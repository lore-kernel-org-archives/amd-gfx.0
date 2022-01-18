Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079E4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 19:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD9D10E1A3;
	Tue, 18 Jan 2022 19:09:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3E710E1A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 19:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIUb6HPy5UsyjduQCCNTFrdZadTsar6Xfgh/8teguA+tTSWOi/dXw37jUh4Pt6SqTNfJKqaxsT2tBR5GmZNvQhVHtfhyyU3WqEOZCLj0kp3ELVmSEZOvRbXqwA5xdhunNUu8VD0J7rS0WlGj6HvPprRDZ5eaxCTBS2DMBkZoQulKWCaXfQPSPdWz9PdOdFyPn0DV85+bxdR6Yfng6dr15vdWN1xKUinVdTjcVgdICQqDPgd46p2Fn7oZiEVUv+3sdLz6O6ycPkvjsAjRqobmMEM7agQYVBUmgmNVnGwACsHwHSQQt3ZFlNgbHqqNug+gB00/Fx8z/p4ubQatQEmoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4dyRf/n8hDmdDCxt5VMQjfT1quwgLgb7g1V++qWLQI=;
 b=Id1omSxFsOrwmlga8DBV4XRZoJjrxWdOFpRsFUHAiH+SQR+fOVWvPPFzm78JL5+c3uqPjoorzIEzZ0ga2wVN19TJwET+Brvq5vCFxNpr0LkmLUw1MJsZe5pQFGUskbVlbTvBq1/Re1SVfR2kAzsJOsonihd48yv+xY5S8q6NdkGMcoRhxBEZqTlxKuRCwx2aOSgNrzimX6SDQU5R07NjQhEzdnVgxL4aVLgu9TD0TdC7yshmV8klwrLF1azq0yE/lHPEQWOMpgJRzKZktcgwaNb7U7wiW2/KsGpCsDU6kfKU+y5Tu7iUZp6o6yIa/5w5xbZrXZYHX4rM2SMnTtGeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4dyRf/n8hDmdDCxt5VMQjfT1quwgLgb7g1V++qWLQI=;
 b=lFE0WyiclLdiSFylzDWirOuJm4rj/w9CuMMy6ZeOt2N02tJOhpDNiePvg1CptY4Xt8/m8EFr2m3ao3GbYE0OTDotqIzTMTis5UI6AvE98Amt2EfSG0LEfJ8rDAauhVXA3Ls4p/xBqApTLfJ4kOJeq8LMOuhmDyzzQvYPSVS1Q/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM6PR12MB2652.namprd12.prod.outlook.com (2603:10b6:5:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 19:09:14 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::144c:ceeb:e458:1424]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::144c:ceeb:e458:1424%3]) with mapi id 15.20.4888.013; Tue, 18 Jan 2022
 19:09:14 +0000
Message-ID: <2f7705db-d5ac-3e7c-a991-79634c0b9f8c@amd.com>
Date: Tue, 18 Jan 2022 14:09:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220118161552.11122-1-jinhuieric.huang@amd.com>
 <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:610:e6::18) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a88ec67-fa76-4105-c994-08d9dab6043f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2652:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2652C915B01B5E431844087B82589@DM6PR12MB2652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCz0AQcjLdI8iTIS6KJKrIGlwtC3J2gEQ4rlP9auz68tkGVVxM+nkq/MhykRSzvz4tDJ8QBb8CRfiAMeL95DD2pRS/2Rcb52fy9yco+p03hO2OR66icyeHoQ5poSK8IP6F1C6SvJm86Pjs2rHTaFX4bvW1dzEYjcUiDHepIc7G8LS35vQ3HridirKLoKS6O0Rcve35qoV4xLq5k9wncHh6BKfwzpHxKkQn8CHHWYKCt32LC6/Q6bTcTHvNSGMZ8UKsKZ5GUKk9Qq2HAI/q06lkQfK7RlUCgAbGedcjE4Mqg5HA95hUVg/4UZbIMlLo6UIDPcmWP9NcZkVGCv8MYH0rp+dG3UhOmb7buyM9Hwj84Nq5plHb1rnGLYm7iyNkwohnMar6exKBDWvDN4LJWNDgKmIAVoYf63jUS4ZtUJkVHKG1fAFanGMsLlg4M0zicYgm5MNHXQD+52+b/nqP7m9SOg6jUmWIC1kDGqYR/fJsRlgvdp5sh85fH6y17FjJOMDLaGymrlzG42NvSa0DILXu0sT+iCx/UsIe8VpxwUws6Uuu5fwPJji+TfL5eNB8siNhryTodp0Fd8Gz16vo5OSIoHc+AFzxVRPpQA7SZdD4SSy9ioZLgmNgKD5KIpxJArMnnJstG1S1BtdX8Tc+cnTQYo3hwNZhQ4MX8owuLZEvCLQUpROFUSwPmg/lBKowWQwVijgQoCZXDxDMn0ajLALO/f6fScO0t+Kssa/qXQwUywtdwoUxvmRd/noTYsAUfnI51rZCWOrM0z07vh+FhqnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6506007)(31696002)(2616005)(38100700002)(186003)(83380400001)(66946007)(66476007)(36756003)(53546011)(316002)(66556008)(6916009)(5660300002)(4326008)(508600001)(6512007)(31686004)(6666004)(6486002)(8936002)(8676002)(2906002)(16393002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBTeGpQc0hKbVZPSDdValRkVlFjRXQ1T2dyR2F5Q0FybnRGd01sQkg5T0ZC?=
 =?utf-8?B?YWx4bDVMT0NhWlQ5YndyQzZ0QnhBV1B3UXE0bVdLMzdOdldmUGVLNnA2SUdZ?=
 =?utf-8?B?MnMwamxEbStXcWdUWFM3WHZjZ3RRZGpMWDQ3US9uVFhMOEtWMzgxcTFVYVJZ?=
 =?utf-8?B?U21RTmdUaHZXYU9aclI3NktWWjN1dEN4cVBuNTkwYU9peHEvNms1dmZtTUlN?=
 =?utf-8?B?UGptZWlHRnB0dnJ6TTdQR2Y0dVEyZ25iQUhiM2dNNmVKdTlyRFVXS2RQTG1z?=
 =?utf-8?B?RUVFWmN6aTgyZFNzR0JDeVZwWVBPeFNnTzZHRjZweW1sYXo4b29vT0hMTXhr?=
 =?utf-8?B?NTVqM3JzZnhtVGxIZk5XSUVkd092QjVwaGI0eGlFNUFzc2lSdE14UUs4Y3pO?=
 =?utf-8?B?NjlIUkdqbHA3RVczZnNiOStZV0M3dTNpSGkzWWl6QjRZZ3lJMnBGSVBFeVM1?=
 =?utf-8?B?S1Z1TGVUcEJERnNTSTJvbklLUlBWQXJuWEpGY0lveXM1OS9LQ2VQemplZjNZ?=
 =?utf-8?B?WmFkSWxCYmNIK1dTV0FIMkhkM0NEWmlmbFNXVG1SWmRKUWp4OS9Qd2pualFt?=
 =?utf-8?B?SDB0YWpOVDRvSks0US9rSTdIejZjOU42WUp2T3FwVUNaM0REVmg4NGYxR3Nz?=
 =?utf-8?B?VjZudjVJdHQ5c0hFbU5NYzZocVZIUmdMN0podVJGUm43QnA4OVZEVjlENWlD?=
 =?utf-8?B?a2hjNEdyUWx5N2ZOSVp1b3NBakVjS3pCNVR5elc5UzEzTHpVcktRTFlmcFIv?=
 =?utf-8?B?MGtrT3ZuaE9EZ1h3SGtlNzFhMnhVOFlUWXBmUzRhejd6K1VDTHgvdndBSFky?=
 =?utf-8?B?alAwS1h5ZjZhTTA0bVFobDU0Y2RRN2Z1aVBCa3ZINWsyOFUvZzZxUkR2dzJM?=
 =?utf-8?B?bzhFQVhXRkdseW9YRDlTbFdoenF3M0Nmd21jTTJHTVlvdkN5b1ZIcS9mdXFO?=
 =?utf-8?B?bEpzTWQ4T3J5MVlGMjRnUnhhMjljMTdFNm1HSGJ6b1hMQWozYTFZaVlZY0p1?=
 =?utf-8?B?UnVmRXRQSWFLb2dIdnYxZkNFVVpZQTNzYVZJdmcrdDV1Z1J4UWRiZDJhYnZD?=
 =?utf-8?B?enZXeXd6bTJKSVlrbnhwaXdIUzlVZGFsUUpSWGFMREFYbjBJNktJZlRRaTNB?=
 =?utf-8?B?d2NwZ0pVNVVqays0V2pDUzYvcDVwU3lJM0drZkY2L1VxN0xMVU15dE95NHpv?=
 =?utf-8?B?aVc4VTRIcksrTCtBSGFGdEdwQm1HY1NhY0hBTS9ISXBZS1hZS29XeDZpcUhO?=
 =?utf-8?B?dmtVSVlSN0hITWlnUEtNczVnMXJlOSsxQzU4RmtZZ0EzKytORUJmUWU4S3VV?=
 =?utf-8?B?K0IrZVA4bnRjM3BsNjR1cFdadzdqeVJuYjMxUjhNWDZEYjUyWXZXd2hYYVNI?=
 =?utf-8?B?OXpmZkE2YkNQaTV1aW9mbkJES0FueVlyWjExbkdrQXBJS3l6U1hpSTNjRXpM?=
 =?utf-8?B?RXFFSi9zQ2VxNGVuNVVvNnJYMitBeUpwNk05amcyKzhPeDhoQ2tEclhKYmZS?=
 =?utf-8?B?cGFJTGRobE05Qkc0Wkp2NGR4cXp2Y2drcTROakMvVkRZTnM3ZDNCVzhGY1RQ?=
 =?utf-8?B?UEZXSTA5QlNvUTc0ZFpXS1l6MVQzYTNhR25oV3AzNG9JTE9aelpQQmYrblZu?=
 =?utf-8?B?VVo5NWUxbUJxUlNETm9PT0R2R2xKRGV2QkhtYU1iS2dsaHZnQ1liRnkrK09q?=
 =?utf-8?B?YTdLRnlqT295bVJRTGlZMlRabkNXdGgzdDZEYTlTWk5SUUhxVm13UzBXSG55?=
 =?utf-8?B?T0gxUVo5WGQ1Y1B2cWlvcTU3WTdtOGs0SDBiSkFZNFJpdFpXQVpYMWZ4UXgy?=
 =?utf-8?B?dVBlcGxZKzgzVkgxUTVHcHRoY3h5MEtCN2xIV0xwRklmZ3NvejFzL0VyZzlv?=
 =?utf-8?B?TnFPU095VmFjazNYY1V4bmtCWkx5VVoyYk5LRXR3WFVRamtQTjZjRjRGbWV6?=
 =?utf-8?B?KzNDeFIxZEI1c1Avejhqdlc4RHdiWjkvWnY5cE9uRlE3SWlwV1U0TVczUVRn?=
 =?utf-8?B?dmVEbzhmelgxOSszV1ErR0xrbUJwRzJwZjR4OFpzT2hHblRqTHFrd1ljYXF5?=
 =?utf-8?B?TU9pemxURzhVbkp1YzFtRVJYSXF1T3lBaEpLOGI2TiszeUswRnlmUWVDWDda?=
 =?utf-8?B?NGowd1BkU1JsMUdYdUZoSXplQndRUmprdlNFRXlSNW90RmhQVUU0NU9ZWGZv?=
 =?utf-8?B?QUU0ME0vTDJ0eExVbzE4dEFsV2JyNkZxRGp3VDhZL01jNHpsL2pDY2Z4bG9p?=
 =?utf-8?Q?5K+sjnp/oIWv8qrok6PyIuJzHjFW6xOMhsn0O0ZR34=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a88ec67-fa76-4105-c994-08d9dab6043f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 19:09:14.4670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9YXGaLZX1YCLmv+XNMJ6vZPaugbwxhLTwgWxOtpcpRyxuuX/5DQ32n+rnaQFBl+4TjXpQGDgI5yWRgr1KPyCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2652
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SDMA fix is generic and not in a specific version of FW, so we don't 
have to check.

Thanks,
Eric

On 2022-01-18 11:35, Alex Deucher wrote:
> On Tue, Jan 18, 2022 at 11:16 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
>> SDMA FW fixes the hang issue for adding heavy-weight TLB
>> flush on Arcturus, so we can enable it.
> Do we need to check for a specific fw version?
>
> Alex
>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index a64cbbd943ba..7b24a920c12e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1892,10 +1892,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>                                  true);
>>          ret = unreserve_bo_and_vms(&ctx, false, false);
>>
>> -       /* Only apply no TLB flush on Aldebaran to
>> -        * workaround regressions on other Asics.
>> +       /* Only apply no TLB flush on Aldebaran and Arcturus
>> +        * to workaround regressions on other Asics.
>>           */
>> -       if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
>> +       if (table_freed &&
>> +           (adev->asic_type != CHIP_ALDEBARAN) &&
>> +           (adev->asic_type != CHIP_ARCTURUS))
>>                  *table_freed = true;
>>
>>          goto out;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index b570c0454ce9..ef4d676cc71c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1806,7 +1806,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>          }
>>          mutex_unlock(&p->mutex);
>>
>> -       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
>> +       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
>> +           KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)) {
>>                  err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
>>                                  (struct kgd_mem *) mem, true);
>>                  if (err) {
>> --
>> 2.25.1
>>

