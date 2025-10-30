Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0D6CCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 22:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B8910E0CD;
	Thu, 30 Oct 2025 22:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N0ozbrX+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF61910E0CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 22:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGQDsPkcCVLEkr0nU5mme1TGaJxUPeWQXJ+y2hm7e8Uq6Ehpr+QlCXeyX+MrKO0zKB2T39f5sTf8PfgBqJcAiu8gy6RNyoVVuGdageCr1R4R10TBAMxoMK8mmr/Lhdlg17vJWb2xoySmK3qwXTjRfQKoNDOWraHe9rnUP4jFPbBzNAYwzGVyS/BdAcxN4WIZEHqmeGiVyIGZg0++Bhn/0f8LbbHSa+u/Qvi0ma2Y+eC3wE5u4Id/upKXE1ilq3DgTp9l1ouSFFqbgt92MedmxRZ0gZFfABe9cUYTEfUJUE3KauGJNwWuFcvODprtMtWT3LklJ1m/ufFZU6DKlC2P4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urgJYW9CxEC8IHJ3bzNKtD3/4b4myxFvY6TCmp03LUE=;
 b=c0uQyA7YX6NuPbm0Ok2AOiIO65soW5dixcS068Fslnx7ozY4cBan+i+Eku88vsk1ln9gj6MUTkD8t29MCzi+CLwL86OUWM++r2ExODMpFu5FNzuaDZYqvBBZeH/aFxdgfx0gSq5t6Neb+PPZUKBa/tFmsMTLwno6q2eiFzVnJZosTEGwPd21j9Wq/Xw1iB7qGYL40Y+SJa27JZ2uqyH3ya/jf3H4HoKN/ulr4NmX3XwjBXwoaVofC3xZE8qOJVSrsVHGcUfxKYoBxVK7kEp0dVjEHX+Ahp575L/F2Zs+/Z5gPA7nb4yTaSZVxH+wdyfT1C/c09YJEhv1Yyv9WyiZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urgJYW9CxEC8IHJ3bzNKtD3/4b4myxFvY6TCmp03LUE=;
 b=N0ozbrX+h5YyMJsRCD5BqBSlOiOvjPuJV9t2GLvjhqOEvcTkFsUkEGEnaVeYKGKrTLzd4FaLJFJbLd42jTCJ+Oy8QLSd8tNy2bjOcESiO/TJ7JIcFI3PW0fPjLQy3HQbT0S0FxVOeeP9EBqrmqYMktnWoGockkhOp3y8dF393Tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH1PPF16C2BD7B0.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::607) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 22:39:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 22:39:38 +0000
Content-Type: multipart/alternative;
 boundary="------------fa0rDmytPl9TzBb8d0fz5DwF"
Message-ID: <bf4723fe-24f8-43d3-95b6-302015c26b46@amd.com>
Date: Thu, 30 Oct 2025 18:39:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
References: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Cc: Philip Yang <Philip.Yang@amd.com>
In-Reply-To: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4c848a-f6e4-484a-9e9a-08de18053507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmlrT3ZKM1lCMERlWEh4MFh2Y1hhejh2ekFiM3FuaEpWbGZhc01wRmYxWTJM?=
 =?utf-8?B?WDZBc0ZhZ01JUU1WOFd3L3hVN01kWk43SWJUbGNaYzVpYk9sOTErVHc0WlNl?=
 =?utf-8?B?WUx5WFRsQitGL2NEQXluUnZ2MHkvWENJR00vbk9BQUMrVmgvSzMvYnQ0RWVO?=
 =?utf-8?B?WUV2VjlQR1d2RzI3VkpvblhqWUpNK2NoMEVkZFNNaTh6ZGtoZ3ZOREtvMGxx?=
 =?utf-8?B?Z3hQWmFCV2p0TVJqbG85S2xhQUtOcXNKeTMvZEFtdE1Xd3JzQk5HVkxyTVNB?=
 =?utf-8?B?Ti9JVzQ4SGVmd0pvcFV6M25jcDhPOGJyZ291c2ZlbHlsWHlPTVArenNHM2tR?=
 =?utf-8?B?Zk9hSWdSNmNzK1ZQenE3cngzallaSU5iL2paMm1sU1c1SWFqdmFpdHNIQU1N?=
 =?utf-8?B?ZS9xYjBNZVFDckFrd1JSNWVHZ2JWaWhUT0pFRG5OV2todGppM0VndWFLSjRF?=
 =?utf-8?B?SVpNdStxM0g5MzI2VmpoekJKQXp5OXpGVXZmNHNDZU5yUzlzc3JQWkZybDdr?=
 =?utf-8?B?eDc5cVNyMmJyVE9rZUtGZ2c2aFBXVC82cUJ3MmdJUDhVQXIxd3phdjZvSkY2?=
 =?utf-8?B?RlNGR3pyUWlCOXVUdUUzck5yUFFHNitjb2pzeFFpWnRvdEtDcWZxaXdqMXNw?=
 =?utf-8?B?WDh5dUdHeGlIa2xVbUw3NTRML3JQVEZLcWIrb3V3R0NlU0NEQ2FjVmVXaXBW?=
 =?utf-8?B?eGxoVDIwMW5hSHZvV09xZWYyWTBMN3dUTm0xSEQvUnJUMGpqRWNIck1Yd2k5?=
 =?utf-8?B?Wm9QUU5WMFpsVlZWM1h4d1RIU1B3RnNHb0VIeTdTRy9lMXVmaWlrQ0YrU2I3?=
 =?utf-8?B?TENUS2w4QW41bG9EQTd5UGZ1TUdPYmhTYlRjOTQ0eHM5QSsycnNtVVNyUTcv?=
 =?utf-8?B?V0cyK01DTUhSMWJRMFdoKzRuYnJGRDFQeGphK1FXM0UyMmRUTExOQ2Rva2ZL?=
 =?utf-8?B?aVA3b2txVW56VFE4Z0xTOHU3dTdzYnZ6K0NRV3RZMDFNeGtiOEZYdG9vOXJn?=
 =?utf-8?B?WUY1ZUNIWGpuN3phVS9zTHBDRURhaU5lZmZrSTFSOVRXbDl6N1U2RzJFZHZp?=
 =?utf-8?B?SlQwTWNiMzdDaGZlUHlPRzNTMUZTMjBja1JJRVQ2S2VOWFN1aXBvSU9mRHdS?=
 =?utf-8?B?amVQTk8rTGY5WG56NUZxeklHZkFtQ0Y0WEpVdXpGMEtaU1FtRGJ3VCtsaG9J?=
 =?utf-8?B?TXZ1dTh5WWVuVmk5QlBFRFFNdWNrU2hRT3N2SkJzUFg2NThMOEZWdlcwdGdS?=
 =?utf-8?B?VEdpQ3U1NHJyQlZKMVB0MW5mWVQzOG1FcExSWUdUQTdIZGZJK1dLcXdYZURt?=
 =?utf-8?B?bU1DZXcyQWU0eUlqR3FqYXZ6MGZDeGxqdjNhMlkvc1RtclpJTTkzNGxDTnRD?=
 =?utf-8?B?SzkrSzdyUmsrazB6Rmpwd0JQRHY4UThqTW9LQy9ld3BxdU1YZi9sTDZpcXNH?=
 =?utf-8?B?R2FvTXVQeUU1MDE3TmZCSlI2Y3lzVzRDUzMrMk05c2NzU3pZcm92ZFJWQzdQ?=
 =?utf-8?B?OFZNZ0ZtZnIxTVJjOXNXU2NYeGtzQ3RhcTYvV0dNMDdhVmpEVlBvM3ovVFNU?=
 =?utf-8?B?emEwYXBRRWE4MXVQc1Z6WkdOYUJCU2pTUUVUekpEKytNeURGaHV6cFljanF6?=
 =?utf-8?B?OUFLSVZ6L1NnRi94d2I2WjNhZUpiQjZ1cUpIMGtrQU1JNDd5aGRIa2szTHVm?=
 =?utf-8?B?eGYyMzJuRE5yR0E1T0IvaDJSUndOUWs2NHFCM2J2YzdlRVgrZXlnMVZSamJj?=
 =?utf-8?B?S0RaUkFHK0Jyemh0RExjcE1LM3BHTUlKSUxDOWNZUEwrQjRoNDhRbFlRVkVm?=
 =?utf-8?B?bkRjcW05eWQ5eklJbDhBVno4WEttSGdIOW1oTTBzNUoveUszNWtiam52NDJR?=
 =?utf-8?B?UjNLbDh5cHowL2o2bExpS1d0WXpIbkdsZG9xS2QxT0tDSmw3OTlNSVByaHlF?=
 =?utf-8?Q?cRvY3HlcSFv+7Wv41G8gQ/SNJGT0BCxy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZyZW96RDZlbEJpYzhXdmZiNGJGK0tVZ1VMUFpubUtlNXVZOFZqMEZuTm5O?=
 =?utf-8?B?L0t5amFYMXN3cTFPZlRLT1c2UlI5OTFwQ2NOd0xhbzcybEFWZGE5M0s5WGlK?=
 =?utf-8?B?bTgyaHFPTnpsUVIrUWhxK1lZMUl5RDdQUjZKaWtUZmNaWmgvOGI5RzcvaDhT?=
 =?utf-8?B?K2UxcTJTSitJMEg1STU2ZUhUcXV6dmxQWUZhZzdZU3dzS0VobUdjbmdZaC9L?=
 =?utf-8?B?RHVKM3drUkRWZEtBVEs1YzQ5SHdUU1JUUGJwNkl0Tlo4TERQVmo3ZytnZjhD?=
 =?utf-8?B?VGl4QkZlUGJEL25PYXcrQndIQWlQMThxbDRLczVEa3RXZTBHdWdBOTRCSzkv?=
 =?utf-8?B?MDE0eEp2b3N1U3Z2d25aRjJKNXNIK1NlRlRUcTlnKzBFY1F1OFAwZVUxcU9t?=
 =?utf-8?B?bjlXRU9ueEs1b2VKSFQvSGlMMkh5OEwyQ1l5RUc2b2tzUXY4SmxXeDQ0eHY1?=
 =?utf-8?B?QjQ2ZnFDS3dQV3BWT3BkSlQrdjA2MmFSSVVmbmV1TStjTE9VRUgrMDRoVURm?=
 =?utf-8?B?VFBKRWl6WkV4eW51dVE2ZnlJc0pIQU9aOUlMajZHUE1HdDdRcXVkYmd0anFx?=
 =?utf-8?B?Tm05SU5yYk5BMi9zSzVieEhVRmkxSG1nTnFPS0xnM1RuQk5wWDF5Q1BObWRh?=
 =?utf-8?B?NGFJL043Nmt1Sk5QYUwwZlFIUmhqNDVUTmYxSGxVYVpWVGI0TUNEdldxZHRu?=
 =?utf-8?B?S0dHVzBVNURnRzBnQ3VLbmFoc2g0MEJ4UGh6dVlCM3pFUUNXclVrYm1HM1Jk?=
 =?utf-8?B?M1NzQmk3UVdxaXQ5K1JzSnVITGR2djJlZGNyTU91ZHlnQVorQVN6UnVjMTZm?=
 =?utf-8?B?cVdyeVg3d21TcGV1ZXhLNDhVZkNJMmxrTnNTREtrR2RKU2F2UzRIQzA4Mzlk?=
 =?utf-8?B?QW1QZEdtaG4xSmRBWE9yNTdoamwzMUJRWTBnazFWNVNCRCt0VTlJK1d5ZU1i?=
 =?utf-8?B?Mm90TXFtYVhZKzZvVmxGdG0yY09maXlFb1lEbVY5Sk5rME1rTm1DUFgyRThR?=
 =?utf-8?B?WHIwTVIydG5WYjhMM2hOalNJeTdyM3NrOEVKalVjNDdOSUc4YjNScHpPeFdt?=
 =?utf-8?B?cTYrNkRCbWRxOGNpSGFoMUV2S2dLalRGQlIxSncrTzR2ZlBVT0NtVlcxb1E5?=
 =?utf-8?B?TStJK05CKzF4em9uS3dKQ0N4eTBCYnZUaGJrS3NiaWM3WUVxVThyaVdYQWtM?=
 =?utf-8?B?b1RHY0hPNWNxVXI2MFZiNTN6d21seEg0dzJWbHRCcURQcTRnMSttVUZ6L2Q1?=
 =?utf-8?B?L2JjMTZkMS9RcHhidXpZclgyTU96Y2NPQXJaYitSb2d4b0RhYmJTZmhrdFp4?=
 =?utf-8?B?d1RXZk9qOHhRRmdOY3hxSE9UbTVtb212RE5VUTJQc25EaVpjclRhNDJ3dkdq?=
 =?utf-8?B?N3V3R2VFUXFPcTYxOW5RdUs2S3FkbzlwR3U0M0YzcDZCVU0rRjZkeXdlbzI1?=
 =?utf-8?B?SDBQbTEzQnVwQkI2WEpmVFBDbTlhN2FsUHZxOUxqbnZURzRrY2lkcXZSZ05Z?=
 =?utf-8?B?Rk4rR1VVaHJYd1ZyUTNWTkFRVG5SczVLeHU0T2VBdnc4clVEQzc3Sy9xYjNo?=
 =?utf-8?B?Q28xNEY2NjU2SjBKL2ZxSHhiMEZWMmhuMGQyakR4bUFDYlUvZ0x4c3pBZ0M2?=
 =?utf-8?B?QUlxeTB2YWxuUE45bVp1VDNoOVI3clY4eTNHdjNYaFlVTWNsQk9sMUNnR2tX?=
 =?utf-8?B?aWxHb1I0YjRDb2d0TWMzWlVqWEhYeWJOellHNkREdTl3RkgwbytoVWtEdmtN?=
 =?utf-8?B?SzZOZ3ZvL0k3MVZ5azFKWGpwMG83WXNFWURueEFrc2NtNHR4bGJFMFRZTU51?=
 =?utf-8?B?T01wejdROVYvZzF0cXU0amx6bVlKNG42cGVGWUJwVnJHUUYwR3lhNkRuZXRk?=
 =?utf-8?B?aWRjVDdNMFRMTk93eDNvN2MvcVJFYzdQRlMzU09qbEtJSWV6Z0dZdkxHTkxj?=
 =?utf-8?B?czhrWkJMN1BXOFVMRkVyT1BMREMyM3dMWERaZDhHZ2VkL3l6OFczS0FEMFMr?=
 =?utf-8?B?QXpyeXRPS3krN0w2UDY3Q056YktPbkNYT1ZBU1VvdUFacVUwM1o5VFFEK2Vs?=
 =?utf-8?B?NW9ubFU3UjlSZDFwR09INm00RGh2WkdoOE1MeVBkZ29FbzJFWVpidktKTTdX?=
 =?utf-8?Q?v6QkktXqiXc/ZgABHfEAIMOI0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4c848a-f6e4-484a-9e9a-08de18053507
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 22:39:37.8887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu8KpJpTNFSK4z+L0T4zbTdE1ZpTDxezsd+cRmMmnq2RtELrh1elMIVVLJyfNnJ2V6rA8ER2EzghPnln0mivnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0
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

--------------fa0rDmytPl9TzBb8d0fz5DwF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-10-29 21:00, Harish Kasiviswanathan wrote:
> Fix the following corner case:-
>   Consider a 2M huge page SVM allocation, followed by prefetch call for
> the first 4K page. The whole range is initially mapped with single PTE.
> After the prefetch, this range gets split to first page + rest of the
> pages. Currently, the first page mapping is not updated on MI300A (APU)
> since page hasn't migrated. However, after range split PTE mapping it not
> valid.
>
> Fix this by forcing page table update for the whole range when prefetch
> is called.  Calling prefetch on APU doesn't improve performance. If all
> it deteriotes. However, functionality has to be supported.
>
> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
> VRAM
>
> Suggested-by: Philip Yang<Philip.Yang@amd.com>
> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c30dfb8ec236..76cab1c8aaa2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   {
>   	uint32_t i;
>   	int gpuidx;
> +	struct kfd_node *node;
>   
>   	for (i = 0; i < nattr; i++) {
>   		switch (attrs[i].type) {
>   		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>   			prange->preferred_loc = attrs[i].value;
> +			node = svm_range_get_node_by_id(prange, attrs[i].value);
> +			if (node && node->adev->apu_prefer_gtt && !p->xnack_enabled)

I don't think you even need the condition based on apu_prefer_gtt. You 
can always set update_mapping. If you are migrating, it would update the 
mapping anyway, so it shouldn't make a difference on dGPUs.

More importantly, I think this may apply to other attributes as well 
that result in splitting of a range without causing a migration. So this 
condition could be moved outside the switch-case block and the loop:

	if (!p->xnack_enabled)
		*update_mapping = true;

I see we already do the same for the access attributes. Just generalize it.

Regards,
   Felix


> +				*update_mapping = true;
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
>   			prange->prefetch_loc = attrs[i].value;
> +			node = svm_range_get_node_by_id(prange, attrs[i].value);
> +			if (node && node->adev->apu_prefer_gtt && !p->xnack_enabled)
> +				*update_mapping = true;
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
--------------fa0rDmytPl9TzBb8d0fz5DwF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-10-29 21:00, Harish
      Kasiviswanathan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com">
      <pre wrap="" class="moz-quote-pre">Fix the following corner case:-
 Consider a 2M huge page SVM allocation, followed by prefetch call for
the first 4K page. The whole range is initially mapped with single PTE.
After the prefetch, this range gets split to first page + rest of the
pages. Currently, the first page mapping is not updated on MI300A (APU)
since page hasn't migrated. However, after range split PTE mapping it not
valid.

Fix this by forcing page table update for the whole range when prefetch
is called.  Calling prefetch on APU doesn't improve performance. If all
it deteriotes. However, functionality has to be supported.

v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
VRAM

Suggested-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c30dfb8ec236..76cab1c8aaa2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 {
 	uint32_t i;
 	int gpuidx;
+	struct kfd_node *node;
 
 	for (i = 0; i &lt; nattr; i++) {
 		switch (attrs[i].type) {
 		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
 			prange-&gt;preferred_loc = attrs[i].value;
+			node = svm_range_get_node_by_id(prange, attrs[i].value);
+			if (node &amp;&amp; node-&gt;adev-&gt;apu_prefer_gtt &amp;&amp; !p-&gt;xnack_enabled)</pre>
    </blockquote>
    <p>I don't think you even need the condition based on
      apu_prefer_gtt. You can always set update_mapping. If you are
      migrating, it would update the mapping anyway, so it shouldn't
      make a difference on dGPUs.</p>
    <p>More importantly, I think this may apply to other attributes as
      well that result in splitting of a range without causing a
      migration. So this condition could be moved outside the
      switch-case block and the loop:</p>
    <pre>	if (!p-&gt;xnack_enabled)
		*update_mapping = true;
</pre>
    <p>I see we already do the same for the access attributes. Just
      generalize it.<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com">
      <pre wrap="" class="moz-quote-pre">
+				*update_mapping = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
 			prange-&gt;prefetch_loc = attrs[i].value;
+			node = svm_range_get_node_by_id(prange, attrs[i].value);
+			if (node &amp;&amp; node-&gt;adev-&gt;apu_prefer_gtt &amp;&amp; !p-&gt;xnack_enabled)
+				*update_mapping = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
</pre>
    </blockquote>
  </body>
</html>

--------------fa0rDmytPl9TzBb8d0fz5DwF--
