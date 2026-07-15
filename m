Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62889C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EA210F09A;
	Wed, 15 Jul 2026 13:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4TLkGROl";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E9B10F09A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP2PDUItHotqVpfaL4aJmkfWz8HatH4LQBzKNaEN36zuYOb5NCbUzryH9CUnVSLPcAC74sWghFc0bwM74nEbF4UvrPRcWZ5YqSPs6oNMRhW7ugzlp0pQiKBsv35sVBCxrgl83zPTteqxZtMFwlKqCej/1LBFrRROh3v5d4UGrJt0q2GTwvigAkqC9fo3/5u9BR0qKK4hLdFpq8axTbI+5mLqQ0dBp+vJO01Oih3/AEl8CVeSkaUIZbpePFC3VLLXojbAJB3HOGfVtyLQJwJBYlQlmBySmaUxHzg85Hgm4qOlvhB3hBwJwN85W6kV8E8VrWeAtlaNBHk9OdhUvdl6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfSlThPIGZfwvg8OEC3s7MHyULl46AFbmuA84TLDRRg=;
 b=d+zFqVOVAmYMJlzGuXPs6TKs23v/6PWueIjrFjFSDu661l+WKouZ72Ly3NdmjKF4fa8WjpskGC82I3Mdl7dEcDPkw/ZmflQQfXqNHbhe+5ttDcfo9HkX5zGzYPCSlbBs2pw0wlA95AbKTS16A6UxJX0VJXzE3VYUNJzr3MkQn1Mnjdt7uZwibmoab4lrs1MSUvyioFKnBNta9ZQId2LdwVIV8QER0YvQnQ1VgBdFIW8j7Qm3H9kVdBFAypQJOlCeeH6uD+M/Av0p/rXh+A5xRjymm6nxrEPbbOGmU+sZDZHjddVn0sRY+xKp8U0o657YImUZIujRTBd4F3s1eiMlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfSlThPIGZfwvg8OEC3s7MHyULl46AFbmuA84TLDRRg=;
 b=4TLkGROl8NKWoKgW48i3XA1DU0pnztnWzWClcaxis/Qd0dNwWxRScKkXDPUbIZ0wSaiP1pnoUglm8uz0EAxRlU92ZQBY96pLBCQY1pZE03XYrxlVSebyH5N5afFGHVoWCHPQP2RNtXfMwQwL7/vt5izOt6c64TSpC/A4hkDVvkU=
Received: from SJ0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:a03:39e::29)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 13:47:40 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2b) by SJ0PR03CA0294.outlook.office365.com
 (2603:10b6:a03:39e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:38 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 44/70] drm/amd/display: Adjust the structure
 dml2_dchub_watermark_regs
Date: Wed, 15 Jul 2026 21:37:54 +0800
Message-ID: <20260715134432.1975118-45-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3dcd37-91fb-4daf-3934-08dee277a346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gdtKN4RRO+IqL2uASbF7rzfRb8MfXi9HRd8LRFFg5kTiMendbjXFnnNiaIHSB/U+6bJLbjZPXpQtL7PyLHGweaCvvRdYU35gp+VY9HMWjTp5BmwDbBS+nh4F4OAtkuftHA9u9EgU8CU61yt6OW8dfH+q4ew+RMOXrUL+kfk+IU/dzsTvPFxkfLilB8T5A1TyDgh8pWdE14O+31raH14lzL3LpVsiYekcboDcrk2JL/NNXEC5ZVW5l7TDW+Bo8EmKZrYmg4xwyRnuRzV9upbcxE9OAqdHKRPKIcp8tcmvORaxzpLu04+Si9dgKPZDwq7FW9zD6hyW9xJey262Iem/BRcbT8xR5ahgXsdlCGggSziswcxoIwzB6JRpyLoaX3e5iArGvZga15y8qBC9ttzGIqE9Xu/+3xSucbEVJ661o4yYQQbWRzD0zP9W1UakHepDcLM3/7EHLFe36KlEc0VW2wqghxS5Rt1LbbJwZMqwpEeaPhYfXK9+GMTLdaimVf9Ci8ZZCW1lgw1htp/2mS/2jMrFm6Ul40eCvKTkYeiJDc0SjdErM1oAffB42LL9yUBkW/Zm1PnmVROw0Vb3qVn3xnnfhzXe45ir+XONt/OJnRwU4wTfW5engkkIxUzJzjKKfFaiqI6MXmBMHv7vb6J3WLlusA6UyQ4zzw9Vz84oPVVfCJF/PhiY5YpM6t4E/h8f9KblX7mF3WAisPzx8frGJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iQ4nQdV4LdBUPxsk+UVJpIv9QmX2A9K7k1VukXcLJtCTCFAL2ISXNH2MMVI5TMkh1rMQdKrotCLDLho/nRjdQv7s/V7PVMXHnRnyg+2R8Sg4WEPAl4jZIkS+5/yArOpGpJyWe99MgBfEHgzwaXf5cXPywiYyk+9gQ8qJpdoqJwclCX/KkHHY9XVnV7FVZeIEnzvpJnn3PxYLc4BhxMfQcsWjkgkuDZgNVj7fcqhHMeMsE72+jxdj7eZSpA+fss5QhgeFKEIIGwGQVJNE8ZdrFLxixVblqItRQtBQASeSu+q9fpSGEA6a19E+hMMoTgmxZUWX69plRifSERYCs3DPXO/ObHx0zOiwq2hX/4cQP3o/k2ghP+bIlyU4R25NDQPyoTBwi8m0su9XZ6pxgu2XfFZVNjH5Nl73Gkq8YNM5ryQWV2x20SDPnpKlNZaEI5u1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:40.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3dcd37-91fb-4daf-3934-08dee277a346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Adjust the structure dml2_dchub_watermark_regs for future usage

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
index 5669be0a7340..799e72243418 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
@@ -171,8 +171,15 @@ struct dml2_dchub_watermark_regs {
 	uint32_t sr_exit_low_power;
 	uint32_t uclk_pstate;
 	uint32_t fclk_pstate;
+	union {
 	uint32_t temp_read_or_ppt;
+		uint32_t temp_read;
+	};
+	uint32_t ppt;
+	union {
 	uint32_t usr;
+		uint32_t buffer_fullness;
+	};
 	/* qos */
 	uint32_t refcyc_per_trip_to_mem;
 	uint32_t refcyc_per_meta_trip_to_mem;
-- 
2.43.0

