Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C523FC02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 08:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC4310EA6A;
	Fri,  7 Feb 2025 08:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kge8Qvfy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B982E10EA69
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 08:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfr6fn7/O95zGKv9d73IKn3d/XOJD6ybG2j0NzSB8DEaAJgQRI2EWkhacymf9+4YMgDPYPRkGfGIWlOlTL7O8GfKl8oBxJvE8zmSmxpcWs/IFiOilP3Ffvvzxjlv9rs+D1JbHTEXIKDjPIF6cF8mAOp8J6j0CIrQnaw0rYPNxoi55/mVrZBZJwb2TD1nM2AXQICVnQK9djxif6jomt+pJug9elMGFnQBU7YGexPMTBVsfOFGboD/DRDDA6AZQbmYo7mN0oT0iKX81Ri4AbA99Oc5hWAvOu7BXQaDc/3SZghKzqWx9N4aiDReZk7Q1kPraJZjE/bD+QbQoJfkmbHRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmv4S5QQih+shnvqpborUn/5/XuQ9FF9d5UQOT3O5Tk=;
 b=o/4pxIKgnMvp62j8sQUsciY4rgdTegOeRooDhufOi7qFQrcU7ZqqrJG3s4/JBbRYOhLbSJlKaMR+1J6Zgc3w7OvuG8KJjgVJ4VOmG5RtiiR+EFAYcQa/f6aPo+jUfpuRP/jyPXk7xhaMYO1HqimvEEYJMK0TymomiVxnpr/ROcTkCY9cIHVyg7iXUBuvSe99iC8deBdg94eKBZyRLzxVbSITUulMyj73hvcvs5nQPcJnU8NNgAN1zHHeyzdBnhomnjYZJSixPK6cSoGrvGBEyDIQ4ZVTwCzwKCSInlOwhQyrxcSKsBtrzuK+yhPEzFs0sJCeY8AoKPLewkVLt0fzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmv4S5QQih+shnvqpborUn/5/XuQ9FF9d5UQOT3O5Tk=;
 b=kge8QvfyjA3q47pDiGCCSsVHmA/KhaSQE6Vc+9usDxJxdESp2U4PGtgw2gzMrUZigNRi3WIPhOemg/FlIeoG+okr3RCFoOSbb81kl1xhk/3ulPhw+Op46uHTnQcWiCP/yljYRSO65WnS4RQMVK19SdReYwU+0cyaw8p8tpauiQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 08:35:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 08:35:56 +0000
Message-ID: <09430e08-e291-4745-9b64-a38ca719b4d7@amd.com>
Date: Fri, 7 Feb 2025 14:05:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: set
 CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 for sriov multiple vf.
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250207060320.1564404-1-Emily.Deng@amd.com>
 <20250207060320.1564404-2-Emily.Deng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250207060320.1564404-2-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 5806a535-4792-4d0c-be14-08dd475270d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkNpeXlrU1QxYTlyTStkU2ZtOHZNNm5xQUxCYlBBYmRuYTdaWjBQN3VkMUxS?=
 =?utf-8?B?T04rTW5wK2s1aXEwYnJwQ04yUXlxVVlBdFJxV2JybHdqL1JxUDFKT3Q1VDF5?=
 =?utf-8?B?VFB3RHJMcnk3MGFZaTV6QTcrVE5LMnFWTGd2Q3RoenlTZS9MZGNJbDdnRTJu?=
 =?utf-8?B?dXU0T1o4R1JXM3U4bGJwbEFrOTEyVlM0cW95MzFPaEtPdnlaMEVXVTBZYlh6?=
 =?utf-8?B?SlVMN3JIVG04ejVvRCthVlVMWGZDSVUxWTI0eFN2cDhGTjNVRzZLZi9BaGk4?=
 =?utf-8?B?V2YvVktpc1g0WjNrRVVYcnkzSnhYZHpXRHREeG9Gd0F3eFQvWkVWRnlkajk0?=
 =?utf-8?B?Q0FndlI3cmY4cnl2bk05cUI0Zzg1dEFlU0U2YnpHYUgzUHU5ZmluOTQvZHZC?=
 =?utf-8?B?REhUYjlBdWpOYXJPaW0zTnppT0ZHcE1pd0RUUU91a0VQNjdTN1hnUmNtcit1?=
 =?utf-8?B?WTUrdENkM2F2ZnZ5OUcwRjRaRWVVUWR1amhpSDdYbk9IbERTcGwvQjdMUGNz?=
 =?utf-8?B?WlU1WjdLdEVwamlaTnlUemlLMXlCVjdvQkdLRXFteUxlTTNPU3Jac1BSa2tu?=
 =?utf-8?B?ek5UeEJBZUFaWTZQRG9EQ1lBMXFvVGFSZ1R5SGJIVFFWaGdFNWNuNTMwOURY?=
 =?utf-8?B?c2lwZ0w4L3lLVGQ5dnNKWjJJVVVZcE9SS2xZdHQ0NERQU3JQdm5CRU5HRlgw?=
 =?utf-8?B?SXhjclVlVDd4VHNqSVNnZC9LU3UzMFhPNlJIYmJvelVwK25ZUmM2YWwyYkFp?=
 =?utf-8?B?Uy9DcWUvb2dodi9PVW1pNkhWaEJoN09BbDF2dDVSSUhTa2srVDlOb0orc1hM?=
 =?utf-8?B?ZElLNmZsOHlITVRGczk0bHZ5cjBZbC9NRGg4Zit2QmVoYUdJNzZlcllaejVG?=
 =?utf-8?B?dUpJbmg4b2VkMXJIdnZmeGpUUUQ1VFBrRHNyUERmWS9Kc2FEbjJPaTJUK3hV?=
 =?utf-8?B?aTVHNjVLV0R6RTVaQXUzcFV6WnRTQm40MmpNV2cwZkpCaU5PZC83Q3h5Wm1D?=
 =?utf-8?B?bnRWcFMxbGtQL0Nwandzdzg5Q004eFRTRExPejI1dXBCQk1xMXJ2ZDExTXBE?=
 =?utf-8?B?SDF3QkJGZEdzTFlwK25Cb3hsU1VlMWxCaFkveUVpUkI3N3g1TFVRSEp1cEhu?=
 =?utf-8?B?Y1VHcXpzSTgyT1FmdDMwOWxOQm03VjNJQmF5UitsbmhXcGYwQlZEeUNTam5m?=
 =?utf-8?B?TEsyd2R6UEU0RnY5ODNOeUpYL1lIVHEyUmhIRmVOQ3d4NGZ2NGpUYmpCU0NQ?=
 =?utf-8?B?ZmhyWnBPSzRTak9rdytuYytZbklzRGNYc2lGQXI4aVY2YW43eUpLc1dBMXNa?=
 =?utf-8?B?aWt1K0EwaG1LZ21BVmtoZVBLUUF0bCtxRFJmeFNKRmpTc3JxdGkrRnlFVGlL?=
 =?utf-8?B?U2prZmN2SEp5VlFLenJMWm1yQ1dXOHUvUDkxM0xyeXJYTWV1UTBtTFVWQ2ww?=
 =?utf-8?B?SlNlL205eXROOUhrR1VrbnBMd2hGQy9taTZWbXJrdEZiTm14VHFEQ0wzd3hP?=
 =?utf-8?B?eFFoSkRtazB6WmpjdlVxZkg0dGh0dkVCODJjTnRqdWthbDNjRjl6b2RITFBk?=
 =?utf-8?B?bmpLTlo3cC9BM09Ec1dBYlRKNnRLeVBVQXpTRkc3enRoVmNDaWtXTlRNMkl3?=
 =?utf-8?B?c096NDNUQ1V4cGFqVEh4c3c1cUQ1Yi9GVnVCd3BXcHEwWmYyamxuQjNneVFF?=
 =?utf-8?B?b1ZBNUxPdWhLM1ZYMHNqSG82V256WTgxTzJlWVZmdE02UWJiMGtKaDFWYmZk?=
 =?utf-8?B?dTdUdmhoamlUbTJjd0hidWdnVVdBZVQ2cXlCQlg3Y1loQ2c5dk4xdHF1VzRn?=
 =?utf-8?B?QUNhenB6bjROaDlWVHgvM0ozNndSbGtWNFhIZTNUUjEvQUQ5aktwY0VpcXNa?=
 =?utf-8?Q?BW2SEI0Q3vQM+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUVhK0ZCZDVWVk1IK3dneFR4L0NwRDR6Vkk3YmVWSEZEcDJNOSttQnBMcUhD?=
 =?utf-8?B?WE5tR0MxakpmRWw1MzgyTnFEWnppeTl1Sm5aRExaMFpKTTJrWXB5YUMzQk1J?=
 =?utf-8?B?S25vdUV2T2ZZeVJ4ZTRid0x4bGVDZmZVS0Q3c3FQWkdQM3p0cjdnL0Yzc2FV?=
 =?utf-8?B?L2wvL0prUktuQ285cFo0dnRoWkRPcDY3eGI0bjBBajdOSGJRRGF3UVVTZWkv?=
 =?utf-8?B?N0NYSzRDWTVxbW1PR09IcE16OEhUR2JxWXVpNFFWem9PMHF4NjZsMVBoZ1FV?=
 =?utf-8?B?b0kyTzlPUndmajNBcGtiTS85OWdLK1Y5Z1dGVnEyK2dxdmdaUldSc2w0QnlN?=
 =?utf-8?B?Ri8yeDhaWmloWkJWMGxRdk5ZbHNzc0ZSWjR3TVkxSWtwZm9yV1EwQVFZOUFM?=
 =?utf-8?B?bGNrd0FaaFkrNXBtVkRlSFpwOHJYcFhqS0k3dlVGcWpsOEVQTjJLZXgwdXI1?=
 =?utf-8?B?STY0ZEN3cWYvckh0YlQ2clY1ZUtQVXdJTEtVZkRoRkpWRTlCNmk4SEJvQjBG?=
 =?utf-8?B?RWpLOFlTdktvSXgreVdDeWs1Sjh5V2RPMGdsUm1vOEpLUG5ydUdqMmxYRzNl?=
 =?utf-8?B?YlJhZ2xEcGMwWjZNeEZQS3BqcXpQRE9XVGlzN2Z0d2swZkd1aHlxU21iWUUr?=
 =?utf-8?B?Ulh4dlNLSnVRZzRNVlRZMTlWdTJPQ2JkYU55cElxRWxNMzJrQ3AvTzVHZXlF?=
 =?utf-8?B?c3R0UHJBVFRTU3F5QmtaRDNmYjY1bVZnSXp0aXp2S3ZLeTF6bGVmTi9vSVNP?=
 =?utf-8?B?SFFIVmY4VVMrdWhCQjhkRlUzQ0FjNE9DQkhkSUh6c3FHRDQ1Qms2S2VTbnp6?=
 =?utf-8?B?b3JpMDNlODRBUnJBS0ZOMGpZbGZQempUeS9qdFBhL0h4QWZadEZaVG9jb0dL?=
 =?utf-8?B?eVFveEh6N3M2Mm9Td3FaMzZOaCtjSXRhcW9zREdOQUxqSmNtQVJpTUhTQ2da?=
 =?utf-8?B?aUVMOHlZNUhwYlJBRmpzdnhsRmR2OHVJcU9FazlTU3BBVzhCTTRqbTZUbzNS?=
 =?utf-8?B?TE1BN280VURQemJYZjVma0gvRS94TTJTYWNKbTVTbC8yVnF0TUpyY09Qa0Ir?=
 =?utf-8?B?K1UydDRQN1dYOVEwNGVyOXA3WnFPci9BZUJ6UHJ0bU9LOWdFd3AwN09UbDFy?=
 =?utf-8?B?Wkc2djEwMjhLaGZ4a3gxbXlrdEJ2cjhRWTFXaUxmT1lFTXYrblZJZU5zZVlh?=
 =?utf-8?B?YUR2MFdZYmsxS0NGY09LdnpYUDFjKzBHWVkwei81SXRpVStRcVJva3lyaDRa?=
 =?utf-8?B?dEZQSGdFdVRrNi9CdTJyakVrdGFXeHFPVWltd2s0L01TRjg0YkJGeTR1M1dL?=
 =?utf-8?B?ZWgvdjFYR0FyWCtGY0thNDNwRlZvZU1PTUNiY2lFNFZveUtETVk5S1BtOGJX?=
 =?utf-8?B?enAwWWlibFdQRC9peHpOb2V6bFdMMEtjZ2lqSkNpYmVxV01sS01KdngxbEpT?=
 =?utf-8?B?QklmTGl5bXJJZ3JYRFFlYUV2MElEWGl1eDY5STZSUjBGcUxRMVBybTRUNHJE?=
 =?utf-8?B?THQ1MFU0b0RHYzhrMDBlb1U2OXZxNU1vVlhERjJIU1ZvMTl3Z0kyaHA4Ykdi?=
 =?utf-8?B?OThyNzlUK0xlZzhnOGNZeDRTcEdzWFdMMmZtQllqSmtuN2V6T3lubVMzODhL?=
 =?utf-8?B?OVhCdnB6TUhneEYyb0hMWWZNSE9KTXZpRzhXbFpxdU1XWk1WaGZ6Z2NWdENI?=
 =?utf-8?B?ak9PQkRnaWxHNlRlQmtaTUNPd3JNeDJ2R1ZwUkFUOFlna0VVb0sxNHlqWlVH?=
 =?utf-8?B?YVorQklHTTFSUnRiTkxjeW44MHI5T1YvSlFXcGplTS9XaGc4cEJHNEovTmZV?=
 =?utf-8?B?cGh3OStxZmdQSkRLQUZ6TDVuYk1DYzkzMElQbFk3cTNmbmxiQlJUd2RuN2ZV?=
 =?utf-8?B?SHhFOGlSSnpJaEVLK002cVFLcHpDRWl4ZG1VN1VXRmFqVU54UkZrdFZtQ2F4?=
 =?utf-8?B?SWtGZHBNait6aS9acCtyU0I2eFErRFZKK05vQW03VXNabjlpZk1RWXE2Zkho?=
 =?utf-8?B?OFVUdHpBNHFxK2RVa0Jwak51Sjl4dHFFQ2xNNXZlS0dhZm5YRy9Cb1hEWVJr?=
 =?utf-8?B?YitsU3c0aWNqRWFqMDhCdGUvZEtvcmVFNllmb1JYY0puWUtvclZycVF2dW1w?=
 =?utf-8?Q?VlJ25j+47xZJIwbGrY9eDFJ7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5806a535-4792-4d0c-be14-08dd475270d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 08:35:56.7155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz6jcOY40F1bBmEbqAAtH/0Wc84To8wvMEbboOagRBg/v/rhTxlfJIQyRcVJ10aJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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



On 2/7/2025 11:33 AM, Emily Deng wrote:
> In sriov multiple vf, Set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 to read WPTR from MQD.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

	Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 +++++++++++++++++--
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2ba185875baa..42251f2b9741 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1857,7 +1857,7 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
>  				    DOORBELL_SOURCE, 0);
>  		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>  				    DOORBELL_HIT, 0);
> -		if (amdgpu_sriov_vf(adev))
> +		if (amdgpu_sriov_multi_vf_mode(adev))
>  			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>  					    DOORBELL_MODE, 1);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index ff417d5361c4..9e08bcfa37d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -551,7 +551,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
>  		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
>  					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
>  					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
> -		if (amdgpu_sriov_vf(mm->dev->adev))
> +		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
>  			m->cp_hqd_pq_doorbell_control |= 1 <<
>  				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
>  		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
> @@ -724,6 +724,9 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  		m = get_mqd(mqd + size * xcc);
>  		update_mqd(mm, m, q, minfo);
>  
> +		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
> +				m->cp_hqd_pq_doorbell_control |= 1 <<
> +					CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
>  		update_cu_mask(mm, m, minfo, xcc);
>  
>  		if (q->format == KFD_QUEUE_FORMAT_AQL) {
> @@ -746,6 +749,21 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  	}
>  }
>  
> +static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
> +			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
> +			struct queue_properties *qp,
> +			const void *mqd_src,
> +			const void *ctl_stack_src, u32 ctl_stack_size)
> +{
> +	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
> +	if (amdgpu_sriov_multi_vf_mode(mm->dev->adev)) {
> +		struct v9_mqd *m;
> +
> +		m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
> +		m->cp_hqd_pq_doorbell_control |= 1 <<
> +				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
> +	}
> +}
>  static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  		   enum kfd_preempt_type type, unsigned int timeout,
>  		   uint32_t pipe_id, uint32_t queue_id)
> @@ -880,7 +898,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>  		mqd->is_occupied = kfd_is_occupied_cp;
>  		mqd->get_checkpoint_info = get_checkpoint_info;
>  		mqd->checkpoint_mqd = checkpoint_mqd;
> -		mqd->restore_mqd = restore_mqd;
>  		mqd->mqd_size = sizeof(struct v9_mqd);
>  		mqd->mqd_stride = mqd_stride_v9;
>  #if defined(CONFIG_DEBUG_FS)
> @@ -892,12 +909,14 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>  			mqd->init_mqd = init_mqd_v9_4_3;
>  			mqd->load_mqd = load_mqd_v9_4_3;
>  			mqd->update_mqd = update_mqd_v9_4_3;
> +			mqd->restore_mqd = restore_mqd_v9_4_3;
>  			mqd->destroy_mqd = destroy_mqd_v9_4_3;
>  			mqd->get_wave_state = get_wave_state_v9_4_3;
>  		} else {
>  			mqd->init_mqd = init_mqd;
>  			mqd->load_mqd = load_mqd;
>  			mqd->update_mqd = update_mqd;
> +			mqd->restore_mqd = restore_mqd;
>  			mqd->destroy_mqd = kfd_destroy_mqd_cp;
>  			mqd->get_wave_state = get_wave_state;
>  		}

