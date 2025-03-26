Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2AAC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 09:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555D210E687;
	Wed, 26 Mar 2025 09:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSKa0e6I";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C0210E682
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 09:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEPiImMs0X4bjmFO+La4kHUjWXWPrycdr7E7ouJGdBPvjK34/x7SHAbg9DD5J0uzj9Vyf0hv2JYIu3hLdkoVKRrOoUlt8xZgcO31pQ2CgiWD+m9CI7eiNAICgGX5mKeWCo+R/akqW+9rNfoN/W1nydm/IoX7hucMOOM/oGT+JnADbPjxAl7NiwWy7yE4QFnHi4ys3qi3zQ0VzHXwJo9gCsrKOM/eCi6DN9BSsZDNeAzLPvtB3zPQgBIc6w/e4a/ICE0B936M3hUy6srQ1JCvgpdP+xBnE5ywp2bep4HwE8qEwbpvmwNfChsDaDZW5DHin3xgbCDO3yTJnnqR5HUphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAX0Hh+NuRy+jJXXDkxOyH2V4Grt0uhqGIznaD3odFA=;
 b=I06LVMNowlVAGBSMBKjpquw59HpABB0OevUlczIrBzaEZ2B31CCpj6kn6E301w3jgzqtsKoidGaFCB2W7L0Qcc0dMZJaSjHshJWbxdSVJO6CLhDOCFqBANjUOKsaIUGJQcvyPwTYoLC5N9cFZKo5FlpJ4aQLtbUinGWZvBrPT486bX+WIoHNz7WzvUEqmQR0ATJfVVgYxj3ukfvwu+TsLNvlWQ5fUS5A/zuckhtocoN+LwwSG9fH44L/LksbBhWVpPopD0lw114V4apymrAZk5o+TJ/MDRld4ySPhBRAWpk2ls4kUmanqwRSakHkbwo+IS4TxCziLkXsbZ7+ZfZjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAX0Hh+NuRy+jJXXDkxOyH2V4Grt0uhqGIznaD3odFA=;
 b=JSKa0e6IgYfAU+0fqxKe9XPJarln5FbcWJSaZmGnXriyBCiCVRceoQdQdoBZV0Yxp9pHlUllhRuJ2c3pX5mOyS+4H8Ru6hvKpQ30ErB96GhWwHi/yjyyqzj98fhmjvW40kko+fVlpsFaKLyPLtR5a1s5fT75JMWDt8xsDmGLeho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Wed, 26 Mar 2025 09:22:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 09:22:25 +0000
Message-ID: <6aae3702-deac-4fd6-8af9-676b3f21e204@amd.com>
Date: Wed, 26 Mar 2025 14:52:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/amd/pm: Use gpu_metrics_v1_8 for smu_v13_0_6
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250326081400.1305136-1-asad.kamal@amd.com>
 <20250326081400.1305136-5-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250326081400.1305136-5-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017C.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::47) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e692aa5-df7b-4306-8d93-08dd6c47b86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG9ZOFFmT3Fxa2F3UlhaUkFXcndsU0szM3JHa2VUQXM4TTJBejgxMzZHdmtT?=
 =?utf-8?B?NllzTEIyVEZoSmFORTRTOUJycHJzNkxVTUlpYnJOcDR6aUlubHdjUnpQUzlF?=
 =?utf-8?B?bjR5QU9MV2VkRWR4aVpBZWhxQmhldjlBbEdrNlFRZkt5NEVGYnFFT2QxQklQ?=
 =?utf-8?B?RWxRNFpOOWxFWVdxRW5YcHJrSXlYT1d1aDk5NlhBeS9sbGhvZ2s3THFMajhX?=
 =?utf-8?B?ZTJJS0pmaXZwYVkwTE5qdE16NEo5SzltWHNvaW5jS2MwRWxWUlduZ1VZNTRr?=
 =?utf-8?B?ZzdIOGpEYkx0NWd3QzBZdXJOR1g4YlNib1JVMWNHVS84aDVseTl4ZU0wUUNI?=
 =?utf-8?B?L01UblNzRHZTM1BhTG00TGNWWjBOWGlNOWwya1VsaEs2cGhWdzcrSEp2K05F?=
 =?utf-8?B?UDBDQldLcjl6aW9LeTBzUThKQ0xiU0tkSHQrVy9FdnpnMllBUEdTRy80NTls?=
 =?utf-8?B?LzV6QStoRU5laUpRTkk5QjlDbWxKcHBidzhOWXFJcG1HcUdZcVF6RTVaRzVl?=
 =?utf-8?B?Ymw3Z3h6Zkd5OStLQi9MM1RWVTYxSlduWGJSWkZablg1bTJ5UXFFT2R4TUlY?=
 =?utf-8?B?b3lmbmxOMlI2OUZHTFJLOXVSeXdVekdraUFHNzVNVGhRNUQxYThmWnV3UG1j?=
 =?utf-8?B?eUkxZm5SOWpMb2RDclp6bldHWnc0VE5keHFhR3ZrME9rNFBLdkN2ekFkZzJK?=
 =?utf-8?B?VU5kZnJnSUJwWjJSMnhWMlROdEg5TGYyN3B5MFZIUnVBckpqTlNWYU4xL1ZB?=
 =?utf-8?B?R0JjbGhqVEYxOWJRVHlkMEFSUzZWMUZuU2oxenV6V0NZc2dzWW44TmJsbnFE?=
 =?utf-8?B?ZitHK005cDJudGZ0Ylg4OU9OYkd2ZVNveGIzM29iTWhFdHFGUFF6RElXN2lz?=
 =?utf-8?B?aGdZbHY3QzgxK0hKWTVPT1lzUEp1d2c4LzNLRFFrdDRsZkptWFovL081VEFu?=
 =?utf-8?B?Z3ovdVBXMnZLeW15dHI2YWgwbjlXMVR5RjE4cVBaaWpMREo5NXJtZTNwS0dk?=
 =?utf-8?B?OFI3cjVqbUdLSjZIVi81NVcrSVd4Y0UvenVEVWVTZlVWU2lhQzExaVRWREdR?=
 =?utf-8?B?ZkNLWE1nRHoxWHdaRlhGSWxKdk82dkMwbEhHV3hTV3ZmWldjdGlIOGw5WWRN?=
 =?utf-8?B?c3BDU0pmb2tobHptWEF1R3V4ZEhUdEs4c2FtMW84eFFUeE9rZlU2R3l0enFY?=
 =?utf-8?B?YUVFRjY2N1JBUHk0SzNhYnBTVjZlQzZSWXNBWmJPMDZoVjBBcUhidnp6cERI?=
 =?utf-8?B?SGtPSEtONUpqZndpaVg0ZDR1MGJUNWpHeXVLbHpwcC9XSVYzM3lQSGpZdjBI?=
 =?utf-8?B?T25POXhaSEZoNVAvRWo2VXlBMEJKdytLYnJnMUgxZEl0THcxZTN5SlhmQjVi?=
 =?utf-8?B?S1JJMHdsdFg4RFdHaS9sR2hMK054QzhHaWtndHBLZnNPWHE5TjE5N05EbktW?=
 =?utf-8?B?aFZBR0RsUjhIWFQ4VEJoZnI4aGFzZCtOQTFBYk1wdkxyTW0wYm9PTjhDUGJ6?=
 =?utf-8?B?dXQxUDVqSlQzdWFpcmYzc1BkSXVvbEVnQVN6cjM5VmpCUU9hMU5DUTBsdmNY?=
 =?utf-8?B?QjAzY3BpYWpVMFNKZ3VmeW9NQjFENkxPYjdRNDZnemZ6SkpZUEZwbWRldW5L?=
 =?utf-8?B?U3NuNW9WanpYNUVESjVidlUzWFIwb3VjN0NEdmc3SlZVdG1TaXNRbUJITS9i?=
 =?utf-8?B?RjA1Y2ZLRGdCMFJVSysyaTBCWXlRYWViaWdFbDlPb3lDR1J3ZU5vNjJvYTg5?=
 =?utf-8?B?VFZGVER0Rit0V1FvN1lPNTZHN2JBQ2ZVQWlWRG5XMVhjeE56OGxNbURnYlBt?=
 =?utf-8?B?dEpMZGxFaTJ6NXhaV3JzM0xBWXp6dHNtZ2MvcHBhT21uaC9kN1hmQ1QyNFVD?=
 =?utf-8?Q?Q9UH2zqFL0CG9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhZNG1UcnlCZEtqSWdVamZEVWxHcVBzVVZ3UWR5eklIMGVPY1g3MzFGbWZ5?=
 =?utf-8?B?bTdzN0d2Wm53VHVZeFZOSzR6VkhuRDloR1VKWFRzZFZtWlFxWHNLcnUyOUUw?=
 =?utf-8?B?bTZVc1daT2xHN09lbVI0ZWhmOUlqMXp3L0cyVmh1b3psbUJCeUNvZUtpK3c1?=
 =?utf-8?B?UXo5bnoyN0M2ckpsSUZvZ0E5aHNiZ2tZc0hMcU9CUnZxQkdSRHBBbzBpZHhD?=
 =?utf-8?B?NERGTnRrRDU0NEkwMkpuaUhoVjkxUE54eE5tdXhHeDhJVUVoZldRendpY1NH?=
 =?utf-8?B?UjBqanZKdGVRWHFHWS81cWE1OGh4Q2JEMWphZ2MzSE1LMkllZnIvOTJCMDZ4?=
 =?utf-8?B?TlpEQ3Q4Ync5cEFnRmJXdlhPNnBWYzMySERxOWVkanRBR3hqRW1MbUsxdzhF?=
 =?utf-8?B?MEgxL2VZTmFxSUhJZDlIbHFKVzh4QjBaSDFqcHNWZEZ3UnR2YW1qRnorYitR?=
 =?utf-8?B?TUNJZ1lxNEZzUS9TODgwcmlBWHVpVFRLZTZsRG81Zk5NcExCTXdtMzhGaFpp?=
 =?utf-8?B?ZU1vUmtJdzhtcUdmUkg2WUJYYndNK2hvS3AzeFpUa3JTYkZNVVZpU3Q1OEcr?=
 =?utf-8?B?WWc3dHZDemdNT0JyWE9hZHlXR2M5bTU1TWtLUnRXbkU1OGlwK2RWNUMyeEFV?=
 =?utf-8?B?OExoS0NtS3N5dkd4UTNhR2xHSEduU0VnbUo4RlgrSUQ0RkxEQ0pycDhNOTB6?=
 =?utf-8?B?bkFWOHVsdlM3MEsxdjAvalNaamF2S2kvM1o0alE4c24zc0x3MGV1bFlSVEVj?=
 =?utf-8?B?L2hlbjFoSDFCanRrbkY0OVBSVzRJeEdKOTBkd1JUSmhwR09NZzVZUnNYNlZu?=
 =?utf-8?B?N1VLTnFxZmIxa0phdmtuSzEzNFd2Y0FCdTFLdDN3aXFrRXB1OVRSZ1VBSEFW?=
 =?utf-8?B?MWR5VG9uWDNEV2phV01XYWFTdFEzV3lGK2xHVXg5ZTUzd2VaVTlPRlZpZksw?=
 =?utf-8?B?SzlpMjJsNU5VeklxeEk4YW5YYy9DTG1Ma09vUG9WeG1pUzJHWnM0b1VRNXo0?=
 =?utf-8?B?d3hHUVN5OUgwdmhHLzRQbGtzalBpcVExVVlQbzl6VU53YkxpYWpOZzdVM0dt?=
 =?utf-8?B?WG1EZi9xRzRla0tsOHNXbmRVa252WTJKVzBKeUJONWpqeTJhOVRqOUFPSVVE?=
 =?utf-8?B?WGh1RHkrUDJPUnFUQlFMWngxbGQ1YnJpTXJoNmNLY0c2TnR0R2dPdnJncTB2?=
 =?utf-8?B?cCsvT1kxdEw4bm16VDNTT1dRMjZaMTZpNUVvcmhmUVBjeHZDOEVYUk1rV2R2?=
 =?utf-8?B?b3RVbHFwSUpNc2VBdENPaTVDVFFDaTRNUGM2dXVJejFLZzlUUTZKVUxxVkpx?=
 =?utf-8?B?LzdZbUh2d09VNEorYyt2UnB4cFU3ZExUQmNwUFJjeEJiRTloMzVYeDRpd3BQ?=
 =?utf-8?B?Ui9IamdacVkzcWRzVkRuTFlFYzlyVmRwSmI3Nit0ZXJhWDBDQmhLNWJ1aDYy?=
 =?utf-8?B?VFVEYXpYb05WUGRFc1V2U1pXNVpDNUJOMW9IcUdGbHo1SDUvSU1MdC8rMTEz?=
 =?utf-8?B?QXI4SFZzY1IzN25GMVRnZUtlR0dYOGJlUGZVQkRwT1ZVc05QN1pwL3ZsdVBo?=
 =?utf-8?B?VzNJeGdaZ2tnUUJIV01vZzA1aEtoMEpSUzBxRUhic1BrYUVhNzFXVGhSNzFv?=
 =?utf-8?B?WTFxOFFhMkt6L2FwZWtMVlp6TGgxK29XV1dJckxrRllYL3A5d1BPVkZmdjN1?=
 =?utf-8?B?bjdSdWc0cWNKMTNLc3VVZVlFaXVpS0pCMEpTNU5RczVOR1Z1VnJvQ1VsUG5o?=
 =?utf-8?B?VzF4REl2VTEyZmZnNkp3aEcweFFpVGRtWTlrVlNRQlpzZVZKaUlDbWJraDdn?=
 =?utf-8?B?azJrV0dxQmR5bkoxbHVtZk1vZlpnU2RrRzhBVU5RcGJJZTBVbEl4TGdjTEVG?=
 =?utf-8?B?UGRyMkFpQTNjTGF4TGNRckc4YmZNckZaTUkwNjdZZWNvczUxa2U5NkltMHhD?=
 =?utf-8?B?QTU3VDN4Mk1IeUl2OEtSTW5pS2lmVDNuWVBleGJtcmdsVEhrT1FrY3R2Y09n?=
 =?utf-8?B?emxKSUFHelE1UkQ5Y3pTaUpsTzZTaVF3Z0xXT1hOS0JwSkY4cEJXNWZEWjNT?=
 =?utf-8?B?QzNCZ2hBUk9YYXRia3Q5VW9TUjU3N0JEeEFlOS9JRW5iS2p1Nk50QThZWmpj?=
 =?utf-8?Q?I8xn6tpfOdHSD+UMhBJ5yabVy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e692aa5-df7b-4306-8d93-08dd6c47b86f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 09:22:25.3029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3SAmZ5vthV7IyPP2s6ikgsBrbqmVwy/Z3spJPZfDBNltrzm7nwDO474L624f/Mh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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



On 3/26/2025 1:43 PM, Asad Kamal wrote:
> Use gpu_metrics_v1_8 for smu_v13_0_6 to fill metrics data
> 
> v2: Move exposing caps to separate patch, move smu_v13.0.12 gpu metrics
> 1.8 usage to separate patch (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Patches 5 and 6 are -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 22 +++++++++++++++----
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  1 +
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index f8489ebbd2ad..4f767948b172 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -507,7 +507,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
>  		return -ENOMEM;
>  	smu_table->metrics_time = 0;
>  
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_7);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_8);
>  	smu_table->gpu_metrics_table =
>  		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>  	if (!smu_table->gpu_metrics_table) {
> @@ -2468,8 +2468,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>  static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
>  {
>  	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_7 *gpu_metrics =
> -		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_8 *gpu_metrics =
> +		(struct gpu_metrics_v1_8 *)smu_table->gpu_metrics_table;
>  	int version = smu_v13_0_6_get_metrics_version(smu);
>  	int ret = 0, xcc_id, inst, i, j, k, idx;
>  	struct amdgpu_device *adev = smu->adev;
> @@ -2495,7 +2495,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
>  	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
>  
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 8);
>  
>  	gpu_metrics->temperature_hotspot =
>  		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version));
> @@ -2648,6 +2648,20 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
>  					SMUQ10_ROUND(GET_GPU_METRIC_FIELD(GfxBusyAcc,
>  									  version)[inst]);
> +				if (smu_v13_0_6_cap_supported(smu, SMU_CAP(HST_LIMIT_METRICS))) {
> +					gpu_metrics->xcp_stats[i].gfx_below_host_limit_ppt_acc[idx] =
> +						SMUQ10_ROUND
> +						(metrics_v0->GfxclkBelowHostLimitPptAcc[inst]);
> +					gpu_metrics->xcp_stats[i].gfx_below_host_limit_thm_acc[idx] =
> +						SMUQ10_ROUND
> +						(metrics_v0->GfxclkBelowHostLimitThmAcc[inst]);
> +					gpu_metrics->xcp_stats[i].gfx_low_utilization_acc[idx] =
> +						SMUQ10_ROUND
> +						(metrics_v0->GfxclkLowUtilizationAcc[inst]);
> +					gpu_metrics->xcp_stats[i].gfx_below_host_limit_total_acc[idx] =
> +						SMUQ10_ROUND
> +						(metrics_v0->GfxclkBelowHostLimitTotalAcc[inst]);
> +				}
>  				idx++;
>  			}
>  		}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index f28b1401fc76..2a8f42dbd9f5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -65,6 +65,7 @@ enum smu_v13_0_6_caps {
>  	SMU_CAP(ACA_SYND),
>  	SMU_CAP(SDMA_RESET),
>  	SMU_CAP(STATIC_METRICS),
> +	SMU_CAP(HST_LIMIT_METRICS),
>  	SMU_CAP(ALL),
>  };
>  

