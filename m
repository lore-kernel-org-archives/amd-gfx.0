Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54882E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 04:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EB410E23D;
	Fri,  3 Jan 2025 04:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="adoJrgUO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1052510E23D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 04:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M40UahpOUG+2ydzdFkx8lrW0ZG67kEt94pRck5YmzPfEnpBYZ17Q7Z8r0RKdMrOcH5bfDHlYOHkbdei7VKeiBNkC2kp0Hwjsj1GpABVstQZJxGYHH/5+oGhjLXXrvByURSIrHpIG5UMVVq6zno9s6ClKgwvClL8fCWsWxdFz+fMGqwCRmtl2j/vunNimN/s1rK0Ysg9PpaEZpqRcS8/wCd29p7b8T80M2+0FFFZVmjnDemuXpP6HNVkPs9JvipFT6zMkIQXp64i6DI62m/hIhn6VHUPGGb5l0WNcUvHIg4AoibbLi/Yc9dg2p/9RwbD8OZp1Gb1J01Ckoy0jWvJHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs+Z3x1XqgMAdqa+2Xx2WRSxQYbU7DS6lYM8d0f8XNI=;
 b=SbrZdUT6ICzGkVU62xA8jdTH86oJ6Pc1KOXN9IIzN3unGvI0VUur0PUAlxUwsOcgsZCbefp3KsfZnT7tsbmiRk4w62xuDP2gj1BKu9o4pZ1WwkrSCShReli9Y15fEKDZbHvlCZpPvzD+W59vm77OgbAtYdYIaApFXV78Pu8uZ/Pj1UlLN14L82cTkLimeyOeqSkuYGoIQ2ShD8qbYeksxWR7c8osJB4QD0kbLVvWbnvWRYkSTIv/Nt38g917Xm8wB30QUGWrXJfBHEhEMcRO1m2EPRxXgIKFBuAjVsf42o9ZJ3usQacOxM07okjk9GDcjauzTXivHMerp9DdMEY68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs+Z3x1XqgMAdqa+2Xx2WRSxQYbU7DS6lYM8d0f8XNI=;
 b=adoJrgUOxHXhm1wfoy/Sy+UiocfnRETXMfxGTohAF/yHXucAXLwdIwCq+SAh/QIwfP28OLvUScu3+vPym08r8dOdHLU4NhN1MpzYEDzOWEmNYenPWWq58mw/xgoOhDap84RNbW+TdYZg0pGUgUgkV9F4pngUsVmm6vTXBbymNuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Fri, 3 Jan
 2025 04:05:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 04:05:03 +0000
Message-ID: <a2436030-b41c-4d78-a861-01240f55e3c3@amd.com>
Date: Fri, 3 Jan 2025 09:34:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] amdgpu: add flags to track sysfs initialization status
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 kent.russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <737a46d7273d625ef8a1146925296bbdf57f2274.1735795671.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <737a46d7273d625ef8a1146925296bbdf57f2274.1735795671.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea8f832-40b8-43d5-d976-08dd2babcc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1pxUmZnYkRhanZxMlRjZ2kzVHZzNnpHWjdyc1h6QnRJVHBqSFI2TUFUV3c0?=
 =?utf-8?B?amNMSDhpcC9lQ1YvSG9rMDZCWm5mVTc2UW1PbUJRbS8vZEZ6cXlzNnZxaldO?=
 =?utf-8?B?clc1aU5jL3ZHTCtPeVdyT3hGaEREL0dNbitkalozeVR6dmg0Q2Z3ckc4QXpZ?=
 =?utf-8?B?MFNJVWNkYW0wSWNiVUIyZFlRL29lNXc5bFQ0bDAxZkk4cUNmdEIya1FRQUdS?=
 =?utf-8?B?MWF2aTNUYUFQRGU4aXY0WUtTRVMwTXJmTWRoSlNLTjdWMkNYRXVRK0I4QUtu?=
 =?utf-8?B?YlBuNjJReUUrL250d3BUNTlYNlBna0F5VU1oY0dTc1g0T0ZseStpNUZKV2x0?=
 =?utf-8?B?ZHJpUE1EaXpRQ0hIQlNzNXBnbXBmYk9FK0pYSEpJcUkvMUlYMmpJdkg3T1Vh?=
 =?utf-8?B?d3p0TmFJWkxzWUdCS1FQbWl2Z1RxSlNXTktYMG9oTDJCVVVSb0RlK0dhNG1v?=
 =?utf-8?B?N2NyekVYVUxSQzAxcThSRXVGNUpjWlhBc1Q1VnMyOVBUbG9aU0J0ckVRRnpB?=
 =?utf-8?B?aWp4dEsyT3FnenBOV2diY09iSHZYazUxVlllMThnTk05emZKTFg2dzBOeUhn?=
 =?utf-8?B?UTdUaFlyaWhoNVlGbWlVRUgwTFFxZ0VCTjBEWFhpSHVCTlpSZWE4YU1vTEp2?=
 =?utf-8?B?TUVta01CUWt0RWNGNGtTK3puMmRUTGtybEJIN0NvTnR6b0o4anNxakZTdzZE?=
 =?utf-8?B?ODhBR0FkQ3UrTklRQ3FwZ3MxdVpPQm96UHI5eGxoRWdjUzJSMTUxazhFaWhq?=
 =?utf-8?B?TXhHK0N1UkM4L05XWXlJUUtuNVdobHdocllsU1cvNk5YVnZSdFZHMm9xUjFa?=
 =?utf-8?B?alNyTkczVWIyMjdiYzE5YngzeWs5MnRtaFVzN2RReXJrS0xjaWtPdFRyckpO?=
 =?utf-8?B?WDNrWDNUY3B5Nm95d2xjbkN3RWJ0NlJaS2tRRGc4dDZpeFFhUE9EbW1BSFJX?=
 =?utf-8?B?Q1IrTEkvYXZVWkFaT1NyRzIxT3ZUMEZwRG91K3pQRTFnaENETXcyckRLSTY2?=
 =?utf-8?B?R2x0bjROWnpkNjVzR1N1eU9XNkZjSm1aTWphbTM1cE54aEozTDJpTHFnZTFF?=
 =?utf-8?B?ZGgrSUdxM3lVZUtXTGhxRjRuaUJSU21OdE5ib0hrSVZhMlBkOU9NQWVWQmJB?=
 =?utf-8?B?SUFlbFU0aS9ObVh6TUNqNmhCbU85ZGlJRnFZSThhd25SeGRmZ2hHdm1ucGtW?=
 =?utf-8?B?aWF1OFdlNEIzSmU2RHRhZ3FiSlducHNIK2prQXN6bStiYkNlWktwNE5BdGpE?=
 =?utf-8?B?Q0NKQnJKc2hjQUVVci9XTkZ1ZG5ENXZxU09tNVpqQ0NGZ091aUp4T1RGOVZE?=
 =?utf-8?B?aG55azdRdFUrM3E5RHpwdnRxRE5pSXNZak1hc2pMYVRFbkdVVHg1cGVZNHpF?=
 =?utf-8?B?RXNFZnFkWVNTTFVBaklGU0JXMS9UZE9jVk5qWlpESU5XcW0xcGdpdnc3dFpv?=
 =?utf-8?B?K1ZqclR1Vm1oOXlGSmJtdnFBUEJ6YVorZGtVQzJTejlUdXBJSTYxS2VzNTVX?=
 =?utf-8?B?RWQyMEdXZ2hIMFI1QmxSUXRsR3Bzc1NsNG1nN1p1NXlNaHJ3NXdpc0lzYkFl?=
 =?utf-8?B?TTNldFpKb2g5VDg1SGh1NHkzdkg1ekNzdVhQZkRmN20yejQ1N2ljZE02c1VC?=
 =?utf-8?B?R1lucDR5eUpXbGNkMkthVUtTMGt1QktqV3NrQkRzNFBacEo1SFFQQWhQa2NB?=
 =?utf-8?B?YjNxNngrbGF4QjR6YnZWZW5tNnR1d2orQjkzcEdKUkRBdTZQbDZRcWVJYnJY?=
 =?utf-8?B?QVFUTUFVQTdsQ0xMY21jbGQvWE9pdmJRclcxVVJ5NnBVeVpEQUdrWlBTRXBa?=
 =?utf-8?B?ZHpoam1mMU9iRStKQi9XcklHd1JFMjJMRlpUSHc5L3Z5d0RHNlZNTDdpcHhr?=
 =?utf-8?Q?bPYva27IS6Pk8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dRSEZvbVUrZlp2ZjBqaGxKbGk1QUt2SXpKQTdITm9pZUs1REV4L3hmcjhh?=
 =?utf-8?B?aFdMMnRjaURLN3Z3WVJMT0xFTUVlb21aR3NvZ0ExWnNzREdhN2kxUDJ3Z2VE?=
 =?utf-8?B?OUJXVHdtQTNYeXNKclZjdGJMRW5IMng5cE9tS29zM3NtVS8rc0Y0ZHBML0Zn?=
 =?utf-8?B?aEIyclB5TzNNYkNCdkpsOGRvKzVCVW8wL2N3MHZRb2pPbnNVdXVsa0l5c1Ni?=
 =?utf-8?B?QjFOMUtIMmtMRExyeVp6Q1lnS2FlQmNFVlNSMHZJSmF2L3hxRVRwMmNCNEw4?=
 =?utf-8?B?Vy83eFQ3bTdrNzhrNzdYMlkvcXR3R3JtYjd1VEpwcnREL2NVbSt5MUlCc1Nv?=
 =?utf-8?B?UXRLOFZUc1Vhamt4Z1lVSXRsekc2Y1d6dndyT1VtUVprQUVqODlWYkpXL09t?=
 =?utf-8?B?anhybVZ5bE9pN2crTnhzbnBnVFNtczI3dlJhWkpuWmk4SkdlWnV6KzZPcUp2?=
 =?utf-8?B?czVJSm9La2VrK1BtUzFteW1Xbjh4UWdqUVBzR2NsQ040emRPeXJuaTFGOXpN?=
 =?utf-8?B?ejBiTjcxWG5FaUpSWDdOeW1IT0pEZkRIeE5CSThWaXAvN3g5azZWZ0JpaUFo?=
 =?utf-8?B?TmV6OW5pNDJXY2pCUnU0aVhZRlNRdHZkUGE0OEpGUG5wbXNreHRKVFM0eDBV?=
 =?utf-8?B?RHJyeTdlbGdiZ21xNlU4YkxYSC9zY0UzQU1oRmkwc2laa3VvVGhjVzVrYkda?=
 =?utf-8?B?YjlvMzBJOW9nYlJqT2RVZkEvOVpjMGUzN1BSR3FKMzBTSXh3d3lOVkdBUExl?=
 =?utf-8?B?L0FKTDdHdktlVzU4TXlCMkhBY0tkZUJicmZFblc5NWtTdUZVVXNSdUtvc3Iy?=
 =?utf-8?B?UDROS2JFUFM2eU9DVlJ5SXRxN0FQcWFRM3FVQjZsbzVRMUl5ZHFidE1sTjlB?=
 =?utf-8?B?N2JkczFrWEpBWWNGVGNhdk5VR0pwaUhVNlk0TkY2MW9LaTY4ZDJiVmNlU2xn?=
 =?utf-8?B?K2JnWlk0VmhHMjRweW9ncmN4cnNzMEI4MFJZdWUyYnp0NkFyR2tsSmc4NzhE?=
 =?utf-8?B?cEhlRVNJK1gwUURYUGZmcWtEQ0M3WEtPam04VjhtNlI3emRCT2tIZWZlKzdo?=
 =?utf-8?B?WWFKdlRXWUdZVmJlOFdBNHEvek15MHNpdUtCRVl6ZzA0ZFEra0lUUlNhNW5l?=
 =?utf-8?B?bWZnL2llUWkyM0hZbUFPT0xqRXZrNERDdG4wZWJWYWRkVW4vblNnMDYvSnU5?=
 =?utf-8?B?TWU0M0o3TTQ4Q3dZR1ltaTBCSVZQVmNJempjOG9DZWlkL2VZUW43d0xzMHl6?=
 =?utf-8?B?OXorSlRlUnF4TGsvYm0rZWZXSTRYalA2TklPb1FqK0J5cDVFaWxQR29sUEk5?=
 =?utf-8?B?OGtMTXRGWkt6ek44aEE5Nmo3VEYwTnlCRDl6ZHlzUWpJRlZhbFBoMXlBZHRB?=
 =?utf-8?B?S0xLSnJpK3JleDNXMjVKd1l0RVU3NTBFaXNiSG5oeXpON1ZDRFhaVHYva1VP?=
 =?utf-8?B?WnpRdDhLL3JVVUlEdHpzYlh4bTRKeWZXOG5ZTmlWMUVMOUdmajNtejNnV1dJ?=
 =?utf-8?B?V2F5TzE5a1VaQWRlV0U0N1doRlBGZlFTWXlyQ0hQcmZ5MjV3T1pNWGlDZTFi?=
 =?utf-8?B?NlR1WlVKcDExaWl5Tm1Ed2xDV05WTjR5SVNMa3RpeWU5R1o2VjR0YmR3VmtU?=
 =?utf-8?B?NXdSYTJRS21uUHNkMnFmYm16TUgxRzZLMzVodGhzWWVyaTFXUW96RTliVTZY?=
 =?utf-8?B?Y0oxZHhYOG4yZ3ovbjU5d2gwNUw2SVFBL2E4OCszMC9OQWh4a0hKL2VRVTJL?=
 =?utf-8?B?ZXdhaTRQeVEwcUJHN0JVRzJsWUFPTHdHZ2lKS0hpNUNyYlVSWHY1RVFRbjNE?=
 =?utf-8?B?RjN3WnhvaVFOZ0w2T2dkdTZodytPc3NPcHMySW50RFVTVmpvVEVNOFBMZVR6?=
 =?utf-8?B?Y0o4WWFKdmppQ2U0Znp1aFRXdlcwaWFkNDV6TmsrdzU5MTVwTEpWUkZXa3NB?=
 =?utf-8?B?YXlJU0VaZ213S1J3U1BDUFg1UWZhMVB5Wm9BLzRvaGduQmlIUWxBYmxUcGoz?=
 =?utf-8?B?M1lCNzRmZDBhTlBzeDN0QzFzTXpjcXFuSWtkTnRhUXdLeEhJSmUzbTdyQkNI?=
 =?utf-8?B?N255b2dlTmg5TlFRUzFqRG1qS1JrbWNjWGdrOW82clh3RGFFZTI2elNwNTZ4?=
 =?utf-8?Q?mDFodAZYdVCjYL+Zu8c77ACCM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea8f832-40b8-43d5-d976-08dd2babcc7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 04:05:03.0326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jgSOfeJnAmYcd0dMA4oMgW33q0+S2exJu6tf8EUiDlVw6LvAPDp2LypfsYSobCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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



On 1/2/2025 11:06 AM, Jiang Liu wrote:
> Add flags to track sysfs initialization status, so we can correctly
> clean them up on error recover paths.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 +++++++++++++++++-----
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 22c7e9669162..e4b13e729770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1157,6 +1157,9 @@ struct amdgpu_device {
>  	bool                            in_runpm;
>  	bool                            has_pr3;
>  
> +	bool				sysfs_en;
> +	bool				fru_sysfs_en;
> +	bool				reg_state_sysfs_en;

These are not required. If the files are not found, they are ignored and
not considered as errors. sysfs_remove_files() returns void.

Thanks,
Lijo

>  	bool                            ucode_sysfs_en;
>  
>  	struct amdgpu_fru_info		*fru_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d1bb9e85b6d7..3244966b0c39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4533,8 +4533,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		adev->ucode_sysfs_en = true;
>  
>  	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
> -	if (r)
> +	if (r) {
>  		dev_err(adev->dev, "Could not create amdgpu device attr\n");
> +		adev->sysfs_en = false;
> +	} else {
> +		adev->sysfs_en = true;
> +	}
> +
>  #ifdef HAVE_PCI_DRIVER_DEV_GROUPS
>  	r = devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
>  	if (r)
> @@ -4542,8 +4547,21 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  			"Could not create amdgpu board attributes\n");
>  #endif
>  
> -	amdgpu_fru_sysfs_init(adev);
> -	amdgpu_reg_state_sysfs_init(adev);
> +	r = amdgpu_fru_sysfs_init(adev);
> +	if (r) {
> +		dev_err(adev->dev, "Could not create amdgpu fru attr\n");
> +		adev->fru_sysfs_en = false;
> +	} else {
> +		adev->fru_sysfs_en = true;
> +	}
> +
> +	r = amdgpu_reg_state_sysfs_init(adev);
> +	if (r) {
> +		dev_err(adev->dev, "Could not create amdgpu reg state attr\n");
> +		adev->reg_state_sysfs_en = false;
> +	} else {
> +		adev->reg_state_sysfs_en = true;
> +	}
>  
>  	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>  		r = amdgpu_pmu_init(adev);
> @@ -4666,10 +4684,12 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  		amdgpu_pm_sysfs_fini(adev);
>  	if (adev->ucode_sysfs_en)
>  		amdgpu_ucode_sysfs_fini(adev);
> -	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> -	amdgpu_fru_sysfs_fini(adev);
> -
> -	amdgpu_reg_state_sysfs_fini(adev);
> +	if (adev->sysfs_en)
> +		sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
> +	if (adev->fru_sysfs_en)
> +		amdgpu_fru_sysfs_fini(adev);
> +	if (adev->reg_state_sysfs_en)
> +		amdgpu_reg_state_sysfs_fini(adev);
>  
>  	/* disable ras feature must before hw fini */
>  	amdgpu_ras_pre_fini(adev);

