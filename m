Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205B5C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 15:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E4810E6D3;
	Wed, 23 Apr 2025 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2IGaVzGs";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A3310E6D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 15:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2zVHgUsbe8pmMrbhp2seZAwmCazKrmSeB3gNp5bJoSM7/6XU9f4q+BMvDuEdlaLG7nDiRM/CBiy3bdTx3QexgnjuT47s7gSnS9/FXLvNr5QWCKYySfdnoLXznuWdsm37IVFkYOheYHU5X/BcSywzwmSMaIWlbJZIvHYITMI/DIVz6t3htLMvAic2MrBtCivG6gYvUJ9fP37xKDhOOLWUZZvKabSpVC1q0LI8/X6QJDBKppdn5dwoBY4jDG0Jum0IIJU8hErN52qjyX7sTmQfXnZVqQ3dfAebpNRyVFqVceRIGSWdXSAKQ6UvIDd8kcN5S+SwiP7Rr+Uto5adyVZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwvzaYMxiMUpJogBDkl7avBWce9f4snRuc7DMgpSx7Y=;
 b=pVKFfJw0pQRzKiSVscSlhQ1R0JPFqrK95JagEnKNHhF1uUCBqeug7siU9DVncs3KvmMhIvHTidcRTyemCf0dVswJVIB7327TYSg4LTJ9I7R8VW85U5PDRQmwshT96NES1PIZjeN2hf/cw/ynnO8zBhmZtnkavCDpr6fAnE+CEUMbvQQDquH5ZbBG5glupWpcf/YBVPeggZVjOnnjYXPLOP2xgbzUMhEEZRc8Hm1oD99OCRKwLjf/EmD7SD706HBNEVF94au471sWRdMKG+EF2umT4qkxSwUIqHNw3V9JCBwsESfcZV/rnDVWTx2Pw44rfR5F+P3oaAy6R/nsWHWf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwvzaYMxiMUpJogBDkl7avBWce9f4snRuc7DMgpSx7Y=;
 b=2IGaVzGsHE0VGISY/AfM1rJ5eS5kvt0pWh/FkTwKY3nQsGkefhwuFgCCRpCDgdpOmkYs9dZipAiBbEAZe7bV6ngpYcqZ0oF4pY5e7D3zyWAhww8v3Y8MmLlJ1su5ZCXVuOp3v+5ySu/BK2vuH1IRwPebMAPdwQvgaKIzvqiO+Nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 15:01:34 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.025; Wed, 23 Apr 2025
 15:01:34 +0000
Subject: Re: [PATCH v2] drm/amdgpu: only keep most recent fence for each
 context
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Yadav, Arvind"
 <Arvind.Yadav@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250423104824.7014-1-Arvind.Yadav@amd.com>
 <BL1PR12MB57537BB48BF34E8946B1DCC693BA2@BL1PR12MB5753.namprd12.prod.outlook.com>
 <b4a9ba33-ac0c-4261-9f46-4b2834b25409@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <bc72f57e-eb12-441e-874c-8c7b3f9c6123@amd.com>
Date: Wed, 23 Apr 2025 20:31:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <b4a9ba33-ac0c-4261-9f46-4b2834b25409@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::8) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b665e1-15e0-4111-d885-08dd8277bcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUhGd3IrREJla2NML3B5RlVmbzBTOFpuR1krb2VERmFnR3orMG5aNlFHbXpX?=
 =?utf-8?B?dENYcHlvVnpSbkZMaXMxckpnUWdPU2dKa1JzVnEwME83clBDeW9TUUJlTVp4?=
 =?utf-8?B?ZnBjWlM5WjROL3dYRG1CMHE0eGk4NHFNUGtyOFhCeUdIbWZqS1E3UEhRSVgz?=
 =?utf-8?B?RnVjb0UyZ2JqdE9HeWtNV0k5UUFyR0EzN0l4RzRUdW5mbjh0bUJ3MHdJQlJi?=
 =?utf-8?B?c0FjYVpHd0VsK0h6V0N4WW54ZUhGaUhkUHdGU202dDZnSkNDWnhyT3hCQU5k?=
 =?utf-8?B?MlNTN3dKN2hkcXhUeVd0TGhxVG5CS2d3ZGZRSm5FOXA0bUU4aXNtaXUxVUhV?=
 =?utf-8?B?Tnp1YmU5OUtxdHdDSkE1VW5BRzYvWElOWlJNYWZwWlJwTm9DNXYvYS9kY2d5?=
 =?utf-8?B?TktvOXR4R0poRGhzR2ZRblJNOEVySW5BenVlQkhPeDZVSER5L2Q1T2o5dTZl?=
 =?utf-8?B?Tm9YMjRsemk2ekpjNjYzcHRPaUY1ZmIxT0Z3TnhKLzRHaE1tTGt4QlZYQUNz?=
 =?utf-8?B?RFFvS2JVd1JpVGZCajk1TEZPc3lsalhCb0Z1Mnc5MnpubjlsVm9FL3B3aW9w?=
 =?utf-8?B?dm13N1dKV0tZWmNna1k1cHZ5ZHdLeEVEOFVBRDRRM0ozY2JENlJHU0g3d05q?=
 =?utf-8?B?ekNncTRucmRhdEtBelp0Ui9DeEdUaXF0b3lMSjMxWVJoa0lzMldoMTNyVnl1?=
 =?utf-8?B?MHh6bE9BQzMxVDhQWHk0ekdOZ09WMkVlNU1sRCtJa0tUQUN1UXA3aURsUHg0?=
 =?utf-8?B?b3lSVWU4WEVMdGdyOEVmVE5kVnBhMnRQRGEvaUQ4NWhBZVFFSFFUbTkydDRq?=
 =?utf-8?B?eXl4RCtvanVONWpNZVRVYTlkQWZHQ0xHVzgwNG5wTUpMRGhjZTUrRVhocHFC?=
 =?utf-8?B?UUNtR3RrMFA0RFFVQ1Q5VytFZ094cGVIWFpsY3pwdzhJcjZWUlRQaDhzajdI?=
 =?utf-8?B?MzQ4K2Q5OEQ4a1JWSzNqb1dmamxEekxadFQzNnRPK0JRc0wwRXU0aStsbTZu?=
 =?utf-8?B?QSt0OVh1TmUyam9VY0VnMWZnL1dRMU1JNFAwWGgranBqb045YllyZk1zckhl?=
 =?utf-8?B?QXhiS2hVZmgrM0hSS01HbjVXanpJeURTL1U3TjNNajBGTktoOEhXTEN6cEhN?=
 =?utf-8?B?UWVZNzhVVUlrMTlIWDZjY21ucS9CUDJhYlRaS2lwRVVHWlVlMEIwVHN1eGdK?=
 =?utf-8?B?dHVpSWh0Njdra2xHcXAyOWxRRXVYZ2pveG04emE3SmRkc2I1QWVJeXRCakhH?=
 =?utf-8?B?U1BBOFJRdTlLRTZPMkVMVGozWlMzZDBaSzI3b0VrUko5ZjAvZnlMOHNPTFpw?=
 =?utf-8?B?cFNWMmVqMlFucVZXeWFBTkcrdHA5VzJwRldnSVdqazRQWDVwS2JZd1dHQnRn?=
 =?utf-8?B?aFRwQkE0WkF3UUFqVGJ5dm90VUtnZE5Nek9PaHZieHpiR2l4c3kzLzJoM0Y2?=
 =?utf-8?B?anVENnY5Z25wTUVpcHF6aXNHTk0rcWsrZlluZ0YxVUh4cTNtY3o0bnY4YXYx?=
 =?utf-8?B?eUZVdVFZWnhhV2tjVmtMV3k1Wmp3NnhyZmxPR25mUnFWbWFxeFRoSFIyRkxW?=
 =?utf-8?B?WWVVMnBpT3hHNWhjZFNWWCtpWko0cjBRNGtHUFlHQWlvdDBrRWw1bW44a0NK?=
 =?utf-8?B?d2lMNTlhUjI4azdQSnNEbHR3WlY4ZXVNeXUyQXlRQlhzZEdtUWJtY01WT1lS?=
 =?utf-8?B?SzJpdTcwTm9lZVlUSnlSeUFlNGk3ZGl5M09RUS9TcFd4dW9QWnF5TGtBWlhV?=
 =?utf-8?B?amwwbDc0KytEV2NITG4xN2ZzR2lxNjFYVzVlWTFMVXZobmZYbjRYNS92Y1l2?=
 =?utf-8?B?VExEMTAvVHpkV1dYUXhaT3BJcG1LaGJFQ1FzWVRFOXdIbDlpUFpUYk12TWtR?=
 =?utf-8?B?eit5T3ZkMGRtOVFnVXVYeExJN014cGk1a3hlSFQ0NjV0T0xSUS9wZHE0NEk1?=
 =?utf-8?Q?wkZubhE+f8I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXVYWHR0WEFWUlZLbXJiQmZIQS9sckdFNm9JMzd5TXZFTGRRWTYzeHozN21I?=
 =?utf-8?B?RG1BNVhKbjhFK2dRdEV4U1IrSDRoNlJITUQvMmRKOERkSExwWUVIYVhzVDFm?=
 =?utf-8?B?Q0x0TFpTZnNVU2crU0xSRzg1NVdiUll1dzFZdytTVUxEc1F6RlNKMzNST2tU?=
 =?utf-8?B?Y0c3aXl3VVE0U2lnSzIwVG9Uc0F3NHlwcml4c0x2M3BTMlBHNzFCSFdodGNo?=
 =?utf-8?B?YnpXTTFwaFMxRHM5UUxZMnhDN1F0bWtPMkZILzZaU1JnZnE1Y1UzcFpsemNw?=
 =?utf-8?B?bHFLc0lsWnhFT0gwc2lBZE5QNjJYWVNUY0VjQ3ZiakxBUFVSK3RGL3VROVgr?=
 =?utf-8?B?MkNXZ0o2Q1lJbU1XakxKMEphajBtbkJmSC91SjI0S1Ryek1SVjNYcFp6ZDQ4?=
 =?utf-8?B?RjJZNGtheFVhanlwREtsZVNrL0tUSWp1Mk1FVkpmZDZuT1FsaGZGVi8veE14?=
 =?utf-8?B?Mm1sd1o1WUprY1d0TGFJTTlaZEVVcTBrM3hEb29ZdXMrSEdiOWlQVmxUTGNB?=
 =?utf-8?B?VFAzNEw0Nzg3em5rSGJQU3oxNnBXSDgwUEo5ZlNMc3kweWNSaHlrZXpSNUZx?=
 =?utf-8?B?RWsxbWc0VmhTeEZFdm9pSHQ4dk5zSU1jVCtvbzZFVkdHWmtsdkRzTldzbUNT?=
 =?utf-8?B?ZnJwdFd6NStETEg1eFdmZTNzUHppdGxyN1h3RExpZm1wcHhHbzNiK3dpM3hn?=
 =?utf-8?B?TnpRNGlPdU9uUFltQXZzVXBubGpROGtRU29zWVZkM0pOZFZKUEprcS9ZMG5k?=
 =?utf-8?B?NWRGVGpsa0ZSUDE4Mm5QbWtZU1JKYm5FanM5YTIyazNkOC9ZZlVtbXhEV0xn?=
 =?utf-8?B?bUxRQTlwWmE5YnhINVg0elc2cDh2a1FhNk9vSWsrZXVkRkZ4cnFTT2hRUTIy?=
 =?utf-8?B?SUJMRXJWdDRKdGt3dkhHaFRHckFpSmRTU2dMVVNETDIrc0ZNbGNISEJ6SUZ3?=
 =?utf-8?B?Uk9nckNPRlZPZCtIdVRpalRlVEdRMlZhUDNsak1YVjA3NGhFWkttbXMxMnlz?=
 =?utf-8?B?bmV0RGNaQ1ZHNjlSWDZwdW4rZFE1TUgwTmRiOUZTSzgwdHRVK3AvTHliQm1N?=
 =?utf-8?B?THBnZFpLUTRDMnJ0alg3cmNKeUpCdkZIS3JudXdPZDlZdFZ3MTR0Z0xhaW9N?=
 =?utf-8?B?UjBhNjRnTnRUckdQRHoyZTBOSmdzaWdNZXhBZUZHTHZQaEUzN2NER2tzM2hZ?=
 =?utf-8?B?MFROSFBOMnVEVHRVZ0xyZTRIOWJjL1cxRDkvR0gwdXM2Y091ZitHeElOSkRj?=
 =?utf-8?B?bm1STFFTbldNN1hycTJvckROZE5tV1I0RlJtbFNsRUpCMlZpbWMxeGZHd1hK?=
 =?utf-8?B?RGlzbmpJd0dwQm41YUtYaUR6YmlRSXpQeEd6VGF4K3k4eTREeHkrUXlvNUZP?=
 =?utf-8?B?K3VHa1JvNW1ISnc0OXMrcWFjMTJkUHR6WkhiMjMxdkdYayt5TDQ0OGp2b1NH?=
 =?utf-8?B?SU42eGY2VTJSUTlmaFYyWU44QnYySmJiOG9xL3h1cE1RWktoVGp2L0pYS1RK?=
 =?utf-8?B?ZGNHSlUzT0RsMXYza2o2S29vdWJCTHArSWJUQ0t1YVB1VUtYMDN0MWRPMU0v?=
 =?utf-8?B?Tm9vY0lGOUczNDZqcHdkOUJUZThOcWkrSFlSRFA5elI2QjR0QjRCWDBVTlh1?=
 =?utf-8?B?dzA3QnR4MFQwZmQ3N0h2QXIySVBFSUFHOUdiOXovRW95NXhyOWhwYWFPdnE4?=
 =?utf-8?B?c21yM3RqeUY0SzV1dWFHQm5pUkdpMHlVSXUydkFWNnVFNk5EcmxmZURIdmRB?=
 =?utf-8?B?a1FCeXN0MllubXZpQ21FTWtuc050UURuOHJLTVV6MVFrZmpKc2hOQTgxczNU?=
 =?utf-8?B?aU5Wem12a2I3T0xtK2paMnBOa3dLS2s2bHhvOGtWdkJKelRpTm02VllpeVJT?=
 =?utf-8?B?MXVPL2Q5QlFkc1BWZXBOUHF6WnQwSW5EZDRmUlh6L1ord0lVb05lSkUvbzU2?=
 =?utf-8?B?ZTVRZkd5ZzFMRkRWTndQb1NrR3Q4cXl2a1FRVkNob2k1bmZkYmw2aXI1M0Rh?=
 =?utf-8?B?SXowZ2w3SXRRSlZNWld5d1pla3BrZEhQZWdTa0grb0VjcGR3THF5dE5KbHZ5?=
 =?utf-8?B?My9RY2lBYVJtZU9GV0NsVWVFM2toWHhaM1lLT2ovenJFd2g4TnFTYXdiWmwx?=
 =?utf-8?Q?+U76E9vn9jzkHAXhRDTnyQlje?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b665e1-15e0-4111-d885-08dd8277bcc5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 15:01:33.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdoUp4y8NkfIz/aqmcaB8MZZAc4ljQNeiaCdIcjm9Vp2F7P5wE9ug/+Zj8Fn/eGtxml8a7pGVTzeUWJ4RhUStw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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


On 4/23/2025 5:43 PM, Christian König wrote:
> On 4/23/25 12:52, Khatri, Sunil wrote:
>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> You need to split this in a dma_buf patch and amd userq patch 
>> separately.
>
> Yeah agree, and the dma_buf patch should re-use and re-structure the 
> existing code and not just add a new function.
>
sure, I will not add new function and try to re-use existing.

Thankyou,
~arvind

>
> Regards,
> Christian.
>>
>> Regards
>> Sunil Khatri
>>
>> -----Original Message-----
>> From: Yadav, Arvind <Arvind.Yadav@amd.com>
>> Sent: Wednesday, April 23, 2025 4:18 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; 
>> Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Yadav, Arvind 
>> <Arvind.Yadav@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; 
>> Yadav, Arvind <Arvind.Yadav@amd.com>
>> Subject: [PATCH v2] drm/amdgpu: only keep most recent fence for each 
>> context
>>
>> Mesa passes shared bo, fence syncobj to userq_ioctl.
>> There can be duplicates here or some fences that are old.
>> This patch is remove duplicates fence and only keep the most recent 
>> fence for each context.
>>
>> v2: Export this code from dma-fence-unwrap.c(by Christian).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/dma-buf/dma-fence-unwrap.c            | 29 +++++++++++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  2 ++
>>   include/linux/dma-fence-unwrap.h              |  3 ++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/dma-buf/dma-fence-unwrap.c 
>> b/drivers/dma-buf/dma-fence-unwrap.c
>> index 2a059ac0ed27..18874eedf091 100644
>> --- a/drivers/dma-buf/dma-fence-unwrap.c
>> +++ b/drivers/dma-buf/dma-fence-unwrap.c
>> @@ -179,3 +179,32 @@ struct dma_fence 
>> *__dma_fence_unwrap_merge(unsigned int num_fences,
>>          return tmp;
>>   }
>>   EXPORT_SYMBOL_GPL(__dma_fence_unwrap_merge);
>> +
>> +/**
>> + * dma_fence_shrink_array - return the shrink fences from fence
>> +containers
>> + * @fences: array of fence
>> + * @num_fences: number of fence in fence array @fences
>> + *
>> + * only keep most recent fence for each context. It will remove
>> +duplicate
>> + * and old fence of same context.
>> + */
>> +unsigned short dma_fence_shrink_array(struct dma_fence **fences,
>> +                                     unsigned short num_fences)
>> +{
>> +       unsigned short count = 0;
>> +
>> +       if (num_fences <= 1)
>> +               return num_fences;
>> +
>> +       sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
>> +
>> +       for (int i = 1; i < num_fences; i++) {
>> +               if (fences[i]->context == fences[count]->context)
>> +                       dma_fence_put(fences[i]);
>> +               else
>> +                       fences[++count] = fences[i];
>> +       }
>> +
>> +       return ++count;
>> +}
>> +EXPORT_SYMBOL_GPL(dma_fence_shrink_array);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 3288c2ff692e..cc74bb0ed06f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -851,6 +851,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>                          fences[num_fences++] = fence;
>>                  }
>>
>> +               num_fences = dma_fence_shrink_array(fences, num_fences);
>> +
>>                  waitq = idr_find(&userq_mgr->userq_idr, 
>> wait_info->waitq_id);
>>                  if (!waitq)
>>                          goto free_fences;
>> diff --git a/include/linux/dma-fence-unwrap.h 
>> b/include/linux/dma-fence-unwrap.h
>> index 66b1e56fbb81..94801feeee4b 100644
>> --- a/include/linux/dma-fence-unwrap.h
>> +++ b/include/linux/dma-fence-unwrap.h
>> @@ -72,4 +72,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned 
>> int num_fences,
>>                  __dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, 
>> __c);    \
>>          })
>>
>> +
>> +unsigned short dma_fence_shrink_array(struct dma_fence **fences,
>> +                                     unsigned short num_fences);
>>   #endif
>> -- 
>> 2.34.1
>>
