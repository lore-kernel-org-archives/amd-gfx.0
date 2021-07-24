Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B4BC4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25E960E52
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C25E960E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9E46FE62;
	Sat, 24 Jul 2021 04:11:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73896FE62
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYEDfin3Q3K0exAbbszj11sMfEKDMx9j7z2E4zPxc57Abw4nmLe+hipAh2bcUYaqU1TdlGh2Jk6KsmlGetUNkCZECUx3Lfui9vi4JcwmD3MRTOFSEO90WWApDMAwtBi3lSPmd8nLID0RJ99FtQimiRnsekdOZFTzMieGPo2cN4hq/u9V9c72haQfLLN0tEuM282OlUzUKQJgbQiB68qbIt/Ec5NY63dVLXy8jewyAzfkqZ7VUjpnuoOvHQ6+r33OYBmzXuaquJyJaA1oYNskM2jAiNUERkkqKGtfKtxSHokwKNXm9TweGPyoMHg/IiORsU9b+3wQ3X4FbzgG06unzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55+xGsSsoiZbt4Hpvdf7VFfUiuqDwd9Yz2RG1OwVRoI=;
 b=KPo2X6LmPNe13WV8MqtT8XbhTdSFBas/VNg3smk5Ig9MzWaYm1lRTf1EFSfdrA7TzXhpY5gVcQT7lnhp3UHC10J+uoMH/sJRMszVO85MvsAe3cdS7nKF+O8Azmj8V5SdyDs2aK+ctI8BwvwVf+L5o/+46Wkuax64+Bqk5/0OUOsABl4tjMHTD743x53x/TFW4oy8f89mzd3f4QDwBpoYBoY271dC8AqcbytTS/eOwqadGvZ80Iw8UwPYNdW4tu923eM2z57jtdO2qUHGGcMwU9RLrJmNhChCCKgMFXsD07UwM77N7y/zp8nwNh8gKK9PVsDq0oy7zluWAN29LJI4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55+xGsSsoiZbt4Hpvdf7VFfUiuqDwd9Yz2RG1OwVRoI=;
 b=MPocycYVKzocmZF1QIL+Zv+Ek0pnsICn87pqTDMJxqskP8PAiKMeb9Cwvg8ovWaolaYj5AdH3oEgEk2Q7LTsHmTa6cB+OfigWUJeYI646hIHVKV5kHYWrt7si/x+avzrMICGlJxSNJztgtTSibD7T5c2BNPxhCis5vrVlPNKpZg=
Received: from BN9PR03CA0854.namprd03.prod.outlook.com (2603:10b6:408:13d::19)
 by CY4PR12MB1798.namprd12.prod.outlook.com (2603:10b6:903:11a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Sat, 24 Jul
 2021 04:11:46 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::35) by BN9PR03CA0854.outlook.office365.com
 (2603:10b6:408:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Sat, 24 Jul 2021 04:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:11:46 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:11:43 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: ensure dentist display clock update
 finished in DCN20
Date: Sat, 24 Jul 2021 12:09:59 +0800
Message-ID: <20210724041001.3875757-13-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 127fc94b-e8f1-421e-78c8-08d94e592715
X-MS-TrafficTypeDiagnostic: CY4PR12MB1798:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1798529B7E3237D5FAE7E09D97E69@CY4PR12MB1798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wyj95uXesWXZHzARIRLghaaUcqHJ6fZcNe54o0PT/JZCKEF/BH/NZ6z475pe5Le9pTTLEPZBBA0T79u6H9djl/eQGIqmV6rNKRzjtWr8tKvugqFWNP3D9esFOHG6mK6s2ORmtwf3CWs0F63n4cXRgqaE0uWlVxCQpeBBuh1mFh6ORH3/Ag38w1FKDiGvDHuTwWSRNsVpWmAP7ICCR3pNiV4sPHS/GPZiP2zsdtsnMKiSyFaedvezrNv8YIhgyK0CmWWcCr8P1EmnC7RGrn1FiqBICj1M4sDOYL799YQWVUONHdnrl/pOguegi5drK16K6VMhvapHzEttw/Xig+8AAVOPtNKyWEDVEclQPdonwqrZI7XNeFKQ6ESdwyuCeJBlo0pyz4rO5x4Q1XwkzQfhYzTO6KhfClLllMyvQp3aYatwnVZ7Bz7R6bRy9GjCvBSCQycqZQWVYMGk7KdrU6o9T4vvgX5OxxpF6SsQ9FLQLz7CQWoJVeqYKpmBCYakFSpmkHZuA8c0JtX6HxaU8Zmo0Zj53QhtlRSAYMiCwC08MhdN7JON7TbqD1vUmoa8KOuK4tav3JUkkfnxFZkwAEQyIBUkJycUUfqPY1De1vxp58Lty2IyPZ0TbTAbWWl1hI4nxXDQ7OFZYHmdfCPqcE8XUiDs5zGNT0UyuwkD6DMItct0+w2iKBu9ZcUQgTj6BgICwLKEY3rBERUEaxrZ/QZa4N+WTrU113YEmALZm77R0ZA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(15650500001)(44832011)(426003)(508600001)(316002)(1076003)(70586007)(70206006)(8936002)(336012)(86362001)(54906003)(2906002)(5660300002)(2616005)(83380400001)(6666004)(7696005)(4326008)(8676002)(6916009)(186003)(26005)(36860700001)(82310400003)(36756003)(16526019)(81166007)(47076005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:11:46.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127fc94b-e8f1-421e-78c8-08d94e592715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1798
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
Cc: Cyr Aric <aric.cyr@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Dale Zhao <dale.zhao@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]
We don't check DENTIST_DISPCLK_CHG_DONE to ensure dentist
display clockis updated to target value. In some scenarios with large
display clock margin, it will deliver unfinished display clock and cause
issues like display black screen.

[How]
Checking DENTIST_DISPCLK_CHG_DONE to ensure display clock
has been update to target value before driver do other clock related
actions.

Reviewed-by: Cyr Aric <aric.cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Dale Zhao <dale.zhao@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index eee406d11b1e..0d01aa9f15a6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -197,7 +197,7 @@ void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr, struct
 
 	REG_UPDATE(DENTIST_DISPCLK_CNTL,
 			DENTIST_DISPCLK_WDIVIDER, dispclk_wdivider);
-//	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 5, 100);
+	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 1000);
 	REG_UPDATE(DENTIST_DISPCLK_CNTL,
 			DENTIST_DPPCLK_WDIVIDER, dppclk_wdivider);
 	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_CHG_DONE, 1, 5, 100);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
