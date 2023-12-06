Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9E7C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 16:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D0B10E72F;
	Wed,  6 Dec 2023 16:07:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D8110E72F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 16:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL99fjGXMyuPz2E53aDNSODJDzTwPFHN3Kene7+WdoT2dFUWhJrUfmGmMtXPNch0NX2pDs8/1WKIi7OtgGrhV4R3k1D8X8ONOy+/PlCISf1ej9yKJ4dmqx7Qze4lAoV8Y8j95iv1HUa+kPOzON7D81iwqLVm4dLvs7MlzfBejfQSfncA6tpM/UziFNgYt66cCVB43+7nOCEtKlN8YkHri2dRqLUh4fLF2eq8N33a279cJAi5SfyMaK24UChOnJpTFtcL+QuMoA0CtzkSj6479K/WXV6RrYAAEb42r7Z0CrWwTt2nInvMKxcuU56BfIHjHK2JAhQS64QqKrcof80l0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGxZaax5zrBHGDRkEQn6Z0njjWzs3IO57mAvATrDGxI=;
 b=Ngnshk1OXjY1XOWOna3vDDa1Zz0dknXYPcL/SEK714lUeVzZ2HhNnnfjNwnqsby1xhYuanSCXvLvaU28IGo0KEG9luSj71oQ+Xxo8F5Sc1uD25Sil+SBYarBetcDSUhC+OjAv47MFxPA5UP4ttabkEHdABfh3Djf8qsjex4NGjs/OUJfhCuJ/gqNc/R4J4xX6Q2kWrE/fKD5L5evwMADOuCoCQDUHxpKiM138DTLTMidP7dPMTGhvUxfCwtGu2ZeLPOGfPALrCkhuEbK2C4kIN3RUUYHkGGhxzQ0QR4x6dhk1IWFKQEZ5HU8TXlGnLjpPZZ9aUWLKsu3n2zMk6S64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGxZaax5zrBHGDRkEQn6Z0njjWzs3IO57mAvATrDGxI=;
 b=S3TJe1sDx20uDv0pfExB8LElpIMZMr4K2VQjWkoY7RTvxQqtY2hdBz27u1TEntfj8XLTnMIJqY3fJ5GEZa7Zn1j2tzdIrWdArl8P37Bln8pB3rjE3ssgisfaibxFJfiCvxWyP6VRNcw7NF9QXxG+aR711aIMz+Buy5252f81GNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 16:07:00 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 16:07:00 +0000
Message-ID: <f7d4593d-cbea-4e33-9eca-09433b4148fd@amd.com>
Date: Wed, 6 Dec 2023 21:36:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use the right method to get IP version
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231206124107.1462461-1-lijo.lazar@amd.com>
 <CADnq5_PDN8_Bo1pBTQeMmCGqA+2uxGsiqArHJkKQaHmz++0yTg@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_PDN8_Bo1pBTQeMmCGqA+2uxGsiqArHJkKQaHmz++0yTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: aa21690c-7d14-4417-7f88-08dbf67560b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcVPMYgwgsrPpNZqDQwrhmbNySYZZNqbLETMESPnCDouQzA7w4dTrbOCQcAkTPc7TeKp9iKXA3z9m3JjZWNRcbiKftZy+deAZt6WPgdRNQnIGjUDkSlJrg+YkUBAzYdlSnR/LnX2ft5IDBD6N/ygabxfvGi340nflfLDPzXIHjI8VBqVkB0p4KXO1We5mLW4g6JF/ZV/Y11wSvw5aCFuQmIJtdkaNgI/F4KUlhxM2iIwWlHewWhDtmDj5PjvXq2b0YQcYdGCGxaM/Z0p99wu86YmNEdh3uxDFtHtT2sVaHsKuJaFjnBkJggzqAPc3QQa3mOFiUmq5YUktb3GY8aFpIS2VKMCYKAwTjevgyZhQl+om2Sz/zG/Y98QDUCShPmWNF80p/4lKAG73XBbRAbzTMOzWz2mxkB6rx7ZvWxvcfTvUSjDL5bbFEfW7V8flLiZy5/LDNYxaBDQti8Ud6TpDyHsfOTne7AQ0emnqVAQJ8JkWrpXhlSXDSVUQ8w8tKhGRdMC4IXt9GZpyTsnhiGFy27JMFlX1Rc2pP22vTytrI3FW21lkpbNoZdIYhK6n9oAR7jMUknoZ3/Me1NPoSZFvgXxCoWjORTiC9dTePWqs5A/0uUaOXrHVt7AairvPzOQ1A5A+pwN/1duDYL9ozgjHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(5660300002)(38100700002)(41300700001)(36756003)(31686004)(86362001)(4326008)(8676002)(8936002)(316002)(66556008)(66946007)(6916009)(66476007)(478600001)(31696002)(6486002)(83380400001)(6666004)(6506007)(26005)(53546011)(6512007)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVdVL1FEMjdzOU1xTkN6L2k5WUJJeW91WlF3Y1VsYnRlcDZXV0RjR0hVcXdF?=
 =?utf-8?B?UWEzakpjdDJZNWhaeGZvYTZnY2FBREZwcEpEbkxJWE12R2lrSWZzdGd6Sm9S?=
 =?utf-8?B?T3pHWEtVTnFISHBXbGNnM2ZwQnNUNlo5YlRhY3haYUNiTCs0RG1SNEtzVTJP?=
 =?utf-8?B?dnNCWmF6dFRVM1lrTTZOUVREOFkxRm9pNXF4c2R5bThnNUlaUm0rVldJejB2?=
 =?utf-8?B?RHRQOWo3YW5WOVg5TEdBQldqQW8zYXM5bitnYVl5SHlTZ0VrTENWdHB1VGVY?=
 =?utf-8?B?VVFjd0p3K1RXRXlPVWNUS2ZvVFJzcnBTZWh1RUNQWXp1cVdvOEhZMjI1bTRh?=
 =?utf-8?B?UE9uWnpvdjdUcE9mbkthQkNXdmNwQUxuYnJJUnM4VjhrOW9GZlFnSm1hbGRD?=
 =?utf-8?B?SjlzbnRvR1RYb1ZJN2FNQkh4NlgzU1BFR2k4R1ZoempOMWlzbS9uT2E1b0Ji?=
 =?utf-8?B?N0EyYmZGS2pQY2tVbWVYTUJ0eHBVSUY0S1hkd0FDME5IQUViM0tlV0Z2c0xZ?=
 =?utf-8?B?MHZvRTFBT2loUVdOd015blJLNmU2dE51ZjVtSWtwVEc0RU1vR1A5d1dFQTF5?=
 =?utf-8?B?ZnQrR2FQRGhTZ3JoRUJMY290Mm13bDUrVCs0V1FKU05qQ3llT1Q1eXRNZHAv?=
 =?utf-8?B?M3ZHR3JBeGRkcTdxTDJsTXJMR2xtZWxsWDRyOGQwQW0ydTZxaEJnZzJlUGl1?=
 =?utf-8?B?cUxuTGxvV09OUWh4TGkzWmtSRXNSWk1ZR3doaHpjd0xia0xyU1lGKzhIdWox?=
 =?utf-8?B?NTNqRE1KM1JZTG8zWUowQkdIT1FrVkVTV2laN1p1YVF6SkttdDdpS2FadjJz?=
 =?utf-8?B?cjIrMWs3YTV5Ris5T2J4UVVmVi9BNWJvRnMxQUtZQjdnYVdDZFg4b1AzUXVE?=
 =?utf-8?B?bm1jdWttbWQ2Zk5jUXNsYXdQWCtRWFl1Z1loZ1BIMjNEb29qaityaURBQnhj?=
 =?utf-8?B?aTY0RnhEUERORGZvcjROZWRaNUtqdGllOTZ0TVgwcTFJSmF2cHJPM1JrR3J4?=
 =?utf-8?B?MlpTU1krT2Q0bmVKLzg0QzNSazFaU083Q0ZhWnlTNXh1azd1UFZNazhXWEN4?=
 =?utf-8?B?Ulh1WU4xc3hFUkZVT3V2djZWSjMwUDNwb3NiMDBwc0k4TXZxKzZJYjRUNElt?=
 =?utf-8?B?UjY1bHdCOTFMeUtUaFExVnAvYzZDRFlsemMyTS9uWE1IYUV5MU9rSkNPeE16?=
 =?utf-8?B?bkFkNVZCZjl2MDh0aVlmNUZiZ1RKUHE0K1cwaU05TVBBeUxqSVUwSmJzNEdE?=
 =?utf-8?B?SDZHd3lkUk5tSEdwaXlWbVA4QU1NZEpGR1dkc0hKSXhMRkJLcGgveG5BWWJF?=
 =?utf-8?B?UkFtdE1uMTJjRDkvQm44YkFLT2JCaWdqNW4vSVgyWklOM3BhNkRtTG85eTRn?=
 =?utf-8?B?cmJMcm9WSkJYbVFZcDVndkVpL0g0Q2xXL1doWWRkZDZXR1ZpOWZ0c1dEMXd4?=
 =?utf-8?B?bkM4VkxORnQ4VThSWTNUenp5Z2xmOUJ4dGdvVGM0bGpYaVhnVDJjT0dnWkFD?=
 =?utf-8?B?Mzh3TEYySHFOK0tZbERCK0RmNXpRb09Xd2ovdzFYQ2VnbDJQdVFISWZHZENR?=
 =?utf-8?B?OFl2NE9KaXZUWk84c0twbDg2ZEUwa3JpTDNUUmhJUWtzTU83dFN4ZXhuUTVU?=
 =?utf-8?B?OGtMMnExNTJIcWVRV00zVGxhUnRBWGk3SVoxbjdweldVOUZpaDNxMTlET1pi?=
 =?utf-8?B?YjJqdGhZN0I5ZWVDbFZsbUljVjNkTnNITVEzTWlwTG0zdUxPck1tdTNQdm56?=
 =?utf-8?B?VHV6Q01mNkpOK3QzaDVCb3gzeHJqdndjN0REZTgyZUl0azJDcW1CaEhqUnlo?=
 =?utf-8?B?S2tTam9tdWNIUU0xOTFFUVVJM3dzcmJzajBZenhiN0VXd25Jc2M1T3JYc0w3?=
 =?utf-8?B?Q1RtZWEyekdwR2ZpRUlGVDlmb3dTaDZySUZ1QmszckhtZHBIZFllMFU1ZFlx?=
 =?utf-8?B?REllaXp6N3VwV1kwZ1JXUnJpY1kxUnJHWkdDK0NHQ2NmalkyQmQxSy85SFdj?=
 =?utf-8?B?M2thTTFVSWRJRExTYjNVeXZNaTU4cFRkREFEdXJ6NERvekttYXYvdC8zMmtE?=
 =?utf-8?B?TEx1Q2VtRW5lcTBNcFFLWW9yeElQTXpMWmRzd3FQSVZnM29ZQ1o2eVNHZnds?=
 =?utf-8?Q?ILxSXH+0F+rxzIl4WAw4LOJmL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa21690c-7d14-4417-7f88-08dbf67560b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 16:07:00.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5kEsATLummfeq1W4kI34KFr1GbQOqutWoOpfxs0t7Cf3FHZwAcbh2IZ0VM6YZgj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/6/2023 7:40 PM, Alex Deucher wrote:
> On Wed, Dec 6, 2023 at 7:57 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> Replace direct usage of adev->ip_versions with amdgpu_ip_version.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 

I see two more instances of direct use. Will send a v2.

Thanks,
Lijo

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c          | 3 ++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 2 +-
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 6 +++---
>>   5 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1b73f519cfb8..f9e8341d9449 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1599,7 +1599,7 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
>>          if (adev->mman.keep_stolen_vga_memory)
>>                  return false;
>>
>> -       return adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0);
>> +       return amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0);
>>   }
>>
>>   /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index 3a632c3b1a2c..0dcff2889e25 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -1099,7 +1099,8 @@ bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev)
>>   {
>>          bool xnack_mode = true;
>>
>> -       if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>> +       if (amdgpu_sriov_vf(adev) &&
>> +           amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
>>                  xnack_mode = false;
>>
>>          return xnack_mode;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 2ac5820e9c92..473a774294ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -883,7 +883,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>           * GRBM interface.
>>           */
>>          if ((vmhub == AMDGPU_GFXHUB(0)) &&
>> -           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
>> +           (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2)))
>>                  RREG32_NO_KIQ(req);
>>
>>          for (j = 0; j < adev->usec_timeout; j++) {
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index c146dc9cba92..394142cf72bc 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -9860,7 +9860,8 @@ static bool should_reset_plane(struct drm_atomic_state *state,
>>           * TODO: Remove this hack for all asics once it proves that the
>>           * fast updates works fine on DCN3.2+.
>>           */
>> -       if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->allow_modeset)
>> +       if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 2, 0) &&
>> +           state->allow_modeset)
>>                  return true;
>>
>>          /* Exit early if we know that we're adding or removing the plane. */
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> index d8f8ad0e7137..4894f7ee737b 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>> @@ -224,7 +224,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
>>          if (smu->is_apu)
>>                  adev->pm.fw_version = smu_version;
>>
>> -       switch (adev->ip_versions[MP1_HWIP][0]) {
>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>>          case IP_VERSION(14, 0, 2):
>>                  smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
>>                  break;
>> @@ -235,7 +235,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
>>                  break;
>>          default:
>>                  dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
>> -                       adev->ip_versions[MP1_HWIP][0]);
>> +                       amdgpu_ip_version(adev, MP1_HWIP, 0));
>>                  smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_INV;
>>                  break;
>>          }
>> @@ -733,7 +733,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
>>          int ret = 0;
>>          struct amdgpu_device *adev = smu->adev;
>>
>> -       switch (adev->ip_versions[MP1_HWIP][0]) {
>> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>>          case IP_VERSION(14, 0, 2):
>>          case IP_VERSION(14, 0, 0):
>>                  if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>> --
>> 2.25.1
>>

-- 
Thanks,
Lijo
