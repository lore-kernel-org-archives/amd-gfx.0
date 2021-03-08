Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD62EC433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B5C6521D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B5C6521D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF3DC89C97;
	Mon,  8 Mar 2021 15:37:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B01F89B96
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 15:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtQ1eYNoTdoJ9+iVU+J30EUkNfA34Lc5RDgm/2cQlzfe8ob51i5hItpR9/ekrMAzCijq0K8MULu0rfpoRgDNzyp1j7eT7O6y0Gvz4eN/t8qc56p6d9mmP3fpXQBKyI9/ZI2OhJqYdDI9AZeHMaOlfhtqxqk8rzJcLkAbBW5aQRMvGrPAd1mLuo8bwWD91USEz6IsSd5DwUao4eFl/2zg9+FxpqHlFNnwuwEuQ4nRYXNoR1H530jNmzX3pOk0AK3VbuK8Zb860exmOS/Whl2NpwdTW//R6ZlyppMx5+xbPFCb3HuX2+qllG9LLkItScWmkfIeMFWQrfDwJtmpUn7zNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c44IdGhBObZY8L/awtbAGbWlEoqzGFD8kXVMp0mveAM=;
 b=eCkfrcWSqR3+EHK0fbo3DThxbHXLzwBUEr7/WkJXHO7R6yhTXAgdTvhYfTFGyNGoU1zdvs+BvvkBi1dNRXDqZ6CkS3hAzCpzUTmQQSDoxlmPDxtvFSMU5sJ4BR9qWZizzNE9S1ELgiCWm8J3rV2ym5TU5mHEqpKnKj3QRo7bk8amHnGfVNtqmkwGdW7AExN+h6ePah21RmL0TSbKqdblgrID7Ks6KJI/Qnyehkq6Ko7aBPpt9256wBHZBUJH8u2HtjOOo5AZM2l70uEiVW57pGrFz2/AmvYrRkWHgG/BAfvRNXOopC5p+s1fbGewBNDOs4BIh0DJ4AQnxWlVyE13mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c44IdGhBObZY8L/awtbAGbWlEoqzGFD8kXVMp0mveAM=;
 b=rBcxhnnl+fBY0Sp7X4BHJXeBv/EQJ5ehoKblVzIfnVbjdAJJHjb3RVo9JPIBPzcT3xfdXE9AyLkGn0sn2VHzVNZIkuFqz1P43CacYfY45MXJigdyPSDQ8/uE2Edf++UxiTJFPNFbRSPdJcet8dZS1SZpP7Jjapu502DuMq/KwVM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1237.namprd12.prod.outlook.com (2603:10b6:903:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 15:37:22 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 15:37:22 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/5] drm/amdgpu: fb BO should be ttm_bo_type_device
Date: Mon,  8 Mar 2021 16:37:03 +0100
Message-Id: <20210308153705.37414-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308153705.37414-1-nirmoy.das@amd.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.42.112]
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.42.112) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 15:37:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b04e882-0dce-4a47-c2f2-08d8e24810fb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12374C5E9839DE1C545254C68B939@CY4PR12MB1237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlXKsJLPghM8hJsl4irJbNYHsbJeQTpYS3YpOL7yQHjVhmYDx1D7rM+Que2pSSYbHYaDze3i+XOyxyyTtBB5q8RFFwk2Hg6UuKwep+d3gdsV5vefNUMxYQG89DN43ZnQ6gnCvLUoVr1WNmo/GRU4XLH9rXYSEJE7Aj8uT0cRbiEthrcl7SqKrNI8jUsqDmL5wOizyLrGByuZz/E4vswgAPgcsi8M8rI6YdwHLJgu5iIll9CWxYcvAKd5dl9LDlJGLd50d6hdhW11UUZeT6T4+LIH6bYLdr+/SJ3sxTlfSEmtLaklppdnscVUlEN4k3n5N6gyb/vEXB3GquXRAXfwnY30Ro2okT8BKGxys4RSC9dtMp5UrEUfA8lkX11OsDYbQWfygfmmfgJdLjp7BWOKm1XR0sJexkypYbyZRiHmrTgVIbDLPtQFNXAC/3Esmwrt85BIY0oWzB6dOzUQeYTjszxPWQRzJb9TOamGaEIr/wDo9C9i+mM/b970ppK4ZQkDSPMx7d4jcKb3CPy0Xjd3pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(186003)(86362001)(44832011)(2906002)(6506007)(16526019)(66476007)(6636002)(26005)(478600001)(36756003)(6666004)(34206002)(37006003)(4326008)(66556008)(5660300002)(6512007)(956004)(316002)(2616005)(83380400001)(1076003)(66946007)(4744005)(8676002)(52116002)(6486002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HOJIftgcN2FJ4bmbHkQqYxbbXhX6b7ri/JN4Nd5o4ClbQ9hPeKBeZvS/yYfO?=
 =?us-ascii?Q?nBUUJlg91wJSBEd5Y56aQtUuvLLvxp5pm534LYOpAXEUtaJJ5ctVd3MFx5Un?=
 =?us-ascii?Q?Sb80veq8Eh6XRnkqdXVSbbGLLtPIhpA/SMhzzhIfxg2gTTFb8L0Bq1N+3g+2?=
 =?us-ascii?Q?/r/MnkoVTRgIb1sUaskJSLzGRTAkUaW5l1PhvJ6JXwq/1eiHnexquP5ykMod?=
 =?us-ascii?Q?fwkyEe8UYUvHf+RtRVtCKr8w3D//QfrPm3mwDr/feRyj5zObj+yCUQ7M3gxO?=
 =?us-ascii?Q?N3/okPXCb9KuiI001W/erJ47O0Ftv2F6+YlVd2pEa/lJtHZNAS25h9KKx59R?=
 =?us-ascii?Q?tXqZCzU6ePjT8tAV0waYx8VEv6MuyL9R9XFuGylAi67TiNaoLOt6vJOJqYnh?=
 =?us-ascii?Q?0dZmBdEL3T4hySfC+NuTqjpKMKyWhp4fDy+0KcI5zTLXW6SX7W0n9gv3wlz2?=
 =?us-ascii?Q?j+21xZm3IcfCaJZUNU0S05tyi9B8k1M7fOsMNfVn1wMdWVIp1brSppWX/6dm?=
 =?us-ascii?Q?YbTrQBUpHDHkusNvmroqkOoKCGU4WIe4gKTro/6cHDkxoSCECosj1xbDq4MH?=
 =?us-ascii?Q?8mskmA2I4t3fbW03MVIOd4gg4k6QPQ5nr8/YyFKBAYPH22dpa4pK/a97Sj74?=
 =?us-ascii?Q?HEBBD37WbFtUoxW/L7CeKRuGSee7I3K6jcFe/GcqIc7qmJJDykO30R7wcNIb?=
 =?us-ascii?Q?CpjTEqYGv2CoqbYLD6bL8qgLu5R/0qYmJW8nhiX7Q2YX3VS2zrNfNJw6EAVp?=
 =?us-ascii?Q?uKFnHO337T2BRmUQdJtb0mURknAlbWjAR/oy+bgoVi4QSiCSgiVaL3UZIpxU?=
 =?us-ascii?Q?PsWvkAuI9PoYcGsZ0tP8ZcbK383CEbctUZWW5Tagoko1B7mfMaeAHDGFla1F?=
 =?us-ascii?Q?6tOEHv2wn3so88dctQChUttBu1J/3RU3KJ2hCPkRk0tftDGE5Urps35TxSyV?=
 =?us-ascii?Q?yS2P68t36dCCeFpkqFVtQm/jU/yqROO1tDiBOO0y0vv1NGnfF6/QOAr2vOvM?=
 =?us-ascii?Q?JgWxI+239E6feLxoyYUJwBSfkjUOYCJEHgaqv9e5pYcJkILEEoYdI5DaIWLD?=
 =?us-ascii?Q?BReMXsD0sG9JqlH4LI3CA+aHfuMFblR42H4YJWg2g9f1ldmKyVoLG7tCzL/6?=
 =?us-ascii?Q?nsfGC0hRxpNG9B6QXWGAJNNe5EQW592pCKc2xNDBiX/9MBy4Lt2EBNvVq/us?=
 =?us-ascii?Q?3+DagzOS1IkIW9q3jzKJDUAFwWr+yb8OybeYdKnJT6FyezDx0CliVv8JlovP?=
 =?us-ascii?Q?yEpVwaUSUnN9/6d4J++xOWBMhvx2PHqbSXrwoqIaD0vGSrn94yYaZDD5zgQM?=
 =?us-ascii?Q?a/1XhDNV/DHWY6HRGklJDFv7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b04e882-0dce-4a47-c2f2-08d8e24810fb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 15:37:22.7431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAPiWfwLudv30gQDcCWTAxbEiBx5hJaCxPOTsDj4MgRUbwM1L2SsJAWVqKLYiOZzXFC+4PNINsmFUtiVXUZLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1237
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

FB BO should not be ttm_bo_type_kernel type and
amdgpufb_create_pinned_object() pins the FB BO anyway.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 51cd49c6f38f..24010cacf7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -146,7 +146,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 	size = mode_cmd->pitches[0] * height;
 	aligned_size = ALIGN(size, PAGE_SIZE);
 	ret = amdgpu_gem_object_create(adev, aligned_size, 0, domain, flags,
-				       ttm_bo_type_kernel, NULL, &gobj);
+				       ttm_bo_type_device, NULL, &gobj);
 	if (ret) {
 		pr_err("failed to allocate framebuffer (%d)\n", aligned_size);
 		return -ENOMEM;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
