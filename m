Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB3EC38A2E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 20:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CE22223C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 20:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ya2MXnec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CE22223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F96E6EB08;
	Fri, 17 Apr 2020 20:45:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE216EACB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 20:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjK6tItg2DfcHTcxVT/KCD8kUb1CfxsU6E+U9KNCXt4Gzo+nIUGN9VSdz/yJJ+8m7idKsYbNgqfLC80BQTATHsE27iHHCjzvwCkHLCpIIL7Rt1tJxOkKpbfVBSP1gt0cPB47jf1cZvuYZNhw1F3TV8/0qb64Q/HIHqnzoT8FDClHKz2dUq+dNbwjW7aRVo5N3ndZpZFXgBsIhL8t+RUDb1KuGO2jjP214FWwVl+k2Ci3iHurj8o+jY0IHJfO1NG2Cb1ulRKyb24eU/cmMHhUOLNH/bFqgOsER9xvEY5S7yckVAujbhFZtJA0LwEnl/7jYH0aXeyG+ZQPgBZkSen94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BunO68jFS6C2RfkT0DWCxQkhHpEVHWVvd3dA2R4pGM=;
 b=eqYakimzamnNZzq1/qiNm9vNX1JFUPBAPy5uem4+dRJQhQonMY5NY+vurlxxnLiacrf3lRzF3Unlr8/dMGC2EGZmzIjYcu+pwtEbziK2h3y9ilYMnhU4SgyMQY2ogpKNPVuq3KNUA+ZQO6+YosinLIy7cXNEzfnDzX8HKw31e6M9fgZr9ix8SR6rEzEPyvOK75BZxU8KCMx4W/7W3JUAf85SJl5lmRrd1Ojw7BEUeHp74wddIze+OVYLLVNvlMSN4UgS7O+FePNHk8yW8wfwwj9PN7TZLx3y4hphOeE0TEWBCO7sVhuTaGFf59QTnjknApyTy86WTOY7D7iY7ITX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BunO68jFS6C2RfkT0DWCxQkhHpEVHWVvd3dA2R4pGM=;
 b=ya2MXnecGQCGIKAKf5MsbS5DJY5AegdU+2jBLAKiZKtKUnRH81f/41P4wiBUHq8mTyZnd3LNIqYfBiWD3p8dChjRnQHOnIUOBDqYHoKQx0QWBzBhWL8YmwbUP+/r7hi/QZhTe2htKyKeuaJ373dzfkVMMOzd0NePnYf3g7OM4LM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 20:45:02 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%3]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 20:45:02 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Adjust the SDMA doorbell info printing
Date: Fri, 17 Apr 2020 16:44:45 -0400
Message-Id: <20200417204446.13999-2-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417204446.13999-1-Yong.Zhao@amd.com>
References: <20200417204446.13999-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM6PR12MB4482.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 20:45:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8208bd0-459b-406e-4261-08d7e31033e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:|DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3594C84E0F9DC294EED4FD67F0D90@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(186003)(4326008)(2616005)(26005)(956004)(36756003)(316002)(52116002)(6666004)(478600001)(7696005)(16526019)(66946007)(6486002)(66476007)(8936002)(66556008)(1076003)(8676002)(6916009)(81156014)(86362001)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3P94/AwBc1RSiiZCe+lkkaRSMAuC6z/EcM/EGzWB22cijnktyop0MGNed9jjtjb7yr7aOeIpS5OpixIcuq7ApbvKf8jQXPgZRFxEC9oR4wbZQxglaxbdFG4u9NzdWAblrL6na/xRV6bJzgryq3tDw98LcHLruayUM26N8U2ZN6Ybfuv+TeclLRx68ajsepqClzkMnxr46Vi6/TZpqECb8EOLdTo19v7avjI19QWz9hPwaRNoTSKSMK3hpLEa4cT4cAOXm7LmV/LCER69oOlVVLGbTGp3HB4BnasXsV28yhe8OHP3SOe1gwXfS+Ylx93M1jVtw4FiZLB+0zgu8G8HkEiX1g1hIsF4rpb1pnlOBxa3jO9KEInQAwp+lF/BGlBNIHoSv8RB1t1J32rtcSXkJJxbYnPe/bqnmtcHUSU3Az66DCSK4sclDOkVeOo5yAe
X-MS-Exchange-AntiSpam-MessageData: 1KEVGAbjVo8sbcjmkL4jh2aM//FZAucyDzitnQtv3weTFFyJShcDusj7wwfb1fLQw+SFEAG3ccGpscjrI4eO/JnWLPo4c6kTVjB0RWZiQDtGSNH/VhNQetv4H56oIJ7AM1iNTug9Y24HqAvT6tVp6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8208bd0-459b-406e-4261-08d7e31033e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 20:45:02.7903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21rLDmj6pHPB1N86vMHWL+PEN6TwrQOD/zbpGmKyax3dr1W/943EOaIMhMZG2fwi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add more detail while turning off the printing by default, because it
is very useful.

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 352cd9632770..c0ca9a8229e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1851,7 +1851,7 @@ static int sdma_v4_0_sw_init(void *handle)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 
-		DRM_INFO("use_doorbell being set to: [%s]\n",
+		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
 
 		/* doorbell size is 2 dwords, get DWORD offset */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index f7b2bcf3f293..764f455ada75 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1260,7 +1260,7 @@ static int sdma_v5_0_sw_init(void *handle)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 
-		DRM_INFO("use_doorbell being set to: [%s]\n",
+		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
 
 		ring->doorbell_index = (i == 0) ?
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
