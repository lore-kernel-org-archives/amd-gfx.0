Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D08C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E00810E35F;
	Tue, 21 May 2024 07:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chYaGwo3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E2910E23A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:36:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJf7Hv/00Mw09jcJ1rkbnH4wOehef7F6iOvIhvZCm2MhGaE03Uke5I7D1ojbQkjwHka6e2mRJ/lqHOYiOg1YLfPIYe6ndrR41yTr+rVBlXZmTBT2fa90M+jkOGFdFrkUHEp4mVGvGiLiVlPtcs50WsoFvnVunRaOZbVsu0kkbQMFZUCP/vNFSvcpfRjGeXLNOIyNq7QEmhYrbR5+jakuUDZ4arhzoVDq5yhMZetQ+MG60rKwvaUP7yX/O8ECyyqmmfBxnHOcw6w+UBHB3Bn87iSXoFIfkspIscUefOYkEuX2wLMzc7Ba5dgHS7/HsN8ioUl9MX1dhWXlN9X0SQ62Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaYKWyOC9MHqo9ysipaOjl8V+bOUuQT0dJcGrY1ZCjU=;
 b=GAee740M0mThtjlahdcwtCHbvTJCII8Us1QufdXaMzjpJZk0k7Eq9Qf0TmbzIIjE3Htol1CWBjoq+mrqE5zFnkcgzHYlGV9NYVMWBxWySBptWn5A34WrPMdXdPnx5x9Pc7PygvLbMn/ezOBNbJm5Jstyq2mwWTpvXeMKD7MR6NMDyJ0chNNjQ07mtVi4pYqa/qaJ9yzPe7EqAG8QFODhCzHPckJYGx88PUvL3b3cARCiuwVMNrRAyy0pBy7udP3MA3bXa8yYtbi9HwPs9r2vUJ2vuz6fqyLr+hBvp18or0db+y0MFgID40PJd69OvO/F+MCDaT5nMrzw23KlCKK9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaYKWyOC9MHqo9ysipaOjl8V+bOUuQT0dJcGrY1ZCjU=;
 b=chYaGwo39ycsKoiVVRyG/5Q3wiSFje2qDgtoJQ6InBriL8DYCIi7WdT17ND0dAzvxUimWxMnI2tKXSRV31xyKOiXhsjSY9FDhlL851yOSfI/UIYQasqJoCv7p6M/SzI/gEl60qmYFpeSeZa5Ap03ATwehMyjjNeEGPt46pQMqmA=
Received: from CH2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:5a::26)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 07:35:59 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::66) by CH2PR08CA0016.outlook.office365.com
 (2603:10b6:610:5a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 07:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 07:35:58 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 02:35:55 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <frank.min@amd.com>, <likun.gao@amd.com>,
 <kenneth.feng@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: mes hw_fini fix for mode1 reset
Date: Tue, 21 May 2024 15:35:35 +0800
Message-ID: <20240521073535.2474624-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 4549a742-9636-40fa-7965-08dc7968a84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MY+PfpUSKDxsFU78jcfe7A83lAQiCJamNJ0MvB8u0g8si+LEz4sdSkvjx2Mz?=
 =?us-ascii?Q?atmyBALgrW0nA+Yvm6KajAz2M8zo/3MZXBV9+6fW60Cf4nr/A1hyeji/59TC?=
 =?us-ascii?Q?QCWZxUB/awdsZ6QDjTEFNDdffG/LEIBu0fkHKpOnCQjZiA5oiTlVH62rIG2o?=
 =?us-ascii?Q?K8Z4iYTEqYkLEOUN+oPLIz0qIRTTRNCYpGkAVES0nwVcBnock6xsO3yJJPlC?=
 =?us-ascii?Q?4fX03yAR1FwBSI622SzruUWKCeZSdbdfOV3+3J9NVI1w+jGYlqLBtVbXh7Bn?=
 =?us-ascii?Q?nwvaeDcULFDzNWeSEt8EJ1M5IUEoJ/WLxepIiMrzx1KKlGVHx7x45jbyY3v8?=
 =?us-ascii?Q?Bcley0NqEJWmKpICumrPbuAaka51it9u47OyYaEWbyH+JDupq7mHk3mld1+n?=
 =?us-ascii?Q?bNNzaxinHnUa3QJEYhQM4smlSR53JNA55BsBZ0imzFi0b/5/UFLkwtaoQbnO?=
 =?us-ascii?Q?7jWgou/bY8fNtx4Y98gKjKlA4HO9yDWTxbumKET+i2zxoonCNA13iNFYag1n?=
 =?us-ascii?Q?tFF1df6kwSW9vCjPtQnko1HOVsymPZTCHzofUb+KgSsXJ20SUwrM6rg+7uDg?=
 =?us-ascii?Q?nN4pjnPfAhjg4wmxsKLuVLaPTNbbj47JmJoH3c85WwyLHlc5qDTSJb/MMjy2?=
 =?us-ascii?Q?oeUWJ+OYqzioMPz9hyg4+NSrgp7o8v7oR59er/CQEFYDb34eHQP3i+6HPfgb?=
 =?us-ascii?Q?wy7bVd0Fb05vzXyWPHfPi7n9lo5jaqZR8/+fwcEiuZa0Khl0ZZTyX+iOjEoa?=
 =?us-ascii?Q?FLTBydTCoaaspOP7CvPNfGNnS5stNrMFQOGPOpU0mWnuTeI0UDIuaHxlQJ9o?=
 =?us-ascii?Q?N2eh5INLLP8SGhzqf2yB1J3gW77BOYKh0WMrT3P7yjFIAquMOTz4fEnrT5ru?=
 =?us-ascii?Q?BN+MwP3ZqamX1slGDKxjwlCJIox1P/CPyRK4x/M9tCGrECiPcrRW//nizESf?=
 =?us-ascii?Q?ot8EmA1jKTS8hr2/Hstnjx/iWBarJAS094tuf5CFqxkauMRn4opG7zpfgp56?=
 =?us-ascii?Q?YQbIokr7HOgEPLGCT8DLW79fmCSdSvb0t/0VHUyn93U0Jup9vtb3B192lvD8?=
 =?us-ascii?Q?BMrspzsj/piT9ndh7ho1w6gT9ec0QoxOBpkm3TTzPCbpPeWKvZTfPU1bf4e8?=
 =?us-ascii?Q?gav9Ij9r5VP5N4al4fcN7vhfekE9nEiL/qzmt0STlciKH9Y7KwPk32nOCe+T?=
 =?us-ascii?Q?ylPz+Het5R8XD8jObssiYVxCahr9X0Bv/jK4WpoBHHXucub0DzwkJ6Em/+kL?=
 =?us-ascii?Q?TCFfQp8fITXj9jBlGRBg0Tc9yUSdEqfOrWMK2cfsOhRZTQCS9Jf/OEaKkHoG?=
 =?us-ascii?Q?taa357fzjIrRN07M3aCvQeWQeyKGrkktj9wss29g6ANS4oSCOF0fmlnzWCuQ?=
 =?us-ascii?Q?hFJGKsjS8mWKMZ4G51x2d+5jxh1J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:35:58.6483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4549a742-9636-40fa-7965-08dc7968a84f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
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

Port mes11 hw_fini to mes12, fix for mode1 reset.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 45b70a4c4ada..f18fdda023c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1380,11 +1380,12 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 
 static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
 {
-	if (!adev->enable_uni_mes && adev->mes.ring.sched.ready)
+	if (adev->mes.ring.sched.ready) {
 		mes_v12_0_kiq_dequeue_sched(adev);
+		adev->mes.ring.sched.ready = false;
+	}
 
-	if (!amdgpu_sriov_vf(adev))
-		mes_v12_0_enable(adev, false);
+	mes_v12_0_enable(adev, false);
 
 	return 0;
 }
-- 
2.41.0

