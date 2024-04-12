Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A607BC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 13:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268B110F651;
	Fri, 12 Apr 2024 13:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MPj+H3cf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CDE10F651
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 13:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeQRmtcTB2Y1Jgi6jOaKe80EQgtPfTOt1634/LADiPLkiH5KsCg6ku2tlcEKQWWjvxFEwcGOBqDoYilV3JdVVcY0kQ2qJFxHjz6yZGUBToYISNZOKWsJt93vUsGAwnHr4Bmbu1Iqp+DuQCq4yCIlVxQInE7r35OO2G63neguszlSyF0z2VBe1ylLfGKv6ngj2jb5zL0whUYPNJgjTQjUF9d82YtCfE7Sxws8j6mX+5iUyDk8abScnFzntjaMWOhWW6e023Kp0ItA/ANKncdkgFiX6AwQNHLQsVQziWUFBRhLrZReR9yM6r3ppDnyIxXAoZz8KtJ5zoJtLIusHCdBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JslaD52jiBuRFp7mtLUXAG1Wbz105oc1OYFuO6GTjBU=;
 b=mr7XA7cGmOBs+GhQ/AI2bzuwsdjYjLYumGPSgMPv9eCjiwUr7OnISR+H0zqFV5ljaoe4Azc9zrLr+v29r/Bc26MsVGxM2WkxnP51v3lAJg1KM1kvD50cvoVPDpmK0hSFeGsKpmD0xjBo2FeQ/VHluEXNJNO87SPfuWS5HEnxlWM6biT7aNT0mfExiPZVtjZD4IKn2z3q+5Iyq+yQ1M9sRdyJPKA6szw4/g9iKz2vVJK2tn6lw6NBk1gLF4MPMESdwZB4rR7O6ZtWveBQCCwLgmQfa85b756b6YN1j7Z9ODNRx8T/eegR6nMFwAIweVKWLhyQa71ap0egvzmrcKvYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JslaD52jiBuRFp7mtLUXAG1Wbz105oc1OYFuO6GTjBU=;
 b=MPj+H3cfkTGB4yZKY1jxEXVWfRHDqL76QEubhw03rk/E/VP6E1Rz9RZDq+Ng59xlrvCR0ULlzy9Vd68mi3DnRoJaHzUNlYYgn9lQqdZCFyRXJOnLESqMSfADpBQq1KlDTwWiRYIb86SeeHjR/50aYY8NbKcV3TLRkhwYx+wmmc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 13:36:50 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 13:36:50 +0000
Message-ID: <0d1982c1-d635-4f19-bb7c-5219c2741d37@amd.com>
Date: Fri, 12 Apr 2024 09:36:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: fix USB-C flag update after
 enc10 feature init"
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240329225852.9648-1-alexander.deucher@amd.com>
 <CADnq5_O3y-zbBA__JHT6pJKd5L8CcF6KB0-GRJjGF=JG8ANMsA@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_O3y-zbBA__JHT6pJKd5L8CcF6KB0-GRJjGF=JG8ANMsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d7de52-5471-44dd-227e-08dc5af59b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Twe2rOHq6g55bHjIoziJ60L2LSq1aUJjUkPsOy+34wIYcUo7FYjURs/f3MgWXTwWwuH3+9lDq9oIAdKjNfvY5AK3AonxJXEs1j4mW2N+kQgWqY8l7BJ+rN9wNDecW87p1k7qZQXv7S9Qod2p8znEVmuet4JteFJ/ClCz8SdRF8XnxVuoG0zz2F18LZsMW3Vp9btQg/wlYfGCsf+1stAjA22Rhi5vUmGKXpX2gMtoFUcVqpptKVP92jlnQ08M9s+sdjgHFeV7rw8uxX3ocwu7CPHmXsOKTRhCAYNmYrZ6nvgD3oQ52TJ8YCrtOEKHfcd3hh9mikeZB5/dtd2MMkgCm70KWWWR+ISa0mkR/PXekMIEAsE7F1pJNiH6nvAp+Fel02K0+xyit4ptHMimBTAMz72BwlkrMEjiNS1HuJibCLLQmjnF8mOpUCA/O9cnA94t/l5s+EGBPvZGEMCci0z6s4JF+O0GsQ1BwSgzuvkUfIEXwjIOhRJbw8IMQ6iC8CaxbJgcBB2bBgTDRVmvKVs9qH/6+/ETxjcQ7DOzVL/My75ggRaM3JylcWOYg0vosmhmQCExZ9c7SflT/WWrJP6syAIAE2XjoDoi+Q853PHaDCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVdJbUtTbndQemFPdWdxeDN6eVBwT3lXNE1veko1aTRiQzdyMkRZenJ0ZXhV?=
 =?utf-8?B?OExpSis0bmZoaTlvRnBRY1IrTXpxVUFFcjBFVkxWa0lmZEl2R3lsUW5wL01K?=
 =?utf-8?B?ZGQ5M1h6YnNaU2lFV3VGRkZEL2kvY05NMHB5QzJsa0pjQ0NFNkdsWHQwZG10?=
 =?utf-8?B?SW1paUdOMkJwSUlqTkNiSDJZRWljdDBLZStacWhndW9nVlBjRnc1SW5TbUwy?=
 =?utf-8?B?WlBPdnpzTXJiVWd5Ky8rREVJZ2wwMGpFdVBNYVI2amVRVE1JY2llR1JvVFNR?=
 =?utf-8?B?U2wvS1NIM2pPeXRnNC9VZmVYb1hTcExrdU9ZSDNyK3I1V1Q2UEd5djAyekM1?=
 =?utf-8?B?SmhMMC9HKzlqbFpZMks3MnluMGdsYkRZOFBPTlRxTEhicnY0N2lMQ05QSnpF?=
 =?utf-8?B?L2xnQnZvUHRrSldwNW9qNzBlSDAzZTNpWWsvNTN1UzNuV3hVUWZraU56WEtS?=
 =?utf-8?B?WUtHUUtOa0ZFSmNFMnFWdXBvVXRpWUsrMmE5T2hFb0JVdlZrOVQ3ZTdTY1Ex?=
 =?utf-8?B?ZnFGZGFpSmxTbHV6VEJkOVRoT0psS05ISUQra3N5TGlXMlJDYnZtQmdmRGVR?=
 =?utf-8?B?dFFHaXNuejgrZVJDYWFabnY2aHVFYittK1VrVkxqVGpNVTAzTVNDMVZkcHlx?=
 =?utf-8?B?WlZaQkVSYnk3dXZsTDI2VmZqSGQraDZ1N00yTk1DdWhXWVlnVmszN1ZkNi9B?=
 =?utf-8?B?T29mWkpkOGJIS1lkaEVHcHBaUm5kTG1raW5TNDZJSWQwdnQya1Exa3lpSkp5?=
 =?utf-8?B?d2Q4SWw1cnlTaFpqVWlEcnVBS2VONkNaZHl5Vy80ZGI5ZWhBdXo4bkRqMUNI?=
 =?utf-8?B?MXFqT2VYbnJ1OUpvRFpDdDRtMEtZSTJYQVZPTGVyaXZRRHJMN2x2ejJLVlAy?=
 =?utf-8?B?QVdDait0R042NmFoYjB5OEJiNm1tUlpVaGRiNUpmQWFkUUlUQkFSZmNDZlR0?=
 =?utf-8?B?MWFqOE9FVWFDVlhjblBrTVpMYmUvSzhDU2NDUUczLzBQMDJ6RHUwSksydFdk?=
 =?utf-8?B?RU1SbXRvZzc2dTMyaXJvQnRSOTV0SlNXQVZuTzAyUlNyWHpmN21DOXdxL0NV?=
 =?utf-8?B?Q1lUV1E3aCtPWFgrY21SWXJoS1ptekcya3J1L2YvRGRqUS80RVk0YkZYVUN0?=
 =?utf-8?B?T1BId1VRbi9XWkFPS3JKaVRBRDlnYTF0b0g2cWpSc0E0eVpkOWNaMTZxQmdF?=
 =?utf-8?B?UkFIMW5zRWRsR2FYQmY0TjBqM2RURjJmRHg2RGUrcTdPeVpRVDk0QUFOVHdl?=
 =?utf-8?B?WlgyN3FjQ0haeENUWUM2L3BOVmJ1ZmM2d05pU1hNOE5zbENpcU9XZm0rWnJ5?=
 =?utf-8?B?QXNhZFZJOGV2T0hXVHptK0YzbThLNjQrSnYzQ1hURUhNR0tCamJhSDlHQ3Vm?=
 =?utf-8?B?amdPMVB2K3M4aUlVZVZwdklKNEFVeSs3cXRteTdGd2hUdkZhajFmQWMvekI1?=
 =?utf-8?B?T2dmOXFTTXJxblhZT3dKV3c2Y3JIUDJhWnpWQjNYUGhqSEdiYldkaG1TK0l6?=
 =?utf-8?B?VlFTY2YvOHRMMjhzWEJBNGhjZmxyNFJWTGZ6Qk5CQUErVHlPRTcwYWNHbDJr?=
 =?utf-8?B?eHRDbVNnNmtzTjNualJ2QjJ6RHNBRUo0NXlPYkdwZDBoQzZqL3ZDTFA2TFNM?=
 =?utf-8?B?WXdFNDI2eEVCc1ZmZGZ6RHgzWFZKTlJQdmZ5ZVpjV0JHdnlNTVE2MVc5b3Vw?=
 =?utf-8?B?eWdpSWovcktIMStWUWVQNXlOcGRpeXZ1N2swTlhCVWt0QklCMGh4cDNWWS9R?=
 =?utf-8?B?NlNsT1dyOG0zU2NaZmZ5a2FNb1ptTEJES0ZLcW5RVC9qaGFZL0NCeENVUlNI?=
 =?utf-8?B?YS9oMVV6b1I4eW5TMFdpZCtMYTRSQ0h2WUxkRmJSK2VVOE0vRTNFK0VDRkI3?=
 =?utf-8?B?SnF3V09iYnhmN3VYcVhyOUJyRFpwSU1XdXlFRjhCb3B0N1ZjWHBNbDlTK0pW?=
 =?utf-8?B?OGEzVEJyckhFckptdjh3MGZCUG56Mi9qbWNnVUFQM2F1aThJbWI5eHZXUXlU?=
 =?utf-8?B?Y3pNa1JCUnN2VFJyVGZQWmluNmY5NGFsOGo3UGd0RXp0TGdhamFSdUdMTTdy?=
 =?utf-8?B?SUJxZC8rTldzQk0xN2UvSWZxVm55ZUxGZ2ErbEpib216MjNxZXc4QnRUUUhY?=
 =?utf-8?Q?RCkiVhUmYHxPBkG3Ni4gWeP00?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d7de52-5471-44dd-227e-08dc5af59b74
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:36:50.4166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAjCtqnCW07xR0Z+fM1HbXJgo1P0S7l5Mv3Eg4keapHVetPCraAYWJjEoEWQQrXp/eDHw1QYD6kBNUHPRJ39nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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



On 2024-04-12 00:16, Alex Deucher wrote:
> ping?
> 
> On Fri, Mar 29, 2024 at 6:59 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> This reverts commit b5abd7f983e14054593dc91d6df2aa5f8cc67652.
>>
>> This change breaks DSC on 4k monitors at 144Hz over USB-C.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3254
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
>> Cc: Tom Chung <chiahsuan.chung@amd.com>
>> Cc: Charlene Liu <charlene.liu@amd.com>
>> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> Cc: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>> ---
>>  .../gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c | 8 +++-----
>>  .../gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c | 4 ++--
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
>> index e224a028d68ac..8a0460e863097 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
>> @@ -248,14 +248,12 @@ void dcn32_link_encoder_construct(
>>         enc10->base.hpd_source = init_data->hpd_source;
>>         enc10->base.connector = init_data->connector;
>>
>> -       enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
>> -
>> -       enc10->base.features = *enc_features;
>>         if (enc10->base.connector.id == CONNECTOR_ID_USBC)
>>                 enc10->base.features.flags.bits.DP_IS_USB_C = 1;
>>
>> -       if (enc10->base.connector.id == CONNECTOR_ID_USBC)
>> -               enc10->base.features.flags.bits.DP_IS_USB_C = 1;
>> +       enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
>> +
>> +       enc10->base.features = *enc_features;
>>
>>         enc10->base.transmitter = init_data->transmitter;
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
>> index 6e6ae3de08e4c..6864b6d174370 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
>> @@ -184,6 +184,8 @@ void dcn35_link_encoder_construct(
>>         enc10->base.hpd_source = init_data->hpd_source;
>>         enc10->base.connector = init_data->connector;
>>
>> +       if (enc10->base.connector.id == CONNECTOR_ID_USBC)
>> +               enc10->base.features.flags.bits.DP_IS_USB_C = 1;
>>
>>         enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
>>
>> @@ -238,8 +240,6 @@ void dcn35_link_encoder_construct(
>>         }
>>
>>         enc10->base.features.flags.bits.HDMI_6GB_EN = 1;
>> -       if (enc10->base.connector.id == CONNECTOR_ID_USBC)
>> -               enc10->base.features.flags.bits.DP_IS_USB_C = 1;
>>
>>         if (bp_funcs->get_connector_speed_cap_info)
>>                 result = bp_funcs->get_connector_speed_cap_info(enc10->base.ctx->dc_bios,
>> --
>> 2.44.0
>>

