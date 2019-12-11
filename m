Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6DAC2D0C9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A6C2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k/ncincr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A6C2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D856EB90;
	Wed, 11 Dec 2019 15:33:45 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7123E6EB8C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjhm14TZTmYdMEt9wuODOOow3/bfWhEiAKCTSajN/rvTqamekkgb6bA6/nBHNyaPl31VNNlvyCFf8oL2nQlli2v9QUmB3G0TaIH1bfuVkytD90Q8H6n/RepJBAsriaSLGAQ3mZnUckue0wy6h37lCzmYlgyWkqWgRtvQ+fa462cR9GOjsXBuOihDxWcWCp/ZErzjx0z28LJbQPoX8k3XKaKdATnRoRwUiRKsax+TyWnav4+J4BQXxs9hEdte403JenNH5u2s4DXqOfzvcajCFCcKDibGa94HFKLIERiqRd4QARoO3tgUl3J5wvV+uV+tsNQ13rA8dOi0AE/dgMUmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=480KH/A2qJHm+O6oCCi1BlyH81hDAbdnYmrrYtkh0hY=;
 b=dOrPc8avWz9t/pyUcmqiiCKDAcvJfxzOOiGFJMDKszUcjezVix36GX3I7934+od5S20BMxtDnuzuCwPiP6q3ThQcimgKpGRHeeejbkI5q81PuAkTIXQRkyCSqjHR7cqsHnnaN1iR1CTLwFnm7IHyD8cUXO2WLRC3g9p7x0vFiHZxNxFBr08J/GLjLzXntnhRrLU1uY2AW1rug/bALxMRuai3tpfEtqF9s90fvz8q4brdyak4jAnaoO4SFy+KyFViV9iCq1saPGSDws+tAGi1hEXw860f7tnMcLNtdU/8Ercf0dyGIzCO55+fNQugSRU/W3TW5unkWazYlIYNsSx5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=480KH/A2qJHm+O6oCCi1BlyH81hDAbdnYmrrYtkh0hY=;
 b=k/ncincrpp1XAMOywAUJRFy3//84UtQTmy6xzIiaSRknqoiICa3WT394otSpX6I42bBblpEdI7A6tkdQDtI36RC41c+vp+nPY1DZ4UhNhPACGdKzPuAaW2/dVU+JSlT2f5asn+DyLH0m/b59i9JIqY7/sHiUZl9xfvR4hN5hkNM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:42 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/39] drm/amd/display: 3.2.64
Date: Wed, 11 Dec 2019 10:32:43 -0500
Message-Id: <20191211153253.2291112-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db925323-5ec6-4d76-3f40-08d77e4f80ab
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491BD8524808BAEE62E016D985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(4744005)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnWLCwu2XXBAGWh24DkrMgQPsXgFq89ByahZIhtFjiIgfTxgwC2VUnHHye9kVFIW1RqYiso0ACGSZPrxuVmswolfk+Bhp0fUl0zEEDlBa7XCz3gy9+YZBn7wXIYE+mFltmlaJA0jh6RLKOcjpj5XcBeCr4FgD5SaQ0Ac5sBJWcb9Gz4DZDzp2vGKIWFUZjwKB+GkJanJuAQeIoLG3V1CM1MZgFYdZt66MEax9IZNvFErt0Fq3Bprgghz1KrduhgDb5if2sK2Nu0lyoIjavCm+xy1yxg1n8IDadrfLquNbfjzkj7lCWjxm9flwsqbeTRDUugF4HNjes50c3BF1DYg3RiHwtRXe8hh0F5CjG/6dPYoGmi+6IJlOKjlanmHXe+AosobV40S5xMFr3Fo/JZjYV248qGh6Vj0zNXMnMmL9TKfazVF0uHzBSeehw0jtyjV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db925323-5ec6-4d76-3f40-08d77e4f80ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:42.5265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc9gkG7bVO8uXwM4KHKBtvyppLavyK/LCAMEs5pvYJmYibvhvUES3eLBEa1KVBS0CBxkzxfFzmI0QcXiL3n0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5c48111deabc..4c2ba93ab7e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.63"
+#define DC_VER "3.2.64"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
