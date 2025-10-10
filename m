Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD802CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 16:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEFE10EC5A;
	Fri, 10 Oct 2025 16:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XvP9mYF/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5649710EC57
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 16:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8C31LKvakj93nP5NjrLX3myN4Ov1+YnH1W+RqPey7aZDLKKAMZM4Xnw3iX0lH/oLek5bC4kbAhSZ7n9OoAYqm8RxbiRFwHAiMOKrB6XyOnDKabv2hxhnzK6sHkXsED/wFKlrkEFDBVJkaXEK+Z11NcwfNtmrtNceoRJhCm0x1ntT2I6RFaRNuJFoVC4sq6pSmEmtRjQuObdR3lseRRBRtlrSxHznLc4VArqjZGn1rLJsN1IbGHrm8VT8OQoPSoBbeHwKIw5bpF31FUW7xneteOHW5hXrcF9fEkcYv1u74P4QSYTf0R9TXQVUDe7Rgm4a8R9WBiwvyhwdlcMzlzC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RXqpf/bwNDaY6K6eEgAWjxQELBZhPn1mv/aKqWRAEo=;
 b=dTb52yUkudCAHRYelAEAe0SNexsJ3OOEmmQIKsEOgFbcFRohqtwPPYPXJsyFNfa+YGuvu5fRCMd7UZbKxBgnP5sj2K4E+VYQkskrOfBUjSaiQCbn21oLC5uhmp0cp9kk27oSv1Z5rSbQ/a9xN8Ltwdk5m+o2SLjLUAIEhKw7LWTFmYzUsXq4QMFx5Pie1uc9mrvO/vN8raF8yUm86mNEcuVqSBQcB3ZIBM4Ezudm6LEhFLlq/Iuoa7I2EOhjf6iuqJESVOumYI0ghZnXdv+kIDdRA2qfleKZwM/l3ErLJW+07Ihy4jUVbNJ8bJTNy5bSBhk4bjMv2ewTwewlaP+oCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RXqpf/bwNDaY6K6eEgAWjxQELBZhPn1mv/aKqWRAEo=;
 b=XvP9mYF/agW62DSsY1nlfoCEjwmDnJpXKLYO81HK0kirfNjT5kDVz/OQCqEB6Pg7ctQNuScvRPJm8fmHI65YT3IM9oTZ0R/fRs9MaD4bRrXJs67SoG4JxwF5Tj59qzv+Jp7t4aGsZzaEcrH/Z/hTHpDAtnxINvDh6v3TvlQowMQ=
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 16:33:36 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::55) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 16:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 16:33:36 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 09:33:34 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <alexdeucher@gmail.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: fix gfx12 mes packet status return check
Date: Fri, 10 Oct 2025 12:33:12 -0400
Message-ID: <20251010163314.1105768-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e2c822-4334-4716-da82-08de081ac2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/2DFGw+SrUIq70sE9jG0vOraYRSTWQ06KEYuAq1UJLPTJpQcQEk8n+bIWGcN?=
 =?us-ascii?Q?Lg+ZFRLBx7WHCNve9P6Lesf2L3jYUWPyXle0AnCE/o56qPlInCmTC+w1QRRU?=
 =?us-ascii?Q?r/KqoeUyGPJokO6J5okN4UoRALiMImNjo1/VP4W2YI/wqRuywWgcre3yeSsu?=
 =?us-ascii?Q?FcIG8a5+W29ZrM0KhPS4qaNHB4mSpPVag5WZVWf/+TfsRTwhNrgOhAIvxgmn?=
 =?us-ascii?Q?5wp6FeX+qDdiD/n+KqCQXAeeIWeG2HT6BFOm21LU5Sy6x33cJrr1/LHTnKqv?=
 =?us-ascii?Q?SHsDYCbyXe8Oo7hLqs1JAoVnHyfq2lbDHEZHqfptMbW573Ve2pwB9XPL7Xgm?=
 =?us-ascii?Q?0LfSh5l22DuJMxhEVPzPqd0rcrWkml4uuSbfCBOCBRUi2vXC4EEcHmBJqzIV?=
 =?us-ascii?Q?K94aROMV4Jrt+hdU/OOnFoNJDPIuRO4T5yJ7MwHOfDCHe2bTqCLD65LCStqt?=
 =?us-ascii?Q?a7dLiUiKWWR+SwNJ0iMR3hLcYmK1VQdArxBT9VORoRZ/seqD+6AOFOQ4ZUzU?=
 =?us-ascii?Q?mX8+FsCl0tAf5fkyHV8ndtBHXORKj7tkOHRyxXNrBnt7w01i1dEfVMUphe/o?=
 =?us-ascii?Q?xCZBGex7b9Tm0GTnUHQSAM5nVd6mF8FGmO/v3+txxJNJnz6arLeqlZjUxKCA?=
 =?us-ascii?Q?xtv58/lFb5Fk8i8NDBjF7VojKJmQQaLlGqkE8Qn+yd/wZ1kA5VHeF/AmyTPs?=
 =?us-ascii?Q?ld323yj+O86hjONxOaPxi778y0MRTRIFs3ELr3YBvMskpENgQ7pK6EOOrgLq?=
 =?us-ascii?Q?SyIFV7ULG9yku8D1w8gFH40AcCwPp7CXEml2hQjylfhxbxTngwGp22M86JiO?=
 =?us-ascii?Q?Q9mQ7xjRWooRKNzQaNB9gdDfbdfi8gCq5qrF25y5ul+WsXqUpNfK6IQeWQHE?=
 =?us-ascii?Q?kJTbDKE0BTapqJP5TQWxSZvhQomB+yobO9YbtdlNtGAz7QzaVoPYDmXEsCpS?=
 =?us-ascii?Q?be5isPSABjHHDm9ukmvS0sO1SsBfl5xov1WJs+QjWEelrNH8vDbDPQrXSWoM?=
 =?us-ascii?Q?zIYmFupTALEjr/hbvLda7plG6Fmd89CtOnCTL7M1tvSDP+5PSVG9sZ1W38lU?=
 =?us-ascii?Q?Yp2sWummpdeOKVmLpxuHwQVVZgxguLsqKH1GdqleuTxYGYfB0xOUGQ8XxcrA?=
 =?us-ascii?Q?Vcp65a9MZTB7KV/4U/3q1Cyr98tjQpwJsc6Dz7BE5wwFVe0Si55rso4vuVgS?=
 =?us-ascii?Q?gmpo39XVMXWHCG1WYunpOi9v1s8ANog5jM4swoWDeYIFBieTUBT6Bg6LcDWO?=
 =?us-ascii?Q?ysT0XjGrTMQq7pmdYJyQUYtUhcchMcf/v0ackkFqnDL6pzDlnJSbx3tJ7WvG?=
 =?us-ascii?Q?H/EPRxYkYnLDsMCfq5TyvNIo1KCxUqKXQ7wf5fseHOCSBXynA6uBQM0Q++6D?=
 =?us-ascii?Q?nBKbYNbvhwGsjGSl0rQ76IqJz1oNp35XtBOqkP3FXeWce9YrjSjGLvNeDRgx?=
 =?us-ascii?Q?BXsJ85P7Jfn/sByZZDREx7FjeteKE9kpTHcN/sOLUhlYvqT3W79sYJoTEnP7?=
 =?us-ascii?Q?DqvzDQ1f9Uo3g/mUhuiClzuLrziIJd4KPb5P1XPsgoG25zN6+JxI4DeoQNTt?=
 =?us-ascii?Q?xG0ZjCeg/DSpbUhdmy0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:33:36.2797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e2c822-4334-4716-da82-08de081ac2c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
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

GFX12 MES uses low 32 bits of status return for success (1 or 0)
and high bits for debug information if low bits are 0.

GFX11 MES doesn't do this so checking full 64-bit status return
for 1 or 0 is still valid.

v2: user lower_32_bits to check status and write some inline comments to
explain the status pointer value.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index aff06f06aeee..e3149196143e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -228,7 +228,12 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
-	if (r < 1 || !*status_ptr) {
+
+	/*
+	 * status_ptr[31:0] == 0 (fail) or status_ptr[63:0] == 1 (success).
+	 * If status_ptr[31:0] == 0 then status_ptr[63:32] will have debug error information.
+	 */
+	if (r < 1 || !(lower_32_bits(*status_ptr))) {
 
 		if (misc_op_str)
 			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s (%s)\n",
-- 
2.34.1

