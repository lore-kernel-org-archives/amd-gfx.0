Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE890C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A12410E0BC;
	Tue, 14 May 2024 06:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGeQ1jZc";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF3A10E0BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaAguJTl//ijYs023gOg/Mk29giKhKuZDvfRnR6RAJSRwKLJAlK4r74DsgwW0N09uUOvqs0ZysxIfZ43P3TX/XE1+q1SpFLA7ADoc6JUcb2IfV35DbS5xfuqw/XQqWe+OUem5wSyJzpIGgbRx0PxXeNo2uK4Y5vJJGnzal5y7YYXLxqZfph4HE86Uvg5WmY4t0z7p3BeeEjVI9QfhT+BawsE01uDO3zwyFJOXZ+0ghkmneUaJqG3HW6bDJ9xfctwprWNCOXL8YrHBbddYW1pwAmG/O2jqHEZVWnKnfMMAmDcIW4eSFMf6WQ2GezxsCyYwWDN5VWYhWsEMVrtnJ6rOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vUlyjPMfDgMX9SchHsBByXSg9kPYnb5bdHDe29IQYk=;
 b=PgvYJcxoV3ML1ewoGR/cVWJ9iCMwstsb8Cn08/bgh9vQPFPM6VNTcK9qNZ7RJ53VFmsCFdZdCbTl/iC+2Xax6x8kiK3+Ldf6GC1atiLGjvDCEvZMWir/h+b07S2pMz4Mca14yZyRyfJ4eDo1UesbsXDNJR4OfLKB320QEMGcNWeu9hO1WG5d4arb7zUWBmq1gpSNFq7VeYnxMXVeRtU2iDpHQQIpOMXJTsrSo2OldZBnsixcGIENsO7UfQQ+KCmIUWxZofOkJoiKMwSRdNJWhaoNJNjIEL3HGjVUWiueIC2ZyVyT7WjMcpncBBlMXuotm/lX6+W2wfEtVTXvexp0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vUlyjPMfDgMX9SchHsBByXSg9kPYnb5bdHDe29IQYk=;
 b=tGeQ1jZcWxuDN4UnEPdUY8xk1SFAXBb++MJnf1YCWiJMPTRAKeDDYxI0SfwFDaQTj/fqaPpI5BOgCd8S+lIFzsmQQEYMjEwL53htqLDxYGr8mirOa4QE80dsm9BnnXPTWAkCN03M2g7iAZyi2EDjrkomu8ilOLOi1YPyPjApoVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 06:06:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 06:06:59 +0000
Message-ID: <649af63e-99e1-4653-b5d0-72938171a94c@amd.com>
Date: Tue, 14 May 2024 11:36:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: check specific index for aldebaran
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240514060451.3649916-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240514060451.3649916-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad67a74-2df9-4f1c-9a49-08dc73dc1081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVExY3Z6ZlVOR3hCQlJaTmxlQ0orVlZnTjMyb3F4VkQvelIyL3BUaXNuY2lD?=
 =?utf-8?B?SFpxSlIxNVV4bzlTY012ekpPMjROeS80YWNiK3hHMVNGQ0pENXREWWJ1OXBw?=
 =?utf-8?B?Qnk1OGxaU0tWZ1JTbHZnTkorSUs2bTJsRnRJZU4xMTBwclovZ2NVTHNFNi9I?=
 =?utf-8?B?VlVlelVETVlLTjJMY21WQTFLSmpFMHdDQTR2V2c2WnpHN0cxd1N5dHNEUURJ?=
 =?utf-8?B?V2lrWnFvVzFWTHZvNTRUdGJMcUVkdk9wcGFUTSt2aDVNdEFOZTVUV0hzdUpI?=
 =?utf-8?B?Q3h3MlIyZGJFcktwZ3czNzh1bzVIajlqVy9uNlp5b3FuQWpFNnBCQjRYaFdF?=
 =?utf-8?B?dDI0VGFMdHdnR3kxUTVjVExpbENXSHZvS05Va1Urb2Ezb1N4THdmcGJ6QlV6?=
 =?utf-8?B?eEExNWpGS1cwVDM3dVV4OFhiSEJYVHFyaXUycjhWYWJpWG5yNVN2Z29ZTmtw?=
 =?utf-8?B?SUFGakZiY2ozM21jazVaa0k3OGlFT1p5b0plTGczbWg2Nm1OK0pWeSt2Z2dC?=
 =?utf-8?B?bEh2RUxBRGdYV1RNai8xNm84NDlDVXRnaEN5VGRUcERNcjlCY1lSMHNWbjNO?=
 =?utf-8?B?Ull1M0JsTU5ZUGw5TUdkYnVxTHl4VHMwb25IbzRFbFVaeVVjNEwxOUR3ajFv?=
 =?utf-8?B?QWVxbGNvclh4ZUFORXV4SUZZNW5MNERid2hVaVNZTnRnaTV5WmNqQlZ0WVhT?=
 =?utf-8?B?SUcrNTR6TkVvK2Z6UkM3UWZQMm4yY2hIaDhjYmtSNkZjd1ZzcHBNeTc2S0Zy?=
 =?utf-8?B?K055ZXZXQ3RxOWZBU0x3MzVFUnM4MzRvMVQzcXBWZ1JubUZleThEbGtoTjYy?=
 =?utf-8?B?eEsya3BhY3diOEZOYk81anFIM014TU5QMTRVTUxQdThQOVkvYU9BdFlJN2xp?=
 =?utf-8?B?QWRZdGxLdzl4b042dTNCYkdRZmpuK3RHQWNibDBROVBQbE85T0k1OUVnTlh1?=
 =?utf-8?B?Uzg5WW1teG9WUTU2cmM4V1JrTTVJSXVpWmo3UlhqSTBiR21waWpnNUx5c0R1?=
 =?utf-8?B?WjdzWmhwMWl4OUtaZGtveThCZDZrUzdDUEx3ZjE1UzRUS1FxeVJVZjhHalA4?=
 =?utf-8?B?aUx0d1J6TjBVZ3ZlREN0NlZsY2F1ZG1ndGNTYkNWM1ZiMXZ4eWVLdlZzUk1v?=
 =?utf-8?B?eS9weXZLWVBvSC93dFNMYkphTjZiQVVhMUlHVGhZUG9tUUZyNXhkYTNpc0ND?=
 =?utf-8?B?SERxam1hSjFHNUo2UjhDNXEySDZHcm4zaEtvTVE4OWZVRkFTeFIrK2QzN1RX?=
 =?utf-8?B?MzlKUS91K0Z3akZYR2t5TldOS3R5RnNzTExwSGlWYk1wbDdLb2JmY1VJYkV0?=
 =?utf-8?B?bUNQYWRVbnJPcEdIWFBZWmZUUWxRbFNaQy9rNGl5MU5CSlRWYW5KQWtqaGh1?=
 =?utf-8?B?ZURjYW5JZEYwUDBEMzVmcnRJNWFjblhqRzVmUml1WE5VdDFmOHZ0T1F2c3hF?=
 =?utf-8?B?YVFHNnVMb0RKUEJwRzE0N05WY2dDYVduK2NKTGtZQnRCSXAxVFhQdlVKNzQw?=
 =?utf-8?B?a3JWRWRTVnJ6NXV3ZXFFdyt3NlJoemlIdGdvMFhCMFBEL1UvZHlhSHFxR2pl?=
 =?utf-8?B?a3hkM3VnRFNMeGQ5OVV1enpQcEowbjZlU3RQNWRlUGlPQVFuZGFFTkdZYnJ3?=
 =?utf-8?B?UXdFaFd3bEFCWHgyemZUMnI4a2h0L3ZscWpvd1NNK3cxbC9EcGlnUzBUc3pZ?=
 =?utf-8?B?dElMczZqRXFuNE1RbTAvQTV0S1lWcGFiWkRIRXVFbFNrS0pmYjlRMzF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJoTHcxekZXTGt0M2Z2Nm9vTm5VNWp0RmtBLzBPTXp4OVhIMkp6TWRUcWxG?=
 =?utf-8?B?ZEJYV2hySDJ0TFkvU08xMW9CbEVYQnZXa0Zqem52aUppaWwwbE1QTEdFVGhx?=
 =?utf-8?B?S0RKWDY2dUJWUXBtVzlic3FtN0xkeC9kUHhualBkTmpIa1lyTVFDQkxBRUZm?=
 =?utf-8?B?SkJuOWhBdHpSTkxiMmNZWDZuaXhGbzJHdDh0bm9ESG1xdjFqajNIR2syRm8y?=
 =?utf-8?B?Vy9pd1E5ajJOeDFXbW5OakxhRmpjaFZDM3ZXRHE1YTFvRWc2NXY5bGpuWkRt?=
 =?utf-8?B?VHJPcGFPTG9pQU5QWmQ5a0hLQUdSeXEvMDZEQkRnR3ZJZDlXc0cvRzR5K2t0?=
 =?utf-8?B?dC9Oc21IVzR3ZVBpdXFFbmE2TGNJQjA3RnNlODcrKzIyRTl0aiswTG5uMml1?=
 =?utf-8?B?cm1yd2dsUUZ5alptck5idE9oY09mK1h5UU1QZjErazFsMzB3OWdBWmRRcG9L?=
 =?utf-8?B?VExRdFhNTm15V2tiU1VmenU0blNTUHVvOXNyVDUyTnE3WVo2Z2FzWmg4Zmo2?=
 =?utf-8?B?OVlzcy8ydExERUp1cXdUQkVpMFgraFF0U25QdnlPU1JsMHhTcHpsekFxMVhE?=
 =?utf-8?B?SXRDUDBGemRkY0t4em90ZGJUMjFXeXpoMmg4K0tHaDhVdHNJdUdreDZnSmFX?=
 =?utf-8?B?R2lTUlVWd2JpdEZiZXRpZmZvamp2SU12cE5vRVRCdFZLdlZDc2FINFBGa3dH?=
 =?utf-8?B?TjFWOXQ4MlFPL3pMNG5hUTFwbSs3RGhSZCtNUnByNlZGV2ozQmtadGNGSWtx?=
 =?utf-8?B?RnVWbENwNmlnZmx3aWVLVldVNkQvb0tFNGhmWHlGbkgzYlh4NmVOTEZOcFht?=
 =?utf-8?B?cTV2WnpiblN3a0VvaWV6dmkzdmxkMTVOSXJkc3NoaVpKWnRaUW9oRGF5NFFa?=
 =?utf-8?B?UXV1cHd1ZXpSdkIzN1haTnBpN2dEc2IyNUx0K0Irc2NaZ2RSNWtPSWVPOGtm?=
 =?utf-8?B?V29kbnhMaGpHbzZENjZFdG4yN1R2UUQ4ZlBzWjQ4bHhBMlBmcDUrTFZQem42?=
 =?utf-8?B?V1RSUE5TbTNWbnpHNTFWTXJjam5ESzlzQXcxelQzYTBFRXdRS3BNcVc4Q3Y4?=
 =?utf-8?B?NXBVenRLZFV3cXkySzBGSFhNbVNSZGJNUVZqekp0VDRvWFpmZVVjdityaU5X?=
 =?utf-8?B?Yy9Uekt3UkE3Z3d6V2ptWGp2ZEZrdFZMNnovYTZLSGo5aXNBOWZyZUMzT1hl?=
 =?utf-8?B?N3dFUFJINjEyOFlqNHdsQ0VTMkl1bUM0WnhhUVN0dnBHbWxhYzFJem5XTW56?=
 =?utf-8?B?ZnQzTHVHZWZsTzVQeEFLTUJObkFMZVNESjlmTGx2c2NuajRtRGYxajJYMWNm?=
 =?utf-8?B?NWxBdS9WODF1eElUdHJiLysrYmFPNVF4azlMUEVCclpaYkN2Q0ZycW5zTFMy?=
 =?utf-8?B?RitSQ0JIUlpZMkdRWTNYcHhxeFVSdEtoclkvRGREYnJIZUUzbkQwKzIxOVRr?=
 =?utf-8?B?OGJEUy9EL2FxSjJqYVdnNEpteGdZanVrM01FNXFtSUJKK2VhbVpNSzhpNUNz?=
 =?utf-8?B?OFVvYjFGTGNjQys1Q1hFbmplSzQ1aG9zUWJoaEcyS1lSd0RvY2s5Ny8yVGZi?=
 =?utf-8?B?YndLK3NkVU1BaFFlNyt6QWE5UzhkcWVpSTNGL0JWMHV6a1RoYXhROWVFQnJv?=
 =?utf-8?B?VTRhR1BBWXoyTlhWdTBqb1VPZk9Xc2tYc0NiSVMxVjZaUEhKV0hNUi95bUFX?=
 =?utf-8?B?bEtQNVphZ2lXWlErc3UyM212SjBJRmI4N1Zqa3lMckVrU3ZTVEU5a2hPTDIr?=
 =?utf-8?B?dDFieVdEeUU4VWZtNjgremRmQVIzMTNQZ0hrRUZESTNsWUpkRzlNa09IV1Nx?=
 =?utf-8?B?UzBUSWVqeU9MMU9WNno4TTFIcmFnVHhEdTNwTjBuNDZHRW95c1MvQXlFa0Jh?=
 =?utf-8?B?UzNaeGhxc0Uwa09KUE9QYlE5b1EyZ2xub3lJcmRTaEhYUVJNTktYL3hKUnRC?=
 =?utf-8?B?elVsWTF3YXBXdmljcVZxeHQrVGpiMkZCaSsyYmVqa053WGFsYThqQWpJUWNV?=
 =?utf-8?B?RVNZSWlDUUdtb0JpWUptRURXaW1vSE4rMGJWTVUybHNPakxuZCtBUDJNZHc0?=
 =?utf-8?B?bHFoa0g1ZW9wdGtEaU5Pd21HMU1EeGkxRVY5UkVnQ1ZIRDFFK3NXRmxLdW5a?=
 =?utf-8?Q?HbGjo47OsQV6/SHgVan3lNb0I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad67a74-2df9-4f1c-9a49-08dc73dc1081
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:06:59.0527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvxI/vLezON/o/7sFMC+qJezlGDockxk77ItkqW8PvLvpmirXjG7qM5IKuDgolpz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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



On 5/14/2024 11:34 AM, Jesse Zhang wrote:
> To avoid warning problems, drop index and
> use PPSMC_MSG_GfxDriverReset instead of index for aldebaran.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index a22eb6bbb05e..d671314c46c8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1880,17 +1880,18 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
>  
>  static int aldebaran_mode2_reset(struct smu_context *smu)
>  {
> -	int ret = 0, index;
> +	int ret = 0;
>  	struct amdgpu_device *adev = smu->adev;
>  	int timeout = 10;
>  
> -	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
> -						SMU_MSG_GfxDeviceDriverReset);
> -	if (index < 0 )
> -		return -EINVAL;
>  	mutex_lock(&smu->message_lock);
>  	if (smu->smc_fw_version >= 0x00441400) {
> -		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
> +		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,

PPSMC_MSG_GfxDriverReset is different from SMU_MSG_GfxDeviceDriverReset.
Use PPSMC_MSG_GfxDriverReset here (for both patches).

Thanks,
Lijo

> +								SMU_RESET_MODE_2, NULL);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
> +			goto out;
> +		}
>  		/* This is similar to FLR, wait till max FLR timeout */
>  		msleep(100);
>  		dev_dbg(smu->adev->dev, "restore config space...\n");
