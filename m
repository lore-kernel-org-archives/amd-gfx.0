Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13318D3A679
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF16410E38D;
	Tue, 29 Oct 2024 17:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVgsqv78";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C4F10E38D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqfR89K2vP0ByyRT+o6GpfpqTPGfNuzn2adKymsdLY3DboLZ4PAtVVWhU6wyWRs7Jscuof91qoes9sAzqPPgNEwUnnaIzVKGIHuyfna7v3cQLOV91+VZDEI+qoTpz5ZLPwqpCrGDep8lOti6s74FBGbvOLRyC30YxzOSmpjBIAW9q7XShy5cfl/H26hmu2BycHtSR/lm3mbMPbvlljTvCfQDD0jOt50mQK7XrA7WhfW0qp3uBRRHDWbY6l5yqnMMRgmQDZ10qgfKTyspSnkxD/D7XgXV5sI+ZabeTJ67xsQl/u3AtWDh3HnfgyBbxMIunMuQksmqebZffEV0iaEQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFa+sMlHl9jBjpTPoSZmL3cRSLc2EnnRN4aIzIBP9zE=;
 b=EUglb18PwSLu8rLFBLP+xkRLTGrZHAZDW3qi0l4mGmT31zCpBwKh4QvE62G9sEnfb8WWjrAIz9rwFZzmZT7WP8qV/AELukp0vJVuDUQAVAXCYuNHpy1mskkxtCTWn1YgtMKGCLzrSwB6inz7JHuhztFxtp5nz8zCn6kAwkkqgVD1n+Lc1HEUYtU9DlixXGKdDeICXeBsfRoEY+pZpb4fgmV1gmoZKEljrGFxMvv5iaZnR51Y7JK/S4ZlcF2q1FIWCMYV9/AWj+RNTKOzyCaI3Y+UByMpQaS9fc9yIPVqWLOZ6mIRmuDWzIUqJNxMtdx5YxYIqD0a8mXdcxM3zKFHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFa+sMlHl9jBjpTPoSZmL3cRSLc2EnnRN4aIzIBP9zE=;
 b=UVgsqv78VK+jfRjvxNshzdRry25GD1QiFuXgWahsqCG1ejX4RwkTL9qa8Bl/cVFYX7ucb4qDBwo+lUVnMLGVcooz/DCV4yDqBx6kvYVUYxr/xZZU506YqX+e97Itu7z+bjxiag+SztTz3IJQ6TnLNjODy86CvUuamQS4xC4o+Ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:44:54 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 17:44:53 +0000
Message-ID: <7b60b466-347a-4005-b462-d12f714ab458@amd.com>
Date: Tue, 29 Oct 2024 13:44:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/29] drm/amd/pm: add inst to smu_dpm_set_vcn_enable
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-4-boyuan.zhang@amd.com>
 <CADnq5_Oi5Vvs1bJa3+TtoCkxAo-jVcJagQtn6JRhpNTpPMpd3w@mail.gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <CADnq5_Oi5Vvs1bJa3+TtoCkxAo-jVcJagQtn6JRhpNTpPMpd3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::24) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2fadb8-add6-40f1-099e-08dcf841651f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlVtNDZpRTZ4ODViM1ZoVHdrN3JMcGpkbkJWYWNscmgzOXVJUGRCRlgralIx?=
 =?utf-8?B?WnllamRtT25OaXFqdWlxVkFHR0dkK3ROQkxvK1FKQnBwdUw3dVJMMWM2cTdv?=
 =?utf-8?B?L3R2S040ZCtnTFF6WFM1SXJsT3FPc2lOdUlDREVBVC9rMm8vbmhmRi85R1Ra?=
 =?utf-8?B?eE9KWkVSMmxhZEpROHE0a0pJRDlKR29lTHNkU2ZTVU1TYmhycmdMM2NGRFE4?=
 =?utf-8?B?VWNuOGQ5a3V0ams5YXJxTjJXZEJjNFB2ZDRqck92VG1tOUd3UzFJSEhOcjVl?=
 =?utf-8?B?QjEyd0o3ZHlHQmN1VnQ1c2JGWmZtUUJxOU9idnFoVFJrOXl2Z0UwZEVQeVJh?=
 =?utf-8?B?UkplTm9DbFQrbXM3QTl0Q3hEZkp0RE0yOWFqQjhZYnZpREpmdFZqeHBFN25N?=
 =?utf-8?B?TTg5d3pvWGgraFpkNVUwbU9oaVhPZE0vS1Q1SkROQXlWK2dzbG13djFjQUI4?=
 =?utf-8?B?QXpXN3FiMWg3eStnck1WYjhBQUhrUHlQRytaSTM0dklqQ1Y1UzNIN2NNZnhn?=
 =?utf-8?B?dG9kemVhRTFITEtmazJlOFVZamVhWnN2OWowbnVyelNQS0JaV25MampjNC9C?=
 =?utf-8?B?VGVOc0cwM1dBVldOWDUzcGxWWUlUdzl1QVJEeHFTWm4yTVZRUzJ3SlZUZFN5?=
 =?utf-8?B?a1FTVWR0Z0QzczA3RkZheW5Cbnd3SkxyQlpkRVpzbCtSRVp3K1pYU3dDQTY4?=
 =?utf-8?B?OTVaWUFHZUs5MFpxUlRnM3cwbUczdHJNTHVCWDZBK1QzZG12aXU5UGo2Tmgx?=
 =?utf-8?B?R1kzTWlNNHY3QjRnYy9zNWxETEJURTZSVWRGYW5zckJqekZ5S1NTU1ZZQUdR?=
 =?utf-8?B?QkY3dGd1ZUdKUjVjREw4dDhwUlM4MzI3cjJnaEdRbWpSMVhZVFJpdXFZaUVV?=
 =?utf-8?B?OGs3L2lFM2tUSUZTMDBqdVMwYUJNaGo4Qm0wa3JLUzc3b2tiRi80NGZvWERt?=
 =?utf-8?B?ZkV6TEUwRkc3dVBQTlJCck1CYXF5VDgzRVUvd3p2STdEM1NEVHhwSWd0QTBn?=
 =?utf-8?B?WG1oRHl0TDdkTGZ4eFkwUzlMdVQvTFZ1L1ExOGtabGEybzYwTURkeGpmNTh0?=
 =?utf-8?B?ZGd4c1JYMVYzZmFmZ2daVGgzSmJOVmNLQVYwenRxZWlxL3hFbVduL2Q3V1E5?=
 =?utf-8?B?bEVhMUpYSnA3S2R1K0R2aHFyRVBpZnd1UlE2aXNqb1R6cU9mRmpwaEVBMTky?=
 =?utf-8?B?MU9INGwxS0xJbzZFOSs4eFVUTHpwRE9DczBnKzRMUTB1bjhZbGFDb3Vna1F2?=
 =?utf-8?B?N3NHc3pVZEJ6Q21MSlFmcVgvL1F2NWtPc1ZIU0dTU09ZSEV3N1hqNjJQVXRB?=
 =?utf-8?B?OW1OeGt0ak5DZm1jWnMzblNHVmtIZVlIejdwSWl5SWdrZC9lbTlDUWFSMUlx?=
 =?utf-8?B?U3N4elY3Y2lFWHlHUEZrejF6S0tHbVhvRksyZW94L0FiWnZLTUhINkhmQnda?=
 =?utf-8?B?SXg5RGRqZW5CaytrSFJkUE9qMnVqOS9peDY4QnppZlRnQkJEdUhoN3hmODRF?=
 =?utf-8?B?U3huSkNGWkxuQi9rKzZnZ0pJVTBMSUVuaWZPZXZSczlGMlU3cjBmZWgxbEEw?=
 =?utf-8?B?RGNObXF0ZFg5bDZ3N01XYk1pZkZScTBtM1AycE5WKzBHa0FTNXNRRnhCK3FU?=
 =?utf-8?B?VUxRMGtySTFGb0RxbkQzYk5OTG8zdDFTSUh0YWUrZGdwR3BuTy82eGlQbTJR?=
 =?utf-8?B?Rkk2emRLZXI3aWE5eFVZcTYxSUxGRXFlQ3U1ZmJXZkdobTZmNUtSVnlWWU5m?=
 =?utf-8?Q?BAK3Jl//jlSCFl91MI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFXajk5c0RxcHZvK3ozeDBBS2NHU284TEJLbTRQYTU1emRtZlRCWWdLWS80?=
 =?utf-8?B?YzVRZ0RudTF2WGFOb2RRajI1eFBoUi9PcDJuTEE1Q0FqUWdRN3VUWFoyNGpY?=
 =?utf-8?B?aFpIZnpWL2xFV2NlczlEMEZTOExKdmVvMTFXLyt0Y3pNbHo4UENZbWxGMEMv?=
 =?utf-8?B?R3U0WHRVQ0RTMkJWcnJzNUFGTy9lUGhiWTdvVUhrZW1oWGJOQ0FQbWZUS0F4?=
 =?utf-8?B?akFEY2NiNGdwQzFIcW5rUHVVd1E0dnpyN3N2WlVsbHpPVW1TUG1rRGNRQVRS?=
 =?utf-8?B?Y09SNzhnY1ErN1I2Vm00czB2T1dlWkpTYnl1bTZKeVIvMjBFNTFyY2FyNnpB?=
 =?utf-8?B?bHFXZFdEd0dGektCWDRMZGREdGUvQk1QWEorS1ZhN3BIWlJrcnA3bWp1eElT?=
 =?utf-8?B?N2w5alRvSitxdTNtbEVEWUEwSU9VNUJEcUNHczk4Rys4NUpNNzRralVjZ2NG?=
 =?utf-8?B?ZU1EYWRxaU1wSDdoaHZYZ3FzV1V5ZUFTOWZISFVUMlR3bHgzazAyM3RMdlVr?=
 =?utf-8?B?VkdSYkoxdkNyRkN4L1daRlU1SjZQaVdTSEVWaFY3QUJMK0NPWWFTMDJ5dmtl?=
 =?utf-8?B?LzVoNHZWd2lVR1gzbVozRjRkRVJ2ZGVLZ3R5VnpldDNLU1Q0QW9ZeU5pVm1W?=
 =?utf-8?B?QXFUaHJsUzRQcHp3WklvemhGQUk2UUVpNXErWXRaSXlERGQ0SkpZSHNKeU05?=
 =?utf-8?B?L043dUw5MWFMNmM5RllxVGJOa05CWGJyM2Q0TXNJYmJyWjBySWgvTk1YNWp2?=
 =?utf-8?B?cXlMbG5scmpXb01KbjQxYzIxT3VOOUo0NmFrL3p6TmlJZlFveXNWNTh5UUlF?=
 =?utf-8?B?bGpaWnRuTk16Y3NyNGprVkREaUs3ZDQwK0R0U09ZOVNlK2o3N2pIL3pYajBZ?=
 =?utf-8?B?SmVxNTdmN0h3TlRtejRJbDJ2TEU3VjNqK0Iydk8vemVNdzhuRkdDckRnSFJJ?=
 =?utf-8?B?NmFGYXllUTJYeHViSStoSS9qZ3M5Y3pFNjZKei9YTXdYWXdLVmdVdVFXUXJF?=
 =?utf-8?B?RkxSOUJoaHphYmVvc3hCOTg0ZDNKeGJjK0NyTEIraXZ2TTg3UWlERTNIbDRM?=
 =?utf-8?B?RlpWdVlDb2VNNVMvUGt0MFpIa3dIS0RXYUxraUFKZlFtMUVCeVlURlpObDJh?=
 =?utf-8?B?OTJ4bEtibFQ5cHJsS2o4UUZkdVpqZUJaRm4vUGc5Y2w2NUt1SlZHMjhzUUlD?=
 =?utf-8?B?c2VQYzBxWUprdjBIc3lzdFlEd0Mybktvc1hBc2UxRDAzTklpOVJpM1doUDJq?=
 =?utf-8?B?VGpWQ0xueXhJMzVyMUE4YXdhdGUyWTdxZ0tnRVN4OWFUdTR1VEtnSENwRVhE?=
 =?utf-8?B?RjV1S1hObU5jY3NZcWNTMEpwY3UvLzFxVFYrWVJTeXIvSlVZbU4raEU1d2x2?=
 =?utf-8?B?UHFaWXAzYmNUeXhIVU5aUC9kZEpIV3c5a1lYRDZDT3orNEhwclBYZW9zZlRz?=
 =?utf-8?B?NHR1OHNJNlJyQVFleTZ1Rk50SVZ6VzVCaXUvY0VTYnJqV3g1azc2MnlkRXcw?=
 =?utf-8?B?azV3UGt3MStPTG5FOW9seVoybmZpTXFHVXJrQmwvWEJvMGdIWURlTG1hdGZn?=
 =?utf-8?B?bWU3V0tFano2a212Wmt6UlhRNDcxay83dnplbW8wR1ZyZVQ2Rm10eDA2OFBr?=
 =?utf-8?B?NVRBa2pmVStTMW9yZ0RiL1lkNEJGZWw1Vk96VW9zMWxlMXEybm1aWjAzRUNQ?=
 =?utf-8?B?Nm1DdFJyb1J3OG5FVm5kRGF2b0xIaGxTODFjWlVncXlDc1U5eElNNnVrOERu?=
 =?utf-8?B?ZHN4ZHdqZnpWRjllV2ozUFFzN2RsT054VkxrdkswRkQ5MGVxODRsek45ZmtI?=
 =?utf-8?B?V1UrNkl3cHhEVk53VCtHNUlONkZJV3JyL01ZWkRMYU0zemx0bEg0OUs4NzZ2?=
 =?utf-8?B?NTdpbGx5aUVmWVVqRm9jSlBwWEtYT1FYYUxHY3RMUFMwZFVnemZSdjNUdFN5?=
 =?utf-8?B?RURVQlNISmJWc3prYmlCanB2WVR6cTJYWFBIMFZlZTV2c2p3SEg4TldWRVJ0?=
 =?utf-8?B?dXNwSW9pY2lRb1hjVVA1L0w0dElqZHY3d1huaDZkZWtuZDNlZVNBQndNWFdh?=
 =?utf-8?B?N290V3NSd2U2NFJVOFE5MElXVlFhZmtRUnl5bzFNT3FNOEhwKzZTNC8yR0l1?=
 =?utf-8?Q?FBiplsTEjxknqzsfUoQ8xx2kS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2fadb8-add6-40f1-099e-08dcf841651f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:44:53.6184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DohsAVqGB4ryck/WusRcWrav27PEs9PZRExJUDxtkhwAyToC51lfTR1gobxCDqgMGh4ybzUwrX9jxD+5zMfB7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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


On 2024-10-28 15:04, Alex Deucher wrote:
> On Thu, Oct 24, 2024 at 10:36 PM <boyuan.zhang@amd.com> wrote:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> First, add an instance parameter to smu_dpm_set_vcn_enable() function,
>> and calling dpm_set_vcn_enable() with this given instance.
>>
>> Second, modify vcn_gated to be an array, to track the gating status
>> for each vcn instance separately.
>>
>> With these 2 changes, smu_dpm_set_vcn_enable() will check and set the
>> gating status for the given vcn instance ONLY.
>>
>> v2: remove duplicated functions.
>>
>> remove for-loop in dpm_set_vcn_enable(), and temporarily move it to
>> to smu_dpm_set_power_gate(), in order to keep the exact same logic as
>> before, until further separation in next patch.
>>
>> v3: add instance number in error message.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 65 ++++++++++++-------
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
>>   2 files changed, 42 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index ccacba56159e..bb7980f48674 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -234,11 +234,11 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
>>   }
>>
>>   static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>> -                                 bool enable)
>> +                                  bool enable,
>> +                                  int inst)
>>   {
>>          struct smu_power_context *smu_power = &smu->smu_power;
>>          struct smu_power_gate *power_gate = &smu_power->power_gate;
>> -       struct amdgpu_device *adev = smu->adev;
>>          int ret = 0;
>>
>>          /*
>> @@ -250,14 +250,12 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>>          if (!smu->ppt_funcs->dpm_set_vcn_enable)
>>                  return 0;
>>
>> -       if (atomic_read(&power_gate->vcn_gated) ^ enable)
>> +       if (atomic_read(&power_gate->vcn_gated[inst]) ^ enable)
>>                  return 0;
>>
>> -       for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> -               ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
>> -               if (ret)
>> -                       return ret;
>> -       }
>> +       ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, inst);
>> +       if (!ret)
>> +               atomic_set(&power_gate->vcn_gated[inst], !enable);
>>
>>          return ret;
>>   }
>> @@ -359,6 +357,7 @@ static int smu_dpm_set_power_gate(void *handle,
>>                                    bool gate)
>>   {
>>          struct smu_context *smu = handle;
>> +       struct amdgpu_device *adev = smu->adev;
>>          int ret = 0;
>>
>>          if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>> @@ -375,10 +374,12 @@ static int smu_dpm_set_power_gate(void *handle,
>>           */
>>          case AMD_IP_BLOCK_TYPE_UVD:
>>          case AMD_IP_BLOCK_TYPE_VCN:
>> -               ret = smu_dpm_set_vcn_enable(smu, !gate);
>> -               if (ret)
>> -                       dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
>> -                               gate ? "gate" : "ungate");
>> +               for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
> Some compilers will warn about mixed declarations and code.  I'd
> suggest declaring i at the top of the function.


Fixed and re-posted.

Boyuan


>
>> +                       ret = smu_dpm_set_vcn_enable(smu, !gate, i);
>> +                       if (ret)
>> +                               dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
>> +                                       gate ? "gate" : "ungate", i);
>> +               }
>>                  break;
>>          case AMD_IP_BLOCK_TYPE_GFX:
>>                  ret = smu_gfx_off_control(smu, gate);
>> @@ -780,21 +781,25 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
>>          struct amdgpu_device *adev = smu->adev;
>>          struct smu_power_context *smu_power = &smu->smu_power;
>>          struct smu_power_gate *power_gate = &smu_power->power_gate;
>> -       int vcn_gate, jpeg_gate;
>> +       int vcn_gate[AMDGPU_MAX_VCN_INSTANCES], jpeg_gate, i;
>>          int ret = 0;
>>
>>          if (!smu->ppt_funcs->set_default_dpm_table)
>>                  return 0;
>>
>> -       if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
>> -               vcn_gate = atomic_read(&power_gate->vcn_gated);
>> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
>> +               for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>> +                       vcn_gate[i] = atomic_read(&power_gate->vcn_gated[i]);
>> +       }
>>          if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
>>                  jpeg_gate = atomic_read(&power_gate->jpeg_gated);
>>
>>          if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
>> -               ret = smu_dpm_set_vcn_enable(smu, true);
>> -               if (ret)
>> -                       return ret;
>> +               for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +                       ret = smu_dpm_set_vcn_enable(smu, true, i);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>>          }
>>
>>          if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
>> @@ -811,8 +816,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
>>          if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
>>                  smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
>>   err_out:
>> -       if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
>> -               smu_dpm_set_vcn_enable(smu, !vcn_gate);
>> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
>> +               for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>> +                       smu_dpm_set_vcn_enable(smu, !vcn_gate[i], i);
>> +       }
>>
>>          return ret;
>>   }
>> @@ -1265,7 +1272,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>>          smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>          smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>
>> -       atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>> +       for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
> Same comment here and all the place below as well.
>
> Alex
>
>> +               atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>>          atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>>          atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>>          atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>> @@ -1832,7 +1840,8 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
>>                  ret = smu_set_gfx_imu_enable(smu);
>>                  if (ret)
>>                          return ret;
>> -               smu_dpm_set_vcn_enable(smu, true);
>> +               for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
>> +                       smu_dpm_set_vcn_enable(smu, true, i);
>>                  smu_dpm_set_jpeg_enable(smu, true);
>>                  smu_dpm_set_vpe_enable(smu, true);
>>                  smu_dpm_set_umsch_mm_enable(smu, true);
>> @@ -2035,7 +2044,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
>>          if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>>                  return 0;
>>
>> -       smu_dpm_set_vcn_enable(smu, false);
>> +       for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
>> +               smu_dpm_set_vcn_enable(smu, false, i);
>>          smu_dpm_set_jpeg_enable(smu, false);
>>          smu_dpm_set_vpe_enable(smu, false);
>>          smu_dpm_set_umsch_mm_enable(smu, false);
>> @@ -2949,6 +2959,7 @@ static int smu_read_sensor(void *handle,
>>                             int *size_arg)
>>   {
>>          struct smu_context *smu = handle;
>> +       struct amdgpu_device *adev = smu->adev;
>>          struct smu_umd_pstate_table *pstate_table =
>>                                  &smu->pstate_table;
>>          int ret = 0;
>> @@ -2997,7 +3008,13 @@ static int smu_read_sensor(void *handle,
>>                  *size = 4;
>>                  break;
>>          case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
>> -               *(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0 : 1;
>> +               *(uint32_t *)data = 0;
>> +               for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +                       if (!atomic_read(&smu->smu_power.power_gate.vcn_gated[i])) {
>> +                               *(uint32_t *)data = 1;
>> +                               break;
>> +                       }
>> +               }
>>                  *size = 4;
>>                  break;
>>          case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index 4ebcc1e53ea2..06d817fb84aa 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -399,7 +399,7 @@ struct smu_dpm_context {
>>   struct smu_power_gate {
>>          bool uvd_gated;
>>          bool vce_gated;
>> -       atomic_t vcn_gated;
>> +       atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
>>          atomic_t jpeg_gated;
>>          atomic_t vpe_gated;
>>          atomic_t umsch_mm_gated;
>> --
>> 2.34.1
>>
