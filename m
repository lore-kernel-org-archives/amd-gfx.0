Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFBBC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 23:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2F110E36C;
	Thu, 23 Jul 2026 23:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DMgqugg2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0321310E36C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 23:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8hPCsvYzoS6eId/wIhvxvp4L3pM6fF6iXWs+hK0hMEpe4CFuVGtpcLM3WXlQMB/RjmCtf2iQEFT31rQ8ZA2bW85hTW2XPUKfSjO1MQQAsqpKGR4hRF+Ej4yW2m21ifj599Tn9urkBa4d6Xez8plnd3mWlS0lXF36ODEaL7yemprzWkZBF9nvvEo3XsQHeFMqb1EC1d62WhOUdvdE3iEp+maZ/nc5C+uAjZktwGqPuphVjaWqUyqjFD2T993JGI2g3jHZTlNL0sxoXIV0MDPk8JDeh/QkaQgabzH75rjTgL4P2FgJpBtjCAVbXvSXlPK9bRgCMmJUFtl+4nIn8N2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n+JSRnI5wX1NkCb884a+A/1WDMJiFtZsIzJYlw1MwM=;
 b=JOJEffXuHnZAwQVEIH+JhY6XVKD3oTwy+VrzR40zDU71Y8JSt8Iz10wt4P+hobTXSQQIlbTbVVPfvS3rDEQmEhzE+JrGkKMObTefcj1nxC/cJkBRN275lyn0ABnNawn963XvMJ5lvKgP1Ug9ySUrJoVd2L9oCU0CoNY/4BPp9zNKID+F460gfl8pS1zaPL0Q2JP+HJNGqXU1YEJDOQALXSD5AxQIRUBYA9EDXl11iS504Tt7YqPCWnQ1PkMahDA90CzDMVZsCCwOIT/nvrUCJu8Uf+gVvz2jD88u/pFvlDXTtTA7y9qHy/z6Yj5oxx887u7fOL330/UFjmG9GpIS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n+JSRnI5wX1NkCb884a+A/1WDMJiFtZsIzJYlw1MwM=;
 b=DMgqugg2U/cGMt2QSuzokAT3elGUp4ggZrdj+Dut87NAyYTtRJvODman9EJzvVz8lUOp4FzeF1W+OkTI4CRfe0O7Yj7oekjUbZh5Q84TjrTdnwDKVzSevPOytVVWuj6Wc1O5oV0UoWEK7g+Ln27W9E/ayQyvo5cWxc4Cr9sZ1Is=
Received: from DS0PR17CA0009.namprd17.prod.outlook.com (2603:10b6:8:191::9) by
 MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 23:59:36 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::af) by DS0PR17CA0009.outlook.office365.com
 (2603:10b6:8:191::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 23:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 23:59:36 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 18:59:33 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, <Lijo.Lazar@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras ta
 runtime command path
Date: Fri, 24 Jul 2026 07:59:18 +0800
Message-ID: <20260723235918.1090518-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dc7747-b299-43f2-e5dc-08dee916731f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0gcvNCy0Oyc+LMtDAOVDfe1KUwC6CIb+PZC779y0Z/RUZIgG82kMT5zqXCIC0WJ583smXO0BJpVdqiofd/2EX++jYX9WrefVS6XvLgyFDCtqxSbjdSxfLyMleTl3XSxTF26M1QXVCcD5650E58Fx5Q/uCen5kAnmAoGjVRvB6qXAtEFWpApjsBFXHv2TsQr7UkibHv9ro2YJdcixbdeWTRuB9Z7sLm8H0Vds0LIm2Ugwt4KexdEitUx8YI0B6mo4qcg0Jk9MYzMDUc8871DoexrVKYHeKwC9C+zrmNufv8+pYvcMVRV7csZ8g3W+L3jQWmSp38d0zOkCnfCvA2sz8BJ8yBeTX3Nv3QJmT2qaSxjx6PBc4zzAcnRtbjVT0bi7M25nQJQnc5fgPm046t79lCZLkWwZX9ZqjnpJQ5T4AI0bQfiIxlhFut0tMPbpBgmw6u654VgZjHK1TdraIPsT66PkfmRQiGhyYVpYgriBKzxOpHnSQ6RCGuwHsWjIx0wYifCPLtJOoBOWIb6WBzWEZgSd7qKoOORhnYtUwrvf++s9EczAlqYHtOrjgYCtyR2FQD5MNHI+GA04NG6ihIS+wXTmccobp7C+P2ab0Wa1dc1vI35I1u0Bu97t3HR9DYcoL5Ev05GnnA/sEW7GI6BwK9E5muMzhFPtflR0/sYvaUQT81Desch0bwfnEgNbmuHE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P0oL9lqYtGkmfJP5T9uDuYaig0pKKGKrcLdS0mhsaAB6AqOgrTeUhwGWYnDpEbGQ1MIm1lx4E1/ZWx/YupNmnoEcqKB6gT+T/H8lscZAOPs47XZ3emKrcvZUvPRbB8XHQKCO+jVi4v7JcKlK8QKTMwaqPQAlBhKt9tcOWzZHfW+7h3zE/fm1RY3JcuvETOsk4ob1A+7K0nV2JwNY/mAqyYoEqLGZYJSfglF9mNRrpIQG5js9ZmJQKrPcip86VYMEPXL3k5qxKRVIksMFmUNtn8DqrCwA07uIlsMo6a5PaeqUcnM0rDeRGTi+lUBkd/ArkVxxOdU03YBous8YLeA2xWQBGThBTLgXSQ490HSbKNn7eIuO0BNXYESHU/00KCE5xxbawJnFteZjWq8tZFPYfnExQJoywtFceoY3XsfKheE4prKDWhz+Bnlh4vBv5hdi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 23:59:36.2372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dc7747-b299-43f2-e5dc-08dee916731f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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

When PMFW enters mode-1 state, it will not respond to incoming messages.
Holding gpu reset lock before dispatching messages to PMFW would defer
GPU recovery processing, cause undesirable timing skew.

Remove the gpu reset lock acquire and release logic inside
send_ras_ta_runtime_cmd, prioritize GPU recovery execution over PMFW
message delivery to fix timing dependency problems.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
index 358f602b167d..fbe91eb67c0e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -374,11 +374,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 	if (!cmd_mem)
 		return -ENOMEM;
 
-	if (!ras_core_down_trylock_gpu_reset_lock(ras_core)) {
-		ret = -EACCES;
-		goto out;
-	}
-
 	ras_cmd = (struct ras_ta_cmd *)cmd_mem->mem_cpu_addr;
 
 	mutex_lock(&ta_ctx->ta_mutex);
@@ -422,7 +417,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 
 unlock:
 	mutex_unlock(&ta_ctx->ta_mutex);
-	ras_core_up_gpu_reset_lock(ras_core);
 out:
 	ras_psp_put_gpu_mem(ras_core, cmd_mem);
 	return ret;
-- 
2.34.1

