Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20A0C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 11:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A2410F8F2;
	Wed, 21 May 2025 11:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MmMutk+Z";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3261710F8F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 11:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL3ykSeli5UDRiifClD9iczx4d/Jg1DjWlYMwQK0UNkaIqvAgp0e0l9I1UjxFYQvekBu/IG7DcoqZGvdQ8j8mIDTQf2RuM3k9srsRRJobMO1pT5Q8S7GrPHP3QJ7rFEGdEs3FVmvtqYWd3UGefYUHTtHC+Dvafe3GJPbHpxVd8k+oY+ekdBHtoS0MJM30ADBSAcqSLQLjaIw+BjmU/dLF82rIyeOHKM6r/xVm8nwlZ2kGOXPKM858c/hwHEfc3ymgoHCqDLd7If5bXUhmH7nkrWdWGWqpFtupa6ZhvHhLjttx1mnlF5NqeXsdzQHwaf27oOg4VEVzzVzXbodPYiXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TSRCw4MRenp2KbQk9pGVWBeviSiC53BnbyslJrTajk=;
 b=XPfUXpa09Er/pxdUcxViU01zAVC1PHYnAp/FGVUncgmQ1RXilLRcfcgRze8pRh6oc4OJUbWfAcOfWn8hrYwXeNUAKPryTP5a+731n6AhXSIrAAZkxapk/gdLX4l8u3Hm2RIDv3nVcNpbN9nrDnV21y7faH1KfleJK4srurHs3OhvT3LuqSpGjSFoehzH/lNYCpADbdJ8FOqPn017/kD1hzTPrmiGwDrY81TrU5NX9BpGG4ASvUtHXMebcO8qeWQsxr08Wg5RljKsu4krMnhb3nG8JcpG9Usm10wXGsFEIHLMKtO2sdtrbo5kU5GjFmCUZqNhpYnuIC0nYpxxXgcSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TSRCw4MRenp2KbQk9pGVWBeviSiC53BnbyslJrTajk=;
 b=MmMutk+ZOSPyEqR7+dLktZlTV/lkOB3RhSMf1guhFvQ4tXnCRclLTo4/AK9FFL2RET628Zsu+ea4zEpXo70BSY7AN+wvAI/Vhfnfh/CtOy7e9nG9qj1X17FgtwOyF13LLNTM3p9n38MpwNK9GnGcJ7XJd37z9w1ryjLImcc8l68=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Wed, 21 May 2025 11:55:55 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 11:55:54 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, GuoQing (Sam)"
 <GuoQing.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
Subject: Re: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbyJcs4MJaW6/wr0qotfWV8KGndLPZ+q8AgAGFFACAAT1wgIAAxUUA
Date: Wed, 21 May 2025 11:55:27 +0000
Message-ID: <8b2ea507-403c-471a-a3d4-db23f3d2f096@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-4-guoqing.zhang@amd.com>
 <e75c26e4-8011-4e49-9e2d-d354dcf7358b@amd.com>
 <4f3c7a86-c89a-429d-8ec1-5db7a0d12c6c@amd.com>
 <67fc5bc0-e1a7-4074-ab4e-bd7735b60cd1@amd.com>
In-Reply-To: <67fc5bc0-e1a7-4074-ab4e-bd7735b60cd1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM4PR12MB5937.namprd12.prod.outlook.com
 (15.20.8746.028)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|DS0PR12MB8246:EE_
x-ms-office365-filtering-correlation-id: dad9be50-9105-46a9-5f58-08dd985e711a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/J1BNl//aDe51hQTC0yeMoS54IhUxcxS2QN0RQwDjJKEBVsvfuCpMflohO?=
 =?iso-8859-1?Q?vFa1Ma84PlrG5GNHh5Gbu6junomd7IohG3f3FkB2tII/rUO/A5fX77qVVc?=
 =?iso-8859-1?Q?yHXtijb522Hx3Zsyhx1fnoFqiiAZf5Fi4V0dslwXlbdHAm8WRMf5pvJvj4?=
 =?iso-8859-1?Q?K7mbKWfIp5397udsIiqkBsdJ7xzI2hTXB2cI8vdl3/MxPpkAQaFMPP9Kx9?=
 =?iso-8859-1?Q?gVDZPZqt1FFPKra7zvrrolhqCOni1qwZy8x1TSB7+8JsfmWCpijWMxFjBt?=
 =?iso-8859-1?Q?VThdPdy0y8UFcarq9C0SGtQZ1BgfQvBIkyhpmbwYwEUKbiVOsZix7tzVk0?=
 =?iso-8859-1?Q?Rhva1qCnS69DwxF52V/dEniyxuxNzpwXyVnQSIXMNIeokwzM3f26YLOgEC?=
 =?iso-8859-1?Q?a+sQa1UCOTnbfzOOGmCCVkrVEODJr7XVrzxVkvSSWazZ8sU22h2QXqInkh?=
 =?iso-8859-1?Q?gMr3qXrCa4pooOwacMWAz9lHktbWcOlXksqYnsSd/p5iyDA2j2MRtzVjwz?=
 =?iso-8859-1?Q?luv6bwNQxfsl682FL79tbncARUlusVQJBmfe+2/yrOWws8SzSPgRiytQkA?=
 =?iso-8859-1?Q?sL/YCzzTIqZW7hR0N4BGEBb5MICkOcGiNJLvPVnaP6M6slBnuTwFp/SIJS?=
 =?iso-8859-1?Q?r1K88/NRWTOpRYfJ42AKy4nnwzjLBW2iclD6aPEpzxXdvPipxJJ789q1xg?=
 =?iso-8859-1?Q?0t/0L6Otz0o2kMzdneFK4h9MoUYKXO1Xm4eim7oc9G2Xic8APEziMMd6tG?=
 =?iso-8859-1?Q?kuz4B1SMNTm+V+lZoxbTtEV0wOid80iCqbEYM0/Xk/BxsD/2QdmhWLE8tw?=
 =?iso-8859-1?Q?vRCMNFIqRfZ+egh8RTqgSgN/VxTkkFAByY7yxfZ59jLMmze4eIDLrUZmhG?=
 =?iso-8859-1?Q?riKQK2qbcrivP06LRxLK+hPXFOMRTKcZl8Q3gXkrp68dhdK2bN+qBUHPTv?=
 =?iso-8859-1?Q?KIqS9Jt3aX5ccuEjQ6oxdufME4xG6EFdJ4VOZJYgsmn9fD8ModUjP+cKDI?=
 =?iso-8859-1?Q?bv314n3+u8oGvETa7T1Gw3Qs4hYGPbEroo0mQlultsBotzoW9a8ncoHyvX?=
 =?iso-8859-1?Q?Eol6cjEVloOgRdXp2MkBM/Jp826HYsnLX/8SgGnz+rRbSahvs37g3fcpGm?=
 =?iso-8859-1?Q?NeDLmud4lI9JtPhWBx5jrLV6xW6uPOjgJoXOhEPvmedAqGPSyGGlNzCPRK?=
 =?iso-8859-1?Q?OC+SDUHArgLcmZ845DssbMMTEQx6/6N05XXI1b55Wh5IZLFtJwzZr3CTIb?=
 =?iso-8859-1?Q?+F8I9eAIqv4LhLsh5YV1j6v12UUeYkpjOR25hdK+zYlKOxT0K4UrMshGVv?=
 =?iso-8859-1?Q?btwxvCDJIQUxQvkpb1HRw7x4l9+AaeFVDhe2mbkHOkCPk/HsAqwUpgGrCE?=
 =?iso-8859-1?Q?CTTZ8t2YFmUPbxflG0dVbf8SUSd8qvHeFOOleE4NSnXLVumGSiih4WwRg+?=
 =?iso-8859-1?Q?5wXNL9L2fY7apEk2hW5tFU8MyyEXNWHX41tJXOJiEaujI81lKKuUgERJcX?=
 =?iso-8859-1?Q?i0hh9aMBZpcQBQvOOG2Lx6C9yOvDS/XF8Z3m2f2ypOTkeRC1fwFBRFZcgo?=
 =?iso-8859-1?Q?yrXw6sE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8Qa46VEvCtqJa9UxJhuHEf00EL/YXtqhO9nLh23Uk2lhnnxVYXtgEJPs6m?=
 =?iso-8859-1?Q?lIwXmGhrjg7hV6rlq+0bk2CvJ69eqURHjwWOaeTZ0HrCDLRoMTMuS1RvlK?=
 =?iso-8859-1?Q?vL6HdwcEMJkQnhZMBKgDFp9VRHlg9Exd5zlIG526RsbIY1Ia0X57H/mtuO?=
 =?iso-8859-1?Q?gYTjVfZesUl87h1p+g75K2iFCwIVdiZBIc2+cf/Xbw8BXjOUj9nAZWSjBZ?=
 =?iso-8859-1?Q?z1KvLH1h2OwAV9h8IfvDtm2tkcW1dE7oOEf9FFgvZH4ghsJAvpeYhx69DB?=
 =?iso-8859-1?Q?UCfavxs1DnxeDauWESFCoHAgHY3huCd/FmfbWJR9t6dBYwjS3CZfnWsOXw?=
 =?iso-8859-1?Q?S7NmoKOwUHFQUD1EqBLJJLoIV4pcCmjmAkxeRfG2Xxuv+wE3P//4aum64d?=
 =?iso-8859-1?Q?MM1dvPTc71Gazs+Vz/ChzWhKTwQhu5EtrVq3bVuVWgbS+9h+Mw4zxnkP1i?=
 =?iso-8859-1?Q?h+qXntKnbv1lUyKXiIgGkwb5RBhXkv4yOMVtVy8NgNfAGRkuXnpfPJFyig?=
 =?iso-8859-1?Q?Fi4moJR+yr7sFw2QN1wdAiOSDHjBVvWG460r22vIf9jHqDGYpZjKBJTouk?=
 =?iso-8859-1?Q?5M5X6EOOV3lOZQeAPLz0e1jFb/Z0/WOdVVLO76NJL71NwVWZz4OkwdQzo+?=
 =?iso-8859-1?Q?npt6tnGBLtCSVam7pxebf3z74YxotYTM7Ufd32LQJqIHj9/pKc+zqEHCPe?=
 =?iso-8859-1?Q?WT323WkGeWCAMTAVMRufZfju/qiRkeHDzayUUok2hQ/DMqqtIU9Jxt3PEC?=
 =?iso-8859-1?Q?fzYt70e4KQ3IFJg2Vep+RyfWGDj/fWhZFIlvAmOApFFWrCN2DBf6yyry1g?=
 =?iso-8859-1?Q?y6lKYLEhDcB7AKrnYKfgpIuP0L1WsehZJKsWpw8HxlAHAevKZ13hGtRv+y?=
 =?iso-8859-1?Q?pa7vSswMNZ5+ALMGzO7VFowgzPm1C1iUS7YsUweFwgiwL9J6vkKEp7fiAB?=
 =?iso-8859-1?Q?4XxVU16NRjfwzdSEMVR772p6g/zHtYAg8T5RSc6oRHYZ4PMWsHZ7uxsBUi?=
 =?iso-8859-1?Q?LsPh+0uPBelepAfRRcIaIMRNs13AxKVtWMQx8kjgNbqVIrgMi/xXGMI0U/?=
 =?iso-8859-1?Q?XYfMTgJY46idtiqGrtnfd77XqmxOLKr6QyMxlotOqanKxu/fhJuWtC/gOZ?=
 =?iso-8859-1?Q?RfajEraQ4Zs7kn1gRE+ThTJBP4gnaDPFHIko7DT3cmswNhp7BDcbwj9NSY?=
 =?iso-8859-1?Q?2GtjAKIX3dviaeRq6CvawIIqdzv2ZKdfoBIIOj1QVhE6xe9frHlwUmFz6I?=
 =?iso-8859-1?Q?ZU2X39KUS9VTombfdQqNNy3XWGzXSsJz25C13N22JG1ZlprVEp0/d592pE?=
 =?iso-8859-1?Q?9NqMfxXBzuqVNfLGPwmENTCvEVVJXrxRY+TQ+q452ck8O5ummdqHAi/+SC?=
 =?iso-8859-1?Q?u+AjBDmAnA3JkjSQ6Rtyc2Ua0GoqK7XRA8MmK2fUEOnjKbC83pDPCi9Pe5?=
 =?iso-8859-1?Q?2ixt5GsAx784N1QsvCAPlOavUGn8BdIoDoDH9VJ//zNdorFKQmwTbgPFRH?=
 =?iso-8859-1?Q?deHbCnZ0qDZP49vkJPH6DoM7FoIJKK5jYurjVJh2/YZ3I8XsWdeuFDSSKs?=
 =?iso-8859-1?Q?J0oJc+VW+VYaCSE2OqLJWXl6MPV0cOUaypKCzq8uX+BTQ/eaC+94WYnZud?=
 =?iso-8859-1?Q?0ekUMoBfoKuaUDn+cZf24r0RKZryy5P3vL?=
Content-Type: multipart/alternative;
 boundary="_000_8b2ea507403c471aa3d4db23f3d2f096amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad9be50-9105-46a9-5f58-08dd985e711a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 11:55:54.5163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6g0wv7rbvNNoZVE08x1YcsO/8GMjQLwMT/WigTnZMtcZrhU+FVvZCY+b67Tgm3FNZANDRASedTRgN4hoYwesg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246
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

--_000_8b2ea507403c471aa3d4db23f3d2f096amdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On 2025/5/21 16:06, Christian K=F6nig wrote:
> On 5/20/25 07:10, Zhang, GuoQing (Sam) wrote:
>>>> +    if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>>> +            /* set mc->vram_start to 0 to switch the returned GPU add=
ress of
>>>> +             * amdgpu_bo_create_reserved() from FB aperture to GART a=
perture.
>>>> +             */
>>>> +            amdgpu_gmc_vram_location(adev, mc, 0);
>>> This function does a lot more than just setting mc->vram_start and mc->=
vram_end.
>>>
>>> You should probably just update the two setting and not call amdgpu_gmc=
_vram_location() at all.
>> I tried only setting mc->vram_start and mc->vram_end. But KMD load will
>> fail with following error logs.
>>
>> [  329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M
>> 0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)
>> [  329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M
>> 0x0000018000000000 - 0x000001801FFFFFFF
>> [  329.314385] [drm] Detected VRAM RAM=3D196288M, BAR=3D262144M
>> [  329.314386] [drm] RAM width 8192bits HBM
>> [  329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to allocate
>> kernel bo
>> [  329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
>> block <gmc_v9_0> failed -22
>> [  329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_init failed
>>
>>
>> It seems like setting mc->visible_vram_size and mc->visible_vram_size
>> fields are also needed. In this case call amdgpu_gmc_vram_location() is
>> better than inline the logic, I think.
> Yeah, exactly that is not a good idea.
>
> The mc->visible_vram_size and mc->real_vram_size should have been initial=
ized by gmc_v9_0_mc_init(). Why didn't that happen?


[Sam] visible_vram_size is set to 0x4000000000 (256G) from
`pci_resource_len(adev->pdev, 0)` in `gmc_v9_0_mc_init()`.
It is set to real_vram_size 0x2fec000000(192G) in
amdgpu_gmc_vram_location().

Should I update the 3 variables inline and not call
amdgpu_gmc_vram_location()?

         mc->vram_start =3D 0;
         mc->vram_end =3D mc->vram_start + mc->mc_vram_size - 1;
         if (mc->real_vram_size < mc->visible_vram_size)
             mc->visible_vram_size =3D mc->real_vram_size;


>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm=
/amd/amdgpu/mmhub_v1_8.c
>>>> index 84cde1239ee4..18e80aa78aff 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
>>>> @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu=
_device *adev)
>>>>         top &=3D MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
>>>>         top <<=3D 24;
>>>>
>>>> -    adev->gmc.fb_start =3D base;
>>>> -    adev->gmc.fb_end =3D top;
>>>> +    if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>>> +            adev->gmc.fb_start =3D base;
>>>> +            adev->gmc.fb_end =3D top;
>>>> +    }
>>> We should probably avoid calling this in the first place.
>>>
>>> The function gmc_v9_0_vram_gtt_location() should probably be adjusted.
>> mmhub_v1_8_get_fb_location() is called by the new
>> amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_location().
> Oh, that is probably a bad idea. The function amdgpu_bo_fb_aper_addr() sh=
ould only rely on cached data.


[Sam] Can I add new `fb_base` field in `struct amdgpu_gmc` to cache the
value of `get_fb_location()`?
Using this approach, we don't need to set fb_start and fb_end on resume
any more, since the reset of the 2 field is caused by
mmhub_v1_8_get_fb_location() calls from amdgpu_bo_fb_aper_addr().
Please see the code change below.

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -259,6 +259,7 @@ struct amdgpu_gmc {
          */
         u64                     fb_start;
         u64                     fb_end;
+       u64                     fb_base;
         unsigned                vram_width;
         u64                     real_vram_size;
         int                     vram_mtrr;

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1527,7 +1527,7 @@ u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)

         WARN_ON_ONCE(bo->tbo.resource->mem_type !=3D TTM_PL_VRAM);

-       fb_base =3D adev->mmhub.funcs->get_fb_location(adev);
+       fb_base =3D adev->gmc.fb_base;
         fb_base +=3D adev->gmc.xgmi.physical_node_id *
adev->gmc.xgmi.node_segment_size;
         offset =3D (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
         return amdgpu_gmc_sign_extend(offset);

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1728,6 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struct
amdgpu_device *adev,
                                         struct amdgpu_gmc *mc)
  {
         u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
+       mc->fb_base =3D base;

         /* add the xgmi offset of the physical node */
         base +=3D adev->gmc.xgmi.physical_node_id *
adev->gmc.xgmi.node_segment_size;

--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -45,10 +45,8 @@ static u64 mmhub_v1_8_get_fb_location(struct
amdgpu_device *adev)
         top &=3D MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
         top <<=3D 24;

-       if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
-               adev->gmc.fb_start =3D base;
-               adev->gmc.fb_end =3D top;
-       }
+       adev->gmc.fb_start =3D base;
+       adev->gmc.fb_end =3D top;


Regards
Sam


>
>> mmhub_v1_8_get_fb_location() is supposed to be a query api according to
>> its name. having such side effect is very surprising.
>>
>> Another approach is set the right fb_start and fb_end in the new
>> amdgpu_virt_resume(), like updating vram_base_offset.
> That is probably better. And skip setting fb_start and fb_end in amdgpu_g=
mc_sysvm_location() for this use case.
>
> That was done only because we re-program those registers on bare metal.
>
> Regards,
> Christian.
>
>> Which approach do you prefer? Or any better suggestions? Thank you.
>>
>>
>> Regards
>> Sam
>>
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>         return base;
>>>>     }

--_000_8b2ea507403c471aa3d4db23f3d2f096amdcom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <852FC34D6DBB9E4A83422B29C65DFBF3@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><br>
On 2025/5/21 16:06, Christian K=F6nig wrote:<br>
&gt; On 5/20/25 07:10, Zhang, GuoQing (Sam) wrote:<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_virt_xgmi_migrate_enabled(a=
dev)) {<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; /* set mc-&gt;vram_start to 0 to switch the returned GPU address =
of<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * amdgpu_bo_create_reserved() from FB aperture to GART aper=
ture.<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_gmc_vram_location(adev, mc, 0);<br>
&gt;&gt;&gt; This function does a lot more than just setting mc-&gt;vram_st=
art and mc-&gt;vram_end.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You should probably just update the two setting and not call a=
mdgpu_gmc_vram_location() at all.<br>
&gt;&gt; I tried only setting mc-&gt;vram_start and mc-&gt;vram_end. But KM=
D load will<br>
&gt;&gt; fail with following error logs.<br>
&gt;&gt;<br>
&gt;&gt; [&nbsp; 329.314346] amdgpu 0000:09:00.0: amdgpu: VRAM: 196288M<br>
&gt;&gt; 0x0000000000000000 - 0x0000002FEBFFFFFF (196288M used)<br>
&gt;&gt; [&nbsp; 329.314348] amdgpu 0000:09:00.0: amdgpu: GART: 512M<br>
&gt;&gt; 0x0000018000000000 - 0x000001801FFFFFFF<br>
&gt;&gt; [&nbsp; 329.314385] [drm] Detected VRAM RAM=3D196288M, BAR=3D26214=
4M<br>
&gt;&gt; [&nbsp; 329.314386] [drm] RAM width 8192bits HBM<br>
&gt;&gt; [&nbsp; 329.314546] amdgpu 0000:09:00.0: amdgpu: (-22) failed to a=
llocate<br>
&gt;&gt; kernel bo<br>
&gt;&gt; [&nbsp; 329.315013] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_i=
nit of IP<br>
&gt;&gt; block &lt;gmc_v9_0&gt; failed -22<br>
&gt;&gt; [&nbsp; 329.315846] amdgpu 0000:09:00.0: amdgpu: amdgpu_device_ip_=
init failed<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; It seems like setting mc-&gt;visible_vram_size and mc-&gt;visible_=
vram_size<br>
&gt;&gt; fields are also needed. In this case call amdgpu_gmc_vram_location=
() is<br>
&gt;&gt; better than inline the logic, I think.<br>
&gt; Yeah, exactly that is not a good idea.<br>
&gt;<br>
&gt; The mc-&gt;visible_vram_size and mc-&gt;real_vram_size should have bee=
n initialized by gmc_v9_0_mc_init(). Why didn't that happen?<br>
<br>
<br>
[Sam] visible_vram_size is set to 0x4000000000 (256G) from <br>
`pci_resource_len(adev-&gt;pdev, 0)` in `gmc_v9_0_mc_init()`.<br>
It is set to real_vram_size 0x2fec000000(192G) in <br>
amdgpu_gmc_vram_location().<br>
<br>
Should I update the 3 variables inline and not call <br>
amdgpu_gmc_vram_location()?<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_start =3D 0;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt=
;vram_start + mc-&gt;mc_vram_size - 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mc-&gt;real_vram_size =
&lt; mc-&gt;visible_vram_size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc=
-&gt;visible_vram_size =3D mc-&gt;real_vram_size;<br>
<br>
<br>
&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/dri=
vers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt;&gt;&gt; index 84cde1239ee4..18e80aa78aff 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
&gt;&gt;&gt;&gt; @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; top &amp;=3D MC=
_VM_FB_LOCATION_TOP__FB_TOP_MASK;<br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; top &lt;&lt;=3D=
 24;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_start =3D base;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_end =3D top;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!amdgpu_virt_xgmi_migrate_enabled(=
adev)) {<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;gmc.fb_start =3D base;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;gmc.fb_end =3D top;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; We should probably avoid calling this in the first place.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The function gmc_v9_0_vram_gtt_location() should probably be a=
djusted.<br>
&gt;&gt; mmhub_v1_8_get_fb_location() is called by the new<br>
&gt;&gt; amdgpu_bo_fb_aper_addr() as well, not just gmc_v9_0_vram_gtt_locat=
ion().<br>
&gt; Oh, that is probably a bad idea. The function amdgpu_bo_fb_aper_addr()=
 should only rely on cached data.<br>
<br>
<br>
[Sam] Can I add new `fb_base` field in `struct amdgpu_gmc` to cache the <br=
>
value of `get_fb_location()`?<br>
Using this approach, we don't need to set fb_start and fb_end on resume <br=
>
any more, since the reset of the 2 field is caused by <br>
mmhub_v1_8_get_fb_location() calls from amdgpu_bo_fb_aper_addr().<br>
Please see the code change below.<br>
<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
@@ -259,6 +259,7 @@ struct amdgpu_gmc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; fb_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; fb_end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; fb_base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vr=
am_width;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; real_vram_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; vram_mtrr;<br>
<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -1527,7 +1527,7 @@ u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(bo-&gt;tbo.re=
source-&gt;mem_type !=3D TTM_PL_VRAM);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fb_base =3D adev-&gt;mmhub.funcs-&gt;=
get_fb_location(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fb_base =3D adev-&gt;gmc.fb_base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fb_base +=3D adev-&gt;gmc.=
xgmi.physical_node_id * <br>
adev-&gt;gmc.xgmi.node_segment_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D (bo-&gt;tbo.res=
ource-&gt;start &lt;&lt; PAGE_SHIFT) + fb_base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_gmc_sign_ext=
end(offset);<br>
<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1728,6 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struct <br>
amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_gmc *mc)<br>
&nbsp;&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base =3D adev-&gt;mmhu=
b.funcs-&gt;get_fb_location(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_base =3D base;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add the xgmi offset of =
the physical node */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base +=3D adev-&gt;gmc.xgm=
i.physical_node_id * <br>
adev-&gt;gmc.xgmi.node_segment_size;<br>
<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c<br>
@@ -45,10 +45,8 @@ static u64 mmhub_v1_8_get_fb_location(struct <br>
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; top &amp;=3D MC_VM_FB_LOCA=
TION_TOP__FB_TOP_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; top &lt;&lt;=3D 24;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_virt_xgmi_migrate_enabled=
(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gmc.fb_start =3D base;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gmc.fb_end =3D top;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_start =3D base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.fb_end =3D top;<br>
<br>
<br>
Regards<br>
Sam<br>
<br>
<br>
&gt;<br>
&gt;&gt; mmhub_v1_8_get_fb_location() is supposed to be a query api accordi=
ng to<br>
&gt;&gt; its name. having such side effect is very surprising.<br>
&gt;&gt;<br>
&gt;&gt; Another approach is set the right fb_start and fb_end in the new<b=
r>
&gt;&gt; amdgpu_virt_resume(), like updating vram_base_offset.<br>
&gt; That is probably better. And skip setting fb_start and fb_end in amdgp=
u_gmc_sysvm_location() for this use case.<br>
&gt;<br>
&gt; That was done only because we re-program those registers on bare metal=
.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt; Which approach do you prefer? Or any better suggestions? Thank you=
.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Regards<br>
&gt;&gt; Sam<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return base;<br=
>
&gt;&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; }<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_8b2ea507403c471aa3d4db23f3d2f096amdcom_--
