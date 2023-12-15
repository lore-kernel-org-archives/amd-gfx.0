Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AA2C46CC5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413D010EA5E;
	Fri, 15 Dec 2023 16:00:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3493610EA62
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo1o0iUnE3fhPe5bSX8AtOU0Lyzj8VpNCYu+pRwhV8g=;
 b=N3cMEagvcOSQ7gdcO6aWYJwO2RCwl+uTEMhVrALaMsuqEheG3GTBW4tV8A7x793tN0i0SUDDFOTtaaUAPIwcocFzHg/tCu1DnCHF4/P0Lq3dIBP1PGyEzjxRMpeJQQJ04Q3/RFbuq3Subf0xsxJ1xFdCtkm1PdGYm9DkKzcmJRY=
Received: from SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::8) by
 CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.31; Fri, 15 Dec 2023 16:00:45 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::1d) by SA9P223CA0003.outlook.office365.com
 (2603:10b6:806:26::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:45 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 14/24] drm/amdkfd: trigger pc sampling trap for arcturus
Date: Fri, 15 Dec 2023 10:59:41 -0500
Message-ID: <20231215155951.811884-15-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: f2158554-5f4e-4d02-0928-08dbfd86ff82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sY3V/RgmzubXt3D3EoabUQChS9GIbW+BhMISohZXVaV4P6gn3385QstHZiFjG0Y0ZbSKUbSmu7X3DQX8k3fJ/568iMf0VQY6bsj8nfhwAtG/nM99iESViJ1ojDRrYMkX58VdeXPb5PWbi3gRjXwmC8GYHZk97SfNP1PrZoDM3+Mf4QERMVDC65ErsgE//T1Y52cnBH2RAC6RtzoZjyoId7NCCXz7ijiC5UVHddU/zS2ibuW2CYlqpTKohEjvc0APXXrBJ7XaEWU6Tnj4uJvMb9/o7SEJncKlxsRqP6/QWDfDQo6qJs1reGt0+T2AG5e0fnLjASaTal35kjx5X/K8oCf+vBeu2IdVFfuuCvfZL6wQ1pnwHRxlVfzdD1WaCFdI3gCGSoGWG4KasnPktFfugbscyjeXm6ztHZNepo6Jnar8gTKiYX1+tDp0bjBwh+LXxIXZGiH/k/bDzHbmjJTb/j2E+3dxNqegF9cS4iXcA3XZ0MhJ4rMJbZrVuH09hYNtsyhySEoe0jTFfy+9uV3a3RrUellqC7TFXqy7X42MZxFoc4vZtak+vLXdYKW4ZTT6arneUdnT6PpiEZZb3JDoGa2KehaeSaLvLc0PgsSHWRsWJZZnA+2WCN2UffP6/QUY0X8yL6LDwXAMA0Zd7ZTkHwyYOAf0XSgOF9pjHiHTzh4Z0DZ/sXNawmw4j8CTrtv2xHvay1xNTpVN3+IvRuUlcOVtV3GD/3MQRJ4fyaOEPf/mOs88zpNn7bLouMGFq4mHNeSXdB/Q8O/pvUfDTF+8Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(70206006)(70586007)(4326008)(8936002)(8676002)(316002)(6916009)(54906003)(478600001)(41300700001)(5660300002)(2906002)(86362001)(36756003)(2616005)(1076003)(36860700001)(83380400001)(40480700001)(356005)(426003)(82740400003)(16526019)(26005)(81166007)(47076005)(40460700003)(336012)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:45.6589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2158554-5f4e-4d02-0928-08dbfd86ff82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement trigger pc sampling trap for arcturus.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 0ba15dcbe4e1..10b362e072a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -390,6 +390,17 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+static uint32_t kgd_arcturus_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 10, 4,
+					target_simd, target_wave_slot, method);
+}
+
 const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -418,5 +429,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.trigger_pc_sample_trap = kgd_arcturus_trigger_pc_sample_trap
 };
-- 
2.25.1

