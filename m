Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF24CA0ECA
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 12:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A38110E414;
	Tue, 12 Sep 2023 12:17:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A3610E414
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 12:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIOdQtGmlE2cbFu6Xcxb/61qRodfEcuw8KrP9CoLQdqyTq8i3oGHOyM2Itis8GSFshtmaZ2dLPHdggfmg5V9mVFv47nlKBtLJunjEslV//NUvnO+iOJnahMON0/ZNfx3upZkv2AnUYRxf2ve5SVBGZeSBU4SzM0E34vo4kXtPPtAHx0nONXw0eMC1T9Qjh3ryJivKl0n/fbtEudj/W7CHwcpVgCJI785Fz6cPPbDthE3giy66xTfjpGoNLA4RZ6J/rexrfOQ7elokAa8p6hsDienQoFYyZXDXVGxmV8ANWf2wOjiW3bQAfDZUljCr/ZOi6Hlobzq/x1zxraga1+Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Woc9sUUWfz16HoofgYosZ/lyCSS2p2DKH7SyjGoeuXk=;
 b=nOkndI7UdC/IH/+HMIVXQIzarEP9ySjdNY+LhXWmYaGUkLfkJoaJG8cbnPJwosMW04mHjiCLOWwezLTBldCMCR9lAkLmuRx0aE8EzbjueP8IpcbWEkE5C9F0g0f81bNPcyEDCHJ5EmKuDMG7GFnvYFMP3R+45y0sg17O0znbihzPNoZxEnPt3a0fYbTnJ0ns+QN1hJ3Q5PnzX0nxvbro5aX7fTVgcBjDP0y5VpAoMgZeOY2fN2I4rQeXvwq1+uNqx08m4YXub36YmpoBLTL6nS9WJ94NW5VcmkWYSctJPFfckp/FyGwKp1i4AeZaxqh4gkhx7dEXfrVPEMgBVnHXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Woc9sUUWfz16HoofgYosZ/lyCSS2p2DKH7SyjGoeuXk=;
 b=NmxPpER/lRplRZO8b9bRMuY9iyDPYEh6cKHa5QbYoKdAqFfTiUuAsL+EvTSzyqFw1AHU+HaZVrl7CTo6mxVCp3Q+U2STfY+nJDwkKIR+pcM1UDgkF8nJtyMytCiUJpK4i187zyc6MCoFEMNV8jlvNe+No/30Y/QilRbM3uu3JGQ=
Received: from SA9PR13CA0125.namprd13.prod.outlook.com (2603:10b6:806:27::10)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 12:17:44 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::33) by SA9PR13CA0125.outlook.office365.com
 (2603:10b6:806:27::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.17 via Frontend
 Transport; Tue, 12 Sep 2023 12:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 12:17:44 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 07:17:43 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Date: Tue, 12 Sep 2023 08:17:21 -0400
Message-ID: <20230912121721.3035694-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|CH0PR12MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: d09ee62b-89e4-47cc-b331-08dbb38a44cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nP4WTYQ2LKtdDYRL/aygXoNr3oLqLhIWdUTHh4mLfuo/YM2KRKnBYkoJ6WRkdSYICjAZNgT8sQzOUNM1XD/hz119ZXdLtZ3dp/QDFYnCsMQUFdL91Vo0DUQXPMIga9sDsnhUNXB4YgBUxYA7+oxEXbtlXxa+2bS6Jl36NQ38LexN/MRJA3hS0ne1cWRSuUBoTMeytO0vS7ZPi0mJLxhs5pd0BAPT4mFy8XU0haKqgf+cFvl45UflDEOEvyMkxzn6vBEcn3qdobQ5HU7h4blIZYSXiM557WitjjtOjzLsYUkdwu7dQ/CtxZMixsWTo0PNvP7s2l50c03RZpVlYZFUpjXqHtxPFM8ZBp1r9yCXWGi7qsTu3KFCYT4PbU+WWYV4SHyh4GsblSASWjZplT4jiHMdbLSrG6M+PkrBgDZgnINmrw6tdUNod2BujhVx6C4/yCkQS5cN+7tiEame0QjxzgN3UUYYiKAmgAw9TvqaRL2ZKOh/avl1UzF9jg3k6wpx6x2Tx5lR4z0JWVh1m8kg5+aIqD0UkxLcSd9t1wX/9Q9RFf242U0ct876vkTxYa8ozA9MvgJNVRwDA/7QDRRVcjyBXIKRwr4L7KbY15cOXjHeca2QzxXHf2lewXm4i6QJr+62Oi5UtPMotNfVu+JfJpQKwkFcP0rWPyJXuS4yIX5l/q/lbrNPrs2bOubv/IeBbuXzsVdaUJT3ivpHU3QbJVtdGhh/g2/DU6g9WOkgzbV+bNKXPBP1uvUvOdSLvMwKXZh7GGXta+HVET/dFXN3cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(82740400003)(356005)(6666004)(81166007)(7696005)(1076003)(16526019)(26005)(2616005)(41300700001)(316002)(54906003)(6916009)(8936002)(5660300002)(4326008)(70586007)(478600001)(70206006)(36860700001)(426003)(336012)(8676002)(83380400001)(47076005)(36756003)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 12:17:44.3491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09ee62b-89e4-47cc-b331-08dbb38a44cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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
Cc: Ruili.Ji@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>, JinHuiEricHuang@amd.com,
 Shikai Guo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are cases where HSA is not initialized when adding queues and
the ADD_QUEUE API should clear the MES process context instead of
SET_SHADER_DEBUGGER.

The only time ADD_QUEUE.skip_process_ctx_clear is required is for
debugger use cases and a debugged process is always runtime enabled
when adding a queue.

Tested-by: Shikai Guo <shikai.guo@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6d07a5dd2648..77159b03a422 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -227,8 +227,10 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
 	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
-	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled ||
-					     kfd_dbg_has_ttmps_always_setup(q->device);
+	queue_input.skip_process_ctx_clear =
+		qpd->pqm->process->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED &&
+						(qpd->pqm->process->debug_trap_enabled ||
+						 kfd_dbg_has_ttmps_always_setup(q->device));
 
 	queue_type = convert_to_mes_queue_type(q->properties.type);
 	if (queue_type < 0) {
-- 
2.34.1

