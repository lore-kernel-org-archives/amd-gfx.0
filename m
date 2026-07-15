Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E6FC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 15:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7A910E1EB;
	Wed, 15 Jul 2026 15:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZBafg8pb";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C97A10E1EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 15:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNl9/fwkXjbY3Lkhw0zopwGDsf4KoMDwN1uhVdHJE62U5UR0+GSODoeUeGXa1ETpXCYi6YH65z8r069uNtq2OJNNyzFbjS/t0wQ5rA9Dik87tQWSUYwebil+1f4aB2HNac9ojasCGvKh3krpDN5BBHPoAdsdvyRRY9LJPDWDlNQXwz1c9xFofy5TorW1QY5Fpc66kZwK26P+scikOqL2Jp+ncoJ/GW5815NLG1gXo0IaEnZjknTcihEtaUG3WxVGbdsmk7bCXF/yjDbSv0I01W3gOInwliLa9eUnk4gpY+QFQ6KJBjoj3wjNL1Ppm0LDanaivhCSpViSaXSj/hPdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU9gIlPrlEoBZnX2oNzjsMtE4PW3yDIXrQiqEo9yexc=;
 b=seKIAwhsgvssgeG3CbeLjZZ7IcaEukQkNl6ddptEzutFCNL+UptwG0XzCWNCD+KPhxbO+FUBC2IftdgVm5ujs1nElFJk0fan7pwdrjZY1yQQ1GyPguF81jICjqdhRZrMz2J1r66qHGmqzSxB80RwtITzLx8/vMPSJxLqu9N4g0DT0ZW8jrycJ+Oyw8rf9vqE163O0q2XHJKy+IztYbMV5+lMQnN7I2R+BC//qnRDEhcp5hCXQZFFQvZm+Qfa3VtgXrbVasXu6wBA8XsP7vBbK+venUSS7XYWtLb/rKm1wkUszS6Zmft19MSHnSQzWQmFnJWK8plizfgy83pMeTValA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU9gIlPrlEoBZnX2oNzjsMtE4PW3yDIXrQiqEo9yexc=;
 b=ZBafg8pbGDJ+Thi+IBFz6ZK0fbktYi20BjO0fdG/3lhYxWa15NaiLXVgVsHuDBsXjczxiTJdV/XKhqOO1dJ7r0IRzsv9mIwo31+wg1hdPRkXfu6Ay1DTYw+AZYw/6gHnXHu9lv2Ok0L4ZCru2a36/V4FWuCc/sH+mt2Y3O8/UEA=
Received: from PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 by DS2PR12MB9590.namprd12.prod.outlook.com (2603:10b6:8:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 15:38:30 +0000
Received: from PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0]) by PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 15:38:30 +0000
From: "McRae, Geoffrey" <Geoffrey.McRae@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN"
 <IVAN.LIPSKI@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei"
 <PingLei.Lin@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH 68/70] drm/amd/display: Flush IRQ workqueue in
 schedule-work tests
Thread-Topic: [PATCH 68/70] drm/amd/display: Flush IRQ workqueue in
 schedule-work tests
Thread-Index: AQHdFGDdag6rvc59TkG75a2ev7GTorZutyZt
Date: Wed, 15 Jul 2026 15:38:30 +0000
Message-ID: <PH7PR12MB55957BD71E419434887E774488F82@PH7PR12MB5595.namprd12.prod.outlook.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
 <20260715134432.1975118-69-Wayne.Lin@amd.com>
In-Reply-To: <20260715134432.1975118-69-Wayne.Lin@amd.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T15:39:21.169Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5595:EE_|DS2PR12MB9590:EE_
x-ms-office365-filtering-correlation-id: ed21fe2e-a74a-4f9f-0679-08dee2871f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: loycjbXPecSfHbAJNUc0NoLe4JhTKFTipyBKdkHaYYlSwaWV1vTTlz8Kchajg3gq2cfeIrK3K4YIJ5VEIvyDcrpWq6W5OX6frW0q5rdVmwqwFTGJ8U2+Or9zzLRuoMpayYuXHY60Vso8DXxaphInw3oSrM5IDLStV3zAT4/P1P/bf6fqqGGFIdIvvrlCNVIyK13AYNYJbKmn3NDgPjSsCxMCvXuwqmtwJJzzgb2U6JRDflgB+8mE2b4oP7SqKQYZiEcee/7eO2Vi2ID8FJ6q3hiwzLdTknkfWPXVLwIPliHDjVG1pBfKqG2WxfJSpzbFon33kh4Vi466zUBqRNVB3yP+wb5mFrUmoBsfoZWsWLFrSv9RmnqLYeElDs9M++f/VYLVdzJfV8UPoaDNL/BoH276dri8yNZwsrXW3VU8y5bP+nflZNorgrv3oxPQBIYRisg4mycz0rqhbJ1l5uTCAigzHFaZ/qEkczbbIQoGAJZMRL1Re1Bdqcm2ip3JuezA0tjmBfBKt+uhulAbNRquYcj7elARRa+U7e/wwl5BTUoa8vgbvDwLsANocvPpgQSHUGFzK6p9Q42YI5fMc2OWmVqwhTI2vRKriFaWKEiGBAWtTaPijEu6p78WxSq2DACWXepJ8IHdNyUApOPd5ISeqilGBIJuxWrDytUSvXEhdSTJqwPt4UU4oFZTZl4czhsAtBZb3TuR+4Aj05ZjF7bFZUuM+yIoKv2MBiOHxMQrBhA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5595.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0+Esq3bYVGaF5UqGZmVQ8gtWbzv641RhPwAdPh5WFHOXfu3dfrFNZ0xNgs?=
 =?iso-8859-1?Q?E+/TX6LI8fcksrmkotjwv7JeKTwcFJM471QR0L8kmUAWCX0tyCRov4fiUe?=
 =?iso-8859-1?Q?xdp5sCtTlv6VcNfPHj/dG6OU11DPopyhCqXR4ZyCR8aWK4Ue/kGwJx8S8z?=
 =?iso-8859-1?Q?r5MoE0Vrfl7jBXuvlaZBq/+WOCwME8AoCfCpey5Kr8Y7sj0K7krQyw71vd?=
 =?iso-8859-1?Q?awo6EsGR62Orl33B9UrFU6sFxSvpWpPdV5fVZTQrrU+m806VFK3u4hS1kK?=
 =?iso-8859-1?Q?LnMffiRu3sfD1kqAtrbsb2b6w3l6tFmAhIXZsEXU1rfTZYtjhLlO+Klfj7?=
 =?iso-8859-1?Q?i1EFTMvSqyq15TIz0dBil66nYEn319+rEi61rEYFWVwp6o+umMPosDwz4B?=
 =?iso-8859-1?Q?vx2N2SqY2MF46+QG6/Q1tomRN78CJzECbUWtN3x3XwDRXqn6INjn4yxL/h?=
 =?iso-8859-1?Q?VDzE3vVAlcWy69lXYR20yhiQhK/0RRMWtSTGROpRMsaRV4p/eC/xj+NB5W?=
 =?iso-8859-1?Q?F9OnZfK/PgH3xtQFQC7TNiq5+V3Y0AaYBE4P70QEvwmUItTpRGuDTs+fsC?=
 =?iso-8859-1?Q?FGCZwhN6D5i7cySHvkNrJyXMMqhVvC7JdIEoryhxHe24UGKNFWbO3djSK6?=
 =?iso-8859-1?Q?bRGuAbAEonk3QBe9w6fZRdHrZRlbbwXTNxXZb10knOfSq88MICDxxzcVLX?=
 =?iso-8859-1?Q?u3vuS8ZrmQJvbi1ECCUR+wwg1KKbguksBsIL+ByGAPxD3fyDNt9H2mf+GR?=
 =?iso-8859-1?Q?Zp5jKc5q6yECR6RstLMjOzc6Qv+zsoIzyzCnaIFtCl71v1JiyLWMIFnCnN?=
 =?iso-8859-1?Q?rKTlPd6xGAvd7chauliYVqxCQwlYvnDH8ic3ZFcoBPkPdMAZVsqmXZmFXM?=
 =?iso-8859-1?Q?VJx70v/v2P5mT0poYT3MKeR8jucH7UaNt7xueGl0WUMlL7JvWLrFBTKctE?=
 =?iso-8859-1?Q?DUnGoa7r/rSzMFVZUDwZ5gF+8ES7yYv0tz975Tnl7JId6yHU9klU5/sVBj?=
 =?iso-8859-1?Q?oNwUvrqVAZfVCVNJZo4ul67atjniNURb53gnt7xvR6K0X5jd9im4LuQAqn?=
 =?iso-8859-1?Q?6fSCpr79qqixeVBHPrftMpG9uiFjr90vdUEBHMXzFHNJuAhU6xdb62rL9Q?=
 =?iso-8859-1?Q?86ardb+ttWcxobknY4WKhbet9jcbcHxZZxfBnsjM3aJ/4J56TNLMbeR0Do?=
 =?iso-8859-1?Q?5yL+Bx5NSsXTYUiSETbrOie4slqChAaENETAWDlWWYGyckbR5lCrnZAvwa?=
 =?iso-8859-1?Q?UPycE5fcrSECnXtUvWmAiCBengPgv2FQDAdnfyiYZjB9Qg1DIrbDV+nMnX?=
 =?iso-8859-1?Q?uC5C/Ai7wgPqzayCZbk2oCVWGnMWzEj5983jgICQLbussmlkKptZlFzTA6?=
 =?iso-8859-1?Q?QDkM3wqSzv27P4b0cmX4lR0X9oNAopj7XcFVKfXYgqcrYsv8MSqSkdw8Wv?=
 =?iso-8859-1?Q?C5cfVUX9v/4CYSvkDm3+MJqaucoZ/cfpq/h9uV/SIHNf1n/UZTGEUfBkus?=
 =?iso-8859-1?Q?AH7oCjov9vVO5nFqFWjOPgDhceY0xLE2Gt+pQPYStIpWqeEGt1n8OITr5k?=
 =?iso-8859-1?Q?oGB/IK3ql2wKBzNC8/9ZSWt6XMEWW4+MPp170hzxbUl3cvcuBUuWBWY9z5?=
 =?iso-8859-1?Q?kuWwox2v3ITjiGqJt+e5/3gMhSpDW//FnUgxa8ipELisDpONuJWrlnwT44?=
 =?iso-8859-1?Q?TWf7VKS6cBhzgMQgMPT5o8O0jKqM/hhp+CydEWtHRQ1FZ79iE86R+nmq1B?=
 =?iso-8859-1?Q?MdSb7BXRSiMZt02OjnypY1+QQ992OmqljuJAq/as5NUQuC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5595.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed21fe2e-a74a-4f9f-0679-08dee2871f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 15:38:30.2186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5CVGeMgn8uIGBtu2zD1Z5CPDFpOdSZe88nsdAbZwrdZU3AxrjBYLdHM4axQ+Z54X211gWDsgA0HXzMYx5KDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9590
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

LGTM=0A=
=0A=
________________________________________=0A=
From: Wayne Lin <Wayne.Lin@amd.com>=0A=
Sent: Wednesday, 15 July 2026 11:38 PM=0A=
To: amd-gfx@lists.freedesktop.org=0A=
Cc: Wentland, Harry; Li, Sun peng (Leo); Pillai, Aurabindo; Li, Roman; Lin,=
 Wayne; Chung, ChiaHsuan (Tom); Zuo, Jerry; Wheeler, Daniel; Wu, Ray; LIPSK=
I, IVAN; Hung, Alex; Lin, Ping Lei; Chen, Chen-Yu; McRae, Geoffrey; Lakha, =
Bhawanpreet=0A=
Subject: [PATCH 68/70] drm/amd/display: Flush IRQ workqueue in schedule-wor=
k tests=0A=
=0A=
From: Alex Hung <alex.hung@amd.com>=0A=
=0A=
[WHAT]=0A=
The tests dm_test_irq_schedule_work_queues_handler,=0A=
dm_test_irq_schedule_work_requeue_fallback, and=0A=
dm_test_irq_handler_dispatches_work relied on amdgpu_dm_irq_fini()=0A=
running each pending low-context work item before freeing the=0A=
handlers, and only checked the handler counts afterwards.=0A=
=0A=
amdgpu_dm_irq_fini() now cancels pending work with=0A=
cancel_work_sync() instead of flushing it, so work that has not yet=0A=
started never runs and the counts stay below the expected values,=0A=
failing the tests.=0A=
=0A=
Flush the private DM IRQ workqueue (adev->dm.irq_wq) so the=0A=
scheduled handlers complete, check the counts, then tear down.=0A=
Flushing this driver-owned workqueue is allowed, unlike the=0A=
system-wide workqueues.=0A=
=0A=
Fixes: 258df8e4f860 ("drm/amd/display: Fix DM IRQ teardown races")=0A=
Cc: Geoffrey McRae <geoffrey.mcrae@amd.com>=0A=
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>=0A=
Signed-off-by: Alex Hung <alex.hung@amd.com>=0A=
Signed-off-by: Wayne Lin <wayne.lin@amd.com>=0A=
---=0A=
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 31 +++++++++++++------=0A=
 1 file changed, 22 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test=
.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c=0A=
index ed20e278742d..dc7ef0523b8f 100644=0A=
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c=0A=
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c=0A=
@@ -1842,12 +1842,15 @@ static void dm_test_irq_schedule_work_queues_handle=
r(struct kunit *test)=0A=
        amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);=0A=
=0A=
        /*=0A=
-        * Low-context work runs asynchronously on system_highpri_wq.=0A=
-        * amdgpu_dm_irq_fini() flushes each pending work item before freei=
ng=0A=
-        * the handlers, so the handler is guaranteed to have run afterward=
s.=0A=
+        * Low-context work runs asynchronously on the DM IRQ workqueue.=0A=
+        * Flush it so the handler completes before we check the count;=0A=
+        * amdgpu_dm_irq_fini() cancels (rather than runs) any work that is=
=0A=
+        * still pending, so the flush must happen first.=0A=
         */=0A=
-       amdgpu_dm_irq_fini(adev);=0A=
+       flush_workqueue(adev->dm.irq_wq);=0A=
        KUNIT_EXPECT_EQ(test, count, 1);=0A=
+=0A=
+       amdgpu_dm_irq_fini(adev);=0A=
 }=0A=
=0A=
 /**=0A=
@@ -1858,7 +1861,7 @@ static void dm_test_irq_schedule_work_queues_handler(=
struct kunit *test)=0A=
  * schedule before the work has run makes queue_work() fail for the=0A=
  * still-pending item, forcing amdgpu_dm_irq_schedule_work() into the fall=
back=0A=
  * that allocates and queues a fresh handler copy. Both work items run whe=
n=0A=
- * amdgpu_dm_irq_fini() flushes the queue, so the handler fires twice.=0A=
+ * the DM IRQ workqueue is flushed, so the handler fires twice.=0A=
  */=0A=
 static void dm_test_irq_schedule_work_requeue_fallback(struct kunit *test)=
=0A=
 {=0A=
@@ -1880,8 +1883,15 @@ static void dm_test_irq_schedule_work_requeue_fallba=
ck(struct kunit *test)=0A=
        amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);=0A=
        amdgpu_dm_irq_schedule_work(adev, DC_IRQ_SOURCE_HPD1);=0A=
=0A=
-       amdgpu_dm_irq_fini(adev);=0A=
+       /*=0A=
+        * Flush the DM IRQ workqueue so both work items run before we chec=
k=0A=
+        * the count; amdgpu_dm_irq_fini() would cancel any still-pending w=
ork=0A=
+        * instead of running it.=0A=
+        */=0A=
+       flush_workqueue(adev->dm.irq_wq);=0A=
        KUNIT_EXPECT_EQ(test, count, 2);=0A=
+=0A=
+       amdgpu_dm_irq_fini(adev);=0A=
 }=0A=
=0A=
 /* Tests for amdgpu_dm_set_hpd_irq_state() */=0A=
@@ -3855,11 +3865,14 @@ static void dm_test_irq_handler_dispatches_work(str=
uct kunit *test)=0A=
        KUNIT_EXPECT_EQ(test, high_count, 1);=0A=
=0A=
        /*=0A=
-        * Low-context work runs asynchronously; amdgpu_dm_irq_fini() flush=
es=0A=
-        * each pending work item before freeing, so it has run afterwards.=
=0A=
+        * Low-context work runs asynchronously; flush the DM IRQ workqueue=
 so=0A=
+        * it completes before we check the count. amdgpu_dm_irq_fini() can=
cels=0A=
+        * any still-pending work rather than running it.=0A=
         */=0A=
-       amdgpu_dm_irq_fini(adev);=0A=
+       flush_workqueue(adev->dm.irq_wq);=0A=
        KUNIT_EXPECT_EQ(test, low_count, 1);=0A=
+=0A=
+       amdgpu_dm_irq_fini(adev);=0A=
 }=0A=
=0A=
 /* Tests for dm_handle_vmin_vmax_update() */=0A=
--=0A=
2.43.0=0A=
=0A=
