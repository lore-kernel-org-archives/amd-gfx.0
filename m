Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FE0C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 15:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCC264F6A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 15:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCC264F6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F676EA47;
	Wed, 10 Mar 2021 15:26:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC95F6EA47
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 15:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOrQCdddsVixy7ul1ZP69OM7gZOyCCsQhCjO9pd6g+TcEJmhG5stldH1DdkCxOF3YqmRKgGA/UhOaI2aRHLa76p0uhSqZ6Do3cCSY/ZTAmQlgQwqYLWVQSxpBDFMufn4wMtYq5eZaiV3eKeSnBnIjYoxwAARrNIfG8CZkPFb/LvHRXcFc9V07jaNppXuCywB/CVi8fvseeCTCEbjj69gL4uFqBBpGzUCnTV4CqOaAlKssPCxnZXxkDe487q/QpulZkmRyz7uq8TRkMstWZ3ZzvhCBTl4uAk/CxY/psj5dyYEzxSSrBD9ba/ZnIb8fxLNU7FiPgmOFDEAyqEMwWnzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e9Zrps97p9TqwQt/j2HuM9Yj/JtGkjx9tWjBQvsVik=;
 b=GOeE8vxdHefKqUa5K2XmwmFRJDkbO8D3pz7Diy/isDUjV03KeQkyW3QTKc/3joRyUIs0jxx6N6GSdy7H1Y6GVtQqq8CB7bN2Xdau7k04Ll2+EeaXxb3rw+Vbjmfp7au+LDOxR+TFWWcjys1fpGrQVtzm0nXTENRTFctL99hiaWcQXakw5ic3a8H5XpkjGKC5n4pO5ARx4GzO8AHG08R0HG8F4q2QyQoHlUR8HSyjCWE5a3UsJCt/G828zHGhhjxSo2Ed4fSRC7DQPsWYIoOJ+fMY/ZSVjLzDgrwe5PVDVqFT447MfuIEjmk3XtbCXTOvAF0aJBJiaCobTgbdkTonfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e9Zrps97p9TqwQt/j2HuM9Yj/JtGkjx9tWjBQvsVik=;
 b=YgxVHlNtcPiN84MzJ19b3yyGNKmnxfY1JL3LnLeIFq3tgul+FIJGoPPh3w8AIJNLWXTbuFMaqfhLicGWE9/0MQYpxSFTFufVDdM9Ej0mPMVt/hE7au6eae4m7Tz8Wqd+uuotR7+KUlrdTYtRqKEKSVzF63DGzCAWmInGLCbEC0U=
Received: from DM5PR13CA0063.namprd13.prod.outlook.com (2603:10b6:3:117::25)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 15:26:15 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::b) by DM5PR13CA0063.outlook.office365.com
 (2603:10b6:3:117::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14 via Frontend
 Transport; Wed, 10 Mar 2021 15:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Wed, 10 Mar 2021 15:26:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 09:26:12 -0600
Received: from Bumblebee.ht.home (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Wed, 10 Mar 2021 09:26:12 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: remove duplicate include in amdgpu_dm.c
Date: Wed, 10 Mar 2021 10:26:07 -0500
Message-ID: <20210310152607.33953-2-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310152607.33953-1-Anson.Jacob@amd.com>
References: <20210310152607.33953-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 374a7032-b628-43c1-e0d9-08d8e3d8d783
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4085E9FD2536D6039D70C0D7EB919@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLwXt8JSOYiQOHncUh2pGUABFuhy6gQFFgw5NZNXC5zdm6bHSwNogiAO8zKs2rigfEq8KaUNZr2YXAQy4f3C9mxuSvvW0NUw094Unhhjc8pD/Fw0Osl5pVVaYyLrNC/WkhHhxn0d4agoSQWIt0QONEBClCUt57bTu+mivo+zVB/yJ8FhaaFBPw6dfqEaK5c+wjjA19JKclE5TaSzJZeYnPXTc7qF2yE0rAQ3r9puo7Sln4/HOHFycTgQMkrrLJW4dwdfZEXhxT7g/2EasQtt3o4a4nbAGcPm8oeMwoxx6FOAT1GxSMwdqEtBKSXbueT+QsR6eQmJdiH01rF0/W9dRWkvf4a0FzpGS/VzWQFfNflii2Qo+c68KPH6+gqibcxVKZDB8Lie2rNWaDxFOT/Diiuc5V7S37VQGErDeEZ39CTR0hajjlPebEuHr7t1jliC6y95DoA/SkVEdSSdEBIm351TdpSCTWCXX/FhsjcdFi3WFyI8yLLYClq5FaxxbDcRaay1e0RzreoNmwRGY0P3JJmvOD2GXmksPpM12EtmZLaLi8k/2eS56fsq+p7KPUhRj/YQeO9EV3T5RdiWxGEc/VO2Iqii5ZN4cqOFIKxw44PhvlWpYmXJcyCQYK6L/OMW1deb5v0eUQOJFfhTDVQrR8XTeyjE2loyppxaTLj8SExaftMC0JdY1BjYcmDXRSCv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(36840700001)(316002)(36756003)(4744005)(26005)(82310400003)(1076003)(186003)(47076005)(83380400001)(54906003)(2906002)(356005)(81166007)(336012)(478600001)(426003)(2616005)(86362001)(4326008)(6666004)(8676002)(70206006)(82740400003)(36860700001)(5660300002)(6916009)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 15:26:14.0091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374a7032-b628-43c1-e0d9-08d8e3d8d783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
Cc: Anson Jacob <Anson.Jacob@amd.com>, Zhang Yunkai <zhang.yunkai@zte.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'drm/drm_hdcp.h' included in 'amdgpu_dm.c' is duplicated.

Reported-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b5a75c73ad71..f9513c5ca2b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -76,7 +76,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
-#include <drm/drm_hdcp.h>
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
