Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E60B606A33A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hccKFxBn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BD110E806;
	Fri, 13 Nov 2026 15:05:19 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C9F10E806
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIqDtP7rn8lw5Uw8/n1thq2bYTSujMrdFBmnakAKinAiSrseZGhTxvn76fDXlb1lTsLKP7kvzcgbnMAtK8GTnPjv6D6Ku+4vsbTsxoKxx8zY/WZiziaSfz82rL+sSLR9qEx5xZxdJqH2slCBTZuIjpkld0nOtOF0nrMy4hryyfHjJB8mIX9SUw719aa2TeDRiO+AVvb4YyzeaXp4pfbVlesmLHQSCOOgvg7g0O5yvLNiLIaoJ2DtH8QWU7qZ0YW03Qcvd15WUjfCgXptIpoRjgCMgpNDYNL+huRfBDnQ4n3w7S1mK0Pdyc8c+v4l4V8TLP/sZchzM3gmtwV6j1YOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdjn0v+iL9/5M55G0sAgctylWycykAqfyPp9NxFD6HA=;
 b=FpPmx9p6LPEDK7zlczNsQmJG0WwnPw07jf5PdSXXvAeXLivmTHQevh0YZXBCvCbEZXfq6429RzHbTxuAnPOTBIwHkWtBje3R0dut3qkHGsjVjyYkaVUoekLadZ23v/l8aMK5w5DKSFabamvthtEYAD+QB4a/d6/xZDx2R7nahLu8qtbJbbK1gowfn5rrN3A30QEpu6h4K002FPngtP69WMlGl1Yj8IbNv3YyvqDCJXeofZlw4/f03s4HmS6gYy4ARf/fIFNmSiPW9zeFYvlLIcd5U0EgpkNSvTM78ogBtLf6AuRRE253OfgJnWUbMojPexsBMvidq1pJX2s0iwhZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdjn0v+iL9/5M55G0sAgctylWycykAqfyPp9NxFD6HA=;
 b=hccKFxBniRd3GsM57H6lFDLxSeclSvHoTCCjpgJNJ+2TMIMyu9Q3paioYTLvxmh+TJ2JAd6RDl1o19K4USXScVwcNot/3Gho1RA/q8OQdqLeRnTJqTDZMPOd8p1kBYDykU7YQYBrxlc+UcBrSdvL1Hc5+rpHXb//Yz/NEmFtowI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 15:05:10 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%3]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 15:05:10 +0000
Message-ID: <ab2113a4-3db7-457a-98b4-a989e5ddbf46@amd.com>
Date: Fri, 13 Nov 2026 09:05:09 -0600
User-Agent: Mozilla Thunderbird
From: Jay Cornwall <jay.cornwall@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix fault shader cleaner on MI3
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: gang.ba@amd.com
References: <20261112134340.4122401-1-kent.russell@amd.com>
 <20261112134340.4122401-2-kent.russell@amd.com>
Content-Language: en-US
In-Reply-To: <20261112134340.4122401-2-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:930:a1::22) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aa94c0-bf10-47b0-2823-08df4197830e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|261009223027099003|4143699003|11063799006|56012099006|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: jLPQ0OC7+1p4WOJAdDAyv0TjQPGyOwhGou62+Jam5+ncMpbbNWRdhvyemE54CWyEanSBYGT72N1hYYK6Cgscn0A2O8gsLUY6z4o/IpnMg/8TYr2ZsqmJTkDrhPoVd547JFySuzhmiUsjbRXk+pXx/OKJnQsH7qzzr0eO3LRZeRX5x+5kGDWyMLzohEemTUa2O8loUNPM5xVc9ktkZ5RRlpnWRC2kxL/4C0FBt/oBCX7dI5A+YtbabCWQfRRGRciuriWJ+nnpotekNlpyUQEbc5XmonYy9WbDTLcr3iGIMT3Mct16W2otojj7TiJjd5oo0K6fyPuRiPuq8TIHbybF2kSF64k255rA55iDOeQnVpb3MUFhjQsXpSgM+PAbGylpWduVr3GZeggHSv1NUqfDWPaUz904Lv1QMdM6A+u2fYNQGwQDxHn7iIC6dnvWzqw68+jypftTAcEENwIMHXpKz6/748Z0ZcR1N+x7y1v3Sk3YU0IR68DOHcSTEbUtGQO3+cLvG9REsXddbLFkFj5YtSV0HN1P55w3l9WLbcVN0nem50o1ww78YAMau7iYZo6JNiPyqrgcw8FOW+4vX/JW7V6anlYNJJrcSdt/NLnflG9Ngvc7LZsC8+JeLrPa9rZ0t/TCmEtvL8YDGbxtzrWZ5wFLmKxTUI0C5UfMVTKlpG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xYMzExLzFFcFhVaUhMWk5TRUNocjdOL3JzSWt0UGFJWHVvU2NEb0tNRnlx?=
 =?utf-8?B?dkMzMk9oNlhHVUU0M0FXRWRDVTc1WkN5b3BNN3dJRUdxSzRLUFhOUEpUdUVB?=
 =?utf-8?B?SGpXRUszTlJ0ZzU5WTVjMzc2SklZQ0tJNWo4NEt6alMvUVRzemYzeFplaFk4?=
 =?utf-8?B?MXJma3YwRGxVRU93ZmtTQVY4UVp1S3BHSlFFTnRrdWJFSjl3OGliZ3VnaGJG?=
 =?utf-8?B?Nnp3aC96YzRNZWVQaGxXQnpUdVo5WkxDZVlYeDQ3MURsanZyNWNmODh3Mndp?=
 =?utf-8?B?dWxGaTBtK3Flb1c3cUV6QnRqd2NWWVdKdEUzSUprcXB0QzY4RGNSamFwbGN1?=
 =?utf-8?B?bnI3NmNUM3lVU1VlTGRzbVkvUmVZZ0h0QVM4K092eDJ6MTAzSWk2RGc3RW1v?=
 =?utf-8?B?MlkwK1djeHFVaEE4MkUwRHpWWnJIQ3AySUtPbnQybEYvWVBHT0R6UmcvMFFQ?=
 =?utf-8?B?dEowTnh6SCt3a3JqNjVHczNTa2ViT1lweG5wNm03ck1qY0srdERpT1d6V2ZM?=
 =?utf-8?B?WTArNGh1cWk2cXFQTFRRODZ0SERrL1dOc0hUbmdtYUs3YkpMY1h2OVhTR3Ru?=
 =?utf-8?B?aVFwb0ZnYmxkM2N0VDRIekJQbDg4ODFlOHhYM2pLWkFBdDROMW4wRytHc0Fp?=
 =?utf-8?B?YU50Mms1Z29LREY1WDBPaWlBTThCckY0a2orb1hBcGRvVVBuKzIrSDRUaGR5?=
 =?utf-8?B?dnhIVmJSbG80Qkx6MXl1bUsvZHp6RnFJZmVmZkFxTkRERmJDWndCNC9tblhN?=
 =?utf-8?B?RTNLUnR3OWNlOWx1dEh0a0t1bm1sTW5Eb29BMkFNckMxYktvdUlUMmc5c1Jq?=
 =?utf-8?B?RWlYQWpFMEtaQXVXaThnZFRuS0QrNENOWGhucTRlTDJKdXNLM2tUMW5aTjRm?=
 =?utf-8?B?d204dHI3NmRJV3JQbHBGMGFqb2txTEorQ0cydlZTQllTS3BjUy9WNkVOU21s?=
 =?utf-8?B?bjBuMVRlR3pyNUQ1Sm56YWsxNDNCM2owNlJQMm84T3NJZmkrN2pPaEgxaDBY?=
 =?utf-8?B?d0NEMm00SnF2NHo1UysyclQwVFU3ZXluelJKVmhYT2x2Smo2RHNyblpETzA0?=
 =?utf-8?B?RjlhWVdKYUVnaVFiajl6UlEvNWdqTkZabjFxN0U5Mzd5Z2hmeVF3L3dVYzln?=
 =?utf-8?B?ZWljck8yTXl5TmJQTURCRUVkTjNveEdwdGdYNUt5dFMrK3lrUlRpOS9PWFYw?=
 =?utf-8?B?cDZzZDRXWHV6UkcrazhuTUw0L1g3WlJnTDZHY09WZDJRUmprbUJhTU1XQW5q?=
 =?utf-8?B?SGlQbFAyYkVUUVhlU2ovd00wKzFaY2FSZ0ZyQnhCNDNXeGhQTUxPVmVrbzdM?=
 =?utf-8?B?NUhady9aZ0RKeGYvb0ZHNWVCVXRzRmFmcGZyNzQzTTVqM1BxL1h0WEwzakpN?=
 =?utf-8?B?RFhqL0tacWRBL1NaMlMxZ1BmZkhyMjV0Q1IwcFJNSU1Dc2oyTzRONDdJVnpB?=
 =?utf-8?B?NWxZa2NOK0Nka1l3d0RCaTdsMFAwRjlEY251Ulk0aWhGbDlEaDc4SC8xM2VV?=
 =?utf-8?B?SzlIaysxenlzaTJGaVo5cWt6UWF3MkJkNGZiSFBBM3BpRER6MCtWMzRzb2xm?=
 =?utf-8?B?TE1yc2tqRlBlb3hwaGYvaFZUOG9BcnJaK1FmbDh3ODBnSWpZcFhXZnhqc0RK?=
 =?utf-8?B?MzNoRUxnaXF5ejlIdGE4ODJJcHkrWlBVK01kWXp2MTc4bWVsQ2xGenBRNStG?=
 =?utf-8?B?dmttMnIzQkYvTzRxMVJWU2haVjgzVEJkMzFNTnFEOU1DbEJMUFJLM1EyamZn?=
 =?utf-8?B?RU5rZS9UR3E3SDVGVVlYQWg0cUFtZ2pzUjh0M0JUUHhrRzhtVTNRYU9MZHpX?=
 =?utf-8?B?b2YzdFJIQWdVcE10eitCWXJ0ZVpTOHErY29OTDNXeCtwcDZGd1FBVlMzTkps?=
 =?utf-8?B?dTJMSlptZXN6ZWVPZGcvRjA5N1NSdzEvNEltOVZEQ1Vwa2tUNE5aRUZndHlm?=
 =?utf-8?B?V3Q0VXRpL1dsWXdZOEM3WnYzTE9Bem9ZeXU4OVM5MXF2Q2ZVeUgzbGlaaXE3?=
 =?utf-8?B?U3VYcFZtc3hNdHVkY2s4NHBFUzZMSEJFam1TRmgyemdubFNMV1FiWTNHcit6?=
 =?utf-8?B?QzFaeDRxbFFQMDFEV0ozb3duTnZFRi9jUDZRWVpkM3lRMXpCU3MxWjhUUFJF?=
 =?utf-8?B?RmlJeTJFVk9yY01MWEdxTmxKZ2ZwUWNTbGlNU2JQSk1rU0grRW1WcHlISmZn?=
 =?utf-8?B?UGVjdUE3WS9rdkszSHk5bndvZDE5OUhhNUlEc2RxQ3NuMFZnTVFSMDhBWHIy?=
 =?utf-8?B?NGRIaXpzZzJuRzl1bkhjUFJLbll4OG5LYmlWbXFOcEFBUFlRMENNblRaUk9W?=
 =?utf-8?Q?+q0GhByx+xJ0lMqbDS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aa94c0-bf10-47b0-2823-08df4197830e
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:05:10.6428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/ZxVhvbPfhvlI063gBSDIlHojE+WMSSJ4/3VJAsmpcMjsaLGgcKciXXvazH+u38HhskGqCfqxFbdNojadbgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 07:43, Kent Russell wrote:

> +#define GFX_V9_4_3_FAULT_CLEANER_INIT_REGS_SIZE 11

Expose this as a variable computed with ARRAY_SIZE so it's kept in sync 
with the array.
