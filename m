Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52031CE8D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 19:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C0C10EAEA;
	Fri, 14 Nov 2025 19:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZZtdhxf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31FA10EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VESTZnA1u+7zMVJZFoVUQL2Ku2SMc2KVgf2ynmPFf26fyqjmbNRxqseYimP3EMh81fP2NAkCdOVyHvxnebxWAOQEKCQKxaHL9YN+QcRc4605AIoOpbK4pE+74sqzfx7hDBe/v9x5jCUPSbj1/iGUV+k2zcJgfbswxHYTHo0Wq6R2nuLOwmL24fPpOtwlzUQoTXOBOfzW7TXUH3AhRqcFCMy7MYjmNTKU/7ROzhZUIHP9NNaPbqb66YuGrMhmKdIle/qn5Ud9U+ioxCbIRc7aw9EXVg1lsVXemdinBMsycDxMb6NaeeJnLX9+1RgoimEFGI60ZxpynBfaojTirEIpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb7HFCTJ67VYS4nYID7+686HJmOEAhojTNq3UyuA8Tw=;
 b=feygQBTM6WHto440zWSXe6WO1xn9jFrQj6ju5v8tCwqwKJpwoJOPzlDIJcmsPd5VnnW0ltO79K2FRznm0dTgcGVG0zXgfjX4Q95eJturaexL71vs1x0yA4Ja2dIouIjwQ8T7zuUKj7jbLeR3gvPtIHi/7p8j0K2Rotq1bBbq0dr5YCelvhI0L9jJWPcFWOeaaYO+wb1BkfU6MjVWudFpQqN4ipIWq/JuOglvNBRIoY3JZonNnBKNmBuuqAWJFCkGSuxmOn4Jo7Tdq5yeOF9ageIB6yIzSzSZwmewTNryjVtRGnyvCaBr4mtTgvaW8Uji6GHCDZXf2UV4cYwwZ+Rk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb7HFCTJ67VYS4nYID7+686HJmOEAhojTNq3UyuA8Tw=;
 b=OZZtdhxfNm3zHUxVFZiY00SdhfzpjWJyEmfBfycHs5tIBl83o4absTPPxqyghJEN7EMJMeta8h0BxOEOqBmSxhABXGGPJm+MOI8V5aLimaJalwBSHh1MXc5TP5FXU1TThKKU1gunrBD3cKcJhFjDCmFtDxXq1bzz/TtOw543nZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 19:20:19 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 19:20:18 +0000
Message-ID: <5011e056-1496-2b90-2bc1-71a0de24b792@amd.com>
Date: Fri, 14 Nov 2025 14:20:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Uninitialized and Unused variables
Content-Language: en-US
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251113161014.1118443-1-andrew.martin@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251113161014.1118443-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: e86a6b94-7132-44ad-fb9c-08de23b2d90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1czTG9DRlJYakZKYmNGZWY5dnI3czUvS2VubHlYY3RuYm5WNlMrbDJjdkt0?=
 =?utf-8?B?RnBtMzNLQm9zdC90LzRWWGhtalI3RHlCYXZlb3JDVEo0d2tZd2s0M0Q2Qm1i?=
 =?utf-8?B?Z0d1SVY3SnRXQVN4WmQ5dDhZRjF2aVVMNTl3T2gwRitHSnJ5bTk5N21pVFVs?=
 =?utf-8?B?SVBvb2hMY0NJKzNEVmFsWXgzcnNJdE9zSjZ4bUR1emZTcytKaFNUM3plUjgy?=
 =?utf-8?B?VitKdDNCUFNqK0lRaGVHek40dnJsc3Fwb3lIeHZOWWF4QWlUd0NNd3Yrdkx0?=
 =?utf-8?B?cDVRcEloYXBlb2NsK1BaN1I0VmlrblA4TTM2NTdPcEdVMEtqaE9RUGdZZjJR?=
 =?utf-8?B?WFp0L0x4K3ZVdlI0M3lJUktvUko3WE5xNjJoYWhxd3ZlWG1GZW1mNUNGZHU2?=
 =?utf-8?B?UjZVVFJXOWV6UDhsdU9XaCtLbE1DK3BYU1VwSk1JR3ZOVHcrT2ZGdUN3NkNK?=
 =?utf-8?B?elNBVm9zTzF2T09Icyt0MjJzTTB2ZWdML1Zhd3ovR1Z5RkpuMWhIemFEN2pL?=
 =?utf-8?B?dGxpSXZ5bDN4MGpWL0FKSTZUaWpXNzRaeUlWOXNtWmN0NDhTdC9PeGpwc01J?=
 =?utf-8?B?WjNSalhpa3pET2xMOFpUTmxPUlE5U0t2UU1MM3BOVldJbFk3SVczUTd3VGhG?=
 =?utf-8?B?KzhJTEZpd2VhdHdKSkZKbTY0WFQ2Y3huZHVEeSt6RGdaRG12dDJkTnYwOUh2?=
 =?utf-8?B?Smc0dDA4ZE9ET2c2Zk9RdzA3UkNBSnlEdmRtMWQzL0hZbXA3a3F5dWpwWG1m?=
 =?utf-8?B?QnA3RFhub3cyQnFLL3pLMWpxRVROWjF5Q0hBRW10YlE2NUh5MHJrZmx1NTlj?=
 =?utf-8?B?UmttSEZEZzJBTHQyZ1VZeGV6WDRHUE9YTm02WmxOVzFSdjdyQlpkMFhUeDZD?=
 =?utf-8?B?by9NSEw0eXZWNzBXdVAwdEhySWZoNFFHYzNmMFl3a3dzRWo0YTlhM1VkOVNM?=
 =?utf-8?B?OTlrT2ZHLzJyKytTY0FhYVFiSnhwWjgwWVJWdjVqZ1BVOEo0RkF1enpBZzFM?=
 =?utf-8?B?eUNHRU95dDFKQXpYSjRjd3oxWDF6T1IrWHUvUkF5d2s5bFBFZFFmWlFPbThn?=
 =?utf-8?B?NHJyRUhPMUw4NHBVbXNqVEpHeFVXMWZkWU1QQ0FoR2lzK0dHY0gvZTU4QTBD?=
 =?utf-8?B?bG9pdFF0ZThwaFA1WDE0UHVUTE9zaVUvZnVmV2FyZ3NLY2RQSTBLZ2p6c2NK?=
 =?utf-8?B?ZTFzOXJ3blArSktCTEpCdnE3NTMzWGhPOGIxQ1NkRDhUVDhPWks0VzN3MjZk?=
 =?utf-8?B?WmNyb3RBVDFWVEtkVEYxMFhzb3ZQUWF5ZDJyU1NwNGY4K3hiN2pHYWlTM3BN?=
 =?utf-8?B?YXlNMVhTM2s2YjBSNlFjcXYwc0svbnBGU2Rkc3Q4d2o4VkhKRlozN3A0L0hP?=
 =?utf-8?B?TXdRT2FNMXJwa2psbUZNcW5PSEpKUkhxN0s3S2w3RjNrMGZrc1hHb0RIR2VS?=
 =?utf-8?B?Q1FFM05KdFlhd0JTWEdZL1NvUHd2MGkrUllRZlR0TGYrK2lINzhpb2gwS0h1?=
 =?utf-8?B?dmp6T1RWdlNKamgxNEhGSVNZU3pCYkVYQk9paFgvM3VuNDZCU2VmZm1wZ0No?=
 =?utf-8?B?TEIvSC9BZXlZbzlXc3g5TzlaS2p3L1oyRUJSdEx3NEFjdkdlUlovQVBIM1Nj?=
 =?utf-8?B?MTZSM2lKQzNSVGptdEk0d0hmYjFWNTZuQnNOb3dvbGQxeGZNdlk4L3VRUTNM?=
 =?utf-8?B?OWxyQ2hnc1pPeVVvSXFmV3RXcU14OThlZHFDelJkUldrSld1NUVxamJzUTlI?=
 =?utf-8?B?QytkS3J5czVHeFc5cGZUUCtOOThnWnYvQklLSk14dExOK3loYzYzZXl0VFMy?=
 =?utf-8?B?RHZOdXNjTHNTMURabzdsb3BoSVFOSEtSUlpxSE9CQmxNNVVhRkg0WmRNZGF5?=
 =?utf-8?B?L1dKWVBUbCtDQ1RuRTVnY0NOYmFheFU4eFJjdnhXWEpGTWx2R1VmZFk5TXBX?=
 =?utf-8?Q?OYm5GnwEiUuUp5wC3pafvHAeCraafhW6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDVaMXVNZ0xya3lVUjFGZ1B6cjhwanNaZ01CbVJETXF1TzVpbHlLaDNGNDlK?=
 =?utf-8?B?M2VoSVhJVEhMZUM4T3orSkIyTnAwaEtqMmlYTXlQOS9vcEwxc09scnpmRHRp?=
 =?utf-8?B?N2RkNHRnRWt2ZE9yaEFuQk5TeGlkQ3B0emozSWJrMytIODV2dlhVeEg5SU9k?=
 =?utf-8?B?aUtMYlpWMHRGTENKZWxueWxFUG5yK29JbTcxR1NnbDZGWUV0L09TeXFFdmxF?=
 =?utf-8?B?YVdVM3BDOWRvTDFYdG5MMGtLaG0yZGM4dHA4ZXhkMTBkU0tqcS9WTG1HaGFh?=
 =?utf-8?B?SFNaS21kTUdvODM1RDQ3Mm1YYkwwZUhaUHFXU3hBZmt4UnErelo0WWRUUkFl?=
 =?utf-8?B?MGVuU2FIaTZxWVJhZ2l2RlZXNXlDTVFMdUdOR1BNUWNRY2hPaWgwWFFYSVB0?=
 =?utf-8?B?alBadGpoLzYzZWF4bU9zZzRBd2UrdTlEZVN4Rm1sc1ArL2RmeTlDTHNRcjNh?=
 =?utf-8?B?T1hibm10NWJmcXRuSnJiKzJ2UTc1TzJKTjF1bERDczRoemlTV1lCNWpGYkNa?=
 =?utf-8?B?bGozbjMxZzVBRTRpUThwSDF6ekZaalVkSmxGOXdUU0xDd3lkRXRWSU1ycGNN?=
 =?utf-8?B?c0lSc3BnbnE1TVB0TnVzVjRVeERYcUNnbGRGUi9qbk41YnRxZWdIQW8wdEFv?=
 =?utf-8?B?a0daeUVVVGZ5aytOMG5XWTVDaWJQMmNpTkREa01ZdGZIa1lwdWlrOXByOWNM?=
 =?utf-8?B?Vm5ibGljODJUa0pTUHI3YlpBbUFyWk9QS2h4ekRpa0E2N0pKd0JEUjZWVXFZ?=
 =?utf-8?B?VWJEeWt0Uk9lMEFIaWl1SXlEaVp2L3VlNytMOWRSazJRVEljWnBrREg3YXp3?=
 =?utf-8?B?M3R2UmFvM1lEeHR4MFVJblVDWXRRVkxHMXFjcDYvdG1XSTdsSHlneDJyUksr?=
 =?utf-8?B?TE1QRGMzOW1XVmN5OWMvWTNFSnhwd1JDSkR0UEhlTmlBWUhwU0V4YncyOVVi?=
 =?utf-8?B?czRSbzU2MVBqMHJqYkVRWU95ajFCWjU2L05LTFV3ZFZFUmNydXdZRHZPOXdZ?=
 =?utf-8?B?VDB3SUNGTEhmcDlRb1VZNWMwYUFxTnRzeCtQVjZ2d2JEZjg2UmZGUlowbWhQ?=
 =?utf-8?B?L3JJNG5EWWpTRG9zTTJHNVhhUk80RVVhZmlIaUhJMkVrcDRFclRTeWcyT3pl?=
 =?utf-8?B?VG41ZVZqVjJBQTZycjVNT3M0MWZWMlc0QStxRVorSVVPUlczTFhPS3lEbFRI?=
 =?utf-8?B?eWszM0syVEh3WXpvYm9ualRJSmYzdmIyNUF6WEVKSjBoVFQyZ1BhY2dPd1gw?=
 =?utf-8?B?Y3FqdXptdzVnQWpqaTNKTCtzdWwzUGtsNGUxc3VoVlJHR0huR1FFNHp2YTZT?=
 =?utf-8?B?Q2llditIYURQUHpDLzVRMmpKTXVWUlZZdVJVcXZEYkFuN3BVc29ubG45MGha?=
 =?utf-8?B?djMxZmxwbHFVMzNwUWFZRFJTQnd3ZXpwTnFQVXRUVWVuS2VaeXkreDlwbm9M?=
 =?utf-8?B?OWpsY1pjWVhJWDhJRGdRaWxJUXh1UVB5ajBKbkJYcFA4YmhpNjVNVi94d0Ew?=
 =?utf-8?B?WHBqK2pRSWZnRm5peHVjV0UyaUE1TytWTXkwWFVFMEgvQmRTemY4SEY5VlU3?=
 =?utf-8?B?ODlydFpNVFhPNXRsMWRKQUlDMFRTb1ZSenJNK2d0cVJaUmZtMjZtdFMybDkw?=
 =?utf-8?B?TDd3VFdmVWdMMmVER1dLelNkRkZXckR0OGEzS01Sb1RZT3VwV0hhQWxCc3dW?=
 =?utf-8?B?K2tJdmM4aDZtN0NDQS9rOGFVZjZablBSb0ZURUFGVzRFWnRIVWtSUlFDU0JD?=
 =?utf-8?B?RW9PUmFOTFpCR0l2TEVtTmVJcmVGRXlrdGNvcHlTaEl3VTI3N1JSc25lR1hW?=
 =?utf-8?B?UTljODY3T01PTjR5MnYrY294eUFLd3ErM3hhSzZiOXBmNi9NMmIzR2hMT1Jy?=
 =?utf-8?B?WDJrKzhISkxxZWVzNERrV3FaMUpWdDk0NGFQOU5ja0I2OWc1YnUzdFpmME1I?=
 =?utf-8?B?THM3VjdMVEh2b0lnQlNreEhMbXlVcElibzdXZnpJdzFuWisrNlVIcjJwZ1RM?=
 =?utf-8?B?ZEE0bDQ2MlRpMVpyNzlLKzlkemtaK2l0bFhxUjkvWUdhSS9qRDA1bDZpMmVh?=
 =?utf-8?B?WXJRb0ttTzZoaFJmbFRXSVBZTVJXTWt5WmNBUHhjTmdLN1kwUVdJNWg0bm5M?=
 =?utf-8?Q?nrIA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86a6b94-7132-44ad-fb9c-08de23b2d90a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 19:20:18.7263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1boh1Dowf02sOJLkBrKFxYwWpVoO2WzsDZSxABXFibgSO1jEQ2eak57Bkg0xjYO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544
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


On 2025-11-13 11:10, Andrew Martin wrote:
> This patch initialize key variables and removed unused ones.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  8 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 38 ++++++++-----------
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 ++--
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  1 -
>   5 files changed, 24 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 22925df6a791..a72b242e2e73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1506,12 +1506,12 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>   {
>   	struct kfd_ioctl_get_dmabuf_info_args *args = data;
>   	struct kfd_node *dev = NULL;
> -	struct amdgpu_device *dmabuf_adev;
> +	struct amdgpu_device *dmabuf_adev = NULL;
>   	void *metadata_buffer = NULL;
> -	uint32_t flags;
> -	int8_t xcp_id;
> +	uint32_t flags = 0;
> +	int8_t xcp_id = 0;
If amdgpu_amdkfd_get_dmabuf_info return 0, dmabuf_adev, flags, xcp_id 
will assign valid value, otherwise this function exit, those init value 
is not needed.
>   	unsigned int i;
> -	int r;
> +	int r = 0;
r is used after return value assigned by function calls, don't need init.
>   
>   	/* Find a KFD GPU device that supports the get_dmabuf_info query */
>   	for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e9cfb80bd436..43e97b5b3b5d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1059,7 +1059,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)
>   
>   int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc)
>   {
> -	int ret, i;
> +	int ret = 0, i;
>   
>   	if (!kfd->init_complete)
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index d7a2e7178ea9..26f1d25538a4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -203,7 +203,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct mes_add_queue_input queue_input;
> -	int r, queue_type;
> +	int r = 0, queue_type;
no need.
>   	uint64_t wptr_addr_off;
>   
>   	if (!dqm->sched_running || dqm->sched_halt)
> @@ -273,7 +273,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   			struct qcm_process_device *qpd)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> -	int r;
> +	int r = 0;
no need.
>   	struct mes_remove_queue_input queue_input;
>   
>   	if (!dqm->sched_running || dqm->sched_halt)
> @@ -624,7 +624,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>   				const void *restore_mqd, const void *restore_ctl_stack)
>   {
>   	struct mqd_manager *mqd_mgr;
> -	int retval;
> +	int retval = 0;
>   
>   	dqm_lock(dqm);
>   
> @@ -853,11 +853,9 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
>   				struct qcm_process_device *qpd,
>   				struct queue *q)
>   {
> -	int retval;
> -	struct mqd_manager *mqd_mgr;
> -
> -	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> -			q->properties.type)];
> +	int retval = 0;
no need.
> +	struct mqd_manager *mqd_mgr =
> +	  dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
unnecessary change.
>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>   		deallocate_hqd(dqm, q);
> @@ -912,7 +910,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   				struct qcm_process_device *qpd,
>   				struct queue *q)
>   {
> -	int retval;
> +	int retval = 0;
no need.
>   	uint64_t sdma_val = 0;
>   	struct device *dev = dqm->dev->adev->dev;
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
> @@ -1141,7 +1139,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   	struct queue *q;
>   	struct mqd_manager *mqd_mgr;
>   	struct kfd_process_device *pdd;
> -	int retval, ret = 0;
> +	int retval = 0, ret = 0;
no need.
>   
>   	dqm_lock(dqm);
>   	if (qpd->evicted++ > 0) /* already evicted, do nothing */
> @@ -1266,7 +1264,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   	struct kfd_process_device *pdd;
>   	uint64_t pd_base;
>   	uint64_t eviction_duration;
> -	int retval, ret = 0;
> +	int retval = 0, ret = 0;
no need.
>   
>   	pdd = qpd_to_pdd(qpd);
>   	/* Retrieve PD base */
> @@ -1443,13 +1441,12 @@ static int register_process(struct device_queue_manager *dqm,
>   static int unregister_process(struct device_queue_manager *dqm,
>   					struct qcm_process_device *qpd)
>   {
> -	int retval;
> +	int retval = 0;
>   	struct device_process_node *cur, *next;
>   
>   	pr_debug("qpd->queues_list is %s\n",
>   			list_empty(&qpd->queues_list) ? "empty" : "not empty");
>   
> -	retval = 0;
>   	dqm_lock(dqm);
>   
>   	list_for_each_entry_safe(cur, next, &dqm->queues, list) {
> @@ -1479,7 +1476,7 @@ set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
>   			unsigned int vmid)
>   {
>   	uint32_t xcc_mask = dqm->dev->xcc_mask;
> -	int xcc_id, ret;
> +	int xcc_id, ret = 0;
>   
>   	for_each_inst(xcc_id, xcc_mask) {
>   		ret = dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
> @@ -1831,8 +1828,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   	struct device *dev = dqm->dev->adev->dev;
>   	int retval, num_hw_queue_slots;
>   
> -	retval = 0;
> -
>   	dqm_lock(dqm);
>   
>   	if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1981,7 +1976,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   			const struct kfd_criu_queue_priv_data *qd,
>   			const void *restore_mqd, const void *restore_ctl_stack)
>   {
> -	int retval;
> +	int retval = 0;
no need
>   	struct mqd_manager *mqd_mgr;
>   
>   	if (dqm->total_queue_count >= max_num_of_queues_per_device) {
> @@ -2389,8 +2384,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   				bool reset)
>   {
>   	struct device *dev = dqm->dev->adev->dev;
> -	struct mqd_manager *mqd_mgr;
> -	int retval;
> +	struct mqd_manager *mqd_mgr = NULL;
no need
> +	int retval = 0;

no need

Other changes look good to me.

Regards,

Philip

>   
>   	if (!dqm->sched_running)
>   		return 0;
> @@ -2784,7 +2779,7 @@ static int checkpoint_mqd(struct device_queue_manager *dqm,
>   static int process_termination_cpsch(struct device_queue_manager *dqm,
>   		struct qcm_process_device *qpd)
>   {
> -	int retval;
> +	int retval = 0;
>   	struct queue *q;
>   	struct device *dev = dqm->dev->adev->dev;
>   	struct kernel_queue *kq, *kq_next;
> @@ -2794,8 +2789,6 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   		KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES;
>   	bool found = false;
>   
> -	retval = 0;
> -
>   	dqm_lock(dqm);
>   
>   	/* Clean all kernel queues */
> @@ -3464,7 +3457,6 @@ int suspend_queues(struct kfd_process *p,
>   					else
>   						per_device_suspended++;
>   				} else if (err != -EBUSY) {
> -					r = err;
>   					queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
>   					break;
>   				}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index f2dee320fada..2e9b6bcf2704 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -596,7 +596,7 @@ static int hiq_load_mqd_kiq_v9_4_3(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *p, struct mm_struct *mms)
>   {
>   	uint32_t xcc_mask = mm->dev->xcc_mask;
> -	int xcc_id, err, inst = 0;
> +	int xcc_id, err = 0, inst = 0;
>   	void *xcc_mqd;
>   	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
>   
> @@ -620,7 +620,7 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   			uint32_t pipe_id, uint32_t queue_id)
>   {
>   	uint32_t xcc_mask = mm->dev->xcc_mask;
> -	int xcc_id, err, inst = 0;
> +	int xcc_id, err = 0, inst = 0;
>   	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
>   	struct v9_mqd *m;
>   	u32 doorbell_off;
> @@ -818,7 +818,7 @@ static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   		   uint32_t pipe_id, uint32_t queue_id)
>   {
>   	uint32_t xcc_mask = mm->dev->xcc_mask;
> -	int xcc_id, err, inst = 0;
> +	int xcc_id, err = 0, inst = 0;
>   	void *xcc_mqd;
>   	struct v9_mqd *m;
>   	uint64_t mqd_offset;
> @@ -848,7 +848,7 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
>   	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
>   	uint32_t xcc_mask = mm->dev->xcc_mask;
> -	int xcc_id, err, inst = 0;
> +	int xcc_id, err = 0, inst = 0;
>   	void *xcc_mqd;
>   	uint64_t mqd_stride_size = mm->mqd_stride(mm, p);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index a1de5d7e173a..8321dd01b67a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -174,7 +174,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
>   		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
>   				engine_sel__mes_map_queues__sdma0_vi;
> -		use_static = false; /* no static queues under SDMA */
>   		break;
>   	default:
>   		WARN(1, "queue type %d", q->properties.type);
