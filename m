Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62067C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 08:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE186EA90;
	Thu,  2 Dec 2021 08:01:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4041C6EA90
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 08:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCltpQGPn7pCrDxGdQesgwvO9T556QZUsBW53zjN9+Zsmbg/dwY9Yw+6WEZ/0cePU0CuOmZYoT3GCGJ2PE41atoEiXjh152Et6p1hR3uS5eBN48UIO/D5ccWrHI7A5GPEfB0V9AazqJREMQybMyUEDeTbQARH4SegGTneJ8yGmtPyl01BkhNTeHStX/1CegC7Bp9s1aaTuVFCj5syVvH2dELjxbVVgvWDGySvChT42142PCo3hKt72y+Cdk757iObdSfOjjRQoShII+GPD7FZcejLz7pc4n5xDoGPDRQWmVBssb9Bm8At1yMreld6IFyvx1KD40XrDETLRw/zqfkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HEB0SoksXGUUxmaWL4YjALOftJywxXivPb+3KzGi6E=;
 b=cSwSrWtBi4ckToc7GgfnztBE+iWH/4v3cD7LiZ9i8XIJBH2uHCvX3/Nmm/Lb+EpRmInOQwbBF7F+z1nbWNbNuBOSGCLC5JSQWYTAwpWMYn/WyyTuYjDDHxOFXjKDGvk6ZCI2A3xPodSGwH0qItSn67lcTtEWBl7xUq+grECZWh5aojIQo5r/PCBFruc2vGtOwAoSSx05TB3UCcB62HJo5jvrg2Ydjz+rVFFhq9keP9gNUsq+BMprwaMLaoE/v1DXtLt0+A9g/PGKhawsPeZ3tGI+mSerLu5sKRoylxcIpmTlWWI7jidF0rn6MTZKiBMUcJMbsJCGVFBqzX1JQhCPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HEB0SoksXGUUxmaWL4YjALOftJywxXivPb+3KzGi6E=;
 b=421kwng+6viYwhJvl7rS0bxFevEolK7I1Tqa/GmTBR1UI9CrUXOx9H0dcqZieBVt4UzBGBFysaI5coggt7xpdqWxlyEJeHpzkQdiK3AKwyUWxrB1+hK481C5qQBLxSM5nFdU8b48MZdTXJIAtE76Cmkbkvy0P13wcmbsPVDJ+Eo=
Received: from MWHPR11CA0026.namprd11.prod.outlook.com (2603:10b6:300:115::12)
 by CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 08:01:35 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::61) by MWHPR11CA0026.outlook.office365.com
 (2603:10b6:300:115::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Thu, 2 Dec 2021 08:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 08:01:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 02:01:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 02:01:33 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 2 Dec 2021 02:01:31 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <tao.zhou1@amd.com>, <candice.li@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH Review 1/2] drm/amdgpu: skip query ecc info in gpu recovery
Date: Thu, 2 Dec 2021 16:01:30 +0800
Message-ID: <20211202080130.22503-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0b47a2a-e8ee-4e47-2e1e-08d9b569f5ef
X-MS-TrafficTypeDiagnostic: CY4PR12MB1767:
X-Microsoft-Antispam-PRVS: <CY4PR12MB176771C8A77A1927BC6CF4BC9A699@CY4PR12MB1767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/zwSIUojKohf5U3o0eM+NPhChcGVf+cQNdhJVSE3Btah64/xftZhCuvv605tLQD0/yf6nmuiBPJTS9ABJ3MTxjTrOF1THArdv/AuFRo4avjngr7jTsX4Ac8NIAAtuCvOpce6m9pN0f1TjwThb9R/AJnSXjQBxofJe+z10PUb/FftbkDbM5Qd9s85+ai1vREhC1/sYi8djRCws5qQc70YKJlfCq71ebtXye7HtACmOsCLowgRtTrFmn+8W3Ri5t4qGImBPyYaouJRlkQLEnkALTzImPGcHclMQNeb9Kyq7rxSNen3lJZBl63X4ENtJ9cHrB81L08P3ZcipByI0I6VWjxkai/bhfqSt1uXT5DvTW21mZCSjCjRmCuPyj2qPqgaT3FTDKLJ4+LeTWpGBvJEJjX7wh2ea7hkW58lB+xhymEKUlOtt3GW6pGrhxHKsbsfu6/VSZB+QqfyotUfVY7XEtL9iD9G8vDTqIKvcgHkGyYOmnLF72I7fXU3qVCFPlqYa13tS2w8HbygunUWA+yn7MXsasLelox5YUOcyWim3WuZQYLKoztSu848tGXTyu467fqRQNzgmGawnpbvLiWHsTHIPMm48OQDq6X97u3ybpa4olKv6pjIp2ImTUC4blQsb7kNE9TTlnHAuVXXnf1IZ9kh22gGFYBbzCxLDJtKg4w76ba8H/9WTM9kP1oOPVCszrHqsTuskmIvIOpX4PEjZlJATR3SSWQRDuot0ssoiRq9Tw9et3Gyz8Z6i3mHK+j2qDeWnUX/RAStVfuO4HMNmCJiZ9kDQ8DK6N1LqRLmDU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(70586007)(7696005)(8676002)(426003)(47076005)(110136005)(2616005)(316002)(1076003)(70206006)(36860700001)(8936002)(6636002)(26005)(40460700001)(356005)(82310400004)(336012)(86362001)(186003)(2906002)(36756003)(83380400001)(4326008)(508600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 08:01:35.0359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b47a2a-e8ee-4e47-2e1e-08d9b569f5ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1767
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this is a workaround due to get ecc info failed during gpu recovery

[  700.236122] amdgpu 0000:09:00.0: amdgpu: Failed to export SMU ecc table!
[  700.236128] amdgpu 0000:09:00.0: amdgpu: GPU reset begin!
[  704.331171] amdgpu: qcm fence wait loop timeout expired
[  704.331194] amdgpu: The cp might be in an unrecoverable state due to an unsuccessful queues preemption
[  704.332445] amdgpu 0000:09:00.0: amdgpu: GPU reset begin!
[  704.332448] amdgpu 0000:09:00.0: amdgpu: Bailing on TDR for s_job:ffffffffffffffff, as another already in progress
[  704.332456] amdgpu: Pasid 0x8000 destroy queue 0 failed, ret -62
[  710.360924] amdgpu 0000:09:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x00000013 SMN_C2PMSG_82:0x00000007
[  710.360964] amdgpu 0000:09:00.0: amdgpu: Failed to disable smu features.
[  710.361002] amdgpu 0000:09:00.0: amdgpu: Fail to disable dpm features!
[  710.361014] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <smu> failed -62

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 33fa1f619926..641f9b447997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -895,6 +895,10 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int ret = 0;
 
+	/* skip get ecc info during gpu recovery */
+	if (atomic_read(&ras->in_recovery) == 1)
+		return;
+
 	/*
 	 * choosing right query method according to
 	 * whether smu support query error information
-- 
2.17.1

