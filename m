Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F6FC369A4
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 16:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01D110E6EB;
	Tue,  8 Apr 2025 16:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mxGMuiK5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90AC10E6E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 16:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQK5imYt7x5cSs/WSNCpvfFRDP/HwM3HE3Caw0U/n8jdTWYpDE/PAdzELzqCA8XP7t9BW0RIAq3/+28mWZ6lab4O/qeMLvWQDNEGO36TZWDz5qJTmb9aLO2IF81DpRUy6av47tUwCaDxHa23kqsE7LKggmykGHdjuM3okuqkDvq48myyyNDwtxgIKw7Ap//TK8p3fabjTXSnlg1Am1R4sFxeknNjUQt5s6MQSslceqDATmDTFB4iFZKTSnTayevbC2Nw5475zNM88m7eTC+kWztAoNwWX3BWADyMyhbafhExW8bUjPS9+2aixmOSCBD1GcVyDRYP2nzzyyWWk4wBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnDpO8OKiaPsYdMn4XLz+uMmkxKuJ/CL7JNUcEEDQkc=;
 b=EXgcmyJlrVtyOr/cF+aMdyHlkALQD90PRJObrJ2YLka86YZdIswJUkfVZNHszpj3hIc3x90eWDj2aNfCObU20JGvNP+xIkh/hjAHtaLWo5Ab3rsjZzReVtsd/2tOr/dQfaDAHo5ysomi3DUQiNU9ir+NA+xjJbx5JDUCJOjZzoqv+02UDyCwzquTMveF6JV0RXcdGcoghb6mey+9awFkknTkYC/eZXu3jvYvCT4wLA+teSCLBFJ90A5AzEGoUMBC4rXLtKUs6HYKKw+XgeCgUPPEILjaeKqEpvZfLP61q3D3BR5DBrZ4U/UkcWYYurWde1PR2b1SumWA8lUznS1tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnDpO8OKiaPsYdMn4XLz+uMmkxKuJ/CL7JNUcEEDQkc=;
 b=mxGMuiK5XFZLxkDAPCTDYpfJQCldUoZgGOir3GlwJ5R5dT9PDRkt7lZZilgDSd+ZqVk+W0p/7T8/moxkcuWrxeH86+daQrfldgsBUd0Ay71q6CSwT5lZDn32pG0hIs9XbCf7RiadESiBPsUAE6vumVRaRoR9KLO9y1HM0n0/Kk8=
Received: from SJ0PR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:332::34)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 16:00:18 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::d1) by SJ0PR05CA0089.outlook.office365.com
 (2603:10b6:a03:332::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Tue,
 8 Apr 2025 16:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 16:00:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 11:00:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/mes12: use the device value for enforce
 isolation
Date: Tue, 8 Apr 2025 11:59:59 -0400
Message-ID: <20250408160000.3149409-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408160000.3149409-1-alexander.deucher@amd.com>
References: <20250408160000.3149409-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c883da-d6c1-46e3-2e49-08dd76b67598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YTeoqPPWGH1oElxHH6TwKLPBQsEApKerRxWYD8IUwIc3Q/c69N4eyLXin+iC?=
 =?us-ascii?Q?7o48fnHJdEcEcqkvD+0NQBrn0xafya6XjWmSrZCU2lCbGKXZBubRqa4s06+c?=
 =?us-ascii?Q?iyxI6A/nfxgPpolpOKT32hwCnDidzNWjauzVKKSRe+cg0saGCDk08l8VGlZi?=
 =?us-ascii?Q?xkgF1f6sPdHnECoF+ZfiEEhKez/EW+wIZiMOl2TpS5wEL+E15GJ4/W2u1Bcd?=
 =?us-ascii?Q?UYefhUWarjRuRhloZnk1irjriel4n8V154+F/EXO9RWz+noBks8XZ2xmIrJy?=
 =?us-ascii?Q?kmKNJ3PPElSeCOAtAdXkCVvkOvJTMtnfE47ZQquVoxGJg7e4CSg9domAyRaq?=
 =?us-ascii?Q?lvQJ63YubY/PjY/xuT9bOfV9GXLX2ho5Ictg3IB930YFKfvCxyi5+Hw4AEdG?=
 =?us-ascii?Q?lpX4fqfnqsSOuEUzZCnjvUsUg/fG7dPGrkXwH5d4J0xvURYZcMzaSNrWBlDc?=
 =?us-ascii?Q?QXkZGGiwJqAvjDlVCi6lEYmAQyCGWxWL7n6128LIpIuIhsXF5HDg9UNavYQN?=
 =?us-ascii?Q?AcTb+2NDsLDZiVOwuywp9z4CSHRdCd/Y2Q+X5x9GsLtiAF3UBIjk9Fs/CZ8l?=
 =?us-ascii?Q?TwZLDNrBl+vAuF065e/+9IKx5ikP2gbxASLK0UwTVmiMFBdgdZxYJ8qjJf8K?=
 =?us-ascii?Q?pdMk/FhMJuue8G5YlphIe/+JtyROAIoRY0Nk3gJoQQuBBJcZxAyQ/tbpiraH?=
 =?us-ascii?Q?8yexNzDW2rZlq1Msx1Muh56N/kqdxhaIn7DV9FYvr/T2wMcd/ysToThvjI5W?=
 =?us-ascii?Q?CHSj0eREh5pgiFl8h7h2jqd7rGu36Ymivyk/oPyozoZF594SaazZEZ6HpQHc?=
 =?us-ascii?Q?B6cENw3QB7HfC34ONZoL9krNLAwPoQUOpQLVkz8pKO351vmIVX8gORnOn+qe?=
 =?us-ascii?Q?1Tn7B1L9ZyFXGsuomasMwmMjbJ5zQe8yJs6oqKzBNGCILcimmUU+L6gWuhdc?=
 =?us-ascii?Q?4ZjsXSTUBk4rdQuoRe7yoDAj61AFqAmpPhHm5pMJIZjUNSde29cbbMpslQSA?=
 =?us-ascii?Q?EA4pdZIfIpyOfvr6+GiNd1V0/95GSzYUjNrvSyBuIQdXB11g+NyT7f2Ex3h8?=
 =?us-ascii?Q?SlPhqL6IqJ3SlcNq22IOFRnIwb+H0w3Dwt1dtJhar9Y8ybA/sZMrB8nelroo?=
 =?us-ascii?Q?IQigNfetWsXFPqOaTR//IKbV770GWbQBZSLTJEZGMr3Tr8GtZJ7JqC9e4Ppe?=
 =?us-ascii?Q?weTjlZ3MEyZNTmj+vRb0icCg3jSMMstpBX5Zt4WGcQVoZRa+yiRRajSF1s11?=
 =?us-ascii?Q?NJXaRqvRP9d0+v3sgvA6tmbheluk2CcOatmepnuHTqesqOA47Lerm8iYaB71?=
 =?us-ascii?Q?A1dq+2Wai+sz1sG47VeLQ+4Q+HNYZWnUxuiqOW54jYYhlMvEbxuzr0ayr218?=
 =?us-ascii?Q?rgkcxSszOlTGWbDAmgvSTihWI30+ZwG51/0zrS+YyUDMM549bS9dDrlY1kka?=
 =?us-ascii?Q?2kh+s+bVfSoQjfNmgU0hQJ3yE2u5ALXKHm5y+S5+FGxAD3I/s0Xr/A180QiE?=
 =?us-ascii?Q?TTLKNtXO2v+D4hE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:00:18.3949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c883da-d6c1-46e3-2e49-08dd76b67598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
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

Use the local setting rather than the global parameter.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 8892858cfd9ae..be43e19b7b7fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -762,7 +762,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 				pipe * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE);
 	}
 
-	if (enforce_isolation)
+	if (adev->enforce_isolation[0])
 		mes_set_hw_res_pkt.limit_single_process = 1;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
-- 
2.49.0

