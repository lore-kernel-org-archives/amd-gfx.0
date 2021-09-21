Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1089AC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE99961168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE99961168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A366EA39;
	Tue, 21 Sep 2021 18:07:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649DF6EA1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRh6mXkoVi+H4bHUSytdoigYCdf2ocZKIbCoRtDrt4GPmLsKs363JMRCBWYcfpvTYwlvX5Kr4TYZdHFcX+2W9qaeG5kljLIuqBPwKFYY6T9Tfzc4glH2UHrH7wFnlvZ+UQk3vk312I3CPfY9zLB1/AI2X7jJ2RDkOkH4mtY5K0MWkR2RchbIglO61NHzf15efAZcOdvG0ayiSJHHzwmelVm6VetnJ5ZubPv3X+5BvF1gz8cGLfBA2vz9nyDs13JaFidAcfJNj0iq+j3b5CtruYUVX+DMzmGgxYSu/DDcJTktv1/42TQWcLwjTToyz1M9cVJTPqlHBuS3pJWsLZijrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UnUVgtQ1KAZSYwjUiZd3UZWE91MBW9pSoM71JbCeKZU=;
 b=Kl33OjKJF7NdOuPWwz6F6a6ApBCGt5AR4M7N49QsDaHoXzWFXgWG6MatGL7uK+plcg5YFnhnryCv+AATSm7cfTN+XRiuzfaEGOhYF7hCigWsOqRGXwqjFizJ0eiEJQ7GfBIZ9ZnLziREbtLW/9cXJb/NH8wT2F9zfkSsxw027o8X44z/+oFvYu08VFB497xMn31PI12K2c2++Obk/gKmalhoSAOceVcpQ00nWP1lL7UwliNOh5ktFMHFWEezh3FMJOTo767TDNJ1MdSM9L9lPDP33Hk1IIN9S6aXETqfFk5qz/Ljp//BR+/taKTkqXl/ccCNskegi7m/trddk8iLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnUVgtQ1KAZSYwjUiZd3UZWE91MBW9pSoM71JbCeKZU=;
 b=2NqCAgAkzsKt+9lkPo+IBo6oPULosix7TdGpPdSTsE6PrWQ8jarTDtfXO0aXUMMgDIlmjazw78qjoB1CGpSBRwRC19LbvGMBCuPn0Hj9x7ygCVqSXpUynsXvfNXVMMHffsMARjr1lEXbAH+oKGPlwAWaZ5qw/HrDe6biLXIM36w=
Received: from DM5PR11CA0001.namprd11.prod.outlook.com (2603:10b6:3:115::11)
 by CH0PR12MB5090.namprd12.prod.outlook.com (2603:10b6:610:bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 18:07:41 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::88) by DM5PR11CA0001.outlook.office365.com
 (2603:10b6:3:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/66] drm/amdgpu: store HW IP versions in the driver structure
Date: Tue, 21 Sep 2021 14:06:22 -0400
Message-ID: <20210921180725.1985552-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1e8f58f-8227-414b-22d7-08d97d2ab466
X-MS-TrafficTypeDiagnostic: CH0PR12MB5090:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5090800A369C8C805858327CF7A19@CH0PR12MB5090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hto65U7uz1vmvQq/UB2Q/Rcb7LrlTbHMjvIRmootCQltMPs/YLQhjXFihoqc6Rvdq8Al7wXcQHkceG8LxnAtJtIJCQ/ByWddxEF6RpESR/r+e15WJqWpe0baN6stH4bIijcJfd/NQ4mTv7LP0rYSYwCGostZoEwE7RUbs1vm0LaOtlO2i7rv1IoCSmIJyjpGgmWpqpCfuqMwr6VlXLoGyxb4GlIUW+yl2DLvUYqf11S9wXdeLCJI+wm36E7lv7vDSknkAbVOj/bBM+NjLRssY2BOrpDdbSPuUfJiv0DW3kC27NnKhBh7dCCUoifwM6+zzXgVzcog1AXtdAILrW9q0V8NdLCzHhDirCp5do7W7VJNQRtEz8iGOGQWRKkxRVakClXiAo6nX3WqaDHcy1MjIGuuEIwGMYs4fAMHN+VqLeZMaNfYwTM3N2SaTnUbsCTv8e3xJyDBmxP8QXJ8Y76LvA3c1d7AX+fikParcKKpHOLHv0jd4fPlKobU6uLCHYwXGxR034Y2WYkJNa659bUflLT9qXGhCDaavKXI3Kq9E9Z6p93+PXC4ybcKNs48WJ80O73tcz73eg/A7qSFBl2WiBaIj7HaNwEEamG99QKIcg20zl2qhXLJAULbHhm9P252MffeneY1oepf58FA6jsIAo7zBBinyCFH+P4m+PiGTNzpnZJYyyXOgH7PFFJdPNp1qQJPa2fzKdB6YP6M38982uIiLrOdwSwbeiA6rt7cbUk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(86362001)(8936002)(2906002)(6666004)(8676002)(508600001)(4326008)(26005)(70206006)(70586007)(356005)(6916009)(7696005)(47076005)(5660300002)(426003)(316002)(186003)(16526019)(81166007)(36756003)(336012)(82310400003)(2616005)(36860700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:41.7527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e8f58f-8227-414b-22d7-08d97d2ab466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5090
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

So we can check the IP versions directly rather than using
asic type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cdb963b9bea0..61ef0d81a957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -760,6 +760,9 @@ enum amd_hw_ip_block_type {
 
 #define HWIP_MAX_INSTANCE	10
 
+#define HW_ID_MAX		300
+#define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
+
 struct amd_powerplay {
 	void *pp_handle;
 	const struct amd_pm_funcs *pp_funcs;
@@ -1090,6 +1093,7 @@ struct amdgpu_device {
 	struct pci_saved_state          *pci_state;
 
 	struct amdgpu_reset_control     *reset_cntl;
+	uint32_t                        ip_versions[HW_ID_MAX];
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f55613611a02..67e7a46f5020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -30,7 +30,6 @@
 #define mmMM_INDEX		0x0
 #define mmMM_INDEX_HI		0x6
 #define mmMM_DATA		0x1
-#define HW_ID_MAX		300
 
 static const char *hw_id_names[HW_ID_MAX] = {
 	[MP1_HWID]		= "MP1",
-- 
2.31.1

