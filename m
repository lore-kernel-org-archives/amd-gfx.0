Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C653CA0EDC
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 03:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB09B10E33C;
	Mon, 18 Aug 2025 03:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UpDVsJi5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB3310E33C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 03:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw4EK0T+jQCqBSMo2+dMozPUqdIKqTUWGCMDqRw6c0qIb/fljdySft8Sx0UIBlfeZvJD7vAoMKDfcbf3Shb+IzWySXZ+ur0eIV7bBbC1f0Iuw5ZU9JkGMAC/fEg2KvqpnNFP88ciiUEGr0hhlsT+/c34mgeiDuwNdj1fYhofnYS176S6ZYVXP9965lc9nnwn3jjJvUVKUcgT7LpmofQGTubmQEapzfMFuIN22Lx5JhPA90OvNDUCA9EZanMLViW7keRfhkbiJGnjM2F1LqoHMlc7Aespxda0n4126UYSG7PYZU+RDRFEpacZs+lbjZWKwd8FOtoj1c6HlVC6GsqqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/IvMEOTXPY/ex724/nm+gRy4ePO2U0jUT38f+Zq70s=;
 b=c+l+qygU0yzwXotWooRHDLi+TynpL+5wK2HLiUbSncQhykKAp5w7l9X/BSE8sF8+cmk2MyrhzUmw+djdkbn8sSGMkxqG0X7Kxc1++g+r2s7cfTaQBxCn2MIRHSieFCt02pLGEyQOi5ZFFhf/a0OBIwCT9UyZt/a418sRLxvejo36SJMFpWP8KG4R3efGsHU8/3I/FgsMfjMA741SaW0ZzNWSrwBidZrdPn+KEJ+Ae9IEFM13/SCRLmWjpyTtO8FPW0GgpyXiBEffa7AFSRaI+KRHWKx+GoM6v2fdBSwqAAejO9KeICPcWVNqLpNlhdubP2McjXEzHiU9TtdljD46zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/IvMEOTXPY/ex724/nm+gRy4ePO2U0jUT38f+Zq70s=;
 b=UpDVsJi5IKJk+eX5DSGEqYhwkMG68WIJABysDr7jtxIwHqCpnrU5WQqsZD6CHZe6M1BynOy5sNTdNpKQEsLOfWY5EnXHndN8yB/NWBH9D5eotlCNqSBSD95Cj5VqrR3P1mMTwwvYoZ29LB030hZVkJ1VBQ3gh4/YqhVrgWas0sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 03:04:37 +0000
Received: from IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692]) by IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692%4]) with mapi id 15.20.9031.014; Mon, 18 Aug 2025
 03:04:37 +0000
Message-ID: <5c44a7c2-1f2e-4020-bfd5-a86955e7191f@amd.com>
Date: Sun, 17 Aug 2025 21:04:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] DC: Fix page flip timeouts on DCE 6
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250802160602.12698-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250802160602.12698-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To IA1PR12MB8495.namprd12.prod.outlook.com
 (2603:10b6:208:44d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8495:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3211b4-0b31-4885-947e-08ddde03f734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3J0a05GYWl1L1VDV0g3WlE5MnNHVGVVUWlLVndSenFJcmNvaXBMZlZuNVNn?=
 =?utf-8?B?UEQ3VWR2dVlSakZuREFNM0w0cVRqaGZBMWd5U2pvcy81VG96cDB1WTlQbmsz?=
 =?utf-8?B?Mk5Kd0VGTlpHekhoVmZoRkZGQVIvTjhxWUdQTyt1TTlkMVQvV29iSThLcXgx?=
 =?utf-8?B?UElqOVFpamZoY2dNOW04L1dNczJTc3JqanBjaGtTQVpBRGJsRTRrZjZFVXRJ?=
 =?utf-8?B?Uy9ncEErODBwY0JPM1BxVXVsRWRoLzBXN0U2VFR0bG9odk9sVDhNa1dkYXNQ?=
 =?utf-8?B?b0dKYjZpdkNXSnptSGE4OHBJdkJHVHVVUGwvOUc5WmJkRTQzakxYQ3FNUkZF?=
 =?utf-8?B?VWlZYVBFSFdsK3AvZXBGK2NUS2xjWUdQSlFDNE4xVjJ1ZW1ySGxLcW80NWJN?=
 =?utf-8?B?K015bGNwdUZHdlF1bTQrbUFYOEpPQlpxMXYyaHNFVTF4ZWVIaE00NjdvU1lL?=
 =?utf-8?B?LzNPbkVNY1VBdW0xOEdjVTVpOUhEOUw3cG9iUE9kZjh3T0Z3R1lURjdNUnUv?=
 =?utf-8?B?VGdmbVVDL2ZRTjYyOHpleUttSi9YbUtpU3B6MW5LMG9WMzdZbEtwZXpxdHZB?=
 =?utf-8?B?M1FDa1BuMGppaXhydkJKcGxuYThMc3FWbkEzU3VMNGpYWmxEZFJrWmlFaHAz?=
 =?utf-8?B?b3JxRHVhejlsRVdLMlNza215OGlqY2w2a3NSQmpEVGtsaWhjK2JURVZSaE1u?=
 =?utf-8?B?YVFsMm1CRWdqTUZqOUN1SXhCRHg1THNwdDNDeTNiODhnZnh4WUhZUisvVzJy?=
 =?utf-8?B?YUQ5KzREM0JIMTRiZk10WWdDNjJGY1I3VmtHamhqTHNFZEVxem9mZUZ4dE9k?=
 =?utf-8?B?clFKQlVBMGhDT3YzamMySUFVZ0czTkttT0lLUjBRSmx4bTJYODA4d1R6dEZ6?=
 =?utf-8?B?Q0puWGNyOC94M0l1aDIxUnFDN29VdmR3RVdZcmM5RXhzcFBmUWVPTlR5WFZT?=
 =?utf-8?B?MVhJWHEzcUlHcFJjZVdQNStMN2hkdUx3UFBOSkRvbmhtNFlPSUpHK2F6K1Jw?=
 =?utf-8?B?RGxWcVhmbGw3QzBiRGJUMm9KOWRqbG8zS1RxdHVjejYxTDh0Y2ZzOHU0b1Js?=
 =?utf-8?B?ZXM4Z1pqVC9HTkQ0dk5lamZ3M24wZ1JEN2JzZFptSWl5OVpVVjNQeHZ2elQy?=
 =?utf-8?B?a2wvRmo1YStEbXJOVlAzUkh0M1VCNVEyVEY2dC9LbGNWUTBuY1cybHJOb2xx?=
 =?utf-8?B?QWFTMVFNelRyNU1iUVhnNFhMTFNhWlAzZ1R0KzQ0SUk3WG5sOUxHV3JQWVJV?=
 =?utf-8?B?YmFUQUdYbFh6dDUzcGpocEFkZU9vS0svM3E0cUdYMEZaeTBJUUhaNzNjdnFv?=
 =?utf-8?B?QkRlTlVlUUU3dHFLTWR2aTA4WmE0eHJkRm9PN2pDU0JrZnpQRkxQOXI2S1Ex?=
 =?utf-8?B?TS92bmR1UkcrbTh0NkZ5SWRwZ0JtYWhUcWJtVS9YTzQ3cVRZNkxkdVpSbkxp?=
 =?utf-8?B?MFhiTG1DSy83KzI4VVhSeGI1TXdURjlqVlV5NWsvVUZRRFRnbWtGZ0UyaDlh?=
 =?utf-8?B?aTFVVENlSXJVVHVqdVFla203bDJzTTBiRWFJOENld1ZBa0x2T3c0ZDFXTUh6?=
 =?utf-8?B?NWJaTTR3UVl1a1BPazQ3WEF1ZFhoN0RxeXZ1YlEyVXppUDJHdzlWOVAyTlZp?=
 =?utf-8?B?UU1iWXlNcUliSW5uOW5ibzNVTTErOFFKenBSZHJEZHpHVTMvNzVNMGhFQUJO?=
 =?utf-8?B?TnRwS1pYOXNGYXJ3ck9QcEpmWHlva05VZ0hPaS93KzRwaitpWHFobDRUeHl2?=
 =?utf-8?B?TE0zQ2h2Rm4vOFRGMGtyTXVpdWFZUm45OHh3NDBvZ0dEeW85V1d5d2pHVlpH?=
 =?utf-8?B?VVF5R1NOdkFDemVZUnJrUE1IdFJ6RUZBSHl2VlE4S2hHTk5WNGlzR3FEbzda?=
 =?utf-8?B?WWI3QmxxVW52YUk1NVBRTnlEeDZOTzdnWFdtLzhJNGduTkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8495.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0dwUUVnOENaR05XSGl1aXpjNTJENWpqZVVoY0M3K1lhYVRHY0Y3bjd2SUp3?=
 =?utf-8?B?UVBZNVNpekVpR0s3ZCtzTk9xd0VSb2JZeFJJMzdkSXBGZWhQZVQ4L1hnWFZS?=
 =?utf-8?B?anQ4TjFHNG5UNWZUZUlVTUFFa2lGNEVONjBpL1dNUmZROVpIbWRFOWE4VWlV?=
 =?utf-8?B?TUtMNEZrb3A5WjFHN1Q5UDAzby9veXFVY2k0WWdwaGhwT3JUV1BuMTZTRWlo?=
 =?utf-8?B?TjVieWpydTY3cGI2dmI2YVAwdXhBRmdlWU0zcjRWVXNaRTM2cGN6cEd2VzBo?=
 =?utf-8?B?dE1YR3JUdERSSEd5Um9mUU5WTGkzNnpLZ2pmNXJCSWZUSkZPTVB4N3dIUjhv?=
 =?utf-8?B?eUZPMnhvUDlLQ0U1QkVmQzQzMUpVWkVjNGM1V28xNU8weURsZHowR3lZdVFP?=
 =?utf-8?B?OFJoT0VwQWszd1hFTDl0UGRYQUJ0dTdNeVpQWlFiNEhzdTAxOGdQWkw1akNC?=
 =?utf-8?B?N1ZxcFh4ekJOWkNBQ2RmREwxOTJDWUdIVnptbXBXZ3I0UFF1c0c1em56RmVU?=
 =?utf-8?B?NGxIMTNhSTBRZmxHZ0ZxMGlHcFc3MkxBNVBoVWlBOUdvV1U3SDZCQ3VqMWhw?=
 =?utf-8?B?N0Fid1RlMmRDUVRLTDZOYU9yTk9LcUJGMVZFQTFod3dQRUJOMVd4VmFDNE9F?=
 =?utf-8?B?VStXZFVDb01kUGhPOXA2UjBtd0RHZU15K2liTGkxU0lUR1EzN2NhZU15clFh?=
 =?utf-8?B?clFYb3VGclRTQitDOG9yYzY4cVdIRDluQ25pTUoxbXFDN0JWNmI3dTNlRE5R?=
 =?utf-8?B?MlVCOUhRQmRkd1ZIeFJMTFZUUFlObkFpZ3JLT2t1UFVoVUdLQXZYZXpzbFlv?=
 =?utf-8?B?MHJHSzRMcXV0bHUvbWgxYkQ1d0xjbTJhOUpOV2FBUS95Sk5Ld3dFSm8yQnR2?=
 =?utf-8?B?eUVBb2tkYzh5cE95UG9yaXdEYVdUcWdQY2pvdXNFUmlLMXJPMlhCSUM3Rmhx?=
 =?utf-8?B?QVRuWVViN3BMandZaVA3RE9DbTBobHJBalN4QXNEQmRZR016SzhNZ25YSjkz?=
 =?utf-8?B?bFBjbzhnZmk3N0pkaTRRSlg5aGtvUkwzT0o1TSttREcxOU53d09jbnhrd2Zt?=
 =?utf-8?B?bzZsdVFSdDlvQ1NlNHA1dEhkejIrcm4wR2swaDZFWE1XWnlOQllTUjc0VStF?=
 =?utf-8?B?NFlPWnBqU29CK0o3YXFkZjFTUDl5TzFxdkx1Y3c4UDVhY3ZGRFNzRHhPYXBu?=
 =?utf-8?B?dzNOR21PSWNxYlg4T3RiUEcybnR2SVBsZ0ZlTWVobjdzWERHQk16dlRydjRC?=
 =?utf-8?B?V3JxOWllTWVHamQ4RGVRbmRZckZnWTMrYzFQd1JVSmRqZ25GdW9oeU8vVExu?=
 =?utf-8?B?bnE4NjZuTjA3cHhDVFpnTDN1STByNFB4QjVPTzM2TGJhMEM2d2R6MzhNMUp5?=
 =?utf-8?B?N1I1d1l5anFPNWtDR3dvU2dxdXBsK1VVczRKU29ZMHR2blhLT3RleWJDSytD?=
 =?utf-8?B?K0R6OTFEekZsOWx1dXFxd0ZXZTRxOTc4YkNpaXNDWlBDTmlNNE9vQm5MeHlC?=
 =?utf-8?B?N2c3d0U3VEpYTTZsN0gySEZYZG8xQWl2R1IweHl4bmdKSWhEQmIwcGlCRkFy?=
 =?utf-8?B?U09GRlorbGp6eEVwSDVEci9BY0xrNWpadTRxTWl4TjA5eVc2Y1FSd3dZR2dq?=
 =?utf-8?B?ajdXSkhYbWVFeEo2UmY5cXQ2OCt1L0NxSFdveGhoZzVpMUFxNXBpamJOOWJX?=
 =?utf-8?B?RTMzMFBGa2krQTU1Nlppd1Q3TmE3aS9MbFdDOVNDeXlxYm1LaEpyZkRVRkdS?=
 =?utf-8?B?RXgvVVpKV0ZGTm5kUXg2emQ3SWcvUW5mYnhsd3d1R1pzaTA0c1ZFdGp6V0dL?=
 =?utf-8?B?RFMwLzJtV1JidkxEVU9rNHRlUzJaeSsxdDZpVXIvbnhLaVZqaFJNMlFoZmIy?=
 =?utf-8?B?Z1ZKN0NQQVEvNVNLNzVFZ3JlUEhnaXBCVGF5SHNyQ2ErVlZPRXVLNThLL2Jk?=
 =?utf-8?B?akNYM1F2OUprTFN0SmswNjUzSFJ5OHVJL01GSUNtZHNwNVNBQjRkZ2JTdDVB?=
 =?utf-8?B?UTVZWktzV2s4c1BUZVY2WnNtSDhuK1pweklyVnBEMlZhWGpqbitFMHROTE53?=
 =?utf-8?B?UnQ1MXB1QWUrRDFNVUMybXZNejYxbzBySVprZzVHYVMxY3ZHOXR6RnFDS1lZ?=
 =?utf-8?Q?Y79XUnVIFK7GSajZWU2Wg2mwv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3211b4-0b31-4885-947e-08ddde03f734
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 03:04:37.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjsYzs/blNOtQNg52sR1OjivxLzIEe5TOGtqyI0LnnsLFH3sW3iJoIVjywtpoNr8DuxIYTnCWB6Gk2ho0pchkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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

The series is Reviewed-by: Alex Hung <alex.hung@amd.com>

The patch series is also tested in promotion test and CI without regression.

On 8/2/25 10:05, Timur Kristóf wrote:
> Currently when using DC on DCE 6, it produces a page flip timeout
> after a suspend/resume.
> 
> After some investigation, it turns out that the issue is because
> DC uses different interrupts between DCE 6 and newer HW versions,
> and it assumes that the VUPDATE interrupt is always present, when
> in fact it's not. It also assumes that the HW is capable of VRR
> when a VRR capable monitor is plugged in, when in fact this is
> not the case.
> 
> This series marks VRR as unsupported on DCE 6 even when a VRR
> capable monitor is plugged in. Furthermore, it fixes the code
> trying to access the unregistered VUPDATE interrupt.
> 
> As a side note, I also attempted to actually use the same
> interrupts as newer DCE versions, but this didn't work.
> Apparently DCE 6 was not advertised with VRR support anyway.
> 
> Finally, there is also a patch to disable fast boot mode
> on DCE 6. The rationale is that this already didn't work
> on DCE 8, and even if it did I have no means to test it.
> 
> Timur Kristóf (3):
>    drm/amd/display: Disable fastboot on DCE 6 too.
>    drm/amd/display: Disable VRR on DCE 6
>    drm/amd/display: Don't use non-registered VUPDATE on DCE 6
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
>   drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
>   drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
>   5 files changed, 35 insertions(+), 20 deletions(-)
> 

