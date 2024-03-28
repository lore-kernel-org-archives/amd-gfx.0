Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6CACD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0832D10F751;
	Thu, 28 Mar 2024 19:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8i/Pmvv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD65711252F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOp8l5SD+Eon4+CdCbN5YrV6sZgeETRaKM0NR3WAbMdHI4bFs7EsVAFxejIlLWVU3QmgfC6QHuy6pXH8vCxNakxUfQprX/JmG+I6TMedMOT8DSisB/tg3ked4AOM7mxOAvn7Ow5ANvAH1Bm2FEJJ/HgV46TU+/MUM39+A2wbSKt2HKkMECeAV/PTErgfbQB6lffSE/rfaS46B6LQKHv+4WX9oA0rxBZoLynstixQsSEim31RYy9CPCUb3iH/IHZnp+hWWq/GQj4mZm2/IMBhQQb3oK0KPLgyQGuzVVj0aJhVQeceOcNjN0oAr28BndcwZNcwJUx9+ZoALc1cMeEwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s99Xc//kFo0i7vjJyg57humkbtHif8dVNQRV/HNIuuk=;
 b=ZRz7kcW5UsP0/XHNgd+yAZSkx9ek6QWCa2l4ojnjAPOe7ca3W9Lk3Vl/uu9UrvWfHSYLPXcmDWb0pY9GvUJkRebqOQwJvNmlmH0f6fTIvxEZ+HnAUquWMQVGelSwa0XzfsvfThoDImz1a6/WbHU98G773hHr6aMvxhnjjqP5qmOdaO8lM2u9FZSKEeyCfU4RlqLVukgZPynMDBC1x5OPAIV1o1kfIf8oTfwRPq37xeNK0ikLoMa/LpsPi1yRllkP+Tkp9ct4VdKhRy6NYLcWI3RpvsadqLKqryHapT3OnBnZ9wBmEWKjghUwhli/SrSD7wUlh+ShsRVx5y82PdDZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s99Xc//kFo0i7vjJyg57humkbtHif8dVNQRV/HNIuuk=;
 b=G8i/Pmvvu3hzDQM6/Rm9H9eTtTqYsupRmQs+W3VcY0DQNRBkTxPCpqJ6S2YALcJD3ke8AIx04SWwVgmKWPSFe/D7bwhgbR3KXmCMLbZv3ipb41WQq5N+Tu2RxP80Ul+zZK9CSSX6yLa9XGsPB+4z4/lNUMvkoschgYGYbgqzKns=
Received: from CH5PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:1ed::17)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:52:06 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::40) by CH5PR02CA0001.outlook.office365.com
 (2603:10b6:610:1ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:03 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 29/43] drm/amd/display: Set alpha enable to 0 for some
 specific formats
Date: Thu, 28 Mar 2024 15:50:33 -0400
Message-ID: <20240328195047.2843715-30-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d0b036-193c-473f-ed69-08dc4f608bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdpFr0zlGu3I23Ac9a9GoReffainEmTrib8D7vsBuyBlg/3TCCsrD9AGajpscJRUzz7rf428konH9Wh8pudvUQkFC0YOYaPfBZc+gwJEUcsli45rz3BOSHNGghT8AqQ9TTXzZyrOql/QVKFwxYgWQ17kvs8p28/8Y0GRQj5i7J8iJmV/HULH3dNzgcGEYn6GpipxDO6kbvNIm2GBR4OPGjA1Hs4ISNpCZdReSR6MDiwvboCKbbfZt9zLvB0N2Jh0LITFuv25ba5BPkUHyCDoDEMRTNosJ2Vj3B6H937eViioW9CRU8ptTCtIjQ9aco6HcNeuq7xDKaZ6XygQ6LgsV/mhpMadvKNI6AWgheeJhQ/DuWwf7iEJ8j5yLvNpTyoeqgz1kvb0/5rO7o9LAC3Fwxey1SsqiydQLFMjc4ftak+8gQBbrljW4dJICGVkXMTVyh5WeYXfph6IH9IUsA4ACV+uzMxTjWFqLAKyAgWgbREQfpXxwkrShnTtfSOZF345Y2K22mcJxTDCh1KQ+zcIOGHnAJilPpMc6A+IoUiYYm+8GVJ9uT1BEoepYCyjC+VFG4JTaSJNE4rZzvs8SjRLhvxMx3FTG6TRYcfWBTsDjvk3n3ZcQFIuua8VRqP+FbQYFk4rHINj6NLIcIjXlzSpJp+8w+Rq+5R0p6RumHCrHopVL4B5CkurfogMAXn7XBO4WNy9dy/+gKp12p+2N/ADOUytZj3gH6bN+mM6KOX/E4RzhVuLwaLAWSx9QQuzvRJy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:05.8492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d0b036-193c-473f-ed69-08dc4f608bc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
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

Set alpha_en to 0 in some specific color formats.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 58095ac75506..f8c0cee34080 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -293,9 +293,11 @@ void dpp3_cnv_setup (
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FIX:
 		pixel_format = 112;
+		alpha_en = 0;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FIX:
 		pixel_format = 113;
+		alpha_en = 0;
 		break;
 	case SURFACE_PIXEL_FORMAT_VIDEO_ACrYCb2101010:
 		pixel_format = 114;
@@ -319,9 +321,11 @@ void dpp3_cnv_setup (
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FLOAT:
 		pixel_format = 118;
+		alpha_en = 0;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_BGR101111_FLOAT:
 		pixel_format = 119;
+		alpha_en = 0;
 		break;
 	default:
 		break;
-- 
2.34.1

