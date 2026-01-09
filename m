Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D656D232FC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 09:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C686610E82C;
	Fri,  9 Jan 2026 09:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sg5usJWm";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FA810E82C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 09:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBAjteIkYoyeh3jruOs6nBid0+A7/R5SEregO8+3RPfJCPTvx3PUSlYGZIkEiM04s138nIunnvNqcWA3mdf9F5azVO+W1vOhUvfjrue6iIOkCzo3NaIlK0G8MSX6j/8030yNh1pKnTpV3H+Xt8nRLwEzulPlMF2JaQmsebY1HfOpQ/vzDp2Wau3wYv01a/3D68wJcCUhKI0kTGkea4uKYwNchqTu8OrdBuW+FVYwPWOmAnQ8Q1qtBzv3NqBXLZGpaIhvymUeEy8FyyiQNvsoQxv/7M1X7HME2yyWZicuS7OdelAfY5nsgj2cgRitfvO+9Gp3TMArYNmFV2V5SqNxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzKlrtGj8jFcdOi/3dT8VO2U8Tj1ZUqqO3yV59Mr1AY=;
 b=G3iehCRj1K5DO6V3bc0b77/R5u5WFKRVpT+5vUsdjCiyYN3eBgCHoLFJu7Q1X416oECETwnRfVyISXmQnqecEGPym5+/S3ShhaB5qyKsCxWloOib4wqo7yCAR8Og8sRpoLbvx+tYxbo6q+dw0FbKvqiLNBZzN3DVY8PQf0ctHB2zB+thS/TFx+EMJyM41erkSfxcpZaGCsAyQVYZLZATgzZNEs4tpm5aVzssyRnqs+ftRZRz6kn6ZoyrBq5KI9JRpHXXO6mLVS7ORhEGgM/N6BVVa6dztyDSL6hjuEKD/cjmF7aTwVNwF6t3ysYhDVP9U4tcJTR4N0ObK5W9wEepxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzKlrtGj8jFcdOi/3dT8VO2U8Tj1ZUqqO3yV59Mr1AY=;
 b=Sg5usJWmxX5AXv4ePqM/AtfGbpLddWWMk32Ei0WhDqaSFbAkKunoUy4z56HJ74rD4M7heOgQ5/pLFfx5oeBCcsijroM6hp8zlcPqFol6slY7W7Q9lIUAK+zeMLdbet4BqAIUDRbmuS99g4kKW9qMCqcLSzFPzbuWjFRXMWXp3aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.4; Fri, 9 Jan 2026 09:02:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:02:00 +0000
Message-ID: <f9ed2178-06a7-4d2d-96d8-ec3c6f64bd12@amd.com>
Date: Fri, 9 Jan 2026 10:01:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: Add timeout for user queue fence
 waiting
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260109023440.4188487-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109023440.4188487-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c5d33b-52a0-45fe-6fc2-08de4f5dbfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWYxY3R3ZWI4QzhleWxPL2hYRFZSS1d5a2I4RmltSE9yRG9QbEE3VFlJRHNx?=
 =?utf-8?B?UjZhaW53eEp0S21HVEVyOHplbkRkekY0SWNIelNMQUpOdmlXTVduYldYL0hl?=
 =?utf-8?B?QlhZbXBieWtBak1SQ0dpZjl1ZDdiZmIxVUtGcVArZW9xNDdSYUxoZGIzdE5z?=
 =?utf-8?B?V20wcW9GM3NVN2d1SjMvRnBoL2k3c3Q4Y0dZQnZHak9Hcy96akdhZWh4SVNL?=
 =?utf-8?B?S0lGM09vZ2x0SmtYcHcvZlhObGxMQjZ5SDRja2d1MWs1ck50a2JaTGZvUlRX?=
 =?utf-8?B?bzJxOS9PMnVLd0VyNVBZRkQxNndhQmRuMnpOdlFmS3p4WWdzUjRKL0cxa3E0?=
 =?utf-8?B?WUJlSEF0b2FaRGhXWVZKSjZBZlZnZWxwbHNlbE1pR1p6TlhmZEhJcnlaU2Nu?=
 =?utf-8?B?NFNUemovRUkyV2syWDRHa25vZ0g5dE9vR3Btekkyd2ZwZlZaNVkwQ3ZTdWYz?=
 =?utf-8?B?Vk5FczltVGtpM3M5U0REby9GRnNzMEF5VGRNYzNGb1o0MlYvZlVKYjBRYWUx?=
 =?utf-8?B?dEZVQ1Z6NGJXKzdkSklhYnVKbVZUOVZhWXdRczIySGhjU2VDMUZqSnpNQUtO?=
 =?utf-8?B?Rkp4eWd6UjNJakdocTFlQzFicGtjTnBEdm42WTI4Z3NBelg2dXhxZGFVbWs5?=
 =?utf-8?B?dDlIWEVkZXpzU0NtRHpyM0xEQnlMZVcrRUs4R28zK3BYcUs3c2RQY1NVR3R5?=
 =?utf-8?B?bDU2dk1wRVh2eE9VSWlKZkt3MGV1OUpNVUdLSEpaV2lwZnpOOFNlOU81em1u?=
 =?utf-8?B?TFRqNE1SOWNzY04xQ2VPVjJJU3NKbVpNK0pSV3hQTXBqL1lWSFd6Z3ZHbngz?=
 =?utf-8?B?Skc3U1pOaUp2UFg0RTI0S0lPeENqVUZUcVV5RVpQajIxRDNUT2tYMzloT1J4?=
 =?utf-8?B?YzFNUE9uYmRYWHV2eWFEeTJTeXQzU0ZMZ0lWdk9WbU55QkNvaVRqOFhCdCsx?=
 =?utf-8?B?ZnRRODlWUXpQUHg1b2ZNVzI1RnEzeFppSGFyWEtBZExma0puWUNmUGNTQXBR?=
 =?utf-8?B?KzgyN1FxV2ZmZHNrQ2xuLzFQUHpvTGtvVXByT09ENW9ISU9QdnlHcDN5WHk0?=
 =?utf-8?B?d3hzemNZdnVURUE1b3Z6eEtGcmdhSmtDT056V3NQS2N4R2g5YnVGaDFNcjEx?=
 =?utf-8?B?bmYrS0R3Wm1GdStDWlEvQzZqY1ZrckhSUmVEQnVhdnAxbHRoQWwwYkpxdkpV?=
 =?utf-8?B?SXB0ZzNuZDRVZW40c00rVHBLYkE5cWNPcDYvQlNlUTdhbDZkbm5CNE50K1I0?=
 =?utf-8?B?N2dwWUJaNm1HNlIwajdSdU1jUVN4dmk2c1NaalJ6Y1Z0NW93ZkZBcTVVMTYw?=
 =?utf-8?B?eUJKbXB1RFZvVXp2T0p5eFhVbGV4TzAyMUVHMnFVQkhyVmhCUDlsQXA5bm0x?=
 =?utf-8?B?REsrZUFPUVVUVW90ZzEyWGJ6UVhwNDVCZDdTR0p4dU81Q2J2VG96MFBQNnk2?=
 =?utf-8?B?SkJLam9LaENqZElMTGxWd2hnankxUEt4NE05OEtWZDBmdE93QkNCTkpZcisz?=
 =?utf-8?B?NXY5Mmo1a3BLS1ZCVHE2bzJiVndpMVVVRHZDWXNNQ0NlNThmQzBJMlU5dk1H?=
 =?utf-8?B?bm1GODkyVGVaNzNpbFBXb3JEV0pDWUlhREtyUHpqd01MQ3RTdzdja0tiL0M1?=
 =?utf-8?B?QkNINmhrT1VqZnM1NEc1WStnSWJlQmpSeXh1bHVuRUYvK2tCOC9QTCtNMTF2?=
 =?utf-8?B?WDRVeURwc3dmUHkxbUJYWTBqSWhpa0lDT1hCaDdpYWcvWm1wSFFlRXdna1BM?=
 =?utf-8?B?VlZITnhlMUlGVFNOUGxZajV3Tk1tUkhxNW5ORXdycUNMTlBwMzRSdmhCc2FS?=
 =?utf-8?B?RlRLRTlDSVRoOVp2VkYrcHcwZU8vK0ZtS25pWWVQc0ZsdGllRjIwZ0dSeFpi?=
 =?utf-8?B?cGxWV2IzQTBBSUJXdGxKOENyTVVHR0JZVlF1VUw4NmFDTWdTNUg4Z1RJclFl?=
 =?utf-8?Q?PUKFZM/c/2CwpzhJ1A1EU/ruQETwbRBx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pYd2hvcHUvTzVqZ0Fmc1dCMFZGczNKWXhMQ3hvYnhWWCtqQkgrc0tTaXoz?=
 =?utf-8?B?by9lVTd5YkJTaFZGak9YMDh4WmRDTjlMeGxJeWpNdW9MZWpzaEkvcGlCQU1O?=
 =?utf-8?B?Uk85S1Q5WkY3MElIN3Fmd0ZRUWZZYnluMzd3QTFIY2o0VWxlakpKZGdxdWNG?=
 =?utf-8?B?ZjgzaUk2WHdyRERxVC9tWGpoNHpKaXJ5NlR6ZjhlUUFmazlTcUVZL00zVHUz?=
 =?utf-8?B?VUdoOEJEK2pObFR5NHhTcEFtZkZSMFpDRGh4S29id0lOSjI4Q2NHRjdXVEcz?=
 =?utf-8?B?aXpremZITGl5cUQ0NU1oOXhOWmovOGdkOU44Y1FVckxMSG00UnQ2ZXB0SjNF?=
 =?utf-8?B?azZKekdZbFRNTFliUXBaUGthRnlUcWkrbnJ3Z2tEZk0rY0cvci9BTk8yVXUz?=
 =?utf-8?B?QlM5QldpUzBpU1R4ejNlZHc2T25NOTB4NTh1SzdYY1dmWDNWUWEwWStkQUll?=
 =?utf-8?B?bjVuQ29rNTV2K1g3dmJ0UmEyTkRlUE5vOEVTMjF4Q2hGSmFhRERwdHNjVVh1?=
 =?utf-8?B?QmFFSWJ6elBseGFZcXRDL20xcjBndGZvQ05scVRycWJGQjVNeFFTYWdQVVFy?=
 =?utf-8?B?amVsTjhVcXRXdUEza2FhMnNnaVdLSTAxbzBJTEg1bEMzV012WGJNZjY5QnRk?=
 =?utf-8?B?L1ppNlZPUHIxQ0V1L2VyampLQkNVZTZGUDgveVUvWXNEOG54N291SkNnNFE1?=
 =?utf-8?B?K3ZVcXRFdHpNVXprUDBUYzlqYUx0bldFb3d4cFYveC9VVFlTU05PMHg3bmxz?=
 =?utf-8?B?bWFpczVDSnIxNGh1WnRpUEVJdGQwcWt2UzlTK1FobHJhdU9qam9teERxQjBF?=
 =?utf-8?B?dGNRZmJTeG9CZExwSFJ1Qm5JeHFyWUhYU2xzeCtIT2dndEFWMkdxWlJTTU5S?=
 =?utf-8?B?MFVpUmNINGRiVVhQNmxKdU5LV0RybWd3U2dQcVQyUUFQK2VVOVVMZGFCb3lM?=
 =?utf-8?B?SWVZWnhKK2NJTCtMR2ZtL2VockszRk1CV1hodkhsSmlSYXBKdUZ4M002Z0Jr?=
 =?utf-8?B?d3c5NGMzYUt2MHpCR3BCYjJtcm5GeExXanNOdldNWm9GaEpHQitvaW9mYitJ?=
 =?utf-8?B?ZWpjZXFON203QXBTVzFqRTRFNXNKalBKR1hRQlgrVDV2cHk5OEd3NUdyVXJh?=
 =?utf-8?B?YWNPK0ZYNnZodEplNnQ3aHlldk1qanlwRFYvQ3lOM0w0eVZtbVY0R3BGQWRy?=
 =?utf-8?B?SlpBSXVaM2taNWxoMGFmNzRxQklYRHhxN0QybHVzSGlJcWthd0UzYXg3bTZn?=
 =?utf-8?B?czdzd3dJRHlZSHNRYmVWemgyUGJueElqSmJtTmVKSUtLTm4xeGpYSkdROFlL?=
 =?utf-8?B?Zm1JTlgxMnE2ZVBSTjJscVphZDFvMFhZYUlJd1UxQ0hWazVCemdYVzNzc3dM?=
 =?utf-8?B?WGpQTFhmeXV5QnVCbjh0MUF6d01NbEhFMTN6R0FYczZzWlBKMEJHakRaSHUz?=
 =?utf-8?B?aWF5NkpFNE1QUnk4Q1hHWjVWSUR0aEZ3UVBka3BQUnlHMDMzTUVuZm16SklW?=
 =?utf-8?B?UFBnbkpsaVRQNU1qV0dmbG1wd1JObXlGWFRLaGVKazNBSW5XN3AxcWZhM3p4?=
 =?utf-8?B?M0JXZFRaTG5mMXM0d1packhDWmJLZ05HeS93ZnhoeVlOcjE1cUJMWThKWGJa?=
 =?utf-8?B?Z3JMampheFNhN3l4blFqVjFwM1E0SFo0bHNkcjVCbXV5S3VKRk9WOVhzZGgv?=
 =?utf-8?B?Q0dRWXBtYnlwOC9hSnlhNDFtOXhMalZTUXRnd0pRS2FZY044SE5GdzE0VDhk?=
 =?utf-8?B?ckpYdmVjLzM0ZEpKL2VUMkdRYklkVzNuUG4wS2lJdDFMc2ZkU0hHNXhLcVVt?=
 =?utf-8?B?UG9Mek9KM1pvNUZKc0tnc2xTU3F6WTBXcXAza09XT0Q0eExBQkdMdjdZcVNS?=
 =?utf-8?B?MkVaQjVTNlZDNjRGVE5zVlJFOHdrc050MTlpZ2NxRGZldDFWVTdqMEJWSHJj?=
 =?utf-8?B?ak9OQmdUS0cycUNYSnBhQlJDZjQzaCtmd3YxTHdBb0J2TGRURFdFdE9BZWl4?=
 =?utf-8?B?ZGR6dXU1UW9Ga2t3OWJSUzg1T0R2VytlUEVyaUVTS3JUdDY0TmthSkZZRVh5?=
 =?utf-8?B?T0UvQXE2L1BrU0NpSW1NQXFQQ2ZYNjZNVjNmaEdKR0hXQnkvUEVMZnJmcTRZ?=
 =?utf-8?B?UmkrSzJNN1FVVm55aDJCQ0xkckxTQ29KWVkwQlpyVWEwaVRVM01tcFd2eHgz?=
 =?utf-8?B?YlFydURNRkJQWlhBS3BNaVdMVGs1NENFVWdyWjdkYzVEQjRXWHp0Y2diQllm?=
 =?utf-8?B?YUN2cjE0YmNZcXlvMFRKMlNyNE1jUWVBSXArek5ZNnZwQTJiNktLd3ZVa1Fu?=
 =?utf-8?Q?xg7vi2/c1IFLyUIeDy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c5d33b-52a0-45fe-6fc2-08de4f5dbfe9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:02:00.5311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYDCh0i7C2cwxF5y5NsihOdRR9aaarZ44BFUHIpwH2hgDrj0t/0sLBZcGsNqCfrn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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

On 1/9/26 03:34, Jesse.Zhang wrote:
> In certain error scenarios (e.g., malformed commands), a fence may never become signaled, causing the kernel to hang indefinitely when waiting with MAX_SCHEDULE_TIMEOUT.
> To prevent such hangs and ensure system responsiveness, replace the indefinite timeout with a reasonable 2-second limit.
> 
> This ensures that even if a fence never signals, the wait will time out and appropriate error handling can take place,
> rather than stalling the driver indefinitely.
> 
> v2: make timeout per queue type (adev->gfx_timeout vs adev->compute_timeout vs adev->sdma_timeout) to be consistent with kernel queues. (Alex)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Once more: Absolutely clear NAK to this here!

The function amdgpu_userq_wait_for_last_fence() *MUST* wait forever for the last fence to signal otherwise we run into massive problems.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 98110f543307..402307581293 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -367,11 +367,29 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>  static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct dma_fence *f = queue->last_fence;
> +	signed long timeout;
>  	int ret = 0;
>  
> +	/* Determine timeout based on queue type */
> +	switch (queue->queue_type) {
> +	case AMDGPU_RING_TYPE_GFX:
> +		timeout = adev->gfx_timeout;
> +		break;
> +	case AMDGPU_RING_TYPE_COMPUTE:
> +		timeout = adev->compute_timeout;
> +		break;
> +	case AMDGPU_RING_TYPE_SDMA:
> +		timeout = adev->sdma_timeout;
> +		break;
> +	default:
> +		timeout = adev->gfx_timeout;
> +		break;
> +	}
> +
>  	if (f && !dma_fence_is_signaled(f)) {
> -		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
> +		ret = dma_fence_wait_timeout(f, true, timeout);
>  		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);

