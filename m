Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37F7C25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 18:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0913910E56B;
	Wed, 22 May 2024 18:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MPTEaA0K";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D835B10E402
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 18:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PucEJWrM5ccUmch0kFghqowrbtaXH55ynk0c6/1KxiBkxtEIs+VrE5ubzo0VUDgTry+VeHpgdRX/mL2Owv8hBD9Qd1BGbDxe7idXmScGNVBSbLDwfDK+kfsLrmxi+G3XZuauKcLbA5M/GOPz7+jZKsvzNjgbVnBGP5uwJNhuzeh7avdnwwU87tZHGy9cZfOBBN4TnnVU9PUozALur/KJaW5TAmAatA17/XSmMEbL7h5vsJnfqDm6upRYvrs6tJICMZMH6NaImAyr/cDidul5UlzoDUVcpo3kLZVICBk/hxH/wObxlFiDYiH9aLjisCdYYtrdPK7PxunYY1cKhIGfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzl4zaH3lkE/UVFwmKkergua6BOynZSGFn3AdClok+8=;
 b=JGYXtOprYg+KPfRMg9MN1GIGrex5s7cY6L4eyBDmNWZExOyF9y9jltXsZJgB6odqJUSNzmBSlUDFy8y9vV+MRSQN0mn7DgVd3wXUfpe18BpVPVC3ZYNc/F5mIUEykZHX/YDYTcLa6FFqlRlQntc9JHY0BOiWGMnZJw21q0OoOB9aYtWvyDIuKQ1yX6N52ZK0PPqq859k+KytJuGdM/93KooihbXG31+SyylZUGTlTufBP+z+W6rJjdDakAag59GXvvctCM4i6atIt/eQsXLoSQFYJzm910JZvR6Crgh37inYyn9iVTG8sevO6yycCphtTejAkaYSlOQrvVPQx6coQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzl4zaH3lkE/UVFwmKkergua6BOynZSGFn3AdClok+8=;
 b=MPTEaA0KiT6zboSMFaIUa90HpcWlNsIp9HMCcIGNjy739g9X3ut79yqvDMeWl01rzvtv4SJ1UtTWsiGSQVK0P76DCWjQOqtf+Z8QHMY9znKjJor25yAGe250n6qz7PO0JhKbbYM65CZ1hicT9YEXUrbxhWNWkN+yRj/fLBuxSCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 18:05:54 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%6]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 18:05:54 +0000
Message-ID: <4c481c88-e38c-455b-972a-a1f434fa787d@amd.com>
Date: Wed, 22 May 2024 14:05:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/display: Fix null pointer dereference in
 dc_stream_program_cursor_position
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>
References: <20240522153638.357634-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240522153638.357634-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 524b4207-93a0-4e4f-0030-08dc7a89d28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVBiS2JrUGJDMU9mMzlTZDk3RldCZjg1QndvTEZVaVVnMDRIQVI2RUhIaEZM?=
 =?utf-8?B?eWFnbFFXL0E3bTJHUEMzRXZVdGt2SnMvOTlCOVc1SC9IelpENFZRbEtvcEI4?=
 =?utf-8?B?TzUzVjM1ZlFEMXNxc1FOWW9IVk5qUGxpTElYRzlWblc5cmtSMVBnUTZKSU1W?=
 =?utf-8?B?YzZLM1cxdkxLQ1MwM2s5NUZuaWtUdzRtNy9zQlExZTNRSW5YYzFqenZncXc1?=
 =?utf-8?B?ZW45NStUNzVtUXJQR2J0RjNTZFB0RW52MEcyOFdNVzJBMHgyZEowSVZnQ0lP?=
 =?utf-8?B?d2ZRbHh2SUxjTW9xSW9WWm5meVphbWJxRUJyWlZhcFhTVzh3N0JOcis0NWJt?=
 =?utf-8?B?bkZ1WHc1WVB2N01RSlpLdjBOcGpxaGFhejlEbmFDQ0thdTlHYlk5VFVYV1dz?=
 =?utf-8?B?RTdYdlVlOTJpWGRKalRpN0pXK2pCWGhZNm10eXlhM000UDJ0MUxzWGd1UXBm?=
 =?utf-8?B?aVlEN0hlVGEvTEFjbmNDcXpVQzlJYi9zSkxETVdGZTczM0NSUG90NXllcmFa?=
 =?utf-8?B?UHlkSnRRSUdQZkp5SWJzcjd5NGlOcUN1MjZxb3lkdGU4RndJWWdydHRUS2xL?=
 =?utf-8?B?ZmxnUmZwdHNKcW1YaDFsbW9ZUkw4YkxSUVJyb2JSTXh2OWg5RVUyeElpVnpC?=
 =?utf-8?B?bG1iVk5VQzMrWFI0SDN3R05rZDExZUlCN2J5OG9GWUFhM1QxRlJzVDAxVWtZ?=
 =?utf-8?B?T3EybHB5K1ZjcW1oVTFpV2dLMFpUZ0VLcHVnVE45TVBsajFpOHU1ME9qQXBu?=
 =?utf-8?B?aHBDWEs4TWt0eDNMeVU0enFRSHZMdDNXVlFBc0lFQkthOHNmTU9IUk80K2RX?=
 =?utf-8?B?YWltVjI4d0liL29xcHBlTjhibVo5N3BxOEdtQ0tKbEZmV3hOMU5jN3lLbkRz?=
 =?utf-8?B?ckliTys5MytlcG9hZThnalpzTXVBenJiRVBvZ3FsV3JFR1BCckF1UEhONVhG?=
 =?utf-8?B?Z1BMTGgvL0dKR21SZ0RhczR1Skl3ckN4M1g3Y2h3YXV1V1lGTWprWjdsSk85?=
 =?utf-8?B?TGV2eXhVTy9XOGxWYTJndUNuZWZYWURRL3NIcXFkYWpNVmFkYTJ5eXlCaU5r?=
 =?utf-8?B?MEFGY0VCeWJvZnFpaFdnQjh5cDIyR2FROTNRNTZzYkVyK09sOUVDSlhxb0RF?=
 =?utf-8?B?WHJ5aDMvNUFObmUvWmFKdE5pZVJoYm5hZitQUXVxTFIyR1UxQ3BWbzBWanVT?=
 =?utf-8?B?Q0RMQm1yS3ZHZHhRM1F3amxSeGZLc3lxTDRtK05IcjVQWHlINzRhVGtNM3kv?=
 =?utf-8?B?cGpIZlRzOGwzTVJVR212ZUxnM1hLYy9qYUYwa2crdkFNYlFEVlJOYVRGaVQ2?=
 =?utf-8?B?Q3RlREJPYXhhNDBrMjREbjc5STVwRXVrbTB5RzhCNzQvM0dET2xGNFRYZmlN?=
 =?utf-8?B?VFBIaDhtRUVwdTlaeThzQ1o5NnUwb1ZaSnJPaFU0VE0yM013STFYMFkwRnpn?=
 =?utf-8?B?aVd1M0tpNVZScG9tZUdSeHVlaVFSdHpsQmc2Ly9nRFd6T2MxVUZ5MTlrTHBo?=
 =?utf-8?B?UlQreHQ1dzVJelc2N0ZjcDJrbEVYandUZW5xNS9UVUNWN0hueDd4SXR0eHAy?=
 =?utf-8?B?cGhqL1FvbDVPRFY4YVRocU9IVlI0WGhrc29QdTZoRFF6NS9tYmdKRmhwSjdF?=
 =?utf-8?B?d1RxSTllaExnbi9hVWRwYmV0c01ORWlUYlZGNU8vODd4azZ5eVpUbHFjS0Zm?=
 =?utf-8?B?V250REJEbW4wY1ZBczFSZkZxenNWclUyaCtpcjBkRFAvWFF6alJJRmh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTcyWk9hN2h5S3hIbS9MZHh1dzZhUTZ4VlNWYjhoeGVGM2ppRHNFOFlrb21C?=
 =?utf-8?B?ajY3T1FsczFOOHJ3ZkFReTh2dlFMMnlacHhqc0NFVDRJZWFYd001TE8zaVVO?=
 =?utf-8?B?bFlJcDBscWVuV3daYWtGc280NnNOMzI4emNvKy9JRDVxMkt4SEp2blVCa0Iv?=
 =?utf-8?B?aGZOUkwyTVB2bGtXRzhSZGVFZmdjaVlBalBaWER0VWRFRkJ5VlYxY1k0bDlI?=
 =?utf-8?B?Z3lnNjhrcDErUFFMSEptbmlhTFRkbkJJNlcxNnNkVHdvRjlpLzFjNnd1dEZm?=
 =?utf-8?B?bHp2MDg4ZW4vYmZRZWR4NEJGcWwvME5aRUFaQTNtZU9kY1NwaTNGZVhWUDVw?=
 =?utf-8?B?TGlpR0hhaHg4RFQxRFAxS1phVnc4a0dvZzFOVVBZNE1LU2tqTEFMNjBIVVFK?=
 =?utf-8?B?YnNFb1I2UlhlKy81anJ3dE1WSzVPTUl1RERZTVBWbkhjaU83QnVkaHdNb2s2?=
 =?utf-8?B?QVEwOUFWdUdDNkl3R3RESUZTTWxrZVRwakRqaEJzbERTeXhMcVlXejlrYmlW?=
 =?utf-8?B?b0VuUGRjazdPaTdWczUxQ2hQOUQxeUhoUytrVmxiYlVXT2JmOWJiNW4yZi9x?=
 =?utf-8?B?eEZMMUVhcEJsc3NpRko3RmhFQnhoNzJjMytxRmtpend2VDZZOElZYWE4eW1v?=
 =?utf-8?B?ZHlra0FaVGc4SWkxWW0yZ25mUE9yeHNpQktadTFTNEI5VHByR1hVZ0paem8y?=
 =?utf-8?B?bGF6bGFzaXh2VFN0WDRsbXBQWUpuakdVKzd5RmE3YmQ5cGFFNGFNV0lEQTNL?=
 =?utf-8?B?NmVBVUx2YmdwcWJQZVFDNkE1bzRsUVdrbGpWQ1dnYWljNno3bzEzblNDSVZu?=
 =?utf-8?B?Y3kvUFdGU0EyODRxc1k1OWtPSEdnN3hQQjZ1ZmZhWXV2UHJ3VEUwclp2K0Vw?=
 =?utf-8?B?UVR5ZjFMNnpGcnpWTndlblR0SkFkUFhhOXc3Z3dESTJ1b3pGYmFUTnIxQ0U5?=
 =?utf-8?B?Z0tNeFFJbjhscU1QNEljbFZJNjlxM3ptbGlkWFd1TXM3ZThoTTYzYnhmT0Jr?=
 =?utf-8?B?WlltMkRNM0JOcXNyY3hUUytCSk9HTHdCOFBFbGN5OGdKRjZPdjNPS2g3MUtS?=
 =?utf-8?B?VG5MWEFIclR2cFczWkV0bThPR3B2UFZGRDNRakFrSkMwNHVwc1dYdVJvU3Jt?=
 =?utf-8?B?UlNvUVIzUTZWTmpIdDNqVzBGSWloRnBZRjdnSGMwNXg2dzFTUW1Jbnl0L05U?=
 =?utf-8?B?VG9OVXVvTi9vekhtOFhhSHcxaVpZT3hMTWtacjBVdmp3QzZqRjVXT0lpemlk?=
 =?utf-8?B?a0Q2S2JreUEvR1JZNVovKzZITktBMjRnVjU1OFl0VmRDMXdkZWtnbzhlT29I?=
 =?utf-8?B?U0hFK1Zad1lDejJQMUVqRHhxa2VDeEl1cG95dU8xL3RmVEwvTGtUVGxqbUZ6?=
 =?utf-8?B?NE5RZXRYbmhUWHdEY2tOTlNqL1hWUTg0bFV0elhaa0ExenZhWTF6ckF6TWRI?=
 =?utf-8?B?UUlDTUV5aFFrdjBkdXh1cnpodnpkWTE4SXdGTmtjWWE2L0k1dzRob2lJQ3lD?=
 =?utf-8?B?QitieW9KV2pITDAwRGJpVFBnMjRDWGhBd1pzZjc1Q1l6d1o5ZFZvWGk2eUpt?=
 =?utf-8?B?Z0dQV3dSV3VYb25SbWt2Z1djdEI3cExJczEyVnY2SmVHUUV2aTd0UFl6bEYv?=
 =?utf-8?B?U1k4dWpLanR2bnU5cHZwTTBWWjBhWHBHWkhmZVNpclNWL2k2N3RXSkVqaGNv?=
 =?utf-8?B?d3ZTY0FKOGphNTM4TWtYOCtWbmJaS0NxMCt6Z0ZuUU9ObzhlOHJqZ3h3bUMv?=
 =?utf-8?B?SUlFYzVod0ZtWDJKTEZTcTY2UWJsUmwwRFpUY21IOUk5YnowQUdOWExVQWdx?=
 =?utf-8?B?ZWxZQVkxL3YrYmluRmNEbGkrM2V4VzBVQXZDUTlSYUlWUEZKMzVuc0pKbXYz?=
 =?utf-8?B?TFkwek5EQ01FVERxTi96OTN2L1RHRzMwb3UyZkJUTE1MYSszQXlpektKMTJq?=
 =?utf-8?B?T3JVU3Y2a0E2TERwdSs5MHdNa0tjYUJacStQT3VPMUlIQmtvTWpxaWFyQldE?=
 =?utf-8?B?U0ZtYmthUm5HTFFsbWFJZkdScExVVUMrQkFoczZqWFVuNGdoYUYvUUVyMFBh?=
 =?utf-8?B?UkVYaEpZa29BajF2d3JPOUNBUHBEaVh2VDh1RGVMaTU5c2ptUUZFRk0ycUZo?=
 =?utf-8?Q?AHZQATCg663udvfJyhqTXFNCh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524b4207-93a0-4e4f-0030-08dc7a89d28f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 18:05:54.5459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfK7CZsPXoK+8ZOM1fubtC8uMAMPLhrFddR5H7IRUeR6wgdUi1+fY2g85MuLv57ZN6wNTnUqqEutwjHs3pR2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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



On 2024-05-22 11:36, Srinivasan Shanmugam wrote:
> The fix involves adding a null check for 'stream' at the beginning of
> the function. If 'stream' is NULL, the function immediately returns
> false. This ensures that 'stream' is not NULL when we dereference it to
> access 'ctx' in 'dc = stream->ctx->dc;' the function.
> 
> Fixes the below:
> 	drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:398 dc_stream_program_cursor_position()
> 	error: we previously assumed 'stream' could be null (see line 397)
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c
>     389 bool dc_stream_program_cursor_position(
>     390         struct dc_stream_state *stream,
>     391         const struct dc_cursor_position *position)
>     392 {
>     393         struct dc *dc;
>     394         bool reset_idle_optimizations = false;
>     395         const struct dc_cursor_position *old_position;
>     396
>     397         old_position = stream ? &stream->cursor_position : NULL;
>                                ^^^^^^^^
> The patch adds a NULL check
> 
> --> 398         dc = stream->ctx->dc;
>                      ^^^^^^^^
> The old code didn't check
> 
>     399
>     400         if (dc_stream_set_cursor_position(stream, position)) {
>     401                 dc_z10_restore(dc);
>     402
>     403                 /* disable idle optimizations if enabling cursor */
>     404                 if (dc->idle_optimizations_allowed &&
>     405                     (!old_position->enable || dc->debug.exit_idle_opt_for_cursor_updates) &&
>     406                     position->enable) {
>     407                         dc_allow_idle_optimizations(dc, false);
> 
> Fixes: f63f86b5affc ("drm/amd/display: Separate setting and programming of cursor")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index de48084eac25..55e1c19b97f1 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -394,7 +394,10 @@ bool dc_stream_program_cursor_position(
>  	bool reset_idle_optimizations = false;
>  	const struct dc_cursor_position *old_position;
>  
> -	old_position = stream ? &stream->cursor_position : NULL;
> +	if (!stream)
> +		return false;
> +
> +	old_position = &stream->cursor_position;
>  	dc = stream->ctx->dc;
>  
>  	if (dc_stream_set_cursor_position(stream, position)) {

