Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83771C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 16:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C825910E050;
	Mon,  8 Jan 2024 16:40:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B2C10E050
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 16:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsvbafJbqHDPvNL9HLO7heaurqRV47nhXaqbVR7kQa3c43lY2zSwQmrs3RroHYCCBWjaGZ9h1tEKHUZbZ82uOiYPEEY2ehyXHeubOAG2uV+g2hM/NXZdCZL0HG06qUKkrPVU+KcBoUoppL7ZXeONVFx/LUeLyOwFfLrV+rOzgMV4O40VrJXniLofpwRpE1OCygorOHxp/Cmx68F4xijeQXovqaC1O4BMs01KIYVc8XwCGd6FwAWHF6wRRHbM/j5YVs9kWh5HW5fKhFx2pkSuIg++E3Xt58yznHSMyCNexCpb0mgMoWYvONggUQVTJTOWZbqiNAZ/Nx5rjx4CuoVn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDW2zysie6QqaYtWc1psWfzMaKC+l9pJEPtouBQN+Gg=;
 b=XkVI5+FzPXQQDKQegQwMX89SJo0wRmmHJItv1v8jG1jz6cOPVSkVbuuQm/oKPqghCdbZR1+IKEoOgsGw6N4kV0RYxzQ/FFG88lSyH0Bbg4XZy3zJIPYsU6eJCNecPHmdwN4PAxdMPahHngQJMy3iU6cakgQRhAsi55yEpTGDXLuvQg5QD2+h55UXOPw66Nkjz6TdEeiQTo0QT7eIYZxHYQ9B/WAWeKFjIpjNM4ONSq7wOmOpndnwjrOAllPncBmoIK22DKrfjpX7EGG4rCZH83rZ96wHY5Xn3vOoEzAkxfDrcWb7rn1rb/nzBQuB+RhG0ixihWRxTp2SHK94oZwUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDW2zysie6QqaYtWc1psWfzMaKC+l9pJEPtouBQN+Gg=;
 b=d/AYgViT567VDpbEjqy1mPspOIwpdxYFKMv5LcRUzzSlx1mFHv5llccDdhMcL8QsXsPOPvXFRcmP4rkUc7a8wQ41Sl9aMK/jMul739i+PPVv4dNc3uyaWzCxHh18YiKVo6vg/2j0fEkXrWKBW7NwZBzztODTpGupfHgvA6CrG8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:40:51 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3508:1efc:dcab:74bb]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3508:1efc:dcab:74bb%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:40:51 +0000
Message-ID: <6697b520-9c8b-4ad8-bf0c-52056445f2c3@amd.com>
Date: Mon, 8 Jan 2024 22:10:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix variable deferencing before NULL
 check in edp_setup_replay()
To: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20240108161920.3973404-1-srinivasan.shanmugam@amd.com>
 <70a1d20c-702e-4c2d-8a66-372f26d85f47@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <70a1d20c-702e-4c2d-8a66-372f26d85f47@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::7) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f43e35f-9cf4-40ec-b52e-08dc10689331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGGfEIf7vxNqzCPkq0phw42oJZsRnP1njA8W2N2PLxQ4g+PujeaSGig6vAtBI+dThkYE3AiKm4ZLasYR5Ys7BvLVJEi4oGqIxYibeeuWgP+/SCL5zOeHXyt2kM5YSSqhVJeA20KFplpNA52wMqLjv6Y5eZa4ToTgk8tdr/UsLc5zJFE+y/HKJiyWEayvazhvg3Jo6l8thzwoZuAPiyuJ2qnrrCsE/jcykyrNCrAs2tu/1OFVY1Vy/7wpUOL8Pd3co1mBhAFCnb4gwv2Xa74S4OrbnJIC9mXfvkBZMBN0ukuyl5yhH5T7lWvMP12CFdlmvrFRUnVR/DndYuBTesTx9X2t07+/IFFLA/nZF13RZEQNapUNyokZagkhNlTAt0N3UU2tIkr5AIrd9ptY2MnJEaM6JqrvtQzbGMuLQicTraljQflaTEaFKmUOI3tL+rp0pE/kb4Aqp+fD2ponujT3MLhH3spwluOrVKCZMVbfLJscdL28+3RPohTrWFkI/G29MUIs8u1Rjk1U1IdWZs1BsAtmBSrfM8zl2eT1iIUFr1s8Zx6DCWFJmLuYcnIjZbH86Akg8L6nLitTAv5ivBcA2sfLwspMcIwG7S6nItepgOZM9frrjsJqSPYJ0bg6RQm2i6QquyYIPkBZMAjsOikGrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(26005)(478600001)(2616005)(83380400001)(31696002)(6636002)(2906002)(5660300002)(41300700001)(38100700002)(31686004)(4326008)(86362001)(6666004)(6512007)(6506007)(6486002)(110136005)(54906003)(53546011)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVFlemdQeDF4V0hDZGNrS3FSUkpYVkw2WHcvSHZRQk1IZVBaSlZOYjhjSFRS?=
 =?utf-8?B?M2Z3Tnp1c2VESnNyb3VDWk5TZHAyNXo2bHNKTU5Yd2l0WTdxWjBoaThYc2lO?=
 =?utf-8?B?WGNIRFMwMEE1Znlxd3BZU0ROV0IzNEZwR0FlSjhrQ1kwQUtaYnRlQUoxQVZw?=
 =?utf-8?B?bDBYUDRkVlErMG15S2hPOTdJdk92ZnJKUTNHRmt0aE40dGt4S3Q2YXYvWGd1?=
 =?utf-8?B?Q0ZTRHRWa0ZmLzBsMnR5Q0lVQUZsNTRoV2RQTWRXMmtWMXRMRktXLzJYNkdj?=
 =?utf-8?B?Y2toR0VhcGY4TjNSU3RubkswS2VKYnBXL3Zwc0Zkek00akVSOG1SUzJZUUpG?=
 =?utf-8?B?bEk3UTdSekQzbDNBcTJwaGVOaVNBQklMVi9nZnNIb0RTZWUxVEZMUXB5bldu?=
 =?utf-8?B?ZFJJUHd3a21TMHNvNmdieEg0YzlUNXl3Y3lCNVJybUs2MDhLYk1MK2I4Ukc5?=
 =?utf-8?B?VjRNWTB6K0J3YmVSd3hpODl3bjRLajRtWjFCV1lkeElaWjB3QlVCWjJ5K2Fk?=
 =?utf-8?B?NE9Zem9Vemk5bjk1LzJEaHJpRkI5Zk4vU1BSWVFSTWtrdVk4WWVjZXVGS0VU?=
 =?utf-8?B?V2dVNS9KZU42ZjJyb3VyZGQrYUhWUG1Za1pTMFJaOWFoOFoybE1lYmVFOVFm?=
 =?utf-8?B?VytBWExSb1lVaHhzcy9jNmt4ZVdLVWk1SDZxLzNIbGJVZ3FIckF2VVdWYmFR?=
 =?utf-8?B?WUVHUmd0OUgwRmVRZ2l1TmtTWEZLWTBZUW91cDRUVkdLSEFjK0tDVHhQUE5V?=
 =?utf-8?B?NGxoTHZSQVJnRTh4YkFtdEs3YVZrejNITGpkbGlYS2E4b1JZU1d6dlAzVG9Q?=
 =?utf-8?B?QVZ1MEE2Z2dDTUoxODNSdExPakFabjZSdGJ5aWorMS9IN3BUV2xxazduVlpY?=
 =?utf-8?B?V2Y3Y2lUUldtSHZHOUNNbDU3elIrYkdpa0VsTjFPaUZTVlo4N0o5SDgrQVdx?=
 =?utf-8?B?NC9jUys4RHpDR05GM2xHR1RVZEd1L2IvNDREMlNaVFdYYlNpUlcwTDVtSDl6?=
 =?utf-8?B?dkVkbzh6R0VOcWZtRngzZWhvdjFVdG04THladDB0SUQ5aEpwZ0VxQ3krN0pw?=
 =?utf-8?B?WXU5S1YwbVQ5SnhDS2FPV3dZaWx5ZEtKTEZZc0NTWFRXbnE5UDNVSzlmTHp0?=
 =?utf-8?B?WjlmbkVqaWtxUnhBc0w5VUNRd1VvSWFwRjFhTXUrZmlQRDd1bjN2K3owUm1p?=
 =?utf-8?B?TDJuNk1OMVpneWNxNTVFalhvSlQ1cjBkbmhMTkVGK1ordE53Mld4OExxamds?=
 =?utf-8?B?Zzh6ZGdTQVZuK0Z0TWZUMmlQTzl6TFVFNnJXL3lOcXRLREk4MyswK0h1TGFr?=
 =?utf-8?B?UENqcENWazk3bUtrYldOYTFHb3RLNmhTZXNuYjVmK25FdDdvNVNPT3ZoeFZr?=
 =?utf-8?B?ZFBTVytSdFhPUmdHdmxCcGg2encyaTJPTUZHSC9OaGExMlo5M09OeWs0bHhw?=
 =?utf-8?B?c09qZGg5ZkJ6USt0cGx1WVRvU1VQNXFHU1VyR2E5ZlRqNFJvb2tlN00weDYy?=
 =?utf-8?B?SmhmTUs5bGxHNUJjRmFMQ0VWZXkwdG1ZOEwrRWJ1SFhNVUtuSGFGRGpTVUJX?=
 =?utf-8?B?QlVjcnVORENsYkZhTUViK0o1dElhR2ZQR2M4eU1MME54V09XeTcxQjV1RXFo?=
 =?utf-8?B?Rng3QTdPT1dVRDIwSmFRUE5iOWQ4VEcwUVo2QXo0SzdQdVhDNTFUMEFpVmhn?=
 =?utf-8?B?T2ppcEFqclY0UHppbERIVDlNSnJoczdMTDBzZnF5SUl1Rzg0VVZSbS84V2NH?=
 =?utf-8?B?SVd4MWZ0b3pVSGdUbkY3cTliWnlDUG5hemQ0aXRBTHVqTXEwbFZlMnRGWkls?=
 =?utf-8?B?cnFodStMdE9rclpiMzljbkJrQmhDVlA3MnBLT2d5WjJxc0JNbC83cFJSSVdi?=
 =?utf-8?B?WUpXalFld2lYMVB0VU9KbG1YS1p0UGJkUVRvNHZHbWlJRE43eGF0eG8yNGUr?=
 =?utf-8?B?bHB1b2sydldOVThPUXRxUXNDM2YwbzNTNnZtd0ZWQ01xQjlzOXZMYTRZalVV?=
 =?utf-8?B?Q2YxVTcxdGkybTlhS3g0dDVaRkQreFdnSVBEcGNKRkRURkVwWFY5cWVSZm9v?=
 =?utf-8?B?UjlEMlI3cmNORWRVbE9YdHpEY0FLd1haWFN4c1pPbDVrNi9YZHlFOVE5aEto?=
 =?utf-8?Q?TN3xIDG6JAwlaFf8ZHu9V/yFG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f43e35f-9cf4-40ec-b52e-08dc10689331
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:40:51.5917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUfFaaoE0WNVcdsZ5h1L25Y37P44coznNG7X2f/5FdaWI1QnDPVb3a4Y6FcTtU0XEbFRTbgOeDnIeYpj8a7d7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
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
 Harry Wentland <harry.wentland@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/8/2024 9:58 PM, Aurabindo Pillai wrote:
>
>
> On 2024-01-08 11:19, Srinivasan Shanmugam wrote:
>> In edp_setup_replay(), 'struct dc *dc' & 'struct dmub_replay *replay'
>> was dereferenced before the pointer 'link' & 'replay' NULL check.
>>
>> Fixes the below:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:947 
>> edp_setup_replay() warn: variable dereferenced before check 'link' 
>> (see line 933)
>>
>> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   .../dc/link/protocols/link_edp_panel_control.c        | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git 
>> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c 
>> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
>> index 7f1196528218..046d3e205415 100644
>> --- 
>> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
>> +++ 
>> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
>> @@ -930,8 +930,8 @@ bool edp_get_replay_state(const struct dc_link 
>> *link, uint64_t *state)
>>   bool edp_setup_replay(struct dc_link *link, const struct 
>> dc_stream_state *stream)
>>   {
>>       /* To-do: Setup Replay */
>> -    struct dc *dc = link->ctx->dc;
>> -    struct dmub_replay *replay = dc->res_pool->replay;
>> +    struct dc *dc;
>> +    struct dmub_replay *replay;
>>       int i;
>>       unsigned int panel_inst;
>>       struct replay_context replay_context = { 0 };
>> @@ -947,6 +947,10 @@ bool edp_setup_replay(struct dc_link *link, 
>> const struct dc_stream_state *stream
>>       if (!link)
>>           return false;
>>   +    dc = link->ctx->dc;
>> +
>> +    replay = dc->res_pool->replay;
>> +
>>       if (!replay)
>>           return false;
>>   @@ -975,8 +979,7 @@ bool edp_setup_replay(struct dc_link *link, 
>> const struct dc_stream_state *stream
>>         replay_context.line_time_in_ns = lineTimeInNs;
>>   -    if (replay)
>> -        link->replay_settings.replay_feature_enabled =
>> +    link->replay_settings.replay_feature_enabled =
>>               replay->funcs->replay_copy_settings(replay, link, 
>> &replay_context, panel_inst);
>>       if (link->replay_settings.replay_feature_enabled) {
>
> Please add Cc: stable@vger.kernel.org in description.

Sure Jay!, thanks for reviews! will add this in description.

Best regards,

Srini

>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
