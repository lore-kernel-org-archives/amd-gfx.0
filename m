Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D8C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8F061C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8F061C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4AB36ED9B;
	Wed,  2 Jun 2021 16:50:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EABB6EDA1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaYH2ZdcplOLnpGTogIdX9lX+OjmL4fSABxeWxtY1NqQACFa551dBGT/kAJvMY8nVh2dgGfgP4MG8j0ovxs+V6HNJ55QDwsvgQuPjbX1GKE3jeFnSYtjeefLmPmCj22T+szgMCP7cMqlBweuUgkYd2o3o5HsOHHqi0ihqJ86unQa6Az+imDr2IS2YhrZFs0R/pKn2DkLxt367UP8OIWauaxOtXrH7TBhotLZnNZJoRrcDsPpKl3QZ25UpLi+pBe1aFj+j1Soym0a7GZ9dmLNZN1Uu64jUZkolRl+Y0YBV9RK8QkhokihEzhhzwU5a9vaj+u0hMj8H8FgWWBUaAq25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caPI4P2+JRSSrUjhNu24dci0wX8lDFUioi6quxYaCvI=;
 b=fKzp2bW6B3pL839TuoN/tD1mVHq9Qzzxifu59DmJFre+ILWtJlfDUA+uVdefp4mGI/QBizYcRzhMUegl8oRsEftsVUshJMbv8mIPlnUuNkauOlSPLqSgqqvwy1RoCYVXb1YuzkBtpw7/B4DYoxg4lzUp0ZomrqnY1Hf2R4x4i69BPjjMxPqD6QMIVpiGUaj40ziDALgjaiaGEn3vgNm5dGiYAIwHGjBslxb03COcFcCoznkeDca7NWdhwhg0pIK4Ajx/Ck8hpaASHhCMQ7XWmzG0C6GWQmAhWjjLpjFSddvmiFDuBDg/t9WxSU9fejIibN0CPCNqDyLrLKXBSTBjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caPI4P2+JRSSrUjhNu24dci0wX8lDFUioi6quxYaCvI=;
 b=2oYxIFXTPyhL04IE9QI7KsejTsulcWXYL93YnkM3lN80zX9zbTfLF3g0n0nlHZC1ZlkCNCCqnB4M9i+TVEsDEXYXW50SGoInBtKe9NJvyO2DTxgi6hHYAyO7fnqpC5NBp7g4EjkJxq4dFmZf9Ded1oMrlOT5Uubbejf/Xg6GS7w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/89] drm/amdgpu/pm: enable gfx_off in yellow carp smu post
 init
Date: Wed,  2 Jun 2021 12:48:14 -0400
Message-Id: <20210602164908.2848791-35-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f350ae1-bb55-4153-dc22-08d925e671c4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4675357022C226200B905AA6F73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfGO4lH40kBaMj+5s2sbtt/AxZK9AKamXF8MxygSOyN7eNW4al55p0I2pxW+x3IWM5De+thYgLJuCOgL2zAGSVpwsbsagl0kFW1bvSwT3JMa0RrIqTAiHMGUOJWn8pFxpUFzxOeC444MqXwfl5ni58nB2zKMp73Euhq2qfPX5zBGvf1l6NuBlykGW+EkqI4CDVGV48ZH1xZGeEl/WZd865ppCNPGajebWCHp4s7x37mMlPMq6Psy2ZqmpRelPDUCi+qscjboP1KljTBCN2GO+BylR736Mkc44GtC2Hc/obbG65ojQY5vA0y+oO68hUXSfFQvjRIzGobrpb+KX5IGdJZmxCAoiNZqIgnpDhe6L5NmcEwhd3sFSTDfxFhmNQnwtTEUgwSwy8O9CQefKJD3IGO1IssQXf2TvY7l5eF4IzOnYLji3Ksv8jozzIbY3/hOCO9Ph7kXkabpOJCLlneV8tCau6fieZ7Fbp8jkLG8CUzvyie3YiREByc+dX6cOfH0mg9HfMetItfDx5SryjMRuA4rg9Vzs/RorM0TmSdby1ZhAscXk5Er40UaP6zleSt4720XrpZFA4yMC1VLOyrGYzqewS5dOUyMg1QH6TnW0zmEWxLMI75A3mCvGmbjqzlfNbm+5aEx5qwSNkWb02PRFD3wGQgraCTYNGo5Mv027PhXrnmHvP+F8w61N1XlZPyB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QfFGnnDvJJxX8gfNiwlj2agwTZimyyZsDBohqNDATb1sltpR3IbhlQQw/xbz?=
 =?us-ascii?Q?NCQgxoWd3outoVDdSapwlL1dWMCsw42a+nCS10+ny5KSalyiJ5G0aODTsImQ?=
 =?us-ascii?Q?9VLzz1JOh+IlXGltZsUfjW2CUaei0jXaKLzTTGXgJdUQVlJB43ITgyvz92ws?=
 =?us-ascii?Q?XxFLykJ4aJLBIZelUP3nVkJp5nvra72omn9diHBM3OIRfM0I2RjZ6UUsECPw?=
 =?us-ascii?Q?WXcxtJGV6TUiQlNrPLbGDoedsijlSfdhkCNLOA9cKSje5fCiyxM02thYKGY4?=
 =?us-ascii?Q?VSBcdarMOHGJvJ31T/0cm/fXSJuWmPmi+Ko05FMR+OF5SXlZlHlzU0qs/U3L?=
 =?us-ascii?Q?UPBsETkJX6wUdNSeYckC7lE5Xj5BqiaJULhm7loCNO8XTEfei3/+mf0rMM03?=
 =?us-ascii?Q?glmZwUn2Mrqp9nbILlFT12FXoP8Xbg0snW8B4AIUcSbM6Cmia2xn8leOJOtQ?=
 =?us-ascii?Q?l9S3F5a3WHMA9x3AExaJ32bhE8zIGL64FxfPxh+6pfFn5QlEI8/B7v8Syb6U?=
 =?us-ascii?Q?XAyLqu3yazFOlGlwpggKdWW7z1r7mQr+WGJwuQpjalvh0PkLRCXBn8onhkDx?=
 =?us-ascii?Q?UAB5XvT/nj2BNys48kE0WK2zcL7nuP6rXkwloxG7WwoI3oRNIRb3fmxk3Ezl?=
 =?us-ascii?Q?dJMUhhGPpXFDCMDbC59Q0cO/nG1+SWPFn3ljc034gyjmHBAttWDjsewgehSr?=
 =?us-ascii?Q?IoM8VV11/sVcY+3WoXS4PdevkpJVC26QGBSuyeEi77njo6i4ydR45uBqJdme?=
 =?us-ascii?Q?K+O/Vd8+F4Y1Jw/Wkm4jWxSWb/79M6nW5RJ2nMePlq5nDzrW7fqqhjmnOdd8?=
 =?us-ascii?Q?XrSmEEZrRreyUUnm2HiHJ12WRRh7davSpqu1XuqeEtJzYTEPzdlcL5/2L3JW?=
 =?us-ascii?Q?ukS404KQr97/hUHKF8TvHAyEgY72OUHQ4CZ3KJBjOxMDkqMlxxBHaxc75qzG?=
 =?us-ascii?Q?WiAqPiHu629jDTu34yDxpIPA0djjA8msPmg/0QcoX6tOuJXPDV/r1mMLsnHp?=
 =?us-ascii?Q?AHJIzEFT3joWSIkl/rhQlDzwcFNrDw5yk5dxNtcdpaF0vUrIN4ZXVo/HpxQf?=
 =?us-ascii?Q?egZzy6NjxBgNd/0dWSKXULpW3WOVH5MpUelJvcS5+vKfqlOw8ltPlwaJaXq/?=
 =?us-ascii?Q?hFJNXL+unrBkqCBDcEsueYy7tUH5S5Ko4La1atvzqH7Vy3BvgeQTofWY8o3N?=
 =?us-ascii?Q?yMki4ebGzU0omuVI+xY97h7cF7I+sNQ9mJllvm5Tx74hPQne1k/JQkMeg2Ba?=
 =?us-ascii?Q?qU1aBdoXAZ/EFcy+NM1d14Pc7jxNGyQLBLXM9nqST8AtUPgOIT9BpB1laEmO?=
 =?us-ascii?Q?uTw2zlkNcFOsRfQ5qMT1OZ02?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f350ae1-bb55-4153-dc22-08d925e671c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:53.2601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEJMQX/GNbhAcy4Ar0PpxadrPq4P/pmxyPcn/4U50+8yMuvY5noMM3/FcdSmzuafFCBAg35S53i3eUlqRlpcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Enable gfx_off in smu_late_init for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index af3db91d609e..1e83adad556a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -140,6 +140,18 @@ static bool yellow_carp_is_dpm_running(struct smu_context *smu)
 
 }
 
+static int yellow_carp_post_smu_init(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	/* allow message will be sent after enable message on Yellow Carp*/
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
+	if (ret)
+		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
+	return ret;
+}
+
 static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.check_fw_status = smu_v13_0_1_check_fw_status,
 	.check_fw_version = smu_v13_0_1_check_fw_version,
@@ -153,6 +165,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_1_gfx_off_control,
+	.post_init = yellow_carp_post_smu_init,
 };
 
 void yellow_carp_set_ppt_funcs(struct smu_context *smu)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
