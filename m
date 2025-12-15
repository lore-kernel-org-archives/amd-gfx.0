Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDBFD5B841
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 15:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB9A10E61C;
	Mon, 15 Dec 2025 15:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exdus2j4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84D010E61C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 15:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcEut/lE5ek9kDtB0l2YwKM41wN5o5UFpRZaljNG5Hgg0Mx3jfUv8uHhVo/dHTaAZNZiQ8WkYm2OnEszW8B6zLP4b/8eysXXxYzmcdM9NT4G4DL8HSBBOynkzEsSwnGjIjpODSpNSQ491nGI53PkC5xymx3jJJo7mMR5bu1bAvNFQxOyEqnZIiEBaJVGuR2qKwzKJBgqvpQ9E8e2wTuEieYvB2kZWZLrAoTrPpwbJ7h8GqrKtGsoT8t8r37cC2Fn/ZYzdnn6pgKtzf42IA1jDVPIwDTYfAkimjjSXEn1WdxDvhi+mueaxd7E2lmaV5Rj6wln5YHmJcd0YA58zsNDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBBnqQx1NcMjFWPEnMAsru6efAjNfra/9Q5Aw+zOMGg=;
 b=Y/nmWTCuq4XhyJ2ptbcj4loU329out7bDQfdNsMeI/GPywIMlmFPMwVuOzAn9Hg1TNn9Vpfm75tWF8EWsGqhAGeFwMstk45CwqKrQvm5Tk4YcZXHTzwHjMACRW/uVRuYRuPhJPoJnfO8G8i1Q5pMMjGHPnuZQ3IZPNhWHnGqaFA9qJuE/qhED2aJ4C5e8fL6YBNKbH4MO+JPnzZplPdSW2Bbxhm3JoJiD7wHWzteIbGXCaKqjy7ia4pTkN5NbYI0sBUesghLhftZg6O4ZZwRMBLBNa1/PJ3ts12GNrasN7F3wdC3akVs+m6UEdfAXZjBsfQNiQ5RXYEwDE401vFEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBBnqQx1NcMjFWPEnMAsru6efAjNfra/9Q5Aw+zOMGg=;
 b=exdus2j4wBYtN0bLFdsV1jDH+9FOYDUhusKdFgcZwZ1VA4P6TzH+ObgcaGHf1BAMqb1fu52/8OYB9PcSJEHJtrO/qdwFAyK3VgsF2/T48KHodVbDaqbZl5bQXoQpupAgRaVPsDFk175z6n67bqoNdKgnYulKGGamsEleFwZIRB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by LV0PR12MB999067.namprd12.prod.outlook.com (2603:10b6:408:32d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 15:50:44 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 15:50:44 +0000
Message-ID: <65a58cd1-27e5-4c09-8802-a58a456fde77@amd.com>
Date: Mon, 15 Dec 2025 10:50:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/amdgpu: Add helper to alloc GART entries
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251209234328.625670-1-Philip.Yang@amd.com>
 <20251209234328.625670-6-Philip.Yang@amd.com>
 <ee2f2f81-6b5f-4b87-bea1-e3ade42ec772@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <ee2f2f81-6b5f-4b87-bea1-e3ade42ec772@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::36)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|LV0PR12MB999067:EE_
X-MS-Office365-Filtering-Correlation-Id: a315f052-7f78-409b-04bf-08de3bf1b4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFVFbzZWMHdXekwwS25SQnFGbWs5K0lsR3FMRHc2dTdVc21wRjFLazZHaUtY?=
 =?utf-8?B?VXNEUlRHUmNOTmFxM0ZUVjM5bTNzNm5kL2xBZXBFbzk5NzNlZUthV2ROWTZX?=
 =?utf-8?B?U3M2Mi95MldlWVc3Qm11V2Q4d2ljbkVvc2xiS1I5NmhRUjhpV3Y0R1VPVE12?=
 =?utf-8?B?NTE4RklBTXk4NkRjWG5yaU5KYVlCMEQrZTZ3K1RTcXNpQ25tSFAwTzBkSmRN?=
 =?utf-8?B?RUdzL08zNUd4RVFEOEIvTlpHYnJrazFWU0tncG83YS9CcW1zcE1HbHdZTFVt?=
 =?utf-8?B?ZHk1M0tqSHRVa2pZcndtUVhJQlFQdVdQVkVNNWcvWUFLQjBXanN5WGRhR2No?=
 =?utf-8?B?OWlvRXRLb21aVFVxa1p5QWRSZDJGbzBlb2s2Q2RKaCs1NG5iRDlGdDlSUytU?=
 =?utf-8?B?S3JldWk2VmJpcDFYbHc0cTRXdy9wWFBpblVleWFVSFdKVm1wYmhaZFRRN0pH?=
 =?utf-8?B?blhxR3dCSTA2UGJNT3BLM2xEUDVRcFZ6N0t2YTB2Q0ZjYzg4VWh3NkhvcTJ2?=
 =?utf-8?B?SFpBWmdaSDdieUZlYmQ4UXYvQWtETEV6Wm1aaWpyVU9SejFEMUZqbi9qM1pH?=
 =?utf-8?B?TlRadjlqY3BidGtSdk8vUTdPQmYvd3JvaDl6YWIzQUY5bUxGRG8xcG1tMDRZ?=
 =?utf-8?B?aUZvTXd0eVJDZXlVZUxmYmlmSXB5THV2OGt2ajFDYzdXMzlJMTdtZXFXaGVT?=
 =?utf-8?B?a216NzkzMERSN1hkUjhCU1RsZ2haWE5rckcralR4dHcya2ZwbVZFbHNLNks2?=
 =?utf-8?B?Um9may9Wd3VRZk1HUFpLYmFwUEcyY1FqSmlXdnpBTUxTSC9HRGFkQzY5TlFE?=
 =?utf-8?B?REN1cFI3b0luVU9TMWd4cEI1Nk1WK0VEZEM2amQvTWZpUm4xWUdCcklYbVAx?=
 =?utf-8?B?a1drczdNWGM4S0tHZnRTMlBTcWFqdDVCRE5Na3VIOE51czB0MklxNDdNcTJp?=
 =?utf-8?B?UWFodDBySW8xNXRjY0JXdzEwVFN0UEhWWW5sVkVVZ3VPZGFaTW10eDZXYjlI?=
 =?utf-8?B?NndaUmVGQnBXWjNWcjJYbWpOZHNlYmNtUSs1djJCWi9SUnlFekowTUUzYmd4?=
 =?utf-8?B?VWt3bTN5eTBsUWkzeDNiWDRBT29YYXphaXlwV2NjYTBKMWltYzBZZm83eTZn?=
 =?utf-8?B?ajl2NXNxYnhqcjZBU1Q5MzlNNTlwYnFzNVVRb2pMYlEzMUdEeWJtb3NZbUVM?=
 =?utf-8?B?YlFBMkJpRkY4Q29qeHhVYnJXN0kySDk2QWxDZ2c3Rm5Objk1a093emJSRmtG?=
 =?utf-8?B?V1BYeWdVYmoyUDB1WUJhNzhDSHBobHRaSVZTRDdvK1c4SzZpSDZ6bERCcW9k?=
 =?utf-8?B?WGRWNzJ0enptSEZVYXpVeXh6a2k1Y1QwYjlVbC9QSDBIb085UXlIY2paQk5w?=
 =?utf-8?B?T0VYei80QW5iMW5lY0M5dU93V2JoaWhQL2x2d0JrZm9kVGJLQldsZjFLQ1hO?=
 =?utf-8?B?UWZiTnFkTEJ4aFZhZlZYaUpsemRaZ25TT0YxT3BzU0E1b1RPajE3dnJ2bHAy?=
 =?utf-8?B?b3RqK1lMb0Q4RWo5bGd3WTlSRERGZFBIMjRQeU9hSVI5TWJHd3Q3UTNzUS9Q?=
 =?utf-8?B?Vi9hN2hkYmsyN3BacGN6U1l3enhySjRRTTRxZ0pHL2ozb2U2QzdnTXR1cmU5?=
 =?utf-8?B?U0VVeHVicDV2bmJDZmJ1ZmRsWjBVQ1J0TmlFQVRGblYvYXFRNjdDMWhJcVRR?=
 =?utf-8?B?aDRJeE13NlhLOHkrNmpXalo1K09HWFMzcWx1eENUbzNRenBxNXFrMEExMFhv?=
 =?utf-8?B?SXpPVFNjc1I0SGtPNUxKOUlBWkJTL1VvUitqaWlzZTJkUTFGandoU3RudzUy?=
 =?utf-8?B?eEFsK08xRXdHODlORE5zejIwZHhUNUpxcWRhVEVRVEN1UWJ6SkxuK3F2YXNx?=
 =?utf-8?B?dGYzRWowaDBJLzZhQTBpRW5Jc3dwdmM1U2l2SG0vdW1UMGd0RkRkNXNjdERH?=
 =?utf-8?Q?ZWtj2mTrLyb/HBPKh/wtoO/IlilymGm1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhZREtJWU5FZUVjalJJTWFBaDlrVnB5ZnNRdTdSM3hOY2d6MjM1MEdTcUNO?=
 =?utf-8?B?bjcxbkNWRGt1M01pdWlUZDZ4b3ZvSXJESVdjYVdKNXozTnRQMC94dXpUWTFv?=
 =?utf-8?B?TDdyMGg5TUd5RlFrZEdtWWEzcWhqQ2U0UmhGMTJ0SWR3akluVXpaRmx0UlN3?=
 =?utf-8?B?UVIwb3MySDdjRW5DeWYzaFhzTWY0VXdTYzhxSmtEcE1IRDM3NXFoYjM0UUVt?=
 =?utf-8?B?dzY5L1Q5UTFuQmQzRHhpb2drSVVWT1hScUNJTkM0WlJRNlpPYnRabWJ1bjJj?=
 =?utf-8?B?Y3ZUQWNwQUxGY1pGVUtoVW1XMENJRC9JS2graEhvYW9mRE0vTFNDNW42S3ZO?=
 =?utf-8?B?Ym9FVkVQOURWK0lQNS9QM1lTeVBmcVlieEVaeTJ6VTlpRGVVMnZOWWxKWjVP?=
 =?utf-8?B?T0RDamd4Skg4a1BuVERvK0NCSk0rdmdNZmRidTJ5dkRYb3E5Y2RmUnR3Vnhp?=
 =?utf-8?B?OTg0NDRmb2x6MjhzeENmekRoMHEyV2U0TEw3a3QxWW1PSVBhZ2JqNGRuajI5?=
 =?utf-8?B?bDBIRmUrdnM4b3BqalY4bGQrN0N1NEU1bXVzV05JS1hYbW50ckVjYnZsNWlC?=
 =?utf-8?B?a0RZSnpJQTJidVFvWHp0UkdueGQ2WUpZLytGSytkY1QrNG9FU0M4aGttZkhM?=
 =?utf-8?B?VG9DcmhxNnNMTzZ1MWI0dW04SHN4ZG1jUTdZemF3T1JIRnAzUWtZM3c4YVIr?=
 =?utf-8?B?ckF1K0dxYVNDNW5FSjB3d0NjRHUyNkNRdTVNZHJCZ3dKVHBPaE5QVThKZzJw?=
 =?utf-8?B?V1JjaURGc1Nac1UzRU5ZeGZtYUw5ZG82Q0tmMzNrUGxQcjJTMHpKMjg1K3oy?=
 =?utf-8?B?TzhrQnVIWlZYOGtkbE9NSVJLTGhGalJYVHM2UFltNThYWHNMTzFxT1l4V2Jj?=
 =?utf-8?B?amVnSXl3MFV0SDYrNEU5U1pkZm1UaCtDSENDK2ZSaktOUEZmVXQxTnBCZHNB?=
 =?utf-8?B?SjhmQ2N4ZVBhU0tBUVlScFdGN2JYRDNCL0Zaa0J2NUxPaWE4eVUralA1QVdz?=
 =?utf-8?B?dXlsaGVzUjlEUDA3aXhSYU5zeTN6SDJhaFRVQjBjNkJ5TUNyUWZ4MHRRVE8x?=
 =?utf-8?B?dFpRNWRFSUFUbFV1Y1BKOGJpMHN0SFM0Z0JDMjhleUJOeHRRenZBL0I4Q2ts?=
 =?utf-8?B?WTVVcm8wTWdyVjQ5TXV0aUJLMlVCYlgyU3k0SE1vMURtMWttRkJ0WVNOOWl1?=
 =?utf-8?B?QlBQTGhkSitnTmJsVHQrSmU3N0NRTnk4d3Yzcnd1bjlSUkNsQTYvN1l3OTdv?=
 =?utf-8?B?amRIZlZNcVRnc0VvSUZ1Znc0WGhuNVVRRjlkekFOK0Q4dTc3aHlJTHE4TlAr?=
 =?utf-8?B?MzBqZ3d1UUZDVE0rL2E5VUhFbmQ4QjgrcFBLVS9tVmJ6U3JyNUdYWlIzTUlP?=
 =?utf-8?B?OEZuL1RXM0dFdUpzYU8yRTZRUkZFU1dnSGdEZ21XSmZJditiUm12ZkVWK3pI?=
 =?utf-8?B?cFFMbWdwR0pCeWlrcEppbzRLcWJCcmd6UUZ6NUkwSHNBbU5IWDc5cUVlUFJx?=
 =?utf-8?B?L1hJcUxsY0tFa1lvdjFqZTVJMEVGYTlQMHFqak1RTm5Fc2VxeGxITnpqSnhG?=
 =?utf-8?B?QTM0cFpGcXY5MXB3VVJxUHNxVzhoOUk3UjUxTUFxd010Nkt0d1pIZ0Zpa0dO?=
 =?utf-8?B?cGJ1bXRtRU52djVVYTlwSmdReURsaHFhOURWN29OSzRKNUV4aWdYUXNaRFVV?=
 =?utf-8?B?elpadDUxQW01ZzZqRDFRRTdFQ21PUmdSeXg0emRxZldxbGgxT0Z0eEZsT2dY?=
 =?utf-8?B?UTZEUjN4TDQrVkhCazZoK0l3VmxEMHhjZmJoN01qY1dBeFFhSVg1TEFZSVU3?=
 =?utf-8?B?aEhzbEVwWDJKUTBoSVFuVWFyZWVLdnZGSlZBZEZhMHJmSjFiNW5Da1Z5VDFz?=
 =?utf-8?B?aThSZS83SDRNS0Nmek05L3FtczNXQVdNdHZJZmNTSy9vQXI1b2VlT0c5b2Jk?=
 =?utf-8?B?TkdQQk1NYUh1MU9YaXhPcW1COTdROUtKdkZtQ2lZVlIxNGd1VjA2RlU0MU95?=
 =?utf-8?B?TXFuUytmcjR3Uy82SkFrNVBBSFZ1WS80YXZoeUhHQVk5L3BITzRHL01OWmY0?=
 =?utf-8?B?b2EyS3pYZ2pMLzhJb1hjS054cFBuaHVXUXV5Z3FBRjVRdUFYbWcwOE92R1Nu?=
 =?utf-8?Q?SxOk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a315f052-7f78-409b-04bf-08de3bf1b4d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:50:44.2380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH8bJMHVURKBz5SJeoOEi8cxImKeLJ1FSpGJamZLjOFjP3vwfP8cYFj/SlfMMNzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999067
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



On 2025-12-15 10:14, Christian König wrote:
> On 12/10/25 00:43, Philip Yang wrote:
>> Add helper amdgpu_gtt_mgr_alloc/free_entries, export the configurable drm_mm
>> allocator parameters to caller.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 27 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  7 ++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> index 895c1e4c6747..d21c7187e4aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> @@ -321,3 +321,30 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
>>   	ttm_resource_manager_cleanup(man);
>>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
>>   }
>> +
>> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>> +				 struct drm_mm_node *node,
>> +				 u64 num_pages, u64 alignment,
>> +				 unsigned long color,
>> +				 enum drm_mm_insert_mode mode)
> The color is unused as far as I remember and the insert mode should be hardcoded, at least I don't see a good reason to expose that.
>
> Any specific reason that was added here?
The color parameter removed in next version, Eric pointed out same 
issue, the new alloc color is hardcoded inside alloc_entries.

Thanks,
Philip
>
> Regards,
> Christian.
>
>> +{
>> +	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>> +	int r;
>> +
>> +	spin_lock(&mgr->lock);
>> +	r = drm_mm_insert_node_in_range(&mgr->mm, node, num_pages,
>> +					alignment, color, 0,
>> +					adev->gmc.gart_size >> PAGE_SHIFT,
>> +					mode);
>> +	spin_unlock(&mgr->lock);
>> +	return r;
>> +}
>> +
>> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
>> +				 struct drm_mm_node *mm_node)
>> +{
>> +	spin_lock(&mgr->lock);
>> +	if (drm_mm_node_allocated(mm_node))
>> +		drm_mm_remove_node(mm_node);
>> +	spin_unlock(&mgr->lock);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 72488124aa59..28511e66d364 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -141,6 +141,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>   
>> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>> +				 struct drm_mm_node *node,
>> +				 u64 num_pages, u64 alignment,
>> +				 unsigned long color,
>> +				 enum drm_mm_insert_mode mode);
>> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
>> +				 struct drm_mm_node *mm_node);
>>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>>   
>>   u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);

