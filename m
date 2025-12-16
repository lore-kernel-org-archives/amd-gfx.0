Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E4DD637DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 22:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DE610E329;
	Tue, 16 Dec 2025 22:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tL52iFC9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9968610E329
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 22:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf5A7lSZt9ZvdPeyg6cOr5QaX3ZwSUjlZWTC25lifibBcHFnPkpA7pPRoLj32B4BRhQ9hPW72U2FgTzkqoX2xEoTu6HNlBliv8wN86XATt7OGO3wDc3IwbsuLF/f6iQGBbcWk7hVhvNedFcSFbwLsyq6AosjLzOvi42VMR2zAHYZBjB+DiLxqzUMje1eqCDIibj03fYAeyd3P1wLFph7Cmkc8SbOlvrPagdiM5XqzCazU5gFqHuw8CvxRaJF3Tgo6ODGVuaMlg9RogR5CjVNtROfadhGVu/a+AoUHh9zcab9BpB6edSUeGRfl7Ok9hwS6ExujKIhRExQgpLMA7ZBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLLeWMGCaQ84dGy3WdKZNOrum5/QfFxsH0Xo/Q2F4/o=;
 b=mDI59R4X9gyFgStBR6AFAqhp6cGmq8n+R19Ipi2KID3WeOksAoJmgfTpS2/tykX2k9yuNGPU1noJ1D7vGXIkJCsQ6MLAll9+Sy8vM1/JUd3AYY3IG0itHG8zuyP9ldO7HP5Nwaz1In49/Q9N3jTQGwgt4tTMnYY/aqjxq4LHrKIzv9hmeAfxDV2vVoILeEDQ7mJXiry/uyyrahu2nwcO7ycHJJnDmi+Cioi+6cYr/ZxmuQeNTZXaPx98yEWNQYR0Q/oFCNo1MbijZio6w4OxxfmZ1IPF2e8Nu577CA5shE76lnVfIzndffeSfxb/Ow9R1eYnsEVipV1ozxdqRzJK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLLeWMGCaQ84dGy3WdKZNOrum5/QfFxsH0Xo/Q2F4/o=;
 b=tL52iFC9WRWz68vXhkq7v3DtraTTWATKOGzrZdrHfIhTBHa/Vl9vS7ZI71jxlwNvDYOTgvVW0oozo2ROromu7bfGROrKA9PfUxQb4yjNq0ap8bfBBFRe7Gje29Goz2xwufBQkXAjz8/uK7OTbRaIe02FAKzn1GCRH5TINb+n0No=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Tue, 16 Dec 2025 22:36:01 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 22:36:01 +0000
Content-Type: multipart/alternative;
 boundary="------------RpzBTZyUlxyfhkp0G0N0jmgs"
Message-ID: <c3415b20-da51-4aac-acf7-841fe9621b3d@amd.com>
Date: Tue, 16 Dec 2025 16:35:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-7-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251215165630.1172383-7-Philip.Yang@amd.com>
X-ClientProxiedBy: DS7PR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:8:54::26) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 870e7cfb-7017-4fd2-985b-08de3cf37d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmJzUTYrQVNYWm55dFQ3dlVxMnhhU005VHdlalIzbjNXMU5JNUFHdFRQZjZ5?=
 =?utf-8?B?Y1RrKzArcS8xZ1RzeTJqdGlNL0c4eEZMMlhXWmZBdGp4cmVaMUk5YStsZ1Fj?=
 =?utf-8?B?Q1VMSUNRejdoVzZnUXlURVR5cFFiRUdxME16Q2V2R05ucFR3ZU9RWkRRNEpy?=
 =?utf-8?B?c2VZeWFsaW5GdmtQekpBaVdlU0dsZWtLR0JLNVpmRjkxckRib3VGaEFrZHBX?=
 =?utf-8?B?SCtZOVZtbkt4TnQwNlhiQTVybFN0RHBXVWF3M1B6amNZemJ6dlZIRkc3UVFu?=
 =?utf-8?B?NjBTeWJHRjJYSEJwVzQ1TTBmQnJFRHpYbTV6TndCZ3RIUkd4R284WXJUMklO?=
 =?utf-8?B?eUNPdFN1QU1HbkdjUk9QMytYNXltSlR6NDRNcUNvRHdIZmJkSTVzV3JyR0Ux?=
 =?utf-8?B?WmFaNkdoOXgvT1RwbEFoSzE2WVpDN2tYbzB4ZmRjRzkyWml4WkFPYmFiWkdB?=
 =?utf-8?B?YU43YXF2d1BxSjVabUpHWGtkM1l0cmpGK3o5YXNhWVVJcjZMRy9CTDdzSFFY?=
 =?utf-8?B?ZG9ESWIyRks2b2dtRlY5b2xRVDZoemNFcnlKYXhRWEJDVk9xUmQ0eTBMKzhz?=
 =?utf-8?B?YzB0S21YWnllVnBlOXhCNlZHd3huQXV3MkZoVVk1eEx0MTVZbjNZSTJYeGJ0?=
 =?utf-8?B?THdYWVM2blVyQ2dxY3ltQmNVcm9HczBnWHBGKzkwV2t4WXlGQzBqVzhuTE93?=
 =?utf-8?B?ZmdJK3lzblJDa0lCMlZiVEhSY09uYU01U1o4MTJEUndnV2xxeEkzNmZWcEht?=
 =?utf-8?B?OWR6TDg4VjFXbGtYd0gzS2xxUFdnVWh0NXhMWjNHNzZhUk9FOXBHajd6TDlk?=
 =?utf-8?B?cTFXTk9LaS84c2tHNTFzVWNpOWVXd3gwanJFK1dOTzFpZlYxOVBIck9aeUpJ?=
 =?utf-8?B?clR2TUFLYzdOckZLYXlhM1J0SWs5UTJxNDcrQk1HU09qK1E4Z1ZkYWVsVm1C?=
 =?utf-8?B?ZlVSWGY2MWdVRzJEZ0Yvczhwc0pGS3ZuTEx3dk9weHArT1hEVHlYOEJSWVR4?=
 =?utf-8?B?M3pCQng1MnE0enN4VEFKK2tScStUQlhwejRSZGJoeTVMZVNScElJb0Z5bDVF?=
 =?utf-8?B?S2NsQ0NGMUJNVWFqU0hQMWU5Sisxd3lNYlhCTkE0bFhVVUZqOEEvT0hUVkhY?=
 =?utf-8?B?RHpCaGxEblV5M1BMNkx3VHh3VnRORUNJUythY203ZFREanpPRVpNVDJ1SnZI?=
 =?utf-8?B?cTVETlZlai9HdzZCR2U2ZlVBR0hCcGc5N0swUldhalV0OERLZWZ0SGRGb2Zt?=
 =?utf-8?B?T0YySFJTcTI5WmVBS1hvQ3ZFMmh1c1hqWUpZTUhoWmtnSFVKYU0yUDBqd0tS?=
 =?utf-8?B?ek1IWTdvRmNBQmxRcXd5aktIMVUxZEZQRmtQdlo4d1NoaEs1bGwyMXFCMDdj?=
 =?utf-8?B?Q0JncUFxdFd2ZWRyaTg3RjFGUWNqWW01Zm51SG9yczZVeWh4WWo0MEVTdjgw?=
 =?utf-8?B?U29ocDRuTHE3TS8vdmE4emppQkFpUlVwMHJUMnBDZEVyNVNNVlVJb2dwQTMv?=
 =?utf-8?B?YUxtSHVnblZrTi9BdnhNWUFKWVZMb0ZnMUZndFdNek1WRUxuSWQxME53aE5l?=
 =?utf-8?B?VE50WmpNaFZIWnNGTS94a3JGYjBGcWFsN2ttdDk2US9UV3NPNngyZ3NRd3Bv?=
 =?utf-8?B?WE5WaGM5MW1HdDZONy94RzZhZU1wbjVtMW4vcGpEMU9zNFN3VVQyS0dKVFR2?=
 =?utf-8?B?UkJmOW5VTS8xdklJbUFHdnY3a3RxaXVqRjFjckhZcU9LWG9DcVFweHFMQU1L?=
 =?utf-8?B?UjBra2xXcEw4L0o0YTlNUmVXc2hKTW1PbDlsWUdJQjdsS2xYa08wTzZ1YmIr?=
 =?utf-8?B?QzJFN0RCVnkzcm44ZTNSWGlRbHMxbUtScWI5VnlWNyszQnpmdm01TW9XTG1n?=
 =?utf-8?B?ckRMYW1TMVFadmFyeHN5WXpZNjk4NnUxWlA4L2xBTDB4cTFWbGllSmtsMzhx?=
 =?utf-8?Q?T2DF49o0x0OkH52mZKm8AbNtK+AhKkXp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9LWDhDN0lVdElYT29PdzB3ZXhrOW1wbWRrWXk1d2ZOSnFmTk5XV3lEcUhm?=
 =?utf-8?B?M0dXR1RkaFBOU1FKVEVmNktVVmZmdTRsaFpVUFVzNnc5ZXJJYjNZNkJZZDJm?=
 =?utf-8?B?V0ZCV1dIc3JKT1lTRHJleTRzcTIxZ09WYXJxWG15UnhqMzRWYlo2TDN4U0NR?=
 =?utf-8?B?cUNUekh2OXpBZ284N25wRTFHTmFBYWdWOGRvVFRZcXNNd1JvOUJKcElyOHlm?=
 =?utf-8?B?WkhieEJrL2tVdy9KMnRhNlVZWjhTTTMwVTRaSUJ4WWpmSjIrU1VhaDI4ZG9w?=
 =?utf-8?B?TmlvZjg0YUwvbUVJakwxby9OMUFNTW5yeXIwNjFvMDRqcUZWYW9xdytXSDBJ?=
 =?utf-8?B?dGhzUzdiMCtIMXFQeG5zUkVzZ2kwWi85TG1IS2FKcm5raVd0Uk5Rcy9KY3da?=
 =?utf-8?B?MGFHY3owU0tPdTY2aEpGMEw5SGdlcXlUd0tiZnRBdVJ0cTNwcER3TldlMmIy?=
 =?utf-8?B?cjdPQkl6d1IvaVppOXpQc2ZiN1o2UlhWUTNsNHZSUVg4ZDIxeEZ2djBjdkY2?=
 =?utf-8?B?SXVsMlhCMnNOYkpUcGRVcFZVQmlUMTZvYmZiZWlxaEtuanBYa1RkSSt2bDlJ?=
 =?utf-8?B?NWRwdkRmWTV1MmNtMVdwQkcwekxQQXZ4SkFTUlF6N01NQ2d4aGN0elFGV3V6?=
 =?utf-8?B?NG94akk2TExoZ1crY3g3YlpHbW5XOCtxTFowVWhwYTFNOW9mV2N1VFZSWWh3?=
 =?utf-8?B?MFdJV0gyK3QxUEszYkFFVThqRnZCMUpablVPdnNCTlkxcDlTdkkrVFU2Mkov?=
 =?utf-8?B?UUNkdDFoL3lIV2NFdS9TQWpabmpUYndqUjA2bS9uRThKd25yL1VjUUZON3JR?=
 =?utf-8?B?Y2lKOUo2N1NMc0hud1VuQ20yeElnQkx4OWdLYmZic2tZSS93bUZxLy9BbnNH?=
 =?utf-8?B?cDUza2JxS2JJUmFybFdqY1YwUlQ3U0prVncxb2xsUWhBc3U0MlRKa1ZoM2Fr?=
 =?utf-8?B?MGNJMFpYeEs2Nmc0UjVSb3pTaExMeGFObG1kK05UT3FBYzUvam5KTFVKR0Z1?=
 =?utf-8?B?cUpKaWd6bHpheEg2TkxCdVR6cE1JRzdoZngwdGU3YmlrSzNOS1ExU1U2Z2My?=
 =?utf-8?B?QmJZRGN1b1R5cFh2YVhGeW5yclpLU2ZNWmxaOTd6YVBYckxjeHFaZW5LSFpy?=
 =?utf-8?B?VktJMlVMODdiTjR3aWdnT3N3Z016cEFzWXFxRlRkNjMrVjYvTTBFOTRLdUlj?=
 =?utf-8?B?WEV3L3kxZWNtWi8xVDdOMjNSUmNLTEpiZ0VBSXBzaFM3N3FXL3V2NVp5cEdF?=
 =?utf-8?B?RVRkSmV6dDF4VlBDOS8va0p3KzBiL1JKUVVQNm9VQm1JMFRQK3ArTCt2SHdR?=
 =?utf-8?B?YXZiSWZhUlF0clIySHFnZlBmT1VEeEdHSTRLM3phaU5LMS9PUzE4V040YXd3?=
 =?utf-8?B?Zi82OGliVEhZVy9Tby9ZNm8rRDlWWElJbXFFazdGeU4ySjZjS2F2L0RDRkFk?=
 =?utf-8?B?YktkbytvVVhTWW5oNDJHQWVON0M3Y09IV2VWTnNQc0tWYldKeEtlZW5rWTBO?=
 =?utf-8?B?MExnS3hQaDhXM1RWcExwVW5EVHRsamVvcUtlUHI2ZVd6a2kzVkcrWTdUbm9y?=
 =?utf-8?B?d1pOeFZod1o0cmtPdUF4VVVTRHJqMUNjYWdpWjhNNmJMVkpGM1BFdGZkN0Jp?=
 =?utf-8?B?VXZvUDRBQjdpeWpQMWNEcHluc1NMU1hNZ0dQdUoxb0phVzVzZFBqTHZtd3p5?=
 =?utf-8?B?RkFOOTB0VHBDZ3g0R3Uza1BJYWw2UVhWRHZYdVBZL3IzUFc2VWhKUWNMYUxL?=
 =?utf-8?B?YVBvTnE4TE9FUk1mTzRBRnlmUUpjUUljSGg1WlVkQzdLanNFR2xHRTRDbDd1?=
 =?utf-8?B?WWVWY21BeEJrMG5YOTZqR0pEejNETlQ1dmZhUk1RcDgxWVpDWWJ3OW0zTDVj?=
 =?utf-8?B?YUF1U2s4ODNDU2ZNUnYxc0ZrampvNEhadnA3K3NNMDFzSENxV3JjQ0ZvRjhY?=
 =?utf-8?B?Q0o5YndZWG05ZTZ3Y0xvMU9oM1JTOS9BOVJhSVozdnhqbGFTZkFWUit6ZUV0?=
 =?utf-8?B?K1IrYkFzUmtDRzJ1bWdYTlI4RStFQWhlbGQ2SExveXdEL1FTaXVvQm1ZTS9m?=
 =?utf-8?B?SXZ5dStleFdaYzhhQTkrTXdwZStJMndhaUdiMjFaR2xMRVFLbHNXeHd0TjlD?=
 =?utf-8?Q?LHF8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870e7cfb-7017-4fd2-985b-08de3cf37d38
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 22:36:01.2898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5/Au1fa+O/3rOSybHMRUQVy9PplQ5qbVy0SN3RvxSk94w84B82/FU8V2wv4NiGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201
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

--------------RpzBTZyUlxyfhkp0G0N0jmgs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/15/2025 10:56 AM, Philip Yang wrote:
> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
> to GART as mtype RW caching, to reduce queue switch latency
>
> Add GART mm_node to kfd mem obj to free the GART entries after
> MQD mem obj is freed.
>
> Use resource cursor to handle VRAM resource which maybe on multiple
> blocks and use cursor_gart to handle GART entries.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>   5 files changed, 109 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4f8bc7f35cdc..d7bf96a7b6b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -880,6 +880,67 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/*
> + * Same function and MQD description from amdgpu_ttm_gart_bind_gfx9_mqd,
> + * except this is for MQD on VRAM BO and use dynamic alloc GART entries.
> + */
> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
> +				struct ttm_buffer_object *tbo,
> +				struct drm_mm_node *mm_node,
> +				uint64_t flags)
> +{
> +	uint64_t total_pages;
> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
> +	uint64_t page_idx, pages_per_xcc;
> +	struct amdgpu_res_cursor cursor_gart;
> +	struct amdgpu_res_cursor cursor;
> +	uint64_t ctrl_flags = flags;
> +	int i;
> +
> +	total_pages = tbo->base.size >> PAGE_SHIFT;
> +
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
> +
> +	pages_per_xcc = total_pages;
> +	do_div(pages_per_xcc, num_xcc);
> +
> +	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
no need use cursor_gar. mm_node->start + n indicates where to update 
gart page table.
> +	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
> +
> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> +		u64 start_page;
> +		u64 npages, n;
> +		u64 pa;
> +
> +		start_page = cursor_gart.start;
> +		pa = cursor.start + adev->vm_manager.vram_base_offset;
> +		n = 1;
> +		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
> +					   flags, NULL);
> +
> +		npages = pages_per_xcc - 1;
> +		while (npages) {
> +			amdgpu_res_next(&cursor_gart, n);
> +			amdgpu_res_next(&cursor, n * PAGE_SIZE);
> +
> +			start_page = cursor_gart.start;
> +			pa = cursor.start + adev->vm_manager.vram_base_offset;
> +			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
> +
> +			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
> +						   ctrl_flags, NULL);
> +
> +			npages -= n;
> +		}
> +
> +		amdgpu_res_next(&cursor_gart, n);
> +		amdgpu_res_next(&cursor, n * PAGE_SIZE);
> +	}
> +}
> +
>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>   				 struct ttm_buffer_object *tbo,
>   				 uint64_t flags)
> @@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   	return 0;
>   }
>   
> +/*
> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
> + *
> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
> + */
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr)
> +{
> +	struct ttm_buffer_object *bo = &abo->tbo;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	uint64_t flags;
> +	int r;
> +
> +	/* Only for valid VRAM bo resource */
> +	if (amdgpu_mem_type_to_domain(bo->resource->mem_type) !=
> +	    AMDGPU_GEM_DOMAIN_VRAM)
> +		return 0;
> +
> +	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
> +					 amdgpu_bo_ngpu_pages(abo), 0);
> +	if (r)
> +		return r;
> +
> +	/* compute PTE flags for this buffer object */
> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
> +	amdgpu_gart_invalidate_tlb(adev);
> +
> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
> +	return 0;
> +}
> +
>   /*
>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 25640bed7dc9..9f07856433fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>   
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
> -
>   int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>   				 struct drm_mm_node *node,
>   				 u64 num_pages,
> @@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   		       u64 k_job_id);
>   
>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr);
>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index f78b249e1a41..edb72f4ef82d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>   	      struct kfd_mem_obj *mqd_mem_obj)
>   {
>   	if (mqd_mem_obj->mem) {
> +		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
> +					    &mqd_mem_obj->mm_node);
>   		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>   		kfree(mqd_mem_obj);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 14123e1a9716..5828220056bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>   			kfree(mqd_mem_obj);
>   			return NULL;
>   		}
> +
> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
> +						       &mqd_mem_obj->mm_node,
> +						       &(mqd_mem_obj->gpu_addr));

Here you create new drm_mm_node for gart page table entries. Before that 
amdgpu_amdkfd_alloc_kernel_mem also creates gart page table entries and 
drm_mm_node. Is there duplication or how do you handle the 
entries/drm_mm_node from amdgpu_amdkfd_alloc_kernel_mem?

Regards

Xiaogang

> +		if (retval) {
> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
> +			kfree(mqd_mem_obj);
> +			return NULL;
> +		}
>   	} else {
>   		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>   				&mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 06cd675c9e74..55738b30c2ec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -253,6 +253,7 @@ struct kfd_mem_obj {
>   	uint64_t gpu_addr;
>   	uint32_t *cpu_ptr;
>   	void *mem;
> +	struct drm_mm_node mm_node;
>   };
>   
>   struct kfd_vmid_info {
--------------RpzBTZyUlxyfhkp0G0N0jmgs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/15/2025 10:56 AM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251215165630.1172383-7-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
to GART as mtype RW caching, to reduce queue switch latency

Add GART mm_node to kfd mem obj to free the GART entries after
MQD mem obj is freed.

Use resource cursor to handle VRAM resource which maybe on multiple
blocks and use cursor_gart to handle GART entries.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 5 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4f8bc7f35cdc..d7bf96a7b6b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -880,6 +880,67 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	}
 }
 
+/*
+ * Same function and MQD description from amdgpu_ttm_gart_bind_gfx9_mqd,
+ * except this is for MQD on VRAM BO and use dynamic alloc GART entries.
+ */
+static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
+				struct ttm_buffer_object *tbo,
+				struct drm_mm_node *mm_node,
+				uint64_t flags)
+{
+	uint64_t total_pages;
+	int num_xcc = max(1U, adev-&gt;gfx.num_xcc_per_xcp);
+	uint64_t page_idx, pages_per_xcc;
+	struct amdgpu_res_cursor cursor_gart;
+	struct amdgpu_res_cursor cursor;
+	uint64_t ctrl_flags = flags;
+	int i;
+
+	total_pages = tbo-&gt;base.size &gt;&gt; PAGE_SHIFT;
+
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &amp;ctrl_flags);
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;= IP_VERSION(9, 4, 3))
+		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &amp;flags);
+
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
+	amdgpu_res_first(NULL, mm_node-&gt;start, total_pages, &amp;cursor_gart);</pre>
    </blockquote>
    no need use&nbsp;<span style="white-space: pre-wrap">cursor_gar.  </span><span style="white-space: pre-wrap">mm_node-&gt;start + n indicates where to update gart page table.</span>
    <blockquote type="cite" cite="mid:20251215165630.1172383-7-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	amdgpu_res_first(tbo-&gt;resource, 0, tbo-&gt;resource-&gt;size, &amp;cursor);
+
+	for (i = 0, page_idx = 0; i &lt; num_xcc; i++, page_idx += pages_per_xcc) {
+		u64 start_page;
+		u64 npages, n;
+		u64 pa;
+
+		start_page = cursor_gart.start;
+		pa = cursor.start + adev-&gt;vm_manager.vram_base_offset;
+		n = 1;
+		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
+					   flags, NULL);
+
+		npages = pages_per_xcc - 1;
+		while (npages) {
+			amdgpu_res_next(&amp;cursor_gart, n);
+			amdgpu_res_next(&amp;cursor, n * PAGE_SIZE);
+
+			start_page = cursor_gart.start;
+			pa = cursor.start + adev-&gt;vm_manager.vram_base_offset;
+			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
+
+			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
+						   ctrl_flags, NULL);
+
+			npages -= n;
+		}
+
+		amdgpu_res_next(&amp;cursor_gart, n);
+		amdgpu_res_next(&amp;cursor, n * PAGE_SIZE);
+	}
+}
+
 static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 				 struct ttm_buffer_object *tbo,
 				 uint64_t flags)
@@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 	return 0;
 }
 
+/*
+ * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
+ *
+ * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
+ */
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  struct drm_mm_node *mm_node,
+				  u64 *gpu_addr)
+{
+	struct ttm_buffer_object *bo = &amp;abo-&gt;tbo;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo-&gt;bdev);
+	uint64_t flags;
+	int r;
+
+	/* Only for valid VRAM bo resource */
+	if (amdgpu_mem_type_to_domain(bo-&gt;resource-&gt;mem_type) !=
+	    AMDGPU_GEM_DOMAIN_VRAM)
+		return 0;
+
+	r = amdgpu_gtt_mgr_alloc_entries(&amp;adev-&gt;mman.gtt_mgr, mm_node,
+					 amdgpu_bo_ngpu_pages(abo), 0);
+	if (r)
+		return r;
+
+	/* compute PTE flags for this buffer object */
+	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo-&gt;resource);
+	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
+	amdgpu_gart_invalidate_tlb(adev);
+
+	*gpu_addr = mm_node-&gt;start &lt;&lt; PAGE_SHIFT;
+	return 0;
+}
+
 /*
  * amdgpu_ttm_recover_gart - Rebind GTT pages
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 25640bed7dc9..9f07856433fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
-
 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 				 struct drm_mm_node *node,
 				 u64 num_pages,
@@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
 		       u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  struct drm_mm_node *mm_node,
+				  u64 *gpu_addr);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index f78b249e1a41..edb72f4ef82d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj-&gt;mem) {
+		amdgpu_gtt_mgr_free_entries(&amp;mm-&gt;dev-&gt;adev-&gt;mman.gtt_mgr,
+					    &amp;mqd_mem_obj-&gt;mm_node);
 		amdgpu_amdkfd_free_kernel_mem(mm-&gt;dev-&gt;adev, &amp;mqd_mem_obj-&gt;mem);
 		kfree(mqd_mem_obj);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 14123e1a9716..5828220056bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			kfree(mqd_mem_obj);
 			return NULL;
 		}
+
+		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj-&gt;mem,
+						       &amp;mqd_mem_obj-&gt;mm_node,
+						       &amp;(mqd_mem_obj-&gt;gpu_addr));</pre>
    </blockquote>
    <p>Here you create new&nbsp;<span style="white-space: pre-wrap">drm_mm_node for gart page table entries. Before that amdgpu_amdkfd_alloc_kernel_mem also creates gart page table entries and drm_mm_node. Is there duplication or how do you handle the entries/drm_mm_node from </span><span style="white-space: pre-wrap"> amdgpu_amdkfd_alloc_kernel_mem?</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:20251215165630.1172383-7-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		if (retval) {
+			amdgpu_amdkfd_free_kernel_mem(node-&gt;adev, &amp;(mqd_mem_obj-&gt;mem));
+			kfree(mqd_mem_obj);
+			return NULL;
+		}
 	} else {
 		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
 				&amp;mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 06cd675c9e74..55738b30c2ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -253,6 +253,7 @@ struct kfd_mem_obj {
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
 	void *mem;
+	struct drm_mm_node mm_node;
 };
 
 struct kfd_vmid_info {
</pre>
    </blockquote>
  </body>
</html>

--------------RpzBTZyUlxyfhkp0G0N0jmgs--
