Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775F4E8B397
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF54C10E1BD;
	Wed,  4 Feb 2026 03:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w9yL7Tk1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1557410E1BD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhIaYpXCXgXd+29ix6RrLknaF3NAeEWSNzh9IThuI8AiytuFfM8uUqKUy7IF0F6GW/kr2zitC2s3w9PzmILjlmWNvXCN5uDFl14c7xGGuWOvNGcX2zHzsERV7/ebKh6/4n9bMywAE6GFFgBW+EOyLCatMbpRq12iT6DCHLp1aDuOQGX4fc3/Ux8IKUaRN3H9bgkgKhb23X/FGuVdzSZzfMoQUqJaPCgUw68EH+UXLJIvFpZ8z43fwJCQBw7ZvzjllrC8Yp04e0uML7oSzILUnDu1VjuJ0abKbA3R6H8nnfCns/XnM9X+ftvbkGAMJzUIwCfo1VodhbbGzlPPO6CjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4fzzbmhrFUzyDiXGW5Qz1cFts/zGDKYs3QPF7skOW8=;
 b=kSklQBkqb1SDJenIXTwOs7xVq6tFlhy0Rx+b14RchdLnzrz13YfEKLKDLEkc5f3fejIgPJQ25Igb/ZwxX44qwCJ3WV98AI7L/SshoszHHWvnMm2wgIhJKdB7k6RqwJebEIbrprqcZ9zC4OJLFOq8msxniwgfWLdYLqP97xTBcKAskUSwApZYXc54/7swUh7RQ7mTCOZdkwC49Ei1/J059Ey9KIvLUFJiSMxG9yeimMXbAlhOwHX5FvBTdga1bpWPOGAeKOuDDIrc2HbBfkcJaGnLhnVGiccAr4O72K17UUAjq713I/2W34zqYCrpu1f6qTU7C4iPLN+zUUkph9/hRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4fzzbmhrFUzyDiXGW5Qz1cFts/zGDKYs3QPF7skOW8=;
 b=w9yL7Tk1yeHM9U7BTojmvjvWBbr3JwgUbX2Pninp/jrt34J4Vy05oq3h9goS0zjkVIFww4vS0YAuY8lkFaUuKhCyaPrrVY5mEHejPqZV7aqVuDjeEsyC8teWiIXyhx/GE3pSbhpUGPvChbJq2/JDO/k/PZqTyewLagGGv5fBZ44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:38:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 03:38:31 +0000
Message-ID: <2aee7c0e-3c1c-405e-8968-752bb56aaf28@amd.com>
Date: Wed, 4 Feb 2026 09:08:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] drm/amd/swsmu: Add support for multi param send/read
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
 <20260204030621.33369-3-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260204030621.33369-3-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 715b965d-cd72-4c37-741a-08de639eddee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE5OU3NWdkVYUFNUTzNWWjcvUmpNbjI2c2paNFNkTy9rWHgxRXFwamVVZnlk?=
 =?utf-8?B?dWkxVnRESTZPTGdFNjZ0c1NoeStRaUVVeldxNHF4SVFOT2wrMVIxWjArV01E?=
 =?utf-8?B?Z0FZSDB6N3F5cVVOQWo2VC9DdS9EcisweHRiOHdqZ0tLWUtoOW4zMGQxRlYr?=
 =?utf-8?B?dHoreDI0T3lUSTdwOHJtZENod1FmaUZNUlFnQ0pGWWxVcXl0WXh2VVB5czB6?=
 =?utf-8?B?c2VKd2FEUmxwbitNZGJ2dmVvRGczYmlRV0szb0lCQmRQWFRFWHlIanpSSU8w?=
 =?utf-8?B?UW9kbUg2UzNmTGpiemszTExhaHNrci82d0FjYWlldCtRalgzYVRsTUxJL0xk?=
 =?utf-8?B?ZkdFc2R5UXJvRVNtZmJ3Y3hZalF4aUFIVDlEN1JsVjdUUTZBNkhPbFBFRnVH?=
 =?utf-8?B?VGJYS29VQzFRNDVVcElsRlFNNWdSZlhVdGRuZmEzMENUOVhnS216TjNOejl5?=
 =?utf-8?B?ZTVPNUo2bVF5cmhmOE1HOC9LNjhFeG9HZXNrczZtVmR5QVdSTXZuNTd6R0Rv?=
 =?utf-8?B?Tyt2U2prNkZ2NFdzTkZKWlIrRldEeG1PeCt0REUyYTVvMHc3ekphb1NEZXZS?=
 =?utf-8?B?K2VMYlhESDY1aHVUKzJiRXpvRVlUWjhpRmRBc1djeDF1MTVzVHFTSVpqS2xp?=
 =?utf-8?B?SkZjYkJGTWdlRTZsOFpOMk1MYllTdW00YW5KOFNQYkFmYk9BcXluaUtzR3hl?=
 =?utf-8?B?TGJqN0VTRE5pYmFwY0k1TGtFREpYTHpMYUdrT25ZdlZaTm96WXowNlFIWUhW?=
 =?utf-8?B?VUEzQlFZM0hwUWZCbVorRDdqZUdpeWFaS3hTSjJ2R2hpZDYvL2djUFUyMnZj?=
 =?utf-8?B?ZW4xTlprNXlLckdYRWduWHNHdGczYkFxelg1azF5NVZzSCtTalFBdEpVNGdI?=
 =?utf-8?B?Ty8vK2RjY3B5Z296aHdCYjZBN050QzYzM09hTExkOFZjeGh6TjE3VUtUUUdh?=
 =?utf-8?B?Mk92aVRBMldTRlBiZFdyU25wQUw3U1VnUjRueHFYMGcraVpLOW1rSEx1aUhR?=
 =?utf-8?B?MmdaY3E0Z2luZjN1a2JjT3BFd0dheVRGcHBrTXNGT2NnaU1YTVpxQU1aU0Jj?=
 =?utf-8?B?T2hvaGJGQUFDTDNHSkpxN21JSXNkOWU2ZXVxZlo1Q1RLak00SGNOc2M3R3hV?=
 =?utf-8?B?N2RwMlgzaVR0Nm9KS2k3TDRiNkZmanZhRmlTZ2h1RVcrRWFBNWl3L2dyRWxK?=
 =?utf-8?B?b2g4ZUFDMW1MRFpHOHh6bCtQckVWa3JFL1VMTit3OUJPMjQ3eE5vWlQ2YXkv?=
 =?utf-8?B?b1QwbEVTdklCSmxsRnFaNlZCZ1pBV0Z3YW5YdVBOMHo0WE5HYytjUGlkRldE?=
 =?utf-8?B?TUZZd253dW53MUwyTW02SzN5N3JQb0dxcEFyWEVSZ1M4MmxCV2NZTVFEL3ll?=
 =?utf-8?B?L3dqSkFJTWs2SEY4TjZQbG1RM3RRWnFtWmp3M2dUL3NQM0NYVmhSdEhCZ3lU?=
 =?utf-8?B?TXdqSFdaWXAwZUlJM21PYVRYNHl0cTVPaWNFM3MvdWRGQXVEVDBUWmU3V0xt?=
 =?utf-8?B?TjlRL244eFZIRWRBSWxjeFREeCtMTjRYdVVmLy9wWlRrUFhQTzIwMlA3clVV?=
 =?utf-8?B?eHRBOGIyN3Bock1PQmRwbGk2UXZJdkwrSnMybzlBUnpSYlVmWDk4TU8xOE9J?=
 =?utf-8?B?a2dIRHhVNmRkOUt2SEZYMGNmZjJlUyttUnVhM2F6L3c0WGlxVUJaQURkRm9P?=
 =?utf-8?B?M1gyc0YzYlFldFFueUVHWkx6R0hNSFF2Ujh5RjJFclc5Yy9Zb1BKQXZlMFd5?=
 =?utf-8?B?V3UxTkR5bXBuaTlHdUpqT3g2Y3hOYk5tUXFuWDlqVndlUUlqbkw4bGV2UXhZ?=
 =?utf-8?B?VXcrQUZHSWhrd2pueTFYeENJRkRUbkxlQ3ZiMU5IY3ZzVHg5cWU2aHFCTmZz?=
 =?utf-8?B?cm5ta1N0ZXFzc05NMlVnOFYrUGlsT0dxSDljTTZhV2c0dGVLb0F0MGlvbVVz?=
 =?utf-8?B?RTJ1TDdGQ3NxMEZyQVZoSDBQVjYxUU1oeW5mcFByR0NOUWthRldlWDhRTGlP?=
 =?utf-8?B?RjNDUzd0RThMcjZENC9QTjZkZmJxVTFPcXI3dWttQ1d3QnlxUUpxdE5BUHcy?=
 =?utf-8?B?dUZLZk9PZEFGTFFJMnZMenpQYk0zb1ZxUDdEZEZXVStKV3lGUUhXYUhKSHRo?=
 =?utf-8?Q?VdmI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVM2a1FXcEFkWTdud2pLczJXdjJRMGdFUElsL0RXWjVYdHdoR285Yi9iMGdQ?=
 =?utf-8?B?NjhlUGtUejNsQnZmdVd1SUZwZnRSd095NWN6SnVKYXozSlVHdDk4ZkFoS21z?=
 =?utf-8?B?Q1NPNHEzM09PSFhTb05NaVNDeU9BU3RiNVhTYkozTGI3SmtSdHVZejBnYVFz?=
 =?utf-8?B?YjR1QmlnU2syMTM1Nll6OWZyZElWNjVrdDRERmVmaFBjYkJ5NGdFYWNKbm9I?=
 =?utf-8?B?V3E5NEVxNWszd01kZzFmb254RGZxR0w0YTlKZ0JyUWdqQ3M3YWhnVlkwbzlS?=
 =?utf-8?B?Smw2Vm5sWGdSdm1yNnA1bDBzMDlPdlViWjl6S1YwUS9JdVVkenRXMExYdVVq?=
 =?utf-8?B?YUJ6dW12MTdySktmU1J1bjNJN0I1djNZaGtodEhyYmhnZXp5MHlIQm1BMjQv?=
 =?utf-8?B?TGlSTFdubENkd1RkaUdWNDBLTEdqQVpzSnI4eXRtUlVyUmpyY3NjblV2SjFG?=
 =?utf-8?B?T3VOSDExQXp6UWsvSFd2MGhmVDNkMzhzOTBORDNCMlZ5SWs3SUR1Z0svSlRx?=
 =?utf-8?B?VW9scy81L1BxaFpuRTRRdG1SUVNOM1JzSk9WK3VPQU05dVdweE04UGVwM0x2?=
 =?utf-8?B?MW9YdzJEbVFZL2JQV3d3R1d4NUlGd0J4NzN2MVdlN0R3ZDZMeXNPUWtVSXh4?=
 =?utf-8?B?WUZ2MWwwWlU4VEVodVJLdFJMN0NzMHVRdko3U2k3M3I3R1MrSTNBenFkMjJP?=
 =?utf-8?B?N0I0K1ljQWgxU05BYnVVZEZOWkd2N3dTcjZtV3E0UC9nd2pJV0Y1QmI5YUVi?=
 =?utf-8?B?Ukp6dWczbDVMZENRNkd3cU5IdzFQTFZvWk9rSjNWZVY4amJUN1FLWnZWN05p?=
 =?utf-8?B?MWcwYVpUTmV1dFZTWFY2UmFlNU94SnE1WWlKRVJOelJpbTNMZkJZRG5OaGFP?=
 =?utf-8?B?SUpQZGJSdWlydXk4YWx1alFNNytmd0hMMjFGdG9rYWxKSThCNnl4Z2t1Q1dU?=
 =?utf-8?B?ZXhYMTFNL25JOTEvYnI0bFN4bzg2MFo1ZzhqNjBsb2gyWkthZ2F6QmNyVXFP?=
 =?utf-8?B?T3R5ZG9mVDZsWHo4dlpWZG9KTjI2bmdRc0RHakdha1NKcGdMYmtqOW9LanZ1?=
 =?utf-8?B?MGE0VVlYQXp4SHRiYloyZ1BZdkhzU011d2lBNHBoQUoyN3pRR1YzNUhVVE1Y?=
 =?utf-8?B?Uml5bTZqNjM4S1YrTVZmQjJVQ3JEaUxWSm5PazQxVW9lMzZvN3h5OW85OEVF?=
 =?utf-8?B?WWxWbEU5ZjdqY1Q4SSt6bGJUU251dUd0QWZKSzYybEx2UnF4OHhtSDgvVEVI?=
 =?utf-8?B?bU1wdzJha3pCSnlkMnF4SzJHNlZYVE0zWFVHaHBtQVlkMWE0WmZzWUQ4OFpR?=
 =?utf-8?B?Rm1RZnRqWkdSc2podVlCZjAwNHNtRzJmaWhaeUZkSVY0YWJReHg4SUFjRDNZ?=
 =?utf-8?B?bis0SCs0cHJCcmVXOEdYMjhWRVNwcWtVdXVzRDJTNFdyeFZZRldzeStMUngy?=
 =?utf-8?B?OUsraFhKZ1ZCRGk5NHNTemxPWFVpZUcxdzJFY0lFcmFwYmVVcDVCMm1tM1Qy?=
 =?utf-8?B?NFo0ZXZoQWNDSk00TUNvbDZWZWQ4LzJTMFFYNHQwMWpNYUswbTVHcFZkWUpB?=
 =?utf-8?B?Sm1MaElZb2R5RmwvMUpreGlHUTkrYWJFTmlMMlU2Si8zK0ZDenBjcW03cWJ4?=
 =?utf-8?B?TW95bG4za1BPOUpKL2RoWWZzUDhFNVlBU0JkRURGc3ZjN3NVL2JUQkMwTk9D?=
 =?utf-8?B?c3dhMzFpdDVJREhYb0pKYWg3eElOU2JyVDZpS2t4ZDVtcHBJNHRSbkExTDlw?=
 =?utf-8?B?OFR6S0IweTJCQ2wxKytBV25zR09pUlZvbkp0REZpVUswdzNQOVpTNGN3Tktn?=
 =?utf-8?B?aTdhcVNaR0xmcGh0dFI0Rk1rcDVLeTdUbUV6TmYzeHVQdk9LMlJGOXRoS2xv?=
 =?utf-8?B?T3dvNmZDck1LQVlRZHBEdnpLYTVWakgxQ3NGNEVJT01HMXdBc2w3eG9DTTAz?=
 =?utf-8?B?eTJsb3hqYjd5M1lVTkVnRndpQnBKSjNYMThWaFYyRUU5Rzg1bUNCS2Nkd1V1?=
 =?utf-8?B?b2RWcWRYWVNtRVc4M25sa1ZqbE9ZVHlad3l4ZkkyR2VteituSXVRblRZUUpi?=
 =?utf-8?B?cGVhNzJWOWlxbU1kYkc5Sk9lTFdvZThib2lRbmlNWjVXSXJIVGh4OHRGYjk0?=
 =?utf-8?B?SWptTFNHNTd2cDBjUzIvZFh5aS9STnhIS0p5Nlk0d3NST0JXZ2tteHdqaG10?=
 =?utf-8?B?bkY4KzA2WmNQNFJ2elRjTHgvT1hyanZNVHF3bFNtNERpbjg3L1NsVjRJM1p0?=
 =?utf-8?B?emhRZTlCTUtueVM1WUIzMjlUUnJHMGtBWnczZ1lNckMxMnJWYUVKVC9xR2ZL?=
 =?utf-8?B?YmpvdlBFWks3TjllVTdLUytHMDk2cW8wM3phMDlHbXp3d3p2UExyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715b965d-cd72-4c37-741a-08de639eddee
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:38:31.6342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1HCiTDmU6gkzP+CjJ/UamohBUWY0hlpDbCOunagRvz513a6ea6vUPKOnPrVWos8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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



On 04-Feb-26 8:36 AM, Pratik Vishwakarma wrote:
> Add new functions for sending multi param send msg
> and read response
> 

With msg_ctl, the intention is for the respective IP versions to use 
msg_ctl directly. We don't need another layer of interface wrappers. The 
existing smu_cmn_* message wrappers are retained only for compatibility.

Thanks,
Lijo

> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 91 ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 10 +++
>   2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 6fd50c2fd20e..d5823f475596 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -183,6 +183,68 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   	return ret;
>   }
>   
> +/**
> + * smu_cmn_send_smc_msg_with_multi_param -- send a message with parameter
> + * @smu: pointer to an SMU context
> + * @msg: message to send
> + * @param: parameter arr to send to the SMU
> + * @read_arg: pointer to u32 arr to return a value from the SMU back
> + *            to the caller
> + * @num_args: number of param arguments
> + * @num_out_args: number of read_arg
> + *
> + * Send the message @msg with parameter @param to the SMU, wait for
> + * completion of the command, and return back a value from the SMU in
> + * @read_arg pointer.
> + *
> + * Return 0 on success, -errno when a problem is encountered sending
> + * message or receiving reply. If there is a PCI bus recovery or
> + * the destination is a virtual GPU which does not allow this message
> + * type, the message is simply dropped and success is also returned.
> + * See smu_msg_v1_decode_response() for details of the -errno.
> + *
> + * If we weren't able to send the message to the SMU, we also print
> + * the error to the standard log.
> + *
> + * Command completion status is printed only if the -errno is
> + * -EREMOTEIO, indicating that the SMU returned back an
> + * undefined/unknown/unspecified result. All other cases are
> + * well-defined, not printed, but instead given back to the client to
> + * decide what further to do.
> + *
> + * The return value, @read_arg is read back regardless, to give back
> + * more information to the client, which on error would most likely be
> + * @param, but we can't assume that. This also eliminates more
> + * conditionals.
> + */
> +int smu_cmn_send_smc_msg_with_multi_param(struct smu_context *smu,
> +				    enum smu_message_type msg,
> +				    uint32_t *param,
> +				    uint32_t *read_arg,
> +				    uint32_t num_args,
> +				    uint32_t num_out_args)
> +{
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +	struct smu_msg_args args = {
> +		.msg = msg,
> +		.args = param,
> +		.num_args = num_args,
> +		.num_out_args = read_arg ? num_out_args : 0,
> +		.flags = 0,
> +		.timeout = 0,
> +	};
> +	int ret;
> +	int i;
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (read_arg)
> +		for (i = 0; i < args.num_out_args; i++)
> +			read_arg[i] = args.out_args[i];
> +
> +	return ret;
> +}
> +
>   int smu_cmn_send_smc_msg(struct smu_context *smu,
>   			 enum smu_message_type msg,
>   			 uint32_t *read_arg)
> @@ -591,6 +653,35 @@ int smu_msg_send_async_locked(struct smu_msg_ctl *ctl,
>   	return ctl->ops->send_msg(ctl, &args);
>   }
>   
> +/**
> + * smu_msg_send_async_locked_multi_param - Send message asynchronously, caller holds lock
> + * @ctl: Message control block
> + * @msg: Message type
> + * @param: Message parameter array of len ctl->config.num_arg_regs
> + * @num_args: Number of write message parameters
> + * @num_out_args: Number of read message parameters
> + *
> + * Send an SMU message without waiting for response. Caller must hold ctl->lock
> + * and call smu_msg_wait_response() later to get the result.
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +int smu_msg_send_async_locked_multi_param(struct smu_msg_ctl *ctl,
> +			      enum smu_message_type msg, u32 param[],
> +			      u32 num_args, u32 num_out_args)
> +{
> +	struct smu_msg_args args = {
> +		.msg = msg,
> +		.args[0] = param,
> +		.num_args = num_args,
> +		.num_out_args = num_out_args,
> +		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,
> +		.timeout = 0,
> +	};
> +
> +	return ctl->ops->send_msg(ctl, &args);
> +}
> +
>   int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>   				   enum smu_cmn2asic_mapping_type type,
>   				   uint32_t index)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index b7bfddc65fb2..839dd03021ae 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -30,6 +30,9 @@ extern const struct smu_msg_ops smu_msg_v1_ops;
>   int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us);
>   int smu_msg_send_async_locked(struct smu_msg_ctl *ctl,
>   			      enum smu_message_type msg, u32 param);
> +int smu_msg_send_async_locked_multi_param(struct smu_msg_ctl *ctl,
> +			      enum smu_message_type msg, u32 param[],
> +			      u32 num_args, u32 num_out_args);
>   
>   #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
>   
> @@ -115,6 +118,13 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   				    uint32_t param,
>   				    uint32_t *read_arg);
>   
> +int smu_cmn_send_smc_msg_with_multi_param(struct smu_context *smu,
> +				    enum smu_message_type msg,
> +				    uint32_t *param,
> +				    uint32_t *read_arg,
> +				    uint32_t num_args,
> +				    uint32_t num_out_args);
> +
>   int smu_cmn_send_smc_msg(struct smu_context *smu,
>   			 enum smu_message_type msg,
>   			 uint32_t *read_arg);

