Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A186606C706
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X0eBziFI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E1710E619;
	Tue, 17 Nov 2026 14:57:06 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6F110E3C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j79C7STCnQwBmbOCtFfkCD8u2uxYrQ9k3yZVnzc0yFThgPotUZd8kPb0yzCOHAvThr1ovSQinERRyslwuth3yKd7OajmzRYBU6ujq/5ibOleOzX87nUliwQU4VO3GiCjwbVgabHHl980H5vheJBSbN7DKFvMo1ZSnKrYDSKBpZvh3MGCGYqABICgCUhYknj8BLZjycssdz1j6IAcIGjv9L8mVtqBJf/1K4JVBqjPGuMzYWqwIDDOZMVQGGraCDn/3MNEUmglyjA+sKM30rACbHZl/JWo4M/THjURMyX31cFWA0jUq6IusuKL+QdJ88W5LNiGWcB3WWklWetnk1FHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpNEKljYI3Nww3Tlc0XROuI7tNiizv+lBpChnmDi+UA=;
 b=d/X5ZHgsOrbG/qAb3fUcJKE2P9bwqOVpc6tn14I+ZeqloKDI4jA2zN8qywYHmLSe2CbFIJFJiNHqm/WTVvgC7Kcxx04dGLOQ2YQFiGo6DVnKiWmvISSuPs7cmNAZ9485pEuM69Idliq3y06UVdyzC0WpWNMMCYjigquktKYV+4+QZjWUlkiZ2SK6bMLPLtOVyHrXoniHKu0/UDOwpMHBge93Usaf0N2Cro0bpkwLFVsXGyQtw/pQnw2r2fn4Pg8eOCPshpKkYGNb/S676B2ZOJc5jDNixwBB0SLWlknLVSnmik1rQqKvFgKEfp5oQ2MtHKB74BxQzsYj1CIaoMNoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpNEKljYI3Nww3Tlc0XROuI7tNiizv+lBpChnmDi+UA=;
 b=X0eBziFIh79Vj2wYWUIhSq6xU5F13cpxTfnr4TXb7QEbH+SwpUlOQSLBPcQMSGy5pcgnKoo0F6izwRj5eFSu2ol5i9bKUAYfTpH84j4BuIx5V/1lejVMQrIBVUOkeYZnh4RsSYwU0NQYZn+0yE2VdP1fQf3aC45CjO87uqfHQ2Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:56:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:56:54 +0000
Message-ID: <9b66a1ba-804a-4cd2-9cac-f5fa3393ac82@amd.com>
Date: Tue, 17 Nov 2026 15:56:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] drm/amdgpu: pass job id as part of
 amdgpu_vm_update_params
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
 <MW3PR12MB45728092AA08C322A8863E529E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB45728092AA08C322A8863E529E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3b0f85-232c-4160-2e97-08df44bb048f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|261026121527099003|261028144727099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261009223027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: wZ2KjP7eBVRU6Y/2XekETxCqp7uIS8Fom0kgM2IETkQvUFZOJULRm8AFKAfmY6fg3wrmmvgO5ysenPN9awFE4kH/ReZpiOoj06mevorRB3mMSb8WiIV6WqOO0RINmu3ar9s5e4txXW7t0OAY1roPVmPm5qINXUYvtIjiOwKK27FFmhuuW29ObZYNJF6z+lCjux8M2Ba5M/QoFi4/67HukW4grkarudwxJJ51EJNAX5psdtdzk0Ai7Wxxqj9qgS41+0+MkJNGdj7qi4n2zv1BOIrrLjDB3hzXramUBSX/ehYraqCow6giu81TidTjzDZyeRCilbQFwvBQNZamgdvi29fe1zO409ppk+Tx+fp3LRfoS4mZdha1K24cPk+xbE1Ip2b/NIoBlx/eapvXdSEkktzWcOLgcGm9UGU3fsxLPuy2kHXWf4ARdrRKlScF7AONOtltDoAR+YNhwxXKuQX/qzakSoyNSJM7DCJ+OjLVqN/GhzJb5q8PhpMPA8S/2JMpolU4w7Z6qogojT5Yum0k37AK1DxLqeav9yPyGyIyOitOa6W1I+ewqn/U/8fU0/fDimVJlNjSyg+c9lqnfO3OVI3H/Rcu8x9ZWR8sIhyy+ek+z0JpWnt6o7MYH/Tj0YhG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261028144727099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFgwSE12VStEUHlvNDlZVmlWaEM3MFgwc2NkTTlhd0lmQlhzTXZBb2dHdnpq?=
 =?utf-8?B?TnpZdkZFbGc0MStRc1hvd1czZXVNdjdxdWswbS9uQ2kzeGpRQ1pPN08rWkMy?=
 =?utf-8?B?Vk9pY0gxMHRXeU9mdjJoTEhzamViV1pEN3Q2QURvZHYyNkdET1BGckRnWFlJ?=
 =?utf-8?B?VVYwczBsMVlMZ24xUzZNSEZWZDUzdmhHSE4vVWVuYmNtNVJqRUZiakwyQlBI?=
 =?utf-8?B?WS9EbGtPMTBZdWhOdkVxT0Y5eFBoWUZCbFhKdzN1M1ZEb3psNEhlbEdZTThD?=
 =?utf-8?B?dUpNKzdnaVloRzhBUloveDFDOGhaVmJoUHlyNmJwVFlWLzJTN2FSMWZLbTZP?=
 =?utf-8?B?M3hYMXRTRWNPWURBSzBYR3NhWGlJMHRFdnFyYXo4YVY3V2NEdTI4aENZSEM4?=
 =?utf-8?B?djhTTmJVNG9paEwzeFNUOW1ITC9GYlBwb0YybnZZUEZkUEljMkh5YzRkMG1V?=
 =?utf-8?B?YmN0Ui8rSkUxKzhqY1dQQzJoRTlGM3hOZFFueEswYVF4Z2R5TXMzcXNoenFX?=
 =?utf-8?B?RUM1NnlBbURONms2dWxleENWTmdBSXVSR0cwdkI1cGk2TitBa1ZzNkNxNEdV?=
 =?utf-8?B?Y3VhTEJmQ2NYZkRmYnRBQjk4Q3EvNkhvcEpPN010SXlZTDB4NmJYN2hzcDlE?=
 =?utf-8?B?Wk1GUDdFRzltalFvaGdkdmhFYXVpRzBEcUVJYzA3T1d4YzAzQ2ZyN0NzVEd6?=
 =?utf-8?B?Q1I3TnJLMkZvQ2xqdDIwY09nb2YxNjlvUlUxVVp6Vmd2c3ZqRWtDVGsvUzZZ?=
 =?utf-8?B?dDdWbWFjVmxpZlhGaXRjMTEvY05pU2Z3d0l2aUkyQnZueDBnNDNjK0xGdXRh?=
 =?utf-8?B?MUU5SGQ2akNIUmQ1bjZWWHhCU2lGYUJEczU5T0R6S2JCSUNtYy9YVG1vbTVu?=
 =?utf-8?B?UWwrVE10VlFlYWhjMlIzMFlqUzM0dmdGMnpnYkQrQmhJMzlsdk56K0RVeEs3?=
 =?utf-8?B?WG9ad0d2clNNS3hwTEZWdS9oVVVPUzdUc1VKNm5oWU91dW1FMEJQWmR5Vzl6?=
 =?utf-8?B?WVpFOE1HSEllNFI0TUpYM3ZkVkV1SUNpd0xhdXdhTGM2WkNKYnZvb2g1YnY0?=
 =?utf-8?B?Q1NEY0U5UDVCbHpOaWVRVEpjMTF5N3NzSUloeGMzcDJtMWVzZ2hka1UwdWVT?=
 =?utf-8?B?YWpGdGwrNElqcXZqU0lMVWltSDBoSGFZWGRrMTBaMmpPODN5UC9LWTF6cHJC?=
 =?utf-8?B?WXFLRE1UYVFYS3VadDVVSFd0TnZjR0VkWEgxWi82SlJJOWNORjdZekx5SWda?=
 =?utf-8?B?bVZqbmpHS09IZk4wSU1aSW9uaXRNNnE5aXVyMm9QNlI0WHlnSG9UL01rdVo3?=
 =?utf-8?B?OEsyY2J6NVR1TXRBaDhXTjRnK3BFMVRKWVhxRGhjMUFBbi9uUVBNU1BHeExS?=
 =?utf-8?B?bS92TGwvbGl5YURlN05US2Zra2laTlg0S3J6NVJlNFVIbFJDN21qQWlORTRB?=
 =?utf-8?B?SzJIY0JwNU8zZGErTHp3TFEzdjZwbHpDaWR2UkRaYjZKK0xmZ3k1M1VwN28v?=
 =?utf-8?B?ZWh1TFBZTUdkV1o0a0FDZjU2Rno3VjFiVVhqalhCdzhIVnNHSmRnd2poNEhw?=
 =?utf-8?B?Y3JrOSsyKzRtUHN4Kzd0aDJEQzdkYythNDdUY3BZRmdqcjI4YWZnSG0rL044?=
 =?utf-8?B?ckluUHNqZFNpTVhxSzN3cUpYZDJONzBybG1LS296VUZ3ZDV3ZU01eDFrQTNH?=
 =?utf-8?B?TjZWRjYrb3FscjVQWkRjWXFvZ2RpVWtxRnhTSGl3WGd2anVCcmFnOWVUSllV?=
 =?utf-8?B?NjRlcTMwcW5Yd0h3Wms3dEgwOU5YaisvU0ZLaUxWczlvOVVsWmlocTVzQVBX?=
 =?utf-8?B?K0JqMlNNOTVmdkg2ajJQTzFtYkZDbTBrQmxCWVVPY2Q2elNNSEZJV3djRWho?=
 =?utf-8?B?MGg2QklkUVRFc2kxdzFiRkZ6Q3oyWkRDRGlGd2RsaHFzKzNtbjdGclUySWh4?=
 =?utf-8?B?NzNuS0pENmtpNDN1WlExQUxzbFVaQnJpVkZaRW5HZjBtTnArZE4rd1Q0REVP?=
 =?utf-8?B?cm9sVm44amt5WHdmSU90Z09GekMyNU14elhZY0Z4a05uYUFUdmpaNlUra0dx?=
 =?utf-8?B?WnM3a0JLRFVXSUdVQWMzMWJDKzYzTW1HZzhzZzFIVlJPRXAzYWtORzFsOEt2?=
 =?utf-8?B?ajMvZjNqeDViSDduTExNMkIweU5ERTRJMEdHL1EwZGM1NVRxZ1BaYTZrZDV2?=
 =?utf-8?B?S2JrdGtWbHQ5NHcrR3NSZUlzeUp1Y0RzVjY0cktuUVlqRUVSR2ZNZ2xTVGlY?=
 =?utf-8?B?Sit1eGdhTXZiM0t3Y3hqd3FDU3NHMkpqZ1hoZjRWR1QrV3B4WnpaNG5WZTgy?=
 =?utf-8?Q?97SEp87AiPuWXAdEjA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3b0f85-232c-4160-2e97-08df44bb048f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:56:54.2859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRCJB+bczVnCqSrL9bfqmZdqoOzNPxcruwt+PO/1A+PJ8bH4+7h6zlSn1AoIu/0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/26 12:39, Mu, Zihao wrote:
> From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> Keep the original identifier in the update context so replacement jobs
> and phases restarted around allocation use the same tracing identity.
> 
> Initialize the ID for range, PDE and table-clear contexts. Use it in
> SDMA's initial and rollover allocations, and remove prepare's separate
> job-ID argument from both backends and the callback type.
> 
> [zmu: Complete the SDMA prepare/alloc_job/rollover changes omitted from
> the inline proposal, and adapt to the current context layout.]
> Link: https://lore.kernel.org/amd-gfx/avRl4ajLaCSa8AeG@quatroqueijos.cascardo.eti.br/
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Signed-off-by: Zihao Mu <zmu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c      |  4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h |  7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c     | 12 +++++-------
>  5 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 172af3b8f1a..7199cec1f95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1055,8 +1055,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  	params.vm = vm;
>  	params.immediate = immediate;
>  
> -	r = vm->update_funcs->prepare(&params, NULL,
> -				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
> +	params.k_job_id = AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES;

Seeting that up should probably be grouped together with setting the other params fields.

Same for other places, apart from that nit pick looks good to me.

Regards,
Christian.

> +	r = vm->update_funcs->prepare(&params, NULL);
>  	if (r)
>  		goto error;
>  
> @@ -1218,8 +1218,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		dma_fence_put(tmp);
>  	}
>  
> -	r = vm->update_funcs->prepare(&params, sync,
> -				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
> +	params.k_job_id = AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE;
> +	r = vm->update_funcs->prepare(&params, sync);
>  	if (r)
>  		goto error_free;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 8c7afd34783..7521c5be207 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -43,14 +43,12 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
>   *
>   * @p: see amdgpu_vm_update_params definition
>   * @sync: sync obj with fences to wait on
> - * @k_job_id: the id for tracing/debug purposes
>   *
>   * Returns:
>   * Negativ errno, 0 for success.
>   */
>  static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
> -				 struct amdgpu_sync *sync,
> -				 u64 k_job_id)
> +				 struct amdgpu_sync *sync)
>  {
>  	if (!sync)
>  		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index 0b7cc3a1701..ea52be053d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -77,6 +77,11 @@ struct amdgpu_vm_update_params {
>  	 */
>  	struct amdgpu_job *job;
>  
> +	/**
> +	 * @k_job_id: original job identifier for every submission in this context
> +	 */
> +	u64 k_job_id;
> +
>  	/**
>  	 * @num_dw_left: number of dw left for the IB
>  	 */
> @@ -107,7 +112,7 @@ struct amdgpu_vm_update_params {
>  struct amdgpu_vm_update_funcs {
>  	int (*map_table)(struct amdgpu_bo_vm *bo);
>  	int (*prepare)(struct amdgpu_vm_update_params *p,
> -		       struct amdgpu_sync *sync, u64 k_job_id);
> +		       struct amdgpu_sync *sync);
>  	int (*update)(struct amdgpu_vm_update_params *p,
>  		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
>  		      unsigned count, uint32_t incr, uint64_t flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index f205adfd59e..0ff2d06bf53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -399,8 +399,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	params.vm = vm;
>  	params.immediate = immediate;
>  
> -	r = vm->update_funcs->prepare(&params, NULL,
> -				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
> +	params.k_job_id = AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR;
> +	r = vm->update_funcs->prepare(&params, NULL);
>  	if (r)
>  		goto exit;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index e7180a6661a..38ca2d78b38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -41,7 +41,7 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm *table)
>  
>  /* Allocate a new job for @count PTE updates */
>  static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
> -				    unsigned int count, u64 k_job_id)
> +				    unsigned int count)
>  {
>  	enum amdgpu_ib_pool_type pool = p->immediate ? AMDGPU_IB_POOL_IMMEDIATE
>  		: AMDGPU_IB_POOL_DELAYED;
> @@ -57,7 +57,7 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
>  	ndw = min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
>  
>  	r = amdgpu_job_alloc_with_ib(p->adev, entity, AMDGPU_FENCE_OWNER_VM,
> -				     ndw * 4, pool, k_job_id, &p->job);
> +				     ndw * 4, pool, p->k_job_id, &p->job);
>  	if (r)
>  		return r;
>  
> @@ -70,17 +70,16 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
>   *
>   * @p: see amdgpu_vm_update_params definition
>   * @sync: amdgpu_sync object with fences to wait for
> - * @k_job_id: identifier of the job, for tracing purpose
>   *
>   * Returns:
>   * Negativ errno, 0 for success.
>   */
>  static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
> -				  struct amdgpu_sync *sync, u64 k_job_id)
> +				  struct amdgpu_sync *sync)
>  {
>  	int r;
>  
> -	r = amdgpu_vm_sdma_alloc_job(p, 0, k_job_id);
> +	r = amdgpu_vm_sdma_alloc_job(p, 0);
>  	if (r)
>  		return r;
>  
> @@ -256,8 +255,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  		if (ndw < 32) {
>  			amdgpu_vm_sdma_commit(p, NULL);
>  
> -			r = amdgpu_vm_sdma_alloc_job(p, count,
> -						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
> +			r = amdgpu_vm_sdma_alloc_job(p, count);
>  			if (r)
>  				return r;
>  

