Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C64C001DD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 17:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC1A10E737;
	Thu, 13 Jul 2023 17:56:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A00110E765
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 17:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/fqXjeDU2DBDvQb5GwuZHbx4HYxh28E4KW3bN31CWEqg5T/8qQhvFaDTnn2AmFYCYxr9P3gzs9f/WdZArwEmiKoIA8tsODdKFfgLOF+uy8OKEQ0TXZsx19J+R+qGOupJpXuooGb4cO2r9Paa2m0V1L+sHHKMQECMxizBASunuS3qVX78INMkjTHgnAZDo3zDWXvDv4M0waa6Sv2HAgyfozSbWDpU//or5/QEjVZ1nZ8r1UbsFracYJ4sZV1QERKBYUmSS0m/y7eLGOxt6S99J6zeYqGPbiHWBsT1gGbqF+IVNMrU/pnwJtIr6BNR4XYnwfVqKlSqYK+9Q3nj+5suA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po/OnknrvpNkOPArBN0caHEi8Ir5NRyYcWZ9WjsjaU8=;
 b=TnC+Rq+kO7O4n/EsQx8SLghxVYOlDhEQHu5J4rE68hVU3eTDk8UK+N8jKGVMQFPhCCMmJal3iqa2HLtpVYadNkosqNFKGQh3PuP/yKCqOdIHf2OKTw3MiCNAjT2K/ZQpOShRZC5dgKnT+1QmD9wpfJ/2jwnZ9bh8CK51y3Zm7kVV5lKBkIVnuJcdO6TJURd7bc/R05Sk3zd+qHk4tkbXIC3xVQ2lsRitSdw+u6fQNMN3I3DKXzkmyGo38NIW2b3kwFntfDKB7fTtKLeBXyPZzEM9xbDFTAq1ytOdw2zVh3hnxaLzRkjkzbLMdG4ukOpRHdf9XIYxUmh2Yc9JfhNpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po/OnknrvpNkOPArBN0caHEi8Ir5NRyYcWZ9WjsjaU8=;
 b=U4PFDVpzDqDvl2gSsKHgOP7qrY1/u3Prh5GxAota1bbbvIhaORJwuFzv21cfhV5m3Gf92vH/SalTLV1zcL1+AxB8o3J0ewRlKfKST3pVuFlJp4hasAoVrUO+azobc9BUmIjC9YGPhQas735f6n5AyBdYXk5ACuK8WlelKxpBQLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 17:55:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c%7]) with mapi id 15.20.6565.026; Thu, 13 Jul 2023
 17:55:55 +0000
Message-ID: <9c8f8fcd-d730-22b7-f46a-5a6b326bde32@amd.com>
Date: Thu, 13 Jul 2023 13:55:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] drm/amd/display: Implement zpos property
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
References: <20230709020700.3116749-1-joshua@froggi.es>
 <20230709020700.3116749-3-joshua@froggi.es>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230709020700.3116749-3-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: ff60659d-96fd-4010-c23c-08db83ca67df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvuZ7b/ZScCHxGC4cxI9EWjqUINE+Ndqeuaplrp59FzLkqqHRQSQzeH0t3swA0APzzXCulP2oY4ALnNWVE+BrIbqpY+lqeVwB+4Cg1rSAf0Fr5zvl7NPtHXq4qB6CXzxhj5rmL7WJdcHP3B1IGuTEd5ZIiF+7N/mKuGB5jqVS4ZyHmFvi9d5n8SYhJgngguIYsFZxL/yIvnjLH2rox2KcrpJpQlrfQ8SWIHqCZGIoijGo7DtmbCLDjur14OBQU+ThZuf99QdzBhvQrY9o8yQTU05VrjR00BQ+Y2XeSB8uq6w4JwjPg6ArqgBXCxk38Whwoqe33c8tF48XhhFCgxDdCISEHkfYNOmlKeGzknFTzaQddZ+DTRrZmyfYG6qy/+YIdLcWL87++Zd3/8RMjU/MSt3AUkhSHgpcSYwNhhcar8rcdN4RiEYlRLgjct+mQaiEDOgYvFyiRsR4/QE2iA6os7acwLaPye/BU9i1Ik1lgHWfqAU3lEzRmoBYrl8AWKIAnYfxV4S1URK9Np9RwLiFhfN6VswZynLJCinpsggynfgPTrclLGvz2QCBYvz88h+p3JEj7d9DPiVMndxlO1wZNbBtElYor3snYWKnAdiXegPBjA3jDxhF5fIvpfztY4/+YOWmTSacBI62fhzPJwd3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(44832011)(41300700001)(2616005)(38100700002)(2906002)(8676002)(316002)(8936002)(31686004)(5660300002)(66946007)(4326008)(66476007)(66556008)(86362001)(53546011)(6666004)(6486002)(6512007)(36756003)(54906003)(31696002)(26005)(6506007)(186003)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1VicHlQUmpobWVqZ0kwOVF5V0FUbHZCOTRYVHVQK3BSekE2VDlhbGE4Rjlk?=
 =?utf-8?B?TFJnVVF6YUpPemY5WEV3R044VE5aclZCVzlNUWV2WFdjblZnamFDQ09RNFJM?=
 =?utf-8?B?SnYvR0RVVVhmbnk0MTdOcDhkVm9WczZJb0VKcDArc1BERXpBNFZVOWZCODJx?=
 =?utf-8?B?Z2twcFBSQjI0MEZQUTRGTUlINmUvQ1BUNTBodEdPNkk0VWdPYXN4aVZqRk96?=
 =?utf-8?B?cmx5dDA0Qk4yaHRPbVJEWk9rdmV5U0NFZ3hpcFJoSHJMR2JMRk5MQm1kZ0Zp?=
 =?utf-8?B?SFlBMERURGZJSkhheEtQQlBtb0UxWlR0YkRaVmx3QUkvRnZqWGk0ZDhQSjkw?=
 =?utf-8?B?QjJ5UXhxVTc0V1IvYXE1bllENWo5b0tJdFljSVVINlNoN3BpTS8rbGwzUXJ4?=
 =?utf-8?B?ZUM2OXA4VElWVlJuWk9zc3AzSnIyOVpqRkFKY1lRMGpEVDFwUGEvRzFIWW0r?=
 =?utf-8?B?SmJ4ZzhSelViN0ZxdmMyTVZPWWJaU21DelNhSmw1NUdyWTUyYktDb2s4OXRv?=
 =?utf-8?B?S3A5V0Rlc1NackdYY2lNa2ZFdzlvaEhsVUY4RjdtRDhXcnF1NzJoMTJQc3R5?=
 =?utf-8?B?S0QwOGNwTFFsL2YzR2FIdkt4WWpqanNydjByR1dHdWVyazJlMGFnTTdxWnlw?=
 =?utf-8?B?UURHTHVzOXlXd2p0QjdFZ2F1VzY4NTVMZW9wUFA0VUg2Y0R3WWliakUzVHZy?=
 =?utf-8?B?cUVRYkI3a1lQUGtSUWt2bWZ2c3R5RURrS0FrRHhJakpXRjRBVjRNUk5aR2NP?=
 =?utf-8?B?c2dTd3JMamsxditqQ25odElyNE5QVm0xWU1BZHRHcDdQOEdIUFNoTC9EY0t4?=
 =?utf-8?B?dEtxUWhzOFJxTVBjQVd3eEhSNHMrb2hwcUM2MDZnSDlkdEpNVjJvemtENDgv?=
 =?utf-8?B?RjZyUXBMMkFZOHRQZFF4MFZDKzREUVJqSi9XN0tWRjdtS2hzRzBOd2w4cklN?=
 =?utf-8?B?a3ZtZE85bFdmNFBIS05zV0ZTMFVaL3U2QlJnaXFJS2VRc3ROQWoxeFh1cDdp?=
 =?utf-8?B?U01vYzF3NERhT2JBYlBhTTV5MDhGYzJnRG5ubFNDZUdSeXpidGcxV3ZMWG95?=
 =?utf-8?B?QUk5dG9hdjViMGROTnZOSGE5SHd3U2ZvTHdWeCtxV0J3N3QwbWttOGNQdk1P?=
 =?utf-8?B?eTBVOUQ4M2piUEtLWlZvVERoYmdsUG4veGpvUmtqbmFwR2J1QUEwTXRoS1Yv?=
 =?utf-8?B?cEVVQjlMcXBSci9yOGJlSUp6NDRLRzdDK25FZld2ZmFaODVOV3RJOFdxQTFu?=
 =?utf-8?B?VmJYczdWLzRqbUd6V0tZY0twWHVZd01lTmJ6cWNPS1c2TUxvbnR3YnNIYTZq?=
 =?utf-8?B?S1VPU3RxWWJhanppaUUrWkxHYUwvN084b0xYWkllbmxmSGZWaWM5Y1BzczRN?=
 =?utf-8?B?MzVDOW9WWEdnZDdOK2RzTVdSME5QZVl3WE5oQ2V1MWpyb2hkbnZLd09rKzhv?=
 =?utf-8?B?a0RGMXJrVzVJZHhsYlh4UjdQeGNnMzlQRXU4a0czNk5ZRmM0UTVWWENzTnBv?=
 =?utf-8?B?eFpDRUVmUlV1RUZ2eUtFMW1kSzRmYm0yb1pXanZqWHNxcHNybzVHejFZQjh3?=
 =?utf-8?B?TC96azJZcUJnSldBanByZ2NHVURPMVY4aWsyeUtPSXhnNldWcC90Y1FqbFNX?=
 =?utf-8?B?QlkzQVR3WXJkMGVIRmpUb0JWNFp2THU4a3lYcmYzbzFuNkc0ZUFuMzU4VC9w?=
 =?utf-8?B?Q29TYUxkQnl1UXFNbFJ5U3phcUNNTDBNdFJBZ3Z2ZHFaTW5hbGhrQ28vUmcv?=
 =?utf-8?B?d0J5NWlnNThuQzNoY2lhTnFGc1FmVWJZNFJ0RjgwVklVcGFza0V5eXpHQzA1?=
 =?utf-8?B?d1ZiWHZHNmc1UlV3Q3M4Njc3bE9sV2VvSi9QZUF3V3NuSkZaUkd1QXFZTjhN?=
 =?utf-8?B?UmV5MmtwbnJUYkRTMGRtTmdvcDJ0OWVZN0pSWkZlTVU4Mm9YSTVBc2FSalh4?=
 =?utf-8?B?YmlZek5rVHhLazZBMlNvdk9xRFRzV09BcGYxcVNKVlNLWXJMOW5BNTVKejFQ?=
 =?utf-8?B?djdoWkRqbXFGMTJnS0xQRXJBc09xNXoxSWZlcWNxaS9CWDVuWVZoNWJsSjUr?=
 =?utf-8?B?L0ZDdEluNFlBZGVKV2NCcHcwRWh1TndSTWFMckhXRVNDcDY0YzRud1ZxVE5s?=
 =?utf-8?Q?8w7eedLevw/i+wDowATKo7FZp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff60659d-96fd-4010-c23c-08db83ca67df
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 17:55:55.5765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEGI10Hwbg2zY1cato2SiAj4uAck/bgVcYL3Vrws1Jh+PviEPImQYoXLhQJyZkNHBp3nLGDQsPQTsacaUt+rlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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
Cc: Melissa Wen <mwen@igalia.com>, Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-07-08 22:06, Joshua Ashton wrote:
> Despite certain GPUs supporting multiple overlay planes already in
> AMDGPU, the driver did not expose the zpos property which is required
> for userspace to take advantage of multiple overlay planes in any
> meaningful way.
> 
> The driver was already hooked up to normalized_zpos, but was just
> missing the exposure of it.
> 
> Signed-off-by: Joshua Ashton <joshua@froggi.es>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Simon Ser <contact@emersion.fr>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 8eeca160d434..2198df96ed6f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1468,6 +1468,15 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>  		drm_plane_create_blend_mode_property(plane, blend_caps);
>  	}
>  
> +	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> +		drm_plane_create_zpos_immutable_property(plane, 0);
> +	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> +		unsigned int zpos = 1 + drm_plane_index(plane);
> +		drm_plane_create_zpos_property(plane, zpos, 1, 254);
> +	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
> +		drm_plane_create_zpos_immutable_property(plane, 255);
> +	}
> +
>  	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
>  	    plane_cap &&
>  	    (plane_cap->pixel_format_support.nv12 ||

