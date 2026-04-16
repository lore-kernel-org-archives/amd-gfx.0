Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C494CF8A171
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 12:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56ED410E1C9;
	Thu, 16 Apr 2026 12:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bZczVeKV";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 060A410E1C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 12:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNqGfK67zAcD6t4fqNUM+H87LJNkATg9Ch5a73pclTEZ81F1aV0PpT4g8RCK34VbBEfpmsgMNbPi6EaolyFUphq9fov+FpRC2xM/bhPoa3jGKI7lc0XwKOWFrwyIPK0pyJfPFsMHdJMyDFa4+YUZtEf3gA967qC+7ukmfl16DmpOLpWbM0dXWo4kvayoPEntFiGrZTh/DwwL+Tccrk6GkYgvghyngRL2KtVuO4tVoiohumslYiZ9wiPOnGFtKXOeAfPMHG0iUKAXZNXZgndSlu7bu/Dr2hUmEdw0UeqHpHs/a5eVpG2ZHMRiFLfon2EJBxTKLd4T87BFQVL9erwy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjWJx4N0tZQiP6hfq/XtY5xdyQbRpCtJ10j5N23EltU=;
 b=cknjxRhEp8pFUtlIrOQaHU3wo/O/qnXMmCCK6QBilm4EUcqwQxQm4sfi1ma4VVII9qDEvsMo+SdK54i+8lUCq5jdx8vQn7eohdNBR0hT/qvfVpc18uQtY3BnvPg+Xk+sMNcXD+/iAaDAdEFYOYCuL8DYXcopJGVKnw9XUq0dVvLtN9SHxTK9szQ1sFUL1ymPoFg7WU6RiC/ak7hGXCgfExraa/qzoYOh94SDjMjRNSLCg0l8kZIfIldGIJAlqCyr0gPObkVnpTcSLLyeH8/+UaBuy84vzuHFSu83lbNJoI8PToj2asH8+NmcwdNypTslBb3L5hbULVzTdz5Gabpg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjWJx4N0tZQiP6hfq/XtY5xdyQbRpCtJ10j5N23EltU=;
 b=bZczVeKV8zM3t1NvlMpEMnDapbf5eBM0n1yv+qnu6kQn3gz3XNnu6W96k2kQ3caHfYI8JwwCq1+KXGfoyi2gyBULE1cG3mBqIyJMrKfc3VJopElaVRW00584AYsRfoSlttgNW56y3oxqavpgn0mEGXZypRNbJF8yVZyhEf8wR0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 12:53:01 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 12:53:01 +0000
Message-ID: <2f526765-ce90-4736-834c-53f02dab4d1d@amd.com>
Date: Thu, 16 Apr 2026 18:22:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix runtime PM imbalance issue in amdgpu_pm.c
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260416102808.71041-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260416102808.71041-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 7983f6b9-375b-4147-7ac4-08de9bb71788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: XWz4PXTO6ano6nYn+/K7NgGtPwxScoTLX0dGdQHkswq42JeD/Uizx6f01LrrSp3COD+Pog2Rs4vWDhf/r5xl0dgjx6zW8KRHzg0ecv3Dg5hCGbo7zxzZ/YlZODGgfiXnSAUi9fGO5cUoSENPA6vV4vgpYUuFTZxxujqjFA+cuf3uo/4bIXB+0QwRGFatCgVFIVtr6nA9tavnrHN0lH3grisTr1zJB7wi9l7Z5bUMmHklNzrcn6CBmBLpI+D/nyGDvBA17ERa+1ujF6v38tX0WN/QQYOdrrPFwT2nhSX4dHmAdMluMVwHTBbfnHvQ1Pfdt0ZAxE3Nw2QECKBirolq+3MzOPfPpBDkdBC4M6UiLacgV8Qb8P7kW/XI3i49T8Kxo7lY4FuLf8e0GRT3s01V+rdm9xvcynzMoMW83IseW8axoGo3pAvDJynK6F/+Yt9xPUSp6LcKHVXjw5MbUS1xqBSCSPhbw0ot03IkMDhiRIxOHlp2otV7MzWxAOpYSWHQouT8cBEGTmy6YSCmWMKPUMJyXoeyb0lVS13DnF0xlijDhdep0E5k+iTr7AzbDxvFa+zEWMDjgedkMKFXehBvXCdha7eJVpnCPUVWxJLse/8yLdhNX09v58tXSG1ZPBcL8PXRfU7sPn2NbPHolrJ5kUEgyAPEMvKEVKq5wJ5f14mEt4GQz4RG56z8fXEqsu4klBfHOZICbaW+VbRJgZ4wz/dDk3twR/dXSibhEBL3oes=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdtQy92TkZNS1hhampVZU51L3U2V3NiWGRVSkhpRFRFSlgwSExmSUJvcVRY?=
 =?utf-8?B?aXlDVlhvVXRPdlp3NVo0M0tkOWc2S3p6dUZzZS9oUVBVdkMwRUNCeWRVNFBQ?=
 =?utf-8?B?UXhma1AzeWhCem1wQlFJNmNvbzM0N1FVSi8xbnNxREZEbzFFbTFmc1ZhZXdJ?=
 =?utf-8?B?b0RaVE9ZSmFpdUdvckRLZElvTHNpd3U0cDc5MEhrbFRDVkU0ei9SL1Vld3NF?=
 =?utf-8?B?bkxHNDJXcnBpaHpiK3lTQ2pDRUxnSUF0cGgzb1VtU0tiWmdWdUczc2gvUllP?=
 =?utf-8?B?bEcxTFR3S2h3YVpxL1JiNktKMjdEcnJpNEkzZnNyaXFFTVlUbnlOUzhxWGxq?=
 =?utf-8?B?R1JQTkJ4NElrU3R4eEVPYitBemhNUE9MeGFHK0pKSlM3elNPMUYxODFQY0tE?=
 =?utf-8?B?KzhVWk9GeXhPekF1R2ZQQ2d0Sm1hM0VEdmFSamNVUWl6a1FwNm4yNDNzQXN0?=
 =?utf-8?B?cTJJRmxETDFwS3FBaVZMWDh2ZjhjNmUwYktSZkpxYmxtSExxL2J6L3p2eGs4?=
 =?utf-8?B?ekxseXN0WkdQWHdOblJnZG1XYWdUUnpRREpTZ1ZjYS9uOGhFNlNFNTRSeHI5?=
 =?utf-8?B?SFIxN3FBTUV5eloyMXBNc2Ezamc0VEVsVTVBVmN2VE5vbWN5L2ljaGI5eFVB?=
 =?utf-8?B?bzhYcmluOHZWdElYazhuRHE2T2R2TEd3MWE2OHpFMkdMVXZxMWZ5MVhMR1hp?=
 =?utf-8?B?U0J2RjVESTR5TnZxR25SUm1hV1VEZWk4czNBcGVqWXZPdVpNUElJbndCRERr?=
 =?utf-8?B?TjRycGEvMFBWZUFsRE9icmFiNjc4MmlGbERwZU51ZlhRZlU3VERoNnBETHZI?=
 =?utf-8?B?V0Z2S1RLZDBsYmNUMjdFRFVGbUpKMkZmalI3OU5BemlXbU0yVFlOLy9WcWtq?=
 =?utf-8?B?TldPRU9PY0FvWG1OOG9FNTRIcUR2cXNpdm1pZkhFeVlkdWtqN1Z4STBpMlNO?=
 =?utf-8?B?US9WUHM0UnZoUVQ3blF0czJDTXJnTUhzS25WSWtIMDdJZ1lIeTIxb3pPMW5G?=
 =?utf-8?B?MDA1K1ZUM1BabysvTDJudzdlRjVIR1RNUmQ0VnNoc25EZExRUUFMWlc4TGlL?=
 =?utf-8?B?a1l4ZkJwbEpRcXR1RFMvL1hmTkxMTlhSeTRkc0pKaS94clZ6U1VndHZiQnlZ?=
 =?utf-8?B?dXhIdmJ0NW5VTFRmeHhxT2N3NDFYUStONmFWTVRveEErQjhYeXhEV0NsbS82?=
 =?utf-8?B?c2d5VmZieHllUVBMK1VXK0ZWTm5vajF0ZHlVUXBnWVBCTDdpQjQ2Z2xzcmMx?=
 =?utf-8?B?Q0N6TDB6ZTVJRXJyc2lGZDFITjJJM2YzTE85R3ZDVTFZWmt6Tlp5MUxpdEcv?=
 =?utf-8?B?aXd4SEtnQndaVzlKcjVIM3JjQnNRaitENW9sTW8zcW1RNWRlZEtCbFRGbUp5?=
 =?utf-8?B?MjVodzFZVGE2Z1BNSlgxa3UxRTB6YS9SbG9WbmtFVlgza082dGZscXUvLzc5?=
 =?utf-8?B?UmtxRStkMHg3YnNIU0ZhU1hNU296WXEyYUVkeG9yMlVjWDV0aFlEcDQvTTJo?=
 =?utf-8?B?SVM1blVNSkczclhRRkJtLzJyNXB2MW9paGVTMDM2WkdXQmVrdUlEWC9md2lJ?=
 =?utf-8?B?YTY2aS8rV09oSGV4ZHg0dmpsc05XcmJmQ0Z1bmZGTVJ2YXBBdXdzVExGNFhL?=
 =?utf-8?B?NjU1b1JXdXJ5M3VvSWI5UUJ1eVRwYXQzQkZtTnBJN0lKcjFiRGlONHM5QjFS?=
 =?utf-8?B?OUQ5T2xJbGdJSXNTNFNoako2NmN6ZG1BZjRWT1gxU25JRk93ank2cVkyTnJl?=
 =?utf-8?B?MDhaMkhLSGNWOHZGZk1sYzA1YlFJVmZKeGY1ZXVWZlRjNHByYmZ5WFdkV1dk?=
 =?utf-8?B?N24ramVHV2dMRnVoaHhYcXhOSWRHOXJDdEM2TjdJdnFwS3B5SW1VNUNITzdV?=
 =?utf-8?B?NTVHeDY1MWQrZGxOTGFFR3cwUllsZzZqbTh6WnhGU3hhWWxwR3B0YWxpaDBT?=
 =?utf-8?B?ME03S2xDNkI0ZjRIbUI0eXc5SVJTb0s5M3prWmowVU1FYzZVMVNHYkEwdHVx?=
 =?utf-8?B?ajdlQ0hpVVFlSytxeHRUdmxwMTNvbUhEN0dSL1BZTXhSNE4yWDV5Y3N6Mm96?=
 =?utf-8?B?TlRzQnF5MHVTcG5EakRObTRkVHpzMWFaSUMySjFnemw2L2RpY2NjeGhsYys3?=
 =?utf-8?B?WHA0MnB1aUxQdkc1bHhxa3F2NmFMVkpZdmowa1RoSHZmL3VQaVVlcE1id0VQ?=
 =?utf-8?B?b1lXZU1GQ2VRQXdsWTArbkYwaVFZZWVVRXJvVGx2d09DOVZFYXlZeEp6THR6?=
 =?utf-8?B?ZktHSXVjOFpseVBvY0IzcUt3bXpyeDRHNGZZRi8veDlZVU5oRDFzREh6elQx?=
 =?utf-8?B?RzdtUDBpb3FZTjZmWXJ2MUxoZXJWYnd1YmptNWFldTJ1UHZNMDBndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7983f6b9-375b-4147-7ac4-08de9bb71788
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 12:53:01.3899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxgVwTLFD/JUI33S7Cic5ql+0Y6AA7gaNYcDfiACc7w1+mxqv8k4okopUpjkGwHD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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



On 16-Apr-26 3:58 PM, Yang Wang wrote:
> Fix runtime PM counter imbalance to prevent device from failing to enter low power state
> 
> Fixes: a50d32c41fb2 ("drm/amd/pm: Deprecate print_clock_levels interface")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index afbfb8e7adf5..fd2e63530e8c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -995,12 +995,15 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>   		return ret;
>   
>   	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		size = ret;
> +		goto out_pm_put;
> +	}
>   
>   	if (size == 0)
>   		size = sysfs_emit(buf, "\n");
>   
> +out_pm_put:
>   	amdgpu_pm_put_access(adev);
>   
>   	return size;
> @@ -3902,11 +3905,14 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>   		return ret;
>   
>   	ret = amdgpu_dpm_emit_clock_levels(adev, od_type, buf, &size);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		size = ret;
> +		goto out_pm_put;
> +	}
>   	if (size == 0)
>   		size = sysfs_emit(buf, "\n");
>   
> +out_pm_put:
>   	amdgpu_pm_put_access(adev);
>   
>   	return size;

