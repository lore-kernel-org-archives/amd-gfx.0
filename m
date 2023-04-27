Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8E7C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 08:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD02F10EAD7;
	Thu, 27 Apr 2023 08:03:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F63010E8FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 08:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgLpE0vBB1UnjXyyd7TJv6A7WkSu4xTR0oykyUHk8p6nDzv1sEaNJQc29SawwWZWGSOQXTNusvymAHZEciQybKDBKx5plkzx90PX21n3t/ITkzeNcoYavuRcyHidTdJqkI5S5Wwd4VQHjjOYQLpQuoBWJ2ADNZoU/uNMYjTpfkCAlfvyCnVcvBs05K/4NjDodyeZ5G91tgzuWCZrQOaKRN26NpW6x5PHNHNW52tcLvqgOxUqYjsG5WISlJY76yVRzZcNq2ZvBJbN068eVFIFafT5cV2E2x6t7Y6Had4xma0dA+UaXF75rGG8fXEzj6eBxz9ehZ7tf+ZTmaT4fe7UYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC0IF8R25g0O1J/M6swE0fplWL0HUHuCY/5OX0wA6Uk=;
 b=dPjOTsZKRDfhYyQemPq0rMRRT4wAoGbwk+zDK/i9ylXEVgCt84/a6ZydwViSKoKdZXZTOV4w33+mpiifKr0flqmO97WII6AIajm+PnvnjhJSe2tPOstIBpNHldOGTpfIjdSQ7YhIoLjY6EXQvrpnzgM+FoNj08oodXUtmBasEGbUID0eXwftfCgEfxKw1rubddY60OverPvCdI0IKkFp3Zq+rk2V8XRcFBwbZdCX61TQav4SEhDU1CQuTpN0mXxRlYq/W6yXSfqmYCjrVISEedv1v6zKVzliT4BSkdhqrDztva4k7SnLhgaVYETGhmbGKXPcg2fCkQ12nUVDcka2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC0IF8R25g0O1J/M6swE0fplWL0HUHuCY/5OX0wA6Uk=;
 b=zShiXFHOm/4IBqnRtXJJy4R382qxNLF7T4BP7dj6ZFEwRSzF0pT0DOfVYQhGfts19+CI4UbmaOUZRVeWddPlLDOYgIANDStL2BjDF7aQHJ4TW3rLcqlvHWdRu+Q9HPCTFW5BTde70rGGzHhU7ohi5HJ2JhK9XTtUszRmP+26YBg=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Thu, 27 Apr 2023 08:03:44 +0000
Received: from DS1PEPF0000E637.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::22) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 08:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E637.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Thu, 27 Apr 2023 08:03:43 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 03:03:40 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add variable to record gpu reset reason
Date: Thu, 27 Apr 2023 16:02:17 +0800
Message-ID: <20230427080219.374815-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E637:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b47c1f2-9a4b-4dd2-80e0-08db46f5ebe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIIwty6o+ewgpE+zqFKfTk5P4Xb+aq+osKfMGnSGUQD5BONMR1ndHBJ36vHcdVYtteZmpNDCUmmdNWl5UBvRYSQrONo3eDnGVdl4jxXgMSk7qBA1I2xq9dXG9GKeE+WBgtAzieTItptuTdUa7S/sKYMY3SQer3BhYrsA3LAEUsDTMtEypchVH5TQkyt4KvX/PGFkqIAxs+afZL71rfccuOjbZ75Ot+r9nBcCqN2HtvWgN0+evCpQTKwv6dSvnbFHgh8TgLDw1kowrmN2SsVk3ZwXr7a7ckIm8V/Ie6dlitJLoHjTcrPoezIDsjI6gjPi6jBlrAPljHUSBxjoKXHTj2hy/Om2//DkCerGdH+v6hdFj7mcqP/pocKQFTeoqV1BbNySEbbUBdK6qn3keW/NGOlMhLfgdTZo800PvG0FqU3R0fPRcG2UIn4xzmoCL48xwBjTvpboFHhqRhFSgH9s0myqNp8obos0AlGtCam9jX0el6Ytf2Rh5ByDXctcAiki36Xsy227K49LXmnYpl2jUIxASZDVScuZ9rS4ldLVo5iW1JJqY5HMjW4pTRTkNCD06BF5bxgHXy8in/t9CqMabSGJGp+hFipOgBo4x4Xt3NntOkXAPJPv/4uKq+Bpy3/SZNFaRNlzgmAK3jEeKJj+kIr4Rjr2cwZAtiLdtWdwfxbAhknvjye7d9ctnI4LhjfqdaFPq95VsFMNkpyQjs6ybxloS2OkOtB69i2EzK724XU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(81166007)(2616005)(41300700001)(40480700001)(478600001)(82310400005)(36860700001)(8676002)(8936002)(4326008)(82740400003)(6916009)(356005)(70206006)(70586007)(83380400001)(47076005)(2906002)(316002)(426003)(5660300002)(336012)(86362001)(186003)(16526019)(40460700003)(54906003)(1076003)(26005)(6666004)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:03:43.9866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b47c1f2-9a4b-4dd2-80e0-08db46f5ebe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E637.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add variable to record gpu reset reason.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ef38f4c93df0..dd9e1ff360c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -385,6 +385,9 @@ struct amdgpu_ras {
 
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+
+	/* gpu reset caused by gfx poison */
+	bool reset_by_gfx_poison;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 068b9586a223..e2faaf6b0a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -84,8 +84,12 @@ static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
 	/* Workaround: when vmid and pasid are both zero, trigger gpu reset in KGD. */
 	if (entry && (entry->client_id == SOC21_IH_CLIENTID_GFX) &&
 	    (entry->src_id == GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT) &&
-	     !entry->vmid && !entry->pasid)
+	     !entry->vmid && !entry->pasid) {
+		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+		ras->reset_by_gfx_poison = true;
 		amdgpu_ras_reset_gpu(adev);
+	}
 
 	return 0;
 }
-- 
2.34.1

