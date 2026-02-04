Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C1CE6E815
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 05:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7994210E0BA;
	Wed,  4 Feb 2026 05:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ag/iKwIy";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280F510E0BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 05:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V225GFtq66lJFP/JjLMZIC0MKtuoNgXtHqeUC8a1Iux4DATWjZmIOYwlVOhRV1vMgZQcqSKEgytyXaAtxvPBeFNGhfKRKasYv4SGsU74alxeWY1dJZlWT4P1exBqhGh7BICaR8CqOZKqCYxPlGnnsLwoqHG1hCUKbHYXaL7ufd+clxvRyOUmW22jqbqXmC3+GxcZw1ns7QkhTUvjxpQ5tecrl9iyTjGlwxPq8QhJo2ilHVRiZOmzXtIHwN54woHBzMWt4IK9HkC4Km7+/H+GG+AuhagwI4gpJsQzvW7WVsUbM9Lt+yewUERiMWfFBOJpoztAJbizxgw2frEpA5YW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhpxzJQc3oc6LlQxutUxa0LcDZMtSWuQ49rZzl1Ybeg=;
 b=im3AxKIECplFOaT21ZDe/1PavLdrxNuj+TPBg2LONxpdZxg5x1d9JM6iSWQ4kTfmJeAUCyTnJwl0wR7GB0dCV9qs8kSeW+luR7xzsAG5ARvceL059UMlFw/xTgW+5BA5W+WFhYWpIo0/nAOJgZZXKNpVgc0XYu731b3g6cvX5+N46v3181KgNaRRv6PNA9rKXrPlfuBSw3xihbh14Eyvp/BFd3rO16lkaRElQLI0Ruf013Ml8GbVGEwLHi26MUtU0L81JMPHWKGe7ixAxfwG7hDyo3pwbUo5rbzpMFuT7EKEJzHjEKDfnZ2Yt9AyzRi4D+h2fr46vgrV4Jj+uD9P1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhpxzJQc3oc6LlQxutUxa0LcDZMtSWuQ49rZzl1Ybeg=;
 b=ag/iKwIyFNd3LbRSUESfDsZJm8n8nF8dw0cbPLE225LDaZPssP4sRhzOzmZcN+u547ZIfVM9d8bPLBGfTXiGs4P8oECgp7U7RgOEo0O481fONFE0rJEwUk9J462tF3dBQAlZN/jvBGQsTqsP2hgIk10ACrK8ZQLr29Z8GHQK9Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 05:51:21 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 05:51:21 +0000
Message-ID: <471e7d36-d136-4523-bd59-7b06112bf0dd@amd.com>
Date: Wed, 4 Feb 2026 11:21:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in
 smu13 & 14 & 15
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260204034732.187325-1-kevinyang.wang@amd.com>
 <9f783e4c-9609-48e5-8a11-1c6debcf9916@amd.com>
 <PH7PR12MB59979ADFBC092D6DF4549A228298A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <72777119-86d6-41b6-ac77-3cf02d861273@amd.com>
 <PH7PR12MB5997A2311C5F7B9B62828F428298A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB5997A2311C5F7B9B62828F428298A@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cb7ecc-2546-4542-8b51-08de63b16c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkpOTkNadkp2TTNWa3pmdHl2MXVIZFQvTVRSWWlDTnhVeFQ1VDVyNnNzMjRv?=
 =?utf-8?B?cks1Z2tHdXNIUktxNXVJdUZVeldiRm9IMENBTkZ4TklXT2hZZHR5N3VaNWgy?=
 =?utf-8?B?cC9lM1BLa2xCTDZNVzZFa0pVY0pUYmZGM2VjbUdZVEkwenpndjkwWUlHL0Va?=
 =?utf-8?B?TnphY0YzbVAyaXVPckoxRE4vQkFVeVRBSURiU080WVptSWxHUkh4TnFsRHRw?=
 =?utf-8?B?SkJvZXNzdXdtSit3dVdPYkh0aThFbDNnSjNSajdoZ2M2cjYxU0FqeUlXSXdZ?=
 =?utf-8?B?TDVrVkp3dHdaeWVLMXNPUVJyMlpzcUVKMWU1aWozc1V1ZGN1Ni9oajdJM1BX?=
 =?utf-8?B?ZlFyMUhrNllTbmdKVTQ1YzRSTHdKUEpjRkVaWUttZlEvZUFGWUYrcGtMamwx?=
 =?utf-8?B?NUdxcThReDRieWdpa3ZpaXdIZ2tmeUZYY2JrNDNHeFFiandMb25kT1V5SitW?=
 =?utf-8?B?OE0zclpxRlZleVV5OWQwWUU4L3VZemR3ZU5WL0k4ZWk4ek9aUkl2WWhNcDV4?=
 =?utf-8?B?bzh0Qk1KbjRlRHBrUUh3amxSanRjWDZWSnVqdEdvOHJSWVhhUUtmRUYzUG9C?=
 =?utf-8?B?VVgxblRvRTNGdFJGWDZJemVyWkJ4UjVlSys3UEhWb29HTzFuWFp2Q3kzSk1O?=
 =?utf-8?B?cDhuVm11T1pIKzZvR0FLeHdpOGh3YU1wZVdtc0p5c3cyNTZIYWY5MXJGUS9y?=
 =?utf-8?B?eG9oOUNUamlsYUZrSmM3OUF0aFRXU0VYZGJMK2RvaFVpeUozU0Q5ajBjUHJQ?=
 =?utf-8?B?V3NOVjBRUSt6QmRRZmdsTmtkcmpRaVF2OFh1TWRPR2ZPQ3lrc0UvV0crLzZN?=
 =?utf-8?B?a2ZUQTJuRGRHdDg5amw4WDg3bXVrcnpuNXdGUDBJai9TaU1RYndBNklldGtL?=
 =?utf-8?B?bjFxN1BRMGRoR0ZvUFZPcW5ORnIvcGlrOTFmSkdqVERiNGFzYy96bUFSS2t1?=
 =?utf-8?B?VXdqT1dUeHI3elRjQys5UWcralZGQk9MR0JvaEZmQkJYK1FGbm9OczFMa3JN?=
 =?utf-8?B?YVBPb0tlZ0dIRFIzbG80N0Z2Rk1oaVJ1Q1UyN0F4MEd5TkNubjh4RzltbVlm?=
 =?utf-8?B?bnNwM1N5eHFXU1JlMTJpWFFpZFgycUlQQ05rRnVUZmpIZE94dUYyNDNJR2Rs?=
 =?utf-8?B?NHpzby9pOHpIeEc4U1dkTDdnZW5CK3ZadFkra1pFRVpQRTVYWWdPR3QrRlZn?=
 =?utf-8?B?cEJXb21uTHFhMGFpWVVyclZFUVpPZEoxNDMzOEc0ZmJaY1JRZmRVZS9IaTRG?=
 =?utf-8?B?ZFlHOWJjNWFvMlhyNmxNWXVLekJTL3ZFb1ZPN3dZYWVxclI5VlBDb1Y2V0Ja?=
 =?utf-8?B?K2wxZWJUMU9nU0RpWlpaS1EyS0xITU5nWm04OWhvZkQzSmlac1FnRHlvV1FM?=
 =?utf-8?B?MlVHRTAxNHcxTklpdCtZRTZ6NlFDbzRQZTJPV1gvZ3A2WVhrakc2bWI3SUhI?=
 =?utf-8?B?UTVCaG44S0pTRm96V200eGpSTVhIT3ZudnZaS3RHcVhsYkwvTHZkVEtqVEJX?=
 =?utf-8?B?ay9lQko1RXIyQVJzYVRrUEdNU2tGdUlCN2VEZjdJTFR2SG9iV1Z6aXFvd0Rr?=
 =?utf-8?B?UUo1OE4yd0tVckdhMlg0RUIvSXhwWGRVT3Vab3VLOTFZekljQUZuTXdvWmVS?=
 =?utf-8?B?Q1l3eUpHUXVEV3dOWk14WVdFdFN2RnQyQjlVbzRNYzRCK2ZkMXY4TS9rYjYr?=
 =?utf-8?B?YzNWSWd6OFEraFI1eVBzdlY3UG02amo3cDk5ZVpaOURtd1IvcmFwRTJ1VlFm?=
 =?utf-8?B?NE9yd0xpSkMxT1FKT1RSUGRNdEZWemliWjhUbmgxUDhESTRieEUvb1JDUGRX?=
 =?utf-8?B?aFdnZ1V5dzVDaGtiNDhDek5uaW1SZ0R4b0JCVVlPYmozaWd0cE4vV1FZWGRo?=
 =?utf-8?B?dVpzRFZhZUp5Sk92eFJ2dXJyM3lzK0E3QU5na3h0VlExK01Dc25PZjJSblJm?=
 =?utf-8?B?am9nWTBQV0ZncVhGSjJrd0RMM2NMQS90OERBeEFBS0M2OTZlQno4OERtK2I5?=
 =?utf-8?B?YkN1S3hWOE5NWGEyUUFjY1VHM1Fyd2huSEVSclMxQXRDT2RtZm8wRHo1b2Yv?=
 =?utf-8?B?dnh5MnF5R2IxbHh1YURFQWkyUjFMSGFDWWx3ZW9Ld2pBUFh3ZStXSjR0ZXk1?=
 =?utf-8?Q?NJ3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2dZSlBzVEozb2cvVURNeFhxNEI3NUxCcnEvT1BNb01FaExTNUhQSExOMllH?=
 =?utf-8?B?d0ovUFlLWUFIVGVTYWJuRHF3NFBvNjlybHdaT0REWlFXVHIybGJmajExTHEx?=
 =?utf-8?B?ZmxYNElKZUdxOUorUTBKV0lGZE9DcGF4YXVZdE9PeDE5eU1NQkxCUElkOEpZ?=
 =?utf-8?B?aEJjbUZxTEdnclpXd0FvYnV2NTNnUlh1YWJHNGxaQmMyV0MyTTFXMzdFa1FU?=
 =?utf-8?B?YWhWUXZacndPZURJODZVQXFWZnRoZ2xqSllWQ3QwZVJET0FuZ2tpNVlXTGQx?=
 =?utf-8?B?d3NTb1BJdEJ3Wlkza01tY2htQTBWS01Db0lzQWtGTGgvL3hqcXlwNnBiY2p1?=
 =?utf-8?B?S1k3UWcxa01ySEZhU0J1L2tGQTVmenYzeTFhaVpxQ09oRnNkeURhUysrSktS?=
 =?utf-8?B?UTdzZGp0S3ZlVzcrTzEweVRMY2ppdzFFV1hXOFA5NldTMEhQOVpzY1hZWFky?=
 =?utf-8?B?Uk9xclgrSWJmTGJoMWp6dVdDdnZFL1hEN2llSE9LLzRyRk8rRUJrbGl6K1NZ?=
 =?utf-8?B?cTc3dmJnY2Q0S2JGSEpESVB6MWxKRG5lQURJNVcxMDRPd3ZpbGhaRFFBeEc1?=
 =?utf-8?B?OHpFcWsyNnRKZTAxYlpBR0JZTjE3N294QU9vWVA2RzMyN0hYN3lrWlZLOEM4?=
 =?utf-8?B?NWs1N3MzUzd2VStvNkdKSXdUam9TWnBZazdNUjZrNm5vbCtocm9zSmcyYy9w?=
 =?utf-8?B?b01FQUZSTkhNZkJDYlVxZ003cDAydUtnckpmRDZvOUxDWlk5RFl3R0NTaUwv?=
 =?utf-8?B?Zkc3bmVMMk5Vb2kxR3FIclRPZHhzdVN1K3JkZ1N2TWhzZkRXKzE1Zy9hNUtr?=
 =?utf-8?B?TmZFR0NtTis4L01XVG10WFhYTUY2ZTBleUhWS3E5bUZ5SjYyMWZUbU9wK1Ry?=
 =?utf-8?B?SG0zb3lPM01HNFdQZjV0dHJkclZHcWtzV0V5bUNGUUFrQzdQM3BET0ZTcTNh?=
 =?utf-8?B?enJqUmFLbE8yUzlCeVZ5RTJvK2h4bFF2MlJUNHU4eFpoWmlQOWU4Rm9VZExi?=
 =?utf-8?B?Smo0YU94YmJDNjVERmkzamdCd1BzaTR0Ym9tUklUUGVmeVhrRlNJd2NKUUlp?=
 =?utf-8?B?OUVNRlZUNG4yV1Q4U0w0NXVMSHFCTmtjSHhVTm5hbmQ0bmNaT3RwRS9zRmtE?=
 =?utf-8?B?THFGbEFId2dJNGJIU001WHFjTG9Uby9yMGI5YkxlWjVjeUgxNmtCNnorYlBl?=
 =?utf-8?B?U2FqV3Y0VUtaa1JFOHhFZE01Q1JoWHc4Nk4yVmZaQmhlSElkd09kOWxvZDRL?=
 =?utf-8?B?aUlCNElDTWVOeDZ1MU5reVJBcys3UkhtSDVDbnVKbGp4eGtLR3RNQWx3L3Zo?=
 =?utf-8?B?RU1DSTkwYUE5RlZ5V1laUkJqQy9XWHJnQ2VzT0VFL1cyLzZFM3JFS2ZpT1ZN?=
 =?utf-8?B?eThIL3FlNjdsSkVuZWZMVUZxRDJVTDV4R3F4ZkF4VlU3dGJSYVlNbDZmN2s1?=
 =?utf-8?B?aHNVSzVYU3Q3VDVzdTUxS0ZXNEtGZjd5ZFdUTFQrWERLMS91QzcrT1lDeWd6?=
 =?utf-8?B?ZnZxN3BYRUtqbDJweE1Wa0V1TTlzNFFuZ0tZMFFsVFI5VjQ5bWJpYUhQSUR5?=
 =?utf-8?B?QWEwVHJPcnFCeVJNWDVyaEZ3VXBzUzNxblJ4RDVoMkpyOVBjYlpuenpwZ3Vi?=
 =?utf-8?B?U1VmMXNUdzk3c0hYOVdORUpRRDVjandDbXJtZWpXaUlrelpwM3VkZkMzTVh5?=
 =?utf-8?B?QTBaaHFMN0ZqYWFGQk13cXBUWmRYMmUyV01tRUt6clNFakNaUVJOR1VUdnpX?=
 =?utf-8?B?WHRUQ25kNWpzYXZGQmFJNlZOS1RLaEN6Z0tYbVRzK3d6c2ZKZkh0S2tmd0xw?=
 =?utf-8?B?YUszRFlqT0YzenlpZFNYd2VYekRTMk54VzJQUVZyM1haLzFXSW1HRTNYdjcx?=
 =?utf-8?B?cGowMzhtZmM1T0xjWU1QRWJjeHB2djdUNENTcWJSZWlnZW44czNGV05nTlkv?=
 =?utf-8?B?NTFZRCtiT1EzNVhad1RGZXJYdVFSeFJnTFBNWEhvaThCaUNuSmt6dWs2K09i?=
 =?utf-8?B?bDZRbW45TjE0cGFTempiSEdmcEk4Y2Q5dGE1U0luVFBLOGF2UTRxUGt0c1hl?=
 =?utf-8?B?NW42MDltVDc0ZTBaalE4K0V2cHQwMTc3WEZlUnNCbmNTNkg1Z3lsOTRJcVNI?=
 =?utf-8?B?c0FNdGgwbUdpNDgzZTdUbzhESjNyQ2hhSm5ySER4QTNoSGZaSk9YQW5sSmQ0?=
 =?utf-8?B?c1cwdDdSM3F5SjdNbGNtb1FaQk9sOGFaK051eHJLaFJMRTJ2QW5KNnhRYWZP?=
 =?utf-8?B?QmRoVVlnRElvWVhOQ2pObVVERjNhWTVwTFQ2RXJCaTR0TGY1U3pidFN1dzlY?=
 =?utf-8?B?WVRsNFFxaE1sZHZNMkJsMlg4VkhpZjRBSy8xamlRc2FJMVZIN3g4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cb7ecc-2546-4542-8b51-08de63b16c85
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 05:51:21.5535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+c1Tw0uH3bLjdJ2SI4he5B3FZiKn6gkQ/uqysOY4Cl9odSeqrNiJ18bMe1Tdr2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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



On 04-Feb-26 10:51 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> I think you are confusing concepts. How do you explain the EXIT/MANUAL case according to your logic?
> 

I don't understand.

[1217924.810528] amdgpu 0000:44:00.0: amdgpu: Invalid performance level 512
[1217924.810537] amdgpu 0000:44:00.0: amdgpu: Failed to set performance 
level 512

As per this error message, the user tried to set a performance level 
which is invalid for the SOC. That is the correct behavior.

Thanks,
Lijo

> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, February 4, 2026 12:49 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in smu13 & 14 & 15
> 
> 
> 
> On 04-Feb-26 9:38 AM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> The term "invalid" in the dmesg log may cause ambiguity for customers.
> 
> I don't see anything wrong with that, it says it is not a valid mode this SOC. Similarly, modes like AMD_DPM_FORCED_LEVEL_PROFILE_PEAK,
> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD etc. are not valid on Aldebaran.
> 
>> The software-defined performance levels shall be properly handled by all pm swsmu/powerplay backends.
> 
> I don't see anything wrong in returning invalid for something which is definitely invalid.
> 
>> In addition, the kgd interface should provide a consistent set of APIs to ensure that user-space programs (e.g., amd-smi) can invoke these interfaces without issues.
>>
> 
> That is missing a query interface for valid modes. It doesn't mean not returning invalid for something that is definitely invalid.
> 
> Thanks,
> Lijo
> 
> 
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, February 4, 2026 11:52 AM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM
>> level in smu13 & 14 & 15
>>
>>
>>
>> On 04-Feb-26 9:17 AM, Yang Wang wrote:
>>> add missing performance level AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM in smu13,14,15.
>>>
>>> kernel dmesg log:
>>> [1217924.810528] amdgpu 0000:44:00.0: amdgpu: Invalid performance
>>> level 512 [1217924.810537] amdgpu 0000:44:00.0: amdgpu: Failed to set
>>> performance level 512
>>>
>>> Fixes: 6be6424684cb ("drm/amd/pm: Enable performance determinism on
>>> aldebaran")
>>>
>>
>> Determinism level is only available for specific SOCs, so the the error message is still valid.
>>
>> Thanks,
>> Lijo
>>
>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
>>>     drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 1 +
>>>     drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 1 +
>>>     3 files changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 63a65ea802fd..d17d6cd71028 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -1659,6 +1659,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
>>>                 break;
>>>         case AMD_DPM_FORCED_LEVEL_MANUAL:
>>>         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>>> +     case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>>>                 return 0;
>>>         default:
>>>                 dev_err(adev->dev, "Invalid performance level %d\n",
>>> level); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>>> index 7dc6687c3693..68ecba0d5e0b 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
>>> @@ -1321,6 +1321,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
>>>                 break;
>>>         case AMD_DPM_FORCED_LEVEL_MANUAL:
>>>         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>>> +     case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>>>                 return 0;
>>>         default:
>>>                 dev_err(adev->dev, "Invalid performance level %d\n",
>>> level); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
>>> index a2854d528bab..1860bd0f1091 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
>>> @@ -1210,6 +1210,7 @@ int smu_v15_0_set_performance_level(struct smu_context *smu,
>>>                 break;
>>>         case AMD_DPM_FORCED_LEVEL_MANUAL:
>>>         case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>>> +     case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
>>>                 return 0;
>>>         default:
>>>                 dev_err(adev->dev, "Invalid performance level %d\n",
>>> level);
>>
> 

