Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5FBC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 09:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1537B10E472;
	Tue, 28 Nov 2023 09:49:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370B510E472
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 09:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVOnbtzwU8dce9TnCQy75fGkHGe5SmVUnqn3dI60P2J28vf5wFABm2UPc2SaiBaceMa//UTGWmMSCDRobrnlwp6GPaHJs5BBbLWDCQNo4VJPDY1WhcrEwpJKtPIUKpZPJ8bKAhnFvCqgvItnLzcKwuQDre3r0N97M8tNsbO4U+j2/gvY8VxDX5XG2uWhmPQSEAQ93iKaqA0910bBTaimK7Ti0Sd5FaWG4adCWykG+emH+Lf7WRCF9VOr7jac6V42Pv3kabh8FrmCj8r+ty35/fxu1awKixMegR8NUc7b67Yt9w2A7modiMJDM1+YDjTyWq5tG8ScTRMhcEM1xYLWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLVwJXnRCSLy5BFWVSgmkWEs3zs41+dtI9tqjeNwkoE=;
 b=DvqN3vXFIFOb/5byvHW5oq5Y0DHNyo13HNTWLlgOWnrXcnfrO/6kyxWRyeAbotdPchE9qR5oulMlYntomPkI0bqE+I4VnCwoKe/WFo5sqBmXKBw2EfnV3KO5hxQdb4+iEJERqlf5gNL1F+f/VV573nlkhI+HWzasX1kPKCCBKiQNswZWnw5ySsYcmF/MFqEVpQ47ArWa2LvJFZ3I/WTWCZ738z366cDJbISczpwqtXolv5TEZHzqO8WL+pYppJA99ZS4u0PIp12JbJA+U4SPPHDSCO7Fg5tbuJMNet4RvRmNc8kCwvOuh6bdvot1uT85N55MywM6ZglBO+dWub5HNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLVwJXnRCSLy5BFWVSgmkWEs3zs41+dtI9tqjeNwkoE=;
 b=4EWURsUtGkgnqG0ok6SSw0SBOE3EkEF+1ppyMaY6cBpgsmLb2UsySgtPcbzogSncx/qlF+aVYcOdRlsDwmDIhJMs97xxud5iQS3EIvS7nWqwANFVKaYp7bobTkTyw6Ro9+kuU87fWAMo3QOOrGT7h0zPryNDx4irU9ufPXGztIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 09:49:14 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 09:49:14 +0000
Message-ID: <a61886fc-358c-4f89-961d-8145f70d31ee@amd.com>
Date: Tue, 28 Nov 2023 15:19:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix uninitialized return value
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20231127182945.1109556-1-lijo.lazar@amd.com>
 <ac4bc87d-7ae1-45d3-8f85-0e294289ad3a@gmail.com>
 <CADnq5_NA0fi8cGvrSzCtmtsWpgKhaG4O8T6cW+ObJoCm=iwzSQ@mail.gmail.com>
 <1c1877d8-c062-4648-950b-4e05f568b356@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1c1877d8-c062-4648-950b-4e05f568b356@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a2f2ea-1a7a-4e3e-b4b6-08dbeff747ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6/f0zGXrBqiF/wIpMGE66leFzayB8ozOUcOUUumMYDfDRuQlwcNzF/VeAqmV0wZRL8J2230G4uRiRhNcO5wz+SIFj4tBMooHOQow3i+Ptrhm6lDZ/+yvKDXXJ4I7u34DLYTUJrdu5fCmFBQD0M+CHk1dKIGZDvb9sC4EbJ3Jq1zVQ486syrgL7GbWmvPWu5c2nfexQcQbogN7ZJg4JD2wwhAJPmruZDPlDj7t56NWxKdVUAvonY+V0gWaWU6OvqICkc3BMF5PFJYwb+m94UoJZfemizalOOWmUbInZtrF6WYNKpiLHq7ockbV1UD4UQCOxMHy8r9ldDbJrrNqcAhBaw+b7N0s7Ullqw8kV4CbNutZubEZrxtoQ3jnAI6IGEtuCzSzZIDNGlXdKjfUWbwCl0ALGUDOuMxRp27HnPtXnZzyYVqqJG7l5nCJE9hLFH5Jo8KZTfC14fRwXo/6/tS0LWzSNRX8JcX8XFt9ZtRlU6uLhOnu1loI8Z36rRsIYbva7EAZJP8RQqO614laa0qlnCRRXlTbslAgchURWLmikzM+EL1sPwNQmmEMAtca5vaLJaen1BO2Py5bnLZDLc8a6RThaq+n+blBR4RFifxw01Y0BzjYp7efgu/sACBtWTPwslBuA7WMLUM0BZ3ZAVvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(2906002)(41300700001)(31686004)(8936002)(8676002)(26005)(66574015)(66476007)(66556008)(316002)(110136005)(66946007)(6512007)(53546011)(5660300002)(2616005)(6666004)(6506007)(83380400001)(86362001)(31696002)(38100700002)(6486002)(478600001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2FkTmJIYUwwYlFSWWlILzVJemgxY3l2M0lXR29qVlNCTXNMajg0S0d1aVZw?=
 =?utf-8?B?KzhsUlk2ODQwSzE5ZUhLMUZlYUFrby9LaTlxamVlZG01MXRheDBncGFncXRw?=
 =?utf-8?B?WkZOWHVEcktHclNJTjVTSzJhMmwwQ2FoTkRsRHdFcHl1ZENTQm82MTN4Nm9J?=
 =?utf-8?B?cHlMaVBqMm4vcE1JYS8rOEx1djI0OUZ4dVhNUmZTeU0wRHpmZm9pYzBrRk53?=
 =?utf-8?B?T1k4WGQ5VFJrRDcvUUpZOEEyYzB3TlVlZ0pqUDdvV3VkVVhJbGp5RjN3Q2lk?=
 =?utf-8?B?WFN2WDRjVUtNdmR0SitXb3oxbkZDOXVtalQ2UWdNS0k5cnpNWTBySWZMaVJ1?=
 =?utf-8?B?ZXYrUkNqcG9VU0NTZ0hiRHlrNitycVEvTjd4ZW1RVnNabEx5Ym8xNE02blo0?=
 =?utf-8?B?bU42VlFwSVNUUWgyOWtMNFkvejByaVg0Ky8rMHYzKzllSnBTcVhjVjlsNGhp?=
 =?utf-8?B?eHdYZjdPWDZJK25NTWRSVFhQNkZ2QUplREhFUU0xcnYzZ0NJTVQ5d2o4NlZX?=
 =?utf-8?B?Z3B5Tk44V2gyS0todlJmYjJHcWZzUEF6WjR1L3FGQnlwdTRyMzViY0VtWGxr?=
 =?utf-8?B?QTZZS0ZPUmFvUnBnTFBkdlBvT0hCNWhpUUJZL3FzczdEZjFVRkN3QkpCTFpZ?=
 =?utf-8?B?RlRwRFcxaTF4WTFER211ZlRGelVEL3JSMlhhTlVBYzd5YXM2TGdVVDIrbDRl?=
 =?utf-8?B?eTBkM213TElNOGl2M3hFUDg0ZGlsQU1WUlh5cjk1VzZlZUpkcmtmZENZNmZ4?=
 =?utf-8?B?RlVhVmtQRW9abnpybXdWSzRra0RRb0JvREVIbk1LcUwrR2N3MjRyR2trMlZz?=
 =?utf-8?B?NnZDZllnbXVkdEF2bGJXQjJiUytnMG9Zam16aGwzR3NoRHpoY2JFNU1ld29S?=
 =?utf-8?B?WXpoY0MvOFg5TzdFQnY4bW1MMFFuaytXeXV4amUvUGwrSW0wS1d1ak43OWRp?=
 =?utf-8?B?UlhkOFdkazZ6MTlxckw0QmxhVjRjK2tVMkRoWGtHUEg2a1VHY2RPTXM4RW0r?=
 =?utf-8?B?enJ2VlZOenRNWjBXR1ZvOXN5aFN2cy8zeUhlaUEwK3lMdHpObi9zbFBPZnZF?=
 =?utf-8?B?Q1JQblQ2UWJtU0tNcU82emRMbVZ0UHp3SGpoK2E4UGVYMG9TWm0xR1gwMEt1?=
 =?utf-8?B?MElOSkFjclR6Y2swU1kzdzc3UklUQk4wcW1CUnR0SE1CcnRIRFBNMStqazVx?=
 =?utf-8?B?RTdaWWFBUHNYZjBYOG9BMnZURHV0RjlOL1dSamxwVDhVOWJqN1JCTkJJZ1RU?=
 =?utf-8?B?MkRhQWNDM3d3KzlxYmZnSEw3VUMwMVFZWjI1MFkrOVpBN1JUbnJQdWI0VG56?=
 =?utf-8?B?eXR6eldxN3AxUlcyNGNDQVN2YkJUN0xBTFl5MDBpYTJXSEFab0FreGdmNHhS?=
 =?utf-8?B?cmpjUEYyb1B5eXpHelczZkFzU0JNY3JySk8vMkxGZWJTTEZLeUdJNzZwSC84?=
 =?utf-8?B?TDdRbnh6UVFFWjN5MXFmOFdiUTZjd1J3R1FBd3gydGc3RDJLYWVDbExYcWFI?=
 =?utf-8?B?SU1kQUg3Uk5jK25ocVRnaDNyREswTStLOHhCNWRMaHlyNjBMZHJpaUdYRmdk?=
 =?utf-8?B?S0t5ZEszcWo3UkhHMTFrdldwdE5pcG1hWk5mcy9UN1VaWk43TGJlK3cxVFNa?=
 =?utf-8?B?NjBQZVZTM0RnQnVwNEVsY0JEWE5jSXkvc0xJTzZLYkcwdnkyVFc4MVFIZ3ZD?=
 =?utf-8?B?Q2tUbEZXUWRqd3Rrc3A2YkxDUkUwL0FUbGxweWx5elJsMjJuc1Z2cUxpeXZi?=
 =?utf-8?B?TmhaajlESjArSWkvcUQwRFVIaXlGRnhIUkx3blhQU0E3ZkZoMzJ3MVNXeGxT?=
 =?utf-8?B?QlhsV1h1UzZFRmpIVkdzalg0Z3NVcUt2ZjVXZExmT1VjdFRjV2pFUTJsWUVq?=
 =?utf-8?B?V050YVpCSWVzRGJXdjZJeWxadlRGdW9qSjF5ZGZ4WTJpcDdrc25CL2dHaWxC?=
 =?utf-8?B?Vy9HY0c1dDQ4TEp6M2FzTUVFWEZES3BZU2RaZGF1MGkxZHJPa05KRHpBeVIr?=
 =?utf-8?B?d1ZORUwwR1VtRTByUEhvV0JCTXk4Ky81azRKMGRuRE9WVE5CM24xS3RWSnlE?=
 =?utf-8?B?cndZUWUwbFZLMjhNM2cxRzc1VDJkV3l2Ri9yZmVSV0R3NGZTNGNPWmFQZFoz?=
 =?utf-8?Q?ceNyx9UE6DcPF1eYYEP26/HNl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a2f2ea-1a7a-4e3e-b4b6-08dbeff747ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 09:49:14.6895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8y0QrHpEk9Kg3qDIfO1wxUOTvn1RfuEb9vjl4FC2ydCzc8r8tENsPPWF3O3qBw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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


On 11/28/2023 3:07 PM, Christian König wrote:
> Am 27.11.23 um 22:55 schrieb Alex Deucher:
>> On Mon, Nov 27, 2023 at 2:22 PM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 27.11.23 um 19:29 schrieb Lijo Lazar:
>>>> The return value is uniinitialized if ras context is NULL.
>>>>
>>>> Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to ras)
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> index 1a8668a63e67..f6b47ebce9d6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>> @@ -3410,7 +3410,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device 
>>>> *adev)
>>>>    int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, 
>>>> bool enable)
>>>>    {
>>>>        struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>> -     int ret;
>>>> +     int ret = 0;
>>> That's usually considered very bad coding style and complained about by
>>> automated checkers.
>>>
>>> Instead explicitly set the return value in the code paths not actually
>>> setting it.
>> In this case, the function is so short, I think it makes things less
>> readable to do that.
>
> Yeah, indeed but that doesn't help us with the coding style checkers.

Are these checkers for real? I see many instances of variable 
initialization including in core kernel code (ex: workqueue) code.

Thanks

Lijo

>
> We could do something like this instead:
>
> if (!con)
>     return 0;
>
> ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
> ...
>
> Regards,
> Christian.
>
>>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>> Regards,
>>> Christian.
>>>
>>>>        if (con) {
>>>>                ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
>
