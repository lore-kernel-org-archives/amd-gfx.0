Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE94FC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2C861A36
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2C861A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D4B6ED42;
	Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B536ED15
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVSURT1TlLubyB2JkdtTx8wrFOsnyxlpucBBJn9rJJvNm6nXLFyeqNjvb/i0vE1ymiOlZ7DnoDDJkCN0eMoCDOCL+SW6ZN5yf4L3TpmPCFw50EBnj8cS4661wHzvhE085JBKHOF+JAGiVSMfezpfpmsdNAiHWBT0ZETlbh2UcX1prGeZkxijdBhNVdv8KMCVXi2AKGCo81aiw9yalkiWt3lgapu6fj9h6+IvT+nhnqG0f45/q2gY65Ph1kLSxDNHkOyYtxGPnO7U3ODkQufw5lRbJYBJh8KYnU5MeZg6NWSaivImvG2wngLNj7kc06yBq0DTurvRqLuinf2Mk8Beqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNw3mEBGUY2EDEic3AAw9Cpl2ucLAD+RRoyKx3qU+8A=;
 b=l6ZmiAvU5D2fJajrmJtm+DnPpN4QWqaZzIzuVIMNVFi5sXs/EWskjDlbiOZljqQlsTqH4ekMdM4XbRvqVwgmqDTguMHWHt8v+potC6/g0rKPCEO+ZrpseYuJd/DqWdhDAJdjmsRc7cR3XyfWV7f6dLV0inyouuqSIFJVyKVxJx27yVFnpkApVt1m9n6wPxrnJAWmQF3JYJzhCz42AU0kjyhmkkB3Pwl4fBc2VSQPKLWUcd/BDydqG+Fum3m1pMFFnAZgvSgYp9hk9hdoRszv/yfPKTUNLeNN+3/WhX1qTimz8kg4XQIeSGPuHZ5PREdUaooQhfQhfZeh9gDDxl8ypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNw3mEBGUY2EDEic3AAw9Cpl2ucLAD+RRoyKx3qU+8A=;
 b=laIiQJkLo4vZgRSttH0BB7EuM9FJZuIH/WAHm40f0yFbphgE21YN48+GJCMFVPgrnfH1f1+ECoaipXiedv8HvnFO0gI9RpIgFGq/TMUQd7PDxSu+26yMwkDfMPagk5H1FNvHOf9HDr8lMA6S7BVMazppUTvb9wLg4T6M/FJQgmk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/89] drm/amdgpu: support fw load type for yellow carp
Date: Wed,  2 Jun 2021 12:47:48 -0400
Message-Id: <20210602164908.2848791-9-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78831b5d-4de2-4182-40a6-08d925e6665d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077918CE63E44073B48E994F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt8ToXNMeHrX35I7aoqRjpy4XJEznMMs+2OvLI6R2mRHdkqPRTZW++q5/WnaCOOzXU8USSzDlG5f1xaULgl8es8UxtaiMMl3jt6624m90isWPeP5vBDOS44mqteQz8LYPxA9Aly6NoD0cClu8FPk5ALFomXPbcvk5tbGomy3rdnYk3Y9NWdOVkpXVc2OWo1caB3BFG0VrFe2DH9qVhhJNdzMqO2jM5l0/FGvfYqEfnhxoseJzPM1TxPtS61mpVh+hcZvxtQuH5ermGLVZz4POfw/hL6C8z721aJndIC+/DZZuAq9mW46hlir1cR66fBOr/sUcabEIOL/dY36zvFp56dYUpFOY38ctygxi3/cU03lOold73RXp8A/FTpuC7xOU9uqkuxyM6jKbNYF0stgLphAQHAEN6Pu/zhkbLjgxExKUJ5qyuUFfk14h2IKjrD0hCs8lhWXj/YYw3yIqkHUC3DKu3zai/Wyd6Uh0BMQBUJigVQxL+ut5Y7aTobDIzgjda4qZeU0DyTHpTKV0nMt7YI6cE6nzMxyPoQn9dEX5rwgJRxwzTGD4fn00odAPZnEkS2CPKUGLsuII+NTYBERPPJoKama8wvmz1cNXaYn1gf0JaRIVTItVy8Yxk65j2EOPnJfqk/yxaLIW3lmTP3MmA5zfUJcXKFBwwaTv1kkNDnXwhZnMCx+khFYY2LJ85K8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(4744005)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SZN6qs4mNbqHpJkDj+oHLpK5CVe/J8rXOd5l19UmuhTQhXIwKW8Lji3eFAZw?=
 =?us-ascii?Q?dquEv6qj39NgbfGAMpPjUBMlqxCnJLZfKmbtjvhHJ4NBj+P51D+zth3XqcPb?=
 =?us-ascii?Q?US7dRe8tvyo5T9cIPWTNHun7Keoh8F3KWFUXgToWF3g3FUGQOJvYaLxzPdEt?=
 =?us-ascii?Q?g/DuiPJD51YIb1wBJvaG/FhpJf0/5XFvCLGw/yliQghMtQvCWqel/Q+hTwCV?=
 =?us-ascii?Q?tV799Z4wYdBCVwemuuDWZa7gwxpYFe0U2teLRehDN8uGfXen47VGQjIwC+Qf?=
 =?us-ascii?Q?98aICHzKg9QBni092R7mJqWczt5YW97EiMC+OZqJNPhpg/TGkZMphja1xy9J?=
 =?us-ascii?Q?bIEbuFgyJu47+HKAvpit0cmtKedI3430jFsbO5QaibJwws+JOmRtA69JwQ/S?=
 =?us-ascii?Q?oR2nnE5xWWOsicN8XJQ2e112sZUgBpxAez8BxMGXgyd6AlhlkNfhFUyGYsBe?=
 =?us-ascii?Q?rn3+6hiIwhgLqv5VWbulGtqb3ycbSRVNcyi6FYvbF0mn3/E1+nl7MuSZHtaB?=
 =?us-ascii?Q?0Bl2XrtRdRr3+XRtKZCjt78n3dd+CzzuQQI3vHel/+8fAyfwQCbyvCny5BEP?=
 =?us-ascii?Q?GPHeLQxxhdzWKja4U/9Surr203UQGdZlNzXkTylhDJJomXFf5bUVRK+A0wQQ?=
 =?us-ascii?Q?yZorsCYOzAOqLGMO2HH4hkK0ozN4UPhUOjBBMyfg+h3E1I5cIqmZde+wx5ze?=
 =?us-ascii?Q?UEy6Hbsl0Y5OFrHqyEL9YiePBldmCFeFWR2TFk07H6vixVlY7f25N1hULI7V?=
 =?us-ascii?Q?alrZF2/asi7oYsC8xbfoMm21Nf3pbvFWEpQ/2t3AePPBQWSM5cR0xMWZ8FGi?=
 =?us-ascii?Q?Oxq1weTW3vaNUQqFU9VNEhVqKPzhyeN4ZOjyNwmp/nDpLgxk2ttmNjTznrXK?=
 =?us-ascii?Q?p77R551LJWpszmJLy/l44bRDRm8MfGL2ZIi3hVaBJQSmvxQ3ad5WuqYLSZYU?=
 =?us-ascii?Q?wGYLZ4FT1E1XtmBuB3A9wk8iiUBEQwmL1T3mpStbvtQgagdGH6Xeq07Yp7Yf?=
 =?us-ascii?Q?dyAxkh2CYAy5A9hT62sDgT8uqqyN+xYq6e0kuInze2cph2OiinvTdvO8sKF8?=
 =?us-ascii?Q?YiOVK2UEfzbOYn9oCcyO9jndYbj9EPL9JYs4nahkAIE3MuqRUzrQPZj3DUPo?=
 =?us-ascii?Q?DeIorf2i/1o17iNUUe2BvxhlVGTB+vE5ca0pxnWej9caMqEoaiukA2ib+bmE?=
 =?us-ascii?Q?odplLwjbS8uF0BY+oM8YQxazhsfHBhU6SwJ3a9l8Bu2XwWFYp0+QSucnoeL7?=
 =?us-ascii?Q?IMHi1rUofWuXhgGbq6F3xxvybX1J+6v4k/zY1grJgy0zGGvfsyUUws4IyrxS?=
 =?us-ascii?Q?Rutltk7b7/jtVE/SyQD0b11N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78831b5d-4de2-4182-40a6-08d925e6665d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:34.1620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw4hHBXB+PW9iegaPmWgBjh1Vjmq1qgXt5DsAeqEYMuIGYkfyY6l3D94aTmSi3IppelhJZN3CBNJ1VFLYcVqNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

This patch sets fw load type as direct with fw_load_type=0 for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 8b502ffd58dd..5eb84de588eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -404,6 +404,7 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_ALDEBARAN:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		if (!load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
