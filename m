Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F60AEE2084
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C609310E748;
	Fri,  6 Feb 2026 11:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2NMGJh3j";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC1210E748
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcpG8vZlRu53xEKG+aci7McBXY9XmSyHwWaslEiQoA5PZtzqo8dsR8IzLD69DLD9j8CwR3p1wUWQJ0gO7pusIEJ6Ef19Bt4oxANLzlqtN5J1tqxuYOlM7peyG1qhmjC/UUGIrAJHf+gTUiKMd/wXq23mG3/u8za7B+11XFOwt3tYCDyf+Mn1B5grtxGYFG+FHmLyZY/fOFc57PBoHuI0OjdDZwaXUmBuFPmFk92bZlgrDB/Vl3Kkz4b+inrjK0DDWBvFy3cfpTJcbxcnfWhxoGX6KFtZLRfjeeoTUBRM/6LgShFtZFwDhlH/wJbT5KrpCQyFyYBlR3Z1vyD20laNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=wGJFXWWIlalLLrHPxULHGs25rpEi4mJrE4RvUvH1b9W3p4hJt5TNq3amzkEM0pzXPEu2oWqcX1EjpfphAoDEXmbtmEeGXtG7sRUuReAKXNJ0g4ccVNyJjlXa0E1IFUPJYM4NZ66jT6VfpAm35H/HgzTqm7IxketI4LbCyvKXEd0j/HukVBOJwDxx1e+5d149BPkNwQtr9pgAbhHPZaerklNHeWQT6zxmWAnYE2jODHlYSjsCgNyAogVDCsMbdkh7DO6YddjpWctnJP3B8QFTHSI6KKn0tR4V5l0HEnKgtlnoqP7UU1qrunb50HXVqhFTDJEjCBIFN2YnW67aGvXWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHdMMjoPCTYVi0RoCw812UtzUiYcQc39Euiy/ZBIlMU=;
 b=2NMGJh3jd6ceuBT2i6XTDnZAwyBjMHOzEAQZnq9BVlllNp2Nzb4sT5fLDq2qeiavCr0iC9+FvQCkN/FwjxGXj4jkpH5zEatq7+lVHuVBE3/RovSD7AAq87xCVCQq9o8EVNyw+mT0Gu9WbnXIsbZXEmGee5ehQS8tXBVYzHmq5vM=
Received: from MN2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:208:23e::9)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 11:25:24 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::55) by MN2PR14CA0004.outlook.office365.com
 (2603:10b6:208:23e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:24 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:22 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 10/11] drm/amd: Add CG/PG flags for GC 11.5.4
Date: Fri, 6 Feb 2026 11:24:48 +0000
Message-ID: <20260206112449.45381-10-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdf547f-2f44-4543-6ab9-08de65726be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mDrfZdbzvfR/xUk12Qypn4PBNkJ/eCTOCgjyJ6PojMVNdGhxydyzjSXH8JHj?=
 =?us-ascii?Q?jBksI8Z72hUg+0UprdORewcF+U0hYBvqAPG8rdSDhrXBg85iCBwfTLbvcF5f?=
 =?us-ascii?Q?1tkCbrSDQ+1TifHaOJESn4ZHJEwRk669VgTxcO1mPApes+d/XnbC34yFIrYe?=
 =?us-ascii?Q?kWso4QwHbi/cH5O6YQLJ3Tr2jh3mQAUqqf9DYbhi5gSDXD2U3XYZQXUW7Pfu?=
 =?us-ascii?Q?f7T9MWuhsYjLFqVfozOVrJ/UBMFZWYftyJxD0YQOnNpOXFF0mDIYO7g+jTlW?=
 =?us-ascii?Q?vczK/oIpozE4hxB6PGtrz5NoSeGCDWwjIWQz1r22pMjNOeyZJFWrihGVPysq?=
 =?us-ascii?Q?NSu598gIA0GlnSH0MXiVc9eywRb+bl4Ai4/PcYfqPbdJyR5ChAVWmnDWPDap?=
 =?us-ascii?Q?ncKcLgNVrqALfS0n3vT4yHw7ok/bHm6/ne9S23NAbDzYTg05oCxjlKxB03yV?=
 =?us-ascii?Q?Wpi9lf2asLT6sXfA/bqRRxuOg+wNQTfbpm7s1Q6cVbV3Fxc2x3K+BucbhvLd?=
 =?us-ascii?Q?BbNMT8/S/XpGH6mRsdhE7w66OM4jX0Qrc+DKhuXPATVd01n2/GgLOPJ+STvP?=
 =?us-ascii?Q?i0ft5j8FkV5fi57L4PygDz0GT8UbaN5NOBOczR3W224k9r22shq4Nn69Sbd0?=
 =?us-ascii?Q?1MWBtEt/LXSM17EQP9QtEmD23xK1+lrmOep9Y3XX49zEltJlvgGEVlP1iyq0?=
 =?us-ascii?Q?+ks8KRizsgDdIHpRC5bQWGvrLLui4oLZ/DTkJwiIV4/VtRAoo0CHZZyu1yHX?=
 =?us-ascii?Q?Y0nWviQR6y3AJICR9cTcIsX8ZPnyz5o99i6xSz7Kb2z07GhIlC9kfnIIFJ2o?=
 =?us-ascii?Q?+wjkxlhvR26iCjrWbKUwHad8bKODw/0CD/X80kZ6LQa/dFNwB4B41Lu02iq+?=
 =?us-ascii?Q?tdGkNE3BePme4p/sRkzUxf8GfP1cT/gJdL/fhSWrY33ThuduMyitl1cQqJRn?=
 =?us-ascii?Q?kLe/eHAJv0yyOE8FDQjrwKQDtF1ZuNNP9q/8sKppRuNpD+ErMNHwqbqDmTzI?=
 =?us-ascii?Q?Hh1H3zpi9Gs1YQ9OJywj+l5mhUgjzvJ7RlNKnjIuPyosj2g6nNP1x13fuCXS?=
 =?us-ascii?Q?D0vsZYbGDSOmbU8QARdvVnNxU8An7exsYYFLD6GdUkbC6Ud6ToiGCyr4u617?=
 =?us-ascii?Q?NKdaF92knhaiiGwOPVEXuYXeLIwuUHj52QSMicyfhEnYI/1JtBMq09TzLH5H?=
 =?us-ascii?Q?PyWBcLWhV1Jrq8f2jW1mQo/7OKX6hjMP7OMI/RM4OBX6Yo28r9+BL0uY3Cmr?=
 =?us-ascii?Q?XgABMPzOicfpgxirrY7wWgrah1mbgN7GUtggUXH1B6ks8AOLi1aiYleR4Sjm?=
 =?us-ascii?Q?R2npQneOosYIU+5FLXN3g9M25vrtG4zfSLhxjGbq6eEg6g4GrAAwL6dFehbI?=
 =?us-ascii?Q?qUX5yw140kzYkWdlyQKvvuMBxji4afE8XNUPb2pA3wuOqDmLl7TgzAFosgpm?=
 =?us-ascii?Q?G/Gt50S1pqkl2ZYOWOu08PA952PsmZIiI+7NTozjk9uadluWv3KwAnlBxcwV?=
 =?us-ascii?Q?bBbdwl18S8X0ZQgcNcF+PDO2j5grHH8dqhnwj2uOg2SKmj2mVhu8QmscvsFR?=
 =?us-ascii?Q?N9wFuEvPT5+SKOi7+Rkk2lVmS+SSHFfLCbXwTSxt6El705TD/4sYGMK3Bk7v?=
 =?us-ascii?Q?6GCFE3a4O8ZjAcX0AxZjFkW7FpHsz9SsEPklyDzeryEE5ni40Zu7fBSPrG3w?=
 =?us-ascii?Q?vXy6cA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mfyec2qGbuYCH37LT5OXZke+R6kOzNc4mxr/fi12TVNNz87dKaOQ2slMrYIQfOyALRtVcdIzFkPJI9bP7F4OMUc4oRaWz2AW/wriUN9tVk11uWkyBqj2VYb4XQ4JbdeIgnjbZ386GhwP7mLTTZFUmn+7AydbYWQJfbq6FvD6GgyJZYqQyVIUKAWwaUnpXqgDYSUHZdtT6Sz6UDRWPEjQir3Us1rz/N7Xfu+gTqVftFeNMT6DEDO4W+QdUTpV+6kys/skc5zZnaZo5Lmyp2K+Gthmkr9NTZEwBjgZyAKimaY8vuRbOGYnR9WGaCp5Pf1dtPOlvRlb/W+bEyLsSosp+zdSc9yLEpGiO/OeKKwG4+hLvyJ7IrpC+L6sqTu9YsVxp5fFdueAS9NvXaTwiARFWewYLMI+UhbKxU+loSEIjd3Uqv6wIfhZ/zNOoZtnmXbT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:24.3974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdf547f-2f44-4543-6ab9-08de65726be9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

Enable GFXOff for GC 11.5.4

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 79d132fc8ca9..8122a5cacf07 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -839,9 +839,28 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 		break;
 	case IP_VERSION(11, 5, 4):
 		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_DS |
+			AMD_CG_SUPPORT_HDP_SD |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x1;
                break;
 	default:
-- 
2.43.0

