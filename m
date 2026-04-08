Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7720F1073C93
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C7A10E641;
	Wed,  8 Apr 2026 12:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mDSQy0av";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778A510E641
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwCNh+/eGc1WNvtJkRQUpV2aC4801ZKPUpH2a3RT/YFJvlqd0VxFo3ofOfaI0tKZg3jH3Wrv4sfIN6g8fUeG45+WEZ/EaZusdnoFPXdqXksgDITLVucSL3M96vLM2p5tf+Yex5oQkg6wTd/9gXCA4nFoe+ZJDapkhuUyvhbwel1T5r6jOuraEQL0kgPL9vsAtcHFU+qx1KtA0bRrW+Kd4T4CO0tAXEgK77R4QsUUzypCZsvsBSbWcKnPALPRKj1UPWRbXEbVyYuFp/OmJ2/6nqsGkzVp2HLA3TSXoFsaVKtbcHVzg79DdSnXGGEDshQDoyAX72YXE/80y4TRGAwEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOKvtwfTzChrq6LA/RV9OTpwZQ/mO3JjelFtNOHJhMY=;
 b=rgrqnGCNd9ME2EJpqJnfEPwDNhuvnbWZRTSo3CO/RxeQua/dDaVcIIPw0rovQSRZ+/LwnY/p357+9rN1SqtFUSEipmBPf5AtPmJbAfdseH0oD1oZ65V5kz3+ybId8Wo5j6wuo2EsDK76PY12OphwUduB8xUdeFLlWWtrQ191qkB+hsy7c4q7oQpnOqdm5wafeqOKZLvB5+Rll7IaVNi/UIimSwyIEgSai9EFMmsLz0Kervn5mIDbaPW9eifqAYFbGpuM2upw3D9RlCaO1KhA03dIPnNYSapRW7wEvxAisUlF0UqxZ1iv052ZOzmp9XRY+Z1+uOo6PyilAl1fT/19lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOKvtwfTzChrq6LA/RV9OTpwZQ/mO3JjelFtNOHJhMY=;
 b=mDSQy0avWfw9kH2SZWGPu06nC5GEVfrm5C7g+/YHcxysvw5OeDDQO4G+WIAoQ2uCpPBaw2eOuLkr9uN3s7Q6W9czfXl3iRVe8yCHPYHqJg1FkdETDSHp41Ra3SQfNnlRduWwcPUeUFeMwWuG0e9TzjpwOVuS65+45KEUKM2PNAA=
Received: from CH5P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::26)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:54:41 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::12) by CH5P221CA0019.outlook.office365.com
 (2603:10b6:610:1f2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 12:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 12:54:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 07:54:40 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 07:54:39 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu/vcn4.0.5: Remove unused define
Date: Wed, 8 Apr 2026 08:54:25 -0400
Message-ID: <20260408125426.2118644-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408125426.2118644-1-benjamin.cheng@amd.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a67bce-7feb-4edb-f851-08de956dff96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /wVfE6x3jBjIsr2pDs6onOBtmscX1/nKSiV8NUlJL+faNOZtE0JItOgCPLf7CLLFxJNVJfT4FNNn22eNrXQMBrVOJE7NyTS2bYMIGULlVZDf3X/QLuBuS+m79NsvZ4hFqGwHh5kBRPUFtLUtzu8qNdZvUAYqeU+s/fFuK0tUtAuc1YVdTqawmlamfsYGJo8e7/i2ihPv94E3AjrmXzFDpb3stzBTF1LB3n5iVX5hiEZEQxuZu+U2TPmb1QzE8FC/bIVMaHyrXc9cWNZs3j5zezRMD7hpuf59W8YDMo9ffQ81boUmQcIrWELucWBrsG+It7quIIxNaklnLkKjukoae4fsbv6TTT7a0d/FNMR/qJYtF/o8tsp+Hwws/+bP2mtQ/hR1Xmtu5Vi3N2tOq8AQHH7yvjgU//qajj4tpOPM+gOsXUocv7w/4LCiRNP4pdSh4XN1HeP7Fncf5XbTHf4NJ1E0R0ljfTu3I5Zzo03UZzjc1tG40vkBuauQwy9Z6epworjD8/fpK3zPQbfNoUncHHEaJi0obI7e4Tk+hqxZ+UcEq5lP2Jv8jRimnoU7lWusDM2RYMzwyvA5nPmgMffoVL811899x39CLbeiyAtx6BI8TLnZDyBWz0TEp43c0ssqKun3NfOwvyu8VUbWrlY0/+HRLi75xY7BzGyW6dgVT3Q1M2R07Am+U3PmrInIkkbyMWZNAkPpFDsKZKzehAEZrv6N7TP/IO+vHH0ufSHGdniSE2LDoVIypn08Eocy+ckx23+Qoln/+Jng1amuuppGvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sjc+6kugBklzsh8O7nr061NZrUV/++Mlnw17VHNyLDfAJwrX9vJZkxfEZufyLkDFAKrONP/wf4bVNxMHMNo+lOdzV77Li7/3mVEwS3arcURiWsJWTOlEdmm4IrhoklGvsmPcBu15Vaih8BvKEBbT6o5TWZIrVp+Fn38cKRyGUtDVYIt7/LhjSMz8NUb7bFcpTjKR07u4RwjKmFw3w/y+PCsNB+BnqQWJaPAJyqw7PqfWcjYP1FON8n6i7fgGVe57DX4G8K92RmYZ+kCerXPd6rlYC5+zhjqE+1G48A+R7i+cECACXqLnVtbPNwEFCJSkhB+gNIsmmeVRjN0a5sEMNuchn3BDUG6kRhBY/cnL+Jzr2nN8TSxk8eVTHS+sWvc0TdiCj8t3r75Xy/KxWbJa2A507vuvU/v6t49h8r5WdIBA5S+sgtYSn7cUjLYjQrVd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:54:40.4707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a67bce-7feb-4edb-f851-08de956dff96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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

As part of the previous cleanup, this was noticed to never be used.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index cbbc02d68695..a204a0f5c44d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -48,8 +48,6 @@
 #define VCN1_VID_SOC_ADDRESS_3_0					(0x48300 + 0x38000)
 #define VCN1_AON_SOC_ADDRESS_3_0					(0x48000 + 0x38000)
 
-#define VCN_HARVEST_MMSCH							0
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_5[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
-- 
2.53.0

