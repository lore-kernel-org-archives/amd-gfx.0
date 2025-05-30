Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4BEC3ABB2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 06:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF0410E00A;
	Fri, 30 May 2025 06:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jX8cjhP/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2878410E00A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 06:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXBGzo3BQqtVBtUGDIVk+8gk1obP8gNKQyrJnaPCX+AWk0/YZ8VZ1ZFzGG9SLC15xqOJW6jjqrNhAhOi5IgjG3fCgSvZWsLNQKDUBnCmtawrbBQv6FaqoU9dcvYyE71g7QQQwCa1gak0jnZ/ea08clTiE2PBAI1pjQcZaR2xPu+YkEL6G3fbEsm05u8omKdKuGdCayYL+h15dxvG0Zgz3FrRE+olzpM9QrgN9YEBmuPPzsAWJ2IoI9it7clB+OotyC7E3/ni00eWyZeqP+56enZYf/HrKZdS1QS/T8tOXfRWDxNO8DlU93Dk935nHx1X6BcIydvVCVzvp6Vhdptzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRJWws7pE+vE4Av8C1OZdeJeA5AZ9BECV0XL77ppbow=;
 b=hjxYeA4GhWOAU3BR1mQzuaNn3wyGFsrZ+HBm0H/H0OWRbzle4JxOA6p8DRKGKiQguH8nT2NDFIaz1eW2Pw0/iWWuZddjLv3hyUa6eDnapmr59kil87AA6UPtwj7WOoUIji+oAyRsamXyU8ZUjCR6OhfCnXidiS0mNykHTHD1D/h6GGruqP1+ZxWdShd6OUceUhyTwyCmPf6n30JuEMqaY+RMZoKP3jLvqiRGlmwDwOJp4IDAPQDLvRq4PpOC6nGgWQGNjRb944h/G74Q9Yek6c3Zvg6yBC+1Mxy0ESlddikKF5r/o3JVrFWznT4BoF37T2o4TxkqY8L53sW40U7SAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRJWws7pE+vE4Av8C1OZdeJeA5AZ9BECV0XL77ppbow=;
 b=jX8cjhP/O9hb+RzzW2LPYdXc8g6bFCCHm66S+QLFehbAhFSRfmkiLLw1QDq+ZdJaQcUsMva5uWkjkQ+5omLafPEwmF8z/x73SBioVlWGQrxiqX/kcUZbnJMjr5STB6Ap1JD/Q7BFavyMd0js+RAtHxZlL/Ha6Kh00aivJjZ1NaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Fri, 30 May 2025 06:48:49 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 06:48:48 +0000
Message-ID: <4b72c728-b028-4cab-8a3e-d6de8041feb9@amd.com>
Date: Fri, 30 May 2025 12:18:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] drm/amdgpu: fix fence fallback timer expired error
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com
References: <20250529100256.754769-1-guoqing.zhang@amd.com>
 <20250529100256.754769-5-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250529100256.754769-5-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7775bf14-a534-493f-1a3a-08dd9f46077d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3VzTmpPZWJGQTRGUnIyVHlaUnowQU1xdEgzOU5CRXp5bWNxTGpZbGZGSUlz?=
 =?utf-8?B?T3pqcWdhVVFCZFE3Z1d2Y1h4cVFzNExreHErSUVNVVZsZWFaRmxjR2d3ZTgr?=
 =?utf-8?B?S3I3dG1vUWg3NVRhSWZXWXFZY1BBUVVSWjB4SGJsMXBzQnZiYUpWbWxiUzVi?=
 =?utf-8?B?RHZXZnNHMnBFblNXTGwrMHFVNXdQYUg1QmFKRjVERStsM2VqUmV0WVdKNmNx?=
 =?utf-8?B?c3h0TktxazhVd2hDUjJnZzhpaXBQMmFvbUg2dHZyL25FdThBeC9Td0hYVS8z?=
 =?utf-8?B?QmZPZDU4b2Z6U09RREhRS3ExNzZLSm9ndi95eDgzWExaelg4VXF5aDFyZXNU?=
 =?utf-8?B?a3ZrbnlQbzJJOTdwR3QxRWVrY1pkNDdkV3cyN0s0b3QxSVRnS2N1QjdsekFy?=
 =?utf-8?B?RTN3S2RnYmVnSkFOYnJOdkd6c01MdWR5WU53YnpGRTMrSVBqOXRua3RWQ2RB?=
 =?utf-8?B?YnVUV3dwUUx2Um10US92MzVFZjVHdEZUdUhaeVNXa25jUFJtV21CbkZVQWIy?=
 =?utf-8?B?QThPTllJZFh1UUcyaHdYVkdnbG8yazJhUldvNHg5WXlaekV6NjFVbW5uME5E?=
 =?utf-8?B?M2VEYlRmZEdFakxvekNLTjZEUmFHaGEzN2dISDdHT083M3pPUU1BRzFKZkEz?=
 =?utf-8?B?TUx1ODZiUjRxMVNUTDBJT0xja3B3Nm96SEJ4cThNN3IrN3ZxMjVqY0dYdGZH?=
 =?utf-8?B?NjBxNlYyUytlazNGbnE4Tng3dEhBbFJFcGdNTXVXRzREMHNKYnZIRi85ZVVN?=
 =?utf-8?B?YTN5Nlc0MmV5YW5vMHlhTS8vWndUdXZ1V3JFWFdicmhtcWM1N3NveC93U3A1?=
 =?utf-8?B?WnhLVXJSVHgyc3N6Z0N0NmxFKzdobVBwR3VZcXpTanFGeU5lNHRpWXJPbzBh?=
 =?utf-8?B?ckc0a3hTYzBWVzZ1YXNqTmdmcE1pQmRsdUkxbDN1UkhITVVRM1JsU1ZMZ2JN?=
 =?utf-8?B?Y2pnTktGelE1UFg3aW1BT3ZvaThyRERwMFZvbGVVR2Z0N0ZzSldscUV4MG9y?=
 =?utf-8?B?MFkwYW1xc0NlaUpORTQwbTMwTGhLVTFaVC9kS2sxRVFsU3BPUkZob3kxdTNp?=
 =?utf-8?B?UGc5M3Y0Uk9tbGtKOStWb1JDN3Y0ZDA2NVVEUktUcWRpZ0NRODNvWHhtVzVr?=
 =?utf-8?B?eUplODFSdTY0S1hWZDZOOUNTblpTVDZyL0hRTVBQcG9hKzQyd0Y4MFFkdUMz?=
 =?utf-8?B?SHJJaXpKU2w1Uk5uelR6Ym1ERzk2aTVOM1hBTzNJUzhtMVpFSnBkbVY4enZ2?=
 =?utf-8?B?YVM1d1poQmRzNGF5SXJQTWhwU0FOVmtjU1dxU21wUVEvT0M2VnR3LytkR3Ra?=
 =?utf-8?B?VW1LMmFNd2xVUHFiamM1bHplK2l6TVhpazZWdjdEY1ZSUm9pekFLODNmeHZw?=
 =?utf-8?B?aDdPTUI2bGJqRTdOcHlSalJmSHhwSDhoQlh5WE01ME8zcnFaRU5FbTdDbFVo?=
 =?utf-8?B?TnhZU2FEMWZsZTl2QytROUplaXd0NDFSRk5DeHFBNktvYW9PQ1JQdGRoN0FM?=
 =?utf-8?B?WXFsM25NcXl4OHRUSzVlWk5KdVBna2VBMTJoZTROeGxFdDJpdVR1L0gvR2xw?=
 =?utf-8?B?cU1XWkJSUkZJMmtoa1NSZEE0WkI1QTJaU1NoODFyV2NhcFhIeXlUY1Z1eW9N?=
 =?utf-8?B?UlJHQWxDMTBHaU9oODFpZFJPNDBBcnlxdkVZUSsyeFRLWlZtNkF3NG03bFBF?=
 =?utf-8?B?azVVSVlOY3YrR2dPVmpBYVFXVE5NTm9OUmVZeHRRd1luMnJIUVV3cnNyZ285?=
 =?utf-8?B?RXhVNWphNVc1VmJNUWI2Q0lkalowM2xCZE5vT1RpcG5ENzBOOVN1N2hrRWc1?=
 =?utf-8?B?bzZzNlNXSE1OK2tnMkw2bTZJd1VwcHVHS0V4UEt6aGtMeUprVlRYcUs2ckFu?=
 =?utf-8?B?bmhDRWJxSGZvSG4vQmRNdWtIMVNiYmVSVUhobzQ1RkIwbzVhNEZLUDY5SHFs?=
 =?utf-8?Q?ln1hmmD2v2w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRlZXZzUEZVanhERTYzeWI3Y1RLMkp6aVhid1FyckpBb0hnMHlvMXo5VFZs?=
 =?utf-8?B?dXZtZEw5REFaUUM0c3V6Sjl0L2x2clVoa1hPa2lGek1NbFdqd2l2ZXFOeWUz?=
 =?utf-8?B?YzFSNmxOYnVPWE5yalJzbUViU1IwcWZsb255amxEUmQzcE04M2gzYi9xeEdG?=
 =?utf-8?B?bUN0M3JLNVpwRGQyVDYxY3l2RGFPUCtHd2ZzWlB6dFRETHhBa3FxbnVHckRl?=
 =?utf-8?B?SUlUQkVNK2RLMjRuQ1hXL3Z2cFg1Qm5ZQVJqM0xxTTNUWmpxVTViWDZqd0ty?=
 =?utf-8?B?cE9pMFdDYjZSbkg2NDEyeVJ0VVBvRDlFUy9EMTBBanVqSmdWMEtOa080c0Vj?=
 =?utf-8?B?YUhPUmo0eWtwcU1rMWlIRHpNVkJsb3lzM3lqOTlacUJWcnB3VDBQMVJUaXA5?=
 =?utf-8?B?UTh1N2xTMUdKY01UbWRzT1Q0K2YzZDB3NkxaM3hpR213TklMcUhZelFJM3J0?=
 =?utf-8?B?RnpjM1lKbEIwZTdoZDlVdDNqRU04bHFxSmhBdmx5NmdoRUZWMGM1WEJvR3Fk?=
 =?utf-8?B?VmVqZ2REODljUmhsZHlYbi9hRGRicjNLQlN6T3k3enozU3pGL3VQSHowUTRF?=
 =?utf-8?B?c2NjSVU3dmEwdi9ueDdjZFhSbkliZk5MWXhCNlJMVHVSK2VNbGUyVFV5aE9v?=
 =?utf-8?B?ODZkb0tOOERwM0lrVFZwbHltVTN1UlR4cVVCYmxESTFzSEdrL0I5Wjg2aGJn?=
 =?utf-8?B?azF2aVNua1QwM2tlQjRhVHlXUERoRHV3dWZVVTUvK2E4M2V3YzB2enRGT3Zq?=
 =?utf-8?B?TERkaGI5RDUvZUV4ZCtNM3NsYXR2Z0tjTStiSWNRSytnc0Vma1V2Q0h1ZmRC?=
 =?utf-8?B?NHRXc0psd0o5cEJxMnZweWFtWkFQMHI0TXNMWndseDJiSld4VTB1d0I1KzFs?=
 =?utf-8?B?U0x2bWlCUjYrSURHSC9YS25iOG1zZ0FLYklvMDhTSnQ1V3BZTmxFQXVpRDlq?=
 =?utf-8?B?d2lOcy9CZ2Q2eXdFL1ZlL0xhVHNWSHdHSHFncDhMN2VJeW83dVIyRUtSeTlJ?=
 =?utf-8?B?K1dUMEZZbVB0MDVPcm9IOTBBS1ZKSHFoRzdOZVFhUGRweXd6YmVkVmxDY3M4?=
 =?utf-8?B?OHlvcEtUclNTSllneHZCZWE3aHJxVStZWThZdEJxa0g5Q0hSV3JlU1BtMWZP?=
 =?utf-8?B?QXhrQW5BdmdZMGhlS09qUUdaWVc4Unc1NDNOM29mMFlKbnh5Z0ZoRFg5dk42?=
 =?utf-8?B?OEFRQStsWCtQdE0yUS8yWG95dWNUcnpnMGNydjJBUzRrM1VHYlpJMCsxWFha?=
 =?utf-8?B?S2JxWmdBN3lvR0NETjBuZ2xucmU3YlhIV09ldmNRYmNDOCtDTmpteVdYenIw?=
 =?utf-8?B?SmRhUVhvcUtIYWRERWUwYkt3OEtEbFJGemZ1QU5Cb21WeSs4U0xQT3NFQ3FC?=
 =?utf-8?B?Q3RRckJqN09RTWFDTi9LdzFBMnJyUkdrK1hQVkgxa084emI3WTRrQXRDZ0l6?=
 =?utf-8?B?Y1c1STltVW04QW5QNWw1aUVEMnFpSjE3bjJHM1NHN21POFR6RHdIVTAvT1hr?=
 =?utf-8?B?RVhqOVBBUWdPaVpHL0dXbk4yNWQ1TGdMREtCSjl0ZVZ2ZWJqRHRMTFhFa3pE?=
 =?utf-8?B?Y3FIeUpscWpUd1l4QkFNK215V3pBVWhyQmsxL1ZwWk9VOXF1KzJhZmVxbDhH?=
 =?utf-8?B?SG9tQlJsUHBsL2pVbDk2ZjlScVlGa0ZOS2Z1cmNiY1Radmw2MGN3SzFsS3FG?=
 =?utf-8?B?c3YwL0Y0RDZVaVg3ZVlKWUpoTTZINi9Kd213MXRXcVgwS2RKNHVjM09NUnRL?=
 =?utf-8?B?b0lxSmJ3WGIzUHBvSFF5YUE0cXQ5TVF0Y1l6cndMT01LVGZUZGw0aUlFVitl?=
 =?utf-8?B?TVcwOWQxeVBBYTNvdWMrR3ZsOHgrU0FDdzk3Q2tybkxTUjdFZFpRMVVlaGVm?=
 =?utf-8?B?NDBXY2FreTJHWFFzbE5RMUlKS2M2aVRHbm1kM3ZLNERWcUFsNWUzMCsxUFVZ?=
 =?utf-8?B?WnAwWlhTUE5MTDlwelZKK01TenhjdzF2ZmhDcFR2TEg0OGk0Zi9FblM3UkM0?=
 =?utf-8?B?Rk1zY3hlT2tpckQ3cXgxY2Nsc05iMmF0QURxZXhkaHBzdng5czliNVJXbGI2?=
 =?utf-8?B?MVVuL0hsd3pFcGhqTm1kSUpNcWJUNjU1VytvVHN1VisvNnIzc0FRcFR2UCtx?=
 =?utf-8?Q?QPSMqZqkMo7pIy2I7s+vy5mUd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7775bf14-a534-493f-1a3a-08dd9f46077d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 06:48:48.3189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n4TGiQ9Oqdj4kMWEIF6+MBa1DEHZ+U7pPvENiCuF/Wk3LG42i2+aRzdNGpyG43+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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



On 5/29/2025 3:32 PM, Samuel Zhang wrote:
> IH is not working after switching a new gpu index for the first time.
> 
> During VM resume, QEMU programming of VF MSIX table (register GFXMSIX_VECT0_ADDR_LO)
> may not work.The access could be blocked by nBIF protection as VF isn't in
> exclusive access mode. Exclusive access is enabled now, disable/enable MSIX
> so that QEMU reprograms MSIX table.
> 
> call amdgpu_restore_msix on resume to restore msix table.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0246a33b90af..f67bc9a52d53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5051,6 +5051,13 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>  	int r;
>  	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>  
> +	/* During VM resume, QEMU programming of VF MSIX table (register GFXMSIX_VECT0_ADDR_LO)
> +	 * may not work. The access could be blocked by nBIF protection as VF isn't in
> +	 * exclusive access mode. Exclusive access is enabled now, disable/enable MSIX
> +	 * so that QEMU reprograms MSIX table.
> +	 */
> +	amdgpu_restore_msix(adev);
> +
>  	r = adev->gfxhub.funcs->get_xgmi_info(adev);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0e890f2785b1..f080354efec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>  	return true;
>  }
>  
> -static void amdgpu_restore_msix(struct amdgpu_device *adev)
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
>  {
>  	u16 ctrl;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index aef5c216b191..f52bd7e6d988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
>  int amdgpu_irq_add_domain(struct amdgpu_device *adev);
>  void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
>  unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
> +void amdgpu_restore_msix(struct amdgpu_device *adev);
>  
>  #endif

