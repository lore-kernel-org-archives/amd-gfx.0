Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4E8D3B987
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 12:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1641410E1C8;
	Tue, 26 Nov 2024 12:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WJ5nD853";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8029F10E1C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 12:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXxs8jj2XHQTkiRhUimI9zhmQkB7N+6T/NLegh+ZRrIVcCmuOFUo39mV1a4vn/VzB9xIs8I/YviZ0zqa8JguAe5omBJr6jqpjg3sfVNZCl/VrMAqGsUrY6Kcmr9ID03bSFNb2zEsvrM12HNZvd9hq0dIlC024DCYLbJkLBgThSopCfPkxnl1MESNgOjB1cmjkkBh+ewIk2GsFEmXYiPhfSV1g0Q5DMfmcYV0Tw3J7jeY1txGVYJPthrtzc6WXn1JddTyIrZ9EY2nxohO8VZsIymFIw6pz7XM+I2rqmKXHwDO1l2zFhyRJFvr3A5sQyW/Dv44cZ89eoOSuR7tiygy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyxlpr/XpaQO4RXATd2/pK6LGEn6/FOisnaVeRi34RM=;
 b=RE82HXnkSwJg+s9GLXf9gZGNrpWZ4ryBKk7bUJnECwWco4Z/iaXyNaNJ5viAEcl6FPG2LJnSCrD0GEZuk45L0kcspXsZp2PJIqgl4UNLKIw1ssszgNBsqx3hDeKAciq2zC/Niyn+ErBypGdtbLXTCg1e4pGM0LS7cMKa2kYnuqFEoEB+UO9CIH6r7OR3LJP6PZBWYmGeYVEyzes6QzZAJ9/dczET6i2jE1N2Cs52hYx77CL7sc+m5y9qQ7EGxufwK1FIHiHIeGh7lqH8zY+iufpIj3U2vNaZ684FaBV5/1GUSd+8IenRnnpBI0ojNhtfB8O+k6oCYyxW94pRQfK6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyxlpr/XpaQO4RXATd2/pK6LGEn6/FOisnaVeRi34RM=;
 b=WJ5nD853X7OF12y4+GJ5Lt8mZdVfSwUOkgyHmNarREgAst0gCzbFieNSIzLEnDIuJ+sixPMqO2Y6c3IWB+E96vNbKzvYxpZMR9OkyRacvzBuRVdT5pFXrid5Ns8hRxXoJ4KgQ1esBRMIKs4qbOo1k1oedwUnFyL8F7S4nhfn7JE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 26 Nov
 2024 12:03:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 12:03:50 +0000
Message-ID: <646e16f9-6cd4-4f5a-9741-e71171e6029f@amd.com>
Date: Tue, 26 Nov 2024 17:33:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix sriov reinit late orders
To: Yiqing Yao <YiQing.Yao@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com
References: <20241126111552.3995736-1-YiQing.Yao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241126111552.3995736-1-YiQing.Yao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c13d3d-a75f-4a2e-eb8a-08dd0e126374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGhmMWwzSXJ4Vy90SjF6emNFNm9IQm4wY3dzTUZUSW8xaGM3VnNqSnlRQXRN?=
 =?utf-8?B?UU83dm84LzYxOE8vdC9pVEtpYXVxai91ZEpKRm01RnRZRjdXbnZ1ckMreUdu?=
 =?utf-8?B?eGRoaFVzNEtOWDJoMENUOWZuTW5oTWJhZGRyclpDa1llbkhVdUUvUUMzclp2?=
 =?utf-8?B?SHF4bDJ2c1lFeUEzK2dLaEhUUHZ6d1d4NFh0bnlHZkc4T0NhK21HVmJnWmtq?=
 =?utf-8?B?UFpCVmlLOWNKSEREWWNIaU5CQ3U1OWgrU1c4RkJTNVc3YXdqOUwzZzY4T2hS?=
 =?utf-8?B?OUlEVDNWeVpUZk92c1h6YUd1aGlEdGc0OXdBaXJSUTNYbzNtajJIWXVUTGxT?=
 =?utf-8?B?VXljbG43bmt2LzNaTUsvRjlaT1M1STJ1ZjdxVXdlYjBzMUljd0pVeTF5NllX?=
 =?utf-8?B?ODY3TEM3Z1NCeE54MWVKUXgzQ2dmbUVtd3c1dFI2TWtNTDUwWi9DVWJJM08w?=
 =?utf-8?B?bXhVNzhhMUVweWFPQ0JtcVhiVGM1MGJXRHRPT2JyTjZ4RENtTm8vRWtyZEtw?=
 =?utf-8?B?cEJFdkpDMnpDYnM3Wklyb0VwQ05jNTRGYlUvRm44cjFTUFZwSlZhL0dFOG93?=
 =?utf-8?B?REszbnhVenFkWkRTdll4cno2aHc1TGRJWlhmQWdxVUNnOVpDL2RDeTc3bVJK?=
 =?utf-8?B?SlNjNnJnM3JKazd5cEh1UC82STdRL0FhYTZzaDFvUXRuMmloY2RwdWdzOSs2?=
 =?utf-8?B?ajc3RVhncWpsSWM1dnZxdlRyTGRTeGY2dmhOQURxRzJ3WklIMVU4Zit0WnR3?=
 =?utf-8?B?UnpMSnNabkJsWTY2aXdYRlJ1MzUwRGE1a2NOUGEyVlZEMGlMU2xJOGx6NldL?=
 =?utf-8?B?RlJpbGpNK2cyQzA3eTh5ZHdyRFpGSjYxSzdrZ1FxWnVzWG9BeFJrVTg4bGMw?=
 =?utf-8?B?Z0NJOFpFaDRhd3dCUnM5bFhjNm9vbjg0SDVYWXp0dmx2bWthNGR6ZGdWOWZI?=
 =?utf-8?B?M2ZvWUhJVExLeGl5N3NLUUtqRnMvU0psR3V6anV0QVA3bHNEeEhsQlpEUDFi?=
 =?utf-8?B?OUVMVTdiVzB5M2tlNlUyY3AxbnlMMlh6VHJIdHdGUDFiYndVZ2JVb3FCa001?=
 =?utf-8?B?dU9pVVIrdUo5WVo1Z0pjbC9na1lZY1VpTEtQaG5TTkovWXR5YXllMHJBWkZ2?=
 =?utf-8?B?K1FqVmh5Y2RkV3l5THdjUG9VcEdmSTJaL3Q0SWk0OGdhZHhiSGxrVElCeSs5?=
 =?utf-8?B?Z3lnbzdOQXpLUkJCbWVQRU5WYmFhQytkY09VWlFOblowazdMS1Q5bytET0ho?=
 =?utf-8?B?bnZmU0xuSC9FWVF6ZlhPcUtBakpSRVh0bXFwZ3VUOFFLWU14YkwzT2hseHJR?=
 =?utf-8?B?M21RUmdab0ZUNEhPVXUyaEpTQXZGa1B3UXZnNjNETGJKU2pyU0p6RFJMNThl?=
 =?utf-8?B?QzU2OER1SGU1VmZVM1NiUFUxMForOHp5T0F1Vm9YM2VxdmQ5dy8wbExJNnZw?=
 =?utf-8?B?OTd1VHcwMEROa3VsRHhUL2RyNWRsUTR6MjJkVHRKSGNRR3crNFhlMm9ISmRj?=
 =?utf-8?B?clJER29RejgrSCtkWm9YWUtPSUdtM1p2UHhTTEhqYktZVGVMOG1uUGZKcVlU?=
 =?utf-8?B?NjkxcDRtR0lQT3N5VExWTTVQOHlzVGN4NTUwOFVTTnVDZTRtT1ZqSHJHTERj?=
 =?utf-8?B?OHhlMEcvZk51S3puaHJqQVQ5WGRqbFZURjBvNDRXdzVoZjlHZTR5TkxuaHpY?=
 =?utf-8?B?QkRTQUxIdTBtNGRGWUhyZGhPc29uZFY3elJ0Nm45cnFZT2NYOFNmZ0pGOGtx?=
 =?utf-8?B?b1RYMDQ0OVVKbmI2MjY0YllsZERvc2VsUVJROUd1ZENuQVg1ZHFYSXAzZEl5?=
 =?utf-8?B?d1JFbHVya3d5aHZhSE1tdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3BGU1h4eTZUWG9uQTNnYUluRzVmajRDSTVMQWJaOEdKcUVCY05seHNqaVdn?=
 =?utf-8?B?OEpRL3k5MnRpa2RtZVlJUXdyRTVLYkN0bzgvcTdGT05ta2cwVVZSeWhVZUc5?=
 =?utf-8?B?ZDJ3Tk9pYVdUb2lqZzBKMzhXREVQYXEzcnNMdEk4TVJpWTlQb3hOTXlNUnk2?=
 =?utf-8?B?dGxvcU04MGMyelN6RzZhQUtmR3JIK1ljRGN1N1E4OGQ0WWY2Q0NzeWM2Q1Ir?=
 =?utf-8?B?TEFocENaZU4vQWVXQmcvSElTRW1OT2FZWi84YkdlekF2ejJGcW5WdkFZdXRi?=
 =?utf-8?B?NDRiazJ3N1BUYUFCaUZQR21wemZTdXpsbmxQTG9BSWRnRGpKSEg0NXZkSkdG?=
 =?utf-8?B?cG5MYVdWM1QxaEo5Unp5STNaNXhKRjlYK2paVW9WTWFUUVF5TFZTRnIwbWp6?=
 =?utf-8?B?WWEyODZZTmoybU5kY0tMRTd1RXF2NkNFbVB3OUwzSXdHZDhaU3V4UENCRU1H?=
 =?utf-8?B?NjRqVmhUVGxwWU9IdENIdW9NY3l5a1hmRzQwMG5pUTMvd2VrK3FvQWpwR0dv?=
 =?utf-8?B?SU1vSmJUdDY5MnJWdWV3QWtYZ1R2eDJBelBQNlZHZURiZldGWDhuUE8vUi9Q?=
 =?utf-8?B?cVU1NjNYRU5CaHFnaGgzMGtLWXhVT1VKWVAvem9iUUU4TU1LNmR0bUpKdHpy?=
 =?utf-8?B?Tm4zbWZBVkNuOFJObTJJZCtsQVZ5ekt0M0Vqa2g4SkhrMGZSQWJnSkJHNFZP?=
 =?utf-8?B?bmpadVVjRk4waTBueFo5RWFmRVhYTE4xajlkTVVyMWFHOWFnY28zU3crcnFU?=
 =?utf-8?B?NlV5ckVOZ2cwUW5VT3ZSSVJncHJtQnFUdHZwMFFiVVVlVmhQbWxBU0JDcTVt?=
 =?utf-8?B?NU1OU29MeTNKc3NkZ0FESlplWmg0TnJqajNwTjh0VjMvNnl0VmhRUmVCdHp4?=
 =?utf-8?B?VFczZ2JxTGF1MEgweHBneXdsTmF3NVRrUSsxbGNmTUNBMzk2ZU1hQ1NZL0pR?=
 =?utf-8?B?NCszWHJ0Vm9xb2Z1TENiNDJlRjA4SUtNd2hoOTF5SUt1dGxDSWlHcnJyNlFT?=
 =?utf-8?B?QzlaN2RnOGl5ZHYzcHRrOCsxdFZuVWJvdlZPTWpBME9jbldpbnkwZkhTcjNp?=
 =?utf-8?B?WW14aEdHVUlIVjcvMUx0ZVVUMFE4bHJYMU5HVEtRT1VNSWRzY3RQSGQ0KzhR?=
 =?utf-8?B?ZW5KRWNsMkNTbUR3YVExL3lTQm5qRFB3WXZJNGUrbW03MkhNc25BcXY3U0py?=
 =?utf-8?B?RDYrdnk3Q0ttb0ZyMFl6ZWxZZXQ4TndaRzlyTkpadGFOVFVKRVZtYTlNRjBH?=
 =?utf-8?B?MlBHTWNHT2ZaQmtvNHlWdlhCTjJsK0NDSkc2TWd6ZUJpZ0U0T3QvMDFtM3Zp?=
 =?utf-8?B?eVhZeG1mcEJCOEd4bGZsTWNnSDZQKzROMFN6RGYxMnkvQjdqRnk5bDNQYzYy?=
 =?utf-8?B?eWNNTkNiR3ErNThIRmIzMktBUmhpK2JENHQyZFRRMUhLTVE3MmhqSVo5blky?=
 =?utf-8?B?YWRPR1NMN3NpbktnamU1bTJLYXkzMk1ZVFRBWnVJUUorZ2Nzb09ZVXhYVU9i?=
 =?utf-8?B?NHNLS21nem9vMVRjMnRaYTB2VURmRGFRZUcwZTFQRTZpUUlUVU5jN1J6enlQ?=
 =?utf-8?B?R0NrcDdEbkdublJXd1F5V2IxTWE3MlZNSUp6cmR6ZTNQY3paNjFUWSs4OEZS?=
 =?utf-8?B?Mkl4ZktVWnJDQ3ZORnJ2bnpTQ25kemVTOEZIYkYzSkdsd091akhRM3Z1Qytl?=
 =?utf-8?B?bGNZZGtxK2UxNE9TRWhFdjJvd2t3L2dqMkpmanhHWGE1WHdQekkxM2dXamZE?=
 =?utf-8?B?cDRNNDhCaXg4K0dkQ0pqSm5rTnpiWTZiNUxEbTFnNEx5Um9yblQvWXRNZVNr?=
 =?utf-8?B?eDNtNHNGVEd6NkN6NEpsRVNkQ2VUQzB5OWE2cVNqbEtrS0syQkRwYUdDL2p0?=
 =?utf-8?B?NjByeGwzdHgvNll6MUg2Vit1dGx6RmptNVIwOW1nOHZtZW14R3o4aWlBQUpu?=
 =?utf-8?B?Y2p0OFdUNTBuc0xaSXd3N1dFalpENHMxTWdiOFF1cmxacGlOd0lwNTZlZ2dU?=
 =?utf-8?B?ZWlRNnhoODV3NXozY2lGc0cxaCtUODdsajlJN08xV29CeE5ybkhCQ2o2M3BK?=
 =?utf-8?B?SmMzQzV6RHdBNVhOMHg3R3FaSlUreWswNmc1VzVjQjFQVzR5RmNTL3NlOGRi?=
 =?utf-8?Q?VPcOf43TQkQxwdW49/p1LbiZp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c13d3d-a75f-4a2e-eb8a-08dd0e126374
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 12:03:50.0891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guirstcLvnDiw5FPuQFEjhhlTaFqyaoc7sEF+tpIhMbjDSA191C5N7ite5P+KKpP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464
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



On 11/26/2024 4:45 PM, Yiqing Yao wrote:
> Use found block to call correct init/resume function on the block.
> Set status.hw for resume and init.
> 
> Print re-init result again. Change to use dev_info.
> Use amdgpu_device_ip_get_ip_block to get target block instead of
> loop.
> 
> Fixes: 17eb6e7137a7 ("drm/amdgpu: validate resume before function call")
> Signed-off-by: Yiqing Yao <YiQing.Yao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 +++++++++-------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 79c573de1f2d..2e30539b589c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3669,7 +3669,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  				continue;
>  
>  			r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
> -			DRM_INFO("RE-INIT-early: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
> +			dev_info(adev->dev, "RE-INIT-early: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
>  			if (r)
>  				return r;
>  			block->status.hw = true;
> @@ -3681,7 +3681,8 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  
>  static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
>  {
> -	int i, r;
> +	struct amdgpu_ip_block *block;
> +	int i, r = 0;
>  
>  	static enum amd_ip_block_type ip_order[] = {
>  		AMD_IP_BLOCK_TYPE_SMC,
> @@ -3696,34 +3697,26 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
>  	};
>  
>  	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
> -		int j;
> -		struct amdgpu_ip_block *block;
> -
> -		for (j = 0; j < adev->num_ip_blocks; j++) {
> -			block = &adev->ip_blocks[j];
> +		block = amdgpu_device_ip_get_ip_block(adev, ip_order[i]);
>  
> -			if (block->version->type != ip_order[i] ||
> -				!block->status.valid ||
> -				block->status.hw)
> -				continue;
> +		if(!block)
> +			continue;
>  
> +		if (block->status.valid && !block->status.hw) {
>  			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
> -				r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
> -				if (r)
> -					return r;
> +				r = amdgpu_ip_block_resume(block);
>  			} else {
> -				r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
> -				if (r) {
> -					DRM_ERROR("hw_init of IP block <%s> failed %d\n",
> -						  adev->ip_blocks[i].version->funcs->name, r);
> -					return r;
> -				}
> -				block->status.hw = true;
> +				r = block->version->funcs->hw_init(block);
>  			}
> +			dev_info(adev->dev, "RE-INIT-late: %s %s\n", block->version->funcs->name,
> +				 r?"failed":"succeeded")

This will come after every reset; better to keep the print only for fail
case as before.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +			if (r)
> +				break;
> +			block->status.hw = true;
>  		}
>  	}
>  
> -	return 0;
> +	return r;
>  }
>  
>  /**

