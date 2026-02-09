Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74012EF070D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF11510E291;
	Mon,  9 Feb 2026 04:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L+HAo7bF";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF71B10E280
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaJY1fqdlPMvqffSFSSYSZewM23sC6Cus2LETBYN1QoDIoSwbrSG/xgMgEbjfnJrmdAjeauGudbVSp1w1vt0mjGDDZMGzF2HsvOi9gg/uK4BbiLHp+ZguhLr96oA8O+sa6Kq7VM88eimV7J090PqgJaSHMFZ5L/b21P1TprzFMT6goPKpvhbaqgpFpMXJlUpE2W1GT2ro5Ro0JULitREb4HtZD+R+c67J77Qa4exKV5at+6EH/J8MfWqQiq24t6XKPPzQ9XWrmFF+oYnstqkJ/zjSV7LIPKWFEozMZkf8Zlx2OPTcXtaSh0FhY9C3eKAeg20rKD+VGuW/izqPkJpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4veaApGfvRN14+T7E+fhYEMJEo5lwqmjnMz5b9Xw6SU=;
 b=E8fXoLomjzC8OJM6C2Oo5wliOS2hZU1LtV4mo8X7koozDVp6TfL6BoNfDp+3NXyDmh45kXtd2bMkswil2WOsu4z/YFgESBbgTmzev3bt78VMw4nY7vR3ggvCM6zdHOW6N+geDlMpjM64VGR/xHEbVDpSN41HH1oCQwZhWIhrtgqt4kvEeN2xfa+kuN/qR5/oAFswNXl9A5oc/+PTEUVLUWQgannEV1mrj+qZHq6quMGGqbHO7czgHQBMnlvg+K0GFjdz4Eb0dI/WJpBMAQ1ZFiz6lgedvkI9ifLNyWwcJzS7RvvaYhXtlNwePbvgd3Se9Yh8Ur8HV+C5XkCeg91Gyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4veaApGfvRN14+T7E+fhYEMJEo5lwqmjnMz5b9Xw6SU=;
 b=L+HAo7bFkvjH36+Xg43IELL8VmPsz7hOsCqh+E76hppca2afCcW582Mvk3sd+B8ZzfNxXTlhztEjxZ/N1r0I/pnZOvgXayJnLDQRugeQnqPFK45mGpZwQk3G3omBu/2z4pwOBIEsEo1gjmrckyfgt2Yqn5R4hxFZHd4O9WvprAM=
Received: from CH2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:610:38::36)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:57:20 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::e8) by CH2PR05CA0059.outlook.office365.com
 (2603:10b6:610:38::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.6 via Frontend Transport; Mon, 9
 Feb 2026 04:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:20 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:18 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 07/11] drm/amdgpu: Drop unsupported function
Date: Mon, 9 Feb 2026 04:56:45 +0000
Message-ID: <20260209045649.59979-7-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: f0250cf5-9ff4-4dc5-ecba-08de6797b4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?21ezGQ1h/Q1ou4jiupBN569kk35iV9Xnla/VFunzYAJY60ch7Z5M0wj4s2tV?=
 =?us-ascii?Q?m+W6lizqYpYXPXU+oAb3b8kiMb18wKaRko6zyBkN90SU0KUCl9H0NGcniTpc?=
 =?us-ascii?Q?36VFdZmngHHQ3gcjVdSbGqOB8AC2IAIG3k5EVsZIDo08hEgCXEAU1tcYEosL?=
 =?us-ascii?Q?zjwUGqtjfA4n1w7iS6DT13N51Q47qEWGMNOzpRRW/UDVUWKog9KdLtDZUmP4?=
 =?us-ascii?Q?2bzX/6DwfA+M7QHLZ3FJ5yZmKaQECarTL+fkcUgS0qYiKs64CNvjWviPYWnm?=
 =?us-ascii?Q?zx4His/9acmhtEKA1iduGmDZLeUAMljLCQ62hKJ2RQBwexaZ6PDSje3fa18u?=
 =?us-ascii?Q?drasmpHIBRrYf0wTYQJXPzxVrI99pOkj/BFiKZebOMbBCx7clzbT6WUeQKWw?=
 =?us-ascii?Q?FI3roxRMxYPP2tWjNoPMM/orHeuv/8IMoltbrCDIGHuKiTCnMmJcphAXO/BA?=
 =?us-ascii?Q?1xzrdLyxm00OBvmalUDzShjCGU0+OYFIg4DgyT7yuVXg3+UAwxrbaxWVqe8Z?=
 =?us-ascii?Q?wyEVr2oatLcz7bLTbAtT2pM8ju06GIubfuOTo5w4yRFbr8O8PSvu7GUCRZ5i?=
 =?us-ascii?Q?2fv1n7ShbZWpWVctfLRmL9oypNXKFIk5IzapEjER2cjp5pT2omXVfHnQaOt8?=
 =?us-ascii?Q?0Wm+SXuH+/vx7JXXpVW8a3b+AH2BmHkwWpVyAQ90Ig45qQV9JT65nDqL/sSW?=
 =?us-ascii?Q?ARW1mfccK9h7sM6gbjZjkKErucGNxxOSvqvDnDrdsoBbTijcbeQ2di/GJsQa?=
 =?us-ascii?Q?amQkCRC8awSKkVCAMpNR5VkbRi2PTo8gjNJ30ON2C1FDzsOR8+DYI/LOfRsB?=
 =?us-ascii?Q?XDdTqn2JxEIH1C89qaylQ9HGhSBcQqQDbghfyFWQCQ29tAbij4KXpkQ9C07x?=
 =?us-ascii?Q?xZtSitJ6wORMijfZ15esdJ1tWja6ueU8vp4/lthD7pTd2+26eLJcysX22LcW?=
 =?us-ascii?Q?nglH0LjKJYraYMQAEevC3kHYpO9CfJFisgFTA8rywbfJwWtG2AdImMdMEHQ2?=
 =?us-ascii?Q?Dhnr/w2HSvvEze495gjNdIK7+I/fkqZyYcMzFUwxLeqebyq3fEMDcGUjaIAr?=
 =?us-ascii?Q?Hn4EQ99Vx2tuCECE0OCodxPqccTn44PngCo8/lbIFesYBdoKCQnIEkWY1Q9N?=
 =?us-ascii?Q?6H/gsS33a632Xe85Fx5/CkRJBAttwHCNXoZySf7HAhu8hY5q0+Yct1Gs2o0X?=
 =?us-ascii?Q?p1DX/X5Rr72CHCl9Gn06zTvRo//fYoa6jpQTzeV171B6pcghUDRTHhTAXZab?=
 =?us-ascii?Q?BvtXYJMj48JPsq1B8I0pKr/4LKVFb8gtuzHVeZf96GQcYX4iSTMTHX2PQ3u7?=
 =?us-ascii?Q?XuG49Gam8tqhNjS1O/MmUprSIN1/8Mne3SHKBTazuRM++/8u5phsZ1tBCd1t?=
 =?us-ascii?Q?D0ANsCT/EUqAV92DYVvKna+XAgCVsE1406JEuVU7Su/JnlF4DbgG1/OhgwGf?=
 =?us-ascii?Q?vWN2n6bDcaKP+88OayWIpNGMj4Lc0blnxuDr/siyCc1DAIkG06A+zM9n3iUq?=
 =?us-ascii?Q?xKKR7Dw/9UoQnmcwVZkAaYq1YxGgdU8Zbm1GAL2i+F+IWFyw8crTQbs/89rY?=
 =?us-ascii?Q?Y/vEWNFuBD5psBOcqo2CbtvjrpHPGhOLNVxRpTkKCAMd3Te66pQJRuL3Q7mh?=
 =?us-ascii?Q?BQMWkeqrdrHTqJEJmOmZrs9ZggV4QqXCZfOZduOLLkM6wSMO6tLqzEOFr3an?=
 =?us-ascii?Q?2iXLrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DsDaiqply/9EyucLCVP9XGXJ/xl7KLX6RkNbiNbaTIO4SWJTfSxFAvvakpwd7zfhXNrjWnnzaRVddTvtltuAnIQ1Wc2iK9T841GiJr5HAq5o5WbirdSoLhxizdc45McOuYp+xvvcaPwBuVdfj87POTmWDPP8zCJnO08SZfy3itFTw8tLLfKG0pxe9eHDBOrmXlkZhJ/0byHA4UWj5a4p2UJYURHJGh4AV7WMHk3DlZqlcIexDFh4tNOpD5NCELDHbWWPxKmxwLj5GlYjnMKRWqp2wH1gaSXEI3sOGFftoYpxSf64mpZWOEDw2CchFuEoHZFi7s4jUSW6sCqWmCP5Jlg58ZJjI6oRHwz+MjqQLyfQgxAIC5dqaLoCRcg5tQ/Jxv28vzqfliKHXFYn1wNqWoN6/ZQkfLyrOwKwPhaAgMWPY39Rz+GP2w2x82sKWnIC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:20.5471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0250cf5-9ff4-4dc5-ecba-08de6797b4e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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

drop set_driver_table_location

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index c1ce603fcdd1..5260de5344ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1382,7 +1382,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
 	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
 	.mode2_reset = smu_v15_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_common_get_dpm_ultimate_freq,
-- 
2.43.0

