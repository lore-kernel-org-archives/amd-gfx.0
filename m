Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79A2C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 06:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987F920825
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 06:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e7Rb8odF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987F920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7C06E13C;
	Fri, 28 Aug 2020 06:59:03 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B382B6E13C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 06:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1nfloLS6cdnxD7taC8qEzFZjkz2Ju/cRcTsTMyANiOQqJZ9jB7azFE0jIosglWUUFp2D7OKYG9aZ78U6rPtn7sX5kmHJD4gg9jZYdV3QvMM2WTd9S1eKLE6rK1Fxcr3fDraesa0OfM9o9/VnfxjHOWgGmqng/FTARsTu29ID5Mdae0do86tD/GPi5bhMpRRW6rP58Oqd5JA4mdTOgkYB74BzGWCiNDh49jLT1Lf2r5T14qYHdlsGqqXeA6Y4kft3mdw6nyyCpXMf5WuezTsvmtKZ61JJjRGnduhBVTgs6OfnR4gINWgxkRB3bq3GhcNh19Op5Tyf2CZg28sdmclwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM1YVEV+3RXpOyb32wqfsqZdjXemSKyVl1g2mO9/TLI=;
 b=Lpgs4Qd50LhEoyH6f9EE3es8oDizv+dUl/nVTL9ZUIZ8mR7W781UhWks5ImJec9NNkXOl0cvYSFam0tpmqiUvLuMUB0jiILHC2XFNnAaXtL05s8WrTh8g385b69Izsa5P6vDR7aE2DHPaSe3sYwX9HNipfovT7JP3NmEu1HsC71DpfhDIp0nZXLZlRMX0Swthh8lj5RaYbrL+T73VvcDfac+5hn5yODe3YxI+hiykt7zVy99TGiFTLKa8M7afAn/CuC+gqHShHrnleUTug+Yj+J08QYP4yjbE5k2jcQnAYXCh8XZBG5N1XDu7RmEiDMlSGTGCy4RsYCjIQNJJ2fLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM1YVEV+3RXpOyb32wqfsqZdjXemSKyVl1g2mO9/TLI=;
 b=e7Rb8odFRCvUoehTkUsYQBBFu1Irqbv+P7ZHCfWkc902E3j1twYlLclm7eHorqNtD/grhOl05YgvJb4qOAuKADqGePnfPCAkApMpx1s7A2Adzb+FS37GvEBUrVnlLGa6j22iQuFY021Nz4NX2Nvf+6cUtZI0Uc7wBI1V/j9whoc=
Received: from DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20)
 by DM5PR12MB2423.namprd12.prod.outlook.com (2603:10b6:4:b3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Fri, 28 Aug
 2020 06:58:55 +0000
Received: from DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::c4db:d26e:cf5f:ac68]) by DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::c4db:d26e:cf5f:ac68%4]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 06:58:55 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Thread-Topic: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
Thread-Index: AQHWfITdQ1z7sECVu0aBMJ6rTYV8qqlMuJKAgABYoQCAAAY/8A==
Date: Fri, 28 Aug 2020 06:58:54 +0000
Message-ID: <DM6PR12MB417063D80DDF8EB22D0E0FD4F8520@DM6PR12MB4170.namprd12.prod.outlook.com>
References: <20200827151858.55326-1-nirmoy.das@amd.com>
 <BY5PR12MB4115985F3DA93723F8D2B82B8F520@BY5PR12MB4115.namprd12.prod.outlook.com>
 <46f0841d-a2d9-88d2-9a53-46f07578532d@amd.com>
In-Reply-To: <46f0841d-a2d9-88d2-9a53-46f07578532d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-28T06:58:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=75b3a1b0-da91-45f7-ab6a-0000ae7ba55b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-28T06:58:31Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3b34a892-73cb-427c-9ac9-0000100f979c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f2b738c-a79a-4d81-15db-08d84b1fd468
x-ms-traffictypediagnostic: DM5PR12MB2423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB24236916F1259A0D6E7ED7DDF8520@DM5PR12MB2423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XU+eBBA0TFXAwZZZNweFXWcngCCHpb3rYrNcSKciPJjY760po2VVNzvznG/66H3dEbPnRpZq+tn0M/o62TwrDmmhJd5OXFt3QhSJgB5DOvoUIacK0VUu5cRfMHzXev6AZTwe7QjmDVsSBItiqWrRrmBUgphZnGEER1x+Nkgn61bjBTaDQeWS89nvyJ2BDZPUZKxeMfMxt8HAclQ8pegv+hatUXMjAQRDV8w1bLeBzNgGc3I44IepmD2iHgRDqUUL6fqy/Q8DeSPiq9n7mxpi47oC4eBq/7YoJ8aRJB/gnWBu3FV0h1Be1MUfty8GtgAeanZrqfBELviuRhWosx2M9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(55016002)(26005)(4326008)(9686003)(8936002)(66556008)(8676002)(186003)(71200400001)(33656002)(66446008)(66946007)(76116006)(86362001)(52536014)(66476007)(64756008)(5660300002)(316002)(83380400001)(54906003)(110136005)(478600001)(7696005)(6506007)(2906002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Ik3sjn/7sjDsEoC+GvhoJRzotTJN2c3KMVh67WQMGM3mAlLFVjsNThAcEdzTK47MihwZuMNkpaobIMPca8pMww28Z5FRztEwiYpD+IOTfNLu0iyfx4RwosiRsSEGuIORReYGnBG5NasK6r3eUnpp7BHAcf0SnN5t2sOJgm1kEJHkCkK8C9Q4zIBzScNdOjtE9Qj5J18S+fFK3XStOlfH66rx20qXwjmwzhtSNhVa7JHlcf59TNMh02a07K1h0+k6LcGJBjSPCrpSCFBR6dVwWWnokR0oOdc1BbTPzm1Z9+OkHlSkEHNeocfJx6VCUzicuiIRxByxakoM9/rIpecsp+JeCAIOgBc9zzn5SIaRLtPj40qHqyzA8hJZeYhxE0ngCqAFuasBtCJ0+Azw6FNzqHOB7Gh5j7WsfaRySZ2707F2TJ0SBlgJAl1LmWq+2qzOm2kZ4zBNS+ghahhTpg0j4+HC1VjqBoEjAn7aTsxAa4tfm/qMDkZCZE6GKYTISejNgOgqY2jh3y+7AMIFnXpWDgwTRUd2vNG+/kyIUxwfbKgFP2Q+sFTS9PK0ACVBCBWH3UXvQi/oHRJ9kqnSqejjZotN/cJ8JQPPBMK6PKfADmCKyUXtCn3XZEnjizLb9+acrNDm3pI1JqJTNG3q1RuZaQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2b738c-a79a-4d81-15db-08d84b1fd468
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 06:58:54.1783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZwn5aQevzl09up/fsbvMDxaj4zV28V9YUCR+f4gRCIxaEJOWGbIdJ4Hqm+wFTSswF3rBlhmtOJ0FvVH/FqlSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2423
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

Hi Nirmoy,

I also found amdgpu_device_ip_reinit_late_sriov() part is missed.
Will push another patch to make them consistent soon.

Best regards,
Jiawei

-----Original Message-----
From: Das, Nirmoy <Nirmoy.Das@amd.com> 
Sent: Friday, August 28, 2020 2:33 PM
To: Deng, Emily <Emily.Deng@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov


On 8/28/20 3:16 AM, Deng, Emily wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Nirmoy,
>      Still think the original logical is more clear.


No problem but we should at least make sure
amdgpu_device_ip_reinit_late_sriov() and
amdgpu_device_ip_reinit_early_sriov()

are consistent. The last patch from Jiawei only touched amdgpu_device_ip_reinit_early_sriov(), same optimization should apply

to amdgpu_device_ip_reinit_late_sriov()


Regards,

Nirmoy


>
> Best wishes
> Emily Deng
>
>
>
>> -----Original Message-----
>> From: Das, Nirmoy <Nirmoy.Das@amd.com>
>> Sent: Thursday, August 27, 2020 11:19 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk 
>> <Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Deng, 
>> Emily <Emily.Deng@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
>> Subject: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
>>
>> This patch removes some unwanted code duplication and simplifies 
>> sriov's ip block reinit logic.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 117 
>> +++++++++++----------
>> 1 file changed, 60 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 696a61cc3ac6..0db6db03bcd3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2587,77 +2587,80 @@ int amdgpu_device_ip_suspend(struct 
>> amdgpu_device *adev) return r; }
>>
>> -static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device 
>> *adev)
>> +/** amdgpu_device_is_early_ip_block_sriov - check for early 
>> +ip_blocks
>> + *
>> + * @ip_block: ip block that need to be check
>> + *
>> + * Returns a tri-state value for a given ip block.
>> + * If an ip block requires early reinit sriov then return 1 or 0 otherwise.
>> + * Return -1 on invalid ip block.
>> + *
>> + */
>> +
>> +static int
>> +amdgpu_device_is_early_ip_block_sriov(const enum amd_ip_block_type
>> +ip_block)
>> {
>> -int i, r;
>> +switch (ip_block) {
>> +/* early ip blocks */
>> +case AMD_IP_BLOCK_TYPE_GMC:
>> +case AMD_IP_BLOCK_TYPE_COMMON:
>> +case AMD_IP_BLOCK_TYPE_PSP:
>> +case AMD_IP_BLOCK_TYPE_IH:
>> +return 1;
>> +/* late ip blocks */
>> +case AMD_IP_BLOCK_TYPE_SMC:
>> +case AMD_IP_BLOCK_TYPE_DCE:
>> +case AMD_IP_BLOCK_TYPE_GFX:
>> +case AMD_IP_BLOCK_TYPE_SDMA:
>> +case AMD_IP_BLOCK_TYPE_UVD:
>> +case AMD_IP_BLOCK_TYPE_VCE:
>> +case AMD_IP_BLOCK_TYPE_VCN:
>> +return 0;
>> +/* invalid ip block */
>> +default:
>> +return -1;
>> +}
>> +}
>>
>> -static enum amd_ip_block_type ip_order[] = { -AMD_IP_BLOCK_TYPE_GMC, 
>> -AMD_IP_BLOCK_TYPE_COMMON, -AMD_IP_BLOCK_TYPE_PSP, 
>> -AMD_IP_BLOCK_TYPE_IH, -};
>> +static int amdgpu_device_ip_reinit_sriov(struct amdgpu_device *adev,  
>> +const int is_early) { int i;
>>
>> for (i = 0; i < adev->num_ip_blocks; i++) { -int j;
>> +int r = 0;
>> +bool init_ip;
>> struct amdgpu_ip_block *block;
>> +enum amd_ip_block_type ip_block;
>>
>> block = &adev->ip_blocks[i];
>> block->status.hw = false;
>> +ip_block = block->version->type;
>> +init_ip = (is_early ==
>> +   amdgpu_device_is_early_ip_block_sriov(ip_block));
>>
>> -for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
>> -
>> -if (block->version->type != ip_order[j] ||
>> -!block->status.valid)
>> -continue;
>> +if (!init_ip ||
>> +    (!is_early && block->status.hw) ||
>> +    !block->status.valid)
>> +continue;
>>
>> -r = block->version->funcs->hw_init(adev);
>> -DRM_INFO("RE-INIT-early: %s %s\n", block->version-
>>> funcs->name, r?"failed":"succeeded");
>> -if (r)
>> -return r;
>> -block->status.hw = true;
>> +if (init_ip && (ip_block == AMD_IP_BLOCK_TYPE_SMC)) { r = 
>> +block->version->funcs->resume(adev);
>> +goto show_log;
>> }
>> -}
>> -
>> -return 0;
>> -}
>>
>> -static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device 
>> *adev) -{ -int i, r;
>> -
>> -static enum amd_ip_block_type ip_order[] = { -AMD_IP_BLOCK_TYPE_SMC, 
>> -AMD_IP_BLOCK_TYPE_DCE, -AMD_IP_BLOCK_TYPE_GFX, 
>> -AMD_IP_BLOCK_TYPE_SDMA, -AMD_IP_BLOCK_TYPE_UVD, 
>> -AMD_IP_BLOCK_TYPE_VCE, -AMD_IP_BLOCK_TYPE_VCN -};
>> -
>> -for (i = 0; i < ARRAY_SIZE(ip_order); i++) { -int j; -struct 
>> amdgpu_ip_block *block;
>> +if (init_ip)
>> +r = block->version->funcs->hw_init(adev);
>>
>> -for (j = 0; j < adev->num_ip_blocks; j++) { -block = 
>> &adev->ip_blocks[j];
>> +show_log:
>> +DRM_INFO("RE-INIT-%s: %s %s\n", is_early ? "early":"late",
>> + block->version->funcs->name, r ?
>> "failed":"succeeded");
>>
>> -if (block->version->type != ip_order[i] || -!block->status.valid ||
>> -block->status.hw)
>> -continue;
>> +if (r)
>> +return r;
>>
>> -if (block->version->type ==
>> AMD_IP_BLOCK_TYPE_SMC)
>> -r = block->version->funcs->resume(adev);
>> -else
>> -r = block->version->funcs->hw_init(adev);
>> +block->status.hw = true;
>>
>> -DRM_INFO("RE-INIT-late: %s %s\n", block->version-
>>> funcs->name, r?"failed":"succeeded");
>> -if (r)
>> -return r;
>> -block->status.hw = true;
>> -}
>> }
>>
>> return 0;
>> @@ -3901,7 +3904,7 @@ static int amdgpu_device_reset_sriov(struct 
>> amdgpu_device *adev, amdgpu_amdkfd_pre_reset(adev);
>>
>> /* Resume IP prior to SMC */
>> -r = amdgpu_device_ip_reinit_early_sriov(adev);
>> +r = amdgpu_device_ip_reinit_sriov(adev, 1);
>> if (r)
>> goto error;
>>
>> @@ -3914,7 +3917,7 @@ static int amdgpu_device_reset_sriov(struct 
>> amdgpu_device *adev, return r;
>>
>> /* now we are okay to resume SMC/CP/SDMA */ -r = 
>> amdgpu_device_ip_reinit_late_sriov(adev);
>> +r = amdgpu_device_ip_reinit_sriov(adev, 0);
>> if (r)
>> goto error;
>>
>> --
>> 2.28.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
