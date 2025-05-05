Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CB4C3ABB0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 13:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C8010E3FD;
	Mon,  5 May 2025 13:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGQsIQ91";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26AB10E3FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 13:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYOrVnfK52oQpm1bvlD4oTJSz3MrQOFkJM4I0F6WLYiyMJ2uSrueMnJRaV/KwjlS+cjpfz5MG/yAUFAfzMmn70EXSc0chtg+xI0bgTMqgJ/Wd0qbNmQuw2bFxk61JxxEhhbir9V0RkWDHA6m9VsTtoOjyhN3/78LFYM1c0NV1m04KnQUA7BLQJTEm5UxYwXEaQcbaBefTjmvLklzKn2jMKTvR9KKyua3fljw92qMCA4qqcKQkGzyfesVhmSgHxmiYISPmH/MA9Rh4QaWaaImdovurltvEjeyZJ9KL6+33xupm4/896Slh1dr7HvUhnuKmv4/gN+8p+kwJOUJr+Qspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT01XiPJ77AODN8FPfHv2CMl/Wtf3HzMHgILyYyjy50=;
 b=CKdShZMwrIRTdO7cthPz/Xy0yWFao9AuX5ZItl1Sanx93nCGTFVQe+vMJkKaqjt8KTUnLK5F0c+Xre3+kNkAyv40d930l2+a1S7FN+2UcGByWjcv927OSJBJJ5n40k5SgbF2bC5V+OSQxbPUo2xso1Jki0ON/vX1QlRctAl/n5qJg2wYfmascBEkkX/Sd7+OLlIeqdmCUQGQLX+Ivttifce7jNQNsFyfa2wlL71rmsCkyMdTpWZtRDFNCcp4fUCSNf12L58pdxymDGg3y1p4PoLnaurh2h70nV/w/zcvyd5tbpw2aWZDux1NsWOoCzFgmlCq0ZVsj3zBpwf7uGQJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT01XiPJ77AODN8FPfHv2CMl/Wtf3HzMHgILyYyjy50=;
 b=eGQsIQ91BV/UNLpcCF21d/xKPHYmALZ+UKWk+iugefgu8QezPiVSAkGfiRhftRn92sjSCFDCkRGF4eeOsjlJgMDitcpkNCIp1LMkUNWgsk+MQV5IXBnYtn/R0XQrxzoBBR+UHHQa4N26MDMC7ZVzs62uAxRQH+3DHxcsRhoNTN4=
Received: from CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:05:18 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::20) by CH2PR18CA0026.outlook.office365.com
 (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Mon,
 5 May 2025 13:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 13:05:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 08:05:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 5/7] drm/amdgpu/hdp6: use memcfg register to post the write
 for HDP flush
Date: Mon, 5 May 2025 09:04:57 -0400
Message-ID: <20250505130459.1985637-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505130459.1985637-1-alexander.deucher@amd.com>
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e334a54-76f5-415c-d2ef-08dd8bd57bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IqVoP2Rhs653xwbDeejuqPwqnux2li5TsrmIrez+7T+KAhQudWNg2pM2A4Il?=
 =?us-ascii?Q?3Yu/q8MTlXhnUd0gidLox5MOpI2KoJJEuh5ds0x1JMGkdCLohdNRc6SrCsHS?=
 =?us-ascii?Q?RD/I5ICA+5ST98J9CM1B8HXSARiwXOrV+lfV2UvfFBiWOLARyiN6ad0jyXRM?=
 =?us-ascii?Q?B524oA3XfMGiiCepaJJFxJd2iko30/e7/UE3Z7uIcXcrScWpmdTEuJIqhKt/?=
 =?us-ascii?Q?kffCb1kvqVM3rhJKBsSQzn5NXhfU7zAsfg7xKDY8yK/SMDHS7ooBqAdGSWL2?=
 =?us-ascii?Q?rdt7mHZiaH5pQX4U6R4motghUd2DGTvBVBh9dZRsbLEcCBF1lgaI5/k0grWj?=
 =?us-ascii?Q?MwQ7WBfQCKgCchhizar9l/wu+nk6Z44YiOUHLgEMbt6lHPVYOKjqAnSkpVUd?=
 =?us-ascii?Q?21cxuKx0mNcvWqBvnXhNAcFyF+qGt+XUE38gQX/tDei1j/xhROS+NXN7X9pr?=
 =?us-ascii?Q?YRjSEXYLLzHlvJljeOEyhSD42ZDnU7tvHpV7KtkQQy2yQOTJOnHqWV2yVw7a?=
 =?us-ascii?Q?59V2Xd5t2kZmc6xwF7IGBQXx39tHV6g1ggeM/J2jQ1RJdI4HIYCHgm53ZJOl?=
 =?us-ascii?Q?MHzChmlovgHZ7IZ6BIUgYpzBFIVZ5V4ouhZkpyz0+Fkysm/RLmDKcEvex6sG?=
 =?us-ascii?Q?VXTZzYMlF3MlHWhoN4LGTf6PhYSIsntz1kt4k7X60j03TINKg/4RGS3QlecO?=
 =?us-ascii?Q?2XJVZsdA+udM7BrT9H5qTYOEG4oedbjhLskLHo93GC0M5YO6x7Ko75nYmjLm?=
 =?us-ascii?Q?yuVO84ePn/l3eQKKe11XKd9o60Dk1Gh3FbCRN3ttnFnbzqhY4tLB0x9zBZX9?=
 =?us-ascii?Q?nsHVZLiytCMfe/5pZLEWHX0BK5eGZIZDaSZMk69xyHgEQxDg74wF5+1qDMPA?=
 =?us-ascii?Q?kU9es9ppMDBjcZw//29LHEKVdvqHHJnUwt3qXPs4Zt5rLwAOAjY2BNWtsph8?=
 =?us-ascii?Q?FKnl3SJpEyisjxDbtklWXNLek9rb2yiQpBbk/yjivopzxiga7wrrnI+CEnbz?=
 =?us-ascii?Q?IsskU6w9OVEYCRzcYRKHGp36SMmtTWPYiLaGuKYlz7EuDF3bl8iuMhvjYoyH?=
 =?us-ascii?Q?fAyKcFi8nefOdwuBmMJvAGCHiJfHTuvuOblKxpQuGqw9h7tLtrvAV9OECcNu?=
 =?us-ascii?Q?ucaEr9b5dx0rs8hykoj/KhcHWuV2NZPh6ll29xd1ujyXf16QCG2wfEQ90xkm?=
 =?us-ascii?Q?bpvzPi1mgEUeAHxjT1e13Ja/ITsnLjy5SHD1uBsOgSqrBrntaRlR+LFWBu0d?=
 =?us-ascii?Q?TshlsgKV5H21fsdg3LhAIPqs941NYlRwmY923hRmqTQXSBc1uzHcWT8B26dC?=
 =?us-ascii?Q?SCSuNKcmf3xV2O6s59l3Igs6W5QTs5VfbTrgj5JarMPrMcd/RWcjIjusqEYQ?=
 =?us-ascii?Q?Y0N9GuyB01FkvqcM+E+LZB4Mm5XvHtjDtAqr6mZ4zt3EwsOceHyEJHHWpcgK?=
 =?us-ascii?Q?rwDKm8rLLqAMjuAOejNgZh7KCuW1XgIkJOUZNSe7FyZ+nQThEf2JUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:05:17.6702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e334a54-76f5-415c-d2ef-08dd8bd57bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: abe1cbaec6cf ("drm/amdgpu/hdp6.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index a88d25a06c29b..6ccd31c8bc692 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -35,7 +35,12 @@ static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
-- 
2.49.0

