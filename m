Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E0FCCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 07:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A6110E70C;
	Wed, 29 Oct 2025 07:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rgfeyVVz";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F8110E709
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 07:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrqUM0heI8IUQ9VPGBKkHf4PLaZcepPYRfswemjj/12QoWANIvcDv2L4hRn364grz0pmX0BHs46XDbCYSud2ls33wfhWDn2Nmt3FT5bFOJt2KWE3tMSw4f5qVbwpo6uZbcJ8ZGAMOAYEVshPm9hoLmOo7mP1ujwtGQ3sJcU3R5RG499oJ+udD0sO+tYliWx9+ilboil5siifP1VOgwbMRaS/QNa2jKx1VQ07jcV98RyPqHNjY4rBen9BFoECP1R/g4rOsrARfNDfH73H22xEDUVtcJM0bo3yxehuP4NmdKvBYOmK+cEdKFTl5z2NpC5zqqQq63K/j4XH+Y4wtg9dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEKcN3xy2YqV9++i0bnnzbj3QzqZugAdNiU3AZ+xEwc=;
 b=fUwBUPYyNDERjwTqKGWvN0RmkfASSdDMavjSRoZWU9dLZsk2uZyusZv5GxLDdlkjudlIvWiYx1lFBbF2qodQLrozXl3kY11ZLY9bofhKA4wBxZqLmgSoMVocc8+i2bBR8Va7FXjt3NO4VwgEvCnf7qWab2ZjmAQV5Cv8ayKCTBgURVKitPsrZtC9ZIJhSDZhFN4JsETWLQq/z/DFEkwebD6Jzr6SKN5me6uPeloVZTHWHVOOmFdbZGqydRPB2mUMX997k37axGvYfKeWAeOqCi/mEEy99RWrlik8/ViX9mZzkou+ErJXmrmVOsvYjV5SefZNjC3u4A4WIsHahBPcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEKcN3xy2YqV9++i0bnnzbj3QzqZugAdNiU3AZ+xEwc=;
 b=rgfeyVVzUQDzBWargknAtcKUnN/7KZK9fVdVjx8o6Hp0fPm39+lkFrAWIfcB5uVPVF6j3+7dFmVZBwDGecjB7L0tvXJuHT9tsympD2nDGZRghrw9mu6iZXu7PiESe5cv+AFaXDGfjM/kFJrDeKyP8ku8S66OFkIytJyGQfCnEH4=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.15; Wed, 29 Oct 2025 07:31:31 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:80:cafe::a6) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 07:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 07:31:30 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 00:31:29 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 02/10] drm/amd/pm: remove smu response check
Date: Wed, 29 Oct 2025 15:31:00 +0800
Message-ID: <20251029073108.1698129-2-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029073108.1698129-1-ganglxie@amd.com>
References: <20251029073108.1698129-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcfcafa-9a7c-4910-d424-08de16bd2dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OjCYRQEfLPW77HDYwitTGr538u3D7ss5auzrr0la2TAnjdKDUsqV18QpzZDO?=
 =?us-ascii?Q?DofHDshIploqYILzC3j6+Ktqnzd6tRycBr2/ra0mAMMo3ScqioEo/qhWCX6T?=
 =?us-ascii?Q?D5OKfRxYU1fLpEEvKn4rckeDrGp3t1td2Fi56RF13F1bNzoA0METHfSYsYp7?=
 =?us-ascii?Q?INA5QgoTctYkdD7qzWF0l0LqJccWKqLrdewPskezhUgtDgKBtbuAdIMV4bsH?=
 =?us-ascii?Q?zmbCyjjM8GuG684yydhgRYm+6Z4ijXhXma2NhTQfyvCVi2LfEVgvnccOFutY?=
 =?us-ascii?Q?yqlekD7zo3EVfcv0Fg8sCXHfCxwEorW3gJjPmG/P1VHro9BDUwmhlSj44v4l?=
 =?us-ascii?Q?MuU7lHdAuKDailgyGruOtWKUItAMosrKb+oioZFZqK6aviBs4dVHp6dUKvQZ?=
 =?us-ascii?Q?NcaKM/UE0oxF/Ll54a7Jd6JQvE5m1wKR5Kii2rU1m3EH6rPIuQouxogtuNZ3?=
 =?us-ascii?Q?tFEHZUiK9UlMQ6xeJ6ZJeT05Jrbd+MwbQvNvWlAjYvsf4c9WUZzZMFNidxOW?=
 =?us-ascii?Q?83BAoJN2bzgBTtsd1ZSUwvFN39bdOhTvVJXKAf1+bZLOagPkIVUFXqY7Wqa+?=
 =?us-ascii?Q?NuavP8BAd58NuXhatTrnVg2zH2fVsA+DyJkJQgYo+z38CxSIdY2ARPkV1ITT?=
 =?us-ascii?Q?jHfjJDXUCf8vxeYqOWYra2jRmC+u2P/rFbdAeITDN3gUxivD/rEbT/ubgsrM?=
 =?us-ascii?Q?NG2FkEaQVC5pwKtvaJm4c11ZNNK5kYitWP34NiHgxFQPznHnCn+VacnBDxtS?=
 =?us-ascii?Q?WSiPSp1yl2e66lN68bjvhWjXWAqjVAP3P/b3ltlku1nX+2ItvrIy+AzOtGuB?=
 =?us-ascii?Q?2Zvs2ba+rQUCycK2Qg7DBhzF4NaIHNbMNIfM7MtTY9WwPaTJuam5uHg8cu8f?=
 =?us-ascii?Q?4bdl4f2VRgws4JXy8n4xkxLV9WiMreHP1o7qRvgwjhIM01hdOwOyX+F/hCJ6?=
 =?us-ascii?Q?wRdKQEyyqPveAllWHmRlOy+vRoTU8reOPSNA+YYN5DGlrwHu1gGlVb53aH1s?=
 =?us-ascii?Q?tv2a6BBFCdznbcxDDtzn5hygHq9Q5jjrqiIacTiriNuZ20nOMETvycnQAVD4?=
 =?us-ascii?Q?+sMh+FJvjABBhi7CKv5q9HsY/D32LIdq+EeLzYVvIIPe04FOV2AapeQRc2nI?=
 =?us-ascii?Q?Kyk6xaqa9jqhrbMtzwFm583lnLFWjaFcqeTtrGXUBL1A88ukVad+Ybl65JSb?=
 =?us-ascii?Q?bDXcHrwKiQ1ayZjGHzEALEqns3esxmcFRVDUsSe7l42fjL3+zKixFGQq2png?=
 =?us-ascii?Q?3U1TmCxRasaL2P/LPsc9GaK7jb85unV8oxCRzsxRzCSb7awdOqrHfp1HvjO0?=
 =?us-ascii?Q?FwNCSa/kSNYFi/gCFMKTh4w8wlDzbRuYHcywMgWcsCCCi+JNTZAwmhWn+R1l?=
 =?us-ascii?Q?R3arMcEiDzsuGysZUoE0IpqF4tCHJ39vdl2ILjOUjulVIOXayZWDHK4arHgm?=
 =?us-ascii?Q?PCAPZRGXMW8WgqtN/jwUVB8nDLM7L8EXdw/XPyJnROFExXQMwEbvuggywOs5?=
 =?us-ascii?Q?Vp2ZvOBy+++W7ognNdz8lONzh4JhlCv4hg8CiRxjvD7OCMxKIq/rrxr6o/nk?=
 =?us-ascii?Q?jmJnrEMFG/e6c6AYpnc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:31:30.7656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcfcafa-9a7c-4910-d424-08de16bd2dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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

Remove switch entry for SMU_RESP_DEBUG_END to process it
in default entry as a generic error, because its meaning may
varies among different socs.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a8961a8f5c42..eea5ff69e5ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -168,10 +168,6 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 				    "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
 				    msg_index, param, message);
 		break;
-	case SMU_RESP_DEBUG_END:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm debugging!");
-		break;
 	case SMU_RESP_UNEXP:
 		if (amdgpu_device_bus_status_check(smu->adev)) {
 			/* print error immediately if device is off the bus */
-- 
2.34.1

