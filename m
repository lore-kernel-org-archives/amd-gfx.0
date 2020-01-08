Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1957C282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72452070E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sK5LZ5gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72452070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB146E8B6;
	Wed,  8 Jan 2020 16:18:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F37A6E8B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjeZ5ysC1A5GOuFbSTyN0BnqofSNPV6eerERHf1KkXDfoBZUPEu7yuQwoRCZZvQuQOV+7nY5BLGSZYlxt0g1kg2JGdutYl89oGr/jAuVA4mr4uqWB1wqqsn14yTskh24xZ5AiuEq+2BxNovzVl+F9jsx+MgwMXvkxPJQ4nk02nbrS29Q5jOjC3fh1o+SAo3Js8nYE4dDVjrv23+GB0sqR5Nm5IDzR4lpy8WeHrHy5nhnmRZVat+gEoJVNniydHU2dFAOmF/xaYUBWh5QqETvWSZlIWJ2D/BurI2BYQO95y+dx5qpqhp7t4w7o/PeJ6D1/p2EX8MHC8Qe7cb36nCW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XHHx9X+EOPfxbG6kJCMQFTPp9w2G11Fs+q1yS0xGsA=;
 b=cDaGRfz+QLxDPat4Wklv5x0jhvtX9h6O+1c9lDG6Yq5H2csxzb8OLqnSZ+piaxL5IFX0gV1fybE7F2MfOpKl7rCOFEAh5L7+Lm6yEbRZw65++lnfpGkZUhsg00qkY62SbqcQGBYr554bWRw0nvjiLapmHIUXsckOPnrJFoZmXj8tAYozBevCzOkfWnDj0yWYr2YASxyEN/ejYs5GaaAeA8Oj7KFQa538mIEqgndAvX3xt2Na/0vMnUdpnL6eRp4gujS5JoG95fXHGk1TAn6SOJ2uETqLCbcMaLkGen72iThtA8/ENxQozjsBDxemkTSsGonagHAAzIzSgR+5fk72Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XHHx9X+EOPfxbG6kJCMQFTPp9w2G11Fs+q1yS0xGsA=;
 b=sK5LZ5gDZqpdYkzd3RQvgbhfODlxH6PRWiwwA6PTVll/8O/T2kIW+vqkq2UiLj4vztiJTU45KQTc/SZ5SOS0z0tYpFuaxqdzh7Epqcqbril2SL+DKEfHya/3a3qUdXWnuSDTK5ZspaGM9rt/KfRgo91jQbFad+X3sXMxmBfc9Tc=
Received: from BN6PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:405:4c::13) by DM5PR12MB1804.namprd12.prod.outlook.com
 (2603:10b6:3:112::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15; Wed, 8 Jan
 2020 16:17:59 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by BN6PR1201CA0003.outlook.office365.com
 (2603:10b6:405:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend
 Transport; Wed, 8 Jan 2020 16:17:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 16:17:58 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 10:17:57 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jan 2020 10:17:55 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Dennis Li <Dennis.Li@amd.com>, John Clements <John.Clements@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>, Candice Li
 <Candice.Li@amd.com>, Gang Long <Gang.Long@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: read sdma edc counter to clear the counters
Date: Thu, 9 Jan 2020 00:17:21 +0800
Message-ID: <20200108161721.7727-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108161721.7727-1-Hawking.Zhang@amd.com>
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(428003)(189003)(199004)(26005)(356004)(6666004)(70206006)(70586007)(7696005)(2906002)(426003)(5660300002)(186003)(6636002)(36756003)(336012)(86362001)(478600001)(316002)(4326008)(8936002)(110136005)(2616005)(81156014)(81166006)(8676002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1804; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57d49e1-a8fa-42b6-e43c-08d7945653be
X-MS-TrafficTypeDiagnostic: DM5PR12MB1804:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18044C2FE9F304B637272696FC3E0@DM5PR12MB1804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGJJiSgVF0CVkEoGx0SzgXQeKNOE1XxHv/4Y0l8pF4ws3ebPwJ5hJsHcVDfxnzlr2xptAkVWbzP1/WRSz/0aXyvQtC9qH8lz4TQlmHUSNat5ybBjrjb4sUEN0B8m+3b8gXve4iViSW5z1zk7NZpYHQW/0DzIjM/txxl6qtCWVf648Vmirtam7RfgdT5LtQPhQPSSvFqQZgAE2NHutPvLw9wi0XISAQmgD2qppdGPPtP7+LMPEJ7mVAa7vdvgmpwzEkq0bFEQCnCdiC8OLdSf1SxRQ7joJ9YKskd8aRHEqJKwknG9jOiRN1MHx2PVI9MPpavQNPj8EuX17xVFEa0K3W2v692SHsFmZNjAijwRk73msQztTeN3aSrSgCM97uaFEUaTeB2wntd2l6HHdpEYSw5XHTgvP96ob7EpdXrHgg6mz/gXKTOKxE4nQbsEZhlo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 16:17:58.7709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57d49e1-a8fa-42b6-e43c-08d7945653be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1804
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA edc counter registers were added in gfx edc counters
array. When querying gfx error counter in that array, there
is no way to differentiate sdma instance number for different
asic and then results to NULL pointer access when trying to
read sdma register base address for instances greater
than 2 on Vega20.
In addition, this also results to wrong gfx error counters
since it actually added sdma edc counters.
Therefore, sdma edc counter registers should be separated
from gfx edc counter regsiter array and only get initialized
when driver tries to enable sdma ras.

Change-Id: I206917f9d7b81670a8fed84dc749085ce5a6f678
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 11 +----------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  7 +++++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 33d1c57aaaf1..c9ade16bbcc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4038,14 +4038,6 @@ static const struct soc15_reg_entry sec_ded_counter_registers[] = {
    { SOC15_REG_ENTRY(GC, 0, mmTCA_EDC_CNT), 0, 1, 2},
    { SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT3), 0, 4, 6},
    { SOC15_REG_ENTRY(HDP, 0, mmHDP_EDC_CNT), 0, 1, 1},
-   { SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER), 0, 1, 1},
-   { SOC15_REG_ENTRY(SDMA1, 0, mmSDMA1_EDC_COUNTER), 0, 1, 1},
-   { SOC15_REG_ENTRY(SDMA2, 0, mmSDMA2_EDC_COUNTER), 0, 1, 1},
-   { SOC15_REG_ENTRY(SDMA3, 0, mmSDMA3_EDC_COUNTER), 0, 1, 1},
-   { SOC15_REG_ENTRY(SDMA4, 0, mmSDMA4_EDC_COUNTER), 0, 1, 1},
-   { SOC15_REG_ENTRY(SDMA5, 0, mmSDMA5_EDC_COUNTER), 0, 1, 1},
-   { SOC15_REG_ENTRY(SDMA6, 0, mmSDMA6_EDC_COUNTER), 0, 1, 1},
-   { SOC15_REG_ENTRY(SDMA7, 0, mmSDMA7_EDC_COUNTER), 0, 1, 1},
 };
 
 static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
@@ -4109,7 +4101,6 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 						adev->gfx.config.max_sh_per_se;
 	int sgpr_work_group_size = 5;
 	int gpr_reg_size = compute_dim_x / 16 + 6;
-	int sec_ded_counter_reg_size = adev->sdma.num_instances + 34;
 
 	/* only support when RAS is enabled */
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
@@ -4249,7 +4240,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 
 	/* read back registers to clear the counters */
 	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < sec_ded_counter_reg_size; i++) {
+	for (i = 0; i < ARRAY_SIZE(sec_ded_counter_registers); i++) {
 		for (j = 0; j < sec_ded_counter_registers[i].se_num; j++) {
 			for (k = 0; k < sec_ded_counter_registers[i].instance; k++) {
 				gfx_v9_0_select_se_sh(adev, j, 0x0, k);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fd20594b6d6e..f4107f9b75f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1802,6 +1802,13 @@ static int sdma_v4_0_late_init(void *handle)
 	struct ras_ih_if ih_info = {
 		.cb = sdma_v4_0_process_ras_data_cb,
 	};
+	int i;
+
+	/* read back edc counter registers to clear the counters */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++)
+			RREG32_SDMA(i, mmSDMA0_EDC_COUNTER);
+	}
 
 	return adev->sdma.funcs->ras_late_init(adev, &ih_info);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
