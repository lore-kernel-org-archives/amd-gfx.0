Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B39DC47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B2A61008
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B2A61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38AA6F39C;
	Thu,  3 Jun 2021 04:56:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44706F39C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 04:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2gK18oOvSy8ZORbUCgpEtI8EdR0hqDg3WMaW0t/nWnvY8Ic6DMXwwPMu9AtJa5IR9c5q3CWu2TdaMvv2QD3yokPY3AUXcP1p6dmHMfTXUBRZxCtQVgEj1xaKUkC8rDXeUxJiAP6yu2zJnFkMn8Fr+me5dMe0O6ZljtIHB2FmoYv10ePsbKPnTldfYbKLtAoweJ1Aejw99LzbZfihfclZKMlmGQrPKnwaR1rLH93joF1+Tx//hag0u6M6V2w7Kcot5SQ++xSkOKQZ1CUDHtFTUpzkJp1XCMRA6Gh+9DiD9pfQ/oAKNe1JkrJfZLyJ58Os9g3mkLs0Myl69SE2UPF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F2swNINsHXhK8IVaiCv49vOx18t4W1h7dSogoyD0b8=;
 b=XLvyO2UoeDfgfC3EgMkB5NySdQcYTI8wEFE2JLF3TuCsOXmZXHWuhmQOT+GUgRcdFjLEzDv5gBZnOWE8qJ+nXykLt8V2mEoXRabsp/OnMmaIrsInuI4Utc1iCsJSaVe/O8r4tiTnyyJG77PVmknfjlwjtwhJrsZzICMPZr2fMrwPjO2GMOdDqIsYZuqnyNyVJwLF35k5UKbPgDabf9obpBzwYWSLKJa27lbqsDYCClDwEQxHGafjvyPPxknhnaW4FVuG8jLEhjzxDiNKfw3kakHSCMMYT8mE0ndu9myEAdPzPAEpC2MrYg9qg72ECpnQduXZdoexc8T8gzNXkuPJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F2swNINsHXhK8IVaiCv49vOx18t4W1h7dSogoyD0b8=;
 b=uA7g1UljJeFcm9RR13Yq4QxQ1lBqZMMI+E60r/BbteDH5yOzX77EFPC/6oqNKSPrGnFlUvdaN0TYmuovlS4PhQW8GMrON/JqRdL87+AHEINCThaMmN0QHgF7fqiLyQ+ZIWf+Cso3i0TvrtTDvyOAvmtC/JwvWbRSPTlYfqG5y00=
Received: from BN1PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:e0::29)
 by BN8PR12MB3041.namprd12.prod.outlook.com (2603:10b6:408:46::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 04:56:35 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::13) by BN1PR10CA0024.outlook.office365.com
 (2603:10b6:408:e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 04:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Thu, 3 Jun 2021 04:56:34 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 23:56:33 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amd/pm: clear the cached dpm feature status
Date: Thu, 3 Jun 2021 12:56:02 +0800
Message-ID: <20210603045603.977998-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210603045603.977998-1-evan.quan@amd.com>
References: <20210603045603.977998-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fcae26b-5853-4840-0507-08d9264bf641
X-MS-TrafficTypeDiagnostic: BN8PR12MB3041:
X-Microsoft-Antispam-PRVS: <BN8PR12MB304140BAC6A16AEFEAA6E64FE43C9@BN8PR12MB3041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76GnIAvCtw4jc/KC/X/EUXqantPs10SEiClUyOWJOwDsjLkKH6Lm33+vApgA1iPlE6YvHWKIyyWRAXaEbjFATQo76kNU9WvHVhgaHBe9aescUFsmRmKpCxnGrLU6LY0bVgcgfyOSbX8SoPT064/c/PlMIElyCdw2lscj3jqKpfrXtlV1kJDWIcDduueiOBt3o3m2EkEvWHXu9M/74JRp22w8htIEAKzKyHsYGdS1eYtzXRtIp+BXkE+hRe3v4Fzn4ujy35GKle6Gt7B1Ek9U+QanAe9K3RdvNgRcTk+SSmr2E20q5JgH8wERE7XB+G89FzjLBoNGfb90uXN9cW6YNlvmvyuDTskhOrCqegjVDuDREvZoK7K23I9y/o3KkR7yyL84RCqU+aKCQxYUPsx7hRt4HW1LsUEdSnTOyBZSS6Rjp/Aut6CNKLLyLaRkZBuqy4WFBkXtl0RGRyCInmEmwCc3BZEcOUB07QHJEANbymlG98ynwU+g+d3pR+GaWs8mjAZmN83hX+dUlvJiyS79YQLlB3IosPXIQwXWc2ujv6B8pe5UHoh5vELH921lW24lkv/I83bU1W4A3PCAtdym/IK2oy981pQ7zDJY7+9R92Rg13BJDTCDWAtweI3xcd7vsV8PAVDG4z3dBdKolDB6Difa1BrHhqvhlehNS2i0fxcacfnLdv6SPytHUMqGg0BR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(81166007)(2616005)(7696005)(36756003)(5660300002)(47076005)(6666004)(36860700001)(44832011)(86362001)(16526019)(336012)(4326008)(8936002)(8676002)(316002)(426003)(2906002)(478600001)(70586007)(1076003)(6916009)(70206006)(54906003)(26005)(82740400003)(356005)(186003)(83380400001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 04:56:34.5065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcae26b-5853-4840-0507-08d9264bf641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3041
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some ASICs, the real dpm feature disablement job is handled by
PMFW during baco reset and custom pptable loading. Cached dpm feature
status need to be cleared to pair that.

Change-Id: I9e37d80e13599833301c04711b097fb37c2e41f9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c9a31556e077..fd7b1b8edeb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1352,6 +1352,16 @@ static int smu_hw_init(void *handle)
 	return 0;
 }
 
+static void smu_reset_cached_dpm_feature_status(struct smu_context *smu)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+
+	mutex_lock(&feature->mutex);
+	bitmap_zero(feature->enabled, feature->feature_num);
+	bitmap_zero(feature->supported, feature->feature_num);
+	mutex_unlock(&feature->mutex);
+}
+
 static int smu_disable_dpms(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1374,16 +1384,20 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
+	    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH)) {
+		smu_reset_cached_dpm_feature_status(smu);
 		return 0;
+	}
 
 	/*
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
 	 * on BACO in. Driver involvement is unnecessary.
 	 */
 	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
-	     use_baco)
+	     use_baco) {
+		smu_reset_cached_dpm_feature_status(smu);
 		return 0;
+	}
 
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
