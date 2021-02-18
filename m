Return-Path: <SRS0=9dkd=HU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BA5C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 17:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D1864DFF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 17:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D1864DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D816E851;
	Thu, 18 Feb 2021 17:06:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBFB6E851
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 17:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBJyqZ6BLf7nk37ixZKL8EuSiO2w1ow9YwIzyxGiu6IyJYYjjKWlO2s20AYrg4g6bjkfmtieESvZBW/vlIU1O89JjSmuIqKE6udSi4XigO6fHQSDhMGmNiG3qkV/bnM2f/eAyrZCxEgaRjGtKv7KdvC5JIxIaLF8XtrR8ymhnxmKFZ9J6pDsapPZQ9iLrhhYu5x2BaI9z6gJl3/73zGTUoQc0Zuo9JUQwvXhAFNpzzTncuoFbRpORFZHobiKIOO3LW/BKnl+WR094j/b7eh8gDRHbnWZE5BZDGtHb3hj1fOgNWWCG1JcZ4uD9/rs72CY8zlmI0ztMoHBC954cqO1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO3ODIgsvz0qUuhk2lRlMo//CQ7GZNSIeUdJD5cpMSk=;
 b=b0ljAldqMF9a9PE+3mNW72ntvVEDFOYx4z9HYBqpeBcv3MAIqUg6KuxjUYvSOtt8YUXb4Os9p3Nyw1U8euFCqjoANesnD6zgGc+A8mScxN37bp6UTb9+jifGgpyx75tFEfAijs63LLNufK02v4c3NpgkH/YBiRLfumpYWQeCQX6ayVneWNX6Q4Q+lMsAWhqu78AG2sSkTIp4iEaQ/qusJgfthdYUN/mMJjtyBhQIhTEF4zEm3xqTiIv2PDwdOsrd2zv7cLGGCN4jK/IiGqhvLUQ0aX4W8CyMDvMZppXPgXfR7rENMpUkhOTmhNJIQsvif3deGVPziGj7w4plwIwoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO3ODIgsvz0qUuhk2lRlMo//CQ7GZNSIeUdJD5cpMSk=;
 b=fX/OUlFu/gVxhcZpy/NZ4Ec4uk97fwSxL0X+FaJ8F4OPmFApgkXQIbYsbd9cn4So2MsSNAgUFgL5fF5tF+HgQo8w0Erkd7k+1wxc7KLgIf0jmdLmfwn2VHAg3OojJVM5DTIYaI7ML2BA6dJ9So3+ce160+na0Ac49UInqvqM7sA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4826.namprd12.prod.outlook.com (2603:10b6:5:1fd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 17:06:49 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::b877:1da1:c4d4:6235]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::b877:1da1:c4d4:6235%6]) with mapi id 15.20.3868.028; Thu, 18 Feb 2021
 17:06:49 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: remove unused variable from struct amdgpu_bo
Date: Thu, 18 Feb 2021 18:06:36 +0100
Message-Id: <20210218170636.91372-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0945.namprd03.prod.outlook.com
 (2603:10b6:408:108::20) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend
 Transport; Thu, 18 Feb 2021 17:06:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81d32dd4-4df1-40a3-9842-08d8d42f9459
X-MS-TrafficTypeDiagnostic: DM6PR12MB4826:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB48264C79F5CBFB1E3D7012A68B859@DM6PR12MB4826.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQjWhMcKKB6j+IikuHlLRLvRoUYKRN1X4mEtqRoJ4A2eVitVqsc+fVW7pbCJmMTDpb/Vw1cHRWfysGPeOrUveC1vpmB6xKJjHrmBAsgosK4csErCPaB5cX5etRCZpLRw02p+19hHLpD7rKzUBfOFMM3EWSDZdb98aRnvVQh/oP467mhMWHxLd6mafEA0xm62q0XQ6qmKqM+Sa3CePxLwzpfjK2faKOUTHJ8KjWy6EsS+x8LReQ49pS2KGO+sGG8Rk3BDfjVljZ1Zrjaf9uAf++c9M+Pc+7m9dcFdlZb37+jLhSXJ0EnFRz3ZwBiBlbtv676uMXP1YEaAnnmlAVYJAwYzbLYrD8cXq26/+y06AY4Urbp3v/tMhfKiyFxuA/IRNTx6moXRlN8nqtfUWd2c+dgyJNt909IIBY/53y/Fy/MzjSQ4oov6HhvZrjlFFQl4K9X8+ebVdoIt98YJo/IvyRIJLlgYhktddvMJEOPWKKC8dnX9V73yx0Gw/A2caeluofH0Kv38rlSdWKzcBeETKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(5660300002)(956004)(186003)(4744005)(6636002)(6486002)(66946007)(86362001)(16526019)(4326008)(8676002)(26005)(316002)(34206002)(37006003)(44832011)(66556008)(66476007)(2906002)(478600001)(2616005)(52116002)(7696005)(1076003)(6666004)(83380400001)(8936002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BhcrLeEqEQilpOm8HyVT7qvywf4pjNVDgb8pkjEFF1Npi30ghd+ekMOJ+cSh?=
 =?us-ascii?Q?rrb9bceg7Y1ugscXY/LPIcR8McPCxweRCVIa4nLCf0gk2zb3AwuaDW50juMy?=
 =?us-ascii?Q?XIrcnbQKsCEO3mT824tpTewQL1oYHmKUbebnISIY2FxZ79vP7062b6qfwjTc?=
 =?us-ascii?Q?xIM5JaxQxBPJWmLkSEnzS09hHvfpbpzbTwThd0IdZlfI94ujEFCijB6k32bP?=
 =?us-ascii?Q?RfcbEWKIem9XqXZopqM/tfWbGSSfystxXgluJnj175DdK7Q90uTxJGhXJ42B?=
 =?us-ascii?Q?P9b8cFmskyBhSCVaV0PSr13MQqvaWefTlUiMYxJvfVKKIWPXQNfhYpdN3HGQ?=
 =?us-ascii?Q?3v5ETy8IEWa4cex6l7GA2D1rsB3SIXdw/5HRT2CUwb7dfyvkY8G41Do44qIU?=
 =?us-ascii?Q?cxzFu2q/vkWI+Moi5b/Kyej/0eQRePrRkiG8BGaMDhzO2pgaGvk6R8oNUwWx?=
 =?us-ascii?Q?IID8vnMjVgcLDyWkljztRN4+8taiI39up4ZDDY0QEC5nDfz/eA0/OKeWfNZW?=
 =?us-ascii?Q?/lw4Lq36UpGJihbAXOLPevkSpsVlP6K6xVQPiiav9zO39plrX6VfTYm/peT7?=
 =?us-ascii?Q?upZkQZ2z/oVVo3TnyJ7Nk5vqbXTjHSHb2YTAXrFOwF0LapNAPuwDI00pH4eg?=
 =?us-ascii?Q?iT00eDFEwNvbkWPuyR2RS6RFyr8F/SVmn5LMv3/facFjxWUFuUmXcktRjOVu?=
 =?us-ascii?Q?F9Vj8HPvwkAsz9WGWygxSU/OfM1D0g574M+uUxFItQSE3vgA++nCfwvRMtAf?=
 =?us-ascii?Q?n7AWkh1oJhgJ6QRSlEQgxe7FV6QaiHgLF+cJL0Um+JhlBKsFpNULNIL/Y+IG?=
 =?us-ascii?Q?+ktCGayUaKfNrT4f0a4roq5GA7xQsghi9JzdE5/oMReosDJV/lOYl43vcRQ9?=
 =?us-ascii?Q?B37ma1DS9utX/7AuZ0FxB7qKX5lajWU4rBvTmgxiRnQkh4+A5WR1d2MK+lL5?=
 =?us-ascii?Q?29SCANy5UpKcfE01IM1qhYmge4GdRU9GAd9AxWnX0ijJgl8ixpMxDas+yOQQ?=
 =?us-ascii?Q?N6cqsA+C09SR6nIGx/D5Sa7Zh9WSO7l2oIPBxKRGlfCemS/UE67nfpDQVOr1?=
 =?us-ascii?Q?AD3KbgqDJoyLKb5R6ycFhgAi/lwdicPNmkgMErc/QXYKe0a41bqAdNYBqFe0?=
 =?us-ascii?Q?+R9B/P0rX5PX8w0gRi7/rnwnU3TYnzYMbElTA3U/QBqMfZXgjvVeWRzIqPRL?=
 =?us-ascii?Q?JkbZrUdobEd1HVnDT5TZzOZJGGs7vnD2lxFcZZaVuzp8DP3USXUQ7QpB7h2D?=
 =?us-ascii?Q?Pj1dNkZ1dUMOCXtx/8kg6cdmzkMa/zfu6kTJ+0RLk+qNLM6j4dsbHbHL8BGT?=
 =?us-ascii?Q?eCUVq99IZfte4Jxz87M7pO1X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d32dd4-4df1-40a3-9842-08d8d42f9459
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 17:06:49.4094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JhigtqjELoZc0gW1SwI5b08LB9NUKX5Wlj1LjyxfAuOAjzUL9jTLvFC1Z9TFzuGHlspEOoSvhPU8epaeQp2cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4826
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 62914a99dee5a("drm/amdgpu: Use mmu_interval_insert instead of hmm_mirror")

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 192627d35bae..8cd96c9330dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -102,7 +102,6 @@ struct amdgpu_bo {
 	struct amdgpu_bo		*shadow;
 
 	struct ttm_bo_kmap_obj		dma_buf_vmap;
-	struct amdgpu_mn		*mn;
 
 
 #ifdef CONFIG_MMU_NOTIFIER
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
