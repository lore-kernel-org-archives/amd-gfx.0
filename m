Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3627CC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DFF222B3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DFF222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02B789857;
	Mon, 18 Jan 2021 01:55:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1DB789856
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 01:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWOtiDDXDQZah89ZdsKLTIc3vFKM1DMr9vjbORUtKww9qSPMBBA+B5o/XVc9R1VdHfgnfKL5R4k7QKdxsOtJpQ2GRzfIOMzT4TR336GYgCVJzM6HLrcY7UsAyYA5S4oYqqRCURggbhGx7iYDLIhV1G4vLky2fGklhPUqrWQPT42dZY24Jmg8Fod8KSOl6BhYRoENxzIieiyIq0squGf2YGB8DPo/eVnmL56gfXUt2crYAtnePwp/D4ywpwGiwrSoEj8Q2NcplemgPBJxMkYzLGhfZzVM5/uDD4LkidOa9zjLPl/GkkYpVcUgQ9nUCS0TBTOl6gcQU0PV9DFNzopSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e5rhcOjA9Lm+1kV1VqnbO7cutK2PpEklwUBvSMMaV0=;
 b=WTIi5EiG71nV9+iPdDDfHrI0/z70Km6YhL2YxTvPH+m3eD+kNTwqwxR78SnV/SFVXuWYscwCSVU7Xv3BfcQ+52GlxJiBjlPHM+LVsSZdK17Et29p4aQgw5p3Q5Hax2p/2svGxjVtitDBKy2bI0HawFBLuWdCOEp0+eQQnkQ4+b5jiNYc/WWMhCRMRZjjfto+1QKrFSqIBN3yUzAHCwj454WFShtmFiNcTtmJKLsTddRmzC3H2U6L7w6Na/K4tXZO/tLvMe6i2PlTov2pDjP9zozshDCLxW9/2OlDbAWLLHCOz1qS3IZeUY137108xU3TvJCu6ldD1jCXoNwoZqv1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e5rhcOjA9Lm+1kV1VqnbO7cutK2PpEklwUBvSMMaV0=;
 b=MVZiEAuDF8abtZV/FqZcZLpVdWHfbgD2DXvqmIDAuYWrhCXO3AQ4cHwiKLmlDuCEgvDt2W4skKCkx75U+phypgRUZYgbkpKrueerOsuhoK6ftFrbpz0MAwT7VhO7MlJsA90/UbTbDJdKmTSHrp8H+C5cMmyTvkDC9Dj8r+2H6Ag=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Mon, 18 Jan 2021 01:55:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 01:55:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: fulfill the API for Sienna Cichlid gfxoff
 state retrieving
Date: Mon, 18 Jan 2021 09:54:52 +0800
Message-Id: <20210118015452.418724-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210118015452.418724-1-evan.quan@amd.com>
References: <20210118015452.418724-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0062.apcprd04.prod.outlook.com
 (2603:1096:202:14::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR04CA0062.apcprd04.prod.outlook.com (2603:1096:202:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 01:55:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82facedf-5f49-4193-61db-08d8bb54195a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4058C50E41BCD07EBFD88E83E4A40@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DP/htvQcBJoKP9ILcd2l6THaXagSnaJO6JCg/ZpiF2SuOjGOjTpXGLBHPg2fcvzlpO1fSsXk2mRL1UNQxaOjB92mg/AkCIqqaJ10bGiAo5XCBWugzQMTNG95h2S3EhxT1jg6W1KygT57DynFhw0DzkLkfjrM3u8Zu6dXFSKET2svh0QlCMP9g0VdqQ6gw6z6UH2higZDyvDkXuXSghRIWNVGsWk7Bnpp7se6fGoWKAFSIGlac+UVdUO0bRxL0Sk6LOiBw0eU/Fu88/h2pMWD3zE03J9dY7PiJQ1EcQXtHnYM9mBlybKB33M0LQdMVJO03/LW9L3qe7bRN2KKIqbxR4Q5X1PBkssGsHehAXeJG2Fu3DZdYSWDBQLxfPIw/6l+Dm3Ayp0Par5w9DmkQhH0zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(8676002)(2616005)(7696005)(6666004)(52116002)(956004)(316002)(86362001)(66556008)(66476007)(44832011)(36756003)(4326008)(478600001)(2906002)(66946007)(8936002)(5660300002)(6486002)(186003)(26005)(6916009)(16526019)(4744005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6svpRCdsXPN3iGm6Rph1qMSdEfjfSsPYk8PM01SBQmdKokqVYLBXIfSw/D9n?=
 =?us-ascii?Q?sNeZpRHdzU9EKah3orfYC1cM9UZV26H/4cTxRfNE7R2cH597Y7stxZijmDTW?=
 =?us-ascii?Q?eIA2xMmEG9TOxnsOJA8gDWaYk/3QfIldffNrDlFcVAwHUO/u5urMqTZxEujg?=
 =?us-ascii?Q?/iTDXrMUR5wBezFPjZwR6XSZApb4ZrueZfkFSSUjGCY916MZSv92rUR29Hw8?=
 =?us-ascii?Q?mzElyXRGhUGAH7n1ybrRozrDS6gUqPfYLNPvogeqeYDzaCSQhoqBsuBK6HNQ?=
 =?us-ascii?Q?M4aTU1uI6mRBzzRkFHoBUHnnTTZF3qcC5NQ/gxiqs9HnVSwE/x/ZIB2wgtcc?=
 =?us-ascii?Q?J41c7PKzovo0/qnmIi31diTHIBbfl7tD9Tprf3pxVjY2ylGhakh5ZYa5tTyc?=
 =?us-ascii?Q?jnihdQ74UctOax0d3SN1iXAPHus0j8bLquVR0xDu+uT61nHWJ10x64rFT39Y?=
 =?us-ascii?Q?X0Pz9vJCfQhqyIOxqFhRX2daX38ZzfSiuTGFbIyfkWTwNNKmLa67sdbLKRKI?=
 =?us-ascii?Q?2bp3ealmLMtjfDpwBUMdCEFs4jjmM3iL0FyINj8+pQ2+SxU2XongySLpoBMG?=
 =?us-ascii?Q?/sTWdlFZwRyNQX0Ir6KQux9GmnPXkh+A67GnEwHfVGjXnEV2FSgxRQbKZC8v?=
 =?us-ascii?Q?155ZUhFnfwPJG3upniIfJgwwJaDUjCkJIUCE9zdvwrZftcraEY3nlrW2g6e1?=
 =?us-ascii?Q?P1Xo1H+CZf6QJjVxK4KLMvbmO1Zy08bf3P641VxG8obYmPEVgI+Ls1K7/BCT?=
 =?us-ascii?Q?XECJBWOzh1YDxNtuiBBM3fcLNoqA5vT5GYZZB8Ra0YQwDvIUwUoiL/kYzoEu?=
 =?us-ascii?Q?tXGwqa9uO6St+OTyA5M+5sNVVo1T8S/v16yAmXbXHUeujvyDzXLL53723C6X?=
 =?us-ascii?Q?7kttR5jTCzE6XTsmNGkdTx6SiUwCuLoyyjwJtIErOoaXuFT2miQ5MOA7M/Jc?=
 =?us-ascii?Q?SeVZCD1G5UQbrombXdT+u+UN+i4/h5SW2GU/jTg4TV+UiRij6IBRvsv3YK+N?=
 =?us-ascii?Q?N4/m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82facedf-5f49-4193-61db-08d8bb54195a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 01:55:15.4043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4a1PFvCpm9Ahq89/4CTRQrPQf1xasD/nJG5z1xja2z8gFR4TxP8cfDSAPP6VqeT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Guchun.Chen@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support Sienna Cichlid gfxoff state retrieving.

Change-Id: I952b652a41a33cdaa05e5294b17a8cfa45a18818
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9ac589248ba9..c34110af359e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3332,6 +3332,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_fan_parameters = sienna_cichlid_get_fan_parameters,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.gpo_control = sienna_cichlid_gpo_control,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
