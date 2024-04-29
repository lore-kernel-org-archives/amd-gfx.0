Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4509BC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FA810FF1F;
	Mon, 29 Apr 2024 14:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cq+NUhSi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED33710FF08
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3P6BsWvSyypT1ITF1nJ9r4lY4/uHZxc79QM4liuIpPijyPyRBPKwW5xsz2QU6DXPaIHkJCPvDWsxK89XzQ9RL0A18cjNfTYHu4L6wF1NLA3lKZLza0397q0zgixjzf6aPS2dxzJbiqYdL7dPXxVLkBaWGOr8oDYTSUMIehdEsRBPCw4xa4Pjs8neW6rVQ4JB69mWUYEMCH6JGeoVajvYlBXv7hRISegQ3YthlvHHsPXWnfA8RhnO/Ry0R5tgKBpWZ3UgeILxBNsBB+qYs+4mS4Yj7KM6KxCvP/wOiFwaxpRqHmJjMSgy9swbLe0D+TtZ9JQ03pHbRniZ4mUM8p0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2/gp4DIlaiJvGkdr3nYq5+gDfETgwQILna2iZj1bys=;
 b=Df8Q0PPMjyBzy46HytgYyENbpPVDcYP7alWpx4cCzS4noXl70PE/kLApbg3UKvE1wSj1t/0NtXrB5xU37vwiOBqBwcZtwUYhT4Cj/1JJqZ/ag3jnSPisfuLsxn0sIfnRO+dx58ww9aq15QK0JXQMykIIhuRvdbAQo6nEdYC/o4Bkfq8GsU0WdL6fuWGsHPA2aYaihSZpF2OB8IwlDhWhi+ffXLtbhSZtkC9xgrmb2guN1tIbet521NEtSyUqScxYiXKFfY29M/blTqyW33d9x0NLe3rEFm2RX4fv9JfVDGp5XME1I2uzLp1+/kgz7hxhpr3pHoyiaziQHPjN5ziTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2/gp4DIlaiJvGkdr3nYq5+gDfETgwQILna2iZj1bys=;
 b=Cq+NUhSirTC5eO28tEnytUJTZWbbB/5np8j4tal9jdaUyuSWjqIcXPpOq/s2wxT396YgIYvcahcZ3GJJLhlRWcvIm1I94BHc2+dXIUEBtxARPsnDANOdKnntFWjLAZaVcmpF4u6pToEIOLvWEyDu8Gzbf8D7n/0nJiTIKcExQy8=
Received: from BY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:180::33)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:57:51 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::9a) by BY5PR13CA0020.outlook.office365.com
 (2603:10b6:a03:180::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lancelot SIX <lancelot.six@amd.com>, Jay Cornwall <jay.cornwall@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/14] drm/amdkfd: save and restore barrier state for gfx12
Date: Mon, 29 Apr 2024 10:57:17 -0400
Message-ID: <20240429145726.3459450-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 049e5ef0-3250-4ef5-7e65-08dc685cbdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AQete3dAzpb3PQFgdnFp2qrVgsdGC9jOeBcgAvbtX4vf66/Unyrokp21+aKO?=
 =?us-ascii?Q?SbkQvAEi5CDFDbQ3brJPknFXGLZwMvq5kImAUpEqqvy/CCp9jwcgVm37fbTP?=
 =?us-ascii?Q?Ykl7XdHNG6/pCbPyeif2IWm48SkFWokAThEnp3AbaRfcAVVWrWYh5Sv7U2Yi?=
 =?us-ascii?Q?av9jN/CTxHjYttOqwRXb5bBzXfa+rAsUpy0tVMe6kQKFcn6e28iWwIC2tjS2?=
 =?us-ascii?Q?G94Cz56Y6Z7VUFYWerIt/f2UrgJgqJUHKW0+75nzu3fOuOnMJE1QujalbDXZ?=
 =?us-ascii?Q?vxSu0EZuFvEEI+g63blP0B8KkbcgWy4NJDX9Cx+HdSD37+nUVg6qnfU1VBLS?=
 =?us-ascii?Q?/FnxNPxWxmG1D3nKzz9x3LR9TTh7mHINin2i/HsO1zxN5xz+sORpMntKNFTr?=
 =?us-ascii?Q?xVPL6oTiFYpWYNDrZEL+HF4AGklw4rQy6pNTZsEh8hoFmPbEhYTdERcxE9iq?=
 =?us-ascii?Q?TwIjT/TR6uo+PQbWt6LwZPXXrhi5qTmqIuuCauvKb/86D/95/gJykevJcqOt?=
 =?us-ascii?Q?PLA0sk04saGzRFBf0uoe2T7TRjnMvBNcXDFvFteLBDowDGL4W5huSHUj5raQ?=
 =?us-ascii?Q?r+nvLB0U3edeHT8qKzLNFE+0BMuNAQZuu6LjKr44tknkhpVRQ6iF+zJNPHja?=
 =?us-ascii?Q?AHsw0Thk+N+53aHb49JuiHKTftg9cw6lSQNvvQmf1rhqJyXg3JLJE38ClXWF?=
 =?us-ascii?Q?ajk+NVNHj0zsyzkzx2ne9I5GEaFVmxn4CS+Dsg/NqAbzn7fS9iGIKTh9WegN?=
 =?us-ascii?Q?eWwDNMR3jcvt9FAi1FmVTOXcs+XzEelcmCFdX5LV6T/A9nAb3R6CEujMOyKV?=
 =?us-ascii?Q?QoINb+5SON/8A4uiksjsfbK0ElCWY/rTykESOAdOeVq2ptOr34JerL4doWr2?=
 =?us-ascii?Q?x/cs4Jd2uz1Gz0Z9lAHfbOfGU5qp3A5i53fw1TfolZLK8k1Jmw3uoDy6TBUf?=
 =?us-ascii?Q?/3P+Mil4e4QoHw82U1kuj/IEtMiusGaPyt/kELFoOfVfRH5G/IyHGnQpdTj7?=
 =?us-ascii?Q?ehx3tMlOjUY6WGs6hzqqoZqyvN6upDMgHxCt++MZjdm5MQplslONf6DFeFzb?=
 =?us-ascii?Q?mvBiINOpcNNOPcSflwJZXCZCE22ZwHeVrIaIbzeJYq92sOLfrLbTmnzZhiia?=
 =?us-ascii?Q?5dq6TTwDhyO4yTxRqKC/CwdXCid1FNUHFjneGq1bS54a9Ps2vmJ3M3MogTGH?=
 =?us-ascii?Q?zp+MkR5KeeRtURucH9++aT4A/T/NS+0Uge5zHJNgipCU/Re9hWGO1loigDew?=
 =?us-ascii?Q?VOzKLOibZHuLOp+0Mk47JfFAkfsVSfnsmxBVWmhGfECL8Xu+lUd6YbwMovzo?=
 =?us-ascii?Q?vD7aPOMnselxOSgxqBV9I/quAgFyrHjEw9wLPCkC4K61cFDaa+bNGh9rtbC8?=
 =?us-ascii?Q?3jW0jgLEqf/1nCkxcqcuRLQxYVjZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:50.8549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049e5ef0-3250-4ef5-7e65-08dc685cbdd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
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

From: Lancelot SIX <lancelot.six@amd.com>

Add support to save and restore the work group barrier state in gfx12
CWSR trap handler.

There is no support to directly restore the signal count of a barrier
state, so instead this patch repeatedly calls s_barrier_signal to
increment the signal count to the desired value.

In this patch, I have implemented the logic to restore the barrier at
the end of the block restoring the HWREGs.  This process needs to be
done by exactly 1 wave per work group.  To achieve this, the initial
value of s_restore_spi_init_hi (containing a FIRST_WAVE bit) needs to be
saved up until that point.  An alternative could be restore the barrier
earlier in the process (around when LDS is restored, as the same wave
does both).  Doing this would break the pattern that the restore
procedure follows the CWSR area layout.

Before restoring the barrier, this patch checks if the barrier was whose
state was saved has the "valid" bit set, even if I don't think this
barrier can be in an invalid state during context save.  I expect this
test to always be true.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 312 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  43 +++
 2 files changed, 205 insertions(+), 150 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 2dd14f26d2f88..b539ac814b867 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3647,7 +3647,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_hex[] = {
-	0xbfa00001, 0xbfa0023b,
+	0xbfa00001, 0xbfa00240,
 	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
@@ -3781,21 +3781,57 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x0000fa71, 0x807d817d,
 	0xb8faf802, 0xd7610002,
 	0x0000fa7a, 0x807d817d,
-	0xbefe00ff, 0x0000ffff,
-	0xbeff0080, 0xc4068070,
+	0xbefa50c1, 0xbfc70000,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xbefe00ff,
+	0x0000ffff, 0xbeff0080,
+	0xc4068070, 0x008ce802,
+	0x00000000, 0xbefe00c1,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0xb8fa1e06,
+	0x847a8a7a, 0x80707a70,
+	0xbef600ff, 0x01000000,
+	0xbef90080, 0xbefd0080,
+	0xbf800000, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xbe8c410c,
+	0xbe8e410e, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
+	0x80798179, 0xd7610002,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
+	0x80798179, 0xd7610002,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
+	0x80798179, 0xd7610002,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
+	0x80798179, 0xd7610002,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
+	0x80798179, 0xd7610002,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
+	0x80798179, 0xd7610002,
+	0x0000f20c, 0x80798179,
+	0xd7610002, 0x0000f20d,
+	0x80798179, 0xd7610002,
+	0x0000f20e, 0x80798179,
+	0xd7610002, 0x0000f20f,
+	0x80798179, 0xbf06a079,
+	0xbfa10007, 0xc4068070,
 	0x008ce802, 0x00000000,
-	0xbefe00c1, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0xb8fa1e06, 0x847a8a7a,
-	0x80707a70, 0xbef600ff,
-	0x01000000, 0xbef90080,
-	0xbefd0080, 0xbf800000,
+	0x8070ff70, 0x00000080,
+	0xbef90080, 0x7e040280,
+	0x807d907d, 0xbf0aff7d,
+	0x00000060, 0xbfa2ffbb,
 	0xbe804100, 0xbe824102,
 	0xbe844104, 0xbe864106,
 	0xbe884108, 0xbe8a410a,
-	0xbe8c410c, 0xbe8e410e,
 	0xd7610002, 0x0000f200,
 	0x80798179, 0xd7610002,
 	0x0000f201, 0x80798179,
@@ -3814,130 +3850,97 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xd7610002, 0x0000f20a,
 	0x80798179, 0xd7610002,
 	0x0000f20b, 0x80798179,
-	0xd7610002, 0x0000f20c,
-	0x80798179, 0xd7610002,
-	0x0000f20d, 0x80798179,
-	0xd7610002, 0x0000f20e,
-	0x80798179, 0xd7610002,
-	0x0000f20f, 0x80798179,
-	0xbf06a079, 0xbfa10007,
 	0xc4068070, 0x008ce802,
-	0x00000000, 0x8070ff70,
-	0x00000080, 0xbef90080,
-	0x7e040280, 0x807d907d,
-	0xbf0aff7d, 0x00000060,
-	0xbfa2ffbb, 0xbe804100,
-	0xbe824102, 0xbe844104,
-	0xbe864106, 0xbe884108,
-	0xbe8a410a, 0xd7610002,
-	0x0000f200, 0x80798179,
-	0xd7610002, 0x0000f201,
-	0x80798179, 0xd7610002,
-	0x0000f202, 0x80798179,
-	0xd7610002, 0x0000f203,
-	0x80798179, 0xd7610002,
-	0x0000f204, 0x80798179,
-	0xd7610002, 0x0000f205,
-	0x80798179, 0xd7610002,
-	0x0000f206, 0x80798179,
-	0xd7610002, 0x0000f207,
-	0x80798179, 0xd7610002,
-	0x0000f208, 0x80798179,
-	0xd7610002, 0x0000f209,
-	0x80798179, 0xd7610002,
-	0x0000f20a, 0x80798179,
-	0xd7610002, 0x0000f20b,
-	0x80798179, 0xc4068070,
-	0x008ce802, 0x00000000,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00001, 0xbeff00c1,
-	0xb8fb4306, 0x8b7bc17b,
-	0xbfa10045, 0x8b7aff6d,
-	0x80000000, 0xbfa10042,
-	0x847b867b, 0x847b827b,
-	0xbef6007b, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0xb8fa1e06, 0x847a8a7a,
-	0x80707a70, 0x8070ff70,
-	0x00000200, 0x8070ff70,
-	0x00000080, 0xbef600ff,
-	0x01000000, 0xd71f0000,
-	0x000100c1, 0xd7200000,
-	0x000200c1, 0x16000084,
+	0x00000000, 0xbefe00c1,
 	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbefd0080,
-	0xbfa20013, 0xbe8300ff,
-	0x00000080, 0xbf800000,
-	0xbf800000, 0xbf800000,
-	0xd8d80000, 0x01000000,
-	0xbf890000, 0xc4068070,
-	0x008ce801, 0x00000000,
-	0x807d037d, 0x80700370,
-	0xd5250000, 0x0001ff00,
-	0x00000080, 0xbf0a7b7d,
-	0xbfa2fff3, 0xbfa00012,
-	0xbe8300ff, 0x00000100,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8fb4306,
+	0x8b7bc17b, 0xbfa10045,
+	0x8b7aff6d, 0x80000000,
+	0xbfa10042, 0x847b867b,
+	0x847b827b, 0xbef6007b,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0xb8fa1e06,
+	0x847a8a7a, 0x80707a70,
+	0x8070ff70, 0x00000200,
+	0x8070ff70, 0x00000080,
+	0xbef600ff, 0x01000000,
+	0xd71f0000, 0x000100c1,
+	0xd7200000, 0x000200c1,
+	0x16000084, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa20013,
+	0xbe8300ff, 0x00000080,
 	0xbf800000, 0xbf800000,
 	0xbf800000, 0xd8d80000,
 	0x01000000, 0xbf890000,
 	0xc4068070, 0x008ce801,
 	0x00000000, 0x807d037d,
 	0x80700370, 0xd5250000,
-	0x0001ff00, 0x00000100,
+	0x0001ff00, 0x00000080,
 	0xbf0a7b7d, 0xbfa2fff3,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20004, 0xbef000ff,
-	0x00000200, 0xbeff0080,
-	0xbfa00003, 0xbef000ff,
-	0x00000400, 0xbeff00c1,
-	0xb8fb3b05, 0x807b817b,
-	0x847b827b, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa2001b, 0xbef600ff,
-	0x01000000, 0xbefd0084,
-	0xbf0a7b7d, 0xbfa10040,
-	0x7e008700, 0x7e028701,
-	0x7e048702, 0x7e068703,
-	0xc4068070, 0x008ce800,
-	0x00000000, 0xc4068070,
-	0x008ce801, 0x00008000,
-	0xc4068070, 0x008ce802,
-	0x00010000, 0xc4068070,
-	0x008ce803, 0x00018000,
-	0x807d847d, 0x8070ff70,
-	0x00000200, 0xbf0a7b7d,
-	0xbfa2ffeb, 0xbfa0002a,
+	0xbfa00012, 0xbe8300ff,
+	0x00000100, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf890000, 0xc4068070,
+	0x008ce801, 0x00000000,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000100, 0xbf0a7b7d,
+	0xbfa2fff3, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20004,
+	0xbef000ff, 0x00000200,
+	0xbeff0080, 0xbfa00003,
+	0xbef000ff, 0x00000400,
+	0xbeff00c1, 0xb8fb3b05,
+	0x807b817b, 0x847b827b,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa2001b,
 	0xbef600ff, 0x01000000,
 	0xbefd0084, 0xbf0a7b7d,
-	0xbfa10015, 0x7e008700,
+	0xbfa10040, 0x7e008700,
 	0x7e028701, 0x7e048702,
 	0x7e068703, 0xc4068070,
 	0x008ce800, 0x00000000,
 	0xc4068070, 0x008ce801,
-	0x00010000, 0xc4068070,
-	0x008ce802, 0x00020000,
+	0x00008000, 0xc4068070,
+	0x008ce802, 0x00010000,
 	0xc4068070, 0x008ce803,
-	0x00030000, 0x807d847d,
-	0x8070ff70, 0x00000400,
+	0x00018000, 0x807d847d,
+	0x8070ff70, 0x00000200,
 	0xbf0a7b7d, 0xbfa2ffeb,
-	0xb8fb1e06, 0x8b7bc17b,
-	0xbfa1000d, 0x847b837b,
-	0x807b7d7b, 0xbefe00c1,
-	0xbeff0080, 0x7e008700,
+	0xbfa0002a, 0xbef600ff,
+	0x01000000, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10015,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
 	0xc4068070, 0x008ce800,
-	0x00000000, 0x807d817d,
-	0x8070ff70, 0x00000080,
-	0xbf0a7b7d, 0xbfa2fff7,
-	0xbfa00159, 0xbef4007e,
-	0x8b75ff7f, 0x0000ffff,
-	0x8c75ff75, 0x00040000,
-	0xbef60080, 0xbef700ff,
-	0x10807fac, 0xb8f20742,
+	0x00000000, 0xc4068070,
+	0x008ce801, 0x00010000,
+	0xc4068070, 0x008ce802,
+	0x00020000, 0xc4068070,
+	0x008ce803, 0x00030000,
+	0x807d847d, 0x8070ff70,
+	0x00000400, 0xbf0a7b7d,
+	0xbfa2ffeb, 0xb8fb1e06,
+	0x8b7bc17b, 0xbfa1000d,
+	0x847b837b, 0x807b7d7b,
+	0xbefe00c1, 0xbeff0080,
+	0x7e008700, 0xc4068070,
+	0x008ce800, 0x00000000,
+	0x807d817d, 0x8070ff70,
+	0x00000080, 0xbf0a7b7d,
+	0xbfa2fff7, 0xbfa0016b,
+	0xbef4007e, 0x8b75ff7f,
+	0x0000ffff, 0x8c75ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x10807fac,
+	0xbef1007f, 0xb8f20742,
 	0x84729972, 0x8b6eff7f,
 	0x04000000, 0xbfa1003c,
 	0xbefe00c1, 0x857d9972,
@@ -4064,49 +4067,58 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xb8ee1e06, 0x846e8a6e,
 	0x80786e78, 0x8078ff78,
 	0x00000200, 0xbef600ff,
-	0x01000000, 0xf4621bfa,
+	0x01000000, 0xbeff0071,
+	0xf4621bfa, 0xf0000000,
+	0x80788478, 0xf4621b3a,
 	0xf0000000, 0x80788478,
-	0xf4621b3a, 0xf0000000,
-	0x80788478, 0xf4621b7a,
+	0xf4621b7a, 0xf0000000,
+	0x80788478, 0xf4621c3a,
 	0xf0000000, 0x80788478,
-	0xf4621c3a, 0xf0000000,
-	0x80788478, 0xf4621c7a,
+	0xf4621c7a, 0xf0000000,
+	0x80788478, 0xf4621eba,
 	0xf0000000, 0x80788478,
-	0xf4621eba, 0xf0000000,
-	0x80788478, 0xf4621efa,
+	0xf4621efa, 0xf0000000,
+	0x80788478, 0xf4621e7a,
 	0xf0000000, 0x80788478,
-	0xf4621e7a, 0xf0000000,
-	0x80788478, 0xf4621cfa,
+	0xf4621cfa, 0xf0000000,
+	0x80788478, 0xf4621bba,
 	0xf0000000, 0x80788478,
+	0xbf89fc07, 0xb96ef814,
 	0xf4621bba, 0xf0000000,
 	0x80788478, 0xbf89fc07,
-	0xb96ef814, 0xf4621bba,
+	0xb96ef815, 0xf4621bba,
 	0xf0000000, 0x80788478,
-	0xbf89fc07, 0xb96ef815,
+	0xbf89fc07, 0xb96ef812,
 	0xf4621bba, 0xf0000000,
 	0x80788478, 0xbf89fc07,
-	0xb96ef812, 0xf4621bba,
+	0xb96ef813, 0x8b6eff7f,
+	0x04000000, 0xbfa1000d,
+	0x80788478, 0xf4621bba,
 	0xf0000000, 0x80788478,
-	0xbf89fc07, 0xb96ef813,
-	0xbe804ec2, 0xbf94fffe,
-	0xbefd006f, 0xbefe0070,
-	0xbeff0071, 0xb97bf811,
-	0xb973f801, 0xb8ee3b05,
-	0x806e816e, 0xbf0d9972,
-	0xbfa20002, 0x846e896e,
-	0xbfa00001, 0x846e8a6e,
-	0xb8ef1e06, 0x846f8a6f,
-	0x806e6f6e, 0x806eff6e,
-	0x00000200, 0x806e746e,
-	0x826f8075, 0x8b6fff6f,
-	0x0000ffff, 0xf4605c37,
-	0xf8000050, 0xf4605d37,
-	0xf8000060, 0xf4601e77,
-	0xf8000074, 0xbf89fc07,
-	0x8b6dff6d, 0x0000ffff,
-	0x8bfe7e7e, 0x8bea6a6a,
-	0xb97af804, 0xbe804a6c,
-	0xbfb00000, 0xbf9f0000,
+	0xbf89fc07, 0xbf0d806e,
+	0xbfa10006, 0x856e906e,
+	0x8b6e6e6e, 0xbfa10003,
+	0xbe804ec1, 0x816ec16e,
+	0xbfa0fffb, 0xbe804ec2,
+	0xbf94fffe, 0xbefd006f,
+	0xbefe0070, 0xbeff0071,
+	0xb97bf811, 0xb973f801,
+	0xb8ee3b05, 0x806e816e,
+	0xbf0d9972, 0xbfa20002,
+	0x846e896e, 0xbfa00001,
+	0x846e8a6e, 0xb8ef1e06,
+	0x846f8a6f, 0x806e6f6e,
+	0x806eff6e, 0x00000200,
+	0x806e746e, 0x826f8075,
+	0x8b6fff6f, 0x0000ffff,
+	0xf4605c37, 0xf8000050,
+	0xf4605d37, 0xf8000060,
+	0xf4601e77, 0xf8000074,
+	0xbf89fc07, 0x8b6dff6d,
+	0x0000ffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0xb97af804,
+	0xbe804a6c, 0xbfb00000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0x00000000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index cab62a1517bf7..9af3b62120041 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -154,6 +154,8 @@ var S_TRAPSTS_HWREG				= HW_REG_WAVE_EXCP_FLAG_PRIV
 var S_TRAPSTS_SAVE_CONTEXT_MASK			= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
 var S_TRAPSTS_SAVE_CONTEXT_SHIFT		= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
 var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK|SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK
+var BARRIER_STATE_SIGNAL_OFFSET			= 16
+var BARRIER_STATE_VALID_OFFSET			= 0
 #endif
 
 // bits [31:24] unused by SPI debug data
@@ -227,6 +229,7 @@ var s_restore_buf_rsrc3				= ttmp11
 var s_restore_size				= ttmp6
 var s_restore_ttmps_lo				= s_restore_tmp
 var s_restore_ttmps_hi				= s_restore_alloc_size
+var s_restore_spi_init_hi_save			= s_restore_exec_hi
 
 shader main
 	asic(DEFAULT)
@@ -639,6 +642,10 @@ L_SAVE_HWREG:
 
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
 	write_hwreg_to_mem(s_save_tmp, s_save_buf_rsrc0, s_save_mem_offset)
+
+	s_get_barrier_state s_save_tmp, -1
+	s_wait_kmcnt (0)
+	write_hwreg_to_mem(s_save_tmp, s_save_buf_rsrc0, s_save_mem_offset)
 #endif
 
 #if NO_SQC_STORE
@@ -1001,6 +1008,11 @@ L_RESTORE:
 	s_mov_b32	s_restore_buf_rsrc2, 0					//NUM_RECORDS initial value = 0 (in bytes)
 	s_mov_b32	s_restore_buf_rsrc3, S_RESTORE_BUF_RSRC_WORD3_MISC
 
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Save s_restore_spi_init_hi for later use.
+	s_mov_b32 s_restore_spi_init_hi_save, s_restore_spi_init_hi
+#endif
+
 	//determine it is wave32 or wave64
 	get_wave_size2(s_restore_size)
 
@@ -1250,6 +1262,11 @@ L_RESTORE_HWREG:
 
 	s_mov_b32	s_restore_buf_rsrc2, 0x1000000				//NUM_RECORDS in bytes
 
+#if ASIC_FAMILY >= CHIP_GFX12
+	// Restore s_restore_spi_init_hi before the saved value gets clobbered.
+	s_mov_b32 s_restore_spi_init_hi, s_restore_spi_init_hi_save
+#endif
+
 	read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0, s_restore_mem_offset)
 	read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0, s_restore_mem_offset)
 	read_hwreg_from_mem(s_restore_pc_hi, s_restore_buf_rsrc0, s_restore_mem_offset)
@@ -1278,6 +1295,32 @@ L_RESTORE_HWREG:
 	s_waitcnt	lgkmcnt(0)
 	s_setreg_b32	hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
 
+	// Only the first wave needs to restore the workgroup barrier.
+	s_and_b32	s_restore_tmp, s_restore_spi_init_hi, S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
+	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
+
+	// Skip over WAVE_STATUS, since there is no state to restore from it
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 4
+
+	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
+	s_waitcnt	lgkmcnt(0)
+
+	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
+	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
+
+	// extract the saved signal count from s_restore_tmp
+	s_lshr_b32	s_restore_tmp, s_restore_tmp, BARRIER_STATE_SIGNAL_OFFSET
+
+	// We need to call s_barrier_signal repeatedly to restore the signal
+	// count of the work group barrier.  The member count is already
+	// initialized with the number of waves in the work group.
+L_BARRIER_RESTORE_LOOP:
+	s_and_b32	s_restore_tmp, s_restore_tmp, s_restore_tmp
+	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
+	s_barrier_signal	-1
+	s_add_i32	s_restore_tmp, s_restore_tmp, -1
+	s_branch	L_BARRIER_RESTORE_LOOP
+
 L_SKIP_BARRIER_RESTORE:
 	// Make barrier and LDS state visible to all waves in the group.
 	s_barrier_signal	-2
-- 
2.44.0

