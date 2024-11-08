Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AE7D5E154
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 10:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C80CA10E966;
	Fri,  8 Nov 2024 10:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jH3Z6Etp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F218C10E960
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 10:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9y7i21l6b8KdWZ8LBQ/1UAd7pBF2XQyETRGrgX2X5l1wGXw0PkY9JuiZ4KoDP7z39Op5h78SSYAMJHFgIS453rP01WdZvi579BcKKj0hchOoM3e5HOq3pk4wTiOV3YxKo7Wh5JBFCQuNuPBWFmc05vlcbwaKJzdm/Ld6exxxZK1heX3JYeXFvurO7Sja9rtRsHDf2quyEjr7iAsnuxFAm9yWI6D6I60Fx5o6zG+mcwINw8nf8EYe5CDZbhiTXOYgsVWlxpl97Kzg57Bs71NcTyZpgqFdrZ1o22VPhsExpppbZ48BPXTDOe7fMdVj4H++GBXtdq9LTsUpTW8W5o6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxcAlt0qgsam4OsjJMyQivsinfS3/NkjnDwdf/evbjw=;
 b=E/Xu2mM0+2SoXmqv68sAsxHKdwMWaQbv6fO14XPyMjKINSRPflE8qhftvUK2o31ZbHBqxz2jSpQY7wlzTSCFoSz6Bcmh6Lyho4ii3s3XZJcsa0Y2u2e52OBQH4z+RhG9+JpSImeTbygySb/lM/yCpWmkgeqchiwk8nRmKX6sbIOE2PDPKeXtYXCcCWhUCGC6oHo05O5XX6FWF5i3ZR0aY4bmF8/cKG1s/rFPFGYOLjYszUd5ZuOI81HXvvXVX9B/IFT5A6nhYpNMklO/2Sh3fFS7lcNC4EyQBPdG8EyhMttWjXVa5vdyx3wnwcrNVb5JlQqwFQzy6Jq0yUNS8a1eKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxcAlt0qgsam4OsjJMyQivsinfS3/NkjnDwdf/evbjw=;
 b=jH3Z6EtpGzQOeYKCIYZebOUY06/Ly70IBLRjtoaFGyPmvbIYplE4eAfadrR3PIbmLaVEGSh5l1HJqy3pqPQWvLfCdIXUIz5FoeEb5QN3IPa3ilFADW3G03Ozpa7o0kHYAy0Bt2kHVYQ7gf5NijoUYh6fl63d04x7jYbtAWEXsRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Fri, 8 Nov 2024 10:41:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 10:41:37 +0000
Message-ID: <ee368151-7be5-4bd4-82e9-f202480cca2f@amd.com>
Date: Fri, 8 Nov 2024 16:11:29 +0530
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
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e99a26-a6df-4d7e-8a1f-08dcffe1ebee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjdMTlQ2M2tKQ084SDFaaC9yN1RwQUpocVFSZ2x6dnl5Wit4clk0bFhCYTJy?=
 =?utf-8?B?MXQ4cG1HZE1OUHM1NThoRHBCRTh6bzB5N0hPK202SGxIK2RWalRMMlQweDNN?=
 =?utf-8?B?eWxUaGpzQTFQMFZqeHlzN2cySGdxWFJ2TTNNaXFVVWNORE9keUlWcUxjUXpo?=
 =?utf-8?B?MkYvYUlWcEtsTXhNRkxCSWQ1TU1XVHRxUURhZnh1M3VjbHNZaS85cmk0UXN5?=
 =?utf-8?B?SHZnT1pQMmpLL21EZ0oxbWdJSTcyRUlwa2o3bVF4VWRVL29OcHhscXRnV1dC?=
 =?utf-8?B?OHY4b2xMSWU4T3RYMWlneGVhSngvVmhkSkVuWGtGV2t2R2czeFJ5NWFCczRn?=
 =?utf-8?B?empPVjRVSTNXejIrUlhXMzFXY3plSzdyemU3L3dSZlJ4Z0YwTWVEMmJCMTRB?=
 =?utf-8?B?TnRQb1VoelRjNEQ4RnJpUytWZ1VZWml5OHljNG9SaTdhS3pkdjJESUwxNmVz?=
 =?utf-8?B?RzlxMkhCQUVTeW0xeExWbnNhKzdaTmVsRjZibWRQVkJxRjdnTGZjeXhpb0Fq?=
 =?utf-8?B?TFphcktZK0pUdDdUSjhmbWdwWmZ3ZC9PSFdWUWZRVjFrQmhOYTh3OFNMbVdF?=
 =?utf-8?B?TithSG5xeFlmZXZzYVpJb2dhdzF6UXZERWpJY0pYaWdoVEI1amF3UUF6RGRB?=
 =?utf-8?B?WWM5RjFqQ2V6aWNDRkw0SCtjd202VytxNjFTRGRWc1dvQjRvOGlrS28rLzhl?=
 =?utf-8?B?d2pjZ2NBUVNDNXNqeWp6ZlNkNHFOdGVZbWdLK2xvbUVMRmtzS2FybEVsWnZE?=
 =?utf-8?B?ODdOU3hsakpjdEczNGoyaDJ2Z2hjQW94UnpQdzZSekI0TUVqY0V0UHJBZWpp?=
 =?utf-8?B?VWVJUHVjOUZPUE1JU2tvTko0d21iTk4vcW1udjNmUE8rZUsvTHYvTHlvUHVU?=
 =?utf-8?B?dlVTQzQwRU5Rc010bXo1aU16TUVQb2ZQMzFuMm1BOFJKN3BlT1NEd1ZzeTZ0?=
 =?utf-8?B?NCtKaDd2ZmpCT1dFRHRzRWxyeXJ6cExBdkpnZjdDVjQzMGt4RnRSWHNpbGoy?=
 =?utf-8?B?SGFjVGVwZ2FaSlh4TVNzNGhXOVl1UTRDWnVVeHhoc3lsR1JEQ2lQMTc2UEh6?=
 =?utf-8?B?bjlsZkpMOGZJS2xvWktuaERoVWl6MVRHajc2U2FnZHpTU1NlY2Fwa3hDWW5Z?=
 =?utf-8?B?RnU0WkhUcW1QVjMrQTBUNXlFRHk5Rnk3UkNPRlRtM2h1R05wMzdsWm1FcTV1?=
 =?utf-8?B?QzN2MEJGNmlDbjluWHRpWXRRalpwd1hvRks1WVVPUXhvV0hEU29XUFJsa0RK?=
 =?utf-8?B?Z1lSaVAvYlpEWHQ3S2ZBV0ZmNVZpNkh5Z3RRbnY0TEk5SnhLWWNiZWxXVWZ0?=
 =?utf-8?B?eTUvRlRkL2c0cUs5di9Md0tuMW1LSG1Zcno1bC9UcEp2dXdycTZZWDdpb2RL?=
 =?utf-8?B?amhnYlRNSHY1V3E3V0I0RnQwcEdpVk5QdlBXbGJ6cUhvY3RSNzVJdkNsc3BU?=
 =?utf-8?B?RmdDWmoyUkt2dkNLMGFhc3EvdlRMeWZGUEl4YnRoNzRsOHNEblBqYXkvSWJZ?=
 =?utf-8?B?MGYvNmhNMVd2MGxVQ0Rvb25kUmNTa1pyUURvUXNYY3FlOEhEQzNqaHFRZW1L?=
 =?utf-8?B?Zk8zODlYNE4rcDRYVXl0ZS9heGJ1SHpKRXV6a1M3ZjgxSndvWGxhcEdyNXJZ?=
 =?utf-8?B?S1k5S2FWbElyRTVySy9NSWlNck5ZSVlkYWdpc3hOTFZMSWtKaXVJdEMzSlJq?=
 =?utf-8?B?b3YybFRjYXRnbUJRbnRYSE9wWk5SMGFHZTMreVk0TmFMZlR5MEZvY3JCSHEv?=
 =?utf-8?Q?K9QGNidc+OAN94cR9/zp7j4GCY93AV8R5p0VhqT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhpck1qcnArcnB1d0dUY0ZvcWw2TkNud1dnanFVUXZzQzhkaEM1ZGFrdmh6?=
 =?utf-8?B?N0hyc2F4UStBT3dnNEVmc1hFMEk2bGtBOFZsZ3JBOHcraDBIU3RLMzlMUHlp?=
 =?utf-8?B?a1IxUWpRazI2SDZZTHF4empsUE9LRHFsLzE2eTh5ang5N3c4WjIxTUc5c2xl?=
 =?utf-8?B?Y1dLemRuZ2ovbndMWUZGc2s3cWhuY3FBNU9vcW1MRUEzOUpqemhuREdyZkRW?=
 =?utf-8?B?M0N2N0VUTDJDTGkxb0IvdFNSQnB4Znh3aTVZbzJNdGxiWWlndUIrRWt0c2kz?=
 =?utf-8?B?TFZ2UjJ0aEUxRTBTcnYrVjUrcWhoR2lOOGNiRElYeFpwZmhETlJHelU5VG5F?=
 =?utf-8?B?ZmN2VzNBbkw3UklaeU9VRmQzbmxpWkFtaXl3VmUrSy9BVkV1dEIvQ2dYYVQ0?=
 =?utf-8?B?WElKNm9hRWNOcHpnWUNuRUMwNlM1UWl6cDA4S0RqQndYSDNvM3FteWpTR1ZY?=
 =?utf-8?B?NVphQkFDVEV4aCtoTUNWL1VlcC9zaWdTblFVeTF0WE1uNk9LT0RTUU02LzNE?=
 =?utf-8?B?U3dTRXFYVnpaSEVHV1p1UzJ2Nmt1ZG14VTI5M3gvOUJ3TjdnNHF3YVBLTlZj?=
 =?utf-8?B?K0l2SitnVkhBTlNzS1dld2w2V2R1VVkwbU9MckRpZEtPbFhFVnNJZ2hHb0xt?=
 =?utf-8?B?NDU4ZzV2NGE1OWsvS2VQeFh6WWE3QXQwNzcveEsyQWxWUUNndFdQYVBzT1lo?=
 =?utf-8?B?eVBPZjQ3ZkxGcmNqcG9ZM21pZVRQZFJVVTk3bSsyZGU1MVl2SFFRNEp5Y3pi?=
 =?utf-8?B?MC9uakFDa1pOMkVoK085RVNYWXZlR1hmemlQL3JUUkxVV1lrWlhDY1c5eFRD?=
 =?utf-8?B?dk83bzRNMXJ6SzhhVnVUVkJkVDIwOTlvU1RvU2g0NnlHSmxiUXdFcFpJYnJu?=
 =?utf-8?B?U2FlZUF6dWRzaU9HVlVwR1lncjdWaGREenhMRENVbFJDY0FKaHhUY0txb2NN?=
 =?utf-8?B?NEtxZWI2alljWHZLYWpiRVlXbStuRXpFSmNqSEhNbjFtcXRwMDNjWUtIc28r?=
 =?utf-8?B?bkFveXFPYUFIRGtiaVF1TmZjTkMzcDNXcWVGVnV3ME15OGt2akdtc24rN2FC?=
 =?utf-8?B?aWxhdUpJWE45bUZXNm82RzRNaCt6dkVWY1pTRG9iVVFHNW85T0szaWxFMnlt?=
 =?utf-8?B?bnYvcUNROFc5MWo1dHRHZ01zWERtbE9JQjl6L0MzZzZSVkY4ci9Bckttb1BZ?=
 =?utf-8?B?QzdER0J0aTlhdkhab0FtdGZaamd6YU9QSk85THF6WGluLzhmRWNDamo2MnNU?=
 =?utf-8?B?MkR1NysyYVk2WUlydnBDWTQ3cWZURHc3KzNDRzF2Z1RpcFNPMmxDQmtPVU1D?=
 =?utf-8?B?ODlTMWVsMmptUEZpYndOUFgraDlLU3FjYUNWOWloMDdpYjlKNlV3blZlZUxO?=
 =?utf-8?B?QTBQMzNDZTVFS1JPNjZQSlhIUGdmejVRWi9JQkNuc2p2SWxkZ1lsQTdNckxT?=
 =?utf-8?B?TUN6NjNUcHM1THc5eWVETGRSVjZNTFF0RUhPSXlpUzFkRmF1OElzdnBidVNZ?=
 =?utf-8?B?SEt0QW8zRG8wRURVbGF5NmVBVHBUT3VEYVR2NU1EUDZvTHlydUtXTlg0Y09W?=
 =?utf-8?B?endTQStmQVhjd0FYSlp3Z3VDSGFRRFJYR0NuT2dlL2o4Tnh5NGVBdnJKU2RX?=
 =?utf-8?B?UWFsdzNJemdMSDNiSmUvNDdBS0R3dGMrbnA2UkZoVm5RN0Z1eGVwdDdDUTln?=
 =?utf-8?B?V3J4c0lWcmRWclgyekM5ZVNWWnhIa1BXNnNTL1dYQUd1VmwwOWZuRFBKKzVW?=
 =?utf-8?B?L3cydlZodEZYbG0vQ1dHNXBPVFVpM0N2Q0xkMnJkcUZIYXZjbEVJMCswdGVr?=
 =?utf-8?B?dDlldDBYV01GMXBJMXpFNVlmeDhIZ2hEMkhLTUwwNHhLbHJtK1p0Zi9BekVh?=
 =?utf-8?B?dUdiY2NTc29KWVhMYWRWUFFVK0sxTEpSMFNRUXhvY0w0ZEpBM1N3Yk8yZXhJ?=
 =?utf-8?B?L296Mm9VQ1JiR0xsQTEySjZ0VzV0L0xHNkVIM0k2VkhnanBCM1dJZXJwdVht?=
 =?utf-8?B?aGpqMFM3S1JXQmpWMmgyMTg4bktseUxNMkFXcklxRWtkMTdJVlhGd0dPcktv?=
 =?utf-8?B?NWtkSlh5STY5WjlGV040NzFZc0QzOUZWWXBuZDY0RXVDZSsrMVFhcE05dXQv?=
 =?utf-8?Q?CdiGK9c5RBjoew/u3l0yiZLX6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e99a26-a6df-4d7e-8a1f-08dcffe1ebee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 10:41:37.4193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAQ8L2eLhFFJ1RNnbS2G5GMiTcCJ31aVrcQACJHdRib4Mm7zlji0vivvEzepQwqH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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



On 11/8/2024 3:51 PM, Liu, Monk wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Christian/Lijo
> 
> We verified all approaches, and we know what works and not works, obviously the mb() doesn't work.
> 
> The way of mb() between set wptr_polling and kicking off doorbell is theoretically correct, and I'm not object to do so... but this won't resolve the issue we hit.
> First of all, USWC will have some chance that the data is still in CPU's WC storage place and not flushed to the memory and even with MB() get rid of re-ordering

This is the wrong premise.

For x86, I see this -

	#define mb()    asm volatile("mfence" : : : "memory")


Below is Intel Arch Manual which clearly mentions any prior buffered
writes are *drained to memory* with mfence (AMD arch manual has a much
clearer definition about WC itself).

Program synchronization can also be carried out with serializing
instructions (see Section 10.3). These instructions
are typically used at critical procedure or task boundaries to force
completion of all previous instructions before a
jump to a new section of code or a context switch occurs. " Like the I/O
instructions, the processor waits until all
previous instructions have been completed and all buffered writes have
been drained to memory before executing
the serializing instruction"

MFENCE — Serializes all store and load operations that occurred prior to
the MFENCE instruction in the
program instruction stream.


Just because it worked because of memory type change doesn't imply that
it is the right way to solve this. You could be looking at a system
config bug.

Thanks,
Lijo

> GPU might still have a chance to read stalled data from ring buffer as long as it is mapped USWC.
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
