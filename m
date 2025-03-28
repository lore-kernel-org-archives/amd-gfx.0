Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8010CC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 04:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1643610E00C;
	Fri, 28 Mar 2025 04:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E+P3NhyU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21BC10E00C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 04:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVPwsy0xN5JKWkVJJ3A1du6PT+S0409mLVMvV5wGcBVxjLgELWPILXe29G6oGW9nq54N3XV7CRMMbfsVb0ZV+nJx2ui9Dh+2dXLJSb7XLfuMNy/aJaKGKXLKPfu3tSuZ6oADJyYkrF7fQLz4GqrJymxPLPu4LvbithI4KmwKZO/TmlczKhmKtcjscB5nZ1UiEbdK32QWZiKl3MS85laNlLdVNKXim7gjTeKi62G/SV5n+kH7hMSbZyYd6P2/HkGer+lCguTD7UfDX2dmkdGR0ak9v60XVEwgfEA2CKzrNKNuRmn0kdxfgW6u2TKrcUfEoQCVNLY2aIDKkiR/aIJj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vpRoW+v3nE8171/7FrnZTdfav3FOLMfZ0DZLDEgsrE=;
 b=Kw1U0LW6ndtNP59wsgrd6+yAc35UwJNRZh/vkyoChNhdkOIf7db/dfaEzxiEQZr76Ktzyx+6JFolID5s234nXDLIDNCLS6GB8RfVY9wMn8RFgxE9EngcZuBM7uHHpEWLZPW49a8kinAgSQQxT3lOg0S3yfIeD6tPazivIoEOL/gmNEdWgjSzzEGvxJZpIhiwhLtsTeXY3L6zeYEyIyZF4jhAVnOCAIPulHBmxlTkZsd15dYfQz6jhAfw/f/TAaRenxXowyg8YwS5LY7nXxRGoIlNtPwUlRYsSvjn2gz4cljCQQL57kPl409oUz0UV7HzTddcp+c6cPYxaX9tHTb13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vpRoW+v3nE8171/7FrnZTdfav3FOLMfZ0DZLDEgsrE=;
 b=E+P3NhyU9Wea5GM3k83WCY0EIt5SDxEF2101Zzai2WIJV/GesGn1wLl8VlQY30oUOq1XNovdNHG4zceTT93248CQ4aMzLuV6VWZQDTJOA4Ypa1+/Cqnkr6yp/pC1XlwFjSq3XCWllCYjA0Ta0chmX4bd0V8ZLn6KKVsjAgsnPe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 04:05:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 04:05:36 +0000
Message-ID: <6147f825-536c-4e4f-8b5a-afdc97120946@amd.com>
Date: Fri, 28 Mar 2025 09:35:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] drm/amd: Avoid showing an error about memory
 allocation in amdgpu_acpi_enumerate_xcc()
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20250327203858.3796086-1-superm1@kernel.org>
 <20250327203858.3796086-3-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250327203858.3796086-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f05ed0b-2ba6-438d-53e9-08dd6dadcad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWZYbVczbUx1YURBR1J1ekt2NEk3bU1HdkVrRzJDclo3Ym1YSDY3TW5RaDJt?=
 =?utf-8?B?aG5vVDFDa1NHb29jb2s2bU5VdVN1UUtudGkrS2pSMnZ1enQ3djhIL3BWNEdN?=
 =?utf-8?B?K21lcWtvM2RKV0dKL1RSVzFHR040NFJNRjNiMndDNDg0dkVoeks5KzVNQk9v?=
 =?utf-8?B?M2tUaTRnRTdrc0o4eSthditkQWd2Z3FyN3FobUUyNkovVis0YndQeFlUMFlq?=
 =?utf-8?B?c0xIemdHM2J3YUVYQ1ZZNFdzNlRhSkZyRHI4OWZ1OW9qNTBVVm9tVWxOSEVa?=
 =?utf-8?B?c2k1WlpiK2VUd2NndnVDWVk0S0M4RzFGNTQrTXBadHB0YUNHd2Q0VHFnWTUy?=
 =?utf-8?B?TzVUd2dQenBRWkUzVHBnR3BoWUZLdnZPQjg2VGJvbDhLekxVTEJZTVlCS202?=
 =?utf-8?B?YmRxd1M3amUzRVlXUDEwKzJPNjBhOVl0SHl6aUllWmtBTFdMUGJRNzBzWENi?=
 =?utf-8?B?Y0tKN295aVBXODJHOVRtN0luYkExblhUL0tGQXZuN0ZCSFBtekRzbFhQTDNU?=
 =?utf-8?B?SldiTkswTVRFMlR6cS9ZRlMyQlFnR0hVbTdYa1pvSjZsWXhPeTFFRnJwQ2xj?=
 =?utf-8?B?YWJjdnY1TmwvYXhBSWFTcExNT2VsY01rNDdQMDdHeThITEpZTTNyc3FGNXVJ?=
 =?utf-8?B?cXpIL1JHa3VacnlBOTBvRFhyeE9VeUYxU3dGbllDSkxrTGczSjFrdnZ1cThC?=
 =?utf-8?B?Ly8xWnVnMytodUg5aG4zQ1RFWW1EVlg3RUd1MVRraFZGVDRHOTd6WStrK2Ju?=
 =?utf-8?B?ekJqQm1obGFMRVBUamhKZFRWanRvbThoM2JEaGJsMkdJQnErM2xCVDJ5UmE3?=
 =?utf-8?B?RjNXRFZpSHAyRGs1WC9VdXQ0Mm16eEVTOTE5OTVSU1VweFdXYWhON2I5YlRR?=
 =?utf-8?B?UVF1ZWdkSHNZVTZ2ZHBXbDNvLzNtNXlaWTBKSmdwWk5XVDlDUmdJNXp5QnJD?=
 =?utf-8?B?RVFvS2Z3Q09rdmVlYTNoOXN2eWxZTnM2cjB0QnRWZVFSOW1CVDVoNThaN2s5?=
 =?utf-8?B?NSs3UndBWWdOZlJNRlBIVm5lNUFrN2F2L2RXTjlxQXdnVFpwSTVwQ0VnTEE4?=
 =?utf-8?B?TDhjUWpHN29GT1Z1aWFGYXB1dlBtc2xNUUhNbWhQeEM5a1ByTmY5Ky83WVJM?=
 =?utf-8?B?WjNlbDF2SG1UZW9VMUNuU1ZqS3c3czE0aUhNWEFIRWs3cEFYOVNwOVdPUEpG?=
 =?utf-8?B?bjYwZFIzZW1MQnM4dUYweWlKSU1aMVh1TUF2c29hV2JJSS9CWDRBbUszRFBH?=
 =?utf-8?B?SDllM1liRmVyYkt6UmNmVHYxalRkZW1lUlA4S2Flb2NBQ3dIc2FQL0o2cVFt?=
 =?utf-8?B?bC8xQlA2bmR0S09xazV0c2VmNGc4aC85TVltanZSZ2JGQldjc05QUlpDU05n?=
 =?utf-8?B?NURLeHQzZEFadTVoaE9GTzdHK21FM3ZIVXdKc0lTaDhGUzdmZWRVTDU5VUpE?=
 =?utf-8?B?SVlWdmo4YVBzMmdTNGcvTXJMQ0hsSjg0RDNwWUF4QTY0QzlGNmp3cGh0NDFV?=
 =?utf-8?B?TTl0SkhqOUhLWGNBTTJPeDhhUDB1Yno4OVA1SGx0Y01IZjhGekxsQnI4ZWM5?=
 =?utf-8?B?KzFjSHdRalVIdE9DTlQwTWRpYWM5Nks5WlliL0Vua1BPYXhKU055YzY1VUFM?=
 =?utf-8?B?MkhnQmFCcklnVyswaExoaGoyaGk4WFI0VHZXYjJQS1FvUW1jVTJTTTF6MU55?=
 =?utf-8?B?QUJwNW92Ull4Y2VGbE9YUWZ1TFpkVHgxenBXRUNCYVJxV2FPVXllOXpkQUxI?=
 =?utf-8?B?UE0yVnJ0R0JwNFBEQlNiMmN5WEFSeGFYd2J0bkdDNTBVK1RPTE43VysrWEtE?=
 =?utf-8?B?QmxUSHlHK0VqWjZ5STJsSVlvWlpIYUZRMEVZK3JjYUExZjlEMjVPUXN5QW5k?=
 =?utf-8?B?aUxBbnE4RDNpQ0dHMGdZVitQWExPVitlYjdkUTU1ZVRGajI3dDlhNGNOeSt0?=
 =?utf-8?Q?5nYuFMa2ID0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JQRjZRYkZLb2hDTlFRWFZ5UER2N1ZURk9LallaOVpEWUlsSE02ajhYSHFB?=
 =?utf-8?B?dEtUNFp6WlNBVmpCejNSUksrd1lSRGx2NlFoQkhvQ0RUb1owa3RjSnl0N1RV?=
 =?utf-8?B?eXZtYUJub1N1TXlLdFJWTHBML1Z5Q1pxaHJSZ3JVMFdLUFcxYUlqOTk3L1Fu?=
 =?utf-8?B?alhHUnZuZ1lKUFZwdG5DOW5UcTVsM0pKVUVick5Fd0tlZTNkVGpCOFpUdHhE?=
 =?utf-8?B?MzRWQlI0UVpRWFppVU1MYjFQZ0VCSFBSRC9ELzdZS2w2RkJXN1VRMEtYV0gy?=
 =?utf-8?B?ZjVwVllJMWFjTVNLK0llUm5MSVJoVlNMWWpkZkhmZDJpb3lBWi9VUVNZb1hT?=
 =?utf-8?B?K3FpVy9rTkhiMGtIN2hGbXNaNDRiSHdJbER0SCt1em1kZFRlUGVPZ05sL0hK?=
 =?utf-8?B?WlNpVys4WlgvbjBqRTN6NU91eWVNeUxSWjFUdGFuMkFCeGwxQzhLanVRL1pq?=
 =?utf-8?B?b3dwSWdlZHFEUjFrcXZ3dzRiTkpPL2hwMFFwUTB4QTZja3V5cFdVS0w1K1pR?=
 =?utf-8?B?aEV2eE14WG11K2Z4N3VzNHpmemxQSkRUVGxXQnZCRzUzRVVDZkVxdjI0NGtR?=
 =?utf-8?B?RVJlTVE2RVBCY3lGWEhOcjl6SFNSZTA5WFFzOHdMMGp1NDFqbXRJckhUczlV?=
 =?utf-8?B?ZUFPWjlBTHJ5OFhrd05RcTU4dEVnaHVTOENGa3h3UWVlNTd0bjRqT0xYVlRP?=
 =?utf-8?B?S1E2K2dwaWZmcEZzSmN6YlpFMHhHTExDQWF0OHYwYnBHcHF3OG9SWkNTM3k2?=
 =?utf-8?B?cVhqYW5KQmZoTEdCREQ1ZkJTN3ZxalhhaFlESlJiSndhbHFubjEzU0Nnc3FD?=
 =?utf-8?B?dTRaVFlkUGhxemNNa0Fza2xHYW1qZzdXeCtCUGpiS0VoZGZtazlTcjI5SWlX?=
 =?utf-8?B?dHAxcnhyRElObU00YVZWU2lRUVh3MlBHaXYyMGZKbmYrM2FwSWxmTWJGVjY0?=
 =?utf-8?B?TTlzK3BnMlFZZEJZbTlHc1Z0ZUJzOWtpb3lmQnNHSVRWeE80VFRMZU1FKzNl?=
 =?utf-8?B?aFV3YzFUK2QxNitjOG9FYS92NFBvNGYxdUVPZVVSQmVGblhLVEVETFdteFNL?=
 =?utf-8?B?WUdybmdLck5QdGwzdzZkR2VzTU9vSVptek12Vmo0VUxmK2JYVGpmZUI4OVZ3?=
 =?utf-8?B?WkJWbitxUFFEWFhTQWNWU1pIN0VxMkhpbDY1NGMyT0t3WjA1OWROTnNPWGt3?=
 =?utf-8?B?bitjZ2tvZXJ6ZkdhMjlyNSt1aXNBMmZtZlV1S0JUYUxkdFQvV2Z6SDNpN2hk?=
 =?utf-8?B?Zkh1VU8zQzE3OERLRFlKR3JFR2k3L2liRjhyYXNGNEViR29qU3BWSTIrSjNj?=
 =?utf-8?B?SFB0YU93anpnZDhuODFQaGExYzh4QkVBQjNGb2s0M1lQcDJ6NFAxMkNvMzNl?=
 =?utf-8?B?YnFucTJzVkJ1bVlad2ZWMlQ1VWcvNGxFTW01KzJ6Z3BPeHpHVno2VzJYbWc0?=
 =?utf-8?B?cHZYRU1DMWltTDl6Ukwxc3BQQUU3Tm8xbzg2UGJ0RTBzWHFsM1V1YTh2WEtx?=
 =?utf-8?B?STg5a0FUaCtmQzRMcXozM1QrbEtzU1YvYzNUcFA3VWNVbzNIUkVDVEZPV0tR?=
 =?utf-8?B?ZVpsRVZLZEFrZVY4NEUyOHowRGFIeEdLNVFCMW1kWTRnSERmeE0wcXFnTUFu?=
 =?utf-8?B?RVJWN01YcWZiU0ZXeDlmMmRRcTVEaEJ1RnFwODZxbG51cTYvU2JNdjk4VG9x?=
 =?utf-8?B?R1UyUFpJcmIyaDl2VHFub2dMM1BPR1A2VlNQaFMyemZBdGo3N0xzaXY3ZmpJ?=
 =?utf-8?B?STBwdkZrVDVDWEF6UWdYSnJ1b1FyYTFCVnFlNVdDdjMxN1FxeTNuMFZkUUln?=
 =?utf-8?B?SE9JcUxHK1ByRE5laFM5QVdseEVtek9RZzJYa2ppUDV1UVhxWnM4VlZ5dnFl?=
 =?utf-8?B?ejNkL2VSYUJIK1FKTW1PNytwRGFFYkQ4d3ZWTDZyWmdvV1J6OTJGajdSRWcv?=
 =?utf-8?B?MnFBNFIxWmVZbDY5WnpVOSt5VkxWQ0ZiYWoyS1dHVVQ2T1hTWGFZZThoRGJs?=
 =?utf-8?B?SEJLTTg0NnYvNm5xTEM5UjIrYVdjNWUxTjZuSFpsQ1UydVBsZTRuV083a3Vt?=
 =?utf-8?B?L1hkUGZIWlRJajZnZnJYblpQZlNTUW1GbCtCU0F4ZXFsRUpFMEo2U29oWm1m?=
 =?utf-8?Q?MPL5uRdezI9tLB/ZuAw+lkW2B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f05ed0b-2ba6-438d-53e9-08dd6dadcad0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 04:05:35.9569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48zxWxO30bvFQ9JQhI6bdoUm9GRjlcl8RwdRvXpssOrNQx6Svos1uAEv9Ym+8Cch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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



On 3/28/2025 2:08 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> checkpatch.pl complains about unnecessary error messages for failing
> to allocate memory. These aren't needed when the return code is -ENOMEM.

It's not about the error code. It conveys till what stage driver
proceeded and when the failure happened. I do see other instances in
kernel which do give an error message with -ENOMEM.

Thanks,
Lijo

> Drop such a message from amdgpu_acpi_enumerate_xcc().
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 1c5994de5a723..840901d65fed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1116,10 +1116,8 @@ static int amdgpu_acpi_enumerate_xcc(void)
>  
>  		xcc_info = kzalloc(sizeof(struct amdgpu_acpi_xcc_info),
>  				   GFP_KERNEL);
> -		if (!xcc_info) {
> -			DRM_ERROR("Failed to allocate memory for xcc info\n");
> +		if (!xcc_info)
>  			return -ENOMEM;
> -		}
>  
>  		INIT_LIST_HEAD(&xcc_info->list);
>  		xcc_info->handle = acpi_device_handle(acpi_dev);

