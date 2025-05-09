Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8988C3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 06:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709A410E9AB;
	Fri,  9 May 2025 06:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MpR84ABj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36E510E9AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 06:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtrEclQ4qkP+gjUnvH6vgOAhky/WqHZHlJREknjMLSROTMg53UCyQNDbQ52oB5S8BE17Do1ZktQlbpNtEnYFb6qkDoaRnKw7f0A87eOjdIxP8CD5f2y7fbvAK3NpVuDk/VBxfrl41gUSZ/vD4AO9GK1+6e11Lo/OicPvle4HgU843I1jC4Tx+dMWH+QmTR8CEuKAA4WIlhmTfVtF8HlAIEQQqenlMLRPhCiaSiFOYbv+JKfWLw68EeIkufwPqnfPV7SaknH3zL0ZmYbMR0Rdsgmet+A3j4Bvo4dDEr76BOlFN6NaGNGCIeByF3kTebjdvnMVKjN1AO/dvDgqOnnbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NIEJ05PRL670j6lZWUWdfxBvKblIGABgZffSqY7ebs=;
 b=hXCRzUWTtwucKoJAlPXAGU9n+N5C3smh4o1xuJ1aCjctIwjseAiHzFhbT2HFYuljVHOirWWBJs83VocdHv4x9dfv6hhzhqC2S2ECUpSKc/5W19K/7nil53SEEluxqCeYYOV5bJzJAFMx7ln8W6LcB8gdYkeXqRGMcP2iAD0pUifB5iMbt5lks9bTTpmZ7e+6SmgF6s1sVjYoW159Xhg10q/d17ruvkYIqxq5E6JTwWAh2CEnGHM6HBIaw/sZF+9JH6RkiSB9bze2NonuN5q1hEJUGMN9PqomwCb8IOHf1YCW+9a5b0/INtUNtnZIToPw6Xc03xUhn/ngXNkZSkH03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NIEJ05PRL670j6lZWUWdfxBvKblIGABgZffSqY7ebs=;
 b=MpR84ABjQ7fXHHhIZO71EzyVqBFc1R8fTyTJ8t/Nec4qi3gHN+rZBACV7uddqXAi7RPQEjvnAjiPk7q7miyf/5yfZQZYOqlcWOObwrOKqILV/XKSujbjClVjpBEIvCbyjCllcfM9BHssNOhQm/L9Wx3XYCB+P7CdC77LmrZqzQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 9 May
 2025 06:00:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 9 May 2025
 06:00:04 +0000
Message-ID: <bb06537d-b04e-4657-9893-923a54b8e5a8@amd.com>
Date: Fri, 9 May 2025 08:00:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com
Cc: Felix.kuehling@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
 <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
 <6466df95-a64d-4894-b148-c153d299599b@amd.com>
 <7563a7d3-a871-490b-b756-11255d0532d9@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7563a7d3-a871-490b-b756-11255d0532d9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0107.namprd02.prod.outlook.com
 (2603:10b6:208:51::48) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: b7845f5b-584c-4ef1-64a4-08dd8ebebe4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnlxSjJJTVlpbzZVY3BTaENzMFQ3ZzRHYVhzMWlOWWJDRXAyYU14Rzd6Tm9W?=
 =?utf-8?B?NmRHNjNCQlE5RTdtZU1zQ1NRTEpubWtEN2VCYWRjaGlRMFY4eVpNeThYa0Fl?=
 =?utf-8?B?RUV2UXQxaUc5QVZickNOdExYc1ZSakREUjN6a0l5dld1a0dEWWtWM1hUUjNT?=
 =?utf-8?B?SGxYZGdmcmIwTnVTN2VTNk5LYWwvZ2M3UUYzb2crNWxuK2s0VlFIMDhwV1Fi?=
 =?utf-8?B?cG8rYUhQcmhLdGovdjdKVU4vcWpKTTRQeXp2Qzl4WS9NV0JIZDJveFU4M3VU?=
 =?utf-8?B?L2lRcGJuU3ZaQjBvMmFnZ2p0VGRGamxoRGNVRlR0VjIyVU5NSFJEMS9YOGx2?=
 =?utf-8?B?Tnl3bmFoZGxmS2duMk11MTY4dk1EQXZPaGp1VmJmY0l3K1c5S1VvWDNTckdz?=
 =?utf-8?B?VWRoOFloMFg5WmlTbjF0N2pzK3JwNDJUUngzYkhJdFBUN2hSN0E4dExJR2kx?=
 =?utf-8?B?NW16aWdYa3hCR1VLUHJPTCtETStuQVJTdUhmYVk2Q0s1d21VSWxNVTdyY0NH?=
 =?utf-8?B?ZW1TWVlQUGZEK0p5b2lYcjM1aWJKcllia3ZSMFFkN3pPQ0lSNStvMmZiVGVi?=
 =?utf-8?B?K1JkMXJRV2V3VnNna1pJM04zZ2d4Y0FFcUo3STJRZFY3RGgwVytHNEczbjNm?=
 =?utf-8?B?bDMrQ1pHVW02ZEZZS3VIaXFYNS80TG1PdGxESmtwcDhudzlUZVhkbzdlUjBu?=
 =?utf-8?B?QWVvTmE5VzAxVjJ0YU1EVm0vZWJtZ2ZyOVRjMjQvTUhkK2JXK000VXJndGJn?=
 =?utf-8?B?Um5uUWo5OEF1TDhXLzlDMHpNLzR2Y2tkVnVod1NtWVFWaTMvUlBqT0RGbEc2?=
 =?utf-8?B?SmIvamcrTGlncUNtT1pEcVNKMmJWNlNVa0xQNGloQ0szL2ZYWDJvY085ODhY?=
 =?utf-8?B?bE9aZnMvMWFBV1pIdkVsaDVnTmdPby9aS0R4NnRmMzU4V1RkOWQ3N3pkRmxr?=
 =?utf-8?B?eDdPc2g2eXM1MEhUYkVTNStlWjNmSTg0cnVQVDd5NFg0QzZIU1luYnB5SXNS?=
 =?utf-8?B?S3FwdVMyUUU5cGpWajFIMmNYRXRKSGUxM3B1cjZjSUJsc2N1RVhPbE05bVdw?=
 =?utf-8?B?NTdpZTcyMjE5SFJVQ0dacW1KbHh0MFJvYVJ3SlY0UTZQSldBa3A2NG5TZ3pw?=
 =?utf-8?B?cG1pS0lITEplOXlUYlcyWVVwazl3ZW5RT1YzNGtGdlEyNWhEOTBRSGVHU05O?=
 =?utf-8?B?T20yWXhTRk1nODV5czErZ2I5eDFiWWVPRWZ6KzFPRzh4RVZlTHgxcFpLNHFt?=
 =?utf-8?B?Z2lWbTJuZTZxRUdHZHp0LzhOeENySmR1dTlob1dvMitTSUZoWE00dnhUTjBU?=
 =?utf-8?B?bEk4NFhoeDJXNzdCU3luVlVpbVNJaENQaGpBc3I5OFp4ZzRhMHIvK0hLQTYy?=
 =?utf-8?B?ZWVYN084RWVNQkNtZFVRZWEzcW5PcE83NFB6RkdON04vOURwYWVTREE4ZUFV?=
 =?utf-8?B?NkEzclU4Ri9QT250N2JlSXc3Z2tkemt0YmoyUHhvcWxlZTlVbWFLMHg5QmZ5?=
 =?utf-8?B?eG5LdWduWFgrOHJqa2ljNFN1dzJqOWphdU5pSzNLZWk4emsyTkZzTFJsMjRH?=
 =?utf-8?B?cnBzQnJ1QXBsZmp5aWlZaTkxU2lEMnB3cGZ5L1M3K2M5UCt6OTBYa1lmdDlx?=
 =?utf-8?B?ckRVV1piTEhTYmw5bFBNaDJ2VTZyUGVQa0VhNzBubmw5Z2JUR2FuZEJDR0R0?=
 =?utf-8?B?V2xkdm9xQmgzU1IzU3B2eEFrV2VTZEdOU2tXVzdzdXgwUDZtbWhnZzhqczda?=
 =?utf-8?B?cHhsdWpyTVlaYjkvOWlMejlVTEkydmxvUkI0R0hBcHZheVRCOFZubFdkQ1dj?=
 =?utf-8?B?ZU9STmRMR0Y4ZExmK1VlSEJiM0tIZW12WU1TN3ZYZnF2bGxYUnRWZ2tPVUhP?=
 =?utf-8?B?WmoxVlgzYWNYWHlMTlQwenl2OWpXQWNtMVkwTm9ZTjM1Njl4Qng0TG92cXI3?=
 =?utf-8?Q?CvAqcffJtE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0Y0TDdUSng5dnl4TW40VitHT3J4OC82N0tEOU5aQks3WElwZ3hnd0Z0Myty?=
 =?utf-8?B?U1JtSjBpTTBxWkFFM01tRXIreG1VckFmeDhnTmZVM3FWdEc5empzNkdsQSs2?=
 =?utf-8?B?R2Z2L0NlOXF1YmZTVHNZRUgwUWpCbGNMVW04TS82NUQwZWJrazR2RFVuekNV?=
 =?utf-8?B?RDhlY1RLY00wVFRaclEwcWFkRnlRdGtSME44bk8rdU9BcE9qSExJWS9Hb3hR?=
 =?utf-8?B?OGQxVTkyTjZqSGhIem1ZUGI3Q3AvNmhNbm1LbVFPQVRnMEZSMHlyQ0hobkZC?=
 =?utf-8?B?aEpUOEdZY2FQQ0Jrc1hISHZMWUJpL3M3VlRGK3lmUmh2cU4xMTdFaTRIWEJY?=
 =?utf-8?B?WWNCQ0hkalpzdEpQSmdBK1FyQ2djVkNVR1J0UnFJdVNvTk81OWQwa05Bb1Rk?=
 =?utf-8?B?Z1l5L1dHRnJHVXRQczNGVzhEV1p6aFV6MVNVMG5oWWJKK1IwOTVUMUsxb2Nq?=
 =?utf-8?B?czI3R1V5SXBWbS9qN0RWZGVYVVVWRnhVd1hEckhMakQzVzBEVE9oMk8zWG9k?=
 =?utf-8?B?a09JRk15VnlzdUhPQ1JuNGF5NHRrUmVqdTdNYmQxLzNQWitPWFBHZ2hpbkR3?=
 =?utf-8?B?KzNoWDZCRTdkMXk5MzNJSkl2c0JQdFNSNnk5SmlycGl2NzcwT0ZCTTlsT3kv?=
 =?utf-8?B?SW9BYW53MjkweGI2ZzZIZnhSTlVkeWpwdittVUZVdnVpU1hwZEhZcHJlNTNX?=
 =?utf-8?B?RlRZUDRaOWd3RW9wRFNpWExFVjlNczFUV1FHZWpEMGhUTlFmUStON2k4RlRW?=
 =?utf-8?B?NFNqR09RQW90eHlDczNITmZFa0xMdHJhK245N1VxeXNKM3VDSk5IRGNiUmtk?=
 =?utf-8?B?cGNpWTdDZ25ocmlrSkl1UVViUnFENzRnSlpYdkx5cVZ4QS9NYU85dG13Rjcz?=
 =?utf-8?B?YTNUUmtReUUwZEdqOUovbzcwZ3lFYU41OWZpMTNlVmNKdHowZU51S0VvWnA5?=
 =?utf-8?B?RmQrNzY3WUVWZzRYOWxLUmFpSy96RnBtZlovTEN2UXdRWDh5VzBlWXVuczhq?=
 =?utf-8?B?cGYwTlpsV29hRkZEZHIxMXQrTkpCLy96R1dvWVd6ZUhHaXhEUEN3SVlMYlNZ?=
 =?utf-8?B?b094Q0NwNlN0SVA1bnUxS1ZJL0EvZ0lIbGxPdzFwbU1aZG5OaXdjazY5QTdM?=
 =?utf-8?B?bmZ1N3VJV2t2VGxMQ01TMTJ2UkZrTElqaXVSTTVJTDdhWXpwWTRYUXdOd1FC?=
 =?utf-8?B?V3dkOVJ1NS9Zem1OYXQ5MGxDd2hRR3lEM0dkckozRGRvTzQxZEFHZnNrM2tF?=
 =?utf-8?B?WXF4MTBBczFZUkNXU3h5M05kMlBGWi9sa0wwR3lTWDNVakE0UXpWQ0ltQjlz?=
 =?utf-8?B?RmdxcDJNbDZoRWMvaE5sS0h4cE02ZG5JUnA1L3VHT2hXVENON2l3UVZWWTJL?=
 =?utf-8?B?eDlTT2hyRXhsN3lZd0daYkdRaWZTSm45NkFxa1NxOTRHWG1HZzBmU2NHa0xC?=
 =?utf-8?B?Q0FWNXEzM2NzdXg3SmxDbUV5OXpJdHlLSFcvcTBRRDFYU3BiYkZvWU5XTS9u?=
 =?utf-8?B?OUFYWnpSWWhwOURUMEE3bVV3aGJsdlNCbS9USzVJdGpnZ1RBSndYNldHOEg5?=
 =?utf-8?B?R2ZKS3RrdzJ4aGhnVUJocm9tS0pXM0pwNTBQMk5WVm5oWlY3dEVhbU1aclQ3?=
 =?utf-8?B?NkFCclV2QnVxa2RpN2lYdExudU1GNUVnaGl2ZHphaWhtSmV6QzBFSk0wYUFM?=
 =?utf-8?B?WXNpV2xyYW1Gd1h1OU84NTVSd3YxSjM0bUV4YkI4QmwwNW1mUVMyejVrVDBB?=
 =?utf-8?B?VmIyTW4reEJBSHhEbzAzOU9BZm56OFBMYkFMMEI3akF0WEk4cmFSTjQ5SjZR?=
 =?utf-8?B?RVJqbURDUjZTaDE0Y1JYTXpxcGRkeStEbHpCVUxHd1QxUWJvQW5IeTdIOTda?=
 =?utf-8?B?UGxqbGpCZ3A3UGpFdDEzMU5SdC84ZHdwK1NrSFpQRUg2bldlSHBRbGE2WEJW?=
 =?utf-8?B?NDFMRzhPVDJRUlFOaXBCaFpqeGtMS2c2VFlLYXRud2JYOERsTzJaYnowRWs5?=
 =?utf-8?B?YWFDbXcxOVFaVGtQcUpGMnVPUldUaG4vYzY3S2g5MjhFc1RsRUR1ZS9tb21w?=
 =?utf-8?B?czdpNmpGNTlwM1F6R0c1aWV5SDJScHd3U0ZISmlGbW5hNnJMSDV6VkNXbUxM?=
 =?utf-8?Q?TrKdNTN79gOVzsz0/t7n9TIY3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7845f5b-584c-4ef1-64a4-08dd8ebebe4b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:00:04.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izNSZgcr4EJAunuGg7xOzCfI9pWiw58VRIjLs87MyLjFWfcikaJE8mkYmJb/5Qrf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
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

On 5/8/25 19:25, James Zhu wrote:
> 
> On 2025-05-08 11:20, James Zhu wrote:
>>
>> On 2025-05-08 10:50, Christian König wrote:
>>> On 5/8/25 16:46, James Zhu wrote:
>>>> When XNACK on, hang or low performance is observed with some test cases.
>>>> The restoring page process has unexpected stuck during evicting/restoring
>>>> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
>>>> 1. when xnack on, retry pagefault will invoke restoring pages process
>>>> 2. A. if there is enough VRAM space, simply migrating pages from ram to vram
>>>>     B. if there is no enough VRAM space left, searching resource LRU list, and
>>>>        scheduling a new eviction work queue to evict LRU bo from vram to ram
>>>>        first, then resume restoring pages process, or waiting for eviction
>>>>        timeout and try to schedule evicting next LRU bo
>>>> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>>>>     queue eviction will be triggered.So restoring work queue will be scheduled.
>>>> 4. step 1, restoring pages process will hold one mm->mmap_lock's read until
>>>>     restoring pages is completed
>>>>     step 2B, evictiion work queue process will hold one mm->mmap_lock's read
>>>>     until evicting bo is completed
>>>>     step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
>>>>     write after the above two mm->mmap_lock's read are released, and in the
>>>>     meantime which will block all following mm->mmap_lock's read request.
>>>> 5. in step 2, if the first eviction bo's size is big enough for step 1
>>>>     restoring pages request, everything is fine. if not, which means that the
>>>>     mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
>>>>     eviction bo's restoring work queue will compete for mm->mmap_lock's write,
>>>>     the second and following LRU bo's evictiion work queue will be blocked by
>>>>     tring to acquire mm->mmap_lock's read until timeout. All restoring pages
>>>>     process will be stuck here.
>>>> Using down_write_trylock to replace mmap_write_lock will help not block the
>>>> second and following evictiion work queue process.
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 72be6e152e88..5f6ed70559b7 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>>>>   {
>>>>   retry_flush_work:
>>>>       flush_work(&svms->deferred_list_work);
>>>> -    mmap_write_lock(mm);
>>>> +        while (true) {
>>>> +                if (down_write_trylock(&(mm->mmap_lock)))
>>>> +                        break;
>>>> +                schedule();
>>>> +        }
>>> Oh, stuff like that is usually an absolutely clear NAK from upstream.
>>>
>>> As far as I know that is not something we can do so easily.
>>>
>>> Would it be possible to wait for progress instead of calling schedule() here?
>>
>> [JZ]  At 1st beginning, I am thinking adding sync with restoring pages done.
>>
>> but the original restoring work design philosophy is blindly scheduled after certain delay.
>>
>> the changes with sync may take more time and risk. I would like Felix and Philip give comments
>>
>> if there is efficient and safe way to fix it. Thanks!
> [JZ] BTW, in worse case, mmap_write_lock will fall into rwsem_down_write_slowpath(), schedule_preempt_disabled() and schedule();

Yeah, but drivers are not allowed to re-implement or even bypass that logic.

Regards,
Christian.

> 
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>         if (list_empty(&svms->deferred_range_list))
>>>>           return;

