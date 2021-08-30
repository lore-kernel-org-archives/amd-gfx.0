Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA025C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 10:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A37610A2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 10:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0A37610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C7C89BAC;
	Mon, 30 Aug 2021 10:03:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD09489BAC
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 10:03:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLHSOdXTzOTTfuAEWx734J97bsXQi58AvWmTZfHn5Tq6qoCDGLUJMvnDEJGSvcE6ocCj13rZGpxJ4nFVDfcUJXWV+Uk/GY+7dgfoPC2Bnpm0fp1mtDMt2YJYlINMs7cfdGcznDFDAA2AKJiba9ZAaPocCZzWdB+m/Ce88vhaHvDWltkUXYEiYmQjWqi6wBxGui/Y97iZi4B+n+g+s/26rZBNEwrBVoy+p3gxQceky6ACfEF3Uz1KrXv0LPLZvcFHIfmZoXNLLsk/PtUZIjOIN1kO7e03ZI/UNYNmzj9D96M7+FSZBSQfNhyZHnCic/1SdaMMc/hi2ssqiYvaBqZ/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+dpj+djXz0Ua2gKyU4IPefAX4wIqo40clrs/rzN76A=;
 b=figqTV694Ijhi4zYjr11hINXtEi5qbOnnlkV1ZTWP5uc+Ln2yXu5bxdMwNqcA/aj0/zLsQbTfDIVfZ/6BMkTeOkxgrpFIjUOwVdDKCVZm59OE88EIxgNjca32yIbb6DCBeJdJTqM8+0FiwTEeb41ZOAUKiFRdFToT4sBLrzIrRh+6FXvWY9gQj5VL+Kk5rK8jut3ICLUNP61IepkLFyJGZ6r3RQahw48CmPuCmOs4+1TjJsBRD0csx5St5zeZRO5vBU5g0Mj/VWyPui54xD2vUHSU4cvHW+oO5gAaQ/oFuADQEXnRmPdzN0gqkLv7NgyELqNmJ9tAgPIvJ4n6UenCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+dpj+djXz0Ua2gKyU4IPefAX4wIqo40clrs/rzN76A=;
 b=pFvPizYbM7nDV/6qtNuwFLg2Ld/LKzaPrc2qC+X+zsYNzDkf6uGkuTZIPY4YSYUCU9DuaD7D8k3J8e8sf8hoS352eX43tWDhj86Kt1L3wggogzAfza4yNvbrZdFYIMbjMkJY2UfDLkajawxHc3HfZApWsiGgWGckKYcWip0BlBU=
Received: from MWHPR15CA0043.namprd15.prod.outlook.com (2603:10b6:300:ad::29)
 by BN8PR12MB3507.namprd12.prod.outlook.com (2603:10b6:408:6e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 07:30:16 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::e8) by MWHPR15CA0043.outlook.office365.com
 (2603:10b6:300:ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Mon, 30 Aug 2021 07:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 07:30:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 30 Aug
 2021 02:30:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 30 Aug
 2021 02:30:14 -0500
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Mon, 30 Aug 2021 02:30:13 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, Yifan Zha <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amd/pm: Update navi12 smu message mapping table in sriov
Date: Mon, 30 Aug 2021 15:30:09 +0800
Message-ID: <20210830073009.800157-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b3b6297-77f8-4440-ecb2-08d96b880332
X-MS-TrafficTypeDiagnostic: BN8PR12MB3507:
X-Microsoft-Antispam-PRVS: <BN8PR12MB350751BC3A48B49BCE5BD5E3F9CB9@BN8PR12MB3507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkxcGOTLkgeCJjiLzYx3x8AVfWcDQLbv/NkjYL38t40K8tp3E1bE6x1jm6rp91cjeQQ42Zk3vYSnnyyDKHRUaPror/nwtLvNKMJF++D66OCnING1cufOJv4LYwdk7DnGBcr2PDkLJM7FtYuL7u3tYP7B7syZy09ib2rQBTt8lp3BfWDuNrDr1nGB3mlOh031JNJucQPr6+ecuzFXZn8FgAUoJQU4qDfC9dkDOqu22SLMMHjnmP6ntPZQiXRkBXZnTU/5CWvkJ7/2BPeiW3SRFOu0h2NIbpdhWFs3PgSyNtrxFHGABfKx6+BvGaCK0iQ3erMMlEywTKIrL5YGd+78IgW7m3OQWzQ5lri1sApuflmZG5dKtjvmN6cT5LMVkTEPHCKUO4bqupDOD+hKi3oR/UuQT1Fecg31m4kSyjG5uUVBfCEn0akOtR2YKJXP99c/i34vNDgqx39hFEBKo1eWLvDpuk9HWLuGUOGL2n4/Gxla63cyaNL7XomGkwu/Zuc0T6kfM4SPlDOR7rZcWtrwwQQvaSlI8iH1gmvGLNLm49h+nclpDVLyZGfmgNSlqKcl6VbosLvymjcslJrrPGu6Ny+KyGMY/vnTo6xuJCZdMKU+CzNCZk2dE6aY+t0NHo8nCzc2nwKBET7JGsjKAtJtCPyVIOKEyqfynmg/cW1RB504NAm2Yo5QyH2xC3H8TFtHGrbwLL8PBSsEYeoFjtqqpSEUI4PD8LS3uORvrkdKASU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(15650500001)(83380400001)(2906002)(4326008)(82310400003)(336012)(426003)(6916009)(2616005)(186003)(8936002)(5660300002)(54906003)(6666004)(26005)(508600001)(316002)(1076003)(8676002)(70586007)(70206006)(36860700001)(47076005)(36756003)(81166007)(7696005)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 07:30:16.1410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3b6297-77f8-4440-ecb2-08d96b880332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3507
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

[Why]
Sending invalid SMU message in sriov cause set dpm level fail.

[How]
Update message table based on SMU firmware.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f96681700c41..be4c88b6833d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -86,21 +86,21 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,	0),
 	MSG_MAP(GetEnabledSmuFeaturesLow,	PPSMC_MSG_GetEnabledSmuFeaturesLow,	1),
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
-	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,		1),
+	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,		0),
 	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,			0),
-	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,	0),
-	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,		0),
+	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,	1),
+	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,		1),
 	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,		0),
 	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,		0),
-	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,	0),
+	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,	1),
 	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,	0),
 	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,		0),
 	MSG_MAP(UseBackupPPTable,		PPSMC_MSG_UseBackupPPTable,		0),
 	MSG_MAP(RunBtc,				PPSMC_MSG_RunBtc,			0),
 	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,			0),
-	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,		0),
-	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,		0),
-	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,		1),
+	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,		1),
+	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,		1),
+	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,		0),
 	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,		0),
 	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,		1),
 	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq,		1),
-- 
2.25.1

