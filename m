Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5F9C4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 04:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF8211310C;
	Wed,  7 Feb 2024 04:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bjkHZmbP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70BA111310A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 04:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaVjsxXbi3dCTXwOeqMtZwTLf9kHXG8bY0Z0WsZ92ULgyPq3LJ/2+6Q9SyZR15ryPiHh5wyizq3Nm1oE1XpsTXusW0UV27I+STarp3fnIY6tzGs9vTrQv8Gn3wEbIQzsgY6UKFQ0LEDYrX5SByVDblLuOdqlTq+Ryr+vkCQZUGOfuKPBYAchTAXBW3Xd3hdexsneZjOCvJbvUr4etF0CMj5Lvo+lWoz6QJkPG99mSmlbu/pLl1K5TsGeMLRlNMxanTHutJDSx4xuL4FDHs0cprBGkCe4BDgDMO53CV88JEMvSGYUsGUxGwnV5SLYPqHVznLxsZxz5mDhmbd9zIcoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZp8Ctuhmb7lcweJ8nuStoe+RF14v54+9V5wSI7Wu1Y=;
 b=izjeLKg9ocpnIjLoV+h1OiOPqpgV0tSOjb9A6psqS4HMc8QLxh3lpRCa23TxN7GjWptBh6sa1/VoMqUFwZxazRocGdUpT7Tx35EF4qWZ2Uu040dCJvV5RcW16XZD4V+TB18NtrJzDYR2WyWr+jxiOvNb1jSAZcUcXitkbkJvOn4XAuEE5UFMdBKtvmR+jVuu325tuHQ/GLJA5Wa+qBYqvbmeuQqHncJsFufjlIprBjt5mblJ44Hu3Qc0nKpRIMsKjdAr92KRfzaPAzIrlR0OxMXyeec9L/3w+AHRxXxYcUIF8eUslmBdp3Xxkc41ZQLaz2MKJv9q4QTv6xgDZ96akg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZp8Ctuhmb7lcweJ8nuStoe+RF14v54+9V5wSI7Wu1Y=;
 b=bjkHZmbPHmKj2fF39vBgrHGdN0b8cfdSALuURAdVCBG0nHwFp8zf9/9AgBGJQQEf3VODyJjcpEtXrWt6oXCXCr02X0iw8VvzGCvgWoVJ9nEhw572G412BF7ruOddspluEcf7FjGkCn9XDtKXn0srMkzBSvTXCivneXoqmEWCubE=
Received: from SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 04:55:29 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f0) by SJ0PR03CA0283.outlook.office365.com
 (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 04:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 04:55:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 22:55:23 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Andrey Grodzovsky
 <andrey.grodzovsky@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix possible NULL dereference on device
 remove/driver unload
Date: Wed, 7 Feb 2024 10:24:59 +0530
Message-ID: <20240207045501.3344729-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
References: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: eff2538f-8279-4599-32b2-08dc27990177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqT0PlJVNCJuujX5fLczxBFdXOqNZEX0MtypBhokAjlC0wsMWb1qRmU+hKAINVcj4eK5Pb3Sl5LpJK3U41/L6bM3UIE/8xnGhJVGrNvP3HTv8URRTJl5BF5L2wQ0VkgarlcBrFR2zQcewx0ojxLqHvf0kE2T+Bu+ifw4uevNbG7G6FTR0urGaRwIpRfATIRsmJaK0d50lIsgc5hmgSW6NUiJxTZFUCIOJUMYux0dTY9K2Ifk6xqcVd1Cid1nC9CqdmmbQmiuuk5tZkQikt/H/fnaC1pJ45iS27hhNHLR5NDdF18rEkzs6lJxpdgC1ACz0uNMFUjJoyyT0jTCvHmtE9tuLWohIDLETWRvUMIVOqD2oOjStcweuMx12ZPKCzCJcJOOlcGKdZ7sH75cfBhJUAHPIHJO+LZ/4XnySPazoRouKZhoTfZ27MxbqgwEU5IQyPXJB+kkFZABYr/hbQIgvYgl77ADVhNvr5+fB9WNRYKYj88aggV54FKDQgIp2UrmXI3GJ2bzrdVoa7VEgZXoJfXp1WEmiarnMmMLV5k+HWe/I3i/wmorb8/Nsnd0XOi7gGfuwKo1HVPlkfLFe4oRM45WGdw485kzLOuAIH0be2HLQMeIkvKFZDS71mtJPhz52aGn8bcqqi3yxbeQQG2R/86O3xZ3A1LWSnR1wLSkKngl92oloSxV426A0/LKeWK/sM1HdHsdrJZILCxSkgDVl5M8T/38BLvqWxo+/Wo4eVo43TXprxu/FCR2M7BaelbRBNsAKbR8y6kP3LcFzYlReA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(26005)(2616005)(16526019)(1076003)(81166007)(82740400003)(356005)(47076005)(8936002)(4326008)(5660300002)(83380400001)(44832011)(110136005)(36860700001)(54906003)(70586007)(316002)(8676002)(2906002)(70206006)(6666004)(7696005)(6636002)(478600001)(426003)(336012)(36756003)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 04:55:28.6117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff2538f-8279-4599-32b2-08dc27990177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
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

As part of a cleanup amdgpu_dm_fini() function, which is typically
called when a device is being shut down or a driver is being unloaded

The below error message suggests that there is a potential null pointer
dereference issue with adev->dm.dc.

In the below, line of code where adev->dm.dc is used without a preceding
null check:

for (i = 0; i < adev->dm.dc->caps.max_links; i++) {

To fix this issue, add a null check for adev->dm.dc before this line.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1959 amdgpu_dm_fini() error: we previously assumed 'adev->dm.dc' could be null (see line 1943)

Fixes: 006c26a0f1c8 ("drm/amd/display: Fix crash on device remove/driver unload")
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3a5e730be24..d4c1415f4562 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1956,7 +1956,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 				      &adev->dm.dmub_bo_gpu_addr,
 				      &adev->dm.dmub_bo_cpu_addr);
 
-	if (adev->dm.hpd_rx_offload_wq) {
+	if (adev->dm.hpd_rx_offload_wq && adev->dm.dc) {
 		for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
 			if (adev->dm.hpd_rx_offload_wq[i].wq) {
 				destroy_workqueue(adev->dm.hpd_rx_offload_wq[i].wq);
-- 
2.34.1

