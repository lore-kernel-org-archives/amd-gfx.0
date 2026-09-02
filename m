Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59578C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 07:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C4210F02B;
	Wed,  2 Sep 2026 07:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZET5lbK3";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3124210F02B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 07:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rds+xVBswGUlzDL3QwZRj0kLlyAYseEY7qdR1tLNZdikU+ZRY2a45sK17dYvKkx9noewS8t/Hf5SjZiGaZ/r9JFzt+/8OBiXsex8WaclETzvGfG3P6tafjI5dIsuPbMFv/OCif/c2HPjqPsyPhcJgj/ocTBZlIyCqd1lPeiQuavTSEHop/zawDhUrkEf5uSxLh4aBmcIu5u5GQG2ceWQ1Ihvq8n88esj61AYAby0VifAaFBtWWzeh3K83sUJGZiwO38RSDWN8/bJoHoUuaBMWOTvYtWQ/ryGmpGOKRHQUkVjHUrVYBP0EYQCYycKVlgVtvRS/ydzqIsCKr41gIGVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOJ7at33189NYXITt/qToeS2cAks7o2C0w6iUJ/xV/k=;
 b=x/CNDo//eRwMxIscXDoQ3KSHRxRXSerggZnL6scOTREEcIT3s6OheBbAHaeCO1AXXzPDzf3Ujx4UeOG3CQ41DaoolrKGnM7Vm97wvijfIeKpMMyX1Xo7WUE0UXe6pyPRqQqhuYxeKse2FvuOvnrrbMwia8M4Fp02mMgEdouyjjkIsyPlIJNkzojv3kCi/oX8f2acWDL6p3sqx/GvSSOCeYTU0KVFmkU4vlMHbBSEap/jedh7hgT3w6tkQEKSUpLh1pYeDHOv78MhhhRlPkcawb75z2b6N28dkPc6fEpDEcCu4E7YcIqMytCNSaYHPiSN485kwUHnaYOCcEN5jQx1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOJ7at33189NYXITt/qToeS2cAks7o2C0w6iUJ/xV/k=;
 b=ZET5lbK34lzDoMHcrXdoCQ1edB3T8WFc9bi8VQOESfzL6KlNsR2HGoFdj0jaOJZcLn3ZUMZdEVa0w8UJRlZ4YzPlAnyX3yXQSDciJRPXBUfUnNv5sgmP+65//SBJRDcHezfsnsiLfXAizDpyl9FnEIIx9AqygNu1MNjKDMuIuGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999289.namprd12.prod.outlook.com (2603:10b6:8:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 07:10:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 07:10:32 +0000
Message-ID: <e9266cee-bf04-4076-8e63-5f1fd497f929@amd.com>
Date: Wed, 2 Sep 2026 09:10:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/31] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <20260901201034.2960437-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260901201034.2960437-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:208:237::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999289:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bd5daa-acc4-48b8-b012-08df08c146f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: KOQzxnpukwnUPLbCvoqNDMiSVhrkuSNow8ipHz84eB4147N2j3Q5r08W5KR0An2dc8plj8U6pai76utv/imNGqaK8huBEwgSO+b81f81o7sVfxieeli/DeNSJcc+PuaSHZwyIpAHSHveVeCH2qVDsbxsLINp1ZydFZItCMOwz4qYIL9KrkpEHEW+WSfnpxahd+vWOM1VR2xrzmRHPuIbDq4k0XbA9HUwKJZcxGxtmXez6eb0aqUnLozw6BUTUHpqCqPqHpDyTpKEQ7Q+75zRWg11olDPi6MsJNAUxJU0k5MxWsjI9KaW2I1xOCVmBo3zi8kShFUKQ86RI5NATZQZN8U4okHXzaVVVMtNWtU0Sywob9M4LbS8oqnWdmmGutY9995svwpFJ93Wme+gqIQLb1oKIu+ETiiofzRlaJfFLAq0tIDCG0SDYR2wxUoHDsxwxNpotjTwp5y16gBhGiphVPucIKAk9YxUpkrMkmTRjAmOlVwr5SLyNySHvElfgokBWazN16x4oQRvtaeJqBakojsb48HAqo8BIeOYoJQ9WwZGNtIcgiKAq0C8sdPHaargUBTeJz/umLZLdLENCNl14ULFnfqmvSOKj7v1SGrEA1KWLpsrjjgWXhjX6J/Doqg+0wlV4RFiwViRu6M32319/cV2g2ymOsyVE/UxPrxXZVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25CUExKd3ZYN0xWK0ZvNmdMTjhGMFV6eGIrZGY1Yzh2RGxrbTN3VFNnZ0sx?=
 =?utf-8?B?bklxTFBHNStDbm8rOUVHSGRyaEJEM2FHMmNlU0h3MVZpSThXQjM2RmE5S3pk?=
 =?utf-8?B?MEZYaWJPQlQ3WGRHa3pIYThGWFZ3SVJvQzVTWTNmL0pkWkgzdjVlSUJ0QUY1?=
 =?utf-8?B?aHF6WHlyVzUwTVpKdDRkWE5ZT3J6SU9TZVhnMTR4RkRsNUJjSCttalExeDkz?=
 =?utf-8?B?VlcyWFUvYm9rZzdBbSsrcTJ6dkY4Zmk0Mis0K1ZRMXVJTVJQd3NHWUZva0t6?=
 =?utf-8?B?WFZDY0phbGZkN0hta3UrZ0w4YnJRRUM4bDVJME1ZRXlDYmtRRTdWZmhvbmdu?=
 =?utf-8?B?RWw5SlUrMFRkc0hxdnpIRnlwQ1BlZVBCdkFmcjBUT3Z4U1JPKzF0UHNnTmo2?=
 =?utf-8?B?TGpDS2EvVm9ROHp4d0w0cjBoVkRIVjd1bTJCdm1oU3I3bkdZUlBKTVE1VlFK?=
 =?utf-8?B?TjlzZlN5UFAzK0owQzVxMDJOYjhITElnd0lOM2xhK2JqVEVZd3BJSzJ6ZUN2?=
 =?utf-8?B?a0xzWXZNU0JOQUdnMklpODV4VjBLWUFWT0VjYndOUmZnK3dsb0pZTFprcU0y?=
 =?utf-8?B?YVJHSVhzUjJNdVVROUhXWFlOd3JJalZQWkNkdlcraEJDQ2QrV0VvcEI2NDhJ?=
 =?utf-8?B?U014aWw3KzgrY1hpZnp6R3ZOQnprdXZqMUNHWTJPREpRVkdVWEZvUDJ4YkZI?=
 =?utf-8?B?b3NaWTdyRlZHNnBTTkYzWTg5RFJrTnkrcHNiT0VJSmFNcFk0TDhPSmZNVlF4?=
 =?utf-8?B?clJHbVhhZXdnWmxrUEgwWEZ1UVQySU5BUUp1NlZBSWhJNW1sRndQRGxjQ1FD?=
 =?utf-8?B?VW92aGsxelZxNHRMeFV1MCtkc0FiYm1KZXJOWXI5TGZ5U2w2bXVLTFM1c2FY?=
 =?utf-8?B?Y0lFejNjUjArcit4c1dwWHFZQ2FNckdyM2VLTUcreEJQUDJSRDFxZFRIVkhv?=
 =?utf-8?B?NEk3OUp5YTZVWStUM3BwTE1RQk9YemZRd0xFTFVrSmo3d1FzZUdCWHRCUnZI?=
 =?utf-8?B?djROdWZvZVBCUlBaZTZ1QWFqQ3RtalNjNHM2WXlJQTFBL0tEY1MwZDE3ZVpB?=
 =?utf-8?B?b3cxbjRzSzIrTCtSR3ZHNC81Y0dQcnQ3Mzk1RUpDaEk4SVcySFZoMEVJVFFs?=
 =?utf-8?B?ellTaGQxM0ZMTysxUlIvVlIzYTBuU0ZvSk52eW54Y1dwYTNLUkh4bHZPa1Z5?=
 =?utf-8?B?TUt6QkYyV0ZNU0hFWitYZ3FIZFlrWEE1OGIyRDB1Rmkwcys4Y1BEZkdzZ2xv?=
 =?utf-8?B?amMwekkvcUl2WlQ5T0cyck00YzJSZ1FOTmc2SlVFeUNiZTVMNi9LYXZTNVdy?=
 =?utf-8?B?MDBlLzVsY0JLWTZPOFNQOXBGREZjTm01Qi9QLzlpbmhvZHcyVUhwODVwdFdx?=
 =?utf-8?B?bTRXRG5TMkpWN2p4czhqVkFxSERaVGM4MEx0Zm9zUGdNNW1pMlJBSmJyU1cz?=
 =?utf-8?B?RUx2OEp1Mm9ndGhSQ2lhTlJxcTd1MGVOOFhmUEpjdDNEbmJXVWVhdVN3Y2k3?=
 =?utf-8?B?dTlaSlg1KzFOZE5BT3ZOWWlJcE01bDUzanNwMzgyS0lsMWdIWk5OcDQ2N3U1?=
 =?utf-8?B?UGFGWWxpalpUSXY4U2V5YWRBZks5dU9vYjJETkhsZy9qODVtVGRZR3FCTFlm?=
 =?utf-8?B?VXA5aU1Ya1plSVM1UGVlN25OSm5nN1NZVENGa21leER5YnVRb21TS3RCVExH?=
 =?utf-8?B?Yk5yVkFRNDJYVjM4UktON1FyNGozV2oyRUI3WEU0UnlyNVVFcVF6UXhJL1pR?=
 =?utf-8?B?ZXlQYnh4c3NzeWVlK2dhV2Nmc1RydUliTVRiRS9PeWJ6MVVkcFJLdEF3Z09z?=
 =?utf-8?B?VFlYSkExSW1zVlRBR2xWcndyT2VDRjdKMU0xNkExTnNGSHZ1OW1BeXMzUytC?=
 =?utf-8?B?aFIyM1BBTmNsZVhYRkh5OVhRWmdRdUh6MTN5dWNQMWRIRGY3YXcvQnZVQU12?=
 =?utf-8?B?QVJPbG1lZDFaU3YrT3E5RE9oa1ZTWWZMQmVGUm9Zc0xzMUhkdGVnU3o2elhl?=
 =?utf-8?B?UWFBS3FTSWxCVnZpdkd0VkZrWHhBWXNSd0w2R1Z6bHZwRUNMV09FMTFxa1B3?=
 =?utf-8?B?QWZybDhrTFJKZUVEUlMxblhWRGNVaHBYM0NXL2laajlscklDSkhKNlVac1hK?=
 =?utf-8?B?MnFCSGo2OVR6MEdGd0poN2Fjcm50cFZBRTMydUdmTW9GMTltZUpvTFd5bFo2?=
 =?utf-8?B?TXZLaEwwbVJDSlFZd2g1RmVsSkh0bFBZWWtVY0NnS0VZL2hwamJzT2lBYmlW?=
 =?utf-8?B?ZUk4TUdpdHNQZEdXZjU2aGxlY1NBdkt3NTFURkcwbGZXT3BCbGU1OXVUdWdi?=
 =?utf-8?Q?5MqmDUblSq3R6gsW4M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bd5daa-acc4-48b8-b012-08df08c146f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:10:32.3597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoMt7r5mqghSAoxJYFy6r6kTBgy3rnzC97S7UmYx/DyzyZauhBELPSoDaVhSiFA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999289
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

On 9/1/26 22:10, Alex Deucher wrote:
> We need to disallow gfxoff if we touch GC MMIO registers.
> At the moment we use KIQ or MES for TLB flushes so
> no intended functional change.

One reason to use the KIQ for TLB invalidation was to avoid enabling/disabling GFXOFF all the time.

So this change here might work around GFXOFF issues, but that only hides the problems we have with GFXOFF and doesn't fix them.

The same is true for all other generations.

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index b46b87291c512..80f1cf1f21736 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  		return;
>  	}
>  
> +	/* disabllow gfxoff when we invalidate */
> +	if (vmhub < AMDGPU_MMHUB0(0))
> +		amdgpu_gfx_off_ctrl(adev, false);
> +
>  	/* This path is needed before KIQ/MES/GFXOFF are set up */
>  	spin_lock(&adev->gmc.invalidate_lock);
>  
> @@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  
>  	spin_unlock(&adev->gmc.invalidate_lock);
>  
> +	if (vmhub < AMDGPU_MMHUB0(0))
> +		amdgpu_gfx_off_ctrl(adev, true);
> +
>  	if (j < adev->usec_timeout)
>  		return;
>  

