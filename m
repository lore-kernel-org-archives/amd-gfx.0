Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAA5C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96BA810E032;
	Wed, 28 Feb 2024 18:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXQyExPP";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB6989119
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+S9mxxU5EBicUVdK7qfAMokcvhKps05VvI90jJgX/Jjzr6WAtMyKaL1xjx6FxdY7J621eaTqRIMkQ3h3IhfSLK2ktGQ6qxpUHdlTgPQzsCnK1pRKxW/Zpx7MVtGiWqs3mcKbLfKfhHY/oyLixl+bap5E9NZbmEygmuHpJPYIS3+/JDBJPv9ZY8UlluyozQZHzipEOjCLy9+C1LLus5WTJuKjUAsZkNunqAchA3rpXBnkmq7HOobNuBRtlg93xsD7JysxFdyP4bw8MJwAodJoVXKg+wOIao3dbLYGz4uMhM8WuCVNarzv6zYdGM0cjCNqqMUgP8jXKCNFbVd/nFQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtRW9mzbFsfr9m0fVLVpqKr23LmNQf+X4DSJrJ+OF9k=;
 b=D4VtAth4kRo+u8ac+nZ7HJZ8AbA5Uu90jEZJ9kqMkd1XRmLe+fYV71gCfxiN+oPBXqYgRF3Rf+1anRKAEKkmZ3fm8y/bNRqa7IgRH64utN/TFqsJL7jz0QZnYJ0KWIaSRW5DJ2euLZ1NZNgxJSwfFL6TvTX7VYXYbd2AiksCES1MUkG1pHzEJQeVshG25oj3k8Ut6FPDS0k07ycWvQ5KxxaxMfp6cqPXOrvN2IcG9y+BXg54KZIURXTp+DRGC6T+nmZuuMZ0rY71Q2GghmevjvM/misQG0shaxPZLpIk10UOENQFHKEtDmAaoxjS1y5oP28HSQcRiah+aFQpKDGrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtRW9mzbFsfr9m0fVLVpqKr23LmNQf+X4DSJrJ+OF9k=;
 b=cXQyExPPtJZOSJ2TK6ByStaPvLa86IonNnWrBycMp7P5ZsdseGtL/HuqsBLFKo/t8sBIWs0UIvkqJdfyRynZnMJN2wJIQf0CNnswzqe3tBMcfglMaPAeHWEkvuyxabn/eOAl6gUEMLJJwtkHu0A3wpj9Uv04A1YtJ+rtJvCKR6U=
Received: from DM6PR11CA0032.namprd11.prod.outlook.com (2603:10b6:5:190::45)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 18:43:29 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::68) by DM6PR11CA0032.outlook.office365.com
 (2603:10b6:5:190::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 18:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:43:29 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:43:26 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Anthony Koo
 <anthony.koo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 12/34] drm/amd/display: Add entry and exit counters
Date: Wed, 28 Feb 2024 11:39:18 -0700
Message-ID: <20240228183940.1883742-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 89877e0f-8dca-47dc-9d5e-08dc388d27ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPh4Muehy2p0Co6KXl06agLL/22pw0LHU5qnsv5xwcirVcPfR5vU4Khdxorgkttz9d3XI7js6aMn9W1uMOAWDQFw0UVGDn30Vqa5dzuzZa1FBPKRDAah5W0RFPzTPw7H0jnecYWj+vsqbgfX3VwRAhJzOpZ9tVfKF13pc5vlT5K+wQeUOONUyDBBGsRuT5KOdqXTgB7u+9mIpOhpZzBWf6NelHO/BwWoRePTfMOYENvTHoZmB5PjdAoDyP3aDL3wUf3SDA/8AVaTTSID2OYnbflTuCARO1lX7JFOWyywvLh8j42mibLnw6Bmpv8Vra4CkYi3Dq6Xu4mkdXmVlEETb0EIPDaHFtr4SXzr03vrSkxv0FhYAe0d0SNvq6Y4hR2vzdr32TPtFGPPyb3f4Qs6q0zBshGju09UezpF3ZtpDHeIWChNA7QFLTrKg2b2JnNmXy6hGqu5Cbdf+UW4PY/M0oCPdTIePddqC7yYpw/fpmOgJ0J7wrqAW5i9yIRtCgH591LcfmadR+sE6hPB5aBfa+XRD/4UqH1UswLfG3XTw4uYgvkQNNsytxhDJzI7OZ+Bt6vOz/ldRzb5OsFpE/BeObrYDi/pxG/Ch4zQ0gEZquai/4XDMDNuJ1X0ujReifZOpD7AgJMb0F1HoVTByfaJ9YwQrosnndz75oQaKYpu+j0+j9qzv5JIdN+242msVIp5rmGOOmzjmfwUI2NJAPaOAK0ZkYIibToVLwDWIaTwE6NEa+yibz7+GQ6NC2UmNArx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:43:29.0232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89877e0f-8dca-47dc-9d5e-08dc388d27ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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

From: Anthony Koo <anthony.koo@amd.com>

[WHY & HOW]
Add new counters in the shared IPS firmware state.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a529e369b2ac..02ad641bd8df 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -724,7 +724,13 @@ union dmub_shared_state_ips_driver_signals {
  */
 struct dmub_shared_state_ips_fw {
 	union dmub_shared_state_ips_fw_signals signals; /**< 4 bytes, IPS signal bits */
-	uint32_t reserved[61]; /**< Reversed, to be updated when adding new fields. */
+	uint32_t rcg_entry_count; /**< Entry counter for RCG */
+	uint32_t rcg_exit_count; /**< Exit counter for RCG */
+	uint32_t ips1_entry_count; /**< Entry counter for IPS1 */
+	uint32_t ips1_exit_count; /**< Exit counter for IPS1 */
+	uint32_t ips2_entry_count; /**< Entry counter for IPS2 */
+	uint32_t ips2_exit_count; /**< Exit counter for IPS2 */
+	uint32_t reserved[55]; /**< Reversed, to be updated when adding new fields. */
 }; /* 248-bytes, fixed */
 
 /**
-- 
2.34.1

