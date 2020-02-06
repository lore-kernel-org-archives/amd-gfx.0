Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27974C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 20:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37E2218AC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 20:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1fTKoAsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37E2218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707906E2D8;
	Thu,  6 Feb 2020 20:00:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770055.outbound.protection.outlook.com [40.107.77.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A253D6E2D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 20:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLb3wDGrLxulibw5DDBs46eVLH95OZ24iWCT69SGTQdDGL3YZruD5Voj/WYmXKtBhdQSNcFngOqpPWUHubA+TKe5gcwIrN3LLj/pgDqjuEgYHP6KhIhGEyCOu/f5H2i4tM33khTQMUPvsR/8spVkgtx1J3khBSH2z/AkdW398W3zl4cBfyLGUpTAejNXiljH9z6aTJU5voreN1ZHqD7ZT7WEqF9N5unjFbgs5Vv4TYB6W5/dWGeo4rTxQJL2xtE3tKtWdSzAeQ4msbZYB1q2eb0oAj3dNMM/zLb8/MSL3cdlaUe8up4j+Fd/MbivwkOGN/IxZ/UVsg5uVzNNlDJYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhH4++NdjLhSVabw7DcTvNHEY3iVdXqv3VHNC5QMMLQ=;
 b=FNbZKCglQZLnV0q01l5y29P+1wN3XIa/oBydYKohDuBc3zi0BKNNMmOOXiw+aMo9Y4OlxFPjW7hjG0ORQ+HBt9q0g/yfdNKxBhwa1EKiymVDFY8OjfOxzHLcIEXMzAAbAobziR+AeVw0m53thUNxSpjOGuDEW72EizC7IcWAfETYwGkZRW3B+lb1Y6HYFUjWG97FQ6nN96G2R7JjyruR244k0BVKRPrpGohajWncL6Ryo8iAy8lRQJQ5hyanMQ5QglA0SE6EsZ8C4wsiQHR9Wc7CK8IL1rT7lMsEg/Hb+7vpyWGwJAt/XrdwxU9Mi5ylBAM+vsBdXlc8E4vPGqP8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhH4++NdjLhSVabw7DcTvNHEY3iVdXqv3VHNC5QMMLQ=;
 b=1fTKoAsiJCZ8w35ILF/XOUIwSlqJAo45H5ChdLG2XhHq2LjNphaIV5llU7mT3Q1vriV3ylsrbbvXL0l9nWW6bZbpC0Nc7AqMFhdpqkXkg41JL8lj6/gxmt1Q1jaB9jnc7a5Z5bAxBUSn2fOp3NUA6Ips4mquWfmXHokypdsltlQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Samir.Dhume@amd.com; 
Received: from DM5PR1201MB0138.namprd12.prod.outlook.com (10.174.107.21) by
 DM5PR1201MB0106.namprd12.prod.outlook.com (10.174.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 20:00:00 +0000
Received: from DM5PR1201MB0138.namprd12.prod.outlook.com
 ([fe80::a1b8:d945:5522:d84e]) by DM5PR1201MB0138.namprd12.prod.outlook.com
 ([fe80::a1b8:d945:5522:d84e%9]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 20:00:00 +0000
From: Samir Dhume <samir.dhume@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost
Date: Thu,  6 Feb 2020 14:59:35 -0500
Message-Id: <20200206195935.36365-1-samir.dhume@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::30) To DM5PR1201MB0138.namprd12.prod.outlook.com
 (2603:10b6:4:56::21)
MIME-Version: 1.0
Received: from sdhume-SYS-7049GP-TRT.amd.com (165.204.55.250) by
 YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 19:59:59 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff33af62-392b-4c7d-1546-08d7ab3f259b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:|DM5PR1201MB0106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB010698A9CF22A5ED5DC691A4E61D0@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(1076003)(66946007)(66476007)(4326008)(66556008)(6486002)(6666004)(5660300002)(2616005)(956004)(81166006)(186003)(16526019)(2906002)(478600001)(86362001)(44832011)(316002)(6916009)(26005)(81156014)(52116002)(8936002)(8676002)(7696005)(36756003)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0106;
 H:DM5PR1201MB0138.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5jaXSqG9zzrhWdU0rrwTZqGUz7R4IU9pPv/3LVGka5bHL1fflszsB2TzFidivuaXxpzrpo1HRclvvEcr6NsHCNzu9kn/wpO5lYhTrjeVVonxkpQDWDrwQRO8BN0ANQKkBck9tIh7Dz48WjHRTdypt97lQ30xO90cTO6dYHqliTCXPs9Crg2nB/T/auDuJt2yXaujsX/YUVfwccdvHwBlVCGSKu20wWOW7uf0hZf6rVlHfitr3SV4yXW+RWaNfmiPqLckJ+1cIsY2eEgOUmYQJh9YleC4ITP0nqhsEMpld03wecTDzK+lWUatkjFwQ0HLtBgqajiPtDrTGtYKxe5RMVtakLjgXc/Ef+yiYDM6KK4j8tj8lngxY+7iKFJUFOoiYPhdBa78MAiGzNmVOuQH0f2qJVFkp2Op6pVJRDn2GMfYp9g5YOmmGcoBXwOrvXX4xAj8frzjjOPbVtWoLurYZ5DzUXzE/chgvH5kdViKavLZt0f9Ha9oq2WyFAB9YFw
X-MS-Exchange-AntiSpam-MessageData: s9IXgnDsxnJh8FtEkdgeuWjTFU5Kci6grHUhhkuwaS4sc97v9/o1xb9L6W9pmAVOd7c4g6PvZG+gkzYcROAkI/Ge+inxN5LTPecC7RjPFVIzP4MMC7jlRDSigN4FZuSlEz4sGQxLS8bwqLKXRqSRiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff33af62-392b-4c7d-1546-08d7ab3f259b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 20:00:00.0333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GWGNYlOpzVqvyzltLAIerzL17nNmOJtAYQydAbARRMYWn8ww0jbiegZE8QZIJ8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
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
Cc: Samir Dhume <samir.dhume@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ported from Vega10. SDMA stress tests sometimes see IRQ lost.

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index cf557a428298..e08245a446fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -32,6 +32,7 @@
 #include "soc15_common.h"
 #include "navi10_ih.h"
 
+#define MAX_REARM_RETRY 10
 
 static void navi10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
 
@@ -283,6 +284,38 @@ static void navi10_ih_decode_iv(struct amdgpu_device *adev,
 	ih->rptr += 32;
 }
 
+/**
+ * navi10_ih_irq_rearm - rearm IRQ if lost
+ *
+ * @adev: amdgpu_device pointer
+ *
+ */
+static void navi10_ih_irq_rearm(struct amdgpu_device *adev,
+			       struct amdgpu_ih_ring *ih)
+{
+	uint32_t reg_rptr = 0;
+	uint32_t v = 0;
+	uint32_t i = 0;
+
+	if (ih == &adev->irq.ih)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR);
+	else if (ih == &adev->irq.ih1)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING1);
+	else if (ih == &adev->irq.ih2)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING2);
+	else
+		return;
+
+	/* Rearm IRQ / re-write doorbell if doorbell write is lost */
+	for (i = 0; i < MAX_REARM_RETRY; i++) {
+		v = RREG32_NO_KIQ(reg_rptr);
+		if ((v < ih->ring_size) && (v != ih->rptr))
+			WDOORBELL32(ih->doorbell_index, ih->rptr);
+		else
+			break;
+	}
+}
+
 /**
  * navi10_ih_set_rptr - set the IH ring buffer rptr
  *
@@ -297,6 +330,9 @@ static void navi10_ih_set_rptr(struct amdgpu_device *adev,
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
 		WDOORBELL32(ih->doorbell_index, ih->rptr);
+
+		if (amdgpu_sriov_vf(adev))
+			navi10_ih_irq_rearm(adev, ih);
 	} else
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
 }
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
