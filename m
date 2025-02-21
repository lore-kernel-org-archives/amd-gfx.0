Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7B7C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A630410EAD9;
	Fri, 21 Feb 2025 16:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kz0fqW36";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C08010EAD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mssonZED19u8cEJlEa15u2JxDi1Fvzm9zqKCSR4jdxF9KrfbfWDy/7R99oeF9Nhae8szZUiQMc2eqHj7d71hFKMz2sZDNrS2tBNbbBnbcMxHNSyw7siO8wGrZddPU/sXNJ3MJr0tOT72BcIOBvslYU/Ft1HDhlNhsi5zp3PnV1vG5dwcEnuQ3b6YbwhdT+Ckep0KLnYO+Ce5Jncy1JdriL7tI9KgnTJsEbGY1zdf1DBr4wqEhLCTkKg2daXZELmGHYidOek0PPvl4aywK6mGXq6PuPTLvHpsEhKpWrzmMIw6Kr7oOhCTHUTVb6l0JYhYbEmBKa9ijVtqbSzrbA4CJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaFzVadW9edi5acaWsMFfIVs4IkIQOq5gtpeqyj/ty0=;
 b=ANsWizqDR75IFBLQTbWLfI/T1SfHOtjnHZIU3a4inD3xjGmivKuT1H9zMFtEainGF3gbjVLccGx8Elx6l12brJvr9CIp5MBOsWwJXn5Z5KVLrT+XUUAnZLdURtP5rKOAkLHK2IR7+QEd8N5HyB2mZYuCz9CO4RCoL6uxOa2UkCMh3bBSz2zUtruyCuk+pRAlF4MDhA8Arr06rBli5e1+jRDlOGrQRxhUWt3GzYp4Br+0XqwdLQvqXGnx9P7Kn6dJH+OaJPAMoaDh31RV1aIRLzdDP794ulZc0xVYQYCjdaf/DeB9yWrjoFBN8EqW6vdKbMvvF9hu0o+0mKx1HnmY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaFzVadW9edi5acaWsMFfIVs4IkIQOq5gtpeqyj/ty0=;
 b=Kz0fqW36ylCfrYscKWxf86T7FtZLHuW6/GTmVSzwmLOE+a0jowUShmSzWaRNXz1ny5mbiemmIw4GWn1qcCl5B7no5pphcaxX/gP1JO+VxK8fH+nyoV/YwLVlLdtOZi3jpSbZy7DJI+pkSS2TOa7d0gqPkP7iPIi12XYq6AaEf9Y=
Received: from PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::24)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 16:02:16 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::ee) by PH7P220CA0040.outlook.office365.com
 (2603:10b6:510:32b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 16:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:15 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:06 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Fix mismatch type comparison in
 custom_float
Date: Fri, 21 Feb 2025 11:01:26 -0500
Message-ID: <20250221160145.1730752-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: 4153750b-a02b-459d-d66a-08dd52911c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JQ1KwmceW1nWFMdNH+X1XTEglPze75nZ8wq1p1Oua/Hv0GWorh4eDM9TZJb7?=
 =?us-ascii?Q?9ZIEndCV2tFhbBJjN1voyC1OGko1of7VFioj5xZN4XdMm6AUPA5MP1z50BZw?=
 =?us-ascii?Q?0bLcUfveaBNRHJK5IGRPZO1rxtghd8NPtvPD3okrXhEqnHTbRCjJRYcCwPxH?=
 =?us-ascii?Q?nYaEJ3LayEQL4MOKqY+FoSnPqL4Bm5SVRnKdThEmmnPORQAjfphJMB/gLECl?=
 =?us-ascii?Q?h4QaU4Iyir7cGOXo/87bKA4hibDtp+kh8WYeIpQR5hv5py+jb6ZqR+W2mmLw?=
 =?us-ascii?Q?08ANu8DEJ10/bOzDRgh5JwK4jg8wNvMQPuDVrD3lGsOCeW+oBKj0Q3ZrB2ul?=
 =?us-ascii?Q?OojoLsN/KlyT5TTzrdyDpONoR6zcRFqBIbmCSIC7jzkUI1PQ1HrlwOX+wCbE?=
 =?us-ascii?Q?bNvLPocuyamR1YpiTkobxD65mmcwgNbjn5GgBnY9pv0mTyzWvJqChD0a1nUO?=
 =?us-ascii?Q?IF/Cu0S/gnReqbg5nYRfVcyV1f/qGZ1DF2Hh2T3irdtsAaS2pL4XdblPoGT4?=
 =?us-ascii?Q?OAqybX3DI3WN7YFgF2EgWTADMtctdRDCAoMUWdG/hzuCzn9BKOOfRMeQSR5o?=
 =?us-ascii?Q?60nn4wp48kmDQvL5prT+jagPlyEKbbHapfpCy+U5XyzrFuwkTAX9gFanueXo?=
 =?us-ascii?Q?b73iDzS+fDPNSiOpsvFy7wmBXhxDNTjIX7qH/xIv0FxIampcPdUwzE4wdEOX?=
 =?us-ascii?Q?votC/EHFX3kfqWwAm8nCx6I9UExJ5E9R+jVz60x0K8Q7FTJ+zJA5FD0SPP+l?=
 =?us-ascii?Q?qzx4KwY6H46tHOlQN9Hu7tG9bEh4BkCiL12yd7oV/rJGL+P5m/YWF04MybZ3?=
 =?us-ascii?Q?eTK6XcyHRr9iGT+YnqbdV0VCd5berIizW9qsaxoHNqIZ18pv08aN0Imo674C?=
 =?us-ascii?Q?9GD8rMoOk9COjX6W+rNmBM+7bijEwszn84M/cc4AxctS8RhepX9vnlk1qA0+?=
 =?us-ascii?Q?4ZJp7JygydGy5s7nT4R6h3t3/pTFLgnbA1aqfVE8fjK268SUAgcxDVuipsWT?=
 =?us-ascii?Q?gCjAT2SHt2wPVaNe9I7SLF6ibhrFoz5EzzZiojx6DdNxR3YmRdCWsxI6rYFN?=
 =?us-ascii?Q?3wJ91FjqXW8MYXKlN3n/yjUrTXN1ZbYLH/3I1xC/YWxeUhOE/AivdOtvLZ1k?=
 =?us-ascii?Q?ezMAE9Gq75sAtM5+PrC3HDhGt9ii9uCT7IkpQjdi9pNjhs6JOKIezZLPsSv5?=
 =?us-ascii?Q?SJO5qTIAUSAte71SG4Dh/CBqorw0O8c1l+ctiBmq93THSzFLiLmFm+ULr3r8?=
 =?us-ascii?Q?OTpGWbLT147NtLUomzVWmecGWddvEDYN7JKdPXoIY8eRP74kkgGzvxNtOASJ?=
 =?us-ascii?Q?N1UGd06xwQ8CAD6VGJGmCKvfhm6AoPUcLeR5yP9vbrNWwrqyIxzU1Iho2Zw/?=
 =?us-ascii?Q?fmwWwq164693aEHXS5x2vBnFsfb40UDAUoXmCUgqKwaO8CcXR1JWxm3esIgo?=
 =?us-ascii?Q?dpPEdGCjXoogeZN5/ipmzJuP8nPku4trce0qTYo6nPqInecHh3kWmNxuF5oc?=
 =?us-ascii?Q?8WhUAwF3OLkZUww=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:15.3489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4153750b-a02b-459d-d66a-08dd52911c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Passing uint into uchar function param.  Pass uint instead

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c | 2 +-
 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
index 131f1e3949d3..52d97918a3bd 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
@@ -346,7 +346,7 @@ struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg)
 		if (m > 0)
 			return spl_fixpt_shl(
 				spl_fixed31_32_exp_from_taylor_series(r),
-				(unsigned char)m);
+				(unsigned int)m);
 		else
 			return spl_fixpt_div_int(
 				spl_fixed31_32_exp_from_taylor_series(r),
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
index ed2647f9a099..9f349ffe9148 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
@@ -189,7 +189,7 @@ static inline struct spl_fixed31_32 spl_fixpt_clamp(
  * @brief
  * result = arg << shift
  */
-static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned char shift)
+static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned int shift)
 {
 	SPL_ASSERT(((arg.value >= 0) && (arg.value <= LLONG_MAX >> shift)) ||
 		((arg.value < 0) && (arg.value >= ~(LLONG_MAX >> shift))));
@@ -203,7 +203,7 @@ static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, uns
  * @brief
  * result = arg >> shift
  */
-static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned char shift)
+static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned int shift)
 {
 	bool negative = arg.value < 0;
 
-- 
2.34.1

