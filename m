Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35F1E77199
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 07:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F7B10E59C;
	Mon,  6 Jan 2025 07:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TQHqMyqP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBBA10E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 07:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JegoPj1ijYzZCXVhKAJG0N3ZplBSvq8waTA5Vdou3d9f7SddKHCL6a7CyONrFF79X6XT8taliyfghBEnjvrkwBTFo7RjxXVLum77CwkYrM22WAEXFHouz2S10XVvR8FOR7hKBWpZjAdPNY24QWKytTfDSV3XjaxxYHqFzmQXBZLIw4gYhKd2Y/3O/kiNERSX9mpMrZnCp2RrhsMEmwGW9RiEq05aqoAvvLh7mUaRdV+7SJosWbQwHs2tiG/dRvwEwuyGfFVTuNW/XnD2Al3Fypc5tVe2QqAnZUabwHwcE7rwlzjI2Cj3HKU8/D8uTAbPWD3Wwp75s/H7ZvExnqjdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk6v+1USnP/aGFfbx+NtRBl286g6TcdtLrzCTPDcFGU=;
 b=PxKhDn0Q1B5pbLzp1Rkm77cXjfkCsqULlvtc1VE7UBWWdP6l9iFmd9Q61WaSa9axqcZe+3aM2RbQEEUxXEAF2Suq56WQ0XORQJDqr6rGyFMqgGZ+Az9lC92Vvdmbt+SUf7kykL80UPqBw0PQxeZBfHEHVLBXnTxVMfJ0efKMgC4JyvcpbBJvkrstty11uf/eXD8LlQN01U/VC/crj29vM6hC3K0J4Znb5je2Y6WHbrh7JxbRlZ1i96+Sr1zX5biV/iRjQJ9R3GsBOGWKitYFDV/PWPET4rLADYccMrLcVNpFnHWSF8NVXc74EMzoDfJbLI7q5Qa3lweU3eTciYnWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk6v+1USnP/aGFfbx+NtRBl286g6TcdtLrzCTPDcFGU=;
 b=TQHqMyqPTD8HuuDiNpadQ8fvZ1uX0CwvTwRUhRls8BcZ6goH3FHTB+aIwMHmf6JDqPls7ffuzUlyeQlxpWqOaJAlwUqdkEVqP5N34aPXqnH3zqJuXkLuJvNDULOM16jmjeT3Xakf9jzmJZ42DEmVJ+oI6m39vsN562M8Bkn2qLY=
Received: from SA1PR02CA0004.namprd02.prod.outlook.com (2603:10b6:806:2cf::8)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 07:17:19 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::45) by SA1PR02CA0004.outlook.office365.com
 (2603:10b6:806:2cf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 07:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 07:17:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 01:17:09 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 6 Jan 2025 01:17:08 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <Jiadong.Zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: enable gfx12 queue reset flag
Date: Mon, 6 Jan 2025 15:17:06 +0800
Message-ID: <20250106071707.2561665-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe0f343-9393-4739-359a-08dd2e22282f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UH/iMQuLLcW6dvQqnv05N7xdusB0DbF5QbbujhF9JpElwTe+y/iBCCiUPbjZ?=
 =?us-ascii?Q?cJ3i9hAa+wUHp7eF39Gw8oGcu/iSSB/5lBoOiEGRbfrHI6ArpPGR7baQWRgB?=
 =?us-ascii?Q?KmMIyk8ZM5/0Xv865e0MmunB1vrrk/ZH/4Cn5ohDp2YbGHNVJDNjpLDnk0lx?=
 =?us-ascii?Q?L4hEx6Z6xMElaWEbQl31IyyOd3mNzVhOIqc8Z8C5OobVmxSHhBUt8R3c98MG?=
 =?us-ascii?Q?CYQ3psl2Efh7Z67tJ0rvvZMklmLzQmY90xHHAxDw26leZDdyF3Mm9k/JBgvs?=
 =?us-ascii?Q?yFQq+xRPAVdlnPSRMsBd74TV+/nr4681b/EYKs1MBxMU+FVOv2HZZKFZSmkG?=
 =?us-ascii?Q?s5W/9UMGVwvMvz934cyn3Pu2Av9DB2YPtD63FjJuH472VsOe5j/9QIldjlqn?=
 =?us-ascii?Q?DOpq9anarDIXPWErcJP+hhh9jErEZT629sbD7oR8hywQPWCEEbYeRQGH1gME?=
 =?us-ascii?Q?B0ydnbhBocqIGDLhCNt8DvqDwWFDXvZGoAesBlBTfBjy2lh7qYqM8eoUB+xp?=
 =?us-ascii?Q?qwq8gXXWHc+5yoFy+wEI0R6neLHl8IR38YhoovDnrgTxsPf6nGt4dtQYbjgI?=
 =?us-ascii?Q?/WMKmyACyGi7c5rMC46MKhuTPPrXSWFDnxqy+LGEtM4rgaz7QQwwCP0bAoFe?=
 =?us-ascii?Q?Wy5Ovd70KXKauR/nnQYkp29cSwJaZ/MzVm0JH2ovO0jWOtv3JUkp+bv4CQP3?=
 =?us-ascii?Q?CCK+dzIqA0469c+MoyMLZv3qu1Fma27LStxnc4QQUYNnd1HrAuzHP9eDrb3K?=
 =?us-ascii?Q?eKNnORi2P+h8fVzfiNaEozEGZPSYyJcp+N22N5R8SG6bd+TNU7es1ETFELth?=
 =?us-ascii?Q?m2TQjLUEyg6CvMFuo4QVBUwciNig/oujIZ0esbxEuprvCdhEsaWrf3BCXpxf?=
 =?us-ascii?Q?Hce/Idki6aU5K2oVdA1OP8yDgFukbF0kT/iAWYunMtsvT4eQ+lrHsXVuHR72?=
 =?us-ascii?Q?9OzssqU9uWpiIvKr7+1jrcimHMEiS/0uVrI/uEg8vClg1xtqa7gwDWpMhjeA?=
 =?us-ascii?Q?jUbI3TIz77yelt33zHRoQL2djq0ET0zq/1lmX3zEDhprOwuS5t8K1cAWB3FO?=
 =?us-ascii?Q?hp1/eXWf8ySvg+41o/UjmAvd1KSkIm257bYPqKy2gF2uuM0UUXVZeOUkylQZ?=
 =?us-ascii?Q?vrxcHaPusSQ1kC18Ocpqgyb6aqWa4gnu96BgSKGqrErwBnjmdnLCherOSVTx?=
 =?us-ascii?Q?yi8WvOp0B/2jU4wBHdKUuMeGd27o+3V0xdqBioffXqL584zwgnbYmDIfL1Vn?=
 =?us-ascii?Q?7pUwW+b28f9hHYPhokgMwCBaTn6XKuN+XhUs8EksgwSv3N3nauCErbrl1UuI?=
 =?us-ascii?Q?tns87FxDBzth2bFoDKP2HMJRvPqRFNsFFuZRR8YYgmBziqsdqFGKfdYAWovQ?=
 =?us-ascii?Q?fefT+/Er06Kn4YJjDoFYwwn4wcrrMR6QcVZUkQg7mjVPsXciaEwpHT3fbZbt?=
 =?us-ascii?Q?pKkfL0W8VnwwOXDhExqdGDt3Ol/ERVs5FVnY8AOtxGET8bPVP7nfaCUlWGk0?=
 =?us-ascii?Q?CK4OtU9PtYRPLS8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 07:17:19.3489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe0f343-9393-4739-359a-08dd2e22282f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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

Enable the kcg and kcq queue reset flag

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3aa34c55554d..69941442f00b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1477,11 +1477,19 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->gfx.gfx_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		if ((adev->gfx.me_fw_version >= 2660) &&
+			    (adev->gfx.mec_fw_version >= 2920)) {
+				adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+				adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		}
+	}
 
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
-- 
2.25.1

