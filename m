Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA665C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99F420760
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pPRcPoN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99F420760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9AA6EAB5;
	Thu,  2 Jul 2020 09:45:26 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760080.outbound.protection.outlook.com [40.107.76.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9363D6EAB5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEmVHSfGapjdkmlrntzOx5wgw2GU+NhJ+85+Knlk/umy+qLjbkwOy65QGAWb2Ii7eMlPO6pMAQ7nu1ZT0vzxJw2q4OSrsQXPqpZNfmZ0Q1MoqVNK/GyvKQsBQxc+8hHLxcg1W7jnwIsN/diTkDz/ZlY9yP+xnyKA7xJ8XTZ2FGZa/kOnX4UTibbO2a9cV5/3ouBe6gPB9kZfUjVNhzmeQuftNhCRiwupcAeza/Z+rLxymGBtIpc9GlX20dKL0xWFsDO1cWBNTcbbQoc8fvid9ePfQIGNygJoOa451FQevGHWmIHPaPZxOFjJY2HbEJRQlrLEZdDdU2StqjVCesvCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3t8FKCCtBFyUM0y67eo5yde7NUwF354kGHccF4CDeY=;
 b=R5W8gS/3O/JaoHFV3MJC1j2SfvLTxBkNjJwe+GZA0gq+cSz4o0mVYIU690CCqph36S4nS/N3tTCk4C6KNySrSg3EOrbnoDPh0HK/RfG4ht+ycsx2BOgB5mgkdSNa5Nd+o0zCFAx+Z5SEOlWC+SgZLQAEqG4WD0MLmHYM56fjPqt3yu9RPv92YmeonU3xbUYF5XSsTnfGayL/bgQP2+7otisNzRkHrqBh+/qEnZZ2CxZ54EMg4oZQW2DPCgzJT/+9hqrLcKNu+MOBsq8yBm1KHgC7k3KjC6swQwdzLJGeGMKXUTNsI784CRaBkdacGqMZiGAxKO9K91v/MOPw30kXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3t8FKCCtBFyUM0y67eo5yde7NUwF354kGHccF4CDeY=;
 b=pPRcPoN2lS0wqtSrC6wdAMNj1uFKja1RPaPM0MO7Es1j4Uec1lsjqXmiPCoqUmJ2MS5S0HPN7BK8pIf9QJf4SehbSn359Dwn+dQ1+i/Nis74po1e2dpz+p5crNtxcQfDO+9HG1jPTWl4OQH8If+wWE4feQlCOCiScp6VPtIOOPc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 09:45:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:45:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/powerplay: unshare the code for retrieving
 current clock frequency
Date: Thu,  2 Jul 2020 17:44:46 +0800
Message-Id: <20200702094447.8158-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702094447.8158-1-evan.quan@amd.com>
References: <20200702094447.8158-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0186.apcprd02.prod.outlook.com (2603:1096:201:21::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 09:45:17 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 739da847-8fba-4516-5eb9-08d81e6ca17f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0219312A0AE1F1E822220DC2E46D0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3c55SMZ42O4bTfNBu7TfXskfkXKdp8UU5TSa69DQAVhnNUYV3YMI/MnlnwtJm4ujIsiqhA9cQl+uhdsn9VR4D+9IhekK27VAfYALB3qsU1k6Lus62Iwhe44OtMSsSFgcPsu2bdn3+PsaY1hrp7L42Yn5d8tSZmlia6USkw5jgEbcpKVO9efQ48JnfAlWwhHXhInN9HrxJkAzj8U0PSHb8zrx7PWd+lXhf8R/qUIYO3FMkZNLjR3I2KTqZHc+WTzHBpi8kQfubPqCBgegnk85shHTD/EkLz2vP9cNvjdp2bdPo2Cgg33NZLsydhadzSQm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(7696005)(52116002)(5660300002)(83380400001)(26005)(8676002)(186003)(16526019)(86362001)(6916009)(2616005)(316002)(6486002)(36756003)(956004)(8936002)(66556008)(66476007)(2906002)(66946007)(1076003)(44832011)(6666004)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: p3ud1LNw41CgCZ9mebrlgn1+Cep24izaBzL+bq/pe0i4+xh7PhsQtxosO4Qpv4HcRDwaWJq6NHmRi3+ABggk+ASPnvDfDeNYdxwnJC1RNlPRvnsMWxng04kBsXuRIM8YjUYIyjRwuC6A6uhxi/L0/McPtoXY9Y+awtu88KVgi7ch8MM6auqwAcp98a+Bup4a9gb7cawL6FkNrK1BwEkMJqSt3GB8KeqGMrtCi8OW+0A1U/JXG+lmqhStov66/2KAT2faMmUKQ2adsXCK3296S9OUCw6iQMAMzAchS158TIgheNWBtGHrQtZC7+pNka1mob/fI5qc6zqd74Yj0fdr8pV2zrJoPf6o51GxG6fgFOcRI6RaKwk8uCbgkMYHNysMhhKhee6XfVReimn125wGoK88VKrr+YDnYCEgbiPwZe+bWKESl0nwkL8DvUUW/9a0h6mjdGHmu269c20v9bcUVNkEFtsCrXqqo8ij8vXpYPD2e1+Ers45QWsZKxLHObjH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739da847-8fba-4516-5eb9-08d81e6ca17f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:45:19.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ExvuKz44WjJLWvHo/vAmSGvUctrrofxOXQxtpNAMnqrWH044tw2oy+pVT3WS2Ql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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

By moving them into asic specific file. Since they are really ASIC
specific.

Change-Id: I932369d5c2033ab8567d26bebcac053a500227f0
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 11 +++++++++++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 10 ++++++++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  8 --------
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |  8 --------
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index ae4bc56ec320..2e04ac1d8ff9 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1201,6 +1201,17 @@ static int arcturus_read_sensor(struct smu_context *smu,
 						(uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		/* the output clock frequency in 10K unit */
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
 	default:
 		ret = smu_v11_0_read_sensor(smu, sensor, data, size);
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 87f110b16e55..3dab6f0e9578 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1697,6 +1697,16 @@ static int navi10_read_sensor(struct smu_context *smu,
 		ret = navi10_thermal_get_temperature(smu, sensor, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = navi10_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = navi10_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
 	default:
 		ret = smu_v11_0_read_sensor(smu, sensor, data, size);
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index a52d562addc2..d77e6de95b18 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -896,6 +896,16 @@ static int renoir_read_sensor(struct smu_context *smu,
 		ret = renoir_get_gpu_temperature(smu, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = renoir_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = renoir_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
 	default:
 		ret = smu_v12_0_read_sensor(smu, sensor, data, size);
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index ad338984d6c0..e6e9583b1180 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1500,6 +1500,16 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		ret = sienna_cichlid_thermal_get_temperature(smu, sensor, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
 	default:
 		ret = smu_v11_0_read_sensor(smu, sensor, data, size);
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 4e913fb4ac5d..952e21234929 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1182,14 +1182,6 @@ int smu_v11_0_read_sensor(struct smu_context *smu,
 		return -EINVAL;
 
 	switch (sensor) {
-	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = smu_v11_0_get_current_clk_freq(smu, SMU_UCLK, (uint32_t *)data);
-		*size = 4;
-		break;
-	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = smu_v11_0_get_current_clk_freq(smu, SMU_GFXCLK, (uint32_t *)data);
-		*size = 4;
-		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
 		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 1d7caaf57b70..4fb3f4984206 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -213,14 +213,6 @@ int smu_v12_0_read_sensor(struct smu_context *smu,
 		return -EINVAL;
 
 	switch (sensor) {
-	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = smu_v12_0_get_current_clk_freq(smu, SMU_UCLK, (uint32_t *)data);
-		*size = 4;
-		break;
-	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = smu_v12_0_get_current_clk_freq(smu, SMU_GFXCLK, (uint32_t *)data);
-		*size = 4;
-		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
