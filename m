Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E5FC87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 18:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791F910E301;
	Wed,  6 Aug 2025 18:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8kZIIqN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483EC10E301
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 18:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHZeJyavha+5q6KQQb+09zsJVE2wKg/Ohl1LDJueaae/COmakoMXSTNNGQ7bMjMYqtMtydbm9gJAkPcooptzzwIH747Y9JWmraC02NuSY7FI4InbzNwJPE4MnIO79pVMCQ2XOffiIlbN6orovMJYuLY/d+spsMSbMlig3AIvGQ/KT+x8OIClA2inZ2XVI/CQA0PKWO84nYE4VQtJ7VwySAe4DmCEiQnbBRkzgZYZkkvOWex1zPe982mdVw0/dNgzkAZqPotVe5QpZE1HAnZPm362QB83BspuZLvFW1WIETN51IQRu/GPkQf2i0trGkZ1rF91gzo0USjx+wsJ0W5SYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vJsm4Lbscz/Po3zJ45NN8xVAzT2ghQocUxztmUTuw0=;
 b=hiGYMIVdH9OrykP3+O/c3qBg7Ev2Wxcauz2j7PMraPuSpNbsmUdQ5GzqfAXEjwMaSlyKxynI5HuDi3Iv1qTwyGy8GVBachtdMw1YpL0/Vu/nqRlOBqAzf2hYR106GBh2BSZRtUgAeKwkze57wd42Pf6T20njYLK0TbuED9fWyRO6mHWdFOqLu5VlJ+4Zirr68j10WfQPs3YegnkMYDoDlxHJRCiDuL3hwaEvgOPPnjP4R9IwJeblMThD6QVCKWapZKRHWOU5JH3UyOYXeqEMnLiguUzJYFUdRxkwM3HiFjzE++2ubcCcyVlUwHtJdVoDd0ft1F6AorhJ1wmmk6smbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vJsm4Lbscz/Po3zJ45NN8xVAzT2ghQocUxztmUTuw0=;
 b=D8kZIIqNlfITK+H5c3YLnSFuPbfmyGwoaoeU66kGXng6K057+jLfUr9JZLgL8jCu7xbaX44b19/CKvNgDkeFNjqPVKTVdq0TZ2SPxvAsc8/fa1pUOkws7yv561JzPeTolVutFta1iAT+tODM83sRG8UAH0CfDg9BNuROhGsRzgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 18:14:02 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44%4]) with mapi id 15.20.8989.015; Wed, 6 Aug 2025
 18:14:02 +0000
Message-ID: <598e36e4-7b96-4f13-8461-1abd650c16da@amd.com>
Date: Wed, 6 Aug 2025 14:13:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type more
 accurately
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
 <fba517c2-2626-41f7-a09d-31fd028e1aa9@amd.com>
 <CAFF-SiUuwwz09Vz90HOTuCcdUt5DXgFLR5EkxWUO1V7uDEOnbA@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CAFF-SiUuwwz09Vz90HOTuCcdUt5DXgFLR5EkxWUO1V7uDEOnbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::17) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: f15d5bf7-66b3-46bf-38b6-08ddd51505cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1F2L1RGS01CK0FTNER3MmJOVFRjYVNoVnZvWE9FazdibHliTFpyZ09vK3A2?=
 =?utf-8?B?djBUdUlTRGo3bVk1KzRKQUJ6WEhCcEMvQzQzQllReFBDMERqelR6U2ZocVhQ?=
 =?utf-8?B?WjBCRUtvRlBKUEt2cHpoeFpqNlJscUd4eHMrWmp2cFpxK2c4WnRaYnVHWmZG?=
 =?utf-8?B?OHllT0tXSzYxN21IS3hUMUtiUzJEajhUa1MyV0Vrd1c2TEpyaHA5cDJQL01M?=
 =?utf-8?B?Uk9nOExHQVFxeGI5WDBDU0kvZHdiSlFibTdISkUvMm52ZldTT2ZSUVhyOXla?=
 =?utf-8?B?V0NPbHlOdU9GSkN0VlovK0lOSzRyVm9CV0lyV3dmWlZnUktqU3NlcGZFU05t?=
 =?utf-8?B?Y0FIY2I5NXA2T3gzRVllUmhWTkVrV01jY2VpOVcxeVFMOXNCZ0hNUDg1YXJX?=
 =?utf-8?B?V20wNVJvT2ZrQitwZDdQRVplOEl0dkUwcmlOMGdwamlIMWRBTmxXN01hVGhI?=
 =?utf-8?B?MWpOcWlNTzRGdnFRQjJRTnozMVhRejUvOFFDN1haVW9XNG1KcDNiTUswTHBM?=
 =?utf-8?B?SWNVeXBHbnRsaFQrWDd5V01BWEg2QUZqd0hGRThZVkFoMGNkalB5L0lvSXdJ?=
 =?utf-8?B?Q05BdjVlRGVtWkhtZEhCSTdlZEdVUzBoMzhJWVN2bnZTOStmK09vUXBXSjli?=
 =?utf-8?B?Y3d6Qzh6bmpCSU5zbEk1dThBd0srWFZROWo3eHI3UHNXQktENU5RK0xTQUwx?=
 =?utf-8?B?V2RMekZRbGNXWERsS3B1WnQwUWF1Q2JlNnlnS3BlVGdqVk95M05hbnRBUWti?=
 =?utf-8?B?NjcvWUQ5RUV6enlNTnEwWnI1K3F4TXE1YWJQTTdSdmJkMUJGR2FReDZwWTdq?=
 =?utf-8?B?Y2oxa2VEUmdOM0ZJcDNPc1lhSDNIc0J3NTU3aDJlUVFEYXhJNWNSTDNjMmo1?=
 =?utf-8?B?SzdJbTQ0a1lRb2gzL1RBL3BvNzVkNEJBYnJzVGQwZmoxaml0aXhLQjk0VWRC?=
 =?utf-8?B?RTZUbnRCNG5KQ1R5blozd0VHT29mamJ0U3JaWGEza3ZMY25FVGRhNlpFRTlO?=
 =?utf-8?B?NkU2TUZwRHJidU5acWxmY3lvSmhYUmNpNlI4ZEp6bzNYQ0ErYk9jeEdjU2wy?=
 =?utf-8?B?Y2ZGbCt2SlpNVElPSW10ZHF5UGljT1V0L0ZIejNYamlpKzl1MzRTSkFQeHBW?=
 =?utf-8?B?SjNYWU1jZTdlWDlselRDM2hJSVExclJnTjhIK1JDQTQwM2hmNFBKRGpzZDBL?=
 =?utf-8?B?elN0MkN2OVFpaWhXbkREb05hTVBYaG5RK2dWZXFRMUc2aU80RXFxdzRKZXY0?=
 =?utf-8?B?U0lFWENkMVlKWkxlQ0poNEFBMHI5RjR0LzZuZDd2M29zVnhFWEFONHdWWUcx?=
 =?utf-8?B?R2k0a3RUMWp2MEs5Y3IvSnlhaU9vZWRFblNNWmVtL2l6MHRtK09paVVsY1hZ?=
 =?utf-8?B?YVBoVlhlRGw5NDBTMXlFeXR3L0x2YWRqZ3F2a2U3R2RSV1NWenl1VnpZSU9r?=
 =?utf-8?B?WWlrRkdvTHNleVVaMUZHa3I4ZVhuRXMyWkFZL2pHcGtzOVhESWZBWnY1OGdo?=
 =?utf-8?B?RWROQ2ZoWUxGMmFidjdtWW1ZcSt3QXgweStoSHJ6ZEYrVTVFd2xnaTMyeExy?=
 =?utf-8?B?aHFPWmFOR09HMVBleUpXdFRocmFUclBZekdhbHRwQzVySlkycFBvU203ZHRn?=
 =?utf-8?B?b3M5ZHZkWmFCKzVyUmZMeW5XMWNwZXNLdXJOQ0dicVhabE9oQTMwT0UrUmw2?=
 =?utf-8?B?V1hIVE12VlJQSENKVWFXdm9rS21CQXd3SmYrWVdiWHFoalVvdDZBSkFFKzlu?=
 =?utf-8?B?YVBrUWlNMmRyL0wycHFPL2V0SzhxMG9yd2oyL0hjSmR4QkJxeDRKVmJFSThs?=
 =?utf-8?Q?w22e73z1nlegq5WymDddIGyMusSYSJB3UVNx0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0Rka0k3Yi82S2ZQVWpmZ2x6c0M4azk0cTUrS3ZWbmxvZWJaL244Q3hOWDBo?=
 =?utf-8?B?STVHclFZUHV1WEZLUG9CVGJIVVgrY1E0a2dPcUU3VFJ0UnF6MzBhYjUwdS9B?=
 =?utf-8?B?QTNoaTFDMXFueDFmdU5YbmZBR2J0U0RvMmJRTzJiMmdqekhHeFpSRTUrVkJz?=
 =?utf-8?B?c3lOaTEzOFZwcWQ5NHFaU0JNaUJwMm1WSVFsMmJqY2xyUTlUdU1TOFlGbkpF?=
 =?utf-8?B?K2xxMGg1NEFMMmRiazcxR3dLOFc4RDExU3hLYmZRRTA1ZTE0aFB3b0pVNThF?=
 =?utf-8?B?UWNES3NtUmVJMmxrdm1xY3p5L3BMNitEV0RlZHdSQVNDdjZieWZ2K2gyMk5F?=
 =?utf-8?B?YWJFY1FtbjJtWTFXeVB5OUFjRWNOREFNL2VuQjY2U01qZU1GRTlVT3NETHZD?=
 =?utf-8?B?S0tWTjhHZVdobVdjaTVFb1JXcVBqZXBxZVJWLzViTnNONTQ4eHhSTnBQbEtk?=
 =?utf-8?B?RTkreFN0SHExd0VsdHVLNEsxTWxuWkF3NnFYTDVNanRqVGU1Und0ZUJLTHcz?=
 =?utf-8?B?ZzhNd1dUZmFhby9NV01nYnR5QytVZE91U3dydTNRRnJwRW1UM2V2ZXNQNmJa?=
 =?utf-8?B?blJPR1VVMUpuK2R5QUdHY0JqQnBIK0NwaDZldnoyZC9XMEJyVWJUY0V1cERN?=
 =?utf-8?B?L0ttQzR3Rnl1NmprUlRvNUlUVmVncEY0RE8rZFR3SStPdkZMVHlQQVRXRDJh?=
 =?utf-8?B?ajcvRk8wMGNFRUNUVlJ2enFTNXFzajFtQlFIcW8rb2NySkdHcjRMbUZjMS9X?=
 =?utf-8?B?ZVdac3NNditkNlZhUm5HTVFRdytwNm5xeVRsZGQ4am5qWGhVU1ZTOUNnOEM1?=
 =?utf-8?B?dXp3dFZzRjhtaHBZUXlHd2hzNXdXWE0yL21GNWRmOWdDMGE5Uk8rYUZBQ1ZK?=
 =?utf-8?B?YWFyUmpSQ3BUczA0TVJkbE15Q3lQdDFOOXJRdDJuSWVVZDdvbmFnelhmemhZ?=
 =?utf-8?B?WGVVWER5M09RRi83MXg0Sk5kSFJTQnFKOE4vdkRKVW1NWXRhU1RHZGZGSVU2?=
 =?utf-8?B?K1RtYmwzbjRBcmlqNjM3SnJiQ2dqcFU1dmxXdjJkc09uS2RyUHpnSVRHOG5D?=
 =?utf-8?B?bmwvemwxcWpQQkJIZjZzMnppcGZqMmdyTnJNOFNXVEc1RThLek1LcjVvMUl5?=
 =?utf-8?B?NGJ0d3BsWUN4TmJSMytFUGFOUDgrQXdPZ3dobVA2UTlnTXpKcVV4K2hjTTYr?=
 =?utf-8?B?SHpuMWhtWng3Z1FjQnA1RXl6bWVnczc4NHVMcmVqbjA4bEtSZjRKT2k4MmJ5?=
 =?utf-8?B?MGg3WXY5SklRZXpXSmxrOXBYWnJ4TVdUdk9Fc1o5YmtTSUU3NFdQRnIxOUVx?=
 =?utf-8?B?b2NOQnZXZUMzTi84ekw2THZ2dEJJdExpWWFzV1RCdElqWjFrNzIvLzB3MVNG?=
 =?utf-8?B?SFFhMnBUWnFKaGp4WFliMDN6WmZncStRNlBiRi9rdTlUYjhxRE82dnV3YXNs?=
 =?utf-8?B?T1Z6M25IeStqYTdscm9PdThoeURhTXlwM2w0dzZ0VXVjTnF6cjlCSmtpMFR5?=
 =?utf-8?B?NDh4VUFYMUxxOWZONW5hN0o1aCtwZ2IxTGluSSsxSXRMaDlNRGhPMGtqRVdz?=
 =?utf-8?B?bXZkeTA1WUZNZDE1cEZHRFkxUjQxTUlYbVVicmdTdjcyaGdtNGczV2doQWRS?=
 =?utf-8?B?MUJhZ3o3WUwwSUVwNmpOcEVhRDBpa2VZRW9iY2Jvc250Zk5nQ0JERldYMnk3?=
 =?utf-8?B?YWFvVkJVbDZKZDNGdjRkc2s0bVdycmluTXhtaFNEeUtBUUplTW9kdDdxanV4?=
 =?utf-8?B?U3E0Q2RtZUl2eW5CTTNPK3VSdGZYZ284MHhBUWIrRGs5WFIzczFwWERuQ3Vl?=
 =?utf-8?B?UXhtM3dDREVXQlY2N053SG81aEZaRURxYk9QdFh2ZlBBMFVoR2hDTEE2cmo2?=
 =?utf-8?B?anYvWmpDcWkxaDh6czZiYlIvR3NXQk9RNlpXOThCRnNLOW1QVjZJdFJmeWN6?=
 =?utf-8?B?YlR2TGI1WEN4M2ZsaXBXU29wbjk1YUNPNW5kREVnZ1dKTXlTVFFlY0ViTjN5?=
 =?utf-8?B?Y1EwamcxdzN4SzFoOTlpcFB5Sythd3pBV1dKMnJYNzkvWXFMQmdPRnZZdHRa?=
 =?utf-8?B?Wm4xUzlnV1pZZE50UHVGODUvZXFqWW44bXI5VDlWSmJuMHBCYXVTZzloRGxI?=
 =?utf-8?Q?ZKXYXdSFPwZTtZVbc/aTK7kOC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15d5bf7-66b3-46bf-38b6-08ddd51505cc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:14:02.6216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJHi+z5HNSdbBLCSf2LlXjz5hjTULtsYvCuY7gJrJb7zbWWJfH/yUCyikzyJKixsPg03il3TTzBpJqspanSdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
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



On 2025-08-06 13:45, Timur Kristóf wrote:
> 
> Harry Wentland <harry.wentland@amd.com <mailto:harry.wentland@amd.com>> ezt írta (időpont: 2025. aug. 6., Sze 16:56):
> 
>     On 2025-07-23 11:57, Timur Kristóf wrote:
>     > Previously, DC determined the DRM connector type based on the
>     > signal type, which becomes problematic when a connector may
>     > support different signal types, such as DVI-I.
>     >
>     > With this patch, it is now determined according to the actual
>     > connector type in DC, meaning it can now distinguish between
>     > DVI-D and DVI-I connectors.
>     >
>     > A subsequent commit will enable polling for these connectors.
>     >
> 
>     Hi Timur,
> 
>     this patch regresses the kms_bw IGT test with Navi 31 and 48
>     with a single 4k60 DP display connected. These subtests fail
>     when they should pass:
> 
>     linear-tiling-2-displays-1920x1080p
>     linear-tiling-2-displays-2160x1440p
>     linear-tiling-2-displays-2560x1440p
>     linear-tiling-2-displays-3840x2160p
>     linear-tiling-3-displays-1920x1080p
>     linear-tiling-3-displays-2160x1440p
>     linear-tiling-3-displays-2560x1440p
>     linear-tiling-3-displays-3840x2160p
>     linear-tiling-4-displays-1920x1080p
>     linear-tiling-4-displays-2160x1440p
>     linear-tiling-4-displays-2560x1440p
>     linear-tiling-4-displays-3840x2160p
> 
>     We confirmed with a revert of this patch.
> 
>     Harry
> 
> 
> Hi Harry,
> 
> Also, can you please help me figure out how do I reproduce this on my own?
> 

- Build IGT using the guide at https://gitlab.freedesktop.org/drm/igt-gpu-tools
  (it's really just meson and ninja)
- Switch to a free VT (e.g., Ctrl+Alt+F3)
- log in as root
- run the test tests/kms_bw
  (optionally use --list-subtests to list subtests, and
   --run-subtest <subtestname> to run a subtest)

> At the moment I don't see what is there that would make a difference to Navi 31 or 48.
> 

Not sure either. But that's why we have these tests because
they often catch things that aren't obvious.

Harry

> Thanks,
> Timur
> 
> 
> 
>     > Signed-off-by: Timur Kristóf <timur.kristof@gmail.com <mailto:timur.kristof@gmail.com>>
>     > ---
>     >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++--------
>     >  1 file changed, 16 insertions(+), 12 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     > index 096b23ad4845..c347b232ae06 100644
>     > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     > @@ -8038,24 +8038,26 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
>     >       return 0;
>     >  }
>     > 
>     > -static int to_drm_connector_type(enum signal_type st)
>     > +static int to_drm_connector_type(uint32_t connector_id)
>     >  {
>     > -     switch (st) {
>     > -     case SIGNAL_TYPE_HDMI_TYPE_A:
>     > +     switch (connector_id) {
>     > +     case CONNECTOR_ID_HDMI_TYPE_A:
>     >               return DRM_MODE_CONNECTOR_HDMIA;
>     > -     case SIGNAL_TYPE_EDP:
>     > +     case CONNECTOR_ID_EDP:
>     >               return DRM_MODE_CONNECTOR_eDP;
>     > -     case SIGNAL_TYPE_LVDS:
>     > +     case CONNECTOR_ID_LVDS:
>     >               return DRM_MODE_CONNECTOR_LVDS;
>     > -     case SIGNAL_TYPE_RGB:
>     > +     case CONNECTOR_ID_VGA:
>     >               return DRM_MODE_CONNECTOR_VGA;
>     > -     case SIGNAL_TYPE_DISPLAY_PORT:
>     > -     case SIGNAL_TYPE_DISPLAY_PORT_MST:
>     > +     case CONNECTOR_ID_DISPLAY_PORT:
>     >               return DRM_MODE_CONNECTOR_DisplayPort;
>     > -     case SIGNAL_TYPE_DVI_DUAL_LINK:
>     > -     case SIGNAL_TYPE_DVI_SINGLE_LINK:
>     > +     case CONNECTOR_ID_SINGLE_LINK_DVID:
>     > +     case CONNECTOR_ID_DUAL_LINK_DVID:
>     >               return DRM_MODE_CONNECTOR_DVID;
>     > -     case SIGNAL_TYPE_VIRTUAL:
>     > +     case CONNECTOR_ID_SINGLE_LINK_DVII:
>     > +     case CONNECTOR_ID_DUAL_LINK_DVII:
>     > +             return DRM_MODE_CONNECTOR_DVII;
>     > +     case CONNECTOR_ID_VIRTUAL:
>     >               return DRM_MODE_CONNECTOR_VIRTUAL;
>     > 
>     >       default:
>     > @@ -8440,6 +8442,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>     >                       link->link_enc->features.dp_ycbcr420_supported ? true : false;
>     >               break;
>     >       case DRM_MODE_CONNECTOR_DVID:
>     > +     case DRM_MODE_CONNECTOR_DVII:
>     > +     case DRM_MODE_CONNECTOR_VGA:
>     >               aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
>     >               break;
>     >       default:
>     > @@ -8631,7 +8635,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>     >               goto out_free;
>     >       }
>     > 
>     > -     connector_type = to_drm_connector_type(link->connector_signal);
>     > +     connector_type = to_drm_connector_type(link->link_id.id <http://link_id.id>);
>     > 
>     >       res = drm_connector_init_with_ddc(
>     >                       dm->ddev,
> 

