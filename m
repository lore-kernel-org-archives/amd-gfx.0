Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FC1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 19:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEFF60F3A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 19:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACEFF60F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492FB89B0D;
	Mon, 27 Sep 2021 19:08:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CDC89B0D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 19:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3CEuBylVDxfRFMkghBTYUL8afJ7e1EUY9ok+m1hfyYrUzcWvuxzeRRLonn54IGqdE5/JDA6HeLG8fZUo5v0Eg+Cb33HKiRYvCqnMfuYAvBKtNYnkZDiO7OuDPnn0GciY2k4BFSAPezQwq4uOR62abKnUKAgnBgD5ScrVTKf+P/3tNmJBgBF3c9heDK1FdCyXHU2y6uCKsxIbG7yU+/LhLun22m6p6D6NfecekeeS1xJBE2gOKTzvPFXIE8CfqlLUn0K7WfkUdaBKCXrBHJk4jZziVOkUhii3RwDcE+SpLzj4b64dyfrIvRChzhkGODqf1dZIO1t5k/Dt3SxRmierw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=l8kX/08yTcm/XN/ElXadUaPGShKrZjJjbyFHSC5sRjY=;
 b=DDq33EpIT9UMoTgOdLFSEZc8VRWgIS5Obyjc0YxMgty6xKKGp2nYGdUF/Svbh+P3NAC9tz66gM70fX9aJ8/6wlVTkkDbDIWchEzOuO25cJnqSVGQtdGIhWnmFG54N58vUKLnDQTnAg5GdpRM805vFHZ2puKcaPxbZyYKHix9KHXvWcGB+P8pTXvwi+/xeHIPurQYMcohxlpq/1PjcsfloOcIuXH4hulb/54pNcy4XHw4GchYCo1IFy/IY2LbNACJd2wxtitPRvw3nBzMRYf8UeF7WOhHk7LE33fX1G0cQRkGh0XI3FYC0rWGxSG2kajA3BkIioxnYYeH/5GenWTPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8kX/08yTcm/XN/ElXadUaPGShKrZjJjbyFHSC5sRjY=;
 b=EZWfS9hOF/OZQ8duh34cU6xSzIq71745b5rBY8Bi4kbA40qKfveXlvV8TNGUABYxlc5N7Phgty77gQ5eVpk4OMyHSeFDETMVlY65EUmSbuSUk/oNTO0sFLXE7OHuMGwe88mnIo/ggc71y6Gii3I3PyD1ANxYhNi+r0jubj6iaDc=
Received: from DM5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:3:d4::34) by
 BY5PR12MB3745.namprd12.prod.outlook.com (2603:10b6:a03:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.21; Mon, 27 Sep
 2021 19:08:00 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::67) by DM5PR05CA0024.outlook.office365.com
 (2603:10b6:3:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Mon, 27 Sep 2021 19:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 19:07:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 27 Sep
 2021 14:07:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: remove unused variable
Date: Mon, 27 Sep 2021 15:07:46 -0400
Message-ID: <20210927190746.675991-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb2a3e3-fc98-4099-72b5-08d981ea1f73
X-MS-TrafficTypeDiagnostic: BY5PR12MB3745:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37459DAC028B5472C3AC27D4F7A79@BY5PR12MB3745.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlC7G4Ked+K7MWFXpq9eNgczSTRF+KYe4MBuK/sVL2G382xiePd1M1J5D6Lf9rk2YH4SzufuHJ9NKPwX+WIbk0/EC7KKb5u42+v7maefAtwQYqbXf9KFI518fWGf2H50h1IuVrihL93RYFqmwy8ZVMTkDQGyCvACH7u8RXILbXpI1ivbGR4mzSZfdloOIKuD3X7bm8vtJPbcfF3cGgDJ3QmunXa9Wzux6Fjs7um/epMUZS4jsT1ewqW7/OYKUfOsYDHlEe/D9UzpEGWwKHr57pDrcUZrsjMt0QTP3/KMDYOyo7abkq+EMM0Kkwfqt6b9VaKM0RWMvpMTk8Dtz2BDlZklcYwP/4+vWkGTycZMEn36Ktm/6yeIYBwGVX05aIorgQDDGrDfiHvcQDCG1f5/khaHMCMh2ckjT3S7DcpiA0iQmy58aLavz+6wlg8aWxK1HXrW8IWcrfOjPsZ16mg7nFfDlfOKhO2Y5SpMvHeUX+KQGjmkGNrVK1DkfBoOSJ42in6OZAtDCb+f8wJz08CzraXp3DKDR1MN8WAE4dLatpVOZjz2g7BqS0d+OEWh40soUddcHK3eMVLYRh4YESugDvbf6A2jE8pPcovZ2FU6mKJSLK9KBAltpe3+W/9z3oTC3a6bV6nPn0yTDeCjYVzBAgf5Z65KPa0SsoQovrc8K7lP+6E48TnENnCZyERG9V1pbf1mcb9Do4XAbY6FdKUwNg2QZHf86uGYv5LBwtaN43c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(7696005)(16526019)(316002)(5660300002)(36860700001)(83380400001)(70206006)(26005)(70586007)(4326008)(2906002)(6916009)(186003)(82310400003)(86362001)(81166007)(1076003)(336012)(8936002)(2616005)(426003)(47076005)(6666004)(508600001)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 19:07:59.8796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb2a3e3-fc98-4099-72b5-08d981ea1f73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3745
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

No longer used, drop it.

Fixes: 1e07005161fc ("drm/amd/display: add function to convert hw to dpcd lane settings")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 029cc78bc9e9..5eb40dcff315 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -520,7 +520,6 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 
 	uint8_t dpcd_lt_buffer[5] = {0};
 	union dpcd_training_pattern dpcd_pattern = { {0} };
-	uint32_t lane;
 	uint32_t size_in_bytes;
 	bool edp_workaround = false; /* TODO link_prop.INTERNAL */
 	dpcd_base_lt_offset = DP_TRAINING_PATTERN_SET;
@@ -1020,7 +1019,6 @@ enum dc_status dpcd_set_lane_settings(
 	uint32_t offset)
 {
 	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {{{0}}};
-	uint32_t lane;
 	unsigned int lane0_set_address;
 	enum dc_status status;
 
-- 
2.31.1

