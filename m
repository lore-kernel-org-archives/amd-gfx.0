Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F2C43617
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BCB61059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BCB61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B426EC78;
	Wed, 12 May 2021 17:31:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5386EC77
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlFPsTpKURsAZfYHdQcTOqpFXJEHE8RtQw2klPZFRAjKjrL/LncUX2EZKt7DdT9X4pG4WyvcRzktm5jebw1XcgEXD8t0QfGl3EFFW92IiwfOwM4v3lHyVVRo9ywb4HZjRb8SKoMNfPU+t4/3GL8vr+o9JOfipMW5E80ov+mHAi19zU2I/+N0ADYPlIwlPsZglZyaq52PBYbJB8ND9imh5KsPTCPzKiHJ413COqET+gmU9EtJrwvcVf3caXF/i8FvlpMInfEs6154ZgwMjkFDwyUe61KfIPsyaxXj0XIVRbTHQiYw1y6hflT76Owgow/NDTlbIg7DT0exbvW2mjMW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC41gDqo4HwR8RTefS6iO0Fa406KzFZeWc7o9eYdPa4=;
 b=bxQfomP3IUyjCIdCbTpmi0wR1JWX7qCN4+adi+bqpTWAlvAUoKdq8zuNmIXtB3MDerp2EHSI0BrFsc9n6MaY/oHML+HTdHUyrnGF+NftB7XkBobtB6dKHhQr74m5DAdj5o6JDOtMYs7isJ9/67iKeXsuj/ArYm2F8rfwX+AVOXeOeaPtcx/50LCJBAaBnpQXBJjH1qhCkWswHjm77z42iJ+y9hb8qTev23CaBUjkJVR3UFeoWNIG9FMUSEKZU0DXEOz+YeU43WWfIaZqN0qlTbPEh1wgdRJgqSHy5+eh7tKbtfVUYA1sqwy2fsCzrIODk8vIB2YH43RJfaNuxmXFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC41gDqo4HwR8RTefS6iO0Fa406KzFZeWc7o9eYdPa4=;
 b=EOboEKEVIG6xfG5jHwdCjD7zqsfomV7qPIePQDwDLYxBlF/9X1gKtbccvLvGWCUus1oyPcTDoI0irUdve5HbQwQl3DDrBGPzYSEISU3VixVXHb2PShsg3FFwxuOc3nnaIGVH5qHdd1zxvXCi32VEX3+Hmfhn5K58Vvf3gwim8zI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/49] drm/amd/amdgpu: update golden_setting_10_3_5 for
 beige_goby
Date: Wed, 12 May 2021 13:30:30 -0400
Message-Id: <20210512173053.2347842-26-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5b0640-918d-4a61-8e70-08d9156bc6d1
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23403D588B59E77A8547EC85F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMc+Cx9cDRrv27JwS7IEtUYoXUcap01B6uu8tNQMygfypUKDnIH9S5wcPkTRS/bXj/KZDcZVMlPJ1fNEIxIf1l5wayQBQGpxgMCCvu5efOuBkwWGEowW7a9uG7yw2tpp+rINEQ8o9Go9ePRW0cDu107Y4F3TiiszXzfntRoepCMcjJO543kEqHwqqYVzsEhZ6vA++ObzG8ZBko1Ak3elq7J5OlKu056ISJd+I3ZaiSv1NJoVPhbMTfDOXt+pxFlTYJWZmPlywHJ+UZcw37ZbXhl/ZT+fMFxT2L5Wl3J5GjoAy1tQ0y/0xHueiKuI14hRelU9el8O2G3RhOI8JO7mLzK7UEDrjQIcY8obUfxAr+g+Bs4DG6Qi679ROwHmUawT15lSkY9cFFK2bI0AOq9Y6ZMbtqdn7C7PQKMNpKU7GPDs4BJWaVtZ81AH5sPLXShu2u9vK7C6qAKp8I8A6nkMT4U3cM06YPttAQpGbzPuVj3XEHDC/kgLGPiNONvarigJdvbP94TrN0k/gBdCM2vleLkgZQ+dnDVUaVBj3Xg137skhvRD/PtyIDdCM7NS/hnbNNnqadiXJnH2sE8HC8VWQMuFqJeGLdZgiVnQkl6CsivZ1t33aLgb8SLh/pHJ3jR0OIDmZHzuNv+GP7ujgp8iyUOtGcGz/a4v4W6jC3QcymIgEK2FosM5PCDXBCsl+B2F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6666004)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(6486002)(8936002)(16526019)(1076003)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zuIeGvgz2wWb8qzSl25FW+D7517WP2IOvbRK5zDhFtXKdnMEnrAwqySh0vZ7?=
 =?us-ascii?Q?8DpUBpY8BJuYnNmF8pAUTDi0NROorXYp8ogZ9JSuIkdfs+fLMjR+/7AzSZCN?=
 =?us-ascii?Q?8Sazmu/9XxffFdreScmbETN/1XPzZBIGGWuT128WKWLPe+a2reOLXOlQtsj6?=
 =?us-ascii?Q?axerGxLAjCmYNkzNQXvqPp4JNwRi7c0aYeEyOJw0pzsbAxpFgPBDba34WiyS?=
 =?us-ascii?Q?LZVHX6Cl/Xz2W9vOx1udEOTDSq97kVVMnEX5zuoRiYmctXQ33cqV2d5X5ckB?=
 =?us-ascii?Q?6nN82YEEF32l9YdltFt5TWl1VKXw0edFs9NdnrxicdT+TWwnj1h9UXas59q+?=
 =?us-ascii?Q?Ivqb7tVMNg8NydL6gMuuRkS4ESHi/flvTF7bCbE9d/TxPGDyRnUpcNeaVPGk?=
 =?us-ascii?Q?M3E4OpBwJeh9fef7mB353BRKrdasWK2yes6Kye/OJC+AC+Hzkz8qWMVWW513?=
 =?us-ascii?Q?VkQaz8kfdfr/VJ7yzlmmYpEg1t380vEE00/jSCabrgaZlIUEegXF5mWla/mS?=
 =?us-ascii?Q?moAk8+OXWZXLk8phOeVNHPHfNugB6SeOh6zONdD1/bvfk2R4cqYJC1AhLz7s?=
 =?us-ascii?Q?hz6d/60+StJmMSJfClj4F4Hwrq/REDyZ7WlgCVKSL//p8WpBXasteGqFIaYS?=
 =?us-ascii?Q?EjrgdEqs3bYY6DNTBzUGNuCQzCBhtI6gOhpbiBPO/ADpWKipStyJN3dviQtU?=
 =?us-ascii?Q?4+CzH90pntE49sCao+HACTax/bA5yRMukccgL+xEWrD6ObJh5uXwU7ljKztl?=
 =?us-ascii?Q?f+FcGQ+U7jwtS+SMoGLgzl8xn9BUx1+5i3Fpdan6Uzsced/t6NckoCz9cCjo?=
 =?us-ascii?Q?+ceyCK8Ue7L+qX4hQ2ALX8ebOKV/NOZ53Q38kvy9IcbKKD4hfRovNMhOgnEI?=
 =?us-ascii?Q?cMuf8bIyHtRREk853j9dSExNtX/bR+tjUhtca8wpaw1Dkc7f4mtpbXMcU2df?=
 =?us-ascii?Q?fu81Mgo0MNiGw+V4MD5cqsnIHyIvBgXKfzq7PpHDbrym/k1CtYbB7uv1dEK3?=
 =?us-ascii?Q?3VTr13I0U8G7Im3x2e+sSM2wdUvpsBpyO3F+oXXXSySGHgXLb2eww55lUXZ3?=
 =?us-ascii?Q?kmIxswjnmI5iG81VLI/Gv2WbnqMRgtdZma/Xmhmjf6wDOlZq6GBAFxnrmumF?=
 =?us-ascii?Q?j1MzsJcsQh4wrH65clBGSHxW7L4lqyTO6jV2xcqeo07EDFubCfwTQ1rMn4nF?=
 =?us-ascii?Q?Hrd+pChdIcdpQL0/yD5FP+D8ophDg8j+IwAQh34z9my4vNwHb6hzIPC2y2zH?=
 =?us-ascii?Q?F2bpIAjIpn4guqBn2jn9Kw0u5OU+tKeTVV+m64bDjYIG2wUYrNBZiDI8CQsd?=
 =?us-ascii?Q?ERz5oyidtMJgOefAasxZ6zdz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5b0640-918d-4a61-8e70-08d9156bc6d1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:29.3291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm+zG+7FaRBOEoN6nQKyL7szrXxtl45e99OQ8m0fNcyryDj3cB+eORwupbI1ZSRQDDPq5I+lQnbOuqxmKLPLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

add mmCGTT_SPI_{RA0/RA1}_CLK_CTRL setting

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 20665117e777..338cd080051f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3417,6 +3417,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 
 static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0x78000000, 0x78000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xb0000ff0, 0x30000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0xff000000, 0x7e000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
