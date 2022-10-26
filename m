Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B23C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 19:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5639010E746;
	Wed, 26 Oct 2022 19:03:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA84310E745
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 19:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ8HDn0n+KeB+2YhE8TES+3GJvwGrDrSk7ELs/bgvZOJZiOop/chhypsZrDqmd0c+6VmtRsU/3ZkcAXPoeAU4IPkHwKur16m2k3spz2qV/le8GqFCsBiXavgFX41KrE2UpcjpLtdFGR/gKVApVP+8gPWRiAgv9Z+tfAjkO9pdHP1xipC23Iyhx90Af2zpnM235/yYphs9VYFDPqe3NuP2V3pCtPUswweALSxuLer/9Twby2p54EtjBpNqkPJXD1PTf3j32Jp0b1ee27/ZojoFvlnbsBfqyPPwci3Sq9NkBDYehnnoP8bYqsZesEpEpW1xNRQ9vM/wUCOh89+cSphZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtdN1ZFyu9iTWuEoxFqOmBISMCObgzeQYAX52C6axIg=;
 b=bMI2NgeFQaFsdQ+GaPNEP9Z0eFMszbMXwbz4XnbVfNTsRYDwBaKr4B4bb4+eGxPcTeJw9A8uITOg/jtCjMiRdru5tsNnthtvBgRaAsHfHAfoKEVUrprsfzUWWgX5FrElh58BgADW0mvGkqWZ9R2a5F49/9+iYN1ZCf/pE9AOAvnqVsRKDoGeaRgMrhSysZEvcStAeY+CY70Tq/65+FZOeBs4SkiyZpPnBCURneZZxEHkP2UgKQV9AOJYtm2AN+KRyBxaoV502vB5C7eeFyypvdkM4w2Po1PoR1/HGo1lvOY3wNxZRzwr7Tk3Kh27bE1cwTpzFrePBoMjUOoGjGfHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtdN1ZFyu9iTWuEoxFqOmBISMCObgzeQYAX52C6axIg=;
 b=Bx+BFZXMn42tmzIdyNNnwWwc4TSGmZT6i45QUBavMIY5oZ1Nw4XdSaExvoFGWuAy+p/iDO4wVstHICdxikZCKA0x/LnnhKxrG7RefJUhWqVYbv3A9H+KnFfuvB7aQuxiQVc2NTUZp4p5YzTs9m7BZLYupgrNPyJiVuiKVOQp6Oo=
Received: from DS7PR05CA0013.namprd05.prod.outlook.com (2603:10b6:5:3b9::18)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 19:03:47 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::d5) by DS7PR05CA0013.outlook.office365.com
 (2603:10b6:5:3b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.8 via Frontend
 Transport; Wed, 26 Oct 2022 19:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 19:03:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 14:03:45 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fail the suspend if resources can't be evicted
Date: Wed, 26 Oct 2022 14:03:55 -0500
Message-ID: <20221026190355.18166-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ad3699-cace-4d2a-d300-08dab784cf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/GJwB9VsU8qaqoyvc5tNUX3WHwa9ZTD5hMzhd4+OQONPmKRGr1w0k1AAher5++HlZWk1zRFXCz0KZUslAVRgBRVNSoqz75SEFxqH4hyrBABXlUGxm3TRgxSTWN3ifHlGRZgonkMgfrIATFb4/3PM2N119JjoQEQ4aePBu8dJrvti7ukw52PbbvssCqhm+TiookcmXuxsKjW5NbQqWdGD6OkiBzjRkP5rsIfXKSJrg0AyS/XAlfX4a0WeGDFX9nD8b4mFdxxLRmeZdlwuHdW8Ho9KWx2/4Qge3gvVx1HFi2PSSMZOqO10usP/z8zuL5JbGrgGPHQbBosccJ9JG/9BdlGmIHWrMvjtTe2qXFE4cHXCDkcABCWVKRol39c3hoL0py5Iye6BCljo3goIatOxKvjHEhO8mr/mffVJr6xjUFKnNF+yv8OtG9Rw4JsvagC4NVWiHcGM7GAvWUAVAe6AaCMjobqRH37Qc9/c8fUkrioRbDjlDlFzaiDpS0Jq7r2cLKa9LDE7CxuffzCHyFI7JyhLmNpk/b4tRbpTyFXh2hipHdrVzalRsVttFyFGaEU5+vjnI6XcAbOHLMOwG12KxwJQmt5avJQFlfCFzN9aTktRkiBYeKi+uVTXItMsT9BMQEvGVGzZYQ4Ys1ZPKf0CbBbuXRtbj/XYbcGHYudm3AlWqNFlx8UkT4oc1iwyP/IvAkJ77qWZi1z4HWxAll0PxsxIB9ykoRXKta5MQZh9ywoZ7BHF5LXhPZp54CLSLw2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(426003)(47076005)(83380400001)(81166007)(356005)(86362001)(36860700001)(70586007)(8936002)(82740400003)(336012)(70206006)(5660300002)(7696005)(44832011)(4326008)(15650500001)(54906003)(6666004)(36756003)(26005)(2616005)(40460700003)(1076003)(82310400005)(40480700001)(6916009)(478600001)(2906002)(966005)(186003)(316002)(8676002)(41300700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:03:47.1390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ad3699-cace-4d2a-d300-08dab784cf93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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
Cc: post@davidak.de, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a system does not have swap and memory is under 100% usage,
amdgpu will fail to evict resources.  Currently the suspend
carries on proceeding to reset the GPU:

```
[drm] evicting device resources failed
[drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <vcn_v3_0> failed -12
[drm] free PSP TMR buffer
[TTM] Failed allocating page table
[drm] evicting device resources failed
amdgpu 0000:03:00.0: amdgpu: MODE1 reset
amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
amdgpu 0000:03:00.0: amdgpu: GPU smu mode1 reset
```

At this point if the suspend actually succeeded I think that amdgpu
would have recovered because the GPU would have power cut off and
restored.  However the kernel fails to continue the suspend from the
memory pressure and amdgpu fails to run the "resume" from the aborted
suspend.

```
ACPI: PM: Preparing to enter system sleep state S3
SLUB: Unable to allocate memory on node -1, gfp=0xdc0(GFP_KERNEL|__GFP_ZERO)
  cache: Acpi-State, object size: 80, buffer size: 80, default order: 0, min order: 0
  node 0: slabs: 22, objs: 1122, free: 0
ACPI Error: AE_NO_MEMORY, Could not update object reference count (20210730/utdelete-651)

[drm:psp_hw_start [amdgpu]] *ERROR* PSP load kdb failed!
[drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
[drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* resume of IP block <psp> failed -62
amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
PM: dpm_run_callback(): pci_pm_resume+0x0/0x100 returns -62
amdgpu 0000:03:00.0: PM: failed to resume async: error -62
```

To avoid this series of unfortunate events, fail amdgpu's suspend
when the memory eviction fails.  This will let the system gracefully
recover and the user can try suspend again when the memory pressure
is relieved.

Reported-by: post@davidak.de
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2223
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6f958603c8cc2..ae10acede495e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4060,15 +4060,18 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
  * at suspend time.
  *
  */
-static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
+static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 {
+	int ret;
+
 	/* No need to evict vram on APUs for suspend to ram or s2idle */
 	if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
-		return;
+		return 0;
 
-	if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
+	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
+	if (ret)
 		DRM_WARN("evicting device resources failed\n");
-
+	return ret;
 }
 
 /*
@@ -4118,7 +4121,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (!adev->in_s0ix)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
-	amdgpu_device_evict_resources(adev);
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
 
 	amdgpu_fence_driver_hw_fini(adev);
 
-- 
2.25.1

