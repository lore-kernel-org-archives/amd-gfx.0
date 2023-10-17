Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A5CCDB485
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 12:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F319410E2E1;
	Tue, 17 Oct 2023 12:46:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBE710E2E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 12:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CO3A+IElOv7cTVR0PmvQt5J9cKBST826rtmNJd/J2H6xzSS9Q3P2mpx2fCfOJl6LG//Uc4si+hL+NSsopQamps2POM+tT7UAZXO/y9wpYPVyO6LiBgcogwEhzQgKlNtRlK24w9pyZg0E36D04CCkCuPqoX2xuPSouoDEmJaoKuGro/ZCYRgh98vrrxhdlvz1B9Al0zYfJdxwXGi3jhGPrMezrJmlVJlxYQ6sG/rQKCD4DNtR1gK+GKWjSsMAe4gDxZEDt2HGPLBIsE/sWGkStXuQQJODxoEwIy2+jwC/nXLd2YwSC/NiZ4muCbkIcocm4VnUkWXCA7g+JUlwR6ua1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J3hFV9voIRNSuAHre7WAu1QKo0K1/JAVt3AuSHojH8=;
 b=gN91CRHyF5anf46/wy0hBA2lU82s4SbIe8VbxUhqZ7TRD0w/eN+Oyevoow+bEBMQVKWuawcfZH+dP1t+Vzg4YjB8CsqzsCyuCzE6BXXMuebduEChdv/gv+xPrVEW0EqVDmklVQyQriGnYA11zLNXVxs6Xlxp/RHgApnZkDF38tY1uANRqqz839JCqON9ahdCCBGFU6hSaCp04z/SWGpcT4Fi2l+1RG4jYYBv3BuKW+f6DCjOIOpNMHS9xuK7nYL2JMkP0LTJXhuYoV7qJX9fttGDzF9zxV5Uquoc+bbT0ECTjr+kdxjaSKGezFCv7XLGSWSHiSZCWiK18cO5X5i1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J3hFV9voIRNSuAHre7WAu1QKo0K1/JAVt3AuSHojH8=;
 b=Ex3y1oETt51dZVo3HuMaaaj9J6oMbLCeoELaSM6bVbAdAiH11s4rgHLo8PWDgU1pwif6QTr7uW1SCXaZMVyLibaeliu5fzIfqyktO2J+tqfF/CLwNwvVyiANbyznckc6IUcwQYw76w9kPMNOt2p4IxMLa5mIruoVI2h4m1BYwB0=
Received: from BY5PR17CA0054.namprd17.prod.outlook.com (2603:10b6:a03:167::31)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Tue, 17 Oct
 2023 12:46:12 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:167:cafe::36) by BY5PR17CA0054.outlook.office365.com
 (2603:10b6:a03:167::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 12:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.4 via Frontend Transport; Tue, 17 Oct 2023 12:46:12 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 07:46:09 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 3/6] drm/amd/pm: record mca debug mode in RAS
Date: Tue, 17 Oct 2023 20:45:49 +0800
Message-ID: <20231017124552.27509-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231017124552.27509-1-tao.zhou1@amd.com>
References: <20231017124552.27509-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 08238e96-faa1-4316-46d5-08dbcf0f0b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mq5wTx1nPs7rCrlFvafNognpy++GIve8NB94/WMkR2v+DxkoOSV/eGTW7Eg8I9nHnayMDY5e1mEssQtiRlU2yTRQAeH0Q70d0fKFffi4fhYD5jknUi8GXPv5LLTXVNBH3pAmLpnqQVvEI7UDe7encIq+/Yo6VcSQ5ksgZb/4DTWnsQkimgBPSGbMyd2eTB93p48y9Ce70LflyDMsa3z+EQJa7ZpfkEfuih/lT46hJq+gq9LlysESoGPhrolAqug1KHa2rEWZuEnELyYobmcD2PqPGdbYhdSfBJFvnqTySQbvYsoeIet1FMMGQO3H54Ap4UGJuEwpQCkCUFhYygLiCqg9h/a1GaY927aN/5juHcPU8Ka4w/bdV8KxaMfzVUQOPFFRi+nobCyfHc1Bseu94j9o95RyiIVmhyivg9po+Dahb7KxSofHISuwiJ6bT9NoAWFPIo8v6Necho1zAuhV0CubyvJlc8NKsDOmMqd83NJ3HMJLxJ1hQTanWuVTfRRh1eS/ZyWg+vTI+DGluXFWsFHDN8LfgTU1FWST547hORmKLhlMIvunNeScKMF6sXNP/BeJWninojZhByRlfElHfbrui4aJOLstyUM3GqvUVaHuOW5QrVpx2KhK+FsyxgDjN/D4gOOJKttPbyzdfFWFLpDQONZkjZGKf7BG2iCqdIIiNvDprMz5EUMuC7fEO1GQemuq8ki1+/YxsbLPgtZilN8jv7NGht76ccBfqaoxlXA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(110136005)(70586007)(6666004)(7696005)(40460700003)(478600001)(70206006)(2906002)(4744005)(36756003)(86362001)(5660300002)(41300700001)(316002)(6636002)(8676002)(4326008)(8936002)(81166007)(16526019)(2616005)(1076003)(356005)(47076005)(36860700001)(336012)(26005)(82740400003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:46:12.3026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08238e96-faa1-4316-46d5-08dbcf0f0b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Call amdgpu_ras_set_mca_debug_mode when we set mca debug mode in smu
v13_0_6.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 74fc945a8f9b..c5c1f479b925 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1475,6 +1475,7 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 	if (smu->smc_fw_version < 0x554800)
 		return 0;
 
+	amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
 					       NULL);
-- 
2.35.1

