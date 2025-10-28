Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BA7CCD1BF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 14:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE1FE10E233;
	Tue, 28 Oct 2025 14:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bsPPES6Z";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70EE610E233
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 14:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci6DCtnl/6tzSZm3P0z2yRY9fl9DttR6gn1Rf1kwv5p9aNDQE8R613AeRUvgQZktx8jBWPt1rBvFgsYhvNGVXdUZ+i7MbGybxLY/wG+/UKPzA8IORg1bpxuMmCgcTzP+HXvJ3adle7ZWCYvLRh7LnNn49MUy6iIO91k1VqqZ47jd/jKVg84G2fcnN3VAuVYnbuSQVHvp6KZePrTocefqAjjWZAOsITbzDbjd8sVpyr9ICHFobRhoeppiRHs1h9Mu+xgcO7hKWZUcE2wSJORhybRyLRWicRpahIMh2MbrhNm5zmC5vT8gKsXIr0+HZ4D7ZrgwCL9Lplwy9xMPdT208w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOLoc2E4739ix4X0W1nXCmYvgADeCrpscqLPu4jIJ00=;
 b=njjogKh2GIlQjk2n1jlFGqHJOy2sZ1KE9WzoNV1DT1IyqZweET6gnC+ibdZSVs6oytjQqUkMr4mvtLUuHsruKViOw+Xf8H/rHjjPMql3t9eTzrIw1e7BPv2lA8TLKEpqxE/yF5mVBtcvE2vquXp1MCNf1zWT69onIib74rFVDAixI5x97JBff8obbKVM6ARAw1v56GeGGASrh5xaIHTDDkZY5jYYdA7fheh8BrmBmrvMjKIASvqeBUd4Ky+IPrVGE6TootZBDs3d6zUe6jhaem6rBlIvwlVrmW+LjxWRSUYMR0eAQCqGTo6X4kf9GNjCJmEU/tvIaTrau2GqsJNvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOLoc2E4739ix4X0W1nXCmYvgADeCrpscqLPu4jIJ00=;
 b=bsPPES6Zj8tpfyV7yLZxxO6lF+0feyjb8RPxYMUOKUmJtfRecR8d0QPUako+B2qJvL9fDuAbjuhdV7YT0IycUkhNiydA1MmEX3LuWQU2TtzHVaR5fgGWT7/QmnorEY4NcguUUIJ2itfNVXyqEAGONp05W6mzVY4ke1SjBMZj344=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Tue, 28 Oct 2025 14:57:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 14:57:45 +0000
Message-ID: <b7799043-efa7-4392-a7a5-941580820d42@amd.com>
Date: Tue, 28 Oct 2025 20:27:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove invalidate and flush hdp macros
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com, christian.koenig@amd.com
References: <20251028141328.3302820-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251028141328.3302820-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fc0269-c1b6-4ce6-a7b5-08de16325a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnFSZnJvNWZxRy93b3kzQWladGFuYkp3ZmRIWjJkOWx2Z1BBajJrM1dmK0Qv?=
 =?utf-8?B?RG44TVhkVDZBWlpNVmE5WmlOenA0OXpMVnYvbEVwY2V5OC9tdUdoMTNaSEpS?=
 =?utf-8?B?ZUtTbW9nWGQ5NERUMDFIcWdUbGZZd0E1bmY1MkhPaVB1cWtjbTRkdkprRVBX?=
 =?utf-8?B?S28vdWJMUlBwbDJ2YS9yVXBudGpyRjI3L1NTRFNWcWdFVjY3OUJqYzgwR0U3?=
 =?utf-8?B?UlJXTCs2ZlJIN0l1M2dsQ0tFUW1mdzdtWkRUK25ySkFVYnJrbFdlNkVVQkc0?=
 =?utf-8?B?c2h6UnJ5WkJ0ZmorcXRKTFJkRWVGaklHQWdEV3RxbGJaK1Jhd29oODdlVW9L?=
 =?utf-8?B?TElBbDVuQW9RcTE3UVR3U3RiS083Q1J3cWtmSHFERG0vUGp5eERLa2I5emtm?=
 =?utf-8?B?WW5PdmhXN09rT3B5YTcwazQ1TklYWlpFNklzMXdhWU5sY2IzcitsTDdKb0J3?=
 =?utf-8?B?ZzRxQmsvRGxjclFaMFd6dE9Jbmp0OVJKUTRrQllyTzEwZE5FK1NxNmZQbEp3?=
 =?utf-8?B?ckhOVisvQVpjNVFtUlpkeGxoam0ybThVeHp3ejN3aWNMbnV4RVJsb2dyZXpY?=
 =?utf-8?B?bkY2V3NhZ0FsRG1HcVVoVzlwSjZoVU1keFg0c09Eblhad3gvSFhkbVNzT1VF?=
 =?utf-8?B?UjRoU3ZXbXlndTVYK29SSGFZR1BWSUJYZDNYY01pQ0pUZXZlY3Brc0E0cFdR?=
 =?utf-8?B?SGtFV2ZsLzdDYlo2OVVJeGVRSjNjRXZHNTViOGJBYlo4R3ZFZHh1bE56ODJ3?=
 =?utf-8?B?RFVMVm5UcnAra0JFaGJZcTAwQldjREtIaCttOUJERHdDRDBMVXI4V2RnYnVM?=
 =?utf-8?B?a0k5YVU4SCswbWlGYVM1NjM5Tjl0aU9IS2IxdGdFaTdudzkybXd1amJ5ZGtw?=
 =?utf-8?B?WFR3TGg2R09ISWpObmllYlpKa3I3ZXZ1MWY4OTJGeFpRcGMxNTJ1ZUFLcnBF?=
 =?utf-8?B?NU05OHFEWFhQVnpKRmFub01YT0wrbWtjUy8yc3FJTkg1bE1lZDR1NnJnS0lV?=
 =?utf-8?B?NjJOdVJDU2liNE9Bd2dsb0VicTA3ZEw5Tmh3N1ZUd0RHRDdkNkF5S0VWMThH?=
 =?utf-8?B?dy9SZmRadkUxVWo4aFRGZ0RibXpoUlN6ZS9UREs5TldQYS9HS0JTSjNXSkR0?=
 =?utf-8?B?VWpUVStJM0VUbEpQSjlRdVAyNjhTeHdEKzNYSDloRFYzci9RaHNEbmVJSkho?=
 =?utf-8?B?cUowWS9PZDQxUkY0clZnYUFqZHBiajhyMjMwZkNvd3A3UUdEMHMxTmEwUUli?=
 =?utf-8?B?RXVNckM3OGhPK2ZvT2piK3JMYnBYaERpNERsU3F5WmNEMms2b3IwSTgyRE13?=
 =?utf-8?B?elI5UEpyUTVjT3B2cENKb3owSG5GR3l0eFRDSGNkWmlaT0l0WjhkSENGM0M2?=
 =?utf-8?B?bUtaRmd6bW1VajFsZVhRNnVHY3U0VU83dXNYczQ3eHpRQ2IwcTc1UWxUWk1o?=
 =?utf-8?B?K0xJVTBzUTZCNjN5VFAvNmtqRUlHaW5HYnppekZwYUsydWZZcEpZaFdmZ0JP?=
 =?utf-8?B?c3N5YXVYM3BjZ2xSc0V5a2NTdk1aUjMvRTZTRVNteFFaSkgzRnVuWVZKalJy?=
 =?utf-8?B?L2ZWbUMzVXJZUjZJNUdNNmw3aU44UTlmSVRTUHc2RnhndU9lWGNTUUVNWU5x?=
 =?utf-8?B?Q1FZM0h6LzgxZUVDcHd0blNkVmtGVjJ4TWZlTUhnbnNxZUxkZ25EQXd5UnBQ?=
 =?utf-8?B?KzlEQURnc3FZR2lwelJZdDZJVjRWOFk4cjhIdEtCbHZ0ZDVveTBSTnlObVEv?=
 =?utf-8?B?YURteGFMamFEZTVCMWRGRlkxbDRxeFJwR2IzUVpudm5mR1ZzU3Awa0xpZ2ZD?=
 =?utf-8?B?RjhxYXVVSEd2K1Q2WlFxN3N5YkZHZnlYSmJmUENaU1U1UUYwelNJZEU5dDd0?=
 =?utf-8?B?bmJYWGZyamRCU0czOTl5WGdrVXRQZ0JaM3phVm1FNVNxOU5xNk9wOG4xSTl1?=
 =?utf-8?Q?2hoVSeJWCO8HwCtetyTwbSuNPP4pbtPy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3Zmc014MjhUazJwTlpLOWl5d1ZWcUZIOGlEaUxjOEpkTDVLMm9sdms0b3dw?=
 =?utf-8?B?M2xialNGT3NXOEpwRnVkSjlBaWN0V2NhK0ZhMTBoYWJNbUdJQnpyYmxrdkxr?=
 =?utf-8?B?OE50ZXhxeUpYcVhTT01FQ20wamg2amhZdFVJOFZNcW1PTzVObkl1Q3phQ3Yx?=
 =?utf-8?B?MGxmajFtSmNoMlFDaGJyZS9RdW5oblNwUTI4Sk9QTzhjNkQyZmNZaGRRNWtH?=
 =?utf-8?B?OUo4djUzUGVwUXEyRnJyMmdYcEwwd3pXY2JkLy9jZWZBM1lyQTQySE1mcndP?=
 =?utf-8?B?bmd1R24xWS9SOTJqdHRxT3ZYQUV3eTVodW02Z25zVjQ0empRdGZLYkRzOEQx?=
 =?utf-8?B?REVEc0tTTmtnZms5QmIxTklPeExzVjFRYWxyR1dLNDc2SXVhejViVEdhTDg2?=
 =?utf-8?B?QjlZU0owM0U2U3RDSFhPTVhmbzlOSVZlcUI0VmRPODVQNWx0c3dnbjB2UlRY?=
 =?utf-8?B?UHRDRXpyNVpJWmVSMHRyMHFNc2FYL0FuaWxxZUpyVlJjbGNyVFN2azdrMEl4?=
 =?utf-8?B?VldzNmw2NkpSTlJMT1oyT2JMMTZEMXJlRTA5OE5DRWNHNk9pcmhxTUhZMnA3?=
 =?utf-8?B?RFZRT3E5eVJTb3RiM2dNSFA2dHVWTmlNemhHWEw4SnJtVjd4S2dXSEtPWU1I?=
 =?utf-8?B?VmVHbVRSZ0ZlWnhaYlZVNTFCTW1PSHN3cWxpQVNCMGszUnlIRWU0VklBNWZK?=
 =?utf-8?B?TUNINEZCR3Q2WWptVGVPNDI3c3ZqdysvMXJSaUFwazlhWFpsL0pIdmFrcXly?=
 =?utf-8?B?TnlWNVUvby9wb1hUV3prVGpKc25HWGZwOHhSZHpjTVBmWmpQUEZpRVZPcUth?=
 =?utf-8?B?QzZXVSs4c3Vhc0xRVUs3UlNyK1c1NmQwUFlnQlh0V1EyR08yZStSV3NuOTNI?=
 =?utf-8?B?V2tTVE5UazVObDM3Q2YzL3NOR01jcTJjbXVZTkRxUGEzQ202VnpNcklXK0pW?=
 =?utf-8?B?Z3VES1VKdWp2czdVWUwxSUZ2dTh0MWJRQ0hnU0JkVkYzR2dSUHF6L3Mrc1pM?=
 =?utf-8?B?ekcvNThzZUg3VmJjTFZnODZLb0hCOW1jOFhCbytNa1RKaDNxVmwxT0p1cTFx?=
 =?utf-8?B?WUZuTFBhTXo3Y3l4eWJyYUxHUXZRcXBlTTkwcENzc2EydUo4QjJuZHJxVjBQ?=
 =?utf-8?B?VkZIMkVlSy9DRDgyUmxkMVRZMzZ4MW5kcEJ3Q0JuVWczZGxPN3pMWWNEYmpk?=
 =?utf-8?B?RkorZzJTclpYZ2FBQlVKR0JZNFN1OURpQWRpdG5sUFZMQjZEZGgzUllVSmVU?=
 =?utf-8?B?M0p0QVVDS2RWYWx5SkpvbUpKUXVyQldqbTJ4eFlZYjJrYkhlQXg5SFp4SnNq?=
 =?utf-8?B?SEt4MDgxaGxrVStvbzJDQmVJNVlzc0Q4dGpvRXZsVmEzbGZReHNCckxHbGNV?=
 =?utf-8?B?VVBBYmZQczQrWmdqSlEwb2VHNWlpVWJXMHpkT25FRnAvRktUclorMDgrVVRP?=
 =?utf-8?B?bVhIcmovR3RocVlnVDIrUEhCWWxzdFJSZ01uQ1Bxd21zR041NENkaWNWV1JJ?=
 =?utf-8?B?RE1BUGdqdFY1N3VmczdlUksydU1BMFl0bHVyMHJZaEpjL3I1UXFkQzhQZUVp?=
 =?utf-8?B?aFl0bEdGaHQrMm5wa2JvcTNYR0N1WmExZUdrdFFpeDdMdHBkbHE1R3BReGUy?=
 =?utf-8?B?WldEQmRoOXNGYUVYdlFPUmZERmZ5Tk8vZnhta25JTFNPd1VBSktwYTNGWDQ5?=
 =?utf-8?B?aE5jaXNQaitMV0xNZlllTXp5dmUxQ3FHOG5mcWVmOVhOLzZIU0JaQXI0cHN3?=
 =?utf-8?B?elEza0VjOU90NkhCVEV3cXhDdEtEdFBuMDl0NDFaMjdsbE5qVno5UEtIc3Qy?=
 =?utf-8?B?RnRScG5vOTBaOFZpR2hYaEFFSlRQbzNPdzVDckpKWWl1Z0Npa2VGb2w0Y0tv?=
 =?utf-8?B?aFRKV3BpR2RVQjNGYVZ2clZiNmpDQk5uN3VxMCt5MCt3OEl6MG5sV3ZZN250?=
 =?utf-8?B?OFZ2ajJTL3NQTWgyWDNGNkVoUUNNcmJjbWdrNnF0Q2k4Wk8rMDdYazRqNktK?=
 =?utf-8?B?eXEwbHFGVVZwbXV4dTlaY1B6NllSQjg1L2RBUmtjaVBwcURTQ1ZNUzlDV25Q?=
 =?utf-8?B?V1NYbWpERUI4Y1B3M1duNlZERWpGWUQxRHpoVjc5ZG5mcUVjVDFHc1ZQNldx?=
 =?utf-8?Q?HsSk0E0Ou3fzJ7oau9bNwqMt6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fc0269-c1b6-4ce6-a7b5-08de16325a4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:57:45.6426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdffKR3wbcl3IVJc5oZaA0pnM0K57kJpz3/U9x9hODt7IA6Yyc8GtSDobgYiTPrV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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



On 10/28/2025 7:43 PM, Asad Kamal wrote:
> Remove amdgpu_asic_flush_hdp & amdgpu_asic_invalidate_hdp functions and
> directly use the mapped ones
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Two patches (invalidate/flush) would have been ideal.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                     | 2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c              | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 +-
>   drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c  | 4 ++--
>   drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 4 ++--
>   drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c | 4 ++--
>   drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c | 8 ++++----
>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c   | 2 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 6 +++---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
>   11 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d1137d8beca7..bcfed46eedaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1539,8 +1539,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
>   #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
>   #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
> -#define amdgpu_asic_flush_hdp(adev, r) amdgpu_hdp_flush(adev, r)
> -#define amdgpu_asic_invalidate_hdp(adev, r) amdgpu_hdp_invalidate(adev, r)
>   #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
>   #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
>   #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b92234d63562..962380af4ee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -7327,7 +7327,7 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
>   			return;
>   	}
>   
> -	amdgpu_asic_flush_hdp(adev, ring);
> +	amdgpu_hdp_flush(adev, ring);
>   }
>   
>   void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
> @@ -7340,7 +7340,7 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>   	if (adev->gmc.xgmi.connected_to_cpu)
>   		return;
>   
> -	amdgpu_asic_invalidate_hdp(adev, ring);
> +	amdgpu_hdp_invalidate(adev, ring);
>   }
>   
>   int amdgpu_in_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 3bd44c24f692..de7a1e168a76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -342,7 +342,7 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
>   	if (ring->me > 1) {
> -		amdgpu_asic_flush_hdp(adev, ring);
> +		amdgpu_hdp_flush(adev, ring);
>   	} else {
>   		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> index ac9ec8257f82..38e19e5cad4d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> @@ -139,7 +139,7 @@ static int smu10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
>   			priv->smu_tables.entry[table_id].table_id,
>   			NULL);
>   
> -	amdgpu_asic_invalidate_hdp(adev, NULL);
> +	amdgpu_hdp_invalidate(adev, NULL);
>   
>   	memcpy(table, (uint8_t *)priv->smu_tables.entry[table_id].table,
>   			priv->smu_tables.entry[table_id].size);
> @@ -164,7 +164,7 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>   	memcpy(priv->smu_tables.entry[table_id].table, table,
>   			priv->smu_tables.entry[table_id].size);
>   
> -	amdgpu_asic_flush_hdp(adev, NULL);
> +	amdgpu_hdp_flush(adev, NULL);
>   
>   	smum_send_msg_to_smc_with_parameter(hwmgr,
>   			PPSMC_MSG_SetDriverDramAddrHigh,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> index f9c0f117725d..0bf1bf5528c2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> @@ -60,7 +60,7 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
>   			priv->smu_tables.entry[table_id].table_id,
>   			NULL);
>   
> -	amdgpu_asic_invalidate_hdp(adev, NULL);
> +	amdgpu_hdp_invalidate(adev, NULL);
>   
>   	memcpy(table, priv->smu_tables.entry[table_id].table,
>   			priv->smu_tables.entry[table_id].size);
> @@ -90,7 +90,7 @@ static int vega10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>   	memcpy(priv->smu_tables.entry[table_id].table, table,
>   			priv->smu_tables.entry[table_id].size);
>   
> -	amdgpu_asic_flush_hdp(adev, NULL);
> +	amdgpu_hdp_flush(adev, NULL);
>   
>   	smum_send_msg_to_smc_with_parameter(hwmgr,
>   			PPSMC_MSG_SetDriverDramAddrHigh,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
> index d3ff6a831ed5..e2ba593faa5d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
> @@ -68,7 +68,7 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr *hwmgr,
>   			"[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
>   			return -EINVAL);
>   
> -	amdgpu_asic_invalidate_hdp(adev, NULL);
> +	amdgpu_hdp_invalidate(adev, NULL);
>   
>   	memcpy(table, priv->smu_tables.entry[table_id].table,
>   			priv->smu_tables.entry[table_id].size);
> @@ -98,7 +98,7 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>   	memcpy(priv->smu_tables.entry[table_id].table, table,
>   			priv->smu_tables.entry[table_id].size);
>   
> -	amdgpu_asic_flush_hdp(adev, NULL);
> +	amdgpu_hdp_flush(adev, NULL);
>   
>   	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
>   			PPSMC_MSG_SetDriverDramAddrHigh,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> index a5c95b180672..e3515156d26f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> @@ -192,7 +192,7 @@ static int vega20_copy_table_from_smc(struct pp_hwmgr *hwmgr,
>   			"[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
>   			return ret);
>   
> -	amdgpu_asic_invalidate_hdp(adev, NULL);
> +	amdgpu_hdp_invalidate(adev, NULL);
>   
>   	memcpy(table, priv->smu_tables.entry[table_id].table,
>   			priv->smu_tables.entry[table_id].size);
> @@ -223,7 +223,7 @@ static int vega20_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>   	memcpy(priv->smu_tables.entry[table_id].table, table,
>   			priv->smu_tables.entry[table_id].size);
>   
> -	amdgpu_asic_flush_hdp(adev, NULL);
> +	amdgpu_hdp_flush(adev, NULL);
>   
>   	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
>   			PPSMC_MSG_SetDriverDramAddrHigh,
> @@ -256,7 +256,7 @@ int vega20_set_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
>   	memcpy(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table, table,
>   			priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
>   
> -	amdgpu_asic_flush_hdp(adev, NULL);
> +	amdgpu_hdp_flush(adev, NULL);
>   
>   	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
>   			PPSMC_MSG_SetDriverDramAddrHigh,
> @@ -306,7 +306,7 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
>   			"[GetActivityMonitor] Attempt to Transfer Table From SMU Failed!",
>   			return ret);
>   
> -	amdgpu_asic_invalidate_hdp(adev, NULL);
> +	amdgpu_hdp_invalidate(adev, NULL);
>   
>   	memcpy(table, priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table,
>   			priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index bbf09aec9152..7c9f77124ab2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2889,7 +2889,7 @@ static int navi10_set_dummy_pstates_table_location(struct smu_context *smu)
>   		dummy_table += 0x1000;
>   	}
>   
> -	amdgpu_asic_flush_hdp(smu->adev, NULL);
> +	amdgpu_hdp_flush(smu->adev, NULL);
>   
>   	ret = smu_cmn_send_smc_msg_with_param(smu,
>   					      SMU_MSG_SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_HIGH,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index cb3fea9e8cf3..a0c844bf852c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -449,7 +449,7 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu)
>   		return ret;
>   	}
>   
> -	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
> +	amdgpu_hdp_invalidate(smu->adev, NULL);
>   	smu_table_cache_update_time(sys_table, jiffies);
>   	memcpy(sys_table->cache.buffer, table->cpu_addr,
>   	       smu_v13_0_12_get_system_metrics_size());
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 0a7d2cea7dc6..e1f9aa5d6c20 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -766,7 +766,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
>   			return ret;
>   		}
>   
> -		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
> +		amdgpu_hdp_invalidate(smu->adev, NULL);
>   		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
>   
>   		smu_table->metrics_time = jiffies;
> @@ -845,7 +845,7 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
>   		return ret;
>   	}
>   
> -	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
> +	amdgpu_hdp_invalidate(smu->adev, NULL);
>   	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
>   
>   	return 0;
> @@ -2385,7 +2385,7 @@ static int smu_v13_0_6_request_i2c_xfer(struct smu_context *smu,
>   
>   	memcpy(table->cpu_addr, table_data, table_size);
>   	/* Flush hdp cache */
> -	amdgpu_asic_flush_hdp(adev, NULL);
> +	amdgpu_hdp_flush(adev, NULL);
>   	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RequestI2cTransaction,
>   					  NULL);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a8961a8f5c42..3b98065dac1d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -980,7 +980,7 @@ int smu_cmn_update_table(struct smu_context *smu,
>   		 * Flush hdp cache: to guard the content seen by
>   		 * GPU is consitent with CPU.
>   		 */
> -		amdgpu_asic_flush_hdp(adev, NULL);
> +		amdgpu_hdp_flush(adev, NULL);
>   	}
>   
>   	ret = smu_cmn_send_smc_msg_with_param(smu, drv2smu ?
> @@ -992,7 +992,7 @@ int smu_cmn_update_table(struct smu_context *smu,
>   		return ret;
>   
>   	if (!drv2smu) {
> -		amdgpu_asic_invalidate_hdp(adev, NULL);
> +		amdgpu_hdp_invalidate(adev, NULL);
>   		memcpy(table_data, table->cpu_addr, table_size);
>   	}
>   

