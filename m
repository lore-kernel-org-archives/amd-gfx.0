Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F99C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 19:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C7710E77E;
	Fri, 28 Jul 2023 19:16:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BA310E77E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 19:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMb9d1DJhGZ5zj0WmCDxFSU0ljnx9GE/4hjsitmkGLjk/j6+QGbN47/wSNB/YnMbiKR4qzyp1/wnBv7NQPrizvJ8Z6V75m4j+tKQFdQv9uzsOoiKaWJKkySSnvGRjFAKj4hKPowfdkaGyl3rkU3hWsTVHeM5EPh/XuIA9Hb3pOaliUa0LOmTYak9R0RhjLwH8Es8WZCa8gD2t9/FuBtpbiXRg/Q9xUX1YY798WisaBClx3OY++xh0OSfqLv3AzdKuTyp4kOzZvF9YZm2fkPhk6d+EHYRGojk7J6BHkHRmEE5zjOZR4Qzae4W1Aq40MmqbA0/f0g3STmGjstCjM89EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxy5qDRUin4mlBBbl4Wh8tAdST5cpw66RrHFZBb+wF8=;
 b=OK3n79hR6VWe5kY3d5PKcc2qSMQyLhgH6zB+jP3h/zoyFjDQ1Mkto6yvwQviz7Cj+wohyvYMcH++Nuv6NaO4Wsy8Brk/awF8KoKxoj1xnj0+FtYsFgqUmjFbRk0LOIm8F88DJdxOZrqioY2pd7krAzE3wMBbCasIpLcTAuDsF+eqTH1LKuppIK6aenVAqyUKl//HAYaEY/7BPlt5A4cBYuDGIawY2LFOzua//WVWFWj+SobrfEoMnYsM1uoyLDkGtaIZ1lY9eG2FVU+p5Otn8dUTuojuRRXAYhTvyc8mvdRV0UfIYVNguq0Y0zDMEfVOkRV9tufCeVW1Hyu/YdDc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxy5qDRUin4mlBBbl4Wh8tAdST5cpw66RrHFZBb+wF8=;
 b=174r4LSKvcGD7gpuJcqAucRv8lGlNnndSq8ANRgcv+kDJjR8GNbgQa6BUdUagRZDm52N5Qgben8aabAWigmC4zpCpZLy3ZOygstewiAhyT0BCPpVTHU531PpTboVntNPVRRHvSguLk+FeoNNMXZTMXWJnrsrAcRYEiBb1kWihh4=
Received: from DS7PR05CA0058.namprd05.prod.outlook.com (2603:10b6:8:2f::11) by
 PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:16:16 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::1d) by DS7PR05CA0058.outlook.office365.com
 (2603:10b6:8:2f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Fri, 28 Jul 2023 19:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 19:16:15 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 14:16:14 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/7] drm/amdgpu/jpeg: mmsch_v3_0_4 requires doorbell on 32
 byte boundary
Date: Fri, 28 Jul 2023 15:15:40 -0400
Message-ID: <20230728191541.1778424-6-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728191541.1778424-1-samir.dhume@amd.com>
References: <20230728191541.1778424-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: af45df42-7652-4f5c-efe8-08db8f9f1d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrOk4Oh+/7iAfSlatDH6Oq63D1887AXJahmGOrUJZ//QTuvE4ET673YgxIlVuZYbMuJBOWOPd6SJsjPhypq3Wb61HWDk/1E1uftyKsKIJaXAXfPBlxwXj+rFfjOFV8l6gvuhhV6NgdKXN5go93CkBqwjs929zAvf+N5YY6c4NHoFHCxZukMI8hJbuRp5PU4MGHbadnhSemNOXtvQFAn4wagH36Uq58DSyb3QtwXwXpuzYSQm2wgD8lJLgcrynZnd4pvs+eXJ4SWnUY2k3QT7262OTR1ldcQRSaioKPX67zRqhZ5ZssT3E0U7g7qH/AJWFeqkVIHUc4sQ0ZW2/B9LQLFD8R+5Y/4GqBCzxtI3vS3SO6jaDvp8TkEV+Pr8FNsgSwS9BiROO4YopsU4F3x9DgXOUliOgeC99Qw9loEgKJdqh2p64cs4qCBcEq2laHUZSUSjr2R3p6n1tz4ipa1u5m0B1Sm4qd846MjhtmO0XiS5PYnc3OCnWJSUeHh+Y5GkIv7C0+DQCLT/+IdTGnbdl35dEAhDtos6SMn6dL1DgjfWQ4mIgr8TYwqr6kEidYExZxzpBpGhY6yjr+KRqxTm3eJ+9nczSR5okJpagyfYj/0VeJoqISTZTJt1PccPlc8nxCXZZGzF0eBV1IRmKj2c/u1lBtDCAzpE+RlfpK5uX28U+aFQylxtaHb2oL5Wx7KE7ogl/MTm+RxHfndMcny7LxfjAgB90ljZuYbSxwIuB6nF/0UVB28Z7Jm+iIWgWLwyqJr11iAopnGuzdgZSqoW/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(26005)(356005)(1076003)(54906003)(478600001)(82740400003)(186003)(16526019)(336012)(426003)(81166007)(6666004)(7696005)(47076005)(70586007)(4326008)(6916009)(2616005)(83380400001)(36860700001)(70206006)(40460700003)(5660300002)(44832011)(41300700001)(316002)(2906002)(8936002)(8676002)(40480700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:16:15.9509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af45df42-7652-4f5c-efe8-08db8f9f1d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, frank.min@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

BASE: VCN0 unified (32 byte boundary)
BASE+4: MJPEG0
BASE+5: MJPEG1
BASE+6: MJPEG2
BASE+7: MJPEG3
BASE+12: MJPEG4
BASE+13: MJPEG5
BASE+14: MJPEG6
BASE+15: MJPEG7

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 33f04ea8549f..f745eeef442f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -111,9 +111,20 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			ring->use_doorbell = true;
 			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
-			ring->doorbell_index =
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				1 + j + 9 * jpeg_inst;
+			if (!amdgpu_sriov_vf(adev)) {
+				ring->doorbell_index =
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					1 + j + 9 * jpeg_inst;
+			} else {
+				if (j < 4)
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						4 + j + 32 * jpeg_inst;
+				else
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						8 + j + 32 * jpeg_inst;
+			}
 			sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.inst[i].aid_id, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 						AMDGPU_RING_PRIO_DEFAULT, NULL);
-- 
2.34.1

