Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2950CC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 15:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E7110E2A7;
	Fri, 11 Jul 2025 15:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U484uVL3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFCE10E2B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 15:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2Gio0Ufrplbxg+5pvgsR6a7AQu/BwfTYZOmxZh1d58IJPRiyBm/qmBIFsL/UWqfUiYwMkP1erw5lxc37ypEKKM4s2PTjLlovRDA1al2cViFPNKd/CSAQUhBfxIU7PGKl+4NEYkj8SwYyw4ZBuSwhgr5V4G7cyCmamdT22FgRKJG2PlyNkNRzp0icyFFsmfS6Sy6s7b0BevUX53osvXsfzdap0KDthJp/40ZSmjHUq0bJWKMZ/Yblxq40BIqWlYo0uf1C2ebwPW8Y1VSqbkIi9C7cZgewXfBM7yv33Jp+9lMIiVuX1d/qHyOBCEZkeVLLBXDRhXlGCywFNkd+8MT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kAMc4m09RTTFBbxe1Ik98mHmh+xdGAx8pv9Jz9SKTg=;
 b=nabSo1VHjxioYgexnnbmnVcVvYfPLz5UbPzmUz9md9scbAhpgJ9DzpY1R1ZPVOAxwTsWNpMrAzcmGXfGHl/np4vb+yrmX2ywxRizB3y2yR5LJH3T9PPZpwITN7IMCuL6m73gM1f2gzBXcJe1rGy497YT767oeloVUAjSG/25V3itgnY0xXiH/XAM8XW3AZzB7rQaZT2tLfCh+n6IBsQTAo/bLpbQxA2Ak1JPidxiTpsvqsz7i5zP4YSIzI6K01mENRPUOFK+b2JGk3Te41Agu3yhTnJF2Dpa5v1VeCz9J4K7QGg6xQzlS7xdVfjln0/5eJVczcuV/LmciP9C4HTG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kAMc4m09RTTFBbxe1Ik98mHmh+xdGAx8pv9Jz9SKTg=;
 b=U484uVL3dpbHjCLBw6oy2Ifgmk3D/jxji5gFIRSYhGn8OqASE1hS6aL/rt27ETMc5Yu3ap2zp5WPRl8NYoBP4b2RVJ0B9qIW/Wnj4DO/KVWIce9OKOouYro12lbsMam16yLBICkTVPNq4Z+78mQ0MV8VZ8GAU/W267pN7tBoFXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 15:28:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 15:28:02 +0000
Message-ID: <5baffbc1-7d46-42ab-8133-d5dbe461e5a3@amd.com>
Date: Fri, 11 Jul 2025 17:27:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu/sdma5.2: Avoid latencies caused by the
 powergating workaround
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250711122338.44831-1-tvrtko.ursulin@igalia.com>
 <57da4e28-4968-409a-9861-3ee969bed541@amd.com>
 <df254527-d027-45df-ae3b-356134536941@igalia.com>
 <CADnq5_PTrZ8eVtT8xDQQyf9tP+7AQ8pcAZ4YSEgUwbufU5YQvw@mail.gmail.com>
 <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a7d6a1d5-30b4-4e79-a845-d71252e7e5f9@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 85330962-00e9-4ea0-915c-08ddc08f85f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkxreXBwSGZwSmI5TWNuQk4zOGViUlRwSWdoQ01xQUw1TStvSE1wYnJhcTJZ?=
 =?utf-8?B?am9iTmxiUWpaejFydEZTYWVVblp0c1R0Ri8xME5xYjJSVGUyRU9xZy9vRkkz?=
 =?utf-8?B?eUhZQTRXRm81M01XQlQ0MXJ4cWtxblRrWktDTjRUcUpPb2V1cmkwK3A4clZ5?=
 =?utf-8?B?NE1NUnlhN0xZOFNCSVhKWi96V2ljcHFpYlZPc080bEJzMy9Yb2t1bTBLZlBT?=
 =?utf-8?B?S0NmQ1VrUGw3QVFrYzBBVEtBYnlkRHo2YWJWclVuSzcvazBFREs4THMwNUpC?=
 =?utf-8?B?d2JJT1RQeHUxbytzQ0ZZdzVVdjdZaU5IUmw3ZmNuOE15cUF0a1BKK2Mzc1hJ?=
 =?utf-8?B?ckt3VmpjQWRnSkpaUnI0cWlhOWZzRHdoRHpteVBzL0ZnMnBhK0IvVHdQSkFF?=
 =?utf-8?B?NUpHUUh3SnI2b1NiNFJmdFNSVk4rOTNBTSs4OEUycDF6WXM3d084U1NhSTdU?=
 =?utf-8?B?K0NmbVRIMi9iWHV3Ym5SdzVZbHVrM0I5VzF6OHRDZklmS2xPaHUvSE5HR1k0?=
 =?utf-8?B?cTJ1WTlNSXZ0b0ZKaEFhZ1hXL0ZhWWRTb1pqb0hCN09JVEVoQTRmalcwakZz?=
 =?utf-8?B?SlZKeGFobk1KcnI2V1BSdXQvekZ4NFpGQ3NOUXQ2Y0xwbXA2THZmVlBFV2Rs?=
 =?utf-8?B?d0JBZHpNbHZsdWNvdkhJNFoyWDRyWnVkbmNjR0Q5TGxKbDAzUWo4ZHV0VjhX?=
 =?utf-8?B?V1dLY0tnbXZyM2twcXVLS1BvWW1xS3dKTzRMY3c5SEpsbWZlWTFCcjkwekVZ?=
 =?utf-8?B?V2RXek9yYzFnbUE3UlBydlBQTjZEL2VzbXdWNUpTZnFQY2ZVT29TNHMyM2JN?=
 =?utf-8?B?U1Y4bjBaelpERm1kb3lKNHc3by9RSTV4emNDcXdyWkRPNmoxTndFdUlMdmFY?=
 =?utf-8?B?cy9iVXFhNzZteG9udGZwdEtNZUJadVhXSzJQakd0WENBTmhpdnZwMmV0Tk9S?=
 =?utf-8?B?R0tHUXYzZ3hMVThVcm0xWkIrakR0TWQ5Z1FnWHVrUllaMGx0MWVRK2pHQnB3?=
 =?utf-8?B?a09xdjVQd3NqTmttbHBRNnRaVHBXR2hRUzF4ZUYvV2xuZFNMRmxrRzBibGpo?=
 =?utf-8?B?YXNHZmppcWxlWUl4anZhcGMyRDBOaVIvZjF3SjN1TFhoSzhUZjE2MTBkSity?=
 =?utf-8?B?cDZzQmZrL0l1d090Z3RmbWJTS2lsUENxQjVjTGtsWXR2ZGtBL05Hb2hlUlJ2?=
 =?utf-8?B?N01HeXJXZnczM3VXRHdzeGd0V0hTQU5teDBoREtHRnpabFVheWthWFpSS3Rq?=
 =?utf-8?B?dUx2UERDazc0STAwTVRrenhrN2tRdHdwc1RobzZPa1ROQkdNeFg0YlhFMjNy?=
 =?utf-8?B?d1pPUjN0bjhJU1hEZVUrejV4QnVleDFoNHVJUEY4MXB5bk1NVGRqRVl6ayt0?=
 =?utf-8?B?eVJRS0tLblk0U2VXall4MGQzaVk4bXZwc05sQndibnNPSGdEamM5OUNQNDF1?=
 =?utf-8?B?Z0JDbTVSVWFYTERkWGdwRk9qaHBuaUgvWURsbi91SEx6TTZpRVpHQllRWGlk?=
 =?utf-8?B?MHprbEpKRmczZDRPcFh5K2F2K05lLzZFdGlsNlFuY1Z1ZGhIZ3hJc2ZGWGlX?=
 =?utf-8?B?QlZnRStHY3lYQkRqYStQcURqaWRvL09ud2RyOTN4bGlGWE05ZXB1WDdVVGxL?=
 =?utf-8?B?RlpxeXRoUW53RFdBUG1nTmF4Vk9xNkpIL3ZGQXVCM0Nsa3hEbjhUQ2d1VFdY?=
 =?utf-8?B?ME9HUmRadnpWd2FpMS95VDB5S0hJVCtORXhPc3BQNDBjMzd2VTRNbzRWY1RP?=
 =?utf-8?B?elNud1dXVGsrWUlEUjJkays2Ti90aWlDUVlhczFnS3VHeTk3WnNobG9HVm04?=
 =?utf-8?Q?VyOidu6tZvb63Y1ndUL2B+HRnfNGxV+WzUlI0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1N1ZzR5ZTFaZ3AyRWNhdjl5SU0vcnhqUGJMZFRwaHV3V05kMlYrVzJGamRF?=
 =?utf-8?B?eGVsVmhPSmJ1ZlRnUHRKcFg3QXRaOGlIUG9uaVRzTWw5L2FoQ0xEYm16Ui95?=
 =?utf-8?B?WCtuUTdBTFdYRDBnZ1k1cXNwcXB1V0RKMUtZTWptWm9mdUxGb2tMZzA5Nm9F?=
 =?utf-8?B?dktzRjFPVkJaT1ljREhmTURzZ2NWV3JBMnNrWStreFg3dVEydS9ZWTJVdFg1?=
 =?utf-8?B?eHJocVg1N29XbDIwZkZxbEdnTnNGZ1ZXam9SdmRXa0VsTGtXeXRYTDRvR0Y0?=
 =?utf-8?B?cTV2MnNYUURnZitXaW0xNHdjWjVaRjhkdmFueS9LNDc5L1hjWDJiaEdtUlJ3?=
 =?utf-8?B?eEsyZ3JxNjE0Wnd2Q2t2ajh5MW80Ujh4ckg1bDVqSXl2QXBrYVdMb2QwR1g0?=
 =?utf-8?B?by9SUVBhdE5ORmlsdVpDYTJMWmp5TkJDUk90WVcza2Z5WVdiZVdYRHozSGh4?=
 =?utf-8?B?dHJvQWVXdTJZWThoc2RuWVdjNlp5Y3RNSmVSSnZjUTFYL1EwYkhBc1R0SDc2?=
 =?utf-8?B?TXpDZGZ5d1Q5SEI5cWpVcWczRXBBQ2kzS2hKNFZiZ0xQR3NPb0t3d1BNaWZh?=
 =?utf-8?B?TnhxYXord0pDeThKNnhkNzFCM1ZsV2NTTXkyVUp3WkdOSjRlMUI0eWp2V2lE?=
 =?utf-8?B?VWtZdGQwVVdnLzFKd2tiQVJLWkhtVU9qT3JVMGtXOGVzeVVXcW9USUFCcTMx?=
 =?utf-8?B?QWxoaEdMQVd2VHNXem9POGRNZ0pGNEV4U1ZiY0puSDByY05ab1lwQlFkcktn?=
 =?utf-8?B?bFpQTk04ZmZCNTBlb3J5WHd3NjhHbmVGemg3K00wbHErVmdQditpWHllWm5G?=
 =?utf-8?B?ZGppWGU1aCt1UkVQZkRoeTFjbUFNdW9kOW9nNGgvQklhT0hsenMvcTFuTHVT?=
 =?utf-8?B?VnpRdXJRTVhwaEpSWDJLc2oveXZNV2tQeTl2bExSY2U3QkJRTURuMmZFaksy?=
 =?utf-8?B?VkwxY3g4Ymg5SlNieGNEMVdSUDRtbVVmNDhlN3NibEtMaTJxZThrOVgzVUtm?=
 =?utf-8?B?S2RmWitLK3NZUyt2bHp5b2VwK1J3N3FhZTNFNHhuUThPNHVYUFo4TFhxQmJo?=
 =?utf-8?B?ekM4LzE3bmxDMXIwdFc1Q2wwaEFONU41cnBWQW5la05TT0UyWE5ReERRbHQ2?=
 =?utf-8?B?a0dtMEdKVE9KSklraFZzdUNoM2RHU3d6dHpqM1BhVnVtaEp4N1R3VUYxanR0?=
 =?utf-8?B?clA4MHNzNVc5UnV5RmdFQml1M3pReHJxdVZxQmxNbzl2dlpaRktoVzRjT1J0?=
 =?utf-8?B?L25uYytwOXlwYWtNM2lJbTQ0bW5PRkJNTzYyWmVNUWF3bjBqMHdzUUptOGlY?=
 =?utf-8?B?S1cweklBdzRYNkZkSG55TmJrbGtFbUdGOGdTWTU1ZHBXalJHYzBkQXhlcWxL?=
 =?utf-8?B?clJVODlTYXpTbjhDa3J4SXVSZ1pnY1FDT0czUjMvSk1KNGhEd3FxODd3cktL?=
 =?utf-8?B?dWszS0p3RlZ1UFJIS2dCVWxlUllzdkdPOXhzRWxGVEtUT0x5emVFdXQ3dHJi?=
 =?utf-8?B?ZCtmMDc2bnlYODJUeUd2OWpuYXJhOWNVREdIL3lHME1qOCtnL3JkVlJMN29J?=
 =?utf-8?B?NzA1aWRGMFM0ZnVxbGtHSlJYamk2Wi9Bdy9sZXV6cERBZFVZMmdZRUhyVDEx?=
 =?utf-8?B?L3hFVEUvSkNBWkIvMjQrOVhTN2xYTk9aZmE4NmI2b3FJQ20xaVlCcmlOaEkw?=
 =?utf-8?B?YmlwSlg3REl5dlEyaHVobllWdEJ6RUJYL0NNdXAxVVNPOEhYZ1ZmMlNQUEdn?=
 =?utf-8?B?SHJCVEdTTzJUK2NGVitTa29TRFFKWU5MRStVdllMS1BVNkJtK1QwN0xLS0xD?=
 =?utf-8?B?WENNcU0waEVnNUZhTEF3U3BsbnRpMk9OQkhURCtTM3JDMEJrZzhybFQwY2g2?=
 =?utf-8?B?K09PUEJyOGUvWkVnRkFUS0h2dzdSNVFFb1VzejFSNzA5WDhRdG02QjV6bVY5?=
 =?utf-8?B?d2ZKRmtiMlA0ZzVuU2xCSjlST3Z3cFo1WnhSdzNSd2NsYUYrRGY3U3dNTGd0?=
 =?utf-8?B?S215Zk90OXYvTzdtSjhLR1gvQjhaZkJOVHZkbmgxN2lvd2d6U2JRbEJGZERU?=
 =?utf-8?B?RmtWNmgwR3duTC8wVis0NHZseitKVDBCbkxvTXlaNlI5N3lCNE9GbFNRYjhY?=
 =?utf-8?Q?Ocy8pyauhjssOm2m0BdE4sQPs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85330962-00e9-4ea0-915c-08ddc08f85f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:28:01.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DDeyW30JBOxhxmUtm9sf4bXLvoMwSpuLEzHiyDyOT/aNIlpNxxEDHocp7nQHmFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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

On 11.07.25 15:58, Tvrtko Ursulin wrote:
> 
> On 11/07/2025 14:39, Alex Deucher wrote:
>> On Fri, Jul 11, 2025 at 9:22 AM Tvrtko Ursulin
>> <tvrtko.ursulin@igalia.com> wrote:
>>>
>>>
>>> On 11/07/2025 13:45, Christian König wrote:
>>>> On 11.07.25 14:23, Tvrtko Ursulin wrote:
>>>>> Commit
>>>>> 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
>>>>> added a workaround which disables GFXOFF for the duration of the job
>>>>> submit stage (with a 100ms trailing hysteresis).
>>>>>
>>>>> Empirically the GFXOFF disable/enable request can suffer from significant
>>>>> latencies (2ms is easily seen) which are then inserted onto the
>>>>> amdgpu_job_run() path, which slows down the CPU submission of ready jobs.
>>>>>
>>>>> 1)
>>>>> If the premise of the GFXOFF workaround is to keep it disabled while the
>>>>> SDMA engine is active, the current workaround achieves that only
>>>>> partially, for submissions and jobs which take less than 100ms (the GFXOFF
>>>>> re-enable hysteresis), counting from the ring write phase, up to
>>>>> completion.
>>>>>
>>>>> 2)
>>>>> If disabling GFXOFF affects the GFX engine too, basing the workaround
>>>>> solely on the SDMA activity creates, at minimum, a needless "chatter" on
>>>>> the SMU communication channel.
>>>>
>>>> IIRC that is intentional. This "needless" chatter is what the workaround was all about.
>>>
>>> I tried to gather knowledge to how the hardware works from the comment
>>> in sdma_v5_2_ring_begin_use(). Maybe I got it wrong so bear with me please.
>>>
>>> To try and explain my questions better. If the GFX ring/engine is busy
>>> is there a point for SDMA to be requesting GFXOFF enable/disable? Or
>>> maybe with diagrams...
>>>
>>> 1)
>>>
>>> SDMA:
>>>
>>>      ring-write     ring-commit       job-execute       job-done
>>>    gfxoff-off-req  gfxoff-on-req  >100ms -> gfxoff-on
>>>
>>> Was the workaround prematurely dropped in this case (aka is
>>> ring->funcs->end_use() the right place to drop it from)? Probably
>>> theoretical that a SDMA job takes more than 100ms but I am trying to
>>> understand it all.
>>>
>>
>> The firmware controls the power to a subset of the chip which contains
>> both gfx and sdma.  Normally the firmware dynamically powers up and
>> down gfx transparently when doorbells come in or the engines go idle
>> for either engine.  amdgpu_gfx_off_ctrl() tells the firmware to allow
>> or disallow gfxoff entry.  So what this workaround does is disallow
>> gfxoff (which results in gfx being powered up) before we touch SDMA.
>> Once SDMA is active, we can allow gfxoff again as it will dynamically
> 
> Hmm so it is "once" and not "while", as the comment says:
> 
>     /* SDMA 5.2.3 (RMB) FW doesn't seem to properly
>      * disallow GFXOFF in some cases leading to
>      * hangs in SDMA.  Disallow GFXOFF while SDMA is active.
> 
> ?
> 
> And for "once active" amdgpu_ring_commit() is what it counts?

More or less, yes. It's the end_use callback which counts and that is called by amdgpu_ring_commit() IIRC.

> 
>> be disabled once GFX/SDMA is no longer active.  In this particular
>> case there was a race condition somewhere in the internal handshaking
>> with SDMA which led to SDMA missing doorbells sometimes and not
>> executing the job even if there was work in the ring.
> 
> Thank you, more or less than what I assumed.
> 
> But in this case there should be no harm in holding GFXOFF disabled until the job completes (like this patch)? Only a win to avoid the SMU communication latencies while unit is powered on anyway.

No, that is something we should try to avoid. GFXOFF can be active again as soon as we have ringed the doorbell.

The work item was there basically to just not turn GFXOFF off/on all the time.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>> 2)
>>>
>>>
>>> GFX:
>>>
>>>      +-----  job executing --------------------------------------+
>>>
>>> SDMA:
>>>
>>>      ring-write     ring-commit       job-execute       job-done
>>>    gfxoff-off-req  gfxoff-on-req  >100ms -> gfxoff-on
>>>
>>>
>>> Is it required for the SDMA activity to cause SMU message traffic in
>>> this case, or is the powerdomain implied to be on (GFXOFF cannot turn it
>>> off while GFX is active)?
>>>
>>> This is the case I measured latency spikes. While the GFX load was
>>> running I was seeing SDMA->run_job() spike and traced it to the SMU
>>> communication.
>>>
>>> Hence the idea from the patch - prevent adev->gfx.gfx_off_req_count
>>> dropping to zero until both GFX and SDMA are idle.
>>>
>>> https://imgshare.cc/rdxu2bjl
>>>
>>> Above is visual representation of these latencies. Y is SDMA run_job()
>>> duration in micro-seconds, X is seconds wall time. Blue is stock kernel,
>>> orange is with this patch. X goes for ~60 seconds, which is how long
>>> Cyberpunk 2077 benchmark is.
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>>> If 1) and 2) hold true, we can improve on the workaround by; a) only
>>>>> re-enabling GFXOFF once the job had actually completed*, and b) apply the
>>>>> same workaround on other rings which share the same GFXOFF powergating
>>>>> domain.
>>>>
>>>> The point of GFXOFF is to turn GFX on/off *without* kernel driver interaction. Otherwise we don't need it in the first place.
>>>>
>>>> We just have a hack for the SDMA because that moved into the GFXOFF domain with Navi and is broken on some HW generations IIRC.
>>>>
>>>>>
>>>>> With these two applied, the GFXOFF re-enable requests are avoided
>>>>> altogether during persistent activity on the GFX ring and simultaneous
>>>>> sporadic activity on the SDMA ring.
>>>>>
>>>>> This has a positive effect of drastically reducing SDMA submission
>>>>> latencies. For example during the Cyberpunk 2077 benchmark, they are
>>>>> reduced from an average of 64us (stdev 60) to 9us (stdev 6). Or more
>>>>> importantly the worst case latency, averaged to a one second window, is
>>>>> reduced from 305us to 30us**.
>>>>>
>>>>> *) For ease of implementation we put the re-enable at the job free stage,
>>>>> since doing it on actual completion is problematic in terms of locking.
>>>>
>>>> Absolutely clear NAK to this. Never ever base anything on the job livetime!
>>>>
>>>> We already had enough trouble with that.
>>>>
>>>>>
>>>>> **) Submission latency ewma averaged (DECLARE_EWMA(latency, 6, 4)) -
>>>>> Approximately 30 SDMA submissions per second, ewma average logged once
>>>>> per second therefore significantly hides the worst case latency. Eg.
>>>>> the real improvement in max submission latency is severely understated by
>>>>> these numbers.
>>>>
>>>> Well that would indeed be quite nice to have.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> References: 94b1e028e15c ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
>>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 1 +
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 8 ++++++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 7 +++++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  | 2 ++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
>>>>>    7 files changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> index 08f268dab8f5..eee40f385793 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> @@ -475,6 +475,7 @@ struct amdgpu_gfx {
>>>>>       uint32_t                        compute_supported_reset;
>>>>>
>>>>>       /* gfx off */
>>>>> +    bool                            gfx_off_held;       /* true: rings hold gfx_off */
>>>>>       bool                            gfx_off_state;      /* true: enabled, false: disabled */
>>>>>       struct mutex                    gfx_off_mutex;      /* mutex to change gfxoff state */
>>>>>       uint32_t                        gfx_off_req_count;  /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> index 206b70acb29a..bf9bffe40235 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> @@ -191,6 +191,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>>>               return r;
>>>>>       }
>>>>>
>>>>> +    if (job && adev->gfx.gfx_off_held &&
>>>>> +        (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
>>>>> +         ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>>> +         ring->funcs->type == AMDGPU_RING_TYPE_SDMA)) {
>>>>> +            amdgpu_gfx_off_ctrl(adev, false);
>>>>> +            job->gfx_off_held = true;
>>>>> +    }
>>>>> +
>>>>>       need_ctx_switch = ring->current_ctx != fence_ctx;
>>>>>       if (ring->funcs->emit_pipeline_sync && job &&
>>>>>           ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> index 2b58e353cca1..4cfd175ac6df 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> @@ -191,6 +191,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>       if (!*job)
>>>>>               return -ENOMEM;
>>>>>
>>>>> +    (*job)->adev = adev;
>>>>>       (*job)->vm = vm;
>>>>>
>>>>>       amdgpu_sync_create(&(*job)->explicit_sync);
>>>>> @@ -268,6 +269,9 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>>>
>>>>>       amdgpu_sync_free(&job->explicit_sync);
>>>>>
>>>>> +    if (job->gfx_off_held)
>>>>> +            amdgpu_gfx_off_ctrl(job->adev, true);
>>>>> +
>>>>
>>>>
>>>>
>>>>
>>>>>       /* only put the hw fence if has embedded fence */
>>>>>       if (!job->hw_fence.base.ops)
>>>>>               kfree(job);
>>>>> @@ -301,6 +305,9 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>>>>       if (job->gang_submit != &job->base.s_fence->scheduled)
>>>>>               dma_fence_put(job->gang_submit);
>>>>>
>>>>> +    if (job->gfx_off_held)
>>>>> +            amdgpu_gfx_off_ctrl(job->adev, true);
>>>>> +
>>>>>       if (!job->hw_fence.base.ops)
>>>>>               kfree(job);
>>>>>       else
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> index 2f302266662b..d4ab832ac193 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> @@ -46,6 +46,7 @@ enum amdgpu_ib_pool_type;
>>>>>
>>>>>    struct amdgpu_job {
>>>>>       struct drm_sched_job    base;
>>>>> +    struct amdgpu_device    *adev;
>>>>>       struct amdgpu_vm        *vm;
>>>>>       struct amdgpu_sync      explicit_sync;
>>>>>       struct amdgpu_fence     hw_fence;
>>>>> @@ -55,6 +56,7 @@ struct amdgpu_job {
>>>>>       bool                    vm_needs_flush;
>>>>>       bool                    gds_switch_needed;
>>>>>       bool                    spm_update_needed;
>>>>> +    bool                    gfx_off_held;
>>>>>       uint64_t                vm_pd_addr;
>>>>>       unsigned                vmid;
>>>>>       unsigned                pasid;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> index 426834806fbf..22cac94e2f2a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> @@ -350,6 +350,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>>>       ring->max_dw = max_dw;
>>>>>       ring->hw_prio = hw_prio;
>>>>>
>>>>> +    if (ring->funcs->gfx_off_held)
>>>>> +            adev->gfx.gfx_off_held = true;
>>>>> +
>>>>>       if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
>>>>>               hw_ip = ring->funcs->type;
>>>>>               num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> index 784ba2ec354c..afaf951b0b78 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> @@ -202,6 +202,7 @@ struct amdgpu_ring_funcs {
>>>>>       bool                    support_64bit_ptrs;
>>>>>       bool                    no_user_fence;
>>>>>       bool                    secure_submission_supported;
>>>>> +    bool                    gfx_off_held;
>>>>>       unsigned                extra_dw;
>>>>>
>>>>>       /* ring read/write ptr handling */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>> index 42a25150f83a..c88de65e82bc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>> @@ -1944,6 +1944,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>>>>>       .nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
>>>>>       .support_64bit_ptrs = true,
>>>>>       .secure_submission_supported = true,
>>>>> +    .gfx_off_held = true,
>>>>>       .get_rptr = sdma_v5_2_ring_get_rptr,
>>>>>       .get_wptr = sdma_v5_2_ring_get_wptr,
>>>>>       .set_wptr = sdma_v5_2_ring_set_wptr,
>>>>
>>>
> 

