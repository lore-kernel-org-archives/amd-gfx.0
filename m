Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A54C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 07:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E9710E24F;
	Wed, 13 Dec 2023 07:02:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F4810E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 07:02:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJSmDl5ScNKlxp/dQ/OntHvzR05rP84Xs1lloWRtdiJKh/YDxMwvjRxapYh9Tbd6dAC8joCkFmCSn902O3Mb7Ap1R7v/dfw4Ekue+Y8vSyjGxioPbZstt57Q0GFs7qEFM1acwaQ2IX9sVNpSm6ZpY+ZzIZ7n1KGqtt5lLh1XZ4Mdwoa952UwVKwEFv+Vy5zHPGK/L9wTeUsPC1Yzy/4m4Ma5yWolfnJXmawHPFkMOQ3CiR1U3KitCY8aYw2Q9KRPl5RKO6Y9LXEkGbd3HmBm2M0lOkTGoF8LTgu5EVSAVyNu7PEfG0VXjKpfSJR6Rw7S+mBs++R6tXsFFU/CfyujVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3SIC3YxPppID3PfjnoyBndQHMgaRAgz6wnIJWTq6J4=;
 b=WLOUhKK7dPYG0Nq5o9/vjS4jNKhzyr1uICgNJywhcP6vddKqSgk4diV6IWTNKLByHzu8mrwdyAIVTiK+EMlNkoYk5WInpgDxqmMBmtFYr0FbzIV/kABXDBrHRhJ9M7ojie8XH9atteglrTfto8akNrY4vzLPXaRv9tQrlxOG2mpjGMGIqHKTC5rogyAKzY3zN7gjJVKsJ+jxTZIKyJF970/arFQGmNIPZ694yy0VpbS9BmbspC9uivjxxXIipc/KxPswzPvvKQ7asSGRvBLiwie3oUycjkO4657RpdT4ASoZb2mhSxyiHJKA1hzHY9kJNwDZ8vEM7XEO67aPpvkVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3SIC3YxPppID3PfjnoyBndQHMgaRAgz6wnIJWTq6J4=;
 b=3eq9JHWaNZMmFFDftS8WfktyroxrkrBH3D6Ria4GUKe9+eKnT3CJweo+osu/gfEfFBtlOjckO7FeVjm+JECaut7kFKqxCaGY3sW2kBHHbXJtlt9ulM0SvgcDElro+SH6+O0MucwaH2Y6ufy+m18qDEIN8QMYGJUdtwVUGw2SFj8=
Received: from BL1PR13CA0173.namprd13.prod.outlook.com (2603:10b6:208:2bd::28)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 07:02:01 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a2) by BL1PR13CA0173.outlook.office365.com
 (2603:10b6:208:2bd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 07:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 07:02:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 01:02:00 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Wed, 13 Dec 2023 01:01:59 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add power save mode workload for smu 13.0.10
Date: Wed, 13 Dec 2023 15:01:57 +0800
Message-ID: <20231213070157.972391-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BN9PR12MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1861da-c580-4bcd-c122-08dbfba967c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpwoNUsd9ht2ZgsG7bfry0qbH1YmF+10de+W9o6AvhJbaffuA3Vlh/jfnJ3lnpByiDyybR99+aRpY9uKhH8zJy+JGNJA8wLcuarXWpHiOMv4pL9AIUqd7NMbAQ56eMCUT6Yph/UoA1pYa8Qy2lj6j5jlddGbBt4hlub9OAb4wJQJiKQr0o0SQdJmGQefb8xpiOBM6Zrvv2uZjp8zOIxeVip6g+it4nehyXzm/kYM/S4FN8o9pF8ywBfhMqq0hYfFamKhKg2F9xDDAmStJ1zVTQW9pb/aF/HqRkUx5qzHpbHfTXPPfb65paFSaJuXnxlsHUL+JF9PhNV2enYjDiVsSdCbt0ZQzFhOlNVk7HJ4AnBpkutowXpDYGMG0bLekuWK5mIdq5rHVc+NqK69nwoeniklDAzVgJPdu4x2EZ2fkc4nJOEGf3RVZiu2K1YCEpk2rPRvZ7HQT9xs7JxTB9Ht26U7ehyjuNSgu2PuiYCCw82FNnUfGXYm53z3ihvKfDIWQMtbtuGDD+gS98wss7U2I+KT1NI1dRzM8cvG2cbsmmHeYzFlyg8igwmoF7Y0Me6lkbgHcILw6fJ25V3W7BFlde2NL8mGHCe4yFaKtobFcbKDG5whhoB2LrGJ4g1TQPsUfINYsh5PO5JN3x/+9us63T6FdK7dUfWspN/dAMD+m6rxKbVdA2WMmbflckxuw7ouzunxHtNvXErZU349YEnowDmDTAIihN1ex3pylKG3lf+K0rWeXM6LmWBNXVHIxQ/SuJPeohRbXzYzCJmnmIOVhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(40470700004)(46966006)(36840700001)(41300700001)(356005)(40480700001)(5660300002)(4326008)(8676002)(8936002)(6916009)(86362001)(36860700001)(40460700003)(70206006)(70586007)(47076005)(82740400003)(316002)(81166007)(44832011)(2906002)(36756003)(336012)(426003)(83380400001)(1076003)(26005)(2616005)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 07:02:01.1359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1861da-c580-4bcd-c122-08dbfba967c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add power save mode workload for smu 13.0.10, so that in compute mode,
pmfw will add 35mv voltage margin since some applications requres higher
voltages.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a24aa886c636..231122622a9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2545,16 +2545,19 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 
 	workload_mask = 1 << workload_type;
 
-	/* Add optimizations for SMU13.0.0.  Reuse the power saving profile */
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
-	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0)) &&
-	    ((smu->adev->pm.fw_version == 0x004e6601) ||
-	     (smu->adev->pm.fw_version >= 0x004e7400))) {
-		workload_type = smu_cmn_to_asic_specific_index(smu,
-							       CMN2ASIC_MAPPING_WORKLOAD,
-							       PP_SMC_POWER_PROFILE_POWERSAVING);
-		if (workload_type >= 0)
-			workload_mask |= 1 << workload_type;
+	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE) {
+		if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
+			((smu->adev->pm.fw_version == 0x004e6601) ||
+			(smu->adev->pm.fw_version >= 0x004e7300))) ||
+			(amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
+			 smu->adev->pm.fw_version >= 0x00504500)) {
+			workload_type = smu_cmn_to_asic_specific_index(smu,
+														   CMN2ASIC_MAPPING_WORKLOAD,
+														   PP_SMC_POWER_PROFILE_POWERSAVING);
+			if (workload_type >= 0)
+				workload_mask |= 1 << workload_type;
+		}
 	}
 
 	return smu_cmn_send_smc_msg_with_param(smu,
-- 
2.34.1

