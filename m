Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05FAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 04:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3DC10EB53;
	Tue, 10 May 2022 04:11:10 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE8910EB6E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 04:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNkLX0J9Mmr5mZKGe795i2gTeZ8GAcwcWB3vA4Jfkd7BAMVY+dWiufYpJpjC3o4DZ+dD5LTDBgtvHGmSbs0XbqGuQSejRXSFdT+P09R1FUF1y1PUoYb3E3sGltrpzlxKt+sgePMRLvBnwQMyjS9kkRtOMLzz92iJHAcWJYILc0o2aPPJIP4muEq6cJdX2oXGPfTKL88PzvNnqRsOX5rDqaDKrJdaayMrZrB36O7moPzKn1gANcqrLTn4PVry5PygIABXVwuD7JKhtDOsOxAut8lLZVOHyuPja+Tj0iSmIYBehFoPCWGPaiiRuXpafUmuzJ3ZPhrHHg3HQDIS/67l+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFAizruORl6ILlyeQ3kiQvB+VWx3ZYgNBSwDYOQSQbE=;
 b=P5QXdFjyYqL4pffK1kvbbJ0+8VaZcJple4JqG2PmTyR9HRuOFZYyC+5LIR09rhVhZqV5xc8HbMm0Mo0dXrFmuaqPzMbc3iJKsJAPcdzZ/uYL1/ZwozTW+ERdpCvTQRb6jFQJXsvLDXCg/tZDJVl2/hgduOHw+CQR+Jje2z+MkinX41Cgk7CDyGJasTE19Ay90wD2n7caN3294Ulq2kxFnlyeZjxiCrrCsDXW/B8zDOAqHAQ8UmywIGZZKzRUHDHybb6n8TpuQuS8q2EJ722sc8hoA7hbGFsuFtxrR0hklSdmL/5ufyvDghL1z8tlYv5sgqCFej/w0biWRpTLENrpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFAizruORl6ILlyeQ3kiQvB+VWx3ZYgNBSwDYOQSQbE=;
 b=NpOpQse3Oli8dOxCWhAFhdH8TPLdfAj5/HfHRjiFUJXWaJBbhxZzR2kvEIzrKpp6FdiWAYHHxLuT6D+ntq+BFGJmG7Lqtx3l2R6cpZLINfBvEe6QW9pu6pWYpxB86/8Mqk7Aw28kUyXdi9i953tueV0ndqg1ANWhU5cyYFbWGfs=
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by BN8PR12MB3300.namprd12.prod.outlook.com (2603:10b6:408:6a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 04:11:07 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::5) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 04:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 04:11:06 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 23:11:04 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <Hawking.Zhang@amd.com>, <lijo.lazar@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/jpeg: add jpeg ras poison consumption
 handling
Date: Tue, 10 May 2022 12:10:43 +0800
Message-ID: <20220510041044.323154-2-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510041044.323154-1-Mohammadzafar.ziya@amd.com>
References: <20220510041044.323154-1-Mohammadzafar.ziya@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f61718-eff9-4ea3-44d6-08da323b1b50
X-MS-TrafficTypeDiagnostic: BN8PR12MB3300:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3300D041159C57835E02124798C99@BN8PR12MB3300.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTkmL2jcm6rpbfdST5lG93ja9ooJMkZYJU6n9ehFglmrNWmuzcfPFyx3AGbahUNBeME8x014GFxg0KrAILoxVmSoHiAXPoX1cFvm7i0cnD6UFUOFgV1cEiUgBEOP7dbdGSs21mbrKChtuXiTZDxT9AJ1+sFbufCTR2pVJpGmABnV/toSLyE0cz66yHhdgiGWTmYj7hOFKkSGeL3VZVmPc2+WOE7tTPS1rypryaGfiFkjv/6Xjh+Mcdem5/o5LOPZxspqLCS7GrOYbEcnOLxWFB0FOReTs+KNKv+YB4XO9lvHFZy9tTtClncNp7cz4wYOpg6ACKGH7ElwJ7tk7luglU5qhQXO6PJN8LQdIwLW98tn+j2yzhdmANQT+W/BvBDYPk8ot6ZksYmbcQRG3BBvxIb4f6ABhR+LrTpH0t1ppi+II6+5KFQnFiOEXH/zn5r7aIJwq/8oaM7a1J4dQMF33bVmW+H4AKJLF/HrY/WRBMPb0RiJt4D3jKcSkdzgPr6lcdbCvKYqFcmNLSyKelKWIxFvzpYXCmK91e9plkVv3LqbgA6hMYKCb0osPeq+EzkGrQj2DRSgDLx+mGs1h0Jkm9AhQTyirANXwAWegTeroPaxKyPtSmGb8lYc5OTOQhkh8nmDNulXHwHABgQG8TlCtzfgTYzfDiCPjxbYgfGWxdK9+FLP9/HnLoUYv6nLoj1U1ZcP0tgroitV55zl3Xg5Pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(5660300002)(6636002)(26005)(6666004)(54906003)(36756003)(8936002)(2906002)(47076005)(336012)(16526019)(426003)(186003)(82310400005)(1076003)(508600001)(36860700001)(86362001)(4326008)(70206006)(110136005)(70586007)(316002)(2616005)(81166007)(8676002)(40460700003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 04:11:06.8113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f61718-eff9-4ea3-44d6-08da323b1b50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3300
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
Cc: Tao Zhou <tao.zhou1@amd.com>,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add jpeg ras poison event callback and consumption handling

V2: Removed the default poison consumption cb handle

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c       | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h       |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c         | 16 ++++++++++++++++
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h  |  3 +++
 4 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 9342aa23ebd2..518eb0e40d32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -216,3 +216,21 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 error:
 	return r;
 }
+
+int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry)
+{
+	struct ras_common_if *ras_if = adev->jpeg.ras_if;
+	struct ras_dispatch_if ih_data = {
+		.entry = entry,
+	};
+
+	if (!ras_if)
+		return 0;
+
+	ih_data.head = *ras_if;
+	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index b6c7fb00e05a..635dca59a70a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -69,4 +69,8 @@ void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring);
 int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
+int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry);
+
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index c2bf036a7330..f87d0f6ffc93 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -99,6 +99,18 @@ static int jpeg_v2_5_sw_init(void *handle)
 				VCN_2_0__SRCID__JPEG_DECODE, &adev->jpeg.inst[i].irq);
 		if (r)
 			return r;
+
+		/* JPEG DJPEG POISON EVENT */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
+			VCN_2_6__SRCID_DJPEG0_POISON, &adev->jpeg.inst[i].irq);
+		if (r)
+			return r;
+
+		/* JPEG EJPEG POISON EVENT */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
+			VCN_2_6__SRCID_EJPEG0_POISON, &adev->jpeg.inst[i].irq);
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_jpeg_sw_init(adev);
@@ -573,6 +585,10 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	case VCN_2_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(&adev->jpeg.inst[ip_instance].ring_dec);
 		break;
+	case VCN_2_6__SRCID_DJPEG0_POISON:
+	case VCN_2_6__SRCID_EJPEG0_POISON:
+		amdgpu_jpeg_process_poison_irq(adev, source, entry);
+		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h
index 17acac147013..f842eb0d65bb 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h
@@ -29,4 +29,7 @@
 #define VCN_2_0__SRCID__JPEG_ENCODE					151		// 0x97 JRBC Encode interrupt
 #define VCN_2_0__SRCID__JPEG_DECODE					153		// 0x99 JRBC Decode interrupt
 
+#define VCN_2_6__SRCID_DJPEG0_POISON					161
+#define VCN_2_6__SRCID_EJPEG0_POISON					162
+
 #endif
-- 
2.25.1

