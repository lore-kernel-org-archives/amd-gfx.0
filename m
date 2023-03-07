Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCBBC64EC4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 02:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7F810E127;
	Tue,  7 Mar 2023 02:12:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA7710E127
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 02:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSiZ6IkycLQimj73B5XYDRZa+AQaN5XTk/yjUFB7cm/kAjg97f/fELqVIynBA7QoAxhsHowG2/WCuNtVG/ukyCjeCtoBSDjYFMcTK3YhYt2OVy6IIAueSgSuePTG5In6enZuPvZjBb5XvDMPS9c9yjZEjPXVfy/Xe1zijPJXa+77t/voOxBkfeb5fi5twxLxjyK3QMKDCx9YMyaWs6gZU+sgwDu5YGaG3q2FjK8qHlOMFhfoz5Vie9axiKzFLqlVFssULTrJXVDMNUl/p3Xd0qrw7uvWzBGEtw7cX7x0EBz8Ch03AvFyrDqZ1474RhPvbYz2dN97avNjRAMP5Mo+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1csmTMLOp+iM/cRxLJGBD79ShUxlZCfJh5NaReKjOM=;
 b=VoNVRbsIlxyqlgAysTOhnd8JgAEv8pU/3L3rYOjBqVTQCJRTuvPqMFNKNr6asRxxzSDDipk+hufBCA5OVhdbfMX4mzNEEva77C7ux8dzCOBpvPGxpPtd2LKD0VYd0D2HzmJlg5i0mb73EmbT4t1Q+Bah63ARrUYzRuZdPEQ+lgzR1BGHMMKw6cOHdpr7eWpuEUtF8SILe3TbIIgwQomAQAyIAcP6vc4MWxPRBL3Al/KsQ+aOkuUXgkOH+6bfWrTzdyf5oYY73ux2/CL7TgyC0vt9xhSNWNh4+/IbOzy7LMwiT6tdGWiR8VCdrFNE5zvTtRdjfsTdK5sWtCS4PgXC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1csmTMLOp+iM/cRxLJGBD79ShUxlZCfJh5NaReKjOM=;
 b=DAczyNFNjhOcmUVAB4GL8OhUW3S6TGLuJgOXmXiIpuEJW1OqY9pozD20Y+fOGlWBIDlWEUHFknQlLNdDsvTp0Jy3AX9XMAAGRRlPG3z0kmw3iiN9fQ1tFhOdGI3bzsXw6ElutoygG3L+u1ZvqaOvyRRXsqxzYUKzhPzJ/Viqhdw=
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 02:12:25 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::2f) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 02:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 02:12:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 20:12:24 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 20:12:23 -0600
Received: from lyndon-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 6 Mar 2023 20:12:22 -0600
From: lyndonli <Lyndon.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the warning info when removing amdgpu device
Date: Tue, 7 Mar 2023 10:12:21 +0800
Message-ID: <20230307021221.45890-1-Lyndon.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: c331d77f-61e0-4ce2-fe85-08db1eb1649b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKkcBTwMdy4AMyHrCkSseQeHSlasT/JXlYxuigB7enMj7I7mTKl0AFvhrZzvklKNUaiIv8B13igxF3XMfweJMuAJGXQnNn12ExKcel3YfwddpFpnU9OmhtMVVY5akCiKSzMNKQcgUbIef9EoY281YzHcnAGpwszRH6Umh7GPOwbJOqbC2OCJgLXhmK5PBrw5pYmrC5/RLBtiGxqg++4+KH9o1ZBL318EBD5UsvJVq5cjYuq5z4pYYwTPy0DMFt3dM3At9C7TMtNfPrzttEYYKlEJZko9X2oA/TIefFZMzk/5nifk764Ppkz21o7M9cQuZ8iyFbmA8nCMKZ2Bkfqg5VCrh8mvW3dZksr1Hdp9jQ5gpiOwgJ2MWWZeKrXkt+w7Yweq2btPXaMo6I7Qf/hPwsEaVQgQl9xTVWIHPYs8HTk2D82ZIu5z+6h5R/EFFta++49b6vaA8YV60N7drwbmHvcSCBpfV6Cw1XjUcR6jHXvMgennT++tAcKTl2NBOFlaiYhIf0HTsPS12DtEgVff3dLfRyY3a3ZNq5Kr0oLvz8HEz7Dm6WcAO9eZyFWLfyVP/tAK6eI+HyV6luA7y8/xqgk6Skrx4rGt9zwQJ4QpkSnkouh+S+LMoMSaA7VEQwwifSYbJF62GY/wTcmk2CrbaZF7uVRSd74Ij4Wt/fXeMjlAeSoBZoPMYs9WaJy9gO8RoV2pqHgGAz/e7xlnOG1uukwr0NGGwr3LVTLmiQ2FHd+xSpEUuKBwxFNfjp2Jj4HwnHKsKBk1rRo4Q31JNfarXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(83380400001)(47076005)(426003)(82740400003)(36860700001)(1076003)(41300700001)(26005)(186003)(336012)(7696005)(5660300002)(2616005)(40460700003)(70586007)(8936002)(6916009)(2906002)(4326008)(8676002)(86362001)(70206006)(40480700001)(356005)(316002)(478600001)(54906003)(81166007)(82310400005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:12:24.7952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c331d77f-61e0-4ce2-fe85-08db1eb1649b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337
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
Cc: guchun.chen@amd.com, feifei.xu@amd.com, Jun.Ma2@amd.com,
 Vitaly.Prosyak@amd.com, lyndonli <Lyndon.Li@amd.com>,
 Alexander.Deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Actually, the drm_dev_enter in psp_cmd_submit_buf
does not protect anything.
And it is not used to prevent concurrent access.
If DRM device is unplugged, it will always check the condition in WARN_ON.
We'd better not keep adding commands to the list.
Simply moving the drm_dev_enter/drm_dev_exit higher level
will not solve the issue.
Because psp_cmd_submit_buf is called in many places, such as
psp_hw_init-->psp_load_fw, psp_suspend-->psp_xgmi_terminate,
amdgpu_device_gpu_recover-->amdgpu_ras_suspend.
So drop drm_dev_enter/drm_dev_exit in psp_cmd_submit_buf.

When removing amdgpu, the calling order as follows:
amdgpu_pci_remove
	drm_dev_unplug
	amdgpu_driver_unload_kms
		amdgpu_device_fini_hw
			amdgpu_device_ip_fini_early
				psp_hw_fini
					psp_ras_terminate
						psp_ta_unloadye
							psp_cmd_submit_buf

[ 4507.740388] Call Trace:
[ 4507.740389]  <TASK>
[ 4507.740391]  psp_ta_unload+0x44/0x70 [amdgpu]
[ 4507.740485]  psp_ras_terminate+0x4d/0x70 [amdgpu]
[ 4507.740575]  psp_hw_fini+0x28/0xa0 [amdgpu]
[ 4507.740662]  amdgpu_device_fini_hw+0x328/0x442 [amdgpu]
[ 4507.740791]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu]
[ 4507.740875]  amdgpu_pci_remove+0x5a/0x140 [amdgpu]
[ 4507.740962]  ? _raw_spin_unlock_irqrestore+0x27/0x43
[ 4507.740965]  ? __pm_runtime_resume+0x60/0x90
[ 4507.740968]  pci_device_remove+0x39/0xb0
[ 4507.740971]  device_remove+0x46/0x70
[ 4507.740972]  device_release_driver_internal+0xd1/0x160
[ 4507.740974]  driver_detach+0x4a/0x90
[ 4507.740975]  bus_remove_driver+0x6c/0xf0
[ 4507.740976]  driver_unregister+0x31/0x50
[ 4507.740977]  pci_unregister_driver+0x40/0x90
[ 4507.740978]  amdgpu_exit+0x15/0x120 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4c617faaa7c9..02f948adae72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -603,27 +603,14 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		   struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)
 {
 	int ret;
-	int index, idx;
+	int index;
 	int timeout = 20000;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
-	bool dev_entered;
 
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	dev_entered = drm_dev_enter(adev_to_drm(psp->adev), &idx);
-	/*
-	 * We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring
-	 * a lock in drm_dev_enter during driver unload because we must call
-	 * drm_dev_unplug as the beginning  of unload driver sequence . It is very
-	 * crucial that userspace can't access device instances anymore.
-	 */
-	if (!dev_entered)
-		WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
-			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA &&
-			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_INVOKE_CMD);
-
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
 	memcpy(psp->cmd_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
@@ -687,8 +674,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 exit:
-	if (dev_entered)
-		drm_dev_exit(idx);
 	return ret;
 }
 
-- 
2.34.1

