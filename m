Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A3CC3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469D421739
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FYldRt50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469D421739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1492E6E2B0;
	Mon,  2 Mar 2020 10:34:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C056E2B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 10:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNsevMTG/biAS4jyvF4llZo1XNdC8AKBmXIwUpyHv7jRNzTFGU9MIGBv1TzQQ4ca+qXwzTeDfmRMa1F7ODxV6s2Sg+2hPUGVDDrMKZfvy4l+WeQC2rrpQdBPOpJkt/lzlDYS2C6Fd81yvdsLbb14fpkNPwQna4uxvz18XAlDIJrm7dPmacT6AmNFog78YH2NLLhUd/79Z0XVaQjEvDYbLoF2CtVZpjd4AQBA6juwhSG6kSlhQyBp53NIYumVm1RKWADGULi292cr7DRI+L33ml1ck38Ef8tgkiSE1pmHbccW7pIKyVxjcMrCW7tBgM4A8bSx1BRG6akkh2DDfmDDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSoHZEf2YMbHSKG6l500N8HXA/Oa9s2R5wYpSdpQdPM=;
 b=Lo/FH8M6YEW0yAJg3gXCfcZDzu2pW3BXPiFeMjt5tL07OJYQb31up1bLVsTs42gTqbh73xhSkv3x59jVuOQD7JRzE+Y8cxzXAc+B5SWt0yYAoymnz7cFjnl0c5a4towtu+jeiBAZII7lT4JBAK/HNejq04BZnvETK7k/xaBVQCUbP54hG0oi9CFj123Fmlc4cG5g8Fc5cgIz675sFCXeVnxwcdG+1bO80VVyDc5Py51ufmP5bq1sM/UVm0wUvKUlTxk7/rLEXgGH4LWeu8fRT/vz/mmz2gVJb+OQ9nuoUfzxM1pUGFmq6va8yGqzbh01eq0DdgxZ2oiIKZzeHgO+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSoHZEf2YMbHSKG6l500N8HXA/Oa9s2R5wYpSdpQdPM=;
 b=FYldRt50XZN8Dvldwld9afi8xhgcBSJ+Hhj7HiiV5MfBog4bz33sdgr47PWQ3u0rSu4AtKQ1f8SSt+XvsPBIlntN+DY1dLbVVxPxqrTOifJPNE70bpxy/bWxroJi84j7r6PPf8kQVOYmj4O8QJTSHdimKXhB7UBnhXryGWOBRz8=
Received: from DM5PR12CA0059.namprd12.prod.outlook.com (2603:10b6:3:103::21)
 by CY4PR12MB1879.namprd12.prod.outlook.com (2603:10b6:903:125::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 10:34:37 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::ba) by DM5PR12CA0059.outlook.office365.com
 (2603:10b6:3:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 10:34:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 10:34:37 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 04:34:35 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 04:34:33 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Guchun Chen <Guchun.Chen@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for HDP
Date: Mon, 2 Mar 2020 18:33:39 +0800
Message-ID: <20200302103339.31723-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302103339.31723-1-Hawking.Zhang@amd.com>
References: <20200302103339.31723-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(428003)(189003)(199004)(81156014)(81166006)(8676002)(7696005)(336012)(4326008)(5660300002)(1076003)(86362001)(186003)(316002)(36756003)(26005)(356004)(2906002)(70206006)(478600001)(426003)(70586007)(110136005)(8936002)(6636002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1879; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81e579e1-cfc4-4d80-5ede-08d7be954e6a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1879:
X-Microsoft-Antispam-PRVS: <CY4PR12MB187907E9A64E7DF774371958FCE70@CY4PR12MB1879.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fK+yM2Vd6TvdUo29dl2nXWgOkAabnL0267aoNAGL4lXwcx7nKqEYucEhQIXVIP2tC9UfuP940UFlYkMWxNVX6W4EaDDVvHZ1eQTPx5AFR+Xoc1IrXuhotLjnom0M/QvYsMZ8FRtwXZJ1li2Vl/5cgBMp9/5s07zPkgiIoBbV0NIM8eVLIF+KvnS1UGJFWiC/EoDKKupYqadtb9mOij7mk7lG5WCANIi6bdnwYmIVPj9dkp498H9GejgytZsdRaeokM/O0j9vEmFCJMsz0C39Thd8dQu3l9oh1Vy9tZsovts0zdiQLm5usBYmHTyVGQ6V3Xvlwz0RTA2tmixYSYEkWH6tOyOG+imZsfyz7fZRC06VVqmLmWAzn48GVc4UgZMwwRBvmTb8GbYV5VXSAmSyACuyqsSOUOWnxeDCA1Npk+s/yrxyVfqlLSTIWIqkslk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 10:34:37.0073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e579e1-cfc4-4d80-5ede-08d7be954e6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1879
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

HDP ras error counters are dirty ones after cold reboot
Read operation is needed to reset them to 0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |  1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c    | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a58b0cf9da51..b735e20888a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -595,6 +595,7 @@ struct amdgpu_asic_funcs {
 	/* invalidate hdp read cache */
 	void (*invalidate_hdp)(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring);
+	void (*reset_hdp_ras_error_count)(struct amdgpu_device *adev);
 	/* check if the asic needs a full reset of if soft reset will work */
 	bool (*need_full_reset)(struct amdgpu_device *adev);
 	/* initialize doorbell layout for specific asic*/
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b746f26f933c..efd52bcf8785 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4149,7 +4149,6 @@ static const struct soc15_reg_entry gfx_v9_0_edc_counter_regs[] = {
    { SOC15_REG_ENTRY(GC, 0, mmTCC_EDC_CNT2), 0, 1, 16},
    { SOC15_REG_ENTRY(GC, 0, mmTCA_EDC_CNT), 0, 1, 2},
    { SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT3), 0, 4, 6},
-   { SOC15_REG_ENTRY(HDP, 0, mmHDP_EDC_CNT), 0, 1, 1},
 };
 
 static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4aa5b9c8e43b..6b717691d554 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -827,6 +827,15 @@ static bool soc15_need_full_reset(struct amdgpu_device *adev)
 	/* change this when we implement soft reset */
 	return true;
 }
+
+static void vega20_reset_hdp_ras_error_count(struct amdgpu_device *adev)
+{
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
+		return;
+	/*read back hdp ras counter to reset it to 0 */
+	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+}
+
 static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
 				 uint64_t *count1)
 {
@@ -994,6 +1003,7 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.get_config_memsize = &soc15_get_config_memsize,
 	.flush_hdp = &soc15_flush_hdp,
 	.invalidate_hdp = &soc15_invalidate_hdp,
+	.reset_hdp_ras_error_count = &vega20_reset_hdp_ras_error_count,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &vega20_doorbell_index_init,
 	.get_pcie_usage = &vega20_get_pcie_usage,
@@ -1239,6 +1249,10 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
+	if (adev->asic_funcs &&
+	    adev->asic_funcs->reset_hdp_ras_error_count)
+		adev->asic_funcs->reset_hdp_ras_error_count(adev);
+
 	if (adev->nbio.funcs->ras_late_init)
 		r = adev->nbio.funcs->ras_late_init(adev);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
