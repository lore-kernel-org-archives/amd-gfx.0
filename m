Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2067FCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 07:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A6C10E1A7;
	Tue,  2 Sep 2025 07:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qcCedjet";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B8010E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 07:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ysxj5fFT9iRSaxtbF7wrVQ0sJ5xQTZjGrIzlXabP+j9Lcw/8vBg5E17+z7Y1mFt206he0ESGclVWoHYToUXqBEpUwkutDZoDpAVcXq07I13HKemQdQavLFE0YAhMmop7Q6jynp41EsyP5g7edEnm3t51xnI7y4M/51YCtAJzueBN31aQ1FtNqvc7LZUqefVCXokZv2AvFHBzfxorcbvf9cHyAi3lTruE+rtDYLiSERSQt1VeN6I/z43Yx5SRkYywX/5z8K5t+o4JfSAHkbDr1J8uYP133LQXyAhuXq7PUJX4g8LQCKAlP1g4YS3NwzwTFzr4xE+rDS1/XGCQGnS8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agm8MxiS/eEdgx2uO64+ByINxOWMT3NirKF9ZT7eW2c=;
 b=BPC4n2CW++Iwnw1mcncwm+hXGMe/bBB2pTpRzlTplLJEUG3zFZPRflQTisU4G/3rn/6tWwsseGzIYamKDOoh44skHU6nL90Y0FQAE8Amcsqd1ViAQtJtr+yXleqsSr2mP0aioDMKfa+f6opcULOZR5Maimwd+RHW662EBwIBiqEZRfib9TDnOQK6/d1f2u6hduC4pHHNAafNFlLABYYDdRHD9Z2R4sf/LevKpqSatBbN7rotN+sqYUYh1aK4x6X0ySZx5Z5toghUJsMBdnu6lYPzWdLzZ/nrzWt/867nAgHg/qvrQykbX/pzGjRfcwOESWbPeAqaeOAdNK/YoNKGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agm8MxiS/eEdgx2uO64+ByINxOWMT3NirKF9ZT7eW2c=;
 b=qcCedjetSK2GGT5KIYsHL8cXOtL6M3La2vWPEn9+CjEF9TCxpS18vh6FCtAWoGJyLmiOxgGBpUZyesR6J/0eOGDq4Qp+mV7FcT44EaShm/NAVtTCiXtyreTCoT4RN+ftqsrwngdidz+UtCrjYV6HvJZnbCSHPylCgwg27JRYYtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:28:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 07:28:40 +0000
Message-ID: <8e98cd9b-92f5-4fa0-b33f-d641331d56f9@amd.com>
Date: Tue, 2 Sep 2025 09:27:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP
 Singleton in GEM_CREATE
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
 <20250902032938.468332-9-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250902032938.468332-9-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c3ccc6-0b1b-4d43-9e68-08dde9f24fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUlqQ3JLdjU0MlZubEhHL01FcWpFZTdYWWp5ZXhmK0Y2MFNJZFF5cFJrZ3Jz?=
 =?utf-8?B?UVVYcHFBUEZUVHFxNXFvL0NFaUI5dVBrVWtxdnRzNE5CcGpDTks5Z2NpT3o0?=
 =?utf-8?B?NWNtaTFTajdYQU9ualJLYnRxc0w5UGp1Zk9vSUlQTU5Hai9YL1JSRzQzcFUw?=
 =?utf-8?B?dlduVDlvL2FUYzZmanA1MkxYSnh6YXVDZHlRNVZ5dkcyQjdZSStuYkhqdTQ5?=
 =?utf-8?B?em9UaU9VWk8zZmVHNEhBVTdYS0R1bmtXbnM5RC90TmxKbEx2VE9mcFNxK2o2?=
 =?utf-8?B?bWVseFV5VndZS0xxQjI5Qnc5L2hJdnVwSmlEZkl6Uzl4aXNVSzFORzA2UkZB?=
 =?utf-8?B?MElHQytYL2N5LzI3RU9adDVqcWNibUVwZS9oNjNCUlZhK1UybVEzUmdiekth?=
 =?utf-8?B?NGZrV1RzVFZPbmFPZzJ3cWoxNEZvbHFZSEpMc29LdmpBZGNQbHJOZUd4U3Zh?=
 =?utf-8?B?R0pXc0dGbHRRQzBid3dLTy9jUFpRT0hBWk13eFd4bW1DS2Vza2VHS0xpL2R1?=
 =?utf-8?B?UHlyb2tuZjNzTE1qWkhyVElhQ2NuN0xqOGFIU1FENG9TQ1JqQTFoaHFROVZL?=
 =?utf-8?B?bmt1L0U4dk45d2JYdUZIMnNNM3NqbjZDQURiZThLTG85aUlLTXlBcmJwZDRU?=
 =?utf-8?B?aVp4UzY4K3dnV3JaWEYvMm5vTE0wbUQrQmtFalhTUHRDRzRVY0Noc2dGdllZ?=
 =?utf-8?B?YVFIMklBQ1AwbTZ2WVcrd01XWER3cTBBWVlSTUlnV1liR1JmcUFDSTlmeXpF?=
 =?utf-8?B?SUltUjBWYTRJNFgrSk1ydFB1YUxJeDlkcUsycTg1Q0MzSW5HV0V0dDg3Y3ZR?=
 =?utf-8?B?QlBiZkNqNGJPZDlLY3VURHY4VlZsVXpyZ3V2S200QUp4S2V6Y2FlYjdnc0Vv?=
 =?utf-8?B?VHBlckErNHg5ZWFKNGhGbllMSkJvVDIxTVBBNlJBMDNIMHkzd3R1ZEF6NElQ?=
 =?utf-8?B?SVVJWExKNTJlc0FuU1duak9VVm04UCtYaWJnQ3ZORkk1U2d3QTJjOTNOWDZ4?=
 =?utf-8?B?MlZqUjVIMGxsRG9rWkViM1RsdG41Rmx2SDZVQi9pRDZHZHBXSTY0Ryt3Z0lO?=
 =?utf-8?B?ZXVmSnBnTjlPWm1lemo5cDJVWjZ0VW1LMzhhUmFYNXJxTTRWR0hNMXRmcjJW?=
 =?utf-8?B?RWpuZm1MUm92eUVNYU1aT2tHb1M1YjVHZU9rK3BMeHk2QUFKS25oWi9jRGkw?=
 =?utf-8?B?QXJZRjNWV2lEek8vOTB3Ym8yc2ZQWGIyK0ppajF0TDhxcERONmRmVVRNeHY0?=
 =?utf-8?B?aU4yODd3TmIyVGl3andncjdROTRCd0puOTB5K2NseEcwc2NVaDFPbmJ2eTVw?=
 =?utf-8?B?S0E5SkdjdFlWTlE1ekhRNGVjTkJHOFhBbHZ4ZGFiNzNEOXl0LzYvVkYyQ3hw?=
 =?utf-8?B?WEd3dzdacCtsTGxLek12Y1ZkZ2dpMmRRSXNvVFFLcmUrbDRIS2F6TDBSNDJ4?=
 =?utf-8?B?cHZ6QWpsaXdQa0dXLzNWcmtUTXZkTWlaWTlCQ1JzRjB4a0dpbkFOR3BvTUNP?=
 =?utf-8?B?TGIrQUZDU01uQ0VGWjZCV0pJd3hZalJIL05oaTM1Z2RkL21lZDV2ZDRiNzVI?=
 =?utf-8?B?TWE3Q0NoOU1SZW81Rmp3cTVsVEQrZEwzZVFlMSs5NnFCVU5pMUQyQlZrV053?=
 =?utf-8?B?NnAxeDdEaTJ5ZUNhQi94UTlPZjRRT2ZCdU9NRWtrQnhyMkwrQ1owb3A1V1Nr?=
 =?utf-8?B?NEVHOVlqK2tnV1czdjkyVzFjQkp1bjNzMUpxRVNnZ25aRm04RXcxOU10S0xN?=
 =?utf-8?B?WlFMQWVMbXlZb3VNNUoyVFdjWWFwRmhKRm4zUllRaVM4STZmalAycXBBeWE5?=
 =?utf-8?B?WVhQam5IajNlelpjcmdGSzV2NzArNGdpOWZRSWRtTHdSNFlUem1HdTNZTFpk?=
 =?utf-8?B?ZUM2WmpiaWR6SVI0WXhoamNFNDBVUURLNzhnZG5MeU1YV2t4YUdFR1BTVDd3?=
 =?utf-8?Q?y8+Dt5p5370=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdpVjhCYXdIck5LT0NZMUtUaTZ0Vk91NU9FMnNVL0JHQTU0SmpiakhxQlRm?=
 =?utf-8?B?SVdQVHcrWGtxMzdsYmdRU094Vm5PdEtXNkhVVmtCZHp5RUpwL2tVTm9MYThy?=
 =?utf-8?B?OFhBbTJYeUhGa0VlcmtHdkZONW9MWjAvZGkvc3BmTDB1UmNYY0pLczJOVm9n?=
 =?utf-8?B?bzJxT3NUaWE5ZmQ2UW1zaFFXVHBjNkNQeDRBcElwV09Bc1FvOFZxRzNrajMy?=
 =?utf-8?B?b3BNWnRXQ2JkbjdKRE5TYXRLRDc2bVpWRWNFZk5zRndsUlBnYVJYRkdYb0o0?=
 =?utf-8?B?MU5RdUNrd1duQ0M1Qnl3TUVydGNEWFU3Z2dhV1RQTUM5dktEWlc4bTM2Q1lt?=
 =?utf-8?B?Q3ZjTThBVmtPWDM3MFBKRzFUcmtpVkFQamxUaGx4OVQ5WFdFQXNZTGgxUWVj?=
 =?utf-8?B?R3YvZ3dSMjhaVjBZQWdjODA1T3pCL0JHL1hLV1NnYVpVZEtWdzlWSGxPMVlS?=
 =?utf-8?B?OVVaU09EQmExd3FsYk9NT0RCTFl4M2lkL25ZelJBNDhPbWpHbkw5alFTeDlP?=
 =?utf-8?B?OFdZeVNUUTZ6QVhRQ0VrRW1MUkxYQllYd1BZOUxwaXZRQy9Oc1VuSjcxWnBs?=
 =?utf-8?B?ekgwZmgzbEc4bHgxQjlJOWFsQlp4WTNiaUlsTGpyRk1XdFZEd1ZUTmdNNXJK?=
 =?utf-8?B?OXhOUnM3UnBuTTY2RTJXeWdPUFB5S0RtUU1kY0ZGSEtaMWhicnBqMnhzYklq?=
 =?utf-8?B?bmI0OHArSm1lZElMdjZScjY2ZTZYZXY2SHpWK0I5WW4xei95blJQU0hCZSto?=
 =?utf-8?B?aTc4NGN6YTZaWXg3bE5pd0FvUDJXQzRYQ1lUK3htUjZLSnFUWWR0dlFWVnhh?=
 =?utf-8?B?TFZWbHIzc1NKRFFQdTdDZmcwRmZ3amNUb0R0NThQQVB3bHUrQTQzeGZiSVdr?=
 =?utf-8?B?OXo2SnJkRHNidFJaVjVpVGl1VXIwT05RamdpRmxDQlRuQ0x1QUROSXNuOG50?=
 =?utf-8?B?Q3kyWlhZWDV0Wmt2ajkwWTBZM3BUbnN6WEwrbkdtazlIWkU3M0ZJSmpxTnlo?=
 =?utf-8?B?TGpSN3FjakFXOFc2TFI4bXlxNFJFSUxoY0xBRlZubHVPUUZHOVZ4QkZ1czIr?=
 =?utf-8?B?cFhnd1BjUWZxMWZaNEtsbUlyY20xa29PeUc1SDI3YmwyMm15dzJyZGk5YTR2?=
 =?utf-8?B?ekMvT0NWOVJvV1BNUWlMd1NZSUpxOG52dFBsdkNuYzFoVFRsLy9ROWR1V3Nj?=
 =?utf-8?B?bUJITHVzRzRCWEh5Qnl4SXJZR1ExVjBPMDVWNjBFNzgvb3VWbXZvRzlzNXR5?=
 =?utf-8?B?UXVmNDQ3SlBkbVZTY3ZrSmY2Q2dicEE4b0FZRit4S2Z0Z08xQmZwNlBuRUxo?=
 =?utf-8?B?eCszallzYno1U1BHZlVZdmJ5bFdRei9PTEI3aEdoS2NMQ3JyQytkM2tycWY0?=
 =?utf-8?B?TCtKOXJoQXd1dlUxMk8rRE4yeGtrL1MwMSt1d084N0JMaWkyMGFFTHhYcFY2?=
 =?utf-8?B?NFBGL0J1RzNGL2pXSk04S3o1SGZjWUkyeTVieFgxQzhJSHpuclpnSnczUHBT?=
 =?utf-8?B?N0syYjBHWTNzQ2N4UWZXdnB2V201ZWhuM2RLRGJUYzNPdXZSbUxuYXUzMFlt?=
 =?utf-8?B?dmtJalFNUlNUTHFyWmpvOFZVOVE2YzlzRnFDTWlQdy9pdm1tbWk3R0tYQnJX?=
 =?utf-8?B?ZUpsbnZrajZyRzlab0trWUdGN2cyK2xPdlJqd1JHZzlUL1VRVDlLaHhNZkpr?=
 =?utf-8?B?RmN5TUpiNklGZjNLU1ZaYjFvcFRVU2FsNG4ySFRiWXJZcjNXWTllb3lkSzdq?=
 =?utf-8?B?dWdGVG0vdWZNZEtxVG5nL3Z0bFAzSWxidzRHU1hpbnBqbUtRSDJQUGFqdlZ3?=
 =?utf-8?B?T1hYSkwxaXhkbFdJOWdtY293S0RWTkRpK2NsUGErNnM1REFxU28yNFdidWUy?=
 =?utf-8?B?U2M4cGQwb2p4MWlVNnNQQUtwV0JVVFUwbi81YXpyclEyNTA3MGdxdHQzcWE3?=
 =?utf-8?B?TzNCMU4rWURodEdhaGRFZlFLYlJENVdvQWZoSkR0cEtJQW5Zdit3SmtQUFJh?=
 =?utf-8?B?TE0xSWdPanNyZHFrbnhFaWROZVJHNWRSV0FhMVFOSncrSmcyb0J6ZkRMbGJS?=
 =?utf-8?B?NDFTb3lsZDVsUnprMndjQVZBVXBTR291NE1RaThxVEpOKzlWTmxVRnRMZ2VS?=
 =?utf-8?Q?N5WuuyaY0JzVybmAnD0NCiUfO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c3ccc6-0b1b-4d43-9e68-08dde9f24fa1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:28:40.4321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJzXrD0+7cFZnU+FEVQKJQLoyjLRoutHy61HjQChI3CVfwlU4th4aUg6m6uDCkLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890
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

On 02.09.25 05:29, Srinivasan Shanmugam wrote:
> Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
> singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
> amdgpu_gem_create_ioctl().
> 
> Validate the fixed 4K constraint: if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE
> return -EINVAL; when provided, size and alignment must equal
> AMDGPU_GPU_PAGE_SIZE.
> 
> If the singleton BO is not available, return -ENODEV.
> 
> v2:
> - Drop READ_ONCE() on adev->mmio_remap.bo (use a plain pointer load).
>   The pointer is set `bo = adev->mmio_remap.bo;` ie., The pointer is
>   written once during init and not changed while IOCTLs run. There’s no
>   concurrent writer in this execution path, so a normal read is safe.
>   (Alex)
> 
> v3:
> - Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
>   MMIO_REMAP fast-path (For MMIO_REMAP, if asked, we don’t allocate a
>   new BO — we just check size/alignment, grab the one pre-made BO,
>   return a handle) handle it and return the singleton handle.
> 
> v4:
>  - Return -EOPNOTSUPP if the singleton isn’t available; drop PAGE_SIZE
>    check from IOCTL; inline the MMIO_REMAP fast-path and keep
>    size/alignment validation there. (Christian)
> 
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 56 ++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index d3c369742124..8781b2e16f54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -424,6 +424,45 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>  	.vm_ops = &amdgpu_gem_vm_ops,
>  };
>  
> +/**
> + * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
> + * @file_priv: DRM file of the caller
> + * @adev: amdgpu device
> + * @req_size: size requested by userspace (0 means “unspecified”)
> + * @req_align: alignment requested by userspace (0 means “unspecified”)
> + * @handle: returned userspace GEM handle (out)
> + *
> + * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
> + * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM init
> + * when the hardware exposes a remap base and PAGE_SIZE <= 4K.
> + *
> + * drm_gem_handle_create() acquires the handle reference, which will be dropped
> + * by GEM_CLOSE in userspace.
> + *
> + * Returns 0 on success,
> + *         -EOPNOTSUPP if the singleton BO is not available on this system,
> + *         or a negative errno from drm_gem_handle_create() / validation.
> + */
> +static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
> +					    struct amdgpu_device *adev,
> +					    u64 req_size, u64 req_align,
> +					    u32 *handle)
> +{
> +	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
> +
> +	if (!bo)
> +		return -EOPNOTSUPP;
> +
> +	/* Enforce fixed 4K constraints when explicitly provided by userspace */
> +	if (req_size && req_size != AMDGPU_GPU_PAGE_SIZE)
> +		return -EINVAL;
> +	if (req_align && req_align != AMDGPU_GPU_PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/* drm_gem_handle_create() gets the ref; GEM_CLOSE will drop it */
> +	return drm_gem_handle_create(file_priv, &bo->tbo.base, handle);
> +}
> +
>  /*
>   * GEM ioctls.
>   */
> @@ -465,8 +504,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	/* always clear VRAM */
>  	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
>  
> -	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
> -		return -EINVAL;
> +	/*
> +	 * === MMIO remap (HDP flush) fast-path ===

Please don't use === in comments.

> +	 * If userspace asks for the MMIO_REMAP domain, don't allocate a new BO.
> +	 * Return a handle to the singleton BO created at ttm init.

That explains what is done but not why. Maybe use something like:

For AMDGPU_GEM_DOMAIN_MMIO_REMAP we only have a single global page and always use the same BO to represent it.

> +	 */
> +	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
> +		r = amdgpu_gem_get_mmio_remap_handle(filp, adev,
> +						     size, args->in.alignment,

Maybe just pass in args instead of size and alignment separately.

We only have size as local variable because we used to have a workaround here. That should probably be removed at some point.

Regards,
Christian.

> +						     &handle);
> +		if (r)
> +			return r;
> +
> +		args->out.handle = handle;
> +		return 0;
> +	}
>  
>  	/* create a gem object to contain this object in */
>  	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |

