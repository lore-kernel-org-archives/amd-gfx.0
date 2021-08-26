Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D8C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B3A6109E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79B3A6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132636E834;
	Thu, 26 Aug 2021 12:42:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACFE6E834
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNnx/IK/8G1F6fMEWl7Oi6Zwl4vfEVc0GcHZyWmKPkXERZynI7sBWbrSpEh1+OS9pt6AyPtcsj+x+6l+Y/B9IDhCxJhUyzSO6xObl/UEnmSbelHocwyVFgoZGTIhXQVdtfciCzqOoIhOhjUJJXImFypv80KRJtk4fE+I35p27/a+9r4IUVV2yzL5EaonpkVRZMLWWQdjc8PYUgnoYIAPE2ucSg6WiSdpY7JPB1Ar07kM8sdILIqQNBlQFQDn0zBDa0GACGsZs0fih6MRMF9hnCTg+MFsvO0BPe0MyOizho6p53VxOVU6f6ZERrGn2I756gmo6anV9OcI5vZOfDImtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLxySMoW+KHgMJC5iF7eXeGuKBhPXLU57lIAn1CQQuE=;
 b=moMcggijk/padRvwMd5/cCL2heCapev5SrNPh+JgDIHGqSCni5Wu5enTnf1CFthSe19UCIBP9apTQjIO/aKUbpjNy5KVRktwXq27P84pie8+f9SBfjsM6tCuboDqzBWb8+tPPOLb6xcT1ReseqU1LlJavn9b7to16C9Xi861nB/OSQ6ciigB+ckwyc85MRK632IDreMDLRGpa6BygUbk1ZLbKUQc9gdm58UWOjaBKw+MWhnLw+tJ2K8I3K/k/fFv/ux2kdJ5zqTuT8dk4KKSCV+0GNVgqyhywLQ5SNDNnbiTy3RWFvwH9q6IeT2BfWcL1qRj45mFQEod2Dgq4ms74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLxySMoW+KHgMJC5iF7eXeGuKBhPXLU57lIAn1CQQuE=;
 b=fenxNuSLVg+dSti+IcUIjk8mepAn71c2tDOfydFwk/SW0+z9Tlp+2WpLWHs+GfsJ/5FZyp1NXPwyDx0us9I16rDoBxTLtSFMTFBv1qBSAkcArQg92bL6pFAhoWzl9EvB3ZyJZBVF8BajOlmr89Jlc3eVxOkeaobgwR6IrQHGTz4=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM5PR12MB1802.namprd12.prod.outlook.com (2603:10b6:3:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 12:28:17 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::d9bd:9fce:27a0:e1be%2]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 12:28:17 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
Thread-Topic: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
Thread-Index: AQHXmdZuCB+yjCUtWE2SNVzYjE2lt6uFs3wAgAAARLeAAAHCAIAAALxNgAABMQCAAABuiw==
Date: Thu, 26 Aug 2021 12:28:17 +0000
Message-ID: <DM6PR12MB3547902D3B388B2F5124E8BCF7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210825172659.247530-1-tom.stdenis@amd.com>
 <4f68568f-6f38-a36d-397b-c9d1d03cf9e2@amd.com>
 <DM6PR12MB3547D401A95FC5CB86595348F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
 <eec9d9d5-aff6-5344-b15b-155a46a57e76@amd.com>
 <DM6PR12MB35470F0FA108B66B49434B10F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
 <2ae34dc2-adb6-54e2-30bc-a9636e1fc41e@amd.com>
In-Reply-To: <2ae34dc2-adb6-54e2-30bc-a9636e1fc41e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-26T12:28:16.684Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c233e3a7-a903-4912-3d06-08d9688cfb6e
x-ms-traffictypediagnostic: DM5PR12MB1802:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1802BFD90CDC35D951D1C404F7C79@DM5PR12MB1802.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OM9rbfa0H21srxFAT2Xc6/zDqV5y6tnPZMx5XV9RiPyHySMAamQmCnou+UG2gWfYXkV/oIgF3XdMMbgRLSU+JJTstB2ApY433lYBZ0yGy5Zbdza5TREJN56RF7x1zYbto3hyUpsL6RIaIp3rpg+hayx6NVGHMGsOHVugtIZu2fECMPUCkscrzawAPFHeM2tvpQkexJY102/HTkKQ9JkUMsy32Z0xzPZ3u7yL3TfkXh6KVdIS6Y8N4oVlAxRdUk2Xig4/wsEymr10pIBX6M26Y7I2e9oFuIDpiwpwPWmg6JTp1BGQ90aXqE81KYaz5tjOKG8zqyB4FnHUo4KO9GYNu/OB0LQ8k247V924EiPn29VreC9nGA5fzUF9U1XrkeUNLVobaTVaqQCuZ9yE6SPtIbJv6KCwG0j8WyWWfvzb1QX8mLr6SJmdnAxbGWzHCyj4Mqr7a1WayzXw2bfrXyVcpVwLOmc2BnT6NLC3fAlc6/tTnqFP7H2d0yhjEXn8matCjRjaHTCSNcAN8n6EaIHBcUVbebELSJHjTg2VFOYhX/j/Ag4bf44Ptp8J/DFJTxpLMNMrbxNfIbsbrdDl3kt1hpg5fYulkgftGeREOrZyO6iC1XmLEOBwNGdF0KKlhNx2ER1rEcEX0vS0jz+7ynpiaslzCg6amq9zZNq6430Oj5YrhzXnrJMf9YBj9Y6I+YU/CYgxUjchMYHj9NOXwGupGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(33656002)(86362001)(316002)(508600001)(8936002)(53546011)(38100700002)(7696005)(186003)(110136005)(26005)(71200400001)(66556008)(83380400001)(122000001)(2906002)(6506007)(38070700005)(5660300002)(66446008)(52536014)(55016002)(66946007)(66476007)(76116006)(30864003)(91956017)(9686003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BAYJ9sQqWbCGGlRc02R+ayAZLRzplDW9Rwp4+Xq6YLJ2NsXwlB2BsHcrsf?=
 =?iso-8859-1?Q?8mBM4S/p4N5eDvYXbf72Ygwssslx3Cj/UGdHx9yblCrvuyaCRduLPJNCjl?=
 =?iso-8859-1?Q?n8jkA64SzkVkbwuwfSrgdLPCIUmTVvOsx5qRtybo3SkGwzlLaxuze0zi8C?=
 =?iso-8859-1?Q?Fa73AFsR9kXqm3RAEe8puO8kFRC959oryDE3P4jzqXyjEwcYR8vU4C8Clb?=
 =?iso-8859-1?Q?Igt1LV9+9PN7ACrxNEQWlaYxiu31W88dXgZFNJlRAO23PZf0b6INPoeCQT?=
 =?iso-8859-1?Q?OTqa85B8LA0LwqKu+Xrkxp3wDI8EaAxlHz8g0NwXJyIet2+7tMfNkYmA06?=
 =?iso-8859-1?Q?R6TomBG1Ihiw4n/4SWzJrfHdQjsdlfwUmUZX0iEijcaQLtHLwf4Is18GSM?=
 =?iso-8859-1?Q?hc4ayQ5RvSb69Eg+mnqeldS9Pu5zmlcwLpPK3dsBhXIVvUQSSrPKuIZJUH?=
 =?iso-8859-1?Q?tKwqugBKAQS4PoK6JuFtS128t8K85ZUkVR3udprJCHEz+edp0ueaPBcOaP?=
 =?iso-8859-1?Q?s76EoWx3T2NRgr6UWZRz9PUCPVnK5JHaF76WjpK/vjYf8yRJodS7Lp2H0u?=
 =?iso-8859-1?Q?QwBKUM8aJ1t8NI6Jj9Mw0Ib9ymlXgJFelmvEvLlXI5E/DdXJMJkppW9jR0?=
 =?iso-8859-1?Q?UQJPfBYF2H+Eo+qq/fn8HnEUAKkFxVWZyjayDEaAuik2l2uQdRSDolAZku?=
 =?iso-8859-1?Q?p8SDQb5rEDnpkYCYyzYyFfCYKgP/b5IdJ9HxzaDKRJpsYZb7jYenoVw461?=
 =?iso-8859-1?Q?4rRcfgiBMOV4WioKn/CUoDHalUy87uSK4/+MvewzUlDec3MDh1JwEHiXA7?=
 =?iso-8859-1?Q?5IA3/zOf1/WDNtMti08Me+Wg06c+cT0qWtogGiEGOSdvDsEc+q0pmjxjaW?=
 =?iso-8859-1?Q?xW9+rvcrKRJ3w6lDgz0ao39Ivqa/JsJwiF6lDa3QeNQjB8MwJbwFrXTYxp?=
 =?iso-8859-1?Q?rzrSyqoYnozVIJ0iialoFgfOspFM0jUeu2H7T8QyfD1DIcxmkmnoclOfKg?=
 =?iso-8859-1?Q?V3gIjeLaA3ErZ92ALpABdApu7OZK2RdClqTuLWcLdhsVQ+8jZOI3eWPquf?=
 =?iso-8859-1?Q?MWo0oJzzyDmM2jQt89ymqoDLMHFfiIKZWZKCybGo37M0UJws5o5eKdvrMB?=
 =?iso-8859-1?Q?Whvw7sKSSG+mNZ7YlrDWRXc+sXZvKJxwL4fsTqnGYfDeN7wpk/yP0vFHDG?=
 =?iso-8859-1?Q?tjeqNYtSXWjIhS7mUZHnlK2AwAvAdSeZruB+nCQNbFvaalSinmyP9UrI4D?=
 =?iso-8859-1?Q?nkAKJl4U6s6igBu3y6UPf4PX/HhSgaMbFVI7FfL3BmwkBlhkKvsaQFhOgb?=
 =?iso-8859-1?Q?WQskugKhPSiMkdUB1g5x9bGJ7xri7QGxMGV+WoJNU+2BeD8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c233e3a7-a903-4912-3d06-08d9688cfb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 12:28:17.1572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8vdARnGQRC8fbjWc+cZ5eUoZvv7lgFpbWBWx/3DznsS5ygRTc02dEuOVZ1Jw7pXLtd6aVxF4ZbQ/faslp0lug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1802
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

[AMD Official Use Only]

The state is set with one syscall and used with a different syscall.  They'=
re not atomic.

(I also don't see the need to bikeshed this anymore than we already have).

Tom

________________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, August 26, 2021 08:26
To: StDenis, Tom; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registe=
rs (v5)

Does that really need a lock? Can't local variables solve it?

Thanks,
Lijo

On 8/26/2021 5:52 PM, StDenis, Tom wrote:
> [AMD Official Use Only]
>
> The issue is someone can issue an ioctl WHILE a read/write is happening. =
 In that case a read could take a [say] SRBM lock but then never free it.
>
> Two threads racing operations WITH the lock in place just means the users=
pace gets undefined outputs which from the kernel is fine.
>
> Tom
>
> ________________________________________
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, August 26, 2021 08:19
> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO regis=
ters (v5)
>
> If there are two threads using the same fd, I don't see anything that
> prevent this order
>
>          set_state (T1) // State1
>          set_state (T2) // State2
>          read (T1)
>          write (T2)
>
> If there are separate fds, I guess the device level mutex takes care anyw=
ay.
>
> Thanks,
> Lijo
>
> On 8/26/2021 5:45 PM, StDenis, Tom wrote:
>> [AMD Official Use Only]
>>
>> While umr uses this as a constant two-step dance that doesn't mean anoth=
er user task couldn't misbehave.  Two threads firing read/write and IOCTL a=
t the same time could cause a lock imbalance.
>>
>> As I remarked to Christian offline that's unlikely to happen since umr i=
s the only likely user of this it's still ideal to avoid potential race con=
ditions as a matter of correctness.
>>
>> Tom
>>
>> ________________________________________
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 26, 2021 08:12
>> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO regi=
sters (v5)
>>
>>
>>
>> On 8/25/2021 10:56 PM, Tom St Denis wrote:
>>> This new debugfs interface uses an IOCTL interface in order to pass
>>> along state information like SRBM and GRBM bank switching.  This
>>> new interface also allows a full 32-bit MMIO address range which
>>> the previous didn't.  With this new design we have room to grow
>>> the flexibility of the file as need be.
>>>
>>> (v2): Move read/write to .read/.write, fix style, add comment
>>>          for IOCTL data structure
>>>
>>> (v3): C style comments
>>>
>>> (v4): use u32 in struct and remove offset variable
>>>
>>> (v5): Drop flag clearing in op function, use 0xFFFFFFFF for broadcast
>>>          instead of 0x3FF, use mutex for op/ioctl.
>>>
>>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 150 +++++++++++++++++=
+++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   1 -
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     |  51 +++++++
>>>     3 files changed, 201 insertions(+), 1 deletion(-)
>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 277128846dd1..87766fef0b1c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -36,6 +36,7 @@
>>>     #include "amdgpu_rap.h"
>>>     #include "amdgpu_securedisplay.h"
>>>     #include "amdgpu_fw_attestation.h"
>>> +#include "amdgpu_umr.h"
>>>
>>>     int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>>>     {
>>> @@ -279,6 +280,143 @@ static ssize_t amdgpu_debugfs_regs_write(struct f=
ile *f, const char __user *buf,
>>>         return amdgpu_debugfs_process_reg_op(false, f, (char __user *)b=
uf, size, pos);
>>>     }
>>>
>>> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file =
*file)
>>> +{
>>> +     struct amdgpu_debugfs_regs2_data *rd;
>>> +
>>> +     rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
>>> +     if (!rd)
>>> +             return -ENOMEM;
>>> +     rd->adev =3D file_inode(file)->i_private;
>>> +     file->private_data =3D rd;
>>> +     mutex_init(&rd->lock);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct fi=
le *file)
>>> +{
>>> +     kfree(file->private_data);
>>> +     return 0;
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *bu=
f, u32 offset, size_t size, int write_en)
>>> +{
>>> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>>> +     struct amdgpu_device *adev =3D rd->adev;
>>> +     ssize_t result =3D 0;
>>> +     int r;
>>> +     uint32_t value;
>>> +
>>> +     if (size & 0x3 || offset & 0x3)
>>> +             return -EINVAL;
>>> +
>>> +     r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>> +     if (r < 0) {
>>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +             return r;
>>> +     }
>>> +
>>> +     r =3D amdgpu_virt_enable_access_debugfs(adev);
>>> +     if (r < 0) {
>>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +             return r;
>>> +     }
>>> +
>>> +     mutex_lock(&rd->lock);
>>> +
>>> +     if (rd->id.use_grbm) {
>>> +             if ((rd->id.grbm.sh !=3D 0xFFFFFFFF && rd->id.grbm.sh >=
=3D adev->gfx.config.max_sh_per_se) ||
>>> +                 (rd->id.grbm.se !=3D 0xFFFFFFFF && rd->id.grbm.se >=
=3D adev->gfx.config.max_shader_engines)) {
>>> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
>>> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
>>> +                     amdgpu_virt_disable_access_debugfs(adev);
>>> +                     mutex_unlock(&rd->lock);
>>> +                     return -EINVAL;
>>> +             }
>>> +             mutex_lock(&adev->grbm_idx_mutex);
>>> +             amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
>>> +                                                             rd->id.gr=
bm.sh,
>>> +                                                             rd->id.gr=
bm.instance);
>>> +     }
>>> +
>>> +     if (rd->id.use_srbm) {
>>> +             mutex_lock(&adev->srbm_mutex);
>>> +             amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.=
srbm.pipe,
>>> +                                                                     r=
d->id.srbm.queue, rd->id.srbm.vmid);
>>> +     }
>>> +
>>> +     if (rd->id.pg_lock)
>>> +             mutex_lock(&adev->pm.mutex);
>>> +
>>> +     while (size) {
>>> +             if (!write_en) {
>>> +                     value =3D RREG32(offset >> 2);
>>> +                     r =3D put_user(value, (uint32_t *)buf);
>>> +             } else {
>>> +                     r =3D get_user(value, (uint32_t *)buf);
>>> +                     if (!r)
>>> +                             amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2=
, value);
>>> +             }
>>> +             if (r) {
>>> +                     result =3D r;
>>> +                     goto end;
>>> +             }
>>> +             offset +=3D 4;
>>> +             size -=3D 4;
>>> +             result +=3D 4;
>>> +             buf +=3D 4;
>>> +     }
>>> +end:
>>> +     if (rd->id.use_grbm) {
>>> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff);
>>> +             mutex_unlock(&adev->grbm_idx_mutex);
>>> +     }
>>> +
>>> +     if (rd->id.use_srbm) {
>>> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>>> +             mutex_unlock(&adev->srbm_mutex);
>>> +     }
>>> +
>>> +     if (rd->id.pg_lock)
>>> +             mutex_unlock(&adev->pm.mutex);
>>> +
>>> +     mutex_unlock(&rd->lock);
>>> +
>>> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +
>>> +     amdgpu_virt_disable_access_debugfs(adev);
>>> +     return result;
>>> +}
>>> +
>>> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cm=
d, unsigned long data)
>>> +{
>>> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>>> +     int r;
>>> +
>>> +     switch (cmd) {
>>> +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>>> +             mutex_lock(&rd->lock);
>>> +             r =3D copy_from_user(&rd->id, (struct amdgpu_debugfs_regs=
2_iocdata *)data, sizeof rd->id);
>>> +             mutex_unlock(&rd->lock);
>>
>> As this is a two-step read/write, I don't think there is any protection
>> offered by having this mutex.
>>
>> Thanks,
>> Lijo
>>
>>> +             return r ? -EINVAL : 0;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *=
buf, size_t size, loff_t *pos)
>>> +{
>>> +     return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char _=
_user *buf, size_t size, loff_t *pos)
>>> +{
>>> +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size,=
 1);
>>> +}
>>> +
>>>
>>>     /**
>>>      * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>>> @@ -1091,6 +1229,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct=
 file *f, char __user *buf,
>>>         return result;
>>>     }
>>>
>>> +static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
>>> +     .owner =3D THIS_MODULE,
>>> +     .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
>>> +     .read =3D amdgpu_debugfs_regs2_read,
>>> +     .write =3D amdgpu_debugfs_regs2_write,
>>> +     .open =3D amdgpu_debugfs_regs2_open,
>>> +     .release =3D amdgpu_debugfs_regs2_release,
>>> +     .llseek =3D default_llseek
>>> +};
>>> +
>>>     static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>>>         .owner =3D THIS_MODULE,
>>>         .read =3D amdgpu_debugfs_regs_read,
>>> @@ -1148,6 +1296,7 @@ static const struct file_operations amdgpu_debugf=
s_gfxoff_fops =3D {
>>>
>>>     static const struct file_operations *debugfs_regs[] =3D {
>>>         &amdgpu_debugfs_regs_fops,
>>> +     &amdgpu_debugfs_regs2_fops,
>>>         &amdgpu_debugfs_regs_didt_fops,
>>>         &amdgpu_debugfs_regs_pcie_fops,
>>>         &amdgpu_debugfs_regs_smc_fops,
>>> @@ -1160,6 +1309,7 @@ static const struct file_operations *debugfs_regs=
[] =3D {
>>>
>>>     static const char *debugfs_regs_names[] =3D {
>>>         "amdgpu_regs",
>>> +     "amdgpu_regs2",
>>>         "amdgpu_regs_didt",
>>>         "amdgpu_regs_pcie",
>>>         "amdgpu_regs_smc",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.h
>>> index 141a8474e24f..6d4965b2d01e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> @@ -22,7 +22,6 @@
>>>      * OTHER DEALINGS IN THE SOFTWARE.
>>>      *
>>>      */
>>> -
>>>     /*
>>>      * Debugfs
>>>      */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_umr.h
>>> new file mode 100644
>>> index 000000000000..919d9d401750
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>> @@ -0,0 +1,51 @@
>>> +/*
>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
>>> + * copy of this software and associated documentation files (the "Soft=
ware"),
>>> + * to deal in the Software without restriction, including without limi=
tation
>>> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
>>> + * and/or sell copies of the Software, and to permit persons to whom t=
he
>>> + * Software is furnished to do so, subject to the following conditions=
:
>>> + *
>>> + * The above copyright notice and this permission notice shall be incl=
uded in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +#include <linux/ioctl.h>
>>> +
>>> +/*
>>> + * MMIO debugfs IOCTL structure
>>> + */
>>> +struct amdgpu_debugfs_regs2_iocdata {
>>> +     __u32 use_srbm, use_grbm, pg_lock;
>>> +     struct {
>>> +             __u32 se, sh, instance;
>>> +     } grbm;
>>> +     struct {
>>> +             __u32 me, pipe, queue, vmid;
>>> +     } srbm;
>>> +};
>>> +
>>> +/*
>>> + * MMIO debugfs state data (per file* handle)
>>> + */
>>> +struct amdgpu_debugfs_regs2_data {
>>> +     struct amdgpu_device *adev;
>>> +     struct mutex lock;
>>> +     struct amdgpu_debugfs_regs2_iocdata id;
>>> +};
>>> +
>>> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>>> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
>>> +};
>>> +
>>> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_=
REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>>>
