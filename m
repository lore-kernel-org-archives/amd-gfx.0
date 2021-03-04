Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF61BC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 04:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9B160C3D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 04:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9B160C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1ED76E488;
	Thu,  4 Mar 2021 04:54:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B876E488
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 04:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUirk1383UqbqDfG6FLbQ6Xb5JLzyNGqv5uoxNnt+WfHmIoClrpD5yYFhUUCX7hPVA/qVuCvCti6MsQGH+5Jj3DKWOjV1qaynMrEOABy7+YAT42W+LJuv1eR8XlHWTnOnPKkZo4TYtYpIh+6ucYbL0irW0Dq7oEMa/wobYERDGKvlz0NPYpipiLizveQ0/I+HIk/EjXzJ5XkTvpk0hpmeC//V+As9SQrTDL1rU/P5kFixk6PgV9NWniztnY9jVfBDpel3XfwUUp871tdaW9bVgTPg1kFSpsvXx8Ct0v5yVRSS/ZZ/E6wm6w4MUr0/RRG0wvn5l8iFVM5VCthvjuCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQjj/SYPTOVN0oZxTdZUneuGTZSy43AxiaiHWaMHF+k=;
 b=BZfR/rjEgtnBzG0WTxWIwEbY8Shfd2Hvx7LP25/YDBRmP25Pjczwdmu06VZc67dPP42ezmWCVR2ib88TgJs1HVC1+DdktdpZnoj9bDWYCjJgbzawfFHSJqRb2egA5n4KGrPrFfcer63f8x4ns3hdTQqJtnyw6mnAR8wptjxR91+CfBnMmaUW/WEP4E37NxDVbBa26P6mbbVmu/BDxGbj5oDdw9xTjmQ0OLXyFF49mh5bVktIbccX/vwsGVt4v99mKj5GmY/yvubrsH2yx7ZpQHiWXSm6XeUu3P4GfiGFFIJyRdYbqC3Xi8rOTdf7wsNmFdD99YCqWyNtqoSvU7l8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQjj/SYPTOVN0oZxTdZUneuGTZSy43AxiaiHWaMHF+k=;
 b=SiK7plW551o2nvT19R3I9gvkWHaCMmdYfLKjGXEwKobOdFulAdL08gdDl7DL9haqe/aOBNww+S++hNy4OkColBz+Mu/QIMtePZF4qtYViheaq5Zv5TToahilBF/otMkoFtiy+1SHExCl7wK3VuspqAOovdZlfiAzBw19Pf9t/sk=
Received: from MWHPR14CA0071.namprd14.prod.outlook.com (2603:10b6:300:81::33)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 04:54:23 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::9f) by MWHPR14CA0071.outlook.office365.com
 (2603:10b6:300:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 04:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 04:54:22 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Mar 2021
 22:54:21 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 3 Mar 2021 22:54:20 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Date: Thu, 4 Mar 2021 12:54:13 +0800
Message-ID: <20210304045413.38603-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce5349c-f3bc-4b3b-7040-08d8dec99406
X-MS-TrafficTypeDiagnostic: BY5PR12MB4193:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4193CC9C79BFD8156B9F555EFE979@BY5PR12MB4193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtMSISrHpyhBMcsC3m/mYCrYPP574Er5elam01w6K76DPQG+8oOjuZExSRVqzeY33eBf8SS0aR+ykqC85PZbKOjmqlNEoEgrle8kq1BM6ZUGjgpJ3jGiv8uzF8ETeOS0EMxNIDDfukKlq8OcLE5QjyySN885Ar43RJaIXeJ44FCPerCQuCsX/imqdSaUwN+2dqOUmLm8E9McK2W6lmALJ8E8hura17/UIOfrKbXCWnRdmRuq1hF7gOYaiCBg0c24oGaMUTGn0jzo+7jXFDuBhFeM4EW7LcKvDvnuJwbShcgNuAZKXdYHN4yoTYuUnt+fZuzop6xXhM/k9GovHisK/7FT/yv6fmGesCy5IsoAfYRtoeupNLvzs+XLngnVBvdrRIGsWb4MbJp+tIO5YRFlULB0+7jB5chBgGF9uLb9Fxx0wA1fEpcyNWcMPLUntrHiO+bqXutckRr5OXX63ZAyjRD8wbR0/26goVfQP13OwrDSkhbrUrAwqGYWD1pj40HYazTlJZuZHhTylntFOQSfN3fBw2EUor+Tnf3WB2fpDN9vYhfDleAHDuHR4nSuHo+Iy+lJPKVme4qhUacybPPXYmt8GLAtla+QsqHJX+fnmTGFbC+1lUqTq/xM/CAybBetDQi+WTfgg3cz5oseAPSdEYg1VFu1NgVxquxTXEn64xz/oTFoirhb/ge/YdBHbLpmVoUyVg9Gi81eDmK/iTBGSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(426003)(5660300002)(6666004)(70586007)(70206006)(81166007)(4744005)(4326008)(2616005)(36860700001)(83380400001)(2906002)(186003)(478600001)(316002)(26005)(8676002)(7696005)(47076005)(86362001)(1076003)(8936002)(336012)(110136005)(36756003)(356005)(54906003)(82310400003)(82740400003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 04:54:22.4608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce5349c-f3bc-4b3b-7040-08d8dec99406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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
Cc: Alexander.Deucher@amd.com, Feifei Xu <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA 4_x asics share the same MGCG/MGLS setting.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3bede8a70d7e..0280e8f589d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2271,21 +2271,11 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
+	if (adev->asic_type >= CHIP_VEGA10) {
 		sdma_v4_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v4_0_update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		break;
-	default:
-		break;
 	}
 	return 0;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
