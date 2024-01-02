Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD3C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 16:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71DB10E1EC;
	Tue,  2 Jan 2024 16:53:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E4610E1EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 16:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+P+50eMLJmtE1Z2ZiCdQzSuZYOUn7l/k83k9IPN8GB/Fr/5k9xLot0R10WuioiYZjbITSHbmLWO4vdG5V9xEtbH7NRbXtGQ+TxlKvH6LS/kVztoStyWWFTX2msDbITVNcUcZNl2adT7TiMncdKxUcH+4nzTI7Envrc6dWbaz2Xe5FrOMuRaowJTlzcrwbaVp1BPTxcPz9wrGtW5HpiGddNN8nnxLrDwgJmVcFns/7syJF0vyXJRAdv03F9npoA8Kq37ZIPdxEsy1NeQb8Z/K03jZJ3bFndqUndp6FTpAwLYWmj8CWCTh87HfHHOnoExaV3EAOx6R/UGNmN2N5h+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KtSPtcAJRxW3LKXdO0p0vXBbu82QwBfgLOIm53dsJA=;
 b=QrE3k1I3IdSxRFyXLFswK72mtm1/O/F9/ChGOj39hvyxv8mYRdXS+akMqxoCQgGvXREsh8oSRlYrRxYZjINijEJ96VZOf13C2/qE3wXBEij0Zg5W1serLOcoJEKUUjB+kFP96KkzUii4PT35nCHoiC3nRF8ERs7XhhzNKZMSPNEAb/BxPmJDC5RDTLSYJIciwlgKsh4VO3op1u/ouyoQvNSyerQNr6oS0JYCvxjrWwISOhUj18ZQeL9TPT6LKBh2U6b/7xz5EqTq1oaubznemGlD4omvxZF8Lg/TITI/x1qo0hqnk4MMDF83nv03yWGpNyU4xg4SIxgl+xge6TGwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KtSPtcAJRxW3LKXdO0p0vXBbu82QwBfgLOIm53dsJA=;
 b=PAYpBJ49GErvDXYxaM85RD50S3gdKKB349/RbnfXecvajbAUfUfw55broVIO3iY3ftU7rfjddzQDCa82e3jXI3NAu9yMd+EeFTaGGCyM/6sSZKByzWs7MpbQDNd8t9OtaeJ+wPgXZHt/UaCJPtphZ1TPa6sVM6ON9I661S0NV7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:53:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 16:53:11 +0000
Message-ID: <75da98e4-bdef-405b-b7d3-2373275e2cb5@amd.com>
Date: Tue, 2 Jan 2024 11:53:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Confirm list is non-empty before utilizing
 list_first_entry in kfd_topology.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231222115339.1689926-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231222115339.1689926-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: be971b16-aadb-4eec-ed93-08dc0bb34e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qy04iel18ux2mnjfX490QlGd5YOUI8pUHKo5VDHG05Lpl+DQdBZUmZpBGElA/wW6wcjHy7PHvvM29gjZSeszO4EFjCFekaNr92d3+lxPkR0MCMv2kGpjBDS1dar2FxaddksQzg2moG2fpWehHyQtQds760BhkP+ukCoJNaZ6agX+WxPLX91w54kmMS59ks/Ehy2IdlALXM8An6yU92nCfkzAbbG6OpoZSJzrQH4zhPrnT2fIC102Y54iDx7h8tjm2JGe1YaU2fM5Tjji8w3v3jm2PsFeuSy4JbU7HpPP9J6cRHSuW3SBB8+C7+r1DiPC1b9N4ndWmia+6yfhDTYF3VE+retFJB5A9ZiaMowzSZeuGMEQ4ukjIu0hRL00wmiMV4RnC+o05/zNJ4IwEkPHT7NhraDwesnDv92pHZJeDa7E99G1agpVxRgKJ8UvzBdaEimaOfS0Mi/zv9uOlu+ZKsIm+xD8ogc9ySHOIlxpXo4OP2sA7p63JbLOtMPL9t82aTb5bDDK8wvCchIMI6zDGDoLzM9PZrgqoJ240tFYhY2gFPCOQ/3HCK5iPahdNGdiiDOiniXuaoQIjY80CejSdZ5NyEb7cZmGMSOGb2JrWNoQHTfz7ubbUFgxfyXUOuYntHxdlCslNAPbykFdbP+fjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(31686004)(66946007)(66556008)(6512007)(6506007)(66476007)(53546011)(6486002)(31696002)(86362001)(36916002)(83380400001)(2616005)(26005)(4001150100001)(38100700002)(2906002)(4326008)(5660300002)(6636002)(478600001)(44832011)(41300700001)(316002)(110136005)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZkcmRGVDNCUTVoWFJWcmladnkzZFFtbGI4QkNtKzBCZXQzZEozNlZLdzJp?=
 =?utf-8?B?NzVpakVDK29hUVZlaXUzd3hnZkpkbFdVQythS0huOHRmVXVieWFlcmZNQjVS?=
 =?utf-8?B?WUFwbnhaS0NkUDVwOStYQ2IrR0pDdGxoWGVMS2ZNRjF2L3JMVWo0eHdZcllV?=
 =?utf-8?B?MjZQV2pEc2wyVnBlb2tsV2MwamgrK1dXczhibTV1NzhhYy83Tk1WMTI0OWp4?=
 =?utf-8?B?VXVYN2VLSm9FMm9jNHdFNW5xb3pTNDZLaVNKSGNVYlJoWmF2bVRsODlsRlNy?=
 =?utf-8?B?cHJWOVlsaUJNVi81aEVtblNjZzhKM29Nd0JDR3pjVlBKS3lZckdBQUtuUUE3?=
 =?utf-8?B?Ni9ORUtGYlVrMHZXQm5hVlJZcDRVMEppU3pqNjZXYTkvUzg0ZXVscWZnMU9i?=
 =?utf-8?B?VzN5VWpsNnd2TnBiTExZcUN3dk5aN0ZYQlhqTHJjamU4UUpiak9SVTR0SnIy?=
 =?utf-8?B?VUZOVW96ZHFDWks4OHV4dzdBeStFNFUyS2MvNm55UVhHYmpyK1JhZCtWR3hq?=
 =?utf-8?B?T24vWVhVKytZLzZGREFXdzE3ZWZ6UEhiYmk0SzBXUU0vRzNXSjlkRU1IdW5n?=
 =?utf-8?B?Y0NYNnZuTVlZTGpNdU1vRGpHQ2N3WmVtZTVpZU0wZUtxdjgzOXJuWGxVUEpU?=
 =?utf-8?B?TnR2SVBoV3Yza0g0R2g5MjhWUXBKODJ6cVBSaHZmNXdxTGtRREhpeTNabDdm?=
 =?utf-8?B?UHhlNkZSZmJxTmJ5UnJ3T3FDZjIrdVVwbjR1RHBFWUtXVlFUeGJnVlJsRkRW?=
 =?utf-8?B?NXp2TWlvd0NGN2ZMcHB6ak9jSk9BUXBVNDF0SVhsMUJCSE82VWdQU2tLcElR?=
 =?utf-8?B?aFNVdS9YT253SDcrQlVQejc1bGhTdVo3c1BtMkZPN3JjRnVsU1hqbCtOQlFi?=
 =?utf-8?B?eXJOSjlCeTNrQTBKelFicC9hTDk4ekc5cjdqVm1JeW4zdlpsckV5Zkg3UW12?=
 =?utf-8?B?TzJURU96KzNXd3JtVFFrN1BsSDZ2Qjk4RmRUNWd4aU5ScFZvbkxYYmF1N2pT?=
 =?utf-8?B?R3pyR0ZwZndScVlqS2VsRmNzbUdwU0dqbWd6UDYwdzZwZS84RCt6ejBoYUVh?=
 =?utf-8?B?NUFMK2dlYWp1UVVDOUpBZFZsR0ZTSmdnbDhTZi9QdjlzRkdCeEZ0d3QvVThD?=
 =?utf-8?B?QjlCN3BUbXRQZGJEN0haSFVVWW52RzVWOGJGSHZiSDJGQ3BsblBWanFiNFU2?=
 =?utf-8?B?TnhIQ0ZKd241c1BydmxyQXpUeVpma29qZUtadlZEczVRWElNK2hkVDZ2Rzcw?=
 =?utf-8?B?SnVZbmpRZEx1d0N6Rlp3T3FKdmJRM1lXYys5R1FCZnppUXM4SVU3VVdOR3NW?=
 =?utf-8?B?VzFHM1N3RjlaQUdRMEJlWnVhNVVwME5mTjdXSUZ6aHhWWUY3QzQzRDAxV1Fi?=
 =?utf-8?B?dHlac2hGS1FDWUJKZ0hkQUdWaXFicUxNSHdha2xhU25HVGUzS09xNnozZTgv?=
 =?utf-8?B?Qk5ZVFFzQjNtSFZaeXNhTGZGTk53dDZwbXZtRjcwUlVDWTBUQTZrN1hXOXBy?=
 =?utf-8?B?ZEIvaW1jVnovU2lRcy96dEYzSGp2eGVkM3NuNDU5ZFNPeGdiM3pnT1ptUnVD?=
 =?utf-8?B?bDlKbmllOHNBVnY0Yitkdmd6aEVDNFhPWHBuQk53UFM0ZEdNMXZPdGNKVXZn?=
 =?utf-8?B?RHp1c0VOZ2ZwdDFDM01MMXhZaWdXdUoxdHE3c1NZS29iN09Ta2FHOUxlMGI1?=
 =?utf-8?B?aVNmVkJDTVhNNVFURFNOK3NJS2M0dHpwb09leFhlNllrcVc1ait3ckRZMVFM?=
 =?utf-8?B?R0xYWmJKMFJUZGFTTTc0Wmo0T1VYbEY0Q0NaYVNjU05uemFLQVNVTnVWU3RN?=
 =?utf-8?B?REVpa1UxcEdOT1NwYmFBWkh4MnpzSEtXY1FKNVc0d0p5ZGZWV3RaSk1zYVVL?=
 =?utf-8?B?OGx0ZGRhYTFnSVhER3QyN1p0Y2FGbVlhZmhFNGhPVm14UzZOWUFEWVhaLzBu?=
 =?utf-8?B?S1NaSk45aGtoWmFZdGNuWEF2K3VWa0hMQmxNVDBIUHEyWWJvY2E2WFlPV3o2?=
 =?utf-8?B?N3k3S1cxMTd6OVFxY1ZVTmk0NkRxSHU1ZXZEL2FKcEpiZXhSWitqRytNaWdD?=
 =?utf-8?B?UENrN3FFV21salJocUVQOC9FdXViRnZjcEh5eE9rd2pmS3h3c0pFQ1IwcHhy?=
 =?utf-8?Q?6xSMQnrs0r+F14KPW1EaAAY+e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be971b16-aadb-4eec-ed93-08dc0bb34e09
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:53:11.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWnNX2nIzuglzNJP/Lj67RtRjH4cAHNX9BgfVNG4o+DCPssISY317YvJBbyNylSsfXAwgmjKejIif0gsMUnWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-12-22 06:53, Srinivasan Shanmugam wrote:
> Before using list_first_entry, make sure to check that list is not
> empty, if list is empty return -ENODATA.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1347 kfd_create_indirect_link_prop() warn: can 'gpu_link' even be NULL?
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_add_peer_prop() warn: can 'iolink1' even be NULL?
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1433 kfd_add_peer_prop() warn: can 'iolink2' even be NULL?
>
> 'Fixes: 0f28cca87e9a ("drm/amdkfd: Extend KFD device topology to surface
> peer-to-peer links")'
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>
> v2:
>    Changed to "if (list_empty(&kdev->io_link_props)) return -ENODATA;"
> (Lijo)
>
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index dc7c8312e8c7..1fc9d4616564 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1342,10 +1342,11 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>   		num_cpu++;
>   	}
>   
> +	if (list_empty(&kdev->io_link_props))
> +		return -ENODATA;
> +
>   	gpu_link = list_first_entry(&kdev->io_link_props,
> -					struct kfd_iolink_properties, list);
> -	if (!gpu_link)
> -		return -ENOMEM;
> +				    struct kfd_iolink_properties, list);
>   
>   	for (i = 0; i < num_cpu; i++) {
>   		/* CPU <--> GPU */
> @@ -1423,15 +1424,17 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>   				peer->gpu->adev))
>   		return ret;
>   
> +	if (list_empty(&kdev->io_link_props))
> +		return -ENODATA;
> +
>   	iolink1 = list_first_entry(&kdev->io_link_props,
> -							struct kfd_iolink_properties, list);
> -	if (!iolink1)
> -		return -ENOMEM;
> +				   struct kfd_iolink_properties, list);
> +
> +	if (list_empty(&peer->io_link_props))
> +		return -ENODATA;
>   
>   	iolink2 = list_first_entry(&peer->io_link_props,
> -							struct kfd_iolink_properties, list);
> -	if (!iolink2)
> -		return -ENOMEM;
> +				   struct kfd_iolink_properties, list);
>   
>   	props = kfd_alloc_struct(props);
>   	if (!props)
