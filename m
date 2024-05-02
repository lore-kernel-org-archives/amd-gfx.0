Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751AEC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 03:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA16C10EA26;
	Thu,  2 May 2024 03:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R9ZiRNGN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D429F10EA26
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 03:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTVSw8W2eKuxpHVbTGKyvwroNmrBZey92qdqs8KehEx8AW013GNiHKTBDaSI5AX9+7RQGtsnsJytzNI1hkeMvGq1ZraVyBMTF2zuIYdz0mnXJoytwaLSW3zuZX34Ghr5Njk9MuhTsVgFX6Aim9WuYUgyN5/2hKqLfRwDAL9NoWqZNRytfrJzX7tTlUQdnZul9Sm+UR2PYTB+FbggrVVM4gyIlsy6UaBH3JpHLtXIRnsXDgqpBWpEiOlkPPWvRK2lR8gL4YsUpvRha3TTsgh6mJB2MTVp7d1yVsrbTOAFuSITS262wL6HR57kOXB65VXYPdpvqcSiaBLsUYuxK3MDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4sj3SXybotkNMkiAiQ06IZnYBxyceHp4MBJkAISg/E=;
 b=WCxoeTPAWHStvUROOeRQyUpkFaC52Po4x/FVNcissUisIjz3tsUCGqi9edZ8oCnPXWuEY0iSfOz8denauNVucjMNoNJSvynw9X8jLhwGEWg/6Fo75XXcbgXv7ocnvMNaPxwIsm2UEtJcUhDwm1gi/vobxONPa25OZ/iAzao+sV0+3zkCtCFQn1qrauzZ4KvidwCJnyid+Av2ch5ad+L3tOxTOJmH0vuEKlHQXB1id8/34ycJin26/eFuH/Bg3FJmKfZcJD0yUMa9yxfEmUtT211YQ2eTsJSWOpzMPRGDwaPkjns/9aEF+a+WODqAdljLth6bQ5I2//V/ceq8Aa06pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4sj3SXybotkNMkiAiQ06IZnYBxyceHp4MBJkAISg/E=;
 b=R9ZiRNGNTCZPZ2lmKB0Bf6Z7XOjbdq7Bg0nstXYwPVTU5MMFH5Layki3vtpuoXIEWgnar6i12fPP9gIDfRi1mb07XWQuGDQCghQCkc0K3toR1aH4e9uEho+gITyydKNfwk8ClisU7G2p8VfNHJT9R2ZzJAktaYFvMSbX37fYwSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 03:51:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 03:51:08 +0000
Message-ID: <15d0dc2d-94f3-48f7-8162-f37b44001754@amd.com>
Date: Wed, 1 May 2024 23:51:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Use dev_error intead of pr_error
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240502010804.125461-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240502010804.125461-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBP288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: a5daa2e8-b9ae-43c8-08b9-08dc6a5b19b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmZtVWhIQnZvaCtoVytJUlRHK24yWnpuczVEalZZSUFPWEE0RHZ6YVJ0Tmls?=
 =?utf-8?B?V2prU1JpUzBuTVJTcnlpRmlobmJQRmhsOHZqM2wrQzFhQ2oyZnRxT1luNTJO?=
 =?utf-8?B?ZHErWVBFMHR0Uko5bTdMUEtxdGlOR2FwZG5IVGoyb0pZQXMxQkN1NWFkcFRO?=
 =?utf-8?B?SFg2Y0lSV0IwMlAxME4zMThXdEhSYXNtQUQ4TVJDMzZOUHZsSXFhR1B2dEZD?=
 =?utf-8?B?YzJySmRRVFdmWm1yMTRScDRwREtoUUhZNDBwaFhTUGthR2VjQml5TmFXUldk?=
 =?utf-8?B?Y3h0TmcxZUsrcytCdGdFNUE1bzdNV0tYN3JmZmwxaGlpMXRUOElUWHZWdW1h?=
 =?utf-8?B?QTQ3ZTl5YlNESlRINXRGNHQwOUNGWFVoK1RzNllMVlBNVURnT3g0RERRSGtD?=
 =?utf-8?B?UmpVTHM5UXdMRDh0WFV1THA1V0xqNjBJOGUvcjJPV2Z0cHVJc1JrcjhBOTZl?=
 =?utf-8?B?TzZJMEQ2bjhrM21GZmovVEI2Rm5wdm84a2o4UnVHR01JVGZSM21lZTNHcmpE?=
 =?utf-8?B?bTVRNmJ3L0dlWWp4SHY1dGVza25IckplUDBkcEZ1bnc0N3dLQTVMODI2OEhR?=
 =?utf-8?B?S2FiT3RyQTh5NnpFZTF3UUZrMmZCa0lWMGczdCs1QVNTRENUWkh2NUpJaXJj?=
 =?utf-8?B?S1Q5NGVEMHAwUiszRkdJRXNBUzk2YmNCMnJVNm16ekpTR2dZV0RKMU1sWHBJ?=
 =?utf-8?B?STl1dWNsR1JaZk1BTG1TSk5MMUo3VVl4VmIrNzYxbysxSEE0a3g4ZHhaZXVT?=
 =?utf-8?B?Z1BqRmJTaVBWSkQ0emgyVlFHQmQ0WTFVdnJ5SGdjN1dTNHZxSVNLRHc5cURX?=
 =?utf-8?B?L0xHOTFqMTErL01jeFpvN3FYTEZDZ1VWbVVWY0Irc2FaZDg2R0FYR1RuZC9R?=
 =?utf-8?B?ZlpzR2RBQXRiR1BkdE1mMWV1VzA1WVg4YW1BYmhsNDkraWQxTW94WUROZUt1?=
 =?utf-8?B?aHZpeG5rNEdqdkRlajNqNTV3RnBGSzBCZ1dzZ2RoWjd2eVg4S2FzSWtwVXNj?=
 =?utf-8?B?U3pmQlpvcHFHbVc0aWdKTEI0a1U5M1NHNGhKMGdTV2QwRTZreFdYdVVFbkt6?=
 =?utf-8?B?WUJjbWpFMllOaUdFRlpFN3Q1bXlKYWNCbzA5VGJJbVArN0J4SFllYnpjdmk1?=
 =?utf-8?B?ZXcrZ2IwNXhJaXptaXh3L1FhOCszRkR5ZWUrVzVNbGZZdDdUZmpmWWRRUkI3?=
 =?utf-8?B?L2Nua3M2czVWa3BYa2pMWVVXVVc4V3RiYzZORElLcENYL3lBcWc3RWM2RHhV?=
 =?utf-8?B?K0lMYTNPdTBZV3BveGVHeVNaK29nKzAzanJnajRJclFwRTFyMWNNa256ejI5?=
 =?utf-8?B?dnRNOHgzazBHUFMyV1ZkdkR6TEU4MnI3b1VsWjhyK2RRc002VHAyWDRsYmFM?=
 =?utf-8?B?R2Y3SFVlRUN4RUgxNzU0V29ZN3NUcVFzbDZwSW5RMHRVUnFqRG9OcTVIRHZW?=
 =?utf-8?B?MUNBdWx0MDZES0plR0drSWJXQmYza093Y0RhUnV6MFdCU2c4T0IvYzRUWDhs?=
 =?utf-8?B?ejAvZ0RoRlUwanNwMGtXMkxEVnl3Qyt2bkl2NkVreE5nTGN3NExxaDczQTBr?=
 =?utf-8?B?M0xkblVObk5HVitrYXQzSUYxSTYvcFdnMXVFdXdKZW9TeWdUMkZ0RkVwaG94?=
 =?utf-8?B?S0Y4Y1dsQXU1OTRvb1FHZWlDT3ViRWMwUTVnV3M1alF6MGJTeXVZVnEzY053?=
 =?utf-8?B?M09RWTkzTTZzQXBkTFVxMU5BL2IwYTFMMnZQQUhzbiswaitmMGtlc1VnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xoNWttdjJsNWd2RzRWUVhwQnNNczNYbUl4dForOTZyTDJ6MmdQT3FicUhD?=
 =?utf-8?B?aFQ1RGpCL3RYNVB0eTV6ak9FeUFVcWpyd1lpa3Q5cEwrRlF4dnZ5c2krcDRx?=
 =?utf-8?B?UlB3Y0xMc1ZxeUdPczhwYnZ2enVHT0l6ZGJlcUNsYmYzeUYyK0Z0bGQ3ZzR0?=
 =?utf-8?B?amhRc0ZmQWJqcFMzT0pBZ3NFOGFtVS9qQ2E1dmp0Z1dmb3dCbTRlMkRWeExJ?=
 =?utf-8?B?M0hHaGFnRCthN0tKbDhiTkZjQmNRcHRZOXVtMlp2cE43eURZN1VIYk9zekgr?=
 =?utf-8?B?c3lMaHBxdkY5aEpQODA0MEtsdkpIZm5mR2dPNnVBelRGaGE0S01KM1Q5YXZx?=
 =?utf-8?B?Vy9xVUtpMkovY3dOSmJENFZLU244MjRUY2FoVitCOFA4bE9RNzFScGxBWnJl?=
 =?utf-8?B?U2RUdDFDOURxZFhGY0JsRnVlVW51ejlqc1E0d2VjRmY1REQyRXBMOUxjc09G?=
 =?utf-8?B?Qkk2SzNvRUNMZnJHd2xoRXA0KytBS3o5T1VySE5xYjF0VTJXdGVZMUxaRmwv?=
 =?utf-8?B?Zy9KK1daSnlONk54dmsyc1hMRGdYSXlRQzFYNUlVTnZuUDlib1RIaWpVekJG?=
 =?utf-8?B?Y0pOZXFlOVM4ZU5NWGVZSlQwcVg4bWoyWkQwZ2dSNGlkQmk3TmhvMkNwR0ti?=
 =?utf-8?B?eTlxVGoxQkhZMFNvYnYxbXFuaVhucTFPUFlBYnBtZS9rZHpoTVp5MVY1QVNx?=
 =?utf-8?B?VkZ5L0RmNmZwQW0xOERYWEdpVUlKZDNMbitYNkVLWUhwOXdqd2xRdXIxMkFa?=
 =?utf-8?B?QndmY3ZJbUFZWm5rOGQ1TmE1QkZFNDN1RURVSXJ4SEkzNnhXY2JUbTBDaEYw?=
 =?utf-8?B?eUVkeEVrdFpod1VQak9mUUcwMEF2K0NaMDE3ZVVjOVN4S0REd2MzbTNIUit4?=
 =?utf-8?B?ejFhV3lsemxPa29tMTFoeUQ4dWFXbmxwUy8vRmxKeWxwL252RVJkaWV5Wm1s?=
 =?utf-8?B?eW5BQ0NvNW9nUkdZMUkxOG8ySk1iZFE3dmg1WG9CWjdsUmJOUG1zWEpxa2k5?=
 =?utf-8?B?UmJ5c1JrKzhzOG41QUx6c004THJMTHhzUGFnNmNtWng0UDN5cVk4TWQ5UGsy?=
 =?utf-8?B?amNZWUJsYXQ4Rkcwb2Y3OTlZVGtFMDJmbUJnWUlBZzNIMWI1alNNcTl0RnNZ?=
 =?utf-8?B?aWQxc3dRQ2hlOEdMZWpOSnIxaFZVM3JlVDJqZGNucGpBOW5VOW5sWERyakZ1?=
 =?utf-8?B?aUVpaG5TRXJ2TFdJNmRScHlBNU5GM0tGTGo1Q3NZVWN2L1F4U09MV1JZcHFq?=
 =?utf-8?B?cHQxQnFNR3FidVZzWkZjQnVDQTFQcUFWYmZYUjQ1bVFUSUpPTVAwOEc2bnJO?=
 =?utf-8?B?RlVOYkpQUWxySHIzUFErRUNjS0ZIaTh5MnBvcjJMck04cW0zUjhMNlg3WjBK?=
 =?utf-8?B?bXdqSTNZZ2ZnZHNIeUt6cEh0UWZwT0pQVGVHS3hJb2Y4WDB5QjZYbWdlTms0?=
 =?utf-8?B?S2diR0hwQ1J4MUFNcjlmOThkVWV6dzl5Yno1WEw2QVV1R3BrSkx1Wm9sYmUz?=
 =?utf-8?B?VVlkd3hZRFBtVGVrNGpaVlN2bHpsNEZzdElOUGd1c1hHZnJNRkxGOHZJNXo4?=
 =?utf-8?B?cHc3a0V1M0JoN2VUbyt3STVVTXZwTjkvM0s4SDM1THhTL2VUSmhmclBzZEdB?=
 =?utf-8?B?Tm8ySDFXTzlrdlN0OHRNN0E2c3RPOUxWV0xINDIzdnljM3BDWElRalJOUjhh?=
 =?utf-8?B?UWEwS2M1TkJKR1p4YXdkL2YxTk9RbExIUmtvRHkvQWgwSjZqMDlQdmoxeDRJ?=
 =?utf-8?B?VEt6Z2kxcVBZSnBPNU5HSzBDQzFoYjZRRzBnWXkxcWU0MlRFWm41VERZT0xw?=
 =?utf-8?B?Q0UzcGNhSDZkZkJlOU5WeEcvaDFEYWFRcTYzaUd4ajJyMTdUZHhQRTVzNnow?=
 =?utf-8?B?OE45K3ZnL2l1Z3BRTmlVZXNHWVZCZ2NnZStUU1dmSU5EUHJ3bXdSc1llMUc5?=
 =?utf-8?B?VkVRYkJJaXltVWt0dlFmQTVzQ09KblVUaHdqWFBFNDJsN25SUW4vMGloa3Vw?=
 =?utf-8?B?eFlXSGZrQjZiU2JUc1FXZHcwT3R3eGljVVJlYVlFSTQwbU1qaFluNnV3ZlBq?=
 =?utf-8?B?dEVRdVp1aFowQmFsUFBmZ29vMC9vSlc2OE02c09hbzAyVitIcjFBQkJPL0ts?=
 =?utf-8?Q?4tmOkW8tKLcducnz8xrY2gAhH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5daa2e8-b9ae-43c8-08b9-08dc6a5b19b2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 03:51:08.6303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XL1xUzh8Rbx623sgi3h5ass2N99+hsYanns1kam1crmVw4EezEjqjkQ8ZOzOy6V7NXGIVD3de6UZ0K9wEhZWhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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


On 2024-05-01 21:08, Harish Kasiviswanathan wrote:
> No functional change. This will help in moving gpu_id creation to next
> step while still being able to identify the correct GPU
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index ba326b43bec5..b93913934b03 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1773,7 +1773,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>  	pr_debug("Added [%d] GPU cache entries\n", num_of_entries);
>  }
>  
> -static int kfd_topology_add_device_locked(struct kfd_node *gpu, uint32_t gpu_id,
> +static int kfd_topology_add_device_locked(struct kfd_node *gpu,
>  					  struct kfd_topology_device **dev)
>  {
>  	int proximity_domain = ++topology_crat_proximity_domain;
> @@ -1786,8 +1786,7 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu, uint32_t gpu_id,
>  					    COMPUTE_UNIT_GPU, gpu,
>  					    proximity_domain);
>  	if (res) {
> -		pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
> -		       gpu_id);
> +		dev_err(gpu->adev->dev, "Error creating VCRAT\n");
>  		topology_crat_proximity_domain--;
>  		goto err;
>  	}
> @@ -1798,8 +1797,7 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu, uint32_t gpu_id,
>  				   &temp_topology_device_list,
>  				   proximity_domain);
>  	if (res) {
> -		pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
> -		       gpu_id);
> +		dev_err(gpu->adev->dev, "Error parsing VCRAT\n");
>  		topology_crat_proximity_domain--;
>  		goto err;
>  	}
> @@ -1825,8 +1823,8 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu, uint32_t gpu_id,
>  	if (!res)
>  		sys_props.generation_count++;
>  	else
> -		pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
> -		       gpu_id, res);
> +		dev_err(gpu->adev->dev, "Failed to update GPU to sysfs topology. res=%d\n",
> +			res);
>  
>  err:
>  	kfd_destroy_crat_image(crat_image);
> @@ -1951,11 +1949,10 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>  	gpu_id = kfd_generate_gpu_id(gpu);
>  	if (gpu->xcp && !gpu->xcp->ddev) {
>  		dev_warn(gpu->adev->dev,
> -		"Won't add GPU (ID: 0x%x) to topology since it has no drm node assigned.",
> -		gpu_id);
> +			 "Won't add GPU to topology since it has no drm node assigned.");
>  		return 0;
>  	} else {
> -		pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
> +		dev_dbg(gpu->adev->dev, "Adding new GPU to topology\n");
>  	}
>  
>  	/* Check to see if this gpu device exists in the topology_device_list.
> @@ -1967,7 +1964,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>  	down_write(&topology_lock);
>  	dev = kfd_assign_gpu(gpu);
>  	if (!dev)
> -		res = kfd_topology_add_device_locked(gpu, gpu_id, &dev);
> +		res = kfd_topology_add_device_locked(gpu, &dev);
>  	up_write(&topology_lock);
>  	if (res)
>  		return res;
