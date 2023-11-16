Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7A9C197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 11:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A94010E271;
	Thu, 16 Nov 2023 11:28:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC4D10E272
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 11:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPwhtdFLOz9+wsnCIiX9MZxqgA8/JgXHeBIf72+EOa2LS9PycLkzFiAzsxyxf7C0p0ex/tups+CJZ2XNW4agCMJdk3H66YPWaaI9fmOI5J01DXjtkDrSg9JkGFhQtjbwRych8y50y8nefy14388mSeEun2nnY2QWhOzJpUazQd1DfXFlvdbu6UPc8SqSzahnDEFbJ1avzdMkL7wevM5HlqzYdhDFkuhvRGHgj2a+etO1QyJR9wiKsSrpj28EyVAAIscCQDYl25t6p8T96mHpUH15IO3R38FbBXi4OA9aD7WQgpUmit10D7UDFtuST7Rn/NEbDFqgNpwI4NPf5M18Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6sxAq1XJWPSsuLZRyxFVrWi5aIJVqCjVX0QBvjSSmI=;
 b=fVbo+2IAidS99puKYTp5xsHBigrVQXqbKRYPrucqynwrn3PQVN5tfqlzWziS1GZm263uGYHRcHexUuK/3P8eqzEZC6dzh0FH1TctuOq2SmExY6WczrHiOoqDRYbyMqqvinbrG0e3ZFxMnS8fBJk3cAdfaM0XiCi+CXgDDCIG0+kfjfppJQPb+4MY/Cysnrc/2x/dJHFquy0piIrhTGwV3RPaEimX+VHcEpZ6oRD2H1RO/C3gh3mF9rzC4ISi2a/YASG/buEPBI6lBtWqkFknEVgkuDm/BkL7xtIO0Y2wXBtCcwnPMIRhtlF3LgiCQ28/y/Dt5sutNCRBbz+XG6CA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6sxAq1XJWPSsuLZRyxFVrWi5aIJVqCjVX0QBvjSSmI=;
 b=AXvVE50C2gMKWjO5G2pIg8wTskoCXYnXEsjIwI0PGGqcYzz0U0ase+ewEVzhg42jls5nxmYnKzA3HSl74c5ru3GP0rSqzZtNowwd0SFsWAPq2JSRxhCNt/PP8xE0/lBJ1kbDpA6l7pTu7KGApAvpvR9tAlCQHFLgwK6LYhMluu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 11:28:01 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510%5]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 11:28:00 +0000
Message-ID: <60914753-9800-5fa7-6796-45c16e21fcfa@amd.com>
Date: Thu, 16 Nov 2023 16:57:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] drm/amdgpu: Move mca debug mode decision to ras
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20231110075547.565860-1-lijo.lazar@amd.com>
In-Reply-To: <20231110075547.565860-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CH0PR12MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 018b45f8-060a-48a3-7412-08dbe6971693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dd294e0eC2lqsyTQdie1E2TklKchpmawhJ/DJTK/iR9+Gn59d03hD61nqBMQXRyDxYQQVGfDHpMf9/qD//5zUs7LY9fy1hyjzxgGvdo/GhTyqoKl3NmNM0FHxkWpGE5eS89nAoxhts0TuvocgZmuX8D1HoTRpHu9T9MmTspCIRTcRc99oeY3BYSihTDLy5SvPTqwvH0H9iHw2s9Qy8hhlRXE5jEtMRe+VOx2gSr3vMfqngZmM8w143SuYUkTh76RgD6hxzuX78s1JlSmxuDtufApp2jOuv7ujTys5vNXl6hTot/jGGE5j7y3p1iampGZYSjtSmasgOr3b6tM5B8Ci0SRbm6m1cKh6BVe3kejB3dpJNwWi99Tviermob6nrQzVUi+XT+ATPbVdfRvCB/2mNZCRAgp9jWi9/kd1bGITxdBmfjDW0rOLyavlpCaQsGPnO7R3bjYYM+jxYZtQHfEHST9LUzHuofpq8HlF9AO25SAWUkyrfJj6TkVntziw+zqzK4uc1Kc0igDgwxrKga43xKQp16Dh3Dki5Tpd1PigxX5aKvUCgUCQdwtJ5CE9jsoIjCMyq1QFcDHrgtBReUA3yi7caisOVn0mFuSPlp4I2eo56Zh1pGHM6ZySeCr4dBPSHnQjs8FDx49WaM9xzkqo6zNC9g31Sug36tOF11Ss6FnHg9vV9CvhgkTuuoG6w37
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(6512007)(6916009)(316002)(36756003)(66946007)(66476007)(66556008)(26005)(2616005)(6486002)(478600001)(6506007)(53546011)(6666004)(31696002)(5660300002)(86362001)(38100700002)(31686004)(2906002)(83380400001)(8936002)(8676002)(41300700001)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThiRUFhbWliQlh0RlhjVkcwZ0tLV2MyalJCMXhRZVJyU2tUZnFvOVVPcEFn?=
 =?utf-8?B?ZEVjcFFlb2dGQi8vTG9WWHNWMjZMZ21PMkhOSFVsS3kxd2JRSUo2YnJ1R3NU?=
 =?utf-8?B?enl6T0VZTS9qTyswQktOSlB6QVB4WGgrSTZNc2RKdk40VG9hWUVCbzE2S0dt?=
 =?utf-8?B?dmhzWlI1SEFUdzNXcUR4ZUFWZ0VzK2VxSnlFT0ZPNmdvcFBwNlArK3lpWG91?=
 =?utf-8?B?czhSU1BiM3ZhSm5JRTd0VWZCbGFseHN5WEdZQlBjdmh3QjJMSUgzeEY1ejZQ?=
 =?utf-8?B?WG41NUxibWZaUzE4VjJLa0tSUkY5UGgxdWlrVGlXRGVZczRDS0dsVnQ4LzlQ?=
 =?utf-8?B?bjNpT1pPWlJRcWNFRVh3VEdPQ3htM1RoYW5jcVRuS3FDUEdBU3BIZnZzYXhq?=
 =?utf-8?B?aHduazdqRnZxNjVGQk55bXVaejE1ZEJRZngyKzlwTmVpY1JVSHJFOUFwbSto?=
 =?utf-8?B?M2NSTE84S2RHRzhRL1lrSDg0QXphWWJpTndZWDluZE9vbmQ5dWhZUllPVHZ0?=
 =?utf-8?B?MHVYY1JJTjVnaUs1RWxlTjVLa0kzd2lhbkxlZEttMXpwaGdpYnVOMG5QRFNn?=
 =?utf-8?B?RjBJZjlqYXhJNTg4KzE0ZUtmTVpQNVEvbVliaDNVb0R4WjBpQ1RKK25QVXRU?=
 =?utf-8?B?RkErTmIrK2dFd2VMMUNXdEZiSTJOdm9SZkJzeU93NEsyMXp3Vi9lL29LNFdm?=
 =?utf-8?B?amJaSE5mMGxjYUp0T1AzR3BXOUUwMDdjclhOMDVDMGxYa0d0RCsxdHQzaWhw?=
 =?utf-8?B?L3FKbDIvVXRmZjhoam01dEUxM0ZZZ1diaEl2Rzh1Q2VrVGdQRlpxUU5aT1Nr?=
 =?utf-8?B?TEtlK1VJY0t5L2xzMnAvT0MzdFo3THM1ZXM0eGNmRmFEZkl4RjFjT3VBZ3ZL?=
 =?utf-8?B?RDl2YU5vZU1nWVBoSFFHMmM1MkM3K1h0K0RZV3BxOVlielNsUkhYeXVWWlpk?=
 =?utf-8?B?bFRpMEZ5SWtGR2hZMk5SSXp1ZFZkVXhZakgzRkdIbkpNVFAwRGhYN09zVElM?=
 =?utf-8?B?dlBDWmFSRFBVTUpPUFN0T08xbFAyWFhBRmFESHdjSENsc01DYlFXNEc4aklh?=
 =?utf-8?B?d3M4UFN0N2dZMXNxUksxS2M3c0hOUHRFRHBlU1VCeWpHYTdQd2J5TXJKQUFR?=
 =?utf-8?B?QWY1eUhJWFd3OFJBdWpyREp4ZmtDYjhMS3J1VVZuZG9LZkp4TVFneEhZdnpl?=
 =?utf-8?B?Tm82NEt2SkV4Yjh1bUo4M3lXb2YxV0xmaDBCK0xOelJNT1RoNlpEUjhXVFB0?=
 =?utf-8?B?QXF3c01lODlNWFlDSjJtMFRYcG5uaXdCb0xITHFiM29MOFVER0VNdkdwWlRH?=
 =?utf-8?B?V2M5UGVudnFDazdqTnh6YmI0K2ZJU2ZyVGZCc2pQVmQ4U2Jla3Z6SnRJYTBL?=
 =?utf-8?B?dWNMVFdFYnEwVjBoUTU4akoxSFFGdFRZUWJxdVN3bGV2N3lrT3E4TkxtRVY4?=
 =?utf-8?B?THlwMXRGcEVVWTVta09OdU0wZ002NkhlTWxIUDhhUXN3OVkyQkNscXlEUXZN?=
 =?utf-8?B?dnRCMmlrcTNhSVdIREcyZzZ5NWlCMjF0SlhkdW9mQWlzRENXaXpLa0hrQ2li?=
 =?utf-8?B?Qk9yV0x1UHJLby9mUEEvZDFpUzVBV3F0UU82M0ZiR0UvREJvTDhWTlA1VXB4?=
 =?utf-8?B?RUwrRmIreUhrdVdnc3NGSHEwZW9uTTA4YWM0aHl2YndoVjVub3FCcmZOMzV1?=
 =?utf-8?B?dWFmZGpOVTF5UmdtWmY2cjVINHV0NTduRW1YUmRtZEJmb1VmdXMxM0hvYldi?=
 =?utf-8?B?RWdSYll1bkZUYzlPRmp2Z3pCNDVKZ0VMd2V4REdYN3VaU1dUSER2ZVhPQ25O?=
 =?utf-8?B?VVZQdDdoc3g0WFRRcnhEai9kajlIZitKdzRGVTc4b1VWcFY4ZWZnZElkM2Rv?=
 =?utf-8?B?SXBzdktCRGdFdVk2YVZIRVNRMVlKMEt1RHM5L2xIenJpSVZ6ck8rVlBBR2lw?=
 =?utf-8?B?cEtITHlCL0lkekJ3MS9DZ0ppb0dpVVA0Z1FJQzlCTlBXbWtZRmpkbWFVUmpo?=
 =?utf-8?B?N3Bob25qMDN0a3JEM2l2YW9UZkFJQ2JRbjhtMmtJMlpuQzd2RzlMVnlxZWE3?=
 =?utf-8?B?NlJCcks1bENmZkk2K1l2OVZtWkRiMEdCdkUzUmZBYkJMQXhjRUc4WmJ5enQ1?=
 =?utf-8?Q?9DUpdFN4L9/Z08OkI2Hlan66m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018b45f8-060a-48a3-7412-08dbe6971693
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 11:28:00.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccQ4txzyRtx8NhByU5v/qQbz8TMp3sBdRpWSqlAnRl3cawYJ1Jk4RQ9a1vvS4KAl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<ping>

On 11/10/2023 1:25 PM, Lijo Lazar wrote:
> Refactor code such that ras block decides the default mca debug mode,
> and not swsmu block.
> 
> By default mca debug mode is set to false.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
> v3: Default mca debug mode is set to false
> 
> v2: Set mca debug mode early before ras block late init as ras query is
> initiated during late init of ras blocks (KevinYang)
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 14 +++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  2 +-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 12 ------------
>   4 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index cf33eb219e25..54f2f346579e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -377,7 +377,7 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>   	int ret;
>   
> -	ret = amdgpu_mca_smu_set_debug_mode(adev, val ? true : false);
> +	ret = amdgpu_ras_set_mca_debug_mode(adev, val ? true : false);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 84e5987b14e0..6747fbe4feab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3132,6 +3132,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> +	amdgpu_ras_set_mca_debug_mode(adev, false);
> +
>   	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
>   		if (!node->ras_obj) {
>   			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
> @@ -3405,12 +3407,18 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
> +int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	int ret;
>   
> -	if (con)
> -		con->is_mca_debug_mode = enable;
> +	if (con) {
> +		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
> +		if (!ret)
> +			con->is_mca_debug_mode = enable;
> +	}
> +
> +	return ret;
>   }
>   
>   bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 19161916ac46..6a941eb8fb8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -773,7 +773,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
>   
>   int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *ras_con);
>   
> -void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
> +int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable);
>   bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
>   bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
>   				     unsigned int *mode);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 6cbfb25a05de..f09f56efbdc3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1516,7 +1516,6 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
>   	if (smu->smc_fw_version < 0x554800)
>   		return 0;
>   
> -	amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
>   	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
>   					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
>   					       NULL);
> @@ -2338,16 +2337,6 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
>   	return ret;
>   }
>   
> -static int smu_v13_0_6_post_init(struct smu_context *smu)
> -{
> -	struct amdgpu_device *adev = smu->adev;
> -
> -	if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
> -		return smu_v13_0_6_mca_set_debug_mode(smu, false);
> -
> -	return 0;
> -}
> -
>   static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
>   {
>   	struct smu_context *smu = adev->powerplay.pp_handle;
> @@ -2904,7 +2893,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>   	.i2c_init = smu_v13_0_6_i2c_control_init,
>   	.i2c_fini = smu_v13_0_6_i2c_control_fini,
>   	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
> -	.post_init = smu_v13_0_6_post_init,
>   };
>   
>   void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
