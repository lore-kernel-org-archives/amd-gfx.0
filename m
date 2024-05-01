Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E7CC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 20:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27FBB10E473;
	Wed,  1 May 2024 20:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KajBxFCC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA60610E473
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 20:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT9UpUg2069B2nEOMIp1B91JWRracWFnw7usq3Hq3d5KOURp4i2O1uukaWD0pSItdnB58Bdij59q8G6ChVPv5rAnTUPTxUPT/2wtq4mESF33OdvZDOLdXrn2bZhFfW2dQNB8dn23xx9CiXwPrh0duurq4/vjF0ke0qG+Gowigib/IkFkMl5akMW+3MRGxgikZkLZgAxuE1ojr2A/Wv5iZPgRYef85dkR/LoP3+M5lcrFVA++zMNCE5OtrI7BYa5lqdeG4+fy+IbAoMiYXX4O6RbLMg9pM2s5910y5fdOIokVxuL7xUNpT2ofk5o42W3Ajm3GkdqX4ANuYcRolBtoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRkCQoWnyffQCswVPTxEqqrYYkUyXP1Sjf/Vlj+wGGs=;
 b=kbxM+Uot9u8WrlNUwEpGeAma0TDyQ9hMvyHNIu6sDIEliBHSd0qy4Q7MiWq02IUYCkeyAUpQtl5QkWpZl4ZAZdwA/9dpbEeaknh9JwLjVSN4K/2SENuOeS3wI6qJOh5Xhj7V8fazpged/OCEs4lChRrAjvGLKAHxNGF5hzv1EjJmtNXbiSiQi8Mv6TVDNLECDK/3bGfWQrSC36hviNgvkXRl4+AlIf79svNlC4CZ3EH9KU2ixDhqR93uwj3rL1/XqhswakMG6VU01mhVuFFOJLAjgY+Lbg5nCj7BCFDjn4qXf9b1xkovh1Elh9u//ux/dCQnC6nJKyHOo1+GaNQk4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRkCQoWnyffQCswVPTxEqqrYYkUyXP1Sjf/Vlj+wGGs=;
 b=KajBxFCCM0fe0WMkH1bB4CjmRpvwsVSs4N+60yfoghK13r39FjvWIHZBeH0/6YmPfKDMnwPeCXGfBL69tajVgDxGATbNiKgnabQtDuk7KUtS403aKWCJL/AwXs/HKciOZGWqUajHtVP8Tt0/h6nI0w68R4KMxZL8uC6pwEJU7Hk=
Received: from CH5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:1f4::8)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 20:38:16 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::b5) by CH5PR04CA0019.outlook.office365.com
 (2603:10b6:610:1f4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 20:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 20:38:15 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 15:38:15 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH v2] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
Date: Wed, 1 May 2024 15:38:06 -0500
Message-ID: <20240501203806.2883081-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cd7f10-4a80-4ea3-81bb-08dc6a1ea0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?91M6m/mJMs9wi1c6RBcR5dYoHwuV/+J0UechvCrWSo0xC0aoTdB7ewjGE3A5?=
 =?us-ascii?Q?6lsMYZSVj+75cRFyzFr1tSSRlN5dlxHYY2vg1CRY0nSqwWWpOuaSAfKGsehg?=
 =?us-ascii?Q?FRd2JvNJPc+D9K7ndXrA4mB50J++Zhl8nUZA82ACAr1UMYbyTQt0DuATUTjr?=
 =?us-ascii?Q?0ZJku9/0986EnsQIAm8Fx1+wy9aGk22oqIeFfr5glzQdlJOaGd6aoEf91Ria?=
 =?us-ascii?Q?GUOfk+YOxlXWtn/LnVnngrglVki7rdXyqnnBHoyxJ+1mSG+Nm0zsR0Nq9zpi?=
 =?us-ascii?Q?kuBmMD/H0ptXFmuXpRbfJ5NmTuFW/e4uTsnUE+B0GKaqu4iy13uMiqbEraZD?=
 =?us-ascii?Q?KRdTfcbvSYw/1LAKf42Q5RS6+dVwG1Ey1wTa3iFDK3/izmZLoCuEc2h60Zy5?=
 =?us-ascii?Q?MQOuv3Um+EsK5W3iwuR3HRSXSZbeGktODR39C7NWvMqKDYwnNn77qifxIswv?=
 =?us-ascii?Q?SLQpjWSZKfUIdMmrSBd8GLWuLyyQaWoAX1KcV4P0TkCc/eon2a3TOyCP6meG?=
 =?us-ascii?Q?kWlKOvQIHLeEoHWpEEYkKKy4FILpUa1eCzrrwvcKX5GUo2ex4guFVQKKyXcK?=
 =?us-ascii?Q?GE+pFEMShhWt11asuK0fgb3G2+FVVKLXBTktF17HtuMRg9k7rUK2zOnm+f3B?=
 =?us-ascii?Q?olJeZSqdYf25EEF410X7MwHhnTBAhFSiDvTQwInYSO5QeHDCNoTi3l0c1MpT?=
 =?us-ascii?Q?L/X8pPY59F6QuEog6iRSBRy3vVW/KIaQbwyau+zDuo29cUNo/SlJtq8cLp6Y?=
 =?us-ascii?Q?nBO70lVg4DTE/0MRa9CfUoLzYPesFI2WSh0SIlaIjiaBIHNuRY3y3t7Athhs?=
 =?us-ascii?Q?6USE+vhdovsS7zSMKxMv3+Q03GcW3Tf19+/ffvK7HABwocAKVAKuHM+RDJWP?=
 =?us-ascii?Q?LSUtLdPC0Z4bwz6jOvowfl3ZSjPIxS2sn6wZWRxkv802w8LtAFEHFaNg/uz7?=
 =?us-ascii?Q?7DAIbH/0JRQ9zms0CX82fubglZZo+e7jg623iy0o+7Clb4+Eg6IyoxENViVk?=
 =?us-ascii?Q?RrP7kEMRC4eRrsZzGUPKfomm4zkK5MkeF9ENmBQ5x1vOKLdcOOJ1La9E9UqA?=
 =?us-ascii?Q?Gf669ybbFtpVX/gY53UXLNlR4vVJqfvQrKiOh4+MWPpX2wHaSHj1BVBAOicS?=
 =?us-ascii?Q?NAO8mzQzLr+G3qwea68y+ab0+3f+LiVMLmiL5w8PJU0hssBNSivi4w3W38g+?=
 =?us-ascii?Q?bW9JQk/xfCaCobho+mY3isIs/ujRL8ozurc9+AfREQHZpY+KisrTdl82dmep?=
 =?us-ascii?Q?IRMnAXFUVzvtvqgVvbjmuFDBdpsK4swHBnPI+iMl+V3nhW4MAer8BGqqO7gc?=
 =?us-ascii?Q?RWzYYeQGnxA2A0CGrr5gIHBogrNr2kID7dmryS0uZmtDIyiCF6LsqYBxQGPi?=
 =?us-ascii?Q?Gban6IgZYxlhvD47c1E4bGBSTcue?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 20:38:15.5837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cd7f10-4a80-4ea3-81bb-08dc6a1ea0d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
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

Analysis of code by Coverity, a static code analyser, has identified
a resource leak in the symbol hmm_range. This leak occurs when one of
the prior steps before it is released encounters an error.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 386875e6eb96..481cb958e165 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1658,7 +1658,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	start = map_start << PAGE_SHIFT;
 	end = (map_last + 1) << PAGE_SHIFT;
 	for (addr = start; !r && addr < end; ) {
-		struct hmm_range *hmm_range;
+		struct hmm_range *hmm_range = NULL;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
@@ -1696,7 +1696,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		svm_range_lock(prange);
-		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
+
+		/* Free backing memory of hmm_range if it was initialized
+		 * Overrride return value to TRY AGAIN only if prior returns
+		 * were successful
+		 */
+		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
-- 
2.34.1

