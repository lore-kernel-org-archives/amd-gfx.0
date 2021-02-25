Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C57CC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351E064F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351E064F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7129D6E1D2;
	Thu, 25 Feb 2021 20:16:35 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C196E2DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 20:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iou43qDzUM1ux68g8ty/IkEoIvfPQT4Nej7AtPb+Po7TIhX6MDd1162nD/B3rcimfe4bL8W+iuKqwTsHxfWDfb4Qk/2VHCyc9T+HskkQQilGOGbZcGDiNV5qU3ldR8++uwDGXJRrB8HF22vgu1SLVgesP3vf+O8hTaPg3sarFsQcZdtdXzNdhZYbd1mGfRUySbUKxx7qWUyasJ7+bGRZVW8fIPbqEydWWVYYfYLcPfq5/OP5dXXmmtMavC8YR6SxZEV3F3NyIlvqojmcnDRKkWqlz6ujzbctj0ty1Pe3/D6QquZtcCV/Y2BJOFNMbIrnhq7IsjOQHXfG/ygQSeLRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKcmJ9VfhyJ747zw1nfdh1n1yRQPDLWjTNmPe+4kfGI=;
 b=E8y620FSlCjW11FjKiwQ22BWKP5ExCKFLjJNUtCMzcdstrDm9vqQQ0pweCxDenrYfg+Uc1uYIQWRhFqN5NxKWJILMW9c8ay4dILK43i5abW8o0Bwrydrz2O2rZ5HgbxmwhiI+Y5I75WByDk8YvlPDbwm4/cVvplm+zMV3iibTcPt0RYIxhCi6eu7f5rPZECcnjMFEUmE/ed97+xXFwjsp8emcUg9hqqXLpwDJ3FqSjCNiShXIkrM6vjSKwlVeWnSJUTb3TMgwrBcKiHPXldLerpyR5u8WylwkVEwZPFeob6j7KlaIDzpI6ymaYLsllm6bmb7RjbjV+MVn0VHfQeyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKcmJ9VfhyJ747zw1nfdh1n1yRQPDLWjTNmPe+4kfGI=;
 b=hU9sYO8YNbAEnKSjZzhkikALayk7JAekD41SqH1Bhpbrdv/6m+HoWPkg2dhoDmkBZabSQVrBhRWSUchoE4C7oNpnijUm6TYVB9lUGn6oA4PbTSjtBTyPxByvjH7m476DeaNTaOOilrGSBdr3Hn21X/ntT7FqtbUY54o00NEWGOQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 20:16:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 20:16:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: bump driver version for new video codec INFO
 ioctl query
Date: Thu, 25 Feb 2021 15:16:13 -0500
Message-Id: <20210225201614.896990-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225201614.896990-1-alexander.deucher@amd.com>
References: <20210225201614.896990-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:91::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 20:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 913cb7ea-9f5e-4f26-e409-08d8d9ca3de9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB387240DC5A9B171F42A9AE05F79E9@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKaONoPPiFwM7KaEjCmVJdldkNIaOh7y3zN0qp9N3MO/1idnj8pDBcc+K/ylS3EfA3TefspFsibIRuNk1H8I2v5FxX4orQNAGzJDNihczNd7H8vIOcWm5Oem4FNnrlvPZOK7RtwbBSYQplEk0UV5ZXkHooxYODdOfyn6IIcP4sV+Fd3nMZomtE23ez48h177El8cdssOBMVJkpgdr5lseiNENgHqu1IlOtB678CCubm3ltYEL+2EMkYCI8yHtYVTMiZx4iTOaGGJQrWLslE/UOAQRIlYakIwCtPrcejUIDwLwCpXMwHLTVaDdMNedtrUDh/HhbOVTnRf2wOGGaUP5DogqQ2B/d7Vqg1J3v+YeWXKuxJRSAofhXVa6qVhlSCzRZFxelwnWnXePCFa4D/8il9dMkhTRg8fIrIuZCYZexxbegprgAW4K6QyOmL89a/inMEozdwVWxB0MTAuuvSbD3gpD6d/ddm4+PYGcMjekYXN75tbxUYpMFu852KDAViEl3HrYLHBvd6Bo7R2RPVnCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(66556008)(316002)(66476007)(26005)(54906003)(8676002)(4744005)(1076003)(2616005)(7696005)(52116002)(956004)(4326008)(186003)(86362001)(6916009)(8936002)(36756003)(16526019)(6666004)(83380400001)(5660300002)(6486002)(478600001)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qarwmjX10gdmFs+c5s3+IZNyZYNVKC5tIY6axAw9p+tfyfIRvBQpzbU0/God?=
 =?us-ascii?Q?VxMnckITM8wN9o0DXz27pKTHQbLSNrMugQ71ttjrqEACLdN18VQKrfqOV7yG?=
 =?us-ascii?Q?J2T9QPb3trWZ7C+SYJgz2XB3BqY43qsLNfxMuNhpOwGz8Lz8b78UdzSeeSvI?=
 =?us-ascii?Q?wf8ui/8p09ZNPW2iF8olizObqARZ5dd4i/YWOI4wg74/sZLjgx6ypuv5roOn?=
 =?us-ascii?Q?SJlz06YCo/0IeFusmsvHBkZ2e+Zfzqox/6gOS3AdQblK+yXoVMuWyF5Mkw6t?=
 =?us-ascii?Q?NfNrOCy1x593R8TUS9znhneo/B+oioC5EjX6csT4ZghP2rLmZt1JM48uL+BX?=
 =?us-ascii?Q?PMAboVfikwX1vVQ9VscIYJ9ugBzzIl0VAt9IOzpjpmP27oaUlYVNe0aib9Os?=
 =?us-ascii?Q?66DTBeQdDYSquXrxczFILE8+pby4sQdAXo1XJUXBuFkmEGvCqF8poCxVhi7H?=
 =?us-ascii?Q?jJh3slZVQrq67e5qW8P5Sxkf7pkp4wVIgoU3HetCCjyy1YaPybucyldLTArw?=
 =?us-ascii?Q?P7cQntZsiMttquMw4VLeETEzhU77pGH0Q2vIsVrSMESuTUj889t7Pjj3hTWx?=
 =?us-ascii?Q?cFsWZz1l/fGekEZbUEuLZaRGcXe5dspgUSc4R+Czn5D/89m2Mi+1jbXvL7ML?=
 =?us-ascii?Q?hww5YW5zn175mbu5gkp4t5xH36ND/uM74ksPJxYx52owIQlMEu+v0vy3znIC?=
 =?us-ascii?Q?3jrET7JDWEiIi2Ob88Js/tf2cNWdHtJs+1dYXzulaTy/bp1ZNY9PhbgmblWR?=
 =?us-ascii?Q?BdlQxFlK8gwLK7XmSlF093PIIf9GoIyL0Yp/3rxMQfaVl8kBoAzmG3siRLOJ?=
 =?us-ascii?Q?5ZM852oNBNG0tp7SmPRcDhaYRXbqEMuJM6TzjnChWuDu3UqyKXNrLV2G1kMg?=
 =?us-ascii?Q?4GnZSky4AqCRVbs7Ww3KcvZ+okec2kkbAADYFl1Je7PfvnDyjPZt+PBQ8bKb?=
 =?us-ascii?Q?shGD8yAix6TTgPcvlRCksLiHRJvPbGaS2h+oXXxmP2Z3imOk1b+qVf6lOupo?=
 =?us-ascii?Q?H5MPKfXNT4C7ngDIb5ryfPsv4pFnoov9LDQqHv5MrJ+GJByUsA2xtWDCcav2?=
 =?us-ascii?Q?6Hthv9tHfO2DavQxs3fvklQ4zMhHgd2mMlhJ6rtwjO8fCGgJQ7D3kijEugyl?=
 =?us-ascii?Q?Mtw74RdCcB0HLQ1d3g1oRB/14jebm1LbHCTtwhA2FD6vU7+UC/hAHrAI2LSp?=
 =?us-ascii?Q?bI2OWUHiVqIYncGlD96i1uJu4ayYLizH1As6cGxTdXfsBRpBubwBpKPni+rW?=
 =?us-ascii?Q?mNoTLsYl+cM8bvXixGHq8v6AD+0ekzo0dKcbweudz3+r914jVCY3jPTRZklN?=
 =?us-ascii?Q?do6nV/kLcETpyWkBW0A/rXTY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913cb7ea-9f5e-4f26-e409-08d8d9ca3de9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:16:32.0704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPV/n2XzrJOEYZQ/7/94zcUjuLvfpd1qSf9AsUW2vMDy4BpXZyjWEm5pE/dOQmzakKqUXIVfUhE+2xukHapbKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So mesa can check when to query the kernel vs use hardcoded
codec bandwidth data.

Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4575192d9b08..4acfb136a295 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -90,9 +90,10 @@
  * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
  * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
+ * - 3.41.0 - Add video codec query
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	40
+#define KMS_DRIVER_MINOR	41
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
