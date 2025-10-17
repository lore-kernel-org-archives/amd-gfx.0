Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC13CCD19A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEA410EB6F;
	Fri, 17 Oct 2025 08:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BAmII+SO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CCC10EB70
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikGxtI4ehmxpAhuw1ys0V1LaUiqxAiloe1BWiyFN6cMgr26e0r9C6OLEOFLYOn5eumeFrpbFGhm7XDkcX8veq1s5PgSZ+EXWMARi24Uxo8VxObeKyqZsoKa0qtrQp/+uiPWWomwgiOllRcRXvqtNSKe+Ow9fhC7/YEigri3Wyy3uVzPX0WVwnLkKTn8bjLukXhWWR2cj20E/Vj/E7/vbp8N/PY14a/axBUTZ6+l5o3ugjXW8qm+LJtjXeucXjPsnWyiQgTWwSa1rvR9JFpvQaWkMV5ksKbq1cMZpc4OzwEkD08c6Kqx2cexcQ6lLuu+F/+4Inj5C7wWorR/eiaf5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1ISGOS8oXxwzviVceg+Pz/vSINlpBSpsopstXN4s2M=;
 b=UZtt1sxiVnN6FCDd/WJNPiy1vdUWb0VHMj2w5vTw1G50dpx78ZMtJ27dBGE4WuNj4I1bugoNM6ZhulxNy5OwlBlOzQGWpUi1gm0L61ebSEITYZGiBW8YjeaPUVbNai6dj5ghyHxt0iZpQUEuBwk3wM3K1xo5BGpQ4DuCKzTEZpW2Fern4QBEcL3Yud33vc2F0A15xi4iEb77Pr9Ore4pMJbhim+Zh01bR2G2PuWIELhtBoZjiCu/8zlyHvZnUExDPAFf9jSKCW33ZAii3Bne9/5gTAyIlTx7YnnkrQpt7OjNtCXh/8JMzyy/K6laF8RYfX+DNocsSy9ns464TyU31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1ISGOS8oXxwzviVceg+Pz/vSINlpBSpsopstXN4s2M=;
 b=BAmII+SOPZPGGs4GN102qmFdPwrhAUUrSj6NsTlK+MI93Ybx5UaWLOFavjZmCzNQE4vX6w5F/atiPbSM0If+6pkbkUQH1Yyorcy07xPSm8+23iHofByDu9fVsjku0CbUZwGxqBOKQcHMa9zCxJaOuMWkPxB+B87UuehgiBZwXJ8=
Received: from DM6PR07CA0080.namprd07.prod.outlook.com (2603:10b6:5:337::13)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:43:34 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::a6) by DM6PR07CA0080.outlook.office365.com
 (2603:10b6:5:337::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 08:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:33 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:30 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 14/18] amdkfd: record kfd context id into kfd process_info
Date: Fri, 17 Oct 2025 16:42:18 +0800
Message-ID: <20251017084222.54721-15-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: c9820a1e-a0cb-4bac-e322-08de0d5941bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cHqxFJY3AN1XRFxGf0Sn8tK48sPqaplSAOVtRyfQvHe4idQryn/PtyrTtOuu?=
 =?us-ascii?Q?OVLCBkcHu3xEI47RjTW1fwaL04+gPB/sRbAMMFOrVupSIN2VVDH915kgZyG6?=
 =?us-ascii?Q?lU4Q5KSFRfD8SZoNCLUT1rUcgxYRKi8uwODl1CHaJZ8JB2aEG2l8gJ+4KgVh?=
 =?us-ascii?Q?PEJmlPMYt3wi/gfDmoXDt+BEK7fccGW5A9bFW8+X7qGpUbQBc90fAyvxHLm7?=
 =?us-ascii?Q?AVKH3MR1zUmhZT/PeVTGlXiLstVNgb7dHGkgSqjDniokOOY2NCT2djzR9Hp0?=
 =?us-ascii?Q?NannbfdTfNqvbsMV87zSCAJG3SCwgfsATDSdcq+qEMqG0kiMNVOpEphKNl2n?=
 =?us-ascii?Q?YVRFNYu2yp7s425wybsZ0kRrSvFrXEzil92GJWIr+DUo5hm1jxs79XChrM2S?=
 =?us-ascii?Q?TA6a+5JOyd7zpRUZc4D4AlopDdkVDX3rkeqCiqIgXgigAEbMridQndgk/Ahm?=
 =?us-ascii?Q?vS/hJ7gq2aJFKS8tw7Z7RFKrWA8YplpRQtZrquXgal00lQPtfXrNv88MylMh?=
 =?us-ascii?Q?FmzD3BSsz4I9l2iqpw/wVQuqzskDMTTLo2kras5ekDFTDbrXuEHo7JsW7HxS?=
 =?us-ascii?Q?N03OvIEBgaCaOyz6aNH650NWlhpdhEbtKnqDX12unzEB5y1fiHdSKG/3uCQ/?=
 =?us-ascii?Q?mwIJgZFB/lPiFHXcqgFVuTAXtk4XRyIYTW6WWqXQZAyHnmj1KJBVCtQWal2G?=
 =?us-ascii?Q?uyxJl2Sy4RGmxb/4CJm7X1Q/Nsp+eHIsZmJBJhDhIonZjCzqG3nsLhxRDA4B?=
 =?us-ascii?Q?jSG2UCCi5vvXfTF1VjvUQco4dOlvg337ERaWOMBcePAog4G2DYco09H74ZtY?=
 =?us-ascii?Q?u9dZcCayD3uI0TXyz3j3npl14gZYvI6QOsD1g0p+JZNmeOOM/5ClFi+NFyR2?=
 =?us-ascii?Q?Eah/ZwnIe7FIqgFwUWet/L0NakoeD079PEZFeRU4dMW4u/g+zKEg1wSgZATo?=
 =?us-ascii?Q?YQMp6sSugPZ59ftGbmCC5RJWIOUu6LBQ6kUMOrMpo52m9JisFuu6fhqlC/Gw?=
 =?us-ascii?Q?RyPJ0sXKmhJsvqs2MRpeH3pe/ukTzdfYST6Nftz/sGq/5XckXuYfCUZTOiX9?=
 =?us-ascii?Q?HwZ1Nl9Wao/HPqJJ5DFdBtMw2vpj2ma2zyvOofRanpezSNmdxajgDI0CJnTI?=
 =?us-ascii?Q?YmRW8+ujS3R1DWsUtc/Zu5l6kZN4dkkMqcx3tIeii0sl38wxHPE1oVoonJ8X?=
 =?us-ascii?Q?PomrFEaenarTUHEiC7GQIDyAfBc7Bsf0Q2Geec0lJLHuWpv6d2lLiBpNqjxU?=
 =?us-ascii?Q?EGEcy+3wRHJDSZ8T0iCFkwYOfHT65QypkzAodM7B2e2fJaE4pMXLDu1lMSuC?=
 =?us-ascii?Q?E4QYugg6DJ3iDBY8HVXMC6vSNelG9oh8vDRtSwX9J8733+ppY33Fvq5uG8Gd?=
 =?us-ascii?Q?4XzlBXvv+QGAX27uUJDPxAcNsDnCd70oHD9NW0k/PT6IrOPyTiK5BaIwIYUs?=
 =?us-ascii?Q?bxPBl29KAUFbdGLXIKKqKy/cbk8H6HwNEiv+eTIDK/dzYcdQ5rTBXmbNfYTZ?=
 =?us-ascii?Q?GueRIY39zmy8P5Z/AN5oW7n2J8fVMaCmey0YOPbYfhjBKbHaH8TgIIETUJu9?=
 =?us-ascii?Q?UiA8Ag3z/wsCpW3OtwI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:33.8807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9820a1e-a0cb-4bac-e322-08de0d5941bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198
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

This commit records the context id of the owner
kfd_process into a kfd process_info when
create it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 9e120c934cc1..28b54d7ee1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -148,6 +148,8 @@ struct amdkfd_process_info {
 	/* MMU-notifier related fields */
 	struct mutex notifier_lock;
 	uint32_t evicted_bos;
+	/* kfd context id */
+	u16 context_id;
 	struct delayed_work restore_userptr_work;
 	struct pid *pid;
 	bool block_mmu_notifications;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 83020963dfde..0e40cdd8c5ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1386,8 +1386,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		       struct dma_fence **ef)
 {
 	struct amdkfd_process_info *info = NULL;
+	struct kfd_process *process = NULL;
 	int ret;
 
+	process = container_of(process_info, struct kfd_process, kgd_process_info);
 	if (!*process_info) {
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
@@ -1414,6 +1416,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		INIT_DELAYED_WORK(&info->restore_userptr_work,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
+		info->context_id = process->context_id;
+
 		*process_info = info;
 	}
 
-- 
2.51.0

