Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77805C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 20:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A7910E0C5;
	Thu, 15 May 2025 20:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4uStYi8C";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1C910E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 20:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imrpEEtV4WgEI1mfqxojy3Ml/9G+ed5ebpje14J9pNSDgpPi6T7MJEofY4BJtrZ+opsnf5I5W9TvOSuQn7DwwKSuTdPJpDq9f0TG4XttqVLBcd9XPjR4fbTR/FUHAfwdzL2MtAu4iD+rkSC10BeNyi3uZvV7BVTf6katjzrUk7V8iBwDCyOeF9wT2iakM9mAuxvx8nFQ20KdpdqzlUeCZZVOOaEMBIOfQQXDEFWWHyhikh1J8ZSzwYUaNCWxgxTdjwFZq3gyvAJ8ZCgnLXgxFGPKQSuh5jM0pQsmB1S9mLNPP2rnWxRlENke6cR7S1B6w61bXhWCoyTCI2pt2JRyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjPrF5f+NiUs77YTUahfAUN59cJ7IKbzxHccHIwDNFw=;
 b=trWyF12ArUbsjaw/rVtzyi5vJxU8xsLM/bqJlcSXZoBg7N0ZGJ9ht8snwX11VB98Zm0Ip4Wj80ucPjqP92GSVr0PW3xLKwna9JjRfk1AkZ2L3Z7XsazJ3IEId9vKP1i0DGv7yvwKrEYjnXPFNbDS/DVLR68JUSN+Nxsv2xmNXp2AfmyWffB04IS8QRStbBIn+KH6LulXNjyFTAwlr5wa0WMGlrOwQVKFDGByWnXx5ChcPDFPJko+53eMBim0OkrskPUSaPRX38Bs+BflmxJO2GZ98nRLHPj/ylC1KsplZeIMOlQk0nd2ENddu0UzS864lCcEBAMUuv5NuHfYM7hk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjPrF5f+NiUs77YTUahfAUN59cJ7IKbzxHccHIwDNFw=;
 b=4uStYi8CFtVcIp+pFNYAKixHUbPSXoeJxkU3RVlzmBYGf1q9SX1SrhOX/6vn/jwNCzyGX4Z59O/XhaHWjWu1PSjH8ORmg1t5TwBv1/uldmg1TtLnR0A+e/Fse4CF4swUWs+we7iFzNcnfiIm2zHfWxuRwY8td+Q7g4GESwsR+0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 20:45:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 20:45:48 +0000
Message-ID: <18f1dafd-4f0b-9dac-2994-3e826f17e335@amd.com>
Date: Thu, 15 May 2025 16:45:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/amdkfd: destroy_pdds release pdd->drm_file at end
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-4-Philip.Yang@amd.com>
 <4a02537f-1ea3-471f-ae10-c85471a65402@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <4a02537f-1ea3-471f-ae10-c85471a65402@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbbd0b5-073b-4e6b-87d8-08dd93f178d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXA2WnRzY0p0V2V4SDlQT3Y0WGg4bzczSU00MUJSdkNxa1ZyQmtDaUVRcmZS?=
 =?utf-8?B?NGUwUGI0YUtSOGhDYkNXRk9rdFJFeFc2eFFFaTJER29Pc1FVSHdQM2pFbTlq?=
 =?utf-8?B?ZGFiVGd3dzlhbk1QOHJORW4rQmljT1dHS1hyS1c1Y2ZqeG9vU3hpNzdhclF0?=
 =?utf-8?B?Q1BGK2dPM1kvSS91dkIrQlVVNTBRcEJpWFNBbTh5MHMwWlBhSHM2V3dMSUxx?=
 =?utf-8?B?YTg4QVBkTTliVm83WjNwdEdXVWhSUVZ6OCtIOGRHbjBOOU9NZnRNTkFOdUNZ?=
 =?utf-8?B?MGxZMVQ5U1JjRlduaWsvV2VwaTlhbWZ5V3JDeWEyV3I0Tnk5VUszS0h1aHd6?=
 =?utf-8?B?SVRKSEhRMDhEbWdYSnVBM1hpTU5MTWluQzl3dythZU1RMkJBQVA3VW9KbDNx?=
 =?utf-8?B?U1IrYVZtcnJ4aU40c01UczlLZnNDQ2pmZERpVGsrVkRaWS9jMEd5UC84bStk?=
 =?utf-8?B?bzQ0dE9LU1JQM2tvWnJBTHB5WUgrRHdvb25CUmVyRXdMRXhoSTBxUFYvMDNN?=
 =?utf-8?B?OW9VMi8yVzg0UHVhNCsxcnlqREtmNkVOM253MWE3VGJ6VzlqSkUzczhhckYw?=
 =?utf-8?B?Z2NoL0FMUFhpTGRndTdzUlR4VCs3L2xmb0duWmNpZVZlSlM1RzZyQ2tFZTlK?=
 =?utf-8?B?Z2VRS3ErVVlJU1BRV241bDdQV1pzNmRvU2RrY1VQZGsyVUw2U2hqQU5oUlpi?=
 =?utf-8?B?SmZJYVlzOEdSTnllQXZEU0xhU2kxaU40L1U2dlBFODcxVHhtSko3L2QxOWRG?=
 =?utf-8?B?NTVUbnVKcnJSM2tjNHovQWFYcmt6MWhaL1czN3VMWXdubDJMNlF1ek9ZYzRr?=
 =?utf-8?B?OTJLTWVkODRDNk43cjVTTHJsZU5pY3ZJdUI4NStFdzRyU3Z4NVJBQk5vWEll?=
 =?utf-8?B?OHcwOTdKb2IvNFdvR0Vha1NKNnRKa2ZzbURLTmdQcFJocVlUZzVYeEozdUc4?=
 =?utf-8?B?V05vUDkxNmdFeGR5U0pDeXhVM3QvL21vdEpJR3JOL3FPQk1MdUhpUllsUG1w?=
 =?utf-8?B?RVgyQ3p2bXVzNHhMOS9kRWZ5MmxuMVkzSmtjYmYva3BMcGoyandtbkhvbzBQ?=
 =?utf-8?B?QUdIaXgrS1pFY3p0dzNsWUxjOGEyaXUwOVVkazZjeGx1QWg5REdCWmljR1Uz?=
 =?utf-8?B?cUZFSk1FeVpPaDZNTzl1WU80MlVHTVZKdUZOUG1WUDJISnRuN1ZaMkRXd2FT?=
 =?utf-8?B?QjJYVXlmbXdKbzNTbWpFYzhhVXNEZ1J6Y0ErRmtrcUMwcW9nTDZzUHF5RE9a?=
 =?utf-8?B?ZVc2WGd0QjZjakRJamc0aGsrUkZmbTNuODc5dFYySGFPSWYzUEZhb1FGbkZV?=
 =?utf-8?B?dFZ4RjIxSFJaNENsM1lKWm9vYnl0L09XT29Nb0s1TzE0RytWVlZNa2lTTFRm?=
 =?utf-8?B?RkJXcmE0NUwrUThIaDlKWDEybGFhaEFIenNBRXUyQ2JDRjJ3QTNhY1prdUhz?=
 =?utf-8?B?QXVnMWRGeW5PTUdUeXVUKzUrbHdIZmRHNFZHMlJVZkFCdmJtSnRTQlFYbE1l?=
 =?utf-8?B?a2toejJVbE5rZlQ0TERYMVBITm13elU5bmNUTFRHOWcyY2VjaE1Gem1YRml2?=
 =?utf-8?B?UGNHcWRzb0x4UG9pRGw3ZmtxbjlPZkxXZU5TdFA1WTFSNDRiL3pCVmVMcVI1?=
 =?utf-8?B?NFVuV2dmUU1Ma0RGdm9KY09LbkE3UnZiaCt2WEg1dFRYZ3orWi9KTVozUEcz?=
 =?utf-8?B?anQ1TUZROEREb1Nic08wNUJmVlZXc3FNdXJZeTRsMmFldkNjOXVPcmVRZ0pW?=
 =?utf-8?B?RXh6UmtnTCs2ak5RRXJUaUhOMUxqL3F6RzlTOG5SVGFIQmxPNTdYUHVkb2xL?=
 =?utf-8?B?NFBKbnhnaTgrc05qU0dNV3FQMnlGdUhUczdBdWg3RHB0QndPcTV5MHNuZzFE?=
 =?utf-8?B?VkVlNVNpOEFkV21OOWVRaC9wOHptdzJGM3lyK0xaY3Ric2pmQVhJQTFSc2xU?=
 =?utf-8?Q?/gkeCDWClG4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRRU1ZrOWtVVkJ1ZGtMdjduNEp2QmMzNUlvZzYzUWc0QkZIRzlKRHVtVVJG?=
 =?utf-8?B?a2xRQkozd0tQSDZ1RUhhWTg3dDMvMlBWbHdrSUxPREkzY2J0VE5lcENsMXpy?=
 =?utf-8?B?R1dmaW5VR1hMbVljdTduSGxLRE1SWGVXU0JYcm5hTDJOZ0YxOEFaT3RsZkQ1?=
 =?utf-8?B?U1piaE5WbThlNkRkZDRHZmdYMkxiSEhLbytvcXYwYzR6OXdYSXhDUjdodnVX?=
 =?utf-8?B?aVlhcmtaeUNkd2ZDQ2lKcksyY1BON0htQ2VrRDBjNHZETy9GU3ZIcjJkS0Q4?=
 =?utf-8?B?bm1mOThmaktyT3MzQjhUSWRQU0J3a3VTY2JrbW9YNWRTZDIweTdaS3RyYnNT?=
 =?utf-8?B?eHk0MmpDU090empWSjNmdklxbVI0Q3NZbnNURTk1MEZJdjJnSGJQK0g5OGVp?=
 =?utf-8?B?QWhwWVlwL1FiZk1pb1RhUXlES3ZaSG9TU0tEdSswNnU3cmNUTzVETzRWUVB6?=
 =?utf-8?B?YlBIZW1WbXk0dmFtUDZzV0h2cUdCb1AvUmVrVjZpdTlZT1EzVXJkNGJiRlVp?=
 =?utf-8?B?dFFiVldSc0N6bG9vUjNqekgvRzg2cnN2b0NTSVNDNG1xZS9YZ2VsOEViUzdr?=
 =?utf-8?B?QWZXbjVXV3pRekQ5eFJwVVBkaGRsZi9ETmhoT2NGZHZwWFZxNlU5UkIreXNI?=
 =?utf-8?B?TCtETDhHOUp0N3BoQ0k2a3dCQnVvYkxUSUpUSnZaUzRSSktnNlhtRVdjeWpz?=
 =?utf-8?B?cjdLQ2R4eHRlZXBScEhLZHNwa3lFT3hUQXNPOHFTdlBzSWlPZHpMUHRVUmFJ?=
 =?utf-8?B?Vi9la3B1VEFlNHRBY2xGTFZmckJ0ZEwvN1lyMDZqSm5HSXB2dHVURTlEVlRo?=
 =?utf-8?B?aHFTUFFXb0dGNnhZTFNibVBxZTU5TSt6eUdURldUV2VGa2NGdVdCN2R6bS82?=
 =?utf-8?B?Y2pwZjV3UlQrcURydU5XalhNYit4T0FCMVBJdmx5RE4yNVR0NmY5MG8vVjNF?=
 =?utf-8?B?dWlVM2VMSld4Y24xM3BPcFUwNnVRV2VvNG9tdG1TTmtxYkh3K0ltRHRBR1hZ?=
 =?utf-8?B?LzFsdkoxZG1mUzhIenpZSkVwY2NhUGQ2Vy9TWFM1a3pYd0J5dVU1dm9BZnQ1?=
 =?utf-8?B?WFlUbjZmN1ROVys5UVR1aFVlQ1RzSE9DcGc3TDRCbmxPS2pqck1kWm5QVmpG?=
 =?utf-8?B?QitBZ2dmNDJvRlZLN1RJRDVGUG1Ib3dBYzF6ckNsTXhwM25Fcm5WLzBPYWlC?=
 =?utf-8?B?d1hVdFhnN1lDcTAyQVN0RTg4MTVnVVFrNGtvV0d0M2tGN0ZZaThqc1Awancx?=
 =?utf-8?B?eVBiV2FuWlpicS9iU3RoWm04TXFmd25RWWFudTV5TDR1cU4xc3owd2tYSE42?=
 =?utf-8?B?RThndFNDakFlRkZ4TCtEUC9malhZNDV4eFhrVDJZeHh5bVBLN0JpamZ0UTBm?=
 =?utf-8?B?OHVKNjVtN1BlbjMwY04vN0lwQUNpSTY5Z1JHYko5WVhtNDhDdFJxZXFiY01H?=
 =?utf-8?B?MXpZOGZpa0FYemptZmRHSjgzTjJndUl4T1pLc2RCK01pMnplTFJDeGEvOExD?=
 =?utf-8?B?RCtER1BuZEpUaURDYTlvZXRyR0tmQjcrSU1ySWp2SmVOazNQcm1XTWFmYk11?=
 =?utf-8?B?ODc1dStaV01ncXYzNXRaWWtyOUhGZlpTZVAwaHNjWk93V1FYN2ZUdjFzY21h?=
 =?utf-8?B?WkFpRWZNRGlCS1F1OXdWRXZQS3kwbklkRHJ5enFJTk1KaDVzTFQxM3o3aFpJ?=
 =?utf-8?B?WjFRdkF4dXVCcmZWYTB1U3FaZVNBN2hkYUQrQ0RPOVFnaEIzUjZtNGxmMHVp?=
 =?utf-8?B?RGoyK2Z1MXJnUEdpQ2lyS1VCTDdrcnhXZVkxUUhaNmdQMnU4ZXhibDRxdWZ4?=
 =?utf-8?B?d1JGUWU3bDl0NER6SjZEbGoxSVBhRE1haGhZa003S01PbkMvZjFvNUtYVi9U?=
 =?utf-8?B?S3ZMKzNLTHljRnhZbXpsQk8yT2dmbHd0d3ptb2p1MDk5WStrV0E0V0ZTQkgz?=
 =?utf-8?B?QTNjbEMwdGRsRlp0WlBweVJOODZPdHZMazNtdThYVVB2NEM1ekhIbXh5NCs2?=
 =?utf-8?B?V2ZQZkFiR2YvZ21XNitMUzRvejdiU1JWWURrVG1OQjVoc3VLeFlSTlNvekNF?=
 =?utf-8?B?K3M0QnM3ZDVIdkpaVHdDc1lLK2N1eUc0ZVhOMGdhb3ZhR3gvYnpyL2RyQm9l?=
 =?utf-8?Q?tSbHYxF8np3V01AOU9cqI1KiB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbbd0b5-073b-4e6b-87d8-08dd93f178d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 20:45:48.2408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjEhN5O8YDviMzM7aJIJLRbYEe68RG4Sq2qVoJE5jkXnQVYUrcSpaZhXXFt16wS1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
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


On 2025-05-15 10:29, Chen, Xiaogang wrote:
>
> Does this patch fix a bug or just make code look more reasonable? 
> kfd_process_destroy_pdds releases pdd related buffers, not related to 
> operations on vm. So vm tear down dose not affect this function.
>
This change doesn't fix anything currently, as fput(pdd->drm_file) to 
free vm is right between free vm mapping qpd->cwsr_mem, qpd->ib_mem and 
free kernel bo qpd->proc_doorbells, pdd->proc_ctx_bo, to make it clear 
for future change.

Regards,

Philip

> Regards
>
> Xiaogang
>
> On 5/14/2025 12:10 PM, Philip Yang wrote:
>> Release pdd->drm_file may free the vm if this is the last reference,
>> move it to the last step after memory is unmapped.
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index e868cc8da46f..b009c852180d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1063,9 +1063,6 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>>   		kfd_process_device_destroy_cwsr_dgpu(pdd);
>>   		kfd_process_device_destroy_ib_mem(pdd);
>>   
>> -		if (pdd->drm_file)
>> -			fput(pdd->drm_file);
>> -
>>   		if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
>>   			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>>   				get_order(KFD_CWSR_TBA_TMA_SIZE));
>> @@ -1088,6 +1085,13 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>>   			pdd->runtime_inuse = false;
>>   		}
>>   
>> +		/*
>> +		 * This may release the vm if application already close the drm node,
>> +		 * do it as last step after memory unmapped.
>> +		 */
>> +		if (pdd->drm_file)
>> +			fput(pdd->drm_file);
>> +
>>   		kfree(pdd);
>>   		p->pdds[i] = NULL;
>>   	}
