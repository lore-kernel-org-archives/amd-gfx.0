Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E94C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 10:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845DC22AED
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 10:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845DC22AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25966E135;
	Mon, 14 Dec 2020 10:35:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54EB56E135
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 10:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZcbBQ5EAEg/d9PbLqZc0647+0I0073TiwJFzkeYULvhj2GPm8DwBAPw1IqptLB2exPXo1mKIJs9K74q9MHD7Ds2hKGH7xiIdiAvJ9WSZb2wdFWKEZc0nBE3wstpDSkvJbL1pDzzBtcFKcLMMFIJi1rfJxgFVqlbWwWk8dJiwhNYH4yW0lYLn6E78FRrenuIj47OSs0vA/fmiMZQ5PIhJUeY9jyV2GivnDU5YwLVWa3kAjjQr/AcjbZ6t1/rdMnUD7PUXt7vtvZ9E0lQzbhRVBuEVPl/YS4chEhFu4S9NBIFGJnouGACzBaUUUGPkGCKSYRuaIZoc8P9BIuWoLZGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7QBXssnvdh2gXe1U4L9B7kLJrJuMyNl5Rje9KvXPwI=;
 b=W//VfGs35QP0XH+1Z/rbHezz4Q8M8zFpk+H9HrFFamTSyR1gIVaV744fbnAZva/WDuRGeREwqNrE0eTmEQWg8jyNoTXM1y+PtnjaliVKvfRc5BkO9ak6Q2NsWH9a59BwvNT7Ez1Bg5Y54XFHYoo+UC1hVecSDPCGyDJ8YeKRoBhK7n7/aIEGWw5MRJiHmrRQX5XHDOoQFFOlfG8Tq2Dh4SbS48JGvZFxTKbvXuwJGEmV7Kifh5TqjchzErZbj6fFoYv1xUouwkg/k9nVa4j9xoCXqS0rBWxoRm8UyRp6+YFTgDZgKQf2i/ZxWvI309F8TVXhr9VDuxUsOopfPChCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7QBXssnvdh2gXe1U4L9B7kLJrJuMyNl5Rje9KvXPwI=;
 b=qdZW4SBkrN3Zg3zLtgx3T+EmjMilNxt2h8vQp/7q2S+3N5Qz4Ma2GkePP6/QxPutyLcOqQm9AZ/dk4+YEUY0HIKn96H7D2/J19PzMGbyPcraopToYhjJbH5WWcAB3u9+KrftQFLdNeCkNzzhfGbA0a1kX/A+Mnuq1ZDnP9FgmiU=
Received: from BN6PR18CA0024.namprd18.prod.outlook.com (2603:10b6:404:121::34)
 by MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 14 Dec
 2020 10:35:23 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::c3) by BN6PR18CA0024.outlook.office365.com
 (2603:10b6:404:121::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Mon, 14 Dec 2020 10:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Mon, 14 Dec 2020 10:35:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Dec
 2020 04:35:22 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Dec
 2020 04:35:22 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 14 Dec 2020 04:35:21 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jane.Jian@amd.com>
Subject: [PATCH V2 1/1] drm/amdgpu: skip load smu and sdma microcode on sriov
 for SIENNA_CICHLID
Date: Mon, 14 Dec 2020 18:35:19 +0800
Message-ID: <20201214103519.20030-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05593ab7-ac65-4abc-3b1b-08d8a01bf675
X-MS-TrafficTypeDiagnostic: MN2PR12MB3839:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3839B0EBEA183920C55F49399AC70@MN2PR12MB3839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1N9g8mTuU2dRbCIJkkEmF2Ugxixr+q21F7NfQ64pHao/y8OIijdXNm8fv3dLGe6BlwDCcInNEBT85ghWHeZ3N+EF6Aq8D8VoTwalEQlpwiLgYvX1tcydSJJsdSjIraYopJ/iPyqoVyJuubfXdpuNSjuX1Siq2Z8yXMGjMjzMJeHl5tvQLZB5/FQw8U1r+yTxewvm0Xn85MBNeHg6GebxN8lOF8Zk6yAVTK7kPllhixs/lPDobB+EXI0OkvKhzt8meHYYfeccnW5wW2zV/D/MvlAIq4P4bRKYri/ICkTxLBjDa294DtOftcjYiWCW9iCA7O9XcqJLq0beyDXuxE0dSWFQXKZ3IjMw5oCgaTIYnMCAL3bOCuwFmojQoIw8rHdcjhM9u1giIiyz50EoWo1sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(46966005)(26005)(70206006)(36756003)(47076004)(2906002)(186003)(6636002)(356005)(81166007)(1076003)(426003)(70586007)(8676002)(2616005)(110136005)(4326008)(5660300002)(86362001)(83380400001)(508600001)(7696005)(8936002)(82310400003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 10:35:23.1914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05593ab7-ac65-4abc-3b1b-08d8a01bf675
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3839
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip load smu and sdma fw on sriov due to sos,
ta and asd fw have been skipped for SIENNA_CICHLID.

V2:
    move asic check into smu11

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c         |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 10 ++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  5 +++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 39e17aae655f..87566dee048d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -153,6 +153,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cf999b7a2164..8b867a6d52b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -847,12 +847,10 @@ static int smu_sw_init(void *handle)
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 
-	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
-		ret = smu_init_microcode(smu);
-		if (ret) {
-			dev_err(adev->dev, "Failed to load smu firmware!\n");
-			return ret;
-		}
+	ret = smu_init_microcode(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to load smu firmware!\n");
+		return ret;
 	}
 
 	ret = smu_smc_table_sw_init(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 624065d3c079..c3c181975c9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -91,6 +91,11 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	const struct common_firmware_header *header;
 	struct amdgpu_firmware_info *ucode = NULL;
 
+	if (amdgpu_sriov_vf(adev) &&
+			((adev->asic_type == CHIP_NAVI12) ||
+			 (adev->asic_type == CHIP_SIENNA_CICHLID)))
+		return 0;
+
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
 		chip_name = "arcturus";
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
