Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD71ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 01:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22C310E919;
	Thu,  8 Sep 2022 01:14:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A993F10E919
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 01:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNgyGCu2sq4xOioukiJx0h6CiQCLvCr4VFo2nNdhUmKCIAV/gXscm9NeBCFTzMXtji6PsykH/2QukN7zoslrqRSD9EN1FW+ki3b4mLrvri34vN4QD1cg038mpr+cUNSfZzFvSjslujEeBYKdY2JW1ro0DNGfj9EzphtlxoJQBoB7AvRqBK8/0a/L4JuY9lo0olsAxoVqBahS7E5foF+aecwuNSheYTe+ZakGKRhg3ja87P66PoW/m9LKy7Iuakp+ifgrI7WDyioK2ap4EluaUxdSG53gZ+ksrxcfvdF4iPHXGzDvzj7QKPKSbc8jeUKy6WPUK/QefNVgT50UdNUoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh7IkKAC978x9i1n+M/+t2irSC9Tl74kXGME9vHwyJ0=;
 b=h++Ab73RWtlRtIpXGCw/JUDU9PYPXz8v6iB/FlZZb27/sRHKGWZBqHrpo+25xRGugiP5Gxk8mcRHrsWUryZDiy7w+045Om0Bppnoe9p6GSKfc4uXyGNNkUQ5SRpn/xwzCCBJVuj3g+3GyCYMKRT9x+KjwFsaHxNVXWfhhx9nzxscz5kMO4XMReax3p6COZFEuP9w43hi3POdD1stNgFT6lFJ/BimHVliHiMq8po+LwtAjaHP/sLUIITdMDPYJ36ExrmzWv7a8hvKQ2+wSjs71SgovQiF9+2yT3enT/VajGM7otttjxcYo5BlynRaxPPWcN5kDFoj/v9zQ+E8bKaxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh7IkKAC978x9i1n+M/+t2irSC9Tl74kXGME9vHwyJ0=;
 b=VnNLFkrCxsl7i9QiKePDSSVE6VcgLsJv5O6o2PkwltBGNJ3tppiSicnujSe/U1bpchHumQho/pvYenWPda0b9PYwzC1BsF1HJCcHOyWvs2FUDJEYWP6/j4ZY5cKk+3sG5zkMH3ml8gofDgghBb3LvdF948bt6pYJ3RSazl06Cnw=
Received: from MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 01:14:52 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a2) by MW2PR16CA0056.outlook.office365.com
 (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Thu, 8 Sep 2022 01:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 01:14:51 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 20:14:45 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Rely on MCUMC_STATUS for umc v8_10 correctable
 error counter only
Date: Thu, 8 Sep 2022 09:14:09 +0800
Message-ID: <20220908011409.17228-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|DM4PR12MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7f9994-d9d2-4587-c583-08da9137880f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvt0bLrgl6NkGtkGlsByVYu/Uc5OLRjwI9KD+nVKJ4s+Y5Gqwo4OAFcVethr0IjlrLyelwrbQSvzSt7NoFD+Y7twlra4iF8Xyxp0ZD/E1RrWeXGAiokgnoYBOUGKzr7jzLUzIWz5ckFbXtcdO0bykWLlwG5ja7bC/UQbZk8nj8SR1w4heStLD1kYI2aGXFGWZTY9vDU2M407LWZGPJfgGhR72nAiOyra51dkawcdNjcDmELP/mUn3TwdwAf8IBvdnLPXXiYOy3xnQvDwK4sFGFPntsBjroD7roryMV4jxS1NovPrPf7HruSsrD8o9slQE5MjN6PXwwHni3rwxdubcrtaDuF/D8uPCEs19NBvMxlCk1N3TQUCYIRnc+RES58PRfCZOoqzuNyzs0yVUAax/evCRWHSJYeG0wVT1SMjqL2dzhseOzBDaaOIkCJzerVJM6bUK/Fm+rmDeDBOtBfqzwoIblB4ai2ux/BV1PpsPAwxB1+uJ7yOo0/ByfLi/kfHxrsgcw5PiANMHLc08EDG20sIkLimgb1JEUwABDWFkIEnLhR7uIjV+qnVKKE9gjVJ0cZkNxgANkWoLqXxuu6nekd3+4IbpWoRHB6Oodk3Z17eMglTl9lpf18Ndq+LYI2grG2+fJCNIsUl8WqBls4DUjlreEyiiAedd9EjRSLVWgy8kDnea4ksqAHK8lPfbwpKktHwGGtW/hUwXZY+EjbV/yn2hZg9YwMZzE2IIeVtWwVUTv8KIpyZzBBY1maTgpmx20yJjkA3ncfKpy6nmViZ/E0Q0HPZkwf7GU2b154GvZwrQxEehgE1bmL5KHtbHNts
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(40470700004)(83380400001)(356005)(81166007)(36860700001)(82740400003)(40460700003)(40480700001)(70586007)(70206006)(8676002)(4326008)(82310400005)(6916009)(316002)(2906002)(44832011)(8936002)(5660300002)(7696005)(26005)(47076005)(426003)(16526019)(336012)(186003)(1076003)(2616005)(41300700001)(6666004)(478600001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 01:14:51.6435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7f9994-d9d2-4587-c583-08da9137880f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only check MCUMC_STATUS for CE counter for umc v8_10.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index 36a2053f2e8b94..a8cbda81828daf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -101,22 +101,16 @@ static void umc_v8_10_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint32_t umc_reg_offset,
 						   unsigned long *error_count)
 {
-	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
 	uint64_t mc_umc_status;
 	uint32_t mc_umc_status_addr;
 
 	/* UMC 8_10 registers */
-	ecc_err_cnt_addr =
-		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
 
-	ecc_err_cnt = RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4);
-	*error_count +=
-		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_GeccErrCnt, GeccErrCnt) -
-		 UMC_V8_10_CE_CNT_INIT);
-
-	/* Check for SRAM correctable error, MCUMC_STATUS is a 64 bit register */
+	/* Rely on MCUMC_STATUS for correctable error counter
+	 * MCUMC_STATUS is a 64 bit register
+	 */
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
-- 
2.17.1

