Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B228FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 01:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FA310E614;
	Wed,  1 Nov 2023 01:49:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7534510E60D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 01:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi5ZBbEK/DC8iu1R6G0nqla6O/itghk7QrTClcsYrpQz/PEGnOk2w8cZOQ6Q91LZm4SvMa0zuqeiuy0qYD++mEHP/Wi9rMJtSZ4e7y+agbQjMeHFyzRq6dDKk8h4znmG2RDFZXcIl8hhpGOJlmEAqM+KRy8WoxNRLdsqTXMgPPibIwe4nzPYRaDV9YZ5StJ7v2Y6T0QggQ7qlk+6cA75bFtiDRkiS3Ab9v5cVF1H3hUsBl7KLk1QS/DdvW7snYOhV1C+J/vfmfbcHkEAZMPUu3ssypcEiGRZkVfqF8HbpKOFFnmiYfjljsChHVJ5XJuHSUgUc6u1rhYZ0HzrULxvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpz2v6JGrOCU0i8WZ1g7q8wKmZITv6z+iGiHqmxHqek=;
 b=M2aQCL4xZHTa1A5B9C5saAjCYh+qWBg3SVPsrs5XTIG+RVMTmVWgnuZsNnaiwIQjOH2LKoVOjeRVOWfUocjXge3Xiwx6L/0hEN9NgOwdzAoDBctKetJbEeh9BpzF9O8m3kGb4HCNGg8KcbdGcKsKYAw/zqpiUNvkrGTPNbmoi6By1Tk8ycxmhTjHdD278aGF3b/vQSSZzxYx4lxqyMbGlnxpI7OhpPHuVfyqnnotTX3TE/ERHPY/mmHoT4+NGA6vsucvPFGf9JKjZeBACDddlqYRSsbqG7J1U+7T7IV7zokS9sTJIaesjo7+jFVjvPBYCsGERTbwfbGMAFXR7uXfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpz2v6JGrOCU0i8WZ1g7q8wKmZITv6z+iGiHqmxHqek=;
 b=X/03TuxFj+HNzUpOl6wBkO+bXOgR3HIN8M4y8keaHAOV18yJQaqsjnUEb0isNS/p2gy89CIwjaICofyR9Z4zedc/7VHwv+GfIuJqvyhvwz8UFEq7cDu9UKiiY71YwMymD98JyYmq8jb+/Rog/46Kdxv/Ti9Mjv79GOSEuu0hpbE=
Received: from SA0PR11CA0207.namprd11.prod.outlook.com (2603:10b6:806:1bc::32)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 01:49:09 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::3d) by SA0PR11CA0207.outlook.office365.com
 (2603:10b6:806:1bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 01:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 01:49:08 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 20:49:04 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix the the asic type of some new asics
Date: Wed, 1 Nov 2023 09:48:45 +0800
Message-ID: <20231101014845.1979083-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101014845.1979083-1-Jun.Ma2@amd.com>
References: <20231101014845.1979083-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH0PR12MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bd4747-15d1-4f42-f9a0-08dbda7cbcc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37Ds8zzv0I5zLUE9TLJgTcvfyoE9YDZl0jgFZ5ZGvw5quTdoFCIeOBCZ2F2izxSsMTprYROVccVea0EleD74vcsLLgbDQT1rTsOcns1fcx7MyD+mtCNpOrAqyAKnrfECZUp7cb5fe/YX9+v9XT+Tf9xWIZkE2x9++qkBfDYnEizFdVfbkCWIddX1gPxZxKUg8O8G2YGF+y+gPHU0DEif1sZeIgnhKRdlIMftpvmhJcdTcpMFobk51sbgVHAkP1l2Y/HmCg5bJcnLHb9FTZoeyguJvLr5M9U/YGeLS86VLpNLBlPvbOpJlWOpBuhMU091iLzsHZ4nLITGGYsxvTmjglk0PSbNlkUKWFWC1OfhQcSezTjPMYRKYVOQkeTUzweX7tk44HDV5+rpbMQBk19RFEq97FucI0h4+OLoQFrXqoQL+1JUGrUg2MYvupdJceSoD8V1ls8/BxDHpIDWgnXbm6r3VMckcX7ZCQ+U3hGFWhObrjLjA1ZT567AL2kUAMOkm+Ltn5caxh4MPihWD2iUB7LmoziSs1ix1LqoInQzzHP+OWVyr9Lkbe1N9t/A8d3K9p7524OYRjUP6Sh74fJ/Rfq8safdAoWQ9J/2of9L8LuiYv7aSY5aAZcSw+SoTblUqijwGnoYk0FHq4HU69l4SKIoA+z7qZnrNXDgjd/Ox1mVEgRHhnLyxNvKjGPzwKYUvvt/5tgRvlROnMgdKpx3ag/93tJKyy1mkBwFHeOC5FLhS3TXgfi+J1fJhPCVbt1sd2IZ3mYDvppWiX3ev3SS0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(36756003)(86362001)(40460700003)(40480700001)(2906002)(41300700001)(8676002)(4326008)(7696005)(478600001)(6666004)(8936002)(426003)(26005)(1076003)(16526019)(5660300002)(70206006)(70586007)(6636002)(47076005)(2616005)(110136005)(316002)(82740400003)(81166007)(356005)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 01:49:08.0192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bd4747-15d1-4f42-f9a0-08dbda7cbcc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some special new asics use the same device id as Sienna_Cichlid.
So fix it.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 756cf49557a2..a62961649171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2073,6 +2073,17 @@ static const struct amdgpu_asic_type_quirk asic_type_quirks[] = {
 	{0x67FF, 0xE7, CHIP_POLARIS10},
 	{0x67FF, 0xF3, CHIP_POLARIS10},
 	{0x67FF, 0xF7, CHIP_POLARIS10},
+	/* differentiate between Navi21 and new asics with the same DID */
+	{0x73BF, 0x18, CHIP_IP_DISCOVERY},
+	{0x73BF, 0x19, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD2, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD4, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD5, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD6, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD8, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xD9, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xDA, CHIP_IP_DISCOVERY},
+	{0x73BF, 0xDB, CHIP_IP_DISCOVERY},
 };
 
 static struct drm_driver amdgpu_kms_driver;
-- 
2.34.1

