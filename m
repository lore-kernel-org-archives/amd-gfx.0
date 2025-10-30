Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B729CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F6110E288;
	Thu, 30 Oct 2025 15:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pZjzF9UF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E1710E288
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7AFi8OqUJaoGs2MxE/B1dCrBFfhdu5/k5JWmaFhdbQgu/g3rBxPv92q2vm09JOAqBbvcMwX9MxkVmxdWlbp/QqFES+7VHt1MEbUYS1Kg0/DOnmt5jJk35HpWdpaEYEKXrAF14haTxK7dPU2W94PHvO5/BwFry1UjuieUGfuUsXhD/xSsnjpcB69TcI28OCAhDdK24QsLRxdMSztLJcdKqv6pdQS2YfvtIsPvN1EQd4PGRNMGGKXu/OFQ+X7yb59ESQMt5VmgfQjS983slebjnac78WIYmUVA389S07vi1DKK/a7Pg9N8DR+JPELe4eM2ZW0N3CzZTV0TwsrAhcz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SauQjd/rYlG7d7FbDxTIvn+xLN91B9JPjbpufI5OlLg=;
 b=ZBkfg9V4dnMKHznSHKfmfVaJ4WTL3wQGYgSmKXyj6C9I9mpxqC7J7BYSjFd9YJ3207eQgENiBZnMKqQxCakQAA69nX8Ed25Se5bfxOs1gsLYE3VF/ajfPGCMg50v3BNj8VegDd6NO6GgfMAR7c9QP6NL34BWhehy1ANnhmDd9wNArTm1bY2Wcj7lJssy9FdpecMbiDIKFHyKfZcxNySohBRg95JcvCRMvM79opzruMU/+/n3vs4hIPpq4lT1sOHDUqn6Oj0gnFLxHYOU3A5TuB31r68S+sZM5zskyBarYxeLvLLcp8a8ODKZS2sKYPZY+RHDhQLyCseD+WzT8mhytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SauQjd/rYlG7d7FbDxTIvn+xLN91B9JPjbpufI5OlLg=;
 b=pZjzF9UF47J2/nnvRec48CbF8hvEG9uzWcPKRoWYvBGlHo7TK7FpdKLdtGHEha4ojn+M/dbUJcq4n03DXHHl89kTFP4N7PChVgdvgbH4AbpG51O8mj0NmVch2XcJkN9/JhLbX8EQWCIvq30XpuuMrtoeHK17iRsNaLMuOlhKGss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:05:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:05:14 +0000
Message-ID: <24133b30-07bb-4ff3-923f-02d5a421fab6@amd.com>
Date: Thu, 30 Oct 2025 11:05:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251030034536.11356-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 4278e460-2da6-45f7-321f-08de17c5bac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlZ5WTFFVW5vcmJDM0t6YndudFVhNUJlVEFQOFZqN2hpT3JqTng4eXZiaW0z?=
 =?utf-8?B?bWdnaVROcEdDMzg5cWlScTVXMVB0VFpXcHVaajB0WFh2T0FHdTZhOE1MTkN2?=
 =?utf-8?B?L0pqbVk4M0Uxa0l1KzFVRGh3akd6NzlmNTYxWldrZUxrN2tHbjVlY2VnaTlZ?=
 =?utf-8?B?bE1EQXdDTnQ5aUFvY2hjblFMeWlVUWlNamNqSVJPYWU1NDl6TXptR1ZmcFV1?=
 =?utf-8?B?Vlo2eUhMNTNoZkZyZk9NNmNscHRWMThBWnZDVGtrem0zMGZSaFJCeUZhMUND?=
 =?utf-8?B?aHdDczhjcmV4R0dHZGZnTEg5V3BveWRxbHQwRFF3UU1tc1VzUXFJbFgrUXBL?=
 =?utf-8?B?OERlUjc0aW5BdytGQjJDbzZlOTZFeTkzR2VETzczdGRacWlia1FJZzYrWUdP?=
 =?utf-8?B?WDhXZzVnOHk1VHJBVWZrNFUrbmE0VHpBdkpXdGo1ZjFIRTd2Z0RITWlkUnlq?=
 =?utf-8?B?dTI5SmhzU2p4MmpKaGd4REFCVHNxZFZYLzdjSEpkQTZvRmxZT2hJdmhZdEto?=
 =?utf-8?B?aGVjNkt0VE9Edm9GZDZzNXFnNUxMZEdkY2lhcjQwZmFRNm50MjZoRmpJT1pQ?=
 =?utf-8?B?eW1RMDhKaHBlMHBEdHNIV3cvTXVUOHBVMGJvZzBvRVBUMkpmakE1S0RxSFFk?=
 =?utf-8?B?NEh4QTcyU3dQZGQ0cXdyakJzelUxL1hNa1dSb2FKbEhRSVVrTFR6UWdkVThD?=
 =?utf-8?B?TDludUtVcmFlWEJ3dlBCcnp3ZmswV0lIUGZubVlZM3IrZmdpdWtwbzExOWN1?=
 =?utf-8?B?S093ZW5TSk4ycmZLdzk3S3JOaEhFZ1Vtd1FSbGxhY1B0UmtuSnM5TGs4bWV2?=
 =?utf-8?B?M0tWZXhWa0I0a2Jwa1FGNUpoeVkvN09CbEpVM09SU1ZVYXRaemFUV0ROUUJI?=
 =?utf-8?B?c1VLVVRCZkRwblBQL1RKRnhCNmZ4OUV6aUFKejJzSWxQSUtKSWpnY0NFSDl4?=
 =?utf-8?B?N3pmajNXekZ4UnRzRkVxYmJEMWFIZ08ycE1HY0xINkNWYWdKVmxBSXQzTHpJ?=
 =?utf-8?B?Y3d0K0FPNnVDQjdFRGFkamJ3NWM4NXphNERTbHY1VEQ5YWw0M1h0RUhCOXF4?=
 =?utf-8?B?Q29pVHVKWHQrWlN2dnF1ald0TTN2RjZ4UTVwUjZ0bmh6amwvbkt0eWZHY0dN?=
 =?utf-8?B?SXR4NFphOU1EbFlGNjBaQ2dtV2M3RWxQWGlFc2RUck51QkpodE5ReTY3TzNZ?=
 =?utf-8?B?NnhwQzdKZVg0S2lCS0lYYlJGWFVOcnB6NGhYdFowUXM4bG00TWZBZnpUejdR?=
 =?utf-8?B?OVJoTkM2Rzg2UnhpUUh4Vy9LNTFJaHJDR1BlY2pIOFRGTlpkdnZYamVqSjhR?=
 =?utf-8?B?MzdkS1hFbEsweGk4RkM2MXhvVmdIY3dwK0szTS9xZ1NYejBBMVpTdDhSNlVV?=
 =?utf-8?B?dFRDbmFRcnh2amZUeS8yQjdpSllTak5NaDFDdXJiaWxrSmVkRkJZa3FpRVJz?=
 =?utf-8?B?cTg0d1VyOUloVXVoT0lVYnFTZGlmUHM3MFFpUjAwbWlURlhVSWQvMTFMelI0?=
 =?utf-8?B?anVtMTBRdFRzcmJoeVBBSjNWNW85TnA1QVM5ak5XNHp0YXY5Zi83MlF6V29B?=
 =?utf-8?B?RS9zeUpmb0ptTDRGV0svdEtRdWNXQkNIZDdOVVBJV1dhVDJGRDU3UGRrQW1q?=
 =?utf-8?B?NGJMcC9qTmtSdThiRWJ5SVAwOGdZcjJJWEN2WVpCcUh6N1hSNHFoTzdWaVFo?=
 =?utf-8?B?OUMybEorNUZrNldSaWhKTXZ4Z3hidE1nSEdwWlphOFphRUF2aE9ZUlBlWVJk?=
 =?utf-8?B?bERRekpDNWQrOXB5ZzVwWVJJcjFldW1sZktzRWpVdWZaYzFIVmQ2NVpIdlVk?=
 =?utf-8?B?cXZlbk1yTGZtcEpEWVN2bElVZmgybmFBcjN5eEtwcVhpNVRLMVBReFltTEJE?=
 =?utf-8?B?ZXZ6SVh0OE1NV3dMQWpyUHBiaVVaMmZUeG9kc09UMWRKS2hmTk1qQkg1enNk?=
 =?utf-8?Q?6sMlgNEUHBSwEx+UofLPdo784oW7aDEn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzIwbUlyY2s3TG9HdXBCUTdaZDV4c1luZmdJNTd6Y25MNUs2WXhYZmhEUHM0?=
 =?utf-8?B?UC9nOGcrNzdVYnIvK2RxUUprOXl5WHRnV2l6bDhNMlFmWkNqdC9tRVlIKzNS?=
 =?utf-8?B?bkpIenA1djFSaENTS2I3bWxKRHc0QUxxUlhRTWkxeURlVUw3amM2TVRwSTV6?=
 =?utf-8?B?NU80U2Z5cGk4aE1DWk1DVy9lOUNIL3FlWlV5TlVKMlhmTkZQbktFdzhValV3?=
 =?utf-8?B?S081QTdLTUhoZWdQeXZPWWQ5bGttaE9pR1poTmdzTEhnQlMwTlJWaEhoMFlt?=
 =?utf-8?B?RVMrQnVGbitENUdVamNrRlFRd25TaGRsR1NIZXp0UENlZGVjWGh1TFp0M2VH?=
 =?utf-8?B?UHNRcHBuSVZuajFPN3JTNmlNOGlEbC8vSktpWHA1U0hPNFNQeEVmeGNEaVVn?=
 =?utf-8?B?c0MvRWtCQWcxWldTT3B6cnJuVS9jYzdDeVJ4dDdCTHVwem9uMnBRazBGanVO?=
 =?utf-8?B?N2hweE43Z0YvUmI1aTdyZ25ucDArMDZzck4xTEt1ZE5kcGhkdWRHaklkS0Za?=
 =?utf-8?B?TjVacnh5OVEzYndyckM1ZzNqUFYzZitOR3ZKSkZsZFg2cS9iZ3pXcnN6RnQr?=
 =?utf-8?B?VFZNdU5SR1hWSFFQUkFVVk1UbmVIejR6S0w1WDZDdlNUV3ZEVmhIRG5YZ3R5?=
 =?utf-8?B?YUxqMEFaOXlOY0JxbUc0VEZxazJMc1dIMjlPZHFsc1MrN0UyV2JjZ2NUQ2Ev?=
 =?utf-8?B?a3NSWnB2b0tobUE0T29uVGRNcEhNZ3UvbzNsMzJwWXJWYnJobDN2dThZRVJZ?=
 =?utf-8?B?Y3VhenhGU2VKOUV6cG4yOStqVmlLZTkxT2JyMERGWVZUT0crM21ZZEpqWFJC?=
 =?utf-8?B?SnBOaHZFS0FxNk45MU1MR3RVaTRaMWNqVG9jQkNlcTQ0SjZnZzFoRlpkcmZx?=
 =?utf-8?B?bUFsYkYvbWdRd0VXTnp1L2trWURkNDd1aHVJMS95MVRESG9lUnB0bUY1UCsw?=
 =?utf-8?B?N3c4NTdrSmZGQ2t4STNBQTR4NjI0RUt3Z1pnTE8reGpIWVlFckw5NXh6UHZI?=
 =?utf-8?B?VktUNVZjc1E1UElJU2FRTjBObHZ6WndSaUEvYzhEZytiQnFwQ2tvdjliN2M1?=
 =?utf-8?B?T3VDRXA2L3h3cXFRNmZRaUkyZTlIaS8waHRGb3BLa2pwZWFOQWZqS1lBcHdB?=
 =?utf-8?B?SnB3YVVUcHlOdzF2RUxxcEw4VmFZSXpDT0ZnQlRmclhPdHNpcDFXakFHTzdn?=
 =?utf-8?B?ZW9WSk5IeFRkWXVvaThnNU5NT1J0V0FkTGNIRlFtOXh2WGtTVTRQWStlbklv?=
 =?utf-8?B?QUlWZCtvVGttMVRYVmNOd3l4eTB4d1hUc0xJc0hiWk9wYjNOdng0dVRpVUwy?=
 =?utf-8?B?cW4xeGZ2MDJvYUFYejg1djRsN1k1Mk1CL1A2eGVEYjNWbU81VkpJZjd3U1Yx?=
 =?utf-8?B?U3ZQSWhhcXpsK21Ed1BqUTdXL0l4QWlWMm8zbFlBZ00xWGs3TmxObndSWWhx?=
 =?utf-8?B?TXZBK1diWVdhdjNQT01pRitQRkFnblN6dld4UTJFVWVTOEVkeEwzdnlUSWZm?=
 =?utf-8?B?dzBMSDY3NXZlRlFyTVE4bWo1UVJIRFJjeTdSVGdRaWZiU01CMGVZS0dLWEs0?=
 =?utf-8?B?bW9vRzlUMC8xTkJPN05Cc1k1dHdUUkptNk9HNWUzemREY25sN1I0YlZRLzRG?=
 =?utf-8?B?cDVVdEcrSEtvNXA4anlwMGY1TEFDTU9kZnlFSzRncjFhdkRnaFY5Y1Jrekdn?=
 =?utf-8?B?QTlKZVYrM3NCZ3hMVVRoeWhEVUg3anZPSklZMjVSRWxJck9VQkdJRlZEMldO?=
 =?utf-8?B?ayttU2hrRWlwUzNCZ2J5TVRsTVpTQnZ1SFM2eWxUdkYvM1hvS3B3Tmh3d0hV?=
 =?utf-8?B?YThKM3Y2SjB0MFZPUTAzeVdLYWR1ZFdqbzFnMjVuUEsya1pTeWg5eE5jamxn?=
 =?utf-8?B?WFExVVFSazFYWUhGdC9XMXV0Syt2UzhBUzZQbmFKUlpFMTVyajUwTDUwNnRU?=
 =?utf-8?B?RmR5VFBZdXdVdHA5UjY0TmtybkJwWFFyVUVJTFUwZ2YzM1lLc0s4UytqelVp?=
 =?utf-8?B?bFllT0x0NzhxS0lQeWlKQ3E4cE4wZGVuRW5Eek44aHNhdkUwL2lsenJuOUpK?=
 =?utf-8?B?d29VZG1MdmZZL0Q1MVM1SmRLSXk4cE9TNWJpY3JoaEV4cGowRGJ4dzhUOHF5?=
 =?utf-8?Q?KO2AKk8NhuS4560GmvWbNXjeu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4278e460-2da6-45f7-321f-08de17c5bac3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:05:14.4754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3boIbM9r4dH8KNgf838qoDei/PSr+aLx9B9NQ3oacaw2mhoYiN3Dovepm3hwU0Nz5V0FIcoTg41oWBZidfeDAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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

On 2025-10-29 23:45, Zhu Lingshan wrote:
> The pasid is a per-process-per-device attribute,
> therefore this commit implements per
> struct kfd_process_device->pasid in sysfs

Does anyone in user mode actually need this PASID? When we changed the 
PASID allocation to be per-process-device, we changed a bunch of our 
dmesg logging (and I think debugfs files, too) to report PIDs instead of 
PASIDs. So there should be no good reason to know PASIDs in user mode.

Regards,
   Felix


>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>   2 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 70ef051511bb..6a3cfeccacd8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -864,6 +864,8 @@ struct kfd_process_device {
>   	bool has_reset_queue;
>   
>   	u32 pasid;
> +	char pasid_filename[MAX_SYSFS_FILENAME_LEN];
> +	struct attribute attr_pasid;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> @@ -983,7 +985,6 @@ struct kfd_process {
>   	/* Kobj for our procfs */
>   	struct kobject *kobj;
>   	struct kobject *kobj_queues;
> -	struct attribute attr_pasid;
>   
>   	/* Keep track cwsr init */
>   	bool has_cwsr;
> @@ -1100,12 +1101,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>   					int handle);
>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>   
> -/* PASIDs */
> -int kfd_pasid_init(void);
> -void kfd_pasid_exit(void);
> -u32 kfd_pasid_alloc(void);
> -void kfd_pasid_free(u32 pasid);
> -
>   /* Doorbells */
>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>   int kfd_doorbell_init(struct kfd_dev *kfd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ddfe30c13e9d..24cf3b250b37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>   			       char *buffer)
>   {
> -	if (strcmp(attr->name, "pasid") == 0)
> -		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
> -	else if (strncmp(attr->name, "vram_", 5) == 0) {
> +	if (strncmp(attr->name, "pasid_", 6) == 0) {
> +		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
> +							      attr_pasid);
> +		return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
> +	} else if (strncmp(attr->name, "vram_", 5) == 0) {
>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>   							      attr_vram);
>   		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>   	 * Create sysfs files for each GPU:
>   	 * - proc/<pid>/vram_<gpuid>
>   	 * - proc/<pid>/sdma_<gpuid>
> +	 * - proc/<pid>/pasid_<gpuid>
>   	 */
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>   			 pdd->dev->id);
>   		kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>   					    pdd->sdma_filename);
> +
> +		snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN, "pasid_%u",
> +			 pdd->dev->id);
> +		kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid, pdd->pasid_filename);
>   	}
>   }
>   
> @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   			goto out;
>   		}
>   
> -		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
> -				      "pasid");
> -
>   		process->kobj_queues = kobject_create_and_add("queues",
>   							process->kobj);
>   		if (!process->kobj_queues)
> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   	if (!p->kobj)
>   		return;
>   
> -	sysfs_remove_file(p->kobj, &p->attr_pasid);
>   	kobject_del(p->kobj_queues);
>   	kobject_put(p->kobj_queues);
>   	p->kobj_queues = NULL;
> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   
>   		sysfs_remove_file(p->kobj, &pdd->attr_vram);
>   		sysfs_remove_file(p->kobj, &pdd->attr_sdma);
> +		sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>   
>   		sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>   		if (pdd->dev->kfd2kgd->get_cu_occupancy)
