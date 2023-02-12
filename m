Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B551C636D4
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35DF10E3BA;
	Sun, 12 Feb 2023 17:01:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3D010E3C3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfHTNRnp4sfShl+ChqPlkMcxJozAuxWd1UpY0pLnGf6umK8KmnlTbZAjxaIoXpkNK9bdd7/U00iIwnYhs/GfpDih+tTxWxRkYKicXW8OIytJK47Q6W3nindzMoEiX+/6GQ8Vdzlb5pYft8oxipKNMSoU2qey9g8QdYvRcmCIAXKowaSU+OqBmFfrcFuWjA++L61MPSMVA/Erqk2ZpW+juFiBr+mnjgonKkr5DoPl9lZkhYuGsS4NfHwhWPeeIB4wCc/YhclYT6vbpj7LwZQRxMYdCKDWuAHlZLx3lzqj1Z/oIo+UWVGgZg73aQ0OBOSABVWQF705QDwvL64GpOxrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwVIRyDIkMs1sSQTx+0FECp+AVl850+XioAnGN/h7UQ=;
 b=iYhnMe1VQ2sKn1FGKwizFK6mke3YR+RQIqB4QSljIUpX6I0/hSLQHfhM9VBN/H1imn0Rwbu6DhHZpuFaTfCirWanPl59rCbcF1/89jgrNWY5ZrLaB4axtplODIK0UdTtqKnlrqhqWxlM0Bpa/JhMwRfQ9XHZaVfxiAdkPra20H574Hl3Q2hU2CNkJEaTS4M9/2QJrvb18D7WMfPPMR8iBTp3+Slq0Ss0OK/BNyHcrA6dXm7KG7ygrboo8kJfWF+OH8T+ssgIn7Wk332/f6dw/kvKCGXuFIfunAcLDRcCBIiRoWW5mAJd+y75KdoLAR2IEuhbPy4HdUFZ8aCRRd2lgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwVIRyDIkMs1sSQTx+0FECp+AVl850+XioAnGN/h7UQ=;
 b=aCfV4n3KSEMVD7YTtTMZLCvA7Hmf/AUaIGYcVuF3KMm7M21Ssp5DrflSh0DyQ9fY8sfvMlLc56QgIq0CSY9xtiVBWkQLqRdGEMQ9hphUDhdyDQwGpQBhnihQYCwFImJmYv4hjqwE4wU89IUSGd95AowuflOGIfxXa1KVIjOIIOo=
Received: from DM6PR02CA0078.namprd02.prod.outlook.com (2603:10b6:5:1f4::19)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:52 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::10) by DM6PR02CA0078.outlook.office365.com
 (2603:10b6:5:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:51 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:50 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/22] drm/amd/display: temporary fix for page faulting
Date: Sun, 12 Feb 2023 11:59:54 -0500
Message-ID: <20230212165955.1993601-22-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb89370-d4d4-4d13-235f-08db0d1ab2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0jiO5OK5ZLJY68vbrkh+3XmrNtlMk+8+eGQhxIIkWuMyyxeACHc8GdS81iXCOtuuYfy3wfd0nD10J4IwnEadnYsJ1eAvhn6K00pgAmHGNHktbIzuk7r3kzTG+AGRpzqdw1psmkUJshYuyy6amAHQ4/73RaGtW5NQphPLzOAGO6nByOfeT9zM1PiyCCaKGp39Ys5+q8Z/KVK9Z6HcDdgqw7qAM4gXx7NEo/qb+jbciq/DyVAedbi3XAbZqgtJ501PaTrX2g4ZmbirAXAnQpmWJXBVL93L17dtu23yKYv1hO0qAXFiEVJG0BpOMwgR3cZIdKZWaPHE6cvj6/z4SJI0X8BaNNqlQwWdyJJ+LkB3YEgPKBkI5xdi1jA6gk++GWY2anJ9lfFVMRpAvG9PXu7shdkCUniuG7VKkeVRk7y2aIIE4NbOYHBx2NjATUjQo/VmKmctya1NUaL1crvVst+8hXvuLA92cTpCS65wAx9NZMGspimkEskIqOw8o/9w7HrZMWwCt/Jgd0gIXQhWxdF2d1xY4PdSPyd8rq+aGvFepZI5hUhtQGJwOgQ1yW1VAia5v6PypHBlxNSwZqM3j866/8y3idy4rjtCykM41ENBB4wdy9ScZ315CvGuh/8dIAPuOhJkDrVnIWbGSXxksrmsgwfBNuUxcVTrC6zgTu43mlw/8oQgS0ftyVGceEe0hBc3RsGJBTxVr5c7kNHkIzyUke4ZNKLuVBD0S1C8+siAvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(40470700004)(46966006)(36840700001)(8936002)(41300700001)(36756003)(426003)(47076005)(2906002)(82740400003)(81166007)(40460700003)(36860700001)(4744005)(5660300002)(83380400001)(44832011)(82310400005)(26005)(186003)(86362001)(16526019)(478600001)(1076003)(70586007)(70206006)(8676002)(2616005)(356005)(40480700001)(336012)(6916009)(4326008)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:52.0015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb89370-d4d4-4d13-235f-08db0d1ab2a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Ayush Gupta <ayugupta@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ayush Gupta <ayugupta@amd.com>

This reverts a part of the
commit f90a13e4d888ba58cb74ed04bb330c622780bb86
 ("drm/amd/display: [FW Promotion] Release 0.0.153.0")

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Ayush Gupta<ayugupta@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 88af952b62bf..f28f7675d736 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -947,7 +947,7 @@ struct dmub_cmd_PLAT_54186_wa {
 		uint8_t grph_stereo : 1; /**< 1 if stereo */
 		uint32_t reserved : 21; /**< Reserved */
 	} flip_params; /**< Pageflip parameters */
-	uint32_t reserved[8]; /**< Reserved bits */
+	uint32_t reserved[9]; /**< Reserved bits */
 };
 
 /**
-- 
2.25.1

