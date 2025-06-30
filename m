Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4165FC8302D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 08:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E049610E3BF;
	Mon, 30 Jun 2025 08:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KU2yJtzX";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D00A10E3BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 08:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN7NnV8gqEnbAjZhRh65YoCzUmXIvOu2j4ABNEY/DlNEdhTiuI7y13Jx3JNwGpYESoPIL4T8mkQocXsRVy7Tn8StpuyTR2Gmbb60qXmErtWEueN+6Q/bmxWZGHpx5ZUvzIpunQ3l5Q10y39bwn2f0T7YqulnDpLSMxYDRagz00bmQlHwfz1W/Rj8S8oYxgItVceVfSxscOthFhTUEzY1BHcvIX7cmYjbV0dckURXm1XMBP+MXVlVrz9ZSGsiNR2YZcy5zkyLyr2rX8RNIpj00KEqx2kWyClms56Y+CYER5qVeAk+n8vaywNhyuT+cpxUAvZH3xMq9xc5mXrn0u+GhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPoLy7FJqYBzN70K5RLa5qgGB1MQMSCdiCJgqCZvNIA=;
 b=SGaPlQQ9OBjQLHWNQyT52vUq0nLHLtiWQTPqCUA0eOtSnRmY3Z0dcncTgHi6/jyrzLZo4hnT4bGeokEGA/zZjIoFQ75wJGYOHRrkFN+Mega6WbpY5KUL/mfLyv25kruoXlJj6lUq6CVZHhksPIOYZe3tzdkfikYA/p2FLx4Dv7zK1avLFOuOnWfkLdokN0j97sz30FRV0DNX/NMj7tJDtIJNInD5tMhXOlYVzTuvM/Bu1DmeB8iuL9XweDhpaWHHK77ZvQqc9hEUGRnVYVBHWPd13JGU5C5vsktz8g7Ups6lWjFKjQDv1hEHB+HhOmsNnfScysaQ4+3yeuBj7o42ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPoLy7FJqYBzN70K5RLa5qgGB1MQMSCdiCJgqCZvNIA=;
 b=KU2yJtzXroHl2NZeQ3GDUEhi0lvAlXn8EZwaLGGSMo6N4JeSjhkELi+30/dzEqrKOGcaSm+cblMzD1/mw/J4yTFPkcQwx2VYW2kSCfnhr6puimd8vGpUQYOnKMfYAmxj8se/NalnFsQFVItvHdb/3F3AWykOvIDgEd+zamqeKUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Mon, 30 Jun
 2025 08:40:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 08:40:37 +0000
Message-ID: <fd35ac26-d510-47ac-a98f-0643c1525f1c@amd.com>
Date: Mon, 30 Jun 2025 10:40:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] drm/amdgpu/sdma: consolidate engine reset handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250627034002.5590-1-alexander.deucher@amd.com>
 <20250627034002.5590-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250627034002.5590-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:208:32f::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: af750c7a-f13f-4412-29f5-08ddb7b1c985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmlBS2hObW9adjZhejBUTXVkck1MV2laaE4wZmd4OGpEUEV4UXk1dDdGMHQ4?=
 =?utf-8?B?MFdIRmN6MERtWDEydzIzVVgyY2ZLT2NzM2xhVVN2Sm9pNEZLOTIvY1JsblNI?=
 =?utf-8?B?TXIxb25vdzRwRGRkbmhScVVOcUR1Y2taZEhsNDJCRW9jdXAwOW42bzRFWUx4?=
 =?utf-8?B?UldLN1Q2SW9ZQ2FSTTNobnJnSTMvL2t2Z1J1YlVXNE1nM1IxOW9uMHpPSXE0?=
 =?utf-8?B?THk2L21pSjZXa1Jvb25ZQW5UNUJsUUc0SHBhdW5lVGVvdndWN2FvR01SeElB?=
 =?utf-8?B?T2RrN2FZSEJVVzdLRUxQSEZ6c2ZuRllPOUxIaTluSk5sOXBla0Y2N0tXaHRl?=
 =?utf-8?B?bnV6R1piUzA2S0pEcnBRYTF1cXBiTE5WdStSYmxXTUhQSXRmcnlydXFXbW1R?=
 =?utf-8?B?bEpWL0dSWHpXTHVvTk1Cc2czWEszZTM3MGZuTlVtY1NoOHpMaks1UXlidFF0?=
 =?utf-8?B?c3BnK1FDVHFhTEpyNTRNTFB5T0diQ01GdjZpYitKQk43SHl3SkphMC9vWUxO?=
 =?utf-8?B?T2tpb1F5WGExL1BqQjRubjhvaXEyZDVMTDFSVWR4a1lnemRMcWFhNmJWOUZq?=
 =?utf-8?B?NXhUV3I2UXpsSmw1ZnJyVk9mUWgvU2ZlVlNxYmVBTmEyalhUYTVENytPcytD?=
 =?utf-8?B?eGhKRUFIUDgrOWM5L0w2RHBvTGF1QnJhZGJ1dnBVOHZUMHJFN2VJb3Z3dmNC?=
 =?utf-8?B?Zm5uMjFRRnNGSnJKU2RqYVhESmpMSzdHdHBKRHlPa1VsYzJCNEp3MlRlMXpr?=
 =?utf-8?B?czlHVmlGZThrVmhBcWZTTFoweG1JUTZwNWpJOHZvSEl3ZkhEdmtTNU5WcFli?=
 =?utf-8?B?eE5YbE0rSnJCSDN3Z3Y3VDByUFZPSERXejhXbnZFWm9yZDYyNEJSKzJtR3RF?=
 =?utf-8?B?cXNBZldFejZzVXhncWlZRTdpSmRTck1VekNiU0laQWVBQU81L3VmemszcEJM?=
 =?utf-8?B?ak92TUlHMmlMUUdCZ0Vmdjk2Sjd2eDFnZE94eTJHSm51bWMycE5KSnNSTlVy?=
 =?utf-8?B?Ty9EQ2g2UzBCRjhvMTkzRlpnSFA1d0NHbDJXdUNsTGtkbmNzZDJUUHozQ1hF?=
 =?utf-8?B?NGtuWDVkRG83SUI5SGdpVVpwak4vQVVxQ09Ed09wS2RwMVk2ZnJxRHl0a2VR?=
 =?utf-8?B?azVPREdNNUd2NDhpZDduNTUrZmZiV1lNMEFFdVBaSzI4NHN3S1FIYW16VTJh?=
 =?utf-8?B?MDYyMlhLb3NkRDVNQ1p0L0tnNUM5WEpOWXdWUWUzeVJBK3FGUFB1TmN6MW1J?=
 =?utf-8?B?QnRNUFh3eTZzMnpyY252Sjc4SkF0VlVxZ2w4dnlnQVpHZzZsYlRNYStzdXpk?=
 =?utf-8?B?SzdXaHJIeUZkTHFBdnRCQWMyRXdyN29lL0s2SkZrdEdKMWh0QmtXdFZmNTBU?=
 =?utf-8?B?M3F6MGFOb2o0enc0VzVQM2F1QjFmbGx4TFpOR1A1VjQrODBNcTh5d1ByTjBJ?=
 =?utf-8?B?UEs4VU4wNnZoMnEyMDQvU2lsQi9WSUp5bU8wdVZkdURaQkg2TVdiaHBnK2Mw?=
 =?utf-8?B?RDNodVFQVDFWS2FIV2pCUlpGdXNKMVNHYmgrRmRMMHdDdlhaMGRvS2NoeFFK?=
 =?utf-8?B?RE0wcHdrV2hpTFZQQW8vaUo5SzBpN2lKeVpnZ3hRZlV4b0ZnUGpINTc2SHFl?=
 =?utf-8?B?OHR2NTlMNEtycG5POWh2Nk13Q01EK2VRQmx0VlBXOXBuU3hQb3BYdmhKN3hq?=
 =?utf-8?B?cHRFd3E1T2tzOXJTcHNrUHI0aVBWL2NWNFJDcXFWcXR2T3NPNkZHOEZXUnNR?=
 =?utf-8?B?UWxLUTk5blM0amo0WStkb0NFcWZZRDVhZlUzS2QvUWRTZm1tajNCM1BaOFo5?=
 =?utf-8?B?QnJkWE9LUzRvNE1KUlE3bzBXdFNEMy9weHU0VFhOQmlyV01Va3ZkUllvSjIz?=
 =?utf-8?B?N3FkdGMvcVVTYTg4V3FlMC9nVXhmb01VWk5JVmZTaXBmRjRyVEZnMHJpNkJ6?=
 =?utf-8?Q?KPqyeCf8nVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktXMjU5YXlFekRNZG9Fd0NVKzlLZHcyVTIzRlVkY0oyckc2allOYkdVaDR1?=
 =?utf-8?B?Mk05bGd1VU1IVUk2MTdNTFlTOHlsV0xZRXUweEhmQTYwSEwzRXhpTzdwQVlU?=
 =?utf-8?B?eEw5ZlVGbTF2aGNPMkFTenVNSXBtemFNNXdZWmpuNDl6VmZkUkJSUVNZcmFm?=
 =?utf-8?B?MFlWaTFtcjloNk52My80MjhZcjVHbmNXb2NPa0tMTENEclgvb1p6czk4aHgw?=
 =?utf-8?B?ajJFTTlGNUcyMmp3VENXZjlLM1Nvdjh2VlZLV3BEY3diVFR4TkcwdCthcWFX?=
 =?utf-8?B?bzFKYTRDK3dvUE5ic201YjVmTmozYWtreER0UFBIVk5MSUZ3WStobnpoWVFw?=
 =?utf-8?B?bTJlSVd2UWpsUllJekZJeXpqNG9VQVhzdGJHUFhqWVlYTjBwaEEvOGV1Z0FB?=
 =?utf-8?B?dXBlaDA4Y21KRk5xNkNHcjJMWDdMNDR5WGl5K01KTVFzeTI2NFF3cXVwY2sv?=
 =?utf-8?B?KzVFWjJzeGVrUGJrSkdhYVo3UFpFK2ZDSksrSHdkalc1MWxEbGMvVUdWUi9s?=
 =?utf-8?B?YWhHZWxsV2VhR3hlbU1may93Q3RWa01FTUFRYlFkQ2FGR0tibDgxc21Rdllk?=
 =?utf-8?B?K2cyYkthMHRFRWFOTTh0cmFkSWNpblRzbHFNbmtycDl2aXRHa3NxeTV0WmdN?=
 =?utf-8?B?VXEvZWV4ZnJkTGRHcDg1aUpXV0ZPYUd0Tld3UmM1ajMvQTZsTTBsbk9kektL?=
 =?utf-8?B?V1J4NkpCdHRRT011eUlsaTIraTZHdDdkdTFTM1o2UVcyb0liMDEvV04zdzRk?=
 =?utf-8?B?d2lGTWpEcE02UC8vb09XTEZXd3VzSUxYM254RXJ1QzBCdnN1dXVFTE5GU05F?=
 =?utf-8?B?OG04S1k4UmV1OEhIb21UK3YzdGp4cTRvZDBNQVpYKzYveGlpbS9wZkdrcDdY?=
 =?utf-8?B?amU4WXZVamdzQ2RwNWZ0R2QrbnhjR3RCK09RQzZpaGJLRUdRTUxOVHRlSFhj?=
 =?utf-8?B?Nk8xbjNEUTBOTXZGQ0RyY2g0UDF5cjZyMjBOUnJHKzFLYlhrdkpUT0hCb3ht?=
 =?utf-8?B?aWFvNVpGUks0Nit4WldtdERxRHhwSkpMaVM0SWJiZGtxRWE4T0NkTTdJS25h?=
 =?utf-8?B?TnJwejRoV1ZDNlRrSldMSmdnUEFCcm1neUgrNEhTMXRYSW4wSEpaL0RlL1Ra?=
 =?utf-8?B?WldvNmN5NUtFeEtZRHQ3WkgxRGYzYlFMdFBjQmR3MS95RFJGM0RTd2cwSmdl?=
 =?utf-8?B?ZVUvWmVoU05OU0VCYS9JdTdoUGpwMUZXR0FibHNEeGdPMnRpd0NnZElrRVds?=
 =?utf-8?B?WkZ4elJpaW0wWjRJRnMxaFNVWUFVN1A0YkllMlB6SFRweDRkTGE2ei9YUXpP?=
 =?utf-8?B?bCtCYUJtdnRUNTQ5NkdIRXlsYTNIdFlRZkU3ZTVySmdmVDhYWWR0VGhVVWVG?=
 =?utf-8?B?aEZlSlZLakpidDhaTlFPR0h5Z1hDYVlDU2JwNFV5VjVoNGErazFwNHhUVVdB?=
 =?utf-8?B?M3hjcDhCNlhId0sxQWNWTEMrQUsrR3RMNzVSZXRaNVVTeEx0Z0phSUs2clJH?=
 =?utf-8?B?cFdVQlFyZVZHNlVwYUNNb2R6TVE5VHQyNHZIaURtbmxKZkhhdUJsSEpYMEN6?=
 =?utf-8?B?QklxMEtGYmwwY3ZUVlNWSGNjeGNvRnJGQWRxOWVXNmVicllmMHJEc1VXQ3FW?=
 =?utf-8?B?VDVTcWpTRXBHbEQ1OVBEdGREQThUY0IrMzJqbUxlbW9WQXpVVEZUYXdWVnBl?=
 =?utf-8?B?QmxhU1l4R1c0T1FabkZwOCs3V0VwWTh6L0RrdXplWFVYaVg5SUV0THdRTkRZ?=
 =?utf-8?B?QVBGNXg4WnpBTWFYVFpCK0NVUE9iWXA1a3hmVXZHaTl6S25reGtRS2xDRng0?=
 =?utf-8?B?M2pXekZhSURMUFdFbGF0OUw5MFhMNXVEd2swYTdXU29TZ0VJNllOdGFZUCtJ?=
 =?utf-8?B?QnJrNjM0OE5Ydmx4MmpSNlBnc2hQc00raGJBQU0rSjVGbWpBSFJNSThlMkdB?=
 =?utf-8?B?ZWNkVUo3aFQyTjBQeXpYYmxPSC80a3VVSC82SFFnY0hMUk1ONktPVXRWRzd0?=
 =?utf-8?B?VDJOTDM5NjUxU053eFF3cXc3TG1oS0NDbEVJREgvR3g3dGE1RWlqSmU5Uk1h?=
 =?utf-8?B?WXAzVnpCUVJ6enRZejNKNGo1bU1mdjQ5SzkwSlMrTU5iaENVbVhQOVE3Y0or?=
 =?utf-8?Q?WrrPDHytrftEp4o+TyrD8Awwu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af750c7a-f13f-4412-29f5-08ddb7b1c985
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:40:37.6329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpHXqTSOV1FSTKA5Mmy5cjlcmHZKGX/s/WsTWG4kt0xdh53bvMbE5RyBChiEj5j/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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

On 27.06.25 05:39, Alex Deucher wrote:
> Move the force completion handling into the common
> engine reset function.  No need to duplicate it for
> every IP version.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 17 +----------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++----
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 ++----
>  4 files changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 7e26a44dcc1fd..56939bb1d1a95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -590,9 +590,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  	 * to be submitted to the queues after the reset is complete.
>  	 */
>  	if (!ret) {
> +		amdgpu_fence_driver_force_completion(gfx_ring);
>  		drm_sched_wqueue_start(&gfx_ring->sched);
> -		if (adev->sdma.has_page_queue)
> +		if (adev->sdma.has_page_queue) {
> +			amdgpu_fence_driver_force_completion(page_ring);

Calling amdgpu_fence_driver_force_completion() here sounds like a really bad idea in the first place.

That will mark all fences as completed making it impossible to execute the remaingin work.

Regards,
Christian.

>  			drm_sched_wqueue_start(&page_ring->sched);
> +		}
>  	}
>  	mutex_unlock(&sdma_instance->engine_reset_mutex);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index d3072bca43e3f..572d105420ec3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1714,7 +1714,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_mask, tmp_mask;
> +	u32 inst_mask;
>  	int i, r;
>  
>  	inst_mask = 1 << ring->me;
> @@ -1733,21 +1733,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  	}
>  
>  	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);
> -	if (r)
> -		return r;
> -
> -	tmp_mask = inst_mask;
> -	for_each_inst(i, tmp_mask) {
> -		ring = &adev->sdma.instance[i].ring;
> -
> -		amdgpu_fence_driver_force_completion(ring);
> -
> -		if (adev->sdma.has_page_queue) {
> -			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
> -
> -			amdgpu_fence_driver_force_completion(page);
> -		}
> -	}
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 4d72b085b3dd7..ed1706da7deec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1618,10 +1618,8 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
>  
>  	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -	if (r)
> -		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> -	return 0;
> +
> +	return r;
>  }
>  
>  static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 42a25150f83ac..b87a4b44fa939 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1534,10 +1534,8 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
>  	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
>  
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -	if (r)
> -		return r;
> -	amdgpu_fence_driver_force_completion(ring);
> -	return 0;
> +
> +	return r;
>  }
>  
>  static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)

