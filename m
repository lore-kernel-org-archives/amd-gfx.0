Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25259E7E0B2
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 09:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC4B10E343;
	Mon,  9 Feb 2026 09:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5rhOkRxz";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E1310E3A2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 09:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AE4j5mzaUi0FZ+0cDl8NIP4BhvUgMPer20YFJNgRgytPrLEstTH/uKXODCxYn6OPljLc2XsPJbkdohPiVdUOcFcZcME0RR8IlYqTJe56KYr6ceUOgch2CYq0feLICgcZaylilYgw+W1Nid/CaRCxvC5KAHEuAnzDTwyd5e8QEtK3fJrOoy/bqelf05eN7obIN3P56nfHyBDC/rZcCwFFw1mjWIZwr0nDvJzmW6pcIL9VdjSlOMitpYemqvHaxQbrksrZUV446a3QYzw70el9DTD4qlc7ntNCOIGyITvyzfm6mGtMQKj/1OgYibYlXz9xBPBTRVmEQKckL3iodcwXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXUKcE0U9i5sQn3PKQaDvJ5l+uJNQhA+Yr6h9n4W5OE=;
 b=e1vFkRW114BB/0xtUx+XVeET+K8wstlh88Fjwq/qxJpmEph71Mhe5gMYUdM+ex3q/864QHSrbwsPtgiN2LZeyrGlMC8RqKECsvKO5zYigvQSth5MieBXktikDDmaObpQ05Zn01bGMAnOPeqvBKngwHknMlaUSlUZpRNkl0WYL1ezSCZu+SoLlpt1gib3dOYOXqgr/FaTYQLxy3p/mcmYIJnZLpnn3jAUV4S/9BgA8X8LLyVFObucwza1gP9LApMtMZ1C/Af67mw8NuNQr2hrSW6A8Uk+BywsQBcdH6I8fsygW0RcIt4Olk1laOhQmkkd76Og/4jrbRIPxDBvgH66Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXUKcE0U9i5sQn3PKQaDvJ5l+uJNQhA+Yr6h9n4W5OE=;
 b=5rhOkRxzW8IObedyOYVSlExnGCwJfJNYcc7l/HHtU04fCaqCiK6bCHNKMvcunfFtmOxb1+DlegKHLiO/GfD/uSjhx2rvQGMAv06j8QrEfqSSl54VCSqUEH/3rekfB0ZiAFLasgaCuXkFud8MfDbZCf6b/n910DEmzq6AkVbNCpE=
Received: from MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:35:59 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::3c) by MN2PR15CA0055.outlook.office365.com
 (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 09:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 09:35:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 03:35:58 -0600
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb10.amd.com (10.181.42.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 9 Feb 2026 03:35:57 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: return when ras table checksum is error
Date: Mon, 9 Feb 2026 17:35:43 +0800
Message-ID: <20260209093543.1341791-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb10.amd.com
 (10.181.42.219)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: aa41a725-7a54-4f41-9cd0-08de67bea1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HUVQxZ7FIihCVrKcXJWZcQitZDDST7rfeY0uKjyOvtwT1nsbV3GRCfJdlyM2?=
 =?us-ascii?Q?ZydDtIjxfrxItacvXZStnLAox/pl+rDCWNsGrZOOnFxmvuLLrgb4TbMcwHiK?=
 =?us-ascii?Q?rZATH0nQ3Hv+HpfRvStSl6R76h4M1bmOVpHUpzSkLeh+Gd3IupWOH4XCfnA4?=
 =?us-ascii?Q?QWArqv4GqxCohRxidbxkBdgukZkcqAbe2iOpq3GFd0ZDhdeHbsdGtFRSTU13?=
 =?us-ascii?Q?IANmahT7qQzvY7WK4JiCJgE3vbSmcRrSbhPcd5XgxU4ao2W6GZFdBIoSWS0A?=
 =?us-ascii?Q?zqqS3TvswxWL/RrnPK/LZ6yprVQlKDEyTKPRKnLPCmLrrjVXbrM+P9wAm6Jb?=
 =?us-ascii?Q?zrgWtRS6JRRK1aA4iOvgS4bme5c0CqcjZA3k4g30uCJVNmHTnuZmftycVQcI?=
 =?us-ascii?Q?YmM5oCokocCkDyGJ+/w5zJImz6oKswy6KEPZpWx02qUkZbKOLArF3PqlgUN7?=
 =?us-ascii?Q?voGq/6IcNy6wgppCvCNINZNkET++LZoswLyK5LraL+vXXa+djE+ww/PkDi3A?=
 =?us-ascii?Q?OofLogZsWuIsYdsgaXBa3iOuVklB+4m4vUwZ6D04Qq5H6hcuqrGVEiJB1b/j?=
 =?us-ascii?Q?5xuCUPfuY/eCnQCgmILzgmuZ04AGI8PzXnSsEE+GKTmmRRih76OipF3sn7TF?=
 =?us-ascii?Q?s7zMFMrqQL1Yeq2p8gsDufAwUOrrLxyZv6JXsh+6skAH8D5WoCNDEhaGut4J?=
 =?us-ascii?Q?fIYBlZ8WTqHfS0ZunMPPFwpb3kG+1r5ifLNAZNDaiCYMSCNKIAPlP3ESwj9G?=
 =?us-ascii?Q?8bkthvmEVIxdYV/L5huueFmR0VdZP9oc0FAhxiiMDeMvgSAh7TDcYbJBO/cb?=
 =?us-ascii?Q?l/10S9fguZKAQtFR2n6iPvoGvenQA0n4uVSfNHZnFdkMTkjJKPT6M6NK9Igf?=
 =?us-ascii?Q?T0P3vmuxs0AXqyp1y8XzZPcBCddUO1rN6yEuoz20ZO4jazm65Tfc9I3VlYqO?=
 =?us-ascii?Q?hL/OQeDSauakMuA/GJBi8aPfm/aMT2+sHXM6AUVvIVNXhpWDwhZSalklaoEj?=
 =?us-ascii?Q?pbDnJJOCznqfTHw6Sg3Q4pj7fY/ylrWpeyGomSAcOhm0JJTHSJ/2YMWmlTP6?=
 =?us-ascii?Q?uADITh/fV2NsK7PpR4QHWm0p/kBmzv/mqbxVvl/gvNwBv8EpUZTUcANpvRgl?=
 =?us-ascii?Q?CVnRu4rAnCNv4x7hbPGAS1tHoSZ9YvsBshTVrXfLwxuZGhEaem9LXjNYwI2P?=
 =?us-ascii?Q?nKu/OFqxbMfNrt3bMSpl5OoCh00lTjFqCLnEri49xjX4QYXZBhLygFtdZdsO?=
 =?us-ascii?Q?gaXbSLXCOGmkL6r67xyiiOQD+DSDMsg+n7fRJm94M3EhPV0gIyYV9BLq9Ol9?=
 =?us-ascii?Q?CRGWfArhc2i+XE563Kln5PYZsafjwZFTWhAizu//kjIgLjykrXUiwIs6HEqX?=
 =?us-ascii?Q?IpMxbXWDFan0YqVhAMJDOaOQg+DFUEwcDc0zrRGao8ywqrjyvqL5I++MPDFw?=
 =?us-ascii?Q?dnUHDug8LcjeeVFmADxATI7yK24NvwxfEsTr8aFpwt5aINUKAW2Q7cmChvWx?=
 =?us-ascii?Q?h2WvHHVX1Z8rKbtiTq1rwh+WlB4x/RvJEWfQRY8v3iBYHhs1Fl4yyxwyXXbN?=
 =?us-ascii?Q?8WrHGEkyAgkRGFtQUG1HuZazkoL7yXs5hFci9TM7ChVhw4gEcft6DRw96U1l?=
 =?us-ascii?Q?17J4Dx78n3tziT+NvDSkzVXTB7SFgUI2KRtJF2ru+O39sgV5Iorz9sqhe39a?=
 =?us-ascii?Q?W4okAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1lDKmisuSzqbavz7d4a0h4HGzLlBxM7Be+sSVo+kFe3ARCTtauT1n7+jRGV7NHEdMevw2LaI5sAU+bEq4DzfsZTmDMF7f7xiOyxIf8P5gFDG1m5ud1buWJ7/dhBvTjdkekP5ZdEDXbPP/BGLZRcB2CLHQDNleTpJvBa3VD2ligzqLUc6GXTVZVHvceB6re6ohszv85iDWKUW8wP9TN40F0xPZxIVXeRV+dVbGjtMmk7dxqaQsPQqaBz8gPPQ1+r9SNH1lHFTfRL4boaXUjkXCH08jzbe933I/sImmWYtWbXX0JtxqPotNEBaSzw1xjc6b7TuKCVJpjYl3fYwhR+g6b4+AodYNA3IJVpcCGnxO99LTDMDKlD/Okh3xPqI5hC4T99dAyfxsmUMcX8vQ8AvRTfXZc5ltwcyPEh68wWRRAIcevoRN0RaXOx+lNuTYPCY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 09:35:59.0199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa41a725-7a54-4f41-9cd0-08de67bea1e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

end the function flow when ras table checksum is error

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2c5d7f87e593..6fba9d5b29ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1701,10 +1701,12 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 		}
 
 		res = __verify_ras_table_checksum(control);
-		if (res)
+		if (res) {
 			dev_err(adev->dev,
 				"RAS table incorrect checksum or error:%d\n",
 				res);
+			return -EINVAL;
+		}
 
 		/* Warn if we are at 90% of the threshold or above
 		 */
-- 
2.34.1

