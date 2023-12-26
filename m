Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8842BC46CD3
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Dec 2023 10:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B1110E06F;
	Tue, 26 Dec 2023 10:04:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5A310E06F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 10:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwz98IQP/TJ55o/9Cu6MswCZwh920z8+p6JKTeeochFOlyys5EDxfM3ZJ94CYMo6WHm/UVhRU2zTD7pWqfI4gln3V3VSgz9Qwj1lt0j8PL//94zz4wuavBJlUpsuSUf2jsOpuuSKfJ1BRkeLB1onGK8unrE1L+dfK1lZv8lTCAXPU5mesGjZsKK+kFMgn8KTsEB8uPPU6m6QhJLYNHmq1+1rVKtO/oi8Hb+Cle/VsUVm224nMBKPBaiH51zzQdILb53eQ+7wIYrdsae7tAIVlzZx2/hm9SeVgQCeH3YNxkjtxkEcVTrc9pfFt741J6oVJvTQ3hqSeDLRxE4XNegkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YGytVdxEH1EOSlVDJtAGEWaUGzNjRWblvmTwY34MMw=;
 b=L1QiDgWWEVyT5/KvlyiS7yyC0NefWmJ8EKgWuua8XkIQCh2SVhF9noCh0ICFlniLTzYTYnpMhRd/0h8JV3k9eU6bOhiPyIUQFuIVEg9CnI6sZrm/Ct3vDmvHAHFED8XQv6Ad8dM32u1C+ZmgfuXx6eDxtW3R3nvHzbdITHLfpAo5JJKqd4laHcpWg8mnpJ8hhI2gpYVVYVOt9N4SRBql/Nex8IBcAiXrlDxa7NbR/DorT2HM5dZjVGVgDdd3yJO3Cnb0RlV7ybqQ+stFtO5AX095wFEOrfyBOhGfvtuoh7/7Py0IfDw255ytVRCWuUhEZkZLk2BSzGpNLamQuoAKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YGytVdxEH1EOSlVDJtAGEWaUGzNjRWblvmTwY34MMw=;
 b=LViZK8qm6hV3He5wQSWPULFVpgUM7iudg8XTMyrtKiOSi99pMnSUyx1c7KAKU8SVa2sEyNtM6jDTxJP+2PKWVpPaKQ7N3Ol9wPZLCX3TA3MxlWmeis0QWTmgneT7jigiHJZgEEnEX4KSB7VZquS7XPGw95gqR25UAwZ8s6SYl+Q=
Received: from SA1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::6)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 10:04:45 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:22c:cafe::ef) by SA1P222CA0030.outlook.office365.com
 (2603:10b6:806:22c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Tue, 26 Dec 2023 10:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 10:04:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 26 Dec 2023 04:04:42 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3] drm/amdgpu: Release 'adev->pm.fw' before return in
 'amdgpu_device_need_post()'
Date: Tue, 26 Dec 2023 15:34:24 +0530
Message-ID: <20231226100425.3129745-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f8e2f2-3b82-4ca1-3746-08dc05fa161a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VneYgNUPPkHsEcoSX1TdW0ipNPhrBN643ww+GpwVW0WsxErN48GleTFml01NkMBfF8nLwvegyb9WA+6TvfZbP84ZAQUh7gfVPyTR1qwzJgaVhVxHRAa/DX3i0Otq+XZ4aTv6BK3F7f46pd4fPxjQJKLLQIo9caWkIebchBIgCn7SjV8CkZF3kaAtCPyrkRZYF9dOuznNK7mAjmiauCQuS0wp1oxdjRKYl/2CAJ1xL/UqsfLG0yCquXQQ0iOYuZzR8RuXm/8+S5NptdUninjuKvs0O5ZDMJwcDCilzReVubG4mk1479zLO6rxfYnYjvKZgfSPvRJJ3Yco1/Y4bwdpDqTU0Z3tafkygFco13Ro8QMG2mBE/gWmVauBDKwpybURfMcQuU/18pb9+38PJJ7d2qa/qj6csu78yIpsfNqgCxjDAJPTvKoYvYbe8UCIRFXdCfuNpog1zZT9XCW2MHYK48U6lWjYmkzkY253fmEGKOqJznQCwSjxL5RqvqsO+3MO6jbV9VoCi0BoniuZKu8cg+CE/i/GLZvSVROuVBBhOZer5qQSgMFPC0JhuxDSq4aJun98NNJcUTMf0zpxHmWmhEbepIZVojW5mFw7G8eSJWPORYzZIg+P41OWGo/79zicFaENW0MQiJOZxljDN07BqO9T7L0pQuy+xwOJ/toIVxVF86V/NoD0WK3vRIkIBIrCeCQgwVkHlCFQs3vr1sZLKLcJZ10zw63iO0jY0PJss4tDTk7OgujudYaQ7ooeyBI1re9Uaruk2c5MvjbVYW+UWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(41300700001)(36860700001)(83380400001)(47076005)(36756003)(81166007)(356005)(82740400003)(44832011)(4326008)(8936002)(6636002)(70586007)(316002)(70206006)(54906003)(8676002)(2906002)(5660300002)(7696005)(6666004)(16526019)(2616005)(1076003)(426003)(336012)(26005)(66574015)(478600001)(110136005)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 10:04:44.9922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8e2f2-3b82-4ca1-3746-08dc05fa161a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
'adev->pm.fw' may not be released before return.

Using the function release_firmware() to release adev->pm.fw.

Thus fixing the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post() warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Monk Liu <Monk.Liu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
   release fw needs to be done only FIJI ASIC (Lijo)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..33f37efaf373 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1544,6 +1544,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+			release_firmware(adev->pm.fw);
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
-- 
2.34.1

