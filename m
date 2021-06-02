Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DB0C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7A361C49
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7A361C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701C46EDD0;
	Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEBA6EDC7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD9n0yozsLSkA0MuIJyX9pln+DfR3AIQ4l0kGF75TWaBD0lDbfFjYjnCbZyCn1CP6HMzFQpwbqRd4AMZHYH9tt9nAy6EdQqxQsp30p4wmqSj6eeH42mhherftAHypmpCsTtDRSDp9vkQ9Muw/O/wB7Xgts6lwye4mUAPne5ooDuNzpvM4xdygui0IMkBd5ayBlOBKAESkUqNveUxKB1Y3NKQUo4HdLFOCb4IYavSWz5MPKUsptuKeEifDZ2wgNYHpitfRNis9fvz5kQT16uUYTxZsMYh2hr3tC/cCUssc5kr/YlXKxXX9cQzTKYQiOzS7BA7VG/hId0rmC2gaj5uqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66hfESy+zLIgwaM53YcndM9Y507sBRxB5hquhrsG+PE=;
 b=BOFjqTHi4OBxXUykwbIgPkknLPB628Wu2S5OJKzme9ux+RE8sTAownOcu2zHVaOpnW6Gr1qHD62Xk4qYzo8lincNJRMSQtlej784ftldYRVGqDCsi7M8PomEXUsqqnZ6DzZygnedHwNabQqPafENI8HTSBxK/U1oobs0V310uoF6l4Cfb1s3scGyOmvOPmSRFs0C9QL3a4FUUQM7KQT+MMnl3iTlblhicsFohrO2ChhB7653lP/1ykQlk0B0Q43NQiS4i/3iK8U8d3RKhWTzPZxPZqMz7eGpJGxA6q60r9nV2tCb+PUzp4MW7S3v9eVrB+cIfoC2RfsqPXBQ4cwySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66hfESy+zLIgwaM53YcndM9Y507sBRxB5hquhrsG+PE=;
 b=tRnMYQIIvVG7MDbsOiez6G0rQ7SBOr2r6+xh7QjTy4w0iIPWDieziJ1O5yVGyed06s/+mFgbzZiXPIYSY+vOZPqMkkBc3BgL5wx8ZdHAIkwW4dbeeDu5RjvQMT40tdGlmyY++MNh34HLQr5VstgZJCtIryINWohqrKqJoOEppvs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:16 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 67/89] drm/amd/pm: disable manually setting MCLK power level
 on yellow carp
Date: Wed,  2 Jun 2021 12:48:46 -0400
Message-Id: <20210602164908.2848791-67-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7486064e-06e2-478d-f727-08d925e67dfd
X-MS-TrafficTypeDiagnostic: BL0PR12MB2369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2369CBFEDEEBE6B732D59B0FF73D9@BL0PR12MB2369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NatIXRSfaNSbccW4ac9ZmoG4cPX64LpshJFaTPD11AxL5qGXX97vlJJGfZzdyfcFDNwdk62pN97O5uaUj5wf4E8w2ODbcJPwCs3t19vxlbaYHSi0Xn9aDkeukkHrmy4hpoASXcnqXYmm7GR3SstU8YHSg2NmPucwwHctkoMR/m54xHxoN1jz8btmf+c6r2r2hHr2tu0jciqaMHfs/z7j0L4ZEHjVvmnLM4wAyvpdiBVpZaTzGNZeyChc1NQbgu+q11Qh/hb5OOVbzM+an/x/7SCZb6keYbpRFcDlku2t7ETrsDeZm9wAf2jN5ZHGaVCxNY6Q3Ro4gfO9PM+S81Y15P2Ed3n0B4V5AHkiHfURULkaZ4xwlZzp+p5JErmOZedp05l5Z7IRazjfMZhBO7jk919QjSrasW0t52YVMTbgpwigarSPcYRUOBeCq2jtTjp+UyD01huzceU2NzwzemXD3mBzTnSOuvWnygbmUB2m2xqBihb08obx7lL2mhOD3qBZWM4N0VHuudYoMDRvbzdd3r72k3wEMsSq00Yn4uPPS2GkUK/hfmmWDvEhaowBdL50hNdWSI03QdOuQNpvfZjws8IvAhb383H9jMa4T2rpjsNM+jmqeFXg1nlnjGnyiwxTINAO1YLrzXwPGjHSpMWjSbGB3U1uDO+wUkSH8yQXyNBah9qeNIYuhdiqTd/gFxbs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(366004)(396003)(54906003)(1076003)(8676002)(6916009)(956004)(2616005)(478600001)(6512007)(6486002)(86362001)(6506007)(4326008)(6666004)(38100700002)(316002)(38350700002)(52116002)(26005)(186003)(5660300002)(66476007)(66946007)(8936002)(83380400001)(36756003)(66556008)(16526019)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bkesis6nuf58neegFyAO4w0QMWIioxDSOffc3UvyLpBM1mtCPbpWYyGlH7rA?=
 =?us-ascii?Q?eCGqY5ESfWHaNpB7CLbBb8G8X0LKVlkWFlTR0HfNx4ueCIwOSV9qZt4gWMXz?=
 =?us-ascii?Q?MZE92mng8mZL7IQBwKoEglSnuwxbyaLw7BLjWogDtmVk4+TJYce9jE8t5aKy?=
 =?us-ascii?Q?EYPfmPn8XDR0pksH07WskprZzo2c7FMY2BStSpY9e430i2D3KBr2hjAkxQL1?=
 =?us-ascii?Q?4NJSpPvdHiA3QRg7ruuAdiBiDJjITjoRq5Jr/NzqgY2FduwuCqnJQxVYp7d+?=
 =?us-ascii?Q?9IrXrjxBw4ukREO+oXUEx0/50xVENxv/yPem+NGwNvCrUtKoBdA/sDFXUzXQ?=
 =?us-ascii?Q?2nRJ7xpUIACvyaTaFVQHj59uL8pd8G271+SfZ74BCXDQ1o+VUfi2nPQyqF9w?=
 =?us-ascii?Q?rDZ8aMpYMKzCVIUMq4MGSzdqRpIRoDk4PtEK4l8OP/IBYEUcD/52h+Q8EI94?=
 =?us-ascii?Q?RE7Es+0tm7BFk13TnZdfeLdUpX4EklZOJVV9hDX1LEO0Anwqns3yUkBVwFBA?=
 =?us-ascii?Q?TNZC4G6G9qk4i0bMys+hIgQ0VGJk/Mnkxj0qVxOyTCB8WhdAmPNmcjkBfhbg?=
 =?us-ascii?Q?Y1jxOt2SzaP8pPExPLaDt6RYnKOYXXMdboK7S063QxVYHxgV+oceYUQ2lYxm?=
 =?us-ascii?Q?VDtRQcSj1kpFqH4rklYB8GcVtaTbfishkTjUElZD2QNx/cJ2bHQ9a36GaZ51?=
 =?us-ascii?Q?O714zlvfKln5fMXgXrPfgTIYoAVzWZs9+83PSDIzkqLOI1rL/TJaUV42R5Xx?=
 =?us-ascii?Q?YfyA/xLjQNiPczRLMWkp1ZeDqpeQhUWqGWB9Ro6u/sTy3thkbOymOBcvKNFC?=
 =?us-ascii?Q?FwGafg6OXiI351CGB896qCxbfKavWLUucMSRf/0DWHVLUXDsKucg0jqRPXCE?=
 =?us-ascii?Q?eIrllYN7+EDuuxLGN4s95R7BvjKklpOo6VSzFTvN4xBPa1viCdtqFU4Zc1xA?=
 =?us-ascii?Q?MXSZ/I6OluTbTw56GP0E01nodJNn5xjLsLggEabYDN7Mv3N6Q+9R69/sWe3v?=
 =?us-ascii?Q?+6WY2GE18vTj99SgXIFMwhnhNQtq4HWLzprJqQmXcubweEvdRe72CCuqgbrs?=
 =?us-ascii?Q?3+QICnECyyKp+dnCpgH3hhJeEnRLDLxNqDjzMu1DlBwGkUjMu+CJNiS7xbgM?=
 =?us-ascii?Q?Tn5BLlTsmDyzidYSu4GZzbHHfisq14e6PEmK8GOA0BV5k/BHZe+9L3tOLH/t?=
 =?us-ascii?Q?+WpHLw2SvuRxod2fFsjJ9LyLkccVNyrw+oisugCRfBSneJfhv5mB6vewvNLA?=
 =?us-ascii?Q?+58VcmQLWAc1VMKHUbbU5VMQrJXc5re3RqrkSG1aCB2WaDOmuCjEnx8wGIWW?=
 =?us-ascii?Q?BeOIkUd5XTcOpyP9MZMyt9UH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7486064e-06e2-478d-f727-08d925e67dfd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:13.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D6MTM113KmEp6y12X8YpNk5ML0VhxSvP8k8vbAzZpxB27UsAHj0/nrfVISMd0jfdrkliIusEvBd1pVo2MD1ug==
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
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

PMFW provides specific messages for setting fclk freq range thus adjust
the power level. There's misusing of these messages when setting
dpm mclk. Since actually mclk could adjust automatically complying with
fclk, remove standalone support for mclk dpm level setting.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 364fc17b2a78..031c49fb4582 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -964,7 +964,6 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-	case SMU_MCLK:
 		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
 		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
 		break;
@@ -1054,7 +1053,6 @@ static int yellow_carp_force_clk_levels(struct smu_context *smu,
 
 	switch (clk_type) {
 	case SMU_SOCCLK:
-	case SMU_MCLK:
 	case SMU_FCLK:
 	case SMU_VCLK:
 	case SMU_DCLK:
@@ -1084,30 +1082,30 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t sclk_min = 0, sclk_max = 0;
-	uint32_t mclk_min = 0, mclk_max = 0;
+	uint32_t fclk_min = 0, fclk_max = 0;
 	uint32_t socclk_min = 0, socclk_max = 0;
 	int ret = 0;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
-		yellow_carp_get_dpm_ultimate_freq(smu, SMU_MCLK, NULL, &mclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
 		sclk_min = sclk_max;
-		mclk_min = mclk_max;
+		fclk_min = fclk_max;
 		socclk_min = socclk_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
-		yellow_carp_get_dpm_ultimate_freq(smu, SMU_MCLK, &mclk_min, NULL);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
 		sclk_max = sclk_min;
-		mclk_max = mclk_min;
+		fclk_max = fclk_min;
 		socclk_max = socclk_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
-		yellow_carp_get_dpm_ultimate_freq(smu, SMU_MCLK, &mclk_min, &mclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
@@ -1136,11 +1134,11 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 		smu->gfx_actual_soft_max_freq = sclk_max;
 	}
 
-	if (mclk_min && mclk_max) {
+	if (fclk_min && fclk_max) {
 		ret = yellow_carp_set_soft_freq_limited_range(smu,
-							    SMU_MCLK,
-							    mclk_min,
-							    mclk_max);
+							    SMU_FCLK,
+							    fclk_min,
+							    fclk_max);
 		if (ret)
 			return ret;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
