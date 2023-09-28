Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C795E7F156
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 20:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34BA10E69D;
	Thu, 28 Sep 2023 20:06:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D3D10E3E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 20:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH55j/SjdKCDFh1shcQnODh/rwZBcgO7Tpze1z3mjgpW8OmwjsQfZ6rgV7h1GtOBEycuM5FATn/DGpXXJfoMtMaMoKBWYWNqKuBYTpqmCq0sPADeG0y8cUSosEyckikwbbBW54eo1x96cpvMR/PE0DqCmCf2GxGQGvmR6xebGf6mkmmIP9gOqhAjHkY9B3/iIiPNs9T5OsiI3TbGgVEGNAqDxIzwMFXcMRrRTUdx14ex53I6ScXElan7d1quPg1om39qZpLuN158EOATszNrAsPhOPJfsAtLkODvw91hSlJ/0Gl7rC3MMOMuNd1AlggoykfsXMz0g7drOTOoW+krdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTe4QLxJmnC5v9ZrbzO2Cj8MpDROChlh0JpS0on+3Os=;
 b=MCO4Ej+H42jqcO5X1OxRewdz3ih7FOss2vMq6uOlXnfcfNAxqpIa1sSiYgdHWAlhJHwdHWFyMm8PwH67IFyuytFJbp5orJjfK2PBP7B1GNYK04yx88Aj6twKM8tAci1eSqQFoqbYXslgDQuxWIOyT235A3f6AzOgh3U7G5kL7CMnw6OpwsIM9m8xpDnnFRTEuePzkRgJ+S7bdMFC/NQFijRMlncItgbyrXR6eDA8XfNN/o0nsHdU3843iXBXZ3gbx9KinQ6pQLa26yMgk5Trvv4gjVNLbtxUj/wZvwI17pYnD+H8d9/OR+1Ki8KpyWufhjxQLvB5KN6jUeat88qOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTe4QLxJmnC5v9ZrbzO2Cj8MpDROChlh0JpS0on+3Os=;
 b=m6S/nPQe3x5ZxZlDoRValWgz0XTN+NPlDVBfQzCco7q020Oq8TOiB3tMH+bVOsGPegpeELUrc0xiXMjRKs92hKpfoxO52aGz6i4alAFnKJZZym18KBjJPcThR1yKagJacsaPLrVkJ9DFCUwyHDDca0+beRrp/H6l02yYpLMoSBc=
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Thu, 28 Sep
 2023 20:06:25 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::33) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Thu, 28 Sep 2023 20:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.25 via Frontend Transport; Thu, 28 Sep 2023 20:06:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 15:06:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: refine fault cache updates
Date: Thu, 28 Sep 2023 16:06:08 -0400
Message-ID: <20230928200608.2857534-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928200608.2857534-1-alexander.deucher@amd.com>
References: <20230928200608.2857534-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8c1f16-5c24-4d92-c28b-08dbc05e64e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2pF9CWNHv1JAkohdj6qiy/I+Os0VUVoagI536yYiOg10XHVFu+mtlEzbLr6PsHkVUOILpta+7L58UUYaV/nfRlAFA8OOFdm8q3bq5fOYgSubmV05Vn6TK0fICgyQDpAGpQ45j2xHt4uE9E9W3v/G7owLd8TS1l98MdGoyWZHoxTdNt0aqweCB3WoUZ5hsUBs0GYTKSPDQi8NZ4aiItU1S0Y/GHLlFH51i3tAzpHlMGvPlN5HGXqJAj/wQWIn+0Sobf9TgLs6o9ojzYEvyOKFzYSIUmXtTRPrsjuhApzm9l0VWBXWj1f00mPxmSLlSa2muLZVj9aXlgXEMbybfTu6Kb+0vp9m5dW3fJggo4Z3hQ6sNHEPnO563KXM4b3uk8IUv7RZ4at2B9BbDlR8X/HTp785b5E9qWJweMFuPt/QjneOD0YLvP8C/Cg604S6YtrXJfO1FsGvdY2E9mWbJjTlGRn3P0D5GSjXdz8zJZJ3HhLTDh/gU9dZTez0oB1UobfHqxCqLm8YV0vMZ6fmtSQk5Fj2SbCXW27r3D+x0B8RImQlf8F3/P1mNeFSi5NTp2TuAET4sDg/fN7kRfc1VihmmiHDgAyjZjzd/w1KZWr/PEX+BHrg/NyRWpviBH7TwoZE8kZqrsmY4UGp27wB446vAX3VQiNgAS29SFYNhL8RZb2b4zBemZwLy4Krwf6VPoPALyY5xpgi6gFltxOrrX5JSfRtMyr5EsArqcCcZKWOCFOE1iRomAeY1MtGZdhuyPE6+CsINjT2hdFWg88We3gVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(15650500001)(7696005)(2906002)(47076005)(478600001)(4326008)(16526019)(426003)(8676002)(70586007)(70206006)(336012)(5660300002)(8936002)(26005)(83380400001)(1076003)(2616005)(36860700001)(81166007)(41300700001)(6916009)(316002)(82740400003)(356005)(6666004)(86362001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 20:06:25.3470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8c1f16-5c24-4d92-c28b-08dbc05e64e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't update the fault cache if status is 0.  In the multiple
fault case, subsequent faults will return a 0 status which is
useless for userspace and replaces the useful fault status, so
only update if status is non-0.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4058ed49e5a6..afc19341334f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2753,7 +2753,12 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
 
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm) {
+	/* Don't update the fault cache if status is 0.  In the multiple
+	 * fault case, subsequent faults will return a 0 status which is
+	 * useless for userspace and replaces the useful fault status, so
+	 * only update if status is non-0.
+	 */
+	if (vm && status) {
 		vm->fault_info.addr = addr;
 		vm->fault_info.status = status;
 		if (AMDGPU_IS_GFXHUB(vmhub)) {
-- 
2.41.0

