Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF83C5519A
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 09:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D799F2071C
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 09:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mniH8OIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D799F2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC706E03B;
	Sun, 26 Apr 2020 09:17:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6843589F92
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 09:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k660efS3YAcpW+CxqcM+RBnID4IS0bih2WLyJVOcfxNesX7/pkKnkLkrpwYiQq2DFD7JwZkiR+s2QlP2GWa5tqgdzAPd8KfI297ZoLGjrIm1+XbJm24vO7VSIYy2NnHuwbV86gEcCrjzwHQZIr9ct51PFK7SZKw9cD61sHnXcNSaRTAiTc2wZvsmAEmJACIwOojLadVFR7OiCTzHbqrYCIYz8j77WS2EDViaPoOZBQGXi2qpAyyOfcRnrLDlzAStJQGqDjS58JiRl0aeXaBvX+6tbSoe2nla9FRggBp0hFbYn25yz8vtFowFXSV3CClZ5crIX12o6PoBuA/Rv5LnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaJ8YRLQXYngsIjZ/VyjwWqX4PqqXfMuoa402sq6Tx8=;
 b=kyRo03pcK7b+vVWZrawzGpLiA55y4W3qGegVuykx0jU5GkRHhMvxP5VjLbRZ2h8kvKVGCgdAifyV9lhBS6bJ83JUJgf2iBVbh2T3IqaxEi7PG4ZhPPLyTvO/6uYTszd2HKdNtvKkkejkXfHG/5keAXZ7CL6yDNmfCPCq/oDH6BFn7m5V7+K81g2za7hhsSey8Eu3+4OYEoTci9VDxTGzsBp2irjUTYXQtDKy5jEPJwqvWxGr45dEcmpMEYwKNURmduy1HSIdvhHskofbbb6fgWGrjIU+xSV7DRNDFd0gavQ0JFX+LVEWKemSIHISwlsTl5K8tDZeyYUQI0gJAshkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaJ8YRLQXYngsIjZ/VyjwWqX4PqqXfMuoa402sq6Tx8=;
 b=mniH8OIsHjGpa0wJDUD4TjKgKuGiwxh6LK5EbBmjrIteOvi8tBVJlUctZjSGQnvi9KacvUngkG5U2Z+UlxfJN/oXtsCBsfnvJk7MaktqGFKJ4I0D1UjhsUsKTrUSA7PlGswZqMFusxzUwBhVu9F76KRr1JqhmR0h4DQQgay1QhU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (10.168.168.136) by
 CY4PR12MB1941.namprd12.prod.outlook.com (10.175.59.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Sun, 26 Apr 2020 09:17:12 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 09:17:12 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, alexander.deucher@amd.com
Subject: [PATCH 1/2] drm/amdgpu: switch to SMN interface to operate RSMU index
 mode
Date: Sun, 26 Apr 2020 17:16:43 +0800
Message-Id: <20200426091644.26776-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426091644.26776-1-guchun.chen@amd.com>
References: <20200426091644.26776-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Sun, 26 Apr 2020 09:17:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50b64abb-2ccd-4abe-fbc6-08d7e9c29a6b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1941:|CY4PR12MB1941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1941ED57A5D1AD1D817FAD4DF1AE0@CY4PR12MB1941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(8676002)(66946007)(6486002)(26005)(81156014)(86362001)(8936002)(7696005)(52116002)(6666004)(36756003)(316002)(1076003)(478600001)(2616005)(44832011)(186003)(4326008)(66476007)(66556008)(2906002)(6636002)(956004)(16526019)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOYoisLTdIF1hzMp5WC1yaxyNNE1IzBTBOMSd4rMk0ux7TEIODWUBlj1LnVyq9CpyX1PQYLoRUggtCOcqpxfpXwk1HLkm7yPAKBIGy0WIZ3zACRVwHHC0qXHi2DHu7+97P6Vsoz9oGClrkNacdKj6MiaKccc1wTZvEylEJTuJcCXB7uENwpitvqvsIkLwUT2JFogolsh7RHF3DWAA8uhS5ASNmNejXUEE8E7ozfL2EdCpK6Xxs7lI8NON/R4T9Ah+MOANQMrICHCA5b535kyDpVguAVjFbtbeq2j0qGQtaCFC38FRmOVeWX2OpGX/USjS8YiiFQ8W8p56kbN2IDyF89qQfwSjLoGrAfmxayi24wGlUtDavHKouIA6bbiJ9S3u8t+ccsV7SoMNMCWPHLV45jq8L2V2HkqZXIprpPE4/9JX8o12nRYbyHyf42XXEst
X-MS-Exchange-AntiSpam-MessageData: ZBObSvJF4xeIQjUNuwSaKeNkK1BHSLVdGYhDmxjPVlSKajRVQWR8Tfz1XPvrgqo7bk/T7CNMKSn0HmQH9aB13PX6uu2MGonhlXJ5c9uerQrScRWKczNBJ8zWi0VvRxkhwdCiaaZ1JLeFs3SOFn/NWxpGiT7kx1d0DX7M5G8jsx0D/83NGqqqXUpeQ9fzigRFq5jhdw6jw8TvSJVfwfS6ogS2R5merFzdwcI4dagLFJ9Iv6B1wJCYCvCyFBNDWo303R+4cnIwiMw6VO9T+woDhp4fPKHVW/oSfDepRQPC/GJ+Sx9kTQEvKuCPa0hVS2GyV1R9ecaSiPCD7ARvZ+CLv3YHxvkErCpoacf0JV3kmoWWXzi7Yt1f9tFJhrBl3ySN6UIZKEYn3fcn27rGXlctfwz3KA+X9z+/t+Di8nt5B5Mitp//FSuiVWAOtrD6KUTGmQkvS99lnIZOJRjCl8Adv3WqEXrF6pVvsBe9E5GGIe7p7Gh10jha3vzmbivS3Xz9fiJiQ96FEX++a0WP8Xoyy+M5VHXyefqy8U/CYLYcGfyLHBUaTmlKYlbHYwfVvXTbBf3Ik3oXyHcslvrS4/3gWpGLToZSwvLiKAtTiI/eeuOPnyc+0u2zoydaob8OAYuFNUtzOEPJno9C1Z8ecNX09UGj1QJCch13bJRb8aaclydo4985+tgothLlv1lFH/Qd5sGV6yySGvHkj0cGxso7+W+Q6Lb8WwAq5ENg3EOrrtNSRe1m9A9fuUP+08FqkykZp91dTfJFCsciWRGG/WndkNk/Y5snOG+YrdGDyXfzj/U=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b64abb-2ccd-4abe-fbc6-08d7e9c29a6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 09:17:12.1938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMMhwVtUqmuUJd889itLLYtyq0w0zAMwVEIKyKm1dxQbbncHrL3ns1vUjiR2Cu74CLOkQ9v6D906M1r/Y261wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1941
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
Cc: Candice.Li@amd.com, Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This makes consistent of regsiter access in this module.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 29 ++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 616eac76eaa7..6d767970b2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -56,24 +56,43 @@ const uint32_t
 
 static void umc_v6_1_enable_umc_index_mode(struct amdgpu_device *adev)
 {
-	WREG32_FIELD15(RSMU, 0, RSMU_UMC_INDEX_REGISTER_NBIF_VG20_GPU,
+	uint32_t rsmu_umc_addr, rsmu_umc_val;
+
+	rsmu_umc_addr = SOC15_REG_OFFSET(RSMU, 0,
+			mmRSMU_UMC_INDEX_REGISTER_NBIF_VG20_GPU);
+	rsmu_umc_val = RREG32_PCIE(rsmu_umc_addr * 4);
+
+	rsmu_umc_val = REG_SET_FIELD(rsmu_umc_val,
+			RSMU_UMC_INDEX_REGISTER_NBIF_VG20_GPU,
 			RSMU_UMC_INDEX_MODE_EN, 1);
+
+	WREG32_PCIE(rsmu_umc_addr * 4, rsmu_umc_val);
 }
 
 static void umc_v6_1_disable_umc_index_mode(struct amdgpu_device *adev)
 {
-	WREG32_FIELD15(RSMU, 0, RSMU_UMC_INDEX_REGISTER_NBIF_VG20_GPU,
+	uint32_t rsmu_umc_addr, rsmu_umc_val;
+
+	rsmu_umc_addr = SOC15_REG_OFFSET(RSMU, 0,
+			mmRSMU_UMC_INDEX_REGISTER_NBIF_VG20_GPU);
+	rsmu_umc_val = RREG32_PCIE(rsmu_umc_addr * 4);
+
+	rsmu_umc_val = REG_SET_FIELD(rsmu_umc_val,
+			RSMU_UMC_INDEX_REGISTER_NBIF_VG20_GPU,
 			RSMU_UMC_INDEX_MODE_EN, 0);
+
+	WREG32_PCIE(rsmu_umc_addr * 4, rsmu_umc_val);
 }
 
 static uint32_t umc_v6_1_get_umc_index_mode_state(struct amdgpu_device *adev)
 {
-	uint32_t rsmu_umc_index;
+	uint32_t rsmu_umc_addr, rsmu_umc_val;
 
-	rsmu_umc_index = RREG32_SOC15(RSMU, 0,
+	rsmu_umc_addr = SOC15_REG_OFFSET(RSMU, 0,
 			mmRSMU_UMC_INDEX_REGISTER_NBIF_VG20_GPU);
+	rsmu_umc_val = RREG32_PCIE(rsmu_umc_addr * 4);
 
-	return REG_GET_FIELD(rsmu_umc_index,
+	return REG_GET_FIELD(rsmu_umc_val,
 			RSMU_UMC_INDEX_REGISTER_NBIF_VG20_GPU,
 			RSMU_UMC_INDEX_MODE_EN);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
