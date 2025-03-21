Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F879C36002
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 14:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A3B10E7DC;
	Fri, 21 Mar 2025 14:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WVdhnTYt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70CEF10E7DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 14:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6i0DIYQlqC+kGnIzN6ep2j6AqlsAtyBHA2gitNWkJy3fk8a9pc3KxYN2PkREZDTRgGxYN+L9hlcAbqeExldEiH7W9NSAGVA9iESasD4kGEg13Nyvst2LxkjhkyxXCzDuPwLKbrMMwRm8lS5swVh/u1WsiqR+PyU61nOXKLPBUctzmhOdkLBdBYp56NV1EGf5sHtLG2+tkds/UT7oYK3cYc+gxN6qSPyL/j+iRnrRZlWoagcs5Cg4cjJCVvqzv8NbNK1lLQXj4XfiuJlDNIwtMzjfypTkCnQ8JMYdMAlmvDGsQsCTRM/PKNpQocpZGwVYD9LiHMPqu1gSrVNRxsCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koucb2V1eTtEqCb9DIwAwEZ3pHmwRFCbCweeJPWEBTs=;
 b=aTxDzRr/T3U5n7LxdNDpnGXo8gj+EaL3LsrX0b4MsXMy6PaC345CgaTl2X2zU4dG6NqDB7RtS8ntHytYP7t82Vae/tXT8UXJkoy4RJaxk4Wx1HHxJUvpAqEJItiyatYq/3+Y4gIGkSJgfA33r93iYrDCiUyC4VFHPJxkvlTnvFe70yi1sQKTl64tsgdbj413nVtdhpb/XxsrsRGCBUhS2moKSOe7j4K8qWLRZSKLiQP9DH+st/xEZGEOo2KVpQRozG7B30vF23j68/RmmVcjuDHAH6qx31TdJvpeUTc438jWLl2dojSYaKccpmkLW8faYxjyvfzZESvpG0gVhgGACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koucb2V1eTtEqCb9DIwAwEZ3pHmwRFCbCweeJPWEBTs=;
 b=WVdhnTYtA2Yu5IQxNhAB4byQ4svH/R7Xw2rYSHETmuTmYRSvlFPljEPNP3KccyKSyhcRnHLs6M+i1jjhTXB8yWw7RsRIrwOn4xAWlP4jqqEUsjbVDHWnbIn9AI5XfY1xYt5nvN9kbTkoAwrhbcuVtFv9HqBJdA3SJQEXAVujk1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 14:10:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 14:10:55 +0000
Message-ID: <b2f6aa2c-3f56-4d93-90f7-2712aa3d4174@amd.com>
Date: Fri, 21 Mar 2025 09:10:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: add proper error message for vblank init
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 alexander.deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: aurabindo.pillai@amd.com, alex.hung@amd.com
References: <20250321113704.390163-1-saleemkhan.jamadar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250321113704.390163-1-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:806:126::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 68af6f69-b95e-4173-30cc-08dd68823214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGZndlUxNEU5Q0p5ajQ5dXRmT2FoV3JWNy93TGZxTW8rTEVPZlpFT1dPZXBG?=
 =?utf-8?B?dlZja0o4MlA4RjlQNVFoTmIxbjNUdExlaUoyVCtqYXlldlJnSHl4UHN1QTlq?=
 =?utf-8?B?eFpxcFJGYXFnTUpIQ1p4V01sZTAwVUpTc1JSdHlGVE5OejZBMWlIOHlsOW90?=
 =?utf-8?B?Q253OFljWnFKdFB2dm9mWHhkQ0FpR01hNEVDS1c3b2lZVVk5cTZCSklBVWdk?=
 =?utf-8?B?Z3U0dXgxZHRpSytFVXZJL0FsRVNhT2RmTmRLOWVSRVE0eld2YUl4ZnRvTW1k?=
 =?utf-8?B?VklJV2lzUDh1UnZVNE8rUW1RK3FXSFdrYytwYjZkVTRjYmZMaG1JeTMwN2NU?=
 =?utf-8?B?QzcwUUd6TTVJeXVnbjJ6YzFHNjRNRWRlamZucXg5bEp4NkpvMUlpWlFRVGdH?=
 =?utf-8?B?WmFlODRJeUdGT0VsSFNlUmsxcDdRZkxFeUxsdkVneXp6eVZGZzZkdStwVllL?=
 =?utf-8?B?QzBHTlRwSUtXWjFrZW5SaUM5czJaYStqR0REVFN6clJTY1Rkd05hU0lOMTJ6?=
 =?utf-8?B?N1o3VURRZlNhVHM4aGJ2cDdyeVZ1OGsvcUFPKy9Rc0p1S1NmazF2d01KWCsv?=
 =?utf-8?B?dUphT3FyN2ZHd2VlVjliK083NnFPLy81dlhTcWU3aHhrTDE4TzFndHVBRzAy?=
 =?utf-8?B?V0xndG8xeDgwRTZWMjh5YVp4Zk1HN09PbnVJRDJJNXNtUEFQcE1JVjRkbU04?=
 =?utf-8?B?Tkp1RUlFZG9ER3JobWY0TnpsSmk2K1ZzK2JFWENBWDdIMUk2VnlIMGl6aGVE?=
 =?utf-8?B?KzgwanRYM0oxS3hycG5qbUJtQlhNNS9jK0ZrMW9DdmRZbWlldE9ldU9pVUpO?=
 =?utf-8?B?N3FVTVZpWUFRdWpIK1h2ZjMrZnBJb0dlQ0ROUFJRa3BuZkRHWDE1OE9Nd1ZU?=
 =?utf-8?B?Z1owdGFzWUlSalpncHFGamJwUy9GRERzaThyOGZpaVQ5dmJLekVObCtvYUlr?=
 =?utf-8?B?RThNYTBFeU54ME9hQVFlNkI2bDh5SnlsSXdzRzU4cFEvOGNIWThkQVFqTHQ2?=
 =?utf-8?B?S2JBdEk3Rlp6V0lXZmNhcENsbWZZS0NXdkVJNm14WEgyVXZGdm5GUU5WYTFq?=
 =?utf-8?B?Mk5JWHJPSnh1My91anppdkxlc1RZd1NRMlVrUDBTTHRGVjNaYlArUDl3Zll5?=
 =?utf-8?B?R3VJRituSmk2anYzMWFKSEtWQjlWV3phQUNnZjZqci9yank2dGlubUhyTTNH?=
 =?utf-8?B?QURTVUZRMHZIdzAvVTJsUlJCVjhWVGJMYmxVbVJGQXpna3ZFN01zaHg3SWNO?=
 =?utf-8?B?UmIyRjYxaVNySlI4NzN3VGZaSlhHY1NLaGNKd2pUaUNua2diYTBnNC9Kai8y?=
 =?utf-8?B?T1VjT1poM2VEMkRQOWVBYzVoRUZBV2JCcGtjQjM4Y2JMdFN6a3FMQTRjZVd6?=
 =?utf-8?B?ZE1XZWorRnpCbDliNUVUeTFZc0todHFCSUI5THlIMUd1QU0xUmdGRkVVVGI0?=
 =?utf-8?B?TGdKcXhOd2NtVURJZm4wMjJEL1oxeUhjU3VaeVV6Zk9VSmVWQ2tKZ0pRdm5Z?=
 =?utf-8?B?bFRkYzRZSEIxdmdYeVhkcE1IQ0JhY2RMUUp6aGk3NFJDQVRUUVhoRG9BcFMx?=
 =?utf-8?B?M3EzczNSdXl0QW04RW9xVXdXY1E3Q0h4SFVFRS9yK0JTQm9MbE9MdGxHazRG?=
 =?utf-8?B?cWRkNG0waUoxVm8rT01JcmZJRXhMUGJOSndmaHY4YXFNRGM1N2VMTVJ6bmZR?=
 =?utf-8?B?cmRqcFRjUzNkUkxxczVGTUdZMmtzZmtKWFZ0QlR0NnR4Qnl0NWc2YUoxdU12?=
 =?utf-8?B?Q3JLMHlMYW4zR3B4aGdLNW5Va09vajUxNzgxWEZEYlh1WU9UVkR0RWpKWkFE?=
 =?utf-8?B?V3hDTDYrUk5VaE1ZMnBsYTdXazZrS3RQU09Kd21yR0hvU1M5WC8ySGdxQW91?=
 =?utf-8?Q?8b1HOlF0VzauV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNtY3hDVjRFUDdZalFxNUduaVBYaDRhNjBLZlppWjBjcEJyVExxQlc0QXFC?=
 =?utf-8?B?ejcrby93Ui9ZZkJCaXJMd1p0dkczSm45bE5RNmlCTXE4OHRZUkxSWmlPMGNh?=
 =?utf-8?B?SGZSQlhESDZUYVpIazhtTFpwYmxHU1lnaTdPQ1Q2RWM2eW9SVUQ4b3BROVpn?=
 =?utf-8?B?VDBJOEgxSnoxRDEzWWc3RGtDN0txeHlpZXowUlhFRjdUMFBvazd3MlZOSGp5?=
 =?utf-8?B?eDVaRE95VS9YMWVMT3VxMlpOUjFVQXc1aHdjblkrUnZiMTBsMThtYXE3bzQ0?=
 =?utf-8?B?cS8wN2R4Q0NZZUszRnlOa3N1RlloVXdaeE41NW1lbVFnSnNXbjJSM2tVWWRV?=
 =?utf-8?B?ZG5nOHJldHFwbDdmTDRxMVhreFNzYk9zZzZ5dUFZQVNERXgva0tlMjVpdmNE?=
 =?utf-8?B?d0swbm4rU09Sa2NoN2IwUGVHQlo0RVlxSENxbklPSVFBcTBqbko0UlgzTVZo?=
 =?utf-8?B?SGhjZndYUC9kcUxNYVVwcHI0bXBrRE1aZXdFZUxmZjNqbjlFUENpT0w4NXRp?=
 =?utf-8?B?ZkZ1cEhLS1BlMXloa0ttS3NoMWwzN2RmOFZJMUpzTU10OFJWQmFjQWUwcUhC?=
 =?utf-8?B?NXlBcUdyYWRQNEF0S1N3RHlQMlFUcHpQSUNISW9mQUJSZHE4bnNxMEY5OUVB?=
 =?utf-8?B?T2F5VDBCOEpocVpER2l6b3pVUitONWhtbHR3T2RZMy9Sb0R4U3JUVi9TcFNi?=
 =?utf-8?B?UEJWQ0EyMjZsenpnWHR6QzNNQUx5WnppYkFqN0Vkb2VXNXFWcUJOZU5oeG40?=
 =?utf-8?B?MEUrVmp5bWM2MEpsWkhkdzJhTGVRTFdQYzJ3ZE1xYWMzMDEzN3kwak94MUp1?=
 =?utf-8?B?T1hXYXVzcklQeXc3MlBvZ01XeGtoWEdnSE9rSEdiaEF3TGhQQlJsam9MNEQz?=
 =?utf-8?B?OGFHZ2tlUkRoQTJZT1pXODEvZEtaY1dDcmkxSFVkeGpGZnFMclRsOFlKdlV3?=
 =?utf-8?B?a1gwNUFma0VUbUlocFVSbCsxZVJSK0hMUElycFpoQnVyVU9oWHR3MkVsNVNK?=
 =?utf-8?B?YlR0a1Y1Sk92bHFuSHhlNUxTYWl3QVVremVmdTczdXozWVQveEhJUDh2dHBa?=
 =?utf-8?B?Z0JlNEYwRW55M3NCdUNLRjl2Tno3dXZyY2xwN3NTVUZxblNCcjNVMmhselVo?=
 =?utf-8?B?OFNhQUR2NjU0WmU3cGVGYy9zQ1JLVGF4NlE0QmQ0NWlsOEdRbnNuZG5hQTNt?=
 =?utf-8?B?VmY5cGFrU1JGSURpUDJRSExVOVdWN2lHZUtQSmNJOXhZa0xlOTZPMEw3WEFQ?=
 =?utf-8?B?ZXZDYVVBK1FrV1A0YmN5dXZrQU03QjRJdmNLYlNYd0ZCNU9ZWmJlSkx3cTdU?=
 =?utf-8?B?bjRWcXJSRzY2OFY5QWZhNmFjMENCSU1xejNDWWRoK0h4VWtjQWR6bW5MK00y?=
 =?utf-8?B?QWNGUjJMVFpHRE1MNCt5elRPS3JoaU1NUkpyajZEZ2lOUm1VekZoWmlTZGhW?=
 =?utf-8?B?b21Oa0FIZWE5KzM0NmNvdk5CSkdsRXU0dGdUZk1MSTlmcHRLTlkzYnNBREtD?=
 =?utf-8?B?MjhNZ0JvUVBIeFFMQ0xmODNjVnBjcTNOd1ZKY3g2c0tVbCtDYUp0cXNmVis0?=
 =?utf-8?B?U0E3ZlhJRGZ2Y2RsNFptUmJMRGxYQWE2OVNZTEx0TGMrY2RrVlBuYXVFeXZU?=
 =?utf-8?B?WUlSeUdmaS91cXFZYXRnM1hEaVVOb2ZVZVc1bnQvNjBVMnhnVnc5RE1QQ0gy?=
 =?utf-8?B?SlovTmNZV0dXVVByL3h2VXRJR1RpN2c2OXFRKzFyTFJTc1M4eG1QcTZjWFYz?=
 =?utf-8?B?Q2VtNzVUd0YvWEYzOVhoMVRXV2srQ055dWJ1TlVrR2N4emZ3ZlFBUGNkMXdK?=
 =?utf-8?B?bnlCMlFsUUdjMFF5MWw0TzZ4S1JXb3NsVXQ1TExEVWE1UC9rL2lqZEtkMWFt?=
 =?utf-8?B?V0hOZzdqc2R0ZmVSRlRnTmZKQXh3NkhpajBSa3JCQkdIT1pONS94eXR3aFZF?=
 =?utf-8?B?L0QxYzhoVlFJZDZpMjJ3Ui9lMmFyeWN3UEZZTjh2NXJ3NXBMUFJSOGJrMWpy?=
 =?utf-8?B?bjluMGZEWHZrR2lGeWtNbXAwQTRvUFRjNElaTTNsdmMrbGpLNjZ0djhwQk94?=
 =?utf-8?B?VVgwVjFxYjkyNHh2NEFKOUhrZEtSS2l1YVBSNDBUb1JqSVk2OXJGcVNyVHRK?=
 =?utf-8?Q?d9cwcstZMFmFgm2znF2+lgA19?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68af6f69-b95e-4173-30cc-08dd68823214
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 14:10:55.3995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aebr/6WxafnfOA8jNPd9hFViGzEcemeH+EwG7GIPOxUwlnilbPOGY0EpDGS6dLiK2B+e+TyiXCKRSiXs4zZzdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
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

On 3/21/2025 06:37, Saleemkhan Jamadar wrote:
> Update message to identifiy the vblank initialization fail case
> 
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8dd9bf58eac5..3decf1973c7d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2218,7 +2218,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   
>   	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
>   		DRM_ERROR(
> -		"amdgpu: failed to initialize sw for display support.\n");
> +		"amdgpu: failed to initialize vblank sw for display support.\n");
>   		goto error;
>   	}
>   

While touching this could you please swap away from DRM_ERROR() to 
drm_err()?
