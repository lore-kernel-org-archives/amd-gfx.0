Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216C5EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 19:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A4710E0BF;
	Wed, 28 Jun 2023 19:50:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E1DF10E075
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 19:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAAHmGAYKjPUFk2DzFAt7vm/4Qieq1AY/C3QgNjcu3v01PVDYjYFXjd73qaIlvdXjOj5DNVxfC0F0tBF/6WPZTEKg1rm/wl2KZaorlE/mTlxrPgn7y6jL2gHpF2mYGhcFc/YmKfoPzPejWBbBGxyKpgZvoUVRSfSUUxY9hnlw5GIfhrkv3rpFPOhL1CEaY9fJnYcRgum0jraf5FVh2kxRE93XG5nUR3kXMmOTzc+FX5ulGy+hQ4NhxqneQC1B00LyN6Cj4HKY2IlCCWkrsOgR9iSiDd5KvTTxT2lXmVdap1JHHda1t1KKELeSEiO9kpFmBcXaUbmJsQ+ltwv0LaH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBF3W6W5Rf6lQUTIKKrmH1xg4OXH4VQCmszD4UVQ0fs=;
 b=i2ds6Dqn9NbcBCh1Lmey5wg4NWI3IGHbFGQEVrJ0gHVMANjdkHlL6x0L/grbAF1X//OGpteACV0KLY4lzebtYP+T4Hd70MhIVy/5+ISLb57FaCAv4QRaGr22nDDTA9PL8c3LoRdILS1SDYrGTSK6XlBMBG/cFBNEt/Rww15EgvPc9kncNWc8+2lh+4/HWKd5uum4Uavrq2I5eQvXP2E0PsgRbc+w21UBdl+qJR/zDzg1Ew0AYLwl9Anu44vzig+A41j/0HwuyVSGJfKQlZHA+aGOt+yQhII9OewBgil2mkD7UTsnchVjQeB9+OJ0tycgqEwzmr/eAYEnoxM3uF9/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBF3W6W5Rf6lQUTIKKrmH1xg4OXH4VQCmszD4UVQ0fs=;
 b=PjYDZe60Ixs7lDm/Uis1XnyZkXqXMp3wd14t8GVvh/jKARh5ycdVInCH8ZtMGyq/Po2TV1hZ9EUJCuLaM4OhKdPHbRdwP1WIm2Yjg0eWmG5jNzyKzeTJJoHNTBXjkNzX4Crk500vsKkpfTlRYiHDRxzwJv4xH8KDETzFGczQ9co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 19:50:23 +0000
Received: from MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::297f:a213:684b:6f0c]) by MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::297f:a213:684b:6f0c%3]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 19:50:22 +0000
Content-Type: multipart/alternative;
 boundary="------------Re8vyZKdK0Uby0G8GHXUYFJT"
Message-ID: <aef85802-4b37-53ce-ca35-257e916398d0@amd.com>
Date: Wed, 28 Jun 2023 15:50:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [patch V2] drm/amdkfd: Access gpuvm_export_dmabuf() api
Content-Language: en-CA
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230622211041.3863864-1-Ramesh.Errabolu@amd.com>
From: David Francis <David.Francis@amd.com>
In-Reply-To: <20230622211041.3863864-1-Ramesh.Errabolu@amd.com>
X-ClientProxiedBy: YQBPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::6) To MN2PR12MB2909.namprd12.prod.outlook.com
 (2603:10b6:208:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2909:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 79483791-f41b-43ba-185f-08db7810e8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mj9dFi8Vc/V8tGxfkBN6ZBPW5V1RGMOs756VG6pBBUfFX3IjG1i2w7eKRsuxq1AuI7VFQV8EdBCoQBUlaNG7VS+nOd0rF9dnTY2JawFJfdwBatIcQ58vFL+HJ3aUbVN0qZBU91i00J2Ymkqswrynte0TlhbLty4tSjGQfy1YdNDLCpBpAXp+OFAXTpXfmkxMe+1V9vS62rjOhyOl8NVdP1V2ptb/Zbiua01haLxD09xAhHVOH2KHQaYelCrakKhIcY3lgfWnqJGS+IEYVnQ+fIyOCsOuNzUEmsMsplA+RgJVefweIY2JZj7WNWw18T9RB0RoG2Vand0tpBeMzxbcxz2Dt+iLfULhynZVafy7mLyLJ/5ZD7A+LYbgZno+cSsoyglU4knBNp7QspU01VJD/ZEs+ysCowSGgUt+mKYs8bBl8dJRn3w/aia3LSpVAmzjUNh0Y6G8mE0W6CxQeNUmodrXNKGHDot0QbVor3h+5sxb/HjWGuzmcjqTNjrjXEB+CEniK1c7MAgdHYsL/VVVpJWxcTsBw+mRTajzVGN4Dw156CFLZUGHRMt+C8ROxHdZTKlRVlTmcQtjeUmiejsw8kPJ4pkVkjnhAhiRuDXcWPV1IzcslYMEaoC0d2sZJ3odkbZCdAX7HLsViFDivI94Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2909.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(31686004)(33964004)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(31696002)(66476007)(66556008)(6506007)(66946007)(53546011)(186003)(26005)(2906002)(6512007)(4326008)(36756003)(8936002)(41300700001)(38100700002)(316002)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVFvNVJ5L3ZFRzM1UkN4T3NiK3ZrZGEwbFV5OCtTN0lIMkcxMUgvcHlkOFJE?=
 =?utf-8?B?bGJjc3BqdE0rZXVkeng1RXBacXhYSHYzWGRPbXBYQU9rdEdzcFZKY3dBTUdL?=
 =?utf-8?B?QWJQWlZ6Q1o1dHNwNytud0wxaGl2WXAvRlV1L2FuejhpRGFGeEZqaUF5dHlp?=
 =?utf-8?B?VjVwaENia0p3c3F5Y3VmOHJudHJ1c094QWJwM1FrTU53UkN5eStpbWkweVlx?=
 =?utf-8?B?Wkhya1VQQ0Y2cXdQM29UaEZoWlFmZGYwSjM4N2xnc1NpM1NNUWZaVVdXaUFp?=
 =?utf-8?B?YTAyMzBsbTRhdWtCR3lvUkdPaWtJSm5sMTR6bHJXNUxzUnlucXg1MExtU0ty?=
 =?utf-8?B?ak52dU1aL0VuL1lUVThkL1dDakF5VmVZd3JYdCs2Q3JOT250VDZ3U1c2RFI5?=
 =?utf-8?B?K1dvdm1qVVY4S2ZiTzRGTys3MllES0ExeE1HdlF5ZnltSVRWMU0vRWY5blgv?=
 =?utf-8?B?RUNudDlyTGQ0YWhPR3hTdjg2Q3JPdTRTTXY0SjNZbkVCYU4vdEMralRtZ3No?=
 =?utf-8?B?L3VNVmFwTktQV3FDTWlRaXlQZTZBQnVZZHNDd1lPbWVEandJZVJBeVF2TEI0?=
 =?utf-8?B?SC9uMktPbE1lQkozMFFaMkMyYWtqL3pwOW03N1BIQjhkQU1SNGlLRDVMY3hk?=
 =?utf-8?B?ZU9oOUljMU40K3luZ2xjWjEzVWJzcUJTMnNFakpLclBlMDU1bVNVTWVKT2d1?=
 =?utf-8?B?SEdVTEpqRzdFVTRPaW1JOUdpZUl1Z3YvcHBGem5UN0NkOTRzVy9WdEluSWZW?=
 =?utf-8?B?cEsrUlBuOWdIbGZOeXpjUmJIWm9sclVJc2t3QWtYWDZOTVYzTWt0MlpCSG5m?=
 =?utf-8?B?MHEzY1hGL2F4VHpsVnNMVE14QkkzQUFTVnlUTzU2d0U5Z2VkUTlTMHNiNUF0?=
 =?utf-8?B?UHVPOXdkM1R2ZWp6MHJNVGRtOUN0S2pwRE1JL3A0RnkraG8zaWdlYkZQVnFV?=
 =?utf-8?B?c2U0WFVlbEFOY29JT1RUU0FPa2Fjb1JSOWoxSmpESmxQaUNTNGdSbXg5ZUNi?=
 =?utf-8?B?TllmNmRsV29FVzY0K2svdjZJR1dKQkVuSWZ4YXBtVXNJZnRLNWJKWmNQMkdj?=
 =?utf-8?B?WWNDelBFN0NUNHNjSmRFT3NLUVhYcGtmcG96WU02V1RhUmppQW1JbW1XSE01?=
 =?utf-8?B?OHp0eXNvcXQ2ajBGdkZEVEdCTHNuc0l5Sm9EK0JXRW96OHF2REhNdjVhMW5v?=
 =?utf-8?B?R2g3Wk0zMU05ckk4UkhLU3Z1YnlGOGp6azErMFQ2Tko4R2pFNlJib0Z0djBL?=
 =?utf-8?B?RHBmUGVMcHR5V1V2em5oUEhOTTliaXdvd2RXTGoveU03NGlCZjhQeEFtcTdX?=
 =?utf-8?B?QldzcE9Db1hlS3pjUjlaRmVvZzdnY1EwK24wSHNidDhteXY1eS9mQ0RobGpp?=
 =?utf-8?B?cDJEK2xXUExhM1VTVnA1ckJ4cTRTNC95cHpKREJpWS9IZVBsS0FnQmIyQTU5?=
 =?utf-8?B?bTRUVGtkWUxLSkZEbVF3aEZmOG85YTAyTkphWVlQUGVjalNoSVBJNGJrcFJr?=
 =?utf-8?B?cHYzZWZmR2JTYTc3Rk9ERWFjYnZNNEZaZkZIN05KYXl3NUFEVHlZNTBtdVc3?=
 =?utf-8?B?UkdmczlFU2ZHQmVGZ0R3dlhURldzL2xIQ29YS1l2M0plNnNmTDI5RXRvUVRw?=
 =?utf-8?B?N0dnb1dhcFM4a3hVRk1kUlhhdUJUanZ6MXpjeUY2Y2lrUHI5TkFYc29YZU41?=
 =?utf-8?B?dmdCWm9mYTJPWGp0L3JQbWl0a2JxY1VHWmFkRlhtb3BpYkIvbVVpRzVCRWhx?=
 =?utf-8?B?VlkyRmZvT0VyN015cWRNTHVKa3hjb2l3RklnVDZsUjNZaC9TY3JZL0VEbzlZ?=
 =?utf-8?B?c2x1Ri8vQ2NnNDVKUmxNU0RmSUVJeWw0ZnE2dnJwZnZoTHZNOEdDZlhKN2NT?=
 =?utf-8?B?Z2NSY3VsVkU4Z0tOZGdtRXY2djhnVmdFY0M0UHJqenV0dHBKTFVNQUFab1hU?=
 =?utf-8?B?aTIxTk9uVktpOUJRRS9GYndlejQ4MXMyVjhwRktDRUVCdnlDcUs5N3RsWWdU?=
 =?utf-8?B?ZHlscUhRNmtrVDVLVnhtRUl0UmNYVzliaTREb3lOd1NSaDR3eHhybmMzS29J?=
 =?utf-8?B?WmtEcXFlQ3Z0b0owTlR5aHpBR1pIczhtUm9MWXZ5QjR6YWZEdURBcHBGZHVh?=
 =?utf-8?Q?64h2YMEE/df3Kt73i0C8EpW+7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79483791-f41b-43ba-185f-08db7810e8df
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 19:50:22.6914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5naxs+Yg8uUix54UH4U4voUgVOly0ugr/GyP6hrsOfDaHRIXPGSMTo4M5VT7dbs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
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
Cc: felix.kuehling@amd.com, rajneesh.bhardwaj@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------Re8vyZKdK0Uby0G8GHXUYFJT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-06-22 17:10, Ramesh Errabolu wrote:

> Call KFD api to get Dmabuf instead of calling GEM Prime API

Would appreciate a more detailed commit message to explain why the
KFD API is preferred over the GEM API.

With or without that change, this is

Reviewed-by: David Francis<David.Francis@amd.com>

>
> Signed-off-by: Ramesh Errabolu<Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cf1db0ab3471..40ac093b5035 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1852,15 +1852,14 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>          return num_of_bos;
>   }
>
> -static int criu_get_prime_handle(struct drm_gem_object *gobj, int flags,
> +static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
>                                        u32 *shared_fd)
>   {
>          struct dma_buf *dmabuf;
>          int ret;
>
> -       dmabuf = amdgpu_gem_prime_export(gobj, flags);
> -       if (IS_ERR(dmabuf)) {
> -               ret = PTR_ERR(dmabuf);
> +       ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
> +       if (ret) {
>                  pr_err("dmabuf export failed for the BO\n");
>                  return ret;
>          }
> @@ -1940,7 +1939,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>                          }
>                          if (bo_bucket->alloc_flags
>                              & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
> -                               ret = criu_get_prime_handle(&dumper_bo->tbo.base,
> +                               ret = criu_get_prime_handle(kgd_mem,
>                                                  bo_bucket->alloc_flags &
>                                                  KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
>                                                  &bo_bucket->dmabuf_fd);
> @@ -2402,7 +2401,7 @@ static int criu_restore_bo(struct kfd_process *p,
>          /* create the dmabuf object and export the bo */
>          if (bo_bucket->alloc_flags
>              & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
> -               ret = criu_get_prime_handle(&kgd_mem->bo->tbo.base, DRM_RDWR,
> +               ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
>                                              &bo_bucket->dmabuf_fd);
>                  if (ret)
>                          return ret;
> --
> 2.25.1
>
--------------Re8vyZKdK0Uby0G8GHXUYFJT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 2023-06-22 17:10, Ramesh Errabolu wrote:</pre>
    <blockquote type="cite" cite="mid:20230622211041.3863864-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
Call KFD api to get Dmabuf instead of calling GEM Prime API</pre>
    </blockquote>
    <pre>Would appreciate a more detailed commit message to explain why the
KFD API is preferred over the GEM API.

With or without that change, this is

Reviewed-by: David Francis <a class="moz-txt-link-rfc2396E" href="mailto:David.Francis@amd.com">&lt;David.Francis@amd.com&gt;</a></pre>
    <blockquote type="cite" cite="mid:20230622211041.3863864-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Ramesh Errabolu <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com" moz-do-not-send="true">&lt;Ramesh.Errabolu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cf1db0ab3471..40ac093b5035 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1852,15 +1852,14 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
        return num_of_bos;
 }

-static int criu_get_prime_handle(struct drm_gem_object *gobj, int flags,
+static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
                                      u32 *shared_fd)
 {
        struct dma_buf *dmabuf;
        int ret;

-       dmabuf = amdgpu_gem_prime_export(gobj, flags);
-       if (IS_ERR(dmabuf)) {
-               ret = PTR_ERR(dmabuf);
+       ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &amp;dmabuf);
+       if (ret) {
                pr_err(&quot;dmabuf export failed for the BO\n&quot;);
                return ret;
        }
@@ -1940,7 +1939,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
                        }
                        if (bo_bucket-&gt;alloc_flags
                            &amp; (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
-                               ret = criu_get_prime_handle(&amp;dumper_bo-&gt;tbo.base,
+                               ret = criu_get_prime_handle(kgd_mem,
                                                bo_bucket-&gt;alloc_flags &amp;
                                                KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
                                                &amp;bo_bucket-&gt;dmabuf_fd);
@@ -2402,7 +2401,7 @@ static int criu_restore_bo(struct kfd_process *p,
        /* create the dmabuf object and export the bo */
        if (bo_bucket-&gt;alloc_flags
            &amp; (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
-               ret = criu_get_prime_handle(&amp;kgd_mem-&gt;bo-&gt;tbo.base, DRM_RDWR,
+               ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
                                            &amp;bo_bucket-&gt;dmabuf_fd);
                if (ret)
                        return ret;
--
2.25.1

</pre>
    </blockquote>
  </body>
</html>

--------------Re8vyZKdK0Uby0G8GHXUYFJT--
