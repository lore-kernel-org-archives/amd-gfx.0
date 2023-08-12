Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC0EC001B0
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 12:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5518510E055;
	Sat, 12 Aug 2023 12:44:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D2810E055
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 12:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgl74KYqrQpx8L//EWyRYwbsaUyuFnfaozWtQQiKZb/9Oarmqo8XKua9gTZxajJBv1pLdjfn9aIaxq5W+vaPD6PqzXgvMZptKvOv4Y/NWTJJoj5yYpsCz/AQB5V00Az0NeNVzbxYcQbL1C8zKSlYWtaT842W0E21OD8Z6kpLJQRfrKbR+ZqIIXcu+k/s4FOftcgElQBKir5auuLiiqh9Bn8b31tLyy2wCwwECTO/t/0Wg/8NfhwPmjDH/S3T7I7/zi2M20FZck0Mwd0PS69rQ3aTcstchJDA7dygOXdadukGx39I7TOffqUzUF59R9Pz6bAsyk0i4oYNo+yLummWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dtJechnQ7ysK4dudtRUkvXLY+eVZzHKgi4FWYVkUBE=;
 b=lD+9Gts5eezuC4IF9H8tLKMjBPSykFlcYVpi27HRLH6uAGe8J9TOPeL5gf0flskMeoD3yRFOIwMXGKxVjPwgC/eHyjCP3nxv2ydKu7RYwTvRIC1d3e5w+VUiZyRgPz02PPRBdXtj+wiCMEG5v/y8VFHFOoCSa5nmYia7j46ON82XP13DALBnklBY5Ij0H+/QXWeVemKP0hVwQalp+NqNzjq5OGcYHUHYqQHILPml5zssH3bUf56DOL3c2kEmy9AX/AGN7+yI80kwMZZjFWNw26O7sFgPr4J7Hk5g5R99J3aRjCvrHIS0U2QPZ8DrCFs4N05Aw0VS2UqxrWqTzqwYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dtJechnQ7ysK4dudtRUkvXLY+eVZzHKgi4FWYVkUBE=;
 b=ZiwSIGi56XNzI2gbxH2Bk/LEiwnPFSKSXuAX/e6Ow/aPax5BDyRnhcegsXR548w08V4wJWprzc9kuIYnqVjDF5niorb259lsFvM/obCWR0l1n/fti3LIrVL0WJwCMgd1qR/Gj7Ic3YPz7uACl7fxSfqRgbq/zbGIxZzUTQs4Cj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Sat, 12 Aug
 2023 12:44:45 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5%5]) with mapi id 15.20.6678.019; Sat, 12 Aug 2023
 12:44:45 +0000
Content-Type: multipart/alternative;
 boundary="------------ORwMjuLRQ3acvkH1sjBMoXUE"
Message-ID: <1f81e70b-2469-6042-8d97-d150e67dc9c7@amd.com>
Date: Sat, 12 Aug 2023 08:44:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out of
 drm resource
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230811202337.1867891-1-James.Zhu@amd.com>
 <20230811210627.1888328-1-James.Zhu@amd.com>
 <BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0342.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::12) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: c878bda4-f6db-433f-9487-08db9b31e7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOVDQEW3cYwmKVKvlGU7U3X0WDqzfEWhF6l1VI07Ti2AMeOzzqZeLqVnLmSV3d7hBFDKtHDBDKHuouWycrYaXdF01FI6NHaJFsj/OJxdIFQymVc9l9FrLvgBulLOm4I8fatgp33A6aUeHHbgIpMnh3AkiNxTRwlymG7nCYIpVwICDZUT4HaAxup30wduFifP9sgHM3VFvkpGJFxRWWxhmsatWS9HXUF0qlci2fyxCvSVZ07TwYtAmVHNBtL4/+fFKMMRLrsE84Pb9TFn340GVwVqvMUSA3YFz48FLCiuSdiO+dIY/tHbRKQPG4tJ0ax4b4AKQ5Zd2sOre8thMZsjkAZCnAZ/ySIqbDNxAS/FrSs+2xvrr2pfsO6JDgi0aBVxq0Be++0k1GM9/W1tUvoEUf/uL2kzOVyXAGwO6zoX3qb9ptRGDycXG2dkCfCexHDQFZJFbISgPn7YVn8/9LDrA+o1bocaM3m0uICVLpihhaaF/toT9wZruCPuv2FAg2u11f3MHpUyMXc0v+epoKbPHVYG+Uhy0/wYzxaRNVjCiJ6qoSsafEow+wW0QAIGTLCl/vk59oBoFhnjOFFVsDd+Le6shvpZsXzKPfzgRdH4ijcRQsh8FI8J0Zf8L5nQNyGuIgz3G3CRaTjD5aqYqNNL2QNQIrCjYoBiA9nrdGIJm4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(186006)(1800799006)(6486002)(6506007)(6666004)(33964004)(6512007)(53546011)(36916002)(966005)(478600001)(2616005)(83380400001)(26005)(2906002)(316002)(54906003)(41300700001)(66556008)(110136005)(66946007)(66476007)(5660300002)(8936002)(4326008)(8676002)(31696002)(38100700002)(36756003)(66574015)(166002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2p3V1BOdFRYWGFMSWJuU2pXT1RVcmJGRDhBNDNLQ1lLaStyZWxJekZZbEpL?=
 =?utf-8?B?cFcvOHh0Ly9Hb0hQT2NoWDJJcG1oUDQ4Qy9mRXpiSUhPSWY2MHNmV1VxQ0VB?=
 =?utf-8?B?ajkvZnJJU3hXKzFDblBZcEJvM1pRQnVRR0E2T29mMzNWLysrNDRYbE5uWnlC?=
 =?utf-8?B?RW91cXkrOXdVaGN4aWJ5SVVYZjgydDl0UEQwMEE4cjMvUnQ5ZWIzVXZIOW5u?=
 =?utf-8?B?TXBkNUdoNXZpdWN5WDNjc0tKd1VhY2V4cDNUTGlCeURmeHpDTUNjcGY5OEdw?=
 =?utf-8?B?czhjdnlCQ2xDNWJhUThIZkRBeG5rU0ZjZHNLeGFGWHM5T2htd3ZQRG50Mit6?=
 =?utf-8?B?ODFTS056c0NmNXRMQldmcDJrS1I4N2xWTm1wUTJSQlI2YkJsT2xucktLT1p6?=
 =?utf-8?B?amw0WmgwcnFYYTdEeFd3RHBQeGh0N1dmTWZYQ3p0V2RLRlRjLzNXeEhEdjdT?=
 =?utf-8?B?bTZiQjM5OXVodW15QjBZVjMvMFFYS240aFh4NW1sUmtnVDl1UFVuUFkwbVVB?=
 =?utf-8?B?RzhPL2JVUWVEaVNoaFlSK3RETytZWjJza2xFekozb0VRTEJNa0dsWll0K1R1?=
 =?utf-8?B?eitadmNSZlc5M1NHOFcvYmNZdzdSc2xDZFhVdGRPRis5a2JqZzF1anh4eGo0?=
 =?utf-8?B?aEFodHY2VnczM1FiclZjdjlFZjZrWjdBdDZPd3pSSjJRUW9CYmZ4amtXYkk1?=
 =?utf-8?B?anRydzJKWFJZV2ttK2d0WG9ETG11dzl5Z2VZWVJrOEtCTGoySWtVWmk3dCt0?=
 =?utf-8?B?WTk5Q2hZQ1F3MkFQT1NISEROR3VYbmRtZk5YNHpDVmc4U1RFTkhFTFV6cEky?=
 =?utf-8?B?aE4vM1pUdVBRVlMwdHVTaHp3SGd0UDlmenRMdm16aVVUaDF3eU1zSTJhTjJK?=
 =?utf-8?B?c3dCeS9BWFM5NStNRWliblZld2JWcGtSM29UeU0wU1hrSThhSzBDMlNRYmJS?=
 =?utf-8?B?STFTYk1NVit6elRIUjZ5N0hsbVZ6bmc5NWZQT2RFdTFNdE9reXE2dDUveHlH?=
 =?utf-8?B?UnQ4clR1TjRic00vanNkeG9LYjFsQWdyeTdrakQzMzlhZzlLdkkxOHR6OXhB?=
 =?utf-8?B?ODVwRTNnOGU0bTgxU3NHNEp5dnlOc25adkRVcFdvUkhVWG1tWEkvMUxZcTJH?=
 =?utf-8?B?MUZxVDVENzd2KzUyeFNQRWNxM2JwNVNoYVZRaFc3cWhuWWg3MnlTci9kTWFj?=
 =?utf-8?B?QnZXYU1xbnFaNEdBQ0FkaXUreFZkaXg0WEVSNDJsOEt3b2syMHBlRUdlMDAz?=
 =?utf-8?B?dWwvYXltRGRFSUhCUVlRQ1paS0ZjZC9jVy9zcnIvVkIvTUdIR1M5VVdoamQ1?=
 =?utf-8?B?ekxHMEVrWngzOU1Uazd1cFRIbEhuQ09nQkE0eTEwZ0JTM2x6eGdVVnREVzNs?=
 =?utf-8?B?NnB3aU04amxxWlNhMTNqUng0cll6MEhubzRURTd6MG1aZ29pTjkzZjlpWXZk?=
 =?utf-8?B?Ny8zQjR0OFRCUnZZQ0YreTltVitjdjBoQ244RFhmc1I1M041OEtVMyt6TTdP?=
 =?utf-8?B?aVpWT0hCTVJINVdoalp4WjREMFVITmhQbmtFcndZYjVkRHZUMUY2VEsxMEJK?=
 =?utf-8?B?RGR3Q1dBMENWYjYyRFdPYll5Nnd6ejhhMFMrV1I2aU4reENPZnBoV0RNY05h?=
 =?utf-8?B?eFBmSEVVemRHS3dGZXBadnJPNjhqZjRQaGtZNTJPbXFtN0RBZHNvSnphS1dj?=
 =?utf-8?B?TkwweDlZL2g5dTVkbFIwNzZyUkZBYnQwM3E1SUw2azZpVVg5ZWx2Zk9sSENN?=
 =?utf-8?B?Mlp2SUVSRGFtb3lYUTN2bGZtS0RFTVdib0lVbEZqejFNVXNYVS9PZCs2N3hF?=
 =?utf-8?B?ZFdVeGxzS0FkSi9JZW5QYk40M1djenFEcmUzVTd2K05mZ29jekoxUG0zYUhS?=
 =?utf-8?B?ZWVOVVdyTGdWSHlFc0I2ZGVhODd1cXZPdDdGajI0eHJyWWYxdmZvYmxTVGdv?=
 =?utf-8?B?NlNlZVVETWNmK0FIdW8xamsxSVhvWXBRa1hKdXg0MnZIS3NDeDFhelNZem82?=
 =?utf-8?B?UGpIMzRxZUhHcDlFTnBiYWxpaGVqa3NTdmpZbHAwRUUwSCtGZlVZOXNVVGpl?=
 =?utf-8?B?OWhGSm5iZ09oSVZKYjZWUlNiSUt5ZnpNOE1TbTFhTHZVemJzdzQ4M055ZnVw?=
 =?utf-8?Q?a1xqWUFotJkBQB8ZhYMnVQ3Bk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c878bda4-f6db-433f-9487-08db9b31e7c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 12:44:44.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJngFdF0rUaKxvsOnzPKV47qWe0b2RMiu3Fmunfmzj19FfG9VpyXBmHaetTRzX9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------ORwMjuLRQ3acvkH1sjBMoXUE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023-08-11 21:39, Lazar, Lijo wrote:
>
> [AMD Official Use Only - General]
>
>
> A dynamic partition switch could happen later.  The switch could still 
> be successful in terms of hardware,
[JZ] Only ignore render node assignment, and remove visibility in user 
space, xcp continues to be generated as usual. so switch should work as 
usual
> and hence gives a false feeling of success even if there are no render 
> nodes available for any app to make use of the partition.
[JZ] from driver prospective, the switch is real success, treat the last 
one harvested in user space.. there is warning in kernel log, and final 
solution for more than 64 nodes is on-going
>
> Also, a kfd node is not expected to have a valid xcp pointer on 
> devices without partition.
[JZ] won't affect xcp pointer, only ddev.
> This access could break then gpu->xcp->ddev.
[JZ] added skip when ddev==NULL
>
> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> James Zhu <James.Zhu@amd.com>
> *Sent:* Saturday, August 12, 2023 2:36:27 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Lin, Amber <Amber.Lin@amd.com>; Zhu, James <James.Zhu@amd.com>; 
> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>
> *Subject:* [PATCH v3] drm/amdgpu: skip xcp drm device allocation when 
> out of drm resource
> Return 0 when drm device alloc failed with -ENOSPC in
> order to  allow amdgpu drive loading. But the xcp without
> drm device node assigned won't be visiable in user space.
> This helps amdgpu driver loading on system which has more
> than 64 nodes, the current limitation.
>
> The proposal to add more drm nodes is discussed in public,
> which will support up to 2^20 nodes totally.
> kernel drm:
> https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/
> libdrm:
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
>
> -v2: added warning message
> -v3: use dev_warn
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 9c9cca129498..565a1fa436d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct 
> amdgpu_device *adev)
>
>          for (i = 1; i < MAX_XCP; i++) {
>                  ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
> -               if (ret)
> +               if (ret == -ENOSPC) {
> +                       dev_warn(adev->dev,
> +                       "Skip xcp node #%d when out of drm node 
> resource.", i);
> +                       return 0;
> +               } else if (ret) {
>                          return ret;
> +               }
>
>                  /* Redirect all IOCTLs to the primary device */
>                  adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
> @@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device 
> *adev,
>                  return 0;
>
>          for (i = 1; i < MAX_XCP; i++) {
> +               if (!adev->xcp_mgr->xcp[i].ddev)
> +                       break;
> +
>                  ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, 
> ent->driver_data);
>                  if (ret)
>                          return ret;
> @@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>                  return;
>
>          for (i = 1; i < MAX_XCP; i++) {
> +               if (!adev->xcp_mgr->xcp[i].ddev)
> +                       break;
> +
>                  p_ddev = adev->xcp_mgr->xcp[i].ddev;
>                  drm_dev_unplug(p_ddev);
>                  p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3b0749390388..310df98ba46a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>          int i;
>          const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
>
> +
>          gpu_id = kfd_generate_gpu_id(gpu);
> -       pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
> +       if (!gpu->xcp->ddev) {
> +               dev_warn(gpu->adev->dev,
> +               "Won't add GPU (ID: 0x%x) to topology since it has no 
> drm node assigned.",
> +               gpu_id);
> +               return 0;
> +       } else {
> +               pr_debug("Adding new GPU (ID: 0x%x) to topology\n", 
> gpu_id);
> +       }
>
>          /* Check to see if this gpu device exists in the 
> topology_device_list.
>           * If so, assign the gpu to that device,
> -- 
> 2.34.1
>
--------------ORwMjuLRQ3acvkH1sjBMoXUE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-08-11 21:39, Lazar, Lijo wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com">
      
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div style="" dir="auto">A dynamic partition switch could happen
          later.&nbsp; The switch could still be successful in terms of
          hardware,</div>
      </div>
    </blockquote>
    [JZ] Only ignore render node assignment, and remove visibility in
    user space, xcp continues to be generated as usual. so switch should
    work as usual<br>
    <blockquote type="cite" cite="mid:BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com">
      <div>
        <div style="" dir="auto"> and hence gives a false feeling of
          success even if there are no render nodes available for any
          app to make use of the partition<span style="font-size: 12pt;">.</span></div>
      </div>
    </blockquote>
    [JZ] from driver prospective, the switch is real success, treat the
    last one harvested in user space.. there is warning in kernel log,
    and final solution for more than 64 nodes is on-going<br>
    <blockquote type="cite" cite="mid:BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com">
      <div>
        <div style="" dir="auto"><br>
        </div>
        <div style="" dir="auto">Also, a kfd node is not expe<span>cted
            to have a valid xcp pointer on devices without partition.</span></div>
      </div>
    </blockquote>
    [JZ] won't affect <span>xcp pointer, only&nbsp; </span><span>ddev. </span><span></span>
    <blockquote type="cite" cite="mid:BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com">
      <div>
        <div style="" dir="auto"><span> This access could break then
            gpu-&gt;xcp-&gt;ddev.</span></div>
      </div>
    </blockquote>
    [JZ] <span>added skip when ddev==NULL</span>
    <blockquote type="cite" cite="mid:BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com">
      <div>
        <div style="" dir="auto"><br>
        </div>
        <div id="ms-outlook-mobile-signature" dir="auto">Thanks,<br>
          Lijo</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><br>
            <b>Sent:</b> Saturday, August 12, 2023 2:36:27 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Lin, Amber <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>; Zhu, James
            <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>; Kasiviswanathan, Harish
            <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH v3] drm/amdgpu: skip xcp drm device
            allocation when out of drm resource</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">Return 0 when drm device alloc
                failed with -ENOSPC in<br>
                order to&nbsp; allow amdgpu drive loading. But the xcp
                without<br>
                drm device node assigned won't be visiable in user
                space.<br>
                This helps amdgpu driver loading on system which has
                more<br>
                than 64 nodes, the current limitation.<br>
                <br>
                The proposal to add more drm nodes is discussed in
                public,<br>
                which will support up to 2^20 nodes totally.<br>
                kernel drm:<br>
                <a href="https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/" moz-do-not-send="true" class="moz-txt-link-freetext">https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@intel.com/T/</a><br>
                libdrm:<br>
                <a href="https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305</a><br>
                <br>
                Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><br>
                Acked-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
                <br>
                -v2: added warning message<br>
                -v3: use dev_warn<br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c&nbsp;&nbsp; | 13
                ++++++++++++-<br>
                &nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10
                +++++++++-<br>
                &nbsp;2 files changed, 21 insertions(+), 2 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br>
                index 9c9cca129498..565a1fa436d4 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br>
                @@ -239,8 +239,13 @@ static int
                amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 1; i &lt; MAX_XCP; i++) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
                amdgpu_xcp_drm_dev_alloc(&amp;p_ddev);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret == -ENOSPC) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Skip xcp node #%d when out of
                drm node resource.&quot;, i);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ret) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Redirect all IOCTLs to the primary
                device */<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;xcp_mgr-&gt;xcp[i].rdev =
                p_ddev-&gt;render-&gt;dev;<br>
                @@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct
                amdgpu_device *adev,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 1; i &lt; MAX_XCP; i++) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;xcp_mgr-&gt;xcp[i].ddev)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
                drm_dev_register(adev-&gt;xcp_mgr-&gt;xcp[i].ddev,
                ent-&gt;driver_data);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
                @@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct
                amdgpu_device *adev)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 1; i &lt; MAX_XCP; i++) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;xcp_mgr-&gt;xcp[i].ddev)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_ddev =
                adev-&gt;xcp_mgr-&gt;xcp[i].ddev;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_unplug(p_ddev);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_ddev-&gt;render-&gt;dev =
                adev-&gt;xcp_mgr-&gt;xcp[i].rdev;<br>
                diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
                b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                index 3b0749390388..310df98ba46a 100644<br>
                --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                @@ -1969,8 +1969,16 @@ int
                kfd_topology_add_device(struct kfd_node *gpu)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *asic_name =
                amdgpu_asic_name[gpu-&gt;adev-&gt;asic_type];<br>
                &nbsp;<br>
                +<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id = kfd_generate_gpu_id(gpu);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Adding new GPU (ID: 0x%x) to
                topology\n&quot;, gpu_id);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!gpu-&gt;xcp-&gt;ddev) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(gpu-&gt;adev-&gt;dev,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Won't add GPU (ID: 0x%x) to topology
                since it has no drm node assigned.&quot;,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Adding new GPU (ID: 0x%x) to
                topology\n&quot;, gpu_id);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check to see if this gpu device exists in
                the topology_device_list.<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If so, assign the gpu to that device,<br>
                -- <br>
                2.34.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--------------ORwMjuLRQ3acvkH1sjBMoXUE--
