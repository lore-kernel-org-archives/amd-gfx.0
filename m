Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA9FC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 09:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FC110E167;
	Tue, 16 May 2023 09:47:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5AE10E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 09:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfP7ha5ZarB9jECm1Q/TM+JneAOVkRPzpSy9FphDwF1c3kglBNMgC2ZWww/jtEMJ/PC/7keO6mlmtdZCTX9NcKawmgUOOKCba4Q8U9WiVWc/g/zCRWmw2t6aZ2h08Kt9wLmczsCyM1sVTNURm8p6Yw++hfwmP6gzz7AebAIHdScrYg6v96Pn6MUukeUqymVgVXKRgjOyA7/6Fp+jJnywlXWJekoCwIPYQbF9c2AtQwSugEea7BRr1TZtrl0nlRxpaNnxnUVzUsM5Tp0anJaUpIlTnsDLoRWD+Bu3jsEEz/JOmdgK/xfwAKN21PPym9iF5f/ij2G4ThT5ILJnKDn4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI9HkVMNZ6GZu0v1YcoV3IPmQ7sBcbQ6+qF7XJJTvVg=;
 b=bbxev9Jmg1y/X8dLMneG8+ZtEvpmTcyEoaeeEpB5jj7L+RyM9ehTnnUhKk+Fhm1wKDlmIrTqV2rzRWLDfcGlnbfNpXA2RMyaFbUdE6obueyPIy7djqjfvMyFg9ORkks+nqHIja2MdDEEPP1bvQ+erbV+qP42hCGgAf0eeAd0OZbFOLK1UZ3MwmXmwfihBEmLn+b2J0A764SUvmuT4fGhVUs3jUi5doc1fKSZFIo3iTFz34sNy+gFV0D+pT/TG5tGu7e42fnifoZo220jkIO+GdvegKIcbW6Qp4dpu+peUsByRdztEzmAt7VY1ri+tocblnfzcNIne0qUcAH/niCOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI9HkVMNZ6GZu0v1YcoV3IPmQ7sBcbQ6+qF7XJJTvVg=;
 b=HKMvlLIP6GNaPn2KnvwgmAAzb18TVHoz5qhyo0It0Eno57WqFE9v3MKj2SHecee79mFH5gtCblGQktWPI2TLJ4AbzkpXnMD11W2O/k4jZDvAfYYo5muYZhfDLW/rkYdhXji35LjdQD++so9r9t/yUjeLgjiQLRRyBMoB755/EwA=
Received: from MW4PR04CA0289.namprd04.prod.outlook.com (2603:10b6:303:89::24)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:47:36 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::3f) by MW4PR04CA0289.outlook.office365.com
 (2603:10b6:303:89::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 09:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 09:47:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 04:47:33 -0500
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 04:47:30 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough case
Date: Tue, 16 May 2023 17:47:16 +0800
Message-ID: <20230516094716.323715-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: efd60911-ff52-4e7b-4c2c-08db55f29359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QGuhKZ/b04HRAYpJwuba88TSic6opIwNnL0AFwrQ6fP874WNCpgXno92pnO3g+ToxfC8iMMIxgyQ0fWDaZLw5J7F/r4CdgcQIl6W11Djm+BELOrCuBjSI4fBElG7+7++QlGFu/Z8c/U/CePfEKoBJ5BOHaui9NjwYiEaeORjh3Qj6iaM3KPxfAH0k7js9WOCM281Ha2xP3TPZKS9TKLPeIxMKs54snk3Q6OwRuvC9tEf5uPXe0mJ6D7ukvdJ8gWi4etme5Jp06QtXc8+WK5zJYqDzns+LKcImIg0GZuTu9HZyqS3VUBs2+UbiooYMEoC+RV0fZwlQs8K3YKJT6ZWXsxD77WObPD65rLT1s9QhPCGAvFDQi7Ol3eK1IDQSDsWjG+rrLlATwRnZGzwftRHeH9NyqqFUa21XRBXr1ZtOnmDHlOOBT/vCl3W0voYZnNvSjhDliwL0ZYqqITKGMlo56loGPW7C2hxEYFzAQV7iky6UNti7NgWHXDGD5lH39/Sh4oCgw2VUoAKJtinwiwTAffQpRJXHERd+Y+jYFkqQiI5/SSQQGeBBbRiFMYRDbcxU2jbZdIU42BI0d85bSU2UrZSBHa0w/SqfPQOkuRNo1f1oKNkc8HmzGEEsAxaRDu2Trkrq+lyXyqyIazX6w6S8E1Kv1JyIF2L9Ew/7cdQ9oKaMsu2kY6BmZsVcHtys2H143upbDhzW7K2nrQh9YgM9zni8C7ytfTuresH3CcS9Z+EqWsZuuzm0DvH8xFJcwEzeudv8O8O0rkmy/sckwReQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(70586007)(70206006)(6916009)(5660300002)(8936002)(4326008)(8676002)(2906002)(478600001)(54906003)(7696005)(41300700001)(316002)(6666004)(40460700003)(26005)(1076003)(356005)(82740400003)(186003)(36860700001)(40480700001)(2616005)(426003)(336012)(83380400001)(47076005)(36756003)(82310400005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:47:34.4044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd60911-ff52-4e7b-4c2c-08db55f29359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, haijun.chang@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Passthrough case is treated as root bus and pcie_gen_mask is set as
default value that does not support GEN 3 and GEN 4 for PCIe link
speed. So PCIe link speed will be downgraded at smu hw init in
passthrough condition

[how]
Move detect virtualization before get pcie info and check if it is
passthrough case when set pcie_gen_mask

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a9d9bbe8586b..255b0014b6a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3813,6 +3813,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
 
+	/* detect hw virtualization here */
+	amdgpu_detect_virtualization(adev);
+
 	amdgpu_device_get_pcie_info(adev);
 
 	if (amdgpu_mcbp)
@@ -3827,9 +3830,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (!adev->reset_domain)
 		return -ENOMEM;
 
-	/* detect hw virtualization here */
-	amdgpu_detect_virtualization(adev);
-
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
@@ -5589,7 +5589,7 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 		adev->pm.pcie_mlw_mask = amdgpu_pcie_lane_cap;
 
 	/* covers APUs as well */
-	if (pci_is_root_bus(adev->pdev->bus)) {
+	if (pci_is_root_bus(adev->pdev->bus) && !amdgpu_passthrough(adev)) {
 		if (adev->pm.pcie_gen_mask == 0)
 			adev->pm.pcie_gen_mask = AMDGPU_DEFAULT_PCIE_GEN_MASK;
 		if (adev->pm.pcie_mlw_mask == 0)
-- 
2.34.1

