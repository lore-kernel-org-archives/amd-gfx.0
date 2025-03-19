Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEB9C282EC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 02:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE2310E00E;
	Wed, 19 Mar 2025 02:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="enAgdb22";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD7C10E00E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 02:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRHex1mND6UlZe1pJEhRvLoNIjnI17FKxzDTBtvb1m4Cgxy4vrLfoMPshR4bZHgC24dAENqDWxWcmNeBcHcFWbVzH/bOjkgnaszKHHU69u2M5IKHQ5VyLBmd64kzfrpXg/5clvWd6wY9BjaDJaVVr3WJ9g+Cmr2QIpljbcuGf6u/vTt+15kHwz1rUZ9m9hTr4fEEOmuUhLpmK1SbARcs0BrytEUaYCZDzvjVlqiWfs8MYpQqBPGDDuKgwnIQuDp5pPZNY5EKWSRHHB78i4CaIMIN0bAl7sShdbNd4vSwHraPPq6dp8zZGeIKCMMLjLKeysqiND9ov8mMogrAMdtk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq0SflBp2NTSeCy7xQhk5NtvpIqh1bpUIZ3/bMRptB0=;
 b=LrDk+VAmZxCvv75teCtWnf4Gj8k4NK3BM0HKmk2DhiFJq5+pNP9PWt1GDSCyAb2z1NbGNKbKyYJnlAyA9kZwQZOopjUhGz6Emw01ZMvOPlMZGaTk5x2zo83Suho74wzLhVpI5l0RpvRQ56Ufntep+RvOMBAzXBrei036l/crlO/wxpuRh9jZDfFjRZo0Qa0hIctYLFq4qobbSr5xlOCR/15AvDnw7T4xGkwcH+sq50XB4ALBmNqLULxTr1dpDQ4+o2RQq/CADVNPWiuCggUitO4iQITCNnXJqaz4iuzJIYLQm7lLNUfZAlhYzG0sbN6Cbtco8HlHw3BRpzR1/6TATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq0SflBp2NTSeCy7xQhk5NtvpIqh1bpUIZ3/bMRptB0=;
 b=enAgdb22IWw76RPNrNMUKekl+FN4/bAshZnyjWQuMj0xtYoJZ1hrqm1uhOiRH3oXSmEdZUTNtmA5/yHJSzCCXUnhwp3HwL+jCTowHYSgYf0j929bkcSfL4WmWyOwSlv0qIbgYsn37JdX0XvnSgs/3+km7JpXnLJSl1K7NZe7TaY=
Received: from CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 02:07:16 +0000
Received: from CY5PR12MB6034.namprd12.prod.outlook.com
 ([fe80::4d3d:786:6806:c34f]) by CY5PR12MB6034.namprd12.prod.outlook.com
 ([fe80::4d3d:786:6806:c34f%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 02:07:16 +0000
From: "Rehman, Ahmad" <Ahmad.Rehman@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0
Thread-Topic: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0
Thread-Index: AQHbmA4V2/fP1GyX0kiptANyFOkVr7N5tlMA
Date: Wed, 19 Mar 2025 02:07:16 +0000
Message-ID: <CY5PR12MB6034FA4D996CF9B1CD2AC2998FD92@CY5PR12MB6034.namprd12.prod.outlook.com>
References: <20250318135955.57341-1-yunru.pan@amd.com>
In-Reply-To: <20250318135955.57341-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5ecbce89-47b0-4383-ae8e-83d90dfd224e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-19T02:04:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6034:EE_|LV3PR12MB9095:EE_
x-ms-office365-filtering-correlation-id: 39e6c482-1b1f-433b-6251-08dd668ac591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Y7ln+7iCW8wiw02ncRUkTSQa/GaLRDpnOasVE+buLlqZ57E75r0OJShQEoSq?=
 =?us-ascii?Q?0hcQLF4MIPZAmNqmZPzYHIELuQA6zUvp7/sQjYNl2C6HSUzmAgS2e3gEA09V?=
 =?us-ascii?Q?9ASrweSpBskbhV/EQANyHbNs+0wwJhSnghedgTAslquZnfx62RxZph1h1XlZ?=
 =?us-ascii?Q?FEk0AVmYnfsgRf8GXvSn62oYHYkKdpo/jE0JJeKSJLTdQHW/6uapA+IEd1+U?=
 =?us-ascii?Q?EdfMo0tqCIzdReUlv5Za7xXw8+vsaOqd55xqoGbLXYyiyEoXn8naTqgAk5Wp?=
 =?us-ascii?Q?kHQHyaQLTH9gbOXesXp1rYGRYgA0pDPZC+0Q2B6iQmOF1wPvW+5PM45ngTds?=
 =?us-ascii?Q?qiHBm+omJYHaj/JRsVFJDpMqwwmhBWQNwEFZwJ6D0mFG4grWy9atH58f48NP?=
 =?us-ascii?Q?nMG6Nbl7Jc5qzfYIbPWm+4GtaOBdleFfSeTQuySqkndRDAHUC3YXQh/34Lti?=
 =?us-ascii?Q?/WNraPuSe/TaeRSvDWYTpn1EFia8R6aC39gEndW2clVAkrcMnD4gboSM5moA?=
 =?us-ascii?Q?JmLTfeTWciTO6YfVpBEnEZX5QACp10LWTeHDcMPQQ/ISODQScS2dsW4JsjLp?=
 =?us-ascii?Q?i1EccXWyF3NxzeswAgBEzib3n5CFzM/rEpGWWsr4paX5XYemfKChJp9bad7W?=
 =?us-ascii?Q?R4YejeucHDqJ9LENKGyrHpG0aiS/CCGi2sCAvQsNM4CTu2+ZFh3h3yoQTzn6?=
 =?us-ascii?Q?W1oZrN1p0qj9hk72fpJ7DR6b/rLPXUl48yHVyyNRErGxLnPDsJwKEVsRchys?=
 =?us-ascii?Q?kF2GA+zIa0+duQ3X7ustHPBhk2eibkUl8pE1kGxX86I6icpw+SQcXY1SU7xl?=
 =?us-ascii?Q?SZwUFCCc/2+a2sCPy1nyB/t1ScQDvSdNk+oYwv3qyzsiGm/T3X8HqGQctEl2?=
 =?us-ascii?Q?AnLGntDOtZPNnIgSVwjkYi6tj2mhm9qz52xQbt8CSEhCTW3pREWg53xAAL39?=
 =?us-ascii?Q?m8mcHRCWMu/EUQl92QKVa9g09LPUXhiLs6pB27jnBJcRo6rhXr2ku7Ec4K+u?=
 =?us-ascii?Q?B3A01M6WSLIhwrLf2/w/Pddf2YbhKEQVMbwqGiR5Ne+spMbSxaSyrckjB0Bt?=
 =?us-ascii?Q?fOvtN5r1POfY2wUPVCrRu5khZYQritiX0xJkSfYP5RGwcIOGiNHR1RGjU5/a?=
 =?us-ascii?Q?Xamvfx/Jhhvc/YpYwFnfRiIoymOnADnLkpfT7iv/1vg1Q3EwagCplt8WNEmr?=
 =?us-ascii?Q?J/VapUWdzm71PODfZi00NqVArl2v6hjHo18Z7cAZwPwDgpcrL0tOaXiDM2V7?=
 =?us-ascii?Q?nSxDq7xaKXIawK/5LnntngQ/lYsrnKgOxGaAC/Uv2pqB1+XuYVP4QWzfRns+?=
 =?us-ascii?Q?E6/Ra7fRd6DopBLC/jPuQmDeFAoJG9p57BNh8X4BUC5fGqw1wwBBrGw0Oqom?=
 =?us-ascii?Q?wQ0gn0rvhRNVENBAu6ryMUn7hB/qlGBMeaqymGBP5RbK/ERD7BgwNjP2NpWN?=
 =?us-ascii?Q?TAhhrnQSSPiZjUROkf9fUP+efKgo9Wzh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6034.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mI9rxClGOtOmfrWsCG7sriIT0WdQcpJE7WnsYKzTjIYcKUj8qnqILZt+kJ46?=
 =?us-ascii?Q?WE15+cybEk3emf3oRnFqvLPtRT/2/I199YeKm5zscX3NKyWbV+qePzmA6w2n?=
 =?us-ascii?Q?+XK+YKC/Yt8pzr6Oh73N3d8yS64liGGUlrY431JQjOeoU1zKPJ7YSPkXius2?=
 =?us-ascii?Q?A3Iw2Kvfs6Yla11F7//Ke81ALt8aep0hMtNFAq501g7Nrlj8PXHsae3ZvSsn?=
 =?us-ascii?Q?E5+Y+CPA285E6d2hECnZrkiJMcxtVunX2PsZjNEeQS9LGINCxWL0126wVEHQ?=
 =?us-ascii?Q?CDsScZkY45zh5fL7GcjcPik1Gkig2gqI4EXRhRTk+HI8t1IVaLidZEHRUoG0?=
 =?us-ascii?Q?QYUza5eqM+LIKarZobIFzUrM1MXkw5koYTQjXv8iE5EbcBzKrFcmkZlmIozi?=
 =?us-ascii?Q?yRmN9Xn90ahlz4qFdFrhalE5FgNTXLHtU7oHNKQCA05oT/nr7peUbeILpbhS?=
 =?us-ascii?Q?Pq7J5FeHhlfuskW5UEteX4yxisvb8Jg5t7ugRc85jweWfctUJGyi/Vf1gcHq?=
 =?us-ascii?Q?kwZSC1ElT74HKRYJFgj+rdsMyK/Fv1Fs30RrE4TDpKOTrNnYvZsR3ThhhNKh?=
 =?us-ascii?Q?fRBWGnUTYJXMjrjvnTjq62Xbov0pTj0CGVzvfV7jiyTK5mhTZ+f3XR8aPhJh?=
 =?us-ascii?Q?9RB7/fumuPTCT07x+it5FTJKWlEE1kw+j5kE3kIVGZ3TU6JRRqtzHatekoAj?=
 =?us-ascii?Q?1PaIP62A6PgnprUvNjKKAnNLhqkBQsY0yveqvboLasPOJkLqk4CjxGU/59uP?=
 =?us-ascii?Q?l5CFozdzaF2sU0W5+yJsurlX8jao8O3HjA9jCygjZKwp+D8RuCeie3YfZVIB?=
 =?us-ascii?Q?aKiiNZ2AzAA1vuHIwW+yk82aBxdrIXbX8wUIybpx2ejBiAc3/mqtVXc8/u7+?=
 =?us-ascii?Q?CEdUIAm4xW6DCTIMfZ9/6T9CKkjuFkfDUX6za7Nhdvq3zvrHi1+w2TGflj4t?=
 =?us-ascii?Q?ce+WCbxnNQYB6yyjNI92hV0/RX6+1OrexfrOC6MsCLMoHH4PnWO/2VEu+63m?=
 =?us-ascii?Q?xOT8FgCwoF4FvfdXpGN47/qPyLgYcrX6r4qJKKPd/p+QkH3FghyPZFlFcPTY?=
 =?us-ascii?Q?n6VLxIxkBWTjdaHORHueWoAfCepQmpL0kp3nGPKPtZ9LK5ShXHKW//V/tYp8?=
 =?us-ascii?Q?59vfdvfcn9Zt8gGmkgzA2CnN+QFA7GQvLF+KTIuGB6IOkbE8gQTGESX5AqFo?=
 =?us-ascii?Q?iAz6sAcuXTxjtGea49Q58jDqpdiq5iRyxf6yFjbCVpBDlqya/7+F6Usi/i4q?=
 =?us-ascii?Q?uv/UAPuYAs+xZfjp13Csvs/pLRguACPPq6yb4QEQWyPitJsOINtX4qi92bKD?=
 =?us-ascii?Q?qIACjKRu+C6irID9l7b5M1xQ7HkbZD0hfnq+/5fMC3Iju1LUENCmnusetqNo?=
 =?us-ascii?Q?zVipoH84rz81LZQPKe5DftjyWLsBmKH8mnQDHwixzHPT1V6pLTHDg3MZJHfz?=
 =?us-ascii?Q?Y55TGTrgnpQoKzgte25A6RECIrL9UEkxlBEBP1v70s8uUIyA30PtO27ZMY35?=
 =?us-ascii?Q?i2CIuWrvc9DFplLYkSSE2uqOhahwXMzR6VbSKWJfgFUE10OQOtFUVCYPrK0t?=
 =?us-ascii?Q?hQTx105mUmC4wUKlaSA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6034.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6c482-1b1f-433b-6251-08dd668ac591
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 02:07:16.2097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91szF/SsTQbDAudAKoFRrBtWiBgYKYMTzMmIelxf+YTAJ7S8lxSUrNFkfpLcWelnPReWaUSTqrRRXqFyaCrihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
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

Looks good.

Reviewed-by: Ahmad Rehman <Ahmad.Rehman@amd.com>

Thanks,
Ahmad

-----Original Message-----
From: Pan, Ellen <Yunru.Pan@amd.com>
Sent: Tuesday, March 18, 2025 10:00 AM
To: amd-gfx@lists.freedesktop.org
Cc: Gande, Shravan kumar <Shravankumar.Gande@amd.com>; Skvortsov, Victor <V=
ictor.Skvortsov@amd.com>; Rehman, Ahmad <Ahmad.Rehman@amd.com>; Pan, Ellen =
<Yunru.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0

This enables ras to be resumed after gpu recovery on mi350 sriov.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3e39b01e054c..82001d5ade4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5334,6 +5334,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
        if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2) =
||
            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0) =
||
            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, 3)=
)
                amdgpu_ras_resume(adev);

--
2.34.1

