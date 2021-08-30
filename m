Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C41CC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 02:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B9160698
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 02:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52B9160698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CA889D7D;
	Mon, 30 Aug 2021 02:39:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B5B89D7D
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 02:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLPO0qPU1W9I2l/sh62SoAHiLsbTAA4J5MlWnsIme7GxnbAZghwp8f4uFEK1HVFiWaDvZ4vM2OQfsnyirMY82iRvOejjJT+aNapL2dZW3kZsPpmSx6Q2NxFjIHotQgzLHdZezsQ42rekvEUiPBOy2whMa/x4uwZSPP/lpNXJCc8AsUik9QQRfstxFLkx0aZfnBvXtnXHP7buExYdIaniUKLohn3m4u6wLOchBowdw9QeeZSIWOVngQ5TLlzC5zyyrxCtPJl5yt17sMYTwNrq+TSzCauoFwoZyMEOwyuicbl6n2hybmsjxIPApWvY6XY1mAkFV85AvrREEcI9K1vcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmQKe3MkyXB4flpCwABoaEzw90tr8DsWOYOmAtoVPdA=;
 b=WEN6x92BPHdIEqVm/MfFmTaHZ2OlDfcruqJLBjmmq1l6aw66iJ2LHYPJzDqw+MTbktRMQT60CFjpI4O3p0A6/8YwW0KMtrK29XB/JLfOB6DoCQKllxplfKSFAKEwbtnM780tCmqnz1Yu0tIUfV3s8hMk6z6FbhLrVfwM4KqnOAgWc6eJ/8CwtGRqiUw1Ogs10hW9ZpQT3s3UGv1zXr+3Sky6prPmspg8USnWWlUz2ia42PoEO3XF4mPSjqj4dKHF/jd3DAkJ4/YX9kAeuc70ZbxgtoOMKvZCFI6Xbo69LZAHa8HzQ3nX+++KgpDWKxYlwlprwk/XXkvddVN/hnE/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmQKe3MkyXB4flpCwABoaEzw90tr8DsWOYOmAtoVPdA=;
 b=1qR2FFfAIj/DTU2dU71harXEPiZTQuZW6uPRCZWHNx9NY1yaW1epTbjf/k1TalrMepqSg68yPTVYlDi5OiUwUbS5ZMBEqYBetUCCaTkgT+Qnj7Yyn3PtlN0n9DXkSEbDxYTNsXaqZPdVInRFQRh9Ua4/zN06tZmkx+yWf4oBswc=
Received: from MWHPR19CA0059.namprd19.prod.outlook.com (2603:10b6:300:94::21)
 by DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 02:39:41 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::a1) by MWHPR19CA0059.outlook.office365.com
 (2603:10b6:300:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Mon, 30 Aug 2021 02:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 02:39:40 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 29 Aug
 2021 21:39:38 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add mpio to ras block
Date: Mon, 30 Aug 2021 10:39:14 +0800
Message-ID: <20210830023914.13670-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78001e4-d78d-4d62-5fb6-08d96b5f6afd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34684F9D3768B7C0A820170091CB9@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8R1pt1P2G3JV+nrmZeVoV8k2yuiHZEp9HnoosnA9HuaXuDOWphUxkunJJKCuXosWOiUw5fAxR9V1cpBonZLIBKrbbRJweoYpTSKdnDsZXsLNeEi05x9sq3Ljgl6LEzpKPAuOmPkHc13XpBe6ZkpfUG6diaGze84tpjgA2KK2bLP7bqbjmAo/2tPHWTrhfYw2oFButVbLXgxt++fdu3pzTLOaIDXGgGDM2BxGCQUI4Y/lbvti3VDdoPNpewvxYT0+++xBbthk4u9WEVBydB5FZBJYSKdzCmQIOfGdCXkEXKVjIOJzwz4cZkM2ScwMiuLOvsNw37F01xEK+r/lv0oc/e2eU+c8cGs3VDluOUP8HYvDjf28n61GTVjzL0hM3Y0ZHUcM/0MLfXtjPG45Iyf947h9wVLecyw5lfob8s2FuBMmcznKtoL4ksinCmg70JM+zTihv50xT/RQOcFtAkgH9JJU7zZekGOc3/iH72dmWYGt/Wfrm0ZlW+qpczv5bPzMvf/RpjtT8HAT2CjVWZOBSCmPoynjAIjwIyIM5cgvFzDV9USkrbE/+UeMwxKUxlUqyZ+/AD7UBLT0CHQdpsLuqa9nKrPg6vQHgVdiHV1IQ0/p3uaf9PJp77lCQaeRFNfO8Mg6r0UDl2XXGgIW9mMCQ00sS11hX5BPT39FbPNTzBvXy2OaDyutPBmYiO3YeyB8YhWXU4QcivNkde+bDB7CbLbu1mNBNDES+2/FSIXwPH4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(47076005)(54906003)(2906002)(36860700001)(6666004)(336012)(6916009)(1076003)(7696005)(316002)(82310400003)(5660300002)(8936002)(8676002)(82740400003)(36756003)(70586007)(70206006)(86362001)(478600001)(83380400001)(26005)(356005)(186003)(426003)(16526019)(2616005)(81166007)(4326008)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 02:39:40.9031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78001e4-d78d-4d62-5fb6-08d96b5f6afd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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

Add MPIO to RAS block

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 96a8fd0ca1df31..77140821dc1126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -61,6 +61,7 @@ const char *ras_block_string[] = {
 	"mp0",
 	"mp1",
 	"fuse",
+	"mpio",
 };
 
 #define ras_err_str(i) (ras_error_string[ffs(i)])
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index eae604fd90b81a..1670467c205463 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -544,6 +544,8 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 		return TA_RAS_BLOCK__MP1;
 	case AMDGPU_RAS_BLOCK__FUSE:
 		return TA_RAS_BLOCK__FUSE;
+	case AMDGPU_RAS_BLOCK__MPIO:
+		return TA_RAS_BLOCK__MPIO;
 	default:
 		WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n", block);
 		return TA_RAS_BLOCK__UMC;
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 0f214a398dd8fd..532260fd64db14 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -73,6 +73,7 @@ enum ta_ras_block {
 	TA_RAS_BLOCK__MP0,
 	TA_RAS_BLOCK__MP1,
 	TA_RAS_BLOCK__FUSE,
+	TA_RAS_BLOCK__MPIO,
 	TA_NUM_BLOCK_MAX
 };
 
-- 
2.17.1

