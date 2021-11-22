Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F19C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 15:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C5189CCB;
	Mon, 22 Nov 2021 15:40:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D7989CBE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 15:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEz9cg2kNqzWzfW6M4EzwfQr/BN9Kq1pIn58JcHER6y9GKBjI1JkE8MC3mlQoMbZRnvKzTwgoddxZ9oq8m9TGGivrJUfVy5Fhs0NyrmjsD+GIrKAPIX2KyJZwT/ZsUbpjxMi5CU61yDVGNSmu5iK+ukwlGIsETxQ6M1AJkcrW/P8guSsbsYBQyQ/T6Vnh7rs+mpdCcLmfHPE1BOeRMpiVRD4cu7mXJp8smxuTDdWCMNb4AVK45DHdSLFzcj96wn27NKhlSIXqU2BViHP/facf1zm0J8ejFfsp59P+gMw6mf3aZWxDl8jCp77DC2bqZQyDaUFppPtb6mQHP+XXBLNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY13oMrSX0Nplp7h6hUJYhUp9To6iVtq17iV3yG74vg=;
 b=F5WSMtMGcADTo4qYHcu5TGTVNziV+D4yrqpK2Kagzc85Mc1HNu1+EqP2ZtxZd7slpNCBJ6fHtznknUKvkgOyq+NFv4DrgC3VY2w8eIGNVO1e25d6tvX93q5sN1HF6XuxZ6lmaaDp8hVl/vH7iDITXbrOBV8Y2rEDY1EeYWziEmE1xnFk9mg/UlBRzVLGdxRyUNOfbN20y8NT/9z0WOYUatOm5r4BURZMPYARh8I7Hfr8S8VdeXFU3vfVZN2QO3BQWeOVfk5h/vJhveSWmCKRLr2gO2cazO9X+Rb0IX0MPtz7D54E21PkQvTIRyiJe3ZkBjVCV9cVj+aIKIcr2iNgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY13oMrSX0Nplp7h6hUJYhUp9To6iVtq17iV3yG74vg=;
 b=sXoSvsO4bXWTo4NLY8PTHUhbE8VCoYmujgt8jFK15TLSs6Sh3izTnKAfIA6tw3juj68gKm1AkX4Ub3D0GlqNi8xYGb/8k/HHIhGmaGGmrjkipPWbwf+zYtnwTb8Y25W+pxlcLdky8/guuA5NZ7u40b2nGC0dh/163ljhTWB6nvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Mon, 22 Nov
 2021 15:40:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 15:40:30 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211118165737.27432-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9a6d5732-cdbc-1964-0b92-a7b64a7d529a@amd.com>
Date: Mon, 22 Nov 2021 10:40:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211118165737.27432-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 15:40:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a23f05e-8b1a-46cb-d86d-08d9adce6a19
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5308FA5EF1E7A1E1B4CFFDFF929F9@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwIp6Qw0obcM65GvPbIdnnt8KClNN/Lav9dxG1HkV7ynw38ux8HYsIjMmFB6Lw9P2x74bljhA5jw5+9OEYO2Z7WGaoNYdkXmB7pZg9igF3GOVmoz1lrzUns2PATvUoTU2hbRjzFD4kWTgKZOVTdoeLaPD1J8ZDaiMHSfx4SZwKBFJj6JDqGFWfocGu/+20hfJltHwA7FsLnI8tTfkYT0zUr8wZMObQY9tyl5ZtlKgQUVJ1+bIBwXOItI7bxlM7ty26RgDBgYUdjy86kD72aSz6K/H8wkA1MjPM979+YA1DswBkZY0TMrQCHdhnBSPeQMrohlLixZOUmfg6irZmLksM+sspwVT/KAq4Of2SUGNgrrVLAxMY9r5QkdOX1610hokdojVarzu5RgDGAW2sX2aBnOU0pUY9g8ddZvgxuHuTvXXYltjxXhehad+YjB78A38C5fdPPSXgyp6roHofQPK40nmqK54q0dRYP4xaU+kbZhux28pHsDfTmGvKXmjWhlRcBExVzgYZn+hC3rKH1C6aHg1ExCdPsQTUevccF08BeI9XlG3myKcAfKVHqGWnpL8yXp0crvF3b97fkFqZBKRNMyzZ+lI0V0MT8o0jf3FY96sJvm34+v4tiUO+hj0J0cFn9G4B2io3Ag70n8Ng3AlZSP8iluOLb0PL8TmRBa1OY1GzK/6vrKkhJFb+zg2tnQkspYt/KhwE5ahIs9mYI7Z3rax1tZcx8NY0Vt8qNCfS4PryUxu1XMUzCubqgcxMMw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(16576012)(66476007)(83380400001)(5660300002)(4001150100001)(508600001)(66946007)(31696002)(38100700002)(186003)(8936002)(8676002)(956004)(6486002)(86362001)(36756003)(316002)(44832011)(2616005)(2906002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNaM3JrZHcwR0lKSllVYVRmeXZkWFZKYzBWeW5XQ0pZQWFHTEV1QTRnZGxO?=
 =?utf-8?B?aS9FZVVMTUpvY0EybTMyait6dGRoSE5iUEM3Nm1GcldsWC9YVUVHK0k4bWEw?=
 =?utf-8?B?OGphTkI5eFBrRktHUGpLUSsrNXRCVmd5S1BKN3l0dnltV2tlLy9HZGRDbEpl?=
 =?utf-8?B?THpYNkpVaFpSbWI3V1luWG5TenhuMkxsd2grUWJ1SnhGb3dYSDNqa2hpUDcv?=
 =?utf-8?B?c2NpYi9WbFVXcXc4b2VVaGNzQXF2czhwem0wbkwrWERjWHJnWk0vZ2N1bENl?=
 =?utf-8?B?cjBDbjBuRGlidnkyYVpNVDZ2T29RdmRRb0Z3QTdTUDYwOW15empGSGU2OVNp?=
 =?utf-8?B?RThHODk1RnlMeHVlaUFDWnlRVG5CVTZOM2JwYW1wcW0xSkwwOHUyN2hDYTJ4?=
 =?utf-8?B?VGh2VzZQVTFxS2xmMHk2RWsyRndtTExEQ1RsZ0dwVG9OTHNsc0Q4dUxRRm9M?=
 =?utf-8?B?U3dCdFhqb29ocExvTURvMnpIWmhZSlVQQXpsT2xIZzFUM1V0TW1YTVlKSlVh?=
 =?utf-8?B?S3BlRUc4VjM0L1ZSK2hvNm9OR1VKaC9EVkg5WG1xeTc0Tk9Banh3a2VwTzg2?=
 =?utf-8?B?NXBkZXVEbGFGMHVrTGtLS2lkWXhDY3lGeGxLcUtCS00wd1lkT25IRzhwd0tx?=
 =?utf-8?B?UitUaWdCUmJYbnN3SnVzekpRbGptYksxaHlsV1RFcWJYOVM5dU5RQlpydUUv?=
 =?utf-8?B?K3d0eStXMWtzRktuOUdEUTNrOWJXZGRqeU5oa2JFektyWUYySFM5eEx3RFpF?=
 =?utf-8?B?ZGxxcS9CdHlRaU1iWGY0M0hKQTd6WHYyWTZoMDFLTjBKZnZXRUtUTWdPS2wv?=
 =?utf-8?B?U0JTcEFMZG1OSnlzUWw5SlY4a0RjSy9tL3R3djl3R1k2NjlsRi9aN25sYzVw?=
 =?utf-8?B?TktFVENmMzhGQWJOV0E4dWcrNGFVcDZWM1Rwemh0cEdNcGhvSDV0Z1lQa0M2?=
 =?utf-8?B?VFlOZnRXSTRtYjJoWE1DM09MYlozWDJZdzBLVHE4aFBaeE53L2wrNVVhdWVM?=
 =?utf-8?B?VEh3V3VRK3NVS1h1Q0tHRlQ1enMxdDJiSWtPYlFhTEdtNCtQNXYvNTBmMTF4?=
 =?utf-8?B?cVpXQVQvWSsyLzUvTHRYWVIyc3EyQWJ0K2gxakY3UHVMMTV4R2tud1VOOUFw?=
 =?utf-8?B?YmlKWnFBWXhnVlRTTHNmeWgzUi9ScHhsaTgyWFNQS3QyV29BRWRzYVpsRHpp?=
 =?utf-8?B?MmNJSXMyYUg5UTB4VXM4QXFBa0RhUVNLTnRJWWVRM3M5cWdYVERnQVRFMGJ2?=
 =?utf-8?B?MnJ3d1BMR3JML0JVbE5LQ0dBN2xocXg3Q2JSNjZET0JZNmhIcEJBTXRHSHZ5?=
 =?utf-8?B?M3l6UWdYQUtKOVdRSE5ld0lXYWltZkhwOFAyMzZ0YlFtWklCUFZBWUxGbHlu?=
 =?utf-8?B?WGVJcGZGaTNab0l2V2QrbUVEZ2p5ZVJtZW5KMHFCN0x4d1hMcXJlUG96dVp2?=
 =?utf-8?B?SnFyend0UDkyOU9hdUFLRGc3TlU4dEoxSFRoNS9vVks5T2t3Tlp4dW8yS0g4?=
 =?utf-8?B?Z3U3OUxucm5HS1VQMXFxTlVTeUpZUGM1QXMydTdjTU9YMFhUSTY0VFV4RGZ6?=
 =?utf-8?B?d2dVdFc1VzN5Y1VEVXA2ODNFSm14c1lSQ2ZQMkNsVmtJOGdDTUpNaG1NL2Zt?=
 =?utf-8?B?dk5JOGRjSTZWb09jQWpsWGoxUmVNb3k0VUlyeURjaXBSSC9jSE9JeXFsNHhM?=
 =?utf-8?B?YTMxSXVydTExLzM4WXhZT2ZkWkNaaURPN1hrdG5TSU9LSVlOOEVzc2p6ak1S?=
 =?utf-8?B?WnJMNlp1dm1VNm01TW55NDJ4enlJUWRlT1AyV0txRjlFVTJ3QkdLSkRtV3ZO?=
 =?utf-8?B?VTR4V3lxRGx6T1prdmdNczJQYmlnU0drbUs1VFF0TlRSc1lvMjJJY3kyK2R1?=
 =?utf-8?B?MnZSRGw4Rzlac1kwNXVuM05QUWNoWmVxcFByUVhBK2QyRm55RFE4S0YzNy9a?=
 =?utf-8?B?SjlmaktBaWNSQzU4bCtsZjljd0Ywa09NMnZadVBQNFQzMmpKM3VsS3FrNTBY?=
 =?utf-8?B?Smg4elZBWXZGOHhuWFNnM3dsK25EZ0dYV0d5NzBnR2lSY1NPbVVkVjFBZ3FO?=
 =?utf-8?B?bGpuTmVSVHQ3TWZab2JUMCtrVHYrNFY1aEJiNThhM2x4cytxbWltRUNRTmZw?=
 =?utf-8?B?SFhuSFBKVk9ocTZGYndBcXpJcXV5V2dWYWhMQU1aZXN2UHZoZ3AyejdUKzlF?=
 =?utf-8?Q?5atiI3tRhERwF1QkCIKrO7A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a23f05e-8b1a-46cb-d86d-08d9adce6a19
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 15:40:30.6041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ho7Hj16HWeKH/z9/N4DllVgTdfCWGFpO13hHyj0rFELZA/2Z3ytGFTNJGNYDh8ACemNFW7rjDJIw41MrqqO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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

Am 2021-11-18 um 11:57 a.m. schrieb shaoyunl:
> For sriov XGMI  configuration, the host driver will handle the hive reset,
> so in guest side, the reset_sriov only be called once on one device. This will
> make kfd post_reset unblanced with kfd pre_reset since kfd pre_reset already
> been moved out of reset_sriov function. Move kfd post_reset out of reset_sriov
> function to make them balance .
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Please change the headline prefix to "drm/amdgpu: ". The extra "/amd" is
redundant. And I'd also add a tag

Fixes: 9f4f2c1a3524 ("drm/amd/amdgpu: fix the kfd pre_reset sequence in
sriov")

Note that the commit hash is the one from the drm-next branch, which is
what will get merged into master eventually. With those changes, the
patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 10c8008d1da0..9a9d5493c676 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4308,7 +4308,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  
>  	amdgpu_irq_gpu_reset_resume_helper(adev);
>  	r = amdgpu_ib_ring_tests(adev);
> -	amdgpu_amdkfd_post_reset(adev);
>  
>  error:
>  	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
> @@ -5081,7 +5080,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  
>  	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>  	/* Actual ASIC resets if needed.*/
> -	/* TODO Implement XGMI hive reset logic for SRIOV */
> +	/* Host driver will handle XGMI hive reset for SRIOV */
>  	if (amdgpu_sriov_vf(adev)) {
>  		r = amdgpu_device_reset_sriov(adev, job ? false : true);
>  		if (r)
> @@ -5141,8 +5140,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  
>  skip_sched_resume:
>  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> -		/* unlock kfd: SRIOV would do it separately */
> -		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
> +		/* unlock kfd */
> +		if (!need_emergency_restart)
>  	                amdgpu_amdkfd_post_reset(tmp_adev);
>  
>  		/* kfd_post_reset will do nothing if kfd device is not initialized,
