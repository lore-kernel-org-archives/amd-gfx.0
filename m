Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5F2C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336FE10F35E;
	Fri, 21 Aug 2026 16:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z607qMPZ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5093710F35E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZbcecSmc1uKZdD8JYTKWByFK8vFeG1gkNGxN+JhZzwHK1yAMEGaOPxHmEFR3HKkABXDSHQe1w/AhB/Y/JASMz7+yR61EtTgZxWsFuS+Z+t4Cu4dVDB2zAD60+rBCHZmx4qcQl2s4SYuVMWS2GKd+im/bm0BlhAbQIjVQpNXFSteSJVZ0bAc+N3XQC4CvNawLc+IVhoJycLHqCKfFIp8uiH74pjX2dsNMU7qNRb3IOYGDQ/BunkrtpqZh2KPNmJEsMPtRArKsUKn9xKz924bZPW+IJMvMo9kAd/QbkYV9Sm8d5RKXOYCM2ghdTUhdDbB1eZAuCkFZqVp+Lm2yUjNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jew5tmHbGt4yc1ELVGt10VnNj3EF7Qn/6I+DVINLhI=;
 b=ZF9SZ30+RxrEcci3v6FLi2h0PcAungDZlunVx3dl9xqYanABj3SNIF1SaoCvfV9fnOLESlBsFfShS2InfFFbjrVA0EijjvV6U7mrnbcvxZedTchvOLm8Z3tnunjewKzR/gB5hmpNJq1GNwoVImTgnn39z7W5FW8EKbFyP1peUNeOCDqVdpM0GPGZiwqf0GfDV7N3sgEBGAqiU4hX+It3oqzTum581sKhkOniud60Px1/V4rF2PX+JxJaRIZp/Pfl0NLq5ITTdPa0xfyfma4EFwRQjdZP1RuoH4fQWS2IiX19BZEOkL3K2R3+oeIWXaK788hm/8WGFsEWob4MsI8dZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jew5tmHbGt4yc1ELVGt10VnNj3EF7Qn/6I+DVINLhI=;
 b=Z607qMPZWy86sXOm/kHpGAk6g6UNip3ckJwsirVOQ+2l1P5euLRkT28DtyZ91rBt6ywYaKbMP+RI+5NJIdnMtDQpI/i6anolEI3/lH9DCB+65jiNQ7htr/iniuq117IDuQb4MKm3xTCdKbtO2v8IMjZ6HiTPtf/sJ3Qo6RX3caE=
Received: from SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::13)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:08:33 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::3f) by SA9P223CA0008.outlook.office365.com
 (2603:10b6:806:26::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:08:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:08:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:08:32 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:08:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: move tlb invalidation to mes sched pipe
Date: Fri, 21 Aug 2026 12:08:19 -0400
Message-ID: <20260821160821.752678-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 2231fdff-d9bd-46a7-57b5-08deff9e72e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: EwM2Y4ryVCBJ1e7vfQfVQ1yDgO560pkmX+tALWdhM1v3b4Lv4/j/GcJl5S+9Ap/sBI3OOSkv08Mc92Prx01ueYkIH7B5OCKj6mDO1T7xJtscX+JUHOxlSvxwuq/2JpOzGFJqf3e2JkuCRxqraKBBd5ret5I7g8teZRCgzx+qYCDNyb4TjtHMwU95VaAoG305AH1Sd8kxMaZ9V8yb0eFPrXKyHgKgQJnYjKRFm27p7XJ86td/3JFDdGa45pLXx9cfUhf4Jrj+eXe1mNog+uf6vs0h9uC/6nhGwGRsatoEId/u2wb4GOW39z3TvB3YQPgYMFB+SE/MC9jx217PQCLGGzf0b/qVAMV7h1Xtqpj7+GRV6YrGjoKv2/JNGvS4qAErP472uQuHuUzeRy+qgXoUOKAY2GEdCtbBEpYUmOYh8dJMbUj48PdCL569Fxt0JdR2/hxwssaI9G00DRXOcrXTWv5XnHbmV4QOxDxBrwCK9Fy6TFa0VFigqTpWddPixfw8JapXgIdcEAkPUtRPxGWQWGq0G/TiBEIxLcUV8KOdTymikwNgNskIwd1cN/8X/rMGDrQgpas1W43HeOX5vyxi1EX3ajs2EEbjF+eBVEyagipUKF0knrwrGsjZLuzs+EOaRSi5uu5VQ+LtJvXZjcCYqYzqZg6bhx1h1QFlT911oWuIdftrypYHXmM1cLu5+NWrrG1g6h+bYwD/QMX1xFpmWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2G9KIxF8tbedDh/DZGb9aI+3yu0eGOEKtMFp5VH4E7oSFpBcJyOoIHU5i75vZ5pQ/aStqJdp9Y14uaTqF2bpv0nsJJvLnIBZxuVgMUkYkPON5qdE7K9SmpT9ccRQ4FMYeJvlR6aZ1iLwbYp4eDKYYcjSe9UQRY40WBcTA4Q8elaZHwUYLbjdVhMFBDmaUjCqyfyk0qg88tCg8lq1CFpRHIU/+Pdb0Co2LvBkBCo/OEXBd2FgJL+A+mGR34h07vIdSgZt+Obu1yZu40V3vNcr9LsrOVWjYQGW1WwevGSO5FgaSZOxOP1iDA1XT/NlkZCmuAxl8V1CP6/MNLk7a4eyaPltNn7bsuufppOpSHnqDnXHJajGPBrMgYHXDA3QKpR39KOEMXTSI9TFR5lMdJeC0pRuoOQGSFIOHfwT9kfDe9cz4tpsL683JhDI32J2dORX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:08:33.0599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2231fdff-d9bd-46a7-57b5-08deff9e72e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shaoyun Liu <shaoyun.liu@amd.com>

The heavy weight shootdown need special handling in MES sched pipe

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 19bbf70e89b78..ba3dd72c56fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -572,7 +572,8 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 	union MESAPI__MISC misc_pkt;
 	int pipe;
 
-	if (mes->adev->enable_uni_mes)
+	/*OP_WRM_REG_WR_WAIT is used to do tlb invalidation which need to be handled in sched pipe for gfx_12_1.*/
+	if (mes->adev->enable_uni_mes && input->op != MES_MISC_OP_WRM_REG_WR_WAIT)
 		pipe = AMDGPU_MES_KIQ_PIPE;
 	else
 		pipe = AMDGPU_MES_SCHED_PIPE;
@@ -964,7 +965,7 @@ static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes *mes,
 	if (ret < 0)
 		return -EINVAL;
 	mes_inv_tlbs.invalidate_tlbs.hub_id = ret;
-	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, AMDGPU_MES_KIQ_PIPE,
+	return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, AMDGPU_MES_SCHED_PIPE,
 			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
 			offsetof(union MESAPI__INV_TLBS, api_status));
 
-- 
2.55.0

