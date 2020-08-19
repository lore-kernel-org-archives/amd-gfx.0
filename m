Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A835C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 18:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5871920658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 18:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5871920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D0C89428;
	Wed, 19 Aug 2020 18:00:50 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680055.outbound.protection.outlook.com [40.107.68.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE54E8916D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 18:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jALC2ITNvr6+NMfs0+ZcHXKCx+YXrtWhcdtaX+vETa9j57l32aySsg9QK02PE/RhIY//yD68r1JWHhzj4Bi9dgc9/+XLIDJyG/4tfO6k/FxQuI5PJr/x6LUcQxbNJbMPLAwINpAbK9exTVT4YSnQ0rZBP0JMCly19ujDiyqduOQK8gZS2i9aGNNHARmOV2cKOuZpJGHy2CF7k60zlVxLIkuP9cgna/YHudeLtlURsYFZFyEZneWz86pWikfiP+xYhVKGTzeQelvrxjc15sms0kRusJb/PEsqR2lQlrPqfcRYDeox5cCU1Hh0tQO5IsgsBNUZVDFotJ1YqlonTAq9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoHddia4E7DKV0jAUS/UzLOFCcafX4p5w/S+TSUoWdw=;
 b=E5SzVEhVLvXdmAcYsKvO1TOQ6MW0rboHJKm9i49LiM48hKuZBtloPFWJpNI/xQnf4BuyeKZC1TfidIe2L+3lK/AO99sy01xXfmuJYUZQz49BKuDVufN7ynQOcnuxm7Buu69x9S9WsWEIaEO86Iaqx/ueeFZGXN3851x02CJxDWBanhFdEpNSaN4NK2po8rYQE/aQsGVUsv/dMr/fUWD1kVlU43WEoDXKzyognQZVizUj/61Rdk+XJMdLkEu92Kj0qO3g0EJrxSTW3vCJFh5otdfIgXVQcvDxvOQf96dje7BdDtGqXCwrFA/MDj8k9ooy1/57rLqDkIWmmtKhva0hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoHddia4E7DKV0jAUS/UzLOFCcafX4p5w/S+TSUoWdw=;
 b=s+gAhoHD6B7h07MpWCZ0aQJGgpI83wdPqyT3PfpBQvtPNlGJnd6Gzpsvm5ICwY9P8ess7hxMDxg3PWz/K8gdK7Z1ztvX3vCHs9DSw0VgSDL0stCdvRy6bzmYNm7Di0nhIAfA/TiTAfkp/roQxrm/yyC/aw9FTBeJPhyY658pkaw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Wed, 19 Aug 2020 18:00:42 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd%5]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 18:00:42 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: ignore userptr NUMA auto balancing event
Date: Wed, 19 Aug 2020 14:00:23 -0400
Message-Id: <20200819180023.5352-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31)
 To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 18:00:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14a8f48b-7c76-4326-92aa-08d84469c9eb
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438F74029AC69BF73A3E9BCE65D0@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVQBnZ6KKgUAZowqMPKPngFKYakl+nLNxMQlHTEId4Miz/LD7p9c4JTS8PzvRBPB264MpT9PUcoeaFujq8FoKB+zRg1lLEAr2NndMum8+/c3tT5EJ3eCCJpFORO9iWuG7viXeem0ZRaI58kYr5VydY9rwXdZnK1UvCneESzkMSzecikZ+goO/8DZmtpN9x+TyQCd4N2rWIWCB35eITazXxhVGm4j2kYS1p3i3Gf65rTtIYzxRufEYo4etkQwrzzsP//smMKF8EptCJb0BBt7tHWbkxTkCPiMQYwVEorO3TiAynV9cKjNiT5LL089gqmO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(5660300002)(6916009)(316002)(36756003)(4326008)(8676002)(83380400001)(52116002)(7696005)(16526019)(26005)(2906002)(186003)(66556008)(66476007)(8936002)(86362001)(2616005)(478600001)(66946007)(6486002)(6666004)(1076003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5h/irJEZa0zcCGEUClDhyjnDNjbJO06ObcqEmQtlD8a3JCAMlEZ9GGa3ra+GruXW3JvwMh0Ud0TGyN977MpyIqVZztj++HGJ16vlxOUOXgmc48tSrj+3yHtxKdOAa9tK4dfkjEOvDYGGdOtf1mBJEAEGqWHYACrt3RWGBA+GBSCGyXktSL87bh24q20WAiP0cPL/s4+S7zd/ARkIGplqK1z7l2HM/yx37ZmrgX0CYPHPLzeUDNBMZO7FmhHXhXDBcXtGPIZoaNOGUmfh7ht7zCkluM8iLc7rcuPUBVa2dx/bgFfm/nxcR38a6SQC+AfZBP/NQC+ICZRnR18J96lt4xFAPjNkgXr8gl9pIBgb+vV2yLsv4lGA66+GgL8xTLtedEFVRhldd27j+GmnNuIZr8Q+l5x0tLhew1iSeok8RpXJX3rKt5u4HL/7aLdVO/hIQ3EKEjkJr/V3t5K5V6P/rsVUcfyFfhhuTB8Jt9UV7tMRabA79PVAqmgeOAQrUe8C7XrGyNy/uLLOBBI08xXhpLgXngMWVPfPKNyDhoKTx8cfI6UjLaXGZ6ThbbH4Of97uQmruVol/sp/Y+Li3tGOEaZ4Rpsg/aRYo85IrjwD6CDWqJRxvsKvvTuqcI71bciNzwzMU9piXfa4G1R0jrvrEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a8f48b-7c76-4326-92aa-08d84469c9eb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 18:00:42.4957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLilYMw23ENqD5lqO5DUm/86APNSOD6EyU9Pw+hGl0BNe1x+YqHw7R+uEaXpb7Yh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

NUMA auto balancing task_numa_work periodically change memory range
protection proto, in order to trigger CPU page hinting fault when CPU
access the memory later to check if that memory range need to migrate to
different NUMA node.

GPU can still access the memory after NUMA change the proto because the
memory is not moved yet, so it is safe to ignore the MMU notifier event
MMU_NOTIFY_PROTECTION_VMA to avoid unnecessary queue eviction and
restore.

Before NUMA auto balancing actually move the memory to different NUMA
node, driver will receive MMU notifier event MMU_NOTIFY_CLEAR to evict
the queues.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 828b5167ff12..dc4e2317dc31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -106,6 +106,8 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
 
 	if (!mmu_notifier_range_blockable(range))
 		return false;
+	if (range->event == MMU_NOTIFY_PROTECTION_VMA)
+		return true;
 
 	mutex_lock(&adev->notifier_lock);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
