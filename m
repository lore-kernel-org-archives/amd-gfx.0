Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0413C19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 08:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2849453F;
	Thu, 11 Aug 2022 08:40:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5A710EB17
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 08:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncniWPLa6tlYBQqoGYHW617kG6XKzcf9JSiajeQ4GTA++D/ojEjS/GDJmvHGhoGqOmiwSx/lOB8Y5T2JyxAvOUR93vif89nDojOKzn3qmHAYI+OYUAaEa+LgLUu94zS/GZ6dJBpB2cMnFw6VsaOYZZKpCWeebtIhcykIjhk2HeGlT+6YbW/b3Y5Q23S3E6EJ8iw+cgwb/baSKzE9DkmGbdykUCp1Z4G8Ka3/6Pmrs5cFsRH59uyAvkiqVNvbfkVaTBYR5mFz6CWnKUWpHeXaMsGvGr6KMnP225UMZeYzsHVfjDp5RrjoVF96wXKv4x3noV4VYZvRofsCL41wWhcjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P35lRD0k6hKfnzw7HvvZ1dv6g/sicPE3VnMGP+At3B0=;
 b=CHx7AJ1SBqtMdSmr0UAqskBaoYa6Ki0ethKCsq6TMeo2VSOso35jvGZSX7gjQJTvs1g0S7Vr1zUI0GMzcScevDi8SCvXLla1DPh7+AOZ+K7MSSoXJJK1KBcg3nFtyUUzc9fAuaV17bhpv7LlG+rjdgxDhea2h7yWswDxpjrCdmFIzRJjhSiOzhS5Kkw3pHFFkmoj4RPXd29Y+QMwK+T/gsHP6tLEOK7VJQbGt5pjz1hI4NpBcR+IigYzBjAMryfAkRDP/DEQA2/OBFAgsx3xrC18m/+Cr3/GMDvEB31UcGA+EUNlkj5g8URbKCTqU0BnWwRCzLfS7ezh2MEHD4TVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P35lRD0k6hKfnzw7HvvZ1dv6g/sicPE3VnMGP+At3B0=;
 b=fTa/EQgVCRi3gxoPK95xGIN3/RYjZe+q26tM9XVs37uRwl5exrr/IcjHbxdUwPjiuCXkdl0wvIEUNzW3w61vjnsfzoLrWqu734ddJQ9N8OPNbQsIiJc8UHR2cLHQ3ZYOFxHPPWZMbU4oScaDNlwcBuvR1Hn7gJ7wZoKi9A7q1ag=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by MWHPR12MB1134.namprd12.prod.outlook.com (2603:10b6:300:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 08:40:45 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::6d) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 11 Aug 2022 08:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 08:40:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 03:40:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 01:40:37 -0700
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 11 Aug 2022 03:40:36 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add mode1 support on smu_v13_0_7
Date: Thu, 11 Aug 2022 16:40:29 +0800
Message-ID: <20220811084029.1924377-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f46cfeeb-4346-4fd2-a659-08da7b752f0e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1134:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4bix2oeqpWQmjc2IYKpXHT6Deq93w/1zJpXV0+1rwei0HUi6eSbbBXJW6ODlOSVDBGLgIx97+8v61/utxBCjR8Z51nm5OOUe/joUeUDnoFwDS2WsY/qGpu184fXXIADSXBlA/QkIRq7i5ZRF4JiApT/17zC+6d81k25Y2mCZIRv+cqv2/i9pltC+IfgYrxVCoW+Yg32t4G6zpDJkfm3+ZU8MMqpkKPXng2Q8FSSqJcvxS6lboIYCMuDWy9Lq2Ipto5RGJV9z0OcGihqVWA9faOGl1MSbQRFULwJgnSAqKG+9xJOCudOdVUfep8dq3z3IDTR8JjV+NwHl32BLqOaBn1OyIUrEtElud9SWUFk7wXM7ilk/o9hBLyTUopEa5cCIEZGUz/RwSG2yvwT5p6XUJbwaeItmJt5ybk1RmIz8nMrpoNPmQ87QufXclBB+w+EEY+g4lIdEOmeP/2J43Ol1tCp67TdoBShDe4CtHiYj1C2pwLrKaoXczFeQXe2fG6se2f5ulBT5eyqj5/eyVFlB6K/MnpbH45VgIXW9dE81d6oNjqD4ARcxKhdfSmUojRv4lWiJeAtzq/EHQrI+VeFDVe177CMz+s4+QEmyPCbBag60yeb/XtEkbjBCKEq2ndKTOgxCJiOuW9Z0gin1v3AZGSqSvxd+oEZ3/3FFJIUsPqptTLhSPjWB8lGlOmv9tcqtFoIhI5cadPvpp44fEh1vaKPkbQp82n55FL70PKIaBxD06JymQ86j0qzk9wT8nfzMzQHu51xb5rct8hTt2JrpaJj7ZuHsbBR1BtTOGNF7oTwHsxjWlUVcveoYkQyAgo5SSwLj7VxU9bPsQ8+fEBSVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(8936002)(356005)(5660300002)(81166007)(44832011)(40480700001)(86362001)(82310400005)(2616005)(426003)(186003)(336012)(1076003)(47076005)(26005)(41300700001)(6666004)(7696005)(36860700001)(478600001)(316002)(6916009)(4326008)(8676002)(82740400003)(70206006)(70586007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 08:40:45.5350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f46cfeeb-4346-4fd2-a659-08da7b752f0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1134
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add mode1 support since it's missing on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d78375d9a141..1016d1c216d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1567,6 +1567,16 @@ static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
+static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	/* SRIOV does not support SMU mode1 reset */
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+	return true;
+}
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1626,6 +1636,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.baco_set_state = smu_v13_0_baco_set_state,
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
+	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
+	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 };
 
-- 
2.25.1

