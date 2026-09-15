Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFA5C88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5A210F220;
	Tue, 15 Sep 2026 07:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3uhd0X8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4265910F07E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjvKq2lN1Idj7LnqD+kTBD3bLFZfWBGv1avIl8r67Xw9HF86PuJ5v5drW7kuuacVYBnPq5oSK0TRZoxLsES8ozFVo1kfOfDWtrs4Z88kjpEqwg7ltbXuiAjmrIQ0wgIJ4hMQfAHpwJJ4wLC5cIMai2xu0Zf0ayJ04TqhZ5wo866wsn9CQLobW9V3mGQjEf7+5NyuIEXZb53Abh0/fhLSKjJzTDiLTVaJnvgUFs1WOE1L7Wj6/pyvPkuKuYu3y7Itn8nobKq4JRARodAvvAB948Zvkc0Y5CPjujsltYHobavkcNPaShwE4sofO9daKjeh+FymGdbDFiaH/K5s8j+VXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx1xKDv29gR/IM8/fAKZ98luLGEauUxID5ynp1hg8Ck=;
 b=uBzvytCJ34BSJ3FjcOAi/OPmWUflfe0JppFw2qgBZlT7ntOacyd8BnKNPyt0xkZyX+SvuoNFTdTFsYWMJQcS4anLURphwADlxaEl86RqlqiX0bEv6qQH3wXh71JTlJkLITMDTFjW8voJdXp2Ao4iY6FTy1R4FDu4eNh8ZqOSLhVS9Kc5dw+AsxybbbINHG6XUIaKTV5bjijUebrjZ6ft6Cf6ITSAuHtYDXcqrADuWyHvywWqmDKEntPARmBkskvVgyFcHkoHsP03vz/t133YIxdjFyNYo8mAtel4A+wsCVoAbYMXDLYA+n0vuofkAqzMMKwmZlo0/zusdDZ5RMFNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx1xKDv29gR/IM8/fAKZ98luLGEauUxID5ynp1hg8Ck=;
 b=K3uhd0X8mOUts8Hg8CErGOj5aUEfnTPkErVK27TfHOQU5CekSa677eRz47O3/KGOus+OUXu1Gk9aJ378TgsUfQX1gdqt6PO+0efaVhR4aaSkK6qBapQwl91Y9Gs/ZU5QyfR49Y+1eo1Hd4bvopDozm+nKoYsGQrLugbMnxyNzXA=
Received: from CH0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:610:e7::23)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:20:09 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::50) by CH0PR03CA0228.outlook.office365.com
 (2603:10b6:610:e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 07:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:20:09 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:20:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu: extend UAPI for reporting userq invalid VA
Date: Tue, 15 Sep 2026 15:19:45 +0800
Message-ID: <20260915071946.710846-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915071946.710846-1-Prike.Liang@amd.com>
References: <20260915071946.710846-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 59850ba7-d6ef-42da-7cd3-08df12f9c660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: lzstmbtWivmeIPq4jbeZoN3MaHHe6ELVw6MfkJuCU4oxz+jt2rrSvpbnyRIhO4Kjtu3+KfAaYamfs1P9Amd/sLHlgy1z+y0++vAW3QE+VnW+1ovy8qxU3N1YRMPoRWTMjQpT7A7azgYPNbt7n22lqqnpFsMK2RBZrx81FMtYds5bIzo4HN4Rg7ADbSUwb2Rg4xZGENJpnEn/bCqTYTVXMwkXtE6U9kIs7DxJsOMXXnxTydB3IdIFoudOLlqux1lrICW7WgFmNb09GgxLSU5dOPuIqqzm3edhVNUWhjy4oGazLmNVxG0M+JfiOqi3OS3pWQAiW1tYphlpvkO09zYfJ1HiNwWB3Q5rLmoMfjL8LkwTUZTSxZDWdYlZ443TMHb/XsOQ/1XHiaTyi3+lX2rZXiU/brnJv9GQPjsb2fV/rccuMrcyrnwXaS5phvuMJhopms5v93HLt/PQTpEflNlC+kGLCRrZaJJB04lK0ofrIYlsc9+PnKW1r8H3no2KWka3LDydgRCMNo0wtehnUaFLTES0TRnjIpaKmwDG1gt9IlziAQ4LK1mkekwgeejttWBonKT3NILiCSpsAVSpGCSnqp7PK1LOTUEQImDZxrMJoOps7vxr9MphC8GWk4ksUPS39rBuCd5Kyi8Ix8b2srbujrNmcAnzviJCTJ90JnfF7AWwYDkZ5cNOicClz77qkG6kiKQsoStKJKby+9Zbw+cFPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a9O2SP5etURyuyQ7QQ+YtHr6WliCS+NB+oH3UWbAB0npkc4bZYxtiGr5QuZg20ThDrhK+kh6lCxC676h6QZJyELQ+walNWO4viJ3TP11p9lQregPKeM5CoMy7AMdfKWSXm3lbM8viVskOuyEwxeiD7ha+3+V3I+3chdQf5yYkK9c5aHxuGyvV2CTJ4RFRayyFmhfwAEAzVCaqXMoJ1kWIXw0nM217IF6vRom6BvqWj3flGq1f9WvmPxIdSKjh6jD8ARu6kltmVatLKK3olGD6E+fof1pTXwYTHzNNqcETOhm0q074lYlaVFeDi2pe6z+RgzYBzrTtOiackRWOquqzsMlYY8bLPwFsBMrUjf6Fjjn/D1ehqxYiG3PE+Xt2esou6MlT8txMjDSi1Kf/XYbVzFFUnLaxCKUhVfs5RxksDhhDq7oQzE7dwu7XplZi7DC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:20:09.3852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59850ba7-d6ef-42da-7cd3-08df12f9c660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

Add UAPI new definition for reporting userq invalid
virtual address status to user space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1be5e70dd4e8..6c92575213c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -835,6 +835,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 	amdgpu_userq_put(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

