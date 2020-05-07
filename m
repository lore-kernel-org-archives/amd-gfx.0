Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B0C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514BF20870
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HqvrmT0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514BF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC166E0DB;
	Thu,  7 May 2020 09:59:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A406E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 09:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA5o6XhQZku/k04cEhLviyIiAtUOWHS/ejgwaK4c4rvLlNv78cU9ZM/qYm+FTC7pp95lb27tDuKj1Kwv2Kg4bxd4KQTQqc5d/4i3jM8Vi0RsqW5gjGVFwtC74CelB2xV7+ku3FS+4TZ4uo2oLO07WHAp3iDzjQwCr9WeE5e65QnaGMNh8HBR6+siR5xDaVFvmBiq9Eh/8kGfPnQhmjfB56JGvqyRXqvvz+LrAesOo1wGoZ8lUnAtk/iPOsV5sFjMLXY45hORC8DNhtOLqVCsk04ezx+uuWuDMTXvAx4DkwSoPWntQRjGM0zrwa0691P32i71GZXQl7+68bxb8HudpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWswOQe9T/XMQWP3DxI7Ydlo2vh3TZJyGeFdJdDGpA8=;
 b=Es6R29zysOIu/5aCwBX5AAwKvDBiN6ZNBe6cvpBNXqFV21ua3agvuztBIf5INwBITFEPLnFYqPdbXyoqQGvVuV3f/YlTIjDrSM0cbvIlO1NnEM6jlOYXqeKvvf7OIwd8QRFt31LymjXV9+Q/zVaLK7fslxCs4tLMM3smxmgyNGh0pN9Kx30Q+UHwoCx+1FX0vdt/JyHHg/ZD4YzRmB3UTIKF6m1Oq8mP46+chr9+a7Eu0bMitucHC6bIwxndUA+4G/uvz0g5LrTJegMNEDPSQqYjjLDCEwNriooQLxiew1QbvbgxZthbvg/0+jQyvqF1+dMF3bskSvo6rc/l0hlSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWswOQe9T/XMQWP3DxI7Ydlo2vh3TZJyGeFdJdDGpA8=;
 b=HqvrmT0eQHoxbi1RPQKM0bytLqAk4OS0OZT9FihOlUDks51aJEn/psYDYL1kwB5Bge6P4h7m6ibgzxJpluKLujHKSnjaUR+x8eVfh8tQU7uigf1lqWBB0z4jK2vakKe2pSf8+qwhIfHIFppCyfVajWmy7CZrxBBgjxCfBOkSgeY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 09:59:15 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 09:59:15 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: cleanup unnecessary virt sriov check in
 amdgpu attribute
Date: Thu,  7 May 2020 17:57:03 +0800
Message-Id: <20200507095704.25623-3-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507095704.25623-1-kevin1.wang@amd.com>
References: <20200507095704.25623-1-kevin1.wang@amd.com>
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (58.247.170.245) by
 HK0PR03CA0098.apcprd03.prod.outlook.com (2603:1096:203:b0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 09:59:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54e1eaf2-8a7d-4c01-9170-08d7f26d4c98
X-MS-TrafficTypeDiagnostic: BY5PR12MB3666:|BY5PR12MB3666:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB366644C07A3116D0424869C3A2A50@BY5PR12MB3666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQy291+8TQN7wdsohZifpQtPLwsWPv4Kyuaeiiv63FQ6Q8RavXBUDJ7odeieTwn6lr81cAN3CLrKQZ7OoeroLl4NTar3BSO6tQJF6HDKsyewvDAVFG5a+amNCFUSL+TvSogcI9sKhnzH0qdk5cE7o1QLTAC5XjpVaJv77oEBH/T45AQFDryRNywyNJFhcrVW9g+weEqMNPUNvDZl2fVxRpLs2km5AExIPnvzW2Yq4Wz3FDYsxYAWGLEhlgaTzzuStkGvSuvQWEARF+ZYUy0tuYxbIrh+KvGMsvm9xzbnjnbtPtkQ25RNhxxKK5rjDcXKpN3gKjWW+g1OyNI2iYMddt50r65xfYSODnIK1Cio7SCxMHhHrR3Nm7zNrreGAE9tt5RIv/ji4HVruIrgjej3V993epfCuCDJBK5u1Xl2pjcD7MgpbJVVISmcrdrhIn+npjsmgNmit1Iv8dc3FDJRXpoKlB2tQMMtf/QhfyaM6JYYqHxkyYM2JIwPH8T6JA5euAHSr6eZy6nEzeFSfHfJXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(33430700001)(33440700001)(316002)(83290400001)(478600001)(2906002)(26005)(83280400001)(83310400001)(83300400001)(83320400001)(16526019)(7696005)(186003)(52116002)(6916009)(6486002)(86362001)(36756003)(66556008)(6666004)(4326008)(8676002)(1076003)(8936002)(66946007)(66476007)(956004)(2616005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fcaj4smOdMKF0AksfKQgee6WuFAKDkHTaQu38jSym63/j6uVWkES6O9b2R03ALDRzN6HGpaEukumjjgiZ9kPoTty2KQ8WUG3NvsTtznDzXtWYVZl/6JIpFKUfhx8Df38efE9DEhoZrGvCHl/ACAG3tgu/IqTmKE/+szbXTKxSgAcQTdXwPhADEEe4o4idd1SvLaJVGFyRdi2a5ITjdBVaeh8v9HgmEVm5lFpJX3XuRAlrStGwdzVoG+taSqgdLdaj2pZZ395pHGT4/CwY3b2QP8bLmwpIb+/JTm+xLPGtLBW6pY1LuISrqaDoPN3P+IUDqV8jdOvY8mMPW9RMfDnzK/XdOig7OiIRHr9AE8M0Yg7LMwDxlJMG2ruT6edu0ivID5g2QYA4bxeKkF3pzn08eswpu+ILq1J/I8m8MGfDkAtUV/2agpMK+CG1k96tbkssNWzq1Zvq8T2WVkjNXe/cKytdStwHNDDBQRlZk8/YCH/JIpXfBYeropr+yINwQgCS2iNJ3bn02g/UPkKXyeFPTZCycpfm3aTtccHuXCSe9gWciueMIFNI7b1nblvXHYsXTgb+5dvOtVVsl9MxvWbL/iyh+G7Arb/a5V6spI4HSDNNA15Opbav4QR1DpCM440og2HopMVLWqNldfxQxHA47GWk60MOBDOhurLA+GOZ5lm1f+UcasKk3DfRuiFEfKpaPVf4FaMGhbpoweG2dpvoWJ8KlHxyL2gY0U3iIdTDNvUcVQ1cegpBOdi4BnE5K1C7BWMlPg2W0xuAXNIzl7fxZlVGBAaMC22B91WDIRZqBY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e1eaf2-8a7d-4c01-9170-08d7f26d4c98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 09:59:15.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaU29tHMxrsa0Vlq6+dkwdz7IPdXRJFAMxNHC6+EGTS9xJvSkWjljR/aZ/W6rb/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 kenneth.feng@amd.com, monk.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the amdgpu device attribute node will be created accordding to sriov vf
mode at runtime.
cleanup unnecessary sriov check in attribute operation function.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 105 -------------------------
 1 file changed, 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b75362bf0742..bc7de2f62d12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -163,9 +163,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -199,9 +196,6 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strncmp("battery", buf, strlen("battery")) == 0)
 		state = POWER_STATE_TYPE_BATTERY;
 	else if (strncmp("balanced", buf, strlen("balanced")) == 0)
@@ -303,9 +297,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -343,9 +334,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strncmp("low", buf, strlen("low")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_LOW;
 	} else if (strncmp("high", buf, strlen("high")) == 0) {
@@ -475,9 +463,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -514,9 +499,6 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (adev->pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
@@ -534,9 +516,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (strlen(buf) == 1)
 		adev->pp_force_state_enabled = false;
 	else if (is_support_sw_smu(adev))
@@ -592,9 +571,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -634,9 +610,6 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -739,9 +712,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	if (count > 127)
 		return -EINVAL;
 
@@ -831,9 +801,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -883,9 +850,6 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	ret = kstrtou64(buf, 0, &featuremask);
 	if (ret)
 		return -EINVAL;
@@ -926,9 +890,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -985,9 +946,6 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1051,9 +1009,6 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1085,9 +1040,6 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1115,9 +1067,6 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	uint32_t mask = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-			return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1149,9 +1098,6 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1179,9 +1125,6 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1215,9 +1158,6 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1245,9 +1185,6 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1281,9 +1218,6 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1311,9 +1245,6 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1347,9 +1278,6 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1377,9 +1305,6 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1413,9 +1338,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1441,9 +1363,6 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
@@ -1482,9 +1401,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1510,9 +1426,6 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
@@ -1571,9 +1484,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1615,9 +1525,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
 	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (count < 2 || count > 127)
 			return -EINVAL;
@@ -1671,9 +1578,6 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1707,9 +1611,6 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1748,9 +1649,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0, count1;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1781,9 +1679,6 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (adev->unique_id)
 		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
