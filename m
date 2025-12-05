Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC87D2F7D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 10:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C076E10EAA6;
	Fri,  5 Dec 2025 10:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IwSKpEMM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1A910EAA5
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 10:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cku93iqBtCOVwJ2WxwLEGg01zjYQkO5JtkOItSzChT90owe5GwOg1MhENlvXSpFG+YAWKHtecpWeoeEVTQ1dAZX1zvEYbrwSyleAUIV650AiZVqBVba9fs6ggQ+xrBWM3O0NXSl3lfcmGFoaG6KHO2qStOBcoFFK9uqc1tgYDAwFk7GM2/4MxYdG9I0QBKWrp6+/mYt9DJb7dSKb+LXvA8WiYgJsWAAhqGAD2fjp0BuBl7JlWjYgazfV6ZAL9zJz2LzgNeLO58tlQY4EZ62HSC02+txuxye/Yk3uc1XjdnrI9xEya4S7r4/2+y95pDMVYJtlnW3dgIHlteFDywDgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hClI4nmAL21HibZuhpBRyROOjOpfL62GGxyxRD91Px0=;
 b=S1DQsDYztMFn9VJJj0rLfvZ66svTp1PxqIMvx8nI5woXKZGTXCF/TiwYSHxVd9HPq/lnyCqb4IVTde9bVYE/t16cDpcWoRu3+8uJdQllIUg5fKvnQywvl/4ns8+3qeiP4RPn3Jg3IqfZZGpAHtkeFnG/vWtQ+B/EgdyE5964Mqqrs76Y7msVMtgzsbqIfqYBtK+GDQhcuXpBNZrcSIx78Nz/WytIEvPMDwa2Mcsvee/3vdmbCaLGMBfunJOywx3cw9VbkODEBw1JZxN952Gfw490tXEN4x5/9TmX6cbkvAXtoHtJt/pAJyI1P3KAqynjWGncIW7tv2dU61XDHe6Tzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hClI4nmAL21HibZuhpBRyROOjOpfL62GGxyxRD91Px0=;
 b=IwSKpEMM7RBueoJE9Eav7JiReiTARS0K1UpQYoN7Wy5SoQ8sStOuKQHisS2BwfqFQ9FbP12lWdzxVP85LvAA+q1PGCeFyl9r7LqrZTkIxNqn1eifsj1k/sGW2AxOlFAXc6fT5lYOz5HkWNlmZwyggEOFTT1Hcz6/uFfqIgtvYUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 10:20:54 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%7]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 10:20:54 +0000
Message-ID: <8f562315-824e-43eb-a4d5-614f077e39ba@amd.com>
Date: Fri, 5 Dec 2025 15:50:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix mes packet params issue when flush hdp.
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: emily.deng@amd.com
References: <20251205083521.1337481-1-chongli2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251205083521.1337481-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::12) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: be283235-c185-4d4f-cdee-08de33e7f917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHAyVVZMSUJvbTVzQlRJU1BWcUhYSWIxT3NUb3VWQ1QzRWhJT3VVM01IdVBa?=
 =?utf-8?B?Y3hSQUZ6QWR0NWp4M2E4VnFDOFN1RXliSmZ0YUFDY3I4M0M4WndjV1BYVWhY?=
 =?utf-8?B?NGU3ZXJEUGZVYUFhN25PUFNHNStVS0FJVmw1bzZ2ekpSZ1luZjJ0M2FmNHRP?=
 =?utf-8?B?R3Ztcm9ZeEVHNnZxSFJlSHU3Smk0dEhpSXZiUTdhNnhCcnptS3lUVVNJTUUy?=
 =?utf-8?B?TWlVUG1nUnBraExGc1IwOGM1UDIrTjhnelQrSGxtSVlHZm40S3lNRkxhMTl0?=
 =?utf-8?B?dWhpM0hPU20vaE8vMVVtUzBZZ29QcEdMTjcrR1J6eVFXekVVWkhQMmllSUFT?=
 =?utf-8?B?a0RsRGdtV0RjWXhRRkxFTmRPWWlXelVpU1N2eDdRODZPR0gyaHRuL2xjMlFH?=
 =?utf-8?B?d3BJMVduNHByTEdhdUNLd0V6L0U2c1ptVm5pODg3N1g1V2l0ZnhQVlRHTWxT?=
 =?utf-8?B?dmhmc2hYc1ViZFNlQUYwZ2N1Rk14M0xPVUw3L2txUWpoT0w5VERyM09xV1gr?=
 =?utf-8?B?YUhKM1hUeTJ1VTlDVDhPeEIxM1QwWnlxbGtESW5XL0pGVEtaZXRJd3p6Q3JV?=
 =?utf-8?B?SVJoa3AvMUhrVVdDMjMxSEFDTlM1ZHdaRkRkMFhLRmkvVnBySk5uY0xjRjhl?=
 =?utf-8?B?K1gvRUU0SWpRYU96dUtiRGx3d3o2Y2lXSnhKdFM0T0t2VmNXd2YwWi9mYzQ3?=
 =?utf-8?B?UUh2MlRPcFN4T1hTajRxdW9EVmVDN282Q0JMU1VZdWxJNFNtYmNFelFZVjhD?=
 =?utf-8?B?VUdnejhPUjdZRTlCeU1KZE5MRU9KeUIxSHpBSWFkeTlHZ1lWQUwwclY4Tkk4?=
 =?utf-8?B?eWROT2JVUFc0bzZqWUV2TFQza1Y4NmNkNjRGT3I0RHVvOEs5bTAvSVNjWVNR?=
 =?utf-8?B?dkVjcU9ZUFN0UkdoWVZhb1k1RGFaeGpqcHJaZ2ZIUU54M2lXZUpVNThwRTd0?=
 =?utf-8?B?bmsrc2g3Z3J5Skh3S2pQUTR5b2QzaFBsa3lHS0lHTzRSR01ZSHlvdWs3cTA2?=
 =?utf-8?B?WGxINnF5QkJXd21XS2I1S1ZMdVVOc1ZLcWFKZzFUekg3LzRjMFRFeWVyNEts?=
 =?utf-8?B?ejRiWWE1RkxlWjlWdFNoWHpRc21nOFBoK0ZDZGlEQVR0Y2tVR2hKdjBnZ3p0?=
 =?utf-8?B?MEd3MEFTRHRrbFhvalNDWGpEZlB0RXpOL2FOSmc2cXZweTR2a21hQ2lZcWZL?=
 =?utf-8?B?NVBueTdwUmZWT0Vha25pYzh2MElrLzhmdzI0RDVnbk10Y2d3Wm1XaUtZanBt?=
 =?utf-8?B?cVkwRlhJdFhtTVF3Tzd6cUwwaUVxSzNpNXFZYSsrdTdzR3EzNDBFSWVkbEtX?=
 =?utf-8?B?WnM3UG54ZDBVMCtGNEFBTTdWcW4yUS9aaVdydzEzc0E1QUdJbkIrbXljQTFm?=
 =?utf-8?B?MlU4VmlqbVpZbURvdCtWTktGZ1p5T210NE84UlJJR3BFekx3cllNdjRLdkxa?=
 =?utf-8?B?dUpkYkltTVQ5aW5jdyt3cUpaaXY1KzNHTUREY3lXcS9jNTFxcUdPK1RySUJR?=
 =?utf-8?B?cGpOeXB3emJ6Nzkyc0VKMEdNNWJlVkoxKyt0T21SeW5UdTQwL1ZrSnlYRk1N?=
 =?utf-8?B?ekpTaEhFN2FOQlAxVEZ1aVZodzBibjNjMExsTktTKzkvSTlWL1ExS0luQjdi?=
 =?utf-8?B?SGFUVlB0UXY0Qml4NzJieVRDV0lPZW9YNjZzR3NKdEZ6MXl1T1VMSEExTW4r?=
 =?utf-8?B?bjV6SjR2cXp5Q0NrU0M1V1ZTSFl3MDB0b3E5Q1lRTlM5QTdsaTV2QldlRnhM?=
 =?utf-8?B?MklXOVA4ZjAvOEtKR1h5RFVQc1ZYOGVqVjZvRUJzWER5dm51NkQ1eU9Xd2di?=
 =?utf-8?B?Lzh0NFIwR0VjbVVmL3VDVzkvRy92blVVQldwcE5VZzh5UXJFNjVyVjFKUTVH?=
 =?utf-8?B?bnYzcDc1Q1hxakZ5WWEyYm9oTVljLzlISmxyNWNaN2RKSVJucW1Xa2YvOTE5?=
 =?utf-8?Q?Xz5UI7BoO8scK/drCfHj+5dbuFWqJoCI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNjUG9rM0JBOXJPOHhTNTVYQTYzWEN6eGJzWVdKK1RqM0NxUldraklyYWpw?=
 =?utf-8?B?MkorR25lU3ZCQjZnZFZTVVNyT3IxeTVhVU8wMlpaNXFTY0FObis0L2s3Y1Iz?=
 =?utf-8?B?WXltNFA0RWo5QzhwN1lzNWxURWFXcllnZmxKK2NsdDdBTWpRREh4cCs0NzBn?=
 =?utf-8?B?Uks3aGRzTUROejR6dE1hYXNOdEl5MCtlVm1Gc1Z6UytIVnpGSzVJN1FSMlFu?=
 =?utf-8?B?L1BKVEZJQWd2bEZtcDR4NlBLVVJpd3JSTkZlNWtzWE9Dd2s1ajB0MFMrWXdV?=
 =?utf-8?B?T2UzODNQUnpuT3Jad2tPNjJDRW5MQnRtelowTVc2N2tmUWRWemlNa2tENVVW?=
 =?utf-8?B?R2VFNjVGTllEcmlEMThwNVVHMXVFcnVKaThXTENtcGlReHRXenVabmJsSUJ4?=
 =?utf-8?B?Q3ZFdmkxa2RUclRVRUo3OVdBTXlRZDRoQTdlSEFLUW9OaDBDOXEwZk0wWWgx?=
 =?utf-8?B?ZHZNY1dmcERvZGFDMjZqdm4zc3JuK1VjTmxBZzVWV3hvbTkvdEJqTThHSWtp?=
 =?utf-8?B?Nmt5dXVZYjB0SVR2ckJqNFgvdzh3cWhiVUhYNWQwTVU5L2dPRWd1UzZ3bzVY?=
 =?utf-8?B?NWJEcjJYSUs2VDMwaFpKVzRkc1djeEdBZzEwR3lEUGJEQlhKc2hCazRkZVNT?=
 =?utf-8?B?RkozcGU0Q21kZTZ4d1psalFEZFpyQkIzb2VRT1o5TVdaM013SWxVUEhDVFRt?=
 =?utf-8?B?U2JjK1doZnlmZ3VISmczemthME1qd1U3TktWYnZPcDV0NHNBNEhWUG9qRkht?=
 =?utf-8?B?NkFRckVMa01TSEJ1STcwd3dpRTRhZjhodCtxdjM5b0hzbkt2N3JWVkFkQmt5?=
 =?utf-8?B?Y0dOc2szTTQxVmEweDh6M1Q5VS9nVTNIR2xhbk5aMi90aFE1Yjg5NWF4UGdK?=
 =?utf-8?B?V2U0Tkc1anMxVTNOekFHOE1vWk05U052cU00b2UyVlkxRHhHeFlQd1R0S1Zo?=
 =?utf-8?B?N296RlVaMC9ieEdjeHU3YnRLTXNzUUdNeUdxYkxJWFdyM1ZlS2xTeXE1ZlMw?=
 =?utf-8?B?aGlUUGozV0E2R0RkZlpjOGMwWElWVm41UTBXV3Q4U0E4a2d6dFpLczFDcUJ4?=
 =?utf-8?B?b3U2UGp5NkNwRldEdXJnTi9xYkIyMlltNTRULytPUkJGd1Q4eGxaMWRZdmlG?=
 =?utf-8?B?VVVwRUpLQm1RMW9uYi94bEhGVlZMMXRJYmN0UnhHeFZOYWZ3UEE5MGw5V2FK?=
 =?utf-8?B?K2MrRE5NY2FDSVhhSGs0WWFtbVdyQkgyTDhobWlRWHRUWldndHBJeURqZWl4?=
 =?utf-8?B?aDd5Znhsek5FdFFYWGhQczI0TnNlWGF4by8rTzlxZVZIRDlOdWd2c0FsRzAx?=
 =?utf-8?B?bXVwUWlaZ2xWQm4zVkowcmxUL1F1UFVSdzd6UjArczRPd2UrNDArWDdsZ2Uv?=
 =?utf-8?B?Vmp6NlVyaDR5OWNZR0RxVXJ3eHpwMSthSzBmNFJlVDRyUHlPYWpEcU83TG9y?=
 =?utf-8?B?amZsQkgzWk9YUXdoR3A0K0JFKzNSb21WY2dNMG5XeEZKRGdQREpseFJuM0xt?=
 =?utf-8?B?TUFsb2lIZW5VQytua2JuUFdrdmI1elJKR1RQRCsyMVRHVTVnTFRSc05BV3Zu?=
 =?utf-8?B?dXNYazBRTVJpc3dOWkREYWl0Nkc3SHA5cjE0OWhicGhxdURSMS9SNTlkMlB4?=
 =?utf-8?B?M3Zha0pRcVEzcjJKckdPWTU1RHVhNDd1dVZOaHNLdHdmYWpSTHJzYVp3YW4r?=
 =?utf-8?B?enVKbUFJYVI1b3NkOXVuQ0IwZUhSVzRvWHBlYzFjOUZsM292ZE9WV3k4eXIz?=
 =?utf-8?B?b0VwSHgxYlRxNTZXNk1OM3BFdHFoa0tTTTIwcXZwdEZDcGJmWXV6NkZ6ZUVX?=
 =?utf-8?B?bk1mdC9nS1kvQjQ0eVpyRW1BdmE2d2lobFlFY2liL3VUOEVUMnRZV3ZtQ1lO?=
 =?utf-8?B?bEtkZElLMFhCcU51TWtEYXdKWUgwSEpHcWVWWFRmTDJLUERjWnhjazRkNm44?=
 =?utf-8?B?QndNSWVKc1U0ZjEwOFFmRmR5bVZnUzNmNjB5K1NXVTRIVGM0alNnbU00Q21Y?=
 =?utf-8?B?UEZSc1dNQitJVWtpY3M5QmxpSFZMQlhQaDgzOWtoNFBtRkVVY3JWdzFmSHZj?=
 =?utf-8?B?WU12QTZIY1RDakkxQzlPbEFNNEI2QmJ0VHhIcVYzRk5QdTNaaGFnMEhac0VX?=
 =?utf-8?Q?NXKo84VG9TRi4vLN6QWlFhooY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be283235-c185-4d4f-cdee-08de33e7f917
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 10:20:54.6201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yW3jIottR1SxlQmk16uX6RGddA3MHatbhEagUNg2WtKo9oUWm8L1Afm9jR0kkwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
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



On 12/5/2025 2:05 PM, chong li wrote:
> both gfx ring and mes use cp0 to flush hdp, cause conflict.
> 
> use function get_ref_and_mask to assign the cp entry.
> reassign mes to use cp8 instead.
> 
> Signed-off-by: chong li <chongli2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  | 15 +++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 40 +++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 40 +++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 +-
>   8 files changed, 87 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 895b841b9626..73305f07ddd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -556,11 +556,22 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>   
>   int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>   {
> -	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
> +	uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
> +	struct amdgpu_ring *gfx_ring, *mes_ring;
> +	uint32_t ref_and_mask = 0, reg_mem_engine = 0;
> +
> +	gfx_ring = &adev->gfx.gfx_ring[0];
> +	mes_ring = &adev->mes.ring[0];
> +
> +	if (!gfx_ring->funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "amdgpu_mes_hdp_flush not support \n");
> +		return -EINVAL;
> +	}
>   

Does this really require a function? Why not keep hdp_flush_mask in 
amdgpu_mes struct and initialize within mes_v*_sw_init()?

Thanks,
Lijo

>   	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
>   	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
> -	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
> +
> +	gfx_ring->funcs->get_ref_and_mask(mes_ring, &ref_and_mask, &reg_mem_engine);
>   
>   	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
>   					     ref_and_mask, ref_and_mask, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index a1fb0fadb6ea..adca4396658e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -250,6 +250,8 @@ struct amdgpu_ring_funcs {
>   	void (*emit_vm_flush)(struct amdgpu_ring *ring, unsigned vmid,
>   			      uint64_t pd_addr);
>   	void (*emit_hdp_flush)(struct amdgpu_ring *ring);
> +	void (*get_ref_and_mask)(struct amdgpu_ring *ring,
> +				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
>   	void (*emit_gds_switch)(struct amdgpu_ring *ring, uint32_t vmid,
>   				uint32_t gds_base, uint32_t gds_size,
>   				uint32_t gws_base, uint32_t gws_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index aaed24f7e716..aafd34ddcfcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8616,7 +8616,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask, reg_mem_engine;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>   		switch (ring->me) {
>   		case 1:
>   			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f4d4dd5dd07b..0ada69d0cc68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5829,29 +5829,50 @@ static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> +/**
> + * gfx_v11_0_ring_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v11_0_ring_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	u32 ref_and_mask, reg_mem_engine;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>   		switch (ring->me) {
>   		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>   			break;
>   		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		case 3:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>   			break;
>   		default:
>   			return;
>   		}
> -		reg_mem_engine = 0;
> +		*reg_mem_engine = 0;
>   	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> -		reg_mem_engine = 1; /* pfp */
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> +		*reg_mem_engine = 1; /* pfp */
>   	}
> +}
> +
> +static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	u32 ref_and_mask, reg_mem_engine;
>   
> +	ring->funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> @@ -7235,6 +7256,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>   	.emit_vm_flush = gfx_v11_0_ring_emit_vm_flush,
>   	.emit_gds_switch = gfx_v11_0_ring_emit_gds_switch,
>   	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
> +	.get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>   	.test_ring = gfx_v11_0_ring_test_ring,
>   	.test_ib = gfx_v11_0_ring_test_ib,
>   	.insert_nop = gfx_v11_ring_insert_nop,
> @@ -7281,6 +7303,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
>   	.emit_vm_flush = gfx_v11_0_ring_emit_vm_flush,
>   	.emit_gds_switch = gfx_v11_0_ring_emit_gds_switch,
>   	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
> +	.get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>   	.test_ring = gfx_v11_0_ring_test_ring,
>   	.test_ib = gfx_v11_0_ring_test_ib,
>   	.insert_nop = gfx_v11_ring_insert_nop,
> @@ -7323,6 +7346,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
>   	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
>   	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
> +	.get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>   };
>   
>   static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index f9cae6666697..0bdb4f292dea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4385,29 +4385,50 @@ static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> +/**
> + * gfx_v12_0_ring_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v12_0_ring_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	u32 ref_and_mask, reg_mem_engine;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>   		switch (ring->me) {
>   		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>   			break;
>   		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		case 3:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>   			break;
>   		default:
>   			return;
>   		}
> -		reg_mem_engine = 0;
> +		*reg_mem_engine = 0;
>   	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> -		reg_mem_engine = 1; /* pfp */
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> +		*reg_mem_engine = 1; /* pfp */
>   	}
> +}
> +
> +static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	u32 ref_and_mask, reg_mem_engine;
>   
> +	ring->funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> @@ -5515,6 +5536,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
>   	.emit_pipeline_sync = gfx_v12_0_ring_emit_pipeline_sync,
>   	.emit_vm_flush = gfx_v12_0_ring_emit_vm_flush,
>   	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
> +	.get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>   	.test_ring = gfx_v12_0_ring_test_ring,
>   	.test_ib = gfx_v12_0_ring_test_ib,
>   	.insert_nop = gfx_v12_ring_insert_nop,
> @@ -5557,6 +5579,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
>   	.emit_pipeline_sync = gfx_v12_0_ring_emit_pipeline_sync,
>   	.emit_vm_flush = gfx_v12_0_ring_emit_vm_flush,
>   	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
> +	.get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>   	.test_ring = gfx_v12_0_ring_test_ring,
>   	.test_ib = gfx_v12_0_ring_test_ib,
>   	.insert_nop = gfx_v12_ring_insert_nop,
> @@ -5599,6 +5622,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
>   	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
>   	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
> +	.get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>   };
>   
>   static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 66a4e4998106..176658846b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2070,7 +2070,8 @@ static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask;
>   	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>   		switch (ring->me) {
>   		case 1:
>   			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e6187be27385..bc1d0870cb2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5382,7 +5382,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask, reg_mem_engine;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>   		switch (ring->me) {
>   		case 1:
>   			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 89253df5ffc8..418b8daa7097 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2820,7 +2820,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask, reg_mem_engine;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>   		switch (ring->me) {
>   		case 1:
>   			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;

