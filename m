Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692E0C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 10:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6F210E597;
	Fri,  5 Jan 2024 10:41:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C3B10E597
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 10:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdiM48Bw3Ve89ByaqeLjgbYOSulkAWevVCXgLNljC5fRdjQtZdY4anw1fzPhiWAQ/3hyCb84rssNjKTk00rRZ/phMhbypG7xjhQh/1ZmhWw5TRp+yAKAhROJ3TiZO0VnYcux7b5D61VqJ0lTLkGiSCUSntD8WMyY0wB0OnhhNlfU1i9TeJg0xt07G40EG78xF2mMLq4DgV9RXPR01V6dVydnhJp3sBY+1bL9pxrjDOkyu2K2Ab8Uzv5teCvw6d0cYfWfXXBJtVN4QmxaQSYFDbrBkTg1M7RJjPTW6LfM+QFdjJ/p/+bAEoCClH/gYmfx+ItPas4X24dHRfUGqB+ixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efWlEq2GPQQ/dml96B9KQqMjiRaPFhHYxX+GpjQ2LXg=;
 b=Z5vGXPsQXDQwyGcjtO3ewizh7K6m10JYhfbDTAlZw2MZZDcxXHo8OslQlAHnBr562Qc/nmnAweH3MGbt1yvAJneCoZc//iUx3nX9zApsvs4CnXNFU7vH67UhbYLXQz1lxX9huza7pMNFeiB09CIDzUcYq5tm1iuT2nBEfCLs1XRF6bypi0VK23Vc0yhyCdMrzG5JnKUBqqvEbdpMMNiBrQjDOD3Alw/8onZfSCevETgP3ehCiNMH5nQDTxPdKRDyA4dfuiyyYIggyMhugDLjdezkQbIqs2cA7xwhHgT7kkqK2sini0Bir8/0Kw7sJUmHYynfuWRnbw5zhnkbNsn7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efWlEq2GPQQ/dml96B9KQqMjiRaPFhHYxX+GpjQ2LXg=;
 b=SNvT7+CexHtmh0mvmKIlbV4By/0QADm/66qGfSsmhxMvi+Vjih5I1q788W1DYZyfbTSsMKxZFE+if1ZWW1nGk6ula9G6M3s43QU6RlXAavL0Hh9R20BhoswHAAXvQFmONCrRzoh/wdZ5KmCs1abLLcpQsacmaMTHxPe6HmUTZPo=
Received: from MN2PR19CA0025.namprd19.prod.outlook.com (2603:10b6:208:178::38)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 10:41:46 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::6d) by MN2PR19CA0025.outlook.office365.com
 (2603:10b6:208:178::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Fri, 5 Jan 2024 10:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 10:41:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 5 Jan 2024 04:41:43 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix unsigned comparison with less than zero in
 vpe_u1_8_from_fraction()
Date: Fri, 5 Jan 2024 16:11:26 +0530
Message-ID: <20240105104126.2773281-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e43c3b-4fbe-4a34-b501-08dc0ddaea29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFgk7pRjvjTuq+wNrcFTfbHnIkSPdMpJmXwwp9muIurM4eoCoZWE3gDpuUAImJRJ1YwX/yXfFaVyHS50/oCTmA1xkcUC0BTAI83Rkkbr0pNeNxKVFUiu9+CqD8GrCKu0kRNQoA6EjycdhC9AY4lMssQAjNRnTbpIk9ZB4rW+XgA8Y94bddCyWFYRMlhRdboKYKx9mJ1p8ypH9faO5kgeEoPW1h1dOgM2eFU8i/mqdXjsE5mc+/X+PxN5aKF08Sc/yCE/Xf6E+p8JQSf3H9HprypBeHR7GdRVFghP0VjW5E4MRyDCb7+hFk1JR7bsN4dWUvddDANdRVHmFHyE4el/BjvLTwH3EBa1Ky129NHjD1DYn/0tA+GSOV/je4bvz2XActs5nZUuObnshnrzwUNEbx2Cjb1ultp3Ejzb4xvpYv4AZnSo1FjZQZchK6VlEho+sx1v0U3P5Me8A5jTNo2VhseqeeYaS/MgQlk9TSOzWGNTPn680z/ugMfly+9dbsWsZGolPpNJs7Z5+2oXbMgk4gOK7Xm8SnQbgn1AavHeYomG6C0yKKd1lBw4P7DcDkxVh6E/LdkpVxfCTNDWR0SOKNjkg4CaS6yKk/55I74ImQB2MD0gGJsmdz/gZ0fDcMvyZZQgN6rpND0FPeXdD9yOyDwG9+UXGPhGHWSsSPQyuvs6oLJfimYzJTbSVHzIDq2YCM48KLWwZCh+u7KBD+kEDxkHERgzrPKW7GEg1PqA6l3gCPzRu/xPfbWlr0U56GnWilS6KbX+gaTgEMKupQ3uMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(1076003)(2616005)(336012)(426003)(6666004)(7696005)(478600001)(26005)(82740400003)(36860700001)(86362001)(36756003)(356005)(81166007)(2906002)(5660300002)(70586007)(16526019)(41300700001)(4326008)(54906003)(83380400001)(47076005)(8676002)(6636002)(316002)(110136005)(8936002)(70206006)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 10:41:46.1932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e43c3b-4fbe-4a34-b501-08dc0ddaea29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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
Cc: Lang Yu <lang.yu@amd.com>, Peyton Lee <peytolee@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The variables 'numerator' and 'denominator', are unsigned 16-bit integer
types, that can never be less than 0.

Thus fixing the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c:62 vpe_u1_8_from_fraction() warn: unsigned 'numerator' is never less than zero.
drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c:63 vpe_u1_8_from_fraction() warn: unsigned 'denominator' is never less than zero.

Cc: Peyton Lee <peytolee@amd.com>
Cc: Lang Yu <lang.yu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 6f149b54d4d3..b9a15d51eb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -59,11 +59,8 @@ static inline uint16_t complete_integer_division_u16(
 
 static uint16_t vpe_u1_8_from_fraction(uint16_t numerator, uint16_t denominator)
 {
-	bool arg1_negative = numerator < 0;
-	bool arg2_negative = denominator < 0;
-
-	uint16_t arg1_value = (uint16_t)(arg1_negative ? -numerator : numerator);
-	uint16_t arg2_value = (uint16_t)(arg2_negative ? -denominator : denominator);
+	u16 arg1_value = numerator;
+	u16 arg2_value = denominator;
 
 	uint16_t remainder;
 
@@ -100,9 +97,6 @@ static uint16_t vpe_u1_8_from_fraction(uint16_t numerator, uint16_t denominator)
 		res_value += summand;
 	}
 
-	if (arg1_negative ^ arg2_negative)
-		res_value = -res_value;
-
 	return res_value;
 }
 
-- 
2.34.1

