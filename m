Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB1C6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 11:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853E410E9A6;
	Wed, 15 Mar 2023 11:05:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C00610E9A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 11:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6LTLNFg67Frme53BVPO1R5pmpRpu75a9W265k/yuIvoxhw9WTzWz0SZ1aYounVLpsK+xWcM+MmpRofyH3Cc2Z0Odkavo51ZfkN+lvEdNw8sz+6G1QU6MFh3HMRVZg7eVPDfg6zlcCiDyGnHAV3TFXe9EpesA3RaByL/KgDaJyBz8P5Q+gHy9l8+b8g4+0ZvNEIq9/+uLU8mp+Y5SjtgoQlY/mYdFw6uTDnciXrS+FAJgKCYYj4fUqzoZe0yfE4VDOvVIsCeUmyclasPdNVJFuoLa0F4nxUHqwlv7rai3hD16RMicWOSeQ9rb/3pphkms3avUTmcKZc58Y4q4BfP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZsPIy1aB5aX08Ka/h7j1zqksUUlD5Moa7I3+o1Psmo=;
 b=D6QWxHe/HaemTazc4sIy4Kydq/SejPwgJjWeg8nGsrzYZB5biMaukUcjYGmDXVUitg1pedA2IOlDYpbh1rrtAi7xndGbgyQH2c3Z4UT6rpyWnqnwL4Fgc8sL7ysC5SsxVOAK44FKZQTKHxnQlFMJv2U9y6xC7EsS0eAJCnWVjy3IWQiqJbwKf45ABnHzTwcAfqnF+EqQk6Mqz1i3WzoADAHEgC1YlZ4pqsmvDcCZRge7cG59eXnmwueK2jLEs9KYHExGNp/ajm+Ja1tF3C20dM/RZe+Zlvoi1OoLeflb1fVCsMloOrmZouvPHyrJi92Aw0uEBNGVQPFPUhhN1BprTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZsPIy1aB5aX08Ka/h7j1zqksUUlD5Moa7I3+o1Psmo=;
 b=lsD8jTGDHIaJfFDxbFPp9UZN0Twu06iKkV5eIvUVvbY83vBeWHA3/Z1tTfJta4GaGsM09LEwMJeawwrY+xDVPI5EmFiXFKOdXKkqLWGODMFoOGAs2LdyioZf2G/5hsbKimdqKzQRqwyfbZODWlpEIF3DN8XA0sYHIqCqaxAaGEg=
Received: from MW4PR03CA0001.namprd03.prod.outlook.com (2603:10b6:303:8f::6)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 11:05:13 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::2e) by MW4PR03CA0001.outlook.office365.com
 (2603:10b6:303:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Wed, 15 Mar 2023 11:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.16 via Frontend Transport; Wed, 15 Mar 2023 11:05:13 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Mar
 2023 06:05:06 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: skip ASIC reset for APUs when go to S4
Date: Wed, 15 Mar 2023 19:03:41 +0800
Message-ID: <20230315110341.248166-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315110341.248166-1-tim.huang@amd.com>
References: <20230315110341.248166-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 725933c9-c0f5-4e9e-d44e-08db254526ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQRffCeOQDoBKN8LgEvxqViwikZpgL8c5G0ev91GrrzOfduytL8bKpMWIfXx42FAmQ+id8kVGC1oNwVJymwtZ0diiUa1TIHN4jZsvn6lWnr8nVikFIOiVNJbaeYKWzh/UjXFL74upltBKl4RLNlgln4gDRaySc6LCEoY1HHLXtiAXAJeu1eh+uPMMmSjagw+3EamfmMoFUQdD/G1PKQLTPAtd9db4hFRp6+G5j4Y1/wujhOFc/HpH1OlJxr1zpJmrLZaeCQahxJhpPpLZBoEZYNqC7mpHdLMIXrulRvmm9LA1upIvdNNIn8v0DrYG7FJ70d4EEJQVYA1q88P3IwVnOMxQp6beIqlPMyWpthdfDhM9egzIL9YRrmKESbwtwkiwIWX+2xMqQdLkuR/0atnz97QRlzflYHekMkkzigWCLD5C7IG7a5O6gMVs1NngWEaZpBxe2CHiljL+7q1o2qnCjJcpsy8HUb/bD9UGbowcEN4cEtuVApTEPpISmTsEB+N48Ky4OyfsDDPo3gU3rXe6Aoh2bPwLq73UO/8qJNn/9hocRHBgFzbtIAjyaxB3DyEKYTficOO0c/LUclkHIdTuKT0RMxZ40LYW+N/ITQujzai1vRCDAsUPizKEaAZV5bKkHd9uV3kawEtJmfyJ31fA0LDmeIFU2+CslsWbWDaWRKPOAiUw8Mjj0hbUs+dLls0ImFkMnxdoVRQ6r/2uF+Eto55pbHuwsbuut2rS2dn8jU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(356005)(82740400003)(36860700001)(81166007)(36756003)(8936002)(41300700001)(2906002)(5660300002)(44832011)(4326008)(40460700003)(82310400005)(40480700001)(26005)(83380400001)(6916009)(316002)(186003)(16526019)(1076003)(2616005)(47076005)(426003)(336012)(54906003)(6666004)(70586007)(70206006)(478600001)(7696005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 11:05:13.4244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725933c9-c0f5-4e9e-d44e-08db254526ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, mario.limonciello@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GC IP v11.0.4/11, PSP TMR need to be reserved
for ASIC mode2 reset. But for S4, when psp suspend,
it will destroy the TMR that fails the ASIC reset.

[  96.006101] amdgpu 0000:62:00.0: amdgpu: MODE2 reset
[  100.409717] amdgpu 0000:62:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x00000011 SMN_C2PMSG_82:0x00000002
[  100.411593] amdgpu 0000:62:00.0: amdgpu: Mode2 reset failed!
[  100.412470] amdgpu 0000:62:00.0: PM: pci_pm_freeze(): amdgpu_pmops_freeze+0x0/0x50 [amdgpu] returns -62
[  100.414020] amdgpu 0000:62:00.0: PM: dpm_run_callback(): pci_pm_freeze+0x0/0xd0 returns -62
[  100.415311] amdgpu 0000:62:00.0: PM: pci_pm_freeze+0x0/0xd0 returned -62 after 4623202 usecs
[  100.416608] amdgpu 0000:62:00.0: PM: failed to freeze async: error -62

We can skip the reset on APUs, assuming we can resume them
properly. Verified on some GFX11, GFX10 and old GFX9 APUs.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5f02c530e2cc..64214996278b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2467,7 +2467,10 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	adev->in_s4 = false;
 	if (r)
 		return r;
-	return amdgpu_asic_reset(adev);
+
+	if (amdgpu_acpi_should_gpu_reset(adev))
+		return amdgpu_asic_reset(adev);
+	return 0;
 }
 
 static int amdgpu_pmops_thaw(struct device *dev)
-- 
2.25.1

