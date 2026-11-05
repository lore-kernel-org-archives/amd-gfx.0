Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4F606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rXdVwYAo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A3610E920;
	Thu,  5 Nov 2026 02:45:20 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478B310E924
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 02:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CczTnhB2DVMO6KRvMlES1LE14grT0TJ96Zfzh3h9rV4EjK1VfLPX2rg2AwbSjLILfAStD7Na7M98//xAOu26LmbmA+FMsew0hnn9mpaH4cfPAmb4E0oJKy2W5o1Y+zO5Z3kv8xd034dN52293wdXqNzjaPY3bx+kDTQLSrk2Ie4jUPnJuatGVHXB8G+Ns2wLRHYp3eriJX2ZPOdSBDLhGONAAshK7g06o0z/vsG/PocfE/TyhM3wYTNufUDw322pEexZYm2C+J3R5zmjchx4Jr3Yjm8w4yxTEnXTAyzCDo6uvUSuJEfo0/XsaTn8poe4V+eXAds+Ec1GZp2FxgBvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COo3TEkKtIWTXvf1Kp8wbkzs8ofqvcfSACmTmzuMQX4=;
 b=QVcCUGa/I2tT8/Yvf8ciO0hiNk7ro0KhphKiNShsXoLwY8LZNQdvmuzhw3BQNs7R9T4imGTDWv55RSdgKMBLjtPVngtUZPMDEudijGk+vUcEIj9WlbKKzi1PUuPkUcfDXaPXQf0TQRiPG7qBFWXwL4XoAdmlBkIHQm+LDiP0gtRk44+WvrKdqZnFsobDtpNL3pxmQgIDDLMafVi9bCGflCerr8wcBOQJjoNo+io9DJMNxByqupkwo3Sufs61UvVFgzNGJTyD+N9aH37TVhD3nFdgsTdUSJhy7bE/7L+YPOceb9TuAXu2ccyiseI+kSUb3O98uT9B0btpOfMDIrBeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COo3TEkKtIWTXvf1Kp8wbkzs8ofqvcfSACmTmzuMQX4=;
 b=rXdVwYAoj9DDvK5N35H3rG3eiO476IzHK1nXtvcBt3m41QGz2W/YY7UlrAlVpndzQMmFOUr3W5GYwL+P53BchuUkX31PGTGEOUo3RlQOX0pSrF8fiNWiFkBQP7tAZyqD2KVgg7cLdOVuf8xY2VjQ1aAtOM2LL1eiafc9MDBul8U=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 02:45:10 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 02:45:09 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdkfd: preempt the HWS runlist once in set_perfcount
Thread-Topic: [PATCH] drm/amdkfd: preempt the HWS runlist once in set_perfcount
Thread-Index: AQHdap4GDSY/aHEwmECGCAn4irRGyrceyghA
Date: Thu, 5 Nov 2026 02:45:09 +0000
Message-ID: <CY5PR12MB636907E3A719CA9B30FA12C8C1772@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20261102074418.2259176-1-perry.yuan@amd.com>
In-Reply-To: <20261102074418.2259176-1-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-05T02:45:03.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ0PR12MB5664:EE_
x-ms-office365-filtering-correlation-id: 3636e5ac-fcaa-4157-546e-08df3ae6cee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|22082099003|18002099003|38070700021|56012099006|11063799006|261021121427099003|261026121527099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003|261102123227099003|261022075727099003|261022105027099003;
x-microsoft-antispam-message-info: rcCqJOn7EHWPkHktPjL4ObtrBKV3V2mIUN3lbnyfcxoRd+k6ji6inJicNHoo3MPpFfJd/UH1jmBtc433lIXBXMt9rSi9kydcxXP5KX0Qbk0iJ29iXhngGZov4bym9awQjPkYJ0qmERDJ2xl+BZOLN1owPG4z+lXFrKDZ4nn/X/dqBfWqIXOrg+/QZT+FDX5t3daJNqG4OdGRfR/+2b+JhJ3lhiBDpz3e3LrMv/UEDio2UWHHLdYsWqDTqgtWOPocKTQOV2Im+w6dRM94RHQSIusKVaBxh+vvv0URqmqfiV6yNYESnPXIuTo8ypKncQiQ7IB3f84EDTZqEe+I8KwEEVsd/Mystl1196B8jrAgh8SyS/7EkX34ATJWSq9iRk0t7k8VpjrwDXZdg0F7QT5qe+/ANqZK1qdewoVKvSbEaDVEDFAdo/3ihH/3EAmWGs/0e0jgCXwh+aEnUIvooxrWNFZ+QAg8rUdMlJNzt1B+n4FDq3wlvLWzMDh/G+xzmBHgWYbU8r5ZDlhB26/HB76IZ4Yi7OD4u1gVlPR59DFfWXU+Mvua1nislwqjfF6GkSFkAGWdcT9rN85fN0yy50TUSijWCvMIBFx36zJeENUITKMyZ4CVJWsHA/7MZsrCQLJXhZwfuedClDQjEAQR2FWP7Ank4Zp9hC3qFF9kCYF9lNOANC7fNRGyVpBk0o0xivla2ItBRe2ZY24DjOjOO7clxlXhrAQnuKQrEZzXIvTcky0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261102123227099003)(261022075727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+PC+VdOX32jjF1naMskg9kKxkJXSph1cUG5jaVFz3y5fa5n72976sx2sPm9W?=
 =?us-ascii?Q?s2t7EUcR+sO2MtgTLtVjMGxvQZfPMOz2i9PS3XI+uKZkAc0OW6k9A4IkopYq?=
 =?us-ascii?Q?w96QCFn6po/UoAKfyQosYpLFONxcFyjS5OkdkzdbpyM20oc4IhZu/suSN9XX?=
 =?us-ascii?Q?Me2eX9+Lr02ZgUz50VpVMonA0Q2lk4M/nDnTB2WrzRQxR4iK1lF2+UcGFmUF?=
 =?us-ascii?Q?B1grapBJEsIts/mIH/MO/JduF6dnUTHOYA+a4dsH6tTFCRkX7EZ325vsaL1d?=
 =?us-ascii?Q?SoWc2EsHc0qHSSAy9kzfDKNiM3tzlJjGGVHmZZCnJnaaomn4mUNDjZQnsJsJ?=
 =?us-ascii?Q?TvXifeVUF6fAKTuFIdRFASDyKWVV8UMiG7l/fDyWdoss6HTCjQQg5MyI1KCg?=
 =?us-ascii?Q?3oUUm0Yq1Ht5H1oEp/aYRewg50JaG3zYh8j39MxrXHu9eDL6JVNqEBTuu20z?=
 =?us-ascii?Q?tdl9Ph+6j6DBS7l6ltSwiHAhqGtY4ZUMJvTq8A1O4fy3W9rf32C2XgF60/Y0?=
 =?us-ascii?Q?REX7vvTXvZcY0pP1A/LNO6NGWQguwylV/VtgwRlP97jHgMOInZZRqGEMV6TS?=
 =?us-ascii?Q?hOnkHTetlZiAVfvic4skErPgPBqy2rcJ7Z+C/QXXmzR7QXnRaC4YIi2u6off?=
 =?us-ascii?Q?9VA4ZGwI4L4UN4ajH88Jbhu+6UoT4T/KnjDF0wI8vHk2F45ujkkpJdcurk6p?=
 =?us-ascii?Q?0tFb8Kt4PqR4kddsmaoFl4L/M+U2HkLyvX65LGKdQqzZh1350kQeHrq0kxR9?=
 =?us-ascii?Q?jeAAcTW6bimZvGipCo6X1tBK6BBjt0uNd2FR9aODSHvMuP78Q7iPZdBaYngf?=
 =?us-ascii?Q?qscVc9+vebFaUW3AiilFx1naD4VQM64UlQywh+/rydkUIKwW4/AdB2jcS7bT?=
 =?us-ascii?Q?rvWxl8DvTp07rWWbswp5LanF0HSahrXoANglEmgo7qbWiGBvinGW2a3kKTj6?=
 =?us-ascii?Q?C5bf3WxdsZX+ai0iA9fEmYVqXOMti+W5kKF4GJ5DYm8SE1dXV71rLxkFR2Eu?=
 =?us-ascii?Q?tm44CP1DL8i4E6/VAAICAvq4HXAeqCiDULDQT8ZzMQTcpfW+n6USLMRqUtwc?=
 =?us-ascii?Q?p642PJHWHssIJZeygCTqohVklx1quiN2zIPt7On/DhdunHJ22jgdtCarxOrj?=
 =?us-ascii?Q?oG1XHuABEp9QNjc5BX9BlAzf5BGGismc/JJRLPAI2SRfHNz0+fH9hBsy8DL5?=
 =?us-ascii?Q?GE9ELsBy5UgwKqqXuv9omNaENMlVP8qS/iKDrQsNucMWILgAzjCiXVCTesse?=
 =?us-ascii?Q?aKe2jKJX7VUnUo9u9undXsSMCTKZwWJe2+shllBn7puN9CtDrNZOI8T9ncxk?=
 =?us-ascii?Q?T+7f5YniooIZ48jyeqQ0tvCU6esB/q4UGs10Fl1PyWN4O2xzuACAX86YmCDd?=
 =?us-ascii?Q?QkMPghebCF1OOQdC7agXS5ETK02tVU6gcgOY+fwD4H+5aeki1FhJnIYMK8ex?=
 =?us-ascii?Q?lXs0d5abkyUZF1eSGny9o/5S888R6rtUsz17L642LOnY5XlBPmIKcZBf6cJ+?=
 =?us-ascii?Q?KUyXmtoSJvX7qRQqet0YJnDZpMKsNtC/xKb8VqMQN6XtG/q+/DrLhnlRXr/Z?=
 =?us-ascii?Q?IF3ioFT+/ZBQFhKPWAKtGHE55X58mS5O3WBr8ZoEGDD9lgzQfLJxFE8eSNQt?=
 =?us-ascii?Q?u+N3p0bsLU2KBAHuEofG8FYwgNBQT4mfAMfwTknrvvWmTSgTIkdcl1L2aJkP?=
 =?us-ascii?Q?O56aSFE8uC8tapycZo8LXx+p9nw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3636e5ac-fcaa-4157-546e-08df3ae6cee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 02:45:09.7792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZR+i+2BmKK+DG39J5P2OxOu6pMAMF3uBtuMXrlaS+wiJ5HE5WVRAEJC+CT9FgtZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Monday, November 2, 2026 3:44 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Yuan, Perry <Perry.Yuan@a=
md.com>
Subject: [PATCH] drm/amdkfd: preempt the HWS runlist once in set_perfcount

On the non-MES HWS path, set_perfcount() calls update_queue_locked() for ev=
ery user queue. Each call unmaps and remaps all dynamic queues, so a single=
 perfcount toggle preempts the runlist once per user queue. This adds repea=
ted stalls to compute workloads during profiling setup and teardown.

Unmap the runlist once, update the compute MQDs, and map it once. Share the=
 MQD update and activity/GWS accounting logic with update_queue_locked() to=
 preserve queue counts. The MQD callback recomputes is_active, and a concur=
rent UPDATE_QUEUE caller can change queue properties before taking the DQM =
lock, so perfcount updates must still account for activity changes.

Skip processes marked with has_reset_queue after preemption, preserving the=
 existing update_queue_locked() guard. Remap after the batch even if the la=
st process was skipped. Keep the per-queue update path for MES and non-HWS =
scheduling.

Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profile=
r kernel driver changes")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 85 +++++++++++++------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f4fb99b599da..c9a303f536c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1093,6 +1093,41 @@ static int destroy_queue_nocpsch(struct device_queue=
_manager *dqm,
        return retval;
 }

+/* Caller must hold the DQM lock and ensure the queue is unmapped. */
+static void update_queue_mqd(struct device_queue_manager *dqm, struct queu=
e *q,
+                            struct qcm_process_device *qpd,
+                            struct mqd_update_info *minfo)
+{
+       struct mqd_manager *mqd_mgr =3D
+               dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.ty=
pe)];
+       bool prev_active =3D q->properties.is_active;
+
+       mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
+
+       /*
+        * Queue properties can change before the updater takes the DQM loc=
k,
+        * so even a perfcount update can change queue activity. Keep the
+        * counters used to build the runlist in sync with the updated stat=
e.
+        */
+       if (q->properties.is_active && !prev_active) {
+               increment_queue_count(dqm, qpd, q);
+       } else if (!q->properties.is_active && prev_active) {
+               decrement_queue_count(dqm, qpd, q);
+       } else if (q->gws && !q->properties.is_gws) {
+               if (q->properties.is_active) {
+                       dqm->gws_queue_count++;
+                       qpd->mapped_gws_queue =3D true;
+               }
+               q->properties.is_gws =3D true;
+       } else if (!q->gws && q->properties.is_gws) {
+               if (q->properties.is_active) {
+                       dqm->gws_queue_count--;
+                       qpd->mapped_gws_queue =3D false;
+               }
+               q->properties.is_gws =3D false;
+       }
+}
+
 static int update_queue_locked(struct device_queue_manager *dqm, struct qu=
eue *q,
                        struct mqd_update_info *minfo)
 {
@@ -1109,7 +1144,7 @@ static int update_queue_locked(struct device_queue_ma=
nager *dqm, struct queue *q
        mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
                        q->properties.type)];

-       /* Save previous activity state for counters */
+       /* Save the activity state for queue removal. */
        prev_active =3D q->properties.is_active;

        /* Make sure the queue is unmapped before updating the MQD */ @@ -1=
150,31 +1185,7 @@ static int update_queue_locked(struct device_queue_manage=
r *dqm, struct queue *q
                }
        }

-       mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
-
-       /*
-        * check active state vs. the previous state and modify
-        * counter accordingly. map_queues_cpsch uses the
-        * dqm->active_queue_count to determine whether a new runlist must =
be
-        * uploaded.
-        */
-       if (q->properties.is_active && !prev_active) {
-               increment_queue_count(dqm, &pdd->qpd, q);
-       } else if (!q->properties.is_active && prev_active) {
-               decrement_queue_count(dqm, &pdd->qpd, q);
-       } else if (q->gws && !q->properties.is_gws) {
-               if (q->properties.is_active) {
-                       dqm->gws_queue_count++;
-                       pdd->qpd.mapped_gws_queue =3D true;
-               }
-               q->properties.is_gws =3D true;
-       } else if (!q->gws && q->properties.is_gws) {
-               if (q->properties.is_active) {
-                       dqm->gws_queue_count--;
-                       pdd->qpd.mapped_gws_queue =3D false;
-               }
-               q->properties.is_gws =3D false;
-       }
+       update_queue_mqd(dqm, q, &pdd->qpd, minfo);

        if (dqm->sched_policy !=3D KFD_SCHED_POLICY_NO_HWS) {
                if (!dqm->dev->kfd->shared_resources.enable_mes)
@@ -1215,19 +1226,39 @@ static void set_perfcount(struct device_queue_manag=
er *dqm, int enable)
        struct qcm_process_device *qpd;
        struct queue *q;
        struct mqd_update_info minfo =3D { 0 };
+       bool batch;

        if (!dqm)
                return;

        minfo.update_flag =3D (enable =3D=3D 1 ? UPDATE_FLAG_PERFCOUNT_ENAB=
LE :
                                                 UPDATE_FLAG_PERFCOUNT_DISA=
BLE);
+       /* Preempt the non-MES HWS runlist once for all compute MQD updates=
. */
+       batch =3D dqm->sched_policy !=3D KFD_SCHED_POLICY_NO_HWS &&
+               !dqm->dev->kfd->shared_resources.enable_mes;
+
        dqm_lock(dqm);
+       if (batch && unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMI=
C_QUEUES,
+                                       0, USE_DEFAULT_GRACE_PERIOD, false)=
)
+               goto out;
+
        list_for_each_entry(cur, &dqm->queues, list) {
                qpd =3D cur->qpd;
+               if (batch && qpd_to_pdd(qpd)->has_reset_queue)
+                       continue;
                list_for_each_entry(q, &qpd->queues_list, list) {
-                       update_queue_locked(dqm, q, &minfo);
+                       if (!batch) {
+                               update_queue_locked(dqm, q, &minfo);
+                               continue;
+                       }
+                       if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUT=
E)
+                               update_queue_mqd(dqm, q, qpd, &minfo);
                }
        }
+
+       if (batch)
+               map_queues_cpsch(dqm);
+out:
        dqm_unlock(dqm);
 }

--
2.34.1

