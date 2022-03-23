Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FEEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 08:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4873410E635;
	Wed, 23 Mar 2022 08:15:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC7C10E63A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 08:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRQhlHqOtJzBBvP6N5z8qu1fAAeBW3KJCz/Oihp0u/rZYRyEPF0MTCykSKhRG0HaCrZaYGP6benuFk27Nets/FSqNISn3q/SuGAbQavnqsHxA+7yFGPLh3lrOdechv34eU0JHwoVqn+EnmuPbmS9eFK6h3kJvAaVaj//UYA+2P9iMWHdaZcTmXXvSjWETqFfXYM/zoH5S0fPbfvWtKNS0Sy9NBvF4vIY6PkVnszxOWYbVZMtHXTsU4zd3AeavyGBzfHnr6LMfB1Vfeq4JrJViv1+jiuqPP0d9gEP/tHZ24jLLn8VMPiEvWlHhk4KOP/s/445z/vGN9wwd1qmgvxnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQBX3i4Mf0HY8QBQ9OoFs36dnfLGM1cLTHyg1F6TJTg=;
 b=j5KCSGpzNMNibHyDQNr/J+7wqRgjXs2wy9Ni0pSHBkwXFOcbV1BShgev1RGqkfnVzGNBB5dOc3FYFc+gs5k00tC2xt34KkMKDy/ydz03qrlKWomUzmzqg9wv81evcZpIGMPLlUhEWNXRZixBrel137jN7jtZh+WplghItFUA8BfOcAsN84BYDqUZesPddFB62QRZBgOH1wBG4GghtQAvt7aLuoLQsDSGgdbziab52grfoK6KRH0CZlyN9HuH5RnFi0TyBLxSNd1kiJdQJVJEzg4aXQHEFz82SUcGx4osboiTZprKqNHQc8rb1GeqdUCQiLpqWyXdjqjjje31o6aX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQBX3i4Mf0HY8QBQ9OoFs36dnfLGM1cLTHyg1F6TJTg=;
 b=jiotJpKGwo/ehoMAs5Rs43jWDRT8Ybw2drTnwLNFoT99xbJuUUNMZKr4Xb9DGhAr5FEIyCv7QAwUBsxE5PR/DRwrE4Blb/JFs3Y5QTI5qdYF9atUplBEzMtC5UL1BX+zsqRIrvnvUliTJ4gy4zuzOTwQQscBndoSDcdylleYMNg=
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Wed, 23 Mar 2022 08:14:58 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ab) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 08:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 08:14:57 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 03:14:54 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set noretry for gfx 10.3.7
Date: Wed, 23 Mar 2022 16:11:58 +0800
Message-ID: <1648023118-29619-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf857391-6970-4870-a06e-08da0ca537db
X-MS-TrafficTypeDiagnostic: CH0PR12MB5299:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5299649BF20C146AD287083EFB189@CH0PR12MB5299.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tC6N0mGJDKm5RAEsuShEB6jMIz/HOqnK8mZXhA3cQhXOdGfj12D8b3Y5RUzG2Qq421Rys9i0vOmLiEl5miT87zDTRrFNKf59af69V8tsjBhlPd2FpDPYKHq+QfkY34DR2RmdtUwpXlmjKJH9CGPv0PZQWgmuzadY0jfgXNiBYCJwJUjzUhy14YBouiMHXh8wWFnfMRT84uKhvEFIqSv2FMDjctmN09tsKwdf0y1cn92P+lE1MtD9qd45SbjEkn08pGcgsGexojPcl55BcQul5xOrarmpKieww9rD351BLEX0aWFJIKpexqnMKLHY5OrKR567A2295eJyrVtgWS8giznuDE9y/7mC8o34HJTR5un0RYcJq2Z/lg0VjOWNY28yMy5ixU3wPv+3ZLcF34CYlDfAaX65OG8sdj+C3mke05C2hFTSZsEmTe8TPZ5AWQlt/KsB6BUvf5RzUXfwzCW0eQoAI2e2n9e2HL64bficgcX4imM2iC/7rjWugvSPmWju1ZUrpfD3eXaW9CTnY1WXX42GYrhhJL0nmWyO2tlr5XtcHHDltmcc3kt1+jHR9cEf3c4qYwP2lKUfiP0lstCM5Gx2f39TyKrc4XbKJgoDgGck8G2FYfPdz+/KZI+cfo53rGh3pyhNo0O4OEGQxR30tmetLNkAoV2kAnNft4lGiLIv/Shw5H3ob0tN1vq2XKjxTJ/kxxj22T3XqI5Fbd0DIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(82310400004)(86362001)(186003)(16526019)(26005)(336012)(54906003)(2616005)(426003)(70206006)(70586007)(6916009)(4326008)(5660300002)(4744005)(36860700001)(8936002)(40460700003)(356005)(81166007)(8676002)(47076005)(2906002)(36756003)(508600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 08:14:57.0905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf857391-6970-4870-a06e-08da0ca537db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com,
 Prike Liang <Prike.Liang@amd.com>, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Disable xnack on the isa gfx10.3.6.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index e1635a3f2553..a66a0881a934 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -569,6 +569,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 6):
+	case IP_VERSION(10, 3, 7):
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
-- 
2.25.1

