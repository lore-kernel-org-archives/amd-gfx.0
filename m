Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982EAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EADB207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YIIaIhMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EADB207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380676E1E0;
	Fri,  3 Jul 2020 08:55:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00FE76E1F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyqIMm6qXSzBAxBW11WkNBnQkAdgW6nkxM7x1YJAGw6OYvM/RrfX2Im4XRAp1KtmbnIvmlk83HBA4xCx0HhKP9tn4fffqRI8Cj9c3rwrK+KDgFC9ecN7jyrmYZwsSd8Xm/l1TA4OsiKnbwcKsuh+qunNixB1JHvYhU8fdQWY1xrkNMrm+HjvOG2b2ZXrJbTIRLla+PtFVHEawgDCezsIGPfQVAWUMdz9F6vcFPSZsHbS2LQT2aXWY7wWGC4IXmg3wf9vo5HOAckYNu8N5uEYRZ72tpc1K9GUWKM6oxzb7TPkJbTYB82K4H9hiIvOJjYy8BkXrYS1ggZJXfyHB/1JMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J65BLtVnHEIT5ifJd24pwPWGTa/qmGtW+RBTgiHnS0Y=;
 b=EqIGjep8o3y6V54NjRt/dMkhDeBv0kxlHXBml7jqkv8sAK0ioGOfroFMtQuhTMNxfzXnmGpUMhknTiPVInBD4io9y8+96gipo4YpzhVbKSzsLTxrGPQ4owiYMabe46WaaWHabmwRvymsjEf14k5Cv7c/3r9LStn8VxO3dCddRK9fOhqkQlbxOEB3MFVNnsT0J3wWhxpFcjea+C1HRYd0bWftuJDW0df681hUTumfjUGv9Xe7pEjpNQy8KuDEVqqRBh0ankKlZPky+IQNPOT7XHHcc6Ug/E+YA8Ny0nuZZ/kRZRDPfs7uRKDGfg9NHpFp64g1LnLKYYTgimstQjEJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J65BLtVnHEIT5ifJd24pwPWGTa/qmGtW+RBTgiHnS0Y=;
 b=YIIaIhMpicxwOt85nViLuGozRhM/L20VNYGMK2/6sFS4ksCekiCgyl6aCX2VXnWTpSzIS32k57XwX2NpUmjOgZ/quE4j0rfvxRqUnyWt/lYHykeNsfzZKIikppZrXmad6gFfKa4wfOjEaxHWNIbYDzoBuGy/bwIOH68SZY9cenk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Fri, 3 Jul 2020 08:55:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:55:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: correct the supported pcie GenSpeed
 and LaneCount
Date: Fri,  3 Jul 2020 16:55:15 +0800
Message-Id: <20200703085515.7552-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703085515.7552-1-evan.quan@amd.com>
References: <20200703085515.7552-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0062.apcprd03.prod.outlook.com (2603:1096:202:17::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.15 via Frontend Transport; Fri, 3 Jul 2020 08:55:34 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 365ee7f3-a34e-4f6d-4822-08d81f2ed9ff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353780295B4CEDDE76CA8D7E46A0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9L7nKRXKVS0Jm0Zq+AU2/5MiMrtHTK/SKugDO0HyL5m89Xcc+IS8UxKPBWdPJtaxDXQQvbRT64LrZsO5cd1iESMsq2WjZCq/XKzn7Fq3tN4EekdiOa30FQbHa09hKqZTkAnILEpPv3ajCL/6hDSjz4qXSplAmlQrV5At8OckXxURUqfEMgKtWEa0SW0w+sGt055qvCgld67wugKKioSIQWzAij+p6h2+w/3W1nJDgXU1VGVqD0sMCpXZ0hedoanXAJrFtLVLoHtSCGex+2Zma4tyr4bmk+cNRy3GkkedXPKMIRPitN//KyL2sZlLWtME4N1mBfcT8bXFhwBKkDdwig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(956004)(478600001)(86362001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(36756003)(83380400001)(6666004)(2616005)(6916009)(186003)(316002)(44832011)(66476007)(52116002)(1076003)(26005)(66946007)(66556008)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AH1+fNdbAtdKOHgAONOuPU0OxU3ZVGwPluwHyQgunJ8c9aWD6C/sdKuHZgFOLb45GEqx6eV/3iUCEutllD0TsvBRGEnKytVPA1r1M1/id86TNlTD2IV/Wfk12DYHLktzs7daDLV/SblZSGXJggLIucNA+Y79mKUuQnRxAsRXMv+mWuvlIyigR1EapjfAEr3W/f6s5Vs0fxZbotLNpK5bIRtKKpVHJaiAGijUmY28Pa46fTv3EpZ24oKlpO1o5nxdHUabmO1dXuAicR++TM9y9bN+1N+XDyTSSD+33yL+J2AG/0gxuRnc4WL36x3rWbwCdYVB4KIbVOfT8DWo1Fx4EZt1bSohx0wmYJhI2K7QUV9kVWimh/tJg6EfIZaQBaar1Uo20NptAhJOPsHpG6aZmgkpsfJ+83xS96XjzHRTAkEAR7ZZy9qyenVHg8+Dhvp1/zhq1IqrtnKL+XcMIhuKJ6r8rS4d3kNK0I2TILJU9IAXvUpY7EO5dLPm+KeSTGa5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365ee7f3-a34e-4f6d-4822-08d81f2ed9ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:55:36.1026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xypU4GFCxpEyKSfv8aCK+h/088ZlMsB6aKnce1TlsYNVprJW5EzvlasG8gZknaE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The LCLK dpm table setup should be performed in .update_pcie_parameters().
Otherwise, the updated GenSpeed and LaneCount information will be lost.

Change-Id: I028c26ca0e54098cb93d9e9266719f1762ba2d7e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c      | 17 +++++++----------
 .../gpu/drm/amd/powerplay/sienna_cichlid_ppt.c  | 17 +++++++----------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 3db5e663aa6f..97d14539c95e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -693,7 +693,6 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
 	struct smu_11_0_dpm_table *dpm_table;
 	int ret = 0;
-	int i;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
@@ -857,12 +856,6 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
-	/* lclk dpm table setup */
-	for (i = 0; i < MAX_PCIE_CONF; i++) {
-		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = driver_ppt->PcieGenSpeed[i];
-		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = driver_ppt->PcieLaneCount[i];
-	}
-
 	return 0;
 }
 
@@ -1936,12 +1929,16 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 				     uint32_t pcie_gen_cap,
 				     uint32_t pcie_width_cap)
 {
+	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	int ret, i;
 	uint32_t smu_pcie_arg;
+	int ret, i;
 
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	/* lclk dpm table setup */
+	for (i = 0; i < MAX_PCIE_CONF; i++) {
+		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pptable->PcieGenSpeed[i];
+		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pptable->PcieLaneCount[i];
+	}
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16) |
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 7a108676f90a..46be02e4b93c 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -601,7 +601,6 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
 	struct smu_11_0_dpm_table *dpm_table;
 	int ret = 0;
-	int i;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
@@ -819,12 +818,6 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
-	/* lclk dpm table setup */
-	for (i = 0; i < MAX_PCIE_CONF; i++) {
-		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = driver_ppt->PcieGenSpeed[i];
-		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = driver_ppt->PcieLaneCount[i];
-	}
-
 	return 0;
 }
 
@@ -1722,12 +1715,16 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
+	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	int ret, i;
 	uint32_t smu_pcie_arg;
+	int ret, i;
 
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	/* lclk dpm table setup */
+	for (i = 0; i < MAX_PCIE_CONF; i++) {
+		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pptable->PcieGenSpeed[i];
+		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pptable->PcieLaneCount[i];
+	}
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16) |
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
