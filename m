Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 07:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7164C61165
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 07:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7164C61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C629989E5F;
	Tue,  9 Nov 2021 07:17:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEACF89E2B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 07:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXrEMziTf+rVFgdNXOHEnRCZhRLyybVNsgHLuGE5l96Tq6S0EBKpiXisJLJ4iXWwimJrmytKzo9/070h3+nuj7nZxlGYKPz9OUzc3DDc96F+YpeEko0g9J7Dwwin6UBk7f69pqqWT7Xa4w3SCQ1fpoGWoKSa9Cn0WwbBlTXcVp295eZ+TmTKzm8j9r0y2UgDneeMKszx6V38vJ+T2+kgew3e0JXvSe03wIm/PvweydqwgZodWwqpMOikTJOzeeGmkodcGfXvzg6azrN86lPSXkJmrPihtqH6LMsASxBEzyhP9lg6AsiDHzR9WR16LPvLtfOjNmGyQFtRWVdpyB2rUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxuiZJ/rSDa3md+a3xRm+JuGhKX/N3LXhHA39n+KWYc=;
 b=fPlQ/YgeKWtpjrWLR+1MTm//q2D51O46WCTr6vuPKNGAQlicyW3F7t6MfU6sNXgiVq2gOcFcWnkzAgVNyaeSo4OFYWWjKarwsdm5rDLMlQo7EPiB6oAqD7Ws0Iv1FP7bdAgq5gXft8U3WV63v8+oeN3qxdMmYr/lmVUS2KKvugkxfzm8oE78KGRNgpb9FAmubYpSOnMMXIScozBRkjEnreQ++Hmy65jCad+8abos5WXJTG4GMmTNLE2xVK7W8z83K52spRZ7vkupqYKftaIswHq/KxwxUxIxIVKBsZN4D805uBQY1yzcnwJK/6WQVV/aBeYUJpzbNFh7gVpSdYhskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxuiZJ/rSDa3md+a3xRm+JuGhKX/N3LXhHA39n+KWYc=;
 b=xkxnssKnSXXVmz5wf9XsC1C9TA+vN74BnjiBISPmQcES2zf0fuDxLNmNpjeLpPl/bK9Wi+dD1Exm/XiEAuCH/mH6Tl3CajUvUWPPy8i4AxFwT4v+coOQg0vLHRWCJZSCFGazTY/kLe2OwGoeJwPOb11H5BJ/UC0pB5sHY+mWxVE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1277.namprd12.prod.outlook.com
 (2603:10b6:300:f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 07:16:59 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:16:59 +0000
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Borislav Petkov <bp@suse.de>,
 Paul Menzel <pmenzel@molgen.mpg.de>, "Liu, Leo" <Leo.Liu@amd.com>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
 <YYkGteomN5Cbh1+C@zn.tnic> <3800b659-f0cb-2565-c525-91b5b34d1a30@amd.com>
 <d35eca15-df36-5885-ca31-a1bd50f09fdf@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a1bfc35c-c987-38b4-e7b7-16c9b9295635@amd.com>
Date: Tue, 9 Nov 2021 08:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <d35eca15-df36-5885-ca31-a1bd50f09fdf@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0088.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::29) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (79.194.4.163) by
 AM0PR06CA0088.eurprd06.prod.outlook.com (2603:10a6:208:fa::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 07:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea8f426-563c-4947-87e2-08d9a350eb5e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1277:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1277D2F01F7E54556219578883929@MWHPR12MB1277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XaZxfVv6PO0PAOIbQuPLnEbxmmFG4j9USMmFkjy7SFhUCOJUUrwfL5J5SdvSnDlnA8xtSr+o59xT0s+/B88ZLwFvrx3PY3nrjCSqJ2nvqzsyv2anY71QHTsncz1BQBZoj3fQTEwC/3xE6ZA1dROLya64EgpnOw7ytaIePBnf/ZWPJHeaeIeHm7Aq0DJxYLWznzFEGbFMpQsjTHtKlk4hvYcxA80eC80QFAaQoXkUZECQ3arEjvVDmWHVLGJJRApEvTwIE6frFVwYB1pqG48pu+vld3V8/WfqZr1jfGy+yYVKWfRcHpqRajXQEvDd1AJshqMzUVhTIJENaIBtdsphkgNuj93j0Hq5Q2zmxqnte607WTJYtwzUdiPc15tsEFOkfeiD/tnCaWA35uJ14bRW5lgaATrAKDXN7p1Gxl6bqFEVBMEZpKKvCxMCzAW/2l8xz1kAA43woZuDiAXWZGpL2n62K8rrX8iyw1nviwvtYfmyC8HmmbgkhCBJTCRCsgqo7l8UXCWROOv4srn6TNMyC5MveiHQg7A0lqVUatz+0PnHeVNqIyT7ogfjyYsoaoGb1vbUVfm4xbDscR6Fo4tDus1XfPykXOceRF3Cvw1sk3ILCCoRjqAPx8YvRBSJG6g2Hg4yf5HIcGWpd9W1iEbgbnjofsYf73ExSO7ABmejdnovkgzUs659mGnK71YtJhASx0j/3GrsR9kztcGVxN+d62DofqP4RHwHG9h/7DHj4g1Arf3CR7SpqvgDihovAVi2hFAUocrOsF35YMArvTNY2UAGxcrdY0HErQKiKUsi9SH3HxcoaQNPYQv1ljh5VDeFeddJtS4TTukGp2jqAbSWeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(2906002)(53546011)(4326008)(83380400001)(31696002)(956004)(2616005)(66574015)(110136005)(66556008)(66946007)(6666004)(26005)(186003)(5660300002)(86362001)(16576012)(6486002)(316002)(38100700002)(8676002)(8936002)(508600001)(966005)(66476007)(6636002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZTcW9vdEc2cGFWdVJqNExOTjlTeTd6d2VqK3lnb0FTNkhpRVhZOGdWR3hX?=
 =?utf-8?B?c2M5RjcvTHBtdE5SVHZ0RGdXN1lFZTIrT0dTRjFScG9LNE5BSHkxcHRadEhC?=
 =?utf-8?B?OUJjNmlQVFY0TkNZVTlUTjIvYlJ2ZDBzNStGZU9QRzl5d0pDRXdvaC9jYzd3?=
 =?utf-8?B?dW5TME1wTldLc0FudG1vKzBUN1VDY3lJK3lFTWxQQ3paMGVnWVVpT0Z4eDQw?=
 =?utf-8?B?WWN4bW0zSE1Uei81YytJcGpycmdCNWZFVThSNWZsNjdJTkpFT3VhdjZSSWZu?=
 =?utf-8?B?KzFQcFY2Zmg0bmRvZFNMRjFkWFQ2VmE3QjNXME92NkFvS0lNSXk1VHZyY2cz?=
 =?utf-8?B?MnNsVkljK25oRjVBYlRYK24vUHBZTUVIT1A0NnVBV0IrUnAxaUgrTlgveHlh?=
 =?utf-8?B?aVpSRzZCTHRGN09IYkVWY2ZBKy9zRzVReVM5NzBxZjdrZmlzRDV4d0NaSFls?=
 =?utf-8?B?QVBGcld5UFdLUUw0MGM0ZkE1RFMzY3NVMHhqbnpqanQxVlEzR1M5VTJUVDNM?=
 =?utf-8?B?djZOWDZuU1pVRDFDdXp5U0Jic3B0SStOKzF5eWlMRnNzKzZDWm9EK1lsV2JT?=
 =?utf-8?B?RS94NDBodGZNQTFHWFpBRlM3c2FZeHBiZW1GYWFaWWp1cVlqeSt4QzkxSVYz?=
 =?utf-8?B?NkxNYVpIbHhsZEkxY1VNbkNHcWJHdmxvMGFTU016ZEJyUVlyQVJ2bUgwRmlN?=
 =?utf-8?B?WmExd2dHRGtCdVN4bkZKcEh6bUhlMkk0Q0hZUCsyQWxJVm8rYTdPSHdINEhu?=
 =?utf-8?B?a3ltUjRyL0pBWGRyNUhQNHgxMkQyRlA5VWl6R0V3bkxZWWZ3Qzc5T3FKUnVS?=
 =?utf-8?B?TGpKL0dPb2I0a1h1Qk42LzBRWTArTzlZR0w3R00rRUNlWWJDZVgrWU9mQUhw?=
 =?utf-8?B?SWh3QmxTcHdGdnlnbmJpbENGZXBOcFJXakZsRVVQODlYK3NjMGN3SnZxZlNY?=
 =?utf-8?B?Rm1BOE9idVNoUUlld1ZmRjNsVEoyUkNEejJaWDVKZEFhNnFEcmJkclgybktj?=
 =?utf-8?B?azczalhSYStKNUhjdThHdnJyRjRISDZWREVObnFyNVVXRFo5Rm5LWGxab1Rz?=
 =?utf-8?B?cnUzc1o2bEcycGhyY0hFVDNHN3MyVllZNDBKMG1pVEdxcUd5Q3hmaGpXRUtk?=
 =?utf-8?B?c2NjRmFjc2JYRnVlVHU1ZStTb1dEUThseFNKeFZMNHFEMkcza3IzbFlhVVFj?=
 =?utf-8?B?TUh4VHVJZWI4cmZqRmhuNkR3TlpBWXh0REdldFZTSG5FUmQ3cHdPSkZtaVla?=
 =?utf-8?B?aTVtWXhyY0VwZC9iMkQzNnNlTFpGZFBBNEZtNmRjcEQzVHhaMEl4SkxlTU9S?=
 =?utf-8?B?aTFOalJWODZDVW9oZmg0RGNTQVNDNnhPbXA0b1F0bU1lK2JrVTRNUDVyRzU2?=
 =?utf-8?B?SW9ZdWwvR1BNbldLUkFkcCtYcWhYZUE0Zm9SSHhBR1hSL0hpTnkvWkU1ekV0?=
 =?utf-8?B?ZUs3ODZ2M0hXRWR1S1FONTZQM2FtN3pYdzJFRWFGRlgrNlFES0tGZWdWVDAz?=
 =?utf-8?B?QzZrN1VVQVFtTHUrMjJPa0FFeFdFWitrV0k5RlFLZzdWLzdVNHFiTXIrU1dF?=
 =?utf-8?B?U1pwVmVpMHZndDBkYzI0YlRjSWh1Syt0L3ZwTHdaUS9IS1E5eHQ0NjlMQjF6?=
 =?utf-8?B?NFVLZkkxMEpRN0tSNVZ4c243akVWWlVMcFFkWjZ0MFlLQnZLRjJndzJna2k1?=
 =?utf-8?B?NTVuN1RQMnZQVEU5bzZJUW8vUStNVW1OT1lzVUdYSXRKbUYvaDdrcW96NGtK?=
 =?utf-8?B?b1dSaXBSUkhMNjcwUm8wM0RGdUh2U0d0bDU2OURNOVRHR2RvRGhCci9wWWl1?=
 =?utf-8?B?R1hRdVBVMjJkZ2w5UVpLZUU1VTdFL3o1R1NXRmNRby9vaWNXajlaNUM3dWwr?=
 =?utf-8?B?YUJ5QWpXL0xpWGJkWTBWenE2WnBIV1FyQ3doc3lONG8vZVVDeENSZFN2UVc3?=
 =?utf-8?B?R25MdlJZOXdDR2ZCblR0YzRHUEw3bWdBK3U0U0dIZFBjenVIb3FheEFFbW45?=
 =?utf-8?B?MDdsK1F5NjNaeW1zSEhpU3lBTE1FOGMzdVVWeVdFRmRmYU9hYjE2Q1M4MEVz?=
 =?utf-8?B?NlVveThYenVRa203WE50RW55UHNhcHhlcGFpTlF6d3NRYUNqVU1aUXNtY3VD?=
 =?utf-8?Q?29Xs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea8f426-563c-4947-87e2-08d9a350eb5e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:16:59.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G3xu3+hHAxni3tmjkaGzO05BRAI2Er/yreDPYdf9hzqPkvSZk0c/BF9zLpBOwEJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1277
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.11.21 um 15:41 schrieb Lazar, Lijo:
>
>
> On 11/8/2021 7:44 PM, Christian König wrote:
>> Am 08.11.21 um 12:15 schrieb Borislav Petkov:
>>> On Mon, Nov 08, 2021 at 09:51:03AM +0100, Paul Menzel wrote:
>>>> Please elaborate the kind of issues.
>>> It fails to reboot on Carrizo-based laptops.
>>
>> That doesn't necessary sounds like a good idea to me then.
>>
>> What exactly is going wrong here? And what is the rational that we 
>> must fix this by avoiding updating the current state?
>>
>
> Reboot will trigger a suspend of IPs. As part of UVD/VCE suspend, now 
> there is an added logic to power gate the IP as part of suspend 
> sequence. In case of UVD/VCE, power gating would have already happened 
> as part of idle work execution.
>
> In any case, power gating is done by SMU FW. The assumption here is - 
> the logic to power gate IP could involve register programming. AFAIK, 
> accessing some UVD/VCE regs during powergate state could cause a hang 
> unless the anti-hang mechanism is not programmed. That means either FW 
> or driver needs to track the state of IP before accessing those regs 
> and in this case probably FW is assuming driver to be responsible. 
> i.e., not to call power off again if it's already powered down.
>
> Though that seems to be a bad assumption on part of FW, it is still a 
> possibility. Haven't seen the actual FW code, it's a very old program.


Ok guys I've double checked the git history and found that this here is 
not as it is intended to be.

See the code in question was just added in August by the following commit:

commit 859e4659273f1df3a23e3990826bcb41e85f68a5
Author: Evan Quan <evan.quan@amd.com>
Date:   Thu Aug 19 12:07:59 2021 +0800

     drm/amdgpu: add missing cleanups for more ASICs on UVD/VCE suspend

     This is a supplement for commit below:
     "drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend".

     Signed-off-by: Evan Quan <evan.quan@amd.com>
     Reviewed-by: Guchun Chen <guchun.chen@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Before that we where just not touching the UVD power state at all during 
suspend and so we won't had a problem in the first place.

So what we should do instead is to just revert commit 
859e4659273f1df3a23e3990826bcb41e85f68a5 with a proper fixes Tag and 
explanation why that is a bad idea.

Regards,
Christian.


>
> Thanks,
> Lijo
>
>> See we usually assume that updating to the already set state is 
>> unproblematic and that here sounds like just trying to mitigated some 
>> issues instead of fixing the root cause.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Whoever commits this, pls add
>>>
>>> Link: https://lore.kernel.org/r/YV81vidWQLWvATMM@zn.tnic
>>>
>>> so that it is clear what the whole story way.
>>>
>>> Thx.
>>>
>>

