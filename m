Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9653CCDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 03:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87ECB10E156;
	Thu, 25 Jun 2026 03:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vg0O0r09";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CF710E15C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 03:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSYg6jgyqMOvVys1d9LwsbRVC/LVmgB2sv1X62MMEqlqXnZ3/OPoBWL77mQYmK9wSmunfJekUlprPdR32l+vpndOK2CK9XzEI6JJPWm7p+AbDCoeqgGb3TCMW2veO/qcefooHlwjq71XdTnUNHFr2rOXE/ZWUaGVV+bTFb/29/cWEcjMNh0bjAk621hXlESeg+SB05zDHGlKQuFdw6NuwX1h7gT4KfYpYejJaYXFfwpkWLqU8WB5up4CfwTBOsxOMfaT6L6IBcDl9qBdc9rbS+GBdnWE/2jNW4z3i0U45g9wEuN+0vTdz3Nt+RAxsvl+HynzI070dKtK+hPubLctZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=278eZwJ+yvpoFYk/cHhS7ZUsLZWeLrp2MiycEaHaNcE=;
 b=u7/wRMpU2Hqnro+ALQ9Xz+MAOTzaOphRqhwezH/XXk7QyZHgOJ/H3H2KZ4hef69tu94E912W4e++0AQZkBp+W1sY4ax9d45oETe+BR6+gLYgti9p5hdCDFqSnKHdy7+ctvfkLQBgyzy+L80zFngLml/qs5aBj91u4RuW9Tr42LXtmsbL5iBBdWAjFNWDarNSObFYOTzuDrwGEFfy7hHOuckPqOF1diq2CWcR2Q1XPk26WYiCkclWtt6c5Og4r25uSzN54ZAR/Ply3RRQJJBRjn13RkcVCKF8XAxZO3oNSyzuHujFAG0iBKeR2U4YyThVpfQqWC+OvyULtaLzhjX3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=278eZwJ+yvpoFYk/cHhS7ZUsLZWeLrp2MiycEaHaNcE=;
 b=vg0O0r09PalDQiCvjFW/yieLzViSIUr02mdup7myV/99nwi/zgVipXy0IYObyBSxC/xzB4E0aoTRAj8fuNWWjy5H/gXpR7oFVn/lBPAuFN0X04JZcQomRoja88lAQCLjVqGkBbtqlJQ58nwtxHaNIW9lPSsaoG0gSp54OT7tWns=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 03:13:04 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::8a) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 03:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 03:13:03 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 22:13:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shaoyun.Liu@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add the doorbell index input for suspending
 userq
Date: Thu, 25 Jun 2026 11:12:50 +0800
Message-ID: <20260625031252.298647-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de50385-7bf1-419a-1e4c-08ded267abbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IttBeR+Db4vGACdIJ3DWj88x21cOOmFhSw/tkc0/fVZa9pCa2UicOqDCcCJy0wSn00/TkKr0SHZff3OmX1HfI83v7KkRLtvzYtVtWF7BM2jujgUf5l0a1SFXdVvf4MPFp2z+W2Yk/1UPRxJNeyMs+g+HyFCOSAkaNMRzkIMwSa3Dp0ivxGd/ACrjyd4tLXfo+qUpwJU5thHgEXNJwVea/Zc6cn0T3+WYTvqTGQp4WuhFBObK1W2xjQTIbY9K2vzb/Wtq2gBK8AqYgtg+lFOaKqrYXaAZvOe2peTqbrn3BV6hA3vhQvjC2sqfkod5u9+X7q/p7qSxuDUA57og0id9t7jQtgr+vrLFMs+Rahx0dRPf2QM7G/6fyGIk9ycl38L1wuCWYJ26Ra1TnddG4/ZJAT0q5KkBjPGKNvPYG/9yLOgdkCFBeuoA95t5VBKNS9uXhT+2ilUeQ0KsypvQZJts4NtR/tNtPefz2LkJjfEiLR4L/T23VXlg8jv2BLOzNRNs8NklFCMNHxDZgz4vgZ3c7QYoD8HAXncM5zXMb3DP7Mux5/iSx/CZ6pRM5oNoIhS9FT2Y3bgt/eXSXqVLDbTBVHx+wuFZx1qfbP7w62mJIMPKxHwkRFSTMHsn6s58UczHmZyySaQMkQC1MvyvzdnBFwRFdj/nBGzxANR8+UBkcXP2VQwso2SE+aJxCl6KMFzTUDyljlNF9q1Nz7C+/TcbpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NIg1i8Eag9MUFS06yKqdITDCwhMu4L9kHit8ZaCkdATKf2Vqe3ztwMX3yGqzy/ERdbNBYF+LpXUghcEyxIk1uv8SrnxQOEdB4YiyBjgTJD7xAagymXYpZ+i0ZWo3UXX/8qGiUPWQrGrXBA0zcADldKnzDUaMhHeD/AHiABxhh6JnBh+IW16x/fGr0ydlHG0ntCTGTPl6dmU2V3E21BzgUYfrkASmOg3T1VqCrY98kPHzp1s1uOV952Fu7SiTJ3lOHc6xyRDM+cAH4o0o7NqO4FM57I0j66e2ssGO+ger8qBUNQ+5EnwRPBzNrOCzoR65bsVSs86fQzfc3/UC5Gm9y5I+2r6SJgG3xRJz4gK9mszww607ig8cxzABXwzh4GSUqYxYquHzrfUWXZM48JDriFcShuZQ91zTQFPEeQm/8z7ZfAhQrIuVpCS5egC1s/qN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 03:13:03.7154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de50385-7bf1-419a-1e4c-08ded267abbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
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

It requires inputing the doorbell offset for MES firmware preempts the
userq, and adding the doorbell offset also keep aliging with the
union MESAPI__SUSPEND in MES firmware.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 5255360353f4..b943af689943 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -305,12 +305,14 @@ struct mes_suspend_gang_input {
 	uint64_t	gang_context_addr;
 	uint64_t	suspend_fence_addr;
 	uint32_t	suspend_fence_value;
+	uint32_t	doorbell_offset;
 };
 
 struct mes_resume_gang_input {
 	uint32_t	xcc_id;
 	bool		resume_all_gangs;
 	uint64_t	gang_context_addr;
+	uint32_t	doorbell_offset;
 };
 
 struct mes_reset_queue_input {
-- 
2.34.1

