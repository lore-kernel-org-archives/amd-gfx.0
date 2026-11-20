Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD3606A690
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YrlLg+OQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175AF112D32;
	Fri, 20 Nov 2026 22:17:04 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73B3112D3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 22:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQ5ZB52gwNxEk+1YChRDaz4982Qf1D6gNF1HXZgKLaHVCkiYO2BPI9IubudFhdqfTUoy8HHqOrWiONeG82Dc3LGHYuyZU19tMNXURw/L9QB4oxMFEqwhtbRCRtoPFloWCy4yj+GGga0xPb1KYyIPYlRODA+YGXDxw71ij5m8YhGgan63u2KHaMnpvGcDjKsSDBdofZ2b2iufpE4jkJC5lt3eUn7rfXYL99gVf8li5YpYnB7yUTFZUd/zDnw1wgBEezqykpubrAJ9GfkL1adiIzTeYe/vyzFAg0PQXn632N+11l7f4fDrZOhWJYd6bie+PFvE1d8jzP4wxshP6wBi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbinDvYHB6DIGPJjQfJxQymR/MtyIeOCefcSE6WhPZQ=;
 b=B786EFU+fsRbZE7xc1muh6fNEx6yU/MncZZplc6Qeq1G7CNkgLlOeFz7xaX/8byGv+fcxy2lVBhu488iYWgABogZ2BPnL/AHGGSmKC6ccl7+3tOsI5kZchbbjCdfLliz4d8teH0Uh3F5vUiL0GCpyFsyWFKgMT1VScQRp3hKKIEtPQCq2+2n5BTTcEpExi7ZU2dD9IZnMEsPrp8O3fM4gX5MiVKQ374BZSkg/dcWmwbQ01nrCHYS63E1uLVmE+KtxZPeTPP+dvJJc+ZETzhKgZaIJtm5J2dWFXtpV97WfPPQ5mff7HbVefbS0aHKlFp3Fv4K7MVMQzS2p065v7Uu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbinDvYHB6DIGPJjQfJxQymR/MtyIeOCefcSE6WhPZQ=;
 b=YrlLg+OQI5UhLR1NPmtlY872irPCtCVmPkaGNdOmevXErITR1f2Qy7vnyVRWv6xTgNwGyq/3MiUksNsufIRvR0tXIt+jqCJF1wjpxbKa4JCPduSHCGrKAdB9CHHu2mYWQUKXU6R95e4wsE3qfS2etxF1wMbuTGBl83yulKw/q40=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8SPRMB0063.namprd12.prod.outlook.com (2603:10b6:408:242::10)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 22:16:53 +0000
Received: from LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0]) by LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 22:16:53 +0000
Message-ID: <ccae1602-9922-450f-b5c9-385459a94baf@amd.com>
Date: Fri, 20 Nov 2026 17:16:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: don't map SVM ranges to a GPU without a VM
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20261120091638.20608-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261120091638.20608-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To LV8SPRMB0063.namprd12.prod.outlook.com
 (2603:10b6:408:242::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0063:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c05ba2-dea8-431d-2184-08df4753fb63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|261102123227099003|11063799006|261028144727099003|261021135927099003|261021121427099003|261022105027099003|261009223027099003|261022075727099003|261026140227099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: cDdmwJG7iGw4dorkHldicODlQ2jnY1+N+MjtFh6IkFKlILC+JVk3b6hwDc8kZEPpMK+hbsGo7hN4fTXVTj2jfhQ3qPEd0qTG9SLEC/C4yvssWJqFtNgdI9wsa1QPdFI75xoaUP2JXhYrox7NScZcCIZLyvwQn7RLtPCXANBcKIST2gEjot0qU9FEMz5aaPkatEixM8WPXp8vAfVkoJm5Knq9nv5bQa8TbB6T/EO2wlBNugaZ5OC8rgacZc44sPeh1+mjFoveODeKNE/Gjq2m6Ans1c229RFd8Vr2S+GqIlUXmqkKDF4F13dAxRCplAlvCVLi71BzH9aiA4DTLtgO1LpihmFr4mNbNXr3ij+fgU6Xh/418yGuw1Jq6Xrc8I6s7afxHOAN+WOthxUFZv89gQPKzGY3Ks+VNcg7DndyPltWqurIHj3bez6LXcCMS9D6CDf/1f/5FKwYbZq+D47WCn3XnRgppdxUe8X/cIh+fqaXYHbPt7eY2PXQXmEOx8ia/dn69iY+sqJ8Ucw6pHe1Q7GgNab9I+3cqcWXhPwud+pUoLhatQvTUdI7/G1S2uQs7qL7l+e3pXOH67b16KyhrOc6z2rZLoNwtGPL23RoAbOmy07f/KdauZc/1fQ8/FlC3pxW9j0npomG3UdyOL0/SZWcXWWglGfpTu2B2Nlt/UE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(261102123227099003)(11063799006)(261028144727099003)(261021135927099003)(261021121427099003)(261022105027099003)(261009223027099003)(261022075727099003)(261026140227099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1Gd09DYlNZL3crTHRGT0Zla0VUR1l5czZSdTJRMDZrekN1UUViWWtXYW54?=
 =?utf-8?B?QWZPUlhUTy82OG9jM3hzZG9YcE5HNkpPVklpbHlKWW5xeitOdGdBdG1FNFB3?=
 =?utf-8?B?SFhMSEpkR01OZHY5SDhoUTdnV0FHeUUzd2NENFgrTFRWNUQ0SHZrTytTSU1Q?=
 =?utf-8?B?c1hndG5rajRNOVNnMzY4V1BkckRFbkp0SDg5MjVhRHludVRHWHhQdWJXYmJT?=
 =?utf-8?B?amR3YlRCdmw5MTdJSkF4TWYyYXBQenoyYW51OWJEYWQvcGRTZHpkM3RlRUxI?=
 =?utf-8?B?WW0xTDhERzA4WjBVdmhZem9aZFFOcWFJaHd4U05JU0dNaEtnbEdSeDZrQ0Vn?=
 =?utf-8?B?VThRS2p3Q0trem9OSm15U2ZSZldyV0c4bG5sODhUODBzUi8vV3I1L3RKSDF2?=
 =?utf-8?B?bnRnSC9iZHh2MHM5ZWVNb3pNNXpLakFLRFZOeUVzSXg3d3daMTQrSllNNitw?=
 =?utf-8?B?ZGJlS1ZselB4OGJGVVFxOW9VandwY3UwL1UweUFqallaZ1RaY09GUWRpSE9E?=
 =?utf-8?B?cnJtVlRsNzdnalo4SXhsK1ExZkpzQ2g2QzgxWTVNNFFZVk9qZVFudTdONFY0?=
 =?utf-8?B?REwzVGFOWlVraWNPSzN0YjlzbVl4ZStTclROcjhHQTlrSnNhSGVBZDJnUjc5?=
 =?utf-8?B?YmdqdHVYSUtnZG1hRzlDN01USnYybnIzS1ozcUZmMk1DT3JFcFgweDAybkJi?=
 =?utf-8?B?UGRZb0tLTU4zSE04WFc1TWtJa0NhU1JIZVBMRHpXNmpEajFuU3NoblEzTVpG?=
 =?utf-8?B?QlV2MjRvWFhzUUZZT29ZbTdQTWM3NWtNVjFRNVdpSzVqRFNKb2NhK2Ribll0?=
 =?utf-8?B?amtOMVZRcjdxNE5nUUpiSWZ1cHM0MEx0dmRhRUJLNFVPRjlDOXBZa0tIOGJW?=
 =?utf-8?B?Sm1MS1MzQmZWcHhZcEdJaHB4OVlZL2JZWkI4ZU9NK2tOZVBDMnVwOXdTSUJY?=
 =?utf-8?B?SE5vamt2L0RkanE3c1M0QWxRdGFhOFhqOVBEY2FFYTZVWnZpSEpIMGZvaEg1?=
 =?utf-8?B?ZTNXQW5QSFdNTHNiUTF3cG12cHRnbS9WK0crNk04QjJUWk01Qm4zTjlKSWQ0?=
 =?utf-8?B?Mjh0Z3J5ZVdYTGxDKzgvZFpTVWZPZHQwZ25icGo0c1VaVDlkZU5XazhHeUVN?=
 =?utf-8?B?bkxuVzQrUkZVSDFPaVMrNDV2NUhTKzZZUGtPMlNLZUVVSlpaV2NVa2EyTk44?=
 =?utf-8?B?b1lhT3VOcE1WTWpQQy9VZjNhMEkwRzB0eDB0STEraUxkRDRTTVB5NnJWcU81?=
 =?utf-8?B?Y3k2YlFxWlpFaGIxU1FDZlN4d2RhNGtPYUZKNkRzVy9zbzl6UmIrekphN1JO?=
 =?utf-8?B?WkNoa0pRazZ2SjVkWGJCU24zYXBpT1J3U0ZMMGpYOW4rclE0MEpIMkdPMU84?=
 =?utf-8?B?Zjkvb3JZK01ybzRablFFbHJ3UnBKbGVsNVZ1aGVmSHlmWWZ4enZXRWZOZHJT?=
 =?utf-8?B?dHZ1aTFrNEpWdkhtbElBdWF6TWV4aHVjMW83THlDYkVQZjlHSExBSFNHL0tI?=
 =?utf-8?B?QUU5YVA5aEZQUVd2QjQxREpwclV5WERMdjlic3VJY0dWSVFtUmtrRW1tT3RS?=
 =?utf-8?B?bGdJTXV2QXpSbHlEQ1k3MFhzSFk1S1RmL0FWcDM1WUh5K1VnVnpidmQ3bUZn?=
 =?utf-8?B?T09YWWhqd3BGajdYeUVWV2V2ZklBOWZVc0NEczBEUHpoVVExVGtzaUZHT0Fh?=
 =?utf-8?B?NGl4Q252SDBQc3FwZEs2T1JabHU2QXhkLzJHNmlxVDUrZWhZN1l5WGpncm1t?=
 =?utf-8?B?akh5Ykk1dWQ2aDU2MWFSL3YyOUx5MDFOby9PeFM4YUZQNzVGWUtJVHRUdHB6?=
 =?utf-8?B?dU4yQmhCb2ppc3JNKzd0THI4UE9Belpwc1Q3dzVpekdQSkdSeFdlQjlQNmV6?=
 =?utf-8?B?cFZJYWptWWFveTFJa2JvM0k1cmgxQS9Yc2NIaTMvNWU3L3hKejFGM050VExB?=
 =?utf-8?B?R1FPMis5a3dvcTRjNXdnL3BBRkN2SjhlK0Z6d1dYaFRQSlNwRStKMjRrSnI3?=
 =?utf-8?B?OUI1RjYrUk1yeFFHYWNzMHdlS0xuTUYvWWNDYmJGNER1UTJ6UzZ5YnFjTjFJ?=
 =?utf-8?B?UXdQZU5pMXJrVGJaR2JHRzJpMTJtZTdNdTNwK2o1eUtscXhSckRMNFdrbTZa?=
 =?utf-8?B?QkhwSUovY3BleGVkakdVN1ZtR1NXVngxbGxhdWlBcTIxb1JoT3FyWnhWSHJt?=
 =?utf-8?B?NE1meFNGVGlSRzMxRHJiTklldmFjcFU1ZlBVUklhNE83LzgwdzdxYTR1ZVZp?=
 =?utf-8?B?Qm5rY01TRXN0VVhOSW9yaFBWZmFXUDZra3Y1eXEwOWs5RXJPamV3aitHY2JL?=
 =?utf-8?B?blV3c1lGallnUnJkQ2VuQUVEcEtWeVVaU3JpeTE0Z2ZUZWlUUjlFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c05ba2-dea8-431d-2184-08df4753fb63
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 22:16:53.6818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA/R5YT2ovUDfSdJqNOHExYv7PbNC35dHcNkLOG5zIrw6nJFMo0o4/WdWALNMJ2Kxoz6+IDz5PIX6KzZjs3k4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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

On 2026-11-20 04:16, Zhu Lingshan wrote:
> If a kfd process does not perform ACQUIRE VM for its
> kfd_process_device, the VM of the pdd is NULL.
>
> svm_range_validate_and_map does not check whether pdd->drm_priv
> is NULL before accessing it, and may cause kernel panic.
>
> This commit fixes this issue by skipping any GPUs
> that haven't acquired VM in svm map.
>
> This commit does not return an error code when
> pdd->drm_priv is NULL to avoid endless
> rescheduling of restore_work.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7401b7fdcb57..b5175f346351 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1818,6 +1818,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);
>   	}
>   
> +	for (idx = 0; idx < ctx->process->n_pdds; idx++) {
> +		if (!ctx->process->pdds[idx]->drm_priv) {
> +			pr_debug("GPU %d has no VM acquired, skip SVM mapping for it, please consider acquiring VM for it and perform SVM unmap and map again\n",
> +				 ctx->process->pdds[idx]->user_gpu_id);
> +			clear_bit(idx, ctx->bitmap);
> +		}
> +	}
> +

I'd put this check in svm_range_check_attr and svm_range_new (where 
prange->bitmap_access is initialized for the XNACK-enabled case). 
svm_range_check_attr gives user mode feedback when they're doing 
something wrong rather than just silently failing to map memory.

Regards,
   Felix


>   	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>   		r = 0;
>   		goto free_ctx;
