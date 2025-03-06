Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37F9C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 10:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A4F10E157;
	Thu,  6 Mar 2025 10:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mKyqFcln";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207D310E157
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 10:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn3N/mhRJ38f4nqreXkTyeB5qE5ec9Pv4CjRPANQ8Kfk5aH1Lya8SI1VlDMBXJoOAsk14HfCvBX3k2JzmS05ZwFo1zH7i/kIWTKKA9mfFpF8NkNJrekI+ZacPAASkPF00UaDZNyOCbB/F+LxmLJ6utw+Dzv1gk47KtMGkR01usyV2M1r4vjY14SbQSyoCzM5Ts6muj3aX7Qv20SfQ+MogM07VZ7XOdlW6xOvk0tu0WXqJeLlFrTqKY8BciN207b3qnrjgfeN1KqtkEUF/a+/DaiVfM4EdXn6/484hwa4Fm5sxV85Xj6Te2xbwCegMJZS2/GQVJoO3joDFk6lVJD7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbCodOSBl9mN3TQw/Y+2j8WAuj/crfzsp4xygViJjSI=;
 b=xy0Az5unXQSK0b7PAU1zvqyLNjnXfKrTE+M6OetDAJVgAojnpLu3+Id+4WOAwjX2o8U2cH3Fp4BlunniNelp9ULyKQSf7iXLsJASqNUPXHIzQiM8qHTGHl775nu4KxkPiGYz58EjENSE9RKlI3dsKsjgGcEc/RupY5Sk+WTbnK011Tnu8zmLqUZpm2XyWTYoKDxVnSswIj0BLKMXFP7VZb0+bCjgdN2QplvVv8CBtAZy215uUi9ppnJaqc/KhfJe+Xe+pV3EehuUm8qgKBDwmiDSQyo+6XC6a1R+QimaBgFyCDsJHXdmMBRFtBCsDzzHck7SQox0/+gJKZejLilqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbCodOSBl9mN3TQw/Y+2j8WAuj/crfzsp4xygViJjSI=;
 b=mKyqFclnMzrdImtax9PYxCImtIHRC6Su2r/BIrSlhJ8TSHhSaXyQV+97AT2kwoaXB+6yfTj0B1x+cCx7eIIQqhL20EGd5x3wJAI4djEJ3lLPizzN9TCUoE/NXguUe8gefXfSz4PPPjjZGC7I9QPvNWrqg/yyRdp8/KCv+B1lUHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 10:21:40 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 10:21:40 +0000
Message-ID: <8a0f2256-0c3e-49d0-88c7-3692931ca809@amd.com>
Date: Thu, 6 Mar 2025 15:51:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-7-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 57381345-1717-47fe-d709-08dd5c98af41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEhJc29NTmJERFB6NjVGcENDbmVHWGsvZzhZaEwrYkRUUVM0UkFzZW1maUsx?=
 =?utf-8?B?MElRdVJyaUhTY2w4ZmxOY1pDZ3RtckFNZ1FTd2lDZ0I3ekpVNFJ1RGJBZjRk?=
 =?utf-8?B?eldiK3lmbGRXSDB5YlV3UGxaNFdiQUQxMG12Z0Y5cXRYOG5QWDNrak95WmNN?=
 =?utf-8?B?KzI2NVVhUTVjZ0JQWGpkak03QmxrTVF4Z3NFOVV2TzVzalQ3UFIvc1pUZXlw?=
 =?utf-8?B?elo4TjBkTlF4SmZsQmIva1BsaUdzejJIZlRWbjVqYndISXdXaVo5Z01MRnFw?=
 =?utf-8?B?NzNhbXNQZ2dMUmROMS9mbFNsNDkvOTJLelpoaFN4Q0lpdTBaRko2V3RlNnla?=
 =?utf-8?B?RUNaMklIN01sajhERURmVzE2M0hRWVNEUm8xMTQxbTBwcHpVbWlUS3F3QW9F?=
 =?utf-8?B?MFl2Z3JVSzVTMGtvQUZhREl0SjBsQTB4MTVYVVZJTDlYdjBWYktib2V1ck1D?=
 =?utf-8?B?UkN5NTRCai94TC9jSG1NUHZKMWxEK1QzRDRXUHg1OEI0cXRjT2ZtNU1xY2k4?=
 =?utf-8?B?OXlDZi9HNllIOGhFcS9tMUJ2Q2ZYQktzQ054cWJqK3JxdmlOSzdzUGhOTkdk?=
 =?utf-8?B?YTJGUDRHRjlYNVlDVngzVU9mMURwQ2Z6S1VrVE11QUg5OGx2SHJSSG5uQnRO?=
 =?utf-8?B?bThsand3OW05djJ3ekc3emJ1Rk9waDZOZUtaUDB6a2xaUzg3clZDWUl0Q0dj?=
 =?utf-8?B?NVl4SURheWJKcHU2K0dFbzZQWFN3MzJMNUlzaHlOTHhlajdDUzMxdDg2NjYw?=
 =?utf-8?B?Nzkyd0FqbzZCNlpTZnZIZVBta2srNXMzQTlzZEs4SVhpOGNlUmlkV1VTRndZ?=
 =?utf-8?B?dXB2WS9ZaHEvV0lvUXpVekFaZFM5aWZ2cUpoYmxCSkR0ZjZPMFR4ZGY5S3dI?=
 =?utf-8?B?aWhRbmsxcHgyclZHc3RQeFFNeG9zbU9hdm5wekIxV2lLcmFaakh1Rk51c1Y0?=
 =?utf-8?B?Wk83cno1SlVvU21FbkxLRzNrbGllUGY2V0tybGhrRDgvZ1lVbWlKSnVTQXUz?=
 =?utf-8?B?MU1pbmZTdFkxanVsRDZzTi9FY1o0M0U4bXZoNjZSYU96TkM5NHh1cVRLVWt3?=
 =?utf-8?B?U0RWdXFOLzRDTWh1dEtFN1JDVXN2TkZDaW84S0dGZVRFT0UyZG1FUXY0MjBj?=
 =?utf-8?B?eENyTitFSXdZbC85TlFsbno4NWNhUC8zRlYvRzFoSkw2ZTlib0xhSVRGcDk4?=
 =?utf-8?B?ZlM0bWdqVzUvUUx0cWZkMEJ0VTJuVGtFTDBKc2VGSS83VEFZMkQrbi9RK1VN?=
 =?utf-8?B?UzgzR29qRWlrZUoycFdpZytuUjQxWm9xOStxT3V0NU9Jem1Hbm4wYWRwM0c0?=
 =?utf-8?B?eWVaTGd3SjltWThabDVhWCt5dUkwMk9TQUNTaktsVHg0aS9pVk9PVGcycW5w?=
 =?utf-8?B?bFZXcVZ6KzlkdktpRjE1S3VDOGpGTnp5Q2ZqMXpIY29RR0hiVDZQQnBZcjZY?=
 =?utf-8?B?YzIrTXVCcUw3MmNRWHl4WUNyaXozT3VtRDBPSWxwT2U0bFJQSUV1K2NzTGxY?=
 =?utf-8?B?NndBSzBteHFXQXVmUFczamRnZXlMZlB5V2x3eVIwWEZNWFAvVEpnS3l3eTFx?=
 =?utf-8?B?N2tJSG9oelBqdjE2Vml2RVRvN3lGSGlWSm9ZaWNwREJ5cG5YWmN0MGtyVmRn?=
 =?utf-8?B?Y2tERzhSTUFFVFE5V1pSWEdnQnpXZGVEQ2psUWFQQnJlQTJGZlFHeWtyT1Jq?=
 =?utf-8?B?WnhTQzl4QWZLOCtheG9Ya1pGb0szdFd0SzVrb3ZsdStHWlh0cUxVRUdWbHpB?=
 =?utf-8?B?dDBnNHk2aU10QnkxNkNIQUdUUm5jcWcrbERYejRGM3pVM2lPRmtJSnVrbUVi?=
 =?utf-8?B?WVR2aE1XMHNJajJkN2dxeVZUR3FkM05WVkE1b016c0MvNVMwalA5RWp6UW83?=
 =?utf-8?Q?6H17k23toQlvk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Z1ZnF2UURWejZsRjBNanpNaHFxWWhDRE03dW0yU1pyVFNPUVZSV29WOExC?=
 =?utf-8?B?RWhrQXhTK0pnSXRKUmpUUW0xKzB2Y09kMlBDcXdDdStTSHlzQ2NyNWFkeHR0?=
 =?utf-8?B?RWQ4bWFOTjBkN3hFTVdZSXdJS1ZDSDBYY0d5RGlaRzcrdklkYnJVb0Q5eUN2?=
 =?utf-8?B?N0diMmJjMDRJVmZyTEd1dlljakViaU5pcTIzckVTWW54Z01SRENqL2t2T2NJ?=
 =?utf-8?B?ZHd5L05UeXYxWE5YVDZ6cHVNb1MweWVINUFnM1B3dnhIS2RmSnB0SUdqTkVn?=
 =?utf-8?B?Q1FLTy9ZczN1SXZQbGYxOWlMNnV1czF2VFNuWDFxV0d4S0xLMUsxWkRlZ3or?=
 =?utf-8?B?L3k2RVRSaSttTXZ4bytNTUFrU0JXRCt5cmdwbEUyTWw3NTloaVJ3WEJLUkYr?=
 =?utf-8?B?TStMNWtLbVIxaU5pNGsyZXRMOFpWSUMvR2JwVGpLS09rY0xLemlJZVIrOCtW?=
 =?utf-8?B?MUU1TFlVcWRBMGoyNWRuQzRkYkhkNnJ3RDJSR0lYVC9uWkR3V1FzTmZjdWxa?=
 =?utf-8?B?MEFuSFhQWm02RUMwdkgreG10cjRiTkhnaS9zWXJYQmNKNkJud0Zuc0VnVGNW?=
 =?utf-8?B?SU1vWUdsYWlJMW1lRThIUUtGdWV5MlVvK0lDcldJY3pWSm10bHBtYnc2T29B?=
 =?utf-8?B?U2V2VW9UbE5PaXhBVG1jZWo3aDR3UkZRcCt1aWhNMWFjYlM5ZEhGVnQrTkYw?=
 =?utf-8?B?R1hEYWZlbG9RWG0xd0FlQ2dFYnFuamgzYi84OG5WVGJDZ0h0ejBabjF6Ri9I?=
 =?utf-8?B?QnV6endsZWJPWmM3anJOazJIT2pWOEl6N0NndmlIektuZ0x3UVhsTkJwRVVX?=
 =?utf-8?B?N0lZckRTajZUVDFkVkZ3c0U3ZlFwWlUwS3NRYmM3TERFelB6U3ZONnkySlJT?=
 =?utf-8?B?LzBkV3F2aFhSa0ljNjR4Uys1TVhrTFdwd0ZLUHhMSG9HMXZRN08wRENRbVB3?=
 =?utf-8?B?aG5pUlo5MUVoa1J2UmZFcXJqQzZxNWlvdHpaVE8wdzhrN3lNZ0s4bGIvQzdm?=
 =?utf-8?B?dGpwdXJ5R3lSUktLMkRrejFraUE5dWZNbFF6bnhodytFM2xJZmZlaHgvcDBZ?=
 =?utf-8?B?STN6U1VSSW9VTTVERDBDYWhpdTZJS1kxb2R2c25VV2RlYVVUU1d4Y3NtMUE1?=
 =?utf-8?B?K2Vsa0Q0dHc5dUVaTXMxQjNpdUVqRllWS1NTV0lXZG1qN0FqOU1hZ1FNcWxu?=
 =?utf-8?B?ZWJiUXNkWGF4dC81d1ZuQ0cyWTB4aUNKb0NiS0FsU3JUcFd0R3QxRVlnbUdo?=
 =?utf-8?B?ZkQyQnJSdVc3TDQ4RDhFYXo4ZzJPOGMvL0greGhXaEJpb1ZPRUNaNXZ3bWRi?=
 =?utf-8?B?S05yaUwrdEx2SzE2SzJKank0djIyZFMvcVArWFNuQk9aZDlWWGpxbUs2SWh2?=
 =?utf-8?B?ZFd5Q2JBeUREb3JUYUo2UmhMY0R3WUVPT29yU0k3dkZBdi83dXgyd0I4bS8z?=
 =?utf-8?B?OElYeHVVSG1QUmg5YVpHVlVQVDQzVVBTSlJmTGI0eHltaWpJLzhHVkZhR0hk?=
 =?utf-8?B?eE83em03WG1HK29kZGR4Uk4xd0VVWHNEdDdreXFYajJHWW5jelJia09TSk9Y?=
 =?utf-8?B?RFBhOG5sRnlmNklIUmZNR2xuUndWQVlHYU1LVnNsR3ByS2ljdXR4YlFtUzNO?=
 =?utf-8?B?SDEwdGNURHRpUVZUcHcyODQyUHBCN25TS3BjNWZPcW5FS1I3bmlyZThKQW85?=
 =?utf-8?B?T1FjSmFTVkh4NVpoVXVLTnZodDIxOFlWYzFGYzVsV2RRRUtrTVhZWVl2SmNx?=
 =?utf-8?B?UVZKcWVuaEhQM1Bpc2ZlL1h5eVhVOUxXdllqS1paQ1AxS0VSV3ljbFhUbUdM?=
 =?utf-8?B?TWNZeDhINHpmRzh5dUZ4L3pGWlZFa01PT2l4dWFDOVVGSzVuMHQ2cDZ1TlpP?=
 =?utf-8?B?U0RuQStqZVRtblBCNU9qQll0WEtRVXQvRmNEbnAzaXFhaHBLR0RNNFA3VUNs?=
 =?utf-8?B?aDc5d25mVGR3cTJjWUpVem42dTR5cEdxYm5yVzBXUzBSc0hkVVFFWWJMZkJL?=
 =?utf-8?B?aXlvNENxT2FJQ0N4c2pCQk1UV2dtVkNna3U2MWk0cU5WcXFaOWhwNU52aERE?=
 =?utf-8?B?TjhpbDRDd01oVjI2QjlCU0p1cmhCUEJuYkVRV1lOdGRUTzgzcUJRVWErVFhn?=
 =?utf-8?Q?GdORVQydTefk/8Gxsn3FwdtZi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57381345-1717-47fe-d709-08dd5c98af41
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:21:40.4342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nNBX8u/wxriiN1X1dSUN4TsXfdY4xPaB05beG4OfFTFl2LKyrWhUTH7J68pCQdXCcn7hTb5ilXZ4x0ykDVl0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/6/2025 2:17 AM, Alex Deucher wrote:
> If we don't have kernel queues, the vmids can be used by
> the MES for user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 71dce64a0ea32..e2007759f5b4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -142,7 +142,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   
>   	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
>   	adev->mes.vmid_mask_mmhub = 0xffffff00;
> -	adev->mes.vmid_mask_gfxhub = 0xffffff00;
> +	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xfffffffe : 0xffffff00;
>   
>   	if (adev->gfx.num_gfx_rings) {
>   		for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 95d894a231fcf..19a5f196829f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -900,7 +900,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * amdgpu graphics/compute will use VMIDs 1-7
>   	 * amdkfd will use VMIDs 8-15
>   	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> +	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
>   
>   	amdgpu_vm_manager_init(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index ea7c32d8380ba..598324e736092 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -837,7 +837,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	 * amdgpu graphics/compute will use VMIDs 1-7
>   	 * amdkfd will use VMIDs 8-15
>   	 */
> -	adev->vm_manager.first_kfd_vmid = 8;
> +	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
>   
>   	amdgpu_vm_manager_init(adev);
>   
