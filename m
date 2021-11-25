Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDD1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 11:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E92E6EAC7;
	Thu, 25 Nov 2021 11:51:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECDC6EB6B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 11:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zho8SjS7eWfobfXtQvGWfhOWNMpG+XoKR+sEXmRoCIqMZjtvDSVtbRU5KB9BIM7vu5Axc/JQZRqvC2+TF8HMj7qWgzoYIhGjWHadKjYjY5tcRX0Byv3/7oAtGbAZ2NqAcNU1f7xzcXFuN2E5cQp7ZDD/Ee9fbNtR0hVfvmdJ4W1kYV+eonAqDUoBLANTqPN68/naw57rF9juYZoLj9yb16hAvodyu4nybUgC5mjPCVLNy7yff7nGbMiLOLNhccaR41iAX2p9WWx3tk0KA2pBzjiWHOxS++JcHEQdtlqNaAZK4ShC9CUlQpzljcjhwFLHxTbusclctnD1RwGQqRItww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu7b2A20ly3B+kZeIBG+TjPI/2q/EIanwwJn6k1fbwQ=;
 b=Y97m4Oa/xYItLF8bFtjQV89Oc5cuyoaPGT6siE3E7tanIuP74VwfDN1QVyMnJheljJ09iqWP3X8cdnbeZxd6O/Aklp9Hhz5p+gTqELvAYFsdwKxUvc3GxE2m5ZVwDoOwfbcqaYsZB70c9+pJSEz9skb3M3PEkCLJ4Dvzbr9cRU0GPk7e3k1Ay12eVwIp2PaaiRVecXaFa+lcLxZAPU+pUoW0NubtdFn07283hDMDkzsoe4u28ILCofxJ6RW0gi6/gTdnpy3Py/t8Vy3OIxe279D5ewkn99NLtftD3woZfHnUBuFqdVmivo3t7xKDvHuEmajyqGCvarmF8tZjl/9XLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu7b2A20ly3B+kZeIBG+TjPI/2q/EIanwwJn6k1fbwQ=;
 b=WWbUT/Tv5lE4Sj3afvFXI8WtKc3/W8hefxABpvCzBNRX2/rzIzwYP3vM8yYM73RhbdTaRJp8t4wI0IKCYrqxTNKsnBirz1h+EqpThSWvVKB5z9XbLJEYeyu703+ArwD7WaJnVUDifv8c2TWutfmYeBacHIFOLXxc4HN1+kT6coA=
Received: from BN0PR02CA0060.namprd02.prod.outlook.com (2603:10b6:408:e5::35)
 by CH2PR12MB4873.namprd12.prod.outlook.com (2603:10b6:610:63::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 11:51:10 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::2d) by BN0PR02CA0060.outlook.office365.com
 (2603:10b6:408:e5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend
 Transport; Thu, 25 Nov 2021 11:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 11:51:09 +0000
Received: from lijo-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 05:51:04 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
Date: Thu, 25 Nov 2021 19:50:49 +0800
Message-ID: <20211125115049.122591-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89a23ce6-d10c-4310-dc85-08d9b009df79
X-MS-TrafficTypeDiagnostic: CH2PR12MB4873:
X-Microsoft-Antispam-PRVS: <CH2PR12MB48739F40D33872E80A1355BA97629@CH2PR12MB4873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09yyzD01BK2s74VvOG4IZt6uEjknMzNPIJ5YDDgPX/bLhEvDcaaaBx62E4LUq/tFgYaZGiG5hpgYkHsSk81EQbP/rJ2j1WOmpjFsaujh4RmkxdAJ3gfw2l6rCn277uJsPvUxsabH1c+ab4JNvCRL4IsRm6lZNAZ+ZCxbCNadff+SZKi6RjP7PftwawjYfL7xAofCElFJJ9avORSCYyYXGQQ5AUK6MK4UiWZ8Dq15VqhGoyc65whCxfeSjg4QIdJOlKWxhYy2fLgfIzPiNz/DjJ+9mQxwsGT82lnXJaunsM5BN+3KKYBl4J7TP3llVFMtKNKiF76EeNh/TpEhstsXkrOkNF2s2US5lcsdUraatUGGtdvgjD3EQFOLMt+BBHuG3KTlXiXw7P3kTEexHERIdMg7scVNnGUgQi7qNHMvz7Y5oMAmf2bJcAH0uMFRDK+ulokmaAuDdYvsbY0eHdwoIzgFI16L+5reptzBlLMxoDQhJsNadfw0t0yE171D5qi17+h17xuY0wTP4vTLTiyUzQvHZIS/aYc2mFvLOgrgbL7MCiIZbzn8y7Zyjyi5/+CeIy7ayvdlTfioFNE7uPb6kZJ6/333WSqP8Fe5TYcR9tttzXc2/qN08qPqiM1+iVoszYC3yA7gCJfg7TkKyzFfONa2C1DT9NDrP8OklwHkQGEbyos8i2yMNUDR3Sh4Q6CDQ2P3u2qKl7/grtTBd3or0pEgI22eiSHUlqyoJuNftIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(356005)(426003)(508600001)(16526019)(316002)(81166007)(70206006)(8676002)(5660300002)(186003)(6916009)(47076005)(70586007)(7696005)(6666004)(1076003)(83380400001)(44832011)(8936002)(36756003)(2906002)(36860700001)(4744005)(26005)(82310400004)(86362001)(54906003)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 11:51:09.8806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a23ce6-d10c-4310-dc85-08d9b009df79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4873
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
Cc: Alexander.Deucher@amd.com, Mario.Limonciello@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ideally power gate/ungate requests shouldn't come when smu block is
uninitialized. Add a WARN message to check the origins if such a thing
ever happens.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e156add7b560..e0f8ab8be975 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -277,8 +277,11 @@ static int smu_dpm_set_power_gate(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
+		WARN(true, "SMU uninitialized but power %s requested for %u!\n",
+		     gate ? "gate" : "ungate", block_type);
 		return -EOPNOTSUPP;
+	}
 
 	switch (block_type) {
 	/*
-- 
2.25.1

