Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38257C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9DC61C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9DC61C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16ED6EDA2;
	Wed,  2 Jun 2021 16:50:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B056ED9F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqJANctfZDJmFq920YvMVcxuIdFRZuTExNySgX0vqOMqJudJ0y5USOT9xqt0EOdlQwxKML3t84of/36jnjqoAqagEwoc6/JJg/VPGNQT01QCi2Jg3PYz01HfEN68Mdre2i7LqVvCf+we6yviBqjgGs3HPXe4WzEDh0XiqxO8/BIUbAvGdzLg1OGkbiM2D9r3oDPRTn1vGMe9uDBkcp3DVi5HwFXuTaZq0s/XF41zclxFTVVNYhwfGjVFtexWrc03WocPMC5I3zqJxTrf2+kT+OjSXwGKvQw121DY5eyAuhVxaYN4qHCPgdhT4rgsVmuMl0yxc0UALD66b74uKK9tug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO8HTa1/H5wksFPZTMfpv2ZoOrDf07HbZ1NiQJ3b4c0=;
 b=aNnzVqjnX1c5lYVW5CP56tux/SduIMcdHbAXM8tfd3m03oU08xQ3v7pNiw6gd6aS5GQYMvRHMdOVGJSPy0o08d0wt7QRFSroNCctoXttIPnPfYinQJneNv0iXo2Za6y0Mdg8Cc4BwUHqIgPb3xeX6l344lom1lmXJDbWPsIe5RXRg2NjPXDEhDgu4Ndm5lepFKlzxapApUdgbp+y48CKfLAvoLesgbCkXcMzU8X5xzBP6wBRKYUjiSgIBv3aeJUiJ2P7rls3QyQjGu6R5Z8jpty2gNdbtopPxIcfQpqT/aPaRdWZ0Z/GBCrYX/EWS1Ag7aKJGFiZMMUQ2ptBkRE+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO8HTa1/H5wksFPZTMfpv2ZoOrDf07HbZ1NiQJ3b4c0=;
 b=P7hcUFS+LL2r40N2rQsWr+FJFkH8d5y93apvsFQ9oez5CIWtMeKJy200qSWOLZ2YWtu7GbS2/5xPFeIioRqj5CgAMYnTuNginhg/ii2JMkIx0XqPEZkL6QrVO8ByO9iheRgZX5aZh6RxtD3t70OLOKuoeYRs1iLwion8WZQs0M8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/89] drm/amdgpu/pm: add gfx_off_control for yellow carp
Date: Wed,  2 Jun 2021 12:48:13 -0400
Message-Id: <20210602164908.2848791-34-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f1d721f-22a6-4436-675b-08d925e67169
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB467539C6E84921322FFF463DF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTJFWl3EOrYEuiLE4iAzGPc9GbJejHrP0mITwn+95GSkZKpkS3RvzAJwhIpWvFrHHJRA9VmUdBGcPArk+5caF2mbRj/bZOHTTidKhR+/iIhHrb3GWvpmAlKOxbadAYyLqnX2oU7uctINah8AHy3N3RDi5Pw6fzLGG30ImK3b2fJkac/qflyuow4DgN6H+aHZYeFET1Oz/q7OG6kOS68TU1peQ+BlDYtGghh41ZiXGxElabAn8YAQv84lfURg9JOV8yrtjFewF2sPMH8cmjtoMlILiTN4mHJH5YLU6kOZ5IGhe8a39z6ylxjaYlO6ZtBF/jCnAYiGxnKCrkBk48Ur0zqDAm9ygcvDgPDoWQYv4RIXBzOd0G2HELoqr5PJqNbig4eGlPeEJxVJzaNIzqjV0fojgS6BojB0NJU4tlJlZXFN6/0Pn4GNcRIFvetZAnTenTioitx4OL4rLYSLKomlbe/E/ozw9f8IKVNIKgxbws6TXijnTRpGi42NgM7oiAoRo6+/l+XgXmsn9jvJMqk896DQfN95o/MowOi3SIajnslovFtMhGz0zeWXUkQpLvhYC3CR2auMX+Xrtj3LGP01NoWl5v4l9T9meWPtAe1Xns+der6r8HurRtiMUpa7bABYMuuYjLf2R3siD+sKcoCnZNI5rm2LR2g77/ZzfRsTgM3Xt2nUmKKvIZvFNc8Q5iR0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(6512007)(478600001)(38350700002)(66476007)(66556008)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xg9cGW1XRmpM0pHR9mVwDMY9XX7fv7qNxiMteypxmhvwJhMY107oFxZvSf0O?=
 =?us-ascii?Q?m0MZAkT6lSJt850RUdszazMRvCGnbN8Yjy8dHCZZUoOp4PCvLneliyrsgGPX?=
 =?us-ascii?Q?gYbK95fBUgDfwUQfH0Jmo35QpVhEfIUe/TiaVZCVouHIQ6qTeRbaX+e8OoB3?=
 =?us-ascii?Q?0Exu4BXvInBULV5pcvLFIo+z1YESeQQEMkPMImPhtL8t/evj2l/iFdcGUNJT?=
 =?us-ascii?Q?6QVl/Gg72C8uDkx+txqUAuOs1whRpJ/Apibbdo24rSZnVTlubKg/333d9gMR?=
 =?us-ascii?Q?JQxsH4rtjb2W4dxGQTGs0YBQGmmcHIBuIpui5N3fQKlT+8+k1BOMbZ89MTNs?=
 =?us-ascii?Q?IS+zVTlNKdjiOWzqiLKWLMwW7ms3+obuUgxm+7cak3yPJ4IRRsKI3dDzPNL9?=
 =?us-ascii?Q?CKRPkBfhnRqkEt/Vb9z672SMFgUEYwlMIcf/q0P0ITAzz6848F8m23pHf5At?=
 =?us-ascii?Q?+Z1v/jHP8p0l+4IWu+9ndVn0GLB3L8J1KCNwYI7wYjd8Ce0ceyWx3ySWb/Bu?=
 =?us-ascii?Q?WtORGHywiLpVhLv0R24il87SaiHSCfSxdOuEID5lO/ns+DwYxgl/1wwoWbQL?=
 =?us-ascii?Q?Vc6aY/Pwgurxb11YceiUbRqfQSrzRQV9ZL9QQUxHImXGxT1gqJw0wuWUhmNZ?=
 =?us-ascii?Q?Y8OwANWbG83u1A+VAu/uXEhRGFmGpCssQM14rFobDdjffUwUZVUMFCQPz09N?=
 =?us-ascii?Q?qCp6xfhg2RHp3s5UgZRhfHPHzO03rG4/oAV3eY1mWGK4Ddmpr7L34eKBoI9r?=
 =?us-ascii?Q?ZqPaaQeOsp/NNzWgom6EZllPMx5AQPSYP6/G9njNUqgOwFzitfnxNDlisx1I?=
 =?us-ascii?Q?MXQ3/P8n0dHhb6cj4FDdb9RFM1Hpj2u8oj3Jda/kCAj6Ab9UJQFW4U1dQGo8?=
 =?us-ascii?Q?ifyvevLIkhMjtVfc0GWVvdYyMw3Tp1JKdXoZG9BEiyNKHBfUIA7df1ZMCwNA?=
 =?us-ascii?Q?RA1qCqdFe5GVt2S3kpbRpDoikzcakQ5MJkhRYdCbzNtekYesflAwNuSQoEw0?=
 =?us-ascii?Q?3/WYZzcRo5g0OThBFOvz0fMwW6n4hLsgD9a1z36m1mDmvNobyKPMNiEsAfmN?=
 =?us-ascii?Q?y7eB9rQxGqbGnn9TOswdyhtSqINnI1S5fL1POc3z2WJN9gqpJi74kooI+4dg?=
 =?us-ascii?Q?vKlQOmSa78oBDDLOny+Jyijw12B4fFJ80SJjWe/ho+2zpWJzfwDlKC36PdZU?=
 =?us-ascii?Q?6uYt09ohdoKOEHju6TiVe8vH4f8oB/XHmgyvuT92bywopjORnifOHbeEw/0V?=
 =?us-ascii?Q?mVJbHqkJmewsYdOaSKTXlT2odft/oIGO1aaO+xpJrZZ2dtboDR3FpVY22mVd?=
 =?us-ascii?Q?2/7Zwutu1TFwdKvnYOh1BVLg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1d721f-22a6-4436-675b-08d925e67169
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:52.6349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dqAUSBtChUG7pXMFTRGev8mR9S7qm3w/Y1a4LZ9qkiui49bTfwiqOKoH3zpc23oRS/eBg8bpib1uGb7H/8hyg==
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

This patch implements gfx_off_control.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 21 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  1 +
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
index 9339c39c78fe..065f3d27b2b8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
@@ -49,5 +49,7 @@ int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);
 int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);
 
 int smu_v13_0_1_set_driver_table_location(struct smu_context *smu);
+
+int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
index 4e41c026a2e6..dfbb527b25cb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
@@ -152,3 +152,24 @@ int smu_v13_0_1_set_driver_table_location(struct smu_context *smu)
 
 	return ret;
 }
+
+int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	switch (adev->asic_type) {
+	case CHIP_YELLOW_CARP:
+		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+			return 0;
+		if (enable)
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+		else
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index cfe086658ce5..af3db91d609e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -152,6 +152,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_1_set_driver_table_location,
+	.gfx_off_control = smu_v13_0_1_gfx_off_control,
 };
 
 void yellow_carp_set_ppt_funcs(struct smu_context *smu)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
