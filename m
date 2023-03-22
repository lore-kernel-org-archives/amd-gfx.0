Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA50C6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244FE10E951;
	Wed, 22 Mar 2023 14:08:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC56210E951
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/eTsDnKI7Q8PXDPKJHPiqTz0D2HlFZNc3koxMiqQDqmm7MbKeJ0VDK+K6qU/J9GQb+94O2DB2f96j923J1UmrROixrKkJ14cBMmVNueMhmmzXHDRVE2SpIDscWPeAMymsUZvX493v+cjdvl590NpqRnt9CYMZkmKfQKPZ0Iou+BkBC3Q61fHZcTBrFyO0wVE8NbVj6cmlaSy63gieKV+4IdNL+Swq2+HTxDpCdZ6n+5hddUC/QRT7QPrlQcy6IRAjqrilfh38xKPTRVPpcr37gZVBM5ijadFJm1Fu+dzveBZ7ZuBg+modrm9p5199svy0PGTOCYxYCrJ83X2QenBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UE8smLmVQ5INSaglCyTAlfu1wB1PEymc2g4zV4gSg8=;
 b=ETiRpEl7hob//vRk0xkwX1P/GxJzNw181UgdhaiTX4Rbdz8XS7nQ+RgXpzzLS3NHu5ekf8NISFWcCOIbU2fps+G164LDDez46glGZMkt0CtXEaFeAomQ24+KY3P24S2HoJtAOf3NtUsz0+8EFTumtdBc+4FOflcKqQEjtLcaEjRXRYfKPCGtxfYVSBpWha6mQEoVEWOwCEniwGIFZsHRTDDsK6YQtI74KpkRwZfT6d2IiRcuyGtb6Np9bazFXcFiPuvkDsPV2QmLo+Fao4fcCM292Kua3m1o9fhScIcsgVHEZVrLSos3fSRgY/Zx594zdDiyWSjLwKP5uz/rhWLoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UE8smLmVQ5INSaglCyTAlfu1wB1PEymc2g4zV4gSg8=;
 b=DYqhr1dIU6jj8sVfYA2zqduZsla432XLuqXcQ6hsGvll/4SLedjk0k5fO3D7Mr01FK2uffvhUM12PaRiaJAEdyHjskbJt4bq3BBLPPUWbzzUn/l2ALmpY7b4MDgpjxfuLF7uzDP5/y/uccNvcLYWC9yXdhJa70JL4ilPHwhjAXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 14:08:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:08:47 +0000
Content-Type: multipart/alternative;
 boundary="------------JdTSK2CDwiaoDb3kxj3nwy0B"
Message-ID: <ac80456d-ac57-dbf4-dca0-7f92a40bb603@amd.com>
Date: Wed, 22 Mar 2023 15:08:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
 <CAAxE2A67NMxra-a9ZYbY8e8S4fjfdXgB1cpjYZsSS8DcUu=LbA@mail.gmail.com>
 <MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com>
 <0e904e40-ee6f-dea2-b2de-3e408a72908e@gmail.com>
 <CAAxE2A66ZF==rvDd8KFrfz79rXBB52vnWU7zsM+rfH69OV0Psw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A66ZF==rvDd8KFrfz79rXBB52vnWU7zsM+rfH69OV0Psw@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cfb827-ab11-4b81-8c59-08db2adef407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKWtfLHbuUilBdaG/R2AJmvMH2/eMLWbpwa81lhOClnkow+M9u9oyhxiM5g3sH0/MjVxOBHDIhFicoa2Pq7V7qg3LxmgbRKDJ4eaakmBWBVHBC6GLYVuCYYwciqz76HkaLTV6BsS/KmCpGBzAusNcunFQeTaupwrSQMwOCGOKFczd1Oi6MJCY5iUkLlUTXbo4SYWkyvQGpfeOjJ38q+Hj5nR/tZuXmiM50F7LPPShI3DIb9A5R2CxJq0cAqxWzJNQB+vp66QKC1U1Md6V9eQPNna8fezMLms4d+IVxw/1OmKNJHWUJgsQA4u7QOujFS3EAsZQfgsvHDcpVmHjR9Posd3F0bWhYJFzFLbXFflIW1fD/2cmrqBQmtmWkV53GdCk52EZ3Z6c0IOoaSLQXPrIsZL34DHGdCzTIzo4P3BrA+kW2kTsDnw5tg/d5Iipicvb+9AmmQLCmDY+aCDItvh8gAyn5iny6mKTUOEEqYMOTog50ao629oAGIyjFEhz5xSaB3SSnQc2q416SA/i0YYBpeVZYayhhZ3gaVcmHkGXSPInD6knM6k/w2APpcu2/qkw0672TaH3Oz/lG1UL7icKsUdm1cLD669j7B+iT81ar+SL9oXuRye8QG1N93zkJYKKBVTciV372BhP++MrIXZ61p5IFhdbmu8j9N7Z43ZvICAiXSXV2WUCEZC6NVncquu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199018)(31686004)(2616005)(6506007)(6512007)(6666004)(966005)(33964004)(6486002)(53546011)(166002)(186003)(86362001)(38100700002)(31696002)(54906003)(2906002)(478600001)(316002)(66946007)(4326008)(110136005)(8676002)(41300700001)(66556008)(8936002)(66476007)(5660300002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFdNeDNrQUdMbHR0L2hKcEJ6ZUVvbTl6NkNlQ1dmeUVaWHNsanIyNks1TnBh?=
 =?utf-8?B?dTd1K2U2QlZ1UVB3Uzk5bjVYUnZzMXBOVG1QaDRGOHJJSlN2NVgraHFJL2VG?=
 =?utf-8?B?VEdtLzJQMHJlUklkYXZWdXNETU1mRG0yQXJMZ2Fsa2xTeUtUVTByd3p0YjFJ?=
 =?utf-8?B?dWVqMG5xOVU4UXl5b2xLTHFaV0pGVHNBUHZVV3pSY0dscVBuOFdRV1NoZEt2?=
 =?utf-8?B?eDNaWjM3NDgxcEl2Wm1lR1FET3ZvMkJhQnlHRVhrRkNEVFcxR3FUY25iMHlu?=
 =?utf-8?B?ZDN1LzVTa0l1bUlnZ3BNN0NpZG5XV3AzSTdLN2VZbDZWcmxTSHVwMEtHd05U?=
 =?utf-8?B?K2VKN1hNMURyTkMwL3Qrek1ESVl5aUVDcTRFTEZzOVdMU3pqcGhtZTFoeFZ2?=
 =?utf-8?B?eFNmYVdadzN1RU5vczl3MWtuZjUxaWRrV3oxOXFSTVFHb1pGRFBqMkhzUWJ3?=
 =?utf-8?B?Q1JLMFlTVGQ3dktMdGNIOEZHRk8yV2NWbi80aHg2S2VCUm4zd1RmbFpvZm40?=
 =?utf-8?B?V2pnK3EvY3dwUFErVE5TejZsVWQ2aEpkekk3a0gwUnhjeTEyYWdLd1BwQ0tz?=
 =?utf-8?B?bzRlTEdHZ09GUk0rcjcwYy9TMVd1T0ZySzlCdXQyZVBXN21BSkk2TjgxZHQ5?=
 =?utf-8?B?VGJqdFhHSGVjd0RVSVd3S3FEVmZTRXlkUUNHUVhJUnRkMzh1WWpySEkzRVBQ?=
 =?utf-8?B?Mm8wOW9IeEdwY1ZwcGtvQUFhTyswbEU2Qi9oc0NFUUpIZU9qRDg4b1dLYzJO?=
 =?utf-8?B?NENZSVFTNnZ6YTlyNVhJUk9qV2tTRGNxL0hvMWNUR1EwVEtmQWdrVGVYcDJk?=
 =?utf-8?B?NGNydkVsTHBQQkFQdHFJeThGN0QrVlorSkZLVHZJYUxDdTVTcUc3TExNVC9j?=
 =?utf-8?B?MU42MEY1a1JkT01zWE1TV1dXTkxWWWYvNCs4dFE2M3lVVldlK1FFSFFhNWI4?=
 =?utf-8?B?NVBvTUJXcGlWU3o0U01wWTdvZTJSaks1bnpibHFmS2lJWGFEajFFdzJWS090?=
 =?utf-8?B?aE95NFhqQ1hhckZPSVZ5SDVZTElQeVlXK2xqRkQ4MHFLdE1KS3AvUnZnYitT?=
 =?utf-8?B?TlpkcTlTRzh0UG1rOC9BbXRWSGprZ3ZBVk00d2wrR2FiMlZ3TG9xdUUwMWI5?=
 =?utf-8?B?RDg2YzhUNDU5ZWl0cXU1T0NqQkdUdFZNaXNiWmNKOVJZbHhKWm5tMmlkQitB?=
 =?utf-8?B?ZXMrTU91T01rZlA5Y1RjdXpRMkViNlBISE53dlBocUg2bDBYT3ZENkZaZ3VJ?=
 =?utf-8?B?NHplc2RRdWFaenhOOGI1dzdscnZTeDdaczlZRVZTNzJ5RnNkQW1jV05oTy9a?=
 =?utf-8?B?MDM3QmdLVWJ4MkVhYk1vc0t1UFJUT2NTSkt3N3hsRzRGNWI4Z3hwL1ErZ2NN?=
 =?utf-8?B?REFvczUzMUVSM2h0Q1lBTHNneENhRmFCVWNPSTJPcTFvekpCeUlsMzRTeW5R?=
 =?utf-8?B?YmZ5OTE2VWJzNWFCWENUSmsvdzFXa2drUGxSaFB2TFMzZTVqSVdkWEI0S1dM?=
 =?utf-8?B?THZ4bG9Vei9VMzgxSUoreFgvYWZvOWxCOThSWUw0dE1PZGsvbHdGMzZ6RC92?=
 =?utf-8?B?enVoZjVyRmFMNjhIL2JoUlRubHQ2WmRzOUFWZ1dmQ3QzcWxPVWFNeFBwYlNK?=
 =?utf-8?B?alloM1hpUkZvb1N4eEd6dEprNWVtdWRYbGxhRStjWjBwR0JJVG0zbFRSWEND?=
 =?utf-8?B?OFljTkRlcjVVYWwrNGk4UWl1TFVGRFh6eFhjY0VTVXhMZC9yTzVrTmVxelRo?=
 =?utf-8?B?bGlob1RLbktCSDMydFhnbDNTbGpLSjdwdXhlMElOWG1lbWxaVlVxWDg5ZGhT?=
 =?utf-8?B?N1loU3RrbU1ycEdPakczNVd2RnhLWW5ucytiUDZ6TnViMVd0MW1HaWkxbnJ0?=
 =?utf-8?B?Vkdld2l5NE9KVEVNN2JtTk5FS1djdVJCTFoxOHM0LzNDUVUrOUhlcldYazVF?=
 =?utf-8?B?MzJWL2lHVHFDSXQzQ0UrTjVTMlRyZ2FUMnVSanRNQ3VBWFlnSDlMUk50WlU4?=
 =?utf-8?B?SDBDa3ZCbXQ5cUxsdDE0N2dLT2dvRUNoa21Hc1ZOeWp1RXRwbk41STNLSHFX?=
 =?utf-8?B?bHpBUFpuWlF3K2p4eE44a05LQmxMKzBsR1V4ZlF2Q3k0ZmNBaEthYkt1QmNv?=
 =?utf-8?B?M0VWQWxrRnJrVkhjUGs3RUU3VWF1cm1RWDU2Z1RDcENsajAxdXY3am1XbFdi?=
 =?utf-8?Q?QZNlMggbGDslX39V7r5jVJ1p2duQTVagOs902zovNlWg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cfb827-ab11-4b81-8c59-08db2adef407
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 14:08:46.9704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rCBj2Jy6gqPKfF2j8EDxMfOss9WA1/6mjuG9sIuygkgJYoLFgnzuaD1QeCDhx3W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------JdTSK2CDwiaoDb3kxj3nwy0B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well completely agree that we shouldn't have unused API. That's why I 
said we should remove the getting the hint from the UAPI.

But what's wrong with setting it after creating the context? Don't you 
know enough about the use case? I need to understand the background a 
bit better here.

Christian.

Am 22.03.23 um 15:05 schrieb Marek Olšák:
> The option to change the hint after context creation and get the hint 
> would be unused uapi, and AFAIK we are not supposed to add unused 
> uapi. What I asked is to change it to a uapi that userspace will 
> actually use.
>
> Marek
>
> On Tue, Mar 21, 2023 at 9:54 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     Yes, I would like to avoid having multiple code paths for context
>     creation.
>
>     Setting it later on should be equally to specifying it on creation
>     since we only need it during CS.
>
>     Regards,
>     Christian.
>
>     Am 21.03.23 um 14:00 schrieb Sharma, Shashank:
>>
>>     [AMD Official Use Only - General]
>>
>>     When we started this patch series, the workload hint was a part
>>     of the ctx_flag only,
>>
>>     But we changed that after the design review, to make it more like
>>     how we are handling PSTATE.
>>
>>     Details:
>>
>>     https://patchwork.freedesktop.org/patch/496111/
>>
>>     Regards
>>
>>     Shashank
>>
>>     *From:*Marek Olšák <maraeo@gmail.com> <mailto:maraeo@gmail.com>
>>     *Sent:* 21 March 2023 04:05
>>     *To:* Sharma, Shashank <Shashank.Sharma@amd.com>
>>     <mailto:Shashank.Sharma@amd.com>
>>     *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>     <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>;
>>     Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>
>>     <mailto:Amaranath.Somalapuram@amd.com>; Koenig, Christian
>>     <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>
>>     *Subject:* Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload
>>     hints to ctx ioctl
>>
>>     I think we should do it differently because this interface will
>>     be mostly unused by open source userspace in its current form.
>>
>>     Let's set the workload hint in drm_amdgpu_ctx_in::flags, and that
>>     will be immutable for the lifetime of the context. No other
>>     interface is needed.
>>
>>     Marek
>>
>>     On Mon, Sep 26, 2022 at 5:41 PM Shashank Sharma
>>     <shashank.sharma@amd.com> wrote:
>>
>>         Allow the user to specify a workload hint to the kernel.
>>         We can use these to tweak the dpm heuristics to better match
>>         the workload for improved performance.
>>
>>         V3: Create only set() workload UAPI (Christian)
>>
>>         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>         Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>         ---
>>          include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>>          1 file changed, 17 insertions(+)
>>
>>         diff --git a/include/uapi/drm/amdgpu_drm.h
>>         b/include/uapi/drm/amdgpu_drm.h
>>         index c2c9c674a223..23d354242699 100644
>>         --- a/include/uapi/drm/amdgpu_drm.h
>>         +++ b/include/uapi/drm/amdgpu_drm.h
>>         @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>>          #define AMDGPU_CTX_OP_QUERY_STATE2     4
>>          #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
>>          #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
>>         +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
>>
>>          /* GPU reset status */
>>          #define AMDGPU_CTX_NO_RESET            0
>>         @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>>          #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>>          #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>>
>>         +/* GPU workload hints, flag bits 8-15 */
>>         +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
>>         +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff <<
>>         AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>         +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 <<
>>         AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>         +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 <<
>>         AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>         +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 <<
>>         AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>         +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 <<
>>         AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>         +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 <<
>>         AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>         +#define AMDGPU_CTX_WORKLOAD_HINT_MAX
>>         AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
>>         +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n >>
>>         AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>         +
>>          struct drm_amdgpu_ctx_in {
>>                 /** AMDGPU_CTX_OP_* */
>>                 __u32   op;
>>         @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>>                                 __u32   flags;
>>                                 __u32   _pad;
>>                         } pstate;
>>         +
>>         +               struct {
>>         +                       __u32   flags;
>>         +                       __u32   _pad;
>>         +               } workload;
>>          };
>>
>>          union drm_amdgpu_ctx {
>>         -- 
>>         2.34.1
>>
>

--------------JdTSK2CDwiaoDb3kxj3nwy0B
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Well completely agree that we shouldn't have unused API. That's why
    I said we should remove the getting the hint from the UAPI.<br>
    <br>
    But what's wrong with setting it after creating the context? Don't
    you know enough about the use case? I need to understand the
    background a bit better here.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 22.03.23 um 15:05 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A66ZF==rvDd8KFrfz79rXBB52vnWU7zsM+rfH69OV0Psw@mail.gmail.com">
      
      <div dir="ltr">
        <div>The option to change the hint after context creation and
          get the hint would be unused uapi, and AFAIK we are not
          supposed to add unused uapi. What I asked is to change it to a
          uapi that userspace will actually use.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, Mar 21, 2023 at
          9:54 AM Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Yes, I would like to avoid having multiple code paths
            for context creation.<br>
            <br>
            Setting it later on should be equally to specifying it on
            creation since we only need it during CS.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 21.03.23 um 14:00 schrieb Sharma, Shashank:<br>
            </div>
            <blockquote type="cite">
              <div>
                <p style="margin:0cm"><span style="font-size:10pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                    Official Use Only - General]</span></p>
                <p class="MsoNormal">&nbsp;</p>
                <p class="MsoNormal"><span>When we started this patch
                    series, the workload hint was a part of the ctx_flag
                    only, </span></p>
                <p class="MsoNormal"><span>But we changed that after the
                    design review, to make it more like how we are
                    handling PSTATE. </span></p>
                <p class="MsoNormal"><span>&nbsp;</span></p>
                <p class="MsoNormal"><span>Details: </span></p>
                <p class="MsoNormal"><span><a href="https://patchwork.freedesktop.org/patch/496111/" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://patchwork.freedesktop.org/patch/496111/</a>
                  </span></p>
                <p class="MsoNormal"><span>&nbsp;</span></p>
                <p class="MsoNormal"><span>Regards</span></p>
                <p class="MsoNormal"><span>Shashank </span></p>
                <p class="MsoNormal"><span>&nbsp;</span></p>
                <div style="border-color:rgb(225,225,225) currentcolor
                  currentcolor;border-style:solid none
                  none;border-width:1pt medium medium;padding:3pt 0cm
                  0cm">
                  <p class="MsoNormal"><b><span lang="EN-US">From:</span></b><span lang="EN-US"> Marek Olšák <a href="mailto:maraeo@gmail.com" target="_blank" moz-do-not-send="true">&lt;maraeo@gmail.com&gt;</a>
                      <br>
                      <b>Sent:</b> 21 March 2023 04:05<br>
                      <b>To:</b> Sharma, Shashank <a href="mailto:Shashank.Sharma@amd.com" target="_blank" moz-do-not-send="true">&lt;Shashank.Sharma@amd.com&gt;</a><br>
                      <b>Cc:</b> <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                      Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" target="_blank" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                      Somalapuram, Amaranath <a href="mailto:Amaranath.Somalapuram@amd.com" target="_blank" moz-do-not-send="true">&lt;Amaranath.Somalapuram@amd.com&gt;</a>;
                      Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" target="_blank" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
                      <b>Subject:</b> Re: [PATCH v3 1/5] drm/amdgpu: add
                      UAPI for workload hints to ctx ioctl</span></p>
                </div>
                <p class="MsoNormal">&nbsp;</p>
                <div>
                  <div>
                    <p class="MsoNormal">I think we should do it
                      differently because this interface will be mostly
                      unused by open source userspace in its current
                      form.</p>
                  </div>
                  <div>
                    <p class="MsoNormal">&nbsp;</p>
                  </div>
                  <div>
                    <p class="MsoNormal">Let's set the workload hint in
                      drm_amdgpu_ctx_in::flags, and that will be
                      immutable for the lifetime of the context. No
                      other interface is needed.</p>
                  </div>
                  <div>
                    <p class="MsoNormal">&nbsp;</p>
                  </div>
                  <div>
                    <p class="MsoNormal">Marek</p>
                  </div>
                </div>
                <p class="MsoNormal">&nbsp;</p>
                <div>
                  <div>
                    <p class="MsoNormal">On Mon, Sep 26, 2022 at 5:41 PM
                      Shashank Sharma &lt;<a href="mailto:shashank.sharma@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">shashank.sharma@amd.com</a>&gt;
                      wrote:</p>
                  </div>
                  <blockquote style="border-color:currentcolor
                    currentcolor currentcolor
                    rgb(204,204,204);border-style:none none none
                    solid;border-width:medium medium medium
                    1pt;padding:0cm 0cm 0cm 6pt;margin:5pt 0cm 5pt
                    4.8pt">
                    <p class="MsoNormal" style="margin-bottom:12pt">Allow
                      the user to specify a workload hint to the kernel.<br>
                      We can use these to tweak the dpm heuristics to
                      better match<br>
                      the workload for improved performance.<br>
                      <br>
                      V3: Create only set() workload UAPI (Christian)<br>
                      <br>
                      Signed-off-by: Alex Deucher &lt;<a href="mailto:alexander.deucher@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
                      Signed-off-by: Shashank Sharma &lt;<a href="mailto:shashank.sharma@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">shashank.sharma@amd.com</a>&gt;<br>
                      ---<br>
                      &nbsp;include/uapi/drm/amdgpu_drm.h | 17
                      +++++++++++++++++<br>
                      &nbsp;1 file changed, 17 insertions(+)<br>
                      <br>
                      diff --git a/include/uapi/drm/amdgpu_drm.h
                      b/include/uapi/drm/amdgpu_drm.h<br>
                      index c2c9c674a223..23d354242699 100644<br>
                      --- a/include/uapi/drm/amdgpu_drm.h<br>
                      +++ b/include/uapi/drm/amdgpu_drm.h<br>
                      @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {<br>
                      &nbsp;#define AMDGPU_CTX_OP_QUERY_STATE2&nbsp; &nbsp; &nbsp;4<br>
                      &nbsp;#define AMDGPU_CTX_OP_GET_STABLE_PSTATE&nbsp; &nbsp; &nbsp; &nbsp; 5<br>
                      &nbsp;#define AMDGPU_CTX_OP_SET_STABLE_PSTATE&nbsp; &nbsp; &nbsp; &nbsp; 6<br>
                      +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE&nbsp; &nbsp; &nbsp;7<br>
                      <br>
                      &nbsp;/* GPU reset status */<br>
                      &nbsp;#define AMDGPU_CTX_NO_RESET&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0<br>
                      @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {<br>
                      &nbsp;#define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK&nbsp; 3<br>
                      &nbsp;#define AMDGPU_CTX_STABLE_PSTATE_PEAK&nbsp; 4<br>
                      <br>
                      +/* GPU workload hints, flag bits 8-15 */<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT&nbsp; &nbsp; &nbsp;8<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_MASK&nbsp; &nbsp; &nbsp; (0xff
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_NONE&nbsp; &nbsp; &nbsp; (0
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_3D&nbsp; &nbsp; &nbsp; &nbsp; (1
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO&nbsp; &nbsp; &nbsp;(2
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_VR&nbsp; &nbsp; &nbsp; &nbsp; (3
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE&nbsp; &nbsp;(4
                      &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +#define AMDGPU_CTX_WORKLOAD_HINT_MAX&nbsp; &nbsp; &nbsp;
                      AMDGPU_CTX_WORKLOAD_HINT_COMPUTE<br>
                      +#define AMDGPU_CTX_WORKLOAD_INDEX(n)&nbsp; &nbsp; &nbsp; (n
                      &gt;&gt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                      +<br>
                      &nbsp;struct drm_amdgpu_ctx_in {<br>
                      &nbsp; &nbsp; &nbsp; &nbsp; /** AMDGPU_CTX_OP_* */<br>
                      &nbsp; &nbsp; &nbsp; &nbsp; __u32&nbsp; &nbsp;op;<br>
                      @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {<br>
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __u32&nbsp; &nbsp;flags;<br>
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __u32&nbsp; &nbsp;_pad;<br>
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } pstate;<br>
                      +<br>
                      +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct {<br>
                      +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__u32&nbsp; &nbsp;flags;<br>
                      +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__u32&nbsp; &nbsp;_pad;<br>
                      +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} workload;<br>
                      &nbsp;};<br>
                      <br>
                      &nbsp;union drm_amdgpu_ctx {<br>
                      -- <br>
                      2.34.1</p>
                  </blockquote>
                </div>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------JdTSK2CDwiaoDb3kxj3nwy0B--
