Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24501C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 13:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7828810E3C2;
	Tue, 24 Oct 2023 13:41:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0DF10E3C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 13:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEcrnsQHqyjaZClkdbT35SQiTJ/nkrvRB/UH8MwNf7115e6mMEtc2cz/UtojfRQQna/CDWLq/lmjqp8PUSTe2yMpkF2tYsFEHn4n/quy7G+nkxrzCTEgnKo9EsQD/qXOuBcUx8EGDNeglTBFCvWckT9/Afdq54oc82xf4Sdlt1TEOrWk5cK3cRHZf+sI8Pi1M4tmzfR1JwRGhBFULzOsjuNi0qePuwJ+jkMW4fjVbl+1W0v2EPsdx1AbQAOCAaFZyTVaS17fiZlDGQGmzlBYmiQfvWOlREti8X4vrvX5izBguhgoZPQCX9fnCNavz8Gk0sRc8awwlGaYKB6aVUksnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0Vrbr9sAwkEm9T5ZUOGlFEydrApWngnEpHbwlgoWKs=;
 b=I5L3NRWuooMuHDFXqsx4b5EsLK4cHamCNLbM39kTC21gB4wnPs3aBfuUcSHlxP2GygHloCHZA0qrvokDAg+qi8zeEXMozrVz7tyfIq4eka9w9WOYoQepky/41PannZD5woWwMwKW8HgLMNz5hf41fUc4OVF2mWbTs/7M8X69Cwo2dATpVKVsYcoJN3RYghbYPJv2tqrKu4FrjGW2hO+ckzylbV2C4XjQPDquR6jV4Pfdb52heRuxkkzL+qxXhTT0+WiT0Pn5hr1xjHMKkbrS/YcxauLRXbhm16twlcuRgVFUyJSOlK2QSQ8LkQ0mm1EqbMvtkWDzZ+sCc+AlH3EJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0Vrbr9sAwkEm9T5ZUOGlFEydrApWngnEpHbwlgoWKs=;
 b=bf7uCCugDOaF7Xi8ndaUV55+S9kHKIzU5ss5Dp9CXeH+1nwqKI7BSLSTKkn/k8ZpwHEfqo6qwP94kro1BoziIYvOOvqfy7bWNH3/0rJY5J5yvgaABheVNItPOFpsimjc9bHo69cA0h2wtgBvllUMQt0xt3KLM3llpxNpaFCZ4Qo=
Received: from DM6PR18CA0020.namprd18.prod.outlook.com (2603:10b6:5:15b::33)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 13:41:39 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::5a) by DM6PR18CA0020.outlook.office365.com
 (2603:10b6:5:15b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Tue, 24 Oct 2023 13:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 13:41:39 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 08:41:37 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: call smu_cmn_get_smc_version in
 is_mode1_reset_supported.
Date: Tue, 24 Oct 2023 21:41:24 +0800
Message-ID: <20231024134124.1601125-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: b416a0e9-9611-4fef-0d9d-08dbd496f371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HKm1SmYHLX2q08owKJv5zcRDVDNQleG8DEda9XUp45rT/zZqvumIMEfHGQYkGsj7AUgD10CRYgLEx9IJz2+u8enekExTYgP2enVrSrETEl1vRqYaPTMkpFSYRfuwKaeIVrrdvufC30xVBkfm6b5bvSZK64hefjghb/JaMSN3Um5g0oJLy2GvX4vvAX10fS71XQhX3R2+NwyQ419HGI8uFJptWaJxoKzFBepNm7Z6uRqvpBFLicQ323yxXjjv+T7PIzwApgzrou02v8HEWOgkhaf409irwhDhqK9w3alXpYghsZhg48MtWYZjBiyJlcsuABr+tONrairEvQg7QcMcJS8dCazH3wT73f9Sk1qFP13arKedwnI5lCgI49FuQxDZdPUjZM5Ewkowq6VK3QlDQCPEMTKKFwog3r7B8Ml01Pv6XQyXdW9yJ+HKD1qHXsuRVUQXczf4u3uh+/4ScKVvELS2tVcTtmOfCVVNaqwjVcsOFX5wMvKFVdH99lUGHBxQVgtEVyAlu8QNLX/cYbyflpoaJXBHyTmq81Ie8cymgZsgk9aXaCvUTwnmS+NrNWDd5Qh9mTnnuIv9LMSXLLsbeK77xWmm32Nx3bd0Zo7DG3l57UdOEPyWaQtMyplismr77nOLwB6lcwRC9can/4d6unhZyT24vq2RXnSVhVIYodbEO6bfz/wyBDsMOcoW3XI6x4AUk+MctTCkyegn3XHV5fZxSei7bZiyXFutt4ge/F9KwTIb9AIZ+2YB8rzhHHocTYPNpvgj2/+9jcvclXJ6zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(46966006)(36840700001)(6666004)(7696005)(6916009)(316002)(70586007)(478600001)(54906003)(70206006)(5660300002)(8676002)(8936002)(4326008)(16526019)(40460700003)(41300700001)(2906002)(40480700001)(83380400001)(82740400003)(26005)(36860700001)(336012)(2616005)(426003)(1076003)(81166007)(356005)(86362001)(36756003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:41:39.6731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b416a0e9-9611-4fef-0d9d-08dbd496f371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 candice.li@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

is_mode1_reset_supported may be called before smu init, when smu_context
is unitialized in driver load/unload test. Call smu_cmn_get_smc_version
explicitly is_mode1_reset_supported.

Fixes: 5fe5098c64d9 ("drm/amd/pm: drop most smu_cmn_get_smc_version in smu")
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 +++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 090249b6422a..77c3d76c76a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2461,12 +2461,18 @@ static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
+	uint32_t smu_version;
+	int ret;
 
 	/**
 	 * SRIOV env will not support SMU mode1 reset
 	 * PM FW support mode1 reset from 58.26
 	 */
-	if (amdgpu_sriov_vf(adev) || (smu->smc_fw_version < 0x003a1a00))
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return false;
+
+	if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
 		return false;
 
 	/**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b1433973380b..648d5eafb27b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2615,13 +2615,19 @@ static int smu_v13_0_0_baco_exit(struct smu_context *smu)
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	u32 smu_version;
+	int ret;
 
 	/* SRIOV does not support SMU mode1 reset */
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
 	/* PMFW support is available since 78.41 */
-	if (smu->smc_fw_version < 0x004e2900)
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return false;
+
+	if (smu_version < 0x004e2900)
 		return false;
 
 	return true;
-- 
2.37.3

