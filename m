Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DDDD49C80
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED7310E984;
	Fri, 30 Jan 2026 08:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qcKw/MzM";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE5C10E97D
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBbctKRmtbrQqn2Cgls0QmczFJrxjCQnGUsZWlvwYYMMBoNV3ULO4vffcEASJmgulkOLYw2SnN7ZMc1t4ME1Iso5VVOeI7kmtYnVVLHDC1nd6OxAUKkWx6gx05xVcfaCkbxnwAcjxmopL+5QiYfYky3InTJe0n/hlBBTnqP2gc74eIGBwapNCBKDpaHmzo9BlhE/K176mxqVV+X8WfcK6RW1Z7FKKAoISEjwWqodmENyeFHgj4/wGkrNsrhRatOls3IcQPcOdKq32Kl2kXluQWCQI8mKKAFlbdnXW2s6cykKgS15rD+8DQZ/veqzAjI6EcrGrz5dk3r5FDGqVLBZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMeaibm63bor2+K5Oto0g0vSR7Cxs/gRsw4w/Asd1ZI=;
 b=uYnlfQAskSfTpSqd37HT5ettHv5VBFsuFmF1h5dn2sjbz8BfZYXtQdqSPaF418YfLsoHKr+FlxsjL+MxCIep35lawJhydr7Vtg0mEkIRH5R2QF7anoNXkNtO9er4qtQ7hf1jHDQq+aM11ra7ehYRuoOjXmY0L3vTOPHkLqvg54RXYtSPilntoIJ0t81yiAUu4/ZyIgh9sEKQ2Kk1AMYzdtGHaaYySl4SjZbUj5iWaLsvFoknnt86GcgmlCuOmU5cpNOf8SineCHa8ZHGSaBKMCqQQd6Xu6+k3k1YP/cC7sB5/qCe5tuB0EkA7U5ZwvjkYxJ2VUzrBKXZNmKlfldu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMeaibm63bor2+K5Oto0g0vSR7Cxs/gRsw4w/Asd1ZI=;
 b=qcKw/MzMGqJotl8if2hpl8+PAzAvaZVxLlbpgprIMCGlZ1lODR4Pal9a4rq/XYcanhajbVus3iOWO8b7omapfoNurdiexU3h1AK5ooP8BPBV6x1Nh4fyT3uIu9O/cIEWns53yLrWGuDrAKyWR565JFuzbFZMqAxX89Zlj3VCfIo=
Received: from BY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:a03:1b8::15)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 08:42:33 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::8c) by BY5PR17CA0002.outlook.office365.com
 (2603:10b6:a03:1b8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:30 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v5 11/11] drm/amdgpu: Add interface to set debug trap flag
Date: Fri, 30 Jan 2026 14:08:05 +0530
Message-ID: <20260130084137.2906792-12-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 857af785-4af3-4e2c-512c-08de5fdb8339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LYfTD3UWCQqKD7VaNxK7rZO9zxhM7W6f+R4Z4blvIElIZe7KBAb8FjAOkIHb?=
 =?us-ascii?Q?OGHCoj51fvbkumktpWzSoZchXlWqx96iFiP77vDOX/X9rtTArkToaUNR3FzX?=
 =?us-ascii?Q?uozB3xUzOQ9BeHu2bb2itUBr31NU91OhcIz6Xs14ffkbOM1QsnOu4TZ3Xh60?=
 =?us-ascii?Q?Y3+C501nQvks0z1MCux9iNUebEEYpsOWQXGQVoUfAJFTCoK98fnquj8G2RhS?=
 =?us-ascii?Q?MIeaID3szoOHQX1Y1c8PWkUB9LQeCJyhYqPZPPBNzTeQPIKZYr0CAcMjF8vy?=
 =?us-ascii?Q?jrT/Pzwo+JR7n5bhnLTyuqcBDKGpAiYGKuKdEg4bVE9W7Hm2advZhf9oYFm1?=
 =?us-ascii?Q?mZhGNC+ARxseBedxR6oVTQFG1oyM32+1AJxaDRGPYr+xLdVqSmG+NcvApbQs?=
 =?us-ascii?Q?m6zDxG2D6GRecoZhcQa9DtG+V86uMhFaTdz61/pJ4LTr8Z82Fn2kUSKuFOY6?=
 =?us-ascii?Q?x+5CUyyY6yV1CPcA28CyZMH9sNP/VnkuU19SuMH2f9WxdyHULz5rjVauJIqn?=
 =?us-ascii?Q?/I/nlod473FCsZ53tpLD017DvWo/p3c50tWcBDFpbRXh/u4v2m/dEDA5JQRD?=
 =?us-ascii?Q?rA3/lmD+DR3GCg80QQ9QLx0gcTZu7z3Wd5PJw7PuTD/Ywm6nG8lR9+Nk0Wo6?=
 =?us-ascii?Q?Srd7FT0U/Oeco3c5XKsdPmIrAD6cBYXjetPW6CfWvjTSmDnP6kxz+M+wlGCJ?=
 =?us-ascii?Q?kNwsx1gPHVevRkS0EgVLQ2vLUO0gvVruizrJYDFER5bxSw7sxZUcwjsa9Zbm?=
 =?us-ascii?Q?4Uhm4Q9EZfpi+MJxpgSRrBlTriDWmOZpbavaBgVPwsPLZueL1Iq9GueJF9Qn?=
 =?us-ascii?Q?yrxrZVBS2QZTdAdMcjyLwNkSU+SNADWiOb0zfkb64qK7VnH2c9Zg0vvCTe2L?=
 =?us-ascii?Q?8MxLNjMddr9wlA2zx2qJaGAVPrrav9Ktp83yvAMB/lf4atol1XSQvec9GicX?=
 =?us-ascii?Q?gaFm1X+RVdcfhesdNAn+9cMNuqHFMBP0ShuFEWuBcKWtW83IEAwVIvpmqatx?=
 =?us-ascii?Q?ODxnEMXN/o6+9CHm4rBn6OK6YW35AggYa0KHJXH8eMHPyY21rwGNzYhUBpQf?=
 =?us-ascii?Q?0aTWYgaQtHXWbtKvnlw8SIctSX4q2UzX1sz/QxGnHzGzk/PZu4WsI9x/Vt9R?=
 =?us-ascii?Q?Cm7gBvNZ90+9LXuDLrvbzUjVS8Owjya3RMbSIgTH63oRC88H/sesAxIWzOZW?=
 =?us-ascii?Q?/c46WEgDxvPPrEsAGverjCiKp4z6lG+fLSaltNmlGfFB1Wx329+GcNkvCmZe?=
 =?us-ascii?Q?hrdaGoPw8e1+lyb1790EXPFegsBmUths7jI7+C+8QTg9KuKTYItYfz8kNPOh?=
 =?us-ascii?Q?sPExaCyUXEmDsN2I3jeXY3c6HAtxvaFJeVmNCSsO4fo1bnQl4eTVdB+ZEHKT?=
 =?us-ascii?Q?bUbFzhUTPHC2/m+u2EVCaHoeLV1/OX2NrQJWonUMg7RtdM+giqxX0OnWOCT2?=
 =?us-ascii?Q?PCw+GP83v/tVkbFkmw3zICNVYHF0SWBwkukWYExeUJF+YHFbSqCwDJot4Aq4?=
 =?us-ascii?Q?CvKjg3xA4UCfOZOcZjJAf5EOUA/YDgWsDoMcwgr7p1u6q5juFtD5qCncsbps?=
 =?us-ascii?Q?8e/uwO56iaA1XDSCk3g8p77OUsDh4SchnyaDnB6nkwOodK1fHOp3487B2P/j?=
 =?us-ascii?Q?7ZiKh2V4y/5PSVNzhTLsw3pSbLG42QUgOWcitaYxkSk7Z3ro1VgPTZJBOyvi?=
 =?us-ascii?Q?le1xtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n7RiKQmylteXC7/0+MChknBXu5cTZ3w90Kydx13ETdzlZRcxu4qvASjXORxFIXJvc/NkNo14hQP5FoRpZPNJERwPw2datWO+M+DRUUWStCQgrcg1HYvL24Rwlw/cpteGIGaEIQEFC0CMg5LHShR4ClqjSfRjJzhRyGlJXYEIzh1jSpDn990shvIKmYddFpveC+QJBWn3GgjKg85IxwSnzY3mxSvtoYG3Yf1ADcGa1O6ZWEnwtyUdUmI+SWPKgCUz5TKph5tQccejriJw7lkHJTpi3noQ5GiGg+9ybzLFfwCmVmmyqdK/3Uh7oinZnxkMEsxbnw6GddnZ1a5Wm3xQjZATKNMFl6cWGhTE6hKHoYCdq05V1/ReDukKKwL1zAyTU1g8V3dBWLbNHe5FnUdCUA+z0PkCZE6v5Q2HsYZc2KgV0xmdMdR63udKuK9LoBoc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:33.5892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857af785-4af3-4e2c-512c-08de5fdb8339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
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
index 50bafb84a912..7e5a08b0a1c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -19,7 +19,6 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-
 #include <drm/drm_exec.h>
 
 #include "amdgpu.h"
@@ -609,4 +608,22 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
index 2cf485111e8f..06036954627e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -92,5 +92,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
 
 int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
+int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
+				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
+				    bool enabled);
 
 #endif
-- 
2.49.0

