Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B217D3DEA6
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 18:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F98210E96C;
	Fri, 18 Oct 2024 18:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="folpyLGR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0BA10E96C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 18:28:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyihEuju4QS0W+cTI9qNVeOE1b20Z8UawXfjI1Q1yHsatfiqrT/IgPmOZ/owj98orI3S/mgVOB6q2fhJZARTN99OR6vZNk392fmFX6Q42WnlC91xQVrff2Loleke4Zd3AFoDXq1VRo0HnJC2/PVoYRiXt7kp29e8Bda9RFn3jwSh+grL0dGwM1Mo2QCCHC26lR3rABXIYYS1aRKqFr+VOprjY63l7RS+MStRHLuWEf0Ju2PErwYCS+mP8BYHi0+HrCe+KEePiIOjil7+uPnaPPDvbIEoAOKpq/uV1lN+1Pv5dSpeoxN1eeL5eKaFsE393HAcUZ3CJfsjdwizE1R2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc4KcUbPOb86Mlyo1K4KHk4tMx5JEaOr7youN9GaKg0=;
 b=AkgoDo7BzSqWUvt/3Sk0A7C+vNPQB6c70XXZF/rqnCj3QWaR2bFQdKQkTfzxe0WkZAHLpmGLWkqTiZusvh1iJ85EB5TsKHTenkF9APF50s27ImMqL4Xb+3GGN4XQY7Bz5N5XSkm++AE8NcDqEgl1E38rN7YfS34+bxJrE5EKEsImRfhMG1illVuG5yOP0q+RbJhEWDUv3NK9fB3CEGMt/Cbli/rvqjgS30g2jFmVOFSz4wqC6SeRGgTmGfUyX44KDV6ndRY8k2M/2/9QQHeNvRXPhaxVP0P31Zj3VDBRFZMt8GixFSLtCzPIMSaNISeQ+rj5xi54Ei+CmH+VX0fphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc4KcUbPOb86Mlyo1K4KHk4tMx5JEaOr7youN9GaKg0=;
 b=folpyLGRT71LQh3DOyJwDlkJ+pLl9o/Xjzng8A9h23DX0fn6Bh/J2N/cTvUZwCuJ6oFcjV2MEgJgWuOpcd+opM9tXg2eCfxej30x7TP5z4Ptwc5S7K7h0lbxYKwnHpNzGVyN4otTqtquH8teA9YLzEaCF2xaTWb4e4kbE7YsD1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 18:28:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 18:28:25 +0000
Message-ID: <1a80e1fe-ef51-4ed4-a851-21d3c9da6c7f@amd.com>
Date: Fri, 18 Oct 2024 14:28:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to
 fence_addr
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20241017083457.183631-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241017083457.183631-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::37) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 8846ed0e-c4f4-4277-96bc-08dcefa2a786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGZaSCtNdWovMVMvZWs2TnpsY0VRQ3VKNy9mMTZ5ZW9LVWlUZ3BTTWMzV2Mr?=
 =?utf-8?B?RnFZenJJVlJTcW9rVWNrR3o5VjJ0RDJCUTZKOERwc2djVDVTd2NwRkpTZ0RS?=
 =?utf-8?B?eGZsN1V4SzF4aVZDQlk3Q0cxcFFxQ3huQXpudzRwMmFRWXowZi9YbGV4ZndT?=
 =?utf-8?B?ZUZ3Vi9DY1k1aVlwaHRFa0p0ZHpweXR1K2dibEVpVEF5VUVpM2JKSGRlSGIw?=
 =?utf-8?B?a2VmK3djNHZWckxLTkI4NWdlY2dnbGFKUlVGSlNlUW9MNUUrYTR5dHlWem4x?=
 =?utf-8?B?S1BWY3RWY0FTUlhadzE3b2UrOFJWcFE3dUFkd1hXazRHSkdQRENjL0cwU0xO?=
 =?utf-8?B?RTJxMHZhT05zN1lkTVpkdmpTbCtUMkRCNDBjZ29sME5tZGNES3ZkVnhGR2w5?=
 =?utf-8?B?UnI0TW5PbDYxNXA5Wm5vaVQ4OFlEdGVBOVJnY0FYY2E4QzRLZTBoVmQ1R09k?=
 =?utf-8?B?M0JJSFYrazE4dHA5V04yTjZNcmp4QjJjbm9xbDYrRzY3S28yams0eDZvQlll?=
 =?utf-8?B?Qk5wUEtUSGtnb01UcDIrOStoSGRCYjBtQWFzaFVUajNETEdWV3dBYS84NW9v?=
 =?utf-8?B?STNRZER0ZkVZTklWWEc3OThpREZNbXc0Y3QrTWJMTmo0VllheUVBR2s1bkla?=
 =?utf-8?B?a0sveDArb1k5eCtnY2EwY1lWdGlWUmJqcGVxNWFSeERqcHZQbkR3cTdNSmZR?=
 =?utf-8?B?U3RxU3JFV3NIcThuNlM1enR5WG1iZmdzVkxURUc0N0RVZlpHSU81a2tEN3Bo?=
 =?utf-8?B?eTczYkRYOVE4blVobVc4QnBQM1VzSXFUUlJjQ3VvbDREZ01wOG5tMDh1M3Vv?=
 =?utf-8?B?Q0sxbXhOQStwaFQ5SURiL1BLUGQ5NDA0Y2VHZ0lITHpzYmMzbitlV01LWE9U?=
 =?utf-8?B?dGR3UmN1N3hlbGl3b0I5V0szQ0Rnb08wNFljT1IxSGZwSVVYT2hvOXFDWFo2?=
 =?utf-8?B?WDdCS3IxTW9uOExxY0J0b3ZOaHF4V0R2QkhEVXZudUdZRmFZUzIyT3IrUDZt?=
 =?utf-8?B?SDNIbUswSk0xOGxEQnp4Y1hKeUxaeVh3dFZVZmNkd3c3S0VrQlZhU0k0d05x?=
 =?utf-8?B?UjVlZ0xOM0YyK0trSkd5cm1Fb2tESWxYM1VDeDFYNjFWSDJQSG9jSXVTNXpo?=
 =?utf-8?B?ZGJFdUFvWEdPOFVVMk1ZcVRNTmZ1T25WVkZPY1BHd3M1RWJDSWtLM2xxK25U?=
 =?utf-8?B?R2k3cVpKRWtLMmpwS2thRm1CQVRjS1Jqa2VBY3hGOHM1cmtGQjg2WlRmRE1K?=
 =?utf-8?B?MWh0UVlSSkxNNXVGblRHQUtVYTN2UWRtaktZN09VZFFhbVlTOWMzaWp1NDBI?=
 =?utf-8?B?UW1pRS9TMXgyNHB1Q2ZuRkROMjNsRGhjbG9RSmFKV0N4TkxOYWpncTdFSkhI?=
 =?utf-8?B?ZEtsS3lUdElHYlB4Z1ljaDZaaUYrYmV2ZDlIRWZrKzZxZlVwK0FSY3pBdktK?=
 =?utf-8?B?UWxTOXEyakZScjBlaFFLRS9Nd3E0MVNwZG4vc25sWTdjeU9vRUYrSkF0UFAy?=
 =?utf-8?B?Z0tVNy9xSExrdUU1aFFXalhCc3FnTlBtVlczeWlacXpBNUs2MEsyQUdsNGRE?=
 =?utf-8?B?Z0xqbXdncHJvV0JocjA4bm1YSTRWaW9sQno3cGF3aW5hUkFVU2RHTUQ2ZGxl?=
 =?utf-8?B?dmRNcERsUjhjRlRZc0xvS1IzWnI3NUdpY0dmb3hLQ2x2RStRL05BOTNOSHg4?=
 =?utf-8?B?UnlhcFJhbENmbmtuOFpiR2c5THdscEZjTE1rMWR1elN1WXNQc1ZHWll6VU9V?=
 =?utf-8?Q?vUllxaZiVqtebO6pyk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3plaUYxRUZFWnB1YkFHeFBCSzM5WVVrekNDeU1KZk1ac3pIZ0ZKTnNManZG?=
 =?utf-8?B?K3g1OEVWdzcvWmRMU09lQnpkK2YySlcybDAwcHRoWUNEREVtcC84TVhoUnd2?=
 =?utf-8?B?cWk4eXY0NVI3blRWU1IxY05DL3Ewb3FyanFWYzRnOE05NHJKNTZ3QllERTl1?=
 =?utf-8?B?QWk5SlhTbk1DbXAvQ3hCWVBrVzViREtrVDRVYVVRQW1xL3F6ZGpid2VmV3hj?=
 =?utf-8?B?QTloUzZPTnV2WXhFRjVSaTN4NzNBRStrQ2R5NlByM2JqQkgzczc3czBnaVVw?=
 =?utf-8?B?L3plTXZMd0xmbktxcjEwTHplZjFEMEJ3K3RpcGowcUlSVnFiTUFTZ2RwT29S?=
 =?utf-8?B?amJ3UURGODdURWphdUFmck9kRXNnZ1pNUXRvSTF2KzZnVzlsQjVPOXVaUUJZ?=
 =?utf-8?B?SHJvYTdBVXg2S2lRd1FuUENnV0s3YlVJNW43My92c0x0dmdZK2ZlU0NZVmMy?=
 =?utf-8?B?eTJocGw3KysvdVFkUjV1WFRFRmtmc2V2YnBRODRwb2dUcVhieGlhTEZsM1FF?=
 =?utf-8?B?TEl5U2hGTmhEK1JXb29GaElxMVRselM3ZzFqdzJaOEkyREY3eU5kZFQ2YXZa?=
 =?utf-8?B?MlQ5K0lRakpTOE1ibDdPMDJUcHVRa2dhK0MyU3JQT1FUS3QwSmZMMFl6K29o?=
 =?utf-8?B?dEMxc2w4VE42Y2xKMU5TQ3V2REViN0JFbmtLK0oraHJkYnFiTFJsVzgySlE5?=
 =?utf-8?B?VytWYTVYK1VUYlBHcnFTcFB0eENteU1XRGFlai9wdDdNMXhzQ1VjYjUxWGpq?=
 =?utf-8?B?YjgzbWlHWHkzQnZZclc4TXRORnVnM1o4aEVaOFRkNVVZWHJicmltUU5hNEVR?=
 =?utf-8?B?ZUlGcUhLaVdIMEFTWVQ3VUl2d05oT0FXZTRLVjFZelhPQXZlNGFvWXlqeDdU?=
 =?utf-8?B?bzJQcitBUm03ZnZxTlBsakpHVTlsc3N1R0UvTll6c1FVbWlKMVljblJaeHpU?=
 =?utf-8?B?bHFmWTlOQTE1bGhIRERJQUpmUm9rU3M3VzB5ZjRlOWRBK0kvSU5PVVBnVE9h?=
 =?utf-8?B?QUlUcWpsQm9DVEw5eVR5NXp2WGhMMDNReFhHVUJoMDBDUk9MOFBkQ2JmekJL?=
 =?utf-8?B?YU11QjJqaXpJdkFCck94WTc1QkJtaXY2RXVCeCt4aGU4ek5NdU05bS9vOHJ1?=
 =?utf-8?B?QlBzVUhYWitOZkFoTDA0eFFNdVpHaDBmRVpLYU9TZWN6cG5BMzlhMDJrY2JH?=
 =?utf-8?B?QXFaQkZXWFIzTHFUdG5FV25uMEkyRWt6QzVsM3YvQ2RHZGVtUm41WHp0c1Z6?=
 =?utf-8?B?Y09kZ1YvSjVXRUZpcEV6NTBJRU9HS1NtQy9YQUVQbnNRUUVEVGFYQmVhQlF2?=
 =?utf-8?B?V3FKZ2N1cmF5NDdtb0xaS3I5Z1ZFTWNrNTBzTHZwc3NEMlRNV08wU1hpQXFV?=
 =?utf-8?B?S3gvRmczZnEzSUVtUWpxRitaa1dMLzNRc2tVSlBhYjlHVDdLRE5KYlEzVVdK?=
 =?utf-8?B?RW0wQVZ1NmI5cHVFTHoxeHlNcVZqdUhjOHA0UHdWSCtyU1RLdm1SbnA2ZUxi?=
 =?utf-8?B?aU1DRzRtdFVjbnB1UWdJTG95bDJOYkN3NnFwU3dxMVNma3VCckYyUXFaQnFZ?=
 =?utf-8?B?azJxV3VLME8xSnkwQXZ3NTVwNTFHSWVNS3pnR2N1bjRkNGZ5WXNnWkxvbXo3?=
 =?utf-8?B?M202ZDI3QWVkS2hKUzVSd3pPS0srU0tPQkV6RllYeS9pV2J4S0lLS1I1NFZ4?=
 =?utf-8?B?bUxSbTkvdUIzZnJJRTd6RWg4enVHMUxrNDFLWWFYVDFPOTJWN042OVd5enpC?=
 =?utf-8?B?bVhoRU82b3lqYjg5Z3pzN09kMytLZnZCa0JFTmorenRDbWlUZzArbjFkQUVV?=
 =?utf-8?B?c1dGZTE4ZG1LWmFaY1piQVRGdUlpYzdPTEVXSlIrTWQ0eGZNZWdWdldLOEZr?=
 =?utf-8?B?UGN4dmszTmM1em5yVEsvcTc4NnFEZU9tMDhXcWR4T0U4SkFrUHdJRkkzTU5m?=
 =?utf-8?B?dmxJYXE4SnNxNzExR3l2N3JXckJPaHkwK1E3cjlqK0lWZ0k3TEp3ZElxRW5n?=
 =?utf-8?B?WktaaEhveFN3TDJ1WUI2RCswcGdFcW1IVmZleTVkeG5PcUtIRXZPQmNjSmFh?=
 =?utf-8?B?SG94TFo5TG1tS3VWVGp3eDN5YThmWHlZc0hURmVsQUpMRTBibWxKUXN3YmFz?=
 =?utf-8?Q?V+uuYk3Gxjj/7/QMa2OyTEelB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8846ed0e-c4f4-4277-96bc-08dcefa2a786
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:28:25.5513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si3blyURaltUQgD8fYQ0sM8wTGg4R7yqBU3Pa4jTpPmp2wbzI6k6pT0erB9oTS/OkQ5Km0fydf+ZIFJFu7RKfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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


On 2024-10-17 04:34, Victor Zhao wrote:
> make sure KFD_FENCE_INIT write to fence_addr before pm_send_query_status
> called, to avoid qcm fence timeout caused by incorrect ordering.
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b2b16a812e73..d9264a353775 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2254,6 +2254,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   		goto out;
>   
>   	*dqm->fence_addr = KFD_FENCE_INIT;
> +	mb();
>   	pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
>   				KFD_FENCE_COMPLETED);
>   	/* should be timed out */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 09ab36f8e8c6..bddb169bb301 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -260,7 +260,7 @@ struct device_queue_manager {
>   	uint16_t		vmid_pasid[VMID_NUM];
>   	uint64_t		pipelines_addr;
>   	uint64_t		fence_gpu_addr;
> -	uint64_t		*fence_addr;
> +	volatile uint64_t	*fence_addr;

[+Christian]

Is the volatile keyword really needed here? I just saw other patches 
removing volatile in some places because it's not sufficient, and not 
needed if you use memory barriers correctly.

Regards,
   Felix


>   	struct kfd_mem_obj	*fence_mem;
>   	bool			active_runlist;
>   	int			sched_policy;
