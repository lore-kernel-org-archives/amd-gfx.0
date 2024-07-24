Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1CAC3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 16:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5520910E754;
	Wed, 24 Jul 2024 16:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPLDoDiR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A7010E75B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 16:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeWTHxcjRnbyBEWT0DbBF2L2L0irHWJuNxcxiOegPY7F24g9HBPRIamTRIppY42j6qQJyhJyvLntiFUjBax4eNXuo6W+5OZWtttkecG4TBm7pkTb5C5KZhcyGjkqhhn28c/lhbqMkrX5NRJ/sqNln9OLXV83fadeFU6CIvjYqhvxUmDgU3eVtz9D5BebeB3f/8kuuOZG1hHNU/Hzjqt9t1N3XyImLPfw16ewUwDRasIpi8HuUOq3LOOf5CxMhj6kO+QUFrOZT7TzwdkiNtJVj2jcHe3GF3Ne6bU2DvDzcRtse8QPxfN/myaEbfC1610UDMir7DuzFkivsTCTe1LB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuhauklcczh+BzuGiNg3SndKZ/Enr6XBf18hiixCBgw=;
 b=gXQPjat7pNuhYRrSfQdwT22nqdo/+8SxshzDxUuSDf9mRpkpS70EQMHnMZNTvYoKE/yoJ0Ij52BVSy5ljlLsc7+IV11UNBx9B+9CUjGz2SsJqbYR50IXVbDz3fXa6gyA0srtqZGhgZn/85QzLSqo9xQOlL8Ea9iR+UxTqxon3kIZ4GZZnGtgct0X9KmRZNsJoY6Z2bzMmdQcUofAEFQ9LZNFZDBohfq77YW/lwy2PBRzeUIXfwgdwYod0VJTIkcx16/gubR8EhlpgduQwky+PPEyGytzVKOGdL4EkB34lo7R5VbCoGoVUNwhGKhPrkyAhHhsQburHDaDqDuniPUiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuhauklcczh+BzuGiNg3SndKZ/Enr6XBf18hiixCBgw=;
 b=mPLDoDiR29MwCwpL+G9t/Vh5k31vLyEV6pX6knhUP/Q5BoM37iuBT1ApOcglaXAm2SLEyBDozPLH6BuvyHkoaMprGOvtQTynmJlH5kWrpWWerHDyLFBakMu8MXFt1gA/rTrHal/DWDqVKXHUF0E083ePRXtWKSgheDwB6z6zV4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 16:30:25 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 16:30:25 +0000
Message-ID: <28e697d9-ed63-4d7f-9299-4671d6e302da@amd.com>
Date: Wed, 24 Jul 2024 22:00:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] drm/amdgpu: add vcn_v3_0 ip dump support
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240724113250.2707693-1-sunil.khatri@amd.com>
 <20240724113250.2707693-3-sunil.khatri@amd.com>
 <CADnq5_My4-7NdE7Rp4-J4T21o6x-ipgVWC00RNdwNiu-VTJ2BQ@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_My4-7NdE7Rp4-J4T21o6x-ipgVWC00RNdwNiu-VTJ2BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::8) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2287be-0f88-4b02-336c-08dcabfdebdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXl1RTR5emd6YlBLNjNOOVdMcWFWd3FaQXNIem9idWxjeEdFZU9TNkRGbkdU?=
 =?utf-8?B?c0FTc0lvOThCZlJpK1hVOEl1eDVoV3FCZFZSVVN6bFZpRWIxdGpvbUxpUG5H?=
 =?utf-8?B?YjlHc2pMMEwrRkNGT1NpUzVaRm5wTnhhbDU4dTArTFVnbFlSVFhCVG1Ea3li?=
 =?utf-8?B?dGsxQUZCMUNodm9DT0lwK1BnRVExUmdvVjlIa1p1YzVpR1FaUU5IcmYvMkhp?=
 =?utf-8?B?eE5xM2JPVTR4RlF3TDdkd0hGV1dIa3hBMmMrMENEUUJOM0pzR2ZKM09uYVpv?=
 =?utf-8?B?ZFdNckgxSHl0NUlvMTFJdWJKanRxbGM4RDFYZmR0eXB3eTdTajRqcFI1NHFZ?=
 =?utf-8?B?NmxMQ1NJYUUwY01BZlJremZMUTJEdExKclZvKzVXQ0NnalA5cjBXWWFFTkx4?=
 =?utf-8?B?Z2hnSG9oVk1sUzNtY25Ka0dlQlp0eU5nT3JheXVaR29ybTlFZk51MDVkdkda?=
 =?utf-8?B?a0s4S29IVlVjQlhVMUU0cmNyTzVsbWxUVHpBdzZIUmNzdlFDTEt2aFMrRXA4?=
 =?utf-8?B?YUI4WDB3Qnh3djNUZ3l0M2xrcU0reG9OQ2tWbExhWnhXNHh0aWhML2ljSWx2?=
 =?utf-8?B?enFqNlVFdGh3SkJyR2VnbTZNSndHZDJpY2RIWXNBQWJBY2VTR1BjejFTbmdU?=
 =?utf-8?B?SmlBWUFQZzBCUmlhaUVaeUI3TkhYMG1BSFpVcC9CN3BScTlwZ1hHc3V2MkVN?=
 =?utf-8?B?VFJ3cmRrbittTmZxOG90VEVtaFpZY0dLN2dLa1FycVlrVEJ6aXBFQldiMy9K?=
 =?utf-8?B?N0NzaTNMYmNlbEVGeXFoamN6WXJpOWRFSXh5dExZRFhvekFkTlV5Nko0SElj?=
 =?utf-8?B?R1hZSnFSR1J2TkdpVnh5MFF3aTBCMVU0VGpwM21aQ1FxL0ZubGtMOHVZSzly?=
 =?utf-8?B?MDVUSW1IbzNmMHUzbGNoVDhGdVo3MFQxeVUva2k2U2RvQTYwU3ZySzYzQ2dL?=
 =?utf-8?B?bCs4dXUxWGljdElXMi9tSUxnWGlBdktKTXRMRjdiYWhRaSs5Qy9MOTBrUUlj?=
 =?utf-8?B?NnVaOGh3ZXNHVzBtMEpzZjZVbU5tUC9hZHNYZVNlWUx1VStSRXJ6aUMrOUZJ?=
 =?utf-8?B?NXlyTVF6TjY2MHdvY3NGT3ZMU3E4TCtnMjlpQmR6ZDFkbWdmemxXRDZKemh3?=
 =?utf-8?B?VkdiZm1kbmltdjZyY3RjU2lWVDUvRkRXdmxBSDdabjVZUHY2cDNxRG5CRlIz?=
 =?utf-8?B?Y2xrb3VoWitBTk5HL2tYUEVsZWtRWFpmaWdRb0xyaExTM2xnWXR6bytVOUNG?=
 =?utf-8?B?NWpzMlBKM1RwUkwzV1J0cnI3Vlh5OHpmLzN6eWc5c21sOGFEa2JGQlpXblVL?=
 =?utf-8?B?bHlpb0FLZ2ZoQXV1NllzbllrYjBEUlpLYUtsV0tCaTg0MlBiV2RnaitvZUkx?=
 =?utf-8?B?R3hFaHpQbFRwNGx0QnNKWmhtYVlXSk1saFYxeEVzQkxBMnQyV2tOTGVwUEt0?=
 =?utf-8?B?a1AvNXJxQWp0VHZjV0NvWU1tSFB2SlJDM0tObUo5VW5MVzFaZ1llaFRFalRN?=
 =?utf-8?B?K05DSTJuTEYwY3F5N0x4a0gzVkhnWGt0V2FsLzZWbGtWSjhkUTZmNkJHc28w?=
 =?utf-8?B?bWlyd0c4TXNRQlRHK0dWckF5bjBqbkxkSlo0Ym5PM0tEVm5WbzJXeExwL0pv?=
 =?utf-8?B?RzVFSFVBazhhSnRsczVrc2ZaNyt6OEZ6eFN5aUdtV2xZWFlWdVIrL2ljVUx6?=
 =?utf-8?B?THdCaUdMM1ZLb2lKeStNRjBNUmwwYjcwY2ZOZ2R6T2NER08yL2g5RXhOOTVu?=
 =?utf-8?B?cmxzb0JCcWlHdUdZZmhGNUdzQVgyMmdNSlh2QjZsbkt4YTRHQUdZSWpCOU9Z?=
 =?utf-8?B?emtaMmV2MjY3dWpKNFNCZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRQSTZiVHJJTDdmdUNhK2ZNQldINDdhVFltZXNRRVFpTFJSckVkTlB1dkZE?=
 =?utf-8?B?QXhNTFJlWUZENVp1ZEpZZ1pEOU5oWFQ5VWtTdHY5OS8zUjhaWWdxK2NyRktS?=
 =?utf-8?B?U2o3QzNTOGdDekV2dWNkRDNzUWMwOVZJenJTbWVhOEdGbU1yaGM2U08wd3NT?=
 =?utf-8?B?NllWeGF0Z0tPRkxJekxMeXdnN0VkWGlCS1I1bXlyTXROU3Qvdm5WVm4zb0Jp?=
 =?utf-8?B?REtnUE1NdzR1Z1lwTnVTcEpzZWwzNlJsd1J6em0reVBMYlRKakZiMDdKS3gx?=
 =?utf-8?B?SndUZC9FUUVUeVlCOFZpSnZERy9NWGdEKytYYXFqdmU2VUh1UTkvRmpwcGxT?=
 =?utf-8?B?Z1VGME9FWVJHNDNNRTFqMVVzQmZHSjZjenBERzZjNXkrRHM2VGFyLzZnQ0VW?=
 =?utf-8?B?Q1haaUxyVWlMQjU4Y1dJNmh1cTZYZ1YyYjRXUkxvc09vMnMvQ0l1MmdadUJ1?=
 =?utf-8?B?UkVmV3FpWFhNL2lFYkxNQktPR1JRVWg4UmFVM09SWU9sMXVWRDBqa3M4Njhq?=
 =?utf-8?B?MDNYTWQrdkFhQVhlemY0TXhBYmxPendUREJUQjQvQ0NBZ29MckFFMUE1Z2FX?=
 =?utf-8?B?TG0xalBFZEk5eDlzdHpmMitTUGFaaklDMnBRMHpySDBvWnpkdU53cnFkL2JE?=
 =?utf-8?B?L3pCTWw5MXNrUEtiNkNsL1p0WEVHQXJ6QmVQSVMwS2JIWThJZHVaekh5dDFy?=
 =?utf-8?B?Q3hiMkdwSVJJcGJDb2hVbEhjWTFNak5VR2hyOUZ5VE9UVzRLbVJNblkvazRz?=
 =?utf-8?B?TFFBaG45dlJDRXlRZk9ON3JVUnVNMGVPUXlidUpWcWxMcGkwUHM4QmtmRnpD?=
 =?utf-8?B?dEVYazVGUTRLMHU1MSt1L0tJRUk5SnlTU2pYQ3ZwTWhDbHZMUlJ3NXpSeGdR?=
 =?utf-8?B?SysvUzI5cWxsaThNeDI5VFJMQ3BNMFcxRm00UTFNendhcW15U2lhZnZiUS80?=
 =?utf-8?B?YTVVaE1qWFVqbVFXZWNIbVRpcU1NQ1hSeWpLdGYvd1VJNkhVd1Z2OXpHVmEy?=
 =?utf-8?B?SWx3Y0RrV2pydTNDcmJHSGdSc1d6d051ZmMyOGZTdUhPM3p5YjJnTmp6WHht?=
 =?utf-8?B?SGVjYmNvM3hKY3BoSnpmY3RJM3pUbysycTRqR051Q0VhQ3kwQWVibm83WGRY?=
 =?utf-8?B?L2pqVTJwRWlsVTZmTG1ndG1KUjVFK1lwVVJudXFabDJSWk5hMEZ1YnBiRFFG?=
 =?utf-8?B?b2ZQMktmem1iZENTT0FtalgrWnRXUlhFdUpraitFMkttUklyUWZwaWpybEk5?=
 =?utf-8?B?clFkKzRBMW12T3MxUDNNcWdvQXRzK2RXN05HMytEcnQ4WVlVYmFwVTJLcCtW?=
 =?utf-8?B?R1lrQ1Z3RVJMNE5RbGlLTFFvTUlrVUdjYlhjb01PK3VJNlBzWHhsS1dvbi9x?=
 =?utf-8?B?L2lleEtZRHJxYlJzbGFnVEprSkgrd0c0bUdwQ1Q3WHVNSXVVcDhGVWFxaWNN?=
 =?utf-8?B?Sjl3blAxTE8zLzhrNEt5bnFvc2VkN2thQTJGMjl6c3FyankvVS9kbnQyQ0N4?=
 =?utf-8?B?K3d5dXhWdGV4K3B4ekduQjF2MWl3ZzN5R3AxWXIxNXhQc2NtbWVLQVVYeEZh?=
 =?utf-8?B?Mjk2aTFyWUcvenp1eW10N1U1Q2pzWXE1bUo4NlIreHdOY2V4OS9veVdYY0V1?=
 =?utf-8?B?VjUzenorR291RGFVejczMkRoWE8yZ0VicWwwTkhJOE0xTHZyQ1lJdjUrNXNq?=
 =?utf-8?B?UzRzenFPb0NnTmpIQzNxV0tWWldhemgrY0F4OGExS0pMODVyRXNyUGc4Qi92?=
 =?utf-8?B?emsrTkJERTZDMnpyNDI2TXdlVkRVZ0NIUDJUcy9WYmp2YnZhUUF3QVRYUkZq?=
 =?utf-8?B?VEFKUldoeFFWWHR0cDlHZCt1RzhqSWZkMmkxR1hsUjNraDFYR0ZRZE5Id1dh?=
 =?utf-8?B?MkN6ZHBkMjgwRFVrYmpocXl0MGlieFQwUStlZTN0UlQrS3hWWW9majVQc2l3?=
 =?utf-8?B?SjF3dEFFanFMTjg3cE5LRG5uSHhQdXg4VUlCSWZTL0R2ejhEQk5BdXB0QnRi?=
 =?utf-8?B?UWZrV0o0ZmhyVWdkeWdLV0l2aU5rd1JsTnR3S1krU1ZjVzhLdC93VjdxdTNK?=
 =?utf-8?B?V0drY3MvVkRuaHorS0NJOFg3Mlh3cEMvVlFoUXZidWcwWWxoWnd2Wk83dDl6?=
 =?utf-8?Q?1QhA9aPiQGo3nRhn5c+Hdu993?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2287be-0f88-4b02-336c-08dcabfdebdd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 16:30:25.5394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfwVgM6erogbcM4f9DHmLLqovO5eHs2z+pzkzUB2aNab/+wvnT+HCmcWgdSh5PAa9En9suZLFxcZFwS2UCDprg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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


On 7/24/2024 9:33 PM, Alex Deucher wrote:
> On Wed, Jul 24, 2024 at 7:33 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Add support of vcn ip dump in the devcoredump
>> for vcn_v3_0.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 149 +++++++++++++++++++++++++-
>>   1 file changed, 148 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index 24f947751c46..544b46ad55bf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -60,6 +60,115 @@
>>   #define RDECODE_MSG_CREATE                                     0x00000000
>>   #define RDECODE_MESSAGE_CREATE                                 0x00000001
>>
>> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] = {
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RBC_RB_RPTR),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RBC_RB_WPTR),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CONTEXT_ID),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_DATA0),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_DATA1),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_CMD),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_RBC_IB_VMID),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC_VMIDS_MULTI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_PGFSM_CONFIG),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_PGFSM_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SOFT_RESET),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SOFT_RESET2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_GATE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_CTRL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_GATE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_CTRL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_STATUS2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_GATE2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_VCPU_CACHE_OFFSET2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SCRATCH1)
>> +};
>> +
>>   static int amdgpu_ih_clientid_vcns[] = {
>>          SOC15_IH_CLIENTID_VCN,
>>          SOC15_IH_CLIENTID_VCN1
>> @@ -126,6 +235,8 @@ static int vcn_v3_0_sw_init(void *handle)
>>          struct amdgpu_ring *ring;
>>          int i, j, r;
>>          int vcn_doorbell_index = 0;
>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
>> +       uint32_t *ptr;
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>
>>          r = amdgpu_vcn_sw_init(adev);
>> @@ -246,6 +357,15 @@ static int vcn_v3_0_sw_init(void *handle)
>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>                  adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
>>
>> +       /* Allocate memory for VCN IP Dump buffer */
>> +       ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
>> +       if (ptr == NULL) {
>> +               DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>> +               adev->vcn.ip_dump = NULL;
>> +       } else {
>> +               adev->vcn.ip_dump = ptr;
>> +       }
>> +
>>          return 0;
>>   }
>>
>> @@ -284,6 +404,7 @@ static int vcn_v3_0_sw_fini(void *handle)
>>
>>          r = amdgpu_vcn_sw_fini(adev);
>>
>> +       kfree(adev->vcn.ip_dump);
>>          return r;
>>   }
>>
>> @@ -2203,6 +2324,32 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
>>          }
>>   }
>>
>> +static void vcn_v3_0_dump_ip_state(void *handle)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       int i, j;
>> +       bool reg_safe;
>> +       uint32_t inst_off;
>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
>> +
>> +       if (!adev->vcn.ip_dump)
>> +               return;
>> +
>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +               if (adev->vcn.harvest_config & (1 << i))
>> +                       continue;
>> +
>> +               inst_off = i * reg_count;
>> +               reg_safe = (RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS) &
>> +                           UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1 ? true : false;
> You can drop the ? true : false.
Noted
>
>> +
>> +               if (reg_safe)
>> +                       for (j = 0; j < reg_count; j++)
>> +                               adev->vcn.ip_dump[inst_off + j] =
>> +                                       RREG32(SOC15_REG_ENTRY_OFFSET(vcn_reg_list_3_0[j]));
> How are you handling the per instance register offset?

Yes that i seem to miss. Using index only we have to do it. Let me 
rectify it.

Regards
Sunil

>
> Alex
>
>> +       }
>> +}
>> +
>>   static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
>>          .name = "vcn_v3_0",
>>          .early_init = vcn_v3_0_early_init,
>> @@ -2221,7 +2368,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
>>          .post_soft_reset = NULL,
>>          .set_clockgating_state = vcn_v3_0_set_clockgating_state,
>>          .set_powergating_state = vcn_v3_0_set_powergating_state,
>> -       .dump_ip_state = NULL,
>> +       .dump_ip_state = vcn_v3_0_dump_ip_state,
>>          .print_ip_state = NULL,
>>   };
>>
>> --
>> 2.34.1
>>
