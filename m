Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E25C2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE8A206CB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XyYxArSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE8A206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855AB89D8E;
	Mon, 23 Dec 2019 19:45:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD1989A5D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 19:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbjC5aq5rnMmMBBH8nJ7QCFeVTN+IgEmdFR/s3qzVaHhFgf6Ef4gMFzhV3KKsN2AGnBva5EcU90HFT32TsE6467pXoT8rKvG6ltFjofQ7Sp4QdZqMJbggEYWxp4O+fM0DSJ+Z80lVPlf6D3F6rErjtvYE6PyW4S/CcJ5vEBvwePYZoGroj5LCzBN6XwI64tVCxVpCRtlwfoYodpLt7gxJ+QUPRQ8VHNwWYGYDcVa1tT6HEjJ1wTokzeb3ye7lPVwJAjB2qmllW9x1duIMlNtS7CCtPpYyqD61pA1k4hWW4h7P/Wb/yu1kuJDFIkcNPvYx2Ixdloy/K2WadIM6XOoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AEvobsB9W72s4bEklU4e5YJCdSMgIN9KDF5pi4Ga9k=;
 b=EB4npCiQKM9gA2fMU4K3AmGexXh5/F82SwbGe5/Q8RKjjmxLh1C7n2K09h+0RLjX4c1l3hPud9oiZyNB2NxwzR40NWsZUjRqkJ4C/Efa/oK8m8maTqVeHb2zr5HojObroEK/TBaOYOq8n9gmp1rgp6Rc/HL2kwxNYjUlWB0LqUOQLhjuP/7Q4ij3yst91FyWrIUVI+XmjTo6usiFBubq4t9aZt4sV21YkGlZo8iGByGjSKUKkuSZYBLfTRwWw2e8c/P9UAeSsnwWr49EazeciYiLk9r3otmwAcEMMc1MIrvH+e+9QjOzOzc7cVVlOQcc7FpsyqKGPI71SE90l15kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AEvobsB9W72s4bEklU4e5YJCdSMgIN9KDF5pi4Ga9k=;
 b=XyYxArSCoVTL5pEtXk64FEz8uZCFwJPQIOKKxUmbZXDOJyUaIB1k6flHSuZdcrP+DuYkQxFDKl7zTWGK4bWK+0VmGYfIkB1IofyFH8ECsx7tIaBvyuUKTCThKlvB9QyiUdKH7P65KTqKRxHOph+zKLnaw75TDt8egAeeCT6VZr0=
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0233.namprd12.prod.outlook.com (10.174.106.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.20; Mon, 23 Dec 2019 19:44:59 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 19:44:59 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Sierra Guiza, Alejandro
 (Alex)" <Alex.Sierra@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
Thread-Topic: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
Thread-Index: AQHVtv5Oq0z2plvJbUqPW9pFbKIjZKfDjNmA///R94CAAALzgIAEwDeAgAACpYk=
Date: Mon, 23 Dec 2019 19:44:58 +0000
Message-ID: <DM5PR1201MB01375C46A00662414CF4D2A5F02E0@DM5PR1201MB0137.namprd12.prod.outlook.com>
References: <20191220062442.33635-1-alex.sierra@amd.com>
 <20191220062442.33635-3-alex.sierra@amd.com>
 <41542c9c-a668-0a4b-1f3f-9b38c8e48d12@amd.com>
 <69ea408a-1f03-a6f4-34be-193bb5a17dec@amd.com>
 <e244e704-1020-6a11-705d-3a84dd2c01b5@amd.com>,
 <dec1e07f-c4ca-a683-224b-286b1edaaeea@amd.com>
In-Reply-To: <dec1e07f-c4ca-a683-224b-286b1edaaeea@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-23T19:44:56.637Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb0ab1e8-df2d-423a-e118-08d787e09828
x-ms-traffictypediagnostic: DM5PR1201MB0233:|DM5PR1201MB0233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB023338F1C6F91020156B830AF02E0@DM5PR1201MB0233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(91956017)(76116006)(86362001)(33656002)(966005)(71200400001)(478600001)(66946007)(6506007)(45080400002)(186003)(9686003)(64756008)(66446008)(53546011)(7696005)(4001150100001)(55016002)(26005)(66476007)(66556008)(316002)(110136005)(52536014)(81156014)(5660300002)(8936002)(81166006)(8676002)(2906002)(19627405001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0233;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCLleiCBkayBshfIDpeAtrHTff2lUgFda75/pLAlewXbmtnXwb/QKbDxiyL/xCVGkXGofkhjZETXupzJKEHtLoMKWzgTVrkhLJZ7I61tyyQJ4IIfrnjSj5sEJCaY8u5tBmX2TR/ZiPRapnUfDVV8wRfy0Ql7lI85M3Dz0rDv95JVgA65ehlVwLKznzdYxlcRxsZriGFSTpOeMyvz0qkmKCk83mZZ0jjIhGkdg2jVFbnSTZlt9tLWVuITVdEcJndg9AmFO8YSgMfcycunmXdOl/1JUQP8bebXrlwUlanfnj8tFH5hCYYazL9OSvQMuniT+Jc+V9dnNESZF/1AoylmFrU/DOXtDkHqIU9aimWECETEd/KQdAkKudpzO0SUmevEJ/aL9MQdfDWP86v9FGZr075hIa2JOsEkTA4+jFf6HJ12CAcTHDCPvYl+aHNzKZc/kZPT/aZ3G/jIUmN/A3vcEOcOwBdXD0HhPFYO7pHcw4w=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0ab1e8-df2d-423a-e118-08d787e09828
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 19:44:58.9915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TtJPvRIhQxRapELGj5ZQKCdAJqnd81Q7UtVXDPq3uKOEnKAkkPAOGA08UZAXY4T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0233
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
Content-Type: multipart/mixed; boundary="===============2146169103=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2146169103==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB01375C46A00662414CF4D2A5F02E0DM5PR1201MB0137_"

--_000_DM5PR1201MB01375C46A00662414CF4D2A5F02E0DM5PR1201MB0137_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

True. There indeed are two vmhubs on Navi. So my two comments are not usefu=
l here.

Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Monday, December 23, 2019 2:34 PM
To: Zhao, Yong <Yong.Zhao@amd.com>; Sierra Guiza, Alejandro (Alex) <Alex.Si=
erra@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org=
>
Subject: Re: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdk=
fd


On 2019-12-20 7:01 p.m., Yong Zhao wrote:
>
> On 2019-12-20 6:50 p.m., Yong Zhao wrote:
>> Inline.
>>
>> On 2019-12-20 4:35 p.m., Felix Kuehling wrote:
>>> On 2019-12-20 1:24, Alex Sierra wrote:
>>>> [Why]
>>>> TLB flush method has been deprecated using kfd2kgd interface.
>>>> This implementation is now on the amdgpu_amdkfd API.
>>>>
>>>> [How]
>>>> TLB flush functions now implemented in amdgpu_amdkfd.
>>>>
>>>> Change-Id: Ic51cccdfe6e71288d78da772b6e1b6ced72f8ef7
>>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>>
>>> Looks good to me. See my comment about the TODO inline.
>>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32
>>>> ++++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  8 ++++--
>>>>   3 files changed, 39 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> index d3da9dde4ee1..b7f6e70c5762 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> @@ -634,6 +634,38 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct
>>>> amdgpu_device *adev, u32 vmid)
>>>>       return false;
>>>>   }
>>>>   +int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd,
>>>> uint16_t vmid)
>>>> +{
>>>> +    struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
>>>> +    /* TODO: condition missing for FAMILY above NV */
>>>
>>> I'm not sure what's missing here. NV and above don't need any
>>> special treatment. Since SDMA is connected to GFXHUB on NV, only the
>>> GFXHUB needs to be flushed.
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> +    if (adev->family =3D=3D AMDGPU_FAMILY_AI) {
>>>> +        int i;
>>>> +
>>>> +        for (i =3D 0; i < adev->num_vmhubs; i++)
>>>> +            amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
>>>> +    } else {
>>>> +        amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
>>>> +    }
>>
>> This if else can be unified by
>>
>> for (i =3D 0; i < adev->num_vmhubs; i++)
>>
>>     amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
>>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd,
>>>> uint16_t pasid)
>>>> +{
>>>> +    struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
>>>> +    uint32_t flush_type =3D 0;
>>>> +    bool all_hub =3D false;
>>>> +
>>>> +    if (adev->gmc.xgmi.num_physical_nodes &&
>>>> +        adev->asic_type =3D=3D CHIP_VEGA20)
>>>> +        flush_type =3D 2;
>>>> +
>>>> +    if (adev->family =3D=3D AMDGPU_FAMILY_AI)
>>>> +        all_hub =3D true;
>>>> +
>>>> +    return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type,
>>>> all_hub);
> The all_hub parameter can be inferred from num_vmhubs in
> flush_gpu_tlb_pasid(), so it can be optimized out here.

Hi Yong,

This is incorrect. NV has two VM hubs: GFXHUB and MMHUB. But KFD doesn't
care about MMHUB on Navi because SDMA is connected to the GFXHUB.
Therefore the all_hub parameter should not be based on the num_vmhubs.
We need a special case for NV.

Or rather the special case could be AI, where SDMA is not connected to
GFXHUB. So only on AI we need to flush all hubs for KFD VMs.

Regards,
   Felix

>>>> +}
>>>> +
>>>>   bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
>>>>   {
>>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index 069d5d230810..47b0f2957d1f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -136,6 +136,8 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev
>>>> *kgd, enum kgd_engine_type engine,
>>>>                   uint32_t *ib_cmd, uint32_t ib_len);
>>>>   void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
>>>>   bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
>>>> +int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t
>>>> vmid);
>>>> +int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd,
>>>> uint16_t pasid);
>>>>     bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32
>>>> vmid);
>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index 536a153ac9a4..25b90f70aecd 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -32,6 +32,7 @@
>>>>   #include <linux/mman.h>
>>>>   #include <linux/file.h>
>>>>   #include "amdgpu_amdkfd.h"
>>>> +#include "amdgpu.h"
>>>>     struct mm_struct;
>>>>   @@ -1152,16 +1153,17 @@ int kfd_reserved_mem_mmap(struct kfd_dev
>>>> *dev, struct kfd_process *process,
>>>>   void kfd_flush_tlb(struct kfd_process_device *pdd)
>>>>   {
>>>>       struct kfd_dev *dev =3D pdd->dev;
>>>> -    const struct kfd2kgd_calls *f2g =3D dev->kfd2kgd;
>>>>         if (dev->dqm->sched_policy =3D=3D KFD_SCHED_POLICY_NO_HWS) {
>>>>           /* Nothing to flush until a VMID is assigned, which
>>>>            * only happens when the first queue is created.
>>>>            */
>>>>           if (pdd->qpd.vmid)
>>>> -            f2g->invalidate_tlbs_vmid(dev->kgd, pdd->qpd.vmid);
>>>> +            amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->kgd,
>>>> +                            pdd->qpd.vmid);
>>>>       } else {
>>>> -        f2g->invalidate_tlbs(dev->kgd, pdd->process->pasid);
>>>> +        amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
>>>> +                        pdd->process->pasid);
>>>>       }
>>>>   }
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong=
.zhao%40amd.com%7C3a33649d2a804998d00408d785a7776f%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637124827007059728&amp;sdata=3DfNTunmAJObxfgbJBlNWWXuc=
yH9ezedLv%2BrqnMTz3Ai4%3D&amp;reserved=3D0
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong.=
zhao%40amd.com%7C3a33649d2a804998d00408d785a7776f%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637124827007059728&amp;sdata=3DfNTunmAJObxfgbJBlNWWXucy=
H9ezedLv%2BrqnMTz3Ai4%3D&amp;reserved=3D0
>>

--_000_DM5PR1201MB01375C46A00662414CF4D2A5F02E0DM5PR1201MB0137_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
True. There indeed are two vmhubs on Navi. So my two comments are not usefu=
l here.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Monday, December 23, 2019 2:34 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;; Sierra Guiza, Alejandro (A=
lex) &lt;Alex.Sierra@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdg=
pu_amdkfd</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 2019-12-20 7:01 p.m., Yong Zhao wrote:<br>
&gt;<br>
&gt; On 2019-12-20 6:50 p.m., Yong Zhao wrote:<br>
&gt;&gt; Inline.<br>
&gt;&gt;<br>
&gt;&gt; On 2019-12-20 4:35 p.m., Felix Kuehling wrote:<br>
&gt;&gt;&gt; On 2019-12-20 1:24, Alex Sierra wrote:<br>
&gt;&gt;&gt;&gt; [Why]<br>
&gt;&gt;&gt;&gt; TLB flush method has been deprecated using kfd2kgd interfa=
ce.<br>
&gt;&gt;&gt;&gt; This implementation is now on the amdgpu_amdkfd API.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [How]<br>
&gt;&gt;&gt;&gt; TLB flush functions now implemented in amdgpu_amdkfd.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Change-Id: Ic51cccdfe6e71288d78da772b6e1b6ced72f8ef7<br>
&gt;&gt;&gt;&gt; Signed-off-by: Alex Sierra &lt;alex.sierra@amd.com&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Looks good to me. See my comment about the TODO inline.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32 <br=
>
&gt;&gt;&gt;&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; =
2 &#43;&#43;<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp=
; |&nbsp; 8 &#43;&#43;&#43;&#43;--<br>
&gt;&gt;&gt;&gt; &nbsp; 3 files changed, 39 insertions(&#43;), 3 deletions(=
-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c <b=
r>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt;&gt;&gt;&gt; index d3da9dde4ee1..b7f6e70c5762 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd=
.c<br>
&gt;&gt;&gt;&gt; @@ -634,6 &#43;634,38 @@ bool amdgpu_amdkfd_is_kfd_vmid(st=
ruct <br>
&gt;&gt;&gt;&gt; amdgpu_device *adev, u32 vmid)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&gt;&gt;&gt; &nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; &#43;int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kg=
d_dev *kgd, <br>
&gt;&gt;&gt;&gt; uint16_t vmid)<br>
&gt;&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (st=
ruct amdgpu_device *)kgd;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* TODO: condition missing for FAM=
ILY above NV */<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I'm not sure what's missing here. NV and above don't need any =
<br>
&gt;&gt;&gt; special treatment. Since SDMA is connected to GFXHUB on NV, on=
ly the <br>
&gt;&gt;&gt; GFXHUB needs to be flushed.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; &nbsp; Felix<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (adev-&gt;family =3D=3D AMDGPU_=
FAMILY_AI) {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D=
 0; i &lt; adev-&gt;num_vmhubs; i&#43;&#43;)<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc=
_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; This if else can be unified by<br>
&gt;&gt;<br>
&gt;&gt; for (i =3D 0; i &lt; adev-&gt;num_vmhubs; i&#43;&#43;)<br>
&gt;&gt;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp; amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev =
*kgd, <br>
&gt;&gt;&gt;&gt; uint16_t pasid)<br>
&gt;&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (st=
ruct amdgpu_device *)kgd;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; uint32_t flush_type =3D 0;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; bool all_hub =3D false;<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical=
_nodes &amp;&amp;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;a=
sic_type =3D=3D CHIP_VEGA20)<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_type=
 =3D 2;<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (adev-&gt;family =3D=3D AMDGPU_=
FAMILY_AI)<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; all_hub =
=3D true;<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return amdgpu_gmc_flush_gpu_tlb_pa=
sid(adev, pasid, flush_type, <br>
&gt;&gt;&gt;&gt; all_hub);<br>
&gt; The all_hub parameter can be inferred from num_vmhubs in <br>
&gt; flush_gpu_tlb_pasid(), so it can be optimized out here.<br>
<br>
Hi Yong,<br>
<br>
This is incorrect. NV has two VM hubs: GFXHUB and MMHUB. But KFD doesn't <b=
r>
care about MMHUB on Navi because SDMA is connected to the GFXHUB. <br>
Therefore the all_hub parameter should not be based on the num_vmhubs. <br>
We need a special case for NV.<br>
<br>
Or rather the special case could be AI, where SDMA is not connected to <br>
GFXHUB. So only on AI we need to flush all hubs for KFD VMs.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
&gt;&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &nbsp; bool amdgpu_amdkfd_have_atomics_support(struct kgd_=
dev *kgd)<br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h <b=
r>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt;&gt;&gt;&gt; index 069d5d230810..47b0f2957d1f 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd=
.h<br>
&gt;&gt;&gt;&gt; @@ -136,6 &#43;136,8 @@ int amdgpu_amdkfd_submit_ib(struct=
 kgd_dev <br>
&gt;&gt;&gt;&gt; *kgd, enum kgd_engine_type engine,<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *ib_cmd, uint32_t ib_=
len);<br>
&gt;&gt;&gt;&gt; &nbsp; void amdgpu_amdkfd_set_compute_idle(struct kgd_dev =
*kgd, bool idle);<br>
&gt;&gt;&gt;&gt; &nbsp; bool amdgpu_amdkfd_have_atomics_support(struct kgd_=
dev *kgd);<br>
&gt;&gt;&gt;&gt; &#43;int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *=
kgd, uint16_t <br>
&gt;&gt;&gt;&gt; vmid);<br>
&gt;&gt;&gt;&gt; &#43;int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev =
*kgd, <br>
&gt;&gt;&gt;&gt; uint16_t pasid);<br>
&gt;&gt;&gt;&gt; &nbsp; &nbsp; bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu=
_device *adev, u32 <br>
&gt;&gt;&gt;&gt; vmid);<br>
&gt;&gt;&gt;&gt; &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process=
.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt;&gt;&gt;&gt; index 536a153ac9a4..25b90f70aecd 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c=
<br>
&gt;&gt;&gt;&gt; @@ -32,6 &#43;32,7 @@<br>
&gt;&gt;&gt;&gt; &nbsp; #include &lt;linux/mman.h&gt;<br>
&gt;&gt;&gt;&gt; &nbsp; #include &lt;linux/file.h&gt;<br>
&gt;&gt;&gt;&gt; &nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt;&gt;&gt;&gt; &#43;#include &quot;amdgpu.h&quot;<br>
&gt;&gt;&gt;&gt; &nbsp; &nbsp; struct mm_struct;<br>
&gt;&gt;&gt;&gt; &nbsp; @@ -1152,16 &#43;1153,17 @@ int kfd_reserved_mem_mm=
ap(struct kfd_dev <br>
&gt;&gt;&gt;&gt; *dev, struct kfd_process *process,<br>
&gt;&gt;&gt;&gt; &nbsp; void kfd_flush_tlb(struct kfd_process_device *pdd)<=
br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev =3D pdd=
-&gt;dev;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; const struct kfd2kgd_calls *f2g =3D de=
v-&gt;kfd2kgd;<br>
&gt;&gt;&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;dqm-&gt;=
sched_policy =3D=3D KFD_SCHED_POLICY_NO_HWS) {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Nothing to flush until a VMID is assigned, which<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; * only happens when the first queue is created.<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; */<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(pdd-&gt;qpd.vmid)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; f2g-&gt;invalidate_tlbs_vmid(dev-&gt;kgd, pdd-&gt;qpd.vmid);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_amdkfd_flush_gpu_tlb_vmid(dev-&gt;kgd,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;qpd.vmid);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f2g-&gt;invali=
date_tlbs(dev-&gt;kgd, pdd-&gt;process-&gt;pasid);<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amd=
kfd_flush_gpu_tlb_pasid(dev-&gt;kgd,<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pdd-&gt;process-&gt;pasid);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; }<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;a=
mp;data=3D02%7C01%7Cyong.zhao%40amd.com%7C3a33649d2a804998d00408d785a7776f%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637124827007059728&amp;amp;sda=
ta=3DfNTunmAJObxfgbJBlNWWXucyH9ezedLv%2BrqnMTz3Ai4%3D&amp;amp;reserved=3D0"=
>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong=
.zhao%40amd.com%7C3a33649d2a804998d00408d785a7776f%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637124827007059728&amp;amp;sdata=3DfNTunmAJObxfgbJBlNW=
WXucyH9ezedLv%2BrqnMTz3Ai4%3D&amp;amp;reserved=3D0</a>
<br>
&gt;&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;d=
ata=3D02%7C01%7Cyong.zhao%40amd.com%7C3a33649d2a804998d00408d785a7776f%7C3d=
d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637124827007059728&amp;amp;sdata=
=3DfNTunmAJObxfgbJBlNWWXucyH9ezedLv%2BrqnMTz3Ai4%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong=
.zhao%40amd.com%7C3a33649d2a804998d00408d785a7776f%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637124827007059728&amp;amp;sdata=3DfNTunmAJObxfgbJBlNW=
WXucyH9ezedLv%2BrqnMTz3Ai4%3D&amp;amp;reserved=3D0</a>
<br>
&gt;&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR1201MB01375C46A00662414CF4D2A5F02E0DM5PR1201MB0137_--

--===============2146169103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2146169103==--
