Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB36FD530E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955FB10EA64;
	Fri, 27 Feb 2026 09:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PK96zF8e";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E4E10EA64
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 09:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtGFUs8LOalT5N182PVGierGwDAAgyUpZ4nXG9M23N7Zg43ZYlbTEv4m8tgTrOWJesilH1B5eWdrKs9A1gcBntUVtMrRNsA+pYgaWi1D0nS0YvV642ODGnPw5TECmTppfOecKZrOt5squ1SHnELuUbUcixi2JY5lD/3ft/DV3UWWzN7O7ufKn3eEhsTdhdMuEolRx1TTU6Zi+kSO95XX3p/b3imrWMZQE04+yz4ozMTtNn+bWogfszl371kQI7lWisPFpQbYuU0a0cAq75vCU9jQRrlHiy1dn4sXkVjshhh6b7DZPOcWiIiBc4yfnXlJTqmHrVsBXJSdWn2rr4Yyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTTRTyQKltl+qUEEYvVhS4SFbzDbpQtO9EWHx2pxppI=;
 b=qaKUrXiOQJULu47SA74JFhTobRvNzw1jpBa5DWhfLlR69JY4dAZsHf5kS4qFUzUO0kP8mzbSl8GjFVG9S0UK+nwqaJfz4wB3M6ViESiRueU174wDizP+feHx6kn5ZHTTc85uYIyG5vvetzBytCduxTRsfAMD3nTy4KURrRZdw4nabuhO2sUFq0xJ3jZN4jWJ3kEWHZOYkFlsFUgRzKF6zaxlbZZi5EMID8v/RULiqyu2l57Z2k5QnbWOxaJd3uBsc1cCj5p5eMhBRFL8p+dMPAOPNnmNTsT0ueqCGGa67fG7+xK0C20YbqtLYD9NA24ZeD7d2vSXl9wX2yunyZ9MTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTTRTyQKltl+qUEEYvVhS4SFbzDbpQtO9EWHx2pxppI=;
 b=PK96zF8edzCv7wKlFGChn7hBycf/YcvFZxwaonP7+AfvaYoeND18jwJj8lAF6HaHxLUtL/nMvRJEhfd4nLfB0v8RlGaI2+aEbN+8H02eQpzrnk1PZSQidhQsuXURBHa64p5XTnko1sm6aIweDlg3OXyGJaf/mUZMl4OFaS9Pejs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 27 Feb
 2026 09:03:09 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 09:03:09 +0000
Content-Type: multipart/alternative;
 boundary="------------kszag50kbAq8dbDoTT7O2q8E"
Message-ID: <52346e1b-0bbe-4381-8d84-b9f1c1da9593@amd.com>
Date: Fri, 27 Feb 2026 14:33:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260227085110.2865415-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260227085110.2865415-1-Jesse.Zhang@amd.com>
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: d476a7ef-4c20-478d-57df-08de75df06db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: 6hluXPL1iIWJVsL6eInxePFTnicjnr9Hd7v7OeVtx21yt0w9yZJG09WQaQWbzlcAQIIWgAxqL6a+bggqhpP4bA/5Jlfw4NE3LT/R24nizdfnxBvfWx2yW/EuQgp20QKBxtBx/4j5FAqMF58NfF5gtUNIoDrIQjeIYWt9lBwsF3GCSa6owJy8BTwOJwaIJI61U0jUPyZmDEBZSRKBKHWOMUk81jX+fCcpuRfJQ/6t9SiaR1KrfY1Q6ctD65Ya8o1cqF3vHOYtofUpNsODQvcSRy9N/MrVlD39NWsk1kAGvsCMkX96lQlWUQ8vcjvaU/CErNLaTPFusgMzqc+2TwilnNcqpvKjfQ+a4yN3lxPO/qiJodXg/UNubMN+ElIxRU9MbHvCWzAZ93PX/7TmGglDjEVNS3wpvMr9zBph2YDHOU22qC75gKgtfSYODT050YiOX+tBVHfUKQ5uvP2KTmWi6fjjKZmm8pI9WsWU0poj/et+j3anmm41k8y98DbfCB7Vd/plyeDQRmIFgPpijy7oVrSnYRZcknOEjch5UQUGhRyX0ZCKFyA8hubzBl6KYAj0P2AK2i+v5c19g75cNqziH6RB0aN9PmYlJFjRvfy06Dy7RgbAuhyUGY0AO3J5D/FT9o4kdh0xEySTHAdY+dpPzbwc40N4VEpMpXS2ZGzP0BtoCADaIr4Hl/tZNGmqoQMG4sAtlysTSJqQhKF8wCQeCnJEdivTsBsI3LfZezwERKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFzS2dYWlAxOHJkV2JsekRrR0dwVEQrSkt5T3QvTDBwcGx0dmhmQURDbkF1?=
 =?utf-8?B?d2dvRWIxMnlWSXFrYzNZT3ovRStGMUZZVTkvTHl6VVJyU1d3WTZyVmF0c2Rq?=
 =?utf-8?B?b3Vyb29LdHNSbURmTnRuTXhOVGVpYms3cG81MzhJSlpZZ2puNFVhV3VtNW1l?=
 =?utf-8?B?Sy9XbFlmVTNzMm0wbWxmdHZZMG9ZU1VNYi81OW9wUmovWUJUZ0RNb0hHSmJV?=
 =?utf-8?B?b0w1UGMvL0RmYWZHSXQ3MkNXMThoMFIxb3QwdUZBNkJUL0V5d1JuazNSblNU?=
 =?utf-8?B?ckJIaUYvNXpFUHFEZUlTeDhKcVZaUitsZk1COHMvYXhXU25jQzFTWmE2UHBF?=
 =?utf-8?B?ekJCcnlWU01tVE9pNUNMcWkyMXNmS09PSTdhaG1INGtqcHg2Z0hDd0l3UVRD?=
 =?utf-8?B?b0dLM0hDaHQwTSt0N0hKSDF1VGZjdHZIS2VRVXFLWmdZek4wcVBwb0pveUor?=
 =?utf-8?B?ZkZ1U2UzOTVHb3VWNHdJNjZyMkVqdTl1czFQYlFueWo5M0R2Qkh0ajhQWTho?=
 =?utf-8?B?cmp0STE3eEJHRGhwZkdKdU5KajdYbWtVRXVJVi9xRUo3bVNiR3ZxK2Vna3hM?=
 =?utf-8?B?QmpnMUtSTFM2WGROWUoyN0M4SjI1RzdxZSsxZENjbjFoMkE4aERoOThZcWND?=
 =?utf-8?B?ZGhWTllHUVNHK3ltUHlOVDNaN0pMSjR4c0l4R092OUVraFRHSDYzcUxFcmRm?=
 =?utf-8?B?Z1VIRExnWDVuK2s5WGJyejBWS1dndlZmRjBBNlV5STNZZ2NudEZEbHYvUFQz?=
 =?utf-8?B?WGZsejBuc1VjelhpK0oyWGI1R0VJM2dCdlYrQ2M5OTBNUVFZOUY3bW9CSTFm?=
 =?utf-8?B?MWJ2aXk0M1FNWExjU2FndjQxaHgwbThqNS84bDIrUWRVVkJpL2x4SVJhK01W?=
 =?utf-8?B?UjhCQzhZZHBFVHVlNmoyaHF5MTRGeUhPc2o5MWNsYnpZVzlENWpNb2tkN1Zj?=
 =?utf-8?B?V2pCRlNBd05DN01UYUVDOE16MEdhRTYxMFFBQVVzdlhFOWJySm5XeEJSbVJH?=
 =?utf-8?B?MXpIdFN1MWxnMENMNE90VkJTdGV3VGZRVlJ1T1lQSHNXTE1qejB0WHpudkFw?=
 =?utf-8?B?Q0RYd0dya3pFMHhVYWhFSk11UDVOQnlONXFFUXRtWEFIREVtVUIrSVZjWDJ0?=
 =?utf-8?B?b0p4cGNvRlVwUlh3cDMwV0VBemFIelNobVFQSWozcGJBaHVDb0FFb2tCV2NC?=
 =?utf-8?B?by9CMzVJUEoyaUoxWC9jYVAybUs3U2l1cDJBcUlMWUpXWlV0NDZuK0Ird0hq?=
 =?utf-8?B?d25pQ05LOUlaU2VPQVM5VjRLOFdIZmpvenNKOUE4OXFyeHBQWURhdUhHc1E4?=
 =?utf-8?B?VFR6SGgrS2cveGRTRlhGQ0srOGUycDZtR0lYMTllL29vbXRtMnROQkJUSHdQ?=
 =?utf-8?B?ZGp0OW5pNzJEVTE4STRPcHE3T3ZIdWpTbDNmRlQwT253T1Bmd3Qwd2VFTGFS?=
 =?utf-8?B?MjJlck5kVU5EUTlPNUZaSEdETEhHRjlVUDRRTXhNL2Q3eXRyQXkwcE5ZaVlK?=
 =?utf-8?B?SHB6T0FRVmVKaHNFaVJmYXNMOHRZSmxXWGp5bTN0YkgzRXFEUW5NYVloc3lR?=
 =?utf-8?B?RnoyUVhmSlhPbFgxS1dBT3o1cUF5QUZwYVFRQlE2cGV6bUN4Ly9uRW1pbWpG?=
 =?utf-8?B?WUJuYWpTZmJ5Ykp0ajMrcS9JWU9heEJBVEZUYlZBZFp6eHFrSjZxbUpmNEpG?=
 =?utf-8?B?V1FocStoMkJFRW01a21abXo4cHowMFp1T2FPNlNpZW81U2M2cE5OOGQ2QjQ1?=
 =?utf-8?B?Mzc4QlJ2a0Rma29FY3J4S0k5SUpESnY5cWEyaDFmY242U1FScTQwSXJEb29m?=
 =?utf-8?B?eUI2cjd3UHlhL0hGQS9MaGZtZXJsemlYYmZUTWNDUEtMNmlUaHUyb1pBdkpx?=
 =?utf-8?B?dURtRUpOTVE1ZnhkMTB2K2I1L2NVcDNJS2d3eDBTT1RoeTlSNTFjc2VQaUhn?=
 =?utf-8?B?L3pydWNiakFMcDF3VnFtU1BSZU55Mnh5Tzd2ZmRxZzRyVlE0elU0bm1MSnhJ?=
 =?utf-8?B?YUFxbnhGenV1VWp1WWxFNVp1aHBIMm4zYXA2Ym40SUlJZUFoUE9TQzJnYUx4?=
 =?utf-8?B?blJzeXpLMG5WQldkU2ZCM0VxK2FFdHQ5WHEvbGp1Nm9WV1JzbEVXcW03QWpS?=
 =?utf-8?B?VGwwREg5akRHMmw3dXkvWWUyOElsdWRRTElsbGRuUUdMRUhLYWpJUmt6ejVy?=
 =?utf-8?B?V3dGdFhISi9nMTlFZFlMWVg5dlc1di90R1hKZ015dzh6VU41ejdDWjBBaXQx?=
 =?utf-8?B?R0xsZjZ2OHpsT1FTcGRjS2wzVWhHVU9RRDZkZWZrU05qRUFRUVFnSUt4VU9u?=
 =?utf-8?B?ZnZvSjJHYlNOeEhVTmRnTlI0Rm9PcXhSTkFnVnVSNlEwTEdUMm81Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d476a7ef-4c20-478d-57df-08de75df06db
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:03:09.1504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoDYB9GcOL7+C0NhfJ04015fjSrGLdKo4bpUqMclSbA5hHOEhgKBPFtOBteucC0B1Y0mDeczvC1+0UCGsVTH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

--------------kszag50kbAq8dbDoTT7O2q8E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 27-02-2026 02:20 pm, Jesse.Zhang wrote:
> The amdgpu_userq_signal_ioctl function was triggering kernel page faults
> due to missing null pointer checks when accessing gobj_read/gobj_write
> arrays, and improper handling of memory allocation for these arrays.
>
> The crash stack showed the failure originated from the ioctl path:
> [   64.977695] Call Trace:
> [   64.977696]  <TASK>
> [   64.977700]  amdgpu_userq_signal_ioctl+0x8e4/0xda0 [amdgpu]
> [   64.977830]  ? tty_ldisc_deref+0x1a/0x20
> [   64.977834]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [   64.977934]  drm_ioctl_kernel+0xab/0x110 [drm]
> [   64.977955]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [   64.978071]  drm_ioctl+0x2cb/0x5a0 [drm]
> [   64.978088]  ? ttm_bo_vm_fault_reserved+0x1ef/0x410 [ttm]
> [   64.978093]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
> [   64.978179]  __x64_sys_ioctl+0x9e/0xf0
> [   64.978182]  x64_sys_call+0x1274/0x2190
> [   64.978185]  do_syscall_64+0x74/0x950
> [   64.978189]  ? ___pte_offset_map+0x20/0x170
> [   64.978191]  ? __handle_mm_fault+0x986/0xfb0
> [   64.978194]  ? count_memcg_events+0xe7/0x1e0
> [   64.978197]  ? handle_mm_fault+0x1cc/0x2b0
> [   64.978199]  ? do_user_addr_fault+0x394/0x8a0
> [   64.978202]  ? irqentry_exit_to_user_mode+0x2a/0x1e0
> [   64.978205]  ? irqentry_exit+0x3f/0x50
> [   64.978206]  ? exc_page_fault+0x97/0x190
> [   64.978208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   64.978210] RIP: 0033:0x7f3c08b24ded
>
> Fixes: fd4fde1df18b ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
>
> V2: initialize gobj_write
>
> Signed-off-by: Jesse Zhang<jesse.zhang@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 22 +++++++++++++------
>   1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..af934374df94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -467,7 +467,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct drm_gem_object **gobj_write, **gobj_read;
> +	struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;

We don’t need to set these to NULL anymore, drm_gem_objects_lookup 
already check and set it to NULL if num objects is 0. I Don’t think this 
patch is needed anymore.

I have already dropped such patch few days back before i pulled in 
drm_gem_objects_lookup fix patch from drm-misc. I think u might have not 
pulled in recent code changes.

Regards
Sunil khatri


>   	u32 *syncobj_handles, num_syncobj_handles;
>   	struct amdgpu_userq_fence *userq_fence;
>   	struct amdgpu_usermode_queue *queue;
> @@ -597,13 +597,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   exec_fini:
>   	drm_exec_fini(&exec);
>   put_gobj_write:
> -	for (i = 0; i < num_write_bo_handles; i++)
> -		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		if (gobj_write)
> +			drm_gem_object_put(gobj_write[i]);
> +	}
> +
> +	if (gobj_write)
> +		kfree(gobj_write);
>   put_gobj_read:
> -	for (i = 0; i < num_read_bo_handles; i++)
> -		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		if (gobj_read)
> +			drm_gem_object_put(gobj_read[i]);
> +	}
> +
> +	if (gobj_read)
> +		kfree(gobj_read);
>   free_syncobj:
>   	while (entry-- > 0)
>   		if (syncobj[entry])
--------------kszag50kbAq8dbDoTT7O2q8E
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27-02-2026 02:20 pm, Jesse.Zhang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260227085110.2865415-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">The amdgpu_userq_signal_ioctl function was triggering kernel page faults
due to missing null pointer checks when accessing gobj_read/gobj_write
arrays, and improper handling of memory allocation for these arrays.

The crash stack showed the failure originated from the ioctl path:
[   64.977695] Call Trace:
[   64.977696]  &lt;TASK&gt;
[   64.977700]  amdgpu_userq_signal_ioctl+0x8e4/0xda0 [amdgpu]
[   64.977830]  ? tty_ldisc_deref+0x1a/0x20
[   64.977834]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[   64.977934]  drm_ioctl_kernel+0xab/0x110 [drm]
[   64.977955]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[   64.978071]  drm_ioctl+0x2cb/0x5a0 [drm]
[   64.978088]  ? ttm_bo_vm_fault_reserved+0x1ef/0x410 [ttm]
[   64.978093]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
[   64.978179]  __x64_sys_ioctl+0x9e/0xf0
[   64.978182]  x64_sys_call+0x1274/0x2190
[   64.978185]  do_syscall_64+0x74/0x950
[   64.978189]  ? ___pte_offset_map+0x20/0x170
[   64.978191]  ? __handle_mm_fault+0x986/0xfb0
[   64.978194]  ? count_memcg_events+0xe7/0x1e0
[   64.978197]  ? handle_mm_fault+0x1cc/0x2b0
[   64.978199]  ? do_user_addr_fault+0x394/0x8a0
[   64.978202]  ? irqentry_exit_to_user_mode+0x2a/0x1e0
[   64.978205]  ? irqentry_exit+0x3f/0x50
[   64.978206]  ? exc_page_fault+0x97/0x190
[   64.978208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.978210] RIP: 0033:0x7f3c08b24ded

Fixes: fd4fde1df18b (&quot;drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl&quot;)

V2: initialize gobj_write

Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:jesse.zhang@amd.com">&lt;jesse.zhang@amd.com&gt;</a>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3c30512a6266..af934374df94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -467,7 +467,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	const unsigned int num_read_bo_handles = args-&gt;num_bo_read_handles;
 	struct amdgpu_fpriv *fpriv = filp-&gt;driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &amp;fpriv-&gt;userq_mgr;
-	struct drm_gem_object **gobj_write, **gobj_read;
+	struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;</pre>
    </blockquote>
    <!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ascii-font-family:Aptos;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Aptos;
	mso-hansi-theme-font:minor-latin;
	mso-font-kerning:1.0pt;
	mso-ligatures:standardcontextual;}
</style>
<![endif]-->
    <p class="MsoPlainText"><span style="color:black">We don’t need to
        set these to
        NULL anymore, drm_gem_objects_lookup already check and set it to
        NULL if num
        objects is 0. I Don’t think this patch is needed anymore.</span></p>
    <p class="MsoPlainText"><span style="color:black">I have already
        dropped such patch few days back before i pulled in&nbsp;</span><span style="color:black">drm_gem_objects_lookup fix patch from
        drm-misc. I think u might have not pulled in recent code
        changes.</span><span style="color:black">&nbsp;</span></p>
    <p class="MsoPlainText"><span style="color:black">Regards<br>
        Sunil khatri</span></p>
    <br>
    <blockquote type="cite" cite="mid:20260227085110.2865415-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	u32 *syncobj_handles, num_syncobj_handles;
 	struct amdgpu_userq_fence *userq_fence;
 	struct amdgpu_usermode_queue *queue;
@@ -597,13 +597,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 exec_fini:
 	drm_exec_fini(&amp;exec);
 put_gobj_write:
-	for (i = 0; i &lt; num_write_bo_handles; i++)
-		drm_gem_object_put(gobj_write[i]);
-	kfree(gobj_write);
+	for (i = 0; i &lt; num_write_bo_handles; i++) {
+		if (gobj_write)
+			drm_gem_object_put(gobj_write[i]);
+	}
+
+	if (gobj_write)
+		kfree(gobj_write);
 put_gobj_read:
-	for (i = 0; i &lt; num_read_bo_handles; i++)
-		drm_gem_object_put(gobj_read[i]);
-	kfree(gobj_read);
+	for (i = 0; i &lt; num_read_bo_handles; i++) {
+		if (gobj_read)
+			drm_gem_object_put(gobj_read[i]);
+	}
+
+	if (gobj_read)
+		kfree(gobj_read);
 free_syncobj:
 	while (entry-- &gt; 0)
 		if (syncobj[entry])
</pre>
    </blockquote>
  </body>
</html>

--------------kszag50kbAq8dbDoTT7O2q8E--
