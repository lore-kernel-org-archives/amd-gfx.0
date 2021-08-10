Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE82C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 19:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DC660EBB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 19:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54DC660EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1EF78984E;
	Tue, 10 Aug 2021 19:15:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28CB28984E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 19:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYLWJuJXjD23Ex+iydtaSkomBIHi/1nslD8XjV/+fI04fNb/VyNz6IULuI4/iUfX9bee/o/hifTRKTG3yvAewWUYxJ6Wp9RYGt+tlBDfnQ5tq1DUZ0+PflxZBsK/DWMTsmhFB9vuGdqRhKCFk8wCVGMcPhmnhdQrvaSF4AHZ++4iaCwPPgUHeNYlo0KBzrRpeN1lK1JBLQTS+Bq2hkHbjqgeNH0d0ShU2g7SqCDDbTegFDXZ1t2INmKCGB645EmkG+n6LyilqwkTdVzsZsDcd1MqP4bYTjD5eokhCLXSqmXK7TJm41tdZVM3GpczL13ZpkmVbwJsNhnCsOCgQmZLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vIM2c/qV2jvA2y9RZ/ZjYlKGr3KjAQy1YDr/B80qrs=;
 b=W3gQ5BAksv5Ca15EzINTTbItJJ3768qxf+CbxonJvRz6uRBIZxchpeMmxs0FBpsBczp5VOCTuQlareTSyskxSN4wfPHHyvtw8jZ4ntt2Jo2Rar3j3Pf7YDMSy1tuDD+XBm8qTy2L+pJoE+83lyT1jb52yK8Afw8eOYORYuzcKeL15ETuasIB7oplvjVyQffqeW3DLfL0cbc/vGbsKPaSkcNvY1sdRei0b6gEl8rAG478DZHxJzZG+72lx1otlgjxO5ZrNO4DnXvzjo1ioa/Csexij16HGRmCxPMxawbvZT+nU6oS60G/C95+MDBCp/V/ZzQImsP3etfH0/2zQ7CHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vIM2c/qV2jvA2y9RZ/ZjYlKGr3KjAQy1YDr/B80qrs=;
 b=WtI7a26mM/aCN6K15FOUloaz35bhMR2UBOnfws8NTbBs3+sfVI5oMhiITw61W95lYsCBAEakEWrsn8e2IPvKVzmkDs9TeAm/IDlVbpxRd0gmr/XCQslwtir4m2CFWqqtQ+TERQh4nkL1jC6LPWCTGGH2v7tDfQaJ29gOiyMshtk=
Received: from BN9PR03CA0263.namprd03.prod.outlook.com (2603:10b6:408:ff::28)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 19:15:46 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::75) by BN9PR03CA0263.outlook.office365.com
 (2603:10b6:408:ff::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 10 Aug 2021 19:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 19:15:46 +0000
Received: from devbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 14:15:46 -0500
From: Ryan Taylor <Ryan.Taylor@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ryan Taylor <Ryan.Taylor@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: graceful exit on restore fan mode failure (v2)
Date: Tue, 10 Aug 2021 12:15:28 -0700
Message-ID: <20210810191528.23430-2-Ryan.Taylor@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810191528.23430-1-Ryan.Taylor@amd.com>
References: <20210810191528.23430-1-Ryan.Taylor@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ba8854b-08cc-4911-5fb6-08d95c3341e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4234:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4234A89156FD41D22FA329A0EAF79@DM6PR12MB4234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wHiafbPFA7YiDCF+/l52A2pZufFnyTKOLeBfTxakFyuoTjZXCB0mzIIvhyMfDrhHdQDcucE8AUNTPaJf6mz+qD3bLHSQbJkKXxG+HasX9nWMRxSpZXlSlXmQGhVs1m3TYtMrSAIHypv6Vz+f1l2sziAilmENyhUjShaEP0105wzeUmmuFxEP/OiRJ+isNxdGaMW0sBMiqvs5RrdjZiFdQpK5THIDAUMQ5b6sedp+x2ViEdv7mPtYOT8iqqWAkbFzfczp6X5c/G8T8qdsB/kHeaPpBHMgMcYRBO05+jPha2UQcQqcmxNzR9Xx+vtjOBWz9uz41JXPAYOGLmZ3LHyQW90TGxB0ss9SHaq07JnJOVh2UNlVmXy6yn8bZAULz1BhhisLj/XSE2gXgwkvFZKpdeiiua/tCfZO+9YaMTB4aD5zqDAGFXzQ1yvoDPC6pm+ozKY3UxO7PBBe9M0fiOizhC1mGvDS0dXns4vmmxjelL6mJOEMACuIw33aO8DCFpAjYVoldyXZCNAYMuSoqh3Vg5I/x1j7j6c2wWtYRSu+GyMKjUuuhM6OVxMIV597gpoHMZoa66pHnVmjw1mGii/r133AznNywnL+eX3ywi5rIisOvn+z2Xplq77W2FZTuQ6fEBHBz/RG4+VUSG8I483GKVVcBSUaF+b82S37plAkWxBStggotaC3F8buwVVvv7exFsyWOxWyXHeVuqY12jo13Ehqxrm2TWl2EKt7mEstZcGAmOd7z6NCOY+2WIYfkftF5kn78sgW2DFc8/BemnINw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(426003)(4326008)(34020700004)(16526019)(82310400003)(47076005)(83380400001)(186003)(8676002)(8936002)(7696005)(336012)(26005)(82740400003)(81166007)(2616005)(6666004)(478600001)(70206006)(316002)(1076003)(6916009)(36756003)(5660300002)(86362001)(54906003)(70586007)(2906002)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 19:15:46.7638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba8854b-08cc-4911-5fb6-08d95c3341e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

Attempt od settings restore and disable restore flag on restore fan mode
failure.

v2: Update fan mode to auto and fan speed to zero (Lijo)

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Ryan Taylor <Ryan.Taylor@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b4b4d615bcbc..00d594e6dd85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -407,11 +407,12 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	    smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_NONE) {
 		ret = smu_set_fan_control_mode(smu, smu->user_dpm_profile.fan_mode);
 		if (ret) {
+			smu->user_dpm_profile.fan_speed_percent = 0;
+			smu->user_dpm_profile.fan_mode = AMD_FAN_CTRL_AUTO;
 			dev_err(smu->adev->dev, "Failed to set manual fan control mode\n");
-			return;
 		}
 
-		if (!ret && smu->user_dpm_profile.fan_speed_percent) {
+		if (smu->user_dpm_profile.fan_speed_percent) {
 			ret = smu_set_fan_speed_percent(smu, smu->user_dpm_profile.fan_speed_percent);
 			if (ret)
 				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
-- 
2.32.0

