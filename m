Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D846C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C95161C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C95161C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033F16ED1B;
	Wed,  2 Jun 2021 16:49:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92B26ED95
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT+ckb3zCYd5iZTUN84biVLzM5SdrFRdgTpjxncMhJqusEvC5N6p4ySDrYoKvRWTbc/ZbEGBTOS3eeE+ntrTMc8Bc0lsUrmzg8/VU/rF4g4ML4G44j00yb6HLsqNpv05/AzI+fYM7gsYNAUtnDEa1a1HdYvfJ1aVNjv/olGYfkxFNipe1vqAPCkccsLMCmtmiE1vgb0ZjobT2VD1q5JGHidmiA5qvk0KsgRMvP7PMI43pRoQmmss/Kk0iJGeV+TyyNHBmJZ5dYb6DQqldHtLB+xgmISjt+m+DDwA4CBeDUZuzqIAqmCwNGDdjIEieyb9WH5QbEHksQ0GFfglYFZcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnQVhA80AVHNWWjAvEh1PgPqTsK/NGmvD7eNycCT1qE=;
 b=Zs9NVa3NQrc9+qApEBM6a6y7gb27mTZtb+YiIyz9HP/6prFka3eyBDcptxottUfyeNbGlwyV8vUiMnG/KM6NaTSX5NAlhBM/48sQSiVP1HHzjkK5ASbGCzKgLNVTMhc92A4thzDujHkKUXgUYSEe1eo/OzdI4MlGNu2ho5XQ+A+6AD4ah0yZgBh9v0NbaFZbXx2z5SD9hapMGqcnLtvQRNYDQR91TvX+fgAGR1COEeUygNLkqcolpIZDNFrQS3b8jkavo/avRvx5H09NPZx0/Iwao8H0dMskJYptrN7ZW3G40Icg2gOmc8AudWowTw6oFBv1rNFfZDPwmfyH4qUitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnQVhA80AVHNWWjAvEh1PgPqTsK/NGmvD7eNycCT1qE=;
 b=5mFTw8vZEv3Ug2DFVVLe7Wk0+hklwczD2/ZiS96PNlAZrjSp7bKxYsEL7KMHIlOyMsbOp40P488w/D5A08f0B511Cx0HNzNKuQkewqnbD8Hf+Sx7p0alxJ0/rM+w2SMlUOL7JhIuDdsaYrJ92HVmNn7G+TdkmmsyiCyAzmth1gE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:47 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/89] drm/amdgpu: enable psp_v13 for yellow carp
Date: Wed,  2 Jun 2021 12:48:06 -0400
Message-Id: <20210602164908.2848791-27-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d4bbca0-10bd-4079-4f6a-08d925e66e2b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40636465A0D39ADC2632080DF73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAuAWcDbrczUMiBtfP3tILIAHTxf5DEt5QUu9mLwcLX/fgunWNFNqqt276zD8JTnpsH81n/wrribbtHP6pyQR1wERXs650/OLT3GN4VDbADtEo/zktCtFyPvWr4uLFrKbjvd0yI0GKLnrmiJy9hDrTC2X+dQPwxXd12H8ZFSNmxgcrH//4bMc9Xnw5kDecBiWpBdsIKRss8/BheTiA4t+NLsvJTMLUDqIoimqL0LTc6SiVDn6TgIPcP2o9fMQAfmcBser7gM075Zq7HV7vUvGC7rAYfYkHmOYdaJCUc2oKlF1nBIwgEFYqrShSjWQrQAXirSobSBIdMrhWVmVkeBCS3rh9aFo7wyISjFzXnhbrJvI8Enx5Y8JEEUEhLIn/5biOAzgaeMw30WHi63zbimGkMWx4etGw2pPxxHziVGiCoBPLkQb6TM175C1RDQRoYzRKhi8zpeY1sRzYdAod57DG2nDj0diSa+zj6mzJcc0j/Owc6jQrTmwHzlRyWa/Vn0OMktZsKhGmK2hC6YFCJd2Iuu52dk4dJfFuHfGdSlph1ZhOy9hIWGDVBxzaEYD0efJSsda4Vhd/D/+OYze1is1Cb/MVWsaIGh19qbVL2Cr/re46Y4Zybl9r4wfCHdQRQO6XMQsZZXIim6F73RwwnXwYS83VZQf2kjr/vMoLRYJdLRF+Zj87X3+l8M1yusgkBN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w1Ry/iPyIIatmaPnyIHCEZkeMQwg25MatCynNwh8GCRdu8317XmDnfgu7Gr8?=
 =?us-ascii?Q?ILcm4T4cNhrwqSBp7KdEJ0Q5niKS8ExdfAXK+8TgF1GyuGZoDbwpf7rb2IxY?=
 =?us-ascii?Q?SsQ/Yj/AqHK5VGRYh25seg2twL91iVfgv7QSHbxpFiYrOc3+A09G8HKJHaF4?=
 =?us-ascii?Q?noYwY6PVMS8AhQyn8pBDTXizio51ISy0PxLMyeFfOGwQLIE+ip07iqfjZ0wH?=
 =?us-ascii?Q?l73406Iwxtu5IwTZJaKQtN1FqNSaicCY6tJc1tPBSpe2TjQCzJexZYyzI7so?=
 =?us-ascii?Q?SLq9Uo+Pcn91wRMC0w68eRxzUFBj+DPKvqH74a04fSoQVJFuHhuP11dqDEis?=
 =?us-ascii?Q?s3487KTgid69zLS7gKHPH24zEY7Q+DMt4qUPGWDGyMC7aiGzSi9qd+Xomxjk?=
 =?us-ascii?Q?xhY/BZb0CkXQKrI5g+8RJjkcOosm3FAjRBlH8kWhhdw6eHVXsxTSf4rGWBzK?=
 =?us-ascii?Q?ql6e2jYkCLec1p/DynsVsfIp7zimra48/4CBHUVMCToYDsQAljh+DPi8Mkzn?=
 =?us-ascii?Q?CUqc1f/YLuuXbecEXRJCxbXFvTWYNCvxJEPqwyT6rezbJg/MEVT53QEB2PKz?=
 =?us-ascii?Q?WYWReI0qNAdZALHsTDCj0B3QqBa4+0zGr0fFa2xh6K0Pd1k08taqAwhnB4iB?=
 =?us-ascii?Q?GztkHSOF/TMzKuup8vUT4lBgY9RrFU9yt1nCLrfBtlkgAFyuEdLN+Blaw1Qs?=
 =?us-ascii?Q?dG2sq6G2mTTafjZzvZpJ7vEr212CjS1FRFfrt9HVuCWgUlHFxEhHIsPhia97?=
 =?us-ascii?Q?CM9pYTlmOdlEFnXCOe6JphmXtoKbzJtzFNHr1WroyFqJddOmuW4p5ctvFxsX?=
 =?us-ascii?Q?W4zPhZOC3suc/YwiiLhICcXYwocJ87MX0en3XZAEBXgS45TbJ6v8BmYNSH+5?=
 =?us-ascii?Q?EPLntkZRPf5XNUto7dMfBMSXkDPWg+3MrzHEv6nDosioy6Gd9Oi9a6JQWoMY?=
 =?us-ascii?Q?bxGswN/7ZqQRTB1+JliSkBv6tVlv4aM8qGqwcNzvPSSO/pmpWbRguPTYJeqI?=
 =?us-ascii?Q?2zqhbvBwgF6+CDxTFMfxoriW31T7ajX87r2mrBF+YOl4s4lUI9JujUIj5qxV?=
 =?us-ascii?Q?jzNR2SLR7NkwkDecELOMNrkoEjnS7/SmxlUW3ZO1FjY+DonSVVFRupTlssIv?=
 =?us-ascii?Q?dFKbnsHj1jBQWtnqqBWwWL+vtms2QOHe2BHwuw+bZ+ZRbaQZOroigBoheiUH?=
 =?us-ascii?Q?hmrxjus86hML05lRY59O3B3S2qDan3Azh+ZY3bPZE4YaoHkrgwUif2Yy7ECp?=
 =?us-ascii?Q?ZeoOYC2vQQzQo+vPbTmcCPjR9AqNU+xTEUEnmIk9hXqHzYHbUWHU7WJYUI1f?=
 =?us-ascii?Q?OA4p5ui4/2XCQtyY3Bsj11c5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4bbca0-10bd-4079-4f6a-08d925e66e2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:47.2704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PCecD9Ew8gyod/4FZ55z5a7cFreLjBIFFfGrLwu/lTXrXE8KsUiH0AgsWEqZFqoEUXpPqVecakiTaRtYbQO8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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

This patch enables psp_v13 for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nv.c         | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..ac9e5aea44e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -115,6 +115,10 @@ static int psp_early_init(void *handle)
 	case CHIP_ALDEBARAN:
 		psp_v13_0_set_psp_funcs(psp);
 		break;
+	case CHIP_YELLOW_CARP:
+		psp_v13_0_set_psp_funcs(psp);
+		psp->autoload_supported = true;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 3fb253675cdf..e6ebd53568d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -992,6 +992,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+			amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
