Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1CECCD1A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DD410EB5F;
	Fri, 17 Oct 2025 08:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GNBDjq2+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388B910EB5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXBlgFWz1xx8dqPIbbFo53XsVwMQDWIbWWC065PxKemCGYtdg63BySK4Ixw9UGvESkBhXsUq2gQbdpBmLdyG5VQWsrzqYzCyB42J0AIqUMrymK++WgV9RuIlCduynJVRN6koHeee8ylhPZN3/GbAzTSA9ZqvwLiHUpZ6+GrEug6RJ5L6JdwkGFRI1vcnVlBqLD/UOvuIt68HxiW38trHzmCEvU/SKvIEBexy8+yuwTsdE1MM+JR/KT9gb+Wubz5WMj1c4cf2Gl4kTsaT39OkLajXqgXv5P4/Cjigh2ksJ5Ag4s5hKPg6hRvAerEyT5TylsqsgVe9rUHFTBiTmiaHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf9T5hOTFnhyKs6InUPA/mvF5yHIkb0BiNPpKT53Zmc=;
 b=ikTFqsGGYO0K163JSpdg0Cnkv4qUExXLJtjAWnyig1RCotqGQrocH1o5vSkL29DzRREwTlfsTx08e8Tw8FMaGRqSYgdHpkQ4dQuEUIIuE58iwAjjHOq9KNznMPcp35g8qvJxH2OunNP4BMfdwkOa1htb3fhq8gV3g6vUAx515fmaHtMrp51TzbNEBkRnF+6HaljAMOwdZCBYO87CmLCHjmEGuN/m99L/e7vK8cCko5DAaKIRYQOKK5YZqOhZHxIvxERAEaAX/kLRxjeOTl2f+f/FdJgjErPNsUbXlU42Hk81ot7ae1/yZhIsszMFq5AyXLngy7HyRQHda18e2Vj/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf9T5hOTFnhyKs6InUPA/mvF5yHIkb0BiNPpKT53Zmc=;
 b=GNBDjq2+u/xuKCLFPFONQDpJ3QkloF9Xjg1lnUbtVTbjEY+EYzW7BpUkAfiRZffRgM5qYG2rTy3raVsx7qpvNxG1gyoQyGNLoZC1pnI7LmuJMV8oJMmLh7dRYKIvYNUSnC7vu17AXx9uXnOTGsNOY6XPhsBOyvVQJQQcbBPekzw=
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 08:43:16 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::e) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 08:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:16 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:07 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 01/18] amdkfd: enlarge the hashtable of kfd_process
Date: Fri, 17 Oct 2025 16:42:05 +0800
Message-ID: <20251017084222.54721-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 0756f4a5-1363-45f6-aa70-08de0d593755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BnzrV094V6ec1YHHEAILUoaFcDtYzcPn/Yqp1If8tc23Zm/g+UEHTN7BnUm/?=
 =?us-ascii?Q?6nzYHbO8EdcLJQh7UT75hPRqoUdXReNeosLqPDUu4TTngvAfUfEPSMpH33/z?=
 =?us-ascii?Q?is0DDxe+Za1ObobwCc6ee/RRdaJFPJ34X1hciORdN1lKOJSKISeLM8H4oMUf?=
 =?us-ascii?Q?55u7mAfcK7PP2hw+mu/+WymcND3eg+AHiOS6BY1aHvCYkD+m4BAzR67Tiixm?=
 =?us-ascii?Q?o9sS47r0hPE/ZjW90qYgGloS0zttNWKNdPmmUpItIpE5skaYEA3Oc8ry/Z2n?=
 =?us-ascii?Q?mnBTGpxegMOUwYvcN8B9pejjcgTMaqI0Xg/0qo5JHy1YtYxYT6dSY2jOSP9f?=
 =?us-ascii?Q?ykWjqfGmX6aBYcsyvcbkaaBKCF4wsfEk24NkG1d7ekj0rEWlrp0xrWY/o/sh?=
 =?us-ascii?Q?Dpgfk4lUQGTQtYLFRkIZ5/X5ZfoCRbCHbCEIQcHbYs+ET6ieqA/SB2HpAp9+?=
 =?us-ascii?Q?t/Oc+pW+9pBchhwUcu8pvXZVyu9Zr/4UR9StFHMV96oVhOo6KcpVGx5UQsXr?=
 =?us-ascii?Q?OPV4K7WMGFFo/TO5wFJ1G3xm5vLNEP2vLACycIjcUNvbMOiIfg+qHYokJutG?=
 =?us-ascii?Q?RYx6WcpU433ZtyzKXfYv39Z0lrLm4DpjGFzhingNp/OzrA6cjjkd3jNrdz3Z?=
 =?us-ascii?Q?DvQ/2GCCymxOkL3uKLzcp6M9xz9ILPUxU3nq7TlzpslBZaR6eDihd/fK54Et?=
 =?us-ascii?Q?27hQ21eWp33iQf/uQgSCLTmM6UyMCYTDABGNLsARywXiPonJC57giPam2pro?=
 =?us-ascii?Q?ZGfG4dUlZ+Hxz33oBpqJnUBTIAAbwR7wt21PnpuHajpsf+N2WMw253X7I6g5?=
 =?us-ascii?Q?ktVN3hnJpYWTztmFeajd9ts+5yT1kMMrlDx2YN/lT48Tp03fPJMiyDJGP+Ww?=
 =?us-ascii?Q?n/zQgrkEgka9plO0ICtbFT0mjy8FnhXmO8CqI5oaNBlBlRghBmYfnHOcOy0E?=
 =?us-ascii?Q?IfiCuDYFLGbqp1EH7ysF2uX0Uh9Dyvz6fFNfjGaFl5FnXgn/pH64w6JWK0LL?=
 =?us-ascii?Q?1l9REdPXxR/TW8cas392Q+M8hAHaKlj+x/AEu6HOnVyttPpLYLRvQiHEmQb9?=
 =?us-ascii?Q?wsxMAVN00L6iGKvV/RPuu6GSMnBPe3DI1RjXLZh0P0u7OqZl/POVuUcf5/Wc?=
 =?us-ascii?Q?3WkItV20Cc07ezDFEBchQVRo6jT3Os4h5JS+DBatUnrKzSpSUojL8IOGNBNf?=
 =?us-ascii?Q?ImROMgrQgcUTXpEI21b1CuRkfkGchUzmemqQTUJdIyT/yo9YQw3Pce8GvWcW?=
 =?us-ascii?Q?K+Tp6G6ymP0n8wZWtL3kZNl1qGF0lpb+u0shftu/EF1AwaAeVrdwlo+CsnGO?=
 =?us-ascii?Q?wBe83fAEjBa0aF34YSB9HtX978J5JpkstL95NqrYezz8MG58JkVzhM05SSKY?=
 =?us-ascii?Q?1t00espKA6ZUx7hwO+mIuOcPDoDMcO7o8Y780pY9JJvc+uHonmpscTGQtAen?=
 =?us-ascii?Q?+pZfbu57eHtzX1ubba/sRnrtw6AiY+eWcX/T/aipxMbH7SypBYPHrfe9zTaZ?=
 =?us-ascii?Q?7x74sPSBd/ZNYqo7Zp0G6p1Aaa4Z3ZMtTfqtfbLJ1F0eAvqoFEQmizUnP3Dy?=
 =?us-ascii?Q?GHQGMGPiy+A6lsOd7jQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:16.3993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0756f4a5-1363-45f6-aa70-08de0d593755
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

This commit enlarges the hashtable size of
kfd_process to 256, because of the multiple
contexts feature allowing each application
create multiple kfd_processes

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb..d943ecf62a3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1020,7 +1020,7 @@ struct kfd_process {
 	bool gpu_page_fault;
 };
 
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
-- 
2.51.0

