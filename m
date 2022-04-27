Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9D9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 09:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1C410E403;
	Wed, 27 Apr 2022 09:13:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F3110E51C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 09:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdPuqSPhDgjsQL3C/pWbKL1fZ5x7YPGp7wWa9jhrGn6dPGBIx4nLjmso2Vl3+HHXinhyN4njV2NEO5EPeReOtStpkAcL86cFK9RxbE5mOryt/aFOmUUPIlTVOOhiDhPzNHiwhNBVp+TfN7K83hvunMNDHQdeonbOD/0S9iFRie57LxHd7KzWKoT8HmRFCDM0Jr/1FVvDWl6K0Oct9oj+SZl1NpzI9Y4xWQqMndjT+re5xDvDHpAu+awckpOZZVbxX6BL+GvvPj+c6x60jaXZQC9NlMpgRn7arWb90fp8zCu2Cbi1ci0IW6Y1W/xszZpe8HFHNVRG7miFEd5bmh5utQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbjfxhU1ZJIXQDPJ3Qw/jnY7NqfVevgXd84R0c12eJc=;
 b=b6hBkBmidD6BQlXgoi7NzVVbhCXCa04jDQwyPYaLBT/6VoNtptf+EcU74wG/62pDpy90OAuO4EWpfyCqillj1DWqYoSWxjdZ9ca9hyheLhvide3ed0AgH6C2v9Ec7O6bse+inKGt4aY+CsouV3Kl95kTRaP3oR0khMUbCA/q5e8kMY8qQ4gT55+difiJe7rGESLPg9VojuBZcbBHmZsN5M4D887q+6UPDEXWglCN8N+chsq8DWKUdjkY71Bsvj971jddO0KLKbh+tRsesYSqghZ3Z7a0JViT/nSE6pWAlo69ILwalBf91V6fJLwcBTwyvBFeDeEyllk7qCKG40eFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbjfxhU1ZJIXQDPJ3Qw/jnY7NqfVevgXd84R0c12eJc=;
 b=mw5zVbGszt+S0RFIxsPD4Kv/lRI1Zr0tc2mMNI8mFqQhonj0ox9bc0BUsuqeXej5RDs056UMJ39h4aovnWqCwMy2GucAaCVwPoYgt9Fl9vJNNQmpIGCmgQ0Dix/iLRkhvid76HYTya1mfmpNtcqf6yVbgqdzYx5gQi/v8dUUPVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB3954.namprd12.prod.outlook.com (2603:10b6:a03:1af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 09:13:08 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:13:08 +0000
Message-ID: <5b7cd2b4-36fd-980b-9d8b-7e9782b89ea5@amd.com>
Date: Wed, 27 Apr 2022 14:42:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Content-Language: en-US
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
 <1603bd63-71f0-87a6-0d18-339bf43568c4@amd.com>
 <BYAPR12MB3238D716386D4F0E246F2189FBFA9@BYAPR12MB3238.namprd12.prod.outlook.com>
 <685cbc01-6acb-a980-7358-b1e815dd0f36@amd.com>
 <BYAPR12MB3238009376AAAD9676E7C98DFBFA9@BYAPR12MB3238.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BYAPR12MB3238009376AAAD9676E7C98DFBFA9@BYAPR12MB3238.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 389c6783-52cd-4a1c-d080-08da282e24e4
X-MS-TrafficTypeDiagnostic: BY5PR12MB3954:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3954DDEBF5DF61E06988919597FA9@BY5PR12MB3954.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kq2C1Zp/d/iPLU2QTvVrs+gczuc3OGuBS39DD42Lj8XaRtR4+eFTdBhLKieagjdJLj07wnt6QcQQeGAfVhLYZVgBn9bMVZIKVFUbrp+lsm1zEoc/W6ZmCJ1HQ8OrbEgBirdz7X56+rwGBsHhfx44jzWkjwOgAIFfeeKqjJD53mPijsxm8Nq8JhTHAuypnID/o2b3GbXItsDOKB29hXGcYGihAvtTIvHYdB9bDthrfoy+8ATzAEjJ0lqmYT6MBnXhu2kKOiNGeYHEGVtANxZ38br8X2pR9m8PwATLcqsYTleHbQc0pPeIxS5iiR7pn6TJbLRrNEPz7KWrFICMVmtDRdKDD0cSMpwxkKkDxG6hl7tbuLVudTJIJedlNFpi0xriftxThZ0nWKw0UItga7koPXD4ibXi4sgyReMkkIwUEdyXQULghgpxYvAtExBaxNLLhdxWLCl+DLbu2ZNKt5+JtINkWVgDPAETQEIMYySq7yOmzf8HuZ2VePD7CYfe5Q1N+FKA8hxFZdeDv/crPTpwdgtpAOfnNadBW3sPddOUJcpWU8MdH9Gia0Dl3ktc171G8Ghj5iyTMpov+vdgJ5qAhNYUnfXPt/lg1kD5de6ns6qR+Kx/a529yGbHPSH5+wtiGuQHDs1B8V1yWA8HU576p/9FLIYRsWjnkcRt77HWbeTu8t7BZ7VKyha5prO+OsHqKCHkhxvC49ow48XxnmeHabUUvGNnijA3x4dWU+d+4LXeVF2DpPv+ATTq+lTk3mB3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(6512007)(2616005)(38100700002)(26005)(6506007)(316002)(53546011)(186003)(86362001)(5660300002)(508600001)(83380400001)(6486002)(36756003)(8936002)(15650500001)(8676002)(66556008)(54906003)(2906002)(110136005)(66476007)(6666004)(4326008)(31686004)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNGcUxmUVBEdDNNZWVOb3UxTm5QcStnOGoyRjBIWlJvbGVoUlo2OUFyTWVS?=
 =?utf-8?B?Yy94aHNIeVN2TEFLVTBrWnVVcGJFNFZITFowMEl0RTlhbHQzajdLbUJzRDZx?=
 =?utf-8?B?YlRLenVjeU5qdld3TDZPODNkTWFnR2xydlQzeTlaeVYwZUE0ZVRJNzBnZ1R6?=
 =?utf-8?B?a0p1cC92S0xvVFJReGhma1lNVlFNNzZaaXV0ckFXdm5UbXFkYndyWkRqMFhK?=
 =?utf-8?B?WThoU1dFWGpxVnBiZlZsaWNWSFd4Mlk2aVRZYkNPWXQ2NWpWcWJjcUpnM2pP?=
 =?utf-8?B?TVNRaE4wVFFybFBzdytCZFhTU2M2Y25SRkFpZ3MwV09jblp3Ujh2KzJYazdx?=
 =?utf-8?B?b2ZTR09ydHpxVCt0VndDY21IbDl4STJoMTA4VzVmOHh2QnFlV1BWZ01nNHl0?=
 =?utf-8?B?ZzdVbWdGc2piY2ViQStXYVdpalJGcmQwTmNSK2xOb1hpUCtKTG1sVHBHRUJB?=
 =?utf-8?B?ZG51QXB1NlFVUFVNa3c4ZnYyN3ovU1NFUmladkZhSkFZZkhXUWFoR2p0MlY3?=
 =?utf-8?B?SEJHUXlXMVQ5T1YrMmJlNUE2TWJKYXlkVTFQNEJwSDBhTnR4c2xEZ3I3cUhI?=
 =?utf-8?B?K0g3dzI4WTZkSjRnL1lZWkZiV2hZanZvK0NOUUMrUzY4b3o4Ri9vY3RCc3k1?=
 =?utf-8?B?MzU2Rldzd0IwdzJsc21sTm9udlF1dVRYK1hmSVRFenVHcVFtZWkzUVFTeGdY?=
 =?utf-8?B?M09WZ1hqSDBXSS8zMWV0ZVJnbEJwbjROUnZZVDJmbXp2bHFoelhNRUhMdlVQ?=
 =?utf-8?B?aFZHSzkzSFhSVVhhZHo4ZE1VM1lQeXZMTEVQOUdCZnRqK24vam5oNUtTUFVv?=
 =?utf-8?B?RVJzZW16ZDAwRjBVNDg3OHI2VzJ2UzJVYk5wY0JjSzJIRGFGeUdRQlVaTTMx?=
 =?utf-8?B?d0JFOWNib2k4VVM0cmZ3dkR4eHdkZWR3V2pjUTJpREdXellBQ1cxcHgzWFBm?=
 =?utf-8?B?dzQyS3FqNU0vTmNQQlJ2R3hDaHNCSWgyRzQzdWxNM1hjNHhpR21mRDhVYjFU?=
 =?utf-8?B?UVZGMXlzRHkwMmsvM2djMXJVSXU2aEQ2YVdrL3Y4VlhhZytWeGs4SWo0N0VG?=
 =?utf-8?B?SkZPOEU1RDkxY3gwL3BybFkrNzh3WVFFQitIWHJCZFlCSUkvOW9rWmpZNVJQ?=
 =?utf-8?B?YUt3SURZLzF4b2Jic3l1Q1RTejlhYUl4cDUxWFEzUlZMMUxzYjRQMHNlcDY5?=
 =?utf-8?B?d0xqYmNFYWt1NnVoT21YRkxnT1ZIeDA1bU84eDJ6REZDZEJXZUNpWExTekRp?=
 =?utf-8?B?MnhIMWE3V1NsTWc4TUs5aVkwak4yQnlTQmk0MncwVHRxU0Q1S21mQWx6VWJT?=
 =?utf-8?B?Z2VpWWNmbis2VStMelVGMUM1ZXR0TTBUSUY3TzdEdnFTR3dTdUh3OFFUOTZQ?=
 =?utf-8?B?ZDF2Vm5rUTdZc3c4NGtZYkhNMGNHZUZ0MXowaDhVTnhrWEM4U0xEaWFCM0xv?=
 =?utf-8?B?ODZxcEMraTU4dWlmcEhOQnhIVXlnNmNnVTRPMkdNVVBHUndNK1ZkQUV3RmpH?=
 =?utf-8?B?WS96WWxZYVd6eFh2bzR3ZUV5UXZuK3p6VFVzeWVmSG9ROXBCeWNRZ3hITDM3?=
 =?utf-8?B?dFdFblBVcEFWRFV0bjcrZFMxTlV2VGExV0NmUmxpKzdRTEkySmJKUXBxVFhW?=
 =?utf-8?B?RnV0dmV0WklVVXBEOTNZUWZNbm9zdE5ITkhRTm1Zd3J4d3oxY3RQK3VsOXdr?=
 =?utf-8?B?TGdQUVpDRFRQakR3eG05NUEvZElUQ1RjaE95TmlzY2laYWEwak5TY1VCTHNo?=
 =?utf-8?B?SlBaNG5GVk4yQ2Z2ODVBcTh1ZGVodGxxdkZMZXA1UUVQNE11elNQZUVDZ002?=
 =?utf-8?B?WWhCUjQvN0FuYk85VFVNeXhEOFo2aFNNeUFEMEJtUzBvTDZ1cUlOMmo2TkVh?=
 =?utf-8?B?OGdsRHF4MUwzb2ZoOCtqQWNCN1d5dTZkZ0ZVSjR6Z1hXbVUzVmlpK0lSVFVv?=
 =?utf-8?B?U3J4eUVoZ3pHZFRrUkwvY0pGMVY4dW1aQmEwYUNselBnWnVGblVqSEpBQjBE?=
 =?utf-8?B?VlpoVThmNE5NbkhDaFU1WWxtZ0NtS3ZVeXZ4bXhpcHJFZ0VKeTZ6cGxsc1Vy?=
 =?utf-8?B?N0NJQmFkVFZPNWRMVWJJYXNwckhuTzRNcTA4Mm1QcE5sejJtWjhucENEQVU5?=
 =?utf-8?B?QUY2Y1VmUWdpMHdzZzZqV0tNTVk2NVBTa041aU1sNWdPc1pleWRST0FIdkx5?=
 =?utf-8?B?TFJyeWkrbVFraGIxUncraHRXWkFraDFoNmhwT3FnY2I4QzdBbTZXRjBuVm0w?=
 =?utf-8?B?TWZ4WHFBeitoeUZGWi9yN1lyQVZaVGZvcEtpV1pWdGRtQ0VsOHUxZEZ0ZlZX?=
 =?utf-8?B?cHliNHI2UURDeUZMaG5tWGFhWHR0SmlsZDB6elhtcmVSWXF4dXhHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389c6783-52cd-4a1c-d080-08da282e24e4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:13:08.3459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oWKuKjsumWD7nPacFu3Ap9yye6esfQo/jsUqAtfL4PuyX6BoBjm+bwxUMyA6JDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3954
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/27/2022 1:02 PM, Liang, Prike wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, April 27, 2022 2:33 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled
>> during s2idle suspend
>>
>>
>>
>> On 4/27/2022 9:44 AM, Liang, Prike wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Tuesday, April 26, 2022 7:19 PM
>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: keep mmhub clock gating being
>>>> enabled during s2idle suspend
>>>>
>>>>
>>>>
>>>> On 4/25/2022 12:22 PM, Prike Liang wrote:
>>>>> Without MMHUB clock gating being enabled then MMHUB will not
>>>>> disconnect from DF and will result in DF C-state entry can't be
>>>>> accessed during S2idle suspend, and eventually s0ix entry will be blocked.
>>>>>
>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++++
>>>>>     1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> index a455e59f41f4..20946bc7fc93 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>> @@ -1151,6 +1151,16 @@ static int
>>>>> gmc_v10_0_set_clockgating_state(void
>>>> *handle,
>>>>>       int r;
>>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>
>>>>> +   /*
>>>>> +    * The issue mmhub can't disconnect from DF with MMHUB clock
>>>> gating being disabled
>>>>> +    * is a new problem observed at DF 3.0.3, however with the same
>>>> suspend sequence not
>>>>> +    * seen any issue on the DF 3.0.2 series platform.
>>>>> +    */
>>>>> +   if (adev->in_s0ix && adev->ip_versions[DF_HWIP][0] >
>>>>> + IP_VERSION(3,
>>>> 0, 2)) {
>>>>> +           dev_dbg(adev->dev, "keep mmhub clock gating being
>>>> enabled for s0ix\n");
>>>>> +           return 0;
>>>>> +   }
>>>>> +
>>>>
>>>> This only ignores clock gating requests as long as s0ix flag is set.
>>>> As far as I see, s0ix flag is set to true even during resume and set
>>>> to false only after resume is completed. Is that intention and is
>>>> this tested to be working fine? I suggest to keep this specifically for
>> suspend calls.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>> It reasonable for also not reenable the clock gating on the s2ilde
>>> resume since clock gating not disabled on the s2idle suspend.
>>
>> Generally, the CG setting registers are not in always-on domain and the
>> register settings will be lost once it goes down. Not sure about the state of
>> this particular IP rail during S0i3 cycle.
>>
>> If the CG settings are driver-enabled, we reprogram CG settings during
>> resume - amdgpu_device_resume->amdgpu_device_ip_late_init ->
>> amdgpu_device_set_cg_state. This logic prevents this. Maybe, it works fine
>> during your testing because it's done by FW. If the settings are programmed
>> by FW components, usually reprogramming is taken care by FW.
>>
>> Thanks,
>> Lijo
>>
> In the S0i3 entry the gfx power rail will be turn off but MEM_S3 power rail is keeping on and involved device/IP context will be saved in the memory and then each context restored by PM firmware during S0i3 resume.

Thanks, that clarifies.

Thanks,
Lijo

> 
>> Have merged the fix for not blocking s0ix support for some
>>> upcoming asic and meanwhile still need dig into whether the DF C-state,
>> MMHUB DS or BIOS mmhub power gate request different on GC 10.3.7
>> introduce this issue and then make a generic solution for such this issue.
>>>
>>>>>       r = adev->mmhub.funcs->set_clockgating(adev, state);
>>>>>       if (r)
>>>>>               return r;
>>>>>
