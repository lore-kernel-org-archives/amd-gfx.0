Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DE7C61DD3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 21:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81EB210F64B;
	Thu,  3 Sep 2026 21:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d5jiLGka";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E3C10F64B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 21:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHqsfX+MLj4fsY3FmLY9K0gxy6/qQ8UI6Nv9OxJd7520Zb4SrsbDOm8R7xkB2A6mikRlF6V5GahOwqGoPTc/MyUXTjgcIX+akLu4SeBJCgQhuO9jV+0la0GsdH16KXEizu6yqvYT0YSz5PSd9w26Yixh6B4JvSRpDo7hirYna8aBtlYdY4vb44cgPWIDyn+mrpBooaU2Sirx0BDqfFlA8C7Kgw6oi/Tp9x2B/1EKFUtAJ73Z4WkWv/NFD+4bohE41FohKegGt7CwwQpSAed6zd5mrpzDy0evqzmZO19BZ52DU1m2Guc7LMypuS4hytsQeYr0r6Dk65WnXcBLQIYZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9Yev+9nJthnEN/b6TMq+Hh0KvRx2ysUkyTxDUvhCEY=;
 b=XZ1rU9b7jq1IEjrsbYr2EokQKcuOfYUY8hBA98BJFRwYo+UgAhlqnPRftsl5ZhsTSMNjHMuUHtT/Xg+vIf5GZ9KFswPapWr48KKXPNtlkdgRFiZnbChTavg86BDzbEaAoQfCOmPF6N5XgsCbizYVrIJzyxkAH+BkYsriOv2fkx+hP0WhPi4EHkA5bnWfvJyFuPvqV0l+Sm8OQaF1Mz93nq/mFqF2Bh20aOItblMxeWX4sHH/l9g/WrhxdVP4jkYLZE8e68l7gRTjKAvqI1LsRKXp15XLz4SFzpXyDptJSRED/rwdk3OVftFrH+pg/DqOChHYZG4ImIa1QKggBspPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Yev+9nJthnEN/b6TMq+Hh0KvRx2ysUkyTxDUvhCEY=;
 b=d5jiLGka7oB0m7oluq0pC2+DDOEbJeKw4SEwTIJ02XBdUP1FDt6mfu5r/EU7dKCQwVqYYeIhfNC1rPx29A9X0ZC0o8qBecQMPQLAubDzFnt+YCOQwcNXsXikaCQPTtNebWDAKgJnV4toARHZFgG0EuaBgDLuAtNo+9fLcSTTCK4=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Thu, 3 Sep
 2026 21:40:33 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 21:40:33 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Reset UALink connection on failed
 TLB-shootdown send
Thread-Topic: [PATCH 2/2] drm/amdgpu: Reset UALink connection on failed
 TLB-shootdown send
Thread-Index: AQHdO+WlaRF/2mXz9EaqAgGI+tVk+ba9Yc2X
Date: Thu, 3 Sep 2026 21:40:33 +0000
Message-ID: <SJ2PR12MB8650BA6CDA773D362D364A548CB62@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260903204841.3485963-1-mukul.joshi@amd.com>
 <20260903204841.3485963-2-mukul.joshi@amd.com>
In-Reply-To: <20260903204841.3485963-2-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-03T21:40:33.151Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|PH8PR12MB7025:EE_
x-ms-office365-filtering-correlation-id: e74afd21-ee94-4cf1-d90b-08df0a03fbcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|4143699003|56012099006|11063799006|8096899003|22082099003|18002099003;
x-microsoft-antispam-message-info: Sf8pA0MsSvQzOpn53ehlY9h+7F1kN/lK5w5R+zJeHqsLX7vFwtOTL6xK9CGOhC2foiER5aG/wk+Ku7gj2sXVI6UKOtpAdeW1JrMyB+/oQ3Sk2SQFr2018d7EFK2ueAHoA7WR4r8Xps7C2tucqWtdOTjgZAAY5gsAfvmTaxS2ScgyX/1BggDBDoQo/ATZL9NhiYT4oiHapK8NGarXoHzVQEqENyS3PyLXIyJ/GOObBKYGoWuH9wYgaZNz1ChihPwqNL8SQiDpDxSs8jRprXWHWfYQSbMdm5rO0s1Mz0S8X5iypA/oUyk1IN5AWjk8p8wmvYfATejjYg2tuSPaqz+oVPBqJE+MXgQ3rS/yMg0PmM8nEL5Sg3VSjZyh3oGDUiAFWFC4Cq18RoQQaB9Wtj9awQZYelPJIcoJmrmdBtndY1Uxruw5Lct7kjKoTOTojIAYxod3svZGK8jj9AoJuPMneM0PdS1Y7zsTMcRcmAq6cb6VsDAlbrnjP6hvbQIWrnCoUZax6Zxv90CCRMvutNq1rHD1r+OhaS6kZq5+T8RnFhzUg0seiEJlHgw4Q8iML/3/AHK/r/Ok9g31PTfwwIl9o+v4KNzfUVTUfwtNnqXrBq+WRTVYTbqLncwGFsmHi3atKZF5n4NKY8DkWsPfD2sPFtAcFPH3fRqKaAXJpRveR6R5WEP5v9zT2yCQ6ZNo+C6IYJbGfnMniDNuFqlcESqy1Og3/FMvoNfsECvke9g9UqU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TLswEU1rLZW4hFPvHuxvYX9kyE8s0J9hjkqTvCfrICJqgd9wT3k5gk2sVt59?=
 =?us-ascii?Q?a9+/yGtEXQlgU7n2mcDFZ9Pkg0PC+7VabHs+2NUXg+bTu8Trw7WerFEGzRxu?=
 =?us-ascii?Q?1cnRVFshFxed4sNcHNapjb5RJCJmwcXZrOjS+RUACnFfj05r2OqN+8MrkdpS?=
 =?us-ascii?Q?oYnMc20QuYnDPDv5esISDfBo3NzHbReJ8pbweacCdgRW0w+JnRxjF6pmT8IX?=
 =?us-ascii?Q?TTFRwaMD3GoZ4QR1IQdTkRsjnlX72ypTI7cZk7adp+9PFn8o+rsL5W3LAD94?=
 =?us-ascii?Q?yHf2Zc/fQGuHvTxpagC1xRKN4zo7/KbDI2BS8C+JiRJ5Ky5WfBETeW77IaYV?=
 =?us-ascii?Q?LoVS8Uh5uUyjfzqXfbb/VCinfXKrlwZD9O2tRDaBhmxgiIeydcoV3xKC9xHR?=
 =?us-ascii?Q?0OpOd7zZe00z6xuOf+AWLmTUHx2e3l1dSMb1ffsDedwpeNR1SAYEsXKIjd/K?=
 =?us-ascii?Q?ZomaL2dAST8LcxQsSYk9etVulT+wFJEwGbWmf19jxR/kM4o9an+i9kRH/oud?=
 =?us-ascii?Q?10jlILScY1rpoCAJCJlb5tA8SFY2wAqUwVVlNVtFFU09MvK/RFe8FKN8Am0G?=
 =?us-ascii?Q?Lu2o39DgfGDviSs7n6PS+s+i4lw2p6MIG5W/1vb/Us1wflogrIAWEyz6gaKt?=
 =?us-ascii?Q?iJ598anr4AQ0zdfqAIBjjOqbYaloySdmnymv/Zv3W/1WH+kNULbTceRMRQiS?=
 =?us-ascii?Q?jp7VtGkHaeV45PbMroLhvgCo5WNGL2RBmOrGQZ9xImUsybGJUmWQRVs66s6i?=
 =?us-ascii?Q?3Fb8xq7cDeH65c/Y4HmI+DaAT7QI+ZeiLlrzVi/+uyYLI8Mg/YNkZxCj/SAu?=
 =?us-ascii?Q?lbAUN6CVzzEzwYEwqH9xd6OHN0XhmFWLFrk1vI9lXehdk/3cVkvPfXzD3Y8A?=
 =?us-ascii?Q?7tjH5Y45/C4qq7SnYs/cgFWOZJ5/MuceYeOnNq8biBtFp5a+2Ggow7WRq29h?=
 =?us-ascii?Q?CioNDNNUVquzr1Q9uZ4A+IOSjN5xF8YhJHjXSzarSw4Rz3HjGNqKXH2lFm1l?=
 =?us-ascii?Q?X2OWHsqqPP0Csp6+efWwIExJ3vJR487WlbWJN6YFJFRn5B4hDtxUcZEDQGr7?=
 =?us-ascii?Q?9/iY+d3QYisfo6AAmbih0/9NlbuN2D/3un2kpqzIoJpPVq4HQBHlLPjvjoTp?=
 =?us-ascii?Q?SODlI0BVa095EzgRtlWuS8N0JXZF6vCgV6yq3YLdCXG2KpSiQfM4LRxtwJ1x?=
 =?us-ascii?Q?fcTrs8UMi1kxq94ccfaWXqG7A2gd8dlxVfysr8zIWQHPjg9fACskIF8gmYub?=
 =?us-ascii?Q?aRrmrrrq3LCK6Tdt326xqWj+7f/keRzHC04qKjIREVNJqbqHPXvsqCJ4oA+1?=
 =?us-ascii?Q?XioQz9f43K5ITXgKQHpc69oml6VYDPLYZVrEuTsWB7+NwpEXCqNAm6yMYtib?=
 =?us-ascii?Q?dVVG2JEgLe7HHWJ2pyj5wV+wDz9I+XWZAuOMqeg+QRXY0Qye7drhZcvDxCHQ?=
 =?us-ascii?Q?cds8jy1E1XQbncO9BYaKqjXDrfhV0LsWoHo3rbaOWgwCB7WFgJcNRixISme5?=
 =?us-ascii?Q?9BEPmyuS6+WxL/0ukaNN+YjwIaIG/UhxEBzRD9z+QMUTcJECtNDuwTh6FvNX?=
 =?us-ascii?Q?0QezE8vHn2JowWIIn7lkfolHyYEbVSKJtiA4Dw8riX2bH905aJj8U0dxVexx?=
 =?us-ascii?Q?FPSZNJazz2SJfFH0sNJmyX9ZbSd3WiXMG5NiMSak7gJr5M1ivs7E/AcTCXJz?=
 =?us-ascii?Q?NJw894pn/kjplmSaL8CssRC0rA47cmprNCNwYjC/CI+I6R4i?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB8650BA6CDA773D362D364A548CB62SJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74afd21-ee94-4cf1-d90b-08df0a03fbcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 21:40:33.5320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfYcHpi+LJMM5yUtela6NWqBGvEnYeKB43Qzq7oWXtA3xEH1iVEBw6k+h+SBPO90YdZUy6uhTWPUfVcxNB8Mfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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

--_000_SJ2PR12MB8650BA6CDA773D362D364A548CB62SJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

This series Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd=
.com>

________________________________
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Thursday, September 3, 2026 4:48 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kuehling, Fel=
ix <Felix.Kuehling@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Reset UALink connection on failed TLB-shoo=
tdown send

If sending TLB shootdown to a remote GPU fails, reset the connection and
mark the connection as NOT_READY.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ualink.c
index f5865c5fe93e..5b3c7f62c34d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2681,10 +2681,19 @@ static void amdgpu_ualink_send_tlb_shootdown(struct=
 amdgpu_device *adev,
                 r =3D amdgpu_ualink_remote_shootdown(adev, remote_acc_id,
                                         npa_addr, size,
                                         AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOO=
TDOWN);
-               if (r)
+               if (r) {
                         dev_err(adev->dev,
                                 "EXP-CLEANUP: TLB shootdown send failed to=
 remote:%u\n",
                                 remote_acc_id);
+
+                       /* Send failed: mark the connection NOT_READY so th=
e
+                        * rest of this cleanup (and other cleanups) skip t=
he
+                        * unreachable peer via amdgpu_ualink_check_conn_re=
ady().
+                        */
+                       amdgpu_ualink_handle_connection_reset(adev, remote_=
acc_id,
+                                               AMDGPU_UALINK_CONN_NOT_READ=
Y,
+                                               imp_entry->generation_count=
);
+               }
         }
 }

--
2.54.0


--_000_SJ2PR12MB8650BA6CDA773D362D364A548CB62SJ2PR12MB8650namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
This series Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiviswanathan@=
amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Joshi, Mukul &lt;Muku=
l.Joshi@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 3, 2026 4:48 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; =
Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Joshi, Mukul &lt;Mukul.Josh=
i@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Reset UALink connection on failed T=
LB-shootdown send</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If sending TLB shootdown to a remote GPU fails, re=
set the connection and<br>
mark the connection as NOT_READY.<br>
<br>
Signed-off-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 11 ++++++++++-<br>
&nbsp;1 file changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ualink.c<br>
index f5865c5fe93e..5b3c7f62c34d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c<br>
@@ -2681,10 +2681,19 @@ static void amdgpu_ualink_send_tlb_shootdown(struct=
 amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ualink_remote_shootdown(adev, remote_acc=
_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; npa_addr, size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;EXP-CLEANUP: TLB shootdown=
 send failed to remote:%u\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_acc_id);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Send failed: =
mark the connection NOT_READY so the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * rest of =
this cleanup (and other cleanups) skip the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * unreacha=
ble peer via amdgpu_ualink_check_conn_ready().<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_ha=
ndle_connection_reset(adev, remote_acc_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UALINK_CONN_NOT=
_READY,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; imp_entry-&gt;generati=
on_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.54.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR12MB8650BA6CDA773D362D364A548CB62SJ2PR12MB8650namp_--
