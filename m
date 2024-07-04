Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1294AC30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 05:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B67410E1FB;
	Thu,  4 Jul 2024 05:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IqTXH3Yo";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A9610E07F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 05:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJRinumdbsFf3wXTVPSqa21UtBPT0e97MBYLwjav7+VkbHBMK+aEgnhUp3xGN9nJAphIGYkG7e8xAQa6EgQhB9N/hcBh63j8p2XF5QQ+p3QwyvAbBYNXuB2OD2100VKFf91Y4Nm1NgrTvaC/led1HNXXZ3iN+N5fORw+Smu0dswh4LUOvE999CPJLvzhbLCfnGcxd5PoeSi+P/byjMs9JbUMWmFnKMtnKSLfOdI8iIDJYi/frEEvprdYd4BMvrjwe/xBqLH+0LKll56aSYllDEqth7QRpdz7M0SYpbKq7A54dEkgpsNaNX3WmVBKP7x5ACFOBPNunNrE3vk6abAvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T19ABQMNrwF5o7GevjuIgjJBLBs/4Q4cY3e5bXXoKQ=;
 b=QGWcc9JQjjpyxt05kLp1AC8xmLdIORUOVAtPfDXheTyWRFT8U1tykr4kf+YjKA68vzRfUBlPIPCi2JM6jDahi5j/UuMtwLfse1Ynl3ESYTPZcqsERDNmY6gmxF+GYUix2nnMXFcv5y69he7Mq7tZQTTU1D1NqF2P4M/Mra08qsFB3ACWu1yUa8A7jqJi0CQddHnZ2hsjjcEL9Dn3G/rPgZc7b0Wysz723TXSCCC5Se/3PV83H6yI0IOP4I7wRfbszbdk4sT2ok3kBy0OD15yTfgU5k+KFs1Zjj0KzflxCQoNiFvJi2PwlxZt2qAgb0pjwYNF6nQ9uK+OCK0GnyziIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T19ABQMNrwF5o7GevjuIgjJBLBs/4Q4cY3e5bXXoKQ=;
 b=IqTXH3YoXGdnY7Scjntpod99yLld4tkhfZ648+N42ggJ77cUlf6qu+3tk/h5vdz19PkSFwBGi0CzoxV94TSW6T1ld5CyAs93Cw9q1H5Y4XTvTZZHpqUqwwQKfd8zEUBp3FF6y8RcPh6o0Ykb8oeMvti3DDbJ4TU5IVkc0QdP47o=
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 05:53:00 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::b) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27 via Frontend
 Transport; Thu, 4 Jul 2024 05:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Thu, 4 Jul 2024 05:52:59 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 00:52:57 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: remove redundant semicolons in RAS_EVENT_LOG
Date: Thu, 4 Jul 2024 13:52:40 +0800
Message-ID: <20240704055240.1722656-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d9a3bb-c7a6-4a08-f15e-08dc9bed8f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m3vvL1fepefIqeHOYSYpNByTvpcR4srnKabRizU20tERkOrTOW9Zu+RaAdkr?=
 =?us-ascii?Q?kHQwtei5QT6vQXxzOnR+irSR/d6BVF9jn/HV/gBqRWzF55vKNM08AqT0IojR?=
 =?us-ascii?Q?m2RJ3tGhqOxRbFTMC7NjtksJSCAncGkLJ2wyHjee5cN19SfLv3cvIOtUoNSu?=
 =?us-ascii?Q?AN8eoG77wi/kvj0PhyXJrHziD8N0K/MRWkcjevE+KYWt2EQ0uIFNjbH2zgSw?=
 =?us-ascii?Q?lyYGDp7HT+MnaXKStbPVG57TON31tPJ/j7LjIbNDf1vhEHnP+6Fu89TE1adY?=
 =?us-ascii?Q?lHxEcgzSExX0K7wmnzsIpBevYh3/PzrIDwTloOfoTwPNdE5B4eRie0Uvtwo1?=
 =?us-ascii?Q?/UVjWhJJncMaGW5hGqUeHamRGK5XSrmmwv+ifSH7K9q1GTUEr6j62BM2G+8Y?=
 =?us-ascii?Q?BLI7/aK1U2oGvwpocRcmosXWFYytQs1H3b4D0skW9r9XKB497KCXUGUm2pkq?=
 =?us-ascii?Q?8tedWcSTXYuYr/vwgWxAYTK8+If0p+bNYy1QdHfL2ZiMH66SMPDUu53aG+nB?=
 =?us-ascii?Q?qRdHrp1xaYI0fIvazPvhCtSxqa2ajwKbXSLuHHlCKL5lDbtlw6hZM45uLzhm?=
 =?us-ascii?Q?HQp0/W+axdM3TBzU8whBfSlWM4lZE35nBsfYCShP8LThJnPwMuMUrzr6YmNx?=
 =?us-ascii?Q?f6zlBATYM2gPypDmlUsn8baBuB3BkOSxDyeo6HosAV5INl6eWrniG8uIybb5?=
 =?us-ascii?Q?uN0tLBe33H2bnCONH7YLEJnNIbyHk7FGGS+FF2fpU+frWfgyE9SHnUTw98ie?=
 =?us-ascii?Q?WGm/ODF/DCVuNgO4so5+QCXrJSnGRy+64S9mDS4L20CpZBkMwXb3vR1gyBUH?=
 =?us-ascii?Q?jjO++S5g1EP1Gjzn+fQ41pjzAxx7UjJWRIlFFglMB1kFaZfVYfL0aRM7BgO0?=
 =?us-ascii?Q?NNxg/78bXHBod1eezySem/IsQiVXYQ0fU17z4FRGUHgzGSyhf+uUpqeh/Cps?=
 =?us-ascii?Q?Aa71EubLCyw6rrMJ13G2gyU+XJsP54utNVU2YlpOYbFOb/8FziFuuIiFr2Cr?=
 =?us-ascii?Q?AP1SwfEVr2AVzpWyTdvU8C3PtFSjzeBfSH4/+ObFsTXasWxQvRWGJzO1sB6w?=
 =?us-ascii?Q?6iuqh+A8xstyCj84PbTGbB1dDir7H03h9r5bgwtgCGacO72IPFpUjFkL1Sub?=
 =?us-ascii?Q?EWt3WFyfr66y1m6EdwkLp7vNTnoS7LKo2xpuysc9gq+Kr3p6r5fs86ffgqzB?=
 =?us-ascii?Q?FMdDfDQghwYs9KbK7RK0NiolxgUmOP9Hxa1baGP4GwXkaOBTAS3gg21V0V5b?=
 =?us-ascii?Q?cWBkIWeyusr3std+SKGksIlkGk0w06cB/4Gg3nVDGVVHpVg0mrA5xGSgGAKm?=
 =?us-ascii?Q?bwteLUkgGu9+YskmY3Vc+SAWSPOL70ngKGM62ELjTWH1memM4cMpTiqBXCvk?=
 =?us-ascii?Q?DyRhS1EyKEQzOPZfm94yqVqYCzLybmAquIig+xtJyHApb11Vm33yWDt3wciY?=
 =?us-ascii?Q?zhS+Oh5GgYBSV1JGRAitb7BFchNr0LJq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:52:59.5538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d9a3bb-c7a6-4a08-f15e-08dc9bed8f8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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

remove redundant semicolons in RAS_EVENT_LOG to avoid
code format check warning.

Fixes: 951c09c88fca ("drm/amdgpu: fix compiler 'side-effect' check issue for RAS_EVENT_LOG()")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 9224fc6418e4..518b10f190ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -72,7 +72,7 @@ struct amdgpu_iv_entry;
 #define RAS_EVENT_ID_IS_VALID(x)	(!((x) & BIT_ULL(63)))
 
 #define RAS_EVENT_LOG(adev, id, fmt, ...)	\
-	amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);
+	amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__)
 
 #define amdgpu_ras_mark_ras_event(adev, type)	\
 	(amdgpu_ras_mark_ras_event_caller((adev), (type), __builtin_return_address(0)))
-- 
2.34.1

