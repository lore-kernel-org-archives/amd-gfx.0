Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D41C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 18:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27067113005;
	Wed,  6 Jul 2022 18:04:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCFD11300F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 18:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7gIzAu4+kEvguTQFdEMmZy2VEq8W0vV3DRrOPOsL5nkkBC+3e8tnK5K1Bg4DWMpSvDIZFZrXUMP2/xeJnv9QMoWnbTqH7RivPfNEU+d0yZPxNes60+2QEeDVpfiizBNsITUhDqu3s7383i2E+e8eAvzJQs7u/l85KQHZN13olNbCJbb/UUJpeWUKcK8ZpkpIy9i/0st3xE2xLPyMEu4ITqgMszsiv+IeusX7w0F/nBbQ82lPbAjaUpgYF7q41ZOhfs+0tyu02lPnT4ICupsA2hdUNDIJsaC0a4S9o9i4TrsapfNA3Tg1mLXu50YaikxnlhQQUHZ/97Ryaz8UKE1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K37ibL2CLPEp/8AbhHLDRhp3P/a4a7Ar/x6bN0OKuZY=;
 b=jaWvpr2k3ITfUy1Ilz5bUD09KcEK6KhHVo3lmKuH9zQZ8JSBeXOdpVCBEhEekLTTnQ/jdvGRIzfhhiUr/xCDFUuUvLbCztuLfX48M/wWOvlR1V+oIlYIyvnT+G1G+gpge7zA1RfWuLw3l8oNU8EHoSGOM8OtLn1mORP+AGGZG4hxd4Z1Q4bwidhE9OdCtcx8/ZumVWoVpH2NlcwUZkmXkYE9zCACd3qrxtAW/QewpWHixpOPezc3e1xTjBu4JJ5nevzU1a5sWX5uYpxwSm3Rlv1QRTZhKPfqdkLNI1wLMBwDQIhMmo0yZ970HqjAnRi27EZpkhxZeXG5DAMrJp8kvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K37ibL2CLPEp/8AbhHLDRhp3P/a4a7Ar/x6bN0OKuZY=;
 b=SOmc/FYZhSyS826vmXPYm+RJi1+hROlThbphFh2fXsN269LJnevyUFsGY1mXaq1g3q3Rpof+ucPzFKojD8ZzxfUr569AQ/ixEb2rW+1T6rhXq/I0Up2d7oSYyojD1Tii3Xs39YVs+O/VDnssAOuf9L9BRyFX4j9EDNxLTO3mUpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB5406.namprd12.prod.outlook.com (2603:10b6:a03:3ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 18:04:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 18:04:02 +0000
Message-ID: <eaded102-5760-8c6b-3d4c-f4ee80e23504@amd.com>
Date: Wed, 6 Jul 2022 14:04:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org, 
 dan.carpenter@oracle.com
References: <20220706164701.3490363-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220706164701.3490363-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 179a8585-e151-4a36-fcf8-08da5f79e88f
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5406:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhBtCOP+v8DkSKhxHoeLhcCnsw2GE0oPU2scnop5tnsemmVS+VSjR0z/23efSI4dqHTHiS5/eYD0UCO2U8FKellVd+LPDY7RdrCk53qBw3oJm0KT7ygIGmSbelPTBMlngqZSshawgwiaGpxV2gxFcnOlQbz+q5PJWui9NiHhwY/XWTuaZE8JsiOgRBa/Px6DHUBeeA4n+RwXk3niHFky/OVV15seHqWvJ0krk3mC4lqginvKZ6YQQmulCbSsvotdmCCJlHTbwg0/YG7AAtHBLz1cH2DYKoKvSvjAGMv8wSgTj2NTK978y4KrFxIhHOjshHl37eUYvzxx4h5JsmvOlUwvmirgr9rl7zNetxfHekk84FuuKgrpOUbyrT0hTEHEv2t/wxCGDyj5jZ2WiyBWu5oUgTfm2Kvg4zc97F99dgp8USv6YW5EN89s56Y1HxaSNdrFzuUjBPx/Kki8eMaUmBRHsuVQy4edayWiPZverii7zf6UAuZ4mv/uSeoez4wtfGXzDlgTR6tBS3ZB01kR+jni+p14OyEtft4H9NZiVfyyKwyuetZVbuKuLD9VsV3n4XOxZ8ElthTH3mF8ABzT8Cp6BQrZG0+XD0ZArLFOIwfLdTEl5uxTFJalvalqPvmiGV9tVc8gnymZ8t+z/Ue9FDNHO1NTaNwMECBcG+hqMZq2GW73Ojp0C8Hw9VHEYYiSEn+wTD4Ixr9fBSRyY45dCkVEH39dY8nDhbb5fokCZa8btzZsRt/XXIAcHW0lbNxrexcLF9hJmURCBy9g5fYxQOPk+H83q8vIwcjbaVR9BB+ldjh0U3txuyV9EtERe+/00nbqXcg/LGSvfZUBduWX9WYc+b3116VkF/McSz/onTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(66946007)(8676002)(38100700002)(5660300002)(66476007)(66556008)(31696002)(44832011)(2906002)(86362001)(6506007)(2616005)(8936002)(6486002)(478600001)(41300700001)(83380400001)(316002)(6512007)(31686004)(36756003)(26005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VheVBwVlVtWitOTStrOUNvY0Y4R3FTK1pqZmpoSW5YRm9icXVoc1AxMU5Q?=
 =?utf-8?B?MUNFR0FUMExWamhsT2RHR002WnRnT1pGNlVOQkUzMU5zbEJvUkQ3NWNTb0xa?=
 =?utf-8?B?Wkw1b1dUbnVyTmEvSDVhQTlTNTQ4RVZUQW1uK3daYkhINWVlM05UTU9QQmg3?=
 =?utf-8?B?S2lTK2poekNmWUNmSlJzcGVYZ2d1TWxtVkxNNnNpZzkwNld3S08vdS9OSVQw?=
 =?utf-8?B?SzJUcE83bWpLMS81VURqL1Vnd3VSSkovd1JTVG0wcm1ZRUdncFBqV0o2VXYr?=
 =?utf-8?B?M0d6YVJraHU1a1grbEdQc2VTVzYwS3YzUkcvUmFNSk53SnF3WktERFoyN2Js?=
 =?utf-8?B?anZVZmx6c0FCQ3BEUUxvR3gvd3Q4cVF4di9KcWdMZjFqQzRQUTlsM1FuZCtR?=
 =?utf-8?B?RllVV0VqQzdseTF3L2QvbFlpME90MmI3b3hKZVoxcXBtSDlFb242aHB6L3h0?=
 =?utf-8?B?R3dUNVJKTjZSNlp0dERKWGhTNHhHSmVTZEJIVTVkMlExSnVCdll5cFRLSUxQ?=
 =?utf-8?B?enNnZXJ0MFcxL1dpU3V4Ny9LbE9oRE5HOVZQMXBtYW1UdDMzSGZsVFF0OFVD?=
 =?utf-8?B?QmNQSFhiTFZWWHlMOE96SnlvYVJ1VVd4ZDB3TGQrZTdwTzI4UlBBME9pUGRZ?=
 =?utf-8?B?cE9tY0E5T0psOG9hY21PQ29HRkUzOXhRUlBBYU83LzBWNllJYXRib2dHZHIr?=
 =?utf-8?B?aUtJQUVxNGpDM21sVUNEc20wd3hPc291SkI0ckMycG90NERNMjVOQk9EOU82?=
 =?utf-8?B?Wm5VSGhwMlZWeHBPbG0rQmkvb2RBVGFwSjBHaThBWFFsSHlPSjYxVVYrS212?=
 =?utf-8?B?Z0tKbUpMTkRBTXpWQXNUVVBEU0swb2ZmOWg3cTdjME4vVkszVHhGOE9sdmZE?=
 =?utf-8?B?UVpmQUZUTkpVRWdvdHNiVlNqTHNzb0dlTmh4MCtvdGxRVWdwaDhZNGl1c0pp?=
 =?utf-8?B?L0hILzcrK2lhZzdGaUtBSlc2dzk0dlRkNDNmOVB6VFIrcmJXVm0zV29Mc0o3?=
 =?utf-8?B?eEdTSjBnWnlwTk5obGF6eHlRUXpHbW9aRTRuRCsxdjdKV0ZjQ3hycThTVXla?=
 =?utf-8?B?Z3RYd1RleFlCWnVKbGg2WmV3T0czRkp2dlQ0aHBZWDZuVHJTa2dQTWZmQTdz?=
 =?utf-8?B?aWI1S3ovRmNSNTlzTnFqRVBIMEhGdkRUYlJ5TDkwdEhuUmFBYWNmSUZOVXho?=
 =?utf-8?B?ZkVMempIYTlLZzhrZnJhQ3B3ZmpvNEg3RGtPNDhMSHNSSFZGZFBnbDVDV2NY?=
 =?utf-8?B?TTVQc1g4QWRRaXJSZzlpNFFqakFUcWQ5b0ZYRzN1TTJuSUU4RDRlZ1hWTXVl?=
 =?utf-8?B?L0NZWlRXRXM4NGhlZ3RQM01NR01uelV0L2FvK2xwNDZhdTgwRHNHdmdTV2pD?=
 =?utf-8?B?VlIyYmhrVTR6cnY2RXljMzVSMEJMcHdtZDgvSUhLRmdDN1RxS2Zubm1nYlhQ?=
 =?utf-8?B?VHUzd2hwMnlHajR4OUQ4RkRTcTBSN1NCeTJ5S2xwc0ZOZHk5bExyeEIzUEFS?=
 =?utf-8?B?UUYva09ET3hWVWRmc2ppWXlvTXlsVUVyWTIrb2MyMkZxMjA3Q0wrUlNudTJQ?=
 =?utf-8?B?ZW1oWmxHa2NoWGkrbCtSM2xYSGF2ekhJT0NuZkE2MGJpNVpiRXEwNHhCSUxy?=
 =?utf-8?B?ZlhsVmRrYzg3SnZIbFdaVGJ3ZUxvQjlpKysyK1NSdjhVVjV4OHFpdGRDSjVz?=
 =?utf-8?B?dWdEak8rNVhTSFNKUExpVUphMGNQTnBaR0VRVDlrY2Zta05lYUtIdUxKcEt4?=
 =?utf-8?B?NDRJbitaenh3Y2pZWlpjcnF4ZWxBNG50N1VYOHNRem90SEVTV1BUSVVJZTEy?=
 =?utf-8?B?Q05tR0s0UGxSWEdST3JWTlN1WG9OUjd3V2gxU1pNYlFjeXRKWGtmbFV4cTU2?=
 =?utf-8?B?M1hybEZlWGt0eTAxd0l4Y0R3ZC9zNUJrSk04Y1NURGphUVF3NE94WUZqNWcv?=
 =?utf-8?B?dzk2bVRZQlJ4Z2lSYjk2MGJaemlnSU1pck44RmRPZkpUN1dwT29FQkppMEZq?=
 =?utf-8?B?c3c4NTdqV1RleW4wT0g0SkJPeStzK3RFdXRtbkJkVFUwcS9lUzBQeWNueTUr?=
 =?utf-8?B?QnZRVEY5UFJaeGlSdXJwUU54TXBMWnB1N3lYcG80UXhNeFpTOWRrK1NGZmxD?=
 =?utf-8?Q?aTG6r83WmZ2nyKUVrCXNskZo8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179a8585-e151-4a36-fcf8-08da5f79e88f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 18:04:02.5184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFGfNfPZmu0UI7VDUjbsfjD5P2h6fdjHFzZ0TSQIyhqUOOpn9C0mx8pNU3GPPvaCIPZc9pcl+eo2R1vb4TvPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5406
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

Am 2022-07-06 um 12:47 schrieb Ramesh Errabolu:
> The patch fixes warnings/error as reported by Smatch a static analyzer
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_create_indirect_link_prop() warn: iterator used outside loop: 'cpu_link'
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1462 kfd_create_indirect_link_prop() error: we previously assumed 'cpu_dev' could be null (see line 1420)
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1516 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'
>
> Fixes: 40d6aa758b13 ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 34 +++++++++++------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 25990bec600d..ca4825e555b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1417,15 +1417,15 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>   
>   		/* find CPU <-->  CPU links */
>   		cpu_dev = kfd_topology_device_by_proximity_domain(i);
> -		if (cpu_dev) {
> -			list_for_each_entry(cpu_link,
> -					&cpu_dev->io_link_props, list) {
> -				if (cpu_link->node_to == gpu_link->node_to)
> -					break;
> -			}
> -		}
> +		if (!cpu_dev)
> +			continue;
> +
> +		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
> +			if (cpu_link->node_to == gpu_link->node_to)
> +				break;
>   
> -		if (cpu_link->node_to != gpu_link->node_to)
> +		/* Ensures we didn't exit from list search with no hits */
> +		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list))
>   			return -ENOMEM;
>   
>   		/* CPU <--> CPU <--> GPU, GPU node*/
> @@ -1510,16 +1510,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>   		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
>   		if (cpu_dev) {
>   			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
> -				if (iolink3->node_to == iolink2->node_to)
> +				if (iolink3->node_to == iolink2->node_to) {
> +					props->weight += iolink3->weight;
> +					props->min_latency += iolink3->min_latency;
> +					props->max_latency += iolink3->max_latency;
> +					props->min_bandwidth = min(props->min_bandwidth,
> +									iolink3->min_bandwidth);
> +					props->max_bandwidth = min(props->max_bandwidth,
> +									iolink3->max_bandwidth);
>   					break;
> -
> -			props->weight += iolink3->weight;
> -			props->min_latency += iolink3->min_latency;
> -			props->max_latency += iolink3->max_latency;
> -			props->min_bandwidth = min(props->min_bandwidth,
> -							iolink3->min_bandwidth);
> -			props->max_bandwidth = min(props->max_bandwidth,
> -							iolink3->max_bandwidth);
> +				}
>   		} else {
>   			WARN(1, "CPU node not found");
>   		}
