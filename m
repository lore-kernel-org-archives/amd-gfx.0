Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C6C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 22:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B39613C8
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 22:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B39613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9AB16E927;
	Mon, 10 May 2021 22:00:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D896E927;
 Mon, 10 May 2021 22:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltWcu13ZNTxSm5sJMQfOd7ySzK1f7ondqs4fS7hsegaYK6rFXOCPcIeK3WnyqX2FI+LoOfro890K0Luh35puYb4m6n+jB6YJbe/mOVGoclOuI6+D1MMbFtgLiYZAHa4VwL7ouYk5vU6DMXHWDLhurbkIMeDRiW21dG8dIb/4vhMNsYl3HdGkd/1KYQhLPThJBCWtTIlrL5spgv13nRyadFe4ryuVHG9fHPG0F2ohkakSS6SW/F9P/De+TVEtB3ZCjusRtGC47GB4424Wm5eyFL7XkMg8s62lztC0lhaQ/I1KWJ+mgVIeIEj4EBs91vUdUKz8Ez7qIezvjAKo7lbp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6MgwABa0xnG6/RJzhsdY0GtEwgbbv1fp/CugNc1r7s=;
 b=e/p6n07gN/5iERE8XKGpu4o4Ghl4lSFRUunlGAGeF5OcqFUglOC1YWYzai7sCjL5/z9u9YxLfzJsxDT2Dm4YaV/vh6tb+wKX+D2iTt1gnLIMvvhzhpDefFZubPZz8/zmdAd0cwGvjfw3+fyrmlc9ka1e0klLJwSmdtqGVNFNsQrlceuwemhHYzsKs7SFIVfO+QRYTOnznplr7ApzWBlaUqCjdLsoAxePH4SMnXjoD1SrzEfP3v7y/FrRjaWgptis4aaaTD4X8fPSnLaL2o0Ggd3fIiyHh6tJrB7d0SWQjHr7aTkEN18J760Yewv3CSBE1N8k+KgZmhyluNy1m6unqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6MgwABa0xnG6/RJzhsdY0GtEwgbbv1fp/CugNc1r7s=;
 b=Uk5XRm91t0Mta3ddxqSDAKOLOLg0fA/1d3QK1vCSbK4zn+fd3vlk6YQoz55BoFNXr1NhNUNj5UJ9Ak0ovynR66MV/LWlAWiJrLuHuHR/6PVVvnWiduIorV3pqPKPkFg9ky18AeiI6dYQIA+InEZ10Y1ugm3eCZjMP4aPyVai8Ck=
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 22:00:03 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::9c8a:73d6:9a07:d021]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::9c8a:73d6:9a07:d021%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 22:00:03 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v2 02/10] drm/amdgpu: Rename kfd_bo_va_list to
 kfd_mem_attachment
Thread-Topic: [PATCH v2 02/10] drm/amdgpu: Rename kfd_bo_va_list to
 kfd_mem_attachment
Thread-Index: AQHXPU8CbDfp5+5JZk6AinJR0cNUT6rdVOjg
Date: Mon, 10 May 2021 22:00:03 +0000
Message-ID: <SN6PR12MB2672F450BD5EA24F5215E0CAE3549@SN6PR12MB2672.namprd12.prod.outlook.com>
References: <20210422013058.6305-1-Felix.Kuehling@amd.com>
 <20210422013058.6305-3-Felix.Kuehling@amd.com>
In-Reply-To: <20210422013058.6305-3-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-10T21:59:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=787b58d7-c9f1-4f18-acc6-de3d2b1442e1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: Review of amdgpu code
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [70.114.142.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f890b37-a207-4015-6df4-08d913fef6fa
x-ms-traffictypediagnostic: SN1PR12MB2591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB25915A11130CB72DFC88DDC6E3549@SN1PR12MB2591.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: omG2d+0tiEs4uihGgqkqZ59+tYifB7Pcs/4Q4WpBNcWe4KRW3RWOfCLW8rbVvhfwXr/AsgCY6YtXb5ES/JL3xtktllS9TLZtWfrW7C+ELj1ZDri7cSgO4c2v5p/CFo8+G12CpSDNy4LPtDx/n1kjwl7QPOeI++5m4AIHZhHieQs/gC1Xkuqg4O606tZ0h5TX8TsCTpKGmHVG635g1rb6li4e2jEDLhsFgsEHWIUfk2/YT2lpYx/R9z04lZG4g94YtNWqnTmkmdgyzH6BgdrPVwWyddALc8mp9FSS8Cw0gJXxTvONb1ODhS6Qo2PWca0dD2uP3RnFpd+bAfoMHwlkJVuwR/e9m0/G2/K1FR8u+0AYE7QAmV9QwJOQF4WkIORQ/tb34CIhT3E+T6pcdyg5q8pqAo7mI+NP5d62cdBJ5vF7k1hHKZiGo+SKJfsrd7TWIQEQpjZXR1k/FiTj+P8uL23+pbpknQfwQcqNgXdApgd7nOplarEw+fyW0EI7x0H8I3t7WljEMfK2mpJps3UFytIjJHJiC48lvkJkGDyhAuaIiiRgXRxbAdDLqKQFXhMRhsMXlFI0fdNFabPn/dGQoBvIzYYLj6iT0GG6j7+XgyLXx5eVhUKhGy3lhacMLJWr6r+prypFM1G88fp8MG7giA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(83380400001)(5660300002)(8936002)(316002)(110136005)(9686003)(186003)(55016002)(30864003)(8676002)(450100002)(26005)(66476007)(76116006)(66556008)(64756008)(66946007)(6506007)(53546011)(478600001)(122000001)(45080400002)(86362001)(71200400001)(38100700002)(2906002)(52536014)(33656002)(7696005)(66446008)(966005)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e4l0XOUDEFEjzxeQeLKXQHCwXslM0DaqD6v3SQzlWaukojx+xvUfRbgvbBiG?=
 =?us-ascii?Q?RYUSjFwCqo2NlnMAPAyLpibvcQpxCw/LY4dLBhcJwcPYRZCdxgORlnv8Bmv0?=
 =?us-ascii?Q?X9BS8aYqd5PC19tEsvDvkNJy5JuGBoNbDufqXwRZdwdDSHOQvSA934KwdV6m?=
 =?us-ascii?Q?gaEfUIS4k8/gCHsJGIr6PUHj8G2bKH7yrVqBzQ2U4mtNWHK7RzxyQSZb3FmC?=
 =?us-ascii?Q?UF00d07zSOxEu7bHC07gagAis34X+G68vIohfIW+h7whwNi53gW5T3nsq3P2?=
 =?us-ascii?Q?ZZCJxeXWIFdbhX/8m6EfyfEcf16pHvYmrQVRT2WpL/QeLH8XD6QFVFPtKc1N?=
 =?us-ascii?Q?0jiV1NNhL9gCpX8T2dRT/aA10/Jv3XsdrdPTPMX/Wenaw7smtDnkbDETFXmc?=
 =?us-ascii?Q?QABEkpy0wwyRkUV5QRup+zKfBm8CBi2kzHZhMiC0YNn7MLCDXFwgBs0kHKQ4?=
 =?us-ascii?Q?o9dv5GkvK2h1RVQV7PULlFyfsQbujgUoG41nD1tQrBspktdF4nq0N3CCfmt1?=
 =?us-ascii?Q?+Z7ndtIN4t4nNMdEh6TyH2mH7aySeF54+WENEpCWeCSCFPJseOGmg+WkpGA4?=
 =?us-ascii?Q?HTCZqknpMYZ1YwAIwxtrhI3SC7venuJSYsgE7wxete5HWyQubBetz6EQE07W?=
 =?us-ascii?Q?J1ylc2JL2RgCBESL4UsTKcaNfAx8WTWVjgbUwxOYbLJlqv5veSW9JrtHm9Da?=
 =?us-ascii?Q?4MfdOojmOki8FbYLcc4aG4ndt4OTUrM/uvMogFei1QBgvuab5IU8AFADUGGU?=
 =?us-ascii?Q?qlQhlcOxBPv0B6iNFK/C2imDfm7QqJRSUILt7/Q5/g6PcwudqZgWPHTafAj3?=
 =?us-ascii?Q?sGYJx0am4/vk2xAZavlWUBXggjULg8MELh9+3+VSNCmbUC7CViiRvCZBRXw4?=
 =?us-ascii?Q?ZqiOtp+4dPsKeTLmAyVNQenk589aesLm+zDKfN02jl4QHIHgVInNY3/fTTK0?=
 =?us-ascii?Q?v/W4cyjiHUq2hZKYeafAHYSoD0ngQqig/KknBlMctDYlIlifqukLiEls1MGQ?=
 =?us-ascii?Q?akHMh4gQxoQx97ML2rSdcPBae/82FO5GQarthDy3o+MYutqMbx/c+cg2DtqQ?=
 =?us-ascii?Q?3+o9mcZJK4gQWbCtAiDpoRXpqNslVMLYhcegl/mD5nLSuy+4rM3mgE3J+Iew?=
 =?us-ascii?Q?rlYLckoQsSseVrA9T8S/KhDPbud3/yxZQEoO79y46hrJETPxRtmDdAZzcY9W?=
 =?us-ascii?Q?cnlBcbJxcOt96k757nyYyNdO2lXhLG+jZQlz1moP3M4Xw11Cipe8bqXPWdcW?=
 =?us-ascii?Q?6MnyIM7yOnyo5T0YXrov3DURbUIIpzOQCkTirS5F3Nzop5JdG7MBqm0HsnOq?=
 =?us-ascii?Q?xA9JU9s+QBtthlBF1RUjvHFW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f890b37-a207-4015-6df4-08d913fef6fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 22:00:03.3805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kim58ZyGn6aQ280koxPZbb3Km8mwPGVEGjJSJ3XSiVY5BtSNUTzmRxNHwk1F7uqm41bmfnhJ+dT4/xFIyCYd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Ramesh Errabolu <ramesh.errabolu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kuehling, Felix
Sent: Wednesday, April 21, 2021 8:31 PM
To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
Subject: [PATCH v2 02/10] drm/amdgpu: Rename kfd_bo_va_list to kfd_mem_attachment

This name is more fitting, especially for the changes coming next to support multi-GPU systems with proper DMA mappings. Cleaned up the code and renamed some related functions and variables to improve readability.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 209 +++++++++---------
 2 files changed, 104 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 313ee49b9f17..c24b2478f445 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -38,10 +38,10 @@ extern uint64_t amdgpu_amdkfd_total_mem_size;
 
 struct amdgpu_device;
 
-struct kfd_bo_va_list {
-	struct list_head bo_list;
+struct kfd_mem_attachment {
+	struct list_head list;
 	struct amdgpu_bo_va *bo_va;
-	void *kgd_dev;
+	struct amdgpu_device *adev;
 	bool is_mapped;
 	uint64_t va;
 	uint64_t pte_flags;
@@ -50,7 +50,7 @@ struct kfd_bo_va_list {  struct kgd_mem {
 	struct mutex lock;
 	struct amdgpu_bo *bo;
-	struct list_head bo_va_list;
+	struct list_head attachments;
 	/* protected by amdkfd_process_info.lock */
 	struct ttm_validate_buffer validate_list;
 	struct ttm_validate_buffer resv_list;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index dfa025d694f8..fee4c64dd051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -72,16 +72,16 @@ static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 	return (struct amdgpu_device *)kgd;
 }
 
-static bool check_if_add_bo_to_vm(struct amdgpu_vm *avm,
+static bool kfd_mem_is_attached(struct amdgpu_vm *avm,
 		struct kgd_mem *mem)
 {
-	struct kfd_bo_va_list *entry;
+	struct kfd_mem_attachment *entry;
 
-	list_for_each_entry(entry, &mem->bo_va_list, bo_list)
+	list_for_each_entry(entry, &mem->attachments, list)
 		if (entry->bo_va->base.vm == avm)
-			return false;
+			return true;
 
-	return true;
+	return false;
 }
 
 /* Set memory usage limits. Current, limits are @@ -473,7 +473,7 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 	return pte_flags;
 }
 
-/* add_bo_to_vm - Add a BO to a VM
+/* kfd_mem_attach - Add a BO to a VM
  *
  * Everything that needs to bo done only once when a BO is first added
  * to a VM. It can later be mapped and unmapped many times without @@ -485,15 +485,14 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
  * 4. Alloc page tables and directories if needed
  * 4a.  Validate new page tables and directories
  */
-static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
+static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem 
+*mem,
 		struct amdgpu_vm *vm, bool is_aql,
-		struct kfd_bo_va_list **p_bo_va_entry)
+		struct kfd_mem_attachment **p_attachment)
 {
 	int ret;
-	struct kfd_bo_va_list *bo_va_entry;
+	struct kfd_mem_attachment *attachment;
 	struct amdgpu_bo *bo = mem->bo;
 	uint64_t va = mem->va;
-	struct list_head *list_bo_va = &mem->bo_va_list;
 	unsigned long bo_size = bo->tbo.base.size;
 
 	if (!va) {
@@ -504,29 +503,29 @@ static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
 	if (is_aql)
 		va += bo_size;
 
-	bo_va_entry = kzalloc(sizeof(*bo_va_entry), GFP_KERNEL);
-	if (!bo_va_entry)
+	attachment = kzalloc(sizeof(*attachment), GFP_KERNEL);
+	if (!attachment)
 		return -ENOMEM;
 
 	pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
 			va + bo_size, vm);
 
 	/* Add BO to VM internal data structures*/
-	bo_va_entry->bo_va = amdgpu_vm_bo_add(adev, vm, bo);
-	if (!bo_va_entry->bo_va) {
+	attachment->bo_va = amdgpu_vm_bo_add(adev, vm, bo);
+	if (!attachment->bo_va) {
 		ret = -EINVAL;
 		pr_err("Failed to add BO object to VM. ret == %d\n",
 				ret);
 		goto err_vmadd;
 	}
 
-	bo_va_entry->va = va;
-	bo_va_entry->pte_flags = get_pte_flags(adev, mem);
-	bo_va_entry->kgd_dev = (void *)adev;
-	list_add(&bo_va_entry->bo_list, list_bo_va);
+	attachment->va = va;
+	attachment->pte_flags = get_pte_flags(adev, mem);
+	attachment->adev = adev;
+	list_add(&attachment->list, &mem->attachments);
 
-	if (p_bo_va_entry)
-		*p_bo_va_entry = bo_va_entry;
+	if (p_attachment)
+		*p_attachment = attachment;
 
 	/* Allocate validate page tables if needed */
 	ret = vm_validate_pt_pd_bos(vm);
@@ -538,22 +537,20 @@ static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
 	return 0;
 
 err_alloc_pts:
-	amdgpu_vm_bo_rmv(adev, bo_va_entry->bo_va);
-	list_del(&bo_va_entry->bo_list);
+	amdgpu_vm_bo_rmv(adev, attachment->bo_va);
+	list_del(&attachment->list);
 err_vmadd:
-	kfree(bo_va_entry);
+	kfree(attachment);
 	return ret;
 }
 
-static void remove_bo_from_vm(struct amdgpu_device *adev,
-		struct kfd_bo_va_list *entry, unsigned long size)
+static void kfd_mem_detach(struct kfd_mem_attachment *attachment)
 {
-	pr_debug("\t remove VA 0x%llx - 0x%llx in entry %p\n",
-			entry->va,
-			entry->va + size, entry);
-	amdgpu_vm_bo_rmv(adev, entry->bo_va);
-	list_del(&entry->bo_list);
-	kfree(entry);
+	pr_debug("\t remove VA 0x%llx in entry %p\n",
+			attachment->va, attachment);
+	amdgpu_vm_bo_rmv(attachment->adev, attachment->bo_va);
+	list_del(&attachment->list);
+	kfree(attachment);
 }
 
 static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem, @@ -728,7 +725,7 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 				struct bo_vm_reservation_context *ctx)  {
 	struct amdgpu_bo *bo = mem->bo;
-	struct kfd_bo_va_list *entry;
+	struct kfd_mem_attachment *entry;
 	unsigned int i;
 	int ret;
 
@@ -740,7 +737,7 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 	INIT_LIST_HEAD(&ctx->list);
 	INIT_LIST_HEAD(&ctx->duplicates);
 
-	list_for_each_entry(entry, &mem->bo_va_list, bo_list) {
+	list_for_each_entry(entry, &mem->attachments, list) {
 		if ((vm && vm != entry->bo_va->base.vm) ||
 			(entry->is_mapped != map_type
 			&& map_type != BO_VM_ALL))
@@ -762,7 +759,7 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 	list_add(&ctx->kfd_bo.tv.head, &ctx->list);
 
 	i = 0;
-	list_for_each_entry(entry, &mem->bo_va_list, bo_list) {
+	list_for_each_entry(entry, &mem->attachments, list) {
 		if ((vm && vm != entry->bo_va->base.vm) ||
 			(entry->is_mapped != map_type
 			&& map_type != BO_VM_ALL))
@@ -817,7 +814,7 @@ static int unreserve_bo_and_vms(struct bo_vm_reservation_context *ctx,  }
 
 static int unmap_bo_from_gpuvm(struct amdgpu_device *adev,
-				struct kfd_bo_va_list *entry,
+				struct kfd_mem_attachment *entry,
 				struct amdgpu_sync *sync)
 {
 	struct amdgpu_bo_va *bo_va = entry->bo_va; @@ -833,7 +830,7 @@ static int unmap_bo_from_gpuvm(struct amdgpu_device *adev,  }
 
 static int update_gpuvm_pte(struct amdgpu_device *adev,
-		struct kfd_bo_va_list *entry,
+		struct kfd_mem_attachment *entry,
 		struct amdgpu_sync *sync)
 {
 	int ret;
@@ -850,7 +847,7 @@ static int update_gpuvm_pte(struct amdgpu_device *adev,  }
 
 static int map_bo_to_gpuvm(struct amdgpu_device *adev,
-		struct kfd_bo_va_list *entry, struct amdgpu_sync *sync,
+		struct kfd_mem_attachment *entry, struct amdgpu_sync *sync,
 		bool no_update_pte)
 {
 	int ret;
@@ -1194,7 +1191,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		ret = -ENOMEM;
 		goto err;
 	}
-	INIT_LIST_HEAD(&(*mem)->bo_va_list);
+	INIT_LIST_HEAD(&(*mem)->attachments);
 	mutex_init(&(*mem)->lock);
 	(*mem)->aql_queue = !!(flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM);
 
@@ -1283,7 +1280,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
 	unsigned long bo_size = mem->bo->tbo.base.size;
-	struct kfd_bo_va_list *entry, *tmp;
+	struct kfd_mem_attachment *entry, *tmp;
 	struct bo_vm_reservation_context ctx;
 	struct ttm_validate_buffer *bo_list_entry;
 	unsigned int mapped_to_gpu_memory;
@@ -1327,9 +1324,8 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		mem->va + bo_size * (1 + mem->aql_queue));
 
 	/* Remove from VM internal data structures */
-	list_for_each_entry_safe(entry, tmp, &mem->bo_va_list, bo_list)
-		remove_bo_from_vm((struct amdgpu_device *)entry->kgd_dev,
-				entry, bo_size);
+	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
+		kfd_mem_detach(entry);
 
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
@@ -1372,10 +1368,10 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	int ret;
 	struct amdgpu_bo *bo;
 	uint32_t domain;
-	struct kfd_bo_va_list *entry;
+	struct kfd_mem_attachment *entry;
 	struct bo_vm_reservation_context ctx;
-	struct kfd_bo_va_list *bo_va_entry = NULL;
-	struct kfd_bo_va_list *bo_va_entry_aql = NULL;
+	struct kfd_mem_attachment *attachment = NULL;
+	struct kfd_mem_attachment *attachment_aql = NULL;
 	unsigned long bo_size;
 	bool is_invalid_userptr = false;
 
@@ -1424,21 +1420,20 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	    bo->tbo.mem.mem_type == TTM_PL_SYSTEM)
 		is_invalid_userptr = true;
 
-	if (check_if_add_bo_to_vm(avm, mem)) {
-		ret = add_bo_to_vm(adev, mem, avm, false,
-				&bo_va_entry);
+	if (!kfd_mem_is_attached(avm, mem)) {
+		ret = kfd_mem_attach(adev, mem, avm, false, &attachment);
 		if (ret)
-			goto add_bo_to_vm_failed;
+			goto attach_failed;
 		if (mem->aql_queue) {
-			ret = add_bo_to_vm(adev, mem, avm,
-					true, &bo_va_entry_aql);
+			ret = kfd_mem_attach(adev, mem, avm, true,
+					     &attachment_aql);
 			if (ret)
-				goto add_bo_to_vm_failed_aql;
+				goto attach_failed_aql;
 		}
 	} else {
 		ret = vm_validate_pt_pd_bos(avm);
 		if (unlikely(ret))
-			goto add_bo_to_vm_failed;
+			goto attach_failed;
 	}
 
 	if (mem->mapped_to_gpu_memory == 0 &&
@@ -1454,30 +1449,30 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 		}
 	}
 
-	list_for_each_entry(entry, &mem->bo_va_list, bo_list) {
-		if (entry->bo_va->base.vm == avm && !entry->is_mapped) {
-			pr_debug("\t map VA 0x%llx - 0x%llx in entry %p\n",
-					entry->va, entry->va + bo_size,
-					entry);
+	list_for_each_entry(entry, &mem->attachments, list) {
+		if (entry->bo_va->base.vm != avm || entry->is_mapped)
+			continue;
 
-			ret = map_bo_to_gpuvm(adev, entry, ctx.sync,
-					      is_invalid_userptr);
-			if (ret) {
-				pr_err("Failed to map bo to gpuvm\n");
-				goto map_bo_to_gpuvm_failed;
-			}
+		pr_debug("\t map VA 0x%llx - 0x%llx in entry %p\n",
+			 entry->va, entry->va + bo_size, entry);
 
-			ret = vm_update_pds(avm, ctx.sync);
-			if (ret) {
-				pr_err("Failed to update page directories\n");
-				goto map_bo_to_gpuvm_failed;
-			}
+		ret = map_bo_to_gpuvm(adev, entry, ctx.sync,
+				      is_invalid_userptr);
+		if (ret) {
+			pr_err("Failed to map bo to gpuvm\n");
+			goto map_bo_to_gpuvm_failed;
+		}
 
-			entry->is_mapped = true;
-			mem->mapped_to_gpu_memory++;
-			pr_debug("\t INC mapping count %d\n",
-					mem->mapped_to_gpu_memory);
+		ret = vm_update_pds(avm, ctx.sync);
+		if (ret) {
+			pr_err("Failed to update page directories\n");
+			goto map_bo_to_gpuvm_failed;
 		}
+
+		entry->is_mapped = true;
+		mem->mapped_to_gpu_memory++;
+		pr_debug("\t INC mapping count %d\n",
+			 mem->mapped_to_gpu_memory);
 	}
 
 	if (!amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) && !bo->tbo.pin_count) @@ -1489,12 +1484,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	goto out;
 
 map_bo_to_gpuvm_failed:
-	if (bo_va_entry_aql)
-		remove_bo_from_vm(adev, bo_va_entry_aql, bo_size);
-add_bo_to_vm_failed_aql:
-	if (bo_va_entry)
-		remove_bo_from_vm(adev, bo_va_entry, bo_size);
-add_bo_to_vm_failed:
+	if (attachment_aql)
+		kfd_mem_detach(attachment_aql);
+attach_failed_aql:
+	if (attachment)
+		kfd_mem_detach(attachment);
+attach_failed:
 	unreserve_bo_and_vms(&ctx, false, false);
 out:
 	mutex_unlock(&mem->process_info->lock);
@@ -1509,7 +1504,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
 	struct amdkfd_process_info *process_info = avm->process_info;
 	unsigned long bo_size = mem->bo->tbo.base.size;
-	struct kfd_bo_va_list *entry;
+	struct kfd_mem_attachment *entry;
 	struct bo_vm_reservation_context ctx;
 	int ret;
 
@@ -1533,26 +1528,24 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		mem->va + bo_size * (1 + mem->aql_queue),
 		avm);
 
-	list_for_each_entry(entry, &mem->bo_va_list, bo_list) {
-		if (entry->bo_va->base.vm == avm && entry->is_mapped) {
-			pr_debug("\t unmap VA 0x%llx - 0x%llx from entry %p\n",
-					entry->va,
-					entry->va + bo_size,
-					entry);
+	list_for_each_entry(entry, &mem->attachments, list) {
+		if (entry->bo_va->base.vm != avm || !entry->is_mapped)
+			continue;
 
-			ret = unmap_bo_from_gpuvm(adev, entry, ctx.sync);
-			if (ret == 0) {
-				entry->is_mapped = false;
-			} else {
-				pr_err("failed to unmap VA 0x%llx\n",
-						mem->va);
-				goto unreserve_out;
-			}
+		pr_debug("\t unmap VA 0x%llx - 0x%llx from entry %p\n",
+			 entry->va, entry->va + bo_size, entry);
 
-			mem->mapped_to_gpu_memory--;
-			pr_debug("\t DEC mapping count %d\n",
-					mem->mapped_to_gpu_memory);
+		ret = unmap_bo_from_gpuvm(adev, entry, ctx.sync);
+		if (ret == 0) {
+			entry->is_mapped = false;
+		} else {
+			pr_err("failed to unmap VA 0x%llx\n", mem->va);
+			goto unreserve_out;
 		}
+
+		mem->mapped_to_gpu_memory--;
+		pr_debug("\t DEC mapping count %d\n",
+			 mem->mapped_to_gpu_memory);
 	}
 
 	/* If BO is unmapped from all VMs, unfence it. It can be evicted if @@ -1701,7 +1694,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 	if (mmap_offset)
 		*mmap_offset = amdgpu_bo_mmap_offset(bo);
 
-	INIT_LIST_HEAD(&(*mem)->bo_va_list);
+	INIT_LIST_HEAD(&(*mem)->attachments);
 	mutex_init(&(*mem)->lock);
 
 	(*mem)->alloc_flags =
@@ -1898,7 +1891,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 	list_for_each_entry_safe(mem, tmp_mem,
 				 &process_info->userptr_inval_list,
 				 validate_list.head) {
-		struct kfd_bo_va_list *bo_va_entry;
+		struct kfd_mem_attachment *attachment;
 
 		bo = mem->bo;
 
@@ -1921,13 +1914,13 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 		 * VM faults if the GPU tries to access the invalid
 		 * memory.
 		 */
-		list_for_each_entry(bo_va_entry, &mem->bo_va_list, bo_list) {
-			if (!bo_va_entry->is_mapped)
+		list_for_each_entry(attachment, &mem->attachments, list) {
+			if (!attachment->is_mapped)
 				continue;
 
 			ret = update_gpuvm_pte((struct amdgpu_device *)
-					       bo_va_entry->kgd_dev,
-					       bo_va_entry, &sync);
+					       attachment->adev,
+					       attachment, &sync);
 			if (ret) {
 				pr_err("%s: update PTE failed\n", __func__);
 				/* make sure this gets validated again */ @@ -2108,7 +2101,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 
 		struct amdgpu_bo *bo = mem->bo;
 		uint32_t domain = mem->domain;
-		struct kfd_bo_va_list *bo_va_entry;
+		struct kfd_mem_attachment *attachment;
 
 		total_size += amdgpu_bo_size(bo);
 
@@ -2128,11 +2121,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 			pr_debug("Memory eviction: Sync BO fence failed. Try again\n");
 			goto validate_map_fail;
 		}
-		list_for_each_entry(bo_va_entry, &mem->bo_va_list,
-				    bo_list) {
+		list_for_each_entry(attachment, &mem->attachments, list) {
 			ret = update_gpuvm_pte((struct amdgpu_device *)
-					      bo_va_entry->kgd_dev,
-					      bo_va_entry,
+					      attachment->adev, attachment,
 					      &sync_obj);
 			if (ret) {
 				pr_debug("Memory eviction: update PTE failed. Try again\n"); @@ -2208,7 +2199,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 		return -ENOMEM;
 
 	mutex_init(&(*mem)->lock);
-	INIT_LIST_HEAD(&(*mem)->bo_va_list);
+	INIT_LIST_HEAD(&(*mem)->attachments);
 	(*mem)->bo = amdgpu_bo_ref(gws_bo);
 	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
 	(*mem)->process_info = process_info;
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cphilip.yang%40amd.com%7Cdae33699caef4626f26b08d9052e6488%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637546519080163885%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=w%2FdbGNao9UPDfoZ6%2BNA1qo8BFKPfAiKJzEEbD9eKgdY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
