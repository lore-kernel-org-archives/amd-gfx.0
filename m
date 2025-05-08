Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45C1C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 09:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E5A10E375;
	Thu,  8 May 2025 09:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4y/gwCvZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43C510E375
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 09:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or7JYFPIdnw37LRjL3oausRDhHS7pamC1T+QATUUm+XIBDQt2rttwLdbrfjo+MF/KEMp4ungeds7gFSxfd/xkemPDZXLuIVOhqlgSPHhtizj4CLluEMrOKSKhM7qHhmljNWYCy6EIRQQdsuw8BMA/1d24pAWHC9L+fbyq+wz3eMatjSRP2MggWSsF1RxYsP5dCf6cz48ysdi7bqhL8Vz22viQWWwMrZN1lxi9PKR6AUsVTYySR/Bqfjvl98vnR4ClDtN5bp7fSZZn1FcO2Y+20PKUkiGeHBPrEp7eazgyZrFBJ0++yPhtFn0nJuWRfyDq0lAXd1ZmsTOr7JSvecoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx61HppHDKS/jx+lJgvQaVPB7TP2QcwPGN9hlDGTSAE=;
 b=vMkshg5rpoubopI5k8GkwN1DcBssxkMS2lV/FY3Nh35ePqgVHVct8/QDuQfN9KiXBYOZt2vtBmJansPiMacZ6guoqqdyG4S218gkqQ0WJcV2jZOOE5wy3/8fn7Eo7yIkm4xyKR7Q0naxrvxk50lF5WQlo77MiSpRhqhXmSMSvo9L8HVqUhMS/hmcLU+LtsCWxHYu7zgaOOGBHbzhMJYKA7pFfMITAuBYo5GZ8OexaQLXq83dJ0GZuKcw5YjzNqEaFEvJ7pdNTFfLgNWqIwTogaBWlgRiW6WnJKyyFkD9EHj2q+UZRZr1X7Zou2Cqnfwyh0EGed6ysaGqwEXT0tyBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx61HppHDKS/jx+lJgvQaVPB7TP2QcwPGN9hlDGTSAE=;
 b=4y/gwCvZbQCLzRQrEWji3ks6ao3+64+I5YxBnPBESgB8CWUThXMjCOD223hvhB1lbXiGeEJOisF6NGd/VBUf+i3XSXpIzfVca+Xu0vgjbw/yK9txQcmdpvuuMOGuKzGT6+GMQ9ObDrNXlL5azFETvwBRzjgVCUZc3yOIfkd/Oco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 09:27:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 09:27:39 +0000
Message-ID: <b0ada9c6-c31f-455e-a24f-4106b62647f1@amd.com>
Date: Thu, 8 May 2025 11:27:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
 <20250508050926.228674-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250508050926.228674-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:d4::42) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d07b4e8-7a3f-4905-0999-08dd8e129346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHNoVXZTb0VIRm16ejJxMjFMREpMMWVEaTF5b1FrVmlLUkpkdHpDL2tpWkdq?=
 =?utf-8?B?NG5icGQ3V3Ywb0FDRFM1Qmh4RldZZWRVKzAxYkxFbk13TEZweVRFRzYzY3ZF?=
 =?utf-8?B?blozRmhpVTlha1JmbUQvZk85OExXRXZTOGc2R1ZRR1NMNitrM3JaVHhSVUdF?=
 =?utf-8?B?cDlac244bnNiQTM5R1JtWFZ5RFVhUjJsWDVVRXRGR2Q1dnVaWk9VdVR4NVhh?=
 =?utf-8?B?bWdkQkEwdXBBQlFydGVYTStndU1qWWl2SkN1UHhTZXJMTGwvWDh1N3V2eSsw?=
 =?utf-8?B?c01ZNEJGSTc1WEN0RlhUU1FGUm5penRkM0grbjRONUNoZlowTnFjSzROTFZn?=
 =?utf-8?B?c3BTWm51a3FodlFGbW5HMkpsSVA4Y21iakptcko0RVhoZkZMUlRLWERWZjNn?=
 =?utf-8?B?NXljV1NWS3hMTkJJMDdPQUExNGxJWEh0Z0RQeFY4Qi8rbmgxeXBvK2VXVU5N?=
 =?utf-8?B?S3lGRU5MSk9Wc29HZXlYOWFSb1lQNy83SXF5MGw4VzBjaExkb3Z0eWptbS8y?=
 =?utf-8?B?dXl4VjZ4a283dVFoWW1EVnJyRFhNZDFzVGI4Nk5aMlo2TzFtNHJ3L256M2Q3?=
 =?utf-8?B?STd0U2d4cW8zQXJ6dlUvb3pob2tMcUx6aGVOd2N4cFZVWC9JMjNlN1VIeUR6?=
 =?utf-8?B?ajFVd1AzcDJwZExnb1pFS3F3RzgwODVES3Qvd1VNcm1pVlYrQ3hva0lEQ3lh?=
 =?utf-8?B?NVdIWFg2S3ZyenJrYlBUR0tYWCtUT2Y2MTU4d0RSN0dIc3JZbUFjR0cxMnEx?=
 =?utf-8?B?aXdXd0puT3hRVkZoOWJVMHk1TGlSM0I1aElNQ2d1SzI2YWRHQllNQk0xdDRO?=
 =?utf-8?B?VmxyOTJEZnlZaWI5WUg3a2dpbmhKZWZia3dMWWVzQnJaT0lDTUw3T1Mzemlu?=
 =?utf-8?B?OWc3dlVpV0NQUlRhRSs1emNyc3Y3ZlNoQkJMd3hZdk9jUWFBT0hMVG9UVUNi?=
 =?utf-8?B?aGY2dWxBTGdhbS9GSjVXOXRrV1p3ODc1UTh1ZGRaRGVkU1d5ZFZwQ0JKakp1?=
 =?utf-8?B?UUlFcjFsRmpISnBWTVpTT3p4eVhaVXBRMFdwbk5PRkllMUFlSEZzVkxPTE1B?=
 =?utf-8?B?Zk5HK2d0eWJ6Z01nZEhrZkJSWXZyeGlyZktrTEZZTUdtOWFhUUZrRVNROEJj?=
 =?utf-8?B?UmNBV01oc3ZqM2RaK1FKNDJDK2tlSGMwcXZQS2VudDhpc0srZyttT0pBWjMx?=
 =?utf-8?B?MFFaU1djNnlEODU4aWtQc0VYYVQ1T1JzQkNtcUJUREFnVmQwZGZkVFJ4Z2hi?=
 =?utf-8?B?N2JyNjdQVlZYaU1BK25Da0FKaFlnekxzY0YrZWxLUHM3MVpWc1M1U3dRVHlV?=
 =?utf-8?B?YnM5RVI0SUk0QjJWQ3lRSmEvbE5yOTcwSUY1bDhrMlFqT3I4NGdCM29yM1J1?=
 =?utf-8?B?Q0JrbGJISnpQMldqSWhpd2lpdzlkU2tzblhBUFN4dC85OE5FdFFNL0c2NFBv?=
 =?utf-8?B?RlNpWkNRTVhtT2gzc2xQWlE4ZUJGYlkxOGVHQlc3dmFLdGFzNVRYcE9QazUw?=
 =?utf-8?B?bEtyMWpZU2NheVlqV3Y3UHFzUndkNkFIbEhNVURHSVVIUG4yRjdpUW5KQlBV?=
 =?utf-8?B?a3VKL3FpbWc2WStVOFNoYzQ3WWdtUzlKS3NacU90OUpEdldBUjU5YkRuai9C?=
 =?utf-8?B?Uk0rNERLWTYwWVdNWlhDSmN1OEhVOTVISXg0STBMSGM4QlN0UjFONGp1S0d5?=
 =?utf-8?B?a1BlQ1MvVzF0aUxmeis0M1NmQ1J6eklPRzFQM0xhcGFFMDdUY1dTcUx4WFlw?=
 =?utf-8?B?dEc5VllHV1dGeThjdVpCd1hSZXVDeWxJcDA4OER4ZFZOaVN0dlowOEVoREJ2?=
 =?utf-8?B?MUJ1bmg3aWpxbUExOHFKOWhIMzVQN05jSnNWYVArdCtTWUJ2dXp6TTJXQVBB?=
 =?utf-8?B?YXBRbjdXOHNvdnNGcmtVTUtxYWRsWkFoMTVRK2piT0RPOG40VDVNU2dKdDlm?=
 =?utf-8?Q?FKMxePaYQgI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RSttdGpCNVd3TUR4ekR4bkNaZWJNS3Jya0NJbEJXNHZHQXZRNVpPNk5YSW84?=
 =?utf-8?B?TjZ5czk2TnhEdW9PR1pSb29pR3ZqMC9tTmc3QlVHNFBEM0h6SnhnUFNYVVdL?=
 =?utf-8?B?UHlFUUFmaG8xU01HZ2NDNUI1aWc3K3FDaVRPLzNMdWVBaHBVUUdnbStHRCs3?=
 =?utf-8?B?eXpJcEJBWXJkd0Z6M2EzaUllQlRTejArVC8vNjFhL0ZIQmRmeVZtTTgrbmoz?=
 =?utf-8?B?Um5lY2ZLYWNUcDhOOHRUQlNvemZrNGEvdHh5MUZrRW9iSUorQllFWGVveTQ1?=
 =?utf-8?B?V3EyRS8yclFpZ2RybWFXMVU2RWI1VWErVUtZMGJNbk02TGdabzJQK3hIWE9D?=
 =?utf-8?B?UzIrQndiM2R4djl3cXNIL0JSNVFCSTFYZ0t0QUxSK0lqNG54QlRQT0ZpRWN2?=
 =?utf-8?B?MWFvbk1LRjJGOURuREZycG5CMHpSbEloQVR1MXZ5SjVOQndSRFRaNlBjaTdD?=
 =?utf-8?B?NXhWRk5uVE1MdU9rNmNGeG91ZGhWNjdOTi8wa2VQeURHT1FVT242WUNiVzBV?=
 =?utf-8?B?TDZ1TlpQUGUyQTE3UVdKa0JlSkpVYlZIWWpuNzJaSVNjUkpON0Mza0JKbHZv?=
 =?utf-8?B?emRqeDJLT2lNNk5NNG1PL05HbVJZU0lkYnZoZlJzZFZhekpmYlRZaS9xYitk?=
 =?utf-8?B?ZTZLZGRnNEVuMS9jK3hGSEZsUWd4R3dTYjZFWXVWZkFFYmZvKzlERnNnNk5I?=
 =?utf-8?B?YWhFbit2aVM3UUloenYwOWo3dWpxU2J5UlRBUXhYa2xEdzk1M2lGUEgzOEZP?=
 =?utf-8?B?eEJjUVVuV3NBRGlpMHVmNjRYZjVPSEFTa1VSVU5NWjVOTGh5cmM4TGRJU0hw?=
 =?utf-8?B?RjR3elNVSjlNbVpVZTFyUzFGcnpRaG9hZWZYWTI2dDEwWWF6aEpFc2I5dzI2?=
 =?utf-8?B?ZU95bFN3T2YzbFc2OG1FK2trR2d0WjhscXh3d3pJVk9NUTkweHQyamJDMkVn?=
 =?utf-8?B?UWRxQU5kSElkREVBSW8xcjg4MEUvUmlqMDBnQmVHUGdnK0l4enliUnZnS3pE?=
 =?utf-8?B?ZHBZMGZrclM0MUkvM3R2ZFBNRm9pT1pHc3lyV1QycTdNdk9Sc3A4REcvamxI?=
 =?utf-8?B?cWpLTzFhNytHMEQwdUtUWVd2Q1lKbGxzZXBNZW0wWTZUR0RvdWhzcjB5dlBr?=
 =?utf-8?B?STd0NTBCenBEemp3VXRzbWgwWGh3clRWaGljY3E3dXJwL005aERnb3JlNFlk?=
 =?utf-8?B?aWdqUFlQSlFsblVvMkRTVi8wQXNzVkZCK2JHdDRVSldITG9acU11aVVzMlYv?=
 =?utf-8?B?WFlYL29nbllUd2htSVIrbGsybExJMjFxU3ZRbjJGWENSVnJUU2Q0cFdHWHhl?=
 =?utf-8?B?MWtwSTZUUmxnMW1ONDhMc0pXMGMzbnRCRS9aaHNWeEwrSnd2N2pjMDZvQkUr?=
 =?utf-8?B?Wmk1SUI4ZFo2RkNrbHlSWXZHRFl6OWdyUWtnRUpuZ216OWJtMWsxdTlJZ2pu?=
 =?utf-8?B?RDh3SlFOeDFkRjdHVngwd2RWanpIRDFXekR1cFJEWnhtdlNsRE9ObnhuRklR?=
 =?utf-8?B?Q0NzSzFjMzU5WG9HVjJ1TWN0UG52NVd2RTR4dGVtRTJRcW9mOThxcUFjQ25r?=
 =?utf-8?B?WWphRm1BSHdKYXE4Y0xIWjU1SXpBam0zQ1g3U1AyeWV1NEpteTJtN0xzTDFR?=
 =?utf-8?B?c2g0VHNNQU1TaTlsSy9NanhjQUhxTWZkczZNM3JqaGt4NkU1MXFQLzN1N0w5?=
 =?utf-8?B?S2JLZFZoRkFjWE5WQ2RzZEFQdEY2TnVUa2lSZXlzTGxjV2U2T1hCd09jTCtr?=
 =?utf-8?B?SHg3NXo4QU9XeGVheW93alRrbE1Ub0c0UGxuUGtkVk9CTlhzbFlIL0VEVldE?=
 =?utf-8?B?Q010NjJmaGNPUFd6RDNtNHhic2dDUmV0NVBYMmZKdnFaUVZwbElITStZRnZw?=
 =?utf-8?B?dVpzZjk4aXhnRWp5dk5pTThTZ1VWanI3cm1GUlJlQzRLVERjMHVxY1JlMHFu?=
 =?utf-8?B?bHpmeEZnRHRtSUFSWE1oQkJ0Y2I3dU10ekV4ZVAvR3FuUEVEZVlzblhiZXNC?=
 =?utf-8?B?WUVVSXBOcHQzUTVTM0FlcUtObThsRGxyTHB3Y29NenBwVCtQS0xIcWljMVFy?=
 =?utf-8?B?QkVMSE9nMy9ldGg1N1VsUGlnU0VXQkxDVVhPRXpBK0JVNnJ4UFVjSHI0TTFM?=
 =?utf-8?Q?q+w97GUNgqmqxD63UmkG3rNr0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d07b4e8-7a3f-4905-0999-08dd8e129346
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 09:27:38.9721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXnwsPURB+dAibSRvC8uyZnUMarHye/NG3mqAVMeH0RhLX0roJ3a8EWcHJWJWtCB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
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



On 5/8/25 07:09, Samuel Zhang wrote:
> For virtual machine with vGPUs in SRIOV single device mode and XGMI
> is enabled, XGMI physical node ids may change when waking up from
> hiberation with different vGPU devices. So update XGMI info on resume.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 ++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d477a901af84..843a3b0a9a07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		r = adev->gfxhub.funcs->get_xgmi_info(adev);
>  		if (r)
>  			return r;
> +		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>  	}
>  
>  	/* enable PCIE atomic ops */
> @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
> +{
> +	int r;
> +
> +	/* Get xgmi info again for sriov to detect device changes */
> +	if (amdgpu_sriov_vf(adev) &&
> +	    !(adev->flags & AMD_IS_APU) &&
> +	    adev->gmc.xgmi.supported &&
> +	    !adev->gmc.xgmi.connected_to_cpu) {
> +		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +		r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +		if (r)
> +			return r;
> +
> +		dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +			adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 32dabba4062f..1387901576f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -89,6 +89,7 @@ struct amdgpu_xgmi {
>  	u64 node_segment_size;
>  	/* physical node (0-3) */
>  	unsigned physical_node_id;
> +	unsigned prev_physical_node_id;
>  	/* number of nodes (0-4) */
>  	unsigned num_physical_nodes;
>  	/* gpu list in the same hive */
> @@ -101,6 +102,9 @@ struct amdgpu_xgmi {
>  	uint8_t max_width;
>  };
>  
> +#define amdgpu_xmgi_is_node_changed(adev) \
> +	(adev->gmc.xgmi.prev_physical_node_id != adev->gmc.xgmi.physical_node_id)


Please drop that function and the related checks.

If this is necessary we want to update the relevant parameters all the time and not just when something changed.

Regards,
Christian.

> +
>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
>  void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
>  int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..7c0ca2721eb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> +	if (amdgpu_xmgi_is_node_changed(adev)) {
> +		adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +		adev->vm_manager.vram_base_offset +=
> +			adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	}
> +
>  	/* If a reset is done for NPS mode switch, read the memory range
>  	 * information again.
>  	 */

