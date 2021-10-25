Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3568760FE8
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3568760FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEF46E1A3;
	Mon, 25 Oct 2021 17:56:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301446E1A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 17:56:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIPGoApuDoPK/Tl0gh38N7BqKCexYQheemVcTM5XeIGyfVAfb4pLA+KjTFnMDv3DQ+WU7WroKNCYdNNARNbFkME9OLeD3QRGOiP+vvV6rwuVMkQw/p+W0ids6PyiyaUZb+cF8mJuzmws++EBsGPx51Gqo3yNBkod359VJWeIERHrTYH2KFoCySW9bwca4XrrSE4cjlL1IW2JvxRGJtRmJVuNcFcjg6UaEUVT8sfSJXrgQ9IiO/P0H0AdSbGaTBeqNYNz39T8RQ1myKIhwW58zcQBPKboRepwBSH6ro3MkHCxEr8VBSINLItTigt+oOsSy6M0R82c62scLr4xQxY8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UadZaYDN1SwYscjZp8Jxf6DEU+rR/8dM3ncEJrVQjI=;
 b=hI7le36qdwrgfslEOGTZElUWvrQQAqV/AhhvKTVQiB7+L3fGwQ0yvXidfgniLMk/ypGVF5riexJls2x3Wm3KddGTolMM2Ahn8fdFgeBG8UFPixN6tUmrneGTTpo9cU5e5aySPCjX6TayrCXXwovGHoJq6TTsVq8Yq9SbVt+mI7/PK+A17xoPGqRjrnFsEq9iLay105mpRku5yVmnqHxTZJavaF8/FEk0CuTiHJHPykyZ6DYgu/lFJ9CrIQGiMGr7xNvzrn3SvmsmMCDScxPsFtwg3p1Pi0H1ktMHSo5zPUJM45EkcP8YeePgNMPktpdB6Gfn5f1660N7ZmjCV0KQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UadZaYDN1SwYscjZp8Jxf6DEU+rR/8dM3ncEJrVQjI=;
 b=ggclCH46Ar3gNNbHb20Fa2hXz2NottJfWDgqMg64iNwGTm8/qtmwp0tS2jNfX1RWLxkuoOsjwnm7IdZ+nxnFHtciamEBm0YWuP1oUCozUTqs5VgwH/pLJ5Sget+B0Kh0qBaoGsFLDvaP6xnVi1NnU9XHUNXpL+V0n2TLtNH/xNk=
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 17:56:08 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::85) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20 via Frontend
 Transport; Mon, 25 Oct 2021 17:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:56:07 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 12:56:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 10:56:06 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Mon, 25 Oct 2021 12:56:05 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Aurabindo.Pillai@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 2/5] drm/amd/display: Fix deadlock when falling back to v2
 from v3
Date: Mon, 25 Oct 2021 13:55:54 -0400
Message-ID: <20211025175557.148601-3-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
References: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b4f88cb-e5aa-4451-f915-08d997e0b8e3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4572:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4572FB4C975BF266F6D392B6EC839@MW3PR12MB4572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgWMQR+CwyP/OD6t43vTXbUHa+KRNyVuVLo/T0XobLNfHqvoBAvYMeweMuulxVVMfaLgJyqfC8VIkOsdNHsYGfa3ArGfJZ2eE+Hc5ROzZF5AxYdxNQMUtW1/Eqxe9N5wPsa4zohx6WgQfgLceockqXI8xbPRyAAqGhA1RDCyyLdAFmzrjiKEMpW6b+HWGiAcxjBe/d2mvtoH1tJCmM3JQ/F40KvtBPKNsEd62SAI8qh0tfoYcRCNvcTgNdAkOKISZDgJYvZHDCYGK9zdltYocjw4k2OOqshX2srqAU9897V/vLh4IRLgzyZpB1jD7dWXH5iK8gkR+9gzK4KyuDvCufuFhCjmynIZxC7KGGmD+f1a02e3myx+r6SNlVTyc7hHbrUgkv6bb7zHo05K9/7Y9mwNgZSJb0D0ZwBEozTlw6N61E+Y6Unk86LdOinqtcUPsAdvFmyuETUPy9zhEjHxHQKxvDFWkqTYeBH3mVNzOCcNrUrbQ6Ziy0RTvEAMkQQEjgLmSFJ77LuZ0raXXXlmOn1GrmQ14PzdWVi/VFBoXFXsIDou0Qr1bGgs3aHKu8FS0B9x4lmRr5EYmcYG9qcj9skg4j+HCBhj3PVsyM4AYWWOP/haaTsqtB7IHAieFTSwqpjmehM9AzaGxeU10DFD9u5jV8OSfgl1A/IhvoOLpFSKe4vLGcPG6kbH5PJqnuqNugpcPy+hOMPtTXMcqrekT9wh/BVb1VhmpHQKEcwc6iM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(5660300002)(316002)(6666004)(83380400001)(2616005)(426003)(26005)(1076003)(82310400003)(8676002)(336012)(186003)(6916009)(356005)(47076005)(2906002)(36756003)(8936002)(86362001)(36860700001)(70206006)(70586007)(4326008)(44832011)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:56:07.8503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4f88cb-e5aa-4451-f915-08d997e0b8e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
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

[Why]
A deadlock in the kernel occurs when we fallback from the V3 to V2
add_topology_to_display or remove_topology_to_display because they
both try to acquire the dtm_mutex but recursive locking isn't
supported on mutex_lock().

[How]
Make the mutex_lock/unlock more fine grained and move them up such that
they're only required for the psp invocation itself.

Fixes: bf62221e9d0e ("drm/amd/display: Add DCN3.1 HDCP support")

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index e9bd84ec027d..be61975f1470 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -105,6 +105,7 @@ static enum mod_hdcp_status remove_display_from_topology_v3(
 	dtm_cmd->dtm_status = TA_DTM_STATUS__GENERIC_FAILURE;
 
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
+	mutex_unlock(&psp->dtm_context.mutex);
 
 	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
 		status = remove_display_from_topology_v2(hdcp, index);
@@ -115,8 +116,6 @@ static enum mod_hdcp_status remove_display_from_topology_v3(
 		HDCP_TOP_REMOVE_DISPLAY_TRACE(hdcp, display->index);
 	}
 
-	mutex_unlock(&psp->dtm_context.mutex);
-
 	return status;
 }
 
@@ -205,6 +204,7 @@ static enum mod_hdcp_status add_display_to_topology_v3(
 	dtm_cmd->dtm_in_message.topology_update_v3.link_hdcp_cap = link->hdcp_supported_informational;
 
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
+	mutex_unlock(&psp->dtm_context.mutex);
 
 	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
 		status = add_display_to_topology_v2(hdcp, display);
@@ -214,8 +214,6 @@ static enum mod_hdcp_status add_display_to_topology_v3(
 		HDCP_TOP_ADD_DISPLAY_TRACE(hdcp, display->index);
 	}
 
-	mutex_unlock(&psp->dtm_context.mutex);
-
 	return status;
 }
 
-- 
2.25.1

