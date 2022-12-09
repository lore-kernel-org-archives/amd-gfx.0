Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64293C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B4410E226;
	Fri,  9 Dec 2022 03:49:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DDD10E03C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpBlpM3LxQwTl83uFlPUqR/PLC249BU5Et1NYpuhHiViu0w2qVLGni9gbymSf1DJ00f70YVEud85psleOoZ/b2q5uPZwmdbjU/voKLVJ7UyQ6uv7lV06N3LCekzuLUYn9190nm/wg8H5V60+O86FVHubMvXAb5GJ7eLcygNMRhP/R0Oakql3vSJM6uV8dcwkNhofbX3vRMQej3T7mhc72+7FeHLToVNWInv0h02SIBsDFlAaKLYi9jRO2WvTcJGMv50vXwvoRwZrnd2oZFlh8fhIYff+vRgNSR7eol1fnu2QlFZIdtiN/9Tcom7JudHb9DV9A653VUNvYIcVgkuYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84C1JKGCyhTJtIrtGMjjhckTYRuY4UaAZm0VC/6OB9g=;
 b=iLbt+Vu8tGUFSsrKgLeCxTGNnNosEMggvxUuKBuwB1R6TXiQHzf1CPG2lFOJUTaDOuPYolFT7IAwaLMtPpeNJnuMquW5O4KOzUgT0Z0nuuc7yzgxRnpXQPHa7LvxE9y7lmPeui64OOiUXGPmmqyBj2FtgpsRhiX2oXFojt+OiBO6KsPnOvL/TkaBTRhx9YPQ14WMZnO0EMJKMZaGzhqQf/xj+CN0KPSmrHnmw90pfjrMNhRROovWSIR4sajVJyFTDg6lDge/HPN5nsYr57ICWLJNcPyQhAB/wUKNNPRoE5ezig5D6PJ0nMmaYOOVfJuJYG8idSa8zb6DNr24rLC4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84C1JKGCyhTJtIrtGMjjhckTYRuY4UaAZm0VC/6OB9g=;
 b=ed5kymwv1iioveMN8oxw5MePyvAIIzjl/moqU29tabj9URYPd2LO13J/SLDJhIkgp9euFBMPK0wtrVh2y5ktMLHYNArZLlVSEcqljU7x+jqG0TIjuZTySqEArd7GI1UVnVevgfOnQwEQxmsDpK+6+yvVZZcwrQTvizza+F0ddhY=
Received: from BN8PR16CA0005.namprd16.prod.outlook.com (2603:10b6:408:4c::18)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:49:11 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::50) by BN8PR16CA0005.outlook.office365.com
 (2603:10b6:408:4c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 9 Dec 2022 03:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:49:11 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:48:53 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amdgpu: expose the minimum shader/memory clock
 frequency
Date: Fri, 9 Dec 2022 11:48:11 +0800
Message-ID: <20221209034813.2373727-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: cf55f62a-e257-45e7-ded2-08dad9985532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7cc8CPZWWqMPWmb3XIsjryWMVoy+bcJ/uYuYSNNQCa1vhwz6BdrelkEfOrrv+XLRsb50jxJJ/KQzs0PnI4OPWZsJDKLYt6zAOmZ18SaWyElvYp+HuvB0cFo/JNjae/MTjJuOaVnQmDOfUL7UjvAZBMQMQkI1+T1XSS3KzgRYZL4cH51EwMj8w7igGnjthbofWk25uXveNDQWYHdhw/oI91NOJHrg+RdN0+BZlR5YHWj/y5g05w5VPnI8WNuxV9lEVV6oFGlBanyhRkHpZ6UN1kArQjIjLVAPayDNdfNLWfMXlZFb0bcjcmg+Vz+DKPS1CdknKPDQke3TnD5dFq67ZCVQIuw0KmAbr8XcGsTUzD/HPKsEvsGwXMakXVoBYS7gbptDYyvkVsv4jIVzCOWVrHbi7pFULyEFQzjkgzr/Dbvn8dFHj9yjcoDf0Tj+hBtXvUwxmjw0uDlLcVZxBaNuw0d+sAMRVp384zGq8hbG+ZP2CYdzW2XjGAoF8b2GCurxmtZzlyWQFFQAXrVe/+gFR2sJKQpSvu1sumhlJYSEensM5gUzzt4FKjCpmKByd9TseQqoHfTuk42p3K4Mq1I/o0ELmVDb6ohWBTGuL5J5DKRZOUtQGKIyOIl1d93S2GOPqyQdgyvuSKwTs4gGvGSBr03YF8mDxfL+Hlu4Cqb6jXu6F34W7ixw06Ua6YuNx4adj4kdLa7+A0Rc6wNNG8Yz8rdnvv820JGABj5rRyg0RI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(54906003)(8936002)(86362001)(81166007)(356005)(44832011)(4326008)(41300700001)(82740400003)(2906002)(5660300002)(36860700001)(83380400001)(70586007)(16526019)(316002)(8676002)(2616005)(6916009)(82310400005)(40480700001)(70206006)(6666004)(186003)(47076005)(26005)(478600001)(7696005)(1076003)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:49:11.3218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf55f62a-e257-45e7-ded2-08dad9985532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise, some UMD tools will treate them as 0 at default while
actually they are not.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I524a512eb538dba626edd6d2c73a370dd6a1b4a5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++++--
 include/uapi/drm/amdgpu_drm.h           |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ccb80f0a7fe2..dd1ebaa40e2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -808,9 +808,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (adev->pm.dpm_enabled) {
 			dev_info->max_engine_clock = amdgpu_dpm_get_sclk(adev, false) * 10;
 			dev_info->max_memory_clock = amdgpu_dpm_get_mclk(adev, false) * 10;
+			dev_info->min_engine_clock = amdgpu_dpm_get_sclk(adev, true) * 10;
+			dev_info->min_memory_clock = amdgpu_dpm_get_mclk(adev, true) * 10;
 		} else {
-			dev_info->max_engine_clock = adev->clock.default_sclk * 10;
-			dev_info->max_memory_clock = adev->clock.default_mclk * 10;
+			dev_info->max_engine_clock =
+				dev_info->min_engine_clock =
+					adev->clock.default_sclk * 10;
+			dev_info->max_memory_clock =
+				dev_info->min_memory_clock =
+					adev->clock.default_mclk * 10;
 		}
 		dev_info->enabled_rb_pipes_mask = adev->gfx.config.backend_enable_mask;
 		dev_info->num_rb_pipes = adev->gfx.config.max_backends_per_se *
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 038153f2f4cd..ab7895347979 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1189,6 +1189,8 @@ struct drm_amdgpu_info_device {
 	__u32 pa_sc_tile_steering_override;
 	/* disabled TCCs */
 	__u64 tcc_disabled_mask;
+	__u64 min_engine_clock;
+	__u64 min_memory_clock;
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.34.1

