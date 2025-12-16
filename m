Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F05D637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 20:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CCA10E654;
	Tue, 16 Dec 2025 20:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GRer8WEB";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532A910E654
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 20:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLyVcIBJluwimYPsw2tRnX1y7oRhuOhNQkoqN+fkm4a2+VcQRRSM/rYgReKHspOolwNKcv+8xaELEU3Pc58ghnbYt/NDY/AWLIZj63JLaO65enPkxwvCl/LI+kDKVq1HK0GTPPe/AvlgJmvj4Fi+UnIuV1JL0byQ+LUOa/Wtp+UUJko4JM1rbAgHjjQS+BTV1gfYHO7/zz3WrM4jVaZV6bdmqLHk01ibwyvfO0w/8dMRFQP+eU7CyflkURoRQLLT0gRi5zf/vXsg52IRRkmgxexZOewpRXX7GIQunPMUhUlRAkscwBkBwH6bi7uZCu6hOqzFA3R+Ihqw5DmgB/e7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBIZZpIQ7phu5voCHhp4wkJkXXmoXtx9xloJAA7zDHw=;
 b=o6y6h/s+tvXxUS3KvQ0vLHHkJXBbMDYgo6ktNylca3WR1fuS7HpL361j0g5EEmLRp0+az5jteo9Cnz+RMHU12eoWY8ftp3T14L5tcrcsznYLe/czNQLB8LvdBrv/0XdKzwxID+PX1cnJE97h2zm/qifxcNWLE2YM2NAGC1pgfFtWPmdDK3WkH8uGgSGmweUaXBHccndpJLJlZdwxNabFEqwpipL/8pVRnif+hHnPfzf74jnlXnQzIj/4K3BYqVpyvrMg6P1ZvL0RMT8Ykafys6zGZ3HQSe8qLybzfhSx7c2xgC6f2qV7cyt47i8IxRh51iNW8ihuFtivLUviheg5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBIZZpIQ7phu5voCHhp4wkJkXXmoXtx9xloJAA7zDHw=;
 b=GRer8WEB7366exTIs0Jvq/KWqa9yC94J0DfxGAv/frE/lkY53WnXgHyEOKoVq3uF+Jaf6ESE353v45BL5I0fBQJwwwOpmU/8IwhnRZ2vEVyLw9l1YWu6WxHRy9U3PKXHLwVZe+fxOqXjvzogNvWPcSr8U+LMb/weU7GyyGmplU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 20:53:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 20:53:38 +0000
Message-ID: <1bb947a6-a5c9-4d49-8025-a15bec9e6aea@amd.com>
Date: Tue, 16 Dec 2025 14:53:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add support for GC IP version 11.5.4
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tim Huang <tim.huang@amd.com>
References: <20251216194537.1872842-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251216194537.1872842-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:610:4c::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b236a7d-37a5-4dbb-7cd9-08de3ce53034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGRiRUx1WFd1LzlFS2Y4UnRPU3cxUWhtUC8xcWo2eER6VTVNTlFTZnV6blVw?=
 =?utf-8?B?VlV0TmJScHVzR3FVMXdiZXZOUm9kR1hnVVRtUmdpMENYbm5qSmkzOUVSdFUv?=
 =?utf-8?B?SzZOVFJ1VFRnNHhhNjQzQkFiZHRLZTRXbDBvNUJXNGJGODZZNmRsbm93U2pN?=
 =?utf-8?B?TFE2clM3cjZ0YWhZallTcXNkczBjV3NQM3JrSWRCaUF5djV0ZUZpaU5UUFky?=
 =?utf-8?B?RFIwcHk1OGxKcmVFR3dPaW9hRW5DY3c1WlNGZGFjK0gvQ21pa1JhNmlFWjgr?=
 =?utf-8?B?UHhCMDdUajhaaloxUEx4cDRBWjdFbUw2YjV2TGNhb3hpekZ2ci95Vm11RHpy?=
 =?utf-8?B?TGp4NEJVcDVKejd2czVVSUlTUzlEdE8zRGg3Q3dCb3d5K2svVG5vWHFVa2Vk?=
 =?utf-8?B?Ylhkai8zYXcvQWRXemgvK0g1NUZGeVRIbWFubVBtS0tORkNpNUJPd0ZGTTRa?=
 =?utf-8?B?NEdoVHJCbVE1NkZHKzJlYy8xYTViUjMyQjd2UndjR2xiTzMxRklac1FkSkY1?=
 =?utf-8?B?aTRjNGpTTGVBMXBJMkxYR1FUK0hTU21xdnFvbVZkZlVzZUUrVUZFZUJYM0w1?=
 =?utf-8?B?a3c0cllYZ3ZiSGp2N1dXLzNIU1ZabExUMGs0UnFVa09CWmJBN01nMnNvRk9M?=
 =?utf-8?B?MGl6VVQ1WWJoOWxqU2tVVEw3Z29DYXk2Z3hMNkdMTW1iTzJZSGM1Vk5zSWRI?=
 =?utf-8?B?cGFwdSs4VXZSNU12a1p5VHdGdzNGU3c0V2RhNFJtVlFBQUI2NWtpa3RqaVpo?=
 =?utf-8?B?MjNxMkpJY2VWK2ErN0I4NnZZRjN6ZmwzeTVvZG5WZm1zTXdIV2EzRGRaMjI3?=
 =?utf-8?B?eHg5VG0zRWtXYlhuRm1TbWJKZnpjTXFXYVF6emJpeURjbmdPMm5OUFNLV1Ry?=
 =?utf-8?B?MmJVL2RuSEVPak93cW9seEg2OTNsVU53TzRGNGlpTUVML3hMWko3by9PVVIy?=
 =?utf-8?B?OUh0cU1MZFd2OE8rQTFHK0VUOW1RQlBXU1JvaER2T2V5TnJqQlhDbDFPajhn?=
 =?utf-8?B?RGZsaUU1eFJoUmZLcWhMSzZrNTNUdnhmOGRGWWxJalJFQVFMbUl6M0U5cVdT?=
 =?utf-8?B?MnkyeERVcUhiL0xnVUVuSDNvaVl2aW9nc1ZRRnFnb2hqSll2WGZnVlY0MXN2?=
 =?utf-8?B?K05BN1QwOGZzWjFsTmpJNWt1TWw1REs1eCtja1B5NEsrR0xhTVliUnU5TmJP?=
 =?utf-8?B?OFYxek5FWFRONytPd01HcGRYeTN0OXlkOTlTTGFlRWdZOHdiYU1aeG85bHN0?=
 =?utf-8?B?ZUJTaXo1QVRWZk1KT0ZiYWtpRzBuaXc5VGtQWjIxSk9qMWgxZ3dySDVYclU5?=
 =?utf-8?B?cGd3dGQ3bFhFckVuRExUMDlONDZERml2MlprZ3dhTXIyandxR1BhUkRkT0dV?=
 =?utf-8?B?c1pHN2hVcVJuek1QaFEyd3d2UmtHdGpzRHFzUWwvTFp1eTZ5TmZJRzVrQnVh?=
 =?utf-8?B?V0VpbnAreVI0UWZaZ3drUC9HbFZyV1pPa1VIMXVNbmhCZWR3TWdNcFEybmZK?=
 =?utf-8?B?cWxsOGx0ZTBrcFkwbzBFZmlzeWZpL3RtTlZPaWNvd0pkYm9TNjNYT1FBZDFO?=
 =?utf-8?B?WWdyTHM2N2FCZkpnV3lwblFQNC91Y1JVTmN0OVB4UC9lNE80NHl6VC8xM1Ri?=
 =?utf-8?B?cUgyZFZsb0N6dFVBUUtocHRzODliT25CekEyU0kzSFFoY0hiUlo0WlRtTjBZ?=
 =?utf-8?B?ZUE3b2dDKzBabmZ5ZjhKZGR1NFlSUEc0Skh2ZTRFTGFaenRNUEVIWURvN3ZX?=
 =?utf-8?B?VHVoRUl6NHE5a292WXU2QkNzR1hHejVFSTg2R3BtNXhXcEtLM0l2OUYzUnlP?=
 =?utf-8?B?MTVVOEtxVE1TU1NsejU4c1pnZjNDTm9mNW8wTG1RNW1QelB3Z2E3YXJXeXBo?=
 =?utf-8?B?WnNQK2p0OXE2Mjk3SkZkU3pyWTc5UFE4UXNvWWZpc0NnUUF6Qmw0akYxT3Fa?=
 =?utf-8?Q?t17a8zuMG8y5NF+NHZN4EZDgLLkgW64Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDIwTmpENVRha3c5dVpKclpCYXBZdFRxQlJtVnZHbFNUVWM1aUlhNDY0Sjc4?=
 =?utf-8?B?VnVkc0RUbXNFN1c5a29uU0N0OTNSbEZnOUtuKzJGUE5TYWdFTnZqSG9RdHYv?=
 =?utf-8?B?bXJrNHE1MWtFdktKU1lab1VRM093YlBxL094SGRvMDNsdmpYbHFBMjhON3Fl?=
 =?utf-8?B?VzFPbjVDK3pRSW9kVUxaMm1aMkd3c2YxWXBtTURjaVd1N3Jzdk1mRU1oczAw?=
 =?utf-8?B?dGxIb3RRMUpVR0xwVVhmTGJ5RHFGUW1aS0IycmNDNlhITzZnd1pVSzlOZ0xQ?=
 =?utf-8?B?cnpJQzliTTJucGZFMzdKdm1HVFVKaXhqbzdzcnBOZ1dMTDFEcDdRUytscWN6?=
 =?utf-8?B?U3JMMzJLYldBSVR3OTJKc2RRM3RYd3VxTGo3cDNVQjZPR215d1hpQ045ZWFC?=
 =?utf-8?B?Uzhkc05wdVRNWFVlNkh6ditZNG5MTmVYTDNYYytYa0VCUUFNeTluT3FybDMx?=
 =?utf-8?B?OU1sTGdGcFdLK2ZUaWNTcHZEZzRiQVl3NitmY1BCZC9ra1l3ekxVcXUvMDYw?=
 =?utf-8?B?ZlNHNzNRUkkremkyMmpybEI0a29rUndVSE14SkRsZzBleG9QOFo0SUx3YmZx?=
 =?utf-8?B?QmFxd0U1RmlVd1o2bEp1TGhnbmx2V0NvUjQwK0VtakdnR1ErL0xrZEoxM2t4?=
 =?utf-8?B?V1lMZU0xemo2Mm90WUVjOFZsa1preHVMZEZudFBoVHNES0w3Um14T08rY3Nu?=
 =?utf-8?B?cVFseHkveEVxbGE4eUpLNEsva2dIVVYxYjNFd2VFMmxFMERORSttYnZaQTFE?=
 =?utf-8?B?OVN2b1c4Q0FLVzJCdlEwREFncGdqNml3RkdybXEwRDlGNDlpYXpmTWgyV2N2?=
 =?utf-8?B?NzRiR2pPS1pUQTBNeFIwMjZvWm91UFZuakRSWU16Q2xvN1FrNXdlSzRvK29G?=
 =?utf-8?B?bitwK0tWazh6SDM4SEEzOHZ1WkFHaVUrazd6KzZuRTU2OGs3Wmw4SDE2eE9a?=
 =?utf-8?B?UzF5YnJrNVlxcjN0M1c4UWl5cHFKaFdjQXgzSWVTTUNvVHgyZERoSGUxZ0l6?=
 =?utf-8?B?eDY4Yjdvb0tqZldBYmlHUUdqeTlUaE5LM0xPQnAwMnlFdWd1YXRGWVJtbVBO?=
 =?utf-8?B?N29oamNrMzE0eUJrWHRPSFhYMTJJT3hnMDFjNk1tMTNhdHk3V0lEdGxsWDk0?=
 =?utf-8?B?b1pldFpCaWxpME9uYWpKWWU2bUs3YnZaK0hya3FLTVlKQ0NRZ1FPejVqdnlo?=
 =?utf-8?B?cXVqWlBTalFoMTQzN0l0em9vV1Ezck12VkNSNHVFZzdja3RSdDdaTmRhZkVr?=
 =?utf-8?B?MWVpWEJCblhOWlFxcmttMjFSWTk3SnJqZ1JndUhweERaK1pCT1AzYmRDeXVN?=
 =?utf-8?B?VGx1SEFlZU1MbEZQajRoU0hGZnZZZURvSHo3YTZRa2VEdTVuZTVNYTlOTHR2?=
 =?utf-8?B?U2dSUmdReHJQYzg5Yk9mSU84TVlQelFzTW1hckpYMzVNU0JIYXJBMm9mMlNF?=
 =?utf-8?B?V3RFUjdKZEl4K2s4bHppN3l4OEtQMWYyT3JwSnozZzB5Y2pEQThtdHhnMWR4?=
 =?utf-8?B?UVJvQVlHU2RRSmUxdEptNUdpNVFRdVhCQjZ4aTVnTkIzanl6R1A5MlJvaVBQ?=
 =?utf-8?B?bjR3LzUwVk1NUDgrMlA2ZmtpcWNMa2dXZjJQUGIrd2R2YkFIRjd1cC91dms4?=
 =?utf-8?B?UytiMVA0TlR0cFZFR0F4OVEvOVl2Z0ovWnBmS0ttc2VsbWpaVUxiMGpIcFpk?=
 =?utf-8?B?Qm5tbC93d1hQVHBuaG8xNzI4NXBpMkY2YmRSdlVKaC9nNXRPOVNVZDhpbG5v?=
 =?utf-8?B?S1ZZOVJ0M2NCS2tqZ0J5YllDWEx1Rm1CdWVTQUFwN2YyYUphOXl6eWFjRWlk?=
 =?utf-8?B?dWw4Y0ordVhiMnVaK3FFU29tcTV3Vzd4RVV1WmNoNlBEbTRkMVlWMi95WmM2?=
 =?utf-8?B?dGo3bE11RE9VMVUybG1NQ1NOYWhPUzRUOWpnTys4MjB3b0lpL0tXaVZodjEz?=
 =?utf-8?B?Z0tzbi9VMUVSRWkrSDBVc29TUE0vZnlqeVp3bkwvckFaRDZsSlZHdVJmNERt?=
 =?utf-8?B?bE5aaC90MmlJTGRLVlR2UjU3WVIxWWtPdmhnMTl5NDV4eW00bndieDI2ai9V?=
 =?utf-8?B?MlpMTVFsZlI5UXNURzdTWFZsUXNEclp2WVBvQU1IVHh6TDhnbkk4eFI5OUdi?=
 =?utf-8?Q?9sYMBNVHpauiYNjh6UZndov1D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b236a7d-37a5-4dbb-7cd9-08de3ce53034
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 20:53:38.8797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Vm8oKqafBHMj6XmOByMBv9UDdyGmcqoZbqiL3vn8Gw+YUaY71GV/jTDMEyxBsTo7gM4csvDHlAC8HXNu88JcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
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



On 12/16/2025 1:45 PM, Alex Deucher wrote:
> From: Tim Huang <tim.huang@amd.com>
> 
> This initializes GC IP version 11.5.4.
> 
> v2: squash in RLC offset fix
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  5 +++++
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 +++++
>   9 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 20d05a3e4516e..116cb437c81bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1988,6 +1988,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2047,6 +2048,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2358,6 +2360,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2559,6 +2562,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
>   		adev->enable_mes = true;
>   		adev->enable_mes_kiq = true;
> @@ -2961,6 +2965,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->family = AMDGPU_FAMILY_GC_11_5_0;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2988,6 +2993,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->flags |= AMD_IS_APU;
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index cd4acc6adc9e1..48605e41cfb94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -949,6 +949,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		/* Don't enable it by default yet.
>   		 */
>   		if (amdgpu_tmz < 1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 79a6977d56b0e..0e5b255eeda40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -120,6 +120,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_pfp.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_rlc.bin");
>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> @@ -1113,6 +1117,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->gfx.config.max_hw_contexts = 8;
>   		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
>   		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
> @@ -1595,6 +1600,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->gfx.me.num_me = 1;
>   		adev->gfx.me.num_pipe_per_me = 1;
>   		adev->gfx.me.num_queue_per_pipe = 2;
> @@ -3052,7 +3058,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 0) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1) ||
>   		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2) ||
> -		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3))
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
> +		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4))
>   			bootload_status = RREG32_SOC15(GC, 0,
>   					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
>   		else
> @@ -5640,6 +5647,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
>   		case IP_VERSION(11, 5, 1):
>   		case IP_VERSION(11, 5, 2):
>   		case IP_VERSION(11, 5, 3):
> +	        case IP_VERSION(11, 5, 4):
>   			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
>   			break;
>   		default:
> @@ -5678,6 +5686,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		if (!enable)
>   			amdgpu_gfx_off_ctrl(adev, false);
>   
> @@ -5712,6 +5721,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   	        gfx_v11_0_update_gfx_clock_gating(adev,
>   	                        state ==  AMD_CG_STATE_GATE);
>   	        break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 7a1f0742754a6..ad5e512e3fb8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -602,6 +602,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
>   		break;
>   	default:
> @@ -778,6 +779,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>   		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
>   		/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index cc626036ed9c3..46d25d55ebbeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -41,6 +41,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>   
>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 5159f4a9787ca..f8678a7bec93c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>   
>   static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 55c3781fc7304..99c4db3b2a232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -799,6 +799,11 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   			AMD_PG_SUPPORT_GFX_PG;
>   		adev->external_rev_id = adev->rev_id + 0x50;
>   		break;
> +	case IP_VERSION(11, 5, 4):
> +               adev->cg_flags = 0;
> +               adev->pg_flags = 0;
> +               adev->external_rev_id = adev->rev_id + 0x1;
> +               break;
>   	default:
>   		/* FIXME: not supported yet */
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 5f2dd378936ed..36ffc3c785367 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1705,6 +1705,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
>   		case IP_VERSION(11, 5, 1):
>   		case IP_VERSION(11, 5, 2):
>   		case IP_VERSION(11, 5, 3):
> +		case IP_VERSION(11, 5, 4):
>   			/* Cacheline size not available in IP discovery for gc11.
>   			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
>   			 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b91843b2af6a6..01e5b3416716f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -164,6 +164,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> +	case IP_VERSION(11, 5, 4):
>   		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -441,6 +442,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   			gfx_target_version = 110503;
>   			f2g = &gfx_v11_kfd2kgd;
>   			break;
> +		case IP_VERSION(11, 5, 4):
> +                        gfx_target_version = 110504;
> +                        f2g = &gfx_v11_kfd2kgd;
> +                        break;
>   		case IP_VERSION(12, 0, 0):
>   			gfx_target_version = 120000;
>   			f2g = &gfx_v12_kfd2kgd;

