Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0F606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FBXC5jm5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B9D10E6AF;
	Wed, 28 Oct 2026 17:05:16 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F1C10E6B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 17:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzzQfWaHh+n/5kyPN9qX0bnCg5oQ/Ym3HtnmHRFLIHsJImf8o5+PSRqHqyNwPadzCr/35Wh0D90H4nw7lflF4/A6KOh7rsmzHOvbUT6EsarbBZerNf7gFVSyDcRIszkw8Nphy6zIo7wezlzD9HBRSvqcxcFt7eIMqERpjK+dLV2wZZ1EAAJve+RZZDcJ6jI2pEarScLfG/J7KbWHw4smR4+CMNwswYaVWXH2Pl7OfKuV2rHyBoDn8jPVSAPJ75EQAfKdoceNwwJJBRyPfqrfm/sXq/z4aHlZ/jhPdTi2S4sSVnh5qtaP5Sy7NqCQHZCTbsUwprUwAEKlBn3LGYsBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EshHLwDV93+GaE/Qy8OB/jXOPCbRQW/32twbyZU2L2E=;
 b=PAmfL6/Z8CYxjzu/2tfPNlFFMvbKTodO4Eeto8U4lX9cc6z5K96QxWJtT3uF0hc1qR4rIA4o8mMyHlFRZ6YPYGk7S3kA2eqCG7UOKaKWL+QBkDbdfqz+F2WRE+rb8j+zg1W+/ZvxHrSIJN2+RnXLaIv9UwmYTXLUVpRLW/xbzCCYhtkwHqkPpSJgt4TUiXFpGZSFEbwPA8EpISax8fGRFiD9GyovuDcuOR+SGyyK4/zn+JZXBD9LgsU5c+OVvBJ5i22Il7WKfqaVa3+VKJASY3xF32Q7N+YdrjKY/nSkH8wi/i4kxxfDxUV4lzDdzcq0+c8T+IrRluN1HPaOpJiUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EshHLwDV93+GaE/Qy8OB/jXOPCbRQW/32twbyZU2L2E=;
 b=FBXC5jm5Vr9MPlo70P4U6Zvl9ETKECI+MZOL56Od7F6zAGqmEhQ0zu0JTPdoPf3nr9n41LVwyu25rCHN8lKkiRSMY5k6QEXJFxDiAGmZam4njM3rVmHAzkpKOCwOGAOgvDxsGX7SQu+hh4EGys3bF2q2Z5UezOCjZLKoigyyMiY=
Received: from SJ0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:a03:333::24)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:05:07 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::1b) by SJ0PR03CA0109.outlook.office365.com
 (2603:10b6:a03:333::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 17:05:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:05:07 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 28 Oct 2026 12:05:05 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: setup MES DBGEXT per requested pipe
Date: Wed, 28 Oct 2026 13:04:52 -0400
Message-ID: <20261028170452.462912-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 0441f7a2-18d3-46eb-9225-08df35159e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|261026121527099003|11063799006|56012099006|261021121427099003|261022075727099003|261009223027099003|261022105027099003|261021123027099003|10067099003|18002099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: VXnifKFoZH5lDEzVIpCucQRz+HN6Xwg2VD8N10+mpPX2TUIIeSLLhhi50lQpf+Sy9DU4ma9GBWrvmHtjujm9DMx6sMWo+Isz5pBQRkb71ts+sKePfEH7fnXngtppcGCrVpa+O5ZZHEod9k3fMU/f5Z5LKYXmaRFG68+vUUZtJ+432/a416rTRU9ycZpJgXMBaJtOZ2nU0uAKA34GEKls2MJjO//Udb6pZYGvNTEfDUfqnEAsqMvhcZiZw/So16fPlUaGFOF8gRJVILPSp0HWW1mEa2jp/hYN0NOh1V9+e6ZdklBurdNy8WlCo8VkOKxT9bxb9eS7xKkQmdoyM0rtukE9ltINpBNlDXqULLREsVKEJj9gxAUJRYxBTK8NzcNKmYesERiWwJTb33UMXSf76aUECzIgIlk8kTbguXyzI+i3nV8igTnujLZYjZJTA5v2N/S3gnxBY7nt+oNVx+/rtZlIWM6RubsIq3HwdIs9xR4U2Cq6GzqotxWnKR8atsCB5dNoAf9JsBJzS2FsAgYHFb8iZ+xicube/UkNEQp72t26eDVJTcumWfvpVnVu/ZgH9mpepUBgi66YrQqrCVWWudHmL6XVl7LJM+fnKLtb2tmioF2o8617+8gRrFdyFu9z+Ajjh28W7I2P4fAKYr9NHiWMEDKf9Ti0vRLMsALuFdwuIoi1mqxzba+z7Ic7RgE4WGuODqcXJ5faxtyqrRvQGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(261026121527099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261022105027099003)(261021123027099003)(10067099003)(18002099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yo9woeZGW00zReW7s7n1yVhWJ1L6BYWpiRRtLom7HJaTpMdrWDE46KS6Ip5myWzdYegMpR2/PvMiOkJD1mY7mM6AveRxiUvwzEJwIn55mDHP7i3D5Uy9u9+rUvIN11SpiiU8GCKVB50kwz4s9vhOoIUEUc6HSwx6a48jLMfsIO+qVxva6fQpQ5R6fGIZPQ5C3RyUNm6dlzF9aowm6teU9ym/2GpqIMRbmjE25btM+uNxCvvCWLwh2bQw9+DI4HOzQ+l/E6o4YFKLnteTcpf2p6OY0wG4Su8Ed0V5l0delTWqXsQ70vVTXrafR55xJw8rTEY4Knku5CP2iJRAkXViOUwEltXS9aTYNYCrh5mhepPfx9HK4ScrjVho6QE1UFsuvI5cKBX4941Nb6TVQYhTDfEzLY1hdAaDN6mevkSK5o+JRqBr5Bfa/mgUZrl4ZChU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:05:07.2415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0441f7a2-18d3-46eb-9225-08df35159e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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

setup MES DBGEXT per requested pipe, so the firmware
attached the log buffer to both KIQ and scheduler pipe
and reject a pipe id outdise the MES pipe range.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 5e4f929ba6b5c..528fc86b0bcaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -641,6 +641,10 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 			input->change_config.option.limit_single_process;
 		break;
 	case MES_MISC_OP_SETUP_MES_DBGEXT:
+		/* The log buffer attaches to the pipe that receives this packet. */
+		if (input->setup_mes_dbgext.pipe >= AMDGPU_MAX_MES_PIPES)
+			return -EINVAL;
+		pipe = input->setup_mes_dbgext.pipe;
 		misc_pkt.opcode = MESAPI_MISC__SETUP_MES_DBGEXT;
 		misc_pkt.dbgext_init_data.dbg_ext_mc_addr =
 				input->setup_mes_dbgext.log_buffer_mc_addr;
@@ -982,10 +986,10 @@ static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes *mes,
  * hardcodes the TIME_STAMP assertion bit (CP_INT_STAT_DEBUG bit 26).  So
  * TIME_STAMP_INT_ENABLE - not GENERIC1_INT_ENABLE - is the CPC_INT_CNTL bit
  * that lets the CP forward the assertion to the host IH.  CPC_INT_CNTL is
- * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1), matching
- * the Windows/SR-IOV KMD path - setting it only on the scheduler pipe is not
- * sufficient.  Armed on every XCC, since each runs its own MES and logs into
- * its own per-XCC buffer region.
+ * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1)
+ * - setting it only on the scheduler pipe is not sufficient.
+ * Armed on every XCC, since each runs its own MES and each (xcc, pipe) logs into
+ * its own buffer region.
  */
 static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool enable)
 {
-- 
2.43.0

