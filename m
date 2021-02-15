Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20203C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 10:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C2764E36
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 10:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C2764E36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB4989F4F;
	Mon, 15 Feb 2021 10:43:23 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680044.outbound.protection.outlook.com [40.107.68.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676A389F4F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 10:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2fJpu1omwMTqPTtQtEC0AlQCEgUk0VQumWnjzfky4k+BhN5YnBAon4hav1PzPmpkywfywAc0uUvHJJdZMUDQvj2KofcaX6rf2iNYfFz2VMoYHfeISh66Z05v3O5XUV7EiP1eS9VcN0WwJza1wHJZrvdSSle5yRzYD/mE61lGVYA6i/MVfZ2W0ns5eLsdu1eP341I7atUBA35TEH+aLGAGu5PhBEzXvRqw9+N0OAO4w+iOIIwrNgux2DcbmdX872dFcEXMegUiBU80l3kt3GcCEZrjAF2Df/AXPdoGYtQAaKnGKx+nOur6u/39h1XN5UqI/mh+FfF8d5irMlUDNvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8BH5zpkunl2OKVbmRA7lvCPMAuWuOqMbIWgY/nRkuM=;
 b=U/PBEwHqMGqCpDVP0FuExPNHYMIb9W8KxPHk4UPRvd2lI+oABYFTaW+rzibVdCpqZ5f6OozzMguYtsc+mtGA3jysO/N5kIwvfqVGyUh9r/tEji5YY84vSdHhT/tLJwWjR7SIVAk66CW1ssfMxZ2FTt+vWq//qvaHwYW187Egq85Mzvp7XCCwDLbeTplAQRRr/72bGZmvNyvLwMwNRr9j0S3lNcQKlSZThrmDsM3IppiuZh6/1wyEBTYUCb8xVjzyjCv2SRkCEMR+n3qdNXXDbOlOGAcdMbqAjW2PPpaW5zk8GuSSvTdn4j+cc5QdThJ1xuETR3/EKGPiGqgvbMVGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8BH5zpkunl2OKVbmRA7lvCPMAuWuOqMbIWgY/nRkuM=;
 b=Q4DV23NiCoRQCOCkpLszNNX/UdJ4r1OlnszVcUw2+Hxz2eBPzGVIMqaMnOLr0B7Ii+avtqXmxVwkjKBIE56UZ50ycOm6Ct4o/MJrfbf9J4h0/B/AO6bmAyKDb5VONMw4BL0uvsZ3gVR9+t7OPHCF+EfTafKiWmMZ4HJoqOMFW7Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Mon, 15 Feb
 2021 10:43:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3846.038; Mon, 15 Feb 2021
 10:43:16 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: do not use drm middle layer for debugfs
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210215101653.35694-1-nirmoy.das@amd.com>
 <20210215101653.35694-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <57585256-9f83-499a-f9e0-13c50de0d24d@amd.com>
Date: Mon, 15 Feb 2021 11:43:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210215101653.35694-3-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e074:3b37:7224:b69f]
X-ClientProxiedBy: AM3PR05CA0132.eurprd05.prod.outlook.com
 (2603:10a6:207:2::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e074:3b37:7224:b69f]
 (2a02:908:1252:fb60:e074:3b37:7224:b69f) by
 AM3PR05CA0132.eurprd05.prod.outlook.com (2603:10a6:207:2::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Mon, 15 Feb 2021 10:43:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37a3e37c-0c7d-44c2-fc18-08d8d19e8045
X-MS-TrafficTypeDiagnostic: MN2PR12MB4111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4111B51DCE464301D0CB4F1883889@MN2PR12MB4111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74ZDL4A0MhZtqenAtaZrstN3Flumi47hz9pfOL4nLlOvyVZcmxCweH6RDJ/5E7IH5KYWd2y9UJFRUSCI3s0BbS9ziQjONKZzXCpSzYR/2R4l6Wbj0K7+RBnACt5MNfFmMaEfzoIn3KCYKxT4WLxB0Aa30qboWYQYDndYi+07sd+bK5ecK6IZTBnn1aPyDLvBk7AAGhgYy9hGWcyb37mblmgHCcDvxgoR5dJwcEHjh4MxEF+z6LyFls2MAep1+0r9hS8dsy/9sUhGk/YbjfpogON0B84+y9YqVAoUzEMhl8cPT/v7mkubbVJaqb8BMoOvxBBnu1W8fw9OQYIL/ggCBQ79o/nWTSHAlcdIMu+Wnr7HEGTCHHsV146Y0o2vkMirCXGjMc6UeXumWEe0LYV2GQLPU4dCp9JrhdKmcic+WDHeDDpplVA75hL45AbRceV+DgaTVjCcZsRdkcdCTUz8B9qk0ezyUfl+ZNO/3jqjvTirQWMcOPx41n0aAdWBBvO2TAvrLut2ugOV6AIXZyBKaaKAR1j0Mvtue2z7+t4C+s/nfxD+SHi03SHjy3acS9e6L5DpRHalc07t7A47Ffu70NkTC+2IuwJqZH7OzZjRlzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(6636002)(30864003)(52116002)(478600001)(4326008)(86362001)(316002)(2616005)(5660300002)(2906002)(8936002)(31696002)(6486002)(8676002)(6666004)(37006003)(36756003)(66556008)(66476007)(31686004)(66946007)(83380400001)(186003)(16526019)(6862004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VlZ6dTlqLzBlTVYrSXRJUGthc1JPS2pQb2dkM25aWVFOUG9Od2FmSlhJM01D?=
 =?utf-8?B?TDRrQk5sazFqaGk5bWEyUktKcnpoWUxVbnUwWFNKUjhUTDFCZk1IY1VPYTI2?=
 =?utf-8?B?bG9TTy9NU25ET29jSWtEWWEyQXdhSmhwb2ZpbzE4TVdEdGZRRzcwMnZRTGxK?=
 =?utf-8?B?NzNLQ201R01jak5xczJwWXZ3clJjSllaRUhtTXpZV2Yydnpuc3NCVWVzaVR2?=
 =?utf-8?B?bHR4TVZidzlVQkdDQ0ZGL2hOZW42Z215dytaYjhKcjZNR25pcnNlK0tHLzJK?=
 =?utf-8?B?TUtGOHZBVE53TEQ2dHpKL0h0WUhMWk9GZ2NIRHFQb0tBckxIT0FlbXFWYldP?=
 =?utf-8?B?aisvRGFHQlhuTWdVSklsMmhaNmJ5SnMxeDRVNmNNbGxBczZ5WG8wcnE0RU5x?=
 =?utf-8?B?ckVPL1JndVA1c0ZqRGUvdTBpcUxGQ3hTN0NGTVA3U1IyUGI3WDVPczlLWE5B?=
 =?utf-8?B?eURjZlFuU3A0ZXFQMkdPaXZ6ZmhleVBqTGhsU1NMTjhrQ0JiSm1ITWdUQStT?=
 =?utf-8?B?UVN5UWlQeUtyRS9xcTdIZkdKZzluY3NpSDVCUkdLLy9pUDhiWDZOY1FHNnhI?=
 =?utf-8?B?MnBvUzhNWklBSzlQbWQ4dzJKVi9JeFdkZEtmYW1zcGkyY3Q4VERxYzIvKzNX?=
 =?utf-8?B?Y3UyUWo4VGg1SWtlblpybldGUWk1cUx3L3dFUkhBV3VoTkZoSEpMNHdVZFhC?=
 =?utf-8?B?MDkvTWZSTXBHeUdoOEhTdm1BWmRUUFY5eEo4a2NCTHI3bnVpaHNuLzlMa1px?=
 =?utf-8?B?MFYraExtK1lYUVg3THg4ZDhqYUcxSk40em9iaHZMUUVXUllxSGdvOERWOUJm?=
 =?utf-8?B?aUVsQWJSU3M4U3VJTmo2c2h0NXpvbGs2amZ4L2F4bUtsdnpHWi96MlN3YUJS?=
 =?utf-8?B?Qlo5ODU2aXZMSitFR2lieFFZeGJhOWwvODhJVnBPSGhOTkFEQldKQWovQjlW?=
 =?utf-8?B?WFhkSURJQUF1VE4wNy8yaW1xbmRRK1NTakdKamVYeXc0Y2ZwQ0pYOTdUNFBJ?=
 =?utf-8?B?a1kyanNKVkhMNUFPSUVDWWQyTUg4cDRXWXVSZU1ONkkzZlBPQm9DOFZFcmdR?=
 =?utf-8?B?VnlwL2RwU1lmeG05NW9PMXZTSTF3Tmk3alFTVHJiVFRnODllODk4eVBHNHBa?=
 =?utf-8?B?d1c5WTdJaGpPdEgvMFhyRWNkZUNPWmFscnA1NW1zeUt6c3FpVjZkaE9rUEVS?=
 =?utf-8?B?c1dvRUN3b20zNW8xaUZVY2EvOU9wcHJpM0ExeGVhTDVaRk1FWUxablFSN04r?=
 =?utf-8?B?Ryt5R2xKYzh2RGxveWo3T0hxSjZtNjRoREpVdTBUVmVZZGVYMTBqZ3VBQmhS?=
 =?utf-8?B?NzhsK0lVSWRDSW1hRDY3eVJ3bUNpZzFjNFRIQytlNVp0U0MweElWQzA3M0NX?=
 =?utf-8?B?bTBaMVozQmo3d3E3YWZ1bG9xdWtCeE9pbENBWVF5ZnVVT0dITFBKUnlES3hs?=
 =?utf-8?B?ekhtajUxNVRycGpydDNzSnVJRVBGNnhLaVROQUg5eFFBRHFvQTZ5ZmZPMTlN?=
 =?utf-8?B?TUdQVkR2VzdZdE1PTTdmS2ppTm90cHcwSEQ5Y2xOc1NvNEl6UkdkdVg2d1RD?=
 =?utf-8?B?aXFaTDEwQU5JcmV0TVRzTEJSb1pXZVN5RFIrNVdYbWl4bjlLczlRTW1RZWNz?=
 =?utf-8?B?SngxdzROM2hSM2k4bzE0M052U1M0dFYzK0R6OGRXd2dWMVBFd3FvRWNoZkxT?=
 =?utf-8?B?Rk1ZWmRvWkVwdy9RTDg5UHdINkhYNldLOWU3VDlFaXFYcUtwajRzRmxJU3BI?=
 =?utf-8?B?Y2xUMFgzZWZCNk50cG9KSnY4azkxWmRCbTZqY1VoY25SdGJ2dHNVUjdKTEF1?=
 =?utf-8?B?VC82UGhoUW5xM1M2VHpkeTAraE4zaXZGWGIvd0NjeWVIMXMwR3hJMm9UY0Ir?=
 =?utf-8?Q?qJpRwWXz/runH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a3e37c-0c7d-44c2-fc18-08d8d19e8045
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 10:43:16.3900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6ancCPU7Zgu7JowKdO0imFqJr0kzRHxRcvZdjCY+ktcf80M+m5Prb9GB2XYDY6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 15.02.21 um 11:16 schrieb Nirmoy Das:
> Use debugfs API directly instead of drm middle layer.
>
> This also includes following debugfs file output changes:
> 1 amdgpu_evict_vram/amdgpu_evict_gtt output will not contain any braces.
>    e.g. (0) --> 0
> 2 amdgpu_gpu_recover output will print return value of
>    amdgpu_device_gpu_recover() instead of not so important "gpu recover"
>    message.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 157 +++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  47 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  23 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  24 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  25 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 127 ++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   2 +-
>   9 files changed, 209 insertions(+), 204 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 719ae65ad633..827a4fd15f85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -28,7 +28,6 @@
>   #include <linux/uaccess.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/poll.h>
> -#include <drm/drm_debugfs.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
> @@ -38,45 +37,6 @@
>   #include "amdgpu_securedisplay.h"
>   #include "amdgpu_fw_attestation.h"
>   
> -/**
> - * amdgpu_debugfs_add_files - Add simple debugfs entries
> - *
> - * @adev:  Device to attach debugfs entries to
> - * @files:  Array of function callbacks that respond to reads
> - * @nfiles: Number of callbacks to register
> - *
> - */
> -int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
> -			     const struct drm_info_list *files,
> -			     unsigned nfiles)
> -{
> -	unsigned i;
> -
> -	for (i = 0; i < adev->debugfs_count; i++) {
> -		if (adev->debugfs[i].files == files) {
> -			/* Already registered */
> -			return 0;
> -		}
> -	}
> -
> -	i = adev->debugfs_count + 1;
> -	if (i > AMDGPU_DEBUGFS_MAX_COMPONENTS) {
> -		DRM_ERROR("Reached maximum number of debugfs components.\n");
> -		DRM_ERROR("Report so we increase "
> -			  "AMDGPU_DEBUGFS_MAX_COMPONENTS.\n");
> -		return -EINVAL;
> -	}
> -	adev->debugfs[adev->debugfs_count].files = files;
> -	adev->debugfs[adev->debugfs_count].num_files = nfiles;
> -	adev->debugfs_count = i;
> -#if defined(CONFIG_DEBUG_FS)
> -	drm_debugfs_create_files(files, nfiles,
> -				 adev_to_drm(adev)->primary->debugfs_root,
> -				 adev_to_drm(adev)->primary);
> -#endif
> -	return 0;
> -}
> -
>   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> @@ -1233,16 +1193,15 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
> +static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>   {
> -	struct drm_info_node *node = (struct drm_info_node *) m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct drm_device *dev = adev_to_drm(adev);
>   	int r = 0, i;
>   
>   	r = pm_runtime_get_sync(dev->dev);
>   	if (r < 0) {
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		pm_runtime_put_autosuspend(dev->dev);
>   		return r;
>   	}
>   
> @@ -1284,30 +1243,19 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> -static int amdgpu_debugfs_get_vbios_dump(struct seq_file *m, void *data)
> -{
> -	struct drm_info_node *node = (struct drm_info_node *) m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> -
> -	seq_write(m, adev->bios, adev->bios_size);
> -	return 0;
> -}
> -
> -static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
> +static int evict_vram_get(void *data, u64 *val)

Please keep the function name unchanged.

>   {
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
> +	struct drm_device *dev = adev_to_drm(adev);
>   	int r;
>   
>   	r = pm_runtime_get_sync(dev->dev);
>   	if (r < 0) {
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		pm_runtime_put_autosuspend(dev->dev);
>   		return r;
>   	}
>   
> -	seq_printf(m, "(%d)\n", amdgpu_bo_evict_vram(adev));
> +	*val = amdgpu_bo_evict_vram(adev);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> @@ -1315,11 +1263,11 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> -static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
> +
> +static int evict_gtt_get(void *data, u64 *val)

Same here.

>   {
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
> +	struct drm_device *dev = adev_to_drm(adev);
>   	int r;
>   
>   	r = pm_runtime_get_sync(dev->dev);
> @@ -1328,7 +1276,7 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
>   		return r;
>   	}
>   
> -	seq_printf(m, "(%d)\n", ttm_bo_evict_mm(&adev->mman.bdev, TTM_PL_TT));
> +	*val = ttm_bo_evict_mm(&adev->mman.bdev, TTM_PL_TT);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> @@ -1336,10 +1284,11 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> -static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
> +
> +static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>   {
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct drm_device *dev = adev_to_drm(adev);
>   	struct drm_file *file;
>   	int r;
>   
> @@ -1365,13 +1314,10 @@ static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
>   	return r;
>   }
>   
> -static const struct drm_info_list amdgpu_debugfs_list[] = {
> -	{"amdgpu_vbios", amdgpu_debugfs_get_vbios_dump},
> -	{"amdgpu_test_ib", &amdgpu_debugfs_test_ib},
> -	{"amdgpu_evict_vram", &amdgpu_debugfs_evict_vram},
> -	{"amdgpu_evict_gtt", &amdgpu_debugfs_evict_gtt},
> -	{"amdgpu_vm_info", &amdgpu_debugfs_vm_info},
> -};
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_test_ib);
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_vm_info);
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_evict_vram_fops, evict_vram_get, NULL, "%lld\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_evict_gtt_fops, evict_gtt_get, NULL, "%lld\n");
>   
>   static void amdgpu_ib_preempt_fences_swap(struct amdgpu_ring *ring,
>   					  struct dma_fence **fences)
> @@ -1592,17 +1538,19 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *ent;
>   	int r, i;
> +	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> +	struct debugfs_blob_wrapper *vbios;

Variable like "r, i" and "ent" declared last please.

> +
> +
>   
> -	ent = debugfs_create_file("amdgpu_preempt_ib", 0600,
> -				  adev_to_drm(adev)->primary->debugfs_root, adev,
> +	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
>   	if (!ent) {
>   		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
>   		return -EIO;
>   	}
>   
> -	ent = debugfs_create_file("amdgpu_force_sclk", 0200,
> -				  adev_to_drm(adev)->primary->debugfs_root, adev,
> +	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
>   				  &fops_sclk_set);
>   	if (!ent) {
>   		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
> @@ -1610,32 +1558,17 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	}
>   
>   	/* Register debugfs entries for amdgpu_ttm */
> -	r = amdgpu_ttm_debugfs_init(adev);
> -	if (r) {
> -		DRM_ERROR("Failed to init debugfs\n");
> -		return r;
> -	}
> -
> +	amdgpu_ttm_debugfs_init(adev);
>   	amdgpu_debugfs_pm_init(adev);
> -
> -	if (amdgpu_debugfs_sa_init(adev)) {
> -		dev_err(adev->dev, "failed to register debugfs file for SA\n");
> -	}
> -
> -	if (amdgpu_debugfs_fence_init(adev))
> -		dev_err(adev->dev, "fence debugfs file creation failed\n");
> -
> -	r = amdgpu_debugfs_gem_init(adev);
> -	if (r)
> -		DRM_ERROR("registering gem debugfs failed (%d).\n", r);
> +	amdgpu_debugfs_sa_init(adev);
> +	amdgpu_debugfs_fence_init(adev);
> +	amdgpu_debugfs_gem_init(adev);
>   
>   	r = amdgpu_debugfs_regs_init(adev);
>   	if (r)
>   		DRM_ERROR("registering register debugfs failed (%d).\n", r);
>   
> -	r = amdgpu_debugfs_firmware_init(adev);
> -	if (r)
> -		DRM_ERROR("registering firmware debugfs failed (%d).\n", r);
> +	amdgpu_debugfs_firmware_init(adev);
>   
>   #if defined(CONFIG_DRM_AMD_DC)
>   	if (amdgpu_device_has_dc_support(adev))
> @@ -1654,17 +1587,29 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	}
>   
>   	amdgpu_ras_debugfs_create_all(adev);
> -
>   	amdgpu_debugfs_autodump_init(adev);
> -
>   	amdgpu_rap_debugfs_init(adev);
> -
>   	amdgpu_securedisplay_debugfs_init(adev);
> -
>   	amdgpu_fw_attestation_debugfs_init(adev);
>   
> -	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
> -					ARRAY_SIZE(amdgpu_debugfs_list));
> +	debugfs_create_file("amdgpu_evict_vram", S_IFREG | S_IRUGO, root, adev,
> +			    &amdgpu_evict_vram_fops);
> +	debugfs_create_file("amdgpu_evict_gtt", S_IFREG | S_IRUGO, root, adev,
> +			    &amdgpu_evict_gtt_fops);
> +	debugfs_create_file("amdgpu_test_ib", S_IFREG | S_IRUGO, root, adev,
> +			    &amdgpu_debugfs_test_ib_fops);
> +	debugfs_create_file("amdgpu_vm_info", S_IFREG | S_IRUGO, root, adev,
> +			    &amdgpu_debugfs_vm_info_fops);
> +
> +	vbios = devm_kzalloc(adev_to_drm(adev)->dev, sizeof(*vbios), GFP_KERNEL);
> +	if (!vbios)
> +		return -ENOMEM;
> +
> +	vbios->data = adev->bios;
> +	vbios->size = adev->bios_size;
> +	debugfs_create_blob("amdgpu_vbios", S_IFREG | S_IRUGO, root, vbios);

Is that vbios allocation ever freed? Maybe just change adev->bios and 
adev->bios_dize into a debugfs_blob_wrapper structure.

Or at least keep the debugfs_blob_wrapper structure inside adev.

> +
> +	return 0;
>   }
>   
>   #else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index 2803884d338d..0ed866da865e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -42,7 +42,7 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>   int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>   			     const struct drm_info_list *files,
>   			     unsigned nfiles);
> -int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
> -int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
> -int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d56f4023ebb3..7809c4db5a3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -36,8 +36,6 @@
>   #include <linux/firmware.h>
>   #include <linux/pm_runtime.h>
>   
> -#include <drm/drm_debugfs.h>
> -
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   
> @@ -697,11 +695,9 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>    * Fence debugfs
>    */
>   #if defined(CONFIG_DEBUG_FS)
> -static int amdgpu_debugfs_fence_info(struct seq_file *m, void *data)
> +static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
>   {
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
>   	int i;
>   
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> @@ -746,11 +742,10 @@ static int amdgpu_debugfs_fence_info(struct seq_file *m, void *data)
>    *
>    * Manually trigger a gpu reset at the next fence wait.
>    */
> -static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
> +static int gpu_recover_get(void *data, u64 *val)
>   {
> -	struct drm_info_node *node = (struct drm_info_node *) m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
> +	struct drm_device *dev = adev_to_drm(adev);
>   	int r;
>   
>   	r = pm_runtime_get_sync(dev->dev);
> @@ -759,8 +754,7 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
>   		return 0;
>   	}
>   
> -	seq_printf(m, "gpu recover\n");
> -	amdgpu_device_gpu_recover(adev, NULL);
> +	*val = amdgpu_device_gpu_recover(adev, NULL);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> @@ -768,26 +762,25 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> -static const struct drm_info_list amdgpu_debugfs_fence_list[] = {
> -	{"amdgpu_fence_info", &amdgpu_debugfs_fence_info, 0, NULL},
> -	{"amdgpu_gpu_recover", &amdgpu_debugfs_gpu_recover, 0, NULL}
> -};
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
> +			 "%lld\n");
>   
> -static const struct drm_info_list amdgpu_debugfs_fence_list_sriov[] = {
> -	{"amdgpu_fence_info", &amdgpu_debugfs_fence_info, 0, NULL},
> -};
>   #endif
>   
> -int amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
> +void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -	if (amdgpu_sriov_vf(adev))
> -		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov,
> -						ARRAY_SIZE(amdgpu_debugfs_fence_list_sriov));
> -	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
> -					ARRAY_SIZE(amdgpu_debugfs_fence_list));
> -#else
> -	return 0;
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +	umode_t mode = S_IFREG | S_IRUGO;

Why the mode as separate variable here? I would keep that close to each 
function call. Same for other places of course.

Apart from that this looks like a really nice cleanup to me.

Regards,
Christian.

> +	struct dentry *root = minor->debugfs_root;
> +
> +	debugfs_create_file("amdgpu_fence_info", mode, root, adev,
> +			    &amdgpu_debugfs_fence_info_fops);
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		debugfs_create_file("amdgpu_gpu_recover", mode, root, adev,
> +				    &amdgpu_debugfs_gpu_recover_fops);
>   #endif
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 5b50860eece4..c2e77ab3331a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -32,7 +32,6 @@
>   #include <linux/dma-buf.h>
>   
>   #include <drm/amdgpu_drm.h>
> -#include <drm/drm_debugfs.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_display.h"
> @@ -836,10 +835,10 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>   }
>   
>   #if defined(CONFIG_DEBUG_FS)
> -static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
> +static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
>   {
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct drm_device *dev = adev_to_drm(adev);
>   	struct drm_file *file;
>   	int r;
>   
> @@ -877,16 +876,18 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> -static const struct drm_info_list amdgpu_debugfs_gem_list[] = {
> -	{"amdgpu_gem_info", &amdgpu_debugfs_gem_info, 0, NULL},
> -};
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_gem_info);
> +
>   #endif
>   
> -int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
> +void amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
> -					ARRAY_SIZE(amdgpu_debugfs_gem_list));
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +	umode_t mode = S_IFREG | S_IRUGO;
> +	struct dentry *root = minor->debugfs_root;
> +
> +	debugfs_create_file("amdgpu_gem_info", mode, root, adev,
> +			    &amdgpu_debugfs_gem_info_fops);
>   #endif
> -	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 7645223ea0ef..3155e4b61d9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -30,7 +30,6 @@
>   #include <linux/slab.h>
>   
>   #include <drm/amdgpu_drm.h>
> -#include <drm/drm_debugfs.h>
>   
>   #include "amdgpu.h"
>   #include "atom.h"
> @@ -453,11 +452,9 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
>    */
>   #if defined(CONFIG_DEBUG_FS)
>   
> -static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
> +static int amdgpu_debugfs_sa_info_show(struct seq_file *m, void *unused)
>   {
> -	struct drm_info_node *node = (struct drm_info_node *) m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
>   
>   	seq_printf(m, "--------------------- DELAYED --------------------- \n");
>   	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DELAYED],
> @@ -471,18 +468,19 @@ static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> -static const struct drm_info_list amdgpu_debugfs_sa_list[] = {
> -	{"amdgpu_sa_info", &amdgpu_debugfs_sa_info, 0, NULL},
> -};
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_sa_info);
>   
>   #endif
>   
> -int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
> +void amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
> -					ARRAY_SIZE(amdgpu_debugfs_sa_list));
> -#else
> -	return 0;
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +	umode_t mode = S_IFREG | S_IRUGO;
> +	struct dentry *root = minor->debugfs_root;
> +
> +	debugfs_create_file("amdgpu_sa_info", mode, root, adev,
> +			    &amdgpu_debugfs_sa_info_fops);
> +
>   #endif
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index e365c4fdcfe3..3ab0a0b48675 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -27,7 +27,6 @@
>    */
>   
>   #include "amdgpu.h"
> -#include <drm/drm_debugfs.h>
>   #include <drm/amdgpu_drm.h>
>   #include "amdgpu_sched.h"
>   #include "amdgpu_uvd.h"
> @@ -1287,11 +1286,9 @@ const int amdgpu_max_kms_ioctl = ARRAY_SIZE(amdgpu_ioctls_kms);
>    */
>   #if defined(CONFIG_DEBUG_FS)
>   
> -static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
> +static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>   {
> -	struct drm_info_node *node = (struct drm_info_node *) m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
>   	struct drm_amdgpu_info_firmware fw_info;
>   	struct drm_amdgpu_query_fw query_fw;
>   	struct atom_context *ctx = adev->mode_info.atom_context;
> @@ -1497,17 +1494,19 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> -static const struct drm_info_list amdgpu_firmware_info_list[] = {
> -	{"amdgpu_firmware_info", amdgpu_debugfs_firmware_info, 0, NULL},
> -};
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_firmware_info);
> +
>   #endif
>   
> -int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev)
> +void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -	return amdgpu_debugfs_add_files(adev, amdgpu_firmware_info_list,
> -					ARRAY_SIZE(amdgpu_firmware_info_list));
> -#else
> -	return 0;
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +	umode_t mode = S_IFREG | S_IRUGO;
> +	struct dentry *root = minor->debugfs_root;
> +
> +	debugfs_create_file("amdgpu_firmware_info", mode, root, adev,
> +			    &amdgpu_debugfs_firmware_info_fops);
> +
>   #endif
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index adbefd6a655d..192627d35bae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -331,7 +331,7 @@ void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
>   					 struct seq_file *m);
>   u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
>   #endif
> -int amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
> +void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
>   
>   bool amdgpu_bo_support_uswc(u64 bo_flags);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index ce92768cd146..3006a720b6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -49,7 +49,6 @@
>   #include <drm/ttm/ttm_module.h>
>   #include <drm/ttm/ttm_page_alloc.h>
>   
> -#include <drm/drm_debugfs.h>
>   #include <drm/amdgpu_drm.h>
>   
>   #include "amdgpu.h"
> @@ -2253,30 +2252,66 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   
>   #if defined(CONFIG_DEBUG_FS)
>   
> -static int amdgpu_mm_dump_table(struct seq_file *m, void *data)
> +static int amdgpu_mm_vram_table_show(struct seq_file *m, void *unused)
>   {
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	unsigned ttm_pl = (uintptr_t)node->info_ent->data;
> -	struct drm_device *dev = node->minor->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> -	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, ttm_pl);
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
> +							    TTM_PL_VRAM);
>   	struct drm_printer p = drm_seq_file_printer(m);
>   
>   	man->func->debug(man, &p);
>   	return 0;
>   }
>   
> -static const struct drm_info_list amdgpu_ttm_debugfs_list[] = {
> -	{"amdgpu_vram_mm", amdgpu_mm_dump_table, 0, (void *)TTM_PL_VRAM},
> -	{"amdgpu_gtt_mm", amdgpu_mm_dump_table, 0, (void *)TTM_PL_TT},
> -	{"amdgpu_gds_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_GDS},
> -	{"amdgpu_gws_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_GWS},
> -	{"amdgpu_oa_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_OA},
> -	{"ttm_page_pool", ttm_page_alloc_debugfs, 0, NULL},
> -#ifdef CONFIG_SWIOTLB
> -	{"ttm_dma_page_pool", ttm_dma_page_alloc_debugfs, 0, NULL}
> -#endif
> -};
> +static int amdgpu_mm_tt_table_show(struct seq_file *m, void *unused)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
> +							    TTM_PL_TT);
> +	struct drm_printer p = drm_seq_file_printer(m);
> +
> +	man->func->debug(man, &p);
> +	return 0;
> +}
> +
> +static int amdgpu_mm_gds_table_show(struct seq_file *m, void *unused)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
> +							    AMDGPU_PL_GDS);
> +	struct drm_printer p = drm_seq_file_printer(m);
> +
> +	man->func->debug(man, &p);
> +	return 0;
> +}
> +
> +static int amdgpu_mm_gws_table_show(struct seq_file *m, void *unused)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
> +							    AMDGPU_PL_GWS);
> +	struct drm_printer p = drm_seq_file_printer(m);
> +
> +	man->func->debug(man, &p);
> +	return 0;
> +}
> +
> +static int amdgpu_mm_oa_table_show(struct seq_file *m, void *unused)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> +	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
> +							    AMDGPU_PL_OA);
> +	struct drm_printer p = drm_seq_file_printer(m);
> +
> +	man->func->debug(man, &p);
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_vram_table);
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_tt_table);
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_gds_table);
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_gws_table);
> +DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_oa_table);
>   
>   /*
>    * amdgpu_ttm_vram_read - Linear read access to VRAM
> @@ -2478,13 +2513,40 @@ static const struct file_operations amdgpu_ttm_iomem_fops = {
>   	.llseek = default_llseek
>   };
>   
> +static int amdgpu_ttm_page_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ttm_page_alloc_debugfs, inode->i_private);
> +}
> +
> +static const struct file_operations amdgpu_ttm_page_debugfs_fops = {
> +	.owner = THIS_MODULE,
> +	.open = amdgpu_ttm_page_debugfs_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +#ifdef CONFIG_SWIOTLB
> +static int amdgpu_ttm_dma_page_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ttm_dma_page_alloc_debugfs, inode->i_private);
> +}
> +
> +
> +static const struct file_operations amdgpu_ttm_dma_page_debugfs_fops = {
> +	.owner = THIS_MODULE,
> +	.open = amdgpu_ttm_dma_page_debugfs_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
>   #endif
>   
> -int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
> +#endif
> +
> +void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
>   {
>   #if defined(CONFIG_DEBUG_FS)
> -	unsigned count;
> -
>   	struct drm_minor *minor = adev_to_drm(adev)->primary;
>   	umode_t mode = S_IFREG | S_IRUGO;
>   	struct dentry *root = minor->debugfs_root;
> @@ -2493,15 +2555,22 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
>   				 &amdgpu_ttm_vram_fops, adev->gmc.mc_vram_size);
>   	debugfs_create_file("amdgpu_iomem", mode, root, adev,
>   			    &amdgpu_ttm_iomem_fops);
> -	count = ARRAY_SIZE(amdgpu_ttm_debugfs_list);
> -
> +	debugfs_create_file("amdgpu_vram_mm", mode, root, adev,
> +			    &amdgpu_mm_vram_table_fops);
> +	debugfs_create_file("amdgpu_gtt_mm", mode, root, adev,
> +			    &amdgpu_mm_tt_table_fops);
> +	debugfs_create_file("amdgpu_gds_mm", mode, root, adev,
> +			    &amdgpu_mm_gds_table_fops);
> +	debugfs_create_file("amdgpu_gws_mm", mode, root, adev,
> +			    &amdgpu_mm_gws_table_fops);
> +	debugfs_create_file("amdgpu_oa_mm", mode, root, adev,
> +			    &amdgpu_mm_oa_table_fops);
> +	debugfs_create_file("ttm_page_pool", mode, root, adev,
> +			    &amdgpu_ttm_page_debugfs_fops);
>   #ifdef CONFIG_SWIOTLB
> -	if (!(adev->need_swiotlb && swiotlb_nr_tbl()))
> -		--count;
> +	if ((adev->need_swiotlb && swiotlb_nr_tbl()))
> +		debugfs_create_file("ttm_dma_page_pool", mode, root, adev,
> +				    &amdgpu_ttm_dma_page_debugfs_fops);
>   #endif
> -
> -	return amdgpu_debugfs_add_files(adev, amdgpu_ttm_debugfs_list, count);
> -#else
> -	return 0;
>   #endif
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 4df4cf2fd4dd..69ba8dd4f3ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -186,6 +186,6 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
>   uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>   				 struct ttm_resource *mem);
>   
> -int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
> +void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>   
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
