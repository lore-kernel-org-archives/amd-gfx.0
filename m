Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E607C4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 06:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FBA210E431;
	Mon,  6 May 2024 06:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vubVQkc5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD09210E431
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 06:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY9+qPn3NLrHQy8EiOuTHffJUjzuao+wnYuLMQFw6fdLDmZUfW3o/cTv/L5dACEIS4c10Yg63Eu7kzx85b1qRZa2rx9ON00gY4tPVAzPrZaZxmtWm+AonKModf+yaOhjH1t3uKvUUI5c7mWYXO2QtFcz/dbtiMLUtQOK8HQNWOQSfjaLW8ZCiNx5kGOYfGlKssAAwwnB5nZNiRjjgX22XskfsfFejBbRnuaKv1rz0xBdrwNIGirSfNluaotLG+b5Cozm1bj7PdX2clCqE0A3oWe0ylOCf9xo2Az6uYlzAccC40BZ3zSveZnRadadIo7HeAa4ip2/FzerAUsKQPNJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Hl7nL3PmiWRuZTSchMUm810f+p0/zh4uXXXKMOWz6E=;
 b=Q/rKjLkxP/2odmStueq3oV52jvGAWA54a1+Aa8c6oqj258DQ0kVT2njl7aW6m2eWr/Wai6rpRT6P8pcNz/xX9yJGDV1JdAsJ1wuFVP7WsTAxAPvtC6w+EHKunmVnOozFmG7tQXnq7YLnTf6W+q7V5sVHf5+RHtbZUQQq6G2u+RjtASOiGGaYMsU43Ljsi3KTAVCilqx6ngFfIGhbEyKKn0zm6RltivzAxsnckcgPseFGxLK9Ii5SgBTP16pEyKlaSHj4CHl/PLkcTTd9BsvrdhgJRd/CI9asltoQ4ibD6rOR/CgjxTQNYWJSwEI2BA2lDAecGVtTSLqyy0Suc/KgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hl7nL3PmiWRuZTSchMUm810f+p0/zh4uXXXKMOWz6E=;
 b=vubVQkc5whq1NNorHOkAQ9A6wboABgpuoRnyBGkHyxU4bUDVy/KtWeuywTuGZdMxTHTebTQRNCOOlEMyeEKa7pfn+Zf4IgtK98x4lkoR+1qzJSQk/AYMaSfDnLMyVwS5UKWb7h9J/YG0vwGbRsuzU5VJCr6iT89UcF3TqzBzltw=
Received: from SJ0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:a03:3a0::11)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 06:47:40 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::4e) by SJ0PR03CA0246.outlook.office365.com
 (2603:10b6:a03:3a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 06:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 06:47:37 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 01:47:34 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: ignoring unsupported ras blocks when MCA bank
 dispatches
Date: Mon, 6 May 2024 14:47:23 +0800
Message-ID: <20240506064723.996050-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: ed136ccb-973d-4ae9-f44a-08dc6d986b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tOCPSltY9iGsaXUS7xec+LTYbfBEpfkIpBDclCRwMYHanrJTHLsFIzn9ZaL1?=
 =?us-ascii?Q?LedX1Mmkr7jOl5EXqSGl/VUrefU5GSmcZCj1iDYXLEOZVkyZZ2xOYFsVOe+i?=
 =?us-ascii?Q?c5vM80W8heIqFF/LazMztVg7YwAo+uXpn9vqPcSUsdhw8fPYeB1IB9KrU5aP?=
 =?us-ascii?Q?8ZXxWlLSmOW15P1ewBD5CcyrHPd01RF4uoLt54sg1yz8WGjmCi362dhM4Sk4?=
 =?us-ascii?Q?fyePxrVKaMhge6VGi6ekb/oeUPRh2PbWsnrMQG3YAYEdiLhUzzf4D6t/aOy0?=
 =?us-ascii?Q?ot83Sdb1hZqvUerCkByERI7jJCUdKITTX6qQRoMYueOeZY1cb1+kvaMm3/ug?=
 =?us-ascii?Q?h3FxPp6FDzPp8gMucsK2+z4u5LPk/kVwWlSKzv4EfjK9ZvhC/ogRERfP/CSk?=
 =?us-ascii?Q?pOG6Vvn7E9DsDyi21UyJFqajLgkqOHIP91QtrCGKvWsT/WWb+b2mkvziN+j7?=
 =?us-ascii?Q?kH/VTsLH7sBbF2sNIXNiWzK2D+aY7299C9PRqay/uaRmz2yxYUBbLx8m1bbe?=
 =?us-ascii?Q?PhuqRZ/airaPkgxnayKHQ6+kmL4oJcrk3754uK4osZ+sIIgJikOHoX3giKgL?=
 =?us-ascii?Q?n6DE5lwwhel90hitl/kfBihcPnle8TlcOxRsDhH9rQkCx1jNXYr5lB+KvjiN?=
 =?us-ascii?Q?3S479fvW8Nf8Rz+GFobHq3T/aGLjKbolTj4ud+mEtOfOHbqWDaJtTkT3MOX/?=
 =?us-ascii?Q?vHcasvJbfDaotcze/7akONOUNdET3zwX0io1lydTccC/+S7v1/vUGzxPlJjY?=
 =?us-ascii?Q?X66BZz+Np1NC2Q0EFo+8nFu25ZXIXAqR4dDLcA2uJl20Mazlbyyzzu8cu3mM?=
 =?us-ascii?Q?/CQ0fB3zfDTZT7dv7vne1qGDArBNsYWU1MB5KWJH8/2iWnD1jEbQB8JZArwr?=
 =?us-ascii?Q?VoXcWFjwQwkv3XCc15GmLz8ZccnX+pWuMaH74o1fDa43zJIhpco7/bRHgaJa?=
 =?us-ascii?Q?9klMPc5oSGQ8QMebDhACtGmeOx64T8P76xpQHKodjCA/592JWh0kL+H1NCpH?=
 =?us-ascii?Q?zkK00RLSC/NB1WRouYzW33RkV/cTbe96MkKc4MpHGr7s6H9f2Vp9WLyHxcLr?=
 =?us-ascii?Q?wJi2imY0Ique1JG1o5hfHhxBqgHxcqvd2M53vHsZ0zWxkxHQ7Nz2d0bnM4Qc?=
 =?us-ascii?Q?n7YIbQi5AKbGga13sXMNmItv9rinLLt2xF7UoSH0EVajBYRRk2fPRAt/mC7c?=
 =?us-ascii?Q?H4b+AMruZH036TiQpvkJXCd9ze+qH4w1OVECQ/hZZRwNwK91br+t17NayyFd?=
 =?us-ascii?Q?PiDWrTwSR8aD3GJtNU1pNCSlTgDlMx2zt9bGbHkyyXDD5d5eUsdsT/EZh1rq?=
 =?us-ascii?Q?MT1Nri0a8WfG3E/h7n6ssNV+orgnL/wxYB4Ss8bsUzqqPkic0bmyB8XjVJSR?=
 =?us-ascii?Q?K4PF1T/HLz2iisLbPV1x2fqMsHDd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 06:47:37.8966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed136ccb-973d-4ae9-f44a-08dc6d986b2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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

This patch is used to solve the problem of incorrect parsing of error counts.
When the UE trigger gpu is reset, the driver will attempt to parse all possible ras blocks.
For ras blocks that are not supported by the current ASIC, the driver should ignore this error.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index a7736aa58ba9..0c9a271c5028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -415,7 +415,7 @@ static int amdgpu_mca_dispatch_mca_set(struct amdgpu_device *adev, enum amdgpu_r
 
 		count = 0;
 		ret = amdgpu_mca_smu_parse_mca_error_count(adev, blk, type, entry, &count);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 
 		if (!count)
-- 
2.34.1

