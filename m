Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0498CAC589
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 08:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE5D10E237;
	Tue,  9 Sep 2025 08:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TNd6zCqr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7866310E237
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 08:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRIEjAVTIr0ka9QZbDa3LfdmMWIv0NyHL2Fhskpt1FVgCL0ggL9JsTgJoeTfUGJkXClUz5XcXrs7Do9YBaHrbOgWlZ31Z24TZWN68LhpZwx0uW/aHqepsHn0Z0u09aD44VLwI4Dg+O/XdUXmbaqySqg4B3aDpw683+zy7v5zBv06ZzHztHhtqUC9oR1cWjQzWzx5NEnsNokZ1YN8YIiZpnHfamc8H2H2JKLYtQbvlatFEdh9T6/2U4fREOFNmCb9fmuTYmCL37xk7bPwI7ppQI186w80WxQjGE6MVEvY9fHVPbcwy0RTe0Eee/ixVZ1Zb0GpSyXiHDbHvfYlqMpNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sBZxq1qBw0YVifCYsPK5O4YSXJgN0FrxWSx9zWVuU0=;
 b=J7LKjvA2nk80rvLmFxtCXixG0BPohRUydEjF9mi/rW7yiyBUvZ9O9yt9JLiFgWVRNWuUiu+pbmLQa8h+qS4SDvya6xeL5qq46UV4y/DgFHdMNxRddV2/WJqXhAbh0xdrwezSZ/D/mJsk17BDHnIYyPXEZVFG9PcBNdRFmPtx+vVSW6Q/oKFK/BDt8rXCk6FdRQkdjS8PT52vutrFZN5eT0Ipg+0uu7y8V9hmNx+/PEfxiUbVw5SrqdSaEvZVCUUOuFCbyrlNqBvF0Y8DL3r+l8xWAlJvq9HtFMAU6/veo6o/Ms+DbWqx1N90saYl80jJXP1s4ncIV9aXVxW047Z0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sBZxq1qBw0YVifCYsPK5O4YSXJgN0FrxWSx9zWVuU0=;
 b=TNd6zCqru1iYASSTBPXBerhFkDzIFIzuSEaXizgUu0kXe48pF5VRwS6TADL3A8XqYLPsJc3zL5fsMcAB546Zza+jwdK8LP1j8gvLENBKpEGunqBowMGADwFcefkUb9iCK3U2NSCubhvE01jvgaDmTOX8sw2l9zs9ofVua2RzMCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:26:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 08:26:43 +0000
Message-ID: <0c1d66d1-0a73-4846-82b3-46f1e3889e8b@amd.com>
Date: Tue, 9 Sep 2025 10:26:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Remove multiple instances of volatile from amdgpu
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250908232134.2223198-1-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250908232134.2223198-1-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0403.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 898ac924-5345-4827-dd98-08ddef7a9b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmh5bXc0aytMZUFCaWNWY01waTFFcExoY3lvRDNYMjhYZ1JqRGJVV1VQdHp6?=
 =?utf-8?B?eFV0QkNZWENOS0I2WjdYMGx6VCt1Ni8vanJZeFpaNTJXMkZMUlNOekExQTdG?=
 =?utf-8?B?cldqbVorV0RrY0NuRFZxdjh6WThZbGhERWpKOGpsS25VamhJUGExaVltK1ZZ?=
 =?utf-8?B?aHZUQWo4S3RsWkFJQU9STVhyWE9JbnduL2xHR01MNC9BNEFDeFpZL1hDNUlS?=
 =?utf-8?B?TDRmTmJaemZ2WnRWbSsrdjdEUW5HbHMveTVpK21RTVYwdHN6KzI0ejRkcTdX?=
 =?utf-8?B?ekRMcVV1amplL2xja1NuSnFXWUJiOXdqeUtyQThuTGdqaGNXL0xmVjFCNHAw?=
 =?utf-8?B?ZCtmSC9sbFhmc2l2c24xenRWSWIrdG42V1p4T0E2M1VwcTNYb3B5NHFUWjV5?=
 =?utf-8?B?N3F4SkhWQUhpOE15TkRjQ3oyYlVLdUhUOGtwMVJZNmpBL29OVFBrbjlyUS9z?=
 =?utf-8?B?bDBVYVpOalA3OGN4cy9SRWxreTVoVS9DUERSWUdpdUpQOFh2c2lUVzV2cmdh?=
 =?utf-8?B?akI0SUczcVhJZW1sUXRkcHJ0WXVmUVh0WjZPWE11eTY0dmEyZ1loTzlJV0JO?=
 =?utf-8?B?bzkwbFFEdE5HYnRJbjZaT1ZpNWcwU3ZGR1BJMmJ3cnh5WFFKOG54R0dyOURn?=
 =?utf-8?B?SUxOMEFqMGQ3SHdScmRXd1B4RXdpRlhMYjVoMklabi9jZVVSWHZTcEJrQ05a?=
 =?utf-8?B?MkpxcjFqRHN2Z0ZIaGZhUWRabisvVXFnK2xXWGpIQnBqVUY2T1B2bEZRS3RE?=
 =?utf-8?B?bmxPK3UzblR5NFNXTnJ2WWg0WC9wczRQMlZldmZSVCtlYVNzK3ZWNUhGSEht?=
 =?utf-8?B?U1lWWFhUaFprUGNlTFZxdDZIeDU1enZQTnVRUUVDSURYNHA4ekRjMUlWRHdO?=
 =?utf-8?B?SWE0SWMySEpZOFRJT2JUZTVybC9IU0d3U3h3QVBhRGtaVDJrRXBlSEFPeU9T?=
 =?utf-8?B?ZmVQZUpFTEUycFF3VEpSTHlDWkJXN0M5STF5SjVFOW9ndjUvUkZxdWltenlp?=
 =?utf-8?B?cVpSNU41Q1RTZjJ3NDJXMGVRY0FzRy9VTnIwajVIcE52b2V6Y091NGxpR0ZQ?=
 =?utf-8?B?ZE0xVlNzU2R3djhCSlNQdEVyWkk4WVNVMWZpTk1VMW4yVEhFNiswN3JxZFl0?=
 =?utf-8?B?aXB5aXVjVW5NcHREa3FmSHdwai95dWxjUHlVNnJKZlhNbkgzYXpyV0hYcXhZ?=
 =?utf-8?B?VGUyZHNTWGZvaUtSVytTYk1lczlFa3FndXdFQmgzdXFqejArZzhuOVV1U0Jj?=
 =?utf-8?B?TC9UYjM1T2RPT3lEWmMxSEM5RmxrdmE1SHdLRG1BZWp5dlcwTWtyalBibVJr?=
 =?utf-8?B?Z1hHdGJFY2JEenRGNHQ5cnA5eXJ4U05kTmlESDNETFVsQTJRUnlCMXd3K2oy?=
 =?utf-8?B?dVdXUThkSWlXanRzc1l4M2RhTXVEZmk1b3hxZWRDWTNnQlJydFB5M1hZT0Z3?=
 =?utf-8?B?SVg4VlNyVVRhZFdKKzQrQXhUd2dncE9aUWN4WkRCZmt1dlZSb2VQa1R1ZXVt?=
 =?utf-8?B?UTRkUlJmbmF2ZXVENlNIWGgyeE8zOTlsVlRpWUZPalRLdDBJaktJVWtwSzZ2?=
 =?utf-8?B?Y0syMm9BZHBOdlVJMkpHM1grT2lLUk42RUllNkVKQnc4UHhPbk9pRWtTaEFR?=
 =?utf-8?B?YmpjaU9JZ3Y3UTBJKzMyOVlhSjk1UVdqaE1GMWFsZXlpT0lxKzlNVDFIUUVF?=
 =?utf-8?B?UmJQeDdJRFN1UUJxSFFZbUlCeGpWTWVBTTBqZGNnT3Mwbk5Na09MbzcvVFFv?=
 =?utf-8?B?a2E1VTBGNmltNzJua2JHaUlwbVR2eGk5WjVhZzFiVDZIVUVXWFpMMERxYm1V?=
 =?utf-8?B?eGoxNTIvcVBRY3pwTGVnYjVVSkVtUG1BUWpJdGg1STZ3TWVYRGMzR0hOR2k3?=
 =?utf-8?B?YUNxVnhBODJRczRUTU02MlZwMFVRNU5pMXNLTXpUcE5nOE9HWDRNSldzVDU0?=
 =?utf-8?Q?bZEog55v+uc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWd3WWs3NnNPQXpLY2k2QVZiUUVYK0xvWmRXY0N4T1BReEF6M1I3d0Mwd2k0?=
 =?utf-8?B?Yy9SdUttYXFhOUQ4bi8wSXk4WUk4a01nREVQZXl0VlZQcE1VaFdhVEFTZkJn?=
 =?utf-8?B?V0hJK25Pa0ZWalpDVmlheVhHYSt3UDY2UkM1QlFzNXRNTEcrdkRUZ1NyOE12?=
 =?utf-8?B?elJFaW50eEJIRm9qK0x1WnpGU2pFdjVLOVNESjV2NHAvVXVXTTJ5bjRxVzBv?=
 =?utf-8?B?UWJDS2pEeE5ZaHJnSGY3elA2UGljYU1kTE1sUFpOVlJEdEI3NElEK2ZSamc0?=
 =?utf-8?B?dllRR3Znbjg0UnBWREg1WW1ydkJzZjFhYUtIbDFYVzJFSTRNNjNKeU8xR24v?=
 =?utf-8?B?N0dGS0FKcHZ1UnhJNGhHcjVGbGZacTZ5ck9MWVNSTzdOVHRnWE1CNmtUM1dx?=
 =?utf-8?B?dnIzZTFFcVFWa3lsVCtyOFJpeER2bCswV3c2TFFVVlJmZkxlUnFDalNUUnJ2?=
 =?utf-8?B?bURKZ2llVk9kanBSOS9helVLWjErNjBIRTFQV3pPZURTeVpwTUI2YWNIUjVX?=
 =?utf-8?B?MC9vWGliT2tpbDFBTFdNRTZ4OG9PL0lRaXJqcUN6ZzQ1OElGbG5HU1pVUG1j?=
 =?utf-8?B?enB1V0hseTY1U2QrV1ljMmJPaG5JK1FabEw1TWxvYWZUcVNKd21OTW1IanY3?=
 =?utf-8?B?WTU3SzArTktIM0ZlS3BkTktHZTB1OER4ZkE3ekxabmVHanRSdkRiY3V3d21B?=
 =?utf-8?B?emozVEc4QzdQcVYwSXNxQUdxaTExbm5Ic3h1UkFwY3dwVTVpWENMOWtJeG5v?=
 =?utf-8?B?K3JDRkdPdE04dGNaZW1KTDFnVmIxWlZZc09QRndtMjg3K3oyWG4wdHp1TXRl?=
 =?utf-8?B?WTlHTnZQUWJVTDVuaWp5Vjh5Y3NqWG9zOHdnVDFVQlE1UEgxb3VxVHhXempD?=
 =?utf-8?B?LzZidVJXYkhYME9oaUthRm1mNHQ5bGY0ZGZCVGNMREpmVTQrK0VURUk3TWhN?=
 =?utf-8?B?ZklzSmdwZTkwR3ZBL21Cd21uSStQbHVCODJoem9BbGhCYlhUY09PMGwrZm40?=
 =?utf-8?B?Q2ZoKzl2OHI3OVhqUWVGQklienBvNWhZdk5zaWN1TWdGSmtmTmdnR2pyV0Yr?=
 =?utf-8?B?L0p1SkZydWFZY3dSQ2xzLzVMZFhLd2ptQ3Nqc1ZKaURKQVNoSXZXOTBSMDJG?=
 =?utf-8?B?K1J4UDBKOVhHRFVNVzJlMkVqV05nNWtnQ2FsNEtwMFFueFl3T0VjamgzSWNX?=
 =?utf-8?B?MTNGcWkxL0xocTNRdlJIdEhIUkhGMFdzL2Q3eWF5cFVweUdSd0Qzb2szUGRO?=
 =?utf-8?B?UjdQRy8yc05Yb3ZweTFyd0krM3hoY3VJRDFHblNubkJvdFNLTW56TExtSTFG?=
 =?utf-8?B?QnZtV2lZaUJ3OFdQcHBBaDhUcktnczcwTE12VC9uNEFlRHBDV2FabVdNKzdP?=
 =?utf-8?B?STZsMHd6Q2RmS3VIV3VqdkZUcXNVWVg3dnc5dmhoeWVab1BpbHFabkl1UGl5?=
 =?utf-8?B?S0RNdlZzb0dhUGlkNXRGb0NlRi94clh3bTdZY2NuVGRvSHJabU51ZjIxaUc0?=
 =?utf-8?B?RUJXb1BtaG9QU29Kb1dPRXMybndLc3NiYWNqa0RPajNaUVNnZFU1a2RNcWo4?=
 =?utf-8?B?V0dsUWx2WGNUS0FyOVpFQTJLSW5lOUszUmxFQUlCVFZ4djVDblNFd1lZMHp1?=
 =?utf-8?B?c1B4OE53NDJLM0JJc2pXc1VkdnR1eVpOOEVST2R2S0VENHBxS1Q0RWZoU1Ew?=
 =?utf-8?B?alpxM3pNL2dBbVBBUUpKRVlERmsyRmxPbEJzZVl0SFZQQ3duZ1VQOEU5c1Jl?=
 =?utf-8?B?RnZGeXRic2x4Z3ZjSGpSS2RoZ2NHWExycG00ZkFFSjNxWUlnNTU5UHNpbm5J?=
 =?utf-8?B?RUtEQlo3WEwzYkltS1VGQ1dNdGQvZGY0K1g2b2tmeXhRYWN4R2FKc1R4MVRP?=
 =?utf-8?B?RTl6N1J5ZXBJbnh2VWxva0hsRWhpWSsxY2p0ckNnVXV5ZUppTU5iazhpVnZj?=
 =?utf-8?B?QTg5bDFKSDhFdmZYYXlaNHdFNEkweDhSQUhEdXZtNHgzTEdOV1pBOU8zOC85?=
 =?utf-8?B?Uk1pSlFOSy8ydHA5WEFUTENsaERzdHVidGM4QVFwMDYvLy9iczNBYUpLeExX?=
 =?utf-8?B?L3NaTzNZbzRJRG1mckdPZXZvV29GZkZqN2FrdnhXTmxla3N0eDFhd0pkU2FD?=
 =?utf-8?Q?XOJS00/IG24Zc1oqstELt+QyM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898ac924-5345-4827-dd98-08ddef7a9b7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:26:43.2803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJxCF/NtYw6pVpm+hW9X8W/LnGxpm3KHkPqf/QHXa1p91cMc20YAPE5kg626SR70
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545
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

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

Could be that this uncovers a bunch of missing memory barriers, but that is pretty much the intended purpose.

Thanks for taking care of that,
Christian.

On 09.09.25 01:15, Rodrigo Siqueira wrote:
> In a series that reworked the CSB manipulation, Christian noticed the
> use of volatile in some of the function parameters and pointed out that
> the use of volatile in amdgpu is probably wrong [1]. He also shared the
> following link about this topic:
> 
>   https://docs.kernel.org/process/volatile-considered-harmful.html
> 
> After reading the documentation and inspecting multiple parts of the
> code, this series was created to remove many parts that use volatile.
> The three rare cases where volatile should be used served as a guide for
> making this series.
> 
> [1] https://lore.kernel.org/amd-gfx/b1c2d811-132a-47e5-a13f-086125b849b5@amd.com/
> 
> Thanks
> 
> Rodrigo Siqueira (5):
>   drm/amdgpu: Remove volatile from CSB functions
>   drm/amdgpu: Remove volatile from RLC files
>   drm/amdgpu: Remove volatile from ring manipulation
>   drm/amdgpu: Remove volatile from amdgpu and amdgpu_ih headers
>   drm/amdgpu: Remove volatile references from VCN
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h   |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c  |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h  |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  5 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  5 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  5 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  7 +++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  5 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 14 +++++++-------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 12 ++++++------
>  24 files changed, 87 insertions(+), 94 deletions(-)
> 

