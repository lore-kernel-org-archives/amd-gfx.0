Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F6FC54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 14:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4FD10E781;
	Wed,  7 Sep 2022 14:24:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34FD10E789
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 14:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaEbGcU5FJuWbDKV+kpS758MeAJNwhJgWfHnvg4nplAV0oIG3BCim9N6My+DHz93lwTZaAXjDWSjWmd76kX0AFhiLnuJ+d6sr1Q8Lw9yUimHCtR5+hb3iax+HElj4o+cPoizaNfBFMDn/aVtbaQtk1j4NNlJWvyEZeW0jHCSsgF0N2gokmMSyhtf+BnLlyzqF2nnn2gnsJ7NP6eLZViUgfs8+eGWJEg1zqpGfKW9al2d4P0WgJ47695RRqaj5o5zmrG79UMeQ+N2ODUi2t9ZhKbX3k6AYUIXgR4gq59hzhgVeWs5gQRJCvq1lCvUBxbkzWD4hMwNty3FpVbSxhoKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5deZC0kJffmGSMzkESTnmBEhIO1vo8wCRAnphwQ0qw=;
 b=RHy321GcYR+YKZts9P4zBbzCXkr/68vYxa+F+o4x6E5JRlIgNQEXeTOuu1Vr3WJCULMzT9a0pF8PEJ4mfi/cnWuztb9fNH+NuZvO9TOAUQtp0p3orjEkn3LXFHpFumvaS4ov9KoXEfg9uxHeHCHm4eUYUTh10lyDh5n/mzy471HIhbsgd9ykAJOWGZ/jM0pRKIxlGS0olHcmO7Qep3vI2HP7dfO/wuQ/kwAw76zFh1VcYCd8NS/+6QRC/N9G9/F4/YvVSE3e/xRdOUyP80ASbJF4kquQAxL1myEwTz4Pyd8wxnimIW/9rnhXoyTGImnK8f44DzlyNmNCZvbINYCxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5deZC0kJffmGSMzkESTnmBEhIO1vo8wCRAnphwQ0qw=;
 b=b5oBR4tHpgg/bQUX+DyUL8RYdx2amOTWvdJiqR/gqW0qIlZ4vXJltMtEKpY1A+bNNYje8uhhUTe6HCkxNkRqyEuyO9eZwfS9IrlqYSjahITTdKQKU/oEpOJQOQLYDo33TYtJtkX64y4SkZ7GwEK5Ji5Q2BFCzvj1rxjEP/BAu7M=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 14:24:48 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%7]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 14:24:48 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing CGTS*TCC_DISABLE to 10.3
 headers
Thread-Topic: [PATCH] drm/amd/amdgpu: Add missing CGTS*TCC_DISABLE to 10.3
 headers
Thread-Index: AQHYwsVW+BADyjgDX0ipSQpm/JrFNa3UBX3L
Date: Wed, 7 Sep 2022 14:24:48 +0000
Message-ID: <BL1PR12MB5144DD4F96D59EEB09E59278F7419@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220907142229.818384-1-tom.stdenis@amd.com>
In-Reply-To: <20220907142229.818384-1-tom.stdenis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-07T14:24:47.775Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13d0501a-ffcd-4b74-e52c-08da90dcb823
x-ms-traffictypediagnostic: DM6PR12MB4547:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POHBzte95c5S4HIEoA0xxPptku5bFgbuUC4MoyCYrTn+kb3gkDxqXes3qoRpLbjNlmWvzYWgz5wpERZBHqrWyaEibOJ6vE2NssVNOQfhjz+98TKfFGUhimPmiYbrQmMEJ20X1wOKd/vTjy5sDZ1oMl9l4C0hg5M+dywGEuf1bZbc11l+ozqmq0Ecp0sr96E7ibnqvA+goa/efzS/wR/RFd3v1UhM2171f/FOqXkEDZ4LIZ1hmFy716gRPB78Mo28kIxn7a3gAGjj1y0j91ovixBejc2Vc9rl/N3jw5ugHbD3qCpttD5q4GY3zpdVlPT5a57HXBekhCD3qVvgFTRPsq5BIy504J10nq38wl1ovU5WPkWU5fF8wx+SKopnLFc5EygduTi75Mr/NjpJeRG5nB/+iylJhNqnEimz2Zaw/3E5Jfz3Fhx41nrABM1HTbXr3/JSPF62MYPI7zPfCuae8NODlWaUYKeJNeuFWNjQLY9TnHYQKo8W6iCX85yrET3v/OEABkEOpfTn8a94oSEhf/GWKSTovbAQMYmIzwnNyx5ryKUXl8L28mcxxkzVtr7zroSdPjxEIsV1ehDBrb2WBcRMaiO6SBkWrkJcuTRi29t0wwObTbuT2M1TqTbQNjNrqlvqrXDKSijNOXH317/tj3xYuyOE4sCsKYLb5N+EC2K8xlJZ93qA9aUHQkRb7ui+/tCYBed4xdjlUvmDOsdj0etWsACyCJZgMv+xPcKbXkLgWp+O+FAN0lQKU7TaOrRUjfhROXnlRxSUd5Ixz6Kbqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(71200400001)(122000001)(19627405001)(38100700002)(8936002)(2906002)(186003)(33656002)(5660300002)(478600001)(52536014)(6506007)(7696005)(83380400001)(53546011)(55016003)(64756008)(66946007)(76116006)(66446008)(66556008)(66476007)(8676002)(9686003)(86362001)(110136005)(41300700001)(26005)(38070700005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FopsLcbEn4T1EH3nP6PLXXOHS9G9apJXA/eeSUt6JPYxb9N0sbJxQM6V4iMX?=
 =?us-ascii?Q?kWI7Pvpzj8o/WdrdcNIil8OdZjOpslf6yG1yi4QnghtyR0nt3uFig/tMi3UB?=
 =?us-ascii?Q?xPXyVatsRmikV7Tsw8zRWNoaL2IOhQTrSdg6NuGKQg0eofpYbe8yVdT5hfAI?=
 =?us-ascii?Q?sBvJpUoUQe1q2qXwYqm8U+nFCVTXih5LmkQG9dpVBaGOuqr4oSN1gWoE+U2f?=
 =?us-ascii?Q?lrLiMoLwxQCc60KnjUFZQeGSQ9zBRheCXd/BeOuTcv9mHvYVEQrEq381/bW8?=
 =?us-ascii?Q?tqb5/tjqjKPloxZwvWdUtJQ7w3F2sOLxwDLAobkjEhIGvZ6YnYqxabvtgzkJ?=
 =?us-ascii?Q?lptREtNaWJRPhSAl1j132AFMGV+09ALKqBF9EAUrdtaXaJBZRBWiihpL9Xrw?=
 =?us-ascii?Q?QBHXEMJozpClKlrUXa55m9is1gBvMDhJfegkZ//sg3VMliaQYKcfzYc3DJfg?=
 =?us-ascii?Q?RBOZYZTsxAw6+E+VP5FoAYFu20CSol3K8b9RNVGrvhQk3YYiDLYR4kPqTpng?=
 =?us-ascii?Q?1jLg5YKKi6aOedQOZj8RrBV2/DNclcy6IpoDIGflUMRZp1/MawHNXAMZdmvz?=
 =?us-ascii?Q?2gyGDtxa22lAcpG8qJLNKjd3gzRO28fYmdQg8VovrKjMZTOrw0EdQGKRT4Pg?=
 =?us-ascii?Q?Or+o/jzlhYhePDwqCUugzRtLLXI17wszZvEa1sixBKp7NjYn38HlDVWG5Xjt?=
 =?us-ascii?Q?a32k7lKp1qzj7gP6cNG0/1I/qUYw0CADi6TXL0eT5q0lmC+WbNU35kjxOODp?=
 =?us-ascii?Q?DYIzVnaooaUdfKHkMorLBUu9IgxfOsk+qtn2+JYxcNC6EP2gD+BUwZIozOUI?=
 =?us-ascii?Q?5dCdR6UPDRJjiLxyjrqeqRDtsroiyH50uIZVTvyXRkDK/1FNzRh4RWP8eJwP?=
 =?us-ascii?Q?6FjTYBej6/qXOe7Y+1nUQmiyjY8zx7p4C8sISPahRi5CE2Yno/ElswV9aBW8?=
 =?us-ascii?Q?MjMsYDfxE9wucy7s0ur+4h/NFr0LSnTgua32kmV3kNUiSvGIGXMBP7Kc9Aui?=
 =?us-ascii?Q?YamUV2rvmGFDo+5LoaKHn88GGR4OfxInrGHa0IUzoZ762gZAtAYQyh7gtR35?=
 =?us-ascii?Q?+ZaMJW3cQKOk3KDIcOSWoZQaMdeFX8+/3yExWwPJ1AoGhM8elvHr2cX4lEB5?=
 =?us-ascii?Q?XZIRGICvilCncyKt/6AVRJSPI5Y1YENt9onHBUBVR2FhvYXYgeWtKBFHpBli?=
 =?us-ascii?Q?H5iaHl0qMlo/1BQ0uSXdKiofTSSDTAELU7u3oNOEJWjANRGJTGxE+XUBBzLV?=
 =?us-ascii?Q?6gIlreua/S6142xq0Ihp2rLxUBds+tf5o8zDFveB4Y0SNZXJtY3fhECv5bOb?=
 =?us-ascii?Q?huPEA/jkcBhvPMBhMqmcKcRz7KcA5GIqRAWZ6IBu9/rgqqLAC9hqY4x7vFim?=
 =?us-ascii?Q?SRBlCBcagL1hXbYwO66DphbZ77nQPVx/FHrl6pGL5sTbi2hvQDhsRt1tb2BF?=
 =?us-ascii?Q?dzoaDfpU7aOJN9CENsRp3kuNrwPrSoxWrWMGdPQiK27zmF4zSfGpud0CnGvw?=
 =?us-ascii?Q?+gQBJVNBd346dVkOH0RmHrDuoPrs9SJrLBSfjivFlJruExNWUZN1HWRgSAeW?=
 =?us-ascii?Q?yhorCH8lTYZ5yKtk0Hc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DD4F96D59EEB09E59278F7419BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d0501a-ffcd-4b74-e52c-08da90dcb823
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 14:24:48.2442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDkPF6VB98hyXx+MDypYsCU1sRZtopkmaKpvE+yD8Efl5j3qcvSn6FHdn9eeQs6Ka20dWbjN9eWy8srcND68gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
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

--_000_BL1PR12MB5144DD4F96D59EEB09E59278F7419BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Tom St D=
enis <tom.stdenis@amd.com>
Sent: Wednesday, September 7, 2022 10:22 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add missing CGTS*TCC_DISABLE to 10.3 heade=
rs

The TCC_DISABLE registers were not included in the 10.3 headers and
instead just placed directly in the gfx_v10_0.c source.  This patch
adds them to the headers so tools like umr can scan them and support them.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h |  4 ++++
 .../drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h    | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/d=
rivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 594bffce93a9..1115dfc6ae1f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -9800,6 +9800,10 @@

 // addressBlock: gc_pwrdec
 // base address: 0x3c000
+#define mmCGTS_TCC_DISABLE                                                =
                             0x5006
+#define mmCGTS_TCC_DISABLE_BASE_IDX                                       =
                             1
+#define mmCGTS_USER_TCC_DISABLE                                           =
                             0x5007
+#define mmCGTS_USER_TCC_DISABLE_BASE_IDX                                  =
                             1
 #define mmSQ_ALU_CLK_CTRL                                                 =
                             0x508e
 #define mmSQ_ALU_CLK_CTRL_BASE_IDX                                        =
                             1
 #define mmSQ_TEX_CLK_CTRL                                                 =
                             0x508f
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/=
drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index a827b0ff8905..83faa276523f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -34547,6 +34547,16 @@


 // addressBlock: gc_pwrdec
+//CGTS_TCC_DISABLE
+#define CGTS_TCC_DISABLE__HI_TCC_DISABLE__SHIFT                           =
                                    0x8
+#define CGTS_TCC_DISABLE__TCC_DISABLE__SHIFT                              =
                                    0x10
+#define CGTS_TCC_DISABLE__HI_TCC_DISABLE_MASK                             =
                                    0x0000FF00L
+#define CGTS_TCC_DISABLE__TCC_DISABLE_MASK                                =
                                    0xFFFF0000L
+//CGTS_USER_TCC_DISABLE
+#define CGTS_USER_TCC_DISABLE__HI_TCC_DISABLE__SHIFT                      =
                                    0x8
+#define CGTS_USER_TCC_DISABLE__TCC_DISABLE__SHIFT                         =
                                    0x10
+#define CGTS_USER_TCC_DISABLE__HI_TCC_DISABLE_MASK                        =
                                    0x0000FF00L
+#define CGTS_USER_TCC_DISABLE__TCC_DISABLE_MASK                           =
                                    0xFFFF0000L
 //SQ_ALU_CLK_CTRL
 #define SQ_ALU_CLK_CTRL__FORCE_WGP_ON_SA0__SHIFT                          =
                                    0x0
 #define SQ_ALU_CLK_CTRL__FORCE_WGP_ON_SA1__SHIFT                          =
                                    0x10
--
2.34.1


--_000_BL1PR12MB5144DD4F96D59EEB09E59278F7419BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Tom St Denis &lt;tom.stdenis@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 7, 2022 10:22 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Add missing CGTS*TCC_DISABLE to 10.=
3 headers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The TCC_DISABLE registers were not included in the=
 10.3 headers and<br>
instead just placed directly in the gfx_v10_0.c source.&nbsp; This patch<br=
>
adds them to the headers so tools like umr can scan them and support them.<=
br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h |&nbsp; 4 ++++=
<br>
&nbsp;.../drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h&nbsp;&nbsp;&nbsp;=
 | 10 ++++++++++<br>
&nbsp;2 files changed, 14 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/d=
rivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h<br>
index 594bffce93a9..1115dfc6ae1f 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h<br>
@@ -9800,6 +9800,10 @@<br>
&nbsp;<br>
&nbsp;// addressBlock: gc_pwrdec<br>
&nbsp;// base address: 0x3c000<br>
+#define mmCGTS_TCC_DISABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5006<br>
+#define mmCGTS_TCC_DISABLE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
+#define mmCGTS_USER_TCC_DISABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x5007<br>
+#define mmCGTS_USER_TCC_DISABLE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&nbsp;#define mmSQ_ALU_CLK_CTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x508e<br>
&nbsp;#define mmSQ_ALU_CLK_CTRL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
<br>
&nbsp;#define mmSQ_TEX_CLK_CTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x508f<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/=
drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h<br>
index a827b0ff8905..83faa276523f 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h<br>
@@ -34547,6 +34547,16 @@<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;// addressBlock: gc_pwrdec<br>
+//CGTS_TCC_DISABLE<br>
+#define CGTS_TCC_DISABLE__HI_TCC_DISABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8<br>
+#define CGTS_TCC_DISABLE__TCC_DISABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
+#define CGTS_TCC_DISABLE__HI_TCC_DISABLE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000FF00L<br>
+#define CGTS_TCC_DISABLE__TCC_DISABLE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFF=
FF0000L<br>
+//CGTS_USER_TCC_DISABLE<br>
+#define CGTS_USER_TCC_DISABLE__HI_TCC_DISABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x8<br>
+#define CGTS_USER_TCC_DISABLE__TCC_DISABLE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
+#define CGTS_USER_TCC_DISABLE__HI_TCC_DISABLE_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000FF00L<br>
+#define CGTS_USER_TCC_DISABLE__TCC_DISABLE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFFFF0000L<br>
&nbsp;//SQ_ALU_CLK_CTRL<br>
&nbsp;#define SQ_ALU_CLK_CTRL__FORCE_WGP_ON_SA0__SHIFT&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define SQ_ALU_CLK_CTRL__FORCE_WGP_ON_SA1__SHIFT&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DD4F96D59EEB09E59278F7419BL1PR12MB5144namp_--
