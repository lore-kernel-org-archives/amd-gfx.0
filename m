Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDE9C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 16:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B4410E1DA;
	Tue,  2 Jan 2024 16:35:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407B110E1DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 16:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZspiyTGQ2+MjpYBwqIfit446j6PhTyjN3Sj1AN/CSDF8iAqVfdZPTOb/lSBs1blwKhjIqU4XGXfucqDbQ092wteLyOuyrJUSUluItOqFwORgHAD7e11/5Un65SAIVsIUmJc1UWO0hGnxBqzpMklAj7//7ktTcsMv2GRNMYUKoSP4XAGXeP6A0PnU6x9wX7Jgh0GQRXHNQoJlQ4UgpcMJCAa551Pcgt1L3NOANLmkuBlp3IWoI5IB32SY4OvAdEp0qUBChcPYsCoY9DnitcDSDI9bNzHOAwnxCcGiCVmtBCvpKdfD5FjdBozaHv9tOoFJAGaJLyqMklB1nuTc+Rndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+OKRkDC5FNCgYEEo3ZKqCp6zVLId9L60cuq1LxtEFY=;
 b=AW30DZ/wlVIWo/BNTzBCOIryRXmmzNHb/C0jO/k3kMA5w5JKtIHquoYMjPEHd8LmM8qFJkJj/3YpQnxqiBzYqnH6XtSyvjKyhpgAyjcxdYBCBHFo3ATh0EcPX/F08twjiYdc5kR6z4tXADQEmee1zy+Tt9fiiRtZp48O9ELyFtwafU+WDf7bJQW9AlFi98eWx2IjiAJYogWr5d6NFV2uzAbUKNbdvu09ikZ8RFHQHs5ZOjMHKuD3APxJdTzEedqlPxbkWu45Rh6KYdCnjU+zM1f9OzJsibv6x5ZhB1uByUd71SDY8WntVF5A9dKqr4zVr83xz3kWZ7AH95NuS1r4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+OKRkDC5FNCgYEEo3ZKqCp6zVLId9L60cuq1LxtEFY=;
 b=f8hOFNDqyi0keWg5D1SXc8C2z5xcaV2jKV9o+V5EyKahP3OEGGu+Y3NuVJvH1o8WLdHUVTGo+VqDwiybB9sFElPFAJCvGuQP+RaewgEqnn8NzWAYq3XMU9UHSajRVkM56RTkOgYIiq1MU7oRwJ+nkG/ryB1JUaG4eCiV5J6H/XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:35:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 16:35:47 +0000
Message-ID: <e5ad185c-7779-4f70-9cda-636f8c9f7318@amd.com>
Date: Tue, 2 Jan 2024 11:35:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix iterator used outside loop in
 'kfd_add_peer_prop()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231229094326.44657-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231229094326.44657-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b93c6a-13d4-43df-b2db-08dc0bb0de89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXShQNZuMIsyT8aGF1uYiTON5w0qSHkNeQVWabUEE8gyt7rKFieY/QDdUn0Af/AxzGJDlEjTw6hmOEM6duyZ0AJTJiJFItdmyJnwSTinFJXMsjRAFRVQO1Glb6zySENYnFd2EXntPnkAAXX1Ey0QggQFetqWvjHzcDugrhdAGggBg30gbi29fWK22WtvN+toEVrMjOkHG1U5hW8CiiR+dQFCgRzvqFQ6RA3NJUCzQSM8Zh39y1pBWtBtmkHtGGx0k9B1MaG0mfy1P1SmEnW/hTik8MMU/5sy3U9rpBQ0zztoI0AmGJbp5t+aiEctLZqIeJkHZOCYmWDa0/63Ds7hZkb5xI9eP1FKlKASHQz4KZ58Gf03bpHrdWtCSWiZZ2cFr5UL4n762Oe63pCmBxNYxPEENxFHdaLcH0LkR7BHmxUR7OXwzA+lFcVhISEiaAqP5+DnuOC6Ov0GbCSRBr0oYqbLXV1rvuBnBb79+z2teVxS7a+aWhO2HBVkswfeukTytZ+LMBdTwNmL+15Fz7y3eFHzalcwrAeMm6LjdDDuJBQw6g9hC6LSqTRjFOO6srkYMN2UEAAX4vLr2sQLQW6RcEeCa1nCxOfv05aEBWe2/tSow8M1iEvbkueDsf5h5ba/a+o93T/F8xZbgxGQ9GL+Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(38100700002)(110136005)(86362001)(31696002)(36756003)(6512007)(83380400001)(26005)(53546011)(2616005)(36916002)(6636002)(6666004)(6486002)(2906002)(4001150100001)(478600001)(6506007)(66556008)(66476007)(316002)(66946007)(5660300002)(44832011)(8936002)(8676002)(4326008)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9EdXpIM2w4WmxEMVBXd3dsL0U0cGc0ZEY3eC9iTUd1MW9aN3F5d1JnUGx3?=
 =?utf-8?B?Szd2N21mK0ZMSFF4N2JFb1kwYk5IVG9YRzBXZnJmdWdsc24yOFRiREpNdmcv?=
 =?utf-8?B?ME4xQnY0cVNmZWN6T0I5VHAvZTQ2MnlKbm82UDZBeXcvWHprazRiRFBML3dV?=
 =?utf-8?B?NGRZK040TERINHF0K3drd013bXhCclJRVjM5UHdiVVBiaUxaOHdUT0lhVlpR?=
 =?utf-8?B?SUpDdHp4THFid0NkZDJMTU9RMzlacjRjNEdVZGFvd1NMMzEvalh6akhUL0Ix?=
 =?utf-8?B?dXMydFA5YnJOTWJFRDN4a3dCQ25iVDR1M0tsQlhmT0Zma1ZGRDJLZXZicTVP?=
 =?utf-8?B?VTVlaGtYR01PVmFCaTE4OVU4blRvclB5YW80b1lYcXhhUE1jMkJtdExtaXdq?=
 =?utf-8?B?TSttYUJwSm9IeU9Ec2RQU2l4UkltRHRUZnE4dVk4UWJRRVhLbTFMcmdyZkwv?=
 =?utf-8?B?bm52eEdkOWw5VDhVMWthVzUvZjJOOEpiSmprdkxjMTJGbUdveWhPL3hubFZR?=
 =?utf-8?B?SnBXSlZ2OGlORE1CaTU2NnNoNmlFM29IVUhVZ0FCNXJPL01KOGRhaGJlUEN2?=
 =?utf-8?B?aXJVcG1jSU54NjE4cWtKdFAzTXVZbEx2MjAyOGVGZjBVd3V5YStwV3d4akZi?=
 =?utf-8?B?OHFINitJdFJtTjhMVFRFN080M0M1dzBwRmNndFNVaUdLOERTOStwZTNoNDFH?=
 =?utf-8?B?TW5lUkRPeEhIZjcrK2dDS0t1QktaSk9aaGY3bFdKUWRPRjNKLzI5emkySXQ3?=
 =?utf-8?B?UUFuSEpWUndFRktaazNGcUJWeGNrRE42Q3k4ODYwb2sxL0IzOENFSTE3OHhS?=
 =?utf-8?B?SkFjMWs2Qlh0SHZqM1JSaW5hT2EwckdwNXdYTTJ0UHIwbGdpMmpYNGl5ZDh5?=
 =?utf-8?B?QVBNQnFmbUJoNENVcE05UjRJWlpaR1FCS1pLZm45bDJObG9aVk5XaVMzZ3lC?=
 =?utf-8?B?dTY0QVg4K09KL2FHdnZEdGRkaXI5eVNXTWJsbzJmbnk3NXd5OGszS3RqWUhx?=
 =?utf-8?B?UWQzT01jdHlwZ21jb1VFaFFIS1ZBYTJjYVA4QndkeVRZeTFtYm92Z1NWNHlt?=
 =?utf-8?B?NC9ra1VxQkgxTHNSNThMbUVzc0VaTWpId2JrVThVeUdxbmZPSjR2UE9sbkVM?=
 =?utf-8?B?NTh4dEdteHo1aTlkU21CbzNTZ3l5UTdqVVBnYjhwaGZqcUlnQ0ZYdkZGR1hY?=
 =?utf-8?B?cDNiYUNNb096VUhzNDhUeDZqMnRXTXFOZCtkKy84bGptRnozNitzTlF2RnlO?=
 =?utf-8?B?cC9vWXdqNWpWb0crcXUzVElZRUV0eVBJcWpZVUhiQXpzN0ppS0R4d0psUWNK?=
 =?utf-8?B?ZCtweUtxWkR5YmNaN0x6YWl4UXJPVFhEbUNBcUluS3B0TUJVSVR4Z3dGcHh1?=
 =?utf-8?B?VVVjSE5UNldOVXVVRmZic0lEendGM2ZDbjBqSU5hMkc2T2VPU3FRM2ttVzJK?=
 =?utf-8?B?Vkw1K1hCcWJMSlV1bCt3aUt6STY0Ynd5QmZJQTZnM3cwSmhrbVptNFJyTFY4?=
 =?utf-8?B?QjNXcGVwR3BJWnc5dlhuRGNVVTdEVGJuazVOWHVSVk1NMnFUOS84WnpkWllI?=
 =?utf-8?B?WGRQR1d2ZEk4U2dEaFJBdXhuNzAzZDVtcUtFUU5vZXU1bjF5WDdkVUJJdFd2?=
 =?utf-8?B?RzZuVTRjRWZTL0l4L3RzODJwQVVldTBST2REOVE2cHNlSHR2UDhTczRHNk1W?=
 =?utf-8?B?T2FUaWlmZ0YvV3d2RVNZUDl6a1Z0WXpITTRQVGlYYyt6R1IvSjAyRkFGR0dh?=
 =?utf-8?B?QlBFc3JWZjRLZDhjdXdKTEVKR0lmOWpWejl1VVBmT1lBRklTOFJEdzZoeFdJ?=
 =?utf-8?B?Wm14M3NPZW8zS2tEMkRDL1lxWEtVZDc2Q0VybG5UazRTOEVodkZSMDMxdXM1?=
 =?utf-8?B?VW9mRHh0RDRXZkN2bDVRbVZyWHhUUE0rdHV0VC9nZTlXbkwrYXRCTk1jWXhH?=
 =?utf-8?B?TWJ3S0J1cldwVU84RW05SHpUNFd6bGtaRTZidkl3M1QzYTVoQjdISzkwYUtX?=
 =?utf-8?B?SHlCZkFIWFVra2hxT1ozMjJJVzFKNmo4dVZ5a2Yya2tqMUxwdlJNNzdqc2dq?=
 =?utf-8?B?SlV5eXlTSjR4RHBaZW92c21BMGtFYzJJc0Z0TlMydFJDaUppTWFKU2dpRmpm?=
 =?utf-8?Q?6Ghgik6QYU70gIiwKH2HbtaOJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b93c6a-13d4-43df-b2db-08dc0bb0de89
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:35:47.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyEK9bn4gqrZ3cA5NCFAj5CU9a3h196PGpKJZTglNmqC15VkJJE38KLvcRKgxJpQXCHSicl+5QR1bKabqj6Icw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-12-29 04:43, Srinivasan Shanmugam wrote:
> Fix the following about iterator use:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1456 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 24 ++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index dc7c8312e8c7..68640e46312f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1449,17 +1449,19 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>   		/* CPU->CPU  link*/
>   		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
>   		if (cpu_dev) {
> -			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
> -				if (iolink3->node_to == iolink2->node_to)
> -					break;
> -
> -			props->weight += iolink3->weight;
> -			props->min_latency += iolink3->min_latency;
> -			props->max_latency += iolink3->max_latency;
> -			props->min_bandwidth = min(props->min_bandwidth,
> -							iolink3->min_bandwidth);
> -			props->max_bandwidth = min(props->max_bandwidth,
> -							iolink3->max_bandwidth);
> +			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list) {
> +				if (iolink3->node_to != iolink2->node_to)
> +					continue;
> +
> +				props->weight += iolink3->weight;
> +				props->min_latency += iolink3->min_latency;
> +				props->max_latency += iolink3->max_latency;
> +				props->min_bandwidth = min(props->min_bandwidth,
> +							   iolink3->min_bandwidth);
> +				props->max_bandwidth = min(props->max_bandwidth,
> +							   iolink3->max_bandwidth);
> +				break;
> +			}
>   		} else {
>   			WARN(1, "CPU node not found");
>   		}
