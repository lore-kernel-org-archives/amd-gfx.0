Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61427C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5C3207DE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UhJqxHDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5C3207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BAB89CA2;
	Tue, 18 Aug 2020 13:10:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4539E89DA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 13:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9mbCXv4YDsCQor0ToXii3qKol5/e4a7XrzpKh/II/dElJ94O+ryLM3kZ4XiTNq41MkAVVIs9FddNgvGv0fOa+wdXZMt+PmVH5FgxXrze1qSoLZzEpto1aSyLM/QnQMyu+hi3Odz4SBElsZonuR8zPlDmeQJ6oatsejE+2HdZEoRELfOjwi8XdsOmVh249j2j1yCii8/E8VSLy+Jf85DgLbeP7EslTDeht+NjcNPulcDWwiX95YMvN+jYUjk2j+Wfnl8TKwtkPbzKBe3hAdGTsGbKuWDcU4I1l7/Tg06xUFT9BvwGjg+uPefxfIfMla9jW+8ZtfwshUkhXHT3/pn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTLJ2mHJxzEPaJ8oOOYyIYlT4mk6XjymsncxYLUzMGw=;
 b=MjWcYzuZdyOez0o/P5bIpBXx+PW98fglhX8RJy5NsnDboQiVWK6d/Umknli4GVjdmeRGxBJrFVBUviQ2ypMBMBacA4fiDTnsasEU7tyAl6OI7DzFQNbouvQw1m2cq9UWScYbfXQ6P6U4T5Ttjjk9uPce4L7npC0fLdggjFriJEDhkwuxOCgYEKmMkcIPfFXqMcCm6RhjbrLbT4EKWUoBkCUXGu116K37BURbixPMm7xqpllXITQ2S7BkuggXwrkGlyT3axZtExIDsla480BkYmvALERi8TXjgVdpmssHDQujmSD5NHSrXASBKtLWhJ68/vb2mz2FXoaHVg8Vbr59hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTLJ2mHJxzEPaJ8oOOYyIYlT4mk6XjymsncxYLUzMGw=;
 b=UhJqxHDqpK4oBWsrva+5UqdBylZtsNTTCfyssCkZVemhIRQILX37sO4LlKTIAvn6VK7l2JB659dL5IEoXIQk2l7pJPrsHQaeSiXo7pHe96WqilXay3AJOLCHYfDkUZjnRE7yMEVXwqwAW96volVj/Z/54HzmhH6OeYtePopq+Jc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 13:10:04 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 13:10:04 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/3] drm/amdkfd: remove iommu v2 for old apu series
Date: Tue, 18 Aug 2020 21:09:32 +0800
Message-Id: <20200818130932.180114-3-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818130932.180114-1-ray.huang@amd.com>
References: <20200818130932.180114-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR02CA0141.apcprd02.prod.outlook.com (2603:1096:202:16::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20 via Frontend Transport; Tue, 18 Aug 2020 13:10:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e08b7b5-131f-419c-0b30-08d843780572
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44086ECD1E67E59071D4C1F6EC5C0@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcoTmYDbFdjxyIWWpBR4trB5VsqqcLx40Ob+rHCQR0gckLmTPSYjSWpEMciaylOX87C5ffKvSGnqQBQ7t2hvQO9CqMnacdawiVqb1ffvjEPqR0bOl9da5KI4yZw/j5Bw0ZYD3Mc4ZklCwO69MoYFTcun4cYb5e8bddjjX1F7oNTD6UBLyEvGLPL1KGEjsz9YlR1hyn39RpkjkfOowKMMvudBmnjBUgPlvyxbKbxxX2yrjLIhC6uv2QWB8rgzfG9WnRhFIyRdiZg24PLogrLXJ6m9aF6bnDBXzk5clXXPgV6RzZOuk4/B83GzqvTXml+F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(4326008)(1076003)(54906003)(6666004)(66476007)(66556008)(7696005)(52116002)(66946007)(2906002)(86362001)(83380400001)(8936002)(6916009)(6486002)(8676002)(36756003)(5660300002)(316002)(478600001)(16526019)(2616005)(186003)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: I4lu1Zz1MePSwlifNg6h/irkHYiCaOnEG9I44osAE3ITEv1hBiZnAmZBNnQk7BaxbxNFjSZ9s+ETMJcjPZ+dD/DyBz3aEUb7LYSH4hfEZv6navku28fiO+rm6xezIi1s63vHUES0TfYZwzah4QegdkzLlifIsnz4RZL5s0Hm57lcfrszYr42LQudSgSN7aPJjWIFWUDNKVzJJpHhrlX4+ePY6bS6cMjOZOOk0WR0aH99HmvXbHuKGQqoBh8IcnXB1lPrW/SLxtmfMHOOloFskf/z0JLkiguvKnRhDmTAiSxQou7UZWRn2aeRHwHSLfoW2n+oRgFnckRPcaffJ+GAZALVZAEBF16/7KW6/ZzpnRYP7KCTkssLpOhnVxMO49IlWhOmWwzmM6eahNY4wgoRMPxTgLYoRPwiu36hb5N7y3JxGG0dRlKU3NtzYg53lGA9eI8LMdYXQNNIGbA/C0JpC0mn8cak/OGqelpM0gbi7ApigfBiGghQPBWLQWrX3jIvFzldlqmI+wOnX1hhz68LaEpMXcy0NWeqvRSQGVKLIhpvgGHo96GqjiohnxS2O2paUCuGDCFKqhdrmF52kizDRheRGC4SfFeKJ53o9enhXJadLYf5t+BeORkE3UqXHRDrjTz9LAmgrcLtKgh3of1EmA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e08b7b5-131f-419c-0b30-08d843780572
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 13:10:04.3369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFsd1JAC916Zu7bDpOvkP7QvpFqTqYZD7GqbyIX3LjG5MQb6WPsQ/ZR7Co8jXj1wzdk7okMmWElM+FqHkWXbDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We already support the fallback path, so it doesn't need IOMMU v2 flag
anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index dab44951c4d8..731f7fdfe9d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -48,13 +48,11 @@ extern const struct kfd2kgd_calls arcturus_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
 
 static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
-#ifdef KFD_SUPPORT_IOMMU_V2
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	[CHIP_KAVERI] = &gfx_v7_kfd2kgd,
 #endif
 	[CHIP_CARRIZO] = &gfx_v8_kfd2kgd,
 	[CHIP_RAVEN] = &gfx_v9_kfd2kgd,
-#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	[CHIP_HAWAII] = &gfx_v7_kfd2kgd,
 #endif
@@ -74,7 +72,6 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
 };
 
-#ifdef KFD_SUPPORT_IOMMU_V2
 static const struct kfd_device_info kaveri_device_info = {
 	.asic_family = CHIP_KAVERI,
 	.asic_name = "kaveri",
@@ -112,7 +109,6 @@ static const struct kfd_device_info carrizo_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
-#endif
 
 static const struct kfd_device_info raven_device_info = {
 	.asic_family = CHIP_RAVEN,
@@ -460,11 +456,9 @@ static const struct kfd_device_info navi14_device_info = {
 
 /* For each entry, [0] is regular and [1] is virtualisation device. */
 static const struct kfd_device_info *kfd_supported_devices[][2] = {
-#ifdef KFD_SUPPORT_IOMMU_V2
 	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
 	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
 	[CHIP_RAVEN] = {&raven_device_info, NULL},
-#endif
 	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
 	[CHIP_TONGA] = {&tonga_device_info, NULL},
 	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
