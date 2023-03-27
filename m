Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51C4C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 17:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F9C10E3C2;
	Mon, 27 Mar 2023 17:20:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45C410E3C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 17:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTpMsheQO5nVKTw2VReZ3mPkVzEuzZSmM37iDwnLji7HBtlEiCKhONR/Rv9gYncxK3U87VU7jqzPyEtvEtCecX7P1Hz29vnk1MkvQpFCvBECy7q//rLKhsB2eeH2iFF/2EjHtPgVC42CEVA8mJH4BVSZOG8uG0cTku3Y1djipw6E/r/r6LgQfehBnuXcWk+l82jyPFq/d/a5F2gEYHVXlRt5Sg83N1GyZ6sN7LSiRVCMr0QnSd3WtLGQb+clwFkqpEhJlWvSh5X2seDjdJmHy2Uf7fCnkrJO0HpM2Br/AUgYh9g9uQiEj1XXS39N4o95c4Pr9wXvJla2kvT2WcpYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrNIDuSHV0MTyt20jXDO3iBKWHwn8LByCDo3Dt4ZJ64=;
 b=WQq5zCN3c2f8zO2/rhUXRiXcT5YK9l1ZR1L1f8mekzGfxP7u+Iqrhgjsn4GDC4ISAH5c1Z1ryj38AzbeYBK5/89H/OZE0X4ghjzE4HhPPDM+Tms3KkePzy4K331brF0oTt5yDAYgtaCjfybODtKKnUwcXtHLlim9MP4sK7bGqaGwRcxjlQRSpPWqCsCTP/qW2dQ5hpdymyCehYdk62IT+5snc+rsa25aqqHohBjwvzpHJ5pzRNM07RFwQm0PBNRNpHF0h6FC1iQDhIR01L9KoDE3RqZoIwzb7a0zgQugu7JHlQo+GnGt1mSsk7ef9N2SOBnjxjpc+i7U2Th7IoUM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrNIDuSHV0MTyt20jXDO3iBKWHwn8LByCDo3Dt4ZJ64=;
 b=swPjJXhC2OOCwoxlmDZ2wopbsNxJENMm+NiaFa+VuZ1WUxlug/8ZsCyZPjsDbs5/fs1nt5zg12kELNdW73meZ0ZV396xWy9i7/oIldKBYHH3GxWFlLFD4VYEyPZ4yYYeZOLzHY+1kzNT8Cr4TOOgTCEt6A7ZkKcZbDJ/5LN7Bes=
Received: from DS7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::16) by
 DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Mon, 27 Mar 2023 17:20:11 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::74) by DS7P222CA0020.outlook.office365.com
 (2603:10b6:8:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 17:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 17:20:11 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 12:20:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix error do not initialise globals to 0
Date: Mon, 27 Mar 2023 22:49:53 +0530
Message-ID: <20230327171953.1910597-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|DM6PR12MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d39ecac-6100-4da7-0b15-08db2ee78550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuM8zBXvyC7gVbyUUqRMpdTqxDSRi/VAfqxrBQ4kwz9QapQ2zFYl7e/JJFbrHzAhxTGTQ8kYI01GTwkBSr6q5BpmZj9LV2V8b5bvUT7TIyLSd2AZ3yGr5RbkJCPQtS+lBJ+00fr5NgXQ2XT5GvoLZQ57Ac43LxAKWVp3trrc9spbRmzYMIe3ILHYv9SfWDDxMvGojozWk/knPXXGtBzhmAgK2GkOhkloI/eK1osfi+71KlhNxjGprS10fpPhCWT+5zI4J1FBMogK3WRzf5u8sxYpg028No1e2+Yc7KNT8Gk2ROfx01et94Zena0X3tpW5xJ776jRG6SMEHmWc5E95ARNwGi6LY7khNoo7Kr1w8meLIRlaoU0pUwAq4In4ITCt4gHF+5ZkfHWcNr14YHaFQx+LZbk+K9opyLpCiJlNcWPG5ZPbuzzYOWEIPxPDZU3c9bPeZGo4+Z0TJpEAodSxdBS4SqQDTP7FilbittGPjAUXaqBxcigct5mZ1aqT4XypTjpT0Mwgm+fiC4Mu6qa/UnwAB9q5tPQcmPQ1aAuwYgDdHKWHKD933URNm7jjF2wETPSMSdUmWfSQbvk6OhpodnqiutWxU4H21DEgrdV1O8qcUMIAnT664mvS9j8ziFXhHq9XAqSRjV5rWwPPYvQ4zmNvRaPmplzeBvpL2BviwVifqDVTlM1RF6RQoLYLIIKEna8MGichzU/vTDjsXSCtMPoy2VaOxiBRFASDsWkmg4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(26005)(16526019)(1076003)(40480700001)(41300700001)(6666004)(186003)(7696005)(2616005)(83380400001)(426003)(336012)(66574015)(47076005)(478600001)(54906003)(316002)(110136005)(6636002)(36860700001)(40460700003)(4326008)(2906002)(8676002)(70586007)(70206006)(44832011)(81166007)(82740400003)(356005)(36756003)(82310400005)(5660300002)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 17:20:11.0277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d39ecac-6100-4da7-0b15-08db2ee78550
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Global variables do not need to be initialized to 0 and checkpatch
flags this error in drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:

ERROR: do not initialise globals to 0
+int amdgpu_no_queue_eviction_on_vm_fault = 0;

Fix this checkpatch error.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 917926c8dc5f5..67dbac87202e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -823,7 +823,7 @@ MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = defa
  * DOC: no_queue_eviction_on_vm_fault (int)
  * If set, process queues will not be evicted on gpuvm fault. This is to keep the wavefront context for debugging (0 = queue eviction, 1 = no queue eviction). The default is 0 (queue eviction).
  */
-int amdgpu_no_queue_eviction_on_vm_fault = 0;
+int amdgpu_no_queue_eviction_on_vm_fault;
 MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (0 = queue eviction, 1 = no queue eviction)");
 module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
 #endif
-- 
2.25.1

