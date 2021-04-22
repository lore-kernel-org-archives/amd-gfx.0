Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B64FC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DD3613F6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DD3613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4706E0F1;
	Thu, 22 Apr 2021 15:40:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE436E0F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ9YZ0dVzV2arUByQo5gmIxSLnIOrY7p6HsVo4Ptc33UeqbXWLaMvPxzxlTHC7x84YUwZ68lEx9qCfHAdvT7P5K/8+4daDGl7g5v2eAvLw+KVYyAFATgaueGioyBj4qUKB6RAMFgsJoi0R38NV2z1D4xn/TZlwiGoHC+j23EhQy+CxFCBFNfcfvFMTA7NluCv3zjkdJZYvss3oj6YL+P/rhQMKnvHe3GTA3psR3CXB6GOgopMDiRCT4cW3IniP4xN4ka7QoTUqIJyBr+Jw9M53elItClZ1HGOSkFfiXrME89fFjMtq3kvkDO9XFnJCCt08wHfyj6voe8HuS6mq4CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItPdi2+c+Z8uU3FpsIR/msd9AeTGTqNQmzZw7K2eOik=;
 b=kbK4NPFJN82RIsxoYKxRCYpcus7Ki/daXcvAsZfy2CSBgHDxK86ZZurdkj96UA7Vh6bWTdxpD4h8hen6BvsH5QAs0QeqRzUqG+0WUXXLrPeb7Gu1T/oSjOxr9aROC3NRoK2fJCTF+PC7X7F236FTRy99bYEWW3KmiVZ7C40VFQtX0FklcfroUCffw2cdoyO4g02fComp1pKyk+A9hRdriR6k7onqyFLiiX9o8v9rWpnrfe9rGU/jb4AQSreP3W8RFG07A/RSTE8CCrLuzGw1f94IGffKigU58whB6yikA+U3apA0mRHmaBBSkKbUVLhM9rEOMYcUw36Q1Uyjo22ZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItPdi2+c+Z8uU3FpsIR/msd9AeTGTqNQmzZw7K2eOik=;
 b=HFHLDCUzExwDxJDUDFnE1W8sieoG2WDjHAddNhsmkD8jQd442fgq8XFUZEXyDo4tp4eGzyxAeMluqQUctUBW+fl2j/c2H2DdyJyPd1cECjF2GOtvB0hpPZUsf5NszMElBGJYL89+EW00jXn6+vMqKWjnZR1md7Pc6vHrpXwA6N8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 15:40:34 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 15:40:34 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/6] drm/amdgpu: expose amdgpu_bo_create_shadow()
Date: Thu, 22 Apr 2021 17:39:58 +0200
Message-Id: <20210422154003.4048-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: PR3P189CA0083.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::28) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 PR3P189CA0083.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 15:40:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a334a889-77dd-4aa2-068f-08d905a4f7f8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1239FD46D6B4019042CF785C8B469@CY4PR12MB1239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvoP/BW62fP70v9VV6wCQebI2KKqlHW31UdhJo+fLBq1xOQmRTEQHNEb5rpwgpn39IKQVWM1bxhpageipbt6kOqFDXK31gYL109jYZ9Dpio4Ef1qu0hgalOcUGKIzeRpsOV6S/3al2k+4/4faiZN7CC9acV3TAD/Q7Mlh8N8KKRbzHv1EMcRMOAaZ4B5uZ7bvFI3nJhO1VAPk6h+79Y9WJ6R/TCJBAavv/+yo29Qe7TFMZdKCq7ES4HbhH+ZYFihk/CE31R3Z3xwVQ0PY24KFlTJEgEmyxRTwPq9P+JuxRpIo03uGN3TL3CUJvATAIeVnL3Lq9K/br4rNhNBIaMwktMCU0yhizC8RcrbvJisIwE8PIKGTjoya2HkKN48T0Ce3IZ1qdrTQF3M3PNUomOOrneeINh8sXCMNb9CTyyg7ZDj/ACYUheAPs2kJawGySSimbnUCOIsfOLiRoD2NRd5zjI52JE4cKtqVf51XYaW0bJvNNPH3edUhNMes2ygfT1a0/nUe62tojEc5ahMrvNokUxprmKV2F+rPL1wOglJslnz8SIFLfRnmTSpPOjNmCCUo/tEwS2pftXjBx2svLrRKfnoODClBMHHWn36ayl83sKNgpQNPbid3X6tXHTYquQ5YckW5aVSbeqfcxjfuvpS2U06BhCR7WHyfMEzMd2C6pY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(2616005)(956004)(8936002)(44832011)(478600001)(34206002)(186003)(6486002)(66476007)(1076003)(5660300002)(4326008)(6666004)(86362001)(8676002)(6636002)(38350700002)(83380400001)(38100700002)(316002)(6506007)(26005)(36756003)(66556008)(66946007)(2906002)(16526019)(6512007)(52116002)(37006003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UOWiyHa4K7Xsp87k39D2C0xWA2nUNUt2a3SN3I7qG379brGmnyoB5Op99Rio?=
 =?us-ascii?Q?a41ZVok01UWVs1exbVuJFPDINfi5AIVyGMh9ze7xKq10KOHdJTZrVDnzzH0t?=
 =?us-ascii?Q?6eVFiK1+rLDpzYGGuui95nqJialya+qHeX6XQcXt/9Ab1ZqattDGRb5tgtDo?=
 =?us-ascii?Q?IBDHmmzTPbtIh0Mwj8pscbQ1gEeewzXfmrEE84Qc8jKRQYVk9oONJIHGbPoT?=
 =?us-ascii?Q?32qJKwEV6k0gWfspVnccUQdh/jqU4voHHcppcVuRiscBqqELItpeYkwr4REx?=
 =?us-ascii?Q?AmfzgA9VjbNwCvN20xPb8NXOudg14xfF9Pabo69KBVSd1QhsLQjAb/xmb6hC?=
 =?us-ascii?Q?aJ5443XEoTt0NhWWwp2wQBgtVLyKnIDf0sPA9rtPcwwxVr5ESOyt2khlyHZF?=
 =?us-ascii?Q?gzDRex9AdL9txJO2B8J2aG9msGLwjR9u4yCI/zMYuOz2QZxOohA5zR+XhnR5?=
 =?us-ascii?Q?nTxxQBsZc+xQfu1F9Jco+oca5ET48iUkooZkeg8XUqSo9Zt2T0CY6gNyxdzf?=
 =?us-ascii?Q?XqFtHYcNU6IoQZ5i6a+KY0xI4kkrssfb3LNmzklggN9Du6g5/W/rs0p9uiEQ?=
 =?us-ascii?Q?a/nnlI7qm+/WRaTqY/0CqgMi2kPLQekuqzExQgFLPBkvnsQ6EwyUhp8souVN?=
 =?us-ascii?Q?4BWyrJCa6ktIYNY3ge4OP25DrHVtZSQL21CLSbqclKk4NjRBoa5DrngFAYr+?=
 =?us-ascii?Q?aqgfw0T9LpE9W194FqM9gkDXuxRSJfT88SeAZMkiq5omG7Et4yig+Oo8pv1C?=
 =?us-ascii?Q?m4GP1wtnq/rC/Pfz2Q9ifz8mikHVmV4EwKTL8cqW4sPxIUhh7PnCSq3qSuTw?=
 =?us-ascii?Q?Hj4bF2haWb6x/3LyxjlxCh9j9NzHTq6kl5/NTBKfGQbSzTJjCBPpfgh9pO7B?=
 =?us-ascii?Q?CtIyFDGBgE9Q35pDRbi79qL5D2ifSfbJwJpe9BogJH2+MgddUh2vXaHaQ0oR?=
 =?us-ascii?Q?iF0nAFQJNCNicc2o6dwQjtDetsES79Pa5slSfZA81t3oJW+w9pMtgk6l3Gm2?=
 =?us-ascii?Q?HorEbVrtRua0tQbvtfSjiyO8c2zQt5oZ77iEgcUDQCbxNS1dcrd4Avlj6ve8?=
 =?us-ascii?Q?AGDYN+dTw7HKGFgxRTa5DDrmaK0kLcQJa+90UnkhmUvgp48WwrfG6oBaw3sq?=
 =?us-ascii?Q?at0bHppg6T8i5b6mY6KYkwGSiOwaPAy30IAu2YLBCdqoHNa1nJJo9dC2bciJ?=
 =?us-ascii?Q?sEwpmqSLi58720AfAO0bKShG+6xBL4m7qXIB1NYJw9vxR7AAr3Cf89BodgsG?=
 =?us-ascii?Q?0xG8+B0C03oOv494WUORCtCAewW1X0woVaq0eVl4/TMbbzQdnQbcwgyVkmL+?=
 =?us-ascii?Q?KysSNvNm9/g3Oe/3+49vDSK4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a334a889-77dd-4aa2-068f-08d905a4f7f8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:40:34.4477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0KA9GD/inxtayAeoNZ12oZ7G1XuO9m+j53wb4q24plpDnusrni5abGORdtpfd31z9c7cvHIXqLffTSZb/HBQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Exposed amdgpu_bo_create_shadow() will be needed
for amdgpu_vm handling.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1345f7eba011..9cdeb20fb6cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -625,9 +625,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-				   unsigned long size,
-				   struct amdgpu_bo *bo)
+int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
+			    unsigned long size,
+			    struct amdgpu_bo *bo)
 {
 	struct amdgpu_bo_param bp;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 973c88bdf37b..e0ec48d6a3fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -271,6 +271,9 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_user **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
+int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
+			    unsigned long size,
+			    struct amdgpu_bo *bo);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
 void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
