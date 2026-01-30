Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CA3E6BF37
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 20:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4A410E37B;
	Fri, 30 Jan 2026 20:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhbQg2hN";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112D310E37B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 20:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk0WcQiolCwFKcyjD1Ij6DIAsCd/i7DcDtkozG1WLjUbvuU0cq1qPGF2ZURio0YOM4bP7EaQ9CyRfKbk9w7x+jp2MUf+FX9WdR5vyrdh/WcheTSC6YM5dhPaOwRZKtvfDrc9buMhaH4/uCJIIlLwPvGgZwDy1QSwA8dE1Ycj/LdIzu+gARJtK+89XsjJ2Y+P1HELuZ/6ZonzM3u9IKY6o6eFRekSTIqk+QAEN3Ei8Lyu/+pNfSwqIzZ4Jm1M+RJg5Dyg4T7pPetwHc8dC5xa6+m8s76c5w7k5wgNaYjugPmP+b8EcGWW+TYKg5oooZRs7oMFvZVhF/bR7vNxKEqGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcW7UNFmy7GW8QE4mikNbWdj4GmgLNCJ8bErfHVclEk=;
 b=y8Kk6COnhHprgQEJGdNlsi2uu8A1Gwj4fNuZ50IpsQRelf6WZe2bLnzMOsGKlnelIkBvnvgGweaROfHSRMLLdgumBW1bsL/xuRLBLad+CQkt1Cfc16MLZEHzYO+4CwqQa1f30gWM2Fx4mLiRlgTkvrDsue3FUvqFGGWg4kEf/SO14w7SQPgY5TTGL0IrAh1cm7u7WzhiT+jTOJx29HefZX4yfdb4ucw11SWAnVk9ys2fpk8ptb/UH6wAmbLkXe00LLjKB7y6WuyITFVXM9I2h+BDNWhxDIdMde5Cdnupqa0Af+8+WabjLQJ+QnNmoEzYdS3jdodI3zNk7Z4rsJDbhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcW7UNFmy7GW8QE4mikNbWdj4GmgLNCJ8bErfHVclEk=;
 b=mhbQg2hNv5OjDSQt+iECZUZJOj+/osh31MA5uJUvqWE39BZh6tRkk+4utVGGMnYQ1ea/QKVhM22QJ2GyVZqvSO/oOWbJqVxvjzJbVX0YBOk0yPEsT6qKuOxJKSO/o5JAypV4XVwZDKeAKBLHwamsFkUoASFiwqhYbLH6/2fTyFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Fri, 30 Jan
 2026 20:00:54 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 20:00:54 +0000
Message-ID: <e1d478b2-99a4-40af-94c9-5eddc72a717b@amd.com>
Date: Fri, 30 Jan 2026 13:00:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amd/display: Refactor DAC load detection, move
 to HWSS
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
References: <20260126210837.21885-1-timur.kristof@gmail.com>
 <20260126210837.21885-6-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260126210837.21885-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: c126bf66-3685-4fac-26bc-08de603a46c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlFLa2VoYWdHVGJyTXptZkhHUm0vK0NhcFBKYW5WcmdnYVhlQytMdHVLRUdt?=
 =?utf-8?B?WUJSNm5hSUo1aFdHRURsRFJRTU93Z0M2RHdWdk1TRGYreU5tN0Q3MHpJSmNp?=
 =?utf-8?B?YXNKVlRMcXZ1TGtTRDVFUXYvU2RpYXRYKzFzUWtJQVpUek1Qa01DOXFSTTNN?=
 =?utf-8?B?Y2UzSVRPeEdGV0d5WEpZV3U1M21IV2l6c1hyS3pMWWNiUzBxV2xBdmJrN1Rt?=
 =?utf-8?B?WGFpNWJjb21mY3A4bmtyeDkxSFN6dXR2Y0liUC9OUjJOZ3V4Z1paTEVDS2FE?=
 =?utf-8?B?ckJDSUtKYVRQRW91c2hWbGFWUXY5dW1OYk1HMDhsT2RXM0xEeGx6ckFmMHlS?=
 =?utf-8?B?VWN4SjlCZ1QwQW5sQnBEODI0bGVhbktxQWY4am9La0txUVB3UUJ2QjZVTkxh?=
 =?utf-8?B?SHNiL3c4QUN3RFZ3N3ZITGJ0SDRQbWZjb1kxeVpFdDNFVUlqSkxhUDBYQmxr?=
 =?utf-8?B?WCswTEE5OHhPZFB3dnhKeUtzRHdzN2NNb2NRNUJLYnhIa2pNSzNPOEJiRThT?=
 =?utf-8?B?dTh4dEFuM2hrUWFPNkVwN0VnV1RucFpQc29scktuK0szZEpnMi96cE9Mdmxl?=
 =?utf-8?B?ZEVUYWdrellDN0JHdXVMS0pGZUdjZ2ZuL05mVERWWVlORSthSDVTRE9SZy9V?=
 =?utf-8?B?QkZhZGpTajZiYnZmcEhxQ3BRbTJ4ZkJsc3VUbjZQTGppbXQrQWhKUFhMc2ZY?=
 =?utf-8?B?OWg4RGR6S1N6Tk52WFRzcmd3SjN4Q1BzcTgzOTU1ZUw3YXA1Q2xtKzhJTnRB?=
 =?utf-8?B?OWpZVVpCOFZKV0xHK3lTRCs3YU11VEt5RkJvOW15bXd2L0J3akdWWGx6YVA4?=
 =?utf-8?B?bmo4TTBEK2RqZ0ZNMU9sS01kRUZUeXBlVEl0OFo2SHZmSTVia1U5S1pmeVkz?=
 =?utf-8?B?b2dEMXExdWlSQU9vcmo0UHBXYy85ZmxLa0RwUkRJaEkybVJjRFIwOWVCN3RK?=
 =?utf-8?B?M3RlSyt3Q3BMditablRrNS9XcEZqdXhFRHdySHFOTXlWY3N4UGFPc0VxN29Y?=
 =?utf-8?B?NUthNkZodHorQkFUU2UvRUZCOHQrdGc5elo1RlZ0WDRialBaNmZvZllYZVMx?=
 =?utf-8?B?TEdNMXJJZmxqUkZhYno2RVpwRVN4Ry9vRVZWZGs2cU9NdkJva3pFRWVPc3Vv?=
 =?utf-8?B?T05hQ1JuaGMwODBBUWE2R29sQnVZUVljK0pFTnZ6ekUxQzU2QnBKMnRENExn?=
 =?utf-8?B?MzFzZDNlMFd5czR5WktSdDlpUkptelErQmV0dHAyT3VaeGR2bmVUQlcvZDVZ?=
 =?utf-8?B?QWpWZWtETjlvbEpCaTllSXQxc09ZdFMxR2FHaUVLMW8xekxYaWNrLzF5MWxt?=
 =?utf-8?B?TjNtVlkxSElMK3R0UkE2b0lIMnlXb1A3dU5HZHBJcjByM2JCYW5CbmFxcVN5?=
 =?utf-8?B?T0JhNzlZZmV1b3lYQVQ4Z2NoUGNjWFJQSjh3Tkc4VThieHYxd0ppOVpqaWVH?=
 =?utf-8?B?bU9nWnU5LzJJTlpoL3k2SVJWSU9YMy8yMjFRbG5oeHNKdUgxWXZPQUdUUmRs?=
 =?utf-8?B?M3ZYZk9oVkw0dHlmcHZuUERZSnY3MjVNdkhkT3VkUldFWHg1NTc2eVdnK2tN?=
 =?utf-8?B?bnVVNVhua2diL2FWMFdtVHE5WW84V2FMMTUvOXhmb3RkamxVUVMwZXFlUXN4?=
 =?utf-8?B?YkxkKytQM1dHQ3hNSElYQVRaMGhmSmJ4WWhvdE1XSjNCVHNWZXpyVWtNVE03?=
 =?utf-8?B?bTc2bllQOFBDQ1U1QnMvNUNHWStvbHd3SDluM1NWQmNlQzVtSXZyWjhaVXF1?=
 =?utf-8?B?YmFJNUtSRWdsZ1BMRmFJOVEvNlNRbzJDYW9Vd0d6cVNtMWFQdmFNNVhvSHFR?=
 =?utf-8?B?OEFwZGlMSnFMODF2cCt6S2MyZzZHcm1ySjJ2UlNDNHE3bURIT2VpUUtiUCtW?=
 =?utf-8?B?RlR0akluNU0yM2cvckVWenROeWVjODlyTTJnajZNeUw1azRyQ05Id2E0YmZY?=
 =?utf-8?B?ZU9EUWVaM2NrdVpSSEF0WGhBRnhBeTJSQW8rbm1CRTFYSysvOGR3QUYwZm9D?=
 =?utf-8?B?WE00dWMvbGJHMEw1YXRqdW9oaHFDWGZ0WFozQTRuaG42TmNZYjkvZnNSVWNt?=
 =?utf-8?B?eGJ3b1ozZ3F0dGZrM2RHR1MrYmZaZ2tXRWZWUmJ4K05ZNWNpRDQ0RzFlcXlC?=
 =?utf-8?B?MDFyUXZ6aUcyNDJ1SUh0eUczeXJpTTNmUEh4b2UrY2dSbi9ZaURxdjBWcGRn?=
 =?utf-8?B?clE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjJsRE1OaFQzYnFwQmpVWXRiSmxMWEhDdE5xVjZJd3pKcFg2MlB6NEE2a0dR?=
 =?utf-8?B?UHB0UGdxai9KZU9tS2RoQTZ3VGdsQkhwaEhUSkxwSnVxbWJHU0hoRzJ0SHVo?=
 =?utf-8?B?d2lrMTAwUVpseXRFaFJFU0lyS3JDQkZYTVhoRkxBeWN6MytsTUJTa3c4anZ4?=
 =?utf-8?B?TldaSHhOdWo2UHYyeW5vSlphREp5bXg2eWYzNlJqNVNtcjIwQm5DV21OeXhY?=
 =?utf-8?B?U3BmNytQVkxUY1dGdVVNaGdtNitMM1doaC82Ymxuem1BcFRNYUN0REpGOXR5?=
 =?utf-8?B?ckNWYllVTi96eU5ObWhHeTlSak9pdVdwZG16Nk1KMFA0U3dzOGVrZlMvNysx?=
 =?utf-8?B?d3dMWWZkQmJtejBBSkxkT00xeCsyMnlVM1REajB3MXlCNzdxOTY5cVlSTWs5?=
 =?utf-8?B?OXVCbERnbzZyTUlVdlNaVnNIZHRldUdaZ3pZdUF0c1pSNDNXNDlvd0NwbWVQ?=
 =?utf-8?B?eG5UclVZNWw4SVFIc1o1MDZhUDdYOU5oMDhRVEZiVEFUQ1llT0xoZ3dteHdJ?=
 =?utf-8?B?a1ZaKzZuSGo2VlZ1Rm1MR3BLSXhRanVBSmZBNUcvbFloMVJ2Vy9OMGFob3Jm?=
 =?utf-8?B?Qm12VE1ZTGVaNUdiWkNTL042U0Q5bDZ3eGxOVGdnWEhZWU5zUW1aRjZuRlNY?=
 =?utf-8?B?MldUWGZPSVNFK216UmhLSGxzNFRzR09PMThqaml2UUNxRC82aEdhV1RTVjNF?=
 =?utf-8?B?QnBPLzdkQTlORkVBbDJEUEg0UVF5all4Q2grUEtpMkZHOFJFMGIrRHI5UktK?=
 =?utf-8?B?VjJQcTFFMGk5dXhKbGd1VUhaUURlU0pTNWwrOTlFd3hoaGkrYnUwZVhXbHBD?=
 =?utf-8?B?WDBKa3NidC8zdGtmSkdNRXF3b0o4T2JiU210blZEQXh5bk0xeUkwajk3d1lu?=
 =?utf-8?B?VHh0RWpzZGJFSTlxUHZTVVc4b1NnQy9HRzB6QUZhNUhSb1BJWmhOTXpEQ093?=
 =?utf-8?B?MEVVY0RLMlM5YXpxaUR4c0p6WnU3ajM1QU5vMUpiaDNzdmdRRkhka3dXV015?=
 =?utf-8?B?a3lQS3gwc3RibDE1NnlXR3ZBVHFUMEZzNURDZzlycm5hUWxGbVh6YnF5NGxJ?=
 =?utf-8?B?Q2dnUHJHZnNJNFAyL21uYmZ3WUpuL3lTZk5ocVFOMThweURNQWRZa0RrdFJU?=
 =?utf-8?B?OHVJbXM0d3pHRDJrNDFqVVpKK3MyYmk2UW8yYzdjUVNRUmVVdEUrcHUxSldD?=
 =?utf-8?B?cmhQSisyUUVTdzFrSHdNK0kwRW96VFFPY2N2aHR1MmYvbmw3Y0xObDJYTldj?=
 =?utf-8?B?V2pKV1BRSEtvNTRWMVNDSVNxV1AydGJGMmkwamZRRFliaDhSL29kZHRUTm5O?=
 =?utf-8?B?ZUtEKzkvejBvUGQ0SG85bmUyWVZrS0w3RC9FUDhUNjlmZjFIcG95ZmZQakl3?=
 =?utf-8?B?ZmRNK3ZPN0hXMG1LaktRNnlHSCs4c2EvcVVNVmVZREs2bHhkOEZRTGdSbmJn?=
 =?utf-8?B?VUFlelMvYytodEUrYXMvRlVoS29OaWJvOWk1ZWxpRkdWMCtPbEJ2KzRIOHNI?=
 =?utf-8?B?S05CRUUwTGhPd3ZJZk9uKzBxUUN3WU5hWHVtZDQyRUNTN0R1ZEhzVS9nQTZi?=
 =?utf-8?B?b0Z2Z1l0MURHMDJCSUo1OGt4V3paam81b05xTmwxU3hMNGtLcFBBSStlVFBH?=
 =?utf-8?B?RnExUDJBeC9udkVrS2RuMzBHMkc4NzRwemlVdi91bFRlWmpZYzZYUVBxamRa?=
 =?utf-8?B?MXpSM0dOSWx1RFRQNDFocDdsVk1jdzNaZTdzZjM1NDJ0MjZKRnYvVDFKSEdr?=
 =?utf-8?B?ZmhVeHlRU0xOeENFenBGQk8zejdsYTZpcVAybmQvSDdHVUViUkVFaFhpWStO?=
 =?utf-8?B?bTd0S3dmanlaUEhrVHA0ZHpLWnlHcW9HMWNJbXVVQTVCRzVnSktmQ3JOZEpR?=
 =?utf-8?B?SlZVd3dJRUV4OUpQTmk4OGtJTFB0aWdZa1RTdGdNT1UzVjM1dEQ1dkpUb2NP?=
 =?utf-8?B?ZEpUNHdES2FVanBuYzI4N05jRTFWRGJKTTVyRjRUYnVCdE41QXBFZTI2Y0tB?=
 =?utf-8?B?UkFNQW84ZE5WM3N6am55dGdNeXh4UklMRXZNQlpMNzB4anVrZDhYZXo3dHhO?=
 =?utf-8?B?V3JjTWpreDBEamU3WVlKMW5KVllYT3hFS09PVDhHSWpoYUNscWgwSVhINHN5?=
 =?utf-8?B?dkJRRjlKQ1BobTl6SVRZbGVpS2dmUmJPWXNwOHNvdE1jZUR1Vzd2VTRPTlJY?=
 =?utf-8?B?cmZJc3JqMkNHbG9iZ1pod3dTT2tidm5YT0dZVVRSY1ZHMUVGdnFzSnQvY1NQ?=
 =?utf-8?B?SWh0Szl5Nm9ndnJ6di93a3RueFB5Nm5NY2dsMjBWSlJaUHhwM0I1anZ2MWdx?=
 =?utf-8?Q?TYP9cM6BykzO+Qmpv9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c126bf66-3685-4fac-26bc-08de603a46c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 20:00:54.6606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HacbE69tGQAb5Bpzgd8Jh+U7IAi+2ef47QTdByvX+VACd4UeTkukXljdMQqlxt9o0IRV0BwrC4vcBMlh3JUktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
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



On 1/26/26 14:08, Timur Kristóf wrote:
> Slightly refactor and simplify DAC load detection.
> This prepares the code to be used for also executing DAC
> load detection on external DP bridge encoders.
> 
> DAC load detection belongs better in the hardware sequencer
> code because the implementation is HW dependent and not all
> chips support the functionality. The code is cleaner when
> link detection probably doesn't call the VBIOS directly.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../gpu/drm/amd/display/dc/bios/bios_parser.c | 25 ++++++++-----------
>   .../gpu/drm/amd/display/dc/dc_bios_types.h    |  4 +--
>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 12 +++++++++
>   .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
>   .../drm/amd/display/dc/link/link_detection.c  | 24 +++---------------
>   5 files changed, 28 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> index 9f11e6ca4051..e2b74dda00fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -782,26 +782,17 @@ static enum bp_result bios_parser_encoder_control(
>   
>   static enum bp_result bios_parser_dac_load_detection(
>   	struct dc_bios *dcb,
> -	enum engine_id engine_id,
> -	enum dal_device_type device_type,
> -	uint32_t enum_id)
> +	enum engine_id engine_id)
>   {
>   	struct bios_parser *bp = BP_FROM_DCB(dcb);
>   	struct dc_context *ctx = dcb->ctx;
>   	struct bp_load_detection_parameters bp_params = {0};
> -	enum bp_result bp_result;
> +	enum bp_result bp_result = BP_RESULT_UNSUPPORTED;
>   	uint32_t bios_0_scratch;
>   	uint32_t device_id_mask = 0;
>   
> -	bp_params.engine_id = engine_id;
> -	bp_params.device_id = get_support_mask_for_device_id(device_type, enum_id);
> -
> -	if (engine_id != ENGINE_ID_DACA &&
> -	    engine_id != ENGINE_ID_DACB)
> -		return BP_RESULT_UNSUPPORTED;
> -
> -	if (!bp->cmd_tbl.dac_load_detection)
> -		return BP_RESULT_UNSUPPORTED;
> +	bp_params.device_id = get_support_mask_for_device_id(
> +		DEVICE_TYPE_CRT, engine_id == ENGINE_ID_DACB ? 2 : 1);
>   
>   	if (bp_params.device_id == ATOM_DEVICE_CRT1_SUPPORT)
>   		device_id_mask = ATOM_S0_CRT1_MASK;
> @@ -815,7 +806,13 @@ static enum bp_result bios_parser_dac_load_detection(
>   	bios_0_scratch &= ~device_id_mask;
>   	dm_write_reg(ctx, bp->base.regs->BIOS_SCRATCH_0, bios_0_scratch);
>   
> -	bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
> +	if (engine_id == ENGINE_ID_DACA || engine_id == ENGINE_ID_DACB) {
> +		if (!bp->cmd_tbl.dac_load_detection)
> +			return BP_RESULT_UNSUPPORTED;
> +
> +		bp_params.engine_id = engine_id;
> +		bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
> +	}
>   
>   	if (bp_result != BP_RESULT_OK)
>   		return bp_result;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
> index 40d7a7d83c40..06fdde281a0c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
> @@ -99,9 +99,7 @@ struct dc_vbios_funcs {
>   		struct bp_encoder_control *cntl);
>   	enum bp_result (*dac_load_detection)(
>   		struct dc_bios *bios,
> -		enum engine_id engine_id,
> -		enum dal_device_type device_type,
> -		uint32_t enum_id);
> +		enum engine_id engine_id);
>   	enum bp_result (*transmitter_control)(
>   		struct dc_bios *bios,
>   		struct bp_transmitter_control *cntl);
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 4659e1b489ba..4e820020252b 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -674,6 +674,17 @@ dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
>   	bios->funcs->encoder_control(bios, &encoder_control);
>   }
>   
> +static bool
> +dce110_dac_load_detect(struct dc_link *link)
> +{
> +	struct dc_bios *bios = link->ctx->dc_bios;
> +	struct link_encoder *link_enc = link->link_enc;
> +	enum bp_result bp_result = BP_RESULT_FAILURE;

Nitpick - bp_result is assigned below right away so it doesn't have to 
be assigned here <-- complained by Coverity.

> +
> +	bp_result = bios->funcs->dac_load_detection(bios, link_enc->analog_engine);
> +	return bp_result == BP_RESULT_OK;
> +}
> +
>   void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
>   {
>   	enum dc_lane_count lane_count =
> @@ -3442,6 +3453,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
>   	.enable_tmds_link_output = dce110_enable_tmds_link_output,
>   	.enable_dp_link_output = dce110_enable_dp_link_output,
>   	.disable_link_output = dce110_disable_link_output,
> +	.dac_load_detect = dce110_dac_load_detect,
>   };
>   
>   static const struct hwseq_private_funcs dce110_private_funcs = {
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> index 51b0f0fd8fcd..5c9a758fde37 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> @@ -1187,6 +1187,7 @@ struct hw_sequencer_funcs {
>   	void (*disable_link_output)(struct dc_link *link,
>   			const struct link_resource *link_res,
>   			enum signal_type signal);
> +	bool (*dac_load_detect)(struct dc_link *link);
>   
>   	void (*get_dcc_en_bits)(struct dc *dc, int *dcc_en_bits);
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 578509e8d0e2..1585cce65b0e 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -932,28 +932,10 @@ static bool link_detect_ddc_probe(struct dc_link *link)
>    */
>   static bool link_detect_dac_load_detect(struct dc_link *link)
>   {
> -	struct dc_bios *bios = link->ctx->dc_bios;
> -	struct link_encoder *link_enc = link->link_enc;
> -	enum engine_id engine_id = link_enc->preferred_engine;
> -	enum dal_device_type device_type = DEVICE_TYPE_CRT;
> -	enum bp_result bp_result = BP_RESULT_UNSUPPORTED;
> -	uint32_t enum_id;
> -
> -	switch (engine_id) {
> -	case ENGINE_ID_DACB:
> -		enum_id = 2;
> -		break;
> -	case ENGINE_ID_DACA:
> -	default:
> -		engine_id = ENGINE_ID_DACA;
> -		enum_id = 1;
> -		break;
> -	}
> -
> -	if (bios->funcs->dac_load_detection)
> -		bp_result = bios->funcs->dac_load_detection(bios, engine_id, device_type, enum_id);
> +	if (!link->dc->hwss.dac_load_detect)
> +		return false;
>   
> -	return bp_result == BP_RESULT_OK;
> +	return link->dc->hwss.dac_load_detect(link);
>   }
>   
>   /*

