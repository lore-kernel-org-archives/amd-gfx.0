Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B35DC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 06:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD7660F5C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 06:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFD7660F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BB9898F3;
	Tue, 17 Aug 2021 06:35:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A4D898F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 06:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtNL51sk8Wu7OJ9gNmviHGlKpR3uqdJzvjMLuCVNV8TVs+v4WNookN8u6GDQLeZ1dHj9KVTeERG9jkIj+xvvRT5Ou0Tlo8E87XlG3Vj3880zdZZCqUyqlY/TcG74XN9FhjsjtucEI6ZUPCPspIjFiSaKmbwh+vwmZy+ZneBkSsEUv6y1OogEanDNkfr4gWBmgNaebPzRdQsZMjoGACwBs2ZY8jNcV9fFApUepnO1j44HQQ/u6J0JFTrFdNrAe4U6ouJXhkpO+h3nAcoP9sbx2ejySedneA47IOX2mQiXqqHZ8VTqH7vCi5oTPiNkxBZD4OJpTsA3ztXdixjpWCYlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK2MRYLRp8q4uAREdQwS4vRBPyRjYYy8q5cmh8QLRzg=;
 b=TGd6HMdN9KSaXJT0gSlOPOX/hmnYSgJQmK2RIJ05E7i9C9kyuicvInpEUhnQ+QAQb/VQ5nVx34hKB5IL0rLYUNgZQ69R370B+A1US7640KjLA3DfNMiBCZBpMKYg7QozouCfeVRsXjGwx1rFT42IcontMuTKBZoczqHTlmot3VqF4aalHrsOWmCfEfxGYX7FFiieMCu/jCWRDMUa8NCtvc74u+gb607IdljRfZwV0QeN8p1NiD8+YmjxRDz8LvVFGJfOFCyXF0MdDlLkhHkja3Sxyu/OE3JPij/mvsbg3bRea6OQCzgSsikfcTh6rUXXPJ4YVr2lSxQobeicspityQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK2MRYLRp8q4uAREdQwS4vRBPyRjYYy8q5cmh8QLRzg=;
 b=h3sywuB0eSYZZnwG8vw8K7Z6jnHF0em7Zkk5z0JHSsks1O9NL5FY6zAwvE5bhgusIFSNQLL0RnZSizEuszPi0ueTx1ECjgpErUHrQP69VDqi98DHtarIyb2ZnGiMDFhrmFMCeKLYVMcq05A5rIY1PNIDSfrMN8exDqt6caxWfFE=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 06:35:32 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::acc6:c407:1353:6a]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::acc6:c407:1353:6a%5]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 06:35:32 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH] Revert "drm/scheduler: Avoid accessing freed bad job."
Thread-Topic: [PATCH] Revert "drm/scheduler: Avoid accessing freed bad job."
Thread-Index: AQHXkyBiYRo5uIbBpEGAPf+DxfIA2qt3PckA
Date: Tue, 17 Aug 2021 06:35:32 +0000
Message-ID: <BL1PR12MB5269E15EB2922E205EFB894184FE9@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210817042815.1269454-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210817042815.1269454-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-17T06:35:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=71d7f93d-b426-4b9f-ac15-4778c47acf64;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28c800a9-81b1-48d5-c12a-08d961493675
x-ms-traffictypediagnostic: BL1PR12MB5349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB534919C3A876AE716BAFB4CF84FE9@BL1PR12MB5349.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bv266RJ2gBO3GEOxueUeH89SAXr/KLAZTP8/bpAsNimIyFsMua9rhxesv/C7o8ZOfNaEmWB9OXQCey2BsnJ7/bsGP6LuC43YOFBN8gv+nGq3pQ9XqQQqCmSQBbZysQf1khOTGPP8Pi/5pQWfYxnsYApBbrRWIZnUx6hp4R0NwSkKkKplbSb0bBNkv49sCjkCoWpiZz+L22uOXAaNrX4yGPRgM20bcWb2YcTbmWznvZYs5dK3/n7QyDLaeSdhzOpttYevwxqenzil/KIZBXHnl5KzZE3h/uIQwUhdhnetJCmgEgu97peIMAd5TE71eg2h+TTe6BQi7Y0dL9a248APMxwKkqtt0AuSWsQwMMAzAe/3Kv2725nweVyts5qRlkK9HY38JuWltuOUq7I9LzRU+W7eSYlcSNVn3vv+1kCsv5R5HQF+cmAfN8OOkgBCTbS7LMSd90mPx9U4r4t5RUBiEcCHB3JqBunJAMlq4ks8CS3kPpIHzksI008YGXiTK2Y09Z4yrbGMSFRiLMag2rKseS9MQ3gupoWDjs2vfSKCBYwhl/NoIt6eOxJSuqEbuHxI9XsOETf7eXSQepS15w69EA7N80X1bmZkXOIMn4gfFwINTGzpNGwIG6wVa+nibUgnS7TJzqevk3XCWP/x82qMvEZQnjG29izLMYeOaSmo094SpZy0LINCUCZr3EoDGcpaElNRHKa4NmcEUPz1xUtGLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(52536014)(33656002)(186003)(26005)(8676002)(4326008)(55016002)(86362001)(53546011)(6506007)(9686003)(7696005)(66476007)(5660300002)(71200400001)(76116006)(2906002)(66946007)(478600001)(66556008)(8936002)(38070700005)(54906003)(122000001)(110136005)(38100700002)(64756008)(66446008)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YCI2ZHYYL5314AjBoO6hppZq6J3M/7PiMfZHRfqaQH+E07i20mGud6NqqUrs?=
 =?us-ascii?Q?0hk3ik1T8NKCTg7q0sPrn3bs2dCwAY8nAt8vDFCe0Qfv9QgmS/o6BU586M0b?=
 =?us-ascii?Q?dpxt3hyjyJFQe9qxjrVBv005l5vMiQCls63/vlSHpUYk1zFWDF0fhYHT+OtK?=
 =?us-ascii?Q?O0OFmjvyBq6Xd9t76zvM0f+kGd2fuPqoL1RXPP7gzIQOWlpSrXq4HXfSh094?=
 =?us-ascii?Q?6WVuojgCrFQTphTiP1JSvV/XKoopr2gnsMKGKEnQg0i5K/Ut5Y12lzOSpjbd?=
 =?us-ascii?Q?WCkQFhE+VCZV/M7oK0H/XWpmin/mKZEr6snVkz2yFB5W5kW8revmKPDSDKjK?=
 =?us-ascii?Q?VDwE7ExcONv6wcaxIEb+1txLp6NrhUyHIx3mZi9LEHpWJFD9t8TkPBj4wxnx?=
 =?us-ascii?Q?L+27tFlk1f9dXrv3xXbhhpJA3ybDVzZAomTJ/t7xtEXxipFuKK0EeDfe22/z?=
 =?us-ascii?Q?SWKM9TbbqEPj+/xVyGbrabFlBeGsTQDdrZO+5TjQl7wkA0p5UKgeBfv2z62Q?=
 =?us-ascii?Q?cJciOIBMH4J+Ko7QEU8S0XeIWXaj9j30gg5HyhhZDmtEA2tiU/MwSluq+RHn?=
 =?us-ascii?Q?cyKb6F5CegUTQDuFGwV5S8StjcDkjwZ2f8ZI5RQDt4suq+lm5ckh2hOJnf6P?=
 =?us-ascii?Q?w9KPNP3EHam4L+SJDIrjGFUQuAIW9l7WsWAJNnZSb+S21Di9WYTFnzbz4Gh0?=
 =?us-ascii?Q?7DKNUjImq7QkhZgcCTNANPWDgotCUkeftc5VVa7prxLAaQb+Lf8tSXzbaeLm?=
 =?us-ascii?Q?g9x+N4Otvww4jhwVGsmtDkL1rk5KSXL6PncmV+HGkr8j8KxvzwggUy0pX1l7?=
 =?us-ascii?Q?rJxElC2hqwEmvNulAt6x7/qIL0KatSf/69B+agCOwElhUdGqolHa5LcouRVW?=
 =?us-ascii?Q?XYQNW7q46ZKZnj3z6CZpB45Ckpeu3G62xlFPeB4b+/IqU7lw02jTjDBuoUS9?=
 =?us-ascii?Q?MYOCDydbbV+bRJooQqt+R4GFluXJ4AivJ8yxmDOHjUNpKhb7CZo2ziK4NMR7?=
 =?us-ascii?Q?6UPUAvMGmuIiUoq8IwREypjK3V0WPsXFzFy5OvJMXFLBh9X+Q7OP7O26nUFH?=
 =?us-ascii?Q?eu0HNqoGVyNwkZEDL71c9cU02ZvmeGG1JIVFARnmNpSeOz9+acuYzYegnWrS?=
 =?us-ascii?Q?ScdCZZGtItHykVck8HL3oLX2Xv5Shkamme7iV/9Vw+6wCWb9XDqy8W5X20v5?=
 =?us-ascii?Q?dT6GM2ugAp/dC8JopXT/N1Mr1b9z6+zaLv7h1ji2rO5JA8m8ajRz1Kdh40bU?=
 =?us-ascii?Q?imknF03DumOV2UReuhEyIsC/FvPQOyL80RAX6U9exQnF5/4zA6Q8+MCoakxD?=
 =?us-ascii?Q?sZKJZVk/51sz4zT28P73Nqy2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c800a9-81b1-48d5-c12a-08d961493675
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 06:35:32.2007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLAUjNpTaAXStFBistkSQMiyb8EY3fKy2Sz8YXjyCe7pGeiqxHCDCsuPSfTjhvw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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

[AMD Official Use Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

Thanks=20

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com>=20
Sent: Tuesday, August 17, 2021 12:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.c=
om>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, JingWen <JingWen=
.Chen2@amd.com>
Subject: [PATCH] Revert "drm/scheduler: Avoid accessing freed bad job."

[Why]
for bailing job, this commit will delete it from pending list thus the bail=
ing job will never have a chance to be resubmitted even in advance tdr mode=
.

[How]
after embeded hw_fence into amdgpu_job is done, the race condition that thi=
s commit tries to work around is completely solved.So revert this commit.
This reverts commit 135517d3565b48f4def3b1b82008bc17eb5d1c90.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 27 --------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sched=
uler/sched_main.c
index a2a953693b45..31d1176d939f 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -317,21 +317,10 @@ static void drm_sched_job_timedout(struct work_struct=
 *work)
 	enum drm_gpu_sched_stat status =3D DRM_GPU_SCHED_STAT_NOMINAL;
=20
 	sched =3D container_of(work, struct drm_gpu_scheduler, work_tdr.work);
-
-	/* Protects against concurrent deletion in drm_sched_get_cleanup_job */
-	spin_lock(&sched->job_list_lock);
 	job =3D list_first_entry_or_null(&sched->pending_list,
 				       struct drm_sched_job, list);
=20
 	if (job) {
-		/*
-		 * Remove the bad job so it cannot be freed by concurrent
-		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->threa=
d
-		 * is parked at which point it's safe.
-		 */
-		list_del_init(&job->list);
-		spin_unlock(&sched->job_list_lock);
-
 		status =3D job->sched->ops->timedout_job(job);
=20
 		/*
@@ -342,8 +331,6 @@ static void drm_sched_job_timedout(struct work_struct *=
work)
 			job->sched->ops->free_job(job);
 			sched->free_guilty =3D false;
 		}
-	} else {
-		spin_unlock(&sched->job_list_lock);
 	}
=20
 	if (status !=3D DRM_GPU_SCHED_STAT_ENODEV) { @@ -392,20 +379,6 @@ void dr=
m_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
=20
 	kthread_park(sched->thread);
=20
-	/*
-	 * Reinsert back the bad job here - now it's safe as
-	 * drm_sched_get_cleanup_job cannot race against us and release the
-	 * bad job at this point - we parked (waited for) any in progress
-	 * (earlier) cleanups and drm_sched_get_cleanup_job will not be called
-	 * now until the scheduler thread is unparked.
-	 */
-	if (bad && bad->sched =3D=3D sched)
-		/*
-		 * Add at the head of the queue to reflect it was the earliest
-		 * job extracted.
-		 */
-		list_add(&bad->list, &sched->pending_list);
-
 	/*
 	 * Iterate the job list from later to  earlier one and either deactive
 	 * their HW callbacks or remove them from pending list if they already
--
2.25.1
