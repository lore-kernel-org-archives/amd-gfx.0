Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B1C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 18:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D8211A6A3;
	Mon,  6 Jun 2022 18:02:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FED11A6A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 18:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvkSLbD7wnAyIcuN+vVEne8YT0+sklndPFQAoMYsANAUN0FpXUylZJmh0S/4Pmld4WHHirOBbEyFrmfm6qWOXV5UZZoUl5EUmVHOcyrIbW13DWeZcpuFPZUJa/vw1s+6ENMOIXRn3nuFTexnFj2wJxyJYsBHWPs6vb4CsXH4Uk4teUMNjXDIBXgUYXPRqXXHt4cNODAGw4tDpt+Av9JfCafL0gkD4LiPMg/gmJ0WGGf3wbafR+VLsl60ThkE2k4c389nkpZ6Vbe782f6XNwsRJd7JjgkaioUM4IXbIZst5btQ/PnYbr3OHXyy83+aESbsiWuXFhvtuYMLI5qa/aWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIv+o99QpEk4sF8I+FpONCMIo1gVXdMCadtmhNCFE/I=;
 b=C11oqnjpL3I7/+8IkNHcyq7hN1YdLrxt+RdP2+ziP7q9341ntCgedqrBAXMaFre34ygSgNeM+oLhthouEMKz7pjzGHJc87rKyBlZPHyoR6r8rVUZrtjZhpCKDehdNpL1G5bEoiaYXO8YglvjgbRbvSIb2BLe9QESzRjnec0EzOBMogKWn387dfY+4bd1IpFr32puaapymbUuuv4uH/08seZdCGbwKJT9qmp8QQpdXH6UMeh5q+jv1WS7XqkQuQTyGI5XkISH7zetH4Kaj2FirEDolafDyOxELYqdknzZAHvvRC2J4yqC81nKSCde5LKA+Z14Clu5glR1QM8hBGVOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIv+o99QpEk4sF8I+FpONCMIo1gVXdMCadtmhNCFE/I=;
 b=qdLCoFebgwlq+J2190AbcS//Pj+nCwjGXOO9WnGFQ8j0cFfsCBQ1qjl29SWiBm7QxZXSOJqGwgkCVlyiOj7cvDx6Br10qsBLdZH/pVTnPhdEBlk8bVuGlm7Pk3uloCfr/rOrfWbYljJOPReoEHAUrvzfwcy+U0N5U8afKy+Uy10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 18:02:10 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 18:02:10 +0000
Message-ID: <c0e6f3d7-e1a7-4446-350c-14a499e78479@amd.com>
Date: Mon, 6 Jun 2022 14:01:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 6/6] Revert "drm/amd/display: Drop unnecessary guard from
 DC resource"
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-7-Rodrigo.Siqueira@amd.com>
 <24e1099e-bf3c-dca2-a8a9-8cd0196248a2@amd.com>
 <CADnq5_MOCk0R3hC6+Yw_e8MQtJR4MhR11wMuTUmeNacp_jOJ_g@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_MOCk0R3hC6+Yw_e8MQtJR4MhR11wMuTUmeNacp_jOJ_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6dcb4d2-dee4-42e9-7997-08da47e6ad59
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6266:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6266916A1E97C27EFC660A598CA29@SJ1PR12MB6266.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HS1W2ZWyYa/QNV7feAf/s9rht5rBKurk+r6+WGS9j0KT/7ToctnYEAtRpH+oIN2EITc/14jzCUGUqlN+tPmyLFq4bJb7AOX8qZQLuOK9e9kXhrAgPqillkNYnChCg3Bb/iM2nFLG96jdbJRfMGwAXr0Cl/kTqfX6ZbLya333riCa8i/hQAbVCy5rdcEpqYO4DEJa3k0xIVD+Fw/j/WAD8UppGNEFzSq7HhCJpKctzYHseUXcMGU90MJ6T1tclYHLg4Eg6nWc/pcTOBQ2mEY3mo+qLFu9eI04GJrLGapTeH4gStsuQ0Ebi0leuYxVuKGlARcEuqTzfYiLBEcnaKeaUMX5K+iBSax/VMAKTuywEOmWLatXrMlwIghfQZcfYDhMpKHqZQXeJeqgRXcL3wL8czhe5v0UoFmjSuDfVMr1OPuv6MtAcIS7EI+eyV23E/pFUMNh98Q5rcKv3jXvRNC6cukqBtYjpW+ZuCDDDpd5C+tlGkz/5XVneVnmR3+fBudluttbU3HevupqKlDkfjrMZpOhCbD7zjl5tG0j/LT9q4zjb6O7FD5f5jvJWFNAxmgHk2iYXJl7HoEOsxa/cdiOEH6tm6EtrDycYqEEmqgOYMMd53MThBCylZ7+KU6sNvClkwA3oreSfmV5rja3L/Fb84F4tZpGILybWWh1o1rKrXz0kqUaq+Bt9eNS7V1fFdZnQbBkol+Ezy8ahECrAez+SKYXRTUhO1NUm33JaqYgy/eOu3hVSJK0tkHKeld2mQMv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(2616005)(8676002)(36756003)(44832011)(2906002)(66556008)(186003)(8936002)(6916009)(316002)(26005)(83380400001)(6512007)(54906003)(31686004)(5660300002)(38100700002)(53546011)(31696002)(6506007)(66476007)(6486002)(4326008)(86362001)(6666004)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVCeGd5UXRjT0NablpUc3NFUk81MlVPSmpFRUdIYzRnRGxuVjc0WjZxeXB2?=
 =?utf-8?B?UjRtbkpZMUI3aVI1OFR6alZJZ3E2S1hxUFo0TDV4QUhvbXp3VUViaSt5NGhv?=
 =?utf-8?B?Z2c4dWlDelY0Z1VEVWQya3FrUWE1OU1wWW5LcW1iUWZDYjlncDUvWk55L0xH?=
 =?utf-8?B?dnFRVTVMWHBuTGZhZ1pydUo3RVBZMldFWGpTT3BuamxsQTYxK2E4WitKdmlV?=
 =?utf-8?B?NGNDeFRUcnBpTS8ycE44SFFnMWUvK2pjcVQ3MjJFMFowYm0weUlITm9KYUFN?=
 =?utf-8?B?dFVYNjhHMUxkaVMrZk9mYVJ5NnRPM1gzYkFaTyswOGJ6MFdBU3VXTCtkbmgz?=
 =?utf-8?B?MnFIZXNMZERGUE1uZ1c3ZkxjT3NZcm1QMGFqWnJqQjNyMHp1eHVRZkdHMkpu?=
 =?utf-8?B?dlJMVjNacjRjUjRpeFZaOTYwdWpETmpGWWUvOHVEUU9jU1BPNlNibFZucEp4?=
 =?utf-8?B?dU1TZHNNV1QrU2ZUYjV5MmVldHBlSG5IT3dmVzc0RllGd0dnc2hncDhiUEtD?=
 =?utf-8?B?M2tGNHRybkV3QlRoSVYxVzFlaytsdkZMdVdNSjFkcEdGWERlNSs4NkkweUEy?=
 =?utf-8?B?ZVVlSkFXaEJOSDdvSmJzTnlqeG8vQlJZVWEyOFA3aEh2aXhDNzc0VzJITU53?=
 =?utf-8?B?NS9aUTRjazdOTUhqVHRaWXdGcm9xYWEvSS95dStrLzZRM01UWjBRa1ZXMk80?=
 =?utf-8?B?eEhZemdVbkxIQ3ZWeEdqMTJtRWlHeGJENEoybm1CcVhobXBaaDFHY3lYY3hU?=
 =?utf-8?B?SEVHOFdrbTdlbUxXaFdjYlB3bk9YeTNsd1R6TWhTS3ZXMnk3SHM1NWQvNDJ3?=
 =?utf-8?B?RHgreTlidEJjK1J2dTVaMWlOSWFKT0NxOC9sZWh1bVhiK25hbkViWFpTb1c1?=
 =?utf-8?B?UjlFaVJGYk1TSDhnalJtZ0NBWkoxNXRvVEdYTzRJaVYvK3QyK0U1NWxwbnlw?=
 =?utf-8?B?Mm1qSXRIdXd2Q3Rjeklmc1d4WEsxaWxKVjcyRS9ldjk3SFdUdUFoQnBsQUZt?=
 =?utf-8?B?aWU5WU01MlNmNGxNMDliVGp4N2U2Q1ZFaWM0dU5FM1VkcVBoN2RUQWt1dXVL?=
 =?utf-8?B?bkFMZ2pzcmphWVEyMkMwSmlMZ3A5cGhTanVPMVl0czI3Nm8wdFRIQzkzSnUv?=
 =?utf-8?B?bkZ5a2VmRWpTNEpPWUNXNTQwMGhqQjU0RmVudkt4V1dwdTkyRElsQW5ESTYr?=
 =?utf-8?B?LzhiTGd5a3Nsa2MxMFlWaklkYUJaTWpHWnZzeUtFQjZxT2ZONThoUDBTKzZM?=
 =?utf-8?B?SVV0ZzRnTnlsSDVrcEM3Mm94VUl1OUdLR0JXT1NqYU9GZTd4S0JncStSUXFI?=
 =?utf-8?B?MHhmalRHakl1RTh1THVsRC9uRTZjUGRXQUF3czVybWw5SEY3aUdFZnZMUzhs?=
 =?utf-8?B?WlVxNHp6WUUxeHRDWVhBWk9kZDRQWlNJY0huQmt5ZkhNMGdIaVdCRUsrMElh?=
 =?utf-8?B?WW42cWFCM1VrQXdoTmZEQk9kZnJpNW51cHFtQlZOMzY5V2drSTRINHBxc1V0?=
 =?utf-8?B?UE9WcHpFS0RVYVBnZlgzbnZMWkV6UnFKUFB6aFpJdndQblUvc1kxUXloU0hl?=
 =?utf-8?B?SW9ScWxjOWhPMFJld2hVS2hnNkpIMVhnemdhN3R0RUttNDNsL0MxTXIwU0J2?=
 =?utf-8?B?OVlXMEgzbHZHLzlMeWhYOStjNWRrZ3JBREQrYVA5VmFYdXgxZFJ4MXFUeTRk?=
 =?utf-8?B?eCs0QjNMUEZrMG12alVNTnkxdlpiSDVFWFdRTjA5cjlhNEcrNUsvaStqUDVh?=
 =?utf-8?B?bXlaZzhFeXBWVG91cTNtS2UxaURGSFJ2aGo5Z2lGSzZqL0NPTHJxeDBWWUxR?=
 =?utf-8?B?cmhRQ1pya1VRUTdsVWIzZVp5eXJMV0EvbEJyb3JLVDhVUnhCcGlHTmhiSVFK?=
 =?utf-8?B?NGxHY1lwSGh6QnZmQkRkVDdUN0xWTk9YU3NScEk5K0lMRTUxZksrZjBxUFY2?=
 =?utf-8?B?MWVpMmEzbDdzRlBpaE0xVVhQUHNmY1RiY1VFRWMra1dvUUlJZXE5SFluOG5Q?=
 =?utf-8?B?WXRNZUNoUkVYN3Y5SklpZWxCRUVjcEsxRmVVL2RETHJuOUFUTWxXa01iMjVC?=
 =?utf-8?B?QlJVYUZFTWFxc2JUdWlnZllYYzByYUdraEFwejNsandjOW14RDBRamlyTy9P?=
 =?utf-8?B?Y0ZYQmYwK0VPaVJKeDQ4SUpMcWpxRnVBdHZUVXJ0TW0rZEdCbitWWmg5T2Zq?=
 =?utf-8?B?VHloUThvNnBPa0tyUiswQ01xNzM3NUxqQyt2VzlsSXpveXhKakZqWDNOdVpH?=
 =?utf-8?B?RFkxWUFkbEZQOGF6bzlPV1hadHNoZUZEL3lPbzB5RXpsSWZJUGdtSmNIUTRQ?=
 =?utf-8?B?M0V0cURpckFLUnNrb05NNlBmNGpjYVdkcnBON0VUc05wUEh3NUdMZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dcb4d2-dee4-42e9-7997-08da47e6ad59
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 18:02:10.5074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRGgz8umeK+28VupGN2lfsQDFqR0aWqRjsY0CWX/ZrNOaw3vCek1DAiQR10+uY8Nz1r0K+1NZiAxUhehpIH+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-06 12:17, Alex Deucher wrote:
> On Mon, Jun 6, 2022 at 10:16 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> On 2022-06-03 14:50, Rodrigo Siqueira wrote:
>>> This reverts commit 78baa3c4dfff4375b109bc5e19663a2f7fad1190.
>>>
>>> This commit introduced the below compilation error when using
>>> allmodconfig:
>>>
>>> error: implicit declaration of function ‘remove_hpo_dp_link_enc_from_ctx’; did you mean ‘add_hpo_dp_link_enc_to_ctx’? [-Werror=implicit-function-declaration]
>>>  2010 |   remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
>>>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>       |   add_hpo_dp_link_enc_to_ctx
>>>
>>> Fixes: 78baa3c4dfff43 ("drm/amd/display: Drop unnecessary guard from DC resource")
>>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> index 7357efb8b439..9bbdfcd6b3a4 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> @@ -2002,6 +2002,7 @@ enum dc_status dc_remove_stream_from_ctx(
>>>       if (dc->res_pool->funcs->link_enc_unassign)
>>>               dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
>>>
>>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>>>       if (is_dp_128b_132b_signal(del_pipe)) {
>>>               update_hpo_dp_stream_engine_usage(
>>>                       &new_ctx->res_ctx, dc->res_pool,
>>> @@ -2009,6 +2010,7 @@ enum dc_status dc_remove_stream_from_ctx(
>>>                       false);
>>>               remove_hpo_dp_link_enc_from_ctx(&new_ctx->res_ctx, del_pipe, del_pipe->stream);
>>
>> Wouldn't a better solution be to drop the DCN guards around
>> remove_hpo_dp_link_enc_from_ctx and release_hpo_dp_link_enc?
>> Not sure why those were guarded in the first place.
> 
> They were added by me in:
> 
> commit d8e4fb9112e88d8d87ffbc38fa511e7118042d4f
> Author: Alex Deucher <alexander.deucher@amd.com>
> Date:   Wed Jun 1 22:22:07 2022 -0400
> 
>     drm/amdgpu/display: Protect some functions with CONFIG_DRM_AMD_DC_DCN
> 
>     Protect remove_hpo_dp_link_enc_from_ctx() and release_hpo_dp_link_enc()
>     with CONFIG_DRM_AMD_DC_DCN as the functions are only called from code
>     that is protected by CONFIG_DRM_AMD_DC_DCN.  Fixes build fail with
>     -Werror=unused-function.
> 
>     Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/321")
>     Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>     Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 

I remember your patch was needed but don't see it now. I wonder
if someone removed the reason the guards were needed.

Harry

> Maybe they are no longer required?
> 
> Alex
> 
> 
>>
>> Harry
>>
>>>       }
>>> +#endif
>>>
>>>       if (del_pipe->stream_res.audio)
>>>               update_audio_usage(
>>

