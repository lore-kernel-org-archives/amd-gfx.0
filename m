Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E47C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD55361A08
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD55361A08
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070B46E426;
	Thu, 30 Sep 2021 14:40:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9006E426
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 14:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Trnt69K3TzzpIm07DDAMG3jJluD9gC+kux18zKf71mvQpJN96aAUjaEvp17cJBpi0+hwOy7dE5Et4DbyGed/4ia9E5ZzQNZKSE+iOEaiEb1RJEc1DDjaeHD1sUoC8DwzXKxnwNFejC4LwcJp084dUALlNZL31NBFYUa7zqAu4BEA62n/I77ag86VPi9XQLGMvsv9FCIjZYkkHFIMeS4DkCM2Dh0+Am0zxRUUY4udkFuJGdbSLJfltyB3obncvLDz9+/sfLS0xPOX/UJ12SgigpaWN1ziwW6GeQ429PN3YNZA3XrvN85hYKxw/agy61nl2fZ9jDx7EYeMwIMvobhVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=M7yiwgkk+3AAxEydyo/mdGvkgmLCKVssCzpoMYqjlos=;
 b=C53KDqBj4x2NEsKPclKPfxGBPNGxNNw9KLB+8wO6QbJGAV8XSys12tGHAmN6ZBb4feHfyKgkMDviyqi5bGbF97K88QkPX3FuXbkOl2Gj9udyWeTjxrnlR8mjj4MjKPnbgxJFwWZ3/OaWXuYS/u3lh0bpuFDmSqnxWQnN8CafJd8fR073oXVpMn6otAICcFkChxf+yblSCQN4Mun/jboz2gdZlINDqeJMeDV8aEqP5LJEUc1tX2ScRSk7o0VCxmJHo65pJCUutd6smWZqlgCyHnmH5m2YtpX4jTZCmgmOJPBHvBl5MuRkBItsUMiLfbSvdwcJshuBFaqai64ttntbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7yiwgkk+3AAxEydyo/mdGvkgmLCKVssCzpoMYqjlos=;
 b=NTYbZuoLtAuFdPjgxegjGu0Ogr8DDdCYuYdkMFCKWZvwTkBn8M9/Epj4frQmgKxt+cBQ8MrRljnb2QvbtlRMRUlA03Ctg8HBhyGAU6V1B/2J+do65mVvtfSeFz7nNXDG47tI7IqIV4xWcoO2YtHXD/QaQrsQXLvdnW1KYByyivE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 14:40:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 14:40:16 +0000
Message-ID: <2e915328-cb03-4bbe-4e15-d7bc735fa39c@amd.com>
Date: Thu, 30 Sep 2021 10:40:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 02/02 v2] drm/amd/display: add cyan_skillfish display
 support
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Mike Lothian <mike@fireburn.co.uk>
Cc: "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, Charlene" <Charlene.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
References: <CH0PR12MB520112519F74BF4E6F2A9FAE9EA79@CH0PR12MB5201.namprd12.prod.outlook.com>
 <CAHbf0-FbZqpR=F1eteqtNo6X45ZvBNP-2FF4oEg_0W0+7Mu2gg@mail.gmail.com>
 <CADnq5_MQao2NuE3+oQXzvyk8=3Wuu8g-aD=usKr0p++4NpEMYA@mail.gmail.com>
 <CADnq5_OZFdXQLOsaN+1QB=mg-t0GSrZ_XkaLEjBPBdB3rF5YLA@mail.gmail.com>
 <CADnq5_NPe2Qq6bXifsFis5tfe=2Uh4nwOZ4RubfhezkvcPucZg@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_NPe2Qq6bXifsFis5tfe=2Uh4nwOZ4RubfhezkvcPucZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:408:e6::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.44.122] (165.204.84.11) by
 BN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:408:e6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13 via Frontend Transport; Thu, 30 Sep 2021 14:40:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7598b750-3695-44c5-7e61-08d9842037c2
X-MS-TrafficTypeDiagnostic: CO6PR12MB5411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5411740D3C7750F1D82251EB8CAA9@CO6PR12MB5411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvmIOf9fBM7LhB6Rc5zFJ1DHMhVq39MV8zOhiXm0G32xnZbV6M+aHhrNqLZ2/pPBJJAICBg9huUfa7SfpQcqAHiSvB86BmhxIu+2eLF1/+JOp9c5w5yMsdd4IZ53HUaaHsnMTUbhqq9AhtU/URHtGlLKaJ5FHjEC3o44/BBGmKuo8jQ72ecEnI9zxLgry7NYjj+HXx6oA2vVyX1+4p8/hMoImftz+Uz8l943ImpMChrVqAsZoArDZ9cGdwjO80tuoz3td8tJ8299yOjvzcoTR4Zoql9GO2CMA3e1WlLI1MigPYRMDIkLpNgKAmBXkozszgW39DenjqTYdUF1QSzEY56UXI8pk8i5G6rKvLYGQ3JjL2WYYrHIrhhqeQm7Vu/4woNq8rAXMiDD9Scko2HtN2RU7ga5Sq3uVd+kg/bZOWc7ii0L3z80/lnukqMzCFV6/AFc3LtOKIUSNBx2Za1xgUf0JFWj0Kig/AyNlGTraAgSJwtJUd0wpGk6layvm97OLhRF0yPm0obi9VT50ivhQNQwkR8a1eqDV5KZgdIewcTl56vwGr28XUXOqvZ+vhFmmuY6N2gVcVGw6xHNgN3utfTMbYCoBQw/1HLFMxLclQm7Ff6BbcEdAKp5s2jzhO9gNLfR9cQ0PAc4Ge5EvXDrORdY36ANfLa5HFUSwQzXTLH++PvkRM19aUjP4nwDG6ifh6QzsImIKvVrKCdTopspTq3vRhY2PAK2CAUu2SwYjNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(31696002)(110136005)(31686004)(8676002)(6666004)(6486002)(8936002)(53546011)(4326008)(54906003)(16576012)(2906002)(86362001)(316002)(44832011)(26005)(66476007)(38100700002)(36756003)(2616005)(66946007)(66556008)(956004)(5660300002)(186003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFo1TGVpUWNHUklZNjlsbE04MWZrRVd6SjB5Wnp4a2xJWWJQbmVucUZqVmxN?=
 =?utf-8?B?OHBvMWlla1RJR3pMaHBJM2d4YWVRZEEraEFpY3gzUnJnNWMwdkwxZElpZGtv?=
 =?utf-8?B?YUN2SGJQZ2M3SWRjbVhCVk9vaFRCc280dXoxMzF0SmhpclJ5M0FxYnVXemJs?=
 =?utf-8?B?OTBXWFZzQ05EQ0NpNXY0bHZHa2FXaVMvQmJxV0tLcFdRSGg5eFNTRTRra2o3?=
 =?utf-8?B?Mk0xSmdZWkhkNmRYcnc0MWRLRmprL2thQ09IaXI2aXZWaUMxNHBHQVJFcWg5?=
 =?utf-8?B?SklkeUdkUHhIb1pNM0ZKWGdRYzd5Q1dYelBXZFRhVC9qcXIxZUNhTXhxQjRR?=
 =?utf-8?B?MGtzL0tiZGdwV3dVZDZHcTA3SEhVT0RXR214NVlDMExaZUpWYVJVc2wwcnZX?=
 =?utf-8?B?Z1FpeUkzaDZweHhVMnlrdlF3eHF2RnVQUnFFVi9sVzFuOEY3SEw0VzZiOEY2?=
 =?utf-8?B?dzB4RmJNVnF0M2dDUTNPZG10WWs5SksxYmdXVEYwMW5wcG9iRHV6cHpyTFBL?=
 =?utf-8?B?SXZ2SXRTNGY3UFFlWFl6L3gwR0k1ZnZjZGFoODdwOTM0alN3cWVYazVOVUJS?=
 =?utf-8?B?dmFIRENMUnd6MDNacmNiRDJRcXlud0h0a3VwY05xNmFkdExZeXJ6dStUc0Iw?=
 =?utf-8?B?b1ZLM0R0bDNiZFRWNU5jS1oxSEJJUU14dStyME9KK09zblM2SWJJN2FyTEF1?=
 =?utf-8?B?bCs4b1VnNGlqcVN5NklQdytUMmZ1TmFVcy9sTlJBMktYRlRRTXl1TXNUUVdW?=
 =?utf-8?B?c2M3dzE0RVF5QTRobEZodlBnS1hoYkZ2ZlJjWnlHYjJrdWh5MGt6V1J0YzQ1?=
 =?utf-8?B?ZU4xVjFjMTJjOUI1VXlYQnl3YXRnMmVRSHRCeFRHZk5wVGVHemFDZUpJd00v?=
 =?utf-8?B?RnNZd1pVR1o0akxqMS9aUlZCK2lGTzZzTGdtanBZaDdUaVhvYm8rOXM3d044?=
 =?utf-8?B?VXJnSFhhdkEwWW9iSkN1KzIwRllyOUJ2ZGNla2FmRTZCK01RcTRaRVFZUGFK?=
 =?utf-8?B?T09mUUlyS0FHd2V1dFBFMDlQRnVWbEQ3STZFWHJmTDJ1ZEV2bUhpZ0dWYVRF?=
 =?utf-8?B?aXQrb2tuNzZpdUdlTTlNc0tZVGFNMHB3Y3JJWVk1RDB4Uks3aWc4U1RtcE1R?=
 =?utf-8?B?UXJ6L1lsb0ZVUVdTM1FIVFBDWFFCY05XWW92cnBuempUSVk5dEFjakFwZjhB?=
 =?utf-8?B?YU9JV2ZmY2tHN2J4UzB5b1Y5RFJ6K0tKeUZucDczdEZnOEQwa3h5anViZ3kx?=
 =?utf-8?B?SXhQbWNENHdKUkdYdEJJa09GT3ZmUDhvWElqS2VYaEFVSGxrWERaQW1jOFVK?=
 =?utf-8?B?OUUvTlJjaXRiWXJrYThFSnVKVUowQzdWb28zZDZqRWRtRC8wR21Wek91YUVu?=
 =?utf-8?B?SVRNdjVsSGU1dEFtNmZTSlE3c0ZBTmtUVWo3U3cwTHFIQUJZK25WMFJ2bjg1?=
 =?utf-8?B?aVZjcG9Gc1ZSaU1TZ3g3YzlzVUkvRHZROFovZ3o2ZHVacVZmRW81cjZhOWZo?=
 =?utf-8?B?WUdiRVVNUk9hcHJEQVA0NFRka2NJOWUxN1ArTFUxc09pZUZxQTI5T0dXSHlu?=
 =?utf-8?B?MGs5MkVzeXdtRitJMGFJeXcxWmI3S1JaRXBSOHE1TXorbWh6RVZVUk9FQ1RE?=
 =?utf-8?B?MUZXWXJ1OGtEalk3bDAvUGltb1gzbURxVkZGR0liR21zRVN1R2JGSXdwRGIz?=
 =?utf-8?B?b0svMWJlSkR2b3UzMHQ5WG0yaTBneE9NTk4vMFA4TU1Pc3pBWUdhT1pNU1ZI?=
 =?utf-8?Q?ulL0Y/i54CWGEQv4Bhz+rXy6tB8GZ7h6WGzcu5C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7598b750-3695-44c5-7e61-08d9842037c2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 14:40:16.0980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uuy9z1OBOtZGFJKf4DjrrQFfO1oIfwCXCYuy7JB1vbIoJNO/o9rm+lHecfFcMnIAAHG6XuhCq7F+BRUsoffaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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



On 2021-09-30 10:12, Alex Deucher wrote:
> On Thu, Sep 30, 2021 at 10:10 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Wed, Sep 29, 2021 at 10:00 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> On Wed, Sep 29, 2021 at 7:23 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>>>>
>>>> Hi
>>>>
>>>> This patch is causing a failure for me when building with clang:
>>>>
>>>>
>>>> Enable DCN201 support in DC (DRM_AMD_DC_DCN201) [Y/n/?] (NEW) y
>>>> Enable HDCP support in DC (DRM_AMD_DC_HDCP) [Y/n/?] y
>>>> AMD DC support for Southern Islands ASICs (DRM_AMD_DC_SI) [N/y/?] n
>>>> Enable secure display support (DRM_AMD_SECURE_DISPLAY) [Y/n/?] y
>>>>  DESCEND objtool
>>>>  CALL    scripts/atomic/check-atomics.sh
>>>>  CALL    scripts/checksyscalls.sh
>>>>  CHK     include/generated/compile.h
>>>>  UPD     kernel/config_data
>>>>  GZIP    kernel/config_data.gz
>>>>  CC      kernel/configs.o
>>>>  AR      kernel/built-in.a
>>>>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/clk_mgr.o
>>>>  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o
>>>> clang-12: error: unknown argument: '-mpreferred-stack-boundary=4'
>>>> make[4]: *** [scripts/Makefile.build:278:
>>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1
>>>> make[4]: *** Waiting for unfinished jobs....
>>>> make[3]: *** [scripts/Makefile.build:540: drivers/gpu/drm/amd/amdgpu] Error 2
>>>> make[2]: *** [scripts/Makefile.build:540: drivers/gpu/drm] Error 2
>>>> make[1]: *** [scripts/Makefile.build:540: drivers/gpu] Error 2
>>>> make: *** [Makefile:1868: drivers] Error 2
>>>
>>> The Makefiles for the new stuff added probably need to be fixed up for
>>> clang like the other Makefiles.  I can take a look tomorrow.
>>
>> I don't see anything off in the Makefiles.  Can you try with a clean tree?
>>
> 
> Nevermind, Harry found it.  patch on the list.
> 

I found a clang build error with dcn201_resources.o, not in dcn30_optc.o.

Not sure why you're seeing this with dcn30_optc.o.

Harry

> Alex
> 

