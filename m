Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CFFC98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 22:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8605810E5EC;
	Tue, 22 Sep 2026 22:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N8tQT3xc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C53A10E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 22:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vqaa9R29WJe9oYbxdDLICC36kalcByWJ5ReYW2bdgA0IB8vxphMeoqvIrxde2J0AVqyj0kNtIqkPmlCoJvi7znxotpa5s3kj57uBso21sjaqZz2rcwN04ggLQTdgWhGmhSX5wGKLdxxiE1aRHzpVfX284PC52kkrGrTVcCiGKQR6z2YhkOJiyh44/F9E98QWVN6scsMlW2VSOWA6EUgzLo+c6a2pcIyvp2o8AaBVMgTVmOG88j6z/hUGkYWTnuuZqNS+oWepbDhHV0VSXBt01di5qWgOsSSRJ+uQRi1vPb+H/Rv30pAWhEcXqlQEB+eDojE+9ZN5/nVkhmLigwlVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me69Ll4qcLBBdCopCE36RDxDcIyxc11wdQEAMjxffzg=;
 b=fB4JnicQcqRqXJ/r/ZevtLmqeHfrF5hEEQw7v7JzBjBoKN5qDnTIl7IGkLA1/+tT6tlz3XrFhMwhIQ/IgiF7c6QIUn408TTzmQXdLdL9KASHsHu1wE8BpoIYiKk/tC5ZsXw8igxjoBKeBNY7uNiJ0JaINua7Qi0/8DycMKbeXLH8TY4PyU/xegoiG1FJabnmcjTRMo9XPJVt1f3v/JGJH8DruHj4JVsdtUUshVQtGGzZudJKNPcIaUUmPrXc6hWy5MTO4FoHUzNe0y/F2b5zVVUXQhkD4Bs8QvuxxVARUacAZB861Ip1GWKogaXWVOgNgP9x9zHiP/0Mliu6yD1oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me69Ll4qcLBBdCopCE36RDxDcIyxc11wdQEAMjxffzg=;
 b=N8tQT3xcum2RWgssNYbz5OA8CNdwv3YDWEufRdkyMg7oG0VbAvpwpg7q1WK9La7zd3y1obB0Os5s8lb9kKaDMTaAIX9WZ6YzGjhZRsQjTIy2eaMkV3fDR6e42pYMvjoPrDVt/x2eRZwKTLqd4V90q0iVGbfiEOCGX8Ijj/HzlLY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA1PR12MB6649.namprd12.prod.outlook.com
 (2603:10b6:208:3a2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 22:20:09 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 22:20:08 +0000
Content-Type: multipart/alternative;
 boundary="------------z19BHIR5mIAiy8cC4WrPE5HK"
Message-ID: <399e1ed3-d377-4a4e-906f-1a5d57113720@amd.com>
Date: Tue, 22 Sep 2026 18:20:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Reject UALink handle ioctl on devices
 without UALink
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com,
 Sashiko-bot <sashiko-bot@kernel.org>
References: <20260922145653.1207241-1-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260922145653.1207241-1-mukul.joshi@amd.com>
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc877de-d89f-446f-0c2e-08df18f7a8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|8096899003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4+vGY/2J/BlaOCTYmpRXe5rq+oefX37ZjnCUtJzg4qyPhB4NRa7ndPNi6M583T8VGlRUrNRBH+3N4HqymVcCcEnGKvoY6UTU2oCV+QD0mIK5ovDEplgdnv3ktYJs0GarvmT5DIloFFxGouW/dYo/DqlGUlfO/W43H38hbey6pTRwF/r/QxwftUQjwXzm+LfZ9uX9+QpA6XEM6x0LhrUPPYPyz2hCUqP7ixqCMxVMgfKCgv7wOm8kC7lf6Ynm8GlkKvx1+t4GwGiZWT5PPCIDC6H9VZU2RxJX+95hRkSwfwU66T5zAXWLsBeyb/p+xHOr+iqaDN1yva6e4rA8s5SXkZsbX/VwOSwrpSE9rlKC617IPV3yrQllRJMZEr9hQeFjdtI1iCTtYAuCPH/nQuajPWCHspxZjdrylD1O6nXPAh8FQM0dLaYubCd2MJ67gso/BV4XCFLyjeP7G+GZ73JEeul21tkqmnGUgxC5qZpM5GxLtqChIgzwEnkcqlaQ7pttbuZIou0iYRKpIdmo+e27CBcYHVEEr1aGsjga1c+VeOe2L1lTPdeMkwUtIZ0mkZhJfwSYaT0iUdpdtPUe6lS6EozwVwWlQYF+/AdRkeXOFJ0nlgrx0H8wfjwRgaSLa14DXrVCaTjK6j9rEPDNClsmOQU1H7h42Hz4eZdK7lhWuME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(8096899003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEhpOHVQdkFzVUlKWW9HN0FOdHEzbHBsR0ppSXJFZjF6Q05tTXFKRUhDSkFK?=
 =?utf-8?B?VU5FNUgxaVpyNmljczF6M0JBbjZGYWdZbE55V0FzSUFFbDl0SlhVZ3FoV21j?=
 =?utf-8?B?cUR5RlBiK1ZsVEJBZWo4dWlCU1hRRWFZd3VFT0tvdWZQS25CZ2FabExETHRQ?=
 =?utf-8?B?SCtOVnBHZjQwbkJXZ3FzTWNIWml6KzJzZm9EbnVLZEcxRlRiOUxGNjhDQWtB?=
 =?utf-8?B?OThUSGNHU2lRcmVvaFNNM0RITVBCTWZQSnlVMVNhblNOWGtvd0E0UXZ4aWlw?=
 =?utf-8?B?cnNydWtkSHZyUHEwT2R0M3M1RTNVeW1HdGFka2pHYnVyMFlTWmpzTkNiVkJN?=
 =?utf-8?B?VGI2YWdMeXE2azYzeW9DK0lJc0xyamxBQkJGNFYraDkrMm1ZRmZDdUR3VDl0?=
 =?utf-8?B?TGVObko4cGdPcG1haU5SYVg5djIzdUwyUEVWUld3TlBQWEMwY3F1aHZ0UW5l?=
 =?utf-8?B?b29mK2dlOTJlZVd2N0RjVENSYTJtVjluNytxZDkxTXk2Z2hFbUJXdy9PQitx?=
 =?utf-8?B?THE5VVc1bUFPLzhvYlhNYzkzRW9iT0lVKytxSG9MdDN1UEREd09sTnU4TDhj?=
 =?utf-8?B?cS9SYnd2RFlFajdOS2RYdTFxQXNOMzhHaFZnZXU3TVJtQTgxSmMwVkg0VUNo?=
 =?utf-8?B?bHFSekRXeXFYYVNpMy9FTTFHMHRJZit4VG5DbFRYbHVzeUtvYjIvdG44QmxR?=
 =?utf-8?B?Vk5IN2tHWkpWZFVnOVpzZ2c0Si9jTzFyZGtMSnQxWjZtMklQM1dIZU5KTW95?=
 =?utf-8?B?QWExQjYrV2Q1azBpaGxCWU5JekoyNFcvQXZPMENFdUo5ejJoN3FncE9wb0tD?=
 =?utf-8?B?N1N3UjdrOXdxNTVqeG5mZHdPQkd0QVg4Q2Q1d1BuN3RyRWpJelNQYVFHVWs4?=
 =?utf-8?B?Wng2dTJpVWQwdkF6NWsrUkFHbUNIOHNjOUFjQnd6bWN0Nlpac2hpVXpLTUV6?=
 =?utf-8?B?dmdxeGpicjE0dmVuRmRWbkZpazVPL29mRWMxaG1lVUJUVUJlVmVMZFdHWGFN?=
 =?utf-8?B?c3RQSEttUVdYOEt0T3o1V1M4YUt3UmxJRW41aVE3Mm00V1VyM3FzS0hLL2NU?=
 =?utf-8?B?ZUM3STcreXF5M2RhOFpKQ2dMbzZVQnpQWVY5YStObWF4LzV0SlBqZ3o3ZUln?=
 =?utf-8?B?c0dpUGV5b09WNDVrQ29MVW51aTM4Nm16YndmZ0VMbzF5NTZKUFdEdEx2QUJF?=
 =?utf-8?B?MThVdFRUcEVxL1hpcjl5YWN4eGU5N3h6RUxWT1lPME9ydnZWN2VHRXl4UFFH?=
 =?utf-8?B?ekRqaFNpbGE2NGlGc3FqM09QaURjWHYrQTlFUUdQQ1VCditNWTh0NTdCZGtH?=
 =?utf-8?B?ZldpYndKSkhRTC95bHpWM29xRjFJazRweUtNVkhPQ0MzRHdEYzlBZS9yY0Ri?=
 =?utf-8?B?ZmZ3YitIcUVDZjk0OGJ0elp0TlZSNnhyV2NidFlvdWFHalpGV0l0M2NOZ1Vv?=
 =?utf-8?B?WEVsZHBxOGg4UGprSHdoallFWHdGdWtQS1RxRURnV0F6QTgwMW00N1lwL085?=
 =?utf-8?B?WkdWYUxQUUFudlhMZitjUUlyM2IrWk1OQnFXWWp3V2Q5U3BkU2RNZG5mRGtk?=
 =?utf-8?B?ejdhYWhTZmtrNWp4UnZoNHprYzBGQ1JRMXhkTWhRQUVKUlJRdG1JOWM0Y1Nv?=
 =?utf-8?B?bWZyNHgrbVdKaVJjZHpkRlp6MXl5OTBQUFQzMGZFZE1OeSt3QldHVTlFQjRQ?=
 =?utf-8?B?Z1owWUh3dER4dll1TU1ldjB0U3dsc2F3Um9ZZ1VBVXhSR1FOSWRjeFpLTmZq?=
 =?utf-8?B?KytpalQ5MXh3K3djOE51enRnYy9MaVFpVjVxalJXL0lReWZjS2dsdEpDUTZu?=
 =?utf-8?B?aTE4Q2ljcnNEQitrZTR2a015ai8vUUdFN1QyWHJXN2pBbTBwMS9iZTVHMzVp?=
 =?utf-8?B?ZGVnM21lNVlpemNTVXM1Nk9hNlZndHB3Q3JtR0tzS1V0eUtXWThxQjh2S2VV?=
 =?utf-8?B?MGwraVVKMW9kSDlNUi9jampKNC9PUkFPSDI3bHlranllcUt6V0Y2Y2VxQjJn?=
 =?utf-8?B?Y3ZlYU13V0N4MENyMUl1NmYrY29nN0xJQUtjYSswTmJ5bWRNZnpVVXZYYTNo?=
 =?utf-8?B?L3hqekxjckQyL29XYnpFYkVIWXk2em56VERZUmlRNFBxc3BKdGxMWkpFZDBX?=
 =?utf-8?B?MFFyWUpndGZ0ODJlMktQcjBvYXdDeEc1ODRXL1JUaTB0bzZQKzZrekpFR1Ur?=
 =?utf-8?B?WkQ3UEluL3FWcnlpYXE5bzUwaXRHZTkvSm1XdlJJT2E1T2k3YWNHZ1hPZS8x?=
 =?utf-8?B?VUpVNnNSME8wNTBaSWQxdDcwWUZmN1Vpa1ZTR3dkOFhzZ29ENGJGN1VpZXdT?=
 =?utf-8?B?RHVZcXExdzcrZDBsTEkrRnhQamRHZjJ3WDVGZG1TZXFhUkFub1RLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc877de-d89f-446f-0c2e-08df18f7a8c4
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 22:20:07.9518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76ARBzJJBothAfCSs6/Xo9RtVY/D2t5GoHmBEpMWa7HNr48YoP51+jJ8C4hU2oAyMjh1cdhvFv4Gd0p5RIG14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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

--------------z19BHIR5mIAiy8cC4WrPE5HK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-22 10:56, Mukul Joshi wrote:
> amdgpu_gem_ualink_handle_ioctl() dereferences adev->ualink.info before
> validating it, but that structure is only allocated when the UALink IP
> block is present, which is currently added only for GFX 12.1 only. The
> ioctl is registered for every amdgpu device with DRM_RENDER_ALLOW, so
> on any other ASIC a render node user can oops the kernel with a single
> call.
>
> Return -EOPNOTSUPP when the UALink software state is absent.
>
> Fixes: 8a8bb5cb0410 ("drm/amdgpu: Add ioctl infra for exporting/importing UALink handles")
> Reported-by: Sashiko-bot<sashiko-bot@kernel.org>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 8411ea17172f..3d84f5a7a34d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -4072,6 +4072,13 @@ int amdgpu_gem_ualink_handle_ioctl(struct drm_device *dev, void *data,
>   	u32 gem_handle;
>   	int r, fd = -1;
>   
> +	/* The ioctl is registered for every amdgpu device, but the UALink
> +	 * software state only exists on ASICs that instantiate the UALink IP
> +	 * block.
> +	 */
> +	if (!adev->ualink.info)
> +		return -EOPNOTSUPP;

I would fold that into the next if-condition, which also prints a 
helpful error message.

	if (!adev->ualink.info ||
	    adev->ualink.info->accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
		...
	}

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +
>   	if (adev->ualink.info->accel_state !=
>   	    AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
>   		dev_err(adev->dev,
--------------z19BHIR5mIAiy8cC4WrPE5HK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-09-22 10:56, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260922145653.1207241-1-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">amdgpu_gem_ualink_handle_ioctl() dereferences adev-&gt;ualink.info before
validating it, but that structure is only allocated when the UALink IP
block is present, which is currently added only for GFX 12.1 only. The
ioctl is registered for every amdgpu device with DRM_RENDER_ALLOW, so
on any other ASIC a render node user can oops the kernel with a single
call.

Return -EOPNOTSUPP when the UALink software state is absent.

Fixes: 8a8bb5cb0410 (&quot;drm/amdgpu: Add ioctl infra for exporting/importing UALink handles&quot;)
Reported-by: Sashiko-bot <a class="moz-txt-link-rfc2396E" href="mailto:sashiko-bot@kernel.org">&lt;sashiko-bot@kernel.org&gt;</a>
Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8411ea17172f..3d84f5a7a34d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4072,6 +4072,13 @@ int amdgpu_gem_ualink_handle_ioctl(struct drm_device *dev, void *data,
 	u32 gem_handle;
 	int r, fd = -1;
 
+	/* The ioctl is registered for every amdgpu device, but the UALink
+	 * software state only exists on ASICs that instantiate the UALink IP
+	 * block.
+	 */
+	if (!adev-&gt;ualink.info)
+		return -EOPNOTSUPP;</pre>
    </blockquote>
    <p>I would fold that into the next if-condition, which also prints a
      helpful error message.</p>
    <pre>	if (!adev-&gt;ualink.info ||
	    adev-&gt;ualink.info-&gt;accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
		...
	}</pre>
    <p>With that fixed, the patch is</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260922145653.1207241-1-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
 	if (adev-&gt;ualink.info-&gt;accel_state !=
 	    AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
 		dev_err(adev-&gt;dev,
</pre>
    </blockquote>
  </body>
</html>

--------------z19BHIR5mIAiy8cC4WrPE5HK--
