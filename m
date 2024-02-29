Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C945C54798
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 06:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E14E10E02D;
	Thu, 29 Feb 2024 06:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ejh6BPlR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA17710E02D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 06:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJX9iZdxaNVs737jbk9fmlkiO/KDscC0PKVvbUMfFS/cOBNLzhVTgsVYCiIsfQ7S11BjriBVFKa/E85mPwx80ofhVFjLimIqMZHGSa1Gy5sIemQyBpZqBIavpJjwzXsEWl3WiSo37qAjFHoEjxWoqXmgqDoKKVFKnWsDjP/F9lCg+6AjXB/IU4XXbQ6Pottpt6z5bLr1kyNtZ+TAI6VrdnVTd+DWMUOJzvqR8az1u+Yta/PaICI3TVMVONA5OEMmP6MPXh6lGaVcE0g/ZOWL3VUQ+eCm6v4erCIqqi6Yy8Y4r7zhEM3sly+AFX3yHtzXdKNYYEYUyg+9Q9S79Zy/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73jFvMsDHMhlgvmaO6tkFCyBlgPiWxwFGdoxgcYYPWY=;
 b=i3jHj7o4fxCU8MzPNOor9EF3iaWAdvirjMuH8WM7phz/jTf0ufti9o9mk68OzvbMbpEZameDmzBOvGTkP98GxYgvFQgY0eKnbz2joAKM4HN8QnIcOLA1pNe+nNxZI5Rj3FlUvEK9l+sccwrLptN7dOEfzOs8R9kyAfgqhhWVWbPd9NMVf47CXk205xbzZ3yYBKP8MhStXON8kVf1MVT8Wz7utzyia6kblf1VDh+SNp2M3qKA2q3Mwt+qZsfa/b6iyXe3X25lVnTWIS3GxqHoqYNXKVWxigy4HgIhS3DfyPRXa3pAsKz93CI6ZIX4AJId90PmEY1pWk85LbGWzQB8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73jFvMsDHMhlgvmaO6tkFCyBlgPiWxwFGdoxgcYYPWY=;
 b=Ejh6BPlR8yQuzU0QlJj9uMvapYBiiDRRhmAtuuswR8fJnZupf1HfL8J9Oq97CmjXXs3s+vx3/UGgntG3ICxl50Kc6LpQL3kEBXfCRSapYnUzbZ/2Co/EDFWbcO79YiRPh8tFApLUtXyNM+lNzqf9SfqehY8Opfo11Z6fw4CZhu4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 06:01:53 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1332:95d4:ebd6:74c8]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1332:95d4:ebd6:74c8%3]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 06:01:53 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Paneer Selvam, Arunpravin"
 <Arunpravin.PaneerSelvam@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH V3] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Thread-Topic: [PATCH V3] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Thread-Index: AQHaatNXucqJGpTwUEmPAUDCVEOKP7Eg07vA
Date: Thu, 29 Feb 2024 06:01:52 +0000
Message-ID: <DM4PR12MB5152FEB1A0123986597BDF71E35F2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240229055124.2094798-1-Jesse.Zhang@amd.com>
In-Reply-To: <20240229055124.2094798-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90eea789-3c1a-4f4c-927d-136179b52522;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-29T06:01:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB6934:EE_
x-ms-office365-filtering-correlation-id: 8960695f-8e4d-4381-91e9-08dc38ebed57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3DztTxDK3Du9+ACZn2aLuykfYp3RRWDpB2WgpuisbcWYABzS6WK2TpN2jKAQIfe+s1RrufLzLnXDOaOkP+2AC6DPRScLhi3uw38UBp+QlG/8GSio0O82uyXgXpj5nkUeqVNIhQy3gDnYqz1YFZh6ZO4z0hlkByu1Em00BiL0JPQUGGqXZueI/+mIxD/sToCrw8x/TAvJxoHHPb5sK9axQSvRAtjaCIixAIASViNtdHdtvYmA2KiJ8s3CI6A//+twz40iQGbeyZa7lMltOjRc7F3G9J0SKEHqnrgMjhOafvk8dBiNv3ONbSxQC/oYsG4nL6asKvWLeXc+dsJ2KLxz200Ma1g4WZvNWkJu+V0KYMlt6kKtkmtxI8kwkQHJ1BUJKUvADlXxhFRSK2cbI1N9NFzV2UeszSE7UdJyGXtpuqObmtApZjAdW4iHM9tysnpaCKK00Vu1+pzSoCAd37tQMhEuieHi831arYsw016l4u1UcAeAQ7wDjNjEzD/yRB8i4dcuOGqXpsuc2TBisJoSDZqycyovhRmC11HHaiQ8N79qW8/RYryc3EOMf/BOwJPfRVlkxntYmPQ9+w9+cIYlOVibDXb9vuuK3QrEU0eZjFUejoUIQ8iJ3IcdyRfuxN5Fz3VxOYR+dqsKRtV9RLWvG8u8wtrJfTCnPj8x+diNlIhESZnPxBs2V8WvI7B+smknUPhV1MFBLZZZSdw6j3tmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2laQ+xHZcnz8DkQ+Hdw15ooh0IcfMD/znxRXuzWfJ2NWF3lkNHEJVd0vtD2?=
 =?us-ascii?Q?7kANz6du00cOBTfqxDkj2dMcux5vz/JaMlqBItpcDe23bKoSp4SQye7a6a7B?=
 =?us-ascii?Q?UDTULnb1+7o710Yhl6wYr31sOC6D/4UI99NO7QNC3p0ogZvFbxvbQgQBP0QV?=
 =?us-ascii?Q?rCT9IpBk1Cjf7PiKf0cE/5qMwI8vJnfn8mdMZDKi507hQ72ByWhN6NFcpyVc?=
 =?us-ascii?Q?QLw1khxIVAcEudmj6lzkNm7xsyv/DBZcsk7FpXDy0eOTdHIXocoYIoTlbGsa?=
 =?us-ascii?Q?cSFK8Pph63f6VSZ5q5VnxjQAZBq2J9ktxyAuEDCzjEnp6uVMInYejGRJr4RG?=
 =?us-ascii?Q?b9HPRslr8dcCIHYPpStGkBk8Nrm85aXhsRSB/NFbInfTkXYWHf0Y/NPySCZM?=
 =?us-ascii?Q?zx2dC56fr4TcpOn2FIKjr721TMgfWUCLQGDy17yPxjbOdJvL67D0ZyOCEIjM?=
 =?us-ascii?Q?m5M3T3yXYOY/IUjYeU3OmsGftLhLOAkZO5mj7JhN8mlTnzLunqwYeVBORe5Q?=
 =?us-ascii?Q?KsJDvS/JLg2/6fNdQBSirwciBFp/PmsW2WFaey5zpWKc5itTlZtzGKIYgAtH?=
 =?us-ascii?Q?FzIQUG9U647l5/xpgr/tCrpAYy67ee4UYjmeN7528o4KBM9vKhZ3zlM4Ps9e?=
 =?us-ascii?Q?5huKUqkJw0gG11RaklC5+OifQvLUlVLGML7S9h/eCauuTr2xYtyd8o9EGvuj?=
 =?us-ascii?Q?95PgVJfoRSOBqz+pCOGQmDR5DAq/bcUaSdiRGOuYpz9yZ/llCTcFuIRxf/8q?=
 =?us-ascii?Q?FSbmH+6lCCLrXvHlH9j7EIDQ65Eaozwc+u7S1br9uz/KQEGhb1q9+XJzZtS7?=
 =?us-ascii?Q?hWto/D0ImcP/uUwOdWbTDp3kCwPJj11wmDyTfo23It1FjoE8/+UC+g+SOPYz?=
 =?us-ascii?Q?nzfE2cjjfHENFpUIgcWqfQlVte2vkjcdTg+/Q4r3nmQse8bVZluXO7F7jmxm?=
 =?us-ascii?Q?mXPQEA+A8rO7sJyFwcNujzIZhii7/4l8/nLrzzmTYSQT6m/rXk6Wsz4B5HFt?=
 =?us-ascii?Q?X4xzk1dptxu4iJ85kelxv7420EwNU6uYkjJSS1V+vYbhMd5aTn513nYUaVN2?=
 =?us-ascii?Q?PaSsM7lxLJ1dawhxprKeVrgNYazFNBqtGI8wMIrOdKJ0TCTE/np/D+6MtUf8?=
 =?us-ascii?Q?wwrwWNMCQNqnRqO87bWKkt1T/8K1zpOGo4pC9Q/JrmEkOLTep46gRPFhwoIk?=
 =?us-ascii?Q?+LD/8y2OMnKzGfzIfxg949ZU9awVIqMRncMkh5WLL3wnehawpzKK3AdKZTic?=
 =?us-ascii?Q?khpBXTVQL9N5i6W/Iq40fj3ZvyCdWhSw+sXr9qDkAjPEcClTHC1Sl8kGFhaL?=
 =?us-ascii?Q?Rp4xKrIhYS286qKShY2j41Z4WWZovojmo5Me/lypSpyOLXQ0Yc1sLGoGqftk?=
 =?us-ascii?Q?9Pti7GN0m15wNv+3kP8EQXi+xFE6ucyv4vd2vfdUvb/ld7RMqpfwpQ/vb1aJ?=
 =?us-ascii?Q?4HkoSidZ+Rs8X1luFqPqO5MS66pkXXW/pvlUWv/GcB7NuahI6ulGfIK4P+hh?=
 =?us-ascii?Q?7g0yN5UI3jK/RKai0idbZyWpRjFy0t76IcBGSXVCui1nJvLoVIUuLkDe5qF/?=
 =?us-ascii?Q?j2k8eakpiI61BC7ITEs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8960695f-8e4d-4381-91e9-08dc38ebed57
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 06:01:52.9677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRVDNsZR/p1y6oX2FfqHa0sJRRGaIfOUGPgVdnCiVh5qX0EGc5HY9jLIJh5Su1eKjtjXLmV0xgTdEAv9CHFcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

[AMD Official Use Only - General]

Please ignore the patch and will send a new patch out soon.

-----Original Message-----
From: Jesse.Zhang <Jesse.Zhang@amd.com>
Sent: Thursday, February 29, 2024 1:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.c=
om>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@am=
d.com>
Subject: [PATCH V3] Revert "drm/amdgpu: remove vm sanity check from amdgpu_=
vm_make_compute" for Raven

fix the issue:
"amdgpu: Failed to create process VM object".

[Why]when amdgpu initialized, seq64 do mampping and update bo mapping in vm=
 page table.
But when clifo run. It also initializes a vm for a process device through t=
he function kfd_process_device_init_vm and ensure the root PD is clean thro=
ugh the function amdgpu_vm_pt_is_root_clean.
So they have a conflict, and clinfo  always failed.

 v1:
    - remove all the pte_supports_ats stuff from the amdgpu_vm code (Felix)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 23 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 55 +----------------------
 3 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index ed4a8c5d26d7..d004ace79536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1385,10 +1385,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev=
,
                        struct amdgpu_bo_va_mapping, list);
                list_del(&mapping->list);

-               if (vm->pte_support_ats &&
-                   mapping->start < AMDGPU_GMC_HOLE_START)
-                       init_pte_value =3D AMDGPU_PTE_DEFAULT_ATC;
-
                r =3D amdgpu_vm_update_range(adev, vm, false, false, true, =
false,
                                           resv, mapping->start, mapping->l=
ast,
                                           init_pte_value, 0, 0, NULL, NULL=
, @@ -2264,7 +2260,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
        if (r)
                return r;

-       vm->pte_support_ats =3D false;
        vm->is_compute_context =3D false;

        vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode & @@ =
-2350,30 +2345,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct =
amdgpu_vm *vm,
  */
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *v=
m)  {
-       bool pte_support_ats =3D (adev->asic_type =3D=3D CHIP_RAVEN);
        int r;

        r =3D amdgpu_bo_reserve(vm->root.bo, true);
        if (r)
                return r;

-       /* Check if PD needs to be reinitialized and do it before
-        * changing any other state, in case it fails.
-        */
-       if (pte_support_ats !=3D vm->pte_support_ats) {
-               /* Sanity checks */
-               if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
-                       r =3D -EINVAL;
-                       goto unreserve_bo;
-               }
-
-               vm->pte_support_ats =3D pte_support_ats;
-               r =3D amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root=
.bo),
-                                      false);
-               if (r)
-                       goto unreserve_bo;
-       }
-
        /* Update VM state */
        vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                    AMDGPU_VM_USE_CPU_FOR_COMPUTE); diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_vm.h
index 42f6ddec50c1..9f6b5e1ccf34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -357,9 +357,6 @@ struct amdgpu_vm {
        /* Functions to use for VM table updates */
        const struct amdgpu_vm_update_funcs     *update_funcs;

-       /* Flag to indicate ATS support from PTE for GFX9 */
-       bool                    pte_support_ats;
-
        /* Up to 128 pending retry page faults */
        DECLARE_KFIFO(faults, u64, 128);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
index a160265ddc07..f07255532aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -89,22 +89,6 @@ static unsigned int amdgpu_vm_pt_num_entries(struct amdg=
pu_device *adev,
        return AMDGPU_VM_PTE_COUNT(adev);
 }

-/**
- * amdgpu_vm_pt_num_ats_entries - return the number of ATS entries in the =
root PD
- *
- * @adev: amdgpu_device pointer
- *
- * Returns:
- * The number of entries in the root page directory which needs the ATS se=
tting.
- */
-static unsigned int amdgpu_vm_pt_num_ats_entries(struct amdgpu_device *ade=
v) -{
-       unsigned int shift;
-
-       shift =3D amdgpu_vm_pt_level_shift(adev, adev->vm_manager.root_leve=
l);
-       return AMDGPU_GMC_HOLE_START >> (shift + AMDGPU_GPU_PAGE_SHIFT);
-}
-
 /**
  * amdgpu_vm_pt_entries_mask - the mask to get the entry number of a PD/PT
  *
@@ -394,27 +378,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
        }

        entries =3D amdgpu_bo_size(bo) / 8;
-       if (!vm->pte_support_ats) {
-               ats_entries =3D 0;
-
-       } else if (!bo->parent) {
-               ats_entries =3D amdgpu_vm_pt_num_ats_entries(adev);
-               ats_entries =3D min(ats_entries, entries);
-               entries -=3D ats_entries;
-
-       } else {
-               struct amdgpu_vm_bo_base *pt;
-
-               pt =3D ancestor->vm_bo;
-               ats_entries =3D amdgpu_vm_pt_num_ats_entries(adev);
-               if ((pt - to_amdgpu_bo_vm(vm->root.bo)->entries) >=3D
-                   ats_entries) {
-                       ats_entries =3D 0;
-               } else {
-                       ats_entries =3D entries;
-                       entries =3D 0;
-               }
-       }
+       ats_entries =3D 0;

        r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
        if (r)
@@ -445,23 +409,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
                goto exit;

        addr =3D 0;
-       if (ats_entries) {
-               uint64_t value =3D 0, flags;
-
-               flags =3D AMDGPU_PTE_DEFAULT_ATC;
-               if (level !=3D AMDGPU_VM_PTB) {
-                       /* Handle leaf PDEs as PTEs */
-                       flags |=3D AMDGPU_PDE_PTE;
-                       amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
-               }
-
-               r =3D vm->update_funcs->update(&params, vmbo, addr, 0,
-                                            ats_entries, value, flags);
-               if (r)
-                       goto exit;
-
-               addr +=3D ats_entries * 8;
-       }

        if (entries) {
                uint64_t value =3D 0, flags =3D 0;
--
2.34.1

