Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECDC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB43A2070E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eRmGDPC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB43A2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789C16E8B3;
	Wed,  8 Jan 2020 16:17:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F756E8B3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDKombneyEElQcl4pKWIMyDifcZN06c6/1KqPxIVY7ee2JhcEQ9x2/ldCXtUGOz1lRjHmgx2LSOgXi2H1M3o8a5Dnfeofg68dA4Q8NOEZnRVpaKDRbquqFJicj10xDL3+QqZCDvX5jOizsS/V7rHMEXWfV/huvqMBj3r4PdFu84XwwKT4qewPvHVoC/J/GgsEd9huF6gGAc9UIfvDenRLcROC5B4iO90WjFUzMetK8Ec2+4tTOiuyQb611PTS7K0Id75D52WFzGj0Cg2hUUGI1kA2hWkGuP1iMctYwHK08fF3Y1AXY+KvyM5gq5pCdXDGpimdrklsLcqfRqP0uxvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIOyvdkvYGpuF2C884k3hF2cR32FZWzgcd18oBifcuI=;
 b=RPi6SXCiwjjo3u3eYnDjT7UFfuZMzI9Sth5Zrc67Sr3V3Mhd7XNukrSPJjqig18783Q2zxEjT0kot4gtDp1By9/BB/8DgXxn1XWcMSMVrybzAK07z0QHkNRu4I5tLLskEv4ZX/+WUDkMMI17KWgFE9YQvC7wEygrgfs7h/jn6ilnQ9fJsn6BZtZo+nNDtYp0KxZsigRJ7df5AsvpdMdZMNCnAF6HKIB/qvesRBzBzCpeqNQpo2qVNeOMD01oZc1VNu+3h6rccnC4/MvP2EPXHvgajHd13J9YLRZ7bW3pQVg54OavlR6/XJjrIJBrhb3KOawBNUfI34nbHQJtM5gtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIOyvdkvYGpuF2C884k3hF2cR32FZWzgcd18oBifcuI=;
 b=eRmGDPC3GcqvkQffWuiA+QfkUkFcHeG64aUkG53zyj+5BkZhvAaY8WsUZ8VQyt40fxdJIO6hz+gxhRxbuLMwtpeUzHA/BEKMPYb1mMPkGcC1JeesY0EQtF+xyER5mKS2b8R9f2qdWqFah2YhuddsJcwKJVgJ3XO87Lptnjjncv0=
Received: from DM3PR12CA0126.namprd12.prod.outlook.com (2603:10b6:0:51::22) by
 BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Wed, 8 Jan 2020 16:17:50 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM3PR12CA0126.outlook.office365.com
 (2603:10b6:0:51::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Wed, 8 Jan 2020 16:17:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 16:17:50 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 10:17:49 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jan 2020 10:17:47 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Dennis Li <Dennis.Li@amd.com>, John Clements <John.Clements@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>, Candice Li
 <Candice.Li@amd.com>, Gang Long <Gang.Long@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: support error reporting for sdma ip block
Date: Thu, 9 Jan 2020 00:17:19 +0800
Message-ID: <20200108161721.7727-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108161721.7727-1-Hawking.Zhang@amd.com>
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(428003)(189003)(199004)(70586007)(4326008)(5660300002)(86362001)(110136005)(2906002)(70206006)(478600001)(36756003)(426003)(1076003)(7696005)(2616005)(26005)(8936002)(81166006)(356004)(336012)(8676002)(6666004)(186003)(6636002)(81156014)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3126; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23294664-fb4e-4f08-f98c-08d794564e94
X-MS-TrafficTypeDiagnostic: BYAPR12MB3126:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3126F36D8653364A5B8119AEFC3E0@BYAPR12MB3126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPjft7MPVg5epaGqCuaIhNsf5o88iZSjhqvtxgXiA8pX+QBESIAsQtcIvRlsa+JLgUYOaVpKgFHv7RP3gmI2shrieICn0Jg6oNC8KG1LXwVqvn9JtL9yrZGCHt3K5DTxOtGXPfoZvzeUc6KJdJhicGjm926EsxFf+IJb+AM6Lj1aCMA6r8ZrK9bnbSlf99+ImitErl+BpL/O6VsqHoenTwKG9MZK1SaCqSARQtfUJGLf0jhI5oScD4hsIIXh5eYAFO2mdbpQIEpK5w+SsTBCUPFVRGlY73MnLPArn4Cq+52jf7De2Jit+4AEIiPPZjHowj5AeyvuRFvFU5j/Ma4B+k5rQJAR3ZkWyMyneUkgKL1GRW1jZ/cXW0Slbj2Fe6YiooEsdINg7Pi7DuOwGr22RtCEOAZJ8+A5ayzeVgcJzw5pP2VxcKHFwW52DVpjmVnl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 16:17:50.1858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23294664-fb4e-4f08-f98c-08d794564e94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

invoke sdma query_ras_error_count to get sdma single
bit error count

Change-Id: Iaaa86bb79dc28fe714937ca832da8a1cb5541930
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c7cee9716bdb..ac9926b3f9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -686,6 +686,7 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
+	int i;
 
 	if (!obj)
 		return -EINVAL;
@@ -700,6 +701,12 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 		if (adev->umc.funcs->query_ras_error_address)
 			adev->umc.funcs->query_ras_error_address(adev, &err_data);
 		break;
+	case AMDGPU_RAS_BLOCK__SDMA:
+		if (adev->sdma.funcs->query_ras_error_count) {
+			for (i = 0; i < adev->sdma.num_instances; i++)
+			adev->sdma.funcs->query_ras_error_count(adev, i, &err_data);
+		}
+		break;
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.funcs->query_ras_error_count)
 			adev->gfx.funcs->query_ras_error_count(adev, &err_data);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
