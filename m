Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD34C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8401B61C64
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8401B61C64
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212A36EDC8;
	Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9DF6EDC1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMCNVqNYqszL4R4pSehfGzk1qXPnpXxQHX0QdL8J1cxCEauNdHozhVjJXk31ALh0EQgLS6uLfGQKHSJakMsCxTAwGR9AcLyQ1R4MpbZeWWm80Llv3i3L+SJ7ioPNiYHTjPZfbK2ZAbUouzRA0tSnQoiicQrL44tPmfbM/JR/uxa/UEZTyquiVODFAe9tZma8K1TUicDMQayQ6xN5kuIC5m+iKZXIG6aKBKOQMKpofJYp/OQbVb/YUp53Vf9BlaCKQwcBzWDKLbGqmhSUrFqC8+y6+39Ysu+DcPUvd4m0nA6KJacMTs/2FlY297ZxkLrrgwsF9RKYyiiBqze1bjHvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UidwtA6rmJ/1H1zkDBANKA3ZU1ywArOsI+Xj3O/69c0=;
 b=Xv81VqLgXVnHs1TO2VAjVfUFIALvbWiSBplF9kKBi6cFgc/SqpU0RFU57kRCAhUDfOMKE+sDBRuQgmHqoBERlpV+EJkWH9ec17QQGPyzKg8T8hUPln2iG3ncBDVEX07ikMuMaWoU+TwLgwPit6UOokT/BvMekS4buTZiLdwErynHvV3cc5wB8t+DsX4kTvk2P8Ftqh+Z2wtELrjUvH19Gk4A/asUE3aQsON4TDitwFmxpOBYYL/pPlLzS4BDlpME+EtdSv7nLxenFUdbMCjGgWrp/Tr9yDQ8HSVUEekP6blHKqKLf+6h0UkbPDPyWt3fd+qvd2QnLgJXPlqk8q/jkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UidwtA6rmJ/1H1zkDBANKA3ZU1ywArOsI+Xj3O/69c0=;
 b=O1NafDh5erYrJxgs2EBouIwsvVNGTwHnq7s4maeLp3WUdGWLR7oiC4V0LqUTzHYiz7u2Fm4uHwLq8LVQkYKh1B24IYiOuxHHU+IgXHPZYDALmpmITI+FJr4zw9HNeoxO8m3HqZhPopRmqat48LBBARdeO1t5JSisCf+LQyYf3+g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:13 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 63/89] drm/amdgpu: add gpu harvest support for yellow carp (v2)
Date: Wed,  2 Jun 2021 12:48:42 -0400
Message-Id: <20210602164908.2848791-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27041e03-a02e-42c4-5310-08d925e67c63
X-MS-TrafficTypeDiagnostic: BL0PR12MB2369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB236958457982D5E0A8E7C093F73D9@BL0PR12MB2369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YO91ZzcV6Y/rwecjPF/XQDTXdhI+YCu1zfMQhox7eyuBxKPZ0FFpYDiIBa+hYufbP8TZ3l1c9iqgXueGmqABrMASxZNVzgitnuSYwON2zJ9ajn2ajhquqV+2Nmx8d2yAcu2NPUkZxij4JKPTx5tmMQL6ZhNiGiOWPWU+QyPj7efU+dcbC3y28Xuqg4xLHngTHSxNX10k1LXuQ876ioW6XfbMW552vKux7OEmAWQ7ZaevJfU/kipIc9cNOmHWfXVuZ58vZSSuD2VigI/ViL1i9byBS5WaRqRyEpnsdld7nQfQk9fjAHfZ4XGhgK6B8wtzSLN3kMxliZ1Ml0STHLamEdkc9YHHk4opa5b4Xg4B6yMwyuWI44iQEOhCfYkb7wOJV1Buxtvs5rQaO6J4G7LDZazaMUZAUZCqqdUKphXS7uPkZwKg9wYP9WWiHJtjlrw/lH7aBatl0dkKeWWsRcfHcLXSNutb8fD1MCRCqDAAyzYdAx9dfCeKbjgX/O+okAFWitW2nYYW+qKiUtqFzKQuQut90keNkRsANjTTx05crJgEoYdgt0kmdE987JbxU9hkGiH2xhjG/SaEOM1Wm3yUOudOhzmMD3Ocmyd1PYG6rS4c5ZMv58oKPxL/K2H0kT7MfJwaLYa4JDoO4xg6mCAqxUp4+iukRazeyyPNHVeEXzEt33sawaa4jQ8h3xg95uoE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(366004)(396003)(54906003)(1076003)(8676002)(6916009)(956004)(2616005)(478600001)(6512007)(6486002)(86362001)(6506007)(4326008)(6666004)(38100700002)(316002)(38350700002)(52116002)(26005)(186003)(5660300002)(66476007)(66946007)(8936002)(83380400001)(36756003)(66556008)(16526019)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7S5DWG2Add4WcfrLRnI7QQuU1mo4wJoNe2e/eL9FHRceSmbvLfAbSEfJMRWl?=
 =?us-ascii?Q?oT4W9SWyV/nntwljC9XknRa9Bh/DsZbq3fZWz6rqTVc1xc310p3FjpsurrSd?=
 =?us-ascii?Q?TVSwyla0b/f6NGVJsZOV7R7dtK6xIn3L4tCFb5pV/sPR9afmqEkW4LxfFjzu?=
 =?us-ascii?Q?NQ1CsyAAInGKvqGVRXfF5zlX3JfvVuGY2HwwRq7PMgiFNLaSvJj0ReshLJsN?=
 =?us-ascii?Q?zy7ZWnrvSJx6ktBBakwPQHJJ9tUBIEJj13uZnUJjllUe7hcLu6NbD+cnaILB?=
 =?us-ascii?Q?A/BKNPzHg/U18FlKKf0D6otPjnC2AQY9lUyISZFe+2mof07aTnwdJfW8I3N4?=
 =?us-ascii?Q?hXGZPsSN1/4pLQ/t5FI9m2qBaGztmJLFQqGIoDaMEIBnIExyybxAQvmkmo44?=
 =?us-ascii?Q?xLFtsehiMS0P8jt6kMPrgbmG9yNpS7O6qihB42OpWL+4bNiV38hJSj6ylnC9?=
 =?us-ascii?Q?VBDwCvDyO5pSgiiRuH0tLSLFOcx1ML1V7oHxjQS8wfI9xvKa5TXE6Dd3PZXm?=
 =?us-ascii?Q?nbxMxy75GH1Gy/lY5S11LRTSSKaj3tUZJzn+pI3gMoKYbRdWBF7kBpbZizGW?=
 =?us-ascii?Q?Wn41pDccsMBZpHehQmzJkaxXL0a2HQAX5LU+v3Y9skdbjGISXN2prLIpAg0Q?=
 =?us-ascii?Q?8TWHh+MoRbV/R74KeTpHQj8usRShqUhh1gmcLFC59Dw44cMyaceEpHRl3fOx?=
 =?us-ascii?Q?enOJIGA4Zo+cGezyC0JzsHNQarH4OvBRE/utwBmYZ7mh/Hn9gAQP3OdBjK97?=
 =?us-ascii?Q?oCy4xAYeIzyNpjt6I2IFBCZ+wExVlk46hquLChVfIBA6/KzyCiy72PsiqYLA?=
 =?us-ascii?Q?bKJ4B0oZshnQd+eDSPbK2giSNIAS8iBLsS+eWMxprhcgECr618pJ3fvJycJd?=
 =?us-ascii?Q?52WzfUEQGOoYMqnnFtuh0teKOSgZp4gYfYEiFjrEqusKgLcfwUXXkTgmB5pW?=
 =?us-ascii?Q?KqXpQpTw++SBy9t+S7KfacEVMFy0QTQ4lafZA8h7rWa+5wlhXxUDasELFiRv?=
 =?us-ascii?Q?XsiD7+7Nh5vJvO/a23KeY0nRAFaV0B2vP5iD2prnzVKlYvW2MZYlHQh+A1Vx?=
 =?us-ascii?Q?jAEerNvVUI5Mcm1C/Fhc9X4GUMBK5JQ0G7DjMgD/glmX1vEgGGqm1iU5lXYq?=
 =?us-ascii?Q?xOLYZi9ttviUOAYMmvc594ZDdDzWmnW5+j77xqavQjJwrcVvPUqQMmzbvBG7?=
 =?us-ascii?Q?TofAP273Uu8778g/qJFYWHmDOar2MUc64TC399eAt5ijtbgy70mmjBMuiKyo?=
 =?us-ascii?Q?arw/NZLUekghGl1nBvRQeOZ2kxaVEOZEqnCB4cAnbbqDdEG2peA/nkic1ohC?=
 =?us-ascii?Q?Z1wHL/WFLyB8RngiTxcF3Rdk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27041e03-a02e-42c4-5310-08d925e67c63
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:11.0968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts0OUAdsL10mqgN6IBlwMAuTzKiktzybmYzhIxmfc0EamDImYu0EOLJslGAQ7ij0nnGYERS99j2P3ngul7oAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Register callback in gfxhub functions to program the bypass groups in
gc_utcl2 corresponding to harvested SA.

v2: update comments (Alex)

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c   | 40 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  7 ++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index 66ebc2e3b2ad..beabab515836 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -34,6 +34,7 @@ struct amdgpu_gfxhub_funcs {
 	void (*set_fault_enable_default)(struct amdgpu_device *adev, bool value);
 	void (*init)(struct amdgpu_device *adev);
 	int (*get_xgmi_info)(struct amdgpu_device *adev);
+	void (*utcl2_harvest)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_gfxhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 41807817de7d..1a374ec0514a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -31,6 +31,9 @@
 
 #include "soc15_common.h"
 
+#define mmGCUTCL2_HARVEST_BYPASS_GROUPS_YELLOW_CARP				0x16f8
+#define mmGCUTCL2_HARVEST_BYPASS_GROUPS_YELLOW_CARP_BASE_IDX	0
+
 static const char *gfxhub_client_ids[] = {
 	"CB/DB",
 	"Reserved",
@@ -531,6 +534,42 @@ static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
+{
+	int i;
+	u32 tmp = 0, disabled_sa = 0;
+	u32 efuse_setting, vbios_setting;
+
+	u32 max_sa_mask = amdgpu_gfx_create_bitmask(
+		adev->gfx.config.max_sh_per_se *
+		adev->gfx.config.max_shader_engines);
+
+	if (adev->asic_type == CHIP_YELLOW_CARP) {
+		/* Get SA disabled bitmap from eFuse setting */
+		efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SA_UNIT_DISABLE);
+		efuse_setting &= CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK;
+		efuse_setting >>= CC_GC_SA_UNIT_DISABLE__SA_DISABLE__SHIFT;
+
+		/* Get SA disabled bitmap from VBIOS setting */
+		vbios_setting = RREG32_SOC15(GC, 0, mmGC_USER_SA_UNIT_DISABLE);
+		vbios_setting &= GC_USER_SA_UNIT_DISABLE__SA_DISABLE_MASK;
+		vbios_setting >>= GC_USER_SA_UNIT_DISABLE__SA_DISABLE__SHIFT;
+
+		disabled_sa |= efuse_setting | vbios_setting;
+		/* Make sure not to report harvested SAs beyond the max SA count */
+		disabled_sa &= max_sa_mask;
+
+		for (i = 0; disabled_sa > 0; i++) {
+			if (disabled_sa & 1)
+				tmp |= 0x3 << (i * 2);
+			disabled_sa >>= 1;
+		}
+		disabled_sa = tmp;
+
+		WREG32_SOC15(GC, 0, mmGCUTCL2_HARVEST_BYPASS_GROUPS_YELLOW_CARP, disabled_sa);
+	}
+}
+
 const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.get_fb_location = gfxhub_v2_1_get_fb_location,
 	.get_mc_fb_offset = gfxhub_v2_1_get_mc_fb_offset,
@@ -540,4 +579,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.set_fault_enable_default = gfxhub_v2_1_set_fault_enable_default,
 	.init = gfxhub_v2_1_init,
 	.get_xgmi_info = gfxhub_v2_1_get_xgmi_info,
+	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 716d2849ca16..a3dc730eca4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1060,6 +1060,13 @@ static int gmc_v10_0_hw_init(void *handle)
 	/* The sequence of these two function calls matters.*/
 	gmc_v10_0_init_golden_registers(adev);
 
+	/*
+	 * harvestable groups in gc_utcl2 need to be programmed before any GFX block
+	 * register setup within GMC, or else system hang when harvesting SA.
+	 */
+	if (adev->gfxhub.funcs && adev->gfxhub.funcs->utcl2_harvest)
+		adev->gfxhub.funcs->utcl2_harvest(adev);
+
 	r = gmc_v10_0_gart_enable(adev);
 	if (r)
 		return r;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
