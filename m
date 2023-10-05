Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E73E92702
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 14:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A385210E412;
	Thu,  5 Oct 2023 14:37:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C183710E412
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 14:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr+RzsJKWuRaa7W36mERU20VOg/x8fAAKp2pABFH2v1cNgsPqp6OJd3/5VJ4KUe869xUlQh+MdOfuoqPsdexurFt3L4Qo+z5NN2tn4hX+ODvtXVEEm2TAphCkMcwBJ+hK9tck9jhUVyT6jxNhr+5ieKYco0J7gFrwKbKYdZ+7aqAgtjEcEZRxpH43gSkw9es/yHZlP2BrC7uTH2aRVj9/gjUFeWsLVHMeq2Utbs0zyyuI8sgfWwBdOGVHIWFNihQuXcwsD6YUsw8UIMd6kiqY2oEY5dlrfrCjkiwyRC0ZLqeXJdnTyAIyAzHNZ+eE7m4QPCmQfK2YSI5jEaMQ0h5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UognOOWW5z8Z7Pw9tq6oBSDZSEmVhGEEzugNaMjo6yI=;
 b=VMD+Rim7S7uLPeK6OEEzJ6zgoQm11wwAvDB/nqcr37b6gxyXJofCLTPfSNK2iNXoA8ODLeefdcMjqXD50MXOJAoFILXf3onbM5FxI0Fbx90/jRoEB86Wi3Z2TUJkATkXAUoY4QYRQ70R5FUEOM18KNoJIRBo7eHZNu/S+k8SxjMSdwuG6LIR6HKHr/oKNGfoR/x0xR8It12PrAx5qeMrb1z++VF5lILVsiZ/rTl5M4WUscC+FEqCfjmR4bMQHYFHUEv4k9xWIyVTpD8vrZMqNFpoJoGxXJ6hjvmhFtUvxhrNPyJMSyY3L8BmBAtC/VMxwsjB/Nq/kyl544gSYWgcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UognOOWW5z8Z7Pw9tq6oBSDZSEmVhGEEzugNaMjo6yI=;
 b=MaCGAOtG47yYUlfBydOQBUey158Ys0DeR1dJnBDaibCOOzIL1maM86o7hCAYdNWmlNJvHypCLq/dY3z1d4/AeNLR9TN+JX2CZ190qwPEY/HE7vh+/tfqG49WPxlbHVhIxiUpzMLN3hvAgQOAzr0N3LZtr75/xeFu6nnr3obuYBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7103.namprd12.prod.outlook.com (2603:10b6:806:2b0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 5 Oct
 2023 14:37:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 14:37:48 +0000
Message-ID: <d7cd2858-2179-48e0-82fa-3e053bb6bc52@amd.com>
Date: Thu, 5 Oct 2023 09:37:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/amd/display: Destroy DC context while keeping
 DML
Content-Language: en-US
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
References: <20231004171838.168215-1-mario.limonciello@amd.com>
 <20231004171838.168215-3-mario.limonciello@amd.com>
 <CADnq5_PU9pzxR4gfVP=-X9YVGYMmqa74qRU-Qm0kxn7BQfivtw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_PU9pzxR4gfVP=-X9YVGYMmqa74qRU-Qm0kxn7BQfivtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d477c9c-c85a-46c3-9d7d-08dbc5b0a5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypbi8PeH5N6mN0FylrlyOuWPddkaqyDeIA+ls+5AxzVxcx72zYPnYAH8xjVTUkiJqP6uyNNo4DpoZZZfO3Q69RzNPLq6iJYV9OOtttP2lOLIq6TfWt1ZpKLeetnbXvLsY6X9BXjQ34eqiH9GBfKutzgI2WobjkZfMHMS82lYtAqc33Gb1Ie0NPitqlGh5GmXJpk6kd38BxUtWWbXnHHK8BVLNa47NE4FjBYVrMHp+xlAHkGHOeWwbO0WY8OBQAP3JhdgI8lB+32+xF0Q/lW65a/sU7yN3fYkSYK2Mf3NYhpxbhhGLrVxDDqpw7wCObliDYW1e/wAbMFq1+OxrKmxs2OS2XirCrbDEFU1VhlRLvFEvrWvnHMkdDmNVjGjWsCLmpU9LzQSNCyZzy+fC/qCO+7uUR+Ph+GXVjU5yGmMQJI0xzfHK2jCNqxbfmc62OzBmwOd/UqppZU/ByOOhSC2/EK2zDZtOmaOYZ4edB2C5CMAEIBwyMWzC2/1uBi8nKmQGR0PI0wqS3lmBAfFzlk5H4JADwdjqFOyUacegHbTzZNthEgj+qfCTZ3hJx+uhZZ2ISwMt7bY2gJV3xOCI6snBPlVOORY5FwxWsmp3GtO4H8YNqdjDTJntzJayxy+2Hnk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(31686004)(6512007)(26005)(36756003)(966005)(66946007)(66476007)(66556008)(41300700001)(316002)(110136005)(6636002)(38100700002)(2616005)(53546011)(6506007)(83380400001)(6486002)(86362001)(5660300002)(44832011)(4326008)(31696002)(8676002)(8936002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdrZWpGV0NrZCtLR1ppNm94M0NmSWt1T0VGZTNQQXV1ZEFNdVZjRXBicyt2?=
 =?utf-8?B?b3hvZDlVTXorcWdzN04vaGlvYmlTQ3Q0SXFmeGFwQVJsVUFYbGY4R2Zqd0Y3?=
 =?utf-8?B?VmJQNU9UaVBrVmNpK3FlVzhMWEtYSWJ2N3lxc3YxSDVmamtKRE05UFdmUks5?=
 =?utf-8?B?MERYaWtHbTJqTlN2MVM3ZFVZTDJjNkoyWThYMFZEM0prSFBMTy9WVkVGY2p4?=
 =?utf-8?B?SFg5UkR4R0tsdkV6elg4dHBOUkJjaUdrUEJoY1ZERmU3cDhsdWl0Q0d3bCtC?=
 =?utf-8?B?WEUyNEpwa28zQ3k0WHZDNllpOFhCMGxZTnEyWU4xUW5Jd1Q5K0VPSHRiVGJ5?=
 =?utf-8?B?UitvS0VaOUtuV3pGRzZjeHVic1RMMUNHTGxYSFNINUZrS0dPQlYxY2REOXdF?=
 =?utf-8?B?dk4weDBFTmlEZWVhbUVyeVBUa3NBN2RTVm9JWGpia3d1Z0xZU0hwR0kxZ1hy?=
 =?utf-8?B?c3VRdmYyZVVhMmQ2M3YrT2I5WWdWNDVUbWpVTW9nem5GRS9waHY4QnVMZTJo?=
 =?utf-8?B?R1NLeWN1Q1NZMHBIODBlMmt4R0gvYlpBaE5CRWpObFpqSkFLeThpWjVWcFVa?=
 =?utf-8?B?MVpOQzg5cjVZNlBuSzNCL00vN0gyWnBGSjlkYmlJVllhRy9WQzlqL09BenJ5?=
 =?utf-8?B?eEN1UUVEaHZYVXhoYWxXb0p5VWkyblZISk1NMi8xa05jNWhMcmlKMXBHUXZt?=
 =?utf-8?B?c2cybTU2azM2RXkrMWR0a3BBSXZ3cStITFJuSUlTRVpMUWRTRXd1UTIrUU5m?=
 =?utf-8?B?UGhJN3NHSGRXamIzQXN6ZWR4c0htVU1oTmllWHgvekUyUDFNeGtVcmtaMDhj?=
 =?utf-8?B?R1hrK1BJUUtpTUJWeXpGaDBNS2JLZGo1WW9RQTFlbU5CQ3Z5UHM2UENRSXZC?=
 =?utf-8?B?UFpGUEVKQXFncm8yeEdLZ0kxSFByWmt0dnp0eWU3U1ZLT0J5ckU3SldMUlRt?=
 =?utf-8?B?WG9jbXE0MHVBTEpoNW9LcVk5VytIUkoxbDBaTUZJS2FqYUt5enZuK3k3QkNm?=
 =?utf-8?B?VHhGYkdxRVVWYVdxakVhdGFhTkk0djBXSmN0bFU4dGxsb2ZWTHpJeTBNMzE2?=
 =?utf-8?B?YUVhRUk4NU5GOG1CSUhNY3NKeEdGVENuUFNncDJYWEVwRWl6eW5aOE1NYzQ1?=
 =?utf-8?B?UDRnMk52THhETGVjUlp0bUFiSy9tZWhESnlsWnF6NktZMmk2cG1IRkY5MkFV?=
 =?utf-8?B?VGwxYXR0NWpxa3ZIS3FDSGlyZzFJVlgvVnB2UXZxQ3JlUGNWckFDdHVETy9y?=
 =?utf-8?B?YnY4dXUrUlNSNjJwOS9mNUNBdHJEK0VsY015WUJkK1NSWXcyZEZTQVMwWmxE?=
 =?utf-8?B?WFdVbEk1NDIyNVEyUVRCQTh3Mi9UYVZ1RDdwRzdXTDNrcmtXSkNYbXQzTkND?=
 =?utf-8?B?TjVxUTFxMU9Ra2xqNldTWitlUVpYT01qaHRjdnBjMVl1eUdxcjZDQWg5Y3Nq?=
 =?utf-8?B?cGNqOFg5TDFxSVVlOUpiN245NXZWQk5DT0I0UWhjVVVTelJZY2NFSE1jcXQ0?=
 =?utf-8?B?VmIwWndUSkhKQndRdSswQUU4VlF0dDE3ellLeTlyem1kVHhxalBac0J5ZklQ?=
 =?utf-8?B?cDd0TWMybDN4V0k1SktGWjNjWS9nM09NZzlaeDNFM2JzTk9iR2NMT1BNa20y?=
 =?utf-8?B?OHVyajhVQ1FQNUZwNUd0Ryt1N2kydVBjRThTQUFpZy82U0trdGRTcTk1dElw?=
 =?utf-8?B?MGgwVktPdDhCSUFnclJ4Qml1YVdacThyL3RVajBsVkRiKzBjMzg0ZkgxVG5r?=
 =?utf-8?B?ZkRjbTEyT2pmaHcwVDBYKzc3dFplWC9zdWdaWXhCbFlHcTR1S0ZUb1VpWmxE?=
 =?utf-8?B?M1BTK1h1NjMvakYwem9QQmdVWGVxeFhMRVd3dEt5eTZMdkNxNzJMdkg4V200?=
 =?utf-8?B?OXFVSnpYWGZvUUQrTGhLVXhCM3JoMXdvZ3BzZm1mNEQ1am1DREsvckJNQkVm?=
 =?utf-8?B?SFNabmhZUUhjb081RjlyZXdUaDdURFc3ajZ0WUZCMk5ZdE1WOGZ5Vm1YMU9x?=
 =?utf-8?B?dXQ5Q2F2Wkh0dW42VjA4djExNk9OenBHTlVJNXkxNUlJemxoYi84blptekp0?=
 =?utf-8?B?aENrMXd3ek94ZGYxaXliY2hxenRqenBaTGJqZ3BTZmNFUXdRcGZOMTNaTCt6?=
 =?utf-8?Q?JM32ynnXi8zv7/8rBoZBKPF7t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d477c9c-c85a-46c3-9d7d-08dbc5b0a5a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:37:48.8597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY7GHXqNQfKJtg7PZSuRY+1aJxlBPdTlwgXIcdP6KqoClMP9MxAmoLsu9z0fx5UgTpg1gUakV7ofImfJG/WUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7103
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/5/2023 09:27, Alex Deucher wrote:
> On Wed, Oct 4, 2023 at 1:37 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> If there is memory pressure at suspend time then dynamically
>> allocating a large structure as part of DC suspend code will
>> fail.
>>
>> Instead re-use the same structure and clear all members except
>> those that should be maintained.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 25 -------------------
>>   .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++++++++
>>   2 files changed, 12 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 39e291a467e2..cb8c7c5a8807 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -4728,9 +4728,6 @@ bool dc_set_power_state(
>>          struct dc *dc,
>>          enum dc_acpi_cm_power_state power_state)
>>   {
>> -       struct kref refcount;
>> -       struct display_mode_lib *dml;
>> -
>>          if (!dc->current_state)
>>                  return true;
>>
>> @@ -4750,30 +4747,8 @@ bool dc_set_power_state(
>>                  break;
>>          default:
>>                  ASSERT(dc->current_state->stream_count == 0);
>> -               /* Zero out the current context so that on resume we start with
>> -                * clean state, and dc hw programming optimizations will not
>> -                * cause any trouble.
>> -                */
>> -               dml = kzalloc(sizeof(struct display_mode_lib),
>> -                               GFP_KERNEL);
>> -
>> -               ASSERT(dml);
>> -               if (!dml)
>> -                       return false;
>> -
>> -               /* Preserve refcount */
>> -               refcount = dc->current_state->refcount;
>> -               /* Preserve display mode lib */
>> -               memcpy(dml, &dc->current_state->bw_ctx.dml, sizeof(struct display_mode_lib));
>>
>>                  dc_resource_state_destruct(dc->current_state);
>> -               memset(dc->current_state, 0,
>> -                               sizeof(*dc->current_state));
>> -
>> -               dc->current_state->refcount = refcount;
>> -               dc->current_state->bw_ctx.dml = *dml;
> 
> The dml dance seems a bit weird.  I guess it's here because
> dc_resource_state_destruct() might change it?  Can we safely drop
> this?  If we do need it, we could pre-allocate a dml structure and use
> that.

The dml structure is huge, so I think it's sub-optimal to have two 
copies of it.  That's why I aimed to just destroy everything else except 
it instead.

The only reason it's "safe" to drop the whole above stuff is because of 
"threading the needle" of what dc_resource_state_destruct() does.

In the earlier version I had a mistake to miss clearing the scratch 
variable and it caused some IGT faliures.

This probably needs to be double checked with the DML2 series landing as 
well to make sure it didn't get caught in the middle.

> 
> Alex
> 
>> -
>> -               kfree(dml);
>>
>>                  break;
>>          }
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> index aa7b5db83644..e487c966c118 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> @@ -4350,6 +4350,18 @@ void dc_resource_state_destruct(struct dc_state *context)
>>                  context->streams[i] = NULL;
>>          }
>>          context->stream_count = 0;
>> +       context->stream_mask = 0;
>> +       memset(&context->res_ctx, 0, sizeof(context->res_ctx));
>> +       memset(&context->pp_display_cfg, 0, sizeof(context->pp_display_cfg));
>> +       memset(&context->dcn_bw_vars, 0, sizeof(context->dcn_bw_vars));
>> +       context->clk_mgr = NULL;
>> +       memset(&context->bw_ctx.bw, 0, sizeof(context->bw_ctx.bw));
>> +       memset(context->block_sequence, 0, sizeof(context->block_sequence));
>> +       context->block_sequence_steps = 0;
>> +       memset(context->dc_dmub_cmd, 0, sizeof(context->dc_dmub_cmd));
>> +       context->dmub_cmd_count = 0;
>> +       memset(&context->perf_params, 0, sizeof(context->perf_params));
>> +       memset(&context->scratch, 0, sizeof(context->scratch));
>>   }
>>
>>   void dc_resource_state_copy_construct(
>> --
>> 2.34.1
>>

