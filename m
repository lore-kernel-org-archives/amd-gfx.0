Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE39DC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986A110E6CF;
	Wed, 30 Jul 2025 19:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0eXP94ku";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242A210E6D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9yF5XJdH9snBL8xmIGGaBfeQgoX2gRFFh5mU/kpONPrWNLwUZnxpgf0bk7iMBfxPhclqDvfNV+knZ2wI8EK7zbQJnx7k1ui17J/tTM2wxz0cD7SKoxO64/BcsTx3IgqadNZ40IOnoqN8V8W/m1ehA8P2QZTAfFtDHmDwvGrn5nLSwqZ8+76aW9s211bCplqJyCwruH+D9u236VlNTHJ54tRcj4UiVCgSJSGVZzdHV3K9FGw8aPySNUgS/ns0Yr2idsPanJFDkYz/MZ8zqQW/nsnEVFW+STOYnEDZpvHGtGJd1NuTsuAc2n+VA16PDCUQ47vRcJD6QRdyIjtFCwvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0IhhhmtIp8QJCkGGJJ0NEcK4GAddLFkXZqb2zOAWMM=;
 b=jtgImw9I9EI4JAjxLaCd759bqapyImqlYrA/ukk8jQC3IU1xBGOy7z+bhJGc+mAMN8MlTMBOeeTgctufS/e+ch+yBsob/DJ7oMWxC5dp7py6DZB0RhDn2PIvMTiWsS0OxwATM3LWz537s0D8aeaVsKmPAtqJXQW/U2l/nejdDUXKhFcV+ac3oQvBkp+4F3rWwnNW5c2cozmFuYiMDgNPLuqemchjryITb1izrhieVAVhK4rLdI/jwuY9pokkfmHoSwyvn5TeA2+TQrqevncR5AYE9V2oGOOtpDROJTDPio2h6wfCfdWZdfQDX3ZvpNf548arpW03Kof8OuQxB2FqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0IhhhmtIp8QJCkGGJJ0NEcK4GAddLFkXZqb2zOAWMM=;
 b=0eXP94kuLFIvb8xHilzOT3GheYxRJBQv4yNzRYpXd5dI4eT/Q1D0Tmd+xGlJ5SElmL/MHzNWDrIboHsXzSi1Vp4FruF6KOqp7ZoLir/R3TvUdwq9Jy7z747NPGG8cgvqoDZjXukGX3Q4nYa530iSdxLjTS6JTB/ZWMfLEsY7ljg=
Received: from BN9PR03CA0157.namprd03.prod.outlook.com (2603:10b6:408:f4::12)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:02:38 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::e7) by BN9PR03CA0157.outlook.office365.com
 (2603:10b6:408:f4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 19:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:02:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:05 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:01:04 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 12/12] drm/amd/display: Promote DC to 3.2.344
Date: Wed, 30 Jul 2025 14:59:03 -0400
Message-ID: <20250730185903.1023256-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e49511-98ce-450b-99a6-08ddcf9ba634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zbhu6O2ADvEWnQf/dcLHYLF8Fz67PhZRIuCACYA+Ep/OeroWpcBbPooMOryP?=
 =?us-ascii?Q?d/xq1LwM3o5ZpJapiF98JNVm28n6tHT/TVcL8DIGCPjuf3+9AgNiSv04vZZp?=
 =?us-ascii?Q?pNZOYZN7DtNDppnI6MYNgrASVeNmr0bWKSPtOhSNlPun5dwVnEjj70XGYQJf?=
 =?us-ascii?Q?5m+5gl0OOCbC6d1VPS4uOX3GtqGDz/nGbDwXyigzTqXzULeSTBjrIhkOsxCi?=
 =?us-ascii?Q?cyAgrzhp/sZ0xUvDG6SAu6N6mSkmuiyHuaRObxaHIsJyplSJLIX9nEydrKLq?=
 =?us-ascii?Q?oOF5XNlLmTRpo9Xeorp0LbKrJn6qsULyh1u1B1GjEno2MfAfLISHKXFSrE9C?=
 =?us-ascii?Q?FwnkQ1yG2rp6sj5DiBLrtb9gwj5vhNOXCpOEvV2dc17noFtQkuLE/wjwSqup?=
 =?us-ascii?Q?N73TDk8ttDI18/M34UAt91JatAQi/wQvOJrYQN4ru7HkBZ/kefJJd9pDI/k1?=
 =?us-ascii?Q?0Czl/AyI9y/X1ffQgIzSNCwHZR/pfpSelcMbccasdbLBxHYNS3WPni112wq0?=
 =?us-ascii?Q?QrVz2s2OcOrqgK+lwbYf9kU1xkjnH8+r2o56nUn+oAAuICtvJ5+Of7lauhnX?=
 =?us-ascii?Q?5c6SvmhL2alsde7WwTCXFUZnKoaMAfs1K47yo/0NDM68RUgqTI29Ew+Moqj5?=
 =?us-ascii?Q?XVJTjKOAadKIOPEbizwAU++Mwpt5WbSZDm7Ob5MMfdC+3wzeswdvalIFQML4?=
 =?us-ascii?Q?Ipe4WRXZzDayzW+hHpNJiSE1Kq7s7hZhoe2FyElYEbtFhvIyBq4cPTkka3qC?=
 =?us-ascii?Q?sw9QTZnLrFwYq08P9x9N5ZRs7yaqKsA4yg/nlF9IqHRAWHFTNfvUvVPXXfya?=
 =?us-ascii?Q?vDVQTLIjlWvCr0DZVfpS+E/8qCrbSJIOIl0M7RoTKWz47cIPNHHVWZhyzs4i?=
 =?us-ascii?Q?lAbBtAVoKxuzfDDnLBnPtBvK5ES5JRgvn9ayEhDAyZKG2z08Ze4mw33V+4Uc?=
 =?us-ascii?Q?EIbjdnEu6TWcAlY1G7CbAe39ifQyvKHXx2KLdqjxb3WUCESBC0O4GdKxeaZC?=
 =?us-ascii?Q?kbSgjdQwH5UZnU2sBXCysnDtodc1Ss67Y+7wLNqEO+d5HkNBPcqz//DZKjr0?=
 =?us-ascii?Q?J/yn0NmaN9l88nhLRw9pHxmR+FTo3oDGgHcl/PWQPt4UahYIKTzXXHFsQzi/?=
 =?us-ascii?Q?Qz2ZDoU2/MMWEBu0wJb7UmU+Snre/cGQQw9qy41g6/MgoUN0BAnQjsQKk4ER?=
 =?us-ascii?Q?KCqxX2+iyOeUaLg0cweimo43EeivAkIhmRGzjym95Qk9uuo23xgonhWMX9Ba?=
 =?us-ascii?Q?S45r5rX64HLcLyIr2xor8zOp+eueyiEZQqNNJGGFPhtriMQwNTO/qfP/RmMt?=
 =?us-ascii?Q?8SEWGbS72FQa64yhQ4li+m3C//isg70g9Afevy39Na9ch20b3KzuaoHUbvRc?=
 =?us-ascii?Q?NjHUwubcfDiqqbfIb2bTIi7nXEc8NmAULQ/LvZHwcaAYP86Q+Jdrte6kh3No?=
 =?us-ascii?Q?OAy9NvczBeN4KUADv8Y4baGuvcQUH+SJoZPln+eW3nixwETrinFOVBU50s4F?=
 =?us-ascii?Q?OJ0ywdyQHhiBKx7o4yEUc3l/Zx4cT8Q/rr7A?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:02:37.1387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e49511-98ce-450b-99a6-08ddcf9ba634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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

Summary:
* Add interface to log hw state when underflow happens
* Fix hubp programming of 3dlut fast load
* Avoid Read Remote DPCD Many Times
* More liberal vmin/vmax update for freesync
* Fix dmub access race condition

Acked-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b68fbdd73dca..18c68e531f71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.343"
+#define DC_VER "3.2.344"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

