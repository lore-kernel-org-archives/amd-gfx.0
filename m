Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BB5CD5BC0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 07:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D99810E5E2;
	Mon, 25 May 2026 07:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SAA1w+4p";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA2510E5BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 07:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaJVC7IDaAcC1KNsOrLMJTV8iuRW5JHPBQxjeJyMnLT7aZPSSPKMMesLEtlyeTN3cPZNp/9fv7Co6coS/NLIWciY2w1zjmdoqgRsfJievs319QdmtyT87CQtkAS+kmdH+iuS01GjaXntXU4XzwSpMXhz1gcQpGmIBIgMh7mjmwBzIHEzpWzUG21ZKJO3F0haeGOKJzYhYfCgiusg0Z/m1lZnAqCmIoNPB6w9acmMLKUF2/BPdpx45wtqo7fpdz7LGH7n5UsmuyzbtB6IL97bWYBgjQLYZjpGK2FNb231HiTtogUbyq3r9k/PUSWITjH1BhBx10Wu764Om2Y7JuTWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es8GkyGZuauhEg3gMMivp8hEYCfv5grb5nRcJA2j/LM=;
 b=SvDpE6PhqyPJSdlPk/sEJ1JmwqSoFzke/fpngolFw/Xzvj+uazLy+5czSMYDg1se54AIT296TBqB9GJ/2y0Nloi3JiQp5rXICKsWnO0841FghwSaqAG5dRRGqgg3PXi4Jjg1CYLLYYOPJoxRoatoRnTd3uK5TbcacvuN1mPl69n5/gNEwtu+DyQvoEzi0CGkWAPLseNbBR/9Npqc9YzSxv+2+J7RUoIwk1xB8MnCXd9vdZJSP55SJn8RIsqOc1K5dfLmQIgwFacqdFyZuUAMW0ce0/JkKsR98JoxMR6beS1sRRnkvMvlyCPSe+YZarvAejELdfAI5bPosBJjusXtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es8GkyGZuauhEg3gMMivp8hEYCfv5grb5nRcJA2j/LM=;
 b=SAA1w+4p9e/E9Evz7kN40euhIIqlLp9gMEkeVEKN/QS7CniYa9XFLyGWnnuGXZYzOMmsTDXKAdJj+M0SHjBtnkyEQhi/6TiYCgkNUXYBNt2M2I4a+ZbhEpyIj9UZva9g1cl2PxdgLsxZALBRe6eZBznBU9Ei3+Yir7Mckjg+v6I=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Mon, 25 May
 2026 07:52:05 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::82) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 07:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 07:52:03 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 02:52:00 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amd/ras: Return RAS TA injection result to userspace
Date: Mon, 25 May 2026 15:51:44 +0800
Message-ID: <20260525075145.41818-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e2edd0-b2f9-45fd-457c-08deba3282e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|3023799007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: MHJVhV/2UVGUKfamK8KdEfcOvZWSXRFhGep54gWxlYcZ3tgJZyXSgIRu7QPKpKclvUEtkYyYdoN5zhw9btpWaspIsiaFENgc6lTK2ANtot8CtyVJfk+gwoHnuja/2McDkcz8VsUEe28Lsh42djK2LOkDLhFZkQZeUy2RHTpJDttjuVseFU4Bvfo4xS8HbdqhrwQcelHDdK2T2CGtaawjPLptG4vvRfI7QZVOeJdLBrS6/NufJr8thuhXDx2JB365X/XPOfxoSY865n1TXCbYXd1QfQfS2dpbjo60QsnbDd1l82LhfK43cXLkVQ0vU1p95rfR5LNNuBIt9M7/WPNckxvaRXhXdCLeEo7cC0MVKRiCELtBd72nXMJzi+CRfFCZghTNy8wMX1LdOm7qfOJ52hEtHcfvZ3q8/HlXnhyIPtnvU6Qw9LTkF8AvYonvc6xD3+ZQyVJtJbQOlX1F7US9MQMkPFNxxyyYBYPffHHMH042XXRcEZP1YDPGDih4Boe8Mbmn6lHQanDgovnHkXjEW5/dTaSRHVS/YnMYlJm/6Sc82pjNzBRRVv+vCKxdgqyYlw77KNDq2bGzem/cQo5SGXe188wA1KRpvf0haWAe8Ewan7eBu5+U0lHtpAPmmnlBHgGrUZDISkpmEBJD5rwp/2HP7V/b8yY699eVYAop6E6/fgBoSrlcGOMkjqJ7Xl6rGBmfUGnuDgBajcp1w6m02kwTbl7ROrtbveYKha1r5BY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(3023799007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0rhbsXPKhi9/QhP9cGhCe2GnwxTwgEI8lZ7YxldFqwrYfBRDv4KmADya9dGDE7zHP1po/9c4sp9Mp74i7aNcri9ddbsc219mpOCw9fXJ4rJzannGE6JKMN8IQ9LQ6BrEzu6C9Wq3YabAnl7wK2J83lXR5RzJn9Xu+EMhpelVYyjxJ9qywfby6gd0oZhG6cjGdGZ3o4MyCdEVOeSkXtvj968+AL+yurVF0tUc6yQidK9823lGO3mLMzxQiyvFTVt9Lzedoz0u/80XZXC9bAWg97pvBUDDCW73NVDABVec/ngJPdniZU3pdP36UWNIVaND/1MT9msGv7eySXt6TyzjB9WpRU4YAob/KvYAXmbODuOXJrJpQfHRzKVdaD3pJA6aguJVOriRNHAREViZKTndQo1Br9qPXL8S97Y5hMYfBLJ/Nwr4hNvctEEO1YGDVJx5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 07:52:03.9176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e2edd0-b2f9-45fd-457c-08deba3282e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
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

Return RAS TA injection result to userspace that avoid
app continue to load work once injection failed.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c        | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ef09a6fad659..11f01b2ec211 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -686,6 +686,9 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
 	if (!ret && !cmd_ctx->cmd_res && output && (out_size == cmd_ctx->output_size))
 		memcpy(output, cmd_ctx->output_buff_raw, cmd_ctx->output_size);
 
+	if (cmd_ctx->cmd_res && cmd_id == RAS_CMD__INJECT_ERROR)
+		ret = cmd_ctx->cmd_res;
+
 	kfree(cmd_ctx);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
index 5d556e2a7000..e26fe8107ac7 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -417,6 +417,11 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 	if (!ras_cmd->ras_status && out && out_size)
 		memcpy(out, &ras_cmd->ras_out_message, out_size);
 
+	if (ras_cmd->ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
+		ret = -EACCES;
+	else if (ras_cmd->ras_status)
+		ret = -EINVAL;
+
 	__check_ras_ta_cmd_resp(ras_core, ras_cmd);
 
 unlock:
-- 
2.43.0

