Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C1C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE17613B6
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE17613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7246E0CC;
	Fri, 23 Apr 2021 11:09:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09566E0CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 11:09:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pkm9QsM5b+8KMEbK85WcDfSQAWUtBLl6pbd2RQflxBxXaJBhJ4sWh1NQPb/mQBCvM7RA85hQW2WjGgkqxL4enYFA5gZhC+1EGsGEURcVT3SL97xJSA7PiWyfX8mp9HWaitzAd9TxsLu2u2u5HhO2FvTAHK9fBK4TQ9RxAyOBIbAAaD8Ic7N7pZFzmh5vSW9hjAlRgqD1Y+yyXc5ccqn+C8ee2+a4CqhYKZ0KjrwafCuRjec9iGlg/KeIDN+jLjoTfrcObIySgBopRt42SvTP87y7pjsXzJ5U6dwDS7c3FOweOL/06WWhaWMlcPZlUj6tH8XMjQSj28b/C0/pVkGqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV7nVvdkVzGzWKv0ROzJbmgnltfoFqmqkLPDqgMrKys=;
 b=THT42M8bXkYJT+2zbNaBWSJllFHn1WlhG9g6cRHAE7u53NR8KYLN050nwfZPF4rWoFAtxX+24ltrrdHpI479msirOZCBEDga0b6w4OygXVyeEms30u5RNwq5dXI2y/Jc4nWaXuvvPqQ64TIAzL/8fCY3/pIZ4DFeGCFb5AuTlcFGHJbQH3WUd3X2xE0RB+AMq+Likrqtq34yzhH4JPg2tsvDmRoON/9atU9cuyfwz47tF0TZfjiBQz59+DaeZYheOQBDGJoIo5P9yuPUugQa8QO8O2QeQUh/z75Cn51m/DAKWScSHOHa9inR3417zL9VsYGb4x0grCLERWylaMMg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV7nVvdkVzGzWKv0ROzJbmgnltfoFqmqkLPDqgMrKys=;
 b=M7us3C/deO5FuwNSjG5QSAuwBoQOfBzrNT1wTvz6k5Z3vMKuXkP+NMfQ7SIIrEgDdoJqMhJnHjIQ6Dg2wRGhYgA+xdxfLw+K/HlLMPs3Kl5Cu72jrCz+HPe/Rvqvouo8BsBADyBq41wKlNR8MjQTVFn3cFhYE+AzCOjfWYfbIxA=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 11:09:04 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::75c2:7212:60da:5248]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::75c2:7212:60da:5248%4]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 11:09:04 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Topic: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Index: AQHXOC8pjkLMv9HcwEau2sHXxB7DSqrB8KXa
Date: Fri, 23 Apr 2021 11:09:03 +0000
Message-ID: <MN2PR12MB3022A43906DFF746D9F77A39A2459@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210423105509.23025-1-Roy.Sun@amd.com>
In-Reply-To: <20210423105509.23025-1-Roy.Sun@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-23T11:09:03.149Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5db17b71-8e22-4a23-d377-08d9064834b5
x-ms-traffictypediagnostic: MN2PR12MB3293:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32930050C05EBC5154D39B13A2459@MN2PR12MB3293.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kX8slgbYXJqrrhCmplvSjEkm2/0Oq81jbWallafQVWTXbFfbCjbdu1qx0BSpjLEMA5BH0zY0P1R9KC6qpLNI8249Q4vsljdFsRctugIP3iI8J3Z9T2ogSsbZuoslpS+xABEKU4ssW9ug6TE4OGJfXKkyiu3TFnGd3zIskXVpMtjV42iv9A2qj6/EX4tQYPBf4VJgXx4ZBR0QWAiMEj6PKGAAJTC4fLL999v/W9sqcTRC15XymbxnTO077sMLJfffHFtigEyM5FlpxBX6/Tb12R3UW2oHqTqcqHqrzF5EAxiMJT8m4t1K8W2B55o3NI5uBl5kOUhRxSlXdHHuBAE5NF4S5mri+o9lRXl2xEcnzrHtPS1L/C+9vNpzigzHDphPRGF3sm0IpK0GM5NuE486pArMcFhyKvd8jhmcpIjzaVO+vraltsHWHszoSH9tVXw6QzgPh0vrvi/UqOmG4KgkBJiC4PHoC2vTrqlNFh5U5kCcBq/13oq1uNJrwpaNKKJz1z2kRREJrhs76Ocbp2nZZsF4+Yu/8LnfZ7L/aANclITryfcW87UsXb2tgyatsPB6mcqu1XtxXtOzeZSNnF72y8ZGBi8wzuNMSPxRrLq30heWbCCFhiTb6euJQLxZ6BI3Qe0YC6cLjQIuS0UGLReXKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(9686003)(86362001)(19627405001)(122000001)(55016002)(2906002)(186003)(26005)(66556008)(966005)(66446008)(66946007)(8676002)(71200400001)(66476007)(478600001)(316002)(7696005)(166002)(64756008)(76116006)(110136005)(4326008)(91956017)(45080400002)(52536014)(38100700002)(8936002)(6506007)(83380400001)(53546011)(33656002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?mcfS/hRhX1ln/3keq4eVorE5SXurjrVF7QfYe/g8UOe/KpLunpTk2ZZjvV?=
 =?iso-8859-1?Q?WYpf2sn500Ybi4WuhProB8sG3o2NSGdYTm5DjFO7Tauxs8UfKaTE64ANMc?=
 =?iso-8859-1?Q?EbHPz8jGI/LYy2tnwe3YIgfpW3t1vqzZEFc90yvXshYR1VTH+xwYpB7jEU?=
 =?iso-8859-1?Q?JsRWJy/IJxDVl7otklO5KIB/F8MJm2EvU8xHFKdDLZYnKr71lKRf2juqdN?=
 =?iso-8859-1?Q?2dm7aZzuosOu/+xSyX2eSfoA25IM4B3W/ivWJhvF8kFSeLNRdu9b5qFaKv?=
 =?iso-8859-1?Q?VRBeyj1It/nww2rEAfg510nCq3DMiodTh2jt7PxsO0A6fZat8+2bjaOs2C?=
 =?iso-8859-1?Q?1g2lR2vTn2jEjej7HHtK20jDB6JGzxGGQ097WlomUteeqd9jEJ3aNIXhWe?=
 =?iso-8859-1?Q?yRVVm7h2QeFiGKx47o/In5slBkOWVBKTrdTclAbMdcF9LXTWiW0aVZy3cC?=
 =?iso-8859-1?Q?THOkZWKdmtcOyhVX2Ct/2W1MA9thg4Mqc1HDaxMfQYGNZiVOxNP7Klr48N?=
 =?iso-8859-1?Q?emyOV6+4wmPO453VL3JVRz7HxA1TDieGuenGgEa2vGrwRkr/NnHX2th6xS?=
 =?iso-8859-1?Q?vwDoMdlabo0Gwalk1h6omRrVlp0FK4SUTJqHh5ta4vxXDIEkkJxmW2uN7W?=
 =?iso-8859-1?Q?jn3wUN1UjZxNveTmIbZIojtUQHyaik5lZeOf4rhAVihXTsxCctZP9WrvQL?=
 =?iso-8859-1?Q?Cecf/Ml2oLpK68taC5BinL2A6Au1DffBg6I+bX/Ir7Io8pG2Dl4VwUNMOh?=
 =?iso-8859-1?Q?y6G14SfJapIIFg8Nu5t+gFRSvHiKFBrwKinP355ujbEjNvDgnGX0+feLrJ?=
 =?iso-8859-1?Q?ujB0uovwgAdm9ltznOTzlNPd7V4LMy/wSA7P5W6Z+zOX78BS/1cpvBd4Or?=
 =?iso-8859-1?Q?eCeCTZhW+3NJI0LSSJ9mOLtQFFcmisMc0BXp+iquX5qVrPbx266e3oWUYW?=
 =?iso-8859-1?Q?uT+iSAukzxU5UD8OrThi5k9w3JJzdDOLUunrDHgXES7qUBKwOXMEwg50RF?=
 =?iso-8859-1?Q?M9SZ4Ry4rEw7TwkQMKOFlvgXRT8EkcLs7qcMyMx+rnRoQOY8yV6BwfYo9T?=
 =?iso-8859-1?Q?BaeKRakpiGlkT0bia4xBa08FmCjy3APN88JTPdF4+RIpG3zWCF+RbwzQwE?=
 =?iso-8859-1?Q?zOtDhxukoiY73vWjANwJqYPnyZwNFBKM5oVcXAGyBqKUe9KwetNEtmU7is?=
 =?iso-8859-1?Q?kkSC9af7mHub+a5e3Mqq+HGCWp36oDrHOdW3cUUdMVeZpVbELBVcy8R2ul?=
 =?iso-8859-1?Q?Jp8Tq+7aUB1P9RJiHb3eTSJTwhYilDdY8eS4i+EUWQDMD+U/6CW+vsWT0/?=
 =?iso-8859-1?Q?vLZ38MBjOp8Zsix9nAWN0F7FunwYETUAmoXXWFzIUa2Yh1H9A0c31wGawB?=
 =?iso-8859-1?Q?VLVUK5qnh/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db17b71-8e22-4a23-d377-08d9064834b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 11:09:03.9850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1/uuPF8ut2VOG5Dr9fxjTSonR8u7Ckimt7lzTOP2yHKUBG1A6s5QNuG64TEIns7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
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
Cc: "Nieto, David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============1888988787=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1888988787==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022A43906DFF746D9F77A39A2459MN2PR12MB3022namp_"

--_000_MN2PR12MB3022A43906DFF746D9F77A39A2459MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Roy Sun =
<Roy.Sun@amd.com>
Sent: Friday, April 23, 2021 6:55 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sun, Roy <Roy.Sun@amd.com>; Nieto, David M <David.Nieto@amd.com>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track

Update the timestamp of scheduled fence on HW
completion of the previous fences

This allow more accurate tracking of the fence
execution in HW

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sched=
uler/sched_main.c
index 92d8de24d0a1..dc05a20a8ef2 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *=
sched)
 EXPORT_SYMBOL(drm_sched_resubmit_jobs);

 /**
- * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs =
from mirror ring list
+ * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of jobs=
 from pending list
  *
  * @sched: scheduler instance
  * @max: job numbers to relaunch
@@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched=
)
 static struct drm_sched_job *
 drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 {
-       struct drm_sched_job *job;
+       struct drm_sched_job *job, *next;

         /*
          * Don't destroy jobs while the timeout worker is running  OR thre=
ad
@@ -690,6 +690,13 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sc=
hed)
         if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
                 /* remove job from pending_list */
                 list_del_init(&job->list);
+               /* account for the next fence in the queue */
+               next =3D list_first_entry_or_null(&sched->pending_list,
+                               struct drm_sched_job, list);
+               if (next) {
+                       next->s_fence->scheduled.timestamp =3D
+                               job->s_fence->finished.timestamp;
+               }

  1.  the timestamp maybe is invalid, we'd better check DMA_FENCE_FLAG_TIME=
STAMP_BIT before use it .
  2.  when hw_submission > 2, do we need to check rest jobs? not only next.

Thanks,
Kevin.

         } else {
                 job =3D NULL;
                 /* queue timeout for next job */
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C3ac81f3f5c0346115dce08d906464b5e%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637547721248267412%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DXZ=
TXlwgkQuEn%2BflY%2FOuUNUymOMjyOZ5lv7%2BiJR7Wjjk%3D&amp;reserved=3D0

--_000_MN2PR12MB3022A43906DFF746D9F77A39A2459MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Roy Sun &lt;Roy.Sun@amd.com&g=
t;<br>
<b>Sent:</b> Friday, April 23, 2021 6:55 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sun, Roy &lt;Roy.Sun@amd.com&gt;; Nieto, David M &lt;David.Nieto=
@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/scheduler: Change scheduled fence track</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Update the timestamp of scheduled fence on HW<br>
completion of the previous fences<br>
<br>
This allow more accurate tracking of the fence<br>
execution in HW<br>
<br>
Signed-off-by: David M Nieto &lt;david.nieto@amd.com&gt;<br>
Signed-off-by: Roy Sun &lt;Roy.Sun@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/scheduler/sched_main.c | 11 +++++++++--<br>
&nbsp;1 file changed, 9 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sched=
uler/sched_main.c<br>
index 92d8de24d0a1..dc05a20a8ef2 100644<br>
--- a/drivers/gpu/drm/scheduler/sched_main.c<br>
+++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
@@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *=
sched)<br>
&nbsp;EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&nbsp;<br>
&nbsp;/**<br>
- * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs =
from mirror ring list<br>
+ * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of jobs=
 from pending list<br>
&nbsp; *<br>
&nbsp; * @sched: scheduler instance<br>
&nbsp; * @max: job numbers to relaunch<br>
@@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched=
)<br>
&nbsp;static struct drm_sched_job *<br>
&nbsp;drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job, *next;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Don't destroy jobs=
 while the timeout worker is running&nbsp; OR thread<br>
@@ -690,6 +690,13 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sc=
hed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job &amp;&amp; dma_fen=
ce_is_signaled(&amp;job-&gt;s_fence-&gt;finished)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* remove job from pending_list */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_del_init(&amp;job-&gt;list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* account for the next fence in the queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; next =3D list_first_entry_or_null(&amp;sched-&gt;pending_list,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (next) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next-&gt;s_fence=
-&gt;scheduled.timestamp =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;s_fence-&gt;finished.timestamp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }</div>
<div class=3D"PlainText">
<div>
<ol>
<li><span>the timestamp maybe is invalid, we'd better check DMA_FENCE_FLAG_=
TIMESTAMP_BIT before use it .<br>
</span></li><li><span>when&nbsp;hw_submission &gt; 2, do we need to check r=
est jobs? not only next.</span></li></ol>
<div><span>Thanks,</span></div>
</div>
<div><span>Kevin.</span></div>
<div><span><br>
</span></div>
</div>
<div class=3D"PlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* queue timeout for next job */<br>
-- <br>
2.31.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C3ac81f3f5c0346115dce08d906464b5e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637547721248267412%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DXZTXlwgkQuEn%2BflY%2FOuUNUymOMjyOZ5lv7%2BiJR7Wjjk%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7CKevin1.Wang%40amd.com%7C3ac81f3f5c0346115dce08d906464b5e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637547721248267412%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DXZTXlwgkQuEn%2BflY%2FOuUNUymOMjyOZ5lv7%2BiJR7Wjjk%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022A43906DFF746D9F77A39A2459MN2PR12MB3022namp_--

--===============1888988787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1888988787==--
