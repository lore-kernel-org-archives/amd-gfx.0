Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE09C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 01:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E204D230FA
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 01:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E204D230FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA3E6E7D1;
	Tue, 19 Jan 2021 01:27:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F366E7D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 01:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVRuiXk7vngRuqIku5kXXfdqy/72zg3jgicjRNqqs69fDrbNHbDqL6WfWpafFhg00G+jor+RRxpEc1Ow3eHzYZCJWsxxj0TcvOjWkUrs8bvZdmqYNuMUDkXaZMccOGL2dMiHglnMf2YlE4qYaIeWLqVhGQP6NjWejN8zNdyTW5nzRiVtc1iTw+ldYVZK+8CgM/wBch0mq6ITEM8oN7k8ToROdMjUAgVUJarMQEf8dr7H6EdKcKuqXytyjBBcupeTDIsygBfDndkjzWVnTILGMRYeLbZvd1qgyT5NR8t1bbOSEMYt6WP5YrtqEt+MISc4xshrMqbA3iO2C5uDOs9UJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcGooDIQ6IZRVk28cv+IRi+hFD+uMUAoMpaH2KX3tEs=;
 b=TrkpYd0kOuQLbhOZBD6ANv9GDVqe52/zGplOOmTwyZUksUod2KMm0SNBTzrG8jRzlx9fqAUGd2PWK4OEghFLkgeU5JlsygKwi1HVCaIql7ymZtoKTTcDzWJUfwKnbtdpVol9Hz1IWNaURpugic72kRJr5E1IY8e+A2xjjbprLWMaSTAMNUqsrmpX6frzkwvJMrb8HDODTvII1UxFf5t6jgqhdzRBlPUULdHB77l4l1lYAlaahcG8E/rTsAwemKjfOyfb1gSNiL0vJCpSE5vaIsDiUGmOUWcNsLtY6Z8JLYPvpwJDK4penQbEZF/GiXfteMXwzrJkK8a0XHocUU7LHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcGooDIQ6IZRVk28cv+IRi+hFD+uMUAoMpaH2KX3tEs=;
 b=rWS00auK9npKUBLfolZd+QefWd0uXiem3FDdPcF8fCEzYTVnZ9gRYUIM4BqsnarcorHxVaVObGla+bZk9LpQZMFfnEislhCmadNdl9D2NODiQCuZid0cqnR0xzTWN9+9VzPOdMFaE8d4mdhmNUrn4Y6XBbDt0qA90Mx6MY7nDTk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB3890.namprd12.prod.outlook.com (2603:10b6:a03:1a7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Tue, 19 Jan
 2021 01:27:29 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 01:27:29 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: no need GPU status set since
 mmnbif_gpu_BIF_DOORBELL_FENCE_CNTL added in FSDL
Date: Tue, 19 Jan 2021 09:26:42 +0800
Message-Id: <1611019602-16557-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:202:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3763.10 via Frontend Transport; Tue, 19 Jan 2021 01:27:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26b15ab9-0c45-487b-9a09-08d8bc1962d4
X-MS-TrafficTypeDiagnostic: BY5PR12MB3890:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3890C06D02A9F3CFAFC3FFBCFBA30@BY5PR12MB3890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7hpTOR3k3LjG6bFE+oXNDj2TwPbcu5AT+hgj5Ut+63Yr2KlldZkDIzo3b6ZLkEwlKktJbF98pbuAwYNW6dccdsKjS4SHhKNcjfuW5lIdJP/DBZKhRf5+qd71+qM3XXW8uVdajzXhcNzbVa3qCASlDCm2xnTaK6ypBoMQPFhpwgPWfAdFxfNtxofmJCxJicclmlPsnfsjkqKZSqBxq+jBteQoNAvctuYFnzVDA7Sn7WbQ01hGH0cZ5D3GBrp7SEwHiAjyDHgCiIhESTox5Bgn0GVABq26WYV9n1sfzLhGGsumbIybK0Zc8STLZO/vOfVGKZNDFL2iktVnsV7baqOK6/ELhPaabQafrSEspbbwMoWUyVenC8t+KhtmUGkastaUzhfvzGzEuPFTNU253z0tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(7696005)(16526019)(8676002)(4744005)(186003)(6486002)(6666004)(6916009)(8936002)(478600001)(2616005)(52116002)(956004)(316002)(5660300002)(66946007)(66476007)(83380400001)(86362001)(66556008)(36756003)(2906002)(4326008)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y9a/+ZyzQ7KdndE5BLdz7LgSO0KQBeNPI5TKVdgyJb2Y8I0QrkH80ZV6At0x?=
 =?us-ascii?Q?RQQEdLiCLYenQbZSWfsfCRj1gaqGBX/xYRD3Nz+5m3pyb/t+tX2AwvJRbppC?=
 =?us-ascii?Q?C9gAkZEDph2WdWzyJpvIinwWS8PLDcyw0WGBfUC50x1XU/xaBg8r1InAhQcI?=
 =?us-ascii?Q?Ul0hPPJWRpOzw3qxWR7mf+Y7sN3KZf9K3Hfh425+UoMsmo9srwNXokD5bQcs?=
 =?us-ascii?Q?o/C7Hu+3g70nyhwbffwFq4N4KZ1X9qfxOM5aeLt60iFHzT88uX+GFMedslPX?=
 =?us-ascii?Q?yueZPwaJYRpmL4EaibCVCEOCh53jY4D6HRsbpu15puMH2yWVK1vjkihXT2fL?=
 =?us-ascii?Q?nENiJH4vtN28CJN4ZGUysaV6ZblbZE4xUbjVZaIIiXaMFKUT29y0hv9c46+z?=
 =?us-ascii?Q?bHaVNTf+dqC9zdUhFxs4wkrPCZ9WYn+1TKgaLEuxRXNDubdMs2L0YoAoWzlz?=
 =?us-ascii?Q?YVf5D30VSlKYlqNdBiaTT8YP4KQeYdls/BSNVjy5ewjt7rq8tb35KhnfWJsk?=
 =?us-ascii?Q?PrV2XdIZ6FOCgPNuJmbjAcp/Gjy3a1VuWiIs/5QaHz06f/YpEwc9mClsqSUt?=
 =?us-ascii?Q?31NKTRBtCnR9mk259dUtGHYDVqhtaAhPwmMorAmdV6yGnEI85OYduQ+bbOCq?=
 =?us-ascii?Q?Ks+Wvg5xPoWmCXCbhruQnL92tY4ZKwRk/TRww9bk9UFIc0hRqfBtMntSjHKY?=
 =?us-ascii?Q?9iZE1RpMcMLJK0BF08Wrt1wg+giF1mbccJis7i6gZN1U+nqQr0wYmaSzk9g9?=
 =?us-ascii?Q?EeU7oJl+OlCtK0FozPW5Xw4UBHiE57mVCg5hFNLWmsMY4yQmxGGJZAmNnboi?=
 =?us-ascii?Q?Epk+mmSBSsO9OWNaaK+ZdIwtZF7ekL6A0mxe0pWHPVnBINaRvNkh+vSjZWf9?=
 =?us-ascii?Q?5agwLJNA+8+zNwosgGSCAIIVhXd67Kf7oBbngxL5vB4XqR8yy2pWUXoYsfef?=
 =?us-ascii?Q?fY2suki2xLvKtKMFn1Hl5bfw7YUvhCfTN5NHylmE4TbNUwT429TK3E2tNwKm?=
 =?us-ascii?Q?UABN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b15ab9-0c45-487b-9a09-08d8bc1962d4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 01:27:29.4227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvydkkrkBJv+fgP0uAI2aWNYeuiE2h5SCRh4O3kr1bhL+XmsexkT1MRTYPneTdyC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3890
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Ray.Huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the renoir there is no need GpuChangeState message set to exit gfxoff in the s0i3 resume since
mmnbif_gpu_BIF_DOORBELL_FENCE_CNTL has been added in the s0i3 FSDL.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index dfe4eee..ab15570 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1306,7 +1306,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 {
 
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GpuChangeState, state, NULL);
+	return 0;
 }
 
 static const struct pptable_funcs renoir_ppt_funcs = {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
