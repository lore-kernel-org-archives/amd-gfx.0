Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AC1C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 13:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E69610E5F0;
	Fri,  5 May 2023 13:17:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C5510E5F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 13:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBlXhS+dpeEgfThrS4kSv7deTgZlpz6Mc9xPiTYaUop0Cm/PfZN98NI19bw6BxAf4DIVjAsVmHSrBPPGD1sUFurNT64TJHBwjZQDQLc/UxldyQNwVZYIfSJ6t/W1t5CUcLRnxxmJBaVHrGOZGF/M2BP12Fc2dm0ZmlG2xZcUFfyrY3ldEMWShP+MiNSFzmgdfCcwE85Vz4MPxTG3dbc2rIeLA6saiC2ZGxuxxs8pzhCmHOtC1U5VWXJQhvYF0Pc0Qmtp+eqCjE4KYYv+sHb+ZoylU6cSOiN8ZpwYPWWi7yqWvuljGnu02Cg5WFvg/pSzOcH4cSIPmaCdmqmI4OHxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDINWVR3ViQPUKLCtO2sasG5KpB5sL1fQaIfBKobYqg=;
 b=DydgNOlGl/SMTkBYWilS792ez6CtrtFurWb78q2ixSLaLtFtC4SSuXqSoLo5FQ4R2PLTo1DggaTj9b0KoFht20qdy6viNwLsJhMi6umkCOwSyJPGS3WMsCyPPfMYOZTCXqf8QHnGVw8YXwZVDxFm1ZXMjuSd/M7l+c/ACqrlm5Kix/erBkwnL5ntA0FelCymYdcpkJ76ZOKdRrRXYfv/XpBB9A+7CkuoXfoYIirv1PaHjCgjXr1OYWVnnl07A9cTLZ7JocQvi5xkiJBSEMcObNsmz2oXhItH2EqltgEbF9ZuqTyGV5HfSI+mNQhgNSfZSLB5EVPXe9ggj/W/E3kLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDINWVR3ViQPUKLCtO2sasG5KpB5sL1fQaIfBKobYqg=;
 b=0PuK0vGM6pjLpDNFCEfIzl/971PoeVXBw6X0AVxR6+xtFyuwHee8XyW1kpGnjUpOotgvEJ1+dBocaNUrd7rD7pbZJtb2SsKgbZks20eoVUZJly7DVRMtEW5EI7YYtX44apBzd/0wKGOlb7vE2+MUhX/PeoX8CSlhtruK2WOpplY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 13:17:36 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%9]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 13:17:36 +0000
Message-ID: <090666d1-84d2-e051-58a4-e508af410976@amd.com>
Date: Fri, 5 May 2023 09:19:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix vram recover doesn't work after whole GPU
 reset
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230505034655.1077755-1-lincao12@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230505034655.1077755-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::13) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc467a4-d6b3-4ceb-577c-08db4d6b1816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZreQL2+5zV/ptJrxuxF9mfam0Sw4DaFIzWvLRfgltH4w+yRRdsf7omo2pZeH110x6LxGcXXO1k0M2mFfYQw8lUky2zpu230RgLH0vpQzX3cNOZIfUJrT0zcI2XPhekLlrS84JBcYGS4yIDUwrnDk1aXAYE52qKxMuS5GVHe8a6tKYGpz1hTHH+oOsVu6KrlTXA7ETveKLaQadHhlKvN+w5RexHmI4BUOPDj1gzddOzOucpxFNKV3XdFSrGcFo940KTeTZ1YcFBSZAGL0xI1dqN4i2Iu6yiN1heDV8GaS0qh9w97OsUBBam03f310MTYFK9P6JkuATrGyR2SfFX7L6Q7TlZf0xRVp6hqjmmmt49lUmahBNfbL8ychS2L3Z3/h7T/J+OTDjwuNYWlpTePzipw3Wzb6O2B51DIncFCILAl6BP6JvkesSG3FCSPp+gVom94BeBMqpfDnnG4Cd0LFpBRLStj2bNLU5qW6/SeIIicu8oRCp0rr/UERs9qynKGHfRz+8Ins9MLdCE4jTcSioruVZykyHkhpJcOjB8ZQrxi7khsrb+A3VzyJMH7sLRXBaE4TsSW6G8Q6Qmd18QiAgYxF9oj2tjfuT/aGhqCG1pqjFdUm+gTtMZQ93KJQ3aLMfibEPWSxj4sUUV2znkkPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(26005)(6506007)(6512007)(31686004)(53546011)(186003)(2616005)(5660300002)(2906002)(83380400001)(44832011)(8936002)(8676002)(36756003)(6486002)(6666004)(41300700001)(316002)(31696002)(478600001)(38100700002)(66946007)(66476007)(66556008)(4326008)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHEraUxnN2Qva09nUWh5M1RsVDRlVzJ3c0dtd0ZzKzIxZk45OEdybFVLUjNP?=
 =?utf-8?B?Y3ZnYURiSFZlTzZmUXBvU0RUMG8wakJjUitCVWNTbzU2TUF1UDJwcE0zQkNM?=
 =?utf-8?B?d0hpTk1yckVlQjVyV1p3TW96T2VLQWhBQjBKdytHbGhnZUx4dGgzWG4yQ0d4?=
 =?utf-8?B?YVZxckxSWHVxT1BEaWFkR3hoRzRMQW5ieVdBQ2VRdVIrV0sxQ252RVZhVlBH?=
 =?utf-8?B?VExuQnN1UHMyRTgxSFVWMFFnME5nV0UxcnVncDZVYnpGczZFVmJjZkRkbE5m?=
 =?utf-8?B?QUFnT2RGajM3N2t6aWp2SVEyWUw4YjF0TnU4K2tGdjR5RnlPSWZmVHFhVno5?=
 =?utf-8?B?dUUvNzZ0dmFCVmxSbTZUNFVjakJYcmlpVkozeFpCMkFBTnJkSFB2NWFXZjlN?=
 =?utf-8?B?OEhZanRzQnF4TXhFUW1pNGorMnFSTENSR09FS1hBT1I3aXR6U3lBUHUwL3hZ?=
 =?utf-8?B?a1E0SHd0U0JhTVNienNzSnFiWUhuTHI4VnVvYkRFTlNoMDhlMEhXcFlua3I0?=
 =?utf-8?B?YzNtZDl5UUNSa2UxNjVXUEhZUTZGY2FQaWFmbGMzYVc4bDhjVTAyaVJRN0p6?=
 =?utf-8?B?WCtBQldwRmVLbElNb25DTWdLT1VJNUJBbVRXOG9KaHZDcktZVFR4Qnc5aEx5?=
 =?utf-8?B?RDVUSFh1N1N5VjBxZlY4NlJEZGkrQkJLL1phZzI0bVFXSmZBOFRIYkd5YnA2?=
 =?utf-8?B?VjlJMWpnREhqbjBpNnVJU0x2YWo1YjJHVkpMM1lQajhlUXlHOVFWRWpudjRo?=
 =?utf-8?B?WGEwWnRncEE2dnF4ZkFhczR2c0E4RDFUdXRUUFlXWDZucklkN1pwMWlGdjQ1?=
 =?utf-8?B?dTd6UFlqa0dhMlFCZndTb0tQbHkvUDdvSnV3MG1YQ1IwQ3ZqU1FJMmRpWjBV?=
 =?utf-8?B?Q1hCcFU2bVJSRkpkWnRIdkFkV1NRNWhPMGEzdWJXNzNjQjFlMzVYaXBJSTdt?=
 =?utf-8?B?V202UjIzd01jeWNsS052eXlFekk3MlRhUWQ3NUx1TjJaK1FUMTlqNTNTRHc3?=
 =?utf-8?B?Q1FidDM5UEdMRnNpWFRLZTFQb1pFSmdDNVVlZlhtVzVpZ2UvaXhlTnpNTDJh?=
 =?utf-8?B?ZGVVS3VFYU1BS3Q1Y2ZUQnJYTDBCc2RyaG5KZGFCWGJ2WlZvNWxUU3kwRUNB?=
 =?utf-8?B?YUhqdlNpRERIdGFqYVBsN2FxUEtxWGZTYUhYMUREaE16N3hJbTFxdEtSaGdP?=
 =?utf-8?B?NXBybTVFN29uazlUVUdaVlZpNGpzMERRVlJoNkgwbGxuY1c1cjB6MlhxK3Bw?=
 =?utf-8?B?cllKalNHWEpWWXdCZzl0U3VaSDRBK0VkL1pyT3BiRzQ0Nllxd3lqdnVtRC92?=
 =?utf-8?B?aDRCQXlxVFh0emxrRUx4eHovTGIrZFI0YkFWcVZNQXR4ODkrRWx5Z2E3VVhm?=
 =?utf-8?B?UVAwMWtTU2NNRGpZQXpSM2EwMTZqS0w3VEF3bk90eHFIYjYwNi8wU2NEZjE5?=
 =?utf-8?B?OFVlbTRCYUFzTk9DVTdKazlFWWsyeWhpaXpraWh2Kzhrc2FRREUzVFEwRWdJ?=
 =?utf-8?B?Nm1OOWo0RXpDbzJFdFpSVTdXajhFaUhaNzJ6THlFQUdTbHZGVnZMZ09pclZF?=
 =?utf-8?B?akl0SlAyZDdOdTVsM0RPSlA4VGdxL00yZmhIaURBTDYwOHhBV051cXFkbVV1?=
 =?utf-8?B?VENiaVJmTlVjLzFxL1RldktlaWRrNmRJVkZTbmx2QlpFM2dtdEtLYzRyaEZP?=
 =?utf-8?B?RFh0Y1lZWVl6bXAwbVN4eUZsN1pRWHRIMkRIMEZac1lwR3ZuRkx6eUNGcHZN?=
 =?utf-8?B?aUxpMkpJS3ZSM3RuWlVFYTdxVGhYTUdzQjV5Tk93c2dVbHF4UFdPNXBySUth?=
 =?utf-8?B?SHFpdmg5RVBVRXcvdkIwMzF4RkgrY3JmZUs3U2xLM3czWGJIVHN6WWRHcE9r?=
 =?utf-8?B?ZnYzRnp3WTR0K3UyOWdFVFpyOXlzSTBRWnRRdmdtdFBuUDJuWDg2TDNwZHdy?=
 =?utf-8?B?QU5LamJwQldjZHVUbVhQdnRINkdnbmptMDlNYTM5MWlxRW84dERLOXhhc3E3?=
 =?utf-8?B?ZkhKZHdmYVdFYXlTdFAzTUlIUG1CclZQNVNVSTZaSXN1MG1wcCtwSnVCQWpK?=
 =?utf-8?B?MTRGOThSZjRFSXB0ZEpLWElMUVRZMU9rK1dYNzdpeDQxOUFhZjljM2VVckp3?=
 =?utf-8?Q?LRvO/kZC+9sU3qbCe4WIyK/81?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc467a4-d6b3-4ceb-577c-08db4d6b1816
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 13:17:36.6031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNop40JdyAk06R+WqoPgbxYoVV0iBZLAi29NBO3rhzxMrl9ebc/xpQNwwZADYvjkIb872Et7WxDufcosIbH2Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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
Cc: zhenguo.yin@amd.com, jingwen.chen2@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/4/23 23:46, Lin.Cao wrote:
> v1: Vmbo->shadow is used to back vram bo up when vram lost. So that we
> should set shadow as vmbo->shadow to recover vmbo->bo
> v2: Modify if(vmbo->shadow) shadow = vmbo->shadow as if(!vmbo->shadow)
> continue;
> 
> Fix: 'commit e18aaea733da ("drm/amdgpu: move shadow_list to amdgpu_bo_vm")'

Please change the previous line to:

Fixes: e18aaea733da ("drm/amdgpu: move shadow_list to amdgpu_bo_vm")

> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 750eaffa81ba..0581b4fec001 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4514,7 +4514,12 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
>   	dev_info(adev->dev, "recover vram bo from shadow start\n");
>   	mutex_lock(&adev->shadow_list_lock);
>   	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
> -		shadow = &vmbo->bo;
> +
> +		/* If vm is compute context or adev is APU, shadow will be NULL */
> +		if (!vmbo->shadow)
> +			continue;
> +		shadow = vmbo->shadow;
> +
>   		/* No need to recover an evicted BO */
>   		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
>   		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
-- 
Hamza

