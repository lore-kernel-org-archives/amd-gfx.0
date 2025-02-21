Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60545C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E928510EAE6;
	Fri, 21 Feb 2025 16:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dTYLQ0OW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468CE10EAE6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrEsaRMTwneKzIIkyVjjkyTlA1xaH08JcGN/b9jHPrEGk2P6QoYWGkGMUUlAtxMaBj9HXL0hxZp04GVBlV7x9tk6wT+ngjjeHFKi3EnM4vATSNJ1dlkK5cFYQrou1TD+3S7j8Bqd03Zk/as0qM8HfY4xJGWMDNmF9XPiKWvSF9OOtY/1hQctj4oEleNZAur6ELDDma3B4JaZ6lQt5eJqaixHuEIO4htWL/kYqL2iRpTfq5iCfKl7BKoYHEB1XFdZG1ndHxWL88af/UQB66FTGyKumhj8DKkLvY3qScPif+336EiW1mJ24Y3hwFwB1EgYML9aWyiIuhnCruhkPr3avA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdvenKOWPFqT+gDWyUK5q657jiif4pS9RlluXH5LEFU=;
 b=lUAPd2H8EXJCc6i546Gdp64M/W+H4Sy+Vgc/UPU5A2WhXvKgw2CIsSiQCZVX/VL3lSSaLLzGfZbaUbCesdd/0iVP9A8BxczjAodUy2aRftn5Zy1arIJAdhjJQdgcAvnUHJf6qTgypESk39TGCFZZQkqm4PbJiKwNdW7jAFW32KYszBsVksBXNPatUeuhLY3aJmd8r3hr1QKpotO13ada1vUBg/yG+ngBgE2Sxp2qol4eZUpOWmbqlI7JRNG8LRm75e3Uf8Pu9xCnhwH+BB+2Nl+tr8ZPpNZLeQ8g4uoXwZPEVbTV0J5Bu/ry4+pvAtN0jwuK5b36z5npjPZs6UMYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdvenKOWPFqT+gDWyUK5q657jiif4pS9RlluXH5LEFU=;
 b=dTYLQ0OW9vkpt0/pvNzDDXfWox/L3DH/KSyxWww06ZWyE02c444TVGrYTO0XeDxCYP8C2jJhdDpUsnh04Xs+umom3Wg0Kyu5jkjLeGrqzOlX50g8OVkny6NI0eQ0aXvV6j/rq3kTUbTkK0VzCbSr5WPzkeRCAr7HpYQsWVNsWlI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 16:25:04 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 16:25:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu/job: move fix is_guilty logic change
Thread-Topic: [PATCH] drm/amdgpu/job: move fix is_guilty logic change
Thread-Index: AQHbhHXwbG/nrRGCckWtkwign9/vh7NR8VDp
Date: Fri, 21 Feb 2025 16:25:04 +0000
Message-ID: <BL1PR12MB5144DA3C9C119C71F13D8F91F7C72@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250221153247.3499295-1-alexander.deucher@amd.com>
In-Reply-To: <20250221153247.3499295-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-21T16:25:03.805Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB8118:EE_
x-ms-office365-filtering-correlation-id: 0a7b776b-1685-49b1-d038-08dd52944c10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?v7sThoOXTboTBjsf1bGMD+dV4iMsMBuwr52fh+T5NTT0NYht4DWV+Ivzakf1?=
 =?us-ascii?Q?26i6RFHDF5F2wxnqt3oeenr+mVZtvil52X1RcPtlB1LNgiuWFdPqbbHxdpN9?=
 =?us-ascii?Q?BvVu0pTvWWtBHOjvtLLv0q14nykAVS4vnXyEopfRKVjrpGW+Tdr9vsi1FwNo?=
 =?us-ascii?Q?MNWPxH+m319E2pi7jrNe4xVko/QdeiH38FoEI7d4t/gftL1PTZImyIJaGiSj?=
 =?us-ascii?Q?IcaAEqST76yPCKeuV7ukAfgDKgyrhTLcZbEHAN9O508EY5397JG+18jg2L3+?=
 =?us-ascii?Q?r0vDpxRYGoake/05JjueCxOorD46eMdU8D02ij2pEnZB1ZKqW4XgJnnLugN+?=
 =?us-ascii?Q?uxZGYkSKwpb1HawWki8UBYcAKpuJ4gBE0qNnD+zZh2r0rtVBg+HhVl9Zlccl?=
 =?us-ascii?Q?PuWYnxVX1UhpX8woJh8ZdhPAhtABDzAMN8rLfxU5kyqadykP8DCOR5zyDSVD?=
 =?us-ascii?Q?VY3nI1A1ZhSBKk8Tr3EbxWRhwsoemJfNMobE64sPR+yMVtBCE/H0MCzYvsyu?=
 =?us-ascii?Q?FvwVKD5hy1fQJyu8B9mirXQG3vhHkTvT8fgcovgCcCTLoe0rR6tt8Zb5NWCy?=
 =?us-ascii?Q?Gyoe+LxkyiE7QSoHSOqNsbpT24ho5nd/lP9H9cMs77voXpbx/W+3jYLO04uH?=
 =?us-ascii?Q?KuJyGE1TCQx2gX1uo5GotTeBufCQoOpL8JZDQwSMG5+Kq71sbJjbVZPFbLWG?=
 =?us-ascii?Q?zgXD/g5GJ1TNd6TzMjx0diuhCvNiyxPwca0y//z1uIJUc4Hr1eCQlz5UJICI?=
 =?us-ascii?Q?ABxRIpSAL9nV3JdkP8McNQymMeaeipOVHzX5O8r+YDtoGKcgLNbgGZYjXe2x?=
 =?us-ascii?Q?JFc3hGED4q2DoZ/HGSQNbvOOKtzM3BOyNbYP1ACULwRb3xWJfy46mr3ejhLq?=
 =?us-ascii?Q?TKLBiKoTQkGFolJ+rpAhk63w3ylZMhwoGvbzu5ekJG+bXemBVXZnktq1IEgP?=
 =?us-ascii?Q?OParaW8s0o1fwCxV/Fos3n0zFPKw8LaSV1dLD6lmwmO6tzv/e4HYnKAWeZXk?=
 =?us-ascii?Q?VP/ti30mYq7bbvN3wH68cnQVtut6MUkeOFoOtKsRbbQwBW3t+2m94r5h0RIn?=
 =?us-ascii?Q?fqrpwJq+3rzR/VK/uOt9SVrLCfqMlpaultO1jU4pe9VSNk0CAAyd1Z0dk2Nw?=
 =?us-ascii?Q?TJP7o3IlOEPOteP3n1c1Om42gSWfckFow4oXcAuRd+MCBjALCe3wRzADGwmC?=
 =?us-ascii?Q?ke44Ylbs9S1iQCryTZZcaRz2nzeTPCyxHjxXN/zSKSNQORUBLtT4oOKGFNT9?=
 =?us-ascii?Q?YnuO2f2bMfydeTT5mbW6h+AuuHAlSqlDJ5LuiDaSRqkUMFKYXoZM3hKO/gyX?=
 =?us-ascii?Q?+I5fMO7ehbnVEvgZUomnDtWqLHzMv04r8pWNQxKHRqm3XlZwePSXUa8ZDvuU?=
 =?us-ascii?Q?mli8hBxWtLJ8ukrOzG38WI5CmvzroYPhvOM4YJIueHFp3chd6qr8CVGS2v/c?=
 =?us-ascii?Q?msoaeYdm6pS0WpxspVqjHezADZ6yldvg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NtS7SRn3AJRPRUDCx+fhlEB8R/31qI9aVM1eS8Jbwbz4maJF6B1rNW9O2bO5?=
 =?us-ascii?Q?XXTPqyp0+l+20UnYSy4ZjV+RVVuiMkJiqXJC6iTRRAgrcWMoasXcjFzFGDCQ?=
 =?us-ascii?Q?+Kkiq21P7YH0gFeczwI5ECV9mKgZJJS/HJOH8T+FbqNs3v390hd8X4O5WxP8?=
 =?us-ascii?Q?YHSsS098G7PHQ3knW+Y08J3HuiD8TmMGqYjnvmlVWD8vxbLk1orJEsK1ODUG?=
 =?us-ascii?Q?dFafkcTyVOeLIYpIkXZW9MUaT++QjRj/7HTmc104UQj0kr2HLn6ovX9fGGRz?=
 =?us-ascii?Q?vfph6sDgT3YoTyHz8CYhUN19oOUtxWiI5dNwW8+MFmOYZ6HeZee0pPpSGW6W?=
 =?us-ascii?Q?0UDT7gcJsaUaEC05dZ1ggZ7F0hq3jnCYuHL+Hv0dpJc1xySdEjrXbmlWQaK6?=
 =?us-ascii?Q?gPBF7pG9F2IaUHpDxTIz9TLR2iZKsH7REd0BuPCUzX+yLRQHatJr1iX6yI1G?=
 =?us-ascii?Q?6swRBECwYHJFd7RXU5gSIL/MBchQyNYt48ndLHPMT6amCiC+vZGUbrV1LuAA?=
 =?us-ascii?Q?wEPO4UIMn3XsDz9fBm4Rv8LvKEQJtiBb9DtWSKR0E6aoOoHSaau/fCD3F2k7?=
 =?us-ascii?Q?dVhfhBwKJN6uL7AzoGxnh31XyRJfl8GIoP3WddvAQof9nGr5qTxAEIyCwmMY?=
 =?us-ascii?Q?SMRjVULD27K1KJKasH8S7LQmn/om7ewzVkdJjRW33g+tZf41lu7YjPoEod8T?=
 =?us-ascii?Q?lMXotaopM73JUMiQuftJrUIte7swLdNaxmNpkP1YOfJF1Tnt0hmg9czIj94w?=
 =?us-ascii?Q?tToJv7RyZjCTG9qlkfzUH9MTbQzTxLYpaV2HzdyUYsuKB7aZAcfiSAHXsZUS?=
 =?us-ascii?Q?9GOYRWvLREuJT+jM294fHAuPsDpnqjFtW6G5eb2wFiZCh6dhMKi56TsgiujT?=
 =?us-ascii?Q?fGi6EFg1FG7Ud0V/11Hoy5IXEoTCIGYKQUHLfDwvMn49P/amoRp2La2u/Umb?=
 =?us-ascii?Q?v5USxJVUzb1xROnGZx5xcwVdWyn0Ps6GkKy7/07XdX4mL8xGz/UBudEr1vIb?=
 =?us-ascii?Q?lKYdc3gnCl9hdp5L90lSljkxRAZ8brjov09KoDIdpdq24lHTFMV8JJ6+Z6HV?=
 =?us-ascii?Q?NZoXySssCdkq/PraNmixj+EAUuQ5yr0GOXSE++/2pIHYtCvTbM+O7YDEkty1?=
 =?us-ascii?Q?MYw18zWbcPIJJ8A/mImEoBBeWFoAcpMDmuSa+d5HpIhWFZ7YxeEsn1OTzoN4?=
 =?us-ascii?Q?2ZWJqecI5ErRyxFCT2YXwT9HI4KXNoQraSxwNWzbdUSZNQebyWWvdoKDCp0N?=
 =?us-ascii?Q?4JFazyG8pTBSVW2q65s94kanQStzKiZHth/F4i+JAbFS/IMY7cX2uX2VF9pu?=
 =?us-ascii?Q?3hBDutBrXwfLK1EcaDacuIudWpK6ZIpY8DbgcRc+QkT5Fzw6BANETfSRqcbG?=
 =?us-ascii?Q?HtSioOPkStqL2zbvFJel9W7OIvHTNtlqGTECaJ7gQkuYTrKkk3BfqRLK2Hg3?=
 =?us-ascii?Q?sOYTWDcwsUYqS4Df0XnB+dgQU8qYKbG7gZnUTeS8miBf5d0kxVjMrydwTdaR?=
 =?us-ascii?Q?oQO2XzvFwNzuhkvSY0tZyO3gZ0UWWnsmdTG6rgL8Pdmy9r4klp6XfLns25O2?=
 =?us-ascii?Q?NIr1XIEje85C341c+qY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DA3C9C119C71F13D8F91F7C72BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7b776b-1685-49b1-d038-08dd52944c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 16:25:04.1067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QGkcM/anT1nVRPFa9oXP3GwO4vcbECOJnr/75BXIixOMjznJh0Id6+bl5DWIw18JCiBrbgmXMYsp/+IAAp/mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
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

--_000_BL1PR12MB5144DA3C9C119C71F13D8F91F7C72BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Ignore this.  Newer version sent.

Alex

________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 21, 2025 10:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/job: move fix is_guilty logic change

Incrementing the gpu_reset counter needs to be
in the is_guilty block.

Fixes: f447ba2bbd48 ("drm/amdgpu: Update amdgpu_job_timedout to check if th=
e ring is guilty")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index efba509e2b5d1..a82119b551dc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -155,8 +155,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(stru=
ct drm_sched_job *s_job)
                 if (!r) {
                         if (amdgpu_ring_sched_ready(ring))
                                 drm_sched_stop(&ring->sched, s_job);
-                       atomic_inc(&ring->adev->gpu_reset_counter);
                         if (is_guilty) {
+                               atomic_inc(&ring->adev->gpu_reset_counter);
                                 amdgpu_fence_driver_force_completion(ring)=
;
                                 dma_fence_set_error(&s_job->s_fence->finis=
hed, -ETIME);
                         }
--
2.48.1


--_000_BL1PR12MB5144DA3C9C119C71F13D8F91F7C72BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ignore this.&nbsp; Newer version sent.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Friday, February 21, 2025 10:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Jes=
se(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/job: move fix is_guilty logic change</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Incrementing the gpu_reset counter needs to be<br>
in the is_guilty block.<br>
<br>
Fixes: f447ba2bbd48 (&quot;drm/amdgpu: Update amdgpu_job_timedout to check =
if the ring is guilty&quot;)<br>
Cc: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c<br>
index efba509e2b5d1..a82119b551dc3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
@@ -155,8 +155,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(stru=
ct drm_sched_job *s_job)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
mdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_stop(&amp;ring-&gt;sch=
ed, s_job);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;=
ring-&gt;adev-&gt;gpu_reset_counter);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i=
s_guilty) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;ring-&gt;adev-&gt;gpu_reset=
_counter);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_driver_force_comple=
tion(ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_set_error(&amp;s_job-&=
gt;s_fence-&gt;finished, -ETIME);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.48.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DA3C9C119C71F13D8F91F7C72BL1PR12MB5144namp_--
