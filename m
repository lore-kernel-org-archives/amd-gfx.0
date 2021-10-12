Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549A1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 06:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1306960F21
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 06:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1306960F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61546E52C;
	Tue, 12 Oct 2021 06:16:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8396E52C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 06:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eotMCk3//3uXoYGjP0eb7zfZj/cYEDJVNJhzg72YU8abF1ZR5uVEmpNV7Xtrz7USp8/W8VIUOaNM44SsBiQtI4nCXf9T3JGb2YVV/grAaO8f1vy+kp4kXIA+3t/OsYektY48dE5sUOB3YJMmXB5IY2jiuDJxtPDV+qH9dBmUIMrvd+vqAHUrQyKZ0GPeUHB9FRBEOAtQpwkjnXrACiMEliiD+/9+8Rz0jB5kGE2bNAXrSuzL9bTAAc1Ym8KjMZp8EUKJpLVtkldXM23GxawnEvgkhA9sBHid+tfeV0YLT+7nKRAqwsc4dCH9x7wDvepavevyTf2PoR8acPO3B9LRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZawiT52LCc3KivtlQkCcx81t3O5dkXDJTbkB1fIgWc=;
 b=c+ahgheP5WZ68chtbVpGfw/A3k/5CCYgFOA69cOWc//70506SQmmwwzpi8N5Z126Ap9ZwOFS38Im1G8SQTERaVwflbBHJBd8AEgajBO/Rodm55Z+RyJPHf6awk2xK4Jh7R5FA3MivTK6qNMxpLiVXerFLCgbtdBVpPle4VewL1mlWy71WvF1J0/RXx+tEzEXQRjEPjLnL4NCMajXvYwmNgXk88uDZ7BEF8z2IOVo8A6ZbzS7Hrj9aV4Dt6iQOimQVbYBfwhSPuTen2Uk+cgyulmEDAdpXUW0TrRwHQ3T71Y7b+SFHJfMEgr3RrdzbVH01VT53NFAAWym1157rRT6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZawiT52LCc3KivtlQkCcx81t3O5dkXDJTbkB1fIgWc=;
 b=vAX+J14uyPGWGHrEXf/vYtT/LHstC24/DFpRbJ/d7jByByeSGTw+2OtFehL1A/qrd9hYl6XhGVazJTsPz4h+e3HOCCs2UFi+LH811y/M2k3r4Ap5vggGvac+UaE559RZmfp86otBV3YNopkQMS1a/eMR2o8krSgsWnDvpFfh+ds=
Received: from MWHPR13CA0045.namprd13.prod.outlook.com (2603:10b6:300:95::31)
 by DM5PR12MB2405.namprd12.prod.outlook.com (2603:10b6:4:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 06:16:22 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::da) by MWHPR13CA0045.outlook.office365.com
 (2603:10b6:300:95::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend
 Transport; Tue, 12 Oct 2021 06:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 06:16:21 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 01:16:18 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: enable display for cyan skillfish
Date: Tue, 12 Oct 2021 14:16:05 +0800
Message-ID: <20211012061605.809634-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dca4d4d2-bd2d-4fe9-0b19-08d98d47cf91
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24057C17566D4B453B45EAF2FBB69@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88RmWTYqeowdfgU6iyGGQrJ0YG9Ec0cO3Kdh7yGHJrrDdFxjub9ZzGeMJ+EZOO1iX5U+8kMAo5Xs9h/vLBzqFqeG8F0vayqJdYQP26paITmc5W54lddY0PqOJq2QjETvl6sSOWBtq6zTIXlfeqaHjF7BQLuY0gwE9GFORAGJWfNSAualmpnkb4j1ewYFEOrec7qSxdHv+25N5+CWQAHDOT2J4QeM2TO7K/Ib2jIUkcTWFG9O7PBksRygWtV8oH0h1hG61uSOqy2+nSILbh2AIVXxnLNLdkYLy+Aof3+JqVq+LVARmy6943wuOgvYTHj4739FfeD/pqBN8MKJ581vXbsp9L65A3WlZggYOFrnojdMlLWUv3CQnMztVh9lQ2VApvy4uN/3kDuxDF9ZUtzKCD8S0xppfWXIslleHeFzgqxY/KSsvU4ORuOXebv+tW5q+JB+GAADMXE20mB1rjfoVJCyRkhffpLp3DkMkKFa4mJi8JvsnQgcHUG4BvBlxM/v7mleYMkgJlubsChoQaOQdvbZ8zOeBJAx84bNJi70HUIWLWM31nfyJQK9xXrBV/Lp0HE8zPHbc3JqJXIY43SNuFcflP2N0F+MNcF9N5OI2veVAhIwbyHSCzkM+y1D1ywRPr00oOc+KvIfuzpz6foe8SzN00Orbj61rFaQAXE1ZhFDy/SMQDkrNv9bLYJ6ByFxFNsYTJjysr6m3G9XnAFPqqyQ/LMVQBbJeahzCzn3xt0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(70586007)(70206006)(82310400003)(2906002)(508600001)(4744005)(81166007)(1076003)(356005)(7696005)(44832011)(2616005)(316002)(8676002)(26005)(8936002)(86362001)(5660300002)(47076005)(16526019)(186003)(4326008)(426003)(6666004)(36756003)(83380400001)(36860700001)(336012)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 06:16:21.2767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca4d4d2-bd2d-4fe9-0b19-08d98d47cf91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Display support for cyan skillfish is ready now. Enable it!

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2bebd2ce6474..4228c7964175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -736,6 +736,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(2, 0, 2):
 		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(2, 0, 3):
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 0):
 		case IP_VERSION(3, 0, 2):
@@ -745,8 +746,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 3):
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
-		case IP_VERSION(2, 0, 3):
-			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.25.1

