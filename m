Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41BFE66886
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 03:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329A210E1CC;
	Mon, 22 Dec 2025 03:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EK65tmd7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB68A10E1CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 03:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj1Rt57NKFfyZivjwPRr/WKhDLsYG7SgUnVL0WGngPgHHP0a8+L4+f7rcCJ7R2hzsTM1XL3bGVvISd+w48p7Hs79d3BmvbKRGIHzKgk7k1GZT1VtA1oMsBuV0nvlYPUzxA+YQBQ73zpyYFFNNAh2PBFpkDriwbHoyDNBu2mJRRyeIVpEivLIjtXwYMAYpktRMe7oIxNwuqlPjNwaIh5Onqyz/PPmbuO14fEuXQslqRUX3q5VkEhnlHxcBruS5FaIWu5EIYHAy0PGDti5vHNk8Zxi2YygLUHAB9de9+LEBe0+aOgZPZEZ1Ni06AEM6oxLf80zpi2Vo/boLL6ZJn/pMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdd5CNbniJZEgqKD4oI9wy7uPvSg67UIb3LRRD9/s9A=;
 b=xyjIeutdzIUG6vkBX9yhMoPKb8rW4r8/Aux0msf2LTNFmlKgnvj+ETxWpJor/uyMhPoWthjSHCjD2rL7CJTjzfqqfvPD7DdeEQV4Y/9Q5pKZBusN2ovPOV+dgozVQmFcTJWP6EAkza77QlsyddUjYck2ob4JoLhC8ggd+1dw0Lofb+7ir3ytQpJyyJa5wlj1nLtGQy2+/bqKLaZcw42kmP7Gmwauqp2+wuTTojSIihtOm9eryKXvcPBLrFUb71t2e1luUE6DqwqeofOFC1uNEjNFzuYFrwh8u0AGECo5/6mPbnjJDz/UsuKAAuevG6BLv8M8h9jG7XOor5QOibN8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdd5CNbniJZEgqKD4oI9wy7uPvSg67UIb3LRRD9/s9A=;
 b=EK65tmd7w0dO/0XgLyOT5U3F4E7pJM1C6doDTTrdSaHdEQccfR6cTygVKgpHTqhiODId4ADVe7l5UviDUs5mBvp1X5Q0erfZXHSnpwX9H3WT7U0m2tNgShfLdwCVAedRnUXdurKFmzn5aJVNNjejnHp0qsqPXkstFgGYEk4/mc8=
Received: from PH7PR10CA0018.namprd10.prod.outlook.com (2603:10b6:510:23d::15)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 03:34:00 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::5d) by PH7PR10CA0018.outlook.office365.com
 (2603:10b6:510:23d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 03:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 03:34:00 +0000
Received: from bingxguo-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Dec 2025 21:33:58 -0600
From: Bingxi Guo <Bingxi.Guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Bingxi Guo
 <Bingxi.Guo@amd.com>
Subject: [PATCH] drm/amdgpu: Add entity's check when alloc sdma jobs
Date: Mon, 22 Dec 2025 11:33:49 +0800
Message-ID: <20251222033349.156700-1-Bingxi.Guo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 902d2f58-cd32-48c1-0903-08de410af224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qz0Gr4Jd1bdTgm4H1J0wKfPckksjuQpnwlKPuK3JKaX05RMTGa62uWA/td6G?=
 =?us-ascii?Q?NNjhZ4fmCD1MfF8UyhHj47YJsPL9Nanc8T+aVhBLKPi5MO0AY3exRWs5raMw?=
 =?us-ascii?Q?E02CSJL3U7lMbbIl2H6p7MrHPHRDhoEB/klHdMN+r6JmbzqEf7IRSgY5zT8J?=
 =?us-ascii?Q?JAHxon0kQ7tcQy9LxSFCuJf00pK7PHs7Ogrdba22yDoSDHOVlWCPcgt47Z3S?=
 =?us-ascii?Q?o2wDio80GFAXfsIMOq9UU3kyUBnbC/3mND1GVf60343b5bA8glbM5jw4fBct?=
 =?us-ascii?Q?JJAhgHfXpztTwbcBXaOe5IJzXfy0AqRHfNax9cFPrDwKgZb5bwlbXqB60HI6?=
 =?us-ascii?Q?4H/s5QAz1en0ikDNnECzow3Vwny9LFn4LUtQ8YtIBBHznAvxAARD3/PBvK0d?=
 =?us-ascii?Q?eQb11LV2/e+jfKywlJgCrsYtQ318DlUeU5pmrTOrYaPhZXgopmiEc9ehZZda?=
 =?us-ascii?Q?Z19S7AtKJaME38rFamBVg/5susgj3LVCbuixmr9MLrxeGXslcD2fpk0VmHl2?=
 =?us-ascii?Q?YRGgJhoUkrno3C5u0HKhHUIz8R3WqP9ROhI1GOIxM0aOhY8DI8aHNHLumfNY?=
 =?us-ascii?Q?tmrk56VO2ortPNhXAONIX3Y/CBxkd0+ycWrIJZlNZ8asfLDlGZs6s7GhjAHf?=
 =?us-ascii?Q?gIU8nZDlVUg6p3T8RXZToRMT7NkW6dJwfEdGnezyEC2aaxaZV1IOjhAgPeNa?=
 =?us-ascii?Q?VhYlCC/Im+GgETqA0xBshxtBUooSJJnSH7Oh8Y3UUqNcJabDg1MFjEA1HHlp?=
 =?us-ascii?Q?T8nnzb0QC3gMLAu6sPpdN+16tAkepJpHC0etTd/bg5A0mUhgRv613Xm83gYC?=
 =?us-ascii?Q?ZpyU6ja4V7WqIptggQ6aD1vbs3Uxy8ElaaSqisBekXTVSU6pkhSzlk58M38s?=
 =?us-ascii?Q?fgs59Hd3q+ZHi/ykoRKXRnbHVmkWM0BcDJmq3/MlAtn24jAHwN5lADXKwvFV?=
 =?us-ascii?Q?Y8BAG+3BeV0W8FKfawY85XimmWkmAIhqgOMfTv7LaTomEukHNKTmwiFuwTB6?=
 =?us-ascii?Q?aAZY5g0S+aQYSDtJHJSf2+2Sv4ENH/ld8MJ4rbMJpwwZgh674FwSZzWArT5P?=
 =?us-ascii?Q?+KUCEZklOYgXs8nNChTi2IcWET/Pn35r19XdQAHMawUBa9IxvB1u9omD3Fqy?=
 =?us-ascii?Q?Rdjwdcib1TtF+Vy+6ofsgLSTRBoYH5OlDUo1kbo2NWSlCljwOZ61wTTJMolL?=
 =?us-ascii?Q?bnQjg9h5vPylWV29L9GbolM18JfGFYweJvmDhEzmZvsNkYszUvlRImmvrVpK?=
 =?us-ascii?Q?SMFQlLslXwZN0nEXPcZHPLtvRJoFwi0bJsBCQb4ZNAb/SoxVOleUz51JQaMg?=
 =?us-ascii?Q?dHDRnvzoe/7NEITqcXXIUS2kVVtjfXc+1psptsbEWeybD/uvWJr3NoG1tiFV?=
 =?us-ascii?Q?FDnSRXy6fanA7tFh6FrklJ31rE1cO3L1l80c6KdAPf/69yhRkTU6dPzke1VJ?=
 =?us-ascii?Q?aWp/ERapPfMMxSJi9lbQKCK4qNr7hBFdpw/Uh7g2Sd/SjuLrXOtqOkTHs6Kp?=
 =?us-ascii?Q?Ak6FxRl9nIpmeYljfqvFKlIbGFX+ffg30gZnAGYcuVjcBSXrDtwC1+AdQ87Z?=
 =?us-ascii?Q?2sZ7JVxl3dYpJmBGZjw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 03:34:00.0494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902d2f58-cd32-48c1-0903-08de410af224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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

issue:When one of multiple processes sharing the same amdgpu device
fd is killed, amdgpu_flush runs but amdgpu_drm_release does not, so the
vm's entitys have been stopped but bos still alive. Later, when the
KFD fd is closed, the driver unmaps BOs from the GPU VM, clears the
freed BO list, and normally submits SDMA jobs plus an
amdgpu_tlb_fence_work to wait on the job's finished fences which will
not be signaled.

add check if entity is NULL or has been stopped, if so, don't submit
sdma jobs and create amdgpu_tlb_fence_work

Signed-off-by: Bingxi Guo <Bingxi.Guo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 36805dcfa159..e57d496a06e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -49,6 +49,13 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
 	unsigned int ndw;
 	int r;
 
+	spin_lock(&entity->lock);
+	if (entity->stopped) {
+		spin_unlock(&entity->lock);
+		return -EINVAL;
+	}
+	spin_unlock(&entity->lock);
+
 	/* estimate how many dw we need */
 	ndw = AMDGPU_VM_SDMA_MIN_NUM_DW;
 	if (p->pages_addr)
-- 
2.43.0

