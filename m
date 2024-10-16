Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D002D1AD53
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 13:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C91D10E6FB;
	Wed, 16 Oct 2024 13:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vAz5l3AU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619E210E6F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 13:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7IADiB6Nb9bC3aWWFbSspbu74pt7vdm6A6aYAt+zYUipnVdqsNNfruGSM/vEMAv1s3ghk9cv5+zJrA57CkwnESVNlcrF+JTeQStN3vXnOE7GhJREoDkVXiUyVzPydtoZszZPHtKRo9EVpt5xr9bLnb0wX9j4+QY3q9mBVelk3EBY+u1+ikWjzTPrpfsti9cJYeyX06MUCVQpw3b6JfWv/43Ay01x1UkHAfPNLqsvQ+6LyWtrbcxFmyrxKA1ZxoZsHgFRcdgZtHlK769nqor0yXMijD0O5F2kCXtoTNianMn2TX4H8Ve7f0OaPgTNqDASO3vnFKXC7MDgB3a3FdOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBhCtB54+pPWAKGAzDh8rMmpym8Fkj4YqlPtK7iTKIg=;
 b=yK7fSkipNUURyzFwZcsGj+JFGZlEz+Dej4PTSukibs5GDI1abSWRu96N2EDubTLwKHjx/39g3xu75iLyU6wJiod/30/pkYgxATNwNk0REe0mdOc3A+uj5PlfwYKuaVAr6Qj5vMLeM74N5fi+gpYsWy550zRrwavw9V+bic1xWzlK5Jj3mmPePLO/vmTLQ9NkRKGUzpx3jBHELXiK5h8E2ml3rsLd/V52hgMHvIg97Rhu3RAIanbZnNoWwbSYhFxzgu2ns0WwByG3TJQJZVuA+yQzsaybmHrr7cT25U2UQo0U/x2NWl8b1GwdPjQ62Oy/gY6lIuywR+l2uMYKnvmdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBhCtB54+pPWAKGAzDh8rMmpym8Fkj4YqlPtK7iTKIg=;
 b=vAz5l3AU42Kw5DrZo7g1pOYdi98/aNTYNg7c/PfwMxS5U4a9q+88qyrVmh1IkZ+WgV9YomAyeid/VEdFju7CNg8RAJS+5xqR5oEWpbdRKQb95qspKNfY8Qyiu+ugULfAPGo2eZaSP1BxP8DmYIGoMAh8swM0NL5nx+VzTssFfoA=
Received: from MW4PR04CA0211.namprd04.prod.outlook.com (2603:10b6:303:87::6)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 13:19:02 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::2b) by MW4PR04CA0211.outlook.office365.com
 (2603:10b6:303:87::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 13:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 13:19:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 08:18:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Ensure HPD source index is valid for
 dcn20/dcn201 link encoders
Date: Wed, 16 Oct 2024 18:48:45 +0530
Message-ID: <20241016131845.3154052-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c914920-77e2-4053-dbc4-08dcede519e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ya0OSu85eUcs2XNYRXPoht3k5n+SnV1hzGSVEmd0ozIWy5X/ixTcTsMaNj8Y?=
 =?us-ascii?Q?rUyeq4Yq3wTGkHLRsLvcT/KI/Q6Ed4b0+XzAuDdMtxfA0kH9llARPPQUu4d+?=
 =?us-ascii?Q?Ia3Plp9BI/qwdSgYp1CA8tVSFIUPNzCrMYTWuEIo92DnrtKMj6X8MlDNDS40?=
 =?us-ascii?Q?pI9NXKoCWyvKCFUcVKux842lAbBCGntgIRZ7vIWBkbHFUtxEQn5iHDxpsW1Z?=
 =?us-ascii?Q?8tT6/6S0uvaf3ttiBdH4y+lQiliTqHb/CIwhmct5NxQyaQ3joc4j7mxhvhkt?=
 =?us-ascii?Q?7sYTNqazdggGo/ESp7eJmOf8wIRG0k2SmWmxUPM+heYDCqG8QeGZ8VKuDpMl?=
 =?us-ascii?Q?mIa+/IQseXUn3g8Gh8NXlZJoQRYJCx+FWPGDIuOPSuT3Tsdbvkuo3YHlIhwY?=
 =?us-ascii?Q?mA15/ajRpSYmcM91rOAgRNz/XwHypyl6gQ7EzxBSAY+BztFqDZt8XwbgDNun?=
 =?us-ascii?Q?Ly7yyPeYcQe7bDN8SNODi8uyZEK82J5HpMASj3uq7yJIPtEYzhivyBnYTU4E?=
 =?us-ascii?Q?T0fOXfdNNoX+qFBh/i24FvQ45cFax24SyEcJjHkMkA+ULptwwk1Rj8SYVRgD?=
 =?us-ascii?Q?s06RqoQOI/1x7K9x/cKhvP/lh9Cq1YMr/kdCjogN16eNT4QzEn6q5IQrWXxr?=
 =?us-ascii?Q?l3hZgxWw2dNiQPYU2NgS4gOTtawvBLlrtsxdXAVdjFKJ92nMu6fDEhDc5bNQ?=
 =?us-ascii?Q?UFVa6/C6ZvqHGEiQf2cg2XPczDYnPEMoplkXVmpSTqjVL3WDn9c7SYojo6wp?=
 =?us-ascii?Q?R+xG1sO9dBGy0trym/w9uIlBjaY/1toLt5dy+OUX4zo6oPcHmnfbG6Uf8E68?=
 =?us-ascii?Q?wzefSYkKiDCOpHnV1+3uOUCN84VKpbf1HoHVEDMDZXFXZEvS7021hlMunm0R?=
 =?us-ascii?Q?B+dOHVzPzmrzMzvLMzeaqQ2135wGDtgHSagoP6Kj8GWageHUuvab/7sUO0wT?=
 =?us-ascii?Q?laveKYqaZ0Hgaz/EhdHf720TO+9QgNr13a3uPc/K8aY1BjYRzO767pJLSczF?=
 =?us-ascii?Q?mdmBEvo6rwh+phPiP9truLMSE6XmiRL/cuN9AxTwY4xuDHV8RV/kOcEWiS/u?=
 =?us-ascii?Q?7xNJS7W+pDV3DKlJjOwBzObirIGq6WltZS524vdeexLqMjbVDcvDYB1p26YR?=
 =?us-ascii?Q?3tp0flkweLrwMvOLti2R07XJTFawa1G/kNT+Q/YQKbTvMrXJxwvXDUB+twDE?=
 =?us-ascii?Q?NRJK1P5Wyq0fm267N2WaGDmbL0PImdB9SE1vK7SRcM+PjX1igGEnTCjgpjBZ?=
 =?us-ascii?Q?oH9oEZDBSvAoeobSBvjM7C+zIXW3PeE5T3vsXgiy/TLkwvP5FK5ltPH1XQDD?=
 =?us-ascii?Q?yfSQ3nM+7fnEeefyetd8R4NQS8zmZ2jgDcnZK3tWhivDAvOQTZa64k6srzVu?=
 =?us-ascii?Q?71Rg12ayV9CJct+/hJ/T7RuT98HN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:19:01.5746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c914920-77e2-4053-dbc4-08dcede519e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

This patch adds a boundary check for the hpd_source index during the
link encoder creation process for dcn20/dcn201 IP's. The check ensures
that the index is within the valid range of the link_enc_hpd_regs array
to prevent out-of-bounds access.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index eea2b3b307cd..288189913e1e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -920,7 +920,7 @@ struct link_encoder *dcn20_link_encoder_create(
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index fc54483b9104..15180ad71513 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -797,7 +797,7 @@ static struct link_encoder *dcn201_link_encoder_create(
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_ATOMIC);
 	struct dcn10_link_encoder *enc10;
 
-	if (!enc20)
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	enc10 = &enc20->enc10;
-- 
2.34.1

