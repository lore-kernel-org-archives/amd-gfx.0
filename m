Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F614C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEF961059
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEF961059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E2E6E8F8;
	Mon,  7 Jun 2021 15:59:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8C46E8F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 15:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U12HGs0uVrsdaFtxZkn9ZKd+wksAT3qE8BPXAkn0ZyVUdt11ZzlwMnqDRUMXgbbyoDRyF0hpu02hqy3TGafIhleqwvm/oByJuVLqmyZ4U+xHWFHh3PA46JlTAIvOb0JZE9S533KMskn7z9JZ6nmGV0hrlSAuSXmWfBeQdydD97ZSnV6iHOHSoPQPwy5OKvpfh/3akeRAX2gyBNdJLB700tgDa4SsLswigIUtimKAkyxleBFqwXm8NYUeoWLfpwoSXoypfkkp77bytTsfPFEL8wcYlWkXAx7LfPFsxKK7pBk3bihQZpF95ObFgkdohVCTxUMZuihR+Uu1WRw6IT9NIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFM9gTUJ8kIYwNeweMcjSgaiv/hMEpsOJV1NczCLQqg=;
 b=JLJagtvgGVRuVVsTjGFPovDWUtgQamE+10uYJuflj7dq2okObrb/9Js9CCfMAoNPAY8LQU6lLFqGmqdpzYg9YAIZhpstnh9bkq4MKs45p6QDxu0+jJ9Z91VUPayZhoyhJ7ncTl5ZuANsK73gmWrKZSFa5XcoFFjpiHtaZMGKO+9vkQERIN1KUnpomLyRWTvzf0z4rc5jZMSPWfdKGL7iZsVkt18gLMEEa2Bux2x0TQxQZIZIIhUQnKepYPwwoHe6htGHCaqjWJsxEHSoHssOKsLBWqBxkgI6usNzmVDS8+e73Gh4EYA1WYHxpv71vk/JZAptl2oFTPFNa/Ffs3Rrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFM9gTUJ8kIYwNeweMcjSgaiv/hMEpsOJV1NczCLQqg=;
 b=TGm+MxOoUBBpIuDo5QAdPbn43JZZGMH09Go1Yci5eOE8h7c6teM5MFJ9p+antGN8qrmTOXolCrMHZ2qcwOTmhYCgQeZHh2cQlRgcZgZXc6p7XWp9QVYIOn7c4xfeSDQWPtPatmFmFw0viJWdKVVb0MsNglao1HrmNl8kVYUdDm4=
Received: from BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26)
 by MN2PR12MB4782.namprd12.prod.outlook.com (2603:10b6:208:a3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 15:59:42 +0000
Received: from BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::2ce1:d92c:92e9:1689]) by BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::2ce1:d92c:92e9:1689%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 15:59:42 +0000
From: "Khaire, Rohit" <Rohit.Khaire@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace"
 <Horace.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on
 SRIOV
Thread-Index: AQHXW6jBBOCm0Cq7+0e2cLfTYbZVMasInCcAgAANbpCAAArEAIAAAHBQ
Date: Mon, 7 Jun 2021 15:59:42 +0000
Message-ID: <BL0PR12MB47552C90D8667E1107279AD487389@BL0PR12MB4755.namprd12.prod.outlook.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
 <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
 <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <da0025b0-308f-6f2f-e4d8-b5a68117828c@amd.com>
In-Reply-To: <da0025b0-308f-6f2f-e4d8-b5a68117828c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-06-07T15:59:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=42decbd8-d65f-40d7-a40e-c09b9d71fde3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cb1602d-8c0e-4a11-bedb-08d929cd4373
x-ms-traffictypediagnostic: MN2PR12MB4782:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB47827D7D494F78F93043185387389@MN2PR12MB4782.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7d+fURr0PcytNA1Lo8t2ebqQEy7/7wUkJCyo/lAogEOCBi3diDF8NG2N9HCS1oeh/24oCBo0mdA930ASHJ22ufoduKnUchys1YXJCOrnPkZlCJ4Gan/mhRFYVZvriDWYSHRp6m2EFbFv2zKjLowJaFfVRTqzrfB1VW2BmtirArxtbW4KtqWNBUG0dm+PSZRS4dpOIESjldkBwVdrSSkuogHg6jU0b/ZITVL8p+SbhRTF7MalL/rpBB2qcYGBP6r3ooFWYhnj4zlsPP70gtiF1dxham3qGV61k1BM6VAbsRArMRN9lLy+YbjVXfrr0e2Gf4QM3tbln/GkDpT5YnybMLoOFnim2esaDaGVTOEq/2bevIK7xd91FLHCaXzB2sS5XVZ8lekdbP8slHI0Fbq0xfoo+O8D0Hhmle/VIfnxLoib/bLQ6zomhXoM8oZ/YRdpXZO4V4TRltEjDCCFQLy16T2P/RjkOkook+utzPWtXnNoMZGzYKmLZMxVOCcTxQCkimZUNvuqyVAlId6OUN5jZw6gw4ed4q2nyuxh0JHDt1rVDho16OyBBEi0uurjaiQ9H7tMMn+WEejjyA/pwD1JjJS8WyRwdf/wIPts/1owe1qaxaWTywByaVz/uW5noQvoG7eVUz6vzMySfF0vjwcdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4755.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39850400004)(136003)(396003)(376002)(33656002)(186003)(64756008)(110136005)(53546011)(6506007)(66476007)(26005)(66446008)(66946007)(66556008)(8936002)(6636002)(83380400001)(38100700002)(122000001)(76116006)(8676002)(316002)(478600001)(4326008)(7696005)(52536014)(86362001)(921005)(5660300002)(55016002)(2906002)(71200400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UHlIWnJXMnNqQmNPTmRXMEs0bVovcmxNTFJnVjY1a0dIK1J2NSt6REdEaUh5?=
 =?utf-8?B?STgwcGJwSG9rTGhxbi9ObkxFYkF2bFlRWFBNVkt5T3FGa0RxajhSRGhhZmlm?=
 =?utf-8?B?YlNRS1hSTndXbzdtVnVobXJKd3hsaUIwRFRONittUDFkT0IzOUNTUDhjWFdG?=
 =?utf-8?B?bVNMOFQzbHlKTUxyQlBkSGw1Z09rUFJQVmRndkFwVnJQekVlR0VhNGo3M2hy?=
 =?utf-8?B?b1hNM3ZqRlZ1ZzZVajJ3UTNqb3RDeExhTlJiQ29LNkN6TzJLeHJKMllKQitB?=
 =?utf-8?B?YS8vODVveEMzK3p2alk4MzRVRXZLazZKWmllZjFWaDN3S2ZlMG9rTWhWa09O?=
 =?utf-8?B?bC8yclpyUzNnM2RjVGJPMHMrdjc4MkYrZGMybmdkOTFWdTN3NkN0RTdPTWxM?=
 =?utf-8?B?UFFQdXlEbFBlTkpCcDBCNWF2VFF3WXN1NDdGa2oyVC9hTm0vckZUenVRQytv?=
 =?utf-8?B?UDZrMElGR3JlbmR6NkQ2L1hZZlBCQ1htV2k2VzFMbG1UK0xlNUkxMlg4M1Fu?=
 =?utf-8?B?dDdwdmFPS1NxT0gzNXNWSDczRWVINFlBdHZqQzRqWjZoZmd2QXJvVGhnM1R0?=
 =?utf-8?B?bGlpNWZZRGh6S1VHMHlCWmZ4RVhlUXM5T0M5N3dqYi8rbHh3U3FqVmpuNUdv?=
 =?utf-8?B?RkVXUGtWWFFTU2oyQnZxV2hwYkhsc2ptNFZ1SStIMmpHdnNLWG1QWjBkRGs4?=
 =?utf-8?B?MU1DUmdKaldEc0tMY0VFZzNLTVRpMzZrai9kZmZDR0VSWkJqM0N1cnJaWWVy?=
 =?utf-8?B?Y2hLRkhQdmo2TGZYSHBacXpITVFmSkhsdEwwVU5NR21PSURiZ08wMXVTN25v?=
 =?utf-8?B?cEkzTXdUS28vdnNkcTI3bmNnakVTanZ6WHQ3YWVBQ3MwUDY3cllRTE94c1Fl?=
 =?utf-8?B?bGxqQkhDRTcyUXVtb3lFM3RVellKaElmVk04N2VTVm84VnlKSFF1QjhVZmhN?=
 =?utf-8?B?aGVrZ0ZUVmY3d1NRZTFPWGw3aVB0MzM4ejlZbTdYNEtuZ1BVUkttTENNM2Nu?=
 =?utf-8?B?Mmx6YVdEQkxjZkNhZC9iamhVaXFIWGU1ZHJKekhOSVdPbkJHbE10cTFicHJV?=
 =?utf-8?B?K2E2Rk43QU84YytnQ3ZSNmhRcWhMa2tOMTY3WmIyWVJlVUJ6bzVtaEd1QjRy?=
 =?utf-8?B?TEZsN1hUcEZvSGhMWkQrZ1d5NTZxSE1BakJmam83MCtOdUovMzhNVTBMNFR3?=
 =?utf-8?B?KzI0a2FLZnBFSXZqdHRKeDlFVFd4UFlEemtNc1FadFo1VWsxdWJ2eHJrTWcx?=
 =?utf-8?B?cjJ4K2dQNXJYcm1YdjRFL2NqR09oYWJ6ZWZLaUxNTko4Z0hNUVdLczVJWUhi?=
 =?utf-8?B?LzFrMjh3N3RZNXdwd3BQdFZPU2hrV1NHRHJQRVFmSWI2Y3RqS3BiaWVYWGFS?=
 =?utf-8?B?b0xtU3lpTk1nV0o4QXA5VUgrc1pkanN1eHdWRmk0UzJRdGZzcWlQQ3ltM2VX?=
 =?utf-8?B?WGg5NUo2amM1QXhzTnZVK2RLMWlWR1FJN094cm1USUZhRE9EelBCcVlKd3RE?=
 =?utf-8?B?TlR6WmlRcERCSUg1L2l6TmVLNEtwTFRDTlkzRzg3MUF5cUJZSlJPNXRueWxy?=
 =?utf-8?B?QTZJNjhMMTRYUHZKY2JsMk5JWkJFV3JOUkxNUFhEbzQ3ZVRQWnhwWHVKTmU4?=
 =?utf-8?B?aTNFeUZKSTVHMktVanpacVZPazA5WElSYTF2UG56Mmo0SmVMS0lFTHdISEJa?=
 =?utf-8?B?R2xwY3RSTmluQ1RoQkJoMDNCNWR4d1doUVZ5ZWNCRzU2eGJpenlOY1dZNUFl?=
 =?utf-8?Q?C4hPH/ShLsPOBWHZ25429i1Yh55utN0WnRpsB8i?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4755.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb1602d-8c0e-4a11-bedb-08d929cd4373
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 15:59:42.5109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gs7C3/oviP+hrvOciG0m/SoZ0DiVYFtNR/tJmiOM90v494vT5dIdlrYKH7uftrMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4782
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

The hash is 5ea6f9c

Rohit

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: June 7, 2021 11:58 AM
To: Khaire, Rohit <Rohit.Khaire@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
Cc: Ming, Davis <Davis.Ming@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV

Do you have the hash for this commit?

Thanks,
Christian.

Am 07.06.21 um 17:30 schrieb Khaire, Rohit:
> [AMD Public Use]
>
> We don't need RING1 and RING2 functionality for SRIOV afaik.
>
> But looking at the description of the original commit message it affects RING0 too?
>
> " drm/amdgpu: add timeout flush mechanism to update wptr for self 
> interrupt (v2)
>
> outstanding log reaches threshold will trigger IH ring1/2's wptr 
> reported, that will avoid generating interrupts to ring0 too frequent.
> But if ring1/2's wptr hasn't been increased for a long time, the 
> outstanding log can't reach threshold so that driver can't get latest 
> wptr info and miss some interrupts."
>
> Rohit
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: June 7, 2021 10:31 AM
> To: Khaire, Rohit <Rohit.Khaire@amd.com>; 
> amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; 
> Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou, 
> Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
> Cc: Ming, Davis <Davis.Ming@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 
> on SRIOV
>
> Why are the ring 1&2 enabled on SRIOV in the first place?
>
> Christian.
>
> Am 07.06.21 um 16:23 schrieb Rohit Khaire:
>> This is similar to IH_RB_CNTL programming in 
>> navi10_ih_toggle_ring_interrupts
>>
>> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
>>    1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index eac564e8dd52..e41188c04846 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -120,11 +120,27 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
>>    	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>>    				   RB_USED_INT_THRESHOLD, threshold);
>>    
>> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
>> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl)) {
>> +			DRM_ERROR("PSP program IH_RB_CNTL_RING1 failed!\n");
>> +			return;
>> +		}
>> +	} else {
>> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
>> +	}
>> +
>>    	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
>>    	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>>    				   RB_USED_INT_THRESHOLD, threshold);
>> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
>> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
>> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2, ih_rb_cntl)) {
>> +			DRM_ERROR("PSP program IH_RB_CNTL_RING2 failed!\n");
>> +			return;
>> +		}
>> +	} else {
>> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
>> +	}
>> +
>>    	WREG32_SOC15(OSSSYS, 0, mmIH_CNTL2, ih_cntl);
>>    }
>>    
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
