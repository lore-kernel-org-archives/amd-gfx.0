Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F690D5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5048D10E969;
	Fri,  8 Nov 2024 11:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zwXRE5rL";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EFB110E969
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTzt+fYBjNQTaJM7YqwxPAcWSmdScgNAD0KP0Q0KoUuJC8QmB3702jehJqTsNfI7vejaYr5uW7pLap2eWDooO2lBSMkcbn36ZrY1JwmcMImVkwRTTsHdWAAkQuJM6hYKqKMbUHkOBph6UEsphaYJXwz0kOUEX47u1aMUztpVYSaKrBnmsBOt2waMB4Z0+rXBDMhpobf/BUT61UEw20ZtPxXl1Ut7rVZKTxK6vOof1sH4n6DP2GPq1Y7MrYYsB3u2L1/EJWLwu2LJjOOndN6EI6AEUQElA7x+WtP4azL5fcXS7pZj0dWjoNbPV61aqi+FFlnaBKCjnEPa015VQtKlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esT+F2PnaISvzrknul/s/F9i+e/pElmKIrCApgDcUt0=;
 b=yYOo1To1muN7+AHJ49h8o6lKUAXuVe9AU6fb+5kZQAOTTNtyUFtxZIUHvhu2/X2K/byPtcH2zFjyv6OUkfm+SqETLFXm7fvfmnyayy/x5ciau9cEebrvM7bqJHkaWgsXFjw426CnRRzXfKQL5gdim/ajz/WoWIpCXgj6OZLeHJGFouViJVq7+6cyfxd6cHcLgKVMrKtnzxCbTtbSW36oWwlnzxnv7ZUo2ioFkKfOC9UmMBHPFtORDLcAIJBAf/ZfhlCVbMqyaDn/ezu0Ret0dWEk1vE1L51WywjWs4ywQlfPZ5CTjv6ahGk+JdMPzszjU/9lr7Uctw3P8o1/kZDoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esT+F2PnaISvzrknul/s/F9i+e/pElmKIrCApgDcUt0=;
 b=zwXRE5rLLxJCNqUdw1YB8JX/DW4qceZhTNuoZXOvREpz42OV6vSQ2qe6+IbIkaDPsNbAyXvDdluGNFy2C9zNOqDNGRA8rQ7LfQ49GFpq06ufNBykOKYZbJiltxYR/tiwOSKaIUl0ni8NDKKPa32M+zaY8MHqmOrtCxU/ZR8dFww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 11:26:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 11:26:37 +0000
Message-ID: <7c0bc3a5-756d-4c60-b459-73a2ee910ce7@amd.com>
Date: Fri, 8 Nov 2024 16:56:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
 <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
 <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB52690F8688563810F74A261A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB52690F8688563810F74A261A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bea8e50-f92c-4d87-908a-08dcffe8352a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjBGMzc0K2VkWnNiY1dCaGtGUld0UzI4bUg1ektwZ2paUGFiUUZUQ3cwQUl3?=
 =?utf-8?B?aWpNTEZSSlk0SmJ6eWFla2d4elZhSkFGL1VHZ3R1V0Zoalc2blhiOFVIelJp?=
 =?utf-8?B?bVJ3TlJITDdzd2FBN25jZmpUeUduUWpBK1ArUjRUYklMbmFTVXkyRzlhcUlT?=
 =?utf-8?B?TE1LRjdRaHdmR0hWZDNaRW1QT05zVlN5VmRjMmsyZWRYU3hTakRZMlBSWWgy?=
 =?utf-8?B?WWxHTDVRelNSZW8xRUdpMFVRck9yalNCL1piM053dWtGVG0rZ0xyL1NjWnQ3?=
 =?utf-8?B?a1RjSWNUSVorMVZUQ1F6ZFpjSnYzQnd0MHlqUFBYSGdEQit4Y092RmVVYUha?=
 =?utf-8?B?aE9yQVBaM3haajJNc0cza0UrdWJpMjJZVElTdzg1eFpPdVB4bzB4TXJtS0FM?=
 =?utf-8?B?K3JqR05TVXBmT2lEV0t3YlJrVDZBMjNuNjg1Mm8vWGVsenlOMGNybGQ4dDA2?=
 =?utf-8?B?VUlEMUFLT2ZxYWw0b0xYTnpoVjFqNE9ySWllSTdueTBTZzdtTWl4clN1VjNP?=
 =?utf-8?B?MUdUbktxNFdxZm0yNjREZHBIYjU0SHNWNkZmZndQQ2NUbHlYdFdQTUNEd2dx?=
 =?utf-8?B?SXJCdkdQcithS0ZFeEtoTm8wcDBMcVE3ZDRFZXlZRTFHY0J6dk5wWXNLeGJN?=
 =?utf-8?B?YnlaT2F2ZWV4RzNqWlN4YmcxanNFVFF3Mi9PZGZwZlRCNUlkNmM3dG5BWmtT?=
 =?utf-8?B?V0F0ejltYTBRZkJvcXlDekI3YXlmY2krT1g4U2JXSjA0M2ZiV2g1bkp1cWJj?=
 =?utf-8?B?MFMwSXU0Qml4WllvdVdIQURqdzdDU0M1a2dOV0FJZ0JiM2l2TTY2eGFyVlJv?=
 =?utf-8?B?OWc0VXdrU2VLZUhSR2QwQWVwdngvdW1SNE9OOVg1UldLTzVEOGhvWkRMdFh6?=
 =?utf-8?B?UDgyTUQrT3dsQkJ1V0NjTkdYNVpjazdZUWhleHk5WVRxcWZPU05qdnFUeEgw?=
 =?utf-8?B?T3E0M1lGYXNoUkhpRjdvb1paNTM5UGV3RG5LSE5QZncyV1d0S3BnS24yK1V0?=
 =?utf-8?B?MmVjU1B1TzduSnQ4QTcydVJUWFp6WTYzZm9xOTBWVW1LblVhZnYwaVJmQlFV?=
 =?utf-8?B?VG1GcWxxZlQwODdsdlg4R0xpVUNDUy92dWtLcnpZemxNbFBTQTk0ek9nSURW?=
 =?utf-8?B?ZFJMT04wNXZqaE9KcjQ5SVNzWCtFaVdhN21aNFZaSDA5d3ZhTGFwYTNwaXdw?=
 =?utf-8?B?bERYVUc5M1JEY25ZMW9FeHpiUHVwSWhkMFBzODJUdUw3ZDhCUTQwUmNOZkJG?=
 =?utf-8?B?dmJpcjA3b0ZZWGhucE1KUVRIRllTOVp1U2Z3dGUvTm5EcnZoREoxc1Y5YWdr?=
 =?utf-8?B?WEU5bWRBZWptN28rUFV6VVR2UW5NZEowNzAvVWQva24xVXlvNklka05oTDM0?=
 =?utf-8?B?cVpRSWZYaEtFaklVYSs5dkNmTEJwdk9OSzlwejMrN1pEeHJjV3BrV2J3Tjhn?=
 =?utf-8?B?OXpORTg0WFBaZ0dsRWVTTHBVNEZTemFKa2Y2Uk9WS2VtY2lhWk1jZXhJOURU?=
 =?utf-8?B?b1ZFYWFRNytQc29qUDBzYkZOcnRWYkRXK2ZDUjFZQkRUU2Z3c3paRFJSdVA1?=
 =?utf-8?B?SDQ0MDgrZjRrVVduak1BQ2JUbGs0a1lqYzZRcG1nNW5KU2pSUWtsWTlJQXN2?=
 =?utf-8?B?TU9WNnlrenhlRFNYam5OS1JnR1VUVC9IZDNTaG9ML2Q5VEtPR1BCZXUyenJ3?=
 =?utf-8?B?byt1Z2xVQ3IvaGlnWDdqdHcxcFhOZ1lGcGJXd2pRUWJHSm9wamEyT0IxZmg1?=
 =?utf-8?Q?8vDaT8JhrEwUaZpPQLmQt/hXTY7ZGKCQ2yz4n/e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFpZ0xkd1YvdFMwdE5NSGpwS1BiMEZqY0Q3djQyaGZkTkhBZG1wMnFXMHpJ?=
 =?utf-8?B?R2FGZDd0N0NncDVvaGwwYVg0VWF2RFdwUDQyTEhnajVCVEFTMU44UlZFRGMy?=
 =?utf-8?B?ZVdHT1N2dzdzWmN0U1hQb1oxK3htd2RIWjBNc0d0dlpYRkI3RzllV25Tc3F1?=
 =?utf-8?B?c2NqdGplVWl6aTJXVW9XZHpRRjJJL0laVDRhd3g3WlExMDR5WEtlbmNBeE1l?=
 =?utf-8?B?bDRpcGU0QXNsNXkvUXJqQ1l3ckE3WXRnSFhjRU5yN0lveEVSSTdoT3dMaUUy?=
 =?utf-8?B?WTd3YStBN1h3NW1ZYkNCRVV0V1B4QW9KSFJoQ1dweWo3Q1ZOelIxS3F4bFN0?=
 =?utf-8?B?NTBHVGdlZzVYb1cyKzllaUJpbHFnMTFFYXpGUUR1SjJFOXdJS2hoZURYZkVv?=
 =?utf-8?B?dzc1aCtpYTBPN2hFYjlLV0U4RzhKMjA1QzQyU3NvbnV0bTg2eW9YbVdQTVA0?=
 =?utf-8?B?cXU0a3pQSmoxenEreWdsR0YyemFqMEg5Y2hIQm1RVUw4U0h0dGkvWElNQzFk?=
 =?utf-8?B?WmNMQUNOaEsvSThKMDAvU050dDNVVm80RlJSMEF1MU1Xd01zZUdJaXJsYWtp?=
 =?utf-8?B?cGI2RTR2OHI5OElWbEFEbXg5dkZkTThSOUVUSkRtVlVITit6RVp6VFBFRTVQ?=
 =?utf-8?B?NzFYQklkd1pkcTJFYjByM1N1amFPcjNHaGd4NXIzY2s3NkQ4SWVwYXk2dzBQ?=
 =?utf-8?B?b29Ib0ljT2Q0R2hncHRvZkxQOTZ0TUZndExqandPWFhRM3FOS1VRN1YwRHVK?=
 =?utf-8?B?M0k5aVdMaFZ2eGVxeDV4YzJzT29jMWNYMFNLWE1jUHVLblh6L2RYUEdBVEVH?=
 =?utf-8?B?bEF0Vy9vaDFQanRVSXoyVzEreHZGc0laTEZyNVVDQlZMSlJycFlKVUlKVmpO?=
 =?utf-8?B?ajVENllVVkg0VzhXUkpzSTNSWFJyNHkrMHZqTzlYV2dKWTZqdjB1anZpL2p3?=
 =?utf-8?B?dFFDaGNtYjFFSjBta3hnQUVxQ3JQOWVBRVk1WkJLVTNaT1ZKYUFjMkYyZHVN?=
 =?utf-8?B?a1pGcFBNUFQ0NlRUUGhTcmJjVmphY2g2S1NPelBPODRrZTlaT1JGd1ByV2lL?=
 =?utf-8?B?OTNWb0phV3QvTGluUkNSc1Bkakh0OUJKaDJrMmNwdkRzcjlyL1o0VWtVTm9E?=
 =?utf-8?B?a3hpY25aS2RGbTM3OXhuU2hoUUhqQmdqdVZ5cjJORlQxekdzWGRKRFhQTnk1?=
 =?utf-8?B?L1dTRVVFclh6NTIrcjByWVpOUS96dFZJS2RZZmVySlc1MGZydThHWmh3TUZO?=
 =?utf-8?B?SjV0dWNjMHdnYmh6YUxoVjBXc1cvUElWNmRiM05LRlQzNEtZc2tNTm00N1N2?=
 =?utf-8?B?a3o1L25MaWg5cExJZ3N1QVI1V1dFMnQxQnhoRU05ZklERXl3UnB2bktsOEFu?=
 =?utf-8?B?WHgrdGFwQnkvNk5qTFc1NWRNVW9tNEhxQnRabzZUVUdUVThGMm9mMjdFeC9h?=
 =?utf-8?B?QUg1RWR2SmJLUUI3c1N3emo5MkRuZzJETlVnVmMwUUhyeDR0UHJjbmtGMzQy?=
 =?utf-8?B?NjN3ZnYrdTdYeHZKY2E5SHFyVUlnd2tiWm5WNTNqS25kaVhWRnU0V1o1YlhZ?=
 =?utf-8?B?TE5yNlpYbTllM09HdENWSVhYU2dsMldub2dkOFBPL3hKaWlFNFQ1UWlLUzlo?=
 =?utf-8?B?dWFjMjhrQUtMMEdIQ05WTnNBMFYvUnFCV29zcXBTRlRveUZzZE1weWRITVhi?=
 =?utf-8?B?QW9ocEVYUkpldHBCWHM4ZndnS0l6ZHB2ZVl2K0ZuSjhpOHVBb3hCR3FQdDVu?=
 =?utf-8?B?ckNobHZGQTZwM05OemZndG44YUFFQVladWVJSkFXNWZPUXRDV0s0ZFRDZW1X?=
 =?utf-8?B?MVdidXlBUjd0RXNLUDVXdzJrY2UrazdBOGFjTDFkb2Vkc2tLVXlQYzZQZ2ls?=
 =?utf-8?B?eFkyNjZsWmNtQ1RjUTNPYlFsYUwwbm5kSFQ3NWRwa1dEK1F0cnB4TXVUR1lU?=
 =?utf-8?B?Wm5ickJQbm96akZNekFwWnErSys2VVE5RFk2VVFNSEo1ckxDVTM0REV2TjRW?=
 =?utf-8?B?c3BWZnRub0NwaE4zVmFiUDJTcWJzTjlZTmh6RGs5cCs1ajZMTHFJWUFVbnds?=
 =?utf-8?B?YU1OMXh0RzFuOUpoeFlrbzF6TmJYSnlheC9WN0g4QXREUXN3YUx2Nll6cjJ6?=
 =?utf-8?Q?ASZY2vr8ngFvsD+BnoVTOxKjx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bea8e50-f92c-4d87-908a-08dcffe8352a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:26:37.2776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B6DUeXx7dciCpIM63REOUsOfjipqar4Ni8k/uoIA3ri76k4ujpXwWH0cme78a72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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



On 11/8/2024 4:29 PM, Liu, Monk wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> To be clear for the mb() approach: Even if we insert mb() in prior to amdgpu_ring_set_wptr(ring), GPU might still fetch stalled data from PQ due to USWC attributes.
> 
Inserting an mb() doesn't cause WC buffer flush is a wrong assumption.

All prior loads/stores are supposed to be globally visible. Hence mb()
followed by a write pointer update also should guarantee the same (From
Arch manual).

	The MFENCE instruction establishes a memory fence for both loads and
stores. The processor ensures that no load
or store after MFENCE will become globally visible *until all loads and
stores before MFENCE are globally visible.*


Ignoring the amdgpu driver part of it - if mb() is not working as
expected as you claim that means something is wrong with the system.

USWC or WB for ring type may still be a separate discussion.

Thanks,
Lijo

> The issue here is not the re-ordering but the stalled PQ.
> 
> Monk Liu | Cloud GPU & Virtualization | AMD
> 
> 
> 
> -----Original Message-----
> From: Liu, Monk
> Sent: Friday, November 8, 2024 6:22 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
> 
> Christian/Lijo
> 
> We verified all approaches, and we know what works and not works, obviously the mb() doesn't work.
> 
> The way of mb() between set wptr_polling and kicking off doorbell is theoretically correct, and I'm not object to do so... but this won't resolve the issue we hit.
> First of all, USWC will have some chance that the data is still in CPU's WC storage place and not flushed to the memory and even with MB() get rid of re-ordering GPU might still have a chance to read stalled data from ring buffer as long as it is mapped USWC.
> 
> This is why only cache plus snoop memory can get rid of inconsistence issues.
> 
> Besides, do you know what's the rational to keep all GFX KCQ cache+snoop but only HIQ/KIQ from KFD configured to USWC ?
> 
> For performance concern that looks to me always the second priority compared to "correct" especially under the case HIQ contributes very little to ROCM performance when switching to cache mapping.
> 
> 
> Monk Liu | Cloud GPU & Virtualization | AMD
> 
> 
> 
> 
> 
> 
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, November 7, 2024 7:57 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
> 
> Am 07.11.24 um 06:58 schrieb Lazar, Lijo:
>> On 11/6/2024 8:42 PM, Alex Deucher wrote:
>>> On Wed, Nov 6, 2024 at 1:49 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>>>> From: Monk Liu <Monk.Liu@amd.com>
>>>>
>>>> As cache GTT buffer is snooped, this way the coherence between CPU
>>>> write and GPU fetch is guaranteed, but original code uses WC +
>>>> unsnooped for HIQ PQ(ring buffer) which introduces coherency issues:
>>>> MEC fetches a stall data from PQ and leads to MEC hang.
>>> Can you elaborate on this?  I can see CPU reads being slower because
>>> the memory is uncached, but the ring buffer is mostly writes anyway.
>>> IIRC, the driver uses USWC for most if not all of the other ring
>>> buffers managed by the kernel.  Why aren't those a problem?
>> We have this on other rings -
>>          mb();
>>          amdgpu_ring_set_wptr(ring);
>>
>> I think the solution should be to use barrier before write pointer
>> updates rather than relying on PCIe snooping.
> 
> Yeah, completely agree as well. The barrier also takes care of preventing the compiler from re-ordering writes.
> 
> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> index 1f1d79ac5e6c..fb087a0ff5bc 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>          if (amdgpu_amdkfd_alloc_gtt_mem(
>>>>                          kfd->adev, size, &kfd->gtt_mem,
>>>>                          &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>>>> -                       false, true)) {
>>>> +                       false, false)) {
>>>>                  dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>>>>                  goto alloc_gtt_mem_failure;
>>>>          }
>>>> --
>>>> 2.34.1
>>>>
> 
