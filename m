Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C41C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9263510E8CD;
	Wed, 10 Jul 2024 19:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AQ3EVheu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC1710E8D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfYOpz3yAVTIWNgwBJo++W7YUNVIi/SFVaOaksekXDg2G2JqaCm4FTYxBHPrRI68LvJ0tiugL+PO4JEbD3CTc2Qe76s8AnkmqOdt5dyIuRayjIEiecifGVAXi/hAcib0yhPoNyVeT/hEsHXQ35m5dUv+WdDpBQ6uRRZ1mZFLK4rZbtEfdAu8oWRue5XITWjMUQXPdyhpRPO5Dc+8e9bi5m8xbVBE7VElj99lotrJEKYfB6T6ePEYBgVaJOILK6WZVT9iN7vUusF+a3pxj0rxe11wo58bhfRPiOBI3jmTNBMNyEzqPVM7qgtyE0FtWZxwxPH5ToGD4/kN49CIxftZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGj5FqFl+ZrM8/R96av6Mm/bJ46eXdrRRbH0p3n2DuU=;
 b=MvZ4WvLUW3NkoY+8N73Oy6I0QQr1FQH4WTkw1qCcWspNKnYBh3PtaZgiKlD4uQ5Lbir4wwB/5mSQVOvdBe6qGUZu/TJhHb+dQmJJEFcO1x4JlEvIYWx6nt8/CqUhHShaXVlE2RCMIEk7aT3VFS0NxTGd3tG13m9fLwQZJgzJTolemTPFTgLrKo3/DtJRAchMUpRQASoZTCDdrYXGXirndFXRaVwAJ79OUh84MHZh7dJKtyE6NEkMg936wWdrw7bHA0bgb/SUbZXyxuMKNBcZdf9kSl/MKWXebktMDXCog5ZlRdgjzTUvt9Qo3QUrS+STu8ilb/QSQqmyUOXkt7FZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGj5FqFl+ZrM8/R96av6Mm/bJ46eXdrRRbH0p3n2DuU=;
 b=AQ3EVheuUYTknEKKUKLjb+iwsAHyzXJjpjzutSAKnCan1ZUGoREty2IWznJePNrMfwR+A3MdABC3RC7wLV76LU8kh24DYwfgrqFcDiO0CTA7wTwjC0nb+UhwienxN9Y/H0QLHc2y2AkXHUjuXW/Z80yCOykOsK4oVNUdq3K12tw=
Received: from PH7PR17CA0065.namprd17.prod.outlook.com (2603:10b6:510:325::9)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:41:04 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::71) by PH7PR17CA0065.outlook.office365.com
 (2603:10b6:510:325::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:41:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:41:02 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:57 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 50/50] drm/amd/display: 3.2.292
Date: Wed, 10 Jul 2024 15:37:07 -0400
Message-ID: <20240710193707.43754-51-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 8409aaeb-5698-4e7d-cf7a-08dca1183c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7tKyU3+TaNgvKoosTBkjNb9kOXjeeusZBvxNgNY9yhU+u5l0h1S9mxFrKzlL?=
 =?us-ascii?Q?isTI8hQ+Do/H+Z/b01G92j9fJIxJ8eJSj9EnawSssXVVmm8xLbujBwDmswlM?=
 =?us-ascii?Q?uBrsnf7+1u1VKAxxJaMTm1imgo8DCpUKzwU9p6iS1UHhFmTdbmwYd4uXWLzq?=
 =?us-ascii?Q?DVnw8R3koynkcdu73kG6xoZeFJ/tpQSQjDQGCl//YMb7jzcGt/bEVGoWFCH1?=
 =?us-ascii?Q?JzWu1KpuhKt8aG7IaEOuuVpyK/0G0cD+pSzQXvchfs6PkSfiZeMuf17SJQv9?=
 =?us-ascii?Q?pDZ7vPyQXYMJc9GanBEfDLmUyuB4nGiKk33hM6YXJ9Rcztyb1ht4lRPI4zn0?=
 =?us-ascii?Q?5OY5agrl77Z3ANrQL4ko/S+Yt6MxeLQ90msIGg+V7doV3b1Q8mlcZmplkYGF?=
 =?us-ascii?Q?+lcg65uggK1BSKEOGNp5MEyCqgBzy021y5+g3Go1AgOjjpspa2C1Lm9FvZw7?=
 =?us-ascii?Q?5lnbX8DG8f/hZ8YRASsJaVt+ZuY6J+yDEPgMuZYp4OG8+A3tYdhKTKFm5dAC?=
 =?us-ascii?Q?SIH5iag/QNB5FGfdoNz3NFSPvja/CIenpsvHvoglV/4oLptaGM2JbT4k27/E?=
 =?us-ascii?Q?/clrQhz3PcY96ZFj0OvtSlMBIcezHMj6u92L+q/ua/xtUITuvxcXmUuoRHRy?=
 =?us-ascii?Q?9znNK39rgsBaeI638dvWu/92aVCLa1Wjs5aZMMGAwqunuvMdH4RubNGFX4iR?=
 =?us-ascii?Q?Wocg/ZUwa2fBrlq+hjtNQ+CDRrV4Skr9vM82FXXDjeLUMMV9dbS/M5Hwk/ma?=
 =?us-ascii?Q?gkfEIK9pv8QmKZdFyhGFAUiOxgZTz1EdcYaeW8S8bD8XydP4XdjBUljK7Pwj?=
 =?us-ascii?Q?HbsZ/BHHthZenHrI60c3EfMCC5Y2/Lhi7s+NkSsFARNonP/XK0z5WMKzJ29d?=
 =?us-ascii?Q?qWKvIempjGWRB5XJYWwTuR0ebkgYoayHtLEKx+Kp99mjemnffCkrV47R67YW?=
 =?us-ascii?Q?B/aqQcNPvwugygdLzJhoG99bEJM2xdEWOd0nw5tCbuUjl6lwbDzdCtpCajpY?=
 =?us-ascii?Q?4ueRJxvR5qRMvJDlFLrP6p23o7+sVbbJDFTsYXzY8poGhBw7UWnhiy5grWzm?=
 =?us-ascii?Q?czHgWRKVrFFpiHmRdSe1FFlTykewGQudd5TXyJjPccl9SM+vWF3TAIVApHD5?=
 =?us-ascii?Q?GyLoIQGQ66fuqjsuNJin8paHxd6gQw2mVQCPT11G/FpjNg85STg/bb6R0wxv?=
 =?us-ascii?Q?jQW4cn/JEzySw82x9PNJqtXNS16lFW0IhNOy5uktH4+G0sPZ4OnnQn3WLbX3?=
 =?us-ascii?Q?zSRNTbHzBQ0eNgtV/nLw6fc8jkzqWte6Q88KhxMW+9eBQaDoEYzNe4RjJvvY?=
 =?us-ascii?Q?koVqyn1V0yeDe3SG9anLHP/yDD05ZH7ykTUYALQhTArhZE/fDXJlsFaluMvy?=
 =?us-ascii?Q?lTOQzID2OwsWg7LD1Dlj4vZCOmKpRqa3uYfZeGtPH8PwUoCHQHRlwMHiqDsm?=
 =?us-ascii?Q?vhAQfkRoKoL1Z44g3krnXdjWcXNRggeW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:41:03.9999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8409aaeb-5698-4e7d-cf7a-08dca1183c4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

From: Aric Cyr <aric.cyr@amd.com>

* FW Release 0.0.225.0
* DML2 fixes
* Re-enable panel replay feature
* Allow display DCC for DCN401
* Refactor DWB, OPP, MPC, MMHUBBUB
* Fix dscclk Programming issue on DCN401

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9d4b821ab219..036b23a6e324 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.291"
+#define DC_VER "3.2.292"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

