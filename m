Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B33BC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC3810E774;
	Wed, 26 Mar 2025 19:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2nVORocq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A76110E78F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZH6eVqkw5a+kBAcPoc4LvwrvS5FdOIT9bMce6NZt1F+akQfoq/474kSdNzIqpwU8LvwjYd4geWAGf45uj7O7i2SBID7Tx+wqQZ7OA17TiMmdbcwoKQeWy3tgihGJjZkRTdSkrNsge2of6ondY1ScjrmholGfDxZxGegH03t5OTfbvtM/Fn0IPKK2X/cF3EJA+MJUbNmVa0MXUlLn32u8RPh2DGd4CR8pPg99I7lnNVCNaWp/iBWrVqccvAEeFAnscRny4wwKMOms9Gj9qelv/SmSiLIgMKD5xoMYs2p058a8dDEncFkDTYxoYjexSRrQ2a+6phJcuggCfXbwfMh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwC9EjjVrOtvSqgE61P498pePaU4FSu6Dt7k2ySRChc=;
 b=vINQj+v/uZ1U0mL2LXE8c2ubaH6sGFq7XZXVJ0H+EO+Zpf4nGfLUMBM+HX1yB3swpLDMVF6UBct9V1y4MTXuk5LpfTBhlCj3oB81QUO42J4v0lCF43x1mKy2JtyjDuc0XcB5n6CPVOpaCe2dmstg5KA3AEUYrsXi42qhf0i9Msd/FRbvjy1nrsAQdfzJfz+4HqjR9iFUwTiYgiL2ZkXLHDIuB3nOz4h6PZWNaWYAOK0FMeXUG3Y8sJjyo0+3II6OQYJtbzP6ykBownCXnELgvIZRp24xVI2kU8QQVkP6qT9j9wLtFpIfszNdeqtvFSl8CrC0VhmfhBevHWB49N2vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwC9EjjVrOtvSqgE61P498pePaU4FSu6Dt7k2ySRChc=;
 b=2nVORocqcg2aKuMBVnMTBKE9bL9CgzB6zR+IRtPeNxwHTBHkE94opiuokLKyyfdLCxdHRhV5BnGnVCCP9I+z4YEcSfrqWSnng2WTKbNAe0c2vWedm7xINvduK8YXwTP0MobePeeJSoXevpWNdeNzklhiqhMQjA3aRrwaRPgO8Wo=
Received: from SA1PR05CA0003.namprd05.prod.outlook.com (2603:10b6:806:2d2::14)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:28 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::9f) by SA1PR05CA0003.outlook.office365.com
 (2603:10b6:806:2d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.26 via Frontend Transport; Wed,
 26 Mar 2025 19:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:23 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:22 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 17/17] drm/amd/display: Promote DAL to 3.2.327
Date: Wed, 26 Mar 2025 15:49:14 -0400
Message-ID: <20250326195202.17343-18-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a42ec28-e6cc-4395-3ec0-08dd6c9fe0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bDHJxJ4gkFWpBismzvOoOnvXVez1W2jn46CAHUWJzRdIppoI8fQe/bh4eg83?=
 =?us-ascii?Q?/cVxWTX5wtIMU8mNKTeVOpMDK6deSKfatLd3kxaQMtMwybFNmAAIR6uhl2Xb?=
 =?us-ascii?Q?kdKkarMK/J8SYrPJR2U6MbzFrNg/4OYvblVfb32qk/5k8Kdi6LoqCaoj9M3X?=
 =?us-ascii?Q?HI7vUc73m1yDf4elizwy45Uacf7+9F2dlJF8LzeNbEdfPUcspOiAXmnkV2p3?=
 =?us-ascii?Q?VXt2XseGifX/YAkB/p6Sh4fP8qckFgu5025nuDNlBdqZyaVjOP5zEnvBDK9P?=
 =?us-ascii?Q?7Zql9ZGMz2aTwydgnsjogV+I36y+gnXDsySIcBjkYRuqQTqEhNIEDXXzCAas?=
 =?us-ascii?Q?gQruPpwpCw6f87idv/mELWZCWABYmngXVtzJ0p7omkQhWLFchH/uWkLWznTY?=
 =?us-ascii?Q?OGB5GXKarDxxrAeJIHRHYki4nDGHcfN9l8Le3u8JwLy+K0Wucz/OK68qTuFe?=
 =?us-ascii?Q?dglaYgXyu9wTSegtYJNRMWW4Y4m+8EV0N2edw3QBLrL3j99yY7qtYfH2/l5/?=
 =?us-ascii?Q?cZfqOX1Sfwuk5rL40Ea+t9lQKMypIjsIH3K2xOzsYypIJXCuoRgffmOVBgq8?=
 =?us-ascii?Q?qNaW3xTQ/VG2JgYcMvtpCufsBUGHn8m0I72H7l+rAbxYuAvdsxOb2jzPFGhb?=
 =?us-ascii?Q?c/y+yhHFbQrMQob2ygqgUCz3FFS6pwNDDkYCQpbLGniXT3uPZtCQ7zOQMhLL?=
 =?us-ascii?Q?FoY7Y6Uce9M93/UBHAMTWqIG/hscedFlEsz1MCzwkL99BB47W1+cul4dzG3D?=
 =?us-ascii?Q?SJpPpGnqjoiF7qewBWPdTuZ1xq8RKmqg7hQbknhaqIFwGl52Rcu4gzOJz2by?=
 =?us-ascii?Q?rMQ/qEZKz6/Le5YMX3nIPhKTTScWP/tp987SNoT2xcTLxvk5QgGsH6mjf+Rj?=
 =?us-ascii?Q?vnrqKDcCmDTXuBgK90X7u6sG3APmJaafFGHHEKJWHpozxIvjXG06lSUukKOw?=
 =?us-ascii?Q?T5SWD+GgGRnR7bITpmBfJymlO+nM2qR/MbFVbrAFplr/cfJ7rLNKIgDWV7de?=
 =?us-ascii?Q?TQpYnQcy7AB7/DI4RbXJUyK/M0nXoWl/K8fuhrdHvX60MRRfCh1EmVCIJz9N?=
 =?us-ascii?Q?GDYkPMIzoRdTMNTX8OBP4ZXAsVB+6lvWrNBeCv6v63r0luQJ7XdsRj3CmLIu?=
 =?us-ascii?Q?bVu2BOKoFM7ouqrrfPs44qMPHkkM2ta5W1u+PXnRb/oaQxF6U5CbwvqhCOzZ?=
 =?us-ascii?Q?kpGWrlIzs56HqtNGKpk/oX57RJ478PpmXVnQdNFwoxxd3FvJR5XdrLOe101b?=
 =?us-ascii?Q?Ou7LCztDga+3xCdTwn8AMQ1P7O+Q8EjQ1yEagW2QDzKzhxEPiP0MJdLLA/w3?=
 =?us-ascii?Q?LIL1qU1KrhwHID02vxZz64FpJkH+V3PkpudJv+Y7m6NrReM8Sih+oVYDFoAN?=
 =?us-ascii?Q?XTspJ22MJP31M/T1yhE1bWWcDo88yH9jDWB7XknW55SBBUlRMlVvO9L7nC4h?=
 =?us-ascii?Q?4Kymi984/wiRDR0SzpE4kLXo+Im9zsFGW5X0HLTWuDbHbRZ3Fp8k75oYOP1T?=
 =?us-ascii?Q?qpSEZHif1JvLrVI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:28.4679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a42ec28-e6cc-4395-3ec0-08dd6c9fe0e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
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

Summary:

* Improve vrr for replay and psr
* Rewrite drm debug message
* Fix clock issues for dcn32 and dcn401
* Fix mst dsc mode validation issue

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0e98af9fb9e1..a24d004f8b57 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.326"
+#define DC_VER "3.2.327"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

