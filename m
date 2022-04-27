Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2142C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 16:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198F510E3B8;
	Wed, 27 Apr 2022 16:18:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA9F10E3B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 16:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnKhr4xAc3taz3GBMUkinrf6zrGnYT8BQ4cH1HI0sw2nT2Irx9lwz98+0eMnrZASGrKXV26OgM1s2ncJHTcBE2BovpMKhMVPYStinpaV69Cj5Q/i9lYTrfkPI0DXbEOTTOESALLLTTz0uFGwZ0B0TjEj6ONUrclrKTvUXH3ZsU9ZmfNupQehFzmW85SxOsAmDuJd6HHdmwhagUtSRt142Lo042s5CW0q0ShgG2dfXC1WVNED1umOrdPppi2gVkBruK1+7re9v1eetp+vPcfu8tVaRaPKl4r3smmXGv6sSVWTE3yC5ScCmp7OSkV94hpPZxNyDQxp1PE13Kj4k//YUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxjTRLn9buCBtB3SmcaGa0sImsSIAvYlwdMzVoiDz+A=;
 b=aeCWdkxdTuHe/gkThy+eOFc42RnNh18p3nuBKKnDWXtjRTWZLpyeiOXXP6f9sLG9ue8NeOlPPxRh3rQ0Jc8+K0IGr11fbBHgkLMxlh6lhHotbgNGKMyBjBpJA+LXwAAh42B/IxsvYfCMbYa/4EbOY6OPrEWN5rBVSYDo9miCRShNenero5sxsJr9plKsi3mb0HguLdPklgXrZMVj0iYeHFHlqTP56Bl6HIF1waDOW39rcD2+pVAH+EAMYBAun8Y7JUG4Ip3/mKb/QU3meiAcYv2fonczTp2kqUa1+Vaerw2v04pdEx5edrX30CPl+VIMQjBRyY/YxzZIy2QTXVP6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxjTRLn9buCBtB3SmcaGa0sImsSIAvYlwdMzVoiDz+A=;
 b=OZqYxyB51+RAt1q1rxvAxtdznSR2+87WhFpBndjlh41rwygQ3t1I0KlPZfOo9+aNU8icUrXdbUJFZjK2xeqvNHBWGELZl8l+qNT+t5ba22YgvA3SPv4i/c71CFUfr6w7DRMY0RcKrjIa1DBRq4reviQ9mRjZe4hXFJXEvTHz8u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by MN2PR12MB3024.namprd12.prod.outlook.com (2603:10b6:208:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 27 Apr
 2022 16:18:03 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::117d:9654:152:b3a8]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::117d:9654:152:b3a8%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 16:18:03 +0000
Message-ID: <c0520bb5-fc82-2507-40d4-bbf35e673155@amd.com>
Date: Wed, 27 Apr 2022 21:47:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards(v2)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20220427102659.23579-1-guchun.chen@amd.com>
 <DM6PR12MB2619F4B2E3CDA10FC4B93946E4FA9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_OaOhGjTRNDhBYq2wL7njk0REgGjpm4XLeTSDf2nOoYUw@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_OaOhGjTRNDhBYq2wL7njk0REgGjpm4XLeTSDf2nOoYUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::27) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 789055f6-7858-46b5-e5f0-08da2869808f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3024:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30244B4B45C19CA4D5AD5A1E97FA9@MN2PR12MB3024.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqYR/m5Cnu+8lOPn9fsQyhIATXLxZTyNfbGypXCpHqi/TZdCNuj7eHa/jgdAopgi3VC7l9uIi7BZYCAH1joaf3OUitG4p+raaoDcIQcFhxsf0b1ZX2c7ylggU2BttGLinXVoTtEt9K2Zl6XT2Qh4wVldmRJfZRT/t5a0rnIjXPc4NKj13rA3eIqieOe5E/I/QKpHWugluzWlKobak1DTEvgBcDoIhbQHEM/4Ci6V5GD1onYJaf/bMTu4+ie1bJ8SYL6Q0bMoMG8qzF2LG3ZtnEeE4DUyqZFxITvasmXaZiHZdqLmETu1Ea3sFdmZyiYP/qP3kAg64H4pyod+L/pA+vZtQnzodTsHzx8HPyEv3esocRKv8GKcf62UCTVzln9R1FDW2o+3FausrhRiJVM42msmCwJuMXSkop3Qk+wAP4rNItxqPDajlbeBEn1idMydp9tndaGY8LAJ7kGXcaauJ4dXSNgmS5PHDQ5YfINtxlTm2YKXw/kputQs/D2s/CCzHPBfjgmGPQk6Nl9BMmg0hFDPKHN6NY7Ri+3tEE8o6mlJWdQUAVRiQbZIWio5N+dUz8X1nZfwK4A1PwbTPC6gm1WX2ckUfh+Naa99hfrk+fqIZQLwPMdlvN8cUM6YN8IZFMBoWLWBmDxPiljThCuwyNjIWO5Q/J5XdNrHWKoyfYUvpb4Fcuh5f66Bwl/oSyqVPf0iBgrKbFBrHhBgspBzb/HsTUxsrIDXXOhcOA6yRi+RpQ1GPognLvKx7Q5DF0yU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(6666004)(66946007)(66476007)(4326008)(66556008)(8676002)(508600001)(6506007)(6512007)(8936002)(6486002)(86362001)(186003)(26005)(53546011)(31696002)(83380400001)(36756003)(5660300002)(2906002)(54906003)(110136005)(316002)(2616005)(6636002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpCUUxGbmkrMUs1bGpIS0Zia0I1SmlYQzQwTGFvV1ZCZEJEQnJaYVIvRHZJ?=
 =?utf-8?B?QlhCeDlvdFRyR0xkUGwzRXd4ZGxIeTNvSGhDemZGd2wvNjJDTWN3VkJnMHhW?=
 =?utf-8?B?ZjhsaFZMM3EydE1wc1V4KzUzcWFxYlFtTlY2enN5a0dlUU1qUVJZR1dhbnE2?=
 =?utf-8?B?NUczYWFmOERPUGdJMkd5T01nSkVnMTVDenJKQUdQRHlUWDdUcUh0TlVuci85?=
 =?utf-8?B?bVJPUnV3anQ5WFRMVlZDZkdBbFFWUSsrWnBNcGtVek9oK3NCNzRXdFkyc3ln?=
 =?utf-8?B?NnZnSzV6QWhGbFlUQkZVZ0tqNE5yY0FtTGw4d05XeUlIc0lsUlZQTktSTWFa?=
 =?utf-8?B?cjl2Rlg4TFVVT1VIV1ZrT3JBdnRabkxad0h3MlIvV2E0aHZ2N0hBODhuK0Vs?=
 =?utf-8?B?ZjNYS1d4RHJsUlE2QjZHK2grQXVZZzc2NVBHS0h3dVcxYmZycTFhTThldDZD?=
 =?utf-8?B?dlNHaDNzUlI2VXFDTUNvK2ZWekZQRjU3akRtUFdzVmVXRXFKVjQvRUp6Z2cr?=
 =?utf-8?B?TEplcHZFY1BCZEtXZElNRG1sMlkxRFpTSlAzei8zckRsSGhvTS81cFd2QTMx?=
 =?utf-8?B?YzgvNXQ2dDR0Z05sc1BKb1NSVmZsOE5yZHF2dmpxcis1RnpGZjByRzM0Yk5V?=
 =?utf-8?B?ZXpqZm9LYUJBRWo0b2toaElLOWZ5Y3hDZG9KN3lLS2xBQTRyeU96UVlVMTRj?=
 =?utf-8?B?aGRIdEpyY3k2Q09uVUtpUUpmQ1dXaDBtV2Ryc0tuR1JJZGlJK0dqQ20xQmFZ?=
 =?utf-8?B?VFc1aDJRRXo3alZHM2pvajYvSElsT0d0anJGdjgzRldncEhZSXlSOUJTaS9K?=
 =?utf-8?B?OUpUWkJ6eTZhUE04Ly8ySjVlcGg5b1grRVQ5SE5LVEFzOW5Qd3V1UThoTEM5?=
 =?utf-8?B?dkpHOU1Eb0R3YkNlSE5kV3FSUFBuNHZNZVMwOHNhSnZkRXJXbUE4VVplTjZi?=
 =?utf-8?B?UzRwTHJDQ3VPSEZoT1c4YnprbHJ1WmlHYTBIUjRLYnlIZzJsbnN3R0poNFJN?=
 =?utf-8?B?cUdIVUp2MVlVWDFsME1nbUkxMXF1cFNRK2JUTENHTlk0ZDhDNXp0by9maFh1?=
 =?utf-8?B?djFLL2l5YnZ5TlpqZGprdGxDcTJTQmFGM2pkNk9vV0RtcmR2bHRqOFlENWg1?=
 =?utf-8?B?MGt4Nk11bkZlTXpyRWR5ZklmeWU2MnlwS0pkRTArM09hNFMySytzdVZqeEhX?=
 =?utf-8?B?YzJPYndnN3ljcnFiVTJZdXpxemVyRjVOejBBbDIzZUxVQUsrSCtGTlhiVmI1?=
 =?utf-8?B?YmMzYTh6YnJvWDN0VDB4UEZ5UWt6bG9aWklUN2w5TUc1M2NJS1NUN1VmUjIx?=
 =?utf-8?B?OXZPR2w1NklNcmdPTDd0cGVhakJWOTcyVWRXR3lTSW9mRlBONTJVRFB0SVFo?=
 =?utf-8?B?Qy9xQ1E2aTJvMGtmdkMxaFA1bFI0UEUxRUJZVlZMYTdoTEM4QnhFeFlOakwx?=
 =?utf-8?B?TmNXUWFkRVVwcy9JREIwcHlGbVBESjhSWUsvSXhzaDk2NDZzOHNPNGJ5MEFp?=
 =?utf-8?B?Q21jNWhVbmx4dzBYZzZ0dzVGVDM5aW9qanRzQWhLRjBCSVcwOGd4MHJWSkxV?=
 =?utf-8?B?NzJaQ3p1YXI5bjI0MlI5TVdVTjRDTlRlNGV5L0tKc3ZYTm5nWXpGdFRqSnhU?=
 =?utf-8?B?Uk1TdHpzVDcyV01zN3o4Vy9hTVlFWlROeWxDQ29FVVg5VlR6akpZNXV2d2RJ?=
 =?utf-8?B?cDZGL0JMdFlSdXhrZzlPL080amwzK3d6cnlvU08rT1VnMUNOcTg1OGE3Z1NN?=
 =?utf-8?B?Y29oSFJyQ2pwbU14eTA2M2lhZWJWZWczVStIb05Kc2RuYWo4Q3ExUzRZcWxD?=
 =?utf-8?B?NlNsVDl2Z25kcW9jd1h1bWRna0Z0WDlwdzV0aFZrV2xiSEp3YXh2T1VFc2Iw?=
 =?utf-8?B?M05WeWE1Ym9XazZFSVVYWlA3Vm1nRDFMN2ZScmFERzl1TzJHNzVEMWNPcFFG?=
 =?utf-8?B?WFJ5VFkrMVV1ZVAzdnZLT0gyZHViWStQTlcxTWY2aE1IMmtTS2pDUjVZT3VD?=
 =?utf-8?B?NUw0TXlnUkxIWnNmTHlzc3BzN3FPeDNRZVQrL09ab1VZVXpNalF5ZkY0VEd1?=
 =?utf-8?B?S2djQUttbU5RaEtsZi9SVUZQR2JRS3JnVjBiOEkyQk1kZWljazFzZVVKR011?=
 =?utf-8?B?Q0M4cW95ZmNaOXVLTkxIcTkreHhvTEduZXRoZjVoNnBHVDR4dG5RZjRDZWdX?=
 =?utf-8?B?Q2VKaitZZ1QwYXJ2UVRIRThNb3ZTRDZDVDJhOGxHa2N4bjBBbmNQQVR0ZEZP?=
 =?utf-8?B?Z2ZVZ002QzRhbWVwbmFLWGNnV3RyOUlXUzZodTFiRnZxVWhFZDFhalpoWjM3?=
 =?utf-8?B?ZURJSnNNaUpUZHoySk5IYmVadkRrOGRCM1NDSVdIaldNSEdOWXpRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789055f6-7858-46b5-e5f0-08da2869808f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 16:18:02.6968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EfP+q70/Ve9kCw4ESTsM9qg2M5PHOP29luJMICSawKhz5D862phch5AoDIyisq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/27/2022 9:40 PM, Alex Deucher wrote:
> On Wed, Apr 27, 2022 at 7:42 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>>
>> [AMD Official Use Only - General]
>>
>>
>>
>>> -----Original Message-----
>>> From: Chen, Guchun <Guchun.Chen@amd.com>
>>> Sent: Wednesday, April 27, 2022 6:27 PM
>>> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>>> Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>>> <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
>>> Cc: Chen, Guchun <Guchun.Chen@amd.com>
>>> Subject: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
>>> cards(v2)
>>>
>>> Disable runtime power management on several sienna cichlid
>>> cards, otherwise SMU will possibly fail to be resumed from
>>> runtime suspend. Will drop this after a clean solution between
>>> kernel driver and SMU FW is available.
>>>
>>> amdgpu 0000:63:00.0: amdgpu: GECC is enabled
>>> amdgpu 0000:63:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is
>>> not available
>>> amdgpu 0000:63:00.0: amdgpu: SMU is resuming...
>>> amdgpu 0000:63:00.0: amdgpu: SMU: I'm not done with your command:
>>> SMN_C2PMSG_66:0x0000000E SMN_C2PMSG_82:0x00000080
>>> amdgpu 0000:63:00.0: amdgpu: Failed to SetDriverDramAddr!
>>> amdgpu 0000:63:00.0: amdgpu: Failed to setup smc hw!
>>> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
>>> block <smu> failed -62
>>> amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_resume failed (-62)
>>>
>>> v2: seperate to a function.
>>>
>>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 262938f0dfdb..1bf8ff71b6b5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -43,6 +43,17 @@
>>>   #include "amdgpu_display.h"
>>>   #include "amdgpu_ras.h"
>>>
>>> +static void amdgpu_runtime_pm_quirk(struct amdgpu_device *adev)
>>> +{
>>> +     /*
>>> +      * Add below quirk on several sienna_cichlid cards to disable
>>> +      * runtime pm to fix EMI failures.
>>> +      */
>>> +     if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision ==
>>> 0x00)) ||
>>> +         ((adev->pdev->device == 0x73BF) && (adev->pdev->revision ==
>>> 0xCF)))
>>> +             adev->runpm = false;
>>> +}
>>> +
>> [Quan, Evan] Better to move this to sienna_cichlid_check_bxco_support(). As long as smu_baco->platform_support is set as false there,
>> the runpm will be disabled accordingly I think.
> 
> Good point.  We probably want to disable BACO entirely or enable the
> workaround because BACO could also be used for a GPU reset in some
> cases.  Then only disable runtime pm if BACO will be used.  BOCO
> should still work fine for example.
> 

As far as I remember, the WA proposal still wants to retain BACO as a 
reset method.

Thanks,
Lijo

> Alex
> 
>>
>> Either way the patch is reviewed-by: Evan Quan <evan.quan@amd.com>
>>
>> BR
>> Evan
>>>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>>>   {
>>>        struct amdgpu_gpu_instance *gpu_instance;
>>> @@ -180,6 +191,9 @@ int amdgpu_driver_load_kms(struct amdgpu_device
>>> *adev, unsigned long flags)
>>>                 */
>>>                if (adev->is_fw_fb)
>>>                        adev->runpm = false;
>>> +
>>> +             amdgpu_runtime_pm_quirk(adev);
>>> +
>>>                if (adev->runpm)
>>>                        dev_info(adev->dev, "Using BACO for runtime
>>> pm\n");
>>>        }
>>> --
>>> 2.17.1
