Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805CEC16B13
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 11:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1E3113311;
	Tue, 23 Apr 2024 11:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/7UCS6Y";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFB411330F
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 11:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKjeysh93Sm33KdFavPyTEuh84V2ZhgMMgXGnoB02lOGBcZzD7wU/kTT2pmxBlzO0nO4eknNzghsnNoT72HrxWTtAGyVYQhGLi7MfTgtcTRGDiZrvxfCtfkSp3PXBWE4IJyKXY82P2CX1nILQGJ5uW6N1Wr8EgmSeY4frTBBTbGB+JakQV8K9zpHOfXv7XjJEsLn2JG3ASRFYdh6mw5UtIXgJpbaoyGmL1G96cRh/KtIy4Q2HEsr7Os1KjYIgq0YVFcjiedkEzhKecbVNE5Tko2JU6ueDOQL42SiahcwuYGzGE5NVkpH5vo1j0Svk/7brQFQdrdPJ6LL+Nxgv1t8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+rOfNf5mgAyQx+2u2yyMX19W9iu2UZ0pKmW1CM4QD8=;
 b=hrW/KpFnYBp191n1yrIIZ0WOdvf1ZsnLIcxso343JSIlZhPs3N4obMp4xjZtGhjX7NgbyqWzFFY6Njvs0CkfwNfQd+zfQIBofN7EUW9u2GidaysE8ju3YCKOX9xOUjzt2dNJBFS23ai6vWmGtiCGkHWc4SX+z+AdkEsdisc99uT2Mmg/b/J8tov1Yl7hYGl7ASpzBBxBRwtN0CDyN+zppmK/3diuXRLpBZU6rROKdl6dvY/WlBBAXAzjZqhttstSd29AFQY13CoAcnmwFutuiNs0BxwXyEa6Bi3558NmdOK/5uw1GRrbOEGyWug8hgwmBI0DSJsuhqKzGdFd9EwyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+rOfNf5mgAyQx+2u2yyMX19W9iu2UZ0pKmW1CM4QD8=;
 b=g/7UCS6YIm0izpSf5+h34yl8QWGl/RW2U74d+xOJRyJHP/OzCn3g4Tv18jKUuSUh7dqGP1H4hyObcEBvf76Ipq1XRZzjJDzofFRPu9I6M87yd2oWkUNNtAz6drW7WgdTCBxDldvHv7h7IfE0NHapWYG1e0Z60In+hS/rPHR9vfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:36:29 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f7eb:b717:d637:dcf7%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:36:29 +0000
Message-ID: <48ce932a-cec6-4b62-aaa0-a4ecde39210a@amd.com>
Date: Tue, 23 Apr 2024 13:36:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add error handle to avoid out-of-bounds
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org, le.ma@amd.com
Cc: Alexander.Deucher@amd.com
References: <20240423091503.12691-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240423091503.12691-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0068.eurprd02.prod.outlook.com
 (2603:10a6:802:14::39) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: c68c2557-dfee-4dfb-532d-08dc63899e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGMrNWRDS0dFU3NlRnQvakQwWmNvTXd1dEYzNzh1K09rQ2ZwTGg5RWxpM2Vx?=
 =?utf-8?B?VWJwQmZ6VXZuc0g3Q24zTWc4QTlUdXVGdmo5aFI3MitGVnVEM1gveGQwYkhs?=
 =?utf-8?B?R3hlRk1ZYVJsR0tZcXdKbFYvazhoR0xDRGdWaW1VZzRZQzhEZTd1dk1jVVZu?=
 =?utf-8?B?L2VlOVJmZklOUVF6amszTFAreUQ2QWdlbjhvYklQTGxKQWd3MDJ1RUJmQ3ky?=
 =?utf-8?B?RHVOL2tJOG90eHlqTXZ4NlJ5REFFODlVUnd0MjdsQjV3eGlPeHhyRXIzY1Zh?=
 =?utf-8?B?NEZmeUVhUGVVbFdKeXdrRzAvaUs3NVNHRW54dTFONGpzWVgwTlpuRTM2OVho?=
 =?utf-8?B?V1dsVUVZS2xWVlFwNGFLL0phMkFyMlJXSElud1hobTMrQUE3WTZ4cFluVUpv?=
 =?utf-8?B?aFZFZE5TNDhDL01EWG9UY1BBRUFIQm5TWmxHbWpMQVNKelFLN1Qwd3RTYWxW?=
 =?utf-8?B?dlpnU1VycmV3dy96WnRHcDNMNzd4YjNHanpYanhEbytSM0ppa280QWx2bWNv?=
 =?utf-8?B?UDlURTNwenRNMm44M29KWTVJbHlhWmtVY2ZBaWRkanFrT0IybDRtYUFmbkpp?=
 =?utf-8?B?ckVqSjN2VEZsS0tSMWJKK3F1Sk9oQUM4S2hOWUh4TXlaTU02QkszLy9aUXRu?=
 =?utf-8?B?TlFDR2MxMHFrelBJckFpUUV1QmJoQVNBU3IzWjExSUtpWHNmaWxYTGVlb01J?=
 =?utf-8?B?RTMxZVdJNG1RRjhqaWZVZUtOZGxtU0NESEpZWUtPMC9mbUZEYUNzM09SNDF6?=
 =?utf-8?B?Y2ROK1AzSFg0aHk1cnJGQVdWeW41aWc2VFNKMEx5bmhjT2JJa2dMNmpZbXhF?=
 =?utf-8?B?MDhzdHJhMmFmWWhtVUFDeVVLa0RVN213aDRUQ2lDVjk4bzlZZXVYMGFQZURE?=
 =?utf-8?B?S2xsNW0zZFAydEE3VVVEdGxmR2NtRGtEN2pRZTJwOWhBaXk4S0JnYWhIM3Za?=
 =?utf-8?B?SklES1F3aUZGQ1ZHdTFjdnBEQzVXVjlmalFmeW9JeGlKN0xhbWJxV1Z5MFZm?=
 =?utf-8?B?bWtnekJBR3JHczlEWE90S3RackVyM0N0NzhFblAzcldSTzdSRUkwY21oZ3hx?=
 =?utf-8?B?RXFaZWhlQ2lyUnkyc1h1eWxaNCtWYzhwK2MydWs4emx1eWtRdDhqLytiN3Mv?=
 =?utf-8?B?MXFWdC9OZ3BzREZoZzRKTXFySzVSTHpOTThpUVIrQTh3SUxiUGVpRHhoeE0z?=
 =?utf-8?B?UWVNanh3VHpueHo3dDQ5d1kvZ0ZWellDbUs4Y0krRzkvOGJzQTNwOThtTGJq?=
 =?utf-8?B?QXR3RmhVd3NVUHpzbEQyUVVRdkZ2OWFiSnNIVTIwRmVrbitXZllWZUNXOXc2?=
 =?utf-8?B?bFdlamIyaEtOLzB1bWxKMktRSEdzdnZ6cjVkYndUdDBBcW5WMEVEQW81ekJp?=
 =?utf-8?B?UWhXZmZjWk54eFhzQldRRHEwT3N1SGpQbU85L1FiUGdjK2N0R0praE00cG5m?=
 =?utf-8?B?ZGFiNmFTbjZacXpicGxqL2YvcHpOTkIyL3c1QnEveXZhRnVxNDNlMk80Znlr?=
 =?utf-8?B?TUFXZmVJeWNlMHdjU3I4YmJnRldZZWlsdkhNcTlHN1k1Q3JlYklHQmd1cnVu?=
 =?utf-8?B?Z3RDOVNLTFE0ZjZOQkVTZkd5c1FzSWE4OWxQZnNtOU5WeDRRV2tnV1p5UXFv?=
 =?utf-8?B?bWxDZ3VjdGlnWnRWZmNxSXJ0WDh3aUlrWm0zY2hkWUF1Mm96bVpaOWpweEhn?=
 =?utf-8?B?cjhrS3FQTTNLNTR6RjRCbTlsSzRJRnh0Qk03bjJ5b0FvMHY5MG1CUUN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0dyOXhjVWE5QmhtNTZDVWRUZXN2R3VsV3RUQ1hld2xLMjJ5ZklGV2RMSjdS?=
 =?utf-8?B?NTRMTFJGajduQ1l4amh2TUc2emVDR2tHRzZMbmRnZ0ZQblZQK1lKMXYwYjhE?=
 =?utf-8?B?VTVtdEtXL1J5LzJkVmtCeDkxT0RJM090MFI3dGh3emFpSnZ3Y1o2eGREdzI2?=
 =?utf-8?B?VlBaVFVwVzF4QnVFSVpBeERRQ09rWjhwcUplTFg3K3h1RTVDbmFHRHArWks5?=
 =?utf-8?B?Yk1qblJlUitGR1FtMG1sbnlXNW80MVI3Q2FMMWVWeUlFU2wwRmJVaGEyOE1Z?=
 =?utf-8?B?d0pvVWpMT2d5ZmZ0aWR3aWtvWlJHa2ZTTEdCSUo0dTh2Y3VrWmg5d1VaNURI?=
 =?utf-8?B?Ly9IUzhiN0lWSUNHNGpLNEN4eE1zZ1NsMVNsa3p0UEoyb0t2emVqZFBmTHNS?=
 =?utf-8?B?ZzkwR0M5UjFtQ0RwU0haTlhvNkFISDZFZFFvVHJFdklHeEorRVMwSkhRc2w1?=
 =?utf-8?B?QkpiM1BuNitpb3gvOFlQenZjeVFqeGVQcWVBdm9sb1ArZzdqSllaUHJ2ODMv?=
 =?utf-8?B?OHQxeTFBczV6ek90cVRtKzBPUjVFVWZMckJJWEJJNi80R3lSOHpUR0J1a3hj?=
 =?utf-8?B?bHArYkN4aXRQRFEycXdZL21tcXlFNVQ3UCthNzlLMWxlemhXRWM1MGtPT0VF?=
 =?utf-8?B?QlVObzZpSDdDQWxEMm9Ed2g0V1VmQW5PcStobTJhVnRQRWRZMUhRNG1Rb0hj?=
 =?utf-8?B?S0ZTSGJDc2hJdDd1a3BFaDRZVWhod3FBa3hYTlRSMjZscUhSUjc5NjJ0T2Yw?=
 =?utf-8?B?QmxCY0p5RnBrMTBiZGloY1lhbUx3MWMrN0FCTWlKTFliM2p6cm9BSVFkemJO?=
 =?utf-8?B?MTVDRUhWYUtaSFVwRzk3bzljazNCNUVVU0FDOXRFcGlkNzhZbnlsNzN2cFhr?=
 =?utf-8?B?bXhpMmpUdnVWVUlXOVQyeG5RcDhpeXBSZDMzMVlLR2F2OWlXdmlkT3N3WDBa?=
 =?utf-8?B?UUxWOGdadDFVRXZsdGpjMkZGSTNvaStVbG5RYURhMzVnbXBuT0pFa3Nla29i?=
 =?utf-8?B?RW0vczF6TE9lNUNSSFl0OHpoNHVFVVVtQjJ6dTFJS1Y1YUR1QXYwalQ5c0lm?=
 =?utf-8?B?NlF5U2hNajdPTHJPWDlWL2JRMWptZzRyZE05dkhFR2c4UUN6bUdydDd6U0w3?=
 =?utf-8?B?dmdOQStlRkVKUHczbDJUZ3hIWjVjRVdFTHB6WlJnSHBvOFFHSmd0U3RPY2lm?=
 =?utf-8?B?UkxzQmlSRUF6OSs2YWQzY1NFU2pCVitlRFJCMHRyYTFBcGtubWsrclJMcXc1?=
 =?utf-8?B?Q0N1UXA4VlBIYXQ5MmZFaG1iOVU3cWxVdERsc0JoS29wYjJuTmdYWEpZWjdJ?=
 =?utf-8?B?eWh0U2JsOFpoVUYvZzZzUk1KU3YzQUc4dXhtUGlMT1duYVFneG1Lck9BcXc2?=
 =?utf-8?B?OCtjTDgxbjdrTDRZMlNMT0pBS1B1NUJjUFdYYXdrQlAyTzNybXhEdEphU0FX?=
 =?utf-8?B?SFcxbGNmeWtVNXoydUdGRWI3Y1lReDZWZmtLM0V1MWs3VE91b2RFVGlBcm1N?=
 =?utf-8?B?U3RvcVJsZkRhTVNtb2hnTlRxZFpEeVdLNUc5R0NwbkE1eW54OUdKMitiMzIx?=
 =?utf-8?B?VVhsNDlZdjFZaHNKUURLU0VSdVVkUk8rc2YwMzlDdG5nRkxaTzlvekJCLzdR?=
 =?utf-8?B?RFJMcnpVZUprc3BKOVl5cG01U0lyQTY3RXNIZk1aWUFoeHY5eTFHNEtJVE5Z?=
 =?utf-8?B?Z0xpNmh1ak5MOWZBTm5BMkp6TG1Ib3dBZFV5MjUvWFZPT1M5S205d2UwQnVs?=
 =?utf-8?B?S3c4WmlvVEpJTFNnL01rbGRWeUpNRFRzbnpTSHp6S29ROVZqMWVhNllMa0ZM?=
 =?utf-8?B?RDl0Vi9iMitMV1FyWC9lOVF3Ty9HdzFJa1ZJaTNaNFJjSVo3eU1GUHN4d096?=
 =?utf-8?B?VlBWdllJdzBTOHZqeUZPS1gzNUtZT09uS3d1SXVxd2tPYm1yVm1tV25sbTdt?=
 =?utf-8?B?RkkrWXFnRWRxNjRYeEpsY1ZVc0M2Um9Na3gxSHpiZlUyeG1NcGdFSVk2MXJy?=
 =?utf-8?B?YXBaWk5iaUxiLytsNFRDSmRNeURrT280M0RSR1Z0MWt3SUVMMmllblF3WjIv?=
 =?utf-8?B?R3NVRC9lTmY0NnBzdWk2T3plWG1MVUVXMDNoc2p6MWlkRkJMQ1lKalJhWnpt?=
 =?utf-8?Q?AK0k5ZSKx5QMz0/A9WG7nbsUf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68c2557-dfee-4dfb-532d-08dc63899e14
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:36:29.6378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF9meyOj/gwwkxYa1oz3CCbH6tgVee3Rnn0zYHW/Z/XBo/nxLk04rqCW2886JZeM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
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

Am 23.04.24 um 11:15 schrieb Bob Zhou:
> if the sdma_v4_0_irq_id_to_seq return -EINVAL, the process should
> be stop to avoid out-of-bounds read, so directly return -EINVAL.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index e2e3856938ed..101038395c3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2021,6 +2021,9 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
>   
>   	DRM_DEBUG("IH: SDMA trap\n");
>   	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
> +	if (instance < 0)
> +		return instance;
> +
>   	switch (entry->ring_id) {
>   	case 0:
>   		amdgpu_fence_process(&adev->sdma.instance[instance].ring);

