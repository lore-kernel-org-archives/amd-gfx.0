Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409C7C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0F4613F2
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0F4613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4086EB35;
	Fri, 23 Apr 2021 03:23:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE2D6EB31
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 03:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTJslq0nWpRW/XoQ5GoHuSo7VXZUYXUtBvHbPRCGcjSBifH8Oci+SyqJoHjf1ZEvz7aVryQlw2LLZVtg1G+8IMc/VrLw8pE7913nfFjTyE3H9K7l7HqwFkcvF5W9hbh0Vy36YriaN3GqgC7EPrRXSZhUGSvVLQCAl48SMBhBgCADChxLVSCw4i8r+bZ+NqpuTlxM7D61+Arq8jURb+jaNkhcwoR1gD7MSCwBJQ00PtRJayzBB81NVJO5YohcfGvccQedCPS6KTlibnmIRyCST1zRP12Nvv+zEJV/DZg6NzMwUlsGKbzwCke3b3O2PRsl+p0vZ//5u4ekyc+59fvxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv6SMfbiXrpQUIlSGLOto+fmq+8e3Nc6KLqnLyXBYFk=;
 b=nr5NcxJPnLMHdQ0SDNTk//kxqDzXqPbR1CcLyNZrC3aPwpHEdUXYNEuNVIPq/xjCvIu6oupFFAwHyWpUZbbCvb1fePnkjDGPLBJ1WvyhR2qV/+34oywKX5lN+v00C+loHKEeW8/s416nEXWpWD3tYata4ndV8+JlRYhR3PETJqlJRUJvGw9UhgvsHEMsIKByvYI1FqkNRscbrkLRLrMquWEYEUBgZPBBwhspYfvxb2n1sngSeTj0fSjKYxxJCsY31ikFo5fL6OmeVniYG1KGP1NfwRmgnCNX9/rKfie72zHRJ2j4IOVg7l10SCEBwu2QTceMgBz6D7S2lcoNdQYO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv6SMfbiXrpQUIlSGLOto+fmq+8e3Nc6KLqnLyXBYFk=;
 b=hFlUayt0VbGRBSwmrC8octIl7NoYI0IC85M6OT1Z/5cNW4ZDPkJx3xO+QmIVR6JRjjRV0zirtfwHtKHJXk0eP0NZiquAgXiGuEGTp4A09oug8snXYGZIsVgkKOjgo6R5K6lXp2Iyv5B3W7ASL0fuWFSkt14qq7HL3pSLJudcRvg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB2956.namprd12.prod.outlook.com (2603:10b6:5:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 23 Apr
 2021 03:22:58 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a%5]) with mapi id 15.20.4020.027; Fri, 23 Apr 2021
 03:22:58 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and
 SIENNA_CICHLID
Date: Thu, 22 Apr 2021 23:22:35 -0400
Message-Id: <20210423032236.6379-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423032236.6379-1-darren.powell@amd.com>
References: <20210423032236.6379-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.190]
X-ClientProxiedBy: YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::30) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.190) by
 YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 03:22:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72490070-969d-46ba-eb65-08d9060716ea
X-MS-TrafficTypeDiagnostic: DM6PR12MB2956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29562B02B93DA2E80EB87123F0459@DM6PR12MB2956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJjnaQOzdHDSu9zhVxopwmchh8DLnh1JrllouTWwgZn4+a+5CL7KKJzTFovo+iJq93gy0Eaa4KdjOkDUHR6OQP9/xxQ92bLdrdhj/yGchkRXOv3/sycfb9PtQi/EZ2QQCZc8NOqTX10Ljezr3IHjaXOAKeH3qJBuKNngSWKMGgI2+/u3OcWEM0Zx/NEFdESlSTGcHrnLEBTmSwq8/dKCn0QG+SsIxBqZ0fmoDgwnOPVdeJ3TZ/iGxMH4U6SfGCVESVMiFsHzMOgJd0FHCt2l4P8HJ0yZ1Zr0PrPR3+VRaTi3ceR6Sy4MMuW+vDw7RbL6HXAN5KFACmXCxFUpcQLZwq5VeuztGLZVMe6bjm1R0WA1qIrErJqeQNgeygBYOJlMRoCIbS44aIfJISi7WFrMXg3NTZlRDTlF/wAjCksRK3A08J1jkZPUVN5T98ulKDMVq7HZ4YNN1kz1Ai4BaJEsdpfawtBvntuFaN0zPeP3neoUROZhNVyv5Jed4iVdnkYcZJBOlt1CWtHo6p0f64f9TBu2+Oax2oPsrr2KVvGOXz9BeNvgaBfgPn6xBLuTZH/HsmWOYT+W6I4vs6eGhpfvvPf1UPyHR5/9LFyXBnifN6m1Cjxad4R55jJLUs9ENv6dqa4BuhJZhJJ1m9jIZ94yr/9XB+LmoT2dt8aRLgmu0BKNFLR0Enw0WBKUOlarzDcZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(86362001)(2616005)(4326008)(8936002)(38100700002)(956004)(16526019)(2906002)(6506007)(6666004)(26005)(52116002)(8676002)(83380400001)(36756003)(6916009)(478600001)(38350700002)(66476007)(66556008)(6486002)(44832011)(66946007)(1076003)(6512007)(186003)(316002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uVDV4E8qXgbntJBFfP0ji+Lgyh16flg6Ijo8UA6TsfUNMwPwdKZZ/JaDyg2J?=
 =?us-ascii?Q?XrFqMFvIJphZogcH4RQ7wIigtAPO26F9olpMbMj7y1l03+kRvFzNBECgxCbH?=
 =?us-ascii?Q?Zrdcq76D0q9ORWFudiWuHhYN7/HFSpsWwA5MP7d5EV2s4QOj1EPJpJoEziKo?=
 =?us-ascii?Q?Pijssjg7jmIn6BHlz/kUFgtx13gLsUXQ0saEM7YHQrkzkGFHn597tov+cE1o?=
 =?us-ascii?Q?SxsL4UDTu4OLrkNl10BrOOs0Yn7sZdd+FG7H+jFekLwRS8sWQeDMsYhWq9DT?=
 =?us-ascii?Q?4us7X0daH9RMEldhrGL75QLewhqqxa2L1GgevIQSizPQpcRqs8+MvSt3DMHP?=
 =?us-ascii?Q?g+La2j1Yi5Yolweo/e0nMeB6GI+LhxJOE/91qhxGTAwq/pwEJTBHSFR4X22t?=
 =?us-ascii?Q?ZyiCP+Wpr/faebVzKXeYoArA+V2c64PLajfjVVwfLar+zJKq47CSyG+nRwgP?=
 =?us-ascii?Q?QQXzHcQzHZxA+BoqH4ASikvQAvo9wLe0wNs9s0xlQh42DHPAmN6shzTaercK?=
 =?us-ascii?Q?d+PwjRScfblejs7FPj+03C6peFz1mJ48rU3qkHKbcV2LZqHZAQqtj2Num3gH?=
 =?us-ascii?Q?yH0nAI4n1A+N1XSvpJIBSG5GeY2tkQiT/TYS1Vxdra8TAnYD8J+6pXwc61BL?=
 =?us-ascii?Q?rDmtNCkMuNfXVrbgNJvbRik048WvR4MRTgETNdZaW+bB42IfUqqc959eeOFY?=
 =?us-ascii?Q?kEPPgA6s16sTxV9lAHiHMVfRwFVgIU0rW6VZNnhR3aijjmqwbJLOgZnRj1hH?=
 =?us-ascii?Q?FwyLwjSSMJXbs+sKo4FD8IVLibK/2ODA6iRgeTGldi8UA6zcERuW5pvGU67n?=
 =?us-ascii?Q?nnCDVtFeyoOcHUAqOHSi+ehSSl3G8wMJp7/LEE5O0ALzWyxHeLAUxDAUao2z?=
 =?us-ascii?Q?FMV0uNOhune5QCxW8huDXhvNmzRXL0gcfbxX2cgr7IyewopA0+lhYuf/IfJq?=
 =?us-ascii?Q?1xctIuCqO82by7dJ8X7Z1TB96bS+HerDPPFMndUnYhvSsn5rSFbcx2+3E/0C?=
 =?us-ascii?Q?LIhIXoIzC5uRcBTOtfTXycZZHk/CR9xzvT9+8yT3h77ipvz+7UWxfEZjAFev?=
 =?us-ascii?Q?3i+L6E4p4uqRQ1k7Gf7e5LHQ3bhAsmXWJKY5AkcAn350uBnsdRKpImLsG/3s?=
 =?us-ascii?Q?urWYqv3dsvOfBt2bcJ/264ad4fPz7YG1K/4pc9uEUxoXP0xDLwGx0tel8Tl+?=
 =?us-ascii?Q?89FYHbK1pVKpl9ju5VmSrZt2d/qfBZwPh2Ry3tBvTr2H6tBQ+GlD4JH3fWnk?=
 =?us-ascii?Q?07Q++10OWTLIwiZa4M2WKtQTiWXO1jIwEqHL3yma9qhe+z1uvWyO/mp7LiV2?=
 =?us-ascii?Q?W2idwP6pRgLnGUBGEAR5BS0E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72490070-969d-46ba-eb65-08d9060716ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 03:22:57.0337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dkDGBfI1/Pc2QnC5PewjjM7OpxfRbRszQUUi23H1Fjm36rtn3KKYPBTnudyYuv4EGPWQzML91hgPZqT/N1nuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Writing to dcefclk causes the gpu to become unresponsive, and requires a reboot.
Patch ignores a .force_clk_levels(SMU_DCEFCLK) call and issues an
info message.

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f827096dc849..ac13042672ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1443,7 +1443,6 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 	case SMU_MCLK:
 	case SMU_UCLK:
-	case SMU_DCEFCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
 		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
@@ -1463,6 +1462,10 @@ static int navi10_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			return size;
 		break;
+	case SMU_DCEFCLK:
+		dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is not supported!\n");
+		break;
+
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 72d9c1be1835..d2fd44b903ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1127,7 +1127,6 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 	case SMU_MCLK:
 	case SMU_UCLK:
-	case SMU_DCEFCLK:
 	case SMU_FCLK:
 		/* There is only 2 levels for fine grained DPM */
 		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
@@ -1147,6 +1146,9 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto forec_level_out;
 		break;
+	case SMU_DCEFCLK:
+		dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is not supported!\n");
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
