Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800C3C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 04:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F3C10E0E6;
	Thu, 26 Oct 2023 04:37:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CC010E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 04:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lANrCl2WWy4FmFddt7niSMzSMbZL8J0BLsEPlS/cXmCNHzPpHAnbwqg4z96BTiThLj6twXNGm/UIFZJvYG7ykGdax56p3n1/vvV92uy2VucmQ6eHV/XU9BMfZVf67fHaZIwSMB2iIxnR5ressXI1k1VgPFsJrc5R9424DVqYj6RP7tyPRGqd5L/wdm1T2perF4wKwKeeM+j2h/8hjBO/XTTWvRT95g10mgOxAuzTfUlK0i01Ht7UJePbIHTNo3y5TVbDbGnbaxk8IsAX05vYDauZe+UX2W8zBVv6BCbCWXUBXdIHCKGHGxgM9r67wzn0kxGj3d5hYIzhh3tfJJ51aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA/1clbotkRgpiJSKKFKfB8Xzj5qc3GtikW4ojrNbjE=;
 b=lcEPWbO7FqDWANuVleF+IcOswTO4q+XUUBcgMP3OA3ebRDJ5wYmKQmcB9DiPiSzjI0jndo0YLfVA6LGfGho3/2G0b9MZZ2HSHz1UIYIr2P2W7y9O5+YmJTGCVRpr+al3ubes4n3BPzc614dMazvuWQ3vBrT12/Hv+vSsDoAnlSPIQaljfWNre8HeD4vlfHZK2bI0PQMOcK542/oMohM8DeAJt8LdN7HJjlOBm4R5dLg7N9VshZyH340mU6raX7LQUJPrjYgVbbMPnFpAPwPp9tBdT24JebgbT18UP175EzAH++BfgtqHweRgC/bIA1h9dMmZ64q1i5dXoqz3ngP3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA/1clbotkRgpiJSKKFKfB8Xzj5qc3GtikW4ojrNbjE=;
 b=VX4eDts2CzhpUG/XMswH7mFpf29XoO3Ej1JWE9ZG/WuLPi0kM4W7/5SH4MD1IQ1E2IDujNmx2cDEIsOiAnM9nVtbxqda//6Qt/Q68Xgokhk9qH5QAVdhqsKTxBme+iBdc67bS+wlREXuCJdp7GMhCcdUwpRx6JczqNxr/W/J2no=
Received: from MN2PR06CA0012.namprd06.prod.outlook.com (2603:10b6:208:23d::17)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 26 Oct
 2023 04:37:18 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::72) by MN2PR06CA0012.outlook.office365.com
 (2603:10b6:208:23d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Thu, 26 Oct 2023 04:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 04:37:17 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 23:37:16 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Retrieve CE count from ce_count_lo_chip in
 EccInfo table
Date: Thu, 26 Oct 2023 12:36:42 +0800
Message-ID: <20231026043642.1104712-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: fab6bf00-cd7e-4cf7-415b-08dbd5dd3c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AVnZLsnW9oXMIH72/mAk0wxDI1HoBW0dCTof2TYNi4t5JvBM5uZFxgwiisQANziSQZrpudXG85mex7CBOIOW2oLgaE5zkpLxSF6h5Wkmv3WShyp8e/g99A6+/l5Eh0ByB1Yvcgoc6RMvTLCnZeKXPQL4TaT12tVLVCxfCgRWzUG7Aa9/xfqerwM/iOCvS3zKeobrOjppGjth4sCdKnYVvXEgpR9gNKeY7T0jvk6PSqjyPJ0O8Jvo+yDkQvxu77JOZU8XnlF33QrM81hcxHJparJSo/h1lw93HzwvY/G0pCUXRLDaFIjnJ4pQbvFEd+KE1OsE1u4sndDi+VttboLzD+o2sogWK3ht21OphF6KWff69bgTegmrha7PsnsabpqHdGfoSH/ZQhv1KVVt1U+Z+3Qwe86coHBaz4A1SPM10OhzrYG2XLz1l4mkX43kPw8mFfV+S+HwuGbPjxtNeF+GUoGWkoezholgJPHdsh62MWM6VgWRseUsQY+lCXHEPeaXH2Xet3lpdoEGxJJuS6sGT1RYYFIHE9+4rylti/0ImbD179qqfRm67GKyJ20XBEW3v+26Qz/aEuTh5q2zwSiKqAdU7obNH0i78dEllAsa+6Tauio3hN0RT7YqbowyCVaH+8nKUDKbfZe702nTq6Oefk7vcVuCLyzBFayyp2Wu5QSIQj9AjvUdWUqUo8cOCb6gtY3rvo2TOsfleY1uKBe8WMNkLmA1KIZUepTMAsGiZct/AIOIRXiq0hQl/R1S/w8bvkw2RfcbLc0dNbpoo/bfvas9PItZPd8cZm/NaeO9Hr5a5lLRXQDx7oIM9tkMwFl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(36860700001)(356005)(426003)(336012)(82740400003)(26005)(16526019)(47076005)(40460700003)(2906002)(5660300002)(83380400001)(70586007)(316002)(4326008)(8676002)(86362001)(70206006)(8936002)(1076003)(41300700001)(81166007)(44832011)(7696005)(6916009)(478600001)(6666004)(40480700001)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 04:37:17.9428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab6bf00-cd7e-4cf7-415b-08dbd5dd3c57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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

Retrieve correctable error count from ce_count_lo_chip instead of
mca_umc_status.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index 46bfdee79bfd2a..c4c77257710c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -336,7 +336,7 @@ static void umc_v8_10_ecc_info_query_correctable_error_count(struct amdgpu_devic
 				      uint32_t node_inst, uint32_t umc_inst, uint32_t ch_inst,
 				      unsigned long *error_count)
 {
-	uint64_t mc_umc_status;
+	uint16_t ecc_ce_cnt;
 	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
@@ -345,12 +345,10 @@ static void umc_v8_10_ecc_info_query_correctable_error_count(struct amdgpu_devic
 				  umc_inst * adev->umc.channel_inst_num +
 				  ch_inst;
 
-	/* check the MCUMC_STATUS */
-	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
-		*error_count += 1;
-	}
+	/* Retrieve CE count */
+	ecc_ce_cnt = ras->umc_ecc.ecc[eccinfo_table_idx].ce_count_lo_chip;
+	if (ecc_ce_cnt)
+		*error_count += ecc_ce_cnt;
 }
 
 static void umc_v8_10_ecc_info_query_uncorrectable_error_count(struct amdgpu_device *adev,
-- 
2.25.1

