Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F31DC3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 11:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB7B10EA1B;
	Fri,  9 May 2025 11:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j16OnfSx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881A510EA1B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 11:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAYErgRo8ERGPaACpRIAqve7ua2djccE9jMYbxMzi9ZmVCsmxfuVS09KGamykQAeBe56ueTt0vd7EIGshEL2FYy4v9wj3H2tNGjemvrVL1ljjrhM833Bl5U+Pd5KjEjOas9GohvyYPXy4Bpf3kLFHVliFGZqZ4DgvHPN5Mlw3Ds1aYPOjQejqXg5VkMvGpMRKOGXrZpi85iMppCnyyN0p67d6XfYdpbdHuVENtGe4NGR++Vrg/vcjDx4Rbyuna5o/1NvkNgTHbfYZCYuOQW7bBx1n5h7GWCN2zZRQvXKUzRNQ0ijqGBZb3JQVrpd62FouAq27jZOdm2oEw2vHrH3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzHiz1LUAiHAqKqUzMreAfKU3MqhsN8Vk11HL+6HEHM=;
 b=EAGDRHSBCgz5k2PQrKxj8vSe941RZRVTwXQ9RPXSW3Nv3PENPaLdyR3RuENOIjTFlfcgkgXuPctCl84yDOCMXjA9BF13E+3FPSiDNqCaXIq+NughR+5f/TLqXLef5dsZ0BuG/XEs7ChSCZSD3z720zP/V5WigIPc1J9k2SltQbszm8e+zWHRCsv4p74kGolv4n1WQGKjK90z29Z2x/A06/G9xTbb9yycXrT19bzwiWpITypV4C+6nX8RIHZXWjx7ZEYrnWjAnUD6SVwpVejtCg4TNDhk4hupWANsnMWEi2OXGOylFe03ZSLdrSUE/oO/MuRyuh+EmsRjLzy1Hu6zPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzHiz1LUAiHAqKqUzMreAfKU3MqhsN8Vk11HL+6HEHM=;
 b=j16OnfSxjJfEHNetS16/WZx+nppcvLXTqjtw1E3LjQKVE1UvS7r9JZLmyAi/a7R1kqdxzSEGxS7dwg2Z68t7N+K5JVvyp6wPe25VkZeYKzH8lvnJLDTke2t2wv06JNWYxWGV1uTbUR/V/nvnuqyLAJ6btZJQoPYwB/7NQ8rstk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 9 May
 2025 11:18:17 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 11:18:17 +0000
Message-ID: <aeed65a7-e422-4f40-b085-6632dacf2562@amd.com>
Date: Fri, 9 May 2025 13:18:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix user queue deadlock by reordering mutex
 locking
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250509092215.3667971-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250509092215.3667971-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cd3abd-29fc-494b-caf8-08dd8eeb32cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWd2TlhVZWtOTkZWSEw0Q0J1Q0dtVGxWK0pyRXNJL3YranBVSUd6b1M2ZEc4?=
 =?utf-8?B?MDZTZU5lZW1CM0pRRS85V3diYXFXakMzaVh2VHh3QlZPR1JXS0J6ZlVadmlu?=
 =?utf-8?B?RzRHRzVJWXF2VTJ2STZxb2oxNExlVll3ZHNjTFFURzNPeWxuSVFwcDJOZ1gy?=
 =?utf-8?B?Nm9CdURBWjlKTlU1MkJoTkZScGRXQVFCTjJoTGZRR2hLNnRxcS9ubHhYSVR5?=
 =?utf-8?B?aW5ha05xY3pwQ0krQ3M1MENPRno0T21na2w0S0tyQVBMTXlVNmhLWFlwLzY5?=
 =?utf-8?B?ZkdudmNHZXJVcjRhdFZGUktBelBEV2wweW9BMkJSTEZyQUEzb1daOXJrbHdY?=
 =?utf-8?B?T0huVUFoUmpBR3JzbFhCZlBhc1phMUFpcWk0cXQvRVFGR3BudGpZMjcvRGRM?=
 =?utf-8?B?Ni9zbC9PcnprWHNGQVN4VEJRRSszcTIvdGZWWkZ6UGFVdnhod0RoNE1TbzV6?=
 =?utf-8?B?OVRKZE5vUXlBR2Qrcnp0ZXZHVGs5MXRCQk1vWmhMdTVJUVhRWHJpR2VsTHBl?=
 =?utf-8?B?OVhPMllLNHpNOU5EMkkyM3hWaWRVQmpUWXdycTBkaGxvSXZCdExKS3dTWlpt?=
 =?utf-8?B?S095SnFGY2ZFbE5IZUFIeWR0R2psNWk5MXlRSndOTmYvdkNuU2JQbWhvWitF?=
 =?utf-8?B?aFFQVFUxMVRLbHpNZGkzRW5IL2FnNW42ays2bDMremxhbzVpRlJPZGdwUzBz?=
 =?utf-8?B?QkFKQk5LTjBXVXZzUk96bkFqK0wvSHRKMzZoMmtja1FUdHpJSUhMWnpVRGds?=
 =?utf-8?B?cnNOTEh1eVlNOVJub2lOVlJua1RXWW1IcmFPV3NxSUpJKzRzWjE4L1c4Mldz?=
 =?utf-8?B?bENYeitFUnNZT3hhYXNyT3FJTWFOaUJ0UGZSQnBMWWhzMklIZXVNMkUrYVdW?=
 =?utf-8?B?ZTJOMnhiTXI3RHc2dTUvZDJNRkRlbGdZMGJqMEo4MG9GcDAwTE5nQlB4dkRj?=
 =?utf-8?B?OFBtVHhTcG8wSGtuRzE2OWtZamZtTGF2cit6d2J1NFlQdE51UW9JdllUOVZt?=
 =?utf-8?B?M0lWNk1rWTJuZ0dXQjFjcVJZSkF0Y0RYOVhqN0RVZ0NETGlZdUdrZ29wcHU3?=
 =?utf-8?B?eGR3MjhuM1FCME5ZaE5EWkY1enBYK3NIQU04YVV4RTNudHBDYUFtOWtOTFI5?=
 =?utf-8?B?Z0xJMzVRTzhGcFNlVGFiYTk5MzczVWNvSnk3R0hIc0tOVll5S2xWT2NpWmdj?=
 =?utf-8?B?YS9Uc2tpM0R1VTVDWXo1blYyekN4WjM1MW5oQjRmdm9XSURZNTM1cHdCVytC?=
 =?utf-8?B?Q3dKRFhUSEtnVVNIaFNZbEhVRC9oWTRXaFNmMDlLOXQ1Tkt2c2g2bHpnaW5M?=
 =?utf-8?B?TnFIeWFtcG52ajdkdnFqOWEzVGZkUTdGbGltZFFXWG5Xd3dmNm0rM1F5RENt?=
 =?utf-8?B?d1JsRS9VTXNQaG85RHhoaEZyWE9lZmoyWDZnWVFkQVNDaWU0aEVDSUtoK0xG?=
 =?utf-8?B?MGFqS3ZzMXo2emhNY3lKK3p6dDJrQTJ5Q0ZZOU9XRnQvZkZ3OFZpV1Y3bEdL?=
 =?utf-8?B?V3Vtd0RWMXkrS0RvQ2U1QUV5SVlsVUtneUJOdUxIdzcyUy9oV3JkUHdNdVlQ?=
 =?utf-8?B?eENMU1M3NTA3NzFnbHB3M2t2TmkrS1NjODF1cm9ldytESVFnYkhCR0QraXA5?=
 =?utf-8?B?NnRPNVNGU3EzVExDL1lhcVhBTUFFNlVwcjZBK3hheWgxU1ViNWdVT3lHM1VS?=
 =?utf-8?B?MkNtbWlqdWJqOGthelFJNTU0aE9uYlBrd3ZvSnA2MUk4UllmNFMrZUg4cElk?=
 =?utf-8?B?QUxYTnh3a1hlSC84YVloL0RVQkZoNmZwQjlXVERLYjJGeitsLzVTdFQ1NFhH?=
 =?utf-8?B?bGtWa04vb295blJPeWpNZnBwL0U3b3NzWm1na3hrTk5DU3h6dXU5WkxtKzJu?=
 =?utf-8?B?bmRKcTF0MHlYb3RRdzF2RjhqSGtFcC9rUVNSWlJwUWh1cFRBWGtaNGZwQlRs?=
 =?utf-8?Q?zj1RRmu3wMU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVLZnRSamd3ajEyYWZDUUdpN20yd1VBb0lobU55RzB6OXB4MjNRNlBQbGI3?=
 =?utf-8?B?UzBTMFZEbm5IQzJCaXlZWEl0YzdsSzNGY3l2dFpGOWN1VktrYk05SFhobi9C?=
 =?utf-8?B?SnBuSEFaREkyN1QyeVlHV0dLOFJYdzJDdmFNSFFSa2FhK1FkZ0xJQ0Y0NzFw?=
 =?utf-8?B?bEFtMndMKzBRTEJ5dCtCQTFvV284UkVRN24yVE5KL0Rrejh2dDgwWnNRNTk3?=
 =?utf-8?B?WlA3eUMvbTV5SEw2LzN1SVVxZ09RaGZocnlJTkxEd1BJME4vQ1ZhUEdhTHdp?=
 =?utf-8?B?TDlBSnRIQWIzOUs1YzhiME5OdVlRanZwS01GbUMxOEMvcmdsSDRUTnA4UXVC?=
 =?utf-8?B?Tk4yVzhBbWREWjJHdnFtTXY3Y1RyT2JVcTBBdk4rT2s2dHJUMmRTUDVpRG5S?=
 =?utf-8?B?cVFhZzAyaEdwcjNQb1dhZHZzdEw1MUIvc2owTUxGRTQ5TlNWc0NWNWJyTG1p?=
 =?utf-8?B?YmxPTzF5NzlxYWQxZTVGV1BBTkZML1RPNjFaYlJxOHlkNkV3d1E2M3IvdFJn?=
 =?utf-8?B?Qkl4L01FZTlPMkxxdTBZU1h6R1VIZkVxTGcyWkRLbnRUVWh4aG85WXpVcHA0?=
 =?utf-8?B?U2lsUTRWWWxiOXRJTzRsVi9RMTdFRjcrVXpYZUdEL2RtcVBOSEtmMzhZcXFW?=
 =?utf-8?B?TlRhMjN1UzIzcUV0dTEwdGxPb0dqZDdFVlhCYkJKNDFNSzQyVnErSVBlUUFv?=
 =?utf-8?B?bExSQ3N3UnFBeEFtc3p2TEUvMXV2UGU1eXFkNk92RUFKQVBhQlhTSWVyc29I?=
 =?utf-8?B?QlVUVEtOcE1mNzJ6MmYxK3JMdmJxZk4wc3d6aDU2M0xsNGk4dUc2SXkyMk9D?=
 =?utf-8?B?QnZSMFZMa0Z6VlVTMnVlVzVmU1RGSG9SYW9la0lLZEdidWFFcE0yWWEzVG1t?=
 =?utf-8?B?YlVTZ2V2bGNUdW5VVk1meFhhVmVMbEJKRGZNWlBXQWp2Y05MSHpIQmdJZWoz?=
 =?utf-8?B?dTI5cXBUS25PWml3OStNdEw3WElwTzZXZUorQXlnbEgwbVYwZHhyaGhvZCtK?=
 =?utf-8?B?S0k1T1ZHOCtnTE9qemFkano2YXh1UkxZR2VmbElZOW9Vd09YQTh4aDB4Qk9H?=
 =?utf-8?B?d1U0RW4ybU1uZEV6UlVobVgyam1ydXNudHlWT0lyUHVXQ28xTGJ0ZzFpclFt?=
 =?utf-8?B?RWJyVmE5KzNQVXV3MXVIMUlHbzkzaG1nTjBEWW1hRkZKTjJTQng3aWJZUzQ2?=
 =?utf-8?B?aDJiRjZNeklxWTQ3eTh5MjNnWHZ3empxSmZXVzRaZms0Qzd1UnkyUVZTcnNI?=
 =?utf-8?B?UHB1UHNCQ0xJNzdYdkpzRllGVUtWWWFQZDFlQjQySGQ2eFU4VXpxell1aSs3?=
 =?utf-8?B?SFlvQnB1TzBpU0IwOXlnZXJoem1LY1VMcUVMT09NYTlFM2piUVNYVFpnYjk0?=
 =?utf-8?B?dUtoUlVCcjdsQ0ZUTnQ5NTdUaEt0YTZzRGVXK2tWZ09PLy9YK0NVRzcwVS9h?=
 =?utf-8?B?WUR4RVdtUGJxSUwxakJkTDN2QkhGWm5lZGJBNU9jcnpoaFIyYjM1bDIwSHh4?=
 =?utf-8?B?Vm52OWQxcXF2cmNhRmc3T0R1NzV2TWRnSFpNMjByelBDWG43cE03R1hxbHpJ?=
 =?utf-8?B?ejIxbGxVQ2tIU0RpaWl6KytkSVR0Und3ZWwxQjkweTdITGZRaU1md2dKTVJO?=
 =?utf-8?B?SkpWd1hWYmRPS0FidWU4N05wY040WkcrdVpYMnBPaTNoWXl5bWlTT2twOG03?=
 =?utf-8?B?RFhHaEFLbkd3RkhqREZSUmNkb0phckFQTVBqLzF3d2l6YkUxWk03MGdldkNn?=
 =?utf-8?B?VkJ6NDQzZFN6WTlvVGFQbzI5L1Y0OXVmdFlFV25FalgwVXdaTlZCQTFkNU4v?=
 =?utf-8?B?NWVDWDZ6NlJ3US8yYUZ4MzNwYmxIN3E5UlpCTlg1MHF0UXhIc3RXQzJ2dzJD?=
 =?utf-8?B?ellvNVRMb3B6VFhRM3Z1YU9LcjRvYU9CbDFhUU9RckpZNWVkS2dRWUk3OG9R?=
 =?utf-8?B?R2hQa1lFRVdVVlhjWTNteFNpcE5kMmFSSnBWbmNZRjVZZUlYaGdBaWplWlRU?=
 =?utf-8?B?aFhaZHljRDQxQllHL2NQdnNEL2FVb0xBaTlJcmMySEtsb0FGU1IzSzAzN202?=
 =?utf-8?B?b0kyY3NtNFRzS3NFMlpINWlpaVpic3UxMmk1ckxJMHR3Z2hKdE9qcUJ0RXBX?=
 =?utf-8?Q?FCivuQvO1O6TbCR28A/jWeysO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd3abd-29fc-494b-caf8-08dd8eeb32cc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:18:17.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMP9xXsbXmjqibmToyDttkSQSrcyY//VimJtSD1gXNf4oDo0IhLyDBxMKbUd3II4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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

On 5/9/25 11:21, Jesse.Zhang wrote:
> This resolves a deadlock between user queue management and GPU reset
> paths by enforcing consistent lock ordering.
> 
> The deadlock occurred when:
> 
> 1. Process exit path (amdgpu_userq_mgr_fini) would:
>    - Take uqm->userq_mutex
>    - Then try to take adev->userq_mutex for list operations
> 
> 2. GPU reset path (amdgpu_userq_pre_reset) would:
>    - Take adev->userq_mutex first (for list traversal)
>    - Then take uqm->userq_mutex
> 
> The solution establishes a strict top-down locking order:
> 1. Always take adev->userq_mutex before any uqm->userq_mutex
> 2. Maintain this order consistently across all code paths
> 
> Changes made:
> - Reordered locking in amdgpu_userq_mgr_fini() to take device lock first
> - Kept existing proper order in amdgpu_userq_pre_reset()
> - Simplified the fini flow by removing redundant operations
> 
> This prevents circular dependencies while maintaining thread safety
> during both normal operation and GPU reset scenarios.
> 
> Fixes: e274db8c826 ("drm/amdgpu: store userq_managers in a list in adev")
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1c0ddec06280..0f1cb6bc63db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -879,22 +879,23 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  
>  	cancel_delayed_work_sync(&userq_mgr->resume_work);
>  
> +	mutex_lock(&adev->userq_mutex);
>  	mutex_lock(&userq_mgr->userq_mutex);
>  	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>  		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>  		amdgpu_userq_unmap_helper(userq_mgr, queue);
>  		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
>  	}
> -	mutex_lock(&adev->userq_mutex);
> +
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>  		if (uqm == userq_mgr) {
>  			list_del(&uqm->list);
>  			break;
>  		}
>  	}
> -	mutex_unlock(&adev->userq_mutex);
>  	idr_destroy(&userq_mgr->userq_idr);
>  	mutex_unlock(&userq_mgr->userq_mutex);
> +	mutex_unlock(&adev->userq_mutex);
>  	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  

