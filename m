Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923D7CCF9E7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 18:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A9210E069;
	Wed, 25 Sep 2024 18:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GQcMUjX8";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA73310E069
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 18:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDrtQrknLiPiUzSL97qLTXxLYZx6stMo8TjKgDZA3ESSkWtmeTqkjTIR83kdNuWy/3eQ/PVmdmfifB5Xb74C6aDMw2AQc07dfMObQHwVeEV9uoAMQtxndL/8GyKkU6moputVwav2ecabXbWXXAyvFK0pVpawTFSAxCV5ijhKYCmdNnxbYo9jyG+gHbgri7BHYWNRiuJDZQR3pXyeCkkfmMIpkW407/tWQ+S7nh5+puknSVibGlhr3nJGkZ10BB6kLyaTGzF9hKitr0BCK4WOdSmawJB4spVsBzPSRThdHtyoQAsNTMxn70lY0906AF5fs63tNYwsjVLGwEOBYZgakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDxYJTvea5SFyRHBDaS/7EDrbKNEUcP8XMvznv2pfIQ=;
 b=VrsuvPJHChmPPd0aOi6IT1yShJigEXBwJApH8QJpmfm/1OQ1zdMBY16iFY/TVqCmXsNITwgHXJs0ZKwj8TI9Zl2zffcPsPEb6Rr/PFPxkVbevg8Wl6T8I+AR+aBY/j0NnNgpwrJwFmxBZPS7q0IreLx1qkq7TmUJZJj98FaDJnMwMPWYxtmnzQmxjqex3ih+bwdojW/EqAqPGjrtNOhwGpBE/K9qR1OSka37J3lLxx5lZ0tX6AAMCqbyLnD99Dxh+S+/AwZZLfgBaUXHSO8fPjP8Bh6JCrm8C7Z/bEBS1xo41JEyG5jDWbtQgQcMycFLTL1ijYkwmpVQPRYqXsGIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDxYJTvea5SFyRHBDaS/7EDrbKNEUcP8XMvznv2pfIQ=;
 b=GQcMUjX8hjLNI3m+Q5F6msb1sYW+Adz3X5HJj/ujihlmw7StilvZl0ndeadrP9gVDJ/pcWgl0fdzsJ+P/faklfSUs0uhih4dCpzx0/vbS6zPUZAUfjzSUIWAC0G7mhJC7/jlv/XYNW7LQtnmTl/rQvjKxB5GvSDqfOasECx3Vt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 18:46:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 18:46:03 +0000
Message-ID: <dca54c7c-22ab-4811-a49b-41779df58450@amd.com>
Date: Wed, 25 Sep 2024 14:46:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Remove an unused parameter in queue creation
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240923091117.13949-1-lang.yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240923091117.13949-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0384.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e42456-46d8-4d24-afde-08dcdd924e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTVIeGM2MmtBb1hFaFlucmRzMUFITWVRd05zclVSSzIrYUgwWmQzRXBpS25h?=
 =?utf-8?B?a2lBU3Z2QU9DM29kQ0VoRGxUSVZtcFdIYlk0ak9RZGU3SEwrOVc1amFVMWVi?=
 =?utf-8?B?SmpnaDljdUs0ZG8wb00rWHYvSHZPWUVxckpJVGNCOFNpSWtJOFdvNE9MekFI?=
 =?utf-8?B?ODRLcm83Y0R5UzZyRHEvdDZqWG9ieUgyM09LOW9oTk81cW5QMEwvWWZ0dFRL?=
 =?utf-8?B?WDRZNnk5aW9nTC9BNWJyeGhTVVVKNFQ1R2x6NVhaMGVpR0hEdFRFWEZRUGFO?=
 =?utf-8?B?MnpDbVB5cC9IVEFFcG53WVRFcXFrWHY5bks4UUVpb2hVQlJzMEtWa01ycktu?=
 =?utf-8?B?R2JSTzVqM09za3hmQUdSSzhEMFdGOGp3c1F2aytld2VPWEhHUEdadlBqbWZT?=
 =?utf-8?B?Vythd1ZBcUdQWFgyRXNQRFFJRitmVlhvTVU0YlNFT0RCYkNmSzFnS1p4TVlJ?=
 =?utf-8?B?bVNVWW1wM3R6VGFjVWRyd0UxYjBTaHRVUVd2cU9KUCtRZkU5VDRXSGY5YmNI?=
 =?utf-8?B?TVVGV2N6emRtRTQ1K2RHRHN4cUJmQnY4UHJvemNyNkZ4OGZHNi9nWHFIclU5?=
 =?utf-8?B?TTVqeG1jSHl5Qkl5L2ZlWVVkOTBxTkNwOXVCaEFIOGl4dFZFWG03WXd4WDda?=
 =?utf-8?B?SlNrcDROZGdtZjFHdmhDMk9OdnpIVlFlNC9sSDd4Nk9nSnhXTDV1eFZtT0Mx?=
 =?utf-8?B?YlhjdkJxVktBVWg2N3Eza3huUUdDanZqd3ZQdmdDOGJuaDJSTmdBT3lBelhJ?=
 =?utf-8?B?VmJId1pDdHRPbG1QOHI3WkNTeHFmSlNoMFlHaEMwUXliV3RXdVBxd1VrOUJG?=
 =?utf-8?B?OERTVmJnclM3aUtxRWxyN1NpbGY3WUpodkxyRUxQZUx3eVlNVGRVNysveXFp?=
 =?utf-8?B?RmE1OVM1ZDBRR3VsVnloTERWM3BwdTg2ZDdtdDB2eGJmL1VuOHhrYVp3T3dn?=
 =?utf-8?B?VTV3c3pjd2YzT0F5akRRcGZobXJuTVQ0Tlhxc2VRdE9ZYlcwTW1IcFdCSEdm?=
 =?utf-8?B?bytmR29rUzBVRytPMFM2SUpQa1hIblhXOS9FTXE5d3BtcVpvelVnV2I2RnNQ?=
 =?utf-8?B?K3R2eFl3bjQwdCswdFEvM0JxdGd3Z2NSMjFUM0grN2ZEbTRQaXpwV21Ncm5K?=
 =?utf-8?B?Vzl5T0V6ZjdZOVFodHVLcFlDWlhPb1krVzRHL2NhSkFBcDBqTm1hMDh5RTVQ?=
 =?utf-8?B?YmxCcjRaQzRaZWJCRDBGcERIOEw0ZHZwL0tPRmNNeWRtVHFOU0cxSWg2cEVL?=
 =?utf-8?B?VXNGWFFiT0hLM1g5RlVVUGpzWXVXcTNFcmtTT1MyUkUveUtmUGdtTTFhdGZk?=
 =?utf-8?B?NEdtbXZ5VThiTjFEa0d4MmJ0OTBvbWZGNmYzbTBmNGVLRW8rcHc1QW1PemVh?=
 =?utf-8?B?SVE1dXd3K1JNVXJXMStReWdSZUJBcWtKY0M2V3RCTys1NjBPMy83NEJ5dTk0?=
 =?utf-8?B?djM3UW1OTkdEUWxNSDFkbzRHeHRSNGc2a0JvS3ZhVDQxcDB1d20reUZQYWNX?=
 =?utf-8?B?Tld3RCsrcGJ4M2EwWFhXVUR2aDExV2R1bkFqR1htakVFOVg2S3dDWk1KbWE3?=
 =?utf-8?B?MDVrTitqM3F2bmdPME5MQ1Bud0tVd1A2OThVOW9xeXZybE11blpPS2l3V2tt?=
 =?utf-8?B?SEYyTUorSWpDRnYyWjZmOTV2WHpkQzk1L29NRVE2bjRxL0drRUx6aEdjaHJJ?=
 =?utf-8?B?V0VDYzlLUTlCODZMYStPUWZROTFFdHFvdHh1bHhaOHMrVFFNdUtLTElBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHJkMkhyR1NPeHY2WHVySXdWTGtLVHl0ejUzOEY1ZFpydFAzRngzeERKUUls?=
 =?utf-8?B?RmVPSGJvR0gxUlUzQUlQbnFXbVVRRWZIdkhnTUhGQVlTc1BEeDR2K2prVFB6?=
 =?utf-8?B?V0VJa1BUaTcvV3FxM29LVlBkVHdidWllOGxieTZEa3hQaGNFSDAwb0RwYkcv?=
 =?utf-8?B?NnBxclpHWkxHbHphN2xuMi9SSVdrZTFydTc5bFk4ZnlqQzRWRlN0bExVSUdn?=
 =?utf-8?B?R01LaWhydHJ5TFV0dEVGV2JkbHNQSWkzcUdPRnZoYjZaVDRKZWo4Q1ZCME50?=
 =?utf-8?B?RnFSMEJ4WTVrTTJGbGVvcVBQMVFJbW1NYWdyNjlyeVZNQytWN3pxNWsyN1ox?=
 =?utf-8?B?YkVXSk1lM0NWNjVZNHdlMDlRbjBYOStORC9LZU9mdkpFb2krcWxtdk9ObDdv?=
 =?utf-8?B?cHVHK3NYMHFkZ2FQQUZaSFJZOUlMNVhCOWN5T1U5dlR5OGFmNUZtSitKZm5l?=
 =?utf-8?B?Zmo1aWp3NXRnaXppbWlzODF4ajFIUG5ndEwrWkdndy9BZVlCbUZjTmZSQ2RX?=
 =?utf-8?B?eTZHYlZQb3hieDFFcFJob1lOU0lZQTUzeEZoREQrd3VUbVRaakxoZnBZa1dM?=
 =?utf-8?B?a2xxVkF3R1pMeXpoQlhVa1JEYUh2NG9Bd3E4ZnlMSlJsd0x5Zi9xanVrYTAr?=
 =?utf-8?B?UDlLblNnL3lickh1OExlYk9FMFp0NGZheFo1Q1duVEpNQTRjdU91NEVPclRG?=
 =?utf-8?B?MFVjL3diM0d4dGZBUCtndXUzWE5YbG5PN3dqeFo4Y1ZCN0J1bGhUdkxRREhL?=
 =?utf-8?B?VzVEOWliMkd3b3B0L04zcUFIYTF0dDlSdi9ZeVYrSVFyd1Z0TkFxcStJWTdn?=
 =?utf-8?B?dk1YbmFINXBXeWtxcmJ2QkR1L21HY3B1ODJNVTRXMTdGNWJXSkpLNWxTeEkx?=
 =?utf-8?B?Y09LdnBydHQ3Q3Ywbnpad09DSWVock91Q1IxY2JxRFpSZ04xTXN0V3VPeFhJ?=
 =?utf-8?B?UXhVck51SVFSQnRycUE3elorMnUxUGptRU9XTUZtQ1VIVWFtQ0dhL3V1THJj?=
 =?utf-8?B?T3NuK0x1aUtaNk54K2VKRTdWa05NR3JyL3RFZDZmL09ySTFCTzNrOThmMHJs?=
 =?utf-8?B?UnJCc3gwZjBWQ01PdGM5OGxPRnc2dWlxdVFEUk5uRURBcXB3VWkvbnBzejZP?=
 =?utf-8?B?NWlpaVI0bjF1WUdOUi92VHYxODF1SXErM1pBcWJyYll4dWN6bnA1MnNnbnhl?=
 =?utf-8?B?VlRBUkRUNUlUSWJkTFN1YTNTNGptdHVsekxYZGRDb2pvT21wWmpQSytrMkY5?=
 =?utf-8?B?OFh1MEpJUmI2aHlDeGJGNWxOelltS0QwaUpBYkNUWHdPRmJDa2Qxalp4U0sy?=
 =?utf-8?B?b2JlQVJJUlJyZm1TMUFHY2lVMUZnQTNpQlNNQktEcGRWM3dRTnVjL2Z1T2dC?=
 =?utf-8?B?VDBFVi9XbTRQSU01K25INGhMd3lvSiswWlJuUjlxcnJtVWVnMllLUk5jVnA3?=
 =?utf-8?B?OTVrN2QwdWN4cVYwbkhFME9kVFZ3bkZyVEFXTlcvNEg4R2NNQ2FJRmVqU2hP?=
 =?utf-8?B?U242ZFVBTVd5eFJOVjNpVzdqcDFrbW81c3lmVWtaUi84MHlZaXhDeEJ6Skwv?=
 =?utf-8?B?Q0JLdTBXcm9hOWo0WlI1L3dYbTk3eDUrbUN1U1RZa0txRU9SNGlmZ3BLRWxu?=
 =?utf-8?B?U3NZWWRqZjM2TzdKYlJVSG95d1kxWXIvTmxmQzQ4TEg5VXZZcGZCQmFzaWNT?=
 =?utf-8?B?OHNNL2k0VXNkc0xpVkdQV3FnQXlqdThzdms4eGFDVW9lbDFBcElLYy9wZjF2?=
 =?utf-8?B?K3RmOVpVa1ZPL0pVanF5SjlZUFMwTzVMRSt0c1pRVUQ4NzhCNmhkQ0lUOUx5?=
 =?utf-8?B?VlF6cDd0TktRNmYrQkgwMTlXL3hROGFlbGFNemlRU2h1L1dCQmJjU1VjRnd5?=
 =?utf-8?B?d0pKWjN3WndRTGlBTGtSdjdvQ0ZNQ0pIdXdOeGE4YlU5WUVvWm02Vkp3NGs1?=
 =?utf-8?B?TEw5NTYrVVRqSTlpSVJxMzlsdnRVOS9sWEtwV2ZMRm1TWjQyTFRLSWhzRlZn?=
 =?utf-8?B?ZEY0UnNrZWN2UTJPL3p1eUZSa0RrSXZadmFxcjk4TEVlVDY5TUl0VksyY05y?=
 =?utf-8?B?TWZGMWRSUnplR0lvcWNIcEJzelpVY1BKQWlpTWhORk45WXhOb29VSUorOWpT?=
 =?utf-8?Q?mYVKMooff65sdkPz9c0a4EJtQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e42456-46d8-4d24-afde-08dcdd924e64
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 18:46:03.1285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AThZN+Jdd86HxWyywwycrkPy6vTrkx+yHdA9IHPNR277pAAIkKfpJif2PwF+PcZagbn3KRbVIHJyFagdNntKhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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


On 2024-09-23 05:11, Lang Yu wrote:
> struct file *f is unused in queue creation, remove it.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 ++++------
>   3 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 9044bdb38cf4..a1f191a5984b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -365,7 +365,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   			p->pasid,
>   			dev->id);
>   
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
> +	err = pqm_create_queue(&p->pqm, dev, &q_properties, &queue_id,
>   			NULL, NULL, NULL, &doorbell_offset_in_process);
>   	if (err != 0)
>   		goto err_create_queue;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d6530febabad..6a5bf88cc232 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1347,7 +1347,6 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p);
>   void pqm_uninit(struct process_queue_manager *pqm);
>   int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct kfd_node *dev,
> -			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
>   			    const struct kfd_criu_queue_priv_data *q_data,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 01b960b15274..c76db22a1000 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -235,7 +235,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   static int init_user_queue(struct process_queue_manager *pqm,
>   				struct kfd_node *dev, struct queue **q,
>   				struct queue_properties *q_properties,
> -				struct file *f, unsigned int qid)
> +				unsigned int qid)
>   {
>   	int retval;
>   
> @@ -300,7 +300,6 @@ static int init_user_queue(struct process_queue_manager *pqm,
>   
>   int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct kfd_node *dev,
> -			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
>   			    const struct kfd_criu_queue_priv_data *q_data,
> @@ -374,7 +373,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		 * allocate_sdma_queue() in create_queue() has the
>   		 * corresponding check logic.
>   		 */
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -395,7 +394,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			goto err_create_queue;
>   		}
>   
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -1029,8 +1028,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   
>   	print_queue_properties(&qp);
>   
> -	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
> -				NULL);
> +	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
>   	if (ret) {
>   		pr_err("Failed to create new queue err:%d\n", ret);
>   		goto exit;
