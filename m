Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CEDC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224D461A4F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 224D461A4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D7C6ECDF;
	Thu, 21 Oct 2021 17:26:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7286ECDF
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 17:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiZFGeUjBLWZoiHf6mwWSNCV8Rj7iqvGeiho77bOLi94FzlYX0Ch9IumVGJAu/ftgCSKWrKYxdQVk8Tw2g4mpFMeTzuAUeCb3AOgfUH3OUeIsS0qfl0Fd6ed9K9c4ams5JlUbFpjQ/YF9988Ln+2YUFtO4w9fSBbhLGoje0NFzgx6qQ5/PZHn3NlsnPiZCT5OCvBwUDTsiSY7AQkH5kfdopUakvHyi+A29bNSPvkE0nCesrzy08krNjl5OCgEXB1B2/370xW2LOUXTqRUPcUMuI6IHRWwPVsAouokWwRgQHmY6RKD0qpkEVaIN66rwBKRtx0LiHUseG6YHdy1vZ1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM7g39eTIErzT4kDB6e/s9Y3x497ZD2VfS4vVCcvanM=;
 b=ZzUUcavCFUi5OxCwE/AbOlaWjtWHs7cwLNiQiVcQJGkBlyZGEX8Tw2J20qJrb/Wo1ZhyTa9Ragflb8FSuuGLpFpUZ4LhHMoW/MeMzmphqGQNF0h74km5sQakAYgdUsLjlDjkHZ7PE4hlOcOVms2d6msiBs3KJ9ckiAiWBH8ujg8aNn9cSn0zFXJkqXKOQ/6PSQlCHAcZHp9exuipSjtj6JMZ971ZLSPOnT2bNFVrd3azCDc9PBSltty5f2g0SzRDifQc+3loLawPO7iHgDFGBBcUpZEDgNoX0c1LI6hKri0kXz9w6Lhocs3e/vwZMHUOButp05thAMxeOWYnCuKWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM7g39eTIErzT4kDB6e/s9Y3x497ZD2VfS4vVCcvanM=;
 b=2nQ4Eu5iSC4lC26PqGa4cNcbH0AWvn0IPg4BeURyrdXbV/QXlU+Bwj4f78pvcyC8DfgpFfvT6EQw5v7xi/SIhFYb9AEzjEeo7Nq7nz4vAO3YD++Hicnl9sGGWlx2Z8Mdi58yHfcaGTrX70N/o/h3esDd1X3x7VkGhWAn0u5I86c=
Received: from DM5PR21CA0047.namprd21.prod.outlook.com (2603:10b6:3:ed::33) by
 SN6PR12MB4701.namprd12.prod.outlook.com (2603:10b6:805:e6::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 17:26:39 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::4b) by DM5PR21CA0047.outlook.office365.com
 (2603:10b6:3:ed::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend
 Transport; Thu, 21 Oct 2021 17:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 17:26:39 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 12:26:38 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add kernel parameter support for ignoring bad
 page threshold
Date: Thu, 21 Oct 2021 13:26:27 -0400
Message-ID: <20211021172628.1294703-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021172628.1294703-1-kent.russell@amd.com>
References: <20211021172628.1294703-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76986952-eecc-42df-0037-08d994b7f126
X-MS-TrafficTypeDiagnostic: SN6PR12MB4701:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4701855F7F038C0698AADF0385BF9@SN6PR12MB4701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kq+7udAoE6075qIDiu4fktKVDh+xhvKZXD4kgybEvgM5YhOsNTsobn3xHERicqaXFLyfaNKpJzT4E81hGbGe1DCvUtHGrexR/iC9mxO8yfHSwPyBn5XY72S7ZysPICM9h4m0Sp8b/eVCmht0q472NOYrwDyBFR9+TeQwesOM4t927z+VJlz8KVpeyk4i+qTlLcAyDGH6mBdvtKJqKXDI0KDbq8JhZP+/pkYAQ8ppdHUhJS3M8oNVY/yvAsxFA8g77iCGwO6O4s6HueAugJNkbXc/RoGHRYGNiVCQV7mMabt0X8OyytevlNFiDgEV3zRApc/pvDIPNFZ6GqerfFPUITSDnBZObgo97Pb78w7PVUagzf6tvGKPYuzEYKQlTKE6pOL5LtWDiSQnYGeqYg92vE5nP3ZtsJLPhtc2Jwg4RUG3Q+W4wIF7PL2NU2zIIrl9+/8GNWMifxil5uB5oB2qxFyvbx3s76iMdTHqdRyvTQ0Ok4J+yOuG7fM8LdGve/B2YSb56zw1cRdB82H649KqjE7kQU27wmQTrQanx0u4wdp6UmVXpJ5KpuyF8ECmM92GymMuDjplaMt5uHirJZbtm/MoGwg4WdKb7+Klgu05N65Pp3xMcf156eo8kQN2fI3/AFZbCIMRNtA+fcPVHXeYFMvh4wSRJBlZh3zYeH0unfgfi98g6Dh4Cqg9ieQcX32nmKhyWBcBc8ExxFsKhdZN6Wu49t5vElE0XPJ6BVkIlc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(36860700001)(508600001)(6666004)(54906003)(36756003)(2906002)(2616005)(1076003)(356005)(426003)(44832011)(316002)(186003)(5660300002)(4326008)(83380400001)(26005)(86362001)(47076005)(336012)(16526019)(82310400003)(6916009)(8676002)(70206006)(70586007)(7696005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 17:26:39.4501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76986952-eecc-42df-0037-08d994b7f126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4701
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When a GPU hits the bad_page_threshold, it will not be initialized by
the amdgpu driver. This means that the table cannot be cleared, nor can
information gathering be performed (getting serial number, BDF, etc).

If the bad_page_threshold kernel parameter is set to -2,
continue to initialize the GPU, while printing a warning to dmesg that
this action has been done

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 12 ++++++++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d58e37fd01f4..b85b67a88a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern bool amdgpu_ignore_bad_page_threshold;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 96bd63aeeddd..eee3cf874e7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -877,7 +877,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
  * result in the GPU entering bad status when the number of total
  * faulty pages by ECC exceeds the threshold value.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement, -2 = ignore bad page threshold)");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8309eea09df3..0428a1d3d22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1105,11 +1105,15 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			res = amdgpu_ras_eeprom_correct_header_tag(control,
 								   RAS_TABLE_HDR_VAL);
 		} else {
-			*exceed_err_limit = true;
-			dev_err(adev->dev,
-				"RAS records:%d exceed threshold:%d, "
-				"GPU will not be initialized. Replace this GPU or increase the threshold",
+			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
 				control->ras_num_recs, ras->bad_page_cnt_threshold);
+			if (amdgpu_bad_page_threshold == -2) {
+				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -2.");
+				res = 0;
+			} else {
+				*exceed_err_limit = true;
+				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
+			}
 		}
 	} else {
 		DRM_INFO("Creating a new EEPROM table");
-- 
2.25.1

