Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48A5C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2BE10E6D6;
	Mon, 26 Sep 2022 15:14:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3EA10E460
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLY8x5T7qm0EBwxzcdFEU9uRSo59R2NfVpOhJbNp5CYGd1s7U6yUhfDgYHNusmfGdhYRlPbOgoUnTrhEVKy4kmgcx48+sPwuV+yKRD3JnHMY+Z9VIxulv34a5T/5F8vDzxZEY+GcQRHpaQQ1BnCo6KEx568ZhUlvMulKFIMcPEA6pB4horUciowYdzl1aJ4eLljaONztT5U+I+R4VdFQmzsZRepnMN2oeENmXEdIQ4Ig/rn7H+9Wrz55bbHbA2+g1PTzC4LMMuxPkqMKkeyxCUEW3sCuMBHCulYce2bRxiwUVJQwN3KTYZVr7vX4KSf4jArT0AkOcnj3k1jXvY/yGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnFRkRSCzMWzTtK4NysYybuLk4CcW3MT4IUpHdSSN+E=;
 b=h93rjYXN9dzc3kyi3swMrKQaj/X13AixFVrgS16kewkdJww3N4yyT7LYZ/4/MRNVtIpP2UPlTupsbBYNpGJTnMrBN3ZUq3aWs1HuOmLJRN6Uw1yWT+fTfl+1056ih+pBhTn2SDePB806MrUPIQTOpF7K0spoBk8cTLSJZLkoSBzHLzfzmHiYNU+PEGIoe0CNA5CyPlx85ucpwzn7HkyWZrZLSyDoHgEMJ0MdnE3ns6lhjOZ7UZF1/9ZucONQTEOIrh/l8HVQOeRLa6CprCYbYwKxnwNWyHW2JrJISZ+RAIAczDLB4PYHZdstK7aPUybloy52AD7wnZI8EF4zIcBD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnFRkRSCzMWzTtK4NysYybuLk4CcW3MT4IUpHdSSN+E=;
 b=x+elZWVyCVLomumam3aIf0kdSICPixo01ytHAbKgRfN91bU7ia1SuAa+GsbI1IBkSbC2JIgYpemxmVajV4ITHsi5ZbguXaSNZU1vQNkICvFhQrU5ClylETRf5jSxS06G1fVPZp5ol18dvRsY+UbD7vdoIurdm5ZGC238E/cKrJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:14:34 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c%9]) with mapi id 15.20.5654.024; Mon, 26 Sep 2022
 15:14:34 +0000
Message-ID: <55293735-fee0-5e81-73cb-0215bc9cc989@amd.com>
Date: Mon, 26 Sep 2022 17:14:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926150252.18635-1-shashank.sharma@amd.com>
 <20220926150252.18635-2-shashank.sharma@amd.com>
 <5e13829e-369b-80a1-5226-c3f0b62534a0@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <5e13829e-369b-80a1-5226-c3f0b62534a0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0726.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH0PR12MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 0120c4b6-d471-4398-79ac-08da9fd1d170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2qJ5uA7PFNmbjTus93+LnHFOBOFr6W8bNu8G/SdlN+MGWjRNBjTnbvLr+nuiwuR/5urwz7wQGKkGdsIkl1qhD2e9cQ5JZQqDId9PPembw+4y02bgSDB2zZXUD6c83CteqJ991GKujv5ZUrUI5M92cdQAA/thyFMtRRsAFf8s4WRNfGWo6dKcd2/Q/XAYwqE/ly1CDt32tweoNmDTujXrt7mX9XWSfua3rd3d5qqo8oLt3+OBKa8b1CTjoKcnjRqZGTjw8uQbLm8lda1PvBw7RdFD54eFpIb+xUrqhztL7uSfm5IEJVayc06qBg5Ujen263TsUItDhvckbHJUl8j5XlAdBCNcqp7TygHo6QxEfa/eCJdR8g9w0EwDwEnCKjg2/17yS8DDZSM9LGVwGIBUca7ChqtWoxG+qNxdFvbp1yHsxrEfGDqHFO2yQIEbnLGfWoAdvnfw8lWWUsYjJcS3e5KhEmRtPRH6d1X2GECoYQ+ZobxAGZosgyQZ2XCKsfn7w3kGBa0ceokRtow/yY9kKyl2baM2BTeKTkx4Hp6tpFRb5zUOkdapm1LhAgocxaDHn12eToZzYTtV+y9FmiDRXMo9PLZBvpMrBpyih6gNkjCNmXx/tUtEj1jxAHx4HkzOxpyY2kIJXAw8kN6Uzv9Kx3jLNlaJ3LEyojFJaHA2RGruXJhN8EBkGEBxmCzn1f0Bn97dQC+Ju267sKbhRtW+s5lAdbKaD+bw0/YfP+U1rieiTLor6UXahGzGKU4lmyTcnWKTRtf31Kyre9O5s2j0krTReuXdtu9Brfpkhud0Ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(66574015)(36756003)(38100700002)(8676002)(66476007)(66556008)(66946007)(4326008)(8936002)(31696002)(2906002)(5660300002)(6666004)(53546011)(6506007)(86362001)(6486002)(2616005)(41300700001)(186003)(6512007)(478600001)(316002)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFTNW95djltQTltY2xQY3hrZ2R1KzZYMU9QV01jU3JFL3N6blVPMitOc2Uy?=
 =?utf-8?B?QkptWXlmbkUyQlBNLzArTUt1MUVQa2Z5MFhlNG9VcW4wNU1QSlBtU2o3Nm9y?=
 =?utf-8?B?SXJZREg4WGIydGVmdWUwWFo3dTc4K3orWnlhZGZHTEJkZDZMaVpLU0k2RDF4?=
 =?utf-8?B?emtYNEdCeVZId1Q0NUd4YVk5ZWZrUTN6OGZMZGk3bW0xODdlcjJpcjczMFRR?=
 =?utf-8?B?T2FML2Q3Z0dCMVRnelErZG5TVmhWMVFhNFZ5L2d2WXltOEhzc216QkJhR3Vn?=
 =?utf-8?B?Vzk0WUIxb21YRnVXTWlYdFpoMmk5clB1YlR5THk4NWFwN3htYUgrdmVBRDZj?=
 =?utf-8?B?OG1maUxQTk9DMUZJeThXZ250SEVNR1BuSGo1eWoreUlrYWtQK1liNEZiVjky?=
 =?utf-8?B?UHJjZGhkcXkrRUtQbjNwUEx5VUxhTnBmQ0lRWDFzTVdSRDdSNTdnWTZoTHky?=
 =?utf-8?B?MjhNNG1DSmtiVWx0RFdWQmFxai9aM0daSXhvSWc5TzZ5dWIwbXcvY2N6WllO?=
 =?utf-8?B?dXo3SHJTV3liK04xeGUxc01McEc0NzJxZlNkc2tMRnI5UTB0VFpPTVQ1OFdE?=
 =?utf-8?B?aElQeXdvOFZudVFuL1BlemNCTk5PcVBKWkpOZy9yZ1VSMm1LSEZQbGdvdXFy?=
 =?utf-8?B?WjV2NE1va3NRTVc3R2VLdW5HOUkxZVZneDZxM2ZtYUo2R0RlOXQzT0VIMzJL?=
 =?utf-8?B?NVpFdjlKTENCaUd2M3R3eWFqU0IrbkRuZzN1QzJoclJxMmRvQ0ZvT0pRcHlK?=
 =?utf-8?B?VEtnRzZSZWJ5bUV2djd2N25CL0xmanVuemxpOGdZUjNoelVHZWZxRDVja2Fw?=
 =?utf-8?B?UzNlMkZoaHArTjFkaUhERE93bVlCNjJuWEM0NThybnRFMEQrNm1oNVNvQWJa?=
 =?utf-8?B?dnJLNmtCcERReGx2cDdLVzkxQmovdmxkdHl0cmFTUEdaTzBRNXRQYlM2ZmRp?=
 =?utf-8?B?R1M5bnZSa0ZHRlZiS0xIbmhYVUYzbm9oenFOY2ovVUlld3hHbmtDdmJST0NH?=
 =?utf-8?B?RkJrUGM3WFR1MDY4eE1pRHpILzR2QWI4VXVwRDg5MTN5OWpYUzZKUzdaT0ZD?=
 =?utf-8?B?dXBQWG9qQUtRcStYdWs2YXZIUHJRdExlY2hOanh4aFAwWDZuV3p5VnVhVlA4?=
 =?utf-8?B?OFU1b1dVVTd4bkt6SEVlaXpMSzBDUWx2blQzUzM0VWF0STMvS2E2M0o1WTla?=
 =?utf-8?B?Vlg1dFJFVmdaN0s3YzM3VXZXSytyVmJBK01KeDF3d2JENEt2d2VIZSs5aVFq?=
 =?utf-8?B?MHFuVlV0MHJ1aURaL3A3blhvbmJMSHQ4eHUvblpWd0pwdklmc1BqdThWOE1r?=
 =?utf-8?B?OURmWEhqK2NCdnY1WS9Ba3NEZkpxa1N6RU8ybGJxOUMyL08xVDcrdnN2cE1B?=
 =?utf-8?B?UlRYc1lvUEVyUjEzMGlocjZINmk2K2g1T3duek1SQk1MUEZSS1ZYSFVOTTlN?=
 =?utf-8?B?d2V5QVE1UVZuK0tyNDF0MXBZUmJud0JhcDZYVWQ0VW5EalJ2c0ZORUdOSVBq?=
 =?utf-8?B?N1FoVWJGSU81Y01RaHR4Tk5oQWd2R0ZrL0d4R2RnYzltbjVJYXI2bjVtUjRs?=
 =?utf-8?B?UTJBSHFybDhjWmJvQ0Fsby9pRlBPVzU0TkFXa0hEdHRBUkZjaUdiRCtNNU5a?=
 =?utf-8?B?azErMFR6aUR2TWZlSkZEYTlYUnNKbGl0T1VmZmZqMXpPZk5XcVduZ1hSNk4x?=
 =?utf-8?B?MmlXMTUyd2doRVhUL1U2SjQ3SWlJd2hlWmxWM2RhczFMTlQzc3ErYlgxOWQv?=
 =?utf-8?B?VFRycnBSWk5GUzUyTlZmbzFVT3UvRGpHOVBHS2s0RTJxRzZQODg1QlRTYVVy?=
 =?utf-8?B?SzU4c1dpNmdJbVdUbXcvcUx6WU9JTERpMGQxUVNORFd2WnVOcFhCL0JKclNk?=
 =?utf-8?B?UWViYVVJVkhTb3lQQnk3dUt1Z1ZjOXl4OFhkR1pIMzVRQUhRWmhRL25PSjZZ?=
 =?utf-8?B?TDcvNW1NaTFoZmVUQ0pkY0VDcTNoL012U1FBdHNQSzI1Q3ZpbFV4ZklOK1Jw?=
 =?utf-8?B?c2xMYWx3a2FrSEQ3V2hTZkVBbXViRmFPUnJXblBoU3M3TTA0Ri9HV21lbmM4?=
 =?utf-8?B?SG1qOHdza1JWcUlzclI4eER4Z3JXMTgxZElweERLNnVXOW13bUFNWlY1QUtk?=
 =?utf-8?Q?OyRDJJFNwCV89GgdAbgW/xj4G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0120c4b6-d471-4398-79ac-08da9fd1d170
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:14:33.9949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRSXavBhkRQvFYJ0kdh4j54gyAkjQg1nvcEfMNDQV18wlVJhhzu1G8+FKvjbk82BWx7fyr9KtXljWv9pZsGOoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Hello Christian,

On 9/26/2022 5:10 PM, Christian König wrote:
> Am 26.09.22 um 17:02 schrieb Shashank Sharma:
>> Allow the user to specify a workload hint to the kernel.
>> We can use these to tweak the dpm heuristics to better match
>> the workload for improved performance.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>> b/include/uapi/drm/amdgpu_drm.h
>> index c2c9c674a223..da5019a6e233 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -212,6 +212,8 @@ union drm_amdgpu_bo_list {
>>   #define AMDGPU_CTX_OP_QUERY_STATE2    4
>>   #define AMDGPU_CTX_OP_GET_STABLE_PSTATE    5
>>   #define AMDGPU_CTX_OP_SET_STABLE_PSTATE    6
>> +#define AMDGPU_CTX_OP_GET_WORKLOAD_PROFILE    7
> 
> Do we really have an use case for getting the profile or is that just 
> added for completeness?
> To be honest, there is no direct use case for a get(). We have 
self-reset in kernel to clear the profile, so this is just for the sake 
of completeness.

> At base minimum we need a test-case for both to exercise the UAPI.
> 

Agree, I have already added some test cases in libdrm/tests/amdgpu for 
my local testing, I will start publishing them once we have an agreement 
on the UAPI and kernel design.

- Shashank

> Regards,
> Christian.
> 
>> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE    8
>>   /* GPU reset status */
>>   #define AMDGPU_CTX_NO_RESET        0
>> @@ -252,6 +254,17 @@ union drm_amdgpu_bo_list {
>>   #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>>   #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>> +/* GPU workload hints, flag bits 8-15 */
>> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
>> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << 
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << 
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << 
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << 
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << 
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << 
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX       
>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
>> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)       (n >> 
>> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>> +
>>   struct drm_amdgpu_ctx_in {
>>       /** AMDGPU_CTX_OP_* */
>>       __u32    op;
>> @@ -281,6 +294,11 @@ union drm_amdgpu_ctx_out {
>>               __u32    flags;
>>               __u32    _pad;
>>           } pstate;
>> +
>> +        struct {
>> +            __u32    flags;
>> +            __u32    _pad;
>> +        } workload;
>>   };
>>   union drm_amdgpu_ctx {
> 
