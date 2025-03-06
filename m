Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A5FC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 11:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F9210E943;
	Thu,  6 Mar 2025 11:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8H1CVGm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798ED10E941
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 11:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPHIFB8TAn2Uc+ZcVJXfQZlklVjJlJkLKnLQ44DSLeTytj/GqkBE+KRZM9i2UeKnNAwPAq5FVEPZeE7P8a4Otk0WqF9FbpLg2oecss16U9dHRlp1RLGFPFKMCuYCGZmCC3cEBVFPlbU1OBUZeyJRsvNV3mlM0AL3/XRVtR/ttamNFeI6a0SSRG/S8570YWXU2jHQ8LT4KZfm3vJFwxfKGcndNlarcQMwwOrhE2d+IKfCQSnoA9iX6x0+j5co0GcSqvdzMXBrJ4erZc1FyHs7ierhXKe79Wbf7+sFS9Z9s7OCH/iTXZvAO278y6FVbsJhEg1XNUHhAfwozkzVOkWdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QknwGaunmbfwFiLSouZiMM6G4VQOWeln7Uny75aFHqA=;
 b=D3CsCGG3vBwv5yfPCCHgmfczPSpZGmNdzvTL1iiJ8uz1R+BOWntoWtNe4L5MHna7vU7DQJSK4wPrSKIJ+gJZxI6/QzV5dDcZGTx839FZYHdb9iLUe+jWSSMcDkc8hnagXFW7skQ6LAnxiO2bnG3WWVj4es73V7K3W6Kax2vIFbvGpXqKrEUmPTsJK92n1LZjj+rleW52BySezzxTF1GQkgvRZ3D26PyZrJgFCIUOERiPHU1BVJhgyQCO8PA/O0V3WenlwbhjpGfZ7fxVJPD1zQBGyz2Et5V1nLBpdEtDUo3uvBPJnxvZCTVpkQDXGGoM4AKCttuNTrkyUFEPEKiyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QknwGaunmbfwFiLSouZiMM6G4VQOWeln7Uny75aFHqA=;
 b=g8H1CVGmx/kAvgYAQJKwcPt8MayI91q8dO68ZVhx51kur00MV1gfWnC7eYjgyr8Vbo/2WOYU06Lv8pxahKVaskTdDPJCuiHinmN6aNnIuhaGLl83HGtRuGN52A7MaHiOl/MgVLC4l3K8zFQzZ8cH+2/NAZV9Lsg1nWABBqSUHsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 11:19:52 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 11:19:52 +0000
Message-ID: <8f032d11-10f2-4a6d-89a5-c6b5a40d67d5@amd.com>
Date: Thu, 6 Mar 2025 16:49:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/amdgpu/sdma6: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-11-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-11-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c95189d-93ee-46c3-2885-08dd5ca0d064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2k0Y1dBVzFqd01WQ29tcU9GZFVUd1l3L2IrekNmVWMzVWREQ1JyMzc4bFVG?=
 =?utf-8?B?anhucmljQ1Z2TmJHd2lGKzZtdCtxMldGc2N4OFhpaXEvR2tyRFdxc2IrNlZH?=
 =?utf-8?B?bzBtWFNPM1JMNW8xenEvVWVGOXZzK2ppR3lZT1N0elJZbklRWmp3eUFTVm55?=
 =?utf-8?B?N2ZYb3Z0aHdJTUxoS0Y0bHFISlVyRXhWSWs3NVBQNW1CZ3R1SjlEZmlBT3RT?=
 =?utf-8?B?TjJpSEQxWGhodEgrTGVtNUEvR3lLdFRKQUFkNExCRlM1THJqaWJRQjRuME1i?=
 =?utf-8?B?N0FrNHlDNWQ0NUpDZFBLNjVjeGNBRWtTVFRXVHR2emwrZ1VidlhKaU9kendQ?=
 =?utf-8?B?dkoxU2xOc3U2Nm51RmE1T2pTeU9pNFVpWmp1ZFVNU3liMll2VHJBL09mZkoz?=
 =?utf-8?B?ZlpTSm5xMVg4VGFWN1hybjd5a0NLNTk2bXNEMEVjSVhUVWlCYVF5eGZmNElI?=
 =?utf-8?B?aFdzRjNaNWJVd3oxb1pOc2p5Tk5JK0FzaXM4OTRwVU9zQTVzenR1QTRiNHhI?=
 =?utf-8?B?TmpJNUtXZWtGbzR2Sjc3VjlybjhpUGhZUEk0N21tcWZZc1NBaFNsK2YzVlRL?=
 =?utf-8?B?eDZYZDJiV2xsaVlsemR5cG9PemlzTURrK2JZTEcwRklva2p1ekljem8zZmZk?=
 =?utf-8?B?ZGhHQmJxVTVQTlg1S3NWQm5qZGJTdzEvZzNrd1ZzOTVUOGFUOHdBRWlqV0My?=
 =?utf-8?B?ZkFwaHRUSkVKOFMzcUZ5TnBYdUtESitZOU9GMGw2MlgzUUd4M3l0eWY3ZmNQ?=
 =?utf-8?B?MDY2YUJSc3gxQWNzV2hEdTdSOHgvZFVQSDlNWDYxVHdORFo5ckJyL0pmMkFp?=
 =?utf-8?B?Tlp2UlFDUWZ2eUZTTEUveFh5bDlhTXpqRDlTTnl0cUpXc01KeW03SWVweTJW?=
 =?utf-8?B?L0JVN1o2dTQ5czRlb0lBVzdFNU9XMm0xZDRORUw3MnF3bUkrZThvWVd1RUc4?=
 =?utf-8?B?MHYrSnliUTFUVXVQUDFCdXZ0cFJ6d0dmMUprZzZoUS9hQzZCVmVqRzdZR0JL?=
 =?utf-8?B?MnNSVkdYZUxnUFd2MlpYQVdCMFlvRkd2bFkwT3RVM0JsOW9Od3hGZ1l5UzRx?=
 =?utf-8?B?NzJNWjQwekJld0hjV0tGNDc5SjkzbG1rUlAwbGN0cjVrclVOd1VGME8vZXd6?=
 =?utf-8?B?YTNIWklMNG9nY0djQXhNVXh2cjBWY3AvY3ZLM3hub3F5MU5mOWo2eHkxOXNY?=
 =?utf-8?B?cXVlVmtuQnA0czRhZU41R0h4c2U5RGExNnp6MEdXMmJ3eWtXaEZHOXVpYjdE?=
 =?utf-8?B?RjIrMGRpSys5Q3NWSVVVbnRTcHd4Lzh3Y0pPRmhqd0IwM3daa0FaU2tuUFIr?=
 =?utf-8?B?SlFPTDUvbFFXQ1o5VDA2T3hvWmVnQStiUVA4T0x6cUJTZTlveTJxeHlhZ1Yw?=
 =?utf-8?B?Qi8vUFhQOUpNdGQ3KzNwUnRacXk5WXNXWkpLNjA2K1JucExHNnlMbzl1MU8x?=
 =?utf-8?B?V3BtVlBMLzRKejFyU3FCYnZRRkpiaDhnZWdWQzhWYy9aR0lMNndwWHFJS2sz?=
 =?utf-8?B?MmhOR3B5czVKRjRTanR4U0FVZ0tCNXRaaTExZjJ6Mi8yUzVRWHdZYWNYcStt?=
 =?utf-8?B?QzUzUE0yTnhNZFRabkVjTjhUQURNMEJPMkQ1eGxwczUyditZTXhSYXQwUjBz?=
 =?utf-8?B?WnF5MWF2WUlPbWoyUFBMSEp0eE1BL2xHTU9xR2JsZHB6OWQ2dFJ1WkVXV3o1?=
 =?utf-8?B?emhoL1M5WC8yTEVjUWJjbCtOc3J3MXlpdnVWWExEN1NiaGYzTXd1M2UvSE01?=
 =?utf-8?B?Sys3L0tvQVpoc3E4UTdnNUYrS0pwVTc5QjVHNlhSdGpmR25SQU5ZSHJHMlNh?=
 =?utf-8?B?cVBNemE1M01ZSU5IVWdQL3AyUUVZcG1sY0hRdktyWVVhWHpiZXhRdDZjamhQ?=
 =?utf-8?Q?/E//w/5shjh1G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzdHcW9UMCtGSFl2NTB1WDc5SStJdllvdUFpU2Z5MDdNUjI0bDd2SlUvYVZM?=
 =?utf-8?B?MTlmcXI2SzhZbEZUV3NsQ3RnbzBZcjhTT3JkdExZbE4vR1Uvamc0VmxWeUd1?=
 =?utf-8?B?eWdqWWIrRlpMejZhekdVUGFYQklPUjBVN1pSSjVkMGRhMGwzdjBEdzhCbHY3?=
 =?utf-8?B?NVB5Zll6Mk4zVDFBakNrZ1IvZFduMnk0WjVZekZYcTNEdUxmck9Md2FrVHhD?=
 =?utf-8?B?U2Jyck1jWTJZT29ZVFZOY2UyU043TUl2emJ0dzduWmlEK0JWWFI0Sis0enVI?=
 =?utf-8?B?QzFFOTNZS05waGJJTURUNW5xbG9PQ2RYZ1ZDOS9YOWRSbWs1WnZEaFM0MEpD?=
 =?utf-8?B?ZzRPaVJVMGpGV21pand0YStJdWFMQk5RbjVvUFRiV2YrZ0FqTEExQzFMYWJp?=
 =?utf-8?B?eFBEYTREdnBRS0FRN2Z3RWlScHdCMk5MeEVmbit1ZWUwWFpzZkFYR2dvb3pJ?=
 =?utf-8?B?TlovVVVJZncrdldHODdKclJnZnlhUGdnMDhWb3NwNmlBTlNrK09vQVdVRC9S?=
 =?utf-8?B?bm5zam96RjhxWDJoS2xkZ1RZaWJyR0pmYnhWWWE3Wmt0SDlZTHBLdGVzRU93?=
 =?utf-8?B?U1Jod2EyK2N5S3ZtR2ZjTGJxVmJPSktBNkwwL2FIaktOYllOSmFCNjNCc0FG?=
 =?utf-8?B?dVJyY0pnVGhnR2hOdjd5bWVJa0ZSK0txc3NCQUJvZmhyMk5tTHgrVEJsYXY2?=
 =?utf-8?B?Y2xabWtLd0FmMklCMDhhQkV2T0VkK3QybVdXVzBLRzBhK1RaczRWM21EL2RI?=
 =?utf-8?B?SG5TNTMvSG8zQ0hVUktpRDdBYzhkR2d2dWNVaVl3cjFCOHAvamJIYVUvRDln?=
 =?utf-8?B?TGRwNS9zREpLYU02U1VmY1E3ak01SmpJVmNOYXZXUWtNOU1LTFdwaURjZ3Ro?=
 =?utf-8?B?cmR3M0pwdVRrYjVNTEYxOUNNTFo2THl4WVFhR1lMRXkyL3lJY2VZU0sra0N1?=
 =?utf-8?B?VndjQ2tYVGlzSnB4YXN1TDhIU0ZiNFVvVThpZzg5cmdtT0NwSll6TXZhNjFQ?=
 =?utf-8?B?RTFqdjdIMkFTZG9BSElsamZ4M0F0bjV1VnlqZzJSSDlORU9xNGpUMlo1aUxZ?=
 =?utf-8?B?LzUyczhUOTg1cWlFMThsOUhmdFZVR2VIUnNoR0NZRGpGaVJmVmVMc0dOQmNj?=
 =?utf-8?B?R0pUckhsdFNrV0VSQWd6T1BOWHRxMm5abUg3cjN3dVVBWEVCV2ppaVROUUFa?=
 =?utf-8?B?MldubFFZOHdydDZTb3gxaTZVWFdzZG1HdE1yOVpabDkwTkJWUEFXNmtWcWlU?=
 =?utf-8?B?cXN1OG1IalBxeUlTSXc3eVRQV0VRRVR2QVU4NDRLL3hZbDQwYXpta1hkcWc0?=
 =?utf-8?B?alQrMzY1RTdzeGhDWE95alU5MlFrNDNGYWpjR3hLM2JqYjAzL2tOcGp6OThM?=
 =?utf-8?B?cC81aC83cnFnZkdqdGNycFdkc29nSEVuVlJWbi90RnlORzllZGtMLzhsSDZU?=
 =?utf-8?B?MDRBZUE4NmFUeUsvd1oxMmVrandQS3R0UlJRVmwyTjdPQ0NHL0RMYjBjc3lx?=
 =?utf-8?B?UTgrbk5oZlMvc1R5QjJVb0c5c3JXRmw2YXhlU3pva2NNOWRVSnlzT0gzNms0?=
 =?utf-8?B?RmVYRUhidVNGcEtIclJVYjd6cHU3Qk5lMDlXVzdpdkZkQU1DOUd0L1c1ZnRt?=
 =?utf-8?B?OVhKRU5DRlhIa0syUWlqblJJc25QYmVweUdmNDNXYkxrbzAzTERYZXFlc1FW?=
 =?utf-8?B?My8xUDFsRml4Mnh0SDVjQkM3czJPczFXbjRIMGpJZUtRSTVjNVhiS3gySU51?=
 =?utf-8?B?S2FSWHBqS0p3R3FKZEwvdWRsN0UxcUVKbWlIWm9GNzJESllpa3AwZ0FEK1l3?=
 =?utf-8?B?ZnMzUzRUL0d2c1pGOUpnN3V5SWNSZTVoa3ZqTm85anhaWWxtMVp3OUdrZVdw?=
 =?utf-8?B?WWk2WGlvTGNGMDk0bUpPY3YwY0k0SklMVXpLSVQydk9mb1c3eGlYbnpPTm9P?=
 =?utf-8?B?SjdkNnBMaHEweVdYcHlqOFBOUC9SdkU5dmtUZi9WUjBGZGNFb0psVksrTVUw?=
 =?utf-8?B?bkhlL0tETE9NalFvOGFITkg0WUFmS2s4TUs0aW1DbUFZbklWUnpwRmxWbXNE?=
 =?utf-8?B?ejRORktETUR5Zkg3OVNEaGFweDRiaDVvbnBnR1pSdVJsTDQzUzQ2UXhXWG1E?=
 =?utf-8?Q?TTkOnSGBdYtCAucxqtuU+eITv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c95189d-93ee-46c3-2885-08dd5ca0d064
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:19:51.9992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEJkCHlzXIodQqGBkXb+tTZcu4d8UwHHUmQMVOmbCInaXVoN/D5EO9rWRWJ9DhTpUgfbxAFINmIAshJBadsvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/6/2025 2:17 AM, Alex Deucher wrote:
> When the parameter is set, disable user submissions
> to kernel queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 3aa4fec4d9e4a..bcc72737f8084 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1304,6 +1304,9 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
> +	if (amdgpu_disable_kq == 1)
> +		adev->sdma.no_user_submission = true;
> +
>   	r = amdgpu_sdma_init_microcode(adev, 0, true);
>   	if (r)
>   		return r;
> @@ -1338,6 +1341,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		ring->ring_obj = NULL;
>   		ring->use_doorbell = true;
>   		ring->me = i;
> +		ring->no_user_submission = adev->sdma.no_user_submission;
>   
>   		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
>   				ring->use_doorbell?"true":"false");
