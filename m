Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224DAFF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 14:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA61A10ED2C;
	Tue, 28 Apr 2026 14:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GoGhWOkA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C51210ED2C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 14:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt7Mul/I54eCeUFrMh/W9ghZ2Y1IaikxV2iHLQZ58TEpmoY+bNK6jfUP8Oi8ox3U7IwpSIv3CczLMlmCMeq8Bg2O2wOEyZHUCBtZc1YuoSpnAeqx8s6Zc88HRs+oVe3fbe6+mGst+y4Ga7F4MzE2eTwROXtpF0xGNmTmdG/AzCE/gmiyJLETLtKaxZ+G82FyA5u3EixLXo7IKrjh6AivXWi37xTG7rbTiKEXE9V5+j7ZJ7PgEWXsgF9geNVDPm/E9JiaOuD9vcDUQpLj+AIrYRr04Yse9ZFiCYOB6hmqFy8j7QgCOghkGsIpfxb9AyjRde5zcEsBz2FUDprI7lA1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDdN+fQAnR3Ovn0exk7sR2VX59ai6EThkMztPn1qGro=;
 b=Jql4sObmEmWf8WgaJW3sIpSnZc99hol+5ez8Bjx/VdADo9HBUhIgl8nzGsZe0nX73KY3qZWQBGOHhiFqlzZ+gGv7+QJeOg9iMUhteSwdDv7X+KFmTJBfa07YsUdB1bAgR63X311jdtUKYntiEMOKP6zOnHiaca/kZyhj6fK0ERJDkWanDi7ER8arppdTH1WWFqHTGTdIk3YaHofBs62fbARwAzHcZ5WJkcEkKgtLF3+8StKvs6Q/aiR6dHgMghjkRaeCz4PT7Vym94BzNgE6gMjUQ3+lyBZKAbWjrRR6MqIuADYYdxVG3j/Zpc0gsFiNd9lNO92CwSdFfosCXuQRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDdN+fQAnR3Ovn0exk7sR2VX59ai6EThkMztPn1qGro=;
 b=GoGhWOkAgT0MteuLzjz6UnnAr/1ZcW8Gc4ADWGMFSa+8S9Kz9jEVhdJa9AawxZXOs/+88kw7gcgRhUbmAeD0kVgTot+DxMzCMXwGNGe4GDBY0qQJ06AtYXgjzTQo8Ron5VdRpzZvzG8ZazvZOGSgcacD2abwrd68dBhoThS2m9M=
Received: from DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::17) by
 CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.13; Tue, 28 Apr 2026 14:56:46 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::ee) by DS7P220CA0003.outlook.office365.com
 (2603:10b6:8:1ca::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 14:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 14:56:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 09:56:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 09:56:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 09:56:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <timur.kristof@gmail.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 3/3] drm/radeon: add missing revision check for CI
Date: Tue, 28 Apr 2026 10:56:20 -0400
Message-ID: <20260428145620.1480646-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428145620.1480646-1-alexander.deucher@amd.com>
References: <20260428145620.1480646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f808b99-1c07-43b6-5391-08dea5365e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info: IiIWnbdW01smn/OR8dgqVupoS42IDyL4yl1OXuEwj8RSklyZYgH2BM+/z9nLuRNJp0BJWmW6WoemEqWOPZq7OQYeRTURuhwLMXa2hjulQdBedrM8BoTMsb38SoOK0rHipbxyIhRcfsHoyT0f/85Ta6jSmq/hMhpf05dyT7QxUTeO+JCJB/4OPRgZYjGL2DAOODYFOUpPEnmMggv8yILZoLBzbETk9MUCuRR0PCE2PITR6Fb6KxVd1kJeFvdmQdMJDKK37SIeqDtpQbS0PSJVGKu8YRFgW4BO99rnC1wZ+YKJpqElGOtOBibMs+H5PBm4+Em14H3ajAvE11oRXnJ6h/9d1BLwPoUCsnrUVPQKGuxDKeBiZoh9RDizwRiO1VaCvX6fflM9JQB/ALZu03QxGyyahCUh970Nlzkne29mE2ZHr6nlG1q5Zisclv0zDyQZDEu/6s7TG0tCt0wgrrWb16pnd4jsBA0Pjz+VZycaqwYtRiWYq1SLFHhRG7tV7XOVK94TV8db/sr8f1D4rgusTi2e9qXG0vZ1MlupdkeHLYVoIkPK47iz2/EjZy/nYLLSoHlG65mLFHnibc0B/vl5olGH1nixQ28LaxlQbD0shzQGH0A9GsWsFAoUjtkiNQSwyK+W8/51afW8ALoHn/Nl8PyUbwrVTsd3QTDzFOITXzJzv9ebDCT+TBIqbbSbfot7/3QyjHuDI2DNCyytAk2fSoLMW7nST5A2cTd3b2mcES8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(13003099007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: McFCDQwtipPhHYCFFFcLoVnjqsO+uN/SbrEObvxOiofccziBMN6192yBnVyqvyVfkj4V8rAODn9jJz83zFUFlS9kLhJlMwZ+Acol+hwfERy9YDIc88+NzCbEhkFXt2q6JyWRp0nWdzZi79dQWFjcdNZkwGg0RWgaMwMVsHQmi7LkbGvnsE+Aw4vxT3EiqBHOeFYnqGalc/TX/NlcanpmJ2JGQoBLddIQkuKUdm6pOPOpdzW73TlXtYI3Y48ygID4U3kj8FlAHBYAGHlS9N9Mlq9vyZDPbLMCwzs0gQx79n4YZxEoy6Ksr60nI2O2J3fB7gmmcwE30cw6YTBliQs9LsEluiOzp2P/xhIJcs9/WoXUgKjE0nB3MVW88QOdRN/JUmNwEPQ8mK6pXohjrIZsovEV/ze1tD12JoEeDFyePgyJcSsDHkkULQ2oab3nZsjX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:56:45.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f808b99-1c07-43b6-5391-08dea5365e20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

The memory level workarounds only apply to revision 0 SKUs.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/1816
Fixes: 127e056e2a82 ("drm/radeon: fix mclk vddc configuration for cards for hawaii")
Fixes: 21b8a369046f ("drm/radeon: fix dram timing for certain hawaii boards")
Fixes: 90b2fee35cb9 ("drm/radeon: fix dpm mc init for certain hawaii boards")
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index ba8db1d07c070..b47b91272b244 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -2461,7 +2461,8 @@ static void ci_register_patching_mc_arb(struct radeon_device *rdev,
 
 	if (patch &&
 	    ((rdev->pdev->device == 0x67B0) ||
-	     (rdev->pdev->device == 0x67B1))) {
+	     (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		if ((memory_clock > 100000) && (memory_clock <= 125000)) {
 			tmp2 = (((0x31 * engine_clock) / 125000) - 1) & 0xff;
 			*dram_timimg2 &= ~0x00ff0000;
@@ -3304,7 +3305,8 @@ static int ci_populate_all_memory_levels(struct radeon_device *rdev)
 	pi->smc_state_table.MemoryLevel[0].EnabledForActivity = 1;
 
 	if ((dpm_table->mclk_table.count >= 2) &&
-	    ((rdev->pdev->device == 0x67B0) || (rdev->pdev->device == 0x67B1))) {
+	    ((rdev->pdev->device == 0x67B0) || (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		pi->smc_state_table.MemoryLevel[1].MinVddc =
 			pi->smc_state_table.MemoryLevel[0].MinVddc;
 		pi->smc_state_table.MemoryLevel[1].MinVddcPhases =
@@ -4493,7 +4495,8 @@ static int ci_register_patching_mc_seq(struct radeon_device *rdev,
 
 	if (patch &&
 	    ((rdev->pdev->device == 0x67B0) ||
-	     (rdev->pdev->device == 0x67B1))) {
+	     (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		for (i = 0; i < table->last; i++) {
 			if (table->last >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
 				return -EINVAL;
-- 
2.53.0

