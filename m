Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E93C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AAF10E5F7;
	Tue, 14 May 2024 08:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HmRECivT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA96910E5F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atnTiX/S1JbxiuKGD5B0COUJo0p8zMjFdi/KbcR3qIpyW3l3rwoIR0x+9d/taO7c4sSSJvfRfq2iUehwLjArRU/ksgV61KhLZXKphoLPWv+klS9rl16JLctoqBxoocNdocI4lVqOlfuhSzF7SDtJHaIife8lFE6zL/Fe9P4gCuv3VufQfQy+aQCxpAcZ7E3Fe3/crDhhE4OvaS7LAywopKbjy5l2Q3rOd0tofspLIrp9O7b05xuU0ZgSanFCKXLc1yjBFp/HWu2mMYsdWkJS40+qgrij21i7SFCpAEDFN1LRWl2KkpSZhpmc6yqds5pePxSwZCJqMH7DJvrpAhd5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ys/9ZkoowwOfsL7g002eoqflsG4wypD8qw50Ym6xQ4=;
 b=P/CurFOsMLEhoskRyXX/JnCuuFKLer9/orezlW/E17VmUMiYJbPjV9kAVPmsJ8LO3rmRROx8re54T1dh/Ml7lStZaQx9Z0Grv5dFth9nRFHuaMwt2ElWjbMJMHOimHXnrEQ+XmULK1/LoHS1ahahaTPgBEzEottp7IbLtrRcg/ZEP/SD5mSbwo7bFi9wIp8z9Fnzfx3vFXYR0VCAItyX39h3CCBD3RL4LkW51/rrSMhUSFdceZOwE1yIPd8x7Uw8ojhWCDeOChtCxrE5nELgVkKmO7LrKKrSm/efx4OQpof9THTFBJ8vj/v51Yg2KZ3QxPCWV2dgwy4TOeS7sX823g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ys/9ZkoowwOfsL7g002eoqflsG4wypD8qw50Ym6xQ4=;
 b=HmRECivTESqNCdF5TxNGGZS/5mOw3GjjCkhIqOwBSmnysg3JCOcfP2ws4Q2IGxFJFLwpgCNMAcYXapP0a7S+LPUk4pab+mX8MpuCoUO3Blejv5D9gglFz2IQRI8wzLInoRV2rBJz/c3EZJDwjEg3GBIUNRZl8XtsarHuju8CDvI=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:51:30 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:51:30 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: enable some cg feature for gc 12.0.0
Thread-Topic: [PATCH 4/8] drm/amdgpu: enable some cg feature for gc 12.0.0
Thread-Index: AQHapduAngjJk9pqv0mVoiSaD08V5rGWbAZQ
Date: Tue, 14 May 2024 08:51:30 +0000
Message-ID: <DM4PR12MB518164A7229466A748EF9D24EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
 <20240514084751.3438103-4-likun.gao@amd.com>
In-Reply-To: <20240514084751.3438103-4-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4c944d27-d3f7-4a75-89d6-6a989dd0ccc9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:51:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: e8cb6b1b-28e4-455f-eefe-08dc73f30c56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?W+Mr4gCJVmyJdHr6frvgnJzkhgPrg1bL0c0m7EGG8/VZJTbx3OvtkogLBSKM?=
 =?us-ascii?Q?7Q96KktSwHepCRxNpt98++tmfCTclPKXzAmNWQZH2eXE72a1I5fegW0Os0tV?=
 =?us-ascii?Q?l9+EG1tP9VgnIIyspJZDfLlKijFhS3qP8Qoh1XcmlUlM6XlIHKz87sYPL8if?=
 =?us-ascii?Q?g0Zb+t71jA3nTR3XpRcf5op/knRTOh0x0+FCT+JjuFfhW3uDAVKZkSwJV+dB?=
 =?us-ascii?Q?f4Zr4jDB/MHhRXvZpBYwT6HOkYTW2OTJGp8JLJFdgFUF8JNiT0zXXSBuA5Jk?=
 =?us-ascii?Q?DHICNOKg2v+k7nOogk3SxcBtApo2I2M2AymOd4vXNztoW6VYwgskXK4wZ0x7?=
 =?us-ascii?Q?7FA1MchJoIcoYT/5NQDY4VWk6YqvqGb7ucCRMKXiBmocY3++Q9wgXsyBRlnK?=
 =?us-ascii?Q?M5AmS7AegHUARFg0cFKir20G5uJsqp4CMwqSZ6MxxVY8GbRwvuc2g6z2rTRN?=
 =?us-ascii?Q?OlXZTlgPXPEmaxfFvYWMk+xSQ5alQxDjpfQxWWzpebb9wH3rGB3sBHmW6X+/?=
 =?us-ascii?Q?tbT3mkboh1DxsmvCX4vtVnXJIN8iEZqfK2kTiDYgLNhtRLRxr5Dg33toHZmS?=
 =?us-ascii?Q?HFvYY7Gy+dLotjlzSxKtR+N0ZQBjubf57lcw9cIqxBVDgybi6lspyBaP12Zk?=
 =?us-ascii?Q?IYS+bK8DyCJm7NIEUgNJpLFoMvsaJH77TVado7NymZKCm3bzeY+2Rlo9KhyF?=
 =?us-ascii?Q?bVUn32klC0iXHrtS8PCsGyfOk3s8lDViRIzcweCLKqFVn6FbwHEzKG+lrRTD?=
 =?us-ascii?Q?66PWWsL8LJGPYrr9mYQRMd7gxNGjkOSCgeUp772+VuCCo2bhkVSV/lIZajUk?=
 =?us-ascii?Q?CwG5FtPjnu7knIMGAELlitFBxPQpbW/yDaQcyba3MWXW6NuWUAXS626vOsoU?=
 =?us-ascii?Q?bQ0/V2Vc3e2na4LOCnkbijXO4mF8rvqNTY1wxEopQVDOAkfn+RllaFqXX+Eo?=
 =?us-ascii?Q?PygolUAjPWTw3ebVwOd6BdFxajOrVw12q3UHoKnytqJLShk6t2AlTmyHWzAJ?=
 =?us-ascii?Q?xXwBva6JKr5+NwFQaoahe+GVIq+xffBFVph7WaQ6lvq2ypWW1gLyVZSSgNho?=
 =?us-ascii?Q?dgvpPTivcpmTh0rRbqvCFEllBOk5POEQLx68Z4Almv2h/EcUhIvr7L9cWbky?=
 =?us-ascii?Q?/BXzhmgx9tM222hUP+lF+SwN/qWSzHlrUPe77NOPwwLTdPuX3B6PGuWGykRi?=
 =?us-ascii?Q?CdCmvF82sdx2rlYXP2s/VN9XZcu3D6rf3q9QpMIOl4cXZgVOaxjOd5aUQG8t?=
 =?us-ascii?Q?b1yBhtu4WOsrFM999gOSTw45fL8Lx3jTpdLEHHWttS8SKWkFXSvO5bsnwGrn?=
 =?us-ascii?Q?WJCGk9uCueqswMFF2MimHFy1jf5iIGN4tP+ZJEeK2n/PaA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3imeKY1oPWT5wQ/gQlq+rCyYakAXZV5F+7IT5WyxQf+5tBpDoLZXZFXY4kJo?=
 =?us-ascii?Q?JC0165J82lonVRDFNVxq7nmnZ3jEYNSuCQyS5iekEFNfKvRQFzycdQWUROz+?=
 =?us-ascii?Q?1+bV50BTytKOEMK63XWix2ABDrBbqumfV+/r8Xq8KMyAOervT0qs4CkS8D/Y?=
 =?us-ascii?Q?7ANgkE/Vb431WiXokvRUIlXb/qb+Ea8KaTg3FhXljTJVydinsyT1qtKRmPdr?=
 =?us-ascii?Q?v5G9BGyMIgBsWKFvFLq3OiqITPdHdUeeTDC9xKMnyQ6ErNkYSS4i+oEn4yJt?=
 =?us-ascii?Q?elILKIJG1FPTdVSmqN8RvJvjiYs+SfQlBwNSO+5XJs9MLGYRVksJmofacamU?=
 =?us-ascii?Q?fry0Y2aSSyr0m9WedXeC6X6bHZYhg9wTFEa1NK9OpLKp/pCXXPoK+P6RVlmt?=
 =?us-ascii?Q?dCyMJZ3HKb0s42qkaljJojdGTis5HxLhd/ldyV1lgYx7q2Dgk2CdbKnvEyd6?=
 =?us-ascii?Q?PsHdQykZvgywsS8DSb+XnubljOFvxsC4GGWUk4ts+LE/zdjN8DOL0atXfylC?=
 =?us-ascii?Q?owB/BvKvTQscpeayOHstopCK+Il/HOCIJH0/zZ5bBdckINFWoAJegRwp0O2l?=
 =?us-ascii?Q?VJpLxdc+snG7QmbNI0O1P8SXVFkVN9Gxc/IjD5iNnIpOlf2KRtbwQ2S7pfH4?=
 =?us-ascii?Q?MMQXyOlQBcD1bBwhktuhzPIzTt8ueGlkTGldsoULtdNfb+IogMBEOQLkYZ0Q?=
 =?us-ascii?Q?Ik0NWjJGZQ/vU5FisqKS2QY44UgEbOSPu4PckBX/WdbWR8zGPgPqUsqBGX6U?=
 =?us-ascii?Q?WnVPzXPSiLI49uzG7M2qpryDXnpYh0iDnfCgg3Vl+GlIWpwqIctWEshBleMj?=
 =?us-ascii?Q?UqIwcCtHO/r8bL3Py9khmzPvUPwD9KbZClMHKOX4RuaAwZHelQgLS1GuCITe?=
 =?us-ascii?Q?lw8Sp3RX9rDgLz6JXKUQVu7Sc7HxBJgNXx3MWMSNkH1yAjw44d0lDh9ycg1v?=
 =?us-ascii?Q?MVjww5jpq71zgVsDiux+QesQidROQfn0lwbt6LXJKJDuihIhEnAd6NuzdlBt?=
 =?us-ascii?Q?BBAsIIr/XUZpAKEcPBaDJ5okGPAKJpttPcHxEfPkY8ikQgsbC5XI2N4SRQVR?=
 =?us-ascii?Q?RguaqmUnRSBk7DhuHHP6bOs/dWXHPM5sN+onWZDCgEw1XEY07m/KyJyBvW/U?=
 =?us-ascii?Q?+mOaVAYIyX4y3yWKtlw0DEPtAfChbhso/Sk8I33aB8clAOKRl4tZChrS4rEn?=
 =?us-ascii?Q?7EJTEGfjtJj/aVwUj/cDmcg21LK5vqbYeBsGWaSF8ywC2oz1sGrCdw9tHgyX?=
 =?us-ascii?Q?YtdkT4OYatyDHmb1MiZV6DFKMRY4qQTT9gxPLYue6c/jEBmsCD8eNEGyLPfn?=
 =?us-ascii?Q?T6IhjZagB1We+rjJb5XTSaNUorbBjeWN0ewKvK/yvVp66oyvG/E76+GoQHWs?=
 =?us-ascii?Q?Ofmh3sUvnG+lt1oBKHkM5kXrcCx9tEFvO7nObGDtKL/f284iVtdIhlStwGAt?=
 =?us-ascii?Q?YHp6xlT91xV+pZM5kwDcYIv2nymXu/PWvrVAwXb/pP7zhnLHGOeRceJpciq/?=
 =?us-ascii?Q?9o4hYvaoEHhB9T0eEMQrtqADDPKpzTzdFlxs4b6YDo0Qfb9DQZ6JTQ7FA+bT?=
 =?us-ascii?Q?5hG85Oy61qcfZy/49bk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cb6b1b-28e4-455f-eefe-08dc73f30c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:51:30.0818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3aHbZ/aF8wqlIdn4xwe5gZI/F9gyk6lurXVLmqOkWBrauhbX8X4Os66I+hdxlDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

From: Likun Gao <Likun.Gao@amd.com>

Enable 3D cgcg, 3D cgls, sram fgcg, perfcounter mgcg, repeater fgcg for gc =
v12.0.0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index 5c796e974252..e91da2d986da 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -398,7 +398,13 @@ static int soc24_common_early_init(void *handle)
        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(12, 0, 0):
                adev->cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |
-                       AMD_CG_SUPPORT_GFX_CGLS;
+                       AMD_CG_SUPPORT_GFX_CGLS |
+                       AMD_CG_SUPPORT_GFX_MGCG |
+                       AMD_CG_SUPPORT_GFX_3D_CGCG |
+                       AMD_CG_SUPPORT_GFX_3D_CGLS |
+                       AMD_CG_SUPPORT_REPEATER_FGCG |
+                       AMD_CG_SUPPORT_GFX_FGCG |
+                       AMD_CG_SUPPORT_GFX_PERF_CLK;
                adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
                        AMD_PG_SUPPORT_JPEG;
                adev->external_rev_id =3D adev->rev_id + 0x40;
--
2.34.1

