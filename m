Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A9EEB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7950E10E429;
	Thu,  6 Jul 2023 12:36:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21E010E429
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHsXw5RKO42t+h4YZkL5Qgj4WHAKS1D3Sqn/dGKJ7SvR6ArnebhHNyQLk8h7hxgKMVcdTu2LygHgVPNYIy3hXr4n+E9CMwC1b55mXIElPFXD6E53LTYDbcJQoXfCdc1R0ARZIuiMlieAKTN1gwKkwUrowznKZWogNRhE550tHzDB3EyJQkHYIXUFrWklOc+j1Zhf3imNSS8pYJa9hb10ilPnN5RgVmwDBe5FhzO8WES8DW30PIuXR/1yW4bHqW2QOPESXacIzZLV/4vxaWmhpARJkfHFXIKEfBQ4W8StMtNMjb+AGcpHQPpZ4434gWQVjfngg6q2X4JqNF3n80sBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SGqI5xwtuYwWktlWzLDoY2b+a7IgvgK6DU6cJbkJ14=;
 b=HQ2KInu1qv84eWR5JOq2eN7/5L9bpmDJ2p9bykpTXXlvTgx1HQ6+tasWRCYqbPUriVIpiC7vQ/hu89VturxFWRmlbaLpEeBRBYQyGjHwaV1f312M6oS86p8iX8lGcSqUsARKEqL5rC4FEL4GyktMyRIx3KLgrk7tFNpYPw+j1sygIrqigq7XDPIar5sxKxnwvBMZOFdDU16wf1LnBrtQr7g+fIJGLaB6wfHbaIyGaTQuhJieCGCPOvR53geP4VFnegJH4vDoJtvvZXW02IhSBV0Tf2MRjKRp+bX1hxmTXbi5GLvtGINoqZFCEMLdRZQksonZQ7uyijrjKXiCLyJTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SGqI5xwtuYwWktlWzLDoY2b+a7IgvgK6DU6cJbkJ14=;
 b=iOF3tB2eC5fyH1qfF3B/NQCjNzVq0Hggi0D8XSoQhJM3tZfoVQsBt8ENdry9ScLMBW5Oq+rbFZfzmGmp1sWr5P97/OSxHDeRZO/M9DJ3icfYO+aAXi/wki953IftDvHCMlHm43iAmwbMcYAkZzfVYtHvrD6MvmE5DPrIy2+4JmA=
Received: from DS7PR03CA0121.namprd03.prod.outlook.com (2603:10b6:5:3b4::6) by
 IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 12:36:50 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ec) by DS7PR03CA0121.outlook.office365.com
 (2603:10b6:5:3b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:50 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:40 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 10/10] drm/amdgpu: add delay after userqueue mapping
Date: Thu, 6 Jul 2023 14:36:02 +0200
Message-ID: <20230706123602.2331-11-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 761bd002-1236-403f-b0dd-08db7e1dabbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqzTIRqoB/1aZKK7TPNFhg29B8NbQ8pgcNptXuV8KTrSZYnlsWW/FX+hq6FarWT7kbHAvfqjHFmT3zeycC1yunsTbcdotQLU+TRc6yZitb978E+qjGhNSXmxnFZ2oprSm8miK5MpDG0voB90Z4RL1cF65+7R8oIfhXZEy2LQvV9dFt7osTXJ/Ypxm1WaeVXF5p9AQR8Q8rEjEMON9HICrZdLZ2V1JeOGycdh1TkVPjAqQErL2M79okl7zsFkUxitQL+q2QeZYhUR/e+C4O6ihPdTT0hYk+RBC8VzzH3bB4v4VrJvrfkHePPwoUcY7x1JlhjXDCoMOeEMsVoza9pZ+TYrRW+2+dOS4dFwOownpjLceyGFotkyDUUC/HMg4SnhxUFflW1Uo117yTWFWVlyHI9bd0PBCpAmTajfn6B2QWmwKXxLixoKn2IXorxQY8662piUS0nS654+in7gH4PkDhV6sChLLQPZTTuoBh/pxHNuv0CRgsqIDF7pBQObpgyQdp6EfN/UldDSlIRXEs8Rp0pIPPMwvezhFBave48Z4DEJGuQINyHDlD2alvNJwcRtQIf1FfTE3qqbnJiYSo13nOh5obx8KRQIPRAnATJNnQhRqTvwL1qJWRQ6CsEa13ZpMOVmVWZzuAAa3KcKLFUo9GzdsMbBP19wAC/Q3oenmza7TWl5Ig7nFb8Pzwz1QJ34qjE/Ay1FjFoNPCUVcuYIPl8sk87i4Jeq75s1DRtYSjHA8Lzs8aSmQlMNtqrC1mwyqzSTt6YXpzYqy52HoAt1JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(81166007)(356005)(82740400003)(40480700001)(36756003)(40460700003)(86362001)(6666004)(478600001)(7696005)(186003)(16526019)(1076003)(26005)(8936002)(8676002)(54906003)(44832011)(5660300002)(41300700001)(6916009)(70206006)(70586007)(4326008)(2906002)(316002)(36860700001)(426003)(336012)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:50.2762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 761bd002-1236-403f-b0dd-08db7e1dabbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It has been observed that the MES FW needs 250-300us to map the gfx
userqueue, and if the user rings the doorbell before this duration,
the FW never recognizes the work. This patch adds the delay of 300
us after the queue mapping.

V1: Moved the delay from userspace IOCTL to kernel (Alex).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8edb020683a1..78b58c5d0fd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -25,6 +25,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
@@ -6749,6 +6750,12 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_ctx;
 	}
 
+	/*
+	 * It has been observed that HWS needs appx 250-300us to map the queue, and the
+	 * user needs to wait this duration before ringing the doorbell, or else the FW
+	 * will never recognize the work.
+	 */
+	udelay(300);
 	return 0;
 
 free_ctx:
-- 
2.40.1

