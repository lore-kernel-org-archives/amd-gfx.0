Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5DCC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8166D10E46A;
	Wed, 31 May 2023 04:48:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD1E10E46A
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdyVikag+8w/CYn7AOVIq6dgYycm5mcEn1DFvWfF/D7ungLUZqnsrSe4ex8nTjFGHwKZmdx3fKA1w/Zl2/aVEpWBTAzsZJAl6M/lnBm+GKNfUxHCo7aGZN0QvfCXks9zKVIHkZlYh9JK0Bu+3r0hVN/U/uXiNbcaCx5LxnqtLEKHKRFv035pw9VBPsP3HkbhMtcjvs9VNYLHYpL4XdT1vFrCS07nI3YHbAgYnveeROEjR9Qw/qlb5wnXOJ7u56dPyKWeuLwogHLRDTfg54ReKtOCerbqfkk4gpd8RAiV0GPNksRNxZEcP8Wns2uwERel8pSZnNGnNAAMTy7UbdYdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuZxsj4jC5dZz7zbh0qsBJnTGl22h7UYifZWYrUmKzg=;
 b=Dq4qpGPNOlOAUam74n95jtBAAbBwJh4YRLK4SmWn/SH1ZNwyQJ0s80oLBkz3LpWMVBAt/HczVps4xj7OAv4IGkFWA6aRbkTZocW9sm3Z7+FNOr0bEftSimqGWTg+/Lfg70yfp/XoBe3aupgrlUyFJGQom1Mixk0gXoSGhZzcqB218S743apJ8REeVfuAnCotZxnnT14RVW5SRtlDhe3vHFRisez4cragAFIwUQoW/uaOH1d5VUWFxxqjTqTwIFKr5SycPVIMRzU3UziKllJmpB2ZnSEZh7i4PUkIAswnU4OPj1LXlc8ij9j2itd8dUIswse0pAnvtWSEMD0Y7O7oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuZxsj4jC5dZz7zbh0qsBJnTGl22h7UYifZWYrUmKzg=;
 b=Z0E/xxVj9ccEMgymNEBr/ebWwBfgh/bRbB2g/FIXZxJF1eQXVaYxH/Vr7eXaBKOvKEXFb8oRukm/2b9Iojz7hH++aijL2q10KmGl7Wn25YPSE+blI9aBn2E8I/Z9KRy7thgNXq9HWUXR9tJJtwwVSHyPmCgq9/9P/+eEL2pSq7U=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 04:48:26 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::5f) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Wed, 31 May 2023 04:48:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:48:15 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 30 May 2023 23:48:13 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Frank.Min@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: skip force complete fences when ring is
 uninitialized
Date: Wed, 31 May 2023 12:48:12 +0800
Message-ID: <20230531044812.460358-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bad442a-bd17-4656-5889-08db6192456a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZ/wsvQsqIVIikUJCf2xAPtZbkHtNwPBnyoQ8P7kF+Q/QqcIVKUYBEJGeDaJ7qN449cSqLCz1QI9CRii60YlOIvVNDaaEKDtGplrvMcMncoB6VnePSLCwxcmPygYlNYzFiKah+wqAt/5CnRBv72SmGcW1yJ1e2IsiD07yyz8gRNWHN095PnrCSLL1TEDLjnduuT/FCmfZyTrhf6isZ4W+dmaFFP2sBnhlCdzX4RXLPIMg6QLitOBIcStqdbgnS7GTjNC+9jq1ChivNkbmHXsbGAhTpOiudZIMXwurLuIYHN6GkKo4a7Fk+RQw7HvOJtKpOEPdkDNZD4bx69+Z6nqW4fexEHL5eKYlsqvKDvmXGo3O1QboiKS8e/7rhx6xst+5enJSodLScw5qxk9S8SaKjTyfrdmbWM846ug5hiCKL/Fw4b6SWxzl0qI2XjWk/c2sXZirkP84VWydCmJT4pW2dNVjNLA4n3IJN54aQ+LjILM6cUoIlfGbEktuha2xKcR6tHtF2EZyOvl9bBaymkU9KToqBf3/o2eDVHvJBu4dWTPMULuciLxjeegWT3b7668vfcszkvFJnj+BcAptSpsN3N8KBx02HA8kObOKzKx8MazonlMuLxK7zfGUk+zmmTtm2jYY6pwFDcKjwWGy43T6oIIN93AamJDh7GTbldPP2wrP5x47qkb8ZxGFnFGWMvxpKQY55t2o0bq2JzjVh2Q772IUdDNqYeAwZK6FvEjcp82w0DQT4xDg08jR6L3TvrMQp+HZsfnNmI4EESLje1FzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(478600001)(54906003)(110136005)(44832011)(8676002)(8936002)(5660300002)(36756003)(2906002)(86362001)(4326008)(6636002)(356005)(70206006)(82740400003)(70586007)(82310400005)(81166007)(316002)(40480700001)(41300700001)(1076003)(26005)(36860700001)(83380400001)(336012)(426003)(186003)(47076005)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:48:25.9367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bad442a-bd17-4656-5889-08db6192456a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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
Cc: Bob Zhou <bob.zhou@amd.com>, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

uvd ring in uvd_v7_0_sw_init only initializes ring in bare metal case,
so when executing amdgpu_uvd_resume to restore fence seq in SRIOV,
a null pointer dereference will occur. This patch correct this.

Fixes: 043f2271e2d0a ("drm/amdgpu: mark force completed fences with -ECANCELED")

BUG: kernel NULL pointer dereference, address: 0000000000000000
Oops: 0000 [#1] PREEMPT SMP PTI
RIP: 0010:amdgpu_fence_driver_set_error+0x3f/0xc0 [amdgpu]
Call Trace:
 <TASK>
 amdgpu_fence_driver_force_completion+0x18/0x50 [amdgpu]
 amdgpu_uvd_resume+0x1b2/0x380 [amdgpu]
 ? amdgpu_ring_init+0x73c/0x820 [amdgpu]
 uvd_v7_0_sw_init+0x358/0x450 [amdgpu]
 amdgpu_device_init.cold+0x198c/0x1fdf [amdgpu]
 ? pci_bus_read_config_byte+0x40/0x80
 ? pci_read_config_byte+0x27/0x50
 amdgpu_driver_load_kms+0x1a/0x160 [amdgpu]
 amdgpu_pci_probe+0x186/0x3c0 [amdgpu]

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c694b41f6461..d2c5484309a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -723,6 +723,8 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
  */
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 {
+	if (ring->fence_drv.irq_src)
+		return;
 	amdgpu_fence_driver_set_error(ring, -ECANCELED);
 	amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
 	amdgpu_fence_process(ring);
-- 
2.34.1

