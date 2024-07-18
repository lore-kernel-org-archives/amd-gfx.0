Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C28AC3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0443510E8CF;
	Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWjiTKUd";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8119610E8E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaHPBLwHNmLfVyk/Fe+dqddq6zl68nHI49S7dWlfDb1A9+0BkzNH5Q2jnPmZkwe0x8w8c2Qgo3eT4m0daS4yXIf3uqQKkq/uubIbIKmTtDoqko0pN/ojTiYAKXAZpzN9H/sHqUXuxGkaGcJO3yTXQus4MqcOXb20eqD2AShPpst5CIGe8iMi1ApuI/wcVNdpg79pAGw9xZnHZKURw4S0ODTe/FG4uXmIorJpvRAiXL/ACzYXw753Ffyp7C5Y0KQ0jHeJ9fpKJ/TJSeLlY15BX0w72w7ZWxBx6nvUuKz/IIWmidZzfzcjxqHlOkjyC7ZA1VW6EXcI8LqRAIyNFc8CXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGmufbB6dmqwoi3nEzdl+h0W6xsPXqr3++Smy1DyGyM=;
 b=W0WlmQjX1VdMt/IjVJ6U6ZNUywJ2xQ0/t6RTRp4oBoRaJP1f59oDCPeD/rxmiYBqgTvaKbmfbatSceXnqbMY99TGZBpRYYZEZl3diuzqhSuy6RgrK48hY9pUvNWZNT5zJKWnmtK3mKYToFkZrt+7+kah2HonzMi9qVmx7JGJxEv6IEl9R8EF0iP+LV7wroE6kHSiQp8aOJj7eotm+pNb6qHe4PHIFDG0UymK5QAYR8eVvDNa26qs9kKGY6uACHbTF9Gs2B1AGpbFrp6ndEWcOeyEWu5zHJJkwcUwUyDt3OBwsi9PpMGGGaCdkvlCQ37MfqMxA7myUu3CgQ5i7QmCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGmufbB6dmqwoi3nEzdl+h0W6xsPXqr3++Smy1DyGyM=;
 b=JWjiTKUdJ7m4QeUeYKNLoi5VwjYX1Qny83x3i+SULshcFsaFbxCjanQxOFqcKMuqRNZRm4apPzIfXd+oGtTtwPXbOiVm0EbwLWDydIpuhfXviplbaNcZx1DDlDpZlUE47H4cEeAq0XzwgdBdnPKRf0F9BOTjf1UGv9nxKTpnDLU=
Received: from BL0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:207:3c::46)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 14:07:58 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::1f) by BL0PR02CA0033.outlook.office365.com
 (2603:10b6:207:3c::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Thu, 18 Jul 2024 14:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:07:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/34] drm/amdgpu/mes11: add API for user queue reset
Date: Thu, 18 Jul 2024 10:07:04 -0400
Message-ID: <20240718140733.1731004-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 505b43fa-6562-4a4f-759f-08dca7330713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8BnMZCfXmYfsU7daTTKvsEuRMOZjr4IKlpF+EZeAQSH0uOQh/qYBqkxjMSi2?=
 =?us-ascii?Q?gDcIn5NBWsa7MjTSC3hMUuOz1yQeRPkfJz430tZYLXM15m5uixT67uotgLoz?=
 =?us-ascii?Q?LhaS6Sfl2knx+aYz7g2HJOASRbxP93Vh94V0ASHIX5LfG2ZLMSvucmMKwgvk?=
 =?us-ascii?Q?u6hZU23rxMNX53HBIvszaj18wruVi29DPAJzmRGqnC+Oo9orQ5aZOdCyTZSB?=
 =?us-ascii?Q?UZlPjyzsDb12T7KaQIk7XCOybVYzUXLjJyKiuJ/fke/Ck1pmHdfh9rLtKaHf?=
 =?us-ascii?Q?qRXRLDTqbdYEjybm1/qRWBa8NC4T7GfQ246yb3xn30bujfKfaX4+/8a81wiz?=
 =?us-ascii?Q?+AuhtoBsJ2t6KbfxNQv4pRBEEZ/8xEc4UkqZ0nxVlFfyKaf95pwdFYn5Fi10?=
 =?us-ascii?Q?XT7oo68bhI+30To4YZWwYFYd3gDqyZy5Opway7jc1qRwSqJtnPRjHsH5ydIB?=
 =?us-ascii?Q?AuSUnG1NMOlm+N3mOo7oYGZAbhObzvngHnElDulxFQfWLpmKrQCZjAulIExj?=
 =?us-ascii?Q?Bu2hyBQokRBp8I83ywF4Qb5y/E6W6YhjGdQgzodgtwuC35S48VYI0QUscRqu?=
 =?us-ascii?Q?sOf01kJh8DcqWdAQSHE/ggQ+ubN8OaP53Wl+aQDqaB84/ZEPxfWvjq1F9u5/?=
 =?us-ascii?Q?IzIYjvtCfqVWcR6dQXLIDwbNEHY2dt5+Q0fHBHDfgLY1qoUNKDbfs0rk0M8A?=
 =?us-ascii?Q?e0ktvPiv8ibmYcNL/GGNHEHa5x07AZfIhuPq6dyJ4c3yV56q6U9yUMoqVDSk?=
 =?us-ascii?Q?Qx4tiw0r6ABxKQM2MkK+RAw+zwEOS78Q1ogrYZNkDRwgDljE9D1U8uKgK4qu?=
 =?us-ascii?Q?Af8ICnJzfXQseLtOQXcXAcFc5ugfcLts59kyv9P1Ye2MqjF5LCL/Hj0T0B2z?=
 =?us-ascii?Q?wB3FXHqjP3cupuS3m2H+DMdD83vMN2JeRGx2NLJoF5R4hAjnd4hAZEyQ4o0s?=
 =?us-ascii?Q?sXCaBnTxDoXtE8CGmGP+WDFhMWHV/JGrFmz594+pYr9XPKUyZy9KcGZIiDMU?=
 =?us-ascii?Q?oIqeHDMJlsj+qvhLoy3Ltwt5hhDTl0Z5iFJJIzu2GVbj+A4cBXPnROBSKE5U?=
 =?us-ascii?Q?eM4fZKh7Dhho1eGBv4RsQND/s9e1sOqszHSVPa0+J5YW4N7gxO03ZRpN4zVM?=
 =?us-ascii?Q?8EH/jF6uKOuT2glKEid4QV/G7eJ+o3icw509Pu2809Zss7PbzeRHVVBx8jpY?=
 =?us-ascii?Q?r717IUG23L+It/J1IbiO4XxKMY2MUzGqo5SCRephfXHzuMNDSXMCe2d/DZLR?=
 =?us-ascii?Q?CagJDspBrBX0+AZq+kVW2TsAd/khvXojfGz6aRGWstoNG3F8FkGUZu1VewiF?=
 =?us-ascii?Q?k1pmNZhdRSr2LSHmZPKuRB+9Sfv4FYXK1ipW7lRBlo8BP6Udem4d1tuYkT61?=
 =?us-ascii?Q?zDfE9RtLjvr2il91JRcdkQUE2rzdnSlT0vzQZFW3lWCPEvEfMK4rdcXQqJwR?=
 =?us-ascii?Q?VbKs1xaul1VXKgqhMBlUNOg+fope7+Qk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:07:58.2873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505b43fa-6562-4a4f-759f-08dca7330713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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

Add API for resetting user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index f611183e1ebf..bf8fb6a1becb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -350,6 +350,26 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
+				    struct mes_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr;
+	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+}
+
 static int mes_v11_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
@@ -628,6 +648,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_legacy_queue = mes_v11_0_reset_legacy_queue,
+	.reset_hw_queue = mes_v11_0_reset_hw_queue,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.45.2

