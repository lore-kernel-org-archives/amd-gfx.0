Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D08C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564DB61C4F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564DB61C4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F88A6ED74;
	Wed,  2 Jun 2021 16:49:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7EE6ED85
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWmoyFcd6tJWBINFte76pC2F81o53joagy9/eRSjHPL2dnqLsRWr9kepV3kFjyHsTtRnlP+NlWFdbs2hWTYiIlPo+kPdervRQEJOgVYmiBdVndn4fPqnpI/T1dUkbtcWrbOqHy8EOKP3YAW9HMgrgZWAV8hOulImpZIz5hRxGXafYwxkE4vAYT5B6tYq3wFckuf4r0WRbkSDnL0CutbYgTc2OVKRfun/EeT3B6v4ZtidsbNryRif9VYsYavTaJ7wLjw5716DyeUSOI3X6pvQfJpUu0BdeZDodG2I7qDOnHV1+wXz5EtbNpJnlHieB1buYj//Wk9tzxLWWDYsg44xPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+0Ljz3il/PFHvN0IYc/reOhvj1vSio3rd8YUadAKCs=;
 b=CTuxTzlde0H4q//USgwrofgBU2mxfj/yhB/JM7glq8iIh04/HjgwfgbGmPCiYxZus3Xj7LAJbLBCbiFIFQiQvvZF7pLyxpkP1JouoVHG91L8yjJ64k28eBZ4inEta1cLsz1I7skIuQhfc/XpNL+Ao9u9g4K+3Zu4ydc4anbnIOEp9090BYOx1hXzODsxz6AWlu7Zk9qWd4N6bbG32pwGmZCoAGG5JNYwpSOHDbBg8OPJq4uMX8e05jNDj1klcOgvMu9oE9eEWeJui1y2bncSdqpoDMCXQIhWo9imh0OL8h7n8aZKoctofT9M5clL1J5Pzmm2hQ4boISNI8jDpDfQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+0Ljz3il/PFHvN0IYc/reOhvj1vSio3rd8YUadAKCs=;
 b=okLGQsfPpIb2RHALDG4GFKTd86b/FGyr9gNTax3L45odxHMnq/U789T9SnsbKq8cPexAp/1MC4sNZ7u2J20V5bWfFMLv6U4/nv1/a4nhs0unL3ltKU+SCJAHeoraN3G6wbumFFFvdksz2b3yWMdZsXpogNoxjTRbFhnfTfCadZM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:42 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/89] drm/amdgpu: add smu ip block for yellow carp(V3)
Date: Wed,  2 Jun 2021 12:48:00 -0400
Message-Id: <20210602164908.2848791-21-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccde8289-82d3-49c0-1505-08d925e66b65
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45337C1B9A52C56C9D176E4CF73D9@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSCFDvePj9AYSDo9rIkddNfm2dC0pKCMnfx1oxccpikY5QeIzbzbbsOSF5IX+uCSLnwgWDxEfWdG0/zQgugoZ/e4N2sBUUj2/39eyA3j3vBPb9XJriSAt4/NeVboGt6YbJ84nT2gmNzb7k2YHR2PEBSaCzCw+waUKM4VNSUQYGRIj+cBiVAmBwYK/GnwlAT0nFUqLyufeU25X4YRHRp/4BV7x1KA8PiWVoui2le4NlAyCL4a3SGf2E53+VqUnjD2cqGtZQxZmZwhfy6GJJluQsK5YafxZBRsj/XD/yNw/S6ms9AjhJu3KtNh+FfPRO1ETNmBPmUFRCq4FI5Endmu6XBs4VjSDZaVHbdCXSW6xTbu+fFV8IXbd+xixPKIGWcCQiUX4/jouqb5pVBzqvLzuH4g5OklQdDVRJQ9edE0ynuF4ExAPergd5MaIygkXCj4QmyTBaZTQ2car8K9FrTdtkUL/8p+UZ7ftBNvKH3xozk1c1f+O37ctYl6RfbTTDQLP+coYyqHaNLHsLND8HVjMxu+Gq5gmN0ZGEM7H7Z78PeZtRb6MIpd/hST0sLN5+a3QC9Vk/SRr1/w0YA3ny2oj2tHQWsV/ORaJ0Kebsd8WTQryVyxUb5J3hHNpVS65/ASJ9BS/2VLI0bfireb4/HgtyYlkO9GelJ7EcFXLWfyv5u5uCkiUln1GNuVt24Pv1gM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(4326008)(36756003)(5660300002)(1076003)(6916009)(52116002)(6486002)(8936002)(6512007)(38350700002)(38100700002)(6666004)(8676002)(86362001)(66946007)(956004)(478600001)(66476007)(66556008)(16526019)(186003)(2616005)(26005)(6506007)(2906002)(54906003)(316002)(83380400001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RVPzDnIfegLPLodZ29LbJgXxm0HWMPQGVlxLDUDZrkeiQrDlgDLs+Ob2OxKw?=
 =?us-ascii?Q?ohre2UFtMlmAXT31g9hrf/6KAOaABvVrn0P/IZ65J4kT8zTVlFz9/DkKNXBH?=
 =?us-ascii?Q?T6kqFbvU+2+ZI+aGVwRfCmuozfOXONcFeeWP8qEs5VMYEjBR0tmmFChJVoM8?=
 =?us-ascii?Q?cQvco4uvaOPjTgRqqX58Bm4ESWdf2KLgkx5Qdk88BxIugDf8FFUWuJxfmzhg?=
 =?us-ascii?Q?FRopAqElPZH2kOkU7qPRpnN08hs/p6p0dSiDls8uX46zyKxAa/PVn8ZSx6tM?=
 =?us-ascii?Q?likjhBlSD4m5uIndh3M1XPfZgKdfFrAEtXEdSnwmMoeCko8T0JcOVo1SZHCK?=
 =?us-ascii?Q?Mz8uWeqRR/MXDyutVgUofi8TlvnHJoKQCV+nH/Glh55mRXJG+dOLnEGj9e2A?=
 =?us-ascii?Q?xFwzjPzJQ1iSlr26wXM8zrH6YJjHLofNZqBnPGElqUQbiPiFBP+VY44acYYG?=
 =?us-ascii?Q?xZSWHRsJi3sepgTtQBoMSJvTCTWDXbGoeTzLqJvXMA83d+wnB9bOOmA/bYnG?=
 =?us-ascii?Q?tepon86P1PO6rLuvxcKrUB+zVnJCeuYuLf3ihMVq+vdCR53gbC1uxc7KZyT7?=
 =?us-ascii?Q?jCd2CXZ3bZUeMYR+od88tjTQRUhKXD0cAFUD9b89VOWQFt7KytOknXeKW1OL?=
 =?us-ascii?Q?ysFmBI7ohQD37z0do6Mplv7Zgtd37q9b2sApRs2dAhA0rZgf0F0RZmYAXAcp?=
 =?us-ascii?Q?Sb4SAeSvBNOGhH/TFvQCq8DeICQ1VaVQG4W958WkWmkModKGxGi/3VNFFzVh?=
 =?us-ascii?Q?FVtWepsrYTEnZ/SC2gljo0zTFKjYS4Lp3J7cj7ISRB9xUGYsDxzO//9e8+EO?=
 =?us-ascii?Q?9GIOKWsToIfhaYqg0TbHUMofD82e9S6J2AqzmyM5V4GZtJtXgTSPd481CErE?=
 =?us-ascii?Q?c3BN90No641ZX4psiGTCZqU8kCXTW3ldN62kRkHDD+ShLo5DIU9zdRWVJ74B?=
 =?us-ascii?Q?W1HQ9J+Lmba/d6+HDfBU0DkBqbmNT8ebTC3t+o6y6cfNlX3qPBN8MmVhe2ic?=
 =?us-ascii?Q?WUXTdAMajEQFZj8Tqe1I/bz5+ccMSYzujQ0CuwrfSoH3deXIA68pUXyMqnCl?=
 =?us-ascii?Q?PSAadHOEedtgrGNNMWmTQyiJ4oHhRed8JxGZFJ/ZE6zkM+C4ILF+nLFnzMDX?=
 =?us-ascii?Q?dKUfBiFsfmOCnz52GnKmmI0Upkigg6ukHe3MvOlxggS7PgUmWgXfr2CtlPrO?=
 =?us-ascii?Q?45MvAToTGs24ZHEGTtFSmJLsFNZjSAtMt4P2UOG2loefPsANwUDlgSdjkkpk?=
 =?us-ascii?Q?hg/84B9Sds8n5/H2vejosR6jy5A4hVVNXkXHVHZGK8fvx10IKCMBPz2Jv6zY?=
 =?us-ascii?Q?2FQp91S9EOH01G1eaqxaVN5s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccde8289-82d3-49c0-1505-08d925e66b65
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:42.6089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5QHDT4BG3Y9p3nvsKFQDwJ3ETLB1iPSxhbRdQR6nhu3I+0Tuv6wYEofYKnoh6PhGEkkqNt2jK8i0toFSfBn8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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

Yellow carp smu ip version: 13_0_1.
V2: rename smu_v13_0 to smu_v13_0_1.
V3: reuse smu_v13_0 with aldebaran.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c           | 1 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d15f99624e4b..3fb253675cdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -992,6 +992,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index bc55af477d1c..71adb9e76a95 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1275,7 +1275,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
-extern const struct amdgpu_ip_block_version smu_v13_0_1_ip_block;
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2a5c109c0d26..6a41f78ac376 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -35,6 +35,7 @@
 #include "renoir_ppt.h"
 #include "vangogh_ppt.h"
 #include "aldebaran_ppt.h"
+#include "yellow_carp_ppt.h"
 #include "amd_pcie.h"
 
 /*
@@ -584,6 +585,9 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 		vangogh_set_ppt_funcs(smu);
 		break;
+	case CHIP_YELLOW_CARP:
+		yellow_carp_set_ppt_funcs(smu);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
