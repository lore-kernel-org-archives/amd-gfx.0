Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075CCECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 05:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F7610E206;
	Tue,  6 Sep 2022 05:45:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF8310E206
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 05:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY0n0QRCaa1mAXECmTiaI5NsaIzcmQ/FKr70K7VqkLjeZQs/I3wld7WoL6pdEgOpu7614e68o4uwj8CFpHUrz9Uk5oeIzwU1aZHS+qC4C1go9rdo/Y6ZD3dXy1apWX67VD/QecN7X0zuzs9wdhZuQI2Ly2WO13A2pZQ3gbtVYooMrbmDQutP2d6KRLI7WL9EfExCgg+ALpWDwYr+yQwwpuV9LyLDKHfBba8d8Cf95TUv6c2Uev5kYg/o9b/kXoxjTZqgzz8Ech0F7Jt+1G4mV06DsygeXDhlAktlulNttf457B4ovxib4Ezbieg4A1TQsLTNrOlUlTDIm+ltNt83NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uvFNtFWWkP9Biooq/1nixftDHE8VW/5gHYxFV0HsSI=;
 b=amF0tM4t6s9OKFZs+Xd0ZxSw2E6yoxvx0MgpN8ak4mLvL3ElhXuN++f5l0eOj0uvPT5pm7MvCxwFajV0CN0eUOE8xqldlkcKkC2wfy5KZCIS/+zSSf2nnCk89I0ocIwM1M76h0Ky9qMqT17px/Kul6zxhqhtgSBRAhsveA6mgC6ZVU/eAsqFl4jnfzzVTAz/RDmj1S4B24U4aw2yTfxCjhZH5Kt1T5BVQJ6DgFoh8buC/8x6p0wdZhgnTNQlYLuj6AGyuLX7htN2ulEyr+RJK+LJm3+ifnoM9uOw3tG3R0AGndE7rTZl6hV5tZihRW5vdLbzQt+yuHQiPq4iYJP5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uvFNtFWWkP9Biooq/1nixftDHE8VW/5gHYxFV0HsSI=;
 b=FT1Ri2OFJSTpYSZMqcQNQ+j5l4Jhgl5ZcZEyB+CuW9prc9BOIKrBoWACODbFzGMf6df1ycOfw1GIo2qinT+dp6cpwvDu3v8WP4EroaPl4IlkfzEpOjjZj9aJ7oJo2LZq/7uNkEZmVVg16dOPHmMShJjcqSS2VgVVncO2b6NL70w=
Received: from BN9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::15)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 05:45:42 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::c5) by BN9P223CA0010.outlook.office365.com
 (2603:10b6:408:10b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14 via Frontend
 Transport; Tue, 6 Sep 2022 05:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 05:45:41 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 00:45:39 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct doorbell range/size value for
 CSDMA_DOORBELL_RANGE
Date: Tue, 6 Sep 2022 13:45:22 +0800
Message-ID: <20220906054522.67936-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85f97bd9-1eb7-42a7-543f-08da8fcb091a
X-MS-TrafficTypeDiagnostic: MN0PR12MB5763:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atifRCZ2+ZCpYbLlfWEsTh23fjpawNtKSQqQZ99HBr4zNA10TJWwz/0gpx4xI3cpWUs6BPtIyRIA/Tcl2Q2tKqUz7BbVv7OAr7ZlTqWpJCcQdZqfTRbdiqAGAcwOXZ/bfmEEKQQ5D21atFggUbOb2Lkxf1L2TBfXliPKKqquPW5nctPrBEIfMkgU/hII/LBUylFOBT1FsOCDtgXfck657gDbj/eyNw+DgQkVovxrGTVuNcHfXpgiIq4pT6+Vneq7sW84HZPdvTGGPoZgQg9G2LJPPV3HvyYahyqsNXTh0JmVJbYqVXW7WT9gX4SF75aKtM5aOz7ssgyVFJOvKXPZy9qWAZSvlAOOE3Hx1tc6dSvWB5mjI5iZ8a4wjJdrnrPb7lH/akJ+kcNIty3w1YV+S6KtF0EN5KpEAWpbA8hi20C3H9eBNkuWmNjjM7NRrT9/8IWZ9ycR8v2uEBOQeaEPhVDhQdJjvO8o/8/TSEBnuswaG9Lm+ZTsy14oaLVIAxpd0yV5mibrJW8B82Ga5WMuKoBTnU9h9w1P7qEkjbgW4oJkZbe0tVYbbLYvqIcNJ/Dw1lL5uacnacv52MaIKHRByulTS9Qi94g3/gSr4V9KLY0aUyukTTRmU301UwvD03o9g58cNP/SRnDYTcUAaUealhyWn/YksNRfEhe6Bwl9z/f7qxlnj9BTdGi4RSgwA6aIeWbfHiLxGcsevogpVKtLKdvXL8wns130W3qChPz/hnWuiMZHh4v13YYQ9uoDKfng/sfFFEfKlIOUFdEuVu9cgE/tpO1W1QN4LE/Hyu/i02OjvywEHpc6bosr4hi2c+nk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(26005)(336012)(1076003)(82310400005)(86362001)(40480700001)(2616005)(82740400003)(6666004)(356005)(81166007)(83380400001)(16526019)(7696005)(70206006)(316002)(6916009)(36756003)(54906003)(41300700001)(70586007)(36860700001)(426003)(47076005)(2906002)(8936002)(4326008)(478600001)(5660300002)(40460700003)(186003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 05:45:41.9575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f97bd9-1eb7-42a7-543f-08da8fcb091a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

current function mixes CSDMA_DOORBELL_RANGE and SDMA0_DOORBELL_RANGE
range/size manipulation, while these 2 registers have difference size
field mask. Remove range/size manipulation for SDMA0_DOORBELL_RANGE.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index 1dc95ef21da6..f30bc826a878 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -68,12 +68,6 @@ static void nbio_v7_7_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 					       GDC0_BIF_CSDMA_DOORBELL_RANGE,
 					       SIZE, doorbell_size);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
-					       OFFSET, doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
-					       SIZE, doorbell_size);
 	} else {
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
-- 
2.37.1

