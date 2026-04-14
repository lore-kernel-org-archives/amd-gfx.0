Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64829F9D0F2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97A010E057;
	Tue, 14 Apr 2026 19:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N74UGAfZ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A3F10E057
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXgxrjq9s8FFR1jk0VDQyglbW/aJMF9Wzwx0hPWjOP2tEZS0meLpr7N3jG0AEBe8cE0o3BSsUW4jfUP6MoQRYmn8qChcde9tkkpkyC+zCM/uWBmVLctBBueGX45FkhFfFMuChydoc37rg4S6Q8Z9ZErGS2mGjCWF+2K+fSylKEdYrhe1b1eSLAU5qbVVa6HwlJlPxACg/Ter3bHwidreL/o/XBdl3U09XK6SNxirCg9T3/uciaRoN5BJPmU1i9XCUXbmb+heX1tH8LGgHMyvUs3Q2qS/Yhd1gUB2z6wxDlM6oYSA89G3wvSWAgmqtYJ/gJpASnDqDhMigIjlGLjpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26cODj1XkS7fsrI4Up4BTXCaXF1VoTvHxgin2tkHW28=;
 b=asFxJ+TGLpq0teHo37oHpqKnsmXgyFZrTmrDuBTsCNat5Wv4n2oItqSX1IS//0VrdUeLwiuGwBdEKqO5AVnumC6O4VCijsfc7GrxWoUusqBbPLOhvv49830HVfbN9b1GXke0OYvatDlyQ2zJuVgfAjSZjCoF/0N2PWZQ42zSKMf82A/ZsLKS/JLup9Q8nQkHzPLkQ7NjHdUGEQr3C9H2srjDfVn71+mgAYXSn54cwl6kZTaCh4jBxfr8lPLJ/DYddLyB0my3rTCVJMXt05hWW0AdSNMxkCH5H1xx9bLH1XEbtYQfMIvEzhHt1vA8v9yguFYanrbnwBiKlclzkhTdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26cODj1XkS7fsrI4Up4BTXCaXF1VoTvHxgin2tkHW28=;
 b=N74UGAfZm0tU/86kiTfmbqBQFzui8APuVcVEVnOY8o1pvsCHJDuKc+TJcBZLUS36Hpwxhfy18figTclu695CPZ9nRf77T4f40ADtmzvsoBF46XqfXbaccXRC17zzS+oT1lg6CNpUSzXYAOakQKLeDVmE1j7/uZZeokrZCEqCPiQ=
Received: from DS7P220CA0060.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::25) by
 CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 19:44:45 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::ea) by DS7P220CA0060.outlook.office365.com
 (2603:10b6:8:224::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Tue,
 14 Apr 2026 19:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:44:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 14:44:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 12:44:28 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:44:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12_1: Increase reserved memory size to 150M
Date: Tue, 14 Apr 2026 15:44:13 -0400
Message-ID: <20260414194413.2213280-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ba8e1e-4861-4755-72aa-08de9a5e473e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xnDQJIb7H1D9bm4t21z7o0736ZQ9EPZv3E6p/RtxGtzV1RH4aGEnj6MlSTsH8b89EBVx14Vq8Yji1jOAFr6JUSn1TmVRipsOg66KhaVxAEoDKUwrvRbNSd3hFM2dG1s0aIBMXW99Qw0Zv7LKdA//efVIlT3aM5ztuM8QTXsxnWQRhfaputNnBRruUVdPfowTdHVaWn4JBkHT/OPQYAiNkWxRGG381uPyH7Eqz2kBXWY9Y07SmNZxpQoBzXfLELqcJG27Cue3yjA0F6GmG5mE7QrZgUn1VrXdczUt/ybQ0rZkKVrSoHw4UiP2hj6S4DeHcuxkbREXj26pMIckdaomnheT/y9DNwHWDMJTw/BxoherjZNzKtHj4hQVRcA4+L3Ovlz4upZ4VRh3ZmB101YVZX8omwHYYXHWkCPpX+cTDj5M5SiF2Ug+7x+YWocROQSCmB1SSagZZvCPavXRmQp2dUrMSNL0vhQp4xQDjhQX+LZqD0Sb4Zb8oENltRhLh6WZanPYn42CpM5fv3KYLK69eSZ+OBVoTQNX5ieau4qMHIiVMDjWWTXpZYJ3ytZtBrGASjveVFkDOJNVf7xm6dQxWp5fp4LAx4mTAoQ8a33eVDq67JbRc5bF/5A6RkWkhfiDCWauQmjvnNh/M8OUvBzaKRMd/Oc2Y28D3isiUvBbZwsMXFYDJgAZojDUNnbFcGfmMshd901T/j8t5fVCQfzdvKksbo9AAqhZRoxKkNbSxOqv3HDBMmKg+hnYKdihreDrsVcvMLK1Di6UYi3HCp4V0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8ANLTZsb2HwPQCFpPUC3w8G+mJWTovc4WcdOooWqULuXEqjulOW9sgI7/8LKCxtQH7mpJL8XCfD2atFrGWKUQ6Z/WjHZHmzQaVkrj1H1XhJiQANRH9FFKKAwHH3WaKSn/rSE7CIY8nnHMySrm1j7yNwwAgb/pQIH/n8HOA1o05MPeZwehlnZcR5zDfJwspv7xIlcdsti6kUXswIx0E1MPqFS3secrdxbdKkI1/NS2jxMFSGo2kKk5kebaqP3UjE/eq9mTj46TISd8iNxYD1ikkhnS3h5FnlkZxsebdMQuWtDr98SzxxVtAcA7EWvRDts99VmFEX/SH1TxiCms1RCyLmA0NBRuVv6pZuwXqXENGeAov0s1rnxpoBIdHSPsYlIXRG5ddeL5+J0D2v55a2nwz9I8H93OziBwVpiFvIctTcvRk8iIdcFLH7ph1VRireG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:44:44.5332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba8e1e-4861-4755-72aa-08de9a5e473e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

From: Alex Sierra <alex.sierra@amd.com>

Increase reserved memory to 150 MB.

v2: squash in fixes (Alex)

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b80fbb11004f9..3e1bc34a5bbc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1712,10 +1712,7 @@ static void amdgpu_ttm_init_fw_resv_region(struct amdgpu_device *adev)
 		reserve_size = max(reserve_size, (uint32_t)280 << 20);
 	else if (!adev->bios &&
 		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		if (hweight32(adev->aid_mask) == 1)
-			reserve_size = max(reserve_size, (uint32_t)128 << 20);
-		else
-			reserve_size = max(reserve_size, (uint32_t)144 << 20);
+		reserve_size = max(reserve_size, (uint32_t)150 << 20);
 	} else if (!reserve_size)
 		reserve_size = DISCOVERY_TMR_OFFSET;
 
-- 
2.53.0

