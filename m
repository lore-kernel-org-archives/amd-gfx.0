Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00CBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 19:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8EA10E493;
	Mon, 16 May 2022 19:35:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8D510E493
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 19:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zae6K3EpNU2l1MH+KW2vgTJyGZv1gEWkzlEhlAU9NRjpcrdbF9KmkfIL0G6FIPhL9CEkOaWxv3fMalynnEzg4n890Z+ur82vRBVVwFKM2nAqDKwnT8D3xyvm4SVpKiXJL0YNX+hZLBXwA/kYT3qPJoyqW2CE4/VgD33S4JRqAaFoxVZQIsoOSL8blTmq5x+67TSnaezAmzYE8fHlRzUj9nwVU/NL0oPcKzpmC+tKsPefMS11yGQ01eCsls7F4PJ8heNaFQ8XwiAHM8xAfhIIBAzcu7weYwAJfuS3a81H2h//8ADJlD6k4KNnb6WVwbOAmlqL6HXx0o3Iqbh5vxFbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ekw2orHANY+U3vp/Aqpl4geoU9bmKAE3iY/roA3Y/U=;
 b=nqXFKQq2qXxLLlgZI7b37r3cWeKoIDb9Oljb7SeJMr6chWn3ZzfgY+fEzwjGy8E69IdVLC1I4IEDRXYlkEPz9AY3uZYfXflg2r/iLrGUnOlpE3QjlmdbbR0qHjRBxrCgzoHecp9/FYgofw2/FZWeg5slppeUseiq2GXQpZCz1cgMiCSiw6qqcwHNZ7WKGGRc8M8BpalDynBLAPeC0w+lmSxEGAI6CoWyMfYAcwnVUCeA6XSrzqP2OwXuXnDNsFvRb+P4G+LKH0oPIwVetg3sbw4HqCCQ9y/KrR+6YL+1rFRiXTAmrgc/gPNMiqQZNeP4DTAbKjBW6grHob6QQbcTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ekw2orHANY+U3vp/Aqpl4geoU9bmKAE3iY/roA3Y/U=;
 b=5kR1Mf338IYR27ttJrKejL9Tcz++maWCjWaAEunDNyOuijlf5NmvwEtYNEz7UGVdu/F26opqCu1QBh8JDGQhDtF0PSyNHddnOsFT4yaI9uBGZ0Wte4/NaXi+tpqGeoCyxb70NJ3PmHJ5sOOmTURmcpxdRl2wMe+zKT1buTZpRMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB3943.namprd12.prod.outlook.com (2603:10b6:610:2d::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Mon, 16 May
 2022 19:35:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%8]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 19:35:17 +0000
Message-ID: <d71132c0-2dd5-b4cb-eed2-094036604a08@amd.com>
Date: Mon, 16 May 2022 15:35:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdkfd: simplify cpu hive assignment
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220516144318.2009474-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220516144318.2009474-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 740da74e-f138-4254-266a-08da377334ad
X-MS-TrafficTypeDiagnostic: CH2PR12MB3943:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3943621AEB9C4D01E651BF7A92CF9@CH2PR12MB3943.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLa/Kj9TX3JUpA12vgd/LFrmEeazR8hNI4NfDGYyRGg3NM7RW86/Y2hXxbo0gesJHkEwcKLWcOIDHEsafVdSQXtRLWZ8EGqeAityTlC2/enpr8jRUVRs24p7LsmwYyik2eV5NCP+OXXpH1Yhaf/wSKDZykVfu0azsvfKb5pnrpav1vNufiPSweAj8JtqvNij3WAELPMMbhoFDPrZ9u94/rLgNxpHXbntqU/cBDPPpCAeZ6Om2JzYMFswAKvI71SCI74+AQWbxr0Xaw5Se6VSRE6s8mYraR/lD1NdszUVtbokcaO3rT+Zbx5KKMNY6hmTWoa+TX3tgzPQtZFxGSU4bpLVeR61GzsFZYLdrEI7Q246Vu+3us6P+mv38HVTUVLSvhbOptjCjuXyuYxEkmjxrbxBILvbVzW82YGWHMe1y9wOCzCbKyHoRU0mdAI8fByijRIfY8vpy0ANW8sfpTitHOr6Dnv2ptyeSkWSPP4sY3Fcuye1E1aXgd4XbvgRIBYy9SmbiAihNsfZFAsEo8t/HaAY2Ua6nItnlWyH6M+bHQAh4bioXHAkF3yikeVmJMy2Gr+wqgn58OAX73egRA5UDi5i1tIBuil/9JlY3mLdTbwUH51oB4W0xuThdPwZVHhusXOfalwzmhs+dd4RTUTpkxLKjJlIlqGcRqOh9goVCoItLfcrVMjeUImkFCxLCmGHgCbyj2qA3N6oo3eTKIrIRFAbsZl0q+ojJjSB09PqnzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(2906002)(186003)(6506007)(26005)(8936002)(83380400001)(508600001)(66946007)(66556008)(44832011)(31696002)(6486002)(31686004)(316002)(36756003)(2616005)(66476007)(5660300002)(8676002)(86362001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRwNVZydEJUc00wSmhucUFUSnhGcmpPWTAwQ3pTdDFnWWIrT2NWeUo3bW1q?=
 =?utf-8?B?dXBiaGVTNEpNYVF2bjFGV3V2UlR6L2J1UHRmaDBvNXRldHNIcVhWMDd5eDRV?=
 =?utf-8?B?dE9kZ0o4OENTRkdzS1hoSFdobVp0SnY2eHRUSUlEbWtvTmxzRDNGcnQxQ1kx?=
 =?utf-8?B?K3NNOS9Zdll3NXJnd1Z5emJkdXo3WmVpT0cxWGd5c0k4b0UrcGl4UU1pZFN4?=
 =?utf-8?B?OXl3M3RCUTg2dFMzZkliRzF5bjFrbS9UVllpQXlreHgrc3lLMTJ3Ly9Yd0hK?=
 =?utf-8?B?ZmU4aUhxeFJlQWVFdWtvYW92cVZMbEVWVmVncFVVeUtSZ3NBcjdQOTZLZjlC?=
 =?utf-8?B?SFlkWTFmQ2FsZTYxRW9ldkJaaDlsM0w2RnJlYkp4OHF2Wm1OeGJ2SVN4MzU0?=
 =?utf-8?B?NVFYdHFrc0p4SlEwYkh5cko0WU1XM1ArSTh5YVkxdGcvekk0MlU5Z2ZFM2Q3?=
 =?utf-8?B?VGdPbnpTNmRhcGZqZFpBeGZkZmNuaVFvUlkzd05YajhKcXRpNGFGMTU1UzJk?=
 =?utf-8?B?dHF4TkYySjArK1pDNzlIOVp5NzVBZlFHSmFhVXNNb0JiNm9uVTU4VmNSNisr?=
 =?utf-8?B?THIzU3g5VlR5YWFmeHdIeWhJaDRhTm5ScEpHdEdrMFZHSnAxTnByYXBJS2tv?=
 =?utf-8?B?N1JNMEtVaXBrdDJpWExKTXZ1TFZtMnl2V2VTM3R2Rkxub1RrVGNzdHBaSzRD?=
 =?utf-8?B?Yk9EWit2TnNqM09lWmJKYkFQUVBTVEtGVjRUQnBndzJFS3dwMUtxcGlEVXRh?=
 =?utf-8?B?N3NkeTB6VmROK3V1Qnc1NjhCM1NxRHlZUGlSb3U4SS8vdERlTWJrMHhZRGZr?=
 =?utf-8?B?dHVUMDUwQmpTcElnOFpYa2orNVJDWHJINGYxbUlPdFJFeVloKzVDRFViYWo1?=
 =?utf-8?B?ZlFERXI3ZkpnQmp1djZSWGJvL3pkZW1oZzVQMzdmY3UzL2ZhWVRFZi93V0ps?=
 =?utf-8?B?YnNFWFkzMzVOUXdUR1gzNUc1VnhFdXd4K3BDVUQrd1E3UjRKb05JcmVBQXNO?=
 =?utf-8?B?T2w1Nk5FcmtJVUNLODNVWFRuVFV3MmtKUE9KUkdEVGhLOVJvZVRGcWFEM2wy?=
 =?utf-8?B?MFNlb3cwOWtQQ3hHdVlXcVVhcTlBQklEdGo1ZVd0VHdjN3VSYVptcWgzaW8x?=
 =?utf-8?B?VUJuS0NrRFVGOG4xajcyejMyZDhvNloxTHVYTWdJYmFqQmY2aEEycEtNS29h?=
 =?utf-8?B?R2YycTRpTVpQOXMwaEtPMitLOTV6OVoxbFAybUdJOUJCWW1aMnNHSlR2T2V5?=
 =?utf-8?B?T3Y2YVdLQ2wxRkdPdzhsck51VjZ6UDRyZFVTLzdXUzc1YW5RUWN3dEV0b1ZD?=
 =?utf-8?B?ZW9mbFp5RkhVQmk1a3dqSmlzMEEyUmppUmVMZ0FoZ3pKWlFJZkxKRklja2JC?=
 =?utf-8?B?YU52dFhYamIvU0JwWGhwMzQ0NkRocllXZ3hSOHVkVEI2d2hSUnNRRXZoNTZX?=
 =?utf-8?B?VnVTVmFJOVduMFNxUDhOalFxN1B6QlZEZnZiRFRYL01PVkQ4NC96NHhOSG5z?=
 =?utf-8?B?a0cwQXA1ZDY2eVF2UUMwNzRaZ2o0dDNtQmxtZ0ZiQ1NKd3ZOWS8zQzZOYzhr?=
 =?utf-8?B?QVE1VTBvMnFvYnI2UFVHVXZzQkhKVzRPRnVqTjBOWExIa3duNUlOQ0d0MXNX?=
 =?utf-8?B?NXh4VVZiVzVTUEI3MTNQeEFjRmJhRkdWUVFGY2orMldwNnRyMTVpeTRZRGZi?=
 =?utf-8?B?dU5NcCtRMWxRbXA2eFVWbk9XMitTR0pQaXhUYnc0Sm9ySE9kK0JWYS96bnJl?=
 =?utf-8?B?NHhRNVNWcXlHVjg3NlFlM29tYkxiQ1FFNVpGLzlSWlJSYXZuWlp6MXF3TTZy?=
 =?utf-8?B?RzRrVHBkOE1iZzg3YUh4a1VURXJiY1RCQUtxS0I4TVJjcFE2R2gxOElaNTA5?=
 =?utf-8?B?WmxweUpONUdaU211ODAyR2VMMnVIeWcvR1pLd2R5VElmeTkwL0J1VVZEamxv?=
 =?utf-8?B?N09haE4vczJLZVU3Y3pkTWM3QW4wWkhldUNTVTdwWmphaTdqU0J0MXJpa1li?=
 =?utf-8?B?US85NmpleG1sVjFmdE9pK3RvMWt4cXdtY3RpVnRNeTViT1owREg2eDdBWkpo?=
 =?utf-8?B?TjN0LzFwSGZkTmNqaXA3VURrcTkvZlRHOERaejJ2dFdBc1NFNzFTcXcyUFgv?=
 =?utf-8?B?UlhRNlFJRE1RSTdxRDJBQW83L0hBSkVhZ2E1d0c0d2dQY2FuTzc2RkJiZlB5?=
 =?utf-8?B?anRyOXNCTG82MElKRDJTbVFCdjFOd3JMY05KS3JXY3RaZVZIQmR6RWVrQ3NR?=
 =?utf-8?B?K2l3SGhxM1RGR24wcmFidnJwZVJZWkprOW5PcHAvaDdHaDF0bm8vWXA3Um9E?=
 =?utf-8?B?eGhSMEFiaFBYK1VZNklnTnBpcW5SNmhPSmVoOEc2MDRjOVQxQ3VMZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740da74e-f138-4254-266a-08da377334ad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 19:35:17.6350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3rY6GvrGuRZDPe7OhiLhWP9RaSGCuvTXt357+1Dobsba+hHf+fBRt1vb7TruFlYsLWbiS+X/WUTijMNtUasTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3943
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

Am 2022-05-16 um 10:43 schrieb Jonathan Kim:
> CPU hive assignment currently assumes when a GPU hive is connected_to_cpu,
> there is only one hive in the system.
>
> Only assign CPUs to the hive if they are explicitly directly connected to
> the GPU hive to get rid of the need for this assumption.
>
> It's more efficient to do this when querying IO links since other non-CRAT
> info has to be filled in anyways.  Also, stop re-assigning the
> same CPU to the same GPU hive if it has already been done before.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 22 ++++++----------------
>   1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 2e20f54bb147..8d50d207cf66 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1271,6 +1271,12 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   		if (!peer_dev)
>   			continue;
>   
> +		/* Include the CPU peer in GPU hive if connected over xGMI. */
> +		if (!peer_dev->gpu && !peer_dev->node_props.hive_id &&
> +				dev->node_props.hive_id &&
> +				dev->gpu->adev->gmc.xgmi.connected_to_cpu)
> +			peer_dev->node_props.hive_id = dev->node_props.hive_id;
> +
>   		list_for_each_entry(inbound_link, &peer_dev->io_link_props,
>   									list) {
>   			if (inbound_link->node_to != link->node_from)
> @@ -1302,22 +1308,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
> -	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
> -	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
> -		struct kfd_topology_device *top_dev;
> -
> -		down_read(&topology_lock);
> -
> -		list_for_each_entry(top_dev, &topology_device_list, list) {
> -			if (top_dev->gpu)
> -				break;
> -
> -			top_dev->node_props.hive_id = gpu->hive_id;
> -		}
> -
> -		up_read(&topology_lock);
> -	}
> -
>   	/* Check to see if this gpu device exists in the topology_device_list.
>   	 * If so, assign the gpu to that device,
>   	 * else create a Virtual CRAT for this gpu device and then parse that
