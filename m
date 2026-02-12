Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4E7EE368E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 14:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0163110E09E;
	Thu, 12 Feb 2026 14:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrTlOkPP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B3D10E09E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 14:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQhiE63IyDCXmXd1aDg6KGzOaVZzzz68vxUQExXNFBbNjnuSPHKKuIL05WV+xfLf1Ymd4BSCHMgqZwwRMZEiVwN0atgeO25C2XUyqdUwhsdqufKHL6seYna+zt4hsmawQAJvGrU8+niYhIgEmcbhyW1NPehiUcZvUad7ydvjOjjMIhhXZ89ZLJoB66QkWXKZAI/NSZ5ATaINFqV8scI2+rDnqoemnPIddAOX4NhiJ1GrZHyCJeQ58Z6Zb7prY1B0LrZ2Z21xjo/7EJyx43LuivWdKbbATDOVZpT8/5KOCLcFOEKSGl15DMFbz+FH0DfOFjRtb785Cl14RXEwZv3sQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0BGn7MRZTadmtIOEJX/sJ1+RJd7urt8uzZMabkuA+8=;
 b=LSFZy6LjUfYQmZxxXiOsuOv3iG8WeiAtljmZ1A0bTyZNBAn7L1an8RjAwZRZmVVFlnMElRmkZTdQ8m+jf0w08lGVwPGbi8mQKoUx8A9LUvlvrgxxgm6+6XGvuw9KhEEneeFzMFX81cYdHIyyTdKOUqfFTG5Mts7mJxi0wwaGOHkXqEfPr/b9fp7hdeZ1OapM8o/POa3by7ObvThYX5yqxuAmFuyswZCIjwJNh41uRU8GwL4rMXajLzHy3Glx+ul/lHlbDFMYlNddWKBVDAerQjDgzDKwYv63HGku8Ja2uTMIGxL6fo1mINr0Ygg1T9GN+qNarA5wonzlyEOIt7NTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0BGn7MRZTadmtIOEJX/sJ1+RJd7urt8uzZMabkuA+8=;
 b=nrTlOkPP1iWoSZ8ZrlDTTuu6eUv0f7btw+eFs1s1ZjD7GN/Zo9Dw6YKrP0A1WNQ2fUa8U81KQkFcuxTAog14s7a0Y7+n/555B6lYgvRhCohqTx2Ygv4UcpnNPLyWeF/Tr0o46WE4DTbBy1Jy1m/c+5XsKJCh3E36vuXRryRGtMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 14:32:17 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 14:32:17 +0000
Message-ID: <866f4bc9-0cd6-4b4d-bf04-11484493934e@amd.com>
Date: Thu, 12 Feb 2026 09:32:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amdgpu: Add amdgpu profiler IOCTL functions
To: Alex Deucher <alexdeucher@gmail.com>
Cc: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, david.belanger@amd.com, chris.freehill@amd.com,
 harish.kasiviswanathan@amd.com
References: <20260122151110.3072843-1-James.Zhu@amd.com>
 <CADnq5_P1DcMS7qPfUOSAvdZKBtSoojk-n_H6QO7NenZzht6=gA@mail.gmail.com>
 <1e830669-0647-4508-bcab-a407eb46aeda@amd.com>
 <CADnq5_NtbthAuWjb5aK1AgybxnrSg_xbcJbxPF1BwtiCD3mqyg@mail.gmail.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <CADnq5_NtbthAuWjb5aK1AgybxnrSg_xbcJbxPF1BwtiCD3mqyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::28) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 415034f5-ec13-450a-ebfc-08de6a438576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkRhdjJCQkxiOVNwUmMxRm8zbGJHMEV2MitUZXc2WS9WN0lNTmU0VDFjbjlv?=
 =?utf-8?B?a3JLaGZUY3RyOHVpUDNBSndwWUZpcVlBYWxIcG1xM0N5NTF0cTJHMTdvTldK?=
 =?utf-8?B?aFBGK1FrV1RuQjBLWnVzY0c4NnA1N05UWFJHd2ZneEFjRlZKWU1tdWlIUjl3?=
 =?utf-8?B?Q2NVRzJjcnJzblpQd01sZkZWN0hLbnZ2OHVhR3ZqaVdVSnFBYVJIWUY0bEUy?=
 =?utf-8?B?dlpIcksxSytlUjNJcUhxM3Z1MzlMOGN3SnJLb25oenpZa3hoZU5vK2x5RVdV?=
 =?utf-8?B?OG42OUJzR0tUbGVCTktOQTFxeUE2S0ROOGRzNVI5NjQzRXF1OUpTdEJsZEwv?=
 =?utf-8?B?cEh1MUVVSGxKTEhCbCs2RDlkb1JrS1piLy8reXU2cHVWV2czc1B6cjFER2xD?=
 =?utf-8?B?cTVjQVduMjFJSlZjdHJ4Wk9XL0M1WDRRc295TUFYeE9Zam5CeHYwcUV4MHpl?=
 =?utf-8?B?cnFmQzgxU1daQlhRVkh1UDltN3JMY3lDaXFPNE10d056Z1FHSUJQWHpDaWtB?=
 =?utf-8?B?VjZYT2YrRDZHVHVuMWp4TEVPMGU3eTI2L1gyZzVTYkthSW9OZE5oMVNVV3RZ?=
 =?utf-8?B?NXlYRnM5VFdIZmowcHh0MjVNaXFHNDlZWXlWVjhNNjFhcXl3MWt3Znc1ZG4y?=
 =?utf-8?B?Qklwb0w5djI3ck9hY2w3aUcvcmltN0txSTFRd1FtN0JHbnlJUThJR25BTzFL?=
 =?utf-8?B?cy9NWDRDcUREaVFZVkwvSW1yY0V1WTQ3Y0pNTTdnbllKNkhpWFQxUXdWdHVo?=
 =?utf-8?B?UzhZYy9WN3l5ekkzSUVEV0xHUzVlRmlhbUdOSFpUbkNuNFFHd3BablgwYmdm?=
 =?utf-8?B?VnhmUDR3c3lsY2ZJb3p1Zk9zbksrSDNvS21iVzQvNnJSM2RCUGs2Y3hvMlpF?=
 =?utf-8?B?Q1dscVZLUlVqVWR0a3F4bUc3MjZ2RWx2MDRWODFpQ3Jqb1FVL0xsdlVwUnI1?=
 =?utf-8?B?M3RWcVpacHVkdGR5OEVCZU5UQTJ6YUN1ODVEMGlzQTM2Z2d6UFY4U1JsSFl3?=
 =?utf-8?B?OXpiNWZHUTVieWlvQVQwU2IvRU1QSzdwOGlIRWg5T216UXM5UDgrV3MxSWw2?=
 =?utf-8?B?bml3dTdjd0VXbXRHUUtZUEJvemt2VFpVZGZpMnFRazFLQzRRd29aNC81cnE5?=
 =?utf-8?B?ZXBlUkU3OGVxUHRLelJDV1VOMnM5ekFIa2o0aHRmRmgwdUs0Um5HbXh5cnRz?=
 =?utf-8?B?blZKZzF2RWNwTDMrQnhNSDl6dW5RaWUrZW1OeE1pbVRCRjhVVTRXNW4xbXJU?=
 =?utf-8?B?TzZTTDUwM3l3Skk1ejhDaW1Tak5zRDNXWHplMkd5cG9kdEVEMEJLbXA3dXBY?=
 =?utf-8?B?R1Ywb3JRaytwK3ZaY3RVNldBS3R2YkRvb1JNdEkzVHdmSXFCVXpLclM3aktn?=
 =?utf-8?B?ZnFFU3lleERDV3lSNUhocUNGdFhjaVdxTW1Pb25rVmVVMytneTdzNGZUWEI1?=
 =?utf-8?B?ektoRHprWE93NEhQVWtaZVNpMmJZK1FLM2k4MnNoZGc4aTVNUUYrZUczbDlM?=
 =?utf-8?B?TUozemZlNnFZSXNSU0ErTmN4MkVjQWh5R1BDS09USCsveVUzZmx6SXg1NVJ4?=
 =?utf-8?B?MVpqNGUvSGNUVGl0T3ZqT245MlU5WUozNXhsV3J6UjZvMTNCSU1nTERMS29T?=
 =?utf-8?B?VzY4TTZUbGQrTWwrU1lENlFhRnhsK2s2L0NGWXhweWYyMzcrc3l4SjV6amUz?=
 =?utf-8?B?cEhzZWl0YVNtNGpjek9taUtUdExvQnJhOXR2YlZXNnZ4aUVPYXFPamdQNkEv?=
 =?utf-8?B?Rjh4aHhtZEhnczZOeis4a2FIL3lxcXM0dEdJaDZFajlYcEFDeS9Rcm1JcHRZ?=
 =?utf-8?B?ZVpJZ09xNGIydGZhNzh2dnQ4d1BBU2xnSWNvWXlWbExrRTI3NUV1N3REVTVZ?=
 =?utf-8?B?TExOVHkzUmk1bmV2bHN3L2xsWEtnL0JrSjVYNE8zTTBmbDRDcUJFSnBvay9O?=
 =?utf-8?B?K2ZXUGlONGhPM3FwZ0VjdGJyNlJ2aWVFV2VOdHc5N0U2MVZ5dFZVSU5Ed2lo?=
 =?utf-8?B?cENzSEI3cVlkNjJKNzF6UHhVcXNpZlN6RDZXQndjekFBeWtRRW1ObVUwTmk2?=
 =?utf-8?B?V3ZFNjMvUC9zYUpzNDJNUVlpRTVhMmlORFhqbEExVjY4bjM2dWJsMTBMNDlp?=
 =?utf-8?Q?WqoI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2l0N3FUMmlMMjJ1KzI3N05lY1hrcFp6MS9WMk1KUC8wV3NjSXdjOTFoTTFq?=
 =?utf-8?B?bzJJSCtvWjk3ekhNR1RjcXZWWGw3TFkwVUJZYkY2eUpPelkwNms1dG1sK0Y3?=
 =?utf-8?B?RS9IRDRyaGFUZjVHNnZmNGo2Q290MkVBKzViK2E1ZzF6eUNIWUkyZDRYUEdB?=
 =?utf-8?B?b1JhaFhIbzU0cE05VHBkekdLR2VveSsxV0p4K25kMDg4cVFxN0JreHhkR3RQ?=
 =?utf-8?B?bVphbmZzZXpzWGcvZVNnaHpia3p0MU1maS9MWC9HRktMbzIrZEZRL3VOT2JL?=
 =?utf-8?B?MjJtR0FZajZIa2V2czM3VnBZWjRmNkRMeFZXUm9MYS8zdEhLaytneHdpVEFi?=
 =?utf-8?B?WEI4Rm5MZVFKdW5jQ29YNSsybU9PM0VvNnY0VlcrRFlaSFFXYkxOSUh4cFp0?=
 =?utf-8?B?VVU3SXl1aExITmpzUUFyOU9ZcFJuZ05VaU5MZUFhS0VwdVA1dkFCM1k1WHJM?=
 =?utf-8?B?R0tnbTZxWFdzaGZQeDhQZUdhQUszQ2Ira3hZa2RSZ0dYeG9sQWVFVWk0NUxE?=
 =?utf-8?B?ZzJuS0ZWWGh6UjhNUU1wY0FuSGdnL25UWWRTdzVzWU5KK3dUczJSd2dlaGNR?=
 =?utf-8?B?YWdVUTNCcVpZS0Rtay9wcVhHYllaTTJsc0p3d2s2QzRmZkFJTytxZ1QwUHFS?=
 =?utf-8?B?WVhYMTRxcGtqUWovL200c2daQi9VTmU4cXdxNmhFd3BDQk9WYlVkdjdBMGhP?=
 =?utf-8?B?MUJUOFAvcTI5V2pkdHMrbXZoUFQ5eTZYcDkxU0VrWVZCTi9IOU5uUUlsQ3dh?=
 =?utf-8?B?cTc2UWdXUmpWZzloTnFJK3VTSGs0b29jM1lFUjkxZzJyLzR6WHpRdUJDbFNq?=
 =?utf-8?B?eDVXQVBqbXE2WktCWEM3QkFvcFhOSlNzYzdaVlF1cm9pUmpjbzZ6ZVloSTlH?=
 =?utf-8?B?eWxPL3BXTXV4VjlXeVRaMFBHR3J1QlJQRTRqUW4rT1E5ekpNd1NnV3JtdTNE?=
 =?utf-8?B?L015SlRCYjFSV3VRa3ZITEhmUURPLzZYSGJVN0RUR3pYaXF6N0ZyL0toSVc2?=
 =?utf-8?B?TXRNZnlwbjZPUWJUaVRNd0NkMVVpblVqZkxuSEdZN1NBdStJNDVMYjZ6YTE4?=
 =?utf-8?B?L2FKUzNPS1NHTEoyakpIY0RwWGcxQXQ2R3FxeFZOUjRqTlREZ1JQdXVqTnRY?=
 =?utf-8?B?bzRWdXhnZzNQbUF2aDJoK3VzeDNWQXRYK1dteDIrY0hFdTFieDVnL1NOZFZx?=
 =?utf-8?B?YmtMQjhlamZ6bjlEMWVMdHlmdS8vd2ZwcTloWDhFV1JQU0FZUHZMOVFpUFlH?=
 =?utf-8?B?QldyV1NpOEZON2dUejAzbVBEVUpuQ290VXJZcEl1K0pnSEZlNTkrNVh5cDdI?=
 =?utf-8?B?TW5DZmVsY25iM3BwMFFtc3dJWGpMd0E4MWVsYjQycjNQRmpPOHMrOXE1RVNH?=
 =?utf-8?B?MEJyYnJYelhQamVMeCtvMWNqSkc0V2w5QUdQQ1N4NU8xNWNMeFVIakcvVzEw?=
 =?utf-8?B?YW5mREJ2OUFQeUxxclc3SWx3ZFJoUEwvL3FYZk1Tb0FNa0RzakJJMHdQd2Jh?=
 =?utf-8?B?NExSU1ZIT2g3Si8wUmdIZ1N3d3ZVLzlEWUQ0dUltWnVoeFlFemh5LzVBeVI0?=
 =?utf-8?B?WFZJMW1JZXdiR202ZTdUeGFqT3V5c3cyMkFNYXY5VVdZNFNpbzdnOENJM1FC?=
 =?utf-8?B?cWVUbUxPWUpscUV5Ri8wNGMyd0pSbVk5TjF6Rm9COFdIWkZ1b29kL0pWN25u?=
 =?utf-8?B?bDJDckpBV2pWSkR6dGpEck5hRThHS0pwa3F1UnUzbGZtUng4MTMxWHdsWTFy?=
 =?utf-8?B?ditqSVo3Qi9ZSkMyMFpHMkJLd2lodnRveDJnQnpDd0xRNnBoanlSaktNSUFY?=
 =?utf-8?B?aU5ta2E1NStKd3JSUWEzWUZQUFZXMk5sOUxaMFVqdDlxMW5EdjhFcXZHZVhu?=
 =?utf-8?B?STA3K3pBS2FmZjl0RGZVWTY1SEhnU2hveUN1L0pIakdCcCs1VVJ2TVdERm0r?=
 =?utf-8?B?bnl3aWE5S3pUVllodUFWZlFlblBFeDNkaVBudGQrYVhsR3lZNGhqM0tTOVhO?=
 =?utf-8?B?ZFJQM3g0OTZmN3YwUmE4VEpEbzc5UUs0WVF3a1JXeEJPZWhVU0dZSHBjVlY2?=
 =?utf-8?B?NlFLVk5vaEplWG9JQUkwMHJNNzNMTEt0S2lWSDgzL29qeUdjem5EeVBaM0gx?=
 =?utf-8?B?MzlkNUhtWW9LeTJtVjhJTVV0V2FEUjlEMlp6eVViN3NMV1NMV3JCaVZlMkQ0?=
 =?utf-8?B?UGdTOVJhSEF3NWJrRWlxMnEvOElpcldjRjFnanZuOGNSOWxQZi9TN2Y1MjVH?=
 =?utf-8?B?TWhnSHRrU1J5SnJYd0pqZ0JWSTJRTGdFalR4WkNEWGxXaUp0aGVkbmVXcFZu?=
 =?utf-8?Q?H74lBcXpCUxml1xXOO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415034f5-ec13-450a-ebfc-08de6a438576
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 14:32:16.9651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMEIsd/Qd7IRjySANGs2E2YUOJ+eEyErKjqiFwKtbdNK+YMeU7H8nN5lipX/5uxH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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


On 2026-02-12 09:00, Alex Deucher wrote:
> On Wed, Feb 11, 2026 at 11:45 AM James Zhu <jamesz@amd.com> wrote:
>> Hi Alex,
>>
>> Thanks! Answer in line.
>>
>> Best Regards!
>>
>> James Zhu
>>
>> On 2026-02-11 10:26, Alex Deucher wrote:
>>> On Thu, Jan 22, 2026 at 10:22 AM James Zhu <James.Zhu@amd.com> wrote:
>>>> to support PMC, PCSampling, SPM etc.
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>    amdgpu/amdgpu.h          |  8 +++++++
>>>>    amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
>>>>    amdgpu/meson.build       |  2 +-
>>>>    include/drm/amdgpu_drm.h | 19 +++++++++++++++++
>>>>    4 files changed, 74 insertions(+), 1 deletion(-)
>>>>    create mode 100644 amdgpu/amdgpu_profiler.c
>>>>
>>>> diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
>>>> index 39b61539..87eec030 100644
>>>> --- a/amdgpu/amdgpu.h
>>>> +++ b/amdgpu/amdgpu.h
>>>> @@ -2072,6 +2072,14 @@ int amdgpu_userq_signal(amdgpu_device_handle dev,
>>>>    int amdgpu_userq_wait(amdgpu_device_handle dev,
>>>>                         struct drm_amdgpu_userq_wait *wait_data);
>>>>
>>>> +/**
>>>> + * Acquire profiler version
>>>> + * \param   dev               - \c [in]     device handle
>>>> + *
>>>> + * \return  0 on success otherwise POSIX Error code
>>>> + */
>>>> +int amdgpu_profiler_version(amdgpu_device_handle dev);
>>>> +
>>>>    #ifdef __cplusplus
>>>>    }
>>>>    #endif
>>>> diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
>>>> new file mode 100644
>>>> index 00000000..8d4dffe4
>>>> --- /dev/null
>>>> +++ b/amdgpu/amdgpu_profiler.c
>>>> @@ -0,0 +1,46 @@
>>>> +/*
>>>> + * Copyright 2026 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>>> + * copy of this software and associated documentation files (the "Software"),
>>>> + * to deal in the Software without restriction, including without limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>>> + * Software is furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +
>>>> +#include <string.h>
>>>> +#include <errno.h>
>>>> +#include "xf86drm.h"
>>>> +#include "amdgpu_drm.h"
>>>> +#include "amdgpu_internal.h"
>>>> +
>>>> +drm_public int
>>>> +amdgpu_profiler_version(amdgpu_device_handle dev)
>>>> +{
>>>> +       int ret;
>>>> +       struct drm_amdgpu_profiler_args user_arg;
>>>> +
>>>> +       if (!dev)
>>>> +               return -EINVAL;
>>>> +
>>>> +       memset(&user_arg, 0, sizeof(user_arg));
>>>> +       user_arg.op = AMDGPU_PROFILER_VERSION;
>>>> +
>>>> +       ret = drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
>>>> +                                 &user_arg, sizeof(user_arg));
>>>> +
>>>> +       return ret;
>>>> +}
>>>> diff --git a/amdgpu/meson.build b/amdgpu/meson.build
>>>> index 3962d32c..d781f2e9 100644
>>>> --- a/amdgpu/meson.build
>>>> +++ b/amdgpu/meson.build
>>>> @@ -27,7 +27,7 @@ libdrm_amdgpu = library(
>>>>        files(
>>>>          'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_device.c',
>>>>          'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_table.c',
>>>> -      'amdgpu_userq.c',
>>>> +      'amdgpu_userq.c', 'amdgpu_profiler.c',
>>>>        ),
>>>>        config_file,
>>>>      ],
>>>> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
>>>> index 947bf261..107d2b69 100644
>>>> --- a/include/drm/amdgpu_drm.h
>>>> +++ b/include/drm/amdgpu_drm.h
>>>> @@ -57,6 +57,7 @@ extern "C" {
>>>>    #define DRM_AMDGPU_USERQ               0x16
>>>>    #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>>>>    #define DRM_AMDGPU_USERQ_WAIT          0x18
>>>> +#define DRM_AMDGPU_PROFILER                    0x20
>>>>
>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -77,6 +78,7 @@ extern "C" {
>>>>    #define DRM_IOCTL_AMDGPU_USERQ         DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>    #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>    #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>> +#define DRM_IOCTL_AMDGPU_PROFILER      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>>>>
>>>>    /**
>>>>     * DOC: memory domains
>>>> @@ -1616,6 +1618,23 @@ struct drm_amdgpu_info_gpuvm_fault {
>>>>    #define AMDGPU_FAMILY_GC_11_5_0                        150 /* GC 11.5.0 */
>>>>    #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 */
>>>>
>>>> +/*
>>>> + * Supported Profiler Operations
>>>> + */
>>>> +enum drm_amdgpu_profiler_ops {
>>>> +       AMDGPU_PROFILER_VERSION = 0,
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_profiler_args {
>>>> +       __u32 op;                        /* amdgpu_profiler_op */
>>>> +       union {
>>>> +           __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
>>>> +                                         * lower 16 bit: minor
>>>> +                                         * higher 16 bit: major
>>>> +                                         */
>>>> +       };
>>>> +};
>>> I think this seems fine.  I think we'd need to see what the other
>>> opcodes would look like.  What is the version query used for?  Can you
>>> provide an example of how the profiler would use this interface for
>>> actually profiling a job?
>> [JZ] Profiler team requests this to track some profiler internal changes to
>>
>> conduct profiler version control.
>>
>> The op will include PMC, PC Sampling and SPM so far.
> That makes sense, but I don't think there is much to review here until
> we know what those interfaces will look like.  Also note that even if
> the kernel driver supports a newer interface, it needs to continue to
> support older interface versions for backwards compatibility.

[JZ] Since ioctl interface is changed, user mode side needs update also.

If they open kfd interface, it will follow old version control. if they open

amdgpu interface, then it will update to new version control.

This is drm portion,and mostly relys on kernel portion.
[PATCH v2] drm/amdgpu/uapi: add profiler interface
needs more review on profiler interface implementation which

is based on device/XCP with out process embedded.

Thanks!

>
> Alex
>
>>> Alex
>>>
>>>> +
>>>>    #if defined(__cplusplus)
>>>>    }
>>>>    #endif
>>>> --
>>>> 2.34.1
>>>>
