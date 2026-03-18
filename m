Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9CC103E161
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5AE10E7C2;
	Wed, 18 Mar 2026 10:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="USpT4LJH";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECF210E7C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBIaZWHoiOoI2D0DjDcVfiYstCTaFySlACXKHyBHUq5yuwrCF5G0PuE/ZgES+0OgQAkniE84yHuYmCsb77HWKHi8WNKJ3miX+EZsmSFP5HxEaBSS3GyyXQsjhoUzxK+j9nJmlxuPQEIkbxkp34RQN7zV6xEbteGKI6iDhGg/5mVtNSXP+NOwQ4JBoCk3VVIofCAKBpneQVcmYCfC607dvIB1PvNIefmd0K8YBEob46Ytmb4f1SPV05P4Pe2QDR/40UtVvbMV+YXrkX9zpRh5ONr6OHmcWhS2/1dv5zUlUJdRRTcdX1ZEQdwaqd+ix4Ei2VgkActdhqtjrP6BF+ItrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBy1KWQRzBzhVtzboMz8xY+DJeSl3DyFlcSnNXRoX08=;
 b=Kj6d7/DPxsOoilWxDlrRDnLobAmWjX4TtDC3deAi5rhh4FRFCc35j9i5pb4NfXUZVrBNH+fYhcTWYnv2eggxCvrFziKP2hf9No8aMwdAz8C8ok+9knxz5Og3IilKYn0AuGNcCVIO4qg+gzLwwqJBI4y6g2pv/yVYtkcsOA0R30x0G43caypSFRqnlC0oGflqXyOkE37tMTKrepE1l0u1c4zJ9A68Z+JrdG8VCjCqtdE16QSZgxg5L8jP8rGKDjj0MwzMtax9KcXF72J7sW1TeqWQpAe83s78TurR704g8wYvCgL6Nt3eSJbtkYuPxkSPtavnfgqVhquQMVlLzbEXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBy1KWQRzBzhVtzboMz8xY+DJeSl3DyFlcSnNXRoX08=;
 b=USpT4LJHxghi1jGoFh2gwLgXfgE3qiijQ3XpnA9T1yzTd//wTPrVvzI1vDSvhmqJXaz4l7kePUOAeuGa/xYv/0J9Y9vG9pfn8g7Z7QgmYed1mLb2SsP7zi0YsP9isI8cTZkywSfRPRHPfoWCQ2S4u/u4KZGrf0NaZ5TYS+3RFRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 10:54:24 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:54:23 +0000
Message-ID: <6c4a19b8-ca0d-40d3-a9cb-fa9e28fc82c3@amd.com>
Date: Wed, 18 Mar 2026 16:24:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add support to query vram info from firmware
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, tao.zhou1@amd.com
References: <20260318104609.1739924-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260318104609.1739924-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9831ab-7b60-43a4-e009-08de84dcb736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: eRDM1hHpxaIn86562Bdt2MfqkWrMi4ooWi+/aL5BqBY9pvk/6fIoA4kZ5gGVEjKJgjb5ttUl4RcijIoDKQQzUoARBcNk5TIInX4Nj5+qDHp1BPuIurpr7zT1WnhzTC460jK9Kuf/LA1Ex7o42J6MAhPTO0vpoS/5VCk1BGzajId3p/IKjzE6IcR/Cr5pCkV0RT4+J9uK+N0T9lki1uIgPgJSymZPS0sOdQlUXcVSrBUYWilrnV7HLCxwgt0yMMOi9kqEIM8hUBNfraaDTBH3Hro4yJivN2q0fK2M6zndTst5t9sZ0DtABp4h7XpOBOlyq5pv9SqwCt313+tkxw1uwrSS5Y12bksZGGY+mJU6daTdQVh6Qkp8nvNMuu3ptnZe++y1HWUJFgpAlOxJXf23GST82KFBHJJKtfuXvcuWitNkz6kGyuZSNgUIEkR+JS+HHnDW/szpl5ssag9n4uKn7/09vfs/GILpUnR0OHdECFDZC6jeDnWb/8D1LW8okr5StEoeOnnXaA0izjsHb+91Y6NH0v7ckbEPjggYG0r4yX6h7V27a9fniIFunTNEe87/C1WLM58QZE9vkyg21z7+uScJZM2YwXsenhgC/TIc9A6JoLELega+F/vPhyHXpPBMm8cG8ByYsK4pjKNDbHDrsz1zLDyTp3a+B+Z1YHZETBBaEypoUKBeeRhcIcvVWG2eGetUALSq8gL8ZT83rUSws0jtob7/oOM1f8QBb74fdwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDkwdHJQb2pha3pFYzMvN2RmenRGYy91NGIzR3plVDhSaEduU0dOdTRPMi9t?=
 =?utf-8?B?MEE5UkdxSzhLemwzZ2lIVW9rZU40VHcwOTArQ0NVNi8zcC9OSHhNQmcvbE9Y?=
 =?utf-8?B?UVlHTkw2alFiTG4wUmJkNEtSZE03Y21lV2lQczJWbzdBdkpQclZJQ3FIZ0xM?=
 =?utf-8?B?UVNqb2tjU3dGQ2ZDVGFocUQ3LzRDVjNDWVh6dG5QYXdFZjlpNU1pQUtjalNm?=
 =?utf-8?B?RFpMdkxhTEVTRHc3UjJoa3VMZDJhSlhxUk9maVZtRmZOT2tuNUF3VG15WHFq?=
 =?utf-8?B?RnQ5MVl5dU0vUVRiRVpMdjdjZlMweHFHYWx1bGpYaUVTeE5QNnk4S29oWklz?=
 =?utf-8?B?QVhxa0FCQVZBVmx0Mkh2TExQRDl2QTJGNE15MXNyUVBlVXF5Y1dSZks1VkJ0?=
 =?utf-8?B?NjBRRkN0aWhJcithTUh6ejA1KzZjZEx0U1ZENmdEOW0vcE9zeTBTdWRoNmFI?=
 =?utf-8?B?bktWaElGZkREdkF5U2c4Zjk1a0FDYU1vNm80dzRkaHl1dkJuK0RscWE4WUN3?=
 =?utf-8?B?WXAwRHlTTmQyd0hMZ1JXS2k4UEdsbDRvMFZtenZ6Q3BUV2xVNGs0cXRNcnFI?=
 =?utf-8?B?V09jUXlWVE9GNnVkc09GMTRhZjdmZzdpLzRVR1ZZUDdORkZpdmIrL1VDd2JC?=
 =?utf-8?B?a0tpSy84Zm5pSEZYY1JZelh5aG1GNFUzWFZvMUs4aG8ycHZDVmZESy9UdkxD?=
 =?utf-8?B?REd0ZVhtdGk5N2JSeVlrTjk0K0duWnEvais4dFhMM2hqMUZ2OTRRMWxpOHpn?=
 =?utf-8?B?TzdCWGV2aDJUVDAvazA2R1VsMlllNWRXbmxGRlNDUXhlRVhiT0ZwZC9VUDRD?=
 =?utf-8?B?Yy81OWFiMkFRYjFHdklBZlJYSk5SQnNob0JySnBRblFTTjRDSHhTMHdkMDB5?=
 =?utf-8?B?T3JNUGJsR2h3QmxicGtwK1JlbnJIUlFialdKeTc1NGlTdFRCZ1lja292Z3FL?=
 =?utf-8?B?dThhVHJXMS8xVUFkRmZUK3QvWS9ta3pjNWlEMW9OZ0djSDVNQjRnMFM5Zmkz?=
 =?utf-8?B?WFJVQU5GMlUycld1SldUbDFvU0VsMEpBZGZSVWJ6bkE3TnRBM0pFWTAxcCtj?=
 =?utf-8?B?Y2ZBTGRkUUtLZWdOMHJtSG9OUTRWUXgzQzhGTS9GMm92OW5pNlU0K0RzTnhH?=
 =?utf-8?B?VlFFTmNyYTA2WHZEWW5sdmlJK1h4SUpEd25RbEE4Z1JqOFVBRXk5YS8yWmtT?=
 =?utf-8?B?Mk03ZEczZ1l2T2hFcEJIWFBPWThrYndkWGl2TG1kWUpvbCtSVFNjYzZZQUt2?=
 =?utf-8?B?dDRHclVzSWx1WkhDWklhWTc3RGhVRzVZbWtCcmh1eEFzVnVMenBhWUFpK2NZ?=
 =?utf-8?B?ZlUweE9tL2dLOERlN2hLQzE0RXVwb0VRaUpmUFRHbTJTbkNBd1RkV3pydE5a?=
 =?utf-8?B?aWN3emxQbllqT3lGcjNsbmF4OWlKOE04Vm9YUzhmNHpiQUs2dDRyS25pcEdI?=
 =?utf-8?B?OEJkaXRoMEhyYkhOYUhhQy8yODA1TmgrSlYzRTJEajRML0xoMUk3NXdDWFBV?=
 =?utf-8?B?OW00YThnK28zemtidk94eHJDQnA4ZmNpdnBmOEtuQmdMZ2JuNy9tRGYzQUpL?=
 =?utf-8?B?cFZ1MW0wOW56YnlxZWZFRDRqdnpzMjVqaEtjYjl4aDQrNVVtQ2tFOUlDUDlM?=
 =?utf-8?B?a2crSU5sYzVSYlpBL3VHZ3p0LzI0dFY1cEhSdUE0MDZveGJiSTloSzNPKzhE?=
 =?utf-8?B?UXRrdHlCZnR4eEVHaXBsTHpsMldQOFNzcExRK2JBUmo0cUFGQlhKTnFwcWdZ?=
 =?utf-8?B?dkQ0NjJqOXhtRDJ2blBlSVBNU29NR1JOOFp4ZjRwZjZzY3QxTlFVRTN4SUkr?=
 =?utf-8?B?aS91UllMaHNjY0kxOUYrQTdxb0t6MGFwRGUzZTJ0K2JlVE53ZTNxR200QzNp?=
 =?utf-8?B?OVBvYXRhYjMzSHFyWTR0Rk9UZWs1SS9GekU0bEp0U0xRZFAwcjlZaTRORVZu?=
 =?utf-8?B?Q0NmS1JsQ0xwclVLZHBVR1U5VDEwMWQ2K1J6QW1wZUZzRExlUnZtdUhTblZ2?=
 =?utf-8?B?WTFLc1E3K1BGaERtdE1tUmtqZzRtaWRJdlNzMXp2b0ZwZWQ0aXNxbEdJdXBN?=
 =?utf-8?B?QlZoVzhxWTNVblZRazArRk1MNGpIeXZVQXNFSndOT1didXVYSlBJdUorbVY5?=
 =?utf-8?B?WjNSaUlidjJSYzVFY0xBekd1QzhiN2U2RllhdTFveGZIOG4rT1hEOHpxdndv?=
 =?utf-8?B?VHBkaHpxbjY3M3J3enRFcENaNUl0L3FBVWJiaTlvSWowNnMrZUFKTkw1cTRP?=
 =?utf-8?B?QnFycTNNeCt1T0xHRW93TzU3eWY4Y0tYN2Q1Y3ltTEpLTzZDUkZxeTU4Y0hs?=
 =?utf-8?B?YTBnM3ZlVno5ajdhY29PcXRvMGY0dER5T1k4Y0VhamV3V29kVDhJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9831ab-7b60-43a4-e009-08de84dcb736
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:54:23.8805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr5tOygCD2U/BSLQAGYomLlTA7RZi6G4GmM9M5WSQxeTxqZjeaik+GUVNu6tgB4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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



On 18-Mar-26 4:16 PM, Gangliang Xie wrote:
> add support to query vram info from firmware
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 16 ++++++++++------
>   2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 7f4751e5caaf..712b0588a359 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -399,6 +399,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   		case IP_VERSION(12, 0, 0):
>   		case IP_VERSION(12, 0, 1):
> +		case IP_VERSION(9, 5, 0):
> +		case IP_VERSION(9, 4, 4):
> +		case IP_VERSION(9, 4, 3):
>   			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
>   			break;
>   		default:
> @@ -475,6 +478,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   			switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   			case IP_VERSION(12, 0, 0):
>   			case IP_VERSION(12, 0, 1):
> +			case IP_VERSION(9, 5, 0):
> +			case IP_VERSION(9, 4, 4):
> +			case IP_VERSION(9, 4, 3):
>   				umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
>   
>   				if (frev == 4) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e35ed0cc2ec6..02827afaa365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1806,6 +1806,7 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
>   static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
>   {
>   	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
> +	int dev_var = adev->pdev->device & 0xF;
>   	u32 vram_info;
>   
>   	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> @@ -1818,6 +1819,10 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
>   		adev->rev_id == 0x3)
>   		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>   
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +	    (dev_var == 0x5))
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
>   	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
>   		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
>   		adev->gmc.vram_vendor = vram_info & 0xF;
> @@ -1836,9 +1841,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	spin_lock_init(&adev->gmc.invalidate_lock);
>   
> -	if (amdgpu_is_multi_aid(adev)) {
> -		gmc_v9_4_3_init_vram_info(adev);
> -	} else if (!adev->bios) {
> +	if (!adev->bios) {
>   		if (adev->flags & AMD_IS_APU) {
>   			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
>   			adev->gmc.vram_width = 64 * 64;

Keeping this as the first option doesn't work for MI300A APU. Also this 
doesn't work for scenarios where VBIOS image is not available like 
passthrough.

Thanks,
Lijo

> @@ -1846,9 +1849,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>   			adev->gmc.vram_width = 128 * 64;
>   		}
> -	} else {
> -		r = amdgpu_atomfirmware_get_vram_info(adev,
> -			&vram_width, &vram_type, &vram_vendor);
> +	} else if (!amdgpu_atomfirmware_get_vram_info(adev,
> +				&vram_width, &vram_type, &vram_vendor)) {
>   		if (amdgpu_sriov_vf(adev))
>   			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
>   			 * and DF related registers is not readable, seems hardcord is the
> @@ -1875,6 +1877,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		adev->gmc.vram_type = vram_type;
>   		adev->gmc.vram_vendor = vram_vendor;
> +	} else if (amdgpu_is_multi_aid(adev)) {
> +		gmc_v9_4_3_init_vram_info(adev);
>   	}
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(9, 1, 0):

