Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7C0CAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 23:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E6310E14D;
	Wed, 17 Sep 2025 23:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FztXDGOu";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E861210E14D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 23:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXsrMfpHISmhXueZn64f3+RcT70nwjUpJqovoyDySKLM2KnUobkJmEZrEIMnA1Qtg1j1rr6qpvt5YMfimI7x6m4qaR6RxmMyYKmr5JTRqdYuSpHsXBsgAQtTG1ho9PQUPdMo7alHSu9woFxCqioorBPSpM/K09Zcos+EGmflb0RbnY7Qi395nuKgqCdUOJjMJYsvV5/8ERe2Milk7HxPxcTSwJRUMv0oOGm9AbII0Z9QEEcPmdRbFYujja0a2kh3HyrBi2pV5iZfmc8ngDx9R7PzUxIHQc0OsjuYrF7AIBTV+h5xoGs3CzHgbtsQRQTwf1EaHDO8IRMsGoTEMUm76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZXJRMz1ddOMvxzflr3F5GllzeeCxtMzFA9CPhR48Oc=;
 b=vfT7ZXo1ZOSwSl9m1tfr8vV9Tp89dWOhkGgxKe3GWVQoDESJNhe26hxVT7Gjc+kIyo4cLYWOwALFONIofcSDpPPVL96I6kollgs+tM8vXm4FGPf0lQ61X61dggzlHlcRs4uAqyk0b5VBxK8cjfIDLmPVFymckAPje9I1HbS4yLxsoJPHJjFhXlkJZYAh/uA5S4EVndj1pkGqs4I9p1ArLLhK9RCOb15Pob+O7rn9VuGJyezseo/W/ei0DiewYm2f+wC2Q0XMDITeNfEVD/bZWgVYd4CYHAqGKu5FuZwmgvG+fdfLq3nvW9VWcBLbSiUBbDKxYlcfmJHwVlleaGoU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZXJRMz1ddOMvxzflr3F5GllzeeCxtMzFA9CPhR48Oc=;
 b=FztXDGOu6Foc3ZVPwfSZbKXeNfMGl4+RKkZ6AeHA5az5iPHL98cvfXlM8iUTy05SGRO+t2du+FANclJEHxgGcBTn1no+0+agBoi1daNkz1CMrmOXgdMbZBFoz21NowUMRvK1K43jrvC5tTZR16tw/SWO5kerSkUdqxzBvrhBos8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 23:12:12 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 23:12:12 +0000
Content-Type: multipart/alternative;
 boundary="------------o9ZOivE2QmUp4SSNB7iilj6q"
Message-ID: <b22f9f1f-0427-432c-a472-23e1fd934d46@amd.com>
Date: Wed, 17 Sep 2025 18:12:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix mmap write lock not release
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250916224125.29338-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250916224125.29338-1-Philip.Yang@amd.com>
X-ClientProxiedBy: SN7PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:f2::13) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 2597a64c-1677-4042-db69-08ddf63fa1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWtqZkNOOFY4NTlYZzhSQW5IK09ENVNzUytmLy83TjJwNVhudDRFTFRMb1VB?=
 =?utf-8?B?RVU1NEpLd29ZbUdFWFYvV242TUVqWHlqei9EU0FEbzFxZ0tVanZVSStmTDdN?=
 =?utf-8?B?UGJQWDRYY1prZklScmtjR0R1aTIwSmcrb1N5ZU9mSGtOWHg1ZDZXZDFGckZC?=
 =?utf-8?B?S3dsSXl1a3dKeSt6UUhFM01Zdll0bDJodlNsUVNVTG4wYTRVdWZsQm13VnBh?=
 =?utf-8?B?Q3hLYlBEZnBsRUxQQWVDYjMxUWw5K2QvcDJOK3NHUC9IVXlhUExYTjRnOXZT?=
 =?utf-8?B?WklLVGlxVVVmc3ZabkdQenVqTnNFRlExVkdPTnpxTFhybjgrMVRqMHlzZHVx?=
 =?utf-8?B?cy94a0hBcjlpeW4wa2VSTVFiYzQrMjk5bTg1aHZYZ0xVeFQzNVhScUEvNnln?=
 =?utf-8?B?VW1uL05PR1U3LzI2MjNrSHdCSncrS05MQS9IbU41Q3FDcG1CUFAzRU1iQjVW?=
 =?utf-8?B?UllrZWtNbFJxRk1zVVE1clhuaER6VWVNL3VkY3pFY2JJaEFScTc4YmdTaVBO?=
 =?utf-8?B?NVk1eGRpK0ozKy91TzdiazdLNUpiSlBVUGsyNFlGSTk5RjVtdSs1NFR0M2JH?=
 =?utf-8?B?NUJwZjFnVG5YeUs0TzB5Q2wzWnRhZlV0ejEyNUtsZ2F5bHAyT0pUQ0RQWGl6?=
 =?utf-8?B?RTQ0cTFNZWFUTG9jSzRzcURmNVFwZXV3OW9lSE9yM2tKRTNoa1FNbGFmSjBz?=
 =?utf-8?B?TE1lL01iRTZkdVpCTVpsQkVhSjMxeXUvR05uMHMyZ1BxVWtxeUkweGVPR0xZ?=
 =?utf-8?B?cUMxSHkweUhCVUJucTN5SHNTaDMwZS9yRTJRdEFiYTQ3NFhaYWd5WS9yNlZh?=
 =?utf-8?B?RzNuemVIdkhYbHVQai91R25WSGhnTE9aYUJ1V3RIemxRUUlqVUFLS3N2RmtG?=
 =?utf-8?B?a0dlN1o0Z09IU2laTW83aWQwNW9adFpZOGJsR2tTK3NEUk12T2V3RVBNT2ZR?=
 =?utf-8?B?elVRamp2THNkcWNVV0pscks4VHpybjdiNit2eG9ZM05jSkFpbzhoOXlWRG1j?=
 =?utf-8?B?cmpXOVNPaTMwSUplbkxGWUtVSXRZK1duSWM0bURWTFpvRE9jVEJYbUc0Nnk0?=
 =?utf-8?B?T1NwOHB4dWNzMzVZRFRlaWcyY3UrMVp3Z2VUMmVCdnE2WEJDaGRWZVA1SS9n?=
 =?utf-8?B?ZEl1dHFyTW9ybE1saTBDaHQrU2NZR2FQbTdZaGFCMnhNRUhlbDJYWVNkZnRh?=
 =?utf-8?B?dnNWM0hCMFZWN1hsWXp0OW1mRjk5WU5PbTlpbWljS3pYM1pXMHFSOEhNMndy?=
 =?utf-8?B?UjZQZ0ZyUmZiazk2My9NNUxJWE9oMVdEQU9rc3ZuS3IvWTVaTU1mNlV0SHlF?=
 =?utf-8?B?VUNHM2t5cXJKZUFNV2dqQTRTV25iVkhmTjFKQi96NUxNa014T2o2MkhTelp4?=
 =?utf-8?B?Y09rYXpDV3ZXL2xscmt3OGZqeFA4dEsxQi9KSnBFNlV4NklPWGdBU0hXMUJO?=
 =?utf-8?B?Mit4RjlGUFBBVEVFZGhSUmFLTk5oYm5vR1NJQ2tIejlDSEZhYU1MNkZwdTJJ?=
 =?utf-8?B?MW5hdGMrYW56ZFRlSVlGYzlJanh1T1ZvMXhzUFlaYk92YkgreXJUOWErdnpj?=
 =?utf-8?B?ZHQ1OCtUV1pmN2NwdzNuYjdmdkVsOTArMzVjQVZkWHpIeDRaaEFJc2laKy9K?=
 =?utf-8?B?R2wwamg1eXRFaFE0c0dNSzU5dlhsejZ6MnJ1bjcwb3BmR2lvM09PUVJiaTkz?=
 =?utf-8?B?Qms0Rk9oMkVXY2srZmZaRVlYd1FpR3lVa3hzb0tKNHZCZXdINXY2TlJ5eWdr?=
 =?utf-8?B?YVVWMFd3eVplQmdBTU5GVDV3eTdhekVRWGFXUkh3cW9DbURZNWV0L3BoRVNM?=
 =?utf-8?B?M3YvMWIwdjA2REVxZG9vZmNrTXFNeUE4a1ZIbVhsQTdHc0IwNmYvQWJsOUJI?=
 =?utf-8?B?cjlqT0pXbCtkQXV0dWZlQkhsN2pLbkIzKzA2dkl1WlBkdEdqdHRkTUJGeEV0?=
 =?utf-8?Q?+A+Tv+IEQYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXREUmVza1l5VUY2UHovbzQvYnRpV3A3U0dVc3NZRWpVWnlCSlZ4VkJLdGRP?=
 =?utf-8?B?c2UyUmZveXVsSS9PYmdRM00zL0NNZU9VaEpndnRJbTN1cHE4a0ZiQlRDWHNw?=
 =?utf-8?B?NHh3RzhQeDhoRmdrcVMzUEQrR0d3Uzl0NllWNzhuUjNuT3E0aVVOcUhwcEJJ?=
 =?utf-8?B?Q0NGaWZuMEJyK2JIY0R0RTVtT3dmak5jeUQyajg2TGh2cFp4dzlQMDBhQVoy?=
 =?utf-8?B?ZGQ5ZmpvSU05L0lackl0WUpqcjl6Z0F1MWhybU84V2t4a2FGWm9WRkFsM0hR?=
 =?utf-8?B?bHkvOFFlSzZPZ1Urb3FaWkpJYVZISVlKTTJHeEtYVC92TUk4SzMrbUJZMzBr?=
 =?utf-8?B?dll0Ulc0Nzdnc0o2blpiM1Y3TkN5WnRVQjd1NWFOVzg2OWwyMVRzZVkva1h3?=
 =?utf-8?B?VWkwL005ZGhOTjY5dTNVeTRYZGVGaVFkS21HcVA1d1JUeDlSc1Z3ZGhocGNE?=
 =?utf-8?B?SXlCNlgzWmQ3SFhOYWVQdUxYbnhYZUlsZWR5UklRaTNBYml5enI2QWxuenlj?=
 =?utf-8?B?VXlKWDhqMTBKNVhPRGNOcDF3WGRrSGxqYk50TTdVMGUxYzNEa245QW0rV0Rq?=
 =?utf-8?B?Sm1saHpqT2IwcEtMaHJQUjh2QVlTTkEzUGVsZzVDS1k5aUI5T0xmckhKVkZR?=
 =?utf-8?B?MURiNDdsTERBc01xeXdtTnRTWTVUNjYrbXovL3RvMUxwWmhFTmpYNW9mNVE4?=
 =?utf-8?B?S1gwU0ZyMG5GZ1BPUUp1dUI3d2JtdmM2eTlLSEl4ZjViYXVDVWd4MnppME5F?=
 =?utf-8?B?RDMxVmNCWndqTkZ0d2hHM0RHbFRUR1NZTHVZenpkMlNXRUNmUWJBSXdvRHZ4?=
 =?utf-8?B?NldzemdPdnptNmlGTnA3V2RaMnBWVk9TOTR2ZThGenkrVVEyazA1M2lQM0kw?=
 =?utf-8?B?dmNrZVlmV3hPU01jcWJNZ0N0K1FIcmgzdEx5TGkyQXVTM2J6bmlTTUoxVm93?=
 =?utf-8?B?S2xsQ3Nwak03WVJNR3V6SXo0bFdGSE5zL0duRXpNUDhOTUR3NFg3TnA2NENY?=
 =?utf-8?B?L2s5WENxYU9EMGwwSXIxSnNmVFVOZmdQeU9sOVVTUFI1Q2J4cVdvTk5iQjJC?=
 =?utf-8?B?SEo5bytuWGtHSmRpMEphSTM2Zzh5UmRPNGRXKytkRWFsYTF2aHN1TSt4aFV4?=
 =?utf-8?B?b2Z5MjFkVXlMbWYySCtUWGhhTjdlcXV2ZVZ3bUptV05lL3paTW1EZmpGR0d2?=
 =?utf-8?B?S3hrbEJsd0N0bHhtckhHaDVnMHFsVGkyTXJacWF2R1JpRFNmazVqNnBKQlF5?=
 =?utf-8?B?WnR0eDJ4MHVvVzZMUnljM1NYeHlJazhORUxxa3VLa2YyU2ZNeDNkZ1dTQ3N3?=
 =?utf-8?B?QzlmbmlrdGtSSXU1M3B3cUxZT25ENUNXUlMxOXRtMUhkeG5XS3o3RHQvM1JG?=
 =?utf-8?B?U0w5Q1Q2KzhBY3B0R2Y0UDlkT1Q0cUxjc0dYeTR2Vy9oUHZsSDFPOTJXWWM5?=
 =?utf-8?B?SHAyMzNWYkcxNm52ZTY4UnBWSmhNenp6MXpyUkYvTldyR3FHWE94bFJ2WUdY?=
 =?utf-8?B?VGJvWTZpaEVrd2ltbEQxSE42WWNDSzcrUWY5MkxHYitRRkV2Qml6aWNpeWE5?=
 =?utf-8?B?dFBaVXRvcGdQOEdRM240ekRWdi9GV000MUJMZEFxZUc5V09UWDg0ZVRLZXZD?=
 =?utf-8?B?VnhMcUZhYmZ1L0Z1eTY4N2N5b3NCSENyVFF6NjVCZTcxcWVXbWwwSis5RVY1?=
 =?utf-8?B?K2VUNCtoaXZ2amdhZk1rMG4zS0lTdmFaZ00yYi9jNGVwckFJU1hMUDZ2TFVt?=
 =?utf-8?B?alJkcDVNYytyWVFTQVBhMXhiaHh1SkczYS9VN1ptY3JJbUg3NHY3T1k4NFYz?=
 =?utf-8?B?WmFiSGNWM2F5VHBEWU5ib2RUR3JaQWJFaTJmSFFQVlJoYUN1TDZxdVFUaGlq?=
 =?utf-8?B?SHFrdXk2dC9OUTF0ckdkeDdSVzZWTmtQeVFNYzVHdlloemZmb3piWFBrOUxl?=
 =?utf-8?B?bkZCNUdwMFpaUnR5ejgrQWxib05yd0M0Z3MrT3lBbnN1VEFxYnQwY3ltcnla?=
 =?utf-8?B?OXJxYkVReHBWa3cweDdobU85T0wwVjlZaXpyM2UwMWJ5bnIrTG1xR2xId3VP?=
 =?utf-8?B?djlTa1NuVHhTVXBwVE9jSSt6L05yMTBPKzBaRjk3YmZNdEI2NFozMEkvLzY5?=
 =?utf-8?Q?xh+Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2597a64c-1677-4042-db69-08ddf63fa1dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 23:12:11.9480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA+gVAhbJ6c0zQ49hxIOJzzCUBRSF2F5yJcYJzSp+uCI3EBFE4aVDNeGVIWNZRAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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

--------------o9ZOivE2QmUp4SSNB7iilj6q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/16/2025 5:41 PM, Philip Yang wrote:
> If mmap write lock is taken while draining retry fault, mmap write lock
> is not released because svm_range_restore_pages calls mmap_read_unlock
> then returns. This causes deadlock and systen hang later because mmap
> read or write lock cannot be taken.
>
> Downgrade mmap write lock to read lock if draining retry fault fix this
> bug.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 6604a37b304f..fb02ff9ae62a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3043,6 +3043,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	if (svms->checkpoint_ts[gpuidx] != 0) {
>   		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
>   			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +			if (write_locked)
> +				mmap_write_downgrade(mm);

Is there unlock order issue? Now it holds svms->lock first, then mmap 
read lock after mmap_write_downgrade. The unlock should be 
mmap_read_unlock(mm), then mutex_unlock(&svms->lock).  "goto 
out_unlock_svms" does it in reverse order.

Regards

Xiaogang

>   			r = -EAGAIN;
>   			goto out_unlock_svms;
>   		} else {
--------------o9ZOivE2QmUp4SSNB7iilj6q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/16/2025 5:41 PM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250916224125.29338-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">If mmap write lock is taken while draining retry fault, mmap write lock
is not released because svm_range_restore_pages calls mmap_read_unlock
then returns. This causes deadlock and systen hang later because mmap
read or write lock cannot be taken.

Downgrade mmap write lock to read lock if draining retry fault fix this
bug.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 6604a37b304f..fb02ff9ae62a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3043,6 +3043,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (svms-&gt;checkpoint_ts[gpuidx] != 0) {
 		if (amdgpu_ih_ts_after_or_equal(ts,  svms-&gt;checkpoint_ts[gpuidx])) {
 			pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
+			if (write_locked)
+				mmap_write_downgrade(mm);</pre>
    </blockquote>
    <p>Is there unlock order issue? Now it holds svms-&gt;lock first,
      then mmap read lock&nbsp;after&nbsp;<span style="white-space: pre-wrap">mmap_write_downgrade</span>.
      The unlock should be mmap_read_unlock(mm), then
      mutex_unlock(&amp;svms-&gt;lock).&nbsp; &quot;<span style="white-space: pre-wrap">goto out_unlock_svms&quot; does it in reverse order.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <blockquote type="cite" cite="mid:20250916224125.29338-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
 			r = -EAGAIN;
 			goto out_unlock_svms;
 		} else {
</pre>
    </blockquote>
  </body>
</html>

--------------o9ZOivE2QmUp4SSNB7iilj6q--
