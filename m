Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AD1C001DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 02:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D96B10E0CD;
	Thu, 27 Jul 2023 02:47:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5626D10E0CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 02:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmQawGn4vdVwgAFxE5sUS/DwY6teVmNVjiUgJ5OgjJ15Sfa0Hbj0OigtSELrcLnfkY3eeZip4ZLQfoG0ihhVutXXTLpkyYQrS5ExGqkoOD09UzCvFYMZKOf8IElyLyBH8pGkCt+rSiSUJZzx0xez/xbKw4bq0/INlC1EE1rtaS5uArOvzcpS/w3H2TlJCI2iKi6crXrBlpZp6LtSah7jHz8zbeqJdaM0Pwxn/vYu/EpReM8f+LkjLmzmqVlq7vDaSJa8FpMJxefw6EM+XoPcbBKem1zrSCGeg2TX7r815PcHYEf2DO7QkdC2BSztnOXzWghjaxGMv9OYJ1rZtT9udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SihUBHazUwzV2sm7p6K2nAy0NXk71mHAFpYQtrQ2e0I=;
 b=LuQh0w7yqYqJAoDho7wEkkFrSYG4wEsd/prmYOV1pp/gnMGTuDzKncariql5oJU6VXkPi71/7BfooTsvapLZyPLgGlp+hvvQDtJtUvthuL8wugLwZ62QCWUiwGTBa2IbmFKUpt7seLRvl648tyV3TKOb77p8xoITyvvpkxeHz9RKZF8H/HMfmVVDTynOOutA2awkMeoCRlXnXjKyeYf3GnOTiOqA6gE5m/IwFSKg55F1sovPcJ9xWayW6f/freBevgfcTK/S7HXgZXhr/cX4Sb3o78QZB6N+N0NSyi29rInH6YKmZiaJ05bMrDuyw8E+IpHBG8sKZ8EPv303fU6DnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SihUBHazUwzV2sm7p6K2nAy0NXk71mHAFpYQtrQ2e0I=;
 b=3mzrCpcjBMqxugQ62EjAGNFewgtyMGnGHOMJovefFCg+2YtucODUH79UqHAV/gIFbtWsCgoqb9rqS58ymqx6qmKmGQYN8hQ7+ykFxjchWWX1bYH9wTf2FjxUwNgYYUvowCGz7P4DThSKMiq+51nnCyIs6j2ZU3b5+hHF/ZNcKJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 02:47:16 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:47:16 +0000
Date: Thu, 27 Jul 2023 10:47:06 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: Re: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping
Message-ID: <ZMHaqktRbbok0Rpi@lang-desktop>
References: <20230726112446.653625-1-Lang.Yu@amd.com>
 <BN9PR12MB525798EF052541B0EF1E518DFC00A@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH2PR12MB421533576E2F0265F1AD2B61FC01A@CH2PR12MB4215.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB421533576E2F0265F1AD2B61FC01A@CH2PR12MB4215.namprd12.prod.outlook.com>
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 772971f4-5076-4e49-ced4-08db8e4bc991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zvi4Fla7sFMB73IXuWERa1f81j5yDufvk4N9WU800tUTLFhARKo4r7LafFw6KEgshL74QwjkuSkpEiXnSU6bSAsqTWT45omeBfaqL4M19Yh1Ny5tvEDkgl0MllEWrx1EEbEsjmtvln95ZZyNzVWd1lA2nJ8ENUmjH0u47IepspjXyn5BiRjfz87SeXdooZ5Q7oBuqNWRWvySC99bHNLRz5ligg6EkTKUi2AP3UcNIgQyuKaYm7F07P7zcw6RccCUhHo8pPzvR8WgO+wdmNQV+uDM/ru9ADjwpJjicclHqhVd29QAjyhpawFbqLnA5mP+CqFmsfC21FGGUeCPsdXK1pV2wBofuR4b71lHT+OiVZJymiCkm7L7fTJoil+Iam16+ztFxeWpSN1jDoJHto7c2Q9hcSHW2EbkuxHL+iK942RyQJWsn9qZG3jqYGfZZWS2AlFIzElBEvSsAoX4zlBkTJx3VzfveIQkVdX8Zp89kr3w4zZvI4AO753Bc8nlyjtnixspfLVc6WrEQxQQfAjfpUzpETEQQmApdEX66AWswu6Ul0Hy4iHLo3zRR1Akqwb4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(6486002)(9686003)(478600001)(6512007)(6666004)(86362001)(54906003)(5660300002)(6506007)(53546011)(8936002)(6862004)(26005)(186003)(2906002)(41300700001)(33716001)(38100700002)(316002)(6636002)(4326008)(8676002)(66556008)(66946007)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8g1FuJK/xxLuFPGsrElNQOSx4DFs1H7E8IrviUvKcnw8nO7S657sAHb+RGnJ?=
 =?us-ascii?Q?jQofypXurycopWu8Y8Et3befKdEGDu4YYzf+LTkJPt1vCx5QWRusFRZMqmly?=
 =?us-ascii?Q?arVH5z8NsKdUxv9EV4sqB16360hZQURobF/mDgCoxU3iDam4ACxg5LXWIo1b?=
 =?us-ascii?Q?RqS6l89ugfL+YRd/DfWM+fYr0FoXpWCVrO0pkka3dEpno9Hv4V8RqUeqy46e?=
 =?us-ascii?Q?U7Jda26Hptyf10YZc2M1Iml2C74PpiSKTxIsBraEm5Ql9ugPjPu15C998mUt?=
 =?us-ascii?Q?PDYH11Y89Lip+ReQmRHXF9OdBcGl0w5+MTmHHnY0d400IoJYY0H9ic82IA75?=
 =?us-ascii?Q?YwNUch8Dv2rkT6Nw3tDhQ8LJRwMPsG9M1cy9haYVCIiIHLKzIOCQsZ1k+W34?=
 =?us-ascii?Q?/2+/S8rD2whv+93aIB1ekgDXkWEx9BA3He3BENlKh3knBC+Sv5fsQoRWGuuy?=
 =?us-ascii?Q?PWkrMqZOXdzU4GTc6A6gjqgmaP+BF9hrHMqKJ6pQM9aGnWQ9sYoFlfesIyGf?=
 =?us-ascii?Q?BNK2GPFAvi/7V6UrPCqsodmyGHn5nFb88TC45joEzGQXS9eCtJSpraM9Z60k?=
 =?us-ascii?Q?z/DDalEvA7B2kdLi/XPXlOKf8Vc7B7YjTXpJu79dKZS4Sq+7Nae0hZQYI2eh?=
 =?us-ascii?Q?XdIvNpD1cRUfaUym4pRf72CmxN/XfgFaEDtV1V/WFzw1nBa2f0L2G8MPhS2m?=
 =?us-ascii?Q?m4bVxGMsaEgmWflgz3t1RbziFLHJ0TRsdvUyIBOqJ+9CeAHuDOK/u/bGTN0L?=
 =?us-ascii?Q?iZYK2tJCixZcqvAxt2YxkUnmSARxtC4NT7IIw2tbLRVSW2xuwsweH7MLCHCp?=
 =?us-ascii?Q?qgg1DcJq+QwZ8KHnZje5/X25g1R9X7q+MTwJFoBa+0W/ETa/JK6Rcn7Gbc/p?=
 =?us-ascii?Q?mSFpQ6i18F057+lm2EH1w/iLDmhCJXK0TvoIvMXmnvX1AYwSE64xRVjYJRkY?=
 =?us-ascii?Q?/oCP/LGwieoc83/u7x/hjHWAk7hUPj5hjNq+8+Dtf1XJGRJTf1TRRw9S9gyt?=
 =?us-ascii?Q?/H2UybBbLpsay3Fx1MC49TMKJd+kJ3Opu7gUeOvA4tSg266PmUASYI5EozPU?=
 =?us-ascii?Q?WFjoak0SY9jBT5ekgPS7zRfDyvw4apXTZRnATOrHkwZwXaYdeTswITt4OlIN?=
 =?us-ascii?Q?dgEP9FcM/tkI57KqshCOQerY95OcpcCuPlBK+uH0BQFfOjQ6h1JzzWrqwKzG?=
 =?us-ascii?Q?7U7M1b8eM1cyr9OnEa/mxJAGRD6+F2cu4/oMkglzXzKWhzrWbsFAe53A2j18?=
 =?us-ascii?Q?y84dRQXNbyqOsgu/A91re7mHib5eOOU1u8bNYG5t2RfAzNnKC8cwWPLXgIrs?=
 =?us-ascii?Q?US/uT6jPktM2qmJT3DgwK9MTMlh56pwRnTo27mRXBdrdgg4fFj2XDveXZFJG?=
 =?us-ascii?Q?UCB32utMKMHbiyGUPNQuwbcS8IBGsdNuZ84NqBiopF8IEPY5m4C/f1TwHbuL?=
 =?us-ascii?Q?XTCGwJ8BiAiSU87Dgig8VcekIkOtOGnpsMDEED2P/ib0oPhGqkWCkGCoYLAt?=
 =?us-ascii?Q?2/nR3MmFozeLcT3h5HU/VcOq/iD8d081fefWJCatiz/ZkcJucRjZOLcnXbn7?=
 =?us-ascii?Q?oZOqV3B7geFRcOmmlGXR4lk+eHV0F1uLhZSWE49R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772971f4-5076-4e49-ced4-08db8e4bc991
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 02:47:15.9882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgTTXr3mEr7YyBujPFAr3zwrF2iwK+Ah+HkBpPRjIxVucvBXRhTfv4i5ohzV40lDaxlYhSUbhRHt9a7+r9u3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 07/27/ , Chai, Thomas wrote:
> [AMD Official Use Only - General]
> 
> Yes,  the patch title is " drm/amdgpu: fix incorrect vmhub index ".
> 
> Hi lang:
>    You can update this patch based on the above patch review results .

Ok. Thanks.

Regards,
Lang

> 
> -----------------
> Best Regards,
> Thomas
> 
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, July 26, 2023 8:03 PM
> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org; Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping
> 
> [AMD Official Use Only - General]
> 
> @Chai, Thomas sent the same fix for the review if I remember correctly. Might check with him to see when he push the fixes.
> 
> Regards,
> Hawking
> 
> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Wednesday, July 26, 2023 19:25
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: [PATCH] drm/amdgpu: correct vmid_src -> vmhub_index mapping
> 
> Align with new vmhub definition.
> vmid_src 0 -> AMDGPU_GFXHUB(0).
> vmid_src 1 -> AMDGPU_MMHUB0(0).
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 6b430e10d38e..9c4e084da99a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -102,9 +102,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>                                        struct amdgpu_irq_src *source,
>                                        struct amdgpu_iv_entry *entry)  {
> +       struct amdgpu_vmhub *hub =
> +               &adev->vmhub[entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0)];
>         bool retry_fault = !!(entry->src_data[1] & 0x80);
>         bool write_fault = !!(entry->src_data[1] & 0x20);
> -       struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
>         struct amdgpu_task_info task_info;
>         uint32_t status = 0;
>         u64 addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 604522f70d03..47f5ced12ba2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -99,7 +99,8 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>                                        struct amdgpu_irq_src *source,
>                                        struct amdgpu_iv_entry *entry)  {
> -       struct amdgpu_vmhub *hub = &adev->vmhub[entry->vmid_src];
> +       struct amdgpu_vmhub *hub =
> +               &adev->vmhub[entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0)];
>         uint32_t status = 0;
>         u64 addr;
> 
> --
> 2.25.1
> 
> 
