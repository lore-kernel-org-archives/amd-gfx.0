Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D584C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 05:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F137861076
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 05:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F137861076
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FFB895B6;
	Tue,  5 Oct 2021 05:46:34 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4B86E20F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 05:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwCW4G72ZASMgxx6P2I7WBOCNs9YOz65ZxcHLuZr7FJM4f0Dwy6vKtkvIpY6CVSweHvTm+1sEUgjrILRhWB6MT5yKojv0BjKVn8omFs0jmnp3joszmfEmK3FXTJsIJULD8+oD8OwZK9eOQ1CiM9cccwEiqw8Gn9o0P2AfTGzYed7OobyGoEuqo1phZbQlC2lr3pYirn/ojlEJ/iX+410bMmfZkzjJh+8w7KDyLYqGwG3jx7PmxCBEXhuy8o72wwHWVN3U/6YG/6BxmIJs+D9yOKzpWtGyJQn2ErHgK3rLKb8e54J2uIDz12XHo3hGAKoMPikCofrt9Rm9B4RWYpD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A68A9ElrjGnuu9Lkj4aHEosRzWGQUQbp3OFJwq3Mow=;
 b=HNJUBLuKY2Z0dlcDLFZo//BXun8ptWjtesWKj3epTAqbaexVCJEBawob1Y1sKiRDKl5hywMBFcprX+FG/YOsz6dAnFCzsjTW8IUd876lcZQIpvHO+LyxB5a82vso3RNoVqWO6Defx12LnO3IzFcbTgYt0JGmqXYfT6EJGy6AFWMSG3UUu3cTR4X6L/YKxuU083ZF/9dvxLcKTw2UPERoFr1Yza2L9XwORqbi1Vm4Y6H5QsHjnK9V244i0fE91ruiVVtktK8ZAaN+yLajsnmdC6Vuy4ju6EN7GbALIxl7rvl4AHId1X83ocepVWF8ovYO9WpvzyAWJ6fY+uRJKMea/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A68A9ElrjGnuu9Lkj4aHEosRzWGQUQbp3OFJwq3Mow=;
 b=WtMvOAH1y0LwOvk0BsFZMhZkmcWJpogV3zeWwO+JQT8sYznU6/pVkRSOrrLLlMaz9hC+E/qHOuM4s5sUeqs3RoEWRGnpBkoszE6ETSTEdUyXUiPFHbQ7sws7/2IYprQ+WjL1LnNdGk+UHXWKoflhyno9qVQ8ekTf22olHruqc/c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 05:46:32 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 05:46:31 +0000
Subject: Re: [PATCH 3/3] drm/amd/pm: explicitly initialize cached power limits
 in smu struct
To: "Powell, Darren" <Darren.Powell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211003044658.29238-1-darren.powell@amd.com>
 <20211003044658.29238-4-darren.powell@amd.com>
 <d3b0d32c-0c14-c5ff-4157-501599c502b5@amd.com>
 <CH0PR12MB538758212431DDDF939AD18CF0AF9@CH0PR12MB5387.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <2c2ef5f5-fb78-a10c-c3b6-7f2291d27ace@amd.com>
Date: Tue, 5 Oct 2021 11:16:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CH0PR12MB538758212431DDDF939AD18CF0AF9@CH0PR12MB5387.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::15) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:bf::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22 via Frontend Transport; Tue, 5 Oct 2021 05:46:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0bf7ad0-a582-4d6c-58b4-08d987c37be6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43403C9ADC11960E221BD0C797AF9@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vhaMA2jbaZ9VYzeAgmPBPozAwjyVY01uCd72qCFx4Y2sQzMk8PfhZgzn/JzN/MS0RmpNZNStG90JZQ60fmiPsiNtjiWeey5XXN7YW5JoTnuLpPodrHj34EBFrGMCx+omvRYRa7rAR8InWgYNik08ugpGHKkLW8EknzsSbscTS2W0XWd8MyTVTyvJg9LUc0WT8QgxuhNXESrZ3TiNEFMLs44KwIB2NG4G20yIu2+ny0kK/xqXOf6gmyarppnH5xtHeTAVXhCs9O6XLJ+/q1MG4v/bqoyM4b2kYAYjRWcNRREHkCSlSUr1WmFgcauthb2WMqz3E7lAarkAlSPgUgQV80KYpAJhjWpUihhrfFja5QkRTv+zGiqueGRb68brO0j+HmmdkKwiaC46VyaE/bhZnJz+mHKvhxrQnIuhFIZ0MxqFbFG4FHNPde4VOGoZmF4djk9YjjCknoTLaWJxOx8w+GEcIf7CtMT4544dMti1jBbwDdqh1kXtarmR3ypqtxLDisUzak0kSQ3Ml5MLza0R1jCXeE2AOmx3AFv0B1z4vqkP/YmJInp597cBORic6ebJQNup4bpwdHV0u+JZ4MzQlbvla6XziTYC7fVRDzPAQsz9z++OBEbvhlpNmVORtmWfq87p+RO9iMZQxpVc6FLGdgpmyHnc5eXbEOcj5XV6Ej6mZyo+PloY8BmZ15s9re9/ia5H5B2KDSZt+cGPHfB8AX+mI/MHvAC9ixxxShEfQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(38100700002)(6666004)(956004)(2616005)(36756003)(86362001)(5660300002)(83380400001)(31696002)(8676002)(66556008)(2906002)(508600001)(16576012)(26005)(110136005)(66476007)(316002)(186003)(6486002)(66946007)(31686004)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2I5VUx5ZnE5cWMyeUs5VnQ1Vnd2ZERJeDdFSkxUMDRyYWpzTG5sUzhkWGh0?=
 =?utf-8?B?VHJYbGNRWEQ3RDFuYmMxSFVhRWY5OGgwejZqMkQyY0Fzd0Rxdk1qQXNXTEZG?=
 =?utf-8?B?TzB1NDZLaWFQendPUHBkc0xxN1lTNmg3Q293T1dndHc1Uit4RVlzYUp5aE00?=
 =?utf-8?B?MnVyS1RsbFlpL3l1SDM3ZHhsU3NEMkRLSElkMjk4amNsR0JhaFFGN3gvTjYr?=
 =?utf-8?B?b0U3OGdQOVZ1Njc5OFd0dUdoQXU0N0o2MS84QkwvM1JQQ2VXcWVWUE91RW9O?=
 =?utf-8?B?ZlpGbERwanVYa0N3WFJUbWg3NHgxdUp2OHBuSjJXbFFUdTdnTk44RE0vN3Ju?=
 =?utf-8?B?UXBvL0dJdUc2Wng2d2NXUm9OMjdSODdYMGhJK0l5Ukd3ek9oUzFYZ01sOUxj?=
 =?utf-8?B?bXl2YUZmaVRzNkhDcDVGakhoYzc2QkFBbEhyK0pDRXdFUDByaTQxR25BaVZS?=
 =?utf-8?B?QlNsK3NtRVo0U0pIaVBndUw3Z3dvRkhGdTYvTDRieDBmME1hbGtNQmY2cnY3?=
 =?utf-8?B?MkQxamJab0M1Uk94alV0eWJjVFNUMysrcnlnYnBENHYweEljcTdyelNabzhI?=
 =?utf-8?B?WTZRNTk5ZktEMkFpWnROY2lNcGtQMFpNSXI1TmZhRHpWamk3aEhEc3VqV1hm?=
 =?utf-8?B?OTgyWTJPWHluZS9pRHlucUlncCtyek4rRXBLS3RKS2JQeEM2Mk03MjUxbW9B?=
 =?utf-8?B?cXBYS0U0U2JuZk5Gc296SURaYTRHaExJdE5NdUZ4MlovbnNhK2E5K1JDWHVW?=
 =?utf-8?B?N2hTSU02NnQ1UDUrc0NzbGVBMmRKTytTRmoyZ3RvQXRyaTZRTmhWQzRTN2Mw?=
 =?utf-8?B?QXg5cTdtL3k0Rkw2MC9FU09oK1c4S3l5UHBQUjVvUTk0M205SFg0VjB4MGND?=
 =?utf-8?B?UFRQZXY2TWREODluOVJ5WXQ4WDdyRk04NG9CdGcvdFQvbXV6QTJjVTdUTnVr?=
 =?utf-8?B?SDBNTGRsbnJhRHltUTdNMHpvcmU5SW80K09zZzJrUGJRUXRIME5BSnBSZUVP?=
 =?utf-8?B?K2dNQ3Qxb3hjOWthU1JOS2xoUXpldGVOTjF6cE8rSmg5c1FzUWtjYW1STW10?=
 =?utf-8?B?UXdTU3FkdFdUUmJGMU5wNkJPVFJKSlQ1TEdoSGtMaHdqcS9VZHBWZWJBcXgy?=
 =?utf-8?B?OEc4OHVZc3JwQVhtb2NKSkhwUkdHVDFFc3ZRNHg1dldtWEZMbkJWRWpadmFu?=
 =?utf-8?B?VzZ1dzZrN0lIL05ORTVlVExLaVZaOEoyZEZFbkhMMDZFOURtM0J1VHFiYktH?=
 =?utf-8?B?dXh6cmdCdWJKU1lMaG1objBvNFMyK2IvNENOS2V4Ui9FQTI2TkRlQTQvY202?=
 =?utf-8?B?OFcrV1J3bWgyQ05sU2tYeU9NOCtaU3JWS2U0and4eXBLUFBjV2dYeHV6WGk3?=
 =?utf-8?B?S216bFJpQ1NJdWlHUXB6ZVArN2JOZDNKYWJ4RXNUaW9XODJTUUQ4ZkRlN0tF?=
 =?utf-8?B?bUVsam43R3d6K1BLTkx5Ky8zWFI3Z1dPOHBwUWJrU20zOFRSY1BLVUpiZDlM?=
 =?utf-8?B?NWFuanlLUklrSHB5bW95eTVBSWdReW9sOHB1TTlqZnc3ajlJWHBTT2tzTG83?=
 =?utf-8?B?Q0RUL0lwY0FDMGxQcEthQVp1VGQ5cjFHQkpsUStNbVhOMlVpaklGQTBhOXJW?=
 =?utf-8?B?bExkOENqd0pKbUJZeDd0bk9jT29yZGlnYXpObWVIdVU1WXcwZHBxV0tlaDNM?=
 =?utf-8?B?MlJhcWhsdHJqdzlWbUpNUWNxalVvWXRJSlZucDhxWXBEcnQ4NHZMTU5GMFdY?=
 =?utf-8?Q?5t3IQPRxBxPYJg70TC9dvZvW4rwJwfnjzeS37Pt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bf7ad0-a582-4d6c-58b4-08d987c37be6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 05:46:31.8240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stL/3QKAa0nt1wObkN5dUurl4kYMrALCplQSNz7u4lKr9Uxdheggy0BnZGflz03S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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



On 10/5/2021 10:34 AM, Powell, Darren wrote:
> [AMD Official Use Only]
> 
> 
> I'm just looking to clarify this code. The macro eventually expands to 
> look like this
> 
>     if ((smu)->ppt_funcs)
>     {
>        if ((smu)->ppt_funcs->get_power_limit)
>            (smu)->ppt_funcs->get_power_limit(smu,
>                                              &smu->current_power_limit, 
> &smu->default_power_limit,
> &smu->max_power_limit);
>        else
>           return 0;
>     }
>     else
>        return -EINVAL;
> 
> But you have to dig to realize that it's a macro, and that it makes no 
> modification if the function is not defined. It's not clear without then 
> searching and following the function pointers which platforms are using 
> the saved value. I thought of inserting the following comment or should 
> I just drop this altogether?

Yes. The limit values are by default initialized to 0. If the function 
is not supported, it's not considered an error to fail late_init (it 
only reports 0 values in hwmon).

late_init also gets called on other occasions like resume or after a 
GPU-only reset. If you want to change the invalid limit value in hwmon 
from 0 to something else (to differentiate unsupported vs API returning 
0 value), then better to do in sw_init.

Thanks,
Lijo

>   /* seed the cached smu power limit values iff get_power_limit is 
> defined, otherwise they remain 0 */
> 
> Thanks
> Darren
> 
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Monday, October 4, 2021 6:43 AM
> *To:* Powell, Darren <Darren.Powell@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 3/3] drm/amd/pm: explicitly initialize cached 
> power limits in smu struct
> 
> 
> On 10/3/2021 10:16 AM, Darren Powell wrote:
>> Code appears to initialize values but macro will exit without error
>> or initializing value if function is not implmented
>> 
>> Signed-off-by: Darren Powell <darren.powell@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index faa78a048b1f..210f047e136d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -712,6 +712,10 @@ static int smu_late_init(void *handle)
>>                return ret;
>>        }
>>   
>> +     smu->current_power_limit = 0;
>> +     smu->default_power_limit = 0;
>> +     smu->max_power_limit = 0;
>> +
> 
> If this is only about first-time init - smu_context is part of adev, it
> will be zero initialized when adev is allocated.
> 
> 
> Thanks,
> Lijo
> 
>>        ret = smu_get_asic_power_limits(smu,
>>                                        &smu->current_power_limit,
>>                                        &smu->default_power_limit,
>> 
