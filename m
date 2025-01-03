Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3240DE77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 23:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93FE10E96F;
	Fri,  3 Jan 2025 23:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/EHidCv";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F5B10E96F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 23:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAeAXVtgxkRaDSz4LeB/0XtShKF7dzX9hK3bmRTXxzF2UrxY6n4PYVMduyjuQPtPGqPAXWUnqUIo0F99md5tT2yRL+c2zAV165jtbL8IFpHmfDxoQ7uI7EpBaAgR0LLvHhlbuvTGPeWFl4QBQ/hqX9akdZykxIOKu2Gzm7seK9fN+e2iMZN6gSBL2Jwcefyq8DhwqbAyMJVXCUsedu3ld5iyV5ygttFMhdJ5NnVb2ajNShbZ4MBMr4p9gRDBbHYxN7Epbd5DJvAVsu5lHwt6LjjLAaj89XZIfvx7GvT+QzuPL6NghIDinnX4qEkq4taDFLeHuqROMDMXBWF8/4a15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wNhOR9kPxokwPkr70jQOY6lCXJ/ynMLzpEaxOx+hSo=;
 b=WZHaL6HLlF0u7U8RWptnZXjJr/+FlJq9a+x5k2RgW0VBVEm7F8ahobnxKhQtqAOrL5tfrF4SWKnHAjrdLcfc1SsRk35U2gq2zQgoCiWt23WO4POAHFx06OZfZufJ5IwI5Fw2H/gpWlPRCmFyJX0J2Nz4dg46rEkyiuIDoAxyUXBGwYJttKDGxgclL0dUozlrKTQsF/DMaxG7CBtocPiwhUNZ5YDm/Qhlyo1Dwr8PinTEvxHFjUd/o3UAr8GtRdT1KVrgz+ozDQilF0dYKiJJ4GBxWp0Rcrci/FieeIRjxKs8Pzi23NASPex0Pd7Lg6goFh6+zLygInb1qRyIPTf/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wNhOR9kPxokwPkr70jQOY6lCXJ/ynMLzpEaxOx+hSo=;
 b=v/EHidCvKlh46A3NEvbaDpGxNrK3TWcWkSUcp26wxD+QO55TC0Faw6RWHunnrfeMyd4YTku9mIcz/rpB1VPMjbt2LpbYgr5Trp4GUELZC5M5DSl3NM+a3cSFrXV1ALZKZsn4xzvPJ7eOi51H+QDCW2ew4aMsq+3lbQEb53gNdqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 23:18:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 23:18:09 +0000
Message-ID: <62496e35-e23c-4d10-a5b1-99978665cebc@amd.com>
Date: Fri, 3 Jan 2025 18:18:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the looply call
 svm_range_restore_pages issue
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <20250103022615.1399054-1-Emily.Deng@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250103022615.1399054-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0354.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a6cda2-0ade-425d-cf1b-08dd2c4ce2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEFJcjdOYjJ3RGovZUVIZWZzU1NlSnRQL1hUNktFck1HYkdKWVAyRDRlWmNu?=
 =?utf-8?B?SkhKc0g5MlZoR05jaFR6Z2t4WUszaDZSSTRQcGNJZ3lSbFVHL2FlU2ErZlZr?=
 =?utf-8?B?cXBUOXUvZ25heWE2aUZWRjZqRDMvaFRCeHYzN0x6cFVvVXFYU3RQamV5YnhU?=
 =?utf-8?B?YVFXZUxzVUFVR1huYTNUNUpLSDBXQVRUakhuNC95NnhhbEQvcVBpMUpsTk1h?=
 =?utf-8?B?Y3NBVzY0QlZRNmU5eFU2Wnk2Q3JLQlFteFF0akNVN21sMFRIY0ZvcUpzM0Q1?=
 =?utf-8?B?T2VMM1RoL0ZFdE5XbG1McG83eVRRc2xiYnRSWktIOFFJZWlqWUVhUTFyTGlR?=
 =?utf-8?B?U1FGdVlkdytvV0x6UmgvOXV0RTNIQkUxWWFxN3NOd3JFTm9KREdLU0ZrcFZp?=
 =?utf-8?B?aFlGQ2JlZFlYZ1VydzFDOTA5L0RVcEtwRUJURmc0QkI0a29UUjFybFA2MVFW?=
 =?utf-8?B?dDFSWnAvMlI3TGsyUzRIS2dObWU3TDFtYStQYUNVOVNvVWFzMC9ZZUc0alJx?=
 =?utf-8?B?c25Ec2U5d0RNWkoyM0JRR0g2cms5SDVKVkFNYXBLRDkyQ3VBWTQrSkNHbFNB?=
 =?utf-8?B?QmRRWkZkckZSd0JmamFQdUtoUjgrakJWanAwOGdKd1JTYW9pOTZDdVpWckZF?=
 =?utf-8?B?YjltS3ZZWHNMejRxWDRLYlFMSXpjQnZKMkhHUXVjNUgyd3FLUXByKzF5Ym8y?=
 =?utf-8?B?dDRHYSt5dzUxbmFPclcrdUhEWTR0cDBGWXNrdzFDT2tZMXh0dDBDbUdBcEsw?=
 =?utf-8?B?eVZIY29CMXhzVDd6bFA4NUdlYk1MSkxGeCs4RURGdVc1WUgvK0tyOHh2SnJs?=
 =?utf-8?B?Tzhwb25RUVFKdnJ1S28yM1BvVldJR25Idkl4QlI3Q3VNd29TU242dW5KajJv?=
 =?utf-8?B?VFRVV3BYakJPMFNDaUViSUV0RmdRMjE3N1hvcVplYThFZ2Z2RmtFV0dqT2pP?=
 =?utf-8?B?T1dqTkpZeDFEUFZ2MFZuUi94Tk1kdVBmdWtPSW1HSG1TeTVHWEhPSE81MHNX?=
 =?utf-8?B?TnBZSDZiMTJoZkxNNWhYbGRQVVFCanp2VHF3S2hrRHBFalJwVkxmMW8yMkZP?=
 =?utf-8?B?clRvU1Voems1VkQvOGNXT05zWDZsN0hTOEU1elNwdFB4Mm9VYTZ1Zms2emkw?=
 =?utf-8?B?ay83SC9ERkpQZG9TTEF2UFR6bFhYbWdmOTAwbC9QSWUyWUszWitTNksydzdW?=
 =?utf-8?B?RmU0TUVOMEp2eG5LWXh6c0lscHVsTHlVT21NTUlOWmdCcHhId3FLK3Ivd0Uz?=
 =?utf-8?B?cHpaUStoRWp0RWNtenRUSTBWSFMzdURCWHpnZ29FZ2ZubTJYQVZvVjljbldi?=
 =?utf-8?B?SU1mOHhwbjFEYlA2Wm93RzlaaXNPdmFnVkdKRTRwbXVMTHVWRHJiT1V4ZUhZ?=
 =?utf-8?B?UUZZNmtpb0FWcW9KcHd2Z09wQkRoNlYyS04yaHg1b2l0VCtjakNwc1hETkRL?=
 =?utf-8?B?ckhpUUx0eno4L25WSVQvT0dCZ0NQQVFBS1VoM0wwNE5FSmNRNXA4aTRHVVJo?=
 =?utf-8?B?M2JCUXlGRW1VZTVGVisramVnSUMxaTZWREhCOWdpVWpkUHBaTjU5WExhR21z?=
 =?utf-8?B?Slp2cW5kTHJ2OVRSd1RIQStFTDJ1eXorMThiS2VpcEtLOVVQa2NQNUVEZHZK?=
 =?utf-8?B?ZHBnZGIzTjJNMzNjZ3dsdXI0NFk1WEdLbzludzFwQW10VXhEdkE4b0l3bFdN?=
 =?utf-8?B?RWN4cEUzc1c3ZzFOcWgwWlBWZGpIUGJjZnoybUprTkhhVmhwTUNhTnRIaTRk?=
 =?utf-8?B?dnFJakwyMytuSi9EQ0hMbEkreEhHUWc2TkhpTWlYcnRtOGd2Ui9ucStrYUpx?=
 =?utf-8?B?RU8xaXUzMjI1TTg1NXkrajVWMXVkRnc0RnJDNjllZ1Q5WlZCRGhWSWtBczFr?=
 =?utf-8?Q?jSkvwrbrnAg72?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZubTdBQ1QzSXFXeU5PWXdKVWo5M2Y1V1ZYRHBGSm8wdDBOekJ1NmFaajRt?=
 =?utf-8?B?TXJPNVdsQ0pLWmVjUGZ5bjQzd0QrL3lrbUd5VXJyNDhOWHR5WDF0QkExTVNq?=
 =?utf-8?B?ZDNwNjIzdEpqOElnS3YyelhITjdoYkpxMTY3Q0FWOWdnUDdQSEQ4RG1vcm1S?=
 =?utf-8?B?NEplMEs4WmVTRytLVkZTaDhSd0lDNFg2YmhkZjg1dHV6eUVPTWlQMk8wemZO?=
 =?utf-8?B?S0ZYaTE0cnFUWDVwMU1rWjdHSE9XdlQ2RmJJMUNUdEdmZFBjS3p4Rk5HaEZw?=
 =?utf-8?B?YldEeXZXaFpjUDdqSVZFeE9mLy9ZS25wY05rNG9CTEQ0RW9xQWdiRllsQndK?=
 =?utf-8?B?R1ZLNThyRW1DOUM0S21Jd2R3YWxUQUNGZXVTT1oxbnAvUStFUkR2WWtoQkY3?=
 =?utf-8?B?WXZnMkg4OUM5QmFRdUN3NDdDb09SekxyRUwxbUlHM3RzVElhMXNtWldxVURM?=
 =?utf-8?B?TTZRTC9KREN5R2RCT0x1WnlzQTVuZmpiZlF6TzdzLy8xSHFPY1NUYmFhbE1H?=
 =?utf-8?B?UXFSSXN1d3lzQzErKzNXQlpMKzRmWmNZcUM5dFlrWUh1dEFrNlVEWDh1eUFh?=
 =?utf-8?B?THlmQmZzTDZyMkpmaFBEbUFBZ1dpdkcxekoySERLc0EwUGFWK3g5bTdhWUln?=
 =?utf-8?B?MVBGMG9hMXovOHRwc2lSdG5EQU5SWlFSdEd1dnArcnVwQ09kTmpXcjdhaWJT?=
 =?utf-8?B?U1lUWmdITTA3TW43VUw1cE5jOWtWbXdkMVJuQkF3SmZENVEzYVF2bThhSEk5?=
 =?utf-8?B?SWgrQ2FsSW93dGtxZGZYcmdPa3ZUQ3UyZTc4QWNVb05MVlFHaHkyQnNwTjRK?=
 =?utf-8?B?aEdMc203bDIrN0NwanpkRWdOQUhmWTVKOUZuZ01ob1FZOTYzUVVleDBESHpi?=
 =?utf-8?B?MU1ld3R2VnNvTXAxYmJWZm9OY25FVWRKTVJBUWRNT29mZnl5WGVCckdRQzhP?=
 =?utf-8?B?aVNPWC93ZGNFbnFsZnpxeXFtUjVrTHVxK0IrN1FJd2JpSU9tZjNSUWpsSGR5?=
 =?utf-8?B?NDN4R3FWYUVPZDRhS0pwZEludHlnSDdBNWticGNvTlJLaXVDWHlYanB6NVVw?=
 =?utf-8?B?QzJBYU1MaFVWeEZ6YzJCV0VHY1FjOVFQRm9hS1A0S1ZOVFQ5WTRqVzVwZnFP?=
 =?utf-8?B?YzJ6cHhqcTkxYzZXR0dldTJyRW9tMWt2NHlTUDdQY2hyeTFPelc4djNIeE5L?=
 =?utf-8?B?TUpLVDhsVVlzb3gxeXkvTW9PdVgxTkhOOUdHWEFWQm1WK0NuWG1rWk1HOTE3?=
 =?utf-8?B?M25JY21MUDlLR2prZkpaek1FSmR5Z255VnIydDQzazdmVHpsdU95MjNnK0x0?=
 =?utf-8?B?TG5ITzNxSmZWNitOZTEzNEtDeUJzQ0IvZE16NDc3T0NOSHkxOVdzYU1PdC81?=
 =?utf-8?B?ZTcvS01sb21Ocmp3ZDZFZmJ4ZmJjNWNYS3FOdy82SG05a2laVTRRRUkyVURL?=
 =?utf-8?B?cUhnRWdueDFZQ2Qxang0MmpnenNsZHRDb1dMemgvNllaWDg4VjFzWGkwc0J6?=
 =?utf-8?B?WGZ6TSt6OHdteEk3K05USXAwQjB1Y2ZTTU9MdU9LZzNnQnBVTjdoUytTZUJU?=
 =?utf-8?B?TmFNdGJXbWNDVENuUkk3QmtLc21taWxQVWpYTjRveUlwTjRFVkVER254aFJE?=
 =?utf-8?B?dUlBbXgrUWM0M09BQy8vTXA1WDRiUzE3MndjaG52T2NhdmVtL1lHRVB0aUZz?=
 =?utf-8?B?c015WVJmRFRvVWJKYkxOdHJkdDlIenY5ZElkWG5FRGhUa1F3SUtPTVRTV2xQ?=
 =?utf-8?B?aVJTTjU5ejRYVGIrN0QvWkdCMzNlYVhRbXVNazRtd2hsZ2g0a28yY3haaVlv?=
 =?utf-8?B?RDU5bXJZT3ViV3BqNjJ4L25hTksyUzc5MGJEZytkZXhSbEduNGpiTVdvUUFT?=
 =?utf-8?B?ek5HaDBrWDd0L1E4Mk95bW5MaXlHd2I2NFZxM1V1dmVpb2drS0Z4RHhuY0pp?=
 =?utf-8?B?VWJTcUNHZ3lRL20wWERXQ1o0VFo5TG1kWUtEN2lWVzFWRnhHMVhCUTByRUpG?=
 =?utf-8?B?MGdmT1Z0Q2J6SE9lS1FxTUIzbmNNUnEyRWR2MkN0a1Q5R2pDbGdLdlVHdFRP?=
 =?utf-8?B?R2Y3K2NrZXZ1V2F6Q1crcENUL2VpRWtYM0RicHU3MzMvQ0MvY2ZpT0IvYVp3?=
 =?utf-8?Q?uivNGdru+gkqPrXn5esDI3hHz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a6cda2-0ade-425d-cf1b-08dd2c4ce2f8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 23:18:09.4763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAWWC7VBPYToZRo286SO8pWK6gaUDxIY6oJTLKSOKfLdK2uxk9snuq9vZRqlBef9RAM4XLRVzkra9dFc3sTTTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
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


On 2025-01-02 21:26, Emily Deng wrote:
> As the delayed free pt, the wanted freed bo has been reused which will cause
> unexpected page fault, and then call svm_range_restore_pages.
>
> Detail as below:
> 1.It wants to free the pt in follow code, but it is not freed immediately
> and used “schedule_work(&vm->pt_free_work);”.
>
> [   92.276838] Call Trace:
> [   92.276841]  dump_stack+0x63/0xa0
> [   92.276887]  amdgpu_vm_pt_free_list+0xfb/0x120 [amdgpu]
> [   92.276932]  amdgpu_vm_update_range+0x69c/0x8e0 [amdgpu]
> [   92.276990]  svm_range_unmap_from_gpus+0x112/0x310 [amdgpu]
> [   92.277046]  svm_range_cpu_invalidate_pagetables+0x725/0x780 [amdgpu]
> [   92.277050]  ? __alloc_pages_nodemask+0x19f/0x3e0
> [   92.277051]  mn_itree_invalidate+0x72/0xc0
> [   92.277052]  __mmu_notifier_invalidate_range_start+0x48/0x60
> [   92.277054]  migrate_vma_collect+0xf6/0x100
> [   92.277055]  migrate_vma_setup+0xcf/0x120
> [   92.277109]  svm_migrate_ram_to_vram+0x256/0x6b0 [amdgpu]
>
> 2.Call svm_range_map_to_gpu->amdgpu_vm_update_range to update the page
> table, at this time it will use the same entry bo which is the want free
> bo in step1.
>
> 3.Then it executes the pt_free_work to free the bo. At this time, the GPU
> access memory will cause page fault as pt bo has been freed. And then it will
> call svm_range_restore_pages again.
>
> How to fix?
> Add a workqueue, and flush the workqueue each time before updating page table.

I think this is kind of a known issue in the GPUVM code. Philip was 
looking at it before.

Just flushing a workqueue may seem like a simple and elegant solution, 
but I'm afraid it introduces lock dependency issues. By flushing the 
workqueue, you're effectively creating a lock dependency of the MMU 
notifier on any locks held inside the worker function. You now get a 
circular lock dependency with any of those locks and memory reclaim. I 
think LOCKDEP would be able to catch that if you compile your kernel 
with that feature enabled.

The proper solution is to prevent delayed freeing of page tables if they 
happened to get reused, or prevent reuse of page tables if they are 
flagged for delayed freeing.

Regards,
   Felix


>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 7 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c        | 6 +++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 +++
>   5 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 93c352b08969..cbf68ad1c8d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1188,6 +1188,7 @@ struct amdgpu_device {
>   	struct mutex                    enforce_isolation_mutex;
>   
>   	struct amdgpu_init_level *init_lvl;
> +	struct workqueue_struct *wq;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f30548f4c3b3..5b4835bc81b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2069,6 +2069,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   		if (ret)
>   			goto out;
>   	}
> +	flush_workqueue(adev->wq);
>   
>   	ret = reserve_bo_and_vm(mem, avm, &ctx);
>   	if (unlikely(ret))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9d6ffe38b48a..500d97cd9114 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2607,7 +2607,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
>   	flush_work(&vm->pt_free_work);
> -
> +	cancel_work_sync(&vm->pt_free_work);
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_put_task_info(vm->task_info);
> @@ -2708,6 +2708,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   #endif
>   
>   	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
> +	adev->wq = alloc_workqueue("amdgpu_recycle",
> +				   WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 16);
>   }
>   
>   /**
> @@ -2721,7 +2723,8 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>   {
>   	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
>   	xa_destroy(&adev->vm_manager.pasids);
> -
> +	flush_workqueue(adev->wq);
> +	destroy_workqueue(adev->wq);
>   	amdgpu_vmid_mgr_fini(adev);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index f78a0434a48f..1204406215ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -554,15 +554,19 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
>   
>   	vm = container_of(work, struct amdgpu_vm, pt_free_work);
>   
> +	printk("Emily:%s\n", __func__);
>   	spin_lock(&vm->status_lock);
>   	list_splice_init(&vm->pt_freed, &pt_freed);
>   	spin_unlock(&vm->status_lock);
> +	printk("Emily:%s 1\n", __func__);
>   
>   	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
>   	amdgpu_bo_reserve(vm->root.bo, true);
> +	printk("Emily:%s 2\n", __func__);
>   
>   	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>   		amdgpu_vm_pt_free(entry);
> +	printk("Emily:%s 3\n", __func__);
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
>   }
> @@ -589,7 +593,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   		spin_lock(&vm->status_lock);
>   		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
>   		spin_unlock(&vm->status_lock);
> -		schedule_work(&vm->pt_free_work);
> +		queue_work(adev->wq, &vm->pt_free_work);
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3e2911895c74..55edf96d5a95 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1314,6 +1314,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	uint64_t init_pte_value = 0;
>   
>   	pr_debug("[0x%llx 0x%llx]\n", start, last);
> +	flush_workqueue(adev->wq);
>   
>   	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
>   				      last, init_pte_value, 0, 0, NULL, NULL,
> @@ -1422,6 +1423,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		 * different memory partition based on fpfn/lpfn, we should use
>   		 * same vm_manager.vram_base_offset regardless memory partition.
>   		 */
> +		flush_workqueue(adev->wq);
> +
>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
>   					   NULL, last_start, prange->start + i,
>   					   pte_flags,
