Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BC3C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFB110EAF0;
	Thu,  6 Jun 2024 21:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F9ec6SuN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B2E10EAF0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaKHxP4lTdGaNz3OjHpl1r6PA6FgK0EBxwGWzl4+wa32bIdg0uA+lvHjeGWDHj3e5u/9eU4TEUcOuNRx2Cwo+apc0kNlMHNE8KSvFfeY9CYRz98WN9c1kqlTau9wrM6+sO/rNLfhRZCTs48UApwhvJqRohlEyGD9KZmBQYWy1HNdOutaYI6LIii+P7RzaCCbVYWHpVNTEdiC7tULGBba9NaHuJEd9sOKyacZI1WPZQPpUQzYlhqVbaElEbcpVl5r/yLoAKn6HLMXI9yJVfQChjU+KdnPn/9iNSCeahfw9CUr+1E87fw6tD80bUyK8J4Vhb7zr50d0M3h38T6NjSZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6lnmWd/i57ArObXZbj4vhWedA96cs29zyfwLaDY740=;
 b=n+mEUyxrsx9uvOVqJ9dwOnuem8I35YWwUxpokAkxPpM/6AOADvJnI/3f06kYL5Gb3hVLX/JYMw5D/EQ+H6cq4zjS8LZIN7QsnSs4xRoYeOWTv0zYwpcnwX2qKM7t/3H2BQfQNKSpNFEm4iKoSRE7/RVzKdRNQTIoaGodNB33yHlX4NaS4Q0JdXmOZFpueJuS58ziEgJvwWKmweVbM793MLJalzxwCaAg6nJ2NbXU64R9sfjQ1/Tt0OojxksNc0za3w+xJ03DHeH6t55oKxPhQKU3Wm2ZVwPCBRapuHO5U9iqWrn9e5gY3CW9xWW/hEv1kgO+mMvUBEWXPwIqwmIqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6lnmWd/i57ArObXZbj4vhWedA96cs29zyfwLaDY740=;
 b=F9ec6SuNXanm3rx1gdcLKtXlXthiPPWQH0b6vK3Mh0rcONDuAWbPMkYKDLgQDFtJrTTx0yoj9JK/FnbrBpJMY7eUac0jskz35J0kRZX3hdebUm3hQkSmus29ZZjjIJ/ipYhtTUON9sKoZIwg9DLW3Wj8UuyxthJ0LbY1b9naT3o=
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 21:57:52 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::f8) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:52 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:50 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 37/67] drm/amd/display: Don't refer to dc_sink in
 is_dsc_need_re_compute
Date: Thu, 6 Jun 2024 17:56:02 -0400
Message-ID: <20240606215632.4061204-38-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: c77bee3c-2966-4ab7-1615-08dc8673b69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rj5QItE2zcn9+tIh/D6DAclYPuF4al1qi+Wx1uYBmvIwkXeSGi0+f25+lfWb?=
 =?us-ascii?Q?CleoU47m5qZdU9Imv90Sr0YO52TN/dw2D8rZfytIr8ZF94GZxI9NjgwlHIYV?=
 =?us-ascii?Q?EgInxAL+aL/j0aH5Cyx9vCvgJ+J23OOBNxDCbhKp6fOiguQu7BFcULm/xZNU?=
 =?us-ascii?Q?37mQlnEH+Ime4rcJCrA+EumzsrOtAtk0JcwDbvj4dZdUWON5ZH+dQSvid2Db?=
 =?us-ascii?Q?97llYXUbpLV/F0u2CKHv+yhAU5MlH20dgqHEWEX2eY6uIYWhfOb5IOQPlGSA?=
 =?us-ascii?Q?4b4EjS8DAsqb4z/XrmfPEZiN4rwas/UPBduohuF6K5xL0qA4QkKiYCD4Xxee?=
 =?us-ascii?Q?ahxPAnAUGALq1Yia5VYQk+w7AKKXFZZDSYaKBJjtsQ2MH/E3oy7pcnm1H7ab?=
 =?us-ascii?Q?jA5XQsloIUuc+hUrvDHrP4KVwnazxqFKCT7WiUI22qQx/9lwSPJ9wb1doAYV?=
 =?us-ascii?Q?jO3TE+AZkUN4PklLP2klkAyfwkk6GUpj8gguY5Ien00AzT9+BZT8y0EVWIe+?=
 =?us-ascii?Q?bZOkzSsvOub+9rwGMu9OIxkvAIjjnimOKAiRwk6bDiIMoqghNDfXOYDfS89o?=
 =?us-ascii?Q?EQ0OWmLNI1MRP6agOR0J/t1Rw8ZgrUfn0vE4+Ttz8yPWExkjSUnOPLQ38bRQ?=
 =?us-ascii?Q?UZonQsCo78dhShyTAksmXgRO572Rok1L1Cn2MCJFfjZsSDnKoC9hP2iTzQz9?=
 =?us-ascii?Q?zyNx+vQsjDRzR6WKnSFFQ6Ew9s9x1wCjnaZ22dLA62Dp+omQVFJLsIQXeiUr?=
 =?us-ascii?Q?GptV0wv56Hk8aIMvFyp4wz2r9UzDEYAVIi2naz05c1+/uiKo9nt/82DjWM1p?=
 =?us-ascii?Q?vZWFOKaXoPv9nHML6QpnpwtoTzUHHhlXBw6YiNmaDpyH1SJcYAlyZNQIVpSS?=
 =?us-ascii?Q?0qa/RgYhGfhei2cBtFlYCfknJ59Zjsz9MTRPmUpuh0UqRoln3OBfKzdsIysn?=
 =?us-ascii?Q?YFCztYcJmDx4CFVPHAeaDcIMCyULNOrrgMYQKR8VfN7IOf2aGgrXurb2em97?=
 =?us-ascii?Q?cXR7UWdIIALY+VJUKv3Fz3BL9Bnq5B0r7DQUonMCN9euErfImnixTgnPioqo?=
 =?us-ascii?Q?6cirrl5mVMDzWrSSsUGFPrRTS6x7jpmuv0jcLZdi0HLbhnZ+PsJHvad7siS1?=
 =?us-ascii?Q?d9az4XioPrKB6YNVBXpXhCAg/owbZwqbJOqwqQjLA2pxOG6UZZq7doWB6EbD?=
 =?us-ascii?Q?A1bJv54f2oVpcqX+al6x6BNhd3ywhe3WoQuDM24sHqsPWvpYRjEE6k2Q6SEP?=
 =?us-ascii?Q?hX0qtsbxMh4DPkqDYh6oBF7tWRpUaWLb7ExvwG7T0VGArmQXiBdg3vxZlH5a?=
 =?us-ascii?Q?jeP9hSpEOEljW+vCwXQeqoxUJOZNTZYKicPy7nef/oHFNcHVykmPgXn3XGBR?=
 =?us-ascii?Q?9RLfbnt4zviOgpcdMK6IMX5Bujz2vWnYIXpszLAb71WqRo43sw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:52.2095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77bee3c-2966-4ab7-1615-08dc8673b69d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238
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

From: Wayne Lin <wayne.lin@amd.com>

[Why]
When unplug one of monitors connected after mst hub, encounter null pointer dereference.

It's due to dc_sink get released immediately in early_unregister() or detect_ctx(). When
commit new state which directly referring to info stored in dc_sink will cause null pointer
dereference.

[how]
Remove redundant checking condition. Relevant condition should already be covered by checking
if dsc_aux is null or not. Also reset dsc_aux to NULL when the connector is disconnected.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index ac60f688660a..f60d55c17fb4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -182,6 +182,8 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 		dc_sink_release(dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
+		aconnector->dsc_aux = NULL;
+		port->passthrough_aux = NULL;
 	}
 
 	aconnector->mst_status = MST_STATUS_DEFAULT;
@@ -498,6 +500,8 @@ dm_dp_mst_detect(struct drm_connector *connector,
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
+		aconnector->dsc_aux = NULL;
+		port->passthrough_aux = NULL;
 
 		amdgpu_dm_set_mst_status(&aconnector->mst_status,
 			MST_REMOTE_EDID | MST_ALLOCATE_NEW_PAYLOAD | MST_CLEAR_ALLOCATED_PAYLOAD,
@@ -1238,14 +1242,6 @@ static bool is_dsc_need_re_compute(
 		if (!aconnector || !aconnector->dsc_aux)
 			continue;
 
-		/*
-		 *	check if cached virtual MST DSC caps are available and DSC is supported
-		 *	as per specifications in their Virtual DPCD registers.
-		*/
-		if (!(aconnector->dc_sink->dsc_caps.dsc_dec_caps.is_dsc_supported ||
-			aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
-			continue;
-
 		stream_on_link[new_stream_on_link_num] = aconnector;
 		new_stream_on_link_num++;
 
-- 
2.34.1

