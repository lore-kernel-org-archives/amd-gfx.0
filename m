Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6AAC0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 07:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D1110E252;
	Wed,  9 Aug 2023 07:29:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540E510E252
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 07:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgGtV8WxpJjcysrz9q7e8ZcDXe4SB4XTMG6dWUAfw+7tZLp50kmSQw79Hy8mGSTli5oeUEIjj2vXGGCGUjlymO0tI032KqfLJCjzyk4kPCAqprZdmvhmE7ZK1Mrtq4UUvRdc7XEhTYZoCrvrIpn5W8faoknAHbLPHLecsp2t2jA9iwyrPMUpwYuUaPviPYWl7LiFYVFB8ZIML4cVOuaaDzReOr5AsU/drdAjL5eFsu6Ri4wpmZNy4L/nr2gXxeWyCy3oWVgyGiGH+BzPlThzS3NXwb2Afq8NNWXLxhTvuZiE4VGay/McN4GdU5+y/1lzym3aVnnddRh7vUBkf9pZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afw6ebQtkLR5KQ8YQ9M2s3F+P1wYIDNn1rkizb33kSM=;
 b=DP3Gs7vYV+KWUljoSDT18aAv/bQxvsseED73dQBL+FzrGVDBW22QkFmIgtN3A9pifRh0NM4X/USfb9esc59ZmaAZ3+Pl/GWohK2+YJLReZF6Bh0C5zZJ8u/+Ekh67zpKvnVUjgp9ZjYOMHlDAsCEMIAnw0Dd/RUWD+rItBjQpj14xcsWayHKafxuCj+TdLwzHuwa/o7E87L8TNSicotdp6KPrGCoJfdQkDTklc+qCJY1TI3w8u+UxoY7gxoX4uJxu4agXe0BBx4loop539SB8WhbjSynHtZo/XNwCLZ/Fr58VCiW4Ry2K9OCl50z5gFRfDdN+A7TKT5kpcZ6xC8RkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afw6ebQtkLR5KQ8YQ9M2s3F+P1wYIDNn1rkizb33kSM=;
 b=5EhbhkrEBo18P/TYUbETf5nPbiXkvuNM0l9K6tZXMyGialYTL+jVWmQi5sq7jtMnhpFDqMM7uxheJvhDtK5SFezyaE2qet2wsYAVmFVB5HS0RuVwxZLE5PWPECacDCjHVMDDHxWe8mzOGNFYBBUSL1jRkDCc0mZqTFXwc9RCHG0=
Received: from CYZPR10CA0019.namprd10.prod.outlook.com (2603:10b6:930:8a::28)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 07:29:40 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:8a:cafe::61) by CYZPR10CA0019.outlook.office365.com
 (2603:10b6:930:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 07:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 07:29:40 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 02:29:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH v4] drm/amdgpu: Fix missing comment for mb() in
 'amdgpu_device_aper_access'
Date: Wed, 9 Aug 2023 12:59:17 +0530
Message-ID: <20230809072917.242488-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e89f14-b082-4a7e-a799-08db98aa6486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ud0ibMxWTzhd2wjJpXEyHHfj4zavTWFeXKG6upX+jWlHYoTCBBdQzEPUyB149Y7DG4f1uImQl3BWl5YgoiTb1UsCjWUGfdg5M4EQiLJ/J6DMHMJRKRRl8QeGMAVvtNYi4/JJ6zjLvp3lwHM5u/YHPFqzyCPlyjqKLikKy9HpZvRP7PGvp6W0JEtkzVzq94Qcd2vUypnWv/tzZny7GYFphAy4q3R1jQBLRvf1lUTB0QkG2GIyd4TjVe+bQw5f+/F9sHBPeAqe33/S5ycLPQg4G7ozZIp8fotE0WkFEekF+w1ceBfpUz+ISUgwFwT1JEEYjM1GOSPUSRaiNzIKbZRicQzlV211SWg/AnvgMQXiU6VJUamaqlV+g40VM1DH9UJXfBubSpnGHFVElU8kwG9endw4ooTZvZ/3tUwnj4Tpuk8ZW/swAPma2tWphxIi/ZI/GEy2G9dTUwZPnK6A+kyMsk1I8mY5yVK6ofVm2iOO/wfNcOqwQHf5pPdYlwxd3ZiGXU+bFMUDa7JYQ1xzrWgr+GfZFVlQqqbrcavA2Em7DVtBn9+VzVEPonx4wybF7iQ2rAPTVE4NwpCqlMCk1QMU2gAYTa/3gorEQdT6oc3YG5eDd5rq01xEBU2Ekrh5hw2oj3L4teDTKQdXv2xZ8B26qKMQhEhWvpe5vJiHf3Bv0C0WCEIf8cZjpCt2yO2unsVQyo8zGmZbn0hhwC/CgDrbK45Uw6c4nhxFend+pPMwQ/PVxSVNXpiB+SVqbLVCBVj7SWplU8/1OG2azxnjfcjPkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(186006)(82310400008)(1800799006)(451199021)(36840700001)(46966006)(40470700004)(2616005)(36756003)(26005)(1076003)(81166007)(7696005)(6666004)(478600001)(356005)(54906003)(110136005)(82740400003)(336012)(16526019)(70586007)(70206006)(6636002)(4326008)(316002)(41300700001)(426003)(8676002)(5660300002)(44832011)(8936002)(40460700003)(2906002)(66574015)(36860700001)(83380400001)(86362001)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:29:40.0372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e89f14-b082-4a7e-a799-08db98aa6486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds the missing code comment for memory barrier

WARNING: memory barrier without comment
+                       mb();

WARNING: memory barrier without comment
+                       mb();

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v4:
 - Incorporated comments from (Lijo)
 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4f818f13dc9d..65c36987f7d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -305,10 +305,16 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 
 		if (write) {
 			memcpy_toio(addr, buf, count);
+			/* Make sure HDP write cache flush happens without any reordering
+			 * after the system memory contents are sent over PCIe device
+			 */
 			mb();
 			amdgpu_device_flush_hdp(adev, NULL);
 		} else {
 			amdgpu_device_invalidate_hdp(adev, NULL);
+			/* Make sure HDP read cache is invalidated before issuing a read
+			 * to the PCIe device
+			 */
 			mb();
 			memcpy_fromio(buf, addr, count);
 		}
-- 
2.25.1

