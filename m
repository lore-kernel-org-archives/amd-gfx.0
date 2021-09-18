Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B68C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B55B61212
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B55B61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92526E0F7;
	Sat, 18 Sep 2021 08:08:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA1E6E0F7
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 08:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntbhxUl09HY04mUxsA1crV+k08fkFSpYGnMi11FLykC/qY8i2873UB47sRk1LT5hv7J7/KOessj5/gSZ5RvxJrbrJdmb2WFkLLRsYZzwKr0GnOU3ii8Zcd2IOCEvhtBUZSRB17fBaun+JFFmwStZYoJzsxmE2EgrgVXk1OXFtakShDAijcgNR/CoILBFFAxS5f+9P4TkqFSsNMo8VEgfIhAY+jvCVoeKpMUnzW3AvOXMMRySetyr1n+xxMtcUPBKN0083+hdUacCg0lYhsxKNz+qehqiCF5/X3738xMhzm+0XdOE3ZIjMJCCUVOtJ/9GkpKsBNqLPgQAWZCL+RLlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2nbjPwe3wZE7WsPE08InhT8Q2C4kMJVSrhOgKn5+fPs=;
 b=kMr1FnXpJFQBQgH/2TjaUsLzcHLSm0C2tmpR1EuXDVPuHS6BDw7CPOSpGBvPYzkh/VDJMd+LH5NUFTJKpwL1zAEEOnqLPgkR4mzb0bJ4S8Tk3pbgcgd0+QaE7KSV1ovaxLbEZ/ZvfEisQ9pkNPuI4VViCkiT2YJhAp7eRGiCEvZIEvtShK89UnOiKdriV7DhInbhkaXIlhxZQNIgEkfEvBus3xzSxvAH686/KeDIqufIJtQ0JcOyTs+ueTa0XgrrFKemgIdJXlnOB7P0Y+DSdXclM4EEeaJT0EmUmh4bXI9TxDDnMy99XovWIE/JmMkxeZT06Tp990LyQdWWlrcbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nbjPwe3wZE7WsPE08InhT8Q2C4kMJVSrhOgKn5+fPs=;
 b=GbcVJht5aLeA2k30ONzTtNdhHmX8vKO0QVPVbfPW+vZblhb0DUX7SwKKdaQ4n0b/zxOD1XJ9JfcYZGDvog8gp2NgYZp5cSatnO5UUYwtFW5on79wwjSKVjQjIpSpYYi1Z8t1999D+Ts0k5/mFFwKEztMtn1iCXMsgEjAlLacOOA=
Received: from BN1PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:e1::18)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 08:08:08 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::dc) by BN1PR12CA0013.outlook.office365.com
 (2603:10b6:408:e1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Sat, 18 Sep 2021 08:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 08:08:08 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 18 Sep
 2021 03:08:00 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add poison mode query for UMC
Date: Sat, 18 Sep 2021 16:07:49 +0800
Message-ID: <20210918080751.23615-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6add790a-49fb-4c41-d7de-08d97a7b7358
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082634F8191D8FCB9A3CFA6B0DE9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BP5v0xfyRHeFvKnQ3vpaUcMgSQCOGFRcnmJ6HWZJyvQc6ZykGrIYmeyAbbFz4eLruXmkIVFNLAE2R1B3fAe+YmQUQz7iWwe5WHKkKuySzxIB2Axi04nC9hHc2Y9A96HAu0P6/36aahyAoICaFUsdkK2HolTBy9aXvxEci0XkIchklZfj6GJTqHitwXf8pn+z+fUzR3hp608iGtIbJGfowvmozvewvHqfct0wGJ/IGIgyAwH1NFug1h0S1mAoa2x/WPQ+xEa8mQY6OECGU714YQtK09+Bo81iISehqvuBDJBN9m0x+Q+cNT2mQe2FVBUK3QYbfd7zU7a+YDNi58Hny6U8WmbriFpdeOvF3Uy1aVkcZ2bKjNwxf0r8mkMVs25l4yhOvTk35VaoERkfDbEiaHC0s4f+ki58G0nUcN1OKgi5G4Rsn973yunpogZY2JVY/YRrR0B5RkPFFTUV/hQW9IVsquArvt7IQZNvmyPtpummd8EFR1xmXrUqmoqS3g2DPBdFhHi0WYJR1rXZrO1HHzJmflNocTxx+WcPA2cB4QRFIhg8AYNo94w9k60RGvyJjwrKELSK4PajNL7YzGzL11N66Zo4TOlOdLogCs/lMG0AJpBlclhnQRCJeApZoCsQoCOmwnZedSdfoIinmjVijQVt58zbAGBt+/oiX0As2reUS/VgELttkNd8vIC3ea+vVDStE6eTGrQFoT/a+/2hrd+ITlY4iaI/e2doun78ves=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(36860700001)(356005)(81166007)(426003)(7696005)(6666004)(5660300002)(336012)(8676002)(6636002)(2616005)(316002)(70206006)(36756003)(26005)(4326008)(47076005)(86362001)(508600001)(110136005)(16526019)(82310400003)(2906002)(186003)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 08:08:08.3984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6add790a-49fb-4c41-d7de-08d97a7b7358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ras poison mode query interface for UMC.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 34 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index e5a75fb788dd..1f5fe2315236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -48,6 +48,7 @@ struct amdgpu_umc_ras_funcs {
 				      void *ras_error_status);
 	void (*query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
+	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index bb30336b1e8d..f7ec3fe134e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -288,9 +288,43 @@ static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
 	}
 }
 
+static uint32_t umc_v6_7_query_ras_poison_mode_per_channel(
+						struct amdgpu_device *adev,
+						uint32_t umc_reg_offset)
+{
+	uint32_t ecc_ctrl_addr, ecc_ctrl;
+
+	ecc_ctrl_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_EccCtrl);
+	ecc_ctrl = RREG32_PCIE((ecc_ctrl_addr +
+					umc_reg_offset) * 4);
+
+	return REG_GET_FIELD(ecc_ctrl, UMCCH0_0_EccCtrl, UCFatalEn);
+}
+
+static bool umc_v6_7_query_ras_poison_mode(struct amdgpu_device *adev)
+{
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
+							umc_inst,
+							ch_inst);
+		/* Enabling fatal error in one channel will be considered
+		   as fatal error mode */
+		if (umc_v6_7_query_ras_poison_mode_per_channel(adev, umc_reg_offset))
+			return false;
+	}
+
+	return true;
+}
+
 const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs = {
 	.ras_late_init = amdgpu_umc_ras_late_init,
 	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v6_7_query_ras_error_count,
 	.query_ras_error_address = umc_v6_7_query_ras_error_address,
+	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
 };
-- 
2.17.1

