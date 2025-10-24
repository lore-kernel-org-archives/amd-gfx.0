Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4837CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 19:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9222910E222;
	Fri, 24 Oct 2025 19:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HsyiqpGG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013026.outbound.protection.outlook.com
 [40.107.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0511810E222
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 19:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQ9r+FrCYhPrX/vsywF/VBuztgdB3onSk257tnAk7sBDeIF+6hj+rt298hRaxRo5aZoF80nJSnRFfljvHwZ/fh2FkldQ258zq/5WxfE30Jd3l1yU8CJ6vdSBCunQxaWYoo3T6eiViTU3LZUu7nXodiHu/w+Kn9myV5PHdqALCXhnuiS/PAKqlTxz+LcxnFXqAkuxDpMoM0Qdvr7wLZZOGRAiyAQQwyjtPv4rYgkYGjGYVUrZOPRvonD5KGjSYC038hQJyqK2KkbB1PMjVVcEfgSiDN6aQ0lU0GxJCJhr4+8qcCAq1sUyDCLDSrGD9+nozsiBz3jzvDBZVcDALOuvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nSNE0lpAXzkRo5tqcWLIQs8QeuTdKppgvbHJXJ3PPs=;
 b=t8+5FBiMTu9g8BCZZCHnIyYDUmDCCzmkPXKFR4Sg/DszzkiWVpICLZW1hGfkAWQfuSaz3gXwVzLw3/nMmZRCAaSBTwySeAwmzNxi0vKFL+bvUtoQBbooiKG73ZwE6TEpvRaXa4tE51xUsT90blY4QSSPLhRyMAH8RfCroUMFB131E5eUKMMWpfqHSPnL8ZSH8IbKD937xohtvYZyyEyNNnI54zL1mOLpPxsu3mgkxU939Ksl2zMZxMr9L8sckS7qJQRqMadkbmdv7cCjsXc9Ji/f4zvO78ICkpkb4P0GJNOrw2vilID6iXemwRC5iXzyInKPtln6QTnn+iVa8j/lmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nSNE0lpAXzkRo5tqcWLIQs8QeuTdKppgvbHJXJ3PPs=;
 b=HsyiqpGGPYKj0X2NYqr/rjyrBsj2cKTNXy8RQRBWdgnjPa5LPddIKbJP3akP8BRdCOxoN9OsdgQRiKNeZs8sNU0gzLMd/mxz79ppmVbc7oa26j8JrKvd0hbSOrGwZJEGUHkST8m4RF7L1L+4ZR4eRh7/kIZHKCLJ14NqU/ag964=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 19:00:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 19:00:41 +0000
Content-Type: multipart/alternative;
 boundary="------------mSGZOwl0s0Cvq5oN7tf09weL"
Message-ID: <edff760c-75ed-43eb-8861-f07d12b12843@amd.com>
Date: Fri, 24 Oct 2025 15:00:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdkfd: fix the clean up when
 amdgpu_hmm_range_alloc fails
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251024172616.2302099-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251024172616.2302099-1-sunil.khatri@amd.com>
X-ClientProxiedBy: YQBPR0101CA0341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 6836b0cc-5d80-4227-ddf8-08de132fa05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmdmU042Y3JyU2hvalFqYmdwNUpRMUw3bzM1N2pWbnNqdjFlQmFFU3hBVmhw?=
 =?utf-8?B?eUNOTlZ6dG1iUlRDTUhaUG5hRm5YR251a2kvai9VdWxINHFBdWJJNm9RSVU0?=
 =?utf-8?B?NG1Lb1c5NFBJOVJrb3I1eTJSMGZVK2pwOEtmWHlKK2xrcG1aRVNLZHA5cGxM?=
 =?utf-8?B?MWJJa09xWm9pSUJ2ZWE5VVJzMmJOQUlybktpaFFtMy93NlZOby9yV3BUd3Bz?=
 =?utf-8?B?S3RHZnVDT2ZFMlllbVRqOTg0Qk5Pbi9HRWxvdWdTSGp4dzVNaTRLNk1MTng0?=
 =?utf-8?B?NXhhQlNSZnNwbVBJNStkZysrbFpXV1hGTDVoai81aldRNnBRSFI4cENPNnMv?=
 =?utf-8?B?VDJLR0xzeVVBZFVudEp0c0pGVHZSd01iWStQUFBWOFR6Vk5wbXVHVC82aHd0?=
 =?utf-8?B?SUdieXN5cnc1NnY4YzdNeFZMN2R1bVBTWkdLbUFEV0ZoWG9USVBRS3M3QnNV?=
 =?utf-8?B?Vmx6cTVSNXJDcGtjMVFiaTdCdExSUXl5WWJpL0xJYlMyY1ByWE5Xb1JMbjR5?=
 =?utf-8?B?cFJpWGZ3VkVpYVpPMnNpZG9WMXUzbDl2SXpVMWZ6dndORlA2b0RaRXBxQkNt?=
 =?utf-8?B?WFltdnpSRVdUSitqbmtwbzBrWDBMMVYwbSs2ZkY5bW8vdWhyK3dmczhwUCt3?=
 =?utf-8?B?ZWxVZGtZMVpDenNRTnpCRVQvekZQMGoxWUwwWjlrajlhdjBKUzhWVE12SHN2?=
 =?utf-8?B?Y2NOcGtzR0N5UGJ2RnM2YllqRUdwUWI1T1RiR2dMalJCMVV2QVQ5amg3OGt0?=
 =?utf-8?B?aUt2bENiZjZFV0tHV21zMmhZQ2VLNFVsQ01oTFd0MHN4OEdUQlR1Z1V3ZG1Y?=
 =?utf-8?B?enJmRTBRbTdFdlQxL0k4bmJ0Uk1kZ3YzSzg3Q2JtaHVzZHF6cVVmOXVTZjUy?=
 =?utf-8?B?ZkRlRDhhb3M5VlZUZFNUVHJ3K2dmZ2JuczdNNFE4U3hzQUh4bTFiakcxT2Jy?=
 =?utf-8?B?dnZ4MHlnYUQ3UnlZUTUvQ1Z0RmJqNG00WXVwM3BQdHVYdVJNdVJvK2pHTWhM?=
 =?utf-8?B?aHJxemFka2c2dU9YVjVkSk04ODE2TjZndHYxOE90cW5uWncxT09pZ0FzZkp3?=
 =?utf-8?B?R0w3YWQ0dW9FOTQ1ZHY3ZEhqR0I3N3EwbTFrMzJzWkd0dlVoNUduU0R5aGVR?=
 =?utf-8?B?cDgweVVUVzdsY0tiekZJSDk0dElDRnlLUWtaVTJNbThNRDVqTlVLMFAwUml6?=
 =?utf-8?B?YTZSK1ltVlg4N0ZXYS9RR0JjeHJiOTFqUDdoQ0UzSHNmR1BVT2srWklHZ0dj?=
 =?utf-8?B?MWJnR2Z4TUhnckFZcGl3ZzFlQWFFRUx1OXZnelBzNG81anlyU1V2WVFEcUt0?=
 =?utf-8?B?N1pLdzYxZExweGRmczJrUHAvejBJSnY1VHlDSEFMSkNsMUcyYjdwY2hxNlZ1?=
 =?utf-8?B?djJNT1RVTC8vVUZSTG9WU0h2QktDYlNjTTlmdVdLVEpWSnE1N1R5RXlpbW1j?=
 =?utf-8?B?TkQ4WFhWam1ZUHRSSk9jTk5iWWxuY2c0a3hMWHZDOVViUTQ5bnVqTllqdE1w?=
 =?utf-8?B?TTdzdHVOUEZOTzIrY3BFaG1DSjhROVhaYnZmcjRkQWQ1UzJYRE5wejJlWFpW?=
 =?utf-8?B?OVZWa2VDeVlFdm1TQkw3ajMrem1oYkE2WnJIOGR1NGdnVkZhSlJwRU8yU0xO?=
 =?utf-8?B?Z0tmSWpRMVJ6dThFWFI5M2RxU2lJdEZ2emhTS01ndlJCTUw3aEp1eWlOTXJO?=
 =?utf-8?B?cU9PbFoyN0dQSnV2L0FaVVhNZGpMNzFKakZyVTRmWnBabVlPSEsvVlJSanlk?=
 =?utf-8?B?STVvY1dnaDdYWVJDRUFNWDhXOXNiWFB2WUwwbUhiK2t6TnBRTDBGazZ1TUgw?=
 =?utf-8?B?bEl4MFJOaWcxcHpMQmZURUVSNXdYZ3RpYUdzeW9Ld0NUSDRvN21uQy9FUEVn?=
 =?utf-8?B?OWRzLzBDZGlveUdZL1dPK2J1TElKRm1uN2didVdjVlVRdnp1ZXZvWEdkVlJR?=
 =?utf-8?Q?SaBj0mZRWbe924OlvopVwNEIk5W0QrjO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjlMWERWWUsvRDVhTkIxT2R5VjNHcXBOOUVBV01tOGxEaHhrTnZmWUR3cUZF?=
 =?utf-8?B?dVR3cnJoN3kzdUg0a1Z3Z1JGSUROTVVOa3ZJYmpBRUJvNG92WUI0UHRZcGUw?=
 =?utf-8?B?V29DK04wKzZoa2FsdVhzR2dWRE9vdWUrR0d0VFA0TUVTckxrbnZoQ3c3TzlJ?=
 =?utf-8?B?UWtuLzFhcjJPVVhUeEc5WHp2bEdpVHpYMmZSVHZCMzRuTVZkZURhVFF5S2RM?=
 =?utf-8?B?YWNFaE1LdzYyd2Y1Y3dLQ1EzWFNSZVRhUURMYlN0U2w3RnEvT2tkOHVtNXVx?=
 =?utf-8?B?ZDFqS21QZkgyMVNOYTM0ZDdWMEllVmQrdUxJeDRIRGpYWFdmWHdCcmdrTVB0?=
 =?utf-8?B?SFhpVHpHUWtJRTJPeFVuVUsrdUF6bjVPRXZhQjlPSlR2dU1lblFSUlNMVGdk?=
 =?utf-8?B?bWdqeHl1YUtOTEdPQWFlT1dpU1g0MWo1U1JOZXU0MGFqR2lOd3M4RmFTVVVK?=
 =?utf-8?B?d0ttQ2Ztd2pBaW9CUXE1TjhiWi9ScHp2MlBTSXhVbXhwc0ZPM2JUeFF0Ykp2?=
 =?utf-8?B?bXBaZnl0SFAwWEhxQVo4akc3OWxiVmlQWlUyTGRzd0hwQVd0aWN2TEtaOTUx?=
 =?utf-8?B?TjhsOC9leXNYVGp5R0tPRllkOC9zTmozYVZIVG41ZHA3dGk0L3NkbjNVYzZK?=
 =?utf-8?B?N2VWeDlLWXhXaGMvR05yMkRPZml4Y2g3NENTN28zWlNQWno1bktNS1l5TnJR?=
 =?utf-8?B?Z05QcGswbEZBZldTbEJ1L2U2aldxS3hVT1FKcWFTNlFzbUQzUWtLYWVsdVVw?=
 =?utf-8?B?OUtNc21nRFNYc3NFRXNydmx1U3M3ZUdZNndJMlpPQzNTcURlalZRSzM1TGtU?=
 =?utf-8?B?dUl4WWYxVzd2cGUvT2ZWNU5uTUlRVE1pemJvZjNBbUJJb0xHSEEwYktDQnVE?=
 =?utf-8?B?aXVkbkpYZkxteTJYVFRiS3JyZTJqaFRvdmtHd0EvNDhreGRTYUVhK3ZsZjVq?=
 =?utf-8?B?Z3dNUzVydlBHWCtmUDNlQmZBcUZQc01WN3ZSU050S0hWYUNsb3pESDE2Qm9m?=
 =?utf-8?B?dU55dks2UlN4L1ZoemQ5NXlnTklPbjNUbVI3dWtFUEJPOUc0R2UvQ250TWtH?=
 =?utf-8?B?TFh0Y21ITUl6dDZ2ZlNqaGYrYytzaFZFaDRucVF1bWp4TFl2ZHJSdVFsclA5?=
 =?utf-8?B?RmtxZ3Z4RVNkLzJ6M3NWTnhOd2hBL0R4UHpWSCs1TCttRVgrUXY3MmV5NEtO?=
 =?utf-8?B?MncwdVNwN3JVcFJFVGp2Nm5vZW14Z3Nhelk2dHBSUzVmMEtuRXNyMUhJMmN1?=
 =?utf-8?B?TGMyNlpQWXUvRmpVazNISTQyb1dIc1dPRnc4TkloSkU3OWk0a3RqWHdOeXZQ?=
 =?utf-8?B?Z2d5ZFpMTy9VdnRveElWdmhLV3RvV1BkbmIydWJPQzJQeGpzM2dLSFhOcUJ4?=
 =?utf-8?B?d0xDTUc0bDBRcDM2VXYwemN5dXRKWUIwNjlEVitCU2lPS1FuYlhZSktGcFFT?=
 =?utf-8?B?R0MvdUJVVDVZZkRqZE05Q3FyYll1UjZPZnNvWGx3MTdHK0llNjRuZFM0ZWdW?=
 =?utf-8?B?MGtNalF1NWxsd3ZIdXhDLys5VzluMjZFQXRCOTF6L3RIaWwvSnRzeVZyakZL?=
 =?utf-8?B?UEVkWXNwQlNZMFU3cUpuZjNjbmFPOEhscUZFT1c4eVNmSVN6ZG03bHBweG1t?=
 =?utf-8?B?Y2hWcmZDZEMwWWMrZGtHcThXWTcvK1BVeWpTK2xsWTlMM0h4UG1iVWg5YWk5?=
 =?utf-8?B?VXFWVGlrZ2YyWml6MVR2NVlLVkZVWk1YUkVPdEdPbHFXSUx0ZVdRQ3JHYlIy?=
 =?utf-8?B?Vm1qNzNoNnhQOFJ3VHkrSDdCNHJKTE8zWVo3cnAwN2lLb296d1pRd2oxUmdX?=
 =?utf-8?B?cDFQRGtIVDRjY3ArQk9YQXFxYjF0SXJMZzJmQWFJdHpVc3hwbFdYYUlpc2tP?=
 =?utf-8?B?UURxWDJrZFA1MURSYTRTY3NqakZnUWh4TW5iTXlQRzhyeGVjUnByQTBlaUIr?=
 =?utf-8?B?YjNrSDJ2YXZqTUhmWGVJcVFDTSsrSW05UFIwUUFSK0FMVENYSDVjelB5UTkw?=
 =?utf-8?B?YVErUVREN0R6am9BV0ltdUh0RTdRTitBT2Uva0J3VTVXQzBpbTFla1kwbE1o?=
 =?utf-8?B?MjV3QktoWHlrbnhJLzhkcE85d2JMVlJnbGFWNjE4QmpZT0lOU2xsWWxSeHRW?=
 =?utf-8?Q?xd7I4vIsQCugaV8kfQHsyPDlL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6836b0cc-5d80-4227-ddf8-08de132fa05a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 19:00:40.9991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAHI2bx7YIQluX8CRrcoNephkLblvkTWFh+JAQV18c61CrUiF1UWlO2ngmLJViKGFaLaV3tuHzBNGnypBsNO9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612
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

--------------mSGZOwl0s0Cvq5oN7tf09weL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-10-24 13:26, Sunil Khatri wrote:
> we need to unreserve the bo's too during clean up along
> with freeing the memory of context.
>
> Fixes: c549912cd8 (drm/amdkfd: add missing return value check for range)
> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7f0ab73e2396..76e36201742a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1740,7 +1740,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			range = amdgpu_hmm_range_alloc(NULL);
>   			if (unlikely(!range)) {
>   				r = -ENOMEM;
> -				goto free_ctx;
> +				break;

Sorry, looking at the latest code, it's even more complicated because of 
p->svms.faulting_task, which also needs to be reset.

			WRITE_ONCE(p->svms.faulting_task, current);
  			range = amdgpu_hmm_range_alloc(NULL);
			if (likely(range))
				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr,
							       npages, readonly, owner,
							       range);
			else
				r = -ENOMEM;
			WRITE_ONCE(p->svms.faulting_task, NULL);
			if (r) {
				amdgpu_hmm_range_free(range);
				pr_debug("failed %d to get svm range pages\n", r);
			}

Regards,
   Felix


>   			}
>   
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
--------------mSGZOwl0s0Cvq5oN7tf09weL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-10-24 13:26, Sunil Khatri
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251024172616.2302099-1-sunil.khatri@amd.com">
      <pre wrap="" class="moz-quote-pre">we need to unreserve the bo's too during clean up along
with freeing the memory of context.

Fixes: c549912cd8 (drm/amdkfd: add missing return value check for range)
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7f0ab73e2396..76e36201742a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1740,7 +1740,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			range = amdgpu_hmm_range_alloc(NULL);
 			if (unlikely(!range)) {
 				r = -ENOMEM;
-				goto free_ctx;
+				break;</pre>
    </blockquote>
    <p>Sorry, looking at the latest code, it's even more complicated
      because of p-&gt;svms.faulting_task, which also needs to be
      reset.&nbsp;</p>
    <pre>			WRITE_ONCE(p-&gt;svms.faulting_task, current);
 			range = amdgpu_hmm_range_alloc(NULL);
			if (likely(range))
				r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr,
							       npages, readonly, owner,
							       range);
			else
				r = -ENOMEM;
			WRITE_ONCE(p-&gt;svms.faulting_task, NULL);
			if (r) {
				amdgpu_hmm_range_free(range);
				pr_debug(&quot;failed %d to get svm range pages\n&quot;, r);
			}</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20251024172616.2302099-1-sunil.khatri@amd.com">
      <pre wrap="" class="moz-quote-pre">
 			}
 
 			r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr, npages,
</pre>
    </blockquote>
  </body>
</html>

--------------mSGZOwl0s0Cvq5oN7tf09weL--
