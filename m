Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD63CCF9F0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 15:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F59810E10B;
	Wed, 29 Oct 2025 15:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rJgrgS80";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC62410E10B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 15:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6gIsKH8cgBcPi9Alsihh4AfmotKRLDCYelcVELOHjFe0I/lkWKzg8AoM4tGurkIOK+btDm+KEU2gbHUgWbY2yJOva68ZiodSMIijns/uyi5nURiYvf8lh5jH86jRRjLWgTyWHTHBICt0PQ/Br4zdB+KilZmn+fKhH/L4fg8SzFjeeBkntRXu6541AsDUwGatgoICve8m7CVTiNCuYTOy6rEfqlpp/mooUBYbs7E+PNXjGfx1Hjzf1uuGZs5DWcCeUnjGS6Gl9cYIUCJw8nb59iRSOWVwYBVswejKVRm7iFOIltUKIe0VGAGG0T/PrZsplRyaFpuKIcijxEUFezgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxKMALV653EUgLAqNLO7vZe7jPW1tpt6SF8G/BP6Ga8=;
 b=WpNPKZlBM0oQedYml8ioVEu/EVuEcP0Shf/eZxDCpKcj8CB/0pRQEnxA/4vtTlJAyJZAIHVeynDSOQkMRrOOVgG3eijAhfet9jSUy9eY3a/bKOUe+Eijgx1DD7BRfT8aeM+4F/M/vbtHIpOo+gr6rmKDadkPQAr8+tqX2JBGzs2QaErLkRc9ynfe3U6nwXOhz5hOfYk8Ptfq4leeWmBssMTFLphHvGxrOxGbjOAYPUz5YIbbsyGqY1nqSaxH/om/hDpHfQX7mcLoliyfGanAmWpSa0w0eIrxxgltI4msaeM8uP2KzCMIkVGFGF86vCioba1Odr4pC6VephxotEnZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxKMALV653EUgLAqNLO7vZe7jPW1tpt6SF8G/BP6Ga8=;
 b=rJgrgS80KGt+2N466NdCdqyA2rxUNOALulUGNldzT0beMUZjgArRN5OOTm56upMDhSa/6Mh5iBxQb6UTbfgTq4ezMkkfn/INrpraZ0xFcetmuRMQ4200xWV9Hz8gAFZPUAqKiKrDgVUSy8wnIuwbXRavBGOGsJ0pysKarW5N4HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 15:56:46 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 15:56:46 +0000
Message-ID: <e8e43ab9-a3a5-4510-8934-eb75c7f0b650@amd.com>
Date: Wed, 29 Oct 2025 09:56:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] drm/amd/display: Fix black screen with HDMI outputs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Ray Wu <ray.wu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
 <20251029030935.2785560-12-ray.wu@amd.com>
 <0756e73047c861ccaa326134e723d09722fe5ccb.camel@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <0756e73047c861ccaa326134e723d09722fe5ccb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:303:85::23) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c56472f-3e5c-4c3b-5a6f-08de1703c33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm9aaDZjMFhYVmZkdGk0aFhIMS9MSDkvT0srYkdhYTdaMjR4dis4NDdaMGZn?=
 =?utf-8?B?ZDlXK2FHbEQyVS80dDlKMnJqMlpKdk13bFlEL0ZsRXlpajVTUk5aVlJEQ1VU?=
 =?utf-8?B?R2VPTDEzU09CZ0N2VTJMdEw5MHZBQlF4UjlnWTJRM2VudEtWbnI0WWI2WjZn?=
 =?utf-8?B?Q0EyeXBqWU9abml5dGhGeGlEdUdqb0pvT1ZtRmREU2ZwbndDY05hOHYvbTN3?=
 =?utf-8?B?ZTY1aGwvYUE2b3BWT3dPMVBLODJsQW5aSlJ4RGN6ZnBySDVKMWNqRi9sazI3?=
 =?utf-8?B?ZHFLTnFNSk9tcEVHQTBybzFKT2FBSURuKzBKVTBYU29TMi8zSTkzeDg0UDVi?=
 =?utf-8?B?eUcyYXNvajd5Wkd0RXdnaVNKKzIrU050VHpTOVpNS3hCc3JHM1VUMHp3SWNI?=
 =?utf-8?B?NXlZZ0ZUN3NZU1k4eGpNUlBFcC9ONFZPR0ZNMzlKUllPdFBuL1FVTUkrbGZU?=
 =?utf-8?B?VkQxRXRJTXgvMU5CTi84Y0N0T25FVk1mZTJJMVZSc0FLeWdsSSticm1BeGdq?=
 =?utf-8?B?cCtOV0ltZmFuMzdQQUovQmJUaGd6ZElNUytWMXFGMyt2QmJ1Q0lxVHl1ZGRL?=
 =?utf-8?B?c1VUM2lzRTl6MCt3U0RlU1NOT2VjdVBpUzcxdEZDQVhHRnNWWjlseVI4VVh2?=
 =?utf-8?B?RGU1VSt1MzdLb0dBZDBLRDZWTjdRdzA3aTJjRk1NL1doZUtjOEFhRUcwUFhl?=
 =?utf-8?B?MjlFOEVoMkdYejQyN0VpY1ZtTytDVmZ1Z2MzSjVBTE9TbWZzaHFiK2FwQW1s?=
 =?utf-8?B?enlGUFptQWVOU3RuS1FGaS9HMFpEUjB2R2xGbi8xcFh1VHdteTN5UUQ1RVNu?=
 =?utf-8?B?c3hjMUtoT1lGcGYwdUREZW5wZXhGdkVSOXZ1QTF4Q0t0bldhL2lhVE9UMURW?=
 =?utf-8?B?QVBJMGZlc0FPdndZSnpiZm0wNHJHZ2lTd2NUVzJuK2Z1Y1IzMUR4WnNrMW9U?=
 =?utf-8?B?RGtSYXZvOHgyMi9IZWtVVG5jWDkybElNT295RkFWeW9LZWkvbUFUSzdtZlVh?=
 =?utf-8?B?WHExUkhvV29PMkZ4VGF4NitoWWNXdW12Vjg4eFJnVmJJM0lHWnFZZmM5R3kz?=
 =?utf-8?B?Y241NmZheDJNZmFiTStjakRFWFdBKzlsbm92YVU0VVc3QW4vOCtsZEsrbnZi?=
 =?utf-8?B?M0w0ZmJobUg4TDVjQWpmMGx1QkhtWjEwa3puTWJremc2Q2JwcnJDQStVaVA4?=
 =?utf-8?B?aFgxUWxLY2ZDVnZXK096QTBWYVR3cHZDd3ZYVHlFZ0hzWUwxL0U4REZNVlM5?=
 =?utf-8?B?TTIzVnVmS0JqeUJWbEVqaGo5QzZaT0hWamRKK3lJclk3ZmI1OXVCdzlGdUVo?=
 =?utf-8?B?UjYrVEpYb1lkcUVLM0NoZk82ck0rbmFPMzJFeHFzVXBrR2VhTGZHRjM0aHRu?=
 =?utf-8?B?VEJybGxHRnk5c3FYWHo4OU43SUh1YWo3RnhMMHVaaCtqclZINWRoUVdITjF2?=
 =?utf-8?B?K2NGK294L1hJZlNZSTRPdWh4UlFTaVpDZlJmMWRUSkx0aWtOUFJFS3FwQTIv?=
 =?utf-8?B?MEh4Y3BoZXJWWE1nTCtqMDVBV2RZU0dBQ1dsenZ2czkyOGtYck5NV25pUTV4?=
 =?utf-8?B?aGJjcVNyblU1aWQwbkY5OTIxWG9sajRhcDBBT3QyZEJlRjhpejZrckNNYzhl?=
 =?utf-8?B?UDNBbjRheGVHbDJXak1UU1MxK1dSZXgrQlZkbGRmKzJ1RS9zRFpZWnQ0MnpK?=
 =?utf-8?B?YUh5SlIxemY2cGZiZkJ5WXNSMmRjNEg3SXFxdEY4NUJqcnVNNGtzVWlLSnRL?=
 =?utf-8?B?Q2NHU01Ua0JoVnVidENDc29FbDQ4L3lQQXdZbXVMa0xjOXBScURDcFBVdWd6?=
 =?utf-8?B?NzF2d2pMWUJLT3A5WklSc0lrYjliemlaZFhjZWozS2hkS2VFUVFMdmQvS3N1?=
 =?utf-8?B?eUN2bWM0SjluVUROWkYvWlNNaDZDSDIycGpOVkhMeWlZY0EzSHQzcWFScG1i?=
 =?utf-8?Q?fi/S79pI8fJpKAyv6Vvg2SpCn2j48pC+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FZSVJQUmNScHZheE9SMWI5SEFXTGxYT0xhUlJUYkh0VjlVVjVXeFc2aUh6?=
 =?utf-8?B?eVdFWWVQaG1za1pDaW5WZG9vY0grc2lOYXEvM0pzT1ZYTlNjUlo2SU5SR01t?=
 =?utf-8?B?aWgzT2NFaERZWlJtdURLTGo5RWtibE5zckJjTWRVU3lOUWh5VWpHVURVTTdy?=
 =?utf-8?B?a2hvWXVmMUJ5YjZLWlpjR3hjQlBSelBFZlJtakpmNDJSTDN4U2tpRGE3RXN1?=
 =?utf-8?B?eU9tQjAzUUhkUytYNVpGVUhVQkhVblZZOWc2KzdSNkU1cDJoU3B1SlZsVTFB?=
 =?utf-8?B?UGZISGdjRktudlNNRkdVbHBsdXBFcGhmSGxhdTJWaXVtQW1ldWpKdWpUTTRB?=
 =?utf-8?B?K1lxbkR4UzR6NTBkd2YwZzJqQ2ZqcmdXeXJCazA0RnptOUV4Q0hmNVhOQ2VX?=
 =?utf-8?B?NnBoYnFGQ21jTllVdURwRTBSM3I4MnlrK2JMQ2hVK1BWeFJyNXJFU0xGN015?=
 =?utf-8?B?bDZHWTgyQkFMQWJJQnNBTDFXMWVEbWQ3VVF0bmUyaHpRcWF3RVdXUWlBSFVB?=
 =?utf-8?B?RlZnY3RoS3RhOFFLbzQ1Nk95WkFadVIrL2doMDFvWFNPKzNOZDcxVVFsc3pD?=
 =?utf-8?B?TC9ZU1QwSWRqWlFnZjZXdUdKaDRQeXNNd1h1OFBuVWhzc1BBcExHQ3VPVVZq?=
 =?utf-8?B?Y05WV0lwRTNod1hxVGtYWVNkQUVGLzFkYjNEU1A2czduelVScHY4SVhlM0tJ?=
 =?utf-8?B?NE53MjIyak1CR09iRWJqYUxNaG5xbkk0QS8wc0lld21hTUpIUkhVTUNjbVBt?=
 =?utf-8?B?RDNMT0tMVko3TUFjZ1FEREh4VnZlT2xVaFIyUWIxNGVUUFQwa2pXQURJS3hr?=
 =?utf-8?B?U0orOGpuVUYwMjJFZStiRC9SNzhJdWRFRllVWkZtamR4MVozMzNpZmtwcWZM?=
 =?utf-8?B?Mmp6a21vaVJac3RzekpkU0haa0N1ajg5bHh1U1pPZ2dWTHdlak5abUM1UVdi?=
 =?utf-8?B?djczZWZjWElLK1FGOXZnSVRMZTN3NjljK3ZWN1A2OXF1bW1JMnZKVlhOMFlk?=
 =?utf-8?B?NERONDhGM1E0MVR1N1ZlYjZJOW5VcXpSUTROeC91RVoyTHowZjErTHN4dDZY?=
 =?utf-8?B?R29NdEU0YzVIU1NwVEVOZ2F4VnpIclpkRmJ5V3BhSVI5MVg1VWVuamtFRHZm?=
 =?utf-8?B?aktGNGkvY3hIL0V0NUhvQ1hNNERmamVMUWVvZzdZZG5VRTd6Y2owSVR5SXZR?=
 =?utf-8?B?TXBoZ0V4TkNIdXFlRUVpbHZjZXNOczEzdjBrcmV1YU1ETnhCQXYwZnRndnI5?=
 =?utf-8?B?TFZseitIOTB4akZiaWFVRmE0MDVzUkNyQnRyM0hIVFhTdkgvNmlVZFFtS3E3?=
 =?utf-8?B?bE1JeWR0aC9MVGFIc2NyNzd6djFLS2FvaWJnWGdMWUExU3BrYnV1eFRnTDZk?=
 =?utf-8?B?MVdZQnVyUXMzZ3AzRk1aNmxZaDdtZnJzVTQvRXRkYUZNODkzdzJrQTJoWm5I?=
 =?utf-8?B?a2cvVGRYanZWcE45ZkszRWE2R2NUakoxalg1bnc5ZnQxL3BCa1VINi9YT0xS?=
 =?utf-8?B?TGQ1RU9rNDlkczFNdEZOb0hxY0U5OWloYndla3hWWFFUd1lLWkgybThXK2dC?=
 =?utf-8?B?U0I3NW5CQ1hzRGpjbm5td1JqZVo4bW1DdmZXUFAyandycFM1MThoNy9mOUhN?=
 =?utf-8?B?RUdaS1c2TFhDTnJ0TWlDc0xtbHB0MzRKRGxEV01LMG9pcU9RYi8yWHZKMk44?=
 =?utf-8?B?VGZTdnVGWi9jNE9PTGNRTmFDek5yNjArZWIyWnNPbS80L215Q1UwZm5QbGd1?=
 =?utf-8?B?N2lqNnl3RFJPeWUzWVk0MHg5UnI4c3h2OWNzUThST2w2dVdqUXBwMmVkbGZy?=
 =?utf-8?B?OWFuN0hYVG9GblpQRFhTVzJudkNES2ZFcW9uWjMyZkZpU3hFb0VPVE9wNW5J?=
 =?utf-8?B?MEM3bUpnNnFMNHpucGxQVnZJYzAveVBZU2tqOTdadjUzZHJwSmVlRzVLbE12?=
 =?utf-8?B?bUtKNmNPejJ0TElUWDU1N3FucUcrTEV3Z1ExMU1sTG5XblBCaXhha0dXRUJq?=
 =?utf-8?B?WGx0REZLYXJSc2dwZUtMVjdqa0ZFTk1JQmo1c2Rwd1JlVEZRUXptRTZlMGJG?=
 =?utf-8?B?OXVDZlpBQzc3V0kxRThmTGxQNEFIMWJ0em54NTdMdkordHZwYS9DTjlldFd2?=
 =?utf-8?Q?F+323XZuM/U2GjHIP8G9+MvaT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c56472f-3e5c-4c3b-5a6f-08de1703c33c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:56:46.4225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pppMP8q0Blw+2rmghYlZTUJbR1hlTJPBU5+gcSeV+f2XVWUqFjkgYShtY08NwF5mXp12kPAx7alQ4inrq8vcvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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



On 10/29/25 02:07, Timur Kristóf wrote:
> Hi,
> 
> On Wed, 2025-10-29 at 11:02 +0800, Ray Wu wrote:
>> From: Alex Hung <alex.hung@amd.com>
>>
>> [Why & How]
>> This fixes the black screen issue on certain APUs with HDMI,
>> accompanied by the following messages:
>>
>> amdgpu 0000:c4:00.0: amdgpu: [drm] Failed to setup vendor info
>>                       frame on connector DP-1: -22
>> amdgpu 0000:c4:00.0: [drm] Cannot find any crtc or sizes [drm]
>>                       Cannot find any crtc or sizes
>>
>> Fixes: 99ff9bc57b02 ("drm/amd/display: Fix DVI-D/HDMI adapters")
>> Suggested-by: Timur Kristóf <timur.kristof@gmail.com>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>> Signed-off-by: Ray Wu <ray.wu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> index c417780f37bc..e8566a5218fc 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> @@ -1252,11 +1252,16 @@ static bool detect_link_and_local_sink(struct
>> dc_link *link,
>>   			sink->edid_caps.analog)
>>   			sink->sink_signal = SIGNAL_TYPE_RGB;
>>   
>> +		if (sink->sink_signal != link->connector_signal)
>> +			DC_LOG_WARNING("sink_signal (%d) does not
>> match connector_signal (%d)\n",
>> +					sink->sink_signal, link-
>>> connector_signal);
>> +
> 
> 
> We should not print warnings for things that occur during normal
> operation. Warning is incorrect because the different signal type is
> normal and expected on certain connectors, for example:
> 
> - DVI-I: the signal type may be DVI (dual or single link) or RGB
> - DP: the signal type may be DP, DVI or HDMI (for dongles)
> - HDMI: the signal type may be HDMI or DVI (without native audio)
> 
> My recommendation is the following:
> 1. Change the warning to a debug message (DC_LOG_DC)
> 2. Move it a few lines below where the sink_signal is determined.
> 
> Thanks & best regards,
> Timur
> 

Thanks. This message may not needed at all.

>>   		/* HDMI-DVI Dongle */
>>   		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
>>   		    !sink->edid_caps.edid_hdmi)
>>   			sink->sink_signal =
>> SIGNAL_TYPE_DVI_SINGLE_LINK;
>>   		else if (dc_is_dvi_signal(sink->sink_signal) &&
>> +			 dc_is_dvi_signal(link->connector_signal) &&
>>   			 aud_support->hdmi_audio_native &&
>>   			 sink->edid_caps.edid_hdmi)
>>   			sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;

