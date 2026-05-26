Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07979CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 08:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8864910E464;
	Tue, 26 May 2026 08:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UuNFTy4h";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16E910E464
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8sSKbjrFIOVwh5KWrp7/fhLlQsXHpDhbD4j5hHJJ51yHouFTpmTVmkRfvlD08ijxarteTFKok9d8d+qLtdmf+NlG3HtbHDdufUvbCYIrqZWr6jC58rQNVSOUEXDYD+WBIxp3QlXieTmCfRDkf9LkkkPuGsNNGtL7yWt6YtIG3lRV0rn2nNpzt/0WJ4N3jqmFzDKNk9cYqTUOnLmAhG9Ai6v0cBQolTAhIDVwMAtpTr/UdI/NQM6grYHODOXe4pc5JX2rpMZXgux4ZFIARUs2eshB0ETwgAT/rSeeL9bGYSF4nNec7rdV/zluQCvUHU0E6R0wtRwdX6Ubf74UKb1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w55noZh26/XqDrtJK0VV5n3uv9uPDaB8Qhoquztz2Bw=;
 b=hkOOzr7srNk651sfz6iLKMP+aSULbgrWKPpxI2W/zeNO+E+1D8//ZPquo2FAHYjfI9dBNxeF9+NWRQyx0JeNMLxufHRFSzjtur4JMY15pr9o99fTYy4EZVfZ9Wh2dY35WwIf1EdTFBuMgMW9J5xXWR5nFmt9A2ed7t+qGvG6UyxD+rqpxKnV0utZE7qdM1UkG6x28gAKzQQG4ZNLDZAz+8TXqnBwd5+vqojK4uKrqxU0+OdmKkMKXuk76XkF/D/fQ6N8T/VkrwcfoQGWm7kCikmYTVDDJEchMHee3GuBy7Rp+vtIKiyk+u/5wB5rA1MAEamxCMJqjn+wBhqutcP3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w55noZh26/XqDrtJK0VV5n3uv9uPDaB8Qhoquztz2Bw=;
 b=UuNFTy4h4l0UFRu38Lf1R81ouaojlAsCAP0sBdRcEluqNdQpdoTZecmWlMVKJy6AR6bNzJx6kOlJCBDR8YYABF1UdBrvwloOqWP4kt2+jg3gellHs1KWxa7xecGl6RBh+3xe+p6oirEoRT84UxAPxuxhb1HHqIDP0qZ79TU+iqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 08:43:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 08:43:30 +0000
Message-ID: <7f3f14f8-ea83-4df2-9ffa-c062e2457d53@amd.com>
Date: Tue, 26 May 2026 10:43:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: improve the userq seq BO free bit lookup
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260526082642.54856-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526082642.54856-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: bfad4a6d-4367-4e12-788f-08debb02dcf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: ZnVt3TaDXFwzz6I0H6UMnmk9q4Vu/Or2fOGQlaIJEBYLmupsaF75zmd/wLyUgwE/BsPcrxDQvJJWscx/XTDNUwUnn7+2mO7++bO8S7lmijYiKiXGV/ndNzwvzfJbm0n2tlwzr9Yu4144QSqFzVbWbYEB3/P+cDcMWXVYWC2WiIoDxxFwKMdtQrafb7MwiWI9X8A1WsuddO75DTSN/56ghkmXjQol+WaatdXWhIeH8IVnbG5a9RqMPaiNTPlqKV266n+mHLIx4dpakF7nJ/fclpBEA0IbkHht+LJUXOtMnEVo97HIphvU0bk0aRGA/sBNunnvNMUo4y9fHA3JbFOKkxNgK8rlSSmWHzcraeXLsXTbshNvT9XCU5XEADT20GZiEaSChqNJ1xyQ2gwhT2nrg8+ABfPBT/JV7xhNXl0/IPOXWEPDy/GEZqdqJD9zc3rfCERHJhBI892NeJeOJ62id24wF0xs0ECOYr6g9ZjkVx+mOeie9E2rssjSbGG/h+PIq2rFVmdmX3nsRZor8uFRTuIjdiFBtv7PkBkRYEvyW8vbvzU+CwZJk2OWfN0qnfNBbVzO41G5nX3iumQA9JkbfBLxJr94FRHiYvj5Dw05pRHiZFrBXM8a3RjZoFNRORy7/H6GFKRFISscpSuJVEGeWz9u6kN+jjeublg32p/8sob9Zf43papltqDax0ksJicM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE5rSzVMUDdkWkY2QkZuSWpvQmJRM0Y5cDRvTHp0Vm9qeTN0ZVQ1VkZBVk1U?=
 =?utf-8?B?ckh5WVpTai90eG9ySGFmQXBwVVRmV0ZkNk1VcHZSUTZoVzNxZVg3SkpCU05W?=
 =?utf-8?B?Yi9BRlNyR082NFloRk5oYWFzdGpWOVZRdUduVEt5MURRMEhTbjUrSTR0TTZw?=
 =?utf-8?B?dXlsT1l4ZkF6Zit3eFlpKyt5Q081a2tHVVVmYnI1MGxVOUNkaXhXZkNBMXVy?=
 =?utf-8?B?MTYrT3JsK3VmTjVRWS85eHBBUEFTK2ZIdE9BN1V4d2JnZ2tETnJZcllXTE5n?=
 =?utf-8?B?WjQyZkRhV0FNekF2RmIxRzh1WjRQTS95bHF3TzFHMGlXY2JKeEFCM1N1ZS95?=
 =?utf-8?B?d1EwM3NocGZnVFpSV1RMMlVYOFhVU1kyQzQvaWs4YzA0dnlvamhRNjNDUjdN?=
 =?utf-8?B?VTJtdFRkZnEwZ2pLM2dmcE1OTGxpdEVUVGRST2EzLzN5Q2xXSHplUGN2bkNn?=
 =?utf-8?B?SmpEYzZ6ZXdIUk1obCtSVmJoSnB4azBzS1pwZzdsNGpzZWR5RGZhWENsZ0ha?=
 =?utf-8?B?WXI0MXJncnpoYjFDZ01VNU5OWm1NWGJyczMxY3RSaUpmdFJPSW1DZmhQbDhm?=
 =?utf-8?B?U3h4azBSencwTUxUOGI5cHVLMGI1S2t6NnpJZTdxM2JSZks4cm1lN3F2MjMw?=
 =?utf-8?B?aWdBemJUVmNlc2grUHNCQmFYUlpVVWFhNGFZcVd5SUgyd2JMcnFnRVhYLzlS?=
 =?utf-8?B?SlRrN3U5Y1hKcFZQMmRWTWdkSm9mSVpMbmJtV0F1WUlYdGJHVlpKZUJXZWlz?=
 =?utf-8?B?YVRLUVEybldTY3dJcVptaUNPWDdEZVIxUStmTk12QTNhS2EvSFBuZDJZeGc0?=
 =?utf-8?B?NncyWTkzSFpwMzhUaERhdW9yRHJiZ0o5cWdJRzRvUko0YjBBVkR5a3grOW5E?=
 =?utf-8?B?eVR6Y0lXR0thV1c4YlhzU3JUQTFqQ0tjdzYvT2hyQkV1UDhjU0ZPaDJMcDBU?=
 =?utf-8?B?SVJoQlNQRUM2OFJrcU5Lem1SOFlDNEtnVDJkcExVMVJxSklibm1QeVhpOGhp?=
 =?utf-8?B?b0RjalFTZWYveDJNM3V3d0cyWS9iMzc1NE11S1FxczBmLzN3eklqTjlkS2JL?=
 =?utf-8?B?M1pvcnVCWnVCU25GVjQxQ0JvUWdEeitTR2xDSmRGTDU4c0I0Ti9pRHpTRE5s?=
 =?utf-8?B?UUFFK3ZFWWd5bUtKbWs1M2FFQ2xqakFweWIxVG0vM3BkNG5FVUdhMnNKTlZE?=
 =?utf-8?B?dDAvT3VyTzJ4MVlzL0RoclBZVVFwaXQ1d0srWm9vdDJwMTh5eWFYQ2pqZlRS?=
 =?utf-8?B?V2M2cWt2dnNhM0pXYjRMdHJNL1NKZXdCOVNnUElSTjFIdWVzQlVIbWpISnBq?=
 =?utf-8?B?RlU0UzZnN1ZSa2IrWEQ4Smhzc3VkSTk0NnZqY0xGMWE2dDNNd2pWZ3krNyt2?=
 =?utf-8?B?Q05HZkpBVlRhQUFZRndob2I3SjljZEFpdzRZR3JGY0dsNTRnaVk5UTMxVzhG?=
 =?utf-8?B?UUZsNEhpQ2VCNCtMUTA2YU1kMWdBdEJxSC9hSTJkZEJMMTFsRmpaaXFwa3hT?=
 =?utf-8?B?cDFLZGtoVjZ4b2FZMXZzRkl1MTRoR29wOGJRTUtxVkNDVTBhUW1BMnJ5cDNz?=
 =?utf-8?B?SU9kUnVxNm5EdjA2VTJpU0xpSEhIMUt2am1kcUg3SWxURDhja0xsOHZTRk8y?=
 =?utf-8?B?WnZDZnhsTXNycDZLb2hOcmtGY3VxUWhxMjVhY1VKcTNwb25SMENlbU9oMit4?=
 =?utf-8?B?eFBHRzB3dThNRmNkSGhMS2REMnkrc24rSExqdmJWOTJkVDJXbkl3RXJtcFBN?=
 =?utf-8?B?Q2FNZmZhUkV5SnBIYUNUSE9sWmJOc3ZSRkEwdG5ydHVBK2I1R2t0M0YrZXpQ?=
 =?utf-8?B?R3lGenhKOUFYdEJiejRvY0l4REJDU3lMeWhCTTZHY0l3V3Z2TGdhZTM5S3Na?=
 =?utf-8?B?a3Y2a29rdzZobnBLdFBiczRFUWVJL0lUMGE0cFVHVEdUd2wzbFhsUkZkTGZq?=
 =?utf-8?B?NWhJZVBxRVRnUDZJT29JelZTRFZzclJWMVU1dWdSRkpBRm4xcnpZU3p0aEUw?=
 =?utf-8?B?Y2VIcEpQMWxHUkYvaXRTVFdtWFdhZ1pxUmYvVGFOVHY3dWJZcndQWnpEdUla?=
 =?utf-8?B?OFliRzRMZUFRTEFKZnQ1NWR5ZXN6bGFleGh6VVJKeVpKTlg1dEkraC8rUFhJ?=
 =?utf-8?B?ZGpMZ2FLM0owQ0lBblZzbXh5QlJya2Z6ZU5pSCtwcC9LZ0tNT0VpODlaRzFQ?=
 =?utf-8?B?VVkvWHBKaVArbGlCRzF2V2xPclVPQWNUR25RZFlWSlJtV3pOWEV4VHgyZFox?=
 =?utf-8?B?akg2cm51ZDE0QTdrMTlDcFJqU3crWEtPUGpRRUFNZUJUejFpendKMzQrOGVD?=
 =?utf-8?Q?ry8MQbZXlJTffJdM0F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfad4a6d-4367-4e12-788f-08debb02dcf6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:43:30.8165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aU2NRtVrW8EeelzYveTFVKqoaDl3qtjrOYlhuQ1nNbaUSnLTcJQG51kvcXYd3zON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
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

On 5/26/26 10:26, Prike Liang wrote:
> Use find_next_zero_bit() to locate the next free seq slot bit
> instead of the current walk, for more efficient bitmap scanning.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index f4be19223588..21a225b0116a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -173,16 +173,17 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>  int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
>  		       u64 *gpu_addr, u64 **cpu_addr)
>  {
> -	unsigned long bit_pos;
> +	unsigned long bit_pos = 0;
>  
> -	for (;;) {
> -		bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
> +	do {
> +		bit_pos = find_next_zero_bit(adev->seq64.used,
> +				     adev->seq64.num_sem, bit_pos);
>  		if (bit_pos >= adev->seq64.num_sem)
>  			return -ENOSPC;
> -
>  		if (!test_and_set_bit(bit_pos, adev->seq64.used))
>  			break;
> -	}
> +		bit_pos++;
> +	} while (1);
>  
>  	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
>  

