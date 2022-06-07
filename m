Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF2BC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 15:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEC210E3FF;
	Tue,  7 Jun 2022 15:02:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A1110E3FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 15:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHj9ZCFDyb7Tbcg9iqTWfPQxJZQE8IeXAgbJUYgBsGDdaSLcdyaM8SpvdboIHXwg/xiE3wkedtwIVFSxgQH/rTF4K962oL8O386GqzKRSgj66X7O3PBq/lGycRCR/7fnuteQM2/eUgbhtAC9l4z3bFj6K2YVvwg3LCJRIzOGUhACO6sorYXC/67sx2kntRzfFht4tY8DKa5F4bADy6th1+nHyOM4JYqJCOo+yy7DVRx3mQ0l3Od/6YWSEs7zh+Iq2VdXfth2YTyNl0fHbVRA3HySUp/VkzDRsJ/eyL4HgK6jxmnMm7n39eGbZ2A4mASdgOkdRroAyHvVLOT+U/d8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pVl7YOIx8CwukHVxOxXDKZntnRSGbeIhJuE7wVf6hM=;
 b=XDllC3nYXoEIMHXZrpZ05UsojTSRRihqgwnxGfsnWun/6KJaA+EnJ8CfX9u7nwvECR72d88sPk9r/wYERqfkPvquZemvvhS7PqWcSTuJowZEY9pIT9C1aYpjKoTzc/JRaoENZG5QN3YNDSlyYnfKO3wQjVZGiCyiOiGkZ2+DKyhYoX+WnUPifROZBrgPSk0zXraRxbtqDPWo8AsnZPT6PM5TVS/iCdncJeBB5NJMCUOotnlnBWMZ9LuTP4xVScpujC4pemJMaRjIyHxR+1PTr5FwvV79D1CLxRKclwgRbpBdDAtqg5avgtzGN/mtWTbDuqUOntZYbVFkG9hC+XXvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pVl7YOIx8CwukHVxOxXDKZntnRSGbeIhJuE7wVf6hM=;
 b=R6Z4jXY84tn0KGumaogW8ZFreK2KcRb9FNh4yzseN5Y08HyVQAgBajMJpH1BzexoinznO9fM565d7rnZC6gr2seoRBpEe6ZNsqOPeO3GctBNmIOEFQHEEIOfev+1qL/Pfu68QjRoAi1qdPlF/rTyfKD0S/v/YSLLm0+1PvigalE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 CH2PR12MB4023.namprd12.prod.outlook.com (2603:10b6:610:14::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Tue, 7 Jun 2022 15:02:26 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 15:02:26 +0000
Message-ID: <56dedb43-b6b6-6032-764b-1e2ccde6c813@amd.com>
Date: Tue, 7 Jun 2022 11:02:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: Fix compilation issues
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
References: <20220607082636.847593-1-chandan.vurdigerenataraj@amd.com>
 <CADnq5_OUvKuW0Z70km1HTFqn8KyZ0LXhLfm3mVqcDiHfUL2=EQ@mail.gmail.com>
From: Leo <sunpeng.li@amd.com>
In-Reply-To: <CADnq5_OUvKuW0Z70km1HTFqn8KyZ0LXhLfm3mVqcDiHfUL2=EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:32b::26) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502aab72-b906-4202-dfe3-08da4896bbb9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4023:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4023A74ED9C7515E23AA751C82A59@CH2PR12MB4023.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+jStpLZZ/CRaFyvtG51wJXTlEPxQ+pjonpDs77cAOHZC3kJ6rWqA4jLv53gvKtuFC1uV1nHpyEJN1qrJdp1WxIFHdhOd/QAuDdzvnZyS6KSRwSe4GEnbbNM/c64exdeh62wT7wulgaV3as4MF1wsnAplzz6KDrSbMeTPxCXqh6YVdlqwqYzo/azmsBsk+dGYGVAyNipYo2Bd8Ir+kEXFf1ThJ4IU91ZiKkbMT2CdArhZFT39pG+Wdi0opS7r6+O2eaHdzozwVVKGxSsHeP6NJKfnANBuoSuS7U/N6dyecz2dOaS8ZnHAS4/l+OdI7y3X7VWX3NrCMq3Mr0q7rn4KEdLnMkdm0REZMlq6M1dpBHhCtTsxnNzGylQZ0hKlVh+q0QwWHolTEkogxamFjYn18p+UT7Lg6nLZTT0UeIWIYe5nCxHaTwFhpx40opVZ66voeH3p0aZ1tbpkHMGxG2QSUR+iN0Oph63NbvYY9zqTYUDx5CF7CGj/oae9mbHovn6pN2tWAvDvDOV0U8SmhvTfzftFmGzyfruL/YU4rumUnmnAxg+12X/kpYAawVAMhiC4y8ESjcUykNv8/lkBCO+SQ/Hs5rMtOXpoSIqpRqTOD323ep7GIiuLpehIyHms6ASOzJ//qEH7doH38BjrFmoow00/qh5Y1flPoR1Kx4F66UZV4mda2ZPSfX9AS92PtOfrhNIFyihybJZ8o7Qyd7zaotYcUPd7jLK+Yxx/Oe9o3Z8qdGA9BZ+8KKsWDtmaxPQ0xivk/L0DuFvByRHh3PD3m0WKX0nrB7TNHEPYiKCNZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(6506007)(316002)(8676002)(2906002)(4326008)(5660300002)(31696002)(66946007)(8936002)(66476007)(66556008)(26005)(6512007)(86362001)(110136005)(186003)(508600001)(6486002)(38100700002)(6666004)(53546011)(2616005)(6636002)(54906003)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNXU3pZM3JyalRDUkszV01iV1FDb1dzZ0NaYTB2aktjSGVmV3hOb3dKU1F4?=
 =?utf-8?B?blhtY2l3bWxNNm9OZXVJeXluWml4M1JoTXVOeW5MMngxS1dvd29ja3Z6TFdC?=
 =?utf-8?B?NEtqbm1nQ0Rqam1tY3ZuZDBHUHVKcGI1Zy9qcE91Q0g5STRYUC9iS3VLSUY1?=
 =?utf-8?B?eFBXeE96WHdaWHk1MGVDQ2JqbVpXTDFaT3cramVhV2J3TXIwMTJQN2lkSkRx?=
 =?utf-8?B?bGhCLzU2azVqVGJTQnEwbFhwNkhHU2lLK0lsaVA4dmw5VFNyU0pWenF3S3pM?=
 =?utf-8?B?a2lxUUpSaEpiZXFVTnBGQnFxSTdhL0VESlNYQjNsOVZjMUJJT1RFeTlldmZw?=
 =?utf-8?B?a1krOU5CTnplcEFoSHdRY3ZDVHNJRmdNYmg1bEttSEwzMUZqVERCVXNaWmsz?=
 =?utf-8?B?NjhJSjdudXZVMzJQZy9uZTBDYkhlRGVOcGpRMjFUVlZva0dUblE2VTBpYmN2?=
 =?utf-8?B?ZitLbllDdDRvZUg1M0V3Z3FOakRxVUlrRm9rSFVLMUN5Vk15NTBYeFg1Ky9E?=
 =?utf-8?B?aEhkN3I0L0grUWU2dmljUDFOK3Q1QUY2Q0J5N1hteVBwWWh1NUlucFJ0Smhm?=
 =?utf-8?B?Ri9KdEIxbmh1MFJmVEJ5cFlCMGJhbGRQT2lPZnNpTEtmaVl1aFZqazczNUNX?=
 =?utf-8?B?SldsbTVRaE9hRmRCaUtJaHhLcVVRbjR4RnpPQ0pWMG03LzQxUCtIVnNtUmNh?=
 =?utf-8?B?L290T1pkdTB6K2hYNEdYcVpSSVc0VGZSNW5EeWxMQTRXOWd6K0cweHozS09q?=
 =?utf-8?B?K1NPa01qcHAyU0N3WVp2eEdlZ0E0blp1MngvVGtYaWx1Y2NhMjFqWHdReHBv?=
 =?utf-8?B?M2NQdnhaZjlLMzJFVUtBWFdVdCtaQjVCZThGQ0VyWlNhMWIxZmE3ZHZraTlE?=
 =?utf-8?B?dndsbkd3R1U5UGthTlhseW9lWk16T3dteWZuczhDbkRYRDhoM2lXYm91Q0Ro?=
 =?utf-8?B?WjJDMnZETjVxSFVWVVNUNjA3VWZROCtVMVlGQ2puTEFSQ3NTUWExbDFUanJl?=
 =?utf-8?B?Slk4elR1ZEVUWFhUWDFFM0N0T0tYQnB4RzdrdlV2WWpsZTBqUmZPREZMVWNk?=
 =?utf-8?B?NDliY2ZNVlU0UmRHek5HQVNjR2thRnltb0JOM3l0akVZZ0lZaks2L2srekFR?=
 =?utf-8?B?WXo4NXVNYzN0RVVRS2F1bEZGbXRjeCsrdWJlTjBLcStOREhDRVZQbkl6aFRG?=
 =?utf-8?B?NVR5TzR0SnFEdlBwdkpkazQzMEtrQkZHK2JCdURmZmlOOWZSd0lqN2dLNDlU?=
 =?utf-8?B?c0JqOWRMOEYrOW5oMXJ2MFhLNWRDNzZERjlJMHVtR09Cd1lTR0Y1YW5BY0Z4?=
 =?utf-8?B?QmY5VjVVYTd0OHJ0dGRCbVBDOHk4TUEzams2T0lGSmJhZ21EQzVvb0hKSEhE?=
 =?utf-8?B?dmk3WU14cnRtTFNSYTkzY2orQWhBRjZXWmRyQm1Ib2ZFNkg4YWdiOWFBTFRW?=
 =?utf-8?B?N1FFVzBMZmFjUVBlMk51U0VYMmVmcE5jNERzRHQ5TzNTRGhpaVVNSzdGd3Zz?=
 =?utf-8?B?eWFJYW80QitlTFZIWFYwWnQwbWRnQ1dOUGNULytTVkZLS2duQktybmJ3d3Zk?=
 =?utf-8?B?ZkNaWndSM0xvMVd2TmdUdkFWQ3NqMmpEREFUV2NqZ0JuMlBsT0lUVytmVlJi?=
 =?utf-8?B?NkpOL3luRkQzVlhFWVRxbVh2OU15UTlpRlNVYjdhL1dsbzJFVyt0YXE3SEFM?=
 =?utf-8?B?TSs4WElyNU5wV1p0S2dGdEtsYWY5VFpYMkFHNFRhTjNqQmxqWmtJaVFod0RL?=
 =?utf-8?B?UUlrMTY5M2dpeXErZkM0M0FIMnM4K1BRakJ5c1ozMTJ0UlZKKytZYmhaVTZC?=
 =?utf-8?B?M0JLRldZTXhob1lxdEtqTGdFd3FhRVJLSzB2UjVJbFVWZWZNUll4eEZQZy8y?=
 =?utf-8?B?R0ZkaytjMS93SWViRmluVDRONzdBL3dpNjc5WkJBZ1VsalczUTdjNEo1ZXR2?=
 =?utf-8?B?bkNURVBIVW1kc0MzSjJ2UkR1SUdIK3RrN0Urb0hyNzBtR1BXTlNIQzgwdGQ4?=
 =?utf-8?B?dzV3VkhpTVNDVjdEYWxCak4ybnlXS1RWWEV1ZTJ4VGk2SkpRSkdpRThrUnVM?=
 =?utf-8?B?M3hhejlObUNzVXdySmVqSVhsemxkdDhkNTcyTzlwVExMRmhKUzdHY0VEZENh?=
 =?utf-8?B?Vi9LUXNGZGUyNmM0R1VHK1ZydkFwMTliUGREeFNqVzFFN2REVjc5UnY3MCtF?=
 =?utf-8?B?TzJUMVFienQ3d0NaY1FpcHpHa3g4NjNFcWlWQlJFU0srSDltQ1dqTW9nTmlG?=
 =?utf-8?B?cCs4OXluWDluakRSSmxPN2Q2Vkl4U0RiK1hQVWtVdWJLMEIzWGVKSXZmSHpC?=
 =?utf-8?B?aTB2NFhhbXhRRDgzVFMxbHhHelNBTVRwWXBLcnNqUllnbkd6ZTNpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502aab72-b906-4202-dfe3-08da4896bbb9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 15:02:25.9411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LMrDq9pH9C3Vl/gxis2rTAKvyKsffDznyOHF4P+lxl4plHCWL+8q2DBJfNqxfbx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4023
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-07 10:00, Alex Deucher wrote:
> On Tue, Jun 7, 2022 at 4:27 AM Chandan Vurdigere Nataraj
> <chandan.vurdigerenataraj@amd.com> wrote:
>>
>> [Why]
>> Getting below build errors:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1419:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>>                 default:
>>                 ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1535:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>>         default:
>>         ^
>>
>> drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:3276:20: error: variable 'v1_5' is uninitialized when used here [-Werror,-Wuninitialized]
>>                         for (i = 0; i < v1_5->number_of_path; ++i)
>>                                         ^~~~
>>
>> [How]
>> Fix compilation issues
>>
>> Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Thanks for the fix!

> 
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
>> index 3540b46765fb..25791ed0559d 100644
>> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
>> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
>> @@ -1415,7 +1415,7 @@ static enum bp_result bios_parser_get_lttpr_caps(
>>                 case 5:
>>                         result = get_disp_caps_v4_5(bp, dce_caps);
>>                         *dce_caps = !!(*dce_caps & DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE);
>> -
>> +                       break;
>>                 default:
>>                         break;
>>                 }
>> @@ -1532,6 +1532,7 @@ static enum bp_result bios_parser_get_embedded_panel_info(
>>                 default:
>>                         break;
>>                 }
>> +               break;
>>         default:
>>                 break;
>>         }
>> @@ -3251,7 +3252,7 @@ static enum bp_result get_bracket_layout_record(
>>         static enum bp_result result;
>>         struct object_info_table *tbl;
>>         struct display_object_info_table_v1_4 *v1_4;
>> -    struct display_object_info_table_v1_5 *v1_5;
>> +       struct display_object_info_table_v1_5 *v1_5;
>>
>>         if (slot_layout_info == NULL) {
>>                 DC_LOG_DETECTION_EDID_PARSER("Invalid slot_layout_info\n");
>> @@ -3259,6 +3260,7 @@ static enum bp_result get_bracket_layout_record(
>>         }
>>         tbl = &bp->object_info_tbl;
>>         v1_4 = tbl->v1_4;
>> +       v1_5 = tbl->v1_5;
>>
>>         result = BP_RESULT_NORECORD;
>>         switch (bp->object_info_tbl.revision.minor) {
>> --
>> 2.25.1
>>

