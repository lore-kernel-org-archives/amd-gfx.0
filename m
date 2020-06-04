Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0198C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54F62072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wjsXRojM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54F62072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F9B6E1A4;
	Thu,  4 Jun 2020 04:47:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE316E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSjA334KGgXAS/GJYln/eyFfW0LDoJAFXAGkTQN5hb2xbnJ23ex7SRfFnBxm3sTtx1nTbVhtq3ut3KCLiRqmrCaksJYhZ1WZYPdxcCGelJmw8K9YPJzE1CZGFz8sMkt2Xp7S3dgXE5yHGs9nCYQkRmq3XTxWCKAXnyQIC0cax0gcQmRkHTDR9UNapbIbPyU1+40chQ8iOOjLSkPOEcXaXUE5ZWfE2AeY6lL5KFegg6jDAzksHyr/15Vm/ed5kYO0+ApuuFr031RqFmhPBgNgPw/G6zcNwKsGVMDwc2G8AqvHuBSxDsN13ptZz6yQmSLh6dG312762Opiv3YeUireug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aie5Ft8FBfGvMubxluXG2AI9hVg6LvLE547ha8GdD8=;
 b=akh0K/2MM9kGBZJm71zSo8K9GwbdcpXeRG9kkWBzXtNlcFTZT1ScWdKHBh6C7k+uonMuu3WYW8AYd7RYPu/YDXpxQF1javOGi95AEOH5+HpoAqu6QfjxXxKKjw2E1DTdlnJwmUrarrq5jtaCHviDGbLqPZLmhLz9uNmz7eFdHYqVBDROIXJV7rEags+nuIjXb/74C3PqaOBfD4outO96/zU5DTF+XA8xCJNxJ7Vb4Kwf3XGRtwL/vAAOzg9J0+uq/HQLBzxUZ6t0MZ7gkuZsuDcVqGt85cpWWZDqVA/BuB19jVzJzGgvg+OU9AHMdMeWZUDXdyyVgyquDUMjkilu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aie5Ft8FBfGvMubxluXG2AI9hVg6LvLE547ha8GdD8=;
 b=wjsXRojMs0z7O3z4uRHqGL1HKCCLkYbcw7U6JoDhrIpgOfUj8XH7vK0kuAr5mLQj83HFoO8lWdpTXG7I+nTjfpHYT5TeKOFvzfBfJEgbXbsR5vLPGoK5lYsZCHww/EAeZjihGxLl+a+kIG7XXbXjxlBwpSKt0tMfjEzfkM8zWbY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 04:47:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/16] drm/amd/powerplay: skip BACO feature on DPMs disablement
Date: Thu,  4 Jun 2020 12:46:19 +0800
Message-Id: <20200604044619.18658-16-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:18 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 615b2cde-1093-48a1-ff07-08d808425d28
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212439389E29BC746906BCDE4890@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoTboWREpkzJIYdNy9aS6ITMCTXKxgdoZCsIKRrL1bwu5K9MQRblT8xhaBeSfWqSxb4yZ+JlO++iPNFMsFbU+hfReolCUdJUj/+1qpiUFB3uV+GahWmyAHq1FDgeoloByPe6WIdaa9k36U6bsNI1xjPsnkcBRHMUZaGJqUqbtoq0JGC28ub+nQa8+Geq88vvKNg78ZA+Xk3+Y5Fr+eagqpD9TTiOpx0mC/ijd6yOIkdHfWjUzU/eTpoWBVe+hcEnXIzVy0F6fanHZ9aBBMyfj6Yz9ShbPodVZdFJwyuGRC+SK3uuVVB829YmJSgw8L3vEMblZS8g3YIA2r4VSDCk4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(8936002)(8676002)(316002)(2906002)(6916009)(956004)(186003)(66556008)(1076003)(6486002)(16526019)(478600001)(52116002)(7696005)(4326008)(83380400001)(36756003)(2616005)(66476007)(66946007)(5660300002)(86362001)(26005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 93gLPIkn3Ue55ZLVGMWwKMykKRXurxAfMraXjBAYgnxrhqtfpSOD5Pby5Nj5gcRa/4UzkYm39lchKfPgERCq1KgWAXLUlra7C379vdf44vq1ldfR2iXFk8oJvTkf0zNGOjP65x0MSI95Zo7o2e43lCXGtFCRg/NeEDuaokqHoTcDZLZsdlm+J7TRd4CcbdISQcRECMduDBq5GeXs9W4Vuip0PfyAbFsESXd/EWjJy3rkIFBfelo+L3X20L53DlQg4SOPXXcaKsw5/kqleKkZpH80DSA8GKMGt2+82+Ua7Ib8mE4MqgjOg4j8YSpJXyWsuV2DHhJWm/VAacTIW3dzG3Yxy2xAcGuMvrUmj1GpFmYN6y0+oJfVWXdixzgLgV2Q0qWBrhmIL4tvJ5ZEWnXnkdvu0tjBk80rVbugU6esAzbNIyAu1nNnnV4IZfN2eYk1hlNwxjAaNLlxu1Udon/NNieEBRRn52fussaf1kP9MJOpnQ7Le1VgfDR8DqFMJLTP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615b2cde-1093-48a1-ff07-08d808425d28
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:19.8275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCqAkwXR9PyoQ0Pb+JPh6FHvlMhtPxQn5j2IcIH2FyHuYMSIbO94pSezvWAJjebw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

Instead of disabling and reenabling it later.

Change-Id: I90775202178f3b7695f42f39ce240bbfd51a1346
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 72 ++++++++++------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d9a9d9723be1..b645bba1d201 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -110,28 +110,32 @@ static int smu_feature_update_enable_state(struct smu_context *smu,
 					   bool enabled)
 {
 	struct smu_feature *feature = &smu->smu_feature;
-	uint32_t feature_low = 0, feature_high = 0;
 	int ret = 0;
 
-	feature_low = (feature_mask >> 0 ) & 0xffffffff;
-	feature_high = (feature_mask >> 32) & 0xffffffff;
-
 	if (enabled) {
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeaturesLow,
-						  feature_low, NULL);
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_EnableSmuFeaturesLow,
+						  lower_32_bits(feature_mask),
+						  NULL);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeaturesHigh,
-						  feature_high, NULL);
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_EnableSmuFeaturesHigh,
+						  upper_32_bits(feature_mask),
+						  NULL);
 		if (ret)
 			return ret;
 	} else {
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeaturesLow,
-						  feature_low, NULL);
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_DisableSmuFeaturesLow,
+						  lower_32_bits(feature_mask),
+						  NULL);
 		if (ret)
 			return ret;
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeaturesHigh,
-						  feature_high, NULL);
+		ret = smu_send_smc_msg_with_param(smu,
+						  SMU_MSG_DisableSmuFeaturesHigh,
+						  upper_32_bits(feature_mask),
+						  NULL);
 		if (ret)
 			return ret;
 	}
@@ -1305,6 +1309,7 @@ static int smu_hw_init(void *handle)
 static int smu_disable_dpms(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	uint64_t features_to_disable;
 	int ret = 0;
 	bool use_baco = !smu->is_apu &&
 		((adev->in_gpu_reset &&
@@ -1336,36 +1341,21 @@ static int smu_disable_dpms(struct smu_context *smu)
 		return 0;
 
 	/*
-	 * Disable all enabled SMU features.
-	 * This should be handled in SMU FW, as a backup
-	 * driver can issue call to SMU FW until sequence
-	 * in SMU FW is operational.
-	 */
-	ret = smu_system_features_control(smu, false);
-	if (ret) {
-		pr_err("Failed to disable smu features.\n");
-		return ret;
-	}
-
-	/*
-	 * For baco, need to leave BACO feature enabled
-	 *
-	 * Correct the way for checking whether SMU_FEATURE_BACO_BIT
-	 * is supported.
-	 *
-	 * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
-	 * always return false as the 'smu_system_features_control(smu, false)'
-	 * was just issued above which disabled all SMU features.
-	 *
-	 * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
-	 * now for the checking.
+	 * For gpu reset, runpm and hibernation through BACO,
+	 * BACO feature has to be kept enabled.
 	 */
-	if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
-		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
-		if (ret) {
-			pr_warn("set BACO feature enabled failed, return %d\n", ret);
-			return ret;
-		}
+	if (use_baco && smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)) {
+		features_to_disable = U64_MAX &
+			~(1ULL << smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT));
+		ret = smu_feature_update_enable_state(smu,
+						      features_to_disable,
+						      0);
+		if (ret)
+			pr_err("Failed to disable smu features except BACO.\n");
+	} else {
+		ret = smu_system_features_control(smu, false);
+		if (ret)
+			pr_err("Failed to disable smu features.\n");
 	}
 
 	if (adev->asic_type >= CHIP_NAVI10 &&
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
