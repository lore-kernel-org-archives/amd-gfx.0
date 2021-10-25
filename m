Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B3DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 14:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC876023B
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 14:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DC876023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04A58990D;
	Mon, 25 Oct 2021 14:42:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E1B8990D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 14:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTzMAALKy+2IFpvOPjuFYkGL+tly02/oTisfwioHfKkMnuiEKCwpBNM/fIF7oYxu70/frZhTWXOknq0OldA2Mh+HOnz/sAKRkhN0zGGI9z9mfjFsfOiMzplFx0P4FdwR/baRbIAqdVr+aM9SjobcAUpBioaLR1RDpi4uQE5DQfbye2LPgwy5H0cvgtROdwZ+cefodmjjzJm08LM/p0LxwRvXd7Lk7xkRaw/+Y/mSfJEHaOo6VVGLrHRNUDLxZzDHxKfK935+YcoRvQF1diMt6jvRgqUZT+FNhdUu7CziEtvIVV8BGaooj3ynrr+3rRDBmGbPtQrO2QcwMMivihTEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgR5PbHUFBQmC+80NtTQRE3wRtMWLr6qkbd1/Oo2ZtE=;
 b=SGtGdX176jZF4/ff9nGKQiZ2eSTmA0ooFDXq521hE0MinEB4fsHICAFmiJdty6FM3iCqpIVlbrr0s3Q3yxBgIjstGv3rLVJ8vZbXNA54WaOez4J2QaRXY9kG8xTkvdw98JZ6pmsQx+N8RNAYJjD48RxKnanoABsmmU2icUZ6RqJxOSj/508ecUF8fC7K+lUJbWNXDnAPb7uv5SstV/AH3lFoDf6pzh/+v8dCO5LfwAa5C957D6KfigQrY+bOx/LQG0yJ7TJxLWY5Kh2P8kqJJ+nULoimMzx6aeF8i06DXiVZbKFW7IQy9xHzKstwc7BuMa8uPt9AaS8Gxh39hV8/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgR5PbHUFBQmC+80NtTQRE3wRtMWLr6qkbd1/Oo2ZtE=;
 b=XuRJbnURUZ7/ZdmDm1ysyuSCCE8Klbm18Yg7S6i3uXKOTH5oiC256+H0il+7Bknk7L8P1cKmXFu0qO86R9x9IJVrExWR8r9mV+cASZPqODhAHn3Qfi6ro9kk0dms2nfKNHgfUdCskaDXmWXHb4GaC6joS/sNWesNT+TuOg2GVMA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Mon, 25 Oct 2021 14:42:29 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%9]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 14:42:29 +0000
Message-ID: <90804a63-686a-7f84-ba20-db06a101fbec@amd.com>
Date: Mon, 25 Oct 2021 10:42:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 32/33] drm/amd/display: fix link training regression for 1
 or 2 lane
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aurabindo.Pillai@amd.com,
 qingqing.zhuo@amd.com, mikita.lipski@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, wayne.lin@amd.com, stylon.wang@amd.com,
 solomon.chiu@amd.com, pavle.kotarac@amd.com, agustin.gutierrez@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Eric Yang <eric.yang2@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
 <20211024133141.239861-33-Rodrigo.Siqueira@amd.com>
 <16010bef-7bf4-1da4-9f76-7b23d4296d5b@molgen.mpg.de>
 <93093738-86a1-056e-08fc-803aecee27f1@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <93093738-86a1-056e-08fc-803aecee27f1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0246.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::17) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 LO4P123CA0246.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 14:42:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efbead88-0f6a-45a2-c804-08d997c5ab28
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:
X-Microsoft-Antispam-PRVS: <DM8PR12MB53999684689FDE0B565A5898EC839@DM8PR12MB5399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nA4ZexdNSfppAubbA9xwrhG5z5wl8mig+pmre9nzxoiCVSsgaVyoWgARJNZ5/irKl93/AMj4gVVWHGwaJ6ml46WXq071fnv6pYFOMYntH1FMQIiNOYRJjWMM0fpzPdCb61eHSB3Cfb1GP3qN3fR67K0ZCERIKfCEFeRZcu93gu6+fU49q2O4foVr3hB9ghbjJc/NWFftZWDEnejwxRi8LUMyAUqR0oWLinRlHNMhc/ia1BTIOZKceD2xvVIYD7ZS/MsrWbMJkcdEGadvYHCSc69926ms+fr7FYoGgjI+EWlEhFbSOigfjioOkHRp5EDwjPPYpaDtFZXrNu0RcEJvIVm5YV5bw4TMMrdBs8oXdNdhsPUAKHXtG4nHq5cr5MywG6CAQOgxPwSXTyejXBPLwHNJjf3eVvVr4s6Ee+6x3eFD7eUYcBU76I/Z0VjoU8tDlKzPSlTzrEb+sYgS7TfITfDSmpNYPEXdRJb3uVtozNnakZpc3HVSIIqvUQqOM1rdqw67qzmA1ySVoTFQWTVismRVZ8Kx8Og+LLTSev92+Q7+hq3wQ60EdvkKN6MMi8c7aNc03YEPxBOjoScMvWjtwrPJ09UCpa1f00uAKo5cKcWPI7GdUSOKeW3wULlC8VjOivTFfGMxXvhNRXlg6veyMmXkKCwf9pUJvoCNUojFbdy20QPwDPUVlacc0YkW/Ox6zR5ZGT7NUUwUaayhe7+yMZGdL2MVP5fNGYPI3SUOYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31696002)(38100700002)(26005)(36756003)(4001150100001)(2616005)(2906002)(508600001)(8676002)(66556008)(86362001)(8936002)(5660300002)(53546011)(66946007)(31686004)(54906003)(83380400001)(6666004)(956004)(110136005)(4326008)(16576012)(66476007)(316002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVxMTJhNlkxZ1VJWUVvRjRyMzkrZTYwSGlwY3FyZml2VW8yejc5c0VGeUwx?=
 =?utf-8?B?UHJQVDFBaCt0Vng3R0JmMDEwSGljN2poRmorZUdoTmYrV2lUZmJuV2xqZ1dz?=
 =?utf-8?B?Q1k5eWxvVEY4VGc2ZVVYSE1ETnVpZ0txbzlBWWR6RjdoN0FQTDFCb1Mvem9Y?=
 =?utf-8?B?Q0gyK25ST0pmQTJJczBTNFdUdkJoOU9ieWhkL0ZlelhWVE9OdkpuS2FQaEFX?=
 =?utf-8?B?RnF0VzU0M2VOQ0dmV2NrYWpQU05pKzNpZ3I0NndzWXRuUWtwNy9ORGd1Y0RP?=
 =?utf-8?B?dFZxSTc5cm9TM0ZiWjljaDgvbUtmSEt5NDJTRFlnbitTRktOeTJ5N3Y1NFpE?=
 =?utf-8?B?RjR3eWxIL1BiRXJwTi9XanVMRWM4MXBYSkFUTEZFbEk2QUk1QkVGeExKVDNN?=
 =?utf-8?B?WVY1RWdBdU85aFdKYkJMY3c0VG8yeWcyWVpMWEEvN0JOODUyYVk4K0swRXJD?=
 =?utf-8?B?bmZyak1IRGlyam0vQXF5UkZmNU52M2JqUGo2dUxHa3ZyUmpFK3dnVGFpL2J4?=
 =?utf-8?B?VXNzalF6SGxyQVdad0ZPRDNNKyt4WHRzajJsL3pzcDNrZmRZeGsyS1ZkWENh?=
 =?utf-8?B?WGJ4K3Nud2RHd096Nmg3cGxhUWZ3V1NTNmpYakdqdHZNdVZvZFJKU1VyQXFy?=
 =?utf-8?B?L0oreWdORVd0SE5lSzJkRnRDSS9OVXZoWDJKYlRPOHNGcjZKSjlsenNJa0o2?=
 =?utf-8?B?WlFQRm9qeksxTVZERm55SnVPS2FRSFBkbUFhQzZ1NE9KS0h0WHNHRXpoT0NG?=
 =?utf-8?B?Mm9ZK1dJbVVwanlTVmE4MHU1bVNydXN4M0szNFRVSjBrZWNTWERmVUQxd2Nh?=
 =?utf-8?B?NW9YZ2RVM1JscmdsZlczb3ZHd3FwRkY5TnJCdVAxTCs5YTJUWlI2R0JDaGUw?=
 =?utf-8?B?WllHTGNWbFRkdHdmcE1KZmdENkJXUldSQ0VhSHY5dHhhMXFVWHpBV3BVSFlp?=
 =?utf-8?B?N3dvYzVWV2Z2MXJ5K1BkTEpSS0FkYzM2NXZ6QXN1Q0RsNjVGdkU0bmZxTmhs?=
 =?utf-8?B?MmtTSmZpSzdiRFFsbTQwVzRENy9ISWN4TzBBQWFFWHdkbEZPSnl3M3hhT1RD?=
 =?utf-8?B?RVhsQnl6cGw2MjhySHpOL242ekdydW5Hb2s3elFtSmxvMmFoa2c3Zy9OcURX?=
 =?utf-8?B?RmpLMDUreXNMOHdOSU5YcUZwS04zbDNqWHZyZ3BaMExmanFPTEcxc2l1VnZZ?=
 =?utf-8?B?MTZUM0QxQ09XVzBKNHBJVitjazh2UWg0VVFOU3JnYWtEZ3F4SGJ5RUdLcDE1?=
 =?utf-8?B?dndlVXdBS2J5bVgxQWFqUXlURU1OMUpVdkI3Y2lBdDNhc04xTVBoN1VZdEU5?=
 =?utf-8?B?Sm02M2YvT2Rvb3JlSEZNRUFJUFE3eFd5TDhsRzlpd1ZzTnNNYmo0YXFuS09z?=
 =?utf-8?B?KzJ5dWo4QjZYYVZacFBVM2NhZk81L1R3TjJaenQxZ0VwM0FpTlBBREJxeTR0?=
 =?utf-8?B?U1dZMk9GT1pqUjVuaFFXUkg1a1ZWOERpbHhYbTE5MjJDQnlTQkhVd2Rnb3FT?=
 =?utf-8?B?dk5IeXNaTmlwU0tuNkd4Tm9ieEw0eUtISFQxdlJSdmxoV0x1RTZWNzJVZTNn?=
 =?utf-8?B?NlhIalJYNDlSQlZScjVHd2FnK285YlpVKzIzUDM3dVdQaGtCdDd6bkkzTGFT?=
 =?utf-8?B?L282RlV1bmdLQUx2UW9yTXhvWXFIRDhDa1FpRVRHNFA2U1V2QWxyTWhzWDVy?=
 =?utf-8?B?aGFOMUtuay9YWldXSkRoOUx4dzJnZVZ6b011MjFPaWRjR2dCTStHOFRxRjRN?=
 =?utf-8?B?bFdKdlp5Z1l3b0liaE9SNHFIYVRHMVdYKzl0Y25KWmk0d29vcUswMThjK1dm?=
 =?utf-8?B?Rllsa0YrVjlyV0xVKzhuQjRkUWE4RXpqc0hQQ1JRVXRLODNMeXFCZDAyeXI4?=
 =?utf-8?B?QXNCTjNEem44ODZxQnZ0SGhJT0VLWldldmtSMEpBMG1heXM1akpjZXptMXhq?=
 =?utf-8?B?a2ppYXJkelVxYnRJYWZydlNmTnVMeSt2ZUJjQXhZRk44cFJQOFNzVmRUYVVO?=
 =?utf-8?B?L2V2WW5rNWl3MS9TZWxzaUhvR05vQ1VCRGxsZ0VsdUJaYnVIRE1DZTRuRkY1?=
 =?utf-8?B?MmlqTmVuZVlzVGlKdUVLV1RlQ1JtTWJuYXlJTEtRUnMrSlhMUXUrMnBkSjZn?=
 =?utf-8?B?SmVqR3hWUTJkZzdHKzJMYXg5d04xSlNKQlNlVS9vd1B1WHBFMjhiVnBkQ0Jy?=
 =?utf-8?Q?al+WHwY2HZCU/9Lz7eWsXLA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbead88-0f6a-45a2-c804-08d997c5ab28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:42:28.9247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q0ue3gQzcfoDjkaKIUuNG7KcYkHcWoxdtE87pLgZKZmy2VRwe+mfxcuRQHtiVWK5SccJ5weBPzEYDffd6EvAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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

On 2021-10-25 9:58 a.m., Harry Wentland wrote:
> 
> 
> On 2021-10-25 07:25, Paul Menzel wrote:
>> Dear Wenjing, dear Rodrigo,
>>
>>
>> On 24.10.21 15:31, Rodrigo Siqueira wrote:
>>> From: Wenjing Liu <wenjing.liu@amd.com>
>>>
>>> [why]
>>> We have a regression that cause maximize lane settings to use
>>> uninitialized data from unused lanes.
>>
>> Which commit caused the regression? Please amend the commit message.
>>
>>> This will cause link training to fail for 1 or 2 lanes because the lane
>>> adjust is populated incorrectly sometimes.
>>
>> On what card did you test this, and how can it be reproduced?
>>
>> Please describe the fix/implemantation in the commit message.
>>
>>> Reviewed-by: Eric Yang <eric.yang2@amd.com>
>>> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>> Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
>>> ---
>>>    .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 35 +++++++++++++++++--
>>>    1 file changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>> index 653279ab96f4..f6ba7c734f54 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>> @@ -108,6 +108,9 @@ static struct dc_link_settings get_common_supported_link_settings(
>>>            struct dc_link_settings link_setting_b);
>>>    static void maximize_lane_settings(const struct link_training_settings *lt_settings,
>>>            struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>>> +static void override_lane_settings(const struct link_training_settings *lt_settings,
>>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>>> +
>>>    static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
>>>            const struct dc_link_settings *link_settings)
>>>    {
>>> @@ -734,15 +737,13 @@ void dp_decide_lane_settings(
>>>            }
>>>    #endif
>>>        }
>>> -
>>> -    /* we find the maximum of the requested settings across all lanes*/
>>> -    /* and set this maximum for all lanes*/
>>>        dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
>>>          if (lt_settings->disallow_per_lane_settings) {
>>>            /* we find the maximum of the requested settings across all lanes*/
>>>            /* and set this maximum for all lanes*/
>>>            maximize_lane_settings(lt_settings, hw_lane_settings);
>>> +        override_lane_settings(lt_settings, hw_lane_settings);
>>>              if (lt_settings->always_match_dpcd_with_hw_lane_settings)
>>>                dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
>>> @@ -833,6 +834,34 @@ static void maximize_lane_settings(const struct link_training_settings *lt_setti
>>>        }
>>>    }
>>>    +static void override_lane_settings(const struct link_training_settings *lt_settings,
>>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
>>> +{
>>> +    uint32_t lane;
>>> +
>>> +    if (lt_settings->voltage_swing == NULL &&
>>> +            lt_settings->pre_emphasis == NULL &&
>>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>>> +            lt_settings->ffe_preset == NULL &&
>>> +#endif
>>> +            lt_settings->post_cursor2 == NULL)
>>> +
>>> +        return;
>>> +
>>> +    for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
>>> +        if (lt_settings->voltage_swing)
>>> +            lane_settings[lane].VOLTAGE_SWING = *lt_settings->voltage_swing;
>>> +        if (lt_settings->pre_emphasis)
>>> +            lane_settings[lane].PRE_EMPHASIS = *lt_settings->pre_emphasis;
>>> +        if (lt_settings->post_cursor2)
>>> +            lane_settings[lane].POST_CURSOR2 = *lt_settings->post_cursor2;
>>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>>> +        if (lt_settings->ffe_preset)
>>> +            lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
>>> +#endif
>>
>> Normally these checks should be done in C and not the preprocessor. `if CONFIG(DRM_AMD_DC_DP2_0)` or similar should work.
>>
> 
> Interesting. I've never seen this before. Do you have an example or link to a doc? A cursory search doesn't yield any results but I might not be searching for the right thing.
> 
> Harry

I'm curious about this too. The compiler with optimizations should 
remove the constant check, but technically the C standard only permits 
it - it doesn't guarantee that it happens.

However, this patch should actually be changed to drop these 
CONFIG_DRM_AMD_DC_DP2_0 guards - this isn't a Kconfig option nor will 
there be one specifically for DP2. This should be folded under the DCN 
support.

Regards,
Nicholas Kazlauskas

> 
>>> +    }
>>> +}
>>> +
>>>    enum dc_status dp_get_lane_status_and_lane_adjust(
>>>        struct dc_link *link,
>>>        const struct link_training_settings *link_training_setting,
>>>
>>
>>
>> Kind regards,
>>
>> Paul
> 

