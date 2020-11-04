Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8BBC2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 14:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2A5206FA
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 14:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dqAPck6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2A5206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE65D6E153;
	Wed,  4 Nov 2020 14:31:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770048.outbound.protection.outlook.com [40.107.77.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27AFA6E053
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 14:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlC8b4/HnFAppD4JGjd97okLtS4RV+XR/ooqGgayG+J3xkcWCBQ5lHRyVZhP2RraQ5mzFdAEsQhNGJ04kTBPAfByNcb/m6hjyLIBw2MrLo2CwBH8/pC3LeVqsbSvNYVBLTwfoRYFgV0NF+O/FgeXG6Qf/svQJGkucYTXmdQGTh8huLzwByyOvKojD3XTsmapuMlAYQ3d5Wwfz1a4tuP3M9KZCOnD7SaFa7MMWz1Fh/XK74Hj+W6krcMbUH3gQIervW7ozYP6fSTo8+dX4ZpszpRs3G8VhuGiQBs7aAw8L8xCRxu66uaRrP5JEuDhv1qeRlWgVSbC9Ffy5oV2EEcdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2o+ZBrAjk480nPcwwWwUzn/pJDlrAqIQ7IfiGt9Z5M=;
 b=WjZZZE/XdC0b+QU+U6h1lgNzltbPYv/XZccIYUZs4Nxro6x8jQHJtfegk56DsOOcdSACXFijpHwazpy0p/2407I0Ji3mCKxOTC/RYwEI1UhN/cMnk6nl1lwWrIp3oMyZW1vITaqzPCSIWDgQ4Cjs4/aMy8oAN0hX6H+c5oh0rdAg3hp7SYRhzVrugm3iAq/9hixMGO8zXsFjNf0/Bys5DTBSvA724pFJXt721r2FbbEDjiQEvJ2Wc1de5C66/lI2xO2B6b6vphbN6wLcL9q/noz0oYnDMnjcbHkqSZX73mBk1hzpVo3RCj5C0jYiZ/5p2TYmzLFyWtsfiCa7QLTOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2o+ZBrAjk480nPcwwWwUzn/pJDlrAqIQ7IfiGt9Z5M=;
 b=dqAPck6KAdZRorTjK2ZD4f+4Ddyn2Y4QYza6PaaRtXokPhsSSYKU+2YEjVtSvcZTbNs6Ytx4UWPkBcm1ai+BDO8ILSmgRPdgPxpt3Pw3sead3NkismV0Q888ElibLJBEmZ23bsvxnl+q1TQ5wTaJxwcegc0oo87kQedpScKbAkM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 14:31:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 14:31:20 +0000
Subject: Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201103171340.2978395-1-shashank.sharma@amd.com>
 <7f9cc1a0-ad6b-ee9b-ac7b-4a49d08de1f9@amd.com>
 <MN2PR12MB3133BFD54B552B19A512B27CF2EF0@MN2PR12MB3133.namprd12.prod.outlook.com>
 <211bb89a-4433-3fb8-7849-6323cafe20fb@amd.com>
 <MN2PR12MB448848FEEB5717DDCF66F601F7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <b6e345a7-5547-2026-313c-739833c5013f@amd.com>
 <MN2PR12MB4488278FB8B457603F1B955CF7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b326cc56-5374-8e35-9492-7ed82225030b@amd.com>
Date: Wed, 4 Nov 2020 15:31:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB4488278FB8B457603F1B955CF7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:205::17)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:205::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 14:31:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2f33b29-dcfa-4eb2-73ee-08d880ce4bf7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4126DB9EE5F13A86DFF17DD983EF0@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDPMCZjaauWBw8WsTKVUX8OdQnudn31Fpkv8RWS91Hu7FaKlmS9LwrbJnh3wfsj6R3TvqdgZkxGdoTq0iUIkJjwnLaP4YfAPgEIDw5DgeJjj4tZWnvWKheWQhZ6hiEJILaDjEAd3ERBhB/Y60V/Q1hq1/TeyU4UR1AFB/xYd8ZG/QF9lw6M7hkbB6OpnC/Mr43LOiVQ39KzH0h8ES/19fsdWT/tyaVwVLDuxbppjvahIHIr1fZbQGm1+n0DlAT9LzhYnOgvW871IB89e7YT4mqn/DgXNbSz+j+rn1H72XVlZHzbxAUJ1XA2C4K/gjOFK+QicHb/XUN6E1hch31IrZuBPX7sKODZv1vCyQwyRE0FAiI0mxBNeQJy0vNao4NrulW3OCtMc3E0Ijbx5JKNFRkL5POrNyFmf1aNCAzt55vR6JExW3cvzegEOvMnsuMDU0Ry8VCYBMO/ILsl5IYfgZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(86362001)(2906002)(110136005)(52116002)(316002)(33964004)(966005)(83380400001)(66574015)(30864003)(186003)(5660300002)(478600001)(6486002)(19627405001)(66476007)(6666004)(4326008)(66556008)(16526019)(8936002)(166002)(8676002)(36756003)(31686004)(66946007)(31696002)(53546011)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j5DD7r3mOBAsmTq9sPwmXGwR8sOKtvVPjYU0Tw93mg9Z0Lng4/Ywcm1HrXaARmUJ58gGAZGjGHY63du4oI3D3zXhGoiTslvfC6/OxiLOydXHvt7WVVNSCQf8PNnVzcc5DDnu8euueFAWi/RlHBy3XAH42JjSLkUAhufaevRv1iFfDiKDypCLb1V0E5pkP39sitOeKasvaG+xFBnmW3mJKA4mcdYgaiiu62tKiE2BSMNRW4e3t+A2dtS6iO4LVZEHMMMCC52ZBAQvvoDGAQbMS86q9HbVMmDAJPWuLfau3NgAy/t86n5X4rijSGRQBlrtZ3e0/9h6WATnC1jOTCQJLZNil3jMTQF69Ve7OF2UgQ6wR4QSwSzJOwsaEm0ipQ4b2VbnOaNK4zLBGuc2uBvc0jHcPjukf4plmx1QR4wpCwHvt/414ACVncKAld87L7Ltl0s5z3aFetLUz5TdTr1d4Cl3Es5KIsWMSV+GR3Po+ofk4oaet4ZNWaWyk/cH525KpJ1V7yhCgARKWP1933XCSqSEnJz//4vbpft1X0E2eUvI/EZac+wKlxRG95kf2e4Ju1BuTnkbpJ9pi9z3z9kHYiI2ryePemKLxCEPVvJ7pLck6s8bzf9q3GUVcI+IJQ9pJJkTjScUU0hmnRF89XaDHazH+/rcNcTBLLFl1BtMyp+tbxf3jflzy6Bx6CjhaRNGff+70eErrL6PNzYi2FpQpA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f33b29-dcfa-4eb2-73ee-08d880ce4bf7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 14:31:20.3409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z2ah+s+ReWL0g7+LWoJmhq+xa4+ADI5UNSYEaSldMqX5Njb5RgFTcHVjjLdq780
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: "Qin, Eddy" <Eddy.Qin@amd.com>
Content-Type: multipart/mixed; boundary="===============1634504997=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1634504997==
Content-Type: multipart/alternative;
 boundary="------------C6F7CC715A5B79075683689D"
Content-Language: en-US

--------------C6F7CC715A5B79075683689D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

In the long term we probably want to nuke this code anyway and switch to 
the DC code, don't we?

Christian.

Am 04.11.20 um 15:23 schrieb Deucher, Alexander:
> You might want to talk to the DAL team, they may have some advice.  In 
> general, I would say test it as well as you can. It's probably safe as 
> radeon is still the default driver for SI parts and generally seems to 
> be working well there.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Sharma, Shashank <Shashank.Sharma@amd.com>
> *Sent:* Wednesday, November 4, 2020 9:11 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Qin, Eddy <Eddy.Qin@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
>
> Thanks Alex, Same question here,
>
> Should we go through some extensive test routine due to change in PLL 
> values, or is it OK to go ahead based on our experience from Radeon 
> values ?
>
>
> Regards
>
> Shashank
>
>
> On 04/11/20 7:36 pm, Deucher, Alexander wrote:
>> Acked-by: Alex Deucher <alexander.deucher@amd.com> 
>> <mailto:alexander.deucher@amd.com>
>> ------------------------------------------------------------------------
>> *From:* Koenig, Christian <Christian.Koenig@amd.com> 
>> <mailto:Christian.Koenig@amd.com>
>> *Sent:* Wednesday, November 4, 2020 6:54 AM
>> *To:* Sharma, Shashank <Shashank.Sharma@amd.com> 
>> <mailto:Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com> 
>> <mailto:Alexander.Deucher@amd.com>; Qin, Eddy <Eddy.Qin@amd.com> 
>> <mailto:Eddy.Qin@amd.com>
>> *Subject:* Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
>> Am 04.11.20 um 11:40 schrieb Sharma, Shashank:
>> > [AMD Public Use]
>> >
>> > Hello Christian,
>> > Yes, that 100 is hardcoded in Radeon, and git blame says it was one 
>> of your patches which made it 100 from 128 😊.
>> > Would you mind having a look at commit id: 
>> 4b21ce1b4b5d262e7d4656b8ececc891fc3cb806 ?
>>
>> Ah, yes that one :)
>>
>> Yeah the background is that this was just an educated guess because I
>> couldn't find anybody which could tell me what the real limits of the
>> PLL is.
>>
>> Looks like we just forgot to apply that patch to amdgpu.
>>
>> Regards,
>> Christian.
>>
>> >
>> > Regards
>> > Shashank
>> > -----Original Message-----
>> > From: Koenig, Christian <Christian.Koenig@amd.com> 
>> <mailto:Christian.Koenig@amd.com>
>> > Sent: Wednesday, November 4, 2020 3:35 PM
>> > To: Sharma, Shashank <Shashank.Sharma@amd.com> 
>> <mailto:Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org>
>> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com> 
>> <mailto:Alexander.Deucher@amd.com>; Qin, Eddy <Eddy.Qin@amd.com> 
>> <mailto:Eddy.Qin@amd.com>
>> > Subject: Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
>> >
>> > Am 03.11.20 um 18:13 schrieb Shashank Sharma:
>> >> This patch limits the ref_div_max value to 100, during the calculation
>> >> of PLL feedback reference divider. With current value (128), the
>> >> produced fb_ref_div value generates unstable output at particular
>> >> frequencies. Radeon driver limits this value at 100.
>> > Mhm, is that 100 hard coded in radeon? I have no idea where that is 
>> coming from.
>> >
>> > Best would probably to grab a hardware engineer and try to figure 
>> out what the real maximums for the PLL is to still produce a stable 
>> signal.
>> >
>> > Christian.
>> >
>> >> On Oland, when we try to setup mode 2048x1280@60 (a bit weird, I
>> >> know), it demands a clock of 221270 Khz. It's been observed that the
>> >> PLL calculations using values 128 and 100 are vastly different, and
>> >> look like this:
>> >>
>> >> +------------------------------------------+
>> >> |Parameter    |AMDGPU        |Radeon       |
>> >> |             |              |             |
>> >> +-------------+----------------------------+
>> >> |Clock feedback              |             |
>> >> |divider max  |  128         |   100       |
>> >> |cap value    |              |             |
>> >> |             |              |             |
>> >> |             |              |             |
>> >> +------------------------------------------+
>> >> |ref_div_max  |              |             |
>> >> |             |  42          |  20         |
>> >> |             |              |             |
>> >> |             |              |             |
>> >> +------------------------------------------+
>> >> |ref_div      |  42          |  20         |
>> >> |             |              |             |
>> >> +------------------------------------------+
>> >> |fb_div       |  10326       |  8195       |
>> >> +------------------------------------------+
>> >> |fb_div       |  1024        |  163        |
>> >> +------------------------------------------+
>> >> |fb_dev_p     |  4           |  9          |
>> >> |frac fb_de^_p|              |             |
>> >> +----------------------------+-------------+
>> >>
>> >> With ref_div_max value clipped at 100, AMDGPU driver can also drive
>> >> videmode 2048x1280@60 (221Mhz) and produce proper output without any
>> >> blanking and distortion on the screen.
>> >>
>> >> PS: This value was changed from 128 to 100 in Radeon driver also, 
>> here:
>> >> https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8
>> >> ececc891fc3cb806
>> >>
>> >> Cc: Alex Deucher <Alexander.Deucher@amd.com> 
>> <mailto:Alexander.Deucher@amd.com>
>> >> Cc: Christian König <christian.koenig@amd.com> 
>> <mailto:christian.koenig@amd.com>
>> >> Cc: Eddy Qin <Eddy.Qin@amd.com> <mailto:Eddy.Qin@amd.com>
>> >>
>> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com> 
>> <mailto:shashank.sharma@amd.com>
>> >> ---
>> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c | 2 +-
>> >>    1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>> >> index 1f2305b7bd13..23a2e1ebf78a 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>> >> @@ -85,7 +85,7 @@ static void amdgpu_pll_get_fb_ref_div(unsigned 
>> nom, unsigned den, unsigned post_
>> >>                                     unsigned *fb_div, unsigned 
>> *ref_div)
>> >>    {
>> >>       /* limit reference * post divider to a maximum */
>> >> -    ref_div_max = min(128 / post_div, ref_div_max);
>> >> +    ref_div_max = min(100 / post_div, ref_div_max);
>> >>
>> >>       /* get matching reference and feedback divider */
>> >>       *ref_div = min(max(DIV_ROUND_CLOSEST(den, post_div), 1u),
>> >> ref_div_max);
>>


--------------C6F7CC715A5B79075683689D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">In the long term we probably want to
      nuke this code anyway and switch to the DC code, don't we?<br>
      <br>
      Christian.<br>
      <br>
      Am 04.11.20 um 15:23 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB4488278FB8B457603F1B955CF7EF0@MN2PR12MB4488.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        You might want to talk to the DAL team, they may have some
        advice.&nbsp; In general, I would say test it as well as you can.&nbsp;
        It's probably safe as radeon is still the default driver for SI
        parts and generally seems to be working well there.</div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Alex</div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Sharma, Shashank <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a><br>
          <b>Sent:</b> Wednesday, November 4, 2020 9:11 AM<br>
          <b>To:</b> Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
          <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Cc:</b> Qin, Eddy <a class="moz-txt-link-rfc2396E" href="mailto:Eddy.Qin@amd.com">&lt;Eddy.Qin@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH] drm/amdgpu: clip the ref divider
          max value at 100</font>
        <div>&nbsp;</div>
      </div>
      <div>
        <p>Thanks Alex, Same question here, <br>
        </p>
        <p>Should we go through some extensive test routine due to
          change in PLL values, or is it OK to go ahead based on our
          experience from Radeon values ?
          <br>
        </p>
        <p><br>
        </p>
        <p>Regards<br>
        </p>
        <p>Shashank<br>
        </p>
        <p><br>
        </p>
        <div class="x_moz-cite-prefix">On 04/11/20 7:36 pm, Deucher,
          Alexander wrote:<br>
        </div>
        <blockquote type="cite">
          <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
          <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
            Acked-by: Alex Deucher <a class="x_moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">
              &lt;alexander.deucher@amd.com&gt;</a><br>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Koenig, Christian
              <a class="x_moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
              <b>Sent:</b> Wednesday, November 4, 2020 6:54 AM<br>
              <b>To:</b> Sharma, Shashank <a class="x_moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com" moz-do-not-send="true">
                &lt;Shashank.Sharma@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                amd-gfx@lists.freedesktop.org</a> <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Cc:</b> Deucher, Alexander <a class="x_moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                &lt;Alexander.Deucher@amd.com&gt;</a>; Qin, Eddy <a class="x_moz-txt-link-rfc2396E" href="mailto:Eddy.Qin@amd.com" moz-do-not-send="true">
                &lt;Eddy.Qin@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: clip the ref
              divider max value at 100</font>
            <div>&nbsp;</div>
          </div>
          <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
                <div class="x_PlainText">Am 04.11.20 um 11:40 schrieb
                  Sharma, Shashank:<br>
                  &gt; [AMD Public Use]<br>
                  &gt;<br>
                  &gt; Hello Christian,<br>
                  &gt; Yes, that 100 is hardcoded in Radeon, and git
                  blame says it was one of your patches which made it
                  100 from 128 😊.<br>
                  &gt; Would you mind having a look at commit id:
                  4b21ce1b4b5d262e7d4656b8ececc891fc3cb806 ?<br>
                  <br>
                  Ah, yes that one :)<br>
                  <br>
                  Yeah the background is that this was just an educated
                  guess because I <br>
                  couldn't find anybody which could tell me what the
                  real limits of the <br>
                  PLL is.<br>
                  <br>
                  Looks like we just forgot to apply that patch to
                  amdgpu.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  &gt;<br>
                  &gt; Regards<br>
                  &gt; Shashank<br>
                  &gt; -----Original Message-----<br>
                  &gt; From: Koenig, Christian <a class="x_moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                    &lt;Christian.Koenig@amd.com&gt;</a><br>
                  &gt; Sent: Wednesday, November 4, 2020 3:35 PM<br>
                  &gt; To: Sharma, Shashank <a class="x_moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com" moz-do-not-send="true">
                    &lt;Shashank.Sharma@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a><br>
                  &gt; Cc: Deucher, Alexander <a class="x_moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                    &lt;Alexander.Deucher@amd.com&gt;</a>; Qin, Eddy <a class="x_moz-txt-link-rfc2396E" href="mailto:Eddy.Qin@amd.com" moz-do-not-send="true">
                    &lt;Eddy.Qin@amd.com&gt;</a><br>
                  &gt; Subject: Re: [PATCH] drm/amdgpu: clip the ref
                  divider max value at 100<br>
                  &gt;<br>
                  &gt; Am 03.11.20 um 18:13 schrieb Shashank Sharma:<br>
                  &gt;&gt; This patch limits the ref_div_max value to
                  100, during the calculation<br>
                  &gt;&gt; of PLL feedback reference divider. With
                  current value (128), the<br>
                  &gt;&gt; produced fb_ref_div value generates unstable
                  output at particular<br>
                  &gt;&gt; frequencies. Radeon driver limits this value
                  at 100.<br>
                  &gt; Mhm, is that 100 hard coded in radeon? I have no
                  idea where that is coming from.<br>
                  &gt;<br>
                  &gt; Best would probably to grab a hardware engineer
                  and try to figure out what the real maximums for the
                  PLL is to still produce a stable signal.<br>
                  &gt;<br>
                  &gt; Christian.<br>
                  &gt;<br>
                  &gt;&gt; On Oland, when we try to setup mode
                  2048x1280@60 (a bit weird, I<br>
                  &gt;&gt; know), it demands a clock of 221270 Khz. It's
                  been observed that the<br>
                  &gt;&gt; PLL calculations using values 128 and 100 are
                  vastly different, and<br>
                  &gt;&gt; look like this:<br>
                  &gt;&gt;<br>
                  &gt;&gt; +------------------------------------------+<br>
                  &gt;&gt; |Parameter&nbsp;&nbsp;&nbsp; |AMDGPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |Radeon&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; +-------------+----------------------------+<br>
                  &gt;&gt; |Clock feedback&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |divider max&nbsp; |&nbsp; 128&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |cap value&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; +------------------------------------------+<br>
                  &gt;&gt; |ref_div_max&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 42&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; +------------------------------------------+<br>
                  &gt;&gt; |ref_div&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 42&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; +------------------------------------------+<br>
                  &gt;&gt; |fb_div&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 10326&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8195&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; +------------------------------------------+<br>
                  &gt;&gt; |fb_div&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 163&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; +------------------------------------------+<br>
                  &gt;&gt; |fb_dev_p&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; |frac fb_de^_p|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
                  &gt;&gt; +----------------------------+-------------+<br>
                  &gt;&gt;<br>
                  &gt;&gt; With ref_div_max value clipped at 100, AMDGPU
                  driver can also drive<br>
                  &gt;&gt; videmode 2048x1280@60 (221Mhz) and produce
                  proper output without any<br>
                  &gt;&gt; blanking and distortion on the screen.<br>
                  &gt;&gt;<br>
                  &gt;&gt; PS: This value was changed from 128 to 100 in
                  Radeon driver also, here:<br>
                  &gt;&gt; <a href="https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8" moz-do-not-send="true">
https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8</a><br>
                  &gt;&gt; ececc891fc3cb806<br>
                  &gt;&gt;<br>
                  &gt;&gt; Cc: Alex Deucher <a class="x_moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                    &lt;Alexander.Deucher@amd.com&gt;</a><br>
                  &gt;&gt; Cc: Christian König <a class="x_moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">
                    &lt;christian.koenig@amd.com&gt;</a><br>
                  &gt;&gt; Cc: Eddy Qin <a class="x_moz-txt-link-rfc2396E" href="mailto:Eddy.Qin@amd.com" moz-do-not-send="true">
                    &lt;Eddy.Qin@amd.com&gt;</a><br>
                  &gt;&gt;<br>
                  &gt;&gt; Signed-off-by: Shashank Sharma <a class="x_moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com" moz-do-not-send="true">
                    &lt;shashank.sharma@amd.com&gt;</a><br>
                  &gt;&gt; ---<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c |
                  2 +-<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1
                  deletion(-)<br>
                  &gt;&gt;<br>
                  &gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
                  &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
                  &gt;&gt; index 1f2305b7bd13..23a2e1ebf78a 100644<br>
                  &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
                  &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
                  &gt;&gt; @@ -85,7 +85,7 @@ static void
                  amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den,
                  unsigned post_<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned
                  *fb_div, unsigned *ref_div)<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* limit reference * post divider to a
                  maximum */<br>
                  &gt;&gt; -&nbsp;&nbsp;&nbsp; ref_div_max = min(128 / post_div,
                  ref_div_max);<br>
                  &gt;&gt; +&nbsp;&nbsp;&nbsp; ref_div_max = min(100 / post_div,
                  ref_div_max);<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get matching reference and feedback
                  divider */<br>
                  &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ref_div =
                  min(max(DIV_ROUND_CLOSEST(den, post_div), 1u),<br>
                  &gt;&gt; ref_div_max);<br>
                  <br>
                </div>
              </span></font></div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------C6F7CC715A5B79075683689D--

--===============1634504997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1634504997==--
