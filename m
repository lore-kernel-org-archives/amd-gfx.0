Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E781C61CE0
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Feb 2026 05:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0975210E0F4;
	Sat, 21 Feb 2026 05:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BuvSLpHN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF60910E021
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 05:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9X3U+PLUoijSdCSrD3IrbNT1MdLK8fV7JqZaE9112cj5QhcExg1285Aw/QDSQOlGoTUXd0bzCWeEIJAOE/U84zVQSsSCTy6Y/s5F6LmY0OcIEKAssWKzeiwL/+YfdoYVNS4BTq99rX7rAzzJLtXxgVUtgwUMMJmFRu9waPAny6gfqAxeLqCf1gyHJOK0FMrtoM/QhlMwGKsIT+t3u4QP0kGy+1pbdV4GDWcZesDhGtRhKz5rxiVNEOV1xA5svSRsx9OsFDwMDJGfIG95C1Ozj2MAvCsqBGfamxanQUm52U+0eIOv5Uf+x7EJ8fCvpGbkR7fZ2NUH+nB5xDu4OrMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4wzeHlqy6MnDqndmyONhaU4Cm7gkcvs05AttLL8F5k=;
 b=qRv25ERbaNpF4wS5hJeT8NZzD1Xeha7uWFpbDbtzzFtft+MgzmyGXBM30a7nmVO0quek2rRmfS9EQhKoJp2NZtVlQyZRT8JK0+SLWpB7k+UvwUvbJ2QlrPBIZxsDu2tlAvUK0ITpPs+qKYB1hf8SWRJkLKzubLF0m2/mTlEo07NoufZnLjgw9Q+q7VOVNObI0y1GWidZmC4vm1y3Hda23VFfAMUGIlM3NMgbIxvY43sAGGJz2q8v9cAHqvwYPjTqFXtzTvrmRYRDyIXRZel5fDo4J1999SkFyrOJ51wX7jNS/zOYRGjG8V+NDPTTlCbthrtkYTmiSxlgtZkGWq5RMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4wzeHlqy6MnDqndmyONhaU4Cm7gkcvs05AttLL8F5k=;
 b=BuvSLpHNg2UW8KSecS0xylahzC9bbkAxvO2z+gOucKsIQlGptIJ87ZXkW5PylLUC+1N7/E5uVGDxzilzA0Nn2WpSOIlNM/lzrFNFg+wgimPFujljrG0fwvE83TnD9N4u5jFtnvb0UoSYJ03hmDtHONXrVz7vJ/VF5YXrKO8Eock=
Received: from DS2PEPF00004566.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::508) by IA1PR12MB6065.namprd12.prod.outlook.com
 (2603:10b6:208:3ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Sat, 21 Feb
 2026 05:14:54 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1003:0:b) by DS2PEPF00004566.outlook.office365.com
 (2603:10b6:f:fc00::508) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Sat,
 21 Feb 2026 05:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sat, 21 Feb 2026 05:14:53 +0000
Received: from suresh-X570-AORUS-ELITE-WIFI.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 20 Feb 2026 23:14:51 -0600
From: sguttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: sguttula <suresh.guttula@amd.com>
Subject: [PATCH] drm/amdgpu/vcn5: Add SMU dpm interface type
Date: Sat, 21 Feb 2026 10:44:36 +0530
Message-ID: <20260221051436.2176281-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2e2a53-481b-49c0-c15e-08de7108257f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QYw3U3k0q+dfTzn6OdU0bRmZZw+1s/vBK49WGoE3ZQlJgLoKpB9fSfp0SXmY?=
 =?us-ascii?Q?ChpBGuUbwREcplUcIQddJYicuDGSKCqxSz7H1ohPKtbnvVZUXbgHwMrz8idk?=
 =?us-ascii?Q?WtTBSSqKdpAUwk1FcnvMGH3xqDJExgkuqmHv/gX8BB29Oro5vwYjH7OLvA3N?=
 =?us-ascii?Q?b6Wdic/cvkX3T7NxvlWcKkpaUgMmzvk6Vdw8BE8p0CQ7bCqco8aniMp5GpXk?=
 =?us-ascii?Q?G+iBikg6fu1DqdeK6j7+7JA59LFzuyn6sIBvF90sRqf5xjU8zYLeLRapa2Fu?=
 =?us-ascii?Q?cZ6Opti1KtR+8hxe1HyWk54c1LPQS/2E8dG64NsRvXZse8ykFpIbSDHCLUeJ?=
 =?us-ascii?Q?OUIwMfUNlH2hS9Qj045UnK23ELbX6qnfXrklDllxnc+ZUGX+xLASLwxcojCl?=
 =?us-ascii?Q?ZElyuxfVxpM+hjWoRougPhtYS0Rfa2iyqO8edJRDZqdTS02wNXFt2o3hmAw7?=
 =?us-ascii?Q?QuU6CzsqV2K3XbSYUgfmgApf10O5BvgvWnXdouR1jAEZXBsaz9Dox8EG3Npl?=
 =?us-ascii?Q?NtmXYTCYMoHZHFNCKRJwI5EF4OL3tw9g314qWzNV5Zlwx0f9PQ0+7ER3feae?=
 =?us-ascii?Q?2Et1hs5BPR23Vg1qutHAjrefddL3+BsEmQWXc7ESAiIKXTvA+MXzhNBGpfXP?=
 =?us-ascii?Q?EJwdaHyy+LLOzA9selcWuZ+sV0GCvcyH89nqYcUqHgSxRij1rNvw1XGLK8N8?=
 =?us-ascii?Q?nTxV+OcNpolb12MeR5njYx0W4OIqIawXEo8acoep9P1M8f9te4qKxVhPC3Zg?=
 =?us-ascii?Q?X57AIbIxpoMO/JBSO5HQirUAfiqMiZ+CUqhaH4A1Me4cVCrzAQiYvBNy95L9?=
 =?us-ascii?Q?ocD2DYwtOlbaEG7YF2uX7+10qDIjmTsBse1KbUWOcUDq2m0ZPMXkflCXNhtj?=
 =?us-ascii?Q?vJKqGLV9eUl+qZVGeJX5FkB6flqZ6p63dkoDmbc3x5E9J3FHmMqlMvJDo/qs?=
 =?us-ascii?Q?9wGqi9/5YIETBnKqe8yF2vfPwMUDVzCpc0r+syYEVK3pCB7OB/Zsx3snFTuJ?=
 =?us-ascii?Q?SDzRUUVmvmxEkQ5NUjld/a+u4gnUaSpzJSes1zUGzvMcFubwtMe1qBSssEdm?=
 =?us-ascii?Q?pFC2kQR0pXdm53Ros84CETApPuOiFXjdOzA3TnELRK/CeIDN+Av0eQ0RLQ5k?=
 =?us-ascii?Q?fvyG98sQZFv8k/2m4HfKwE2YaGF2kM77QOeMNPZzHpMsgocAxZzaSr0iuAsd?=
 =?us-ascii?Q?VWcilkfFk638Xbe6InVU5YojL4bA+6zuoUGW5CzckkBXhkMOz4kS5+opmpBl?=
 =?us-ascii?Q?tAwjaXmMLV2pdXj0UcN/GAirxz29/8QBke6UAJhINBy5tnFFLxY4VdhFG/UC?=
 =?us-ascii?Q?6UNAtqCEmh+ACJD7/LZGouL0IWwSbDSUlnFsoWVRsSYM2fzneTPM8ClpsotT?=
 =?us-ascii?Q?PIs44yLYfPEpaur4709JiML1xokbcR7FnKZn/F63Sg52Z1UVDEWJGGeV7Nq+?=
 =?us-ascii?Q?idC2sgx+d8AvFSXDNcTN2Nt9xNtO228qbktUG0kOiJlkrnL74uQ2M+iCJklc?=
 =?us-ascii?Q?EwR7+gyfO8UBQ2lhvZzbRymlh6OVNrqG2Z+Hq5+iPrkQZ8roDLP2xCjvHhMf?=
 =?us-ascii?Q?0uA8rQuap/Wljhzg3oe8+5PS/ZxOELDoiwSUimaYysWYHDoOt0gHKyZ4JMA5?=
 =?us-ascii?Q?zPO0yVSFbLeRx8FEyPtD4E1AyUs+Zt8U/xlsxtUEqfyAyhi7TevrMjIOVJ5i?=
 =?us-ascii?Q?2gMeN3/jXtTc8VpIG53jn9hEfpA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9YoLxwpNX0COTCFi1KqdAvvyN61h1Ykw3ZR0OEVMHBO8BxGJ3Of3lUgIC5AyjFiKyiFHYvJ7GCX6Vb4LDNTQ1d2S4nrcChkc1lR3sVS0P16rCUI1mNu7aakt0UsgryulV8zhWNVM1d4nr7YAk7lMAb+57wOU0PpR4gasd9yQxrKWmDxoXTC4wJj8facCdBnhvSI9E3kIqK0Xo28RZe41Gy2LkY30Y5CHVTXwJlxX0rbLdESMcD9qvdjmagtCdgYOL7KZVB+MR0IY7ji9UB4GuxWtokgWjOpZedpQQxpyozVE5OMSyKxH750iEzdsl9Sb/In6BnAZb85gKhhzS1R5+D+M4nIAd7W5zGvURl+up5tgeVdurWGh/KhIs1Iw3bHDXZIUcUdeBYxkTqO6+sHOTMx9M3X1KeYGmtNUGvcJLJGwELM8kDrgAf/QolLKadiA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 05:14:53.5202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2e2a53-481b-49c0-c15e-08de7108257f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065
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

This will set AMDGPU_VCN_SMU_DPM_INTERFACE_* smu_type
based on soc type and fixing ring timeout issue seen
for DPM enabled case.

Signed-off-by: sguttula <suresh.guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 0202df5db1e1..6109124f852e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -174,6 +174,10 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
 		fw_shared->sq.is_enabled = 1;
 
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG);
+		fw_shared->smu_dpm_interface.smu_interface_type = (adev->flags & AMD_IS_APU) ?
+			AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;
+
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 
-- 
2.43.0

