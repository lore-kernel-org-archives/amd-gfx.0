Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA07C636CA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 03:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DEC8601FA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 03:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEC8601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033956E8E7;
	Fri, 16 Jul 2021 03:11:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8214D6E8E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 03:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij6GwQQ2XrPAywrjtADfHSZpNMa92P5YWYJq/fWCFllb/q0TSvyRu6zLH3SwmCqaFT1bfBy+0QHAW3xea1ewyxrVPCOLRmpbQGsbJgLrntKx3+NXclk6QzIobexh8bQv9Tl6Cizd3b9IKAgW1IrhOEIFce+t3kTtGuEj3eMzBBC0UaTkgOyefwSN/ho1XXD6Lkj2DrXOMfVLl1HGC646/IAZyw9xaCJkVmtvQpqDMtG30kF6/Y1n0pZ7I6n/AwI7Lm2FikUj8bAw0eB5XA+eRjkzo7JOB1sDM8F1KNjd6npsbw+mWtQhoYMdzJMDRAkXd5BwipzTj3Gr5h4Exlxd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLiEsigwvG9utAnaOTNtHru/HL8HavOWUDLC8WBQJco=;
 b=O0piKIcJ5rnYzjb7E+FiEzvErYxOI1N8fJBogmbd6mABjXLZoja4x7RAao18Uvwdr6AUGM2Om+O3HVfC8oD/kGjvFT6kDnzRb/oKRfNrOORn0Sh1itmn9DNW2hrlA3HsBf4iDjdBznIPsN3VCfou6JvGNOp4+jeoy6+fnYA4yPW1rsWZkj9MXk9YoqsQ4+T5vUtJSwqcrwMmLUbTz6oqu6PHE6ikhIkaDj4qfi4QGu6e0MyrLwRS6Ukx9SlNbwOAsba3Kk6tdisGeKleI1tyt20Ad/SzINDcVy7LaUQXO7xT/YfPdVd1yMMXtyrpX31B4uznxaICKqlpVnI8NJtO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLiEsigwvG9utAnaOTNtHru/HL8HavOWUDLC8WBQJco=;
 b=ChyeKHfqM8UMPcn7C2v7KsoNOoCjX3XsLO2zoA4KnLi5tDEdhnDDbDqhajkhjDvpCnS4eTF28Uymkpr4X8zkCWViHY9bXIexaEVBxEPtH2U67d1L5Mw4jOHee6bBQHAA+7Sd1ECyoEM7q0/Psjy0Hs62GXAQF83dPy0Kuu2TSXA=
Received: from BN6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:404:8e::32)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Fri, 16 Jul
 2021 03:11:02 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::7f) by BN6PR21CA0022.outlook.office365.com
 (2603:10b6:404:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2 via Frontend
 Transport; Fri, 16 Jul 2021 03:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 03:11:02 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 22:10:59 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH v2 2/3] drm/amdgpu/ttm: replace duplicate code with
 exiting function
Date: Fri, 16 Jul 2021 11:10:41 +0800
Message-ID: <20210716031042.827317-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716031042.827317-1-kevin1.wang@amd.com>
References: <20210716031042.827317-1-kevin1.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5094adc-af5d-402c-d97c-08d948075796
X-MS-TrafficTypeDiagnostic: BN9PR12MB5097:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5097589FFC16603F57C60200A2119@BN9PR12MB5097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0r44+TM6Ej2/+Jod465KSc9KHR6rjxXio7f9X8vJzZ2V3ak/nyfLPWXuz44oAO2DmNhDdDDOoxDPNMFjxFjoR1KQlRZ/Nv2LHUSVIG/lZFt8C4YHU48JhzaFLbCDjNcRanPI/GID+uXPCY2Lagiw5Xc2EOPDCG248Xr3Sp5Ey+FIDwn6lmQQi3YcnQ55eNRhG2S0BwnTts7woF9IbmmXId1lNxiopnJgw/m5tR+MGjqjdvTG0ad51hpoPoMtJBwu5buc98ij3E0eocCBB1EwoFKNCkWdvcSanIW/5ndFZ/8WFQPTKYdPK3G5vssa0uM6hY4QARPT9lxucLWaA3hndhtddt8HRI4UupyCQeU9uXBW0viCfVhUdHATT9Be0OBjwvu5CTnFyVnUabemuHBEmZtt8iAWguJdoiFVUzRB/cWkU1z91VAhhpHiX5HpidAfJAqsNBAkN3IRuYvSzpavvdt5zYY288R9X4rU1Kg0kckViL+ngPSHUy6m2Zl8ml8nk3Fw1s/LL1seDmuBsytDYUleQLWBeEBEnbyR+569LZOkJNk3VvstW9Qlsm4389Z/duQvcIjPOGXtL5AldwrCIXUwdMyL5rRJZ3oYPlBKZlsa+y28N0kj70UF+dVBLp2MuK3qMChAU4BjXocZR8Dq6PJjbve6JurXeQfzGSTiluun9zONTUZE9jYavgAVrAy0bQ/RgCm9dWAAIl0jHiu5rA35sbZZr04L+k7BONUO4kw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(70206006)(83380400001)(70586007)(6916009)(2906002)(7696005)(8936002)(16526019)(36756003)(186003)(26005)(47076005)(2616005)(426003)(336012)(86362001)(82310400003)(54906003)(6666004)(356005)(316002)(8676002)(4326008)(81166007)(36860700001)(478600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 03:11:02.0580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5094adc-af5d-402c-d97c-08d948075796
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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
Cc: Kevin
 Wang <kevin1.wang@amd.com>, lijo.lazar@amd.com, alexander.deucher@amd.com,
 frank.min@amd.com, christian.koenig@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

using exiting function to replace duplicate code blocks in
amdgpu_ttm_vram_write().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2aa2eb5de37a..f4ff3c9350b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2207,7 +2207,6 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
 		return -ENXIO;
 
 	while (size) {
-		unsigned long flags;
 		uint32_t value;
 
 		if (*pos >= adev->gmc.mc_vram_size)
@@ -2217,11 +2216,7 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
 		if (r)
 			return r;
 
-		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)*pos) | 0x80000000);
-		WREG32_NO_KIQ(mmMM_INDEX_HI, *pos >> 31);
-		WREG32_NO_KIQ(mmMM_DATA, value);
-		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+		amdgpu_device_mm_access(adev, *pos, &value, 4, true);
 
 		result += 4;
 		buf += 4;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
