Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14530C3DA6D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 08:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0CB810E346;
	Tue, 20 May 2025 08:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R3sc8U9w";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F65010E346
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 08:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7No9+b0LeYHXuKFuDead6T9+ZXuWt9jm8V0VpsFeep1IGs/0Cra1p6J4zJW3QPDlWII2FnbAic75Ig4w59mY1b/rX7bh1JHFV93mZpRui7D7IUThve5sNyN9dwKcsaYiXc/yPE4rzpk+Zv0Yq9xfqPcfzLjL3D0s8gEmYfTuGhxyVq0lPEta12iLr4KCy0sDbRnL8HcjbIPButXdhglCxvwhgTucM4OPr2Hl+tn58QGYKk0OUd+bOGib3hHm+W5hoetUzblxJ8wldba/cCDgT0ASIyNOdtrT9Xh/gEeey/cDkgB4i0alszXPiq2JtFrJIeCjTW+Fqw5j2vGBwJ2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJdEEOZjPa87J0HJdJuVipAnsh4fQdqSU6S+ye5Kr/M=;
 b=SKQJwNRwlA8RDuH67phvMb7bNyn8t8kTpdREaWnfTmpBS3EZoocmHbA4NRX1Dl6izn8apJ1XAs6gzT3utUZPCEg4wirrZDctGJtiRb8oq8fLxw9BYF8FFI138NWXSY36wBui3S34w9Z3ILhMjJ8hRaIYiqUxjU7ZM4T8yv/XvUE/a8u/YCavx7STxQotggynx0NDKTfJTvh68716yJb90PygR7ZASxOO8qkYXPeUj6S2cQU8VtRd9hetX2uzzG9vgFqZyOdaAU5OB6GcH8/2MXOK3W3Bur4ebkTECg/RNuVTP6WmVDLPoXxOxV8ntjGBAmgghdJv57Vm8vVjPAjmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJdEEOZjPa87J0HJdJuVipAnsh4fQdqSU6S+ye5Kr/M=;
 b=R3sc8U9wtLND7pAuI1cvXInV37NXrvkVbt9NXarUsjyZ9xBLTrbg9rRfQwhAkRB+YDXMlPZOO/u6ZfxIL43R16T+HoP5y6lvAc+jpuM+Yvj1X9InNP3Kr16T6XWhrlM9iWnMF1kWONM4a5r/b+xYufSlBMzI+QpGjP81BxakJZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 08:40:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 08:40:18 +0000
Message-ID: <3c03620e-43ca-45c8-b099-706b129315bf@amd.com>
Date: Tue, 20 May 2025 10:40:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] drm/amdgpu: Add locking to amdgpu_ctx_mgr_entity_fini()
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20250519163713.11367-1-tvrtko.ursulin@igalia.com>
 <20250519163713.11367-4-tvrtko.ursulin@igalia.com>
 <71accc22-29d1-47ff-909e-e8eb2bdd528a@amd.com>
 <03033981-c9bd-46ba-8855-06127c95567c@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <03033981-c9bd-46ba-8855-06127c95567c@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:36e::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f30f658-7a80-4939-9a76-08dd9779f2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXZuT05aWjFzRGdjaXd2b1lBMHlzcHNPY3g5M3BOY0hsRmlKY1NoTm9CSGhQ?=
 =?utf-8?B?NXVsSFRMWWRhWEQ1V0VYVldQTzVrRThTOEJkSWZieUN4TzRJWUNKdHZjMlkw?=
 =?utf-8?B?eUplMkQ5V01DclkxVXZjeGw5ck1LdWdlQjdIVk9XN2drZ3dpZ2oySCtrM2ta?=
 =?utf-8?B?OHJzZWtOamZ3YmRnU2VyVWZ6OXE1T0hEREIzeXJMRHZpblpQcXJLcUNCZElH?=
 =?utf-8?B?bHlJcXpkdE15VGEzS2FzRFJuaXVWZ1Buc09EQ2xsZUR4WW9nVzBSU3JTR3pq?=
 =?utf-8?B?dFJUUXdkR2o5ZHhrcUtiZHRxdCtwZ1ZSNTBwa2pTaDN4QTZreXpyb3lRcmNO?=
 =?utf-8?B?eFhpL25zaUJwcS9QVE9Qa2I3dWJwSGNiU3p4TnhTM1NBSHFReWpWSnl2ZWQ3?=
 =?utf-8?B?d0h6b1NTR25yU1BZVU52SHdsMjREdG1meTNSOXE3WWpOOGVUM0lBYUVrQlZl?=
 =?utf-8?B?bVduY0cvMXVWMzFpWTRrY3crczB3VTlIc2JhNWdNdEZmMmVLcFVyZ2JibHUw?=
 =?utf-8?B?VzJmd2ZOalQyRHRZRWFQK0xxWC9md2t1cjJGQ1QvaUdQLzQzbDhhQmYzOUxt?=
 =?utf-8?B?dmhuZjkrZ0ZXQXVtYnd3NUx0dmpzeGNnaDFnWGZJK0JKblM1am40SnFFQVVw?=
 =?utf-8?B?Wk9WM2tFUFdpVGZ3aEJpem1aSmZlc3lid2FTWXh4bU9RUGdkU3A5NTF0QlRB?=
 =?utf-8?B?QWhQc0FwTXZ6eGhWODZldHNBbXUrc2xWanlJTTBRQmtVWm5PNXh5Zk43WjdK?=
 =?utf-8?B?cGFjZ2s0eDArczUxN05seDJySnlPdG5RYXJTUEFDc2tRa3BJMmFjWWkzcTZR?=
 =?utf-8?B?czRtR1pDK1BRUDlEK2FHbGR5czF4MTRlVTlmZmtNb0ZYZFFnb2tnbEFZcHU3?=
 =?utf-8?B?MHA3WTd0TWwvb3RnNmFzcThPT25LWFdCV3grclpIS2JmcVBCb1gxK1RuODJZ?=
 =?utf-8?B?STFiakxSTlh1bWNOblJKS0h0MzRETkVoSXJHc1FoRWZJbzJJUmlVNGVTVVJN?=
 =?utf-8?B?dm5WWDlFUjJmb2xpR0RKZ1FYbFlsbFUrTzRUd3RjeFFXZE9aZiswV2RpRkw1?=
 =?utf-8?B?NEt3RVhCbGJLMktQQ0cxQ2Q2em5Ub1c2THNnY1EzSU5DTUV5WDZLV2FhR2tx?=
 =?utf-8?B?eWc0dUxMeXNxcm9vYTZrOGhUTW83Sk5yUEQ2WStWaGkrRVBxdVNraEI1UDNq?=
 =?utf-8?B?L3VlTGNtcFg2Nm53bmpkOEFoa1RuUUozQVQ2V2E0WHRySjZ0Y3N3ckpCcWwy?=
 =?utf-8?B?NWRJNVlJTzlRN1V5WkNiU1psV1EzQTNoem5mczc4WTNJY1p5dDVLdytPV1hK?=
 =?utf-8?B?T1FwcFZDRVJnNWo0dFdVR0VGeFBhUzdvS2dNaS8vY2JHN1ZlVHJpNWVHbXdB?=
 =?utf-8?B?RjBEOUtJcFhtc2N5bE8rVWpkNllyVFZ6bEdmVm9iSXgxZldpNFdGMWdEeENC?=
 =?utf-8?B?RzltOUE3Z1EySE5TcFRBcy85VVgxSXp3Tmh3anVHV1Noc1Fta2haeGpkanZZ?=
 =?utf-8?B?YXhEZkRRWnBISzl1Tkp3Z1l4WS9ZUElWYUpwVkVVMUZSSk1HMUg1cGNUQW95?=
 =?utf-8?B?cHZTaXZPanV0UWViZCtUdUc0MWFIanJuSkJJYzRmYkEwbmRaU3hSZGMyZUNn?=
 =?utf-8?B?Q0ovdUgwSEc4RWNiblhIdU1xa2RFZS83REI5d00vT3JOUHVtbjdKMjh2YjlX?=
 =?utf-8?B?U2JvRFc5enkxRkM3Y0RlOUF4YzV4RGpham1JdWJZTTBSSTdTUlUyRjNKZTJM?=
 =?utf-8?B?SzloeDE2aFlGYlQzNEVGODlTa2Zia09iZTdJZTAzUjBPVklVRjZicEdGT0Zt?=
 =?utf-8?B?NnlhcXMxLy96eU9NeVRDM1h1Z2E2T1lLanROWDhLQzdCKzNrYWNsTElBNFky?=
 =?utf-8?B?dlRZRkE4eldtYUxVYUFueUp4elZZdWJSZTloR1ZLRzVVRnlaY3pzeldoTlQz?=
 =?utf-8?Q?Xv7q9TSkd7M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZZSlh1ZHpKVXJrTlp2aXJtOFY5Q3VEdG5wSVhxclQ3RW9mSDBiWEJlQSs1?=
 =?utf-8?B?U2VEd3pJaDRMYTAwWjhtbjExbXdVRElEdG5IV2NHTDh3UXVaUUp4N0lwQmtr?=
 =?utf-8?B?QXpuR2V3blc3TFF4UTFXOGlUZVNJdng4dHFzeE4yWlpPRlF5TkxwNnpGUUE4?=
 =?utf-8?B?aGc1UE1DZGU3c0piTnhXZmVBVHBPMVN0Z0xwanQxZUt1cXMzM294NkJhN05B?=
 =?utf-8?B?TXBhdjV3Qmc0Zm5uY040c1V1eVBTYnEwVm9uWDk4eHlGSnpra1RyNXFvNFNt?=
 =?utf-8?B?N216RjN3SmMrMjJkVHlKdTl6d0lPY21GbHVJLzVOWlRoZVEzZ2htOE51UjU4?=
 =?utf-8?B?eFJkZkVncDlUZWtwZFlENmxUNkVRT3NleGhqZFFuWHhFVll4TjVydERWMjRo?=
 =?utf-8?B?YzBSeUNuLzBTaS93VlhKRUMrVGtlQXVtSHB6aW5ZVVVabHFmdzRpcS9CUmNm?=
 =?utf-8?B?eEQ5V3NLWDVZbU9qRWRNUXF0aWVYL09zbVpNZnM0Wk44cDVuQ2swdk0zd0Ey?=
 =?utf-8?B?TjBrU1ZBTzNSdFRSOS9pSnJZMFlCVkI4NDM4aU5WV2NoT1k5bVFhTXhGY1BV?=
 =?utf-8?B?b3dkdm1Pa2FRTU1ZZTRKdWpJcHJBNGFTcnlER29yTVp5YWlXdVRzaTRDQTRa?=
 =?utf-8?B?ZEpQZm9XRnNXb0VmSytONit6YUlkN3ZhYlVSZm1pU3lxUFNSWFgxYklsQmJk?=
 =?utf-8?B?alphd2pTeVRGTUpBcWhmVUFkTk5vNFVnT0VNMWthLzBSdTVmRWRpSGVydkdX?=
 =?utf-8?B?ekFyUFFFc0k4dElxTVNXNHdZNXhyT0EvS0dhby8vQ2lyTEx6YTFKTkVCRy9U?=
 =?utf-8?B?WGo2T3c2UUtSSUM3VExWQTVOWGlaSVF2cEVld3VQUlkvNW12Y3FqcGR0YThU?=
 =?utf-8?B?SmhXRGdHR1NPOTcxdzFGN3BNSVl6TnRNZ3hQQ254TjR2bVVBL0RrQms3cFdp?=
 =?utf-8?B?U2lRTlBUcmVnTmJqQ1R3T2Q4cUIzQ1poZEx5NG00QUV5bGZvVHp0dUo0NXl4?=
 =?utf-8?B?ZFh1QXR1cExpaVNlSzZQWDBFV096YlZvZ1JTa0dKNmdrQ25xUHRQUlhGbDhQ?=
 =?utf-8?B?cjh4TlJEa3crWDMraCtsalNCbmxMWkxFdEM0QzlPeFFRRUN3U1NCeVkwdEJt?=
 =?utf-8?B?NGEvTnE0cE1kTnpyVGtwa0RYek5yb1BGWEVjT0NnZW12NVc0b3VWTTJzSXd4?=
 =?utf-8?B?VEwxbEFHd1lNbVR0Mlp6dTFxeitHR013ZCtWTUYwck9zaEFUaVRjbzJBMnRV?=
 =?utf-8?B?SGpmMEY3c0ZjOFdSbFRRSm4vSnNPM09LcG93ZjlrdWd5cHo4R1FuOWp0Smxu?=
 =?utf-8?B?NHhXNDRzSXFPSis3RllKTG03QnNTa21waTNFcFV3Rk5DUC82UzdFVVc2bGtT?=
 =?utf-8?B?anR6aU92eXlpNnJDWmJpL2sxa2ZsVjZCdzVWWksvRUMyUkMrc3QySmJpbzFS?=
 =?utf-8?B?YmF1WUM1MUkwV0YyeU9CMmpIWWNONDFubTc0OG52LzJmZnFoZDVyNVoyZzZ5?=
 =?utf-8?B?SlVDL0FhZklLa3VnK2VjVlJ4TStHdm9wcWxUQmRtSVYwNnNsVEdkMlRXYW9V?=
 =?utf-8?B?WkIrVnZqS2QxR2VQZ2pxVDZWbjhvTFhHcC8vdWxyMWp5SEJFemRnTGpGTUVE?=
 =?utf-8?B?cjlmRzFjTmpPVm14bUNlRkVzaEQ5aURNclNxa1JkdnFRS1VlTURZVUxFdnRO?=
 =?utf-8?B?anVSUnhQcFZ6b2k5bGR6TmlxTGozKzE5azNHOStlTWorSzRIdUtCc3NsTmJs?=
 =?utf-8?B?UGtlRVladERHTUFDSmhiWmt4SVRQTXd5UUFpa25ySGNzN3ZnRWcxeXo5ZVZQ?=
 =?utf-8?B?bnc2VjhzajA5R0VtNk5oQXBqV2ZBcitqbTh4ajhibkkzeW5PVjZRL2Z0aVBM?=
 =?utf-8?B?WC94cjd0cWNsbzJLZEs5RkVUWHhpRTllOXpYY2VvOFpJUTlrMkR5L1VXc2VJ?=
 =?utf-8?B?QytwMHNOdXdFaUhZcGwvSnhsMjlLMUVNZjJOWWdjOWJuUnRpek9QN3ZOUDBN?=
 =?utf-8?B?Wmx4OVJvNXFqQ2xHdUxTMlNBOVJETHdhaEpWdmxpQUsrN2kzNURLVzNONmJx?=
 =?utf-8?B?bmVxNlVlSVRFWE1FM0JFV1kzaUo4ekR1Qkk0T3ZOZ21LM0Q0SnRVSlFhbFF1?=
 =?utf-8?Q?nRs1G6woxwkZ/62xdKJJo9e0N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f30f658-7a80-4939-9a76-08dd9779f2de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:40:18.0060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAnrFcvC3ElB0LWY+FRfzJPjWWWkMrbtpVxXfa3uINIpRhEw6ZRwcOCbAt0fTWbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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

On 5/20/25 09:50, Tvrtko Ursulin wrote:
> 
> On 20/05/2025 08:39, Christian König wrote:
>> On 5/19/25 18:37, Tvrtko Ursulin wrote:
>>> Amdgpu_ctx_mgr_entity_fini() walks the context IDR unlocked so question is
>>> could it in theory see a stale entry and attempt to destroy the
>>> drm_sched_entity twice?
>>
>> No, when this function is called when the file descriptor is freed up.
>>
>> So there should never ever be any concurrent user of this.
>>
>>> Problem is I have hit this on a KASAN enabled kernel only _once_ and never
>>> since. In that case it reported amdgpu_ctx_ioctl() had freed the entity
>>> already which would mean the question is could we possibly go through the
>>> mutex_unlock() on one CPU, and another CPU to follow immediately with
>>> file->release (DRM postclose) and see the stale entry.
>>
>> Mhm, it would basically mean that the file descriptor can be closed while some IOCTL on it is still ongoing.
> 
> I know, like if the VFS side of things was broken.
> 
>> I think that this would be extremely ugly and should never ever happen in the first place. Adding the mutex just band aids the issue, but not really fixes it.
> 
> So the part I wasn't sure about was not the ->release() running actually in parallel with ->ioctl(), but straight afterwards, but on a different CPU.
> 
> If there is any chance the missing mutex_lock() before the IDR walk could mean a lacking memory barrier, so the entry that was just removed by ->ioctl() is seen in ->release().
> 
>  Thread A        Thread B
>  amdgpu_ctx_ioctl   
>   -> amdgpu_ctx_free
>       mutex_lock
>       idr_remove
>       mutex_unlock
>        fput()        fput()
>             ->release()
>             amdgpu_ctx_mgr_fini               
>              -> amdgpu_ctx_mgr_entity_fini
>                   idr_for_each_entry
>                 stale entry ??? -> BOOM       
> 
> Question is does the mutex_unlock() in Thread A ensures that the write into the IDR array would be seen in Thread B, given no mutex_lock() in the latter.

Oh, good question! I have absolutely no idea.

The mutex_unlock() certainly doesn't provide any memory barrier for the other CPU which does the _fini, but the fput() or the ->release code path might.

As far as I know it is rather common to not lock anything in the destroy path. I will try to double check.

Thanks,
Christian.

> 
> Regards,       
> 
> Tvrtko
>  >> Throwing it out there not to forget about it, since I have manage to
>>> lose the KASAN trace already..
>>
>> If you manage to trigger that again please send it to me ASAP.
>>
>> Thanks,
>> Christian.
>>
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index 85567d0d9545..95b005ed839e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -927,6 +927,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>>         idp = &mgr->ctx_handles;
>>>   +    mutex_lock(&mgr->lock);
>>>       idr_for_each_entry(idp, ctx, id) {
>>>           if (kref_read(&ctx->refcount) != 1) {
>>>               DRM_ERROR("ctx %p is still alive\n", ctx);
>>> @@ -945,6 +946,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>>               }
>>>           }
>>>       }
>>> +    mutex_unlock(&mgr->lock);
>>>   }
>>>     void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>>
> 

