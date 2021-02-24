Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B3C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDE464F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDE464F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97B86EB7C;
	Wed, 24 Feb 2021 22:21:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9D26EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiJkRj9f2g5KD8WdDrj06x/CwhJIcwD97bS9w31l2O64YeVjbiI2fuRGJ23Wz33md9XJdAxrEPytqmIDfXCklzDK6cFJYjNLslKor87lSQGL8pEbXrOKvtVwFmG+Dvrpb5ciWK88UqyVp+dJWwGqueNJQcJmO67TxZMls9x6ofYhc7FTCQlpDJZ4iW/4sTu7eW9sAN6r55+TBItQGqz0riSXNkT+Jagtu+RzZ+zXRfuovWu8Jvmz3m+PoYYmSjXHIxCGKFKyQXA+Agv42i532HUD3emc59I1qD7QExB4Xt60wYIElJ3UdgdrvGeyoTw/6lVygzGx1gjrUkryIZiVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyLYTCIAMEst4PIMYTFb6VYDtbYYlZsMOBbMqNMV0ho=;
 b=lqql86mQUygxQd42AA4USokTG2HXa8nMfmh6Cp9CJq3DTRn89Dh73uc5XCVPY6TzFUeTSg3J+gFvCQ3lsa5XWNkYF/VbwPMTtjcVTQltGAJNcifVTARe3qLCVle/Fv5UsaV3ODksDBcKrEn64nRY0HLKOw9JmmlTpTN4pyhwL3vgBIH01ownLdHvXkiWGBkB0eNA/eyxZovNYMKJYsR0idzSyIs7fQi2rmNkv5R5iHWj7LZ7KuqiKUFbgyXy/ijTrOzjnmHHeeyfOdsV3jBW0IzSD+Yzf0s6oN+wu44RVEpYjXNnPMbnWQ7zsI5oaW7E36R0Z1cR3RC/Ng1SnYcK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyLYTCIAMEst4PIMYTFb6VYDtbYYlZsMOBbMqNMV0ho=;
 b=mW3NaynJfXjEgo3L85oZ6hEG1Hm0wKM4yLz8RsapZ6vtvldpk3AsepdaqrjyCXemuAKcB66KwQ/vg9C4+3WqmIwCi+NkzK2Czh+CjRXeE0VXhoLjEqeB/wC8HONsxNVHcOy12jF1AYh6gJhP17SnAgcAJ/xQ18s9zWaRVsBKZE0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 108/159] drm/amdgpu: enable dpg indirect sram mode on aldebaran
Date: Wed, 24 Feb 2021 17:18:08 -0500
Message-Id: <20210224221859.3068810-101-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4118bd79-d022-496e-8007-08d8d912697a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798A003605092F649FBCC04F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtEku8eB+0x+QTaOTH57EqmsZaDZUwxdQInAvV05BfJy4juuUcCMd9bmzfNFAR2KsfdXBjQHT7LPX7VooCb+wHybOBQ+ebRq0RdPa1pzf15gmfN7yrjqjS/R/GttLxqeh5r7ki4rZTGfEQHc3QzsDPUc0UDJ5fvEUdydYv1a2RtIk1Z9Z8Uod0abA/Z32EFK9kGZ9Jzf89p0ONfAK6d4Gph4TK1+0ph8Yb4PjbE6WXp6S14YqPs05WpEJOA0USF2iN1qiEwxpCPIHB9GpzLtcEJmPhR3ywsTnmeW2BH2Hxq6Ib7L8iC3FieX0QZR/HNX48DEUsyNUCgAFof6nDWGy0MqzfciBMA3uwCoFdjXzbeF64Kn6dbQjvpjuPhrSWjnqhfOxYqjL5emNQw3AbVUXWiPk6l4OPpOq6bbHHZH0vIwe4KBPK0ku9vP8Qowp0kDdYkMDe/cf3MWZqw9pwrGMDEDzYuRQji5WL6/x7uaoVT+vjQIIUWDEeDGdDBSDBjhnjOOBPhXocZnYZnqdTs+vIap0hHWF15K3VVx3Uf5r/leEvmqo+rwX/YLJWwKJkLywWiKGgw5wUI5AFMjGIdQ3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(4744005)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hcBwc87d/PnQsJ5JmXEj0Uzre5fXGR3ZMwWn5yi221yx/79+15+5VzJKoMbT?=
 =?us-ascii?Q?o2oFaaqtRGjrucyfj2GcVjoiVSIFlbny0zP2A7TH3qNWby2zip4dyb/rUQ0e?=
 =?us-ascii?Q?F/3PJPGXyuLoABiq2i2VttDSRyK37/zht4s64MVW8TcMdwdOtdk4XeLJCBUA?=
 =?us-ascii?Q?l44sRY602LdEkDzx0CO4DFOAJXHZIyiTB8onlD0uRdfmU+MgtOOSSuO0VsLL?=
 =?us-ascii?Q?gqaQ04bgqz4QmTaxw6TbfltWmDB+AXIcGxkc8kgXHWACGdLV3sa/ka2laPs/?=
 =?us-ascii?Q?F9QWt4vezBf/HbxjK/a6dehKjdcu/w0g+VQDVJFToOYw0CIHbdxvw8rtFcDq?=
 =?us-ascii?Q?6PCmm/cCrmrvkWF9h27Mwk8s6I9v8g5PQMaavA+UUhMYTg7msipES/63F8wb?=
 =?us-ascii?Q?hPXLOGxa+0ouU/RPK4vhb3N0X61gflL4Jki95hoLwiDdPsrMH54Cd2yvyJ4M?=
 =?us-ascii?Q?oH7uRwr7c/7w6nA3UeHf8XcSHgpYJuYb6+ObUa9amxdhoKUho51zoFFMbd5/?=
 =?us-ascii?Q?JzW2kO8oLFB1WxYE8tMBp+A2t55KOgCaAnBeiQ+SFg432QP3jf+CclzkSXwX?=
 =?us-ascii?Q?8bvy24puWwtlMWnnakrJdV6zYF43o7evWGBHKuESgLJAn2HJyV4C53BF2S3o?=
 =?us-ascii?Q?OJBDyZ5vesnJcw0zR6XJ7FU1VbW3j29nn39IvCFPruKFP2TnflAZyE3eyTkv?=
 =?us-ascii?Q?owPuKqCy7a7rcb8OuaDNPlfMkVX9nfVgAjeX/r4AZDJ6JIb4DDL69VpR45T1?=
 =?us-ascii?Q?wjL7lGWvinZQF33giJ3ZwJC8YyuaBPzsM+wuJSky6bsOdFjbrw85ZWvn3z1+?=
 =?us-ascii?Q?rdaDvaHQN7PWkwCZJ+54YwsVy6QUiDHsbkVRa36l9JAx0gTy7w38hyxALbTw?=
 =?us-ascii?Q?YCJlUL6FU/mn0HjMgqKbwBbkCAOYmGRfeRwOqWo6Cdn9Yn36zyCAVOoVbzyS?=
 =?us-ascii?Q?qLnFEAg/roDk6g2TmL5nac6VtMtedElQ0GT9Ue464TnLXluZsEd1W3PAvSg3?=
 =?us-ascii?Q?SVsnNwbzW9A+euNmMCFsj1Pwojn3QpTT3xlWLxAOuZrZjzpzZPv3KsiR7h+S?=
 =?us-ascii?Q?kxWGrGD/cbMRzwKhVL6sV8nKWT2arTOEGv5eDgiwM+jrTnePhaY6ub+QHj76?=
 =?us-ascii?Q?ZVsviFlrerfiYmBZpvm7uqpK10bJGewLp4e9a1hFPTp1hI6txSJjyBL/tMDD?=
 =?us-ascii?Q?60VAzla5Yo19miPMPlPI9rMIvWqkIhGUubmNY2sKhV+vfFxZvK3ZDtLCVKAY?=
 =?us-ascii?Q?414KGtfZfd+pA1BrAT+r4J1oA79kNiiDr4tRIDfRmbZ4EJFTzevSgcbpBTPc?=
 =?us-ascii?Q?LmLjvql6S19+imcoH1xJA14O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4118bd79-d022-496e-8007-08d8d912697a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:37.7210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GXbiQ09I9KIcxAT0Nv0RP4VZ0XboKpt3aIrqFLCDcr91o7KD4WRRyfHm7BGsQu3vpfFEanq5U78ZtL+Sj+EnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable dpg indirect sram mode on aldebaran.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d872bf674aa1..d25613060b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -108,6 +108,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case CHIP_ALDEBARAN:
 		fw_name = FIRMWARE_ALDEBARAN;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
 		break;
 	case CHIP_NAVI10:
 		fw_name = FIRMWARE_NAVI10;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
