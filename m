Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0C5C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34AD510E50D;
	Wed,  2 Nov 2022 16:59:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D4010E1F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQz9W0N789fVDf/H40vDSUEi/UfRSMCHjVP15/7eU+9MC0JeKdjs1IM+6a9+M+/a9Cs2bb1PHL7uqdzZKtbAB70RVwxaZdZ8CvEN0A3JL5RvD9x7cvZDQS4m7e3+xq449QExDK5EmAqq8YhZQC1lJtn3Iv5t8hJcJC5hjzIvoIUrMsizj7WoMfZs7jEyx7hIE0DU7vuYUPHyw9FfKxkfnswWRc+lyiBDF3ktWhtUQiNTnZLcB79p0KxsBbSSfAEsEULS7bBL00wE6jYg+Y3wG8MPK0QBQVqCuFYB11+wmBxakhX9Jo9YDXV8Y4r10pVG28h1TZy6Q8o63YiV4LkYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRJslP+0wnm6w5OExQK9PhOJ+A1OhMrvKWsRKcd9HzQ=;
 b=L5em1EjnhC4cICFcy7lOusUIqRn510kNRb8n3ps+6FPEU2+lkbAQjWfR3Z/KzxJhMW8qUuLGr+QF9pzDzNa1ylnp62wzFy1c1OKi7xGdhJ1vSrBu9wylMu/JqplT5R2uAN1UIzOHCoAWtHxN8HBrp7pI/kH2PWOuKY/rU1MWvl3csLskKi6971kkV+vXy/bDK/x46cQ0tfuRJevfUOwAN1y0Kl/Csev/nz4J1O4pLC3vLdM8v8RFjp0DpZG0/F9gCP8GCuQXXIAFamy7Y0cwzY6yvbrbM1HC4wHzsr4QnxdJOi88bCORCCC/u5cf7EP5KCx0v08EtHN6B4Jx5nGbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRJslP+0wnm6w5OExQK9PhOJ+A1OhMrvKWsRKcd9HzQ=;
 b=s4V6IcxcUPieyoBlV2/sZWFgxPwIKkp91hNQInAl4f13IpKz0djLJSonU7+oGUqMu6Q6MiOqViIIYUF4immS+1kCjy/a1L9DJQ7Y2czJB9VKuvu16t8oErqceEvGop1zqXKtLsFXL8QJfeWZ80m1XfMlMsDL5u3Vr50Y1EHYolQ=
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 16:59:33 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::a2) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 16:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:59:32 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:59:30 -0500
From: Perry Yuan <Perry.Yuan@amd.com>
To: <Alexander.Deucher@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: remove the DID of Vangogh from pciidlist
Date: Thu, 3 Nov 2022 00:59:14 +0800
Message-ID: <20221102165914.1995657-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102165914.1995657-1-Perry.Yuan@amd.com>
References: <20221102165914.1995657-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de093df-bcc7-4b95-9b47-08dabcf39d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TR+Ofa0OSW6kkn0MwQ56lvAdcjSd4WQ8NK6XttlMcSrbeyN+YY1MBmyyyE1PglUmNwqxOqpfHYRu7W2pGXajUkuhlwmif3KT/6t/0eeVRA+/r21/SqRHu5wxXPxFx2YFa61V/XCtzn2UEd/DD9R+QMEoxFcOIvOp52eaDOx2sWrSv0Ac7MwkE9/ahHvVIph5wgIjDwCnPaNf3Dx1RvxFHkw80FDZFHwV/vExVrxKhQ9kMJP0ZFkOj8yA+9D2geW5YiCEXm1ARYKchXkhm0avYLSfP0i1uqmjgpsGjBJeZ83FjMwcLclnaznXZNmH/dpckI0/sVK294FPPmjTmVx1mfjmtzO8DfRd+CbmVC5SuQ2Dnn8RpInkEbb/GMCJ+Wg6YiDpXJ75C29KvaqUUhtsUb7yPLf3IxgVBn7OTfCQMy8ZmBrgk4pTFH0zURWk5yzESqWy362KvWhdDj1nWVGZD/iARcChIVTt/rCK25Yl8sYO+XxCTdZLSITw0Bjbom2u4qjE/hSMlQlDs9YsBjPy95CS8CT6ZVCmk6ylqIMClsPQNpV8KsLzdkP1Op19rEOJlBuTxeYZxt9sEnrkSS0nKW5h6ke+Qw9fUcjNMuhCBatmI4D0WvcjOAPSRS9o3jJw1l4eD3p7vhgIfd6jTpQPGviDa5Hcl9/DwI6hNr14c+G6M9EJlguNV9r230mfyli8I02IxLqhJWOGgHk8g4flIi8Mg/9ppadJ2gjf4PTgD/KnELmCHmi15Ni0KqPA++4FQoiiJ5Fo6XCPOpeRE8upbgXkz3gt6hQDF+HiQfOFwDs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(86362001)(26005)(186003)(83380400001)(316002)(5660300002)(36756003)(1076003)(16526019)(54906003)(6636002)(2616005)(37006003)(40480700001)(82740400003)(336012)(356005)(6666004)(41300700001)(4326008)(8676002)(8936002)(6862004)(478600001)(7696005)(36860700001)(40460700003)(47076005)(81166007)(70586007)(426003)(82310400005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:59:32.8893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de093df-bcc7-4b95-9b47-08dabcf39d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661
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
Cc: richardqi.liang@amd.com, Shimmer.Huang@amd.com,
 amd-gfx@lists.freedesktop.org, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

change the vangogh family to use IP discovery path to initialize IP
list, this needs to remove the DID from the PCI ID list to allow the IP
discovery path to set all the IP versions correctly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 429fcdf28836..9c323405e3bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1909,9 +1909,6 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 
-	/* Van Gogh */
-	{0x1002, 0x163F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VANGOGH|AMD_IS_APU},
-
 	/* Yellow Carp */
 	{0x1002, 0x164D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
 	{0x1002, 0x1681, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
-- 
2.34.1

