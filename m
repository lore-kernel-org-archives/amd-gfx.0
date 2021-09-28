Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FE6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA676101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FA676101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59406E8E2;
	Tue, 28 Sep 2021 16:46:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836D66E8E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfBZD3fKO3oNJ401VRpAJvU+BXuL4d62oNXdynIL0FALMCUghqJOT8f5ma/au2qlrtStvWM0dx4cGjTbkWrqQvyNGQeyubTWazfmMqcesxMQpj/jo9KKULTmohg1GP6laE4mKKoeMeij+wwjw2js1mRUELfwO79r5kUtxImh/gpWr44PvEzY3iRcLoLd9AE3X5Mo6yodznYgKFanhXcPQTvzpmh+eBQMWsgCyf//isQjX5CmudavRGge0Ga2OXLVi0ShxDYETHeHelA8KYY3d92VIctVLDfJwlrx7CmxG+6vNi0G/u8vAUlANqVlxCfpRisL0pQdT2J4NTqGr48l6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2JnsguoFUFuXu2/aPC4KhSkJxcl+VLpvc/tcNtfLU8k=;
 b=kYKo6cRHu7+Jo73WiwHkBjvYIeSDvcYGsW7YDW+Xhdiian/zFVlfgTntzV0Km88PFV//P0KsNG+Lkn+GZaDWL3CA1MU8HL/fWeNZ8oaEmXu5dyNiwW1lETWZ9CzauFSUujlJRtuyVdFeOmloMyEoTZ0Kh2WfL0I1PHegZZLTZv0fZyEiVZnmWxdoRDmlj1j362/ZtGw7oh4Siw5y3+mH+mO/ALGQgzVqPXoSCQvH3RQquBhP3sNYqzUp8RGblrt1RtP8riKRkg2Owa8KaX6jbS1j1jVCih43d+W941BqKQHCAv1EMGQwVrxulPUM/Qi6Uu74tNxx2gjrqdiC5mlsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JnsguoFUFuXu2/aPC4KhSkJxcl+VLpvc/tcNtfLU8k=;
 b=IMNcfiboRhJovPc1K4VVY43rkFnYnh+LTCcCwUZ83yodzELzKNfe5eew2BLDsw5vQ6LtMvtN4qn3mwo+gt6drNtEtEUDsZoGphAPxNDzaojdWL6Io4M+cfIQI59pc2KswCUlETYXQ2xv/vwm4anaYnpW9K3EeqKlce+LAwUqT8M=
Received: from DM5PR07CA0133.namprd07.prod.outlook.com (2603:10b6:3:13e::23)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 28 Sep
 2021 16:46:24 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::5b) by DM5PR07CA0133.outlook.office365.com
 (2603:10b6:3:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 57/64] drm/amdgpu: add new asic_type for IP discovery
Date: Tue, 28 Sep 2021 12:42:30 -0400
Message-ID: <20210928164237.833132-58-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 43a95e5e-9bf3-4fe4-8d16-08d9829f8203
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13813E21EC2A84279E3CE34EF7A89@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEW7TSYACDeUVkUKYs/6EEHfHyhY1nW7zKz+L3amtS4B/rISQuNvb7ppOwbPWtqdeGTm2ukKLcxJ1TYLjmXo+d6yz/4SkrFh5zzMc+1+mAB9u0OjPVT7c+OrxXkfuc4T5J5KsLXRQtsg/rIHuor776G/E2Vvu6iOAosWqL3INo7FQg3W28qn0rv5NIp45U3FTOuNTyAvtF385QCOJi9AJHPzOzOGsevxhmNqklMRP14g6BKZvw3iiIQKWXRNwixjjUc7Oj0xa6e4mHeL9JgAjK2fvBsQvU9Sae7adqe5nImvtzilT733IHA78DzbOfL3FQXoWc5s21Mmzls0OLxBgr8m1JdSzuvwKYn5QH9xY54Tvz6sFoHbB/YWOS8c4b3aa3dKHb1/jFDm3qUrFqBs1469K4aMbcW2WevX4JKMURF+SDOXoELKDogX2YIN3R/LZdPQRBtnXp+bToGG2819HslrABPLV7oau2EHxafswgiquNMtQSGH8V1tdr6I5LX1OU9gFAAvtlWSNkoM0MingvIX8uYHTaAU30HPG4dst3Tqxeec6F6CeHXJ4sb38lOvXOhCwfNbKLGtQvsQwAuT6OR3ghvUg4C0NkAC4VOhs7MAUAO9W55fbN881LMK+xjqpbJ0HHsHzYtV5dWMHehRUVUJHiApyZHsZi5sOd1RsXqpoAAXgW51ILE3HTIGBddtBfXQRZ7AYFQdBcf9SEDjYXwSLdlzK63pVAU4++ZszWg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(5660300002)(16526019)(8676002)(2906002)(26005)(36756003)(6916009)(316002)(82310400003)(54906003)(36860700001)(7696005)(8936002)(47076005)(86362001)(508600001)(356005)(1076003)(81166007)(70586007)(426003)(6666004)(2616005)(70206006)(4326008)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:24.1588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a95e5e-9bf3-4fe4-8d16-08d9829f8203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
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

Add a new asic type for asics where we don't have an
explicit entry in the PCI ID list.  We don't need
an asic type for these asics, other than something higher
than the existing ones, so just use this for all new
asics.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 include/drm/amd_asic_type.h                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5e53b54bbeff..b607c76e61a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -125,6 +125,7 @@ const char *amdgpu_asic_name[] = {
 	"DIMGREY_CAVEFISH",
 	"BEIGE_GOBY",
 	"YELLOW_CARP",
+	"IP DISCOVERY",
 	"LAST",
 };
 
diff --git a/include/drm/amd_asic_type.h b/include/drm/amd_asic_type.h
index 0f66a0d9f06d..90b69270f2fa 100644
--- a/include/drm/amd_asic_type.h
+++ b/include/drm/amd_asic_type.h
@@ -62,6 +62,7 @@ enum amd_asic_type {
 	CHIP_DIMGREY_CAVEFISH,	/* 33 */
 	CHIP_BEIGE_GOBY,	/* 34 */
 	CHIP_YELLOW_CARP,	/* 35 */
+	CHIP_IP_DISCOVERY,	/* 36 */
 	CHIP_LAST,
 };
 
-- 
2.31.1

