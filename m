Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BCFC021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 08:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6069210E180;
	Fri, 21 Feb 2025 08:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKvwGXSY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319C310E180
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 08:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWd1Fejt1CYiec6//ASQQ4e7KVfibVsPmwPCVQHTLD7VUvd7SYQ1GQeCuh/8h6JS7Zwjo3EgeDwK/fLmFUc65LwZRBn80MHOVZDTxUb6UJykqXFr4rcVCgfq/3eK7HpHW1zgr/+NH5T/EwuL5wAcKwx2iGLMdp1H2dnV+/6D2sXZHvXLQNwJujQcw+rBQDdUjz1CwTgnAcgNEumprMHcLZJChHjdj5JWv/JRcfy4OJ039gPUJWTFFJHvQfNwh13J0GkbsMBfGQgSFghsi8uYU9KLJRM/yyrOQu6m/mL5BI4ueQzC0oo4p/o6ml6Ck0Ee+OmKuzDn+SU/7YeAWTEt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UTYZq2G11VqLtnMzOy/9nTWiuyR3tfdCbUvlVbIXFQ=;
 b=lZPYLzyTqSw85YZ9p6kZnFyvNhu2JONMFyOxzuurPiRct0LuPHAGjXMbRK1zYk7Owxp5R94o+8E4f3ARuT2D/i8ljtXxngvJ1ZI3MLDQBeMuBgKharYfHqf8CtV73XXu/j9IckkCQSRzGgf8XGASANbrTFtm7r40jXcyKxIQA/zXC5DHCnenhznacZG59C75YsssRvxBJG2Hmf7YOxU4ZmcxLuIQkiv4fsv80FWWk3cFyPPr48/SrcJY4+wy3TN9jxf306+Q5DH2ESiwoBBaXVMuarnamJmPtpvvUevs4SsIxg0TWRxpjGeHCRjjwagGkZfb6VPIvzo7+lkYY1Xblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UTYZq2G11VqLtnMzOy/9nTWiuyR3tfdCbUvlVbIXFQ=;
 b=yKvwGXSYbewc4SVXhl9kDy3sWEElV3WFXPsmKq1ICKEWj630alo4oounXdQXk5/5UoTd3DLqlR1ab8eC5DBt5uLumFqxIb9YPYcmSDxe8eje8II3+oCztxol/6uwn1289eBJHao725yAd6LTZQgtMSBFbCKj+gZjUZxGimxkj2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:13:16 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%3]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 08:13:16 +0000
Message-ID: <7f5f3c07-e0b9-424d-afea-880ebfd9d8a3@amd.com>
Date: Fri, 21 Feb 2025 13:43:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Initialize SDMA sysfs reset mask in
 late_init
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>, tim.huang@amd.com,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20250221061746.3949672-1-jesse.zhang@amd.com>
 <20250221061746.3949672-2-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250221061746.3949672-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ab40ad-606a-44b2-9e1f-08dd524f9791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDNVNU4xTVpnWTZxbzVLNG9HUmFvNTBEVkpEbWZOK0RRcmpKSjg4UUYzUHBa?=
 =?utf-8?B?Tkx3OHhZZnMyOVJWRGZReHV6aE5QTWRZYW52ckRQV3RrTGV3d3diUlpZdHdX?=
 =?utf-8?B?RXc5NW5vbnZJS3FBWlE4UHdNOFRrV1Q3TmNNREh6VjBXMnpNUVROZUMwcm9t?=
 =?utf-8?B?MnV4dkxnMVFZLzNscmVpemxpYkhUdDlIVko1Z3FpT1FZM2Q5VEdiS0l0dysw?=
 =?utf-8?B?UXEwSklPSWNmQldEOGQ4bXY4bUhXSWl1NjF2UTJHdE9ITk5JRXhCS0xNUlFm?=
 =?utf-8?B?TGpDT293WlRsZHNBR1FqZW5wL2NsQlkxdmMyeHFieEZ0TXlDdG1vS0E0S2hY?=
 =?utf-8?B?YThJZWRyOXNYSlh4bXp0Sk5yOXZHQ2xwb0NHN1U3MVprOUZjdjFSa2tlK0Nt?=
 =?utf-8?B?cFdoSlF3K04yZXlhcVREU2M3U0FjNng2eHZBYnRhQkNxMkNSZ2NXM1hGb2Jy?=
 =?utf-8?B?WFZtNGhHWFdLWDJsckoyYlh0Tzl5OGlXSGh3YWM5V2hsZ3RyMlZtbzMwelVV?=
 =?utf-8?B?Y0ZMQzRWTWw4R1htWEljSUEyMklUU1BHRXpIczhnWjVabmRjbjJ1ZzdzdTZT?=
 =?utf-8?B?SzRRTXhxMVo3SFBCb25sZHNwOWEzM2xGTlZVYkxaVVMvRGhsTmFqYUZmaVBh?=
 =?utf-8?B?QjFwZEQ4SHBzQkdXNzYyNTUyOXF3VGtxSlpXZk15QmtNbll4Sm9HbUM0NTdt?=
 =?utf-8?B?Y2JoV0N6cDFDSmE4L3luUHFkY2xJd2QwZzZRNWl5SStmemN6NmtMWVBZR1Bz?=
 =?utf-8?B?MXVhR2V1d3FqdWltczNhUzd0bGZqVnM5V3RaOWxxYWpadUhIQVRPdWJhS25K?=
 =?utf-8?B?V0k4VVJXZnNQdmRULzVnSWpMM3JCNE9sRlZpcHJyT3BGbUhqZ2RlM2NzbGM5?=
 =?utf-8?B?a1BMWk4yZUFvVHZSckZJdFpob2ZOSEVxSkRUZ3IzVmwxck5ySUR5OU1zZC9q?=
 =?utf-8?B?eTh4VzBqNUs4Tnc2K05xTDFQUUYvSTgyclpYOUJETUZneTFIQ2NjTzBZMGhR?=
 =?utf-8?B?MGhFZnlwNXhJUnNSU2xxVUlYMkVZMDlZdVpNZ2ZxWndBZ0FmQWNiWjJ5ZmFV?=
 =?utf-8?B?TUJTa0tIUzlCRlE5WUJjWnBUUjNDUFNldFozM2NZaWoxNDdpVHVqd2tlTjI3?=
 =?utf-8?B?Y09YTkU3NVYzemwxSlZuZjlhZkNEbDlWaml0R1RVbTBjOTdPb2oyWU8xYzlO?=
 =?utf-8?B?dDdCbmJtME5Da2tZdzdTQUFnN2orSWhhb00vN1VzOUg2dFRtQXUveDZueUtl?=
 =?utf-8?B?bHo5SWt0Y1R6Y2tTcUc3dy9kK1FMMlExZkg3ODg2UWdoaHFSdXJLeFpSRGJq?=
 =?utf-8?B?ckFCbE9QaDhjQ1VmOTh4a3B6NGdSa3pIemV3cG5pOW02MWRIaWt1ZlpONUtm?=
 =?utf-8?B?OTFlZ0U0YlU2NjIraUE3S28yay9EMjJNQ2VxMnZXUXhvNTlKUXJQOUo0TXRo?=
 =?utf-8?B?M3VYVWxiZGoyTHQvdlgvVyt0UUZBUjJveFlTWUYrakh4dEV2S1M3VWZ5NFlG?=
 =?utf-8?B?UUluRWJsVnFRamlaR2VHeXF3UlI5bDNXN2N5MHZHZzVBSGpjYTJyeWg0MUJH?=
 =?utf-8?B?NWJsVEUvMS9nWDhKaWYwNjM2cC9LNTBXTWNPY3lxRzhEZTNTdDdtZDh2ekd3?=
 =?utf-8?B?c0hZUDU0N2lpT0lTR1NFVjhWazNUcXVQajBJRHdLSU9MNnl2M3ZSRG9OcVZQ?=
 =?utf-8?B?UHZ6YVhBcUxUUlJvUXkwMGIwREVuMXpnZkZTSDY1S01hazVkNGRsM2pBdmRo?=
 =?utf-8?B?dC9qTGl1eUNPUzFaczMvMExVL2xmNk50ZDdoT0pOTlRoblArdmdyZlVnUWpR?=
 =?utf-8?B?M1lPODE0TnlqOTJxc2V1SWloV2hBRDNIeWVzb3F5T0JaY0E3QTQweDVHTGM1?=
 =?utf-8?Q?uRp4nWYjDnujZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2NHR3h0ZmpEbUJub0ZPOHpWdEdpUE5DUGtKV29iMWg1YlF3YS96VDdsdDFw?=
 =?utf-8?B?QXZtbWw5dnpOOGlYMzZuU1BvZ2JFeE43MGlBR2VKZUxHSWVTazlZNHlITzAv?=
 =?utf-8?B?YkpHY0hqMDdMaUtwRkF2T0hUZTlBZkJvZW9ydkxPNERoZGlEc1QrRDVGczls?=
 =?utf-8?B?Nlp6RHBQSXJQMVFxaXRtbDZJblJPbmlxckdFZ1UvWnlsb2l1OTVLWXJYRFpX?=
 =?utf-8?B?SGJ5Z1JSZEtqOS85ZU9pbUZaOUk4YXMrWTZSUUJVaGZ0WjBrNTJ3Z0oxTXZX?=
 =?utf-8?B?ak1JcWx3emtCUUNvdXhBeWQrU0hUM2drcXBpNWxOU2J1WmNwWkdZT2JURE9w?=
 =?utf-8?B?NmdIVlN2RjhRdUphKzVxdFI4ZGNrZlE1V1hJTlNHcGtSTGZ5T1llTnVTYnlm?=
 =?utf-8?B?QzhOQ0cvNkFMMXZvQ1dJbkhRWGlzc0gvVHZkdWJINjRkcDB2N0FNOE03WGdt?=
 =?utf-8?B?OU9IU203Q1V4Y25jdWMvVjdkT3RsclFzLzhoeTFGWk9CQnN2OThZMzFlbTNF?=
 =?utf-8?B?Z3NRUUJSQ3dWcndsUHFIaG1IZzRnY0xhK0pNUFNENnJhNWhVaDlYWXBqeXJ2?=
 =?utf-8?B?RHYxMFZndzBybURTSWd6cjVMYTlHMmprd0s4b1VGWEl6OURvUmVBZ1F5Qmli?=
 =?utf-8?B?VzBGMlcxRDRjVmFsOEhCL2habTZlanI5d0FxbXU0YmpsNXBOMHY0VEQxcm1N?=
 =?utf-8?B?T1o3cVpDZEMrVDkraVpxNkRaWFUzUUkyZkFmbVNHV1VPU2tPNWphR3FsNTZo?=
 =?utf-8?B?cmdJMzQ0VjgyK2plZTRLd0J1QUZ6QVI4b1N1WlRLSFlJUENVMzgxekJkQmkr?=
 =?utf-8?B?L29pZUVuNytYWmsyOUNpekYzdDViUWxpakpxekNWRFhCT3E3WTk1VHdhczds?=
 =?utf-8?B?eERoRWtDb2E3RmgrNitsUnV3dXdRdUlvN0pKVnpPSHlrR0tUZ1Uyc1Z3SHA4?=
 =?utf-8?B?T2gxWDZNRllyMGNCQkdpZjMyVDg4M3lJaWQzNlFmT1l0R2JQVzRmckFKWXNE?=
 =?utf-8?B?THp0clhOU01BNlM5NWZoVmVpMmhuWThUSW45ZnlCeDBjakFiQWhDckFlL0ov?=
 =?utf-8?B?YlFkajEwdGtpY3lUOHpTWFlYUERCQ3I4TDZ2NUtqT1BubUt4ZXhhK2RkNXhu?=
 =?utf-8?B?cU9MVTFDaFhjYytoa1JPY3A2QXA1VFVlRWhtSHBrV0VhVnR2ejVKcFhvd3E3?=
 =?utf-8?B?SEVpUS9nMlhzZ2pDREVzMjBxQUZMKzNnbEN1emJGNHlXTWNZRmRJZlFCYjdm?=
 =?utf-8?B?cnRvVzh4ZGxNZnBRTnRkdjZ1ZUhOdTZOWHlNOTNDdCsyMnU3VTlYT3pVaUw2?=
 =?utf-8?B?dXFBTW9Zam9HR1VjeGlaZkg1NGdmMmdPVjEydXJVN3lLNUF0bTJhcGc0dHJJ?=
 =?utf-8?B?ekZib3ExWVRHREVld1VDVURDTUdlSVM3Q25RcDNkQU85YkNZK1lBSmtoUU5E?=
 =?utf-8?B?SXFzbm5HcU9BUGg5eTJLWmp1clMrN052M1ZneUdHdlM4bHZ4c1NDaEdMR2du?=
 =?utf-8?B?L3FDNVZGdXo3SVFNeWtHWDlEQjlNeTQ0WTNMU3JmU1cwb1FLa3ZNbXRmSFdh?=
 =?utf-8?B?REg1cmZ4aVRnWHhkRlRzdlNTUkwrWlM2TzdTMUhIcHhpNU5xTmxEbHdYYXFj?=
 =?utf-8?B?MWN1YjdQTGt6MnFDSUdwc1A1SUlqemtBbmFMSXc2dlM2TlZ4d3ovelFZWm9F?=
 =?utf-8?B?dGdibXp0bEFLaitDZDVOb2thckJlMmxTUmphS3ltTDdsdm1OTUxZelA4VmFK?=
 =?utf-8?B?UVN0NGEyMWRDQm1LeFMvV3V2Ti9xS056U3I0MCszMzlwdmhaQXVEdlJDWDdi?=
 =?utf-8?B?Zm9tVy9DeGxGa0FxUklZM3BmT3ovVkhacVlybE9MVytGWWxiMEZTMCtyeGRR?=
 =?utf-8?B?YUU4ZG5GUzhBUUM4ZExWeUVqVVFScjdvN0VmR2RGNWVFeWNraDVyR2UrOGlO?=
 =?utf-8?B?aUI2emhURURQeDh4MWIrczF5NDk4ZVlKNGxDVy9MRXpRNnNZN2ZwTkhWaVZP?=
 =?utf-8?B?QitJM1k0Yis4QklaandaUjFDZElnV016VTkzVmFaZlhqZTQ0SnY2eXdLc3dv?=
 =?utf-8?B?NTN5aVpnakZaZThMWHU5MVdRMFFNVDRvdGVOWWZSTUx3c2owK3A1UmlmWWlD?=
 =?utf-8?Q?5yB0z5t0ZOaAPPKlxYlQQNOKP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ab40ad-606a-44b2-9e1f-08dd524f9791
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 08:13:15.9053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGVjnqyjFHeSeq88hl0V/V5No/WE/lu46iwpeO2FNIvyuwSNiSWtWiXqKrpiCznR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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



On 2/21/2025 11:47 AM, jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> - Introduce a new function `sdma_v4_4_2_init_sysfs_reset_mask` to initialize the sysfs reset mask for SDMA.
> - Move the initialization of the sysfs reset mask to the `late_init` stage to ensure that the SMU  initialization
>      and capability setup are completed before checking the SDMA reset capability.
> - Consolidate the logic for setting the supported reset types and initializing the sysfs reset mask into the new function.
> - For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC firmware version is at least 0xb0 and PMFW supports queue reset.
> - Add a TODO comment for future support of per-queue reset for IP version 9.4.5.
> 
> This change ensures that per-queue reset is only enabled when the MEC and PMFW support it.
> 
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 55 ++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 4fa688e00f5e..fd2884de2dc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -107,6 +107,7 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
> +static int  sdma_v4_4_2_init_sysfs_reset_mask(struct amdgpu_device *adev);
>  
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>  		u32 instance, u32 offset)
> @@ -1366,6 +1367,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
>  static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
>  #if 0
>  	struct ras_ih_if ih_info = {
>  		.cb = sdma_v4_4_2_process_ras_data_cb,
> @@ -1374,7 +1376,12 @@ static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
>  	if (!amdgpu_persistent_edc_harvesting_supported(adev))
>  		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__SDMA);
>  
> -	return 0;
> +	/* The initialization is done in the late_init stage to ensure that the SMU
> +	 * initialization and capability setup are completed before we check the SDMA
> +	 * reset capability
> +	 */
> +	r = sdma_v4_4_2_init_sysfs_reset_mask(adev);

Late init is called after every reset. Since the sysfs file is created
already, it will return something like -EEXIST.

Thanks,
Lijo

> +	return r;
>  }
>  
>  static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
> @@ -1481,10 +1488,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> -	/* TODO: Add queue reset mask when FW fully supports it */
> -	adev->sdma.supported_reset =
> -		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> -
>  	if (amdgpu_sdma_ras_sw_init(adev)) {
>  		dev_err(adev->dev, "fail to initialize sdma ras block\n");
>  		return -EINVAL;
> @@ -1497,9 +1500,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	else
>  		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>  
> -	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> -	if (r)
> -		return r;
>  	/* Initialize guilty flags for GFX and PAGE queues */
>  	adev->sdma.gfx_guilty = false;
>  	adev->sdma.page_guilty = false;
> @@ -2328,6 +2328,45 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev)
>  	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
>  }
>  
> +/**
> + * sdma_v4_4_2_init_sysfs_reset_mask - Initialize sysfs reset mask for SDMA
> + * @adev: Pointer to the AMDGPU device structure
> + *
> + * This function initializes the sysfs reset mask for SDMA and sets the supported
> + * reset types based on the IP version and firmware versions.
> + *
> + * Returns: 0 on success, or a negative error code on failure.
> + */
> +static int sdma_v4_4_2_init_sysfs_reset_mask(struct amdgpu_device *adev)
> +{
> +	int r = 0;
> +
> +	/* Set the supported reset types */
> +	adev->sdma.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> +	/*
> +	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.
> +	 * it needs to check both of them at here to skip old mec and pmfw.
> +	 */
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 4, 4):
> +		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
> +			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +		break;
> +	case IP_VERSION(9, 4, 5):
> +		/*TODO: enable the queue reset flag until fw supported */
> +	default:
> +		break;
> +	}
> +
> +	/* Initialize the sysfs reset mask */
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +
> +	return r;
> +
> +}
> +
>  const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
>  	.type = AMD_IP_BLOCK_TYPE_SDMA,
>  	.major = 4,

