Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64299D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 09:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E462210E1D2;
	Tue,  9 Dec 2025 09:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SO+wqaUU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94B710E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 09:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdqrQqaX/UKYl1Jy/bS1LIVqobfflDXuKJtOm490lW55/exW4jV0V+GJ7KqSnIv3u1Vi8suvxVgsH0jgR6KBeBadzXwbVVsrOCNPq+QZ9JwNMA4IOj2paov6aXBuMXby3S5UGpFCp3eu6xhxCkFzJrtztZx+I4ncM//lR8ehC7n7QpV+e+mP2FsOldqOOErQHlmW8r7sq0vT/BT4DefCh8vf3RtcYjPPhj2W3+M7+B8IwU+CDKXjptlBhJtfv1kwIgdtq79lR85FEh2rcgstcFFDRzjQCOB3A4W8UdL10pn1PxJNrxdAvghhlNyG3+hrnaKN8sd4i1wb1eqnG8Kaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHpqJJu+azqyLSxWCWk4x3FtVi2Qjv2BgVRBu/4RZKk=;
 b=dAUol651WAsSV9HxRCJ+JbANOypnsxnSCYPYVD1HczkR3ytTxdlhfrwHEsEMEYSVZ7uGR8EhwGGJvrr0O3OHesvJJ9O+MsmVwF7yQS3ts8ertqBcDqqE4h0gHuSfdt1VgXog4CVLcPlMAzQUAOuanf/PKdKNKHJj1/lcU+Zd5mkdPkvyJ736D4oBXmded/wsYxFw7fHZ7qNMUxZ4EAt9kDhk81aTvShYqiQzUQeZ1cAT1JHZH0aTs65HnzsIw9yLYi3M4UTn50Du/7TJ0oNoSWnYDer+YFNok7W1eVTBv7Gi7JtKwIDCxlJbgzwLm7O7xU9ygMZPReMAMrp5BA1ilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHpqJJu+azqyLSxWCWk4x3FtVi2Qjv2BgVRBu/4RZKk=;
 b=SO+wqaUUFfnTEYWNg09YfYGzhGYS8pl6DviPL6o2Q/bx6Z/BZPZHkE/GgNhTfsSUlmuBlpqBWrwgq1bx4K13l+cb+cskmKDWNkRT4WxSYnvXm+dWo125UQ9BI0P4hMMzPlme9aDACPzpnc5cyZet6izYTzo8Onb5TEP3ktANAdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 09:39:11 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 09:39:11 +0000
Message-ID: <9e4ae737-55c8-4fa8-9425-0c88fd0e4726@amd.com>
Date: Tue, 9 Dec 2025 10:38:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
 <20251209012538.3882774-6-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251209012538.3882774-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: d73ad648-0660-4d3f-47ed-08de3706c8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmpoT3pIeXRmcVhEbTJ5ZWt2clVBS1EvOUZRSDdpZnd6MUpPTExyREdLdlpL?=
 =?utf-8?B?T3ZjWnpqTU94R0hEcUg4Uy9XZElzMnRIUE1QcTNzSGs5SkdRZzcrdzExMTl3?=
 =?utf-8?B?ZmR1OXZBQ0FvUi9MV09kSUdmdHpEYUlpbmpnVFZQTXNId0RLZHZkSjJGeElu?=
 =?utf-8?B?UERVZENDRXY0NG5weUI3c2N0aGVvRGdTcUlVUVhwTlhwcTFob2N4RzJ5RzV1?=
 =?utf-8?B?cmJVbVQrcEREV0FZckdBRTQzaFdOZ1ZJZ3IvWlo2VWJqeWNCdExKOTJ0ZFhO?=
 =?utf-8?B?NkZtV1BGZmQ3aERPRFVuUlpMWmM0ejNYMlFZd1VoU01YUFcxOS9IYjdQcVpF?=
 =?utf-8?B?c25leHBVcXFBSEJUTElZVmVJV1p4RHR5TGJkYkZNZkZaWnFnVkMwTEVSTXJz?=
 =?utf-8?B?ZnRGdnFYcWhINW1id1F3R0l5NW9mUW1NQ1JRNHlTRjkrdjRPS3ZUZXRpS2hL?=
 =?utf-8?B?L1hKSTcxUHRzQWFvU0FGblhrcWloQkpvd3g2WGt0QjdDZTh6VG9nSVFuNXNC?=
 =?utf-8?B?TGlvSkMxaDJxVGUzZzU5NlZCNHdmMmNjcXJwUld5OEF6SWk3VjJhMUdDNHcr?=
 =?utf-8?B?M1BCSThUMDlMUlBnU2FGS01RN3JZVU4zQ0IvUWpkUkRNQXlSNk05SHNrdFht?=
 =?utf-8?B?eTh4akRzMG5aSnkzbnF1Rk1UbjVLc0lZNGtmN1dld2V6eEcwM2VHdk1peFRr?=
 =?utf-8?B?VU4weVhTQ29XcXcwTWhOUW8xMmp1V0NHaCtlYnlJZDZPaTJjS3JneHRCQW0v?=
 =?utf-8?B?QjlnNG51dnh4dSszM0ZLMW1VTFY0WFREQVlMNlgyTDlkVDQ3b1NVRnlIamVY?=
 =?utf-8?B?ck1YK2MwNXE5YkQxNFU3b3FoM0FUdm44QUVSZy95VldkcXhLWDQ2Zit4SW9W?=
 =?utf-8?B?QXY4YzEwcVd3cTR6MzFRc21tTkZUVUl2N0ZWUnNZYktRZG93c0FKeE5HbDQr?=
 =?utf-8?B?a2Z5eC9RVzVkcnVDUTJwR1hvdGhsM004QXNMS2NTeGFvbHdLTVpqZEFQVFd4?=
 =?utf-8?B?YlZ3NnFQZnUzZnp2Z3FKTjBjM2lIWTdIM3h5QUlPOGRpbGhJbm5LMGZqQk85?=
 =?utf-8?B?blkyUXV3NjVxc2VpUlZSWHl2VXc0NTl6VnZFWXpqbStkRUFIUFRnM3Y3WVpO?=
 =?utf-8?B?Y3B0TFVhTU55TkRPV2tIZ1gvS00rR0x0Ry82cGFjc1R3WktmODl5TGM1ZEE3?=
 =?utf-8?B?OGsyS1htcS8wajBhei9wNmVYdm92blpuY3hHMFZxOURXNG1oMG1iQUY1enRi?=
 =?utf-8?B?VmpsV2NqZkJpclNFZlhKcDlGNWRmUTZOWXZ0dW1CbEJQWVV6a01OcGZSNFM2?=
 =?utf-8?B?K25XZHlWTnRIaThaK3l6MjRSV0tjYXQySGtWd1NLZHQyYzZFVVRwSEUyU0VU?=
 =?utf-8?B?TzM1SzJkUkNpTVpDa2V1Wm9hZEM1emRDYkVYMkdTOGExdlBMTmQxUmU2VHFr?=
 =?utf-8?B?enU1WmxGTDJMNUhPenJUaWJJMU5RNG9kTTV5bVcyMzdiSjBUTjZCNlZMSW5n?=
 =?utf-8?B?Qzh5MFZod0V0OWZLYnpNRHFmZHgzZDhZaW9iWTZCL3pzenVVSmQ5emtYeUlR?=
 =?utf-8?B?WnRBZGIxZDVEUTRZNndCVmQzN0J2TUxSSUMwS1dOYXBpL3YzV3NsOXRCdXdm?=
 =?utf-8?B?UGZsYnp2cTN3Y0dlOWJXcE9yTVIweThMWWM2cWhaN28yMDRDVmFLVnRJVHBS?=
 =?utf-8?B?dnBmZk1TL09qanUwZ3BZd05qYnhCdXVYN1ladXFJKzJVbm1YenRlcVdONm5U?=
 =?utf-8?B?K1ZTZ2huSVBGblZxZlBKdUhzbHByRWF4QkZVZm15elZYQ1JtRS9vRWdDYWNt?=
 =?utf-8?B?clVNM2QrY3lJcXVvZW56SC8wQVk4YkNraTBKelFDa0lTMWF5Mm1CMkZSZjNq?=
 =?utf-8?B?L3BlQlpFQ2pvLytEMGVxbWxWMTgyMjc2TVNRdDNEdWRhYldSaUpqQmR6bkVn?=
 =?utf-8?Q?ydP+Q5yydw/6TcoY5abuQ3/xoEWe4ui+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RFeVdIVXFjN0hFV1dUQjJQaXpCbUg1UWx4RmZYVjlpRERicDNUVEdGL2Fq?=
 =?utf-8?B?amViSnBhZXBoQ0N1bEs0eVl2Q09BU0xqRXVSL1ZISnc0L0k1QzlEdGJEempm?=
 =?utf-8?B?K0dSKzdaRFFYOG0xQjcxV1NzU25NRDNyN2lvRVAzZTdLTWpzQml1NUg0dFFp?=
 =?utf-8?B?MlVTQmtVbjBmSU9LeTZiMEcrOU9QazRZY1RaRXpFdkcxK1dmd2JFTzFNM1RR?=
 =?utf-8?B?OHN3Zm9IZzdKWUJTaUwwWHpUbzg4TjBIdXlMcHNZODIxVUovSjBHZ09XbUd1?=
 =?utf-8?B?VFQvVkJkc0NOTWZYRjc0ME1SRUVWRlpTZm9RaUxjaHQ4dEFPMzZROVVJWVdY?=
 =?utf-8?B?SmNYZklFMjF3elVtQXNFcHJoVEM2bGo0K0VlUXNJWS9OSmdJWStqNVRoYlVO?=
 =?utf-8?B?MHRGcXhUTk1BWjhVRG01alY3K3JlR1E2c1h5aHIyWERsVEZQL2NXbmlIc0ZB?=
 =?utf-8?B?UE9QZHRiSDUzemlZeG4ydlEvQ3BQMi9vZmJCMkp2NkE2eExYbEQzNUx1cTJj?=
 =?utf-8?B?N2FDaFVFNEJDYjBnYXZPbzRUVkJwYmd5cWZwY1BuU3Qxam5hcWJiOVhEa1h3?=
 =?utf-8?B?Y2dObng5V2NrNVdnN2hhUlhtOFBlNVRzWUdja0hibzljQUE0K2luVTYrZG83?=
 =?utf-8?B?dHpZaEhRT2ZmRUxFbDgyeTdNK2lYZnFGeTZRaEJLdURaRHl1WVFwZ3R0S1Qy?=
 =?utf-8?B?U2lyeE1NeHpFSy9SeFpUb1NzWnhtWHFLRHF0cnFrbHd5Z1hTZU5LSUw5K0cy?=
 =?utf-8?B?NGJpYURPckJvR0pKNkxyc0x4RW1IVkpaMXFDMzExdHdKejZaVGVEYlJ0dndK?=
 =?utf-8?B?VTJ4VjI3V2U0OFBjQjVSN2lpMEJkZ0dUOVhsNEZJV3RndVlOT3lpSnFseVFr?=
 =?utf-8?B?TDBuNSswS3owektzWUkwaFRtUFRzVTlYbEp2RkxBTmpuUWgyS3ZTSmczcDZO?=
 =?utf-8?B?SUtmK3h5NXRRV2p2V25EbFFzZzFldUQwd3dQeDErYlFZeDM1RWpTd0Q5Nnl2?=
 =?utf-8?B?T3Y0TG4zMHVhc1lqMG1ycDYwK2pQZUxobVU1UzYyNTdjeWNrZFpBMUlZM05H?=
 =?utf-8?B?K3NvMTRPWUttUG1BcVJDWXVXbnFGeGdWMU1BVjVJL3oxeVNramkxcUVXbFc0?=
 =?utf-8?B?c0FjWGw4TTZYa3Vkb1A0YmtlZUk1dkNEVllzcTNoc0tIUVBpWG9yWlF2QmRG?=
 =?utf-8?B?cHlzL3B3bzFtcGo0eVQwQy9FbzdGRWJXWlJSbUwvWWtGdUg1bWRMRUZVODVU?=
 =?utf-8?B?R0ptUUFmTE9idy9vSTBBMTZMaUJ5d2xzMEhWamwvSWF3MUdiMCtCejV0bDdk?=
 =?utf-8?B?NVRyQ1dRVlVwS0pXTjNCRFN0MzJXaEZxVVJDMGxjbW9QTlV5YVR3d053RUlm?=
 =?utf-8?B?bnI2RkNOZVBWV2RVeiszeGJKckVnMWtsaGo1eWVMZUpUWjV2Mk9DSklRT3dC?=
 =?utf-8?B?RkVYTEJDR1djU3VmbjdHbFcyRWlMd0s0NVk3dnltRWtKTXFwRE9sSzIzRTVM?=
 =?utf-8?B?WHRGdk44bnFDQXQvSzJoQmt0SnoxcXN1M2RTSysyeEt3d0xsUzk2c3hTZnho?=
 =?utf-8?B?LzE3aFh2KzJid0VlRjVFWlFEQmRDVCtYMHdPWmlnZHBtTTQwL1NmMGdHTjI4?=
 =?utf-8?B?OFB5MEpmUVkvSWIzNzk3M2NlTG11VUVMemR6OWpUZW5jbGZUL05CQTE2YkR0?=
 =?utf-8?B?T3p4ay91TTlLOSs5WEdDRllyYk1QUTdYSHEra3JMemdWRW1DR0N3UnpDajJY?=
 =?utf-8?B?UnlCdndsNFRxbWZ3a1JoMVh5enEvV2k4T2xwODdVSnhEQmJPU2FWOHF5eWtX?=
 =?utf-8?B?d1laWnQxZWdaWjBSZkF4c2JhNncvTFRDejdhelE2WVlnOEJ6bDMyQnRYanEr?=
 =?utf-8?B?elZncFpSTG9UeXZITStCWWZBN3dvQjlSbHVYOEI2Q1BVNkFobVd4RWVQMUZp?=
 =?utf-8?B?ZnhSWkJzWVcxU29xSDkxSXpLb3NoK0JVMW5IYnVxeDlSbS9WODNqa0oxa1BY?=
 =?utf-8?B?cFZQaXZGaUhhSnhsY1hYYVk1M2syVVFJWGtpc0JhdGxNNlAzbnJ3cWdNYURC?=
 =?utf-8?B?WnN1MnFMNXFsQzYxb2N5aldiVWlXUkZ3dFV0dnBjRnVjMTBQUjF3YnNTL1pN?=
 =?utf-8?Q?kktc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73ad648-0660-4d3f-47ed-08de3706c8c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:39:11.0236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5+uapVKsoGcX2DIrsDUTFrbFELlx4f3Mz2/3vEc9CDS/HUuOEgPvNEYsIEj6Fbi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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



On 12/9/25 02:25, Philip Yang wrote:
> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
> to GART as mtype RW caching, to reduce queue switch latency.
> 
> Add helper amdgpu_gtt_mgr_alloc/free_entries.
> Add helper amdgpu_ttm_gart_bind_gfx9_mqd_vram to bind VRAM pages
> to GART entries.
> 
> Add GART mm_node to kfd mem obj to free the GART entries after
> MQD mem obj is freed.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   | 37 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 71 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 10 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  1 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  6 files changed, 129 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 895c1e4c6747..c83e1cf1f02d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -321,3 +321,40 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
>  	ttm_resource_manager_cleanup(man);
>  	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
>  }
> +
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_device *adev,
> +				 struct drm_mm_node *mm_node,
> +				 u64 num_pages, u64 alignment,
> +				 unsigned long color, u64 range_start,
> +				 u64 range_end, enum drm_mm_insert_mode mode)
> +{
> +	struct ttm_resource_manager *man;
> +	struct amdgpu_gtt_mgr *mgr;
> +	int r;
> +
> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
> +
> +	spin_lock(&mgr->lock);
> +	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
> +					alignment, color, range_start,
> +					adev->gmc.gart_size >> PAGE_SHIFT,
> +					mode);
> +	spin_unlock(&mgr->lock);
> +	return r;
> +}
> +
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_device *adev,
> +				 struct drm_mm_node *mm_node)
> +{
> +	struct ttm_resource_manager *man;
> +	struct amdgpu_gtt_mgr *mgr;
> +
> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
> +
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(mm_node))
> +		drm_mm_remove_node(mm_node);
> +	spin_unlock(&mgr->lock);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4f8bc7f35cdc..43009d3809b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -880,6 +880,42 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>  	}
>  }
>  
> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
> +				struct ttm_buffer_object *tbo,
> +				struct drm_mm_node *mm_node,
> +				uint64_t flags)
> +{
> +	uint64_t total_pages;
> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
> +	uint64_t page_idx, pages_per_xcc;
> +	uint64_t ctrl_flags = flags;
> +	int i;
> +
> +	total_pages = tbo->resource->size >> PAGE_SHIFT;
> +
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
> +
> +	pages_per_xcc = total_pages;
> +	do_div(pages_per_xcc, num_xcc);
> +
> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> +		u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
> +		u64 start_page = mm_node->start + page_idx;


Again, don't use tbo->resource->start nor mm_node->start.

@Pierre-Eric: can you take a look as well? Philip is basically allocating GART space here as well.

Regards,
Christian.

> +
> +		pa += adev->vm_manager.vram_base_offset;
> +		amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
> +					   flags, NULL);
> +
> +		amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
> +					   start_page + 1,
> +					   pages_per_xcc - 1,
> +					   ctrl_flags, NULL);
> +	}
> +}
> +
>  static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>  				 struct ttm_buffer_object *tbo,
>  				 uint64_t flags)
> @@ -1017,6 +1053,41 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>  	return 0;
>  }
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
> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
> +		return 0;
> +
> +	r = amdgpu_gtt_mgr_alloc_entries(adev, mm_node,
> +					 amdgpu_bo_ngpu_pages(abo),
> +					 0, 0, 0,
> +					 adev->gmc.gart_size >> PAGE_SHIFT,
> +					 0);
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
>  /*
>   * amdgpu_ttm_recover_gart - Rebind GTT pages
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 72488124aa59..eff536f12cb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -140,6 +140,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_device *adev,
> +				 struct drm_mm_node *mm_node,
> +				 u64 num_pages, u64 alignment,
> +				 unsigned long color, u64 range_start,
> +				 u64 range_end, enum drm_mm_insert_mode mode);
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_device *adev,
> +				 struct drm_mm_node *mm_node);
>  
>  uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>  
> @@ -185,6 +192,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  		       u64 k_job_id);
>  
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index f78b249e1a41..0bf9c35112fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -225,6 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>  	      struct kfd_mem_obj *mqd_mem_obj)
>  {
>  	if (mqd_mem_obj->mem) {
> +		amdgpu_gtt_mgr_free_entries(mm->dev->adev, &mqd_mem_obj->mm_node);
>  		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>  		kfree(mqd_mem_obj);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 14123e1a9716..5828220056bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>  			kfree(mqd_mem_obj);
>  			return NULL;
>  		}
> +
> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
> +						       &mqd_mem_obj->mm_node,
> +						       &(mqd_mem_obj->gpu_addr));
> +		if (retval) {
> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
> +			kfree(mqd_mem_obj);
> +			return NULL;
> +		}
>  	} else {
>  		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>  				&mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 29419b3249cf..fdde907836fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -252,6 +252,7 @@ struct kfd_mem_obj {
>  	uint64_t gpu_addr;
>  	uint32_t *cpu_ptr;
>  	void *mem;
> +	struct drm_mm_node mm_node;
>  };
>  
>  struct kfd_vmid_info {

