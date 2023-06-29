Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93A7EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 13:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7458210E3D1;
	Thu, 29 Jun 2023 13:23:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A517010E3CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 13:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6c6LJ3JAWHYiSmu6GLkzhDXqNEogKXj3aJOzfVHquZvKvs5F/SH9zZwoN8J2KoJ1vg/AagiC40uGCGOIkSPpgLEcWMces9/cDOWP6WcV2oPQif4KumMRSN7cH+dp5vy2C4g2642Z4Ul77j241fQHwFAYOnGv/ibN7jwewh2iKSPk6xF9VPhn6DSdIiC3tjDyG6BJTtN5lw4VJ9n0xl+JmLFjPc1DSltAyF9v6dMwND8o9GygM+Bw+46G5wkw1pEZ59LBgWpQEfNrNsPXfMqpx5KjNikDI8OLut9tXjCfo6B98jghcZmz+Bs8+ECCSjtUVPpHzxmhlQWmf+3caiIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tWbbOuG13BzqSiRbs+wkOuN2z/q1OLuvfvTaUXZo6M=;
 b=gjuqwI4QOQJgwkbkgTVwEPH+IwbPNxjUlh85dezmU9ONb40SiVJqzd98WCof2M0hmi2LgauKgfVr0Ie9hhhAUSE4sbmkCIl/7mHgpUd/HamQv32ey7hcnsaRrOwCohTCoOomdonK8VQQwoaxuoukOxrk03ChDQP8IB/pkP0Y9xGBmMToEV6x5Qk02//aAQ/O59mk1a2zTm8I8vIdzehCUKWaPsO2yxgcTbyncyuNoTjyiYHNvR8BMrFvvLrIhC9o3uDhBiBJ9STUzy69Y5iW0UPBn/IxOafiUjGLIa/88iiFzS+anTvLPpr80ciYMGJq3mCVW4untsR8zhWcHqSlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tWbbOuG13BzqSiRbs+wkOuN2z/q1OLuvfvTaUXZo6M=;
 b=tHl0ALknsoqbzZnMQ3qew1/XARbekMtICW8g5MfkrXNGK9TQ+zFxn8D+WLwUO8An3C9utp0XzyfO+Ai5+G3Et6b5rGgjtHo2oX8qfqt0tMCc0Ojlc39dm9Ihl41bAFnbDkfrlUVrfv1CrVmhgRPhptSWgO0x/K8FACOzdE6NaGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 13:23:26 +0000
Received: from MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::297f:a213:684b:6f0c]) by MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::297f:a213:684b:6f0c%3]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 13:23:26 +0000
Content-Type: multipart/alternative;
 boundary="------------seaP21PnmrAly652UBpmSPo8"
Message-ID: <c9a10a17-d349-dc9a-8819-8b376efe2b7c@amd.com>
Date: Thu, 29 Jun 2023 09:23:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [patch V2] drm/amdkfd: Access gpuvm_export_dmabuf() api
Content-Language: en-CA
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230622211041.3863864-1-Ramesh.Errabolu@amd.com>
 <aef85802-4b37-53ce-ca35-257e916398d0@amd.com>
 <SN1PR12MB2575BD1009EC55A184222D8DE324A@SN1PR12MB2575.namprd12.prod.outlook.com>
From: David Francis <David.Francis@amd.com>
In-Reply-To: <SN1PR12MB2575BD1009EC55A184222D8DE324A@SN1PR12MB2575.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::27) To MN2PR12MB2909.namprd12.prod.outlook.com
 (2603:10b6:208:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2909:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f5df8f-db7a-4282-3eb5-08db78a402e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xewxka1McYBmaq0+3SnYpKZaZMv9bcW/pikUjSEwzn1Q1gB0etkOAstQP3lpFpuJAUN8ASjWO7r2rqpM/2M0xBvjnOVDzWjlOtGkwMruhBQBchFl3UI3YtOxrk0o2sSKxH/kk8L3kJXdclIfC24S2gmuQpWhhgLCNKL+n3AaMxSD0YkPnXSWGPI78m+lU95hvGnSLkiWEkbdGAxfpiD3TLJkQcfuIoyDEx2gkkJ/1ELphLTKoXtHOTIejkOz2MYHOofXki0gw3ub5TNyE8OY6LNnq4SxAnr5s0StijPKexERIIHoO4K1iVkLpAKueoi9mc8Sbl0FLCB7ZfPsTNWH8HIO/3U601V2nCSkMXL+4zq+59WKCVsNtV9IHBKDBDfSOvRMSkB6BKn0LNlt7i1N4Qb5JMdtzxclRHHNq1sX1mKfXpKTp9Id+atGTNQYtJAcRku9bekMBZXCk1N4+gogKH6dGTiju+LJhy//A+hoaIWiVATARlJqGtfCo5/A62rMmHA1nUK17HnvrfypoKA8iFtSm3HKzPEZYfN6BHOGFeNbf7qZQiq6IcB8+1nmnY8WE6hXK/KbNiETYZ1bJVe2nzDINWn/1TimgjpXXffXl6ccjjRITDW4XI9HuHc0j36M3fo4mTt37SPSfaFP0w43XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2909.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(6512007)(6666004)(2906002)(186003)(6486002)(83380400001)(38100700002)(2616005)(6506007)(53546011)(86362001)(33964004)(110136005)(41300700001)(31696002)(54906003)(478600001)(316002)(36756003)(66556008)(4326008)(31686004)(66946007)(66476007)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RTU29Cc0k4MjVSem5keFZDMmoveVh1QUV5aVZ3eTcyVGFyek1BZTdycjE4?=
 =?utf-8?B?SjhEZHJ3WUErd2pmTW8vcmFVbVVsTUVFZC95UFRMT0cyaWlNVVpNVENxOUty?=
 =?utf-8?B?OTV4THpubGUyRkVCdVBBR2Jla3pyWDZGdEFSVFZHWCtWRUxUODU0UmRBdmJE?=
 =?utf-8?B?NlJyd1lJeDh2WHl4WFJ4ZWFVcWhGcVo5SlpCdHdFVzBBY3V6bmgzakVSTEFW?=
 =?utf-8?B?OGs2T0JPdEphNkxDclJzanJNZEM2YXZRa25ITVU3RWZ2MXlwY3YyaU9XSE1K?=
 =?utf-8?B?amNhYWdGVnlqY3pVWXZCdlFwRFpFUmlGRzRQUVd5U2xGQVpScmhjY2NzdnVB?=
 =?utf-8?B?a1hHa2VIbG1SZVZlOEU3RDY2Nyt0c2poaE1HWEJFMXhwUVlpQVMzUDdvSDRQ?=
 =?utf-8?B?WWJaVWZ6NXhNekc5ZGlvNTJSalhENFJjMUt2aHN6R2piTi80YmlwV25yc2Zx?=
 =?utf-8?B?YmtrUzY3bmVLZDdudllacHBvNnQ0NkdxOGQ2SGhocXNRMGF2WWlLMDE1R2Nj?=
 =?utf-8?B?Y1grdEQ0WlZiTlBoaHI0c05Eaks0NDZDUUJya3hnbU9DdmJJVWtBWUUwazU4?=
 =?utf-8?B?aUk5ZDdlTVJKdEx3NTlBR1RxeUNRR2s3SmhWeVFIVFNvWjhtWWMvVnVrUklK?=
 =?utf-8?B?ZFZhZmlqUGNwRVVBbmljOU1ERy9CSnJYdWZkd0pPOHpYS1FNeEpkcEJXMFhM?=
 =?utf-8?B?UjFwbnBUVW1EQjRkaklqdXl1ejh1YnNvcnUvUjd6RlFhWi9TSkFZV1hsZUlZ?=
 =?utf-8?B?VmJvYlM3WVlxSzdrNERaemFXcFdOL2tGcWZtM1NYaDBjb0tsMUFjcTZINW1F?=
 =?utf-8?B?bmFsN3o2NEM5S2ZoS3hMemlyU2hQamdNU05KV25xMS9IbHh4VlZrWFJuS1Z0?=
 =?utf-8?B?c0xYVzJOaTFXWVBXdzJtV3pxS3NGZ1d2SVZIL2liVkQyUE5oa1I3cDlKZEZt?=
 =?utf-8?B?MXcxQUJsSnRCTWxxdjBCVlBDd21udEpibjVRLzJpOTZRMlI4SU4vVHRveExh?=
 =?utf-8?B?bDBGYjNRS2sySy9OYTNMa200VnIvY2tkMkIrTHVIYnBibk9UMFo2YkJISDVk?=
 =?utf-8?B?TTNuaUVmTzlMZnV0Q0tSVUg1QWx3STJzcU5TOWFDN0NvM1ZNV0tCUHRnNFll?=
 =?utf-8?B?a081MFpOekhVMVMzSUVTWFFqOE5PeWgza0dRSWEyeEEwZzBQSXNuVGdOVVdF?=
 =?utf-8?B?dDV6YlMwUUFTeGJmdDdmb29heEtiUmwzWHpqdXBGbWdTc2JGSzZrSCt1V1FN?=
 =?utf-8?B?Zkh5T25VOXpYa1F0eGdySkVwTXQrSXRsR2x2ajdGYStXTThVRWczWVVYYmdp?=
 =?utf-8?B?V3Y2QWd4bHNWQmRVRlhydnRXY0J4RHdCQlJ3d2FUSXJaZlFXL0JYeDlxeGtx?=
 =?utf-8?B?Z3dpRzMwU1hxNjZZT0VzZndrUlRxVWhXandzVGhmRWMrZ252UmZiMXlOaTY2?=
 =?utf-8?B?Uml2YzV2V2lXeFlaM3VNYzR5amR3b1FCbEVqTWM3M2pmdEdMU2lYVUlZcEtD?=
 =?utf-8?B?ZmFrQWV6bFVyMW80Z2JmR1ZOQi9tbVpvMlU3TnVKSUJBVDZjWERLd0R0WU1k?=
 =?utf-8?B?dXlCOStwdHc0aVJPMm9VRjhqd3lpMU9EZFNoRnc5OFlDK1c2UytSL0dJdEQ4?=
 =?utf-8?B?YlNnazJlcWlXNmtGTFh6cnp3RmNZOXRmU0VMam5CQjZDVFZDK1JqMTJOYUZn?=
 =?utf-8?B?MFcyeUNyaksrYlNVU3pjSXpoYzBnSld2NXVueUxCOEtlbTkxNkxkNEZHOXN0?=
 =?utf-8?B?NmRReFhjdzJrbDNSaGt0dWg5VGhhVGIrZ2xHdkdPVVJ2cUx3MFpMbFNJVE5r?=
 =?utf-8?B?cUI3R2s5WlNrSTM4blJnWFRjNFVwYlRVN3ZHeXA4NHY3QnV0RlBRWVZyYXpN?=
 =?utf-8?B?YUx1Y2MzSlcyNkxWM2ozVUZiQnl0NDZMZS9TakVVRHV2NXgvQlgzQUgxNEJN?=
 =?utf-8?B?a1piTGhuWXp6bGpZMDFpbVdZMkVKU1ZyY0d2b1pMU0tKRk5YN2VjNGZkRTZo?=
 =?utf-8?B?RTh6ZzJlWWdwbXgvRnhjemlYR0JhRldubzkySnlwUjFBVFo0b09SaUF3dE1o?=
 =?utf-8?B?QVdPSmN5cDFHdmtneTJiK3JmbUhwc1ZxTkVsVWU0UmxRZE5jNFhmQXNjc2Jq?=
 =?utf-8?B?cldtbkZ3MnhnbzFSd01BY0RXY1B4dUxrbzlyV1hFK0VxdEtBU1BlSU1sUVA5?=
 =?utf-8?Q?VEfnWAol2TyWtSTIbm4gYCA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f5df8f-db7a-4282-3eb5-08db78a402e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:23:26.1212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE92mHLc4BWHU3QqXr5seUwMJtnV4YULxm4z0tkCNnYj5oATKcHO7sk/W0bRdkDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------seaP21PnmrAly652UBpmSPo8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>
> Does this read well.
>
> drm/amdkfd: Access gpuvm_export_dmabuf() API to get Dmabuf
>
> Directly invoking the function amdgpu_gem_prime_export() from within
>
> KFD is not correct. By utilizing the KFD API to obtain Dmabuf, the
>
> implementation can prevent the creation of multiple instances of
>
> struct dma_buf.
>
> Regards,
>
> Ramesh
>
Looks good.

With the new commit message, patch is

Reviewed-by: David Francis<David.Francis@amd.com>

> On 2023-06-22 17:10, Ramesh Errabolu wrote:
>
>     Call KFD api to get Dmabuf instead of calling GEM Prime API
>
> Would appreciate a more detailed commit message to explain why the
> KFD API is preferred over the GEM API.
> With or without that change, this is
> Reviewed-by: David Francis<David.Francis@amd.com>  <mailto:David.Francis@amd.com>
>
>     Signed-off-by: Ramesh Errabolu<Ramesh.Errabolu@amd.com>  <mailto:Ramesh.Errabolu@amd.com>
>
>     ---
>
>       drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++------
>
>       1 file changed, 5 insertions(+), 6 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>
>     index cf1db0ab3471..40ac093b5035 100644
>
>     --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>
>     +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>
>     @@ -1852,15 +1852,14 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
>
>              return num_of_bos;
>
>       }
>
>     -static int criu_get_prime_handle(struct drm_gem_object *gobj, int flags,
>
>     +static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
>
>                                            u32 *shared_fd)
>
>       {
>
>              struct dma_buf *dmabuf;
>
>              int ret;
>
>     -       dmabuf = amdgpu_gem_prime_export(gobj, flags);
>
>     -       if (IS_ERR(dmabuf)) {
>
>     -               ret = PTR_ERR(dmabuf);
>
>     +       ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
>
>     +       if (ret) {
>
>                      pr_err("dmabuf export failed for the BO\n");
>
>                      return ret;
>
>              }
>
>     @@ -1940,7 +1939,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>
>                              }
>
>                              if (bo_bucket->alloc_flags
>
>                                  & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
>
>     -                               ret = criu_get_prime_handle(&dumper_bo->tbo.base,
>
>     +                               ret = criu_get_prime_handle(kgd_mem,
>
>                                                      bo_bucket->alloc_flags &
>
>                                                      KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
>
>                                                      &bo_bucket->dmabuf_fd);
>
>     @@ -2402,7 +2401,7 @@ static int criu_restore_bo(struct kfd_process *p,
>
>              /* create the dmabuf object and export the bo */
>
>              if (bo_bucket->alloc_flags
>
>                  & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
>
>     -               ret = criu_get_prime_handle(&kgd_mem->bo->tbo.base, DRM_RDWR,
>
>     +               ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
>
>                                                  &bo_bucket->dmabuf_fd);
>
>                      if (ret)
>
>                              return ret;
>
>     --
>
>     2.25.1
>
--------------seaP21PnmrAly652UBpmSPo8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:SN1PR12MB2575BD1009EC55A184222D8DE324A@SN1PR12MB2575.namprd12.prod.outlook.com"><br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-family:&quot;Courier
              New&quot;">Does this read well.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Courier
              New&quot;"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal" style="margin-left:.5in"><span style="font-family:&quot;Courier New&quot;">drm/amdkfd:
              Access gpuvm_export_dmabuf() API to get Dmabuf<o:p></o:p></span></p>
          <p class="MsoNormal" style="margin-left:.5in"><span style="font-family:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal" style="margin-left:.5in"><span style="font-family:&quot;Courier New&quot;">Directly
              invoking the function amdgpu_gem_prime_export() from
              within<o:p></o:p></span></p>
          <p class="MsoNormal" style="margin-left:.5in"><span style="font-family:&quot;Courier New&quot;">KFD is not
              correct. By utilizing the KFD API to obtain Dmabuf, the<o:p></o:p></span></p>
          <p class="MsoNormal" style="margin-left:.5in"><span style="font-family:&quot;Courier New&quot;">implementation
              can prevent the creation of multiple instances of<o:p></o:p></span></p>
          <p class="MsoNormal" style="margin-left:.5in"><span style="font-family:&quot;Courier New&quot;">struct
              dma_buf.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Courier
              New&quot;"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Courier
              New&quot;">Regards,<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Courier
              New&quot;">Ramesh<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-family:&quot;Courier
              New&quot;"><o:p>&nbsp;</o:p></span></p>
        </div>
      </div>
    </blockquote>
    <pre>Looks good.

With the new commit message, patch is

Reviewed-by: David Francis <a class="moz-txt-link-rfc2396E" href="mailto:David.Francis@amd.com">&lt;David.Francis@amd.com&gt;</a>
</pre>
    <blockquote type="cite" cite="mid:SN1PR12MB2575BD1009EC55A184222D8DE324A@SN1PR12MB2575.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1"><o:p>&nbsp;</o:p>
          <pre>On 2023-06-22 17:10, Ramesh Errabolu wrote:<o:p></o:p></pre>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Call KFD api to get Dmabuf instead of calling GEM Prime API<o:p></o:p></pre>
          </blockquote>
          <pre>Would appreciate a more detailed commit message to explain why the<o:p></o:p></pre>
          <pre>KFD API is preferred over the GEM API.<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>With or without that change, this is<o:p></o:p></pre>
          <pre><o:p>&nbsp;</o:p></pre>
          <pre>Reviewed-by: David Francis <a href="mailto:David.Francis@amd.com" moz-do-not-send="true">&lt;David.Francis@amd.com&gt;</a><o:p></o:p></pre>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>Signed-off-by: Ramesh Errabolu <a href="mailto:Ramesh.Errabolu@amd.com" moz-do-not-send="true">&lt;Ramesh.Errabolu@amd.com&gt;</a><o:p></o:p></pre>
            <pre>---<o:p></o:p></pre>
            <pre> drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++------<o:p></o:p></pre>
            <pre> 1 file changed, 5 insertions(+), 6 deletions(-)<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<o:p></o:p></pre>
            <pre>index cf1db0ab3471..40ac093b5035 100644<o:p></o:p></pre>
            <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<o:p></o:p></pre>
            <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<o:p></o:p></pre>
            <pre>@@ -1852,15 +1852,14 @@ static uint32_t get_process_num_bos(struct kfd_process *p)<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return num_of_bos;<o:p></o:p></pre>
            <pre> }<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>-static int criu_get_prime_handle(struct drm_gem_object *gobj, int flags,<o:p></o:p></pre>
            <pre>+static int criu_get_prime_handle(struct kgd_mem *mem, int flags,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *shared_fd)<o:p></o:p></pre>
            <pre> {<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf *dmabuf;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmabuf = amdgpu_gem_prime_export(gobj, flags);<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(dmabuf)) {<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = PTR_ERR(dmabuf);<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &amp;dmabuf);<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;dmabuf export failed for the BO\n&quot;);<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
            <pre>@@ -1940,7 +1939,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_bucket-&gt;alloc_flags<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = criu_get_prime_handle(&amp;dumper_bo-&gt;tbo.base,<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = criu_get_prime_handle(kgd_mem,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_bucket-&gt;alloc_flags &amp;<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;bo_bucket-&gt;dmabuf_fd);<o:p></o:p></pre>
            <pre>@@ -2402,7 +2401,7 @@ static int criu_restore_bo(struct kfd_process *p,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* create the dmabuf object and export the bo */<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_bucket-&gt;alloc_flags<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {<o:p></o:p></pre>
            <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = criu_get_prime_handle(&amp;kgd_mem-&gt;bo-&gt;tbo.base, DRM_RDWR,<o:p></o:p></pre>
            <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;bo_bucket-&gt;dmabuf_fd);<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></pre>
            <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></pre>
            <pre>--<o:p></o:p></pre>
            <pre>2.25.1<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------seaP21PnmrAly652UBpmSPo8--
