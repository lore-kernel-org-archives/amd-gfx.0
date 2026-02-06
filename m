Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C99FEE20AA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25CB10E081;
	Fri,  6 Feb 2026 14:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uvn/EDyh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E064610E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtjbtC0UNp06RtW8f2y5jkIWdm3PJlvKNnCg1nggg7VVH7Bgh8t6PgKxVQcPm4k2EaVGZbbGCHyqL+qyoiZhxTeyohOYVvyQL+DwQrYP1/LH+3a0UnwUM4xIidjmCJJ4C5cuk0W2na8GUr31lvJ/t+XznUHyxc/IA8UtksJgYy+Yk5yapyHknCwML/EHQrytsiKxfnb2ylMTbMD2/wUb8jhk80M1M7zucIma8MhPLf7EEevGs4nxr0I/Jd8hixoAb8hP43Wf1ZP7rogfwkSCkqI4bYTqsWLblQYqidh6vAD/rRtzwzgwUe/ikyz1Aj0k4vHTeMiaw/ETIW/YDh3ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeLlDV7QggpyVcNoZYvf8p/TgVUgsZmgytkSSK8RL9Q=;
 b=qndls4bv3ehvmEt433Aaa8G+bwrGnRgY/O2NjgloUgRLMwFH4Zq0augSsMmrEZR36xY+Li4EY8N3LhIZ4PNiu0LtRJK0UDSqnCrHFgPCzJBey6IqyYDqYNxMpSmgynK4YYZLNb+xht9dVJPlI/Xb7ubqX7jwCf+UoA+JzCvcQeSxn6Yoxs7K22vWLxn8fNVfGuv9ziOQ+jjEac501sNXtJAnGs3t3i+98eLA4V1JkAVflwLCWj5d0UlnWCfqMTxqaoKGrTtTNwwnRaPPBW8Vu0rdnzfzj5ko6UGHU95TcCQRLVbx1BA89er48o3/LDsImQEAOfJtrguckDIlTIMZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeLlDV7QggpyVcNoZYvf8p/TgVUgsZmgytkSSK8RL9Q=;
 b=uvn/EDyhH55jfsBeofseaoOod9J1EDLtk3OFxaLc8OYX0u2gAyrJeZc88Ei10t6cpIppXBAuDZtbIwTJBjA5TptJ80cSGnOe+L1KvKFCHyHt3Do8jCAk383OZdZ5UoSNVIkEU6ZS803jCBzHh7qSYPWh57U89k4oieZgLYRcXqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:33:55 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:33:54 +0000
Message-ID: <714c75c0-ca7a-4af9-bf37-7bbff35845a3@amd.com>
Date: Fri, 6 Feb 2026 20:03:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] drm/amdgpu: Fix is_dpm_running
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
 <20260206140049.105294-6-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206140049.105294-6-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::31) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 545bf098-5c70-47c9-d971-08de658cc136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emhlQkhYL1FpK2hGaXhZREtFTythRER0Wk1KQjlOQ0MxbXlONitJT3dQNW0y?=
 =?utf-8?B?YytvMlhzdDQ4Q2ZxVlFic20vVDVyNzVVYTlMdGpJYlpFVSt1OWhra3ZPMGdV?=
 =?utf-8?B?OEtOTDBMZGJnMjBtOW8zclVRdDBEemJzNTltYklmcFpnQ2JNVzJtQ0hWeTRY?=
 =?utf-8?B?ZDZHbC9EOXgvejM4VktyUXFrTTByTzFud1AvdTUvL0IvUXJkdm1oS0lqWTJC?=
 =?utf-8?B?RWRHdlNRUXUvdUJEajFpZWo3TnNZRlVXRXpDbXpTWERFRmRYeEhBdmV6azBl?=
 =?utf-8?B?ZHhtM28zNkFiOHdRSUpzaml5TlFVSG9PcDFMM0F5anZsa1RodE96azlVUXU2?=
 =?utf-8?B?VWs4MFFJRW1LOGQ4N1R6UVRSTFVHTXdVU3p1YkpBWEdQL3RFM2hpVWhKWTRQ?=
 =?utf-8?B?YU03ZUN6S0w4RDVEZDRYd1Uvd1dqL3BDdVhOSm5lWDAzRkdaV2o5SG83NTVV?=
 =?utf-8?B?b2VHWDhXcFpzb0xVQytLZTQ1d25GQjZpSHh3bjVkN2FCWHJnU2cyaXlOd1dG?=
 =?utf-8?B?SEd4OW1FNHdLWXYzTXNnTVNrSjBKUkQ3WG5mRjRHLzVLWUZvc2Y0SngwVjZh?=
 =?utf-8?B?ZnNUNEJCbDRHY2E0OVByalhCaFBUM1J5TWJFTEwwc2lSTy9Ga1ZtRmJRbXJ1?=
 =?utf-8?B?UmlNcHI3cDNnelcrbGJoVHdDS0VVMGVMYXdQUHMwbkRBK2lzV2N6R2dIR2Nh?=
 =?utf-8?B?Q3pBdHhFNlE4c2lEcXlScy9TVHhNS0Q0UXMxOHJGZ0J4cmZPL3pYZVo1ZzUr?=
 =?utf-8?B?Vk1nNEdpd2piMHBNa3h6YmRvVGsvVGd5WEZVMDJuTFlkQnNFc3RmV0RrZ3Rl?=
 =?utf-8?B?UDA5RDlFK1ROZVl1MjU1Mzg5RDQ3ODdHMXZOZXNaTTBqdjIvaU85Ni9qcS9Y?=
 =?utf-8?B?b2FoREk0amVuR0NxTlJ0TEN4d2FmQ0ZsL3ozMmVvTkZNTmtrdGVHcmE0dG4r?=
 =?utf-8?B?emQ2WFJPYU1ycWlSZmwzT01lQmNYUmtLS3UrREs2Q3g2dXQrWERUc0JoUkls?=
 =?utf-8?B?VkJpTUNWdlR5VlhBb1BZVWJrbEVSbTd6cEJXVEp6QnQzcElBNHNqMUVLSjdm?=
 =?utf-8?B?T0R0YjJvS3lPLzBHMkx0OTk0MFM4eWhxNmZjRjRUcjVaNDA1TEw5ZlRDeUQz?=
 =?utf-8?B?UGRoMEM4RUJSL095ZVpzRXp1dHowTkNidlFuV3BsaURKRFBWZ3JoMFBtRHFl?=
 =?utf-8?B?ZjB2OXNBb1hPUDZYOVFQNHZOUC9DQ2VJZERwSnQ3c1dqTnhXSWk2djcvVjVy?=
 =?utf-8?B?Wk9kNVRjUTRNMWoyYmp4VUVQVGdFYUU3Rm41aVZ4WlpUbWlxcmRldFJqKzRR?=
 =?utf-8?B?bGk0N3RtSzNCaFM0TWdyTUhwdGlFajAyZnBlV3hUeG5VMmFveXdBTnUyWTdG?=
 =?utf-8?B?OGhBY1ZMZWdFOXpwWUhGblFqYmdnNDNHVFc5V0x0U2ZxQzYwc2pzZktaQktS?=
 =?utf-8?B?UU8xMloreGtlNlJDdmpIa0NsaDZVN1hsbzlYN3VjN284eHdNT1YwdXF2M2Qv?=
 =?utf-8?B?MmRDT3czaFZ0Ym1SQWh4eFFCaCt0T0NHMzI1VWlZand1SmZSMWt0SCttRkVG?=
 =?utf-8?B?bnZVN2R5U0VSa0hVd2EvUmxwR2JtV1dGQTNYWmphcVljVkJ1eS9RRlZ4RE83?=
 =?utf-8?B?M0NhUnoyeE5MVWNRVVNHRlpMTU9mc241Y216dXlFWkNIVEp0aHRjSWZjZGxB?=
 =?utf-8?B?aEh0elM5T1ZUMXc4OU12dm5RR20rWHR6Tjl3VmZmS1hUamdYenF5bHFJaGJz?=
 =?utf-8?B?am1kNGMrUjB3LzFtWUNBazhDZ3lUZ2JwcDJSc0YvRG8wTXpBM2J5OTZ1VXg3?=
 =?utf-8?B?bGJPdDdadU55R0F1NzFIbnZOTHAwQTJxbGg2UkQ0d21ncGpkMmdOMGxraDB1?=
 =?utf-8?B?cHZqVFZpMjNSMXUyS2crS0s1NW5Ua3lUNXRrRGFEbVRQM0xlK0ZscVVBTjJq?=
 =?utf-8?B?dmlyUkpnU25KQjduQjlieXNZRGVmbnRPRmhtdzNUeEVvRXZYTEZLUUYzSHpq?=
 =?utf-8?B?U2hGTTZzZ2JITSszUDJzVFN1Q3FPemNxa2QvbnE2Vm1TQ0VCczNtR0xXNk5r?=
 =?utf-8?B?QXloa2tBRHRabExsblJ3QkQ3ZlQ3RnA1aEtIRkRUTTVnKzJ2YlRUbW9ZYmdO?=
 =?utf-8?Q?ZK58=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNxdFdMOGlJWWFGRnY2Tk8xdXJ3UlVqU0pZWCtKWjdnWmd0ZUZkeHVzeTZr?=
 =?utf-8?B?YWZHN0hkS2Zqd3MybVI1b21aZmx1YUtzNDVPZk80aFpXeTZyWmdZaWNsbWdW?=
 =?utf-8?B?M2Z1MW92RGdHcFFkOFlnQWtvUVdlVnF5RHBVcTF5NXN5QThaQXhydXl4dHgx?=
 =?utf-8?B?OGJmaDZQOVZHcG1ocHduNUNEM2l3dFUrRjlqU2I3NXBodXQybzd5R2NETVBo?=
 =?utf-8?B?UUt2b3FvWUY5QU1DUE1CZWhQWm5NWGt4ZUg3KzNzQkhRVWxLYnBLdzZUd2Yy?=
 =?utf-8?B?U3JVQVh1b1E1ME82SUhvVXNST2dJcFZKMHJCTTlKWm82QzRkTDZLRlVwWU9p?=
 =?utf-8?B?bEZiS3oxZytIQnBqVDEyWVRVZ1RNYzBPbkFFekxBTCtsV1o3UGgyeUgyTm1X?=
 =?utf-8?B?WDgwL2drNzliUU1rSENkVkM2em44RkJpcVpVaVg2bG8wUXh4SEJGbTh2SG5h?=
 =?utf-8?B?SWhhQXp0a2pPalo0RmhrM0M4SzliTnlMWWdWS2R6Q2RmcmE3aE5udG5CMWlp?=
 =?utf-8?B?ZElYOWVCK2NqVmhMbmhjVUg3bDRlY2pxRGdrdUZHSlpwZkJJTFNEQkd5NElU?=
 =?utf-8?B?Z3g4NGNZd3VoVituWlVBN0lPSkhxT1NTemVtQkxxNnFOaXk2bkY4dm9nK2tw?=
 =?utf-8?B?eGhhdURPNlJNS1ZBdWJWZlB0bEpCL0RiTmNWOWRaV3lVaUx3M2pJMXUzSU5o?=
 =?utf-8?B?KzFhcHNXM2tXMkllMjZwRUdFTWlWa3hnaVJPU2xoV3ViTnJjeHJtMFJ0aTk3?=
 =?utf-8?B?ZksvZmJUeURCdEo5c05SdEp5ZnpIT2xJVkJDZDdhVHJTYjJNU1Y4TU9yVUs3?=
 =?utf-8?B?cUlPUnNhTGNhSkNaUmVKamZDQjJhVFBHZm1CcHdxZXExYnd3c3dTTzBxTTVi?=
 =?utf-8?B?SnJTOXpQUkdNSkw5aDJHTS9PclBCcDhOU3BjcUI0V3AxQ20zaFZ2RGxKTDND?=
 =?utf-8?B?REtwVUVMQ3VoYUpibGVGOEJsd1F6eGdTcElRL1BWQ2lqb3d5UWNYKzdDNm9K?=
 =?utf-8?B?LzVqdDN5c3k4UU9QcHBtWENVNDJXUUpGTTVHQzZCejJtaVZMaS9NdFcvSmV6?=
 =?utf-8?B?VFBIYkNBUUR3b0hCbVp3QkZyZ2R0aitOQURZTVVTNHJwZm1neW9vZ0paVG5V?=
 =?utf-8?B?NmFjL2NvVjFFblFuWnlaVzFDZkgzVm8yMVVBMlVZUjZ6ZTFsSFBMNWdIbllF?=
 =?utf-8?B?THJpcVN1aFEvUzRKdEJxTnk0Q1NnaHk1MzdpY0lQNEJOS0plUEhIQTVMVkI2?=
 =?utf-8?B?OVU5RVJVc1MwZ3RzcmlxWUJTZE52eXdQV0I0VWc5V01ZdDJvSDBJM2NrUFI0?=
 =?utf-8?B?Q09oU0E2RmxFRUFXbEVqMDE2ZVgyMUNyY3ZmS1JhbHFDVGxyRnR4Um9kSVg1?=
 =?utf-8?B?SC9wSi9QVnlNME93Z1B1WkJiU0FSMktmN2Zpbm9hOGdvSTVGMzhQdDVGWkVB?=
 =?utf-8?B?Q3RidGExaFZxUlBDREVMQXNiMXZIZlhXWm9Qd1JhUGRwYUxXanlDdWY0ZXdu?=
 =?utf-8?B?dUE0MkpGSkVhZ1pzRlB0VWhVN2VVL0pNeFdaaStJSm9yUFdxQUo0cjJ0SHhH?=
 =?utf-8?B?V09YTEZGRXJ1UHRsbDNNdHRNaFcvLzAzODdBeXBFa3Z4bWpsRmVaR0hUMm1n?=
 =?utf-8?B?aEdmbWo1c2tEenE2M3RUK040UDMwVFVPQktsRzkyZE1STE93M3VnWlByNXF2?=
 =?utf-8?B?ZkRFaWpLQzduOG1TVkpOWWprVHMrZE4zVUQrRUlEcWZ4UnFhdE5HMTlIZloz?=
 =?utf-8?B?aTlhNDk1NUVpSHFDejdEelZtNVBlSnM3YThtZTNzKytEeE5vcjQzWldGRk40?=
 =?utf-8?B?OXZkS3J4WkEwZVh0QzhrVXlpQjZxbUxNN21TdkFoeUE5SVZSelVPU20xcm05?=
 =?utf-8?B?K0o2REw4YkNkVzgxaitlL3g2VE0wNHZMc3hqOERLZ09kSnAwY013UHV6UndL?=
 =?utf-8?B?UkpBZHd6RUZwZzRoSCtBN01uRDc5dWFtRElxTzZGME5DSlBHMVhuZmJ3OG9n?=
 =?utf-8?B?K1FGUnZuUjdIUkdmUkthMUlQNFZsYnRDNFAxK3ZYUzVQNm5KTUxmNkZ6eXFh?=
 =?utf-8?B?WnpSSDlHVml6VE9MTmYrRDRVd0dmMWl5by9YdzNiL3ZEc1NhN3hDM0lrcmxP?=
 =?utf-8?B?TnpkVGVKYW9mN1RuZnhkL2lpRmVaemNicjhES1NCMzZDTDJ1SjJpS2xnTUo2?=
 =?utf-8?B?L09aYzNaaFJ2VGQ1WXVVb3BFN1B0cjNwdmpTVHBlT0xQdGx2ZXluV3hBT01X?=
 =?utf-8?B?UXlBd2pSUGpWQXpKbzc5WkUyOEFzZmpPSzladVZSNjh1THBMKytvWXVJVEw0?=
 =?utf-8?B?dmJLT25vOFV3NmpxdnQrMjA0dHhDWVVudTlpeml6T0R5VkExM3hZUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545bf098-5c70-47c9-d971-08de658cc136
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:33:54.8157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh/th/T2luB5c+lWwdA9C7o068/Lf38ouvI6C4hrlkgJhtJyADLsMQXSRcb0y72t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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



On 06-Feb-26 7:30 PM, Pratik Vishwakarma wrote:
> Use multi args for get_enabled_mask to fix is_dpm_running
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 29 +++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index e53201f42e40..891cdd8bc5cf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -517,12 +517,37 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
> +					struct smu_feature_bits *feature_mask)
> +{
> +	uint32_t features[2];
> +	int ret;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!feature_mask)
> +		return -EINVAL;
> +
> +	struct smu_msg_args args = {
> +		.msg = SMU_MSG_GetEnabledSmuFeatures,
> +		.num_args = 0,
> +		.num_out_args = 2,
> +	};
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (!ret)
> +		smu_feature_bits_from_arr32(feature_mask, features,
> +					    SMU_FEATURE_NUM_DEFAULT);

This calls copies data from the array provided to feature_bits. Now in 
this case features array is untouched. Should be the out args array - 
args.out_args

Thanks,
Lijo

> +
> +	return ret;
> +}
> +
>   static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
>   {
>   	int ret = 0;
>   	struct smu_feature_bits feature_enabled;
>   
> -	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
> +	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
>   
>   	if (ret)
>   		return false;
> @@ -1394,7 +1419,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
>   	.is_dpm_running = smu_v15_0_0_is_dpm_running,
>   	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
>   	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
> -	.get_enabled_mask = smu_cmn_get_enabled_mask,
> +	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_driver_table_location = smu_v15_0_set_driver_table_location,
>   	.gfx_off_control = smu_v15_0_gfx_off_control,

