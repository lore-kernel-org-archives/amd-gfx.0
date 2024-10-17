Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18606D37487
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B487E10E31B;
	Thu, 17 Oct 2024 12:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JsTD1rWW";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB33F10E31B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn/Un4NrdPIwVCwo4wVlMMh+El/P1IdC0S2wju89FxBNUgbJe3hWpH5d/sfD0PHajHjCDlo6SgXMNCRRXRA1OOiHCXG8/XG5BucR2VI+lP5bLBXBtt0/wGa2HmvwmidlWXPf4ytI8PFL9RinMLrlWdKOc1nfOLZv05i+AynXIbb4s1hepGKXaLcnWFLELn+79ORGsODYO02FPh9bQQs+v7uG0NieF8iMe7NQ2Onoq+aQHjwYwd2j4/TXLulB3M7z1YSirY7MoA9HLARSqJeX8EWLxcipG0qWkXO1s1df2u6BNjgUcVwE3Nxq36OJ9FcJzKqNWjzEnybPOY85l6mv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu04+eBxE2vGsOzmszWfEl7bijiZy+jiWaTnFowGPuE=;
 b=l+uTZaLjz6r77wq8u7YS7IjQXio/5VdRGT93VK9dVS3K2ERbUz+XfZRnNxp8of1wejEwkOdPzTa9EiqAlADNPz1IFSNABv1MJA6EfKQACP7s3SHhPXRymroMwOuL4ViM3+U5Ge77SNjxJTfUz3+g3J8H5m5RhU6BKvr/5gVx0CDgb2bFQtvqHhEF+ea5LoTg/m+Uwa3IPp2uUNB6rI2Cwt1sqwZVlkJDJtpgGcELPi3G2Xal4KDtNRXRbkfZ22VzdAzIg6L5cmluEB2QrqIqR79QyDNXjgJJJu+zIkHk5r5qvFlzWTOMO/l0/I6MIaadwptaFfhoQn0NMqkn7h3CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu04+eBxE2vGsOzmszWfEl7bijiZy+jiWaTnFowGPuE=;
 b=JsTD1rWWJrX+OClmdOATz76QQol0D0W4i+QUcsGhCutCDuZ9dz8DvlHz9rwsp7CUowvbQ70lZInkh7DzhyAvTze9NSNBGKn1DKhlPrL+mfr6VY9MCDNUjlK1C133EMuSkqXYtBgO4qNryGTx2JdCeYg4MXhnEeFvtt4sGnBmDh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 12:45:24 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 12:45:23 +0000
Subject: Re: [PATCH v4 06/15] drm/amdgpu: validate suspend before function call
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-7-sunil.khatri@amd.com>
 <a63b46ad-3c81-425b-a24f-6da7ded8bf45@gmail.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <e9b65730-1978-e909-0ad4-f7371a2502fc@amd.com>
Date: Thu, 17 Oct 2024 18:15:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <a63b46ad-3c81-425b-a24f-6da7ded8bf45@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::22) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 15742a42-598c-4eb8-217c-08dceea99174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkZSdC9uQzY3THZRZDVGU1QzMlNJMHI3Z3p3aVo5K3Jjd2YvbnRNVnlBS3gr?=
 =?utf-8?B?ZVoybjB4RW5YWjJsWTA5Wno2bUhyTjE3cFVlKzFtOXFhQUtGa0tlcldqQzg1?=
 =?utf-8?B?RUN2S1Z5cTVhRGFXemNhSXRmWkdnbDE2UCt5Y0JnUVpsSGM1VUJQNlhSY3hH?=
 =?utf-8?B?cytxWjRuMDhDZ2RoKzFVV0J1VWl2akt1cGdaUXcrVG4xUWZPUEJ6Sm5yb09W?=
 =?utf-8?B?Rmt4T3Bsc0lJanR6TzdOR0czU3l2YTlMajR5bllIcXhIQndidCt3VjA0c3Av?=
 =?utf-8?B?Y1poc3cySDJsU0lSWTR1bVhUbU5HbmExZHQ4Z2lSYUhXbkwzNGZLVFY0enBD?=
 =?utf-8?B?Tis0aWZWb045SWFvRUxjK1pBMXFFT0VCdHFsaXZ4YUFwQVgvbFNMUU1mL2FV?=
 =?utf-8?B?YmMyRXdBQTZPUkRETjVzZEtzTTBocXRLOXFOZXNTZkFoWnZVcGFWbE9vOE95?=
 =?utf-8?B?OE5CaDM1b3kvaFd2QXV0dDVWbkpucEJaOEdPN3JwZXgrOU9vMW85YWVFbEYy?=
 =?utf-8?B?eWg5eFRDTTl1dlR1MDhuaTVKdWxUZThWcW5KTlJaRjMzanJ3RzBIOW53Z3l3?=
 =?utf-8?B?NTdFV0VjaTlESjNPYjl5SWRZUEVqdnlaMHRRQ2xvamI4Tm81WkpWTTVlRCti?=
 =?utf-8?B?ZXlGZjVpc2g1L3hVZk03TFZqNUdYTjBtdnF4S29haWJaTWdZYTZROFJjZndP?=
 =?utf-8?B?ZWNhVWZhNWI4dXpnWjFTME5MbnZuL1FqWkc0WjkyMTlhWmJJZW96YmZkNVBX?=
 =?utf-8?B?czJ5VHhXSWRkaVVDOUd4Ykd3ZWpvZzZlYWJhWUtVREhvbWJ0SUFzVU5Tc21x?=
 =?utf-8?B?RENZR3JIbGFpdUZyQmwxMTZ0OEpZbHhQVWtUZTFWdFBJMjhBRTIvWW9IZVo4?=
 =?utf-8?B?K0FGWks1VDlMaHZ4VGpmZVNoakdnYnZNQ3k2UTZTU0ltS3pCRWhVazN3ZkRh?=
 =?utf-8?B?b1B5bmNJUWVmc3d0dVZxQ0J2YlhNd2NCK3d6ekRwelQxam43TFRucUw3RUEr?=
 =?utf-8?B?dGRkMURIUTVyMm1TbHhDWWVsNS83MGZlT0M5bHk3Wi9LZEJjWEEzYXVHLzNL?=
 =?utf-8?B?d2lXSW5jZktzb0dNdXRqV0hTd2UxNFZuM3Nlc0RzS2d1ZUdDc01kVVN0cW5G?=
 =?utf-8?B?clNYdldSSFU2UklLTWNWdHFVOWduSFg1M1drak44SzlpWlE0T0dLOWNpS29k?=
 =?utf-8?B?UUQxSDB2SFF3Mmp6eko5ZktBeWVFNnZ3YnIrYXF0OTVGYWtrTnhmYlZIdGNw?=
 =?utf-8?B?UXd0d1dBWFNQc1NEcWc3OXpjUWlsYXpLdk5KS2pITG5HQkZXV2p3N2xEMGN5?=
 =?utf-8?B?dXZJNXR5QkYrOGFGRkxRZlJwa0JJWGRVR0pVK1VmMDdtaXRrVVMxVU5DK1Np?=
 =?utf-8?B?NlJSZmowS1hCaHpNT3k5ZkxUNmVDQ3dHTmowTCtFeHU5ZHRubDQ3YmdTM3ph?=
 =?utf-8?B?blIwVGVNckM2TkRQTGt1a3ZXQ0RKQ3ZtcVpMTW9Pd2xGZDhPbU40eFdveUxM?=
 =?utf-8?B?RDQ3QkFpTmhnNXEzVXIxSGlhcXk4NWtYQmlUMEgwWDVvNFRqTlRkU2g3WCtR?=
 =?utf-8?B?RTRBZzRoSU02VWdyQjRTUjhXcXhXay9hdlBtTGFmU1FqWi9HK1VDZEFGKzNJ?=
 =?utf-8?B?SU1SdUtzdVpiQThTVE9xNTYyR1g3czBPcXhzWG1GYjdVY2UwVW5JdFJVNjdM?=
 =?utf-8?B?ZmZGT21XVDl1T0k1VlZrNHZ3blE0VWozQ2F2SDA2QllMQnc3bUpSY3RBUkdG?=
 =?utf-8?Q?/DJofFahMjrArO1FNMUixoPuTkZe5qohAWmtnEY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFh5QTZGalBHNlFxd0F2VDdXdFBKUVBydzZZdGtGQWZ6K2FTMG52eExua2VS?=
 =?utf-8?B?d0drWnB6WFR5T0ZlZXpId1hBU2I4cU14cEZDWXo1K0EzU2tjZHNWVWRvNkpS?=
 =?utf-8?B?U0VHWm9hTmpWdEJGRTB4bFdYTm1IVWQ0RHpCa05oLzVUT0lNNzdQU2kxTllj?=
 =?utf-8?B?cndNYktqT0pSVFBrOVhucEhZeGplZFR5b25VL3pldHorbzNEdjRBSUROWmdj?=
 =?utf-8?B?MTl4M0NqNittSlQxOVFVWHVoY1ptYlg4bXRBSVppbGgvRmx3RGZ4azEzdjFl?=
 =?utf-8?B?ZW5oRFhUUFBpLzBsaTN5OWdwZ0tMdGd2NFMybU1NbEU3dEhwMFBrQytyTE1n?=
 =?utf-8?B?QUdsOC84UjcxeHpWR1AyS1J0VmtNc1VyNW8yMytWaS9XRmp1QzNLOFRhdnNs?=
 =?utf-8?B?cFo3Q0tTTEYrQkxqSVVsVktXbll5SmhXTEV3TEdRSjgxaHNTSHlEMkIvOEpM?=
 =?utf-8?B?QlZPRnF3WGs0bjlJYkVNRUZSRzRJY3JvTUlCMTVVd2hVVitoY1BxMTI0eVJy?=
 =?utf-8?B?Zm5QVHYyT1pvVFQyWSsvTjhOM1lvYVd5eEIxbVlBK3B6VFBBSXlCeEdCNDQ4?=
 =?utf-8?B?N0F2TkY2LzFLRDd0Smk1K2tMcm5RVFQ5ZXlESW9vQzg2bSsraFZ0RDFEMkVR?=
 =?utf-8?B?b1FaMTI3VCtQYk8zNVl2Q0pYaGxSNituS1pwNjczRytvemNSY3Nud3RoVmQv?=
 =?utf-8?B?R3dmb0l4c0FIQWNWclBRUGpJUkk1QStkRmFPK1BWSDBJdEtNcUdvZW1TNXVT?=
 =?utf-8?B?NXpXMlNJeWJXRk5qVTU0QVJxL2ZCclljcUk1T3NpV3lqRWtub0R4RGVJQlRu?=
 =?utf-8?B?c0xrNkR4cEhTa3Y1NXpuWGRXVno4MGRIT015LzFOUmx2R1BHaDBzMDArL0ZX?=
 =?utf-8?B?SCs2L2wwNCtZWlVMdDBuR0FVUElFU3ZpTENYRENZU3JpM0UwRi82VUd3bFBV?=
 =?utf-8?B?VDVNSlNhLy9YdkJFMDBKdm9kNnh6RFlqc3B1dVlxdi9MZVhoVzd2MHZZR3Nz?=
 =?utf-8?B?U0dML21BZXpNSkdTbjd6NW8zTmRiZkEyeUF5QnZMOXhYN1dMby83Y21RaVJw?=
 =?utf-8?B?VThrL1R5bmN4NjQ2ck9IRkhBdVgwMjZ2UWYxZ1Q0UU80V0xlbXV0SjdRY0lh?=
 =?utf-8?B?WG1TT2ZPMGNkY1R3a3hFSVVXVElhcXZHVEhzc01WQ0o5SmkyNUJJL0ZPc3ow?=
 =?utf-8?B?djB6ak16NUJVamRQUXMwSDdDWms1WGhLNUJNVXNSY2JQb2dmZktKZzVQUHFB?=
 =?utf-8?B?eGRKek1oejVueTZRTVJ4Yll2eG5tZG1nYlZlbnBqRHlDS1luSHVQMWZwOFZF?=
 =?utf-8?B?dDVYOE9Ha2xyS3VJY2poK21kaDllUVp4d0RxZjJNYVMyZm9kelhYZnoxeDhH?=
 =?utf-8?B?dm1zRWl6aCtIUHBHNGcxbVl0QzRyUnlKZnlHVVhnV3lQUzdjL0JIT3V5dWFx?=
 =?utf-8?B?YXBJakxCUzJsbExld251MVZFM0NOT3A2WVdPUnhibnk5Z1VxZGJTai9DdGg1?=
 =?utf-8?B?M3VhL3dHQ0gzRTB1cGtadjlGM0Z6ajRUc1pQRmV1ZklRM2gvbTFTeVNBei9s?=
 =?utf-8?B?ell5d2ptOUR1YWNBMG5HYm9FNnFSc3dvSjh6WHhuYkYvYkdBR0FhOXNHNEtj?=
 =?utf-8?B?SzdiSGlhSW94bUhZaytVZ2wzNWFWRFBETU5LV0xiMFdHcms0cnZYV1BGdHhy?=
 =?utf-8?B?WjhlcFBTVW16Uks5NWY3L3REZkRTMVZHcm14WXYyRHdWNnduMmR1MW1WbVBV?=
 =?utf-8?B?RXdEOGh2Ung4czZ1RGRjOGU1MllVLzY2ZWtLSDZwWktIemM2WWJoOHM5RmVH?=
 =?utf-8?B?YUwxcVViN3F0WGZOWnlUN1pGVEUvNjdkWGNyWGhnLzFxa0w0YzFCTGpuR2Z5?=
 =?utf-8?B?UzMzazNSTThVVVJhckdsdTcydEgvczd1bTJDbHc5RWI1UnI5VHY0MCt1bWlk?=
 =?utf-8?B?d1dlNEhhV3dSOHBnWDVIYk9SSUkxdm9LTHc0NDZuYm1vRVlkMHJ6Y3dxaXJU?=
 =?utf-8?B?SGFUMi84NzVCNXRIN3ZndW1oRTQwVWRJZ20zU2FmM1U2Y3FrNExhUmZyNUlT?=
 =?utf-8?B?SWhJYm93dXVzMHFvWFZmZGtiZCt4Ky82RkF6K1QvV3JFUko5S05EVk9CSmdE?=
 =?utf-8?Q?yoSDyLpOAd/xNxPIfRUd5tlbf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15742a42-598c-4eb8-217c-08dceea99174
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:45:23.7874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwy0s/Q5Pr+HQdo+Apck3W2tRKFG3D3EseGGgelBp9cyl21JMvOM9KgeRyk/C2pe+A0zNS+idmylAy40Z9L7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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


On 10/17/2024 5:24 PM, Christian König wrote:
> Am 17.10.24 um 12:06 schrieb Sunil Khatri:
>> Before making a function call to suspend, validate
>> the function pointer like we do in sw_init.
>
> Same comment as on patch #5, please add an amdgpu_ip_block_suspend() 
> function and just call it multiple times.
> Noted.

> Regards,
> Christian.
>
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26 ++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>>   5 files changed, 46 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c 
>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> index c1ff24335a0c..e55d680d95ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct 
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>>   -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>             adev->ip_blocks[i].status.hw = false;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 96cecd4a636b..fda89aeb4d1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3478,12 +3478,14 @@ static int 
>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>             adev->ip_blocks[i].status.hw = false;
>> @@ -3560,11 +3562,13 @@ static int 
>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>           /* handle putting the SMC in the appropriate state */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index 3e2724590dbf..6bc75aa1c3b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -40,11 +40,13 @@ static int 
>> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                dev_err(adev->dev, "suspend of IP block <%s> failed 
>> %d",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c 
>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> index 475b7df3a908..10dece12509f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct 
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>>   -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c 
>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> index 5ea9090b5040..ab049f0b4d39 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct 
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_MES))
>>               continue;
>>   -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
>
