Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45DCCCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BF010E89C;
	Thu, 23 Oct 2025 07:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vubj+DHF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D6410E89C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 07:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4/fmJzKTDe7yskWqbikLov4GVc0y3LDpt5NAPC43As4shFABsg1MTfBZLUhstni2zW4O99wOiJa2xi94rMakqIeGlkb4Hetd+LRLFA8GXY56WSMVhDVqG8PYHpdhPnKW0sfl5KMfgM4IIYMy/v6bbHifL/1AAUvb7u5OpWcqpcVXcyPdN+W2EquHRKthGdY1935adIlwenhfQwhIuZZwg9J8cOxCuipSITDE/ypFGeY92d+fMZq647/VYwV0jDx97I9EYF8L0igC4sCz9zkATWT6U2ZZW5QND3riY/4UIInl2pGedIiq79WOz/wKBceAHyoDi5Te98IEBtNgJqjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oLVUt9Hwz2koc6ou+2rKU6JZH5ozvbT3Tg+IQZwBhE=;
 b=HHe1UETomAEF2Wf1I/9BeqCG3AkfeQB0GowyP3BD0ImXJSyC2y8Yy7KcvZUTxpNBUIXCW2te9ZOWElzNZ+eb+ExkVKoEFy0l0IhBDNzrPAIRtFWxnFJHmkKpvbTBUFMpGpjOcP39zHGT+rkJ5LrLCy7zkQqK3DrAa4Cio//2vrLTMWJimkRtOTKUe8G+bL12g+jOGd63M1/aaar1laxGb2UDiVwdqqys14tMHZSjLbjzdcgG0Ih1/m/PbkIH+fmyH+VF0NzCjKo03cQjQA5V39NBwDseRNP5WOe15T0nhM5nlZ+Rr7DoEq4psEOwPQ9XLgMRcFD0fTwWL7qhBdFtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oLVUt9Hwz2koc6ou+2rKU6JZH5ozvbT3Tg+IQZwBhE=;
 b=Vubj+DHF3DzUmDKxv2Gb+udDjXqvluB4EG2qv1WORu6Wi8c4NiuB5KK4gNzx94Cf0qcp6zMcTYRyRO4+KFg4UKR7reM1DUyXZgHs4xLWWyWcCUI6n1jaHQMiv/ByUdEs+Gc4/qZ4rd6OQ5xgZmx1yh+ByOL/Ddy1IDC+8lQl+yY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:48:07 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:48:07 +0000
Message-ID: <dc5cbf60-d73f-4590-ab7c-0ac3e919fb5c@amd.com>
Date: Thu, 23 Oct 2025 13:18:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: null check for hmm_pfns ptr before freeing
 it
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251023065848.1664757-1-sunil.khatri@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20251023065848.1664757-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: ed085ed7-8de9-4395-1183-08de12088145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3UyNy80eEpOQ1lncU04cFJJblJlb005WlNEMlE3Q0UxaGZvNSt2Vis1eHJW?=
 =?utf-8?B?TmVJTWdJWm9GR3F0bmxXYVozdTR4cTFRM1VySytOOEtXREV2ekdVcWEzSml6?=
 =?utf-8?B?d3IzMzEzQ3BRVWh0enRaQm16bGlxMHpDUS9kTk5kSm56U2Fqd1hiazZ3NW40?=
 =?utf-8?B?OTJTMW9MS1IxU2VkSG9hRURaaDBLdWlHRkJqaGZkV2k0NDJFckpCeWVrTkdl?=
 =?utf-8?B?akJHankyR1RYUitqNDZ4c2NYcUwzeTZteGsrcDA5RGdWT0JuU2lSRGloUXJx?=
 =?utf-8?B?cWdyMlljT3VUOExmZDlxYVhHeHJVUE5Ua3hGTkRaOUFzRU4xOVNxRFhvbi9U?=
 =?utf-8?B?WUdWSkt6MXR2MmxiTVJ0eXJMOHl0T24rY3hDMldVaUx6VWxPdXB2c0pJUi9W?=
 =?utf-8?B?RG0xc3piQVlKcG81VlRxUERKaXdkZ0x2azRXNWRoSXA2MGtJbm5pbkc1QTFT?=
 =?utf-8?B?dTNWTXFGUmI5cEVDVjJzOFJuc1JiZWhwM3c4aXdsQzRpaDB2ZWtkS3l3dXRa?=
 =?utf-8?B?N3o3UExySCtEYnJYMVZDU0cxRks2UzUzMEpobElTM1RVWHkxZTFqNWEvK0ZV?=
 =?utf-8?B?MGJIT0VhVi9RV0xOV2NZcFRtZHRSK3dobWt0REMzbTBxRmZZeDIzaC9oaTBI?=
 =?utf-8?B?UnI4RVJiOVVVYTYvYnF4L1B0K0dtWE5maVF5RklTRHdvTHFhM3lJUmp2N0pz?=
 =?utf-8?B?Y0xmNTJQTGNIa0U4SW8wMVU4SHhuTXpZQVc1MENLZjlmSDlzdEpCUlNxdEJE?=
 =?utf-8?B?Ly9KSTZtMHh2ZXdJWnpHS2IzRE4vZ1E5ZGJUSUdIa0srSEtvYVA3ZnFQOXFW?=
 =?utf-8?B?SW1iM2RIelN6TVF0VkJDNWx3MGcreERrUGZIaUc2UGh5NDYwaHBlZTg0Wlo5?=
 =?utf-8?B?YlBZbFAxMzVUTElQVStVazhXUHBkNks1b0gvM3pDbTFLUW1PRmY4ZGxJOVo0?=
 =?utf-8?B?QURjTUVtdXcxd0xiMGVOcjljZTNjWkVFNTJVbjJaaGlwOSsyR3p1d01pM1Fi?=
 =?utf-8?B?TGZmZklOa21ud1hIbHpVUmNaanorN3pjMzBoZWlaY1VxSE9RUkE5cmtjREpK?=
 =?utf-8?B?L0ZOcXdWc0ZDR3BJUWRET3JadXh4alFRM01jeVRPQUYxV1JTdmFEcDVMODFW?=
 =?utf-8?B?SDloWEVtRThmWEdLYW9Kckw3ejdoZHZuUkNrUXFtWm52NFpyeTFGYjlOTGwx?=
 =?utf-8?B?akNUSjJ5Q1BieklPMWNCY2pZa3Qzd2hEem1WR1dnYVc5cGplVWVnNHNRL3Jv?=
 =?utf-8?B?THNReUJIdmx5V1Zxak5rR2taWGw2bk5QQ2p5aXM2T2NWS211Mi9wMkZvcWE3?=
 =?utf-8?B?SU1IL1VjVnlZRzVmZExnK2ZueVN6SVh2SmVFRk1OMjg1K2o0U0JvTEdHdXhJ?=
 =?utf-8?B?YXBFT0wyRGxSK2F0QjhhMHM4OGhWUmt6SVpIWWJHRzFLSDBsWk9Eazc4bFk1?=
 =?utf-8?B?ZE5Oc3JCamxESFFGbjN4MGw3WEdEQnFnMnVEUk5vZFBOa3B3dzNLeE5GZmJF?=
 =?utf-8?B?cU1WS0c2eXlON2tUQjFwMWt1NHJoakFrUkYyOXpuVis4Z3ppQjg2RFRsWU5p?=
 =?utf-8?B?M2l5bUF2R2FMTzRhZmFjLzBtZGtoWllBRGRnaU5ac01sM3lUQWZSekU3WTh4?=
 =?utf-8?B?anFOblp6NmtLQzUvSU95QWpMOWlCWVZoVnhIQ1g5ZGNwUmVIMTBLbzJTb3RP?=
 =?utf-8?B?bTQ4b3NESTQ1bnhzZjMwRDhBdEJmRTROWEdrRW55L0FBcnRFWVJKdWR1VTlP?=
 =?utf-8?B?ak5nQW41ZGI5OVl5Tzc5MVZJQzZQNGQyL1gwVFQ4b1hCYzVqSEZxY3h6bjNo?=
 =?utf-8?B?Und2Q0VaYndBMEY3YXU3KzlUWlY2eUZabTE3STRZb05BeGF1Sld6SlBsVmFB?=
 =?utf-8?B?Y2ZFaDVqSTk0UVJsSFF5MGl2bllBTjZocnM1RHR5SERZaTVJT2F2OHYzOXgv?=
 =?utf-8?Q?+3d3bh6u1/lO3DwL9Nb1kp+dxDdOYJ9y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29LUWhFZ2c0YUVvRVh3UjFHTmxiRytjYS9PL29kOENYWGNnSEIrYVZRODY2?=
 =?utf-8?B?TVBYWUs2M050b1R0Q01mQXJpQ3hlZTRQUGRFbjQvbkZqQXcxN2x3MTE2YVpT?=
 =?utf-8?B?Z3NEVXNzVXRlYnp1MG4vUjZ4ZEkxWUtyZ3ZiTlBoYVNIUTJlaVJ4a2R1ZUtY?=
 =?utf-8?B?QjNYRUhSSVFMci94eDErTjhnVk13M2ptOGpTUlZqVEpCWGEwS3RNaTFWdWlJ?=
 =?utf-8?B?aTU0Y1Q1NlZUK2JjMlhSTkU3SlNhVm5ZL3FvSUplaTRIZ2diNWVRcllLbTRm?=
 =?utf-8?B?YVY3QStrUzhiQmZnU3lqdWRSaCt1dlJzRXRaVmxCelAwclRIdFNPYWN3YmJC?=
 =?utf-8?B?RDhwWFNYdmRsVzljeGduaEFlQjVhQVlpdXBGakZxZVpXMHZmY1FlUEwrbWRj?=
 =?utf-8?B?VmVDSTJ0ZHFQOU1LUnFWMzV3UW9jNDBFWkJEbFJEWjFmWXJhSXhRZUdxYkx3?=
 =?utf-8?B?N0UzUXBSdmxqTlJST1JsTmN2TFFTMmhCS3dXZ2lVcTJEU0YrMCswRzd2VGxw?=
 =?utf-8?B?MGFRbWdzRnVFTVF3N3lMN3BvSnlLcDRVcjlKWDlXRVh6bytwVjNNRnF0a1Ri?=
 =?utf-8?B?U2JGYjdYQnNZbm9Zc0JEZkp0dDUxWTJ5WVlGUzRjdTdsWVV4aFU2K1NvNGFr?=
 =?utf-8?B?T2F4T3FVb1lza0Nvcm1weklnRUZ4YURURjhOaHE3SzVubVhpTUZNZDRVcWxp?=
 =?utf-8?B?ZlBOclJ0TEs2ZUcxS2NsdkgyZlJDNTJ0RTZGd3lkVWRwTzY2VlByWXcrNG01?=
 =?utf-8?B?TU1MeklSOU9qc3o4MlErSERaMk8zSFRQL0JPREM2djR6ZlY3VXlWQkpqRVZU?=
 =?utf-8?B?VDNKenQ2b0dhOEtNdkFGem4yUG8xWGI0eUdLKzJ1NUliNmxYNTNWeWMwa0sz?=
 =?utf-8?B?WTdtTlRuREpaWWpTN3VYUTZHQ0hXREZsRTRaVHRIRGgvZVdneHUxS3IvVmZx?=
 =?utf-8?B?TEpmNlU2WVJQSmM2ZjlQTURRTS9CbGxMK1pGd2hFWEhWZVFTZUJNelNsRWpz?=
 =?utf-8?B?OGpFd1ZPZnArUnlyQ21XZGNxMCttbS8zSnA4cGtsTG5nMEwxR0lFVGRzYXlo?=
 =?utf-8?B?Yi84c3gvZXgrSWw0TzFsRk10UXhEalk1MzlHcE9LMzhxS0hoSG4vMkJsOTdJ?=
 =?utf-8?B?b3V5T0FNdjVJN3l5L29oV1JUL1VXMWNITnVkNGp5ZHZJVmNubmJjc3RYVDUy?=
 =?utf-8?B?YW1zcW1IQ2VZWkgrdXFtWnZMcU1kT1c3N0pWL3Q0YTR4ZkdBa045TTQya2Vw?=
 =?utf-8?B?Mk1neFFvOEc4TzFEZkUrdzJUTWVwejlFelBodkNCc1QreHk2RERsdjcxM1lP?=
 =?utf-8?B?dDBXbUluMEM5ZGt6WXl6ZWRQZmdLeitZMG9zTlY5bWpDQkxnM3FkQWFadWo0?=
 =?utf-8?B?M1ArWHdMa1VGOFJ1UU1QUndNR1V6cmk0MFRZdThraDZHK21Zc3BjOFUwR08v?=
 =?utf-8?B?MzI0eEFkYkRNRlhub0J5TGpmZFVaYzl0dFA4MTlmRnRsYWYzYWhvdjFnSHR2?=
 =?utf-8?B?ZFczTDJieXQxQVRLWThTTzVkU3ExVUwwbEFaczBab0J2OUthTGQvc2R3MVA0?=
 =?utf-8?B?M3BXNHpRTEF5WitPNVN6TE40SStMTnJNcGhJS0htenFLejVvWEF0Y0F3aWxZ?=
 =?utf-8?B?UFlqOEdkeE9Ha0lmRzNzVUhNUlRra1dxeEd5cWpMTlUvUS9iUnRwRHFMYW5i?=
 =?utf-8?B?UVRlS1BWNFNWbC9PcjI1MzRlWUZYNWxYVUxabHlxYnphUk95SzZjZUQ1T01W?=
 =?utf-8?B?cjltUkZTbEtMTVNNOGFaUmo5ekxWbzlGMUhRUnMraW1ocnYxdGR1bEVZRlho?=
 =?utf-8?B?UkptMzkwUmtTRnFNVEgzeUhSTXRqOXJWTkdoNVhqc0RDbW1ROHZtMnl4RlAx?=
 =?utf-8?B?c2tWQjN5d0lnR1R1U2ExcEtPRXU3Q1c0YzhOTUk5T1NTSGttRVp6SWQzU1p5?=
 =?utf-8?B?emJaMkpSL2FjTHd5OFVNUkZpN3RQRGVTKzB5REVneEtPR3FnVk4vVndVTUVo?=
 =?utf-8?B?SHExN01wckszVXFtNy9hbTJKL3BhUXlVTEdiTWpjU0NkZmN5ejJDRmo3OTRN?=
 =?utf-8?B?VVB4NGRvS1VKT1RDdnYxL3ZiZ2pxUmNSTnhqa2pzMDZic1pmMURVa2xBSm5z?=
 =?utf-8?Q?8zvibEJ9Mdg0pZb48GxkElRxD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed085ed7-8de9-4395-1183-08de12088145
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:48:07.5050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kM3ck/44DcQ0GIILvNR55vhz6pk0sHAXNByNNwelc8NGEnKVt+EAYYSBTtQBJtGdzKG9rdQHr6VP/EJQusC0Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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

Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Regards,
Arun.
On 10/23/2025 12:28 PM, Sunil Khatri wrote:
> Due to low memory or when num of pages is too big to be
> accomodated, allocation could fail for pfn's.
>
> Chekc hmm_pfns for NULL before calling the kvfree for the it.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index d6f903a2d573..6ac206e2bc46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -286,7 +286,11 @@ void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>   	if (!range)
>   		return;
>   
> -	kvfree(range->hmm_range.hmm_pfns);
> +	if (range->hmm_range.hmm_pfns) {
> +		kvfree(range->hmm_range.hmm_pfns);
> +		range->hmm_range.hmm_pfns = NULL;
> +	}
> +
>   	amdgpu_bo_unref(&range->bo);
>   	kfree(range);
>   }

