Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695F8C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 02:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86B510E096;
	Wed, 17 May 2023 02:23:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7831710E096
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 02:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlGENo+jwE55my5ObdB2iQecVadslcXmYvTlmhRoUpOBetiDzanR53vUjawGpOaivsEDbGVFoGWKlFWPUQaZ1bUCyjSj0gzXrfs6MITzncJIQD1u8/t3qFGW99z8bnLAJeU0yA+Ha0HzYSbfuwoZg0cgFkeqec3dg0jSNOQB9Mn45uI/ErXvTdCOuqFyGfVFPqQdppY+t7ww8Irz8cpXKMaiT3OCQfmn+yl8NZwPZCzMnySYp0wGUM2Ncves5TkjV6+g7cxV3asL19cFdmiYIegAhelRdXrLVDBEOLf556JFifKQ1egX3jRlaxxvFjFiMFPBobjWwd/r9gfF5baS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhprcoRWP0bLK1nxM6Dh9M9FRdE7UO/jiZzUikxWuUE=;
 b=a8OHxopx49nnfnq9ovUK+GWm+7fBOY+Zzaqydf0cITTRqiK4BSliJuWh+eUIVj++E6CB6qqyvv6gBgFgQ1SPilOLpUlJWPljEEn2Nk71cLrHXfP9dophG97E7JKT3oTR6EI6pAvcdjQOKa2iHZw379XublpZBMsSInZinMNbkR+KW7EzdAMmETBf8+138devNqFAKOzuVYdzyV6+C6yJvCygPqBdR6FB7OcRFVVtNIVQOME0rVvLoj5n/pPgj8lTFzCqbRm5LwpfFIfCWDEULVVhOW+X2ai+pwj5jtIQx2dy7wpv1NVPgqgMkVCH6en0t8zJJvgrG6baveNKJiySfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhprcoRWP0bLK1nxM6Dh9M9FRdE7UO/jiZzUikxWuUE=;
 b=S9DPaI6canFDN0Ket0O2SxZIQJm8h+tg4MnqKcUVtzWD+X+jar9KOmAYhURm0pjyrcZISMkSUkYZjl18RCFgCqLfkWKpQzk25SPt3dTC543wgwu58FdOqEC64wBGMUvsUf4znf7DmzN1rrPWeA/mwtEzSJALKvhMPymm18T2DG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 02:23:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 02:23:32 +0000
Message-ID: <207c617e-79b4-b5fe-c565-a9cd733b1bbf@amd.com>
Date: Tue, 16 May 2023 21:23:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] drm/amd: Add safety check to make sure RLC is only
 turned off while in GFXOFF
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230516175214.3491-1-mario.limonciello@amd.com>
 <20230516175214.3491-4-mario.limonciello@amd.com>
 <CADnq5_OH5vRico9MuegyEAM2SfQchdiXVgCSRLdf6jYmhTYO+A@mail.gmail.com>
 <fb607620-cbf4-e6fe-be24-aad12f530f66@amd.com>
 <CADnq5_N0Z=HzGZA_wXaDrXjYRMOSneOkmbcRnvguOUdLjAinKQ@mail.gmail.com>
Content-Language: en-US
From: "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <CADnq5_N0Z=HzGZA_wXaDrXjYRMOSneOkmbcRnvguOUdLjAinKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:806:27::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c5b26d-a004-46df-09f4-08db567db593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wgivzs7gRW/XixcrPUqGT7Ivyp2Ug37WKl5S79G/WaddSe6Z+VvYjsnOFJZ4hUtPJZ6t2oSf8h/hSDxZZG7L2lEQLNyJDmV+Z+E+pDyyqfwxiTGhb9LNbSBzmFraHiLP8VSCIK1wP+QUrTMa2rncxeIJVPHYiIHJY0CdrBUssqO6CFlJ7E9DH5/vU6q76qhugMRmB+/CYvl0ntDrMXIs4/AbmKd4FKNwDzIUQWntFjC95sZ2TTtg59bJMtlpVaY/GPQ5DRoLMZTvxgsLb+w0DIigLF1W8QUrHr2/BbuiOsQiLYP+XTaNd9dlyhdONSMCcs8GW8NUuTp0b6mb6HMKs/u33TpD47GThH6MZV11cy1lDsB7AF26X+vzg7acFmjDP3W7uiWf5dNtOAq8h7b2bZ/WMfQN7a//UrCWy0kZhH0ApJuGJUvQEtFvfT4GqltyuEib+wrqjO3pE/GMoVxDNLZmhtnylSB1TTyXhF5W57XbzNIAEkFnVFXX9Rn/mmewuZ6UGpDcoMhKifpE/lVoqVJGyp9DnQ/zZFhWnCwwEQCVwYeW0dhVJjPw3wh0Jhrt1h8A0TiuKg8uRQTxhxHaV1jKKC+ZHb/7IkST68q2xigYwPmLPctc2iY8Fl/3ceOeo8dTT6E9N9QCf8q8UABG0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(2906002)(38100700002)(316002)(5660300002)(8676002)(8936002)(36756003)(41300700001)(31696002)(478600001)(6512007)(6506007)(26005)(53546011)(186003)(6486002)(2616005)(31686004)(66476007)(83380400001)(4326008)(66556008)(66946007)(54906003)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkE0M1NKajVRbFdNMTFzSUhhdWRmMll6UnhoMDIxUDFtYUFtWnJRMUVTTEJt?=
 =?utf-8?B?eFo3S0N4QU5ISHN2NkhiMTRjSnpzaEw1dUJGTnB4N3g2NmlHTmdNV0ZnUGxs?=
 =?utf-8?B?clRPWWl0RUgwMlZQYUFKN01JWmwzeXVlWVlwcmtjdlhtY3FmWnZoYTFPclVM?=
 =?utf-8?B?cVVzejZMVUU2dWhXRDZPaktsZ2VhMUdieTVoNWl2WFk2ZDdSYnRaUFpOejZ2?=
 =?utf-8?B?RWFqam01S1VHVHdMZ3ExaFo4bm05N1E5VEhTQ2I0bTMvcWhtdGltTGNvM2lV?=
 =?utf-8?B?M0xlc1VzUE5XNjhGd2dvV1pSYm44NlV3eEFmWUpjcmdhdnpxZDZVQWpFVm5o?=
 =?utf-8?B?bDVrK1dhVkpiMUJiTEx0ZkF0ZkVFUVFmUE5HU2E3ZVFyWHhIdlJGODBheU1I?=
 =?utf-8?B?dXhQb1RvNVJwZ2l5MHNwMDg3aWhaVHRZWFE4WWs4MzdocGo1ZnRhOFNLcG5Y?=
 =?utf-8?B?eXhZK3FRdGoxVEJrR2tQa2EwblFPbjdpVDllRmtoRnRPLzR0NGUzUlFNZkg3?=
 =?utf-8?B?R1g3UUNNTUUyTk11TUxJOWtGemxuNjZJN2tiRWlmRVlJdUpiOW5idFpqWUoy?=
 =?utf-8?B?ZFc5NHA4enRmb0RQL3lkYUtmdVZqV0VGZjd6UFEyS1U3Y295UWs0L0wvMnEr?=
 =?utf-8?B?V2krOS82NnZRTExaRmZHaWhVZ242M0NNUWQvQW1HU3A3aDBGQ3lYYmUvNHhG?=
 =?utf-8?B?ZEpHRjd4RHQ3VTMxWTBCTndFVDE5RFhMcHBuQ1NUOUlCYm5NUWdabFp5YzE3?=
 =?utf-8?B?bTB3SGFvTzIzMkc3K2twWGVMaXkrRjIvVHYwMGIyRzhqOG9EZEpKbTBXR2lT?=
 =?utf-8?B?ajdnOGVVZ2E2eG1nN20wWE9ubmVRcm82M2pZYWVpZ0tuVGhGTDFObTY4YkJp?=
 =?utf-8?B?YUZteXNsUkwrOUphcXB1TlVQWXVNNGluT2lnRWFIcjNFcGJlL3F6S1g1ZVZV?=
 =?utf-8?B?dC94MGdsRlZxeFJXaFRtd1JOQmU5bHZVOWZVUklGWTZLTnRWTDZ0bWZld3JE?=
 =?utf-8?B?eFk5ai96d2hkV2hjWHJ1TlYyUWtPR2ZlSm1VVEk5djJaWVhpRzZ6ZHgwMzVT?=
 =?utf-8?B?N0lndXZQYVZWYU12SWpQMTI5enYvd3NrSlNWWFk5d3IvUlFuSVR3SnQxQTA1?=
 =?utf-8?B?UUxxeTZ3WWdoNGtsRmJrTnNRbE5RcTVzcEc4OHlQOWRUcjZWQ3Z1SmR6WDNG?=
 =?utf-8?B?Qmt3Sm00eXJpTVFOYTl3Q3hHbFhTcXExVEV6VVpWMy9TaGhDSGd1VVJJbEVh?=
 =?utf-8?B?U0RKNzBWM3dTaHhRb0c3ZkpQOW83YTMvS1ljUHMxeTNFVUV4QnNiamhlWm8x?=
 =?utf-8?B?TkNTTGpaTzk3cXZ5WEpmMU9yTlh4MEMvcC9LUU1xclBOaEgxQ2F0Zm5pMEpM?=
 =?utf-8?B?QStnbUpGRVBjMkZvNlN5OUc0elloQ0RNWVlVdW5yT2d4NlNEOXRDSkoyaDYz?=
 =?utf-8?B?R1FpNXdDZ0w2azZ4QkkvODhvL1VIL0FMVEl0ZWJibVdraWVOb0VpR0xobW1h?=
 =?utf-8?B?NDEzczdrdkpjMTZvMncvdll3YWJuNmI3TXdURTZYTHNIWHA3MHVQdkkwOWFW?=
 =?utf-8?B?QktnbFFrWWFqNCtBREV0VDV6U1NvRGxtdFZoUjdGdU5vY1IxSm16NGgwalM4?=
 =?utf-8?B?WDhsOG54R1FTNXNlaDVUQlVOdjVoVnRFQnlCRWk4ZjIyaEJlU0R3VjU4SjRV?=
 =?utf-8?B?bkNQUkV3WVhQL05MbVBFbkJIT0JkSHRDNEFWbWs5aXZlRk1HYVB0NTBnMGx4?=
 =?utf-8?B?WnZvSllKN1hVdWtrU3JKUXJCVVIzSjJFQU1DZTVMenZmT0kwUW5sZEFSZkt2?=
 =?utf-8?B?ZkdvYXQxZDVHMk5vKytGYmpzOXNpMHRRL1JMdTJDUFowbndBS0lIWWFjL0hC?=
 =?utf-8?B?R1lRYlNuTGlTYmx0cHZvMklMdUhUODg4OFE5Z1MrVWxKY0lSLzgvL3FiV3ho?=
 =?utf-8?B?S0NoSURlQi96eFI0bnRaNE5tSUJCd0VDQ0h5UHpYTm9WNzIyZyt6VzBPUmsy?=
 =?utf-8?B?emtwZ2ZMS3ZvZkdUYjZPZVRRSUlqeW9xb1R2bjNCZTNBdFljSXI3REtJRUhK?=
 =?utf-8?B?dmF0bWJYcks5VUpPS0YwenhMbnRwbDRDaGZRRXhiRkZIQUtMa2Q2QUJsWW52?=
 =?utf-8?Q?lPfxzsr6LUyY1RHBEMRF5CM1t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5b26d-a004-46df-09f4-08db567db593
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 02:23:32.3415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibELqekVlrn73FZ/ZMzJi0HJqkylqzXeoVvw8mdH5/DcLvfudx1j4LWKLkKlXIvXiDqrABAndHK4MxYACWd5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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
Cc: Tim Huang <tim.huang@amd.com>, richard.gong@amd.com, Juan.Martinez@amd.com,
 amd-gfx@lists.freedesktop.org, Mario Limonciello <mario.limonciello@amd.com>,
 anson.tsao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/16/2023 4:57 PM, Alex Deucher wrote:
> On Tue, May 16, 2023 at 5:50 PM Limonciello, Mario <mlimonci@amd.com> wrote:
>>
>> On 5/16/2023 4:39 PM, Alex Deucher wrote:
>>> On Tue, May 16, 2023 at 2:15 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>> On GFX11 if RLC is stopped when not in GFXOFF the system will hang.
>>>> Prevent this case from ever happening.
>>>>
>>>> Tested-by: Juan Martinez <Juan.Martinez@amd.com>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index dcbdb2641086..f1f879d9ed8d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -1766,6 +1766,10 @@ static void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
>>>>    {
>>>>           u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
>>>>
>>>> +       if (!adev->gfx.gfx_off_state) {
>>>> +               dev_err(adev->dev, "GFX is not in GFXOFF\n");
>>>> +               return;
>>>> +       }
>>> This should move up before the RREG above?  Also, I think it would be
>>> cleaner to just not mess with the RLC in S0i3.  Can we just return
>>> early in smu_disable_dpms() for the APU case?  All of the DPM features
>>> are controlled by the SMU so that function is mostly a nop of APUs
>>> anyway.
>>>
>>> Alex
>> That was what the original attempt did when we first identified this issue.
>> Unfortunately though just skipping RLC (without patches 1 and 2) means
>> that GFXOFF still either doesn't get toggled at suspend entry or isn't fully
>>
>> off at suspend entry.
>>
>> This leads to the graphics core behaving erratically upon resume.
>>
>> So if you're OK with patches 1 and 2, I'll adjust patch 3 to also skip
>> RLC for
>> APU.
> Sure.
OK, let me double check RLC skip and I'll send out a v2.
> I wonder if we need something similar as patch 2 for other APUs?
I expect patch 1 "alone" to help Renoir and Cezanne hitting a similar 
circumstance.
For Rembrandt and Mendocino, they don't have IMU, so what would you poll?
>
> Thinking out loud here, I wonder if we shouldn't just return early in
> the top level suspend/resume functions for S0i3.

I think this can make sense for GFX10 and GFX11 maybe, but as it's already
bifurcated I think it's probably better to do case by case basis.

