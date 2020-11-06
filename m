Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3C9C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536C0208C7
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WYnI0s0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536C0208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B129F88401;
	Fri,  6 Nov 2020 19:05:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6DA88401
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 19:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhJdX+wrjpIAkeYuJjbwYRBQhGq9QfCTXRakEYJRxizIoZRtQJ26JIjwNWbtGJAVnzAnxeyq6UX3ujmXk6s9G3crVBCfKu8YvJ6U+88IC2NXZuXsK1fcyGb+AWlGYP9Mpr6b6donly3SDefMyp2Mj4JehIT1aIVffSfC48NV6MHL/hRHXDelURE0D0/2bkZmPIvsCSVBkKgJ7lOAMctO896HUdilYwnkO4XlScxhO4PgLkyZEOaCnjIPfCBFvWuDfT+8cUujRJUbn8Ef3oDSu8uyPSToQAW2c9jntBkuxKaiLoe8CfjGl4G1MAbUYEckAEcuiVLw1jTvpuOe2YiqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djiiJ3l7eBkdtJc8eOLVTX9WV5vTmIh8DS9OYtSX7SM=;
 b=NnjQkzIbJ1LR/F2W4dkW7hQ1GqjVQA/1NwpKO+7Cuxp+/qKrXGINuQPw46U3lDhN+tMy7kycVI6b9/Y28MbvGxEPzDoWoeJOMBqldqEJL5WqJ64Zf3GBRLLzlDPQwpLX2rJkGp4rIBIr16rEZqa4xH1TiHCnqp7tlLAzL3qHw1COZGHbj6EtAHBqpmWM4X7fMzzH4dXpKT8WbNFT1Pc64/5CMOG2w02vPSkyUe3Dwnl1jLwg1JhRoxBmk/nfn0ogtbzud5krDe13nlnFtE+WPshClTRPUVv9f/JzJDPEFUXBzFRxamg93wc66XbhWWWystX0NnBEDIUjoitEdWr8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djiiJ3l7eBkdtJc8eOLVTX9WV5vTmIh8DS9OYtSX7SM=;
 b=WYnI0s0ZxXhlaDdncpmHE9QuNXa9AmTH6hoMJnqJZi3egx/ieF4gw/XeSdxdgcNxgBcD4o8D/6rEUeORQ2wAcrb9/dUlOVrVuJCsxXWKEG3sZxkSjTT6d71ji6Egf5uGxUE15L1wxOa1oq4NRnAdYkck1R9M8w3n0WMb/0Y5yjI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 19:05:48 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::b9cd:3b19:1981:52a6]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::b9cd:3b19:1981:52a6%6]) with mapi id 15.20.3541.021; Fri, 6 Nov 2020
 19:05:47 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Import amdgpu_amdkfd_gfx_v9 header file into
 implementation
Date: Fri,  6 Nov 2020 13:05:28 -0600
Message-Id: <20201106190528.10807-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:4:60::36) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 DM5PR08CA0047.namprd08.prod.outlook.com (2603:10b6:4:60::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 19:05:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b737339-0299-4eef-db8c-08d88286f857
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2384C06414CEB099A7FACA37E3ED0@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayy8wbt8X6TPpDm24ct60s0AKX8nXNZnktJgzNiXWOieGUzslSZYe+khmNa+/zf7/IyrzqcbkaEfgmXzHf9J2uC5bl4J2dtFSd+VwxOPAt25Rz5BFL81Uq3Xk4BnYscZlJ3bQErEI+ewqPGjqHJkXtmTr3rslUqWbTtWGEmWdhQXCWAf5pdnoCf62i4gTRegF6WuSEtFMPLEmhRaU1qoH2oPC6QOLSaHNy35beKNK6m7ZGmHYWh+Ac400j2HR8+EJAWF+jrr3+K/a5rNvLSakaVsEvEiOKd4ZT7C7IxqvjDgEEGTeJjxqF9ZyJTX6k80xWgLKY5H+BsmIgiyoLH7rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(66476007)(2906002)(956004)(26005)(316002)(6666004)(8936002)(1076003)(66556008)(52116002)(66946007)(2616005)(8676002)(83380400001)(478600001)(5660300002)(6486002)(186003)(36756003)(4326008)(86362001)(6916009)(16526019)(4744005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Oh3oLfd/x4jdlzytOOf0ShFUuG5epSCwpwTW/5tXuVmqvDzyo37g+8yaNWgGIyKLVI3iVgmYcvTLvsaPQ9vMYb101Pd+skCu9UzzKtnJESL65pnUJ6WrEBTeWfecBGq06SVftKz/qZKG3GpGZ7q5GXtQ9y3/bwV7CI6y57Ca/gupgNcPI0hF8pEzd948RNL2qzPwXIGU3P3T7J3uu6Bt/6DrslbJGJfT/ybbFStlBQI/vkvHI/fIlQQsU1yTtzuu9YuuM8Mh3Oo+tIYCa2kwlUpeP5Xu3J0Oz1F3mbSRi/n7nbR7FgPaOdkqI9KSII08y+xkV+jtFe2MZovmplAUub4PYpDJHQrJRec51jwczbc0uE8Fg08aHrrlqdgKCCVKT0U4yAydf04w8tHYXwH42cypPK0RsQK5TudgYszjxYac1q208MbJiTftVf9Xgd22pGUKHdsy6t2o3UBJWxZ1NgAjrMx4OCsj0QHyu+KH5NWsCfMegbESq5uS6Cw3o+8qzbrNZJAuVdFY6xSBlBMwyajAcq9T89OqXEQQRwPlTWm9W4l93D34A4DPN9JKcjYMi/yoRQq1wvj1eqZ56gWWJDZEY5n8mDkr85hxhRWQb9c/XP19zj3qtTjVvfa2uyeaKDieqf8SFjXr7dEPNcaNuQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b737339-0299-4eef-db8c-08d88286f857
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 19:05:47.8560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNYhtvICSKsYe5itVZ7RqfvrI5svrTexVHpT2qMpdg8fzhw7zBHpWGkYHZtOX5ZIFXn681RgWEwSclH0pTSGBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Prevent compiler warnings when building amdgpu kernel module

[How]
Add the include directive for amdgpu_amdkfd_gfx_v9 header file

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index b75bf0bb05ae..c70d8cadaf18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -37,6 +37,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "gfx_v9_0.h"
+#include "amdgpu_amdkfd_gfx_v9.h"
 
 enum hqd_dequeue_request_type {
 	NO_ACTION = 0,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
