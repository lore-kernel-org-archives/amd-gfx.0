Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3A6C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 14:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34830206F0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 14:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B5F+SbmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34830206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F03B189A61;
	Mon, 24 Aug 2020 14:21:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5A789A61
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 14:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGiArZWzckkq50fgImcv52oZWJPcjxasYalHmFkY0otusgMVHf5oHNAVPgjDFLHwlp4MpLXNtK2S2cHYK0cy9DNPc2VMqsAT4JP2XzQWNG54s8sy2LJJoEoqldyEBMh3dI4xQV630b1M9rHqmawN35IbvhUaTBkWn2EisZrgrnCwhAtFgwma6LrRvnnKB9mL4wwJuIfoUo2e6gZguaS1B6RSZYiqZfg5aNFBKJrimO3MAOamRIN2OGzZWLoQEo5mlBlE0+vuFIxCqx1Pz1hgWmjboUdsHERP4uH9L8tTVTfE7S2/qsGXo9W0NgT60Kb9U7pq2lbMxvJ/nPOM4IZVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQybG7dgL0eEFjyXxNh07mxGPBvu+TUZrQGB46sqqlo=;
 b=lSEPyIH2YIDxdESMvw5CmOvRLT7j3tk1gFb+Lj48NkaFM+o342b9aziyyBPY9WItjMFvlT1vkFsaDweMxGUtoFcq7oPQ5AdBt9gwT/BJJhPUL2twCyayuw6W4OhIPhA7FWQLm2dMPKUdg5XnQXmMsm/7A2+ioqvTaNOrA50WRfEzNGtLF/6wcSEcozX/SuyyJCgzC6JYFNDjdA1nKVwctCWBEdNhz7CuccKvClHmQY8c58lQ5Y9AWilmSx7EEqZ7I+PTk8bQs2fkwEBFM1czkhUWz577DraxriHYpDY0wod5O5oCyBDHE6Rqe7RGuClWno7muYo1Pti7/v+aZ05TiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQybG7dgL0eEFjyXxNh07mxGPBvu+TUZrQGB46sqqlo=;
 b=B5F+SbmML82dE0kE7tW9mljX6GeDXx3hhAfgJA0o/8c+inMJNBE0wcME3OjvfRVuDiO6dEoQR9u6tAvjoxXm9Y2fhqRcLv5Q5kFcS7h9aemUXiVevKFXWjy787n1zVg7snrbS16TqScUl5fWYtE3xWlRvMrlZ1FJZ4E/ZBQZQMI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 14:21:40 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 14:21:40 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: call amdgpu_amdkfd_get_unique_id directly
Date: Mon, 24 Aug 2020 10:21:16 -0400
Message-Id: <20200824142117.23684-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::47) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 14:21:39 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e54c834-aca4-421c-74e8-08d8483904a7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2413DF93D24D5882F50D8F5592560@SN1PR12MB2413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amArvIj/XTCsnsq6WAdpJXutkxbTML2MZNy3yqA3eaCj7YcdgNNTFv5fF0khtgeNl55n8M7XA126zIOlDpqKqKdiEfMV0NeEpBG1zeOGNoOxcK6EJrcM7mCsQJBeidOuphsnFtWMDIepqsLj62fSFns4tb1cxxQsozXiMLUW4chzfasMpq/q1cDiHN0RhKdPNAWOumHxU0VCO87BPeQRMJvj7376gJE6x0yG/e3WJz4b6KvTNmSRNU1rzlDBiNAAuI/1kcVoCGrfvuQ/FXWz047m9rTxUiHbKelFvekLZ4PsgsSG6QqpmE5HxGtmnN5qd59+KsvReT3/fLclvsShIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(26005)(6486002)(2616005)(186003)(6916009)(52116002)(956004)(5660300002)(1076003)(4326008)(83380400001)(316002)(16576012)(6666004)(2906002)(66556008)(66946007)(66476007)(8676002)(478600001)(36756003)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TSrD0uPZROSJsA519ct8YDNoZ5S4J8eUHBm3+UJYkppL54dJPsRdjrewOTVm09+t30j3PCrq2TaZ2USBqXoPHPub0iTwZ9C+53Sa924IZDvwhlyr+3ZfKXXzn5vdowKsSm8HCsrkpGvaZQLiOHULrO3qNbmGTFiI3PIxGjahjegtgyUttxM7hbIdHUQjkvWtwjaXvK38b70M8B1L6rpwAaUImhUpFoqMbs7nwkhabekWcwvYM9tSawvgw2teXyZdlln+oiSg5PzuUmtCFDIB19ioqQV51efx5wcnwSC73rTUODlqpvYTwDf+M6knHXEyync56vIEAmGaMqNt47w8oo2EU1iGFN4ESGsk42BAaSce6hF/9OfMLvfExcSWAeTs0+LMoZf1wzTzhzcbAAl6bx9Eoaacfe6ZOqvmcwz/fgWJPNuefiyW8i8+C/PxyM7Pa3/PZEi3M+bYpQtSGtpVJ2qkYnQDcEBiXIt3JrOiqP6jnv7PoBZNOCId6Urqp21zQjUmN1kje6/4J6bR/d3gF4PFKM/E8PGmF1vcb5c3Z3DrdhlZG8Rww/Mz/I/pGZ9EINzUlwr6Dj53MnyNKMlsl9XglSV5KTagyzpoflN9+O6APzTB5IVfDwnOVT5FMAuKj1tnUPQSWet0f9NlGWxzlw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e54c834-aca4-421c-74e8-08d8483904a7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 14:21:40.4562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoHvEImZJBZWgRxUdt+e5LGMYiIC+IFMPdb8ZMjPL8fIO1udt1ur1hJsvjf8vmqE3gJjUZx7lVCQaYCguG9fpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2413
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
Cc: Amber.Lin@amd.com, DivyaUday.Shikre@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to use a function pointer because the implementation is not
ASIC-specific. This fixes missing support due to a missing function
pointer on Arcturus.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 3 +--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    | 4 ----
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index b872cdb0b705..cef2ed767299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -778,5 +778,4 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 			get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
-	.get_unique_id = amdgpu_amdkfd_get_unique_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 64fdb6a81c47..e5592548b588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -729,5 +729,4 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
-	.get_unique_id = amdgpu_amdkfd_get_unique_id,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b15b620e731b..5ffd03685722 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -715,8 +715,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	if (kfd->kfd2kgd->get_hive_id)
 		kfd->hive_id = kfd->kfd2kgd->get_hive_id(kfd->kgd);
 
-	if (kfd->kfd2kgd->get_unique_id)
-		kfd->unique_id = kfd->kfd2kgd->get_unique_id(kfd->kgd);
+	kfd->unique_id = amdgpu_amdkfd_get_unique_id(kfd->kgd);
 
 	if (kfd_interrupt_init(kfd)) {
 		dev_err(kfd_device, "Error initializing interrupts\n");
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index a3c238c39ef5..017f97394344 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -214,8 +214,6 @@ struct tile_config {
  *
  * @get_hive_id: Returns hive id of current  device,  0 if xgmi is not enabled
  *
- * @get_unique_id: Returns uuid id of current  device
- * 
  * This structure contains function pointers to services that the kgd driver
  * provides to amdkfd driver.
  *
@@ -291,8 +289,6 @@ struct kfd2kgd_calls {
 			uint32_t vmid, uint64_t page_table_base);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
 	uint64_t (*get_hive_id)(struct kgd_dev *kgd);
-	uint64_t (*get_unique_id)(struct kgd_dev *kgd);
-
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
