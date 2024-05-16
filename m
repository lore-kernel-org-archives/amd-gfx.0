Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F86FC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 03:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C211E10E1F7;
	Thu, 16 May 2024 03:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cFb3U5Rp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB1910E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 03:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU/7zfFDkAwIwAeIXCqOEYt11A3W6B2eCxBTzsE86a99qvCnkGA1QrL2u2jhupZD+yjYzxKYo84mihxTc/pfhK1jRGC2pZ3S8zgxefURM7ttExeMOmCGm7SafYmT/W+kt8PDuRd8uyxp0plfDLLpI2jsGOtkXYzXwJBN2VRlslH4AUYKDhVy++CpDZwpyWnxLXrZfExFFOKZfayxJ/jqTrdnXf6tAvgrUwmYUJKZJutFC1kU/iBmDyF9tVwp0OnS3HqKOgbrFIfq8FBp8jKh445oITOc4f/tDHgE+Mmh4qwpHinL9T3Nde4RJAmdNF6c9Niaa78hxmVyq6WoEMUljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BNrHw1ocaR65OXpdDVHz3M3+2x0Y+qFPc6C1GNpYI8=;
 b=EOn4Rnh2SOgKnM+zsJbnZrWk9O0JDqiXQZ9FaTn7R7ICGbEswIvS5wwTAKcpl9l+RNswtf9x9SeALqe40cABnHJ/xSSPC/1EEFEFSRPYnZdiY0HYu8kV4hXZSZYWGCcRoO2RohICnIUbEF9eQ6FWqM/saUCt5ySebLv9ClVeg8HdR2IcPWKYnvEtqJXRs19aEtPMvGBwlCMdzATGylW2V85Mkq0yq2i/+eS1Ry8o7Vo6xL3Bwq48cn5+n80aYZsYJthIwm8jX+QKgkTbRZZLfu1uzXGg1haDmaHllgAtqq2mmBcKyzVyHdk5HB3NyHbud2bTyISBKcLt27jsUkyBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BNrHw1ocaR65OXpdDVHz3M3+2x0Y+qFPc6C1GNpYI8=;
 b=cFb3U5RplwSxLL+pofy8WvJzFENKlovK862iMHnANPklgpCm3qPL2J4w8nki7XGKFegXmob8QuUrT7MsrjLivUeu9BNveSaNs+63phEzJg9l2gGinHVjSsQPA+k+aQL9iV8TkTZXSe4c6tb+TYPGN6RT6tEULgFvA9k6+pWbBNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 16 May
 2024 03:41:06 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%4]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 03:41:05 +0000
Message-ID: <b1c87bf1-46f3-44ad-9ae7-83fa45af0ba4@amd.com>
Date: Thu, 16 May 2024 09:11:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/amdgpu: Add support to dump gfx10 cp registers
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240515121754.1810181-1-sunil.khatri@amd.com>
 <20240515121754.1810181-2-sunil.khatri@amd.com>
 <BL1PR12MB5144B860357AFBCC3A2518C8F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <BL1PR12MB5144B860357AFBCC3A2518C8F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 2758ceb9-9a40-4fe7-2d30-08dc755a0406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1NOc1JCaUNJWENyMzBacG0vZmcwTHZ0dk9TaW1BeFcrb3Qydk4yYmF0V3Vr?=
 =?utf-8?B?K3ZzRE8rQUNTV01nZkE2NEsvUnFpb2J4bkxZVFA5S0lXa0gzaTBnODZsN3FW?=
 =?utf-8?B?UDM3cnd3TmttSkMveWpvL2Y2bWs4WkJUNEFveS93VTZUQlpPTkxSVTZQaTM3?=
 =?utf-8?B?bXNPYXMzK3FBb3p2S3JmWUl1ZTBUaFR5WDdpSkFTVVIxeCtHM2N6U1BWdUtz?=
 =?utf-8?B?WXIzMjBWdVluMUFyWXhzZ0tHVlVsV1pRZUVIeWFJTVdYT05peHI4d0tkemZV?=
 =?utf-8?B?b1hqV01HWlM4cmltcHRwMXp3ZGNyVjJNV0RnZ2o1WTJQVTVtamVZd083ajJY?=
 =?utf-8?B?Y2dtMDlNMVMzbEk0NmJPTkVCUzJqNldYNjhaTUhQcFVwK1Q4MEsrUGJKNnR4?=
 =?utf-8?B?cmNxdWp6aWZURmU2aHBMT2hxQlJYcnhVR0VrRjJkZ2FDYVpIaHhXOFpBSDUz?=
 =?utf-8?B?QkRKODJWZllKMW9vWFNhc3dERGI5SGxIYm1Ya0VGNUZPL1dHR0dHL0dRK2dO?=
 =?utf-8?B?cGFNUUpkcVkyOXB3clVqNlJkeXVMQmNXUFMzYkQ1dG9uUGRtdkYwbHN3L0s1?=
 =?utf-8?B?VjAvanFTQ25jdzltd3E3TmI5RFh2TG9kZjRIWGpiM2FTYWR6OTRFRXFkRHVM?=
 =?utf-8?B?WWhxWUxHL3RjQ2V1QktMbGRpRzZPK3RzNEdyVHpQaHg1NGk4KzVKYWtURldC?=
 =?utf-8?B?QjBsSW8yeXlESnhNZUdRS21sTTRRNFpzTGlpTXh1cFRnSHYwNFFSMWRGRGh4?=
 =?utf-8?B?R3R1MVpTNXErdStyRHNDb0dsaDdQNW4vS0l2OVdnbGJXL2xHY29IcHFsbWZ2?=
 =?utf-8?B?c2d0MUhkR0JmQ2s5NGMvMDZsOWJFZEFsSmZrSDQwQU0yY3FveC9YZTA0NFJr?=
 =?utf-8?B?VW5pNDJranFIYlJrcFpzUHh3ZFVmUjBBWWVyOC8rMnQrQTFrWFdNZXVzYWZW?=
 =?utf-8?B?YUVZc0VKVUZSdUlSdmViSDFSSUJnOXR3WXA0VjYxa09RQklWbDNqY2hNR0Vs?=
 =?utf-8?B?amlzM0gxeWV0cklJVXY1SnJVeW9WcTVGZkFaODJsQ3pLLzJyRVdWMFpnUEZV?=
 =?utf-8?B?QTZwNllaM0VNbFR2YTVBTVZwd2lSdmVRRXBtTXRpTjZnandGY0FFcGlOeEo5?=
 =?utf-8?B?cHVxS3FUa3RsK0hobjUzUHdiUHdZSThZbFFobnpJbEZzcUxXUUNiblRkNVJr?=
 =?utf-8?B?ZCsxbDdPaWowbldURTFYSCtLVklxajdkbmZvVmlMeFZwdnMvWGp4c3lpbWt6?=
 =?utf-8?B?UWtaMzFXak03MmhuTXdFY2w3bjRzUnRnckNYcHRSa1ZXREFPSG5EVzdaQjR5?=
 =?utf-8?B?dlh3NWpKeTBmenJGM1UvMmxhcFRwTk9QOWJ0cjF0dVdoVDB0VTZMZ3BSYTJx?=
 =?utf-8?B?NlF6TXZFRDl2Sm9hU2g5d21icHpwMlc5N0M3Qy9lZTBmSlJiK3N0ZEdQMjdT?=
 =?utf-8?B?UUpSZ1dEL2pQZmNSL1pBUWJlZ0NlbUpFMkp6eWhtV0ZrU2phV3hMKytMaWhW?=
 =?utf-8?B?VncyZDA1TE11bE1rN2FkTldtbFFwUlBxVm5kRjU4L3p0Zzk2dUpkZ1ZDVjZm?=
 =?utf-8?B?dUJ6VGM2TVJ4MlJYM24zN1cvYUc3dng1MEkyQi85NzdNR1p6c1NERFZuOEJ2?=
 =?utf-8?B?TitoRUZVQzJYbThVSzBPcVJlVGJHUkNtWDZvODhSeVJZWkVkWVNKeWhJQkhN?=
 =?utf-8?B?UHVBdExkK1RqVmtUd25nVjhPK1M1NExGT0NNS1RKSTh1N09mQVZ6NnB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1JZby90N3M0aWhrWjl0bW1ucm5PYWlvRUhjMldrWVgzWHNXVlVLRExnOStJ?=
 =?utf-8?B?OXlOWnloS2JJeGdMdVQxL1RpdUxSR3k0cGNVT3dhd200Zm9mSzkrUVVqdzE5?=
 =?utf-8?B?aHVaN0dTbWlUR3lhdFM1VjJ2OE1oem5nNUkvT252MDU2L0Fzc1gzOHl6Wlpw?=
 =?utf-8?B?dk1GQXVRck1RVzNKR00zWjFWSUIxdkF1amE4RnROREhLcXA5eFlST1ZmaWdH?=
 =?utf-8?B?SHd2MXo5aENvZ2NGdUJkemIyWnZ1VjV5SVhVVkZvZ1RqYUZXd0I2eDJ6aWNO?=
 =?utf-8?B?ZEVFSGpDV3ZpZG1aQUk4MDJrUDJQOTlNd0hSbko1c1V3dG40bXBmTlcwQmx1?=
 =?utf-8?B?cmR6aW5UNElwZDlDenVhTDNCanlCU2ZKRm1OR1g1amxwcGpwbk9QSXhKaGJx?=
 =?utf-8?B?aE83QXpMZ3FPN1BNUXJNTlN6VFQrQWVYclZHSUpscVRzbFFzUklKU3VFcXhK?=
 =?utf-8?B?VXlFK21jQ05JTUxQZ2RFdHA3aEF5T1ZnaUNYTWg1QXErT09hT3hJS1JIZ0V3?=
 =?utf-8?B?Z052MTd3bldnVS9JWnFDeXJnOWFOUUd5c3dYWE10L1hSWkU5TzNFUU84Tm00?=
 =?utf-8?B?dGNRbU01aWxoY0gzSk52TCs4cDZ4b0FaNEpKaGJoaXc1V1JEeGp5SmxtWHR3?=
 =?utf-8?B?WEwxMDZJUHkzUmx5Um5YTVlrczNwMXZ0enZqeldMSmtUK016QmJndnYrMVNR?=
 =?utf-8?B?dFBiMFlaeWllQUZtZTNwV3ZUbU51aXl6aS8xOHkvMUxuUnVGaFZ1WFNnUk5y?=
 =?utf-8?B?TS9qZGJXSDk4U29QcGZKZ1Mxd1FhSkljYnVyQjdrV0hLbzhndjZWYTdyNVFr?=
 =?utf-8?B?REw5TVdoZ3ludG52WjRpUFpkU29kczNOUTFVVUtpY1kwbXovakprU2lubmZn?=
 =?utf-8?B?blRoZmk3OFh0aFBOMkFXWHloK1pVUDJJNDZzYjVFMDlrWXFmVW95UkRhUHNv?=
 =?utf-8?B?ZzltNGpwL2ZISGhQRU5jb2l6WVRVa1lmU2FDQnBpbDFTUmR6SWI5d2ZtNjhh?=
 =?utf-8?B?c2t5S3Z2WG1kVDlPTXhCSGhvVy85eWtOekhVRVhncnZQZmQ0VkVjdlR5NWhh?=
 =?utf-8?B?WWM1bjk4cDJaRzk5dm5CazRUMTdZcS9XNnBjNlppenpUYUFYdzJUYWRsWnFJ?=
 =?utf-8?B?NEpLZGhQRXJ6b3FjNHdCM1hhMTBIc1A5akthQk1ZTDNhWS85MVNWaVpkemVs?=
 =?utf-8?B?SnJyZzlkZ1Q0amFwYVpFeGtIQ0k1TjZjb3dmRXA1NVVCK2VNdWd0WFd3aUhz?=
 =?utf-8?B?VldneEd6U3RNSzhZM2xSZk9oODdEZVErRUsydGJtKyswbkpJYkRKb0JGcUpq?=
 =?utf-8?B?Y3JUS1d5S0VMcC9oKytybEp0eXQ2NGdERjNEWWxjWGhBMVdGbU9qUnVXMlJk?=
 =?utf-8?B?UlV2NEUvWUFRUkpyYWpFUmo4RUxwUjNGbkZGRzlPT3AvdW01OGxYMWFSZUZv?=
 =?utf-8?B?Z0dBb1M1V3lrcy8zZDJFa3NsQVRsTTJoQkQ3Y3pMYWFwblNlR0g4T0MrNVdx?=
 =?utf-8?B?UXpObys0QThCdTdLMGR3ci9WQ3ZJYTRiUFlPTWFrOU1kNElXemZwQy9pVlJJ?=
 =?utf-8?B?R0tXcXc5ZHNNTzJjOWdNOTBHMk81aGZpdVVLUk9HUHdsQ1l0NnE2dVl0dWtt?=
 =?utf-8?B?Q2FJcUxRRkR1OVdlSzVFVi8zak9YTjhoMy9qWGZlOStoUUhOaDUveXgvOFFG?=
 =?utf-8?B?cXo5Tk5SRTZEOTBlV1BWOXdya2VzYjA1eW9FUzRPSDNVTXpIOXZyempsS1dW?=
 =?utf-8?B?WFZOVGdLU1FMeWRsdGtjdnpkK3IxdGxyUGhyRVFrT1I4RWR1dTdlSmRPZkxJ?=
 =?utf-8?B?dWNEOXlhSGZOTmdiS25wRUJpOFl3RnpSNDNROFNZQzlWYlp5MGF1ZGJ2aW1B?=
 =?utf-8?B?SzlxL3Z2RmJhOHB5NVl3bW94R2R4NEtwRFpuMG5BdFU0bkllUHVvb1ZZTi81?=
 =?utf-8?B?K1BoYWlwVlRDK0JuaFp3R29rYjE3aTdnZUs2ejdWbEUvdjFmdFNtdzdJMmNU?=
 =?utf-8?B?dG1CV1p6Wkk0dHVhejhpa2ZYWHlKV1FoYlVSQjlpa2Y1SU1lRGcxQ1V4bllX?=
 =?utf-8?B?cWloeHgxVy9oSE1VMm1KMkErL3BDb0VkVkpDYzZ1UzJSb2xORGlnMHdpM0Vk?=
 =?utf-8?Q?Ra8QB3ARn4zOxzB6HXHQYrBuh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2758ceb9-9a40-4fe7-2d30-08dc755a0406
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 03:41:05.7849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lfk5KIky+bVYJlZLCr+tPLXy4bZ5ZFWVwdg18R93o068zXQfu22Ld5XNzaf4YUWmvKQBJ6sclq5+Kc86z7XjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492
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


On 5/16/2024 1:40 AM, Deucher, Alexander wrote:
> [Public]
>
>> -----Original Message-----
>> From: Sunil Khatri <sunil.khatri@amd.com>
>> Sent: Wednesday, May 15, 2024 8:18 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Subject: [PATCH v3 2/4] drm/amdgpu: Add support to dump gfx10 cp
>> registers
>>
>> add support to dump registers of all instances of cp registers in gfx10
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   1 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 117
>> +++++++++++++++++++++++-
>>   2 files changed, 114 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 30d7f9c29478..d96873c154ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -436,6 +436,7 @@ struct amdgpu_gfx {
>>
>>        /* IP reg dump */
>>        uint32_t                        *ipdump_core;
>> +     uint32_t                        *ipdump_cp;
> I'd call this ip_dump_compute or ip_dump_compute_queues to align with that the registers represent.
Sure
>
> Alex
>
>>   };
>>
>>   struct amdgpu_gfx_ras_reg_entry {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index f6d6a4b9802d..daf9a3571183 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -381,6 +381,49 @@ static const struct amdgpu_hwip_reg_entry
>> gc_reg_list_10_1[] = {
>>        SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)  };
>>
>> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_10[] = {
>> +     /* compute registers */
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_HQD_PQ_DOORBELL_CONTROL),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_HQD_SUSPEND_WG_STATE_OFFSET),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS) };
>> +
>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>        SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4,
>> 0xffffffff, 0x00400014),
>>        SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL,
>> 0xfcff8fff, 0xf8000100), @@ -4595,10 +4638,11 @@ static int
>> gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>>                             hw_prio, NULL);
>>   }
>>
>> -static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
>> +static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
>>   {
>>        uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>        uint32_t *ptr;
>> +     uint32_t inst;
>>
>>        ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>>        if (ptr == NULL) {
>> @@ -4607,6 +4651,19 @@ static void gfx_v10_0_alloc_dump_mem(struct
>> amdgpu_device *adev)
>>        } else {
>>                adev->gfx.ipdump_core = ptr;
>>        }
>> +
>> +     /* Allocate memory for gfx cp registers for all the instances */
>> +     reg_count = ARRAY_SIZE(gc_cp_reg_list_10);
>> +     inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>> +             adev->gfx.mec.num_queue_per_pipe;
>> +
>> +     ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
>> +     if (ptr == NULL) {
>> +             DRM_ERROR("Failed to allocate memory for GFX CP IP
>> Dump\n");
>> +             adev->gfx.ipdump_cp = NULL;
>> +     } else {
>> +             adev->gfx.ipdump_cp = ptr;
>> +     }
>>   }
>>
>>   static int gfx_v10_0_sw_init(void *handle) @@ -4761,7 +4818,7 @@ static
>> int gfx_v10_0_sw_init(void *handle)
>>
>>        gfx_v10_0_gpu_early_init(adev);
>>
>> -     gfx_v10_0_alloc_dump_mem(adev);
>> +     gfx_v10_0_alloc_ip_dump(adev);
>>
>>        return 0;
>>   }
>> @@ -4816,6 +4873,7 @@ static int gfx_v10_0_sw_fini(void *handle)
>>        gfx_v10_0_free_microcode(adev);
>>
>>        kfree(adev->gfx.ipdump_core);
>> +     kfree(adev->gfx.ipdump_cp);
>>
>>        return 0;
>>   }
>> @@ -9280,7 +9338,7 @@ static void gfx_v10_0_emit_mem_sync(struct
>> amdgpu_ring *ring)  static void gfx_v10_ip_print(void *handle, struct
>> drm_printer *p)  {
>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -     uint32_t i;
>> +     uint32_t i, j, k, reg, index = 0;
>>        uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>
>>        if (!adev->gfx.ipdump_core)
>> @@ -9290,12 +9348,32 @@ static void gfx_v10_ip_print(void *handle, struct
>> drm_printer *p)
>>                drm_printf(p, "%-50s \t 0x%08x\n",
>>                           gc_reg_list_10_1[i].reg_name,
>>                           adev->gfx.ipdump_core[i]);
>> +
>> +     /* print cp registers for all instances */
>> +     if (!adev->gfx.ipdump_cp)
>> +             return;
>> +
>> +     reg_count = ARRAY_SIZE(gc_cp_reg_list_10);
>> +
>> +     for (i = 0; i < adev->gfx.mec.num_mec; i++) {
>> +             for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>> +                     for (k = 0; k < adev->gfx.mec.num_queue_per_pipe;
>> k++) {
>> +                             drm_printf(p, "mec %d, pipe %d, queue
>> %d\n", i, j, k);
>> +                             for (reg = 0; reg < reg_count; reg++) {
>> +                                     drm_printf(p, "%-50s \t 0x%08x\n",
>> +
>> gc_cp_reg_list_10[reg].reg_name,
>> +                                                adev->gfx.ipdump_cp[index
>> + reg]);
>> +                             }
>> +                             index += reg_count;
>> +                     }
>> +             }
>> +     }
>>   }
>>
>>   static void gfx_v10_ip_dump(void *handle)  {
>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> -     uint32_t i;
>> +     uint32_t i, j, k, reg, index = 0;
>>        uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>
>>        if (!adev->gfx.ipdump_core)
>> @@ -9305,6 +9383,37 @@ static void gfx_v10_ip_dump(void *handle)
>>        for (i = 0; i < reg_count; i++)
>>                adev->gfx.ipdump_core[i] =
>> RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>>        amdgpu_gfx_off_ctrl(adev, true);
>> +
>> +     /* dump cp registers for all instances */
>> +     if (!adev->gfx.ipdump_cp)
>> +             return;
>> +
>> +     reg_count = ARRAY_SIZE(gc_cp_reg_list_10);
>> +     amdgpu_gfx_off_ctrl(adev, false);
>> +     mutex_lock(&adev->srbm_mutex);
>> +     for (i = 0; i < adev->gfx.mec.num_mec; i++) {
>> +             for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>> +                     for (k = 0; k < adev->gfx.mec.num_queue_per_pipe;
>> k++) {
>> +                             nv_grbm_select(adev, i, j, k, 0);
>> +
>> +                             for (reg = 0; reg < reg_count; reg++) {
>> +                                     adev->gfx.ipdump_cp[index + reg] =
>> +
>>        RREG32(SOC15_REG_ENTRY_OFFSET(
>> +
>>        gc_cp_reg_list_10[reg]));
>> +                             }
>> +                             index += reg_count;
>> +                             /*
>> +                              * Reading all registers take long and causes
>> watchdog timeout,
>> +                              * releasing core for every set of registers read
>> helps in cpu
>> +                              * core not being locked.
>> +                              */
>> +                             msleep(1);
>> +                     }
>> +             }
>> +     }
>> +     nv_grbm_select(adev, 0, 0, 0, 0);
>> +     mutex_unlock(&adev->srbm_mutex);
>> +     amdgpu_gfx_off_ctrl(adev, true);
>>   }
>>
>>   static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>> --
>> 2.34.1
