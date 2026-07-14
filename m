Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8706EC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 12:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0213789FD4;
	Tue, 14 Jul 2026 12:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Knqu88bu";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D50D89FD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 12:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgH1dD+WVasd37xIrpk0biD6Vkw+MG4heOPBZhCEJeEZ+5YUkgH0Ib8h5Xkm9+s43TmSC8cP+5I4GkjvEREnI1+DaoPIyUXaS/gHaG6RhxNnqBPv9h8MdtUpcaTO09Gfng2/yxwjzkWI4n2gDOup3x7nPXq/CWQ1pB0sVjJfqHkDIX1pZ3rhcbukLU1G5+nYRCl+v8f+vaDsvBJ97F2jIZb978o7TUVkiOAaKzz3O4N/HGAM6Q4wQaEYlCe5tlf4Um5vtf4iElgKSB3b+3qgJ5PI7WkA0CrMeY8kGKXebvBkEnU4RdA6lEh679d/rXuccBH0yZ4TnUKm+P9wd2YhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4CZIe6t9T2LLVnPD+0TMMSmKdLMGfluHYIEXpUZPCc=;
 b=u5S78NHacObM7zrLjeylk9K6zjYLzP7HgySbVHItjiAZ1gTjuolIPT0zzQGZhgzGyFn2v6tOiXqWrphTOi3ZKPv/JiCojFTs9LUspjlUiZ7k/y9fTOV7qcjei7aMbpPIFj47YlcWPA/+f75LLV/49lVCLqCDhVIdu6i7taorJPnAu6aJCtbOuszu4eHGYMAHs3yV2Rbj7lBgC2sXhbiYYhGvSUMEy4H5oRwJZt5J/8EZHHVXLJZxQ/NvL6BgFe4BBnIci2Y7XvcdBEVow/vcxn7X603msrqdZ18DMju3kx+FHAGIMBKlBTm11e5m37jzTkHP5OrDEd7lZTqjmfVgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4CZIe6t9T2LLVnPD+0TMMSmKdLMGfluHYIEXpUZPCc=;
 b=Knqu88bu0K+zRIlX2OZ3sKQA5bGzfqmPU9WGQb+3O3oe6B7829cXOFrUZD2AkxHFWmR0/t3CjtoWTcIy91QKBFpTkmZUZgrC7JkffrhDqeYHKYffAa84Hu5zD3IY/kpQqMCgHQ03PvjZAjRMCLSzEZQCg9V4DBfH5G8p+Ku97wE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB999078.namprd12.prod.outlook.com (2603:10b6:8:2fd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Tue, 14 Jul
 2026 12:50:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 12:50:55 +0000
Message-ID: <2419fa93-4af2-4311-8ae4-82d6d0b855c6@amd.com>
Date: Tue, 14 Jul 2026 14:50:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] drm/amdgpu: Remove queue-scoped WAIT_EVENT records
 on queue teardown
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714081023.3395485-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB999078:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f592a95-5ba8-4390-b439-08dee1a68b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HZgH4Z139XhPz3Ihj2lrxkovpVGSXRu2M1/7oruLPyFqPQetAAPWrHGVpxKgNgghwxmsz58uKQWpZL6XEHo6taUGgKAz44AnjO2pJqRQZADDKE1EZs1BaFc6Bhf6Q+5XXnuyMXRRWbcFANDPm3+a3TVIe91jsb7fNCPQCzlHUDUhxyVOaW18eT/wpDI5AMO7ZJ3p5MAQcdFUWLen7AOY05LD0s1aXLat1hQ9SOQ1k9vtgd1RTDwCFBdkIPgLVtebnUot6rwCWRuAGJbMqYdt6nx466lrREw8UHM+0oYdrJeVIHzYZTQ+IpK0XxICtvAqrc6YagAvl+kSR8d0lvnvLQDCkwH9PiYBdNCYHvgsCzNBjAlVg0XOATOgRHlLi5hqQUpTfVkhaMPfOpms2+xpJG4VRn4InatDRjtQe17hrdXMH/xXP9KCz2O37Z8nhLrQp3S3rIv9XFMngl9jq9LdnP7KhKfbtdLTsOvsrzfHhDLDWuIvLS2/f2h24G/A14pcr2z1roLvQHq+vR7n1ilCiZlJobwyGN0LbvZOflPjBXLCKl5QZ0/7aLwLx4UMLll/4VDBkp2cm2VYC8sJ/xtIMuwteKXJa2QF+H/zYGv5GpGstIwE+S/nFn+iCkkoBJuRIa40HPCRWV1qCQ4Q0tMrtIXfCn/FcyTgyawbdl15QJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBFb3d6UFFEWUNUemd4RmZRQmp6NG91bEdqRGpXRnNubGx6aVhWMlYvLzRJ?=
 =?utf-8?B?endVaDEwTWRObVl1WUMra216RWdMYVBnay9sT1AvczZYNWYramMzbi90UzVH?=
 =?utf-8?B?c3VmZWljdzRZbGVrTnB5bWRyS0Q4ZnVuU1NzWTRwRk5VeWMyWGpSVTgyN251?=
 =?utf-8?B?VkhobFhyNlM3NTBxZ2JWQVNHSnhCcTYzZVdtMWl0cXJTeWpQOFNld1J0bXQ3?=
 =?utf-8?B?Zlp1NnpNZUNDVFMzd0s2RC9TbjRkeUptSVlBRjBxbUY5Tk9TSS9maVRUZXdz?=
 =?utf-8?B?dVBZMmVmVVhNNWRQdGkxeFVYbmlUc3BnUHNBcXlqUklKcXk4ZEZncURnWHFI?=
 =?utf-8?B?a3JJNGtSOCswK0xOTEdDL1J5WHZyckd6alBCTHBwbFpqbmJ4aHpBbjlBUlhL?=
 =?utf-8?B?ZHZnakZRRG9YdHYwNm4wNG1odHZsZThYT2RpaDlJd3lSN0l2UkxVdktKeFdP?=
 =?utf-8?B?QW9zNFdSRWdKN2IvbjIzdGVSVU55Njg0S3dTVnZSNjA4OFNYa0s1WmF4amFU?=
 =?utf-8?B?alpYWlhQRjlSTll1RjlWT1NxTTBLYms3T29QWEdpWVF2dThwSWJxRUFOcUg1?=
 =?utf-8?B?V093NWVKVjV3QzFYb3VJRGhaVjZyOE9CTXMzelZGeEtZRmlXcFR4MkVDQmhS?=
 =?utf-8?B?dUFkMEZXUUY2aHlIcG5QSmIvZUJ3aUR3T2NaT0xhM1dRa21NVEJoY2dXZ01j?=
 =?utf-8?B?ZWZ4bzQ3dWRFQlM5dU5Gb3V0d0h2cWEwTWMxTmw0Ylc0dm9NZnMyVUk0ZTBr?=
 =?utf-8?B?N1RhcURuWWtVNDhtVTVkS080MldLR1NPL0ZlbHhiODFLUEVHK0ZNUldscEVq?=
 =?utf-8?B?L1prZG0xMm04U1pOSXZXMS9uVHZsTEtwNFBOTGx1OHNHOXcyLzVxVlJjdTN6?=
 =?utf-8?B?U2V0ZU4rWWgvOVYwSlhRcHBUTVNLbm42Y3hKUzVvbUppVTc4WnV6VzgvUDUz?=
 =?utf-8?B?RVhsaUtTZk1YMUU0dVZHaTBaVkYyUDZ5d1I0d3E1WXU4c3lYMlNJL3BjZ29q?=
 =?utf-8?B?SUN6T2NVcU9wa0x0OHBlK0hWSUlyblJZVXZqbTZEeUdWWGRWYnVNd2l4NDJW?=
 =?utf-8?B?ZkNGS2RSMm5WbW9WOGhnRncyRkZyb2RWME1IVVU0c0pWZnd4ZkFHYjVLWExB?=
 =?utf-8?B?STVERzk5Z0ozRHFPMFJiMGxEU3g2ZFIyZU41UlRkMVg2S2pRNHl0KzdCSmdm?=
 =?utf-8?B?ekxCVmtId1B2aFI1d1lDalp4RkpvZWhBRk1YR1dYMUtEVnQvZkZQM2U3ejJ5?=
 =?utf-8?B?ZmZJa0liMzdranlOZmdodFU1alNzRklQcjZiRGxvT0VnZll6YWw5bXMyYlov?=
 =?utf-8?B?Zjhmb0lUazBPK084VExUNWtNOUUxN1ZRY0VGMjBrdXNOK3R4OERDK0hIeTQ5?=
 =?utf-8?B?VkRmU0l3VVFiV2Znb2xZWC91ZXpHUnRNS1d5c2wxNThrbTd4bUFTWlM0azMv?=
 =?utf-8?B?RWZtL3VBOFlQVUNCVTZWeDZHTjFycG5UNklXVThBSURralV6ajlMOFJNVzNF?=
 =?utf-8?B?RWtGZDZsWmpJbm8xMDdqeFBGdHlzb0hkY253U0RrNDhqM1UwT3VsVE80aWcx?=
 =?utf-8?B?S1hqejdFa1BleG5VWUYrRjQ5Rk1VeTJRUmJNUVZUaVVMQjRXTUlCYTZFS1lM?=
 =?utf-8?B?dXVyZkNGOEM2K2Zidkg2SERvQnpwa29nTTdiek03ZWhGT25IRXd1Qks2Y1VB?=
 =?utf-8?B?dkN3OVdCRTdpYVNETEI2RnlhcHZCa1A3cWJQNVBGRWhkMHNOYjMrOXMzVlc5?=
 =?utf-8?B?N3lMU3ZGR0NjdHhibC8xZmNCWFBWT1BxSTFzUnkzV0g3RC9vT3V4UjUwcmdT?=
 =?utf-8?B?UDN0TmQ0K1ROcTFhdXFaeW5zbWlGYXM2by9IL1lkUHR5ejMwMkJ4dzVhZW9j?=
 =?utf-8?B?OE9CUkJyMktlK3Ewd1M4TmFxT1ErM0hKell4aFlma21LUnVTQlFsVkZqNytk?=
 =?utf-8?B?WnZHUmRaWk5IZDlxUEp4ZFpWcXJuQ0FQKzNxeC9NQ3hFZ0lNaDIvUmFjME1h?=
 =?utf-8?B?VHYxNWZ6eGE1OVd1cHJ5TkYyOUdLUnpHMGtUSyt5RzRZNHZoVVo5RWxmZkpW?=
 =?utf-8?B?N01ndk91OWhMdHh6dWIzZHp3Rnhha0JIZDNZTG43WDI1bE5JbGIxdDl4RDhG?=
 =?utf-8?B?aUN1cVB6VGZqVzAvUENrNmdzN09Gay9MTlVGODlVMHBYZmhRTEhUdm9jZDBl?=
 =?utf-8?B?WXZkd2h6OWJrRThXb0RwRldhQlg0Y0s1UEJqMzVjMXdRTm9YcGtYbE9QRjhU?=
 =?utf-8?B?M2lwSEZxQjRPTGsvYjZnL2oxRUJWT3F2TnJacVFJb3YxNEFzdlBrU0FWcWsr?=
 =?utf-8?Q?jg9DbrK65jojFyQzuU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f592a95-5ba8-4390-b439-08dee1a68b43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:50:55.3798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1gfbXxxe2QxRkotQtmnKJWqmjpszVxcKFS0fVxH03HFhcwnpCgHK4UcjOhhCeko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999078
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

On 7/14/26 10:10, Srinivasan Shanmugam wrote:
> Pending WAIT_EVENT records for queue-scoped events store queue pointers
> and own queue references while queued.
> 
> Remove all WAIT_EVENT records associated with a user queue before USERQ
> drops its queue reference during queue teardown. This mirrors the
> EVENTFD queue cleanup path and prevents pending records from keeping
> stale queue state after the queue is removed from USERQ ownership.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 65b20d7a4b18..aa17e55d52e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -56,6 +56,24 @@ amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
>  	return &fpriv->eventfd_mgr;
>  }
>  
> +/*
> + * Get the per-file wait-event manager associated with this userq manager.
> + */
> +struct amdgpu_wait_event_mgr *
> +amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +	struct amdgpu_fpriv *fpriv;
> +
> +	if (WARN_ON(!userq_mgr || !userq_mgr->file))
> +		return NULL;
> +
> +	fpriv = userq_mgr->file->driver_priv;
> +	if (WARN_ON(!fpriv))
> +		return NULL;
> +
> +	return &fpriv->wait_event_mgr;
> +}
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>  	int i;
> @@ -1035,6 +1053,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  			return -ENOENT;
>  
>  		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
> +		amdgpu_wait_event_remove_queue(&fpriv->wait_event_mgr, queue);
>  
>  		amdgpu_userq_put(queue);
>  		break;
> @@ -1421,6 +1440,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  
>  		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
>  					    queue);
> +		amdgpu_wait_event_remove_queue(amdgpu_userq_wait_event_mgr(userq_mgr),
> +					       queue);
>  
>  		amdgpu_userq_put(queue);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 526e007e300e..5d6d68d26c90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -204,4 +204,6 @@ int amdgpu_userq_input_cwsr_params_validate(
>  	struct amdgpu_cwsr_params *cwsr_params);
>  struct amdgpu_eventfd_mgr *
>  amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
> +struct amdgpu_wait_event_mgr *
> +amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr);
>  #endif

