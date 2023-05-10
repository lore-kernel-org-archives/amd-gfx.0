Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6E7C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CEA10E54F;
	Wed, 10 May 2023 21:26:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 189CC10E54F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X04++dfAXg9/QqYWZ3k5/ca3+d7R2juqyz0zitzEh6UVqQFs5bDl73RThUNEEkCFiwiwVk/O5ZqFatq4m4VW49dna/T/5sbYQxoRysmBQai2+Y34Y143tuv0HZDIz4xn/DjcFH2GAkHNKEGTk/eJYv2ljKIgMis+e+3vsdMvRs6iIQBovgmhNwZhR3rZFdExzn8IDlzxisjHH7FRGW1fyLU08aYEhdlqdkjmPA3eeJhe0mYeOxK46/TkUUA3PwvGAJ9I2TC5c7el397K3q4pFlwzMqi/bb+8NSMxvRc1ToMulEuDWIDWXB+R1tzi9Ol0jhFg+AkVzai61D0Ae14EDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdbrm5VAhSsox5wuI8ux2OKRpjDpNeIlH7Yx6DSUKhU=;
 b=hn2BjMtoKMcSQE3cQ6uOxCo0jz/5+8ARosipGrP79xoDV9Lwe9gNkG0tYdOWr4UOOAZc/gcqOD0BUCGIJ0e+rQYJdyIINFE2B5DE11/w0gzIwcc5jZWZljuJub62dMwOjg1LY/tlU7DYyR7MNtKA6In6pgKcTLtPkahiuGh9mY+/XPNYHkO8Y0RGGnVJwS+OVyc/Go0Z69367IOFNjpGD9ELjSSVkMF5R//pHTYL9xuGQkg0MjqZEdKbWpb5C+2zTP078zW9I7yq/Bff5wPB4jY5YeNRXtBy1FjPSAcBITmggDFpLwhuopTGHg9Dz6xtkJbQL12XW1D+d+lW4K/0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdbrm5VAhSsox5wuI8ux2OKRpjDpNeIlH7Yx6DSUKhU=;
 b=sX7UUwOWlLUJ41fMRkbnF+DFzOwkGiJ9FJXJnIHIdmlU6zoM7QCHGGlzcCKKoWcjnL8fWwYNLgNNOJN4RnC/VGkCG02iaC4P9RVkSKPYyhVkGTn6cv91FXT1gZC/AvnrCUMr66PrVL7qH13qRUEoAiVDRCGhrnzyTSy7Pw1DJS4=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:26:49 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:338:cafe::19) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Wed, 10 May 2023 21:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:26:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:26:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: add check for RAS instance mask
Date: Wed, 10 May 2023 17:26:24 -0400
Message-ID: <20230510212624.2071771-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212624.2071771-1-alexander.deucher@amd.com>
References: <20230510212624.2071771-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fab4607-9dd2-4847-ce0f-08db519d4011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYppCAKUyDgktIm0syh6TYGfZHj38C7vKPhX8dq8yHXFJvDL5GznGREts9SO4WoAdbn4NTKOscnHURCbDI4CAS3Q4c8D6b4vJ1gyXrUcyVFQNM7vFmw2F5nZhtt/cJ2A75imKTupO46RRX682yuId3UGu8RN70h2LzLpXDfZjnwqQkMg/eZzMdlmrlEfGiFxNhbp43O586CHXZXskeNgZqwoJMqdTwV9T2RQT/MejblYj3VVoMtrLLiYXA5OJxTtJpbtbT7oPoNHE0myYp+9CzZZCTHbZcGfywrFp/+ayuFqcnVh5lMCIT2T/qB4AKgNWdB7TjraS6pEWKuc9Gp4UQjulw6Itq4HlWCNEJ5RYp1nLltoI6tCSFuKH3HWqVc5cndJv8tyjAZrMLB7ThXKEiuSdCOMe9NfO1CorMn6tzbx0y4y8O+lGe+85xOWZ1tG9FWj441xlVi0ncYsCULENJ7CTY5vlGG0s0ThIgDcqfMkqE2InxEWPrKG6DuLFUCMnmYSgWa+9sn5gXIuLsZlFSIVtJk4lForj/z+8SrRpTikngnn8x4bsqK5wzfyIs9cPe7pIgGL7vKb3Kjdz7/7WZLpln/3U8NchkfKiCSgwNMucxaR52nG3JBEZcX8cvePa/2hR/iyxHToBJJom1I1RqSHxwwVEoFKe5G6rV7dU3dnQIIDjZ8hLhu9Yx+yvFGju9t/RsgOiKRojw81bFyf3JRC0EN2UtFLLsh+S1SFhp4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(8936002)(478600001)(6916009)(5660300002)(8676002)(316002)(54906003)(16526019)(4326008)(6666004)(70206006)(70586007)(7696005)(1076003)(26005)(186003)(40460700003)(82740400003)(47076005)(356005)(36860700001)(2616005)(36756003)(83380400001)(336012)(426003)(82310400005)(40480700001)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:26:42.8118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fab4607-9dd2-4847-ce0f-08db519d4011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 "Stanley . Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

The mask is only needed to be set when RAS block instance number is
more than 1 and invalid bits should be also masked out.
We only check valid bits for GFX and SDMA block for now, and will
add check for other RAS blocks in the future.

v2: move the check under injection operation since the mask is only
    used by RAS error inject.
v3: add valid bits handling for SDMA.
v4: print message if the mask is adjusted.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b7d8250a9281..6bb438642cc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -333,6 +333,42 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 	return 0;
 }
 
+static void amdgpu_ras_instance_mask_check(struct amdgpu_device *adev,
+				struct ras_debug_if *data)
+{
+	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	uint32_t mask, inst_mask = data->inject.instance_mask;
+
+	/* no need to set instance mask if there is only one instance */
+	if (num_xcc <= 1 && inst_mask) {
+		data->inject.instance_mask = 0;
+		dev_dbg(adev->dev,
+			"RAS inject mask(0x%x) isn't supported and force it to 0.\n",
+			inst_mask);
+
+		return;
+	}
+
+	switch (data->head.block) {
+	case AMDGPU_RAS_BLOCK__GFX:
+		mask = GENMASK(num_xcc - 1, 0);
+		break;
+	case AMDGPU_RAS_BLOCK__SDMA:
+		mask = GENMASK(adev->sdma.num_instances - 1, 0);
+		break;
+	default:
+		mask = 0;
+		break;
+	}
+
+	/* remove invalid bits in instance mask */
+	data->inject.instance_mask &= mask;
+	if (inst_mask != data->inject.instance_mask)
+		dev_dbg(adev->dev,
+			"Adjust RAS inject mask 0x%x to 0x%x\n",
+			inst_mask, data->inject.instance_mask);
+}
+
 /**
  * DOC: AMDGPU RAS debugfs control interface
  *
@@ -468,6 +504,8 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 			break;
 		}
 
+		amdgpu_ras_instance_mask_check(adev, &data);
+
 		/* data.inject.address is offset instead of absolute gpu address */
 		ret = amdgpu_ras_error_inject(adev, &data.inject);
 		break;
-- 
2.40.1

