Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA99C25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 06:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DCD410E268;
	Thu,  6 Jun 2024 06:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5raOJlPf";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEEF10E268
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 06:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3eaC8uuovMfGtmTzmN3Ygk7rdeMHKF8kMW0zI10rNSm+wzOP6Dh6up35cm4Y7fUA2dK2SdEomiWWCCJbXfWYDq6HBw3ghKZM7hkwXCrHWv9rKMuAvHaufjTfesKlGIrH0mgxZTP7VCPXCLmgoQUjfcFlRfpKAihDuH2RkTtBNnSCOOgFZeeM7Idt35L6VZTb4/9HYAIrnDxkGfb2SyU5MT+Avs23Ovv+FrnTaGqJKag8di6ZBkBjXYKJveBFkX3KnxtYTLjyHdxUR+qO3zl8Zspkj1AMt5sKQ6kFn6LulRZIVnYxvffde9fYrbGQ5VJEdFmuL+GjBmH1CKLb5dA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lla6cRBS9eKAmw5bHg/waQ+YFryUAIJqOYFNsXdnCPI=;
 b=PGsDGF0uEKHahimigNCL2ehc8b11Pp0zBWXo0+ILb88DbeG/OMO1b+a7LGvoIm3ZXLaIAb5G5/m2h4gdWVXiryZTjS0fQEVGKmvblftkvPNJ9/iZXLxcHiJZSHUfXBNyMU/Tk4LmZzqCVLfHOfjbByf5aPv3FgDZWn+fUOpempFq31kxnVlZZC3bl2Inzi5yaYwYQmvYNPRidy0n90Ilu1JtKMwJjsn1b8Uh3197VMcjfgmZ3hRc1pnfiikYa+DpMKaBng/TnJiPHkr1bY36UQnI/izi2xEzR/dXLTA6MH6w99SeGkPrz6yvj+RYiWaqpS7R4nISF6+TN0zLQafRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lla6cRBS9eKAmw5bHg/waQ+YFryUAIJqOYFNsXdnCPI=;
 b=5raOJlPfunkDt2irLam3l71YTWX7UrnorHEoxaGuxDGbA5NZDo6zb57PRWT2mUEMEIJXsDVu3Uw3yPeFLsb/gpW1wlzdptF61Bgzf9sMNog5vN9jloMzH2v7lUSUkqMm+9wDbc14Oaz/znxlLB/G/U8kKRGM+MECxXdEvigBups=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 06:19:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 06:19:27 +0000
Content-Type: multipart/alternative;
 boundary="------------E7JDn7L56MiS6cLgnfgEmcAm"
Message-ID: <0e63d585-cba0-4941-ae9f-4de91ab15e67@amd.com>
Date: Thu, 6 Jun 2024 08:19:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: revert "take runtime pm reference when we
 attach a buffer"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: shashank.sharma@amd.com, Pierre.Jabbour@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20240605123159.90950-1-christian.koenig@amd.com>
 <CADnq5_Pq4jh7VrageBKPX4Qp1sGWPHTte2s_pxL20iQiosjUyA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Pq4jh7VrageBKPX4Qp1sGWPHTte2s_pxL20iQiosjUyA@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6387d6-e1d4-41b3-13bf-08dc85f09de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjI5QzlPNEluMGdBeHFYTHRsekQwT1BwOVI5bnZKNVdhb3JpeUhjMzFMWTVG?=
 =?utf-8?B?TzJmUkNBV3djbm1PT1NwbzEyaGlyeEJWMDI4Yk5yRHQzdkFjVGRHaFZ1ZGdk?=
 =?utf-8?B?SFFpMFNRVHlYT3hYY0JBQmdqanJLb1IrMjNHWFVKZ0VvT0tSVUU3Y2pVdGhR?=
 =?utf-8?B?ZWtMUFZzbGJUci9IK3NmLzlpOTE0dnNJL3pPLzg4RXd2R3RrYThzRnNYYnYy?=
 =?utf-8?B?TkNZRkt4M2FvaVdZY2NRNVJmQWk4dCtaYmJUYVc5aE9zSjJVQ2RVMUhZckVS?=
 =?utf-8?B?ZytxYUNFZCsrVVFJRXVpYWxEZHk2RlozSkxZb2pQaWFRVHVFRlF6Y3NJZ2VQ?=
 =?utf-8?B?UnViaEp5S281N0NqTnhGR2FVZmtKSmpVeWJXSnFIUkZVamIrWHF1b3J5NURH?=
 =?utf-8?B?cDFvZjNTRXplWTBNd3l5akdTWXRmRXlwUVJrc3BpRks0WnJsQWdDQVlPK3Rh?=
 =?utf-8?B?NHFhMWdQZnJPd2UxT1FBa0UxcXI0QjhuaVo2cVZBY21zZWJWNzg5WXNUZHJS?=
 =?utf-8?B?MU5vbEFqaFpaY3ZUd1U2UFJ2TURxaVdZWlA0ZzQ1NlZ5RXNmbG1GY0pOcSsv?=
 =?utf-8?B?dVdIVmVldUVDU0JBYWd3RFRJV0xyTmRLVmt4SVhicFVLRnBtNXNxWnpkUmtV?=
 =?utf-8?B?dytsVzJSU3JQS2kyZ0pOUU5wTE1NSHEwV2dwWnRiWkVBSjRZT0JGWTZBdm1o?=
 =?utf-8?B?Z1dKWVVpUjJTWlRXZC9GZGkwT0JrR0F4cXB5SlNJazMzWTIycjdNbDVOWDRN?=
 =?utf-8?B?d2hQR0RmQVBYc1dVY0QwYlZ3R1FMRG85c0Q3bmcxL3daR3hCT1FBdlBXd3Ra?=
 =?utf-8?B?OXNISXlZdlpVUityRS90VnVkRFdPZzcvNEc2Y21kYUpDekhsT0Y5bDZQU0pv?=
 =?utf-8?B?NitmbHU2Z3lQdTZvSzhFRGxiditGZlZHeCtleXpMWTJHNkM4T1RqUjArSE1K?=
 =?utf-8?B?WlJMajhXd0o4TXlic1hIczFMRFNpMlNLNTY3Y25CZSs2cHBFWVJhWG5NTVdy?=
 =?utf-8?B?dE12MURoWE5kWFdzQ1FFSnpDVWtjWDZXTmVLMk9ZU2ExU1pqcGZpWjJZV3Fo?=
 =?utf-8?B?dUJHaVdxWVBRYkk0Yk5iWElkaFpMWGR4ME4wdVhaZTB3TGNDakdSQTJHK3Ix?=
 =?utf-8?B?dWJvSnAxdS9zeHJlelp6eVlQNFl4Q3hHWGhnRmcwZk1yTTJtZEhBV2xqQXNU?=
 =?utf-8?B?cUpoQzNESGE3OFJhZzYxaU9qWWRWUmlWSGlvT3JoNm1RbnV3b1N5bWVhOEdO?=
 =?utf-8?B?RWV4eHV4amgxNC9LTmlyNzVOc2ptTS9kbFRUdjhHRUowaGJMRFUzTEZuSFV0?=
 =?utf-8?B?SkFub0Z0amdRT1Nqa2ttM2Z1TWVJOWhVMVdCUlFQbHFDZVUvU1BkeVZCbjF5?=
 =?utf-8?B?WklKc3YrNjRYUmU2bnpBWWNuV08wRzBoMjNoTHE3MkxQR3l5QklQaTQxNk52?=
 =?utf-8?B?RjZ1Ky9lZ2V5Y2hVb28zNHFPN1NkaWs4aVJ6SDNTUkhLWjBCWWhjd0FJSmJB?=
 =?utf-8?B?VnVoTG9QTkZhSStwWXJxaC9lM3F6ckJ2SWdrRVc1ME5OcU9TNTEvRlQvcSth?=
 =?utf-8?B?WTdoNDB0UlNHbXc5V0padnFUaHZoaVM5aEJFTnFMVmZQcXIwMk1PN29DSk1Z?=
 =?utf-8?B?TTUzVnZnRElRdjJUWTRDb0hBRGRKY3NtSVlBbzZsaVBKbHVxOTU5cVNCRG9h?=
 =?utf-8?B?ZVhHSmlnYXhuNUJDN2lPOXhlVVRESWY5cVZZUzZhZVZHbzYvQ0JrVll2Rjhr?=
 =?utf-8?Q?4kXtP7iqL+pluvbGWE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNjTW9mT3NyaW93NFdZVW1FNUpHeFIxRm0rV2NOY3c3a3BLeXNaMWNRdTF6?=
 =?utf-8?B?a3FBNTZBQnRSdFpBS2lWekR5R2ZoZjRQcXNBcjhBK0ZnR1hBOHdrSndwU3Mv?=
 =?utf-8?B?TzNOeGFwKzFuWmpzSURtRjRodmpJUUlFM2g2R3piTTNFc29yazhhbGxaNmpi?=
 =?utf-8?B?QmM5b2RmTUZ2RU9qQ3UrK3IzMlFyTmFidHF3WEh4dXV5Uk8vYzRYS2pxSURp?=
 =?utf-8?B?UFRucVBEcjhFYzN4UHZSQ01ZQWg5dk9pQXQ0TTVUajVxM3M4SzFSdXpZQTVs?=
 =?utf-8?B?M1FVSTdUdHpPeVBhZ0ViNW56bk5yU25JZUxPdTdyR0R2NXY0ZGJLSURMKzlx?=
 =?utf-8?B?M1pJQjVvRGEvMHVlZ1AweTRGNGhkd2JtRll3RldBYytkQjhjUWNhTDhkek05?=
 =?utf-8?B?akpHdkoxUVpPcTF4dlNITDcrUXZ0V2ZxQW1yMXFiSmIzbDJVai9TZWJvNXVs?=
 =?utf-8?B?Q0hyaGRZNmZOTjlBbnRDUjIwakY0ZGtreUV2eFljQzBYN2laaUdMVVBMZVB3?=
 =?utf-8?B?ZCtxMlNkTlI3bDJ1TEVUc1lycEpOVmFrbDlLSXF5MTFFVk9paXZob0Nrb3lD?=
 =?utf-8?B?NnBnWE1rdTJ0ZnlseFNycUlyWVN0QVhEMXdQNVBCOUpwLzZhcjVqS1ZqT0ps?=
 =?utf-8?B?akJVNFRVbjMrRjR0TW9Md3lvMVlCZ3J2d1hhK0R3YkhicWk5ZzdTaEhHcGxr?=
 =?utf-8?B?cUEyK3NsNHQ2WCs2Q0ZFRWhERnBYREV6NTdvYnNFRm9iZHZUU2EvTEk4eGNZ?=
 =?utf-8?B?UmZMSGl0dldCdDJWUklIbWFZdjRIbkFEc0lmV25wTklVcjF0cW5yNTZFOXdQ?=
 =?utf-8?B?MUxxOEg5YWR6L1l1L29xbTJXNDVoUGo2WGhSUkpWYmQ1RUtvcjhiNHpabG5n?=
 =?utf-8?B?NXcyRWNlUUdrWHRiSVRBeG82MjQ1S2hNWHRxT0cyNUxrOUZOamc5MndrK01G?=
 =?utf-8?B?bE5ZODRxUVRWTkdOWEpHalFpc3Q2WWhwM1hrMWtIUUhrMllWbTVTMUUwUVFj?=
 =?utf-8?B?YXBoUWE4OERaMnFCTDBxdW1LZGVQend6TVl6bExtcXRzb1BvSDkvQ01rMEdJ?=
 =?utf-8?B?cmc3QzZ2TS9xZ29zWlgzMXROeDZYL0VkVVhpMEducVU1a2dqZVUrcXZsTThs?=
 =?utf-8?B?SmlkR3lsc202T2M0K1o0cUxHb3owd1Yxa0JiMDFCMWtMZ3ZBcGd1a1RVa20v?=
 =?utf-8?B?Z3hGdlBCaXQ1VGp3c1UxelZhL09UaXJoKzNaQTNObGlVeFhkbG1MdXF3bFVC?=
 =?utf-8?B?UUo5MkJsRkpqUk1jSFNISFVSM296R0krYzh4ZUYxQ1o5TnRsakxqSzFHMEd5?=
 =?utf-8?B?K2tmRTlGbFpYVkJ0bU1EMFFCbGNHTjZWUW5Td2xpK0ZGU3VZejZMaFNDM1pO?=
 =?utf-8?B?QzEvZlIxRGZ1VkkzRG5tL1ZqKzkxYkxWeWhuNWk5V3Q3SG50UG51elZIbHBO?=
 =?utf-8?B?K01GMXdSZnBvODdrd0o3QW1iUnFJbW4vbEdXRmNUVnZ1cnZiazB6WXhFTXlN?=
 =?utf-8?B?bUh3M2NBU2txbXdDT1pyV1FHNmRWZGJ1cDUrbzY4ZjFDV2JqcDNhRStSUXkr?=
 =?utf-8?B?ZWc5dzZRcnI1S1NDSXVVTTE1UGkvTW9yb3lkb3pTSloxelVnVnozOW9NRGJ0?=
 =?utf-8?B?aXhVa3BScFp4TVNoc2hFVDJXOG13andJVFM0SXdmK1R0UUh1cEJ5bnB5c3Zx?=
 =?utf-8?B?WG0yTVorMkUvbHlVWTlVNGdaejVsSXdjVExQTTZOL050UUsxNCsvRlFsRWZF?=
 =?utf-8?B?QW9JSHZlNEsyeUtlOVIxODFIY3JOdWhIeUhDdjFpalArUXFRdGRmaVlVc3FT?=
 =?utf-8?B?SmJReGVBOU5KRVRqTEx0K3E1eTFSYUdGTjcyWFBERW94ay96d0gySUJuaDhu?=
 =?utf-8?B?K0hObFlNOWtPRURLTFQza3JwUHBSNXJleWhaWFF4ZnYxMU5CZklFOVFodW1w?=
 =?utf-8?B?NEp4eDYrNkZ2TnpLYlV5QjhiS3FwYWZuT0dCK21JVWFNTWVoUUdaeitmNVB5?=
 =?utf-8?B?c2t0VjNGMUVUWkJicmRuV1hmTmFPN1FJWmM4MnBCT3FMQWl6a0lyWTc4QTQv?=
 =?utf-8?B?KzQ3OUFqbVRQb1RqL3UxeWVkLzZ4dmdEZTdnK2xpcDZmZmtuQlNjRVlPMnEr?=
 =?utf-8?Q?jFPfdWshl9OImURL0dDDyKc8V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6387d6-e1d4-41b3-13bf-08dc85f09de7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 06:19:26.9538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQuWQkyYTOWUruvJmotFul1R4NZWjPSzLLnPabnfdPltrN91ima9WigfhHh/RHUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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

--------------E7JDn7L56MiS6cLgnfgEmcAm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.06.24 um 15:20 schrieb Alex Deucher:
> On Wed, Jun 5, 2024 at 8:32 AM Christian König
> <ckoenig.leichtzumerken@gmail.com>  wrote:
>> This reverts commit b8c415e3bf989be1b749409951debe6b36f5c78c and
>> commit 425285d39afddaf4a9dab36045b816af0cc3e400.
>>
>> Taking a runtime pm reference for DMA-buf is actually completely
>> unnecessary.
>>
>> When the buffer is in GTT it is still accessible even when the GPU
>> is powered down and when it is in VRAM the buffer gets migrated to
>> GTT before powering down.
>>
> Won't that kind of defeat the purpose of P2P DMA?  I guess it's a
> trade off between performance and power savings.

Not really. P2P is useful because ti avoids the extra bounce through 
system memory.

But when the ASIC is powered down and not producing any new data there 
really is no extra bounce.

>> The only use case which would make it mandatory to keep the runtime
>> pm reference would be if we pin the buffer into VRAM, and that's not
>> something we currently do.
> We'll need to bring this back if we ever support that?  I think we'll
> want that for P2P DMA with RDMA NICs that don't support ODP.  That's
> one of the big blockers for a lot of ROCm customers to migrate to the
> in box drivers.

Yeah, but we need a completely different approach in that case.

The problem is that calling pm_runtime_get_sync() from the DMA-buf 
callbacks is illegal in the first place because we have the reservation 
lock taken here which is also taken during resume.

So this here never triggered or otherwise we would have seen a deadlock 
(I should probably mention that in the commit message).

Christian.

>
> Alex
>
>> Signed-off-by: Christian König<christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 33 ---------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  2 --
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   | 15 ----------
>>   3 files changed, 50 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 0b3b10d21952..ab848047204c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -41,8 +41,6 @@
>>   #include <linux/dma-buf.h>
>>   #include <linux/dma-fence-array.h>
>>   #include <linux/pci-p2pdma.h>
>> -#include <linux/pm_runtime.h>
>> -#include "amdgpu_trace.h"
>>
>>   /**
>>    * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
>> @@ -63,37 +61,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>>          if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>>                  attach->peer2peer = false;
>>
>> -       r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> -       trace_amdgpu_runpm_reference_dumps(1, __func__);
>> -       if (r < 0)
>> -               goto out;
>> -
>>          return 0;
>> -
>> -out:
>> -       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> -       trace_amdgpu_runpm_reference_dumps(0, __func__);
>> -       return r;
>> -}
>> -
>> -/**
>> - * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
>> - *
>> - * @dmabuf: DMA-buf where we remove the attachment from
>> - * @attach: the attachment to remove
>> - *
>> - * Called when an attachment is removed from the DMA-buf.
>> - */
>> -static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
>> -                                 struct dma_buf_attachment *attach)
>> -{
>> -       struct drm_gem_object *obj = dmabuf->priv;
>> -       struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>> -       struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> -
>> -       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> -       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> -       trace_amdgpu_runpm_reference_dumps(0, __func__);
>>   }
>>
>>   /**
>> @@ -266,7 +234,6 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
>>
>>   const struct dma_buf_ops amdgpu_dmabuf_ops = {
>>          .attach = amdgpu_dma_buf_attach,
>> -       .detach = amdgpu_dma_buf_detach,
>>          .pin = amdgpu_dma_buf_pin,
>>          .unpin = amdgpu_dma_buf_unpin,
>>          .map_dma_buf = amdgpu_dma_buf_map,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 10832b470448..bc3ac73b6b8d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -181,7 +181,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>>          amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>>                                 seq, flags | AMDGPU_FENCE_FLAG_INT);
>>          pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>> -       trace_amdgpu_runpm_reference_dumps(1, __func__);
>>          ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>>          if (unlikely(rcu_dereference_protected(*ptr, 1))) {
>>                  struct dma_fence *old;
>> @@ -309,7 +308,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>>                  dma_fence_put(fence);
>>                  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>                  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> -               trace_amdgpu_runpm_reference_dumps(0, __func__);
>>          } while (last_seq != seq);
>>
>>          return true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index f539b1d00234..2fd1bfb35916 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -554,21 +554,6 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
>>                        __entry->value)
>>   );
>>
>> -TRACE_EVENT(amdgpu_runpm_reference_dumps,
>> -           TP_PROTO(uint32_t index, const char *func),
>> -           TP_ARGS(index, func),
>> -           TP_STRUCT__entry(
>> -                            __field(uint32_t, index)
>> -                            __string(func, func)
>> -                            ),
>> -           TP_fast_assign(
>> -                          __entry->index = index;
>> -                          __assign_str(func, func);
>> -                          ),
>> -           TP_printk("amdgpu runpm reference dump 0x%x: 0x%s\n",
>> -                     __entry->index,
>> -                     __get_str(func))
>> -);
>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>   #endif
>>
>> --
>> 2.34.1
>>

--------------E7JDn7L56MiS6cLgnfgEmcAm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 05.06.24 um 15:20 schrieb Alex Deucher:<br>
    <blockquote type="cite" cite="mid:CADnq5_Pq4jh7VrageBKPX4Qp1sGWPHTte2s_pxL20iQiosjUyA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Wed, Jun 5, 2024 at 8:32 AM Christian König
<a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
This reverts commit b8c415e3bf989be1b749409951debe6b36f5c78c and
commit 425285d39afddaf4a9dab36045b816af0cc3e400.

Taking a runtime pm reference for DMA-buf is actually completely
unnecessary.

When the buffer is in GTT it is still accessible even when the GPU
is powered down and when it is in VRAM the buffer gets migrated to
GTT before powering down.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Won't that kind of defeat the purpose of P2P DMA?  I guess it's a
trade off between performance and power savings.</pre>
    </blockquote>
    <br>
    Not really. P2P is useful because ti avoids the extra bounce through
    system memory.<br>
    <br>
    But when the ASIC is powered down and not producing any new data
    there really is no extra bounce.<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:CADnq5_Pq4jh7VrageBKPX4Qp1sGWPHTte2s_pxL20iQiosjUyA@mail.gmail.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The only use case which would make it mandatory to keep the runtime
pm reference would be if we pin the buffer into VRAM, and that's not
something we currently do.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
We'll need to bring this back if we ever support that?  I think we'll
want that for P2P DMA with RDMA NICs that don't support ODP.  That's
one of the big blockers for a lot of ROCm customers to migrate to the
in box drivers.</pre>
    </blockquote>
    <br>
    Yeah, but we need a completely different approach in that case.<br>
    <br>
    The problem is that calling pm_runtime_get_sync() from the DMA-buf
    callbacks is illegal in the first place because we have the
    reservation lock taken here which is also taken during resume.<br>
    <br>
    So this here never triggered or otherwise we would have seen a
    deadlock (I should probably mention that in the commit message).<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:CADnq5_Pq4jh7VrageBKPX4Qp1sGWPHTte2s_pxL20iQiosjUyA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 33 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   | 15 ----------
 3 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 0b3b10d21952..ab848047204c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -41,8 +41,6 @@
 #include &lt;linux/dma-buf.h&gt;
 #include &lt;linux/dma-fence-array.h&gt;
 #include &lt;linux/pci-p2pdma.h&gt;
-#include &lt;linux/pm_runtime.h&gt;
-#include &quot;amdgpu_trace.h&quot;

 /**
  * amdgpu_dma_buf_attach - &amp;dma_buf_ops.attach implementation
@@ -63,37 +61,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
        if (pci_p2pdma_distance(adev-&gt;pdev, attach-&gt;dev, false) &lt; 0)
                attach-&gt;peer2peer = false;

-       r = pm_runtime_get_sync(adev_to_drm(adev)-&gt;dev);
-       trace_amdgpu_runpm_reference_dumps(1, __func__);
-       if (r &lt; 0)
-               goto out;
-
        return 0;
-
-out:
-       pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
-       trace_amdgpu_runpm_reference_dumps(0, __func__);
-       return r;
-}
-
-/**
- * amdgpu_dma_buf_detach - &amp;dma_buf_ops.detach implementation
- *
- * @dmabuf: DMA-buf where we remove the attachment from
- * @attach: the attachment to remove
- *
- * Called when an attachment is removed from the DMA-buf.
- */
-static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
-                                 struct dma_buf_attachment *attach)
-{
-       struct drm_gem_object *obj = dmabuf-&gt;priv;
-       struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-       struct amdgpu_device *adev = amdgpu_ttm_adev(bo-&gt;tbo.bdev);
-
-       pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
-       trace_amdgpu_runpm_reference_dumps(0, __func__);
 }

 /**
@@ -266,7 +234,6 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,

 const struct dma_buf_ops amdgpu_dmabuf_ops = {
        .attach = amdgpu_dma_buf_attach,
-       .detach = amdgpu_dma_buf_detach,
        .pin = amdgpu_dma_buf_pin,
        .unpin = amdgpu_dma_buf_unpin,
        .map_dma_buf = amdgpu_dma_buf_map,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 10832b470448..bc3ac73b6b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -181,7 +181,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
        amdgpu_ring_emit_fence(ring, ring-&gt;fence_drv.gpu_addr,
                               seq, flags | AMDGPU_FENCE_FLAG_INT);
        pm_runtime_get_noresume(adev_to_drm(adev)-&gt;dev);
-       trace_amdgpu_runpm_reference_dumps(1, __func__);
        ptr = &amp;ring-&gt;fence_drv.fences[seq &amp; ring-&gt;fence_drv.num_fences_mask];
        if (unlikely(rcu_dereference_protected(*ptr, 1))) {
                struct dma_fence *old;
@@ -309,7 +308,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
                dma_fence_put(fence);
                pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);
                pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
-               trace_amdgpu_runpm_reference_dumps(0, __func__);
        } while (last_seq != seq);

        return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index f539b1d00234..2fd1bfb35916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -554,21 +554,6 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
                      __entry-&gt;value)
 );

-TRACE_EVENT(amdgpu_runpm_reference_dumps,
-           TP_PROTO(uint32_t index, const char *func),
-           TP_ARGS(index, func),
-           TP_STRUCT__entry(
-                            __field(uint32_t, index)
-                            __string(func, func)
-                            ),
-           TP_fast_assign(
-                          __entry-&gt;index = index;
-                          __assign_str(func, func);
-                          ),
-           TP_printk(&quot;amdgpu runpm reference dump 0x%x: 0x%s\n&quot;,
-                     __entry-&gt;index,
-                     __get_str(func))
-);
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif

--
2.34.1

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------E7JDn7L56MiS6cLgnfgEmcAm--
