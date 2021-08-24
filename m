Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7727C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A499161AEC
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A499161AEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B6E89B22;
	Tue, 24 Aug 2021 17:03:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985CD89B22
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J90o8CepqtKxyeaBCL4YWze46AR86Pug/7IptY+MF+q8FoqA7QxQiACEN9LMWUk8bTuJQ+x8c7vK5q+i/ve9WDDiT0t3XPwv4TaoJSoGbjk88tJxcInO1i5OvRD2/3a3NHS5QC/nMsMNIsvt5c6qDGSVHQbJYSdGdML8lBdsIUHSxkBqTEs1MAijdtjLvMaZpG8xRm8Se5WbP7hohcxexwMSDvMXjtesiinuHLVgUEbbQthgMnRJEHzLmFw2708BA8N6FgeiC0scx17QUsFxNJYeU5ekbxYeX8EvaVExLF50zx7CmAAM3QD0ouZNgxEV8Is1g5B/6DbMo1GOGqUBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUcwCUMNhgD+xCeT/oru5h0npf5pF7Yn/e2ilscOYZc=;
 b=caconPX7fqpcG17lrXhLg5RLnbDbc3r7ZRvVLuCcH/uXUu8NIYTMejwrlbZQt4BDC5A34rYR4xy0oUIYOeH5+N1eS/4RjybmzzIBAH632f8ZDgSAmHhlnGQAkOc1pXewxRHFLnqfx0XIv9wa5CKjDe5pBFqUyFJ1S8GzLjPur0fiW2D6V18cD2PEt6P/4PCIKN+H4aaQtZOBhdMqVDy4DnbwGdcqQXebejPauNUbqU3I1Eq3Wy4qkAg3SBkzY3Pwl2NeNKSgSHrG6I3WhZp3CH7YQgBPQ+7/NY9Rgn3rSLIUd9OjdmtsFz2sgWYWFqxZIJNRV0hhVVhpZHvIZraxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUcwCUMNhgD+xCeT/oru5h0npf5pF7Yn/e2ilscOYZc=;
 b=Fm7aTKa8lx4ajIhrqG8xCKxSAIfiQ65NLQ8frda4iFx9wJfEPKp4/CXAykwxyfB4/fNOB4x0ZBaDL/iGdmEo0Bs/84JEMtBds677ZA4Dynq8WHRvEaJnRda1qzVzvqICAL4Td1xITYlxrAKuQ8MUjwn00Y6GFVvPVKddRAPV8KU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:48:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e99e:c0a1:4e9d:322f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e99e:c0a1:4e9d:322f%9]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:48:56 +0000
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Simon Ser <contact@emersion.fr>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
 Hersen Wu <hersenxs.wu@amd.com>, Louis Li <Ching-shih.Li@amd.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
 <20210818131824.avczlw6ie3tfs76j@outlook.office365.com>
 <Hm33HvRokytajvNBSyeseBTVWScQu0mPJVLvRcABYsahB6j3DjJwvelk-WgnIA2AlG1AU0wnGV3gvAgzDf5nmWYRjIS58gMjtdrG0m_kjhA=@emersion.fr>
 <ffd29136-d0e3-17a9-f01f-e81c44ae0284@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <7a1d1909-cead-16ef-7b22-b2adc0cf3ee2@amd.com>
Date: Tue, 24 Aug 2021 12:48:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <ffd29136-d0e3-17a9-f01f-e81c44ae0284@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (209.195.106.179) by
 YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 16:48:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78522de7-b5a2-4044-1dc6-08d9671f0fd8
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5426F02AB86E1AF6AF6EB8E38CC59@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srzTR8pqKxFHwzj0pJ9KHt0HWxKLVcYbjzKeZdio1U74Fe8fA+mPU3exZwgs4do+0aGsVkO1VZeUik0UUUVBeoT6zYVA73I5yjpb/8E08D0LqOlagZQ1jnueMfHU+OqvZjrodZDfqtej4IBBP8f39Pydb8NRVEaLbXPF0rUyoEL5Q7vbytZXt4Li6DapDpKFKANDL1HdSlWRa78ERCPecJRKZeUIKLMKuzuvJNz4qHZyR3vxaEn7OQQ6DpE6s99kck/NePxoRwLM6I7FvRS0iywpxKKE2lOxfo9q5LvJlSeOdVWHkfomPGMuauUFIM/iDsnxswvbrbkto6FW4VMmxZaj58eJa7XKX9BPmp9p6Y6AVyG+ivrrbzhIBqCUp7NxP1ybczA1mLZiyxoKwB4g0CluVBAUAHYlA12enjokxSPav9YmRXH2FoGS8UItBZJEmr/1r56cEEMDoDcaPp2N1/Xy3QBWlOZAaNWdMCeyfiIRAwI0o6Su6joubmk73W9fUjqaEJDh4xN2ygStWW69rPpLkeuGcn9uwosgtR2by63y1HYsWlqjNAwxl8Xkhq9DpZLjM63sCn38/na7uzq7jXjwXJ6fT6YSrs1k2/bSMSP2wqlxkF4wwFYPbHZURotpKxkBCXhLFMfYpd/2wf4DSxSznZ9v2L7+19QpP6k5/8XESzkS+A2CzXpu5/xblw8G1vp4w5fdvV24g+lB4TAMlsMxslRwmuoc9bhfB+kEiQrerho5iWZKj/G1NYW31DeemEY8pjsmZFXqc53VzNYTe4jIyxKLPpWW0pBr9PQps2WutsTTGx0NJfGI2vLASEoNpcJ+F8dbV4NQmST6qP9Pf+d0eB4mE/DkXEOnDJZyzAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(6486002)(956004)(8676002)(8936002)(2616005)(44832011)(38100700002)(5660300002)(54906003)(36756003)(83380400001)(31686004)(66556008)(66476007)(2906002)(6636002)(66946007)(53546011)(110136005)(16576012)(186003)(316002)(478600001)(31696002)(26005)(4326008)(966005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lJOVFXeXZnRjNWdnREOWxPY04zSXdGZXA2UUJjSUZTZ1VpM1FvNkJaampG?=
 =?utf-8?B?dGw0cm1YNUNIYXo4SEJTbzQ4WURvMUVsMmJyTXJuRkV0TWZneEJZR1pOQlB4?=
 =?utf-8?B?cGFGL01VL0N4bnFwWUVFdnRpTmJxWEQyQWZuclN6NklaU096VTNKS3FqVWM3?=
 =?utf-8?B?M1l4YWlZdHE0RFNTOTF1QTNPMzJSLzc1bFFOclk2MlU1TnBReVZOWnRBSWRa?=
 =?utf-8?B?YVBTbGM5WDF1enZCSlBNWTBxREdIa0Ixd3RNNmpSWldoRW5TQzVBWTExUkpy?=
 =?utf-8?B?TVZGWjc4elVOV2p3Y3I3OFpJK0lKSUNKU090aEdGSS85NTkvN0lGVDRKM0dO?=
 =?utf-8?B?UXE1cXBkL0hmT0tYdGdZbWJhcFhiMkJ5eDNrempGRTRVK1hNUUxTQWZyUlA1?=
 =?utf-8?B?dDlYSS96dVpRR2M2WGU4c092djNXeGlrbDZlMjlaYStJKzBrazcyUlpXdUk4?=
 =?utf-8?B?WWZMYWFnVUw4RUNscDJEK243TThaU3IvRHhqUStYQnB3QlRHTE1wcHgvQnA5?=
 =?utf-8?B?aUlJK0pKbTZjYWhleUVVdDNoMHh3c1JnaXhMU3JjelJLTVdtREF6Y21XWW1H?=
 =?utf-8?B?RDNUS0oyQUpXbUJ3SVlNaWVMb09kNWtnYWlLZG5GdG5kNERyQXYvaXkyRGJZ?=
 =?utf-8?B?N3dRTHpaWmI3OTBZVW82TUlidEJGbkZTU0lCMmlhWk1ITkd6K0dabTlEYkc5?=
 =?utf-8?B?eDhVRWRQZ1JaVFlHZ1F4WEJKRkhncERXWEFYM2VQOXZ2VXlBbFBoaGhKb05I?=
 =?utf-8?B?L1laMm9xajBNMEhmWTc1bnpHU0tMdmNpUFJ6L09hbFZCTFB6ZytIZVNHTzdu?=
 =?utf-8?B?NXBpM2t6TWVzTHRpa2V1NC9iKy9vMUVYTk9kWU1SRzRPRStYK1Z4eG04RUNC?=
 =?utf-8?B?OVg5THJ6bkdtaGFWRE1QalJHNGJEVDliVkFIbGVFYnkveWhZQUMxMHpFY1c3?=
 =?utf-8?B?S1kvVU5KVmQzUHBJdXJVdVptUFV1T0tjZmNISDZZeVk4bi9TekM0WTVXdU9V?=
 =?utf-8?B?eVlwbXhEcFFueUJjYjZYcFFLMG05bTlwdFhrN3FDUkFqNTFabStnblo4MDl3?=
 =?utf-8?B?YVN1SElxTU9QZUI0WWtyOHlicVZmR2pQczdtbTBMQlJHUWtZRGpGTmsrZDNP?=
 =?utf-8?B?RzJ0QTJkY1U1UXBVY3VuSWtQMHRwSEZZZWxxb0VIRWtsbjJLeHcxQWUvWkdE?=
 =?utf-8?B?bThnaS9idy9qWlZlRnJrdjNreFZjVDBRd01LODJSSFUyVDB5SFJERWhZL2tI?=
 =?utf-8?B?NDdQcEdBc1Z1RnNENmxoMGZKZk5HUk4wRzV1dUFTQjRlcXRyWGZpcEY1L2tJ?=
 =?utf-8?B?T1VJcDVyWmJuVS9zdmFoaVBKd1hRTkQwY1ZqU3NxR2d6TFpxM3FKTVFwUTRC?=
 =?utf-8?B?Y1VsVzVpRXF1MDRGSE1zTDRxMXo2UnUzNDltS3FVbUVHdHl4YVNVa2duZ00x?=
 =?utf-8?B?MW8wUFh6QlR0cCtVdTUzTUR6bytCdkVFdGpKWVdNS1hOVEtJTGRFbktRMkRh?=
 =?utf-8?B?MnI5RHVyeXp1dkFVbDA3ZmpSbEthbmJ1WDY5UVlhcWdzMDRTcVhlcUVwYUh0?=
 =?utf-8?B?Qjh2dmF2cWFEbEY3QmIxRkJZL0VOZEJkNGVZS0M2ZjN5SEc0bTIxQXVqcEcv?=
 =?utf-8?B?QXhNRzR6WFFMTE1COU1waDNWVWE2alk5cW1jTnBiUE4xOEUyWmVFazRaNVlG?=
 =?utf-8?B?VEQ2ZFdPL3RkclpuZzg4QVlRRkdXZ0NkS2RoN21VNUVCSFZkSmhnWUQxdnhk?=
 =?utf-8?Q?jWMCKeejRBc7ZNEIbeAWuub4hcYT4yz6omd034R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78522de7-b5a2-4044-1dc6-08d9671f0fd8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:48:56.0191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZZjgZiSZmlC+5+Ot3gzXKcJuGNPkJwg3lgJot7vZLEoyNglCSffmB/NUZeyST5Jv2kieGbB3L/kL9NOsi3GOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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



On 2021-08-24 10:56 a.m., Kazlauskas, Nicholas wrote:
> On 2021-08-24 9:59 a.m., Simon Ser wrote:
>> Hi Rodrigo!
>>
>> Thanks a lot for your reply! Comments below, please bear with me: I'm
>> a bit familiar with the cursor issues, but my knowledge of AMD hw is
>> still severely lacking.
>>
>> On Wednesday, August 18th, 2021 at 15:18, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
>>
>>> On 08/18, Simon Ser wrote:
>>>> Hm. This patch causes a regression for me. I was using primary + overlay
>>>> not covering the whole primary plane + cursor before. This patch breaks it.
>>>
>>> Which branch are you using? Recently, I reverted part of that patch,
>>> see:
>>>
>>>    Revert "drm/amd/display: Fix overlay validation by considering cursors"
>>
>> Right. This revert actually makes things worse. Prior to the revert the
>> overlay could be enabled without the cursor. With the revert the overlay
>> cannot be enabled at all, even if the cursor is disabled.
>>
>>>> This patch makes the overlay plane very useless for me, because the primary
>>>> plane is always under the overlay plane.
>>>
>>> I'm curious about your use case with overlay planes. Could you help me
>>> to understand it better? If possible, describe:
>>>
>>> 1. Context and scenario
>>> 2. Compositor
>>> 3. Kernel version
>>> 4. If you know which IGT test describe your test?
>>>
>>> I'm investigating overlay issues in our driver, and a userspace
>>> perspective might help me.
>>
>> I'm working on gamescope [1], Valve's gaming compositor. Our use-cases include
>> displaying (from bottom to top) a game in the background, a notification popup
>> over it in the overlay plane, and a cursor in the cursor plane. All of the
>> planes might be rotated. The game's buffer might be scaled and might not cover
>> the whole CRTC.
>>
>> libliftoff [2] is used to provide vendor-agnostic KMS plane offload. In other
>> words, I'd prefer to avoid relying too much on hardware specific details, e.g.
>> I'd prefer to avoid hole-punching via a underlay (it might work on AMD hw, but
>> will fail on many other drivers).
> 
> Hi Simon,
> 
> Siqueria explained a bit below, but the problem is that we don't have dedicated cursor planes in hardware.
> 
> It's easiest to under the hardware cursor as being constrained within the DRM plane specifications. Each DRM plane maps to 1 (or 2) hardware pipes and the cursor has to be drawn along with it. The cursor will inherit the scale, bounds, and color management associated with the underlying pipes.
> 

To elaborate on this a bit more, each HW plane's scanout engine
has the ability to scan out a cursor, in addition to the plane's
framebuffer. This cursor is drawn onto the plane at the scanout
phase. Any further scaling, color processing, or other operation
on the pipe will equally apply to the cursor as to the framebuffer
itself.

Our driver will look at the cursor position and place the cursor
with the topmost HW plane at that position.

> From the kernel display driver perspective that makes things quite difficult with the existing DRM API - we can only really guarantee you get HW cursor when the framebuffer covers the entire screen and it is unscaled or matches the scaling expected by the user.
> 
> Hole punching generally satisfies both of these since it's a transparent framebuffer that covers the entire screen.
> 
> The case that's slightly more complicated is when the overlay doesn't cover the entire screen but the primary plane does. We can still enable the cursor if the primary plane and overlay have a matching scale and color management - our display hardware can draw the cursor on multiple pipes. (Note: this statement only applies for DCN2.1+)
> 
> If the overlay plane does not cover the entire screen and the scale or the color management differs then we cannot enable the HW cursor plane. As you mouse over the bounds of the overlay you will see the cursor drawn differently on the primary and overlay pipe.
> 
> If the overlay plane and primary plane do not cover the entire screen then you will lose HW cursor outside of the union of their bounds.
> 
> Correct me if I'm wrong, but I think your usecase [1] falls under the category where:
> 1. Primary plane covers entire screen
> 2. Overlay plane does not cover the entire screen
> 3. Overlay plane is scaled
> 

If I understood Simon right the primary plane (bottom-most,
game plane) might not cover the entire screen, which is fine.

Is the Steam overlay always the size of the crtc, or does it
match the size of the game plane, or is it unrelated to either?

If the overlay is covering the entire screen and always active
you should be good. If the overlay appears and disappears the
cursor drawing would switch between the overlay and the game
plane.

> This isn't a support configuration because HW cursor cannot be drawn in the same position on both pipes.
> 
> I think you can see a similar usecase to [1] on Windows, but the difference is that the cursor is drawn on the "primary plane" instead of on top of the primary and overlay. I don't remember if DRM has a requirement that the cursor plane must be topmost, but we can't enable [1] as long as it is.
> 
> I don't know if you have more usecases in mind than [1], but just as some general recommendations I think you should only really use overlays when they fall under one of two categories:
> 
> 1. You want to save power:
> 
> You will burn additional power for the overlay pipe.
> 
> But you will save power in use cases like video playback - where the decoder produces the framebuffer and we can avoid a shader composited copy with its associated GFX engine overhead and memory traffic.
> 
> 2. You want more performance:
> 
> You will burn additional power for the overlay pipe.
> 
> On bandwidth constrained systems you can save significant memory bandwidth by avoiding the shader composition by allowing for direct scanout of game or other application buffers.
> 
> Your usecase [1] falls under this category, but as an aside I discourage trying to design usecases where the compositor requires the overlay for functional purposes.
> 
> Best regards,
> Nicholas Kazlauskas
> 
>>
>> I'm usually using the latest kernel (at the time of writing, v5.13.10), but I
>> often test with drm-tip or agd5f's amd-staging-drm-next, especially when
>> working on amdgpu patches.
>>
>> My primary hardware of interest is RDNA 2 based (the upcoming Steam Deck), but
>> of course it's better if gamescope can run on a wide range of hardware.
>>
>> I don't know if there's an IGT covering my use-case.
>>
>> [1]: https://github.com/Plagman/gamescope>>> [2]: https://github.com/emersion/libliftoff>>>
>>>>> Basically, we cannot draw the cursor at the same size and position on
>>>>> two separated pipes since it uses extra bandwidth and DML only run
>>>>> with one cursor.
>>>>
>>>> I don't understand this limitation. Why would it be necessary to draw the
>>>> cursor on two separate pipes? Isn't it only necessary to draw it once on
>>>> the overlay pipe, and not draw it on the primary pipe?
>>>
>>> I will try to provide some background. Harry and Nick, feel free to
>>> correct me or add extra information.
>>>
>>> In the amdgpu driver and from the DRM perspective, we expose cursors as
>>> a plane, but we don't have a real plane dedicated to cursors from the
>>> hardware perspective. We have part of our HUPB handling cursors (see
>>> commit "drm/amd/display: Add DCN3.1 DCHHUB" for a hardware block
>>> overview), which requires a different way to deal with the cursor plane
>>> since they are not planes in the hardware.
>>
>> What are DCHUBBUB and MMHUBBUB responsible for? Is one handling the primary
>> plane and the other handling the overlay plane? Or something else entirely?
>>

MMHUBBUB > DCHUBBUB > HUBP (for each pipe)

MMHUBBUB is irrelevant if DWB (display writeback) is not used. DWB is not
enabled in the driver.

DCHUBBUB is the overall scanout engine for all DC pipes and includes a
HUBP per pipe.

HUBP will have requestors for the primary framebuffer, DCC meta, dynamic
metadata (for things like Dolby HDR, though it's not fully implemented),
and cursor data.

Harry

>>> As a result, we have some
>>> limitations, such as not support multiple cursors with overlay; to
>>> support this, we need to deal with these aspects:
>>
>> Hm, but I don't want to draw multiple cursors. I want to draw a single
>> cursor. If all planes are enabled, can't we paint the cursor only on the
>> overlay plane and not paint the cursor on the primary plane?
>>
>> Or maybe it's impossible to draw the cursor on the overlay plane outside
>> of the overlay plane bounds?
>>
>> I'm also confused by the commit message in "drm/amd/display: Fix two cursor
>> duplication when using overlay", because an overlay which doesn't cover the
>> whole CRTC used to work perfectly fine, even with the cursor plane enabled.
>>
>>> 1. We need to make multiple cursor match in the same position and size.
>>> Again, keep in mind that cursors are handled in the HUBP, which is the
>>> first part of our pipe, and it is not a plane.
>>>
>>> 2. Fwiu, our Display Mode Library (DML), has gaps with multiple cursor
>>> support, which can lead to bandwidth problems such as underflow. Part of
>>> these limitations came from DCN1.0; the new ASIC probably can support
>>> multiple cursors without issues.
>>>
>>> Additionally, we fully support a strategy named underlay, which inverts
>>> the logic around the overlay. The idea is to put the DE in the overlay
>>> plane covering the entire screen and the other fb in the primary plane
>>> behind the overlay (DE); this can be useful for playback video
>>> scenarios.
>>
>> Yeah, as I said above this requires knowing a lot about the target hardware,
>> which is a bit unfortunate. This requires hole-punching and significantly
>> changes the composition logic.
>>
> 

