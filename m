Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2491AC7114A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 05:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D1B10E4C9;
	Tue, 17 Jun 2025 05:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Gi97cUY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A4610E4C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 05:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciRR15IFr2virTSKOGG1t2IM5NZyRpje5L0Z50//8D4Go7WgKdm8SS4mgCFSQ575cC/c8hZBDYx0Bf38zPtK+f4WBFvY40hYakhaxzeJAEhSBBXBuoMmrrddI4AExn6yFbJ0SIKDHbAbZ0AYyi0IPvsmblSWsrX7PrTZgj1IpJUP9LfNaEb0C4k6QgtHsPXvmjmx9aX9VqYQkOq3nfUiukK48O5LHwSPg3nht2A75ZMbElNX/2jqEFOavFkou4zF9zDQtPa3g7HdLjz+qWYtWUF6VraWj9yFtd9pR5f3pdhVmYqKfR1aM2lqehmR2zysISKK4TzYqY6smasP1Q+K1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+p6fGw0sNTweYrzVjSEdLy/VSahaXItIZiGcmb3KGI=;
 b=B+qIH8hJJr2AstkWH/ZFiPGhymF+ZerwGI21+ieuScQd8Kt7aFtdTHLIvByG5r7yo8t6Ej0mdVbx+p3q89+jTfSpZLQlG8tVuL1vZl/PBfJhLaoa8Mtr2Ach0pBNmblOvY1A6kToi/DBvaAN0gpSdmkkqUP23R5nK7L8TMqZVRqtzKa4f7bjGifugE4jj4mBu2IaefC9bRXYM+68IQTAafv3HvoBkTyohPTnVDFVljygp6kWOjbT2/RATuokdhtNYDz73oGMg/cpYE4agb9uYpRJDR1dfB043WgkOKN01A8bRKqyuvlOjZgofbjS54DhXuvklBYIg5u5qgt8byxMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+p6fGw0sNTweYrzVjSEdLy/VSahaXItIZiGcmb3KGI=;
 b=0Gi97cUY1m0FbQqxieIZqXKteRpAZvvdEfjF6xWbjfT0Mid6FtbZNn/7H7ylp8UWIe83HtaqtznIkKcveqaXeT7BJFIOoiL7o1D4GQkVHP5SAUGiz1uCbKvPcro8J59uY/bhRzu4F+A7iH5E4Jq1KV9bisIJqZ1V/49DQ5tyon4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 17 Jun
 2025 05:44:49 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 05:44:48 +0000
Message-ID: <0a773ecc-0f6e-49c2-984c-e4927153af40@amd.com>
Date: Tue, 17 Jun 2025 11:14:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Adjust output for discovery error handling
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20250613214101.4117000-1-superm1@kernel.org>
 <f1525ee7-9f1d-48ae-81af-f97fb3a00351@amd.com>
 <4749ad1c-8af9-4230-b925-c5074e28f898@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <4749ad1c-8af9-4230-b925-c5074e28f898@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::27) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a55a621-f8bf-4869-55c3-08ddad62123b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEg4ZkJ2RmN2cjNsWk42YXlwRkhsbHdxR1g3bzFqMzdQZUxzQmo2STV6VHp2?=
 =?utf-8?B?WkNMd0RWdjFlb0VXbmVCK3NPRGpIZTc0aDhkbU5CbzFNRkEybjNwU1NTNkx6?=
 =?utf-8?B?NFJGWng5c2tja2xIRVhMVmJ0U3d3dUhKOWNCamt5TGVoblk5d1IxVXY4WjRX?=
 =?utf-8?B?VExkSktyMjRNUDdXcHYzMzNuN1BuUkU2TG5FYTNNTTRORHE4Uld3M0kzdjJk?=
 =?utf-8?B?RktUS3VHTUVycWhxbHk3YzNiK1hDS0JOT0NQaFRPam4yL202Uko4emcxY2Q3?=
 =?utf-8?B?RXJKN0xEazZ2cmU2RkhSbjcwQ2hscG5TMmRPY3dxeE84ZVppeWNYRXJ2U2ho?=
 =?utf-8?B?NE1peFdlNHlTcmFVTHpqS2VYVnRlQTF2SFVEaEJ6b2pCNXMrSTB6azhzeU42?=
 =?utf-8?B?WlkwRmtOOGFsVlZ6MVVSYnAvNVpvRmR0cFY1RktnNHdPblplbS91b29HL0xT?=
 =?utf-8?B?WDZQdCsyVzNiZVBzamNUNExnbXZ6c0dWMXJqS0JIMjFiM1VGVWd1NVlwSXJC?=
 =?utf-8?B?THM4ZGlsM01DMjNTUWdjN21GWkRLTDBGSEJ0WlNqS1B6clg1YzM3eENPMCtN?=
 =?utf-8?B?Z2kyY3ZUSlkwY0tWTml5dWJYOUpkdjFMKzV1cUlKb3VMWE1JdFpFWDBndXFO?=
 =?utf-8?B?aFlqTEx3bDN6TWxOSlVRRWJaU2I4dWEzdk5WNkxCNGZ3Qi9vaitqQVZkQWJs?=
 =?utf-8?B?Vkt3ZEN0SUJ2ajlBUldjWm40VDY4TmlNUllMQm1BalRvTmZMSFRKRHVsM2FH?=
 =?utf-8?B?ZXczS1JIb0FLWU40eGxNcEtRcFlxckx1QmIwK0M4ZEJjTlFPY1JGVTJvTTBR?=
 =?utf-8?B?QnRCNHFqaXN4czZscG4raUtJTVVaZzZ6YzBQWTVTZ25pbW9kbi9JaEdwZlR4?=
 =?utf-8?B?ZGR5Zno5KzB3WUZuU0Z3c3U0OUt1ZEtyTGtBM21lWTc3ejJrUHVqTkRRYnZi?=
 =?utf-8?B?SmkrcG1GSnM3eXkrcXhQYTJiT2Z0aEFseEFwTnphOVhFOFZLUHdOKzhZR1Yr?=
 =?utf-8?B?TFFHcUw0V01hcWdySi9XY3RrMy85WEo0bm9LL25LOFAzbzEwcDBENkpNUHRq?=
 =?utf-8?B?UjVWakFlOVNNSkI0dkNDN2V1eEVDd241WlVvb2pIWEVld3JmaGIrZERjRTFw?=
 =?utf-8?B?cEFpeEd6YjQ3YkNyTkM4WjNiaC9Wa0traUZsc3hDZmtmTTd1cStxZHJ0K1E2?=
 =?utf-8?B?WjN4Q2E0aEdZT3lzbnY0TTdIMmFudTVQUlY3TjJjWWZYVzF2Z2hmaWMyYXBj?=
 =?utf-8?B?WW1RWjNiTUdWZlF0VkIxQmR0ckh1bG5mUXJSNGNBSGRHTGZ4TnNOcGVnUU9i?=
 =?utf-8?B?aGNsZDdTOFRuQzRuT25QNk1JdjVIaW50R29KdlFRcS82V1ZibDA2clNtTnp3?=
 =?utf-8?B?SThLdnJnaE1zU2hlYTkvUWhFdmQvYmhtZ3hYTE9JWHRlMExaWlhZQWFsT2lY?=
 =?utf-8?B?cDRGdGFuOVdKSEkwNW9XSlE5OXpLTXZIcC9lSWdBV1RZcTk4QWE1cHprcHJU?=
 =?utf-8?B?bGtBTG5VY1VXTDdFZjNWMms3VnEzc2htdEN4V3Bpb1NxRG1EQlBHSCtZeDlj?=
 =?utf-8?B?VWxoSW45bkF3ZThRMUtqZmV1VWZHYkZqUVZOZDVsWHhtQUVnZlpHWHhNallB?=
 =?utf-8?B?Q0QwT0V5eFllbkNIVDU1K1lxbVhndEJTWm01YUVESWd3SmUwUWVuaERTZ3Jz?=
 =?utf-8?B?VXd1SVpnUXBlNXhpTXFZbk1sZHBhTUpnQjA4aHJDQUdzdjNKU0dVaTY5VFU1?=
 =?utf-8?B?cGxzVk9wWW0xekN0VG5ZOWxvTlM2ZDRsQWV0OElSWnRVbXhPVEZPVktwdm85?=
 =?utf-8?Q?XUxc9S+ipmpliOtSK/gfc8ej16zyR7AEVrWSw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGN0NnZHdjlwWjhWaWw5bUlPRmhEVXBQejZVaHZYeDFSYTFDZ1h1bVZ0YWto?=
 =?utf-8?B?V2VzQ25vT1dqbVhEUlRDUmxkczJ1b1UxRTZqM1UySmNrMDRRbTFVdGxrdDRX?=
 =?utf-8?B?enp2ZllISHN1MVN6YWxkaGdvYjdpKzloWTdiV1lGUmtYV2dpa0dXYVpZcUhL?=
 =?utf-8?B?dXRZVyt2R0lzOXN2eTBtT2s2WmtpV0QybkVsNzVCZEZ3L2tYNTBGdis5VW1N?=
 =?utf-8?B?K1RMQ1BKMkd1ckNVZWV4bFUraVorT3poV1Rad0NwK3cyUGdWejRvUnlzencw?=
 =?utf-8?B?dzMycVNSK1p6MmtFY0MyejNHR2d3M044Q0NKZm1ENXFmSFNJSzY3bTVlT1lK?=
 =?utf-8?B?Nmp5aU9aNkNmU0UwUUllZzlGbHpzVFM3ZUJFbnduUjVYUmZjbVZnRk1OMDNt?=
 =?utf-8?B?bVdFZHA3d3E0ZHNlWDdPcHFtRFgvb3RON25YeVFBbUd0S2hzb2NLUDRwWFh6?=
 =?utf-8?B?UG1TNDZUWDBBMTVZVUlkVVNaejVLNXNCYnNWcjRZdXpyUEEyNTVCcHBmK0d1?=
 =?utf-8?B?VmtqRm5PdUQzVjhINUdvWXNmZElWZ1NCYVhsVmNlTm1vdHVjcjBGR05jMi9G?=
 =?utf-8?B?TlROOWdpbmxYdEZXMEhqbHB1Y2s3NW85eU1hSkhKbXdja0RzMjRMVDBGNC9F?=
 =?utf-8?B?Tk5xWEF1UVBMbG8zYlpiSmNCVElyZkZBRlFzc2psczI2enJsMDJYYVpGR0FM?=
 =?utf-8?B?M0VBVFVUeVNESEVlTUwyYTZ4M20xaFF0U1lreWNSb1FYbnp2anNvWURVMlVm?=
 =?utf-8?B?a2gzM2JRK3d6ZEdSVk9lM1JRN3V3MVVNZGs3RmpoQ01NUUhublljeDVPajVB?=
 =?utf-8?B?MmV2SWYzWmJKYlg1b3pMNmdSRk93UzU3WVh0c2doVzgvNVdxVVBRUkFlNDdX?=
 =?utf-8?B?cVNmdHg5ZU1OQy91Vk9uSWZxMWZTM3lQejZaVFpnM3BhRWVycnhPQ2Q4bDg0?=
 =?utf-8?B?WnNPbHlmUkowM2NINUYzWDhZNXpiR2Y1UDAyTzVncEZ1eSsvNWZyb2ZnMEJn?=
 =?utf-8?B?Sjd0SjFqM1NXc2VyYnlNeXpRN3kyaVh5dUx3SHhFaVliTmtmQUR6Yjg0Z0hl?=
 =?utf-8?B?bklhbklKdktQN21KVnBCdWhZb1dUTG5pa2IwQ3VVSE1WdUVMM2RlZnplM3R6?=
 =?utf-8?B?TlIvcmswNS9JWUVWZ0JTYUUwa0F3dHF2NDB0eUVyN2wveSs5YjYreWtEOFYx?=
 =?utf-8?B?dDZHQ3liN3V0NHR3WHpIK1dCc0RIeTNTd2pnbWtUTEJwdmErV1B1amVRYWdN?=
 =?utf-8?B?RWtWdHVUL1V0VnEyOUdraTFEL2tITEpzNEptTkp0VkZZZVgyYmpCcnRoaCtF?=
 =?utf-8?B?SzFPWWdUUlEySEEzUlZNMTVPT01kRGFURlpaV3Mxa3NUTFgxOERHbkFQbXYv?=
 =?utf-8?B?WStaNFN1c2NEWmpWMGpzN0hud1dNZlF5NXd3bzFDU3kwSWRjZWtUUTkzMXFh?=
 =?utf-8?B?ak5zeVJVRlN0NkRtczNiaEhvS3FiOHJldUUrV29vR24zcFhzNWpoSHpUUGZ2?=
 =?utf-8?B?WFQ5azg4cDFZeW1PZ2tCb0ZZR1JPMW4wL0VIeFRNQXh1aHQxa25BUVlQb1hO?=
 =?utf-8?B?SExrR2tDcHN5My82VzFJMzF1MFhyVEJrUzFvRlE0dlJOYWY4R2tjb0NQdlJK?=
 =?utf-8?B?UUtNTUtuS09rZVZOWi9yVXhFMFBrK1lnQ1pyYzI2SlN5ckttODRjVjNOcFJW?=
 =?utf-8?B?aHlabkVGRDZKTEtoRVRTSXhnbTlYUUdEdjN1K0QrLzFZRXZuSHRpM3RCc3Ra?=
 =?utf-8?B?aFJubStrRFRBQW9MNFJzWEdXNktSaGplQjl1S1NHYmxuMGlrOUd4MUtaUmdY?=
 =?utf-8?B?TkErNWpYMGw3TVYyOUJLWEMxbUpvZDNucmhEVW9yUGtyTkhCcXBiRXplbGxO?=
 =?utf-8?B?Y1plOXNwMnloT0ZoWmluK1ZBZlFtTTg4eHdDMVJPblFyekFSQVoyZFZvSW8z?=
 =?utf-8?B?bG5iMTR3T05iMHQ5NTRBL255dUlXY0ExTDg1YnMyRXFMYlRCTWVBVEd3NTN3?=
 =?utf-8?B?Z3dJY3IxdzJUREl5R1I2SCtuY0RLK09ZcVhVd0FJWjR0UjZBVEx1bmRia2FG?=
 =?utf-8?B?bVphV09lZjY0cnVsbFpubWlIQ0I1anp5YUlUcXRpU1UzT043OEkwSEJlRVB3?=
 =?utf-8?Q?Ue9U/2vUX4UVaHgsxlb9XoUY5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a55a621-f8bf-4869-55c3-08ddad62123b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 05:44:48.6467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+t0/OnMwvfQ0o8imNvdJjJYTVSD5DCXQFoe2M/ldb0Aev/s5BO0LVv60zu6LPC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
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



On 6/16/2025 10:35 PM, Mario Limonciello wrote:
> On 6/13/25 10:27 PM, Lazar, Lijo wrote:
>>
>>
>> On 6/14/2025 3:11 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> commit 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
>>> available") added support for reading an amdgpu IP discovery bin file
>>> for some specific products. If it's not found then it will fallback to
>>> hardcoded values. However if it's not found there is also a lot of noise
>>> about missing files and errors.
>>>
>>> Adjust the error handling to decrease most messages to DEBUG and to show
>>> at most one message to a user about the missing file at INFO level.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4312
>>> Fixes: 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw
>>> file available")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
>>>   1 file changed, 6 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/
>>> gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index a0e9bf9b27108..8e4526a8c2600 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -321,10 +321,9 @@ static int
>>> amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
>>>       const struct firmware *fw;
>>>       int r;
>>>   -    r = request_firmware(&fw, fw_name, adev->dev);
>>> +    r = firmware_request_nowarn(&fw, fw_name, adev->dev);
>>>       if (r) {
>>> -        dev_err(adev->dev, "can't load firmware \"%s\"\n",
>>> -            fw_name);
>>> +        drm_info(&adev->ddev, "Optional firmware \"%s\" was not
>>> found\n", fw_name);
>>>           return r;
>>>       }
>>>   @@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct
>>> amdgpu_device *adev)
>>>       /* Read from file if it is the preferred option */
>>>       fw_name = amdgpu_discovery_get_fw_name(adev);
>>>       if (fw_name != NULL) {
>>> -        dev_info(adev->dev, "use ip discovery information from file");
>>> +        drm_dbg(&adev->ddev, "use ip discovery information from file");
>>>           r = amdgpu_discovery_read_binary_from_file(adev, adev-
>>> >mman.discovery_bin, fw_name);
>>> -
>>> -        if (r) {
>>> -            dev_err(adev->dev, "failed to read ip discovery binary
>>> from file\n");
>>> -            r = -EINVAL;
>>> +        if (r)
>>>               goto out;
>>> -        }
>>> -
>>>       } else {
>>> +        drm_dbg(&adev->ddev, "use ip discovery information from
>>> memory");
>>>           r = amdgpu_discovery_read_binary_from_mem(
>>>               adev, adev->mman.discovery_bin);
>>>           if (r)
>>> @@ -1339,7 +1334,7 @@ static int
>>> amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>>         r = amdgpu_discovery_init(adev);
>>>       if (r) {
>>> -        DRM_ERROR("amdgpu_discovery_init failed\n");
>>> +        drm_warn(&adev->ddev, "%s failed: %d\n", __func__, r);
>>
>> This indeed is an error. Rest of the changes are fine.
> 
> How about pushing this down into amdgpu_discovery_set_ip_blocks()?
> I was thinking we can put it in the default case only so that the
> fallback path doesn't make a lot of noise for vega/raven/arcturus/
> aldebaran.
> 
> Something like this:
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/
> gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 3877b43d9f863..d5bd105de1b31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1333,10 +1333,8 @@ static int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
>         int r;
> 
>         r = amdgpu_discovery_init(adev);
> -       if (r) {
> -               DRM_ERROR("amdgpu_discovery_init failed\n");
> +       if (r)
>                 return r;
> -       }
> 
>         wafl_ver = 0;
>         adev->gfx.xcc_mask = 0;
> @@ -2574,8 +2572,10 @@ int amdgpu_discovery_set_ip_blocks(struct
> amdgpu_device *adev)
>                 break;
>         default:
>                 r = amdgpu_discovery_reg_base_init(adev);
> -               if (r)
> -                       return -EINVAL;
> +               if (r) {
> +                       drm_err(&adev->ddev, "discovery failed: %d\n",
> ret);
> +                       return r;
> +               }
> 

Yes, looks fine.

Thanks,
Lijo

>                 amdgpu_discovery_harvest_ip(adev);
>                 amdgpu_discovery_get_gfx_info(adev);
> 
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>>           return r;
>>>       }
>>>   
>>
> 

