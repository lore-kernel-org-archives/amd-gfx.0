Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F5BC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 07:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3307F10E685;
	Wed, 25 Jun 2025 07:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OpbAcY3n";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A850810E685
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 07:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISGLqefue0o9ol44pZahxwY6A5h6dG9ma7e1ONN/wQ9MKLN6oItoQRKrbbhYFcMy3jYdWccNX9QnJ3TlqVk3BG+BvVqKjui+MelYZCR7nAzNmXxjCZyYbevEFMy8KWZFcsT4tvwUxsFOobfj7Mfd2I1INt+m3Z1c/EDjqi8t0pTdMS+mNFhKhOyDAHfOHPc5oflPkVSwqG/IQkHRmNiA0FrEK0uzpY5ritng9yXG5Vad9YW82kuoQHiCdW2p3PBVi+X06chhj5NL5TnVf7BXeyQ4hDSSttPlWEhW7Y8yUqlm50TQGNbPvPqkwwLr31roKVoD0UnxpIESdAQzYMOgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRNnWNHXpuDlF9oIKlJcbFMWmKfAuoP9P3yBiGJAHIQ=;
 b=hPefC/3eI7hF4jSsFrD8aOIdMpT2Cfms9yh8dY2tUklPeiRxs+LyXczJCDVCHdSgQ6MdIMJ6HJO8B8fxaUDt6yvPhNbM0sy3w0m3qTduFZxxdpMC29icZpx7CmIJHGZLpf8DHWEwALaHqKpI4DEZCCjS00RMK8F+eoFYnHTkBYOtNiiBXLBgbCBxjBzybX9tTYwIDJdt8s3DfZ7LbveN13eGgyzuVmOoo8JIi+8CwWidkQr9vuzjW6Touvpdrcc4J3VEDiNYGPZWw3s+PO8n2dWzBK3WdN4N7pcfIQkOzJ9v5+bdWBZMgZMPOe9gt5TXvsFcbgS1uH/Loe8tYbhqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRNnWNHXpuDlF9oIKlJcbFMWmKfAuoP9P3yBiGJAHIQ=;
 b=OpbAcY3ntgscKPciXadftEJ0Exx9yCcICqTaczVXfobX2Hr4egyxCSf6CqO8HyMj5Y/IpsNYuy2Qdl9+LEjhFApw6xSqklrqA/+M+ZIG7DSCtgX1/f7LYMqW59MeiVpRluIDtTGgTyAcOB1Q4x42rVl1niFKQvZ4BVvPbLVqrL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 07:57:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:57:09 +0000
Message-ID: <52b2c11c-9bac-4bfc-b690-9e05acdaeac1@amd.com>
Date: Wed, 25 Jun 2025 09:57:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] drm/amdgpu: unify the userq doorbell object
 destroy
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250624084535.1178476-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0297.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 3678009a-e6e5-45eb-c2ca-08ddb3bde269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anIxZXV6ZDBPbG80dEJTQWthS2Jhb21NZVRheHZSRjNjdGRGWUJuRVpSSHFU?=
 =?utf-8?B?elRnLytFck5uYk4xZi9pMys5YUdSaDZ1V09tdlpGZUE0YWM3SHdqKzhyUDR3?=
 =?utf-8?B?UzhabTRGcTlVcldFNkJGVk5SZkZ3S1Z5UERoUW5kaWgvK0Y5U0JYd2MxTDFl?=
 =?utf-8?B?aS9STGg5cTl0eVQ0YWdzSHg2cmhKbjFPdmxKWXlZOEZVNHlIdFExK3p0TVJt?=
 =?utf-8?B?bW83QnRBS2M3M2tMUElmNFdzcEN5bWNadEFyMDk5RHdtSy81VFoydFZOcnVy?=
 =?utf-8?B?c3VaRkVKWTlqRHdqOEhseWo5ekhLZmRPbU5Nd29JS2NSc3pMc0NEcUJIUkFi?=
 =?utf-8?B?SUNxcXZteXg2YytVcFlwSkxac3hkNjI4a3JWd1BmeXA2QXNIcXhudmpuVjFZ?=
 =?utf-8?B?dFZNN1RTT1JwS0JyQ0pFRFIwcThxUDdQSFRSeFRuMUJoYjZBNmN0NkQwQ2tn?=
 =?utf-8?B?NjlNRkljOVQyNkEwaHA4T2lNNlo2ZVcxeHpkRXdjdGpFTHVHdm92djBveUcz?=
 =?utf-8?B?a3p1TmxzTzZtdUYvOXVLRitTQzhqYlNGWDlEL2piMTNoUHZpNWZaeUc1VzA0?=
 =?utf-8?B?dERaSVdKTnhWV0plM2Zzd0lIMjBhd2hGOVNyTjJRZTRNQk9TWWpQc3pxWVNk?=
 =?utf-8?B?Mm1Uai9BR2ZzbWwxZGZuOWNjTC9VbGt2QTJMeVFXMlRJYUQyeU80SFh0ZTVK?=
 =?utf-8?B?WnBnUm16UVJpdk4vNmdRZDFqTEpPV0x5ZC9kL3d5bU8veEJhYVp3QXRxSmJI?=
 =?utf-8?B?YmdDeEZMUjg3d2JXOEZoMWMxN0FXS0hueW5uTXAvbUU0QWpuRk9wVmJBeER6?=
 =?utf-8?B?dEdYdWVPc3Bsb2NHa293bG41WGRRWHpIY2VxSmx4U0w5RFcwNXl1N1RMa2p0?=
 =?utf-8?B?RGQ0cC8yTXVTcTR0V0s2RURVWnpma2xuRFBkendpZDNEbXZhYk5IZ1doTG4z?=
 =?utf-8?B?ZjA0bERGdkdxbVREOXhGem9ReGpjbHliRnB0ZXVNUmJUVmN3bjdOa0V0YXRl?=
 =?utf-8?B?OTdCcWx6YWt6SUNadlNOb0dZb01lQkp3S0VseERIOWdGdCtZdmlaOEhmMjRI?=
 =?utf-8?B?QmtZUHUySFRJcnhxcGRUSnlNeXVEVXF4Y2w1SmFsOHFzK3ZGV0s2VW96RjZF?=
 =?utf-8?B?ckVQTkJRZ0JKd1JUMWFGSGsxTU5vcXF1aUpENko5RnFBQXZINEN6TWFNMkFH?=
 =?utf-8?B?aFh3c09TZkJjclcvMmlyd0dnRFFvTWI5QjBBVXNGdzZ5Wkh3ZURHNmhTZW9H?=
 =?utf-8?B?b3psOFRyUDBpR0tTVTFadmFqTU1TbmxYZll1U1NydVVKNlBTM2JydjBOdDcy?=
 =?utf-8?B?QjVja1RXcWtpZGJDT2swa2tNSTVzUEV1YWdTa3lUV2ZrdGR0WG8wb0pVcEdV?=
 =?utf-8?B?a3VBSjR3TEVnNzg1VXcvOStkTExNMGV6WU9KeGM4aHBxaEtMcHdBY3A2ZmpM?=
 =?utf-8?B?ZjEra0FTZ3MvYUxVdDB6M2NFK2EzSCtoTzMxeGt3THpoa0Y5dnRXaEFoZHYx?=
 =?utf-8?B?MUxZbmM3VlhJT0xRRHZuaXo4NW9odlNpQXhZOTVIS2g4eFQ5UUJ6ZW9PR3dY?=
 =?utf-8?B?UGRhbTNsbWZhNm45ZHpyZTBTanBFZGMvMHg5MHZGbE9GckdHOGg1VGhEVk5K?=
 =?utf-8?B?dUQvM29KUWVKSXh1RlFoTCtGT1hyNG9NSFoxVGVjY0FTY0ZnMyttOThGYUVx?=
 =?utf-8?B?K0lsM1JKcmt0em9TaEdRNEVHOEpWaE12S1hDMUR1cmZkKzZLK3llbjFadUt4?=
 =?utf-8?B?WWJxek9aZUc2eXhGdGNqaFphSjFHZ29HcmhBZWJXZlIrRkYyMGRFeGNxUm9t?=
 =?utf-8?B?SjV5K3BMODd2d241ZUsyeXRvRkZBc0FyVW9VTzV2STFIN3VTUGtMYUpPZVk2?=
 =?utf-8?B?czVJU0NCb1lGYi9mRmFTYlRiNVl4QXdNeUpxU0kxOXQvUWdXdUIxQU9RclA3?=
 =?utf-8?Q?L6fDuVHCy+c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUk3cEZRalhuMis0Sjg2bXRYL0JsSTVYRmpQRitBVVMzNHRSbm84Nm5DQjMr?=
 =?utf-8?B?d1E0TldPSFRGOEwyNWhhSEFmNXpHZUsyVFZRSVpkZGx2R2o3TURycitoMXB1?=
 =?utf-8?B?UlU0RDlFWnRRNHNsVERKdDNlMmQvcHhaVDJxZ0R1cjNRR1FxR3lDaFVUM3dN?=
 =?utf-8?B?SEVQUU5XUER4TzI0YkpUeXVoRmtVT0R2bjJqYzBMNHJ3UVdjY1VsMVdMN0tI?=
 =?utf-8?B?T0hpb0Z1djRpQ2Z1V1g2c0IrS3Y1L2dMZ1Brb1kvRUFxQnJPZWdwRjhvY2hN?=
 =?utf-8?B?ekhaYThhak9TTjUwVzlRNnpOOUFrbUNieG5mdWh2REYrTE1FSGhYSmNlVU9a?=
 =?utf-8?B?bk0xQ2tmYXN0US9NQ1VBLzQyRk9NSXp2Y1YwVXlzMFE4R2RZTVYwVDNKR2hk?=
 =?utf-8?B?KzBwem91aFdCWEJuK2pWS3c5Z3BvcDdHSEFLbW9Idy92QjZCSzRQR0d3MjIz?=
 =?utf-8?B?Q3p4WUZ4V0FaWHpjb1JwMnVuV05zakRpK0dmMmpCclVFUC90bGFRRTJXWStQ?=
 =?utf-8?B?bDRyelNsNjJkRldHZ3R2STZTVjdWZTlLQys2U0E4S0NyM1ZCdTEyeXI1VkZL?=
 =?utf-8?B?ZVZaR1p1TExTWlpSelU3ZWlhSjE2d0VuWmh6THdBUldXVnk5OVdTTXkzL0ds?=
 =?utf-8?B?Ti83V2xGMllBYzQ5bmdJWVVhUTVySkF4a0FGOW9EU0w1KzB0djRBVjRsNTNv?=
 =?utf-8?B?M1VGMzdISi9sbWVkdXdGdFlzVHVJWUQwUDdwbFg5UUFPMi8xeWthdGw2YVBL?=
 =?utf-8?B?bHZJK3FqejFFT0FhQ2U1ODZwRjFMU2RyUVVsZDl6RDB3MTBBS1h1U3VPNC90?=
 =?utf-8?B?R0FqNlo1cFppazJBRlZDcDJIbGYyRlN1eTZRU0FoeVlBVkdjQUhyUVR1RlZ6?=
 =?utf-8?B?MzJhekx1MlJSUk80T0lBYVQ1N0NqeFJ5S0dLc3NoMXQzYzU4T0RvRWdGNU9w?=
 =?utf-8?B?b1Rvcm5Xc1orNU9OeStsTWM3VXQxczNWVStVL2hlMERGMVhETzcyS2dmcC9Z?=
 =?utf-8?B?ZGViSjZaODFkTWNwMFB3TElsYkxObEY1Uk04WUkvVHVJbFZNZFlGVTNzRDdZ?=
 =?utf-8?B?WU5lNFV5SGh5WlhGU1NONGFWc09SWDRlUDVZVkw5V3pzTW13VzAvZHJVVnBu?=
 =?utf-8?B?ZEdzckI2d1JIZHhoOVpobHg0VDczaUZGbHp3YXpITWk4K0dwUUtHdlcrZ1Zx?=
 =?utf-8?B?bk9iWEMvZjZvNWl5c3RvMjM5S2ZmOHVYT0pNNEJIc1dEQ2d1TUZxeVc1eVhI?=
 =?utf-8?B?K09mRTRtTUlkNE8xWURQMVRoUFdDb091YVBCTXIwdmZrdE11dWtFUTJZU2E1?=
 =?utf-8?B?QUVoRVY5RENRZzNMby9PU2lMcEprNGh1THJnSE9nWTQvTTcwd0lTbEM4aGRa?=
 =?utf-8?B?eW9ncE1xUW9LVmxaU1FxV1FaRWdYS2RMQXBxM3BqZnFVT3BHOW40dlVOTU1l?=
 =?utf-8?B?dk5VM2JWcXQrRitWQXJYUHdDb284L09iOHFnZ29yV1hLTktmZmZjTkRmNmhI?=
 =?utf-8?B?L0xRcjhRWGlNNUx3N3VJMzdTMnFIMVJOVUNjNjloS3gvM25CL3I1YnZWdGQz?=
 =?utf-8?B?bEJ2K1N3VE5ERHkwTjFrR2RHWk1taThlaEVpTTNIdDJWRmRUS3pHT1ozMFVM?=
 =?utf-8?B?SW1nZVpNcEZSOENrTU5jMlhvTytueVVoenFJQk9tOFJQOU5TOU52RFN5OWM0?=
 =?utf-8?B?b21YWnhyTG9NZitPMEFlTjBKN0pzZTVPRjVqWTZwc3c3aktWL3dTVElxWGVJ?=
 =?utf-8?B?VWZUQlJwa1BEaFJ3eWFxTUcwdll1QTBrRlMxeEQvL0lJbDBVemExMWcwVkZG?=
 =?utf-8?B?OEpZRlEyVm9RZU5XZXZ5ZmVMQm5HaXgxTXRTNUlia2JsQWwrYXJSTTRFMGFy?=
 =?utf-8?B?b3ZmVGpZWDhScXVzM0l1U0plNk5PcGg3dm1hU1NlS08zNHJsc2dyOTg3MVhr?=
 =?utf-8?B?YTJTVXQ3aGJiSlJyc0tWWGhGNkRXcFRrQ3N1ZWRRZDVsZXBxc3ZkUWhoYzAw?=
 =?utf-8?B?dWFkNXdSWlhXdUY5RDkzTmo5MVJRZzFYNjBESW1OWGlMS1NSYjZCcUdVU0ZK?=
 =?utf-8?B?UmxVQ3lRTkxzTlZDYXplVm9SVXNGL0lkRy9KVGVYakFjZXkyUWJkZW0wMkdi?=
 =?utf-8?Q?DU3Vz/lfj43aacjUHeOAESUhQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3678009a-e6e5-45eb-c2ca-08ddb3bde269
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:57:08.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSGSV4ogGunewIAFyV4NwEJ9cHBAUjf5JsO7blWDYn9QXe97SeLcDfygK2Frj4vn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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



On 24.06.25 10:45, Prike Liang wrote:
> Unify and refine the userq doorbell object destroy.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 1 -
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c7c9f9e597f1..acaea4416ed2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -317,7 +317,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		amdgpu_bo_unpin(queue->db_obj.obj);
>  		amdgpu_bo_unreserve(queue->db_obj.obj);
>  	}
> -	amdgpu_bo_unref(&queue->db_obj.obj);
>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>  	/*TODO: It requires a reset for unmap error*/
>  	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 1457fb49a794..dbacdfcb6f7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -336,6 +336,10 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>  		      struct amdgpu_usermode_queue *queue)
>  {
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +	/*Validate the doorbell obj whether has unpinned by amdgpu_userq_destroy()*/
> +	if (queue->db_obj.obj->tbo.pin_count)
> +		amdgpu_bo_unpin(queue->db_obj.obj);
> +	amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);

Absolutely clear NAK! You are breaking tons of things here.

What the heck are you trying to do?

Regards,
Christian.


>  	kfree(queue->userq_prop);
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }

