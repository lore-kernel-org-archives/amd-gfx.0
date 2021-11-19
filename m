Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CDCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 21:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618C46E077;
	Fri, 19 Nov 2021 21:11:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E306E077
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 21:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhgX+a6dBjFdoAcLfBAkLscro2hgmanBMtFU+F1UmNOUVptiCjWLhVWwwZEFVKn990BV8q6mb8eJIIZdmUoFGRXd3DGm48P1HDUFIAXmK3/7e2RBrYk7nbTVtIujK1aEz9ZZKtE5J02qrY8sKNLMxN/Vh1LZ89v6wGgKbToINZ5X0hz2FBGKdTrFIn1pl3AIwrwXxAjAMFzzczkY2dJn+qQNyRq4ltMcfm0rCw7RomQVAetPCr6fcmeaoYryY/gZmGj+RHvgebUSPiQdXDcR8ETjLJ4JJxHRWytkwRkohZTekg9EuFabGCrps748Zn6XKMqHNEX52BS/GFp2w+p6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SIgkZrElh4KQ9MKouJ750jFutGhq00XK3mqctfwe0w=;
 b=iNHNv4Il1wd4fKBvvqzU4W4O9qPFzQ1yZwKPkBxIExjJIzGKByGrj/UySLr1lWVd/DXWSGQCcbrwGHGHcuhmuodITb4lZi3y5FYamrsBM7dBW6UPLyq9do9b1c6p4Ux2B3rxknrkVnrgHE1b0Hc7cYuZ659CCsOTuBIsxUhvovHEdIIZnkBGuVwypg+C42bPIgQWxFk4yYEIrHnDZyCJcPi+c/FBfOaGM5DQnMhoQAWEzWP06HViOvqhHYSbnntoB3R4KYVEuaIzWlbjIj47d+rqW76Q/H1FFLnV8c/NnNo6B1YoAYb/zKcgMPL8ypm1qyvU7BLDQdeEu2Aysixazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SIgkZrElh4KQ9MKouJ750jFutGhq00XK3mqctfwe0w=;
 b=ImCM+n2ykKLbwwHuZgSAg4NvthPMPv4blF4SVJsnCq69SgRpABuJ+W1XbmPhxaE+fiFeKQEKBzTZtZ0NQlZt35oIf4nUox5nqmzpG4p8YQTuANjsx9FuKl7gfPyRwFNgdXuhvX+UqQgk6QeSCPocNNwOnOJtc//AyyYO0N5zZto=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 19 Nov
 2021 21:11:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 21:11:21 +0000
Subject: Re: [PATCH v2 1/4] drm/amdkfd: replace asic_name with amdgpu_asic_name
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119195258.2173551-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4ce290e0-ffa1-f6c3-5d3a-be15df43a32f@amd.com>
Date: Fri, 19 Nov 2021 16:11:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211119195258.2173551-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:208:239::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 MN2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:208:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 21:11:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f658f51-1cf9-4db4-cbef-08d9aba12296
X-MS-TrafficTypeDiagnostic: BN9PR12MB5036:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5036E3F81C43B99FD86DC9A8929C9@BN9PR12MB5036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XdDCZ0RHVBLmgnV/DI0XU6Cz4DXp00AHE6S1QTs/XIV6HDpJcTi7rqf3WUaAWcqhCL1zZNP9DiBKcYKVWg8XnG1tsIT8C93t6V1E4hYistoGbYtg8pkEwvP5wIQ85eASdN1gDYfPU2Y8sMArA7km8ZGm4tmisucobvSsGFAhvriVnJRNmjWfzCCN+LaJMCXeqt2uFmHeincTvu/jqU/SNjtCOnxG07nlj0YEa93qxuJvqxn2LFB4kHHgK9xBUGlGQAZLaDs6xJycQWjY9Q4xCa2PrUiLXDXtmMzEncLZfcxz2LFf69XHiLMn5yJpbCsh5HpdgmAOS6CO5ttAI6IGEbqA8iain9dvYj/bxsWi6lfsexMlTWSYO2s7EcWH/zD+tH/+qF/bTFOVIm7a04KjxbY/H1pdmGinUAob46esgkJaWeR2tymfFCzmrYuXCl8/HzlHZ2ArbTxgcglH8jAtCdS+N0XcUaF75YfjDRfie5UFS7YMNXK6y8y5F3IeFOuWdkladdivSLB84QhvX+RUcUCol809QxHPfl3523g7s8lDQeYlwhM/+B3Vk4ROvn7VBo4Jf5e6cIKw18dogkVuP3XSshnM4GTYGIVIBgYdEo6kFIKAtRlZRHj01D28KKrCWVQ8E98uMyzUhqs3uLlowcBaRTIXTcaJOPraZ+uo0TsoVGIRjFxH3W1EnMk/dhaFVxmTB3KgWEn2ghnF1X6rgsD6IGlO3kCoFY/kUvmu+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(86362001)(31696002)(36756003)(8936002)(36916002)(508600001)(38100700002)(316002)(31686004)(5660300002)(44832011)(66556008)(186003)(6486002)(53546011)(4001150100001)(956004)(66946007)(2906002)(4326008)(83380400001)(26005)(2616005)(16576012)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXU5RnJWbHhGb3dLWnBHaGMybTdUV2p3S0VlOG8ySXpRVk54UW5ZaldJV1hH?=
 =?utf-8?B?RGJqeTZ1V25qdTZIRHZUTEdTMVd0QmhGR3ZuL2ZwQ3lkZ25rVm14YTh3d0NM?=
 =?utf-8?B?Z3Y1aTdZV3VCMmRGTFBBY2UvT1QvU2RLbHhIWjNVYXlMT2FHeHNaZW5XdEFQ?=
 =?utf-8?B?SHFIeUVjS0tKVW9xeVpVOFVmdHF0ZHVaNC94V1VTN2VVWXAxMkx2eFRMU3hz?=
 =?utf-8?B?TWZnTDNncG5vb01pS1JHZ0kxTmpwbUV1MUJjcWR0ZW5nSmlja09KYTdSL1R5?=
 =?utf-8?B?eGw3UTBQVlB4OW1RY0NKNVFxaDJMWFVPbG4rSVVuemoxc0NRUDRuMUhFUk5Q?=
 =?utf-8?B?ZnJLd0MwU3A0OGF5Rk1Eb29WL29uNC9Zc3k3cCtpY3NoM3BDcVQrMGJBMys0?=
 =?utf-8?B?VURDa1RXZzluRGpjVSs0TVY2YmRwWXZoOHplMldncklWRnl2VjNoRkZTbUVu?=
 =?utf-8?B?YWhhVWVRdERHb0FzQWtzOTZIK3B1cFViR0Z1WitSRzQxcVF3TUNQRklhMXNG?=
 =?utf-8?B?dFhWWkkvWktUcFJDSzJ5bmVqb3ZFNXREaTZqNkVrVVVIWEphMktrRDFtL09h?=
 =?utf-8?B?TWFIZktGdHo4T1dianBxNFFBZWNUSThRWG9tR0JsZkprTnpSc2U1UlJGQnA3?=
 =?utf-8?B?VlRBMG4rVGs5MGl2b2dnTC9qblp1UFRZeXpHcXpXRkxZTDdvMmJkOHh2TDdu?=
 =?utf-8?B?MXJNaXFmTWhQZ3k4QS9LSlp3WXdMcTBVeFQvRGJvYVg4eXh2K0hlWGlidjM1?=
 =?utf-8?B?Znk3V3diSHpTeXZsamlCVnJtS29YMDUxa2JoL0NyZ01kTnJkaS9FQVpjTUJL?=
 =?utf-8?B?eVZyM0JPZUxuVG9tZTJ6SjJJWEhHSkJuazFwMmFVWGFvbTE3ak9VTXB3UU1n?=
 =?utf-8?B?SktFcXAwallFRmZvb0JZOFVXSVNrVnB4ekE2eVkvTGZvdUpDMjRqSWhwR2NU?=
 =?utf-8?B?bnJUY294QTh6azBRRDRtMFdaTmlqSVJXS0ttL3YvQXR0UStsNENCSFprWUQw?=
 =?utf-8?B?VlN4eGdNMjZUSFY2UkdOMm5tWjluK1dhREYrNVFBSlMzMEs0aERzUUc3OGU5?=
 =?utf-8?B?M3JiMTZWVzVRN0MrTERra2wwZGdwelQ2NUI1bjgzVHB4R1pjWUdJRDBpVjhS?=
 =?utf-8?B?cjBCQXRiSHllbXYyYTNSSXhzVHBkVDdyUGtnSGpjRjZjQUVtUDZmaUtoanM5?=
 =?utf-8?B?bzM0cFp3aUM5d2lIVCtQUktYSlFvYnNxOHRyUVNKTWtIRTcxcnhUMTRTZmg5?=
 =?utf-8?B?U3hDRy9NUC93Tkhsd3NBcUxaOGVKYm1KUk5QUEFFdXdmZ0d5Nk5lMmpPMHdJ?=
 =?utf-8?B?OUxkekVqSC92em1NM3YyeVFMN0p5dHRIUjJtSWMxSjd2VjU2OVgrYVJBcTRu?=
 =?utf-8?B?a2hJeER3YWxsejNKdndsZzFjckZRbWgwRTFKVzgxeS9ZS0Q1eC9TczE2M0gw?=
 =?utf-8?B?V2hxandUcEJFZUVBVjRib05vTXMwU3k0VFBWM1FHUWJ4cVFFRzNGWElJdXho?=
 =?utf-8?B?MXlPS3NvTU1ENmlUa3ZHQzBuRFJUV05hVHFvcDNrTi9WaTRhTFNFQ2FzeTIx?=
 =?utf-8?B?d29mT1VNTVVkUW5PKzZjdHU3VXlneGwzZUNNK1ZpclV0UUVveWRON3Q2Q0tJ?=
 =?utf-8?B?N2ppWjViNkFCbUF4V243ZGIwNmdaeGhNRjFzVTNYeDJMdFBMR1dyY3BMZ3lk?=
 =?utf-8?B?N3ZWY2RuYU5oK0xvbDhUUUhMRVgzakhhMGZkR09vRUpjNTdJQmVvS0N0Rm9G?=
 =?utf-8?B?T0dTaDl4eEJyc1d5ZSsvU2l0Y3dJZ29tbnVlb2x3UGV0aDZ4WnJsbmhLbHlY?=
 =?utf-8?B?Z01naGdKMmg1bnBUeE5VeC9YZVNwVlBiRWFqMndOS1JlQXdDRkpDQ0J6anpW?=
 =?utf-8?B?RTJWOStDSXJMWTFuNDRGWmpHN2tDeTU5RDNnZklnUVRsMHNkc0pIazZnK1pr?=
 =?utf-8?B?TjRCSWY4V0NPSGNISllBaU5iMFBOaUFZSG5hVlhkTkpmTUM0Wm1OR3F0ek9X?=
 =?utf-8?B?M1hGcE9wbS84U01hWWF3UU4zSHptMzUyWWdJU05CN0dCSTFacVdNekJnN0Zk?=
 =?utf-8?B?ZzhIbm5iUnczU3JhUloybU53b0RzSlhDRFNqYzhvZVRjRGFqMUlsSmJQV21X?=
 =?utf-8?B?MXJnVVltRXBWT0xIU3A3NjRwajQwSTFNa3M3a3p4a2tFSFFCT1pXa3hXek00?=
 =?utf-8?Q?2E4Fisi5w0IJvoWMseRM6fI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f658f51-1cf9-4db4-cbef-08d9aba12296
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 21:11:20.9297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cntKePZQXVn3NunHYbav7xe2GyX8h3XRQSju/2isOh68QbzYQHiXyN5oQ+pCLcIVCfVxpM8it26t7s0ZUk1EEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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

On 2021-11-19 2:52 p.m., Graham Sider wrote:
> device_info->asic_name and amdgpu_asic_name[adev->asic_type] both
> provide asic name strings, with the only difference being casing.

That could still break compatibility since this name gets exposed to 
user mode. You could convert the name in dev->node_props to lower case 
to fix that.

Regards,
   Felix


> Propose to remove asic_name from device_info and replace sysfs entry
> with amdgpu_asic_name[].
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 29 -----------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +-
>   3 files changed, 1 insertion(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e1294fba0c26..e11fc4e20c32 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -55,7 +55,6 @@ extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
>   
>   #ifdef KFD_SUPPORT_IOMMU_V2
>   static const struct kfd_device_info kaveri_device_info = {
> -	.asic_name = "kaveri",
>   	.gfx_target_version = 70000,
>   	.max_pasid_bits = 16,
>   	/* max num of queues for KV.TODO should be a dynamic value */
> @@ -72,7 +71,6 @@ static const struct kfd_device_info kaveri_device_info = {
>   };
>   
>   static const struct kfd_device_info carrizo_device_info = {
> -	.asic_name = "carrizo",
>   	.gfx_target_version = 80001,
>   	.max_pasid_bits = 16,
>   	/* max num of queues for CZ.TODO should be a dynamic value */
> @@ -89,7 +87,6 @@ static const struct kfd_device_info carrizo_device_info = {
>   };
>   
>   static const struct kfd_device_info raven_device_info = {
> -	.asic_name = "raven",
>   	.gfx_target_version = 90002,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -107,7 +104,6 @@ static const struct kfd_device_info raven_device_info = {
>   
>   #ifdef CONFIG_DRM_AMDGPU_CIK
>   static const struct kfd_device_info hawaii_device_info = {
> -	.asic_name = "hawaii",
>   	.gfx_target_version = 70001,
>   	.max_pasid_bits = 16,
>   	/* max num of queues for KV.TODO should be a dynamic value */
> @@ -125,7 +121,6 @@ static const struct kfd_device_info hawaii_device_info = {
>   #endif
>   
>   static const struct kfd_device_info tonga_device_info = {
> -	.asic_name = "tonga",
>   	.gfx_target_version = 80002,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -141,7 +136,6 @@ static const struct kfd_device_info tonga_device_info = {
>   };
>   
>   static const struct kfd_device_info fiji_device_info = {
> -	.asic_name = "fiji",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -157,7 +151,6 @@ static const struct kfd_device_info fiji_device_info = {
>   };
>   
>   static const struct kfd_device_info fiji_vf_device_info = {
> -	.asic_name = "fiji",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -174,7 +167,6 @@ static const struct kfd_device_info fiji_vf_device_info = {
>   
>   
>   static const struct kfd_device_info polaris10_device_info = {
> -	.asic_name = "polaris10",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -190,7 +182,6 @@ static const struct kfd_device_info polaris10_device_info = {
>   };
>   
>   static const struct kfd_device_info polaris10_vf_device_info = {
> -	.asic_name = "polaris10",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -206,7 +197,6 @@ static const struct kfd_device_info polaris10_vf_device_info = {
>   };
>   
>   static const struct kfd_device_info polaris11_device_info = {
> -	.asic_name = "polaris11",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -222,7 +212,6 @@ static const struct kfd_device_info polaris11_device_info = {
>   };
>   
>   static const struct kfd_device_info polaris12_device_info = {
> -	.asic_name = "polaris12",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -238,7 +227,6 @@ static const struct kfd_device_info polaris12_device_info = {
>   };
>   
>   static const struct kfd_device_info vegam_device_info = {
> -	.asic_name = "vegam",
>   	.gfx_target_version = 80003,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -254,7 +242,6 @@ static const struct kfd_device_info vegam_device_info = {
>   };
>   
>   static const struct kfd_device_info vega10_device_info = {
> -	.asic_name = "vega10",
>   	.gfx_target_version = 90000,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -270,7 +257,6 @@ static const struct kfd_device_info vega10_device_info = {
>   };
>   
>   static const struct kfd_device_info vega10_vf_device_info = {
> -	.asic_name = "vega10",
>   	.gfx_target_version = 90000,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -286,7 +272,6 @@ static const struct kfd_device_info vega10_vf_device_info = {
>   };
>   
>   static const struct kfd_device_info vega12_device_info = {
> -	.asic_name = "vega12",
>   	.gfx_target_version = 90004,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -302,7 +287,6 @@ static const struct kfd_device_info vega12_device_info = {
>   };
>   
>   static const struct kfd_device_info vega20_device_info = {
> -	.asic_name = "vega20",
>   	.gfx_target_version = 90006,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd	= 24,
> @@ -318,7 +302,6 @@ static const struct kfd_device_info vega20_device_info = {
>   };
>   
>   static const struct kfd_device_info arcturus_device_info = {
> -	.asic_name = "arcturus",
>   	.gfx_target_version = 90008,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd	= 24,
> @@ -334,7 +317,6 @@ static const struct kfd_device_info arcturus_device_info = {
>   };
>   
>   static const struct kfd_device_info aldebaran_device_info = {
> -	.asic_name = "aldebaran",
>   	.gfx_target_version = 90010,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd	= 24,
> @@ -350,7 +332,6 @@ static const struct kfd_device_info aldebaran_device_info = {
>   };
>   
>   static const struct kfd_device_info renoir_device_info = {
> -	.asic_name = "renoir",
>   	.gfx_target_version = 90012,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -366,7 +347,6 @@ static const struct kfd_device_info renoir_device_info = {
>   };
>   
>   static const struct kfd_device_info navi10_device_info = {
> -	.asic_name = "navi10",
>   	.gfx_target_version = 100100,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -383,7 +363,6 @@ static const struct kfd_device_info navi10_device_info = {
>   };
>   
>   static const struct kfd_device_info navi12_device_info = {
> -	.asic_name = "navi12",
>   	.gfx_target_version = 100101,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -400,7 +379,6 @@ static const struct kfd_device_info navi12_device_info = {
>   };
>   
>   static const struct kfd_device_info navi14_device_info = {
> -	.asic_name = "navi14",
>   	.gfx_target_version = 100102,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -417,7 +395,6 @@ static const struct kfd_device_info navi14_device_info = {
>   };
>   
>   static const struct kfd_device_info sienna_cichlid_device_info = {
> -	.asic_name = "sienna_cichlid",
>   	.gfx_target_version = 100300,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -434,7 +411,6 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
>   };
>   
>   static const struct kfd_device_info navy_flounder_device_info = {
> -	.asic_name = "navy_flounder",
>   	.gfx_target_version = 100301,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -451,7 +427,6 @@ static const struct kfd_device_info navy_flounder_device_info = {
>   };
>   
>   static const struct kfd_device_info vangogh_device_info = {
> -	.asic_name = "vangogh",
>   	.gfx_target_version = 100303,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -468,7 +443,6 @@ static const struct kfd_device_info vangogh_device_info = {
>   };
>   
>   static const struct kfd_device_info dimgrey_cavefish_device_info = {
> -	.asic_name = "dimgrey_cavefish",
>   	.gfx_target_version = 100302,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -485,7 +459,6 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
>   };
>   
>   static const struct kfd_device_info beige_goby_device_info = {
> -	.asic_name = "beige_goby",
>   	.gfx_target_version = 100304,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -502,7 +475,6 @@ static const struct kfd_device_info beige_goby_device_info = {
>   };
>   
>   static const struct kfd_device_info yellow_carp_device_info = {
> -	.asic_name = "yellow_carp",
>   	.gfx_target_version = 100305,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> @@ -519,7 +491,6 @@ static const struct kfd_device_info yellow_carp_device_info = {
>   };
>   
>   static const struct kfd_device_info cyan_skillfish_device_info = {
> -	.asic_name = "cyan_skillfish",
>   	.gfx_target_version = 100103,
>   	.max_pasid_bits = 16,
>   	.max_no_of_hqd  = 24,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 1054fedd7b3c..3e11febee7c6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -195,7 +195,6 @@ struct kfd_event_interrupt_class {
>   };
>   
>   struct kfd_device_info {
> -	const char *asic_name;
>   	uint32_t gfx_target_version;
>   	const struct kfd_event_interrupt_class *event_interrupt_class;
>   	unsigned int max_pasid_bits;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 2d44b26b6657..d2bb35f1c58f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1370,7 +1370,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>   	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
>   
> -	strncpy(dev->node_props.name, gpu->device_info->asic_name,
> +	strncpy(dev->node_props.name, amdgpu_asic_name[gpu->adev->asic_type],
>   			KFD_TOPOLOGY_PUBLIC_NAME_SIZE);
>   
>   	dev->node_props.simd_arrays_per_engine =
