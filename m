Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863ECC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 18:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E761710E2CB;
	Fri, 31 May 2024 18:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aFhIccTi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E57510E2CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 18:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfvHpxWmnY4iSDD82JprkBbq3Qy9xl8mgWh4hpX188khpKCNFcY6KrHew4HvApXhD1vBe6BGPW+6DsrBvn6WmejRFxdn9eIflIHPADdzBhQVnTGY7mKKX/g4lXG4iczEJzff7sW05i0mIIXmHyDeMTMHKUQ4fT6C0ZqPEhxac/SN01KBfmMXcGhBBTaGYRrVjXXm4MLNDNfd7GdZCR1FUeW5odIt12CRT+VqvYh/9q5HFoADdwOjHbaMFqFZOJLb87WnwYmo/OdW0TmicxdTuka0u1x3QHxzNfHdndfO6U5q1IVTQfm1RT6lHUezAnkg97FXZvJqC+gJciIDiwyFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0iQRzG7uAn1CVtVGcOCALzJ415HWNLxcQQ+Sq0zSb4=;
 b=KuPykRiwhQHyoKNNZT6Ae6fVgMfpI3OzsfB7jSxzvKrOc5NKK5Q6eYW7M6Ft5++sb00Vq8Evm3L+GppZgvegVsBMp0PVz9YACupiMzSvePJNQR3MMuNXuDupWZYAunx7hymVIH4e23NeCh8TdRk55lDI9gt8FA65ZLVcZY08MLwhRDUYW4lmF/DLRV6y7bmDQrqBPpcSAyxdVeCs9ktlZzteC9qCEHCHeT7g/02pHvNX/L8bqwDPVjfGRtm3bc+F0MQNIX/dhq9icWn4x8SjgcplKb6724WJq5cSuhS28oC3Z7BgeJt/0ucucGAHdMJ/lNFitHPj1/2P9POCOHwnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0iQRzG7uAn1CVtVGcOCALzJ415HWNLxcQQ+Sq0zSb4=;
 b=aFhIccTidivdqgbFPBDhlvrqacsWhaIMzNkFvVEWJeDvPnFBpAu68vKQZABZE48rDpldunpkIi8E0tST5oJZakiZN6rY00JII//nVnm7P1ZfH+8hxIpiKqBmtTepuNY+aHikZoliWizYcCx3M3FvciQyWnLXlxwUGlPsYKsqdm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 18:45:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 18:45:29 +0000
Message-ID: <1261b9ca-57b2-48c0-bad3-4aa7c85fd39a@amd.com>
Date: Fri, 31 May 2024 14:45:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdkfd: fix the kdf debugger issue
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240531025105.2456989-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240531025105.2456989-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: de81b92f-fc31-4abf-606a-08dc81a1d7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bW5HYUxNMDRVS3BmR1Awd05QZFpRNWc5RGJFM1lxMFZGSHpVNmc4MkZzdWR1?=
 =?utf-8?B?cm1EN1Fhb0laTXgvaml3VlN6bTdseUdxd0VvNUZpME8yRE5jWmszYWxHcWM4?=
 =?utf-8?B?RTlOOTBpL0Jua1hGR0tIUC9GaXBwT2tva2liVEJWcGdhZDNlUkVsT01qdzZj?=
 =?utf-8?B?QmFCUk4rYVBIUVFGNlBxa1R4bGJQMjR4WnA4bXRtZ1g2U093dVZEVzArUisv?=
 =?utf-8?B?VWF6dzNvU2tGaVFjTVJ5TmpMcGk1RG5LQVR0bmdkV3UzQVlXSFhjSFQwT3JY?=
 =?utf-8?B?Uml4WjJLOE5qczgya2toMEs4SmpTelJzRzhVZ0FQYmVkblhKNlBoOVEvUVQ0?=
 =?utf-8?B?N0l6Tzd5RDBDSk9XU1hGNE9BV01jdDZ0VE9yUWpjS3FHN1lkd0dTaG53dS9a?=
 =?utf-8?B?Y09LNm1OcDRBc1BxZjZIRzltSTV6STcrMFJxSVkxaGVKWGpGZEtVN3ZMdjJI?=
 =?utf-8?B?QVd0TWJJbXpPRjYzQ3FpeVU4WjZmanBIRjE2bnF4ZTVOd3g5aVdaaVJ1bFNS?=
 =?utf-8?B?RWlwZUN6TUZEVGxNb2JiZXI1d0VoTjhiekhVMjdVNVZpQWwrRFVSS1F6a3Zm?=
 =?utf-8?B?b0k0ek16MFVmYmt6dDdISFRQV2swT3huOXFNZ0M0MldKaDNpTmpTYnNhMVZz?=
 =?utf-8?B?aTlyY1lickZ3eEJBdHdvdndtRmtEOXVWZ0dEUFE4M3BPSWtJTVpKbmJucGtW?=
 =?utf-8?B?eVVIVkpHWlBZak9DazVMZ1h6ZFc2ZzM2OEZROUc1QkJTZkdocmRiMHEyc2Fx?=
 =?utf-8?B?VWNuZ1pnTjRQMDB5dGUrY1hLRzdwblkrbjFUdFg4dmtMNTVMSFVNN2tTTzNG?=
 =?utf-8?B?TkZubXR1STF4a2VLaXBCK0prbUtwQUFHcnFVaFFOU1FOUGY4eERURmpEVHRr?=
 =?utf-8?B?aVhMZzBVbUR1WkdRK0lyK2hTdDNoNHZWSEE5MW5VZ1ZXM2Fwc2V0V3FEbmtp?=
 =?utf-8?B?NG10cFdka3A2WmNsNUhzR29pbmZzQU1JU1lHYlhlcWhJbE5YVjVibmt4UXh1?=
 =?utf-8?B?d1Y1bWREZVQreGpGdG1MZUhSeUNYb3NacWlwaDVrMWkxajJHUjN0WHJpajBB?=
 =?utf-8?B?NDBkSnFsQjg4MWJFQnZHWU9uL0VydkVNQzFpNHlwTVM4T1JMVUt4N3VHdnJp?=
 =?utf-8?B?MkwxbERscVczaHhLL2pMU0VoeWQ4Z2dyZmdaUmtJOER1WXAxUlNnQzIzMFk3?=
 =?utf-8?B?Nmhnd3BUUUNzektMUTdLTDVZWEplSGN1ZWI0b3FxL0EzZE13ZUE1UGJldDN2?=
 =?utf-8?B?MlpIMHkwTUNrVzU1MVpjblRGVDgyYVY0aXAyZHVRRXNZMnlBc2F0ZEUzNHBj?=
 =?utf-8?B?Uk9PZnROK1htTVhlc1QwbjJDejVuYXo1aTdvd1pNRnY1aDJ1Q3VHNWY5dWIw?=
 =?utf-8?B?Vmo5ai9DWHlWTERydkxCZ3gzRHhjeVJySjJZckNyYUF0aDhZRDhsc0swaWUr?=
 =?utf-8?B?WER1YmtnTUZ6S2FoL2pTbEY0OTRnZ0lLa0NTYzJhVVFCTWRVb2Rjamk4RFQy?=
 =?utf-8?B?ZXVqVGE2V1FaOUdWYlZpUUNYa1hqNmkwK0c4SU1XM3JpbFYwRHp1cWlDZ3Rs?=
 =?utf-8?B?aFRrMFdXeDczVjFtTXJ1a0YyMU1CS3ZjZTdSYWVhSk85TTJHcjZqTVlGeGQr?=
 =?utf-8?B?cnZuODBPNXFzUmNGOXRFRkJnSE1OUG8vM0ZrWVhOSURpN0t2RDNMdGxUQlpO?=
 =?utf-8?B?ZUgzTTlHaUtuejRKejZGaEY5SWxtRXRBeHZoOU9qUXgxVGtPYlVqU2tnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlMzaUs5WWp5VHJUQTBkd09iTml6OHFJazFWQ2tVWnZLcWF6ZUlVUHpzaE9S?=
 =?utf-8?B?SElleHpGZU9wRHd6UCtkT1V4TjlIR3BkMXBxSDE2K2FmNUc1K3N6T09PR2dw?=
 =?utf-8?B?VlE3NmdicVpsdDd2V3lrNWpyYkFiUkRjcmxUb0dNZVluclNSUmhBUVlDbHdk?=
 =?utf-8?B?dnEzVVk5dmN2VUNRc0RlRUZmRUZiMTk4VlNRUEN2OFh1TkVDWlFaWWhPM1lY?=
 =?utf-8?B?MkFicHc4TGF5Q2pQdzltSXBTM0ZYV0xTZTZPNjlnZnNJcWhYSlVkSnFiR2RO?=
 =?utf-8?B?dE1ScDFTTXZXTzkzd0pjZGtQRENzNVR5WVBFSWJySkt0NUd6TnZ1M1RpZ3Zx?=
 =?utf-8?B?YzlkZWVQUHNDWUE4ZTU2UWdHVC9OWVNwTFFmNTNzOXJ0Z2dQUitoNHMvSEsz?=
 =?utf-8?B?eTA5WkNkRmp5dW4yMzJkY0NoZXRsQWp1dWV2M1JpSUhpaU4yWGxFcHNCaStV?=
 =?utf-8?B?S0grUnJMOWFTQjAzQU9abGF4VGM5MnpwMTkzOVNSdkpuNUgwWGJERXpTRXMv?=
 =?utf-8?B?WElqREw0YTZneTN6TmUwNVZSdjl4eXZmRVB5US8zYXlpQ2YyZEpHNUcxSzlY?=
 =?utf-8?B?Y2VBOS9QS3F5U1NUR3BxQnpqeFZrQWdkeGM5ckZwK3hSZ3hvVGIzUXA3VWg5?=
 =?utf-8?B?U1NhbzlvcGovYU9CeXl1UjlnY0o1V2RmVlVmdi9wSEVsOEwwSXVTTUU3bHNP?=
 =?utf-8?B?YUhjV3U3N1NFenhmOEdpeE4vcW52V2ZGS1ZZSExUNTArNUhHWlJMdWVBZkcv?=
 =?utf-8?B?aUFoYWlnSGRVZGtwMjBSVE1pUTJVRStOaWdmWnl4a1FYdlJqdlp4VmVNQlJP?=
 =?utf-8?B?OWR6MHRTcDdVL1g0dE04RTJQZWttbnAzYWE4NTJ2enhaT25lU2l0RG02RUsr?=
 =?utf-8?B?cG8wOW0vYkFMeTY3bEZNVFAvMzBmcGlPTlJUTTkyR3QxNHRTWDhvcGFLV2hY?=
 =?utf-8?B?eXQzUHk0WUdjMHRrL3hBTERrZjdiTjhhVmJOM0lRQ0wxV1VlY2N5MHBPWHg0?=
 =?utf-8?B?ZC9vanNld1lGanBZL2w5T25LZFI1WlJiQkJJdUZWM2t1OTczemdrbk1FZ0FK?=
 =?utf-8?B?blBSdnJ4S1ZUamFlaWhQN0dYNFdOeUk5UUhqb3A1TmhaWWYvbGFPWFBIc0gz?=
 =?utf-8?B?VzJ0dFpjSGxZalRRSUNmQVBjNDBvMTM0YVg4SEw4anBoOS9ET3l3V2d5a0tK?=
 =?utf-8?B?R3BtWDJJVmV6SEFFYmhCSHY2QXB5RjhVbE9Yb0gvdkdML2JEbFlYYUFKYjA5?=
 =?utf-8?B?em1wbm9mL09sMVpTOUorYXJpZkZtMllSYzBEY0UrOFVrdjJPOXN4OHJEOUpy?=
 =?utf-8?B?VlNxOGNyeFF5N2ZDUTNleU43VEVObWtsWVhiUWlkTUYzMzlZOCtRSDcvWktj?=
 =?utf-8?B?YWZldzJmNXFCWVpKRHpSOTRsOTZ5Um5WY3FJZkhTU1MvRHpGTFpUWGZTQjhI?=
 =?utf-8?B?WDNwY0R5YkNZcGgxOTRFa285b0IxNUVTbTRzd3UySWlHZ1poOVMvTDBtTUlp?=
 =?utf-8?B?R203aTIrdUZhSGUrZXlVQ1BPeHpGOFpXS0F6b3QvM293T2dGaEJqdDByME9L?=
 =?utf-8?B?YUVTelpCeXFVZUFkTlFpa1FOWHlyRmxBQmhwWWRySkc5Nmpkd1JqMkdMUUI3?=
 =?utf-8?B?K1BkOWxzY3h4VnNaWUQxT1dwTWFhekY4V1RuYVNGamVnb0VRRFp6Mm85VGlm?=
 =?utf-8?B?S1NXMzcrckFFTXgzZXd2VUdnZzJuc2lwVmFvTE1BMGp1WWJmNWpuZTN4VHlW?=
 =?utf-8?B?NUo4QUpGTHY4dHFodGFlMmdTYVhpVEVMOElqYit6R3liNjhPSm9XRE9oMXgx?=
 =?utf-8?B?TU13VWNhV2M1aGZTRlRXbjc2b3B0Qzl1U2FkNFpMOHcwZi8wNGpCOGQ2QUt5?=
 =?utf-8?B?Qkh3cXRseUQrSHE3UUZXL3FlcjFSUk5XZS9KWkg4dUpVaEFCK0w4dWpvU3RI?=
 =?utf-8?B?OU5HWmxrSWRWNHZjSHRmUStMWVpweVF0VmJrQnMyK0YrZjVpYXkyaVRzWGE1?=
 =?utf-8?B?cXYzSk1ic0tXUGI2cUEyakFXRVc5c0VFdWFESTlWcXVZUjRxaUJaaXVrS1pM?=
 =?utf-8?B?MDB4eDgyM1crTGV6aWNCeDR1MHNKVTgvcUUvckRnSFZlUHhLVEtBalRualJ0?=
 =?utf-8?Q?iuMn/2/B3rXDjYyUvpMqICcqh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de81b92f-fc31-4abf-606a-08dc81a1d7c9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:45:29.1229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKbvBcVtMLB3wpcBI68cC5Tyci8WuIuSMNF/SO7QZ+/uCcHTRc9mRDBujVkYnayEbBnLzYNppejozCzMS0NDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

On 2024-05-30 22:51, Jesse Zhang wrote:
> The expression caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED
> and  caps | HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED
> are always 1/true regardless of the values of its operand.
>
> Fixes: 75de8428c3d632 ("drm/amdkfd: enable single alu ops for gfx12")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 3f27bab7a502..34a282540c7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -503,13 +503,13 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>   				kfd_topology_device_by_id(target->pdds[i]->dev->id);
>   		uint32_t caps = topo_dev->node_props.capability;
>   
> -		if (!(caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
> +		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
>   			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
>   			*flags = prev_flags;
>   			return -EACCES;
>   		}
>   
> -		if (!(caps | HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
> +		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
>   		    (*flags & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
>   			*flags = prev_flags;
>   			return -EACCES;
