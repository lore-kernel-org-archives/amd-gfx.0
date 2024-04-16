Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44A2C00A94
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 02:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C242112959;
	Tue, 16 Apr 2024 02:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ZOI9+ok";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD8E112959
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 02:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5Vay5z0o8mnQPsP6bGFHi1/PrFj8QHq+eja3FdykSt4Y2FhB+BzmJ8oUOTcgptm45gIgImiL9GPXS9waO/qyBS4at5izrx7fQznRalA8UjygwkZoOJGx3XcpGNTyqT5kEnjvheSnXKU1r5/Hvz64MjV8Q0G6Ji3Itu7pUyaUCK/aYW4niedeAsrSYLUUf1xx07IJ00vTx2Nuse03M3tGt6tGp/fV1JWUiXk6v5uPArYaXM3cV7ZC1BLAqgHvbjdMpwv0dNnoGD/W09GjfQQYyybXf/dcU5OyWCjZSb/YRLPkBHoYOQeDEP1AADMrHuS+sYayUiZgCZl/rrOFzXh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t6HuqbOxIW2Y4t6iuFqzChrmLFnWYi1mq6bgWjXa10=;
 b=Slgc1Nl9g1xwlBsE6dgLlaG4rISgfHU6IsCcOmPKrZU3QXc7ptaLQbUweSUY3XAVc5aG4/YgTtJBHhQxXVRL6s9cg5tj6ri0PkuhP81RvmTHxcl6rC/9a+owASXOtjebY5mPk0dvtIqfv6Mr8lXM5iSlAw32IiHsmD68lwwu0A7aZmp/LJqcbOb78d2A0FcB2a8vg7PpbCtjrf9RVo7f+W2XHuR2u8cuX8PSMTXwX0wGgF3b2zs1Rk3VgGHb5fqrqE+N6Sra7dqLyffW3xy0Y30+an2EtKuHpXEBsP7LStkdz1m/CqkNIjYN8q04QmMlj51w+VbOOrLZ73/kaL2w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t6HuqbOxIW2Y4t6iuFqzChrmLFnWYi1mq6bgWjXa10=;
 b=1ZOI9+oksn2GST/fuhKJD+OPnejnwfQD//PXgQuyudfAj3ejqAiJBo48LKB9dAwoSjGUn+OTq5r//UxYNYk8++CLIVpu4upbamuvUGi6akJwFg5B2i8iSDhtYqYdj+/wFUz34Lt8pFE61McsbO/l8oNAcDBPeQ016XxwBEVFUkk=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 02:05:04 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::d6a1:3931:bca2:6f07%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:05:04 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: make sure VM is ready for updating
 operations
Thread-Topic: [PATCH v2] drm/amdkfd: make sure VM is ready for updating
 operations
Thread-Index: AQHai+fVX+wtBUFVm0m1AzThQR/+drFqLR2A
Date: Tue, 16 Apr 2024 02:05:04 +0000
Message-ID: <MW6PR12MB8898F0B4C9E26188E8FE69D5FB082@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240411081101.3883715-1-Lang.Yu@amd.com>
In-Reply-To: <20240411081101.3883715-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=eb7e8961-7a51-4d6f-b768-4b82b44dd43d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-16T02:05:00Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|CH3PR12MB7643:EE_
x-ms-office365-filtering-correlation-id: 03d2a616-87b1-4ec5-bbbf-08dc5db9a1ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: texjWiaot6aWCsfhA5fG0sRun+raWyGYkZIyyeoxKB7himOrKOJIkAoqa9eDmvZBZW+tjJahKeU0ZlWbNkxD2dWQn3jpHNyK4/6oGjOEz1W+gUoxfkMhLrmn9ofxC/XVhlsM4B934/5G8RsHe81GJcJi0x4oABMODAbQUVigs+U3JcwUNpH9fm2xhLoMDiYKx1X1UzUZwwSBUEeFSLTyhsPyl50mM8ZHHJ/YIrVZM30b8NZG1K/ndLAGhvc87FKXYSAp0uk/mMoQfM4wrsCAz59bXAFoeAZ3UhR4I8o02oacfnJvGmMAgk6v9nyMA5ZTKEY/9vo0nybw94JcpCKGcTMm5fpojDW/783bAvc4vlDQhayOAybbnleyxy1e/IYHLO1H4cihUyNu8EFRjvukK1mfeqZtGXPl5IpPf6zXVae2LIDLgG8YxfHiWPnXzuqhfaPxbKxB2EmK0p0KJw6l5RgTeCBwuFsO9YMMQdB70t6uUAglpUe0KCl9I+Mf0aso8uwlAGnMoEp2iPMxjmhau+vwshv1WCWn+RqLIiUSytLO1A8BZkgN2yE4MOFJ9pfoSVwcA9UBQq+GvFSsLgEfJYjtF9ty3EmuAkJfqmhNrcHroh+WE7Y3YnrzE7GSfcjh2vQbmFU2vyTXEw80dESsJue/4/y0HFXjDi8PSQGR2uBBaZfKYMsrls8SgBVHh01wQoB5gSRNy+fF8RV9ZW79mC3UhLIH7D1Vpz96gcMuedk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6SlKXEmXQLi56tfAgF4nghvnGj4krO0vhUIveD5Hbk6zdHO/CQYdDXA/gFss?=
 =?us-ascii?Q?OBYdvK7D9xEbp1gtyYZ1xYWYb20QmkUWV+u+o0ZoRcs4b4IpEWxDH5g8DjSG?=
 =?us-ascii?Q?v8DzJvUHw2Y6FnFWb8ND1wXCWav/5D/N5X0UrwhPl5Rw5615eXXREFJIGKOP?=
 =?us-ascii?Q?1NyjjrKOcTWKnqwjC8TTmNhPPVIAvlfZ9vHcqLm3Sk9bhdw2QX2AQwQpEXgc?=
 =?us-ascii?Q?EiaghHi1VqWHyeDXRIDnc9FKi88ruMVhw/00VyhKzLkvveyKx32wVKFZ0Z4N?=
 =?us-ascii?Q?u/TN9VvWcE5uMU0a8tcezk5qGquhuPAadUvWWY3n0pATv5meppw2JqjFiUMe?=
 =?us-ascii?Q?3Ufj/OiH5GJO3Jp+T/MfkQB2sOl+NxmGnPqAuNQfcGk1Ycb3pmSx6udZrqi0?=
 =?us-ascii?Q?AhH0PLTrCV234/Mlj5EfNtvKpVhQNnxtMa/fNZnqndH9jek8T8Go6YJbSUKk?=
 =?us-ascii?Q?18yk92hYTObVkBKyTgR6gbr4ezZXtd6HtqrW2L9CVGO2ZeK+WrDO5l3D1UfF?=
 =?us-ascii?Q?ke3/S3U1Y5kZ415CP9ClPS1LxTp1uAo66AoHCBGQFyxyzUbm86Ieao2caZDP?=
 =?us-ascii?Q?iBO2TR7lK2C6zaHlEobAtYgjj5ngE4tmY5Bd95L0DHXhc8JL9LVjyCwOWicG?=
 =?us-ascii?Q?2PBi/ozj3XEyov1ZYdCLWRTrUPJjaZIoLEbHqLymViZ3U0Q9IeZLSQFeXMEe?=
 =?us-ascii?Q?mWYv2Vw8+1PHgOZfesFHjuxT8zDEhK/SNeVfKT9q8uGm+3UjeXuvHKYG2JVS?=
 =?us-ascii?Q?3LW9aO5Ms3ruzUMA7jkMxjUjwe9O9CZ/odAsSjQ4Jl+Dw8rS5xhrmeaj1b4z?=
 =?us-ascii?Q?FWdBIDBYObBTBGs34L9WBZb+YqWSIEKrhsBH2i9QZCQNSKRLCMpCvuBa0Moy?=
 =?us-ascii?Q?ZtO+UiZGniRdn3VwoeLqQds0TZ487FD7ro1E/5oQ804e60KfdzeDC6eHtbmQ?=
 =?us-ascii?Q?Ytq70+TynZ35d0gqCKxexurk+7gxHd78/oyam7u0Ude6iXMuJjF/xT4UjsVj?=
 =?us-ascii?Q?uGigxPfGlu8KXnAM2VrmkmOOhfONbBGlu4CQnjiZdI1zXvh8V7EkYdEP4Vpf?=
 =?us-ascii?Q?TPmuLjpFtkIaBnH89tK9m0DMuHQbEqgtWhsRHFzLLR+WqI4HVXH0aR/+2+Qt?=
 =?us-ascii?Q?oBG8oSQ91z/Vnobi6FWuWQmFFP2Qsv8VOn+igfbMp4+WnL7qDBhN7/wlDZVV?=
 =?us-ascii?Q?Al7oqt633BUAxMNCANBKjhDpNZ1sqidoFYezhr62VXAD9KNu6t0ujUG5ZlTN?=
 =?us-ascii?Q?PURt6wxSkCd0OIfgVSkDg+YdChhzOEzyueTdGnYMm+pKi+Y52eOQdBJbdmOC?=
 =?us-ascii?Q?HW/6B5I2NFSXIcMLofo1TQhPNX/jW12MaQJ2y5HgYf9MWr0jbNDTs0wGfavS?=
 =?us-ascii?Q?F3K917mpqFbxhVsbcd8aV/cWdp+vCHd2bL9amOnJ2WCQMX+pfRDnQdsdo7yz?=
 =?us-ascii?Q?lD0YwLMqrEY2O3MmjhbZEhJ8WlJ4M1XuLbgeZcZz+QgYAWumpLQWd1Tf2KYU?=
 =?us-ascii?Q?qnf1xlpRUhq0WQcBBq6RCPGEIJz8/GuVrjWpNJI9lorSV306m7KyZBn5mlPc?=
 =?us-ascii?Q?UxDBsyZMg27CGNCUwxk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d2a616-87b1-4ec5-bbbf-08dc5db9a1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:05:04.2008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wi6TPfmYuJkRHck/wFzZgyCP6AO8MlCxBRg+jj8wbOmBsWwj3W7kjC+9OpZFcV2fJYNElqNWGnCXJHHgnX2yrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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

[Public]

ping

>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Thursday, April 11, 2024 4:11 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
><Felix.Kuehling@amd.com>; Yu, Lang <Lang.Yu@amd.com>
>Subject: [PATCH v2] drm/amdkfd: make sure VM is ready for updating
>operations
>
>When page table BOs were evicted but not validated before updating page
>tables, VM is still in evicting state, amdgpu_vm_update_range returns -EBU=
SY
>and restore_process_worker runs into a dead loop.
>
>v2: Split the BO validation and page table update into two separate loops =
in
>amdgpu_amdkfd_restore_process_bos. (Felix)
>  1.Validate BOs
>  2.Validate VM (and DMABuf attachments)
>  3.Update page tables for the BOs validated above
>
>Fixes: 2fdba514ad5a ("drm/amdgpu: Auto-validate DMABuf imports in
>compute VMs")
>
>Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>---
> .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 +++++++++++----
>----
> 1 file changed, 20 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>index 0ae9fd844623..e2c9e6ddb1d1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>@@ -2900,13 +2900,12 @@ int
>amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>__rcu *
>
>       amdgpu_sync_create(&sync_obj);
>
>-      /* Validate BOs and map them to GPUVM (update VM page tables).
>*/
>+      /* Validate BOs managed by KFD */
>       list_for_each_entry(mem, &process_info->kfd_bo_list,
>                           validate_list) {
>
>               struct amdgpu_bo *bo =3D mem->bo;
>               uint32_t domain =3D mem->domain;
>-              struct kfd_mem_attachment *attachment;
>               struct dma_resv_iter cursor;
>               struct dma_fence *fence;
>
>@@ -2931,6 +2930,25 @@ int
>amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>__rcu *
>                               goto validate_map_fail;
>                       }
>               }
>+      }
>+
>+      if (failed_size)
>+              pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size=
);
>+
>+      /* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
>+       * validations above would invalidate DMABuf imports again.
>+       */
>+      ret =3D process_validate_vms(process_info, &exec.ticket);
>+      if (ret) {
>+              pr_debug("Validating VMs failed, ret: %d\n", ret);
>+              goto validate_map_fail;
>+      }
>+
>+      /* Update mappings managed by KFD. */
>+      list_for_each_entry(mem, &process_info->kfd_bo_list,
>+                          validate_list) {
>+              struct kfd_mem_attachment *attachment;
>+
>               list_for_each_entry(attachment, &mem->attachments, list) {
>                       if (!attachment->is_mapped)
>                               continue;
>@@ -2947,18 +2965,6 @@ int
>amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>__rcu *
>               }
>       }
>
>-      if (failed_size)
>-              pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size=
);
>-
>-      /* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
>-       * validations above would invalidate DMABuf imports again.
>-       */
>-      ret =3D process_validate_vms(process_info, &exec.ticket);
>-      if (ret) {
>-              pr_debug("Validating VMs failed, ret: %d\n", ret);
>-              goto validate_map_fail;
>-      }
>-
>       /* Update mappings not managed by KFD */
>       list_for_each_entry(peer_vm, &process_info->vm_list_head,
>                       vm_list_node) {
>--
>2.25.1

