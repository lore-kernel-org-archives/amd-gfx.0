Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE56C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 13:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A89710E324;
	Tue,  4 Apr 2023 13:59:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FDC10E324
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 13:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcYUKpXjhE0MXEuU8eLlD1OPn8PpM+r4Q8SGEcMUEw8wQ6JoCdGOqNVGY8k63+c4KI9h7heeIfFqdz7H1pN6X/p2Q1jvNIV354/Ei7lK5+/e1huty3swc2IC7tVe4PBh/8adIZ3+UKu9phzPjrEC3FJl1TEKibGY1/887BhLDrEDtSHopsy0mrup0AEBnokTP6bQSFnlCdsZGBk9Oj+tqu+NHtu3J6NJARyrhMZNiLHL2kT74RyOgKFsLWMAPCBeKoX2Jzd1jarPz+1WAfU0Td+Taj4Udt0eHwYQFMAEUxlcX7iWoPkSoQsy788NZHNp2oviQBkEXfHPyZP1iJSf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghUDKr/HH8eMaT5SgI4mlKyBZBC6LBgfHAeDM04KOkU=;
 b=X/fuCbT8+FRvbRkUEmPFurzkqVnOrTxKa5QpICklgYAmIiC2LBMFTKH16qR0T60ukqxEBrWnkGqObGlho0RsTzcTTXAJ8ym4udISyPIFWgQcV8E4TnX65Gwo1jzlOL6Sgo315/VgTgpxbLxKjs0G9jl9xF+xLzP8UICkUa5WP4yiNnXuJHugjCZQcpoic50WIsbd1o9I4JrbgvcnASywzl+TF+m1pHjzaQOkyJKDdtp/9qFqcOBIGYUo0p25b0H2Yt4GCH7pUGvBNnJgGmiWOITtTU6XqqEIc5w8pWe+vT0E7IhK14VPdBqgtnOPOLrt3U6nJm0snLzJc0ldwLkXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghUDKr/HH8eMaT5SgI4mlKyBZBC6LBgfHAeDM04KOkU=;
 b=BLe9o2uuOOYZJPxMHCjFZos/Rqy/HcoCGHiQrArW/QIKJ5+XQgFME/XZhsLRP22jIO9YQDrTzZWK2fhODf9YAuwcC9pnhL7xShwXquZoVeGuFCEilPoMMFgAiIFJwr5l7NzeKJbCgHmpvelQPAxz3Pjw9VX40/0SydDxkodWzvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 13:59:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 13:59:25 +0000
Message-ID: <73dfa0fe-4ea1-26bf-cf49-57b4f873a765@amd.com>
Date: Tue, 4 Apr 2023 09:59:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] drm/amdgpu: DROP redundant
 drm_prime_sg_to_dma_addr_array
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <20230404095640.3277840-3-shane.xiao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230404095640.3277840-3-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 263f3549-ca67-4df4-8819-08db3514ccb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNPU0Lq6zpBdfdHredRjc0wlYWgtBwjSpF/6XDwETarFGYbb3puJ5NbdGTcCs5IVtJ6xehHcCd0zUD1elZ509KazE98KR6si1TYndzJFFIxOyVXZpBCruJxHQQMTrLemZD2x9E7V9WlXAKUkvRGZMmooDJ/RdoEB6ETxAMp1dJ4tTxpykcX40vohz8OGMQXVFezZGUjDd1HBR9u3pM3Oqea1d+OCph6mT9a2ZPZ9RegPfQ82UTCHaQSxCKN7n4PUeFseedrhPChWvvI+73BzvXXEx1KVuJfqF5FfuPyj8sZFCHCRIs83XEPOeP0xtjEjdPOF0gisFHAL0JX7uMBttCf46J0kk3esf3i7KjpqE/cRFJvqErhgPvZBRITedvLIEeLJMBaJdmcU3OS5ap51DMzx0q4a6ScablCJw4w8NJtJ2y6awbzdarwtlLDluIo36d3Jdi0NRRkVqyojvqI1q4o2wUqzuyCXBFtPC7dD5AqKlEjEtAfa5u+c3UBVBkQKeq0drmvHjsBqKf9PR+OaaR0dOc2rVe8KY0pfQgqAaWdod9sQ5bZ6dbrJCrwJ8AJzR9qftrxUauiGDISdJYN9ZTQqY9msiReD11nmP8DQg24wB26NUg6vHVSSNs31TxlkQ+Qa3ZPy85G+DMTKBSjDfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(31686004)(6486002)(66476007)(66556008)(66946007)(41300700001)(8676002)(4326008)(36756003)(31696002)(6636002)(478600001)(316002)(86362001)(38100700002)(6506007)(83380400001)(186003)(2616005)(6512007)(8936002)(2906002)(5660300002)(26005)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkZ3bngzaVczT0htUVR1N3A2c0dnaS9WWlhCcTd3cjVpTXFjazhLQjRkUjdS?=
 =?utf-8?B?Rll5dlh3RjBVVnpFQmt3clVHaWo0ZzZ0YSswbmZwTEdGaTB4SEFCVHNOekNy?=
 =?utf-8?B?dm9tSlpqNUROWERyN2NUejJHbUF3TnZrZVZjSG9OUDdDY0RyZEJhUzJackp5?=
 =?utf-8?B?ejhaNi9mSWp3MmFMaU9MK2pTekN0RmErbjA2akZLVkM3dzFlYk5ydzNBV1lw?=
 =?utf-8?B?dUhRY2hZR1JqNlp6RkExTE9uRXRVb0JMZ1VGdmdFWVp0L0JJeSs5UzBwVC81?=
 =?utf-8?B?VkVuZ0tFYTlHMllGQ1hEd2ExcEc1c2RxOW4xVnJKRTRDN1lYVGFwVmRMcmlo?=
 =?utf-8?B?aldqbzE4WG1wYzFzSXVNdFQ4UFJnd3NuRjNqMG1jUXhtZEJQanRESm1TeG1V?=
 =?utf-8?B?M0pVTXBvemlRaDNNcDIvVVA5ZVZud3RjcHEwVkwxYmlKUmZ2UEVxWVRDNEtH?=
 =?utf-8?B?bXAwdVJ5aEpMMFJ2bFhnUWJFUHphYzZCL0JwSUk4UW5veW1tNFdlOThWVW1Z?=
 =?utf-8?B?eTVydUpSSmNzTzA2QUZ0c1g3NXM2UjZ5QlJjMWNYVFhQMWZCb3U2VnBCTExC?=
 =?utf-8?B?QVFNdGNWWDFaZVQ0TzhxU2NDRzBYOXhJNXBuR1JSM1RXOE12Q25LbDFhZUxR?=
 =?utf-8?B?anVxZDBxNnkxbjJYTzVFc004WjNaSndxeUV1OElucDdabXFJd295WDZkajMr?=
 =?utf-8?B?SW91QmxiMjJkWUVZQktnOU5jcjl4M01aT1grZWo0a2krSERaTGVjdkM5MWtl?=
 =?utf-8?B?cDROcUNPTGs3Tmo3aFNPUmlBNUl0MnpNdTQxb09wb0NPRmRPOVViOGRlbkkx?=
 =?utf-8?B?TWtYQkxyYlUzVW9wYUtBaXpKYXBYRGpTazUxK1ovSVFpNnBsTGRqaEFyd2gx?=
 =?utf-8?B?SXRzd3N6ZTNEOGI1dml5NlZ5aWx0RThpcjZEN0I1MUhvb3FleFF0dG9wOWlR?=
 =?utf-8?B?SEdaenRjbWVqaU9SbWxlSE9RNEhIOVFtZENqRVBDcnE1KzIvU3dCaUNGcFlw?=
 =?utf-8?B?NUJocFhMYll4K3hhbXBnRzBPTk5vR3B4QmJIaXppZnV0QjVtTUNKOGpGTlhy?=
 =?utf-8?B?ZHhkVkZPdHJmQlZaRFJIdTdNdi9qNkgvbDRuSnQwRW1NM2d2amo0T0FSNXJI?=
 =?utf-8?B?ZGpIUTlMY09VNVQ4ZlNKdXpVOWlNU3JOYkJRaVhCMDVvaFRlekNqb2hXejB0?=
 =?utf-8?B?em0vK200NnZMVVBiV3ZtdkZvdjlwZktWWjBkak13bTVXKzl3TmJUcGQxNU9C?=
 =?utf-8?B?TjFLM2hnSm9PcldJSzNUQWNtbWs2eHEwR0FQTktFV2k2RXpJVGZPR001RmJZ?=
 =?utf-8?B?dVN1MUlvdTZjM0hrS09ITUZ0Y3FKcmhwajhBSndwVkFqVmN3d281TXNMQnIv?=
 =?utf-8?B?akVXY2JIRG9jN1NpMm9TenJ4VnRMejZqdlZIZ1R1T0pDdXdPNkF3VTZHb3Fl?=
 =?utf-8?B?eTh5d2ltRFFqK2t6YVFPYVE1U3hsa2pHUXgrVDVieUJNcjk0eVU5UHVORmMz?=
 =?utf-8?B?bzVLYk40U3dxcnV6WTRBLzUyaGwwQ3RyY2xTTi9EVWlRUjJYV1FqZjZ0M0NW?=
 =?utf-8?B?UzFaY0ZEMGlqSDFTOWZCY3ZpejNOTFVRVGx4TVE0RmszVWR4T0h0TG5VcWU0?=
 =?utf-8?B?ZGxFSU9hcE1oVG1IYUk0WDNCZ3lKNHlQNlJiREVlakZTNXpVQUF4bDlIRllE?=
 =?utf-8?B?MU9HSFlEd1Bic0ZITHZVMEYzVXZXblpmbUpQYkRCN0hvcnUrcE42VVd2T2FK?=
 =?utf-8?B?TlVaNURnUWJJUkdtVWltZzYydzdnUEFXYjNhd0d0aUtUNDJOUCtTVmI4WW53?=
 =?utf-8?B?QlZUeU1YQ3FWVS9TWXorRVpGbGErbEErQ0NvUmtJejRlVWcvdmhybU9Nazlz?=
 =?utf-8?B?SGtXZldQUENsNUlKVnloQURtYzdNNUtwc2x1SFNYa1V2eS9vZkJ2NmVPbk5W?=
 =?utf-8?B?ZVNvOXBnaTQ2UEVkNDlIczQ4SVUwZE5FOVR0TFRYSTVuSVpadnhGKzFnTUVD?=
 =?utf-8?B?dWRwK1hJNE9DMlhDOFkyQUlwWmJCOHNiNnFiUDFOdUF2RHFKb0xpYTY1anFE?=
 =?utf-8?B?NTBnb1JJUGw1dGp0Z2FnUThLQmZhckNkY2p2Z1BFOS9UMkNrUHAweXg4MDdw?=
 =?utf-8?Q?bAlScKpULkuS1kwowmI0EPayD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263f3549-ca67-4df4-8819-08db3514ccb3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:59:25.4534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x902FsW75SuM1diZSyHchhAzeSwemrtN4VP+0YaONMYcDYObZPGissrtHqp7fnEuWnZWTB0/xsBXmk6WVrhgwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
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
Cc: aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-04-04 um 05:56 schrieb Shane Xiao:
> For DMA-MAP userptr on other GPUs, the dma address array
> has been populated in amdgpu_ttm_backend_bind.

OK. I think "has been populated" should be "will be populated", because 
amdgpu_ttm_backend_bind happens as a callback from the ttm_bo_validate 
call below. With that fixed in the patch description, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Remove the redundant call from the driver.
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index bcb0a7b32703..94ee8f638c12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -488,9 +488,6 @@ kfd_mem_dmamap_userptr(struct kgd_mem *mem,
>   	if (unlikely(ret))
>   		goto release_sg;
>   
> -	drm_prime_sg_to_dma_addr_array(ttm->sg, ttm->dma_address,
> -				       ttm->num_pages);
> -
>   	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>   	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   	if (ret)
