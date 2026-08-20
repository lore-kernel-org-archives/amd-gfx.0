Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F9BC5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 15:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B3E10E1F0;
	Thu, 20 Aug 2026 15:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r51E/fsF";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163D310E1F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 15:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhWE6iX/dPfqegMiDHTZu1z712/FtdBsNVHwukqUWdjDPlGeyUiW/1ZNR5WXmFkI67lCvZIGATsWEsDL4JR4l2RlIO99P5iBYteYiPdMG/i131Ui3hrsHXm7Vd0vB5KNrkdCgYK/hNec/jy6GrLmJ29cClgTasaukT/K331+a/tqP813IVfyevdVccIvX7wIDrXr1o32Jho6SxSZlBcE/JA3oJ7WasCe+MAI0xCU9Jbkd7PCbEyYue+tSFA6TnC8AGbOvDQaUxHvdsbnE73LWpMBZji551TP5Q3d21xRMYh0SJ5BHJHxuShf6CSQY0LzVQyWhe+3oqNhT240gizTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moWNbVYQxKanJo6ArFL6ZOubEYpTJ/oWeWXbyPyrZDc=;
 b=UmVocND7snksp4L6JgH2UV35mywVo5rhAnLOG0rAgVvbHRT2iLMZX7J3dAYAWU7CCrB85Iaw/JiFEsZdBW4OFQb4iuljyUpM4bEcvIn41ApnN1+zX7yLfGH+lJdl3REceep4oRYHuf/lnYa4kniKtv9gCcTVfaompURmfpuxij/4/Zoz+44BJd6P7QjS8sTjZvoTfQW706XS0XAmaxJH66cq6XdgrF3SicvNSAfbkjvPSzyb+ClzsZ3NpiYPo61ntwBNZJx22V+7pV91IM87QAzcY9b5PraN0tMvnEWEKyDrBIPVNU0ydOFvMr2z56IKMBeXWYHdcRMUaws0b4OC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moWNbVYQxKanJo6ArFL6ZOubEYpTJ/oWeWXbyPyrZDc=;
 b=r51E/fsFEHdu3M/+83L5EBpnm4aW5EWwugbABCSfN4ZKMAYZ54GxaODnDGFIXXl8oPGbnEB9xdwdVMnHa83+uJAJqgK6XXna5vpfZ+CDXhnuxUpL/zZ/SgwTux9kFeLpXfHbTYdR0onDODcmSiHQMaLTwmK27uB8LQwV8m9ySKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 15:54:00 +0000
Received: from SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53]) by SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:54:00 +0000
Message-ID: <880c1dfa-5422-4fa2-88b5-c4c1fbe06add@amd.com>
Date: Thu, 20 Aug 2026 17:53:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix VCE 3 ring align_mask
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260820144727.12484-2-david.rosca@amd.com>
 <CADnq5_M+r+Sr3GXRr9O_jqu9zcVYRuihVfczpU1PwFoO1vw7AA@mail.gmail.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <CADnq5_M+r+Sr3GXRr9O_jqu9zcVYRuihVfczpU1PwFoO1vw7AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::25) To SN7PR12MB6767.namprd12.prod.outlook.com
 (2603:10b6:806:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6767:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2cce71-039b-4c47-53b3-08defed34048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|3023799007|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: dgCFC88jVqJ2BMMgVg4/jarzXIkgIslyimtWNsbBHloEx7u8gTgCA+2V5Ezngod8y6e84nfTavh0zIfPWXRnz3qpKnjSnlXm6uyGhm/1OxTxZwJCD//2CQyWE2AsZaF60W7VUvMtlHIcTmdiwZ+VSEPnAfSdkE39sWTMwwXpBsaQhDlvbejYM9rR0ge9jB4ujxWUFvSymAIUXcO+DNVTxaQkL5tTNDOAxaTH7ySSpgAOPd7/v6p3jCR1CDF8JsMLqanyI8wgVjFPSu/gnbvAQEJ7qSyuLO7rC9urYDb4gyFX1MzuU1PjE+OaNZMT978DGRv1RURjFS2Yu9d1VS+c7SZ7sAjyMSkc3U4OttDDQNwC2yrje9m8Qx+5VqqYemxs0hz2ne0/MLLJHCczaMZEcUVrtGhafeyKHz/0ZGJNVYJrc0iJzKZLyH01jR/OgqlNfkLtMAW3pwXNJm2qUnWIVEalWZx+d/ZQ12wLwdom814WOhJZrHx/+v82AXjxb5bbb4Y+Xl7B2mUql/w/OdMp6OFKEwpXpploCPXue7QVpvY5lf9Hk4M2SA2bxK1XsXW+lkSUDx5M/mQZ8OH3O1ujgNFZPqDfIq/EveKkZJ+9WpP3TcSZtvxNqOFLWDiasiOZHI8xlXIorqbbspft9Com5KaRzsKP1BIg4za8XMeC8kM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVhvZzdyQnFtWjRPc1ArQVY2WXloNzRXYW9yeXpodER0K3J2SUdPamRETThE?=
 =?utf-8?B?N1V3dlhmWjB5YXBNLytJSFpnUDZqd0tURDlLbCtJTEdWaC9XdzI3SmRCTENG?=
 =?utf-8?B?eWlZelJPQTF1Y3E4Zm1WNkxPSjNYQTEyRTdvcG5oOThqbnRiZmFtdGZaMUo1?=
 =?utf-8?B?MkVBVUZwRGw4SEg0NzhpYXFnblJxbU5lY2wyZTRXUVEyb1ZyQlBVRmFOVGgv?=
 =?utf-8?B?ZGJDVlRWV3VxaVJjL0theW1saTJvRXJid3B5eWt4TURGUU84YVp1WG41NTlM?=
 =?utf-8?B?N2xwc090RTJySkNvb0xYZ3cvdFpMUXFMRFVFMEk0S3Q1Q0x3RXJ2REFvc2Vp?=
 =?utf-8?B?MUwzblgrZXZpeTIrRFlOVWZEaWszdmNjViszSHpLT2ZpQlhpL3pNOHBUWkNu?=
 =?utf-8?B?elg0cXBTWXBCVzJpeUlmbjBIS0R0RFhqbU9aM2NLUEdvRnkxcWZlYnJ5RnZs?=
 =?utf-8?B?d2M3am5mamh2elBSdjZmbXA3SnE4SDlRSmhwS0N4MjFzcTQ4OWI2dS9xMC82?=
 =?utf-8?B?b0lPbkNmaUtSZW1Wb0czclJZRTVDN0NtV1FPRmlCQkEzVitUcXErSmpodHY3?=
 =?utf-8?B?UzA4WnFLSEZxVVpVUjNqdkgzd3JkazM5N2pFOTFKMC9iTG4xOHJpcE1nWTc1?=
 =?utf-8?B?d1lXbDd0OGh3eHgvdWsyTzFSZmc1am1IcHJFQkFHVGpGTlBiOTk4aGR5eVFC?=
 =?utf-8?B?cEhFcTNteDZ2eWFvUkl4QUk0UlZHMWwvQjB3QTNLcTlQR2VEOWk4Sm5kd2Fh?=
 =?utf-8?B?VitrczFaKzF5SVl0eWgrbjlYTWVxb1RpdEhFVHVTNWszZUV1MnlPak1IYytv?=
 =?utf-8?B?bi9adjZnOW0yM3o0V2o2bGdYU080MktFRit5VHFmSGhER2ZDS1NmWjA1eTc0?=
 =?utf-8?B?R05xclBCU0NzeEZteG9aKzVCTUNIc244blJCRmRlNzBRVmpieFhxbFUwZU5Q?=
 =?utf-8?B?cld4Tm53TGVvUTBXSTNYUnpLbzhKVG5MbzVnMjNRcXdqejhJKzhUMzJKUUtj?=
 =?utf-8?B?UUdZYUtabHFjSGdpcmJHZEkxV2hWWXBSZ2hOb2xSUHpCKzdnRGdLL3g0eDJT?=
 =?utf-8?B?YlRGeEpNWDMzMWhGWm5iMXJ1T0IyNzF2YkpmSlBuWCtJZmQvOTEwS0R3WXNZ?=
 =?utf-8?B?QVNsbWtaeUtzWmhLQzljN3hWbk41WmdaR2labEoxNXNsdVJlRnhJRjcwbSs3?=
 =?utf-8?B?Q25YZytjQk5VS01TSGVzT2U2S3JoUkJLSE1RV1hxRU1OZkhGNmdMMnFOTTZa?=
 =?utf-8?B?K3M0YkFQM1pvU29tcllzMWJnYjI3ZiswUG1hR1FaUWVRZ0NJNCtqU3dNbzd5?=
 =?utf-8?B?SHdDTE0wVFdZTWhaZnBYR2J4eDhuK05oVGpYL3V2cXZ0SlQrbkU1WDE5Q3Ez?=
 =?utf-8?B?bFhXYnNLc1RJaU5HdU50d09kTi8yRXZDU0plRjZKa3llcEt6S2RtUXJHbWdM?=
 =?utf-8?B?VW9ISmtzblNNYklkazVZcVB4bVV1amQvS1ovUkEzZFYzdDR0RWVBQWduMEYr?=
 =?utf-8?B?REkzWW1XOUdGZVh3ZnFVY0J6QmMvN2wyTCtyeDlFZGxmSW1YaXQxNjhkVjhM?=
 =?utf-8?B?MjBGeENuNVByL1ErNldFVWNsSWRTTXBlRm91M3BXa2pSSVhqcUZzZDQxekFm?=
 =?utf-8?B?SWFnditpUkVvMzR0TENESFVMUVExSUtlYVVTSzFyYWEwS0w5OFQ2dlB5bG9W?=
 =?utf-8?B?U2JXZWJRNjlCT3hUQkZlakpqNDVFcGN5VXh3c2t6dGw3dW91bWhDNUV3cUE3?=
 =?utf-8?B?TDZ5UVhSR1pVdGVuRk83dG56UkJoOEJ3TkJQQkhEKzU4OURzbVIzUHpWQWph?=
 =?utf-8?B?a29nUW9TRTBLWjFRRHJ6cnpjS0hrZW9xeEpZbEJkSTd2UkI5QXFhbjFSTnhS?=
 =?utf-8?B?b3p2SC84TWozcnArbWVReXM4dGVwdkk4akRYTUQxajVzeVhnVUliTTBEaDI0?=
 =?utf-8?B?WlNYOWRZSmQyMEh6R1VoRGxNbWZuM2Y0WmNuUW5GL0habU53WW5Pak1uK3p4?=
 =?utf-8?B?YzEvS3I5cXR4dmtQWHcyYkFac2N2aFJMcUQxb0k1SUsyNW1nRnFlaE9ORjJ4?=
 =?utf-8?B?Z3N6S2RjREpocDN3QjVFSXhoSXllU1BaeHZGZVkxZEh3RmRxeGhEa2xlOVZU?=
 =?utf-8?B?NEJtcndoZmFyTVNTODUxendpcDVQVnpoa25lbW0rZVlSMS9CbDRBQmZ2cm9z?=
 =?utf-8?B?ODRpMy83dGNDTlgzZC9mQ0VJQmdMN200azlXNi9nOXZPUjFYbGlpbkIycWN0?=
 =?utf-8?B?Mk8yUkN2THkzRmdhZWFDTVlXSWtiUmpzOWk5Z0pucHhkQ0FpOXF5a2Z5Tjdr?=
 =?utf-8?B?bGI1RHRvMm9iTHA5eW5GekQ3eDhRdlpGd2JlNGQyMCtmVHBBNVB5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2cce71-039b-4c47-53b3-08defed34048
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:54:00.5100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzhyxxslMz1+veGrf+0aCM9Xh5Jw+9Oh7RCxJtDn34AoOquTAT7AezIBkZt90WNG9BAI2MrLryU+bwHhy4jmzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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


On 8/20/26 17:05, Alex Deucher wrote:
> On Thu, Aug 20, 2026 at 11:01 AM David Rosca <david.rosca@amd.com> wrote:
>> The largest frame is 20 dwords, so 0xf mask is too small.
>> This was always wrong, but we were lucky with the VCE_CMD_END
>> commands inserted after fence and vm_flush.
>>
>> Fixes: 7591335141a0 ("drm/amdgpu: Implement insert_end for VCE 3")
>> Signed-off-by: David Rosca <david.rosca@amd.com>
> Do any other VCE versions need their masks fixed?

No, only VCE 3 was wrong.

David

>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index 9809a23fa521..d5adccd3e689 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -890,7 +890,7 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_phys_funcs = {
>>
>>   static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
>>          .type = AMDGPU_RING_TYPE_VCE,
>> -       .align_mask = 0xf,
>> +       .align_mask = 0x1f,
>>          .nop = VCE_CMD_NO_OP,
>>          .support_64bit_ptrs = false,
>>          .no_user_fence = true,
>> --
>> 2.43.0
>>
