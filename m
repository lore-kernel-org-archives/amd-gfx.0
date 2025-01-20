Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCD1C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 12:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB04D10E3D0;
	Mon, 20 Jan 2025 12:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AsMExfd7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6C710E3D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 12:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDmwY4c1i+sOcwoUyu5MiFZdRss+tZgPEW3yx0Ce+aQpPx9rTy7Mda5rjjUsqhxMxX4P3E6xSKvH2Mmk3I+VJM/xC7nhVrmyESywlQHDkZI/lh+HO6epPjRVlzNBwcvExhSDSRN1eQsxB+B2qm/qpHVepualnZKBkWVf8BLhwUMO6JaG1Rqnl2yGsMmckQ/KdUaFYyggy3tie/piZdvW4RU1hsHKimUoFlXgug0KR0AH9Xb1MBsJHP5IssKSrQXyNrmHuozmww/9TReoTtGmGlW8eTcMHR7V6ogeYe9qGaSxSRkGsCwEeTvIFQd2yW8cPm29Z86OX2cQvQCOQR6c/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAhIYvP4vGDg1rHRoetABTJbBA85dldKV2MEeQ0PSfU=;
 b=dkDzvEb6Ro7a6T+ObzetkJQSh9bWwn5qJB9GGIpgG5suxNCq3V+raFpjI2fWtkLWkwWvF1IcaBxWKXzi24jly+bOpN3Okq9dK44E1v1q2OuZ26jtsrR69XHUsneDx2uOfKIiwMAVb4bXBZTTDSlzGS5ljl+ifT3JRreHnB8lsglFoa6Z2eNg8Ri1RANtrQRYKZ7iub+y+y6Sb4U8147DBKFkOPDBdDCvhzdkwyQzPbLxmqApSDmIUDKYV1yzGPELa6rAaerVmJWprkX7GpPHbU48iNYJN9qj1A36Xn5C9DN4oj860RxQSaXTWage65We2AL7qsjcUhCxzJNNnFrWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAhIYvP4vGDg1rHRoetABTJbBA85dldKV2MEeQ0PSfU=;
 b=AsMExfd7XdZarT++3Jbjsu/w1CD9lYfHjeQlFkxffNcRbpU73Zv9tvSYsuFDtxI+/chhgRen6pzTieB8wa3iYQPX45Ke0gJ4f4od7HtrcgwLIb25D4bQLXXwhz6zEDUyOxlRBSJmDfeuiqHpZXNylpbuYrwfHFAFuhbcwM8X62Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.19; Mon, 20 Jan 2025 12:39:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 12:39:16 +0000
Message-ID: <c7349fc2-bf88-4aaf-8b5c-9a887bbbe715@amd.com>
Date: Mon, 20 Jan 2025 18:09:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Prevent null pointer dereference in GPU
 bandwidth calculation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250120123206.188410-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250120123206.188410-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PEPF000001AB.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 41326e1b-e6cb-434a-ccb8-08dd394f73d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFZkQVBNamZYMitrZE1WemozbkVVeDJCcmJRdGJ4WXRTQWlESGVPTUs1c0tT?=
 =?utf-8?B?T085QWtmOGdaOTV6aXg2bHB5TnBwOXpFc0Nmc0N2WVRPS05vZUhLUkhwRzJF?=
 =?utf-8?B?SVdaNVpKWUZ6eHBhWGh3SzlUUnVMZVVzdVhyMS82QmovU3JmSWRwSjNENFBt?=
 =?utf-8?B?Nk1MNjhzeGlwcyttRjFjNmdXamF2TzB2ZUJNc2J5UHhBQzdacDJleW9NQW9k?=
 =?utf-8?B?NU9GT3VyY1cybW82TDYrZDhUOWFQb0pUendqZ1N3U3NjUXpFR1Q5NWNZTmcz?=
 =?utf-8?B?aElNVXUyd0k3NDRRM1lwTjlpbFIvSXVCUml1UXJaUlFYRmNYMkZKMUhUZ1NP?=
 =?utf-8?B?MWI4YkNjWXhPNURRVkdhd2pyV2RkWUZwWXNYdi8xdzBMallmV2ZYUFVsSUhC?=
 =?utf-8?B?b1FoOU9PWmQrTGRHVGREU2dXbThxR0N3WGdoZGhNT1FlN2Fnb29Ibzk1WG5O?=
 =?utf-8?B?VU11VW81R0tjbzZMMnJSWHdINW40SUxlZzQ5L3EzM2hUSVA0ZzBzamdlK0ty?=
 =?utf-8?B?UjJZYWo1R1FzdUVTUkJtL0x4ZktmTkVaQ0JUeEN2MjdFWW9Ob3JNSmpvVml5?=
 =?utf-8?B?U0RZY3c4S2NCdTJ3cjJoRjd5Z0x2dVpLbU92TFp3Z1FDREdvVzUrbkVZMUtu?=
 =?utf-8?B?aFZDWFk0Y1VIenpBR2R0c0o5aDhQK3I0aHM4NlZKZFZneWk5cG1wc2xhQWRJ?=
 =?utf-8?B?YTFWNmRneHBLNkRGNC9ISnVpSmIwNXg2TGNaTmJkK2JmMXJvR01tSlp2Zklh?=
 =?utf-8?B?UlVYNkRJOWF1SEpvUXlFdmRMWm8vNG1aenV5dlFQRk12SjQ2enFneTdVRVFO?=
 =?utf-8?B?VVlVY2hpTmNleitNQjd1V295dytKcVlBZDdCVzR3YnZBay9IUklCWUdDd2d4?=
 =?utf-8?B?RzEwVlcvRDVnYmtSVjFaaTlQMFlIa1YwTGg0WVpDajJ3UFBEdDhnMjdnTWpv?=
 =?utf-8?B?R1Y5M1phVng2Qm1rZGVEdWNCRitvRWRTbk5NUlBydjdRU0pUR3hUb2lMeHgw?=
 =?utf-8?B?cWZMUkpDblJqSmREbDIvajVKdkhyVndia0o1ZC9kWEt1ME9qMCt2SjZUT0Uw?=
 =?utf-8?B?VnFOM1NHWFU1aVBCajllc3hoaFVCRU50SzFtWnN1dldNZjNSdC85U0c4U01X?=
 =?utf-8?B?UFByRFNRaTlidXJXL2cvamdwQkE2RWM2L0QzeE5TYnhiVTVtUWNISUs0eWJP?=
 =?utf-8?B?ZDlhMzdLRXh1SWltT0JIQWpqTXFhc0xQbXRvMUIrWmNVN25ZMFU2ekdZR0NE?=
 =?utf-8?B?cFQ3MjdSSTJUY3hxYWtJMXFRR093cnErckZvblluZmZFMTBJREcrVTRhNGV3?=
 =?utf-8?B?cnd1dVVxSVo1ZGpzNEtFVUIybE1SYWZrbGtwcmxJenRrT2RvS0hlU3h4QVFO?=
 =?utf-8?B?ekhpWC9vVHNTSkpEZGhqYTlsc1ZZbUlEb3dQN1NBSjBMMDhqYjlHRG5jQnJJ?=
 =?utf-8?B?U3NidXlob2Q0dnp4NHJ2clAzKzVmeEFCcDMvZ21aY1BhSCt1U1VXcVRPVWw4?=
 =?utf-8?B?azVmYmpOdGtmQ3dCS2thZll2OHU2ak9mbUxFOTUva0dYUXVNYUk1cHZKUzNh?=
 =?utf-8?B?WXd4bTZEWmg3bGpqRkQ2dGRNbEc3eTJUeXRmWUhJWUQ3WmhvMmpWRlNpOEdY?=
 =?utf-8?B?UFd2SjJOVUg0L1B0eFFscWdMNXgxZzZnZHJBZmxtMVNSQU1kaUF3U21BcDNF?=
 =?utf-8?B?S2hXOWloNWM0V25Ua3ZIbWVNM0g2eGtMVTFJTjNOeU9MK2QzSWZ6OEFzSFNo?=
 =?utf-8?B?ZU53YzJlN05sZFBxMHo0bmlnQk5obTUrUDNTUDZWRUx0Z1NacGo3MkRieTl5?=
 =?utf-8?B?S1NrKzg0RlVaRW1QTEd6YTgxOU82RDN4QThBVlc4Q1AzSHUrYUdWcEhZNnpk?=
 =?utf-8?Q?VA+Z4zXV29QG+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlgvbEJsSDR5NlorQVFxdm1XTW04Mk9zT3NMOUk1ckFta3F2akViemZSSThS?=
 =?utf-8?B?MnQvM1dNM2pDMmZ1d3V5TlZCektiOVgveFdRUE5MRWx4VWgzRlM1UGtqNGhI?=
 =?utf-8?B?NHF4N0plbGs4SS8xOW5QNGxRWmFLSWJ2V1hhbVhTWVYxcThKVDFGZ1dFSGEz?=
 =?utf-8?B?QVE0eG9MQSt2RjIyWHUvTzJ3ZVRad0JxdnltcVIzbzc3bFN0MjlCbVJnbEZq?=
 =?utf-8?B?R2Q2d1YyLzRQYysyeEFMSE5teWVXNWtpaXNSWncrYXQxc0NFU1VBT3M2MXhx?=
 =?utf-8?B?aHNPZ05Wc2lSMHpzcHJ0ZVlmbExKU1prZXdocyt6eFl6NlJBb1ZGTW9oQTRQ?=
 =?utf-8?B?OTkvK01YbVh6R3hPNHMrMGhFRVFJZ3NNNHBxdFJVL0V1dGlzRCtpeERsTDA3?=
 =?utf-8?B?VERQTjBkK3FUZlYzWXNsSW9MR3lOS2FndkNaUnpLUzdXZnRLWHdtRVhEaUZV?=
 =?utf-8?B?M0ZESDdkbENyZXUrVGVkc0xnaXpoeEgrNVdXU09oTll5UnZnUUNta21VdmtH?=
 =?utf-8?B?UW1BUm1jU09mM2dReHp1dCt6bHhoVHdsdk1QcDhlNDVYUnlVa0FhS2E1VmZm?=
 =?utf-8?B?UHdMOHVzNmJGT1I4Zkt0SHVpZE52TXdQbm01T3VGSGVNSW5xeG4wYlEvQmtH?=
 =?utf-8?B?dEowK0JMMHptcll4R25jbWpxTFV2eTJWcXlsZ1poVlpUMExEMUJiMDRBUkh3?=
 =?utf-8?B?dENIeUNRMkJJeit6OG1HdTBxbWk3eW5ucnBRbkwxR25MdWk2OHJDa1RJSHhy?=
 =?utf-8?B?Ti9zOEVRdWpsZEVRc1hORyt4YVpMVFIxMGFXZkN0eGZWbkJGRkFqcmRhMHhX?=
 =?utf-8?B?NTN5d0hqL1NUem1EcEx6azRFTWc4cDR2NUttZzgyWUIzQkpWWDhIcHY0b2VG?=
 =?utf-8?B?NGVDeERoSURhM3ZDUUxoK3E2ZnI5Y21CeEJYVWhockozLzFpS0tOVXFqRkwz?=
 =?utf-8?B?R3BLYnY4VG9sNDBUb0IzK3VCcU5BdUl6U0NZZHlrUnNnSjJ1ZHJLMk5md1ZC?=
 =?utf-8?B?MUY5alkzb0JqemNYd2w5WnVFaWxwNWdxbGYyMzJGaTYxTXY1MFNjTzViWFls?=
 =?utf-8?B?cUVDNW0remF0ZEw0UG0wMENpeHY0elVuZEhWQW96WElYam9VTEVBa0ZhM2FV?=
 =?utf-8?B?R2Z2RW5rN1dFbCswN2t3d05Wd3JyaTlOQVp4WmhvVkY2TzBPVnBGR3pEVEcw?=
 =?utf-8?B?bXdTMmd6T3BjbHg3K25QcFVEd0JuSjFPUFkweG96ZDVMc2NKQkY5cU9taDFR?=
 =?utf-8?B?MTdBTlNDcmNsWWN6bjZqZUZFNys5bzh3MHF0ek5zWVQzdGptV3NzaUlXQ0dN?=
 =?utf-8?B?ZXk0V3ZzRDFweFRkbjdtWHBSR1UvbHhUNXdoekV6QS9kVU91MytOWXFjV0N0?=
 =?utf-8?B?Q1JtcmpCYWhrWDdndWsyRkZhaFo3QURrQU5VVTlnMXRiaEhMdmlHRnVtWHB2?=
 =?utf-8?B?Qmg5V1hpK1Z0b0J0ZTkyZnZKOEk0V1l3SEFmWVk3WktiYVc0T0VLUllIZldR?=
 =?utf-8?B?VzAyMDY1ZHFQQTBxalJENFV0bUpFRVF6T2srWmNuSkVlN1ZoRTRpc2Rjd1ZJ?=
 =?utf-8?B?SnRUdW5PQXBvSlFUUlF0a3dhMUhQODlXMVVrNFd5WkhkdlNTSmE4RUErYmY4?=
 =?utf-8?B?TThTb0xMZXY5R0VQb3Vna3Z2ZnhSRHBMZlV1eXYvM25WTlFiT0hqcVlrZmhI?=
 =?utf-8?B?OWovdG1NbFgxOXF6OEV1V1poSUdhS2pVVFozdC9td3kveThnSzRvbTAvUEdD?=
 =?utf-8?B?ZEdJWm5sY1BzeVdJLzhSd1d5UGpZditZZ1c0bkJaR1N4S0Rzd0lBbnpGSC9Q?=
 =?utf-8?B?Z0hCd3ZSVFZ4WEV1U0ExeTV6bmFSVGEwVkNMU2VTUXIwZTVWSlptTVl5bU5Q?=
 =?utf-8?B?eXNSVzJkRjltalQwUXkyRENBQWszeUV3bGZTc0FCYytVSUNPSEt1cGJReDFU?=
 =?utf-8?B?djlWcUNMVkpGK1RyaTN5QnRkQS9qMWl0WmF0RXNNVDR4UGZ6WXoxVE1vb3Bq?=
 =?utf-8?B?L09SL2RmRzlraTdWR1lXOUZRRFFyUGQ3NlNPWGtvUVdPaUxScnJHUFdCd2dO?=
 =?utf-8?B?aXBjb0JYSERIWHgyT0RrdEdGUGNBNGlWRENrU0I0UFJoWFkzbVFsZUkrRGcz?=
 =?utf-8?Q?1l1hWq1vBNjJHCXEG6wecDOva?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41326e1b-e6cb-434a-ccb8-08dd394f73d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:39:16.8948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7UZaBOh94hcmwZ1GuRlWW8MDnAxcP7+UHPkbtSMFEhWkXP1nwa/LVbwoVRq/7yW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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



On 1/20/2025 6:02 PM, Srinivasan Shanmugam wrote:
> This commit adds an early return if no upstream bridge is found, setting
> the speed and width to PCI_SPEED_UNKNOWN and PCIE_LNK_WIDTH_UNKNOWN,
> respectively. This ensures that the function handles the absence of an
> upstream bridge gracefully.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6193 amdgpu_device_gpu_bandwidth()
> 	error: we previously assumed 'parent' could be null (see line 6180)
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     6170 static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>     6171                                         enum pci_bus_speed *speed,
>     6172                                         enum pcie_link_width *width)
>     6173 {
>     6174         struct pci_dev *parent = adev->pdev;
>     6175
>     6176         if (!speed || !width)
>     6177                 return;
>     6178
>     6179         parent = pci_upstream_bridge(parent);
>     6180         if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
>                      ^^^^^^
> If parent is NULL
> 
>     6181                 /* use the upstream/downstream switches internal to dGPU */
>     6182                 *speed = pcie_get_speed_cap(parent);
>     6183                 *width = pcie_get_width_cap(parent);
>     6184                 while ((parent = pci_upstream_bridge(parent))) {
>     6185                         if (parent->vendor == PCI_VENDOR_ID_ATI) {
>     6186                                 /* use the upstream/downstream switches internal to dGPU */
>     6187                                 *speed = pcie_get_speed_cap(parent);
>     6188                                 *width = pcie_get_width_cap(parent);
>     6189                         }
>     6190                 }
>     6191         } else {
>     6192                 /* use the device itself */
> --> 6193                 *speed = pcie_get_speed_cap(parent);
>                                                      ^^^^^^ Then we are toasted here.

I think the correct fix is to use adev->pdev here.

Thanks,
Lijo

> 
>     6194                 *width = pcie_get_width_cap(parent);
>     6195         }
>     6196 }
> 
> Fixes: 9e424a5d9087 ("drm/amdgpu: cache gpu pcie link width")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 46af07faf8c8..749791a486bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6174,6 +6174,14 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
>  		return;
>  
>  	parent = pci_upstream_bridge(parent);
> +
> +	if (!parent) {
> +		/*Return early if no upstream bridge is found */
> +		*speed = PCI_SPEED_UNKNOWN;
> +		*width = PCIE_LNK_WIDTH_UNKNOWN;
> +		return;
> +	}
> +
>  	if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
>  		/* use the upstream/downstream switches internal to dGPU */
>  		*speed = pcie_get_speed_cap(parent);

