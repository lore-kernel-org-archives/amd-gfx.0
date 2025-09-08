Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2050DCAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA66D10E49A;
	Mon,  8 Sep 2025 08:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fp6W7mCm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D149B10E496
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkvY9lbHSfNJlKQvOGKbrOg3Og3Pf8XOTGECdpxAUHYhSVYXtUppd2WPIPxdnDeia6tSGRq9IMgrGkIibF44JNwfc2rqPlGY8WfaqgFklAUDgCoK4t/INXPi5rzSB5PbY1DdPKVuCCsHaYpKbzGcv+RazxQb+FSbc5Oywfrp+x2j8MIWGkJ39W5izGORZx9YmspG37w3AMz/JvCW1G3u294X4EM2UwROT2Aun5ZvTyOFT2s6HHxxEKZbzMcNaqOazZ9EwM+/nCsrri4v4AL08Fwv7T5NgNF9pn+sX+JiZ9S07696WUHHhYjF74x7SGp//2zNgQAW/XEcn1gchtYD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUkI77BcRPdbpecC+dX11cUlb0xPTgOKtpfAPZkloC8=;
 b=VemplWrvqaYiq/dC7nyziWWBG0XKOyYXqrrRIYj8kKiLFIf1up0r/xkGz8bol7rB+3FZwRdXJ8ZxrrGGoT0GgEf1qg0RJMryePRQzZf4NVdoL+eV+nC95tmHNYbn+26IND/5ZyNBAObM3JxiCNZkZtu2LdumJD8lHV+Gzx4Jevn3R0rFzAOVGvkHSsZNfGk+xjuDz7Ua7Ke5kr2qBrOwEaqlT1H1OLG8QUsHAgLtC0V3RraLqUq6ULLtEk3PpMau85ZXJc3YYcDVk0m9Bt19vZayLBgkimpDY5+zHLtTd+sFgVERK/exfZUwDxP3JWdMDpAB2WfXDGgLg8HKlbGANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUkI77BcRPdbpecC+dX11cUlb0xPTgOKtpfAPZkloC8=;
 b=fp6W7mCmKXPcWxvR2KTBUYcSxHaF8GdVpRAkEbNs9MrNvzQjTVD3aZI7GW3EE+ETIB98dHwkOfXmRGTAqISPyAYQwXLDlZtpmgFJbpJnEAwaf+Kj8J76XT8k1V/Wp5GCbA/Kr6c3DhP9XQIwdQTUL7f0v94fiaRktktKECp8AZg=
Received: from SJ0PR03CA0216.namprd03.prod.outlook.com (2603:10b6:a03:39f::11)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:25 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::ab) by SJ0PR03CA0216.outlook.office365.com
 (2603:10b6:a03:39f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:15 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v10 11/14] drm/amdgpu: keeping waiting userq fence infinitely
Date: Mon, 8 Sep 2025 16:48:43 +0800
Message-ID: <20250908084846.1873894-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 283174ab-e9e4-4353-3fca-08ddeeb49d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RhjNYC2D62M7vMqma8GG7MLuHDe2iFK4P2z8451ttL6709S6haGKuzvG7/+L?=
 =?us-ascii?Q?deZHL/TTe86Zdoc9kF0nVelaMpfDHslg00R0AV/wE2+uDoeHN+nlvjaEZ8Cz?=
 =?us-ascii?Q?FYSJSagir/4gJz1mqzeCileJvJn6o21Ceye7NTiUTUQBm5w9GJtp8VPIHouD?=
 =?us-ascii?Q?9TtKKizkLSIegs1iul29J2lmnKQteK5BqbJpt/RnXZe/nS3KMcnSxYhpwczi?=
 =?us-ascii?Q?5jUjuW1sTWpQcmxGG+K4GDzA0+WdfoBN2CNB0IdY97mDZUd/pSSNiSRJjq28?=
 =?us-ascii?Q?H0IsCgPx+mh4splOyal8KQ0EBGBaFLBFaDASy0BtfCFM1bcxXnue1fMKShZ/?=
 =?us-ascii?Q?st3maK+lz+xzbhLjDYmkfAA/oO91DhB3sp2iRaLbMipS7tvrNNzJS1LC1aav?=
 =?us-ascii?Q?wv188lexNVTUkdVD9PkqACfVNeODBIQsFG+8cT+kEL/yvTbUsJ2aIgyKJWbS?=
 =?us-ascii?Q?Sq2B1RYAmw4pFtx6PqHm6V4BuncByrMlLDi+TTFSdX2djsUWxyGmFtK2RtcZ?=
 =?us-ascii?Q?oH+4p5BgsdZES9PPOSP1TNO8czn49OpjQ/PbYUPwhkyzkjdXr4MxrjLyjTsZ?=
 =?us-ascii?Q?yOy2Q43ljIOguDSUseDYqZL2KcBWTmpjQIolT90SpFE1hJi6kr/Zz5Lkvh7C?=
 =?us-ascii?Q?X7ytStzU+p6Ey0Tg4HlId1IZze4fAUo6TCANrd3FKNDukyjJu/DLn36dYivE?=
 =?us-ascii?Q?IVUCLr0jIuhFB2dk60p/qgmlRjVyU0/hz+6EuhWggg5KT4dot5tGTqW9Zf1h?=
 =?us-ascii?Q?DcDRLPkfwO7F90A7PpemznVTuIa4pB93MhHCtKZMvEgC95b2ly/I4ZposI+u?=
 =?us-ascii?Q?MV4Z3r/bqux/a8eyYvyEvLLuLgD/i7kzFZoZKYk+7Y1/2wc4W5jJdDkLcm3E?=
 =?us-ascii?Q?LYUxt+VGpEo7eDOFKBLNa1a4FaC7KhxFqmGCTTVpfgrjA0kSFXp9uknJj0mv?=
 =?us-ascii?Q?FwjkFjFveLHRvKGv8310t8NfaQnLBm0SGsaxMxCAAuz4UIqqEpBmafhJQyyn?=
 =?us-ascii?Q?mOW1l6y1WkzFdBEvPFkh8hKw+jOe3hszMZp9VEb1MEdWQDH+AOU7JAdwwk2Q?=
 =?us-ascii?Q?aCKaBTBYcXbcYpdsZjPwIeDu6Q7XjcVOVzvVEwDuVHuPcGUnzzG+yp6ydPOb?=
 =?us-ascii?Q?j0qngU+YgvPPSHH8E58WP0vI+aC1J6AUqWqgB9KSo4djkUAJrQSiE19M9xYf?=
 =?us-ascii?Q?G7OPIALMf3uUxSzbfnMNL51vf658yeJZLlMbZ+ZuppOaB0tWHVe1tKbcX0yi?=
 =?us-ascii?Q?qdfUiZg8418ct5d8c4KaFwWJ7sOoF3+Hl1Zv03/Yx+mnu6+qUY6rChPms5Ht?=
 =?us-ascii?Q?wQzLQDADUAwP174BwwL4zwJV36MeZOS5qSewMBwRmdmgnRwgfeUXimDBtiw/?=
 =?us-ascii?Q?py/tZOLEcVpO8aEh43IHZ8eGyRJDhtgvBr5dey6JxZ/tltK33HAuL9Vya1yT?=
 =?us-ascii?Q?kzg9UoogPovlB12oI6q/F6wlQeDdWS+qzTaZdPvmkhCf3DZpq8VFP8UL79Tx?=
 =?us-ascii?Q?n+dZXirzupGbCUV3yNwh5LaGFBFGq+kbowtB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:25.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283174ab-e9e4-4353-3fca-08ddeeb49d31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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

Keeping waiting the userq fence infinitely untill
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 98b6b3761a0a..3b62675a4ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -283,7 +283,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -291,11 +291,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

