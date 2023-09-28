Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0401DCE7B0E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 08:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86CA010E5F3;
	Thu, 28 Sep 2023 08:42:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0008F10E0ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 08:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fleeMovMFgfKFelKCk/Vf+6G10Odc4iZ9TO+EJzj1jhTrQ9TVD6RwMo1QD5/vQOfBc7vc98RKl8N1j14EklHdAkpkq6tRNYksXKqDC4T+jW5FVEnksziql+JsewBpgqrNmvxm0FlyKu6cVGrfNwgP7yTvp5ZemkYth33KOTzGwuco8SmqkmuPOoa6/43AOwg84+NxRKT0Wc4bgrZk8X4VuGxfYjOPTUm0z7dbahWnvxwlnkQ+tJ/wi898V3HFKQlcmTVVouHGjKpNcfkzqeumZrhzznY/izvJkFk1Lcns6MW+6cL9r16QOexUinQNm8O1lZ++bTp5TQ8N1hnjpSAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH577JMLk/tILubbqpjlFsdY7x33f3UGY+t5Hdjylm0=;
 b=BkDMcSFL1ml29voB6f3yZfCzAkB8otx24tp/HaioAk7eQowSSk/Hddjz0dqYGOWfwIAsnWEccLfh38KHLffdJh9L7/M7JUDsqMICngi2YV7QTtiM2saCecsmu+O7uzUyJDZbAkfdC+WCHzUv8shkbs7dds3dOc21a+qTVdQLkPX5SOjYe+r0f+zaQlNJLxyRp8OVVJC+AjBwR+h/QLc4ABxjJ3+p2eWGzUvIzzmKeScdxZmCKLK/rSod8abF0fDx9H0uTP6Zbz7nGbTt0vz05/1W77hLA/qIap1t/PKBTz1NVPwtDg4GQyh197TWxUM3kEVTkEybJUSIFcm/IJehOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH577JMLk/tILubbqpjlFsdY7x33f3UGY+t5Hdjylm0=;
 b=VCRDJmLG7G3ouUuTJFx0Nxu0OEJzaBPsMEsYHEeZDhiTfUn43YX26c6y9UEp6elP+kYyVE/cjs0EAToLLdWhEkvIAPu4VDWuGW9OtasQUFFt7t2gGHxhxB7U+wSKVgIGcpg9dBn1ZmI8SXT3tO06LElQ401j51jK/7lOKLWiBGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 28 Sep
 2023 08:42:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 08:42:53 +0000
Message-ID: <5c9fc217-3ee6-16f6-ba7c-13cfe95c414e@amd.com>
Date: Thu, 28 Sep 2023 10:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: add hub->ctx_distance in setup_vmid_config
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230928083131.2858658-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230928083131.2858658-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6def1a-2036-4109-734f-08dbbffee758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPrl7H7jHCMORqBmucaeCch10Q4DKEU7oFtR8nqHXCyGZpGCEKFyf6wo+j/G3mmj+I8SaUZiuFc2saqXeOBrPjDoOyYx7Hr3AJ5ejjGwtfTMWTMrRXj5T5ZAJM+n+TrcMhnZsKEmqSMX9sR3WVYp7ooimeBqKlHRU/jQnW20sjSis7K4IELQFy8iyhzD8PCF/QlnS2Dns+vv4XcEpZxoQRKHLYDGc5e3rlC5V1mPvBJW8AMw4Gq54CgpGPdE87UrxftvMyw9Cd0DxPtXMGrsYDyJQj0m3gJsaTWLJuGnWaPffWGmSGKujw3Cuv0rY0Wn9cK83K5dF5IvHVTHO8L42mckD+zecC+DEkCpZQJ/BeaPkj6SQz0pddPvviFQslNTjqxbXYwLcvS/Qhhgyvoy+hh6hMDMYj3Pu+n3hEIajGY41ludhE1A+YyyfJWYvQyDFd0LyIiHxVWslzwteQAWKG3xAx9xvy7BapNkkitBqOL9/dfdMHm51HliaqlSpVvHDNulu3kG6bixXG3+IJ9ny9IBGYAr4qf/CQXUAZCMY+OdkKxjjdICHilw1UutmzBOSEQW/OK6rC88+fIAHMEnJpfvMtaWiRQqLca1QMG12+OxyFQzWtEF0v0YhtUAjUwITv0Gba/lZ/LT+Qr4ia5upg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6506007)(66946007)(6512007)(2906002)(26005)(30864003)(4326008)(2616005)(83380400001)(66556008)(66476007)(478600001)(41300700001)(5660300002)(8936002)(316002)(31696002)(6666004)(6486002)(38100700002)(8676002)(36756003)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhkZzFsckRIaUdmbzhscC81QmZDUGNkMFBJSm1JU3BZQXdndmlJb0F5Rmg2?=
 =?utf-8?B?M3RNaVlLUlZ0KzdqSEQ2K1MxeWtNMHNHOUVTbFdnbGg0RWdQRkJTd1FJR09S?=
 =?utf-8?B?RjZ5K1d3V3lPdTd1OVVNdjJsWTU1ZmRUWXU2YkdIcU1RY2YxOFIxL21SdnFR?=
 =?utf-8?B?SEhsSWc5Z0orb255TXJ2OXh2Y3M1cGI2aUJ6T09ZQ0hFTEJYZSt2Y1pNaFE1?=
 =?utf-8?B?KzMxRnlCeFFHT1pmRmd5OENwcjJud0diNnlEWS9peCtibUFndkJCMDR1ME5T?=
 =?utf-8?B?U2xiQk5TWVBNZUc2NDJQcTM0K3VRNm5PcmoyK0w2b0c5Y1B6U0U4TC9uMnZJ?=
 =?utf-8?B?RG1SVHFLOEFRci9reW5reTFHRmJxTVVjUElQNSs2Q094a0hJRS9FSGZVM1lz?=
 =?utf-8?B?Q1M2Y3dQUWw5ODQ2V2FHZWZENWJscm9rYUkrTEV1UFRXUXRMQ3F5eUFheFd4?=
 =?utf-8?B?OVQwM3htcWt6dEs0OGNJV1JaNG5BL29Id0NzVEl0NDhJVVVrNWI3S0YzYWgz?=
 =?utf-8?B?ZHdyUkJNS1JtNGY3WlJMT0ZOTFhDc3FLRnh3aGp2NHFVcEFKWngvZUNZUXVx?=
 =?utf-8?B?Y2IvNnlQVFNQQ1RZNFRiaUFMbldoQ2cwbjFUMFk0dG1wNHArdVYwd09GQ0xa?=
 =?utf-8?B?ZVZoSFIvVnd5N1g1YTZQeS9VcTdqTE0xd2ljaWdjS0VsMUNSRGppdWEzTHRO?=
 =?utf-8?B?UW9mRGpyc2VLd3Bad1dxU05jQm52WFYxQjhxMWl2UFJLSmNWTTFDK1E1czdS?=
 =?utf-8?B?UkdlN0M4aDFBWENUeHYwKzdRYWFWN1pCSHE3TzlIOW1QVUppcHIrZjhDZUNC?=
 =?utf-8?B?K1FrNVVpS3M2TW1qNGx6NlloWUpkejVwZmNqKzBHWWxhY2FBOGIvcnEyM0Rm?=
 =?utf-8?B?TjlhcURCRTZld1FwM3FGZjZqcHl1azZOZnpYTHM0Z09NeVlneHg2UXUwSTQw?=
 =?utf-8?B?L1NHV0pXSG8vczF3MnFuQTFSUUpacTl3NW1Mc3BOYjgwWVk4S1VjTlJTUnJw?=
 =?utf-8?B?cVN5M2tMOWhCTE5zRDYvejlpTG9WMHpOUzNOUDlNQm9tRWd0Q1l1Y2dGWnVN?=
 =?utf-8?B?WGRjeDZXK1lGamc5ZGNEK2hsSGp2OTR5aFZiSkx1UE9PQlBDeFAvc0NkdENQ?=
 =?utf-8?B?aDNieHVxdnUzbTJEMy9jOXo3d2ZJdG1xdENqS3AvU1U3cDZZcURyR2dXRk1i?=
 =?utf-8?B?UmQyZDhHV05VK0gxS2o0Z0Q5eEtqR2h6eGhrdzlVaW9UU2lxY3FlVU1DcFda?=
 =?utf-8?B?b2tOYXM5Q3FZalBTd0hlNlZORlpwUm5zYUlYbmh3S2kvMHZ3Q3VGNHkzZEti?=
 =?utf-8?B?cFNaWG5VNVY2ckl0R2x3R3BsbHVQRXk5N2JjSVIrbEZrQkhmU3lBY2F4M3VK?=
 =?utf-8?B?RGZYVkx1Q1I3UHlOR2tOZXdMbEplSlBseHcyL0I5RjVmbFJ2V3c4NGpCcGNK?=
 =?utf-8?B?NmRTbXA2cVFkSThjeU9pSS92WjFFQXYrVndPS0FxR2Z6Q0VEN1ZlSzBFOUhK?=
 =?utf-8?B?Y0pMU21ZdG11Ti9JSHpONnE2RDZ2blpUR1ZCWDRmcllvL0p5dlJPZm1MSjBq?=
 =?utf-8?B?V2FJTTZqeEVLcU9GVDQweXUzY1JzWXFGMjhEdkxWa1htNGY0Wll2UnBYNDJw?=
 =?utf-8?B?cjllNnZOaG5Yc3B1b1M0eWhwSERUSDRpcDVnSlptcGxmNzBvV2RrS3o5bkRV?=
 =?utf-8?B?aVpKS0pxRC9Ua0xxRXVmOGprRm8zUDIyOFY5TWlabU4wTXR6VzVPamZLNGFI?=
 =?utf-8?B?NEV6QldlYTRUdmx1OXlibFo1TGNGMFJVbG81N1QxRWJqWE5LdkNmN1NLeTh4?=
 =?utf-8?B?NUxKbTJPcjhwS0lXZFZaZm1pTUppYW8vdFFUQk5DZk9UNVdtS0VhM3JQcUtp?=
 =?utf-8?B?OWtFYlJxQUFrMlM1SWFhQkFhQ1h0S1RIZVZTTDBZQlkzcERXWXVMc0VrSm5D?=
 =?utf-8?B?MmFDcnl6eXNKOTI4cnpCZUZOT3gyRnBEeXBRcmZCd1dWcXFoWEF2TXJvTUZB?=
 =?utf-8?B?NTdWUnVWcEZKRDJaaXRSdlhTYis4U3ArdEFjbnZ6a2g1U1psWGFNdjNTY0dr?=
 =?utf-8?B?YTJwTW9oZTR0aTdPQ1REZzFIYkNDR2pIcUYzKzdsY3o0bXV2SlZ5dXlZOWY0?=
 =?utf-8?Q?4h6kK4FQ5Mp4n23oCFNMHCRm9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6def1a-2036-4109-734f-08dbbffee758
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:42:52.8493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG+Wsuvrul2xxEdr7j1hj8VYP6J65nytS7TwTWC3d7/Yx2zMfAOuA3mDtMer/ks7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.09.23 um 10:31 schrieb Yifan Zhang:
> add hub->ctx_distance when read CONTEXT1_CNTL, align w/
> write back operation.

Good catch, but please double check the coding style with checkpath.pl.

With that done the patch is Acked-by: Christian König 
<christian.koenig@amd.com>

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c     | 2 +-
>   17 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index bcb6ba03cead..f9949fedfbb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -297,7 +297,7 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index cdc290a474a9..53a2ba5fcf4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -260,7 +260,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   		block_size -= 9;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index ff60670b8464..5f949caa68b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -329,7 +329,7 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
>   	for_each_inst(j, xcc_mask) {
>   		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
>   		for (i = 0; i <= 14; i++) {
> -			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i);
> +			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   					    num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 8521c45e8f38..793faf62cb07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -287,7 +287,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index f829c441640a..cd0e8a321e46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -296,7 +296,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 89ff7910cb0f..abe30c8bd2ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -294,7 +294,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index be1da5927910..b3ef6e71811f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -299,7 +299,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index fb91b31056ca..843219a91736 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -242,7 +242,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>   		block_size -= 9;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index 9086f2fdfaf4..92432cd2c0c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -274,7 +274,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
>   		block_size -= 9;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 784c4e077470..2c0419faf8d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -344,7 +344,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
>   		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
>   		for (i = 0; i <= 14; i++) {
>   			tmp = RREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
> -						  i);
> +						  i * hub->ctx_distance);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
>   					    ENABLE_CONTEXT, 1);
>   			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index 37458f906980..02fd45261399 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -367,7 +367,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> index 4ddd9448e2bc..5eb8122e2746 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> @@ -285,7 +285,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index 9627df8b194b..7d5242df58a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -323,7 +323,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> index 77bff803b452..134c4ec10887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> @@ -310,7 +310,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index d1fc9dce7151..f0f182f033b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -315,7 +315,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> index 3d80a184ce6b..76b12f015d1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> @@ -303,7 +303,7 @@ static void mmhub_v3_3_setup_vmid_config(struct amdgpu_device *adev)
>   	uint32_t tmp;
>   
>   	for (i = 0; i <= 14; i++) {
> -		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
> +		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
>   				    adev->vm_manager.num_level);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 5718e4d40e66..1b7da4aff2b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -308,7 +308,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
> -				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
> +				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i * hub->ctx_distance);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,

