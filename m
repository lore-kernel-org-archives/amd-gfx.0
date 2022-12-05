Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12592C4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 09:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D59910E0BF;
	Mon,  5 Dec 2022 09:43:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0546210E0A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 09:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBrEEbx7DhaGWWjyjKMMKiK6yVIOaXdz0WfKOsZWOolnxQ0o0tleIxwTgnwro6fEwsD1/zVMHIbWevPMceYz90nKAPFS50kCHegefV+Drm6rSTUdhO93caXmRJ3rvU+Smc4FQK9d4Uke63XXpE4G+ges6Ui1VbWoZaDfV0GG19IPjoPWZyXyrJ/5Tcg7E26PIwkXqMdyyPMDzOFcmD/4lmH4rndUIZUP9WhXW8GnBjtQ43RZPE0WSeGiqVu21wSwXL7gN8jzGq0dScvmNriJpqVudjN/4VEiHOti4LH7hFAWA+2Aeo8BH09jlW5UGooJOKO6qbU6oFmsY2hlJO+82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHWtYzlP+BySZKAhFdVHhESEa6CDynW9tx6afomDgtY=;
 b=XScRSi4HKwar9ZNH5G8WruSt/nNwbZGoMlcjmUvHYP9Y/NjuaBbm20Jya5hqCTK/8JLt8f9vVhVp2b+IoD1kn6wTIkXhBJRCXFlH+bCuuqTw4HyflyOoolU+l6M6xDK1LMQJS8c7e7d3zf2mKYcgzKydHtSXip4h44UatYB2poVL/QC5UKYz1kgxBUL4uCu6VoIDpDYoOvupcr4zntlzLkduR7CAVriNTx5TbmNMh02EqkCkaMiIhvJcqe3bQudOiY1AgZ9nNfhzThKthB7NWzM5N9/L1uEIk0HSpgKvZZwjmtLQT5Kfi1MEkHP4/q4JerCdGk/qYZW6FbB3UPNp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHWtYzlP+BySZKAhFdVHhESEa6CDynW9tx6afomDgtY=;
 b=IJSVHfTb6AJ3Y6dAhAy40rGDkk/Ve3ssuuWtRhjtgma42J+/LbVFFJHhBmIfxtpOwezTM9RDZVkAa2Hn9TXn6kkM4tCjwlcnjeB0n22W4i6aTMk9oeBGQjnbsbfAl2OJ00dhZTz74u7F/pr0V7clM81lyDU591zFJiu0IEpVHR0=
Received: from BN9PR03CA0720.namprd03.prod.outlook.com (2603:10b6:408:ef::35)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 09:42:54 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::2d) by BN9PR03CA0720.outlook.office365.com
 (2603:10b6:408:ef::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 09:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 09:42:53 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 03:42:51 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: enable GFX Power Gating for GC IP v11.0.4
Date: Mon, 5 Dec 2022 17:41:24 +0800
Message-ID: <20221205094126.2190885-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205094126.2190885-1-tim.huang@amd.com>
References: <20221205094126.2190885-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f528c5a-c6e4-40a9-141d-08dad6a51526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HALIOlWzBA6j3EaSTzXXQRMkives13Ai9T82FN9I0cXa+j1j5IbIEjfYj+6y8kEsPQUgNL55+SvSpXb64NNqEToNaGoi8tJ5kSF5obE603OU3cf7361SSHRejIW8olrIXcYp02PcOTU2Dj7RRKNwGc4RNNNTumZ/KrOB9k1VxvgsWBxhESe1SJH0Ei84c8HbDiCd/7txY+IP5cM6gT8jmJSN+HDtte6dZ+h4YT6DtAeCbQuyDRbmnxGGOtmkHW3GFWGV8yJ29AWoWc/uA3nlR2rZ/BttwPfEc4JQqF5Opi2hlMsGrnjRsK1Q6yebOo04UhAPDIBZ4zmxz9CdoP34AQQ/YCzIV+ty3YIPMqktac3cA8UsWLVC0MAgo0BMgv+e7YiS0UPpHCI2UDTxkTd1zvng3ipFTzt+qkrlQ+gwuR/u8fNvBuWwUYALNCR3Nz/unTmMcQB04dUYHuJXFfibiDsxwEO4mC1UVYc7DFHwQf63lh4/0UalYI+1Aab4t81gSLZZNxCBfF8XnmG9Uw+vCh9xPqnfpy8eZhhGEtBX4r/OVM5LCDphVuzkR/bd0+KHsa165YM0zPnjZ28iyUhYQ6/fSTzjCG/b78xWp8U5QLaLWds47hjifelarMeeJNhHgDIdHMbdAkQPoNmtalvVRzNtJp7tO0mMPBzBwA4TKo/92THwVJ2k/0izAosBfJ+T1b0Y5HDC1EXfwkMihPkLida4ob0cQlKYBAQADGVB3rY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(81166007)(356005)(86362001)(82740400003)(44832011)(2906002)(8936002)(70586007)(4326008)(70206006)(41300700001)(8676002)(5660300002)(82310400005)(40480700001)(7696005)(26005)(186003)(6666004)(336012)(426003)(16526019)(47076005)(6916009)(316002)(2616005)(54906003)(1076003)(40460700003)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 09:42:53.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f528c5a-c6e4-40a9-141d-08dad6a51526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GFX Power Gating control for GC IP v11.0.4.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index bf78440e1e70..506c285d5f49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5058,6 +5058,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
 		switch (adev->ip_versions[GC_HWIP][0]) {
 		case IP_VERSION(11, 0, 1):
+		case IP_VERSION(11, 0, 4):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5091,6 +5092,7 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
 		gfx_v11_cntl_pg(adev, enable);
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
-- 
2.25.1

