Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C34606A333
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=szCSG0bb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD76D10E41E;
	Fri, 13 Nov 2026 18:49:41 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569AE10E41E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 18:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvGjmghOiPWDONtsYQmZio05UK/igE/ZJfMe/SS3tM71AEe1Fi7ZptWFiDNmS6lQV6XNQ6fQE0JoQRmdawQPROqrX8512/Km3KU5wQq8A6ZbLcKl26unFsZUxfufBCY4T1sLAVROx8K7AFHKoeHTzX5OPdNJ9BCBYmmJbsjs23xUsJ6XihkqZoYRjX2iJoAL0e1OuPIZ1yIQwjJv39CYCH6tfJ3XUJ5izQvFICuH8+27kgkJZksSlg1+mMM+V+Swi5blJRiS0X04b8jA8IuN+kdR5OiXDMhtNN8RubSfy7OssIGWIkpiSCpvpZEDysmwfZyWWFEB9fZxHg8+7n931A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJEpW0ja0pSpblqaKhh4OR/7HxZNrCVABy7qXVWv3ok=;
 b=HvbXen9/6lrBPQJRBmo4C3DUMg/UVq10iuXTXZMaJHngcI8iGnAX7wk3vGW43PUerWK6Dn6Yto8rvd5dy5Pxb6nr5MJ4xoxOhog721Kk6Qq8wDG32qHSO1UEaDgYAsHGfjBaXKhnau1kDyLI3Mi5JLUfVXqS120sgOqgfjJHSSFBGRYPgk8ceJDuPEvQByJxA0S/xjfdE1GlVKiN9ib/iSbHb5o2/J0TMLKGtcPFMuNEkUgl4Oau1XxKFiHMVEdzzzQ5aNKnnep42tBi3baEz0WQ4TuE+LqPxDgusp2z45+Sxs3kt5rYvYuOQTC3vxKdU1wl6FFkDJNeAtBWhqNqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJEpW0ja0pSpblqaKhh4OR/7HxZNrCVABy7qXVWv3ok=;
 b=szCSG0bbh0y1ej3qvoYvYjVyImLlDsu/5R2ouLpmnuqwlxHAedjBqXY70UortHVkQmr/NMwss7K2uCJfwAppisZSjwibrfQk0Q+w+mbBYtF3xLMz9P2AtiUKE4tleOq4VhkIBzE4+ADru3fGGZqockzRMZqZwY9E459cWEz/UqE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:18:02 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 18:18:01 +0000
Content-Type: multipart/alternative;
 boundary="------------a5bTW8erQKo0sAsOSC6xGn1h"
Message-ID: <db8300f3-247d-45fa-8ae8-1846bde7efc1@amd.com>
Date: Fri, 13 Nov 2026 13:17:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear root PT after setting vm->is_npa = true
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, christian.koenig@amd.com, alexander.deucher@amd.com
References: <20261113134017.2781893-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261113134017.2781893-1-shahyan.soltani@amd.com>
X-ClientProxiedBy: YT4PR01CA0291.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::15) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 758365d6-873d-413e-2e7c-08df41b2738b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261026140227099003|11063799006|261026121527099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261102123227099003|56012099006|261028144727099003|10067099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: KkUNuvdwVMHJFf8BwDAXwqosrM7c60gpCZtyow3UHGF6fxF/AdEdstHkIYjOSvaaG+8q50MS8TwJWzHGCGC0k74uFyJ1lzs/QZ/cDKey4oU1EOzPsasqRXUWnGqp7DlnHxQIiDx3Eg255bxqCXOoNhIImFGtBLeeZx2ZxKjA8JfBXAwHLllUbkOEltLlWoQ4/cdMHFuAe2Jbu/11/59kOAhDTI8l6ALytoOXf25h7jMn0MAEh64JV/P4GDLif0C7I3IiJAj+8He7+dwp6sKA6WodlWJdF7p4oJBLxvEckB5EDD6b8G+vAfnNgsQTQLJIxcjcQycsE6bet8fF4Xe9nIVHA2CY/YJHTpB1yljrUyrlf22AaN+sRclGwOpquWxEUEFDu4MvPz9Y8P5nk9bUgnN2r+mtH/w/dFCWimJqf5rQFlsu5dgcrLwCyTadQr8CsvfoVcMfaB9h6Yi0wrVzutV2GieUAMORXYbY/Po4jZIkYnGRWRlowSMWPYuFOOa7YUiQzf3+B8TcWUAwxb6Jrkar6Ccdir7P5bj2DMyvGGaXUrvDwY97ndTlyyFTRRU22qzMz7hJN1nd0SPzsWefNAo4xEgm6m8FRrBtlebids5xiBfjADAXSpbuhaUISIFdznqeWAk9bW8NBmu/4Z1V59ltcSpupt8x6VmRDmSpxCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261026140227099003)(11063799006)(261026121527099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261102123227099003)(56012099006)(261028144727099003)(10067099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0lSeWhlL1FPaDM3cGcwb3RYMmVZRXZOUnN2UW93c1pyQW9MRC94Y01YUTh0?=
 =?utf-8?B?ZHFzNU5BWGZoZUl1Zi94SHFmdHk1RGVrSUIvZ0xtZlRqb2RVRm9keHJHN3I2?=
 =?utf-8?B?TGpQaFRLRmQ1RTRETndXSHRpQ3lUMllRVC9jYm9TdnkxeTVvVGZiZmQ2MWRR?=
 =?utf-8?B?R095VmZibnVOWDBsTitXWXdQNjJpUklVU0d1RjZDUjEwcUNpWDJ4UDI5NzRS?=
 =?utf-8?B?TW5INmU1SVNlS0l3L2RDUjg3c2ZOMFJ2eGw0amsySnk1UWVacjN3NnErS0Q1?=
 =?utf-8?B?bTErWjlpTkpXekRJQmV6SzI2UlIzam5tbGFoZE9IeDFYcC8xeVRzZU4yeTJU?=
 =?utf-8?B?c2RISFlGSGpORklaOVNzS3o2emN1NnlWdHlEKy9URmhNMmtvUGJCT1d1NE83?=
 =?utf-8?B?WitDMWF6MmVTQmN5YTNZM3ZjcCtEWG14c29oa1liS1dvZ09nb3I0cVdseTQx?=
 =?utf-8?B?Wmw2d3oyaUIzRHNvMk4zVW11bU1RRnZJbjJ5RmRsUFlLakhyNEdDTDNTRjRQ?=
 =?utf-8?B?UXpnaVh4VnBPNFNnTWpHTlJSQy9YTmJZVDdTTEdUWVN2d0NacVFXWmdGVk5q?=
 =?utf-8?B?YjhGU3JzMG85aktYbnlZNldVUXhIeHhIWmZvU2I5a051Uk5QdCtVejh6Skhz?=
 =?utf-8?B?UGZyd0NybmFINjVQQ0l0bHZiK0w1b0V3d21JSmxUV0dUay9aYnRqZlg1WXJJ?=
 =?utf-8?B?eHJlcUFqY3VwbE5YdVNya09odFNPQk1vTm5WR1RkUXBFY0xBeUd3NC9pMXNM?=
 =?utf-8?B?RXNxTWNHVzI5V0g0ZmsvSDlxTk8yL0cwenpNMmswOEJyemMyczJSWXlQT2lU?=
 =?utf-8?B?SUV0ZXlISmMyUkRVcVRKbkdSdkx4b2kyMENyK3NxYUszK3UwR3IrQnE3a1Nw?=
 =?utf-8?B?eTA3NE1INWJZTHMyQnlxVGxlOWVhQmRaYjlHQmR5YWlENUx2c2NZMW1HRHBG?=
 =?utf-8?B?RzNhSGp6bFZ3S3RmdFVYWE5lTXNiTHdtOFFZYkloMDRVajUyOElYTlp4dldz?=
 =?utf-8?B?VmVJTHZINVlYa2tndVZmeGpiN0MwSnFVNzN1OGZCdnhadmJTRWNKaFdCUE1t?=
 =?utf-8?B?SlllRGNKRGVpYVl5WGEvUmEvNEFQYmdEN05HWkdyNW1jZytqbUlyN0xWeUdT?=
 =?utf-8?B?RE1XRnVDQ3liU2JWVFYwZkRzZGl2SVd3YkE1V01tNXphbXZLeUtnY0NETExO?=
 =?utf-8?B?ZkQ2a3ZmT1Q0OTVQdWVSVVhqL3ZyWXhJMWg4a2NXNlhSdGZ6cGNtRlI3eU9J?=
 =?utf-8?B?MzBWVklRUnhTMmQwZDErQ29EdmFURUh6bjV5MVhLRHFtL0lJbUZ3SGpSUmdV?=
 =?utf-8?B?MDZuMWx4SktScWMvaWNOaS9Pa3lyL21Hb3J4b0QrZEZGcHpGdzB6WVVvVjc3?=
 =?utf-8?B?UEg3NG5KM3R0WjEzRVU1UnREa3ZvQWJmcVNHdDJsVUQzd055c2NxUXhoOTU3?=
 =?utf-8?B?RVVwNkVWWU5BcE5LTmc0U0VtU2VFRUs5b25QT1FJbFZYZ2hBYUZQaVFmZzM3?=
 =?utf-8?B?OTJyMWJHUnh2bWFHalMyNDkvOVVtNUVuUUE5NFJqUXBHVlNLZTNGeUFFSkNT?=
 =?utf-8?B?dHVCWEhwK2FNSnFVRlFiLzFJMGdEL0swVDR6RTlDSCtoQzhoMEdFa2p5OFRE?=
 =?utf-8?B?Ulhnckg5eUNFSEc3TDdPOGV3VzhJekRhWit2Y092bHZhN3NWQ0JuMExEZXd0?=
 =?utf-8?B?d1BHWFhveXNhVklkQXE3SWQ5Y0UzL29YU0JNcFJTM09CaTFxU2FFK2swVVla?=
 =?utf-8?B?Q1lxcHM3Z3ZFaXFoczBkTHYyOU9zd0tuZEc5aFZ3V2hCRlhWTnZGTUh1U2ZG?=
 =?utf-8?B?TzhoMk9vd2ZUenlrRzJzMy94NXZVa0pESWNteFQ1ZWxRTi9BSk1kUjgvVFlI?=
 =?utf-8?B?Y3lzTUZVc0RhRE1Ia0Y5STZzL1VLTmM2WmZYZlZ3cERJS0tmUS9mL1BsWjU4?=
 =?utf-8?B?NCszR2FsQnhybkVFT3BMRWZPcGYxb1ZjOFBKR001QWZVblVqMTFFTnRlMVlH?=
 =?utf-8?B?K0tZeTNyK1kwY1B3U2E2djZ5ZmxNUTFFNFRkb2duY1lmamtZVGhIMUpJWVRL?=
 =?utf-8?B?TkJTdVFjR3pzbGVPOGtUaElmelFyeUZCeThTeDNCaGlOYlZXQUduMXRWaVA3?=
 =?utf-8?B?OG5wRXB4V1k0Y0lVVGE0WlpjQ1U0NGJ0QWM0Y3JVZ2JmbFZqSnBFZTBsdmU5?=
 =?utf-8?B?NGU4UEhLMVpSZ1ZtRldpTk1vSHFPVC9EZE5rNHVyck5zOXZnMlgvcEFSbnZy?=
 =?utf-8?B?MVMzWHpKL2N4SU1DSHRGaHlaT2lFVlNQYjBYYTlSMERVWjFBNTVoUFpmNUxB?=
 =?utf-8?Q?cH2/kQZiO7TMBCZsfE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758365d6-873d-413e-2e7c-08df41b2738b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:18:01.2168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCVBov2SXAbfsh5FR/j4f0U5HBgtAxS7DZA1G88zeJYnUXXCvhgryfAvT6+d0HII
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------a5bTW8erQKo0sAsOSC6xGn1h
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-13 08:40, Shahyan Soltani wrote:
> Previously, the root pt was never cleared after setting vm->is_npa =
> true within amdgpu_vm_make_npa(). This resulted in the flag
> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>
> Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
> been pinned/validated. This allows the root PT of the NPA VM to be cleared
> with the correct value.
>
> Remove the redundant second setting of vm->is_npa = true.
>
> Suggested-by: Christian König<christian.koenig@amd.com>
> Signed-off-by: Shahyan Soltani<shahyan.soltani@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e..bc5d4bfdd424 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2829,11 +2829,12 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	if (r)
>   		return r;
>   	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (!r)
> +		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
Here we should flush TLB, so no stale translation is left behind from a 
previous page table.

      amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);

Regards,
Philip
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	if (r)
>   		return r;
>   
> -	vm->is_npa = true;
>   	vm->need_tlb_fence = false;
>   
>   	return 0;

--------------a5bTW8erQKo0sAsOSC6xGn1h
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-13 08:40, Shahyan Soltani
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261113134017.2781893-1-shahyan.soltani@amd.com">
      <pre wrap="" class="moz-quote-pre">Previously, the root pt was never cleared after setting vm-&gt;is_npa =
true within amdgpu_vm_make_npa(). This resulted in the flag
adev-&gt;gmc.no_retry_flags to never be applied for the NPA VMs.

Call amdgpu_vm_pt_clear() after vm-&gt;is_npa = true is set and the bo has
been pinned/validated. This allows the root PT of the NPA VM to be cleared
with the correct value.

Remove the redundant second setting of vm-&gt;is_npa = true.

Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Shahyan Soltani <a class="moz-txt-link-rfc2396E" href="mailto:shahyan.soltani@amd.com">&lt;shahyan.soltani@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e..bc5d4bfdd424 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2829,11 +2829,12 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (r)
 		return r;
 	r = amdgpu_bo_pin(vm-&gt;root.bo, AMDGPU_GEM_DOMAIN_VRAM);
+	if (!r)
+		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm-&gt;root.bo), false);</pre>
    </blockquote>
    Here we should flush TLB, so no stale translation is left behind
    from a previous page table.<br>
    <br>
    &nbsp; &nbsp; &nbsp;amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261113134017.2781893-1-shahyan.soltani@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	amdgpu_bo_unreserve(vm-&gt;root.bo);
 	if (r)
 		return r;
 
-	vm-&gt;is_npa = true;
 	vm-&gt;need_tlb_fence = false;
 
 	return 0;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------a5bTW8erQKo0sAsOSC6xGn1h--
