Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA50C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85CF10E333;
	Fri, 27 Jun 2025 14:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y3AmGJSl";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4C610E333
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzkN6uMlSBzJsx3hjgizdzN20hkXDR966RHoPhOdaqk7d2EuRjRxtpTG1CSG6EjBC90wKS0bydObtnvQqntGRyk1O3vWKDD8ZePB2Vtw1B4/BpnRy4HrbltWZ0ejikK37qitlGDqum5LBAcbvJijA9JKcv7RoZjTiNDiJKQWSgGHtKGyMtnfouoEqmOKIFWPgHHgHOTYl4wtsS3a3SdS7mXtzQk4Zqm3T5ltQ9p0N1s+bsjSKLKAuasBF3O0Vi9OjzdpKe7VkPYwNRgdis30ryKp7N4v23NL1LPcHbnR9EGjVhayh2d10Y6f4kEE7/YNQeq3Ty6F0ONXnZXnWOPMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9tjx/suoQSMyAw90xaLWZn3s8SvLd5B1ZfOY5mEqOU=;
 b=qZfGuCtyz5Iij8vV9QS3he1GV3k3zgZVpmhWdbYo6tcS77FPmnhfBo3mJlVz3Gq76QLTvVX+8hM51VdyN6/I7nyWAnzBKNxm/v1XJNjdYg7YEVEM5MgJuq4SPLtCc9Az+p+clG1Fb+l/OuWoaLW/ld9aJx6oCidBS084XoP7qOINpgg4bSwIJV36cZH7HsFjI1DRb0IZKLgmFazJp6neHN6ybVMy4aKassur1oolrkuTaP7RGHizx4LgGdWBxXmFYmQDzxTlO8lkMHI3OPshiKd/zQCZf+PwMaN1iDhOy3m0qJL73hfG76M2VWxbR9r/4Pl1d2AYd7vSx4aaJa8oeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9tjx/suoQSMyAw90xaLWZn3s8SvLd5B1ZfOY5mEqOU=;
 b=Y3AmGJSlTdxXxgSSZsHeqzCmIentp0W6dpZKYRXhXE7jZG89pwQTB9VrwkjMp23Uy9m5SVaCSDfIXC2Qq+aCB2JdSUSAXqdInlBh56sepQUfdMilYxTDEZ1KF2eNn7LR7PYSt94X6JCmn/fqEnNfxJIMR8AfWW7+H4fCmuCuMpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 14:56:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 14:56:46 +0000
Message-ID: <005cacc4-ce81-4635-9e19-0c1e8f82766d@amd.com>
Date: Fri, 27 Jun 2025 20:26:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amd: Decrease message level for legacy-pm,
 kv-dpm and si-dpm
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
References: <20250627143432.3222843-1-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250627143432.3222843-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 09809658-9315-4147-9313-08ddb58ad644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1doeVhCMGg0dlN0V1J6US9BV0NFcTYxRGhZeG1QU28vd0xHai9sRjJpNGhr?=
 =?utf-8?B?dUFJNUhuZUt4NmRaYmRiajgyWlpDbndGL1ZyTzJMaEt3NWxqbkl1ZW8xMlJy?=
 =?utf-8?B?aGpWNFdvSDNnME8yZ3hNaytmWE9vYlRSeFliUEx0YjlWemsxeDNYNzNkY3BX?=
 =?utf-8?B?YlQ3eTFSb3lZanZ0NEh4WHAxN0R1SzVlMW5iUTI5QVB2WVJqbnBFcmltRnh1?=
 =?utf-8?B?c3puRThVRVVwYlZraE5pOFNteDNRN2M3MVFxVmZ5M29oRVUrdnY2a3YrbmU2?=
 =?utf-8?B?WExWbEZxS2pYTnpEODN5cUdBTzJDVGxhUHVoTE1JNkJHczB3VGhDR2pNL0Rj?=
 =?utf-8?B?NTg3WStJUEh1QnJyTXNTNUlvSXcxM3E2aW9KMnVXemYxTGxqYlljVk9UZmlw?=
 =?utf-8?B?MWJWZy9acGlKZHQ1TU84R2RweUVrdUhvQjgwSWhNVGJrSkd5UzJ3N0Jtd3N5?=
 =?utf-8?B?YS9ROVU4NGxWaVVla1ZzWGJsNUx6UERqSmdkdnVLZlRZOGtvTWVYYVpwRko5?=
 =?utf-8?B?dEY4d2NMRm1jcDcvc0oydWcyZjFOVlBzTGp6b2kyWWdRUDJ5OC9GUmVxU0du?=
 =?utf-8?B?WERvYVB6K1dVZ0RIM2puM21sZmtZMWtleEc2ZGROUkphODQzSFUzSmpOTC9Z?=
 =?utf-8?B?blpBSXI2aCtLaE1jd0JFemJZQkJua01yNWplMWYwUGoya1dlRERUdG5QYnA0?=
 =?utf-8?B?SUJKSlRtSkwvb3NlTlhTZDY4cDN4NmsxNzU3ZHV2c2txYVlTWnE1MGRLVkhy?=
 =?utf-8?B?dHVpcW1Udmljd2tRVTEvZUZlYmsyeDBZb1QyMVZINjZuOXloeTFKVldkOFR3?=
 =?utf-8?B?WS91WW1lWG1jamhtbWxiTlFoaHdMVm9qNEtqTWV6SU5JL0N4dGJGN3JzRndY?=
 =?utf-8?B?aW9Hemo5S1d4dlpscjVGRTRVaC93NE1Xa3V5NURJenZkbi90N2ZjWmpJYjFy?=
 =?utf-8?B?Z0pQaG1wUkdHWGtkZlZzb0VBQjdDVjV3N09xSXJLaXprN3EwckUwRm1MR3I5?=
 =?utf-8?B?dnpIKytnS0NhWVVQaWF3UURDSVpXZXRNRUJtSUpPWEs5VnJjYjROWmt0WXJU?=
 =?utf-8?B?cGU0S3lXbEx2TDJYdzhQUzNhSE5ZQ2VCQWcyaUNlZGlHbXpYc0lZQVZMYTVM?=
 =?utf-8?B?dW5vWU9LdGg2ZDI5WWM0ZHA2eUFvN2VjQXNRQUlveE5Wb1dCTTNXUGZzNWpv?=
 =?utf-8?B?cDMzYWdDeTJnNWxmL3NwV0JLRzJ5S3lZMnZIdW9rSHZmOURMV1kxSkdMTDhL?=
 =?utf-8?B?MThtV0NKdDhKbHgvTGxNdDUrMGY0NmFBY3VqWTRMUkRCMUl1U0VnbWJ0REVx?=
 =?utf-8?B?ME53TWFlTnhYZUtNV3BOazJqeEtkc1hVQktHdUlHTjVGM1NpdXRVQlgxV0Rm?=
 =?utf-8?B?WTYrdkozbzNwMWxFUlRHbk1wNmc1N3doRmxlVU9HWHVPRXUvUzlQRFpTZVdE?=
 =?utf-8?B?NmJkQzRvcmRzSjdGcGhkOTdmdm9QNGVobUVGQ2t6dndjMDczUWhiR2NUNmFG?=
 =?utf-8?B?czBURkJkWm0yb3VLV2Joa3hRamRpSTJ3bXlQaWhsd3o4VWx4V3NNQkN0aXZ3?=
 =?utf-8?B?Y2NVY0t0Zi92S25pbGFvenNvNFE3anpaUEh5bzU2Z1JEK0xXZlRqdWNGL1A3?=
 =?utf-8?B?blA3c1Qyc2poNkp2NkhiSlhzTXFlU0MwOE45VDhGQW96TGpnZ0tYbk1lRyti?=
 =?utf-8?B?TE9Kc0lLdENYTU5ISExWSmpZMDR0c1RBdUVJOStURTNzREcrV2JGUCtiZ1RD?=
 =?utf-8?B?MTNCZWI3QlhYTkEyMmdraU9sME1sUTNOR1EyV2hWZnlwS0xFb1dMb0JBR0Vh?=
 =?utf-8?Q?DVENk0Dw+EdC58zNEInbSl+zsozRBFrm8lJLI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhpakJjd1IvQy9GOVl4V2xPUUY4a25jU21zeE9qc1F5c0NIbFo4cGNCMS84?=
 =?utf-8?B?STNoS0sreWlYK2YzRDd6OUptek93VllibkVndGZ3LzBlcjVHUHZMVkpDSjdl?=
 =?utf-8?B?cTRHYVA5SzdQSTY0Nzd3VG5aNGxUV2lDaEZJa2hvZEl4WlRXdFRQZ2JSb1Ni?=
 =?utf-8?B?Uy9OYkxIdTExN1YzQmZFcmxYWjUrcmYzVUk2SWtvcjZkb1pkbjlESllHUlNq?=
 =?utf-8?B?d0NDOHQ3OXV4VVRLVlRoZzR6bis2b2U2THFTckthdXlTN0gwZDR3QlRJZW1i?=
 =?utf-8?B?SGFtWWpuNkU4alE2Zjd3ZWx2TUxnMDFwY1QvcjBZSW9iK3RnbzFNYWY0Qzg4?=
 =?utf-8?B?VWlZSWNRaUNKa0MrWk5adEdvMXBUbGtSdW16RUllNlhFeXdJNG11ajZqV2th?=
 =?utf-8?B?U1U0OGJ6djRVeFAyQUQzL281R3ArNjhTbkI2aHBBMndJc21OaXB5OFoxeEpy?=
 =?utf-8?B?TGZFcVBUR09VNDJ2aDlzWFBLZzVSS2NGR3I2cTZ5K1BJZHY1SEZyMlpFVjY4?=
 =?utf-8?B?U2xPSlV0TDBHWVRJOE9HUlFZWWlzOXZUM1BKOHQ5am5jSElsOU9qRFNDbjVv?=
 =?utf-8?B?RDJKQjBUdGlUQkRQR2Q1dU1mT1lETkFLQUd1U3JucThUeVY3NHZSUzhPUWJX?=
 =?utf-8?B?OU9ZakptUFZ4Z1dsOGwxMThwc1ppZ2swUnVrdzZjV1FZRGY0c0ZXWjVseGNh?=
 =?utf-8?B?RU15R1IyQ0lWRk1Od3AyZXJXRVBpa2RjTmIwTzhwZGRiOWpIc1FwTElhbjQr?=
 =?utf-8?B?RXJiRTg3TkNwUmxCTW9ocEVtYmNZVklVNnVDSWVCOUN5emNJdXBKeUM3RVIr?=
 =?utf-8?B?ekx1dmNOV3Q0SklqZ3FVdElraThWZ01JeDhsK3h2MUVYMHB6Rko5eTE4dUFM?=
 =?utf-8?B?cGlWd0hVczdOZWJUWFNudC9VbDN5WHJNc2VnME5iK0Rudms4bUJmOHpQb0ly?=
 =?utf-8?B?Mng4S2t2VGFXSHhMaENKRUZxVlVkMWRqZU9MZnlZdnpVNmMyVzlGV2xzYjdB?=
 =?utf-8?B?eGcxZ0lLMTNqbTB4QmpyUmROaTRiTVhZKzNjVXhzUTAyTzV2eVF0dHo4YkJs?=
 =?utf-8?B?YnBzdEpJc2dBeTlRSVdOTnNySWlDV3JCYWIwSkJqSDhlY3RYcWZ4SzdzWU1r?=
 =?utf-8?B?Q2NEMXowaXZ0eE9xMk1STFR6MjE1UGthMk9ycUplQlZGYlYzMTcrcUJuUk1x?=
 =?utf-8?B?NVVTN2FvUmU0N0J2ZWVrSXA3MW1TMUltNFMyTjJoMFd0NmpRYUxaR09GOVMz?=
 =?utf-8?B?bFkyT1RFa2oyMkVoS01ObzdLeTJ3OGxVa2RUL0xRNjBXd3IwQUlyR3VJMm96?=
 =?utf-8?B?ZUVKT2RwQlduYXR3ckU5L2xkdGR1YW8zU1htMGZkUUk2TmhXaDhLUC92cTdD?=
 =?utf-8?B?bEZ3bk1BYmNibnBjT3BhL3dvL1FSa3dwYURVTm03SnN0TmF0ZnJ6VHVmY211?=
 =?utf-8?B?WWVxN3EwbGtuOTFIK0gzWkRYRzVrSzRUVjVOaUxHelRuK2xwcWpsVWhGM2dm?=
 =?utf-8?B?RjQrc3F5TzZFQm1jSytKN1J4d3FHdmdOWEpqQ0JtWmRzVzl5ZEw2UFhpeDhs?=
 =?utf-8?B?cHRPeUI5OWc1dG5peGJvV0ljV29iRW5ncnlHNGZsWjhlNUJKT0w5WFpqcE1T?=
 =?utf-8?B?WldQT2MvRkJLTFc2M1orWlVTMUlMOE5HNzBUZmhydFlJeXBCUHVjWXl3bUpH?=
 =?utf-8?B?NFI1WlZxZmdMTEZqencvbmRsR3hvUXNiUW5GMFVtYlI2ZFZlYkRhVTdyN2hu?=
 =?utf-8?B?dTB0M3Z0QXE1Z0JoRUczbXI2QVlubEVQMG45RThVamNUV3dkQzN4TzdUaWJC?=
 =?utf-8?B?ZmpkOWMxTGozZmRoTmxvZWV1bGh5bkxzL1RWTUJ4c0d2cHloQTIzUjhmTmRO?=
 =?utf-8?B?MVJRS2huSEJQdHJDakhpUDI4cVh3TEJQTVl5TW1ZMDIyKzN1S3JJa3lOaW95?=
 =?utf-8?B?Z0JNNDMvMGRreDZyVDlOS2Jlam1iUXBnWWQveGNqVXlPWFh6ak9SOEV2alF2?=
 =?utf-8?B?SzdlZ0t0ODRLTGhNR2pGU1h0ZFEvS21oeGZDekErVkd4VkVDN0FSRy9kM2p1?=
 =?utf-8?B?amRWNXd4cnNHSm9FMTFJQVVNaE1MZEdhcEttQ3Z1TVNOQUh5YkFiTmsrUjFw?=
 =?utf-8?Q?5IvVERagUkumxZPasyRxe+RYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09809658-9315-4147-9313-08ddb58ad644
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:56:46.6766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYTkxPiCytIfqBftSePDTCvOjeXoXMmsb4mcoPa+4ngKxBsyPBCw9Am778MUR1z5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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



On 6/27/2025 8:04 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> legacy-pm, kv-dpm and si-dpm have prints while changing power states
> that don't have a level and thus are printed by default. These are
> not useful at runtime for most people, so decrease them to debug.
> 
> Reported-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4322
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v3:
>  * Rename functions to include 'dbg' in the name (Lijo)
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 16 ++--
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 92 +++++++------------
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h    |  7 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 10 +-
>  4 files changed, 50 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index 34e71727b27d7..5d0b18062b8c1 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -2886,16 +2886,18 @@ kv_dpm_print_power_state(void *handle, void *request_ps)
>  	struct kv_ps *ps = kv_get_ps(rps);
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> -	amdgpu_dpm_print_class_info(rps->class, rps->class2);
> -	amdgpu_dpm_print_cap_info(rps->caps);
> -	printk("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
> +	amdgpu_dpm_dbg_print_class_info(adev, rps->class, rps->class2);
> +	amdgpu_dpm_dbg_print_cap_info(adev, rps->caps);
> +	drm_dbg(adev_to_drm(adev), "vclk: %d, dclk: %d\n",
> +		rps->vclk, rps->dclk);
>  	for (i = 0; i < ps->num_levels; i++) {
>  		struct kv_pl *pl = &ps->levels[i];
> -		printk("\t\tpower level %d    sclk: %u vddc: %u\n",
> -		       i, pl->sclk,
> -		       kv_convert_8bit_index_to_voltage(adev, pl->vddc_index));
> +		drm_dbg(adev_to_drm(adev),
> +			"power level %d    sclk: %u vddc: %u\n",
> +			i, pl->sclk,
> +			kv_convert_8bit_index_to_voltage(adev, pl->vddc_index));
>  	}
> -	amdgpu_dpm_print_ps_status(adev, rps);
> +	amdgpu_dpm_dbg_print_ps_status(adev, rps);
>  }
>  
>  static void kv_dpm_fini(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index c7518b13e7879..2492d9a31bdfa 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -47,7 +47,7 @@
>  #define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
>  		((adev)->powerplay.pp_funcs->check_state_equal((adev)->powerplay.pp_handle, (cps), (rps), (equal)))
>  
> -void amdgpu_dpm_print_class_info(u32 class, u32 class2)
> +void amdgpu_dpm_dbg_print_class_info(struct amdgpu_device *adev, u32 class, u32 class2)
>  {
>  	const char *s;
>  
> @@ -66,71 +66,45 @@ void amdgpu_dpm_print_class_info(u32 class, u32 class2)
>  		s = "performance";
>  		break;
>  	}
> -	printk("\tui class: %s\n", s);
> -	printk("\tinternal class:");
> +	drm_dbg(adev_to_drm(adev), "\tui class: %s\n", s);
>  	if (((class & ~ATOM_PPLIB_CLASSIFICATION_UI_MASK) == 0) &&
>  	    (class2 == 0))
> -		pr_cont(" none");
> -	else {
> -		if (class & ATOM_PPLIB_CLASSIFICATION_BOOT)
> -			pr_cont(" boot");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_THERMAL)
> -			pr_cont(" thermal");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_LIMITEDPOWERSOURCE)
> -			pr_cont(" limited_pwr");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_REST)
> -			pr_cont(" rest");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_FORCED)
> -			pr_cont(" forced");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE)
> -			pr_cont(" 3d_perf");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_OVERDRIVETEMPLATE)
> -			pr_cont(" ovrdrv");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_UVDSTATE)
> -			pr_cont(" uvd");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_3DLOW)
> -			pr_cont(" 3d_low");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_ACPI)
> -			pr_cont(" acpi");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_HD2STATE)
> -			pr_cont(" uvd_hd2");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_HDSTATE)
> -			pr_cont(" uvd_hd");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_SDSTATE)
> -			pr_cont(" uvd_sd");
> -		if (class2 & ATOM_PPLIB_CLASSIFICATION2_LIMITEDPOWERSOURCE_2)
> -			pr_cont(" limited_pwr2");
> -		if (class2 & ATOM_PPLIB_CLASSIFICATION2_ULV)
> -			pr_cont(" ulv");
> -		if (class2 & ATOM_PPLIB_CLASSIFICATION2_MVC)
> -			pr_cont(" uvd_mvc");
> -	}
> -	pr_cont("\n");
> +		drm_dbg(adev_to_drm(adev), "\tinternal class: none\n");
> +	else
> +		drm_dbg(adev_to_drm(adev), "\tinternal class: %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
> +			(class & ATOM_PPLIB_CLASSIFICATION_BOOT) ? " boot" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_THERMAL) ? " thermal" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_LIMITEDPOWERSOURCE) ? " limited_pwr" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_REST) ? " rest" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_FORCED) ? " forced" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE) ? " 3d_perf" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_OVERDRIVETEMPLATE) ? " ovrdrv" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_UVDSTATE) ? " uvd" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_3DLOW) ? " 3d_low" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_ACPI) ? " acpi" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_HD2STATE) ? " uvd_hd2" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_HDSTATE) ? " uvd_hd" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_SDSTATE) ? " uvd_sd" : "",
> +			(class2 & ATOM_PPLIB_CLASSIFICATION2_LIMITEDPOWERSOURCE_2) ? " limited_pwr2" : "",
> +			(class2 & ATOM_PPLIB_CLASSIFICATION2_ULV) ? " ulv" : "",
> +			(class2 & ATOM_PPLIB_CLASSIFICATION2_MVC) ? " uvd_mvc" : "");
>  }
>  
> -void amdgpu_dpm_print_cap_info(u32 caps)
> +void amdgpu_dpm_dbg_print_cap_info(struct amdgpu_device *adev, u32 caps)
>  {
> -	printk("\tcaps:");
> -	if (caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY)
> -		pr_cont(" single_disp");
> -	if (caps & ATOM_PPLIB_SUPPORTS_VIDEO_PLAYBACK)
> -		pr_cont(" video");
> -	if (caps & ATOM_PPLIB_DISALLOW_ON_DC)
> -		pr_cont(" no_dc");
> -	pr_cont("\n");
> +	drm_dbg(adev_to_drm(adev), "\tcaps: %s%s%s\n",
> +		(caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) ? " single_disp" : "",
> +		(caps & ATOM_PPLIB_SUPPORTS_VIDEO_PLAYBACK) ? " video" : "",
> +		(caps & ATOM_PPLIB_DISALLOW_ON_DC) ? " no_dc" : "");
>  }
>  
> -void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
> +void amdgpu_dpm_dbg_print_ps_status(struct amdgpu_device *adev,
>  				struct amdgpu_ps *rps)
>  {
> -	printk("\tstatus:");
> -	if (rps == adev->pm.dpm.current_ps)
> -		pr_cont(" c");
> -	if (rps == adev->pm.dpm.requested_ps)
> -		pr_cont(" r");
> -	if (rps == adev->pm.dpm.boot_ps)
> -		pr_cont(" b");
> -	pr_cont("\n");
> +	drm_dbg(adev_to_drm(adev), "\tstatus:%s%s%s\n",
> +		rps == adev->pm.dpm.current_ps ? " c" : "",
> +		rps == adev->pm.dpm.requested_ps ? " r" : "",
> +		rps == adev->pm.dpm.boot_ps ? " b" : "");
>  }
>  
>  void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
> @@ -943,9 +917,9 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>  		return -EINVAL;
>  
>  	if (amdgpu_dpm == 1 && pp_funcs->print_power_state) {
> -		printk("switching from power state:\n");
> +		drm_dbg(adev_to_drm(adev), "switching from power state\n");
>  		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
> -		printk("switching to power state:\n");
> +		drm_dbg(adev_to_drm(adev), "switching to power state\n");
>  		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested_ps);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> index 93bd3973330cd..7120eef305092 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> @@ -23,10 +23,9 @@
>  #ifndef __LEGACY_DPM_H__
>  #define __LEGACY_DPM_H__
>  
> -void amdgpu_dpm_print_class_info(u32 class, u32 class2);
> -void amdgpu_dpm_print_cap_info(u32 caps);
> -void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
> -				struct amdgpu_ps *rps);
> +void amdgpu_dpm_dbg_print_class_info(struct amdgpu_device *adev, u32 class, u32 class2);
> +void amdgpu_dpm_dbg_print_cap_info(struct amdgpu_device *adev, u32 caps);
> +void amdgpu_dpm_dbg_print_ps_status(struct amdgpu_device *adev, struct amdgpu_ps *rps);
>  int amdgpu_get_platform_caps(struct amdgpu_device *adev);
>  int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
>  void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 4c0e976004ba4..52e732be59e36 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7951,15 +7951,15 @@ static void si_dpm_print_power_state(void *handle,
>  	struct rv7xx_pl *pl;
>  	int i;
>  
> -	amdgpu_dpm_print_class_info(rps->class, rps->class2);
> -	amdgpu_dpm_print_cap_info(rps->caps);
> -	DRM_INFO("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
> +	amdgpu_dpm_dbg_print_class_info(adev, rps->class, rps->class2);
> +	amdgpu_dpm_dbg_print_cap_info(adev, rps->caps);
> +	drm_dbg(adev_to_drm(adev), "\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
>  	for (i = 0; i < ps->performance_level_count; i++) {
>  		pl = &ps->performance_levels[i];
> -		DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
> +		drm_dbg(adev_to_drm(adev), "\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
>  			 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
>  	}
> -	amdgpu_dpm_print_ps_status(adev, rps);
> +	amdgpu_dpm_dbg_print_ps_status(adev, rps);
>  }
>  
>  static int si_dpm_early_init(struct amdgpu_ip_block *ip_block)

