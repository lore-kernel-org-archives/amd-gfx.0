Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191DEC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3121E10E4B0;
	Wed, 14 Dec 2022 22:25:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E47C310E4B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efzCCejj7v2Y9fvWPgXwvr4HWDIqr0rLLAB8+Mtr+z2jjcAkNBvnorUrYTh6Z9iWOOmFgl8aYFBrHOeXvUO9i899XrBECJJQVqQUMT7Lu15DV3Db0806smFuS3+TsmzTalQQOAMwnSLsM7TwvINnFApOEQ9EwyqnNvODeg317DsxPbXQKS+HvPxlrZInMPcj8Pp4QU00yyAbQ+WULttaU+XBmYsuP6ccteLsVB8pPryoijd3BEC2rec7Kyu43E6+Kd1fcaKWJFiS8KtNjHNHE1KS8soZ9LFBFY1dEMD6TqpxgZYrEsKIGJ302G+5LMA4T3BT3x9pJs0am9tk6xtSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmJKyarSaOlvjfuTWTflAdPEtFmkG1oGXCfNS+hE5qQ=;
 b=EuETKoKD6yYk0m0pTfVf4l14Trni5YW0nIjoAf+deqVx4VstpXXIj0iLnqk3/4JyQuPpvFjIKmfMgmJOdhje3GX+oeN9UdpRye8v8tJN/7tNqlJC51Nd1wEDXdg+r2EEIkHSGHG6RTCpvXtB+/lZNZFkwcspv41jZqLLqdKF0vXlCcRReM0GolI1J4X7a9YQGu+pNsv7T9uYuthdDEyKj+BMson1V8QdCs3QO114S0Xm5VsVdFZsCn2FZ1NO+pBFoIkQ1Tazpk7MWhVKwCOUJqPYeCCgnTfdKQz2lJLogqT5d7kTDycVDI0LdW21pTB9kmFAIRSk5UlrjmeolsygsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmJKyarSaOlvjfuTWTflAdPEtFmkG1oGXCfNS+hE5qQ=;
 b=BF6OgR+G0siJAdRtvcMZF7kOQ29NgkFiEogDzFshi4ycB0JFR8jhAVSrFMwLWsOKvN/UaTPJOkSLIKNaZ6GbocC8HfLgJJFux00s9ilRsqQrDNhdwv19+xFa89VlGBDj0QDrHsDNUkvcsmihNECO1+BbY0RPILgUyjGP0GnTKMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 22:25:19 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 22:25:18 +0000
Message-ID: <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
Date: Wed, 14 Dec 2022 15:25:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 232fec33-516a-4be3-27b0-08dade2214d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9txiKPuPIeaDbWAda7QCtx79vdEdxpHPmzMKEc2aztZVU0qqTbaVYiGXHFtJGMuaWsIYrJQv+dX149U9nifIYopZaouwS7Ux3UQpz0OFDkXgvRa6+xO4mwaBcBCaVP8wY+/pfatc7A7j9SWHBaKE0+lEuXKiJi/A/74SVYxyHhuEcXfNEFVfc2YdBUSv+FTIH7Z+WtuMvfCgxDG9YiU380x1s8hU5cG5iL3uoSUwxc9OPeUgfWkeybrT7M276a+VFOo61rlbXU/NyNNPHj1cUG1IxjutWHnCuEJ3AgL5vIN5lxVXW4nwBFnHf4MfyUV9jr6x3bs1O+N6NErx6pkX92U2cbAK4iz5GJULEhG4LfzPfJ5g678w7wt5Z6h7QOgAcba4ounP92d3hJnGg2k9R9WhSBXUjKgTuoeoViBlzdUs7CXkSuMYJmzfW3RjWCRKZAIta4kuJ2U5AHeGUyeB1Y1bK/ymbXE+kuC1yWx9uQwC8rpvEgvG6fGZJ/n20sZ7jQwwOdZrVdYXPK/8+GDbwHK0r5gbOBOza1iPyvKD4NXciHEzpbLCJotiib/bhjHR1p6e54z+V7sRqzCXOvvc0If1OeUk/eu7cvEQQo0C4q2xgNIX2mUKW+0VK2iGHBodU2Z2oNMCKcx+26eRISi4vXtpshgPURmaDkx2C+KOmfjQoi8KTJBZ1ymkdLM6z1H0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(8936002)(4326008)(31686004)(6916009)(41300700001)(31696002)(4001150100001)(316002)(86362001)(66476007)(66556008)(66946007)(5660300002)(8676002)(6486002)(83380400001)(44832011)(38100700002)(478600001)(2906002)(186003)(6512007)(6506007)(53546011)(36756003)(2616005)(45080400002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG84M3dlVjRVcHFaYXYzelYwT2hTWnVRWmsvRlhwNWxmbHFSS2pQTHdnb2NW?=
 =?utf-8?B?aEhIUXJkRktHeTAwb1AwYW56T1dHV200NmVnaUhJTGg0MHFuNHUzLzBtWlc5?=
 =?utf-8?B?amMwUzhjYXB2NGhyVUxlNTI2LzdMN0c0WkFjc0c3aUhBcWc2V0NrSUkyMThk?=
 =?utf-8?B?M0MrbWJvM1hJSVZzVTYxUUNza0FnQTgxc2FFQjZiblN6SUR6eE9QREEyN3ZK?=
 =?utf-8?B?L0EzK3dWSnNvdnhLcWZhQ04rWVl2Mm10NWVKVGhIbVRUVEk1SmxFNDBUZTJh?=
 =?utf-8?B?WVRUbHhYeEFkTlZvSE11dmwwOCtKWnhOV1hhSUVISTR0M2tXdU9mTzVFMkdz?=
 =?utf-8?B?TlVyZ0JybXJSV1JsNWhwSThWS01oNFFtTGY4L3dxNy9xcDluYlpxRElLWlBD?=
 =?utf-8?B?QU9ITHc1ekxXNG9PVWlPZEp4WmZ3VjhUMitjTkdrV05rN3NkbE1jenBxMnBs?=
 =?utf-8?B?R1VlbXFST2k2TmdBVEFxYUs4NUlzOVFXRXp1YnhCa3M1RWhJWEJKK09DbGIw?=
 =?utf-8?B?SlRPTEFQcFB6ZFExOGFWaFZoc1UvZ0FHcDJMRCsrVjljTm41UUIwOHNGSVdM?=
 =?utf-8?B?Rm81VVd1S3FGcitlblJUN0dMYitXUXZ4MmV2bml0TUgrSCtQamZsTmt4NVRW?=
 =?utf-8?B?dmg5Z1krVTFnWDdwMGU3a1pCbWxMQlk0UWJkV0tRK0hYbmsyNUF6M3Z0bTVr?=
 =?utf-8?B?UFcycDhBZVZEeEhwSkMrU1p6NEN2TGlnOVU0QnFDVEsvMzgybGhKVVpGNThL?=
 =?utf-8?B?QmlUdkFiWXk3WnJ2NGQvWkpMOUhxMHhWNGlpOTNJZ2hjczFaWlUwNnppTXA3?=
 =?utf-8?B?WHhrRzhYdVdkY1Frck9Ub3NhWjdWWkFpellkc1ZRd0wzQ1Yrb1ZEM2tscTNi?=
 =?utf-8?B?NE9VU2dPSExBQ1BKRHV5K1RLd01QaTlrVTNtOVYzU2RuelhmejVlU2tiYWlr?=
 =?utf-8?B?MXcvU0lkSTFpbVovYnhkQ1I4OE12ZThHU2taTTIrQVJIcVVDUTFDdENrMVpP?=
 =?utf-8?B?ZFpvZSs4Nmt1YmxsSUJBQjMycDZlb3gzN3lWV0N2b045Z0tyc3dWMkg5VURN?=
 =?utf-8?B?T2RHMHFycGlPclZ2VmxhcFdIdjlDUW5ERHY4NnMzajlJZXJwQ1IzMHRXbmxw?=
 =?utf-8?B?eDhzV05hdTF4Q3hVZGlLZzM1cGNnaFhKSWp6ZGpYbE9DREdha2drWCsyQTBV?=
 =?utf-8?B?Tml4cGJJVERHQUlncnJyU1AzV3VVNEJhRFhUWjhxZTJaQXpGMllQWHA4SW5S?=
 =?utf-8?B?Y3hDMCt5S0NzWWQ5aXVRWFhubWpLWHE1LzRuNFg0SHh5azdpYklTTnViR1ZV?=
 =?utf-8?B?ZHg5c0U5L1NJem1DNU0rQlRwTVdVU1JrT3FHWlNOVGpEUE1nWDNqUzg0MEhh?=
 =?utf-8?B?U3U0MVRGYmtDMEpseUxsK01MMGgzdjZCM20wMlFxZHBJRC9jSFM5NUlGTXlO?=
 =?utf-8?B?TUJWczlKZ1RtaUFIaUo4Wmo5S09zV0EyU2lVdys3dWExR1BQc0MzSWh4ZzBP?=
 =?utf-8?B?bzFhREpYL2J6enM0ZTExMlZ1WEdXMndCWWNRaElEVXJ4aGZYajdqZEh1Rmpa?=
 =?utf-8?B?VSs0eFFGUUxrNmtyRnVFSy9rS2xzVmk3QjB1dkJzT24xT0dFeWlRQmIvdVNI?=
 =?utf-8?B?WC9ZNjlwT1dJM3pjcmlBaFBXUDI0Z0o2dXRvdVAzV1ZYV3FjTmtGWjVZMnBI?=
 =?utf-8?B?Tzk2aVVJRDI3Yk54SFQ4Z0c0d1c0T2d0TG9PQlFxZlRlaTEzMnpoV3NsaWdB?=
 =?utf-8?B?a0FtOEdKbi9ic0JyaWNrSFB2TUtkbG1Obk1RcEJyT3NRL2RXRnI2OGl2Q0dN?=
 =?utf-8?B?NHF2ZGU5QTcxY2hlWkVHTFlKaG1BZ3VTT0J0MUMzSllOOVRHQzZYR1RpVU5k?=
 =?utf-8?B?TGpxejE4enNJQnV6Z2ljNWYyLzNhN1JSOEJGaktxelp3dGhyU3J3VUZTOFFR?=
 =?utf-8?B?Z3V0QTNldVF5ajB5Z1NSdGhQTVpUSHNWdVV4SnF0NVVOWUVVM2x6UDJ4VElw?=
 =?utf-8?B?L0h0V0g4TU05dk03aTRUenFaSFBCR0FQY1hKQkpaMDBNb0t6RngvS01nZzdZ?=
 =?utf-8?B?K01yOGFadWtKRTZ6SnJ3UUpLa0ZIZW9INmMzbDhBTVErNWhWb0ZtMEdBVXBL?=
 =?utf-8?B?NHB2enZCaC9JdUlMeGdvU3ZrdnVNRE1wQzYxTDdDbXhWTXdhWGhCL01GemhY?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232fec33-516a-4be3-27b0-08dade2214d8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:25:18.8029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TCc8IxHUqoNokEeSHm549DjpdYozwDQ6UCeoflk58gdRHb5ZIV3Yts0F/hRXQwpbal4AhuJiTAevtiGFN3dOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-12-14 14:54, Alex Deucher wrote:
> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>>
>>
>>
>> On 2022-12-14 13:48, Alex Deucher wrote:
>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>> <aurabindo.pillai@amd.com> wrote:
>>>>
>>>> From: Alex Hung <alex.hung@amd.com>
>>>>
>>>> [Why]
>>>> When running IGT kms_bw test with DP monitor, some systems crash from
>>>> msleep no matter how long or short the time is.
>>>>
>>>> [How]
>>>> To replace msleep with mdelay.
>>>
>>> Can you provide a bit more info about the crash?  A lot of platforms
>>> don't support delay larger than 2-4ms so this change will generate
>>> errors on ARM and possibly other platforms.
>>>
>>> Alex
>>
>> The msleep was introduced in eec3303de3378 for non-compliant display
>> port monitors but IGT's kms_bw test can cause a recent h/w to hang at
>> msleep(60) when calling "igt_remove_fb" in IGT
>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Figt-gpu-tools%2F-%2Fblob%2Fmaster%2Ftests%2Fkms_bw.c%23L197&amp;data=05%7C01%7Calex.hung%40amd.com%7Cee0c28620f2447f13a8f08dade1dc0bc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638066516634100466%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=mx33srt3RgcA4ZklYVXom9ZQklJjWmcywEtb4qJQVBQ%3D&amp;reserved=0)
>>
>> It is possible to workaround this by reversing order of
>> igt_remove_fb(&buffer[i]), as the following example:
>>
>>     igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]
>>
>> Hangs:
>>     igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
>>
>> No hangs:
>>     igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]
>>
>> However, IGT simply exposes the problem and it makes more sense to stop
>> the hang from occurring.
>>
>> I also tried to remove the msleep completely and it also work, but I
>> didn't want to break the fix for the original problematic hardware
>> configuration.
> 
> Why does sleep vs delay make a difference?  Is there some race that we
> are not locking against?
> 
> Alex
> 

That was my original thought but I did not find any previously. I will 
investigate it again.

If mdelay(>4) isn't usable on other platforms, is it an option to use 
mdelay on x86_64 only and keep msleep on other platforms or just remove 
the msleep for other platforms, something like

-                       msleep(60);
+#ifdef CONFIG_X86_64
+                       mdelay(60);
+#endif


>>
>>>
>>>>
>>>> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>>>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>> index 913a1fe6b3da..e6251ccadb70 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
>>>>                            * After output is idle pattern some sinks need time to recognize the stream
>>>>                            * has changed or they enter protection state and hang.
>>>>                            */
>>>> -                       msleep(60);
>>>> +                       mdelay(60);
>>>>                   } else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
>>>>                           if (!link->dc->config.edp_no_power_sequencing) {
>>>>                                   /*
>>>> --
>>>> 2.39.0
>>>>
