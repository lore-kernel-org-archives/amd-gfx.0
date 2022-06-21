Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57302C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 02:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9023112241;
	Tue, 21 Jun 2022 02:26:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB4E11233D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 02:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnuz1rE3xI9jUgqJyRE0Eoq45eTkwZTWdm5O/pMot+OB2nz18bUW222c2tCHuefKVyEXU1jaY8I2Vsya/TFMnWH465R8VBClnMj681JI04sx95KDWX3GQmKUF2QogboSz9hqzt7qCE+04hyJBIF9Q8uismA33o6kxgSOR9dNXh7Pl5OL+g9w8XVvzx78v2N/aBZm41T+npWoE1PjlIHZLD4K/MMClGQV4KNpW/xAkG98RkDbbJLwawwGC3+wKQm6dmPHX7Nw6t+mDDPZ9WuR0VC/3rbcXVaZksFVmCfaJkDw21I7L5Dnq27z9MZzsgb2SO6f8uIco0RQBmypyrU6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBi6kMreAjiWoJgSpoXTFNqWhoXBnOTD9dQQXtcG4Y8=;
 b=C5ZZ+utCgAWfmzM+W8Mu5+ZQDrZeFh2BGbHsRwXLArNrmMmaXBNr54cccEAD5VA2hCc1XV69FyHzTgf4eEe8HH2qVGmvRvFdQD79M7KhHyIboYGaeWCaQWlp6HQ6u0ET72B8IKc7RNTdpYhIiOdROv7NIDR8D3s109CgaJZKexWbzfRNaEdWXsJ1SffiexnXMv4FLLHQhvX+EUnSpy/pOKdBlwBTS2Ded0IOGTxMgwfoq+vts57lF6uubzUOjQCgGKnSC94ukNZpJhcIpVDwG7doipSi0jYux7+iTnlUvQ7hYfoyljqmboKyGe0zNk0cs/xhh3+6NGbwyjZiKRyyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBi6kMreAjiWoJgSpoXTFNqWhoXBnOTD9dQQXtcG4Y8=;
 b=3YV3ItOWD8sgGrgNOwutNcFnCzuVJz7GEFlHYxjCwnQjtRGzJ1d+F2ZBE0Idp+wScZpCIsJrdiU9b8itcdOvAmFXGLro0PDqQ0o1HPk/oxq3hMIuiNqBMS77/gTARIYTSPhhx64Xh5da6UUNq4tJj0npUg4O6ejq5qxfpDp1LF4=
Received: from MWHPR01CA0030.prod.exchangelabs.com (2603:10b6:300:101::16) by
 CY4PR12MB1863.namprd12.prod.outlook.com (2603:10b6:903:120::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 02:26:39 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::ec) by MWHPR01CA0030.outlook.office365.com
 (2603:10b6:300:101::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Tue, 21 Jun 2022 02:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 02:26:38 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 21:26:33 -0500
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: To flush tlb for MMHUB of GFX9 series
Date: Tue, 21 Jun 2022 10:25:50 +0800
Message-ID: <20220621022550.492588-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cc082b9-0504-4d53-6a04-08da532d787c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1863:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1863400225B2922874C96E2F9BB39@CY4PR12MB1863.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJJdXa6az5QUDp2+bgn1Jbw9deA6lo3UZLjFreisWKEnX4r5x64RlnRAFhZqW65938rFAXKKEW4FxbBtHYTWnovNIkuCcoK8ntSpWGLITm3t5R0LSZIPZ5aIF6bwc72Wsc+XBBTO0FFfqNdK2vsW3iYlrDEJUGU0XQNU22KqV1KDs0aKa46nJ05Jv5CMWvN4F+q/g92y3MYc4SYLUskwBhebeOAqyPhBCa9pL9dNwyg7Gw3L1kV6azDKxOsVe0AUuUsesX0mysQRDQ5ZCHzOweaZsqBdHVm0vkXLfle9XeLJrM9dDj9/RKsH59PbsecICsJw0zya9YWdLdSFtGjZtSA3g5Ryq/EVxi0qZ+wgOmQM5asdmaHP8JGiSqXUWlitVp+JAKtp48hgUDm0TQVOYgXkS/bTyjWcTM8PSWIz/AxIO26+0qqmUXMjxay47557GU5mFS0bh0utF3aeWWFHMc32esfY/115/7klNF1c+h92ebx5AZpRvu09BArEI/CwONPNwOloXVWDY8PQlVZBk0khVpxZYvAoKYie10tV+ZqU9VcXYbNZU70zczM2nMwVdh/gWVi7yhcW/e4vcOlzbfyIBW6MI3dUCULL9eHYyIFIALfjfHkk1DEk1nb8q7gBqjHzG+tL1kr81zz72IbjFEYS7qZW9cRdt4dZPTqRPEttHaBZEqA7Q1lk3lsGUbMuJZX1Uhk2JuVVbIEQQts3kyzsHWUYCy5io0qw+FqchDB+ALZt03CZAu+MDmlvPr9r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(40470700004)(46966006)(36840700001)(2906002)(40480700001)(8676002)(82310400005)(47076005)(4326008)(40460700003)(5660300002)(8936002)(83380400001)(36860700001)(478600001)(86362001)(16526019)(36756003)(81166007)(356005)(82740400003)(70206006)(70586007)(6916009)(54906003)(316002)(1076003)(186003)(2616005)(7696005)(26005)(6666004)(426003)(336012)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 02:26:38.4524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc082b9-0504-4d53-6a04-08da532d787c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1863
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
Cc: alex.sierra@amd.com, felix.kuehling@amd.com, Ruili Ji <ruiliji2@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

amdgpu: [mmhub0] no-retry page fault (src_id:0 ring:40 vmid:8 pasid:32769, for process test_basic pid 3305 thread test_basic pid 3305)
amdgpu: in page starting at address 0x00007ff990003000 from IH client 0x12 (VMC)
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00840051
amdgpu: Faulty UTCL2 client ID: MP1 (0x0)
amdgpu: MORE_FAULTS: 0x1
amdgpu: WALKER_ERROR: 0x0
amdgpu: PERMISSION_FAULTS: 0x5
amdgpu: MAPPING_ERROR: 0x0
amdgpu: RW: 0x1

When memory is allocated by kfd, no one triggers the tlb flush for MMHUB0.
There is page fault from MMHUB0.

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Change-Id: I97786f02849dd047703d6e8feff53916b307715c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d0c9762ebfb..12fc822c0a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -739,7 +739,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 {
 	bool all_hub = false;
 
-	if (adev->family == AMDGPU_FAMILY_AI)
+	if (adev->family == AMDGPU_FAMILY_AI
+		|| adev->family == AMDGPU_FAMILY_RV)
 		all_hub = true;
 
 	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
-- 
2.25.1

