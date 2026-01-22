Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60504C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096E610E979;
	Thu, 22 Jan 2026 10:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3NGmnLk";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9F510E979
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUbeYDubkzGUBzqW2DPL8srJJ3GGE2FTOqroGhZWsIgAwKf/OI0Ius8/q3XES+FhrVY+en7n+cdvI3s9Y2hxtnxiW+QBjm+3kw7MZlucr5LWkkmwtvJQmYwaB6spkAS/3EL0L8LvEBwFtwVJs8qWf9Vzyko5ciAFLGHtICaT8URvlzF73GYQOZRs3c7Gz3d19WuGshq3NazzbvSYaSCPianrHAMOw7ii1Kl2EXABb3mfpld0KAeAPSVMrbridvjHmBTA16DK/y7Dud30WMmSYNQ/5YJnrArdwob3TfyUxCAgTK8nUSDWxvwA3Q9Ke4my3KSnYHJ6rcoFMaflYM4ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa+Fmf+Gh6ZoPD5h2gEQhQ3f27phVQkoO0rQxRSBRX0=;
 b=qW6N4AJji9Ad81WaCNDTAAAFCp7bRVpy3/UJncgBt36A/CvwyLzfF5ZjMD4sRyTuwpXvI0I/fpLGvpyf1uv99PhmIRghFfRhXwNvz49I/5lRHsuAY1pnnh8U00bWDVEUEZEoq7Ovl1V3mA6Z/Uqfp1Z2MwfkNZQedHJZhK9+ZFZJ21iJv9ECknlp8dnlB//lCPl4nU7ivNN+PIwTx859NyPkbTgeZXy5Fv0F0zhFXDYMr81l1ADGpPO9MSbxzY/80fXrakKKUQoptqBn/LagQ95xIrqe/wtj2IabPuzUZCv1+ezB7WrOlnfXIIXfdXmy+VX0Zz/wVY7uIIGrMXUA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa+Fmf+Gh6ZoPD5h2gEQhQ3f27phVQkoO0rQxRSBRX0=;
 b=v3NGmnLkiv1ydo+lr30Ji8z9E2S9mBGH0rPd5GYgefxM5H/cRmepCtC3+bQXPnIt5T91QMSIjMXDTCOsSFa7BjaxLlwIwUrS7lsM+pUExlZUNpSHX7aSy6k2cqBWqk9q6/ylSufOfE9Rx/+J71NhZVu1aL3B/JutK7iQjzXpjlk=
Received: from DM6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:5:1e0::32)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:42:10 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::c6) by DM6PR08CA0058.outlook.office365.com
 (2603:10b6:5:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:42:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:42:02 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v4 11/11] drm/amdgpu: Add interface to set debug trap flag
Date: Thu, 22 Jan 2026 16:10:00 +0530
Message-ID: <20260122104118.1682154-12-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: df12e941-a58f-4317-49e4-08de59a2e5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?opxKk4C/cL46BdDBGYeY4dA939ap/ZUxNvC2j+PPHywOrz6BRMbRrkoibNAh?=
 =?us-ascii?Q?mgk+9p76O7pGuiQOPHQf/fkn3DYuNgyGfjzCrTvObEeoQtd5mnMckutf5skR?=
 =?us-ascii?Q?vIZFP3UmOQmRKyrPeBeCCEBuDX01U6l630m4KJ7IE6sBCZ+diPd1qyIH4Opi?=
 =?us-ascii?Q?iWWTXXF7a8/6UCUkRlLv5NWq9MwSliVOJn5Yl3Kl4V1MsmhXORhipzPfREtl?=
 =?us-ascii?Q?o5yhAhz2sAYWZydcNT4HguovRnBAiQNI3H6ubzoSteogpKRTfyuveJJRUC+A?=
 =?us-ascii?Q?8c3TTONnSzdAnTJglFZ7f1Lz9YjqXoNlMI8IHmCjrgY8oi9WtpzCJX4uumKD?=
 =?us-ascii?Q?1cvuhTcoRqsVK3OnBbdRFb/LuZTtntDsmVUW5t70NYffqPnqRnfxJz0slISq?=
 =?us-ascii?Q?qGNh2lJyqqrLsqejHcKG5vXqV/89+ypcfWXLOWanxzWvF0FCSIVx9p8rZUQD?=
 =?us-ascii?Q?cWM/lAN/zg2WmA/V5uzK/bBGjSJGIfGr/Dk2dqCHRrrMLfZlLfzzX+AcLYsP?=
 =?us-ascii?Q?yyqaF2lR3ezLYNwQKpYpx1cDQtJID2fPahZnpJzwFSZal4oaZKGoC55bvP8a?=
 =?us-ascii?Q?fbaqemHH89wZ6LycviJkqKOeXIGjn+U5lpbRJdQMyNi10Vh+szPuvCusUtbR?=
 =?us-ascii?Q?3vp2gvimDdbl0c2mCxRx6ld10b6NgA6RvYSVa3wqNnyGxxKyPpFoUer5qLDW?=
 =?us-ascii?Q?V8dEN3uzbfbfLi6kiZk7wMzWOlY+Ildp0v4PQQDQZeqgrdYo19kqgkrv5bTe?=
 =?us-ascii?Q?ppHsTaZlf3WPCv0Ne6hO6M5uC4dQpZ+Bs/wWRUIHHBkUgc0bJGaOthf8vXD4?=
 =?us-ascii?Q?+a4Vw+Mxk944KBsgxjBE3fSVCoXuEc89zmn3geLw/oH4rvE5209DlzIDIiXU?=
 =?us-ascii?Q?yIG3KUBP+NdZbELMCktijcHEMdCliBQPuFIukhmLld70CSEcqQboNJ1AjWLA?=
 =?us-ascii?Q?ka4Xva2lYROf7J9rfic97FfILlOH/MqrCeKFb+BLUMS2aeOawgrhs+90AcHm?=
 =?us-ascii?Q?FMy+W/Mj1sG+qiw1Bz47SU8r7GirMbR0qqRty/pKsDZ+FsXLdp6ZVm31+2uz?=
 =?us-ascii?Q?16Mwg+HpHTVHlTe9pjivG4yVB7Pas6yIAGBSPPqurzmsulsNoyM0PXoB+yl9?=
 =?us-ascii?Q?mAbbpVxjYi+oZjyRAh+DENe13kLPPn8IT9JkHJwGHHOc4CIPC6obk+oxKXMC?=
 =?us-ascii?Q?XOzkxoPfzUKtzwC+n2DY4CDSSYeVWrM+hEc9t/WCgv86Vy4HuRBRLZJEHrhq?=
 =?us-ascii?Q?Tp48cPr57XNAUetKlr8HgRbl/Lo7+R0IanrqpOvDZNHn13FvdH7DpXLINP2g?=
 =?us-ascii?Q?HDFm0bJMNbw9p8T2sGigeKNgEJ0+ZU+3E/9+3u6PQ3ipKJANv/78NmDifa37?=
 =?us-ascii?Q?pCB6wKcosoqMkhF1JI6IkAXj4WQk+sAlzDAH85Ld4BC73eXvG362juzWewlT?=
 =?us-ascii?Q?mpJ/4har1LLqe5JT2H2mI5Ty9S7bZFypyoAqsJ/er6XnrdPrvnsB95KyElnZ?=
 =?us-ascii?Q?OSbBNJxK6stGlGCOgTjli1YBhiR6MilAWoPA0OejCgqPU+mtLqPlHUAiUDbL?=
 =?us-ascii?Q?0SEl/YRNK/Pu/dDlQUCNIVgptEmNGvO3vdSFXXU60JxV/Hi/qk9QqAqU7M7x?=
 =?us-ascii?Q?yPvz1PFCwBCzGrsfbmiUKyAuPkMb4wokkoimHwsbyurrVYKolBDM6dk/HZVx?=
 =?us-ascii?Q?j5aFeA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:42:10.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df12e941-a58f-4317-49e4-08de59a2e5c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
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

Add interface to set debugger trap flag in TMA region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 70f444afece0..663b91c8e6f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -19,7 +19,6 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-
 #include <drm/drm_exec.h>
 
 #include "amdgpu.h"
@@ -614,4 +613,22 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	}
 
 	return r;
+}
+
+int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
+				    bool enabled)
+{
+	uint64_t *l1tma;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	if (!cwsr_obj)
+		return -EINVAL;
+
+	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
+	l1tma[2] = enabled;
+
+	return 0;
 }
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index c9f61e393fde..a32044b07b45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -93,5 +93,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
 
 int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
+int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
+				    bool enabled);
 
 #endif
-- 
2.49.0

