Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16F7CCD184
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8751310E6DE;
	Wed, 15 Oct 2025 02:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqOJ28X6";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B986710E6DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDPaZw6cSQTauWZJlNiGdiFZWdI7raS008zz64amGBF9MCU/ZitcQjybm4BuGR/X5a4jL2rOuRbU/wGALsL4vF39pZqxnoJmWlmSpqk+pBrSlnB0esloXrBYngMXq4kFo2dJM5Cmq8fu/W6dNCpg8GvPkp5fA0Z2qgd9hEd71Eyg9Vkpb6Dizg+r0i0gOjPPJe/CEcev+bFUjKrT36xOKN/YQq1LIlFln9GY+elhyGWL6hyW0IuREAap7eAiKHJYMawYa+kZSKmp+Ufc1Fs/97iOul5kmXqVkuVy8m3A8dLJk4oV60bdHKiG4/F7Nmjq/0Peo9vVbruM4Qc3jGE52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2LcAwc5g9xcITAlJBrnHPR600/hzTiix2iKgJq+biA=;
 b=Vzcv0zwZRNhym9s2LIJsTETCJv5z2G9Dk1VlVASjjWivNDABaT4jgpczBSfv9aOoGkBwOSqdp+R83a14eUFnulDhsD+kLnImwmgr5NFfqVPEqL6ZRLrvvjl3wmEHyJE7ANMnSzYViys1ADzls27VKVl6Eh/4sNpEGSQPAT00B/YaPAc89sEfIwoXpuK/A4DuNc/o9RNerbIc5j+AMAV1+xqYb5oaHO7H5qQZnvN7sgGx359Q8PPUwi9dFbChql113NKA9+WAv/Vboo6AFQN8maaelRTqWZJhU7Nmh3p/fK3v48lHMQxgy7Qv/UNV8+bo+4/61r2lygANBxg8OQK0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2LcAwc5g9xcITAlJBrnHPR600/hzTiix2iKgJq+biA=;
 b=vqOJ28X6PzdEVMPZ+JKyGS50xQq8Vx0F+fi6eZn5bu5nfcmd836vonNJt4FTExWOntF6glvKGzNCE3jkoP4NepQ9oZCzTTH95EILsQO2fYqtajVqa8nVW5A6yAVSTS27Y1QeIN8oFCKGG10kFTtWDyBruykHcnIvWmfCxWftlOk=
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by DS4PR12MB9633.namprd12.prod.outlook.com (2603:10b6:8:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 02:59:29 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::c2) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 15 Oct 2025 02:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:59:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:59:06 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:59:03 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 8/8] drm/amd/display: Promote DC to 3.2.355
Date: Wed, 15 Oct 2025 10:57:09 +0800
Message-ID: <20251015025816.1542507-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS4PR12MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: be8dd8ba-7984-46ac-d991-08de0b96db79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UCMGEcP8nWy//Y5csPpnObb/CNcWXVNGxKFiNKmiUdM6werfMuoGKDjYJ03g?=
 =?us-ascii?Q?0MLU2gKrMtrF+qsOII0tGCitid2FW9Lk72q3iGgqzaMe70flygnaYpiTmox4?=
 =?us-ascii?Q?wnvUXJYg50NFxiYqF8PRqbzAiSsGP+wD88Ee4i6Zn5WTUL7Si3NXt+urP7MZ?=
 =?us-ascii?Q?ZNS4jkhSrib26viHUmQpkNVMRih86gYW/BQK5qAGrB/heHfobvGRTGBFqgR+?=
 =?us-ascii?Q?8y7kxO+cmo4kvKW2bsZQWgQs9MReu+4SsmYywcusqJbg84YTVVGkHOWlpN0c?=
 =?us-ascii?Q?T7m0wMK2wzF/hynjzhHmo4lk5vvNhrVIbg+RBEeTjCfdI38/ENgq+L8VP5Is?=
 =?us-ascii?Q?NF6SQiwGbYNc0p32TNr4hCiPbEMCAWOYK+o7un+VSY5PhpkrW0nsh++hZMBa?=
 =?us-ascii?Q?egJhVRDSpXJd8PR63A4xSDW9npQ5I3TefeaCFDv9gS1t0C/LPKNeHaOv25HI?=
 =?us-ascii?Q?BSiWVJFVw8Bwl6n0CD3CQvE2I+zW8csoG0D8ZP1sFRYMgfe5cMFrvS5JUiYA?=
 =?us-ascii?Q?rkjhAFXJTf8+/qHC6kpZCHBVrquUEqSL/oOQhbITRKIwCTfZF0oBXEppBZeh?=
 =?us-ascii?Q?rCcNcJAdZd2K/v30rcDIWSKwQtFsSeBMqTG5F1D/oOGuztGoXj8+r4b9TOCU?=
 =?us-ascii?Q?UOi2kSKFDbWTTFon6oeip63IuxqVuE4fiyv+bEBTGzLggZN2LDiBEAgCeDX0?=
 =?us-ascii?Q?82waQgjk3amP1nWJEBbgSJzV8uxKzMmxjDUqfG+fNInDdsJBK/upTh4H7O39?=
 =?us-ascii?Q?SuItvZ4VboNn9h6TU+uzAvepVCRAkPfEqTICVTn7ZpJ0lCvSDhlejnpq0J4q?=
 =?us-ascii?Q?6BMt0oNEC49/idUKfSfGy/Lx9AAZQR7wZJ7dL4cmED+kq0pM5QBxU+IP7/hg?=
 =?us-ascii?Q?Yj/jNh87YpNGfnXmoCYwkjE/mpQheJ1kQicwoLhtiagTgEMWOFj1Ycv7FXUe?=
 =?us-ascii?Q?+BEaTLIiPC+6kkxAW/Lw3BfgMmciwNT4WfC+z/3qVK5zey2xgpzALOyw68hs?=
 =?us-ascii?Q?0zONqscbAG8++2Sey+FuugtPh/TdN+iA8tcMh+VDSMLhQnyP+CcEQi9ob7DK?=
 =?us-ascii?Q?yzgkT6y0Ler3wOEQ/JtSwp7/GHzWOvpFzn0JCN94e2PZPvJBd1x87YSJqm7D?=
 =?us-ascii?Q?dbZxwCPI5exuv2Wmwi4anL6vAPKoDGfb6ZPHAEwEtvCV5yJQrBNAQYT3PGA5?=
 =?us-ascii?Q?bdmocJkX2idUcdQ/pl3Rsk7AgWIet4DimHfqWAz2BVWES6cWYh4JvNzF17oW?=
 =?us-ascii?Q?WXj0MDdNAtrcdXKaoHZCQmT9bm5Jk/lyXZ5E/lqWReFNsDe7Y7NgEtNAlEf3?=
 =?us-ascii?Q?W7JOMX0i4s2r3npLgP7ajzQaOUmOlAFVW6FjFzQCZAJTfdxdsK+q8PUOwETi?=
 =?us-ascii?Q?dIV4dBLxA7RlskrV3gEVyFZt20uuf/bXEondYybazLpNxzbQfI32o+7R5/62?=
 =?us-ascii?Q?UeKfFbhWTQxJLjlTKTDrXs0WF+CvSVSDlbBqnOGKEQ5BpnimJ1RBQ8qYyg2H?=
 =?us-ascii?Q?S1fzFdjTD2q3CyCKp3qcISSxKUbWCU6uJPO5LSF+vHWsgzOoL3MVMLMpnSXr?=
 =?us-ascii?Q?ypc+Jm8VFABbC94fN9A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:59:28.7051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8dd8ba-7984-46ac-d991-08de0b96db79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9633
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following update:

-Fix GFP_ATOMIC abuse
-Fix several checkpatch issues
-Set DCN32 to use update planes and stream version 3
-Write segment pointer with mot enabled for MST
-Control BW allocation in FW side
-Change clean dsc blocks condition in accelerated mode
-Check disable_fec flag before enabling FEC

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c661a0191c50..14fca9dfe272 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.354"
+#define DC_VER "3.2.355"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

