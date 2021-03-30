Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A288C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F261A619BD
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F261A619BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3AB6E8E6;
	Tue, 30 Mar 2021 13:25:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1A86E8E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 13:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTmJe1ZahZmwzGIpqNVFugL8AsOd0/cqZ/wFqg8hfPZpCuUNvpQQcFUwg2WCQ0akviJabFRYim9pAvk48TqYu+DHrD3ev4bkJISlS+6Bjnb7VU2s+v7VGw9jzG1Z+LodUhVHFOJBUkPTY1TaFWcdafOALE5tbEu/qeGtPYaS/sus0dfiikK9UtfRVR9dNJm4A+LoEs3Qjb9S9E6k0vOqxOr1knbLWk5y0XTxd2CfejNku2OZLNMs+HJldro75YVpOb8Yp5QCBDVzPIOn1LERz6SCfLdburzjS395E+Cs4s3tbDkTnim2mg5Hxy8kszAkCUnhgHS4mbdapo4FCpchCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf26+z3vaNGILsgnl/Lq+eNl0QN3pXuNb0vHfUN0d6o=;
 b=DhxcQ4zLh3MymLqwZCPwx5XcqT8g59f9zC6pHI/bvYXlQqRfzb4xjqWiQXUgSbn3XKlyRVkzocLMo7Oln5O87N27FtVC/IJNuZbaaKIUoa4QEnpF8oPMioKJzhx1VEWw4z6fLy0Pvgf7GFHSjVCtZpdqmJn/fSTarvSoQe9PgnEnlyi1ln2XJRh9gZ69baTgUgzwAlDpacZwUJ66KtOAexoDK9Es/xtkLWodBp3xq/ajQZpflt/Aby20NgZLnfOZD8lB1F/k028UkDpZuCDVipVfvl3QS8ZX+OnreMJtMq1SuYFAyyKke8rT2QoyYw6dKRpFfrXUoQu/C9wrr+WXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf26+z3vaNGILsgnl/Lq+eNl0QN3pXuNb0vHfUN0d6o=;
 b=sXzcVBso+jb0X/UbXvWB+EUdnvA18LDFyLur00yBIjL7UDFGBzLt43wi1sWm0YjXnqCoX5xJxT0tag94vKID65zjltmOBOPqq6D2MZNLx2R8Cw9XLeo5quewCNsKqc39x2qSp+OMhlCvnyyp7A6hThZzHmRtMBpppV9XUSThl88=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1414.namprd12.prod.outlook.com (2603:10b6:903:3a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 13:25:16 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Tue, 30 Mar 2021
 13:25:16 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Subject: [PATCH] drm/amdgpu: fix compiler warning(v2)
Date: Tue, 30 Mar 2021 21:24:57 +0800
Message-Id: <20210330132457.32494-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 13:25:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3dd920d-f3c4-4de2-2dcd-08d8f37f416d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1414CAC3ECD5D78D8DB3440BF17D9@CY4PR12MB1414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wulU9ynaBOtyTQSu2m2bFozXrOnI3lef9YmEYGJ6Qqv71Fm7bjngcPtZ3IyL5UNH44Phjo9+7vlAOVS7hDPW16hozsqPGq5PwHYxga67PJACbvnP3Pg9k6go7J0ll+E/tKohGu18xVGwVjQ10fDrdgWBfFLyX6zTnU2KlXU0Q74QpDHHg4rroMnMmVodS09YzVmo/9fqCQOVtKHRUQO85F6Xwuz4l+WjaUWJT8pivOHCu/YKzmYRcQmgQKoQs+zervT6aNl0wsIg7vYjAdSkEBgs08rNQirvOig1jzFx3fHh3gUPA71ETpK/Oaw47guVYKkEmXoHve95cDqxWN6UCqAAEPdXO3lZzRdL/d/b9NR3k2kyj5UQ0EDq/uypjc/TXsFHncG6PmDjOYstCD5wqwkJZ0oHqpzL3GzxeIrt+GhnVmndVBizjLVgt+RvxYGzyW7kjkEboxSTXMqPnn9b41Qd4cqFecfIWUREgn7IeJmFN8ljcFmflbJoMdcWXEbw+Gvk7ybGbvsj2Iht1eLxBorq1MC0Tgyas0kbRAG8Maev4IstRzk/bZt+M+MGDWMjchmkJkQ512M8wAmqJnYtgzsZXL2s2wS/AJXYBtssEqv9fnx9xwYOGzh4/qAelHMmEDw+LLzYN9hYO35YHj+Wjo8NPZVYOfWBuDwBkI4TXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(8676002)(6636002)(8936002)(478600001)(52116002)(7696005)(316002)(66476007)(66946007)(38100700001)(66556008)(5660300002)(6486002)(1076003)(2906002)(26005)(86362001)(44832011)(4326008)(36756003)(2616005)(956004)(186003)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VsJF/FxVxs9XYVtvmsVg3rP1nSPP0rnITrynWR17cVJpaDbZyKGOAP7Zr6Pj?=
 =?us-ascii?Q?blm2uez5ynZ+U1euy+mYHo0+kSZlXwQ2ffPHjaDsaxdAGngBB32dQCZpGGI3?=
 =?us-ascii?Q?P0b7m/v6DpKaFWMzOyrYjBAUikAH2AuNkdZWepMAeuGvxk7Gi/2CpVUMD+8W?=
 =?us-ascii?Q?Jwngfu0rQEHUlNGT24w3hO3yf9IiVOFETdd0HnPZJt6oG2utYBwQX46BtyFE?=
 =?us-ascii?Q?H3H46BM2ufeYGLECgBOuyZM/Lx4R4qIvhz0ndox+bQl59xdAIyiZluUddxhY?=
 =?us-ascii?Q?dhF99Kp+Yn53r2VdlEHBV2uK7L98QvGPGig+YTYjnzD+KKCdOW1l7aBjyJgS?=
 =?us-ascii?Q?7EhJoe3pc0NsRx3oT4AH5SxxB/bgIiHJ6ufvy4qTevDkdOyKqATg4vMLQFdI?=
 =?us-ascii?Q?SsRAA5t06thYlL3GarwIxtBQTi9ZHGOa+ZgaY0tBemcY/LcyBgrzJu387vuU?=
 =?us-ascii?Q?Db3nB75Caphpvc71jjDhgou9wj4diwaEqeutsoB7jGGbI/PDTnPWnh1zo2B1?=
 =?us-ascii?Q?l+eNzdiX5q5eP6/TU2ev/1UvSsfiPzTg5e/ziqLjO0hIhYd4Fs5/8JVhShXz?=
 =?us-ascii?Q?PORUpWooizdm5zJvrTod7Lq6hb5+pCDTgWJUQSWmRqWw5dLPMc68rvSiBjQ1?=
 =?us-ascii?Q?H4OtoS5G2kQUBtylo7YyZhxdqk+TeXSBGZ0Juqbrqc6DIWloBfPk2BOqmEZE?=
 =?us-ascii?Q?guAqpRY0OcT61QPBGdGejW7e4/3LNUmfgCrvSFO1OzwR5Ezv+AFBJMsYlh2L?=
 =?us-ascii?Q?IoMmrNTUcvIorTW+LgcdiWpPmyICdsWIQohhlskL+mPfE2bmhoYTR2lIEitD?=
 =?us-ascii?Q?XdaakJhwjxyy8lrJ2k8bjMqFE88BV9DfJaoKQBMShrboA5piuqFEdKj7OWXT?=
 =?us-ascii?Q?0fsmPH6AHWt3HXgcCcCt3OYv5HHpotm+BGRmOv9+kkH2hC7tMFz0mBORTzMz?=
 =?us-ascii?Q?dq0iTHtlkJD6EOR+DuPi/bDd5YXgs+q2pec3sLqXYozzZNvbe+FaX3aOliKX?=
 =?us-ascii?Q?+z014USyBVweTER6GYhENmFz8U6SVAOA5sq3agWqEgYZH6ObjaEGWYKmp/T8?=
 =?us-ascii?Q?ztLIIBcjcXp/UNL5zJU0612I6MeLM9YAIH+PAv/vcHRoWKUPjIiDC16egOyP?=
 =?us-ascii?Q?/xM0bStkN96Y0RljBr1W7SJBms0jK/v/b0nhLt/Av8XoeEz7htZ6/7KJYGER?=
 =?us-ascii?Q?rlev9Ug4tv8zX4RqzBktmtTpzwzEgbgYp5Rt/QzRnyDYrCbJAhBesXUXTLPu?=
 =?us-ascii?Q?nxgWX4DIwpqJPfw71oZfaS9S7PHv9v3yxL8sp7ld3PRK7AbQUYhsAoDaPaQ0?=
 =?us-ascii?Q?r3fb05I6asIL2c0sKkReJiFh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dd920d-f3c4-4de2-2dcd-08d8f37f416d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:25:15.9054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iklhMZhkVruKMf5fEHt2qkpdQ+sdoADuDISSX8YHkxvS/ITkhvB0Wkxe87HHTlK7I/bO4zkpdD0TxI5aGrpCwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1414
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
  int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);

v2: put short variable declaration last

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 722efd86718e..fbaa4c148cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -823,11 +823,10 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	int r;
-
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
 	enum dma_data_direction direction = write ?
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
+	int r;
 
 	/* Allocate an SG array and squash pages into it */
 	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
@@ -861,7 +860,6 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
 	enum dma_data_direction direction = write ?
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
