Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E79C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 05:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40ED110E2D5;
	Tue, 16 May 2023 05:04:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F6C10E2D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 05:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgpk0tHNSTN3jtV7bwtVEnqWEAyBCfiJyL0x3RTdMQc8q1cu+P9KTw00FulMEVwyPwYkPm1SN/HwuZvdoBY9dlab0hPxnI7DCiBbiyoBOY4BRKsTkltjHcc6XeRcLURmiCVTsAoTwKEJCJPIw4zpzqGL7KHId8ndOROiu8ZT5nk4AhgRGW+mxgAqHHnXq2uv8qBSuFlscERHdS+3e/scRX9xNRzlLfmkY5zmOIVK+l1Wo4eyjZGjvdwGIgge+guMNfn97HitXHPHkSm9IknLjLJVKwRTDjHwzV6haR4VNQmlpN3tSoTS0ElZPyGM7hd1IHHzjxtgarCD6m2//i/k4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYKTEDuTjT8bithNqo1u+Td/1IgBdtOGdWZnqQ/dsdo=;
 b=cWra8I18Diy7/rCVi5AlBBQ6FC/Mtb89LTkXu7e+VbUJRVSaUq8KBAFB9sq5e6h+abt25Tqq7Gp6qAyFpw6jCsFP0sCBDtHzlBR5bN0gSugFTnhJej7fmYfseCRSUlbAT+ul0pPrwb3skErRLA/xDTSgXdmOCqrK/KI63cR+VTFqLpavBUU/cFPl/Hk6h3UVELE90meqO6Y4ZdDvoUpZp3xVyvbXtzM4/YNEuXNsNqdCmvAXPBBQZD9oPuazYLNWxdonBUZtwAgXw88KzygoP+PqAJV0l6z6c3+eT8hpSSL7Z3mTJiJUJnNgAU9B7QG2cm1DRDD255aGYRWkwLTk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYKTEDuTjT8bithNqo1u+Td/1IgBdtOGdWZnqQ/dsdo=;
 b=XU1+74Y0TfAitbrXMtbqoBWyITnvkFpiVrZIGICQNny8Xq+hNCT86eliI4jnY/V0c/gG4+XyMNZsBnGeGvIZafWpbnhuEwDIVgTHjjkKGUNslLmqbZVPGLCwAL+5LJUauBsO4sjbKQDusepWgf+umAZgaHNGGzo+B3oK8LUtp28=
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 05:04:33 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::8e) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 05:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 05:04:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 00:04:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 00:04:31 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Tue, 16 May 2023 00:04:29 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/6] drm/amdgpu: add RAS POISON interrupt funcs for
 jpeg_v2_6
Date: Tue, 16 May 2023 01:03:57 -0400
Message-ID: <20230516050358.13095-5-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
References: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ab3afc-2d4b-41b8-877e-08db55cb09a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UNxu9jjDWBQ37y8uNG0Ch/RDCXkNGjwMG1jZ260npYRGCQxWOs3y2MFikWBYm6DgQh4uYtHMmN1vDcdynVeJ/IIFFykPcNOKxij/ex1nzSCA1Adk6akOeJgoAOOAYff3pgIDhf4hMIlmEVGi/1tMPf7ooizbHM5YX4YVLqZ/6vgaEz811ndxAw25yOXPaLj3P/dJYsEO3NFAGdkljheKIEoW3OiaXQ9JorOyF2W2n42y4lCgE/ILbt6w3zdE5eGTW9JPPPFb0mGry9QoV+MNKrPT2rGl2bDHzi+2krazKHOS0jYBknv1j4houw1l7dnrGvNOJ9kqCAvd4YV8EoGBHQtASKsME2E9cyZezE46iAfp7k6nkFffuXhDdfjDX9Ok2to+i67R/aUPsyfI4BKsyO3qlLiMUmDpnLKOGvbRSarlPLqfBhZG4F87qW2Bvx1/GSIovR6sUUcozvGcRH7pWXIs/mfto+ylLAMgJGqUwBz9dKAozAZBvqDQcICzGGq6OdyPTCBytz2FDR5E5NPJhtnBoFlkahNTtXasYFFGXFwXy/5b/t4p/TdHebD4IPRirB9ht1YMkPv+JuUGpMj6osb1cIl8B7a/svBqrBXuLzmeqKAuSRjPWp95D9hQsJO/y8yegFmHO2I+dDC1pPllk9K7etu/CboZN45qoEgB7Y74fR8Zvjql6VvtTRE0KzuwlcyRTNqdOpLnNf3slEMSgyloOXXRQFwvq8DeqbPDA+SeMKh1nGJuC04vxXehzk/NskKzAYoyxfXeviQD92pAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(336012)(47076005)(426003)(70586007)(70206006)(2616005)(478600001)(7696005)(40480700001)(26005)(1076003)(54906003)(6666004)(186003)(5660300002)(40460700003)(86362001)(8936002)(8676002)(316002)(2906002)(6916009)(82740400003)(41300700001)(36756003)(356005)(4326008)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 05:04:33.0034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ab3afc-2d4b-41b8-877e-08db55cb09a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 27 ++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index b79edb12b90e..3c83f0578113 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -102,13 +102,13 @@ static int jpeg_v2_5_sw_init(void *handle)
 
 		/* JPEG DJPEG POISON EVENT */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
-			VCN_2_6__SRCID_DJPEG0_POISON, &adev->jpeg.inst[i].irq);
+			VCN_2_6__SRCID_DJPEG0_POISON, &adev->jpeg.inst[i].ras_poison_irq);
 		if (r)
 			return r;
 
 		/* JPEG EJPEG POISON EVENT */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
-			VCN_2_6__SRCID_EJPEG0_POISON, &adev->jpeg.inst[i].irq);
+			VCN_2_6__SRCID_EJPEG0_POISON, &adev->jpeg.inst[i].ras_poison_irq);
 		if (r)
 			return r;
 	}
@@ -221,6 +221,9 @@ static int jpeg_v2_5_hw_fini(void *handle)
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 		      RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
 			jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+			amdgpu_irq_put(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -569,6 +572,14 @@ static int jpeg_v2_5_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_6_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -593,10 +604,6 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	case VCN_2_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(adev->jpeg.inst[ip_instance].ring_dec);
 		break;
-	case VCN_2_6__SRCID_DJPEG0_POISON:
-	case VCN_2_6__SRCID_EJPEG0_POISON:
-		amdgpu_jpeg_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -725,6 +732,11 @@ static const struct amdgpu_irq_src_funcs jpeg_v2_5_irq_funcs = {
 	.process = jpeg_v2_5_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs jpeg_v2_6_ras_irq_funcs = {
+	.set = jpeg_v2_6_set_ras_interrupt_state,
+	.process = amdgpu_jpeg_process_poison_irq,
+};
+
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -735,6 +747,9 @@ static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 
 		adev->jpeg.inst[i].irq.num_types = 1;
 		adev->jpeg.inst[i].irq.funcs = &jpeg_v2_5_irq_funcs;
+
+		adev->jpeg.inst[i].ras_poison_irq.num_types = 1;
+		adev->jpeg.inst[i].ras_poison_irq.funcs = &jpeg_v2_6_ras_irq_funcs;
 	}
 }
 
-- 
2.34.1

