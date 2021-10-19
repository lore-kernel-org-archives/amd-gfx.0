Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09621C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE7461154
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAE7461154
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F676EC1D;
	Tue, 19 Oct 2021 15:41:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0E06EC1D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 15:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqvFuc059V1shJtuHXAqaKa6lu9/Y2oTkjzV4d64ZoicOkQscZnHfL/QLsX9jPCmxWdUuf7dV3mBOhWwVa1ig6hSbzUittue2oTMVNw8qfICYcPUHNCeKqP3KN7D6lq1Uxc/iwdUc9FvRyV5jy8Ae/cakrY6ahr593UdwfWNmGecGTdUKyCQBfgXL/8KFyzB9IaeWfk/aU6MWJP6Weh+mbmrxNeuGwd13WU8hDNyFYkRtgc1UNkHwd9+gh9Yk2Lgs6MmuZUA8NCE1hHhP//h+NEJnboPExeYcuhdxOR4gzlNiNzjkCB7QL9wq993A6CBmyDAWFeqeDnAtMpNichXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMEMKcGsHGE1nIY46jUIYpBBmOobyD8NRyFdiJdURSs=;
 b=YZ/1hKAl3VCGuigAf0ggQkS1g1WG52F2SlnxdJ6bhyo9R8EHvDDdj7H9iGzq6WI3Z5LkxKc7oOIPA3SDP/CG3JfhbGnJ4aa2GZ5BO71dvHpwCQgcskWmsGdHs1kEQ3V+vpNCUQKJd/LoA4nNJEczhh6uV4AO/kjQS/LT+UzZNS7yIpw1dAez+/nF6DAnxw6lHFQqFwhYpacjdCyDijEDBQnXh8G//HS0KERTe7x+2pqj9AG3F9GhlChEG3Jjc41gC0RE6CbI6uSiNxThQtpvJ9SDQmsZ1Ck1QLj706wRszP9Almjvi613JUIbRiLkrS8klY70anNgSleyczHK4Fl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMEMKcGsHGE1nIY46jUIYpBBmOobyD8NRyFdiJdURSs=;
 b=4wEbGT2mTQiAnZeH0iY2e/rw44Lzojr8GATLnd0o3dlzA3nlb0PLafOFXPlOi82jAi2HO7bS8KJ/h6/tCbRdLpQwqMyMGmNftSCmymARtXBl8VWX6HVEVLBeRq2uthFMH34D8jqGQCzDa6adaD5mSnMyoX8IjK9HeP3rl4WdJ1U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB3563.namprd12.prod.outlook.com (2603:10b6:5:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 15:41:14 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4608.018; Tue, 19 Oct
 2021 15:41:13 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: recover gart table at resume
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
 "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>
Cc: Christian.Koenig@amd.com
References: <20211019132200.10352-1-nirmoy.das@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <28201f2b-e524-4192-bafc-29c5871fbb16@amd.com>
Date: Tue, 19 Oct 2021 11:41:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019132200.10352-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: LO4P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::16) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:a4e6:969e:ec:4698]
 (2607:fea8:3edf:49b0:a4e6:969e:ec:4698) by
 LO4P123CA0029.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:151::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:41:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efb24376-3ee3-4f9b-782d-08d99316e1bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3563DE6EDA8AAD9FE6956743EABD9@DM6PR12MB3563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5j5v8eyydgRXSzs+GBFuW1GE16fbMNzPKYZFr2CfvliwTTlDITwqbvL07gNITF2C4Y0GJyvkx2AR+QTt+g2iQ6Zz563PPizrUh46lMv45kY8PmUigazUMraiXMHxxGvd/QOY0aAzONanuSfVehqfcxvlvXCjwNCQdkUO2WHe4aZAdl0r4vS+w3xP3pm1F20RTmJIZni2vkfgpp7Mbgc21aIR770vBdn9dhqXi65dQygAzCK+vTJrbdzHRbYbAJfyle/bN/9Ri++fvvEo2YMcJQjXjszcgZPJruc9Lyi/ekn4Llr7LyKCCpM8KnGHIZUC+jXhgxLMmD37puyluNmdHulFE/KnCYsmgrL1MlrNhQ1QTSy1QRnYneljp6bC5eIuI095mEkJWksxOXmO/NXuyffkgbhP0mMQiwBLTY6NdAOJUxyz8xpJ4nE0KJDJwDNB46T5aLler4r5w478XwpmLfl4Lia4Gox21mi8RNVG/m3hxbqFaiBJdB9mUwYB8FmkxsFuYfk125Yc9o2XO9piTyTmBBJ7+n86ezjI4Ic6qEEn6qPWq64llcH5FbNO2dVA+OHpBb6LhMEuyBYHo8DqVhKIBfQjBgfY208Ca9YJ27lkU/cIdtU7AlCfE0/n2sclD7zxPiBVFEIyAqRJ3Q21C1m/jRg6/VULTRozD+oIQ+dfj3Q5nRC/pcHqq8PLQjzb59dw/JZCUW/cg4Q4YkJjkS9kZ0DklDxomNi+Ib1PhJBtEjwDdY7/u+VQBsBzAzw7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(31686004)(6636002)(4001150100001)(186003)(110136005)(31696002)(5660300002)(83380400001)(86362001)(66946007)(6666004)(38100700002)(66476007)(6486002)(2616005)(8936002)(8676002)(36756003)(316002)(66556008)(44832011)(508600001)(2906002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFNNTJGNncrU0dCUi9Td3RzS2VFVFcvNXdWUXU0a0ZJeUVQZE4yVE80RWJl?=
 =?utf-8?B?em5HMStlUk5TSlFpVWlQbnlMU0dLZHVXNDVJWmxCYUVDbE5iOWJ4c003T1NV?=
 =?utf-8?B?NGlQbHo4SHh6S3lOZ3M0dUwxZlJ6Ums5TXNQaU1YYkZyVGpaRmZXVnZ3SndL?=
 =?utf-8?B?SU9TWCtjU3U2QlZjRnE2L0tvcnc5TitlaEJmRndZSmE0WGd2dHVQR3F5S0ZF?=
 =?utf-8?B?eWVCRG5XVlpZSlVOTzE2N3lvQ0dKdGJ0dEtPTVVOVndMU0g3VWRnZWlEdGVj?=
 =?utf-8?B?aWhZbnBXZTBCSDVqYWorZHIxdGxKOExRWi9zOWZpRVdQWjZjT2Z4NDVucVF4?=
 =?utf-8?B?T2NqcFRSZkU4UGVvbXlaNFBlQUhnL0FLODgwWHJVRGFWbjlNWlFkcU8rRkVi?=
 =?utf-8?B?ZENyR2lLQTlEc0N5M1dCZllLYjVrM293eHd4dWF0QmFyeTBtNWVuQlFsRCtM?=
 =?utf-8?B?bElOOGNaSW8yMUE1L1VrWG1HaDVYZlJWVWZIWm5MS1hOcEFGUysvMERtdGdi?=
 =?utf-8?B?Yy9MdFZVOFIyS0l3K0ZxZG5QMU5DN1AyaGVaY3Y4OUFhblhaOXUybm1IMXpV?=
 =?utf-8?B?anFUc010TzlZKzQ5V2NvUzVLWUZrZHg0c2NPWi9lc2hwbnZqSVZvcE8yNjFR?=
 =?utf-8?B?ZGFDbTZMRnBCYlEydVkraXU4Nm9wS3dUZU9FOGRDVmUyYVlMYVlVZHlBdHdl?=
 =?utf-8?B?QXJtVkFSRVRjM0pNNmhFSGUxeVByRThuaTYzZzQ4ZVNTZjdSMkdqM01Oa3c4?=
 =?utf-8?B?djBMUVcrUGpQeDZRaTN5emtibUJkLytBSnVOdS9zNHBMa2czWExjdm55UFY2?=
 =?utf-8?B?cVljUm5pU0pJZHR6ZU45OUM1bVBTQmdtTnNETVlYOXBaSXF6eTV0RzBYaXhl?=
 =?utf-8?B?VjM1R3lDdUVvTWRlQStXbG5nQ2V6ZExHVUZBZTByRnFaZTZ3MDcxOGlod200?=
 =?utf-8?B?Vnlna3YySENDRElrRGxvVlBmK0pNRnNOVTFkblJpQllqYk42eThwaGFwbzBa?=
 =?utf-8?B?Qy9zVmVCbXl2aFdCWFlScWQwMnBaVDZvZnUwaFZYcWNDclpSNDNqN0ZQUnVn?=
 =?utf-8?B?bTZzWXZHNC9LRFJKVWdEOVE4bGNoby9FbzNqSElETW1VL0gwdkdBU0pBZTBF?=
 =?utf-8?B?SnhMbTYvRk43R1UzaWlhRVJ1bktqOFZIaHYzb1pNeThQK0xDTUh1OVdheG4v?=
 =?utf-8?B?b3VBRmxQajU1YmJ4Yzk1L0NiT3N0UUpReGNheUdRaXpxVnVQcEliK1oybXhI?=
 =?utf-8?B?M2FuWnpUZmlRMVllNC9UcFpBb04xajdLb3V1QmIvWjRac3VLTGM1TnVGbmJm?=
 =?utf-8?B?TnVpVURuZEovVXkrbmlZd1FJK1grT0l4aTJuTTNSY3diVFNES3UyeTJPTkJ1?=
 =?utf-8?B?S2xCQzRxMmlLZStMbldzUUcxSU8vUkpTZTZqMy8xVjg4RG0rU0NXNytveFpZ?=
 =?utf-8?B?dGdJbmVJZ0VMYXdhczFYeTZsemdyVDB5UmMrWm5sSDVuR0I2NkNXV2x5NE8v?=
 =?utf-8?B?OWxzakJ6eWNHMWVybXZjMjRaL1JNekVaVU9MZUxVOTBqYVVqNGM0OElKVWJJ?=
 =?utf-8?B?eVdTdlM1OGdReEtGT0wzTGFDaFJYRzcySjlqQWJTSXF4NXlnb1JnMm5rTWNn?=
 =?utf-8?B?Z2p1ZTJxbFBRU3JsOXJSNXNoTG5tRTF6VjFqQkRpdkYzc2R1cmkrcVJ1azRB?=
 =?utf-8?B?eFd1QlRGYUFUMXhOZWpkdU1WcWxLSkFSb3VwTnJxOG9iSjhXSXowMVNNU1Z6?=
 =?utf-8?B?Z1F2eDJUaEtyMHkwVDVkZUVTdEVrUThHQzFXNzc2VTd6cG9uTjlIcXdqSU4v?=
 =?utf-8?B?c2taQkJiZytHOUY2QjhvVHNCUWlkaGNldWMyYm9wbGtrOEVaZEw0NTJtb2VT?=
 =?utf-8?Q?zMAvkNMy4E2ja?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb24376-3ee3-4f9b-782d-08d99316e1bb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:41:13.7048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeMDHU7FmaWY1yTikw6MHOjYQVyeyiHg46WCvhfVckq9ctftqc/P41Lj5qt/JoXSTQGCH4e5uqVwKYbC32urTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3563
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


On 2021-10-19 9:22 a.m., Nirmoy Das wrote:
> Get rid off pin/unpin and evict and swap back gart
> page table which should make things less likely to break.

+Christian

Could you guys also clarify what exactly are the stability issues this 
fixes ?

Andrey


>
> Also remove 2nd call to amdgpu_device_evict_resources()
> as we don't need it.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 -----
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 16 ++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 17 +++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++++++----
>   4 files changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41ce86244144..22ff229ab981 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3941,11 +3941,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	amdgpu_fence_driver_hw_fini(adev);
>   
>   	amdgpu_device_ip_suspend_phase2(adev);
> -	/* This second call to evict device resources is to evict
> -	 * the gart page table using the CPU.
> -	 */
> -	amdgpu_device_evict_resources(adev);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3ec5ff5a6dbe..18e3f3c5aae6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -992,9 +992,16 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (!adev->in_suspend) {
> +		r = amdgpu_gart_table_vram_pin(adev);
> +		if (r)
> +			return r;
> +	} else {
> +		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
> +							    TTM_PL_TT));
> +		if (r)
> +			return r;
> +	}
>   
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1062,7 +1069,8 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
> +	if (!adev->in_suspend)
> +		amdgpu_gart_table_vram_unpin(adev);
>   }
>   
>   static int gmc_v10_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 492ebed2915b..0ef50ad3d7d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -837,9 +837,17 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +
> +	if (!adev->in_suspend) {
> +		r = amdgpu_gart_table_vram_pin(adev);
> +		if (r)
> +			return r;
> +	} else {
> +		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
> +							    TTM_PL_TT));
> +		if (r)
> +			return r;
> +	}
>   
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>   
> @@ -992,7 +1000,8 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
> +	if (!adev->in_suspend)
> +		amdgpu_gart_table_vram_unpin(adev);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..1bbcefd53974 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1714,9 +1714,16 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (!adev->in_suspend) {
> +		r = amdgpu_gart_table_vram_pin(adev);
> +		if (r)
> +			return r;
> +	} else {
> +		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
> +							    TTM_PL_TT));
> +		if (r)
> +			return r;
> +	}
>   
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1793,7 +1800,8 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
> +	if (!adev->in_suspend)
> +		amdgpu_gart_table_vram_unpin(adev);
>   }
>   
>   static int gmc_v9_0_hw_fini(void *handle)
