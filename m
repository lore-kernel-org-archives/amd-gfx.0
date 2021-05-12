Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A6CC43611
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF21613E9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF21613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617CB6EC7F;
	Wed, 12 May 2021 17:32:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C1F6EC7B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgSD8/5s2qUunGbkrmRo/GpVlphbzK3R364ZB3InqUQj3/nkgmWPUoWlNOJFh6BCMdZ9ZwsoGq/UGiyn/zMjCBy/zCFzkVQ1W6YLJ//D51NthfokZh87alML9xzUytFv8FbL8uSp1bjAJcJU+jxnx94DyBmOnBxQV7GmYOabRmVmOiJQflydAkVU2OvS6qEGxkOJVR45PdgbUixnZk/a4kYp5ALa64ytzlS2doTJW8zRwnk824l/7+FzqSCRthKQ1InXGR8UFqTSD/FSPF9bcmz8goHKqHhsMBU6vEx53gmSSo4vegsJh5l56toKFo5oIoR9yOJRGfaMUW6KGR87VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmgmbErLWzE3x8UT3XxLAu/vk5FM167Gc8k9hKsy5kU=;
 b=HOvneFAdTX5SegusTeXSKP3/0+31SOSp2h6TepS6KaHF4fELW1qltuQugxwe5x6Cxy8BEiTcfF7pYE16mPHAVuWYtDk8UG31v+EcRyNfeXCIjECk7jaJOdrtD/rk5VqW5eCsHu+dQFAsQlNOeE4zN1UqSt25FVSRT9drN1GkuvSCKlmQ7yN5QBLQYEqzpoKvjtkHvI5IS1BiotlL0cvaJ4mjZhhiJ3TEhy3xyLWydVmQKY4GbMn/gDkepzgo1nGG8lm3AsP+fSIkB4Hncn4OSIULs8uHmdljNjJYTMMKHmA59Q8tjFdOwuRvmo8CiowlyU8y+qPI2fDE4qYsQwuRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmgmbErLWzE3x8UT3XxLAu/vk5FM167Gc8k9hKsy5kU=;
 b=ZL1qb+gKd1ECvgAI7QMeqcQJOul5qf6b2ISTD+fmBrW6q7LfjMYMER5E6rGt50M+vwUlR3ijpQmTRXit9EWBaVuVh60fG2g2KU8qMmZcmcXAcmVQ3J/jgzcNpMRciNUM1x+mIU+/HXY+xHkjb+iZ8N/+XQdOEdZIH9nAIXv8G6c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:06 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/49] drm/amdgpu: enable ih CG for beige_goby
Date: Wed, 12 May 2021 13:30:39 -0400
Message-Id: <20210512173053.2347842-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfc256dd-dba4-4cdc-132c-08d9156bcacf
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2564C562BA08030D189722F8F7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPpdq30SmyCxTyXbu2r9GjURGL1PulW5i9+SQp+CGtRcYXxe95h2IcUrQrFf+D1y58T73dxqRkZLI0W3nGceXH3Mg8k1EZEbT8MYPUJJg6sdZghM/sfgiTU2g1YWc6m2ulUrHnoDm1HPKJ/wU0/wdHG36UY8FxwCtFmfo+zo9j/Y47g/zURMxmZYzf3pTHK/zO7MLCt/H3b1uRXCmUx8uV/CQhTi7tFoex3LLjtzt8QCeF81BB7pvYSii9oPfTLZYzPOLoNNAQ4rgOiNgDrA2ioesTa95QwdYAE4H0B/vn8O9JDhOPH9qCiCAJQUAHaTL9D+V16mFCjIi1u8aIgL/Z0C2XX9w7b8XRdOJCWOudj6udpGM7q+cD5UuIIn1TQAgBzeAtSJExg4Q8B900QPYxQhGxKWxXMCelHwBMIaqYJvRjLM9K3qnwyTTh4uyVZ+r8zS6P5joImmah+GD/mnivnCDifqFvbMkLKUrpRia4L2MSfhqbI9oqQA12/lqY8sRiLX+RjZe48Yy0XATjWX5TogILPzxPrZuf7XHaoG+ybx+oDuggRk7/MGvutNIp7zqca6TzJOSfDFh353gjoViBxMPSwkQ/mdL6J+4P0dRwd5fVkQQiDnCFDpfQj4othdWPOqzTt0YwuTw8OSF9HwDjNR1CM5IawIzNCqoVWDrf0H0mxCYvejPMNmWO139eki
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(2906002)(6486002)(1076003)(66556008)(54906003)(83380400001)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(4744005)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Hcu6hcyBjFBcosh7pWcmDZctnBhmEBrlTUpklYFfW4+wzTCTYLbkcJsjYGQn?=
 =?us-ascii?Q?eaKdUwR6sFyZCPyJFoWqducaYkN110BJBPBBM+0gvL6hh5hkalTzfmJQRFVF?=
 =?us-ascii?Q?yz2GwRYLVQswPAU09hL91s6s62Q+b5P0Pxlr6MogN213OHSyoPTZR1Pph/F7?=
 =?us-ascii?Q?YJLFL8czF+TtUNwQTnZN9Qn9Z4zzu6yNr1j5M6aKH/DuZiSGDSlNllBdTBoA?=
 =?us-ascii?Q?/8dz7H5qwM02uSnrSzJBpKbuBqVK/9UPmMPvCmJGXd2+WPESp7bUzvJ8kxEL?=
 =?us-ascii?Q?c8A4jXn0slXJ7i7wZD5zluy2x34akjueiNdEOLkk3qKNnEy99TtNUlTWGbX0?=
 =?us-ascii?Q?IvHB82mj8kmsQDFXp/PjwiAJz9lk7k3Q6wuTl3s7NFq3dh27MzPtinXWwQhY?=
 =?us-ascii?Q?jkIBS5+/nq2Vl6tbR2tC11T9umpmImFLwS7HBP1avTMJoF9VZpZzSgl5GKKG?=
 =?us-ascii?Q?TqvcXphOQcd0rZjgz3WkeBsDMT+R0opSlnCfbDzJizQK4Yt4+3d9Y46MgNu9?=
 =?us-ascii?Q?CEGQhnmxJ4ImVeMfAsCTf8m7tL27Xj6k3loNUNTz1nFyR5VAtZ33lliKHaVv?=
 =?us-ascii?Q?ahipa1sewyLP+p64SU+wBdFhX6lgsJteR1y1PMRZ67PqEo9U/g6A4iYp0iFW?=
 =?us-ascii?Q?z3lpraIeggDIAzKxcDHKzTDJnPYucRRdhg1ny6aeDaLlHObQqI4iAyug/o0l?=
 =?us-ascii?Q?DbNZCH2OXTxcD4YqGBGmlApxBVogL1NjjqBcfX3Nkbo54UBWE5ai2Q5X89lA?=
 =?us-ascii?Q?39x7yPpqfUiOhRI69o3pFXCyLzz3v923tqYCK2V/jLgw0yaibcM6ZQnOToHq?=
 =?us-ascii?Q?7gdflraPGyJ1wku1Uau8ExS6KL+GoslU2HQqMdBHmfCGn5aJlTVrbvdNZVDX?=
 =?us-ascii?Q?D+apjzfiMrUEUWixXPHfetEhIN8WrGz2y4kn/Sm4fP0cN/T6sZJGmwonbs1b?=
 =?us-ascii?Q?2if03KeWvrXWc2e50vDKdiKuqD2yeSW6ngm+DHpGR6Fw1m8XCJ/C2eOXG1Ap?=
 =?us-ascii?Q?FbGchd9Lh/7ffoekKemOq5OmE6zr71nBtuMBw1DNbFBTbIbEmA4M3sKU8FtK?=
 =?us-ascii?Q?sRn8EsU0grGYVDu5aFBIogoC5guL/QdMF5bGGgq7B2V6gyscRBXwL2Kpi8+o?=
 =?us-ascii?Q?IoepsomMq+zDca2gvKX6jD+/2VEg6qRhJLc7F/68/LxsKGvGl/z3c26dnbdD?=
 =?us-ascii?Q?gy2qf3tIz1zs7U0DG4JtmVIxtvosA3HJkw9qHjf1dMiCFwfIwjPi9IFOzYFn?=
 =?us-ascii?Q?QbitzvMK1vmavYfFTwsY0XHsZ4K9W9dOyoG4tSxTF9ttUQDD/dNj4rfn6qLj?=
 =?us-ascii?Q?IHWCUYPrDm+xPSCOsZIxI/ow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc256dd-dba4-4cdc-132c-08d9156bcacf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:35.8903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylgIrC+xqv612HfSjEKeqX3MoUf0qgdhgdO4FZgA2L+qD3hzfGaomuiD1/MqVwzBCwWfZhJpLtPeuQ0CBUzQKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Enable ih clock gating for beige_goby.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6253845d5017..7fb65f936951 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1178,7 +1178,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS;
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_IH_CG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_ATHUB |
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
