Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E99C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A59922CF7
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TqHm4tFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A59922CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D720E6E8AE;
	Thu,  6 Aug 2020 09:43:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA2C6E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 09:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3UoOu0mQmuoldWQgWgI6R7Vw89UxOKWLtMsPPH69JPJl6EqUkqoMzwJ0IgboGvPpH4ZextwmJZLXqnkrUakT+HEChM9CV3rXR4ktqa8hHtuDTLZwtjlm52La84pNEY8k0wRuWrZ8ESPE8Ls0fxcJ/X3rQpKdrSFu09BE/h2NdgVOsrvKn2V18p58/0fEeff4uhArui4FtiOrABmeB/qCPGYjjg2wCZL7fRBZbQ4dc2eba1kqKW92KZRSNJtxP0Tb/Vka3lfaiT7yE7gU3BokhV9InYaspSnc6XEIrD962tqa+Sxva7CQ2Q+tr+gVvkO0IhBJGIdbQNxcq9cc5D6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZow72oeGV3GygxUMdhWAkCpKbBAA08y1/OKRA2dGh8=;
 b=YymDoZHqxTipCgFgxQC90z5NR6rO5npleMqCpcpRon3L49y5d9E/bj4IzYkCzwNV+5GAdYKOMlOEEe+WIs5VUzuH8lZp3Klfk1dcogyhgHNbgmypbF3jjtpDWln8Hw62bJ/BaZxsSJ6Kp26hnOIT4THcoxCdBpCEvkXANzDL+gj1HKz9OBU1BpPf0XOe59OSbBBVxL3kxDEPUOrsInXnDUqZVYtmH3hA9I9MLDZktpw39vUNFLAi/myek0AGecZFTWqa9TaR6NWER7l4/gtxerYX0vaYUKM0Sw/xiTnTAawhXZozw0w5Ean6PYBtVlNzYdNVBPs48DtYQdhYOlvYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZow72oeGV3GygxUMdhWAkCpKbBAA08y1/OKRA2dGh8=;
 b=TqHm4tFKNptgNrv8uekzFn8saRLrS4S5FVRTpfeW8nmupDnapqMxatCYYJSGCFW6enomrabtzqHxnnc60HDJCaFG8zzkcQaE9+puqbyAGGXhJ92tDoglKUQuC0MgU4Se5irfwhYmfiY73LagGBiJB5AsQs49Qa2vyW5FVNxJ9EM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 6 Aug
 2020 09:43:37 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::c83a:4059:70c4:3911]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::c83a:4059:70c4:3911%9]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 09:43:37 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: use mode1 reset by default for sienna_cichlid
Date: Thu,  6 Aug 2020 17:43:17 +0800
Message-Id: <20200806094317.2022184-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR04CA0046.apcprd04.prod.outlook.com (2603:1096:202:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18 via Frontend Transport; Thu, 6 Aug 2020 09:43:34 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0715177e-4440-4d6e-5f6e-08d839ed3108
X-MS-TrafficTypeDiagnostic: MW3PR12MB4428:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB44286AA33BE85F9F366A3F96EF480@MW3PR12MB4428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvuX1t4zkP0+x7ovxqOfrc8iNq10YcRUlwF2PR1rhEIw3PVb8tvIm1+T2agAPqFs9jqb9OSYxh5OGt+Jsn/WGHL6bT9+Pu/HQY1JgqGKJsNGpY9k5AaruFvYM53CjwvS+Y3YRYpN5tfoMnd3Z7y8MM4/lC7M3N2H1ldJOmscyWkEE9z6dxTxfGVPmgZSVt6S/Y/DoMV/tEjxWQFfvOpjZbICvQMt4TnQBfs02wFxBrsAPfvACs0IkhEmRMGLwX+WJbGFtPRi0bE2cO7GUJzxkzLvdgpm1uTqEgAriCny69yhCCMrU87URnzenP7s1UPs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(5660300002)(66556008)(86362001)(2616005)(956004)(44832011)(36756003)(66946007)(66476007)(16526019)(26005)(186003)(83380400001)(7696005)(52116002)(8676002)(54906003)(4326008)(478600001)(6916009)(6486002)(6666004)(1076003)(316002)(2906002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: e7thl9SuC1OfAwgZXXVuBSfeLODgcJUft5RZPDBxbiLwfUHmyjq9gPOnTQ/Kb9v/dWLibu8n9wnWMJNZDMReNNYPipR6tZ4eD2ptNf6hj/DMqivQxmfL42lTZANM7ztL5+KO9XZT2s3qWyD0faMxNBvgMz2/qsbXBLq+O9Wq8KZQJgsexTyHh3JfX6svU3viGRCDvEvIIlxCOBeVl26agd5USksuJXtThAIV5e2JvCvhPULb5fPkyfMKhW5hStAOROfrRgJZi37DuTbPzjMHWbLDnWM9R379vJVnG0OqkFWKrkXAikXkUx581D/knhP38nN9rZaoTsHkT+qJt4TbtjmlwC49jovyN5X0RUAkksnVUBNYfZUDz/+mkmUOS/pI4FQJKqGWJK60FO9eeQuTULPgy6rOloWL25q1ISjk9W1thqd7k1aGMlQao9RmQgg/7fuL7Rh3MMz0UtOcA8q9Nv9ndKdmwU4DOW4EgC21jCz9TX5LNUj4r2btFFn3u15A8+9FpBFcaEPWE3QMEpafPAyVM8FpzXBLFlnkFhkeRz+BqmOf2OX3ZjhIIUwrQMY+LtSgrZx2aobTIs2g0YEawDCySiUnpvaw5dhJOPJ6DetaH+t5VcPLeLGpLDiXI0nWpN94GOla8RKIMYKnf7ph+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0715177e-4440-4d6e-5f6e-08d839ed3108
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 09:43:37.0777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kui8jUGGS7yUEoAbE/df1J2qQZTVWCnQPtQiyIrsIUyuYPZ4b02qrdHjJgn9HShg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Swith default gpu reset method for sienna_cichlid to MODE1 reset.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I775e5a66bbac474f65ca8c999136ccaf9c1dc14e
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 74d02d270d34..da8024c2826e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -362,10 +362,15 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
-	if (smu_baco_is_support(smu))
-		return AMD_RESET_METHOD_BACO;
-	else
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
 		return AMD_RESET_METHOD_MODE1;
+	default:
+		if (smu_baco_is_support(smu))
+			return AMD_RESET_METHOD_BACO;
+		else
+			return AMD_RESET_METHOD_MODE1;
+	}
 }
 
 static int nv_asic_reset(struct amdgpu_device *adev)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
