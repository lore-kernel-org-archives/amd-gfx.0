Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C9FCD11DB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 12:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9F410E580;
	Mon, 25 Mar 2024 12:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1y9DxsM4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D1D10E1E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 12:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS9MACgEw3Zp/liVYxnd0q55hk9xHw/bG59eWviz0xvhxiw6nkkrbTUzH9E6zajzcwsauqDkzJe0Jh9NXmE2mcuc0bj0RBw7WOS69BFV+HqeifPpDTy6ZSwtuJq4RsUIKhKnZoa9mtizSmqH407vM8S0VgMBSgYdwxKa/t7vbZx3P963pCJVOrzG5NlyJfHJVOlN7xNuYoEf2tWo4Umi/o9QIFwF0BWzPAIXKmxNtGBZFNRBqMwu6ed3l/I8xMyST/WNoPyKh2F86cmbbrYfUou7iud989l46JIZaf2pIikA2URYm0vp4oCDRBknU/l17h0Ad++APNNyFDLSSz17ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3OLP4OKTxMk8ILbsm335gkCq/7ayGcGazMvWra8h34=;
 b=hHD6fQoDjpuwBCZyHMXCBJeHfe7ZUqtRmOAX8uYdUDEMVHy9HrJbfRtDe/bszemTDEpoFmMveytanNJXA+G7MXmrfv408CJFCFpHMUoSsV6cRt3Uw8UxlPbkNSMcyTQADjfkC/YacNGtw97F1wqDLBFgOdzoIEImXee2GkuH72FNZmp5jUJMsDxIOc5jOrlz+UX0Ftcr9QQn99eS66KwHzxAAsgY9kylQK6YswjIK0uCiVO8AEYEda35tRKrq4bjmKTQrldXzO7W3dlQ2X8jyaRV956fuScKar4bCP/o8rRD53AiDpJW92G83ZeuqUruchAgsj3oJdOz1DlTUAjx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3OLP4OKTxMk8ILbsm335gkCq/7ayGcGazMvWra8h34=;
 b=1y9DxsM4xe7A6HMc0lv06yBLomhI5r3cyS7ZICtQTgwIq/9f4InKX5pvT7Cwoe3M7051DfXXUKjYBEQKF9HLkP7vjN5hE3ic5eTOiy2pTSeBp/AG5Js8XSjdIe1EpMcYMVH4g0CrTfL3xGTplvlbIvnZCcKnfHrJBp/kU/8DF/c=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 12:58:14 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::832a:d65b:6251:4d6e%3]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 12:58:13 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Thread-Topic: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Thread-Index: AQHafHkE7VgplRr2nUa/aZd+99nt3bFIbx2E
Date: Mon, 25 Mar 2024 12:58:13 +0000
Message-ID: <CH0PR12MB53721DC88B89DB6EC87A2A29F4362@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240322164956.167498-1-shaoyun.liu@amd.com>
In-Reply-To: <20240322164956.167498-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-25T12:57:44.7694248Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|CY5PR12MB6180:EE_
x-ms-office365-filtering-correlation-id: e18edbeb-8dcb-4a61-a82a-08dc4ccb3b35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+GNv5dW/uy+fDu/hKCMQQvvjspgK55m/UN71aFLqndSTeyoOwJE0Cd+fMX7Gfja2jFDufcmoAuRrpnY5yingNbpDgJ6KtCIABffANKXF+bwhS8xwpaCu+Iig5yLmXcxGz/pMXrkqpj2e71msy3gyFeEXVyOT8jMXcxfUYobw/la9+xOT71sPUyBVoFpyn+ltCLehTTWAr4aYn/nvi2pY/NFp5mIUjoQh60qSKmFlbnN3O0+ILlylfwfbKmzC2JazTREjoe8lKf1Lk/MNE3gveak3QUmrQjzKH5SrXNLNERk7c3XWYkWKFGVG8wEZTe3hXSeFdX+62ovoSYv0Sg/If/O8mAtBLt4NSJ5/UrfckkQDaHW95U67xfSSdS42r99CTEqnLekqC9lKlwv3vmvLzkxe2uBPEOX5lk5nm2JoEpafmsAwEsDJrf0wQwt3XZbkih6y9c4s9I+JXWboKlhaDQAsxncV1gwOfiPNLlIbXJsflNWxMuV7pcFjuanK2njR+kvzJo4Ql0O3sEAb7gauqbXeb+PuQcvgiASQW6WEtT8bPWPU3Sr9xnpln8YCqD+K7Sjg7t6vIlUQOrmN596PUszW/U1McJ2FJ/MGO3rpN1dSOMEDK5wo5jPT1zb0SJRLPx8VC40JFeZOvSCSSKXSDhda6I18E409DMei21abio=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yyyQTWW68IdJ7tzU+0vc+ElalM9i+A2yv/gYjIjBW3a4Z49vjG+V+dIvq3N/?=
 =?us-ascii?Q?3eeXw+oqlR8ajgDHqAVWdZkCneGtaUM0XTW+YItBK+/CasnouWE5K1SbDp6b?=
 =?us-ascii?Q?hCAxl0ZuURQHgk6Qu5LOkXRSjJ1OKkHW/nkAiZXpPneJBcQGAOkQX4fHIcd2?=
 =?us-ascii?Q?0G/4ZX7fDiBuowKpgbfiQQHbM9T0x4tn4yPo4KGoSNpyoAh/ltQ0RDv+jPhu?=
 =?us-ascii?Q?rS2BoaEe33NYiVZreBIrvtNfJVFegBvhcCVdKWdaiTKNgDB3MVQa9qeMyOLG?=
 =?us-ascii?Q?Z+UARGFm/oZZlV6n6sZD1cPSKbOvCOd/u/DYPPHH1hFxNwvHO5ArGXACezgt?=
 =?us-ascii?Q?y8SpIavbtODiGIJx2t8zwlFXhL8efyU78xRRlFlH4lYSX8CoXvgMuYMYCnx2?=
 =?us-ascii?Q?8ENHVJy5NeG32xnI2H39ZCD8EfPeqKP90wPxRLEPEtV3ieiczJSv8Dt+wbB0?=
 =?us-ascii?Q?RnJLTrBLitHE4nkzZestO38Xs+0TEiKhSBpdCqYO2jj7bzDk+NuHRb4yym+q?=
 =?us-ascii?Q?7WrTc59I8/miD7nQgppoDeQ2y4PD4+U04H7jsW63xqe5KTVR9F6vrFcymK75?=
 =?us-ascii?Q?jppRW3LutW7s4mvtIt/FaVa1QTVmD8nkAwnG9bcP4KzfLT1JY2DDApR0fQtX?=
 =?us-ascii?Q?m7+44Vs0EyYzA5o+kQdVBME0RvcKwrcjgSN3yPC2oY4MSzaSSN8AsjOUXqE2?=
 =?us-ascii?Q?MYhciSjhJ8iIiHEIFH7xcx/brj7zo4s0fyq3diyBzCIYhoejLdSNKNXOArXM?=
 =?us-ascii?Q?fLiMr1z8thS+SgfR8Z3bhamBjlkk23mWDQ+vBOvEA9dMN7sGHJOI9w0xUYPw?=
 =?us-ascii?Q?G2G7yKEs2c/Sik7AHJ9fKwftzOGLUVWYrwSQt1fh7TCS95Q5O+pKbPU1nJ+R?=
 =?us-ascii?Q?2I6UdxBGqeB1ghWvJ72gZ4cwn1al8laxlhDD62WdVxxV4gNIn69+fR+ddhsS?=
 =?us-ascii?Q?/HZnHXIT1A1zYb0JGEwvKU3AXxrLVUoVsvRwda0yJ2u+z3Yhm0tyfP4FEloY?=
 =?us-ascii?Q?Jtn+mpNaUfXO4ZuRxMPZ+Kjo2ykU1wEKatlwRFosVxvZnp5cfmRux0obiePM?=
 =?us-ascii?Q?HfcB22cCSpLyMCl1nqKnrQYQtC946a82BSxJnJ8wIZyvQbFro7zMx6SZx6Vz?=
 =?us-ascii?Q?tLYieW17/grY/VZGSnF3Iyp/RvGHr8E8G5lwYVYYkA/tx629ehWU/G4VwRx8?=
 =?us-ascii?Q?bJBW1TG5YySBU798kDkleM/9jxLvWft0/Dhb5DdM9iMnXRR0I14sUr3t+uTz?=
 =?us-ascii?Q?fgPj4CfOizt8CTkTqIV4zYjoHTjWkWF+zZp/RSDHGcMVW3jHJSC13ToZNcd3?=
 =?us-ascii?Q?UIohoFqCeEnqwmI2IaoZj+CBdvdd6trbZRFEyNS69Zv9TASl3LlHAmq/DUId?=
 =?us-ascii?Q?T6H4hzkKLKonf1dzKHD8okW24ZkE78E9RV0EzGohOJJDDEG+zhpc60vYXbRj?=
 =?us-ascii?Q?rH/TUUxHlFG9MWdt2lX0nKZ0Xh+kM5l0zinpftH2OE7hxLemyEioNS7GPWf5?=
 =?us-ascii?Q?lBsU2M1KJVAxoK6OWLfgT+nhtMPtfHLn5Z2/sMfHqH7kvZYBMqAQFk0I/vh4?=
 =?us-ascii?Q?mJgzt1U/9qK1PGtUtTXB78DNJbQhPrmqyfkfYo4crMF2xfgtLRwUe0Px0aFO?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB53721DC88B89DB6EC87A2A29F4362CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18edbeb-8dcb-4a61-a82a-08dc4ccb3b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 12:58:13.5135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeZMvdU+2bwRd7OQtD5uH0Z4vUXOueFTsaqqHTNC4nj1QrK0X59UzVe/gEyUPAB0+Uu38t4QtzSs3sYZlwt+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
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

--_000_CH0PR12MB53721DC88B89DB6EC87A2A29F4362CH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

 struct amdgpu_mes_funcs;

--
2.34.1


--_000_CH0PR12MB53721DC88B89DB6EC87A2A29F4362CH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div>
<div dir=3D"ltr">Ping</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Shaoyun &lt;Shao=
yun.Liu@amd.com&gt;<br>
<b>Sent:</b> Friday, March 22, 2024 12:49:56 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu : Increase the mes log buffer size as pe=
r new MES FW version</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From MES version 0x54, the log entry increased and=
 require the log buffer<br>
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
MDGPU_MES_LOG_BUFFER_SIZE, PAGE_SIZE,<br>
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
&nbsp;<br>
&nbsp;struct amdgpu_mes_funcs;<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB53721DC88B89DB6EC87A2A29F4362CH0PR12MB5372namp_--
