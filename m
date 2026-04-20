Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF87CEA71B3
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 01:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D1710E002;
	Mon, 20 Apr 2026 01:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gw9g5Stv";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6D010E002
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 01:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvxt5bp4MxCinpeC9hUzj+5CvmsFwmkvXZPuiwXyQJbEfAyLbXUdT5CyR26+/8iOZNW+JzoF3hjfUPH1Yu4Ww3QVKjTx1fxr+YVU5460Xc5S4ILiNHWCMY73h0cMRjrq5rNokJwhoO3D+wdxgH8t/IfU9vUcptQaz/OzCHOlCBhVyuG84e71+H16iMjp/Gus+FKrbU2RKw6owOjgSwHWL3+BlhhxAs7FpvWWS+A7uei/Pknu0zdV+y3osfcJ3Iwt314ctKuXDh2pGtOqySBOMYWspkWM3/OSkV/rxEzm6vE8q+gYCvUvcfMvprYlzwDhRhXOYL/UsmJ3Gy8x8nfUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9O8sgFlBGa1zR+0DJ5rBIO7QVd669JAm+6Io6NfpOo=;
 b=E/fXITwzUvAfh9AESSb1hfejWm5Sp96+7f4HPkvFGJw7OX+HOYFVVKopi48up5+5cKdp3qtq58E4jZoPbdykT/jR91oyLSgkwWECGVx3nwMA1HElN/oo6Qlfz69ECR6LO3FtSBRXj9XqbcC5gdDL8o85vK4LJAyXDTREYLQEHrdKiKuqTlJHWTaJV6zftF3q0h7XnxZkD12fF1Nv1BEns34yhUfggi5RpgNNPSKQEaFHcg4A3URHOPHhrxV2mvHZXEdq7webd2pA7cFAITal7EGfRwKjvGlYOay1JFnv8lDM/j00X1NcAIxj1RffKP7IT/qD8MSDF2nUmO03P3C5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9O8sgFlBGa1zR+0DJ5rBIO7QVd669JAm+6Io6NfpOo=;
 b=Gw9g5StvXu+5l1BbGi4urLq18VJqeeFlvYs7mb1rJZCGWmKGlUvbe0Xxy5P9WS+hbCX1CEU2eZHkJywJScNI3kb7PLItiDWNwWESa0LEZOCxclE8+78dV+me4v7G4QNcBcDROYeSx5xcGruwFCsZ20KVrgThoe8j4JLh9hCCAf8=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Mon, 20 Apr
 2026 01:32:40 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9846.011; Mon, 20 Apr 2026
 01:32:40 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] drm/amd: Adjust ASPM support quirk to cover more Intel
 hosts
Thread-Topic: [PATCH] drm/amd: Adjust ASPM support quirk to cover more Intel
 hosts
Thread-Index: AQHcz7NsuyBZwDOPNkaXR3+skXyyvLXnK4xQ
Date: Mon, 20 Apr 2026 01:32:39 +0000
Message-ID: <DM6PR12MB29729B33788320CC0B615199822F2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260419041652.17673-1-mario.limonciello@amd.com>
In-Reply-To: <20260419041652.17673-1-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Kenneth.Feng@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-20T01:31:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|IA1PR12MB6410:EE_
x-ms-office365-filtering-correlation-id: 1f0bbece-cf15-4b41-92ee-08de9e7cb609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: j6firk1Dp7aOQxf0NuvVUtcxpVtxgtkYOdN2tQWWXGp6hzusklbL7LefZyvNIx/JX7rzYa1c+u/EccCJG2NZ4E5Ozgx5GYRSLvK/nIohG9SyyUBy4jUBPcbrKiH+a+PxZNyCnZmLVupeSNg4bE1ejMzSFZMLQl38oft4x4X/XrLdNo4Uwo68KqiWCQBuGAGrYZ4dK8kRTagipuhxryN0Hk89OMa9KdCTtReSTRRIPlgQwDCeKve18P+R145QJg6j1G9g8ILigAKv8D8CyVoo9pNjSZegq7tMF/1OdYeazeXvfaGyoOllcYVubN4/zMBgmOuncOSG8nY9Q3rBEWR7802aDQCmh1Z6NPsLm7clkIqU1NpwQsLp+yYgWAVBJLE1v+93Ypc7yE7N8e9xdZwej80O+Xuq5vZ5TvoS3OhPr6Q4iHewkeLtV4JmT7WH0WvzVxrIbnv+LClwhk7+KbZ8D3TShDni2a294XxvL2r1WqI61tV0czf8r9lociy8DN7dKe8kBViZoITWb6E4Vcn2m5gXJQzGOovthl+TxE+/zfXTNGX4u9kDUvgEWEkVGYYIP83ZLM1JWJpkIhKY4VNH86v4veRfvennbjlntaNzOhHrtrbpix+dLnt6LOciR5DX305zHXFge1f0TJLrNMih0gJJf+G2GQ721VfYDYHI/fbZ4F7b0XaXq9QlNm15VdBRYdoMkyaN95ZHfprFKY/jSFtsVXzR8v4r7nIroVGbtarDUk/S3X9tMXIIH9AwUM8T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TVcTav6BZIZzinj7kE92LjgnP4fWv/97F1Q3QsrdfzqFe4CgYsINoTG9Lqpu?=
 =?us-ascii?Q?noWaulep9+9BsFQwigllRYNJvtGVrvhCg1J3eHjilk72I0mS/ctidtsomN4D?=
 =?us-ascii?Q?CXSKfafQdwIOLmz6wWAmC66wQaj8hG47kTqKviQk4QA+i+uxMywH+1Kk4xQ5?=
 =?us-ascii?Q?aJrh+WB7bcuvQgJcNNi/61Lptx5StOLhdVJ5IXK+Mh5poeOn+mCUr1c9m/Bf?=
 =?us-ascii?Q?qzXvqDbs14YetD/GqdsjIQu9qOSqEkySJwSvGdiW/rixOr/CseSKat1uIu6X?=
 =?us-ascii?Q?hQq37KWg7Z7JR168Jg4Okd/qksnZaEZXi/nOqfDTYoHE7P4KGwWeuxSa8WFd?=
 =?us-ascii?Q?A8q++uigl4735Es/NpNZOaIo3Oza+ctxSn+7HBjtyFCe4d5uwjlPFftlyZux?=
 =?us-ascii?Q?q+jXzkmmHM8M6zIQgsyHUNI5RYtz/aZMTmWtM1t8Wdt9JzisUqwBeVqVaOnr?=
 =?us-ascii?Q?apqVFasdw6dXYd5Sm54YZVH5YWOkjsfmpUP80jzgcKtNIpO9frT+3FwSEeSC?=
 =?us-ascii?Q?fESNiMUnvWRIlh0gsrfmSX+3LcROypZmHyjsH2q0eSl6LYk/W4Mh0fTBb1YJ?=
 =?us-ascii?Q?p3yT6CiD+HdSyZ/XF7LfBSyODSHnpgDjMWOlh2iqFn6T84c1kK5gclQnGpJ5?=
 =?us-ascii?Q?6YovNQBWH3+tzQi4vS1XLZ+ht6uhAiyeZnTB8tnsQ1ToagLGJuxWDeuazrNJ?=
 =?us-ascii?Q?ahmhv7BeYSbkyrmu78TR43MUP8KbPtALRrKbucuGElKFZm0dclwU4ZuKmllh?=
 =?us-ascii?Q?m9Xzx0bQ5X0+9L5DPDD6zkJZ7W57JvXsx8eWpGQVBX0KnKNxQPQbbwuuZ2Nt?=
 =?us-ascii?Q?klCawVCkAYGAj1ugydLhiUXm/rHK4ipfs5ytVaJhgsEJ8FsTIM+cQrJLWBLW?=
 =?us-ascii?Q?gcjaXCbiiu6x3pIJusjrZiAP71exO54hNOm285fa+dWBJYJKOwVaVMjk1CMX?=
 =?us-ascii?Q?FhzH6NbdXAWaZUlwKv2Id2NjOMy4q5IGjbbt89CoCnjfWidbcJ0I5vFXx+kE?=
 =?us-ascii?Q?x9jqck3ZVQCXXnp2m2QoXQ/u/rNiQGy8f5e64dDS9lmcgjuSbp4TkGWUAQQs?=
 =?us-ascii?Q?xvr+hvABfkv9m3Jc19GeMW/xlGeCg3tEAaxciCaAtO58gVyt0OlBX9SzWm6g?=
 =?us-ascii?Q?NsW4VQyZEhdl0qNPyNM6Z1b9J4xnSRqa3qUhJz+O4iS0bm1rtCu6NAFsiPpE?=
 =?us-ascii?Q?D8Gq1YtuwTGiLLNCeoNJx5l2BlSsZ/i5TSgUlzyKXnfQokhWX951QooucnJ/?=
 =?us-ascii?Q?cZo4J44ppYppa1ZYiR0o30xS+X1kDkp7EWAKqD0J9gQ7Amz4wohH2xAGlwog?=
 =?us-ascii?Q?NZHjihryt91sSTVI/AW5DINlmjS720MC6wJfRH2XQetxvHz8WlcQzjkYk/9j?=
 =?us-ascii?Q?3E+RyO+6eGINy0ckUYkErWfgV0Bfta8Sswcwup5+VmD3tEavANocd32kIGvT?=
 =?us-ascii?Q?tKoAnsjWjrIjneBx7A3ZqZTdfz2kL1F31IpYRBCqXfRrwR/pAlCIaCU/Cnrs?=
 =?us-ascii?Q?JTSW0ak07usW7Hm2vgn/oEtEr/mJEAqp+WQM83smBSPkf7/0173eVyz6L01d?=
 =?us-ascii?Q?9SatZY8W/3J6x5foxu9ba9o3gidvra8IijrKVVG92XJAOF74XJCr2By5Na+P?=
 =?us-ascii?Q?TQE500d0uh7TkblQf2ZIHtfCoQeoZ3cvuLO86qb4OZ/PDUaWHzOB3ik+HlWU?=
 =?us-ascii?Q?vgXGnZSkpyiplEQ7clu22HiBJM9J9RzI57eC5EKVPSJH7xSi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0bbece-cf15-4b41-92ee-08de9e7cb609
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 01:32:40.0243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mR5wt8lQvPH69/eilhTrZhjs7G3KSKtYks8ae1PTcfzYB5qzNzZalN+eZbnDjhUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Cc @Deucher, Alexander @Feng, Kenneth,

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello
Sent: Sunday, April 19, 2026 12:17
To: amd-gfx@lists.freedesktop.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amd: Adjust ASPM support quirk to cover more Intel hos=
ts

Some of the same issues identified in commit c770ef19673fb
("drm/amd/amdgpu: disable ASPM in some situations") also affect Tiger Lake =
systems with GFX11 connected over USB4. Widen the net to also match these h=
osts.

Fixes: d9b3a066dfcd3 ("drm/amd: Exclude dGPUs in eGPU enclosures from DPM q=
uirks")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5145
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index bc7e96b58d3fc..b11c4b5fa8fcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1334,18 +1334,15 @@ static bool amdgpu_device_aspm_support_quirk(struct=
 amdgpu_device *adev)  #if IS_ENABLED(CONFIG_X86)
        struct cpuinfo_x86 *c =3D &cpu_data(0);

-       if (!(amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12, 0, =
0) ||
-                 amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12,=
 0, 1)))
-               return false;
-
-       if (c->x86 =3D=3D 6 &&
-               adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5)=
 {
+       if (c->x86_vendor =3D=3D X86_VENDOR_INTEL) {
                switch (c->x86_model) {
                case VFM_MODEL(INTEL_ALDERLAKE):
                case VFM_MODEL(INTEL_ALDERLAKE_L):
                case VFM_MODEL(INTEL_RAPTORLAKE):
                case VFM_MODEL(INTEL_RAPTORLAKE_P):
                case VFM_MODEL(INTEL_RAPTORLAKE_S):
+               case VFM_MODEL(INTEL_TIGERLAKE):
+               case VFM_MODEL(INTEL_TIGERLAKE_L):
                        return true;
                default:
                        return false;
--
2.43.0

