Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D15C369D8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 02:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6F910E1F2;
	Mon, 28 Apr 2025 02:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d1dIDXlA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6071610E1F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 02:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCYPffwz3x+thh3h8N6AmqQtJ4wzTw10+NBdnXUpKmgIBSmUiyV4G4HmWS+aBqIvMh8sCGyPyImtxXsWxAcLhmf1B5Q11JXui3PD2i13slmMufPlYxTAl2oOoBNCLSLxwDkRaPjumnn314BpMNw1bEvtqwng5mWOprBRPqhETD15wX4eISSSEpt1GiYoMQx1cXCHjphmr1EGlZ61f9qC0qBiUEmgaEESRpqj7ea5eRPoA7VIcxWZBtBqzBlCPZCl2MNW27lDfPg+psHkKCLTCZBLVPr+K0Huaa7hMGQ+G8pxvFwUcW/n+S30oPWnPDBYnKYLGFby74arSRJXH+892A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxKb+tkdE6S9wsBnQWL2IB5cvfYieLmaFbFgkATfEEA=;
 b=rmb54OXHqTPxOgVbLqFelsnUh8J0lpSe8c0nrkhl7lvraHhRv6MfeFkucn7DiEuaQ1YIGWCy+8lTz4+bVKP63bHycWrzDh43cK+6W3qhLXZCyWGhuESqrvyKAuZVEwnBCHyUw6BY9jK72OZYafrvbcahsgmPBsO4iy2RJSC94+LXJQjA1w3AAKPgORZVW4YahA1zPd/XiqtVN/RAMXWDvcKeI1V1plvk6FXtUonIS831R3h2l4fS0TQ5Sw2NEl25SelxZhyXR1KlFM7tQSKKJ6CKgapPxRQo1ezVNQxTDjZsHVgW1tYT6mfBQStLIkeN7dYxgzsG7NIQIifdh9cBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxKb+tkdE6S9wsBnQWL2IB5cvfYieLmaFbFgkATfEEA=;
 b=d1dIDXlA4oGmR75pLewe4xanoYkC72nQ7zEs2az5uxuL6eHPbetG0ZIq+2h8G9pgViOVuk8P6ehQ1jpXhwu4MC8j5bk8OUsxOZBe3iPA6Kstrf8CjfSZ+58pv1y+IXOuR1rAvdGXUUNL9qMEnDVn6EwpZi5N6wmVU0Pl2docAeU=
Received: from MW4PR04CA0137.namprd04.prod.outlook.com (2603:10b6:303:84::22)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 02:40:20 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::9) by MW4PR04CA0137.outlook.office365.com
 (2603:10b6:303:84::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 02:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 02:40:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Apr
 2025 21:40:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Apr
 2025 21:40:17 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 27 Apr 2025 21:40:11 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix API status offset for MES queue reset
Date: Mon, 28 Apr 2025 10:39:32 +0800
Message-ID: <20250428024010.1330997-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: f831eff2-cd91-44a6-54dc-08dd85fe0464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MObEVwI6TEa/oqR+gkttVkxw1JAtxTKvpZ9s+tPL33LYrwKpGBdvPVzbWzyE?=
 =?us-ascii?Q?HGNA8RwMJscJxqWT3Rcjxm/TLDhVFnFPCiQCD9NouxHLesTZBJiSYNQ+PXVP?=
 =?us-ascii?Q?JbUXZC/ln8BqqNvYfDb49dqrc9AwgsYlwvld7aeJrbmKMcRZTcR2c4aZJzyw?=
 =?us-ascii?Q?1vEO+/QKl4j09t5OZy3d6g1K8iY7SObq3VPoNYF1otz93DXGgjtfSKDDuAEp?=
 =?us-ascii?Q?XNrTzI/cMIPBR4HRCc5baAfq3LI6Q45zwV2jVC3aOUc9TT8en/t0NRLobSK7?=
 =?us-ascii?Q?A/BA6+HzUqpDOx+vQJVkNaDT5I7WvjWa6PAyHL9rGxAjRH1TVuuT7DIQ87a2?=
 =?us-ascii?Q?lMUCH2McGVeYJ3bQypbLxU67OjJB6RYOtqn/v0w6JqA+PiNngUoQS5G/bdEK?=
 =?us-ascii?Q?w+fA5LYY0fSyDbiw9OGSbyR45RwZwoTQDA/SDDfMaJQL99B3FNiNmrPhEhej?=
 =?us-ascii?Q?DCzQuluDVugprM4fJTRYfp896NZFyODaD0gKSTxEpwVjAOud6f03XQU+Zr5n?=
 =?us-ascii?Q?yr7OpD4TX0m+SZu6qy48oAjF3TK4i+DYa6W1888FIRCoHb3Kot3OgjH1PGFa?=
 =?us-ascii?Q?ExxP7opbAAK6S3E0aTID3QnM9+SU1ZVsuFYPV/aqlNAIyKvjCEfMNUVq/I6E?=
 =?us-ascii?Q?QLbtBgKnyzS78XROJIiv/0D3ApMssdl3B8ToIrIz4HSLZ+Oie6jrql6XixKW?=
 =?us-ascii?Q?YO5gdutLn+4uCPdZxSvegeSR6idT1dOLfNDgKhWOyP9ZFK2aK0rVEyNxsa35?=
 =?us-ascii?Q?GXldWCKlKIkkpQfIMGmJz9sQfyENXXXTGGfUZmSfdUwiqDQ912NgpNhi7h04?=
 =?us-ascii?Q?P8UO0gPQORT9jqE686tzCJt4l7U2EgxrWkqvKlVN4ZVjcb1PKzIKx1VqAdhL?=
 =?us-ascii?Q?qL4YdXu56DZCcvtg8MB5jHsx1Cl+rK7QtnaQNduPZAJKXcpXXWQb9SJm1IKm?=
 =?us-ascii?Q?d6tkr1aEe+8YkjEK3YiI15JfE3W622fLvcY6rdtHZu3a//FkwtWK7nkcusf6?=
 =?us-ascii?Q?VQYmkzeFMfzdsJGaX656KeOadYOk4tV8QJwoArv7uuk0w7YuHMAlaAUIUlDw?=
 =?us-ascii?Q?uGlZPQA1+zBBlHnOUK97rk+M7NPjpijqfGP+ipMzDI7T2f3MA3NLUuJKu2tO?=
 =?us-ascii?Q?IuIVQFdqXEWjo8lBoZYAD/dqRTqy3M9nFSW2oAZusEdB+OLqZt7LhLAVhWHt?=
 =?us-ascii?Q?SJMFhwsGckaZVFF86Iv+fRiC+XpWsjUhF9wpXMikIWrws0xQH2vba//3UF58?=
 =?us-ascii?Q?63h1OB2NPhhnDVoJbDYhhdKuLIO17oCzxCbUxZhPfxgNhQAi0ozIqYkcMN1w?=
 =?us-ascii?Q?sb4IrJrgGELJ2v9cbXLKhq5+j4YgtusZzF1sGr8zjNUOcvS2Wl5sMeZr+koz?=
 =?us-ascii?Q?So85yi9vl3tRVl01h1rWrMJiQWhnbQe2IjfCzfirXCQQupzwIW8yuY+JJMKs?=
 =?us-ascii?Q?RaLb2VBXb9KwEhKnkfu74D9jc7E9hu4jvj3PqKdW6op0aRSbSMIRk4lDTwD6?=
 =?us-ascii?Q?BWuqiPMMIS/U5r3mmGplDwl+GIeBRqOcC8L5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 02:40:19.6943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f831eff2-cd91-44a6-54dc-08dd85fe0464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

The mes_v11_0_reset_hw_queue and mes_v12_0_reset_hw_queue functions were
using the wrong union type (MESAPI__REMOVE_QUEUE) when getting the offset
for api_status. Since these functions handle queue reset operations, they
should use MESAPI__RESET union instead.

This fixes the polling of API status during hardware queue reset operations
in the MES for both v11 and v12 versions.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 0a5b7a296f08..b34d7bedc317 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -497,7 +497,7 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__RESET, api_status));
 }
 
 static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 1f7614dccb00..ee8b531b713d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -517,7 +517,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__RESET, api_status));
 }
 
 static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
-- 
2.49.0

