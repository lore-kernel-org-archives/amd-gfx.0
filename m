Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EC2C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 14:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CDD10E903;
	Mon, 25 Mar 2024 14:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NltNq9yx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3601310E90C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 14:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixiqXdevp7wfPllQLt22sBM4dLIwITD9ZY+AcD/GD/qA2CSkVTY0wXL+fj21zjgN3kvqZXqgndHaF8nH9t4PDrlevoupubAKCPz51wFo7m1HpZC0anW8zFCgqxTHsbPonvvX1j7HTNBBAV8PT8SxHppcPKFzSZeLIZhJO1YY6BE+TEFWUnKdqUuoXtClhHVsRZDS434BLp3caGeqrJ3qfFH3ATuSyLFdXi8I4OrtIFGiLSfUa6eByuHW+RW9qSbm34v0xKXNF8DlhgyOxAuiYB4HS03x3aMpAobk6n846RHlBGgHoh0YlT55CupEsppNNxafGQrwHkqPJ0b1PybCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr0QS6ck35aURYpwxkx30xrt8Z6mER9tLEAUU+jo5WI=;
 b=DtPm/XdwsiGu1Q5gHkS4L4T5vXWuvFPgtuiSqO2F2ken1gf3lDy+KMRBDL3++mhBbHxpKLPYQWm4Kp5PGmbA9OfGDr578sFJTw0YsZYc3o/Lx9tggvEHut2LYCE+DlSgc8KYgxvX/EJoJal+/ovmCU2+KYcGull7Ew2dk9JCRtuyUQ/0GLdu3PlPYvo+aWHsMQh80Qqjdk1zVgQxxjQoUiTVJISBmtohfUzzWBmBHukVTrLwMmM2dxYd7SvCbWKAR8d4zwITViNMEGLmNKDdpWk9VO4se7JrcCHcRfwBwk6Th46uzAaT0WZtNURTpvY2kC2LBo5VJ28Yi+4Vqni/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr0QS6ck35aURYpwxkx30xrt8Z6mER9tLEAUU+jo5WI=;
 b=NltNq9yx4qtNJ61vMEhpF28C7s8ztSEHLNsGNU0Mjui8qAbaKRb2QKhdu73DUCYGHC0tidvBSD3DLrwNLNLCKIPwZpk1WkuLZ+wSFihIisaKpe0iBbeEinsJPb2UTwgUyaOz4yTv0FszSujKcUyxJ5QHYq7egc3mptaWoyttVyg=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:14:57 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:14:57 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Thread-Topic: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Thread-Index: AQHafHkHArsKmxo62km3svhC3nwNp7FIbz6AgAAVEyc=
Date: Mon, 25 Mar 2024 14:14:57 +0000
Message-ID: <MW4PR12MB5667DFD02A6A37B32483069DF2362@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20240322164956.167498-1-shaoyun.liu@amd.com>
 <CH0PR12MB53721DC88B89DB6EC87A2A29F4362@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53721DC88B89DB6EC87A2A29F4362@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-25T14:14:57.329Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|SJ1PR12MB6027:EE_
x-ms-office365-filtering-correlation-id: 7bbcd589-bf2c-4ee0-e92d-08dc4cd5f37d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKLQD4RXNTbd0f9gxKQERAy+vab9ErvOwoR9k/aul/AhW7Sm/IwqaTds8rKHs3kzik2g9Jy0uAoqvgH7rfNQBLNOHo8wg0OQtczMh0fxK3XFKeswiI//ZBiTYilO9cIcv74ummGuyQwralBNjS4Kn6fQH20LAvstzuxepeqOqCtouIqDNLHK2FhGd9fDW/B1Z+TEOobFfN6B01qw/70csTksaJAfoavQ9Sm0rXKnRZxj1ODEA4BrePhZ3mqKHq9uQifGu76BadEkrDj4zJl6w+fXuXyv9w0vGkQHNtuFNVvufkRR6ynrYoenKqLUIJjsKvBOdnef/zuruA7mkPnBgIUmJBja7/0P/+pyqxtN+VbVbDZBltt8BBYQ3fNhzyxr3uLszU7dXJsMF7C9GSrlDxK/OpoekPKad/KHkdnHt76iXFdWX6oDGXloP7/UKciT1Rwb82rMrdXULaXaUpyRQ7O33/FzNFk7MH2v6eZ5/O/XlrGuBo/OT/DRg93yCERRO+INZcKAVdVaDsZGHFWzJAL9Fa0GpbrSe/6GB3fFfX7OagQzpr64+/rg10MzmK40r7AdwMtG+WCkQVzIWai+3cKF76hSrya8FOUjq0YnkAl7MAoOsfRWJfxbxvaC6imn6LRuyMfpI0qVo9cr94WMYNqV29UinS/eCibUX9Lx7H8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bxGRVznyhQI5ENMqF+nPB8uysDgm/ERjOr0P1bOCOH0Yfc/N30zPAZFJP0?=
 =?iso-8859-1?Q?ETLcTmINio3loaRS8/7fEqqWn2eRVAHUZ1LjPVWeHcSGxI9qjIb7f7lKdB?=
 =?iso-8859-1?Q?MXzuMSItrL7GZcpydruyJZmTl/6LPnkQdQlaRImdAqodpB4Wpq3u4vpOEk?=
 =?iso-8859-1?Q?48rXSTCSJlIggBPCg9ui2WJqeFHMWs7bDNOl2GqNy2AztYLN7ubFcYQWpv?=
 =?iso-8859-1?Q?o9Ovhx/yv7qC+jvjqIW2UtPYwVWPTdu9Ex0n4ePOcAKOmHPGomHtPdArBB?=
 =?iso-8859-1?Q?qymwlfcBvveiTLpJ8t0PPRc8trxm3JtPjOSzZywkhx5Kfs6G8f95l8TbDM?=
 =?iso-8859-1?Q?s1vENEbLh8ztrRchhri/uhCxynYYl8i3DKJwLUpOj1VFIFdzBO6/YOif6Z?=
 =?iso-8859-1?Q?+A9GmEm+utIDFvoG+2NohT2rzWAitpBfY1eI4SxYQoOY5y6IEr4oqvpb6D?=
 =?iso-8859-1?Q?UW+sHAs9V/t+XhsOtsjRuGN8woHY6uCs2rqWENST4l1jKN2b7259w4NHm0?=
 =?iso-8859-1?Q?xseLxpmrvEfnrO461AKDlm6bPvL0aknqMBKMit528zh82oOSSBeagVvDpe?=
 =?iso-8859-1?Q?gD4B0kFyPk/8qFTO0qeUo4npjL//1EK3QpEF/+Xr40mjptBule8All22Jt?=
 =?iso-8859-1?Q?o+PHd1ZxbNyn8FQz1/XYqSCPsLydNyNVH88xi7Q9ZEw+4llBPnaq7cHQ4N?=
 =?iso-8859-1?Q?TkwqzHXfaSkj9glM2ehSahvu1aKAAT7jxhlmEbL8zhi0aNuUOcD/IUDSF+?=
 =?iso-8859-1?Q?2wSyRyNCf7O45TdWVg48ffuhjQvvEUmmuXO23y74CPNk+Te5mefwY1twVy?=
 =?iso-8859-1?Q?kRaQocx/3Xxh0DoO0xhDGEs0irAjTJuQ7rmqoeJmluXsg7jkSFxHoKAkAN?=
 =?iso-8859-1?Q?vSKQjb5d2O0FgsQhpXsdzA3+ym8NJqpJ0S8xjht4DVAaKgrsHbvJb942K7?=
 =?iso-8859-1?Q?CwoIKYd1/EUL7koKMIAGARAaSYN9akxXq+Ez0v9yXpnjTv5evgH0onR6dk?=
 =?iso-8859-1?Q?3L9b4syDm9DvRHgPoN/h5pGfj69CJyCdV8moWBjCiq62CPX4pakctuszqW?=
 =?iso-8859-1?Q?bMLHNEaCemndyqwetJdVqYSyJt6F+Idcvzka+qPHPCwk3W1P+q3Ca+PkMn?=
 =?iso-8859-1?Q?3aU6cziNxdgjC/mAL5nmHJlUafpmAwQHgPvR1OBNGDCrgecE5Tm7GWCjq3?=
 =?iso-8859-1?Q?0LEWa7/6jMpxiyu6VPKwNfJQDO3p9lAHCBBwJEN0GmBnGyJXgjIu33Plbc?=
 =?iso-8859-1?Q?H3FOxFdH/Yon9lT5ruEwf0YvpEhyU8NF0EE83m7RMAhBUGOxFkHG470/ig?=
 =?iso-8859-1?Q?T04BwHWjth4ALPyZYQtHg8usJdsNewx7mFFC17KflyVm0r+BGUJQSzQCJ7?=
 =?iso-8859-1?Q?fwt0EWGQz/LrGLSZ9jKIc8jKXKQgu6RkKdo8VMK9G5nvs5RmDYKeQmNh/2?=
 =?iso-8859-1?Q?7+NmF+wryRbO0eXtZRMAuN0cR17aIaqZsd1W1IfZRQlIHXYyfzZnHMHO8d?=
 =?iso-8859-1?Q?hagEei6JGFwAjmCxnD/xT4o3eQ3Qn57Ohx7FiCdPTpFv1Bpw4asE/B21Fa?=
 =?iso-8859-1?Q?YNJ5JeSdm47L0sGlPCQmWuRMAT/NJ0+sNibpO3bU4hnM0G1yx6iYkpECr7?=
 =?iso-8859-1?Q?mhPChZI+XSrIs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB5667DFD02A6A37B32483069DF2362MW4PR12MB5667namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbcd589-bf2c-4ee0-e92d-08dc4cd5f37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 14:14:57.6590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELk8qmX7XFwDYUZxYlmENdYyHfk58+qtVfR4Mrw9oRqznEe8XBbnb3ivz3imaeDzPTo6Q2NbnCVDBRnCYKKtlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
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

--_000_MW4PR12MB5667DFD02A6A37B32483069DF2362MW4PR12MB5667namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liu, Sha=
oyun <Shaoyun.Liu@amd.com>
Sent: Monday, March 25, 2024 1:58 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu : Increase the mes log buffer size as per n=
ew MES FW version


[AMD Official Use Only - General]


[AMD Official Use Only - General]

Ping

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Friday, March 22, 2024 12:49:56 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new M=
ES FW version

From MES version 0x54, the log entry increased and require the log buffer
size to be increased. The 16k is maximum size agreed

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 9ace848e174c..78e4f88f5134 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -103,7 +103,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_devi=
ce *adev)
         if (!amdgpu_mes_log_enable)
                 return 0;

-       r =3D amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_MES_LOG_BUFFER_SIZE, PAG=
E_SIZE,

shouldn't this be under a version check >=3D 0x54 instead of directly chang=
ing it ?

                                     AMDGPU_GEM_DOMAIN_GTT,
                                     &adev->mes.event_log_gpu_obj,
                                     &adev->mes.event_log_gpu_addr,
@@ -1548,12 +1548,11 @@ static int amdgpu_debugfs_mes_event_log_show(struct=
 seq_file *m, void *unused)
         uint32_t *mem =3D (uint32_t *)(adev->mes.event_log_cpu_addr);

         seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
-                    mem, PAGE_SIZE, false);
+                    mem, AMDGPU_MES_LOG_BUFFER_SIZE, false);

         return 0;
 }

-
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);

 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 7d4f93fea937..4c8fc3117ef8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -52,6 +52,7 @@ enum amdgpu_mes_priority_level {

 #define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
 #define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
+#define AMDGPU_MES_LOG_BUFFER_SIZE 0x4000 /* Maximu log buffer size for ME=
S */

Apart from that, it looks good to me.


  *   Shashank

 struct amdgpu_mes_funcs;

--
2.34.1


--_000_MW4PR12MB5667DFD02A6A37B32483069DF2362MW4PR12MB5667namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend" style=3D"color: inherit; background-color: inherit=
;"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg" style=3D"color: inherit; background-c=
olor: inherit;">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rg=
b(0, 0, 0);"><b>From:</b>&nbsp;amd-gfx &lt;amd-gfx-bounces@lists.freedeskto=
p.org&gt; on behalf of Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, March 25, 2024 1:58 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] drm/amdgpu : Increase the mes log buffer s=
ize as per new MES FW version</span>
<div>&nbsp;</div>
</div>
<p style=3D"margin: 5pt; font-family: Arial; font-size: 10pt; color: rgb(0,=
 0, 255);">
[AMD Official Use Only - General]</p>
<br>
<p style=3D"margin: 5pt; font-family: Arial; font-size: 10pt; color: rgb(0,=
 0, 255);">
[AMD Official Use Only - General]</p>
<br>
<div style=3D"direction: ltr;">Ping</div>
<div id=3D"x_ms-outlook-mobile-signature" style=3D"color: inherit; backgrou=
nd-color: inherit;">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef" id=3D"OWA86d86bbb-728c-c3b9-2c99-3877=
795c1560" class=3D"OWAAutoLink" data-auth=3D"NotApplicable" data-loopstyle=
=3D"linkonly">
Outlook for iOS</a></div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"x_divRplyFwdMsg" style=3D"color: inherit; background=
-color: inherit;">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rg=
b(0, 0, 0);"><b>From:</b>&nbsp;Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, March 22, 2024 12:49:56 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdgpu : Increase the mes log buffer size =
as per new MES FW version</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">From MES version 0=
x54, the log entry increased and require the log buffer<br>
size to be increased. The 16k is maximum size agreed<br>
<br>
Signed-off-by: shaoyunl &lt;shaoyun.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +<br>
&nbsp;2 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 9ace848e174c..78e4f88f5134 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -103,7 +103,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_mes_log_enable=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_kernel(adev, P=
AGE_SIZE, PAGE_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_kernel(adev, A=
MDGPU_MES_LOG_BUFFER_SIZE, PAGE_SIZE,</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">shouldn't this be =
under a version check &gt;=3D 0x54 instead of directly changing it ?</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_G=
EM_DOMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ade=
v-&gt;mes.event_log_gpu_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ade=
v-&gt;mes.event_log_gpu_addr,<br>
@@ -1548,12 +1548,11 @@ static int amdgpu_debugfs_mes_event_log_show(struct=
 seq_file *m, void *unused)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *mem =3D (uint32_=
t *)(adev-&gt;mes.event_log_cpu_addr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_hex_dump(m, &quot;&quo=
t;, DUMP_PREFIX_OFFSET, 32, 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem, PAGE_SIZE, false);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem, AMDGPU_MES_LOG_BUFFER_SIZE, f=
alse);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-<br>
&nbsp;DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index 7d4f93fea937..4c8fc3117ef8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -52,6 +52,7 @@ enum amdgpu_mes_priority_level {<br>
&nbsp;<br>
&nbsp;#define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */<br>
&nbsp;#define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */<br>
+#define AMDGPU_MES_LOG_BUFFER_SIZE 0x4000 /* Maximu log buffer size for ME=
S */<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Apart from that, i=
t looks good to me.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<ul data-editing-info=3D"{&quot;orderedStyleType&quot;:1,&quot;unorderedSty=
leType&quot;:2}" style=3D"margin-top: 0px; margin-bottom: 0px;">
<li style=3D"font-size: 11pt; list-style-type: &quot;- &quot;;"><span style=
=3D"font-size: 11pt;">Shashank&nbsp;<br>
</span></li></ul>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
&nbsp;struct amdgpu_mes_funcs;<br>
&nbsp;<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_MW4PR12MB5667DFD02A6A37B32483069DF2362MW4PR12MB5667namp_--
