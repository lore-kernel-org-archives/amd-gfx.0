Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F2BC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 22:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A78613C1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 22:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A78613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74E66E045;
	Fri, 16 Apr 2021 22:31:03 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBCA6E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 22:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXQbHyFJ00Rj7KjtdOIO++jxh3Moa5N7vhffMUZqSVe2V/zrndH7kef+9p8p42hW7/unAo7nSpIme4ric1ieOeH2V51NGq3OQ2tJDD2zYsnxiRzXbJ8ATq1XfsE10C2GS8XlQdGcWtvJizp1KbQI/GqqN5pXnr8Ng5hw4fv//HBDbfUUs7KHLZKWKoNC0/WvR++DesN/Aa8I/25MFeiUP6aF9DGZ3kfvoGgcMYeWEeCRUNqxRC8NhEUATto9A5Yz7w82cZn6pkB1kA9suKa5xzGft/2vo11AR7QU8ShfLxuT9fJhUfaWpc65OkviCgCsOkrqvPjnQPfvf1vgT25uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieSEqHfuv09/0tyjvYe5zmQhS5CfeFYo4rG4lchbYZ4=;
 b=HAl3hxnmGLikHzXst91JLO7HO2mXCdH3I3sx/TA2oRTi60H9Pc3OXMpLRL+PO/XgT7kEhk6AVS2Y83BUIG/CX+jjmaIvgt+Cn523z5ClgoHIntMz7E1O204e+z/ILsIpogkOB95mcOFC2XSO7mPgz92xR58NZCamS+R3h3K1CQ+rdbn0OXsfXgNAmtS6QxezqtTAZggJhzit0fjRSc4qYu1GelXmhF1zTMGB26INVN0AnVroUELYvuNIrymqMGnmQEc4ipSTygTIceq+FL7dLxfXuwrGR7BcV77Mqh5b8DRQ5uMa3t+gwMTI3mvas2aAbWugG3x175f6lwxSS8Uusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieSEqHfuv09/0tyjvYe5zmQhS5CfeFYo4rG4lchbYZ4=;
 b=4wBuLTH+X5ganTqa3/lkqUmI7JlUEGUJlIUtrXZ0aIWcrt6DTG9d6aEUasV5w3HX8uOMzx+jxkEF2h//x8z1nbjhM30AYJn3Nl+VDpr0B12FsfsM+ifj5kuPugVrA9+mNVLUPz6FcsP7M8wVvoGCXrXbZfjL4HRR298KaxoZc18=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 22:31:00 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a%5]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 22:31:00 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] amdgpu/pm: add extra info to SMU msg pre-check failed
 message
Date: Fri, 16 Apr 2021 18:29:54 -0400
Message-Id: <20210416222956.4580-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416222956.4580-1-darren.powell@amd.com>
References: <20210416222956.4580-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.190]
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.190) by
 YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend
 Transport; Fri, 16 Apr 2021 22:31:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77d57995-30e5-4fba-9c4c-08d901274fce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34522C75A58F11A600655E44F04C9@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ab2XKt06IojMBiEwaBNffEkOIYafOGNn+ap5aDbiKYsSNiWNqR2dthYPB7OU65IAGbLT74sNYLzVq0+EHeTqHDBXdSRy5gCwwMGpSaJuNyAjwyoiackSGVy+PGTP75vjUqv2g2Y519J+Xg1t6oNJD/qy5utifQg1vPGH9ClKDMjxd5rH5BkaTpwzyvn2DdtKEFoqBSyWlylxhl3Db6L6CdPPil1Mk1iDyAqBkFn9eTrU2Z32QhZmowVNrGoiFa+ZLkT41S0V1D+v3HtZ9dKqZAd87mctp0SfTwv+9CjPdW93eE/g8xZkTHbIfQu4eoh2t4I7s3aIwyBdqUY1HtCgENHMOkSiadLjXN6WVBgEIBaTC3g2gY3URnrCeuQ3h2sL1PEXDoDn/MWWqYTYsF0d2TZo9q4lsfMCcIc6DKL7YElMu9IBdeJVYrDW1w0P9QYtvUlBhZ8czxbCx3g3/0kXbVlyfSV60lU7CsYu7HjPXTU39ubX+ceRduc44S/cLVrnc+JYSnY/it64IKpATrZIjTbA2Vn70Rx0XYIYTTsx5jpQLr1EfxeoaHLJJUQlwNJLSeMYB9QAFL1MRL0IN5WiWs9p6P2TrISh+zLuE4kVPyNC7jUFbW1ra24bXDsmBH+1VtPc7WWTmmKXwFKK0nIiQaJknpIm2u74nAL6te8HSVRe2RyCxstxIFDae2rQscBP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(6916009)(69590400012)(186003)(86362001)(6506007)(6486002)(4744005)(6512007)(36756003)(8936002)(52116002)(8676002)(478600001)(66476007)(83380400001)(2616005)(4326008)(44832011)(956004)(6666004)(1076003)(5660300002)(66946007)(38350700002)(316002)(2906002)(16526019)(15650500001)(66556008)(38100700002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pFRhs3XjkxPkTvueLdsVn70kAblXymL0RYxllCQoV0XW/v9HZL/EaUCEdEj4?=
 =?us-ascii?Q?TsGES5v0nGH2/PQrm0bcmRI+UqbxgFW6uf5MaGTJvr4BNraVx26fdRK/VltM?=
 =?us-ascii?Q?rBB2/14P8eTU51E86oQfqHn9RRc6n0IZIR4Ljw8s4RL8DC9/eDztQJc4hYkM?=
 =?us-ascii?Q?E/+P9rz4AfNMSz1m/2Se/rg3n4GE5E607H6FdiEUqbBjzqD8z8H5wen9kkcz?=
 =?us-ascii?Q?IRq54Wglm0kjnIwkxXmeIFmigQ2Fe/LGSowAiESoJ6pXtie/PFP8GMZ1wW/+?=
 =?us-ascii?Q?xSYeNNfQJ4SjweYrVlcPb3jl+r0ScCWotIBrTZasDItcTBDChjkNKcYcid/O?=
 =?us-ascii?Q?eUPh57ZRAXeRjcUPrgC5RWLR9o67k9IPol72xAv/f39ajSBr0fkLaLda6+3O?=
 =?us-ascii?Q?UrnFv/CBsYiO5AgD6rGlT+34AJtPbYsMj11NMLJwhD4/940GQaWa4RmRBbbo?=
 =?us-ascii?Q?xFEe/7sDZ51NTKw1FLH96rc14OVdHb/5rUVJPiQNSDWybRnioIvdS8xYBSTr?=
 =?us-ascii?Q?ysP7RHTuWPAKCPlzkaZMpM9vjchILxc+ZqBZx7q3xAtZnrLm11KMdTHNhGst?=
 =?us-ascii?Q?dbNwaF+Gi69aVR0fZKKTv6F+0g4VLJ8GlR63Am7fW/bdxQYRyIDItt7Qokp4?=
 =?us-ascii?Q?1J04K9ivS+iTCdagKNm+nltLG2bcFTWnOgtbHtuOFaKl73W38LuXoZMr8B1X?=
 =?us-ascii?Q?qwTYDT8WG2tg0htuAq/QjzbYdQi2iSy6mjQgegyWmpnJOg1T/pxn1tTq92a/?=
 =?us-ascii?Q?CsRTuJojGuGWDakg1TYMtEPL+F0iGOh/OUveGJydctDvGZUvg65HJkSGhFvr?=
 =?us-ascii?Q?S9OhhSUJOnuDJJDrcvwtwuCaq2m8PlNHuvr4dNiACMe9V0hLaykd7jS/cvQj?=
 =?us-ascii?Q?stl0NQC03vhE/6LH9/MyzOR3+Qrc7BessME+Q4p2kjxhNb/SECR/U263SMUb?=
 =?us-ascii?Q?b1x0WOU2p21YLp4gZM1+2pkxlOsiXqS7C2kTNL7cZ52rLCxBi++n4NLD4yGZ?=
 =?us-ascii?Q?bi+YQUTtDSrJlfL0gs0DXwiBK5iOdQZ6M0c9OXqRmPjITXwM2z/osjvw0f2m?=
 =?us-ascii?Q?FncHZNIb13upbYbhR738U6TJaPIqS3U1YVbcErMCyPL+5EVj4TQrl0MPj8pm?=
 =?us-ascii?Q?aJODskSQjX2KszuBHQ6gKvw2Ll7dr/lADhnO02XDE9tZ905u3Jo4kCQdDlj3?=
 =?us-ascii?Q?3tKEdfRKO3rVJammPIA/JnihLvFJm6VKkUn+f+VBojat+wbLswilfhCun2vZ?=
 =?us-ascii?Q?dWaR7trqTAAudkKh9DVOIh/kAGB6vflLzfrspIeXb6FZAI3LHkol6tWRryag?=
 =?us-ascii?Q?rOCYFMq22WCiZiT4q5+1TMyz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d57995-30e5-4fba-9c4c-08d901274fce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 22:31:00.6197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeU88WE1/S29v531uDzvX5pA6VXskQD8grNrocvFuGm2n77v75c+GDaR9Uj04XCyW2rAvHLficW6bCEkokercg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
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

Insert the value of the response to error message emitted when the
SMU msg pre-check failes

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index dc7d2e71aa6f..5d1743f3321e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -104,8 +104,8 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 
 	ret = smu_cmn_wait_for_response(smu);
 	if (ret != 0x1) {
-		dev_err(adev->dev, "Msg issuing pre-check failed and "
-		       "SMU may be not in the right state!\n");
+		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and "
+		       "SMU may be not in the right state!\n", ret);
 		if (ret != -ETIME)
 			ret = -EIO;
 		return ret;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
