Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77FDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BBC60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99BBC60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384696EA7B;
	Tue, 21 Sep 2021 18:08:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF756EA7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYgOVICQ8z1+OlcEAuAETer1A9Ijjq61pqSNxbLp6HL5r7ktwLQpGaEwEX83z5L/JRMT4BaRmO/1aB4YL3497MlwKllBaJDR23+JZ7JmGUL2AEG2i2yu+2Y5pPGIHPup0t61CFxXRuIvr+u6e4117EAu4m8dKpgcgPw7MRXH77O9Pxn+PPRE8LDoZ0QnLvVOZlYYvSxcrZ0ZpNlw2DSVtRhZTfVTIeg/G7OqtYhbWNTdELwiQAOH165MyrkPvW6VQyCwKrihFFaS8MXcpx0Yn+zWVwSsoDI/C05Zma+RmEE44wlkwzakmimQBw+IAadqKzihTDokTnXXIPxS8FZ1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=OTwuAkt1vuRWjATbUs2GJWpLgwaYMgwZwFtgeu+GkT4=;
 b=L7syycgIm67W6vQ4pEJRYEFnBpVJtvxx4LhDrsVCxpNhCoUL5GOWBZBbSL9yt16gll5PiOtOYVQUn3vCRt+a57R/QSZ4N5f0f+PtX5HSeMxV3AkCsTjVuGwr1A9WT/M7H0oh2hR0jTxNjqyfHQX3/kgmSTNWpXLT7qoBWTzozrZQOyBYDGU26fiKBwWWw7H31qb5BvwHRqaS9nwZQgLypA+u4bjvgMYnKpFPKnpHLtdmeVy8J1feaFin9zVh8lCdf7HNkTHKZFZMDquw5oUs2pdbBgip9UuoVGs81TyrVGFKO6GvXVTfrzjRNqtjZkpNYhUzEETcBwbml7o6vnbutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTwuAkt1vuRWjATbUs2GJWpLgwaYMgwZwFtgeu+GkT4=;
 b=0DltGjXoYWCEywCLwsL52nbu9LUuaxPeggF0sDJXy9ZHAFjc0LyW3o1na/L9iKrG7fzD981izIO4yDE7f1nG4CMY1bP2T7UtGUtRm2zz9u97Jx+e10yjTFNf4gcK1crsvYIdU2dWvV3sfrP78Vyxpg15CGROIS1u+5vpNpIwOpQ=
Received: from DM3PR12CA0065.namprd12.prod.outlook.com (2603:10b6:0:56::33) by
 BN8PR12MB4788.namprd12.prod.outlook.com (2603:10b6:408:a3::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:02 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::5c) by DM3PR12CA0065.outlook.office365.com
 (2603:10b6:0:56::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 45/66] drm/amdgpu/pm/smu_v13.0: convert IP version checking
Date: Tue, 21 Sep 2021 14:07:04 -0400
Message-ID: <20210921180725.1985552-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9468b73d-bdd3-420f-5c16-08d97d2ac089
X-MS-TrafficTypeDiagnostic: BN8PR12MB4788:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4788673D568BC700164E292FF7A19@BN8PR12MB4788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAgCqc9me9AuhA1S0XFk9BdlXy46AIUYYbg3755Ajz+aYHt0s7WlR5DdbWHXBS/9I/Zvt4gb6wtJvW/4xaHEvkcBA89iZeP01PfLtAanY3vttg2yMbPKx1/ttCHNUt79akWJKgzzA2138rnN1lTxQVtBqmn/O658BCiJ0s7JLAIkWWtADhjRDDJ3LNVehBi9WgTtlrY0buaqtbneOVL9f+XG7C6wywlSamB/d2wa8SbvMLgoSypFnNfgnkSDMnExq0743kp/2N7w0YYCxn0Xd205pUx2zHkcrPEWP8dIlHbglJC2ZIXoCVHEVcOPjJzKXkQ4sUnOZ+gEmiwDsZAmxca5mXh0smLmxZVkzB33/WtfEL2VvLHFqQiomFAp+MyjwPrYUB8uqxbVKP2VlNVImV54YOdTXie8X6YBeHxzcl6R/56LN8I6T9ssursyMcUFzOBykjy4rT9LSmHUr0P/wgaY8tkAJs+76UQDhS+s4wrJPimz6XmtS6h+AhyIVf3jAo6AuCNVB+kQKEUiC9raMGGVeHunfleSooKkNPsS+RLSsnZw6MP2p9nhF/LTvMhtHOCM7zOzAAsCp3x8Df5bRyccENeVVZZI2YvY/Qud1qyaIh87obaF8oym+DfHtOVZf1wAeszwp9jYfw0vKEA/4+haVD94Gbtu4WcVrAwbf2WHjadvdLsZU9WMoUgeRh5NEMhQtTjxB+P/lrjYc4Z8GodOM9qymT5cNMRu91UMbuw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(36756003)(2616005)(16526019)(508600001)(70206006)(2906002)(82310400003)(336012)(316002)(356005)(6916009)(426003)(1076003)(5660300002)(8936002)(36860700001)(7696005)(8676002)(86362001)(47076005)(26005)(83380400001)(186003)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:02.1092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9468b73d-bdd3-420f-5c16-08d97d2ac089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4788
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a0e50f23b1dd..08f3cc809fc6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -89,12 +89,13 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(13, 0, 2):
 		chip_name = "aldebaran";
 		break;
 	default:
-		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
+		dev_err(adev->dev, "Unsupported IP version 0x%x\n",
+			adev->ip_versions[MP1_HWIP]);
 		return -EINVAL;
 	}
 
@@ -210,15 +211,17 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	smu_minor = (smu_version >> 8) & 0xff;
 	smu_debug = (smu_version >> 0) & 0xff;
 
-	switch (smu->adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (smu->adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(13, 0, 2):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
 		break;
 	default:
-		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
+		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
+			smu->adev->ip_versions[MP1_HWIP]);
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_INV;
 		break;
 	}
@@ -740,8 +743,9 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
-	switch (adev->asic_type) {
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.31.1

