Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02639606A338
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aO8KcqKf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638DF10F778;
	Tue, 17 Nov 2026 14:17:35 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7EE10F76D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3OWkJLjXNA59daBaQDlgAyvaaxj1zaVnowgqjaDkKOnR93v+Bn6jNGTThNxteYgbR0ntYvjoZ/rlmepA/+ZelcbGgVljajd9g1Jrtt4WeWuJG/kuivtOEd10gfW/r2+x9/rk1v+ZPgz1SQT/kYVouAZaOzUMPSRiGZhfpoDlp151fIrTU5fEIB3glXnkJr2CSyY+zKPKCMrRJlkLmgOmoA3PW1NCn/6X7PlsCZwCJTz8+sOBT9uAnYKwt1H1G2WaQeQHJdhWOJqJvbW7ZHP3kkVMf8LQZpxdeq55HIa67hLIid3Ygmj5iOiDnpTdgszLtiySjhUH7bHLbLJEbb4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fsv5RT8aSzBjaugSmZdOyD8bJqORArWFaKjjLPJE/zc=;
 b=SWeDgpaP0kMIId3Je5eXJsTqIUke8xlp5inZYf0bY80fcqihwJOrWR9MhXbIK1va1XZM1NX+FC7MguwN22kGOcqiOspTLhT2QgZI7HyGcpo1A3SWfjHKZnL/6a5Esdsd8M0RLNDpovfI35C+ndFTAXX+Vvrw0/FKmYWPXzR+rg7FvgsRvhXkgyVuIgQK9urfP0muApeVSgZuTKEQ/1EVxBFSop6PuJqoL0H426t9gSET+JBalgvJYU8YjeO4e+48SxSvib6CQjBDIQJql2KJ0Q6pdRI0RRNFEf5fwZO/ShODAi8Mzflw/OuisN+5S5Rs+nh7ljvtWZAdZ1uMTvq4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fsv5RT8aSzBjaugSmZdOyD8bJqORArWFaKjjLPJE/zc=;
 b=aO8KcqKfQl/2hGXjOr74Le79z9owUh/a+6mlUKzmv3zQfwHMyjZm7Y3pCtcaRRH7HeRlmaSB+JwpiSN1lYK9B0IEqe5vdJ2Sv6IrPpJlNfE14NkLpQk3IAiv3FIZsbUOTKEwev73x+gG5Egu8HTxFpMrnXWd5Xi3Dk0LGZOIGFc=
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by BN7PPFD6BF22047.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:17:23 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::5a) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 14:17:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 14:17:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 08:17:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>,
 "James Zhu" <james.zhu@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie
 Vock <natalie.vock@gmx.de>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
Date: Tue, 17 Nov 2026 19:46:48 +0530
Message-ID: <20261117141649.1658444-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117141649.1658444-1-srinivasan.shanmugam@amd.com>
References: <20261117141649.1658444-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|BN7PPFD6BF22047:EE_
X-MS-Office365-Filtering-Correlation-Id: b5089547-dc73-4b85-df97-08df44b57e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|6133799003|22082099003|261009223027099003|3023799007|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: O/yMg6cOP07mIHUp9ahz5EUXkspjckzDQ64dMc3nQdY+CQaTnvUjBDavI+YJcxxiJqFydtKdeyNXkddOS35oH5XnWhUOLC6yTLaY+xbKl1IP9s0sNgV+2XF9KOwV2/123oisTKm/rkoZt8ZL5gElWwL6jHo5iicOWY8KmYuTDtNCHb3r2aGirGfK5bl6Fa69eR78KdQjmJZcMDSpsidIbCB3tMuCCVNLZwH9/IDjMgSewCy4OA9EqY39FPZH+4nsX62raETc+nfRoolURnyXql2UwT60tx/fNsi40fNr8q4CIx7sLlV4AojeS7ffpkYVr/iTiixDvhzlv6gXcwGqlM2Td7py1rMpWOS5wDSHYlFL+J9wC4Hzo/3tnkrSVwwMKdv1SR0DzqQ7XWmQUybXBuj1KgNxGGKVdqjDmlTgpSdhTxhVGW6FE+VqOvj+gb/drs/EAPsHtBJwkiehrlYBCiY/KPB5G/lpusoK0juToBdyXqXyUMVMhFwlcO1Uzdo3/8MIoNrr7Kjp9drrYVRMIHCGo2Ed6E329hGiLVf1z8U0TOUoygExjWEXFXQfP3r7xXqXNCOuIvaTHTznL+WInImfSpUUmTRYdjn+o4SLDBcopkK9YVUXXMcp1cpE8QSNz5adUgv+TrVE1Z4FK+WsT8mpV4BSiZCU0yfRnaBEaFyRUoSS+X4nV7poQOFfBNYzHrGCAd/zDOjbCBHozP982A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CuEfiTGehL+gymGCl4/91P0t7P4ASWN8WXy0lDVTY6IqXVGM4Sc5q2ebc69N/fIm+e59vP4XB/nqw66znmybnnAsEeml2nZ66MtgPsZ+sKWVofsb90hGSjnbgpAQLgRb487/12P9sVcbfnOjLAtf1tuGpbyogJP70xSwR6TvQQiDltTI1fP5C7k3GMBLkeV/P35dftEcifJsn3gTc6NKqqGI09kl1Zi+ponP5vGXs5Jl9JC1KGYuGZKvRxp/aJRvZF1iHpviM8SuLbvRpYEfBm2BcKmYQvZqRlppWd6fHMgO1MOgi7jDAeFSGtlIIrdXvP4INnyJaC8zr1olPk0LGFPQ1mc6BjgcftWFizJzG4XGcn+JbSLBd80k9+FAqLbnUjb8c5RUytMKXsw7KErz5xmIBumozBRkage0gz6ApY1JCUboarWJXMUU2rYYhoYp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:17:21.1876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5089547-dc73-4b85-df97-08df44b57e91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD6BF22047
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

User queues get their first-level TBA and TMA from MES/KIQ when the
queue is created. Kernel-managed VMIDs do not use this path, so program
their trap registers from the gfxhub setup path.

Get the reserved first-level TBA and TMA virtual addresses and program
them for kernel-managed VMIDs. User-queue VMIDs continue to receive
their trap state through the existing MES/KIQ programming path.

The trap registers use the SRBM selector, so keep the programming under
srbm_mutex and restore the VMID selector after the registers are
updated.

Trap enablement differs across GPU generations. On GFX9, enable traps
for user-queue VMIDs through the debug trap configuration and program
kernel-managed VMIDs through the gfxhub path. On GFX9.4.3, enable the
per-VMID trap control on each XCC. On generations where trap enable is
encoded in SQ_SHADER_TBA_HI, program TRAP_EN together with the TBA
address.

Mask the TBA and TMA address fields before writing the registers. Keep
TRAP_EN disabled on the affected GFX11 ASICs to preserve the existing
trap workaround.

On multi-XCC hardware, program the requested XCCs and restore the VMID
selector on each XCC afterwards.

Keep the first-level trap VA layout inside amdgpu_trap. The gfxhub code
only needs the final TBA and TMA addresses.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index cb3e5f26ee23..8eec379bfb3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -63,7 +63,14 @@ static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
 	return addr;
 }
 
-static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
+void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
+			     u64 *tba_addr, u64 *tma_addr)
+{
+	*tba_addr = amdgpu_trap_tba_vaddr(adev);
+	*tma_addr = *tba_addr + AMDGPU_TRAP_TMA_OFFSET;
+}
+
+bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
 {
 	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 
-- 
2.34.1

