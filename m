Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1789C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 22:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E92210E566;
	Thu,  3 Feb 2022 22:14:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BFD10E566
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 22:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oxp8/mntRqf4sz+G5QV/AP1SqBelauqRqrLXYYLUlSv84OTPDINdYCwtWXHQbUXqIjGfM/iVPhqw5t2pJFtAm3aUrXYAMPKOK6AfCwPEC4ujIVAvaZ/XHvxFLvwaveHoMelH7jK+0eijDoQERJaepqqQaSSwGdxNefi7SmYo1U7YydrdZ2ZiQIIppFCc+6fZxooT3r+6J4ayQ5k5WFnH7wVG6kDNi073fiLoa+X+YC/EXLVsNcksZmHJX90EJnIiONjvhelzpTcDL/qknrAXlnXZKu0inrQdNt9Hc6MK6CITCJmYRr1Iroi2r6oOQqGjanRN4TDIi8yjU3Mtz2oi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S3DSENlC2C/mIcsc8ks2ouCvUnVSmktRqJOUY8Nr6Y=;
 b=j/gGd0NzhXHbClkYkYbocfIQdsxOsT6WpOPHnK/8rkxMQhkyVILZB536lJxgqncmQp314icsnJIz1ZHTOTK/em+GOw2DKNLfmkWLa10rzMDViCEeeE+lC0Ek30vAdCRFK/VkIl+SphSzUnDavV5hylqvNJnXmiBW7mvkk1puGQ/QWBgK/wteMET/3amgjyJf0bUrjm1aMiM8iIw1ZoC5hZa8X/J7pDnmNsQ6szH1tFcnW2Jl7dr0a/nqE5llbigWyxlyxVgswV4qHjfxv4pJR3QjcU4VOvS+P2DBil7MvPIje3snAGc1deI8PT+SQSuTD6bjEqoG/sntDXotkcJT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S3DSENlC2C/mIcsc8ks2ouCvUnVSmktRqJOUY8Nr6Y=;
 b=Zd7UuS/48p8jfP4KNW9gOuyIyojo2rWIpI4HCZkV7+uSpvwWoLwFY75RuFjX7c4GtyXOBSzXJVUdGnnrxIP39I8ze+fHjsrZNoNhPBhMXErdCD3fjm61La0tvGWIUBbyI3kHlHVT0oFmyc7HJPzRp+Iv4iqqa0IOqWhCZe5e/gU=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by BL0PR12MB2418.namprd12.prod.outlook.com (2603:10b6:207:4d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Thu, 3 Feb
 2022 22:14:40 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::cb) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 22:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 22:14:40 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 16:14:38 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Print once if RAS unsupported
Date: Thu, 3 Feb 2022 17:14:21 -0500
Message-ID: <20220203221421.93557-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d281d127-5fa1-4775-be12-08d9e76292a4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2418:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2418F8D2B1F6E3253D46F6C999289@BL0PR12MB2418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:52;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daGWzU/XxiRA+77RElPD6l5jaf5kgMJWBdA2myiunMKB3vlseW7hu/JCRz8LqPf+A0PlOjywi3txY+OCqJefgIEi/HH5G+y7bciql3HviCANlCJYCg4dNLFo2MrLlYQVICiqeZu/gMdM33tOj3Hec0yia4k5owKNEMYK9mZdgbsAfCISwRuGX1qjTQ1lhEd4ayo6WkCFyT510lOyjPFafKNcl0RZpoqz8AThphJ0J0bjPIpsY+JgEFXWHugLnzPpi9zewLC3wbvKki5gc9OMENolsj1IDf0LSFroYWXB9Ho1KBfM8O0LqrkyeoM2npx/DoGTRqq6RyZdrTKiHR/lhtZ3CIJDMJNEwUhCBRbJyNHrqATz0SQcotVG92y4QJA6pN7BRojNCOaggqLGNBi9eJsKGNyCSHhGCiTFnJvXCwMHh3Te2dX9UglXYgvUVRaFNCXSiFmeXRW3Trp6kfi9m5E/o9e5gf/jyWI/KDerzzKcL5Lpskix+Uw+ljhGCP7Aboq2vI15bjzrpBmlvEdtoZbXOIxRBI+yt7xBBvK6OD+T61XPrtdGG5R4apvaH2vh5qy789aNKeZxAKgeIOxeUUQLjyL23pPAW9Nj9sMg7zVkrmRPc+4Q/n7c696P6tWO/+/D5y2f6E1ZBRwTqNrj6UKx+1Ds11ydVYfOZoU7iKjwwAyIuWe1VNwGkVs3jxLX/x04bEPB6ZCynEo4VT+P2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(44832011)(70586007)(8936002)(8676002)(36756003)(47076005)(356005)(81166007)(70206006)(40460700003)(4326008)(36860700001)(6916009)(54906003)(6666004)(7696005)(316002)(26005)(426003)(82310400004)(16526019)(86362001)(2616005)(5660300002)(2906002)(186003)(508600001)(83380400001)(1076003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 22:14:40.1936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d281d127-5fa1-4775-be12-08d9e76292a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2418
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
Cc: Tao Zhou <tao.zhou1@amd.com>, yipechai <YiPeng.Chai@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 John
 Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MESA polls for errors every 2-3 seconds. Printing with dev_info() causes
the dmesg log to fill up with the same message, e.g,

[18028.206676] amdgpu 0000:0b:00.0: amdgpu: df doesn't config ras function.

Make it dev_info_once(), as it isn't something correctible during boot, so
printing just once is sufficient. Also sanitize the message.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: yipechai <YiPeng.Chai@amd.com>
Fixes: e93ea3d0cf434b ("drm/amdgpu: Modify gfx block to fit for the unified ras block data and ops")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9d7c778c1a2d8e..cddbfbb1d6447a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -952,8 +952,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	} else {
 		block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
 		if (!block_obj || !block_obj->hw_ops)   {
-			dev_info(adev->dev, "%s doesn't config ras function.\n",
-					get_ras_block_str(&info->head));
+			dev_info_once(adev->dev, "%s doesn't config RAS function\n",
+				      get_ras_block_str(&info->head));
 			return -EINVAL;
 		}
 
@@ -1028,8 +1028,8 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	if (!block_obj || !block_obj->hw_ops)   {
-		dev_info(adev->dev, "%s doesn't config ras function.\n",
-				ras_block_str(block));
+		dev_info_once(adev->dev, "%s doesn't config RAS function\n",
+			      ras_block_str(block));
 		return -EINVAL;
 	}
 
@@ -1066,8 +1066,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	if (!block_obj || !block_obj->hw_ops)	{
-		dev_info(adev->dev, "%s doesn't config ras function.\n",
-					get_ras_block_str(&info->head));
+		dev_info_once(adev->dev, "%s doesn't config RAS function\n",
+			      get_ras_block_str(&info->head));
 		return -EINVAL;
 	}
 
@@ -1717,8 +1717,8 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 					info->head.sub_block_index);
 
 	if (!block_obj || !block_obj->hw_ops) {
-		dev_info(adev->dev, "%s doesn't config ras function.\n",
-			get_ras_block_str(&info->head));
+		dev_info_once(adev->dev, "%s doesn't config RAS function\n",
+			      get_ras_block_str(&info->head));
 		return;
 	}
 

base-commit: cf33ae90884f254d683436fc2538b99dc4932447
-- 
2.35.0.3.gb23dac905b

