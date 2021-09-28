Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDF3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2BB61266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F2BB61266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1735D89A5E;
	Tue, 28 Sep 2021 16:45:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7A689A5E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft1iTRFNbT/WwuZejOEhw3KQlxuhnxLdIM4BFtujjHbnIzkbkUshs/fHsZN0mN3cMc9awVyWGX5z2lnaJxoKN7f2Qc2SEgqd3doYzUYjPYlpZGhW9QGUrXHRn2Tw2lCcbnh7eGZ4YRP3K9U/9lh8AorMqP77php76s+4qiks12eY1V3oKP1iHpphp4JvAg1WAgI7h+0PmmgmggW/DXlP7rZ+mEq3jTZEEBL4C5zeNtEWwvAEJbgVnEZhFPJOBtmv95woXxGWHijEdHIe99CEgiqtFAbGGgGOnk+NsQzrzoFgpe3/DNzWUdHDXZU8Or0rG3AuH84K7ytupwf3Mbhxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=+bEW6ROyFDRRIM+1prFE5Nane/Dfxb8T0D3MNL0vn0A=;
 b=V09XeTq/R40HLGwpHgNcQZWq2Ibt2tT5IBDjEVTpB4zmlbf3f/zexp6DpFAoAEQ6X7C196wYfGSHqNHTaFPvtM6+y+xWnh/FvQgDi7YRlTLj4+hqHIfBfcYPmRayD8IMmd8GYP0utcHoJmLmcoV4e62TNSon72pBA6tMMXUKq3n95gRn+2g9VmK4A3ZsrNdXqtpthYjg0huL13MYHJyze/wQUWypmWbcYgqolhW45sY9jbn+gPEE2swzd6WJlpSedcFashjXAo1cINbg0UZGS0u9TUnVEolbgRu211zpgMWz6GXShyDuEP7FrjxFybJd+LA9k0RL9sB5lhN1Y9Ncmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bEW6ROyFDRRIM+1prFE5Nane/Dfxb8T0D3MNL0vn0A=;
 b=MgXfrG/ng67ulFDzhurExv2NRcRk+RAPhuwux9ywq7gZJ6Cq4iaHLCFcgl9Csxb5f7YkXU7QGclizlkxuo0IYOFzJq4LCBX591GP6OfxbHHDCuOwjUF8pwKq1MHdniFXLIEtAgBpsBGgcgEm7I9qCf4f12aJdNinJLHFAYMzwAg=
Received: from DM5PR13CA0039.namprd13.prod.outlook.com (2603:10b6:3:7b::25) by
 DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 16:45:18 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::37) by DM5PR13CA0039.outlook.office365.com
 (2603:10b6:3:7b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 38/64] drm/amdgpu/hdp4.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:11 -0400
Message-ID: <20210928164237.833132-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e04e6924-468f-48bf-7ae1-08d9829f5a51
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0202:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0202754BECC4161EE64E5A2DF7A89@DM5PR1201MB0202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGRtPHXMWAwUNrkCmFFZQX706izobNy1i67rHo/bmW4JgdI9dUUoGjildLQMIkvwKpiIjv34jSvaCNpD3/+Y0yIMYkv/zQt/olIwzCYOAbY/yxeBEmbPh3GadicM1Ez7q6/u0jtp01MzHFDU50gYUPokXtZMwOLO2Ee56+MQg4+iR/RTBmN8WVPa8E21mRQmD1fvPjUxJP8jpUcD8fvf0sexjj3ApGUF1JkdciTkTD2R29nWU2ZAbd+5Xgl3R2jw2jhKaslOFGDL8PGnkD9mAR4Fnb1tMqSuzNLWOFG3CVZGpZ2azRCfXDMEt/kVcWvH2CFcwOdEB9C6yy5KVka7KAtKDg9ji7stQ6C+TgqXfhRUXLZ5NZzcUXINqT5uQ26ThnbMoH614uIEA6Wg5Z+OAzboGgrVN3Caz2iWA67DXgYl4aoOHYoKyaWNKiFqD4T9w0p5PZ6GIQYjphLupgjyHFfarLfu6GVgmyODVcXHg32S7fTS5VpaID+jLQrm4G8WciICGjRPwv0G5QAJRY5ocBJC7lrwxlbgNYtdSwozEVrLcpm7ogRgWOKiUEMxvNvdH/EWXS8wFXIEV4jjk4xjbnAeTNHK4PEVCbpV4Z41r8ZchOyc8Tl+xFEYG4vsrMh/EkE8C3KjXeLKcb//pehKcekbbF0+Xef7Qwrc4XtBScanEJKK5KkSrBqVldnRkAdZYUclfC1ZV9oZtUeUf+WDA0cELCakJJM3fd3Ht0oI1V8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(16526019)(186003)(8936002)(7696005)(5660300002)(508600001)(36860700001)(82310400003)(4326008)(8676002)(6916009)(83380400001)(66574015)(47076005)(86362001)(36756003)(54906003)(26005)(2906002)(70206006)(81166007)(316002)(2616005)(70586007)(426003)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:17.5526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e04e6924-468f-48bf-7ae1-08d9829f5a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0202
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 74b90cc2bf48..88938115557b 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -49,7 +49,7 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
-	if (adev->asic_type == CHIP_ALDEBARAN)
+	if (adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 4, 0))
 		return;
 
 	if (!ring || !ring->funcs->emit_wreg)
@@ -79,7 +79,7 @@ static void hdp_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
 		return;
 
-	if (adev->asic_type >= CHIP_ALDEBARAN)
+	if (adev->ip_versions[HDP_HWIP] >= IP_VERSION(4, 4, 0))
 		WREG32_SOC15(HDP, 0, mmHDP_EDC_CNT, 0);
 	else
 		/*read back hdp ras counter to reset it to 0 */
@@ -91,9 +91,10 @@ static void hdp_v4_0_update_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t def, data;
 
-	if (adev->asic_type == CHIP_VEGA10 ||
-	    adev->asic_type == CHIP_VEGA12 ||
-	    adev->asic_type == CHIP_RAVEN) {
+	if (adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 0, 0) ||
+	    adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 0, 1) ||
+	    adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 1, 1) ||
+	    adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 1, 0)) {
 		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
 
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
@@ -135,8 +136,8 @@ static void hdp_v4_0_get_clockgating_state(struct amdgpu_device *adev,
 
 static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
+	switch (adev->ip_versions[HDP_HWIP]) {
+	case IP_VERSION(4, 2, 1):
 		WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
 		break;
 	default:
-- 
2.31.1

