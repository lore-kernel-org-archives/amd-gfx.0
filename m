Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7765BC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 05:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0821420B1F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 05:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oiIJzLb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0821420B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4AE56E9D7;
	Wed, 14 Oct 2020 05:21:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8287E6E9D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 05:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDs3ydhRJe9vK/DzeUP0UAbwLSZZMAjZck9wbqfPtGdYonackAQgeZjxGp7vUXiUBxNTu1oP30FLh+fkQ4b0VtKqC0vSSfACinHHm5AtIm4a1VAI8J+uzizChTMYbrNrILKNsYA2RPleRyYAyq9BCVfjyPs4XoYCGINeG4SFwZq/pz3v92tqR5zDhXtZ1TvlApd4eLf8nSElOAcTrTnXEgQ9uniYM0xK0beS64hLl6dW9yJevJrEWCo6ZFHeYCIcb/beqx7rGmotR4lv2xo2NOflq72Yv69Kuh6Y+sWkcg5Znf1KRgcANeojfDpZnmvRqcKxAuET6H+pSpSea3zWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpENlDT9vsYAItOVonZY5B9DDK2fD/p+dh9OYvXkAjU=;
 b=WiSMeYfew+z8LdDJp54C4GzlkqmhYEbRKlAJlXmZbTvUlGGywTgC7QGP0iCKp9kaAtJ2Pr/hzyYcyd699U2XvygakuB7V8YVHpfYayRKOgi/Luh9xo539lhR9jjMfiqaR5OcT8S7B8OlhxmY6JAgefePvJR4ZjvO6ba721UsHpc/Odh1TG0wFe9cBkk+BHH3WJ3K6D4/dwkr2dsg8GhH4AhFjR8YciWnxcgAx99qJKiRleK22TtsezX7Gpm9588nl0o9IrY9dFYTlooLvk2s0WcQ5Xgzh8DsryaabyB9I6xcUeTldlXXq4P5ECnhYH7xdpsuibqa3a2quNAYwcm+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpENlDT9vsYAItOVonZY5B9DDK2fD/p+dh9OYvXkAjU=;
 b=oiIJzLb1G6HxlrPkhbkWjNzz1m/beUg2dmrHJY7OzpjBoob8aeMht9j4JWZMocIO8UTQdq3wcp3iS4DeoCI6CbqSHslIZfCVAnZiwtbUk7IXDXDbDpgqCB67eYqZXlMrxp1MbpQPFqs5LCTs/gb+t0szje1vhiJSJUQeDo8LDao=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Wed, 14 Oct 2020 05:20:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 05:20:59 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: populate Arcturus PCIE link state
Date: Wed, 14 Oct 2020 13:20:23 +0800
Message-Id: <20201014052023.7085-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014052023.7085-1-evan.quan@amd.com>
References: <20201014052023.7085-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.3 via Frontend Transport; Wed, 14 Oct 2020 05:20:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af3b8048-880a-42bd-09ea-08d87000ef8f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34683BD6ACDEC7A47FC6BD69E4050@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:29;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNuJX9ZHB4xUz6IyxJqqei7msIhzijDU7pJ0MJUlUe1sCRuGxkZ/C2dbJ3mLWS0mGK+PHuovY0E9g2pTZ7yHpHVm/mWyP4UQ1TKEmkzn5xJQeT2c0RbFGSZ1/BKJVxkTLUuae/fenGznBvOKTUJoGpcK50Qc0P3GTpgNALBqu64CH9gj2eCQh0e9CoXoL8dPmuqtlwyDCFgUseZNgs8Nq8ySeRrnoqbLesV+kzPCyT0Z23DGmFXhLU/N6UFIUEs0MdVT3gkXRO7vn9UR9+N3EJnRTPOK3NFkHYRtmFOF7xKCPEiW0nbdS+rCtFCeYFgh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(6666004)(4326008)(7696005)(52116002)(26005)(36756003)(8936002)(6916009)(8676002)(186003)(16526019)(66556008)(66476007)(66946007)(86362001)(478600001)(2906002)(316002)(44832011)(2616005)(1076003)(956004)(6486002)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HRoaWmgHbduJ1NosUBFlAyjAS0+AiNHKyQVjsD2RwePKSAnIjEI+uOzPUZu8N0bbAYLYZfzYyviSolmllP89FSShYwkzoMPHb+TtSZIdtKLUSAdZjp5lZW502p1K31Xoqn46PpDUrAPxm6Ocd41+j4tN+uH1T7TRagGqOG4BFfB1WelGIrrtzP7+7mpzN8Szrj4wI4QiKzKRKE1v6nHFNxM4YBY/JD/+gVivu/GLV5GBAvb6bHhloQNxuZR9nnPTH9Rf2b4P/YJDq7HzI7cbcsBYP0zFktNWLQeF4V6K1yfb9LrexJRK4NiyGm97HHIEXugyVcjGaWCUJbyHS7M/S3WLeHPdGXNU7mLPWtrA4IDU5/iHz+XIYJJ6QLn8vhMNy8EDNVgctduSDLMLOQFKVKPf4Jxhuju3cL/1OSxBKTTWVhQWo3dloVan5CAgX+ajw92NybJmD2MmZjNXbv3zCmmmmiZtSzEITEooNjNnIU/Q0UW9PzxOYdm7FXhX6OxkNnbjf4FwfCdAChm7a+SsJAzaQOUSGGcjvahRWDC9FbJ3TAfiH/YsyVzE+7WN0q+P6Sw01w9xtXJP49Jut0zKR7KVSPLMQjI4IleXLdWvi5uy8M3Y6qpFIoVP83nMUOKWjZW+9gS3/gtLzrz2I/itDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3b8048-880a-42bd-09ea-08d87000ef8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:20:59.7093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTNpD6XousfE5BxbDw7PV2BRnvENdVnGTuGKem2Up029O52XNZuEuXSeX9MAjoFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Populate current link speed, width and clock domain frequency.

Change-Id: Ic342fbd8f5e2495d212eaa4b85b4e146838e0525
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             |  3 ---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 46eea3f8f958..f87411cfa4da 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2124,9 +2124,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (asic_type < CHIP_VEGA20)
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-		if (asic_type == CHIP_ARCTURUS)
-			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
 		*states = ATTR_STATE_UNSUPPORTED;
 		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f982b9090d7b..46d950757230 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -720,6 +720,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	struct smu_11_0_dpm_table *single_dpm_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_11_0_dpm_context *dpm_context = NULL;
+	uint32_t gen_speed, lane_width;
 
 	if (amdgpu_ras_intr_triggered())
 		return snprintf(buf, PAGE_SIZE, "unavailable\n");
@@ -823,6 +824,23 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 				now) ? "*" : ""));
 		break;
 
+	case SMU_PCIE:
+		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
+		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
+		size += sprintf(buf + size, "0: %s %s %dMhz *\n",
+				(gen_speed == 0) ? "2.5GT/s," :
+				(gen_speed == 1) ? "5.0GT/s," :
+				(gen_speed == 2) ? "8.0GT/s," :
+				(gen_speed == 3) ? "16.0GT/s," : "",
+				(lane_width == 1) ? "x1" :
+				(lane_width == 2) ? "x2" :
+				(lane_width == 3) ? "x4" :
+				(lane_width == 4) ? "x8" :
+				(lane_width == 5) ? "x12" :
+				(lane_width == 6) ? "x16" : "",
+				smu->smu_table.boot_values.lclk / 100);
+		break;
+
 	default:
 		break;
 	}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
