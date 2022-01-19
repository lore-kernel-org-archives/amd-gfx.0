Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4A2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 09:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA2D10EA15;
	Wed, 19 Jan 2022 09:25:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6793310EA15
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 09:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxCQCRBPHsHfWbJlxd+Rybv5Jik1dePfPTKW1iS+iOR76YJiJ/gM7jYkmngztDIjFf3HZdH85R7ZJolLDDkxJvfZ6dpteth1yp37cTldfImnfKfLLcIj+dHTLkv55MbRZfMByvWfKxcd2wsJNZYmjDJVlf6U+VoQ2lcGTcFGNduNfEMmK9LsEa1d0XZv0rSQ1Q13mtOWIc0T+E2dwtpUdqYkNug5cyQomPXxwLl6HkAW7gwYj9Rk+wJ6P2Ur0M0KVSUnCZOAEPIxVrNwWmeEj7UO45oLYeosJZ3Sy6Fw+5QENz44vzF0/bYL/xUT6O5x0GicBOIiceP36059OtkHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldsgyLRK0qrN0EevlOCNcSe66OVi7/nDmV0mZGFUYTI=;
 b=SM0aTfzfM9+BNsSs820QgfkNBdvzRdqCPQVIrtEXExl8WQpZInI3x9EWOrK7TBgi4+7X8uKGYZe3ain1MtWRJrqBSffllOdAASfsfvxIpL+lo5t90I/WE67YHCJwNZUGjNX7u1zetCIdsGwejBI0Ivibmdx20kT5GGuU0IuQ6A61h/LQgss3Nhf8Tch8fYuackJZeNdeFO7vTAK0TgYc9spxVMRV3/3j3qRBnBc9rAfUswzQMak/nO9wdMOy74iAI2vhlYzlj8123RZzVjiuSaFOzVeWRJLwACoCDmSquSH6gEY1jdtvpI4F+ek+uuWQ+p5AJ77++Ufw8EZypkAODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldsgyLRK0qrN0EevlOCNcSe66OVi7/nDmV0mZGFUYTI=;
 b=uGfvBVXMLsD1h0aKbbrbRm+LOHd6UadJAi0UvWl3PTnvOiOjTuSNHqTuZiD9R2SflCayPgZ8RiE6mqw/QKIhHJwtMZ4vLUMWH3q6SCnOeitGxaKLq2AD0G6Ga//x1YwwE2ve7sTnChAkqJ2DGNp8/0iRSsgUJzX3tfkgPf41mL4=
Received: from BN9PR03CA0418.namprd03.prod.outlook.com (2603:10b6:408:111::33)
 by BN8PR12MB2961.namprd12.prod.outlook.com (2603:10b6:408:65::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 09:25:14 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::d1) by BN9PR03CA0418.outlook.office365.com
 (2603:10b6:408:111::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 09:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 09:25:14 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 03:25:11 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] Revert "drm/amdgpu: No longer insert ras blocks into
 ras_list if it already exists in ras_list"
Date: Wed, 19 Jan 2022 17:24:35 +0800
Message-ID: <20220119092435.287721-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119092435.287721-1-YiPeng.Chai@amd.com>
References: <20220119092435.287721-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eab0108-44ca-489a-99d7-08d9db2d9987
X-MS-TrafficTypeDiagnostic: BN8PR12MB2961:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB296116172F56591544C92708FC599@BN8PR12MB2961.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zzKK+l6APHUcq9UZZ6wxyGlyw0geCC/3c+V0jUMwdgMPyA8jeSYvnoItGuDYfhCNxtuxv4C6swRrblHpDj+PjjdRQYMNvIoRtpJw5JmxUPVjMl2gGuBt9eYjGGsCSf+RzIWxBMP7M74E66ylsRcsex+K2Ju9kDh2cKjGxeymRoPL23Lld7t6Q4wyY35uPiROChG7jSTKFyxsxzgeMrzDUFcRLmC3swT03UHvBLgbXsLYiwPCo4dN2LulniS3S8+ryeiEB2ZZ3YNC6UMnFc93iyxPO0jDlcsmOWT/TROY2O3bO1HyTwTyTPuTwM1ML7usKZX9tTD2ei+2xt4s5IBOsALP5TYo428VawmSu8PjYd/Ut1HOfmkLtzcYciw6OmyG8MI/XujpMdtYikFbjeqHfnd4JGW1CZWeD2Tzr4msudnhRJQ7GQfNH7r5/Q83B+WeLfhE4MF5I4hZBm5OzI8exY7yTQsHgNvXobsGaNogso3DIj2EKZSDjGeifSmILa9p0YDzQUTm4jF/bxG1fGMSAt63c/f52dgmSzzSW8DGlXmWM/f7DcF1+a2uL2z5kyxl22pibqdLdCejxGFaiS3fG4/F/+JmUF3kzb3cBzfJJDiSGiin12Rb8B03iLshlkBcpCiG3LOmaRsdd8BkJ1AyHkERQlbM8fdvls1cnXxRxON4cuMnfLYNAQ0nt8EdXwhVUUpNpdJP1SpiZ54P0qu4AzxeNOhvSr0zuUt46kFrvtN6XhqVQaPZmHOqerEvZF+TbSK3oKgyYTHbveG4sm6xWi8dbiDJYf9f5UyqDvNPrwYu46PCn/3ihl4cpCLO4XU5mnbdj/l+KNZ3s9ta1zH1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(2616005)(36860700001)(8676002)(47076005)(26005)(82310400004)(6916009)(70206006)(86362001)(7696005)(70586007)(40460700001)(83380400001)(5660300002)(356005)(426003)(16526019)(508600001)(54906003)(336012)(36756003)(4326008)(316002)(186003)(8936002)(6666004)(2906002)(81166007)(1076003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 09:25:14.5135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eab0108-44ca-489a-99d7-08d9db2d9987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2961
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

This reverts commit 48e175f7476c6deb7ccf1f10d081322d52830a17.

Xgmi ras initialization had been moved from .late_init to early_init,
the defect of repeated calling amdgpu_ras_register_ras_block had been
fixed, so revert this patch.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2b71611be388..e6b81543e104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2775,19 +2775,12 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object *ras_block_obj)
 {
-	struct amdgpu_ras_block_object *obj, *tmp;
 	if (!adev || !ras_block_obj)
 		return -EINVAL;
 
 	if (!amdgpu_ras_asic_supported(adev))
 		return 0;
 
-	/* If the ras object is in ras_list, don't add it again */
-	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
-		if (obj == ras_block_obj)
-			return 0;
-	}
-
 	INIT_LIST_HEAD(&ras_block_obj->node);
 	list_add_tail(&ras_block_obj->node, &adev->ras_list);
 
-- 
2.25.1

