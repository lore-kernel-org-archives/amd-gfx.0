Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D01EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 16:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B6461465
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 16:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28B6461465
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC1FA6EE3E;
	Thu, 16 Sep 2021 16:41:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1886EE3E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 16:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MILWjvOoNgxcqTjpDYWeCOQSHFct3tJPpvtoG/3HMm+v89sp+xaTVADdMAq+pXjTkO4rhP0XvcA5+lchMIg2ZbjyJqIo/E0vhtaG8d/pbx/QjQFWDTnPAZiMkXCw5W6LdTlRApKir4WseYWqkqzMtZ2BfwJrBTXUgrapXHPFBSVTXV3WHn/3hx7lskkOsXOaaslBOo/35hqgOpU1zQAp5OYc6nLv1xDATNWHpcY/siE9Xx4K9ygcwUtgvWF59Vlfau3Px4Rc4vXwo3pKRpZ8Ml1EhuOLKDMRaUAaEF6tms3y1YtJKr8KG/zecV7JihxZR41sr7H9X2OEoLkMmgc64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=v71aSKghnLbfsbPFrsJ3tG3A6XLVhJ1CTp4bTQOngSI=;
 b=YM8IiYLNElFxjpPwcYQBwxuTAITxlV60IfP9dbYMeb5+aIlbtNp55jugwjbeLne5C42p9lKnn5g5AT8bZUUUkxAMtZcIGrW+lHwm7KRlm3g6/l3Snz1LFGEvfCXHKRLZM/ge6ndyMkrK0D6luDTVJSTQ4srg2W8KfIK+OVMkFDWke4LlBwNIVGkCX2tmp/qg+9nSZgKzwPsRChlmTRSx8uifo3DMRqM9BA+3jEr4WXkCVMZM+WX9ryGtYElWKVLw5ZM0ywfQDxJe6hN7upeBQlRa8FDMgcMztDLHt2HOQ4rMjl8+R9ytEWe004y3/5/kRzl6eR0H+sNXq7RTm/5uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v71aSKghnLbfsbPFrsJ3tG3A6XLVhJ1CTp4bTQOngSI=;
 b=l6/Bg4MJ4IWvzD4UvT8iobW482ZXiwttppUSRQ5ajyVJxRLOhbslYdilrYh1eUZvWAaNbJPgR84Sj7GWhNRwJpGirOiAGbzsH53KyyFo4loSB3y6PGUpccd2aHaoO6j2RkoOlwct9LQSL6lwYYcH/JQKmQ5OywRBX6f5IGsvaiI=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:40:59 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%9]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 16:40:59 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Quan, Evan" <Evan.Quan@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix crash on device remove/driver unload
Thread-Topic: [PATCH] drm/amdgpu: Fix crash on device remove/driver unload
Thread-Index: AQHXqmnJgVMsu3qm806R9iRI3XrkaaumUq4AgAB8RgCAAAHAAIAABzeAgAADt9c=
Date: Thu, 16 Sep 2021 16:40:59 +0000
Message-ID: <CH0PR12MB534811900AA6A49C74658BCB97DC9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210915194153.455140-1-andrey.grodzovsky@amd.com>
 <e5f543f5-f2c3-294a-59f1-4c5ca99233ee@amd.com>
 <a0c98e67-9690-cfb2-35ef-806561d6bf44@amd.com>
 <8269157a-fc6e-37ef-63e4-9b2de79a6b05@amd.com>
 <45b4cd29-bed1-6243-0e9d-da6bd33c195e@amd.com>
In-Reply-To: <45b4cd29-bed1-6243-0e9d-da6bd33c195e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-16T16:31:08.9921149Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712533d3-8a67-4ebd-b0c8-08d97930c39f
x-ms-traffictypediagnostic: CH0PR12MB5154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB51546D4906656B1AE18187F097DC9@CH0PR12MB5154.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beD34vLafh/bdU54y9tuTcrPF9+8G8sYaRVg40ukaTM7/qH2jrc5C68ukpgsRLudQbsJXvUwoiUu2DDaEz1gVfzDhfOyTt+WSvST4kJJKOIEYAbtQRhA7ENIn99qtTZ6Izza+U1j87TY6Bu2JeAbMnIVu6xh5L+lhjPTW6YBFPcilbbrLuUW8Xo9rXKrS4k4mOeOH7Ds3dpuuxfls2jgvgU4PVBG5V9Gk6qbNrHSKeGO71OfEdm+EP5LBhdAk2CoqnyKYwfoJP6e6Vn30eG6iCb3h0ax7A7PnuIBurR0emeWCU/fAsOcSdk4MjZqvJ+5rZq2Q+kSNzHAKhFWLcqG7+qD0/z06TCkcQMU5yjZ+/95DoRTFr+8r1u4y8iz2/uqsCIrBvbkyNkwitiqsGie32uEjPaoa3H9QNRz08BdTG4S+FY7MZGyjYJFfxFtdL7svTxQMB5YnzPATSb9LrAx6lqI6P0aHmyGzpng2nOq/MEoJjj+IsKXuyop9MdnG7ujFKo+niWIFVCunSCtEh9drP2ErTQIOcIDVbBLob1dK1lFIfdTUHdDPoykTxFyxyD1IhnzXUnEny4sO3LQpYj9OyMDrfmLJeZunQIYXrt/ct9AeV+W7NZQXkwoyieArYnr1Cnp2kDIO7cQlgHYlcWkmt2Q6TJgDG/08qzLfHsQQmqXdQUdc9FQiEcei3jI1Q9oj4LJAPzFh6pw6qgi2IG3XA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(52536014)(54906003)(83380400001)(110136005)(66446008)(91956017)(53546011)(8676002)(66476007)(66946007)(76116006)(66556008)(64756008)(6506007)(86362001)(316002)(38100700002)(122000001)(2906002)(71200400001)(30864003)(186003)(55016002)(478600001)(5660300002)(9686003)(7696005)(8936002)(33656002)(26005)(38070700005)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fIznLFKpW8Aw0CLCGzH51gFSqfdvpgx73m8dXpyRIQ4kc6ftn9YUrRzNe2SW?=
 =?us-ascii?Q?1Ze56a0kd8Ul3XvdmxXQJso24Yl2n6Ylm1+NsUqonkKefpLswoenfAHTIbt0?=
 =?us-ascii?Q?lX3vaK1PoSH6WzqU6bOsTl5L/dlNsIsAi+rLHdjetESLNVS0pMRNwPnCE53H?=
 =?us-ascii?Q?oh7cVmIB9cZCDmfbYpHfHvpFXUOrqsOAOfpYccpxHBP6T2MYWvQ4feN7B1EY?=
 =?us-ascii?Q?SFhkQl24q4+yf5IARRRYMBC5IfILZ7xykMGnShq2zFUCV0KYN7OgCRhJpEVT?=
 =?us-ascii?Q?2oHUfcRedOrxiK6clAuVH7Q3QXtYtVybNS6Tc5lLY6YyAjz8zV1QU0bH2GIV?=
 =?us-ascii?Q?vAGkRKDRQHZwrI9G+mucuHQBori6jWyaChe7kKvANOoJIQlTtNjdMZUzj+bv?=
 =?us-ascii?Q?67wBNLDkPd67rCb0r/EzqzSpMKwPzGORDXNU33df7YxJz7u07GU6wW25GlhJ?=
 =?us-ascii?Q?Aha+4ERYSBSYtzjsJ+9+pKlRfchpuKxRBhfraHVd0HmIZIdNVW6VjMys3nMJ?=
 =?us-ascii?Q?RBot8wcafRGqoYMjPSVP5l0ZfS7lUsRj+bOToai2N6dS83cvzsWo2aeyvXIJ?=
 =?us-ascii?Q?ioGuFF6ispLBW1D4TJwlxwRhneL0DtmWXjcG2Qre3KMXycSwxXIZXE1X7tYS?=
 =?us-ascii?Q?hGcNJ/JS/zlL9gODGg6xG39qnytTbFSMVzZhwB2gHlIEjdF/pCf5/eARRojN?=
 =?us-ascii?Q?cGfhXLMAzopXfkyX5pgw8ig8u6oAxY+K7kcJ3QwaDFGNsJ1xCngGpCg8mWCF?=
 =?us-ascii?Q?ZFpYMvnIl79LiYGhq3hHfXbK4UoAJzg+WrmL4ErSFImqwpMEB2gy4Xg+IZVu?=
 =?us-ascii?Q?gzIRq5DuB3otKyXW8GjcSc+mLcxipz69q3+XhPCPWI/dEjwVk4aUlbFRkhs2?=
 =?us-ascii?Q?t/wLJbkec1XHbbwrWutBJ+Zmlo5Z7l1owGeJhNuo1CvjuUy92Q2sCN/rU3Ts?=
 =?us-ascii?Q?pbgDagi5gSGC+7JjsVqjg28G4hjVcs2zMXAbez+QmGgUmx+r38Nmu3rNloD9?=
 =?us-ascii?Q?zO4T69TtXakA7eF3aqrqCXcn3bpIGmCMKOpubmsWlkTBgrncJVX4NRm7UQHQ?=
 =?us-ascii?Q?gvzVQpD4Ajjl+kk5Rk7k2NDU4Iih8ic1YVY3ILF0HCkDYOywikM1Q3XGCCl7?=
 =?us-ascii?Q?YqsvXBMr9lqzk9f/LJf8MN3n9190/X0ilX5M6ddTIQbhSempFmrYm54dI2os?=
 =?us-ascii?Q?oQwTC+71QA42zP+yHyqvURLVSEEwQNoms6XPBb0C9eRdazurKBublJvuaejl?=
 =?us-ascii?Q?roePYDgRNuCH+WidZfk0abokVrZMR5AZE5fAQg0yJ1se5VPkrW4yj8lsjMWk?=
 =?us-ascii?Q?6LeecfGAe7K5rzoNuamy3/zr+ZeOZ+FxhE24gjWup97B5g=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB534811900AA6A49C74658BCB97DC9CH0PR12MB5348namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712533d3-8a67-4ebd-b0c8-08d97930c39f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:40:59.6073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VClOgUpHV/KOR6u9LUF4KLiZVCg9+IP0ZNnNaX0VbHkJg/PpzXkk88YgAieqrEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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

--_000_CH0PR12MB534811900AA6A49C74658BCB97DC9CH0PR12MB5348namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Ah.. didn't notice that. As I mentioned, it's mainly a cosmetic/semantic th=
ing. AFAIU, hw_fini() is expected to be called once when hw is removed/rese=
t or driver is removed. Suspend is temporary and may be called multiple tim=
es during the lifetime. So calling hw_fini() from suspend() appears a bit o=
dd (probably just for me).

If it's worth, something like this -

vce_4_2_suspend() {

__vce_4_2_suspend();
....
// Anything extra
}

vce_4_2_hw_fini() {

__vce_4_2_suspend();

}

Thanks,
Lijo
________________________________
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Thursday, September 16, 2021 9:47:41 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deuch=
er, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix crash on device remove/driver unload


On 2021-09-16 11:51 a.m., Lazar, Lijo wrote:
>
>
> On 9/16/2021 9:15 PM, Andrey Grodzovsky wrote:
>>
>> On 2021-09-16 4:20 a.m., Lazar, Lijo wrote:
>>> A minor comment below.
>>>
>>> On 9/16/2021 1:11 AM, Andrey Grodzovsky wrote:
>>>> Crash:
>>>> BUG: unable to handle page fault for address: 00000000000010e1
>>>> RIP: 0010:vega10_power_gate_vce+0x26/0x50 [amdgpu]
>>>> Call Trace:
>>>> pp_set_powergating_by_smu+0x16a/0x2b0 [amdgpu]
>>>> amdgpu_dpm_set_powergating_by_smu+0x92/0xf0 [amdgpu]
>>>> amdgpu_dpm_enable_vce+0x2e/0xc0 [amdgpu]
>>>> vce_v4_0_hw_fini+0x95/0xa0 [amdgpu]
>>>> amdgpu_device_fini_hw+0x232/0x30d [amdgpu]
>>>> amdgpu_driver_unload_kms+0x5c/0x80 [amdgpu]
>>>> amdgpu_pci_remove+0x27/0x40 [amdgpu]
>>>> pci_device_remove+0x3e/0xb0
>>>> device_release_driver_internal+0x103/0x1d0
>>>> device_release_driver+0x12/0x20
>>>> pci_stop_bus_device+0x79/0xa0
>>>> pci_stop_and_remove_bus_device_locked+0x1b/0x30
>>>> remove_store+0x7b/0x90
>>>> dev_attr_store+0x17/0x30
>>>> sysfs_kf_write+0x4b/0x60
>>>> kernfs_fop_write_iter+0x151/0x1e0
>>>>
>>>> Why:
>>>> VCE/UVD had dependency on SMC block for their suspend but
>>>> SMC block is the first to do HW fini due to some constraints
>>>>
>>>> How:
>>>> Since the original patch was dealing with suspend issues
>>>> move the SMC block dependency back into suspend hooks as
>>>> was done in V1 of the original patches.
>>>> Keep flushing idle work both in suspend and HW fini seuqnces
>>>> since it's essential in both cases.
>>>>
>>>> Fixes:
>>>> 2178d3c189b9 drm/amdgpu: add missing cleanups for more ASICs on
>>>> UVD/VCE suspend
>>>> ee6679aaa61c drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE
>>>> on suspend
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++-------
>>>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++-------
>>>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 24 ++++++++-------
>>>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 32 ++++++++++---------
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 19 +++++++-----
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 28 +++++++++--------
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 44
>>>> ++++++++++++++-------------
>>>>   7 files changed, 105 insertions(+), 90 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> index 7232241e3bfb..0fef925b6602 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>>> @@ -698,6 +698,19 @@ static int uvd_v3_1_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>>> +    if (RREG32(mmUVD_STATUS) !=3D 0)
>>>> +        uvd_v3_1_stop(adev);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v3_1_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -722,17 +735,6 @@ static int uvd_v3_1_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    if (RREG32(mmUVD_STATUS) !=3D 0)
>>>> -        uvd_v3_1_stop(adev);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v3_1_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> -
>>>>       r =3D uvd_v3_1_hw_fini(adev);
>>>
>>> "cosmetic change" comment - hw_fini is supposed to be the final tear
>>> down call. So instead of suspend calling hw_fini, perhaps it makes
>>> sense to read the other way - hw_fini just suspends the hardware?
>>>
>>> Thanks,
>>> Lijo
>>
>>
>> Not sure what you mean ?
>
> Now it is - suspend()-> calls hw_fini()
>
> What I meant is hw_fini() -> calls suspend() and that is read as "to
> do hw_fini() only suspend the hardware and nothing extra is needed".
>
> In short implementation stays in suspend() and hw_fini() calls suspend().


Sorry, still confused, what about amdgpu_vce_suspend being called from
vce_v4_0_suspend for example - we don't want that to be called from hw_fini=
.
Can you maybe show draft change of what you mean for one specific UVD or
VCE version ?

Andrey


>
> Thanks,
> Lijo
>
>>
>> Andrey
>>
>>
>>>
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>>> index 52d6de969f46..c108b8381795 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>>> @@ -212,6 +212,19 @@ static int uvd_v4_2_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>>> +    if (RREG32(mmUVD_STATUS) !=3D 0)
>>>> +        uvd_v4_2_stop(adev);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v4_2_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -236,17 +249,6 @@ static int uvd_v4_2_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    if (RREG32(mmUVD_STATUS) !=3D 0)
>>>> -        uvd_v4_2_stop(adev);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v4_2_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> -
>>>>       r =3D uvd_v4_2_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>>> index db6d06758e4d..563493d1f830 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>>> @@ -210,6 +210,19 @@ static int uvd_v5_0_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>>> +    if (RREG32(mmUVD_STATUS) !=3D 0)
>>>> +        uvd_v5_0_stop(adev);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v5_0_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -234,17 +247,6 @@ static int uvd_v5_0_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    if (RREG32(mmUVD_STATUS) !=3D 0)
>>>> -        uvd_v5_0_stop(adev);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v5_0_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> -
>>>>       r =3D uvd_v5_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> index b6e82d75561f..1fd9ca21a091 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>>> @@ -606,6 +606,23 @@ static int uvd_v7_0_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>> +
>>>> +    if (!amdgpu_sriov_vf(adev))
>>>> +        uvd_v7_0_stop(adev);
>>>> +    else {
>>>> +        /* full access mode, so don't touch any UVD register */
>>>> +        DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int uvd_v7_0_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -630,21 +647,6 @@ static int uvd_v7_0_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    if (!amdgpu_sriov_vf(adev))
>>>> -        uvd_v7_0_stop(adev);
>>>> -    else {
>>>> -        /* full access mode, so don't touch any UVD register */
>>>> -        DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>>>> -    }
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>> -static int uvd_v7_0_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> -
>>>>       r =3D uvd_v7_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> index 84e488f189f5..67eb01fef789 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> @@ -481,6 +481,17 @@ static int vce_v2_0_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->vce.idle_work);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int vce_v2_0_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> +
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -504,14 +515,6 @@ static int vce_v2_0_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    return 0;
>>>> -}
>>>> -
>>>> -static int vce_v2_0_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> -
>>>>       r =3D vce_v2_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> index 2a18c1e089fd..142e291983b4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> @@ -492,6 +492,21 @@ static int vce_v3_0_hw_fini(void *handle)
>>>>       int r;
>>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>>   + cancel_delayed_work_sync(&adev->vce.idle_work);
>>>> +
>>>> +    r =3D vce_v3_0_wait_for_idle(handle);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    vce_v3_0_stop(adev);
>>>> +    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>>>> +}
>>>> +
>>>> +static int vce_v3_0_suspend(void *handle)
>>>> +{
>>>> +    int r;
>>>> +    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> +
>>>>       /*
>>>>        * Proper cleanups before halting the HW engine:
>>>>        *   - cancel the delayed idle work
>>>> @@ -515,19 +530,6 @@ static int vce_v3_0_hw_fini(void *handle)
>>>>                                  AMD_CG_STATE_GATE);
>>>>       }
>>>>   -    r =3D vce_v3_0_wait_for_idle(handle);
>>>> -    if (r)
>>>> -        return r;
>>>> -
>>>> -    vce_v3_0_stop(adev);
>>>> -    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>>>> -}
>>>> -
>>>> -static int vce_v3_0_suspend(void *handle)
>>>> -{
>>>> -    int r;
>>>> -    struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>> -
>>>>       r =3D vce_v3_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> index 044cf9d74b85..226b79254db8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> @@ -544,29 +544,8 @@ static int vce_v4_0_hw_fini(void *handle)
>>>>   {
>>>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>>>   -    /*
>>>> -     * Proper cleanups before halting the HW engine:
>>>> -     *   - cancel the delayed idle work
>>>> -     *   - enable powergating
>>>> -     *   - enable clockgating
>>>> -     *   - disable dpm
>>>> -     *
>>>> -     * TODO: to align with the VCN implementation, move the
>>>> -     * jobs for clockgating/powergating/dpm setting to
>>>> -     * ->set_powergating_state().
>>>> -     */
>>>>       cancel_delayed_work_sync(&adev->vce.idle_work);
>>>>   -    if (adev->pm.dpm_enabled) {
>>>> -        amdgpu_dpm_enable_vce(adev, false);
>>>> -    } else {
>>>> -        amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>>> -        amdgpu_device_ip_set_powergating_state(adev,
>>>> AMD_IP_BLOCK_TYPE_VCE,
>>>> -                               AMD_PG_STATE_GATE);
>>>> -        amdgpu_device_ip_set_clockgating_state(adev,
>>>> AMD_IP_BLOCK_TYPE_VCE,
>>>> -                               AMD_CG_STATE_GATE);
>>>> -    }
>>>> -
>>>>       if (!amdgpu_sriov_vf(adev)) {
>>>>           /* vce_v4_0_wait_for_idle(handle); */
>>>>           vce_v4_0_stop(adev);
>>>> @@ -596,6 +575,29 @@ static int vce_v4_0_suspend(void *handle)
>>>>           drm_dev_exit(idx);
>>>>       }
>>>>   +    /*
>>>> +     * Proper cleanups before halting the HW engine:
>>>> +     *   - cancel the delayed idle work
>>>> +     *   - enable powergating
>>>> +     *   - enable clockgating
>>>> +     *   - disable dpm
>>>> +     *
>>>> +     * TODO: to align with the VCN implementation, move the
>>>> +     * jobs for clockgating/powergating/dpm setting to
>>>> +     * ->set_powergating_state().
>>>> +     */
>>>> +    cancel_delayed_work_sync(&adev->vce.idle_work);
>>>> +
>>>> +    if (adev->pm.dpm_enabled) {
>>>> +        amdgpu_dpm_enable_vce(adev, false);
>>>> +    } else {
>>>> +        amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>>> +        amdgpu_device_ip_set_powergating_state(adev,
>>>> AMD_IP_BLOCK_TYPE_VCE,
>>>> +                               AMD_PG_STATE_GATE);
>>>> +        amdgpu_device_ip_set_clockgating_state(adev,
>>>> AMD_IP_BLOCK_TYPE_VCE,
>>>> +                               AMD_CG_STATE_GATE);
>>>> +    }
>>>> +
>>>>       r =3D vce_v4_0_hw_fini(adev);
>>>>       if (r)
>>>>           return r;
>>>>

--_000_CH0PR12MB534811900AA6A49C74658BCB97DC9CH0PR12MB5348namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Ah.. didn't notice that. As I mentioned, it's mainly a cosmetic/semantic th=
ing. AFAIU, hw_fini() is expected to be called once when hw is removed/rese=
t or driver is removed. Suspend is temporary and may be called multiple tim=
es during the lifetime. So calling
 hw_fini() from suspend() appears a bit odd (probably just for me).</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
If it's worth, something like this -</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
vce_4_2_suspend() {</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
__vce_4_2_suspend();</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
....</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
// Anything extra</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
}</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
vce_4_2_hw_fini() {</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
__vce_4_2_suspend();</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
}</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto"><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Grodzovsky, Andrey &l=
t;Andrey.Grodzovsky@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 16, 2021 9:47:41 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan=
@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix crash on device remove/driver u=
nload</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 2021-09-16 11:51 a.m., Lazar, Lijo wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 9/16/2021 9:15 PM, Andrey Grodzovsky wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 2021-09-16 4:20 a.m., Lazar, Lijo wrote:<br>
&gt;&gt;&gt; A minor comment below.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 9/16/2021 1:11 AM, Andrey Grodzovsky wrote:<br>
&gt;&gt;&gt;&gt; Crash:<br>
&gt;&gt;&gt;&gt; BUG: unable to handle page fault for address: 000000000000=
10e1<br>
&gt;&gt;&gt;&gt; RIP: 0010:vega10_power_gate_vce+0x26/0x50 [amdgpu]<br>
&gt;&gt;&gt;&gt; Call Trace:<br>
&gt;&gt;&gt;&gt; pp_set_powergating_by_smu+0x16a/0x2b0 [amdgpu]<br>
&gt;&gt;&gt;&gt; amdgpu_dpm_set_powergating_by_smu+0x92/0xf0 [amdgpu]<br>
&gt;&gt;&gt;&gt; amdgpu_dpm_enable_vce+0x2e/0xc0 [amdgpu]<br>
&gt;&gt;&gt;&gt; vce_v4_0_hw_fini+0x95/0xa0 [amdgpu]<br>
&gt;&gt;&gt;&gt; amdgpu_device_fini_hw+0x232/0x30d [amdgpu]<br>
&gt;&gt;&gt;&gt; amdgpu_driver_unload_kms+0x5c/0x80 [amdgpu]<br>
&gt;&gt;&gt;&gt; amdgpu_pci_remove+0x27/0x40 [amdgpu]<br>
&gt;&gt;&gt;&gt; pci_device_remove+0x3e/0xb0<br>
&gt;&gt;&gt;&gt; device_release_driver_internal+0x103/0x1d0<br>
&gt;&gt;&gt;&gt; device_release_driver+0x12/0x20<br>
&gt;&gt;&gt;&gt; pci_stop_bus_device+0x79/0xa0<br>
&gt;&gt;&gt;&gt; pci_stop_and_remove_bus_device_locked+0x1b/0x30<br>
&gt;&gt;&gt;&gt; remove_store+0x7b/0x90<br>
&gt;&gt;&gt;&gt; dev_attr_store+0x17/0x30<br>
&gt;&gt;&gt;&gt; sysfs_kf_write+0x4b/0x60<br>
&gt;&gt;&gt;&gt; kernfs_fop_write_iter+0x151/0x1e0<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Why:<br>
&gt;&gt;&gt;&gt; VCE/UVD had dependency on SMC block for their suspend but<=
br>
&gt;&gt;&gt;&gt; SMC block is the first to do HW fini due to some constrain=
ts<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; How:<br>
&gt;&gt;&gt;&gt; Since the original patch was dealing with suspend issues<b=
r>
&gt;&gt;&gt;&gt; move the SMC block dependency back into suspend hooks as<b=
r>
&gt;&gt;&gt;&gt; was done in V1 of the original patches.<br>
&gt;&gt;&gt;&gt; Keep flushing idle work both in suspend and HW fini seuqnc=
es<br>
&gt;&gt;&gt;&gt; since it's essential in both cases.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Fixes:<br>
&gt;&gt;&gt;&gt; 2178d3c189b9 drm/amdgpu: add missing cleanups for more ASI=
Cs on <br>
&gt;&gt;&gt;&gt; UVD/VCE suspend<br>
&gt;&gt;&gt;&gt; ee6679aaa61c drm/amdgpu: add missing cleanups for Polaris1=
2 UVD/VCE <br>
&gt;&gt;&gt;&gt; on suspend<br>
&gt;&gt;&gt;&gt; Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@amd=
.com&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++=
-------<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++=
-------<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 24 ++++++++=
-------<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 32 ++++++++=
++---------<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 19 +++++++-=
----<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 28 ++++++++=
+--------<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 44 <br>
&gt;&gt;&gt;&gt; ++++++++++++++-------------<br>
&gt;&gt;&gt;&gt; &nbsp; 7 files changed, 105 insertions(+), 90 deletions(-)=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c<br>
&gt;&gt;&gt;&gt; index 7232241e3bfb..0fef925b6602 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c<br>
&gt;&gt;&gt;&gt; @@ -698,6 +698,19 @@ static int uvd_v3_1_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; &nbsp; + cancel_delayed_work_sync(&amp;adev-&gt;uvd.idle_w=
ork);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=3D 0)<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v3_1_stop(=
adev);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +static int uvd_v3_1_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups bef=
ore halting the HW engine:<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cance=
l the delayed idle work<br>
&gt;&gt;&gt;&gt; @@ -722,17 +735,6 @@ static int uvd_v3_1_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GA=
TE);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=3D 0=
)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v3_1_stop(=
adev);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -static int uvd_v3_1_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v3_1_hw_fini(adev=
);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &quot;cosmetic change&quot; comment - hw_fini is supposed to b=
e the final tear <br>
&gt;&gt;&gt; down call. So instead of suspend calling hw_fini, perhaps it m=
akes <br>
&gt;&gt;&gt; sense to read the other way - hw_fini just suspends the hardwa=
re?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Lijo<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Not sure what you mean ?<br>
&gt;<br>
&gt; Now it is - suspend()-&gt; calls hw_fini()<br>
&gt;<br>
&gt; What I meant is hw_fini() -&gt; calls suspend() and that is read as &q=
uot;to <br>
&gt; do hw_fini() only suspend the hardware and nothing extra is needed&quo=
t;.<br>
&gt;<br>
&gt; In short implementation stays in suspend() and hw_fini() calls suspend=
().<br>
<br>
<br>
Sorry, still confused, what about amdgpu_vce_suspend being called from <br>
vce_v4_0_suspend for example - we don't want that to be called from hw_fini=
.<br>
Can you maybe show draft change of what you mean for one specific UVD or <b=
r>
VCE version ?<br>
<br>
Andrey<br>
<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Andrey<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&gt;&gt;&gt;&gt; index 52d6de969f46..c108b8381795 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&gt;&gt;&gt;&gt; @@ -212,6 +212,19 @@ static int uvd_v4_2_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; &nbsp; + cancel_delayed_work_sync(&amp;adev-&gt;uvd.idle_w=
ork);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=3D 0)<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v4_2_stop(=
adev);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +static int uvd_v4_2_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups bef=
ore halting the HW engine:<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cance=
l the delayed idle work<br>
&gt;&gt;&gt;&gt; @@ -236,17 +249,6 @@ static int uvd_v4_2_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GA=
TE);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=3D 0=
)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v4_2_stop(=
adev);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -static int uvd_v4_2_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v4_2_hw_fini(adev=
);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt;&gt;&gt;&gt; index db6d06758e4d..563493d1f830 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&gt;&gt;&gt;&gt; @@ -210,6 +210,19 @@ static int uvd_v5_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; &nbsp; + cancel_delayed_work_sync(&amp;adev-&gt;uvd.idle_w=
ork);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=3D 0)<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v5_0_stop(=
adev);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +static int uvd_v5_0_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups bef=
ore halting the HW engine:<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cance=
l the delayed idle work<br>
&gt;&gt;&gt;&gt; @@ -234,17 +247,6 @@ static int uvd_v5_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GA=
TE);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (RREG32(mmUVD_STATUS) !=3D 0=
)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v5_0_stop(=
adev);<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -static int uvd_v5_0_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v5_0_hw_fini(adev=
);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt;&gt;&gt;&gt; index b6e82d75561f..1fd9ca21a091 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt;&gt;&gt;&gt; @@ -606,6 +606,23 @@ static int uvd_v7_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; &nbsp; + cancel_delayed_work_sync(&amp;adev-&gt;uvd.idle_w=
ork);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v7_0_stop(=
adev);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; else {<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* full access=
 mode, so don't touch any UVD register */<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quo=
t;For SRIOV client, shouldn't do anything.\n&quot;);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +static int uvd_v7_0_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups bef=
ore halting the HW engine:<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cance=
l the delayed idle work<br>
&gt;&gt;&gt;&gt; @@ -630,21 +647,6 @@ static int uvd_v7_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GA=
TE);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v7_0_stop(=
adev);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; else {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* full access=
 mode, so don't touch any UVD register */<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quo=
t;For SRIOV client, shouldn't do anything.\n&quot;);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -static int uvd_v7_0_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v7_0_hw_fini(adev=
);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt;&gt;&gt;&gt; index 84e488f189f5..67eb01fef789 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt;&gt;&gt;&gt; @@ -481,6 +481,17 @@ static int vce_v2_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; &nbsp; + cancel_delayed_work_sync(&amp;adev-&gt;vce.idle_w=
ork);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +static int vce_v2_0_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups bef=
ore halting the HW engine:<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cance=
l the delayed idle work<br>
&gt;&gt;&gt;&gt; @@ -504,14 +515,6 @@ static int vce_v2_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GA=
TE);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -static int vce_v2_0_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vce_v2_0_hw_fini(adev=
);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt;&gt;&gt;&gt; index 2a18c1e089fd..142e291983b4 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt;&gt;&gt;&gt; @@ -492,6 +492,21 @@ static int vce_v3_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; &nbsp; + cancel_delayed_work_sync(&amp;adev-&gt;vce.idle_w=
ork);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; r =3D vce_v3_0_wait_for_idle(handle);<=
br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; vce_v3_0_stop(adev);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return vce_v3_0_set_clockgating_state(=
adev, AMD_CG_STATE_GATE);<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +static int vce_v3_0_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups bef=
ore halting the HW engine:<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cance=
l the delayed idle work<br>
&gt;&gt;&gt;&gt; @@ -515,19 +530,6 @@ static int vce_v3_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GA=
TE);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; r =3D vce_v3_0_wait_for_idle(ha=
ndle);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; vce_v3_0_stop(adev);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; return vce_v3_0_set_clockgating_state(=
adev, AMD_CG_STATE_GATE);<br>
&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -static int vce_v3_0_suspend(void *handle)<br>
&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct=
 amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vce_v3_0_hw_fini(adev=
);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&gt;&gt;&gt;&gt; index 044cf9d74b85..226b79254db8 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&gt;&gt;&gt;&gt; @@ -544,29 +544,8 @@ static int vce_v4_0_hw_fini(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before halting=
 the HW engine:<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the delay=
ed idle work<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergati=
ng<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgati=
ng<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN im=
plementation, move the<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergati=
ng/dpm setting to<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().<=
br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&a=
mp;adev-&gt;vce.idle_work);<br>
&gt;&gt;&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<=
br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_ena=
ble_vce(adev, false);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_se=
t_vce_clocks(adev, 0, 0);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_=
ip_set_powergating_state(adev, <br>
&gt;&gt;&gt;&gt; AMD_IP_BLOCK_TYPE_VCE,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_=
ip_set_clockgating_state(adev, <br>
&gt;&gt;&gt;&gt; AMD_IP_BLOCK_TYPE_VCE,<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))=
 {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
vce_v4_0_wait_for_idle(handle); */<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce=
_v4_0_stop(adev);<br>
&gt;&gt;&gt;&gt; @@ -596,6 +575,29 @@ static int vce_v4_0_suspend(void *han=
dle)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm=
_dev_exit(idx);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; &nbsp; +&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * Proper cleanups before halting=
 the HW engine:<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - cancel the delay=
ed idle work<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable powergati=
ng<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - enable clockgati=
ng<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - disable dpm<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * TODO: to align with the VCN im=
plementation, move the<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * jobs for clockgating/powergati=
ng/dpm setting to<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * -&gt;set_powergating_state().<=
br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&gt=
;vce.idle_work);<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_ena=
ble_vce(adev, false);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_se=
t_vce_clocks(adev, 0, 0);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_=
ip_set_powergating_state(adev, <br>
&gt;&gt;&gt;&gt; AMD_IP_BLOCK_TYPE_VCE,<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_=
ip_set_clockgating_state(adev, <br>
&gt;&gt;&gt;&gt; AMD_IP_BLOCK_TYPE_VCE,<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_STATE_GATE);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vce_v4_0_hw_fini(adev=
);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn r;<br>
&gt;&gt;&gt;&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB534811900AA6A49C74658BCB97DC9CH0PR12MB5348namp_--
