Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D98C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 14:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3C010E967;
	Thu, 20 Feb 2025 14:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXOjcvvr";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A989E10E967
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 14:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfHy3VyXZ9BZ6KZNp+ONM3LmSypFzZxvnyhf+wKXy3sG4LHu9adTqEdZFFKg9XxUGUAaj9GJiC/pitplihCmOO+EOxZUfB+4r8rU/j8bhibHiJalEElQFE6uNiglfUcJtVtWDcIU4Zy7mz33XEeFhLEwQoSotpF/9Syd34zP5VakTLaHUgg6GPfdd//if+kCYJoylKVW0ASR4KjHKwjl/8l2B8CWVket123Ofmbj6ru+yNl7CnIHcS178Pco0Q7mQ8P+hYVWNLZvVMuh7nAcIFaKpwJmkwWwNGpgw7MUKSiLDs03LySrF2H8d8NwXi5W5sCgcY8vVEx70v+Hc4/ZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX0gRu6y6Sx+32ZwuLH7pOP5OGMax7zmPBHQFkYxu8Y=;
 b=QY9Qkbx9+AEBeFqi+xhoVssmO+oCAiUOqzAdIuvCvSGBokPURljYQhEdhjKuiX8N9v8V98c5yko4CtLeiVIFOQn50IPFO8IYMK8VjG8vLwNQ5gAPZDmBiqp4abR8mlAtKftIYh7pOGsPqaU+u/uwxznEYgzVTBgYRCzBY+z99syjN61nUX/Du8perZOJ/hcVIJb1ZAfxT+dz/wGMcuFZNZZH0rDLP8LsPoprItUTgbjUeddNkPoA9f3Hde7BvC2lW4HfJ/rdew5ysu1hRfnlmL5S4Z0lIsXU9wSK52lphjW6+CclioUPZqMVFyRv3tTXkkiMy81DKvPKmfezx9JKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX0gRu6y6Sx+32ZwuLH7pOP5OGMax7zmPBHQFkYxu8Y=;
 b=EXOjcvvr6goiRoIduTaUeJVWqrh6DA+ExzOhOfloJ0I597J5pZMyQPkH/31HfYrrGS+TQCmod61bELa5MPiFRQBNIRiULW/4/pqqHujURPPnS1t9fgecmtEmyyHiQ56Ppt4Mhw6qqp/sXh5axlOQSXVEv13NhhPsMho/nIKqjsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 14:27:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 14:27:11 +0000
Message-ID: <37d2ac6c-3888-4123-a8c1-733cf65a4e07@amd.com>
Date: Thu, 20 Feb 2025 09:27:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't over commit vram while xnack is off
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250220120013.2051240-1-Emily.Deng@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250220120013.2051240-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: ba030503-0fe0-47f8-8f80-08dd51baa995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnRQRGRlVUpiaWV2Qi9ud05waWRteGlXcTZ3akVvQjBMdWNBaGdVaHVhaysx?=
 =?utf-8?B?Qk5vNy9pZXVET0IxMUJBRjc3Zk5Gc0hwWUFUQ0xPOXpmU2dkVmJSekhMMjlw?=
 =?utf-8?B?QnV5VDN6aFg5Y1kzUUdRWTc1MWpEaFZyMC9QTzRqWklCa3ZhTXVuVnJxNUlX?=
 =?utf-8?B?enYrUDV1VkNqM0t6VmxEUHl6T2JETFJJRVBOUW5RL0pieEtoV2tjU1NXa3hY?=
 =?utf-8?B?NzRQMTNNbG9tQkZHeVRXZnNiaUpXYkRzQ0YvcmN5OTI0dUVwakx5QzZRaWxy?=
 =?utf-8?B?MUNMbGZleC9welV3WE5Qam1SS2FQOTVvUzJHYldtcjQ1VFhSVDUxMHpBdVdk?=
 =?utf-8?B?czRQbEZuQndiOXpvZGpPYmhEMVNwZmFTa1RNUjJ0aWtkalp5RjVCM0U2dG5Z?=
 =?utf-8?B?WjNMZ2xBdXcydFFrMW9jUGlsdEVrVXRLSmEwelE2YzAxZnBRM2VxT2I0MjBk?=
 =?utf-8?B?SmtWYWxUTW00aU5Uajh2TUJkV3hwR1BRSFhoajU1MkhjbTFJL0krU3lwZ2tp?=
 =?utf-8?B?bGZEdCtTK2Q2YlJ5WHNFWEczNC9nTXQxVFF3cVp5MjZLa3U0ZWNKdlRNbVYw?=
 =?utf-8?B?RXp0OUtPaUU5bzRCYnpuZ3hLUVYvN0JjaS9wdDVUbVpOV2pWdUNzQzA4N3VC?=
 =?utf-8?B?UWl5UE9CdEFyMm4zc3h3bWY2d3R3QVdFa24yL2J6cG9xU0ZWb3cyVUZOdzR0?=
 =?utf-8?B?RXNtTlNMckQrZUpwc2oyNFIrTEZLMTdMdFE4dCtCM002UlNlSEhXLzY4MjUx?=
 =?utf-8?B?Y1JrYm03T2pZb1VWVEVkb2Z1enhabUZVZk0rak10MWJyaFhlVzdTRDVKOXBq?=
 =?utf-8?B?NWFaVVZiQnV4RVZ0YXhZa0cySkNMenV6eGx1dURBUi9BdjdZUXd2TTlWM0JF?=
 =?utf-8?B?VkNFaHdhOXZaWGpFNFhaUkJUenVFa3ZXNXlVZUh2OStBS3FYbDBMSmtvSUpl?=
 =?utf-8?B?YnprMjV6SnJjdDFGa3l5VUMyR3pWM1ZoTTNkUC84UThRT3ltVVpPMGFPVCtD?=
 =?utf-8?B?cWQ5dzh0MTYvdFJFUjY1WG5BajNTL3FZbURHbkFFZ1ZhUEIvYkgrY1hOT1Zm?=
 =?utf-8?B?eTVEK2FjU0kya1FRUE80ZEhTenhhZVB6OVVUMmsvZ1g4YlBMbEtYZmlWNnhP?=
 =?utf-8?B?c0tjbCtmRG93a1RUdVBJWUwrbVZuTzJ3b0ZCU3JJWWlQc1JEeEt3eTQvendy?=
 =?utf-8?B?VlhFa1lUZjhwZzJvRW8vQTd4SE42cHJjWm16ZzdWN2VhTm5YUmpBMnpGVnIw?=
 =?utf-8?B?eDBOTGNJRUsrVW1wc0M2OW5SZm42cU1laGgwWmYzZHkvbW5OTUN0QlB0cURW?=
 =?utf-8?B?bHVWcm9iK21TSDNlVnc1Z0hWbWd6cGE3Q3JvWE9CR3dvN3pldENqMlV4MExN?=
 =?utf-8?B?MERka1JCZFBlOVN3Vm9WWnRtMmlCY1krb0FMRTI5RnROaG9OVTg1TmFnaklH?=
 =?utf-8?B?dW0zekNlTi9vMVdHMU1hUkliM3ZjNXcvM1BXbGtEa3pwYmJOWVJyR3UzZmhY?=
 =?utf-8?B?dDkwQkxJdGcxdmk5Z0NQS1h0RXBOaXVFeXZCbU1STTRDbThCZUszejJPRDlt?=
 =?utf-8?B?SS9ZM0JBclgvOHdxTUFuYytzSWIxa1RpcFVrc1M3T1ZDK2JMcHdZMWVFdXJZ?=
 =?utf-8?B?Y29pTVBUcWttbW1RaWVONE51NDhYTjJoa1lwWER6czVIaFJmNDczZHJ1Smdp?=
 =?utf-8?B?Kzc5WDI1YmVYanhrd1VqT2FIbEp1SDV3a0RQelZFVVFVeitOVDlZZ0Q5bVkx?=
 =?utf-8?B?QXkvNWoxNVF5QXpnRWVzUlZqZFRSUHQ3eFhFZXlZdDF5cjlFL0pwNVVDQWo0?=
 =?utf-8?B?ckQwSlhiZUp3cVNJSFRoZm9vbnp2WmY1NDR4MnpkbDY5NThZWUZONklVYTFw?=
 =?utf-8?Q?tZKluocLKlbn7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajVMc00zUkNZSzlmQk1hQ2NzRVNaZFN2em9aUW9pRE1ReGFGc29yYVFLb1lF?=
 =?utf-8?B?ZEM3T3dwbG5UV3ByZ3lNSW1wK3hZbXZXUFk5R0xqcGh4L0QwdWx2OWNDUHZs?=
 =?utf-8?B?UXlWRUpGQUZiL2xWMUlqcHJDYWNpNU1TSXRjZ3FpaXFyY0RUWlRwMmNNZitz?=
 =?utf-8?B?bWp4YTJDVy8vMjA2RE1PUmpGWkg2bXI1TGxybmRzekZsZVVHcWJCYVRxajFs?=
 =?utf-8?B?SlNNSlh4S3pyZis5TEhsV3Z3ZTBtZjNLemdGUWlaeHdYK1FET3hDNWJ3TGZp?=
 =?utf-8?B?S2FrRDF3V0JaOGRvS2UwclpaRGpNUXlJWmdrYkFNZ0xuaW1JWExyNjMycEsr?=
 =?utf-8?B?cVhJVk9IZjVodzdtRkRSRmkwbWxYdmcreXI3MnR6b1FWYmpDeEtrMm9GWkhw?=
 =?utf-8?B?S3VxSDVybU1QVkNnSkE4byt3WmxNRmRYVHBSQUFYekQ2RkR0dlVERHQvQWdN?=
 =?utf-8?B?U1NaYWdxVUtieHNTMk03Uis1dEtyL3Z5WTk3VzJKNFdOVzdWNDJZOTc3c0VB?=
 =?utf-8?B?Ujl2VVZsRVR1UHhEb1R3RmhoQktTdHJVS09ObXZoV1JvbEdkYVc2N2N2MFht?=
 =?utf-8?B?T3drMmc2eG9tVk5MUFl2NG03bmpaNXJnaTRXMENYRXc2V2RVSnpsdXk3SEdy?=
 =?utf-8?B?d29qSVBmL3QwenVaWnVISVJNdHdqTmw4bnYxYXUxNjBxY0NBWG5tYUF4SVp4?=
 =?utf-8?B?RU91MUFzc1ZGVG4rbTVYUkNWQ0x6NWljMHVTMDh5cXhhRnI2UDc4RVNsVGMw?=
 =?utf-8?B?RDltK3BkaG11M1Jpc1RPYVdTZDQvejRDUGNWajFQQTNEeklOMGdocEZDTVhQ?=
 =?utf-8?B?SlZsNk5BM29tR3JNeUxSNlB4eExKRkZHTjlRamJWaG12SVlyZXRMYzc4SmVQ?=
 =?utf-8?B?K3k0czNNS1l4K2UvazQ3T3pjYUIyaVZwalhPZ0lUSzBIdkRnaVdjQzhBMUlI?=
 =?utf-8?B?OWVqVDBLTmVIYkplTy9hMVlJdE9SOUtDSEpaSUVWM0gzUnR3YUwzVXRjak9U?=
 =?utf-8?B?alFpT2xwdDZ0c2hvRnB5RVlHT256ZHhGeklhb2lnYnI2K0JJMnVHR3R4Nm1a?=
 =?utf-8?B?OHpoY0hOemtDNGhyaXpHUWpjRmoyR2xNZk45ejVrNmMybjNDeFJ6TGw2eUt4?=
 =?utf-8?B?ODNselNMNzROeWlZYXZ2clN6aWhNNjBrTHAzUGpCZHR1M3cxd2NxdFNhU1ZR?=
 =?utf-8?B?bkpud2s1K2N1cmVydEVSZi9uUjZ1cXJ3Mk0xRmwydjdINnlKS1N4cG9NS251?=
 =?utf-8?B?ZGN5VWs3b1pYZ2JDZENQWnl1Um8zSWdrdVZLS3R1SjdsRUtuRUoyNlU0eU1I?=
 =?utf-8?B?TlpWMnZmQ1FSM3licXRKNFpKMTBGRmg3YnE3NzRBUEpKS09ESHcwWWVJQ05l?=
 =?utf-8?B?a0tRYnFTS2N1bmJUczJkSFp0bmZ2ekh6dXdkTk9ock1SVjZtc0E0NjYxamU3?=
 =?utf-8?B?S3Q0ZHNVaEFvQ0ZFN2hteSs1cnk1MmpnaTlRQXU4RVpXZkIrSEtLRjQ1eE1j?=
 =?utf-8?B?WHJCYVArdXFWSEYzVHRGR3dMWjg1SWlvRlpsZDlXL3prc1p4ZzZwTHNKR05k?=
 =?utf-8?B?QzJDekFNQ1M0OXJidjNqYUVIdkZvZ2lvSEFlOTA0M250RmIxdGxSQVdXZzNq?=
 =?utf-8?B?SUpFQzl1RVlYemswY1B1VHd1YUk4YngwSThGMlBTeWRRdDhKcytaNHA0OTNT?=
 =?utf-8?B?Ry9YbEQvNXFHUW1WRDZ4Z1d6K2FFazAvUjBERkZSTDFtTDFBNFQzK3Nic2dx?=
 =?utf-8?B?eElhdmVhTkh0c016ZjFwM0haejV6cEthRkFqUk1DdzJOK1lXK2F6MTBXRDlq?=
 =?utf-8?B?QXhFRExuZU00Nk5kNE5xNVpaUEJ1cWduMjlpdTBPdlJYY2hZbHl6akJKaU5N?=
 =?utf-8?B?YkY5eHE1SnBWcjlUNDM1L2tGQXVwU2Q4Uks2M0ZIREF1c2tsZUhQdzFHY3Rj?=
 =?utf-8?B?SzdBS0FMZUIvT0ZKaDlrMStERTRFZE9PeTdyT3pEcmlOU2VRQ3dibFYyZHNm?=
 =?utf-8?B?b28rWXdyNnBSUW5GQ1UwTzV2dUd5WXRRUXByVjlKSHBrU0oxWGhNLzBGK0lw?=
 =?utf-8?B?MXFHRldhV2JqaGF4UmVVRlk0QTdoRVRCM3ozRElkTXJhRkNFWFFPR0QxUExD?=
 =?utf-8?Q?IIel/gp8D+MqLPeJrVri0YhlR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba030503-0fe0-47f8-8f80-08dd51baa995
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:27:10.9304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H9L1sXa2xQCUTyDui2GmskhfWkB5ik1pUrp5Cw8KEhKICC0dPiDppTsFzvSP/oaFR0hb9DlFSlvi41V9eP5Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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

On 2025-02-20 7:00, Emily Deng wrote:
> For xnack is off, the application should ensure the vram not overcommit.

This is incorrect. SVM ranges in VRAM can always be evicted to system memory even with XNACK off. During the migration the user mode queues are stopped by the MMU notifier. We apply system memory limits for SVM to ensure that all SVM ranges can fit into system memory. VRAM is used opportunistically while it's available.

A VRAM allocation for non-SVM should be able to evict SVM ranges from the same process. This does not stop forward progress of the application because the application can continue after the migration with the data in system memory. This patch breaks that.

Regards,
  Felix


>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 1ef758ac5076..1aad27994452 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -171,11 +171,17 @@ static void amdkfd_fence_release(struct dma_fence *f)
>  bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
>  {
>  	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
> +	struct kfd_process *p;
>  
>  	if (!fence)
>  		return false;
>  	else if (fence->mm == mm  && !fence->svm_bo)
>  		return true;
> +	else if (fence->svm_bo) {
> +		p = kfd_lookup_process_by_mm(mm);
> +		if (p && !p->xnack_enabled)
> +			return true;
> +	}
>  
>  	return false;
>  }
