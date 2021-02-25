Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D66C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 06:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6488B64E6C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 06:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6488B64E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD6A66EC3F;
	Thu, 25 Feb 2021 06:03:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0C16EC3F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 06:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCDbmnR6DvRcVEm6KW08oyzJZAm/Fpzf4C/frObHsjpM4jjHvTuqymRU/umc5S6WRZzyYsdYrlcBHQnlVtr5qsHoyT5NqrS9PwOEL8xLybKS0yjTY3c8ppVblPlRhCHOw8RoRK+StEIQN2ma0Gkf69lAetBV6OF/66hdWPHdgRHetXIJNbP/RX01jMyC32z0q6pz8cB19d4q0Pcbpkx6dlug2gh/sIV3lsHWwOzYlsnUCENrJjF7G5e5jyifZcJnfIS3ihXUnejXTKH5FGpTvDNbiRmy67xjhT3sZl8KGK6lpb2+/K35nMArhujFeJeyk8LX66BdwF6xLqw0gmJFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrZiuWZoOWsYdWvg2vBW8Zl1PfEsiUXTiV07ZY3nS+o=;
 b=KwNQtFomFVk95rf+qUh1l/Jr5rEsQA4THSUZKTfmwss4EqDU7z4sRCQECxMpvJcKqb5bh+NHoZ0uHwTw7D+HF2ONL5cnZBECndpsjSaJA7Y9j/6+KuYv24r8FmOdn/SsCrGMZlbClWHEZ54fIWODsUNVT+oCNyAey3prIjmPPOfK7j57C3lhffrkEHZCPxOj1RZKc9vKLdX8ARPHa9to7MazTT7vjaeAghaiS7UWIZ5zHYCcqbdkL00m7iV8Tr8LixUbY0H4V0/wqM5DwXOMBSRuANMEZmgaX0QX6O217u8UwOkNEbWdkcL68zZzHEbYbhSVXWaDXgJ+HANOXqTX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrZiuWZoOWsYdWvg2vBW8Zl1PfEsiUXTiV07ZY3nS+o=;
 b=3VJd7ya5ZiSjVeI4Md3gv4TwVG1p+y148SZA89d0My+dT6r0ztoxF/pS/I/6Reqjl3fQBSfkjphAqiDusc+dmCMfQLzH5fnMLucr5xtIUKbhcPU0hzRszjt5i5KkaCxoOWJs37BTjVYFm8zUjg13Bs3byWw/gO2ELQuuLSAXFXU=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 25 Feb
 2021 06:03:12 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290%10]) with mapi id 15.20.3868.033; Thu, 25 Feb
 2021 06:03:12 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm: add a flag to indicate job is resubmitted
Thread-Topic: [PATCH 1/2] drm: add a flag to indicate job is resubmitted
Thread-Index: AQHXCzcGPCZiwFQWyUGGiY2++fiIxKpoYSiA
Date: Thu, 25 Feb 2021 06:03:12 +0000
Message-ID: <DM5PR12MB1708AE4CA6F11EE8379AD20A849E9@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-25T06:03:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8be3dfd7-79d6-4b81-98ab-961a13e6c351;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2a40b8a-dc2f-4312-1b60-08d8d95308b6
x-ms-traffictypediagnostic: DM5PR12MB2357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23573DB69F186E7CF7E9671D849E9@DM5PR12MB2357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhSJ1j1vqJ4munPgA5rphSAHZitQxV+W5KCpx69OoNEnZoqVOoNeRPC6wYk6gMNMBREfY0RTKNMm+ZcqZCWfddn2glkS0PZtDZcfHwhCDNEdIzMq6vqIZw7j9cZGNkq/+X3ybdcmVqJfFlau08vvMSXQJwh4CHwJehiu/8AxfPBSJRdcRhp30627Q39KuvwIFMk8U37cY/9S0xUM+z8PCRSxR0e5WzIXzDd6hdrxYIIm0OTLYD3qQQhoUP+h2kt8iiaJtdza9FgbnjKFajW4sA80HWYPSC+xvLuc7fHloOdxwTSaaXxF4/DOWIxt2U3a32bXwMErwl7B6aijHUAorCxu1i9p/+vPeKGVRkXUblWGUUGTosE678v6h9b3W0Y+nilKOPP8vvIv76UoHq9efeBXtbgkiZCn6WW+l7utlqs1EL3NQUBFeG65AHSNFglpkb0cesReRy46+LWinaqO3csVh901VHaDsQrgAQidjto7kRcped/Vmf351lnHBb+uUDcDYQZaVQnkbOjxnwPFhg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(5660300002)(64756008)(52536014)(2906002)(66476007)(186003)(54906003)(83380400001)(66946007)(66556008)(71200400001)(76116006)(66446008)(9686003)(4326008)(53546011)(33656002)(6506007)(8676002)(110136005)(7696005)(8936002)(26005)(316002)(55016002)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?g/aGVbMOw8djSvANGPLdKCU8cV6202JfH9EW+b6P1AKT2ExLwWJiFcTRahQ3?=
 =?us-ascii?Q?3qRgAZJYJb1tVb6Q9/vlXti8rVfp+4leBq+fXQ/NfI4lU8QG+IFntOWSt5Lp?=
 =?us-ascii?Q?nDyrn0+Wq6om1bEMFKlcjWYR2zojyn/p6Sa7BJT9R9ffyrHWBqA1jXnPWxOX?=
 =?us-ascii?Q?AsYAm3E/MZakGQa2hPfWh15LU/AbYo9luuYo965I+GeUUNlO44L8wYC2AwJ2?=
 =?us-ascii?Q?L1TOjq5ErZ3S80dOx0ByH3N5F2XzkBFlD6pqldoqMK/GKcaFgGzWp7Y9zahK?=
 =?us-ascii?Q?vG6Wkra0KyODTk2w9avr9vgAy41u6qjXnADLuZmuA0s+lSksjvcvRRa+WUIX?=
 =?us-ascii?Q?kCuLr1tTbMo8qNikYF9rP/GyedWxv7b8A1lbPyAUup6B4IoVr8Fy49S5DqhD?=
 =?us-ascii?Q?Gwgf/kd2+ptQcF6BGn2xGxRgzjLeatGyfwFGO/mBDBddn/yGKzGRmhnpslo6?=
 =?us-ascii?Q?5dooHBkWOCwEC8cRIPws+S3ib5BZ2k87GS40mmhMBZqooseSmLBs9sVqhQem?=
 =?us-ascii?Q?ZAZdd8lHnfAEX73jim7xGuJ5FpxflrLC305UeWhb+xvJz4w/gqyDRS7x5kBt?=
 =?us-ascii?Q?xhLG0zbF/Vt7h8dWMVVCuAa4xoEjSX5eV9nFQuuk2Jf9YLc6XkabLmKaj7Rz?=
 =?us-ascii?Q?abXK3+ZOzmT7ewmoc25QROMT4ViRFA9j4C2fPUxdEQzm4nsohE3dt5070xS5?=
 =?us-ascii?Q?k99gKmmAyqznqueuX9/LiKqksj1gMO1XHT3nAf54fdBS+Q/0zmlBtpWNyLJG?=
 =?us-ascii?Q?c0+zaHb7JZ0bYMQ6cQsCOZRUJedov8y+/NogbZS5awbHdNMbo89iNmWVGoF8?=
 =?us-ascii?Q?NHILtF4GmOaQtXr8lModYl5hQdyPZZ1qaJuogvZg4PyFQfnfRO69qrdt/SWV?=
 =?us-ascii?Q?j/UKCi2J0OQY9g4Rd2bgWMpeIq/MhnyE2BjhsC7r0i6m9uN9eOfV+wHWnUZg?=
 =?us-ascii?Q?sMIT4tXzQNQKIM7C/bwalZKAflNwoNiiRLhC3jBUzvMcaGzIah0AkkckJtBH?=
 =?us-ascii?Q?R8+k6BtMbT1F/ux7dW6PTLgd1YdCFLB9XkpKXHZcfbIhUMgPQywa9Yc1u8FL?=
 =?us-ascii?Q?g2Or9Bnij3VloNOnWgiQUeBx3WAuclT1OC8LFdCYa+IxLQ6WE+CM79bIkudL?=
 =?us-ascii?Q?wbziFZU2FEocJMuMwYgvEKgpmGdMnt9DB1je86d9BW5mxlg22SpnnaWo5pPV?=
 =?us-ascii?Q?Q7sRBC2NbeapWr/xFJpBjqvDZYlS8TqFg0M8GW3iKbv83aqBttOmeeDzgVwu?=
 =?us-ascii?Q?e4PZSXoBfCOkBN04my9d3ICmp64VvMlkedbUeqemA08eyY35GsZMPZ30fOP1?=
 =?us-ascii?Q?hsjvbZEo9wXqfSkubzslHHwo?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a40b8a-dc2f-4312-1b60-08d8d95308b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 06:03:12.3590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJaiADteGwibJ2dMI9qafYAu7vHii/7iDOMc/drktL7o9AaIaTQmYyx3OjGUDMPU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Patches are fine by me,  reviewed by: Monk Liu <monk.liu@amd.com>

Still need Christian to take a look

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Thursday, February 25, 2021 1:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH 1/2] drm: add a flag to indicate job is resubmitted

Add a flag in drm_sched_job to indicate the job resubmit.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 ++
 include/drm/gpu_scheduler.h            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index da24c4e8b9fb..d59ac90f5081 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -517,6 +517,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 		if (found_guilty && s_job->s_fence->scheduled.context == guilty_context)
 			dma_fence_set_error(&s_fence->finished, -ECANCELED);
 
+		s_job->flags |= DRM_FLAG_RESUBMIT_JOB;
 		dma_fence_put(s_job->s_fence->parent);
 		fence = sched->ops->run_job(s_job);
 
@@ -565,6 +566,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 	if (!job->s_fence)
 		return -ENOMEM;
 	job->id = atomic64_inc_return(&sched->job_id_count);
+	job->flags = 0;
 
 	INIT_LIST_HEAD(&job->node);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h index 92436553fd6a..a22122f98c9c 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
+#define DRM_FLAG_RESUBMIT_JOB (1 << 0)
 
 struct drm_gpu_scheduler;
 struct drm_sched_rq;
@@ -198,6 +199,7 @@ struct drm_sched_job {
 	enum drm_sched_priority		s_priority;
 	struct drm_sched_entity  *entity;
 	struct dma_fence_cb		cb;
+	uint32_t			flags;
 };
 
 static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
