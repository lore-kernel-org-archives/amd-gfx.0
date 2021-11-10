Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1B2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 02:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA91B61077
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 02:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA91B61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE3A6EC8E;
	Wed, 10 Nov 2021 02:14:07 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE2C66EC8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 02:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9NRocirXv3WDe2BLazV9fwXT/K0ZHdBZb3iiPlJEoXdPyZO+CW2nSG/jPghI4n/wL0qU74oEWn/5Jk0ldBy+/U13DwYqcnK6aPfrDmMdGChBWJfIRw/WVwlJ3Poz+H+P19A7Q089o4FJ8KwfDkm4+oa0QHDCq03ri9WKYu9xk3wcRVcSaUy7KRHEL57DWhMdoszbKxAwAdw1hCqB6ZbQOcdpX5eDXUz/kHK1dUuzQUEsD4KAeSs+l7/bIDPwuIuWLNvPFJuJzy6lj0xqIlgEjG3AbICPcQTUDw33tgr2bAt74xzD750vXYC/nVMrLF2PoOcjqxE/Ok3mTubh2UG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z5YTySnd2vGlZuWqQLMLhhngfe2z+/avxBwtXnBm5Q=;
 b=l2ch79WRPk6TuzRrz01rs+0wCBC8IKactW0erXDSk3A3a0w/sCxu6rmRGuToLrmTAqJL38tXOp9h/iFoeLMXYhWnvMnPcg0SIdw4vYUJG2ss3JwivgAVIWkd3ekVeYrM7EwV5nv8LFG/vKU7APtGjPPDsfHQiqBT3KP/BgVWf/FK1qO3hwiUgc/ZMes0iTtqddJ/I1xnoke7xHCfxdjpxikcYWjOKZqn1NmxSphnJHTbWZvXt1BoHLXUGdo6gePQ9bzeYi1F6dNr5q/WVWZ5pe5yvmIR0gmqNW28EkkRaEPLx3yd/rII/XTtdQLnFuchGlG+s6R5yM/4XdvhVQmz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z5YTySnd2vGlZuWqQLMLhhngfe2z+/avxBwtXnBm5Q=;
 b=vtq0cws8bWUqUnlev/Ri1WWhaW5laMD6poyFYRj+4wo1We6gt5W/QLHe8o+oL7GOhaqCo9VBwMIVI6TZ4214dtSEdioiqtQjFwJLZL/7439kyieTFCBjiK2SckJslNdGCxX2xVbZxaLSDKWpFw3M34A/n1cV4VzlUKIWz3lpvg0=
Received: from DM5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:3:c0::13) by
 MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Wed, 10 Nov 2021 02:14:03 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::92) by DM5PR16CA0003.outlook.office365.com
 (2603:10b6:3:c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Wed, 10 Nov 2021 02:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Wed, 10 Nov 2021 02:14:02 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 9 Nov 2021 20:13:59 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: drop jpeg IP initialization in SRIOV case
Date: Wed, 10 Nov 2021 10:13:37 +0800
Message-ID: <20211110021337.27171-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de507ce1-f670-49fb-b0d6-08d9a3efc3de
X-MS-TrafficTypeDiagnostic: MW3PR12MB4538:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4538637A8445A812AEDA2C41F1939@MW3PR12MB4538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVCGjAMBweqb26z94+613Xn1ZRVWCKWW7fLT7f71iRjdKFG6SN/JfyJI+Tuel+Op3h1pU0tg9Y0R6y8kGcLmNs5TG+Tq6PJ0cbTfduk7rMwdYhhoCMycg8rP5gv8nNXeKEHAH6Efw1qzhUQhNbWgLUFz5lhqkz32yPxjU9Nj9BbRM7KBGActx+XFExupuX7mJDUQLTliL8zfGZXszm/97fCGIO6e+I99w7B8uiVxNMvYWmEy2fDUdfv6R7gSpjoK+kzgjRrp9Ksx+djKqfy2jbKYwtmv8T5oHzwYy5jDlFJreU0pFwOhCR0M9SzVH2y+9uftVk9mcnAcVN0N1kwGGkiqeLROGw105GOHDDkfy8tEzuCvG9h2L3KypV66gzD9YgmmlYjF2cKdAn6HsGn1J+etto16ONcdEynBO8FkAS4gZwQO3uBLlHZCAyBKeOr6dzqi2ZiG4VWODKGixB/1VJ54Uyn3BIDFyviqHTbnbj2vvB/yMQDfO1AjQeEX3SU/Ys4ImcGkWxF0ZkbWnFuEB+j5CiK1rQL9czRVeTEb+iPysfkuEe8sjsK739E/g+669ub/SLO8qLf9+UH5LOA86t0WiGRVFW73+PZbfatvgxhU5WSEc9VViVIHfx64Ms7CCNCLt3Q7fWv3LYOJgYMSYI+40HgVpKfY2PemRASLJfCk/jYHLz8cvaqspGYdpzQVC6Em1BDjlLBfaZ3UZf756yu93zshuW9xw6fVRl+8UInR2DogYKWF8L76QOWwye0C
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(82310400003)(8936002)(70586007)(7696005)(336012)(426003)(508600001)(36860700001)(5660300002)(2616005)(8676002)(83380400001)(44832011)(6636002)(110136005)(86362001)(36756003)(186003)(16526019)(356005)(70206006)(4326008)(6666004)(2906002)(47076005)(316002)(26005)(1076003)(4744005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 02:14:02.7199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de507ce1-f670-49fb-b0d6-08d9a3efc3de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 67a765c6352d("drm/amdgpu: clean up set IP function")

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d7c8d9e3c203..a20d21409c95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -867,7 +867,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(2, 0, 2):
 		case IP_VERSION(2, 2, 0):
 			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
+			if (!amdgpu_sriov_vf(adev))
+				amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 			break;
 		case IP_VERSION(2, 0, 3):
 			break;
-- 
2.17.1

