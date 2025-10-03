Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52D9CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 18:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DE910E959;
	Fri,  3 Oct 2025 18:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hNCBG26c";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF01610E959
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 18:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgqKUSHOS20N4C0mkreJ0Cd+PqU3zp6R9Ou7v56sE3UyHw3XNXqbzskL0+T+xEWYbaPncCw6C5xZhIPYtR5QDhEvfJfzN9UiVUSlpjLCMtSTgEVxnPnvjQLczeOt4T59YCcUgCm8Pe2h/zxuFXKjm8/BUqqynd1lzwm861RkJ80MCIB60k3hLZCZ8GtEpHXeahOC/pWKK0EAJKT81lZPvlPL54U/u1Zvlqtowi0ZzAO/n0LxYNdgwZh9cJ5dGWXOZi3SErpdTXn1uvb13VFn36Sqmk2iLL1LUEPKqWOQkBf09etJDBaWrr0Ho70/Kd2XLPpxm6rPVyAB2Uz+ZBJoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVkg8eyi+LC9dXl/v8vP3azC+PBmiH8SLgatipDZ92I=;
 b=GGW9flnMYKTVVkiJGP6SZE8EugrnfONTJCc4A7/tHAlHSBOKTLYouwbtjX7eNqu+XpHkfpGuwpOETlNR2S144YD+q3IrWsznKDAYzwA7xTReczLGZYuY+C+ReNxeZhEHBWTQ9cXlP313oGgSEUcrN65MvMFSuiV2Hf2zK2gKIOXl+DHli8ialTMn6+J465yvTNAt61unEoprYoeYAflGQkFInTg2RlQrD6kgXMAaH1vMmA2gJJ6KHuFsIBuRDuuzYJB56Bf8klnjdp5+9DEdzl4FEUDHUcE8H2aqGc3IEydvL/L+8UDhvf3mshrxhFaDQwziQvy9wPTwt8hpObgWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVkg8eyi+LC9dXl/v8vP3azC+PBmiH8SLgatipDZ92I=;
 b=hNCBG26cS4OxjHQxHtYrvyIoDzIFof6IVpLKn4BLgtQpr98rEg6YxNbd1ACy3IwXBJjqJPgfRHOtdpxBwtYSP3v34MdOhcUa0eD/T1BJVjI86a3YAjG8MFwUsJIKtbuwU6CA1aXA6E1aOBtsfmh6eF6oNnOqGfjYHYT+mGaZlrE=
Received: from PH0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:510:5::32)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Fri, 3 Oct
 2025 18:15:51 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::80) by PH0PR07CA0027.outlook.office365.com
 (2603:10b6:510:5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Fri,
 3 Oct 2025 18:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 18:15:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 11:15:49 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <harish.kasiviswanathan@amd.com>,
 <Xiaogang.Chen@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: svm check hmm range kzalloc return NULL
Date: Fri, 3 Oct 2025 14:15:15 -0400
Message-ID: <20251003181518.24270-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: c13b52d4-dc5e-4d93-eb5a-08de02a8e204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4k4i4FNbws2dQYmhjVuwK9sEWD23RsB7gipLWntlK0DiPjTs+VjnwCurvYeb?=
 =?us-ascii?Q?K5ElhtxWv7GUR8Xa2NPRx+yJ/fnMwZ3WxJKdPVcvY91srO4891DdzpQk3BOI?=
 =?us-ascii?Q?KZSc7w0ftWFYe3A+AMB9yDmmJuLNmLGkLWD+eB/ZL7y9p9y7DukRMiIQuCRK?=
 =?us-ascii?Q?aI/TS0ICmwvCJi4F7UfqRESy6xmBXVptsVFZmyAUOpZ7XiKq2k6Zh5pUjxQ7?=
 =?us-ascii?Q?D8uXTqjLJRdNeMDBo5p/w/dD4Gnm8GrsRM4CbIA4ld6aVPOPMBoIJLbeyYrV?=
 =?us-ascii?Q?LDXHlXyO6s34tsUJ2lHKjzDRllndFGtW8t2hYIb9ZDQvpbUZvf4qGuggQjFZ?=
 =?us-ascii?Q?Q3MHr7iah14buyiDNUqL2qJc0TMlEejXC/1vulRc+NtEdWsh9hKi1hS8yVz2?=
 =?us-ascii?Q?4GHIYFiXitTt+lKHQzQJsuf1XLCH1QBQXorKST/zVodj1cCi4RUCWhuUwVjE?=
 =?us-ascii?Q?a7U6X4hyZwxFft83h2M4Xw4ewtiGowJQxFtd+K/fmrOCxVHfwvq+wcK2WtPs?=
 =?us-ascii?Q?IqRZZrm65yyyARDmePoyJw+4K2u5+LMar2yJljNHppWuo6y41ZlqFJWQjiT5?=
 =?us-ascii?Q?TnVhRSoJLaieOLOhrulganoFqCC0hk/6wbdNcx/PLpYDsBXLYUnbdDicmK9Z?=
 =?us-ascii?Q?1YKqkrb28BpY8M+dj97v+k1HAS1AZaAM/QRwfrG+xuE4cu8O5NC/haPgiBsW?=
 =?us-ascii?Q?+SNRXGWXEjic4AL4TJu2yYygKxLQnsjb/lcdC/JqUSAlKmN7kArpYpSTym61?=
 =?us-ascii?Q?PL5jVZnDec+/q4XPsvKsCUgLUqX4oK2ciRLstP60lYzFN/wGLSWGIaMmiyeh?=
 =?us-ascii?Q?T9S/2vspsuR3LXAEkJiKMT0VLnIDTxO7xD81SxoS9nb3sHINfAhPnJh/xQ/6?=
 =?us-ascii?Q?/ZLOcFCBbZekLRcSfWfACHsdO+szpbaKe1J8B2IN85G0MSBynp5ciP0FrohR?=
 =?us-ascii?Q?4OvWmCRpk+np292dVd+VNLXtgkxenw+rpmqUcMyOxSNllU/RKya6uY0PqRK9?=
 =?us-ascii?Q?prNEyS3Urb3BsoRLunXfsaZ///3q+QKSvBrK7/hoVSpp1FLBeWVyEXQpSjEM?=
 =?us-ascii?Q?8a8Ki2JnM8EZCV189WN4GHKz/alzi2Dlnq962XVg/N/uGVrs5SGGmx8tkzPu?=
 =?us-ascii?Q?I5rmFKz72/H67Fh7EncHrwpkz6ITvzc2GhVUp9pm+Q0Qt5TBcdc5zh48VYu5?=
 =?us-ascii?Q?own1NBcgVQYnywFo9R+PNSABo0Ybcd/ehTn9EbtgSMp7g2NR8TNmpriS9H1V?=
 =?us-ascii?Q?W8Dszrod02S7/I7ZOlPo95ERI79SqHkly9GYT2uDYdaFp/JBmI49RUYtfBCQ?=
 =?us-ascii?Q?WBF9DlXqWNKAPO925LZ22DO/shjyBegFzeQgRqwh0qF1Q5aOGNqYzLsi0qLr?=
 =?us-ascii?Q?0ueAACQ2MMosbPQfuZKrwcXwcUc26eSC/V3iJ5QYC/Z6fo3K8PNvxSI00YUt?=
 =?us-ascii?Q?BGUknf6TzgdqmH4U48Cj8LisN3KhzHGO7sQfi4LygHG89nZ0KEX9CHC+NXBh?=
 =?us-ascii?Q?UG7fGVxXp4ONylJMeeIFVdthHyPrsTqfucggDrzqBaZkZHTkVv3kUPfh92ZF?=
 =?us-ascii?Q?53ISIPSDdWLFoCoBMYA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 18:15:50.2046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c13b52d4-dc5e-4d93-eb5a-08de02a8e204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471
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

Add hmm_range kzalloc return NULL error check. In case the get_pages
return failed, free and set hmm_range to NULL, to avoid double free in
get_pages_done.

Fixes: 29e6f5716115 ("drm/amdgpu: use user provided hmm_range buffer in amdgpu_ttm_tt_get_user_pages")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8c3787b00f36..e8a15751c125 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1736,15 +1736,20 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				continue;
 			}
 
-			WRITE_ONCE(p->svms.faulting_task, current);
 			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
-			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
-						       readonly, owner,
-						       hmm_range);
-			WRITE_ONCE(p->svms.faulting_task, NULL);
-			if (r) {
-				kfree(hmm_range);
-				pr_debug("failed %d to get svm range pages\n", r);
+			if (unlikely(!hmm_range)) {
+				r = -ENOMEM;
+			} else {
+				WRITE_ONCE(p->svms.faulting_task, current);
+				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
+							       readonly, owner,
+							       hmm_range);
+				WRITE_ONCE(p->svms.faulting_task, NULL);
+				if (r) {
+					kfree(hmm_range);
+					hmm_range = NULL;
+					pr_debug("failed %d to get svm range pages\n", r);
+				}
 			}
 		} else {
 			r = -EFAULT;
-- 
2.49.0

