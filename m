Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1790C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 22:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D38889D44;
	Mon, 22 Nov 2021 22:19:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0AD89D44
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 22:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp1JQjiscFy+IKiUQf18zMpNOhAGhbEQtNJ0Cnqa+8jNncg80ZNOiaTxSddniqPkS+Xu6ONYxrOELLdmJ84ze0nSdW5ZzwYR+l47yihiFdC1QOLhI9RV9gZZXyaAFB5M0hEdDAS84vxeQp7hO//WOzfVBlAvdPc8FoMnBexdtEeJzVVcj+nyN3b824xv28y3+wL25VXm0Sqpa/PIJs3UaA8acGxQOu4Bv3QOkrAPPypbFEJEM1kq7HoIo59BWaE9GutGd5OD+V7+N3wv+Ii8jZBaUnKSWCCKwN8Od1R4A8glfU9Hnw39NnAUBrTZtPn/Gf1b+AvbwiWXjm4g/unvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM26PPI6KQGXAINuNBmc6K58XakVceA5JW6P1U0k0co=;
 b=TjNsAAP+ZiPCUJC/mvT/YqaKg0b+blWjCDx50U2B2F3zeazIql9gb8fR/RJsLaavQiBWvYvH2g5/YOd5UhMYQhKVipVruS8ZJw8UVlWaI1qdKrULOuTSNMK32rHQgMVX0tAPyngtGIYRELAIDWl2gKkvC7y4juvLlL2NN+x/hOKb5WG6ZG4FEnSWxCEFPdyEv1m34OuiNWfeVmIEyV2f6CJkyMfQpiD63ogLu9mTCPuEo/lu4pfQip2Qs3iXXNp0rP8LvbSm7PpokLqbM6DD6Thwil6rsZorlo2l4qDXl/TsBIdXzSpxTJEpkC79fau1buDUthvimxpC6BOm1vqCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM26PPI6KQGXAINuNBmc6K58XakVceA5JW6P1U0k0co=;
 b=wdMGH/CqLgjlJCJ4Su9UK46tdbAEmvguBmWZHFZeuQfKzzhxUAO3KIOvV3N1hY9aMLLpXq/Kcc5bNTjsVAHVvB+F+g2sa+R4PMK05Mdz60HMHu5HYABEUInTF7Q0s8UWSLkc048pGhxdvKCinU5+oilLygxCtSuPL7U6iA+i+cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 22:19:18 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::7d09:bfe9:7aa9:6011]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::7d09:bfe9:7aa9:6011%5]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 22:19:18 +0000
Message-ID: <81dde1c9-358f-fee2-6586-890fd5ce1d2e@amd.com>
Date: Mon, 22 Nov 2021 17:19:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/2] drm/amd/pm: Add debug prints
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20211117185512.102807-1-luben.tuikov@amd.com>
 <CADnq5_PkhsvBm_+Yz+JcUEY7dxeeiwiTMM89w_DVxTjPBQwsPA@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_PkhsvBm_+Yz+JcUEY7dxeeiwiTMM89w_DVxTjPBQwsPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21 via Frontend Transport; Mon, 22 Nov 2021 22:19:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eabb9321-cf7c-48b2-2de5-08d9ae061fe0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:
X-Microsoft-Antispam-PRVS: <DM6PR12MB495913460C20E299A29A7979999F9@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZtQcUoPnkUO8r1ntTUYUcEIzS0ZQQpFHolE9iU7TobmeM1ilBHHrpmEpufAIta0UOvUOl/8/r4gaFwWMlU66V4fiJGtoqmB+1OPZgOuQ2MCTvk+Anag06Oc81O520iXcqcsJp9n/b2eayxOCRaRmh2a4USzOdWRVoUFaqjJkpVGDz+iYAZWb1mhaNuhxPXHOLQUXidC4uxEXIjwh4a2F0lPat+Thic5jekdhlcJBtpXW8MQOMZOF5SErduyFPq9ErRfJ1UJfJHcfvHbkzpI51vVYM1JusKX3jQ4z5o8d9MTIbu8eBRilhBbFbuO9skExh8sRffeyNreZde12xamJNXlE2f5XcX3pHPP9j40WtBiAEr+DGex8hH6h99vwRb84v0Yb2Ocf1G0tA2CSpxXeBn4aQ7ZximB7Q/hLkzKnX0wZgojxLXpO40uK6Eb3ENnDBKdWTKfQ+DFgAG/jGCZ0RUpIAppST3stz+vtdAzstAWLPhKFWYobwd+zZSe3zI8njL7qUZSp/n5+nBRU3OnUGFnqVnvkVBs9p8qV41sX9Qthqh9o78mAvf98DE0T52znf+POWO+/4yDv9Kqx55e7azLhOs5oyJ5/K/CbQUtq+/Nm/9HSGIWoDEV3Ov+e9g6qgBUekSMuNyY1gIK6S4Hmzzqwegpa/Im0/dONtz9/uipm/HIzRP/KM1WJ2hR10DB9H0dJPcE5egyuVGiI2w4HhdKMl02qF4G1QShhq6stjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(508600001)(956004)(2616005)(83380400001)(26005)(38100700002)(31686004)(66574015)(36756003)(66946007)(53546011)(86362001)(54906003)(16576012)(44832011)(316002)(8676002)(66476007)(66556008)(2906002)(186003)(6486002)(4001150100001)(4326008)(5660300002)(8936002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGFiMzkvNC9iTlhhUHdGKzVFUW9IVS9DdS94QXFqUWFZSWtPb1pYdEpYQk1W?=
 =?utf-8?B?TXIva0Y5aDArdnhmSFV0OE0veFcwVnF6d1FJK3Q0RkI1eldoVWxMWTRlTzgx?=
 =?utf-8?B?a2hjT09xd0FPNmRJMGpTM2dMSlRwYm9SWE0zM0JHOVRXNXU3UW5zRjFjeUx0?=
 =?utf-8?B?SWJrZjY4VEU2WXZ4OTlIVnNPYzdjaHFoczN2K3daMlNNOTBVR3lHaW0zMW0y?=
 =?utf-8?B?cUNaT1BOZHZ2c25XMERJMm14aVRKNkg3M2NpY2pRdXRDOHBJTmd2TUt2eHN1?=
 =?utf-8?B?WDNDZE5xNmxOZ0JoL0g4ekFVMTJvaFFVTE91NnRLcGNyaE94SlNNK2hIWkhn?=
 =?utf-8?B?blo0RXJWTzhUeG1YZzIvRUMydmxEOTUwMWdUZEtVcVFHNnQrRk12SjlGZW5n?=
 =?utf-8?B?ZGN2MitoOWpPaXRScUpINHBHMTZJQk1uTGRLSnVETklGY3JnTG8zVjhieGRW?=
 =?utf-8?B?NU9qK3c3amk3QWQxSFN3dEdyYmNDOHBsNUttOFFIOWFLVzFwY1ROSThxYXBu?=
 =?utf-8?B?eVF2eGxTZE1BeTY1dEY2OEN6dG4rVmljektQZ2trMGQ1aDNMQmk4NGl1STk4?=
 =?utf-8?B?Z0NmQlBHcm9XVjViOGU5UGZVb1I3UUFEZnBWd0F4NnFMK2FHdEJzaGw0bWhF?=
 =?utf-8?B?SUh2dGRyNnJhRFl2U3U4WENBWFBlVXRtOVlaWVpla01Zc1R0SGtwL2k3NmR1?=
 =?utf-8?B?WnJDSE96ZWZ1V3pEVWlBaHlVeDdlVVdmd2RiWXFZeFBnM0RSbkZuZ0k3VU8w?=
 =?utf-8?B?Ny9HTnIrdVNIcHRPVTBNcklTWGpqMVZIQWdHd0ltVjVocGVSNk5GSnFVZ21m?=
 =?utf-8?B?SDdwaU5LeXprQlBvUkR5Wk1XNmI0cnZ0Z1BwQUN5eVpFaDVnWDJTcEUwaXJ3?=
 =?utf-8?B?enQ5aDl2R1d3K1ZCTkZvSWs4K2NVNllFaEQza3krMnR1MXU4WFh0Ny9HVTdi?=
 =?utf-8?B?Qysxc3FvWmtpVWdpdUtGcjRrUURwU2ZCdUYyaEp6WFdQY3ZJd0VnaXgxbVBB?=
 =?utf-8?B?WGdEK0Nscmc2QkdVQ2JRTldpUEoxVnc4dW1sekZyRmp2UzFmbWlPeVdxVERt?=
 =?utf-8?B?dEFyY2llMzE0cjYvenRpTy9ETkJiMEFqYWg3ZTBVcEVPM2paRWx1aTk1T3d0?=
 =?utf-8?B?SkhKYjhzZmV5bU55eEUwNE5XdEdNWjd3S25EVTNpMWRHTURyTFZ2STZ3V0RQ?=
 =?utf-8?B?TlQwWHFCVllIN01MaDhPRGNuZlVHa3N2L0g5RTFEbXBYRHErMVg0eEp4QnFz?=
 =?utf-8?B?N0gyTVc2V2RZbjdCSURQU0p6cFpPdVViMklZRVVTS2UyMlRFUWhTK0dOdW1B?=
 =?utf-8?B?YXVFbmtxNU54Mk1lNEx6K3NDblVXY25DaE9iaWhEVnZGanRUcHlRU1FXeGdC?=
 =?utf-8?B?VzAvb3JzZ1pTbkxUWk9hTUtHMlJnbU9lK3NobzdkMWlSNjY3WVdhaHlFNjA2?=
 =?utf-8?B?OU1GT25PZVBEUkJNTEtMY0lRNnlsNmZaRmtTY2lwM2I2Y1hVd1AzRGxScWsz?=
 =?utf-8?B?Wktra1h6aEVsNlErNklvSGNsUitPekgyVW5HQkF0U1lXcUU5N1gwbTAwWjFK?=
 =?utf-8?B?MFpjbXVNZWNMeGVWazJic0tBTEdRVWpBQUhMS2RzT3hxaVVndkhKWHRWUjFD?=
 =?utf-8?B?RXdpUVNsMURvYnJJMk51QVhXbXdoQ0l4MHo0VkhwWnhDU3BUMW5UbmUzeUVa?=
 =?utf-8?B?a29nU3ZocitTQlNjNUE5RzAyLzRUNExJazE5cnpLZTliYU5NNlN3S0F5OURj?=
 =?utf-8?B?MHdCdWN6cEtQRXk1QWQ0aVkvbnVUdjhpK0NLUjJkTEd0SjZPajVOTE1FR1dG?=
 =?utf-8?B?RVR2Um1MZzk2c0dPbUdiRzdqMlRnb3VMUjFFQzUvUDRxVXplZEZyNnk5dHh3?=
 =?utf-8?B?cytkZUp1S0hPUEl6dVpPMFA5a0FPTnVKdGtudHp6M0phV21mRzJtZjA4S3dC?=
 =?utf-8?B?TG1HVExJY01BWDUvZUdreWVSWEN0WDJUUUJxM05NMVNmb216cVlXSWNDUHg5?=
 =?utf-8?B?aWRWVWl3UGkxODNpdFNYckJMazFzbWJSNE81RDUwUEE2eUl1U2dES0pLVmZj?=
 =?utf-8?B?ajFBQjRaN3QzaFlnWXl4RHliQTk2SWFueUxiVWNablg2ZkQ1SlErQkxpb0RP?=
 =?utf-8?Q?wVnY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabb9321-cf7c-48b2-2de5-08d9ae061fe0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 22:19:17.8577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzNAcLP9wzO8Sf0OT8gXAY4RUmLk6AEUNR0xe8QcEfHlJRppTXRDAN26Uow0bPJy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-17 16:54, Alex Deucher wrote:
> On Wed, Nov 17, 2021 at 1:56 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>> Add prints where there are none and none are printed in the callee.
>>
>> Add a print in sienna_cichlid_run_btc() to help debug and to mirror other
>> platforms, as no print is present in the caller, smu_smc_hw_setup().
>>
>> Remove the word "previous" from comment and print to make it shorter and
>> avoid confusion in various prints.
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 8 +++++---
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 +++++++-
>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
>>  3 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 01168b8955bff3..67cc6fb4f422f4 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1153,6 +1153,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>>                 case IP_VERSION(11, 5, 0):
>>                 case IP_VERSION(11, 0, 12):
>>                         ret = smu_system_features_control(smu, true);
>> +                       if (ret)
>> +                               dev_err(adev->dev, "Failed system features control!\n");
>>                         break;
>>                 default:
>>                         break;
>> @@ -1277,8 +1279,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>>         }
>>
>>         ret = smu_notify_display_change(smu);
>> -       if (ret)
>> +       if (ret) {
>> +               dev_err(adev->dev, "Failed to notify display change!\n");
>>                 return ret;
>> +       }
>>
>>         /*
>>          * Set min deep sleep dce fclk with bootup value from vbios via
>> @@ -1286,8 +1290,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>>          */
>>         ret = smu_set_min_dcef_deep_sleep(smu,
>>                                           smu->smu_table.boot_values.dcefclk / 100);
>> -       if (ret)
>> -               return ret;
>>
>>         return ret;
>>  }
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index b0bb389185d51c..f3522320df7e58 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -2135,7 +2135,13 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
>>
>>  static int sienna_cichlid_run_btc(struct smu_context *smu)
>>  {
>> -       return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
>> +       int res;
>> +
>> +       res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
>> +       if (res)
>> +               dev_err(smu->adev->dev, "RunDcBtc failed!\n");
>> +
>> +       return res;
> Maybe better to split this hunk into a separate patch and also fix up
> the run_btc functions for other asics.

No problem. I checked all under amd/pm/swsmu and Sienna is the only one.
I'll send another set of patches.

Regards,
Luben

>
> Alex
>
>
>>  }
>>
>>  static int sienna_cichlid_baco_enter(struct smu_context *smu)
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index ea6f50c08c5f3b..f9a42a07eeaebf 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -97,7 +97,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>>   * smu: a pointer to SMU context
>>   *
>>   * Returns the status of the SMU, which could be,
>> - *    0, the SMU is busy with your previous command;
>> + *    0, the SMU is busy with your command;
>>   *    1, execution status: success, execution result: success;
>>   * 0xFF, execution status: success, execution result: failure;
>>   * 0xFE, unknown command;
>> @@ -143,7 +143,7 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
>>                 u32 msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
>>                 u32 prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>>                 dev_err_ratelimited(adev->dev,
>> -                                   "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
>> +                                   "SMU: I'm not done with your command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
>>                                     msg_idx, prm);
>>         }
>>                 break;
>>
>> base-commit: ae2faedcc13fa5ee109ceb9e8cc05d759ad57980
>> --
>> 2.34.0
>>

