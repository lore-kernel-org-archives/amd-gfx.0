Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEB7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD546E48D;
	Thu, 25 Nov 2021 10:59:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA45893DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js+kq5rKr0rs19MdRnX+LWNjZWTKPX5YcGwyUIYLF4cMWlfRFy+QFdTYmxvZ1JlSPXtzaGnNAZZtdXNx/kmMrmFlb2E4Vbj7JKNV1X58Gcg3NQWrXo/UE4bqWbh3h0slBBAm/IlqdQzgDzIzm47Snh1V1R7Uyc9veV8SenG2ey0LxC6Jaa17HqU9jDEDxRCrqTv49IGM1MvuNcEpDadwUBhktaCxbBnSPsdjN7IcfoyofMFGiEir/M7Qfu0jBKqMOZ1c4YDNeW5Mxolm1EVtkmmsEt7dx3dUbn8ntOJcN+8u3HyfycMK4QG0N89JRBU/wOk50ZgjL7K8Z3TkTWpx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWN7gy2Kk/akJtDZHE+gdedEFawoWm/gweO2Iaz+8gg=;
 b=ObbgEK9E7auT3FvprIBaCY28a0yeVu/teVgsvRq0hatl0ge0BZd11LNkgivmUlbXBFxzXI5IM6H6DeI1OAreJe/Et5CHdBudpna3UjWuuSUk5SquMxdYJ6FqUKMNmeadRpXLD2BQP/FpxfWXJ6WemPc62Xb3hNzMXY4iBi6imsCLCKds+JQcudBytsa46A1GEoel/HeTvSfabCKXLZLDZES9r5xzU7EwtmcmzanTLSTn8O+RDwr62f3gWhLyT2v/eXcFfbNkZjET59Y9IluwBRqLiJzlRC9zQnllkbPZBCfxZu4sQrlpn9UtIfekq461Va5nH7cZuBbHt/yi8vN9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWN7gy2Kk/akJtDZHE+gdedEFawoWm/gweO2Iaz+8gg=;
 b=lEgNCIWKN8pEY90lBHz05Wtp9Es3KBlVErN41I8wziOAMEZYZrDm8PMsYyIDUgrBzveq6OFlRhAJfgUBKEB46Inu38zxnGnWei3uobgDuIFeu5c2ev5Rvo+KeQ8UN+cAHlyryfN0sWVw24lYBlorBm2XmlGm9dfdDRoZa6ilePg=
Received: from DM5PR21CA0059.namprd21.prod.outlook.com (2603:10b6:3:129::21)
 by MN2PR12MB3343.namprd12.prod.outlook.com (2603:10b6:208:c2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 10:58:57 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::6) by DM5PR21CA0059.outlook.office365.com
 (2603:10b6:3:129::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend
 Transport; Thu, 25 Nov 2021 10:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:58:57 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:55 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amdgpu: Modify nbio block to fit for the unified ras
 function pointers.
Date: Thu, 25 Nov 2021 18:56:59 +0800
Message-ID: <20211125105701.15860-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125105701.15860-1-YiPeng.Chai@amd.com>
References: <20211125105701.15860-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54ccb841-d6d7-4da3-b87d-08d9b0029426
X-MS-TrafficTypeDiagnostic: MN2PR12MB3343:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33439BFE737EAA9ABAF01029FC629@MN2PR12MB3343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykvXjEx7fTijcPMPm/cb3ETptCwlyRVeOI6g4ux8kclUFNZXkwFcZS5Eos1VS2tzJMzSguFoOYXwPRQ4y4cJL7fz8EPiH3MqrL/rt4tYOSIPpjvNsBlNaVH4sB06S+q5qSADXS56/HZ5BbBQ8sVF6my71eYjLP+o+f+UeroARYOxaX3Ck7k58cQSwTEj5d6hyTp7VetksSAvr5uESEAUj7ZgAuqcAxJgAdCiRwchzoARKOSV8ki0inCaBJ3tYp5iSK8cCemy0gK2Cp2DjTgaXocNYjBKag8+Nx2f8ZbSBn31CUMhSHKG9pDKhFSA86fXEzsY1XEm6nY/YMy31CtoU1adUU4BwzPlgFJG3o3aLp1JEwdNcwOnYw9gL1INhRYOR5tXfHUGBgvsVUQnMQT0yDwikiwjXBQG4wVoBD8Qjop/4Mmqsz/dZ6l8xrpaXVCanUeDYu95pA53VxYlfNjva5b4Ue+d0wiA+5yZTejfrrr/2rsKWi32xQdTBO15b0m2w/7A6oT9+uFNdwZfKpzBc2wHhphkBbz2qTg4ez7c3C1yGDaZfWBsU1FJ6tqris3I++2ZRla0b7UmocfS1EwPEGtCqGFuLbpxHH7RzO2qst30MV2F5yJTVmGjrtzFxKCF1k8oF+JFI7cDdb3dOs/o7h88Uws5hOnHORieMQWXzLqEwKIGU1PsHUyqOR3ZWxh1+mR5yu6DJb0uYTdWfRvyXwqkAjoWiw6md+tDJO/CKEZSwwy9MsEZz29M42XEpSx5o0v7UGF48GzsAR92hp8KTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8676002)(86362001)(5660300002)(70586007)(426003)(336012)(26005)(16526019)(6916009)(8936002)(7696005)(70206006)(82310400004)(36756003)(186003)(316002)(36860700001)(356005)(508600001)(1076003)(2906002)(83380400001)(4326008)(2616005)(47076005)(81166007)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:58:57.0775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ccb841-d6d7-4da3-b87d-08d9b0029426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
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
Cc: yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify nbio block ras functions to fit for the unified ras function pointers.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 8 ++++----
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 843052205bd5..21574493afff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -22,7 +22,7 @@
  */
 #ifndef __AMDGPU_NBIO_H__
 #define __AMDGPU_NBIO_H__
-
+#include "amdgpu_ras.h"
 /*
  * amdgpu nbio functions
  */
@@ -48,14 +48,11 @@ struct nbio_hdp_flush_reg {
 };
 
 struct amdgpu_nbio_ras_funcs {
+	struct amdgpu_ras_block_ops ops;
 	void (*handle_ras_controller_intr_no_bifring)(struct amdgpu_device *adev);
 	void (*handle_ras_err_event_athub_intr_no_bifring)(struct amdgpu_device *adev);
 	int (*init_ras_controller_interrupt)(struct amdgpu_device *adev);
 	int (*init_ras_err_event_athub_interrupt)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2d9ef677a2ef..2c79172f6031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -938,8 +938,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 		if (adev->nbio.ras_funcs &&
-		    adev->nbio.ras_funcs->query_ras_error_count)
-			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->nbio.ras_funcs->ops.query_ras_error_count)
+			adev->nbio.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
 		if (adev->gmc.xgmi.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 91b3afa946f5..ebbe78d2ca52 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -643,9 +643,11 @@ const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs = {
 	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
 	.init_ras_controller_interrupt = nbio_v7_4_init_ras_controller_interrupt,
 	.init_ras_err_event_athub_interrupt = nbio_v7_4_init_ras_err_event_athub_interrupt,
-	.query_ras_error_count = nbio_v7_4_query_ras_error_count,
-	.ras_late_init = amdgpu_nbio_ras_late_init,
-	.ras_fini = amdgpu_nbio_ras_fini,
+	.ops = {
+		.query_ras_error_count = nbio_v7_4_query_ras_error_count,
+		.ras_late_init = amdgpu_nbio_ras_late_init,
+		.ras_fini = amdgpu_nbio_ras_fini,
+	},
 };
 
 static void nbio_v7_4_program_ltr(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f9d92b6deef0..99176af847f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1386,8 +1386,8 @@ static int soc15_common_late_init(void *handle)
 		xgpu_ai_mailbox_get_irq(adev);
 
 	if (adev->nbio.ras_funcs &&
-	    adev->nbio.ras_funcs->ras_late_init)
-		r = adev->nbio.ras_funcs->ras_late_init(adev);
+	    adev->nbio.ras_funcs->ops.ras_late_init)
+		r = adev->nbio.ras_funcs->ops.ras_late_init(adev);
 
 	return r;
 }
@@ -1409,8 +1409,8 @@ static int soc15_common_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->nbio.ras_funcs &&
-	    adev->nbio.ras_funcs->ras_fini)
-		adev->nbio.ras_funcs->ras_fini(adev);
+	    adev->nbio.ras_funcs->ops.ras_fini)
+		adev->nbio.ras_funcs->ops.ras_fini(adev);
 	adev->df.funcs->sw_fini(adev);
 	return 0;
 }
-- 
2.25.1

