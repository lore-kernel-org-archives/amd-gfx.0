Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199D8D44D54
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 12:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C9910E13A;
	Wed,  6 Nov 2024 12:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mz9F/hkB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EBF10E13A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 12:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHRIKuGR0xwJqWUA3+O/XsHkW0kFLG/R60K1XhjbiRYMp0qCzdEPRd9hkVrGy+ie0VQ5pRZbsGTyQHsnVmodWGRueaaSVpReZ4c6Ir/ZSFtRMQEuczfb16Js6xrmgj1+MJjPXIHJv/2SdSKjemmWVfId48ziQ30QrtAl9efEzKkz/bcNxXT9PFZgG2INC4/hGUsgpHt8opHfPF2hW7FxtB3nNluP9Mcc94p9mGDt7NABe+7ShSFw2UJ+ZLFeIYLb4H5fq3ECvksRuG/6Tytc+Rwzrtpsn1K7K6Dl0yg7LpH4NElDnmD7Q/wSsY78sh3zYoet5M9nbyRqbif+8oktPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8+clbibxVGtpGpJy7zuxMvR0OfiMc4fsMX6oYPkFkY=;
 b=atsXmPIG8fg20jZ1d0ULzxrMwAhMJ0fBdUf+BEpUEHR0S6nuex7sMUqzFqP/jwr7IsYJ25VKuDvYLM7XEwuYlL7gH+mhg3qVAPTT/bZHpe3pK1h0j+9tCr9NLge/Ky04Hsgz3DzzXEMICQB9r4KJfhMkyulXWRl5CvTqUHiQhCWvCjeI9Yy1Tu0tjnWL1d5fvpjbr0u1v2Oz0bT3x0lWAAFdOlD7dECBMUXraPpXfBCqmDy3MZ1vxbN6oplxNRCZoUlA/bynSgTBvXe+/BPsDCdh7s9p+6h2Qx/6LBE8HaXL/f47o0N8cpmBGuaF/f8MbNsjdhxgd4osaFc94bQaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8+clbibxVGtpGpJy7zuxMvR0OfiMc4fsMX6oYPkFkY=;
 b=Mz9F/hkB/rIod5muHp/nm/b5ju3iU3/UOcOQDZC+N5+0Lk+bknDcDl+WMoK8IuazcUd+2PnqxLZfBWcrz2IA5lVrTAKLiHHNvw6iLP3ZmnGA/G9iVPPDwQMZlyR3k3q1XZd17DhkXJB9CFqpNEnA8u3J6bxCTnbYaWWHWVXTVMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 12:24:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 12:24:19 +0000
Message-ID: <02ddce81-b7fc-4b72-8fa6-1aee9346edbc@amd.com>
Date: Wed, 6 Nov 2024 13:24:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: correct the SVM DMA device unmap direction
To: Felix Kuehling <felix.kuehling@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Harish.Kasiviswanathan@amd.com
References: <20241105023332.172404-1-Prike.Liang@amd.com>
 <04d4ab32-45a1-4b88-86ee-fb0f35a0ca40@amd.com>
 <3e8ece68-d9e7-4037-bc99-d3f9b78128b5@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3e8ece68-d9e7-4037-bc99-d3f9b78128b5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 01445246-1d55-4790-7a06-08dcfe5df043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N09NY0J0KzVXQy9ZcG1JNWVrU2hzcWNDUGE2YmE3RUJlS1JoR0JxSzQrZ1M2?=
 =?utf-8?B?aDBUNXhVaDk4WVJnNXFWcWV0ZElBU0prbmFLNXNOMjg1TnpUVDNpWkdjbXpk?=
 =?utf-8?B?UXdtYXRPT2VncFZaOEJnd0lSU1NmSEJCQlZkNS9uTm5ua3B2OEhod0ppR1Fh?=
 =?utf-8?B?WSszS204cmQyanpMNGVhcXFlVDFEVEZIZjdvSzJZbDRZTWpwTE5OOHNwVE5r?=
 =?utf-8?B?dFdVV2VUdXJnS2FWNmR6aTcwSXhrc0dLRU1TWFZzMS9WTzFmcThKd1ViZm5Q?=
 =?utf-8?B?dytlekhJdFZYS0VVNnk4dmNXcHE4OUVZcGR0VWZPL1BHdFpJajU1R28wc2tT?=
 =?utf-8?B?V2ljdXRyMFlmTzBUakN3cmg1UHBNUTUzdU5kTVl1RkFxMnB6anQwZ01zL1Z3?=
 =?utf-8?B?TjM5dEVrYllodzFMalJZVGtrcWRGdS9HekQyK0JxT1puUFZnSmNwVXZOcjQ1?=
 =?utf-8?B?dWRJS0RuMXJJWm9TUWQ2aW12Q1I0a0dROXBBMTJPMnJnVy8yQjdBQ1pYU0wv?=
 =?utf-8?B?SUlVREVmQmlJNzFnUk5QWU9abitheGFPMm9seVpPR1NlZDFHZ2hXdXpwNEQ5?=
 =?utf-8?B?eTFDLzFhRXVJZGVtTmVGc25tMTNOdGpHeXFxTjRIT1JJaS9LeGlNbnFlTlNy?=
 =?utf-8?B?b1d6Z3JtdzZycWo1WkxMc2ZQSVRwcFdWUURZbW9EOG1keHAwbEMvakdWbGpY?=
 =?utf-8?B?Y1NIVzdSSzhDZ2ZCVzg3bkl1NTZUeXBmUlVIMkptYk9QajR3UDZJdU9MblM1?=
 =?utf-8?B?UWJWZHUrNXppS0orWEM4eU9lVTdhOFNZT2R1bktDZUJRY3YrSlNLN2J2enY4?=
 =?utf-8?B?V1ZaWjV4bCtqWFhqSnVybTlSZURQWGZYeFVjamxOdzJYb01yRi9hR0VrS1Vt?=
 =?utf-8?B?THg3MEZ5WThkSXNmUzVCekcwU1RaQVYxUGxzVTdZRTdCKzRaNTJWL0VTL3lH?=
 =?utf-8?B?WUxZNkg3a0pUeVhtbEE3UWhUN0xvZzhDV2NXMm1OVXkvTVVUMkZWcEFmMFIz?=
 =?utf-8?B?T0Q4TEN3aFNjc08wdDVjVmI0aEdjWnhPOHBpbFpRMEhZamdyTEJLUVZrSVRJ?=
 =?utf-8?B?U2ZJYWJIbFcvTnNFZnBJOWhuSXVmRWhyM2J3SkpHOGZhcHVJQWhvdUtGSVhQ?=
 =?utf-8?B?ZjRQU1V4OXErN05BU2tGdlBxcndjZlVZM0c3VkdKWU9ZRFk0V3FGM3Jnc2RL?=
 =?utf-8?B?dTUxbjA5UEhRQ1dPbnV4bzFMcWF2R2I1cGptaXU4c2JyYmJxTGJld1lzMDds?=
 =?utf-8?B?eEwzWW1qbkdXWk90eE9ET0lxL254RS91djJ5ajdRdStZSUZMZ245RHN0UlhG?=
 =?utf-8?B?TlRCaUpScHdscXhOZTNhZ2h3V1I2Mk80SDdLUmttZHdkOWdaSjJaOE90Q3NR?=
 =?utf-8?B?Wmp2VURDamVudWdzQ05MQy9qdjdUaVhIRTNhRCtPRmtiWk5XbzN1NjVBeFRC?=
 =?utf-8?B?RStUcmR6SHFydVgrdjhwSDR5RVFUYVBYb281aXB2aHRrdytNQitiaXkwYUFJ?=
 =?utf-8?B?RExBUmwxVm1YajlQaUloVkRqQ1krMHd4YnFXUDArQzFZaVlwV3NOaVh0TWE2?=
 =?utf-8?B?bmpLNjRvTG1xQ1Q3UWVxR1liT2JvcENWQ3dJR2h2UDBLaTFmS3doS2J6ell2?=
 =?utf-8?B?YnY3TStqTDM2YVdaTVpuWU9uYTlZVnJyeGtUY1BtZWk4WjVkTkFTTnpPaWt5?=
 =?utf-8?B?R3ZmNFRCWVFOTkYvMzNhdnpheWFRaFkvT1pMR1U4T3g0WndTUzJia2l4MTY5?=
 =?utf-8?Q?mvTyXmBj/tTPe6M6QKpnQbVs8xreNbs4T6rPwsp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDlqeFlhSFlYNHZlaTJnM3JSN3dkVFljeTlzZDA5UkhEUkMvUFROMHo5L3Q4?=
 =?utf-8?B?a0xhNnJHemd5RUxHTnhsVEJTbFBra0ZGL3FRSnlPNDlweGhGR2tpaG16STdY?=
 =?utf-8?B?UmMwMTR5cUxlZllsaTNTaXJBYm84cWQ4Y28wZHZwdjJ0ajV1NGdhTkNFSWVi?=
 =?utf-8?B?eXZOdmJQUXpJK1dQRk12WkdYbXNqdjRjZ1NBZFp6LzNhRDdlYlZ6a2RsWVF4?=
 =?utf-8?B?Yk1NQWlKWG5TZzIrYmxhNFBEVE9SSXVoL0N3TDU0WWU5R3hJVU8yL0tUNkZE?=
 =?utf-8?B?MVJGbmNyL2VLQ294VFlWL0VyL0VLNXpNS3ZLbkFkSGUvait5SzVKRTBOVGZI?=
 =?utf-8?B?aXhlNmdEdnFyR2VZY3didG1uZkdFaEQ4cjY2a05sbEh0eGc1UzNFYmsrcTFP?=
 =?utf-8?B?dlRRTGRvT0taQXRObTVwbjFKYXR6Z20rNGRhR0hsK1JQalFhVEo4bkdnSFIz?=
 =?utf-8?B?T3VsenpUQWVITDRCRXlXOVN0SGwwR0xaRDZJYisyUVJXM2syclFWZkxnY3pw?=
 =?utf-8?B?ZEZpRU9YbWRTby9wd2VZVnI4M2hmSjUzWVZWV2Y0amk4eFU4bWIyMkwvVytY?=
 =?utf-8?B?Wm15MzEvSVIwaHhOdTdON0xLZ2xiWjBEalJuTzFsdE1iNEhIRXRIaUpNaHdJ?=
 =?utf-8?B?WGVsZXp0MUVsbFFRcFY5Wm90K1I0U3pJZkpSbHU2Rk93V0JXQXBUL2p1ZjVF?=
 =?utf-8?B?UTJuWEJka3BMaVp5YTVJUktFazd5WTVVMk9wZU9kejk5NzEza1pBNUVRZ3lz?=
 =?utf-8?B?Vm52OVUxT29ITENpcXdTdExBeXFnem9TSjdaUzhiQ0s0QVVSb3hYMStRbXhB?=
 =?utf-8?B?RXdOTm5NVStTQW80VERDVVlxalpxWVZBSmhFNm1aQVQxRWtKWksxTHJkVTdH?=
 =?utf-8?B?K2dza2Y5NEIyM092V0h1cnUwd0dIN2U4bFJFVUVGUHJ6azRwc2wvZDU1bFFW?=
 =?utf-8?B?aHFuMjN3UTdCN3NxdDByNDFxSDVRNktGRm0xYmd2T1ZybFc4bmhWc2ZZU1px?=
 =?utf-8?B?cy9FT3dVVFpsUXhmYmxYbnY2ZFBIYkx6Z1AzYi9KT3l2eXZsRy9zbnZtL3Vj?=
 =?utf-8?B?VjZ2REFjb3RjTHVWSy94UXR4a1hEZUhqdWVEUnlYZDBsSm93OTRnS2Z6Z040?=
 =?utf-8?B?cExOdkJUaVdDWGVlNHo4ZWtlL2ZGcC94RHIwVXRsVkhmdU5HTDg2bXBBbk1K?=
 =?utf-8?B?OU1mUDUzc05CWUpCM3QvZFpzZFRycjZFVzB5a2owTUxFeTF6V0pFWGJMaVVh?=
 =?utf-8?B?aGhwNnN4VnJoLzNmc2RwdG1EYTViMmZPQ1VjRnc5OFNtdkp1eUlzUzA5NTlx?=
 =?utf-8?B?Z1ZESFA4ZVhSbVNwSU80RW5ZYktiNmNIV0hxbktvdFhGUHZlNGduM0RBN0lW?=
 =?utf-8?B?aitMYjlFeDNXaUZObm1KbU9xdVRQOTdLOUI1OExZY0x4djQ5SW5ET0JCWE55?=
 =?utf-8?B?ZnhtSUJ4ZC9QY1d6eHFXcy9EcWIyTHZ3dDJ4bldVKzR5dno1SGhiZEMwNGs4?=
 =?utf-8?B?ZmJjTUkwTmcvVWVDNmE0YlNoNWdLdWk4TWtMaHp1MlQwaUVlSXJIdlc0dWF6?=
 =?utf-8?B?WVlNMlRGWFhWT2pOU1F3bWFGSmNQTXQ2S21ZY0dzZm5GbEdnQTdqb0d1Wnhl?=
 =?utf-8?B?NGNaK3Z3SFNPWWQyMHp0S3R0eGhVeldZdWRyMi9zTC9JbHRPM1NtcHNleWls?=
 =?utf-8?B?Nm1WNXA0czVESFRiRVJyRlNMV1FTQnY4SXFyMkhkMlkvUktHWG1PTXJRMFZr?=
 =?utf-8?B?SEdsb2xZaUdUZ3ViaE5vUEFleGhEOHI0dUx3bTN3Qi8rcmRUTHhNek0yRnlD?=
 =?utf-8?B?U2JKS0V5UTVEVTgrSmpFYXJEdkFpays1LzRBQWpYQ0l1WFhNNnBXUmd1N2Ni?=
 =?utf-8?B?UG9Ga0Vmb041Skp6TWZMNC81bFVlTDhmQ25PNTYyZEJydnJ3czdWeVA4dWNU?=
 =?utf-8?B?bFQ1bWFZV2h6SE54eExHQ1FhbUQwUkx5VXZ2Z2Rna1NEbUFzV0lYbnZaVVlx?=
 =?utf-8?B?TFF0bFZQc0lUSXFrWkR1RkgvTW1MUDdVVVZjUldHWGRjNHNST281cVYzbUdv?=
 =?utf-8?B?WmFMVThhWDZjYjVjL1FWY21QYkpHVk85eCtsY1h5clFicENVeWJhb1VYWkRv?=
 =?utf-8?Q?oSWR/7KxsGCO96fcjB/Ugib5B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01445246-1d55-4790-7a06-08dcfe5df043
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 12:24:19.7452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A72cuYGchXryD1A50aF5YCWSANVClkkfivnVAiQaltBaMW1M1Jwvi1XfZAmenDsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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

Am 05.11.24 um 17:34 schrieb Felix Kuehling:
> On 2024-11-05 06:04, Christian König wrote:
>> Am 05.11.24 um 03:33 schrieb Prike Liang:
>>> The SVM DMA device unmap direction should be same as
>>> the DMA map process.
>>
>> At least of hand that looks like it's only papering over a major 
>> problem.
>>
>> Why are DMA ranges for SVM mapped with a direction in the first 
>> place? That is usually not something we should do.
>
> These are DMA mappings of system memory pages. I guess we're creating 
> DMA mappings only for the access required for the migration, which is 
> not bidirectional. I see we do something similar for userptr mappings 
> depending on whether the GPU mapping is read-only or read-write. Is 
> that wrong for userptrs as well?

I think so, yes. The DMA directions are there to make explicit CPU cache 
management and bounce buffers possible.

Since we shouldn't need or even want either for a cache coherent PCIe 
device we should probably always use BIDIRECTIONAL.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 6 +++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
>>>   3 files changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index eacfeb32f35d..9d83bb9dd004 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -445,7 +445,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>       pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>>>                mpages, cpages, migrate.npages);
>>>   -    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>>> +    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages, 
>>> DMA_TO_DEVICE);
>>>     out_free:
>>>       kvfree(buf);
>>> @@ -750,7 +750,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>>> struct svm_range *prange,
>>>       svm_migrate_copy_done(adev, mfence);
>>>       migrate_vma_finalize(&migrate);
>>>   -    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>>> +    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages, 
>>> DMA_FROM_DEVICE);
>>>     out_free:
>>>       kvfree(buf);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 3e2911895c74..c21485fe6cbb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -233,9 +233,9 @@ svm_range_dma_map(struct svm_range *prange, 
>>> unsigned long *bitmap,
>>>   }
>>>     void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t 
>>> *dma_addr,
>>> -             unsigned long offset, unsigned long npages)
>>> +             unsigned long offset, unsigned long npages,
>>> +                enum dma_data_direction dir)
>>>   {
>>> -    enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>>>       int i;
>>>         if (!dma_addr)
>>> @@ -272,7 +272,7 @@ void svm_range_dma_unmap(struct svm_range *prange)
>>>           }
>>>           dev = &pdd->dev->adev->pdev->dev;
>>>   -        svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
>>> +        svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages, 
>>> DMA_BIDIRECTIONAL);
>>>       }
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index bddd24f04669..5370d68bc5b2 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -182,7 +182,8 @@ void svm_range_add_list_work(struct 
>>> svm_range_list *svms,
>>>                    enum svm_work_list_ops op);
>>>   void schedule_deferred_list_work(struct svm_range_list *svms);
>>>   void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t 
>>> *dma_addr,
>>> -             unsigned long offset, unsigned long npages);
>>> +             unsigned long offset, unsigned long npages,
>>> +             enum dma_data_direction dir);
>>>   void svm_range_dma_unmap(struct svm_range *prange);
>>>   int svm_range_get_info(struct kfd_process *p, uint32_t 
>>> *num_svm_ranges,
>>>                  uint64_t *svm_priv_data_size);
>>

