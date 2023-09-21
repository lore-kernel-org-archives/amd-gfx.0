Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583DBE7D0A6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 19:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CAB10E603;
	Thu, 21 Sep 2023 19:33:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33FF10E603
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 19:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eepvyf5PvnJMDqHgwYVsaKwVEybqHwS+ib/OWQUxReNuSte8M8XGq2NxLRvYXfXhcPNmwd3uIRIsJlqgsmmugqNPYj/t0v3wXA9vLvS3xo7iB1Jp/Ww2/eqp3YNNnQiUm9tDN9SBWAUmFuzJ7/EzxHSG+eMhU3tq+LSEq6sV21th6qguSfVAZoeav0eOPCzNzqPROeMGSzUwdfaAAnQmBh007LUR4yX4wweyItNtrWqS0GEv122lkyRm7GQbrJzX7h67DiWSKpPjvNb+wvGtK6qk+soMY+Mp0WGQVfI+ffClwo1du5mIK3fwpAAoXpwOGoMvmDB2CbsZK+tYjN7IwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zav1+LdJvpH/u39CRzIRzlnl5aq6i8K8mLE0tFNsD0M=;
 b=mnRlLT6YEHIOrHJsavglZXZq4PFhYY1BlTO/7UZU1bSPHntrIchOE9XFOfHLod9WAzPWPGfbXuhP4n5Nit1B0IDcLSSXobbF+eP5hXbZDtHVtGgKGxOsSStEcLETi8fEINnOcAKXZvEsCl/ydY8QG9MLVke8IIUGQ10mWwSUlpczB9jpttAK8IL/8FdDTmCdnHdgJYWdDW2rJtyd4AlEC+eWp8cHpkF4ApMg3DL+RcTBqUfDEruQASWx713hKDI3q1vXcoag8o4BuP5wwiIbvgCSwDeE0HIiLvWHFPmKA/gRMQkYz/xZcVaRFREvEIL2gH5UlzL+YGJWxksURa7Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zav1+LdJvpH/u39CRzIRzlnl5aq6i8K8mLE0tFNsD0M=;
 b=bG6EDH7pwV/zyHwCwBVsAlSqdNRkIX+FbOsCzdJB52YTDVyzcN8mYtklZ/zTRLbApQxiaXUMeLHL8y4PSdx3Kpn22eLQKsmrCR78yN+/CpDqs8+EYHzPJPsZKKMTP2/utTY8yFc6TzOR8YqOaOkIwwFbkpJZDJ7cZE5XpIm02MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Thu, 21 Sep
 2023 19:33:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 19:33:37 +0000
Message-ID: <c014784e-1574-1a20-a5c5-e8137005790d@amd.com>
Date: Thu, 21 Sep 2023 15:33:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdkfd: fix some race conditions in vram buffer
 alloc/free of svm code
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920160932.12067-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230920160932.12067-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0169.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 946a71eb-4098-4a6d-2d39-08dbbad9a724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6hpOwsOfPM9kzq6BH4OeT1DCPtSXGLb7WJStcIpjDaCcmfbhW6Td6OaDD0+PB2q7BjtZzUqKwwgAF00SmlvYp8nZRGarW4RkzbE6ra5wvUS46VLji3CjKl0YjHs7Ofbs/NzTtvVoYshaedPi7jo/wCbMDpEwClg6PvsbR+EOOV+EVjoAsmwlyM+QMCURyhsicwCupCQWRGe5fLlPJxZdPWHdrKuAgVQhN96bjg0/+chRum176uVK3AKx2jlTayJzNEP1lDeKHKJKiwAPpU7VJ4SQXwxWq4ditNRmUOLVb6SFGjcZ79iccuWhnkytKtgl8tKqceANWvWOQBUlaMQOxWsLGb9d/U3vqLTZVXo7mGdGNFtbW2AMmyLD2DPuvwBxg8W1g4iAMKIn1RaiOigjBw0Or+xTugZlc0acN+sm2EDHChVcgbYSV25IqGxSyJhD+OazHmhSkCZqTEBKq/4c3Mq0uMDnwNhy68AGvklxTPsX5FXPEa877XfwJ2acZayUcHjiKWCmEqCmzcyzngWUTPjDYjRIKHqFe57EyRSJqkfrKqxMSXfy7XCybOFoNghN+XfLrDCVfG7W2wIaMsAfy5U7vAq99Mvw5pZX476eiV9k2u2CK0TXBu7NgQIX+OhToBevo0ae36GfwLNWAVXtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(186009)(1800799009)(451199024)(66556008)(8676002)(26005)(8936002)(2616005)(4326008)(83380400001)(2906002)(31696002)(36756003)(44832011)(86362001)(53546011)(6506007)(6486002)(5660300002)(31686004)(478600001)(316002)(6512007)(38100700002)(66946007)(41300700001)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1IyaC94WnBYM053dGdEcjNvVHo1b0hrYWxFaTJKQUZOdFhjWngvUEU1ZHBs?=
 =?utf-8?B?djVDa2xObUt4R2R0RkphMG1jTWZ3Rngxa3N4MTNVQTB2a216STV3bTYwR2pw?=
 =?utf-8?B?M2sycXhTYUJSaHI5QkpJUEpRQjVudEJLM1c5aG9CTGs3S0duRkVmWk9vRGhh?=
 =?utf-8?B?VkF0SkxLZFAvWGZscVphbHJLNHdJQTY5Sm5LUDc2K0tyLzM5MnAzMGpTcUdO?=
 =?utf-8?B?VWNmbHJxOWJzRmsvWk5ZbEVsdzlJd3plK25YVTFmYkdta1NNZFVzam1KS2tC?=
 =?utf-8?B?NUplbVZHRG5oMDhIeDhCWE50WFlObkthVzJEN1FLSnZEZlFZdkVRVmEyUm01?=
 =?utf-8?B?NXRna3BaWEpGakhFL1RmclBiVHlwSUp4aFN6MXE3SG9xT3ZXSm5XdnpXRG43?=
 =?utf-8?B?VEVkRzQ5VVJ0elA5M1VHZjVhUWcrK0dnejVZUDN1WFRpUWc3NXdHYlRYK3Q0?=
 =?utf-8?B?ZXVHSzl4cXQwandHR09RZW5ZZW5EZnh6VzZLa2ZqS25OM3VLdGQ1akpQMExW?=
 =?utf-8?B?OFdQRklhS3E4clRVSzk5bWlCZ3NQL3BmWFJzTmxEMjVoZnc0eVkzSldVNFpL?=
 =?utf-8?B?Qlg1UWRiejlpS3VVRFIrSVpGbit5OW1OYXg0Y3lVK21IeXJ3R3RrUm9DRGxC?=
 =?utf-8?B?REFQZUlnUHZCYTZCWG40eklLVzlmU3V0cGxXOUIrdERnRjdaRzNoV2kyaXhX?=
 =?utf-8?B?aWNLUWhUc1ZRZjJoMFVVdytiS05QV3RpRjFhcnpGTnJNN0dvZ05XZEdoekVQ?=
 =?utf-8?B?Qjk4ZXpYVWFjS2xlYjhDQU5WNVB4Y2R5bnAyTU4yWnhkbDVPcjBnZkNnMmhj?=
 =?utf-8?B?bFpTeFNIZFU0Ync2Wk51MDBrTUZWbDZpU0pPQXlQTURJZ0RzQ0F1bkxCZUM5?=
 =?utf-8?B?WWdtbXVscDQ1VDRnaTRBQTRseWFSRXUwR3ZadWpPcXQ1WVI1YVhCSjRCY3BQ?=
 =?utf-8?B?RlJySlBJNnBBdWI0SVlQUS9VMlRPQm4wcEpZSitqanJEYmF2TEZFM1RzUG1q?=
 =?utf-8?B?Ukd6aHNSRmdPcklBbmtINnp0NFdhdmE2dTduclNMZFVnR1VGUGhuT3g0TlIv?=
 =?utf-8?B?cVBYck9Dd2lEcXF5VFlsNkIzU05SMXN5Y2FTY2QzR2JQVkh4NG9MRzVWT2dR?=
 =?utf-8?B?THVHeHhsUnRxWWtDeVQ3d3dsdkhDaDlqNDMzOGYrRzY2RXJSV1cwd3Jlblh2?=
 =?utf-8?B?SUFxYVpRNTR4a3kzdEt3Q3RXSm80VE9RYWdXdmVLZnBNY1BDa2V6ZUxPazFN?=
 =?utf-8?B?V2pUcE1MOWtnZFU0N1pQSndqMUNUV1lzcGVnbTBmT2JMeVVCd3B3cGtzOEJn?=
 =?utf-8?B?eXBsbHlkUkpUbmxqRU5ZVEJJRHdocGppK2puUHN2UThOVFlDSnN2dVZpQStL?=
 =?utf-8?B?Zy9GSVZIMFlIcnVXMGhiZHYwZHErV2ZoZWV5SUdGTmNsL3dUTE51dThHVzhY?=
 =?utf-8?B?aGxRVmQxTDc3NVFkUkh1T0FvU0x0M25qSjg1SzlaWEtkYW5hR3BWOW9NOERm?=
 =?utf-8?B?UXRYd3hpZHJteFREU3pNU1FtZm5EL3MrMkVYajlqa0ZYK1lqNlRsdGx2STh0?=
 =?utf-8?B?TzBkOVhXQ01QWXBrWThBSSttV25UdWJEZGNqUy9VWlBkVG9XRjRBOE5kSFlC?=
 =?utf-8?B?N3ZSTFp6NHhXdzdpYjJMUHM5ZXFPakMvVVA0SVpzS0c3bFJRQ0QxK3JObmsx?=
 =?utf-8?B?RGVXbklLVFNNOXp6Y2tTSmppYldWenBUdENZVEpyRmkwWVRPdlFUZjBzVGlV?=
 =?utf-8?B?bHk4Z29yTFEvdmx6OGpPSlorbVY5UWpVK0QrUCtPYmZKU01OTW9MWkxMZyts?=
 =?utf-8?B?QWc0d2RGNUtaOUlPNld3TUNWRGtUNkRwQ2VCRERnS0dWQ2FTaTVTSTl3K0dE?=
 =?utf-8?B?MHg2RElpU0dEYUNSZnBjUVhwYTU5eVNPL1N6Y1VjdDJJM3ZwanRweWdwb09I?=
 =?utf-8?B?L2M0OElobnEwZnpZTFkrVy9uTVZpZTlSU0hqSm9JcnhHQTlHZk1Lb0xiZ3Ru?=
 =?utf-8?B?SUlVNGE0cGFVYUhCZlQ2TzRkOFUxSVZOMGVobmtLOGZWRTJWZzRFZEhhOUhz?=
 =?utf-8?B?a0hjWW9WdVByeXBDT1BwNzY3R3VsSld3d2xnTTk5OHcyclQwWDBTRTFoY0Qz?=
 =?utf-8?Q?2Cefcw3yEo3UcJuxPHcpnIVF8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946a71eb-4098-4a6d-2d39-08dbbad9a724
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 19:33:37.9073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y//xtYhn7zcUClXTodCsEwjeqUPXv0yW82Js+FW2N9vuoIzqf5NXDEB/vo36vYMtLW2hmRswUipABa0Hcqf8Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-20 12:09, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> This patch fixes:
> 1: ref number of prange's svm_bo got decreased by an async call from hmm. When
> wait svm_bo of prange got released we shoul also wait prang->svm_bo become NULL,
> otherwise prange->svm_bo may be set to null after allocate new vram buffer.
>
> 2: During waiting svm_bo of prange got released in a while loop should reschedule
> current task to give other tasks oppotunity to run, specially the the workque
> task that handles svm_bo ref release, otherwise we may enter to softlock.
>
> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index bed0f8bf83c7..164cd77af62d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -502,11 +502,11 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
>   
>   	/* We need a new svm_bo. Spin-loop to wait for concurrent
>   	 * svm_range_bo_release to finish removing this range from
> -	 * its range list. After this, it is safe to reuse the
> -	 * svm_bo pointer and svm_bo_list head.
> +	 * its range list and set prange->svm_bo to null. After this,
> +	 * it is safe to reuse the svm_bo pointer and svm_bo_list head.
>   	 */
> -	while (!list_empty_careful(&prange->svm_bo_list))
> -		;
> +	while (!list_empty_careful(&prange->svm_bo_list) || prange->svm_bo)
> +		cond_resched();
>   
>   	return false;
>   }
