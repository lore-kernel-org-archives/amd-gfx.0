Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D967CF433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 04:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7676110E176;
	Thu, 16 Apr 2026 04:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYbVPG5c";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED79810E176
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 04:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDXMIeDGR1ktc3H0ZNFlM0UNaKhQCJPFb70urQvxnCT2yqw2g/V+O8EnzUG8iwG+YSyKrqniUE1sUogPqXoTXSY472Cd4qa1dQSgOsC6QYmnnqVio1bdVGni6Zaf28kADn/LW7chUGZdl04BtJGt2WahcE2uHAO31WEtnaZEnQW14UM8udu61FYWmSZtgFfVGJcWvOBvo8PN/G/1iMXu/fL0V6iAyMPwPATW93KqWFX7jTSfKQFDCnszYausvir1D+P07ApLhpZgAJDRaZKYtstfpVaE269lqZL9SBabceohDWj1geQQJOeEptp6iYiRp0ZoKcBiyVV9I8xiOls/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY7Az2AbT5+jYKmgzf9QPj6lHQX1Uc3cEWEZYWDqQhw=;
 b=ljMhv30z2NrMVzegaBV6JvQ8IYRPxiAtPniCi0Vk0WptRMRJhMyFoJAWdLt/2lQlp86XFcTcWag3AMKFcWTIt3XckftmYnHCeF7Q+hMwljUTJ3/TSfUcooUvk0vMRT9iClsBeTnpQG+Vv+tfZJ0R90mHsf88xymRPdeS7QdGNTjw7BFblXCimCJ1ZnxpPr3uno3XyS3+KUTMo/XC0wIu315A08xncYEJ48k+93nmY6hg6hjIwjrToOh/EcO6dY7i1NSED79XxBC5b6wNFUGP/6tvxEmYWzJ9hCS17GXRTycL/k6XaH/9d8U6faf18N+6ik9zaW3oCvY5H9tKa0/1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY7Az2AbT5+jYKmgzf9QPj6lHQX1Uc3cEWEZYWDqQhw=;
 b=aYbVPG5cyYkymBkX3SEopgyjqXmwiJoJbTuqTGrVsHsDqEK3NPEkVUHBl0rp/MG3N3QLd58AHKUZXilbONDrzl0nZpfzE+4S0B/R6PNprmFi+3a8NOgqh0gmApAEVDeF75wVk30xCEOGW8qaPGNw2X5OSnB8vHDxD7psLNITDZ8=
Received: from MN2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:208:23c::6)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 04:50:40 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::d9) by MN2PR18CA0001.outlook.office365.com
 (2603:10b6:208:23c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 04:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 04:50:39 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 23:50:37 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: fix profiler ioctl command number
Date: Thu, 16 Apr 2026 12:50:24 +0800
Message-ID: <20260416045025.1825888-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 28782ee3-67bd-448b-48e2-08de9b73b514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Eie0USXVK7NrazdFLhe1uWGx8ih4AIAIAyHnYa/uMdnEWaa2/VkW1s3s8k87zijgT1mCQZVnLRiAxybD9oD2SAwWGB1QoYtLy0cfHlOxhrHy5MT7gRFMkipybiMvni47z+hKVA2CCA+07jLhJ7oiuOkgzC48SUF7ngPu92bgsJB1SJIvRd/iA62+VW/hNzcT3T1Hu1+XZGEJMuCrNB9Ww71jVSvZ4bF20ZQJw/Q+QtK6DASuP+cm4cWWffOtNGXJwu/CSpUtwOb2ezUd0MgWPiAgz4izX3E21eEeOtS95awpxaziYYaAxLrXQKfOEED1txg/vYMngNdE1x0KT81pcvkdIUFXGOEa0MGm2fFj0cs2SNqXfDcdWxBo9UqCFe6TjLK6XN+Z9VVdmYinUEnryi4ClfMf9qtJsgus0X/SpCtOyxexNwXdCtPoAtTPI4nTz8MBlwyFF/dpAnqUIlL34ENQ9YXlFwxTRULgO8GuflcRXOL+8W2oEgTVPQA4aMakm6Jk5VsIWvjW46ZqLe4kOf3ercVXjhEpMJ/5FJzUgj6Cjy2df/87FcaryRzUox2/yDXKi20rnBQc5py7U355RmBEKH0b/esrzz0njtsxADoG0j1rzIYokoWBU/eDvHTFT2VhILGxWbB5PeR7PMySgQb0z8ldetMDULKY4gtlgQTv/too7t6+73D/0AxVPelEqHH64lNpQBKDZQA8dLsnfiFan9WLuwOB6diRfKtGPhrAdMonB5VQAz3+L0TR4wdW0c+bfeToK5sFhsEO3VPkug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F71BIlIKHbZ4gvlel+lU1+4LQxSmgsjvwLgkX0NjqExHD05IlWp29TdpS345e6tsw898Nq0D3RA9MFo09ftMGwFVmxGJFV2va9aCYzAJ9Gk+gqiFhr9FJkGGRy805XoXodcss6nORCdkdyCGDxKVj5l2hDR8AEM9SLWeBVTfaB8ZlOouZpty1h/PQEj2cKbXB9t/j8LxwC5SPX+AVMtfiDcrZ5FDm7uEh8HwBzPCBiaj2ZihCDyNvq28B8hsO41hA9wveDrEbiXzNciib4o64KwzINQpHe8utE//JgTKKsFHgL+rP3+N76n7yORJfVOgXuPoUxOLwKtXApS8q/gIT4sXWMDXeK8jaiZ9beowWfeX3Cty8m08mWhzjw9WLWo3W1Y2TzBhm4M59YrTnRLEGBkNKuOXDhVbE8Y07aWqZ0avm4GKj4yDPlPKygb2l1a5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 04:50:39.4344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28782ee3-67bd-448b-48e2-08de9b73b514
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
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

Move `AMDKFD_IOC_PROFILER` from the secondary ioctl range to the
primary upstream range at `0x28` and bump `AMDKFD_COMMAND_END` to
`0x29`.

Fixes: 4abe9fd1e763 ("Add kfd_ioctl_profiler to contain profiler kernel driver changes")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index da93daa3283c..1a94d512df35 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1711,13 +1711,10 @@ struct kfd_ioctl_profiler_args {
 #define AMDKFD_IOC_CREATE_PROCESS		\
 		AMDKFD_IO(0x27)
 
-#define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x28
-
 #define AMDKFD_IOC_PROFILER			\
-		AMDKFD_IOWR(0x86, struct kfd_ioctl_profiler_args)
+		AMDKFD_IOWR(0x28, struct kfd_ioctl_profiler_args)
 
-#define AMDKFD_COMMAND_START_2		0x80
-#define AMDKFD_COMMAND_END_2		0x87
+#define AMDKFD_COMMAND_START		0x01
+#define AMDKFD_COMMAND_END		0x29
 
 #endif
-- 
2.34.1

