Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76F2C47DB3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 11:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B3D10F037;
	Fri,  2 Feb 2024 11:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QlHKRmrs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476A510F037
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 11:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR9mODCQD+LUys9TQa7fwmboA46j+6Bh+ENDRJcYVVWtNluTRZv/UvA3hh84biWuqzKefKSD8orq8pYUqOzk+VMJFR9muqB0b76Px0/JNOFl6jjIDOkbC1fxgNYdEKyer7fQQ8iG41Mysr6Z+phVxkCMCTU2r8Q7uSJARHbAQ9IY3ot24fXflDxbnRLiDlKjQKpISk1SDkpYrJhlCrzHC7/DvxO8bPfL7vLIo6Wa1LnSRy6shAYtT6m7o2H4MhJqJBu065Viqxvj/T7BqF4DybRg+f3n1tZNaFtwtQpB5lCR/cpNa/OnoQgLR6/iA3ii3gA08eIhbk9Kyqy5Yllbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBpDdCRxrzXEaDLKqUTA05ev16okxqf6obF4/hs/0v0=;
 b=KBneIEiFHYe8uaeimh6PzvtCwTmOy65ahzfOlEi0AtEOg2hBtW9ZyRSHMqwlVsAz8m+1VPjHbAUvi/I8PBp3p9HvNEI37j64MtS4m/w66v9vow2JuwpdwDXrSbYc9hHxRRJY00f4v3kXXRN9jzLFyt+HhrI1A216oL0xZ5ew2pqTKKMmZ8oY2YZzKDR/yTyrycVrVjqeXpqaFP3B3Bbk8EGsACaO+zmY3epEei0BM1gjEKqfLdgVcfhhO7Z29O47tSxE6jXaQeO2u/DQk9cpwfh3VwIvHOULFGSCnlbufntSMwBa4fJd07ayD4nlvJKtLdIbVhXnS6ufB2mZmkLX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBpDdCRxrzXEaDLKqUTA05ev16okxqf6obF4/hs/0v0=;
 b=QlHKRmrshOYFe1MkjOSMWPpkjXs5Qp2R/A22fLNu4jQiZVhIxfpmPq+f8Wj8/jWxTwRdYs2XGmbCSnNhEy801CwblcqQ2kRa2pti6d2oy7Z1Fy/1NQslLHVByZ10PlB422HRVyrq8/C4BBx1UpQN4PNqQ2KQmeQf66+TyqRDQYo=
Received: from SJ0PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:33f::29)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 11:12:47 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::f9) by SJ0PR05CA0054.outlook.office365.com
 (2603:10b6:a03:33f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Fri, 2 Feb 2024 11:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 2 Feb 2024 11:12:46 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 05:12:44 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amd/pm: Retrieve UMC ODECC error count from aca bank
Date: Fri, 2 Feb 2024 19:12:30 +0800
Message-ID: <20240202111230.1153924-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b6afdb-d1ec-4781-8f1b-08dc23dfe2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNOoa85MSGCiRXOgFJuL4ajuvosiyp+zIeEPCyM26M1IJcF3H6xgGMb9Stk3TpWCPyxkIW0KhKLY7B+Ycb5WIM3tQ2rHY/3kniv8P6oppnm2F3TaAJ8iFjZ18QCnVNB5riKzsabyQeQjqbKmAQKd/2BIkodPTMjCwbh78xoyrRABVaeUZvNuw5qPbLmuyPs7wwyDkCELlOvkvkGjYNnwdSxYeSAaDfNQLtwM8glFyrDRn+l6t2Ijbq5V9Zr7q4wKaSqqTXXtdZCoPJVQPFnDAMTQZ4B37XVOGHWRlPxZm4pTt/YcKLbO6ayjRIxITtJ2pfqithl3VQ0Gdrs+ue9CmwKemzxgyh6CSkyI1UheQ2x/Yn4nPLVH5NLfURkZNpgbhXOM1BKjJZwCVOCRRiStjh8VpopCzcAVyvHBOyOD3Qj61y1yVEiXoITkxicOPrMvkSBzAk6J0hMUekJoona64fMECm/UuYjqhApS3iJwsixqKhaF02XZs9JRsVSuhZ90r5n7K4/OrbHLWtL30QdjD5oPvQTJpsQPYCQXhQruK/bNBO9CWr9bYNV/y90r+Qqd/Q2AoQwf1SriI3IOIPblQTuOc1iKb3qjuNiwKzF8UiB+NGCpVUSnNBpSgqSDjIylsuxtDTB2v1tAFf7MSl8ohJMaxm32wfcKBAZVQhi1AMKlxJACgMDckAkB/r2BPEjF02qYWwFG6Q+qMPpFZPmZc+DyNHCa4pMVm/CzB6HPg9vwR/41WJKRPy7UCjcFCk2ubposR4IfH1T2aWZZwyNxddviQzHPf+lVPFAjQ48FA7k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(44832011)(5660300002)(8676002)(70206006)(2616005)(70586007)(316002)(6916009)(7696005)(6666004)(8936002)(1076003)(478600001)(426003)(26005)(16526019)(336012)(40460700003)(83380400001)(40480700001)(47076005)(36860700001)(86362001)(82740400003)(4326008)(356005)(81166007)(41300700001)(36756003)(171953004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:12:46.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b6afdb-d1ec-4781-8f1b-08dc23dfe2cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

Instead of software managed counters.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d6e14a5f406e63..03873d784be6d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2552,8 +2552,12 @@ static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct
 				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, uint32_t *count)
 {
 	uint64_t status0;
+	uint32_t ext_error_code;
+	uint32_t odecc_err_cnt;
 
 	status0 = entry->regs[MCA_REG_IDX_STATUS];
+	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(status0);
+	odecc_err_cnt = MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
 
 	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
 		*count = 0;
@@ -2563,7 +2567,7 @@ static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct
 	if (umc_v12_0_is_deferred_error(adev, status0) ||
 	    umc_v12_0_is_uncorrectable_error(adev, status0) ||
 	    umc_v12_0_is_correctable_error(adev, status0))
-		*count = 1;
+		*count = (ext_error_code == 0) ? odecc_err_cnt : 1;
 
 	return 0;
 }
-- 
2.25.1

