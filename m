Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C389C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 15:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE6B6135A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 15:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE6B6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3523D6E835;
	Mon, 26 Apr 2021 15:30:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 873886E524
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 15:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VznoD8QALEfuoLw4+oXYAA0LtOQDkV8uopFj0O7fwnB2mQts2lIY881yU9No1HB//4kPGEpuaGAxQ/O4+4K6t6rCZjFYXmpZkA3KaUvTaKo6DljfVsbItXn2kCsCilKHDrIgDHUAbUic3KV32AzUQnUtl7YCliW+1d2QtIpoHVtrMy7tsXauuKdGkBEyC1XmQRG3z/9K+MVp0a6ONOFNmtWtGn8FVjKW9bDnnG0DI2PoQTRJWAF+Rboi+mNndMSxpxUFYr+1blMCA1M43l69ZdMC3F0Qm3x+C4MmGJMUI9oPCcXoOYZ9cKfgPcmtvvix25yp6I57JhHAceqF0/UJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOkKfsJvnYyyb++A6YYyZG8R33m8kHD2qtZAOK9BJpM=;
 b=Hoyg6GrBy1MjH35d3VqCF4Tae+iAmU4HEIdx5RZI3gs3OxjnEGwBkI7cm/t4XvzdhHkhZqooRZJkfUkyD0Q6dsYM8jVWaq0CszzCtgX5HCn3msz4D1S80a3L9ZPs/nhoxe5r57WS9n9JGct8V2+eNtjP5XwHmsSlVOYjv/5kOZZeyexdmE/w0tCnbweIEE9cnRCNT25mW0/w0dZQUrjtLX/BlbKX2a72dhSaOZ5laUplMF4yCtbgctnCx0jb0cRHF2acfZ1vvn7LnqTHrhB6VdKqIFJXzlCzOuC2Rq7+wEqwfWYhfvFtOKgWCIT4MVFZVjvWClpzrBEm78NReU13DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOkKfsJvnYyyb++A6YYyZG8R33m8kHD2qtZAOK9BJpM=;
 b=wNhTzd3YkdHPgDgx9lyXmztmNDp9rMUfq6IIZhJrY9MG5dxfE3Dwbx5raTggL8E+6t/X+V+hkAvKgiAn/nS8eelsPdg8Ek9xjmNdRpMezXFNCnhrxqKhKrOBOKUBRjXwV2MX4GIeRnxDuDfoo7HCxWBRnSthOkUjVZEl3Ref2Dk=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3069.namprd12.prod.outlook.com (2603:10b6:208:c4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 15:30:20 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::75c2:7212:60da:5248]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::75c2:7212:60da:5248%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 15:30:20 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Topic: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Index: AQHXOmUvyjEBx9i29EurKoBsWI5JTqrG7PqT
Date: Mon, 26 Apr 2021 15:30:20 +0000
Message-ID: <MN2PR12MB3022E9D72A4816C9A693F591A2429@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
In-Reply-To: <20210426062701.39732-1-Roy.Sun@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-26T15:30:19.689Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [112.65.12.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ced1bfc-53c7-4b13-d72c-08d908c833cb
x-ms-traffictypediagnostic: MN2PR12MB3069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3069FA95BD671A9F3D6CB0DFA2429@MN2PR12MB3069.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: arjKBSquhE2S4e8w7zd3QVcg5KcfQBijJqcLcAD9wrWSh0UoZCzHJN+tkKxIEBGMBE1RK9zVbxsvsn/lSGEHDjzPvSyv3JUtZFP01Z1wxBt/m851R2sNNnp3rzkUaU51nUr6LOgRJ0vn3uuEFRAjeRdGei0MwVIo0GtUFlExOBvOx/+21DiYVhVINsjc7r2bSfiAtdo8Km6LFmZhGRC9KoHpzLyZxMa3ZWDmlz3IqGAjtkz1NBDz0UJ96CHaMcpQ7O45BZ340VqjV1HSVtbQcE5Rh3YLCPW/GlKwWzO7Zqo+EDWEZBYNHsolZdGTC3uHsj/3o5x+UPU2JkYN4nijMvJrfCr2aMGRVCfVXfDHx7HJ0rOCm308rCUP4jk41bAdEMvMqPWIKbm/5/e6s4GKAhlqSdpZgHJrnciyBU/4f1xpNIny7ycfTL3NhThp8zOt0vx0/V/h9y+b+XlHP8KEEI+jiSA2r4oXq+Jh8WeeyZ7vjgz3laucJUIy++SNNe0Ci3eauwrvb7oxNgkCXsv0mhN2jM1HAdCkucxTj/Dhf3pwUVsTo4JCUfIXbMMCOdH3VzfobTiVuqi3MHGlSQT23mXtBAzuWPdCesBshoQ/ejtFUQvS+t1fCoyV0p9MeYbPhzrLEPyKp79Gx4yv8moOsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(86362001)(110136005)(19627405001)(8676002)(4326008)(52536014)(166002)(33656002)(66946007)(64756008)(66476007)(66556008)(91956017)(76116006)(316002)(2906002)(26005)(186003)(5660300002)(966005)(55016002)(45080400002)(66446008)(8936002)(71200400001)(38100700002)(478600001)(122000001)(83380400001)(7696005)(9686003)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9ORrHRSmSy/PwzTfCrl0UafA/1u8zTV/d1GYOITGogYf5mOhW/Aa4FEyaZ?=
 =?iso-8859-1?Q?2qVeZt8Sa3luSLNyDdfxh2l2TbkjbDfJzlq5nx/vPxQ3W8GEsFlZ2epUmH?=
 =?iso-8859-1?Q?2Oxzc5kO5WcPZoOnRFCc9AZ5WqXJ+yitBFylquqFQ5xMEWbrg2r9U8AK7H?=
 =?iso-8859-1?Q?ZEPvCvJxx43rCDd2iRaP6jhfMvViCUGyzs8xBu/WJDTaz7m7zGsL+jZZ5m?=
 =?iso-8859-1?Q?Qso4OISnPQxuBz/AESxcc28Kch0IDZGpaj5iyhAewXQChqHTISYhSBmWEl?=
 =?iso-8859-1?Q?lqskMPLTTQgz4HpRgESdW/w6Z0xcquYPLRZUF/rOZZZ3pFMAukeiKhEUrR?=
 =?iso-8859-1?Q?mRWXJQV7UokfeX3+nD8/e9642xcx6i9wvlERnG/bm6W32U6D0hCS3IfOVR?=
 =?iso-8859-1?Q?lLTO7aGKqVViZHC/sChgk5mouhywwh7PfB9wW3fj1/6qFgh1zgZhPMNhqh?=
 =?iso-8859-1?Q?nIWOpbPGim1c1Rbdj1suLosbd4EVOLLv6o2DhGZS0w37Jt4dkn6JvFcC1x?=
 =?iso-8859-1?Q?DQzQbB08wqwXcnwDXYfi+kei/We6Ewo0OaEDaB4QwXMEG3t/OwSVQiNebT?=
 =?iso-8859-1?Q?hZEmKZg5z0XwJeAjdZO4EH+WldjbcK17B2ncaHgGmq5PwnZrKlJYwIWcn2?=
 =?iso-8859-1?Q?4c9aT9R8jsgoV6TIMUAYMlSHFUC+PQIOmmDXlb3GApWm/0/i3LpzxMyNYz?=
 =?iso-8859-1?Q?nGlY2Geak3zWBDZYjaEZexwI3SHGv93nWpFGwZvWsZb66M6xzyNwXVrcPE?=
 =?iso-8859-1?Q?pN75ktvUvLyN42W1FnnFTuw6AUWZI8sW8p/HEGSebQK4/Hl8kKlSTEC3jn?=
 =?iso-8859-1?Q?jJrhk57q4HBACP8tJOporavv2HLtRSST9Uy1jB0uV3NYTTjChFO34jf/vG?=
 =?iso-8859-1?Q?j3m6AfPVr8ksJ3TrEiFUP7jdHkAYEusvw/PjyQQAinyptGkk/KN7nSfVD1?=
 =?iso-8859-1?Q?zVLZLL3Q0hxqgt9SGDnzZajuW/8TrgG95vstUZK4B7EW2c7xU+TCF7pDN/?=
 =?iso-8859-1?Q?P4n70hPLRJslYpkyOLHeEXIlE9CtPQWka4QgpFf0jpSbDHZV+mj31UIvlr?=
 =?iso-8859-1?Q?VfB6asU/GYzrWaRyUors0l0hvz3/Mn2a5zfg2CNvd32p4fSER0SQPwxXHZ?=
 =?iso-8859-1?Q?WsRkWxYPSV9Tsa12XibWsMiig/J0cUq5Bly6iIRL/zTuq7RvvH+vQ7euTZ?=
 =?iso-8859-1?Q?jaYi1E6tP4mgcKn+iAOeLbKBq7bf2gKL4YOGeGOqPR8cwOXMk4m1MUfPHU?=
 =?iso-8859-1?Q?+xoHN7c7TGAgLoVhXLlMo+NhWk0hIY7GSL68mJFMoL9zf+8DzH6Q31iH9E?=
 =?iso-8859-1?Q?CO9oPUjbBJl/8gXq2RukZ9f3P09F1uynQqoS7NsWtRbCH4k=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ced1bfc-53c7-4b13-d72c-08d908c833cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 15:30:20.4244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvLVeq6HDqoKfJ0BJDoJtEmSLIB4nYT+n1pDHmCCi4EWVYNaPCNxanjaRMdKuHcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
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
Content-Type: multipart/mixed; boundary="===============0063754366=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0063754366==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022E9D72A4816C9A693F591A2429MN2PR12MB3022namp_"

--_000_MN2PR12MB3022E9D72A4816C9A693F591A2429MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Roy Sun =
<Roy.Sun@amd.com>
Sent: Monday, April 26, 2021 2:27 PM
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
 drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sched=
uler/sched_main.c
index 92d8de24d0a1..f8e39ab0c41b 100644
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
@@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sc=
hed)
         if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
                 /* remove job from pending_list */
                 list_del_init(&job->list);
We just need to record the scheduled time of the next job. So we
need not to check the rest job.

[kevin]:
ok, it is fine for me with the timestamp flag check.
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

+               /* account for the next fence in the queue */
+               next =3D list_first_entry_or_null(&sched->pending_list,
+                               struct drm_sched_job, list);
+               if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
+                       &job->s_fence->finished.flags)) {
+                       next->s_fence->scheduled.timestamp =3D
+                               job->s_fence->finished.timestamp;
+               }
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
ang%40amd.com%7C0cebaf8d37e144c6b82108d9087c502e%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637550152295564379%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DHd=
iil9BC2sp2pUI1121yZWELoCQqhDqTnbr7E9oVutw%3D&amp;reserved=3D0

--_000_MN2PR12MB3022E9D72A4816C9A693F591A2429MN2PR12MB3022namp_
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
<b>Sent:</b> Monday, April 26, 2021 2:27 PM<br>
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
&nbsp;drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--<br>
&nbsp;1 file changed, 10 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sched=
uler/sched_main.c<br>
index 92d8de24d0a1..f8e39ab0c41b 100644<br>
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
@@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sc=
hed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job &amp;&amp; dma_fen=
ce_is_signaled(&amp;job-&gt;s_fence-&gt;finished)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* remove job from pending_list */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_del_init(&amp;job-&gt;list);<br>
We just need to record the scheduled time of the next job. So we <br>
need not to check the rest job.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">ok, it is fine for me with the timestamp flag chec=
k.</div>
<div class=3D"PlainText">Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt=
;</div>
<div class=3D"PlainText"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* account for the next fence in the queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; next =3D list_first_entry_or_null(&amp;sched-&gt;pending_list,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (next &amp;&amp; test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;job-&gt;s_f=
ence-&gt;finished.flags)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next-&gt;s_fence=
-&gt;scheduled.timestamp =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;s_fence-&gt;finished.timestamp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
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
7C01%7CKevin1.Wang%40amd.com%7C0cebaf8d37e144c6b82108d9087c502e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637550152295564379%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DHdiil9BC2sp2pUI1121yZWELoCQqhDqTnbr7E9oVutw%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C0cebaf8d37e144c6b82108d9087c502e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637550152295564379%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DHdiil9BC2sp2pUI1121yZWELoCQqhDqTnbr7E9oVutw%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3022E9D72A4816C9A693F591A2429MN2PR12MB3022namp_--

--===============0063754366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0063754366==--
