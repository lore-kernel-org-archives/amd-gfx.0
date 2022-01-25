Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF11EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 15:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0F310E3AA;
	Tue, 25 Jan 2022 15:33:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE4F10E3AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 15:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKrEuOAcAFESSe8CFcv008MSgf3jPtMYx/6zHtkfRVdfCpS6dheKm0Ez79wXRs2fTLZ5N6RJeJdqLZ1b/EUZWOSAHZzIVomhNJusaoEtYz27kJxaWj51OF/WwjGaYEjOTneYbI1eCTP5EUGHyRX/SM9HfYUQQ+fggx57qjlAwMfcymfeI+Ybm2l21XCtNaaC1Cok3GLQSEgEMLQonLzL306Jfv1YcgmWZ1yi37hPO1mc+QazNrsA/ErTmmb+TPEB4G2c6BscFEplZeAFK/fNaLTGFuAHwk83uQnfDG1dqLZ+WizuUsBmvmPdNYeR9GvXVVmhsuHDI4i6iBUpXmSnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21k9NTZxtj7EewCsh1Wvu5HHIIsZaMsb3m0t06fVwEI=;
 b=cB/GJe3Tz2J+3OrlHaVvcB0Ec1IqSYMjMEPbTmQVrgJSf+mTCtTJoChPyBpZiXlxH0ikPPRj7BtLwahrmck6qu7+KsmluolKZsWwv6MUQg3OS2GoDzc/b0gX9hR4lKDjy4ZkY25N9wvKZPkZrOa3zA4zgWITKMW/bPvXxMziFxuadW4a7kYtWsWUdr2zOqMeNeLqnWXV0+EiJCxuAtAi4u7k252uGwl1nMiCwq7Bpg6Dkiyro25pkMgxuHJHXkoPJfnGY76ez4defpSEJju6JlgQCeL4BThd5ruC3lQGBCDQlJL/PSY8kJD9igh8BanWNzKyAGNYXTUNx5HuwdrIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21k9NTZxtj7EewCsh1Wvu5HHIIsZaMsb3m0t06fVwEI=;
 b=WpmZjhhmefS5P8iDVAteA1k0/wSjRZyMRpa4mi69+H+m7iZDI1xD+cG44xLUlWn52UfdWbQLoirWR076EsDYPTHu8GY54C2BgNmXYazDb0LY2HIGJXC9/5QdRwe6eahaPezi/+pCCwICV2N4uO8qZbQ7Iry/kKp8Fg6I1ll75uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 15:33:51 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 15:33:50 +0000
Message-ID: <fcacd0b9-947e-db05-38a9-4e31cd1c8586@amd.com>
Date: Tue, 25 Jan 2022 10:33:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu/display: use msleep rather than udelay for
 long delays
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120180429.616236-1-alexander.deucher@amd.com>
 <20220120180429.616236-2-alexander.deucher@amd.com>
 <36b699d7-b7c4-21cf-93ee-47f4f33190df@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <36b699d7-b7c4-21cf-93ee-47f4f33190df@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::23) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95287d6f-4a02-4443-3b1c-08d9e01815de
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0121FD212FCDE2D663CE74E68C5F9@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7swQwIOX3/Bh15oh4Y2ShBNuK+sXwmBAyyRlq07XY7xkYo27xMhdVPtJMNr45ccEnBA7GqMN/IFeYMgfdWWf8qlADR3TGpGIqvRz1Bn2+JHY/Y5g4SYb60Q5KKGrAqT9eKRewLEGT1ghpkX1xPwvcOMtGIAxP6LjvZGxRQkZBfJSHZBJAm1IhyuHtue15aUrjkHtOeuZihJpwN9u172DSD5oEBON0qgzMHVi5o3GrAl7rWPPfZcYLYM0SKlrCWyxAw0IHyV66shp/MQImWvd75UtMpFzELKUF2VH4/XVmxHPET2VPnbvTGq73fQwRo2QVZLLhhLnWuFt73xCM5XnM4202GIsgxHfa/4D1A0ZuYgp7LyvXfUJYLNmOykG7LV4YXJjDsJ/t5gtjaE3SfRDVCquawFudOdUYFULwq5sqgwo//p3yIq/pr7Hu1sBpljgY4j5I9uQAeeSoF3kuJTnHNSgySflRb8nYbaW+FJBMy5R9cLW5Dfsiqo/nu6MEv3ou8v+HbtePr2YOtcIcZRx/x1EWd+DtqkpyqVIAGPqMBX4Jp12u34tCHhQtyKgDmbusDZErrRNV8kYTI2bCOxEPB1AsYEAJ8lct2l2PsGX+fTeVZ1llk00d2RZvpTwg/MsNf+T7+t7NQAfpKEgbIec8NsIv+pYRrZjWHh7ztv1ykUZan25pI/2VWcrtS9SNJbvpNckZLWcShiYlxfNJ27tbb+758dGla/YvE5Ou6uUNYU+br66bNULc3EhjxhLYQs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(31686004)(6506007)(316002)(66476007)(86362001)(2616005)(66556008)(110136005)(36756003)(83380400001)(38100700002)(66946007)(53546011)(6512007)(5660300002)(44832011)(26005)(6666004)(6486002)(8676002)(2906002)(508600001)(8936002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVMdG9FUjM5ZWo1UmZzUFZRZ2pKSTkvSW9sYytqQmlxbmpJRVBaTGtreDZF?=
 =?utf-8?B?OFBWUGZZL3F3M1VQaDBUQm9EUEt0dDJ0bC9jejRFSyt5dW95YVpXZWFVdmcx?=
 =?utf-8?B?dFY5TEYxeWtmaFk4djYvYUpxWGRWZHBnWUprTEZaTDQzb21PdUgyeDB3M0Ja?=
 =?utf-8?B?UGJiT1BWeTZMZlQ5RDNHdUZ0aVpLVXVOUURDemdTWGJvU3htRVQ3TmVFZzk5?=
 =?utf-8?B?WmdCQmNNK3NndFVUeE1TVkhoM3lRZVpSM0phTCtvQ1JKZ2dMKzg1d3RTTTBj?=
 =?utf-8?B?MVpWRk9ZYnJZQ1R3YTBqaXppZ0d1Q2JkbUIzbTYzbU1vUFVFTVpyTHlDL2xw?=
 =?utf-8?B?NE5tbmk4c0lFR3dEbHkzc2wrRFlBMGlWU24yR1BxTXMxSFRuR2ozbWJ0a1lz?=
 =?utf-8?B?SWdjQ1o5T2hJWGhuSnVZWjFBSWNSTWJONGdGbUNQK2orTEJ3UVJqYlBLMkh0?=
 =?utf-8?B?eFZTVjgrNmh5a3lpTE4zYUlrUExpWWRWVjY1eVNLNEdxWDRvUDhTdml2SFY4?=
 =?utf-8?B?VVNWS1BNVm9QNFRva2dwNnBTSWhzaHIvRzFjblUvcVpkS2lZdzIyaFhUeGl3?=
 =?utf-8?B?V1lEWFMwdEovYUtsSGUyWkphUVo1RTY5M0dIeVpPajhDTmZuWWkvOU1KL0FF?=
 =?utf-8?B?TEFEZW5GbGtTVHFKd2RnN0VYeTZsR1BJbktWVjNSWVpIK1pFSWdkbTF1UGZu?=
 =?utf-8?B?L3VpSWk0RzlpQTZNeCtYeVprSzdiT0dqNUtETloxODNjN2xYSFY4Q1V2ZXlr?=
 =?utf-8?B?TElEdGVpeHVodGJmS0JHQTBrcmRaT2lUNFFjYVN0REhsSE5nSThONkU0UzFt?=
 =?utf-8?B?L2tpWVFhaWxHbzVKc1RxdTN0THJsNVZySHZjdDBEL1NOWlZkdGd5M3hBWnFm?=
 =?utf-8?B?MG0rYlp1QU1zRmdLb1YxaVhUenZWV2ZXZ3ROMEMyekEyVUtkNzUrSVZsTmRv?=
 =?utf-8?B?VGJTZGJ0bkFiV0RvVWxMWWpmSVpMdlAxQ3doZUJxQVhVQkpMRURPWmQzRDB4?=
 =?utf-8?B?ZEdnZW1RT1NTNzN5VXJHb1JaSW5ONnliOXp4b2xacFlQNjhGK3RRSElmajJL?=
 =?utf-8?B?WVpHMGYxQytsQzRYRlFIZFUvNHVUV212a2tFdmtuRTg0TlJCS3ZFbUhxRHd6?=
 =?utf-8?B?cnZnTmF0SjFSQzNPSWpENEpyS0xlSjBaZTlPcEFxUGxmUTY1MVI0Z3BrdlM5?=
 =?utf-8?B?Qy9LOU5OYk9Kajg3eWFHSzd0aDlVSG1Vb09wYW9BWTFLbHNVdEdVK1RXMyta?=
 =?utf-8?B?OHlTUVIwZ2l4WmI0N2FSbVROZnZlYVpBUFNtdFI0RTdnVEF5VGl5VFRjS0lO?=
 =?utf-8?B?K3EySlZxMUU3d2ZESW8rKzJjVUt3RnpoNnc5ckpkVm53VjJPK3ZzZ2RXMG56?=
 =?utf-8?B?YlNuWWFjSmxBWC9zVzhLb1Jta0pmME1ia2d2QS9ySmFRRlVlZjBBcElWdmQz?=
 =?utf-8?B?Z2tQUjFiSzlrbmpuWEwwbWtSMVZpTXJaK3duZzFCQzNZRzdlOFdvRENVaTAz?=
 =?utf-8?B?UklhZXZzTzBTY3JyYTNCc3R0cmcyR1NwbHpvT3B4NTl3Ui9TUkMySnprcDdw?=
 =?utf-8?B?VnNudExiL2I4SGxRcFVnR0dlbUs4MWpSRVVvbkV1ZXQxNC92cHFhZytBMzV4?=
 =?utf-8?B?Q0JZQ3VVU2E0bEZqM1BINTh2YnQ0TVltak44dE1kTnNwb3E4TjFDQXoycmJv?=
 =?utf-8?B?bHdpZEtTQnNCWTdCTnlRK0FqcWU2aldzQ1RvOXJzNW13UkR0elBsZmxoVEFX?=
 =?utf-8?B?bU5NOVBJM01XM0Ivd25ERzRDejA2NmYrMTFPZElLaURDVWNjMWVGblJQYXcv?=
 =?utf-8?B?SDFVM0Ewd3hLeHpQYXdQUS8rY0Y4Tm9GOTlhOW5TSE5SaFhRSUdJNEZwMjVH?=
 =?utf-8?B?enFvQTZtbFZvQVovNllMYWplV2xVTHJxWjNwTFlHN0tvOGw4ODZ1RkRrYmx3?=
 =?utf-8?B?V2R1VC8xekRNeVMzdms4bCtaMVF4UXNHUElWbGpMQ01LMHpXNzRFQlVFWFFk?=
 =?utf-8?B?M2J4WVR4M04wNmtXWUF2bktsaldXRDNLdWFTS1pWcE1jMUNDNnVRK01FM1Z3?=
 =?utf-8?B?cWdFNEtwVDdSOVBrWmsvUFBSVGJQdmhGZVkza1Y5ZnJUMkxxZTdIMEoxL2VT?=
 =?utf-8?B?d0VYQ2UrTmNLdVpnMnhMdDduV0dOVmlkelRoUVM3Z2dMZk1VUGV5LytRLzBM?=
 =?utf-8?Q?gFgafDdsy/T3LxkdE9h/wLM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95287d6f-4a02-4443-3b1c-08d9e01815de
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:33:50.5201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XViraStPHopTfE8NgeGYmxr9Lq3mgiS7JnCcen5epSjR+2MUfE4uYK30g0WzH2CRMgWYG99nnI4MUx/2YmSXqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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



On 2022-01-25 06:32, Lazar, Lijo wrote:
> 
> 
> On 1/20/2022 11:34 PM, Alex Deucher wrote:
>> Some architectures (e.g., ARM) throw an compilation error if the
>> udelay is too long.  In general udelays of longer than 2000us are
>> not recommended on any architecture.  Switch to msleep in these
>> cases.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> index aa1c67c3c386..eb4432dca761 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> @@ -6941,7 +6941,7 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
>>               }
>>           }
>>           retries++;
>> -        udelay(5000);
>> +        msleep(5);
> 
> msleep is not recommended for sleeps < 20ms. The original code (modified in patch 1) seems to do such a check. As per kernel doc, if precision matters recommendation is to use usleep_range().
> 

If I remember right the sleep (non-polling) function can take (significantly) longer than the requested time, but never shorter. This should be fine in this case.

Harry

> Thanks,
> Lijo
> 
>>       }
>>         if (!result && retries == max_retries) {
>> @@ -6993,7 +6993,7 @@ bool dpcd_poll_for_allocation_change_trigger(struct dc_link *link)
>>               break;
>>           }
>>   -        udelay(5000);
>> +        msleep(5);
>>       }
>>         if (result == ACT_FAILED) {
>>

