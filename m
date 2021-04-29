Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E257DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAD461447
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAD461447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BBC6EC87;
	Thu, 29 Apr 2021 06:26:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D87C6EC8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5+1sG+ogazf0vmZSkP5kzpgVwXmiPwPf/NYWXqCaMCizryS+EohRspKTqc4dEElRYa/SzoFF1ksBcerO1gg75YFmAKeJ302UhIsmTckc1oR9lYBuuR0oG0tvv1ztY6k6ithp2MXAif+7f/YyTjjbqAUilaMmxWhGcGSMMoJp8A/DJakafcUtDfjiFdr7K0VOdVDOUnBam1ZK/speWW/E8XCksMKc6dpzovbVXOQYW4YJqWP6kDYznjpGrk7oVU1aNldxnEmgC/wv719PKizA4X0+zDFOs1gyTQpwcgvEnJpUx/mMB8C3/HNryOSP9TEEsnPDdFlOkh8DgpLDd9e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0m6qBPeX/JKe8LOHmNUNQoRfBelzKTapsRUGkTkt6A=;
 b=deANPjD1m+ycePegBVkNT6eXR4Q+WDDcF7hrq5Br4OzOr9qqqJf5jLt9ww/JC3GFeTVQI9ilECHsbA2CY4UHnp1ujXK333oRXY90bi+Uc6okA0l6B4tUryvzYHGywyWRMBvw9qfeCeq1sOutpXMvxUptjTH+PZhN1yeR/HxWcyA1eYITLd1RFIDUSCmALv7/U/LcH+bGcl7xZ+jse6ewyWqOjQMj9twkX1plJStstHC6WCtk9SGUFVR4sfki0I0g/JLw75PtzCVF4AzGlRlCYBCeeNhpSmPH/oGs5pzgCMHkSkIMQ3kGpz+ofLM5SjKh/5oOErTTdV0J+IyOdpUhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0m6qBPeX/JKe8LOHmNUNQoRfBelzKTapsRUGkTkt6A=;
 b=BWCg6VayKerGLSMDJxagg8jGBR7b0M11wa857Q9Pk5DQpetI3KkQl/RRGjKH+iBw65X6ssnBcBngj4vZeyNW+N9a0RfjRxafgLLhW/C2ALHmkYeMz7GOiFRrKSKtZ3tPAQHMFt478/Y84x4yXgz6+153fN5TIDzvB3PV/RY+6T4=
Received: from BN6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:404:10a::16)
 by BN8PR12MB2865.namprd12.prod.outlook.com (2603:10b6:408:96::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:26:00 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::a9) by BN6PR13CA0006.outlook.office365.com
 (2603:10b6:404:10a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 06:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 06:26:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:26:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:25:59 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:25:58 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: implement hdp v4_0 ras functions
Date: Thu, 29 Apr 2021 14:25:42 +0800
Message-ID: <1619677546-2630-3-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51eecf30-0bab-4731-11f7-08d90ad7a84a
X-MS-TrafficTypeDiagnostic: BN8PR12MB2865:
X-Microsoft-Antispam-PRVS: <BN8PR12MB28656645DD18A98C10A2C7E7FC5F9@BN8PR12MB2865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOHqmuzRu3fBkzw7OCT9imymZfYKdutZ0qdwi7ntbkQoxRWtrZVUWwwebgFG0+fdo4I1DVIcl88T7lPTLWjVeFY0G36FYA2l2WP0QOutlbImgR+xH3JLoq2psm807oIpjT7ej/adEPhGoMlfV/zBeSV7nJ7kRJSgTBQoo3aJ6YW02CWGxChe2VX8mJvQA83Z3nCRWF6nE1/ARmWqGjvFORWnJ8/5Vv7qx/DRbdXfVWURGH1pZYhapvB+SpqF1cZDGfG9R3ZXB1ERJORBvQ6LTXTpyiDty4/xn2AbSJdGYzzbuDbWmm5QkF0Kp+SpCThuEF1BwtXNuvvNohHvgtKcaHcIOWh0javlIrvtovQDH4H3weOllhzBMe/HdT0oOSW0ThA64A7PoOoidZRAJJR8E1wJFFQNjq5wLi1s1/RYAEoYpNw18aGXkw9XRbkohdAlBqf2v9HaWGcbN+a+prc3QPP7g7zG2U7Qf8qS/P8riuAmwoJDbynf6YwmGiCPE0ziZFJgWYV5Fvlxtm9psA4SxVzqBN/2bdpRIqQYKhRU7umBMH8ucv3qwkxvSzwbnB9bxd6lTiZGfDu0b6fqT97fnZN3z+xnlnuqHu9e6fOfFNQL0Agsy3AxmcEofGeTqbYUKgS+aCcTG9o5v3W3lsBAaJ0lfduEl/p5AZDFZIF4UeMDOVZNdPMBdLJ4F5tHvGow
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(110136005)(426003)(36756003)(316002)(6666004)(82740400003)(81166007)(356005)(36860700001)(47076005)(26005)(186003)(336012)(2616005)(83380400001)(478600001)(8676002)(2906002)(4326008)(82310400003)(70206006)(7696005)(8936002)(86362001)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:26:00.6869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eecf30-0bab-4731-11f7-08d90ad7a84a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2865
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

implement hdp v4_0 ras functions, including
ras init/fini, query/reset_error_counter

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 30 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index edbd35d..330c0f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -59,12 +59,31 @@ static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
 }
 
+static void hdp_v4_0_query_ras_error_count(struct amdgpu_device *adev,
+					   void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	err_data->ue_count = 0;
+	err_data->ce_count = 0;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
+		return;
+
+	/* HDP SRAM errors are uncorrectable ones (i.e. fatal errors) */
+	err_data->ue_count += RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+};
+
 static void hdp_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
 		return;
-	/*read back hdp ras counter to reset it to 0 */
-	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+
+	if (adev->asic_type >= CHIP_ALDEBARAN)
+		WREG32_SOC15(HDP, 0, mmHDP_EDC_CNT, 0);
+	else
+		/*read back hdp ras counter to reset it to 0 */
+		RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
 }
 
 static void hdp_v4_0_update_clock_gating(struct amdgpu_device *adev,
@@ -130,6 +149,13 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
 }
 
+const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs = {
+	.ras_late_init = amdgpu_hdp_ras_late_init,
+	.ras_fini = amdgpu_hdp_ras_fini,
+	.query_ras_error_count = hdp_v4_0_query_ras_error_count,
+	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
+};
+
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
 	.flush_hdp = hdp_v4_0_flush_hdp,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
index d1e6399..dc3a1b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
@@ -27,5 +27,6 @@
 #include "soc15_common.h"
 
 extern const struct amdgpu_hdp_funcs hdp_v4_0_funcs;
+extern const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs;
 
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
