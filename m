Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F4AC47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 11:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E265F10E187;
	Tue, 16 Jan 2024 11:02:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C3310E187
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 11:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl5eoJwZ1/3X6u7wfPXYR4Za0ZOPUnCiVMNXB1d+Hd4otdw1b5P14Ois9ngoratkjJPzhKHOS77PJBJPO8E8gyU6k1SKV1K+4E8w1ViVSISG+UmpsqaNkeW7nKfcTXXlRXOVsSi+RFURIkuuECiWUiHEz++EgrMTnHRQJaSXq073CZtoMrw1fE5xQVEquM/5SvJXEgMN+xL2Ke3VxQ4Hw1nLV32CKB3Tk27Gzy9H5+oQSnNF6wJBtWW0obyKFqyHADPfSeuoN3TPRJaDw8cS7aiSOj1aSP5pm9MV6nufPj2dLF5RzQGsx6PEBaLW5E8cK5jgOaG6my0FETB8mTkYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfvAfbWotS3O9AQmVdyaC+BDGD7OydCEziFsPgh0vY8=;
 b=HeWCtDMQfBWXR4+oY4PBSZU14t8+uTcesRhQYY6qZq7qlMi2+Z91mt6d9aFBSXPP3OgPcQ59fbOxMbZyWOyxA3lj/RT/qvi7H4Y5lxI2fZPcUzb55X4XOkgbgnuCTz5NCtU6NVV0rR+sZsBFMHJzQAsiQB2t/nrSUuPnvvJ1+a/jVJHcij+8akdRHfz+/HQNHvMyj6FkTXCwSnqSat7yD+i2yWTrCC0GscwidHbt27GeRoPuqTO/sJNtC7JHCCWiSFJiuS19Sojc5Y3InSSOCsiA5dfruwctPXMhYId9FlLNWNg5/9kGlT9Jfdii6WnbxhDXcw7cSclPEHN8hdLZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfvAfbWotS3O9AQmVdyaC+BDGD7OydCEziFsPgh0vY8=;
 b=oBpEDyT2MIWDPty3AAAsijx/FtpvROUHxbviiMRlxEpRiwLeKHOrM1enIqxpV0QTPv1+FY/pY92enaCdCnSEGjprlkKN8NwYC7r+nEvgBXtW6kK5OAtSPo9AbaD/9M1v/TjXpy5gXsIlgwq+EnNhJReq1Vj3R18qZATmxvMvsGg=
Received: from CY5PR22CA0031.namprd22.prod.outlook.com (2603:10b6:930:1d::15)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 11:02:30 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::24) by CY5PR22CA0031.outlook.office365.com
 (2603:10b6:930:1d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Tue, 16 Jan 2024 11:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 11:02:30 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 05:02:28 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix UBSAN array-index-out-of-bounds for
 ras_block_string[]
Date: Tue, 16 Jan 2024 19:02:04 +0800
Message-ID: <20240116110204.1352227-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e389ee-356f-4cfb-8a87-08dc1682a25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3ds4VOfkx2Nn+0QxbZndBD6RWkZJLwIHrQPzvPx9kxYfjbsdyS4Aw0bxnb6z0QaF5No9/5PjnPYoWCZ5D88Thgj7QXa5QPsJJckHEym3eGy1l4WMv7t9em7XUTnYOESSt2h29KA4z/RVA3G2xMJACYus+bGjTCp2RqWgaAYBpJPOu560tin+96ALYqfUGzFo5P3QKC0KNq8VUGsJ8M+AL3nBby/gwynQTTOqtQpetcMrvhK2uvGlx1UbR3eCWCrUQPGQtD9Dh6A/GkFiIGf99Ivq0Sl+og+POopW1eviOcinZfSLGSV6irwDJXLkU1O1EPaU5fBDXsK9Llq6OlfRXTpOs46YxndhR787BGL6tM+sMxeDBeatEmUkBVJtC3MWsMPhYPjXjyxl02zbXuSgbZXkuaUvBGjhy5QO7UWFsCoSwBqkOUHIFMXl9UWYy7QUvjbvWf1rukEunf6H5cv6ayuqI1anfbwhZ9d2m9yrizneaM5oCT9aRayn0+Yv4rA4jvjkY8GeOiuqMf3T/ogE6NvpPW4cSoE3jPdag6EiiDCZ9pXBWF2mAttEFnDYWs3x4RgnchxAFR3OhS12F9ekcvLymE+AU7WKEzE+DI1QZBmULGrd/Iwu1tP649H6CZWHYvkGnCYRS5/RteQWP0raVWOA3/MW2mqPiJykTOTC/5VTK5fQXoDLEUXpbioCN4Vv3sjrDik971N6dWioO05M6uOUSr1Gwz80LvmImqN2ch+5ItbYC2YeWkjKLpbr/2ygH3T05RGKohSIc9fpo6WMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(4744005)(2906002)(5660300002)(41300700001)(40480700001)(83380400001)(478600001)(16526019)(336012)(1076003)(26005)(86362001)(2616005)(426003)(81166007)(356005)(7696005)(40460700003)(47076005)(6666004)(316002)(36860700001)(8676002)(8936002)(70206006)(4326008)(82740400003)(36756003)(70586007)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:02:30.4403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e389ee-356f-4cfb-8a87-08dc1682a25f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
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
Cc: Yang Wang <kevinyang.wang@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix array index out of bounds issue for ras_block_string[] array.

Fixes: 2e3675fe4e3ee ("drm/amdgpu: Align ras block enum with firmware")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ff6f84714f68..8004863719d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -74,6 +74,8 @@ const char *ras_block_string[] = {
 	"mca",
 	"vcn",
 	"jpeg",
+	"ih",
+	"mpio",
 };
 
 const char *ras_mca_block_string[] = {
@@ -95,7 +97,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 	if (!ras_block)
 		return "NULL";
 
-	if (ras_block->block >= AMDGPU_RAS_BLOCK_COUNT)
+	if (ras_block->block >= AMDGPU_RAS_BLOCK_COUNT ||
+	    ras_block->block >= ARRAY_SIZE(ras_block_string))
 		return "OUT OF RANGE";
 
 	if (ras_block->block == AMDGPU_RAS_BLOCK__MCA)
-- 
2.34.1

