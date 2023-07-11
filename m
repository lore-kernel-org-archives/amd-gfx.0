Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639FFEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 18:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC83910E08F;
	Tue, 11 Jul 2023 18:33:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0EF410E427
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 18:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaMwdLosaq6I60m9Gw031nhssOHarhopx6amHVM0M/BbIt+7xYLOALJCi/PuEwgF+uL7lx9udaturF06p1kKTFjnEu1mSa+zR/SDTda4+Ib9G0wbstexuStPt1BD7FD511lEAs+e8XwCl5tvNfHLqstd2xZ4lP2R6ZfMypAIJj8ywGJKN8nnQVAPeeeZDn3Juef4s2occtlMooZ2WqdXwkFVzfvXxNaaVn3u67iM688UuinnOPehSnyBbuYdhmzrkvNvmczomN/nJ9cTIDycoW3+xGb1XMo2M8TTEK1FYysSdVQ9AOsvavXdXyBVbHpk2Jm7W7m9FcASmldSQ+yNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNiGYROCJySCZWbEfIjjId/fRaZmKSVEOVHNWVtn5QI=;
 b=HtzQGBSYqHMu8n4WDbfesFvlgtSr+brt32+P2jnaj2/Tu9kisEvrgSobNhqhNf248bL2Rd1itRnSYwwIHTebsjWGrZZdLEWxSX2VBOHdzg9e1n1voMR1gdikW6ODeRS1eyKlW6EjDX4sml1s45G3HwHCFfWqmGGW3SPLmLDgLEA8eB+cMP9vAN+MqUH38tDur0tgwvkW4gB1kC8hjPrHfNJ7z4m9foIKTVJZeqcbd5M+pY6c+axUu0qTTW5ziFHmoN84m7QMb17qdilFCMWI2J3oVlCoL+OZ0YD9AXjoFRVJo1eE9o9OnRKgRwoIJdHnJEVBfhAJQvBLAwQQlhsI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNiGYROCJySCZWbEfIjjId/fRaZmKSVEOVHNWVtn5QI=;
 b=RsV27uajskuEBg9Yzk97di30CrgnIqxtChB8yDI7l1kJZw9CmvT6NqGsUlzqCtUsWdovLqACqC1yuRe+arZMbb6Wo2xbfnxGBG9YsYiZZh3/CU5MGqYlyJ89eeegv0AcktPoCFLo/+hfVeiG5l/nitnuwG5a9D5mDQB0bqUoWqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Tue, 11 Jul
 2023 18:32:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:32:56 +0000
Message-ID: <eba2d296-e694-ecc6-9568-39f505b2517f@amd.com>
Date: Tue, 11 Jul 2023 14:32:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: report dispatch id always saved in ttmps
 after gc9.4.2
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230711171947.2914493-1-jonathan.kim@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230711171947.2914493-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecf27f1-d592-42fe-dde6-08db823d3f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+76P77XvxvfO+lSFq323QQZpBHZLzemVPKXDJaFJdAZT9J/HiP8e4PQznk8Q+qpKgzLov/MYdDiGYaJA1j6ZrDQ91lZGRLfLHkfs3WrvflIn0qu2owtAnS/uA9ZlJM8OQviR2SmIDT98jwwEQdAVoZHwJnMJhgnw2KCGVg2NfLMpn523UaZ/kQmvpobDA0euIEBshpA+w1tgvxJghScLf7IOjfMG46htzSXy/FpXSC0O6vTZNdGmKJkq518wJyu5RVnhgmw26FkYSn741xQdMdx1jtJCUcZxk96/TypPrWSWK2LqjHSE7CUNAaB5g2DXgSOBAscfcggNyGEOny2+oCJzbMPrwN06MzhWHkU7BzltCMMW7svCfm0jRELzBBBzi0En4/1Ijw0nx3IF6AyQoUSBJL656k/J4cghHlyeMQIZ5W3bTftQ7nD8/xgwsUIdNu7uLJi0CVj7XIrPCwU5q7TOmJ7Og9XO11w86VNrQ56XLFhZyi9S8geuC8Izmqw84v7VTUdoSx5FQmiqd7TvLF2ndtPUBOJEMp3TiEKELeFvlVS19AblVbiLTaj7qTvM6xFj+Sg6m/yScICVzv9ANIHMnuwDhX7QIN62W7QfiVi37IZ+DbV1rU4QYd8XYxapvFc5YaWL2BjUFKwq6WSCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(36916002)(6486002)(478600001)(6506007)(186003)(53546011)(2906002)(66476007)(316002)(6512007)(5660300002)(4326008)(66556008)(41300700001)(66946007)(8676002)(44832011)(38100700002)(26005)(8936002)(86362001)(31696002)(36756003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVorVmFuN2tDVWgzOG1NbFdTM0w2VUFjSkhudEdkYmkyaVc2T1MzZGdwQ1oy?=
 =?utf-8?B?WlRzeFdaU1pzR3o3bUZEMHRBaXhtdGJyeEhqbmdPM0gxeWJjNnQvdW1zR3ox?=
 =?utf-8?B?NTB4QW05eHhJSTNWWXh5aW42V1NaTVBvN3puZ3JBdEtvQjBuVXlvRjVPVC9B?=
 =?utf-8?B?UVE3cTRTZmJqYURzTHU5YXhvT1IxNlBBU1FTNjEzd0draHZ5ZStPMTRqcmky?=
 =?utf-8?B?YmluUkxFOFhGdS8zRWhjdVhKL0VsdytiUHREb0hmZ3p2a3JBTURaYkU2eEdI?=
 =?utf-8?B?UkFuYnB6KzFSS2FZRkQzbmY5ZTNOZU5rdC8wS0xoTHdxMHBoZ0psNDY2bEJH?=
 =?utf-8?B?L1dmUms1SXNFZUgwa0F5WlB6MVI2MlBUL0dGSnV3aHg2Mk5tZ3h3cFNYS3Q4?=
 =?utf-8?B?WGMzNHJxK0x5UEhodGY3TngvbHZKWGEyUEtBdm9iTWo3TkVTeWZBQ1UvZGZt?=
 =?utf-8?B?QU9weWJ0YVFvcTA2QW1GcXhpMnBjcnVWVUVSNUxhUitRTHJRa210VDJZNWlE?=
 =?utf-8?B?VzBheVBSQlVRTldKOUFMMC82UzIrNHc3cjFhdlhKM3o3MW5KWjFqb1FyR1Z2?=
 =?utf-8?B?Zm44Vnh0RzFZSzBGNjVvOUxYK0FpOWVmNmxWd3pBcjhNYy8ydStBK1d2TFFp?=
 =?utf-8?B?WUFQYzliVmNMUWRMQnhhZEJOSkpFdmhDK1dib040OVQ5c0R2bEcvdWtRSXgy?=
 =?utf-8?B?ZGNLYkdUY0xMS0ZCQ1o2c0k0T1kwdWRhTnZQcmhWSjB4d1k2TFMrZkRNRFEw?=
 =?utf-8?B?N1dsdStTWDJ0ZXZ4UUdRcnFDZklOVnNsSUpuZXJFUiswWDdFT3lFZ25tU3pK?=
 =?utf-8?B?U25XL3hEQkNBYmRmY2M0aTF5a3B6Ujg3TE92QWp1WkpLV2hERk1Mc0JySWY1?=
 =?utf-8?B?VHo3Y2pDa0p2bGxPWlRmVGFyWktFMGh0bGJ6YWoxb0paMFBTMXNNWHZuN3FG?=
 =?utf-8?B?SURJZC9oWnBBVWE5aldoOGNvYWhsNnVXbThuMTcwclRzQzFxeEhGcHpXWWt0?=
 =?utf-8?B?QnUwQ1VnM1RlMWoxQ1JyTWJJblNoSzg4TmxmRnY2djA2M3FaVUZMZVdlOGdX?=
 =?utf-8?B?eG1zK2trMG03WnFwcUZkSG1vdXdBcVRGOGdUNktDNWhvdnN5bm5QM2IzRUlC?=
 =?utf-8?B?NytGVmh5TjBwSThJRk5KNDVVY1FGVDlOb2dIRlZNR3dTRXJVek9zemxZNHE1?=
 =?utf-8?B?aGhxUjdreHZaT2pSM3FQRVd2QjFOUWNLeWxMc0pTTklFdmxVRHJmaXNmZmNG?=
 =?utf-8?B?OHMyYUhWT3J0R2NsTys0RmxQK0I4Yjc2ZEhWbWJyTmhQdHRhUXRuODRwSjZ6?=
 =?utf-8?B?SUg0SElXUC84YWpBZ2hJOXhIdnQ4RXZ3UnUxcnJsY2tjeEdzSVJ1NVhvNmIr?=
 =?utf-8?B?Qk5MeEJvTXJWYUxnZ25YZlNhKzI2Vm8rN0JHb2tLaEQ3Q2lKS2VXTEtWWWF4?=
 =?utf-8?B?ajlnR0J2VGY0M3dTcnZ4TDJOclVaVDBjeVdENUpqVGlFdWNYcTF1OU1TMXhM?=
 =?utf-8?B?eGdmK2xzbStHOVRMb3kvenBqdVVmUXhFN1NObHJrZ1FBbW0zcEpnL2pvU20r?=
 =?utf-8?B?Q283S3VPcmc3UEJPVEc4YXJQalBSVGI2bXVReFNHV1RlZXZDK2xyR1pWMFFs?=
 =?utf-8?B?WXpUOWc2dklzQjJxcFAycE9RSHcvbWlHU2syUHBxYUFMdVhUK3BZTWJ4R1cz?=
 =?utf-8?B?RVAranRmTEJ6OGhDbzhIZWFjOXV0TGpFQm5sdmt1UEs0MTE4QjJzU3J0Y3Vk?=
 =?utf-8?B?QVFGRXdncGFRblpROEtweElJWWMrdE8rSlBQVEYyb3BscmRqcVhlUUt5c0J6?=
 =?utf-8?B?ZkJDNG8xYjBkTmZSN0JUckpsTWlScWNzcFZEM2s3bVdia3pLc3RveTM4TXRi?=
 =?utf-8?B?dThZUFZwL2JxSHJDRWVtQWY4WUV5THRVRFFqbys1K3hqRVIyVHAvSTRpMm5k?=
 =?utf-8?B?R3ZVSlRZSnMvNlpUVmRuN0ZaM3BLRjc5TEpBcWI0SVErZTRUVVRnY016U3cz?=
 =?utf-8?B?VE03NGVBdGtQeTdvOElickdDa0FkWjVFbURqZmVZd2pEMjZNdG90bWpDaEVk?=
 =?utf-8?B?WGQydmM2WW42UFViT1QrdjM4dUN5TDJFWXBQMFZvYUFsK2tDTWFOcHdNbUZ6?=
 =?utf-8?Q?3AHFSJvqAbJbYuoW+oqNsVqVP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecf27f1-d592-42fe-dde6-08db823d3f02
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:32:56.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktTLCBpDfJwWA7qa1EGxoq8Vg8ZmO1vH0uc1aAW7E50ZmyVJZKYjpUQ9rZwsHrakXYlmqtqPXcepHs0j3djq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
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
Cc: JinHuiEric.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-07-11 13:19, Jonathan Kim wrote:
> The feature to save the dispatch ID in trap temporaries 6 & 7 on context
> save is unconditionally enabled during MQD initialization.
>
> Now that TTMPs are always setup regardless of debug mode for GC 9.4.3, we
> should report that the dispatch ID is always available for debug/trap
> handling.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 1a4cdee86759..eeedc3ddffeb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1941,10 +1941,11 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>   				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
>   				HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
>   
> -		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
> +		if (KFD_GC_VERSION(dev->gpu) != IP_VERSION(9, 4, 2))
>   			dev->node_props.debug_prop |=
>   				HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
> -		else
> +
> +		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 4, 2))
>   			dev->node_props.capability |=
>   				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
>   	} else {
