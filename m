Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FECBC10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0127F2070A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SX0T+nHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0127F2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920546E560;
	Tue, 24 Mar 2020 21:58:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02846E55C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 21:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0GgFsW74KKjvyDJjOgScdXbIvqJcFdcPXJUt6YuasllOgELW9FkL6DyjQ58WGCVXFTyduTB0ujf3oQUVuD6poWqDyElCOPBYF+fewC9kRQmy8JgAK6jQW6eX/n+BEo/2e9MshEn2/DNMmoDWUqqgw53mMumI7e/+osnGPHQdQCXv97I1QcELQXTAJCfj3bjw4rFDZsVXR6HStLOwZUQLnVsUtwK2iW4PhJo91XXt+h/fkdqvxk27Ds7wODCF9papbw3n3FZKFsi9krB6S0XZSLTUtDmaUzGEZE4vxJhhWdQ30hRUb7Vi48lQHIEX9uthrHhkXiTtbDw9mRyZQP9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpQTGpu7w+JYiz1mjwUHqijVZ97kwwNk/bz2PYlh8yY=;
 b=CetdD6VjrCDoUTKFANCjYdbhqrCk3f+5n1tw4D+ljGDnpPj2eAUfIaHGjVzsLECFSwQfe9gXpNn868e5McyeLxCh9voOXwVi77H/doewFyPqLVhIrI+JgEiXULDfIFycBpfnDIIJ9Wjnxv4jM+2Ug36z05/xTEpD2clb+OtOAtYurKvBe8Nnox+vkLktJjjc1tCks98BDQp5OHhX7fd+txUlWui4OC07uC+bHvh5SgFug3snRB+6I/XfjDZQyJqvk8LPI5dRgAGEAnyfhShBiSK4ZuWE/dzij4YlGPdeYBOVm1ZdS5ZOR9zjYpXeR+C8m3GSRWWZ27xFDRrv2wM5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpQTGpu7w+JYiz1mjwUHqijVZ97kwwNk/bz2PYlh8yY=;
 b=SX0T+nHybF5gaX4vBmAKLMOua7/SoQnCuRc2YUvXQ5toVWYeRs1d4a16BtKmabBouEbqh8q0MNQmgxEn/7DTNFXgTo8GdSEPSVVrtk8GeucHWhSRfQ8X5tWSapYpfHPLne9FNhgpRpGglBKPTWCuUF9H3EOKpRh3zjEirAI5YfI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 21:58:09 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 21:58:09 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: reroute VMC and UMD to IH ring 1 for oss v5
Date: Tue, 24 Mar 2020 16:57:48 -0500
Message-Id: <20200324215749.29169-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324215749.29169-1-alex.sierra@amd.com>
References: <20200324215749.29169-1-alex.sierra@amd.com>
X-ClientProxiedBy: DM5PR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:4:4a::21) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR1401CA0011.namprd14.prod.outlook.com (2603:10b6:4:4a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 21:58:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9c531c1-01ef-4ae4-7017-08d7d03e7047
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:|SA0PR12MB4383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43834C200A89FC0BA9EAB8CEFDF10@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(8676002)(16526019)(52116002)(186003)(81156014)(86362001)(66556008)(26005)(7696005)(316002)(8936002)(66476007)(81166006)(66946007)(44832011)(6486002)(478600001)(2906002)(956004)(36756003)(6916009)(5660300002)(4326008)(2616005)(6666004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4383;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0QeFESW0Hs8X6vnOd+XNnEsI8syFn79sKUxpcDA2uYeEVYw6eeizZDgpfiEpen+gBNTh84gDkMeWZvcvG3z//spj5NMmYlOXTDrjahvtVH4ugZ5VkvrV9fSqGmRhF78myIrnT2fdQITM5N8JoWbyEsnf6jECwK8cc5aUgrObs7vvza2mdWYaUgqKBIZwZOEfprmCSRX2FSAeVGhlw0qAwUeUNbYAgAHuVC3FrXaX/8dt0EuZIkJfs6QC/pEOire6RVAdtTqErbioqr2YT/Q1+d8S/ygAWFub7VZh2+KLzfUsuaGUhYqETT+jEHgRPiXm5a9rMbI6S/RJMKpu7HMwGQuAWef2EXjZO7VyCJkIPcknURr6FexSWfI/FMzGjq2p3H9cXEje/W9hJWNP2ZtNmigJuLruaMs0s3qx+Hr5l9OdRuBBfft1nuhvO5uiZiL
X-MS-Exchange-AntiSpam-MessageData: K+EpaT6irzOmEXR7ZO3gNvRDTe+DzqwB9uZ8m7mc78c6P2ta/pSrtxJFmBI7Vcq63IfMIsgd3klrjivFM5yokmVkXJnD47bCvQxHkfkyCl7n04rD/VJ7E8kXXULETZAjdGEtFyQ4LVseVMdPp+lQvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c531c1-01ef-4ae4-7017-08d7d03e7047
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 21:58:08.8794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lycsM5p5cKAE1S4YSAQdUgUDWBvHcPeNBxDF/ekcskvbND4jY5pbE5zzIPMfRHvLyjlbbkR3xtj/v6kvAZhQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Due Page faults can easily overwhelm the interrupt handler.
So to make sure that we never lose valuable interrupts on the primary ring
we re-route page faults to IH ring 1.
It also facilitates the recovery page process, since it's already
running from a process context.
This is valid for Arcturus and future Navi generation GPUs.

[How]
Setting IH_CLIENT_CFG_DATA for VMC and UMD IH clients.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 4ce42635787a..6fca5206833d 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -205,6 +205,24 @@ static uint32_t navi10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
 	return ih_doorbell_rtpr;
 }
 
+static void navi10_ih_reroute_ih(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Reroute to IH ring 1 for VMC */
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
+	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
+
+	/* Reroute IH ring 1 for UMC */
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x1B);
+	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
+	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
+	WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
+}
+
 /**
  * navi10_ih_irq_init - init and enable the interrupt ring
  *
@@ -243,6 +261,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	} else {
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
+	navi10_ih_reroute_ih(adev);
 
 	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
 		if (ih->use_bus_addr) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
