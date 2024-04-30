Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0B0C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 14:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C62D10FF12;
	Tue, 30 Apr 2024 14:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fIU3OVSy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB2D10FF12
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 14:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLHGrFgjSk1C5Of5Vt/GEfNHg9gKihK14MkuMTtQ7XwcAgDf0GiSy8/4j2iBk1COy2v87JiJ5500ZnZf3kjNVaR7/sw5RLlB5VBNHgFljufp0o0HDfyQ8iL/bTAtOaoACMVbsn5ZusBkfn+UVpIyWTDaSx14aLwUExIueAiJDACS7E0MmhOftaUNmL5RhuxS1Kd2Wy23C7rm9IUiyVcB7/binp6Df+pERqpPhQww2nYsehSbLhU+upLmmGcBGUfF8SYgia9hRdjfUNPcqYFMw3vcGeBaMdqikTA7aZs/iFBnctlsH2cM5qD0uNzdtIhEk+PP7szHm0ERMHa460o6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3oXhZgxvbrkW7wH2e0GgjlC6SH/2ePMghRMf8CaO8A=;
 b=byGttT5JTlpgW39xKGBfKpJItLUQAekO1S5RuUpoy9uGuYh637lSoFeHztch6yOWJxZ9Wvc7AKNOi5gCUv5a72HPh8iVYabal3Qb+iEBZXTIK8aQ4bkXmkzeG8wUMXoZWj94ga/AjcaRvCYX/6r+BdHGQY0hsQpEQxK6XKQQ4TypCsleSRONVf8dWpZK5GwnKAW9rBrG1cNYaXVWObUDu5Xc7A1StsAsM7yNa2QyUSboPrQ3of0vuF19Ud0uDhYaIjzQx8sXubNxtDL08I9pVkp3Vd1O4kyRZGKN51R4HW6Mequ+Ny4NOFzlquaZcrAvcK4O4X+0Psug4SH7JKIIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3oXhZgxvbrkW7wH2e0GgjlC6SH/2ePMghRMf8CaO8A=;
 b=fIU3OVSy9dcjNrukEhA6XqpPohHNI+DTsyYEmbDekHY1R0K+G5blv1nQ77Q4Tjpje9eYHqWbOnkjyaMtuBSeJk5KAYd/RlxrTP8HENNxT2WLtIWHLrDPnnca0yMCpd8QjKrwvCaxXutM6jSgTnf+3MOOhourQA0IMKLqOIDF+AI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 14:49:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.023; Tue, 30 Apr 2024
 14:49:03 +0000
Message-ID: <bf4baa39-4689-41e2-9efb-35be989901b6@amd.com>
Date: Tue, 30 Apr 2024 20:18:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: avoid reading vf2pf info size from FB
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com
References: <20240430142356.23489-1-Zhigang.Luo@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240430142356.23489-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: d3abce96-6144-4f7e-2412-08dc6924ad4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elJVUG8wbEFGdFc2RUo0NWJIbmpiaisyQno1NDRIRkFXbDNsVDhleUZTZkFl?=
 =?utf-8?B?cnVJdnJrWTg1dlFJMWkyZUl1RUFrWTZyTFVudnZPb1pMNXVYUmxwdm8veERl?=
 =?utf-8?B?dFJyWmVjM0tJV0hvd1k1U1J6NVhvYk9Ba3pwYzVjdzllZ2djSmVQUDlnMUN4?=
 =?utf-8?B?YnVmdkFuYjlhZ1pTTm9YbkRSTGFGdHVzZk81ckFweWVWQVkxdTJac0ZNdExt?=
 =?utf-8?B?SVJuWHlOZGFXOHd0SnRLL2dOTXZkaEVWWDEwYk52bWZtZ1R6aS9yNG5Na0Fj?=
 =?utf-8?B?VTduV0U4ckJhRTEzR29YQmdEc2ZLVHdQY0tTNno4cnBwSi9LUHNhUnBqa3hG?=
 =?utf-8?B?Wk1maDJsK0s5ZmZvQzlKZ3JibTBoQ3laUm95R3ltb0FCYzVrRTdnT2xjSElu?=
 =?utf-8?B?OGg1Ykl0R2s5bWpVQWdVZURwVlMzajEzU2UrdGtTUnA4c3F5YWs2MU1VSlMz?=
 =?utf-8?B?TytUbU1DYTBiY3QwK2J0ZGdySTg4TnZPdUZvZi94QUd4bERBRlRncmQrTEpK?=
 =?utf-8?B?M2lEYzRack95N3kxazlZVGZrcmc3RUtwWFFRYm5WKzJRSDFtcE1lVnV1SkdG?=
 =?utf-8?B?Zkp0Wk10QXd1UWtqRml5c2VpM0lDamZhdFQwZ3hkeTQzR0dXZUJjUTkzWGlU?=
 =?utf-8?B?ZXIzTVNLVjMxaEhFeTZFZUJmNEpwOCtLa0o3R01EWXBIbVIzVnFic2I5NWdQ?=
 =?utf-8?B?RFRINDRvWSt5djdVeFI3V1pHRXJURFFRRDREaUcrZXBrUFAydU5zc1JFVzVj?=
 =?utf-8?B?YzBqN2Z5ZHprTUtIckd0YUFHMnMwRVJpdzdsTXc5YU9OMlk1SXRpWUdqZEhL?=
 =?utf-8?B?aUVFbmRUNG9wZWY1UDR3RUIxUTgzd1gvQ3RXdGNyZEdpcmFyYVRQRUFVWXpS?=
 =?utf-8?B?emlFWHVXdTlZWHlZM2FHdjQxWnJuckJDMm1zTEw5VmVQdzhndVc0Y2JqNEF0?=
 =?utf-8?B?L1J4WitlTkZzMVhZN29abU0rTUQweCtxNXdxcGFHMzBtSmNrWTk0dE5nWFJP?=
 =?utf-8?B?bTRPTU5xYVdWOVk0UjRyaGI3a2kzaVdTZTJoWFNNeUNHeWRNSnRzU0Q1Z1Zj?=
 =?utf-8?B?bFhKN2dzRjY3UmdXVzdGdmtHSUtHR1l3N3BWTTBtbDJXWklveXIyOWNveXBP?=
 =?utf-8?B?cGVBSTBZdGNWWXFPM1NQSVRoSnhaU2YyU01MVnZwNmI2RWg3VTNwNC8yejN4?=
 =?utf-8?B?MFdvSWZyM3ZJeG00Ny9wTFpoNGJoQVl1VHRxS1RoWkFNbnJqdUlJMUdya2py?=
 =?utf-8?B?MEtDaU1iQ2RQWDB1ZkVOZmlvMUx3S0VvdXM1eHphVmY5ejlDUDh4QXl0cEZY?=
 =?utf-8?B?c21Uc0ZkTUxQeFQxbFRhR0tuV2t4Y3U0WndTUGZRMXZHUEJrZ2dUMktUcy9p?=
 =?utf-8?B?YmtWeVVYb0crT1EwVmkvTUorbFozTktFOWl1cUZvYUQwSEZJYnNnb2UxME1a?=
 =?utf-8?B?ZG55WHNhWGVBOWwrVWg4dmMyN09OYUF4alprQVZwaTVIaUY2TmR4UmZ0aHhP?=
 =?utf-8?B?eFN0NWlubXd6ZlBLdVJ2bGZxeHA0UWkwQ0QrZ2o0cWdZUHZEWDhteHl3ZnU0?=
 =?utf-8?B?N0EveGlCYW9OTVBTUjhVaHZTZ1lCNjVnNU1tUFYyYU9oOXdYYXp5dWYzeWtx?=
 =?utf-8?B?RXFLek9Cb0xVMDMwajYxOG80RDhFTWNZMW5GNVBCS2Y4eldYcm4rTld0Q21Q?=
 =?utf-8?B?WTU2a2JmZVltSmU4cmI5NkZoOTcwOW55VVdUU2VkU2svTTVJSzNsZTFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emRIQS9rNnorSXhMMGlmenRMMWZ0azJNUGJUdTlVTDl2MDNBaFZwbm5IeDZr?=
 =?utf-8?B?VmJmU055YW9QY1VUL1RXK2RGdDg4Ui90Zjd2by8xN3FHc3p0ajFPNXBoMDFM?=
 =?utf-8?B?am1ObHRlZG5JS3VFeHJRLzFINzFJck54cWJwdmN0ZitrYk1KblFUVyt5aW5G?=
 =?utf-8?B?RStLVHZ5U2hoMjFzYmMyTnREQmpsL1NPOXhkR3JJVVBTVitKck9SUUx2elhN?=
 =?utf-8?B?VFNPY2xwTGVTbHpidXowcU5ETW1pR3NpTCt1UFNDQ0RTdjFIbkVkMTdPU1Nh?=
 =?utf-8?B?N3NZTVFmaHlSOHpOTTNKOFY0Tm04VFZuRktBZVlpYzB2UTBYZlZBemtMT2VS?=
 =?utf-8?B?c2cvTzl0WFpvMVFMRURrMEhTTDA4TWFaM3QxdFQwMXdUaXVuUy9VVzdNckU4?=
 =?utf-8?B?SlZCRXVKU0hjZnlwSnVGcitBckdQTWpvc1pDTk1ROE5DSU0weHU3V0ZIZGdl?=
 =?utf-8?B?TUVZa1BNOEFMbHNod3JtbENNTFVKK3R6akxhTENUSHZ6VHVGc1VPd1pFNHdq?=
 =?utf-8?B?Kzl5TjFjV3UyRnNlSVJ4cm9zUDVZMmt4UTJoeXQzVFc5bFN4Z08xT01QTkdj?=
 =?utf-8?B?eXl0cG1sZDZXU2IxLy9NQ0pYQXJTOU5lZ25jU0VWdHFEa3BLWWhMOC8yUUU5?=
 =?utf-8?B?dnNCelh5TGZNeFdudXpobTM2MlJ5eXo2S0hucUlOSlNEcFhDRDlBazk2Y2pz?=
 =?utf-8?B?dHZLSUJ5Y2VDM1UyVFpJYnFaZ2tvTDJFQTlXbGovNUh2Vldpb2JjczRXbTBT?=
 =?utf-8?B?UmpGSDQ2QUVJNi81cmM4RWkwVVZEVzRJVWs3dWRPRFhkbmhqSXdOVUY4bDF4?=
 =?utf-8?B?K1pyV2FjTk9nS0JQbjFIUm5ySFhqWVFDZSt0aHFibnNvdDlRQVlrbU5aMVNL?=
 =?utf-8?B?UCtxS2w2RHZxbUp0ZHJBSUpmSkFodzVqaWp2RW4wV1RqK1RSbUlzbFJoUnNP?=
 =?utf-8?B?YXBuNU9oNDROdlRNUUhkcHFqckpxRERtNEd3djJhbE9SVktpdXpRRkJYVDRD?=
 =?utf-8?B?dE14VUNHZWpvUlhWV3BjMFI0aDBlT2VCSVN5QStjeDl6Wnl6blFpUHdkbDcx?=
 =?utf-8?B?T0tMaURPM1Zqa1YzUlVOcTVlUjRSaHY2cnpNTEFpdnpPTUJ3SFF5S2VUWWVX?=
 =?utf-8?B?QW9GMXFLKzJVQ0kwQjA4TUoydEplS2d1bnJDQURodHhPRDdKOEJUN3k4Q3hS?=
 =?utf-8?B?SW85ZnVvOWJRRjBBaGtvM051VnVXczZJRGNwVDhUSC9VMUhEb1p1UjVyN2pV?=
 =?utf-8?B?TzBMUktuNnplOW9nNDcrT2ZhRXg2VENZOVNKalU4aXI5cGtxUzdDbmJHUGxm?=
 =?utf-8?B?a2prcWFwZGQ4dDR4S2ZSQklvZGRkS3VNY3BYeEQzdDl1UkwwU25BN0RoZzJ5?=
 =?utf-8?B?RFdQMm1PWktpRjBPT01lQjJzQmUxNWlSNTRWSW85aWduSERNNlZUYUdlN21y?=
 =?utf-8?B?Zk9DL2l2MXFSMGE3TW5KZWJiSy9IeW8rWVNPRTN2V1hMV21hL29sRmQyQkMw?=
 =?utf-8?B?dnVSWkRPU3VqWXZkRzhwR1dSRG05dXEraGdDMHZVSm12MHdZNDNLZnBVUVVW?=
 =?utf-8?B?eXNpdTJ4VEUwa0tRMmtxS3g2ZnQ0YWNDcGRycWZITzNjRUFEMHYwYXV5QjBJ?=
 =?utf-8?B?R204djBJUHhtR0cyZ1BnanZyMFRlcVc4WUxHdmpEWlVtQkpqdnNuL2NwdEl3?=
 =?utf-8?B?ZWJBS1V4UWVCYUhPVDBYbEZBbitlaXY4TEV1NkxmQ3pwU3V2a2dvNTlUS0FW?=
 =?utf-8?B?RFNpOHVRZ3lUbUs2QU40Tk5IV1U4Wm83K3RIdVhISWx6MlAxOWtHeGNncnNi?=
 =?utf-8?B?Z2U4QnZkbFpGYnN4RFF2UlFGTDZ4TTNlcHJ2OTBFdmNXN3doQzZBcXVkUjd0?=
 =?utf-8?B?Y2JnWjcyMWx2YVhnVGtTbmVIZktWWGFkQWlaU2tsSExITnhGb0pPemRTYklU?=
 =?utf-8?B?Ty9Xa051UU1NY1hnTFd5K3BWM0Q0M1dibklzbmNMMTBxdkVvZ0s0dDF4WjYx?=
 =?utf-8?B?dnk4T0VKSEU5TytRNUhnL2NEOWw1WWhiNjZrN3VTKzRubGc5TlVwSnZvY0pE?=
 =?utf-8?B?Y2dDbmJLNEViQlFmalZxWGJWM1UwUWZzMnFwSFplMmFyMkdOOE1BR2FVYm9X?=
 =?utf-8?Q?3ElvSCiu4UhowrXNXrWAdq07G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3abce96-6144-4f7e-2412-08dc6924ad4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:49:03.0749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70/+/ycGow0y0jH+BohgrYc1R0ikNSUPZgg89t6ihq0piExFpkZpu2pRmQgJHpR6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
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



On 4/30/2024 7:53 PM, Zhigang Luo wrote:
> VF can't access FB when host is doing mode1 reset. Using sizeof to get
> vf2pf info size, instead of reading it from vf2pf header stored in FB.
> 
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 54ab51a4ada7..c84d2217005e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -583,7 +583,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
>  	}
>  	vf2pf_info->checksum =
>  		amd_sriov_msg_checksum(
> -		vf2pf_info, vf2pf_info->header.size, 0, 0);
> +		vf2pf_info, sizeof(struct amd_sriov_msg_vf2pf_info), 0, 0);

You may change to sizeof(*vf2pf_info).

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>  
>  	return 0;
>  }
