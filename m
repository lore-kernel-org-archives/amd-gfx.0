Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936F6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 09:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D1B10EA96;
	Thu, 26 May 2022 09:49:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035F310EA96
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 09:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQA2rYkvJdXXvYjHzy3najuR1ro33ZcAIyWPFxW9SVFsnIJ8Oed2ExHxRF8h0vdw5JUrd5VAxUxUcZQiZh9UAqoPPTIcUkLLQKawKLEjrypYOZNX2SQEtuGrEMjYdKKyu7uJqRbSeSB82hbdolaO+EGBkJIcRKDBB/aVAD1CP3wowJsmmYicrXuW5OWItb1Jy3uYtP0V1HxLJHrmN9C8MeD04+Gp3F4bxOcA+eq5femmD4TlhLWVqqJEUisNqry4dS3+oaHWIAZhiGZfwZ1Z0tri7Z4MRmbqzfk9gKn1hC/jOiHaFttDrvO8U9TmjMUAADKUCr253Z6JcbpB8004PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VIllgd1KJ+73vHRFQngOtf1OIBBkChaaMUdyEzqZKM=;
 b=A4idKk/adXwjIAuW+XjKgoAy0sYNz+Ol8Zf8ZhGH3Vi7Cilsl3yGSHv0ni61pg6d9P3BLPs/Xg9hPph3UL1YN7uM2YAfzxUSSxaOprhtnjBF20fqGn57RpeJysk0u3eGsLUQ1TvSaZj1r37lhvaffb7+1g0JiH+Mk1SJH12lKbIhHzzdEFfxat7j7Z9NrZMnfXocCgVMpNuvUF6KYgD5ODD6TERT2AHjTtYgb/O/XDp1DRavihIQJjRgeaex7F1hnGJAx8738fAwefntICUOedttSirHaA2UzZ7y0PuUp49Y5xS06UW6uTERSrHhlDP5R2UigOyv7YWEklmLgfGi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VIllgd1KJ+73vHRFQngOtf1OIBBkChaaMUdyEzqZKM=;
 b=31tJvpiYvQyFUBXbbqjz4VvnODUIbMs83EEfBKyxAdt0lfMTferF7L4m066cMyPsgWsz4Rilf54qR4S+amsu8qOjnjDZTsNGY1aGECQamemxirjJ1jbPZGrwMmkwWknsfGNWNzi4ZKQtandzwZTfvvO1GEIDvCl+V82NVlq7/pI=
Received: from BN0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:141::25)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 09:49:10 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::60) by BN0PR07CA0018.outlook.office365.com
 (2603:10b6:408:141::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 09:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 09:49:09 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 04:49:05 -0500
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Date: Thu, 26 May 2022 15:18:38 +0530
Message-ID: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 760788aa-087b-454f-d681-08da3efcfb5a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5166:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51661A96494C55B92115A64EF8D99@DM4PR12MB5166.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7n4WkerTXsHz2Yy3trj18vh/EwBxwD/gldVvA7HOsJs/Dn5YptyJP7cAUqWhlFIDIAVwl1PlSP45NYlwl8wTqablJN1Zr6ADiu95x8hA0vMHyiuRPEs0gfFff6jXmMg3A9C5BXgmTwLlWWxWwSLkWgqUuvEdqwNZsWdI7xG8D2Z1GoaYeidddyCiOEssQnTPEGLooLg++p+KIkPimou9FXRebCaz34bbph9zX5TQpGrRNPEdoMfvcFsk1/9Uz72YzDjnUSOYBHRiy71n1iycpNzK1RNWv/k7ApNWGtb17rLNXrWoJbweteCS0Bex0zB0A05xjNC8IObMHcg1VkuO7PE9nl6tepAQZZYIqC26tQXZfbhDwz8DqgTIq9VXcud12kKVLj7Yl0vmAHMtBCAALaZ4w1V9HmLkGy/utwxwPeP6ewzCmbU9362VDb9Uy/uUccwXo3AjOIZ0VSmgpai3bAQGvAN/Kj8Wj/AJOkBWhxd7ZyUd6z73VHuBuBH6UNJyXsMRP2Do/v09123TD2To8I8K9VDRlQz4clkaPE3617btM5cmHafp9Z/QRvlrdBYglf+kTTPEA/AwZX6yX+Qfa8dD5YXjxXRgo4gKHTOWRbO6uMdnJB9BQf5PyRVYbPH3cDgQTexAyBzN90BnwXXJIeIJBzXeiJQ7fLbZ/DyQ5MBaCnOym5WQ7TRyP1WzxKpQcoiOeRVRrou/PE2borQ78A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(70206006)(70586007)(4326008)(508600001)(36756003)(8676002)(54906003)(316002)(6916009)(82310400005)(36860700001)(47076005)(40460700003)(1076003)(2906002)(2616005)(6666004)(5660300002)(7696005)(26005)(356005)(8936002)(426003)(83380400001)(81166007)(336012)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 09:49:09.5436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760788aa-087b-454f-d681-08da3efcfb5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate memory for register value and use the same values for devcoredump.
v1 -> V2: Change krealloc_array() to kmalloc_array()

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 6 +++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 76df583663c7..c79d9992b113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1042,6 +1042,7 @@ struct amdgpu_device {
 
 	/* reset dump register */
 	uint32_t                        *reset_dump_reg_list;
+	uint32_t			*reset_dump_reg_value;
 	int                             num_regs;
 
 	struct amdgpu_reset_domain	*reset_domain;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index eedb12f6b8a3..f3ac7912c29c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1709,17 +1709,24 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
 		i++;
 	} while (len < size);
 
+	new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto error_free;
+	}
 	ret = down_write_killable(&adev->reset_domain->sem);
 	if (ret)
 		goto error_free;
 
 	swap(adev->reset_dump_reg_list, tmp);
+	swap(adev->reset_dump_reg_value, new);
 	adev->num_regs = i;
 	up_write(&adev->reset_domain->sem);
 	ret = size;
 
 error_free:
 	kfree(tmp);
+	kfree(new);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4daa0e893965..866b4980a6fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4720,15 +4720,15 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
 {
-	uint32_t reg_value;
 	int i;
 
 	lockdep_assert_held(&adev->reset_domain->sem);
 	dump_stack();
 
 	for (i = 0; i < adev->num_regs; i++) {
-		reg_value = RREG32(adev->reset_dump_reg_list[i]);
-		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
+		adev->reset_dump_reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
+				adev->reset_dump_reg_value[i]);
 	}
 
 	return 0;
-- 
2.32.0

