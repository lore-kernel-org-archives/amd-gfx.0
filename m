Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D39EE14D8
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 04:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6021F10E755;
	Thu,  7 Sep 2023 04:12:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4E310E755
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 04:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZC2mqHV/KbzanMUrqeYEg/qhprGxITUIcSjXB59MEdPAPbE2WJ27mQt3DVjansWRaMd+qQ6draIQil6zQOuNdiC6d6YVM8GLSn9B61AmmE1TQi5kXSiNkgP8wp0nqFFb8sFdoE1bL0p9nq0EsbV4u3TK5ioOEvOeTz+CyWs/8y9+o5bcIq1H5lPv9fc6otZtFFAfP07ZkRGKs5ehAdhcV7dEb3YI6/5+wg7Qm08YV7q//wkHwYaj1H7i8uxy+4bG3k2KxBn/nYNiRT0pEIgtoBOCqRMhkw5REs1tfmd42wcjEilfOMpBRyQ9wk8ncWAQMCY/3ZtpBV67oj6Ng4+wHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfqZIrQg6eBjusEgtY1mpxktdquFuyv0H1ML7qzyRrI=;
 b=GN6oHSivrvE0anUS6fEdUROAwXbzD6ergvXwxnVwPcJkC03FyaZ6ORYuy2bgrAEvwpJYpRIwIhdWt/pBA38qQ5kNSsSat43Lp1H+2Wtq82h3b41ygDEuo/aQiN3fotYXMYZ+kO6hc+BPSdD7o19BHmb5C0N6MPVY/rY6CYFnthEMns+RHbYC/+f0y6idiwTqXY908eXT8nPyOJbX6uggYR9cBqgHNo91/kSoVIcVtdW0uuDt6XU3ARD+WiKsuHyMDhBqEAH2NZgs8zAqlEuq/h3J4lcrEjP/JuFIQTbc2AYgbwv4qWC5tTZ88jhuxPaBKoB4zV0oXRlhH2deXdn6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfqZIrQg6eBjusEgtY1mpxktdquFuyv0H1ML7qzyRrI=;
 b=BREFJWM6GrDUy0aGhcFadsI5kklQewes2S9+0Rkyrq/Bj3MPWrcfpZN8EUJ8WynBbjG5d1i6mDWf4AhMG0nYaPQZ87HcWJpEE6CRN66zlNRtlDnvEfHzIu8vZxDny14vmzXri1+qDk7AvQR5xkhnBVtfWFCuJekBgNTRLcRa7OA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 04:12:09 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 04:12:09 +0000
Message-ID: <dc537299-be0e-492f-0e09-7241a80f7769@amd.com>
Date: Thu, 7 Sep 2023 09:41:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Fix refclk reporting for SMU v13.0.6
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230906035647.952389-1-lijo.lazar@amd.com>
 <CADnq5_P0bXrSOOs=UBLA9pasWnL=R8jeusScy3j5qHhE-fvs6A@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_P0bXrSOOs=UBLA9pasWnL=R8jeusScy3j5qHhE-fvs6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 7757b837-0285-4cef-f310-08dbaf589a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnVmvpuhK3xfJX4T19KR+fc/gnNtnUCy+A5obi1zWhSBOLQ/QGIQxw022uIyC166uq2XB1niTvfBekNX5O9flYQYskHz/NWKmnFMxnQyENK1jsgPi6TcAyg/mDy1OHqqxxqGmm2b8L+7cenf8dqAdpT0Ln+dlxoFtETBIDo908fTiAWM/k/48BFHmgClLAgRsidT+wewGUY7WKp6WNirxSpnsJtE6Qz3BfxtWd23EJk3hRJDk3uc7Yz7E2ApjLH9fZhH1jven+1lpDBjsdtYLY8U9L6sjfao5FatjgQDK75mFc13IIIdM8NaaO4tLjNWGFtrESGiDFkR50JTx3UVnH6L49HMF2oBJamTc4VFyavc/1D/2kjEnqisfoVzRAtnhh81tYsZkTSadA3QR/k6YXUwslmYvk6QqXvZattCb9aGA5WalneztmUE8Ahw4GqLpvTWKDxMM8UzueEVAFM6iTfXuuAiYPjuA6EQGZKzro7M/v2/vOyC1rsmeaHsGDvj1vErNwqG5L6Cun8rrcj8jqjxIzCq8mq9teun8UhcBaTUmdIag+ho17z6YBZnrf5e+TcerMOMTylsr8Y/sPAXX2jQkgO118JSUB/Zcbxi29jTcKcEoQ354PqHEhYAiI9dCrlVKvH+XP5B4dmAlQWqUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199024)(186009)(1800799009)(38100700002)(36756003)(83380400001)(2906002)(53546011)(316002)(6916009)(66476007)(66946007)(66556008)(6666004)(6486002)(6506007)(6512007)(41300700001)(8936002)(31696002)(86362001)(478600001)(31686004)(8676002)(4326008)(26005)(2616005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtIVC9HN2xUa09RazgrTVQwS0lDVmpzMHZYeDd1NjhKK25ONEhOcWdxOFMz?=
 =?utf-8?B?dHZ6dzA3cDVoNml6UFVuVzdPbm1iUGMycldQVkdkUFhvRjd1Si9CZUN4NnE4?=
 =?utf-8?B?d1hDWUhTUk16UElKMThBd09nSS9US3JHRWlkRHdPY3dsQXBxeXlrQnRKb0l3?=
 =?utf-8?B?Wi9LUGJpQXovckQ0eFVUSU5ONTZ6NndnbE5jUmFFT3VJYy9wZ1JwUWhYdzFj?=
 =?utf-8?B?YkU1N1gzbURLTVNFMXU0Ly9kUHZjTWl6MnBmQzhockFlMlJqbkpKWlhWaUVq?=
 =?utf-8?B?SmNQZGVMUHcrLzRIaXR0cnpKN0YreHpCNjcyRGttZmMxRnRVS0lmS2IyVjIx?=
 =?utf-8?B?eDhrai8vWHdqdmQxaXVCNVgxLzNESkUyaGlRdjJ0aEpnVG9jMGEyS1dLSWFr?=
 =?utf-8?B?eDM3N2xTMkJndWZTWWhrUTAwc3cyOTBKR0xkY0pydVV6V3kwZ243ZzRPd2RP?=
 =?utf-8?B?Ymhwd3ArcXhnT0hyWThDVGJmd1BxdGJQV3NPMVI3MVQzMFJPY0t2czBXcG1i?=
 =?utf-8?B?ZndRTlI2R1hmMmpKSENXV2RCeFhORkozWk5RelFHVngvN3IxclI5dkdCTXVN?=
 =?utf-8?B?YUVTbG8yWHZ2NjF5TmRKV21Tei9zN0tnTGdiOE44UTF4Ni9LL0cvcFNkVHVK?=
 =?utf-8?B?Q3NWQ01ScjQ3dC9XWldVaU14ejllbVNmamNjWkFkd1RpR2dmNURNcE9xZm53?=
 =?utf-8?B?TUtmUVhydHZKRkVtOHlMc3NoQXg3ZXZ3TlVRYytaL3RERWZ0Z3RQNVVJWERJ?=
 =?utf-8?B?Mi8xdnpJRWlmNTU5eDl6RnMvL1NyVldvV3NYWW9aNHdiSDVvTHJ1QkZENkZn?=
 =?utf-8?B?UUlYcXRQZEFuQ2xQMFFxNkpGQUdFMkpNMTVTMURwVWdWSnlpbDcwRWY2ZXBv?=
 =?utf-8?B?Mks0RnZRTEpldllweFYra0R0L1BqQXdFSFRsSnZYQUhTN2dnY212VWFZTEVn?=
 =?utf-8?B?N1lQRW1ZOU40aGZBWGgvQnIvL2dzN3lWUllHaEU5cE0xWnl1am1qVWVBWmEx?=
 =?utf-8?B?UFNtTmIyVUQ0OS95Sy8wNmR1R1pnY3NTU2d3N1J5WExoMjRUd2syNHljdlV2?=
 =?utf-8?B?aGI0Yk8xN0hib2J5YW1MQnNQQmxjWVJGUjl6NUV3b1lBdGg2M2VQRGFHeEE2?=
 =?utf-8?B?YUltMGRpVXlNWVRwd0wvS3B6NW1RZ1NvblBSRWtPRWYyOEdzTFU3NHZNelRQ?=
 =?utf-8?B?dWRuZDM0WmlPc1oxa0dueW11a2IyNks1M3ZzcmVidXl6ZFhiZ1M4eXdLZ0Rz?=
 =?utf-8?B?OHFLVmM4NHFqbE1CRmlQTGhxZXlSQ2pmcDRSeXVaYm94Q2pHM2ZWZm1wQnhL?=
 =?utf-8?B?YjNKUm1uVzREdjFmZ0JDT0N3WExiREg2ZlQ0ZU41Y0hGMzdCWE4ydkRCRlVY?=
 =?utf-8?B?bk4zKzV5N2RxWWcyNTZyYjRoKzRxTVR4MitFOUVCNmxWbXBuTnNhay82NW01?=
 =?utf-8?B?TTVEbHNMTGcxbGRUdXp6bHp3RkhNaDVMNHB6RHhFVGNLdnJHOXMxV3lRMGw5?=
 =?utf-8?B?aU5WekkrRUdGM0g1ZUNISmNMemwwcHkrWGNiOUdzTnl5SlpXdml3NUNSS3d6?=
 =?utf-8?B?aEliZEx6dk00VDROWkVqKzBiakRiakZJQ240bVYwWlE0dGNOdmFLN1QxU01Y?=
 =?utf-8?B?STBzd0dUWjVpWHVicjF2S0c3VjdBQ1BLQUFvdGpuTUxBcnJhN3h4OFdWMWhy?=
 =?utf-8?B?N1IvcTZ4UUdHWHN2c3g1V2RHWXRGRWg4dWt4b3FzYjJPUTQ4UkZ2MU1oWVpu?=
 =?utf-8?B?eFZwTWR5TGhURlJNVFdQOFE0am1XYjRYY0tOQ3JjK1VFUG9QUGI5MUJwcjVR?=
 =?utf-8?B?L2ExTnN1VndvZHlZN0YwMVAzWERTbERBYktmSEg3cHIvcFVOS012ZzRscWFY?=
 =?utf-8?B?dzhITXRPQ2IzZmkyY3ZVb2I4MVQ4bjJETmx1cnRuRWlDL0YxbDJLaTR1SnNF?=
 =?utf-8?B?V2l0MVpZV2E2ZzlERGRkVTBqdkRMeURLYVZQN0tOQUlFRzlMSzZpdHJmOWtZ?=
 =?utf-8?B?Y2tpcjcyYUwxejJIRzlPQ29kbWJpNEt3ekV5RXJXMkR1OEJ5TytqY1l6Ymhv?=
 =?utf-8?B?eCtRcUNYWkNlU3A1ZGFnbTA4V2FxQi96OEtOL1hBc0lBb21ueGlJVzFtNjVX?=
 =?utf-8?Q?nRBqBkVMZXIefSCzEoRuAXVZ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7757b837-0285-4cef-f310-08dbaf589a25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 04:12:08.5546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiQKiY052wA6CrObAKytRFfYBa4aPvX74wKgkp4hc4luzJMgrwAmG+t0jJHMJuNi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
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



On 9/6/2023 8:53 PM, Alex Deucher wrote:
> On Wed, Sep 6, 2023 at 12:05 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> SMU v13.0.6 SOCs have 100MHz reference clock.
>>
> 
> Do we want to use the vbios value on boards that have a vbios?  If
> it's the same on all variants, then this is probably fine as is.
> 

Yes, it's the same for all variants.

Thanks,
Lijo

> Alex
> 
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index f5be40d7ba36..28094cd7d9c2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -325,7 +325,8 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
>>          u32 reference_clock = adev->clock.spll.reference_freq;
>>
>>          if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 0) ||
>> -           adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 1))
>> +           adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 1) ||
>> +           adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 6))
>>                  return 10000;
>>          if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(10, 0, 0) ||
>>              adev->ip_versions[MP1_HWIP][0] == IP_VERSION(10, 0, 1))
>> --
>> 2.25.1
>>
