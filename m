Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEA6C3B19D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546AB2082F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jba3vXel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546AB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F226EB7D;
	Fri, 14 Feb 2020 14:07:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C206E81C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 14:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYm0wbYcwN5QvNcVnYfrj19riveAzKSH/NIHG1w464ZYvfKc1Yr6HJr+fjrd/djXkTJPg2f7WKJ49NzvhCxJWil1d/9UcnUz9RhAnXkWWiOsQO1yxFut7QMUtYu6RH6G7UmiL8Xmy377sZDZOWgndrVQC+j73ligXL7rayt7ONLo2ADp2igYdjAMmN2bafFhI+sZCX3Q9L63W7gfk/b6aR91lYanfpsK1qtXLac4AibMwAe7pAfFZqCeFG8KUj7bFXlaZd+MGgihgK1IyaYxBTEddSERqqnRksnJYTJRnfnbv72diewNKCRrHl5jP/kARaE3lgbRxWvNFk8SIOcIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NipiHKhZhn1/htlviBmEXDjXNfulYSZl/+wXoE72gJk=;
 b=kaxeHlhWVkLZpZWkMw5rFgGZPqG2Br7y16gFsO0+kPOVsSpip2FhAhT4eMKLHkdFG2RkhbdSKd7wASGHi0V3K+ZvEVAI0W1wJwB49ELv2DVy2L80KTit9oX8mCtJO4S6gYml9K5LR/5GVUvF459o9cbeByOljrnRQW9bAxLE6rYw8WOHkXeIWT+n6yF1ijjm+s45i0WrnUPlEGQtXY687N4E63Cdepp34bbjmnfchdmf3wL0E6AXhyn2+rN5pbBv419zUE5EshSnlNU8jT8/tkjLwBsLWuO3LK2DSJmiUzBbXaXDRPqTNASssOKo2u2Nn6b8gunAG0rrAJkYAfx+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NipiHKhZhn1/htlviBmEXDjXNfulYSZl/+wXoE72gJk=;
 b=jba3vXely0sYxg100PlaLED1lbY+AvdvvC7KxWYMS0BfLfqXlfBtvmcaKGqW2EcTJHMjFaCbKXvDqV9nGvTPc6rCDIwc7QVEb6MwOUgYG6NXkmsT3rBijC8+UR4RSQBD4lwf5oN48eOJW2+vEgx6JaLEDZPXJlkrmbKaR+NJh5Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3110.namprd12.prod.outlook.com (20.178.53.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 14 Feb 2020 14:07:13 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 14:07:13 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 2/2] drm/amdgpu: record non-zero error counter info in NBIO
 before resetting GPU
Date: Fri, 14 Feb 2020 22:06:50 +0800
Message-Id: <20200214140650.2133-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214140650.2133-1-guchun.chen@amd.com>
References: <20200214140650.2133-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK2PR02CA0196.apcprd02.prod.outlook.com
 (2603:1096:201:21::32) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0196.apcprd02.prod.outlook.com (2603:1096:201:21::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24 via Frontend Transport; Fri, 14 Feb 2020 14:07:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 335088da-5217-428c-a5dd-08d7b15730af
X-MS-TrafficTypeDiagnostic: BYAPR12MB3110:|BYAPR12MB3110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31106BA6F80CCD1F3BB872E4F1150@BYAPR12MB3110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(52116002)(66476007)(66556008)(66946007)(478600001)(7696005)(5660300002)(6636002)(6666004)(1076003)(316002)(81156014)(4326008)(2906002)(2616005)(36756003)(86362001)(8676002)(44832011)(8936002)(81166006)(6486002)(186003)(26005)(16526019)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3110;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nza/MKm6NIMnb8QFQGhxFLRaL9TsybE9YjfMCUcaYsm94maoP2kuR6QRxP34BdneHwCuZiN1w9yLsFzvmtgOSq3bcJWcTdXp2M79N8TD7EYNkllclq89roM6j5kzN8TseFQE3maRDQDmLHQRZKXgkmsNIdKMijTK+fgtndgnlbJHAhr3rvdRSK3IkCjc1/p/Jrc6kY+/GMJCcv5zrACEsOHNPyoM7A7QXw3oPDCSQ2ceTz+HC+5dDsM9kWNPkSvYvNWIFIlzDCmpNYLq5TZmB938+Na9/Z2LSIMqNkmINmqjLbNL+mG53boMiTqhQFpTL61Bdi1D3AdIjnxvkChzYYOQxpoDDADxryv0xPTP3EWDuWTvzSVTiKoB7OxvXHCdaGTRJXvNLw5ZcVwBx4k6aDtInnvwhJ9Ro/h1ZyC5TtAk77hBLXmewOipMexO2mQL
X-MS-Exchange-AntiSpam-MessageData: Jvt9ElL3SJFXXDOfjINYEkDVydVaQeoYY9d1XLH3YSevnRXKwnnuHtgr7zDHfXgoRxL//i4a2WcUDFPlV07x/CBkAGi/zovYQDOqsbFeViA2DfvNpNxiWey7XzfMk7KCVe8beBDOeKI1rXXaqGuXRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335088da-5217-428c-a5dd-08d7b15730af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:07:13.6601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNOExBEp3srNu0uo+6wqIjdslK/ovNdllk2z6F3T5Exd4uOqgnav1x/a+a3JYjA8jkOeUYU2I5CSwkvXyUFqcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3110
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When NBIO's RAS error happens, before trigging GPU reset, it's needed
to record error counter information, which can correct the error counter
value missed issue when reading from debugfs.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 65eb378fa035..149d386590df 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -318,6 +318,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 {
 	uint32_t bif_doorbell_intr_cntl;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, adev->nbio.ras_if);
+	struct ras_err_data err_data = {0, 0, 0, NULL};
 
 	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
 	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
@@ -332,7 +333,19 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		 * clear error status after ras_controller_intr according to
 		 * hw team and count ue number for query
 		 */
-		nbio_v7_4_query_ras_error_count(adev, &obj->err_data);
+		nbio_v7_4_query_ras_error_count(adev, &err_data);
+
+		/* logging on error counter and printing for awareness */
+		obj->err_data.ue_count += err_data.ue_count;
+		obj->err_data.ce_count += err_data.ce_count;
+
+		if (err_data.ce_count)
+			DRM_INFO("%ld correctable errors detected in %s block\n",
+				obj->err_data.ce_count, adev->nbio.ras_if->name);
+
+		if (err_data.ue_count)
+			DRM_INFO("%ld uncorrectable errors detected in %s block\n",
+				obj->err_data.ue_count, adev->nbio.ras_if->name);
 
 		DRM_WARN("RAS controller interrupt triggered by NBIF error\n");
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
