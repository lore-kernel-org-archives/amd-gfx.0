Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69919C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 11:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E321810E668;
	Tue,  6 May 2025 11:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J2NyuCXu";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91E310E24E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 11:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jza8Tr/sb9blJEWpSD3dHV4+sQDacER7NFF9EpV4L9hcR2ywcFDhQKhQOIuL3a7D8/eKjq+K3Kc273Pk2x21wQHyfRbyV9tu8Gw0dsbx5Ybf5b5FMjgVNQbwNjjfelI6zqz56okYs/jWBlkB1k4s24nYphsWJe7zUiFG3uyhz8btgwP93dX4r+kbyZI2ImcM+0Bw9st5HR//7LSc05SU/HEIUeh6KftGubsh8AGHGZCGIJqN/ldmC0y/eRBeBH6kivO7/v24U5sNITlQLznWeAXVb98e3XI4neTZn89tCcWlaiTw+svFsRzC6R6CRJMFtgA+p7OR08/oWUURytEGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e48K/qTndMs9FYKSHMjAsIoDO8OXAiuAQWaS34a4+F0=;
 b=CRMm/7lvVWGeQDmAZzOYUXI/09Dt7vjETfqEwzWkNkKZkN5V8OswNcJkFoN7/zFHFyCZwZej/5ep9d6ROiCruzyPuxJsGiG6TBCvvSREmItDAnMQc4wilgAwoCkglp/TUwNsAk0nURX6h1ADrIZcjLtjJD4LkoRBfrQTWch2JO5wvDaKpkT4OHQyTkZgPqVDk/NK8nIxRwyNn5WBVAdTLaa3HUTxVMIc0LBJa+uIeuvCw+iR3lXA/+/qTJTETdIRBdkCZz7zFhuay1/KSMSQp7BKtUyLVvQ2N1D2v4uUuKQNLRLh31P9M+DeUWExWSCmp2iJyTndobhRoHnQT4NJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e48K/qTndMs9FYKSHMjAsIoDO8OXAiuAQWaS34a4+F0=;
 b=J2NyuCXuuYN1maCpypFIl41b+kN1qwRrnA+5rdNKZVKeVkOlMD5qNjoy+zGfb6lkqt4myyIwEECyMRzV7tk0BqhbC98tRfLMh1BFNLS7PMdzCbA9GFarJrgeNzATI4k4ZLWkw2aRaxhoSRluZ+N9YunzEMDQpa+GaSPriHIwv1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Tue, 6 May 2025 11:55:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 11:55:45 +0000
Message-ID: <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
Date: Tue, 6 May 2025 17:25:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250506093629.249792-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d36ff8-11fc-4c0b-df79-08dd8c94eecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmpoVDVwWEtGWUFUckxIYmg2NVNDNFVuRlpPRHliRm1JNGRtTDBlWXdvRWg0?=
 =?utf-8?B?anZxWWhGV1ZKLzNlSC81ZktFTjJMQkZ6clpqcGpwYXpDNjQ5VTNxUjV0TW9i?=
 =?utf-8?B?bXllZ3NsR0xuOUtHZS9RT0tjMmZ1SXo5YURKSGszZkVsam9vWU9HVGlGMUl4?=
 =?utf-8?B?UzBHL2t5WU9WQy9abTZEUlFoZHZuNGpDVXpFVzNZMVNhV1BjQXhNZXVUbWtE?=
 =?utf-8?B?U3MxTzZSOXRiSHBIakp1U1N3aWwrTVRva1JnM05STjRtVjNueDk2a0N5T3o5?=
 =?utf-8?B?eHhhVTQ0em41cXpWR2ptNVBjQ2xJWlcwL2grYldhekxXQjRrcUZMYUdGRncx?=
 =?utf-8?B?OVhEY0pVVnFWeGhpZktZK3U4bWwveUFrUHFOVzBUL2x4L3IzRFBZcmFFNTZH?=
 =?utf-8?B?SkZVWDVHYU5abnMwTTBPQXRxYmdsSHhBVXRkL2YzSi9sOTlrTEw4MVBYTmsr?=
 =?utf-8?B?SHJsSWUyKzgvWjk0WUlxREtmZ1pBMjI4RTJTK0hMbytSUnk3MC9wMXorZytD?=
 =?utf-8?B?bGJvQUFLVHAxRUdKQ0Z5NGtvOVd3b3ljSWNwaE5VclNtdlVIV0t1WldsOTM2?=
 =?utf-8?B?WXhYQ3grbW1HZVFWcXRLWDhpU0JiRjVQaCtmdmVrWkdnOVhYbWZUNzd0STVZ?=
 =?utf-8?B?RitmUUlTUzJVTlJwOFA4WURKaFV6empFdGU1NlJTbFV5R3Y5NFFZVWRmNDVL?=
 =?utf-8?B?dEUwb1RrWk5CajhuRzJpQUl0dC91ZXRJZWtLeVE0aUdCU3NQOWIraFlZeUFF?=
 =?utf-8?B?d3NMTXFNc1hLN2NyOFNHTXI1RzNNdmZFT2Z1OGFPRVhjTjZFQjJaS05BNUFQ?=
 =?utf-8?B?R09mc1FWeUxXY0pUQTVEMUltUDF0d2NHU1pKSFd1QkxMa0dYNk1wSkhnM3BC?=
 =?utf-8?B?NVhlc3NZZFhseVlUcHc0R1FaNUN6N0NoUTZjQ2RVbzdJZW5YalZ1cW5qYlFz?=
 =?utf-8?B?bllxVFllSlJYeFpuSVNiVTFIZ25xeHNiUDFrMkllYjIzWHZRRUVkL2hrTjVr?=
 =?utf-8?B?L3hiK0ZWN3hHWGQ4Z0I0Y0dnRTFhdlNlY3QxNVRuWko4b2cvK3ZTakUyRW4z?=
 =?utf-8?B?QmZPVHZ3aklTSmVYeXN5cWZ0ZVowVXhUK0tDK09Db3hOWk1oeHBTOHFaelVZ?=
 =?utf-8?B?YVErMCs1TkhML0w5ZERZMDBpeTYwNjRjbW9HK0k3VUE5N1FPK1M0ckhyQWVD?=
 =?utf-8?B?TlJYTkRoZC8rcGIxTDlkb1B4eUkwSGdiTjVydkF1c1ExRDRQUWxvMjdoZHd1?=
 =?utf-8?B?ZnRSV0x6UTU1U2MrRzhNNEtQZkVjakVqL1RkZzVVNG5aekoyMlpEUU5lMmVD?=
 =?utf-8?B?eE9DaUc3M2lXeXRDSy85WFBJeGFxdi83bnNtS0tnd1daMkpqcFBSMDZRWkxo?=
 =?utf-8?B?d0wrV3J2bHYzaDMrY1Y3MlQ2cDJCelNCNTJjT2UyaDBPN1JWRnBGSVNOTnNK?=
 =?utf-8?B?VzdKQ0FTY2xFazlrNXVoSGZGZjBLbW5ybEJPOXdDVnVYSkYvM3B6a1FJWWk4?=
 =?utf-8?B?V1ZxTEFuWDFCNm5TZkg2aXVYNXl1S0pSWkZmemI1ZUZQek5oL3FRRFR3d1JP?=
 =?utf-8?B?WnNhSXZaNXZtU2FFc2RKMGo4OTIwcXpuN25VYmxaQytHYmN2aXhIbXJ4cG9k?=
 =?utf-8?B?RVFHYm5nWmdCM2xIdlpUdDlBcUpBSTJybXpDRDNZUUt4T0VJdHQ3N1NTdGh0?=
 =?utf-8?B?TGlOeVN6T25FNGg0UEI0dDc1SDNVUFN3a2lmSzZ3OWpXMU5hNkkxUENuZkZQ?=
 =?utf-8?B?bm1UcDV1ckZrMzBBbGQ2eGFHU2lzVXdkODNmQVpJTVJIb1g0cnJJbEhYN2s2?=
 =?utf-8?B?QkpTRmtpblZyWGIrSG9yM0FoV2RtNmh0VWZ4TXpMNHNyWiszN0xhQmRNck45?=
 =?utf-8?B?aVMyWWRFdEo1VkRuZnZvbkZsMjYxRlVBQkpHend6V3N0YUkrMzFrZmhLcDNt?=
 =?utf-8?Q?22PBdvouyUQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODN2dXpZNTdIdkI4TVM3VTRQVHdhYTk5aGo2STM3VjVKR0RCWXQzbURFaldF?=
 =?utf-8?B?VU9RNnJXaWxBVzVWU0I5blpjSHN5THcxWVI4d05VRVRsNVRJVVVweDBNUEhi?=
 =?utf-8?B?NXdlQWFFZzdhcWs2QW9tdGtOYjE3L1Y2SGxnK3BsY1ZmN2RaRUt2d2QrVnE4?=
 =?utf-8?B?WkFZOU9ydEFXWm9ZdXJjdnpVakhjb3lxY09qcjFpMFBWR0FzRTlHaFhpU2FH?=
 =?utf-8?B?RHBwS3ZMNzhIRHpWd0JqbFM2SHRlck9zSElHcDgwTHhJWmk4WlBmUUpHd2kv?=
 =?utf-8?B?Uk5VTXJzY0x3VUs0dzAxYTVFV0RWZWYwRHJpZ1BYMVAzUUZEVmU2dEhlRHlu?=
 =?utf-8?B?T2RRODJoTE4rWE1uNUlvbE83emI0U2dVOWZrdE5pYXRGOE5FNS9oL0xZNlBY?=
 =?utf-8?B?N09xMGpydkRsS0lNbFJjM09TTngvQW5zako2MTl5TGJuWVJYVU9hRThhWmNB?=
 =?utf-8?B?VlJzbEcvVSszd3RNbUNUTXo1UXYwOTVrdmJOUEd1djlXOWE0d1BhYzNWeUFZ?=
 =?utf-8?B?STF1eDNKY2hjVmdqQ04wNTlTVGNydFR6WTkrSTlCWWdrSDFaTkNJMFZOaENF?=
 =?utf-8?B?OVVQdDRmUGNPZXpuMXIvNU5kYnJ0cHNma1JzNjc1dkU1Y05GdWFxcmQydDZm?=
 =?utf-8?B?WXRUSUdsbm5nMHZmSzU2Rk91SjdBMUhVaW5xTmcwam0xNjcwM2RZVFJOQ0dS?=
 =?utf-8?B?dk9hWGRGdWJvWWhkSE5US0JPa3lWa2dXU1J0NG84dW1WeEtpMncyRnQzVjhW?=
 =?utf-8?B?NkNFUDRTT00yaVBDWFJKRVFVZG1iT3E1VjJoVGNEcUhQaFk1QXFzV0QrZmht?=
 =?utf-8?B?YnFNYXd2QmZQZ2R0ZmhpV05iNWlQSGxJQzRMZUpST1Z0THBjZkxNN1BqSEVo?=
 =?utf-8?B?YjFEUlVHamVRVU55YlhPSjVQZVY2dTRQOWFGWmFPZ2ZheXN3dkV5YmthekZV?=
 =?utf-8?B?VlplQy9qMDdCMnZ0U0ViWjhQM2d3VldiOXpsN0FIb0FBM2pnZVRJOVFBM1BZ?=
 =?utf-8?B?d3RBQlk5M1lqZFBXYVpHU0FScVU1djFydFhrbU5MSUlMTWs4NEp2SHQvWllS?=
 =?utf-8?B?TFR4Q2RhbHhVVTZPVDlLZHVZRG5ERERmWitUZEU2SCtQKzRab01veTRNZkYz?=
 =?utf-8?B?ODB2TUNNcS9sRWtiYWEzYWNBVzVEVHBTaGE3Y0lGQzNvcjlPazRhMlB3T3Fu?=
 =?utf-8?B?VEd1TXNwdjFtbFB0eUtnSTNOZ2p5NGlZN2x1UWc5eUtaU1dNY3NKL05vand3?=
 =?utf-8?B?WXd5ZHF3M3hKM2tsSWRtWFlvVktoYndZS3NRUHk3eXJPWmc1UjJYalVFdUdp?=
 =?utf-8?B?dHpFcENuWmFqWlJwRmI5WlZrZnRWRFg2ak5YZ1dUUkFLZE1MWnVpS3VINThx?=
 =?utf-8?B?V25VOVZtNkU0aUZETTU3Ry9uWTZKQUMyVmwzYnViUHFiWFB0Zi9ybVIvUEZR?=
 =?utf-8?B?QXFCelRvUFc1QWFsQllwQ3BCV1pSRm9keFliNzEyN0N4U0ZFVk0vU0lvM2N2?=
 =?utf-8?B?TEdjckVmU1g0TkNObDFMZm11bkhDeXZ2dUJCb2dwZWNBODNqWUkrRTNTS2hC?=
 =?utf-8?B?bUdQclpUbDRnWTBRVCt0T1hOZm1weUo0WjdJNFp3MHM1eWVDSmN3VE5YVEp2?=
 =?utf-8?B?dTZvTUF1RmR4eTBGZWJ2aStsNXQ5V1JNVzNmWHVMemg1OU5uUSs2M0xiejJQ?=
 =?utf-8?B?bXpxMENBSGdCTHJxM3JLQ01BZFh1cXhwRmIyQ3JSQlFvdTFRdU0yYzJBSHgx?=
 =?utf-8?B?SG5qYkFidXNjL2pWb0JoV2ZvQWZtMm1sQ3Z5eWF3MjhJWUhQamlFSWdJekk1?=
 =?utf-8?B?UlVJb0c4OEY3cHNQZnBEdDA1ZEZkUUMrK1RnYnJ6OVlOWjJkWEc3Q2JvT2la?=
 =?utf-8?B?WUZRTGVjblAyYyt6YmIzUGRNT01BeisybWlGZVdRa1JENG5tZ1dvZGpTc05q?=
 =?utf-8?B?WUliNWFhb0xJTzlnMVZ5blhIM3JFbEdSR3M4YlZCRjh4bHMxVjl4ZVFRdmxt?=
 =?utf-8?B?SHZDQ2pnN0RIaldQTkdTWGpHbmNiUVBha25xQmszcmt3YjhYenJRNXZTdjZK?=
 =?utf-8?B?S2NCdnFTU1E2WFlkUWZIOUFsdmRLbks3bzlLWnkzLzFnMStOOWlwR0hhRGpU?=
 =?utf-8?Q?aEI27rQ18fLUDxdMBgHkEy6TL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d36ff8-11fc-4c0b-df79-08dd8c94eecc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:55:45.0987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyGr3dh1yg7nK7OJKMPdLMYWHZ+DDDx8bno28hgHO/bdaa4+ZV0CslGGm/9nbO+I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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



On 5/6/2025 3:06 PM, Samuel Zhang wrote:
> For virtual machine with vGPUs in SRIOV single device mode and XGMI
> is enabled, XGMI physical node ids may change when waking up from
> hiberation with different vGPU devices. So update XGMI physical node
> ids on resume.
> 

Please keep in mind that this is not the only scenario addressed by the
driver - for ex: a resume sequence is executed after a device reset.
This patch itself introduces unwanted sequences for other commonly used
usecases. Please rework on the series without breaking existing usecases.

Thanks,
Lijo

> Update GPU memory controller configuration on resume if XGMI physical
> node ids are changed.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d477a901af84..e795af5067e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
> +{
> +	int r;
> +	unsigned int prev_physical_node_id;
> +
> +	/* Get xgmi info again for sriov to detect device changes */
> +	if (amdgpu_sriov_vf(adev) &&
> +	    !(adev->flags & AMD_IS_APU) &&
> +	    adev->gmc.xgmi.supported &&
> +	    !adev->gmc.xgmi.connected_to_cpu) {
> +		prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +		r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +		if (r)
> +			return r;
> +
> +		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +			prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
> +	}
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  		if (r)
>  			return r;
> +		r = amdgpu_device_update_xgmi_info(adev);
> +		if (r)
> +			return r;
>  	}
>  
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..a2abddf3c110 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>  	if (!mem_ranges || !exp_ranges)
>  		return -EINVAL;
>  
> -	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
> -		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> +	refresh = true;
>  	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>  					    &range_cnt, refresh);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..1eb451a3743b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> +	r = gmc_v9_0_mc_init(adev);
> +	if (r)
> +		return r;
> +
>  	/* If a reset is done for NPS mode switch, read the memory range
>  	 * information again.
>  	 */

