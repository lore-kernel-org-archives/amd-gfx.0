Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689FBC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26ECD64E81
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26ECD64E81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB54E89DFB;
	Mon, 15 Mar 2021 11:23:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CC989DFB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+taYgJctE4hw9HQjYotqgD89i0p0sbCIVFzQA7G3CeBh+aYJ+9MzhhFQPJA7nZiw2PvsppMDkjqyiN27esayXX0WjwrIbGDTWloSEkwy7rIuH9h1FInrM9pf9X6hipg20TO2WQwlIv20dY3rrQy8SsC19lNkJBn2FnWPPmUquwD2H+SIDoR4oHYq+18i+WSY/Ui3ldyVQ6ss8tNjQQpeJADZYYtqKoG89lMu2C9h+JUChhkSSdwMm8/J/43JS3FsNsjYr30N2QkAPk99tVUuwuA8WpS/nqTxpvyIFo/awrHITnX44HrEcWKgDTOUQX3IJo8oL9YYEHxGpxS+C+CeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsYTHPirZYc7QP9sknYoO66cV24Nkpaq6CLaYdaAXy4=;
 b=fRJLgVO+cjvE/5qD/1Bl7vGx/4EMmXhDPdDy1QdVEmUxc3SyUPdxQsA0aAUI2LrfEUF0N6+dAHuI2fgCiz9F/gFehm6kPIP75CECS7M6AVE42lV8rjVgjs9ZiFnzQjIcxx0JjrF/NkcFXSqVQOl9IA0h5yXDOkFIJJ7nUjgSzWo8mWMrWgGjj0bM8mBomtQS0pVIhNIPxFWF4+G6B7UbYjbqv6wMbTVQljZNVufVMQB3vhUAa+Usv//o8ngSc8EaQhpaZrkFp0rrmZRglpwefWFbT+HIEKg+vqKciqRmLUL++fDj8usO1vQBFpZAl5pztsRQ/g2/J+zFK7FnlPaGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsYTHPirZYc7QP9sknYoO66cV24Nkpaq6CLaYdaAXy4=;
 b=3hvHF4x04UmAJr+EJopPb2W2PUOW89StMceCCa9uCCvIRFhg4T0zbJYsF8i49CEkyOTuFRFkZnjgrawpHDNKJ2JRlAH/ERv1+4rUYwtXBMYjdYiggOHabdkEFwGBgsQZLE4p18Me1xgDPh3jlKbkpxK3YBqlRz4HOq3lsOO292s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:12 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:12 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/23] drm/amd/display: Fix secure display lock problems
Date: Mon, 15 Mar 2021 09:40:00 +0800
Message-Id: <20210315014010.16238-14-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af1590a8-000c-4f74-2cbf-08d8e7a4b80a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37406C70A4A4A3E6CAFEDE08976C9@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1wuEhLd0TEXRnsLRD33sKSKG6NtwSD1XtvZhilz1EkISb5UHu2+1K9eo99t6K5ytsvKDpSXh1QlkpP4OkJaMPSVYGHAL9/VhhOMiAPhypHdfHCqiG7SL61UAtumSZTBJlFNeE5iFNi46rpXylYaZiDsK2RXJg3TuJlV5dwADzkawSoSpoewjKiFQJHK4P/FZaAhobu0rPcIVVBZ+ytj30MfjuTyQ5qCIsx/uRYf6vkNQkN9vXBweS9gV20LA5A1BYtKPy+/accZ3NBMmyWdYzhSyuTbrGU092f5VFpq1UCNTrY/bbWQTk4zQFAVNE8tIhJzVE3xKPox92fJRwueuXFuLO2C7enf2ZJaPPZjzhe/eMY4McX+TYkn1xcpyfgOxTUWLJB3VKILtBcNsqtaYX8g21dlaDrhZhrFmfgXMZI1TeFR03xX9ZAXn6zv5Vo5q5xIQ2teYBFk1b+EA5ghjNDaiyfchsv4gkGWWyFWEHiWnXD7miM65NUy3vfnnmTARlRCrUeg/ABW5fgHIFptwPjrXAetjv9Xnp3Yv1CneuEnKcofRw1yt4NstmjItNxo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(6486002)(6512007)(36756003)(6506007)(86362001)(4326008)(66946007)(16526019)(6666004)(66476007)(66556008)(6916009)(26005)(8676002)(478600001)(956004)(5660300002)(54906003)(2906002)(316002)(83380400001)(44832011)(52116002)(1076003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DR11kZyhBY5r5agMWo1FiHU9csDLlxKzNGCfiggVxcS7WjOhAsLe6EiZ75jR?=
 =?us-ascii?Q?BFIVnluF+ioMKPhUao0ZcVeFG+fOqcXf6w65oe1Pc/ZQ/2a9+X1Iu2MqwzZ0?=
 =?us-ascii?Q?g0d/94q0FmDi2v/Ly1OT3gHyJ/9/VbMjtrkFvM9t7EXVSqUWLY/MXlHVUS86?=
 =?us-ascii?Q?KLikaUgPdiXIqktkamhi1lKfuUMuMJXDi8ZslJclTr4wNIThqBJahiO7eh0E?=
 =?us-ascii?Q?FGb7VRyG8eC9LUDBHeQ3bY1zqWeZcreF1UA0kuLOgdnuxbk5k7MaV6Phijwr?=
 =?us-ascii?Q?h+ONfxwJvjIEzE9sOt7IEmGV9XWhygd0DUjDXC1ZQn6tmAaRTSKP632EGk6B?=
 =?us-ascii?Q?QIcXKMF0g8quUwcbXDkNcPYPaqFORlq3E8F9rcagTUxXpzgDS3dBxS1FSo2W?=
 =?us-ascii?Q?aBJNLE8iUMZS/uRMNInTHwkZ1JwQp6il6juTIoO/vgrtlCov5SDdUTfq+Ae/?=
 =?us-ascii?Q?mBS+zRQxUQ+mYOWgp25YLqToKWjEz/omm8I+BgIjmyvNTNObQGHsbn8OhYxx?=
 =?us-ascii?Q?uFhTERNuG9Z0rnchr3fyFeGyJMB1NnNoaIJOpyTfn6vr57NzaMqbcfbbixVs?=
 =?us-ascii?Q?+TjQyOBUj+IFbhZm3jEwXlpCSVQKggFYdc0h2MH2GdvI/TgfnuDp/6Wz0quJ?=
 =?us-ascii?Q?JfqGmw4lFrLFwNf1F+Qav1M4Nu1AMwO5lF+ipjx7f7d+rvduWC+e6RgBT2Rn?=
 =?us-ascii?Q?Ft1qUocDJyWpeW9343T9ICMM2lnx0ZdUgCQbwZ8jcFowdYrCWd+o5tZVshgq?=
 =?us-ascii?Q?gXoxneel5ZV8y23OlHabBxQidAOhN0DMBU3OvmN1M5HzJ1HQf4XZTQ7+V8xW?=
 =?us-ascii?Q?brIIHkdeqQKNqVCvPhdwQzOY5f6DxmheNuXODn9ALd7rzrZV8XcNoMVmdIrT?=
 =?us-ascii?Q?LIUW7G8xDPdHOH+243NM4A2cR9s+ihPD4E+n5Fr3wjrux444JcCNl6YMpjA5?=
 =?us-ascii?Q?Jk8Y0KLlRIOPOepTFDSf9gr28cngfUJOfDVn8M1DQHyT0IkLtfYt2TMu2eIu?=
 =?us-ascii?Q?LMeo0obklQQcIrxzF/w5kVTWUFbG19JuGT9sLo2zTrvbSEaQ2PYqpXRadavj?=
 =?us-ascii?Q?sp1AzdDaAvV2IulMPXNcnkkage7mgF2e45tBJs8NZNSmu+LwwId9m2VgAtO0?=
 =?us-ascii?Q?WCJWF7ipe0ovO7e7aS/4e9EEqi8bMeyi4sQR1qfUyVWUZdwmuLlh9HKJy8Kc?=
 =?us-ascii?Q?wXIiswjIi9OjECWsvUUo7XSzuFKBbcH0gAlSigGOc6U3CjzM7kGsp4XDDyEb?=
 =?us-ascii?Q?onafR04+4V2rpndjwT+WLXBc4fIPMBUEAwp/61rjndQpGd6T99yvpvYxQnUO?=
 =?us-ascii?Q?S9m2Y3ngoVIM4OH5zgCU5H5C/mtm68tp0BlEnb+2RDMzuQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1590a8-000c-4f74-2cbf-08d8e7a4b80a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:12.3751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYG80HqkRJtizFP8QMZstTRwQDN4CmC9kM5QSsdMAlJJ4gTSnHM2qsAx65AdikyZsm4MTeeG1lFUVpUJh1+zgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <Solomon.Chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Find out few locks problems while doing secure display. They are
following few parts:

1. crc_rd_work_lock in amdgpu_dm_crtc_handle_crc_window_irq() should
also use spin_lock_irqsave instead of spin_lock_irq.

2. In crc_win_update_set(), crc_rd_work_lock should be grabbed after
obtaining lock event_lock. Otherwise, will cause deadlock by conflicting
the lock order in amdgpu_dm_crtc_handle_crc_window_irq()

3. flush_work() in crc_win_update_set() is no need and will cause
deadlock since amdgpu_dm_crtc_notify_ta_to_read() also tries to grab
lock crc_rd_work_lock.

[How]
Fix above problems.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Solomon Chiu <Solomon.Chiu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  | 10 +++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  6 ++----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 3adbaf50a558..c6d6baab106e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -433,7 +433,7 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	struct amdgpu_device *adev = NULL;
 	struct crc_rd_work *crc_rd_wrk = NULL;
 	struct crc_params *crc_window = NULL, tmp_window;
-	unsigned long flags;
+	unsigned long flags1, flags2;
 	struct crtc_position position;
 	uint32_t v_blank;
 	uint32_t v_back_porch;
@@ -447,7 +447,7 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	adev = drm_to_adev(crtc->dev);
 	drm_dev = crtc->dev;
 
-	spin_lock_irqsave(&drm_dev->event_lock, flags);
+	spin_lock_irqsave(&drm_dev->event_lock, flags1);
 	stream_state = acrtc->dm_irq_params.stream;
 	cur_crc_src = acrtc->dm_irq_params.crc_src;
 	timing_out = &stream_state->timing;
@@ -508,10 +508,10 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 				if (acrtc->dm_irq_params.crc_window.skip_frame_cnt == 0) {
 					if (adev->dm.crc_rd_wrk) {
 						crc_rd_wrk = adev->dm.crc_rd_wrk;
-						spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
+						spin_lock_irqsave(&crc_rd_wrk->crc_rd_work_lock, flags2);
 						crc_rd_wrk->phy_inst =
 							stream_state->link->link_enc_hw_inst;
-						spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
+						spin_unlock_irqrestore(&crc_rd_wrk->crc_rd_work_lock, flags2);
 						schedule_work(&crc_rd_wrk->notify_ta_work);
 					}
 				} else {
@@ -522,7 +522,7 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	}
 
 cleanup:
-	spin_unlock_irqrestore(&drm_dev->event_lock, flags);
+	spin_unlock_irqrestore(&drm_dev->event_lock, flags1);
 }
 
 void amdgpu_dm_crtc_secure_display_resume(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6d839d3fb6a3..b8644f49e0f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2695,14 +2695,12 @@ static int crc_win_update_set(void *data, u64 val)
 	struct crc_rd_work *crc_rd_wrk = adev->dm.crc_rd_wrk;
 
 	if (val) {
-		spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
 		spin_lock_irq(&adev_to_drm(adev)->event_lock);
+		spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
 		if (crc_rd_wrk && crc_rd_wrk->crtc) {
 			old_crtc = crc_rd_wrk->crtc;
 			old_acrtc = to_amdgpu_crtc(old_crtc);
-			flush_work(&adev->dm.crc_rd_wrk->notify_ta_work);
 		}
-
 		new_acrtc = to_amdgpu_crtc(new_crtc);
 
 		if (old_crtc && old_crtc != new_crtc) {
@@ -2720,8 +2718,8 @@ static int crc_win_update_set(void *data, u64 val)
 			new_acrtc->dm_irq_params.crc_window.skip_frame_cnt = 0;
 			crc_rd_wrk->crtc = new_crtc;
 		}
-		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
 		spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
+		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
 	}
 
 	return 0;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
