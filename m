Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E84DC2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 19:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0092610E996;
	Wed,  3 Jul 2024 19:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kqV1WfjW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9AA10E990
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 19:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1P8cAdlSHXLafsj4kPqjaBzFZzT8Ol+DHADnRIwNtxESvf7k5J6ASh73KxTr2N41WQgFuIh3QCZCgqjDaI81M6QRdqYeebt90PL7xI03ffMHuQ2c6+WK3BY18Vl7U0cSVlWZkYefNf8xIBqZnzH0ahTnRNFqshQVoRiVJC27LeMMcAvKdvnJcKhzN78gj3MDKEIFsmJ/tLngasmysjF/D9oWcVuFm5XcdhDsHU1SuMtBzrtEXkTfIExVUKrGIADFosBlubwg1UcFkmII+62Jy7dtvtE1RJOespMa76tUFUC4BWIswvOZavAgiGVfPxbOZ0ncqNYNCnbCruuziHkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr2ucF/1c8Tch1I1T/iomIw8kcf19Chiw4cOrRDoIQg=;
 b=ZfIkUFdtCrzOeYS+2We6mhAgmMnkiVBOgyBB4X74YgFEXNvxFuPogSBSg3P4lt0ey2gg2Ku8DQ0OJ2XweCEd9f8t87l0eCis74PXk4VrFZJJZ1j5kgcDFh+YurJZDN+7sxNJ3v9ZJ/kPnASO6/rAYL/Rhq7IMpPOB4rnwY5jH+mL7S+/NWXY2apOD3/RxFBn/WPwqeWFHyqLRfDWz0MbdtrK1jqGL1nU5fPrjPkUyT7qUYOsGMytQJ8zoozTYk+cn4ysK44Lgyq/SyN6rfrT9bC+gEij1M9zgzW/3v9Zp4UYdPXVqzUCrZ/ZBRe1++YjGp/cawwON48cmVIAV72gaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr2ucF/1c8Tch1I1T/iomIw8kcf19Chiw4cOrRDoIQg=;
 b=kqV1WfjWECaid7J+09aoUPmd66Y8HeFF/hbD3ubYVAijeDS+m3/OePZLef88k8AeAIJ66JQ/0N0a7BakKV8Oz0Ba6znqXN7NKf8P7A/7kRySiB3YS5c4Rtw+FboH/CD4gWI+qGNp1IYYVDrBvd7PTevLYXtRP8PLX7n8r/hNtOs=
Received: from CH0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:76::18)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Wed, 3 Jul
 2024 19:36:26 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::c) by CH0PR04CA0013.outlook.office365.com
 (2603:10b6:610:76::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Wed, 3 Jul 2024 19:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 19:36:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 14:36:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] MAINTAINERS: update powerplay and swsmu
Date: Wed, 3 Jul 2024 15:36:09 -0400
Message-ID: <20240703193611.2002463-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: d23d4a0f-8d32-4f01-8588-08dc9b976d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ZbBcKqhdGO3wKLpCpKtdSRGh04Ht+24RZZ4ZJWnqXkPuO0hk861++CfoPAg?=
 =?us-ascii?Q?Blv56yv6ykA18ZPvnqGOpoXbAkaP4loyqSp+rFBphlKS2BuYYS53CQzcfQUW?=
 =?us-ascii?Q?z6CYgbd9XgKC5r3+U16FS+hZV23PSAP+gVwe0XquQEBaznpqivSk0NJZgTnz?=
 =?us-ascii?Q?/HRWvCmUKHFTztGE5Egb/+clQWqySh/FQmuFOMY002WmEaJcKcB4LxjOHloF?=
 =?us-ascii?Q?eJFl1xLgBeCmPm2ASRKdnzrecrD0fdMVYTO8E5P63m16g12GFkfJbQYH7A5y?=
 =?us-ascii?Q?VVUHT6T5ul7kVBl/AGUjULwK2/WSd9gPCzjoHVeB5sajpAw/+uuGfaShrTx7?=
 =?us-ascii?Q?7QiLHUK5Kalzm28X5xaW29oXUrZpNkHyROc1+HUkQKhTur7qkJXYJHuB5vx4?=
 =?us-ascii?Q?TyYFiMdwSBUW+nN8tzOAJ/aHRAIoqmp06RfAbFuvJZe9wUjBeoS1qnR/5vyZ?=
 =?us-ascii?Q?1eRh47tz07c5WYD2ijBQYHJ2b+ocVo9ajvyi2EgZdeiWszzwBWKMudGPFAjZ?=
 =?us-ascii?Q?DYrmempDQrYkDdyxMvSazfmPqVKONMSlRCH5PGTuirVOlo+F2rKuSNHpgVn1?=
 =?us-ascii?Q?c99t59B934hFGA3aipuRHtJs720cymYGADYcoP1KGDoEMaKPkdzsoRkN6rIV?=
 =?us-ascii?Q?qGh6vXOj9ENRQi7ZwXJo7DIDFUDcvuaC8WcCuzjdT/2eYPtsL+4OlwydjeBi?=
 =?us-ascii?Q?tUI/SVpRs4pankiYjk9bXXKsNtkmfk7bhZDenhuaPh5BoE2fB7Y9whve4lBt?=
 =?us-ascii?Q?+opgGz7xWO79kWNyMPLGdlkf9bEG17CDqc+IpGJ1Z5DXSCRJ5chq2DTXr5Un?=
 =?us-ascii?Q?X9gFLqWTzVGKCOORsC9BR9nzmDHYXgJPh6MLMvKa4zfLJwOVst9lGA35GAn6?=
 =?us-ascii?Q?5VZbmkkv5gMe/lhpzVCNSOxSxKTjoiCVkvz2U34+MbUyr7hHJhMeZu7ZcKLc?=
 =?us-ascii?Q?m2zhdCQKKGJfhjwMoQrkniu51Yzx3VG2OBeoQNwG/hB65vOURoyojd2yBGGD?=
 =?us-ascii?Q?FCvgtqwL6bI50mhh13iRFWlQnIhRzWOku0/AFFMoGXf/eH8fRJKm6C8iVjC/?=
 =?us-ascii?Q?YPFFYFQsljJBAnk3EbhVjfXE44gS3GHKfSGSF0I9E+oNS70jWiuSNcDN/RcU?=
 =?us-ascii?Q?sf+kiuhO3d9wDdINme1Ysnd73vuMjDMPpPuU5LL5HmUvviS2qF9o3T8ta/CZ?=
 =?us-ascii?Q?SPRvnADWg3pSnz/qLRTATK+yPrADzeQoIPFirwvgA7F7tOAsffOe3acpiNQ5?=
 =?us-ascii?Q?FROgXPXHxinzcpSvEmX9ouijpNCyMt7m/fiIegpYGaRjE1A8UmxUTkuYuC2S?=
 =?us-ascii?Q?knOivEoXTHkuO2qFx4T8JG3zJIItGQ/TVTaFHAyY9PzbhS+KIeadGlrzAkY1?=
 =?us-ascii?Q?hDH+2Fe5Lb/7+JyJcrnrR/P2SBED?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 19:36:25.8492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d23d4a0f-8d32-4f01-8588-08dc9b976d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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

Evan is no longer maintaining powerplay and swsmu.
Add Kenneth Feng as his replacement.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 082483b40fac..3b7aac333d8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1092,7 +1092,7 @@ F:	Documentation/ABI/testing/sysfs-amd-pmf
 F:	drivers/platform/x86/amd/pmf/
 
 AMD POWERPLAY AND SWSMU
-M:	Evan Quan <evan.quan@amd.com>
+M:	Kenneth Feng <kenneth.feng@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
-- 
2.45.2

