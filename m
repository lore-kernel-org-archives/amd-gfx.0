Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809011073CBF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC8F10E66D;
	Wed,  8 Apr 2026 13:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gtyHuCl6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E3310E66D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs9LyQp2dytkczBEYrrGAcut1ByMqInR1XwU8T0l04pvL7tic2EXbfbpciQvBHR5iw45ftFqOdWzufJOO7tEqkW8viAsSbaSYelrA3WJmaOrzNMFd5SXanl9+jEsFB8LTCZ4L1vQbOrMDnX9O9atbyF97wKzfRDYCL+sM3cf7YDUaAb/4ptXBtUh1EWdxwjD4dvkUPq2WDePnKpOdCxpzh2SYycupXEi6w4FM6b4YCTrPcF2yDsVJFcqpJYf90glmb+y+b/rPyCOiPCi5yPt26fyfWEtu1xJbwGz832PHOPT5j6G2WVeZaIqjBBBEz+ZPLmveBHesPORYRRKqtQjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkuKVF8nX3HcH7tB94Btiwbh3ujsbEI1e3FuJzkVRWs=;
 b=hibGKFtTldn4beX/VqnI8JiiC010uzvkxhkoHxW5rY3oMZP9VtRogjO9UmbP5x2Nc81A1fxWp/ybF8PJ8UGnLTTeB3zrmFElxRJAbJLyLY8nwUhGzwG8CPGoFkpOcEJtI6w8+0PAc7xVKmyxd958fCkwRKr6P1A2OCXLO/BNLAXvCb5bjn1WQTy2Juvui4At7EhXnixafUhotULn20WDTKEuoAl8xGPPiG/a5ojFZbHsvD6k2ax3zDfVEmO66I3nKpqEb6Cm9edpFBTkuPQsfRAKMPm7i9dGfuHHJ/abXygmlwJuDi/K5bZwKTpF4QZQjP3OuG2Ol0PbTmK2n23j7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkuKVF8nX3HcH7tB94Btiwbh3ujsbEI1e3FuJzkVRWs=;
 b=gtyHuCl6gODSbNp3OE9V3jTzD7VFx1m4LOm/TREJJTOSeh0aoZWlYbAzuxikAKIlbVCjngog5wrikOkUaj7QXFV8BS3vGwUEUfXW6FLv8e6Y8mmWSUGHsO71Y2zV3qd25CsK/Izv70YADXmkAh+nVPy2+v0XQsVTWgMgj9YqSS0=
Received: from MN0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:208:52c::27)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 13:51:15 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::cb) by MN0PR05CA0030.outlook.office365.com
 (2603:10b6:208:52c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 13:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 13:51:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Apr
 2026 08:51:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Apr
 2026 08:51:14 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 08:51:13 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v4 2/3] drm/amdgpu/vcn4.0.5: Remove unused define
Date: Wed, 8 Apr 2026 09:50:56 -0400
Message-ID: <20260408135057.2133928-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408135057.2133928-1-benjamin.cheng@amd.com>
References: <20260408135057.2133928-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: e3689f9b-326b-43f6-c21e-08de9575e6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: aLmQf0Ltx5iDGakPsXJ0NAg14jEF5JBXpgqfAocc9K6Nlgx2c0XxPJVmPYKeOPmmruPolkDAaDU8+MZ1Ebj+O2JGdfLL7Sra2iO7HjPW6v+Jc5bYF6KSRRGI8aCFHxd+Ee3O5c00bbgQVMkuGnuYG5Cliy0b8AOPG4RQ8w02kg5yshcxrr4sorrPm9dBqtEWfhFeJgFOpnbJEZKqkwm2Ya4UDssdPCTOK3hNZ/2N0r1NNrrYgzwK8/dmwKltzy6RtY41OVPx6y/idNV97wmuWc2mfHekyCZAl+XMSoU4DLkRTHntyZh4QH1ywgwa88Pce8cZA75NbqNjXtvB1yGLcbgTll3EOD61pRak2X7x8c1YkX/P8UI4BA97xTJokg36cxqfqopGifH1qe9pedMXxiCM468W0rJHl07RpUFcV9Pjm3Nri72iLHH0Y7YjyQXk58RzejX9NZ9r7RQUpL4QlEAlt6VsbgHKL1HG8BOAQZpPLv0J1uyYtcqjHN9VWPNtAlYy8HsiC7AYnUms6ZInQcZ2aT7tlr2dj52MOUp8Prs+REdAX+W6NCKIX2OAwTRKZRsKFSYlCCEXq/Jizl6iXza0jHAO39Lq2EyEiffyokQd04AMegbfdD+9uQxmtSZLV3fH2XzEWH5jmel7wLmzxSDBE0afO6iJMDXX/x5Gng8MWmk1h/nb5S/9ERp7p0yxVrbgTCGAJObPYqKCqmiJHuuD0+iWgTvScEq+ZZY9mpXn93sTXJL04lv9tRnsMhPN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 27k2KcBwpUXsd+xRSVKIk/WddGGZhbV0xb/LlWP7/ZigTg8e4E6HQq/ccJWlgjSuf/qVfkBNwl1+XqrA/htqqm0uJH5jr/d3VxNgcEzzOGVe5DQDLr6NKoZ8KKgECga5xKDoEXiUtGUatx/vkcfc9iFTSNlAwvqGUJ5/hFF8CCr9TxpGgP+mM03lRWZCDe6aPOHxXd5yfCkU0I2OUvf031bHbo5H+PUPugght6sY95i/V1HFqZMrJS73xVue8bHNBw4CTCTr3qmv0mq5YNZMIUxDpzQuhILcPjSDlVpoS6igHoeBRAujdOhUSk9bku+umpUqp4d3WWReKGltgIVG1bArbL6hDQSNoK/TZUIlU8r0JryTNXpEPwbmg0kKGLsk1RtNP3BLqSKJ9aVvmFaRXjay8LnNkZiA0O3Pma/Zn0UDT0v1uibfRj3Ug8cMFiK8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:51:15.1789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3689f9b-326b-43f6-c21e-08de9575e6fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
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

