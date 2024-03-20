Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5597BC54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C8F10ED68;
	Wed, 20 Mar 2024 06:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wClWH1aL";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A35E10EDCF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW//lisBszzxoi+a4rG3T5/y8rtdOt1FmgDlfbVndVKQfFCmW0WjpgjUUzIgCL2mqD4IpPVi0KeIkULAjs5RAiHORjJOlUeHSYDC3mgLSST8FTIrEO08ilCJ/NfyNVaXfIDiT1xEsi3K3HHUobWABUt2b9HUXBpTxRv0ufxhoIoAeFIUoXUC4Z15c7sl9p14p7Uya2KFvWMqui+dEkj4EHWWh9VMnAiSwCQC0crYcr5JlF6PEjs8bfbaZuQHarn5dxHjl9IEJrotpCS0vO6KCnuMNxKrlUw33yy132BMNcHjp1hrPxMkPxJcb6PaifNEZB1CWxBL25ppL3uiV1izeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnp9NBYLA2knWCVQElBmu+o6BC3FY/EZ4+pNlnB6EX0=;
 b=ULynaoqEf1+tCYK/zq5tFeCUDi5AskgDe7YStdUT0mtEtUT8gIwLSykr6KlJXJKbdHdZ29zyWtvV/IEgUQv9cy6PL/0v6DtJW5y+fbVbBSv83Axdfn7YATvlE4ZO7UqMSX/fVWBqRP/s3xfUBDzcUzjHIs+xDh5+Y8skh3C2FoabrteXM5Ia/2gLeva8NhGQqrmYHqa0yk2xLugnEa/yM5Kj2rJEnPmU5zZsRmtTyuaVw9QkDcFl+TF5yxR+x0mvbAlsif1nWvgp4FvNiU1pHwYt1cE2iQKWkMJtnP016M6O3LoIFEjLLUCpkvCqx+wYHfrKs1mshWkOjKtJZXidkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnp9NBYLA2knWCVQElBmu+o6BC3FY/EZ4+pNlnB6EX0=;
 b=wClWH1aL2Pm36ZTjXR0T97sNZ/NMz0NfaKBW77r/LXqRYo5BCFWPzvkk88mecY7AHhM2ghK4DeP+JKwNofyHQhYfOE+sfqfxL1nWJca2/wJaGyJ4y5f5+2aCiZmhEc35CA4E927nOLtEwCeJfOGz8cZL1pDKZNSMh90njRFtVcs=
Received: from BLAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:32b::12)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 06:36:33 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::e3) by BLAPR03CA0007.outlook.office365.com
 (2603:10b6:208:32b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:32 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:29 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sohaib Nadeem
 <sohaib.nadeem@amd.com>, Josip Pavic <josip.pavic@amd.com>
Subject: [PATCH 07/22] drm/amd/display: Added missing null checks
Date: Wed, 20 Mar 2024 14:35:41 +0800
Message-ID: <20240320063556.1326615-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 96686a2e-a5b3-4e57-b75f-08dc48a81556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIN5DLJ5D0d6y7BjPwK+tF82f4IK3ADktm347MDbFg7L9wCRYMxSGl36UH9PXeNdmMuYwqinqwozMIw+dSmkFiAVUN3Z1JSBkphag6DG4q1CNmGRmJL6J8U9Lmlg4jyQUjp+UT3dF+QtHkR7ScY45BzjAJPAJZJfqfE5aaCTvYXIkZ8D17XjmI8k6yG4ONu8JqX0SOJ/Dp33wVSAoqfXyrdmlrCZilEDvhcubyuIfTSsD2vfoUmgX8OojDYgGiKjHZyPIWc/8Vwx0ZqGXCMT83kogHyhNP+MQoYZe6KuAY1okaL9/tI2XJHafWp35zGKS8xMQr0AtvZ3k17p8whp5WHoO2Wli12UwbOwfx4VYJ93QL4IFKJPBzCe70+BuG0Wlwls8lJpx1KmC9BmxkdHv2zkyFM92F9NN+gldZzyBvBjLiFt0U0n28Wi0gMedmBTgKQQmUCt8TY2sR9n7BUso5FXqaqq/FDkpvcAXNTjX45DQjqj50TeKegCRgUEi8d1rrxPzaifSCxxvQn+bywEhIyVGNTCapqhVCqj52PDreCtN+pRsuGK8LvSiEzpRWxgS1fpgpcuGjDazrGisU4kfYoOlPR1Cypiri04ChoSw35zUOKNpn+fKbwXOXe3yB1JEEZyaVYFUpa0SctdfPzXq1eSlyu+eApNnWp/sJxPXwzpQ5IPgdLL2MLFSVxqmW7iZUGDe8cT9WOk4nuHlRiNw79ECGi+jF8SL3zfpShX5U7qMuS+JraqzxSFTv2BIqfy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:32.9009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96686a2e-a5b3-4e57-b75f-08dc48a81556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[why&how]
Add the missing null check before dereference for dc_stream_status*

Fixes: 06653fc22752 ("drm/amd/display: Implement update_planes_and_stream_v3 sequence")
Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cc4fd4e0deb6..dd9fe36646a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4291,6 +4291,9 @@ static int initialize_empty_surface_updates(
 	struct dc_stream_status *status = dc_stream_get_status(stream);
 	int i;
 
+	if (!status)
+		return 0;
+
 	for (i = 0; i < status->plane_count; i++)
 		srf_updates[i].surface = status->plane_states[i];
 
-- 
2.34.1

