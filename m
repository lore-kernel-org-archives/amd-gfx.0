Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62CDF483E1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 18:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBF010E36C;
	Mon, 23 Mar 2026 18:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eEap3KP0";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FF610E36C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 18:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAOKaGR0Y0CRpKV9W+wgSOUp/p078g8IlmS4dWHvQRqkcIOSZb+52UqAnJ+zEfe3xBNTE/S0N1ru8IOOsr4NimD3u4DZmsU4L3/lAISWfW9xPxU6m+u6m1xFKhFBnUPLGMoGzCMhYBEQiVEl/uprKIDrKM1VMFRWG6ofj0akEuw2ZoU9QfKHclZFUdBfes8ITfltvlq8Lr/3bCLASjL0fA4ByuE+FjtGHRlvqa3lZ5lR9w+pOataUU9c5iBRofCRbsGdS95TOdJOrB7pdKSKCfPTk9qGysqeRUl68GTUf80/oN1sEGTAWy2njabcbLBvkNSyqodWPgR+7ipiHlg2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwU0OOxPtwNhmG/vS/jEDs62pg8BUJroUIJTVO1oTcQ=;
 b=R81kZWtWGrr6XJcffuUVVrJyKE+/BhPKvPSUWFNXhxPdUtHJDVScor3xen4txFbRn/0PQKN96cSH8rm5l2w6B6cBV/kpkZBxX/fmu1mFLGEKzMN+pVZ0tqa1NN8tQGFwVdIDgSlrR19XWcpY33gAhuefCZkJxDwd7P2dIWcmL72h/OU8teJl037IlSJarVKojkr1oohsVkLlkOlbQTS3WOIQhqDywEOuLFOm+tomwmV31ILCGPZo8+Ybwo6IGCudw8rFHxljPcuW/lN+bO2a54tvXl8fegXXQ8AdcGwKIN7VxCOYaiXzx7j6TahIZ263iDW/nsV+K9leoV5khY0lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwU0OOxPtwNhmG/vS/jEDs62pg8BUJroUIJTVO1oTcQ=;
 b=eEap3KP06DPylxC6NvZ5OOcLH2hmeokdQnq1fj/MAnxStIaRpVhxGC/RULxOJ7ScXQTq6Jw7EWgsPhzn2ledSHdsoIqJRt/OlPywNaWrBuSWhj9QAsi087EYyclZIKVmw79+JBkh3fquRUZZ4UYvgiESalU4Pbp8SjHaHJybEkE=
Received: from SJ2PR07CA0019.namprd07.prod.outlook.com (2603:10b6:a03:505::21)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 18:45:12 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::32) by SJ2PR07CA0019.outlook.office365.com
 (2603:10b6:a03:505::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 18:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 18:45:11 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 13:45:10 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Amber Lin
 <Amber.Lin@amd.com>
Subject: [PATCH 0/2] Support SDMA queue reset
Date: Mon, 23 Mar 2026 14:44:55 -0400
Message-ID: <20260323184457.1244422-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ec6549-bb33-4e79-6f2c-08de890c5081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: JUp8ObMY1Aht6zLpd+NkrfvTVDjrjsX/tbw6sRZKuHUn04xWQ0RE2BtjGy1klnaRKA3GBvCLfSAPgn8/AGMUizubhRqMBo+ls4ygrK5uT4QhryL0EB1tCcL2exlJy3/3NepjayZjg0s2EGtQ/2ckJ9MDfH0Hqo4wSl2SEs4TlLcGw+g2IXMaeEpv7EsiwwiXs0BZX8tMCkBlc9kY98HxR0JpcYixtlqXaT+GFw3s3QdD7TXzrC4GtlUfaxxIH6fPgFlsML/XxvuDI7kjL/8lqQrdNqIFpufz53dSt8FrAOie+YTl3p1ArB6GxSEsYUX7GKuQMmJPLOGDpczFP+jWlV4tpjRxiv73fmq/IRzUjH5sQxPiNkzVdBeu/QEYpgCooXaBlN8OE8sIpPAMdMqjSlUuYtzKaHSvltCP63a4e9+28aP0JOCczi8Bl9z/NHfHLifLiY5qxxAPDQqsGL1d5EryJRLHtzMGMui0w3iR3NWZMpRoE7eGEQZdNcOyzI7AcNBwbuST64hFo1bmCPivCCgEBwQF7Uq4+t6wxLyXD+4o2GtnirEg3TVEzYcvxqufMSLfc9x3P5IoW7rX+7ktrNWJoNwnfjvPHZJ6gZIpm41SvdxTMcq+1uRqYGe2T5OafbFfveKjdul8LB27KyzKMHzwkw91BGVAe83fUqUWlvAOnGwbN9MjLbnGGoG8pT2OVlgBCYFR9kEIfCPVBnBGVY+4D7DiwnwVIbnkhxBbb0GT2eL2ILrYXeTT+SRWl8CzETgJWCqMJf0ZGJ7/OFNNzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 96hq5taW2CBQv23dPVVlgSHcimeiep2/oRY9NxvYHG8MGmUmxL2xpIJN3ShMdSM6hzbgqogKAUwoN7pdBxK/Yj0xdhlW0TSmqJC/j9qeLNiUoHIHuu+JPr1VXI4oVYMy9mzbVkXdxjdD+b25PittlJU2BmJx8vAM53lAdtBGLSDEV1W6gOGslTkGlFYzwdQx2WxRP9W3XPBSK11z5KLD2jXKUZa5eWI7TpqCYK9TqQ0dvoSgojx9pC5aXeakf/+b/x6n4idzxB7GPoK08uFCJA048M2Xj4MQNqePFU5DHl5Rt0tuCL4MsKTjTGGeomxnkOLBbGQuzQdemwJhGvYjlR0IQ/D58zmqxJYl+nXC1MlSa8FhZsiedYAjh2vkkQfIm4ueS/KM6sYrmfdpjSLaOkjPAdq/+32QWQrV4gnoTk6JlIAgySVzyfwcT62AYev+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:45:11.4650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ec6549-bb33-4e79-6f2c-08de890c5081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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

This series follows the compute queue/pipe reset series of patches to
enable SDMA queue reset on gfx v12.1

Amber Lin (2):
  drm/amdgpu: Support MES suspend_all_sdma_gangs
  drm/amdkfd: Enable SDMA queue reset on GC v12

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h   | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c    | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 4 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0

