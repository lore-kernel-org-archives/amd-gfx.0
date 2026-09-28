Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551FAC9833F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 12:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDBB10E88E;
	Mon, 28 Sep 2026 12:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4QPrnUN3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530CE10E88E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJSlmlz8xFAPbKBw5VSirCHC0T6KCspqAVo57Fpmhtzu6HLaiR7bmF3VwwXPg026EBUBuMYiXHIGxiHF+AQxOMPL37m16FSflnyd+6zTULQsPMnvd1vjNdnro39u5l+ZnmJW1jXI004Vq8DblhNinup/odmRnDVP5745mr8Cip1zdnEePOtyU2jBy8pcs1Rv9tZ/0DfSK7M/7FBcuOWYJ3m5EzJS5OeC3G6nnQAXTEahr0GwgZOBIsCqsOX2khaYXeF24MDEN0V3bOuxFXDh4OKVKwxfejd/kJwSfI51ELZjbyfQXnZ3Ovi67YKeN3SJrZOTMhW6U+CZaFdb6N4yjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC8oUwmFWOVzW8hg2sf6XvXQDWcFzqtiOo1sGiwvbeU=;
 b=uv7bnL6JV2dmup+L/4tQfQoVVyi+MYce1mUcE1/xzEecVa1EEJNVdomrjMDVxzJW6Om5NZEAhWgiZjoio252vWPMDQ6Q5GsFCB6MXMTL5lVFpQxjgPWKzfo1t74irigoz6T2VvXE/KTEisPiRurpOf3si7wsGWMsD0438s+mcU5NBGR8KdxZjc3L9MVLYomWek8QrdM9wwTJXq+SuvWMYB/cTniTvQLFOZ6DgfWvTiAHnlUfqV9FyAnajNklGfPKu2+Ep9wVgi2m0dbl4W5CA2mI0y7We/TydgNFTeHMkxlAeRH+KXJWPvbFlprvqyUBhXXq+I4uw6TRvJ/em21u/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC8oUwmFWOVzW8hg2sf6XvXQDWcFzqtiOo1sGiwvbeU=;
 b=4QPrnUN3a03NW74I+csri62jjEMS6HIayQLobZlRL4ZYfeOsFH1knLud5KpCYiZFY1LBNe50jrOv/zOrcebaX3vOitCSPkQtgbt1hZcii8GRqjGsOiFu6qZ4V6o7LrpFVJqntnlUJ9xCTBYCWpNNJjBT7gVc37t6HOlyNNkhXOM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:53:12 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:53:12 +0000
Message-ID: <83714274-6699-4c6b-a446-f002d0cddd1a@amd.com>
Date: Mon, 28 Sep 2026 18:23:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu/mes: Support 64-bit register reads
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Shaoyun.Liu@amd.com
Cc: Davis.Ming@amd.com, Gavin.Wan@amd.com
References: <20260928103155.843597-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260928103155.843597-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c813eb5-c63f-4279-843c-08df1d5f7440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZWPJB4qbyZHRkjUhiMvssnuF5LXX08B29piLXOifTf5yBqa5uJhacSPHbLD7+hTG9VeNr1XPnoVQCMPKHm0HgmBKlmxCoQZMPI2bVlPbqaNWJfe+0RAe1X72qRZd8fQS+YbKtseZ+eP9z5w+v6GmBdyZq7XzHhpUnX2seNQWjvHabMmRcZE5OEmvCo9e0cnJncjXhq4U/KumzKBNLJKrm13XRY/ed0c4JGpkd1WtL+uFO0yhe1lWoJUvaI6FkPlb3lVIDdwGfNiemPB5bMCgcThW1xB0vITgpHfEnKomtRiCUG/U11TOb/x6FvtXFFoLFiK2oFCLQIpUJX5TuWjlXI/uSQV7NbPSzEhigGWCi+Zh2aCTpyIV7muO6GSzkEvVrU3720d1c8fzbVNcd1l86T5EmcZkFqGKccc9QUvIqr8wKT9D1eAkljRyU0hEh+Z3QRfd6pDnUMXPX2TSYl3S/dSZ5pW5kBnKjHJcHxncna2T3tanbvtPq08DeODCnWwr4I1o+KGBNTeJE65LuuMwxLP1Q/hJCldkcj7lrHqohBVe7EDwdmGekfB5KD9bz1VNwbw3ZRsPHtm+DTQYVGtrPgLtWuEvG+RJ/LSXKXfkR5R1RthVLg5oNsXV4PnU0BIrIrkLlah71LBR27fOZnh6w9jeQ8jR8hChm5ZpGlV18Qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlQdENDTFVaR3hNbXVLQ1lCVlhZaWhwMVp0RVVxNnJtTnhycUtHbUdsNjJZ?=
 =?utf-8?B?TWlhdURtZU5Gd1FQSEFhM1Y0V1JuQzRZQjc5NmxHNm5WaGY1QVI1aFhQc3RL?=
 =?utf-8?B?cU1hUUpaTHkvVXp6djRJSE5OVmVjQkI0ZFZOUkhCaVRJbU9DWWNFU3RUbHZn?=
 =?utf-8?B?eE1rZzZlZFBvRTBpamtQRHFNUHBzc25sYXpoeWZzUVcydVFoSGc2R3dBZUhm?=
 =?utf-8?B?cFZibmpVMklVNFNETE0zaVZqa3FSRGRVN0pTaWdmTDFoK2FLUHNLV3hvSmNo?=
 =?utf-8?B?Y01JYnlkbEhYNXhTU2FEa1d6cnZEOUU1NE5DS1VJNkJJZGVhdTlEcUJQYjBH?=
 =?utf-8?B?MTRyOFBCNUJaZnNTS2Mwa3B6U2xvSk5RcUVoM2dzdG9WSHIxT0JCeUhNbzBH?=
 =?utf-8?B?T1pUNmxNMnExS3V0eWttc3lFUHJKS0lLUko2RGNJcFNiUUNQRmRtN1ZvRDNy?=
 =?utf-8?B?TndYTGxaZUhTc0FTTFBiMm0wdk91Vk1JN0kzWml6NFI0a0l5TFV2Rkh0bkxE?=
 =?utf-8?B?MTlsa1VZYmhYY1JZeTRJSzhNVm5SZmMrdlJ4UFlnSUw3OTdURlk5UVdjVjFt?=
 =?utf-8?B?N2xibTcvWVlrYlM2WDhBeWxvb1pXekRtdWFNUnBXVkJGYURURTA4YVdaZUx6?=
 =?utf-8?B?YVVkQ0orNHRzUGM2b0dQZGRLN0tTbllHcld6MHNNbTE3WVI4RWNFQ2JGeE9L?=
 =?utf-8?B?VTdhOW0rekhpRlFoeVVzK3NNQlBQVUlaRWZyQTA3eCtqcDlkL2d0R1J6MC9X?=
 =?utf-8?B?Qjcxby9CUlBxTDRtcXViTjZzRjEzV0FCelFQN1hnaWdsU055UzdpbzMrdUJt?=
 =?utf-8?B?YldVTXBCclFhL0VtVWpyZ0kyRi9VREV1bEVPVzdmSXdNV0lRb1pOamh6bGZW?=
 =?utf-8?B?TDVBTXB4ZitqZThJeUJlaTdUblIyQWtjTlZkVVlpdUwwRUhoemM2SmJKV3Zq?=
 =?utf-8?B?U3llRGxZZkM4TEU2VTBUZzl1MkRDVzFPODVzdjh3YnVQV3oxZTh1dHc4TEE3?=
 =?utf-8?B?RDBIQVo4bmdCcWFuSEN6elVKUHVrYVdPUG9GL09yZVhadXdDdzJ2WHdndlNz?=
 =?utf-8?B?c1NxZWk1UGpKTU13Mkh4WTBPYXEzTjJQRjhJRzJzTjhBSEZtUlE3VjFEREc0?=
 =?utf-8?B?UWU4MnVRc1VpQ1FWbnU2M1FVUFNUSEo5YW96ei9mL1VrMDRCVEpkR1pMVkh6?=
 =?utf-8?B?RllsUlhhVm5BWXlvZzZ5ZU5GcXlsbWlYeXJmcnptVnMvbXlFMUsxVVpoeHY0?=
 =?utf-8?B?WmozM1lWL1dFbENWRlN2T2pJUmsvUFNPUGNHMUJxa0NJK2FKYnBTRVl4eWxX?=
 =?utf-8?B?NG9TdHRkdU5oRnFIQ3p6VDgxRzhlUVF1OEtJcUFtaUxxanZRbE9WeSs5elN6?=
 =?utf-8?B?d25aR0RzUHNpR29GNUhSdW5jRDAyaXJSdWtYd2dqWHN5ZEVLRDdWcEdHdkdB?=
 =?utf-8?B?K0I2VEo4SjcrN002dmVMdm54SmtYVDVTNmM2UUNXVEVLR0l1SG9Wa0oxNzlz?=
 =?utf-8?B?TjE5WHpTZjlQdE9lMzQrSXFuVXBLZWFwQVcrdFFZek9jR2wrNXR1Zkh5cGhm?=
 =?utf-8?B?dGhXbVB5enZ4WFZQd2hqVXE5MytrWG5Ea0llMWZGUnZzc0hsYTB0YjNyeklH?=
 =?utf-8?B?bEtIQm91RjhqU2llYk5TdnY1K0ZxRXNkbEVXdS9FZ0IwMnlvS2F2bnFOM0Q5?=
 =?utf-8?B?T3A4OEpEYWt3K0wvcThETk0ycjBDUlJuRDd5bS83MHpFODY5elF6YUFOSVBk?=
 =?utf-8?B?aUp5REZHM0JNa295OGZTeXJPYzl2UTZKekdHNEVPZ0p3Y3YvSkRtY0puNnBO?=
 =?utf-8?B?Q0w4WjVwQ0NPT1NsUEZGLzVsdERNWWFkMk5WU1lxSFlmWUtzVlZ5YzQ2Y1JV?=
 =?utf-8?B?VHlXeFZxTER0VDdZWURYQ2xPanF5NTdlYmVGWjU2SkY3RW9sNnNYVXBxTmxB?=
 =?utf-8?B?T2U5dzlady9xcXR1MGttdlc5MlEwZ0FKM0JJc1QyNVNzZnVQZmFxYWpDbWlJ?=
 =?utf-8?B?SjM0dHF2RXYyQzRNWDZJWndpcU9aNWtzUnJNRkNnRit0SjlZSE0zbXNiNWZQ?=
 =?utf-8?B?WGtmM1d4cVkyYVByb05EczZUQzNWeWJBdzZ0QmlTMVZTOFNnOFNoK09FdkVU?=
 =?utf-8?B?c3BoMkFmbHg4U3FKUGkvNTMzaTlJbi9JNm01OUVrSTNsY1pQTUc1QVRhMnRi?=
 =?utf-8?B?U1UxNitITHZ1WkZTYWlRLzlSUXJKSFhPODk4SSsvQmVxbEFFZzhBZ1I1UWVS?=
 =?utf-8?B?czZnTUxoN1JzRmwwM3YxVFhNOEhaZkhSK0NWMnlPNE9KRjZhWUl6MzVLRHJr?=
 =?utf-8?Q?FgpQLlWoR4QMFUCpqW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c813eb5-c63f-4279-843c-08df1d5f7440
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:53:12.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1xopDR6rz7+5gLZ78F3Zqx01Lkc4Z8u2V3Q+jevYME3GdmiI7UPZL4PxiY6z9h3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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



On 28-Sep-26 4:01 PM, Victor Zhao wrote:
> [why]
> Some register values span two consecutive dwords and must be sampled
> with one MES operation.
> 
> [how]
> Add amdgpu_mes_rreg64(), set READ_REG read64Bits for MES 11 and
> MES 12, and combine the two returned dwords into a 64-bit value.
> Reject 64-bit reads on MES 11 scheduler firmware older than 0x42,
> which predates read64Bits support.
> 
> v2: add MES 11 support with the same read64Bits option
> v3: return read status separately and require MES 11 firmware 0x42 or newer
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 43 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  6 +++
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +
>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  2 +
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h |  7 +++
>   6 files changed, 63 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 5bebe74de01ad..3be6e577a8aa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -582,6 +582,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
>   	op_input.op = MES_MISC_OP_READ_REG;
>   	op_input.read_reg.reg_offset = reg;
>   	op_input.read_reg.buffer_addr = read_val_gpu_addr;
> +	op_input.read_reg.read64_bits = false;
>   
>   	if (!adev->mes.funcs->misc_op) {
>   		dev_err(adev->dev, "mes rreg is not supported!\n");
> @@ -602,6 +603,48 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
>   	return val;
>   }
>   
> +int amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
> +		      uint32_t xcc_id, uint64_t *val)
> +{
> +	struct mes_misc_op_input op_input = { 0 };
> +	uint32_t addr_offset;
> +	uint32_t *read_val_ptr;
> +	int r;
> +
> +	r = amdgpu_wb_get(adev, &addr_offset);
> +	if (r) {
> +		dev_err(adev->dev, "critical bug! too many mes readers\n");
> +		return r;
> +	}
> +
> +	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];

read_val_ptr may be declared/assigned as u64* and used during read back.

That aside, this looks good.

Thanks,
Lijo

> +	op_input.xcc_id = xcc_id;
> +	op_input.op = MES_MISC_OP_READ_REG;
> +	op_input.read_reg.reg_offset = reg;
> +	op_input.read_reg.buffer_addr = adev->wb.gpu_addr + addr_offset * 4;
> +	op_input.read_reg.read64_bits = true;
> +
> +	if (!adev->mes.funcs->misc_op) {
> +		dev_err(adev->dev, "mes rreg is not supported!\n");
> +		r = -EINVAL;
> +		goto error;
> +	}
> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r) {
> +		dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
> +	} else {
> +		*val = READ_ONCE(read_val_ptr[0]);
> +		*val |= (uint64_t)READ_ONCE(read_val_ptr[1]) << 32;
> +	}
> +
> +error:
> +	amdgpu_wb_free(adev, addr_offset);
> +	return r;
> +}
> +
>   int amdgpu_mes_wreg(struct amdgpu_device *adev, uint32_t reg,
>   		    uint32_t val, uint32_t xcc_id)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 33a426f58e723..1e801f427ddb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -373,6 +373,7 @@ struct mes_misc_op_input {
>   		struct {
>   			uint32_t                  reg_offset;
>   			uint64_t                  buffer_addr;
> +			bool                      read64_bits;
>   		} read_reg;
>   
>   		struct {
> @@ -545,6 +546,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   
>   uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
>   			 uint32_t xcc_id);
> +int amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
> +		      uint32_t xcc_id, uint64_t *val);
>   int amdgpu_mes_wreg(struct amdgpu_device *adev,
>   		    uint32_t reg, uint32_t val, uint32_t xcc_id);
>   int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index d8b4d3deff605..ef82f7536e449 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -902,9 +902,15 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>   
>   	switch (input->op) {
>   	case MES_MISC_OP_READ_REG:
> +		if (input->read_reg.read64_bits &&
> +		    (mes->sched_version & AMDGPU_MES_VERSION_MASK) < 0x42)
> +			return -EOPNOTSUPP;
> +
>   		misc_pkt.opcode = MESAPI_MISC__READ_REG;
>   		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
>   		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
> +		misc_pkt.read_reg.option.bits.read64Bits =
> +			input->read_reg.read64_bits;
>   		break;
>   	case MES_MISC_OP_WRITE_REG:
>   		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 04465804c2544..0d2a60528802e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -858,6 +858,8 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
>   		misc_pkt.opcode = MESAPI_MISC__READ_REG;
>   		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
>   		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
> +		misc_pkt.read_reg.option.bits.read64Bits =
> +			input->read_reg.read64_bits;
>   		break;
>   	case MES_MISC_OP_WRITE_REG:
>   		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index d17ced46d5f73..e0a488e516c09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -581,6 +581,8 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
>   	case MES_MISC_OP_READ_REG:
>   		misc_pkt.opcode = MESAPI_MISC__READ_REG;
>   		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
> +		misc_pkt.read_reg.option.bits.read64Bits =
> +			input->read_reg.read64_bits;
>   		mes_v12_1_get_rrmt(input->read_reg.reg_offset,
>   				   GET_INST(GC, input->xcc_id),
>   				   &misc_pkt.read_reg.rrmt_opt,
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index 1fe824b41f2a5..b27ec78da3b08 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -635,6 +635,13 @@ struct WRITE_REG {
>   struct READ_REG {
>   	uint32_t                  reg_offset;
>   	uint64_t                  buffer_addr;
> +	union {
> +		struct {
> +			uint32_t read64Bits : 1;
> +			uint32_t reserved : 31;
> +		} bits;
> +		uint32_t all;
> +	} option;
>   };
>   
>   enum WRM_OPERATION {

