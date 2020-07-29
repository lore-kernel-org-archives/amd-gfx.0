Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C500CC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B03B2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jERbL557"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B03B2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656806E440;
	Wed, 29 Jul 2020 02:57:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76DB6E43F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6SZMwYo6E4QGyxI1A0WutDXjPDYqWn4Ns4bK5Vn81UjwcdTKUoiSzYd8j/u9C9M+sp1p08FJbC99ep9n1mLP6lTMi5MZPiC3dCmC3IexDX3vTs+z2kZgBXsJs5frgevY+IchqSieH9zl/oeZLC5JMv5DBReSflUYyxTr6xhhxlh601X/HJNCSxnfRYeTk/fzXsrQsJS1RJ8/kYvOLRw/6Rj/lf+joE8qpeXy6ZYG8mlQb15CfXSqM2lqGqVXUttwjSoVfJe5DaywqzIIzJqacvUV7q6SYaT+LgWmK6rVgTLBrTLd9qW+WNSS0vQVa9Iu/Wvy79DI0BLL5HD4Hvl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya8cAJ7G1d+WwP58PmT16k5Br4qUFTwd1M+iICDGMRw=;
 b=kbwns7fnbt1OwdbKqTToEQ5dR9FuUO61l4VRcRikGT1IzuqbphzARh71TDzFgRsX3mcpjKO9B0bf5f23C93SkTqGo4lTr61CR1TLOlvNuaBBn9+LEK9h4REh3kLy9wqzjCw8Dubp4xK1hIIGc8Ndh0sB4ndlzf5CO273AKtSBXpEirrACzUL30QJD+fEJ6qcO3PmSP97f3U8S5aGGT92JD/cDnIY7/CfFvcmV0jsXHTDgVutYQw8YLkPKcsW+7K9nakdEa4awT7mRo+Yn+S4s/z8uTCSfpOP9gT50m/Xs3oyjRrRfPWB1mrvGuM0lFHEGEqtQdRZg3QKvHKePrXuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya8cAJ7G1d+WwP58PmT16k5Br4qUFTwd1M+iICDGMRw=;
 b=jERbL557v62Lso+vVRQGGK0gwhA1u/3tVTfm+9KLx+AsbwPHrJ1rIM+Tz99FY6yd2uKOIRH5W2nD1gHswoAMQD5m1Mq01qxh0ewooF/edd5//eV3nW4/+Us0g+9xsmPle4OPoRrbIFmETc4t+QmkY8lSPDd4BBMKCs3Ep4cCYww=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:26 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:26 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 11/12] drm/amdgpu: disable page reservation when
 amdgpu_bad_page_threshold = 0
Date: Wed, 29 Jul 2020 10:56:28 +0800
Message-Id: <20200729025629.19355-12-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:57:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1f6a8f2-eab6-4a28-79c6-08d8336b1fda
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1285666617798ADFC3680ADAF1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvRWEqG1mjD8JKNVo6bQvRGE+EiAwLR/YBSD0FpUP+FciW1JWhf3nyqR3Fk0gfw83Ta/GbfevjNdEVJndfpjzGajuaw1jdeVNT7ZBlUAa7Qe5vgfDW2PyhN1k51qQGvOcEO5sArFo9fAH781nfkolPRunIMr36JsOohEvr+YEBed0OnG+uyy68DLEDjOl9OtgFBS5+0/BGNa1EwsgdeIdGHprpD5fuMEsRIq4+Uv6brcd/270Oq7QBObK3cx7aD/wdDrqxRmpVGKIz4WM/ekS7ssK/qkqlTHPztggjoVCOsYS3DVJHWLD4Xk0GPYMvcyAW8yLOmmD18dJSDWH9BEyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KQTys4/Vpumro2xttbzAHlOiEgBL1e8YNvnJ4dep/f2y4ZGEgPqz9Wc+HW7IGX8puvlzVIWDi93gxqt7gpR72Mw/uh7cRDFfxoBnxYvdClwxzi78bImoGOGeUcWW2CyP4ARhybGwAdMQ0rR0nOGtwj4xiNRQ3T646SFBWARYPShd5qlzE5F1sIkUgyXrlpotbEame9Djb+g7dunj6yALe/d8ox7rQqq2dJRz/tk/Zfnq9OCRT+q69CFEtHn/Afxwvh89U0dTpisqp3VaE1TA9gn3BhCqzXuDGq8k/DBg16/Znz1u39cbEdzx7cgmhUEwrJB76tzPU1t4L7WfpOd+XuL/iOtlIZnCZIgV6+sWUJ+JUIoBMOtcET1ndo6tVQFw6IVAAKQ9mn0knWjHAokxJSbsPEx44IWV5iHlBs8ynR6GKHli9Vr1S3a3s9Kb8qloOfSDnMOqXLYWmKF47YvQ8YjZQEOjJU7VpVTRL9hqxDROMRLBQ2nbyK8mUYEb4R2u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f6a8f2-eab6-4a28-79c6-08d8336b1fda
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:26.4103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jy6X1CnBk0Yo8haeMrBhxc596FwqYRKBP99LzrgKejt776XI5v6iQCmUU8ujo6lTiJ9aAh1CYNAFHgck1K1Dyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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

When amdgpu_bad_page_threshold = 0, bad page reservation stuffs
are skipped in either UMC ECC irq or page retirement calling of
sync flood isr.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0b7317349bde..f47909d6a95b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1678,7 +1678,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	int ret = 0;
 
 	/* no bad page record, skip eeprom access */
-	if (!control->num_recs)
+	if (!control->num_recs || (amdgpu_bad_page_threshold == 0))
 		return ret;
 
 	bps = kcalloc(control->num_recs, sizeof(*bps), GFP_KERNEL);
@@ -1782,7 +1782,8 @@ int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev)
 	struct amdgpu_bo *bo = NULL;
 	int i, ret = 0;
 
-	if (!con || !con->eh_data)
+	/* Not reserve bad page when amdgpu_bad_page_threshold == 0. */
+	if (!con || !con->eh_data || (amdgpu_bad_page_threshold == 0))
 		return 0;
 
 	mutex_lock(&con->recovery_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index af1b1ccf613c..262baf0f61ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -125,8 +125,9 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 				"detected in UMC block\n",
 				err_data->ue_count);
 
-		if (err_data->err_addr_cnt &&
-		    amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
+		if ((amdgpu_bad_page_threshold != 0) &&
+			err_data->err_addr_cnt &&
+			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt))
 			dev_warn(adev->dev, "Failed to add ras bad page!\n");
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
