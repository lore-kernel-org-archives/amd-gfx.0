Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6EEC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 17:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF9861249
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 17:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF9861249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818DB898F0;
	Tue, 13 Jul 2021 17:18:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C24C8985A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 17:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aamctOFmP6RWTCHvWeESXM4bYULwScpm/rDxxs77Er4AToaascV60okMf0KQTw6n6HLNCT70HFdttHF/2Ktly2me9MsHvo7rtlD0kWcORTyfO9+B16svyMB5YQrLj0EQdu3SaQUw0xi6SU9JnevlPaXLj1ydUp8/ET7ae84bcHYfKSJiVvp8zl0InVSaVBFwZ5cbnPRcNDnPwLFdh/ILkvaUQzta0brBySUdHe/9/A/KG12bmWK8bP8YSvHMFpJ5EcDY3cAXof0Wf43W3Qf7ye5L88nbCTGUGzpnKxxjvULprR1qEg0xTZ3u3whCrWiGU0q0ErfjGpjQzYaf8Wo8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElZE03V3CIEGCqNgw/ybGSZouO0BxRkbgFuKxFJbDWs=;
 b=exqde9vRfHhMSrdYnwywktzuwemk2bUmwRU8ANpqfTl7VcNRkosqDg4Wr1IvceNxAudCikJqBjbbI7btR1M61BLUIrFALkG9qsS91S80jdLZXozIhwOF9wXC20usN7KLVdmhz0F+pkVMi63Qcg3HlA/nbygOzbs9zXr4JhCjAUv/bdk52OB5QlLIUDqzM83aZchXk8SHKDBgjN+lcY/EQRBIpf3rfQN3uKiruahIGi02DAKnPSvG8gjNXkG4c+inTwd2c5oXrPGxjQ3nyvuX/siobEV7InwHlEB/7Zdtxl/Tb2Dy0HacUobq0sbIfJfrkAXUjTEaUGCMdBYN8BfM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElZE03V3CIEGCqNgw/ybGSZouO0BxRkbgFuKxFJbDWs=;
 b=CaFPY/WAdEGhM6b05iMajVcARFC5a0uFmKqccbFb+Dk9bX7rgWcsNtx9xmqtKC/3R6BvnCQUs4hY7lA9981mchH0gsM3zf5Fii7zfGrdLQumW9gcjYck95iQVJja1mu4sYYxahJqTnQC0sIh/fi/hlLf7N3eG68S+CSuBXfdnhM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 17:18:40 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::50f2:699c:121d:f257%4]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 17:18:40 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210712153051.4029-1-luben.tuikov@amd.com>
 <9317e662-e6af-da2f-7451-df0e1a1da1d4@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <2aaef980-0dc3-e9ac-0344-f322d82868bf@amd.com>
Date: Tue, 13 Jul 2021 13:18:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <9317e662-e6af-da2f-7451-df0e1a1da1d4@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 17:18:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c1acbb-e869-4bc4-fd96-08d946224208
X-MS-TrafficTypeDiagnostic: DM5PR12MB1866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18668AE1239E3AC5C4E5BD0599149@DM5PR12MB1866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIZW8LafKBsK7/RFjwiZ4zJroamB3VXkD25K6hXvt857IZgF9mKezRqIMZnH638HaKAG/GEHRW+eNxa3DKzXfDS9AnJzXmg5TeLiGNe/7CBBQL15/cieTWDp/WjkInnhGOA08EIdb7v0alLsFlkRtFuowa8bZYOpHZPNJ6QifEf6mtR9DICMXkyGYFnlNslAv8K6pyC3uBzHIUt5myPFdS5WmSFYRmlYEevA3/qdl83vjpr8Li0OgKF8gC15VzTFTmXbh4QRPThwDGY8wSHDSxV+Z4ig60YwHcMhR50aul6XE/oYjdT0h4eX+tNkszziLrXVHFevj83DBtOPSCW9Z153uLMHlfwq2Gjm2GkIRRaVR1zplqPcQqlw6WiJ4EnGrGqFPFQqpwqgCulA/ANFBN2ZP+6dilySZ8xS5pqJ8Je2tRvrWG0i+k65NXlDLFaYfKfG9YNNTlRtEb22z2vWVl4uglR1fJaFKtHW2nYeK/dQj7gBfEamgBP5xAd9fmjdungcjDMZI4wOTOH7RbpsoK/R+/yoLSyBtNlAtYuPrWhHUxmcGMw9Uw4SO2GpqbVlP36DtVrbQ+rFp+ACXIuRaPpnWOrhn6WsM1UyR2J9QF4INazg09dDvxyNcsACAs+r3b07e8deW0BQojqNbbdFzj6CLhU3l042/+fBW/CnqkMnk9HVJVo7/P5FDmZNnx7IudRpIyY6GgnkgNHFgbfeBqbB8kYKLrnAlmlq95z/KN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(53546011)(6506007)(26005)(31696002)(186003)(55236004)(86362001)(2906002)(478600001)(6512007)(6486002)(44832011)(956004)(2616005)(31686004)(36756003)(66476007)(66946007)(66556008)(5660300002)(4326008)(8936002)(30864003)(54906003)(8676002)(316002)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmF3U1pvZDVmS3oxVGZXYW92ZTVuV1ZSQjlFL0lRVlVuaGtUQUdubTR0aVIv?=
 =?utf-8?B?RGRPRVlaMjV0V29nTDFBOWx5UnRWUzEzS0dQUnB2YVo2bExWVkVZTlNvSHkx?=
 =?utf-8?B?R1d0dm05bEZOSGdRTEUrUExOR3pWd05oOXRtRS9SdmNKUWdRLzVoQVNDb2lB?=
 =?utf-8?B?Wnptb08yOVY1MFdiZEcxRU9qaVNnWUE0WmlTY3d2RjF0SXR5V3hCVXZ2WHow?=
 =?utf-8?B?NVYvbkdDTTZCcm9rM3o1ZUVsUC9zTTZad0g3RVhVUFNnOG14N0dqTFl5VlAr?=
 =?utf-8?B?UTMwa1FEQ0xJc3F1ZVJLekx6ODVQNndGYTgzZ3BKZkhWa2xhRU9lQ0l1OTdl?=
 =?utf-8?B?TlRCUi9Sb1pnV09kL3U3bkZOWTJxTXBtT092b1plQkRORHNPN3BkNWlVdjVN?=
 =?utf-8?B?eWV1VGQ5TzczVTI3NURKL0RlK0s1enkwRk5oU3hCazFqRng4VUVrcUdPMjd5?=
 =?utf-8?B?ZUtLOGxkdlh2QkRla0FSTGVONENjZEtxSnRWSUY4MGx5TjkxS3NwYUM3eDJJ?=
 =?utf-8?B?djh2N2NNRmJuNGNWQWJhejFwWFdpOGRBT3ZKWURuU3BwdmoyOW5LNWJBYW9H?=
 =?utf-8?B?eHF0dE9RVVc4NU9nOEN3aUlHTEdUT2taWUV0QkVjckszTUNJSC9zOXlzZCsw?=
 =?utf-8?B?bTNHZFFGMzhvRXFtaVZpaFY1VWl2akpkWVlPb1N0bm9XVlNEcmw2dUdRTXdV?=
 =?utf-8?B?N1VCSHYrdTA3bHI3dkkzcUxOYlhuZXV0T3hSQThET3QvdUFRdmpCN21KWmR6?=
 =?utf-8?B?RVBlU0NCY24xbGdCa3hOQlU0bjZTTlc5cVpCUnhWa0xhRzdvNktCQTJKdFVJ?=
 =?utf-8?B?bXdtZHl0ZFF2RmEyeHVUeGxpQnZWKzEzcHBGd0RvZmRFU2dIZkN6d0t5NjJy?=
 =?utf-8?B?cUxyK053enl1K25MdGhSdVh1UThkWHdYWTIxRjdSK054Q0R1amRrUzVVL1c1?=
 =?utf-8?B?TVFlM3BRN2RFdDUxaDVtUXFvT1RlRWFlZURxTHdUZlBTTDFmUkJCN2o0RjJk?=
 =?utf-8?B?QndwbEFBc0w2WG9tZlpMU1UyckIrMzFOelR4Nks0QTNXSUR3Wm5XaWZLdXJU?=
 =?utf-8?B?V2xsTjBxeDdYUFdDeXgwVW9UcWNVVDhyeUo0RnpnbFNBL2VDaXlxcnZqNlJX?=
 =?utf-8?B?RFNWNlgwYktZTlcrVFVMTmVXTCt4WEpidGVTTzMxa1hRNm1BRmZneUpzaHh4?=
 =?utf-8?B?RWtXQUczNXJKRzlOaGwxRVVYRHVCbDBiQzFlbVZuanlKQUdpeHg3bnR3SkFE?=
 =?utf-8?B?TFUvTVEyNXBVQU9oMDBIbFZMQyt5c09rWHdvTU40ZHBQNW5xWEF0SHpmci8v?=
 =?utf-8?B?YUdMRUpBWllZS2swWEVoWkZOQUwydTdiWUJ3Sys0U2I0YWhxdzdUYVJUUndZ?=
 =?utf-8?B?NWQybk13dE0zQWhMRmphOThvU1FRNGZDQU4yTzhxTWwzWDZKd3MwY2Nld0I1?=
 =?utf-8?B?QjZaaG9KZUV1ME9INDE0d0VTVy9CYTFiaDZCTmJ5cy9aaHo3MExaOTdmQjFO?=
 =?utf-8?B?K2FaOFQwVWlwUFo0SU5wbTFWUVZWR0Z4VUVtOURZc3F0MEJpSm5VSXF6SjZz?=
 =?utf-8?B?UFMvRVNDZzcwQTRUbFZDNDZYUE5ZaXVxcUFXUVdmSzJmSEo2WUp1WUFFRXds?=
 =?utf-8?B?cFBJVXFUU0FTQ09vMHRCNDFOYnp5UFRWckZmNWlzVzA2VnRyRSsxQktUU3pm?=
 =?utf-8?B?dWMwL1pFUStteXVCMTRMa3dvRkFIVGw5eUMvV1pBdThTeUZhMjl5eUdjZ1Fw?=
 =?utf-8?Q?/TTo01X132xptoZmFb3/zlIjiNpMRzVdJcjqbiY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c1acbb-e869-4bc4-fd96-08d946224208
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 17:18:40.2462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5JlgpF2Byf8opgHwwQzNBbVYWsuPK2SYgefqskSvn0ovr2tV1tRlQ+DO49Dd4yM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
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
 aaron.baluja@amd.com, "Alimucaj, Andi" <Anduil.Alimucaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-12 10:56 p.m., Lazar, Lijo wrote:
>
> On 7/12/2021 9:00 PM, Luben Tuikov wrote:
>> This fixes a bug which if we probe a non-existing
>> I2C device, and the SMU returns 0xFF, from then on
>> we can never communicate with the SMU, because the
>> code before this patch reads and interprets 0xFF
>> as a terminal error, and thus we never write 0
>> into register 90 to clear the status (and
>> subsequently send a new command to the SMU.)
>>
>> It is not an error that the SMU returns status
>> 0xFF. This means that the SMU executed the last
>> command successfully (execution status), but the
>> command result is an error of some sort (execution
>> result), depending on what the command was.
>>
>> When doing a status check of the SMU, before we
>> send a new command, the only status which
>> precludes us from sending a new command is 0--the
>> SMU hasn't finished executing a previous command,
>> and 0xFC--the SMU is busy.
>>
>> This bug was seen as the following line in the
>> kernel log,
>>
>> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
>>
>> when subsequent SMU commands, not necessarily
>> related to I2C, were sent to the SMU.
>>
>> This patch fixes this bug.
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Evan Quan <evan.quan@amd.com>
>> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196 +++++++++++++++++++------
>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>>   2 files changed, 152 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index c902fdf322c1be..775eb50a2e49a6 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -55,7 +55,7 @@
>>   
>>   #undef __SMU_DUMMY_MAP
>>   #define __SMU_DUMMY_MAP(type)	#type
>> -static const char* __smu_message_names[] = {
>> +static const char * const __smu_message_names[] = {
>>   	SMU_MESSAGE_TYPES
>>   };
>>   
>> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>>   	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>>   }
>>   
>> -int smu_cmn_wait_for_response(struct smu_context *smu)
>> +/**
>> + * __smu_cmn_poll_stat -- poll for a status from the SMU
>> + * smu: a pointer to SMU context
>> + *
>> + * Returns the status of the SMU, which could be,
>> + * 0, the SMU is busy with your previous command;
>> + * 1,    execution status: success, execution result: success;
>> + * 0xFF, execution status: success, execution result: failure;
>> + * 0xFE, unknown command;
>> + * 0xFD, valid command, but bad (command) prerequisites;
>> + * 0xFC, the command was rejected as the SMU is busy;
>> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
>> + */
> These are the response codes defined in header (0xFB is somehow missing)
> // SMU Response Codes:
> #define PPSMC_Result_OK                    0x1
> #define PPSMC_Result_Failed                0xFF
> #define PPSMC_Result_UnknownCmd            0xFE
> #define PPSMC_Result_CmdRejectedPrereq     0xFD
> #define PPSMC_Result_CmdRejectedBusy       0xFC
>
> It's better to use #defines for these, usually we follow a convention 
> like SMU_
>
> Ex:
> 	#define SMU_RESP_RESULT_OK 0x1

I did not define these as macros (they're called "macros" not "defines"), _on_purpose_,
because they are already defined by the SMU, but we're not using header files which define them,
and for this reason I don't want to define them YET AGAIN. So, no, no macros for these constants,
unless we include a header file which is also used by the SMU team.

Furthermore, I can see that these constants are defined for each ASIC, yet we're a single
driver for all ASICs and I don't see how this can be reconciled, unless the SMU team moves
to a single header file defining those for all ASICs.

Thus, no macros.

> 	
>
>> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>>   {
>>   	struct amdgpu_device *adev = smu->adev;
>> -	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
>> +	int timeout = adev->usec_timeout * 20;
>> +	u32 reg;
>>   
>> -	for (i = 0; i < timeout; i++) {
>> -		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>> -		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>> -			return cur_value;
>> +	for ( ; timeout > 0; timeout--) {
>> +		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>> +		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>> +			break;
>>   
>>   		udelay(1);
>>   	}
>>   
>> -	/* timeout means wrong logic */
>> -	if (i == timeout)
>> -		return -ETIME;
>> -
>> -	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>> +	return reg;
>>   }
>>   
>> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>> -				     uint16_t msg, uint32_t param)
>> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
>> +				      u32 reg_c2pmsg_90,
> Instead of using reg/regname in function, it would be better to name it 
> as smu_cmn_resp/smu_resp or similar to make it clear that we are 
> decoding smu response.

No. And here's the reason: I had about two hour meeting with the leads of the SMU team,
and it was clear that there is a distinction between a command execution status,
and command execution result. The former describes whether the SMU executed the command
or not, and the latter describes the result of the action executed by the command.

Unfortunately, it is easy to confuse those as was done in buggy commit fcb1fe9c9e0031, prior
to which it worked fine (!).

So, I don't want to give a stamp to register 90 as a "response". We may change this to be
"status" instead and response to be returned in the argument register, unless the function
returns an argument in which case 90 will be 0, or something like that--we've not fleshed it out yet.

In any case, I don't want to label 90 as "response" and this is why the name of this function
says EXACTLY what it is doing and NO MORE: decode the code in register 90, that's it.

>
>> +				      int msg_index,
>> +				      u32 param,
>> +				      enum smu_message_type msg)
>>   {
>>   	struct amdgpu_device *adev = smu->adev;
>> -	int ret;
>> +	const char *message = smu_get_message_name(smu, msg);
>>   
>> -	ret = smu_cmn_wait_for_response(smu);
>> -	if (ret != 0x1) {
>> -		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and "
>> -		       "SMU may be not in the right state!\n", ret);
>> -		if (ret != -ETIME)
>> -			ret = -EIO;
>> -		return ret;
>> +	switch (reg_c2pmsg_90) {
>> +	case 0:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: I'm not done with your previous command!");
>> +		break;
>> +	case 1:
>> +		/* The SMU executed the command. It completed with a
>> +		 * successful result.
>> +		 */
>> +		break;
>> +	case 0xFF:
>> +		/* The SMU executed the command. It completed with a
>> +		 * unsuccessful result.
>> +		 */
>> +		break;
>> +	case 0xFE:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: unknown command: index:%d param:0x%08X message:%s",
>> +				    msg_index, param, message);
>> +		break;
>> +	case 0xFD:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
>> +				    msg_index, param, message);
>> +		break;
>> +	case 0xFC:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
>> +				    msg_index, param, message);
>> +		break;
>> +	case 0xFB:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: I'm debugging!");
>> +		break;
>> +	default:
>> +		dev_err_ratelimited(adev->dev,
>> +				    "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
>> +				    reg_c2pmsg_90, msg_index, param, message);
>> +		break;
>> +	}
>> +}
>> +
>> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
> Same comment on naming - resp2errno?

Nope! See above.
No renaming 90 to response, no overloading meaning. See my comment above.


>> +{
>> +	int res;
>> +
>> +	switch (reg_c2pmsg_90) {
>> +	case 0:
>> +		res = -ETIME;
>> +		break;
>> +	case 1:
>> +		res = 0;
>> +		break;
>> +	case 0xFF:
>> +		res = -EIO;
>> +		break;
>> +	case 0xFE:
>> +		res = -EOPNOTSUPP;
>> +		break;
>> +	case 0xFD:
>> +		res = -EIO;
>> +		break;
>> +	case 0xFC:
>> +		res = -EBUSY;
>> +		break;
>> +	case 0xFB:
>> +		res = -EIO;
>> +		break;
>> +	default:
>> +		res = -EIO;
>> +		break;
>>   	}
>>   
>> +	return res;
>> +}
>> +
>> +static void __smu_cmn_send_msg(struct smu_context *smu,
>> +			       u16 msg,
>> +			       u32 param)
>> +{
>> +	struct amdgpu_device *adev = smu->adev;
>> +
>>   	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
>>   	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
>>   	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
>> +}
>>   
>> -	return 0;
>> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>> +				     uint16_t msg_index,
>> +				     uint32_t param)
>> +{
>> +	u32 reg;
>> +	int res;
>> +
>> +	if (smu->adev->in_pci_err_recovery)
>> +		return 0;
>> +
>> +	mutex_lock(&smu->message_lock);
>> +	reg = __smu_cmn_poll_stat(smu);
>> +	if (reg == 0 || reg == 0xFC) {
> The problem with 0xFC check is it could be the response of a previous 
> message. It could mean that FW was busy when the prev message was sent, 
> not now.

It was explained to me by the SMU lead, that these codes mean that the SMU FW is busy NOW.

>
> There is a default case (value not in any of the predefined error 
> codes), that should be considered here also. That happens sometimes and 
> usually that means FW is in undefined state.

Is this "default value" used to be returned (exposed) to the driver by the SMU FW?
Will the driver actually see this value in 90 returned by the FW?
What is this value?

>
>
>> +		res = __smu_cmn_reg2errno(smu, reg);
>> +		goto Out;
> Label naming style, lower case?.

Absolutely NOT!
It's a paragraph label, not a variable.

>
>> +	}
>> +	__smu_cmn_send_msg(smu, msg_index, param);
>> +	res = 0;
>> +Out:
>> +	mutex_unlock(&smu->message_lock);
>> +	return res;
>> +}
>> +
>> +int smu_cmn_wait_for_response(struct smu_context *smu)
>> +{
>> +	u32 reg;
>> +
>> +	reg = __smu_cmn_poll_stat(smu);
>> +	return __smu_cmn_reg2errno(smu, reg);
>>   }
>>   
>>   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>> @@ -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>   				    uint32_t param,
>>   				    uint32_t *read_arg)
>>   {
>> -	struct amdgpu_device *adev = smu->adev;
>> -	int ret = 0, index = 0;
>> +	int res, index;
>> +	u32 reg;
>>   
>>   	if (smu->adev->in_pci_err_recovery)
>>   		return 0;
>> @@ -136,31 +251,20 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>   		return index == -EACCES ? 0 : index;
>>   
>>   	mutex_lock(&smu->message_lock);
>> -	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
>> -	if (ret)
>> -		goto out;
>> -
>> -	ret = smu_cmn_wait_for_response(smu);
>> -	if (ret != 0x1) {
>> -		if (ret == -ETIME) {
>> -			dev_err(adev->dev, "message: %15s (%d) \tparam: 0x%08x is timeout (no response)\n",
>> -				smu_get_message_name(smu, msg), index, param);
>> -		} else {
>> -			dev_err(adev->dev, "failed send message: %15s (%d) \tparam: 0x%08x response %#x\n",
>> -				smu_get_message_name(smu, msg), index, param,
>> -				ret);
>> -			ret = -EIO;
>> -		}
>> -		goto out;
>> +	reg = __smu_cmn_poll_stat(smu);
>> +	if (reg == 0 || reg == 0xFC) {
> Same comments as for without_waiting case.

Same response.

>
>> +		res = __smu_cmn_reg2errno(smu, reg);
>> +		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> This precheck fail print is missing in without_waiting message.

And that is ON PURPOSE, if you study how "without_waiting" is used.
It's ON PURPOSE.

>
>> +		goto Out; >   	}
>> -
>> +	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>> +	reg = __smu_cmn_poll_stat(smu);
>> +	res = __smu_cmn_reg2errno(smu, reg);
> Using smu_cmn_wait_for_response instead of these two makes the intent 
> clearer - that we are waiting for the response.
>
> We need a print here as well if the message has failed.

Nope--that'll be the naive thing to do. You don't want a print here. It was done this way on purpose.
You're merely sending something to the SMU, maybe a reset.....................
You want to know if it was sent. If it is not a reset, the SMU is allowed to take it's time to complete it,
and also the same for a reset. So what if the SMU takes one 1us over YOUR timeout period? But
if the SMU hung, you'll see this on the NEXT command submission to the SMU.

Regards,
Luben

>
> Thanks,
> Lijo
>
>>   	if (read_arg)
>>   		smu_cmn_read_arg(smu, read_arg);
>> -
>> -	ret = 0; /* 0 as driver return value */
>> -out:
>> +Out:
>>   	mutex_unlock(&smu->message_lock);
>> -	return ret;
>> +	return res;
>>   }
>>   
>>   int smu_cmn_send_smc_msg(struct smu_context *smu,
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> index 9add5f16ff562a..16993daa2ae042 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> @@ -27,7 +27,8 @@
>>   
>>   #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
>>   int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>> -				     uint16_t msg, uint32_t param);
>> +				     uint16_t msg_index,
>> +				     uint32_t param);
>>   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>   				    enum smu_message_type msg,
>>   				    uint32_t param,
>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
