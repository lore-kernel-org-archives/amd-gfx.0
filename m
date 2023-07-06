Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4F5EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DDC10E481;
	Thu,  6 Jul 2023 18:30:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F4710E481
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD0tgEbZWV1ksQWWGovHXo2dmc3x8F6HvIMwRGM8++rMwaU3Oj8/TujzRI/eQLsfzO6ix8bqsR8WUNIx0A5ySGnBl6czUjjh7HtkF2Xq7aKv+kI+zBji1H5b0WyJdnizuoa3+PUDm9hUBfW6xEgMPcI5DlfUZc8s1LuL2UG5ewvAeIjQv3OcyI7cEyACn4kIgY4jqAVhfNtD9/pX+xpqvJtharqsyaBE1/XczBA8FVUN+tV9PTuYPWLfcrHBK+JXvRu+y2AK/1DA6k6uQk8iPL91yUFVqrRWS6b1+Rn4Q1U6JTNy47ZUPzsPEs37C5BrTJrUxW+3tlPaNljjWU+TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmKyGB6mRfr+pWZ2gTbp9pnCj8NDEN6/Gn1wqaWgoPQ=;
 b=Ay96H8Bwv8FBzpRZnyY0pbyvfK1I1lAkxBIg6x7Js8hvm5Y63s055fREDNL7HgOrLDxOtHwreOB/uDHnHAb+PQyyvtwM0ema88RMg44ZRytOazhSyo+3gn9ZbVL9R9zj6vIMOgxcZ149d9wWk9C0z0GLcE5odp17HKy6Tc7lE58GXkEncegIPPv1JKT5lrkdjlGUi6Gq3sGHI/2iQawzMVYe52pFsL83ZWyaUhwNUUPiorAqb2ByJbKLTP1qzHyLT5Km6j5Xua20PnaqVezML+1BvmEFN2yQ6mQC5r8LlRf39rGegWy+oh4+Bay6u5YvG/23JIHZIofHQD9LZ56axw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmKyGB6mRfr+pWZ2gTbp9pnCj8NDEN6/Gn1wqaWgoPQ=;
 b=bkZfIbMr9RAfOS7F2+h/6E48TZH7kChcjTK4ug5kD+5t7wOnLEnrZkTYw6wFmJ+rRewn42I+KksIvG6k1Tvw9yr2JTPnIeRujlqzay25I7p7o+L3u0VA1kv8rOJGJwd6TlXmTJ1jk9pNNePCEOLGnz4vdtRNZoSaLFV09omqWMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 18:30:07 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 18:30:07 +0000
Message-ID: <b5cf30fa-6efe-04e4-173c-adec24386fbb@amd.com>
Date: Thu, 6 Jul 2023 20:30:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 10/10] drm/amdgpu: add delay after userqueue mapping
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-11-shashank.sharma@amd.com>
 <CADnq5_O2iSioSREAp=8iPnQ+qcm98b6+NUK6AJo9y5XGkT6BbA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_O2iSioSREAp=8iPnQ+qcm98b6+NUK6AJo9y5XGkT6BbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0de59c-d9d6-4442-c37b-08db7e4f05e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWqLka30xwOB3UNdZkOt+C7nFUeudJkj75gPvl5GHY/XBJ8Zo1jdn5S3H3K3yagLIunIVz2XPwlUMawxDB7lMdKcR37ImJL8EczfxKwrnxb6lwGnABRclwZmMPx+7Nh0qcBP4npK2Izr3WZqgCH0SVkV8ZE13iNA+p6boy97lC40rLPr0ZRIqQGqL3kBZiunWXtF37SzceZpb+uCIzzzx+tVpspACLAp4Qg4xqlZnsMdgBmB4qI3o8D5jJl4cN0XVFxLD7Kf8V6LjyevUJ+jm8/BiR7tWrF9b4VJDISnJ6VzjRV+hWGmIjMpDgKlnT/fAlJCj3D5Z9nCR9anbJ4zp8uMGBW9eKkoQ4BAgLs/bGLUuHd9IvxlBf29LlDm6Z6mjLdt6ZD2tlpzR5csGQnW5aP7e8Gpr+DXKzP69tzObwVVt+TycI9v6UgNXerWGMDumIikjEyfiYHeDGG85SLT6t3SlTULkGKqvV6OdY8nUtQrKeRqEPJuFqylWBv+XcFtxfDnLM5uaWBTSeoVfOgwzbWex3ohmM0gnGKRX1WYAwHHmGScKOJHjzrKavqhtn/1wcOBpM1bRoLaEFyrjQKvW33R2BYLpfnqeeVC+ttTP3UtlJFNWu8gXOvj9a9fzeE/knwoDvUNIwmXvFrt3fx/Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(31686004)(36756003)(31696002)(86362001)(2906002)(44832011)(5660300002)(4326008)(6512007)(478600001)(186003)(83380400001)(6506007)(53546011)(26005)(54906003)(6486002)(66556008)(316002)(2616005)(38100700002)(6916009)(66476007)(41300700001)(66946007)(8936002)(8676002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkdVdXJoNEdaK1doT0Nad0MwdWFvVDYxU2VITmRaWE5ENU9UVklGcGlWa0ww?=
 =?utf-8?B?eEhyaEFSQkVTbE9qT0RQa0d0T3pBVi9KU0Y1YU0rTlR4TCtkNlFJZzZqeFhM?=
 =?utf-8?B?OGRxc3NFcHdoKys3aTIxdnpYbWorbGc4WGNBUC80VUhpc0U4MG90Q1VPbjF6?=
 =?utf-8?B?Y2ZONzJVdlVtNnNNcGdFTUxyc1NDaHZRVnhxRGZVS3pGZ3I2UkZiaVdyOVAy?=
 =?utf-8?B?VlBYcDBKbGVjOVdndEtmV3o2R1RnYzR4Q1piVGxVMDJlNWgxMFhuUTVGeVJo?=
 =?utf-8?B?OGMrbmFvWURpSWZzMi8ySjQ1cm1yVWJxMHpGck92VXpKNjI3SGVCOFEwd2Z3?=
 =?utf-8?B?NjdqK0F4cktyamw0YUllVWtiZ1pvRmo0cDZvMml6OE9BVmZXQlpSRkhWYnl4?=
 =?utf-8?B?ZVk0NnZGaDRXTmw2RlpaUXB3SmpKYjlvWk44KzZleDB3Q2h0SXcwMU9BejZR?=
 =?utf-8?B?d0RRbTZEWjVFU3BCUkRPRUFpUlZnbHpIRENBRFg1NjFncEdUTUlDSlVkQTkz?=
 =?utf-8?B?a01BRzJjb2hPR3FhZXRWWmFtMmtkQkVGdHhQWmJUOU9HTFQ2SGFhQmI5SUFW?=
 =?utf-8?B?djZPa1VTY3BwR05HbW1Sd2txc0ladmEydFArUjBramdSWTdiWGIxb1ZKMXkz?=
 =?utf-8?B?TEJMc3RURjVwYnFrMHVmS0xPWXlIb0pwK2xuZm9SZFBrVkkzbkUvblN2RHBI?=
 =?utf-8?B?VjVRSUlJZTdBZjFSVTNaVlF2UGVaeHQ0UXNqaXFLZ2d5Rlp5ZW0wM0tIOGw5?=
 =?utf-8?B?djJOY3lwVXdlejlLTW8xR3B3K3U5NmtIaGlBSTFzUHlYN2N2a2F2QytqZTRP?=
 =?utf-8?B?K3RFTmZETUFSRUpNMGZ3OEJweUVxZnF0UGVMRDYxb1pkVkJyTlV6eStkR2R5?=
 =?utf-8?B?dC90eEhId25xWkZjK00xeWpQNUdKV3lJd05lenpXc1p1Qy9WaXdzRDdDOXFt?=
 =?utf-8?B?STB6aFdPcnUxQXp6T0ZWZ2UxYnZvYUJRNXRITzBTN0dGRFRLMDRob29qNi9S?=
 =?utf-8?B?ZnRVSkdLeW5NZkFtRERpcko5U3BFR0Q3eWlRa3IyczRtZE13bjRQbWlIMnRT?=
 =?utf-8?B?Wk52QWwxcXFkamNYclR4NWVCektDYis3U01xWWpmWnlwTVZyWDRyQytaclZk?=
 =?utf-8?B?YzdmQ2FjMDZTRGNSTVoybGgrY3dIekpGTlA2ZE13b3NIcGxweExBaFFldS92?=
 =?utf-8?B?SEdDaGVxQjNWeTVHZGdKYncxeGt5NHpWODc2d3Yxb3lKaFNaRGRxajdvRGxt?=
 =?utf-8?B?RjhBbU5nclhhZ05UcjIvamtsQmgxV3VkMTFtOFFQNzhSV29yejlyQ2pObEV6?=
 =?utf-8?B?Y25kYWtLNmMvRUNJQjlncmgzTUw2Vm9UWmlSVzI5VmZTeXZQZFphNGFqUnI5?=
 =?utf-8?B?YXJTT2s5UDVEQzUrQmQ3WTYyQnRhSHR6T09YSHUxQnlwcVFsY2FKWEhPM1Z0?=
 =?utf-8?B?aXMxczN2THk4dGN1SWpVVWNQVWRLNUM4NHNaNzJvaG1JZW9iTFc1VStvdVVm?=
 =?utf-8?B?RDJMbkhxczRNVjczeW55RXhFcytDSllsN2R4cE1JOWV4aUQ5MTlSWi9wV2ND?=
 =?utf-8?B?ZmxLNEpUVjFHRi8rcFlPaGw2bHBBZDRpWFVvc2Y4aytiUjZ0SVJUR0k2c0JG?=
 =?utf-8?B?dGltTUZvczlQL3ptOUFsOUhQaitZeitlVDN5Z2NKcVJpaUhqdHN0bVFkSkJ1?=
 =?utf-8?B?K29uaXFxSklrYmZFZS9EeVVGcTBqdFZBa2JVb0dzZHArQ1ZNeXovNVp3OUxn?=
 =?utf-8?B?K0o2TEpRZkZCSmJ2eVVYRDdQNytvTGhjQytQUmo0U21uM05FVGJSVi9tZmpN?=
 =?utf-8?B?QkRpcG9PNGFJTk1uRFFEMEVsRFExbDc5MjVaUFhHWTVVV2ZGQ1BkWnpMcS9F?=
 =?utf-8?B?SFFWczBjTHErMU5xU3Z5b1EzU2U2c0JVU2luR2k3Qlk2Z1dNcVc0djdDNjU4?=
 =?utf-8?B?Tk81RDlnTFFlUTE3OTQremVNdGxzWHhFTkt4ZVRLWjUyL01LMlFDd2pwajFU?=
 =?utf-8?B?QWVHQ0tYejJ2Rk5hcitFUFFSZFNIbndOaHd2U0szQWtRU1ZhNlBxdjFPVkRs?=
 =?utf-8?B?dndrR21vaFEvREp4VzNyQWFQWGJ3bzFNOVVnYkZ2U1QzMjlCVUg0WWt5bkRk?=
 =?utf-8?Q?508K+v9jI0aswD8lCqTxaie7k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0de59c-d9d6-4442-c37b-08db7e4f05e6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:30:07.2451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UefhGFp7WF7rlyK5Pf6n2vWLDZBpt3iFAx4r60HAJEUnqKFfQz3hXNlneRyWkRb8tlxLYFbmfrid6zeGRESbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 06/07/2023 19:41, Alex Deucher wrote:
> On Thu, Jul 6, 2023 at 8:36 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> It has been observed that the MES FW needs 250-300us to map the gfx
>> userqueue, and if the user rings the doorbell before this duration,
>> the FW never recognizes the work. This patch adds the delay of 300
>> us after the queue mapping.
>>
>> V1: Moved the delay from userspace IOCTL to kernel (Alex).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 8edb020683a1..78b58c5d0fd8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/firmware.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <linux/delay.h>
>>   #include "amdgpu.h"
>>   #include "amdgpu_gfx.h"
>>   #include "amdgpu_psp.h"
>> @@ -6749,6 +6750,12 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                  goto free_ctx;
>>          }
>>
>> +       /*
>> +        * It has been observed that HWS needs appx 250-300us to map the queue, and the
>> +        * user needs to wait this duration before ringing the doorbell, or else the FW
>> +        * will never recognize the work.
>> +        */
>> +       udelay(300);
> Is there a way we can query the MES to verify that the queue is mapped
> and ready?  We should talk to the MES team.  This is hacky and may
> fail if the MES is busy, etc.

So far I have not received any input on this, I can restart a discussion.

- Shashank

> Alex
>
>
>>          return 0;
>>
>>   free_ctx:
>> --
>> 2.40.1
>>
