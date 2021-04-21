Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C6C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 16:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82B66144A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 16:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82B66144A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300926E9DB;
	Wed, 21 Apr 2021 16:36:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6866E9DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 16:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPWC/bpxJ+2/vFzGSlJ/mLmJLNuepkNHwnMz6QvBIJWBEdHjsxhTu7f1aBnVSJzn8hw0oPrbNiMtGGnfMDWsT/3mcD4G6qJge2cNpX42q4XJ7IbBQ/qbOkUFy4NRhZ/eLLnUxUEt+mKRdmbUP+DK2iTCoD1SGzSKw9pc6Klrw/+aciKj9MIzzhtYyQ0DmwSsvLCNxLMnBSmxZXsdT4yTUK7s/zahaiZl1nf1phFGfc41NE/yx2nskXUxz7GtH/PVP/b6tXbJ0PUi+B9quSq7ue1DQw5ZzUxdjDD/D9zCLKV4UIkowAyXyYflFAxWzk5LlKZ2DkQvXi/0YnUp/RhcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfu6Eap7ppcJ7xmWl8DFBefCgHAfNJJXRc+LwwK4DOk=;
 b=O553P70p9NyfaNFm/N2pDzzRLv4fogY84SfpjpBxz2SFSaC2/bdE33V4dEK14KA3oQvVNo0aYPtFhfC5XI/wVyOYmIucXILZ4iHmYsBVmNC15DnMNzC8n3m7rqPvIqOViAHTefos6O7xJkGVMwBOrazzRjhKx7DLg1Z/PL7vNlJMCd7WqnjVwI9hJIbRFCbyURU8NK0FSs3CaLBysaro8wNi4oFJ/uJARZMrHMcVGx9h8Df8wLCGrUeBPNc8u0rb597SoVyVIxwZd10T6+G0Zg6bErxaD5FwcQ4MX0m43nqPmQWThioOt1OvdtJMYJxRhSy/xZYbWA+FkA7cksp6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfu6Eap7ppcJ7xmWl8DFBefCgHAfNJJXRc+LwwK4DOk=;
 b=2sh8ZeiKD6/RaAi3/qSz/UWuTw6oGOcOALD8IhFm7a6mI7/Lz2vi4z+qGLB+7ieRfVr46ACOEVh4Q5HHPD1zEjLhbCs9mzlouvAYpD3k2lvi5ilqqjrKbA+Xi3PQQO4fk3+k2pdip7v0j7pxygFbjWFD2Cvnbrzn3Uc3h1xTt9M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1237.namprd12.prod.outlook.com (2603:10b6:903:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 16:36:06 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 16:36:06 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/4] drm/amdgpu: remove AMDGPU_GEM_CREATE_SHADOW flag
Date: Wed, 21 Apr 2021 18:35:23 +0200
Message-Id: <20210421163523.14493-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421163523.14493-1-nirmoy.das@amd.com>
References: <20210421163523.14493-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.111.123]
X-ClientProxiedBy: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.111.123) by
 AM3PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:207:5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 16:36:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cebe017-4590-467e-c6a4-08d904e38f8a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB123704BEFB913D9D894CC3FE8B479@CY4PR12MB1237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihnyPSTEoxcbCRihDr4E9WaBlGM1TayejN+lkXrXqflm5opjkemokdAa8kD/MJZ6RXV3rnqKAlRF5VGewQVgl09Q0Y7emQrQoQphKexB9mZpEdyJjZNNtMJfHolLRJcp2VBkQ0pk8E0llfABv4PQoHpWZS45RCIbf90ds2P+Aww/mq/4lnKaTljcnuwVcOzuJ/5Wd+P2AXI1d4xfNZ1rci7U852P/txcqSgQQzrV1kwuZPqPFLnILbSzAzVvgt+YZag/M7scucI8SzKHL3caUgUAoxe5gVt4vVbJl0GOzSl37BNgTjrZovOFWpU98xCOC3U16Grb3eXl3ushXpfO6BimyJgIoxw8NzqOjX4A6ZDV9Lx8V6LteHqpq6a0dvp4By3IDKeF5XHGNpRtGCE0gKpgrUKf4U1P4PF6Maf1jjV9O2Tf6EjF6qXJtFUuof7yS6KtqNsAntn5x1jBmWWYBpsmoAHt3BX4s9AXlrM6vRvAbhC1T54ApuT8Vb6jZ2T3Ap2rbRBCE2Nau6zSNiw4iPZX38nZD8e18mDuGDqJvUcHBgx0LSCaL3AStLMWd1PBNQSy8hbLkBTccpUJrtb+pV8dvpt7yDqPZL8s2jSYFkDr4V20/0HV9x7tEubmtlgt6eRA7RWNg6WW7U+xbzRR/ipB9rfF/bVSt4+59cYSEMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(34206002)(6666004)(44832011)(316002)(6506007)(8676002)(4326008)(478600001)(1076003)(83380400001)(37006003)(66556008)(52116002)(5660300002)(6512007)(2906002)(66946007)(6636002)(66476007)(16526019)(86362001)(36756003)(26005)(956004)(8936002)(2616005)(38350700002)(38100700002)(6486002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8aIMFDC4mx8PrLgQCtk4IaWZF331aDVY5Vku7nHYFcf/rXHJjXVoxsjkbQqC?=
 =?us-ascii?Q?E6TePwA3sMFlzW6aced9pmkkfPUemu5XeJ4KPw9BfuzMEr44BJMfep+ORXHl?=
 =?us-ascii?Q?uCBsZavkMhm7ZQ/h5wtd5b8bXDQfzmxnJ9/gmq99aMvRBJOf2tiHXFQk26/f?=
 =?us-ascii?Q?ZUf4n7haDrBadGAVb08o623ZTG74c5U8R3b+qOkMNfprF9iYm5Vdg38Xsr95?=
 =?us-ascii?Q?hzvgQqfOmZzvyditQ1VKu8CtUrKGvtgkMx2vc/VgudtRcs6UAoevoM5wZoJ3?=
 =?us-ascii?Q?6c/eBufTHJhkMeikoFU9dD/5cDnnVoky79ABol2ezECfcvcE0syfZ4o5KqPn?=
 =?us-ascii?Q?6mofnruHvkrkKHrJ5BOmomFDJSjUx+0K15C1f0xMWFtKWdfh+NJEtdUVdeho?=
 =?us-ascii?Q?p6FNgf+tYsganfKgOxdSCOc8SoIawuyOwKnJ7A9OMmbzTIl8/fuKnVFRCUCV?=
 =?us-ascii?Q?5EJ0fVPisjfckRDJM8PCevR9u5D9+MjyyTizWPQ186Yf/Khvs6AIuA27wCaZ?=
 =?us-ascii?Q?lnI+IBtG7P4OlXwTN/lDhee5aS/X63hMtQmaTd2XHJQhE2p+DebexlrxR1Zi?=
 =?us-ascii?Q?5ycJ4BYXOaFG5JE90jDfNfi+LlNlvC88iJeZHqPzv1xeALmKuzVKp8+6ZivA?=
 =?us-ascii?Q?Bdj91ITclQkxFJVerIXjvhXXWXhcOF42uoZ0vzNA1KmgndpCwUiv8ZTtPIvr?=
 =?us-ascii?Q?D/8OvdJYVE6LSPPupYGSLZZTnNPELouRcdQjbIOMRmnF7PdyKA03Xz5riSBo?=
 =?us-ascii?Q?EC34nkRlau6zD7X3aFZDPGCe4x1ljtkgBVk+sDCueXyWOlADttR8T7uU14XL?=
 =?us-ascii?Q?M3K00CRnh3Eb6JnXiHhiV1RLyy6QBU2A+1UjAQotNuV6WIQnxeDxiYqVgSDe?=
 =?us-ascii?Q?3UvxgdMBuolZcUkLU62Bi0I2k1M3lGeUq+2uXB80pEimwttwvc7K90mTjPq6?=
 =?us-ascii?Q?tSlJBXPVKBoGn/zc5NGIeZ3R9f5oOOpBGNubbeaOzkrrpOXLMxwCxunBnftX?=
 =?us-ascii?Q?fnMx7geyYY2ctq7fW6fP7IAgckrC1PY0NCXM0t8GlFSWflIkKMkeXINkE7Fb?=
 =?us-ascii?Q?NR475PqwHRd/ihgXKywKudbJZdNMCDlsE2kgQqDxMsCMhawLgARbm92dQeEj?=
 =?us-ascii?Q?HpWR0NRtcMM/Gx+gHdImpJzssR3QQpC2PZ/Bjgq3b8QhAm/rL/dZhpMayIcf?=
 =?us-ascii?Q?D77atI3Wz88f2gAy+2JI+4iLtpOmHY2k5MhSXXhYWN9zmc9YVkN1IfX9yy5j?=
 =?us-ascii?Q?g7NfIz+ee6qkXlZ3nQsSTPhiQUyzp1PoVkGHmKWoXziXpH6A/GhdfpyidpDh?=
 =?us-ascii?Q?1tgwJFHeqnqcxa/XqAZBt8QJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cebe017-4590-467e-c6a4-08d904e38f8a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 16:36:06.3349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Myf12AqbNIvjwP4fP1zk23zqLxx3sHgzQjBVUA1pLJMjJoU5w7VOTUB83bIxszywItLlMUizr7IfYkTGZFH63A==
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

Remove unused AMDGPU_GEM_CREATE_SHADOW flag.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +----
 include/uapi/drm/amdgpu_drm.h              | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4256cbfec5eb..2d9bd0d4f81c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -638,8 +638,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-		AMDGPU_GEM_CREATE_SHADOW;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
@@ -692,7 +691,6 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo_ptr;
 	int r;
 
-	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
 	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
 	if (r)
@@ -1566,7 +1564,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
 	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
 	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
-	amdgpu_bo_print_flag(m, bo, SHADOW);
 	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
 	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..9169df7fadee 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -119,8 +119,6 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_CPU_GTT_USWC		(1 << 2)
 /* Flag that the memory should be in VRAM and cleared */
 #define AMDGPU_GEM_CREATE_VRAM_CLEARED		(1 << 3)
-/* Flag that create shadow bo(GTT) while allocating vram bo */
-#define AMDGPU_GEM_CREATE_SHADOW		(1 << 4)
 /* Flag that allocating the BO should use linear VRAM */
 #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS	(1 << 5)
 /* Flag that BO is always valid in this VM */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
