Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CCC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 14:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA07E206F0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 14:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QRyu0NSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA07E206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFBB6E28E;
	Mon, 24 Aug 2020 14:21:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FEB6E28B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 14:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8MVEHaOey9mCddeAaTsxKADUnwtD5OJ9wsZ2MwaCS7AqpT70rhFNTpMKHbxs+7miOGusuVa2rXtg00EBxltlbI1NGMEFqw6BUncjG9TvOjLff0jpJQZ9FiTPMP8sp+UtNUoDA1tyzUD6Y7phjQAYsEL1lVKt8wgTlrQK5jJJA7qxbhHz3iyOWQIdY7pzeg/CfYJL6lfiCPZ4vdy/bHhRJJNrJ28ZIni37Qg2s3e7v1eY7WyoUXaBqr4sCBMXUEV5Y9vm89fIXciiOrCWBhwomDHbUVWX+xJiL08JyDAl/bbsKzsscLvtBNUyYOhHrVmUMnKZlsnhW0pc8M4c6yVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzPHQykmV58VruN5a8JQdbtmRM256FcNOWgPpeKpB6w=;
 b=NjycX0vUQqH0XVDahd8LJoR4VCHjuBPVEfYtdsQ+JZX9xiySWeiW9Cn9fEbLVPCJY05TA3m7s7dnNuu3Pn/DabpKOXL2m4ucPfZF2+ad/WMOLStxypsBsvYlgkxpyZOmuna8ROZ1NY//LmCN0D+0Dg0YSV2t0ZwfOH7yFCS/AHFD2hkhQzPncsOHRKmADMgMKnDdhp5a3QqHMp+kBI849TKFNgFHuDBxvfLU6zNvYfGkmD2iLLL8mEFllOGPSkiC6ppU27d2g8Y8QEqgaUf6GZx8GlL9riP506t/uEv2Vu198IzVPUzUPuawQPjSuIZ6xHlyVgEnT+k0yURjHo4WGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzPHQykmV58VruN5a8JQdbtmRM256FcNOWgPpeKpB6w=;
 b=QRyu0NSI7U8VY0XUg/6DDwhWDCHAFHQbZ6DbFv2JDYA25qVSSBo5PpowfwKk4YlsenPsKhmBsCfSbDtyaDSb1kbqfOIiSPNEYt1kVzM/O5BVBlzSAUiwqhXK6tt9BDM/rR5e6yEiyI/QJq4cJapHpZmD7w2fL/4hIUM/s17qYh0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 14:21:41 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 14:21:41 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: call amdgpu_amdkfd_get_hive_id directly
Date: Mon, 24 Aug 2020 10:21:17 -0400
Message-Id: <20200824142117.23684-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824142117.23684-1-Felix.Kuehling@amd.com>
References: <20200824142117.23684-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::47) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 14:21:40 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e11ddf81-e1f1-4b7f-688a-08d848390515
X-MS-TrafficTypeDiagnostic: SN1PR12MB2413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB241359D6B259B14EAC43446D92560@SN1PR12MB2413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIM4Sasd6c6AZEh6ittHx5QuilkFKHiyqgfDUF4u2TNTcwEJxUE8EtsFdyS77p9ptbhaCUEXiHE0F1p00tTwOyVpyQM+7pRIpL21ltL/6vPKHl1URZtJbpyqFwXE0jId22Yad27IO2vVMHydUCPEwS6zbTUbTvli8HTpV6clWNAE/qL/on/IQ10WXHBA+R9NhznrYVlBtq81seARDXllVzOSROol2ikspULVPWYTUJjgcmqyO0mhFGxYEkbINimUrimHyyv1MpAD32DnU3Sb01IlkBixmPwEsmH1W93wZiWvcBuzZ0e6RElS+7QaM4UDsWEqKuhptTCGa2FwYw4q6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(26005)(6486002)(2616005)(186003)(6916009)(52116002)(956004)(5660300002)(1076003)(4326008)(83380400001)(316002)(16576012)(6666004)(2906002)(66556008)(66946007)(66476007)(8676002)(478600001)(36756003)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O/cCC3xAQvid+bfI0P4pCmLS6k6H8z9DAzEUjO+px98iR8QAciSyqXQVFQ4Rc/sp+OJzRKZgntyNT9V/fX04inmdOQuovcNCtnq6k+DOQygoBBa6xqwh4xNgZDKLd2jNpJOzhyB4Zd0oPd4Ts/fQd+fvdcFgyjoOjhnXiDlOtLZnOp+dPru6tW4PlZiRxuYaUfxXKhaG/DTLsV1e5HAOR+B/sjcyeib7pTysDDPlEiOH54lOnIkdanA6fsxHyppIJsNG1rGfeoYMBUULP3nbBsx1nqs/5L5N1tUkWNnI3x5BjFwuQKoyHFpelUIbHOodzy/WPahiBYVxZQvnjfvC5sz9jtYLxdd05/wzufnr3zNFvUZScKvR4AOvnDlNa/rd9q5QRYcY3V9ER8rQnx67dc3M7aaqyKsYO7+5p3ghg/FZnQpaV6RLb3YGMqcoGsbPDQm+jDWKlH3jL3KE/8hkl8wKvm16CPY+uuQhZH1G27/d7mZiOA3+j2iYSYb5InzXCm74SrY+49b/nu6gNruaeJ8Rba9+qEYPRMApoE2w0G7rO7zP9E58X2opKrsAHnCsukY2JM/AwUbh/y1kQkBIz95oKZiNSSsTwQv9AsfbwKjFylmjQ+meIYDqiXCiSyoUmELETkNgDoezUH1OYrH54A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11ddf81-e1f1-4b7f-688a-08d848390515
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 14:21:41.2217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uhd2Zh/DvjNonIX6xsRApR33Mekz38CNq4mEA3G1/lPVoNnJC7jeCu6UKZHM/2wpsknUp+d+I48e5Rij5kLjaQ==
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
ASIC-specific.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c   | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c    | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_device.c              | 3 +--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h      | 3 ---
 6 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index b914434db3ea..6a2e42087dbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -305,5 +305,4 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
-	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index cef2ed767299..830d5322d538 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -777,5 +777,4 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
-	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 7e59e473a190..e12623a9f7c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -822,7 +822,6 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.address_watch_get_offset = address_watch_get_offset_v10_3,
 	.get_atc_vmid_pasid_mapping_info = NULL,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base_v10_3,
-	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 #if 0
 	.enable_debug_trap = enable_debug_trap_v10_3,
 	.disable_debug_trap = disable_debug_trap_v10_3,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e5592548b588..afe5d47a9354 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -728,5 +728,4 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
-	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 5ffd03685722..e1cd6599529f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -712,8 +712,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto kfd_doorbell_error;
 	}
 
-	if (kfd->kfd2kgd->get_hive_id)
-		kfd->hive_id = kfd->kfd2kgd->get_hive_id(kfd->kgd);
+	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->kgd);
 
 	kfd->unique_id = amdgpu_amdkfd_get_unique_id(kfd->kgd);
 
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 017f97394344..fc592f60e6a0 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -212,8 +212,6 @@ struct tile_config {
  * IH ring entry. This function allows the KFD ISR to get the VMID
  * from the fault status register as early as possible.
  *
- * @get_hive_id: Returns hive id of current  device,  0 if xgmi is not enabled
- *
  * This structure contains function pointers to services that the kgd driver
  * provides to amdkfd driver.
  *
@@ -288,7 +286,6 @@ struct kfd2kgd_calls {
 	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
-	uint64_t (*get_hive_id)(struct kgd_dev *kgd);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
