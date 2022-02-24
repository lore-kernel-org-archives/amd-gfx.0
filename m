Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8067C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 22:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E76E10E8FC;
	Thu, 24 Feb 2022 22:49:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14AD10E8FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 22:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8o/bxRMNAOht12ux9vvQ6+OzfyN0qe3L8FpVS7mbr97dCM3TXu3PA0M99P9djVZvDnCji+YnbqoAlnjyy3P3vRdD5Zpzuzk0tjixn5LXsy0Ds6na0H5RN/nerVw+JElf29q6BVFWIpYhcjeCQBADfCxvSaHPQI1Q3fyMWAys+LL9mSTAqD1bC3FSn+KzWYg0lxnyhC6fK+xBS1c52qStxKW9kITl5iiioj/zvQPgXDVQRyoGUd8yKEzvf+I7+U0MInbN3fNl/Nl0EzPpEPZRSV8gyrCUlxfpmXrR4WrIJcDoSuAc619rMe0ASQxzqaxtWjfFZO2H9Om3S7yr1Lq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BbBjH0+My6yusH1jPVCJR7Xy4ebSTVEclApVilM8rg=;
 b=YalFQUUfrAySTKcmGXotjh10rzPlYyUntpr6ZiDG8oM6yGTuGreUAIRcHLGhPFc/kzP/RDldiL4acFdH6PcpXfsZAcuRNki4FWQFLb42a0ORuJZrnvnrW7UWZIxipkZzqnglSCSD1gJDe/4OAm3kESZJkqbE5ebIdwG1Er2gWMxHMZQlWTddMzn/or2YiEqrZrJaHFzYplrHrPCkWv7M0mHRdGQAiDF5ydOiuuyaKugTTURqxm1cIxWTpnOrcVEkAlW9m5QloX4D/W9Jct7e1C46oe7wAVXWi1Nx3UePoQMuijP+zyitZ1UwrYx7Ecz8yK/SmSAnkkS9VXTDmJ4I3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BbBjH0+My6yusH1jPVCJR7Xy4ebSTVEclApVilM8rg=;
 b=pZ0LtpAxrEYM4Oi38e5TTm27/r1/+tXYBiATCPsWK//t5JSgWAmqKbqzNkHVDiY82oABaH3E6HasaawhNFKOn0ahNBzb6ByGjILWX7v7WKGN/mZ8QSmGSPkQeAM2U7rAFEk86ogciWH7CZZbRIYE534swDTOP6zNVwMaAYKul7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB3599.namprd12.prod.outlook.com (2603:10b6:208:d2::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Thu, 24 Feb 2022 22:49:53 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b908:1ec9:3e42:ea00]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b908:1ec9:3e42:ea00%5]) with mapi id 15.20.5017.025; Thu, 24 Feb 2022
 22:49:53 +0000
Message-ID: <43b65bd6-b29b-9517-e011-63144e605c4d@amd.com>
Date: Thu, 24 Feb 2022 17:49:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/amd/display: Don't fill up the logs
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220224214531.6397-1-luben.tuikov@amd.com>
 <CADnq5_MvPWnrOnNb4Ggm-jUgyg7zq69WAthfZ2bZgTXAYzEG2Q@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_MvPWnrOnNb4Ggm-jUgyg7zq69WAthfZ2bZgTXAYzEG2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::6) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c0d644-6475-4c04-b22e-08d9f7e7f8b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3599:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3599953C04D52E44B819C18B993D9@MN2PR12MB3599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcYuQIpCBA8JTfWLrTY+EJYjJZARd4PLeVhDwVn8BCf7pt8INg3vu00TEk2gqLOTV+vgVMN5giTeqEv3cYhJFN9K+tDTMvJUeJ4kiKY8nmU9+rRQ+UsImNnO4bqep7Ijl0ZQJuGFQ+Adf9tDZsbvk1uwSLIhRdk96ER0aZCt5+7YNNDeAMisd3xuDgAOyKJMn2dJNV22Xr3zoJWOoJ9ieErOsTDSWsOzpvB022X2kYrf2OchszG62pINPa+fhCRKcx+4OjQmP/vQMbl6kYwGEzPd6noC3dCfmW0l/LpfhnmOnt3g8EWZxfqjhyiu905B+wF4XSdZAHYfBKhcney00+xtwYSKGsXpDNgc0ZAEiN1Zgb0NiibHitUHAPqOK9DjveYwI8T6xeBZosdCMx01NEs/pAcrFtFfPLm+u875jA+CYVpcofYWQD+SStJGBkNBGxD6WFQKhwZk5PNQdTThbn5SQ/1riTiadFJqVgcYVpcPmctIcIPCl1UINElj27tAuNnMM41ofgttK1D7G349koFD5nfXFYbzJgSnC7v+H09yOOWmnX/6TGg+x58clByKFNC1Rikrt0iGc0czvUdpCN0qW52th2D9ssqImiRSqb1vTq3+ggCfqXdsJ6JHaqUrcgR7z4UTvyo3hPaEwRkd1vL85Cz1PGbNInE9d47m1omShVg3F2UASmJ/d12pS1wa80Lul7YrhbkJSDP6EqxG/yP5foyRBS8SIA79h6QFfiaonRXQsRcaJ9f9gL2svVqg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(6916009)(31686004)(36756003)(44832011)(5660300002)(83380400001)(316002)(53546011)(54906003)(6512007)(6506007)(2616005)(26005)(186003)(86362001)(66476007)(6666004)(508600001)(38100700002)(66556008)(4326008)(31696002)(2906002)(66946007)(6486002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmpKRDhES0VFSlRSajhGUUd3RlhadUJFTStmbDNTVW1rN2t2OS8zaHprUjM5?=
 =?utf-8?B?TUJuRE1KMERqTkQ4STJCLytPNy95MW1IaE51dG1ZanRIdDZ1MEhMbHpnQmdt?=
 =?utf-8?B?V3F1d3dqSlNuZ0dYd0MrbFhhZEV3LzlTY3lwYjlmMDV5NGlBRUJNM25wc0Er?=
 =?utf-8?B?MVRKZ3lQTzVwY1ZKZ01xeFRrVzk0N2h3dmtSdENmZkladU1WT2NjUXlFZS91?=
 =?utf-8?B?RXNkcGJiamZpZnpUc2M0SE5IeDYzT2dQMlA0TGxudTlNRnhsbDRlVmNxeTFi?=
 =?utf-8?B?TGVCYzhidkppdmlka2E0aEYzN1lqWHM5cDdFbjRhdWIzYTdvcG92eUowbXNu?=
 =?utf-8?B?MHlwWElaMFlDbGVMcG04RVp2ZEhWTkRCWXd4RVpJNVVZWWY4dlBZWTMza1VX?=
 =?utf-8?B?ZjlFNHhkQ2VUMjQxZ2Nram45T2pVSFh0LzRUR1ZvSStqTUhSY0tEWHFZUDhY?=
 =?utf-8?B?MEZYNk8wd0FIL05wZ1lBV3I3MVV3WHgzMTBmSm9LSXlFVUY1MDg2UmU4cWhB?=
 =?utf-8?B?bXhBZUJlVXpsaTNuem93VjcvRlBDVTN6SFI3RTIwQTJScnVxaUJ0Z0ZVNUNO?=
 =?utf-8?B?bFY5eUVhQWo3RFo5di80UmRKQmt2TmdwMEZuQ3IwVFF6QmErbTNrSlM2dFBr?=
 =?utf-8?B?WjI4VEJQUHAzc09nSk0wbXFyVjF6Vnd4YkxqWXQ4R0ZqTmg1U0I0eDhVdHpX?=
 =?utf-8?B?K2JOYTR5WlZFdlhGbnNYYVVtaHdDUngwd3psa3VoK0hUUWJXN21rUmVNQTl0?=
 =?utf-8?B?QTY4VXJ3VTk4bzNYUUdjend2SndRSklUS0Y1bW1mczg5YVhkaDlPV3U0K3hQ?=
 =?utf-8?B?MmZBbTB4SlorL1NuTCtGak9DN0JxdTdIOWFmelpIRUUwUUkwbHlCbkpMVFJp?=
 =?utf-8?B?bEFSdnZVNXYxbDhHRWxDWnA3Y0RtdkNkMDdMdkRlRWR6RWx6eUhuSXlVSnNy?=
 =?utf-8?B?N0VteTlPL2gyTDVoVHQyUE8zdmJnRCtnVURQU01rVjQzWDlaYjh2d1NtRGFY?=
 =?utf-8?B?RWY5dVQxZnA4UlRHa0cvT0lFSll4M01USVRxV1hzT1NDTTBzazFiVUtXVDVy?=
 =?utf-8?B?Z3NlRUxwNGpzbXpsWUNSVUVsdjhVMktxb05KRkt5ano1d3ZOVTEzZ1RzNFky?=
 =?utf-8?B?MnBsd1V0bHVtOWoxczVxakQwUW1oM2JSVnRPMnk4NkRMcnFoaUgvTW1Zdmw5?=
 =?utf-8?B?R3lSVytia2FTRSt0K2J6VlVkenVPRnFsK0VFTE92ZyszWFJ4UXY1L2ZmZGhm?=
 =?utf-8?B?cTlEaVJxMmJrUkdkcWttbVk4OEhaY2UrYXVRc0VYajVpcy9mRWh0VUNmYisx?=
 =?utf-8?B?bnlWK3Yrc2pudFY5cVBENFRrOU9uaGEyWHhDbm14M3hUYmxHZlF1UFNONFJY?=
 =?utf-8?B?bWd0SGQ1ZVhKbGs1cm8vRmxucVdCaEdaODd2WXNlbW1LSkJyQi9iRjZzS25C?=
 =?utf-8?B?MjNTdUNEMXRrQUc1eHI5ZDhFZVJzejVrRWF3aGJhbEp5K1RoTEF0TkpGcXdt?=
 =?utf-8?B?Vk9aWmhvVGR3aTBCWXZ0OTlicWxKY2U3WGxCZFlXazA4WFR0SEhVQnQ5aVR3?=
 =?utf-8?B?RXd0NTZ6eTNjellCcml6a2pBdjFqSDJ0ekgvelpSTk80MDYvUm5kaXBvdkd4?=
 =?utf-8?B?dElZQXFuRkR2cE5rSlhVck01aXFHc1NyMEVKaHJrUVpMVE5wclVtTHkvMVJN?=
 =?utf-8?B?dng1bzgzMnRrUHh4N3cxNkpIaUljeEVKeXBYSVpLbHVaekxYM3FJR3FjdGVu?=
 =?utf-8?B?RFhMTVpsNEtpMEV4MEtrbjRDOW5xWllaZGdjNlFCbW1BSFNvOUR0ZzQ4cnp5?=
 =?utf-8?B?c2RLdExqUnZmSDhBclFRWWNqTjRqUzhQaU5BbEQyOVpuNUlIL0p6U3FoVTdW?=
 =?utf-8?B?OUJmNnN2RkltdmI0dmM2VG5tTmEvZjB0eGtOR2dudEg1MEdmQTRQZ0pEdnF5?=
 =?utf-8?B?cVNWODQ2eW80bG5UajU4U3JoMjFhenJiaE9GUWY1T1QwdWNzUHNXemVIYVVl?=
 =?utf-8?B?aEpHVXdjd2VLak1yaXBBa1daYjN2Q2oxdFREcEp0RWRvUUhFeUNVeEUxSkF2?=
 =?utf-8?B?N1FPMGlsWXozRkZYM1NqUkpYL3V2OUtuQ0hVRFUyVGM0UExvdXdMT013N0VX?=
 =?utf-8?Q?5aS8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c0d644-6475-4c04-b22e-08d9f7e7f8b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 22:49:53.3139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ia7R9rDvQKrDH/kpQT9JgImJngcL/t9fOJ6LfF7Ya+Flb8gXwPkazvGwnxrJgYi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3599
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
Cc: Felix Kuehling <felix.kuehling@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Hersen Wu <hersenwu@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I could, but if they enable KMS debug, this prints 100s of times a second.
It literally overflows the log. It needs to be printed "ONCE" in whichever mode.
Either that, or not print it at all--it is "DEBUG" after all.

Regards,
Luben

On 2022-02-24 17:21, Alex Deucher wrote:
> On Thu, Feb 24, 2022 at 4:46 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> Don't fill up the logs with:
>>
>> [253557.859575] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
>> [253557.892966] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
>> [253557.926070] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
>> [253557.959344] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
>>
>> which prints many times a second, when the kernel is run with
>> drm.debug=2.
>>
>> Instead of DRM_DEBUG_DRIVER(), make it DRM_INFO_ONCE().
> 
> Maybe convert to DRM_DEBUG_KMS() for consistency with the rest of the
> display code?
> 
> Alex
> 
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Roman Li <Roman.Li@amd.com>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Hersen Wu <hersenwu@amd.com>
>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
>> Fixes: 5898243ba7acdb ("drm/amd/display: Add dsc pre-validation in atomic check")
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> index 05573f073b21f7..0542034530b1b0 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> @@ -1198,11 +1198,11 @@ void pre_validate_dsc(struct drm_atomic_state *state,
>>         struct dc_state *local_dc_state = NULL;
>>
>>         if (!is_dsc_precompute_needed(state)) {
>> -               DRM_DEBUG_DRIVER("DSC precompute is not needed.\n");
>> +               DRM_INFO_ONCE("DSC precompute is not needed.\n");
>>                 return;
>>         }
>>         if (dm_atomic_get_state(state, dm_state_ptr)) {
>> -               DRM_DEBUG_DRIVER("dm_atomic_get_state() failed\n");
>> +               DRM_INFO_ONCE("dm_atomic_get_state() failed\n");
>>                 return;
>>         }
>>         dm_state = *dm_state_ptr;
>> @@ -1245,7 +1245,7 @@ void pre_validate_dsc(struct drm_atomic_state *state,
>>         }
>>
>>         if (!pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars)) {
>> -               DRM_DEBUG_DRIVER("pre_compute_mst_dsc_configs_for_state() failed\n");
>> +               DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
>>                 goto clean_exit;
>>         }
>>
>> @@ -1258,7 +1258,7 @@ void pre_validate_dsc(struct drm_atomic_state *state,
>>
>>                 if (local_dc_state->streams[i] &&
>>                     is_timing_changed(stream, local_dc_state->streams[i])) {
>> -                       DRM_DEBUG_DRIVER("crtc[%d] needs mode_changed\n", i);
>> +                       DRM_INFO_ONCE("crtc[%d] needs mode_changed\n", i);
>>                 } else {
>>                         int ind = find_crtc_index_in_state_by_stream(state, stream);
>>
>>
>> base-commit: bff980c7632ef3b0099ba230cf7d5c864db3e1a3
>> --
>> 2.35.1.129.gb80121027d
>>

Regards,
-- 
Luben
