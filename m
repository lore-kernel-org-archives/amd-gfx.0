Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA2EC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 09:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C832074D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 09:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YhuLSKe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C832074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E840C6E5BD;
	Thu, 13 Aug 2020 09:08:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA9B6E5BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 09:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WceHaFhTJevkuEaqG7ovd9i085JhLxOnM4OGKLC1Cz/lIWl1x8cB3d7W8AdtKnqe3Xw+ybYz13cno7LSvEEWLBKlqsmj7Hmu9u+uYM7MEt+5ufYX6KxcQGKIj1qCtvlCn0C/oLzF81iwIcEqekppktEZgXWYaK/BVNuKAdhKKATO0AK50gYXOqSjebuL4h//yhRECovYdsc9969KGYxqOrP9JlMC2L0ykiMiGfs3NGhQjNQ5tPWuzbPdEvsOXMUJ/fix+yNPjFuc0czBgfprAGL3ayWunMwQaPhBKToBMwo5UK2c3ZnRLuEuKODlQSHvrz0wNdBrp864+KYR4Vcnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfyF3oECbesHTd2UT+xqNyFuSFz5VpdWRMLtR7mpKz8=;
 b=dkvUiyn9XT8BwxjmuYnIgjX4DMwKOMnO9XjQicOmAimdX4MSFCo9Mc+bUJ2XToV17FCmJxR3SDCpjNLFZJROB1xyS1iVnViCA+znm5YmSMoAr9pBUBr0SZbPFdTP04XIDnjqlHUhdlj60Ja8minE6K9tkhFICyvoYi5dNFzzV7NybpqkOLO+zUlhUaiVR534IsNGE6SWXaP6I0ywN0zLHy7SweRaGw6GpUR7aiL8pzYpF2SWOEFnON14+XZ/+gEJz2JnMF056NofSdDAvmq4SoGEAygde5D/XTkn9CiiSFfA5QbEqb3zAwJv2h/rL2SQx2lIf9WXMvPrLAZf/r2cyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfyF3oECbesHTd2UT+xqNyFuSFz5VpdWRMLtR7mpKz8=;
 b=YhuLSKe/0HH7b4UkWc2wA4IwJRnwOu0U6vbzt/jzPCNmvxXouRtgCDXDI+jChJzbr6pk86LmHSXdboISJEmO/eSgE5tVflHmXvwqRfuBw3vhIDoUqp8WgIsnDhn7VLKNhEyRgFwD0Sjo+ES7ri83SD9qOunOiNLm8OiUvxU/7EM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Thu, 13 Aug 2020 09:08:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 09:08:45 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/powerplay: drop unnecessary pp_funcs checker
Date: Thu, 13 Aug 2020 17:08:17 +0800
Message-Id: <20200813090819.32115-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813090819.32115-1-evan.quan@amd.com>
References: <20200813090819.32115-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0062.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 09:08:43 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23559463-6dd3-4193-f3c1-08d83f687aec
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB235878358C52B3728484EDFCE4430@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sd00Jy1jHSchfgwTRueMJkP5JTlDhq6MS6TiTQa+tJDIwmsXLzQYaPzq9X4VCpst364m386oY8/Nd5C26chN03CzKLzyOU2yFGaDvXmiY5hmhFM7OziLGjgd1xdncqs8cSNIgA9owcdZcMadv7hhj0ekXNx3qLlOO4okTzfH6rdoZrnKI0ne9iSUqjLT7UyKIFYek30lPam83Ai3qKgtnLNiYz45p786i3NChv/ZAq2L80kWQwcofZXViT/U1EeVx7W+nlqxCZ6Y+NZXptW8vYNzPoRi7DnccVo+Bebcn9TvstaAEpQZ68sz1Nb5fOT6QEIKzs0g3CRT22adttTuqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(5660300002)(66946007)(6916009)(4326008)(66476007)(66556008)(2616005)(16526019)(86362001)(2906002)(956004)(7696005)(6486002)(186003)(44832011)(52116002)(1076003)(83380400001)(8676002)(8936002)(316002)(478600001)(26005)(6666004)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fPg2Y22lhk9rNvEKUrbdKJvT4j81LUVTYGwYX5Y7tX4kKA13y2Gavq7uF+EUMNzVNb7xzzzB06QmR1U+ryJnKAW8Y9p27aMuYnyM2pW+nuG40d7WohtyM5HOitduZG+c3kTqbGK/u19JoVc7tQycfc+qIsNElEKAwwEhMbOkjiLxNPm4ysdXH+Ocd9qSPmU/amhwQvBJOwQ/5cTP+pPSzO/Fy0GAonn/xeuLwBXASHW32f6UwYqQ2UDTfOfaFwZnT0D1ECQq+hjnTlS1Q3pImplPSQvnTo0dDwOyRs7gA8/jF8KCjwhHUFxkwfgPZTVKhp92Uqf+YN6DHbZTAkUENt/Mm8UdGOnb8cukytsknFNsFNgB3Q/oUIC3POrIh5WEab2hYjUhgfNiurwX4xqlqFoRzf9qo81IaeorRe0jrTIg+/YSFLyBFP5ompQSO5RCM3/Uft2G8hkUNiXiYtRfTWTshousy3fqNr4Mn9uVis8bDGRD72+UcsXd5sm/WcNJUpBqP935IIw5wcyDVIZJvUBVvFOQWFrP1HHRKwictwwh3Ow4FqzW8GSXBGjsmhlBreC2lU4cm8yPy/UNezeas4opnrZr/AU3IphivVVLZpZPnoFy7GnicAjt2eYE+8rorpdG5XvubT7hVJOqa00vKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23559463-6dd3-4193-f3c1-08d83f687aec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 09:08:44.8960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIJC1ZadhY0Z53VT4Bc3tNCjm0YtqTOHRWxIIN4T5qDTi+L5ony6o/L5W0+xZfAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's redundant. Also, the callers should not care about
the implementation details.

Change-Id: I5ae2e334a5657a077747e6bd1428573baad89e33
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 11 +++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  5 ++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c |  3 +--
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 12247a32f9ef..d3e51d361179 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -136,9 +136,7 @@ static int acp_poweroff(struct generic_pm_domain *genpd)
 	 * 2. power off the acp tiles
 	 * 3. check and enter ulv state
 	 */
-		if (adev->powerplay.pp_funcs &&
-			adev->powerplay.pp_funcs->set_powergating_by_smu)
-			amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
 	}
 	return 0;
 }
@@ -157,8 +155,7 @@ static int acp_poweron(struct generic_pm_domain *genpd)
 	 * 2. turn on acp clock
 	 * 3. power on acp tiles
 	 */
-		if (adev->powerplay.pp_funcs->set_powergating_by_smu)
-			amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
 	}
 	return 0;
 }
@@ -529,9 +526,7 @@ static int acp_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
-	if (adev->powerplay.pp_funcs &&
-		adev->powerplay.pp_funcs->set_powergating_by_smu)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable);
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index d8d4ae124d13..d5843e8a6e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5343,10 +5343,9 @@ static int gfx_v8_0_late_init(void *handle)
 static void gfx_v8_0_enable_gfx_static_mg_power_gating(struct amdgpu_device *adev,
 						       bool enable)
 {
-	if (((adev->asic_type == CHIP_POLARIS11) ||
+	if ((adev->asic_type == CHIP_POLARIS11) ||
 	    (adev->asic_type == CHIP_POLARIS12) ||
-	    (adev->asic_type == CHIP_VEGAM)) &&
-	    adev->powerplay.pp_funcs->set_powergating_by_smu)
+	    (adev->asic_type == CHIP_VEGAM))
 		/* Send msg to SMU via Powerplay */
 		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, enable);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index e24d6e533be3..45a902b1acb7 100755
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -304,8 +304,7 @@ static void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
 		return;
 
 	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
-		if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->set_powergating_by_smu)
-			amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GMC, true);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GMC, true);
 
 	}
 }
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
