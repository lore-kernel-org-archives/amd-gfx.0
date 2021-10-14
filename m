Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAA7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 17:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3406C61167
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 17:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3406C61167
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDA96E1C0;
	Thu, 14 Oct 2021 17:55:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CBF46E1C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 17:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG5thqjQbUgyhuI/IVrNMCbTwaz7N0j1cK1h1/HyPysSLbFvNvsF+MF0/rrRz8em/JONoO5/1SeEcZxUBJW/IGlzmMpPklr3zDTtEF28yBZBuauyH4AhNB9NqrJF/CIkzj88ztC9JKPpegPSYw/xGj8pIDz6/HJ7W2JkbsBz6NTRpTm3OxonoRxU8LG2MOEh3Y7RfzWznNK/SgaK05YMZhvx4YXGdBS2wT2OysRGgjgn3NhZLyP3ZOHZzMpewAy187xJeDWx4DPAwlBMuruTPL28eLr1cCm8pd93CWgiHknyenggG4Oq0sD8RqAno4Qvk7hiYgQ9a5O4dY5q9VuvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7EXcF1w5a6B3FboFSnFUGH5KRRuQEJ0TDldw0QF0uM=;
 b=M6T+mLS6DXAZBYOyh/DaKd08undyojIp5SoBk655V0/KR0Xce4uHBW6qVzefYpZX4EnVRxtUteEU92nECtDW1xHR2bc2X3aLvQFWVZtYeOTrXLWUMFYFNRReJbVvQzysD2+441WnKZs89CgQ8P+h+W9ODL8WvdqGRTacoSy6JIriddxrOejA54XhPeyLtOqnWxT3tGtVhu6KgngQ8Q3pOn4ChYvmPegjduZI01fWmBMm/vluo6OlQnNDaQvLNvqk0o7duic0D5Wczys/K5PbThZehFR5l5crbC4wHcdURfLq25vT372DYLDJ8lAO/Cfobl0MJyD4ys6dqAcAwHNYOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7EXcF1w5a6B3FboFSnFUGH5KRRuQEJ0TDldw0QF0uM=;
 b=xxbmTz+2uuZYpQ8HxCoSVe40dl8vMURDzOU+JBS3RwT4m0eKiP+9lXlZeBuXVjdJPnkDzo7hL/oR1QvpeJh7sg6krYWub7/rcYQPaPjpGts1WxwMin4OReOPnxgOWcoivhOIvuuO8xtSEZuOqDOQmQipB176L00NbVKD1pP556E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4618.namprd12.prod.outlook.com (2603:10b6:5:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 17:55:14 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.030; Thu, 14 Oct 2021
 17:55:13 +0000
Subject: Re: [PATCH] drm/amdkfd: map gpu hive id to xgmi connected cpu
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sean.Keely@amd.com
References: <20211014174454.3342996-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e7d59f5e-3db8-5abd-9947-373f868f1219@amd.com>
Date: Thu, 14 Oct 2021 13:55:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211014174454.3342996-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 17:55:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 730a8ca2-9797-4258-1308-08d98f3bc604
X-MS-TrafficTypeDiagnostic: DM6PR12MB4618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB461822C3FDA1A84BF6A8FC2692B89@DM6PR12MB4618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRDg22wMObApiinSHRuBNtxcYiCP8yTAopqFhgFfAUN2u+eIofqOUadS+LYIBpjwpo1VDq1mIa6F1dqxxXygysVHXdPWukU8NQkUNvzb7UNjnfGtugMDE755F+EV4beixp19gUsXw8002i11o+QdTzku3km3ntHEO/3pJD1JsaWz6qWS9VN4L00s2sfr0Dr+0zswbcZyqF8HLPYS9ub2tGkFMZtI2t8ZYCTUVPDkAO9ORqYT7Ur1Ty6Yy/4qSUlKLfiC11KKotwhIrUDy5dencVpbdgoCWKfi0Mg6Gl2ogrnVV+kXWM/r0zo6EH/jj1pSmLEdoIp6ddh4X4+E9u9sKVGn3Ns6Pteir4k6xpTSjbzPK8hzak2rPVKjP+bkT2OKXsEClWkjEIj0dgfHoPR9KyUHtqSkOZni9Rb/GcI2GKowWTgkHlrXgHmrO8nNlLfNGF4qo3IPV5alwbo9fxPfd5Ef7WRphkIPfc7dS4itUk3VUEX68bgy0BRSMu3hpKMeSgtlsd9sgyngbn+3fIEbXrqWNd2gqIRHP251/hWi9WkbsIY3Xy+QIXW3zJW6mT2e7257S645YPu88f5hS1O0n3O7vCJ3B3+3NQjAJUJmpSak660hlgR2LgM8h8rcsIEFYZz/ZQSJz3uW0/c7UsrT6uSH0OESR3k3iJkfAkSmxJgyCo0AYHMX+SREY/SNUH9u92pAr4OPr4HPevbsiDlVNCwOOIRDRvMQ0/8wspIML9gxTUp88q1bq5M9Pec9WIj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(956004)(16576012)(316002)(31696002)(66556008)(66476007)(66946007)(2906002)(4326008)(83380400001)(86362001)(5660300002)(44832011)(31686004)(4001150100001)(186003)(26005)(8936002)(508600001)(8676002)(36756003)(38100700002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0x2Sk8zNC9XRVQvOGRLN0NCa3NlZEs1d2E3VFZyR2M5S25SOGxYTmFSUWxH?=
 =?utf-8?B?bWI0ZmVYSm0wZ0dobHR3aExGY2lxaS93dlNFNVFyVTZiREFrcERPMURHQi95?=
 =?utf-8?B?VTlKU1grVHl4djFLMHZCNlBGcDFVRWZGK1p1V3Rzc3pXWXA0WEs0Wi9KYVNi?=
 =?utf-8?B?Wm53VVlqY1Vpa0JTdTNZYU9VTDB4dDh2cXFSb3pMYjFOQlFnYmxrckx5UHBE?=
 =?utf-8?B?SkxLKzRTVUJFS1FuTGx6OFI2aHBiaU1VL2RLMGZvbFM5bzlEMVdDNFJkUkE4?=
 =?utf-8?B?cytMNXpQRHk2OVRoekhDL1Irb3F6NnJ1LzhRbkh5bEFMWVJ3QWliMUNDaDJn?=
 =?utf-8?B?K0d1Z0hZVk12VzdXeFdQSHNzclQxUmdiU2FUWFZEcTJCQXJFdWRHYlN0VkhG?=
 =?utf-8?B?ZlJndkFyQktOZm1tZkRGRFhXU0RsNTE1VFZsSmQvNVVZaSs2aWFzbFpKV0Yr?=
 =?utf-8?B?eEk1Z0pZUXNQVndETzZqWUN2WUdKKzhDb05xQmF1TThxQ3hVRzEzMHpQaFI4?=
 =?utf-8?B?UXNDaUNCRVlWQzMySzZNOFNsby9oWWg0d29WdmlLNXJXb3BwaEtxbGZLWlVQ?=
 =?utf-8?B?cjJLRHJkVWNienZWZ0lhdDFienFQQk05Y2tmSUpDeklGMDJEWnBMN3JNTWgr?=
 =?utf-8?B?QWcyUE43UzNrRHVFT1BkMkNKMlFPOGMySFlTcFd1SVNtcTRDeWNNb1c1NDVL?=
 =?utf-8?B?a2VBbnllSFRYV3VNbXcxeEZUdFZTbFhRNXFnSHBTZXhlYkE0ZmIyOHRTVmox?=
 =?utf-8?B?WmJxL2hiZFJ5S3ZoSTdhZWM2MldlRHIvWldzY0sybmlvVHVzY3dKYWRnUGpw?=
 =?utf-8?B?WUNxZERRMzN2cUFvb2J6T0l4TVkwcEx3VG9ZY2ZoQmlOdlFZWUZ4NnJXNnIw?=
 =?utf-8?B?L1p1RjhHamFLQXUzRGJqRExwM3ZXdGtJVEJCY1ZFbkhnZUczZ2lXUnVhQnQx?=
 =?utf-8?B?TFVCSWZTenlocnJiQ3pPdDhYUVd1Si9kRkx5bTE3WjlCZ2Q2QmhiM2RUSUlp?=
 =?utf-8?B?czlyUmlDRVF1NzNkU2o0ZGlwK0RPVzIxZFJEZW5iUllaOU9Ob1hDbDk2aGlH?=
 =?utf-8?B?QSsveFVDQWhreUlwc0dIaWkvNnZBSERqR2VxTnpMcGY5a0dzS25zVStoVTRO?=
 =?utf-8?B?UFhnejNPZk5FTzRITnZnN2RWOThsemptMkFWVTJNWWJSTXBkUFhrOG5XOGFF?=
 =?utf-8?B?NmxBU3pDSGxqdmV6TkNvWDNEM0dGL0lxUTJOUmQwZnZscTEyb0NSL1BrNEtM?=
 =?utf-8?B?MFNSbzhHSXJzVGdrQW9Hd2RDTWE1NVFVVEpxL1J0Rk9kYUJXRVgzK3BHNWdx?=
 =?utf-8?B?T0pMMnQyQ01IOWpEZDBLRXFWdk5mUzhSWDUrVHcvUExCYVFZc0k2NGhoam84?=
 =?utf-8?B?dGF2dkxLQ1FjVlliZXhFSkpnb1BKU2ZjZFIzazJmVUtBSDV6TGFzaEU3Sjdo?=
 =?utf-8?B?RnhFRW5SVzJQSlEwQTUzT2VINnM5QkN6clNQVjRpNWJ5WTI4QVAyTG9aT0la?=
 =?utf-8?B?VW04bkV1Z29ZLzV0MTl4ZWxCSElrL3J4ZkhJZkhxSGEzYXdRaHNTaEVhdVQv?=
 =?utf-8?B?VzNodzQ3cVBKakxtV0hFSGlnWWIzT2VxODZxWE1UN3BPMW9rVVhXWVYrWDhC?=
 =?utf-8?B?c2EzcTB2UVVURlh4UWJROTdueUJlREtwUmFkWU1lVkpKczVhTS9BRHZuU1pn?=
 =?utf-8?B?SkpVZVVQamYzcjRRYWxvdXI3bW5CUW1qa0MyNHFyV0NWdlladG1PcjBHNHlk?=
 =?utf-8?Q?qCsOiM83IFBWEqewMjdmL6RKs6KNv+OH4lYkRoU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730a8ca2-9797-4258-1308-08d98f3bc604
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 17:55:13.8873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvFE5qmBKFTM8/bJ5QeKh+bJWgbyJn+2j/+CxvLeXmTp0L7nsYUWwMLO2ug4ATc28Q5dPkL/pAVzPPAnYS0Itw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4618
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

Am 2021-10-14 um 1:44 p.m. schrieb Jonathan Kim:
> ROCr needs to be able to identify all devices that have direct access to
> fine grain memory, which should include CPUs that are connected to GPUs
> over xGMI. The GPU hive ID can be mapped onto the CPU hive ID since the
> CPU is part of the hive.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 98cca5f2b27f..d04c48dfd72b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1296,6 +1296,27 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  
>  	proximity_domain = atomic_inc_return(&topology_crat_proximity_domain);
>  
> +	adev = (struct amdgpu_device *)(gpu->kgd);
> +
> +	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
> +	if (gpu->hive_id && adev->gmc.xgmi.connected_to_cpu) {
> +		int i;
> +
> +		for (i = 0; i < proximity_domain; i++) {
> +			struct kfd_topology_device *to_dev =
> +						kfd_topology_device_by_proximity_domain(i);
> +
> +			if (!to_dev)
> +				continue;
> +
> +			if (to_dev->gpu)
> +				break;
> +
> +			to_dev->node_props.hive_id = gpu->hive_id;
> +			break;

On a NUMA system there will be multiple CPU nodes (e.g. in NPS-4 mode).
The "break" statement here means, you'll only update the hive ID on the
first NUMA node.

Other than that, this change makes sense.

Regards,
  Felix


> +		}
> +	}
> +
>  	/* Check to see if this gpu device exists in the topology_device_list.
>  	 * If so, assign the gpu to that device,
>  	 * else create a Virtual CRAT for this gpu device and then parse that
> @@ -1457,7 +1478,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  		dev->node_props.max_waves_per_simd = 10;
>  	}
>  
> -	adev = (struct amdgpu_device *)(dev->gpu->kgd);
>  	/* kfd only concerns sram ecc on GFX and HBM ecc on UMC */
>  	dev->node_props.capability |=
>  		((adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__GFX)) != 0) ?
