Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BB9CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 14:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C2810E642;
	Wed, 10 Jun 2026 14:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpUiPBqn";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A847210E642
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 14:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIzEnh3BQVgqBflq6RDc6xdUO7a8CevesfBbf58Lgq6L/HyrDK5XQQswStB3eGpsAl/9LBqZ5kMOrkrAdKVdiYDN4amstWOE0pj0D42dCRtEjPQTMfnflHYeH5MOodWOLG/Q6PuzHrtpy+caHHAiw4cWjh80Z0UOLsi61Nw5mVqPtuFY72yAYoi6zIxZf2DaXvmI5vfI+GQYmUj8gCBsrcdQ6N7cRCWiRcOcFVyjt7Gv85xlfQSk5O09tAWsyeeszvg2LXIpm4dj0b9KU6QCW87Fwdskyb39YIXK5ZWJcBfjWgWHrO4IZbV6aCTKmrTCrt/55f2OYsXRrqqdQ4aW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWMLrJwwjyYDolrQFagdIc6jesV3C3dPqvTE7ip/3N4=;
 b=YkexaoBapAt5LMTq7eF/IBGeDYjTVy0lgF/u5+IWKaZ3T3d++UeF9ml8SXgIE8EFWH/lk65rC32sScAxYARp2A7Zhpy6+6X/ilimhbIo6I2eK5UW2/xrNj/iFmuuJa8BD6uqfy0H+1ygLNLTA5QaQJps+Emxm5QCNQZpUkux9UrEuZd0Om7AXVqL+wHwIrcAXD7jh11D3zdRkyZ4CzreGABBFAJzv+pgtiYc1NkEX5fWszjGxQ9PfefKAPwnbq7BMIF4b1JUc7anSpPJpB/NT/a2n9OVEMesthfJ/t3F9Oe0t16HNjR58W680L1dXDcv9naoj7hyqXYYc7RhSd4Yig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWMLrJwwjyYDolrQFagdIc6jesV3C3dPqvTE7ip/3N4=;
 b=YpUiPBqnkevDor52fo7/uE7wKHq4M9raNs28oHg3EyZKVMecX6ZiqAf7lNKjgRYnTV1JgepluyIdGe7qmLKPP95gAQLOGXNrjFj4scA+Gn2AygpkSScvxJ9fy+X5ovtlgRzSwyh2+7lbdf6ga1PVvxxNS+vti4/wywDEVxr0K8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 14:59:46 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 14:59:45 +0000
Message-ID: <e590b459-b865-4f8d-983a-347197e99a83@amd.com>
Date: Wed, 10 Jun 2026 09:59:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/pm: smu_v14_0_0: add DCLK and VCLK1/DCLK1
 metric handlers
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Priya Hosur <Priya.Hosur@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Kenneth.Feng@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
 <20260610120944.124040-2-Priya.Hosur@amd.com>
 <04061de3-10d3-4fa1-b166-5bcf3139037d@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <04061de3-10d3-4fa1-b166-5bcf3139037d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:610:57::19) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5983d960-9ade-4146-7361-08dec700e8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8D9VMlmHxPTNi4e2fzEpT4NUzETj3qRmKC+//zu/wYN/wjT+eT/Ln+EOsWHYpO/bnZo3+JHk7naZh9SE411XowZ395Mmx1yrJUzhNCvtw/376IFVVpwWgIDQN7rBxseNGpDFta2I31PhjR0f4yqv2P1p900Fgk9r2qJ9iPIgUQIefAGWYmBrIVPd/ZZrjO/2T52gSiMl7crc/uY2LvFBSX9GKni2SHrjWUcAAz/eomlinTp5NGHwPF1DnC4MHXNpq+67LTrwy7suNdxFHOUvMxj2U6g8qjLf4jZsWMmGsFfmlHMWuOMmlP8ARQsh0nL7AnCyG5o2GBvm5NSc8Rgctysr4kukPhd235ynGJRpTj4c+B+z3WozogdVi+uG4xatVET1Xs/fwV/KLYy/Vcj74jyOBuNAGrPGi1GachM8TzNl+AOHD+i9Ravh7Y3zFY0+L2kwnhfTqbjn6LYGPOOmLRDGFrSMYENTpj/wrGAy+vs43Ferl8Oj1e+iOn1NFBIFrz9jkP+SyOhLi1qZWpKIAybVIogc88A8IQT+WNx7gWpk1joBjebmQ4rcmYuDMFv2cXhaiM06Aif0+2TVseB1gyWkCOuvTIkVorB3EinHpri80SscGvt/tTwglcbNt/43ORz2JB1bB6QI2lPE4F88sSJo/5A8YpE21jvnHZjecTOfkpkuL8bBnKf+0z4uygNY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFRRSmZqY3pFTU80VVRzaFM5TVhURGIyMHl4bFRmeG1WaEFraTM3S09TWVVz?=
 =?utf-8?B?SmRUTnpaN0NtTk5yUmNxTUpyZlNvV29MOGw3aWkzNmZ1V2lKSkJGYmNTelY1?=
 =?utf-8?B?Rm9JNHhzM1VPcW04Q3pvb25tT0hLWTRTWnlpYytwTEI3QkJnd05WU08yMGxa?=
 =?utf-8?B?M0F1NUR0amExbGJxdkx2RVRIb0thbklCcGYvODVncWtYS2hBbDJhNEdNTGQv?=
 =?utf-8?B?YkU5WGRmYmZ2UUozbll2bmtQN0RtQVRybnplKzBJWHNsQmNDOGNpZzVNcnFy?=
 =?utf-8?B?R09zVjRPbWFQSWR0WlRGREowRFVoSlFKdHZqYmVGaTVLS3VINmVxMUNMa0Ni?=
 =?utf-8?B?a2JRVFovUWQxRDQvT3lMTXVBUkN0cWR2QTlab1pTRWZ2RWtmanJYVm1EcVZq?=
 =?utf-8?B?OGZ0QWI3dmRHL3czc2VDV0lKS0hqRFNwSGFtdkpKc1NXK0ZZR1NqQ3ExZUdB?=
 =?utf-8?B?TXpDUjByYWlrZWxQRURnSFhxYWNna3pJazViTmhWZnJwQS9zVzFyZE5FdmtP?=
 =?utf-8?B?NW4yRE9IdzZkNnV2aDZWTWpWNTV6SUdzci9yekUwcEU1azg3aTMwK3hQbnZk?=
 =?utf-8?B?a1VCRlNGMDBrYjk2clp6bzNLSWxzUTVkTG1HM2JlWU5nSVBueFpydGlxdjNI?=
 =?utf-8?B?OGMwdTUzM1ZSa2xWd1JlMEhaOWZUWE5MajhXbi9ySmpjaWoyTk5qTlhBVkhO?=
 =?utf-8?B?STA5MStNQXdLbXdTYnM5eVlCa0pLYVczNnNNSHBNNTExalJJN3dZS0wxeC9h?=
 =?utf-8?B?UERhbW1QdjBtQmhwbG5OTzZzT2czQ0tBWEhzUm5Ca3NmNkNZelF0RHJYb1JY?=
 =?utf-8?B?TnJjNWdSRTZPazQ4NGRlWVNkME1RbnVNLzVYNHlUVmJhOWtabjNSR21aTU5h?=
 =?utf-8?B?Y3JsOEdsWVkwTE03S3E3cDFjazNpbWl3eU1yUGRYZVU0MEtoN1VlNHI1b1V3?=
 =?utf-8?B?SGhBKzV2dUIvTDNCTlpMdXRNcEM1WjNZVmRTVHNndzhkWjFmY2VnOTJHczFo?=
 =?utf-8?B?REU5dm1tV1BFa2dmUGV4QlR6aHhVVXB0OVBKbXJFS3VzcEFHejFpclpxdmRn?=
 =?utf-8?B?a1pZNmlGRnQrUjlWS3RTRzg0K1lyTGpXSFZFQjNQNUtVNHVWSitKU1RyU0NZ?=
 =?utf-8?B?ek1TNXNFVVpDNEZ3QnBET29HVU9hMmthbHRBNWQ4UFBKV3pNbXk4S1pGZnpN?=
 =?utf-8?B?TlBnSGRnblFEK0xiUDdUM2FtNWU4akpEKzFqMDg4Zy85dUY3NXFxYUNBWURN?=
 =?utf-8?B?YzhSRmtqdG0vbXhTaDk5ZGJkTk9mNURTYnJWOVpuSC91eVRpVE0weWF0QUkx?=
 =?utf-8?B?WXVoc1pwRmdyS0lPRXoxRmRDK053V2t6MDRnb2ljOEtiUFdyNHorYWNENlA5?=
 =?utf-8?B?b1ZPbG8yRXBnUEVyd2FYcU9vVm12eWJYbU9RM2syenh2QUZuQ3RHYWh1NU9n?=
 =?utf-8?B?eGxiOE5KYmtZU0pJd2xIWGxIZVcxdFZITGUwUjlySjRUZjBxN3hyZ0lKMGlN?=
 =?utf-8?B?TzJkR3ptWi9PWHQ4UGkwV1RkYkR4QnNqQVFqMDQ0ZG9ESCtxcVNJKzZLc2pk?=
 =?utf-8?B?Z04rYkVES1hhb2U4ZlVnZ1hFazlhcmNYaFA0QTNnd0pNenRJcmd6aUJMY0tG?=
 =?utf-8?B?cjh4R2pYSTNCaVo2TnM5UGNkV1BhQkxzdU9RQk9rdkdKWFVEcloxN25sRDU2?=
 =?utf-8?B?Rkc3dlNscjNLNW9FN3VldFc5c0U4dnhGbTNNR2dKSkpmaDA1UGZVdTB4L1RY?=
 =?utf-8?B?NHVSdnJYOE8yTGdZR0RmVWpPcytTcjJnODl3d0hiUEJIeEVxTmlQNmtMSWY3?=
 =?utf-8?B?UWhKMHZxUzBERWpoZ2ZseWk4bi9sS051UkpTeWZUTDFQbHE2ZEgzMlczbFN3?=
 =?utf-8?B?VmpTaXFUSFdJeHhoTDFRQkJwV3pyYnhFVjNyai9uMktjd0NRR1djSEFTYkxE?=
 =?utf-8?B?WVp5YVlmZ2c4cGx3TEN2OWh6OGR5SDMwRWFhMjhrZXZiUkw2cVFLVGpiNWRI?=
 =?utf-8?B?dFNncUt5cVBzamVaVkQrRlZhcDhONU05d2d3SnRzeDI1R2psVno0OXUrdXJX?=
 =?utf-8?B?b3N0cTA5ZEdSRkpoYUxpU1BhRFd6RnJFR1lSZVBmblpNcDlWUnM1cE5WclR5?=
 =?utf-8?B?dkhZVk5HUUp2bEZSWGRuNGFmNGNZdDRnKzdmYUVWQ0JLZ0Z6WHMrc3RjT09X?=
 =?utf-8?B?SnF6c09NUnJPN0Z1bWdrYWlTTk1KQUtLZVFIbUtLcFVxYkF0K1M2UFJsTHJa?=
 =?utf-8?B?Y3JqWmtRSnVhTHp6S3FESEx6SVZRMDA0NGVKSVdWN21SalRSb1FheitkOHZH?=
 =?utf-8?Q?HtV40XrLkrG0xSRQxg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5983d960-9ade-4146-7361-08dec700e8e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:59:45.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxhnK6E0Vk+jpqzLAehuf4ZhF/cG8R5sy8N9WABQaM7dZeRm7utfhl/6PZ8vKvG/Hlo2VRYqR07bFRs15uM6LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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



On 6/10/26 08:29, Lazar, Lijo wrote:
> 
> 
> On 10-Jun-26 5:39 PM, Priya Hosur wrote:
>> Merge METRICS_AVERAGE_VCLK and METRICS_AVERAGE_DCLK into a single
>> fall-through case mapping both to VclkFrequency, since SmuMetrics_t
>> has no DclkFrequency field and DCLK tracks VCLK on VCN. Add
>> VCLK1/DCLK1 metric handlers returning 0 as the struct has no fields
>> for these, avoiding UINT_MAX default that causes N/A in amd-smi.
>>
>> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/ 
>> drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
>> index 2fe006de927a..c977681d8946 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
>> @@ -281,9 +281,13 @@ static int 
>> smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>>           *value = metrics->SocclkFrequency;
>>           break;
>>       case METRICS_AVERAGE_VCLK:
>> +    case METRICS_AVERAGE_DCLK:
>> +        /* No DclkFrequency in SmuMetrics_t; DCLK tracks VCLK on VCN */
>>           *value = metrics->VclkFrequency;
>>           break;
>> -    case METRICS_AVERAGE_DCLK:
>> +    case METRICS_AVERAGE_VCLK1:
>> +    case METRICS_AVERAGE_DCLK1:
>> +        /* No Vclk1/Dclk1 in v14.0.0 SmuMetrics_t; avoid UINT_MAX 
>> default */
> 
> These are clocks for the second VCN instance. If adding them to FW 
> metrics is not an option, then reporting the value as UINT_MAX is better 
> as that indicates N/A (not applicable/available).
> 

Do the two instances share a common clock?

> Thanks,
> Lijo>           *value = 0;
>>           break;
>>       case METRICS_AVERAGE_UCLK:
> 

