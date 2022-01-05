Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A98C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jan 2022 22:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61CAF10E414;
	Wed,  5 Jan 2022 22:36:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E582D10E52B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jan 2022 22:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgBrvugitvbm1z44RhKlUGSTfV06nYA6DArvzl+Xi3hNSWy5cVP+C1TJBkvXCOB/cIa5aKO8PhEfF4kPVenr+W4raKsyhMDrIKeFGIBBLK8GOaO4l5Tk1Auj7UVMuHV0IiBX4fHjZRnlJ/SmyIyziqujSiLS+GGcWbooQCvaSTCVhL/6nw5h0ZXKTMc53N0XMp022m9vzmDgJy9djxGwIumqBjwH1rAhm4HEDuPuned+/1atETJAglrXaV+m2Q55xO3seePveu23wdlTXphKlEyH1LPC2E+w0jnjwEdhCypmgLcxmR6DAwRbDx4giLnHOotbvaGZ0pm7ZlMEFVlxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXcwiQexo28wopOJGiNwTdLKBay1SvCc+bVtS7mu4RU=;
 b=eT1x/dgANffGK73WejebrMq2D6W348JAV4A76KKs2xC6BjeS0Bvtkt+GlZKRnlRDqJAqpTXEzo2MuxQ4je/PqYdaYD7p0TYIULmgd3XEoGEut0oAYipQyFV9I0pEVyf36euL9klT6u26fLSTySIqq2EuveNkhR9a2h6tPUx4CDxvTo3Y0a7xVfdM8QBtq2ekxMx9gNqFwAOXGNM+1ab7saXejfeVbrADk5wl2ZZKm1SRIIW3ejy+V1tedGeTAM4WIb/l8Xd5gL5zp+dtWsq43Y7Kkz6WyfmzkZxZyq/qR52yBd110laGhkKhcTes9xVwvctJMvjmZJgCC+QwQmmQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXcwiQexo28wopOJGiNwTdLKBay1SvCc+bVtS7mu4RU=;
 b=w6ClHitjwjtr8XKpS4W+Fq7uVVWc+eUNfUCHSAtW5yfTFY5gWNJhWCumgvjj2JWoYV7EUNbTAuCxdli5O9y7n0kfaZKBWJAfnbQWOsMC/igMPO1EGYrb/ilwv9hiOAKRsKl6bhMAPDAZceM5nsqZJ9rfVRGp7ejBO6ymAWtn7ug=
Received: from MWHPR1601CA0007.namprd16.prod.outlook.com
 (2603:10b6:300:da::17) by SN6PR12MB2735.namprd12.prod.outlook.com
 (2603:10b6:805:69::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 22:36:13 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::76) by MWHPR1601CA0007.outlook.office365.com
 (2603:10b6:300:da::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 22:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 22:36:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 16:36:12 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amd/display: Add power_state member into dc_state
Date: Wed, 5 Jan 2022 16:35:57 -0600
Message-ID: <20220105223558.22848-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 443cb3cd-0ef7-4f85-528d-08d9d09bc772
X-MS-TrafficTypeDiagnostic: SN6PR12MB2735:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB273512CEBD7287DF362E5033E24B9@SN6PR12MB2735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJny503DIC3SWGv5IriYCTAHycKp3/fAK6o/qLj4sRcylGHxhfeuQh1TizoBrEhC5T02m5DxyjbIlhGN5qsi/tJWBtF0vUIcpi4Xk/jLrp8GYorMVa7Bnepqc9KHKf+d7h28cG4SVqJgONs4ZNLouVNg3lQG7AmzBW9hgzvPw4M6yuUpy1gs7tlXK8RjVq/xJgfQ00vsz9Wf5DMq5IKG5iAVcooT7f+cmSE53UXY+9SxE0/dFOutWxWti9PJacTNuyK8XmuYxDCKcQpWLMkToCXPrOlYu1UHiLAQODR9aFZ4LDzg1sCztBcr9hYnW4kPBOzOJyYO9SuTeKBIbrRX4SwzMQ0OstHs5TFQfSgi64FDzM1OsoqLstzxKV8PrbQ+6KRW6fm7XFKQgnBIJ37Fqvw9GPoPoN2ca3PhjDqcM6CSm6aLkXUbSL0z3K4nMMkInNnCriFZOsdiHJfuPzABMR7kNtg/Q5v2fSCbyFfhc4KrYP+jtw4HfUyLt/IvYpnYefMf5VclZGSGUCbT7XsWvnWKw20PY9biy5HRvMtuN2hdLkAgWVRyrDXxZ1U+Y+VDJSnzk5BxCzS9e/oqdQAZUhc4GPYKAlk5oMCcpdbW9GpwyNAA6w+apjiFdPm1WMJMOBmYq3iqEv3E2ioNDqiXwoMyyzOJJH9pVnQKVb023BgssllU+Fs8ga29HQANFBnFJECL6HEPSGY8VvE9TDIT2bRCFAhEnzTbWF0R/lSJGC/WKpKb39QsS/xq3SZP8Xc+FFZSjuE+q80Cq3zCn1e/KKoEbkvuSappPlWhhA2F/zE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(2906002)(186003)(16526019)(36756003)(81166007)(336012)(356005)(426003)(1076003)(8676002)(54906003)(36860700001)(47076005)(86362001)(7696005)(6666004)(26005)(6916009)(508600001)(2616005)(83380400001)(316002)(4326008)(8936002)(44832011)(40460700001)(70586007)(82310400004)(70206006)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:36:13.2739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443cb3cd-0ef7-4f85-528d-08d9d09bc772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>, spasswolf@web.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can be used by the display core to let decisions be made based
upon the requested power state.

Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Scott Bruce <smbruce@gmail.com>
Cc: Chris Hixon <linux-kernel-bugs@hixontech.com>
Cc: spasswolf@web.de
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v2->v3:
 * New patch
 drivers/gpu/drm/amd/display/dc/core/dc.c        | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/core_types.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 91c4874473d6..2954485b474c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3281,6 +3281,8 @@ void dc_set_power_state(
 	if (!dc->current_state)
 		return;
 
+	dc->current_state->power_state = power_state;
+
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_resource_state_construct(dc, dc->current_state);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 943240e2809e..6bd0aeed1856 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -506,6 +506,7 @@ struct dc_state {
 	struct {
 		unsigned int stutter_period_us;
 	} perf_params;
+	enum dc_acpi_cm_power_state power_state;
 };
 
 #endif /* _CORE_TYPES_H_ */
-- 
2.25.1

