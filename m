Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B178C5DF9C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 18:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9678810E586;
	Mon, 24 Aug 2026 18:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XhAc5PpQ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1011E10E585
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 18:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuMKVw9T0uhrazmsvZcCj1NLGZcNFvdn9VMX98P/ZMlf9xZ37gVhftvMGg7VKoWVkDuNST5r0dDkeKn/e9Ry8/42ZeGIehO7gUaoVwY5HtAz/gmQ3SASgE4T3nI2lWQJ4YqauUDUo401Zv8o1Y4G8I+XZs94Y1KEGrTqF04ukMOPBENCyhsn66EjfOM8HvuHmC++gnndEnjMPSIGsg0LLzlC/vJpLjsm4zZhT1UP3tiSI3pU+QA+xOdDs9dOuenmJP4BQGCNVyWiJiwN/IKJu/SMFX/1QC4+Aqbu95vzslLQTaaDpgNLxQnVFF8ABh3BSAnWidq7AfjmHQHwt/icbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGeVafeJYVuDAkrt92AAQv5G0EuBWyYdiWRBxLajqLg=;
 b=nvCBNrvr6alrUhh/3cfQUVxT8RoAXymsc/Sqf0Ee3Ttebw7v/e7eX9n4NF879ixP//gjRYzqsqZ40n3XbYQB/3OO0WqvBIMJVoQlPjfAI0beFMPmcjIt1rXu3xUgxSESykau+/xGmQyKw/g20fF30voIuOeZg5k3Y5ij1PQmc/EkhJtVsNT/eb2t72VX6IOFX3+ZJg1hxPlPTjsbUAsD6L6rlyyRcoRgRISQaD1WY2bHjuRb3bi7+WDZ3hmrTszTS3VliZIqI1ow1Rf/rKhIzW4BuYsVgM35rfJjJ7Alt7rqiQQsKhkeuKj2TprPCbU06ppEwxT/iwpBKTwiVJi9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGeVafeJYVuDAkrt92AAQv5G0EuBWyYdiWRBxLajqLg=;
 b=XhAc5PpQDgFKUwfhok6CsjAj3uFWQGm85KLQI1/6hh7jVe+o4ik7OsmDshLYFJa7k2n3OhOTlIC+L1WRWKj3M2VbGyP8/mPIWFWukL2OHGr5e80ruB2qH/1gFztzk25JQ29c0pQaJNQdD5IUOYAiXpNkyu6v5fTFVro6kAOKwEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:22:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 18:22:10 +0000
Message-ID: <9cd28902-569f-49ee-8a3d-9909f9b0f46e@amd.com>
Date: Mon, 24 Aug 2026 20:22:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: avoid force-completing uninitialized UVD
 rings
To: Bob Zhou <bobzhou2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, frank.min@amd.com
References: <20260819064313.3609274-1-bobzhou2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260819064313.3609274-1-bobzhou2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0425.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 857b2595-0725-4156-fc9f-08df020c9c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1Y6EDGRx7Kh76ZfAMYDaK7oyDga4yXHHGRuFXWvZWDPUYOOuhIittjRq7YYshLC1+jwGLjU1XpkG5WR/2E3f9zZGxYL18K1AnwKznoZkDbNhy8/7yJYt8KCe6Kd7/zRsQXH92aToqGO7vHiZpd2HTZVDQmMGAkLT7n64nHvzJMSaxW+v466m9/yvKXaApIUS3NwCh0YUVoHKOEMh2Q7aEohBsvD9gWGam2zyrai7h9zhBqfxMIVKO8KPJHd+MVBvD/Lz7FQHBwKfiZxmquHCTl5fuDDKs+j9lFsHQ6twovE+dyUv8SaCBaWd7FnN5LNoH3eLi9UHfpCzOPekb4D65AF856XlkozQyLWa40mIo4xu6vkahqtg/xlpb3db1klBxTEK/tDsNiW2HXPjBCieVRNUVkLQOGJYY66SH5tmXfKfZQ0eDUDKa3cpNm8lBpFcSfQeU20xuujdJzLvVO+Zb21QZ48op2IgK1seAE0h7Ek+UkDV9zURLnAFtB+iM7Zu+T6vLmap8y1bmRDMFGzK0QWx+E3Z44bQBVVFAy0XDZPu2UZHziWiJs4oJSdYC7/wIF43nry6q3en8Ah7SD3VQ9z28vo1jJ50DLWyGSprZ0aHpuQ66tDiSfY2kNfmqd9CRh8BHdsxd2pnGZ8bxyDM+Egoe0kujBnrdQ3AzEDCpcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTAxdEI0TnpJb3hiMVYyK2pjOFM1cGZhWnBpVjQ2NUxjZTVYQU82VjFhSVRh?=
 =?utf-8?B?VGpjYnpoNXJzOHI2TE1WY29MQU52QzFRZGV6VlNFNVk1Ny92MDBrd29UeC90?=
 =?utf-8?B?dWdQd1B4YytGL3hVWEhmM0prUzdOVU5aa3RQaGIzazZOUHdUUjJTaDE1SHMw?=
 =?utf-8?B?UzJPbmgxSktkVE8rdkNEQjBueDBBQTZWcGsxOXFDQ2lySklyUnNKMUdXelcy?=
 =?utf-8?B?WTdPMlM2bnRKT3dvMGRnUHBCbmo3RWdRUEJyL01LS04xclJyU2pSMFV1em0r?=
 =?utf-8?B?cnBYdmNyWldhcFI1bHRpRXowR1RBMVF5c3YzamJJUlhENGt2KzhnN3RHSFVo?=
 =?utf-8?B?Yk96M2ptRE9XMTYwRm5HYmxCRVJEZDlYakVCUDh5RnJYc0tQN0dSNHF4clcx?=
 =?utf-8?B?UmphQ2Z5WDFEaFFZc2U3QmtQS2JpcXhpNEFpdHFodnNkemprZW05bGh1VWor?=
 =?utf-8?B?ZEdMM1FiR240REVyMmg4RmlOVUFMd1UvWUIyNzRJdlNIdFpYamtMSlBtNVg1?=
 =?utf-8?B?eS93NFJjUVV6OE51UlFXRVMrNjdGMWd6OW43K0dsVFBpaEF5WGFTRFhkclFk?=
 =?utf-8?B?c2plT3pXZ1hseE45QXJWa0wyMG5JTllhTVRwMzFrOEVUTlRmdElwV2x6cGk3?=
 =?utf-8?B?RGtKTk95anpzM2JacnhmdlRLSVN5eVREMWhBZjVPWlM3TFU1VGNTVDNPbkZ1?=
 =?utf-8?B?TElybTBjdDhSbVFBUENhWi93MUFYN1BCYko4cWZ1M3A1MWduMWZyVThSb20x?=
 =?utf-8?B?UmswNVlNbnpOSmhaL00ybFdGZEZuTFNMNlJpb00wbjdnRzdNRW9IOG9DRGVO?=
 =?utf-8?B?WW9OZzVvSkN2RHpyVDQxQmk1K3ZSOHA3ektNVGtRb1FhVkROeUFJQUdXV1BS?=
 =?utf-8?B?a1BQcyswZlg5QWQ4cDFTWS9tRm5uNDlYWnF3bDYzYi8wZVp3Z0tsUFM1R1lu?=
 =?utf-8?B?dXhsRVFQVVl5RTlGd2hHaXMydk9HaVh6dm94UHludGtVVmFoaWdOdXVOekVD?=
 =?utf-8?B?ZnJneXJQRGIwb1JJZWtSY0tzeUdnWUVTVmhndG9GbUhjR1ZrV3V0cEpxTHVD?=
 =?utf-8?B?M29OWFVESDJkNVFjUXVWdklXNjdObzdmbndTMjgvZ09NdEVjZ09hT3czekRX?=
 =?utf-8?B?bmhTMThrTCtpS08yR2hUT3dHc1hpWktDa1hnNFpRbi8zcWpTa0k3NmtEQ0xH?=
 =?utf-8?B?VG5qSTUxYmNqcWt0STl5c0R5T0kvTjBUVG5WN1dRdTZhZTVEUEJlQ2hnU2hn?=
 =?utf-8?B?RmJsN2dRdHpXQjVpNkREVDVWcmswTUwrN3Q0M3JkOFRDNURRM0prRTJxcm15?=
 =?utf-8?B?WklwSEFDaUxkdDBiWXZYYzhnWTliZkJvMDdmMTZSQk9GOGtyZG9lTS9NempP?=
 =?utf-8?B?cmM3citud3l2UzV5dTA5VjZmeVRuSU5EL3BBUFFTSSszekM4SWVlNnltUzdi?=
 =?utf-8?B?V09LcE10blhHRlJmcEovZEpPUWg5d2V1ZnR2ZWRqNEZyUmFqaThEcisyMnRO?=
 =?utf-8?B?b1pYUGVSQTZhUHA4V0hOYWVzMHRRQUdNbVpSTTVJN3FyMVFnVlJES05zTW1Y?=
 =?utf-8?B?Tm5ZeEJpbVBnbk92QnBmZC95TUtmbmtQRGpJb1NaVHRlK3ljSFFPSFhGR1B2?=
 =?utf-8?B?L00rYyt1bHRyR1U0SW9XamZqR3FvdEFhVnVFS3dTNURLNVdkSkk1UUVwY1Q1?=
 =?utf-8?B?U2J2SWttc0tOSnNLb3l5UGY1K1ZGWmpXMkUxRUFmMDIrbGtWcW04S3M1TVdk?=
 =?utf-8?B?bTNlOFVLSmRtVXBoQ3EyUlp6TUYxcTZDV2IxUExzUFcxUTdhQkw4OXJybVgz?=
 =?utf-8?B?L1pXeGhPYXRudWJoZER6L3ZxZWZmbmVFQk41TW5CMGdNeEF6cGJVR3J1aHdJ?=
 =?utf-8?B?cTl3V2s3L3k0SlVYSXN0dTdHWCtPWjliN1dhd3U5aXRzcEgwanBFQlVuSG0x?=
 =?utf-8?B?ZzJKSS8zcXkxR3pZNFB6cmNPY3V4RVhxaldiRk5rODYybVBwTDNZV1dDcFpW?=
 =?utf-8?B?Qlp0Tk5IRU9vcVZKalBRUyt0R0tMdnBJa1lBM1c0elZsemtOcC9rRmpmMGh6?=
 =?utf-8?B?eVRBcHQ3SFgzZnZLeXFyakIvZENjTC9aSU05T210cWR0ZEx0a0pJZVZ0YitP?=
 =?utf-8?B?SFdRcU00bk0xbDA5Z1RPSWM4REZyUEVGRVlaanQ1R1JmMmdNd2hQNVZJbG45?=
 =?utf-8?B?TWVaNWtybnE1VTcxM2NUbGQyME0zUVFjeSs1QzM5OWFKNndiNG5JUVdiT3NZ?=
 =?utf-8?B?aGRSVUQ5TG9BN2dYcjcwK254eU1nOXBFNnhTVmFJSVpUR0ZJclpzOVg2Wlhw?=
 =?utf-8?Q?q3SrWorCToehoDso4R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857b2595-0725-4156-fc9f-08df020c9c96
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 18:22:10.3057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Rxs0trMtN5J3e3j7iM1KW8KuLJm+UomRzUAfRPQB/1OBYDDVTylXBhUY72omJs4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
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



On 8/19/26 08:43, Bob Zhou wrote:
> uvd_v7_0_sw_init() does not initialize the UVD decode ring for an
> SR-IOV VF. However, amdgpu_uvd_resume() unconditionally force-completes
> the decode ring when restoring its fence sequence.
> 
> Skip fence completion when the fence driver is not initialized.
> 
> Fixes: 043f2271e2d0 ("drm/amdgpu: mark force completed fences with -ECANCELED")
> Signed-off-by: Bob Zhou <bobzhou2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 228a405a94c4f..ecd7caa95d4b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -517,7 +517,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>  			}
>  			memset_io(ptr, 0, size);
>  			/* to restore uvd fence seq */
> -			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
> +			if (adev->uvd.inst[i].ring.fence_drv.initialized)
> +				amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);

That check should potentially be inside amdgpu_fence_driver_force_completion(), apart from that it looks good to me.

Regards,
Christian.

>  		}
>  	}
>  	return 0;

