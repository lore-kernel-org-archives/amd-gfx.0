Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB5AC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A006710E44B;
	Wed,  7 Aug 2024 07:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYJclKyI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D0710E44A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr7SgoFkk27pHIFdl1vsDjsKvhdBqHmnKlfczhC76QJeStMGJ89oVdvQ1tHkN2QW474oeUe6D1hK9+lHnHqRp1blVAjj84jCia3S69cEFJfGAcmaz9M7pQgK1fyIyRvP8zVONRZE6gAIVS0zgqfFRDjAsLTBIL+7x4z57ktuET6nyz7y9Jh+ggioFu1hiUY+0NW24jj6IBWRprYX9ke0S5n9QkfLU41XQptdr3EOTokdUlDyZbYiY6IRH8adBV/3RxmgW9xZNBEJT6g0+4TY1wDEZAjFZJQa9NWcGmbGNCWVoiVASbaX6pRZ6i8kjwMtKBPLfNJaInr81rnSBOPk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMIl9rV+pJ6OCfYDUzSaKIsiZmW1NIcosmvz18TU5qI=;
 b=wFHg3Kwscc4FeZl1X6uXv71hRJmD+xI+jJs052AtHqzMLKrqtHGo5vSECIZ5Vz+uXkSFD3LDH8NYuRIHNH6GnESbtFHwuKoHF5bVZkNZfZNgjXlUFdGio5t2vhCEvpYHREUm77qdPwUtRLyyV3PZO64N7KcC+p8mmmg1Xee+AAcOmxr597MWTrzIOQ1CnZfFLL5OUCMLvQQu5fVNIXziftz2+FDnAh3ox54C9+1SAXteHeVYWTlrFgrCWhMqnrz/Rh4Vp6RZlVF2z1MPqYJDu9IFi4w9In2frW9H2DUCxp3GbiqDx0VvKSdLzmuxMA2a0LnEYt7dqMSp3PhjnxFT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMIl9rV+pJ6OCfYDUzSaKIsiZmW1NIcosmvz18TU5qI=;
 b=kYJclKyIKuolr7Vbp4tvTXLiItETKFX1p31wVze/mSArvRPhQ5xFYvL2z6F2ZYNenzGtBQTqbu5OCE0Yqnpbl8hoOyOanNtkAe++ZR5+1ZSzlJuDRUabm7SZ9ASbMM2CUv4H2I2ZzNiSJvQJO4WFG11REeNCAznCdOai6tXxjEY=
Received: from BN9PR03CA0792.namprd03.prod.outlook.com (2603:10b6:408:13f::17)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 07:57:23 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::4f) by BN9PR03CA0792.outlook.office365.com
 (2603:10b6:408:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:20 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:18 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 19/24] drm/amd/display: Remove unused field
Date: Wed, 7 Aug 2024 15:55:41 +0800
Message-ID: <20240807075546.831208-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 5440a68a-f278-47ff-432c-08dcb6b69264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r3WJXSowAtnIX8pNs1sk4Td52+geoVl54KKlXDYb+o+/Gvrhngn2wbrjWRrP?=
 =?us-ascii?Q?cghNNZBZkA6X/MFd8yXebsv0k0jKNL9svYuAB303h+Wyptyrjk7qTHN2jp87?=
 =?us-ascii?Q?rLDLi9/jzYzzC5peonZEvPa7MNzsJfefGk2CQEp5k8ADaap9Adu+WgGG5MDF?=
 =?us-ascii?Q?gdT4qvYNPA8dB9MG+bj8dKKKJC0Xpx6CO1z2KIp73L4XsACFX6NKjYkdLobE?=
 =?us-ascii?Q?P8V9ETmQZ8YJYW9ixDvxRvwPcJvqxIlPTcBvCWSEEIJ+G93mT/9cBTQ3kxV4?=
 =?us-ascii?Q?4xV6+SUklEWestgg5scbsGiLCR7khMiwkyHT3QubjRhAU7cF7qjCvYuTzy1a?=
 =?us-ascii?Q?ACp0cCIIXuAXGMQnD0BpA3DRl8gQIdkhm2aL8y4S//XZGtGHbT0RZkQKd74w?=
 =?us-ascii?Q?HjInlfdv7OmNAV2UvebM1eg4/+8m9Xcx1taywA0QikeyxYz4A+yioVumo5Zs?=
 =?us-ascii?Q?MgH9y3LdHeXmh1G8TnOwfiDt7vsmTyvP6zNuadz7c0lI/n04OncxCNJNPnnf?=
 =?us-ascii?Q?7IKYzbu7ElDiLUPSleKZ0jH7G+hL6atGCWLVpKyOGmBYvdwnr2wlqLEUFnEZ?=
 =?us-ascii?Q?50mJn3fPlc4MrWiSHtre3mEIZQ34DdGQYfmf1f9yznM7xSZrceW4oCXjPNWO?=
 =?us-ascii?Q?257+BiW+QinghckkYhoVIOiGorOSN7RiutJzW6tETZ9WjRc7QDl1cExYYvBJ?=
 =?us-ascii?Q?DbWPubj/O77SX7wxoF1lhCul3AU7/0ZPyFDzpuuSbSn9/ZFNAeVorgcESGUT?=
 =?us-ascii?Q?3HmLma9YBh4hxAXPHSz03eJona7fJ3p/Ez9us7W4YfbiF93ZWsC2pT+udGjw?=
 =?us-ascii?Q?1jG1f+NjJqKXjSPybRsvje1OLuT4Azj2KEY+S0iJnbAaxl6MisZfUWsJ7vTv?=
 =?us-ascii?Q?UoGhVTVsmZ5ShsU8ya7UwK/6DTMT54L7kXslx2Y1LEwlvxiA+sSExk9EeCyb?=
 =?us-ascii?Q?9ZW3Mu9PgMOLWeua8rkY58L5wfL54LefBoteo4FQWSQsaxEIGOqJw4XlEGC9?=
 =?us-ascii?Q?4+/vwiuO8IUSguYGtdd4Ei3DIXpyXqSBbgCgzDUDh3GAhvnVJobXTJhkDI1V?=
 =?us-ascii?Q?tK48QVzLa89cwGvcu5J05ktfqd/1nJw3JIzKMbgL/1HTSInvOVOZJPJUGD2P?=
 =?us-ascii?Q?KlPKnf56dJzBKZR4u2TJq7Q3s4pGcVgRwiZDgNBVECuhT9JqJEBceEBG5BEE?=
 =?us-ascii?Q?GID6PkdHFMHMFKSath+raneUR9pdUARa2ggT2NpC3NooWSyTLyus7u4CG9y4?=
 =?us-ascii?Q?/pFFB3onpcq9IXE1Z/W3rHS/cADHZR1bqAqGsYRsK+rkAByJkKEF7OtlsgPU?=
 =?us-ascii?Q?R96CXeyeIDfFJoZMuutk+71dGqQxBoc0NsudC+gFqU4teYIhIjq+t5nAmUYl?=
 =?us-ascii?Q?pfoXybK7lPDa0t/5KP4MW7IkuZFLH/4OoV6ACCZxfUIDFH3IViO1SIYVolJJ?=
 =?us-ascii?Q?2uXvVpYYHOjOcAiknkAyX92itSWA5pux?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:23.5333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5440a68a-f278-47ff-432c-08dcb6b69264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[why & how]
Remove force_backlight_start_level since it is never used.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7873daf72608..91a351f8711e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -306,8 +306,6 @@ struct dc_bug_wa {
 		uint8_t dcfclk_ds: 1;
 	} clock_update_disable_mask;
 	bool skip_psr_ips_crtc_disable;
-	//Customer Specific WAs
-	uint32_t force_backlight_start_level;
 };
 struct dc_dcc_surface_param {
 	struct dc_size surface_size;
-- 
2.34.1

