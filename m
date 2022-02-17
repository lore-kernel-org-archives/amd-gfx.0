Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB569C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 07:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BB910E966;
	Thu, 17 Feb 2022 07:39:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9320A10E966
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 07:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlZLoySwfoiH9+5VoAESst8Q00K7xcYt+2J2Mr5jiDXGx/52DEgcoAsiWTatw1J70cAoMYQO/zcj7SwaF4ONaduZIc0HJBrab41ci8Lh47lVlYAWJIyyV+9D0QiubMxM+QcgKHrQQeN++WllEqV+7eKO7s6yEe8SqF1aJzazHw8kcdclKIjCssA8GojYF0T1gY7p+djanQl20OsybYWKnA08kbMxJzolCgcmOwEAwTcHwECHlBnLTZw7O2TalJ/bQejHvFsIh7CRJ0gxD5oc/CAEioa/UsxU/L8+LfFNijHVMiWZjrxBroVAbpmYy1zQj99BSxl8NaEM1/nKHrIb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wN2pqxoSEsQ2DMl30a0MaY4bxdIL8v7oJ/rWA0v9izc=;
 b=RjnHHsOwFcu91IBvz0zp1+8C2l27Fm45RsryAdUZQ2ZBnquMJ1z6FMoYiJXcSWbn0ktRAj7lnRGmp122zN2//qdl0iM7aDhbxwY5ISQ2unoccsP3R3/LZkOHtQKGQCHQD2c+HNKx6bK79/i6ef7+jVNoNCpvCQnikcM01K/3u3tIi+lRCbds1ItpLhFu9o3KP2dc6xzDWe8CHvkHqcAdrQizp7UM1a4hFB8uV/XzD3GyB5s6iZrg0eNf9gqioNTEir7dSNKSWx3FexpttOr97FjPF3LIxeYs0TRTlysLIpQkjvZfPe548AR4pdt4eU8G9t707SCWnkrn8E3yeQYwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN2pqxoSEsQ2DMl30a0MaY4bxdIL8v7oJ/rWA0v9izc=;
 b=E5AljZ59URXPU+qi6Zop457doU8HzXSOEmc+9hoU7H54iO32JHjZ6EfA9xDgTiW3yKQYZcy9zR3GXj/DC5YoydRvVdMVMXrkACaFmStBVi3ecDo2q5KkPF2LA8mB65r6Ijk/0hZETTF7Rn7d4LJAJe9a6KDHe/J6OsWw5CUEBMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4891.namprd12.prod.outlook.com (2603:10b6:610:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 07:39:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 07:39:19 +0000
Message-ID: <877dd621-3615-a278-4090-24b314f21a5d@amd.com>
Date: Thu, 17 Feb 2022 08:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: fill scheduler with device ptr
Content-Language: en-US
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>
References: <20220216072223.8394-1-Jiawei.Gu@amd.com>
 <20220216072223.8394-2-Jiawei.Gu@amd.com>
 <6ea78726-4121-a01a-57d1-76d496e6bcc8@amd.com>
 <CH0PR12MB5156D41524A4F2C3458FD5A9F8369@CH0PR12MB5156.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH0PR12MB5156D41524A4F2C3458FD5A9F8369@CH0PR12MB5156.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b841c985-3265-484d-82a4-08d9f1e89b1d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4891:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4891AE79D6648A2AFF64FA2083369@CH2PR12MB4891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssz4d/r9iz9qc0KkrU2p6b6RGKBQHjZ7MpAjsr3vhgWHIgmHVOksrqpcTrSJqJRW242wcFike7Slv/FySNEHw5hUYCXQ5nJhz+5h0h5++4EbVcWozTj1i6mGHmzSfz4mnJfHWsegP8NlT0MnxxRrIGLqfz+dbOpvDvhRJ4kUnkXJcH8LkdDNDniTvK1V2p8Cp0m+0dCrEmPfq8qzJwf3MEJpEZxm0IpIHodCDg55uc6NDd4tZusuTEUOtQILJZn95MGhQxrOhmtsZTOXDbg7BovQweno+zjQnHxzoGM+nF0UqSNAJql608iYz09BEdx/A3ec9JZxYlj+nCstwzzsP0FxQGDPMmWbY7x3YlKXWwEKDWVC8GlgvrsH/QNpe+f0dWi7OpPzpYBPt03n2ElvyCDWoTAnNn4XThgC0NjFxspEwUNBsmzH7Jiatdvs+LmnIDb9A4DR80ewYNV4eYYkFFAwzwkvsUeb9cI74u9lD+LDDBNsd9snE4E8pLyRXv/dmLcYtD5DL0aixqAPcrD7zF5RkdzfC0THOU0nxz04Et+J3yqF8LDBe2Q0MnyLa8CWy4db+e+fmCHyfR54G28ayanW10qs+GocIyKlcyGiKLgWy5YSA8e67BvxosSRfX/0Xo2eSQ85xL/EossbBQlAdDIXwLITPWwxipFz40kakSCqLDDT8LLl8E2emcpyfiHUb8C7VE2vQez0QssD27y9D5lad8L5mr8V7QNfWU/RpTmukPWd0nkMfY8f01hNTdWT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(36756003)(83380400001)(921005)(2906002)(8936002)(38100700002)(5660300002)(53546011)(31696002)(6506007)(186003)(86362001)(8676002)(66476007)(66556008)(66946007)(6512007)(110136005)(2616005)(316002)(6636002)(6666004)(6486002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnY1VWFwUkw1Y2ljdHVEVm03RXNvWklmU0Jwdis5LzlzNHk3MHRRZ1lzZlNu?=
 =?utf-8?B?c0dOQ25rRG0ya295VkYwQUliQ2NiTkVGTXpGcDJIQVFjeDRGbjhRUzlaVk96?=
 =?utf-8?B?a3JNVmExQzNvVmdYbXpHVlJTcHllV0hTbVExZW5GVGhwUEVWbFhuc2Frbzlk?=
 =?utf-8?B?MXRzRkdnYy9pY1JjMExpaHNYNTdHYVpYeDdGUGhPWnFNZng2N1J6NUg0TVVn?=
 =?utf-8?B?SG9UV0wzRGVZZ2dGQlgzcnpjVUpac1RheUcrclpadUdvSGJubXJXVW8xbzVI?=
 =?utf-8?B?MjNHQnVTNzF1TnBGMUNpNXJOR1BjUmxiM1o0UEZSUkJ2YTJORWlQb1dodzRv?=
 =?utf-8?B?RzRwN0xYTXBoOTR6Nm5TeVhyRU5qbXFhU1JkeitKNnM1WW9XUFBNTlNTTEJV?=
 =?utf-8?B?dXZaU3dQdTE1Mk9Nak42R0w1QmRXZTRoaFZrWXVuRWpmemFIYjRHeFhiU1Zv?=
 =?utf-8?B?STIvN3VYL2JYNWtjL1lrVWpiMHV4R09iV2JOWG5kdmd4WjNGV3N6ZnFyNVlY?=
 =?utf-8?B?WVR5bnRtL2dnS0JjcXhHWFY3NUEzdUZrSFpUVERYTzdZR3h6RWRzYVkxS0tS?=
 =?utf-8?B?THV6VUdiUjJFaTZHVkVDdnVVanVTRFBUNk91dzhJdmxtWEhxNUpzNkt1eWlB?=
 =?utf-8?B?QXNDQnFqeXZubzMxQkFPeWU2Nkk0NE53R1dGcHF3MEtsVFoweVgyNDNVYWV2?=
 =?utf-8?B?UnZlU2JibGZPVVg5aytWMVNQUG9DRkNvck5oSFllZFJsMWloT2tUUHBZdXpT?=
 =?utf-8?B?aGhub01ab1Z6U0Z0cUhPQ0sxZWdZQ3ZkQ2xtNmw2d3R2K213Rzg0TUJVcDR6?=
 =?utf-8?B?RlpWaEpvSy9GYWFEZGtvc2c1akxObjZQeU9iUzFqaDkyMTN3K2RMa0dnSG1k?=
 =?utf-8?B?WFVSS3VUVWJkcTZza3NhZFB5VkhBMldpbXo3TDJodUNYd0JZelJyZmlOcGsx?=
 =?utf-8?B?eHphd1RSRDFUZ2JBUjJxZEF4WGsxNFlrdUdKMkVSOXFqNG5MVFhuRXpiQ2xH?=
 =?utf-8?B?N0tWNm9KVEpud2krcnRLeVpoUk1CaFNadVdtQWhtZjVBWWdSS1Qva052OFVL?=
 =?utf-8?B?UVQ2NTIwMm9wV09rSTcwWVdDTGNwcjFqemdhWFAwZHJRNURicGNBRDJNbFdX?=
 =?utf-8?B?RHpIS0NQcy9wU0RaV3gveko4Y0wzTTJneGhHbGtNSnNhMzVjSGZzK3BlYnpT?=
 =?utf-8?B?Y0VSQlVxVi9TMi9aQkJpVWJ4Y0cxMzJKMGdjWERFUjNBYml0WjZ0cGgvNU1z?=
 =?utf-8?B?WnRKaXVqZmZtUVFMOEFyOWVPVE00MFJYRmZBU1BhNWtpS0YrSUZnY2xvUnhS?=
 =?utf-8?B?aHQ2UkdUWE4wd0VWaU5iTmRhcnEvcUtpd1FNTndMNTgwcDAyYTBVbEZLcEMr?=
 =?utf-8?B?UDY3K3JCMCtFTDFGcEVTSEp1MHJUczhIR1ZRNHh2alNSN2dUVXlQVG1qMzRL?=
 =?utf-8?B?T0RQVWQ5QXJZdTIxS1RTUEh0MFdtcXZzMTcrdVJ2Y250cGxudE5qbXJCbnZL?=
 =?utf-8?B?a3IyMnpDUjFFdVhyOFc2SDNUczJJTlJXV2J1aGNzMHNmck4yb3Q5S0NFSWU0?=
 =?utf-8?B?Y1ByM0lJTlk5TFlNUm9kUVlzZ0RrMXl4MEJDdmFTcnI3cE5OQWpzZklEUXJJ?=
 =?utf-8?B?YkJhQ3BYclorUWp0UG5IdDJEV1hZUUkzcHRIWXdjQW1WbzRrK0Nlci9KVTRK?=
 =?utf-8?B?RGt3Mk53V0tweXZlRXZMcm9hZS83VGZ1T2ZoaVkrT29FLzNRYTFrQ290Ny8z?=
 =?utf-8?B?bVM1TkR0bkh0a0pLdkdaOExTYnRDK1VXeEtKR09XeG5KRWg0ZU54VEVhKzMy?=
 =?utf-8?B?TGxhODhDTGUzZjJ4MDR1cWtVZm4ydDFEbzQvYm53UW9nbElVTmRyNGN5YXVY?=
 =?utf-8?B?MzJSTnlWTVluSDYwdjZ5L29vSk1NMUttUmlsd2pIWkJhU0JuNXBDeVBpbXNm?=
 =?utf-8?B?empNTG50VEVySGVLeGEwTWppcjlwMXNOT2lZaGNvQzJjMVgyQkhKVUE4bk1q?=
 =?utf-8?B?aTJpMVlHa3p3aFFmVStOQVFWTG43cUFOTWRJcVVaNzdLcEV6T0lmM1dYNGFH?=
 =?utf-8?B?TE5uaGlqSlc5dmJlV0VSKzNMRThKTUIrMTdYOHhPc1BOejFCN3R0ZVhFTk4r?=
 =?utf-8?B?U3hCZ1FQemJwRjBFNzdqaFRoR0JoSWZtZGdWc2k5cTVZVmpGS2JVc1dBMENZ?=
 =?utf-8?Q?ygAHXIypq1KFgcdos64nphI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b841c985-3265-484d-82a4-08d9f1e89b1d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 07:39:19.0963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT2pTqmimKvEZg6yDfAva2zDTKGfeRds/VY3Gc0Jha1cg0+l2hQgiGwk7IWrC+xG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4891
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

Am 17.02.22 um 03:46 schrieb Gu, JiaWei (Will):
> [AMD Official Use Only]
>
> Hi Christian,
>
> My same concern is that an additional parameter may affects other drivers which want to use public drm_sched_init(), and I want to reduce the scope of affection.
> Will it avoid potential compatibility issues if we keep the interface unchanged and let driver fill device pointer by itself?

No, that will just cause confusion. We keep all drivers in a single 
Linux kernel exactly to avoid stuff like that.

Regards,
Christian.

>
> And DRM_DEV_ERROR() print is fine with NULL device pointer, there's a NULL pointer check inside of it already.
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, February 16, 2022 7:17 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Chen, Horace <Horace.Chen@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: fill scheduler with device ptr
>
>
>
> Am 16.02.22 um 08:22 schrieb Jiawei Gu:
>> Now scheduler contains device ptr. Add it so scheduler printing can be
>> more reader-friendly under multiple GPU scenario.
>>
>> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 4787cb3acaed..da53983c93f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -506,6 +506,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>    		break;
>>    	}
>>    
>> +	ring->sched.dev = adev->dev;
> That should probably be a parameter to drm_sched_init() instead and I'm not sure what happens in the print when this is NULL.
>
> So make sure to update all other drivers which want to use
> drm_sched_init() as well.
>
> Regards,
> Christian.
>
>>    	r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>    			   num_hw_submission, amdgpu_job_hang_limit,
>>    			   timeout, sched_score, ring->name);

