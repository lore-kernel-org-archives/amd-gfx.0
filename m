Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9289C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 15:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894A160F01
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 15:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 894A160F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2B36EDD5;
	Thu, 29 Jul 2021 15:38:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AB26E151
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 15:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/kmXryxSsTmM0fkf618zseC/rgU09oMzewAANL2etQpN1tsmVqtPytWbtXsPOVqlAA9kAmIsC7gsaxQGyFkUYsKkDmR0jf1zcRjQxldlNk8OlvNJ9AGwgqNGrRfMQcOZG9Ka07zCJ4E+sMQ/GLse7bz9wswapDlF6a0eSK1/JaM8kIEaM/4N0HTulvyH2ePhKr1ygPamb26mgVWW3cOm1+10p5OQEG2ZyLalgPV+u65uEeKjkfMVAs7jsWPgvRa28U+IpmeM0dL81NqVc1uQundNPo00b/iidetPtNjHAeg/V3VDeW52E0A8rEdX5dRP0AtDHeZypxtVAB5tIgi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYoAg+75S//IJgS5+wKi4nmiJpoGPJlW8Z9K79jBFrU=;
 b=h3xaRHb3om/yn5BVov+XenIoRa1GZZheHbsE1dRc1DdbRvCrZpgJLIdIqxiKlCnZKLiiTVTDXPQfJ0p5M6grlohdbHdoun+JF5W7PcfoP0GIRLmqCQo1EHVzOxwEe0wVG35fAtqrQ5Vo+IK+D1N9rCHh1nXcFyipY2wfoEvn1E0SEz5LlLZX1tNE+psObZu1RnfIiZ/eoYdGsnJbKBWDqMVnOnMGEnIXZWBWXotp6yai6Cf9pLQuF7eUNyy5cQ+vn5MicScx1LJa3ZSRXVg2hp8bvODhJURv0PR+JSgP+ozrL6chyqSM3VxoicPGvkFFwP6YKLBlDd0Rr4CH4Q1xkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYoAg+75S//IJgS5+wKi4nmiJpoGPJlW8Z9K79jBFrU=;
 b=uPfwmfKOXnQar/xqMeW4pb7PomNwwD5PnBisoGJO6OcNtvrOSFYuWaW+4ar5vclWcz+pFvgc3GUs5uCwIot2yfmsJCho5t9qYGGhyfPT4sSJ431RosovAI/EGsBUlq+vwdaeusGg/1KvX9pB13vuG7pQnVc49Fr+QCGWkZTX5ns=
Received: from MW4PR04CA0385.namprd04.prod.outlook.com (2603:10b6:303:81::30)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Thu, 29 Jul
 2021 15:38:24 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::b0) by MW4PR04CA0385.outlook.office365.com
 (2603:10b6:303:81::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Thu, 29 Jul 2021 15:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 15:38:23 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 10:38:22 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix channel_index table layout for Aldebaran
Date: Thu, 29 Jul 2021 11:37:58 -0400
Message-ID: <20210729153758.13662-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b9a71a4-a9b5-4e46-28c5-08d952a6e6d8
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB249090284B41B31615D1BA2CEEEB9@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJu1xDTGc/NjirKYCxr2nRP8xb5ed1s/KrRVbOAxpRntZFnNXSus3VfZD7COfDFJwJxHhUyBag7t7ciuoEblLIfag5DOy17EEAA/U71n1mo3XndC7BK83lR09pWEFt99+JHULUGg994DWQO3gEP6Oo6awwISW0HBVhaGZeOXfnrUEQOLXFZmDgPhngsg2+zJSN8O+oEHtqev0mL6WPAqp0xLBU9tHagWyalu/hc83ypp9GCMrYDr2ShDQwYO3Nt6BRI0Ng/sz+WRwEWaNPhXJ5mZS6ub53JdADQ/OEPiAeVTWXYzU1huVS1lf8rV+QYvyneQMXmaLoSjjuSFZLap6nAPmJbLJo1VwteSy+fDWdv46cIKlMMjUhpCclS2DE7s3y7gV8AfMbHFUCZIDomQcdbgAUaKjbWuG0fYWQjafvi3npqBoiigbSGRwHrHFm8UqSv4GXbrfIESldpDezKY3hnAv+ez50jqT/W/IfjHqZTLZWzTAuNQYBrUuyy9v8fdl/DRe/xjl+tWbUF3wCRCEuRsq0oJvcYiH+S1YXmux7PkN/JdQeyeDI3IpBmrKLQd0tOwf43Ta1Xi79QQCQSmEQclShKRIxO/P4z/ThHKRNdvHA2uTc59sNIBQxUoljK7glO5eRfaXga608SVYQduYcvkhsrh+Qq9Iq7wl+X32rYCKuCVU8dBAfCSfXcvFc2tTDPBucqdtteFDx1Eau4vjChLclD5NI95gZAmMlbT+JY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(316002)(7696005)(336012)(83380400001)(4326008)(8676002)(8936002)(26005)(5660300002)(1076003)(54906003)(86362001)(6916009)(44832011)(356005)(47076005)(36756003)(186003)(2616005)(81166007)(478600001)(16526019)(6666004)(426003)(82310400003)(36860700001)(82740400003)(70206006)(2906002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 15:38:23.8961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9a71a4-a9b5-4e46-28c5-08d952a6e6d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, john.clements@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the channel_index table layout to fetch the correct
channel_index when calculating physical address from
normalized address during page retirement.
Also, fix the number of UMC instances and number of channels
within each UMC instance for Aldebaran.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7cf653f9e9a7..097230b5e946 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1171,8 +1171,8 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		break;
 	case CHIP_ALDEBARAN:
 		adev->umc.max_ras_err_cnt_per_query = UMC_V6_7_TOTAL_CHANNEL_NUM;
-		adev->umc.channel_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
-		adev->umc.umc_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
+		adev->umc.channel_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
+		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_7_PER_CHANNEL_OFFSET;
 		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->umc.ras_funcs = &umc_v6_7_ras_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 7da12110425c..bb30336b1e8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -30,17 +30,17 @@
 
 const uint32_t
 	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] = {
-		{28, 12, 6, 22},	{19, 3, 9, 25},
-		{20, 4, 30, 14},	{11, 27, 1, 17},
-		{24, 8, 2, 18},		{15, 31, 5, 21},
-		{16, 0, 26, 10},	{7, 23, 29, 13}
+		{28, 20, 24, 16, 12, 4, 8, 0},
+		{6, 30, 2, 26, 22, 14, 18, 10},
+		{19, 11, 15, 7, 3, 27, 31, 23},
+		{9, 1, 5, 29, 25, 17, 21, 13}
 };
 const uint32_t
 	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] = {
-		{19, 3, 9, 25},		{28, 12, 6, 22},
-		{11, 27, 1, 17},	{20, 4, 30, 14},
-		{15, 31, 5, 21},	{24, 8, 2, 18},
-		{7, 23, 29, 13},	{16, 0, 26, 10}
+		{19, 11, 15, 7,	3, 27, 31, 23},
+		{9, 1, 5, 29, 25, 17, 21, 13},
+		{28, 20, 24, 16, 12, 4, 8, 0},
+		{6, 30, 2, 26, 22, 14, 18, 10},
 };
 
 static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 81b8f1844091..57f2557e7aca 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -36,9 +36,9 @@
 #define UMC_V6_7_INST_DIST	0x40000
 
 /* number of umc channel instance with memory map register access */
-#define UMC_V6_7_CHANNEL_INSTANCE_NUM		4
+#define UMC_V6_7_UMC_INSTANCE_NUM		4
 /* number of umc instance with memory map register access */
-#define UMC_V6_7_UMC_INSTANCE_NUM		8
+#define UMC_V6_7_CHANNEL_INSTANCE_NUM		8
 /* total channel instances in one umc block */
 #define UMC_V6_7_TOTAL_CHANNEL_NUM	(UMC_V6_7_CHANNEL_INSTANCE_NUM * UMC_V6_7_UMC_INSTANCE_NUM)
 /* UMC regiser per channel offset */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
