Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FA2CD1283
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 06:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6ACC10E681;
	Mon,  1 Apr 2024 06:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4yYy2zPE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F9710E681
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 06:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbX07n4pam1NsZtLwh4C0VbMK0m68p73E9AqNiYT4MAGDZBBrviP0Hc4CFt4IuXtGBl6wQlRByBfMpiRHbqiylHEp5u1Y5Hag85XOTSDcElGWxefE7hhkZYIv7Q2G+01dRDDZnYJ+4R8An98Dg78YeU0e64BjZ1Pm0tityFV/7H6d4fF/BXSZEsa9+UuV1aqhlaL1QLLRQa1D5LBURWNc7rlfECbE0jGPY4q1ZLegYydq+Rx1wB9cdaIPMvreR+AzfG24wWYKZEnJRYYaAlCeJcov3EQFSnVFxEQReCUn6RRXpD98VsHDeoktAu0ngwbqjv+5dYEFtf6YLR4PEfO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXZ6C747bEayLndz1II6kDa2gGt7J7r76ChTb29Ib4s=;
 b=DdhIk5psrkPLg3PeKQK/2iZ12rkt6oJL6oT8c+THddxSFRpDqhs1vtiRET9be7giLC2YGyNRT+MoSe86sxuAHQUX9cIYQC9rOygQFDmPMjtZeI4SoXqdoKD5ot8FLZPEN/+TIvLwAdBMAUzfrrE7TDVo7OzPIigY1NbsBN/JYpEfN0mhkiVARchk1OIwutbxQEaBPhx2o1vLBJNim+d5pJ/O4/oFFOI3LCBwgjJxEpSUTJTRv9kyiGD/Hn7//CviMQf9RZbfAart6JhDStm+r9VDnSx52FZMwB1MOBheHRDGZl1OMg6dU6F5cElACZPg0mlcwRmRULWEk78lU0KCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXZ6C747bEayLndz1II6kDa2gGt7J7r76ChTb29Ib4s=;
 b=4yYy2zPEZSzKl1CpP3+JU6FD2c2BEnl1CyQDTxB/zF7kKG9qR2T6i1znlg6V/Di/v17/U6nS71wMN8B05Rn1mrHFlZvcTBD7zaLGW+1E1rKZZUrIRSitmstZ4cao4jsIuq7Sc5hlFYwEFSb+Vt5bv1YUXXIcLquEbFSV234hmh4=
Received: from DM6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:5:1b3::41)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 06:24:38 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::43) by DM6PR17CA0028.outlook.office365.com
 (2603:10b6:5:1b3::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 06:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 06:24:38 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 01:24:37 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: update XGMI RAS UE criteria for sum v13.0.6
Date: Mon, 1 Apr 2024 14:24:27 +0800
Message-ID: <20240401062427.369821-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: fd52683f-57cf-44f7-b9c9-08dc5214687f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjMcsFpd9Bmml6ocRoSww0B2FtPgCzakeBZRbabrz0lz6p2COF/KHCdD/YEUWfyv841aQZ05oqh8G4mstOAr7fSJkNwddDepHNOBFnWk99l/0jJuAIn6hRh0KOA2OCV3Uh/FqGhmaO5LZtvhim1XMch47nXqlBbrA/mtOXNSYSQxRzpw7KuObEEcjFLq83uLb1kNgBVY86xmitgl8anm7bbZ/RY5awLZ+LIcjKET+/kq/QPlKTGHeATFAIMb/0EEADULVPmn9amYlt5nxBM+HU4skRgZw2DqU3otIMFhlaFSggqhrc4tHonSlbCps+ZPG4GILQkusEzYqmQk5ri+6LapD1CZc/adqkXUUGluzFb7t7GYGIh0rVUXbwpEEN9Vz1l34Imd924U8HXOtSZaY7Qh2x0x0FbCBtn1HTbGf0BrJMHu2K8kcc19/sbESsqWEkjKJY/TxHyXoorpxfACtexrYYBl9PdI1caszeoPz1oUCnAALw/HsKD1JTMZbdGGZmPegO6KfGKyvJBMTyuhqEiNnES878TJ3qgULEFNU6j8X/OQRj+n/9/srmXtx4v2cyOny+tFnOB4WZeNmui7pBqlBh4oJcSvtofcYpPoxeOBNbRbVrf3+dJzje2ckI23r5CQU0fMltb0un/ZUzt4MV/CkEutQ5tg0S7ww3rszLOir30fXERSeyOlltVWLQXtsxYkmimnLwQBn7suzZKtZevZCd3YMzfwUcUw+qGVvu6PLVTZ5FhRyXQtCk9iy1wS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 06:24:38.4854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd52683f-57cf-44f7-b9c9-08dc5214687f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
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

Add more possible ext error code.

v2: still use ext error code instead of UC bit.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 443233563a52..7a7c7f4b7de3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2694,7 +2694,8 @@ static int mca_pcs_xgmi_mca_get_err_count(const struct mca_ras_info *mca_ras, st
 	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(entry->regs[MCA_REG_IDX_STATUS]);
 	err_cnt = MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
 
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE && ext_error_code == 0)
+	if (type == AMDGPU_MCA_ERROR_TYPE_UE &&
+	    (ext_error_code == 0 || ext_error_code == 9))
 		*count = err_cnt;
 	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && ext_error_code == 6)
 		*count = err_cnt;
-- 
2.34.1

