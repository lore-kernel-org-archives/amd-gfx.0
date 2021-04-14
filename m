Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDEEC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC458611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC458611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8822E6E44F;
	Wed, 14 Apr 2021 06:20:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294A06E44F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 06:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0Vn798PXr+ANUPrTwGOOrMmfuaMirXwj9KO+Nv6CQcKY6ESjjdtdYbOtTgNVoJcC4bbjqfXWkZWuyVS5eV6yFHIMnQCfVfVaxk/QnEMkB+U6WzGyNnaR/BsSJSFFMh1/HYNx6Fji4C9bduLNEPo2w0SmB4w8pcz7Q5Ns8syQVT/JJCE2mOTM3yZARMT4wTogxRSX99nO9oQXxg7pqhwIPT50gUtt5OdsfAf5cpfRiQ4vuoWLWR+dxmzfaut7y+TODLY3jM5AwawXNG+fqMBfJ/aUl7zpvjQQNf/nvBv+tedBPbiyFbsOZYPWNbVTlVD3lKluHkPEGSrYbLYvvFLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzrPdpuK4wjLfWSyX1X5Ps/fol5eng5Uyv5X+S7ZoFs=;
 b=L/JCqLQZReo4p8T34ogtCauB+PFoMXo4JBsGqLy/eoUqgd3PRNlpD6TxGnyfuSwDtR4gyWdJ+7E96aKu1alNZzfABnbhCyBniCOYnFe/2+Kji0rQBqp9rxIZwZktqfDDodUShwmyshK7ApRrQ1YxjeCOvaLIftkrn5tVQV9K1onD6/ecpx82xOvylbRSoaCKyzTN1dq4G+/gRjhhfBTxGjCKZjxV7yUc+vRx0ngiH86D63uR6vYzXtCrDgujmXzYoUxFzcx0mEW2B65Ame44ev2IcHkPfBB0jnSfHjeyoaoSwcMp0SsdmtFwfzOrJoNgQozX+3ic6fO/CtW0xNwS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzrPdpuK4wjLfWSyX1X5Ps/fol5eng5Uyv5X+S7ZoFs=;
 b=NOBS2Ets3eu9+XDlvB7aKPhEbEeS5scVqXt07QcVKJnRy7vPJdAusj3zp8JnuBuf0yco5q3R1cB9ChRTbdzkPEpw/pEkXI7kkJ5NK3XCGAV7nSWai/gxyTwwSYqaOyYo/90cX+13N9npy0LVBxgd3qBStdGoFCF7g0pUqcNUT54=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 06:20:31 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a%6]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 06:20:31 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: remove the "set" function of pp_dpm_mclk for
 vangogh
Date: Wed, 14 Apr 2021 14:20:10 +0800
Message-Id: <20210414062010.3251391-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-vm.amd.com (180.167.199.189) by
 HKAPR04CA0015.apcprd04.prod.outlook.com (2603:1096:203:d0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Wed, 14 Apr 2021 06:20:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef1696d-8c70-4363-944b-08d8ff0d67a8
X-MS-TrafficTypeDiagnostic: BN7PR12MB2836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28364B963DF1D7A9BBBA0668F14E9@BN7PR12MB2836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gsc18XyCtk2ym0kdZbQ4Ccjr8G0a1b5Qe8hY8BhMq9AtojTbgt6T2INayA2GpNKXIoWekj6DRkCldriVpV1XmY5PtcExc4MXx00T0xNhNHoQaVDv5MXWIGQmnfwzxul0wIxodHZSdltaOUEbxD4U3NPTqpHGFAst94w0sKowwwa6tj+NyOXPU4PeZrjJG2d+/4Gidr9yGhNP9PFOBoe7QNG8IxQuLh6ewZFfCZyPS9w/9GjoeyS409W6CavsfNrQaQ/HNlK/y3+JjCl2hmgSJ7RkqlmYjqwJhqnwcuxMotzBF2TZJ1LvaFN4OK0XT+SiNWMuAeqxvR21H4OR6/YMjkQdVnm416uyqpum4FH0/L+NLcya6DO7s2tzh0ixAxEvhNX4y5svEGZWqk/dj6364sGFTDNSsstwir49ZEywJMbYHIR7+gfxlP+pD0cyCjXVlVckyYtD3yWnhokz02uGoXrYMTwooag+c8KxdZtOBC7jTv1mXPN8bZNI+5SO4HCoq4VtnlaZsrveIfuH6CyzUtEqKj8AYf3WXKmU83yxbgMKl8Wt/rsJWx4zpcsEhTcnTDRAM45bQ92LpF9O1Wiuub82rD7pLFMeuF2f/kavdcPwJyJr2FD3dQ/4lwux59MAPtUY+f3jkMhDQKahvQwPSKfWWhqxiFwGdjZUD7MjKGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(83380400001)(36756003)(26005)(38100700002)(16526019)(7696005)(316002)(38350700002)(52116002)(5660300002)(66556008)(1076003)(6486002)(478600001)(4326008)(2906002)(66476007)(8936002)(2616005)(66946007)(956004)(86362001)(6916009)(186003)(6666004)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zyUSrMfijIvhXmWlNe2aJvztVdzdczxpsZU/ngWytwnOFW610ZCeCzZe0Kga?=
 =?us-ascii?Q?FjGfO3DQDMBEcAM7wyomFaURms4IueZf1Oa460AWDzTkNU26RDVvZXjzdvoT?=
 =?us-ascii?Q?DyMiB07N8iotjd6TTg+0Z9dK8kb6GHEouMAH4Vrhl8CU1Eh5YUNXZnfAOep6?=
 =?us-ascii?Q?IrL9pmSA9j+NRT9UGzf9YC74zR8qMEBPeBHUzcKVckddM2NLNMVViFmDSfyG?=
 =?us-ascii?Q?RmWbvxo40or3K9jUYDLk+7P3QVcsXG0NuMZvo8QNjfRiqU3v1S67R3eiIVF3?=
 =?us-ascii?Q?rm1FW0ZPvenVzzDbkuuVmujHXfCxbnhBoh5Pl/gtfIijPGOjWHGbqRREwxAZ?=
 =?us-ascii?Q?1XabHMzw5AU56cRy7jdQGOy2HsnfMEXI0AmQkjxCjifmb1uTxD6AA3K8YXAe?=
 =?us-ascii?Q?21QTa7eqSHkf0EKDa7oPb+HhiGKmSv5doSGh5Di0BlcNfWtL+IvgnJrfZsJW?=
 =?us-ascii?Q?p67ttK7/6JZYYFOfTmTtLKKZreEKVx9uxqPEagtg1/nrbomec/+35ov06tS9?=
 =?us-ascii?Q?lIwtmnjifXWOlnVfumwVTvk67eatsQ3yVnupKrMdOWY70W1fvjPVDnHJE4KD?=
 =?us-ascii?Q?UMvB69XQfliP691pldM4xmXRJBAiFOVE+kMhPsX6RhhPWNjqyBTZunf+VJwi?=
 =?us-ascii?Q?2knJQ3i0+UqvIV/DhIfJ/mCCN1SnkoEZL+loXWVxWiRcwfTAFqgFD+I3hAEJ?=
 =?us-ascii?Q?FmuMfzH1FULwjrUWjYlhyXPPiHXoUGwXK8HFm6R9YBI8COD7SsKaiCjnCr62?=
 =?us-ascii?Q?c+0HjhLTGjiPIBFxu89AWipo/tnhsWSx4hO0OJDNzYHymAIUvLqJ3GezTPrE?=
 =?us-ascii?Q?vkXI8qHHN5XOrDQ9KgaqsDQl91c0K3fHEjBjR5pfyvjLYmp/RoWJabx3iqVL?=
 =?us-ascii?Q?YYbaoJxVBmImJAl5hFMpweA4zjSJBojEGICkmocPmycX9OdxXYRIkVKtSbKt?=
 =?us-ascii?Q?X5N6kAyqoAi18X+c8e5bPqSnK41mv8G0jSMIq3Pp9yGHj+Mihio7DfpOhfhI?=
 =?us-ascii?Q?RR4fPPK6+jaDm8m5OJbHPxR/doOqk2GiQ2mSNGdWo3AnfhgIVJ0ba7kFZuo6?=
 =?us-ascii?Q?YlQGJqtgYAtELISBa9YhousgurT2PMoVuQ+orYihX550MId330zojY2PIaQA?=
 =?us-ascii?Q?SE02jl/GHzsvHXeYe4AbBLbpQICh3fPdpI20GpjJSlZ/VSRBONiwHGQcfsPO?=
 =?us-ascii?Q?KDrhQheKK7FR4phOCnguwG1DZBOfIAGYdEJxImoVgiVK6xhOMiG+IV0M11fN?=
 =?us-ascii?Q?A6ddptXVJCtehGnLRUdo+5EkXJDKzPdZIccNchmoxh2nXKexDc4796JkCaX+?=
 =?us-ascii?Q?trlB9/sF/YMzfqm1vYoSFiEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef1696d-8c70-4363-944b-08d8ff0d67a8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 06:20:31.4303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbwsD6rKT7K33Feo1Ynl9ULC/yn8gGegFv5A2aXh+0oAgWZIdbryC2YB9D8eQqgFpmnwGhFki2QLs6apkmn+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
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
Cc: Lijo.Lazar@amd.com, kevin1.wang@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to remove the "set" function of pp_dpm_mclk for vangogh.
For vangogh, mclk bonds with fclk, they will lock each other
on the same perfomance level. But according to the smu message from pmfw,
only fclk is allowed to set value manually, so remove the unnecessary
code of "set" function for mclk.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 61ff9a663b21..35904315c1f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1092,7 +1092,6 @@ static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
 			return ret;
 		break;
 	case SMU_FCLK:
-	case SMU_MCLK:
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 							SMU_MSG_SetHardMinFclkByFreq,
 							min, NULL);
@@ -1180,7 +1179,6 @@ static int vangogh_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 		break;
-	case SMU_MCLK:
 	case SMU_FCLK:
 		ret = vangogh_get_dpm_clk_limited(smu,
 							clk_type, soft_min_level, &min_freq);
@@ -1267,7 +1265,6 @@ static int vangogh_force_dpm_limit_value(struct smu_context *smu, bool highest)
 		SMU_SOCCLK,
 		SMU_VCLK,
 		SMU_DCLK,
-		SMU_MCLK,
 		SMU_FCLK,
 	};
 
@@ -1296,7 +1293,6 @@ static int vangogh_unforce_dpm_levels(struct smu_context *smu)
 		enum smu_clk_type clk_type;
 		uint32_t	feature;
 	} clk_feature_map[] = {
-		{SMU_MCLK,   SMU_FEATURE_DPM_FCLK_BIT},
 		{SMU_FCLK, SMU_FEATURE_DPM_FCLK_BIT},
 		{SMU_SOCCLK, SMU_FEATURE_DPM_SOCCLK_BIT},
 		{SMU_VCLK, SMU_FEATURE_VCN_DPM_BIT},
@@ -1428,7 +1424,6 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		vangogh_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
 		vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
 		vangogh_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
 		vangogh_force_clk_levels(smu, SMU_VCLK, 1 << vclk_mask);
@@ -1468,7 +1463,6 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		vangogh_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
 		vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
