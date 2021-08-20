Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B99C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 08:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816E860F92
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 08:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 816E860F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6FC6EA35;
	Fri, 20 Aug 2021 08:05:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB5336EA35
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 08:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEkdZlf8GRd+9HPlKO7+XRKAT2xcm2sMwguRRLn8nVcKb+8lEo9ht/fVjlmK3KaXfM51JJr2iCXy9Wd81vlEfdmpSnRmTY6XrxYDPm0roYjL+ImoN3BWs1tceGRrE9epRWqC18dYm+9IylXdAiRp0KRrmkFI+wBhGLhZQf1A0po/9Gh8LS/MhxsGMWkUMtsUkdlzE3nW+1Ongx29198ljjH8h0Xal1G+TDWVIZxJWnwcRjtIWztikziFTZTMiWx3ciI+BvkO5utljcQpvJN+DPP/wFyuB89ubqjiHGecwvsH0wgOkS8mULKsNO8/aM6bt84AK6WKIfvXpAJftergiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOh8rxC8uPSJU9KH4Hhqg268biyYGJ/98VyDGk5qvtc=;
 b=iGLn5WThpG1Dy9sW/4GhjyZmSN3sD36ciq9s9HGmMshSbFfQWripSqqjMK4x4kPkc6+/s/LmN5JMvT15nvPIXeYt9U8fBUbDUePxayMxEePq7wAH2hE3keBM5yyjkVDRfP7TgleGA88VT3ecKwOPZ+FojMpye8A1lytEQrsqKFF5DUXbcMFxW16nMqfJ7QfPOh62GrEVPpWXKKZLoIcuaeTOBggzPY5Ou3FH22l4EBtRCD6jDXMUiYAeecKxnKK+jQWQcTCNEwwm04YNJW060IuYKKzQ/DYe6unxec7d8oOF2mhE6HzqKDp8163qc/pNgEMff13N/jnYthRmYff05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOh8rxC8uPSJU9KH4Hhqg268biyYGJ/98VyDGk5qvtc=;
 b=4VmE8ItYrWJ7BWKQ76ZH31zG34/ih+OF4fpUWwB6yVFlNdY+bqvOv69ZHc77QiVCFAHC8qNueFyRMDUF7vEOLulWvALAonUZ8w8X7MfkQpkIHIeAAC0H344yYkjAMSp7eZleHLFDtP0+qdFN8r4/qEljdELmvU03yAKnYDIn4v4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 08:05:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 08:05:45 +0000
Subject: Re: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <1d64e5d6-8981-3bc2-21dd-b8eaf7a9333e@amd.com>
 <b71ef8fd-55f7-068b-db64-1aa727cde211@amd.com>
 <DM4PR12MB5040EBA85361E825DC161023F2C19@DM4PR12MB5040.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d8a9db0d-f52e-de2d-f40f-bae5bf04e801@amd.com>
Date: Fri, 20 Aug 2021 10:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM4PR12MB5040EBA85361E825DC161023F2C19@DM4PR12MB5040.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.5 via Frontend Transport; Fri, 20 Aug 2021 08:05:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1603282b-0b73-4f96-68de-08d963b14fb1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4208106B70876C58A719CA9283C19@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9Z4xfcMqHjiY9Hx+iKC+Q6OH0BY5HHbm+aZTSuUjh40/jNaNb9ufpKxqRfB3/4VvQpvkOwa1iO/J1XS3Lqdn6qLRMjxuL/nH3r7chwB0tNyI5OVJFJIeMVSdWIy2V42BNOpURyV33+POHcPZjBlf2yRYkbbMR5ZuTscI2yA02Pn5meHK0Sobw36gp0QC1FV1TeUf5NQ3qGW7mFlULzbKvpWcXUV9i4v8jmlhgPe5svyu6H4eALF2E2eMnRdIYun0k5FKfp799iyscOP51kbTImnZPv0jIyPsRVtK5kTwud/KZOXmkpFbwh8l0eFlNiS/ICP/o6i1DZ/UDVjn9Jyhhzg/gC2b0xmXRl/KAHTE0hLd8HNa470bLSbDG1TVJ1InujHenZeOcKS44R78VZs554Wx43BFucG3gZXD91i/MuD1i+4HQI7+4j1bUcgDx5V2aHKWX8zJT2yDv+Hk4GAmrPkHsYZeB5L8YKhPMgxiiySWkjt94ng9P0GadEUSyP8CXGDqedQJdVxiw+R7mPZawQBzS7rmmeKu7KnEW/mH0OnwivIhx7AzjUmb2UsWfpvo+KEQafj0vmaCpO8iQVUf2VOoIpukYNkEV+TrCcnU2Io4N29UQLlpfNtVQ58PXBirFoWHzWvi7N5x7bYeCx6GBmes+K0YegqS6GLCyrXkrvKFUpNsjpNEweHZiWjXBP07Kj7Ak8+W7J0+WTT/ySDvTCEcQqZ+Zr3+NbMtiYEYI5D3IDpaLfwO8lq9bxtrPtG3Bl7RrW+Iga7W/TvBdSuAugSKHMSPINDADRb8l36aSlOfSbWI384ioDco7KsC1vRN5oAJ1LYfWdB1Ze6QHpxOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(31686004)(31696002)(2906002)(83380400001)(2616005)(956004)(86362001)(66574015)(5660300002)(66556008)(38100700002)(53546011)(186003)(508600001)(16576012)(66946007)(110136005)(66476007)(6486002)(6666004)(26005)(8676002)(36756003)(4326008)(316002)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnpYTmFvUmU5L0R1R0VzYnhMVFpFVzUxeGdwM1pRWGNtWUlicEhVSXRlejZL?=
 =?utf-8?B?eUV6dkt5clF3bDY1MnMybjJvbXpaNlpJcjBNQWM3ZExnczJwcGl4RXBVY2ZP?=
 =?utf-8?B?NUFuSnphWnJJWkNNcm84Q3ArMFlLNHM3TWtEWVVFd1RPcVpSNzAvd3cxa0tr?=
 =?utf-8?B?eU5Tdy92ZDdqdVB4bUhGa056VHkwTEhWY0Njd2pkWi9nL1JSWDRNeG1obzVi?=
 =?utf-8?B?V3N2NUpVSkV3azZvRDcyZFJpTWlJaS9oOFBaMTNFYm5Zam51UHZCeTJrcnJX?=
 =?utf-8?B?dkMxbmdTUHhTbjZQNnpEdEp0Nml0NEVBdGh0TytHVUR6cmYxUFhzaGhoZ1lw?=
 =?utf-8?B?YTllTkRZQm1Ia29oOUZXS1pEQXZKMTZGblJHYjN1RUxZUDZDKzVVbGtJcENp?=
 =?utf-8?B?R0VzQmJoOVp4YXk0UWRnOURNT1BiZ2ppTUNwOTJPcGdiWUw1UXl5bVhRZ0Fr?=
 =?utf-8?B?T1ZyV3NWaSt2Z1hjMHh1S01IT21QZHByZ0grcWZBOWNXNHNyTGtLZk9qUXZj?=
 =?utf-8?B?NlAxLzRCSkcwVUQydDZQV1F4WUlEdHlzdS9sdzhYRHB2NFdISm5CMmY3M2Nv?=
 =?utf-8?B?NW9jclJYRVY3NFhGclRCempUaHFjaEJITFBqNS8rTmxlUGFMcWJkT2ZzWG1F?=
 =?utf-8?B?TEFqdW41Yk1odjZCZEVLMHpnVWhHa3Y2UThaaUpZSFc0N2xIMXlqNklOVEdx?=
 =?utf-8?B?dndkbzBEZEN0YndCUkcxZVh2T2s3S2Jvbzl1R0Y2ZTFwWitlOFY4Y0tyaE1k?=
 =?utf-8?B?WmZJU29CTGJRNUFoVXdoVHdQZGZIVXMxYk5WS1lhK01xRlhudUFwN0RMK0lS?=
 =?utf-8?B?UWFDWXVwQ1ovL1NmemRPVW5GaUd1RENneURWQnF5dTJMUVFmcGh6TVhDUHdU?=
 =?utf-8?B?RnZwUnMxeW9DalFVUEQ2dHZyWU5OcGRmRU5IbWVlaFE4cnZaYmdlQWRwVE5N?=
 =?utf-8?B?bkZMRlFOcnRMUHRRa21IQXNtaGlTUWJldnZuV0xVZE43MHlVU2dMMDV0eG1q?=
 =?utf-8?B?Tm1UTDZKYmFxTnlScTY3VjJKdEE1R3BJb05jK05JREVJbTBoRDNnbnNxd1Rz?=
 =?utf-8?B?MlFuY0hBQXIvK1FlQThMZGFabGZ1bUtTZlhONSsyaG9saUg4QmROR25xdFpW?=
 =?utf-8?B?YXhUQ3ZmeWNtbi9lL2tvWEhXM2tvMWk3ZkFPRzZ1R1JlYzBaRkVVWUFhUUlV?=
 =?utf-8?B?YUg2bmprS25DZnFmUEM3Ri9GNTlYYzEreEdSMzN1UHJuUThRUmdrMHc5NG1E?=
 =?utf-8?B?K3BRR2dwaGk1cWI0M051WlRvUFdaOXV0YzRaUTFUQkNWOWJGcVdmQXJHbFk2?=
 =?utf-8?B?RjdJWEpXeVZoVE5PUkYxNkgyVXR5TWpldEpLTmZSRFMyd1ZWU3BWZ3BqU1Z1?=
 =?utf-8?B?clhnSGVDQ2U2TmU2SExRdlRsalkrQjBOaHZwa0dINFJoakNadXBBZzBSV1Rr?=
 =?utf-8?B?ejdBNHFNU05sVEF4YXByT3FocnBibWJTWkhEb3I3cytBblZNR2dBVGJEdTE0?=
 =?utf-8?B?ZTV6K1N4dk5aRXFQVXBNWTVWUk5aSXE2VjhHTGhHL2I4d3N6TFB5Skx0bXRz?=
 =?utf-8?B?eVRiL242Q1k0WjNWdG8vY2NZYTF3YlFybHB3akp6M2JQbzlLZVY2Zm5WbUti?=
 =?utf-8?B?Sm5Yd3lCQUVBZGE2Yk9qR2FITUhPeUIzdXdHRWxaNUZlYnlmTU9nQTFZaDZP?=
 =?utf-8?B?c25GSjUrcmtNcklZVC9NdGdmemVsbFpRY1F4QU0yNW9HWktRMGtqcXBRSkZX?=
 =?utf-8?Q?/4g1ytFWRTJyclVZ94r+dP2zSTpCjZe6fufB6ZW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1603282b-0b73-4f96-68de-08d963b14fb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 08:05:44.9042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyeBW1YRlDaq82fNtxXnq9TpgpP5BvJdo86CVFLuqiUIvBvG5C4B0fm1r/HVYKEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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

Uff, I think that was SI but could be CIK as well.

We have a table for this somewhere, but I don't have it at hand.

Regards,
Christian.

Am 20.08.21 um 09:43 schrieb Sharma, Shashank:
> [AMD Official Use Only]
>
> Agree, on the similar note, which Gen is OLAND BTW 😊 ?
>
> Regards
> Shashank
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, August 20, 2021 12:08 PM
> To: Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
>
> Sounds like a good idea to me, but I would limit this generally or at least for the whole generation and not just one particular chipset.
>
> Regards,
> Christian.
>
> Am 20.08.21 um 08:05 schrieb Sharma, Shashank:
>>  From 4841e5ba60e33ff798bde6cb69fbd7e137b6db9c Mon Sep 17 00:00:00 2001
>> From: Shashank Sharma <shashank.sharma@amd.com>
>> Date: Fri, 20 Aug 2021 10:20:02 +0530
>> Subject: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> This patch limits the ref_div_max value to 100, during the calculation
>> of PLL feedback reference divider. With current value (128), the
>> produced fb_ref_div value generates unstable output at particular
>> frequencies. Radeon driver limits this value at 100.
>>
>> On Oland, when we try to setup mode 2048x1280@60 (a bit weird, I
>> know), it demands a clock of 221270 Khz. It's been observed that the
>> PLL calculations using values 128 and 100 are vastly different, and
>> look like this:
>>
>> +------------------------------------------+
>> |Parameter    |AMDGPU        |Radeon       |
>> |             |              |             |
>> +-------------+----------------------------+
>> |Clock feedback              |             | divider max  |  128
>> ||   100       | cap value    |              |             |
>> |             |              |             |
>> |             |              |             |
>> +------------------------------------------+
>> |ref_div_max  |              |             |
>> |             |  42          |  20         |
>> |             |              |             |
>> |             |              |             |
>> +------------------------------------------+
>> |ref_div      |  42          |  20         |
>> |             |              |             |
>> +------------------------------------------+
>> |fb_div       |  10326       |  8195       |
>> +------------------------------------------+
>> |fb_div       |  1024        |  163        |
>> +------------------------------------------+
>> |fb_dev_p     |  4           |  9          | frac fb_de^_p|
>> ||             |
>> +----------------------------+-------------+
>>
>> With ref_div_max value clipped at 100, AMDGPU driver can also drive
>> videmode 2048x1280@60 (221Mhz) and produce proper output without any
>> blanking and distortion on the screen.
>>
>> PS: This value was changed from 128 to 100 in Radeon driver also, here:
>> https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8
>> ececc891fc3cb806
>>
>>
>> V1:
>> Got acks from:
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>>
>> V2:
>> - Restricting the changes only for OLAND, just to avoid any regression
>>    for other cards.
>> - Changed unsigned -> unsigned int to make checkpatch quiet.
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Eddy Qin <Eddy.Qin@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c    | 20 +++++++++++++-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h    |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/atombios_crtc.c |  2 +-
>>   3 files changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>> index f2e20666c9c1..6d04c1d25bfb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
>> @@ -80,12 +80,17 @@ static void amdgpu_pll_reduce_ratio(unsigned *nom,
>> unsigned *den,
>>    * Calculate feedback and reference divider for a given post divider.
>> Makes
>>    * sure we stay within the limits.
>>    */
>> -static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den,
>> unsigned post_div,
>> -                      unsigned fb_div_max, unsigned ref_div_max,
>> -                      unsigned *fb_div, unsigned *ref_div)
>> +static void amdgpu_pll_get_fb_ref_div(struct amdgpu_device *adev,
>> unsigned int nom,
>> +                      unsigned int den, unsigned int post_div,
>> +                      unsigned int fb_div_max, unsigned int
>> +ref_div_max,
>> +                      unsigned int *fb_div, unsigned int *ref_div)
>>   {
>> +
>>       /* limit reference * post divider to a maximum */
>> -    ref_div_max = min(128 / post_div, ref_div_max);
>> +    if (adev->asic_type == CHIP_OLAND)
>> +        ref_div_max = min(100 / post_div, ref_div_max);
>> +    else
>> +        ref_div_max = min(128 / post_div, ref_div_max);
>>
>>       /* get matching reference and feedback divider */
>>       *ref_div = min(max(DIV_ROUND_CLOSEST(den, post_div), 1u),
>> ref_div_max); @@ -112,7 +117,8 @@ static void
>> amdgpu_pll_get_fb_ref_div(unsigned
>> nom, unsigned den, unsigned post_
>>    * Try to calculate the PLL parameters to generate the given frequency:
>>    * dot_clock = (ref_freq * feedback_div) / (ref_div * post_div)
>>    */
>> -void amdgpu_pll_compute(struct amdgpu_pll *pll,
>> +void amdgpu_pll_compute(struct amdgpu_device *adev,
>> +            struct amdgpu_pll *pll,
>>               u32 freq,
>>               u32 *dot_clock_p,
>>               u32 *fb_div_p,
>> @@ -199,7 +205,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
>>
>>       for (post_div = post_div_min; post_div <= post_div_max;
>> ++post_div) {
>>           unsigned diff;
>> -        amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max,
>> +        amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div,
>> +fb_div_max,
>>                         ref_div_max, &fb_div, &ref_div);
>>           diff = abs(target_clock - (pll->reference_freq * fb_div) /
>>               (ref_div * post_div));
>> @@ -214,7 +220,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
>>       post_div = post_div_best;
>>
>>       /* get the feedback and reference divider for the optimal value
>> */
>> -    amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max,
>> ref_div_max,
>> +    amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max,
>> ref_div_max,
>>                     &fb_div, &ref_div);
>>
>>       /* reduce the numbers to a simpler ratio once more */ diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
>> index db6136f68b82..44a583d6c9b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
>> @@ -24,7 +24,8 @@
>>   #ifndef __AMDGPU_PLL_H__
>>   #define __AMDGPU_PLL_H__
>>
>> -void amdgpu_pll_compute(struct amdgpu_pll *pll,
>> +void amdgpu_pll_compute(struct amdgpu_device *adev,
>> +             struct amdgpu_pll *pll,
>>                u32 freq,
>>                u32 *dot_clock_p,
>>                u32 *fb_div_p,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
>> b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
>> index 159a2a4385a1..afad094f84c2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
>> @@ -851,7 +851,7 @@ void amdgpu_atombios_crtc_set_pll(struct drm_crtc
>> *crtc, struct drm_display_mode
>>       pll->reference_div = amdgpu_crtc->pll_reference_div;
>>       pll->post_div = amdgpu_crtc->pll_post_div;
>>
>> -    amdgpu_pll_compute(pll, amdgpu_crtc->adjusted_clock, &pll_clock,
>> +    amdgpu_pll_compute(adev, pll, amdgpu_crtc->adjusted_clock,
>> &pll_clock,
>>                   &fb_div, &frac_fb_div, &ref_div, &post_div);
>>
>>       amdgpu_atombios_crtc_program_ss(adev, ATOM_DISABLE,
>> amdgpu_crtc->pll_id,

