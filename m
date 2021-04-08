Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68054C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 13:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4026113A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 13:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4026113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5366EADF;
	Thu,  8 Apr 2021 13:13:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D156EA2B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 08:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJtLTEym8IQYDllkGGwLiuXaWKwUryaeaGzHa6SlYemQiufrPz88qJvSWgGudDOVzmyN8WOv7MVZHI/zYjqwEv+22dmVPdHl/D1pL+b/ya/in5AYjeiV8J3Xe/LH8Jdn0+pCPdNAf10IgtwccGa9Cm0dUbtckn3ToQHVWYVH9x5k801jW9JuZp5sW9Rhnj5BkxPgY8ZniEJtD/SMx6OBtseOIbL1L0uUnSOMhASUEM0gAZpkQBWwAe6WMxcXYVfwrFdSHLple1b+tXSyzF8MjpQxghs7jGL4+LJuum4msBIfNsew/MGzRSBxe/ezjcTRwUkI/CfJBGX9GpBsKfbw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGQRUzUgRradEhh/rD0bBqBFvBuzQh1TgyT+ZXW3VA=;
 b=FWs8HEZaZQl/h5dP3e16BCXBJEfJb6Ghp9YAcB3LSZDOG1hYgIK8CTKqAEbf5bLE/4Kg/BWsMc2QHWDjPR9kdL4LlOQ8x+NuafO8b8BBAbWscqST9OuMkXHuQa9NjsJZ5x38KJC30v4YgeFqMoJL9wpBg5Z01VT1he1Xf+scx6GEW/pQQOLh/PTYqJLNUBOubZg1zAv6AG4BF87W/srCH0rbi8jAp7/MhmQdqTay6651mIhonYGzCBQHnt1faphm///sgM1SBF0zzKBFUQuXOPVKguUkV3beSGcn8t8eoaiPzyl2RDQkOFa7ai8X5CP/pSn+rnht6rs4C/oxijjemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGQRUzUgRradEhh/rD0bBqBFvBuzQh1TgyT+ZXW3VA=;
 b=w8O+1jTQuNUgdOALJcCrO61UXPb2GXogCNYrPnrEAAcACJyppkOx6ygAXScK2Q85yzY2t8rAtn29+m2P4yQI6azoBvAgj8a0/SpvpzBTaBSLR+GY57siB8w2tSU9DcPVZjAaSTB5erkzqN8OUTPIzutnccyow9iFscg/gI4uKHc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4757.namprd12.prod.outlook.com (2603:10b6:a03:97::32)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19; Thu, 8 Apr
 2021 08:35:33 +0000
Received: from BYAPR12MB4757.namprd12.prod.outlook.com
 ([fe80::78ad:8c8c:13a5:3c3f]) by BYAPR12MB4757.namprd12.prod.outlook.com
 ([fe80::78ad:8c8c:13a5:3c3f%7]) with mapi id 15.20.3999.033; Thu, 8 Apr 2021
 08:35:33 +0000
From: jianzh@amd.com
To: EmilyDeng@amd.com
Subject: [PATCH] drm/amdgpu/sriov: Add MB_REQ_MSG_READY_TO_RESET response
Date: Thu,  8 Apr 2021 16:35:11 +0800
Message-Id: <20210408083511.3033545-1-jianzh@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:203:c9::20) To BYAPR12MB4757.namprd12.prod.outlook.com
 (2603:10b6:a03:97::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (180.167.199.189) by
 HKAPR03CA0033.apcprd03.prod.outlook.com (2603:1096:203:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Thu, 8 Apr 2021 08:35:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eae24bc-9698-4797-4912-08d8fa69463d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4322D1B979C5CA7325DDBD8BE1749@BY5PR12MB4322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdRN0DeZczVTrovrkNarXvWqw9Ervwt4QutFTJS4He20V4+KLjEmfr5bgDCy7sD6aF6KoGvpXqJzafV9ncVtg+k/kGYr8yRUDSx6RicnnwRx3GcrumwCQYf4RUp5gW6wNNIdEWYs9hpTbNhAHqm8DyFhK576zL5vD71z7lPo50LGqx77uVSoJMn62QgbDQN0PUqUBwIleGp/7BUyfJJC1yYHyhC3NJ3eQz72CrXCZfVsfeYELDBNgEbnVDjN6oHhkuX2v8bwRVgZcYaqQ6vxbYiloBCQiNAe44Gvd4r7PfHzWe6ViaOD8oLOFlLujIabb3DExiRML6C2UgQYlIrVMwi1lfbawqOneqe87eeJpnXxjRvl2yPTdNRpKbUWlb+LVxKTVDIanubnF4tLOf3s5hVxFPF81cCYIoQ1I/mpVerKNKTCqDQb4vMRvpUP8uIfpqqG7hxSe5JpANfWW6tH6+CWec2JJ/RPf87miKCbmLnWAWFZY5ujC5ovGUQ/43zNQJDm5rOeTQQS5oWHJb41CKxtkGJeGCdQqxu46iEIScqlE+I3S+EqEtSVkHd3N5ln534Py44f8hG6emZceUMEFX6EA5ZwmRKZtx8WIZocEmNHsttrh9/RF2yV9Od/U7XfApA4/bquUWsYz+wRXA/haG2Vw6/R6mYHVgSNNTOp/Xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(316002)(37006003)(66556008)(5660300002)(66946007)(66476007)(2906002)(36756003)(1076003)(34206002)(956004)(6666004)(7696005)(38100700001)(52116002)(83380400001)(2616005)(4326008)(186003)(8676002)(26005)(6486002)(9686003)(16526019)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xlEXcqeYF7As9Ma42EwImUJdAXOyzBYlHB/7vbIFY/sJ3nRAp5TL26gtwS8g?=
 =?us-ascii?Q?kaj3mrXLyq8JSSKnKSssP54h5ptnKD9l6/Igm2zTa9sMAZMXP3zfGpVeStSb?=
 =?us-ascii?Q?dkCUAVDk6ZpUCC0A2g/Rmj5B9slbnPTTY7ij4nOfWlzHr8LiwNBtYgnIhb+2?=
 =?us-ascii?Q?408/cXJBYIOey+d7sezn5+yf0n+gLOXMboqKR1VhUnYJbQGDMbJQ0krkd5JM?=
 =?us-ascii?Q?Kz9EvfaDKiLIwOzWl9XsEVL+eMFfR12SPoWnt19iILTjNXuYq12EARdH+cKY?=
 =?us-ascii?Q?3cgRID6h1t8UpFuds/2RVeQBem2L13JERyzk3PnOb0il69xICDtO++XMCYYv?=
 =?us-ascii?Q?YyRe0Wbc5WV03k8qgBYkP4hvkvDehS0V/WW31ezbeNxOFP8JwNpLbsz4l0AS?=
 =?us-ascii?Q?Z6nGc1iPFr4Zja/Hkfd7xKK8Uwq6te6rKMApHf/oyGKfAJep+hDl0BcKWfzd?=
 =?us-ascii?Q?ZMGu8N5abMIo+gSdGmmvgXF54gSoR0V21KZLZdSyqS/FnIB1HEgqQ7i+n01X?=
 =?us-ascii?Q?0faCryoPu4sCmPpEXGxVAwBHwWpM6i4H8rK5qzPsDOQSBYkEZ1wZ6t6BPlnu?=
 =?us-ascii?Q?YRGXyBOkh7+rY6TdqPTsexqoYnJcdojCbtiETE3ZgMkyTh6j+ZP1NwzTgwhy?=
 =?us-ascii?Q?0sMrndcI6MCqISJaFy4Q8PGrRo4JAB50feF+ulo4Wvr+AqZ3iZATgZVWkAc6?=
 =?us-ascii?Q?4xVJkISKd4dxlVvMpzbz0C3uhP4Deq1LOQbEjLu0h/smy6Rz1cbBNEC+vrRc?=
 =?us-ascii?Q?D4mBze91GSFOkVU0/13198zCe4FXoOn4COAY6NWFAQALpzcHLUjYBoj675nS?=
 =?us-ascii?Q?tNe5K+ga1m84CrT+pqXTcbCrwkb+4oelOZbwVY7KRs+XRZ7O4xerdZs0gomj?=
 =?us-ascii?Q?BYS+Lb2HpW8Y6DxXZE8RQUkiPXf9BzHVQE9rY76bDzR7pUsQc63RSsUDPdXd?=
 =?us-ascii?Q?FtD00eydnPeV962knybd0tulMUiovD2sRq8P1c3V7IMjqy5UjMpDxjahglR9?=
 =?us-ascii?Q?ftBkSyKKbkdo0+HfloGM/aN6OL1OJP0/QGVguzVHiIxPC3ZPny6pdK8PCXjj?=
 =?us-ascii?Q?wbqQ3sSrBGKK9O7YIh87IekZSKZQzzQ3Rpk6nzPfR6uxfhysJ9bZdM+CHb9S?=
 =?us-ascii?Q?bXxI0WUyQlM5NzDXDxTha2M3uRxyAQya5+kDFmXrkKgUipUW8OmYH/EI6gki?=
 =?us-ascii?Q?hldfXF1BnZ3DUjFwkyeZcdSDc6FEyTrLa+uIuk4UXgQHk+AyYgiRZHxFB1eL?=
 =?us-ascii?Q?siKjyjSbWylIIymsX+XXx/HSTYVxm+jZzZOLJ33bCnnPXjMCPYomTbZP5cEG?=
 =?us-ascii?Q?j5l4JUuWWrKMBtSFk4mUAv18?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eae24bc-9698-4797-4912-08d8fa69463d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 08:35:33.6243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rb6b7O/7GTGoZ+GYuVWN79XaR7KbeapySHYG2KtQ1cKe0mtVG2ufBsGKbzOih/3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Mailman-Approved-At: Thu, 08 Apr 2021 13:13:52 +0000
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
Cc: Jiange Zhao <Jiange.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiange Zhao <Jiange.Zhao@amd.com>

Add MB_REQ_MSG_READY_TO_RESET response when VF get FLR notification.
When guest received FLR notification from host, it would
lock adapter into reset state. There will be no more
job submission and hardware access after that.

Then it should send a response to host that it has prepared
for host reset.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 48e588d3c409..117d22848ee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -277,6 +277,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		return;
 
 	amdgpu_virt_fini_data_exchange(adev);
+	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
 	atomic_set(&adev->in_gpu_reset, 1);
 
 	do {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 9f5808616174..73887b0aa1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -37,7 +37,8 @@ enum idh_request {
 	IDH_REQ_GPU_RESET_ACCESS,
 	IDH_REQ_GPU_INIT_DATA,
 
-	IDH_LOG_VF_ERROR       = 200,
+	IDH_LOG_VF_ERROR	= 200,
+	IDH_READY_TO_RESET 	= 201,
 };
 
 enum idh_event {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
