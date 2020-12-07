Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F471C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 09:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577B923447
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 09:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577B923447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD6889DE1;
	Mon,  7 Dec 2020 09:22:58 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690042.outbound.protection.outlook.com [40.107.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E875889DE1
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 09:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6jeIHTdvGaFjl0O7BUtfq3V6ik5nLI8OzbmswvYyaB+MYus4Cmi5hBgkLAP0sia0bj11Vj8/LHVEmVVOS8e50MygUyQrIG9QQPxIT6xMClfwgBcZFBYKiRvuEFBLwErOySHZxrtQIeFD4W9Zg398pC5qkElrmJL0PNf/BWKH+qWEFplXURdeEc/2uyffL02VY3wDCKDQlnXyHc+52/Yt42nTOoupurfErvANmWPhKzWzjiBOJY8eeIFGrVZb5d8l7hd/Qp4xkETwSwGG8ltNPy7Fhi1eUo6DGH/gyAeoBYrMIPB8cY3QQAdFmYEzcS467VpQE9TH6ZgMn6uigSDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud7mjsMvWDEs4yuuW3BlAMTvMHUI7NNU7Mt93GIGnXs=;
 b=OqRwPmcFey237JbOA/NCMYTUQeWu9PKwVAEWX5bxE5NBP+Q++3GKICaVX0vWoJ4bnqAFBPeWCbK99+My0Ejzud8sso5LdCC+6mzmmJvKLm2b5TFQJQa84xwBMr5AQjrAYWkGOYOw+XkxPwTmH4Le7P3VJS6LxX8hDnNLTcQGJ255HL4ZfGYa450czgkhMnST3RPnvhojWz/n18/L1p8DgscxBRKLwTLklPMCzgzGDy3HXRhOYiBsa7Ot/tgRYHfb/X2pIKxeWTNV/fwWrB0BKJOD/07aCod55HATNZvHWnTJiDRbsCi+b5ShGV0QRt1K81dZY6XghqL450988T6O3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud7mjsMvWDEs4yuuW3BlAMTvMHUI7NNU7Mt93GIGnXs=;
 b=TnJfGhq3bI/m/b8Rydpjx2+YNCXt2FFI8dFlnfcamSO3EfJiZP9hoDDLrAbe63OPwzbd0dHFR52JzKRfVzN3jPR+hIh0Z7kuQN+HPcZoTNdnjymMyDmmEuPRnxMzeEJ9aVpJHFcYsP4JwcWhUGoHqTSrLnWQllkbEWn38wm+DlU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Mon, 7 Dec 2020 09:22:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 09:22:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: correct power limit setting for SMU V11
Date: Mon,  7 Dec 2020 17:22:32 +0800
Message-Id: <20201207092232.81415-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201207092232.81415-1-evan.quan@amd.com>
References: <20201207092232.81415-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR03CA0117.apcprd03.prod.outlook.com (2603:1096:203:b0::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 09:22:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 185a3386-b682-4d77-551f-08d89a91ae6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB407564982D393F038F665843E4CE0@DM6PR12MB4075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1QWOD4vD+ikKD5RltoA3zpU0gsvv9hHFY3xyigoEGlqaYnnqlDsMpRH2Jc8bTv/vWFdsbuk6pfGdVcJt1wDQV2/FkwkLNpKV+SS16DEsrP4MvjqQioiBmh7GXIMzApVhwzv49fdBGyjHXFp1deYmkN554zzjOyA3j2wgeNOZarFUCZHPSY4UROI6w5HxZCBMjhV7shXRiz49RVv6YBcDjBlIa2J9iqAJ0GmhRvqc1XxnJp9QHz9owhmZQUlJF9o1nMLeD7lqBR8Qtc+c+OjLUJWX/3uWo26Hwiyyq7BGhXI5oG3UDAJRLPTh3HDRx3iREgCzkztZqTvJcYOKgwjjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(2616005)(8936002)(8676002)(4326008)(52116002)(36756003)(66946007)(5660300002)(26005)(956004)(316002)(44832011)(66476007)(6666004)(6486002)(83380400001)(478600001)(2906002)(6916009)(7696005)(16526019)(66556008)(86362001)(186003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ngs3n2JdnbzQmOfd2vOIlGq1BPjfU6GTcPzcAKD/uPTENR45JdwDYeoiz4g0?=
 =?us-ascii?Q?fryKB2AWynTTvSw/eRnx+s9xWF6kYHLhN89BZ6MSivGWphQiJmFhijkfQOD4?=
 =?us-ascii?Q?tq0z1700EtVLxcPuz/989Ry6M+vxlAmvPR/ZaeQLcbk/wSBTYP+KVrJcLEgP?=
 =?us-ascii?Q?2xsWf2zlVTwv+ZL0/VkieS6h2NLZqc8Vki2PcobTmBpdtC7ZJqRi8T8q4/k4?=
 =?us-ascii?Q?W+uI3kBO+KQlh2I7Ks8aDVA12Ms5iN5exzi0wEFfFy8gvDPrSsLC2cENZVhI?=
 =?us-ascii?Q?A/2PbSpmmVf8myMjwXx1DDIt9up+TzFtsHHum5ij7wpZDjic6tVvIRp9Qkdk?=
 =?us-ascii?Q?l3TzYh8fLs1I2KuKdPe03xVu9w22mZKo+VVy195aMLbnqmAIidETzQZTb+P9?=
 =?us-ascii?Q?BiPwfBdnmko+Shh7R6JNQ7nVQDk6Je7laQ/3y0LvYpweT6LG1vgwV1zpe0ja?=
 =?us-ascii?Q?yGDN8U8qdIpuq4JR+AoDUT7KVSwnnSPxW9gyoRMWNMo5fVyLTUw7h51aYzn3?=
 =?us-ascii?Q?6yZDygaguwFNLpNcj+TP2jrVIqLT9eUexpR8A759o3Sk1NDZqspOFM/x3dan?=
 =?us-ascii?Q?cNPU5vz9o/ZDbFatdS87FlqP+ukFxZkUp2kkUXThISHzTWkvA9GJ23QHjZIo?=
 =?us-ascii?Q?cDyg3CZlJ+05Oo9U1Nz0VVx8yfpuMg2Z0IQ9ESfKNi8vwQnxIWftHpUDhGZt?=
 =?us-ascii?Q?0xmIDIOhL+JemrH6Rb6bHUetD8XwoMtJ+G1sB5x2LIeNQYYGvgRmdTDyM9hl?=
 =?us-ascii?Q?Yo6HxjqyTshjQCWWmnQfgdKdTZFl1O1Xqyg00qhH7TSkJEfQrgFOupC1VseB?=
 =?us-ascii?Q?j2o5JlJV4gPuMhFP40+eXZJISGIOMwW4MksMvA8hXxC2581475GeecCjwz1A?=
 =?us-ascii?Q?LZyxZCnqlkIzEM7ot3dFwcB1sXRXovQNhnBMMO/sbYzFaN5+qYMP0mIqazLy?=
 =?us-ascii?Q?QqAHLER6cZvH0d19coBmPIjFxzXefdGS7vI+ygYpAxR3EnD0ddUsdb41AjVj?=
 =?us-ascii?Q?meft?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 09:22:56.0152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 185a3386-b682-4d77-551f-08d89a91ae6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1JDWYo3xWhk1gxjRqplGVkLy9pzwt6Q3NegQfydSrzImc2FJ/a3U9OcR48S8FjG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

Correct the power limit setting for SMU V11 asics.

Change-Id: Idedc590c35934397bd77b7ac825b063cd319dbbf
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 624065d3c079..3288760a5431 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -929,9 +929,13 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 	if (power_src < 0)
 		return -EINVAL;
 
+	/*
+	 * BIT 24-31: ControllerId (hardcoded as PPT0)
+	 * BIT 16-23: PowerSource
+	 */
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_GetPptLimit,
-					  power_src << 16,
+					  (0 << 24) | (power_src << 16),
 					  power_limit);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
@@ -941,6 +945,7 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 
 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 {
+	int power_src;
 	int ret = 0;
 
 	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
@@ -948,6 +953,22 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 		return -EOPNOTSUPP;
 	}
 
+	power_src = smu_cmn_to_asic_specific_index(smu,
+					CMN2ASIC_MAPPING_PWR,
+					smu->adev->pm.ac_power ?
+					SMU_POWER_SOURCE_AC :
+					SMU_POWER_SOURCE_DC);
+	if (power_src < 0)
+		return -EINVAL;
+
+	/*
+	 * BIT 24-31: ControllerId (hardcoded as PPT0)
+	 * BIT 16-23: PowerSource
+	 * BIT 0-15: PowerLimit
+	 */
+	n &= 0xFFFF;
+	n |= 0 << 24;
+	n |= (power_src) << 16;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, n, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
