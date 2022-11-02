Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76863C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 15:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8957010E4A7;
	Wed,  2 Nov 2022 15:04:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B9B10E4A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 15:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=merr4Y/sg5gW53zdCRrJWyJCnIO+yTcuE8sObXguAmsczvw86n08essS5hiigyWCsFYhErBclZeRglzgbt83/0/TU/Lh9gzcxw+f2PDZ/51chqei5M5H9dWCa/0JZn4yzNyiJdDByOcKc0eK3xwD1qgZYkUcZ4r2kLzanQPqbl/dvR06W6PY0ey8/scEJfkx1ZtV0MkeSALbM+0lbOpwbHGlOSFGRVF+5UsjRgnFB6w/P81Hf48l9oDQLYzYHsrmBm0BX0WmJmU37jWYBvH3q05OV2Dt+aYqs4igYSI4dWjESfEur2UkX1r4EJjOkoHyhbpSkkXDbPeAuoQWORkAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqR7aZbD0pxdBqVhPLRlCswxvJ9U3Bqzs5umGm4+iAs=;
 b=Lw4Klx/M83LBPVgoVF7RtvwMwIMgSU84OWi8on9A+If6qe0xt1rvWbBPZYQX5vyDkYcuxL4IGFJd+1eY1WJFdzRQVl/WFYg1Pe+LV5fU1SnJqXVuNDbDX4uspfQtPw0TcOGGaTxkVbvB9OhJi96+Ch1W9RNBUcK5wunBhSbFWhY71DMCBLs0jpXg6DnZNPMLc91Y1OdscVThOJJ6lTOfAkvl7GlthVTjhVQoznKwQxizI5OYfNOLl6PdgT5J9sbNIVQzb+SWs52k7P6YropOEAKjBtTfdAKc195pXBDVq9LDP3wAZ3rzNBWN+/B6Jphwbzqq1ou4ipXEBjW/0v/HrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqR7aZbD0pxdBqVhPLRlCswxvJ9U3Bqzs5umGm4+iAs=;
 b=qVKSNLI+6aDaKQ8N6Kvjsif9KySdVnQNQxGaK6OYKiPkQD+ZNGweyENcwwRk486ifTOWrbNKOm0fxnGgBr75hogwF5tWy3XJr2Rsswktq9/IpVuX0s+PullRvESAIbj9QcrQi6kBElXz4iLSuqI5fbJUPIXwktEHPyouVEA1K1w=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 15:04:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187%4]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 15:04:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: skip ras late init if it is not supported
Thread-Topic: [PATCH] drm/amd/amdgpu: skip ras late init if it is not supported
Thread-Index: AQHY7qP+2qeWpTB8lkSckTMU4kJLd64ru3eS
Date: Wed, 2 Nov 2022 15:04:35 +0000
Message-ID: <BL1PR12MB514476F7C5A0F4765AF25589F7399@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20221102101458.1243982-1-kenneth.feng@amd.com>
In-Reply-To: <20221102101458.1243982-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-02T15:04:34.677Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB5912:EE_
x-ms-office365-filtering-correlation-id: 7f0f2b00-134e-4c2a-550d-08dabce38e2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wpXEHNFZKvM6wwaUs94GuYGPRDkWkBV4cm4lYM1A1iTkuNQ6DmSc7n3lQ3ywlceEolzeeJiWJ/1Gp0e7/p4Nn+ZVARGuc/tQAPul8+2X3D+OYmnSSceXO9+OwP/upbZ7wuiF0F1ayKRZXMwi4GrhiCbu8bUfOnUwAJp0ggpEcF/Oy3sFb0+UyU/kfQ4/7ltNQgzfeeTR5+zby45uLES+tOEqbuDe8fEjNTpEB7R5TC0YRgyyJkEC+Yd9g8w9Yyreej5L5BDGqzsBCIy6vYaezgtnnMxZSwHVon3lRcEWAy6n5pPYp9U1I0zOKWU5Y8/QkrtzS45GV1zOSvpCBWv4qVKkdb+iPLGmjqG0GmWDoA5ecEVJE2KcCYajVGNluGhznrZh4RSIEqPaaQgo24YGUU//nxRHsHdd5o+8HBNGzG26Hc1hB1H1kGcvP8rzyGlCiQU4cWKUlTRYkss2T0cnQ519ZK0n3umbo2Nx960AkobZbb5k6J/O1TwbApEugX34f6UGmMdtAmzYAThexEun+HqaEKI9WKl4hwlqoIs2PoOjWRl9S+M+J5hwR/ve4zOq9PJJjKSZ5lFjZBRf/YqyOt8GznXF0mINkOU6MjlDKnbEVUdLFXNXfvYTa4M+fUtBBt2j7gEfqlMNPZs1bkrHG+kV7pIdc5pVbqWxACGEeLeN4ddI7hoYDLlJ+WCBzYIFE/G+T+c0RrfT0ijupPWleiLUOunNf05fBHJD3ii34OPl8Qkue83Ap/7BTgAvTG+a7u61HLe+TcLqiP8zWN2YjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(19627405001)(66946007)(76116006)(8936002)(41300700001)(66446008)(66476007)(8676002)(64756008)(5660300002)(52536014)(186003)(26005)(33656002)(7696005)(6506007)(38070700005)(110136005)(9686003)(316002)(71200400001)(478600001)(53546011)(66556008)(2906002)(38100700002)(83380400001)(55016003)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I4BHpG5L7qxpKwL23cMUz1VAaPxCxDQoZpEBB0D//fEaDA9qqC2cypEb+1CJ?=
 =?us-ascii?Q?aHSAuJYrgjXOtkcnIhdHwC8zTZvVxmDwBE2WIJPY3SObjiwdFlyTbmLTWfL8?=
 =?us-ascii?Q?5Xeww0pYE3LISH64HeuJifCeeKc624HuPNe9pZLRoaXipMP9uFlxeiLmzNAB?=
 =?us-ascii?Q?KHrFOBOvHNuhkjfRuU3ld2wIEzxOUtq8WPRE+T+O/5EM93gJFBu1B/GLr/5B?=
 =?us-ascii?Q?Nlq+piq4hY+14kKSWsYyX5xpVFtgo28PoN7lcgLfzfq8+cZH2wTSSK/bhkh0?=
 =?us-ascii?Q?2NJH0JfwYrZRS6iYKar6pdRLqpjxhYORmWF+TxcoUq5Gr7A5clS1MSJS3xZB?=
 =?us-ascii?Q?BaG6ISbnqAVIuUa5kFh2Gf25itAoywjMiMh+DvkoRf0Pr8XWHwOotXRhgiMa?=
 =?us-ascii?Q?k7ku9dtUq+E5QPpICAK1ado7uoxe6baFzfE9U4ChC4trYpK9Z3qEH4JFMZ27?=
 =?us-ascii?Q?gXitQS6PxQZbI96mX3AjQmDw/q20hNQ0u1jAFNi9F1a0xuEk0wGsIAnc0swF?=
 =?us-ascii?Q?xkuOPRu0HtWvW07YCVu/y3czF2wjahqIDulg+PuUx6/HK8IioWEwrG7xjInt?=
 =?us-ascii?Q?/kVPK6pxTyFO/IXEyUqrBFUtkTJEs2gk2HUJPsw52tBHQZyi9sBrNSepBSQs?=
 =?us-ascii?Q?9N505AOHjD1YBUEcQ+MbyUX/YLRZKRKuXzSgzuRP8LrXxKCXabK4mUNzwbCJ?=
 =?us-ascii?Q?ut/eoMsopprXXR3qX3eld9sS8poi5RHUwamwGbk2/fDUZOMRAuPhVYPHsWYV?=
 =?us-ascii?Q?SvFFbaaPoTt1ka6wOf5dCdab0M4G0y8EKWe0BXbXUtLCFNebIoNAuzChBx/X?=
 =?us-ascii?Q?gpkmQxv97Fbwxf47zEvjg1XYaKIS1sytC/HH2OLT/JJic6Toz6GJNP0YnRyn?=
 =?us-ascii?Q?BGpfeZ1t7jQZQoCEQXZA9E03msC9UdFOHs1vTAOrhxmHGAT/T8K1jsTRAfaf?=
 =?us-ascii?Q?m880l7/kxhiD5tfpjY5IaK92D6Iu5r+pn7ZJwuoUL7TLPlG1GDU64Iu57XsX?=
 =?us-ascii?Q?R0uf7LTVdgPry27fYQotU5V7LyzXtBGj3iOPHiXxkSNkjVg125egKCL0lVSX?=
 =?us-ascii?Q?sFwqn5EXhl4d534fgMIHMEkrbSGKGiefGAWWCRfgjNehsdPTShMSdzZ/DUOz?=
 =?us-ascii?Q?OHj3BMVGDFUUQKd79uqG91DL1KNNZTWYPddar+fIbZjO0lAOzt41ywv6FKZw?=
 =?us-ascii?Q?2zLsiFl6sqXlQjd2wrcvY98fBlN6HY2O5kZdrrqoXCcl6DipfYL/KUa0CxY0?=
 =?us-ascii?Q?1n+hl5CAYupvP113GfLtiVJGh9zECFGZAnIK753f98eqWIuMYNAZ1jncdCzZ?=
 =?us-ascii?Q?Pawl8QLEhjExlBkXwsPe+3oQ490ErKF7+LHxsXpy400zt4Sobm42aCyfmBK6?=
 =?us-ascii?Q?k0smHMqnp2mBed7I+6ED56BIDcICMWKJaq/oVBbWC3GcRpO7mJGDydvGrXsw?=
 =?us-ascii?Q?9uIjCNLpt0xUCbo9LarTGdC6U751oT/zTBGvqwr41BquVwbb0b8dNJgqkhyz?=
 =?us-ascii?Q?yTJbpJ9hLZZpD4a/WGJxVkxKnR74D0Jt2WAOkzKm8tIvWf5G6Ap1c65AI98k?=
 =?us-ascii?Q?2Qms3/BLM53hGRl04C0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514476F7C5A0F4765AF25589F7399BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0f2b00-134e-4c2a-550d-08dabce38e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 15:04:35.4811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98HqUWieBufp6Dkp9h0v/8Q5T1erp31+EHisqfjq58zF4VL0N5BDwc/vEm9uJhnkTLo1NnrjHFHAbmwpcQK/Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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

--_000_BL1PR12MB514476F7C5A0F4765AF25589F7399BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Wednesday, November 2, 2022 6:14 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: skip ras late init if it is not supported

skip ras late init on gc_11_0_3 if it is not supported,
in order to prevent the hardware init exception.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 84a76c36d9a7..afe1fadc1e9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4707,7 +4707,7 @@ static int gfx_v11_0_late_init(void *handle)
         if (r)
                 return r;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3)) {
+       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3) && ad=
ev->ras_enabled) {
                 r =3D gfx_v11_0_ras_late_init(handle);
                 if (r)
                         return r;
--
2.25.1


--_000_BL1PR12MB514476F7C5A0F4765AF25589F7399BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 2, 2022 6:14 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: skip ras late init if it is not sup=
ported</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">skip ras late init on gc_11_0_3 if it is not suppo=
rted,<br>
in order to prevent the hardware init exception.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 84a76c36d9a7..afe1fadc1e9d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -4707,7 +4707,7 @@ static int gfx_v11_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(11, 0, 3)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(11, 0, 3) &amp;&amp; adev-&gt;ras_enabled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D gfx_v11_0_ras_late_init(handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514476F7C5A0F4765AF25589F7399BL1PR12MB5144namp_--
