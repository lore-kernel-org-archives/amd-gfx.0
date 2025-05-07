Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B899BC3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 10:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C2510E07E;
	Wed,  7 May 2025 10:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EBjHzPYY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991D710E07E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 10:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tISxI7MUsmv1lJSF1YKH9lv5n/m3JOPa6gkER7M4qJUoapd075106vEu06qTOZ0Zaz1QWKv7Q6rFVQCK/iqY/Lpmn103BgSj2GHwh64zmGCaHGiZLPNfUGnZ8IQK/kL6WJMbCqL3S2mjRUuNq2U31BHjIfEXLtN35pamGS991TsPPI0/X4LUvLmHRU4wav/y2AqlptF4dbcrprueqRdWuDlIfXaeItj+KI84x59KyWWD71oIkNEp4OErG61J1Am3E0MX0DVFvdU8wVn0hyoo68sA5BVCj9fwnkb1i+ANfPB5q26b1gOCPOSfO07EJH/IG9i34J3bFmPlQqI7ufQmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zrj1Looo6JAJi+gwFYTHBw47xSA0XoaSrhv0cgRYsso=;
 b=aFkpBklUVbUE4MWPLR7sHDKj9IEoJ7DQTW7tLm1uR12jRxG83qZ+oKlNdTsFqDHa8eaq68hjS/5ta2MahmIuUBggXG8yxbM9h+gI7+In2USp2886/LVZb1mZzXTaU+qdV9X7rtvLtNngPz30vDrD4sOr/hCqdcKK4yubiv44U7NMtsrLt9dxFwNVqu3KAzYM8sYY7vtcPAkQzj7ALOb4fitqkAsiklTDKgQYrMvp5ILlkH5S2Dad7VycAJ8qUR5cXjYziuRVol88kldcDoZ7iwpCVQnXzlZldMnqtN3h9PryBwCc8AioVtHgTUkH99EMIiUjHc+Ss2gmEnESZto4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zrj1Looo6JAJi+gwFYTHBw47xSA0XoaSrhv0cgRYsso=;
 b=EBjHzPYYeMV5RO6n1seLn17vFeTq+JXYfp7qZFvTHSbFjBPOn5Iwyhxi19YhzNgbBg9VKe/5EmsTUMvrFg3RRV5sAKn5rxe1EttGduopgf8lRoA8nE/X302y0/owfxgC17kZ/F1soaFowq78KSwEeH2T8b/iT9webWljOMQclKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 10:19:48 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 10:19:48 +0000
Message-ID: <3ae6f972-ffab-413b-9fb8-ac250bb91955@amd.com>
Date: Wed, 7 May 2025 18:19:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm/amdgpu: update GPU addresses for SMU and PSP
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 lijo.lazar@amd.com
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <20250506093629.249792-2-guoqing.zhang@amd.com>
 <8c0b30d8-3e90-4e76-beca-f0a74efa7d14@amd.com>
Content-Language: en-US
From: Sam <guoqzhan@amd.com>
In-Reply-To: <8c0b30d8-3e90-4e76-beca-f0a74efa7d14@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DM4PR12MB5937.namprd12.prod.outlook.com
 (2603:10b6:8:68::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5937:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da07848-1eba-42f5-081f-08dd8d50b1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enV3dU5RYitVZXpJbEJSME9GbExXTW5hdlVXYUJGdlpVYjdBVmZOZ0pjRUNC?=
 =?utf-8?B?UHBSdXBKTVVvTkd1bkZUVWNLM0licGpYMTNwUDdQZWczU09VTngxUFYxdUxZ?=
 =?utf-8?B?U3d4UXVFZ1dFaHQxMGJlajIxRDk3bi9ONU1RK1lTTmNlWFRBeElQK3J5aW81?=
 =?utf-8?B?MSsxNVgzRnZ0Y1poN0RQcWloVElxZXFraTFLV2lYOUQ3YXpRbkZ1KzdzSkMz?=
 =?utf-8?B?MjVOTkJHYkI1S010S2xDWkdSMWU3djllWGswTVkwemZlNU5FYjYvN0twTWVn?=
 =?utf-8?B?YVFoWG94Q2p0bWg1S1dxS3ppcEVrb0JpUEJ1eU5tOHNZVU9IbG52MTJTOWJx?=
 =?utf-8?B?cFNvbTBpSnZ3RzVLMG5mY0FLVitqN05Bd3B5akR4d2lpMGpidEFHL0psK0xY?=
 =?utf-8?B?bkxwbGlLeEY5a2N6NXRMRkwyUHkycDdmL3FPQzIwSnVaZzQzSWdoNzl3cVEv?=
 =?utf-8?B?Q2Y1aC85Q0ZUek1ud1dYY25GK0xDaEFpUkhBUlFmbExZSDV5Qm5lMUNDWXdx?=
 =?utf-8?B?L1IwZFdEV3VXc1Y4ZDZndmxsVkl2ZmV6U1BXWjN3dVdTaWFpb1l0SDF2OERn?=
 =?utf-8?B?bkNkUnZLcytVZFBxNldDSGZjMVVmRzhuc2xBKytZY1E0RlY2TVA3ZW1ZQWJS?=
 =?utf-8?B?S1UxL3c4cjM5d2xDTkhrVXZNTjJBZUVTK3ZrWnZ3QjBaYjNPTUZ3N1F4eGJD?=
 =?utf-8?B?WW8vOGVyWTZId2ZSQ0RmOGd1R0dqeEQ4TlRSYmI5b0tkZ1V3MGxUamNlUUhJ?=
 =?utf-8?B?NElSNWIwd24wMEVOMnR5YVV6WkswcEo3SSt6V0hSRVE3S3c2dHJYSjEraW9o?=
 =?utf-8?B?aWJMRnNROEwxZXNSa0I5dlJLdVN6S2NVaTVuK1E5UkNiMXdlemVocHN3QkpX?=
 =?utf-8?B?YWQ1aVcwTHA5OVZOMUNwQS9TM05tblBnOFQ4UTJ0Z1IrZ1B0VFdINmNBaUtN?=
 =?utf-8?B?Umtnb1pJNUJHWHRLd2Vydmt6OFVZOE0zbW1UMnlDUzlYNitacG5mYmYzKzFD?=
 =?utf-8?B?cUZhTE5BSG5saGZyRFpyZ2R4di9PUmJuRGNkMmh3ZzdmK1hiL3B5cnROUGpx?=
 =?utf-8?B?SkdEY1V5cDRsNGhEUTlqaC85bHFPYmR2S01DeTE0ckxqYjJNQjNUK3Q3bVJB?=
 =?utf-8?B?ZXlBaGtGK2RwYWdFVUFFZ0tiY0VWcVUzSUMrV3lZc3cxZyt4Y1Fzbi9xNSto?=
 =?utf-8?B?eWZNcWJ3T044RklZaXVOSkNuaElacVdUODFHQ21RaUNhMEYxTVVmRDlkQW9o?=
 =?utf-8?B?VElUZWYvcEdaK3NwUzNFUVlvMWI1d1VnTlRZMHNYNnRkRHZxTk90aDlVcEVP?=
 =?utf-8?B?OVZva3VKMXpvQXBFSXRxWjlxQ2VXc2l1N1gzWjk4K2NzRzRqYk5aZjh2U3lB?=
 =?utf-8?B?UWx1UzRpUVRWeXc1NjBYS3dhYncxQTQ4U1dSdGdqcDFGVEk1amNvbTJkd0VE?=
 =?utf-8?B?TGRoRko5TTk2V0tYYnpKaVllMXk1VDdob0lGaExYdHZDMjB2dDRzZWZDQm0r?=
 =?utf-8?B?a1lDL2ZOOHcrS0V5M0Q0Yzc1RFJuNWxaNXI1MXVPMWhiNGRnOFdrTGxNZVFr?=
 =?utf-8?B?ZEJlSkV3Z1RHbE4wOE5kdmdYY0JkY0dwaUJSZ0xwRjJEOXRUam5QOUhYeDJH?=
 =?utf-8?B?c0doL2tBM0dma2lWdGllSFEwK0pmTCtUOHh6M2pJUWVOaUtQdGZHTHVWMkx2?=
 =?utf-8?B?YzZHanNoNmtFQjhUdy9tM1NvOUtXWHFWN092em56WDhmSEF6c1E1OEVMamdv?=
 =?utf-8?B?MnlBQk8yWk1lUyt1REFVUTUzRC9LcTNTckxzdUZZWjVKQlRhZjlwSXBhY0Vp?=
 =?utf-8?B?Z3NQRUdUZms1azZLQkpHTUdONDFtaGZrbUhtV3JWWUdxTFh1bXE3QkZvdW9y?=
 =?utf-8?B?WW1OenRBaGlGdCs2b05xVFgzQTRpUS9VNGFUQXFHZ3d5ZUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJUeVd2KzAvQWRBUVdEd1BRK0p4eVQ0VmhHZ1l6TGpjRjFxUnRpMFFnZFVz?=
 =?utf-8?B?OFhVK0Q3V3R3VTNoNGl5a09UUjVpeEphUyt0aGZISzdZNFFmUm5nOWswV0Qw?=
 =?utf-8?B?VDJoWU9YQUNoU2FoSG1PcE16SmtvVEtYcy9aMW5XOGpMckxOWDRVS1Fob3Ny?=
 =?utf-8?B?TWozWlpIOGp2d2RFalBrOVFaRlJ2em11WndMcGJnSTVYNjRhSlBJSzJ1ek1L?=
 =?utf-8?B?VzkyMWdxZ0IvdndBTVo3RnpRbHp0VkRyUUllOGF4a01uN1haNkl6cysxdmhD?=
 =?utf-8?B?UGRnU3k1WGZUR3FTaDdqLzdKNEVma25tWDdCMjlzUW5GY2pvMnhmTEFMNCtu?=
 =?utf-8?B?ZDdjQUdsUTI3ZHlPNTk5cWFjYjYxbDdvS2lhWFpiYi9FY0ZEK0FGYlVlWkVB?=
 =?utf-8?B?bkIzN0dRVUMxNzZ3d3Z1RmJjck9acDY2d3JHWS83NlBtZGl4WTlwUU1hMVpZ?=
 =?utf-8?B?SGZONXJZendGV3d5R2E4OXhpaE5saVVTNVZoaEk3YWRhMStIUGkwSkhTR0F4?=
 =?utf-8?B?STJ6citGQ0tBcVYybUQxRmFpaDV1UG5ZMnpmbzAyOUQrTjFyVXMxVDBMZ1Ni?=
 =?utf-8?B?WWF4cjRhckhpMEJjSWZZY0hTTmd1VWkwQjlFUWhmYlladzJ1WWdrdWdZQUQ1?=
 =?utf-8?B?L0dKVkxSZlgwM05tOFB3VldSbzZjRDdBeERmbldEWlFSQmJhMkQ0MWdSQXp0?=
 =?utf-8?B?QkhlcDNwOHVXZWdWdjU3V2JvQWpsTWVQTnFUdW1qWTlZeDVoQ3lXWlBXZy9B?=
 =?utf-8?B?QjZLa0FKYUh2ZW00NUMzbktPcHpWbTRjaEFQdTVIRUs4RDNFRkFReDZaSkFR?=
 =?utf-8?B?R0RRZDljdDFMOGpoTVhDalRxcE96cTVVSUh2QjhjSmNrcFdjK09qTlZZa0RJ?=
 =?utf-8?B?bGR0eldxUTJrcmtORURHYm0zV1luWHhEU09LeThPTlVUK3ZCbk9wODdJNW44?=
 =?utf-8?B?QkxmR21ERXJyYUgzN1NxY0Z0RG5mZWRSdEtaYUEwWC9TY0JZUVp1WDVrejg1?=
 =?utf-8?B?d0FleTBrM2xuSEZFdGtrTTlQaVM3dVFwcnp5WDhLMWNKUUtta1QyaUkwL2Fr?=
 =?utf-8?B?dFVlUWNuSXYyaVVLTFF4MGdmU20zT0d1STJvRm9IbkVJYVB6K2hMNGhwOTJB?=
 =?utf-8?B?MUs2QjZjN084REVZclZ1NHJ3TG44ZG42M08xTUF4STVQMnNlUzhGbzRlNWpQ?=
 =?utf-8?B?SDl3cXVOb1VNRkttdUR4cnRSVmxyb0RxRDNDRmZRREtWSWF4eTNXUVFGUkZN?=
 =?utf-8?B?RzZTaFBUalFmNUdaNUpHVWlRZ3JuLzZiY0czeFdHK3ZNbmRMaGlNWHFzdVVS?=
 =?utf-8?B?SnVPYWhDdEJNVzdWdlVMczlkdndVRGFZd3NhZWRsbTlJSWcrbTZOYzFCVEZV?=
 =?utf-8?B?R3FnbUttZDVJVUg3WlpzTDlJa1NmZE5zd1F4TjhwZGpWZktUTnJrcFVQZTMx?=
 =?utf-8?B?TDlyNGxxQXJKbUo3bWdvaE5sWUdGK0RsSFNTdXJnVnRaczl6SEtBdzhrcUhp?=
 =?utf-8?B?aEVjVlc4dVR3a1ExaTlyVU9ORUVVMkhGcnQ5M3Q1MUVGQnZlZTErVENscTRO?=
 =?utf-8?B?c2NvQ2hEVHhLaHhwRGZMNEMwWUxWY0UzT09oc0R6MFBtQW5xZXFmWkRWQ2RC?=
 =?utf-8?B?TVk0RHhrdVhxTElHbUhDKzVrVWRDMktrVHlKWTl5c1F2eThRK2dSSitXN3kv?=
 =?utf-8?B?cG50T3RIcW12WGVFd0ppbUFyTlJyb2pMakp0bWpHY1J2OWdPMUNrUXV5ZXMv?=
 =?utf-8?B?SitpUWk4V0ZuT2IwKzZUYktyNS8zaGFLVC90dlUyQVM5ckRJVmZUZnZ1RVdq?=
 =?utf-8?B?cUNKNjBPVmNxTFRHRFFBd3JhbFFUUXduSDdkVVNybmg5S2JxUDkxOTg1OFM1?=
 =?utf-8?B?ZWFNN0tTMVBGN1F5cnFmL29nd1RoSDhsSGIvRE9oSC83R2VNR1lLVjdBMEYy?=
 =?utf-8?B?dk9DMTdUOVNsVXlxY3huU2thWG9sMWo0Uzhuckl2YllYeUh4NDRISTl4SVNh?=
 =?utf-8?B?c1RmR1E4YmozNGhXL05hT2FkQ09CcHpBYzFvSHEvb0JPMzY2V0lLQkFlUGtr?=
 =?utf-8?B?WFBYcitjMlcvMjdSemtTNm1kYzh1VTRPS2JwVzFOZTJYV1V4d3BCc0lNSHlJ?=
 =?utf-8?Q?J+AfiYku8CSQIMXgGjj2UUak4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da07848-1eba-42f5-081f-08dd8d50b1ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:19:47.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TusZEpuHT9SjC2Cfj6QDE6Di7l6++2MQ/1s/TB63UG9p115p4voPqBKr8/gimq0r7483cvNqRfRP7RWd86JN6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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

@Koenig, Christian <mailto:Christian.Koenig@amd.com> Thank you for the 
review!
@Lazar, Lijo <mailto:Lijo.Lazar@amd.com> Could you help review this 
patch? Thank you!

Regards
Sam

On 2025/5/6 20:32, Christian König wrote:
> On 5/6/25 11:36, Samuel Zhang wrote:
>> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
>> the FB aperture address for SMU and PSP.
>>
>> 2 reasons for this change:
>> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
>> aperture address, it is not compatible with SMU and PSP, it need to updated
>> to use FB aperture address.
>> 2. Since FB aperture address will change after switching to new GPU
>> index after hibernation, it need to be updated after resume.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> At least of hand that looks like it should work.
>
> Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>
>
> But I think Lijo or somebody else familiar with the PSP/SMU code should take a look as well.
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 22 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 +++++++++++++++++
>>   5 files changed, 63 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4e794d546b61..3dde57cd5b81 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1513,6 +1513,26 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>>   	return amdgpu_bo_gpu_offset_no_check(bo);
>>   }
>>   
>> +/**
>> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
>> + * @bo:	amdgpu VRAM buffer object for which we query the offset
>> + *
>> + * Returns:
>> + * current FB aperture GPU offset of the object.
>> + */
>> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
>> +{
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> +	uint64_t offset, fb_base;
>> +
>> +	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
>> +
>> +	fb_base = adev->mmhub.funcs->get_fb_location(adev);
>> +	fb_base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>> +	offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
>> +	return amdgpu_gmc_sign_extend(offset);
>> +}
>> +
>>   /**
>>    * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>>    * @bo:	amdgpu object for which we query the offset
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index dcce362bfad3..c8a63e38f5d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>>   			     bool intr);
>>   int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>>   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>>   uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>>   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index e1e658a97b36..bdab40b42983 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>>   					      &psp->tmr_bo, &psp->tmr_mc_addr,
>>   					      pptr);
>>   	}
>> +	if (psp->tmr_bo)
>> +		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>>   
>>   	return ret;
>>   }
>> @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>>   	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
>>   	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
>>   
>> +	if (context->mem_context.shared_bo)
>> +		context->mem_context.shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
>> +
>>   	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
>>   		lower_32_bits(context->mem_context.shared_mc_addr);
>>   	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
>> @@ -2336,11 +2341,26 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
>>   	return false;
>>   }
>>   
>> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
>> +{
>> +	struct psp_context *psp = &adev->psp;
>> +
>> +	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
>> +		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
>> +		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
>> +		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
>> +	}
>> +	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
>> +		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
>> +}
>> +
>>   static int psp_hw_start(struct psp_context *psp)
>>   {
>>   	struct amdgpu_device *adev = psp->adev;
>>   	int ret;
>>   
>> +	psp_update_gpu_addresses(adev);
>> +
>>   	if (!amdgpu_sriov_vf(adev)) {
>>   		if ((is_psp_fw_valid(psp->kdb)) &&
>>   		    (psp->funcs->bootloader_load_kdb != NULL)) {
>> @@ -3976,6 +3996,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>>   	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
>>   
>>   	mutex_lock(&adev->psp.mutex);
>> +	fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
>>   	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
>>   	mutex_unlock(&adev->psp.mutex);
>>   
>> @@ -4085,6 +4106,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
>>   	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
>>   
>>   	mutex_lock(&adev->psp.mutex);
>> +	fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
>>   	ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
>>   	mutex_unlock(&adev->psp.mutex);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> index 3d9e9fdc10b4..f3b56c219e7e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
>> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>>   		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
>>   	}
>>   
>> +	if (adev->firmware.fw_buf)
>> +		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
>> +
>>   	for (i = 0; i < adev->firmware.max_ucodes; i++) {
>>   		ucode = &adev->firmware.ucode[i];
>>   		if (ucode->fw) {
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 315b0856bf02..dfdda98cf0c5 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>>   	return 0;
>>   }
>>   
>> +static void smu_update_gpu_addresses(struct smu_context *smu)
>> +{
>> +	struct smu_table_context *smu_table = &smu->smu_table;
>> +	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
>> +	struct smu_table *driver_table = &(smu_table->driver_table);
>> +	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
>> +
>> +	if (pm_status_table->bo)
>> +		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
>> +	if (driver_table->bo)
>> +		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
>> +	if (dummy_read_1_table->bo)
>> +		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
>> +}
>> +
>>   /**
>>    * smu_alloc_memory_pool - allocate memory pool in the system memory
>>    *
>> @@ -1789,6 +1804,8 @@ static int smu_start_smc_engine(struct smu_context *smu)
>>   	struct amdgpu_device *adev = smu->adev;
>>   	int ret = 0;
>>   
>> +	smu_update_gpu_addresses(smu);
>> +
>>   	smu->smc_fw_state = SMU_FW_INIT;
>>   
>>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
