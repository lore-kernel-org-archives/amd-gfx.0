Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C7CC3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCD120870
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GWK8P+Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCD120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA696EB22;
	Wed,  4 Mar 2020 10:52:28 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680056.outbound.protection.outlook.com [40.107.68.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6A16EB22
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 10:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOfp+HE0JsCkUmOzeisXf+4H3+bu1w5h0ZjSiUcH/FIaxeAyrCwYwdRZatHTzzgkjuXxOasWn5cv6lkzuWiV/XN5/rBrgzIRSa1JKRYOV6UcUJSldAMlT7OnvsumKtS08A/VEbSXbobnz5wU3QQ5F5G9p2FbFma4+32iRgGr5+dOfh+pofdPNtrSBAn1NOv0aKRd13J5HX8r26ikchqq9PFMNineSf2QW9stYbuUv6GD+goM4h7RZWXLTtV/fEbaJE68t5INR+/8GYTmauOHIOGheHkn8jyjHDqUY8anI62QvcYUSAaOYmbxpJ7JbMaBEpB+NBamHzBD8qwid1/VQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtWekA+81VGtS3hpqdBg8VXtR8i8lvpzY5lk3/L/htI=;
 b=VWvcJJlTGvx4lSzKS0z+GSawFbuXWSWg4Qhyxu7JFGRNq+Ya3kQU3UibAYB539htsscFyDVapXFA7oZJJnlV/sl0wGUgEO2fXURhhzFbiy7n5xxovY2hGlnYJZb+N+1TcEyRbzZnRcrXKSFOPW/eDj2wE57arDpzwzKonM4z47HFDEs10QVUjhpTbscq2Ltcy6XgGaxo4A658cy5szInEe+ff1lVFXjFpHIS2RWuL2ofr8g3sPfhVic6qpc2m698yDINdkFKKebyeXWNHJ9d8tE3G6P9I19UcFkTFo60d5hkV1s96ktdmq+NfbuQUmnusCqU6DOQ8Z9LIoOFA217HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtWekA+81VGtS3hpqdBg8VXtR8i8lvpzY5lk3/L/htI=;
 b=GWK8P+LrM0icVio/3c83Kq3kEeZ6seVPZ7XYM4O4FD/Sq4NunI0bCWiSleqAAT8tX+S/LfNQac+fCCOfolmbrzFwZ/ePYPCurmwhg6voST1koWjW/ThqrwKpL57G5+zrdtoHnIeVv1VGoN/A9vZnY3L6VI6CbwNein9qTwp2clY=
Received: from MN2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:208:234::11)
 by MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 10:52:23 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::60) by MN2PR16CA0042.outlook.office365.com
 (2603:10b6:208:234::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 10:52:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 10:52:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 04:52:22 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 04:52:22 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 04:52:20 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "Tao
 Zhou" <Tao.Zhou1@amd.com>, John Clements <John.Clements@amd.com>, Dennis Li
 <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: enable PCS error report on VG20
Date: Wed, 4 Mar 2020 18:52:02 +0800
Message-ID: <20200304105203.6660-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304105203.6660-1-Hawking.Zhang@amd.com>
References: <20200304105203.6660-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(428003)(199004)(189003)(426003)(1076003)(356004)(36756003)(6666004)(7696005)(336012)(5660300002)(2616005)(6636002)(70206006)(316002)(110136005)(478600001)(86362001)(186003)(8676002)(70586007)(81166006)(81156014)(8936002)(26005)(2906002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1870; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 907b48f6-a48f-4de6-b2ee-08d7c02a1eac
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18700A5B36971C79CD669316FCE50@MWHPR12MB1870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YgSSB5FiSSIw1C3N93aYu+xvcrNDEsw5YAyi2s7cKCxtCcA1hbLwieXjvVQV8NhjVlc/uYwUaT9pG3GL9PlnJFztYbG9N1gaSioB02suaXsEQEvP9CopAKojn1sRzjOCDyrD1b5rT1hAbdzKN4ILNd8xC79vHgEZwt8bWXIBuKnUbB6uepRc5809l96OYxIYn7N27inbzG6nuTXAuiaTnOkOhz2YOXjpWAlVzN6AAlTKHApZxTmMGREK+ZaYZlCo5OZ+66giQZzw/zZbISeUPlAXpzlCjfsGIus8XPxuqu9F41yexUba9W2dGn+9JYbLvjnFJwUxz5Go1R7vMANTE2yTlH2HT98nG2k3H5PRih6rfn+X1v21JSUAwD9Fs+kaQgWGUJGp39FKoWtxyoDhKEE/UBF1q8n048xbxLUjzVdxG0PHIicaY/LlMFBIbH4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 10:52:23.1318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 907b48f6-a48f-4de6-b2ee-08d7c02a1eac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now driver will report XGMI/WAFL PCS error through
sysfs xgmi_wafl_err_count node on Vega20

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 87f57878dbd5..bc216348b323 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -31,6 +31,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_atomfirmware.h"
+#include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 
 const char *ras_error_string[] = {
@@ -720,6 +721,9 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 		if (adev->nbio.funcs->query_ras_error_count)
 			adev->nbio.funcs->query_ras_error_count(adev, &err_data);
 		break;
+	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
+		amdgpu_xgmi_query_ras_error_count(adev, &err_data);
+		break;
 	default:
 		break;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
