Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4398C4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 14:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3666F10EB24;
	Fri, 12 Jan 2024 14:48:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D1E10EB24
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 14:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMmgCPze9b9d5WaK6AE4bWIL+UvZ0bmv42POQFAgItmkpwvNa+yU3T9E+4XhSdFtbQg9oM1A6CSQwqRdIBfmMF2fYh6BXLFXf78g2K20zyIbBanc/99Jd0pcdhs3m2e6bx1FEZHyZh+wspE/r+SNKTWN86p7kP2QG4VGG33fLZM5IDtMsnE0tPFDu10OQuXP4aVTDK2oRH8ZUS6U0IoT9G6eX1IWDaAF4OgsGpsXQCa1EA+mStCDff+kPVUCTEHkvt1GvJ4QxayYrlBmd1gpVhRQ2qZdW1AM6/gJlE63DF+SO3kH89/cLH8IUmtHMvifAJsZ9a4OCNZ2BSOFKg4Ybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dCcGS7woJhf7rSPwLTRb6axytQ46+MNnQTqtwvcM8A=;
 b=lBwW0S9fC16mCt7PprDogyV4/7I+guxOqRWmYAMIqH1LkIodQdCYY4/A/XyPPewVTnlge4BkM585P5aAIK/nhnHHED0ir/NcalDNoeac0q0Stlpm/I2xweM2PTeKJGVuvXlMSdc2om6UWYOQeCbM5JQbvL9gOXMS+c/qikkm4u+nZIqfTvVOAm1+3bXcLFXT7AbjPz7otog/VIh8NI0I8PlnOv/FaCMDV0SeAg4J7hjGJbCsunLE424+RGF1UbMYMOzIm9B8Ohwp+lfgA4SEYHn/6V5z1SScfgT3Rd6ivbWpluxqYQTe/s6kSuB5YndBtuvvmukHr9fsrXlECHR7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dCcGS7woJhf7rSPwLTRb6axytQ46+MNnQTqtwvcM8A=;
 b=FxV9cLXGbMxKtdUF37QAUJXiPQyjctRmdCKPftVf1NgSFlNMc6je+aKAedWhmEqzEuo+hka4lyNotYu2kzlmEYRUOQgbsiZVI7DGNATnPqikO1wXpkGSY9jo7SWDCmuCbCuEcA/mzeGVWnVrpUv4J2UnhSs+3ee8Yonx0xXohJ0=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 14:48:49 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::1571:1de1:6cc4:d26e]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::1571:1de1:6cc4:d26e%7]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 14:48:49 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: reserve the BO before validating it
Thread-Topic: [PATCH] drm/amdkfd: reserve the BO before validating it
Thread-Index: AQHaRF76llEZPMP5AkCoMK4x922hH7DUyyMAgAElJQA=
Date: Fri, 12 Jan 2024 14:48:49 +0000
Message-ID: <e0849195-a85a-4969-83c9-451db40177a9@amd.com>
References: <20240111072221.90774-1-Lang.Yu@amd.com>
 <d111de60-8bc9-4fd8-aca7-6c539362d9d9@amd.com>
In-Reply-To: <d111de60-8bc9-4fd8-aca7-6c539362d9d9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-12T14:48:48.765Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
x-ms-exchange-imapappendstamp: SN7PR12MB7202.namprd12.prod.outlook.com
 (15.20.7181.004)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|PH8PR12MB7352:EE_
x-ms-office365-filtering-correlation-id: a4bd332e-09fb-4408-a0d7-08dc137d9633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6W6wf7wVOYv5AAF+F5toO+vOzLVz/8z9I5UY9epOE49U/1/yy3x/8PcJMdbVsvxMZMi6cGFF/KeEKXSsg0Ctz2rnmS/+OXYX66tkg0ikeW8hB6R8xlZ92K1Y8BHuOtgLtxvYXMSUG5+jR+/2IrqXDL4LI4fqxHhTUW3HXQdMw8nDNEWCLCtr9CDlniEug+EP1JM/nVambL42V4nFws4PqjpATPHehA92dhsUcp2ngL2ZCMtZNG0nMBM8E9NmlUQnp6hhKilAjz5HaHrmnNhfpAhmxW1MSZ/0W6LUrnV0vOxQlxANBwPPaO9EBlMddIURtw+SGqyOjFWCv+C8SxcbRPGY6SRpsPuP5ApfcmHmBANeQwRBAKxFs+9D9+CxnWqe2jBoeHOiOuVEG6A60703SK7OZbFYkX60OIdvfKgn0iyLmFUYchQezm+hm9MOhFWlf85ZmuJvZbClUnEkA2qorGJJVZGzu9U8pjU1a5qbB7LKRL6t2WQSSs8wHUJUu4K4sFDwGLsNLeAF561NrgkNoBJNeKdWROKQON7hV64+sAMD30TJkkmavD1KwxH4qm7EAzMBUfM7IemyT3vUISjYurzXhawr6P8bm/eSR5pKu26+7Kdol86ywA3L97ky2bv2ehNFWFQAeRrNG2i508JLJm+4LixnLrep4WNqL581bkTyW1v6nFKg/yIvPAeeJF3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(186009)(451199024)(2906002)(5660300002)(38070700009)(41300700001)(6486002)(2616005)(38100700002)(99936003)(83380400001)(478600001)(966005)(122000001)(71200400001)(8936002)(53546011)(6512007)(6506007)(31686004)(26005)(31696002)(91956017)(66446008)(8676002)(4326008)(66946007)(64756008)(36756003)(110136005)(76116006)(66476007)(86362001)(66556008)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hCcYAsQOb4PwwYZWCdSdEZi4F5eLwFQib7kjd2SfuJf3TPhZ02VNjfHLnJ?=
 =?iso-8859-1?Q?fbBZVj+y3f2s9rSChJfrODQmK6Gb/HnsV39ZrJ4uHL5cCszn78UZu/KDvM?=
 =?iso-8859-1?Q?HfrcY2nVWv8mXKqXPUYBnAQRfmDi0vSmKoIfZhdKIf3Lc9/U0oMTAlzFIU?=
 =?iso-8859-1?Q?gfy5Q7lwJ4/wP1H/CRccJ1OBtcJzZfy5LgcNlu8cSRIF7uhN7KhjEyqu5O?=
 =?iso-8859-1?Q?jiUx4f8kmSACUClOXcZCDUTH0l+hrYK08fni9wpG+DyrCUIBO/+4qfblaD?=
 =?iso-8859-1?Q?fgLrjBqseKhqfw5Ez9Dzam2uvkeFoC+SZfmzF25wsyINwaUNk5BQt1VBp3?=
 =?iso-8859-1?Q?S9AUG0nkeGtfGXiCKHf0vUWWA7P9lEs+VNmBFMCj1TyHwX5lD1pLnfhWvY?=
 =?iso-8859-1?Q?fB0YbS8a6nS45mmujxzZJKNPgBrx4fHXfFwe0nKfG8FodlhYRnuIB4Q25S?=
 =?iso-8859-1?Q?e1kGCZnDRxKZba8kahbBBcoIlrI8RVL7CDYouuieaielwsZu7+EBeebJVG?=
 =?iso-8859-1?Q?bfjKfQHLLXER4qpwcCmLNSL/67ETZzM4gMDl6nC1zGzu+mW2bb0g4vK5H0?=
 =?iso-8859-1?Q?NIJ0dtQqIREnHz6osFPd/0Q0//F5I6R+kgmxHvGilFwsXzvq9w/HH5YKeW?=
 =?iso-8859-1?Q?hGpE7WixsVrmkkFwGajLkfe0jZ2HC71wa2xKdjiEtGe+umcfiIy2BuRnHp?=
 =?iso-8859-1?Q?oBLD2XSfs+aNXAwsHF5VKJUhF2Es0/5VfEOETVsZJP8+va7Lxx4Z/6pzCf?=
 =?iso-8859-1?Q?Dl1/ajFAV9IqFJcp5DDpxjH120c2xcqP6n8GQ5A6XaTGDNuzRRioGH5WYH?=
 =?iso-8859-1?Q?+GGqaqc76dUgsbjecbpL3fjmhFregdbIToF4Cq1zvIxuBsgvuWzaNIvRRR?=
 =?iso-8859-1?Q?SbkBIsQ1IpSxq2shLlIPjZOffuX+9dShzirJXitgzdfgCXzKHc/gDWFMJh?=
 =?iso-8859-1?Q?7z2lgODPqQCZpn9+6wuvoxR00vtzpGDirsUAsuN8FCisQXw8wOwoAj3ubX?=
 =?iso-8859-1?Q?DdZdASE73HnyzrgHlbtaSjXPsEP4M92/vEbRfL1l3Sof6xIx05WBTm0zHL?=
 =?iso-8859-1?Q?LCxYt4hlLVdQRyWTZcCHR6afPw3Bh1eQRhgI04RzQ79LaKEPoWFa+S04so?=
 =?iso-8859-1?Q?QIGISJvHeHVVe7if/QdG2ywBnaUgf37gJ8CUShV2MRRMSxqK6NYM3lstJ5?=
 =?iso-8859-1?Q?fy5nZMdDUtvgQtHDwjIYoVUeDWZb1yrDQn7HO69h3ke22oUQqcdvfxRznM?=
 =?iso-8859-1?Q?FAogZd797Y2R0RglH5f4SaQG/k83bp9sX5z/Z3quKscdUf8ORoBzIUA8Pn?=
 =?iso-8859-1?Q?jtii8K/Def7HTYsmfUECuhY/E1D6EnJcu0tCOketCpj7L1Kr1rEG1ZkYbM?=
 =?iso-8859-1?Q?O80Krf4QMPT3wv2YMzN6ydvVBXDhAYl2JiFak4+XJmPgp0jp3t1N2oW20Z?=
 =?iso-8859-1?Q?EowYIns8rKvQzvlEEzBEgr+EL2nbq088CWILZu8o0VL0cwTXp4PzKUIFZu?=
 =?iso-8859-1?Q?KUl+g2ZzICo3//EMyNbyOKpV0GGornSrSXFpKURfUHsCu6e0O5RHsWmmBv?=
 =?iso-8859-1?Q?fKnAxKVyo6J04kDfn36pYjX5YdLvio3yWcuB4y+oAIIAy0A6iGjWrV9wvc?=
 =?iso-8859-1?Q?CmMhP/7Btsf50=3D?=
Content-Type: multipart/mixed;
 boundary="_002_e0849195a85a496983c9451db40177a9amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bd332e-09fb-4408-a0d7-08dc137d9633
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 14:48:49.0972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACr6JWu27Jjtk1WdhSPehZaxIvPeHOpJDFAeV55sqayJY3QT6rjeB50eiHZBAOQu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_e0849195a85a496983c9451db40177a9amdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EE4B9C534307AE43B2D93F41FDDC4270@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

On 2024-01-11 11:19, Felix Kuehling wrote:
> On 2024-01-11 02:22, Lang Yu wrote:
>> Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB flush")
>>
>> [   41.708711] WARNING: CPU: 0 PID: 1463 at
>> drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
>> [   41.708989] Call Trace:
>> [   41.708992]  <TASK>
>> [   41.708996]  ? show_regs+0x6c/0x80
>> [   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>> [   41.709008]  ? __warn+0x93/0x190
>> [   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>> [   41.709024]  ? report_bug+0x1f9/0x210
>> [   41.709035]  ? handle_bug+0x46/0x80
>> [   41.709041]  ? exc_invalid_op+0x1d/0x80
>> [   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
>> [   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
>> [   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
>> [   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
>> [   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
>> [   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
>> [   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80 [amdgpu]
>> [   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
>> [   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
>> [   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10
>> [amdgpu]
>> [   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
>> [   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
>> [   41.709959]  __x64_sys_ioctl+0x9c/0xd0
>> [   41.709967]  do_syscall_64+0x3f/0x90
>> [   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 48697b789342..f5542a4ab8ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2095,8 +2095,13 @@ void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct
>> kgd_mem *mem, void *drm_priv)
>>       mutex_lock(&mem->lock);
>>         list_for_each_entry(entry, &mem->attachments, list) {
>> -        if (entry->bo_va->base.vm =3D=3D vm)
>> +        if (entry->bo_va->base.vm !=3D vm)
>> +            continue;
>> +
>> +        if (!WARN_ON(amdgpu_bo_reserve(entry->bo_va->base.bo, true))) {
>>               kfd_mem_dmaunmap_attachment(mem, entry);
>> +            amdgpu_bo_unreserve(entry->bo_va->base.bo);
>> +        }
>
> I'm pretty sure someone else worked on a fix for this before. This is
> not a good solution. We need to handle failed reservations (due to
> ERESTARTSYS) and make sure that the unmap ioctl can be restarted
> correctly in that case.
>
> See
> https://lore.kernel.org/amd-gfx/530aac57-5561-4d1d-879a-93b108e5c8c2@gmai=
l.com/
>
> David, do you have any update on this work?
>
I tried to solve this same problem.

After feedback from November's post, I updated my patch.

In testing, I found that my patch (attached to avoid cluttering this
thread and to make clear the patch is not ready for primetime) causes
lockdep to emit possible circular dependency warnings, so I haven't
pursued it any further.

> Regards,
>   Felix
>
>
>>       }
>>         mutex_unlock(&mem->lock);

--_002_e0849195a85a496983c9451db40177a9amdcom_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-Acquire-ttm-locks-for-dmaunmap.patch"
Content-Description: 0001-drm-amdgpu-Acquire-ttm-locks-for-dmaunmap.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Acquire-ttm-locks-for-dmaunmap.patch"; size=4304;
	creation-date="Fri, 12 Jan 2024 14:48:37 GMT";
	modification-date="Fri, 12 Jan 2024 14:48:37 GMT"
Content-ID: <E82220D5D4EE6A49BC8B82A71419E107@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64

RnJvbSA1ZjAwZWY0NTE4YWUxOTcxZjJjZDMxYTg5YTY0NzM4MGI0OWZiZTQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBGcmFuY2lzIDxEYXZpZC5GcmFuY2lzQGFtZC5jb20+
CkRhdGU6IFRodSwgNSBPY3QgMjAyMyAxMTozNjowNiAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IEFjcXVpcmUgdHRtIGxvY2tzIGZvciBkbWF1bm1hcAoKZG1hdW5tYXAgY2FuIGNh
bGwgdHRtX2JvX3ZhbGlkYXRlLCB3aGljaCBleHBlY3RzIHRoZQp0dG0gZG1hX3Jlc3YgdG8gYmUg
aGVsZC4KCkFjcXVpcmUgdGhlIGxvY2tzIGluIGFtZGdwdV9hbWRrZmRfZ3B1dm1fZG1hdW5tYXBf
bWVtLgoKQmVjYXVzZSB0aGUgZG1hdW5tYXAgc3RlcCBjYW4gbm93IGZhaWwsIGl0IGlzIG5vdyBu
ZWNlc3NhcnkgdG8KdHJhY2sgd2hpY2ggYXR0YWNobWVudHMgaGF2ZSBhbmQgaGF2ZSBub3QgYmVl
biBkbWF1bm1hcHBlZC4KClRoaXMgZmFpbHVyZSBjYW4gYWxzbyBjYXVzZSB0aGUgc3luY19tZW1v
cnkgc3RlcCBvZiB0aGUgaW9jdGwKdG8gYmUgcmVwZWF0ZWQ7IGl0IGlzIGlkZW1wb3RlbnQsIHNv
IHRoaXMgc2hvdWxkIG5vdCBjYXVzZSBhbnkgaXNzdWVzLgoKU2lnbmVkLW9mZi1ieTogRGF2aWQg
RnJhbmNpcyA8RGF2aWQuRnJhbmNpc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCAgICAgfCAgMyArKy0KIC4uLi9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jICAgfCAxOCArKysrKysrKysrKysrKystLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgICAgICAgfCAgNyArKysrKystCiAz
IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCmluZGV4IDNhZDhkYzUyM2I0Mi4u
YWVlZDZhODkzOTAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5oCkBAIC01OCw2ICs1OCw3IEBAIHN0cnVjdCBrZmRfbWVtX2F0dGFjaG1lbnQgewogCXN0cnVj
dCBsaXN0X2hlYWQgbGlzdDsKIAllbnVtIGtmZF9tZW1fYXR0YWNobWVudF90eXBlIHR5cGU7CiAJ
Ym9vbCBpc19tYXBwZWQ7CisJYm9vbCBpc19kbWFtYXBwZWQ7CiAJc3RydWN0IGFtZGdwdV9ib192
YSAqYm9fdmE7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXY7CiAJdWludDY0X3QgdmE7CkBA
IC0zMDIsNyArMzAzLDcgQEAgaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX21lbW9yeV90b19n
cHUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCSAgc3RydWN0IGtnZF9tZW0gKm1l
bSwgdm9pZCAqZHJtX3ByaXYpOwogaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1fdW5tYXBfbWVtb3J5
X2Zyb21fZ3B1KAogCQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGtnZF9tZW0g
Km1lbSwgdm9pZCAqZHJtX3ByaXYpOwotdm9pZCBhbWRncHVfYW1ka2ZkX2dwdXZtX2RtYXVubWFw
X21lbShzdHJ1Y3Qga2dkX21lbSAqbWVtLCB2b2lkICpkcm1fcHJpdik7CitpbnQgYW1kZ3B1X2Ft
ZGtmZF9ncHV2bV9kbWF1bm1hcF9tZW0oc3RydWN0IGtnZF9tZW0gKm1lbSwgdm9pZCAqZHJtX3By
aXYpOwogaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1fc3luY19tZW1vcnkoCiAJCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qga2dkX21lbSAqbWVtLCBib29sIGludHIpOwogaW50IGFt
ZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX2d0dF9ib190b19rZXJuZWwoc3RydWN0IGtnZF9tZW0gKm1l
bSwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0u
YwppbmRleCA1NGYzMWE0MjAyMjkuLmMwNWFjZDk5YzI1YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwpAQCAtMjA4MSw2ICsyMDgxLDcg
QEAgaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX21lbW9yeV90b19ncHUoCiAJCX0KIAogCQll
bnRyeS0+aXNfbWFwcGVkID0gdHJ1ZTsKKwkJZW50cnktPmlzX2RtYW1hcHBlZCA9IHRydWU7CiAJ
CW1lbS0+bWFwcGVkX3RvX2dwdV9tZW1vcnkrKzsKIAkJcHJfZGVidWcoIlx0IElOQyBtYXBwaW5n
IGNvdW50ICVkXG4iLAogCQkJIG1lbS0+bWFwcGVkX3RvX2dwdV9tZW1vcnkpOwpAQCAtMjEwMiwy
MSArMjEwMywzMiBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9tYXBfbWVtb3J5X3RvX2dwdSgK
IAlyZXR1cm4gcmV0OwogfQogCi12b2lkIGFtZGdwdV9hbWRrZmRfZ3B1dm1fZG1hdW5tYXBfbWVt
KHN0cnVjdCBrZ2RfbWVtICptZW0sIHZvaWQgKmRybV9wcml2KQoraW50IGFtZGdwdV9hbWRrZmRf
Z3B1dm1fZG1hdW5tYXBfbWVtKHN0cnVjdCBrZ2RfbWVtICptZW0sIHZvaWQgKmRybV9wcml2KQog
ewogCXN0cnVjdCBrZmRfbWVtX2F0dGFjaG1lbnQgKmVudHJ5OwogCXN0cnVjdCBhbWRncHVfdm0g
KnZtOworCWludCByZXQ7CiAKIAl2bSA9IGRybV9wcml2X3RvX3ZtKGRybV9wcml2KTsKIAogCW11
dGV4X2xvY2soJm1lbS0+bG9jayk7CiAKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGVudHJ5LCAmbWVt
LT5hdHRhY2htZW50cywgbGlzdCkgewotCQlpZiAoZW50cnktPmJvX3ZhLT5iYXNlLnZtID09IHZt
KQorCQlpZiAoZW50cnktPmJvX3ZhLT5iYXNlLnZtID09IHZtICYmIGVudHJ5LT5pc19kbWFtYXBw
ZWQpIHsKKwkJCXJldCA9IGFtZGdwdV9ib19yZXNlcnZlKGVudHJ5LT5ib192YS0+YmFzZS5ibywg
ZmFsc2UpOworCQkJaWYgKHJldCkgeworCQkJCWdvdG8gb3V0OworCQkJfQorCiAJCQlrZmRfbWVt
X2RtYXVubWFwX2F0dGFjaG1lbnQobWVtLCBlbnRyeSk7Ci0JfQorCQkJZW50cnktPmlzX2RtYW1h
cHBlZCA9IGZhbHNlOwogCisJCQlhbWRncHVfYm9fdW5yZXNlcnZlKGVudHJ5LT5ib192YS0+YmFz
ZS5ibyk7CisJCX0KKwl9CitvdXQ6CiAJbXV0ZXhfdW5sb2NrKCZtZW0tPmxvY2spOworCXJldHVy
biByZXQ7CiB9CiAKIGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX3VubWFwX21lbW9yeV9mcm9tX2dw
dSgKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCmluZGV4IDA2OTg4Y2Yx
ZGI1MS4uZDc1YzE4MWNiNzQ0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY2hhcmRldi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFy
ZGV2LmMKQEAgLTE0NDIsNyArMTQ0MiwxMSBAQCBzdGF0aWMgaW50IGtmZF9pb2N0bF91bm1hcF9t
ZW1vcnlfZnJvbV9ncHUoc3RydWN0IGZpbGUgKmZpbGVwLAogCQkJa2ZkX2ZsdXNoX3RsYihwZWVy
X3BkZCwgVExCX0ZMVVNIX0hFQVZZV0VJR0hUKTsKIAogCQkvKiBSZW1vdmUgZG1hIG1hcHBpbmcg
YWZ0ZXIgdGxiIGZsdXNoIHRvIGF2b2lkIElPX1BBR0VfRkFVTFQgKi8KLQkJYW1kZ3B1X2FtZGtm
ZF9ncHV2bV9kbWF1bm1hcF9tZW0obWVtLCBwZWVyX3BkZC0+ZHJtX3ByaXYpOworCQllcnIgPSBh
bWRncHVfYW1ka2ZkX2dwdXZtX2RtYXVubWFwX21lbShtZW0sIHBlZXJfcGRkLT5kcm1fcHJpdik7
CisJCWlmIChlcnIpIHsKKwkJCXByX2RlYnVnKCJETUEgdW5tYXBwaW5nIGZhaWxlZCwgYWNxdWly
ZSBpbnRlcnJ1cHRlZCBieSB1c2VyIHNpZ25hbFxuIik7CisJCQlnb3RvIGRtYXVubWFwX2ZhaWxl
ZDsKKwkJfQogCX0KIAogCW11dGV4X3VubG9jaygmcC0+bXV0ZXgpOwpAQCAtMTQ1NSw2ICsxNDU5
LDcgQEAgc3RhdGljIGludCBrZmRfaW9jdGxfdW5tYXBfbWVtb3J5X2Zyb21fZ3B1KHN0cnVjdCBm
aWxlICpmaWxlcCwKIGdldF9tZW1fb2JqX2Zyb21faGFuZGxlX2ZhaWxlZDoKIHVubWFwX21lbW9y
eV9mcm9tX2dwdV9mYWlsZWQ6CiBzeW5jX21lbW9yeV9mYWlsZWQ6CitkbWF1bm1hcF9mYWlsZWQ6
CiAJbXV0ZXhfdW5sb2NrKCZwLT5tdXRleCk7CiBjb3B5X2Zyb21fdXNlcl9mYWlsZWQ6CiAJa2Zy
ZWUoZGV2aWNlc19hcnIpOwotLSAKMi4zNC4xCgo=

--_002_e0849195a85a496983c9451db40177a9amdcom_--
