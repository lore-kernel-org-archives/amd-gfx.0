Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C61AC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 19:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A57A510E615;
	Mon, 10 Feb 2025 19:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ObmYXI58";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8F410E615
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 19:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/zDToa5Qxfl2KuSr7sb2BCKhZvT1xp00nue3YkEgNwTwUS11uCifJzbh0J5G2OwFkldlPHwswYNcmhDnW3FuDFtbAJ0gTVDF6yIMeK4SndRdKTeI5kUusETuWXzkPqAwfRL6pRMBQDfvD35Fvxgmh0tvF7Kbee2T9BXvuBNK6lk17Ci/WNrUJzILf0IfAWfQU2wk6fS+eV528+ZkW5xSEYFMRYOVfbb97SlHMopD1Ckguqpdry8S2ffSMRfsUlhlJVg8re0yRnYqa1JDGkEl5/IzZBwLV2cFMcf/GdEiZNy5nn+Q+BBhwMDdCC7SD2N4jIbDKubJIOjl5cRgq/w8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UzlnAk93VU0tpW88g0bLPa8WAGh/rPoz6OC1quYVWo=;
 b=yGBHCrZPs5YbXYMV+IydchZ1Y4TzPKIJt3HI4EZvz6/O4I3BZDKgP7HsljPQtOOA4dJTem2btqMFq635T3f0pO7n87gCUw566dmmh0uygluxZL1HUTCSmf2vCZlXAAAklAkncwIdVIDkuKgM7v/qzYXcJNKvYWQD6qfulQuuRFd7aQDDsc6y5SEVOWMinzSvjgHaJMsZD3WwngYZNt3I5LccCeCxLFZhzCUQsEdR64VhQWa8d24lPagFEsWVGZLiSBye1s1GRt0ijM4Hoq9JJfeu5tYETekAc7ggoGNRghIMZzTyKbjuQnWhVtqCpewzlcioZq97ZAyq38QGJhJ7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UzlnAk93VU0tpW88g0bLPa8WAGh/rPoz6OC1quYVWo=;
 b=ObmYXI58eiivGTHfcj3Gsr5YBm7qGXuHt1bwHh/3K99JZnlWUymueWagELJEKbdu0mRJTzC13A3SFcBbPMln+EpGu4X/brvKOmquopnHq7f5hWxktVLqLy3epQIFo6p8D7mvRN1wfpRyAUZaALaUS+gERKj2DM8xSVRBQCjAk08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 19:41:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 19:41:26 +0000
Message-ID: <09f3506d-c85f-4cee-9013-3a3a1a05085a@amd.com>
Date: Mon, 10 Feb 2025 20:41:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/mes11: fix set_hw_resources_1 calculation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20250210162755.2488728-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250210162755.2488728-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: e571abe2-9448-4d8d-c166-08dd4a0ae843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU9kNER0M0Y0U3MwckhoQmJybFk2dTg5VWQvL09kNURqTHBteEd3VEl3Z09t?=
 =?utf-8?B?LzNMZ3RKVnVKWFo5RXVoWDdva1ptN2FDZTI3RjAyNkszdVQvTXpZWHJMekZF?=
 =?utf-8?B?SHpVZUJkR2dQNmo0bHIyQlpXMndndkMrSEJsdUZncENSUHdER1ZyOGlORWRm?=
 =?utf-8?B?ZFNoTFpsUEhwQk9LdFk1Ym1vWk85VGphVkhTZTVFS3c1SWY2MVpaNEk2S3hi?=
 =?utf-8?B?c1BLV0ZyNDZiTUY0THhBZzVlekhZMEdRT2xKQ3cvM0RWcGxhaFJRQU9kVnJ0?=
 =?utf-8?B?ZWl4YzM2SUdvZkJOS2loV3hGS25JZGhVbTlac3RIN01aSjRGY0prd1lYZndQ?=
 =?utf-8?B?ODhUMnNJdlBPbS9Uc0FCMVBaYUpKY3JwTFZlRk1LZzJLVXo5ZXlrWHpFM3cz?=
 =?utf-8?B?bDZ5OVVRTTNKTmt6aCs5eGlLU0Ixb2FQWHBZT05FS21mWTZnS0R2c3Fic3VM?=
 =?utf-8?B?WVJ4NXdrMWQwQ3FkOXVrTS9hWXg1T2ZETitSSWlZSnBLbk5TczNNYVo0bWUw?=
 =?utf-8?B?K2hDM0ZsVmhXamxtejkyMXdmRDdvbUI5RzY3ZEd5ekE1UFhkelk3RjFtVUMr?=
 =?utf-8?B?RUxsbXZuYXhCaXErNjhaZjMvSHJoRnU4Q1p6QzJFVHNlV2RBaFd4QmNFLzNp?=
 =?utf-8?B?OFRSN0FQdExmSE9ZR1RXNHY1am1nQzl3TnJ2dUxGeFhvQTRuT3VveWRNSXpa?=
 =?utf-8?B?K056d3FTNi94eVRnOVRtZnJUN0FZZlFFNzlmalBkUmdyNnppVk1QQlUrejRC?=
 =?utf-8?B?bldneVBZdU55OFJnbElMNXNpM09CNzVpbzBxWVI4QmNGc0NRWFluQVZZRW5R?=
 =?utf-8?B?eG9CU1JMOThSNitzTVdpbjM2MEVCRVRpMzRlRXNxbFNVL3Z1aGg3UW1Xd3A0?=
 =?utf-8?B?bDdQWTUrWlhDSlJ4Y1l5RXJUSlFibVEyNG1ObjVFRmMwdTA4Yms1VlhSWjZQ?=
 =?utf-8?B?YjVsTm1lemwwam5mR0JZOXB4WFEwUzhlWUhuaVgzKzJ0Zm0zb2YyWTZUKzVy?=
 =?utf-8?B?VktIeGZzVG1MNThjN1ljdjVkK2s3dWdDMkRlc2twRTdCVll2VkgwNEZQRGpu?=
 =?utf-8?B?TC83ZDVLY0kzSXBsZ0ZkNllOVElsc3A0Wjc4M0VmSEFualhsTlZzbHNTTmJF?=
 =?utf-8?B?VldIZG82ei8reWRrNk5nYTNETGpqTTVSUS9Jay96SXpoWHVaS0dGVFo3eDZT?=
 =?utf-8?B?bEFPWlNFeGF5aXlRNVU2cUh2UlB0UjN0YlE1WTNnVGd6TkE5azlqRmFHRmVU?=
 =?utf-8?B?UjJINjY4cUY3cUk3YkVGVUxETjk0bzhpZld2aGtRT3dZdXFIbmF1MFhtZ2JN?=
 =?utf-8?B?TEcrcmdqRHhOMElUOGpsQnZvUkRKeHRpWDRFZkh1VVNaYXFZeUZYc09CTGxs?=
 =?utf-8?B?S0dPbXMxSFJsUWdkdk9vcmtZcW0zSVBDdDk3L2JpM1JTbmZXek9tL0QzS1Y4?=
 =?utf-8?B?VFZJcEJPR0NSekVuSno4UnV1bmpQQ3ErSjdXN1ZsUDdKbjFBdHFUcFVpSUV2?=
 =?utf-8?B?YnNPM1JsVHN6d3pQeTFodXM1emlpWG9wampBblpocEcvbEdHZzZoV0IzK1lr?=
 =?utf-8?B?Z1ZiNnJnQ0dEbTltYm5WV0JDOWQxbnE4NEdSTkdPY3RvMldBWTJ1d3ZVVjk2?=
 =?utf-8?B?TVp5NEtPSTZ5TU9Sc3B5NllDbGRrMi80UVRJbHdFVnpONUtUN3VZVmtzUUZI?=
 =?utf-8?B?ZmxPakRtam1ldXU2NTlwV0VaT1lNOFY4cXdQM05nNHRIMU9QR1FaNkV0MGxL?=
 =?utf-8?B?MUFRWFFGcHNKa0tWMVZZekMwbUp6dXdlNWo1TE9JenN0cHo4NlcvdE9nK2Fx?=
 =?utf-8?B?Sk9rZnluTUJkSmU0ekVTUzd2R2xBd2hiTTlBUEpONk1lZ3JDNitRMTAzVTVa?=
 =?utf-8?Q?2/L+ioBGTFXCG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZReTlzdG4vOVBQZnNLWHRyVmxBcFhZVnVRSTRDUVA0NklCeGVuUEp4Q1FR?=
 =?utf-8?B?T0JXSlFvTGJpUmVyK1hrb2Y3WGZ5RTFDdGlsQWlvMG5wNnNQb1ovcHlqV2Zh?=
 =?utf-8?B?UEtBL1BzZEFpa0NNbjlhemtYRy9UNWxRejU4UVdwc2dNLzlnVUR5VTlpNjkv?=
 =?utf-8?B?L1lrUjU2Tmd6c3BFcHFpaTMzTmw4OUwwVjU3dHhmdUpvc1NycWVDMDV0blJn?=
 =?utf-8?B?M1BUSjBvVklTWUxhRHFNZ1l1eGJXZ2VnYnorUi9tV0ZZalpER01Yelg2cmhN?=
 =?utf-8?B?S1EyeC9ZUVd4WTVNa0lGMTRNczdZVWNLQ3RTdlI5V0YzcHZ0V2VSSGdkdENt?=
 =?utf-8?B?amV2eWliVnEwQTZVeHErc2VRcWhWc05MamJOUVhFL0xOd0s2ZUVxSUVsaTdO?=
 =?utf-8?B?ZVRjaDVUNG5pN1ZGWnN2NmhTUjdNeHVRT0FRMGRmV0xGbUw3dXVVRUJCRjNK?=
 =?utf-8?B?SXBSa3pKcC8rcWtXdDROZWhuczI1WXFqNFNLcWZldnNtbkdiTW4wWWd0YlNP?=
 =?utf-8?B?WlVqN3krNHF1ZTVObklJaUljYktxZmRXN2dzQ3hWNHpJR0hsZExQZWZuMCtB?=
 =?utf-8?B?MU01V09mcFhKRjdPQk12cmM4OEhaZ29LTjRvRlZiOEpubHhNNHlPQkwwSXJH?=
 =?utf-8?B?MzBXbHE1dTQ4aG85a244U2lUNlhGdlBRb1V1UHdiZ2YyejZldE02bS9KdWtx?=
 =?utf-8?B?MkFjZjVwQXhWenFtZGlDYThhQzhBdWdDUVVkSUtydkxJK3NUSUExYmZEYWxz?=
 =?utf-8?B?eHVMa0NpQS9IQ2piVVJCYm11K2Y1QWdiNDl2cGJ3SDZiWklJcmFnYVdRVUhn?=
 =?utf-8?B?bWs0endNNGJZSnM5Z2dvaDk3eUtrdStCa0xiQWRTVnM1ZTBSRlRtZ0xzSURP?=
 =?utf-8?B?UjNuQkxuQ1FsOUNOSm5zQ1ZuN2tkeUtJL2hYc3BOdkVPK01YWXZab1dPNy9n?=
 =?utf-8?B?cVYyNjJ1elYrUXloN2NZb0krYS9PRHBvTEtkRFg1SW1kb2hXaXcvSzZkMmJR?=
 =?utf-8?B?Z1dmYjgrNUxsT0ZvczFGbkhNWWtIRkUxYTA4MGhoVGJnVUthV3JYeVpYVW00?=
 =?utf-8?B?MzZrNHN3OWgrNlVLY2R1d2ZPRVBjcEY4akZ5V0RKOUkwWFE2RStBSFFJT3hh?=
 =?utf-8?B?bncrMVNxMVpFWnJBc01HdlJFZStoM3FIbWtoNWZsVDlWWHNVZ0QrR2JDQmY0?=
 =?utf-8?B?NkpzelRyMlhiclBwTVNTK0JkUUwzdHlsRnFwbmlnR0NZZVJ1UE5NRW52L2Rn?=
 =?utf-8?B?OWxWenFVLzZLSzV3d1IxQzdSbEJOWHpDaUhDZFN4am9hYXdxcktlUzI0SzlL?=
 =?utf-8?B?ZUxPTmJQdWNaUDdiYThDcmNBMndRVE5FTC9Ec1ZEK2xsTUZ3WVBGVys5cUJx?=
 =?utf-8?B?OHEwWXJQaUZsTUZJNGY3NmNqejVJaW1WT2I2UjlrTjNzQ1psbWxtUjhzdWxH?=
 =?utf-8?B?QzQxNzBwdGxhQlpsdG5XaHBDUG1ITVk4clpaU2tUUXBScnJaVy8xN0hFN1dW?=
 =?utf-8?B?b01vcWE1Mk1RNDFiczdsYzBCYWxaQkJNT0dReEg1eW9XeFgzTzM4TXpaWG5i?=
 =?utf-8?B?YWRwaTlLTXpjcnNpWVZKdW8yNW4rRHVnVUI3VnluUmwxYnFxREd5aFhYRnJu?=
 =?utf-8?B?YUVOd2pid2J5SE5FUjVIZ1FnZlFmaDd0ejVIYnVtN25rNC9ORHhNeDVweW1z?=
 =?utf-8?B?OEx6RmY0ZlloVFRaUWF6Vm9QV3RFVkMyMmxkTTBuUDFOQ21HVytKaVVLYUZz?=
 =?utf-8?B?akw1dDhGZlcwYXNHYTNESjRpeFBwbjROQitwVTMwUVNmU3lQbVJjb3J4b3pV?=
 =?utf-8?B?YzNyVmdrWTBCbnVFbGVHcFZSZlovRzlxd01sN3JNVnRwNDIxTE1kckppd2x0?=
 =?utf-8?B?elRCaFJCOE1ZT25ZSkpCOGNBcDFvN3hYVFp2VW1sSlJscktoT1g4a3N1TWVw?=
 =?utf-8?B?WnV5SXBSaTBNSlNKVDJjVHdrOFRxN0UvSzhrTFRSdG04M2V0UGE1Qi9lOXVi?=
 =?utf-8?B?bHozMGhmN01mU1V5UUdQMSszdmo1ZFNIY1lJVU9YWFZ3Q3JYdG5wUGJiL05C?=
 =?utf-8?B?ZXcycTcxRnh6ajZnSkxvaThhQktTc1JtZEpYdHRHOFdnd0grTUJqNHhSZWlI?=
 =?utf-8?Q?+4fCj/3qt3OkM8spNHDJWixMS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e571abe2-9448-4d8d-c166-08dd4a0ae843
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 19:41:26.6025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37uKFdxsyI9NRvXShg4/DWSiHzFovhrSPcGgcqe7vsaFdXvLfZMXl+0Cz2ukyQmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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

Am 10.02.25 um 17:27 schrieb Alex Deucher:
> It's GPU page size not CPU page size.  In most cases they
> are the same, but not always.  This can lead to overallocation
> on systems with larger pages.
>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index bf51f3dcc130e..e862a3febe2b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -743,7 +743,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   
>   static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   {
> -	int size = 128 * PAGE_SIZE;
> +	int size = 128 * AMDGPU_GPU_PAGE_SIZE;
>   	int ret = 0;
>   	struct amdgpu_device *adev = mes->adev;
>   	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;

