Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148A2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 12:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D9B2072C
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 12:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D9B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9D36E111;
	Wed, 27 Jan 2021 12:35:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114FB6E111
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 12:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiBUPgTYLE2BcIbTJBu6axO9fejTTSRDp83SA2ToJkQfP8pwS/fq4P1Ir/5kJdY2il5sAFQFcEa9QZK/7uet/U8Uj5HVgpsQYXJu04ZAM/BupVrfNx1jU+5vYtUt2skOHHWgpLwo7/irlcO2PE8rqxwptbI9287kqbE2lvI2BCLF/97ddxWzRKzsaA9QfSKJXblnCrmNOL2HMrpobXShfBN7j2IsJmfrd9ypi87tBurag/WFBnYs1bar6K/RZbVeh3b7coRbkFyWOxubb0x8bzfmG6Ulf+75veEnZVRBR2qKORBoSyiTkOhtGB+mXeowm0CNP88lEV49RKrVZ2vyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adRB8D6qWybWaCppLT4Dg+CdmydZptq3zcLxg7G7dEg=;
 b=hPEbPinUpGu89XjsmF6VKB4Zq99+lA9aBNpCL1UWXlA6YyYrly4pLz5hwS6qyUzf8L+CMDxN21ATpvbUyINjKaZbvQ5eyKZfL5qiGDqzxIHwh3Vqdbk60pxGPhuUdhHY3GzCH4VYONIhYwxVCbyHekJ/WJeh0fxecWXd+gLs8DRXGsSbU+6bWhqtgMDUTX01+JT3Cyr4BTYVKEi8fuTIjwJy6eeljdjnolBtNl5wNoSzkU0+l8s/L4LX5Os/BEE6NQTkBBV+3EaCzfhNkHvRNIXj5j7JUvfKm1I5Dgz7VmrJ3MlYe9Un1OTHpM6do3EQ/yIXtBeB7BpnxsP8I08XkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adRB8D6qWybWaCppLT4Dg+CdmydZptq3zcLxg7G7dEg=;
 b=0uiE9jumpD1ftxHnvHlXpHsJ9rDGCsmhrCLB1pOaRhudVFx9kLpGMUQnIm3//VvFCyK+0tr1G+/cvpBrF7+GvpfDFGyaEt1g8qDRc5RMJ1onaenZxDm1ragty7+qnR8vvuONjPFrmM89xyknLCsXbtLE5JoHsgA1MOlQNwRvF4o=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 12:35:04 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 12:35:04 +0000
Subject: Re: [PATCH] drm/amd/display: Add DC feature flag to disable audio
To: =?UTF-8?Q?Ernst_Sj=c3=b6strand?= <ernstp@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210126143155.16479-1-ernstp@gmail.com>
 <CADnq5_MzCdBnmZ4e8PckzK7wjA7DdsRaQ35gqi=H=TJ7_OWcmw@mail.gmail.com>
 <CAD=4a=W-K1Zf64Bqhpzby-nX-iYYnuVZeX55w8JC0=F20x5Mtw@mail.gmail.com>
 <0115f891-d4a8-930c-7095-cbb45ec1df01@amd.com>
 <c9c2a670-4f82-adb5-8ecf-fd80652203c7@gmail.com>
 <CAD=4a=WiL5m0jJOgEDe9xrM3bsX1Xt+YTtV_WY5_j+sAOEGe=g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c81df6d6-de72-e4fb-2c43-d2220f325a3e@amd.com>
Date: Wed, 27 Jan 2021 13:34:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAD=4a=WiL5m0jJOgEDe9xrM3bsX1Xt+YTtV_WY5_j+sAOEGe=g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0195.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0195.eurprd02.prod.outlook.com (2603:10a6:20b:28e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend
 Transport; Wed, 27 Jan 2021 12:35:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de188069-659f-4e92-975f-08d8c2bff8ca
X-MS-TrafficTypeDiagnostic: BL0PR12MB4948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49481069E5CB5A8A15E1F98383BB9@BL0PR12MB4948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onvZ1tou2D4CBFBrN21MHKAsEcgmmVuggzIdnPvv0JcOFGr/q//YDpa3ObKzWAqq/uynmoEgOy7tIO931jU84VHb/K9pz0g5vDGzRVYzM9fxYcrrmHrjp31aA3FOacVpU0ozibDP345MhOfDvQeLzuxwYgvFLVt0WdHxtCBJLDlUNe0bWt5kK6CgksiGYW6M7YN5gRBwudi10eno/rMmQhO9F4s4SpdrBW2oUnzniVfEamhnj6nCOBkl44lVEy+7gLByknlEHr8Flfw8kTxWM/drq9NWwBT1hP7EO+JXcRmDOPBmJY2Q9hsBcfPcb+TWVn+Vw34JjVZYuMOncdBjUziOoXKUCt3J3Hno1EMLutlhygzyhhwWpMR9GcHNcYOuIL46tLbvkqe2XwizZmnCP4hiCqXW/xmPYUwBhX1qH1C0OGn5ze6OkcYArX5r8YfGVt5FCaEqMNPT1JLY8TG+98lhvfpKZo2F36OGJTyj9ju3DrvN0FGtM2QLAqAMBMuSW8PVM9xoaV3gf+FUDrt1I8ufnverSiBzqTTqQ0v3xphtlDoiV2fNMjiRQi1/DAADmtZ5oaUYSydnjhqkpSdDHVnd2eYPzyL79pvz8gbqhpjseYNSOUffpI/DLdxwwbmx4XaTEQ7C3rSqIqKMlgbk+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(966005)(31696002)(31686004)(66574015)(6666004)(30864003)(36756003)(16526019)(86362001)(316002)(66556008)(8676002)(2906002)(83380400001)(5660300002)(6486002)(52116002)(4326008)(66476007)(54906003)(45080400002)(8936002)(2616005)(186003)(53546011)(66946007)(478600001)(33964004)(110136005)(166002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M3NkOE9sdUl6cVJjS1QyNDBydjh0LzRaOXlqWVV4eUFYVVJ5dW4xWEpXbmRC?=
 =?utf-8?B?dkFPYXZzT3YyODk5S0svYUVWZS9ONWtabjVYL0xXa1Q0TE1DaWdtbXNNSmpa?=
 =?utf-8?B?ZkZ4QlBSaWQ4c1hndXc4bnAwUDJYTzY5K2xCaEp4VnN3TzA0bXAyN0hDREVx?=
 =?utf-8?B?d1phSGRoQnFDdWtVMmFjTEJaSC95aU9lcGk4MmVITlZ3UnVHWkVkNCtGb2RI?=
 =?utf-8?B?d2tWQ05pU2RvK2czaSs1bzlzRTFYekpKTjBXc21QaHZMdFduZ3BUSFp6MnN4?=
 =?utf-8?B?R0p5VGZadXBTMzAyL2srSlhHTloyTnJkNDdmRDhTbzJyS0xMeW1PNVFRcHRP?=
 =?utf-8?B?ZmJNdHk3ZWl3b09SSW16WGNPM0tmNVhpZEhIUEFhWDRmeXNydW1HN29WcW0z?=
 =?utf-8?B?T25BdDlQZWRBMkoxVGNJZGFVc3hiT2ZReU1Sc1U2aDE0bUxQd1AwV0xuUWor?=
 =?utf-8?B?ak1ua3FIWW52U3VoVWJzd2EzYWUybE5DckFtRk1ISXk1QytoMzJZUTc0N2FI?=
 =?utf-8?B?Ym1YMkZ4QkcwSjVLRXZzc1I3ZzJDK2xyY25CbTRnM2UrcG5icW1kbmVTaXk0?=
 =?utf-8?B?U3R5WlhYRC9FSTVhSHMvMmU1OXlpSDFBZ2E0SVVhWFVkTGhJWWJkRlJrdjN1?=
 =?utf-8?B?cHhXV08zTzA5MDNEOVcrQTYxSTJQU0dyYVBobzNxLzhHZGRwQ01oTm5VZHIr?=
 =?utf-8?B?bDRiWlRZMEJHTVlhcXI2UTh5S2s1alZnRmY2Z01vZzFWd2trWUN1TXNxdmVI?=
 =?utf-8?B?elVZR0hjMHlQOUxocEd6bEkzUHdYMTZwU3FSYmFmMys4cFFxNGVQVERRNXZ3?=
 =?utf-8?B?bGhhZEdnWFRFYU1JSXBiNk5Fa0VNOVUyMExYaFh2R2NCTVFoWk83NzMzQW8y?=
 =?utf-8?B?eGFlZGkwaE02QXlSQW5jR00wQkNTc2xtUC9ERm9QY3Y1b0gySE4wWVA3NDlU?=
 =?utf-8?B?SmptN3BMMGN3ZjhYMnZHTkRZOERMakhweS9mYjlnTlNXaFlSUWlZd3paODFZ?=
 =?utf-8?B?OVplRVlWbWl1d1drN1g0cFpFcEtHTmoyU09Nci8yayt4a3JMUFhFV3FRRDZR?=
 =?utf-8?B?eFc4clI5aFlEVmZRQ3NPaFl4SkFtdWpyRFB5aWdLazVvMmxzdEI2SEF4VHJ1?=
 =?utf-8?B?Q29TcWVXTFVXeVJubUVjbVUwR1R5VlZVK0ZUYzhXays0aWYwZmFSTkZCL2hk?=
 =?utf-8?B?ZHZqSkVDOEEvTlI0Z1ljaTJWbmlEUThhQ0RRQXdRVVVpa05wV0JvSkpneU5i?=
 =?utf-8?B?cGJjR3JweGYxV1A4MmpvZUhDdGZLUCtPYUxvNmRZS3RyWkZNTCtsMTFvTjRY?=
 =?utf-8?B?L3BVZkwrN1dRcjVsQnRWRzZqeEwyTFI2Rm01NTVrRUduUjByc3lqRldrcGx4?=
 =?utf-8?B?QmNNUEhDbDNQNWZmUlR4NGREQldGZDlqRExFVzNVbmNTQ2UxVTc4SWxvajVQ?=
 =?utf-8?B?alBGOFVmSHltaTRyNXppRExNTzZPSm1CdzRVb2xBVy96Q2hKR1V0bUc5Qith?=
 =?utf-8?B?RVB2NWNtK2FmUjFKOWU1VXd0R282N0xYVEdhaUtOaGVFSSszZUlNai9pV3VD?=
 =?utf-8?B?UzFEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de188069-659f-4e92-975f-08d8c2bff8ca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 12:35:04.3892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrh883WuH9tvzxeoJzD0I7tWlgKaG/g113PyqAeGmtvK1XtGfyDTx900OPwiCzOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: multipart/mixed; boundary="===============0275204047=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0275204047==
Content-Type: multipart/alternative;
 boundary="------------314C281FA49E4B1FE3864C5F"
Content-Language: en-US

--------------314C281FA49E4B1FE3864C5F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.01.21 um 13:23 schrieb Ernst Sjöstrand:
> Just some additional thoughts...
>
> The amdgpu driver already supports this as I mentioned, however only 
> for the non-DC codepath.
> "Set HDMI/DPAudio. Only affects non-DC display handling. The default 
> is -1 (Enabled), set 0 to disabled it."

I've added this because I completely reverse engineered this roughly 10 
years ago without any hardware documentation.

>
> Linux doesn't have a good infrastructure to disable sound cards afaik. 
> If someone has 6 displays, do they really need 6 extra sound cards? 
> Minor thing, I know.

Well yes, that is intentional :) In general the kernel should expose and 
manage all available hardware.

What you do with that in userspace is a completely different question.

Christian.

>
> It was very easy to do, and didn't feel intrusive.
> //E
>
> Den ons 27 jan. 2021 kl 12:11 skrev Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>>:
>
>     Am 26.01.21 um 17:15 schrieb Harry Wentland:
>     > On 2021-01-26 9:51 a.m., Ernst Sjöstrand wrote:
>     >> No problems with amdgpu, but when my headphone port is glitching I
>     >> often end up with some HDMI audio output selected instead.
>     >>
>     >
>     > Wouldn't this be better fixed in the audio management service, like
>     > PulseAudio? It sounds like it's not remembering your preferences
>     > correctly.
>
>     Yeah agree. A feature like this in a specific hardware driver is
>     justified if it prevents hangs or something similar.
>
>     But this just sounds like a problem in a higher level of the stack
>     which
>     should be fixed hardware driver independently.
>
>     Christian.
>
>     >
>     > Harry
>     >
>     >> It also cleans up the clutter in the audio selection list.
>     >>
>     >> //E
>     >>
>     >> Den tis 26 jan. 2021 kl 15:34 skrev Alex Deucher
>     >> <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>
>     <mailto:alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>>:
>     >>
>     >>     On Tue, Jan 26, 2021 at 9:32 AM Ernst Sjöstrand
>     <ernstp@gmail.com <mailto:ernstp@gmail.com>
>     >>     <mailto:ernstp@gmail.com <mailto:ernstp@gmail.com>>> wrote:
>     >>      >
>     >>      > With the pre-DC path you could set audio=0 to disable audio.
>     >>      > This adds a similar feature for the DC path with
>     >>      > amdgpu.dcfeaturemask=0x10.
>     >>      >
>     >>      > Signed-off-by: Ernst Sjöstrand <ernstp@gmail.com
>     <mailto:ernstp@gmail.com>
>     >>     <mailto:ernstp@gmail.com <mailto:ernstp@gmail.com>>>
>     >>
>     >>     Is there a reason you want this?  I.e., is audio causing
>     problems
>     >>     for you?
>     >>
>     >>     Alex
>     >>
>     >>      > ---
>     >>      > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>     >>      > drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7
>     ++++---
>     >>      >  drivers/gpu/drm/amd/display/dc/dc.h        | 1 +
>     >>      >  drivers/gpu/drm/amd/include/amd_shared.h         | 1 +
>     >>      >  4 files changed, 9 insertions(+), 3 deletions(-)
>     >>      >
>     >>      > diff --git
>     a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     >> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     >>      > index e490fc2486f7..322d9439b9c2 100644
>     >>      > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     >>      > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     >>      > @@ -1013,6 +1013,9 @@ static int amdgpu_dm_init(struct
>     >>     amdgpu_device *adev)
>     >>      >         if (amdgpu_dc_feature_mask &
>     >> DC_DISABLE_FRACTIONAL_PWM_MASK)
>     >>      >  init_data.flags.disable_fractional_pwm = true;
>     >>      >
>     >>      > +       if (amdgpu_dc_feature_mask & DC_DISABLE_AUDIO)
>     >>      > +  init_data.flags.disable_audio = true;
>     >>      > +
>     >>      >  init_data.flags.power_down_display_on_boot = true;
>     >>      >
>     >>      >         init_data.soc_bounding_box =
>     adev->dm.soc_bounding_box;
>     >>      > diff --git
>     a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>     >> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>     >>      > index 68b65a090d17..4cc0d2308c98 100644
>     >>      > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>     >>      > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>     >>      > @@ -2141,9 +2141,10 @@ enum dc_status
>     >> resource_map_pool_resources(
>     >>      >                 true);
>     >>      >
>     >>      >         /* TODO: Add check if ASIC support and EDID audio */
>     >>      > -       if (!stream->converter_disable_audio &&
>     >>      > -  dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
>     >>      > -  stream->audio_info.mode_count &&
>     >>     stream->audio_info.flags.all) {
>     >>      > +       if (!dc->config.disable_audio &&
>     >>      > +  !stream->converter_disable_audio &&
>     >>      > +  dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
>     >>      > +  stream->audio_info.mode_count &&
>     >>     stream->audio_info.flags.all) {
>     >>      >  pipe_ctx->stream_res.audio =
>     >> find_first_free_audio(
>     >>      >                 &context->res_ctx, pool,
>     >>     pipe_ctx->stream_res.stream_enc->id, dc_ctx->dce_version);
>     >>      >
>     >>      > diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
>     >>     b/drivers/gpu/drm/amd/display/dc/dc.h
>     >>      > index 71d46ade24e5..2ab6d770c66b 100644
>     >>      > --- a/drivers/gpu/drm/amd/display/dc/dc.h
>     >>      > +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>     >>      > @@ -297,6 +297,7 @@ struct dc_config {
>     >>      >         bool multi_mon_pp_mclk_switch;
>     >>      >         bool disable_dmcu;
>     >>      >         bool enable_4to1MPC;
>     >>      > +       bool disable_audio;
>     >>      >  #if defined(CONFIG_DRM_AMD_DC_DCN)
>     >>      >         bool clamp_min_dcfclk;
>     >>      >  #endif
>     >>      > diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>     >>     b/drivers/gpu/drm/amd/include/amd_shared.h
>     >>      > index 9676016a37ce..7202d816a97e 100644
>     >>      > --- a/drivers/gpu/drm/amd/include/amd_shared.h
>     >>      > +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>     >>      > @@ -220,6 +220,7 @@ enum DC_FEATURE_MASK {
>     >>      >         DC_MULTI_MON_PP_MCLK_SWITCH_MASK = 0x2,
>     >>      >         DC_DISABLE_FRACTIONAL_PWM_MASK = 0x4,
>     >>      >         DC_PSR_MASK = 0x8,
>     >>      > +       DC_DISABLE_AUDIO = 0x10,
>     >>      >  };
>     >>      >
>     >>      >  enum DC_DEBUG_MASK {
>     >>      > --
>     >>      > 2.27.0
>     >>      >
>     >>      > _______________________________________________
>     >>      > amd-gfx mailing list
>     >>      > amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     >> <mailto:amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>>
>     >>      > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C3354fa4fd15e44cf893008d8c2be6eae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473470463299654%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=z7%2FzAtqTi3XNYmiX3xe7u9IhsxpwclmNIlQUAEolFnI%3D&reserved=0>
>     >>
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7CHARRY.WENTLAND%40amd.com%7C736532bfba5d4b96e9ac08d8c209e99d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637472695123517788%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=1MWOfMfaIhdV%2BcnH%2BeAC0aRqb9BMVrdvReZBKG2ZJSc%3D&reserved=0
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C3354fa4fd15e44cf893008d8c2be6eae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473470463299654%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=z7%2FzAtqTi3XNYmiX3xe7u9IhsxpwclmNIlQUAEolFnI%3D&reserved=0>>
>     >>
>     >>
>     >> _______________________________________________
>     >> amd-gfx mailing list
>     >> amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C3354fa4fd15e44cf893008d8c2be6eae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473470463309647%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=P1LjkrSmbCSv0NuUJiS3aMO2poxzg3BzrlYr2p%2FSISw%3D&reserved=0>
>     >>
>     > _______________________________________________
>     > amd-gfx mailing list
>     > amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C3354fa4fd15e44cf893008d8c2be6eae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473470463309647%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=P1LjkrSmbCSv0NuUJiS3aMO2poxzg3BzrlYr2p%2FSISw%3D&reserved=0>
>


--------------314C281FA49E4B1FE3864C5F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 27.01.21 um 13:23 schrieb Ernst
      Sjöstrand:<br>
    </div>
    <blockquote type="cite" cite="mid:CAD=4a=WiL5m0jJOgEDe9xrM3bsX1Xt+YTtV_WY5_j+sAOEGe=g@mail.gmail.com">
      
      <div dir="ltr">
        <div>
          <div style="font-family:arial,helvetica,sans-serif" class="gmail_default">Just some additional thoughts...</div>
          <br>
        </div>
        <div>The amdgpu driver already supports this as I mentioned,
          however only for the non-DC codepath.</div>
        <div><span class="gmail_default" style="font-family:arial,helvetica,sans-serif">&quot;</span>Set
          HDMI/DPAudio. Only affects non-DC display handling. The
          default is -1 (Enabled), set 0 to disabled it.<span class="gmail_default" style="font-family:arial,helvetica,sans-serif">&quot;</span></div>
      </div>
    </blockquote>
    <br>
    I've added this because I completely reverse engineered this roughly
    10 years ago without any hardware documentation.<br>
    <br>
    <blockquote type="cite" cite="mid:CAD=4a=WiL5m0jJOgEDe9xrM3bsX1Xt+YTtV_WY5_j+sAOEGe=g@mail.gmail.com">
      <div dir="ltr">
        <div><span class="gmail_default" style="font-family:arial,helvetica,sans-serif"><br>
          </span></div>
        <div><span class="gmail_default" style="font-family:arial,helvetica,sans-serif">Linux doesn't
            have a good infrastructure to disable sound cards afaik. If
            someone has 6 displays, do they really need 6 extra sound
            cards? Minor thing, I know.</span></div>
      </div>
    </blockquote>
    <br>
    Well yes, that is intentional :) In general the kernel should expose
    and manage all available hardware.<br>
    <br>
    What you do with that in userspace is a completely different
    question.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:CAD=4a=WiL5m0jJOgEDe9xrM3bsX1Xt+YTtV_WY5_j+sAOEGe=g@mail.gmail.com">
      <div dir="ltr">
        <div><span class="gmail_default" style="font-family:arial,helvetica,sans-serif"><br>
          </span></div>
        <div><span class="gmail_default" style="font-family:arial,helvetica,sans-serif">It was very
            easy to do, and didn't feel intrusive.<br>
          </span></div>
        <div><span class="gmail_default" style="font-family:arial,helvetica,sans-serif"></span></div>
        <div><span class="gmail_default" style="font-family:arial,helvetica,sans-serif">//E<br>
          </span></div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">Den ons 27 jan. 2021 kl 12:11
          skrev Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am
          26.01.21 um 17:15 schrieb Harry Wentland:<br>
          &gt; On 2021-01-26 9:51 a.m., Ernst Sjöstrand wrote:<br>
          &gt;&gt; No problems with amdgpu, but when my headphone port
          is glitching I <br>
          &gt;&gt; often end up with some HDMI audio output selected
          instead.<br>
          &gt;&gt;<br>
          &gt;<br>
          &gt; Wouldn't this be better fixed in the audio management
          service, like <br>
          &gt; PulseAudio? It sounds like it's not remembering your
          preferences <br>
          &gt; correctly.<br>
          <br>
          Yeah agree. A feature like this in a specific hardware driver
          is <br>
          justified if it prevents hangs or something similar.<br>
          <br>
          But this just sounds like a problem in a higher level of the
          stack which <br>
          should be fixed hardware driver independently.<br>
          <br>
          Christian.<br>
          <br>
          &gt;<br>
          &gt; Harry<br>
          &gt;<br>
          &gt;&gt; It also cleans up the clutter in the audio selection
          list.<br>
          &gt;&gt;<br>
          &gt;&gt; //E<br>
          &gt;&gt;<br>
          &gt;&gt; Den tis 26 jan. 2021 kl 15:34 skrev Alex Deucher <br>
          &gt;&gt; &lt;<a href="mailto:alexdeucher@gmail.com" target="_blank" moz-do-not-send="true">alexdeucher@gmail.com</a>
          &lt;mailto:<a href="mailto:alexdeucher@gmail.com" target="_blank" moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;&gt;:<br>
          &gt;&gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; On Tue, Jan 26, 2021 at 9:32 AM Ernst Sjöstrand
          &lt;<a href="mailto:ernstp@gmail.com" target="_blank" moz-do-not-send="true">ernstp@gmail.com</a><br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; &lt;mailto:<a href="mailto:ernstp@gmail.com" target="_blank" moz-do-not-send="true">ernstp@gmail.com</a>&gt;&gt;
          wrote:<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; With the pre-DC path you could set audio=0
          to disable audio.<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; This adds a similar feature for the DC path
          with<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; amdgpu.dcfeaturemask=0x10.<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; Signed-off-by: Ernst Sjöstrand &lt;<a href="mailto:ernstp@gmail.com" target="_blank" moz-do-not-send="true">ernstp@gmail.com</a><br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; &lt;mailto:<a href="mailto:ernstp@gmail.com" target="_blank" moz-do-not-send="true">ernstp@gmail.com</a>&gt;&gt;<br>
          &gt;&gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; Is there a reason you want this?&nbsp; I.e., is audio
          causing problems<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; for you?<br>
          &gt;&gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; Alex<br>
          &gt;&gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; ---<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;
          drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;
          drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 7 ++++---<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; drivers/gpu/drm/amd/display/dc/dc.h&nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp;| 1 +<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; drivers/gpu/drm/amd/include/amd_shared.h&nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; | 1 +<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; 4 files changed, 9 insertions(+), 3
          deletions(-)<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; diff --git
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; index e490fc2486f7..322d9439b9c2 100644<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; ---
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +++
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -1013,6 +1013,9 @@ static int
          amdgpu_dm_init(struct<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; amdgpu_device *adev)<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (amdgpu_dc_feature_mask &amp; <br>
          &gt;&gt; DC_DISABLE_FRACTIONAL_PWM_MASK)<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;init_data.flags.disable_fractional_pwm = true;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;if (amdgpu_dc_feature_mask &amp;
          DC_DISABLE_AUDIO)<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;init_data.flags.disable_audio = true;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;init_data.flags.power_down_display_on_boot = true;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;init_data.soc_bounding_box =
          adev-&gt;dm.soc_bounding_box;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; diff --git
          a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;
          b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; index 68b65a090d17..4cc0d2308c98 100644<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; ---
          a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +++
          b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -2141,9 +2141,10 @@ enum dc_status <br>
          &gt;&gt; resource_map_pool_resources(<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;true);<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* TODO: Add check if ASIC support
          and EDID audio */<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; -&nbsp; &nbsp; &nbsp; &nbsp;if
          (!stream-&gt;converter_disable_audio &amp;&amp;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; -
          &nbsp;dc_is_audio_capable_signal(pipe_ctx-&gt;stream-&gt;signal)
          &amp;&amp;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;stream-&gt;audio_info.mode_count &amp;&amp;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; stream-&gt;audio_info.flags.all) {<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;if (!dc-&gt;config.disable_audio
          &amp;&amp;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;!stream-&gt;converter_disable_audio &amp;&amp;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +
          &nbsp;dc_is_audio_capable_signal(pipe_ctx-&gt;stream-&gt;signal)
          &amp;&amp;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;stream-&gt;audio_info.mode_count &amp;&amp;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; stream-&gt;audio_info.flags.all) {<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;pipe_ctx-&gt;stream_res.audio = <br>
          &gt;&gt; find_first_free_audio(<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&amp;context-&gt;res_ctx,
          pool,<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.stream_enc-&gt;id,
          dc_ctx-&gt;dce_version);<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; diff --git
          a/drivers/gpu/drm/amd/display/dc/dc.h<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/display/dc/dc.h<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; index 71d46ade24e5..2ab6d770c66b 100644<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; --- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -297,6 +297,7 @@ struct dc_config {<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bool multi_mon_pp_mclk_switch;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bool disable_dmcu;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bool enable_4to1MPC;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;bool disable_audio;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bool clamp_min_dcfclk;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; #endif<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; diff --git
          a/drivers/gpu/drm/amd/include/amd_shared.h<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/include/amd_shared.h<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; index 9676016a37ce..7202d816a97e 100644<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; ---
          a/drivers/gpu/drm/amd/include/amd_shared.h<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +++
          b/drivers/gpu/drm/amd/include/amd_shared.h<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -220,6 +220,7 @@ enum DC_FEATURE_MASK {<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DC_MULTI_MON_PP_MCLK_SWITCH_MASK =
          0x2,<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DC_DISABLE_FRACTIONAL_PWM_MASK =
          0x4,<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DC_PSR_MASK = 0x8,<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;DC_DISABLE_AUDIO = 0x10,<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; };<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; enum DC_DEBUG_MASK {<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; --<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; 2.27.0<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt;
          _______________________________________________<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; amd-gfx mailing list<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a> <br>
          &gt;&gt; &lt;mailto:<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
          &gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp; &gt; <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C3354fa4fd15e44cf893008d8c2be6eae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473470463299654%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=z7%2FzAtqTi3XNYmiX3xe7u9IhsxpwclmNIlQUAEolFnI%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="krmYkxgSfMqwIq7ySynkZkB4cP2mfQL0Vf1k4Ot6hgiJbxhAWim5HbW8JhYn9BWkzSS5ZxB1lX2U0AMMtFvAoqROWuM6rfxg6zoRUwh8EWc6Mf9F+pwQDNopRqYvDtcJRed6sj+gNYJ9X79Zta+ZvDO8i/mZkvwqsBK44+Kgsbg=" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          &gt;&gt; &lt;<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C3354fa4fd15e44cf893008d8c2be6eae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473470463299654%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=z7%2FzAtqTi3XNYmiX3xe7u9IhsxpwclmNIlQUAEolFnI%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="krmYkxgSfMqwIq7ySynkZkB4cP2mfQL0Vf1k4Ot6hgiJbxhAWim5HbW8JhYn9BWkzSS5ZxB1lX2U0AMMtFvAoqROWuM6rfxg6zoRUwh8EWc6Mf9F+pwQDNopRqYvDtcJRed6sj+gNYJ9X79Zta+ZvDO8i/mZkvwqsBK44+Kgsbg=" rel="noreferrer" target="_blank" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CHARRY.WENTLAND%40amd.com%7C736532bfba5d4b96e9ac08d8c209e99d%7C3dd8961fe4884e608e11a82
 d994e183d%7C0%7C0%7C637472695123517788%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=1MWOfMfaIhdV%2BcnH%2BeAC0aRqb9BMVrdvReZBKG2ZJSc%3D&amp;reserved=0</a>&gt;<br>
          &gt;&gt;<br>
          &gt;&gt;<br>
          &gt;&gt; _______________________________________________<br>
          &gt;&gt; amd-gfx mailing list<br>
          &gt;&gt; <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
          &gt;&gt; <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C3354fa4fd15e44cf893008d8c2be6eae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473470463309647%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=P1LjkrSmbCSv0NuUJiS3aMO2poxzg3BzrlYr2p%2FSISw%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="AgEx6lB5XYMuj0DaZIRAHgNvMIRDilSlJBiDJdbnjmSZrcr/2ufW0qSnsbrIC2Tgj50ba95UxOXG9/veoj0d9zcznwlbnDvJLLckL4TUVeL+tkv1aGT/3BusXhPNKEJMdE9XmDTPjfz18Z41lQjiMcnbScmMVizFIYV/HKXVKFU=" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          &gt;&gt;<br>
          &gt; _______________________________________________<br>
          &gt; amd-gfx mailing list<br>
          &gt; <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
          &gt; <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C3354fa4fd15e44cf893008d8c2be6eae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473470463309647%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=P1LjkrSmbCSv0NuUJiS3aMO2poxzg3BzrlYr2p%2FSISw%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="AgEx6lB5XYMuj0DaZIRAHgNvMIRDilSlJBiDJdbnjmSZrcr/2ufW0qSnsbrIC2Tgj50ba95UxOXG9/veoj0d9zcznwlbnDvJLLckL4TUVeL+tkv1aGT/3BusXhPNKEJMdE9XmDTPjfz18Z41lQjiMcnbScmMVizFIYV/HKXVKFU=" rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------314C281FA49E4B1FE3864C5F--

--===============0275204047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0275204047==--
