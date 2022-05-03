Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1806BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A82710E9EE;
	Tue,  3 May 2022 20:09:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF5010EA0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNGWlke3hexNPP2uZcU8jBOq/JEMYzCYW4jxgV8qJJEHsIh8Zv+fJKW0QS/5DSruBE4IjR5THVkkGtsnBEkrmJeNcPZ6ScNEfSjG0ggqj2VRwBLkhjJeNtH7spCiAKHHhrPl/yYR9z5rkluSFn7PJAHC6X5rc/kJ2+y7yxcudF0c2h0xgFRgXApzWRGIIa1vWVzMC/F7+waKcsjexaxcqUYN8JqUxTALK4UCBHGLEX2KvkupL2oCUeapHZS7Ve+BLco8ApqIoNMDhAfekhhZ8Y0Wf5ypHzJ+zLc8P+fRtehLDRGnY1tzeZFxz7Wb0SAR/hp6tKrlVKJ5v8VnfISIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovSdN/opnYYbf+5xboFFzTAtzDl6LtvBpf8yV9CSmBc=;
 b=ieMBKJhMHBZgnUzcwletwydwLemj17zabESfSPtwgGltDmA9AmT08polpYBIzdjzz4C7z+zTbsSzvHmUgknXAC8zoPcriqpTrLWukOBeYDXbGE78KS2tr2gkdHTW24iUSWlgZmhI4d5t3CA8Mti09DpXL5n3mit6aXergU5rkWTvhZZGtv6s40HTszgth/K2dN1sy5kVb7ZCwewwi5PJgxxcfcCCBxreNGLRVK6mdqnUx3M7e1WFMKNKezvc2YQhGz48yUKh9SGpGTIRkIPoMDEAK9UcOCUQBeZIYNZmx72jjM5UsKLVAbDhzUEv6jQvt5oqoa+QVHlyCJXcuLGoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovSdN/opnYYbf+5xboFFzTAtzDl6LtvBpf8yV9CSmBc=;
 b=reGCm4r7eZirEqraDMluLMiaN4wfzy3hsXPkT1nPfP/T6PYIA/57pMEuAYzLAMl7b0p/Teh2oeBPO/xjE61x937lz2zpJdUmi+/ojbCKkpb2EJqQD16N4k2Rdwc4Ox7AZJ3hCLsH6MZg9c4bI37+2ftpCJ0F7MNQ5COc0t/FL8o=
Received: from DM6PR07CA0043.namprd07.prod.outlook.com (2603:10b6:5:74::20) by
 DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:09:15 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::ca) by DM6PR07CA0043.outlook.office365.com
 (2603:10b6:5:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 20:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: support more DPM features for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:39 -0400
Message-ID: <20220503200855.1163186-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1f1965-2756-44ef-8913-08da2d40cc12
X-MS-TrafficTypeDiagnostic: DM8PR12MB5495:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54950472C346DA648ED9E01DF7C09@DM8PR12MB5495.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sI0qU44/qi41m2gU1asx2ueLcCVUBdbfvpndoTiCCDL6+k1r/0cyuVaV6guiR5FLWMuhJm3I7mBl1Kc1XrGelhcY5AmCEHQJuPOaKnPnZkKY9v6wMtsm5uuYdCL/qTGlZXllTI2b6YdB9+HQ3T5OOOdybCdV729b1wud6ugqZLPjOzBVg96lKHDn5n8SrevV61hIVR5h5jawNnkzrOvkqw13e7KkL1nuaecKyaHFGyaT008JAIVg3xehxWc2s3gGwPT28OhTlWzdT5GizWvWgrUBChpj7eax8am12l5azaMSIwHc/UB8Bk/nKMcSNbGWjDW3vjgyO1nusnPZZoYrAseALnnoH5S5jgjjSSpS/kT01R11wr+MaI1ctg4EnBOZA3AeH4ZTyyqiX+fHrQXofHFcWz8q5YOZJBqbbXNAkfVaBOcQ7WGPNo+8tiWjIyOOCImjneB3hyRJIT66uCCwxh7xldpL+iiHeHQ1H4sNMcdvx/fKWzw/antOOt62F/JErw8AhoYW5KnJqPi/vUkA4UmDjcZS98sAE1GjFqj9wP0B9eqRUiOhobnUULzHnbwykfN2w0DB3/vzBEOX57l7+mJ8N9CznyqTkuA7TbsPEfCdtC1srkR29IwtnDFc3E8uitxzbbP5EYgNmc2Mf+KAeEZA8zbGbqT4w+nC1Zy7TcwYpD4xWDQUen11HthC/LVOrm8xjQw2BW/svrkL+inc3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(16526019)(186003)(6916009)(81166007)(40460700003)(54906003)(356005)(5660300002)(316002)(4326008)(47076005)(70586007)(6666004)(336012)(8936002)(83380400001)(8676002)(70206006)(426003)(2906002)(508600001)(86362001)(7696005)(2616005)(82310400005)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:15.0176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1f1965-2756-44ef-8913-08da2d40cc12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

To pair with 78.30.0 PMFW, support more dpm features:
  - UCLK DPM (disabled temporarily)
  - VMEMP Scaling (disabled temporarily)
  - VDDIO Scaling (disabled temporarily)
  - GFXCLK DS
  - SOCCLK DS
  - MPCLK Deep Sleep on VDD_SOC
  - MPCLK Deep Sleep on VDD_BACO
  - Memory Temperature Reading (disabled temporarily)

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 74d7fa3dc00d..b43884cf939c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -225,6 +225,22 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DF_CSTATE_BIT);
 
+#if 0
+	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK) {
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
+	}
+
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MEM_TEMP_READ_BIT);
+#endif
+
+	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_MPCLK_DS_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
+
 	return 0;
 }
 
-- 
2.35.1

