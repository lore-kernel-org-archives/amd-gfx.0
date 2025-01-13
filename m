Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FB5C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 21:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E5410E03A;
	Mon, 13 Jan 2025 21:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tzhLvjl0";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F0010E1AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 21:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELfGcsqWYhLD9tUzzg6UD3MKG4CrMmSAAUtWp75MRyhPTH0D1rhQ0yVP+j5hRGbWRZKqNCNdsa0LDtAUEqC1RQw9cHpKaB7B/fysQDl0azG8EuBqyFOnmNkP4Lf5LnnlBvgx6DytSPgXolPWXBBKgx0MPtUGnNI85csGi6MhRaLgdZxx3rsvCWEI4qgG9UD5DGlIuID+U+Xw4EVKWo4iruMyxK+N/vyXAMrFSFnucZRIPFewYEx9sU/nfRw6sailhpLOyTZp0onIWCcbeln9gJu6rcLq7/KFJAGjkPjmbjl1rGs7k40rykbvVg7V/5PxkYa0EzQqtHZDMMLmTJULxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKOddzROv6WT1pLwQggTSfUHxWd9Nt+5jnD+q4JxYag=;
 b=VRHHN8FXi/Ddh23TD7++8eLeOF52drfjVErjFcAvGf8mKYrTt+L1wF09IYsWZDVvc4MJGNrDFCkmb4IuH6P19e2oCmz+OZAOPKJ7TfCFsXlDVV7W9ONEhR/ISjPY8IaNX88gIcolGn/04Aww5eHnnhuPYEQfWbAld8g/MpaIO5/gHXUXjYIVXvVBA2r8xCc+uQHvT7yrFSX5LovXcz1Nocdl+urRtbVAM/cVPY5t7Fr8T1aGLID1XXHgdUxDsuXAYEsHne0wRPFW5jnttLoxbvcMfzEX702wk/47Q+7vbJrmg33rgYsFgiwHtb7q6okK094ydrbXraq+/xaW3FM0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKOddzROv6WT1pLwQggTSfUHxWd9Nt+5jnD+q4JxYag=;
 b=tzhLvjl0kPX3hkVgSe4IAsEBWMXjxwzfzJlX4+Y9XlbLK/mkumbHb1tkJb4ZaKPljdhXkdw2ZmCnIZJu2Q/bkMR4DOyALXTBt632ZUpSSsUyyyVgLAbg3UFF5hjVmURHkQKL3IdXxaKNlQYa9cMSF3fIk7Jx39/aeHnzKN9LRy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 21:59:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 21:59:18 +0000
Message-ID: <3e429518-d36e-42ff-a876-c9217a180f51@amd.com>
Date: Mon, 13 Jan 2025 15:59:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 "Lazar, Lijo" <lijo.lazar@amd.com>, Hawking.Zhang@amd.com,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, Kent.Russell@amd.com,
 Shuo Liu <shuox.liu@linux.alibaba.com>, amd-gfx@lists.freedesktop.org
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <37c31a32-c5fb-4a5b-8aad-448997f94cda@amd.com>
 <A6A619E6-08E4-4A60-951B-26F2BF4F93E4@linux.alibaba.com>
 <512c6943-57a7-4cc5-98cc-5400a5113b58@amd.com>
 <883EFB5E-1140-4757-969B-C2A8E4842E22@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <883EFB5E-1140-4757-969B-C2A8E4842E22@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:806:24::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ea89fe-2bd3-4fc9-bc2f-08dd341d8711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXNsT0wzZ01tVGdudC9zWVlISFIwL1MrMzNRNUFlQTFqay9TK0ZQNmhmMlhh?=
 =?utf-8?B?Y1lqay9WSlRFczMzWW5qL2hmUlY0a3BmbDdWWmpjSUxnQStGWlNjYjlYb2dy?=
 =?utf-8?B?enJ1NHFPRngwcUlJRjMxaFYyc05sM0tCUXUxc1BBNlVhREJpb05Zd3lNbHYz?=
 =?utf-8?B?RU9CSkhLcGRkUGhBU0d3eWx3REkwaDI2K0hHTjBLSG51RG9QSS8xOGIxYkli?=
 =?utf-8?B?dU1HNlAyNHhIdEpkZFh4blU1Rks2VzZSNml2dTFEdHZNY3NGUmJEUmtuK2Qw?=
 =?utf-8?B?cVBFd2JaYjVIUE1wanFpZXpkb3QyRXR3U05sZXFYbUpwUGw1YVdxWDhERTBT?=
 =?utf-8?B?NDArUnU1OHgxT1Jma0Rha2JsMGpTTU02YUVzZmhWc3ZjTHFRb09ySHlLQ0Z5?=
 =?utf-8?B?ckw5akJRSmVGNFlnSHlhZGVxcHIzSDVvOU5sbk1QV2x6MEZWK0FPSm9XQmI2?=
 =?utf-8?B?NlcxTmk4QUlyUjNyM2ZUVXRvb29vbS94Y2NEeTNZS0tPN0hTUHpGcU0rY2Vj?=
 =?utf-8?B?YUh5eDdPQmdNcFQ0OXRLSE1ibzBqR3RDYkdqWlJjM2Uza25MVHpnVzJSOGJQ?=
 =?utf-8?B?eTRiUWMrWngzKzBKTFVhRUI4UkRCWUh5cG9qcU9ZME9wOFFKUjRwblIrR2hP?=
 =?utf-8?B?NGNmOGZ3Vm1NZkl4WWxNbDFTUTNFN291SE1OZXM4RE0zNitKeFF5UTI2QzNY?=
 =?utf-8?B?QVpOckIyOEdiNTlSeUNGTU1vTjVYa1dDYk1TdzJtajdhUTh5VnNTdHFrL2hx?=
 =?utf-8?B?SjVRSHFIclFDNmNtSlNEZlI2bFdaZXlKeUplRXcxQkZjSDdwSkowdW1UZm5i?=
 =?utf-8?B?d2NmNk54dXFtWHIwU0FPblA5eTJzUStNMlYwamlKNERxOGlySjI4SDFORG5k?=
 =?utf-8?B?STlzaEVUUzlxSSt6RlIzc1ZObXlWcksxR3p2ZUZzWm45K0V0RlFFaFpRdFFi?=
 =?utf-8?B?czlCSDJLUGVVTkdKb3dtM091RmozV0dNODFIVlNNS0hjclVpY1YzSktRZVpJ?=
 =?utf-8?B?clhzd0N5cFBQK05pN0JWQkZhSWdkZkJKc0VCdjlYWVNEU045MDNjWXFKK1Mx?=
 =?utf-8?B?UE9iZHZHeEJiTms4VjNjdG1mTCtkdHE4cGpwMW1MQUxrT3hsUGljTE9zMXVv?=
 =?utf-8?B?SC9uUTQvN3VlZmloZE9qYVNhOGlWRUMvazRCMU9sQnk3dWRLbHdiQUl5Vytx?=
 =?utf-8?B?N3k3enRaa3lRNG1Da2tXUjRDQjhTZXlLRGRUUGVrRSt4U1ZsS2NtZUlvRHVo?=
 =?utf-8?B?NHRINlBZa2FKSkdEWTZybUVsMDJ5NWI4NDdJREFSemRneTZ4SEVzNnZoVi8r?=
 =?utf-8?B?ZGVueXJNWkFQdFZGUG9NNFFVNnU3MDdLUkdwdG9xZ3R1K0NMUHZkZlgrSWxH?=
 =?utf-8?B?ZE1tZkRjVjF2ZjJSb0c3MGpLeGh0Um51cHJlV3AvbEFnOWk4WDcrajlCRGti?=
 =?utf-8?B?ekY2TVVwR3JQUnpNS0JHVTgySzlCRnlxWDVLdG9MbXdNQmpvZTB2Y2hLOW5G?=
 =?utf-8?B?SGdCdWI3R0JWUnV0Mjkxem1LZ2luam02V3d0d0srU1BOV1R4eGFPTUlNek12?=
 =?utf-8?B?M1o3dWF5WllMaHlGekJ1YWt3Z1JhcEdFWkhoWlAxVUlUbXIyZXFEczFITmJI?=
 =?utf-8?B?VW9McmpGc0pGU3dGWUFMdkx4M1AwYkVmV1hhUEhoOEN0dmJZWldoemtEQ1RK?=
 =?utf-8?B?dk5wbUZOcnRQVURDZmVpRndYZWFTaGJQMFFTSDBvYUNxRnpsMU9GR1E1cytz?=
 =?utf-8?B?UWsrdmh6SitMa1JMaFlQOGxFTDNETFB2aFlLZWI3WVhib0VmZlExU2VzTlJj?=
 =?utf-8?B?cVkzZTNqdVJmSGhBeEtBQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3FzSnBKb09PRjdmaU5uK3JOZjhNK2VrOWZUZHpSVnhtWUQwSjNoMWZQUDN0?=
 =?utf-8?B?SlFUSzh2N2R6RDc3STJ0NmxiejkxRFpWOEg4UUhWbit4UWtVT09RdDVSbDB2?=
 =?utf-8?B?RVlOQzVsQm5mTlM0Mmk5ZXZJckVCWlY0RjYrUk9GTU5FQ2FEMy9VbFRTRUZI?=
 =?utf-8?B?RUJvWHZONXVDdnp4NkZqOGFQTnIvN2NDdlJhend5cDM1TllLVkxGUXhJU3F4?=
 =?utf-8?B?bmtGREQxVURhalpkQ3JoR1hLZU1tREZIRkRQdnJnM0VnYVRWQkh5dWpjN1g5?=
 =?utf-8?B?NXVjd1E4clRFZndPSlRsZzhzS1Q2U0lkNUFFa0crQ01ZUXllNTlnZ2xseUJm?=
 =?utf-8?B?ZmJ6U3NvaVhmY3krMnI0dnRBeUh2ZTBLRFB2V2FQeVp0VFZKeVovL2JBOFNS?=
 =?utf-8?B?TFhGWnZlTHNzOHlPdHAvKzRkSjFaSklYMXlRelg0czRRaUpKVkF4WExCZXc1?=
 =?utf-8?B?UWRUSGE1RWdRNDBxK3ZlQUd3L1p5U0pnalVic2pHTGk2VUlqR2JQdEVkTlJW?=
 =?utf-8?B?bVZxeFRDa3JvcERacWdYTmpsM2pQWWQrWVpSb0lJU29uWnJ5YUpnenFpMURY?=
 =?utf-8?B?a3BTU01ZZm1KV1hRdXdNVmJvSW9waXBSNVFqTWZ4dFF1OVlYbytGZzJZK2Mr?=
 =?utf-8?B?dXoyREpNLzRYRHdHcUcwYjBUenEwWk04b0dYTXdWaE1RajkxSkplSGcwaHBO?=
 =?utf-8?B?ZmRqdlV3TnNlcXBSTUp3VldDTExkdEw0YUV3NXduMVc4TlFVUXpwUGlJSWQv?=
 =?utf-8?B?akNFeXcxSkd4dlppNDFySFB6VWEveGxraTVjNFRQMXVuOHlERWFnYVBMQk5P?=
 =?utf-8?B?NWMzK3p0cXQ2UENHWGtFZWNkOStnUzJXY0xJK2ptNXZKbGNOSm55aUMyTCtV?=
 =?utf-8?B?cjlwdmc3dEZZenpCblJTN0NyenJOYVc2SUhzM0Fna3JnUENzcUFHQllqVDZ0?=
 =?utf-8?B?OEJMRWJtaE9aSGVXU1djdGRUYkpKWjl3aERqdFhTaUM3eWpoOE1CMnJhV1lu?=
 =?utf-8?B?WFZ6QkU5RUZCMUQzREs0dlpaZHhUdWdCR1BwOXBiS0xXRHRPNEcrZmVXV3pp?=
 =?utf-8?B?bzhlZGNlL2o3Rno1OWZYTzdzM2dPYjBDa040aGdXRnpkK3Y4dnV2d05SbW5j?=
 =?utf-8?B?OFdDQkVYeklGSHZueW0rRHNDL3FEM0VxMkxnWVhtb0MzS2NDL2Z0bmprdE9k?=
 =?utf-8?B?aElrWnV0NjlzYnZ6eXVObE1HMkZBbjFvWVB6bVBldWo0WU5jM3RIYm16SC95?=
 =?utf-8?B?aWRqckdSNldPcEdkM1ZIbERlZ3hVYWhxR1hoMFgyTlBqU1N6Q255dEE4eEpo?=
 =?utf-8?B?ZmRaVG1SeHZjZENGTkRaazRUTDZvWDdNWXYyWXpXcDlnSXFhTC9EYVEyNXUv?=
 =?utf-8?B?NU0yaUt5eHZyMVBzdm96OU5rWHhla01NWkx2ckZIbGxtUlJTMWZPb2VTdVdp?=
 =?utf-8?B?aFg1N1d2OXFaSDh3c0ZQSXhTdXVyeTF6ckpmNWJUZkNGcXlDS1NYeHo1ZFFF?=
 =?utf-8?B?NlorUzE2cjVNc0dKTXZzYzNsT0Y5Z09DbU55c2xDV05xQnkwcEhWazBNaDFt?=
 =?utf-8?B?TGxEcjZ3VHA5aXpUdlV1K1dYSTJjTWJOQ3R5dEtPbERHWlVtUDF2ZWFjODIr?=
 =?utf-8?B?c3I1d3Y3RmhEQjMwTGw0K1JsUFl2ak95WGMxN0FoMFJhQlBYcURhWC9keFlN?=
 =?utf-8?B?MWJCcFM3VFRLLzFJMDc2WC9GOU1MZ1dpanFWWGpPQU0vTFJvSFNtU1pFTmZQ?=
 =?utf-8?B?dUxIWVZQeVVISUlpaE5VRzhVTmgyWUJvRzlZZkNPL0N6cTNoc2RTN3NxVldW?=
 =?utf-8?B?UWIxQXp0ektWT1RpYlhXNG5DZ2hTUjhQWi8yOUdWczNMcWVVL0MwQWhmTGUx?=
 =?utf-8?B?U2VkeTF4WWVXVUN1UHVSa1pRbzVpSWxUYzBUd1kydTkzZFR3dVpLV1dGb29U?=
 =?utf-8?B?SFV2KzUyTTJBbTNYSU9HS3BVZ2hzV2o1WTVrSzVUazF0WGNkdllGNFlUTzQ3?=
 =?utf-8?B?Q05oOGQ4Q1FTVzNGYmUzblBqVHloMFZIU3ZIanRPZTA2UlBuVk92N0FPS3Rr?=
 =?utf-8?B?RGhNbEg5QU04VHpjcG9nMnhtclkyMWxBeHRvUTY1SVYwNzcrYUdTRzcvSmZo?=
 =?utf-8?Q?J1krZPXCea2DOi/NPfA4xawZh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ea89fe-2bd3-4fc9-bc2f-08dd341d8711
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 21:59:18.2773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v37ynvKm/2XejRrgb/Hsz+Ds+hUTUcnPCLia2mjsNZ+EsF3OQFhsMdtWsvRrq8nyiOratnRs736J8+1DWn1LYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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

On 1/12/2025 19:19, Gerry Liu wrote:
> 
> 
>> 2025年1月10日 01:10，Mario Limonciello <mario.limonciello@amd.com> 写道：
>>
>> General note - don't use HTML for mailing list communication.
>>
>> I'm not sure if Apple Mail lets you switch this around.
>>
>> If not, you might try using Thunderbird instead.  You can pick to reply in plain text or HTML by holding shift when you hit "reply all"
>>
>> For my reply I'll convert my reply to plain text, please see inline below.
>>
>> On 1/8/2025 23:34, Gerry Liu wrote:
>>>> 2025年1月9日 00:33，Mario Limonciello <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> 写道：
>>>>
>>>> On 1/8/2025 07:59, Jiang Liu wrote:
>>>>> Subject: [RFC PATCH 00/13] Enhance device state machine to better support suspend/resume
>>>>
>>>> I'm not sure how this happened, but your subject didn't end up in the subject of the thread on patch 0 so the thread just looks like an unsubjected thread.
>>> Maybe it’s caused by one extra blank line at the header.
>>
>> Yeah that might be it.  Hopefully it doesn't happen on v2.
>>
>>>>
>>>>> Recently we were testing suspend/resume functionality with AMD GPUs,
>>>>> we have encountered several resource tracking related bugs, such as
>>>>> double buffer free, use after free and unbalanced irq reference count.
>>>>
>>>> Can you share more aobut how you were hitting these issues?  Are they specific to S3 or to s2idle flows?  dGPU or APU?
>>>> Are they only with SRIOV?
>>>>
>>>> Is there anything to do with the host influencing the failures to happen, or are you contriving the failures to find the bugs?
>>>>
>>>> I know we've had some reports about resource tracking warnings on the reset flows, but I haven't heard much about suspend/resume.
>>> We are investigating to develop some advanced product features based on amdgpu suspend/resume.
>>> So we started by tested the suspend/resume functionality of AMD 308x GPUs with the following simple script:
>>> ```
>>> echoplatform >/sys/power/pm_test
>>> i=0
>>> while true; do
>>> echomem >/sys/power/state
>>> leti=i+1
>>> echo$i
>>> sleep1
>>> done
>>> ```
>>> It succeeds with the first and second iteration but always fails on following iterations on a bare metal servers with eight MI308X GPUs.
>>
>> Can you share more about this server?  Does it support suspend to ram or a hardware backed suspend to idle?  If you don't know, you can check like this:
>>
>> ❯ cat /sys/power/mem_sleep
>> s2idle [deep]
> # cat /sys/power/mem_sleep
> [s2idle]
> 
>>
>> If it's suspend to idle, what does the FACP indicate?  You can do this check to find out if you don't know.
>>
>> ❯ sudo cp /sys/firmware/acpi/tables/FACP /tmp
>> ❯ sudo iasl -d /tmp/FACP
>> ❯ grep "idle" -i /tmp/FACP.dsl
>>                       Low Power S0 Idle (V5) : 0
>>
> With acpidump and `iasl -d facp.data`, we got:
> [070h 0112   4]        Flags (decoded below) : 000084A5
>        WBINVD instruction is operational (V1) : 1
>                WBINVD flushes all caches (V1) : 0
>                      All CPUs support C1 (V1) : 1
>                    C2 works on MP system (V1) : 0
>              Control Method Power Button (V1) : 0
>              Control Method Sleep Button (V1) : 1
>          RTC wake not in fixed reg space (V1) : 0
>              RTC can wake system from S4 (V1) : 1
>                          32-bit PM Timer (V1) : 0
>                        Docking Supported (V1) : 0
>                 Reset Register Supported (V2) : 1
>                              Sealed Case (V3) : 0
>                      Headless - No Video (V3) : 0
>          Use native instr after SLP_TYPx (V3) : 0
>                PCIEXP_WAK Bits Supported (V4) : 0
>                       Use Platform Timer (V4) : 1
>                 RTC_STS valid on S4 wake (V4) : 0
>                  Remote Power-on capable (V4) : 0
>                   Use APIC Cluster Model (V4) : 0
>       Use APIC Physical Destination Mode (V4) : 0
>                         Hardware Reduced (V5) : 0
>                        Low Power S0 Idle (V5) : 0
> 
>>> With some investigation we found that the gpu asic should be reset during the test,
>>
>> Yeah; but this comes back to my above questions.  Typically there is an assumption that the power rails are going to be cut in system suspend.
>>
>> If that doesn't hold true, then you're doing a pure software suspend and have found a series of issues in the driver with how that's handled.
> Yeah, we are trying to do a `pure software suspend`, letting hypervisor to save/restore system images instead of guest OS.
> And during the suspend process, we hope we can cancel the suspend request at any later stage.
> We cancel suspend at late stages, it does behave like a pure software suspend.
> 

Thanks; this all makes a lot more sense now.  This isn't an area that 
has a lot of coverage right now.  Most suspend testing happens with the 
power being cut and coming back fresh.

Will keep this in mind as reviewing your future iterations of your patches.

>>
>>> so we submitted a patch to fix the failure (https:// github.com/ROCm/ROCK-Kernel-Driver/pull/181 <https://github.com/ROCm/ ROCK-Kernel-Driver/pull/181>)
>>
>> Typically kernel patches don't go through that repo, they're discussed on the mailing lists. Can you bring this patch for discussion on amd-gfx?
> Will post to amd-gfx after solving the conflicts.

Thx!

> 
> Regards,
> Gerry
> 
>>
>>> During analyze and root-cause the failure, we have encountered several crashes, resource leakages and false alarms.
>>
>> Yeah; I think you found some real issues.
>>
>>> So I have worked out patch sets to solve issues we encountered. The other patch set is https://lists.freedesktop.org/archives/amd-gfx/2025- January/118484.html <https://lists.freedesktop.org/archives/amd- gfx/2025-January/118484.html>
>>
>> Thanks!
>>
>>> With sriov in single VF mode, resume always fails. Seems some contexts/ vram buffers get lost during suspend and haven’t be restored on resume, so cause failure.
>>> We haven’t tested sriov in multiple VFs mode yet. We need more help from AMD side to make SR work for SRIOV:)
>>>>
>>>>> We have tried to solve these issues case by case, but found that may
>>>>> not be the right way. Especially about the unbalanced irq reference
>>>>> count, there will be new issues appear once we fixed the current known
>>>>> issues. After analyzing related source code, we found that there may be
>>>>> some fundamental implementaion flaws behind these resource tracking
>>>>
>>>> implementation
>>>>
>>>>> issues.
>>>>> The amdgpu driver has two major state machines to driver the device
>>>>> management flow, one is for ip blocks, the other is for ras blocks.
>>>>> The hook points defined in struct amd_ip_funcs for device setup/teardown
>>>>> are symmetric, but the implementation is asymmetric, sometime even
>>>>> ambiguous. The most obvious two issues we noticed are:
>>>>> 1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()
>>>>>     are called from .hw_fini() instead of .early_fini().
>>>>> 2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized doesn't
>>>>>     match the way to set those flags.
>>>>> When taking device suspend/resume into account, in addition to device
>>>>> probe/remove, things get much more complex. Some issues arise because
>>>>> many suspend/resume implementations directly reuse .hw_init/.hw_fini/
>>>>> .late_init hook points.
>>>>>
>>>>> So we try to fix those issues by two enhancements/refinements to current
>>>>> device management state machines.
>>>>> The first change is to make the ip block state machine and associated
>>>>> status flags work in stack-like way as below:
>>>>> Callback        Status Flags
>>>>> early_init:     valid = true
>>>>> sw_init:        sw = true
>>>>> hw_init:        hw = true
>>>>> late_init:      late_initialized = true
>>>>> early_fini:     late_initialized = false
>>>>> hw_fini:        hw = false
>>>>> sw_fini:        sw = false
>>>>> late_fini:      valid = false
>>>>
>>>> At a high level this makes sense to me, but I'd just call 'late' or 'late_init'.
>>>>
>>>> Another idea if you make it stack like is to do it as a true enum for the state machine and store it all in one variable.
>>> I will add a patch to convert those bool flags into an enum.
>>
>> Thanks!
> 

