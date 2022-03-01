Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6229FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 13:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCA010E5DA;
	Tue,  1 Mar 2022 13:05:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E433310E5DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 13:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrE9wLamFSTwt93TrvQSUEtMZ2MrsRX+aYI1YSQ+seGAT4QTrVyYBQxJjgsuVtPQvKzYtzAkm55wM+kex7NDW+vkYj6G+06nfKz8tG50eWApbIR2+pTez2yIw3KejqxtYDYKqD7X/qeLllxyxmI6ETelE3pjCP/DDY8ZzmmRLym9/UcSVbJ4mUhNLibbWE8C1w33htV0DJ2LhZyz2xzsTydH5dHyVPorUEy/49Irtw2yVhamqTG6nuQDjcKPa9/r/XgdxoBSjNL0XQyjE5XnvsQoXBvnf7BNyhWgxvKU2s3RvaaKJaCtdPg2hBb3fSIH6un4ZmeVDZmqb6XCOOFSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToB++7odEK6IvCGYOMI1B2uwfVuWY1tlBXUdTUHpGdU=;
 b=PSEENxUIuV1V20WQ+A4Ihzy5MD9k8jsymNPT2iR+hdasaqa04/IDIsD1yiR63C2G6uyZTjka9oGGLVvugnLz6bhy4nWrepWX0VJ7kdvkpiDxv2we8LbVYnVAHsTzleN1HS4A8Q73lKXaTu3NHuNOw9H1Av//JoFhqdMMbyNYN7lg2a4ol/szdTjMJ2BQnEwVi+SvqPN+SSmsEK2iipbEmP8KHAFgnehL0NEB6Us6yuahLPVhNB30DxEdAZgBGbpGzcOyYhtMv29SYzt2UaLEA8COGv1LuiTK2vCgBfBI5OqJKYjTJ6U+wJ8hh6FBU6jYpC+arb4WbY379uwGEVFXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToB++7odEK6IvCGYOMI1B2uwfVuWY1tlBXUdTUHpGdU=;
 b=YWC8tlxGOGoEDbMU3Cl+9+L+aA6+6FWvGXkMocxkHv9g69qRXrVxPONdSzUjM5X/JpSB9wPc7q+h4iNi18eTYr51x+YjCjjmLJydIF5xSzif4UVZUxcK/2+VSeIx1GpH86xUeks6xaeYb0DNzTHkErGYmQ60pB2wgCGioxbQBmA=
Received: from BN6PR12CA0040.namprd12.prod.outlook.com (2603:10b6:405:70::26)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 13:05:38 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::68) by BN6PR12CA0040.outlook.office365.com
 (2603:10b6:405:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Tue, 1 Mar 2022 13:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 13:05:38 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 07:05:36 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: move amdgpu_gmc_noretry_set after ip_versions
 populated
Date: Tue, 1 Mar 2022 21:05:04 +0800
Message-ID: <20220301130505.3723500-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2562bf2a-8d23-48fc-cd5e-08d9fb842e78
X-MS-TrafficTypeDiagnostic: MW2PR12MB2569:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB256997504C2B9B876D4A2304C1029@MW2PR12MB2569.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9TcfVpXqGTPcwyUFXGue8iRaSRKMZspaWBc2Ng3adA0MJQxHve5g58vP1jMgpO+k8V87Vh4NnElcxYNo/7SMYmWywujdjslRdxFvvOzhfZZNSq7kaup54CgFg2ukqQ1ITDThvBBHIU3LCrx5KhpzTtzi7pkMSHrGQWaGC8socB6O29Xfh/q2+G3ENKDLTd99VcbUZN41JswT4URHGTE2zm2dioRjec0AsNCdprABwz6PQUNYV32NzTNtwU7Zu6hj2pE4UcZtsIpqobAsfxyBy6ymaXpD3su9BKrafAQiNY2O0X+thV+Lxs7czlSJHAzmKZdH0VuN4YpwoZergxn0JzK2HIvpwnQtA3/XO8lA/9l3LMjOjmvXt7Mr/DySCi+MtlrGGqauuP/rfBPZ6gPsoFeMxWT3P8eRP7Q4MS4p1qbtqlXC59tC1yK0tg4lAV9LxnImcKhfvNHdf2X9pnhTBKjjS/Jo7aJeP31IQwEhxeyboDZFX3bt22RDHhKt4q5kfvMZbXfmhVTasPooWXc5f/LE0OseCpMdCbeTe/9mRKPp6nuPf2yBjY4NAZX6d/zU1+R92lh8Mxxfa6uz+QWjgnREyqwfX/ySa7k1hnv9ANNQ/lAU1mEH56ZSubVxmeH4zf0BloJTV0JRg1hQ3uPUcVlw2CFaEK8zQMJCcE+gqjRkcCYUld7OGCvR+yCjUmhj1RI/62/vOuiqqcUPmR7wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(36756003)(36860700001)(7696005)(47076005)(1076003)(54906003)(6916009)(316002)(81166007)(356005)(6666004)(40460700003)(4326008)(70586007)(8936002)(70206006)(4744005)(16526019)(186003)(426003)(336012)(86362001)(82310400004)(2906002)(2616005)(26005)(83380400001)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 13:05:38.2934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2562bf2a-8d23-48fc-cd5e-08d9fb842e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

otherwise adev->ip_versions is still empty when amdgpu_gmc_noretry_set
is called.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6113ddc765a7..61a6a7920c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1554,7 +1554,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	amdgpu_gmc_tmz_set(adev);
 
-	amdgpu_gmc_noretry_set(adev);
 
 	return 0;
 }
@@ -3641,6 +3640,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_gmc_noretry_set(adev);
 	/* Need to get xgmi info early to decide the reset behavior*/
 	if (adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-- 
2.25.1

