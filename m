Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1BD606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gcHlQTMt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B892510E950;
	Mon, 16 Nov 2026 02:26:41 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7255310E94E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 02:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IudKHYN13lwrFHuu/3/60EceC5ECsNjnZp6u0iwhQUVgzan4VKedvr1XoTpKiRgQAFWO00p1WbCQ9Y4lWpZKpiM/BQ2mHCfq1lovNvw/HA6VUWVC6IuWFvuOA+ygq7suGha56BVAfOuyjaAmvgFSgNS7foTYxFCrJmzLI/ATYTpM3PqJdMK0bMcZ3IlNk27T6luUIQsLK8b+JQ3ZN0pPPlm/XuQleBWzMc8RAdwcWvAjWJN/eDZhXe4NQIGtqfIz8+LrpZsc6pgT15m/D3ZO8VJrCXtneYo5qaQ3Qq+Ur0s3EZ/80Go9gQ8bboKUxgCALYCnNFNdvIQr6Mj7e36ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzuO60pcXJuYfIOvC8HUmvBuAwPCJioTrAmYJRFBXMk=;
 b=n7ehBo7oBqSa+THZWW6t6X3/r9O6FFcrCqvfrCVK5UEIyPEjztSfPw4FsDa0THQqjb/moxIBnW3dJ96KZ57S4kEX1/UADyQRrDrZFdPiDzdW8dQq1iBX+suVIF7sjI40/Bg8B0mAQ2W4LHVs+pM0nZcSwtwA5Q3eUttb9i4ozAKcKnUyfg+nfq50anye+UBMmR+PbNGzPut8c1MXqlN8ZisVINmynv7AuxLs2WDFX3F7ZCcfcvM6EC6C1vF+EE/r48vYM45FLpHCfY+AZYAvL2rSp000ysh7JVrC1OVEPWsGB0XDfIm3g856JVmEGDIuR1g2VS6ZVlFKJxPxJSu8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzuO60pcXJuYfIOvC8HUmvBuAwPCJioTrAmYJRFBXMk=;
 b=gcHlQTMtN0oc21ZS1ykzcBr0E+at0B7rEQAqsqSKYpAAlDMKjygQCTg9ECTw5PmJK3qYXvzylxrSI+nOIBXkAFKq0+yz0ZVT+5K6r3Iba6BY/E30BglVnaAhoKfjIutpHnJ9Uflcn29nx4teGMV58Y13UU2HUmhGO+6FeZN93VI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 02:26:32 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 02:26:32 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: don't take a per VM kernel BO for a page
 table
Thread-Topic: [PATCH v3] drm/amdgpu: don't take a per VM kernel BO for a page
 table
Thread-Index: AQHdb/Fyu/NbwPchl0uqlZlXhkHeeLcwA9GQ
Date: Mon, 16 Nov 2026 02:26:32 +0000
Message-ID: <DM4PR12MB5152A5DAD4AD68A659655569E37C2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261109022419.2677141-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261109022419.2677141-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T02:26:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ1PR12MB6172:EE_
x-ms-office365-filtering-correlation-id: cce212f1-91c2-42bb-9176-08df4389074e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261102123227099003|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: ZCVhiU7IPbmuSbgxcWFeDWPNcKvul2sch866RdE1emPtavXacnbsqEK4Fgebpca6eeesH4xX62fOOQsswp2lPxysnjGCZrDAcCouVlkU8FngwbuFpDgNFTYazmTNBgCV68/12Mz9HElTyHFzzIg9WnfM20ymzJ9NLrVAt/yYxldn9h0clf8b/eup4OO8QN9LIIuvapvl8izN1fcayrQFkKtBCeMSYbPRkW8e0iwX1D0WB+Kw5MszD2ePh5P/xhyxwAabEDhuStmTKiwzOlfCviInUTCGGIZ1f+hNK9E+EolD7rhG73TAmCOu2yPbBd+wMNafw4w4MrspV17jQpNe0OSvcv3y3SdrnQP328utnWgbKkXneKnolODKZrEp+VdjJywiiEbbQaXxFf9JnGIfLXKd2QsbV1rk2I1NP3aHLenBjac9CN/q8/h8jJ7GVg8sdi0cxvYEWCmg1rbe4wOrIH8AfHLlvVgAHQjJochK8dqAUXMqT9KceWIsvIolmyZjwrC9SfbeSEs4PPfTHGqLo3/eEmm3/mNdTl3ySX9mVn2MibIPcdeeB70Ikakv/VNQFv8W9qcusmjb7R3vM+98UAZQKvdE6u9gkq2tS4NJof8Pg2gjP0GpC6HKqqaVLdiQmOlRtgaYVKWKYDwPT6GghijJAVFk0uApEamSgVD1eIaraJeWzpPUxxNmx/eKYVDsg7fsm3FrHKEkcz74jQj231miDY4Su4lM1Yx7VfPU8Wk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+FiIQB6gNzgiUnnfx80PsXbAOmfczMuxE50LM4kgJsIT3ASOhGrngWmRjOuB?=
 =?us-ascii?Q?4xJzopZWX/8OT7Di3oRA71ubmSxcXJGNtOLFko4ofaYfytEivkSKPf0lmfTs?=
 =?us-ascii?Q?tYcVIlfpyxH0FeNdFvf7C5fRSYKM7tbyp/HuPLghVAspFprb/slIy2Poslp+?=
 =?us-ascii?Q?trZS06VyH9vG9zU4Je5g6KG9i7T4+cvLOIdmvZBzEBxl8HeglNN3pe8sjYTr?=
 =?us-ascii?Q?MwSzV0liXI6/6xSoJ/zLzUNr4idP8cf3e9aJwEtHq8+Va+PYZ7B5Bf1HIeDF?=
 =?us-ascii?Q?4y5mC5ecugx7ENKkO6XTF2ZnaeuOoBLTMMCxcFAQkFjO567c2p+E+7vuLt4o?=
 =?us-ascii?Q?madbJGiITRU9aGAiGk2iQ/6+UtO7/Z83T/wCu+AlCKkkS6Q24E+CbAsfiCNS?=
 =?us-ascii?Q?Whm6+A86QEfy4vwkuoowcEN2jdgbSZNvV4++d5r/M2EhLLaGg70kb6QW73vj?=
 =?us-ascii?Q?pvoRO6hsjFCjbHRBY1JBwJFQu/FHMNFBMmWz0FlaTlSuZC/wtfysd1RjvRav?=
 =?us-ascii?Q?23Q2/h2F0awepdZGaN1HXSMd0WqA67SVXf0yyZLQI76/cYsWNPQdeXfLleZx?=
 =?us-ascii?Q?QcAoA8OkmCGlE/Mze2XsY76s3yFTasKWyt/Ak1+G2BYgsAuThnMs0oB3Wolg?=
 =?us-ascii?Q?70rRnFgcFbwI3Jc1gq6tBBk4K+7fCaqs1QDeQ6jOfbdT6DlKz2un4IxZJOya?=
 =?us-ascii?Q?owUITZNskBCV6HU/id3P+/RJjgO+kOgj0h36fLnm/2QpV1kUF4w8sxYQXs0b?=
 =?us-ascii?Q?6rJH0r6KmNNoTPYV2Imah2pSCVDJamUEKXS6zYkXuLEoZkaN+BA3w9AnMjJw?=
 =?us-ascii?Q?XTaPmQsa1wCTgk82PQ5vunn4bP5lrHCDnbevHjWOaN4Ob3f3whsiCYxNdrIB?=
 =?us-ascii?Q?JcmRY/CbpVziINNBvv3VcDFub9JT4lhi7RWB73sM2lb2Niw9t12xVgkcYmFQ?=
 =?us-ascii?Q?e9A+jrKwWLxbTyHq2Iy8ueV3hHo32mLkknyxI/HVG976B9u2aM4HNRVvflMg?=
 =?us-ascii?Q?j+ag/c/dYZk2HOBZ4PSjJ9ONrW8J6g14f8J52etoavscnSB4VR6vWC6bS9f1?=
 =?us-ascii?Q?urNkqakLy4muLJjXPk+9ylisqob+Nu+sAR/afG7bSk93MnF5veLG0uB8EwFp?=
 =?us-ascii?Q?Jvozk/d54VOXmYJg/XDDYvYdKpT8VY1BaDaANxB2IIh0R68cSeHDn4yX3xly?=
 =?us-ascii?Q?AMjYsDqUIc3uJlKdVvhMI4aZwHW+Tm8yzHClwyVWxFbxsP1J57r3r7SALqS/?=
 =?us-ascii?Q?N3AolSWurwe8uqQokxLn19+vrersA5cT+apOMpaq2F7nhvkKe2EEE2h11BBJ?=
 =?us-ascii?Q?kBXht0oYm+osFvHpdQ3RGIVObZSvovsASa/TrHhKbhb4ZCC4Xj44LHrmfBD1?=
 =?us-ascii?Q?nRD4hbg3Fe4ylYLiakbUlghh7Sxtb04HXyEPIrw2u1CXda8lOA9c5AhSNV6c?=
 =?us-ascii?Q?ErUs5kYXNdmwEn4+FAiORqk+ffKLdtI5gX7eNFNT2ZYQF67AH7ibOk9O7TBe?=
 =?us-ascii?Q?h2hz7Z+Gz4XV/VGOYrUF6yPK6hc3Dw8ePnKgz0lUxqq5QLK5u3zpfq8cj5PL?=
 =?us-ascii?Q?N6TVMtLpgbzXRVh05zkuF+1JCZnKuXMsDnqNJAXe1Dox517NI7a7KlIHwjEU?=
 =?us-ascii?Q?wuwU/tFMc4qlzNwF+DRUl9CQVSNYjwp3MkRRN53aWoImaD/xLQQ6cjuH48A5?=
 =?us-ascii?Q?nGkFPwVDA7ezBvO+HeNwzCm0o98n8vGR5IPdNvhrvo4sHTRC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce212f1-91c2-42bb-9176-08df4389074e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 02:26:32.1854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWx/L8Nvsjwao3pMD0dV0zkdAN8zUiWMU869/T1Wrm2w/pMNAYM5+uJghzT+hXozyeCedf8zZUnWZkka8ZkO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Ping ...
> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, November 9, 2026 10:24 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v3] drm/amdgpu: don't take a per VM kernel BO for a page
> table
>
> amdgpu_vm_bo_lock_lists() puts every BO which shares the resv of the root
> PD and is a ttm_bo_type_kernel BO on the page table lists. The CWSR TMA B=
O
> which amdgpu_cwsr_alloc() creates for every opened render node is such a
> BO, so it is treated as a page table: after a VRAM losing reset its bo_va=
 moves
> to the page tables needing an update, and
> amdgpu_vm_update_pdes() tries to write its PDE. It has no parent page
> directory, so that fails, and fails again on every following submission o=
f the file.
>
> On navi48, submitting on a render node, then amdgpu_gpu_recover and
> submitting again, also with a new context:
>
>   amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
>   amdgpu 0000:03:00.0: GPU reset(1) succeeded!
>   WARNING: amdgpu_vm_pt.c:671 at
> amdgpu_vm_pde_update+0x329/0x5d0 [amdgpu], CPU#0: vmreinit/2629
>   Call Trace:
>    amdgpu_vm_update_pdes+0x262/0x5e0 [amdgpu]
>    amdgpu_cs_ioctl+0x35c9/0x7a00 [amdgpu]
>    drm_ioctl_kernel+0x180/0x320 [drm]
>    drm_ioctl+0x530/0xcb0 [drm]
>
> and every command submission fails with -EINVAL from then on.
>
> Don't look at the BO type. Give the PDs and PTs, which
> amdgpu_bo_create_vm() creates, a destroy function of their own and tell
> them by it, like the user and SVM BOs are told by theirs. The TMA BO stay=
s a
> kernel BO which userspace can't mmap.
>
> v2: Keep the TMA BO a kernel BO, userspace must not be able to mmap it
>     (Christian). Instead let the creator of the vm_bo tell whether it is
>     a PD/PT, with a page_table flag in struct amdgpu_vm_bo_base next to
>     the other bools, so the struct doesn't grow. Fixes the commit that
>     added the TMA BO.
> v3: Drop the flag, give the PDs/PTs a destroy function of their own and
>     identify them by it, like the user and SVM BOs (Christian).
>
> Fixes: 8a93aae9896b ("drm/amdgpu: Add CWSR infrastructure for user
> queues")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 22
> ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  2 +-
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6aa895f63aea..d4651f2d437c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -71,6 +71,12 @@ static void amdgpu_bo_destroy(struct
> ttm_buffer_object *tbo)
>       kvfree(bo);
>  }
>
> +/* A function of its own, the page tables are told apart by it */
> +static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo) {
> +     amdgpu_bo_destroy(tbo);
> +}
> +
>  static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)  {
>       struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(tbo); @@ -94,6 +100,7
> @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
> bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)  {
>       if (bo->destroy =3D=3D &amdgpu_bo_destroy ||
> +         bo->destroy =3D=3D &amdgpu_bo_vm_destroy ||
>           bo->destroy =3D=3D &amdgpu_bo_user_destroy ||
>           bo->destroy =3D=3D &svm_range_bo_destroy)
>               return true;
> @@ -101,6 +108,20 @@ bool amdgpu_bo_is_amdgpu_bo(struct
> ttm_buffer_object *bo)
>       return false;
>  }
>
> +/**
> + * amdgpu_bo_is_vm_bo - check if the buffer object is a page directory
> +or table
> + * @bo: buffer object to be checked
> + *
> + * Uses the destroy function amdgpu_bo_create_vm() sets for the object.
> + *
> + * Returns:
> + * true if the object is a PD or PT of a VM, false if not.
> + */
> +bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo) {
> +     return bo->tbo.destroy =3D=3D &amdgpu_bo_vm_destroy; }
> +
>  /**
>   * amdgpu_bo_placement_from_domain - set buffer's placement
>   * @abo: &amdgpu_bo buffer object whose placement is to be set @@ -
> 813,6 +834,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>        * num of amdgpu_vm_pt entries.
>        */
>       BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
> +     bp->destroy =3D &amdgpu_bo_vm_destroy;
>       r =3D amdgpu_bo_create(adev, bp, &bo_ptr);
>       if (r)
>               return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 2e6a8e6f577a..8e67a8e60572 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -254,6 +254,7 @@ static inline bool amdgpu_bo_encrypted(struct
> amdgpu_bo *bo)  }
>
>  bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
> +bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo);
>  void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32
> domain);
>
>  int amdgpu_bo_create(struct amdgpu_device *adev, diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a2814830dd2b..d5d9e2587661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -162,7 +162,7 @@ amdgpu_vm_bo_lock_lists(struct
> amdgpu_vm_bo_base *vm_bo)
>               /* No extra locking needed, protected by the root PD resv l=
ock
> */
>               amdgpu_vm_assert_locked(vm);
>
> -             if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
> +             if (amdgpu_bo_is_vm_bo(bo))
>                       return &vm->kernel;
>
>               return &vm->always_valid;
> --
> 2.50.1

