Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B76C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 18:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A651361289
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 18:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A651361289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6332C89BF4;
	Mon, 12 Apr 2021 18:19:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D1389BF4
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 18:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXYl+z+quydhDYqBZGnu4DGIw0rf76Nrm3sbre4Aii6MbWWtQ32DaWXpgQNephrianwRCZM9CbQ7gNrEGxtsqymU1b92UJZiyWPr9yyp8o1ri7iKu8htEpxzvzYNJQKD0DTl8Ko82bm6M9qDD9gZhkGeaPlKU8dsBakLoH8Jp7GCrdXXA+/5YvC87x0mdxykbIFzHBqnHlAngj7duYDoYMeU2/K4sxYV2JvZ2kzGiR1BmxnK1Ric0LH0wuOnw7qmAUjKszjLgeYadF0qxZhxLAaCfPugLghorUJ3CUnH6i45Ab0wQePoJzBSE+KGTElir2G0PVtrVUAR6qzJrFJLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSG11hyUhqp7x2mWIIiAyMX2bYi2dHak1WX/Z6vSVTs=;
 b=HOffmsSrpYvInNn/U8vexqO4B73S0Y7FyZgcSlPRzqPL/oMkBTVamUeYx8YwdXI0ZTNz/4QJ01L6OkXp96YwIAJbhJrZKGbwLi+ygqdpgzXuUOqK5ng/oQIC4iji5vgQj2y1Nl1iov/9jprdEG0zJa0t2tE4V/+uX2xDnxifWaxA5KEqDqTd92yXUKcM0rJ3YKTZ/iThO6FJoxIg9/Av6ZvRBpdFuF+PMiNpWcyfOee2vLobmZWsd4c0ojvnWaFExNXb7tco/j+YMPuKx1DScmumilKjAie0MJMrlpZIIoj7dZWf1Sa5GeiVqHuxhBhH5zx5yHIdFbVdd4MKCA3Alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSG11hyUhqp7x2mWIIiAyMX2bYi2dHak1WX/Z6vSVTs=;
 b=2Df33n/NL1nHh5Gt1jtll+dHT+veSDvvRSxk3Bpfab6hlBhCg6X5OawRDJWc/WyQxajeG46Nvc5M0AWa3i6qVQN0TXWSW33/zOobeZR/Jnbk1pEvzLwQOjzJH+4wnxIg2hIfJX7QSfIckbbuxgiU4/ODfVY44k5aUj2qgNoF6ts=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Mon, 12 Apr
 2021 18:18:58 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:18:58 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
Date: Mon, 12 Apr 2021 14:18:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
 (2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22 via Frontend
 Transport; Mon, 12 Apr 2021 18:18:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46cf70ba-8ce8-41e7-94c7-08d8fddf7082
X-MS-TrafficTypeDiagnostic: SA0PR12MB4400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4400D91B4E6E2E652DFCE7A8EA709@SA0PR12MB4400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYpblw3UkIl5L5LQaWhO0GDKwzqQzoI1pEZaNv3jQx11HG1E94d+QgG5PniOjef7LomFBQA+/UI0BilJubQ/3UYD+jAC/NJBH5kTxA5C65NHD9y5Wev/wXHFGR431xUeSQCT9BxE5VpIoCFAgjmE/cp5rlOnp6xndsP/vlGcjw76skQlFuYdEY+60KYbLNAEbYpW4Boy427zt6wB+XpU4Y6lJhtTmZtCgbCjb1BTonsiCv6z2tRXaPKwvCln2VgSP0ykcV9Cz9rWykrZE5dM74w4BoiCvYUQfO7QucpUkLVDEAOOtQiF8hOjcdawFTuCgVQtojHQtDh0K1jt3X3nczhiuZLaXqiF7NH/Byy062rQlfnPiEQn+y9XsUUP+rRO/9lmY7uSl2N4Aci3HfkzIHZmBOJH/h4KN+ObrEtjEM550PJi71Il8iDllcDFTjf29oeeqiBjxSJWrjzLVG+4i48hpb6bDqFP4KC1Hc/BZh/n9iArSL1uD/8Yd7lm0o25OvJcjnKRKfc6E1KOSPeB01VgvAIrUA0HtJ1DFk7hCb+f6Wuzwnn+/gf7PLjxyEIeMm5foh7qdL2Yl5JqJMuOOmGLBvBJbJZ8J/MyhllzGTgyJfUnMIPR3VSSeUQU50A5y1+lfiWECwyUrPD+yk8HVFZEqw16bT7ziljN0v9c3PscDB8kFnLIBEtPybrmqHiQGHt8moUkMdSGkojOFF4bGhp9+pCYyuLVE55eGpfi9kjwYIRspBqEfeheIiQg3GoVMtVwqF3xOEYAqjEoaRsHkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(186003)(83380400001)(966005)(16526019)(6486002)(2906002)(31686004)(66946007)(45080400002)(8676002)(38100700002)(36756003)(8936002)(316002)(31696002)(52116002)(6636002)(66574015)(921005)(86362001)(44832011)(30864003)(2616005)(110136005)(66556008)(33964004)(5660300002)(478600001)(66476007)(53546011)(166002)(60764002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aTBubHQzK3lscmpLL0daRlZGU09ZNzM2bVZRY3diMC9nQm1TTU4xYit1cHlH?=
 =?utf-8?B?aXJZWk1DRmdGNFZsNkkzNUQwYXI5Y0J1emhYMml0QW9qRFlwSXkxa2RYRWRU?=
 =?utf-8?B?MDlHUlZiNkl2TFlkN1EwUGUwUHBDeklVVmR0eWR6R3lVL2hLaXZkY0kvZXpK?=
 =?utf-8?B?R29oRFdzRnplTHJtRjFWQ3Q2ZnRxa3BLR1pVdWlCWXliaGlwRmQrcmFUc1cz?=
 =?utf-8?B?d2NXSzBqMGRoYXFhN0JOQmt3ZkROUHdRTFNXcGFuMlpwSmVxMHR5MFBwM2Nw?=
 =?utf-8?B?RzNKM1NnaGdjRVNxbnpHTG96MHhPQW1PNGRxYlBmSCtIQVFGK2o3RXlBU2pJ?=
 =?utf-8?B?Tk0vQy8wemQzWWZIdVBuakRnNVg1Wjl3Zkw3QjdxMmhtNlJiRnRpRk5QbzZV?=
 =?utf-8?B?TkJNelpFeFpmMkdCZzJJMDJ6alBDeXBkeEduaW5qMG9lMnhKWlBVZllUV2hq?=
 =?utf-8?B?R1l0SGluQUVWalI3TDdOT3A5Skw5UE9NUCtrb09qU0ZOMXIrdHU5dncwK3ZM?=
 =?utf-8?B?NVg2RVg2UC8vWTQyMDZFNGJ1NW5OQzl6QW9YcmkrUU9iUU5UVGN0eEx2eDB3?=
 =?utf-8?B?TmJPZnVUUjc5b1pHUXRFZzJsSE5oSlVrQ3FDYVlvVzU2UEtXbU40ZkN0aXc2?=
 =?utf-8?B?eGpzbnRKMmtnWFpBMThKTjBTQmhGYjJ4Y0k1dFRYOXhsYUljREZybk5ZRTNs?=
 =?utf-8?B?cmxDVkhjS1VzWmRwMjBMMjJWU24rNW0zRDRoTjl0UEw2TDY2WklDaFFLM21S?=
 =?utf-8?B?YzJBOTl5Nk5neVZQU3Y0K3NKODdyRE1ZaUFXd3QyVmFOZ1c4WFhNOCtmRW16?=
 =?utf-8?B?RFlFT0svVDZSRm4yQWk4amJ3dVpXSXFLY2FGd2xSMnBvTFRpd3pFa3RnTzZw?=
 =?utf-8?B?a0xnMUJnb3hYSnEyelZTMVVZZkpvaVVpbkdsUWJCZE14YXhmcHlHWHFlQmY2?=
 =?utf-8?B?SXdNMWprTXRZTmJuMlVmMUNPSkJ3ZDhUVWduMUhoZ1JoM1VrRkJNL3A4Ulg0?=
 =?utf-8?B?VGhNMGlPZUNDdUhPdGdtTytmdzYvNEZnZjNPNEd3TklhaVBJT2sycjZMUE5j?=
 =?utf-8?B?bjNnUUVhU3dnb0o1RzJDVkJPRkgzSHpDSnc2UktBeW9ONW04WFlFVldsd3hB?=
 =?utf-8?B?azdadVJSUWhtVXVMeVd5T3hyL2ErVlZWeGJDMzNKMm1INWxjeU54eU8xWWgv?=
 =?utf-8?B?am1ucTN4enpHelhpb3lQSks5NEpYdGNuaDR5cmJHb283NDZCZ2k3RG1ya2ds?=
 =?utf-8?B?Z1RyOFkycXYwRmZFUkl5RzBRSE04dEYrYUtIanM4WGJhdEhsRjd5MzAyUzFm?=
 =?utf-8?B?dzRzT3FtbW0yeEJnR0xvb09vL2dQdm1PSGVzOStTV0E5emZQN3NKZ1ltNzBI?=
 =?utf-8?B?ODZiN1cvdVQrUlFpR1l5MHZob0hSRm0rYUdsV2tsSzhnb3pqM3R5U3lEcUMr?=
 =?utf-8?B?dHJWRDVwNURCTGJiakFONXpOOURDaVNOSEE0dVF3a0J6QUcwUjd4Sm9zMlRL?=
 =?utf-8?B?SnFUNWtxL2NLSkpGMnlTN2xrUU85RXNLMGY0NmVqeFFiODB3K0dsSGpBR1RZ?=
 =?utf-8?B?ZXl4QnJJeHdtejVjQWgvV1ZGV2pId21OVFk5OThYSnYzREY1Skl0MkJiVm1p?=
 =?utf-8?B?MTREWmRkVzNTbXN6eUN6QjJ5a2d6dFV2YTA0NHB6K2UzR25HdkdOMVBCaTM4?=
 =?utf-8?B?NnF1S3lLQjB0QTZRSTFTWTBrSXlBd3BQaXltT1ZVWVkvRjJhcU1SMm9GVndH?=
 =?utf-8?B?UXpXZjdiR3MvSnpKRm4zdEpvRjR0MTBtMTNrMnkzZE1ValhVa25QQ2M5a1o4?=
 =?utf-8?B?MGtwRE9nYkQvd1B2UzIzZHVkWWFBYkxiNXZZUjdNOHJ5WUtJQXZwbDBuTjlW?=
 =?utf-8?Q?57OqA+RdlHL2N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cf70ba-8ce8-41e7-94c7-08d8fddf7082
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:18:58.3343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkxkxQMyArBYTuRhweRbh8qz1PFOsSQWT6O357fD946BKq+BVomXXcux+zdccp6gxCJiI2xq2e9P5LaDfr80Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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
Content-Type: multipart/mixed; boundary="===============2120577988=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2120577988==
Content-Type: multipart/alternative;
 boundary="------------333F1FBADBDD731718A759FC"
Content-Language: en-US

--------------333F1FBADBDD731718A759FC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-04-12 2:05 p.m., Christian König wrote:
> Am 12.04.21 um 20:01 schrieb Andrey Grodzovsky:
>>
>> On 2021-04-12 1:44 p.m., Christian König wrote:
>>
>>>
>>> Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:
>>>> On 2021-04-10 1:34 p.m., Christian König wrote:
>>>>> Hi Andrey,
>>>>>
>>>>> Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky:
>>>>>> [SNIP]
>>>>>>>>
>>>>>>>> If we use a list and a flag called 'emit_allowed' under a lock 
>>>>>>>> such that in amdgpu_fence_emit we lock the list, check the flag 
>>>>>>>> and if true add the new HW fence to list and proceed to HW 
>>>>>>>> emition as normal, otherwise return with -ENODEV. In 
>>>>>>>> amdgpu_pci_remove we take the lock, set the flag to false, and 
>>>>>>>> then iterate the list and force signal it. Will this not 
>>>>>>>> prevent any new HW fence creation from now on from any place 
>>>>>>>> trying to do so ?
>>>>>>>
>>>>>>> Way to much overhead. The fence processing is intentionally lock 
>>>>>>> free to avoid cache line bouncing because the IRQ can move from 
>>>>>>> CPU to CPU.
>>>>>>>
>>>>>>> We need something which at least the processing of fences in the 
>>>>>>> interrupt handler doesn't affect at all.
>>>>>>
>>>>>>
>>>>>> As far as I see in the code, amdgpu_fence_emit is only called 
>>>>>> from task context. Also, we can skip this list I proposed and 
>>>>>> just use amdgpu_fence_driver_force_completion for each ring to 
>>>>>> signal all created HW fences.
>>>>>
>>>>> Ah, wait a second this gave me another idea.
>>>>>
>>>>> See amdgpu_fence_driver_force_completion():
>>>>>
>>>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>>>>>
>>>>> If we change that to something like:
>>>>>
>>>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq + 0x3FFFFFFF);
>>>>>
>>>>> Not only the currently submitted, but also the next 0x3FFFFFFF 
>>>>> fences will be considered signaled.
>>>>>
>>>>> This basically solves out problem of making sure that new fences 
>>>>> are also signaled without any additional overhead whatsoever.
>>>>
>>>>
>>>> Problem with this is that the act of setting the sync_seq to some 
>>>> MAX value alone is not enough, you actually have to call 
>>>> amdgpu_fence_process to iterate and signal the fences currently 
>>>> stored in ring->fence_drv.fences array and to guarantee that once 
>>>> you done your signalling no more HW fences will be added to that 
>>>> array anymore. I was thinking to do something like bellow:
>>>>
>>>
>>> Well we could implement the is_signaled callback once more, but I'm 
>>> not sure if that is a good idea.
>>
>>
>> This indeed could save the explicit signaling I am doing bellow but I 
>> also set an error code there which might be helpful to propagate to users
>>
>>
>>>
>>>> amdgpu_fence_emit()
>>>>
>>>> {
>>>>
>>>>     dma_fence_init(fence);
>>>>
>>>>     srcu_read_lock(amdgpu_unplug_srcu)
>>>>
>>>>     if (!adev->unplug)) {
>>>>
>>>>         seq = ++ring->fence_drv.sync_seq;
>>>>         emit_fence(fence);
>>>>
>>>> */* We can't wait forever as the HW might be gone at any point*/**
>>>>        dma_fence_wait_timeout(old_fence, 5S);*
>>>>
>>>
>>> You can pretty much ignore this wait here. It is only as a last 
>>> resort so that we never overwrite the ring buffers.
>>
>>
>> If device is present how can I ignore this ?
>>

I think you missed my question here


>>
>>>
>>> But it should not have a timeout as far as I can see.
>>
>>
>> Without timeout wait the who approach falls apart as I can't call 
>> srcu_synchronize on this scope because once device is physically gone 
>> the wait here will be forever
>>
>
> Yeah, but this is intentional. The only alternative to avoid 
> corruption is to wait with a timeout and call BUG() if that triggers. 
> That isn't much better.
>
>>
>>>
>>>>         ring->fence_drv.fences[seq & 
>>>> ring->fence_drv.num_fences_mask] = fence;
>>>>
>>>>     } else {
>>>>
>>>>         dma_fence_set_error(fence, -ENODEV);
>>>>         DMA_fence_signal(fence)
>>>>
>>>>     }
>>>>
>>>>     srcu_read_unlock(amdgpu_unplug_srcu)
>>>>     return fence;
>>>>
>>>> }
>>>>
>>>> amdgpu_pci_remove
>>>>
>>>> {
>>>>
>>>>     adev->unplug = true;
>>>>     synchronize_srcu(amdgpu_unplug_srcu)
>>>>
>>>
>>> Well that is just duplicating what drm_dev_unplug() should be doing 
>>> on a different level.
>>
>>
>> drm_dev_unplug is on a much wider scope, for everything in the device 
>> including 'flushing' in flight IOCTLs, this deals specifically with 
>> the issue of force signalling HW fences
>>
>
> Yeah, but it adds the same overhead as the device srcu.
>
> Christian.


So what's the right approach ? How we guarantee that when running 
amdgpu_fence_driver_force_completion we will signal all the HW fences 
and not racing against some more fences insertion into that array ?

Andrey


>
>> Andrey
>>
>>
>>>
>>> Christian.
>>>
>>>>     /* Past this point no more fence are submitted to HW ring and 
>>>> hence we can safely call force signal on all that are currently there.
>>>>      * Any subsequently created  HW fences will be returned 
>>>> signaled with an error code right away
>>>>      */
>>>>
>>>>     for_each_ring(adev)
>>>>         amdgpu_fence_process(ring)
>>>>
>>>>     drm_dev_unplug(dev);
>>>>     Stop schedulers
>>>>     cancel_sync(all timers and queued works);
>>>>     hw_fini
>>>>     unmap_mmio
>>>>
>>>> }
>>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>>>>
>>>>>>>>> Alternatively grabbing the reset write side and stopping and 
>>>>>>>>> then restarting the scheduler could work as well.
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>
>>>>>>>> I didn't get the above and I don't see why I need to reuse the 
>>>>>>>> GPU reset rw_lock. I rely on the SRCU unplug flag for unplug. 
>>>>>>>> Also, not clear to me why are we focusing on the scheduler 
>>>>>>>> threads, any code patch to generate HW fences should be 
>>>>>>>> covered, so any code leading to amdgpu_fence_emit needs to be 
>>>>>>>> taken into account such as, direct IB submissions, VM flushes 
>>>>>>>> e.t.c
>>>>>>>
>>>>>>> You need to work together with the reset lock anyway, cause a 
>>>>>>> hotplug could run at the same time as a reset.
>>>>>>
>>>>>>
>>>>>> For going my way indeed now I see now that I have to take reset 
>>>>>> write side lock during HW fences signalling in order to protect 
>>>>>> against scheduler/HW fences detachment and reattachment during 
>>>>>> schedulers stop/restart. But if we go with your approach  then 
>>>>>> calling drm_dev_unplug and scoping amdgpu_job_timeout with 
>>>>>> drm_dev_enter/exit should be enough to prevent any concurrent GPU 
>>>>>> resets during unplug. In fact I already do it anyway - 
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;reserved=0
>>>>>
>>>>> Yes, good point as well.
>>>>>
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Andrey
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>

--------------333F1FBADBDD731718A759FC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-12 2:05 p.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com">
      
      Am 12.04.21 um 20:01 schrieb Andrey Grodzovsky:<br>
      <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
        <p>On 2021-04-12 1:44 p.m., Christian König wrote:<br>
        </p>
        <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
          Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:<br>
          <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
            <div class="moz-cite-prefix">On 2021-04-10 1:34 p.m.,
              Christian König wrote:<br>
            </div>
            <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">Hi
              Andrey, <br>
              <br>
              Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky: <br>
              <blockquote type="cite">[SNIP] <br>
                <blockquote type="cite">
                  <blockquote type="cite"> <br>
                    If we use a list and a flag called 'emit_allowed'
                    under a lock such that in amdgpu_fence_emit we lock
                    the list, check the flag and if true add the new HW
                    fence to list and proceed to HW emition as normal,
                    otherwise return with -ENODEV. In amdgpu_pci_remove
                    we take the lock, set the flag to false, and then
                    iterate the list and force signal it. Will this not
                    prevent any new HW fence creation from now on from
                    any place trying to do so ? <br>
                  </blockquote>
                  <br>
                  Way to much overhead. The fence processing is
                  intentionally lock free to avoid cache line bouncing
                  because the IRQ can move from CPU to CPU. <br>
                  <br>
                  We need something which at least the processing of
                  fences in the interrupt handler doesn't affect at all.
                  <br>
                </blockquote>
                <br>
                <br>
                As far as I see in the code, amdgpu_fence_emit is only
                called from task context. Also, we can skip this list I
                proposed and just use
                amdgpu_fence_driver_force_completion for each ring to
                signal all created HW fences. <br>
              </blockquote>
              <br>
              Ah, wait a second this gave me another idea. <br>
              <br>
              See amdgpu_fence_driver_force_completion(): <br>
              <br>
              amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq); <br>
              <br>
              If we change that to something like: <br>
              <br>
              amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq +
              0x3FFFFFFF); <br>
              <br>
              Not only the currently submitted, but also the next
              0x3FFFFFFF fences will be considered signaled. <br>
              <br>
              This basically solves out problem of making sure that new
              fences are also signaled without any additional overhead
              whatsoever.</blockquote>
            <p><br>
            </p>
            <p>Problem with this is that the act of setting the sync_seq
              to some MAX value alone is not enough, you actually have
              to call amdgpu_fence_process to iterate and signal the
              fences currently stored in ring-&gt;fence_drv.fences array
              and to guarantee that once you done your signalling no
              more HW fences will be added to that array anymore. I was
              thinking to do something like bellow:</p>
          </blockquote>
          <br>
          Well we could implement the is_signaled callback once more,
          but I'm not sure if that is a good idea.<br>
        </blockquote>
        <p><br>
        </p>
        <p>This indeed could save the explicit signaling I am doing
          bellow but I also set an error code there which might be
          helpful to propagate to users</p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
          <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
            <p>amdgpu_fence_emit()</p>
            <p>{</p>
            <p>&nbsp;&nbsp;&nbsp; dma_fence_init(fence);<br>
            </p>
            <p>&nbsp;&nbsp;&nbsp; srcu_read_lock(amdgpu_unplug_srcu)</p>
            <p>&nbsp;&nbsp;&nbsp; if (!adev-&gt;unplug)) {</p>
            <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq = ++ring-&gt;fence_drv.sync_seq;<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; emit_fence(fence);</p>
            <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <b>/* We can't wait forever as the HW might be
                gone at any point*/</b><b><br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; dma_fence_wait_timeout(old_fence, 5S);</b><br>
            </p>
          </blockquote>
          <br>
          You can pretty much ignore this wait here. It is only as a
          last resort so that we never overwrite the ring buffers.<br>
        </blockquote>
        <p><br>
        </p>
        <p>If device is present how can I ignore this ?</p>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
    <p>I think you missed my question here <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com">
      <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
          But it should not have a timeout as far as I can see.<br>
        </blockquote>
        <p><br>
        </p>
        <p>Without timeout wait the who approach falls apart as I can't
          call srcu_synchronize on this scope because once device is
          physically gone the wait here will be forever</p>
      </blockquote>
      <br>
      Yeah, but this is intentional. The only alternative to avoid
      corruption is to wait with a timeout and call BUG() if that
      triggers. That isn't much better.<br>
      <br>
      <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
          <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
            <p> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.fences[seq &amp;
              ring-&gt;fence_drv.num_fences_mask] = fence;<br>
            </p>
            <p>&nbsp;&nbsp;&nbsp; } else {</p>
            <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dma_fence_set_error(fence, -ENODEV);<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DMA_fence_signal(fence) &nbsp;&nbsp; <br>
            </p>
            <p>&nbsp;&nbsp;&nbsp; } &nbsp; <br>
            </p>
            <p>&nbsp;&nbsp;&nbsp; srcu_read_unlock(amdgpu_unplug_srcu)<br>
              &nbsp;&nbsp;&nbsp; return fence;<br>
            </p>
            <p>}</p>
            <p>amdgpu_pci_remove <br>
            </p>
            <p>{</p>
            <p>&nbsp;&nbsp;&nbsp; adev-&gt;unplug = true;<br>
              &nbsp;&nbsp;&nbsp; synchronize_srcu(amdgpu_unplug_srcu) <br>
            </p>
          </blockquote>
          <br>
          Well that is just duplicating what drm_dev_unplug() should be
          doing on a different level.<br>
        </blockquote>
        <p><br>
        </p>
        <p>drm_dev_unplug is on a much wider scope, for everything in
          the device including 'flushing' in flight IOCTLs, this deals
          specifically with the issue of force signalling HW fences</p>
      </blockquote>
      <br>
      Yeah, but it adds the same overhead as the device srcu.<br>
      <br>
      Christian.<br>
    </blockquote>
    <p><br>
    </p>
    <p>So what's the right approach ? How we guarantee that when running
      amdgpu_fence_driver_force_completion we will signal all the HW
      fences and not racing against some more fences insertion into that
      array ?</p>
    <p>Andrey<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com"> <br>
      <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
        <p>Andrey</p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
          Christian.<br>
          <br>
          <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
            <p>&nbsp;&nbsp;&nbsp; /* Past this point no more fence are submitted to HW
              ring and hence we can safely call force signal on all that
              are currently there. <br>
              &nbsp;&nbsp;&nbsp;&nbsp; * Any subsequently created&nbsp; HW fences will be
              returned signaled with an error code right away <br>
              &nbsp;&nbsp;&nbsp;&nbsp; */<br>
            </p>
            <p>&nbsp;&nbsp;&nbsp; for_each_ring(adev)<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; amdgpu_fence_process(ring)</p>
            <p>&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
              &nbsp;&nbsp;&nbsp; Stop schedulers<br>
              &nbsp;&nbsp;&nbsp; cancel_sync(all timers and queued works);<br>
              &nbsp;&nbsp;&nbsp; hw_fini<br>
              &nbsp;&nbsp;&nbsp; unmap_mmio<br>
            </p>
            <p>}</p>
            <p><br>
            </p>
            <p>Andrey</p>
            <p><br>
            </p>
            <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">
              <br>
              <br>
              <blockquote type="cite"> <br>
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite"> <br>
                      Alternatively grabbing the reset write side and
                      stopping and then restarting the scheduler could
                      work as well. <br>
                      <br>
                      Christian. <br>
                    </blockquote>
                    <br>
                    <br>
                    I didn't get the above and I don't see why I need to
                    reuse the GPU reset rw_lock. I rely on the SRCU
                    unplug flag for unplug. Also, not clear to me why
                    are we focusing on the scheduler threads, any code
                    patch to generate HW fences should be covered, so
                    any code leading to amdgpu_fence_emit needs to be
                    taken into account such as, direct IB submissions,
                    VM flushes e.t.c <br>
                  </blockquote>
                  <br>
                  You need to work together with the reset lock anyway,
                  cause a hotplug could run at the same time as a reset.
                  <br>
                </blockquote>
                <br>
                <br>
                For going my way indeed now I see now that I have to
                take reset write side lock during HW fences signalling
                in order to protect against scheduler/HW fences
                detachment and reattachment during schedulers
                stop/restart. But if we go with your approach&nbsp; then
                calling drm_dev_unplug and scoping amdgpu_job_timeout
                with drm_dev_enter/exit should be enough to prevent any
                concurrent GPU resets during unplug. In fact I already
                do it anyway - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
 luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0</a><br>
              </blockquote>
              <br>
              Yes, good point as well. <br>
              <br>
              Christian. <br>
              <br>
              <blockquote type="cite"> <br>
                Andrey <br>
                <br>
                <br>
                <blockquote type="cite"> <br>
                  <br>
                  Christian. <br>
                  <br>
                  <blockquote type="cite"> <br>
                    Andrey <br>
                    <br>
                    <br>
                    <blockquote type="cite"> <br>
                      <blockquote type="cite"> <br>
                        Christian. <br>
                        <br>
                        <blockquote type="cite"> <br>
                          Andrey <br>
                          <br>
                          <br>
                          <blockquote type="cite"> <br>
                            <blockquote type="cite">Andrey <br>
                              <br>
                              <br>
                            </blockquote>
                            <br>
                          </blockquote>
                        </blockquote>
                        <br>
                      </blockquote>
                      <br>
                    </blockquote>
                  </blockquote>
                  <br>
                </blockquote>
              </blockquote>
              <br>
            </blockquote>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------333F1FBADBDD731718A759FC--

--===============2120577988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2120577988==--
