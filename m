Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF24C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 10:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5605CAD415;
	Fri, 12 Aug 2022 10:20:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA10AD3CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 10:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8o6seuDTHWSpkBzAAN/CAVgTHRUYk7Ld+vtJfKMgq5iYruZHLyA9OuSvNJe2lyAqcjUyIJ2+V7S4iAPjd/NmZulu1yltxVTFGU0d9y3Dpc6Q9+8uva4h4Pl/z5k5Mk4eqZ4YbtbhLzaTh3SLicIg13R7f3IvuJ2ccBlDeYV4sV5cjP1q+0jWp0hjDuc2LKnVwfnTBEHO0Yzlc/NhaI2ykN2SfXCnVYAUO/J5vUGi8Up6q/44NQAMc+rMqI3XOe0iB8d25WAvc6wFRbk7rRvjlZZBXUnR5keO6xx0fO4LI/Drjm6faMLf6RfLtQ+BeAO0qKgfko6wRmGmH38HT/JxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gim+EN6wlbwF1SNbS8pDELVjbDdRcLiVTIsV+FFMpuM=;
 b=H7CsWNEpPN78r1TVZcfQMlnsVaIfuIn66m8S8IuhqOtE9QfFBSeRRryvcl3vf5XXxc2//sbBNACr4g7W5cFF0LLCgL9fqkGJ88ddeUdVNFGraRm/kw2dQUJwGZsPeF2lKWSXQk+YxLwjOYaHWKdYMIg0KO5ERZuyh+rb4XpR8VxCqG8/svMuDT6lOYyYedxl/DsL0N14a94nyLsGfKdrRQbmyziBE+7I3e/6L62l0NHR5406KXcFBL65fNGcHubr33iGfLLXD5iNAABTmJ1hNGAVAPjJoaQ1znZNXOxojc3qXjuLPxpiov35HYifx1HRkqQRHCqOFnAcxqZ3iilNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gim+EN6wlbwF1SNbS8pDELVjbDdRcLiVTIsV+FFMpuM=;
 b=au+smeXKKp68sNXMSiVAVY5QbnccLmm2rjhV0k17bHxskY5oE3zX4Y82PIU994HyWWwSlwt8p6iR5TUApCMJZsqb1JgZhkZQN18/M6FMYu1PHbuFMSi6JaecRQm1hLYJOZgkUPL8UpYgVxiv3wjv0CwJMIgzlc4k81Xi/kENNmE=
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by MWHPR12MB1135.namprd12.prod.outlook.com (2603:10b6:300:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 10:20:37 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::68) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 12 Aug 2022 10:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Fri, 12 Aug 2022 10:20:37 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 05:20:35 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: enable IH Clock Gating for OSS IP v6.0.1
Date: Fri, 12 Aug 2022 18:19:52 +0800
Message-ID: <20220812101953.3884354-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b56c2a97-764e-4f44-1828-08da7c4c4cf7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQu2lMFAdjL2S01kXSS2kDYTFmeVFvjNnbftQugAcC8fjmHbIHHdhDH7lWUK1ssKYA57y43xEv7hLnqKB9aPfesFvK0Fi+xpDP2WE6X7KgODwfqrAdSfStORyp5Xz0UQfB7VlF/l3TPzU89y7qrlgeGJDaqw6NqHP3oZ+SoY0Enroin7sTmNCQF5ojiCud1zHKOt5+FPY+BnA1yEMe3rXf2T64pG1uoCWZNN4kzqHeVc61/Freum6oBlsEUE6Z7ei+fHjzv66h9H3XPogeG5H8PV8+uDvRQrjUTuCYnekk+mmVeP1YbdpuJNoybS/lqMgAIS7Sd4Y9fcvzNSdE1dLUAmERwXFIQJ+/yI8wveNFosnPhxZZQFI4VAB65MKOwXXOilgDg9l33dMorC1VQuMJ1w+cT4drdKvnIkYwAfKg1EIlouIZr9FSX3CZrK+tpd2TRiyxfbVZlOclO/tdRZ8prNE/ikldAI5YADHJAZoudUUM9W15w+nYaIwzbKjZbeS83hmYl8SPOGHTMjFxq8cMl/mhV5rJKsGt+gAI4S9v/ZTuO2LgOxoo8rfsrHWvLlOfKiTADbn5EPWsThD5IvSnaQ47ttVfqCMzapZZpHEZPtKBlZdZ1i1GMzWMeYER6+LlfhJawXCLmL75nmNYoblhmoRiEJrv8v9fOxjNniZBfDpSMvzK9RSBdjpi2WmRMTOtLwCBH56tq1fwf8Oynm90tQDaXkKEIpCkKrk+y3KZpXqneiuY89gH3i7BbxYpXDz6V+XnWejVR/iJDvaFnrmOEeTE9/ZT+nF3JQ6cqrYjFJzBIDh4jchimhV9WQ5N5YtElFhSz5D+ajNWS3YqLBCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(40470700004)(4744005)(426003)(356005)(336012)(47076005)(82740400003)(26005)(1076003)(8936002)(2616005)(81166007)(16526019)(186003)(5660300002)(36756003)(40480700001)(44832011)(2906002)(70206006)(70586007)(4326008)(8676002)(86362001)(478600001)(6666004)(7696005)(41300700001)(36860700001)(40460700003)(82310400005)(6916009)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 10:20:37.6186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b56c2a97-764e-4f44-1828-08da7c4c4cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1135
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable AMD_CG_SUPPORT_IH_CG support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6c3440e7ed3f..1ff7fc7bb340 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -602,6 +602,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
-- 
2.25.1

