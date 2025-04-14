Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5D7C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 15:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB0E10E61A;
	Mon, 14 Apr 2025 15:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eTbMBiz0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578BB10E616
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 15:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA3DX2qxOLvevAPNmRd2LdAA6GvhVbx3IbSwU/wd9zaVnNaXH16QhIAW1C5EcOZ03dK+eQ5Kflft5VCk4THhm89FIXOAXNf4/Rlcp8eMi60rRrfOjCxyfEBok0R6M2Y7pZclhbAPryN84uSTYk+vn+1CLgxY4eU+0+VgnlrjjXuMUVGR0QRE/Fdk2hYksQASq0RNQ6MhpkzP9thA4/DCbj91YnKDHIC9tG9z6ZekkbvV/y0ffhyP/GSmEwXndBedFP+ihnYN8HXTDHf3/xBCCgKXr6hOXKCVLNxX6Pqp4cUJs5J19uhAuJ84VTGOYwHCE++ER3fzYed/YFbl0GRY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNdbit7e4RWz4c7D3K7RJFlIr4oQzbeWogEYgWA4gMg=;
 b=Ahk7mOg1eugsgeC8ibqBpJ6KAAWr5WfiJyMgGyxRV3hjez/KvvLWsKcEA2yt5gDrVeOI8iVFHjb0F4QaBlW8zluSvu0Mf+xGyJK6hvn+Lml3TPHkU5f3MvZoq8DuWbCf2+EEeUf1nBvvz6GQp3EmTI3cDEj34zEIzViSlhtd4I8vu1yKEtag0iHwFV87oGF8xGUC7dB1v0PquQy4+Y+zuLjDYdm1Yf0KOJOO5c9tQZcY9M5CwX/3OIddya2eDe1gFWhuTPUclhA1SCu46B8Er7OSH+Q8Pckqfaq1PdZ9pR6NrASqj88rnV6cZre2EMoe2suLc9rrB5sBXkq0JbuGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNdbit7e4RWz4c7D3K7RJFlIr4oQzbeWogEYgWA4gMg=;
 b=eTbMBiz0ZkouAgFOBMxJZDlQizkIBMQF7yBVaKCjLgV0DUIimOqm6GqDvRRJXiWHEmS4uHDUz3ELDgjcEMyMjMqwI/rbcjudZPxHRKZqJySufMw8lSLX41GQFzaGn/LvB+s0cj90JoywY7cyFkTFbneOWb+9eHCrsz8yfdVNw6Y=
Received: from SA0PR11CA0193.namprd11.prod.outlook.com (2603:10b6:806:1bc::18)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 15:33:45 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::ef) by SA0PR11CA0193.outlook.office365.com
 (2603:10b6:806:1bc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:33:44 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Apr 2025 10:33:43 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: fix NULL check mistake for process smi event
Date: Mon, 14 Apr 2025 11:33:00 -0400
Message-ID: <20250414153301.51427-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: dd42fbe0-e2e9-4a0d-b53b-08dd7b69be20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IYPihhKzCzfCePNjVCz9GuVT4URB4qGBKRL6a/wz0zYpZeVaM9Ejmd5f3mok?=
 =?us-ascii?Q?EcKb2xo/1mS/ztM2oD31ep/4OyD+7w5+dkN01nkWfFw/SvaEJxfTQKowRV/y?=
 =?us-ascii?Q?p/AfpjTlqb/xtj2gbOIn6D+8gYHxUN7/gXWY5B5WJD++NImpz0qvLBbeBFa2?=
 =?us-ascii?Q?5TeJrJI4JFgRJPkln0sPbsRL0P/TwzykcvzF65hoLIK1SE837X6J/OLdP8OC?=
 =?us-ascii?Q?+/jtU9I+XscNJvsHlHodPPElbUt+6UCUF2bPz3xZ826sKyoe/dlxEFnsboB2?=
 =?us-ascii?Q?IJOpKvTfInr/kEOzQsklMDeqAqxjc26eBgox5pRilBV15i5W6y+MYz/gK68+?=
 =?us-ascii?Q?Y+ergk/ehPsEGJYKsOF+uy8twfobkzLUrFjvLlHJkwPdqwrjrdYKiiiX7WeK?=
 =?us-ascii?Q?TjJWEiG1di+HNK2DgIh2zSLlV/vV/Nqu1NkAfA1nLFIyxMN+GM3clfDb79vX?=
 =?us-ascii?Q?4eJVT/LXjkjr344CbxqsKOQzT6vgorxZ8kmja9vZZCY0ufECvStIfMXOJFVy?=
 =?us-ascii?Q?85Sb3Susi66F1bmAVhpW6h/YVUW6wwTnnzgpaQceSu2rk4NQPT8hSndJVlI3?=
 =?us-ascii?Q?6RlDiZHWSV0aeEK5WRLQT/UvDG+QMZQgtWXFBFWBrHMvMcBcDYvu7fARfqsT?=
 =?us-ascii?Q?j1x6VlX9ocMfUB3GqpHciuIRraHyfMUZbFngKbHJnxMSF3Pow1DtkhFgx3xx?=
 =?us-ascii?Q?W6F4t9SeSZ2nARwTpD4SKgam24g1Pc6nsrESCMVtcMc74yMUSlao+mFulQik?=
 =?us-ascii?Q?aRtxiiWSYxNI774OpwMpKChr3hjuPvuHlBeqBLgtLj082k5HAUFfgK5mqtB5?=
 =?us-ascii?Q?7pFshnZT0n7R3xmbpf62qhuwAW3uY1xu7k5FusQMAqMUqTc4bEN8yu8K+fre?=
 =?us-ascii?Q?NUlPvd4ZDfZDFWTUUZ7Q5af7MWUhPiib7ldf6Zq/P/9UwZNFA/n8ubwIgeYH?=
 =?us-ascii?Q?NTmft6rF1tBk1VwKIHLqE2swwJrh0+0heHxHfD7LfoEEACtuaQW2VXD66zMo?=
 =?us-ascii?Q?md/VkEm6v4a9SeiKPKLOqelXgDIkhzVtcNy8a4bWHto5iwQqfKLYn02+uEeK?=
 =?us-ascii?Q?0hQLXC5IfMdBI6TYjiJBenfnZrLl3CqRQ7On5kSOsptaOufS3/spzaVy+Tcr?=
 =?us-ascii?Q?IXkKlnKJuzBk255PVA/0jvfL0ADmsF3ChKw7tMTb6p10vn2eOcmMC6cpYgiS?=
 =?us-ascii?Q?O+dv/cJWgXXOWakDUCCkW2wMM5vIUqXOdWOL06M/PMO6FbP7R5qSAiQi1na2?=
 =?us-ascii?Q?+/WpL4U3PFUKANMumbF74qGTaJoYjloOrORvvRlvHX1qVKa5p9nTf84P36x3?=
 =?us-ascii?Q?+GEt3sRd+0cDKb3AhQZnOJJOC0mFRUjguFgZAFtWsHnnUMV360EfkFmYoppt?=
 =?us-ascii?Q?jm0g0UodBisJk7N4X/JC1gF7Ib4vno+GIclcBj+0TXekSElFo+HC0xCyJTAK?=
 =?us-ascii?Q?3Fd0qP6R2kPDl+3lGsCX6Iz8HUSlNsXP3TyX8ZqChpykS6ay4F9he1vY0IJM?=
 =?us-ascii?Q?PO77eDTG2Vas1v5m4XTNWFPWZ3/1ByU5nD8n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:33:44.7294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd42fbe0-e2e9-4a0d-b53b-08dd7b69be20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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

The mistake will lead to NULL kernel oops, so fix it.

Fixes: 56ed4241e9fe ("drm/amdkfd: add smi events for process start and end")

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 727a4ce29fe6..c27fd7aec1c3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -350,7 +350,7 @@ void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
 	struct amdgpu_task_info *task_info;
 	struct amdgpu_vm *avm;
 
-	if (pdd->drm_priv)
+	if (!pdd->drm_priv)
 		return;
 
 	avm = drm_priv_to_vm(pdd->drm_priv);
-- 
2.34.1

