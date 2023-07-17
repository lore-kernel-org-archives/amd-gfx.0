Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BFFEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 02:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8B610E12B;
	Mon, 17 Jul 2023 02:26:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0653910E12B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 02:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoieyMkGJeya9Y6DjFf3MK9qZ+8dKOPkBpoUhk2RQvbrrlu4DigHAs4w7oDBu5H3IsbPNXXAPuJUcksO2qf/9109sDAwp1YAally0VneqiEI+kuqt9kTKpzzc7dPyG2c0RQRx+d4oHFReOvP9dsi49AippsJE6bIyw8/Faser0Ko2iNmUULOhGKI4QpZxjo9ni1X29xpdgwl3LNdEDqz+VvAiCIYoijSmGLJ5+phdmWLsb4HU31rArjxVujZcowNe9aYyEWMTTQsMrt9MOmlrbqgcXfs1RYldTI38j1GwKyaR1Hwxuv9OkywgmliaHlWAdOJ9naXbGRi43n7o0eDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyAWzdtZzZLCupOAkC2kKpkYLES2hqOktLDt8kK3B4Q=;
 b=ONyYQTpEUn4oJRyCvhlBoD4IEwJX8o5AU2i2hjQI4/ITamMBXKv73z2Olv98fwb4xO4nocCf21ECoX8pqXUwyiDk98MXtdC4rVwcXh8Ph2dLjw+J8kCG2Y45jjN03DM+3rCCBvV0PR/0Tu9/1svhAck42g/AE2Pw/W2YY3WCkrLhdiuxr3iN1MzyXFS26W6bONlxLmuWwRVz3BrwMW0iis6KnvnBfvvrDkc/sy83lHPx0YSguFN2eTxVWpcSjTu+gx6cV/QnFuvuJ/vFMbgB1CNaUIBLSCHa/ykg3o9KFrVzMQC+zBwg/ZV7TDnGWeatdYFk+TjeA08EblEysvPxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyAWzdtZzZLCupOAkC2kKpkYLES2hqOktLDt8kK3B4Q=;
 b=XhiVSXhVnKm2Aku6+OvFvJC9Q5gDORy2NY6f23PmmMFFUeyDpv0U2YMzUCkWVWAHmRl+ejLju+F2cEUypoTwGz73uh8dK0C3H74ZZd6BpK1ZgSKJfBA0pPMkNfMo6jAb+WdBB01CXCH3ftx0LtO0FY6grQuHomVUDSRug6T95DY=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 02:26:49 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::d0) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 02:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 02:26:48 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 16 Jul 2023 21:26:46 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/vm: use the same xcp_id from root PD
Date: Mon, 17 Jul 2023 10:26:18 +0800
Message-ID: <20230717022619.3833601-3-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717022619.3833601-1-guchun.chen@amd.com>
References: <20230717022619.3833601-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dbe569-e40b-4bbd-dc0d-08db866d4601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sAIlU2ckBFNrcqwsPk9QWsEDxT5XPRrqlR6qajCU1ZHl98B+kMk74BcJfqoqpauDfRtwz2Vgh3EyStNXYWKcO9KQAhc/Z/K6GCHpXWeQQ+QW/OrmyFCNU1U0brSvurns/hhd52wEpIkv898NKFIDar+Xz/ZhAlNCwnnxL+dkMTNwrJ0dO7DzeUMzGj8pJMh/oeYzVL1aopVpXv0xVmwRBMo+fTVSDSOxV69t2xjbbgD6LkLY0gL4Y4Id2KEgerRcXC+CpI12GMEpprwEJDazLAL3lQDq3VvKG/p+xU1yjjtESoGZnaJ5hIci6GpIrm6be6RYQIVGxeika9OL5Qss7InL+ibvmJAvNTGJZtDXv5WTtQ6sonjzJRMIRs6+L/0EDqhj8xioPB1Zdjtd5WkBXmEhh6kOvvBYZNj573NPmSvlhJVFn1nEVv97niOqBWCzop0jkEvn+CqU8rxEoIpPSSfFHgtnHzC1/DKNvnfu3e6GHh7d4SSePUnE+wFmUyxrlYmO2bsERxsWmLWOXKnaDeTAO+sFG4lyAmJ2QWa/DTHNYCRImZVZnMhGx0SyMjsVlhpXY2XcT71DizqY39NcCwSbLufn8N3RdoToz9ulzH9NIxx3J9YP3AvGf6CHx5K5kbOG+JANh0Uk3uUDYwyHiDJsliJkCyaKbXVuZkou9nBzGqOMY+tmbdzgGufXoQnbpvvEVfyWWEPftCgwpXpgnm8o7CBATYRg0+DoiRZFRbMz4CvMe06r8+FJk7nPoVRWuz4QSY2srObCTrr6Zy9Kh+ZGb6wRmtEB/2cOOPQx0g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(82740400003)(83380400001)(1076003)(16526019)(40460700003)(336012)(26005)(186003)(110136005)(478600001)(6666004)(7696005)(8676002)(41300700001)(8936002)(2906002)(4744005)(70206006)(70586007)(316002)(36860700001)(4326008)(6636002)(5660300002)(66574015)(36756003)(44832011)(426003)(2616005)(47076005)(81166007)(86362001)(356005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 02:26:48.6828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dbe569-e40b-4bbd-dc0d-08db866d4601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
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

Other PDs/PTs allocation should just use the same xcp_id as that
stored in root PD.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index eb52dfe64948..83e1923f6775 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -607,7 +607,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt, 0);
+	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
+				vm->root.bo->xcp_id);
 	amdgpu_vm_eviction_lock(vm);
 	if (r)
 		return r;
-- 
2.25.1

