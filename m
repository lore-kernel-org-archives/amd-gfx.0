Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803AEC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 05:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBD210E0EF;
	Tue, 16 May 2023 05:04:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4812E10E093
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 05:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB2RgReU+P4Aek5VMv9qFmjjhNb/LGXocktjio4pwJmCetQOSisjZ/q5pqb/NmQbrFtlumus/ePjEJX+4nnfhpC1pr+OUY81Yz6AQu0E/j9EG/haBZ6rYr73Sjmn4kUUHpWwxoejsYCCUIReORN4LeJls2+2Xah0NqBk8O82anKFiAvZnuwJ0dQVBU5Uq39GqGfJ1eOuF0pVp0Zpu8RvZKKkbg5lqSuitpSF+RM103Uw6iuge6zexhiuYRMuysTc3eAxEjP5k4qDSHBymRZKtYUNJlDoAvBYlVtfvnJlx8TkzBD1Z39bfcg3P0X01RgDhFb+tNgXqII/uyf06ufJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bu/X5DA33i8oFtSgu3Cp2Tlw0XYsYNoZraxJuwIyco=;
 b=Fp8WMfZhEKdIdLV5NgJInn7KRjUJGLNyeXm0ke6Aub4Dwzz9wa8oHTIS9/yKhSIYbtJ9VBAIZbgVVZ0K0pHsOYs5rF/GpVj9w9SN2FaRdHZLBS0hR4QHXCF3g8yvQYCsa2Mi3vqPdljbr7Eytsc54zN0kzgLONA184SjjlYpJybV5IAXPPAEKRA8vQANcwZN189stBVi2ooYjbg1enJrAdgk7DMQDCU7JTFMpuYqcjtQCGAM+L8Oyf4uqg6McA0VQnl20kdOaXNwyZnutzfEiXIvyy4dsrHim696AnlOUGP2dZc1ySHb0C+ACSLnwfGxKIA1fzJYwC/FBYwBWH3tgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bu/X5DA33i8oFtSgu3Cp2Tlw0XYsYNoZraxJuwIyco=;
 b=vEb+OovPw4Vkk9Z5+hyPnr6LkeVohMstZUesNBgchx9zo6p8BxDTRvmMG95R9SC73mALWI5IQXeH1WsWjVEYNzfmrNW2xkXV8LZ9nrNMIAdBvYDI2bPe4K2F2JTP/9/Vpc9zuSKbI15wqU8tU6yG+zO2OobiHddL8X1RJbXOPoQ=
Received: from DM6PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:100::26)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 05:04:05 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::4b) by DM6PR03CA0049.outlook.office365.com
 (2603:10b6:5:100::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 05:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 05:04:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 00:04:04 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 16 May 2023 00:04:01 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/6] drm/amdgpu: add RAS POISON interrupt funcs for vcn_v2_6
Date: Tue, 16 May 2023 01:03:54 -0400
Message-ID: <20230516050358.13095-2-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
References: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 125b2017-4380-4e20-be47-08db55caf8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbEVCkhZMsFWAnaOHt7OLe9QepKy50N2ua//a6r88HBN+swQ5CQsKfzu7R1oBb8sGIo95d+/jrqB2yW6AQHfXOIV1KDx05XWQTJqMWlOjpr7aXjrQz0n2k1RGr33CJmuWerk6J4iIEse8Vsf9huZ6HWMQUSlhk8MWP6j0DJIgyEZzNAQI/oQ9CzYaLRGSi2Cc7z1JkFkoYAIor5Eqf3yLraVQ/OdEsrzyBTybfJ63XHYWn0iLX2+OkrQD5fPDRAhYcPCIxcGso7fFVmeaSSrCnvU7F9eDteqh+84ImRjS4rbyPgQHe/RYPGstQQJl/s1hL/3BSj+O9AprgiusY44UsgEUrMgVrcDiIHnSRuJZ8HwB3+E2O/bPkbqhZW5/NOi/xEbrBjtlCbti624mPF8D99ApQhU547pREMso9JAjN8LiTt0Sbt7d3Gg6SXzxB8uPVtNeBk5VBhnrwG6pjMUGMjHlwX2n8kouGzqqT2fA1PMBe6W8CQY5sJ/9EQ5N7d47NdWvOGeecywp/67idJ5cklrKBXI/oD9kTv/jTMrpvxu4q8d/Pix92E4q7d2uNsTIq1/dVOYSvCwLAJmeX266lL1PUkFh/HvW+BfYF2C4DvI092kOhUQLfH6e4HSQvSHToFLkOUr9N51mOmB+XwDxLuEmXTbQacG+HwjCF25NkFqMVua0E8qxUwgIcSv6RI6ON763/7wr+qAJ0s/uAPeqrs7i3BHvQ8TgA1WLR6ovsW7qoD6iRxB+MxXMxlnFGP76gtGSBAhNvtR9MOfmo9kdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(40460700003)(54906003)(8676002)(86362001)(8936002)(5660300002)(2906002)(36756003)(82310400005)(4326008)(6916009)(70586007)(70206006)(82740400003)(356005)(81166007)(316002)(40480700001)(41300700001)(36860700001)(47076005)(186003)(2616005)(1076003)(26005)(83380400001)(336012)(426003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 05:04:05.1475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125b2017-4380-4e20-be47-08db55caf8fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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
Cc: HaoPing.Liu@amd.com, bob.zhou@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, feifei.xu@amd.com, tao.zhou1@amd.com,
 Sonny.Jiang@amd.com, Mario.Limonciello@amd.com, Leo.Liu@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ras_poison_irq and functions.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 7044bd7c9f62..52f1a90b0bb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -143,7 +143,7 @@ static int vcn_v2_5_sw_init(void *handle)
 
 		/* VCN POISON TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].irq);
+			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
 		if (r)
 			return r;
 	}
@@ -354,6 +354,9 @@ static int vcn_v2_5_hw_fini(void *handle)
 		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
 			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -1807,6 +1810,14 @@ static int vcn_v2_5_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int vcn_v2_6_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -1837,9 +1848,6 @@ static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 	case VCN_2_0__SRCID__UVD_ENC_LOW_LATENCY:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[1]);
 		break;
-	case VCN_2_6__SRCID_UVD_POISON:
-		amdgpu_vcn_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -1854,6 +1862,11 @@ static const struct amdgpu_irq_src_funcs vcn_v2_5_irq_funcs = {
 	.process = vcn_v2_5_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs = {
+	.set = vcn_v2_6_set_ras_interrupt_state,
+	.process = amdgpu_vcn_process_poison_irq,
+};
+
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -1863,6 +1876,9 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 			continue;
 		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
+
+		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
 	}
 }
 
-- 
2.34.1

