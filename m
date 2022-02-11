Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B30CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 17:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A20EC10E8AA;
	Thu, 10 Feb 2022 17:17:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663310E8AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 17:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds/BHcVJqfDz/ovmeeKeikln9hjeHo91CoNKji/8N4dag0PvidwJuQfyluj5j9LSDt+XDXJEDwtr1L00cHCLOKdQzn8sixE9FltfqwhIuOrNAEojQzcQxDQIgsf+Xg0weEHvf6lHqP1ZKu0Dm/mgchNYMl7BD41ArOnXIjeJYZMxZv+tQNo6cmCRrq80rrFG8UNVhj9FxWSoK6lv/Pjd2pbpRaU8rvmeXN3czFVarydpZVWNnPFp4NJjGtIGoz9xyTp7ermpuyu9B781tM1S/6slLAl6eBO/+ii428/R+nYmjIHVxxoA73jG1Bm5wuon1M68Fh75sS1mmucehwU+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLzlouaH8Huc+QbvaTopOB5pR96PDfgij/9fU8XvpZM=;
 b=N4WuVzWc2xI0nJxYgOO++5iW2Z0tQHJYHsivJ98vPfe+5bFLR2ZiYVCyGmXAVJfKhLTHIURpf56YnQUYL43bfCVVmZhrge8rEFcVCKA+uJcGmd0CTTJgasK68PFqEM2YDThwEttyf8JepSwRwJzHrJ3gepXp2HjyR9eFDBKv/6ZVf7+pKf2/IiNHA+ZLEyUanacksFghdPHcM2wvnaxX+qjJwqQWfhyFkHs/UJbdTLuroL/LPWrhE01Ux1ITGThMIdVkKTHyOPae3z2+KPMbCrs8x9N7OXwVTa4D18M4nbHkzvm+EJIquece0JtumtSRKo1R2LqOt3XkNlFdreP2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLzlouaH8Huc+QbvaTopOB5pR96PDfgij/9fU8XvpZM=;
 b=ZBC/37eRjxgKg9NbK7+bCejjFBqcSSnXnpq68BVCfmSz1rD0+goiih7yJiT7CYOJ7+r+mqDyi2PZz2KxMOsuqdzSDdZoaXRiTKvXmrg6rp/lANkZ9EMUvi0mF/TZYBSMPNbewTqaguwslB/HrArmtK/fdUgQEA4QHzyUba6mAak=
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by BN6PR12MB1252.namprd12.prod.outlook.com (2603:10b6:404:15::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 17:17:49 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::ad) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 17:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 17:17:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 11:17:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 09:17:48 -0800
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 10 Feb 2022 11:17:47 -0600
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Disable managing hwmon sysfs attributes for ONEVF
 mode
Date: Fri, 11 Feb 2022 02:23:43 +0100
Message-ID: <20220211012343.3955-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 448e96da-a450-49cd-9c7f-08d9ecb94324
X-MS-TrafficTypeDiagnostic: BN6PR12MB1252:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB12529F0F915B6641C24B8ECA982F9@BN6PR12MB1252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJObltNlUirN2Z67BxD95K+rTtbfteZI2eSqkylcq2lrLp6LjoRx5NqTOKELrJ1qbwS7700NCKoVt3uQVo08//UMSke3uIofrpba0PqypARqozMLmELprr02gTNj0A1nUNlCdp/MG0EQyVcm19Pj8VLANhMyyJrqGUg5Gtz2DE2SvzWzjf8CUbibPyShjE67M/RnF1B3hkUvQuaPrpdbWSDC82YFgBnt9rslvR0s3i2h7Ew2Ypr0OTXxbX8i/CbyOrUaHvnsu9YcGRSKJ3XC7JE+asQq9P/PcUkCyLVMkP8l3KheqlbPJYzU5Vxy0uJ/2Aldf/faXLJJ2jGF8fGOEPxtS9BnYv1htDSsPXeMiNOrACl24Um4xESoZoWEnX7Dqv9TsnCC14cv0LIGNbqBn52wjJVW/PtfsxlC7QLXVYmUq5KaEOL9bhy00YaPtd1UcGOvKmKvIyMRAYH0iGoG04Dy1Ja7ahefMQc7B9RVi2lBIJMcjkbJ3os2UfZ985Qay++k4xyvTLhEYN48adSblpgx7t1fqtrrxoyDtld1NAlsr/uPJ2gyC1aEg94oFPQZY0RZSjvLJlqpQ1gl6XpJeYx75RZW09hpgLlHmvA+crdfYDr7Utoujdm9Dt+VhJEdV3SxCLdbcC1wdB7rcK7AC7Mo4kOOBMte2N2FpjZLKIhHi5CtqO0rEs0GUqcv79lV4NvYy/0gXrezdHIn5OPJwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(426003)(8936002)(186003)(1076003)(82310400004)(6666004)(26005)(5660300002)(44832011)(7696005)(2616005)(4744005)(2906002)(86362001)(47076005)(81166007)(356005)(40460700003)(36860700001)(316002)(508600001)(6916009)(8676002)(70586007)(4326008)(70206006)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 17:17:48.8432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448e96da-a450-49cd-9c7f-08d9ecb94324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1252
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
Cc: Danijel Slivka <danijel.slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch prohibits performing of set commands on all hwmon attributes
through sysfs in ONEVF mode.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ad5da252228b..3cec023a7b06 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3161,6 +3161,10 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
+	/* under pp one vf mode manage of hwmon attributes is not supported */
+	if (amdgpu_sriov_is_pp_one_vf(adev))
+		effective_mode &= ~S_IWUSR;
+
 	/* Skip fan attributes if fan is not present */
 	if (adev->pm.no_fan && (attr == &sensor_dev_attr_pwm1.dev_attr.attr ||
 	    attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
-- 
2.25.1

