Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E376C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70A961100
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A70A961100
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D9A8958E;
	Tue,  7 Sep 2021 17:53:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430C68958E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 17:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGw4DfpTKyeldn9CROluuYpkXgBc15Q3wltXH+g0/2e/qx1QNK/CA6SR5kjBFmAycOzTz/Lpur9w3XTcKkkHaVsNcYN5CDTVsPndRnHDAl7Vgd47kMs073Ex+mCYKmR+GBANqCm+w1bC4vvL+OHwyVNSmry5XhCwEbEV5ApoXQkLn9OuVtxA89E+JHaOh6DOkFtDBMkwpcRqSULJr9oEzolJDv90YZybWBIgdcWxrM+ycEz+DUDUShNmEiCU0CHx3x7MBLVfNqJlbXRdiFG1jrgP7dA/IIMD0cO3PMRzZsajWyx+Kq2d8OCbLlk0K+a3nd1903PshRBLI0nt6Y3rzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZylYmho/NKv4quzTtgXIVyDbGdEBEmC3R6pfZ3HzkAE=;
 b=UfszqxPWEhU5aNGYNa/Z/F0THwuqep+zafqDXfNNV2wDuE6eVvQqc/ygyQFEY12o43CwIkeaEydzzlcA70r5HPR7a3/vMSmOZmDmb7pMqLctO494gdHdZm6Dv+BSKOPupT9IeO83zcLaLkGFARSGvNCLA809m+UcG2+DkZ1qo/uaZIOLkAKf1RRSJt4ukay8hs3GZq2OYZpIkmiX69ktvxcVbQRkha30cOL8am8fAi9OsxQbS4PqKUAuElap0CBEB33wz59LKHXWdsSKX54lANnonSszEI6nJerOPN37rUvDjoKhzwnLyXA6sX4aA8jmzBSFvQ2BEvdxLNI9jLKjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZylYmho/NKv4quzTtgXIVyDbGdEBEmC3R6pfZ3HzkAE=;
 b=nHi208Uk5p7QsdrUal3oYExpmtI6kRsDsnk4mbEQimwa2mwwgVOicSmIUJAkAjKXq/SuWFd65H0ZEL6eGZydGbuvB9YZp2XMq91WnTd7xZ9p+Q5OgdoXTPtmmYp9scFd/2fXFU+jSs8QUK/E8qMNqiekSFkpJeRycT5J+RQ4UWs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 17:53:43 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 17:53:43 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: move iommu_resume before ip init/resume
From: Felix Kuehling <felix.kuehling@amd.com>
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kolAflash@kolahilft.de, me@jeromec.com, alexdeucher@gmail.com,
 ted437@gmail.com
References: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
 <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
 <03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com>
 <adfed1a3-4e1d-8ead-bbf4-4c4448c0f7fe@amd.com>
 <3c196bbc-3799-44ff-d5f8-ade4ada89d93@amd.com>
Message-ID: <ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com>
Date: Tue, 7 Sep 2021 13:53:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <3c196bbc-3799-44ff-d5f8-ade4ada89d93@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::37) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 7 Sep 2021 17:53:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cd5305f-0508-403d-74d1-08d972286eed
X-MS-TrafficTypeDiagnostic: BN9PR12MB5178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5178E2E95662D7D233422BF692D39@BN9PR12MB5178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FM0G/OYgTrpxixU4YCsmktO2RPR35MKN6drIGyZtmlp9LrBCw2KIcy1iXZctqjhTMkl8e+KbAEjKPjIy1bX5drCUOXAhnfX/86qPOqZJMlORFaXVNH8tRt2lSql9bKv3V33ukne/aI5Imvg4bkBoDJ6L30SqmPpbZnM5L3MKQTVtBNe+mdIe/Hx3Wif1L4XdxzI6BT0r4XV++ioBpkatReRJzE0x4Z1yE5yDnJNl79YSSC5Krcyqn6YUzEtVGqSF8uiaBrYa4Sfjg/HILjkyaVhLjScioOCyTapSnZ6W/YaYr173VeT/+/5QEJwDC/p2nGhAUKf6kpCPdKTB6jUjwmHXat9e2YYZFg2ifscGpbpNml+6yl61F7AMW3WXXXguautHNEqU6HooT3z2/P5v4HnS3s9bpdWD7lrfaWyzvKzR6tX89LlEuTxQXjFC26vtLU5efCjGVxuXkOxdCGaL9uc9rLzlTRcOkmAGO2guJrM3lX9LtE2cxMSIsVQypElV3kW3U2d3BosxyLUva4qQFJQs8zpftaFcavQvSPidN2uClOzsJD5Nfc4ldlkYkiZ1xX1sTIQDAv0afVvPKj1Is6YnJrpCgaDr8pDnQNjO48TOxb97xThEybHCRNGyUFge63fiVTj1wN0m+W4WCqrabrw33LcQwXUcXlQQ2/sQ9jIMVb1E4jbe+lGzbr8Pl/1qalj3FNHIleqJp7GnGUKH1sQZ+7lhXKnIN20ffm/+RxmksjhjkGRlqjZCJzEZp/QVmJOSs8pwegg7OXjq2biNkEKTjYAZDd1s4erQ+hEK1dLwB4KcOECmdqt8SMuXOdH/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(8936002)(6486002)(26005)(86362001)(5660300002)(186003)(8676002)(31696002)(478600001)(956004)(2616005)(966005)(66946007)(53546011)(31686004)(2906002)(316002)(16576012)(36756003)(38100700002)(4326008)(66476007)(66556008)(110136005)(44832011)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhHYmlKNzJ2VHIyYTZneVV2d3REVnRaVldQMTVMdU05OE0xS1lvcmlKM0lm?=
 =?utf-8?B?dE5FWkhwaC8zQkUreVQxNzhWYTdGR0dZZ3BCM1cyak9lQ0p4ekh0b2k5UU52?=
 =?utf-8?B?M09FMkU2Um9TTU9LeXhMVEFETjNscEo0NFQxYU1NM2xaWlZBcFQ5SjFEeHZw?=
 =?utf-8?B?RVEyRDRzVjZLVkpBenU5bEcyRUdKV05tVG5saVBKREQ2RHg1T1k2YThNUEhj?=
 =?utf-8?B?VEV2SmtlSElmY0t0V01jVHpURWFKMThmeFZTejF3a0FYUWxDSys5clFSZWxB?=
 =?utf-8?B?dW5WM21lck5DU1BOaGhBR0JqNnZVYnFEK3dNMjJZQ2NoZmZYVUxqQlpIWGti?=
 =?utf-8?B?TExxam12N05BTFJkMDFXN3hsUklYTHkycHBhYjEyVkk3NlJ0V3ZzdERJT3cy?=
 =?utf-8?B?VXpIMnJMbFpQNDl6QW9HRnAvYmVsWjVKWS91ZENETnhEaXcvbHVPaWs5ZkFI?=
 =?utf-8?B?VGpUTkpLTHphSnorZ0NxWmc1WUppTE9NdTZIeXRiTGtGdFZ1K0pxTDlJZ01q?=
 =?utf-8?B?cFBMcTRqSmFLNEROd0FQV2ZqaEREVDVNZUJOQUYwTW5xa01GVHFEY1hBY2tq?=
 =?utf-8?B?MTZLMVlGM041eTJyUWhoclRHVUVEdUx2L0RsSnZ4OUxBT0tsdEw0NjhqNE5K?=
 =?utf-8?B?NnArL3ljN1IxQ09MeURFNk9EamNWeWNuZTBBUG9HRkp6RHdUcnlxMEF2djh1?=
 =?utf-8?B?UTBQMXB5NVBOSll3N1ZsR3NRYUxrR3VWTFlpdHp2N1p5WnBFcXlYMXczOUVJ?=
 =?utf-8?B?akZlZjlmU1o3MHB2RVhSaGtuem1pV2J6OTVrQ0p6eFNuNlkzM3BLY1JpUERG?=
 =?utf-8?B?Z0wxaTViaUhQdDJEdWQ4d2NtaHNiWGc0NEVTM3dDWHhiaTc0MGtzMGlNSGlJ?=
 =?utf-8?B?bHhORHFnY0hCS0dTd2treUdSbHFqS2RXeWZBVjJOSmJFUE1UazhmYzhMOFhs?=
 =?utf-8?B?dFpZQnJVQ0hzdURPd3lVam9iVXBzL0xzZWR3cENySWt3TVFTYXVEa29mS0VX?=
 =?utf-8?B?UUZ6QXdyR2M2a2UyYTNTaDdJZmVKTWhRQUYzdXlhdVNmY3QydVNzM3d2Q0Vz?=
 =?utf-8?B?Q3NvMFhwV0dzc2YvZkxWOXFSSGV5RmZ5WFBqZG0wTEtxZkhoUURzQUZueWhv?=
 =?utf-8?B?RkpiV2F2NFZHSnBJTkdvSXIyYnBVRllNY2pvTzZLZUpTanNKUmhXUDZTZlNI?=
 =?utf-8?B?ZDBobmgrdDZheTJTcUdYN3pSbnQ5dmthOGtWWHRtRTN3RldHV3dCQ2diYTJq?=
 =?utf-8?B?ZEtrVUpCSFpFNGRuQ1JNYU16QWhLM3lNQWI4bFZRUU5OYmI1SWZIWHUrOWo1?=
 =?utf-8?B?ZWU4RjdhSkQvRytJZUpud3ZRbVVyREg4d3llOEZSZncrVytmYS8yS3o3ZDFC?=
 =?utf-8?B?OTE4cm03cExLUTVWZSt4Qy9Mb3JkRmZvcmtUZkltcTVSSE9YeWdmWlV3MUhk?=
 =?utf-8?B?REFqRWtDNFVHRzBxSFF1bENaS1JWaEliZlRYNVoyM2syeVJ6NzlsaUk5UlIx?=
 =?utf-8?B?cHE1K1k4elNoNHljWXgxL1ZCTkNDY2FLRllXaVBqQzh5a2hSR1MxOWIwOG1z?=
 =?utf-8?B?ektnbVh1UnJ1ejdoYlQ0bkR6c2hlNzMvV2xGR2xXSmtOQm0xUVlncDNlaG0x?=
 =?utf-8?B?R24yc09ibmJGZHlxRDRWRXZibm1xblNzcnVkRGFKckFJQkI0NXZDOEdLT3BN?=
 =?utf-8?B?TFIwRUNkVGFjSVplanZ4YXQ3eUMxb3NDbjBzQXVvNjE0aGlSNmV4TlFMVmQ4?=
 =?utf-8?Q?e3MoSRWjaDMOZYzQc7sHCCudlTLfLaF3jJ3bPjG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd5305f-0508-403d-74d1-08d972286eed
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 17:53:43.5935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JdIVwQinQbFoEHIkqTiBSiViuJwUGqud7AAtYaqNedTtsIzZStVGdS17E538pMx1suK6mypGdibInbMlzSFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
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

Am 2021-09-07 um 1:51 p.m. schrieb Felix Kuehling:
> Am 2021-09-07 um 1:22 p.m. schrieb James Zhu:
>> On 2021-09-07 12:48 p.m., Felix Kuehling wrote:
>>> Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
>>>> Separate iommu_resume from kfd_resume, and move it before
>>>> other amdgpu ip init/resume.
>>>>
>>>> Fixed Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211277
>>> I think the change is OK. But I don't understand how the IOMMUv2
>>> initialization sequence could affect a crash in DM. The display should
>>> not depend on IOMMUv2 at all. What am I missing?
>> [JZ] It is a weird issue. disable VCN IP block or disable gpu_off
>> feature, or set pci=noats, all
>>
>> can fix DM crash. Also the issue occurred quite random, some time
>> after few suspend/resume cycle,
>>
>> some times after few hundreds S/R cycles. the maximum that I saw is
>> 2422 S/R cycles.
>>
>> But every time DM crash, I can see one or two iommu errors ahead:
>>
>> *AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=****
>> flags=0x0070]*
> This error is not from IOMMUv2 doing GVA to GPA translations. It's from
> IOMMUv1 doing GPA to SPA translation. This error points to an invalid
> physical (GVA) address being used by the GPU to access random system

Oops: s/GVA/GPA


> memory it shouldn't be accessing (because there is no valid DMA mapping).
>
> On AMD systems, IOMMUv1 tends to be in pass-through mode when IOMMUv2 is
> enabled. It's possible that the earlier initialization of IOMMUv2 hides
> the problem by putting the IOMMU into passthrough mode. I don't think
> this patch series is a valid solution.
>
> You can probably fix the problem with this kernel boot parameter: iommu=pt
>
> And you can probably reproduce it even with this patch series if instead
> you add: iommu=nopt amd_iommu=force_isolation
>
> Regards,
>   Felix
>
>
>> Since we can't stop HW/FW/SW right the way after IO page fault
>> detected, so I can't tell which part try to access
>> system memory through IOMMU.
>>
>> But after moving IOMMU device init before other amdgpu IP init/resume,
>> the DM crash /IOMMU page fault issues are gone.
>>
>> Those patches can't directly explain why the issue fixed, but this new
>> sequence makes more sense to me.
>>
>> Can I have you RB on those patches?
>>
>> Thanks!
>> James
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 653bd8f..e3f0308 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>  	if (r)
>>>>  		goto init_failed;
>>>>  
>>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>>> +	if (r)
>>>> +		goto init_failed;
>>>> +
>>>>  	r = amdgpu_device_ip_hw_init_phase1(adev);
>>>>  	if (r)
>>>>  		goto init_failed;
>>>> @@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>>>>  {
>>>>  	int r;
>>>>  
>>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>>> +	if (r)
>>>> +		return r;
>>>> +
>>>>  	r = amdgpu_device_ip_resume_phase1(adev);
>>>>  	if (r)
>>>>  		return r;
>>>> @@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>  				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>>>  			} else {
>>>>  				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>>> +				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
>>>> +				if (r)
>>>> +					goto out;
>>>> +
>>>>  				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>>>  				if (r)
>>>>  					goto out;
