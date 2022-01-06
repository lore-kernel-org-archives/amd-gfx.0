Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4CDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 09:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97286113F0E;
	Thu,  6 Jan 2022 09:17:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61527113F0E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 09:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZnrQWylonQp3/dp2c/RwxoWlPBoYViRi0+jEwB6uzN5+rq92AZ7qXG7zC9fGd7Ew9qzYBXwqiSexcKB/7LGe4auw7KhlS36zHkcGfssspl3Uajzildgf+CHpsVxQ7HEyedyPQGLyYVvMGOKXMYsYcykrA3eGdY7kYGt6DQnDt3RcEpX2SNyAE9FUcLHh6jpqidTMFjtIiZYF6ELYhDl9iRZhtHLONwkQW7aN2jDkgXgVtzCI/GUPCj5z0oVOiXjapR/7Rh5EkVQjrFYU6WSenN6VvnQdL4zzOWINA6Zpaqc+NKCMm8l/aq/AIFRvQHws4B+04SAnv7cNYENyhvv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuZqudoMwGUnaQqaV0HCwr6E0bVoHBYI4UzeJCVni5U=;
 b=iaNRlFAP2Wc81nreEL/OTH33XgjbyvUHGJA32I00w77Zyf+fa4hqHk6tk+SZ7lG3oWbjGdBj67mCmiDJu60q3KvF8TapcbrtqGEp7QqrbIIIPwOwbu1kH4LeaD6dcSGR4oMioDZLcFMMJizM+K5Pt2B7WtobYJ+oVmXWp6MvbqCSIZgxOZEsuGiV403sSofTRHIIHz5zf4DNV2pSQEKBQ5mMTqIQ+1BM7GA2x1bCk0ntkH4uj8untP/g9kZsdOmar28YDEo1uDqGXC1Bd2Y/pEO/hAkUhIKXqhRthafY48eCAuC78deRCTGQLzrc6yKCWC3O0BRGwgOVnjAr3j8qVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuZqudoMwGUnaQqaV0HCwr6E0bVoHBYI4UzeJCVni5U=;
 b=PCPxsD8kgT7ZuuYOCN2ELljOdLYpJMIyxICCUojBFmJNXYs2ZzvND8en7lylFC5xK+ZvU0l8LMiUJQpgL66XM20qpde0QlHbUJI12bO7pxDRlFNt/FrDhtwVr5Kn8zuLHjC0L40SfHylpIinEwYQ3GywQQx0rs2tWfcKwYV78vA=
Received: from DM5PR07CA0153.namprd07.prod.outlook.com (2603:10b6:3:ee::19) by
 BN6PR1201MB0161.namprd12.prod.outlook.com (2603:10b6:405:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 09:17:05 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::f1) by DM5PR07CA0153.outlook.office365.com
 (2603:10b6:3:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 09:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 09:17:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 03:17:02 -0600
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 6 Jan 2022 03:17:01 -0600
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <John.Clements@amd.com>,
 <Stanley.Yang@amd.com>, <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Clear garbage data in err_data before usage
Date: Thu, 6 Jan 2022 17:16:40 +0800
Message-ID: <20220106091640.18705-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68cd5981-636f-4af7-a4f7-08d9d0f54e81
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0161:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0161FE35818CC5CBD2BB2E98F84C9@BN6PR1201MB0161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68PXHBTOPKQt3epu55FPc9UNX5D2Rm8/uh7EGoTqh0Qvl6Kms1q5jDMNWPlvVv5kbtimFGYJ0rxQMas5Yp8HRzcHL0hvL8kq4jpcYv6eqCRBT57yAIIkhQKAGRz2fmcXRRnaKXk8E40WrBPcHDkC3EKuBXxdYO7BDsS/YQ5eMgPRGFHGTT9kUmeTJxqagott2QCDjruQMPCTXSf6vOlzaX7Umjs29T9TqBY9o1PdTP7n+J2cXsBAB0ROfxgH88jjT1L48OwWsBp2Gc/V6OpH6tG8p2aXQ+X+CsJVAZ1WN23dOTwcYNnbElR7ccmCewDsqfNSbupNuKdmdSLka4aBQO8SXEdUCSRfx3Zl7WIIXlv5oaB1puDDhKFcKToLv0QExd95wdO4aY2BIuOpOyrREIUXgrhjG5f1MPe3iandwU6m4bYcLXXo4d5WrhbAbfix0vSc5U+148z6ThDrdHkGtr/938sqVoyDzq2+DFW+xydMhYRyFSr386x6za9jv/KwJIFuc4/6H+aAbe2k+ZBog4H5Y0yhc5fTnE18IWo0MS1hzDyCO9NrlzRVc1zu9ASr2W2/g8I/+0bDXpwcLhaXvkmQLZkGABoth6iVvaWQ+77YGoClcwOKm9wQUmvrSlYFQyvMciqj7k80OarA6QiS10RW1yQnbD0aRvEgl3/paLSb3OvrL3havsreg8PqbXpD92kyUn7yFSUR2b4SlMN7ZWnunSN6OTpXmAKl+SlLt62fbAFzErgXVkPf0fEV0CECLhSWw1SU6hC+dT+ScLWn3h2NIBaKK077ZzmJi32IB8s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(36860700001)(2906002)(82310400004)(6636002)(70586007)(8676002)(70206006)(2616005)(4326008)(7696005)(47076005)(336012)(6666004)(36756003)(426003)(508600001)(316002)(110136005)(356005)(4744005)(81166007)(186003)(26005)(86362001)(5660300002)(40460700001)(8936002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 09:17:05.1226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cd5981-636f-4af7-a4f7-08d9d0f54e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0161
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
Cc: Jiawei Gu <Jiawei.Gu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Memory of err_data should be cleaned before usage
when there're multiple entry in ras ih.
Otherwise garbage data from last loop will be used.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 31bad1a20ed0..3f5bf5780ebf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1592,6 +1592,7 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 				/* Let IP handle its data, maybe we need get the output
 				 * from the callback to udpate the error type/count, etc
 				 */
+				memset(&err_data, 0, sizeof(err_data));
 				ret = data->cb(obj->adev, &err_data, &entry);
 				/* ue will trigger an interrupt, and in that case
 				 * we need do a reset to recovery the whole system.
-- 
2.17.1

