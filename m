Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF911E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B41B10E82A;
	Wed,  8 Jan 2025 09:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bk/DwuHd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1377210E82E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 09:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKWeBqdyqsvfng+Dp15nu31c3Kq+Wti5Pf1KJbS6QTBzLtDPmEDauRijrt0lFVYSNun+ofSwkDfhuoF/LFv9FSMtX1ttqr2j1oRuH/gSECo8tF69zwA7SvLTUCralU8mCIIA9OEefgdAs+mN6D2p8HY/NaSMkx5yBlW0wnAp0cT2PNhTHLOF8mbr+TP401xJIBBZUHd3wiSbYipJG9ppm5y1+9kpojp7/7J9MRVbxMRN498GAQhOnNgw5IwCzfZTUeWalsbIwQOEtrcdxoZI2ybBRsB6tkF5w0mcJCW7Zw4GH+jvif24+DYOODyC0SXrcRlKcJyis/tn34J5GRgG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIyHoMvGI9WsHQGLX1VBBKHNyZlwwF2O/XybolcYQMQ=;
 b=QJC9x9nLrkCRTWpmbnR9PH468fqpL5peDZxx5aQtJ3ryBVyUNyS6j9/bm8+W/2WAL2l6DB68DQ6bN6UQIhC31E3gIkTzp2z7pzJFA+bW6wmh8YGpzs14V4bG9FwmMdbMkqNLg36uBHUqV5zi0Qy6S/k0oXtJfHuZ8mupawjcPI1LUNamoPjGDCswYinD+Xz8Wryk3zUnEGHKMGfLW05qCXTWD4u6ULlz4WNshCk1WBze40309OdeM3LHyg1T+tYUOBvhL30tUk7Z+3zdMGzVyq59XBdQHYLbekkMJ2iVqZoxjzPdOegbxLmOna5szrdx8n6DEl9Q5Jdg2Mt7OYHv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIyHoMvGI9WsHQGLX1VBBKHNyZlwwF2O/XybolcYQMQ=;
 b=bk/DwuHdl7vdsw9VMShjMAnDFgqjPvTwITUqi007Br560JIh8ngboF0xWlORWldcc3VMNsIlQQCLzZ2ioEo7b83P2uo8rWSU8pauo4wpf+7VCvvknlqynIkTj1rLXgI6Ij+8I9F8pJac0R2DmRjjZP1ZA6VeNPrw9H7NhVS9cO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 09:31:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 09:31:47 +0000
Message-ID: <720f5edc-db64-411f-9d22-b0c718b69f7e@amd.com>
Date: Wed, 8 Jan 2025 15:01:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/6] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <c46d4c3bead7f62439eca5110de8afe4783a7418.1736325561.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <c46d4c3bead7f62439eca5110de8afe4783a7418.1736325561.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::29) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: e979edc4-9e92-43c7-2feb-08dd2fc7456a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjdqZGZZajduREdDUHBoQkJHemVaWWRGeXBISlhrSmJJRjNsQktpYnhBVzVv?=
 =?utf-8?B?T0xjcWVWRCt0dkdWNWYzU0RlMjV1dGt0ZlFTTkljK3h4cnd4NHcrNVUyWm9v?=
 =?utf-8?B?QjVZQ0lxaDBiVkJNeTBRSyt5WFdpdmI5UDRHc2ZZR010L2pLQlNJT0l4bmRT?=
 =?utf-8?B?K3Y4VGtrcnRWTFNHWG5CLzFkbk45TzRqZytFUkxhK0tEV0w3OW5LTWszYXRI?=
 =?utf-8?B?V2lvY253WWdOVzRRSnRTQWNQY1FtLyt1dVpDTUdiSncybTNHd1g3YWk2TlpC?=
 =?utf-8?B?d2crYU4vQm5CcHZCZTErZ0lXN3M1cGZlaEdyaHMxUjFPcXEwdjZoTGtQR3Iz?=
 =?utf-8?B?L0NDeGkzMXQ5VW1HL3FIbzcxN0RMNG05RWpiQzRwSUxoZEp4Rm90UFFIaURP?=
 =?utf-8?B?NHJ6R3N0aTlVaGM2Wk1GWjZNelZRTU1FQWlDL1NQbzdwZFBDRXAxS2U4UlAr?=
 =?utf-8?B?dm9HY0RuLzMrUkFFc0ordmlyUnhLL2o0MHU2T1A5MDM2enFybTk1MklicCti?=
 =?utf-8?B?NWt3L0dnZE1ibUNCVk9nQjd3SjJTOXQ3dFJqN1RNaGxiQkI2SVNFQ0ErSC8y?=
 =?utf-8?B?ZFRZM0hTMWRmV09ZWEpXLytPZDE3aHo5VU1xV1VCVkhTQkJLS3ZWelpKWE81?=
 =?utf-8?B?VkdITFYzZWcyeGJodmlrQ0wwQUlEREkvMXRnTzB0V1lkNWIxV2FaNG13SU1k?=
 =?utf-8?B?NVlpM0wxdEVoZUlaUGVKM2xKNndJdm5MSHUxVXJnM0graFdqK2RYWk5ldC9G?=
 =?utf-8?B?YkNqUTB1VFovMHJWVm43YmZFWU45Z2hHVFdJU01ydXd3NE9jcXB1S2Q4Uk94?=
 =?utf-8?B?d3YrVEVEN21DdkdQbVVidXEzN3NzMzdoa2JpRFR2SVpITmdhN1g5aXFlTUdY?=
 =?utf-8?B?Q3RHcXFpbnNDdnVGaW04WTVkRm52bENranU5YmNNNTk1a1FBTkFGWENURmNy?=
 =?utf-8?B?TCtZb0djVVhZYTdqcnBIVkgxaWhibXdmcUxlMmRaVmxWeEJNZ2ZpU242Slk2?=
 =?utf-8?B?WVA4NWkrNHRnbHpnUThEaStHTmVDYmdIbDV0ZWNabFMyWkE4blp3RHNDUHdO?=
 =?utf-8?B?U1FyYmdrcXVtckNOT2RTbWZVR3BUZVk2eDFWWTd2aXdJa0tBdEJYbGRnMjRk?=
 =?utf-8?B?ZEV5NEVLQklvZTAxWmw4bXhhcHN2bVlsZnFQSXIzMXlzRFV5bkxlSFhteDVB?=
 =?utf-8?B?NW94QTYzMlVPTWxweTNVQTFLdkhJNEljaTdQbUlidUs0TGhBSmJlWTRMYUZY?=
 =?utf-8?B?UmV2TVVQQmVmazNsV1J3alJKUVk3RVRYR0VrRnh2RHI3QzIwVDd5YXFCdW9H?=
 =?utf-8?B?M1Jlb290VzdQZVZpNjZ0S1NWdXF0dlgrQ3ZxeTVoYVNIcWJWZkFFeGcvWjlH?=
 =?utf-8?B?NnNVc1hHbmduZ3VhNXRpN3NqM0t6RlhZVU5maXBTdHN6cmdaREp4ZXdsS1RJ?=
 =?utf-8?B?YVJGeWgrNSt1RWhmUUJPejB4dy85MW1YRXVIcXZnSGpoTHhGOC9vRUJyVDBl?=
 =?utf-8?B?OVNaR1JmME9xcHlFcHJSZE1CeTkyYlhFKzRoaGZGSHVtdmJ1U25EU3VWa3BG?=
 =?utf-8?B?dzlIZGpFMlJxSmpyOERzcW9XMGNwNUFJTUVVSGJxbVo5Y1BDWHVJWTVxSzhx?=
 =?utf-8?B?OTJFUjBET0lKM3cwR3Z5Tk41czNFQmFqZm5uRkUzZlp6VTlWcHkzcHhod2ds?=
 =?utf-8?B?aDVQUW5sMW5rdkVvd3hTWklVYlNSK2huMU1zaFlpWVdwVDhKLzBoYjJ4bThy?=
 =?utf-8?B?V3BvVFhUWFpuUXhsMHNNM1N2WnZ6MVdLS1Qvc1A4OFhjajNmZUxLSGpiRXVQ?=
 =?utf-8?B?dTNWdU0zRnNLZzRscW9Ga0p1YnlTZ3kxU0tDbUUrVXQ2V204VHhNTTRJRkJs?=
 =?utf-8?B?RzF2UkxMSXc5dDFZMkdIbTM3Ti83Y3BjTDBveUc2UlZyVWdZbXJTVkJuMDlX?=
 =?utf-8?Q?ORG5lUdC/pk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNYWjhBT0w4WVB3eEpLNlFFd3psR0JQZGY3Z0I1UitqUGJYc21lM2hmV3hp?=
 =?utf-8?B?bEFsMENqSjFRaXphU1ljWFZRK2FlNkhmdlo2eFdDQkoxOTFIR0N5c3k5YnZ6?=
 =?utf-8?B?VVBCaDMvYUlob3Z5czgzeEg0OEVjOG5FbUdVVVZSY1JUUHlwcWxFakRjSGl0?=
 =?utf-8?B?YjdKZXduTjhEMVgzOGRseDZRTGh1M3pmbHhSSEFrRmdCM2NsR1VMcGIxTWkz?=
 =?utf-8?B?MUhHdUVpMkpmSkNYNVBlWFc0WFNXdmlCVXBvS1czSGMvYTVlQWl4em80OFVn?=
 =?utf-8?B?ZlZmSnBrMVVYRWxFRVdVbkgxdjY3d3dMYWdicFBsU1pVWElLYStOTzRoQTE1?=
 =?utf-8?B?VUFaMEF4R1JwbzloWjFzcklTcU9uNkYvRUpJVXptc0tMMzMvR3lKS3doaUoz?=
 =?utf-8?B?WEk5aUZDZFlzbTh6QS9OaEludlpHa3FKMTNRZFN1WWxJVnpBRWZnaStRb3Bq?=
 =?utf-8?B?cUZ5eU13UG4zNGhET0tNRFNLQXdzZ0luUnAvZkZqdGdtVEI3S3dBUzlyOEdv?=
 =?utf-8?B?RUdRRjBEV0FFMm9ndXRzR3ZSMDlpclJxMFhYQURGTXVqbmg3VXlsK1lMUk5C?=
 =?utf-8?B?N3lHZytZSWE5U0Z1QWFHOEVML21uR3RaSDBhek9RcldTU2lTTDhUYzBqWDU1?=
 =?utf-8?B?SVNlSkoxc2dGazhvTWRSb2c4eWVTQS9HSW5BdDkyOFF2c1h5RnVaNG51RlF1?=
 =?utf-8?B?alg1bE93NDFrU3BBbzZRbXB4Ly9FcStnSFQ3OWVRcWJKcERXL2lZbTl2eTJn?=
 =?utf-8?B?eXlzcE02dDZyZ0VUL290T2VKdEFVOUVpNDdkbWxiWkliNS9VKzhXbDA0a0Nr?=
 =?utf-8?B?bmFHK25TZ0E3Rkc1c1Y3azN3L0oxOXZRZTA1M0RveWtYcFdHL0dWM1NBdE53?=
 =?utf-8?B?cDVQNkJTNjhvLy9tTnRwOGxsdlY4RUt6VHJnNmxDZ29PSVpTeWpRYTJoU1ZP?=
 =?utf-8?B?SlQ0VWViMklVQ3EwcGxoYkJuT1dLcnUxc0o1UTBwRCtQZGdkWG90S1p0bDZr?=
 =?utf-8?B?NWxhN0lLTzgrVHlXRFdkZFJLd0NPNU5nOHFpWHBkMnJxdnVLaVFpM0JrbjlZ?=
 =?utf-8?B?bzZSZjMyZHMzd3VVUGZ3ZGphT0RaZjJjME1UL2plVGhaVGd6Zk9xTWx2ejZS?=
 =?utf-8?B?ZVNjNmhzS2RLS3BWMFB0Z2hWQWVBOFduZ29QU3gzdUNlVVY5U2lRV0ZjeEV4?=
 =?utf-8?B?cXY0T3BWdlpYNDFRWFBjYkpBZDhmRjVlY0RrVWhhUVVWK205QTVPN1FYMlds?=
 =?utf-8?B?bjkyZ1JwdU5qeWJRNTVINXhTM2Z2azU0WGFpVTZrOFRhTDVlQk1KS0xkNDNW?=
 =?utf-8?B?QmxoN1I3L01adWFNTVlkaU1WY29HZk1EZkhPMXdCSjQ1NGs1cGYrM21ZZ3ZW?=
 =?utf-8?B?bUZUd3UvSTNGV2hqQU9vVjZZMTFpM1A1L1Z2SjJudGRablRjWGY1U0loa0tT?=
 =?utf-8?B?Rmp6U2VTY1F6VWhsdlkrZDZHSGdZbTdFaHllVDJBUHdRWlFMMkFqTlpJM1Zu?=
 =?utf-8?B?RlNuR3kzVkhzQU5HTTRCR1F6amlWdEw4bDk2MUR0YmpabkRyeE56cGROcnk5?=
 =?utf-8?B?QndaUFZ1UzNuRXdReEZ6MFBwWGpEOUZ2aHFxSFAxeFBVMkJxSnJneCtXcldh?=
 =?utf-8?B?dTROaVBIUVg1dkx2QTRscFk0MzlGZWtjR2ozT0FNV1FveVNQaWVkT2paVEp3?=
 =?utf-8?B?aHZsU0xwMTBwRGl4dGF5M2NOajNWMWpGU2todHVnTDY1c2lFMHlxM0drV0w1?=
 =?utf-8?B?MEUvMGVYKzE2ZEsvWnk0bFlvYThlbWozbVdWa2ZuWU9kWGRmRHM0UEFzWTBI?=
 =?utf-8?B?Tm1keHhvWDFyMkhieUxzV0JmbTA2YXk5dGdZeXl4aysrbHMwN0lZQ29rQ3E1?=
 =?utf-8?B?dlFRRWVrY05YV1gwMjdqZ01kVTdKM0tVeGtUbkFhTWtDQ0lWdFlTcW5ZTEhK?=
 =?utf-8?B?L3RETCs2VmxHTG9jNDJiRWkwWGdlbzd3WUp0Y1lnWmtZN2xCVncwTGpUQkxm?=
 =?utf-8?B?d2Rlbnl0dHlYUjcyQXNlWkVMaFBCV3FZdFRzMDl3dzNrcVNDRzhacHpMZURx?=
 =?utf-8?B?bDFBV2xxaWlvM09pRG5JZVZnblNEUCs2M2E3a3BCeERHOEVIMEJRclJJZ1o2?=
 =?utf-8?Q?vjYN8iLrXxxqASjP5PzItoroC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e979edc4-9e92-43c7-2feb-08dd2fc7456a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 09:31:46.9775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNlsqyX/0qboQIveCJxCMd+CW93bkU5fCXUvI77F4unvlhd4V9yu401RpaeFfjOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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



On 1/8/2025 2:26 PM, Jiang Liu wrote:
> Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
> drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
> to do error recovery.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 76 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>  2 files changed, 63 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index faed84172dd4..fc92b5fe1040 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -45,21 +45,32 @@ static const struct drm_driver amdgpu_xcp_driver = {
>  
>  static int8_t pdev_num;
>  static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static DEFINE_MUTEX(xcp_mutex);
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  {
>  	struct platform_device *pdev;
>  	struct xcp_device *pxcp_dev;
>  	char dev_name[20];
> -	int ret;
> +	int ret, index;
>  
> -	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
> -		return -ENODEV;
> +	mutex_lock(&xcp_mutex);
> +	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (!xcp_dev[index])
> +			break;
> +	}
>  
> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
>  	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	if (IS_ERR(pdev)) {
> +		ret = PTR_ERR(pdev);
> +		goto out_unregister;
> +	}
>  
>  	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
>  		ret = -ENOMEM;
> @@ -72,10 +83,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  		goto out_devres;
>  	}
>  
> -	xcp_dev[pdev_num] = pxcp_dev;
> -	xcp_dev[pdev_num]->pdev = pdev;
> +	xcp_dev[index] = pxcp_dev;
> +	xcp_dev[index]->pdev = pdev;
>  	*ddev = &pxcp_dev->drm;
>  	pdev_num++;
> +	mutex_unlock(&xcp_mutex);
>  
>  	return 0;
>  
> @@ -83,21 +95,57 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  	devres_release_group(&pdev->dev, NULL);
>  out_unregister:
>  	platform_device_unregister(pdev);
> +out_unlock:
> +	mutex_unlock(&xcp_mutex);
>  
>  	return ret;
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>  
> +static void amdgpu_xcp_drm_dev_destroy(int index)

<Nit> Use something like __amdgpu_xcp_drm_dev_free(int index) to keep
the 'free' suffix.

> +{
> +	struct platform_device *pdev;
> +
> +	pdev = xcp_dev[index]->pdev;
> +	devres_release_group(&pdev->dev, NULL);
> +	platform_device_unregister(pdev);
> +	xcp_dev[index] = NULL;
> +	pdev_num--;
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
> +{
> +	int index;
> +	struct xcp_device *pxcp_dev;
> +
> +	if (ddev == NULL)

Does it make sense to add !pdev_num check or a WARN_ON(!pdev_num) below?

> +		return;
> +
> +	pxcp_dev = container_of(ddev, struct xcp_device, drm);
> +
> +	mutex_lock(&xcp_mutex);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index] == pxcp_dev) {
> +			amdgpu_xcp_drm_dev_destroy(index);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&xcp_mutex);
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
>  void amdgpu_xcp_drv_release(void)
>  {
> -	for (--pdev_num; pdev_num >= 0; --pdev_num) {
> -		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
> +	int index;
>  
> -		devres_release_group(&pdev->dev, NULL);
> -		platform_device_unregister(pdev);
> -		xcp_dev[pdev_num] = NULL;

To better optimize, add one check like below.
	if (!pdev_num)
		return;

Thanks,
Lijo

> +	mutex_lock(&xcp_mutex);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index]) {
> +			amdgpu_xcp_drm_dev_destroy(index);
> +		}
>  	}
> -	pdev_num = 0;
> +	WARN_ON(pdev_num != 0);
> +	mutex_unlock(&xcp_mutex);
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>  #define _AMDGPU_XCP_DRV_H_
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>  void amdgpu_xcp_drv_release(void);
>  #endif /* _AMDGPU_XCP_DRV_H_ */

