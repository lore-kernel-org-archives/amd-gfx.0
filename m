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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2ABC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 15:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 425CA61246
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 15:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 425CA61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F9D8966C;
	Tue, 24 Aug 2021 15:11:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF948966C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 15:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P046mbO7MXpt2VCfAMT5dn25KLdgXzYGx7Mr/k/gyDo5AZ13wDEGuYLREMa8lLL7ao+7Yxn0/Fmo3GrcLhXNCW3c0DeBm6W4FfRc83MktJvVTrF8RJfi1Dae56EjJ1IJeyT30A2Y+wXXMyrY3WawRgVuL37o0D8w6G0WD3ipvOFtb4WZU/WQZuIWyv/pFvwOc1r74yxlbPoyR2qHSENjAVAJ9NIktUnITGvv/mMR+3yLJ2Mse38Yf1cwf/Id91xBVDE39JSsGaxq2013zbuZsTKs9zXQmBcLQn58kPHKT4FJZCX7B7Ry3hd34i3Uej1XoSvUlnjCTtF8cVcg1I3n4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChMBGWL224EPez4N8/tE8DmcSnCOFD5gdyRqOXdUgko=;
 b=e5hBQJpRm+F4GYIFGVfIyPOu7bh8FYWDBQ9dDLJBQLHDpnwRzHQFVflSurGTZ4B5yh5eKyXItGQBaK3bRhr33Gr/FVOYKJ60H3isnIcgVbCSjmYACLomqhhT0HlwT/q6aqaRfwyNDVKUyagIiJSodIuPvGYnNDMZyO6JczWRpfxqU4Z6tIkn5nN+UDt7+aJH7SAM/YEOBcvmkJpV7+meQBkLDwjf0pU9IiJF/6GEEeI9Jv2jMAKtCTgAjfxjQkZCsd8qSYx4ZwBIAwBFk5fKJ54AIx54MmlHe1p/aAyxgFrwnSVMiZ/HQpsad7uTazwsxw+cvtn6Sltxox+LDAMuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChMBGWL224EPez4N8/tE8DmcSnCOFD5gdyRqOXdUgko=;
 b=TGx6i9OAgkn8t0cMtNSHUnyQC4Dc5fLzvJ5/GlJhmdz2hZmAqjKxblDtqouLfzXvSYeWAJUuoOjLgo671mAXNYbN5OQOUsLdO5ddAUsQ2CzjdR6Eb3xDSjONiazhOBXuMi/r0631AvL8adwJeJfa/Wv7NQIvusy5LdweaP/iaZc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 14:56:56 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::812c:c10a:1b16:6e71]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::812c:c10a:1b16:6e71%5]) with mapi id 15.20.4457.017; Tue, 24 Aug 2021
 14:56:56 +0000
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
To: Simon Ser <contact@emersion.fr>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
 Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
 <20210818131824.avczlw6ie3tfs76j@outlook.office365.com>
 <Hm33HvRokytajvNBSyeseBTVWScQu0mPJVLvRcABYsahB6j3DjJwvelk-WgnIA2AlG1AU0wnGV3gvAgzDf5nmWYRjIS58gMjtdrG0m_kjhA=@emersion.fr>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <ffd29136-d0e3-17a9-f01f-e81c44ae0284@amd.com>
Date: Tue, 24 Aug 2021 10:56:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <Hm33HvRokytajvNBSyeseBTVWScQu0mPJVLvRcABYsahB6j3DjJwvelk-WgnIA2AlG1AU0wnGV3gvAgzDf5nmWYRjIS58gMjtdrG0m_kjhA=@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.16.161] (165.204.54.211) by
 YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Tue, 24 Aug 2021 14:56:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a57b215e-70e3-4b14-5c00-08d9670f6a92
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5360EE2AF14DE3026415626CECC59@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SANrY+mSEYAIeFlfha2CxULSak785f/RfvdSGyeIs/E3JivKSeBT0y1TPGpr3and1Hoag5CD8M0a2Y5dJDUbDQvDeocLhMeMm4kau03gRhgzBRjhhxlLC2ItMkk4EWCF+P3bi5vdobDR+ev+J4JjVzKnOCQ6FMUEgx519f1pA5QRYNmBu0dQzPtbkZ+wYobfcyXm3i4uclYbGNefn7pEDEQ0Aj97LVrKbJY3AyWqjZ2vhqRJTf+ByZGfwNK/fx06EVVgUhRKXuS11UnF0K2pG9MQmGLOFgvDrCmSATMTTc4V4ApaKXa4e4h2nfqCOjvi9ECPjudTU028peB7qgnuiRmgBAMNWkJrauQGIfCGtyS1adp1QSCJd0Dnmo6xQk7jx0ykdu7uBZbLGrEBw4rEcEZGbvCakzWpoKBFfvEgAd4jOY43HS0QsVuEUT0spX6V8S+jG0xAXkQj8ODUt6yIxwMELEdePPAupR4bseN6ep6twKawbzM+9F9opGUSrcqo0ZmF7fuTTw3lYSMrXQzKDlu5wbsroeSBiM0ooi+nZ9clT1cgc5NGvZHHvFOntU0z4krkGusF+L/hSmRn+eFfRnHXjcGwKUjxl857CD0qCjlWavVkFeuYhnun5mOH7nQRappFh5o+5U+9cx6+5jIgDxEmACY/edTLsRKrlVRhHEJb6eFwyi/2+GmCIhAXdtj8f4HWHsP7d9wez2WQVi+0kD/kstgGDRCGz8+4CFQ2FJWnpAEA3VeJzkNRAFEzsb4DbxUd04maU06Vr25bVUkKt5vBltF+Lf1rz3C+el8C/pRda3Tjr6d9hRsnZpHd+QBWOaJGB+Ea9Gey9wZSY7ewLWVrIrHU+3aGt89/rPvN6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(36756003)(4326008)(54906003)(16576012)(966005)(478600001)(956004)(8676002)(316002)(26005)(8936002)(6636002)(2616005)(38100700002)(31686004)(5660300002)(110136005)(45080400002)(31696002)(6486002)(2906002)(53546011)(66946007)(86362001)(6666004)(66476007)(66556008)(83380400001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JSYU84SzB0UFJLbW9oVzVhOFJHZUZ2cGFZZkJvTGwxTG5FRGgxODBGTzVV?=
 =?utf-8?B?RXRGM0YrUGxBRHlHZndhQ2RwWHRWMkRjWkI2ajZvRnFoS1NuR2VzcnNuaEFH?=
 =?utf-8?B?bkRBZ3NZVzVCckZZVmJjSnQzNGVyUTZLd1VHNktyRlF3RVR1OE9QWjRYaE4v?=
 =?utf-8?B?WmppTGZ0ZWtQcEZVYkdqOG1ENFc0MFRuQ0dVTEVoNXNFQVlocURMcFFZZlVJ?=
 =?utf-8?B?YklqTUc3OG02QlpjN3Fmci8vQzZMRE5mb2R5OUFmTnpjU1ZoRU91dXRXOTEz?=
 =?utf-8?B?Nit1OWhYK284cDFUVHNORE9jTlErcU9TVE5UU1AyV1BTREhCSlpnRmpQRUtZ?=
 =?utf-8?B?bmRiS0RnYXVEa05RWXc5LzFaQmpsL01XbC9rTjVJMDgyUkFZMmN0WmF6NmV0?=
 =?utf-8?B?SU05V1ZZd0ZJb2o5czBaK1MveVJReS8vaFljY0liMDNBamVlTHpGZzNoTStL?=
 =?utf-8?B?K2pWbnpZS1FkeGxSZUt5UUxwejFEdk9uTEhIT2ZkNkRPdUFSQWtPelJKemlt?=
 =?utf-8?B?akNoWEJSOExCeVVXT01hb2NJeGpmb3U3c3pmUEZQUzBtQ2lucDUyZHdqTWIv?=
 =?utf-8?B?Rm92dWllLzZDNThtQ1R0ajcxNFBNdEdjeGllOWNValhhSnBGZHVPMGtsY1Nw?=
 =?utf-8?B?bnJ5cW5mOVQvc1h5Vm9uNHhRZTdlZE1ML01QaDVYTEswWnl2eUQ1cFBJd0lv?=
 =?utf-8?B?T2VETC9qd3dHYU5VcUVRRUxic0NvNTFwUG5mQmhhdVRZMEUvSHNuMGdLckli?=
 =?utf-8?B?aVNhQnRzL3BYV0kyK1VWN0xrOE0rcFdoc0lleXBzRHJjaWlxK3VsSzBXR3dh?=
 =?utf-8?B?aUZpbjZjK1N1VFdNWG1PMzVldkV6aTNYMFhUdTN0c0gvTitTQkxCdmJKMCtI?=
 =?utf-8?B?cmlWR1JpSGRUOHgybGJqNWZRTmRySklGelhpZU9yTGh0a0xLMzJwZ1dINWwx?=
 =?utf-8?B?eVd2eWlqaWxpbm9yYlo5aGpwSFdQTlBSbEJVenJBcWdzOXNHeSt5SHdGV2xo?=
 =?utf-8?B?S0RFZnE1a2hBNE12K0hEOEFkM2dJN3dHRGJuSW91K0NUSVhURExSMEpyb2lN?=
 =?utf-8?B?VzdXMkg5aWhRMWZaVjBMYmE1UG5GQW4wc1NoUi94OGJ1NWdES1JiS2I2QzV2?=
 =?utf-8?B?bm9EeDZ0djAyRytaby9JMDZIL2R0VmdLYU40dWozY01lb3oxRzR2TlU3M3Vk?=
 =?utf-8?B?MkNOaXIyQTEzbXh0NGhxaHV3RzJHanVJNXhGNG51YzRIb0tiWGxxZ01aa3Vs?=
 =?utf-8?B?cHZrTEVDNk53c1ZmNitvZkdxYWhQVG5hVlNJN2hiMW11REMxR00xOGNNVUxD?=
 =?utf-8?B?RE82NzdnYmVpSTlCdllVZXBDNUlERzhjZG9aRzVWbVdEWHVQUlUvbmphVnBN?=
 =?utf-8?B?SDc3TzlRSmYyQ1I2TWtxM2Z2ZnBnRDl3OWx3c0ZTQ0xYS0pCZ3ZZWGhITDV3?=
 =?utf-8?B?UFc0OGt1Y3crZTQxc084UWFFenJudlkwVEhnaXZaSkh5RFVLN2NhOFg5ZVBR?=
 =?utf-8?B?aGZzN0dEK3Z1N3hEejVaNE5IWGJrSVllK0syWEsxU3hhSlg1K2RWNXQ5U0l2?=
 =?utf-8?B?aklDSXhxNkY0dGlCVHkrcFIxeVJ4R09BN0k4QWgrZDRGMVRMc0UrYWxDTFQv?=
 =?utf-8?B?ZFQ3WFY2b1NVM0FRUkgvS0R4L1RuS3lHZkI4L0tFZjRjSjdMblY1blkvVU9K?=
 =?utf-8?B?OG54UnpkS2hySHdJWHlxZW40R1krbjRWVkZJdGcvS0dTdnB2YU5nc1ArR1M5?=
 =?utf-8?Q?oxMew6UiGCl1il1GHqCEAK7LajOTpqiN2qX++4R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57b215e-70e3-4b14-5c00-08d9670f6a92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 14:56:56.1804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm5kH3ByvAZr7JoH+jU9PZQGfvsyUuecTgXos74fwVqYV3RPJ6q9LryTfqFwz5pJeM0m1sbwhe81AKxES8lNqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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

On 2021-08-24 9:59 a.m., Simon Ser wrote:
> Hi Rodrigo!
> 
> Thanks a lot for your reply! Comments below, please bear with me: I'm
> a bit familiar with the cursor issues, but my knowledge of AMD hw is
> still severely lacking.
> 
> On Wednesday, August 18th, 2021 at 15:18, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
> 
>> On 08/18, Simon Ser wrote:
>>> Hm. This patch causes a regression for me. I was using primary + overlay
>>> not covering the whole primary plane + cursor before. This patch breaks it.
>>
>> Which branch are you using? Recently, I reverted part of that patch,
>> see:
>>
>>    Revert "drm/amd/display: Fix overlay validation by considering cursors"
> 
> Right. This revert actually makes things worse. Prior to the revert the
> overlay could be enabled without the cursor. With the revert the overlay
> cannot be enabled at all, even if the cursor is disabled.
> 
>>> This patch makes the overlay plane very useless for me, because the primary
>>> plane is always under the overlay plane.
>>
>> I'm curious about your use case with overlay planes. Could you help me
>> to understand it better? If possible, describe:
>>
>> 1. Context and scenario
>> 2. Compositor
>> 3. Kernel version
>> 4. If you know which IGT test describe your test?
>>
>> I'm investigating overlay issues in our driver, and a userspace
>> perspective might help me.
> 
> I'm working on gamescope [1], Valve's gaming compositor. Our use-cases include
> displaying (from bottom to top) a game in the background, a notification popup
> over it in the overlay plane, and a cursor in the cursor plane. All of the
> planes might be rotated. The game's buffer might be scaled and might not cover
> the whole CRTC.
> 
> libliftoff [2] is used to provide vendor-agnostic KMS plane offload. In other
> words, I'd prefer to avoid relying too much on hardware specific details, e.g.
> I'd prefer to avoid hole-punching via a underlay (it might work on AMD hw, but
> will fail on many other drivers).

Hi Simon,

Siqueria explained a bit below, but the problem is that we don't have 
dedicated cursor planes in hardware.

It's easiest to under the hardware cursor as being constrained within 
the DRM plane specifications. Each DRM plane maps to 1 (or 2) hardware 
pipes and the cursor has to be drawn along with it. The cursor will 
inherit the scale, bounds, and color management associated with the 
underlying pipes.

 From the kernel display driver perspective that makes things quite 
difficult with the existing DRM API - we can only really guarantee you 
get HW cursor when the framebuffer covers the entire screen and it is 
unscaled or matches the scaling expected by the user.

Hole punching generally satisfies both of these since it's a transparent 
framebuffer that covers the entire screen.

The case that's slightly more complicated is when the overlay doesn't 
cover the entire screen but the primary plane does. We can still enable 
the cursor if the primary plane and overlay have a matching scale and 
color management - our display hardware can draw the cursor on multiple 
pipes. (Note: this statement only applies for DCN2.1+)

If the overlay plane does not cover the entire screen and the scale or 
the color management differs then we cannot enable the HW cursor plane. 
As you mouse over the bounds of the overlay you will see the cursor 
drawn differently on the primary and overlay pipe.

If the overlay plane and primary plane do not cover the entire screen 
then you will lose HW cursor outside of the union of their bounds.

Correct me if I'm wrong, but I think your usecase [1] falls under the 
category where:
1. Primary plane covers entire screen
2. Overlay plane does not cover the entire screen
3. Overlay plane is scaled

This isn't a support configuration because HW cursor cannot be drawn in 
the same position on both pipes.

I think you can see a similar usecase to [1] on Windows, but the 
difference is that the cursor is drawn on the "primary plane" instead of 
on top of the primary and overlay. I don't remember if DRM has a 
requirement that the cursor plane must be topmost, but we can't enable 
[1] as long as it is.

I don't know if you have more usecases in mind than [1], but just as 
some general recommendations I think you should only really use overlays 
when they fall under one of two categories:

1. You want to save power:

You will burn additional power for the overlay pipe.

But you will save power in use cases like video playback - where the 
decoder produces the framebuffer and we can avoid a shader composited 
copy with its associated GFX engine overhead and memory traffic.

2. You want more performance:

You will burn additional power for the overlay pipe.

On bandwidth constrained systems you can save significant memory 
bandwidth by avoiding the shader composition by allowing for direct 
scanout of game or other application buffers.

Your usecase [1] falls under this category, but as an aside I discourage 
trying to design usecases where the compositor requires the overlay for 
functional purposes.

Best regards,
Nicholas Kazlauskas

> 
> I'm usually using the latest kernel (at the time of writing, v5.13.10), but I
> often test with drm-tip or agd5f's amd-staging-drm-next, especially when
> working on amdgpu patches.
> 
> My primary hardware of interest is RDNA 2 based (the upcoming Steam Deck), but
> of course it's better if gamescope can run on a wide range of hardware.
> 
> I don't know if there's an IGT covering my use-case.
> 
> [1]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FPlagman%2Fgamescope&amp;data=04%7C01%7CNicholas.Kazlauskas%40amd.com%7C0a5e1d2ce0874a87929e08d96707743a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654104020179511%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PCliYWadIaVDDnEQUOONNo%2FmC2ieIMjUw9Zr4XP3XDM%3D&amp;reserved=0
> [2]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Femersion%2Flibliftoff&amp;data=04%7C01%7CNicholas.Kazlauskas%40amd.com%7C0a5e1d2ce0874a87929e08d96707743a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654104020179511%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=q4NCvqFpwdSXVnBcBSdxCYII44ekOiQBWTe9SUDhFUo%3D&amp;reserved=0
> 
>>>> Basically, we cannot draw the cursor at the same size and position on
>>>> two separated pipes since it uses extra bandwidth and DML only run
>>>> with one cursor.
>>>
>>> I don't understand this limitation. Why would it be necessary to draw the
>>> cursor on two separate pipes? Isn't it only necessary to draw it once on
>>> the overlay pipe, and not draw it on the primary pipe?
>>
>> I will try to provide some background. Harry and Nick, feel free to
>> correct me or add extra information.
>>
>> In the amdgpu driver and from the DRM perspective, we expose cursors as
>> a plane, but we don't have a real plane dedicated to cursors from the
>> hardware perspective. We have part of our HUPB handling cursors (see
>> commit "drm/amd/display: Add DCN3.1 DCHHUB" for a hardware block
>> overview), which requires a different way to deal with the cursor plane
>> since they are not planes in the hardware.
> 
> What are DCHUBBUB and MMHUBBUB responsible for? Is one handling the primary
> plane and the other handling the overlay plane? Or something else entirely?
> 
>> As a result, we have some
>> limitations, such as not support multiple cursors with overlay; to
>> support this, we need to deal with these aspects:
> 
> Hm, but I don't want to draw multiple cursors. I want to draw a single
> cursor. If all planes are enabled, can't we paint the cursor only on the
> overlay plane and not paint the cursor on the primary plane?
> 
> Or maybe it's impossible to draw the cursor on the overlay plane outside
> of the overlay plane bounds?
> 
> I'm also confused by the commit message in "drm/amd/display: Fix two cursor
> duplication when using overlay", because an overlay which doesn't cover the
> whole CRTC used to work perfectly fine, even with the cursor plane enabled.
> 
>> 1. We need to make multiple cursor match in the same position and size.
>> Again, keep in mind that cursors are handled in the HUBP, which is the
>> first part of our pipe, and it is not a plane.
>>
>> 2. Fwiu, our Display Mode Library (DML), has gaps with multiple cursor
>> support, which can lead to bandwidth problems such as underflow. Part of
>> these limitations came from DCN1.0; the new ASIC probably can support
>> multiple cursors without issues.
>>
>> Additionally, we fully support a strategy named underlay, which inverts
>> the logic around the overlay. The idea is to put the DE in the overlay
>> plane covering the entire screen and the other fb in the primary plane
>> behind the overlay (DE); this can be useful for playback video
>> scenarios.
> 
> Yeah, as I said above this requires knowing a lot about the target hardware,
> which is a bit unfortunate. This requires hole-punching and significantly
> changes the composition logic.
> 

