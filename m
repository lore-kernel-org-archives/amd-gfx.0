Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EBCEDE989
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 02:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58C410E03F;
	Fri, 15 Sep 2023 02:52:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AD010E03F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 02:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbF0xmJUB6grMgFuOT5AT0en2Cwxjpca4UmtqxqXClkR3FyTQTnkTmDpR/s62s/szK8zaXpCZRT/r/kFawl8oNNOKKU2Om2ogwcoKQucicJZuOKaMeFzWCuejgr4gNJTmloh/pxqv4BIOHSCImGKUwDjP0YpaKZFySLeJenaFiHcAcCsxiLGHcLfILJKv6KAowTICK7ZOaG/Wxwm7g0OrAigb5DQGDalFJ7Cnl3kDZ5M3u+GfDg9FrrdeQz0xxA9z8jNgoDkhW3dm2OzryRMddX08pEsej4j1tsZKFrvKj2cRwfY0RcnShPmIdjZcMGu9lHhhxFwoyC37x3/BHCThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPgRQPXVgbRiylalNFa82RMTiI1opSsTebQYi24wjFY=;
 b=NA55KuC292Aksgor/KV+yE2rQpE7QhGB+RrREkbI2cXD2sPre9YvaiWeHXgI6MCDh6+BtkNPXux4QGERWTyCUvRXEdpYXByJErvaMCU7KQUp0Agd3vcEnR1Xc7mWEQU0/tMPEfwg9g3OWfimlShkYO7yHv9yaHZ+5/Xncb/4vCGpH6A30J96qtTxnx9JNbQCY28wwreaVMjaU0gX2RGDQsEEu5TXhEnEQqlrQ5owF71A2e98mKriAoxyGkKe6+A2TbkWzRHwQlluLbxqg2Xg1fZWPBBVPDt0xZEJVqAOvLXyhhed/3Hz/zhjPpff8Ltb4789y/dpAa1JSfe2+GfHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPgRQPXVgbRiylalNFa82RMTiI1opSsTebQYi24wjFY=;
 b=n+1O1CDI1hBT3r0SjhjsVFKZmkqH0eTFVUS+QSOS3S9bsKdsh7uur5ck2eTKaiUFUFxRKm3bvvjybYKfQBBPxYczFxIOQzbHdUpr2+TkDHJb6hnFqulYG62l1LzfnVbqDgeoifXS/5NzRtlcGraJfAcGWvifpeayNidENrUFkVc=
Received: from MW4PR03CA0163.namprd03.prod.outlook.com (2603:10b6:303:8d::18)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.39; Fri, 15 Sep
 2023 02:52:32 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::5e) by MW4PR03CA0163.outlook.office365.com
 (2603:10b6:303:8d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 02:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 02:52:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 21:52:30 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Thu, 14 Sep 2023 21:52:28 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use gpu_offset for user queue's wptr
Date: Fri, 15 Sep 2023 10:52:14 +0800
Message-ID: <20230915025213.2463291-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: a27c0192-d457-404b-21b7-08dbb596cebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gm58ryMd36sCkwLdKPgx4eSflaAd9kmiF+yLg1oMheaeOPaqgR6UCo1oHG1c+MNeX/zxUL8uiUVJvyU9hx4VmN1CytfoQFRejNUEaVMD8QZ5v+PvBNWbhpLtJhe3jB85W6gOVUTZ7PfqQjfygu3RVT99D5uZ1Bjk45RBeucgOLs8cta1eqyDROrkgXcg8z14zRmuXmil+0hvHHkVDVxsyJHKApaBkl1d6krSg/OhTjEBUMd7cwG3u3C6IwMluSnDVx6/j2p51bW9O9CrPeW8jXNlB2FVyrZLFZ9NkMuzvF2WjhLxyu/48RsA1+wfEFBDudygwhty2R5mM6tmhTgaCP4wMPXj174ms+W666B5lT2YDcLJle6h7RWqozII9glzJuAn2nLy/K175HtlYiQJwAnLuYzL0XomCh0QMfn6rcNndLB4rDdLEobYHKf8gdYo3xVtTjJ/ModwNB6DHGpnI3AT5trNLoT1nH3OELn7d7ZRsIiamSNc6zH+iq0ZlIfkz78/54xFedDmUaCyIXghufaH7OW/krSSc2zwhMJEzOppxzEVZsfHKWemD2GzgvkBNvxc2AQqDcamFfBP7G7/eHBtnhPbhX9VvfC8iL/Lyqhcwqm1/wFYwVZfMdo443/pBXAsfLQ4x6AGW5LXlAjMZYj68aKb+X7XKRi3sqEDC8wzmAk1b87+hwl1JO0fCZLb63gs0nJTQ3wP862tL8SxzKH0qX8yzruBfd9akR62jHPQEzLzKZkWE4hTdWwU3iV/it0UDl7dj3cxrf60eRcxRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(36756003)(86362001)(40480700001)(2616005)(40460700003)(82740400003)(316002)(54906003)(6916009)(70206006)(41300700001)(8936002)(70586007)(4326008)(81166007)(356005)(8676002)(426003)(6666004)(336012)(36860700001)(26005)(1076003)(478600001)(2906002)(7696005)(47076005)(83380400001)(5660300002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 02:52:31.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27c0192-d457-404b-21b7-08dbb596cebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>, Deucher
 Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Directly use tbo's start address will miss the domain start offset. Need
to use gpu_offset instead.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 77159b03a422..36e7171ad9a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -216,7 +216,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	if (q->wptr_bo) {
 		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
-		queue_input.wptr_mc_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
+		queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) + wptr_addr_off;
 	}
 
 	queue_input.is_kfd_process = 1;
-- 
2.34.1

