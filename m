Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CAC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD219208C9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 07:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yVIe3mfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD219208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBE289DA9;
	Fri, 28 Aug 2020 07:09:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7EF89DA9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 07:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buyu5DoEuLZM+tl3z+GOgZGxDTXrswpA3p5XeFhDcLVS2NdLriX6VgtO4VuiDEwmjpJW0bXiXRs3jpRK4/QvO+du1CCNpTLZpihu/K0TRep0Zw6nvEbHdFC/VrO9orewlLCQD1S3E8ceJkUNOSRBXL3gEhH54etRbgKLR843OVky7wadudqSmhRocJIMUe23vEstODzqDykmypVkIhL3D1TpFjOkX0uKHFimnkMXiglJQ52pnf4Q1t8C3T63g23XFrNPcxj/S8+IaORwdVqlIhTsc00aTL2zmYcreYazFP1/c5dEuVziIzaDYjM0r796sftyxfmIGqvf7iLsf2DeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNSEPYXnD3sMEnUqWFtFjL5yCU/zb4PpyMVX0jlPI4E=;
 b=SgrPz+8b/MjmZ1e2aNk8UfXds3fUD8y3/oXOjS4zbosC/NDEDrYmLekgjTqy/4UcwXuJjE0QVh99fmfipVGNM95o+tPf8wqUGKzAKkZnMM2qG1Gqr2mL+b+sy/xr1Naonc+6yScmRAZGPMoGGaXl3nGEBLOX+OmAejTlG0Wb/XAPyEaiJJa9ZbIxQH6Kvps4SdrdtN2w1hOYf65hRv/miyVIpTT4idDsKpPdXBBW+6jkpUWVmsJqiliCrjELKM2MUI+zL05mWx6aLTdDB1gAqUSmbHx05sWhN4DbGMLgnNYuYx4gEXhjLEsvRwGChHxah5V2mw1WDVkKxpQij50jsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNSEPYXnD3sMEnUqWFtFjL5yCU/zb4PpyMVX0jlPI4E=;
 b=yVIe3mfAdbDj9zuuMt4aYwFXT7yyorS2I2GAr1g5jG8ddCi5wCfvzL+e6dqWyKs78kocwUQvv2E7jxQOP1O4pk4a3Rc92XKmTgJDhBcZPL/72xVjYuuzQBaOtKKpceE5jzaHviL5RoQ3Pw/DG+ZDVVnKZUhCicmMq5HnPL/UZ80=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 07:09:35 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 07:09:35 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "Das, Nirmoy"
 <Nirmoy.Das@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200827151858.55326-1-nirmoy.das@amd.com>
 <BY5PR12MB4115985F3DA93723F8D2B82B8F520@BY5PR12MB4115.namprd12.prod.outlook.com>
 <46f0841d-a2d9-88d2-9a53-46f07578532d@amd.com>
 <DM6PR12MB417063D80DDF8EB22D0E0FD4F8520@DM6PR12MB4170.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <fbb9d8c3-3e99-b577-ea25-0f83d30cf5e2@amd.com>
Date: Fri, 28 Aug 2020 09:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <DM6PR12MB417063D80DDF8EB22D0E0FD4F8520@DM6PR12MB4170.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:405:14::11) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR16CA0025.namprd16.prod.outlook.com (2603:10b6:405:14::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 07:09:34 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af2f2358-4307-4800-d7f3-08d84b215216
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2456A8AA04FF4CC5FB3BF1378B520@DM5PR12MB2456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/CSvjYiz8B7JcJqjcm5olNO5RiOBEZqxIyragGieIiEu7pwhJGgP553/jiTShSxmUx9TKbQHESjLvuHK+lu2nGM0FVwqyKpkz6GSQCCkPb9+L6fGZ63pLXzrDGjx4AS8iqYpa6QHTTqFZOLoOsVQAwdo+s60cfd1mdqjGZwb3IrIj2WALwvUmtgx4ax5vye8BqUtMdu2bmu8WAeENoK25p5wlrq/5WKBvp+t8kvnM1gFIWmSQ8wudfYjAXBS35ZOSi/OygMO4HCWc9LMukXBXysQuuGU7rJ/xQcxTOZGXec3GkaQiF89FFVCu26+nbhEugJ/tBl+d9Hx1SciHR2tfKhE9OF7Xj3hi4XFTopq1nQYlWiRwWdqpX9VBN0Cj0S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(16576012)(316002)(4326008)(8676002)(53546011)(83380400001)(36756003)(5660300002)(186003)(26005)(110136005)(956004)(66476007)(66946007)(52116002)(66556008)(31696002)(2616005)(54906003)(6486002)(31686004)(2906002)(8936002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WcZXfW1lrQoca0Lb9QeqU6t0qooL6coIzAKc7NTaHiNGVtp+01dv67Rt+Ub1ZuK11S+B4+PQdyY041UkAZDKH05mvT2h8bzAEaFdzmL6NyOGeXTDwZGOJjNO8PvCnzzHRmktGuZAGNoMoGs76QuAtMEO54+H4wnVUE8K2skfdCXkNz9lEc22cGk+F+2agl5YdyDlpcl3wm0ofcUounNXyVNL78BqZ8mFN2ToADlTBiPsU1be5oDtNKbaF5mxuujq/hvTJEJdeLyh+DdQnNKzmnpqJbjMs78dYfC7E5dNYo1uQ1AcNPQuPdqZ2NG7nzNm+iYf0c8MhLOm6KQjSXZc9E6vaDnXDzE/4ctIP9YArZ+4/AnRoZsayIvQZ0+XhL9NnKziIb69AeeyMgZ+3bmerFk9DKXcRJiA0yh8jXCEvnHfVPDs5jsIBb5EUnzofO+rOYQL2/jnF/rn0f99wgQT5L5iMx/q5ONuIvbxzMTqQ7zqsis87Rv4K0asWZrpdR/1WCaHV4wx3fkzUoTsvg/IF1d5UJ0KvWpMVW10kS6hjyFsdjcGLFYYSySDe+j3OOC/9y+1Qc2rdCNezjfI1+SjgFM45U/2WPJr/BYkOm/yBkOsAwtnPfIL+bVjTe05I8ju6x3hpXIOHUz6wniwmdwyNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2f2358-4307-4800-d7f3-08d84b215216
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 07:09:35.8286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv/zBf9jCZaNQwshaHr92VlKlaKHziVSdYpHjJeXPPGnOI4YJi/7JFy/E4c9LYS2x2g5ndKKlkwmrSMCjB6ktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


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
> To: Deng, Emily <Emily.Deng@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
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
> are consistent. The last patch from Jiawei only touched amdgpu_device_ip_reinit_early_sriov(), same optimization should apply
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
>>> -static enum amd_ip_block_type ip_order[] = { -AMD_IP_BLOCK_TYPE_GMC,
>>> -AMD_IP_BLOCK_TYPE_COMMON, -AMD_IP_BLOCK_TYPE_PSP,
>>> -AMD_IP_BLOCK_TYPE_IH, -};
>>> +static int amdgpu_device_ip_reinit_sriov(struct amdgpu_device *adev,
>>> +const int is_early) { int i;
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
>>> -static enum amd_ip_block_type ip_order[] = { -AMD_IP_BLOCK_TYPE_SMC,
>>> -AMD_IP_BLOCK_TYPE_DCE, -AMD_IP_BLOCK_TYPE_GFX,
>>> -AMD_IP_BLOCK_TYPE_SDMA, -AMD_IP_BLOCK_TYPE_UVD,
>>> -AMD_IP_BLOCK_TYPE_VCE, -AMD_IP_BLOCK_TYPE_VCN -};
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
