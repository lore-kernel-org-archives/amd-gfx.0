Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CD0D69115
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 15:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C338B10E247;
	Thu, 28 Nov 2024 15:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nj7ELI8F";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E0410E247
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 15:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cesDr0VWw7LTElkYMxxXUnJMnOu0foEjE6Nb6Jh9Q1gTn1CnY9UpTXbllN5CsbGKTD+CkPecKW2/AP97U00HaLqAqJ/AUXKA+ttr5ZJZ571lAvr/jgVHzyXPKezz++PBdXIHUHUcc/9JzF2kaGfm7DgFHETx9p2lo6l530IkJIInPYO5UWshXuiGAEH34Js/CBF0cQTQjXP6TuwkMmAD1i5Ye23lEZyGCVIOc5iWByFJ6c4JOV3UMscWibCPlJCttd8VKBt9B3tCacHg6bK5zziQbs/OsQxsXOfghWGPmcqOS00WzC47I4WNBjJysZ4uwHpxiTA49nRJCdgyszJb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRJ2FVVFbDCJpDXufxgBKR+xtzY64LZvYyAdBTqC1Iw=;
 b=R6YPkiu/IXT+Te6ckVPTZ/l33r3rVfrPpuVuTT89pRIBAvpShp4Fr/QHa0QHYjCYSNwetIAZxISEvgoNUVTwuZQ4SCGsovVyK7WY1C/QPjz7F8uInmfXTk/v26asNBqCTGRqql6nAkou5qO+G49jZamOpIV4bPcey/O/7eRWvaijfDSVMn+N6ejkumuUN5U7kLuJKI7UfTFk4ELH9loq4h36kurgGB05eNY05hUlnpGZALm689PjsthhnwT8lPw78AcPNpGxsiWhq8UTx+7KZ0ki+5WR7Y9sUWu7dLK+VWUpLyy+Z9ktRl0qtJsAWEUbcPwerlBHkXDyomVOcnAjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRJ2FVVFbDCJpDXufxgBKR+xtzY64LZvYyAdBTqC1Iw=;
 b=nj7ELI8F0zoKLtLANLEAGc8UPq3a5TgYfLgBYTizjtrEnPAerBmB2No4rB5Ou4DLsoc5sMm5c9OtRntT7vOKV3jyJ32mz+/XXVOr+RZJkv99wS0heGUVT/yK4UjZuZxeMQz6G4xAOaqN213dgCJqBo0om1vUjXK9zLaP3hwt7t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.14; Thu, 28 Nov 2024 15:21:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:21:59 +0000
Message-ID: <3d0e1c32-3a17-4d45-a9d7-9347db9bd1ea@amd.com>
Date: Thu, 28 Nov 2024 20:51:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Use the correct wptr size
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, mukul.joshi@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20241118053434.3382003-1-lijo.lazar@amd.com>
 <7fb86a69-aa43-41fc-90e9-4750c84a3a89@amd.com>
 <a8cb1cfb-bdc9-4e56-8a11-bbe8f311fe6f@amd.com>
 <5116ebb9-e0d2-4525-a3ca-ca5f254b3cce@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5116ebb9-e0d2-4525-a3ca-ca5f254b3cce@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: de80866d-eb99-4482-77da-08dd0fc066b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWY5aGttVU9MODNzOEw3Y1FzYjByMmpkblExOGhnR0krZjVmZE9ZbWsxSU9O?=
 =?utf-8?B?MVdkUzY0eHFQR0VmdU94emFDY0tLTkVmaHZQbGlJbXljQTlQYnNGUXVodGU4?=
 =?utf-8?B?L3B4d2Y5NGpLZW9yQ25FaFJmU1FXN3B3a3lzSFE3c1hQRXV2OVJEMXM3aFFz?=
 =?utf-8?B?NXQ4WnZteTc5bm5MRDR2UkdiVzlMc1pNY0c5WWV5NjFmYVBXb09QTW5XQW9k?=
 =?utf-8?B?cllZQWczdjIvN0N2V3hKT1Y4V2UrNnhlS1l5cDVodk91YXQ5R0wyK2RWOWoz?=
 =?utf-8?B?RllmT0dBSmRkU0cvTGgrUEd5WnVFY0JpTkprMkJFZnB0WENYV2wvV2Z6eEJq?=
 =?utf-8?B?VE5EZkd1UzJ6Y3N3enRwbFBWVGVxTngya3NMekE5YytpOU5Ba1FkR09XR1Qy?=
 =?utf-8?B?RTlhTW9NYjYrVEJoSFVxaGp2QzZHalBKWGJWMDlwZ2xJbVJLVU93L2xZRFcy?=
 =?utf-8?B?enFvcC8wY21HbzNIUi8ySDYyUFpMcnhOZEs1dTRSM0ZpSjg2aFgvZGJZeVVv?=
 =?utf-8?B?alFib2ZwMmIwUFg2NTRWY3g0QWZDTnlWcmk4RWk0b3ZwUnNuS2dDbEM5Z2lS?=
 =?utf-8?B?NDR4TVVrb1pjT2VCNDdvL3pua1NXNmd2cXpFbU81OC9mYnZqallwQWYxdm1h?=
 =?utf-8?B?NEZJTnR0Y3VrcjlQYUMvQTFnNW1PeGVZUTVWYkpRODdSV1gyLy9TdnpGbFBl?=
 =?utf-8?B?TFJ0d2MzdC9MRDR1b1VNZ1dFaUtucFVQcVBFOW9xd21HZDE0b2FBVFhneUFu?=
 =?utf-8?B?dEIrUytQS3FiblVGM1hTWU1yT1RrajBMNlVVamlQS1QyMGU1TGJiU0FpU01U?=
 =?utf-8?B?bWNmSXRwQzJJQzVPTFBoUnJUWDlLY3k1d2pKQXptWkU1T25FV2dzRDNucUN3?=
 =?utf-8?B?WVpFZ0FSMXhmeGxzdUVJb3NyRE44ZWdBc2J1K2VZZUVGbkVlaXdhSFluRnhV?=
 =?utf-8?B?YS9JWlQvWkZucWN4Ky9tL2VrS3dKa241YWR6OTBEQXJ5cWRYS09zUjBiOXo5?=
 =?utf-8?B?ZWN5S0l5SkErQmI5eWpvUDU1NEgvRHRnVTVocEdsQmVXQkJEWlFpSW9QR0Ir?=
 =?utf-8?B?UVRmYVF5MG5ha0s1ckNBRFNsRVZSc3VKaUIya29UZEtDMTgvb1pxV2VCbzRh?=
 =?utf-8?B?bjhSYm8wY0U4bEp1Tnl0VnNSRXZUK0VpN0VaQ3NuTkt1dmtrR2srZnZOd2xG?=
 =?utf-8?B?M2pxUGFBQzNsNEhubFo1eFpEZjd2UThOdVNUbGZWZ3VjZTNqNklIWkFZK1Nq?=
 =?utf-8?B?K3hST1dkQkRKbG84ZGFPWjJ2R3ZOQm1IUDlPN3YwWHA1Yi9QSFpUNXFpc3NE?=
 =?utf-8?B?NElhMGVMaUJiRXFQTVBrcUd1UDUzbTZvWERQWDBpemxpZjNkbWxKbWR2Z1Aw?=
 =?utf-8?B?QWpBb1RITnhNREdOYWJ5K2k4UUZUTWVtbGhzZmZYbW1Wb2lIcVpHSmdqRGd2?=
 =?utf-8?B?dk5DVUl1K29MN2ExeUplUTU2MzVTVjJ4Ym5ZWHdhOFI4RWhTUE1mMGxhT3Fl?=
 =?utf-8?B?MUVIc2JIcHpCSWgrdDM3M1FVRjI4V3ErRFRUM2ZnbFVFbHdEeEhCUURydlBL?=
 =?utf-8?B?NjJ5akE3aGUzTVNodlk2bXNFcXV5YXFsZFFIVDdGU3JLR3MweUZ5dTFQTnNY?=
 =?utf-8?B?QjhhTnR6Wi9hR3A0eStRVGJqSW9XMVdsSWlsUnpqRnNpVE5CRDlNYjUxcEdo?=
 =?utf-8?B?eEV6cHZ5cUtoejA4MHVLK0E4LzN5NGQ0KzhFY1c0cEgzUUpubGhTRXU3SGxs?=
 =?utf-8?B?ZlUrYUpqZ1JRNWVBOHhiVzZkWm40d3hRQjVtSmlsRCtKaG81WUsreEoxK25K?=
 =?utf-8?B?c3NDaTROTnQzcTdSUjVQQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clBmS1p3TFJUNnQ3ZzRkRVNISWd6L01wcmhxeXpDYXMwdmJHdFlQekdaL3pr?=
 =?utf-8?B?cXJpcE9Ja2ZTdlBMcjVCSHFRamVtQ3pGeVY1b09jcUVISm5uRHZVNE94MUlL?=
 =?utf-8?B?TmlmQzFESjVzYmpUNkJ3bGJlRStsUWhtS3EwcHRNRzlPSGJWMXk2TG9LNzMw?=
 =?utf-8?B?RXNQa2xzbGhtaGVXVCsySGVQKytWVjZmZGRsZHdqWnU5U2ZFQzAzNVgyZUZQ?=
 =?utf-8?B?aENGN3E3WXBtQlJ6ZXR4SUQwd3d3UUFtbmQxWXZ6cmhaRXJpdHhwUFJPcmJz?=
 =?utf-8?B?S1FXaklmeGg5NnNDdlBhQWJWbk53WDNFUWRHYkk0KzFYVWN4eFJaR3RSZzlQ?=
 =?utf-8?B?ZC9EUWtrREw3THYvelp1N0lwM3QxZVJJMXNycVFuZWZwcFF4VlpoVE9Hd3ZP?=
 =?utf-8?B?dXFPd2VWQ21xVXpKbENGWDNYSUYyelVHSmUwaG9RalY4Ni9FQUpnemhzRksx?=
 =?utf-8?B?eHhIKzM4eFRmS1oxekhLVnU0VUN4emF6MVErakJwTUlJR0tmV0IxRk9yVXBU?=
 =?utf-8?B?cmFmSFF0cm96SnZzY1lXV3dlbVNranphTUVSNEJaWExxT2QrVHRMQUlKY3Jl?=
 =?utf-8?B?d3NRQXk3V3lMSTQ3LzVzRUdSOXVSSmUvcDl2S0ZuTUltWTNldytpTUQxbE8r?=
 =?utf-8?B?QXJqbmpTSXZISWNXcUkwM0dsR0J1ckVjVWZqTzk5bHI3NTE2czJLOE5wbVBk?=
 =?utf-8?B?MjExVnlPcHhTdmdQVkcyY2hGZno4TVdLQjFmUFRvMy9RRU95VjVudEdnOUpI?=
 =?utf-8?B?UyszZjA1d3JZNGU2Z0JjY1ZoN3FnY016QkR4YWUxRll2ZTBIaHRRZGJVK2dr?=
 =?utf-8?B?KzIyaUp1TTk2NDdVdkJFMjhTeTVmMnBNbGFKdFZPZng1ODloOWdDL3h6MDN4?=
 =?utf-8?B?VmNwblBDTjhBbmxBRU04OFZJZHVkRzAyYXh3eGN0ZnYwVTQxSHMvVUtNQk1H?=
 =?utf-8?B?cEFnTlVLb2puN25jeWxLK2ZqNGl1dGQ3M1hlNWcyTEJranhHby9jQjNkKy9n?=
 =?utf-8?B?UkpGRTRmZXF5VDNicmZJcXhMTDBCdXBHakVwM29TQW1UaGozdFJETGN6ZjUw?=
 =?utf-8?B?WUthOXhBUlYyMTlCS3hJWUVXS3oxVUY4T1M0a1dCTmZBSjJSVE9KWDg1TThL?=
 =?utf-8?B?a2VpNHBZZUEzbWVQYzY2cHo3azloNDMwUjBKVGZacklrWDFrTHdVakc1OUo1?=
 =?utf-8?B?cHlIOFdMNUpCTTZWNkUvOU8zQnRLcmpvVTcvT1Vhb0JSaXRQWWxGOVRnRmFy?=
 =?utf-8?B?ZDlRckFXWEVRaWVqeXowVVBCRXVQbFB4c1NnNU9rZHpFU29jV20wN0hLTzRp?=
 =?utf-8?B?YjNFN1hBVk9QNDdkMWF6OU40RHk2TXV0UHZhenlHNStwc252OGJtaXlPTSts?=
 =?utf-8?B?bHdFTXkvVngra2dPTGpxdklFMVFLMWJWUmNKYTA5V0dxelBpMVp2SWF2QUtO?=
 =?utf-8?B?S1d4Y2VVTFJhMnZEbEx6R0l6My9NUkxiZlRqSGV6YW9OV0tSRUM0Nll5b1pB?=
 =?utf-8?B?UnFDYno2WFNSUG9mVkR4WjVCV29LeTVwRjRlTUliYzE4eXpyVG51aSs5clJH?=
 =?utf-8?B?M2FBNW1EYUZhbGFFVTFTKzVPeExWcGh2dDRRM09ZaHJ5dXRRMmxxOGhOdUJj?=
 =?utf-8?B?bkR5Qlk1SjVzM2lYaTFxSDltVU1pLzIzbW1uUWlzdlgvN3p1VnJXd2YvSmVC?=
 =?utf-8?B?VFl0Njg0QnRGdFlVTGQzT0tISWptNTN5cHRUNTkvWnV4R2lvc3dmcmV3UGpG?=
 =?utf-8?B?cmt1cHJrNXBkU3krbTdvbUJBVzNDTFZETnFFT1V3Y3FVKzhubEhiNWluaVhB?=
 =?utf-8?B?cWZwM1RnR1FQS1BEN2h2alRPL3UrdXhxOUpPclcvdDB1RStWUFFlZGdCOVpC?=
 =?utf-8?B?NDRlcDRYTDRyT0xpN2JyTHJ2cGxxQ2ZGaUYwOFYwMk1uNVR2cWpiWVVFeGg2?=
 =?utf-8?B?RG1neWRYU3FGeTgrUTZ4M0wxbnY0ZUdlMHN0ME0xL0gyQzMrbm9uQWRJQzJY?=
 =?utf-8?B?MnFUWXZLaEVUcmxONGdldWhjZVl4VGZSSmV4SEE5MnFHK1BPQzdvQVNqL05r?=
 =?utf-8?B?WW1ueUE5Q2dlc2E3NkJ0ZE5Va1hhSGRxKy8wVGRjVmZ6ZmJMWnlla0EyMlVI?=
 =?utf-8?Q?yASc27bWjUoQQE6tXN/8ZUZTx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de80866d-eb99-4482-77da-08dd0fc066b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:21:59.1632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6nfnkuPw+nO+VHp3DuqeaUiyh6B1DhOQrNganKMQvBtaZnNiyhl9t8Ncimx588c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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



On 11/28/2024 8:12 PM, Felix Kuehling wrote:
> 
> 
> On 2024-11-27 22:45, Lazar, Lijo wrote:
>>
>>
>> On 11/28/2024 5:43 AM, Felix Kuehling wrote:
>>>
>>> On 2024-11-18 00:34, Lijo Lazar wrote:
>>>> Write pointer could be 32-bit or 64-bit. Use the correct size during
>>>> initialization.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/
>>>> gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>> index 4843dcb9a5f7..d6037577c532 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>>> @@ -125,7 +125,7 @@ static bool kq_initialize(struct kernel_queue *kq,
>>>> struct kfd_node *dev,
>>>>         memset(kq->pq_kernel_addr, 0, queue_size);
>>>>       memset(kq->rptr_kernel, 0, sizeof(*kq->rptr_kernel));
>>>> -    memset(kq->wptr_kernel, 0, sizeof(*kq->wptr_kernel));
>>>> +    memset(kq->wptr_kernel, 0, dev->kfd->device_info.doorbell_size);
>>>
>>> It would be safer and cleaner to just initialize kq->wptr64_kernel,
>>> which is always 64 bit and aliases kq->wptr_kernel.
>>>
>>
>> It's done this way because of aliasing. The size requested is
>> doorbell_size which could be 4 or 8 bytes.
>>
>> By safer, do you mean to have an if..else check in case the aliasing is
>> taken out?
> 
> Cleaner because the size of the memset would match the size of the variable. And safer because it clears the entire wptr, regardless of the doorbell size.
> 
> That said, it doesn't really matter because the whole kq structure is allocated with kzalloc just before calling kq_initialize. So maybe we should just remove all those redundant memset(kq->field, 0, size) calls.
> 

This is not related to kzalloc of kq structure. This is actually
initializing write pointer value to 0.

The sequence is -
	Allocate memory for write pointer (kfd_gtt_sa_allocate)
	Assign kq wptr to the allocated pointer
	Set wptr to 0 (Initial write pointer value).

The last step should actually be based on 4 byte or 8byte, this patch is
for that. If gtt_sa_allocate is already getting a cleared memory, then
this can be skipped as well.

Thanks,
Lijo

> Regards,
>   Felix
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>
>>>>         prop.queue_size = queue_size;
>>>>       prop.is_interop = false;
>>
> 

