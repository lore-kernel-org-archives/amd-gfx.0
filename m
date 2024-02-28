Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF94BC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2219E10E490;
	Wed, 28 Feb 2024 18:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vXLoo5oW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1757210E490
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCbMEqUugFDPT0MviqdYhP4rU20jdXNA2AWKwMM1DTao7+4y5AfsbYOri1mG0D7Z2x2IRf3fAcEkfxFbAE7pfXlIK1Ag+4ILHWHhyjYhCr52rmXbrrfTvKAtREk9j8zm7oLk006u1/RJ0nQsbin3NieoEqV1qQizFnHOrzVvLsI1pEKaQGUf6cxxvfTxC1S7vw2v4X2IjMU0YemCIqDhsx7IDMiA8kmlATFEmmIlIQ20bvgXyXiqXwrerWc423oKZNSkprube0VqJyOXrDdjsncLLXq9cuqI5VlmJ+MSWcWTItDd46BiWPvkaTMoqVdQ3EDIMF1qWW9kh57ZU/BIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb361o2ZjYJjNaDlD9O9pqExVDqcV7Ta1knD55g96Uo=;
 b=is0/i8cRPA3nKtY/VUf5/bsvv4H8Q6k/fCiMJL0eSGS1Nn/FG4PDoLYGWUXnP2bBbvjtuOUTwBQ1SUxuUS73tyw2JeijS7qTDkrd+fB3C7nWft1pzwkVcAXSDcG1xMKgtSpq9AtIH97VyrTl7Nw1/5ev9HGV0z46HEDZOODzsx9qepzOsxfhXR2Mr97xL23wZkKQNtwPBxOhmYlnxmpTqZ+TgrfaX5HkKjmBh3lOv6gMhPLFpSKi5vaf4r/AQEs2tMxmwY0XNqxpbO/4kpNi3IX/ikHcQrb9vfthVqs5y3LGsXGWYjlDEQwqg8uV5H/alN57+aWLJ+cpbN2RoUV5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb361o2ZjYJjNaDlD9O9pqExVDqcV7Ta1knD55g96Uo=;
 b=vXLoo5oW9f+LLuBNgaCZJZqs370PSNJALg4LtPnLWgajkBWkcYadtqurCe3TuYjoTBeVnlAHRLXdCxLSulzw1prJwoD77Zxxskw83nYM4epuwhDZ8i5j8Y804eBl0CeP1UVi22JEmPt3mq3JLUDkHpT183bZt/N040Sts/0CIEw=
Received: from CYXPR02CA0059.namprd02.prod.outlook.com (2603:10b6:930:cd::6)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:43:42 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::36) by CYXPR02CA0059.outlook.office365.com
 (2603:10b6:930:cd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:43:42 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:43:40 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 "Alex Hung" <alex.hung@amd.com>
Subject: [PATCH 13/34] drm/amd/display: 3.2.274
Date: Wed, 28 Feb 2024 11:39:19 -0700
Message-ID: <20240228183940.1883742-14-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee911c5-93e0-42fa-3826-08dc388d2fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9gst7E/DpXgdsCvOZqXb43IvCKbYN/szIbCp9nIx9wd4BPhez00YWukr38rhHwg7vdg7/AwSkhZmZrDpOt6Haf7X/1y9iR4TKe3Kzv0hGsyRIDjXlRyBRdWzlOx11XBcIa0Uo+1rBtsBPiA6uS1kVT6rs2kF7V0kZw0TRGHzry80SyIuux1QDI09D7MAdb/wBI2HQqxa+gI8dIDpwdMKFeqsLTULhUoXdnjittW14ujEuSO8nsWllWim7xVIxNU9Za/TaGuqvRSGNc3T3dRjcHlfSb1Q9EtO7ceRQ/pW2EmBmnTi2s6ioUsL9CkXitFVaRCnZRt/vTdXMn8e1JLx9mnxToAUnAjDJRTKM5n7oTCyxTs65upznzTqUkuu8b7ivSPgbI40FwdWCZ1+39pB0zYj/XKeOUq9/6mimviryqnDeMJ7VD2IbLGtuJCLo3H71jRf6Az9t1+zB5fpToepEOyL+QeJ2IsRlWz3D+aHiRWEizKuGUzGI2f/U3GNROP1QaLRAUx833ejsQmoxKuZ7m7+qspFA2xpxo7JWD+i2RofMusRi9IW+x5C1SGU6xP4XBd08z7NDo8+wLLkDSP8CSrRNDdrGSYiyKxB4uKYsX/w8SbG5pORqERiGo40ecYT3VDVKIOJfdL40JK6bRFu4/RhGLzowyNbMBl5U7nCwQlSCnnaRkNaJsjOXd13hRGxcoS7fc/Ho3jlhyLPHD4+pCiJaB2IDPnxIQvSSJV8nROBTdYxXRvyCQEjAhaQcoH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:43:42.2877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee911c5-93e0-42fa-3826-08dc388d2fd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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

From: Aric Cyr <aric.cyr@amd.com>

- Change default size for dummy plane in DML2
- Enable DML2 debug flags
- Add some forward declarations
- Add DML2 folder to include path
- Set DCN351 BB and IP the same as DCN35
- Override min required DCFCLK in dml1_validate
- Fix function banner for amdgpu_dm_psr_disable_all()
- Allow dirty rects to be sent to dmub when abm is active
- Add debug key to allow disabling dtbclk
- Add debug prints for IPS testing
- Exit idle optimizations before HDCP execution
- Add entry and exit counters

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c9485a7744d7..09c6a393642a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.273"
+#define DC_VER "3.2.274"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

