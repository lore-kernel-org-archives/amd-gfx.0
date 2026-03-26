Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBEB109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C6B10E944;
	Thu, 26 Mar 2026 03:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bgr77FqV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3486C10E944
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xs0UCblmvF2S0AUJcoAR51qfFwIe55vf5VVkZ78wYDteGbNJgcIUuztZQUQIWoJH2GFaeSGW0166+y0vCxWIEJuCxuyqZi0GBkmt8X38fjI53q8+odDyXJ8IZYAsYdHLhSFWdEJKRFwijvBsABLdRBgOkGDNbL0i1YMNHqbM7wCBnLaG9L6nfx7Z6Cvhr+Q73ZC4kA5FGg+MiCfJAU5+Zz0t5uUkJYb6kJbgdGh8HPs3eRVfBsHH3L3cg38TXHH9ey3/7Morp7WgUhhTgsl5ydIMoDbrHRwM1HklfcRu8SIi4F1z2Tb9G8UOVqx6ZP6JvV9iLHaoDPWnDv+GOC2V8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zgo32S+NurOSwu27us7iKAM/h0uKlNe9+XJxCf8vb+4=;
 b=K3jUgdyTubQjYQH3EizcjDZD7BX1QAZkA/1MG6VhKMfjagK/gT5i4XqdyJCUHuvh8sNdAgKHwbv/SqW0j9NnPGGHeZx3DJdgyZMb2fI3hQQf0Yzv9feL6pz5bxgSXehm13BhlW45ElibxGyGQOgxijzBOJsXurd/4dFoUyTkfSTH3avh8U9JOtpOLoPpWmvfzHa/F4eLfRXn/4KT9zENdI9d9KrrsVA6o70p4dvHuqcRXVg/YdDlAyZ2pJkkLRxGQZU1p6YB9S4AL4WvbHcXL+0LLeNiZBacLyzWHIUWRgTnjZ+ZWJ7wy0rgFZIzu6VwJYsBxVPCVzLbLdbd6+pftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zgo32S+NurOSwu27us7iKAM/h0uKlNe9+XJxCf8vb+4=;
 b=bgr77FqVUdDHcH1D1BMlCv6Vk7ZqTJ1k6wr65hhwsuFf3UYP0U28ySYJyHlBBarP5phbcAh/SjmruguzQ6N+840l/fKETLUZ4n+3WoUesFnCDtXFrfLNWvDTwED0JW2wQWwuQmJunnivaBOiW5Y4Yk7QRkyN8lVKoOeO5466FMU=
Received: from BL0PR0102CA0019.prod.exchangelabs.com (2603:10b6:207:18::32) by
 SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Thu, 26 Mar 2026 03:02:57 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::2c) by BL0PR0102CA0019.outlook.office365.com
 (2603:10b6:207:18::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:02:57 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:02:53 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 29/30] drm/amd/display: [FW Promotion] Release 0.1.53.0
Date: Thu, 26 Mar 2026 10:57:20 +0800
Message-ID: <20260326030153.406612-30-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: c677fa97-f527-49a4-07b6-08de8ae42eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: fyLRiRPYtjOJpljxi1YqQszFBVy4Gw0GuaPMdEZfaFc63c9gnwVPtEVi06mMYZKBO52X3O3kfAK/05xxNTjYlzMWw0yc4izYJVoorJhEssm5XJiWq0FRmO+pwdMjbT7gD1eT8OyZXP+2k6Xh3U3aLdxIFY/PN7RNSV+NQzcJE9iFcObgtUivEXVWhr7iwdAnr1PASv3/50mPpAzWFgq5Y702EaraGZiTUroJybK/zdx2lacQozo8zg8grIrh7OL6EZEaUWDnOEJUDlpvc+HGz+s0EmabN6icTrRnvOKly39MGCtMwE748RBenOX3GkleCDk3p3eZHc2N8IDQpQvUrOTNbeNrxwS7HeZ37GgVX8bOewKLWfxl3hTRAzRYwvzbCOcfM1t6mRjg1t/uyQiBhEWlOaadmU/pEzLocTInCyWnYpSrNXw8xzqF4TE3vmOpod41kUtb7qsmf4Xwt+wuVYvp86KvZVjJbGmpSK7bi3LIRmOjHe+Q9SWc8F97XUm2TWksmHbjfePAegymstWq4zZxN8mIBepEEDnmcclQQcEBn2FD/6TRoMMVRRWOecrwebsSnC0r0rV+wwt60G/5NtCgq57DTt0bXKU1XCLtf5QR1aSaqcTwnG1lcNFF18OYMwkyqKCb2odRLKQhU+Y2uuVBJtFLh2PP3554mbzzQPKckYyCQ53E8tVaZ0MFsivUYpABpt45at5FoY2fGKkXuu8GgV7OaYWbkNvS4MLtOrtDhCc0ieI8QpOE2uLUP9bS5WvKwMyCHuxZdFZNt6MgyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lx5XRjIo3UttSck4MbYpgMyYvzm9J7xTbC1Zq4NveKgz7hYfvDjYGbw0ak857lxM30J/4r5irxqNrWiM5H/wHFi/VDeovgysSQuKJ+cvCnHoSyTpWWXYgT6cIRBf1vEvMbIEjaKWPfE8MLILEmtft/awgZ6YoT8TTIWfHQjPIfrunTcF52AGhiA5aD6c4t264R1hrlsy/qwp1PVuxAY4+Uh4kL3MExpvhKZXkB6X3NUXiowXp+UIRJlINjj88nf2OiUKlMsYnREP1vlt57zFwopI34Ue5bm9opKAYIECEuIUwtmTfOAy4oxyfOi3MpITOVLK9vS607lGpyX0Ag2k7a3ew4pNKhkc4dJYzMO4+G3vd5L3rbwF7lH6kAcbv7ZIxWvUqHT57mrV3JBjz9XatoMtjkaWh7OTa658f2vBxkUtYvlGnfVpUO2mpA9R0g7U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:02:57.3316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c677fa97-f527-49a4-07b6-08de8ae42eb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
dmu: Parse freesync mccs vcp code

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 8fbd179a4c87..fe9431cea3e5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -6272,6 +6272,7 @@ struct dmub_cmd_edid_cea_amd_vsdb {
 	uint16_t amd_vsdb_version;	/**< AMD VSDB version */
 	uint16_t min_frame_rate;	/**< Maximum frame rate */
 	uint16_t max_frame_rate;	/**< Minimum frame rate */
+	uint8_t freesync_mccs_vcp_code; /**< Freesync MCCS VCP code */
 };
 
 /**
-- 
2.43.0

