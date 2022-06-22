Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D94EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 11:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA51710E5CB;
	Wed, 22 Jun 2022 11:10:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC5C10E5CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 11:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8XQMOCy5ywMTQSMhDdvedBT+np42QiQmnCtm+wH1e5XWx4zATrz2iPAjsS/f9UgwCcpdCM0nriKVm8HAiv2a+k8HzOUjPlPOXhVpwKofYRb44aq/ogPfArAsYLMOwxhi75Bg/adfUQHNcNGMxuXOGvY33cC0C946bgsLztHD4GRtKCi6H8KxrWE2OCpXZAnenvd2sYjtfqTpP4w8F3htWRQdHzSmwfY1W/EbGCS/k6omAmMIeGAEbKl8fWV2FRqjA3d3cHNeKJXnQXK5N1NETBZamLtU0GR5XqUbuA8TV9MoxdZhK1714XbIH+m95iSVliACLGaeRXzoo49WbNhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku9s5ndqkxANgq8H+7gohcedYPB+qV3KkwvJne2vn1A=;
 b=JG+QQQ0Lo7ftmjtivbs6NdFTkYI7ZT1bRb2PA61IPlThaOkjwrEJtkpinrcmaaFANWsv2EqtK/xb9wfxxQPIW9eHonFRH/is8fFV2+oSI/gTisbmxA6J22Xjc/mAIjNVYXnLPZYRZ7SPnXSquEL1HF6/ziqdzaAx9iopu8/IeYPCMvIDKaO7lOi2/y2Kim38f59H8aYn6T5XGH6eAVhbfVVu/vu80H/ZCZjyhGNpxYEr7gEkbFdEBSfxSq7S6G8SXkSHhSmBdF2Xicd+2Kz6mx9Mupyl8t6OSKz/l6HBgxpatOlc0//mOs5Sn5N7XePustE1SpS02KcwKOdrYu7cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku9s5ndqkxANgq8H+7gohcedYPB+qV3KkwvJne2vn1A=;
 b=W4Gkpi6c4Qq01bnbgbnZ2c1dEpENUMMSRFsiwJcHajTjFe1llyWJYO/CQgSFSxUfsEhxpkJvO0pBMwz0uTrUOC9lBJ1/KpdhHaZWTT+KL3RfC57RIajKl0qvHkMUB1FjvZIYOTa8QuEQQj9CUVkDtsnW/m+KMppnYB/ECZF6Bk0=
Received: from DM5PR05CA0010.namprd05.prod.outlook.com (2603:10b6:3:d4::20) by
 CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 11:10:06 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::59) by DM5PR05CA0010.outlook.office365.com
 (2603:10b6:3:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 22 Jun 2022 11:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 11:10:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 06:10:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 06:10:00 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 22 Jun 2022 06:09:59 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: add missed ras block id
Date: Wed, 22 Jun 2022 19:09:56 +0800
Message-ID: <20220622110956.15496-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fbfa01c-fd12-4ca6-c73b-08da543fc06a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB012042D94A322ABE172AF5149AB29@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcEIYgQ7QM2sWj5ex2as1VRPy/bQ3azgrq21Mt1r9pShTWldS0+O1lrQMx+rdajEhbPMXb/4FeZlLp9msg3pGUCsYoG88CnAqcPrNasc4j9cNwclEzlYM4NwnwTGRqAVahoBZHpJ+krzdsqWVd5h796Wj+3Jx0iWrInhLzmjhK+9ZNe7jIAHFG1Y2fm/GSvY+lEt/WmNGFnrFgWpMULImm4topU6UynJq3dVSkOXGSOrTcF6LtsL2lFNtijeXfECCRLQggNOiJBwgEL492yYN8FV4+wd1P4Jwa+8mWR8TWItLPmfITuZb4azN/8aHwNbg6u9BYNSJjG1gBQEn30Buhp6k8nAF1oFi4indDMj7vD6TDtt1w9B/R+TPzrKG8a9kbofqHh0piFx9lU2T2hgtzeMGV4wJNbl4D9+kpa/cpAyn02anHJCZK7QMmukPJtABf61OzPfWxmz/0+ziA4p2lVxdv1Su7QDY68dcE9wiVqxLDPnJEz0BwBXmx5cJcOnKpxbaH2kZYaWfVHjwYx9xlOQ8F35equ/mKZkLX1UBfkroHL3/d2co1JxpOnZWJpL6rs0G1KTEMkmNUE2pw1XzJ2mBWJugvhFkuXzLU+CSteusjrRBNEYz/nPHthaId1i/9vnyAbixgmNX/RJw+xU4vLjS/TA7IctSauumQAguLd0y1717ITx0S5YtsOPzY7jYQHtgN3LV89rx1rEUwhRlPnKKuzrEnTVFft6BAdkXf+ov7vhfuxIxAVYlxFx7ARSDUkqKMUVJp4rFz/McboAAZ+Ul/SCC9tCAvdHypbOhJE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(40470700004)(46966006)(2616005)(41300700001)(7696005)(47076005)(2906002)(336012)(83380400001)(26005)(40460700003)(426003)(478600001)(1076003)(5660300002)(40480700001)(82310400005)(6666004)(186003)(356005)(70206006)(4326008)(6636002)(8676002)(110136005)(316002)(8936002)(36860700001)(82740400003)(70586007)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 11:10:01.3148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbfa01c-fd12-4ca6-c73b-08da543fc06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The VCN and JPEG ras are supported, so add VCN and JPEG ras block id.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bf5a95104ec1..172ead9e7649 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -581,6 +581,10 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 		return TA_RAS_BLOCK__FUSE;
 	case AMDGPU_RAS_BLOCK__MCA:
 		return TA_RAS_BLOCK__MCA;
+	case AMDGPU_RAS_BLOCK__VCN:
+		return TA_RAS_BLOCK__VCN;
+	case AMDGPU_RAS_BLOCK__JPEG:
+		return TA_RAS_BLOCK__JPEG;
 	default:
 		WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n", block);
 		return TA_RAS_BLOCK__UMC;
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 509d8a1945eb..30d0482ac466 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -84,6 +84,8 @@ enum ta_ras_block {
 	TA_RAS_BLOCK__MP1,
 	TA_RAS_BLOCK__FUSE,
 	TA_RAS_BLOCK__MCA,
+	TA_RAS_BLOCK__VCN,
+	TA_RAS_BLOCK__JPEG,
 	TA_NUM_BLOCK_MAX
 };
 
-- 
2.17.1

