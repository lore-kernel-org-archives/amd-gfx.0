Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7DDC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAFC20776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d+4A2i5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAFC20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0536E323;
	Fri, 28 Aug 2020 07:39:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF0B6E323
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 07:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm9GiI7gy1GSKCBXFUSKK1JBWcCbOPKTUetX3aE0r84mcQHHCQOJmzPRp5QbGd26jYbrgz9dKH8ot/+J3K2myujBwjndq3fxeHVc9YDZKZGXMYEj6/hKYSBOqzz97AGUZRuLoQ2UBT3UMuMY6sTBxa01fQALvmA2H9IvXyoL18NswfY7/5H9VR9Bs6JXxXAesyhnc33NOr8ZpYSWxW0PJN5TNDETpMQm7HcTLlTOEMsBzr80MOhS1r/CfqQ/mGdDQJLNFS5V40Zj1sNfZLMmQkNStfratMEh6aBLx73JVnYkFFo5S+pvmBBABLwHSlgguzP++LKo8eQFHuu2EuDAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pvgnwO7ucu/0k750deJCR09ejDwnC82I4Qj58ii9jI=;
 b=NimGWQsEjeIYlr6IQ/QtFPDs1JvIQx3/hooKur6CdUWkT/UPAKJMg0X6Nbpe0tc7xVKAoIR0qITkatkwHhytFlQbw6JJ7Ho/u6T4qycsSO17uMxtO61xtmFC06eDtV95ddu6J2IM0SJjC8mwbdPFf+tq0k97K0fOwFbozoD4I+p0o/B78Wm2jWy3I7x0rUchrOmWVXB12BPNlQCzpGIMy7/cS6ASZ/M2Xrr4rvku0IYwPAOPlb+aABsIPx3Iq8powa30XdzliJZYw4rldHIWeV44Cs7w+t387gzipaHSvp6IkHrf5lOcXLkCBnAYrchNl7S/z67RezvchZH8zYgTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pvgnwO7ucu/0k750deJCR09ejDwnC82I4Qj58ii9jI=;
 b=d+4A2i5QnKUZ1Nl6VBIJ/QkhDwGOmfDkEJKWWDAOLYa7HVwzIhiFTiRYtzEIdbSNVq6pEtOEhClcPGf+KwIRFETc5+TYtbVnAgtAgjByNlsPrvBzS7k9//DI1drbRilpOMukXBqYXaLYks+PSgeoIA/Lt+P7Ebp6p2ethSAJ7Cg=
Received: from DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20)
 by DM5PR12MB1769.namprd12.prod.outlook.com (2603:10b6:3:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 28 Aug
 2020 07:39:30 +0000
Received: from DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::c4db:d26e:cf5f:ac68]) by DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::c4db:d26e:cf5f:ac68%4]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 07:39:30 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Thread-Topic: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Thread-Index: AQHWfITdQ1z7sECVu0aBMJ6rTYV8qqlMuJKAgABYoQCAAAY/8IAABQWAgAAFk3A=
Date: Fri, 28 Aug 2020 07:39:30 +0000
Message-ID: <DM6PR12MB4170D9136E7EBEA394CA4948F8520@DM6PR12MB4170.namprd12.prod.outlook.com>
References: <20200827151858.55326-1-nirmoy.das@amd.com>
 <BY5PR12MB4115985F3DA93723F8D2B82B8F520@BY5PR12MB4115.namprd12.prod.outlook.com>
 <46f0841d-a2d9-88d2-9a53-46f07578532d@amd.com>
 <DM6PR12MB417063D80DDF8EB22D0E0FD4F8520@DM6PR12MB4170.namprd12.prod.outlook.com>
 <fbb9d8c3-3e99-b577-ea25-0f83d30cf5e2@amd.com>
In-Reply-To: <fbb9d8c3-3e99-b577-ea25-0f83d30cf5e2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-28T07:39:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=16a09c0c-2ff8-4e42-829e-0000fa1d1018;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-28T07:39:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 154f8fb4-01f8-4eb0-9d92-0000c7812ab5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebbf6fd1-e47d-4466-7bf6-08d84b257ff0
x-ms-traffictypediagnostic: DM5PR12MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1769250A12D0C561F9F3B831F8520@DM5PR12MB1769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /qA2aKlyR1DVZbi6urHF6RA1667SJ69YbLKxfuhVtqrqHxPykXm6u348RiHkbQ4IDuTDKmnVRCfZqn2Utrz4+4tT7o59/muMfUoQ1KcZH3v9bhTjyCdqc1IR4Usf2ZkLX2UjBIrgOXG3VHW1k7gD5JgaZwmGm+1wFSBQ+DeJzABKkbZIqwLUatBkyDALNv4ZAJ8Fq8d2ZpWVHX6mLVH9u0zkr2hehEcg8fMmy88mNp6JR7oKSlaSvDnNnzXeQtktmLSehGW32X26OekswHqIQjQM2YhWL7xJE12FWR67f95V1EY8PJMrrwpj1HIVkHRfpzqOpeY2rb2BQlZyh/G3Pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(5660300002)(71200400001)(4326008)(66446008)(66556008)(66476007)(64756008)(54906003)(33656002)(478600001)(9686003)(55016002)(83380400001)(52536014)(86362001)(110136005)(53546011)(6506007)(7696005)(8936002)(2906002)(316002)(8676002)(186003)(66946007)(76116006)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WKPJx5puPxnZZp7+TRYgW8DFc3jvzIj61sYu+YfY11hXU5oRl2zGQ9RzH4twwPVmXB8GQORwjUJty8VvVGJsURCX4u+kcxDjTYE5kSQ1M3cJApkLXFlBdRg4u2oXKijsBbfDqoVnB0N5W2f+2+qTDu17ms8NXFPMYvpoCu6HKp+QP9Obr9zF6UAHrL2IWNIt44j2N8N6xCNd0X6YJMUQP2Nf/gO716JEAWK0N31BHqL12uGLz+uUqhvQ5vjN3jZNGpQXT6KOPB/xsxIAyHpvbwr+0pa4ZP2/zfJJ3RV87AHxuzTWvT8WN8CYim2W7IwG6DzH2ujV5mAHbho2mNyZIDPDH195WxbiYV/emOr2deHUqAAyVwDUbqH0eoAWlWA5UOaSCxLi7GNOgayR6Vdidp27a0c9MuQ/Udiy1PxH8wE+C8+QP4KTe/jFyENS15G9q1m6jBfJlgpRaTkNThD35uGUozuiZRfzhiQO5cm0PS51uIyAUpwZntgRAcwyB6TZM0dNqb+61JGsSMzCByHGzAIsQWh5oDVXUBeZlKPUXKURdKBDUo6vDHQxKUYDbUFYcCMWLMqt/+ikrcUXoHMU/6N2qZK8hUNLFLr2k9AEsHHAivNd/9ngDdinmlc9V4k6ByvzD+KK6gBwg0suCHRv9Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbf6fd1-e47d-4466-7bf6-08d84b257ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 07:39:30.4090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6EI0ARVBPHrqxF1cMQuupqf+CJdB1HprDPrNGL4bXQWyHPd2EEoSBmKCpuIlH8K4IcAKjyl61eGpSAOJ3E7Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1769
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Per Monk and Emily's suggestion, I will not submit another patch to make amdgpu_device_ip_reinit_late_sriov()
and amdgpu_device_ip_reinit_early_sriov() consistent.
There's already no logic bug, the little difference in loop layer order does no harm.

Sorry about missing the amdgpu_device_ip_reinit_late_sriov() part.

Best regards,
Jiawei

-----Original Message-----
From: Das, Nirmoy <Nirmoy.Das@amd.com> 
Sent: Friday, August 28, 2020 3:14 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>; Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov


On 8/28/20 8:58 AM, Gu, JiaWei (Will) wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Nirmoy,
>
> I also found amdgpu_device_ip_reinit_late_sriov() part is missed.
> Will push another patch to make them consistent soon.


Thanks, Jiawei.


Nirmoy


>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Das, Nirmoy <Nirmoy.Das@amd.com>
> Sent: Friday, August 28, 2020 2:33 PM
> To: Deng, Emily <Emily.Deng@amd.com>; Das, Nirmoy 
> <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk 
> <Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Subject: Re: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
>
>
> On 8/28/20 3:16 AM, Deng, Emily wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Hi Nirmoy,
>>       Still think the original logical is more clear.
>
> No problem but we should at least make sure
> amdgpu_device_ip_reinit_late_sriov() and
> amdgpu_device_ip_reinit_early_sriov()
>
> are consistent. The last patch from Jiawei only touched 
> amdgpu_device_ip_reinit_early_sriov(), same optimization should apply
>
> to amdgpu_device_ip_reinit_late_sriov()
>
>
> Regards,
>
> Nirmoy
>
>
>> Best wishes
>> Emily Deng
>>
>>
>>
>>> -----Original Message-----
>>> From: Das, Nirmoy <Nirmoy.Das@amd.com>
>>> Sent: Thursday, August 27, 2020 11:19 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk 
>>> <Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Deng, 
>>> Emily <Emily.Deng@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
>>> Subject: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
>>>
>>> This patch removes some unwanted code duplication and simplifies 
>>> sriov's ip block reinit logic.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 117
>>> +++++++++++----------
>>> 1 file changed, 60 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 696a61cc3ac6..0db6db03bcd3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2587,77 +2587,80 @@ int amdgpu_device_ip_suspend(struct 
>>> amdgpu_device *adev) return r; }
>>>
>>> -static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device
>>> *adev)
>>> +/** amdgpu_device_is_early_ip_block_sriov - check for early 
>>> +ip_blocks
>>> + *
>>> + * @ip_block: ip block that need to be check
>>> + *
>>> + * Returns a tri-state value for a given ip block.
>>> + * If an ip block requires early reinit sriov then return 1 or 0 otherwise.
>>> + * Return -1 on invalid ip block.
>>> + *
>>> + */
>>> +
>>> +static int
>>> +amdgpu_device_is_early_ip_block_sriov(const enum amd_ip_block_type
>>> +ip_block)
>>> {
>>> -int i, r;
>>> +switch (ip_block) {
>>> +/* early ip blocks */
>>> +case AMD_IP_BLOCK_TYPE_GMC:
>>> +case AMD_IP_BLOCK_TYPE_COMMON:
>>> +case AMD_IP_BLOCK_TYPE_PSP:
>>> +case AMD_IP_BLOCK_TYPE_IH:
>>> +return 1;
>>> +/* late ip blocks */
>>> +case AMD_IP_BLOCK_TYPE_SMC:
>>> +case AMD_IP_BLOCK_TYPE_DCE:
>>> +case AMD_IP_BLOCK_TYPE_GFX:
>>> +case AMD_IP_BLOCK_TYPE_SDMA:
>>> +case AMD_IP_BLOCK_TYPE_UVD:
>>> +case AMD_IP_BLOCK_TYPE_VCE:
>>> +case AMD_IP_BLOCK_TYPE_VCN:
>>> +return 0;
>>> +/* invalid ip block */
>>> +default:
>>> +return -1;
>>> +}
>>> +}
>>>
>>> -static enum amd_ip_block_type ip_order[] = { 
>>> -AMD_IP_BLOCK_TYPE_GMC, -AMD_IP_BLOCK_TYPE_COMMON, 
>>> -AMD_IP_BLOCK_TYPE_PSP, -AMD_IP_BLOCK_TYPE_IH, -};
>>> +static int amdgpu_device_ip_reinit_sriov(struct amdgpu_device 
>>> +*adev, const int is_early) { int i;
>>>
>>> for (i = 0; i < adev->num_ip_blocks; i++) { -int j;
>>> +int r = 0;
>>> +bool init_ip;
>>> struct amdgpu_ip_block *block;
>>> +enum amd_ip_block_type ip_block;
>>>
>>> block = &adev->ip_blocks[i];
>>> block->status.hw = false;
>>> +ip_block = block->version->type;
>>> +init_ip = (is_early ==
>>> +   amdgpu_device_is_early_ip_block_sriov(ip_block));
>>>
>>> -for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
>>> -
>>> -if (block->version->type != ip_order[j] ||
>>> -!block->status.valid)
>>> -continue;
>>> +if (!init_ip ||
>>> +    (!is_early && block->status.hw) ||
>>> +    !block->status.valid)
>>> +continue;
>>>
>>> -r = block->version->funcs->hw_init(adev);
>>> -DRM_INFO("RE-INIT-early: %s %s\n", block->version-
>>>> funcs->name, r?"failed":"succeeded");
>>> -if (r)
>>> -return r;
>>> -block->status.hw = true;
>>> +if (init_ip && (ip_block == AMD_IP_BLOCK_TYPE_SMC)) { r =
>>> +block->version->funcs->resume(adev);
>>> +goto show_log;
>>> }
>>> -}
>>> -
>>> -return 0;
>>> -}
>>>
>>> -static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device
>>> *adev) -{ -int i, r;
>>> -
>>> -static enum amd_ip_block_type ip_order[] = { 
>>> -AMD_IP_BLOCK_TYPE_SMC, -AMD_IP_BLOCK_TYPE_DCE, 
>>> -AMD_IP_BLOCK_TYPE_GFX, -AMD_IP_BLOCK_TYPE_SDMA, 
>>> -AMD_IP_BLOCK_TYPE_UVD, -AMD_IP_BLOCK_TYPE_VCE, 
>>> -AMD_IP_BLOCK_TYPE_VCN -};
>>> -
>>> -for (i = 0; i < ARRAY_SIZE(ip_order); i++) { -int j; -struct 
>>> amdgpu_ip_block *block;
>>> +if (init_ip)
>>> +r = block->version->funcs->hw_init(adev);
>>>
>>> -for (j = 0; j < adev->num_ip_blocks; j++) { -block = 
>>> &adev->ip_blocks[j];
>>> +show_log:
>>> +DRM_INFO("RE-INIT-%s: %s %s\n", is_early ? "early":"late",
>>> + block->version->funcs->name, r ?
>>> "failed":"succeeded");
>>>
>>> -if (block->version->type != ip_order[i] || -!block->status.valid ||
>>> -block->status.hw)
>>> -continue;
>>> +if (r)
>>> +return r;
>>>
>>> -if (block->version->type ==
>>> AMD_IP_BLOCK_TYPE_SMC)
>>> -r = block->version->funcs->resume(adev);
>>> -else
>>> -r = block->version->funcs->hw_init(adev);
>>> +block->status.hw = true;
>>>
>>> -DRM_INFO("RE-INIT-late: %s %s\n", block->version-
>>>> funcs->name, r?"failed":"succeeded");
>>> -if (r)
>>> -return r;
>>> -block->status.hw = true;
>>> -}
>>> }
>>>
>>> return 0;
>>> @@ -3901,7 +3904,7 @@ static int amdgpu_device_reset_sriov(struct 
>>> amdgpu_device *adev, amdgpu_amdkfd_pre_reset(adev);
>>>
>>> /* Resume IP prior to SMC */
>>> -r = amdgpu_device_ip_reinit_early_sriov(adev);
>>> +r = amdgpu_device_ip_reinit_sriov(adev, 1);
>>> if (r)
>>> goto error;
>>>
>>> @@ -3914,7 +3917,7 @@ static int amdgpu_device_reset_sriov(struct 
>>> amdgpu_device *adev, return r;
>>>
>>> /* now we are okay to resume SMC/CP/SDMA */ -r = 
>>> amdgpu_device_ip_reinit_late_sriov(adev);
>>> +r = amdgpu_device_ip_reinit_sriov(adev, 0);
>>> if (r)
>>> goto error;
>>>
>>> --
>>> 2.28.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
