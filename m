Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E46DC11F66
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 16:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D879661289
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 16:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D879661289
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A696E431;
	Wed, 14 Jul 2021 16:57:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3296A6E42D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 16:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwyZ2oMu2KR25R06xAOJPirQBDs38AzsEUknm6auHWq6FiS5z9x/OWNgv7XUHIWkXPU499TwtKfBS68VfyuvUjjrcxKc9ZubPPOEoGnZ4MY798+Z/VXhR1Laqi2Gxe2OxblfWP8iRFANfiPrl7fRD2LrQwuNzbDsRHXAlc1Pe+swNLs4AL4s5Zrbvpai0E3i3VKoVTWlFL88FEVbCqWodMArkP1sBcORLvFNG/iAKvKFixWKBqdvNM1jTRzkO/iBmLDyrR74eq89n5hoUcpp69pfaMYBj2fXIYEJSK87RekADUfmEF8MKrA00+Cmd4k/lUV7ut8Ja7Se4T6lCmtzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J33eYotrD8j5gd8Y/uldzE6dXqNNMoqkmSgnOWLHXk=;
 b=Jj0CZAGpNWx+DwGQKgVmbucKmfp3h9YR4EXf5w/6SXdu9QHMEk1WUd9Bjw+QIzCIl/uG5mHW9J+NAv/wn+KS5GGAfBLcu3b0J/5rGVweZJ1M5kDm5Q8lhR2SlKICKdKwoAXy2SBCUsN2dCanK0cU2FJJcwvbgFPByq5So4hwCJo2HoNthK8+pcCuFvlZjIzdlienQOfz7f2q+W8Y1JMYiilxDqSYwGN4Z5aGGkcjqEvQlTexwofsOovUWZWKM7Akaz619liivw5sRgCnnhZtb4sPcE8WvA0iaBq2bpfuqIvKvHV17qUx2EeZiTluYJvLzVru6ahaQnlb9X1PJtBmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J33eYotrD8j5gd8Y/uldzE6dXqNNMoqkmSgnOWLHXk=;
 b=H8LKXebwL9fa7bGGjkCf4VBJqEoSSdcERFLg6TbExLQGcdwS1GrZqhOSFoG93kW9kO+3PLybRJ0KNvqLE6BvJh54iKfA2pwaB90ayRU2BsPX0s3PruCE1FNPvgy7rT4YQ+7Ny4Wy5lb28mA7uP4gTVzAwM7lzAS+Le81EaCjIQk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 16:57:10 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 16:57:10 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20210712153051.4029-1-luben.tuikov@amd.com>
 <9317e662-e6af-da2f-7451-df0e1a1da1d4@amd.com>
 <CADnq5_MH4p2kWz5DX3oi0=rRGOGxo23FyDtfgCW-8aGm4AKD6Q@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <58ecee07-5d0f-6e23-786c-cf73ab1644ae@amd.com>
Date: Wed, 14 Jul 2021 12:57:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_MH4p2kWz5DX3oi0=rRGOGxo23FyDtfgCW-8aGm4AKD6Q@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 14 Jul 2021 16:57:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db4672cd-cb38-4282-3889-08d946e86b75
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB002775F2D762EEA9331D8DC899139@DM5PR1201MB0027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZjalfNZXIEgG91d1B5xQCe4VokRzYb/qNhPESkVId5mnHtn7BsfAn6nVqawBPUonBM1CbqlDFx92P2Jbc3LDILkSvo4w8v4MM4IZML4KRxNomBn6hCxZhpZ8zPbDDasyWoxo0MSThyd9gLrIpPTpPHi/mZKh3weEC/8p6lCmuP6+5lVZs9Q5QCYZZXs8GbgqRgkpVWQ1l7wuCkeaFPhWrVv8TUGTqY+6/fgnZ8MUZMUTbUk/gZFN6q4FhK8OJdCFn93svYTIPziXzJX7P8T5pHu9GKK4jXBctMV+RM4HzOUJG+NFMiiixip7pRtyPIVMArWIg3RTAZFH3Lx1Xml1FRgCdJKbHatyz8gnF77JPHAFuzc7TtPJOWeV31CCz4dm2JOfTe3r/nz1D3ViVx6Pd38cX5voEqvlXyJb6X4HAQBUntAESfL8ruO3+OxByV68/U0GOxUqO89yK3A5X/U5l2Jtd6zPWafdgD40M+a+SPPbJ22sKxLLlu/ij8ScaO5I3oCjs82xVb1PnUtX3EgZF/juRGVfyOSryJEigfreq7wztuU/Gi77oL73orkHoheXUZzyZd3QPXEtIkM93Li9DDMlrjQIlXvWc18V1vm5CMn4s9O0oB0YQITr0IgtPNwn6b/lXmgOs1SljHIKg7lhKy3fW7D3KC3jxJyl3B0RvUEplKC5uLu2gg4O9m7Fk3lnlUkTKT3Xklcd56bfZtVPBR9jG8tjxNq1HOrsxo5LCTntUXixiQknYn4sVYVXZWO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(6506007)(55236004)(53546011)(2906002)(186003)(966005)(8936002)(110136005)(54906003)(478600001)(316002)(45080400002)(8676002)(86362001)(38100700002)(30864003)(66476007)(31686004)(31696002)(36756003)(6486002)(2616005)(956004)(66556008)(26005)(6636002)(6512007)(5660300002)(83380400001)(44832011)(66946007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXgvVlJZc2FFalJ1Y2dGV3Nja1ZOZ1daNzJBaHd5T05UUHRjV3FQK2JzQm1q?=
 =?utf-8?B?TUNBNmlrdE5wZTNQYjc1OEVSdk1lWFA5RGRDNmdZN2ZjRTUxNzFQOEhIOEYw?=
 =?utf-8?B?TDVweHFtWDFRWHF3ai9VMEZXeU9FekN1cXR3UVVFRmdRMjN3ekpzYk9zUnAr?=
 =?utf-8?B?aTYzbTluK3FlZnJITmJmZHVrTE0xeGRFU0p5ZnMzMVFMajlMMThpeGcxUW5T?=
 =?utf-8?B?N2RUQkkrK2FsbFRjbVkyTXZtc1N6MisyMVVzOGFORnY3TXd6d2hwS1ZQcHVk?=
 =?utf-8?B?NThQVGg2cys2WmdCTFViZVlSaE1Hb2NmN0c3YTNOakd0NGgzSldxaUJOak1C?=
 =?utf-8?B?NmlwR0hNTmIvWWxxM1FReFpscDVMUldzRDJkQ0FhMm9OOGROVUtoeVFwTmZl?=
 =?utf-8?B?cHBxbGNGNWROZWJCZG1jRFVXNThZc29nOE1jV00xYVVtUTZDQ1JKeEtNcGJl?=
 =?utf-8?B?bDRXZEpYVHBnQnI5SzZla0lHYXl6bUZzMzZSUGtuNXVBa2Z2QmM5V2huOW85?=
 =?utf-8?B?eFd1b2xZTkJ0UEhWa2szY2NWT0V4Q3BYWGg2RnRSRmdQODh5Z2FGNTgreWl4?=
 =?utf-8?B?NUo3cjRlWU1xbzZocUhHVmU2ZlBaMU44Q3A5THk1eUMwTDBoTjRVQVBoeTRv?=
 =?utf-8?B?VEFBQ2xVZVIrR0IwSmNuekJQbzhIYWpadElkcCtxelpGUEtZUlV5eHA3N0Nz?=
 =?utf-8?B?WmxYTHhhR2cwRjR5THp6YmtETktVQlhNQnQyQVIzMmlZc0txekhrSXV1RFFO?=
 =?utf-8?B?dW44TkpNZlgvZzdra0tTNW55cGdMRjB3dld6c2pqRThzcWFHSnBQSHRzcnNr?=
 =?utf-8?B?bTFQZmVzZE9tdjhIU0Foalg0MmZvYmIybnBVeTdFVVVsL1d5bHZSaGRrWkJL?=
 =?utf-8?B?dm84YTROTlJVMWhvaDR1NUQyWk95OWFCdGlDdEJMdDBEb0thcjV2bGFsRzNu?=
 =?utf-8?B?TWpKN1F2ZXBtYVJpYk5rS3ZiK0Z3MmNGaThyZm1uYWZSN2FDQkdPUVZtcEJk?=
 =?utf-8?B?eVNNb2Z3eVM2aFFYSG9Pd0VZUTlQMmNVVklFQjUyMTI5aDAvRzJTOEVTZ0Fv?=
 =?utf-8?B?N2dSMURzcS93WXdNZzJBY1ZTL3ZnTHVNc1VHNm9ocmR2TWJyeGg0RXZyZldB?=
 =?utf-8?B?WkZmY0J3bEFkTXdOT2xQbVIzQjFQbDZHTnlMZFh2RkhmU3J4RVlrcnVBNzM2?=
 =?utf-8?B?UzVtK2hZQTAzWmljOHk5YkIyQ2NGQ3lxUnlXeEExN0Uxb1kyMW0rVHp6S1VB?=
 =?utf-8?B?eWtkQlArYkxiQ2p0OE1sUmF3L2J6MTJTblozVXdoL1JLT2tmOWg4dkRNQk5N?=
 =?utf-8?B?OHErc083d0ZmcHcydDNhYTNIYjlMUzJXWG42YkFHdU1oR2lFMkNqYmt5Rzdh?=
 =?utf-8?B?VEZEYmRFKy82TXVtUFE2TWVVOG80NGEvSzlvbW5iVGpTVmI0N2ZYUXN4blVX?=
 =?utf-8?B?T3Y0a3pUM2RYY2dINFVjY0c4dmQyTDlxVmFRYlozZVBjRHhuVkFCQjlYKzlK?=
 =?utf-8?B?ZG12Ukc3YjFoMXdOMmt5ZjgzZEtyb0xGZWx1Vjk5bFJQLzdnSnV1ZmYzcHhk?=
 =?utf-8?B?VXpLa1dYQkdjSmZPMGx6TTNVRjM1cS8zNklES1dpYUtVR3FJWDRYUmxZYUZz?=
 =?utf-8?B?aFRRWFd6YjVHWjA1QzlVS1N6eEowai96YjIvOGFhOE5MdmFnV0RWdXhIQVhu?=
 =?utf-8?B?SUl0WmpCZnJVd1JWa05KWS9yRmI5dzBLSi9rclhVc0VSRmpYZW1sQW9OZDhi?=
 =?utf-8?Q?UeGhqPc7gyI03OXmAM3IYPGuwLkB32k7AJqovH6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4672cd-cb38-4282-3889-08d946e86b75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:57:10.0266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03vRrVSfPK2/CLv2GvRRF+ofvC/Q/GbAt/dX3NLDCL9tVsq7XoO1wDxAsDn1pwMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-14 11:19 a.m., Alex Deucher wrote:
> On Mon, Jul 12, 2021 at 10:56 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>> On 7/12/2021 9:00 PM, Luben Tuikov wrote:
>>> This fixes a bug which if we probe a non-existing
>>> I2C device, and the SMU returns 0xFF, from then on
>>> we can never communicate with the SMU, because the
>>> code before this patch reads and interprets 0xFF
>>> as a terminal error, and thus we never write 0
>>> into register 90 to clear the status (and
>>> subsequently send a new command to the SMU.)
>>>
>>> It is not an error that the SMU returns status
>>> 0xFF. This means that the SMU executed the last
>>> command successfully (execution status), but the
>>> command result is an error of some sort (execution
>>> result), depending on what the command was.
>>>
>>> When doing a status check of the SMU, before we
>>> send a new command, the only status which
>>> precludes us from sending a new command is 0--the
>>> SMU hasn't finished executing a previous command,
>>> and 0xFC--the SMU is busy.
>>>
>>> This bug was seen as the following line in the
>>> kernel log,
>>>
>>> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
>>>
>>> when subsequent SMU commands, not necessarily
>>> related to I2C, were sent to the SMU.
>>>
>>> This patch fixes this bug.
>>>
>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>> Cc: Evan Quan <evan.quan@amd.com>
>>> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196 +++++++++++++++++++------
>>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>>>   2 files changed, 152 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index c902fdf322c1be..775eb50a2e49a6 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -55,7 +55,7 @@
>>>
>>>   #undef __SMU_DUMMY_MAP
>>>   #define __SMU_DUMMY_MAP(type)       #type
>>> -static const char* __smu_message_names[] = {
>>> +static const char * const __smu_message_names[] = {
>>>       SMU_MESSAGE_TYPES
>>>   };
>>>
>>> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>>>       *arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>>>   }
>>>
>>> -int smu_cmn_wait_for_response(struct smu_context *smu)
>>> +/**
>>> + * __smu_cmn_poll_stat -- poll for a status from the SMU
>>> + * smu: a pointer to SMU context
>>> + *
>>> + * Returns the status of the SMU, which could be,
>>> + * 0, the SMU is busy with your previous command;
>>> + * 1,    execution status: success, execution result: success;
>>> + * 0xFF, execution status: success, execution result: failure;
>>> + * 0xFE, unknown command;
>>> + * 0xFD, valid command, but bad (command) prerequisites;
>>> + * 0xFC, the command was rejected as the SMU is busy;
>>> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
>>> + */
>> These are the response codes defined in header (0xFB is somehow missing)
>> // SMU Response Codes:
>> #define PPSMC_Result_OK                    0x1
>> #define PPSMC_Result_Failed                0xFF
>> #define PPSMC_Result_UnknownCmd            0xFE
>> #define PPSMC_Result_CmdRejectedPrereq     0xFD
>> #define PPSMC_Result_CmdRejectedBusy       0xFC
>>
>> It's better to use #defines for these, usually we follow a convention
>> like SMU_
> We could do a MAP_RESULT() macro like we do with the messages, etc. to
> make them per asic, but that may be overkill as I think these result
> codes have been the same across asics for a long time.

I think this would be best done in a subsequent/follow-up patch, since
it doesn't affect the behaviour of the system. I feel that such a change, while cosmetic,
would be somewhat involved and deserves its own patch and review, but for now,
we should get the system going.

I also think that ideally we'd want this to arrive from the SMU team perhaps,
so that we're impervious to such changes.

Regards,
Luben


>
> Alex
>
>> Ex:
>>         #define SMU_RESP_RESULT_OK 0x1
>>
>>
>>> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>>>   {
>>>       struct amdgpu_device *adev = smu->adev;
>>> -     uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
>>> +     int timeout = adev->usec_timeout * 20;
>>> +     u32 reg;
>>>
>>> -     for (i = 0; i < timeout; i++) {
>>> -             cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>> -             if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>> -                     return cur_value;
>>> +     for ( ; timeout > 0; timeout--) {
>>> +             reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>> +             if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>> +                     break;
>>>
>>>               udelay(1);
>>>       }
>>>
>>> -     /* timeout means wrong logic */
>>> -     if (i == timeout)
>>> -             return -ETIME;
>>> -
>>> -     return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>> +     return reg;
>>>   }
>>>
>>> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>> -                                  uint16_t msg, uint32_t param)
>>> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
>>> +                                   u32 reg_c2pmsg_90,
>> Instead of using reg/regname in function, it would be better to name it
>> as smu_cmn_resp/smu_resp or similar to make it clear that we are
>> decoding smu response.
>>
>>> +                                   int msg_index,
>>> +                                   u32 param,
>>> +                                   enum smu_message_type msg)
>>>   {
>>>       struct amdgpu_device *adev = smu->adev;
>>> -     int ret;
>>> +     const char *message = smu_get_message_name(smu, msg);
>>>
>>> -     ret = smu_cmn_wait_for_response(smu);
>>> -     if (ret != 0x1) {
>>> -             dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and "
>>> -                    "SMU may be not in the right state!\n", ret);
>>> -             if (ret != -ETIME)
>>> -                     ret = -EIO;
>>> -             return ret;
>>> +     switch (reg_c2pmsg_90) {
>>> +     case 0:
>>> +             dev_err_ratelimited(adev->dev,
>>> +                                 "SMU: I'm not done with your previous command!");
>>> +             break;
>>> +     case 1:
>>> +             /* The SMU executed the command. It completed with a
>>> +              * successful result.
>>> +              */
>>> +             break;
>>> +     case 0xFF:
>>> +             /* The SMU executed the command. It completed with a
>>> +              * unsuccessful result.
>>> +              */
>>> +             break;
>>> +     case 0xFE:
>>> +             dev_err_ratelimited(adev->dev,
>>> +                                 "SMU: unknown command: index:%d param:0x%08X message:%s",
>>> +                                 msg_index, param, message);
>>> +             break;
>>> +     case 0xFD:
>>> +             dev_err_ratelimited(adev->dev,
>>> +                                 "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
>>> +                                 msg_index, param, message);
>>> +             break;
>>> +     case 0xFC:
>>> +             dev_err_ratelimited(adev->dev,
>>> +                                 "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
>>> +                                 msg_index, param, message);
>>> +             break;
>>> +     case 0xFB:
>>> +             dev_err_ratelimited(adev->dev,
>>> +                                 "SMU: I'm debugging!");
>>> +             break;
>>> +     default:
>>> +             dev_err_ratelimited(adev->dev,
>>> +                                 "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
>>> +                                 reg_c2pmsg_90, msg_index, param, message);
>>> +             break;
>>> +     }
>>> +}
>>> +
>>> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
>> Same comment on naming - resp2errno?
>>> +{
>>> +     int res;
>>> +
>>> +     switch (reg_c2pmsg_90) {
>>> +     case 0:
>>> +             res = -ETIME;
>>> +             break;
>>> +     case 1:
>>> +             res = 0;
>>> +             break;
>>> +     case 0xFF:
>>> +             res = -EIO;
>>> +             break;
>>> +     case 0xFE:
>>> +             res = -EOPNOTSUPP;
>>> +             break;
>>> +     case 0xFD:
>>> +             res = -EIO;
>>> +             break;
>>> +     case 0xFC:
>>> +             res = -EBUSY;
>>> +             break;
>>> +     case 0xFB:
>>> +             res = -EIO;
>>> +             break;
>>> +     default:
>>> +             res = -EIO;
>>> +             break;
>>>       }
>>>
>>> +     return res;
>>> +}
>>> +
>>> +static void __smu_cmn_send_msg(struct smu_context *smu,
>>> +                            u16 msg,
>>> +                            u32 param)
>>> +{
>>> +     struct amdgpu_device *adev = smu->adev;
>>> +
>>>       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
>>>       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
>>>       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
>>> +}
>>>
>>> -     return 0;
>>> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>> +                                  uint16_t msg_index,
>>> +                                  uint32_t param)
>>> +{
>>> +     u32 reg;
>>> +     int res;
>>> +
>>> +     if (smu->adev->in_pci_err_recovery)
>>> +             return 0;
>>> +
>>> +     mutex_lock(&smu->message_lock);
>>> +     reg = __smu_cmn_poll_stat(smu);
>>> +     if (reg == 0 || reg == 0xFC) {
>> The problem with 0xFC check is it could be the response of a previous
>> message. It could mean that FW was busy when the prev message was sent,
>> not now.
>>
>> There is a default case (value not in any of the predefined error
>> codes), that should be considered here also. That happens sometimes and
>> usually that means FW is in undefined state.
>>
>>
>>> +             res = __smu_cmn_reg2errno(smu, reg);
>>> +             goto Out;
>> Label naming style, lower case?.
>>
>>> +     }
>>> +     __smu_cmn_send_msg(smu, msg_index, param);
>>> +     res = 0;
>>> +Out:
>>> +     mutex_unlock(&smu->message_lock);
>>> +     return res;
>>> +}
>>> +
>>> +int smu_cmn_wait_for_response(struct smu_context *smu)
>>> +{
>>> +     u32 reg;
>>> +
>>> +     reg = __smu_cmn_poll_stat(smu);
>>> +     return __smu_cmn_reg2errno(smu, reg);
>>>   }
>>>
>>>   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>> @@ -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>>                                   uint32_t param,
>>>                                   uint32_t *read_arg)
>>>   {
>>> -     struct amdgpu_device *adev = smu->adev;
>>> -     int ret = 0, index = 0;
>>> +     int res, index;
>>> +     u32 reg;
>>>
>>>       if (smu->adev->in_pci_err_recovery)
>>>               return 0;
>>> @@ -136,31 +251,20 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>>               return index == -EACCES ? 0 : index;
>>>
>>>       mutex_lock(&smu->message_lock);
>>> -     ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
>>> -     if (ret)
>>> -             goto out;
>>> -
>>> -     ret = smu_cmn_wait_for_response(smu);
>>> -     if (ret != 0x1) {
>>> -             if (ret == -ETIME) {
>>> -                     dev_err(adev->dev, "message: %15s (%d) \tparam: 0x%08x is timeout (no response)\n",
>>> -                             smu_get_message_name(smu, msg), index, param);
>>> -             } else {
>>> -                     dev_err(adev->dev, "failed send message: %15s (%d) \tparam: 0x%08x response %#x\n",
>>> -                             smu_get_message_name(smu, msg), index, param,
>>> -                             ret);
>>> -                     ret = -EIO;
>>> -             }
>>> -             goto out;
>>> +     reg = __smu_cmn_poll_stat(smu);
>>> +     if (reg == 0 || reg == 0xFC) {
>> Same comments as for without_waiting case.
>>
>>> +             res = __smu_cmn_reg2errno(smu, reg);
>>> +             __smu_cmn_reg_print_error(smu, reg, index, param, msg);
>> This precheck fail print is missing in without_waiting message.
>>
>>> +             goto Out; >     }
>>> -
>>> +     __smu_cmn_send_msg(smu, (uint16_t) index, param);
>>> +     reg = __smu_cmn_poll_stat(smu);
>>> +     res = __smu_cmn_reg2errno(smu, reg);
>> Using smu_cmn_wait_for_response instead of these two makes the intent
>> clearer - that we are waiting for the response.
>>
>> We need a print here as well if the message has failed.
>>
>> Thanks,
>> Lijo
>>
>>>       if (read_arg)
>>>               smu_cmn_read_arg(smu, read_arg);
>>> -
>>> -     ret = 0; /* 0 as driver return value */
>>> -out:
>>> +Out:
>>>       mutex_unlock(&smu->message_lock);
>>> -     return ret;
>>> +     return res;
>>>   }
>>>
>>>   int smu_cmn_send_smc_msg(struct smu_context *smu,
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> index 9add5f16ff562a..16993daa2ae042 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> @@ -27,7 +27,8 @@
>>>
>>>   #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
>>>   int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>>> -                                  uint16_t msg, uint32_t param);
>>> +                                  uint16_t msg_index,
>>> +                                  uint32_t param);
>>>   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>>                                   enum smu_message_type msg,
>>>                                   uint32_t param,
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7C63c12227eaee4417d06c08d946dad4be%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637618727955855924%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Au4k6zam4oVtRNl2JA%2BNEQTGjiOLxZULDKQnYDQg9ho%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
