Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01016CD1283
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 03:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC9A10EE30;
	Mon,  1 Apr 2024 03:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H5h5DkSh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB4F10EE30
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 03:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtZq47AVQjUOGe8IuwFsLtMKWLDqdG405ek63dqt6ZuZnpvWsPTXPuMIXiQGmIBxne6fJy3rJIQfmZn+qiRvP7VI/rZCw4JDw2UVL+0iC9eKHGBfltUEAzG9WzVCZcjR/twUQ61BzKOBt2qCUeNWiPBCKO8zu2AiCjT0wkHCFlaJTgBwx0Fugw2fz0ECTk+x2zJfDipr91Y7lIY4iqrOBL6zlFGLX+wMueQzbVTQ1baaGcENA7CosM4gZv9jEO3SYE7z6E3aBmyrHVa4h7xbo8WREYTufG3q4Wx/MGHLzHPeC3F0KWNl9DtSzjZFoKvako1HrwFlP/23m5p9I9v4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0mDwnsHkJ11X/xwc6RTBt6QFR2q1dXroI7IQr7279M=;
 b=kfvlpALbnWOrwO3BiI1G2CFkKFZwV0VVNoO5175JS8UhB7Zf5VKIHQ5IspKVK9JnZMXL5QueWdXETPluyTjo2vgaKh4fy9bEsd1Ieyi51o4FY4gJnMzHAaGQNOi1n6P8yFGGAsCD8+ESsJaivLFed9ts8q71eZMSJESLse2R1h901iYwFFawm238OJvgxICSaUX3UCThHlARAtcOwyKCnmLqRR1NmnoTVOn3SMvBFVRJ+hxLItoN+FGofvBXr2X3c87lXqGMNR/uSQdvrREFUu3XcRSx7YYFm0OydAcMjUCX3EyerYJeh21Mlloas7vvp2h7vZxb0tox24tHFBdZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0mDwnsHkJ11X/xwc6RTBt6QFR2q1dXroI7IQr7279M=;
 b=H5h5DkShdBYgFqiTJv6vg12C1bx3yRKSeAvGzRBVh+qsl75BgofRhXtCwCT1EMq7rqxqcXW2muNRNKbnQyGqUT4Kl7xMAaKVES4K/21k/vbIDuivnYqtFlZdkrSD9/QZooXWcWW0PFWFS3qebvQZ3XBxChDrkAebW1d2TD31ClE=
Received: from CH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:610:32::25)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 03:41:53 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::60) by CH0PR07CA0020.outlook.office365.com
 (2603:10b6:610:32::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 03:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 03:41:52 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 31 Mar
 2024 22:41:51 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: update XGMI RAS UC criteria for sum v13.0.6
Date: Mon, 1 Apr 2024 11:41:42 +0800
Message-ID: <20240401034142.369448-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad31eb0-cbe1-4e19-899d-08dc51fdabc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUcD03lqU8d00yixXuUiU5BDnnnZOnU8k6Vhuec7LehYq+nRlCmEDLGOQmhKrRGcvH2UESmMv9I7ZORo/FUbXTjs67z2U9olfPQGFDsKTqB6cjjjlxPccLq+tiO+AgFEApDfET05zcmXnVkt2Ek0xW1UKNMTCRkqa4NXYX/gYl+IhTXIXYvErhbVIQgq3LUcBXRROwSOKQwzyDlzv71BFRUGdclq1fn9A5aO/6tYKA2znjEMf/100xntmCU6qbG5jJSny/xUeD9DLo6yzuwcgn2iV80/t011p1C2ecV67kzbt+/bSekb79FiJpb71Y4jxk3ebYV0+ip2S8jfN0PwMZFu9Xt9OFm2V3/m8O4C9UlMYePNyLCJTnjg/dnfsjPmMv9eQ/zXP56fNSjdf2whJlzQKho0LjRpf/ueAQKH3BP6HMaZRsVTD/s5WyE7BLfRP48LPloRIuDW8Bm6lar/O/3WM7c4e8924yG8tqmgJfnxz2xvSrXOKeYcOIJOuFa9Xv4gwrY4Qy3jcKJjS3iZTTrFIaLF/Nqcr73ODm4pNmoy936Z8CGOVYXmrYEH8YEX6lgHmTv1WEGczNK5g8oLUjze7hTV+ezRIiIP2Vkc963HaFciCNnaezA2N1Qr5wdtpnCtJ0bBZoRvT4O0zGSFd687vrMihV4573UJTh7ig8dQnQMMR8AMXIw+mkLBo/+3rybu5wnGMx5cNYYjkTO9mLjyECNczF2UyOKycWAvhEzuzUfyb9KV/cexB/iN+MdD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 03:41:52.9084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad31eb0-cbe1-4e19-899d-08dc51fdabc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

Check UC bit instead of ext error code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 443233563a52..027bbebbf28e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2689,12 +2689,13 @@ static int mca_pcs_xgmi_mca_get_err_count(const struct mca_ras_info *mca_ras, st
 					  uint32_t *count)
 {
 	u32 ext_error_code;
-	u32 err_cnt;
+	u32 err_cnt, uc;
 
 	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(entry->regs[MCA_REG_IDX_STATUS]);
 	err_cnt = MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
+	uc = MCA_REG__STATUS__UC(entry->regs[MCA_REG_IDX_STATUS]);
 
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE && ext_error_code == 0)
+	if (type == AMDGPU_MCA_ERROR_TYPE_UE && uc)
 		*count = err_cnt;
 	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && ext_error_code == 6)
 		*count = err_cnt;
-- 
2.34.1

