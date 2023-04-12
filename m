Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1993C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 14:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8B510E852;
	Wed, 12 Apr 2023 14:02:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E9D10E83F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 14:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcaHIrxexr9PW00eKGYuIVDGmvsNWIoNn3dl75dkEiYIuqxDGvYNHhuR0eGtsAXntwPSKiEqIK2S6t5rpGhhI82daUUP1HqalFNYORN3zIUlWK3mgGh7XBmiGfTLCl7dKj8LTnWx+vhbcCMgtr9JCvQJxLfJZ/L6GQiTh1ee40ndAHr+u5vZEqgtKEugWR+Mp+IhTbbY2Bbne442vtvEoRNKW7etXjhB5DVorWU8wW/fcr/6jVMT32Jt4EFkcmvAcNH2Xq5n218kpnwX43q4b8IqyOnAJsGl+bKhlEKO7XfGa86JOjybdTCrq8nus+So8wGdw1b2Cin/9uKlKi7Qaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuzTy5UN2auKoEbNYG3/5Y9F17Bz+4nnRYq8OkiUu5o=;
 b=Dv9+sBFJASlmlIlcCY5Sjg/xyPSGcTbrIFHp7/fwwkqK1ZNEp7wqutYps1IN9stZ5uXOmagCglyziq1gOwZ4xrIs0xuXVcE0jWGAgZwmoFQ1K6RcE2jE8Pc7BKAG7QH3QOZicRgeZ6/ZRVVDdnZq9HSMGPv+lh98bp7s3dmfmA8BYo891YM5VH+xs8p6SKebofEqs5UrKe9z58HT6/WKQCjefdBZMuDafizPtwiHI6QmC63gty4o0V/2w92nkeyHkddlE4kU4N9vq4zVqEbJS2eHvtPsHu+s6RYd3oFjY2k7/De/N5umUYrsVixJPr4AZ87Am79CZawE3e04WqxXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuzTy5UN2auKoEbNYG3/5Y9F17Bz+4nnRYq8OkiUu5o=;
 b=nUs67W8ROlTsKd/F6nvlGQLhRjjKLWGOdmwUgQtb7WPHLkZrpmX117AkPVzvkQiH8nkxWEBZl6vGjrQBfD0zSGy26WCiOe/3OC5OVpy1TOgGDu7H6UA4yMYbnPjZ/9eiSetI6wPBXH/8hnwk+3HKQplwNni9ETiqMvDdOu0Cw78=
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 14:02:31 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::97) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Wed, 12 Apr 2023 14:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Wed, 12 Apr 2023 14:02:30 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 12 Apr 2023 09:02:04 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Jack Gui <Jack.Gui@amd.com>, Likun Gao
 <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: drop temp programming for pagefault handling
Date: Wed, 12 Apr 2023 22:01:48 +0800
Message-ID: <20230412140148.28633-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 55341a4c-0953-4cde-69cb-08db3b5e8eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJNRSQXRSTyEAlR9koLfTlVVoBSWiAd+maIXLYM9+pOBg6Lq7Xt8ekQx1YZ0sC/4Acmng0JAgBlw8QOYKFCNDGU37JbA2Thwsruhp6/pb9AGCGGMBQF5c+atCUowzeKVIGk372mJczY5PDHsog7sqPHaOqO7Xo0qhb8yLpgpkrfr8RHrtEytTGiUc6lJUjBH2B+hZGmyIdaaT50VvuMffWgR79sZsswO3eKAZKjPBtOxSjvq5CNwnr+ez0ApDZ11KmvJVly9kYIRiYPeLegfoKX8q57HWg39qedfqsxOHmESGAzdMykrZ6VFyU8syuK1lhQkbKEHCgNhbsJVkkumN3AAcDO1XYe1yyI9c4dNcDfjdZ1c6kd1PxynCNZQMeoDMXGvUYHClK7fOr0XZvAleK3v0/5SVagInxiBORQ5HXaqa8EJ/vNBA0tOZG8opMfqV2H9t9EfkdRafv3rNjiuorfyzwta4oNlXLgWUnItl0xYftz2VDkhoZtAeGEgWuCMymzuSt950QTda7dgwMIBICon4uAH5ByGtmYl3Wz3/HPEhEhevRy0tmL3Jn0EqpPomKw5Xk7ENHDz+BuP9I+0GJMivPSgGbGxWCpEkT3yshJ0NHZPYWeNk6PUw5DUHGuQv4QUaoPbmFxMWA/XcWla2gBCN+ER//LlujXcxqoq6GgUzUiJM8advZREVeT2gjR6mR1n9Ho4PPFL3/6/Hh7x4kEK3Tw/KYJ56wJT2o8WMbU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(36756003)(70586007)(41300700001)(7696005)(110136005)(86362001)(6636002)(4326008)(478600001)(316002)(70206006)(8676002)(40480700001)(8936002)(5660300002)(82310400005)(2906002)(36860700001)(16526019)(356005)(82740400003)(186003)(83380400001)(1076003)(2616005)(26005)(47076005)(336012)(6666004)(426003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:02:30.8884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55341a4c-0953-4cde-69cb-08db3b5e8eba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Was introduced as workaround. not needed anymore

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index be0d0f47415e..13712640fa46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -417,34 +417,12 @@ static void gfxhub_v3_0_set_fault_enable_default(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, CP_DEBUG, CPG_UTCL1_ERROR_HALT_DISABLE, 1);
 	WREG32_SOC15(GC, 0, regCP_DEBUG, tmp);
 
-	/**
-	 * Set GRBM_GFX_INDEX in broad cast mode
-	 * before programming GL1C_UTCL0_CNTL1 and SQG_CONFIG
-	 */
-	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, regGRBM_GFX_INDEX_DEFAULT);
-
-	/**
-	 * Retry respond mode: RETRY
-	 * Error (no retry) respond mode: SUCCESS
-	 */
-	tmp = RREG32_SOC15(GC, 0, regGL1C_UTCL0_CNTL1);
-	tmp = REG_SET_FIELD(tmp, GL1C_UTCL0_CNTL1, RESP_MODE, 0);
-	tmp = REG_SET_FIELD(tmp, GL1C_UTCL0_CNTL1, RESP_FAULT_MODE, 0x2);
-	WREG32_SOC15(GC, 0, regGL1C_UTCL0_CNTL1, tmp);
-
 	/* These registers are not accessible to VF-SRIOV.
 	 * The PF will program them instead.
 	 */
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	/* Disable SQ XNACK interrupt for all VMIDs */
-	tmp = RREG32_SOC15(GC, 0, regSQG_CONFIG);
-	tmp = REG_SET_FIELD(tmp, SQG_CONFIG, XNACK_INTR_MASK,
-			    SQG_CONFIG__XNACK_INTR_MASK_MASK >>
-			    SQG_CONFIG__XNACK_INTR_MASK__SHIFT);
-	WREG32_SOC15(GC, 0, regSQG_CONFIG, tmp);
-
 	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-- 
2.34.1

