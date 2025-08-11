Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC136C87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 09:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850AB10E403;
	Mon, 11 Aug 2025 09:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wC3urbek";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C4510E403
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 09:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2KnYCoJFGAc6FjeTcP7KLN6IWmQZmNKYZtZhFb6O7Uu7GXiSQA6jpjVA4W4nf6ksENvsvR/oN3SZv83Vms342HNeyb0gqr7VxR9iBeEgyamcINP9ZocWMG2ga4piLd+BAHuhSPmYmm8TyUoC/kxZDejElwjElJEPXJACydyIDq0ao6AofCGAuiDols6uFEKEixU//8UWlih8uXCtv3req9QfLTCQuGD5hicuwHwYtpoI/7bN97vqIHW4VN3MAxDzs0XDdkdcqMC7fhy0KxRFuc8yCYDm0pLXJRApK4evyScAqjGTwnFhjoq+PxIl24zvikV16btuScU/mKrhBs24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=BKbHdaT+h72YYLgL0wCj8HTi21wtfqKyv9fx+teQK0eB+pFQ77nnOfQUDPYrr2FcnY0b+0ECk/aRWh2l0lk+6xh+mWmTYLZPdzpHaFavvwcyoYRVA94bqjkk9qKXxFr4ocuNS7RddYeuSj0uC6t3Gbaq7zWlVCpCXDyXhYXE+cgT+xwUIN6JslXWpBtQLzUTMHqelPLPDizpspNAFv7Se2ozwxHImHY+v6acReEhhpBcOfkqf0Gtc3WxK1zBCsUy+ISS91aG0/5bP+bi7W40MsHL7TWTffk5qoEiaI+INnS1/D8HMEtG6WEXKUDdNlJemKC4AjM8HQP7gFSlQ5YDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=wC3urbekkNSu9+PD2I6b4eP3/OFG3VfHTuLa5HlYkr6XHyRlQWVrRL9Y0ae2baIn+dWKqc/sSoW4S+Mu0+GXRmj+GM33JMPEtjB9mdKqWFoV5kTR4sH1WWzQNVMixAQYTKCHIShwilqK0ifvsFdi7DerOGQbUCLF9FhZ5U4i/HU=
Received: from CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 09:59:48 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::d9) by CH2PR10CA0022.outlook.office365.com
 (2603:10b6:610:4c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 09:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:59:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:59:44 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 04:59:38 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v8 01/11] drm/amdgpu: Add preempt and restore callbacks to userq
 funcs
Date: Mon, 11 Aug 2025 17:56:48 +0800
Message-ID: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: a2858a46-dbdd-42c2-b52d-08ddd8bdce7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iXRLZ+RyRpn8ot8i84RuCcapbULzy3ORJZ6I2a1b6VaXdi2gptFRRl+HuQpF?=
 =?us-ascii?Q?S9nYXuLjBCeuB05slDqFztLeZKtJGxT52495O5o98s6+Xq8vXhNloIlrT/vf?=
 =?us-ascii?Q?MYITFCVtdcrhuDOUmZVIMBWs+WnWj3WWpuz7Ycnb0aoguTJi9MCgHpz0BJDH?=
 =?us-ascii?Q?CvKQugUHevJEtHKcaOhOxJMxg9lthN9j2dA6JqU6O4A7wdgoaC2i1kHzbaUe?=
 =?us-ascii?Q?DzsJntRNLF0HX9l/bawJ31A9iBd0KSqFqGoDy3pYL+JfVeP/wszoQAeT8r8h?=
 =?us-ascii?Q?G6TUnixB3rlbPiWwXDn2JbXtHJaqZhR9/S6Md1H7Rl9+95xdSwXlRbPUVgkk?=
 =?us-ascii?Q?70Xasegoo9u7maB9OmurcCbXU9rq1RvsnadNyEd3e1fuX9Ie/5LvwyHkC+MU?=
 =?us-ascii?Q?XNtwXwRG+nRgyckUH/vsGfka22zlHgGQfTBZqnupXir1nN4IZoOT18wwMsq4?=
 =?us-ascii?Q?xL2KfjRlbVTYliK9t1xeqiPJ3cDNdyJAAOIGEsFazlgj8tp6uhbRP7oQ+/SB?=
 =?us-ascii?Q?zLr9xcpXn5wVUjXoC+HQBDKpmgjrhF2zOIMvFU9cfLsZuwexKmMfcAsP5rb0?=
 =?us-ascii?Q?F61iwKFit2xM2qgbGOAVP5GEHlTdNejbPxoXovj7PjjKTzXMgAFqZOZQzMNf?=
 =?us-ascii?Q?Sd4M51JSgRa+kSBboNGXzylW3QEX9bHcPVnEWAon4UZRxKDsOu1FF9tUPwPE?=
 =?us-ascii?Q?K2iprkAPKWD45gdmVyScsMYLfGPTbDOEjPN5v1m2165r5kNP7cEL4Tz7ubqZ?=
 =?us-ascii?Q?ZkBZTQm0RjR97E444/le832YzQ3tASCNLW1TC+eh5/zFXZ6C46pHRfxGpqGr?=
 =?us-ascii?Q?czMS0WmFu+k4h5DDv3srgt0O8pe/OIz1q9bXZzya2aL7vtlYFeqrtEns0h00?=
 =?us-ascii?Q?bGwsuc/NI8dO3TSuvCNqgCNgOsSAs1DZKvlvIc6xtTPZSNzYO7HGrSuhfB1g?=
 =?us-ascii?Q?K6D5sFZF2MLOzK3IjmqEH5vvV5MTKHoeVeqjZIDMjkSsvr7R5zKR2dZjD7p0?=
 =?us-ascii?Q?x3kU/RIftparWfcDhLrGPwFQdsb2Kly9hjke853J/DExOcejZhb9zbQuiVYH?=
 =?us-ascii?Q?7xOll9F/9do2LCMTvlvPUd5YlfCTGIAoJ56sEfQjNsCnT3fVaFQZcUQrN9So?=
 =?us-ascii?Q?iJ9jto7VhCDlWD5E3D7H/pxz3ePeC27cOHzi3G3NBuhr4SYfIgOXDhrePaE1?=
 =?us-ascii?Q?/Gt37Bt00v1hlbCc3qJ13W58GfP86lhqu/Jw8CJIF8EaictcUO9cmWVeFl9u?=
 =?us-ascii?Q?ApakeGBjLouoWeYlQu5a1Z8lqRhv9qqETy8+pOoq2lEsrvRHkasm0Qz1PZRa?=
 =?us-ascii?Q?TyRw/O9R31bF3tQHZm9KZ6XcxB3P/dtYTyItgf/TDhdVz6IWgXR85H00iSGl?=
 =?us-ascii?Q?HH3xpZbgzFNeNDbkHrSdkXVqLgoaF8HGZvO97wyb/2eT07FoX5N0FtWEu7d9?=
 =?us-ascii?Q?aAqmJRo+41Qldw5ui6gmEwNNoWgO40CjXGZ2L1HgjEVUWXr+6c44MGd8J2Ew?=
 =?us-ascii?Q?VIf7j08rKXmmZ8CRmcZ+qq2zlXjMAkcr6Mvp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:59:48.0576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2858a46-dbdd-42c2-b52d-08ddd8bdce7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..5111d7dce86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

