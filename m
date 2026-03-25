Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C03109C050
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 17:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FE210E2A7;
	Wed, 25 Mar 2026 17:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sPDRY3H9";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC09710E2A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 17:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAvLkFbaKnioQ7EyhLYeWNLad0Zn2D7U+IL8UNO5zE1y56tXpeEBpWUN24TREgM0kVbRP+1EvzmD5tVcsL+vI7BgFmaoPR2z4YFZvKTtlkf/e6hzGakGcbX3Zd6ILwUU3qllU/VV8pLQHHop5QOHDJo3fqKjKTgX7n85zxydzCvQKTJlNEa+Iut4w+LO5akh8spz9m/jqS0N5KeabUQkpUhgkDdfFu0VB9VTIjxBKqXuw938dvbwuQ54BJhVpZ+xmyB+VwZj1H8WtEMtVM4p+538YCwrKpOfD7D1oTfRuuYpOoKPIHj7Kv9VVdtK1YsvSTrgK588ZzPBy0VDnfRudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLuI84Cm4Ngw8Iq/SYM0EYIg+za7lt0Vmc2IMHCcf6w=;
 b=RxbySD4u6U8ZJJBCfzwkbd1qLdyd9GFNS8K268JAtfqYtfcgLhHlVLOWz9Pb90K/TbMiMu1yQ3QOB4orApiCZ0x9/raF1OVzdo2/3zQ5dY4Lt5WzA+AbntG3mespRjxFKFOVp1xcijvg4n2ssu8JP2FDwG58yxZhXk3Y6nUeczzwxondw29dIacmrOYz+Vljf5zXKBsCI//lhRPScugci9yLaVyjsQ2nRuE9nZepWPcxsjpg4b7dGLQAqL7RF0bi7saELbTsAV4O8UJudWCtzgH6+YZADJsUZXI5pk/rNTc03Qvl5PxL3iIH8lYhJ5jY0xjpEk09yiUdM5t17PSxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLuI84Cm4Ngw8Iq/SYM0EYIg+za7lt0Vmc2IMHCcf6w=;
 b=sPDRY3H9qGxu/qWCnu6fjXNi0URH27k+PIe1oiT37QFdaFgGGK8KqbpEjLdNv8Pz2Qn30nSgBZL4cpQt3URkpMnqZIMyw4wLM9kB7P6rROA6mUL5cUISH4iJbyoAQPqIyp+/eXxK0jqhthHS4QXDkQ8n2AWKPnBtyQfnqfrSeuE=
Received: from BLAPR05CA0031.namprd05.prod.outlook.com (2603:10b6:208:335::12)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 17:52:16 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::91) by BLAPR05CA0031.outlook.office365.com
 (2603:10b6:208:335::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Wed,
 25 Mar 2026 17:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 17:52:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 12:52:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 10:52:15 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 12:52:15 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 (Ming Qiang) Wu" <David.Wu3@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
Date: Wed, 25 Mar 2026 13:51:34 -0400
Message-ID: <20260325175135.3326685-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325175135.3326685-1-benjamin.cheng@amd.com>
References: <20260325175135.3326685-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d99177-cf6d-49f4-acbb-08de8a9740ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9AZitDJxC5DHpfFJahQ+D6/ld4ZsGPLSHmMtc8v5rOvB+JNX0D3/EFdkSWutZR+e2shjpnHEfUSs0l4X7DUHmrL8rl4pF4hlDYi0j9y9tDbMSGdLxMuNEF3yQvNjBvJWEKhdzo0LZVz/KBLYzXwxA37xrK9qKsPndvPRMiL6sJplUB+sKYBRfTZsq4FQCDBOJ2Ymm58RlrZE2jdTGEAHSI3xveR2e7lanAZ2Sn5rDWEKeGjLPt12XZ1X67qkuAX7vwrx6BENM40fCeQGxY4L/rxreNDThKNOOk+fsyrhCEaI6daXEjI0i1GzMQfKKq/ftiwJmKwm34HyyWl65DzTROsBKFiEfp4eFhm/bM3cX17x1aCxkf2cdWzZmtecbKc0KJDRZy6E/kycCGxummWV8pGuWPlGBsZH9xVKiCNxkfWoGzpMOCz7Q7QKOkbt6HcO3x+XQYVTn3LDKvB7/Aw2Lq52ntvclQUyChefqQ2ZC+FRJ6UjHg66PWeqPIDiA5+orh57g7v+wCCPz9wSq+CO2bULYVOs1HtSb4hwpVpC3vDH/AND02ISUwn2dDtiXZTcxaFd8uRpgOZFHsRJi8GVX4bmlMc7DCGrIuB+xA54FoDRLGVCSC00Xof3fuRhuBWeS7MEkxxjV1mYCvkp1yMGEm98VhIhrnehZ5f5rbefaJLP0i+vgp0PqgMMsr1KBe7Ih7wfGuILp64yG0VnJRXHKWYtJRCGVrGqYixEnvSkyzwGozkjIuwvECB5KeAZHpeYAkQ6HFu/zVceAYqhygJYsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r2Hb53E3Es83uwQcSJ/CnObAP3jLnCaS9xS2GmXDTFPAPY9dMTmgkk5etSCrFZNaleMHLFyGOW9bSYUnf/RCG67IZPAwUSkzLvrgA4fIOJLlca3vZE94NMqZeq0yruw0Dh5qUqyJZR12fsGLhDhbWZxn4yuhTKviEEVchEJxKwU8vAwcvdr6oZhJpNI4mRFWfBRNvZhgfTOidoxr5PodbPSLcwUpV6N//+0VaEbMjE3KcXKTvssR+07UJsQFqOqltXVtg8b6dnzhgwiZW5ahFzsaY44LXid8OOGxbr/zB3atH5hkU1MRpm8RIqHtlX+4AiKUapd2t04/tI/HnJhDgUW3Z5E+KlaGpFE8j6vya8x0yn+p47NxCIR/DOpV0f4ppGqsTVl24PjIAoIC9KEvgmKbvrO20u9qcSEvscocb3cHFxj3eYOtTcML1VDVtDgu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 17:52:16.6852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d99177-cf6d-49f4-acbb-08de8a9740ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

Check bounds against the end of the BO whenever we access the msg.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d17219be50f3..f0f492777b09 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1826,7 +1826,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
+	uint32_t *msg, num_buffers, len_dw;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1863,6 +1863,12 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
+	/* Make sure there's at least 4 DWORDs accessible */
+	if (end - addr < 16) {
+		r = -EINVAL;
+		goto out;
+	}
+
 	/* Check length */
 	if (msg[1] > end - addr) {
 		r = -EINVAL;
@@ -1872,7 +1878,15 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
@@ -1882,7 +1896,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || offset + size > end - addr) {
 			r = -EINVAL;
 			goto out;
 		}
-- 
2.53.0

