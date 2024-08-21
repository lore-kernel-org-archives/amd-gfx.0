Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A98EC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 20:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD1310E2EB;
	Wed, 21 Aug 2024 20:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T4t6k56p";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC5910E2EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 20:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJxEOe4Q+fc3MGZcUfc4XKHPm4nuKftQ6QhLfEKbqshm6r7iIbZT9RYW8ejiIkhGB87C8BP3EsTRxEldgYfoG9NCSe6NIL8wHf2vWuuo7t84yJmghiW79GbBv2AmWx6sa2TLcnShuWHFjoYjx39/gYWNI8vuOEO7g40ivcxiOp2fsqWE0XdNHdc4S1yMABzgDEhk+k7RDw0XodVCa0l74vmx0M0p9jHCxamKL5lWnQ9cIWnUt9ek1W8MJS6kCM7BpTSwB3NPokhXmwBwxrHCm5RIminZX0d8QNpQGnwSMHrcig8eQ//2MNJdyFhx7xKKzykcoL3Lbin76OQPlo619A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/VZy0t4chHlri8AtIxR70T57gdbLBH8dBAWYm11WoM=;
 b=vmAwXOFSCarJOW6n4UMz2E7NhGLrby59WZ2ShlY2oWlMtulZFkwdaUPnVI+og1uQwZpkO9RFyENqVVGdW20pIYewIvWlRWT5XEu8pLEk+poLuj2VcdvWgMVzJ/FRaAv68PXeQ1gWK6aihMp+TUZUi4LbxQlUaAlXnFAy7IgoKtdwGXCs2zJG5ji+Fu4SiNF6gz8xM8KHvk3pH8Kivx/y9Wksu8LIEH/sfUXpBoSrHAILWEOOD9FHXoejj1/UbhsPIq91o+xk0tzpsRqa84v5/yppAt9pPPxUqC/XDXNAST5vxdtROrJlFnHBjMYb+KcWT7/7FTQrX7OD2ejYZrtHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/VZy0t4chHlri8AtIxR70T57gdbLBH8dBAWYm11WoM=;
 b=T4t6k56p95TXRCwWQd3+ldG7AItfmv+ZCb0O446MnqOuCw6Uhu9CZqtj9PA8gvGhlzT6+Pg8/lcyxGrzlkDz0Zwb3iwQM7Wr32G2AwoEOxQ4u3EpvQnwsrhLPXltl5Q6oRUTzzmwmP7OsHO16kq8OYk8PMhYTEuGJqb0TEO+xow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 20:46:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 20:46:18 +0000
Message-ID: <2e24ab52-c5cc-4991-b610-df0681410229@amd.com>
Date: Wed, 21 Aug 2024 16:46:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: re-work VM syncing
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 friedrich.vock@gmx.de, bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240821120324.4583-1-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240821120324.4583-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bd6e26-2673-47e6-0407-08dcc2224e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVZ1S3dNcGY3VHRsTTYvN0JOUGE5ZGpPYkYwbUM4UWUrSUhTMXRsU2FqQkRS?=
 =?utf-8?B?WjNWRmJmbDZwK0NvenpWOTZhVEFCUUpDSUV0VWFVQzFOTGFteUFIWjVtT1g5?=
 =?utf-8?B?NzA3T3VONW5yRzhqUC9EbHkzT1hsdGI3eFI1UytianJHV2FWMS9CUnIvSnhu?=
 =?utf-8?B?akkvSDViK3d3NEVPbHkva3lJYVlpYTRZQVE4U1pOVWJTUldjWGdyTS90clNm?=
 =?utf-8?B?K2JyUSt6bUNJa1JXd1NoM2pnOWt0VVg3M0F1Y0thRFdrRnhQa1ozbkVRTWR3?=
 =?utf-8?B?TXk0UnU3Zk83UkFSNnh1ZW9pRGJPdUh1RjZBVkZ4NDZWUTFvdW9LQnBUTDl0?=
 =?utf-8?B?QVM2cFRQTFphSTdyVHMySWVJRmp4YjIxUkxyVkRVaDBtVDlpVFZQSnFOam52?=
 =?utf-8?B?cThFdmN3V3k5aFF1VTZGY1RpdmVpR1U0OU9GZ1BDYVJiM2VzOGpmOEs1alNT?=
 =?utf-8?B?NUVDL1hxMFYwVXk5QXBkQlBBUUkzVXBjK1ZscTZZbTRGamJaekY0ZDl0MjBy?=
 =?utf-8?B?UG5WUUVxSDJBYkN0dWxjeWdPWWFLZjRxRmhZVUxhTC9SRmR4ZTd4a1dxL1dw?=
 =?utf-8?B?QkdSdlFQazZvTmg3Nko1ME9MVkphcTZqRzBsOU8rc2c3NjBWR1NxN2kxQVZQ?=
 =?utf-8?B?eWZiTzVPekdjZ0dTMlRQM1Q3YU5oV3YxcFp2ZU1TTEYzZ3J0cXVMbFVCcm54?=
 =?utf-8?B?MVlSYy9zVzh3aEVoMEx5R3IwWHpHbXF6eVdxKzg3c2cxWFY1OFdHY2FFNVJM?=
 =?utf-8?B?cXBXSVNIcXZnU1FWNU1YZzRkbE1zSnBrWUJDQVFaVHVuR0ZoOFY2RWxBWjRY?=
 =?utf-8?B?TXJRQmZUN3ZhdGk0RytKYStnZFZaQldQbFpVL3pxaG8yUDBMQXRtT20wU2lj?=
 =?utf-8?B?ckhYaFhTOXM4UzZ6N3lUR05kK1F3bTIzVEN0NHBaL0hHb2htMXFIcUhiSzJi?=
 =?utf-8?B?c1dGMDN5VVhtVmlOa0hVSk1NYUY2a0ZGREdDZFd6OWZ2Ri8yanhITnBRbkIy?=
 =?utf-8?B?c05Ha2dPNzlDTG9HcjNUSnA2SCt2cUM3QWpqOGxWdllBdnV3OWVSUDc0OXRu?=
 =?utf-8?B?bHk2MkY2eFV2MWJ0SEp6VGtGcTZSTlAxWWkwdyszSEY5OHo2S1d5dll3bUpk?=
 =?utf-8?B?bVlFSm1lV2FOcDhmM0g0Umc1dklocGFtRmcxRnBLVUdjVEtqanZYOUNmY3VY?=
 =?utf-8?B?bFFmV1VjeDlEeS9rV1FCeWZ3dSt4U2FqVE5CZ0FIekpBbFQ0TG9xM3pzZjZG?=
 =?utf-8?B?cGxIOXpWTXh0OC92M2ZGaVlLejhJbk1yMTh2cnpSQkY1RUhucHVtUDFVd0F5?=
 =?utf-8?B?SDBzWGovQzE1bjRzWXROUTRCSG5PUnVhamQvNThId0Yvc0dXb3c5VndodXoz?=
 =?utf-8?B?ZzRneEQyRXlpZXFOdlpEMkhtZjNIcnNLZ0xScncwSTZPT3JsOGNiR09yZ0NT?=
 =?utf-8?B?S21wNFRlTVdvdERvNzMwYzZiV0VKeHdhMTRBY1hrVHByLzhud2VIT3dLSjRk?=
 =?utf-8?B?Y2hoWFh3RmlIamNBRUpOaFpaNEcrY2xwOGtISjJwSXpWOEZCVnVJUEVBTUlJ?=
 =?utf-8?B?NVYwSUx4RFQ5YlB1OERCTU9hQjJMZXJVUEZXcEhCNmVYTUZVMGVCNWQ1aFln?=
 =?utf-8?B?bDErZThKWmJKV0lmV1pCZE5DKzBYd0pxb014NUtPSEYwMk9OLzZsTlQvanNo?=
 =?utf-8?B?dm55ZVE5YWNtWHJnNVh3dmpvT2IvTGpxWXVaTkZ2QjlROGM2UDJrR3Y4SnNv?=
 =?utf-8?B?VktObTBTKytVNElOQnpnVi8ybWVMNVJBREdYNS9md3hwTk00bnp3L0xxZTNm?=
 =?utf-8?B?Uk50QlZqcmMrVXIrdlNFQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExHTFFLSE9TTWxadm8vcFE1czEvRFNwY0xnVS9UY0N1TXpGZndMQXhmNDNS?=
 =?utf-8?B?L1lvWlcvYlpVSkZCZXROSUlsMnRuOUxtTEgwYUhmY0VZcDMwT25zcjN1ZmNp?=
 =?utf-8?B?ZzlIWi9jVURYV2lPR2pxSy8yZmV1c3h4TEVnd1grUWg0aDZab1hCbE5jekR3?=
 =?utf-8?B?YlNkcDBQeEJBVm1zcVpSNUgrNG9LVXVWUG8zQldrNW1JYWVTeldPcm5IL1ZJ?=
 =?utf-8?B?bUFnL3BtY3JEcEZFdUJUQytUc3djMW5vNytqM2RsMXh3UnFvWThjOUZlMytG?=
 =?utf-8?B?R3VDTXpxd1BiM3VWclNWeGV1dDBrMDdycjJsbjFyczRVS0hHM1FjZ2Z2dVIv?=
 =?utf-8?B?YmVLa3A4SVZ2Y2ZvZTdaTG82ZG5RQW5rRmxBaGlsbzE1RTlhUk1zZ2VKRCtV?=
 =?utf-8?B?dkZGMHJ3U01xK1NJeEpqYW43Tkovek5NR1IvTHg1NkNmc29KbXJvK3dmS3d1?=
 =?utf-8?B?VVM0eENxZFIrYnNZVnE3MXRVUGkyQ3pxTERENTVBY2lQRkp0VEo1cmREMEpz?=
 =?utf-8?B?eUNJMzd1TGtBa1JUS2s1NVlFNlRSTnRaNk5sRmxoWlhVUW91cFIxUityYnd2?=
 =?utf-8?B?R3E1ejZtOWpwYnVJcWttZlpUMWt0WUk4MExoc1RZaWdqUGhKcWtuTlZjcGo2?=
 =?utf-8?B?VjZSWHl2Z2toa0toczgraWZTcFc0VlNyenFYRFExRmdYRnNhcU1BR0hER1Q3?=
 =?utf-8?B?WUp0SlI5QzlJbFcxdG8vT1ZBd0lJNDZCYi9ReGtvQVJmZlB4UUFnbnRxbXVY?=
 =?utf-8?B?ekJUUGVuZU0xc2E3Z3NzeTQwYkp4UFFLMDdBdENzVGVWczZla0c1MFJmNWJI?=
 =?utf-8?B?OFg3SW5BYkdIM25RSEhqcjVma2dVODVqaHhMMnZYRGtjZ0hMWU5KUy9wZHAz?=
 =?utf-8?B?dWhYbDRMZHBvcURMZXUvYTZScWxwRDljS2FRaVFvMlBRTlhsNXVOZlE3T05Z?=
 =?utf-8?B?S2JkaGQ4ZkhNSXJ4VFNGdXZObE9zVHJ2TXR2dzg5RkNFTE5SdEhURWZWSERo?=
 =?utf-8?B?dEJtVm9hUlF3RWV6dng4RE8zTHg0R29YRjRPNVpuTG15NSs0RUxYVkViM0FY?=
 =?utf-8?B?M1pteWEzTVR1Y0N3Y0NTd1UwNjdXQjVjVFRyOVpkeU9ZS05MVXE0UXFVK0w4?=
 =?utf-8?B?ejdKczQ3MTUzKzlxZ3ZIakxsNENpQkZScERtT3BQUG92SnE4WnRKMi83djhI?=
 =?utf-8?B?dWV5NU0xVGhMeFFVc2FlNy9RSlMxYnpyQUFzZXhhMC8xMUVodW9hL216TkhD?=
 =?utf-8?B?TmZuUGxRVVJUbHlqK0t0YXlwZUNEQndKbkVYT1Q3a1JicndEeHJlS3hOVnI2?=
 =?utf-8?B?enlWSDVkWjV2c3d4aU81WTA3NHFiWGJybi9UQ0ViWGxUdjJ5SmJJdjczejNw?=
 =?utf-8?B?U0Irby9HVkh5b3lWUVZqZythcDhPOHRXaWIrMUJvLzZDLy90cFJJb2RmU29r?=
 =?utf-8?B?S3VSVmZBKzIxdU1CbEZSUGtsb1NoUlFwNVhvV3NPNUcxVkI2eUVlN0tiMjlZ?=
 =?utf-8?B?Um42LzNoSE91RGhxYkdYcWN0LzdQcUNtQmpjRjhNbjJRRk5RdDNlVVJlMWhS?=
 =?utf-8?B?NDNWSkFCalFvVWJvSGhtV0RSalNURU1VZm92MElCTU5WNmRwZnVodWltNWxO?=
 =?utf-8?B?bm9PS29PSTJLUVhiM3Ywd2xLZyt4bkgxS3RkbWs5cVdIZS9JOG82UDVhWmRt?=
 =?utf-8?B?SjEyd21SZ1F4Y0NJRFFVUC9YQ2txYnJRZDB4MU54WVdYMnZ6bnd0YWpGN1E4?=
 =?utf-8?B?cDBXcUtySDhRZnVhbHpXeC9FUHgxUm03dTAxS2VRYTdaRUdSMXFkK1lxdlVv?=
 =?utf-8?B?eXRRaW5iTFpXTklJZWxDeWhDTVNLcG1hQWdXVGZsbHc3RG9GTFdSM0taK1o0?=
 =?utf-8?B?RlJQYndMYjdsTmFpbjRGaWNJTmpveTkzN09TYzhHc1RNa2c0QmpaSHd5SExL?=
 =?utf-8?B?TjIrWmRYS2Y2NjI2Q1AzbGxwRjZKdFVRS0ZGNFB5UkxJS2ZLQXB6UHhHcXNQ?=
 =?utf-8?B?WG1kZWNabXJrYXEyWmtWNjREVmhJazBJUUxiUUZJaTJza2VvOENza3cxdFZM?=
 =?utf-8?B?djNqQVIxRmhaRjI3bFVEZmo3bXk2dU5GQkNTVVBWUUw2bGJmR3ZSbW83dHhq?=
 =?utf-8?Q?2hHael/QuEYtRkY80ZCrwdvIY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bd6e26-2673-47e6-0407-08dcc2224e60
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 20:46:18.0272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGP5JPePI0Fte3+VISUp1Ev01evUVl95ouWkVAMeqWg3cC+LWkpmd7Ac9Dbxfq5fv/Uv7Wb4cZ4rrNm2hgStgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
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


On 2024-08-21 08:03, Christian König wrote:
> Rework how VM operations synchronize to submissions. Provide an
> amdgpu_sync container to the backends instead of an reservation
> object and fill in the amdgpu_sync object in the higher layers
> of the code.
>
> No intended functional change, just prepares for upcomming changes.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 84 +++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 11 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 16 +---

There are two calls to amdgpu_vm_update_range in amdkfd/kfd_svm.c that 
would need to be updated as well.

Regards,
   Felix


>   5 files changed, 65 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index bcb729094521..ba99d428610a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -838,7 +838,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	params.vm = vm;
>   	params.immediate = immediate;
>   
> -	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
> +	r = vm->update_funcs->prepare(&params, NULL);
>   	if (r)
>   		goto error;
>   
> @@ -933,7 +933,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
>    * @allow_override: change MTYPE for local NUMA nodes
> - * @resv: fences we need to sync to
> + * @sync: fences we need to sync to
>    * @start: start of mapped range
>    * @last: last mapped entry
>    * @flags: flags for the entries
> @@ -949,16 +949,16 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * 0 for success, negative erro code for failure.
>    */
>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
> -			   struct dma_resv *resv, uint64_t start, uint64_t last,
> -			   uint64_t flags, uint64_t offset, uint64_t vram_base,
> +			   bool immediate, bool unlocked, bool flush_tlb,
> +			   bool allow_override, struct amdgpu_sync *sync,
> +			   uint64_t start, uint64_t last, uint64_t flags,
> +			   uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
>   			   struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_res_cursor cursor;
> -	enum amdgpu_sync_mode sync_mode;
>   	int r, idx;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -991,14 +991,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.allow_override = allow_override;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>   
> -	/* Implicitly sync to command submissions in the same VM before
> -	 * unmapping. Sync to moving fences before mapping.
> -	 */
> -	if (!(flags & AMDGPU_PTE_VALID))
> -		sync_mode = AMDGPU_SYNC_EQ_OWNER;
> -	else
> -		sync_mode = AMDGPU_SYNC_EXPLICIT;
> -
>   	amdgpu_vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r = -EBUSY;
> @@ -1013,7 +1005,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		dma_fence_put(tmp);
>   	}
>   
> -	r = vm->update_funcs->prepare(&params, resv, sync_mode);
> +	r = vm->update_funcs->prepare(&params, sync);
>   	if (r)
>   		goto error_free;
>   
> @@ -1155,23 +1147,30 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   	struct amdgpu_bo *bo = bo_va->base.bo;
>   	struct amdgpu_vm *vm = bo_va->base.vm;
>   	struct amdgpu_bo_va_mapping *mapping;
> +	struct dma_fence **last_update;
>   	dma_addr_t *pages_addr = NULL;
>   	struct ttm_resource *mem;
> -	struct dma_fence **last_update;
> +	struct amdgpu_sync sync;
>   	bool flush_tlb = clear;
> -	bool uncached;
> -	struct dma_resv *resv;
>   	uint64_t vram_base;
>   	uint64_t flags;
> +	bool uncached;
>   	int r;
>   
> +	amdgpu_sync_create(&sync);
>   	if (clear || !bo) {
>   		mem = NULL;
> -		resv = vm->root.bo->tbo.base.resv;
> +
> +		/* Implicitly sync to command submissions in the same VM before
> +		 * unmapping.
> +		 */
> +		r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
> +				     AMDGPU_SYNC_EQ_OWNER, vm);
> +		if (r)
> +			goto error_free;
>   	} else {
>   		struct drm_gem_object *obj = &bo->tbo.base;
>   
> -		resv = bo->tbo.base.resv;
>   		if (obj->import_attach && bo_va->is_xgmi) {
>   			struct dma_buf *dma_buf = obj->import_attach->dmabuf;
>   			struct drm_gem_object *gobj = dma_buf->priv;
> @@ -1185,6 +1184,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		if (mem && (mem->mem_type == TTM_PL_TT ||
>   			    mem->mem_type == AMDGPU_PL_PREEMPT))
>   			pages_addr = bo->tbo.ttm->dma_address;
> +
> +		/* Implicitly sync to moving fences before mapping anything */
> +		r = amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
> +				     AMDGPU_SYNC_EXPLICIT, vm);
> +		if (r)
> +			goto error_free;
>   	}
>   
>   	if (bo) {
> @@ -1234,12 +1239,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		trace_amdgpu_vm_bo_update(mapping);
>   
>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
> -					   !uncached, resv, mapping->start, mapping->last,
> -					   update_flags, mapping->offset,
> -					   vram_base, mem, pages_addr,
> -					   last_update);
> +					   !uncached, &sync, mapping->start,
> +					   mapping->last, update_flags,
> +					   mapping->offset, vram_base, mem,
> +					   pages_addr, last_update);
>   		if (r)
> -			return r;
> +			goto error_free;
>   	}
>   
>   	/* If the BO is not in its preferred location add it back to
> @@ -1267,7 +1272,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   			trace_amdgpu_vm_bo_mapping(mapping);
>   	}
>   
> -	return 0;
> +error_free:
> +	amdgpu_sync_free(&sync);
> +	return r;
>   }
>   
>   /**
> @@ -1414,25 +1421,34 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm,
>   			  struct dma_fence **fence)
>   {
> -	struct dma_resv *resv = vm->root.bo->tbo.base.resv;
>   	struct amdgpu_bo_va_mapping *mapping;
> -	uint64_t init_pte_value = 0;
>   	struct dma_fence *f = NULL;
> +	struct amdgpu_sync sync;
>   	int r;
>   
> +
> +	/*
> +	 * Implicitly sync to command submissions in the same VM before
> +	 * unmapping.
> +	 */
> +	amdgpu_sync_create(&sync);
> +	r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
> +			     AMDGPU_SYNC_EQ_OWNER, vm);
> +	if (r)
> +		goto error_free;
> +
>   	while (!list_empty(&vm->freed)) {
>   		mapping = list_first_entry(&vm->freed,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>   
>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
> -					   resv, mapping->start, mapping->last,
> -					   init_pte_value, 0, 0, NULL, NULL,
> -					   &f);
> +					   &sync, mapping->start, mapping->last,
> +					   0, 0, 0, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> -			return r;
> +			goto error_free;
>   		}
>   	}
>   
> @@ -1443,7 +1459,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   		dma_fence_put(f);
>   	}
>   
> -	return 0;
> +error_free:
> +	amdgpu_sync_free(&sync);
> +	return r;
>   
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 046949c4b695..1a759012ce93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -304,8 +304,8 @@ struct amdgpu_vm_update_params {
>   
>   struct amdgpu_vm_update_funcs {
>   	int (*map_table)(struct amdgpu_bo_vm *bo);
> -	int (*prepare)(struct amdgpu_vm_update_params *p, struct dma_resv *resv,
> -		       enum amdgpu_sync_mode sync_mode);
> +	int (*prepare)(struct amdgpu_vm_update_params *p,
> +		       struct amdgpu_sync *sync);
>   	int (*update)(struct amdgpu_vm_update_params *p,
>   		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
>   		      unsigned count, uint32_t incr, uint64_t flags);
> @@ -505,9 +505,10 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
> -			   struct dma_resv *resv, uint64_t start, uint64_t last,
> -			   uint64_t flags, uint64_t offset, uint64_t vram_base,
> +			   bool immediate, bool unlocked, bool flush_tlb,
> +			   bool allow_override, struct amdgpu_sync *sync,
> +			   uint64_t start, uint64_t last, uint64_t flags,
> +			   uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
>   			   struct dma_fence **fence);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 3895bd7d176a..9ff59a4e6f15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -46,13 +46,12 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
>    * Negativ errno, 0 for success.
>    */
>   static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
> -				 struct dma_resv *resv,
> -				 enum amdgpu_sync_mode sync_mode)
> +				 struct amdgpu_sync *sync)
>   {
> -	if (!resv)
> +	if (!sync)
>   		return 0;
>   
> -	return amdgpu_bo_sync_wait_resv(p->adev, resv, sync_mode, p->vm, true);
> +	return amdgpu_sync_wait(sync, true);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index e39d6e7643bf..a076f43097e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -403,7 +403,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.vm = vm;
>   	params.immediate = immediate;
>   
> -	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
> +	r = vm->update_funcs->prepare(&params, NULL);
>   	if (r)
>   		goto exit;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 9b748d7058b5..4772fba33285 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -77,32 +77,24 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
>    * amdgpu_vm_sdma_prepare - prepare SDMA command submission
>    *
>    * @p: see amdgpu_vm_update_params definition
> - * @resv: reservation object with embedded fence
> - * @sync_mode: synchronization mode
> + * @sync: amdgpu_sync object with fences to wait for
>    *
>    * Returns:
>    * Negativ errno, 0 for success.
>    */
>   static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
> -				  struct dma_resv *resv,
> -				  enum amdgpu_sync_mode sync_mode)
> +				  struct amdgpu_sync *sync)
>   {
> -	struct amdgpu_sync sync;
>   	int r;
>   
>   	r = amdgpu_vm_sdma_alloc_job(p, 0);
>   	if (r)
>   		return r;
>   
> -	if (!resv)
> +	if (!sync)
>   		return 0;
>   
> -	amdgpu_sync_create(&sync);
> -	r = amdgpu_sync_resv(p->adev, &sync, resv, sync_mode, p->vm);
> -	if (!r)
> -		r = amdgpu_sync_push_to_job(&sync, p->job);
> -	amdgpu_sync_free(&sync);
> -
> +	r = amdgpu_sync_push_to_job(sync, p->job);
>   	if (r) {
>   		p->num_dw_left = 0;
>   		amdgpu_job_free(p->job);
