Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B29C25B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 15:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1EA112348;
	Tue, 28 May 2024 15:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="INH4OwME";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C5B112341
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 15:25:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0kcmbYsy8/VtBaLr5nP4QQEUNPeYanUyNNCSXMrP5fOCy3oX55GQQlbqA4B9NRA487lgdgk6M/uL2Ti1jzRoPANOIienfDBFbIxx4+TJODjiW+oJeEPlHZpJug3Ei0J0rdm9pSBMKJI6DHvI+qFAHI7l5EaHFiB9tn8hDzQ/sXzDeJp6rOTeKpVBaN1slpfGFZw+7Q8dPiYKAYGc9jo7sOdJMeSHQUF/UFd6wmgeu/eBuMqt/QI50F9LTU/hhvvPaKoD2sCl1ooNvBQodGUmYlDzDmzah+r7m3gk2bnOHEfT0xT9ab01zPvZWFT/xduplILzpjdFQYEvWOB77E/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voR3NFJKhOf+Zl1z1lLjDoOHeLZIAPvCRmmsZWJfMJI=;
 b=Mznk50SYqUkdIw8tamzn/j02gpOZn/6V8+hNdMEcR1Qhp9KdOd3hELLZWQCls+154dfhl+hVe9KsK1FArM/TWdYHY8OPbxWC4kxuX68z1b4N/TcJE+lEvekKNRcjJvSUfaqDJYVffjenB/hkI/LBMO5EjCQWffFxZ8pq8lrZoV6/N5/HPOFTA1SmAUE9+qx5Ic6jt1Gecn/7i9RNkfpIx2KIEGeA3d7YK5826Y324NJO4XLXINwdH/sZNbUgHBYXqFyRK7gokuDZMkCrez2HGh3wTvxlqh1auEVmoSSxcLBSIUoC6OnYPo6Ce7G04Mnl685ouuX23Vhex0XW+wrUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voR3NFJKhOf+Zl1z1lLjDoOHeLZIAPvCRmmsZWJfMJI=;
 b=INH4OwMEhQTXdsxM8eoeQVC7BhIHAyuaCeexUENnmIWMEK4eKj7QVL6MUpfLQ17PaQe9qLD7IXV3pmXGuqRKtV4z8kp3rM+li8xTjPpQchr15wMhQJ+PMtnWPPiR8vvrWz75rui0xQeLprTs/w4rQZINA4seIG1pm4cAy9xZoMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.37; Tue, 28 May 2024 15:25:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:25:38 +0000
Message-ID: <72770a52-2b16-4816-b51d-72687c90fe74@amd.com>
Date: Tue, 28 May 2024 10:25:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix 'snprintf' output truncation warning
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com,
 benjamin.chan@amd.com, king.li@amd.com, bin.du@amd.com
References: <20240528152406.25208-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240528152406.25208-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:806:127::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: cefccf16-cdff-48bf-7605-08dc7f2a6d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXpxeTZQSFF2bTdneTRkRjA3L2wvOFNCRmpmdjhFNitkQSt2WWRwYytRdXRH?=
 =?utf-8?B?cE1oK0Ywd3RSWDRBakRIcy9zRXhvYnRKeTlnajBzaGozT3pINzV0T0VTRnVI?=
 =?utf-8?B?MW1YczlPNjRyOTBCbENTQjhZUVVGMGJNZENuQVlWYWJrdWlIOW93Z09UM3NH?=
 =?utf-8?B?YVk3QWJCQ3NXUU5KUmdubFlIRFNhbW93bTZnYVZRQ2k2WUo2L0xzdG5xUVU1?=
 =?utf-8?B?VUNRVjZnSmxCRHY1aVFwWnBqb2hPdUdkTTREME1KNU54aFdaRE5VK0dTMkl5?=
 =?utf-8?B?ZDYrcm9Xb05JMjYwanh3ZVNwM01Mc3dyOG5DcWQvckpaUHdiWnRQalRaUVh5?=
 =?utf-8?B?cVNEdThjcTRzV3orcGcyUFl2UjVEa21WTlVKdjJ1MmkvNW50YjJCMENjYWRS?=
 =?utf-8?B?RDJjVEhteEJUS1Brcy9qYW5kMHBBYVJlQUk5NHp1M3JmVDJjVlhoTWJ4SWF1?=
 =?utf-8?B?MDV4YmxYWTJtN3lrQUwvclV6bklYaWFHMGNBR2VvL3hHc1BRd0R0ZmlYb0U2?=
 =?utf-8?B?ZW5sNUI3aGNYeFEvNWZBU2JqMk9tN2RZQ214cWV6ODZMb1d5amhxOS8wWlM0?=
 =?utf-8?B?Z3BNNDAxU25uazZHQlpDZ1FHT29JaE84MGMvaDFmR0lRdTZ4cHlwcURJM0dH?=
 =?utf-8?B?L1hLZng4YnBPZE12WmlDVytYb2REZVVRZGNFaDYrY3c2c3NUQU9ZMFVzK3dt?=
 =?utf-8?B?ZGxGQ005WTNhaVcxM3Mremp3ZERQVE43aFkwaW05NCszN2RSbDhVYzQ0NEdV?=
 =?utf-8?B?MDZ2M3BVc0ZKVkhEb3Y2M24yTUNMK3YyOTJXNGN0ZFpsRFlrekV0N3h5d0RQ?=
 =?utf-8?B?SVdWbUY4RzVUZGh5TVkzVkM5dFBabWcxdmNreENZME5jeFNZd0NTdnVNMEg0?=
 =?utf-8?B?NEgzRzc0bkVJMUN4dktzelhoRnJjK2docWNhZFh6Sm9zSWh0RGlwNDR0dEVD?=
 =?utf-8?B?Q0I1ZDNPZlBYRkpMcGZES0ZaUXIrWDFzYldvS3ZzU2gyWXRSRGtmTWZvN1ZV?=
 =?utf-8?B?cndJOXAxNVFUZ1hHSEVXaFpCWTI1OVZYQnlCU2tpeWtqdVFQU0hzR0VRRVZa?=
 =?utf-8?B?N2NhVFJwRzZTQnRPSkdNR2djckJrS1hGYmpWV2FQSHpsWFpxNFg3SE1rNlda?=
 =?utf-8?B?QkRLV3JwaTJaZGtZVzJRU0phQ05hWDZ6eUpRZmE1MkRxR3M2U2VOTGt2RGd1?=
 =?utf-8?B?ZnA5ajFmT05FK2tJOEpBNzM3QnB1NEtsNXpXeDFNUVhjL0t5ZzR1T2ZabmlT?=
 =?utf-8?B?eXhwMzhnNGVRRTFnbkRKVS96L2ZrNXkraWMwcE81ZmE4TTNDaXVyWXFsczhi?=
 =?utf-8?B?T2lSUGpDQXJJeTdBZ1g0TEhEQUpzczZ0Qk14UlAvcTB6anpYb09YdlZHc0xM?=
 =?utf-8?B?V2FUTkhmUUNjUmczNFJKanVaTUthMnQ0cmF5RXh1d0JyRkZWNDV0MGc0VzJR?=
 =?utf-8?B?OUxUUnlmVDF6Q1ZhMGhwQTRzV2NJNk9zTjRxWnZ5S2ljUndTKzBRc2RCMmhP?=
 =?utf-8?B?T25xWXJaclBCUm5JNGlVZXFaWlJvNlJUU3NaRmZiVHA4YnluaHV5VU5QUHNt?=
 =?utf-8?B?eVA3QWY1OU43aXRxcER4M2dzY0hwLzBnRElHNzBtQnZwY1ErZnNSYk9HV3Jt?=
 =?utf-8?B?QmUxc0NsSWNSRnRyazlnbDNDWXFxZFU1WWV0QnlxMGRqc293QzVJeTUwZmw3?=
 =?utf-8?B?ZFpNbmZrOXpXbmxPMkRHLzY3VHRLME5EZGlnM0hPQVBEN0JuL1RlWEh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2pyNzc0ZU5PQlV5VUc1QU55RFdlNTZPZGZBQXFQUzhzSk1tb0NXVHl4cnBx?=
 =?utf-8?B?bnhWeFpGeWVtN0QzOTh4SHU2VEJqaEpaOHh4bHRiSkxCUXB2cEJCbDZWbXRI?=
 =?utf-8?B?VStQZys0ODN4WDBmb1VkU1M0YWErdWNqTVNISVo5TDMzR2U2bDg2eW9lWk0y?=
 =?utf-8?B?amxvL2xzZFlRaFZ1cTAwQnNzQ1pZS0dUU3dQcUVNNU1pVm9UeW94MUl0cWs3?=
 =?utf-8?B?UzFzOVMwK1JJbEtBNGdoNStpUmlaK2xGeUlSaEN0TWdHSEVyNkZYMjFjbUxp?=
 =?utf-8?B?MzA1L2I2eUphQitPT2JIYnVwczkrbEFXOC9NZThGbjZiTlZFZzNpd2QwNXg0?=
 =?utf-8?B?eVhtYWRtRko4TFJ2dVRiNjJFTmplMjNlV2NHYTJGWVQ4RlVJL20wUlU5R3cv?=
 =?utf-8?B?bGk2Mkp3bThCaDFuS3BCVnhheUx6RnpKUTQxVkhzTks0S2NIUWtkV2I4bmhw?=
 =?utf-8?B?WElxc2NJMzhMSkx3blJNdmN6UWpkUkNBZTlzYzVRTC82aFFhMGw2YlhYVFIx?=
 =?utf-8?B?ciszSndpSXc0K1JkWk5DeTU2Q1o2T2phSjFxM3d2SzBaak9YTkZwQ29hd1Vi?=
 =?utf-8?B?R1VPaUpreVBzb2lPR1RwMllnWFpFNURPdFo3a0FDajJTYUVoMHd5cmFyL0c1?=
 =?utf-8?B?czArRVB2OXZiYXBxWGs3TGhsemlzL2kxRFhXMG1mcEdLaTZvS3hrdytremdr?=
 =?utf-8?B?NzlZQWVmY2p4ZjJEOVROSUN5R1d4RUVmby9Vd2M1T0lHSThGclRVQVFScU5C?=
 =?utf-8?B?WTVqSDV6bWV4ejhzOWJ0Uk41Q3ZuTldCVlpTajgrK3hJU3VEVnY3RFdRaEFR?=
 =?utf-8?B?Y0RtY2p3ZGFyeUo0TFd5ZmsvU2RNSlBVMEc4eTFRMlNkSFhFeXQzcUIrQ1Bh?=
 =?utf-8?B?VHZMSXZMMEZGTnVDbElTZnF5U1VDeTBUZW13aC9nQUFrajN1UHpSckRRazJK?=
 =?utf-8?B?WWEvcG9kNUdqT3VVWVdmc0Z3NW9YRUIvRkkzN3VEUmRlbzQ2cVRObzV3T3Q0?=
 =?utf-8?B?WWx4d0NGQUNVOSswZFdtZFhVSlFXdHQ3UzJXZ2wvRHhwbWlwcjk1YmhuWVhC?=
 =?utf-8?B?N1o4dHFyUDZKMW80ZjNlck1SMjVLNWhGYzBnM2d3M0cveTlqbFFsSUdlTDRj?=
 =?utf-8?B?N0dWRGh4WUZYQ2pEeDdYQlQzNXBJSGFqS21iM0o2UGR3aEhicVZiZjdPNkhv?=
 =?utf-8?B?bnNMaVNEdGp4Y3hudHFKVHZFLzVCRGhxZW1nRWQ1RlFmRzRJeTJhT2w4T0Vn?=
 =?utf-8?B?T1kxcGpaRWQ3bW1Sd3p2MVdiNEV5TFdiL1pLZ2JTWk1SRk5IYUNPak9MaWxV?=
 =?utf-8?B?cHZ0NmsyNTFZYU90NGRPM0p6T0F4RExzMjh0cHZ6bXJXTzJPRWc0Mk9reFhj?=
 =?utf-8?B?NlcySVNRSCs2bVN6QTNQUFd5TWNMOEQxdjlGMnVST2ZlVmd6YW95Uy9PM1hM?=
 =?utf-8?B?RXdrUnpLMUh3MHMzZTFMZHZoRSszU1JNNThtWWZRR1h4T1FIVVBMRE95Mk0z?=
 =?utf-8?B?WEtTeVBkbkgwQ2NpbGlORTVub1R2dTNJZW5wSVFNaVpvcU9zTHpmOVlLdHpX?=
 =?utf-8?B?OHkxZ3VMU1BldU9JZzIrMk5UbGFaR3Y4NGlnWnVBVmMwOTE5MFJJTFJJQ1E4?=
 =?utf-8?B?OUJremY1bGhRUjBKalpBRVNuRXpxTXRGdVQ3N0x6NExoT2hSUEFKak5mVjl1?=
 =?utf-8?B?dEZiNnhvRS9VaFZsMGNiMWJMZUJZNUQzQTdoWCtub1RiMlhGZTE4a0QrTkpD?=
 =?utf-8?B?Vk9CYzJJSWFvVnU2MjFsWWxPQjlOYzRVVm1kSldULzVURVA2cGZWbmdWU24v?=
 =?utf-8?B?OEswTGFoVElyT3M5cXpzRlk3VGhSd0NKeklUdTFiREJxRW5nRVhuSGJ3R0dY?=
 =?utf-8?B?YllwYzF6aTNYWEFmR1FZc2JqaGh5VGhwYVRBaUt2b2FtMGFKMUZhSU41U0pX?=
 =?utf-8?B?VFlBSUZkWVFBWklpeHlKUFQ2QzZyMmhKZHJFSlNQbWxxZVQxMmlkM0d3UjB5?=
 =?utf-8?B?Q1JLNDA3WVIzcDl3STFtWHFhT2ZxLzViN1NwSWVaNHN3MmpmbDdWQmpPUFdO?=
 =?utf-8?B?a09qVmxQb3VrcFNoc2o0OVRJYlBobGl1RCtDbEs5Z1FLTFF5YVpMZS9KT1Mw?=
 =?utf-8?Q?z6J5H0U+KqU1AyZZGJYHjx8cc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefccf16-cdff-48bf-7605-08dc7f2a6d37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:25:37.9904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+DnUVdjF16arr1MqN5WPrMLM91wgfxxWzZu03eDj95mAgCYhwFeHsaNI0VlXhea9mcQK+lZCyGhsE06RiXfaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216
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

On 5/28/2024 10:24, Pratap Nirujogi wrote:
> snprintf can truncate the output fw filename if the isp ucode_prefix
> exceeds 29 characters. Knowing ISP ucode_prefix is in the format
> isp_x_x_x, limiting the size of ucode_prefix[] to 10 characters
> to fix the warning.
> 
> Fixes the below warning:
> 
>     drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c: In function 'isp_early_init':
>     drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c:192:58: warning: 'snprintf'
>     output may be truncated before the last format character
>     [-Wformat-truncation=]
>       192 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>           |                                                          ^
>     In function 'isp_load_fw_by_psp',
>         inlined from 'isp_early_init' at drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c:218:8:
>     drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c:192:9: note: 'snprintf' output between 12 and 41 bytes into a destination of size 40
>       192 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

As the kernel robot reported this you should add a "Reported-by:" tag 
for it.

Otherwise LGTM (feel free to add that tag when committing).

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 240408486d6b..2a3f4668cb9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -96,7 +96,7 @@ static int isp_resume(void *handle)
>   static int isp_load_fw_by_psp(struct amdgpu_device *adev)
>   {
>   	const struct common_firmware_header *hdr;
> -	char ucode_prefix[30];
> +	char ucode_prefix[10];
>   	char fw_name[40];
>   	int r = 0;
>   

