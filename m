Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CAFC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 06:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9829110E53D;
	Thu, 17 Nov 2022 06:09:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB74A10E53B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 06:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0VmbP+oH1uom2GZlKdr/0EbgeUpfPDmo/3SK8Xzg4S5ucfq9S/oV/22tO0w55jy17aSStdjDw7eae4nDiiu3YsuNgVuEvd0C3kKBB/G99y0XkJkyDChP1XCZynmTjvmrGzaNxN3oaqgH3qqUQ/KXfnJRjSMOhJI4c3SysjoPLM9Zylf5e95NyNYHQU3aDyg8Tsb/mK/ZuuPpaEOFVccJV0CyWYXP7Aer/ET6bEbXFpXuBIZG4296rIciFIVJOGWRAnI+wUnSkrWzRV7E197w/dQvq51WQkDd3hKNrDk8bkVzy0lpNEnr1/cG3xq9GKaRdmjcouBSn25v8++35J7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTQacFRN3ZAgAqItkVq5NMql0OR0JqYM9GPM9IU5kwk=;
 b=B8MVEnnM9D4jTRT6PDKtUkprwuMO4wmEQTWXGUCgLgeH/NUs4zVa6humcmKuYIs6P3NDoKTOdKcO857lyIOLqsvD9g9ljntHl/8j7j8yZlzm5Cb4lrjklrV0W/xg3rO1RKE2uikLAGIPclk31zjx4xs1ZQHwyfoikWDR/SjwP1mQv34IaA26MWO0cq3ru8zkhm6qUTXMeurf8BrvTPK6vnlwkU5JA5wKHy9VejH0gaPL6/GQ+ZqOrLHUvkx24+GkIV+iH/zwK4EyGbCXXNZlZ5mdSWDIiIR74VZzGlzxHb+cDQY87yWzNC/TaxIEOvjApowGOXK8o2QQsxc0h7vORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTQacFRN3ZAgAqItkVq5NMql0OR0JqYM9GPM9IU5kwk=;
 b=doc7dSSK8aep8ruohPDIEwQYZQwmu9ienjNTTjRk8f6WQZHOqBHKt2+EdRslyNbRZ+TkBbmjCnUT+VCWfgKYlbOMGu5JHYwVmZSHetE2gGvBB+zUwXnFVFVpiYZMSkQEmxALVtHho84Ayhp8rS0yBATj+X+/EvJt6eXvyd//vNw=
Received: from BN6PR17CA0046.namprd17.prod.outlook.com (2603:10b6:405:75::35)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 06:09:36 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::c4) by BN6PR17CA0046.outlook.office365.com
 (2603:10b6:405:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Thu, 17 Nov 2022 06:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 06:09:36 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 00:09:33 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: add VCN 4.0 RAS poison consumption handling
Date: Thu, 17 Nov 2022 14:07:54 +0800
Message-ID: <20221117060755.13655-7-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117060755.13655-1-tao.zhou1@amd.com>
References: <20221117060755.13655-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|CH2PR12MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df55f29-9534-46a7-f585-08dac8624dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWTnxhfLkq0X28md4Ex9+8kOrXbPnKGMImRm/yil0x6drQqtCpECCdifAFjhaYf3eE8+KVGTwIfxRXaDYLIc7iuQD3hKStNBaxSJclf5giLLYPJG4bEObbIjTBWYnsmsiqcYQb74FGCA9fuLnf/j4tbB8SZ9VznD3RGz4mVdf9bazlXcLVanK/pHJ+rx0vsv5HFx8KaVrYAXVE3kAWAxdtR/X3sKT6yhVczJJ7oJ6qUURaCPR17Hc6lg9Tx9liHuyza9WkHD4m+H/4CuKBuStxLejmKLK6/4JcmlQr7fE8XxvR4NvMmbF7BTP7bCG6TOwy0sLw2kSEKGwd1itdSFAy1ZNeGDq9lfTlPDamnG8yTpagakQvmRlP+voSRY4q6b9BlUNIJbTk27pmC7ISYNe+fAtDcrUdtsCmfH6BWRBcMD6xeZNkdbkZsQliLd7V//HgJJgtUhMT118LQ8cfjpLTRygUmm1Esy73bXk+8GNTI1aDks4vLsA2B34hSGHdw6aMD2utzmmClprskSSqN1LdimcWTRSNSkYn/gM8M+ONXDOVHC8I/o1X+mSggYTwnHOh2sx1xBh4auXkKVreUHvcLbJuLuEyMrs9gx5W4eDvk3iXv3RvCaG+M9BpYqOkUxXR0Jy0pWCcX9AlV5whB7ea0pSgWjizobxuUQSS/ONHVOihNW+O9rBpGl5Oj6lAj52a1Y4sNnldiC2VRd2/m2j8fyU5W2v6+RlnSj41QGr2Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(82310400005)(36756003)(40460700003)(40480700001)(86362001)(82740400003)(356005)(81166007)(316002)(26005)(7696005)(110136005)(54906003)(6636002)(6666004)(47076005)(426003)(4326008)(186003)(2906002)(478600001)(16526019)(70586007)(70206006)(8676002)(1076003)(41300700001)(8936002)(336012)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:09:36.3183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df55f29-9534-46a7-f585-08dac8624dd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Register irq handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b067fb63010e..403d054cf51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -135,6 +135,12 @@ static int vcn_v4_0_sw_init(void *handle)
 		if (r)
 			return r;
 
+		/* VCN POISON TRAP */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
+				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
+		if (r)
+			return r;
+
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
 		if (amdgpu_sriov_vf(adev))
@@ -299,6 +305,7 @@ static int vcn_v4_0_hw_fini(void *handle)
 			}
 		}
 
+		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
 	}
 
 	return 0;
@@ -1942,6 +1949,9 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_
 	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
 		break;
+	case VCN_4_0__SRCID_UVD_POISON:
+		amdgpu_vcn_process_poison_irq(adev, source, entry);
+		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
-- 
2.35.1

