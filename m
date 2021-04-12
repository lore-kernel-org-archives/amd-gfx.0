Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32598C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 17:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE1F61019
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 17:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE1F61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A70989EA3;
	Mon, 12 Apr 2021 17:27:38 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F80689EA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 17:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSBA74AWSpA9hiwrNFwDcTjPSno7Ej/yi+uLhMfhsby9MridxPmof+jPofgutnRohNjz+98L/BjA1T8sXzaWMFyYjqoSmYjJ9fNXFs+qo07T8zJHYoG91dIgWVQsWcwmCBVse9Qda7ypdUmcgmYrGAccdpB3KV2y/8k2QsNVq661tpKig02+8b4gLSRtUjHaf7McYasPkEWtBu0d5gHnI3PGiRz6ykYAuN9Xun35xD+yoAFJpTjGCRHRbM4F6DlIWtrEkxSem8w9HC/fQkfqBMRG6Fn/kDrc8we0Vvp69UkCAah4uuTybTBqdb5xMqNaTZH3h9vhCy2v0R9uPYeGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGhwRTs5tqlz9oE+opysPb2zM7v+/gpVlX13sZOQKF4=;
 b=B3Bp/WSMNCnyXwDCxH6b7Opv+lxKQYZW/3TtslsYxeE+sNxKAwlDsGHryS2u8lh4ul91bcNAv+N0Z9EP8fK/qIGJSyXWJNfgpUy8mkWyN3wSmXE2fz9AmOnZOlulCjshkUi3FAFL++sE8TswHwIl/kHKXj1YGuMZLw/W2qiOOGugpT36xpI80Q9XRdMYd40kHzh3VHfWXjZyvs9UO1P3SZ9q+i/3D8LxYrDwhLXaHCwAb2gOJo2Qj9oPGdmKozg2ALxWgyOdontb84dfdNdyhieQ6+7lEUaBcLybyT6yGOiXvKpKc1fbz4r1pKL6BWTC8jAlWi0XCa8gxu9LV7dfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGhwRTs5tqlz9oE+opysPb2zM7v+/gpVlX13sZOQKF4=;
 b=XOATIVvnyJe33S4zrV9c1rebKgQaSMiwuaDFEAROdNgjInZAx/qvCpTLMoJY64+7Pj6ZnAj+z1Mo6eU7p/f/0kkHzfnMCs2gZ9QKivhRm1IChNsXXnhGamHpUV3fYHCDnrT3xKtWRd3wc457UTB90fFiTS9KVPurInv4gi1Kz+Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 17:27:35 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:27:35 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
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
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
Date: Mon, 12 Apr 2021 13:27:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
X-ClientProxiedBy: YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49)
 To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5]
 (2607:fea8:3edf:49b0:42b0:8005:56c0:5bb5) by
 YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Mon, 12 Apr 2021 17:27:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca1bdc26-f4d0-482a-8430-08d8fdd842c0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4541157510A61ED2C08597CDEA709@SA0PR12MB4541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nt4vWJzrpYkOuCdPjiIs8TSM4hEUA5P97IOHoxn2XG2KS0XjIgvFA5mN5u11+dHBd2hfxyjWCIpSE+shpqAMSgh5lMH1K+xvSCxx4cY5hqrqVUqQ+C9dhqeINRgIoUlCQpdlY6pmNmEiBQpeX3E0p5sB84zV8RPpwb/pZRzBSd0zBXglZuOUB6Mjoy3zFpHZhrYKab5C7kjABoeuLoy/Ev/QJkzjFUs+uV5AVfYVSpf4QTyRlfYrDZVD+Qqxzk4C7bE6T+Rp8BHWwtKLBR5xRqqmAvp83yFms8pP56ofrOH1xea9OiVFKKsH1YNlDZkFITqXfo2BTtRv5jEcHjP5vqZ9RjHMdYDUIUQ27myeWi88kuSl+8Y3BmGna0y0jpjb+iPRpSg/VDiuye9CtPLbfzdVtZwXy9XXFNsj/pC7r4tVVr4LRvI3Uksv2wNlUo0PhhBC4+qdf9AEoOGIY+oAu5uN4kii9+xv7HueErOtp4gJMe9sQ8vvTiIAK2lhTAlLCH9ctjh9m5cvqeKaLwF7yU1yM/zsZjSHHZyF4D1BwHBzfzFwr58Sy6MFMs0CvevVNB/4TbRXun3Rm+rjODfnPfHij332ITAUmMGOB9nJtoPeBbAA4ViC6HTCIiSSGSNWk63U8z/HCGdYa+RPBj2XhncVrL3q6G8GK449TQHz0gcRwHr3XgMbpav1sUvMBleaYB/O00jIAK5D1w/n7OCX3CJWgqfXmskRl9k8oQOGFrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(83380400001)(316002)(31686004)(166002)(66574015)(86362001)(53546011)(8936002)(66556008)(2616005)(44832011)(33964004)(38100700002)(52116002)(31696002)(66476007)(478600001)(966005)(6486002)(8676002)(6636002)(45080400002)(5660300002)(186003)(2906002)(6666004)(110136005)(36756003)(66946007)(16526019)(921005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M2k0dm5FTHNZQnVVTnozMkJIaUhPT0o2UzJrdG92V3pQMG52QWMyL0dyQktV?=
 =?utf-8?B?RFRFOFFjVVVGdGdmVVVNYUhXenNMcmt5cHFYcjlPM3VCeXJBZEJjV2pTQWJJ?=
 =?utf-8?B?YVVpOTVjMy9VSDBVRDlsY3FGYy9MMlVJN3RibXgwSnBlZXQ3enAyTTVYMDlF?=
 =?utf-8?B?eWtnS3ZZSll3d3lvejRYSDZHWmMxL3diMWFwejQ4UGs1cXF1UFpKVmZLMFBt?=
 =?utf-8?B?QkZKdHIyLzloeHRaV1R3QTA2QUcwOWwxaWxUMmtqUVZ1OFovaUZPRENwV2xv?=
 =?utf-8?B?dHdMZkNoR2Q3VUh6SGh3YmE4bGRDeU5ER0djTFdvekpMRFNTRUtnRkFkd1g4?=
 =?utf-8?B?N3FhdHNIelpXYndyc1V5VUVuQVhMUkorMnhaNnJGOEJYM0xBb25xV0pRS0wy?=
 =?utf-8?B?ZHV4ZVNoY0JiNU1XKzB2WW9uT1I3aithbnB4ZW1rNnpFYnViT2dpa1lscDRv?=
 =?utf-8?B?MEkrMXFCTU4wemVPcW1OMGh1NzNTdzFEc2UyNC9IL2Z2cGsxTEJTa3NpUVND?=
 =?utf-8?B?VTVJTExTTG1VeFAvcko3cFQwbXBGdEIwVDU0SUdGRzhqb1pUaGNJWEhzZEdH?=
 =?utf-8?B?YTVuUmhkbVQxRk1kckdSbVJtZzIvVjVhdUg3MHNwam9JRGhKSWNXb0VteTQy?=
 =?utf-8?B?djJHRkxVVmE4Mmk4dHljQjVUSXliekVjVk5ZSG4ra2tXS0NkZ3Y1Vm8yRFo2?=
 =?utf-8?B?TEVHV09VME5Cd1RkZFMvWDgxcUxaSjNMZnhOWE9OM2FqTDdXdDBCbVl2VlA1?=
 =?utf-8?B?QnkrSVM1WlFqWHliU2syL2lKZk82NHBXaGxNV2RwVGhJWllhelUyVkN2SWRj?=
 =?utf-8?B?cUJueWp5WXNOS0N2dWVJZDFhT3dHWkdDMWJIazM4WUdscC9BbDE3RW52ZGc3?=
 =?utf-8?B?V1VPRWZ2UjlEd2RzZm5FZXgwTUYybm1aWlRoWmd0aHNyeWtDdlMxNDRvNk83?=
 =?utf-8?B?bzluVzdQTDB2S0cyUXViYUZtQml6cUxvS1l0UCtOd3IwSFlYYktCYkZBSTh6?=
 =?utf-8?B?R212M2l4Z3BacXlrRU9Xc0xTWmhDNGdjdTArVEJRRGJlL2Y5dlo2TG1YUHhM?=
 =?utf-8?B?UnN6WlBNeitNTkdHK2NlZmRhNHJ1TEZDNkxoNU9VRVpWYXo5UlBzR2JOQVZu?=
 =?utf-8?B?Q1pyVWg1b2RmdTNWUFl4UnV0WFZQZ1BCWFh0b3dIdUdTT2wrTUlsd3hkT1lE?=
 =?utf-8?B?cWVPYmZ6dnBTQkFnNFdUQ0xVSEwyWkVFNmk0S3UzUFBkWGFKd01odFFNZGZz?=
 =?utf-8?B?TEQ4QURJbk9ONEZnVTh1M1lTbVlWeHBUMFExeU93WjBvQURzTHhpWEdBZnMr?=
 =?utf-8?B?THJhVXovdXBWQmFrL2NlUmd1aXVVOXBkMFZpSmpHWlh5NnJzREd5TDRDb01N?=
 =?utf-8?B?SUlFenZDeDdLQ21hdU1TY0VSck56WFhzZkowVWV3dk80NERIOGtsRHhVOWtY?=
 =?utf-8?B?MmRrWXBueGhTM1g2dFFTc1F3RGdQT0puRjB2Nk5kWFI3UWlmKzVMNm5EdUY2?=
 =?utf-8?B?VHNQSEhLQ0QzT0Nsb3M4bVUxT0p2TGxXeDkweGtqUjVsWEdpanhyaGFsR2FY?=
 =?utf-8?B?c3dCSlJrTUFDNGRzODlKL1Y3K213S1ZuVStEMm4ydW90aCtxTmt6NklCMVhl?=
 =?utf-8?B?SVBDVHF3c0pTUlJ2dTFIVG9UemlJT2NEM2M4OGlVYWdtNWpYTGh0NWJySW8y?=
 =?utf-8?B?NkllRVd4SFVjK1pRcjVaK0RHTGJKZFJhUzl1M0hXWk9SZk1kUGdQVVM3aVhF?=
 =?utf-8?B?d1U0dmtjRUdXN2NUT2w2WXQzS1dHSklvR2xIbC9pZ0V4R2U0cTdmcVV0TTlx?=
 =?utf-8?B?VHBjOUVLK0ZOU21POXg2Y0R1N0E2SUFJRERNVEphU0daYzg2S1ZlNldCcU84?=
 =?utf-8?Q?EWcuKDedq/bXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1bdc26-f4d0-482a-8430-08d8fdd842c0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 17:27:35.3348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NImOVzbzTZGojSEqbRSSW+USF9SRWCh0W1cgdHAOJmVcQsuZJXRO6a/gmYvN6M2SYtHqFy2iRwyIfdTf558IOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
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
Content-Type: multipart/mixed; boundary="===============1008061592=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1008061592==
Content-Type: multipart/alternative;
 boundary="------------FBE8EC16522B37A46E7A1410"
Content-Language: en-US

--------------FBE8EC16522B37A46E7A1410
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-04-10 1:34 p.m., Christian König wrote:
> Hi Andrey,
>
> Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky:
>> [SNIP]
>>>>
>>>> If we use a list and a flag called 'emit_allowed' under a lock such 
>>>> that in amdgpu_fence_emit we lock the list, check the flag and if 
>>>> true add the new HW fence to list and proceed to HW emition as 
>>>> normal, otherwise return with -ENODEV. In amdgpu_pci_remove we take 
>>>> the lock, set the flag to false, and then iterate the list and 
>>>> force signal it. Will this not prevent any new HW fence creation 
>>>> from now on from any place trying to do so ?
>>>
>>> Way to much overhead. The fence processing is intentionally lock 
>>> free to avoid cache line bouncing because the IRQ can move from CPU 
>>> to CPU.
>>>
>>> We need something which at least the processing of fences in the 
>>> interrupt handler doesn't affect at all.
>>
>>
>> As far as I see in the code, amdgpu_fence_emit is only called from 
>> task context. Also, we can skip this list I proposed and just use 
>> amdgpu_fence_driver_force_completion for each ring to signal all 
>> created HW fences.
>
> Ah, wait a second this gave me another idea.
>
> See amdgpu_fence_driver_force_completion():
>
> amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>
> If we change that to something like:
>
> amdgpu_fence_write(ring, ring->fence_drv.sync_seq + 0x3FFFFFFF);
>
> Not only the currently submitted, but also the next 0x3FFFFFFF fences 
> will be considered signaled.
>
> This basically solves out problem of making sure that new fences are 
> also signaled without any additional overhead whatsoever.


Problem with this is that the act of setting the sync_seq to some MAX 
value alone is not enough, you actually have to call 
amdgpu_fence_process to iterate and signal the fences currently stored 
in ring->fence_drv.fences array and to guarantee that once you done your 
signalling no more HW fences will be added to that array anymore. I was 
thinking to do something like bellow:

amdgpu_fence_emit()

{

     dma_fence_init(fence);

     srcu_read_lock(amdgpu_unplug_srcu)

     if (!adev->unplug)) {

         seq = ++ring->fence_drv.sync_seq;
         emit_fence(fence);

*/* We can't wait forever as the HW might be gone at any point*/**
        dma_fence_wait_timeout(old_fence, 5S);*
         ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask] = 
fence;

     } else {

         dma_fence_set_error(fence, -ENODEV);
         DMA_fence_signal(fence)

     }

     srcu_read_unlock(amdgpu_unplug_srcu)
     return fence;

}

amdgpu_pci_remove

{

     adev->unplug = true;
     synchronize_srcu(amdgpu_unplug_srcu)

     /* Past this point no more fence are submitted to HW ring and hence 
we can safely call force signal on all that are currently there.
      * Any subsequently created  HW fences will be returned signaled 
with an error code right away
      */

     for_each_ring(adev)
         amdgpu_fence_process(ring)

     drm_dev_unplug(dev);
     Stop schedulers
     cancel_sync(all timers and queued works);
     hw_fini
     unmap_mmio

}


Andrey


>
>
>>
>>>>>
>>>>> Alternatively grabbing the reset write side and stopping and then 
>>>>> restarting the scheduler could work as well.
>>>>>
>>>>> Christian.
>>>>
>>>>
>>>> I didn't get the above and I don't see why I need to reuse the GPU 
>>>> reset rw_lock. I rely on the SRCU unplug flag for unplug. Also, not 
>>>> clear to me why are we focusing on the scheduler threads, any code 
>>>> patch to generate HW fences should be covered, so any code leading 
>>>> to amdgpu_fence_emit needs to be taken into account such as, direct 
>>>> IB submissions, VM flushes e.t.c
>>>
>>> You need to work together with the reset lock anyway, cause a 
>>> hotplug could run at the same time as a reset.
>>
>>
>> For going my way indeed now I see now that I have to take reset write 
>> side lock during HW fences signalling in order to protect against 
>> scheduler/HW fences detachment and reattachment during schedulers 
>> stop/restart. But if we go with your approach  then calling 
>> drm_dev_unplug and scoping amdgpu_job_timeout with drm_dev_enter/exit 
>> should be enough to prevent any concurrent GPU resets during unplug. 
>> In fact I already do it anyway - 
>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;reserved=0
>
> Yes, good point as well.
>
> Christian.
>
>>
>> Andrey
>>
>>
>>>
>>>
>>> Christian.
>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>
>>>
>

--------------FBE8EC16522B37A46E7A1410
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+DQo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPHA+PGJyPgog
ICAgPC9wPgogICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAyMDIxLTA0LTEwIDE6
MzQgcC5tLiwgQ2hyaXN0aWFuCiAgICAgIEvDtm5pZyB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAg
IDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNpdGU9Im1pZDpiNmEyNGQzZi00ZmU2LWM2NDItYjQ3
OC0zNmUzODZhYTkwNmRAZ21haWwuY29tIj5IaQogICAgICBBbmRyZXksCiAgICAgIDxicj4KICAg
ICAgPGJyPgogICAgICBBbSAwOS4wNC4yMSB1bSAyMDoxOCBzY2hyaWViIEFuZHJleSBHcm9kem92
c2t5OgogICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPltTTklQXQogICAg
ICAgIDxicj4KICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgIDxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICA8YnI+CiAgICAgICAgICAgIElmIHdlIHVz
ZSBhIGxpc3QgYW5kIGEgZmxhZyBjYWxsZWQgJ2VtaXRfYWxsb3dlZCcgdW5kZXIgYQogICAgICAg
ICAgICBsb2NrIHN1Y2ggdGhhdCBpbiBhbWRncHVfZmVuY2VfZW1pdCB3ZSBsb2NrIHRoZSBsaXN0
LCBjaGVjawogICAgICAgICAgICB0aGUgZmxhZyBhbmQgaWYgdHJ1ZSBhZGQgdGhlIG5ldyBIVyBm
ZW5jZSB0byBsaXN0IGFuZAogICAgICAgICAgICBwcm9jZWVkIHRvIEhXIGVtaXRpb24gYXMgbm9y
bWFsLCBvdGhlcndpc2UgcmV0dXJuIHdpdGgKICAgICAgICAgICAgLUVOT0RFVi4gSW4gYW1kZ3B1
X3BjaV9yZW1vdmUgd2UgdGFrZSB0aGUgbG9jaywgc2V0IHRoZSBmbGFnCiAgICAgICAgICAgIHRv
IGZhbHNlLCBhbmQgdGhlbiBpdGVyYXRlIHRoZSBsaXN0IGFuZCBmb3JjZSBzaWduYWwgaXQuCiAg
ICAgICAgICAgIFdpbGwgdGhpcyBub3QgcHJldmVudCBhbnkgbmV3IEhXIGZlbmNlIGNyZWF0aW9u
IGZyb20gbm93IG9uCiAgICAgICAgICAgIGZyb20gYW55IHBsYWNlIHRyeWluZyB0byBkbyBzbyA/
CiAgICAgICAgICAgIDxicj4KICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgIDxicj4K
ICAgICAgICAgIFdheSB0byBtdWNoIG92ZXJoZWFkLiBUaGUgZmVuY2UgcHJvY2Vzc2luZyBpcyBp
bnRlbnRpb25hbGx5CiAgICAgICAgICBsb2NrIGZyZWUgdG8gYXZvaWQgY2FjaGUgbGluZSBib3Vu
Y2luZyBiZWNhdXNlIHRoZSBJUlEgY2FuCiAgICAgICAgICBtb3ZlIGZyb20gQ1BVIHRvIENQVS4K
ICAgICAgICAgIDxicj4KICAgICAgICAgIDxicj4KICAgICAgICAgIFdlIG5lZWQgc29tZXRoaW5n
IHdoaWNoIGF0IGxlYXN0IHRoZSBwcm9jZXNzaW5nIG9mIGZlbmNlcyBpbgogICAgICAgICAgdGhl
IGludGVycnVwdCBoYW5kbGVyIGRvZXNuJ3QgYWZmZWN0IGF0IGFsbC4KICAgICAgICAgIDxicj4K
ICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPGJyPgogICAgICAgIDxicj4KICAgICAgICBB
cyBmYXIgYXMgSSBzZWUgaW4gdGhlIGNvZGUsIGFtZGdwdV9mZW5jZV9lbWl0IGlzIG9ubHkgY2Fs
bGVkCiAgICAgICAgZnJvbSB0YXNrIGNvbnRleHQuIEFsc28sIHdlIGNhbiBza2lwIHRoaXMgbGlz
dCBJIHByb3Bvc2VkIGFuZAogICAgICAgIGp1c3QgdXNlIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9y
Y2VfY29tcGxldGlvbiBmb3IgZWFjaCByaW5nIHRvCiAgICAgICAgc2lnbmFsIGFsbCBjcmVhdGVk
IEhXIGZlbmNlcy4KICAgICAgICA8YnI+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPGJyPgog
ICAgICBBaCwgd2FpdCBhIHNlY29uZCB0aGlzIGdhdmUgbWUgYW5vdGhlciBpZGVhLgogICAgICA8
YnI+CiAgICAgIDxicj4KICAgICAgU2VlIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxl
dGlvbigpOgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgYW1kZ3B1X2ZlbmNlX3dyaXRlKHJp
bmcsIHJpbmctJmd0O2ZlbmNlX2Rydi5zeW5jX3NlcSk7CiAgICAgIDxicj4KICAgICAgPGJyPgog
ICAgICBJZiB3ZSBjaGFuZ2UgdGhhdCB0byBzb21ldGhpbmcgbGlrZToKICAgICAgPGJyPgogICAg
ICA8YnI+CiAgICAgIGFtZGdwdV9mZW5jZV93cml0ZShyaW5nLCByaW5nLSZndDtmZW5jZV9kcnYu
c3luY19zZXEgKwogICAgICAweDNGRkZGRkZGKTsKICAgICAgPGJyPgogICAgICA8YnI+CiAgICAg
IE5vdCBvbmx5IHRoZSBjdXJyZW50bHkgc3VibWl0dGVkLCBidXQgYWxzbyB0aGUgbmV4dCAweDNG
RkZGRkZGCiAgICAgIGZlbmNlcyB3aWxsIGJlIGNvbnNpZGVyZWQgc2lnbmFsZWQuCiAgICAgIDxi
cj4KICAgICAgPGJyPgogICAgICBUaGlzIGJhc2ljYWxseSBzb2x2ZXMgb3V0IHByb2JsZW0gb2Yg
bWFraW5nIHN1cmUgdGhhdCBuZXcgZmVuY2VzCiAgICAgIGFyZSBhbHNvIHNpZ25hbGVkIHdpdGhv
dXQgYW55IGFkZGl0aW9uYWwgb3ZlcmhlYWQgd2hhdHNvZXZlci48L2Jsb2NrcXVvdGU+CiAgICA8
cD48YnI+CiAgICA8L3A+CiAgICA8cD5Qcm9ibGVtIHdpdGggdGhpcyBpcyB0aGF0IHRoZSBhY3Qg
b2Ygc2V0dGluZyB0aGUgc3luY19zZXEgdG8gc29tZQogICAgICBNQVggdmFsdWUgYWxvbmUgaXMg
bm90IGVub3VnaCwgeW91IGFjdHVhbGx5IGhhdmUgdG8gY2FsbAogICAgICBhbWRncHVfZmVuY2Vf
cHJvY2VzcyB0byBpdGVyYXRlIGFuZCBzaWduYWwgdGhlIGZlbmNlcyBjdXJyZW50bHkKICAgICAg
c3RvcmVkIGluIHJpbmctJmd0O2ZlbmNlX2Rydi5mZW5jZXMgYXJyYXkgYW5kIHRvIGd1YXJhbnRl
ZSB0aGF0CiAgICAgIG9uY2UgeW91IGRvbmUgeW91ciBzaWduYWxsaW5nIG5vIG1vcmUgSFcgZmVu
Y2VzIHdpbGwgYmUgYWRkZWQgdG8KICAgICAgdGhhdCBhcnJheSBhbnltb3JlLiBJIHdhcyB0aGlu
a2luZyB0byBkbyBzb21ldGhpbmcgbGlrZSBiZWxsb3c6PC9wPgogICAgPHA+YW1kZ3B1X2ZlbmNl
X2VtaXQoKTwvcD4KICAgIDxwPns8L3A+CiAgICA8cD4mbmJzcDsmbmJzcDsmbmJzcDsgZG1hX2Zl
bmNlX2luaXQoZmVuY2UpOzxicj4KICAgIDwvcD4KICAgIDxwPiZuYnNwOyZuYnNwOyZuYnNwOyBz
cmN1X3JlYWRfbG9jayhhbWRncHVfdW5wbHVnX3NyY3UpPC9wPgogICAgPHA+Jm5ic3A7Jm5ic3A7
Jm5ic3A7IGlmICghYWRldi0mZ3Q7dW5wbHVnKSkgezwvcD4KICAgIDxwPiZuYnNwOyZuYnNwOyZu
YnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgc2VxID0gKytyaW5nLSZndDtmZW5jZV9kcnYuc3luY19z
ZXE7PGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IGVtaXRf
ZmVuY2UoZmVuY2UpOzwvcD4KICAgIDxwPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsm
bmJzcDsgPGI+LyogV2UgY2FuJ3Qgd2FpdCBmb3JldmVyIGFzIHRoZSBIVyBtaWdodCBiZSBnb25l
IGF0CiAgICAgICAgYW55IHBvaW50Ki88L2I+PGI+PGJyPgogICAgICAgICZuYnNwOyZuYnNwOyZu
YnNwOyAmbmJzcDsmbmJzcDsgZG1hX2ZlbmNlX3dhaXRfdGltZW91dChvbGRfZmVuY2UsIDVTKTs8
L2I+PGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IHJpbmct
Jmd0O2ZlbmNlX2Rydi5mZW5jZXNbc2VxICZhbXA7CiAgICAgIHJpbmctJmd0O2ZlbmNlX2Rydi5u
dW1fZmVuY2VzX21hc2tdID0gZmVuY2U7PGJyPgogICAgPC9wPgogICAgPHA+Jm5ic3A7Jm5ic3A7
Jm5ic3A7IH0gZWxzZSB7PC9wPgogICAgPHA+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNw
OyZuYnNwOyBkbWFfZmVuY2Vfc2V0X2Vycm9yKGZlbmNlLCAtRU5PREVWKTs8YnI+CiAgICAgICZu
YnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgRE1BX2ZlbmNlX3NpZ25hbChmZW5j
ZSkgJm5ic3A7Jm5ic3A7IDxicj4KICAgIDwvcD4KICAgIDxwPiZuYnNwOyZuYnNwOyZuYnNwOyB9
ICZuYnNwOyA8YnI+CiAgICA8L3A+CiAgICA8cD4mbmJzcDsmbmJzcDsmbmJzcDsgc3JjdV9yZWFk
X3VubG9jayhhbWRncHVfdW5wbHVnX3NyY3UpPGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsg
cmV0dXJuIGZlbmNlOzxicj4KICAgIDwvcD4KICAgIDxwPn08L3A+CiAgICA8cD5hbWRncHVfcGNp
X3JlbW92ZSA8YnI+CiAgICA8L3A+CiAgICA8cD57PC9wPgogICAgPHA+Jm5ic3A7Jm5ic3A7Jm5i
c3A7IGFkZXYtJmd0O3VucGx1ZyA9IHRydWU7PGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsg
c3luY2hyb25pemVfc3JjdShhbWRncHVfdW5wbHVnX3NyY3UpJm5ic3A7PC9wPgogICAgPHA+Jm5i
c3A7Jm5ic3A7Jm5ic3A7IC8qIFBhc3QgdGhpcyBwb2ludCBubyBtb3JlIGZlbmNlIGFyZSBzdWJt
aXR0ZWQgdG8gSFcgcmluZyBhbmQKICAgICAgaGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxsIGZvcmNl
IHNpZ25hbCBvbiBhbGwgdGhhdCBhcmUgY3VycmVudGx5CiAgICAgIHRoZXJlLiA8YnI+CiAgICAg
ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqIEFueSBzdWJzZXF1ZW50bHkgY3JlYXRlZCZuYnNw
OyBIVyBmZW5jZXMgd2lsbCBiZSByZXR1cm5lZAogICAgICBzaWduYWxlZCB3aXRoIGFuIGVycm9y
IGNvZGUgcmlnaHQgYXdheSA8YnI+CiAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAqLzxi
cj4KICAgIDwvcD4KICAgIDxwPiZuYnNwOyZuYnNwOyZuYnNwOyBmb3JfZWFjaF9yaW5nKGFkZXYp
PGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7IGFtZGdwdV9m
ZW5jZV9wcm9jZXNzKHJpbmcpPC9wPgogICAgPHA+Jm5ic3A7Jm5ic3A7Jm5ic3A7IGRybV9kZXZf
dW5wbHVnKGRldik7PGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsgU3RvcCBzY2hlZHVsZXJz
PGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsgY2FuY2VsX3N5bmMoYWxsIHRpbWVycyBhbmQg
cXVldWVkIHdvcmtzKTs8YnI+CiAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyBod19maW5pPGJyPgog
ICAgICAmbmJzcDsmbmJzcDsmbmJzcDsgdW5tYXBfbW1pbzxicj4KICAgIDwvcD4KICAgIDxwPn08
L3A+CiAgICA8cD48YnI+CiAgICA8L3A+CiAgICA8cD5BbmRyZXk8L3A+CiAgICA8cD48YnI+CiAg
ICA8L3A+CiAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6YjZhMjRkM2YtNGZl
Ni1jNjQyLWI0NzgtMzZlMzg2YWE5MDZkQGdtYWlsLmNvbSI+CiAgICAgIDxicj4KICAgICAgPGJy
PgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YnI+CiAgICAgICAgPGJs
b2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4K
ICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgICAgPGJyPgog
ICAgICAgICAgICAgIEFsdGVybmF0aXZlbHkgZ3JhYmJpbmcgdGhlIHJlc2V0IHdyaXRlIHNpZGUg
YW5kIHN0b3BwaW5nCiAgICAgICAgICAgICAgYW5kIHRoZW4gcmVzdGFydGluZyB0aGUgc2NoZWR1
bGVyIGNvdWxkIHdvcmsgYXMgd2VsbC4KICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAg
PGJyPgogICAgICAgICAgICAgIENocmlzdGlhbi4KICAgICAgICAgICAgICA8YnI+CiAgICAgICAg
ICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgPGJyPgogICAgICAgICAgICA8YnI+CiAgICAg
ICAgICAgIEkgZGlkbid0IGdldCB0aGUgYWJvdmUgYW5kIEkgZG9uJ3Qgc2VlIHdoeSBJIG5lZWQg
dG8gcmV1c2UKICAgICAgICAgICAgdGhlIEdQVSByZXNldCByd19sb2NrLiBJIHJlbHkgb24gdGhl
IFNSQ1UgdW5wbHVnIGZsYWcgZm9yCiAgICAgICAgICAgIHVucGx1Zy4gQWxzbywgbm90IGNsZWFy
IHRvIG1lIHdoeSBhcmUgd2UgZm9jdXNpbmcgb24gdGhlCiAgICAgICAgICAgIHNjaGVkdWxlciB0
aHJlYWRzLCBhbnkgY29kZSBwYXRjaCB0byBnZW5lcmF0ZSBIVyBmZW5jZXMKICAgICAgICAgICAg
c2hvdWxkIGJlIGNvdmVyZWQsIHNvIGFueSBjb2RlIGxlYWRpbmcgdG8gYW1kZ3B1X2ZlbmNlX2Vt
aXQKICAgICAgICAgICAgbmVlZHMgdG8gYmUgdGFrZW4gaW50byBhY2NvdW50IHN1Y2ggYXMsIGRp
cmVjdCBJQgogICAgICAgICAgICBzdWJtaXNzaW9ucywgVk0gZmx1c2hlcyBlLnQuYwogICAgICAg
ICAgICA8YnI+CiAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICA8YnI+CiAgICAgICAg
ICBZb3UgbmVlZCB0byB3b3JrIHRvZ2V0aGVyIHdpdGggdGhlIHJlc2V0IGxvY2sgYW55d2F5LCBj
YXVzZSBhCiAgICAgICAgICBob3RwbHVnIGNvdWxkIHJ1biBhdCB0aGUgc2FtZSB0aW1lIGFzIGEg
cmVzZXQuCiAgICAgICAgICA8YnI+CiAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgIDxicj4K
ICAgICAgICA8YnI+CiAgICAgICAgRm9yIGdvaW5nIG15IHdheSBpbmRlZWQgbm93IEkgc2VlIG5v
dyB0aGF0IEkgaGF2ZSB0byB0YWtlIHJlc2V0CiAgICAgICAgd3JpdGUgc2lkZSBsb2NrIGR1cmlu
ZyBIVyBmZW5jZXMgc2lnbmFsbGluZyBpbiBvcmRlciB0byBwcm90ZWN0CiAgICAgICAgYWdhaW5z
dCBzY2hlZHVsZXIvSFcgZmVuY2VzIGRldGFjaG1lbnQgYW5kIHJlYXR0YWNobWVudCBkdXJpbmcK
ICAgICAgICBzY2hlZHVsZXJzIHN0b3AvcmVzdGFydC4gQnV0IGlmIHdlIGdvIHdpdGggeW91ciBh
cHByb2FjaCZuYnNwOyB0aGVuCiAgICAgICAgY2FsbGluZyBkcm1fZGV2X3VucGx1ZyBhbmQgc2Nv
cGluZyBhbWRncHVfam9iX3RpbWVvdXQgd2l0aAogICAgICAgIGRybV9kZXZfZW50ZXIvZXhpdCBz
aG91bGQgYmUgZW5vdWdoIHRvIHByZXZlbnQgYW55IGNvbmN1cnJlbnQKICAgICAgICBHUFUgcmVz
ZXRzIGR1cmluZyB1bnBsdWcuIEluIGZhY3QgSSBhbHJlYWR5IGRvIGl0IGFueXdheSAtCjxhIGNs
YXNzPSJtb3otdHh0LWxpbmstZnJlZXRleHQiIGhyZWY9Imh0dHBzOi8vbmFtMTEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9w
Lm9yZyUyRn5hZ3JvZHpvdiUyRmxpbnV4JTJGY29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQl
MjZpZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDljNWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2FtcDtk
YXRhPTA0JTdDMDElN0NhbmRyZXkuZ3JvZHpvdnNreSU0MGFtZC5jb20lN0NlZWZhOWM5MGVkOGM0
MDVlYzNiNzA4ZDhmYzQ2ZGFhYSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2Mzc1MzY3Mjg1NTA4ODQ3NDAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMTAwMCZhbXA7YW1wO3NkYXRhPVVpTmFKRSUyQkg0NWlZbWJ3U0RuTVNLWlM1ejBpYWsw
Zk5sYmJmWXFLUzJKbyUzRCZhbXA7YW1wO3Jlc2VydmVkPTAiPmh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNr
dG9wLm9yZyUyRn5hZ3JvZHpvdiUyRmxpbnV4JTJGY29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5l
eHQlMjZpZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDljNWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2Ft
cDtkYXRhPTA0JTdDMDElN0NhbmRyZXkuZ3JvZHpvdnNreSU0MGFtZC5jb20lN0NlZWZhOWM5MGVk
OGM0MDVlYzNiNzA4ZDhmYzQ2ZGFhYSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNk
JTdDMCU3QzAlN0M2Mzc1MzY3Mjg1NTA4ODQ3NDAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
V0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2
TW4wJTNEJTdDMTAwMCZhbXA7YW1wO3NkYXRhPVVpTmFKRSUyQkg0NWlZbWJ3U0RuTVNLWlM1ejBp
YWswZk5sYmJmWXFLUzJKbyUzRCZhbXA7YW1wO3Jlc2VydmVkPTA8L2E+PGJyPgogICAgICA8L2Js
b2NrcXVvdGU+CiAgICAgIDxicj4KICAgICAgWWVzLCBnb29kIHBvaW50IGFzIHdlbGwuCiAgICAg
IDxicj4KICAgICAgPGJyPgogICAgICBDaHJpc3RpYW4uCiAgICAgIDxicj4KICAgICAgPGJyPgog
ICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8YnI+CiAgICAgICAgQW5kcmV5
CiAgICAgICAgPGJyPgogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICBD
aHJpc3RpYW4uCiAgICAgICAgICA8YnI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICA8YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAgPGJyPgogICAgICAgICAgICBBbmRyZXkKICAg
ICAgICAgICAgPGJyPgogICAgICAgICAgICA8YnI+CiAgICAgICAgICAgIDxicj4KICAgICAgICAg
ICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgICAgPGJyPgogICAgICAgICAg
ICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICAgICAgPGJyPgogICAgICAg
ICAgICAgICAgQ2hyaXN0aWFuLgogICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgICAg
PGJyPgogICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAg
ICAgICAgIDxicj4KICAgICAgICAgICAgICAgICAgQW5kcmV5CiAgICAgICAgICAgICAgICAgIDxi
cj4KICAgICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgICAgICA8YnI+CiAgICAgICAg
ICAgICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICAgICAgICAgIDxi
cj4KICAgICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj5BbmRyZXkKICAg
ICAgICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgICAgICAgICAgIDxicj4KICAgICAg
ICAgICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAg
ICAgICAgICAgICAgICAgICAgPGJyPgogICAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAg
ICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICA8YnI+CiAgICAgICAg
ICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgICAgIDxicj4KICAgICAgICAgICAgPC9ibG9j
a3F1b3RlPgogICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgPGJyPgogICAgICAgIDwv
YmxvY2txdW90ZT4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8YnI+CiAgICA8L2Jsb2NrcXVv
dGU+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--------------FBE8EC16522B37A46E7A1410--

--===============1008061592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1008061592==--
