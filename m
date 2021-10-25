Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09A5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 15:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9018860F92
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 15:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9018860F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F1D6E049;
	Mon, 25 Oct 2021 15:25:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FA36E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 15:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwT4iaZANLQWcbFoYy3L0PhZR8/pC1E120V9YRuXo0iNl+cSPEVY/YMwf4+5lEGly7h+nL3dK+5hYZ2UwLYC9oExnvLEfx3d3jWpWS6mrPHrsHxyaI5lrvhkIcUzk32qzXXfvJDxtvt6P2mlDSWu8FEXUTtGm/QE/NEUOBM6YLBjLeMuRkDaHhuBlJcSPG8rc0vFgMeI9dBTqQK9LCQCFwJKUHto+Guz1vn5dxgB+A4b7AiWPORSDan9tf0P4nTKE83bBVs1iGklpPnJjxc0SsOohzC0gBxahDSPFR85XlVICYM1BlvxEkRlNOO73GUrvXIzIwoyni+J4jI26RUDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bvFJxzT3CTtvpewk2ObGVY/yNOUi2CxsQ+y3ivEty8=;
 b=IWU3oubi6HbaY5r5aXbSkCT1aSBIN4ox6rEiVU0O31Kc1cA/ZSOTTy2hL6g0q6Q3TbMohi2jBDPqoA8H1Ffq5/dI+ozb2NSRVSmpjuYeNwB/niiq+r4y5jyY4ajZTJkCjIQU0B7mmRTy/3fFcFYjV3MdR8B7XO1Ppj5sy9/Elpl19ZbwYV+zjFdpQfGJPh258SB7VE0mIBjaKRmzGoTtwj6p83/Gs+jj5MKeIVSnUOtZ+TROiJ7wvV7l3AxheKdOj+2TyBpT9LWGTeBNhmw7H78GxnAAmBMMx0PGrWq2gYOPMLeA4sB83O42YdpvUt38t9hWVC3JSXmBQHq2Y9YPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bvFJxzT3CTtvpewk2ObGVY/yNOUi2CxsQ+y3ivEty8=;
 b=q9f1XeQa325X+8KXCuGmZ1kETTDnTOXwFly4LeYTyEzgam9jTToLFZziPr4hQko9qKT7XP9IAszGQPkAJjNSpgBD8sqmOwqBgbUQ0/hmqEpY6j4RsoD/zS9BLngP3CMnW8xepN0wvM7kUZjk55K0d9d4nHhJptN+CgGvIDGQ2Lg=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 15:25:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 15:25:39 +0000
Message-ID: <bb99bda4-900f-1c36-d407-d055bdab560c@amd.com>
Date: Mon, 25 Oct 2021 11:25:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 32/33] drm/amd/display: fix link training regression for 1
 or 2 lane
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
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
 <90804a63-686a-7f84-ba20-db06a101fbec@amd.com>
 <b8adaf50-b856-3425-d8d9-5c2c6090cbf6@molgen.mpg.de>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <b8adaf50-b856-3425-d8d9-5c2c6090cbf6@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::43) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 15:25:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79237713-40fd-4219-e71d-08d997cbb2e4
X-MS-TrafficTypeDiagnostic: CO6PR12MB5458:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5458D12A5F682C7C2332F4E48C839@CO6PR12MB5458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsHoYcDIS/DbT4oY1Btag0gTWADUadEo+OUB1nuBnIsMDSsRP+Zwx+AtFl0PpGCBiMWpEnZdspeNcoQ0CrtxG6x4831QfuHHEdTkynO52zMpKexYkS3XavLr6lAWBTzpFiot4UYjMtlFJ1MN/VxkCc6mP3yFbsQYfWKWCdzcD9Aiub00sCw61oCoNRz7i6VM8UhCSK58GwpTy1OU4TyLGB7KiWDLvjGzWXc4260cORCwwms42UkKKhFiPzspsEhUMn1UZRFKPadWhxxiBkiKKNXifB6IAjAIFYn3WX40B3lYZvGNKaZCH0wK60TYpnIy5BNf9nx6lbw95B5WyTa9aEKRkP4OmFElPizKgppnxVd1v3odsM2u4KDVgl7dHvpC8RwtlMAVLVIoHLAAGHK2xajSBj0LWc+XFmeP8dC3cZmkmxANsbzWMjlvfD+T/w8h151CkOHJuV8wDBDtU9OFD8KgSao0kig3ptT2W5AZCpSBiU+5r/a0B6C+RTAnZsFflzU240lOAwC0EM9+nsQCa0WX82oI8oUrETOzLtW0GiQozG7zlhCAIMXcaP7spjtOd8IHQO5Io2rY7gZAzIuGr+tafqARzYVc1df+w7gLdDk5HZwHEPZS40wAqW/sdVPGTlZP26amF37nYpxULV7EYMivReSdARlKQcvJ9RfJqk7qE/N/3GlKX5tLBr4EXNLOv/IR4Mo5rQOHGJHdp233Rt/FaPbL01tQXbuPCsDkEk5plMom4+x2XHPBzKJZKkX7M/WlVBtV0pqG6sAiCtlbO22ZLdhH9AFcl22cPFy4SykCLdA5wh14JQdbiIILfCBs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(956004)(966005)(66476007)(66556008)(31696002)(4326008)(6486002)(186003)(31686004)(2906002)(38100700002)(54906003)(110136005)(5660300002)(508600001)(4001150100001)(26005)(86362001)(6666004)(316002)(83380400001)(36756003)(2616005)(8676002)(53546011)(44832011)(8936002)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWJPTUdGOXNuSmIzN1VhTWxTb3Y3YlE3bG1BMWlkZHkrbFg2ZUxQWjRHb05j?=
 =?utf-8?B?MEdhK2lKcXRodERLcmNCR1VIOHVjTG9pMHA2bTdNVGIzNWN2YWNPVmg4dlJl?=
 =?utf-8?B?cjVON3VBT0pJMEdNekw3OEs1cStHMEdjaXRoclpYWTF2eXVRR2pGeVUzTEp4?=
 =?utf-8?B?Q2lMcVY1VUlzd2JYSThBb2VlL3Z1cy9GL2NSU1puRU9iUWhyZmlWaUd0bVQx?=
 =?utf-8?B?S1o4TGNXY2xhWDUvYmw0WTZHV2NqSXVzcnNEVzZzOC9ueEoyWVpWYml0MnBW?=
 =?utf-8?B?RUZIRWZDOU4vajRCZW03Q3hwcXJpR3pDV2J6ZWs2L21BV3pnVkNyM1ZNUTl5?=
 =?utf-8?B?SDI5WWNyclpNMDVpamtOemQwRWdMdHhsYlNIWlVGOGFrbHI4Uzh5QVpoL1dj?=
 =?utf-8?B?MmltbXJHbVlxUzZ0ZkE0MDJVK3pyamQ4MnJYTWRlSHFjdmw3eUppbjlBSjVs?=
 =?utf-8?B?aWllSDFoM1o2YjhRdGhMZEpkVnRuYnAwSzRIQ1RMRzl5aG1jamFaeTVDaUoy?=
 =?utf-8?B?eDAvU0RFQ0hTTUpkcENnNU50NW5RUmMvZGpDeGwrSTBuTk9VR1ZLbkVwZzl1?=
 =?utf-8?B?a2FwbHRDbG5uMklEcytjbitqNWx1U0tSdWRkeFQwTnBlTkZlWWRuUzErRU1y?=
 =?utf-8?B?czlLekRCZGlvWnZqbFhLYU5KTWR4UGxBM0NEWGcvRTRyS1E1NmFIMzRuTjkr?=
 =?utf-8?B?bUl5VHdJOVlLVkpOc3N4cEZ2YzVGTFkyczV2b1Y5WjV3SlFxZmpFdFg3L3Q5?=
 =?utf-8?B?Mkx0bVRKNkJjUDg3aVBTV280bTFKMnBqVlpSRWhnOGVOR3ZMV2p5NHlZK0NI?=
 =?utf-8?B?SHdzSC9wQThuZE1IWWJZelJOR2lYYWVwMnhWVi9uS3MrZityZFdoREdkMUEv?=
 =?utf-8?B?ekRaeFNnbUxURWNkRldCd0YzUzJCald5bVBTaTNLT0NTZjZwWkFkUC91VlVM?=
 =?utf-8?B?VEJXM3BLd1g5WTdNN3JxQWVxVGduUXl5d0hIZkFYM0x6eUR1c1pJczJuNUh5?=
 =?utf-8?B?aVd2WGRWRFRGWjNxVCt2QkJucFluUUR1SWhlcC82SmUyQ0F5aEo3REVzTE84?=
 =?utf-8?B?TWY2d0N5NVNKaEd5Z2FhRnNoN2taTnE1RTZ0L2M0STBPZHNvUWUzOW5ocGVY?=
 =?utf-8?B?d3pLcUtRTy9qY0hRd0dIUHdPejNoUDNUL3l0RE1VdlZlek5xaFlnRzFjNXJB?=
 =?utf-8?B?VGEvZGJFUXd2aW9UcUhHYlhzOTRyTk94S2p5V1VRWW9UUjFIUlcwaks5SXQw?=
 =?utf-8?B?eXM1cnMzdTVYU1RLdUFQQ01jblF2ZFZlNmcxN2ZuSHZaK0RmV0JVbGM2R3E0?=
 =?utf-8?B?NTV6Q0ZxdTcxVGtVYXBLYjRKSzViRk0zcHBsM0EwbG1MMXZvSTFOUmlCL1l2?=
 =?utf-8?B?ajJlanBmZFd5V0FmaUx5T1BYbC9TVEhkQ043bXpoWHFuMjRoMkpoRXJHNWFD?=
 =?utf-8?B?UTdoMGF4WmwrWFU5SHdJbVgrcFB0OVBEbWVFTVA3VWlES0NjOFNMN0YwTENU?=
 =?utf-8?B?UlI5NVdCTERueWEvS1FTdlp3SnVCTmRlRlFUbGJHZ2plUHBRTHpQcmUzbmlN?=
 =?utf-8?B?MEUrMmVVdUVYM3ZFdGhSUzBIT3lEa3JDcmNTRlJJVWhnL1JMcG01RVhpbHVV?=
 =?utf-8?B?UEl5ZnFRUDlzblhPYnEySUFCOHd0MWY4a05KOFh3enZDeGZnMEFqQnpPQ0V4?=
 =?utf-8?B?Mm9PZmZ4RE9iVkpzSGw3U1ZZdjFLMlpna3R6MHhPQ0hjNEFBOWZXeDE2K0Qw?=
 =?utf-8?B?VzNHUjJSTnRFaUhCSFFDU3d4aHkxaTh4cytSWFhlMitTMFlNOFA4SGRQWHRM?=
 =?utf-8?B?TWhEYktsazlScnFpaUpvVncrdElzdjFocFI1a1l3a09RQ21xanlPS1ZmRVdw?=
 =?utf-8?B?UDRVU0pqSXFmVTRGL0VWVjVFQUlmRnpUQVY3TDZNdE4vSUFpeHZTUnU5Y2Vn?=
 =?utf-8?B?VVhyQjBoa3lpeVF6TEJrUUxCRGFFNTJua2E3T0F6dkVNNCs2UmpKMGJyY1R5?=
 =?utf-8?B?eDZKTHJwQU9ueDNrRDI2bTM5dDhiVFpkcmRlTnk1YUVid3pSKzlRNEZ0bGpW?=
 =?utf-8?B?RFI3c0hrRjZaUldiZldidVkwZDhYY0hvZURsNXRoRGJUYXFKbzlDZy9UYjFK?=
 =?utf-8?B?cjlrdGY3bUhhK0E4U0ZCbk4vY0l5Rk9rNzdXbHU2OGw4VXVtSXlzSjkwRlFZ?=
 =?utf-8?Q?ryoJSxy3iAXWoUcS3wnVLy0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79237713-40fd-4219-e71d-08d997cbb2e4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 15:25:38.8681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rAQma9i3CEAk/+tWD/hFhz51xxOMd1FE3/lRmbF0Ypi7r85KdkEAHuunvDxWFOOa5QAVHwQarSbpk2DQWn/rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
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



On 2021-10-25 11:12, Paul Menzel wrote:
> Dear Nicholas, dear Harry,
> 
> 
> On 25.10.21 16:42, Kazlauskas, Nicholas wrote:
>> On 2021-10-25 9:58 a.m., Harry Wentland wrote:
> 
>>> On 2021-10-25 07:25, Paul Menzel wrote:
> 
>>>> On 24.10.21 15:31, Rodrigo Siqueira wrote:
>>>>> From: Wenjing Liu <wenjing.liu@amd.com>
>>>>>
>>>>> [why]
>>>>> We have a regression that cause maximize lane settings to use
>>>>> uninitialized data from unused lanes.
>>>>
>>>> Which commit caused the regression? Please amend the commit message.
>>>>
>>>>> This will cause link training to fail for 1 or 2 lanes because the lane
>>>>> adjust is populated incorrectly sometimes.
>>>>
>>>> On what card did you test this, and how can it be reproduced?
>>>>
>>>> Please describe the fix/implemantation in the commit message.
>>>>
>>>>> Reviewed-by: Eric Yang <eric.yang2@amd.com>
>>>>> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>>>> Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
>>>>> ---
>>>>>    .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 35 +++++++++++++++++--
>>>>>    1 file changed, 32 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>>>> index 653279ab96f4..f6ba7c734f54 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>>>> @@ -108,6 +108,9 @@ static struct dc_link_settings get_common_supported_link_settings(
>>>>>            struct dc_link_settings link_setting_b);
>>>>>    static void maximize_lane_settings(const struct link_training_settings *lt_settings,
>>>>>            struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>>>>> +static void override_lane_settings(const struct link_training_settings *lt_settings,
>>>>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>>>>> +
>>>>>    static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
>>>>>            const struct dc_link_settings *link_settings)
>>>>>    {
>>>>> @@ -734,15 +737,13 @@ void dp_decide_lane_settings(
>>>>>            }
>>>>>    #endif
>>>>>        }
>>>>> -
>>>>> -    /* we find the maximum of the requested settings across all lanes*/
>>>>> -    /* and set this maximum for all lanes*/
>>>>>        dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
>>>>>          if (lt_settings->disallow_per_lane_settings) {
>>>>>            /* we find the maximum of the requested settings across all lanes*/
>>>>>            /* and set this maximum for all lanes*/
>>>>>            maximize_lane_settings(lt_settings, hw_lane_settings);
>>>>> +        override_lane_settings(lt_settings, hw_lane_settings);
>>>>>              if (lt_settings->always_match_dpcd_with_hw_lane_settings)
>>>>>                dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
>>>>> @@ -833,6 +834,34 @@ static void maximize_lane_settings(const struct link_training_settings *lt_setti
>>>>>        }
>>>>>    }
>>>>>    +static void override_lane_settings(const struct link_training_settings *lt_settings,
>>>>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
>>>>> +{
>>>>> +    uint32_t lane;
>>>>> +
>>>>> +    if (lt_settings->voltage_swing == NULL &&
>>>>> +            lt_settings->pre_emphasis == NULL &&
>>>>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>>>>> +            lt_settings->ffe_preset == NULL &&
>>>>> +#endif
>>>>> +            lt_settings->post_cursor2 == NULL)
>>>>> +
>>>>> +        return;
>>>>> +
>>>>> +    for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
>>>>> +        if (lt_settings->voltage_swing)
>>>>> +            lane_settings[lane].VOLTAGE_SWING = *lt_settings->voltage_swing;
>>>>> +        if (lt_settings->pre_emphasis)
>>>>> +            lane_settings[lane].PRE_EMPHASIS = *lt_settings->pre_emphasis;
>>>>> +        if (lt_settings->post_cursor2)
>>>>> +            lane_settings[lane].POST_CURSOR2 = *lt_settings->post_cursor2;
>>>>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>>>>> +        if (lt_settings->ffe_preset)
>>>>> +            lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
>>>>> +#endif
>>>>
>>>> Normally these checks should be done in C and not the preprocessor. `if CONFIG(DRM_AMD_DC_DP2_0)` or similar should work.
>>>>
>>>
>>> Interesting. I've never seen this before. Do you have an example or link to a doc? A cursory search doesn't yield any results but I might not be searching for the right thing.
>>>
>>> Harry
>>
>> I'm curious about this too. The compiler with optimizations should remove the constant check, but technically the C standard only permits it - it doesn't guarantee that it happens.
>>
>> However, this patch should actually be changed to drop these CONFIG_DRM_AMD_DC_DP2_0 guards - this isn't a Kconfig option nor will there be one specifically for DP2. This should be folded under the DCN support.
> 
> From the Linux kernel coding style [1][2]:
> 
>> Within code, where possible, use the IS_ENABLED macro to convert a
>> Kconfig symbol into a C boolean expression, and use it in a normal C
>> conditional:
>>
>> if (IS_ENABLED(CONFIG_SOMETHING)) {
>>         ...
>> }
> 
> 
> Kind regards,
> 

Interesting. Thanks for sharing. I wasn't aware of that.

Unfortunately a lot of our configs fall into this category
for which ifdef is still needed:

> However, this approach still allows the C compiler to
> see the code inside the block, and check it for correctness
> (syntax, types, symbol references, etc). Thus, you still
> have to use an #ifdef if the code inside the block references
> symbols that will not exist if the condition is not met.

I'll keep an eye out for where we can use the C check instead
of macros in the future.

Harry

> Paul
> 
> 
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>    enum dc_status dp_get_lane_status_and_lane_adjust(
>>>>>        struct dc_link *link,
>>>>>        const struct link_training_settings *link_training_setting,
> 
> [1]: https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation>> [2]: Documentation/process/coding-style.rst

