Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AF8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 10:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEC410F41C;
	Thu, 13 Jan 2022 10:32:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A1B10F2E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 10:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftJJVboilhsf5ArZMyENLFpn4wlttlJ3U6kd7Dt8ptiqmWQgkmwwOESHliUdfia1uNlxSUDf3SiP3uZN9Pw5m+u4bI6vNTgzc9yNf1cOKWebaJpXgUYyJFjABaIX0TaF7+bdep7DIcj3e1h8ILcv/Ri/s8ZWCV/W0ERyx/dgSDiZkpBHpSR0NFXnFacTYvHH/5UER2s+6uh1CpifwTye0nsN7BK4jfwwyOLrsZYvYONw/AJIy+fTkOXQ6INYaZek8S982YNl2Dw1wgyGzfB4jiwZu8s0rFPWWXU29USB1+bsw4ZVEuc0UWhxHBP6VwsYXS3nR8yoTVsKlIuJF2bkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dXxNrNj3PyYquvwjVmnfGdjHFJY3n05L2mbnxYc6Kg=;
 b=ZtrCTMUYgPjYHbEMGFHSqGm1gKOp/Y7pIkPFHnj0axe/XybVLPA4R20G9OyITy+Yuf65BiEGqZvsFOQrDLC9/9bYGxBAU47LSLr1nzmg77Yc9kGusHPUBipz68neP9lscuK2XIeLjZ7/BBAO/YwVX3oquCvKR7UODTLtlTCVjaPhVIG2C/wGeCZG7UXN+QmWg+0VgE4BDrbESKKh7eilzOEfOezL10VPEwMxwcB1NbOU+AEkbFUaduU85NBNzbzzj7EVEsXgelxVU4sJhc93vpfMxvC8KJzDckuAInOVFX7KtcM6ER69qYnHUK1xDFMYI2wscxCO2V6S0O7wlH6UsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dXxNrNj3PyYquvwjVmnfGdjHFJY3n05L2mbnxYc6Kg=;
 b=hUei/NK/YWFJBhVmQFNjjNQdovHv3RTWxQRPw0u4YttBZ0SxTQa0L1hjuomWvLoGTXWxQkmJuqG36/OtIp+dDfrhnFjuK0YaAkOAxYimRnBNT4/RasvklewnTaEisUvW0BfaoanXBnzW8Ty+LbRkk4bbQ27EBBBa0DtK4IQ4gms=
Received: from DM6PR11CA0022.namprd11.prod.outlook.com (2603:10b6:5:190::35)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 10:31:58 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::8b) by DM6PR11CA0022.outlook.office365.com
 (2603:10b6:5:190::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 10:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 10:31:58 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 04:31:56 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/2] drm/amdgpu: Use ARRAY_SIZE to get array length
Date: Thu, 13 Jan 2022 18:31:31 +0800
Message-ID: <20220113103132.3910820-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 947a445d-9960-44a4-c354-08d9d67fed9e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055936A985D6126ABFDED04FC539@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:239;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI/METYO12RBiFLcn8P2ld2LsIyHzFbSrYg5Shp2xLnwyH76uSeS2IcJG8ghdPLlVkh9a3E45B+Q5oHnnPaKBvl0UlbvN6++uRNCz5BCe5eEt46UIhT5KQ++ASBSw5nwpNCk/JEzssRaU0hhMggjFtsRiBxFaTbO4U9UyU9dMjA52ZfxYZnIF7oa0zXJ4EF47eptqMMMOzhNbQXjO5SZPvCA1cUOuXSVE+b5ylMuzdNgOYJY+UwFzJ5G1XGYzrnkfKoE9MGzq+EpvqdNLTEEN9iidc/BzNLHYY8RloASwbIv9NLUwn4qnGq3AXYKFn6opbLfjSp2EdkCTY6VJ+yCteMlala1hYPfFAMtrfBSHh/X7FqXZnpTU+NX4nMP7vGfmvwDNVtzwGT8OHQe46OLyrAmM2vu/djFqS+q+qlBZQNifguep623E0ed/1n4XxtB2zg/+KcdIasP/ISawPsYJnSjmFRJYPnaxDbI+G75eGeG/sBp6IAUBzop1eFsxb5SQmF3W1KBnuooprqmRgkWG5mzir370gth+pN/op276eJOO7QURuf2ziANjpWtZGNKUjyoqMZsQsjPkBXp+nNQZAIANCQmERk/m0BTZBnujD1QSSUyuRHs1Wsj/EEFGepN/m9xWlztFDI/b+sZEKQxU3Yb6E9oP1XKyHQ19NQcfXLHnK63sXHSdBcDHqBxCAPLShp0ap21CrWDCLrChsC0M1A3FeMT6ezgAQfsDPmjvCA6+pyt8ZTYKQH+FXJ/xzleladVEbOL2sSTvCGTC0ScLwHlKkJblhf1PdhY8umMhJUCMHaKX6GKgU/L0V9bL4L0H5qWDERab1WSrXJxdKv/Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(4744005)(4326008)(8676002)(81166007)(36860700001)(26005)(36756003)(82310400004)(508600001)(6666004)(316002)(2906002)(186003)(6916009)(1076003)(8936002)(40460700001)(70206006)(83380400001)(16526019)(2616005)(336012)(47076005)(70586007)(356005)(426003)(5660300002)(54906003)(7696005)(86362001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 10:31:58.4650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 947a445d-9960-44a4-c354-08d9d67fed9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use ARRAY_SIZE to get array length.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 23f4290b2fde..394a18e3c6af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -89,7 +89,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 	return ras_block_string[ras_block->block];
 }
 
-#define ras_block_str(_BLOCK_)  (((_BLOCK_) < (sizeof(*ras_block_string)/sizeof(const char*))) ? ras_block_string[_BLOCK_] : "Out Of Range")
+#define ras_block_str(_BLOCK_) \
+	(((_BLOCK_) < ARRAY_SIZE(ras_block_string)) ? ras_block_string[_BLOCK_] : "Out Of Range")
 
 #define ras_err_str(i) (ras_error_string[ffs(i)])
 
-- 
2.25.1

