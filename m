Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C9606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cqT0JUQj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A6010E3AC;
	Wed, 18 Nov 2026 08:35:08 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE5D10E3AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 08:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ5l+0z6BBUABqgRRQAVhbMlCUEgK/opEbpTRFfQnjWpwkv0CA5KOs2xuRxSul1t492kUlhkRiXgQviEIc8ev9EW4gVBYjMoc3vAAyo8tPnhNy8qjLAL84ApJvmqLT5ZpfE/ueIIevJiUHLrRQ6DOO5cqKOKQspiQ//Y59ju5PCgU62Un0HrGjqxW5HfkuzyX9RmYC6V4NCRqfpgi9MLsUYRQ3/Eo0v8ZEZ/1drywxncOoFc9+tw1OiR4CG1QqpLsMihD2V2FJ8e0c51i8yedXNFMAmwPiNJTSTibJAIQknZxIxHu0aTZThP76jjNcsCErduAGAZm/vmRMV7PBR1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1mutNrhqowJlZQUA7EZx5MLlnzkiT0PjcsP8SD+iKM=;
 b=f/Vhf0UGkIPyQdMpkJfnNrZybvMltApuY+zY9oafY7o3phS7C7Tqo4W6ngEyFv7MEDo775CGbLrpkD0+6zoa8H5NQZZDzJjKBbQ+j9P20VN/kjg4ZFKN4+u0ucZqwwjQA7oOFP4ci0ZcTXKBJsO0e8LJ++yyAqcAdW/2BngHvmw+tVrskn25HTm3TVyTzT+vn9Q8n6jxelx2ffH3yL6eE2LmnZyUkflXUA+e1RWrO1wOVNhfFQ7oDRsA67Hr+doh/5zi5Bz0Sv5RRwUDaAEJIgnpYCshAL43n5t/XdvSzon8IbXldYuJ+Y/wZC2IS/3tW40qKEEZ9Lm+rYGmewbXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1mutNrhqowJlZQUA7EZx5MLlnzkiT0PjcsP8SD+iKM=;
 b=cqT0JUQjsyGgF3/WzUQc+dxvKtY/nv727sWUO8QCHm+C3V58C7l5Hlz04lJqNUiVN+8t+CQmpzG2pTUNWOAwTgIPksZVpNxbT9C1fQeuLF0qZomsjciLcb9Nv/D8vYMWCQxhRg97gWZYPGbn4RjnZavF/jja6RhQs+3sgse4MCA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB999094.namprd12.prod.outlook.com (2603:10b6:408:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:34:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 08:34:57 +0000
Message-ID: <5bab4181-f4ee-4953-a1ec-43ed00ef8844@amd.com>
Date: Wed, 18 Nov 2026 09:34:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/5] drm/amdgpu: finalize partial VM range updates
 on error
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
 <MW3PR12MB457285A4036148B8A5C077C19E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB457285A4036148B8A5C077C19E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB999094:EE_
X-MS-Office365-Filtering-Correlation-Id: 186b8463-d394-4385-8dfa-08df454ed3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|261009223027099003|4143699003|11063799006|56012099006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: qD5Ig7XT5miA8Q1u/mH0EUAMc4Jjz4Cvm8Yo+QpJGSOmQ2urrGO/HJE3Rn3yJixV6OVJRN7Tg/YGGLEVl/7H0M19K53nOke0HLiPZh8uqCGrezYMbB+an+mNmVnxyMTNi2VBJMX9N0puY0l7FZNm0oDujXC59M7yE0ZPFH8YwYq/IMhTXwza4HaDGMq8KNtiS/+P+vPil0lvkl0HGxbWxNfmlSfyPij9Z7yKcHBmlk/TqXev3NeTnNU00BYgS8Rnscgh6lfXUPvCgf7CYae8f9A6fT6ZgXAShTEQidqg0cwUsVO3JFRUtCeozfnlVrRFvTKl2i+96IBUNdNowQXhPtivXay2eC/1qboam8iKHQvuSscyapHWQhq6YUOiZa9Hul61BqoMtp8K3QjqLHamI/sPwp8fzLUsp6BthAipV7HRlP9HhyMN6TjJd7ZoIYeB5qHWmWOlvIzldLtDdr2C1pMtA+XdrRbselbYlAkcTKFpHz6PwquH4JxewULyPCxnWgoQE9Z17TuZqmHNcRMrJ/fWcHVFtQmQWB0mF27286UTVxm9EEYXtLcj7h4QhAxbcLYQCVO1A7RYWg/8HgwaMGL4yBC7uhTqzkNDr3fD98/tCu2kPTCTEOp3Pks4nrYI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ymg2Rzk1OWxkK3VYbmhzdmdtdktObTZrK25ua1A5c3l5a0h6QnYwaUp4bFlH?=
 =?utf-8?B?bHpQck5PWGtocWJMc2c4SDBVRlZzNGI4MGt6eHBwYXpqWFFqRmVZa3BXaGYx?=
 =?utf-8?B?QzhGSGZhQk13c0RKVWVXSGFYbEVvd1REYUVubm5NcnBMY0JOWVJMVDJQWHdC?=
 =?utf-8?B?Zkh4S04zU1Z2WnVMTUF1V1E4dUFWYk8wcHp5ME05aFZDWGZHTWV1MVJiSTZQ?=
 =?utf-8?B?V2xuaGxMbmVQR3NXd3psTHMzdDU4T09ZQUxIK3dtZHRLS2ZNYVMrS1N1WXpD?=
 =?utf-8?B?K2NLWTlVNU1aSmZUVG53TEU0aGthQkl4bFNkaGY0N0FvWkdCUHB3S0lNYm4z?=
 =?utf-8?B?SU9rMjVkTTNqdXlyNXlkYStKU1pVcFpJMW9CaFZXRm9lSlZNU2plYkx6U1BO?=
 =?utf-8?B?M2tadE9FNThXUlIxdVZsdjE2SytzUkZ0R0NGbHNPVFpmbXhoMU1LZGhya3Ni?=
 =?utf-8?B?WTZRNFRvKzE3a0UvQVJXNTIxeGZYZlBodkhIWG1rRm1oUDBQcE1KWFl4OXBB?=
 =?utf-8?B?OVF1RVA5NHJHMm9BSFpNdGFaSHc2Z2VXODByZWtNbHZ5U2l4VW8waEd1QVdN?=
 =?utf-8?B?M1hISncwZVFBTXBIQ05sU0tZRzgvcmhTMG9pZVo3Wm9EMVh6R3l2R3BqM0sz?=
 =?utf-8?B?Qkl0VXZsL0o0ODB5V0tzVmRMcHk5aVlCWUlPMmhOck1lcG9pT0UwT1JBTkkz?=
 =?utf-8?B?enVhY2gzRmFDTUxWdTEvcHIxcERTVkNXUThUb3VaL3o2RzlwQUlMU2hKVmJC?=
 =?utf-8?B?UjVUVU9vQU10N2lEMWdWL3R0Y2ZZUzN0N2FHRWQ4ZDlNUFdXcEMvVDhkZVFl?=
 =?utf-8?B?YzZyUmltT1haK3dBOS9mcG5lVVJYRE1kWHVjQTlONjNTMlpLbCtjZndOUlM4?=
 =?utf-8?B?RUJyYzJyTlNhanFneGx6TmEvaGFRNEJjSW1iMkQ4b0g3Z1orNUpMYjhjY0NK?=
 =?utf-8?B?TXZhZCt1RmpMaE5NVEtjdGRiNkFqWW5oUmtNNmJINkVlcitjQ1NVb21tUURw?=
 =?utf-8?B?MUtNMmQ5dTFPekhIUnJVWGp4dmJTUVVCS3FyZEhxcDVocnpaTW43dmFtLzFW?=
 =?utf-8?B?WnA2c2s5dnZ0S1VnSWx6MTFWeVByQkZ0bFBuelg1VklFWVE1a0ozRCtraEhu?=
 =?utf-8?B?NEJLaTVFQm8xUmJ0b3hKUW1Za25xbXlyTkw5cE1oV0NuZE1IcVF2VEVsanZ1?=
 =?utf-8?B?UzN3dFNEWVRKbkw3OVhMQ2ZKSEV1ZkJoZllHbHlMV2ZWR3ZSWFNCZ3VKeElm?=
 =?utf-8?B?U1VYL2grbkxOdVlNbXNjck56QXlReGdVanUvSnpiTFFPTkVKS3N6bFhWeFdB?=
 =?utf-8?B?SHltUmNST3daRWN4NkpZS2h2R2Y3YkpiekRxVU5Kd1JybmErYTl5OFBKblFt?=
 =?utf-8?B?dU5BaUVqbUZTZEhZNnI2SlNyMlRlc0dGK1RVVTczSDNLVlZEaFFvS0MwazFx?=
 =?utf-8?B?MlFncjBMNjRRR1dCUmgyOVZIamFOUTdFTzFlMStVZnJFOU1OOWJCN2NlMEhi?=
 =?utf-8?B?STBoKzdHQ2h2RnVnTC9NWjNadHBHWTN2eG90by9FTG0xRllNT2s4Vm9vbHNV?=
 =?utf-8?B?RWJBbk5UV2ZaMG0vaC9pL24zblF3SXkyMER2NnVBL0NUQzdTSGorSWhzVmpk?=
 =?utf-8?B?d2JlVUZ3K2NKUmMrZXFpdktWUytXWFcwa0c5S2JEelE0ZlBYZXFnOXNleUxn?=
 =?utf-8?B?a1NEdXpGTUJIQXVoQzVFam94eW5xT21tUzdWTzhiUCtlSzJiOGxsc2xBSVdv?=
 =?utf-8?B?Q1VhR3p0U3BXWVRLL2djR3I2dStqNVRZb2ZQU2pvcjZ4VDB5RHFvY3NDb0tn?=
 =?utf-8?B?RTAzU3Q4OWlSVmo3bXRqVjFhMDc0MG80Sm5JZE9jTis2ZE1CenlaZnJQT1lN?=
 =?utf-8?B?YXdJMmRuc3dYMUpHRTRLdnE4Wko0ekdqdTR2Mk1sbmZxRDl2dmhTanhteklq?=
 =?utf-8?B?VHRodFBQeFR1S2gyU3NVazVUWEswUGdpTDNBQ1hvT3RXWTlKa3RKbGJibXoz?=
 =?utf-8?B?RUdsYmdaMXFPRGtlZExIeCtIaCtab3EzU1Bud2Y2TENSR1U0ZVk4c1c0TTZa?=
 =?utf-8?B?NDBEN1VMSjgrNnVKTGRmZWlNMWEvZUZzTjNJUVNBT2ROT0pvbFpzSHN5MVJI?=
 =?utf-8?B?aVJENXc0TTlOZ0NpR1dIWFJhNEt2NUMzUWsxRk5HMmRiU0ZQSnhySStlZzdM?=
 =?utf-8?B?aElscjJCNUFHbnAyMmJQM2JrWHRnVldtMTVzVytEVkVPdHFxdnVUblZrMzZ6?=
 =?utf-8?B?ZVRJbXVQWVJhcHpCbFByUEN6NldvRjJLNFpWVlo1d014S0dSelN4QTRUd2FY?=
 =?utf-8?Q?C/BTpj8IRAGxQ/Hmh5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186b8463-d394-4385-8dfa-08df454ed3fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:34:57.8375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6neTXWlt5+D+zyTGG7j6kfQDV7S4vn72GNBY1rqh3nlKdjxiSjYH8xuRzE7007e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999094
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/26 12:39, Mu, Zihao wrote:
> From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> Stop walking on an update error, then commit existing work and complete
> the TLB and temporary page-table-list cleanup. The void commit callback
> does not overwrite the original update result.
> 
> The preceding internal completion tracking orders finalization after
> the latest submitted IB, including immediate and rollover submissions.
> 
> [zmu: Rebase on commit-void and the internal completion prerequisite.]
> Link: https://lore.kernel.org/amd-gfx/20260914-amdgpu_vm_fixes-v1-4-d6d835591e0f@igalia.com/
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Signed-off-by: Zihao Mu <zmu@amd.com>

Yeah once more clear NAK to that!

First of all we can't flush the TLB nor free the page tables because we don't know if they are still used or not.

What we need to do first is to make sure we commit the SDMA work before allocating new page tables.

It would even be better to move the allocation of page tables outside of the loop which updates the PTEs. But we need a better data structure for the page addresses to do something like that.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3b4df22c5ed..3f3c5a82fc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1276,7 +1276,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		tmp = start + num_entries;
>  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>  		if (r)
> -			goto error_free;
> +			break;
>  
>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>  		start = tmp;

