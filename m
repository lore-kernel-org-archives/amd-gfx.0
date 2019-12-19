Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716AFC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 11:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6B820674
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 11:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FiHyXnVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6B820674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45AD6EB56;
	Thu, 19 Dec 2019 11:49:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA556EB56
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 11:49:42 +0000 (UTC)
Received: from MN2PR12MB3550.namprd12.prod.outlook.com (2603:10b6:208:108::22)
 by BN8PR12MB3538.namprd12.prod.outlook.com (2603:10b6:408:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14; Thu, 19 Dec
 2019 11:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf5z38fJ2qJsJYa9tHze8zlZ4ugG7IqwdHLGuCnudO1DRGSjSxe/M0iVs3cz+3nuOdqbbdhUCDoAiMYPIar6rffDtcZX7WfsgRjHZV8ZkKix+Qb/ok9MIwcjwJYPKpp7PCidBDdQ4PrjktzrzX7N2VHpyPhw431BZ9pTbv/7r/oI/2iwJvAT0uGzr8XjVaVuEO0CaiJ0G00/zQcX4GbKOGEg6388v2z+NTnCQ24AAojrw5Df3gI2LWX9yE9RlRF2Bs3JcsVMXcauEXECMuukDrPnN79vcn4wK4fBojyDMzjfHmQzs9IbD3FihTvv4f5Lh9WO1hoVPcnvLjYUvVMk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc8nKRGRSK7Plh4GUGPrq3hZxQDMO4KCBRC+rJAc/yA=;
 b=VlEdXqPa/jb1uhb0fYRUvSNc9p0tWrOP3enQqmW3VDF+CP7O1EihmGHYUkLn9AbZX2sCFcgTOYtqijjrKgKDeYAjZVdjVEKrhYCxgJxjCrE7Rggy9QM6TezQfV5d8pwWJkTgtD62CLFawghsW1HP8diVku1o39CdpA3qQCBXpKgX6XUOfJ5CEZEAUNgucGfFNjql4q25a5Q/o3w7WZIqrYpl34A9gg/95E+ZCv5SIAmIwhmyFOItRHOqoqRgZThYqZinwwaVrDlvEx304ApsvKmDUyroQy6yl7E1FcryyBGuG/Sc6bTdd+xA597c4HdQwqOAHxhl9vyRLKay+wCGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc8nKRGRSK7Plh4GUGPrq3hZxQDMO4KCBRC+rJAc/yA=;
 b=FiHyXnVp+DaOKt9EMf2HCSwlxAROG0ZYkQhkoRJbXfEurcfE0tCrI5soILN9pdNZMUDkwOsHJJnN3uDQEV8exS6Xv2EpHgUYNNKHwCRw0/VknPbFpyHPJneePtRCWr9rINcbwFTcbAX1mXej0JnpL/lub9bYi46J9EmOofbZHZQ=
Received: from MWHPR12CA0047.namprd12.prod.outlook.com (2603:10b6:301:2::33)
 by MN2PR12MB3550.namprd12.prod.outlook.com (2603:10b6:208:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Thu, 19 Dec
 2019 11:42:40 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by MWHPR12CA0047.outlook.office365.com
 (2603:10b6:301:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Thu, 19 Dec 2019 11:42:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 19 Dec 2019 11:42:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 05:42:39 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 05:42:39 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 19 Dec 2019 05:42:37 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: fix ctx init failure for asics without gfx
 ring
Date: Thu, 19 Dec 2019 19:42:28 +0800
Message-ID: <1576755748-9800-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39840400004)(396003)(346002)(376002)(428003)(189003)(199004)(186003)(2616005)(4326008)(4744005)(356004)(6666004)(478600001)(8936002)(6916009)(70206006)(26005)(5660300002)(70586007)(36756003)(54906003)(316002)(81156014)(81166006)(44832011)(86362001)(426003)(8676002)(336012)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3550; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4479758d-c047-4d5d-8daa-08d784788db5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3550:|MN2PR12MB3550:|BN8PR12MB3538:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3550C3300E8458A7980B4782F6520@MN2PR12MB3550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQiBY5wiWb0sMY2gIoPACbCUlyn3Ks+X6QzhEQtpsIjlyysyb9UEdzxOBo6E8h1cUILFfo3DDJFsagWZW0qXQqgVjeuf98u7f/AYOczuW5HRM0QLkzIXVMnedkDEbfqDA0dNz790hb2stmtaowOindZxYs3WIW1jCSdNzfYIP/t7ZygJ9X7VdR08tBNRxVnbPTPFiElJNhRcpxzAElGkG4GaPHnQwbJOw4qC6a+uPsjkN66qprY9FW49s+DBlqwsgKL4kxLEeYpeBa3EXT3FfSI9PchoUadg/I2ku+SS5iqx8TtwUjG+L2vm9T2uo9XhwH73KKuU9/RrDLqc6kKijcxl5K8o2Sbw+XNUEEYjIanpu8x6HvO6kk3a+CEot7x739MHbL0CWjJ7iMQi3BJ34jNe4nkoA00c7KPhEl4TMeraU6xEl82Csqwyh8L7TmhY
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 11:42:40.3011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4479758d-c047-4d5d-8daa-08d784788db5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3550
X-OriginatorOrg: amd.com
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
Cc: Feifei.Xu@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com, Le
 Ma <le.ma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This workaround does not affect other asics because amdgpu only need expose
one gfx sched to user for now.

Change-Id: Ica92b8565a89899aebe0eba7b2b5a25159b411d3
Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 63f6365..64e2bab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -127,7 +127,8 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 
 		switch (i) {
 		case AMDGPU_HW_IP_GFX:
-			scheds = adev->gfx.gfx_sched;
+			sched = &adev->gfx.gfx_ring[0].sched;
+			scheds = &sched;
 			num_scheds = 1;
 			break;
 		case AMDGPU_HW_IP_COMPUTE:
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
