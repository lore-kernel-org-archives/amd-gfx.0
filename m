Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493E4EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 11:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C3910E562;
	Fri,  7 Jul 2023 11:33:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A4B10E562
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 11:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjG1GTlFkRXwtLLFuUQV9h4B1q8k/ovCleHYrHS7VM4o4jgSqxXfymFSfZmDLT+iYxE/GKk5C2UbGcgPXi9GinfApCtwi+tE4ec7UzN2Tx82k7ofb6N/Mau38AI1EezQ22IGurJD6J6mwhjXhmYoVlh0d6MrHOtHXG6ma9wtFauiqoKfTch2HvmUeUrTaM7mnPz2G6szajS4uSIc+TpJqYD/sLw2yiEAi+uSin61nJcJQVwTSs+LHY8OoJ3pLmeUR48+ZW+hYfnDplFaDyn/nDUueBN5fA0WZVQWj8+jftpjW9iOGPlGnApMezUqcnfSLkPZIKHWn5trO16SNhyqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVCB7Nqi4SrjTbjvEj1mJAx84UspXemb+Y4ToWk0Dyk=;
 b=PveeeI5jDyXoK7UdPvTTfLOJVIBGWjicMDHe5ezD74lgOZrqcZft0Be9bO/8TWBjakWkDaxBSKQmCjwxaGUi/k4zWYa7Bz4GPLK1AsHx1jw1hwCuLimHqTfWDtWIHX6PIN7u/vk05ELBaoCu8FAlOobtpo2i9ZG55uqh82LrEpamH/rMfV16gTc9nnH1Ey5KJIJ153WlcK7E87GsY8fjO5QShGvJC+l0bB4IjgRWH7TOhRSuuI7rNRrx+caJ4aX/cWVVzMRaaFLXUr1o+7OtId0K2TGQS0mpfFLhRTOTwvHnfUUW6vcf+R0GKLqh30BjXbsJnqlD5xEalDX29ZP3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVCB7Nqi4SrjTbjvEj1mJAx84UspXemb+Y4ToWk0Dyk=;
 b=OgnrUxYfqmgfFh+6opN6mB4/toD743XdM3Xru0Pbryj3Z5hOCR7y71FbZ4AzRuoo1cShzml8GBEOJc5RTe0jdQ2nOQbwVOyPMDV43MVuf26dc1XATL8co3HnlEu7ELqoSjFj3q8YhZPtGboM3n2mgSUJOKpeBR29+jYfXKxNuUM=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 11:32:50 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39e:cafe::3) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 11:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 11:32:49 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 06:32:47 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct the UCODE ID used for VCN 4.0.3 SRAM
 update
Date: Fri, 7 Jul 2023 19:31:44 +0800
Message-ID: <20230707113144.536043-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef67b5e-c70d-411d-6753-08db7edde493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: On42ZQma1LhR0IayrU/91WjkHmjxNORtzPoOzzeZuvPj57CmEmqAXJk3EwIxmtofxwbkxE2n281hGTLY/WHTsTyoPyxCXbExU8atmA1hY6UaJbGAattVpt1ikCNB7/yQKUMrF+/aTMbSnhMut/d8nzgL8uuYp6kQIOaWnceDz7nhIiLF4W14OgyxW8M32Hx2+Bz+YLXvwI8JZ2vhzytB6LmBeKwEiI8yD+bKXQoiRVJdBeREooTuz2nYdICfa1lkbisIeDkPDGogD7ZF0h66y/VDWi8UcjNvzxj11WKvLHHoI4TECa9HStRA8oS2eLB+yT3DuKDLx1sbY7KBoTWUBtVFWlcpo7AGmXvglYj1ctuAlEuidtPkMWxXHDSf287iyxcJeKr/CBX8v06OJ6p3IaltTyrUfygRH4YAS7ny86zMrL0C5BcUsTJYFkEfhmfu5+LHIdz7e1t8uyHXOI+nlr+tEW/us/n7dPpg701RXOFGJMimk1A1Rtn/SCcjLEVupJLbRDAxn+TLwi1rJONt/WC1oW9zUR1monWVGRJ0BynzRUmDHzLdqPjV28Oi5nRDhslVwod6rElwBW8hOLky6SfCpLLaOfG4QjgY3IaPCayyKXYAUT1szhcMjLQH/eiLcfXxIuPbI+4YKTecRGv2prmbyYM9u1KvlqltCjJwEgmObYB1dJernMbuiGWLdEP+lWrc13X9hhnFc33MfLalQi4DiFBcpcK0yeuqWfekxUXgZ89am+reGMyUcvEdCmH9EUon4dRj6DL5u9CFaxDauA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(86362001)(4744005)(5660300002)(82310400005)(2906002)(40460700003)(40480700001)(47076005)(186003)(16526019)(426003)(336012)(36860700001)(83380400001)(1076003)(26005)(82740400003)(54906003)(81166007)(6666004)(7696005)(356005)(6916009)(70206006)(4326008)(2616005)(70586007)(316002)(478600001)(8676002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:32:49.0013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef67b5e-c70d-411d-6753-08db7edde493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It uses the same UCODE ID(VCN0_RAM) but differnet cmd buffers
for all instances.

Fixes: e928b52c58dd ("drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ce8c766dcc73..8ff814b6b656 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -778,7 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, inst_idx);
+		amdgpu_vcn_psp_update_sram(adev, 0);
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
-- 
2.25.1

