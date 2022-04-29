Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D19C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 20:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17D410F9DA;
	Fri, 29 Apr 2022 20:16:51 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F2210F9DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 20:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjZpMg90YvW7t5+CP1pEi0BDVpYTFocDKAnttDVQV/czjLttYqW/P1ZUCNtAj6+Qbk+TjaSY/sdq4yIldccUeCUCIEGnOJDvjyAwGCcF8fsbW/nWWDZYx2hdU7Vt/ZsgtBX0+mx60UCfKK+dSfDXc992WBXBZGjbVY4U0Xer6vfYDxElFQT5O+vHBNnTxbnG7/gT1mEvpe6Z31kSw0zy2B2N3IqJYWo5Xb+7wBtthQAxWexLTNeVwnm+OdxZSmI85okhtZaJHoeSMt388T/jqXEw4weWmyqYTO/yrX+YgEBO9T9cDwev6dtSd5Q8fj43EeJDhO8xse6W3TPNY73u+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5+11p/O+7wdC+lgrOj+yQqdjnTmqvX3jAB/DC/he8Y=;
 b=IewINkhnsUSNm2S/bZzVO9OnnYOWwB9cPm+SSN6AC6l8XGTNE9ULyW9TQo6HcGf3q3WD6r5HLyo8Q3aXID4nTMZMf5dfKChsLk3sZcHXDS7VrKYfZWdO1co9pE25bj8RqVQs38bNUN4epUIsDs7hO9jF2zMYBWaRKPb8Fmu3u/UHXyMRbPNFGY8G7rEIpGZAk8WyTAOy2XV3Ifg9Q3v94PbyFZjKFlxbpnfzGJDdWstl2H9/GSLYsxeozkwqudKOtU36JN11IIy86hGlfaKYMEf1C8EwDq/wmN3ROMQep0OLCGLnLlNEW3/mpYzDo6D8OedVhcdevFEvQ5tETwJwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5+11p/O+7wdC+lgrOj+yQqdjnTmqvX3jAB/DC/he8Y=;
 b=zg/tDPlpKLQmKazp4JwbyBl3X83GEsVKZZEnTgBeyru0F1YZfkJ5d+xH80L1KMKjU7qUWDF/d+0VVTOVv8jCsGgMmDIVPL43zh7m/66CFw35m9YbNPwvraZ8z7PnwP6P/Kfwbmdq2u2OICl3DedYf7D3ErmYlkYsJLC6lnGtG2Q=
Received: from BN9PR03CA0205.namprd03.prod.outlook.com (2603:10b6:408:f9::30)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 20:16:49 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::c) by BN9PR03CA0205.outlook.office365.com
 (2603:10b6:408:f9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 20:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 20:16:49 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:16:48 -0500
From: Alice Wong <shiwei.wong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/ucode: Remove firmware load type check in
 amdgpu_ucode_free_bo
Date: Fri, 29 Apr 2022 16:15:46 -0400
Message-ID: <20220429201546.129362-1-shiwei.wong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd9c6c9f-3eac-46fc-045a-08da2a1d3126
X-MS-TrafficTypeDiagnostic: CH2PR12MB4327:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB43279BB896B3703CB45CA6D3EBFC9@CH2PR12MB4327.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VOgMwQHhnMJ0Cx/J313HZjvwFD1EblJCdClml4b2mifEbtVDgz/Qa9pP/u81W42dL7YBFVAsenly93kGxbbH7t69J5HUjy8nBvYvC+vDWAzsuvGi1VI2Sc6cNWlrPagUTz5jNNKr3PGXt+obEPoVdXV5MB/c/jFoKW8McgVjz79NFc/aPeDQU4eq5YRRJ46w99I330XA1FH/aqMbVkBQxTDZLtKd1yMRnzGvBLcga45UosE3Sbh44QAGWs+BHBQAGk3yODnY5g8yrbJsTiATCaUR+0+zMvebKJkkTAgV3FQ8+DrNxghltqaRq7dJ5u95qtc7Hx8fW27XREdS/F0oLFmzm5IqAOVM2zxbakvoKeHVVKujTMS105Znv7nzKjg1lQrnhJuSgJe/QBES2GXSPXnT5kQQI2wVhh+8o6ThO5rsdRs05KhiuTtjI9B7eMe/Cfkn1kX3Bn9Xu7QgNVIgVp0FpPTjWrsl0iehhnmWiMdRj5Cm8cjIuV+43QmhRDOEEUHHCJlU/YYgi1FZy9Whjq4IdW/6mvpZ14Q3vV+lq5E6lq96QR3zpXbm9D8wWeP6Nseo/sirWGdQpUkAdIj+kDEnwanF3X1DngQw/3E7ql/G9AwSugpKCkE2JjClHMoo85Ogv2APiGme+ppdtkHGHXVSVQ6ccxkTZNXhULOeCvBASxfcAhTc6raRQdNOTUHTL8aIu/OJ1qanOfttggOkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(5660300002)(8936002)(508600001)(82310400005)(8676002)(36860700001)(70586007)(70206006)(4326008)(356005)(316002)(81166007)(2616005)(2906002)(26005)(1076003)(7696005)(186003)(16526019)(83380400001)(47076005)(336012)(40460700003)(86362001)(426003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 20:16:49.2714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9c6c9f-3eac-46fc-045a-08da2a1d3126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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
Cc: Alice Wong <shiwei.wong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When psp_hw_init failed, it will set the load_type to AMDGPU_FW_LOAD_DIRECT.
During amdgpu_device_ip_fini, amdgpu_ucode_free_bo checks that load_type is
AMDGPU_FW_LOAD_DIRECT and skips deallocating fw_buf causing memory leak.
Remove load_type check in amdgpu_ucode_free_bo.

Signed-off-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index ca3350502618..aebafbc327fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -714,8 +714,7 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 
 void amdgpu_ucode_free_bo(struct amdgpu_device *adev)
 {
-	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT)
-		amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
+	amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
 		&adev->firmware.fw_buf_mc,
 		&adev->firmware.fw_buf_ptr);
 }
-- 
2.25.1

