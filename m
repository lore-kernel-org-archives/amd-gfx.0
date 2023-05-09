Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF39C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E07010E428;
	Tue,  9 May 2023 22:20:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3739D10E405
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzp41N9aVxSj34vV+EJ2qwhIJnEi6e7307L6VuWOaa+4ltnjAW7q3LbR7CZu0/Z2mo2YH8U6eSo1pqATKvgTnCYEUJTA3Jin6z94Q/COQpRZpQB6tASX9yI+B1cBm0UC8GI76qUEgLuCkOeQAjzXzlmQkEdwlAiOz942cE0gZM8craFXKgh1/PuNr69Xy+kaL9OR2R5r8dkTpsa70Flhf89gcZXsEmfn+6fdEpUEiIigNlii7XFBH+ncUQzAx3dN5+nGC3hZ2jRozAkO+ieyCdf91GOyisaEhFglJYzyeC20FoUU3bsXoaqZtSXBIRbokQ4N20KvSG+oCXlyJvxFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Umg8wqMbj3e8Aq5Hw7pupcMXG6LMqUs0aoWRa0Fg/o8=;
 b=d8ICaZQFiEiJvkYf6zd4q0CVF1NP5eSMxIZkOyLAG9l+k5G0e8o7Jg543p08rj4luxtb/1lZq7bbxNa4iJzJ06mDfu2QKJM+3KUrwnyPaD3WQ3B4vJwej+EwjPpO3HikzlE9TOTzWcq8o+5udAroaCd2uH6Vx4xxP7TbQrwAbfcKvbn6okjTUZ8K6xLhEqlIzds+FAAf+3dYBlMDGHVNsX6qtj9XWjvjstDQAaV0oFehZZ+6Mg884oEq6MBrUsOewyiDWTI2HIizcxEFgScTAEUcXdqaP4fNaIta1zaziO1fEyk6JvvMW+l5j8JpSe4YgrXHeRhPdFEdXRENfP6hKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umg8wqMbj3e8Aq5Hw7pupcMXG6LMqUs0aoWRa0Fg/o8=;
 b=EDDcxOz8Pb7yJX361WxR99ukODIhZLgFYq1EpOQDL0mOwBepWuYjURbwtfI5vBc6RdOBOCRQmvYmgiLrplKhS7a5dKqzADsDbQIFDDFi9paGnwXWLwxXFnJvWQ12F/hxQQOf1MUSNIW285Hgle1pMZD55jSIvAecH5r6ncy4fag=
Received: from MW2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:907::44) by
 CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:20:31 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::20) by MW2PR16CA0031.outlook.office365.com
 (2603:10b6:907::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Tue, 9 May 2023 22:20:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:20:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Checked if the pointer NULL before use it.
Date: Tue, 9 May 2023 18:20:11 -0400
Message-ID: <20230509222011.477547-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222011.477547-1-alexander.deucher@amd.com>
References: <20230509222011.477547-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: b67558c5-104c-46f5-6a7c-08db50db99df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZyNJpYWhnc+Kpass3XhOtu33y77JZBIo0h36kcHAIqGDR9Isjt2Yx/QVeMoJbFyTwN7cgOAeYIHOqlDc8qr09k4iVJmR/lcptVmpNx6amPhOalnhg+lGgTp2wwdMEA2bib6PHcF2yHUUCWDxGaV2MYG7SsSUa1NcD15MzZIAicEY/AbuxDM5afpDM+UvXG/U8y/3FgIZR22yKzUZeBQi8snecLfr+7YxQvNHz02uM6/Z+ifBnyj16UXOeXxKbdlQYOSJXE6tsXxsEyHd1K9UfYEFOsbfONy+Zv9IXDDGdzPV6H4T+P+z66j6Vl8Mr6Y4nEgQwh+aZ8jItGxAeogNTPouLGV8QNMgnRYPQEnDkAifvoDGPOwMMDa6HOtrtOzptGzyT8EZmxdi2IM12eaC2O7R0jMtxccj/hBik2bOXbg6qnY3EfENLVaM5HMNJbDGQU0V9PC+5jOpW04Kw3Xw5WHPYQC1uG6Mb1mTt/iwAGgfF84FBJkHgbeWQNzQY00nl1DtJUxUCqqyL46fcOZpjLrDLxAWKlsMr3TlbKOoLHfQjhiEXinkwfRAsymUCf9eFJ/p2G+OCh66f+oegYDxO5sQZpVKljAqtYksJV14rgG0ebys22GekjVKdyxpV8xKXAHX2x5u0f92K6JbAKVOylGeJBk260JnczBR+KntMb9P712ici1mxDsBHQsczsW1t19NQccEQfGg6/lLczlE8T5vrauNkiLH5JYDQJd35h4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(26005)(47076005)(1076003)(186003)(16526019)(478600001)(336012)(83380400001)(426003)(2616005)(6666004)(40460700003)(8676002)(7696005)(82310400005)(81166007)(316002)(86362001)(41300700001)(356005)(5660300002)(40480700001)(36756003)(6916009)(70206006)(8936002)(70586007)(82740400003)(4326008)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:20:31.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67558c5-104c-46f5-6a7c-08db50db99df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Gavin Wan <Gavin.Wan@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gavin Wan <Gavin.Wan@amd.com>

For SRIOV on some parts, the host driver does not post VBIOS. So the guest
cannot get bios information. Therefore, adev->virt.fw_reserve.p_pf2vf
and adev->mode_info.atom_context are NULL.

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Reviewed-by: Zhigang Luo <Zhigang.Luo@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5d62e0d5cc11..c2136accd523 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3854,21 +3854,24 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	/* enable PCIE atomic ops */
-	if (amdgpu_sriov_vf(adev))
-		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
-			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
-			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	if (amdgpu_sriov_vf(adev)) {
+		if (adev->virt.fw_reserve.p_pf2vf)
+			adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
+						      adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
+				(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
 	/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
 	 * internal path natively support atomics, set have_atomics_support to true.
 	 */
-	else if ((adev->flags & AMD_IS_APU) &&
-		(adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0)))
+	} else if ((adev->flags & AMD_IS_APU) &&
+		   (adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0))) {
 		adev->have_atomics_support = true;
-	else
+	} else {
 		adev->have_atomics_support =
 			!pci_enable_atomic_ops_to_root(adev->pdev,
 					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
 					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	}
+
 	if (!adev->have_atomics_support)
 		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
 
@@ -3884,7 +3887,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	amdgpu_reset_init(adev);
 
 	/* detect if we are with an SRIOV vbios */
-	amdgpu_device_detect_sriov_bios(adev);
+	if (adev->bios)
+		amdgpu_device_detect_sriov_bios(adev);
 
 	/* check if we need to reset the asic
 	 *  E.g., driver was not cleanly unloaded previously, etc.
-- 
2.40.1

