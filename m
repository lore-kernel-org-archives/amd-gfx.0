Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7455EEA3F2A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 09:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043E010E159;
	Tue, 10 Feb 2026 09:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WMiLb+FZ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010013.outbound.protection.outlook.com
 [52.101.193.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F80D10E159
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 09:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmXfQcBtvBuYIqpgVbp5vsYYkz016Jm1zfMocUePIwgsLnZFjVnkcshAQ3rWyEFg7H8/mQI0qGRZXKLwPjaoqVLiogF/S8TulS9tQm7p5as1xHYWalqXky/TCyS95npiJw6ODlSJW4LWrY68iOma0ta+JGvKmvIvz21dqwMxI4hBqI3SoTMZR9Qk+muPwbXa+w3tjQTE1iaBox5+don7iHeU91kRbc6x9wbclzvC1efzBNB2lJUQERRMkUIVxm9TsPo87YPXoCuCiZ0zlWmsfqkYp+W4UB9e9Q0WNcKFcgoL5aybNn6+FrfoVO2RghVIsOhL8gJkOv3NRuVplLb9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VLFnqiFz0KFULOhqAZrdRF2EJ3cQBTTtYFPd7g/kU0=;
 b=Ro9jsLfI2Du/7gbfuMBP90G45HoQxjEG+HOKld3M4uhashNU3NWasPxXHXSfPB0qjy7zDaYxy9Jd18PxJxgal9278EZCZV18FDgQ9kY/51G9+hk+1XOq/7CiyXD80JmawbQYifvWJLevqzQs7hpmgQq0QBd4+LdiSMniKnFSdYIq8U/kzVf4a7bwdCE70isNrwyAidEy0kTrSIaXpfoMHmLNnDJmETtFGD9lWEmS95MGaDcCvqxxYOIwqwsY0GaF1IGJnkJDQ+fKWV3bpbG//CdR1XM/O4yoYlC6UaCuvxSRAZVsB/9YSMEyQHQWx0mTBhzxMfoSLHuok2nToNVPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VLFnqiFz0KFULOhqAZrdRF2EJ3cQBTTtYFPd7g/kU0=;
 b=WMiLb+FZOrSTHwpE5FIhgo5mO3qbkFkUrnt7Pc0kD+lV1ScMDvnvLjiOR+FBGuY0fJtLH4F6XwEIwQEFp7MS21avzbI/0TUKXhEZVArMgurefHDkk094xg5vw0oDy6AVCkEbk/O6s9PSSYPet4HPz8Ac7T9XbDLPzPtrZ2zbc5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 09:08:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 09:08:32 +0000
Message-ID: <238a843d-4b0a-407e-8c5b-1ed4e5b2934e@amd.com>
Date: Tue, 10 Feb 2026 10:08:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Drop dead error handling after
 dma_fence_wait(old, false)
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260210051108.1514514-1-srinivasan.shanmugam@amd.com>
 <20260210051108.1514514-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260210051108.1514514-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 2229a04a-1cfe-4edd-803e-08de6883f656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkxzK0JSZnhHQ3FiVkN3SUdzN1FWUDYrV3hkNWoreXduNTZuQWJCUVJMWjAv?=
 =?utf-8?B?akNkY2ZYcDVhREJlWkRWZm40Vi9TYjV1TW9kSnVtT0VGa2lZQjgyVE5OUnB1?=
 =?utf-8?B?czZWSFNOb2dzb2UzeGhZdktybEw2dDRCRjVSODdEejV1d3kxbWpKMS9IRlc3?=
 =?utf-8?B?V0J1bGpXQnc3cmhoL3dnSVh6MGs3ZWcvMXQ1NjVzenVxbFkzTFoyaWFzdG1v?=
 =?utf-8?B?KzJZKzB2YXFocFl2T2NzZVVSdUJuaXhrRThRdzFnU2lmYUtlVk01a25DdGk3?=
 =?utf-8?B?cjV0cENrRFJTWkpLMlVzT1RzSHdOK3RvNjBHMld1dFZLUFVVU2lLaU5iNE0z?=
 =?utf-8?B?Z3lPSU9SM2t5Y0d3WTIzNmU1MjUvSXFLcmxaLzFFRWdKNVhuOXBaWHVBL1hi?=
 =?utf-8?B?dmtlckN3Zm9QYmM1cm1qNWtUMGFvcWhkK1JMMm1pSWdleEVpSFk0RGpIMGdk?=
 =?utf-8?B?YU5BT1A5MDE5Ly9LZDdYZW8wSlNKZm53UHpya2kxRjVPOXhXVEJwd0oxbjhx?=
 =?utf-8?B?a20wWFFveEU5WXN0SThwK2xlY3BHRk1VSjBXY1VVbnZhZmk4ZWs2cGVrUzdW?=
 =?utf-8?B?LzZ2c2RMYysvNzN6M00xR0xMOHBRNkNvbENlTi9rb1hacXh4UkZLZmlBUkp3?=
 =?utf-8?B?bjR1YmEySGdQZGJ5TEdLb2d3Zkk2R0xHci9SdlNrSXNLSm9Wam83NEwyUHFY?=
 =?utf-8?B?YUNWcFhKeDJhdDNIbWhIcTJmczZ6dnljZ2xHNWpkN0xSbjAzOHc0SWpIMkJP?=
 =?utf-8?B?N0NiVVNLUGF0bFlHbFVXQnNzbXFRaTJabzhmOFNtWktyZStqT1FnL2UvTnVJ?=
 =?utf-8?B?amtQVGZYVCtqekFRWWdnWkpXTWpVRVRTQmxTQ1kzUGdMUGpNcGloS0JtbDZ0?=
 =?utf-8?B?TDQ0bFhJM3pMVVZRT1prZ3BqNzIwZGs3MitjZkhmRGtVems1WkZ0MnB0UE1v?=
 =?utf-8?B?c2pMT1ErblgzcE9oayswZ3NBaExSK3JJUUlrNVl2dkJRaWNGNkZZc3hrWXFV?=
 =?utf-8?B?OTcyVTlJcnV5Vk5aNkVmU0kxaGlCZ1pDejVoeW5uTkJyTEhISHBHVGRrTTUz?=
 =?utf-8?B?ajlzeUIwNXQ4Q1hnQWJjMUhEQjhRbm9lS2Y4Ykh1ekoxS0J5M2poY3J0VGZT?=
 =?utf-8?B?Q2JWWGw0Qnhib3pjV3R3REl5eGtLckI1Yjh1bWR4VVJNVzFZMVFseXhGdGVC?=
 =?utf-8?B?VURxS0I5ZmJXV05nTW5UZi81SHdyb3dLSjAvY1F6RmVpdlBWYjdNeGdtUEtQ?=
 =?utf-8?B?cDlmbkhHZjdhc3poTTY0OGNSSFRQWkZoU2NPSWp6cEpMQ05hRThiMW1uY1lD?=
 =?utf-8?B?MVRNUlFReGhXS2lKRjJxZEV3dURvQ1UyK0lWSGc5ODYzM0xBMHc4N21CK1Ar?=
 =?utf-8?B?ZmtFeUprOThudnR2VEtkaDFEREZkbE4zN1N0dnZodDhXV2Z2UndpUytjZVdu?=
 =?utf-8?B?WWJNRGdHN3phL0toenV2SG5qV0I4UGFmNW1rU0xoMHk4cWkweDhQY3RYNjY3?=
 =?utf-8?B?NnliQ1YrT0o1azRlODFKekRBTTdCUFdUMjRobUFqMnJ4cXhmTEZKT1hyVWFi?=
 =?utf-8?B?dzBXcitUSnd0VjNZb2krU3c4K3ZQbXdWMlQ4d0VkM3dYNGZBK1l3S3Q1NzQw?=
 =?utf-8?B?a0x6YVhCaTZ2YWhxL3pQZEVCaXJNSWhuT2tId0thbG1KZnFtdnFzSU1pTVFt?=
 =?utf-8?B?N29xSjF2LzRkczFYUTcxMGhrSlRReE94N1pXbGFybUtGaThvVi94MWVxdWdX?=
 =?utf-8?B?c0c3TFZvZEp4Sk5yQU5JcG1VdzlONlNMNGFySGlZdnBseG5CYmt4eER1bEhy?=
 =?utf-8?B?ZFg1SndMdFUrbjJtL2dmZTJMQ09QdzRWVmU0aFRON3VNOU5BZTlBOE1VRndP?=
 =?utf-8?B?VHJlY3loOUJ1QjFPdFhsZDZLYytsWWZMZlBmcGsvaE1YTFhYU0NWeGtscERT?=
 =?utf-8?B?aFdodHgra1hWclMzcVN0Zk9mTi9vNGdBUGVNSFNacmlOWDE4UFR3Vm1pMld4?=
 =?utf-8?B?czJ1bnRnTXBiTmo0cjk4WW1CNmhoNVlSMDRPR2xabEYwMjlnbmhKTDFlSVFV?=
 =?utf-8?B?WlpHL3JoOHJrMGEvN3E4TWFEaFp1Si9sN3d0NVQvc1c5V056UVNzNFV0Z1BS?=
 =?utf-8?Q?L8zU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkxZWGsvR1pXRGw2a1BtcjZpOVluWE8xQ2Y2Y05qSnE0enF1RThaR2dYWEs5?=
 =?utf-8?B?RHBGTzBNdHl3Z1lpU1pBQmJ1NGFiVi9SUzVCNGRCcWNlaWpRUEJnYTBadUJ4?=
 =?utf-8?B?SmNjMTUwM1NKaEFVb2plOWhhR1p1a2V4K05oclJ5RUdTb0xZSFpUZHlPUEJG?=
 =?utf-8?B?ZHdYdHBVems3UVJLWnFCWDk2d1dJbnFpMGxZcS9uQW5hamZvbXdyVGhQUnNE?=
 =?utf-8?B?SE8vVnNhelQ0MUFTRi9CVDZIWWI0SnpsaWgzWW9ZblJXMFh4ejV3SWNrQ1Br?=
 =?utf-8?B?cWxqai9mWXZZUzFiek9BdFlHV1U1cmxJYThNMjE2NG9DU1Y1L3lCWmk3d2NO?=
 =?utf-8?B?elVOYVlGY2NDWG9vNk9kMWsxUGVMVzZwN3RBS05SdzhmcE1LTnZuMzMwcjVu?=
 =?utf-8?B?NGpORExlQmVpRkZydzV4aWVIcndoVTJFaHNMa1M0SlB1Z2JZZVkwTmJhSUFM?=
 =?utf-8?B?V0NvTGdISWt6UUx5bGJMSHltWUNCaXViK2pvd1dnN2c5WlNDMG5YYm1KT25s?=
 =?utf-8?B?L21xdnAvVUdmY1RiWldodndsV1Q3dEVmUHc0UGRTdndFRUU5N3hFYTVtUG9S?=
 =?utf-8?B?Mis3czBiRDJpcE54NTJMbmRuL2hWUG1QdExxbHgxU2FsMDFlRG5FN3M4OEx1?=
 =?utf-8?B?aFhGSTRJZ2NWV2NMNE5vQmVpd3JzUWdvUDhmdlRFREMrbE5NaWttYnp1NVZu?=
 =?utf-8?B?SUpFVnZkeDQ1aWNaL0pkdStoZC9JejloOFk3SW53L3NKYUhMclpydkc5THNP?=
 =?utf-8?B?NW1Dc0NhZmZJY003NjkxTmhSQ1lBQlBoeTRnR3hiMEpNeFhDNklUejQ1SzR1?=
 =?utf-8?B?MFhMQk9lVFBQajMvQXhkczVRNDlBOHZXRnZvN3lCajdhZUtCV1BmcGJvSXd5?=
 =?utf-8?B?a3loSGs1Ny81Yys1dy9ERDdpbnlEb0d0NTluejJQcGErdVJQZFU5d1VPYWgz?=
 =?utf-8?B?S09SWHJTdU8rMzZ1aFhUdTQwUXB6dWx1NXYxQ3ZyVTRiV2VDLzdpS2lSTWt2?=
 =?utf-8?B?ZFJ1VE5zaXQvRVV5SS9yR0l1VXYrZWZ2cWY3NEplN3FEVG5XSzVoRjgxNk5k?=
 =?utf-8?B?QWFDcnVER1ZvNG1WYlI3dG1YZmpndm9CMEVmWjR4ZytGTTRISzJOL2Y5T2pL?=
 =?utf-8?B?c3VJUHY4dVVtZE5MSHAzK2tucFM0aHRGMVJWenBianFKaGJxZGJXUjF6NUsy?=
 =?utf-8?B?NGxGOURUTjFVaFFLVTZSSVJQZkFBSmwvbGNqSVBkVkZEdGo5Y2JGdlpPWld3?=
 =?utf-8?B?SHFmVlRDZVhmUGVBbWRBUEtHYmRmZTNWaDUxZkxDUjl4ZW0vdDdVT3VwckVY?=
 =?utf-8?B?RDZhR1U0SEszQVB1THFrbUJsdGppZ0NFdHlWRDZFekx2KzVTWk1PUCtCT1Rk?=
 =?utf-8?B?NFZzRSt5Vlk4MXlEZDRXWXFnWXdiV0xZL0ROSnhUWWZRSC95UFhwMTVMOVF0?=
 =?utf-8?B?K3I3eGFWVG1IRVdlZzhhbmc1TS85ZzNLdXR3Sjh6UEdrWGlwVEFZOUxEYldk?=
 =?utf-8?B?OTNjMVBERk15RnhpU0doaUdGaTR2Myt2OTZ6eVJSWk16UzlwRFhDMTNqYWpn?=
 =?utf-8?B?V25HeXBFRVdHUVo5VzNTOHhYdTZqditmN0NhNjUraGNNODdwQmxrNEFsV2R2?=
 =?utf-8?B?UVNJaFlCaGVrYy9yMW9BR1lLNWxHQTZQcDIrN2JZT1dQbEpWZ2VBak1oUDdq?=
 =?utf-8?B?RXNYejRYSDlnVjVEN1lSVVkrWFZCZ3QwMVB1M0MrZkRiYWZzbU9VeGp0OHFR?=
 =?utf-8?B?Z1NHNk5kZ2xubTNSd2tSN1ZCOGNOdHBZZG1rdW9FYlZQMnBCdGozQ0Z6WmYz?=
 =?utf-8?B?cU9raUxrbmV5TzI4QVFPUmJtZ29YRGhKQjhXQ0tsTGw3eEVPVHFzWkJXZ2hG?=
 =?utf-8?B?ZHdabVNwTTRkb1k1MWF4dWdoZnFxc25tVG43SWkvWURVdXdOOTIzbUFUTGZ0?=
 =?utf-8?B?V09CWFNtQjZjdnFOb2hZMEExMGIrSEltWG53b01oTWU1Nm9rVEIyN0lDVnBB?=
 =?utf-8?B?ekUrV1ZaUDZ5NUcrYW9mbWZPUWlSU2p5eC93QTFLdFMzaXdCNEJWMkRuWnJ1?=
 =?utf-8?B?MW5rMFpTK0xXTmZwMGk3NTNsQWJuY0plZmxBVmlzaDR0b01lTTAxdHBseklv?=
 =?utf-8?B?MXlKQnc1dlF0djU2eWFnakJHSnp2WmNpKzEvODdFSTNlaFlXMVFIL0FJRklB?=
 =?utf-8?B?cWJZTExwMnBRSWhPZlV1OXg3TnJiTURvMlAyYlIzQVZQWTVJbUtzVzNCMWRm?=
 =?utf-8?B?K2VlakNNSXk5b21pbFUzVFhiSlVabHdJOStTSmJ3UmxUdnhvNFNMazIrVyty?=
 =?utf-8?Q?dQj5yneQsYnpC8AC7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2229a04a-1cfe-4edd-803e-08de6883f656
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:08:32.1234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6YrrCh6jPyBX8dGEWdni8BuoZAhIXYWYcIpCxNVJQwqWHJD1vKs5necGToOYvHV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
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

On 2/10/26 06:11, Srinivasan Shanmugam wrote:
> dma_fence_wait(old, false) cannot return an error because it is not
> interruptible. Drop the unreachable error handling in amdgpu_fence_emit().
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 1054d66c54fa..01f347f59405 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -141,10 +141,8 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>  		rcu_read_unlock();
>  
>  		if (old) {
> -			r = dma_fence_wait(old, false);
> +			dma_fence_wait(old, false);
>  			dma_fence_put(old);
> -			if (r)
> -				return r;

Please also drop the return code from amdgpu_fence_emit() and cleanup all callers since the function now can't fail any more.

Apart from that looks good to me.

Thanks,
Christian.

>  		}
>  	}
>  

