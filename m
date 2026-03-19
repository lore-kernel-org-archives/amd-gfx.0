Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475B0108E1FF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 12:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9FA10E862;
	Thu, 19 Mar 2026 12:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xfGrhtMi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E75D10E862
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 12:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eg/T9sOwmx9duN0EWsITd/KcO6urr7Q4GvLtDsw+sBVNob6SX6hcT+5s2IkLFFbx219xOmNOe9mcr5q0941JHSBCf5h0ngsMGo4GXlJ24Rcyah/uJ25QjBCZ0XRViKwOT3iTAUIa8fOKXevtR4hvjej/AFZBvpbUJEULNBIRuasutIe1TzZE8gt3esL4eXzfKWK/nOB1/8leqBDDQx6EojgZJ27hcs65e5W5CUDVZz+ovzMNGFlpD3RFFyCmYccbGaJP6a/7w8pOUaCSXzF+9hbVUoATk1E81v717cZSBlMIimOVVkrOi+XpOm4yvXy7zaC2RO01iF1y5N/WFARP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7dgZjOlvbp+vRRvRDhdHYgHrvmdu92eUp5fJsY38OM=;
 b=P3tIuDgSfrWtMgweNz0oQe1ujiVLCMeALiDegVPoaNHoJAzG9lm4dv0HsMSURT5X8AaGzDSGJ1CRQ+FvjgYls5jm66tJUDB5/Cm7afF+7886+tVtgvhYOD/jaH8rb7b55PD/jknFgJacCLPadisW7C1iNnaQ4d7dTC8GJMdw6IQVObUDESNAha56MueoQhP7P1MURdUbHZzLAVwPEGAHm6XwXpucIiWUNlSla4W5OpLmtyLMw+h+EUcIfnmkZyKAdEx/xH1RhdbmKTAolSAy76rBFg4P0wqsgtr8U2FsdxdpDkx+dd63kgRsV4KkbFKrRKGeBT8v/2PtV9uAhZwmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7dgZjOlvbp+vRRvRDhdHYgHrvmdu92eUp5fJsY38OM=;
 b=xfGrhtMimEQLuhfOqolF9LyMZtqGuRTs2zqFsnP/dibZy8LW665BttvMotd/7aYz3pGvDoazQKAFNNljqOaH/Jx0TvcyhfZdulpZvcLU5GsCuZEDqPK5fWlzcsiQ1xciVlvShIHDEcvg37iBaEcWDj0pm1/RvHE8BA8rBprbiUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 12:26:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 12:26:55 +0000
Message-ID: <ff1a5fee-33ec-4a72-999e-c8645321bbe5@amd.com>
Date: Thu, 19 Mar 2026 13:26:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip discovery dump when topology is
 unavailable
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260319105934.1989939-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260319105934.1989939-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 162482cd-aee3-40c8-14be-08de85b2cec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: XGCF/TJfBmj4nFmSBtUaMCoXZjqyKKRqjbS3ME/wLK9YTke19TOe8I/8aLb74KEspp/zVMTHSPDoRhlhrPASsF3iCi23XU944VK/po5oVmr1GlHWbfHUXEPrbu9K4gYCsW33hbU4BH7p+WgfKSjKs9SUV0/zWThCzqmbEqQpDDhcE7uKAQKAGMWFMYDopxDS9qs3Y7FjwYT+kB1qIaDrOL7MYQnSUswLK4hcg7KGLZbbs9BLJH2yFLA7SGpABMPfX9CkLZalVyEcZTdZgg2eow46rkfqWTPIaDuEMuz22esm+T5qnadu1l/6XAeoswj3jHBjh03ThPl01NMDFo7dPTR8an0L/SgEjSOGPZZk/N741B/pHMd/K+bRnCtaZ0hLFKpnd77KMHAzudwl3PxXX8k8gxjQEIRZEUmlLMDiaNpL8/sfIePZez7+StErlp9/RD8ACS5Dc5u27J2ijviznbcwPUGoOrXyDheyinh4/YetSPYFKfidytlVboRhu1QRLJFGTz9LR8C28MbcjCEDsaCFLGDYrl/DeOfl5qUY1DgvaCLJ25OB7BmxU0dt4IkNuCDZUelD3htewaakSN9exZ7hDk9i6smYnFmDjK3HJKujCrX1N6/XTJVT1zxn/4uh58MlfXJbqc1CQ3hdocP537A4LbwosiLcrNctss6eYH1rM9b5IO0yHd8F6b+miPayEdm85HgrFYpKxezmWWFRm+rdDPCivZyg9lZSyM4M2Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1p4WVJ0TWJER1V1OElXcjlpRDlRTStINGloaDlOZjV5NnBpSWlDV0V0Q05V?=
 =?utf-8?B?MTdRdUVEbTRiTFFhNk11aEpwV1Jza0lKb2dvVnIzRWVwd3FRd01LS1RDc1gz?=
 =?utf-8?B?eW9tVEoxUFdiWjM1ZXZNcjM0d1lYd1MzMURlSzFuL1JCdFM0YTZ4cmdGQVVT?=
 =?utf-8?B?ZFBiVkRCZnRFU0p1dHArUG5iRE5PekdZajFIZHlzZ2s4Y3hpRERWUWFFOGpp?=
 =?utf-8?B?cVdrOVJJcHZwanVKeWVLa1YzMGVnbUpJWjgwZENSMlAzNHFzQ29UdGRmcmZW?=
 =?utf-8?B?TnlFL2lQblo3eVhXdk1aNk1nWkg5TjZxbGZLSVgyaVF5UmZFWnlIekh4WXRj?=
 =?utf-8?B?emw5K3NnaXpiMDJNNU1ZMjRBUG1VSnF6c21BVFRhUGwvUnREWGxYZWNURnJL?=
 =?utf-8?B?bDJNVUErWGtyT05RNEZYU3dXUVhpYkdzU3N0WDNRMjdnOTZOZWtha095ajVU?=
 =?utf-8?B?a0doblBGd0FWUEg0UkdrcWxLM0MzRXdrZ05oNWlKUURjU1BZYmh6RGY5R05t?=
 =?utf-8?B?RjdOMy9ZMHlLR3Z2eEE3ZlhjTHlOb0lQWlJoQXVvRHhqRm9zQzEwNHZ4OUhY?=
 =?utf-8?B?VkxUSkJFUUJPTE9OSnZnVDNqcUZSS3RrbnZZNU1EaVZibzk4Y2NjUmhLdGRs?=
 =?utf-8?B?VWFoSm5aM29sZzF1MU1KQ21KUm9lLytVZnVqK01uVmpacktuU0ZRVTF2WVRj?=
 =?utf-8?B?U1FhbUIyMTFWbjBzd1NVQnVTWUQ1eGU5WTNUT3A0alIyZ29kTWVaY1hNamhw?=
 =?utf-8?B?MTBYcit2cm1XeTRxb0IrNXRaTE9XVzgzckEzemlNeHBOc3JGVkg5S3B5VU5t?=
 =?utf-8?B?WFdVTzFLdXN6TFRyaGN6NElBT3ZOby9WbGJ6NHVOMi83bzVjK3lWZVBEQ2Jx?=
 =?utf-8?B?eFJpSTZaaXg3bXA1VEtMRWRJWC9kNGdXdkRya29nb1dNRjFqNFRsWnFUNmtu?=
 =?utf-8?B?S3ROSWF5SURhTmg0M3lLRzEzTis0QkFvcWJDR1Jmc0VJL2NzdkEyTlp2Mk5R?=
 =?utf-8?B?VTdyTkRtbVB3NnhibUNEajVUdit0WnZTUi9tNitraFFVOFU3YlNSbm02SGdj?=
 =?utf-8?B?K1hhbGFkV1RYRHVMcFhCYVVSMW1wVGRFWHVsSm1LTWFpVFBQSjd2cHFmWGZO?=
 =?utf-8?B?NEhraVNJcjZMT2xkVFAreGhUNGJxTE85V2tLWmFSUUlwNFU4bWgwNURDNVZj?=
 =?utf-8?B?eEVzaDBuUndudk1QQlI1ZkdYa0hrdHVpREpuUThJWFUzZXBuUFAxb0dwRTRL?=
 =?utf-8?B?VmU1bVpMYVc5RmgxMEE4MnY2U20ya0c3MTlZWkhkQm5EWUQwN0MxdEZqd2hq?=
 =?utf-8?B?RDI5Y1hodmo2V3dBTEJuMnNldFFXOEtUR1Y0U1Avbklmejd3ZWFaN0hxRGNo?=
 =?utf-8?B?VFU5MVR5Wm8zenhBc2VpbHpXdUVnd2E1S3FSS3A1a0RaeThmYnpTWDcxY0lF?=
 =?utf-8?B?UUNOWFAzMm1rakdTTml1TUZWY1lNdEpSQWNhd3hTS0h5Rlg4YS8rZXo1V0pZ?=
 =?utf-8?B?cVVNZHRpWWVIWmlHQ2h1ZldENm5MM1p0UUVWQjdBdmtHOXNKRmJzZEVKRWlJ?=
 =?utf-8?B?bXVLbVhlVjZHbU53eE5HTnRQMndJUFBmOVRJRkZEL0R3TFFkMTFOUG9qZWNh?=
 =?utf-8?B?dnlpZDF3MG92eGIrcWRXV25idUdjK29rWUNZMGMwUW84U01mOGR2THNMY2xi?=
 =?utf-8?B?dXQ4YndLVXdMRVFMMDRZYkVjWWlBWlB6a1ZQcGErM0V0dzhqV3NBNGw2RWp1?=
 =?utf-8?B?N21mNEczMzRQbThaTFZobS83MlUxVVJHbnB5QnlNZURZTS91cE9KUWRpdGRl?=
 =?utf-8?B?NUxVazdQVVFSbjJmdzZpLzlOTW82d3g0eUhsa3JvcndPcDUzTlpYcFJwdFMw?=
 =?utf-8?B?dVJlV25tcUNydDBQdlN4aWwvZjRwUU4ycm9Xa05rcFZrQ3pUUU9NbUZXM3U4?=
 =?utf-8?B?bWZrQTczNjNnaEtxQms4Y3hLR2NWMDZTMjRnbm5oYmw2RDdQeSttd0ttWCsv?=
 =?utf-8?B?d3ZuMVVBeWNoRmF3YnRha01FaU1TaVNkeDVjanhIN3h2Y0NTSVhFMG5VT3JL?=
 =?utf-8?B?T0M3RXpEVDJpVFEzNGd1eXd1Y3F4emtTSURGcU9MdVNnNEt0SlM4dnpVbCtH?=
 =?utf-8?B?Q3dWWWkyNHpYTXpmVDFkODQxSUcrUDJqL1hOc010T05WbGl1Y28yNUhGM1FW?=
 =?utf-8?B?UEo0NnltL3hQaHFQNG5CanVtUHBEd3F5aVc0MmwwZGNQaEFlYzFOY0pIRjVQ?=
 =?utf-8?B?cm5oTWNqT2FablBSSUtqOGhIYk4wU3hKZjNQbW9RYlp1dFNkZGYyZ3A4MGFG?=
 =?utf-8?Q?uGFNRs+UQ69QrQxHtB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162482cd-aee3-40c8-14be-08de85b2cec1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:26:55.4647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1M3UE6tvqW9ustTjpxTyizaD/CvBE8tgH2XFpRBUWznP6lFc3Wu9zHR5SPhxXl6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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

On 3/19/26 11:59, Srinivasan Shanmugam wrote:
> When generating a devcoredump, amdgpu_discovery_dump() prints the IP
> discovery topology.
> 
> The function already needs to handle the case where
> adev->discovery.ip_top is NULL to avoid a crash.
> 
> Currently, the code prints a section header and an additional message
> when the topology is unavailable.
> 
> However, for platforms where discovery is not used, this section is not
> expected to be present. Printing an extra message adds unnecessary
> output.
> 
> Simplify this by skipping the entire section when ip_top is NULL.
> 
> The NULL check is kept to avoid a crash, but no output is generated when
> the discovery topology is unavailable.
> 
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 6be1f971a31a..5a4e63e1ad93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1422,15 +1422,13 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p)
>  	struct ip_hw_instance *ip_inst;
>  	int i = 0, j;
>  
> -	drm_printf(p, "\nHW IP Discovery\n");
> -
> -	if (!ip_top) {
> -		drm_printf(p, "ip discovery topology unavailable\n");
> +	if (!ip_top)
>  		return;
> -	}
>  
>  	die_kset = &ip_top->die_kset;
>  
> +	drm_printf(p, "\nHW IP Discovery\n");
> +
>  	spin_lock(&die_kset->list_lock);
>  	list_for_each(el_die, &die_kset->list) {
>  		drm_printf(p, "die %d\n", i++);

