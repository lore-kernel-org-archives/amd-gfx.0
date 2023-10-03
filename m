Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27FEE8FDBA
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 21:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A41D10E025;
	Tue,  3 Oct 2023 21:37:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E5BF10E025
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 21:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaKnYrRDIyQj2CnNOkFledZdnw+7iQDuDf3OydrW4QXlreK3UQqvyebJ71TdXHGzNTi0x3Iq3bn6wBtvx/Ugh6j4z60POAVcrraahfl3A2FTNZggpqlJf/iPUpnK6u6biGHDvyoy6EJ33aR0PB6FJ84ejlZaEN2t457se5Yai8RVROHxCJMhcSGz9f2VjLi9xZuvKQYXgrIvtCAkJG+Oo7bbR3e60OR7Q0OuaRuy1qQATg8LJZOizt0uoXuL+LyD/F38MVvQeT33DuqqX1Ldf50cPRYVFb7cbLu/xnOgDe2DiX9y9WJZogkrdTzM5N+gjK2F/BbRINOwYpYC0XfWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7GhRr4Easu2ahlFPaNAZ0H5qGmEy7dbCegKHYtgozk=;
 b=Zt5ji3MSGS23f7EXNnBPGXAHAktlSwqDsQfgfBYzRIZSMNzNOkbPiZPsUcN830quh/VFS8Z85TL1TDLaDLxSQbpCX7R/2Tqg1C4iksg89agpfGwjwIXfNvScQ6zkjAcW0kISKWH/Zetup+jsVCwpv7b1XqtE3aNfdrFhlVHoaou/zbP0+Q9zk5mtZukv8GlafV6XNOGyN70JoveCpIaPoDsREw/x8Af+PdE+sXJwiSwG+Bdahf5P/U4KbMuTsJpTNITO0zJ7WneI8tvqVU4ftE3r7BExX7vpRvn1DYHS9oLX4xFG3qr9N7+9i/TScAk6sZc9i8RSFMwbqS7iwmwxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7GhRr4Easu2ahlFPaNAZ0H5qGmEy7dbCegKHYtgozk=;
 b=NAuoUVWY8EitBZSa8oDK7TQ+XHIcn/UBDXFcyckdhmIodGreoDpxmxvlExwwtx1L7u37Ee1+czLNvCa6OmFzW9hWScw1hS0g44UZvl9NZCIkZq7QbC1yvWDlmezCDiGJ6jhr5hO2aFa+hMI62X/1U+Zft6zMZhjhFjxvabJs/ZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 21:37:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 21:37:14 +0000
Message-ID: <995b4966-3902-dbdb-1991-b30e158e991b@amd.com>
Date: Tue, 3 Oct 2023 17:37:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdkfd: Fix EXT_COHERENT memory allocation crash
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231003205029.4764-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231003205029.4764-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ac5173-822d-483b-f9bc-08dbc458e8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGQzUdi0x2hXerE8Xnr8xgUan82YbAA3wcM1xiI+hiHG5sWbp4ceMGqsot+gMcjGj0S8twAShxER7rXkNzZTgEVWsVwZcPi3+3JY/xq+l3zYm1ON2cuQdqDWfDYI3UOEon6ubqIZ4fOBD5anwpKHLCuInbrgFWYtDzA1sE1mKqwRFgsX8AmIP7rvG25SNMhgF4z6b8K3qkgWW+ReTD0xncf2j0DaJPpGqypltV/kbdmlPtOC075W3y4OAt5q6PBf1VMsHUAmw4pJ390xjYoIK1iSZ8NVIskue66eszhGgXd66PJCQo72wqK1quVmEhEHlXCYz2Rah0aGGYBqS8kwcFBy7lACbnptu+SXosbjvFQTvvUhVjeMJipjvgtZDBd3BqECby2gQkipSXgmisdvYu+P4Vlwy+AVqspCE2K32NRwEG+wv0DR7HcgqEyT1ee+rpr7dWuhm2fkTRLyEGb78VjuHSGuuj2kUKSGT+JctrPURcPmplsMdxhHwCww0tJKyDq8LnTullws5Jp/MwnJLV1yM/sjKSqOxQwHjXzcB5ESmUL3eSuHH41m3sAlhOnGGBRIKIO+HYGbddkMWA9GUjH/Tn0KKgFmTF+Sz1g4iPdhUr1981H25M9laDbd5zl8oyTtk95s8ppyg5o+Z3X1rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(36756003)(83380400001)(8676002)(31696002)(86362001)(44832011)(5660300002)(8936002)(36916002)(2616005)(26005)(53546011)(6486002)(6506007)(6512007)(38100700002)(316002)(478600001)(66556008)(2906002)(41300700001)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0drZEZBdDVhcVJqRDNMN2hZS1lydU91TjEvOWg0RWNQZTd5MHhtVi9rcjRq?=
 =?utf-8?B?M3gvSkdjb2hYRktIYmQySWlRNXJIbTFMU3FTY3dGc1kvcHlETzRicnZyWWl5?=
 =?utf-8?B?M1NtamwxVmlnVVFmTGlDcGNDOXhOMzZSdld2eHJqSVU0SEZBOXhvREc0Ym55?=
 =?utf-8?B?dkk3OEtCeHpsOXdEUXZKZ2tHRzNMU21BVXhwN056ZENvZ2V3YXFPcnNuL2gz?=
 =?utf-8?B?TkZSN1Vaek0rdWZ4cnc3Nk1Qdm9hVk5kOEJkditnMUJERFNvMzJIZndYV1pa?=
 =?utf-8?B?QnQvWXZGTCt4eUFmTGpLbGsrN29LUEZDZkZFRUVSbGQ3bWJKeER1elc3S0No?=
 =?utf-8?B?Um5EYVpvVkExZWFpVlcva280SStBa3JZMFRzb292eGRBSUZlNlVqQzhiUEVt?=
 =?utf-8?B?M1VHTnRMQmRyRklSdWM2N0hxbXFNbHdVTHpsYWh0Tm1wUVZCT3dDKzZ2RmIy?=
 =?utf-8?B?TDMyMUlGNjA3cDhvU2tjNlpQM3Q4WmZJOWE0RjQyYitvcTNUSVA2NGhMN0tH?=
 =?utf-8?B?UERTSEZoOXR5bjNJeWFjcURMMWZHRHYvQ21CVFZreW1aZnVRZlo0MDczSUJX?=
 =?utf-8?B?QW5CYTFKVFJ3akcwb0V1SVpUWVRCVmpwNkR3TjVBRUhzYVVvMUQ3bks2M1Rr?=
 =?utf-8?B?NFFjY1g2Tmt3a0ptL0RPR1dIRzdvNkJPNk5Ma1h4ZXJDbkdid3NwNjJENmdT?=
 =?utf-8?B?U3Bxa1RkY1VkMWVuamdTQ2JiZEU4c0ozOXNIT081U01GaUhjbXRORjd1cGVI?=
 =?utf-8?B?RXp1R2NUUlZmZTMxZUNvRVNVcWV4L1k1R2U0bzZkWmR3UVJVQ2Y1aUdtTHda?=
 =?utf-8?B?ZmlxVFdsaXNXcmRPWUh0dEZzYS9mV1BrQnhicmVhZWI3V3RsZHRNamx0NXNo?=
 =?utf-8?B?NXFSeEgwMFVVbDJMNS9sTFBmaWRzYzRKUHpYckxiVTcwVmNGV20zcmpTTDh1?=
 =?utf-8?B?WkluaDM3bXFNYjBYTWM0NytLLzlyRm1ldDJmcnJIcU1UV3NNeTlFOHVpTzVX?=
 =?utf-8?B?RERZSUhETlFOZXZVdHlYdTJndyszbU02aXQrbUJVcWoyUnBIb09iU2dpVjVE?=
 =?utf-8?B?SVdyTkpsN0NFZjc3dmVLK0tPcC9QcTIyV0tBYXBvNmtVUm5YNnVNUXJKTUcr?=
 =?utf-8?B?WWYwN0NacXNyRlM1ZnVCOENBQmpqYkVTMDMraUVIa2FKNkdOa2l4ZFYrVFZ3?=
 =?utf-8?B?MHNHY1M2SW0yTUczWnVlb3BGb2ZnUDl1NDRQNzRMNFVUNnhlRWorUTBMMWha?=
 =?utf-8?B?Z0NWQUhMWWU3Zk4wWFEwUjRRWGJzRnVKSDR3N0xmRWxWTGdxQXp4Qnl1Y1NN?=
 =?utf-8?B?WDdybm9wanVsYzRyUFFja0tVd3Qrd05RRWp4WE9jM2VxeG1UbkVJT0FPc2U3?=
 =?utf-8?B?cTJveTF4VTRIU2pxMEM1ZWNCbDFlMVhBT1I5S0lTUEhOSlVaNXhNNWJ0UUVj?=
 =?utf-8?B?N2I4WlRRRUJIVFBQTUZKTjUxdVVVM2RETVExU1ZRbXJNRWZZV0Jheisyd3p0?=
 =?utf-8?B?RUlTZkxBSnk2dTV1VGpZSDNFUGhnQ0ZTQkl2SFFoOEFWMTJoMzU2SFE5c0VZ?=
 =?utf-8?B?cENlMjhCU2lMY1pUVTRSRDRTQlhINkFVRWRvQWtNajJGaXhXYnVHU0FTZFA3?=
 =?utf-8?B?cWd4SXhKM3lQRnlBc0hTcEFRMkd3Y3pJNm1UdFl5N0FSdTNkSi9rT0FGWFZ5?=
 =?utf-8?B?aHh1bEErcnBQVVNONHNtL09qOHlJMzA1WDZBUDZ1K1BMNlE4LzRRcm53eXhl?=
 =?utf-8?B?MkZ0cXRsWXNyVEw1Qyt6Zm9KaDVpaVVlVU9BN0o0M2xRaG5qY1F2SU5uNVoz?=
 =?utf-8?B?MWQwbXNDaDV5ekRsak80ZjluMnRWc0dKWVo2ZXBkTCszRldiUW5GVEsxT0E2?=
 =?utf-8?B?dTlRRkpRWmdDSVJVa0U5ZXlPc0VSejlybnhzekY1aXJhOSswbzdhVmJiOHFX?=
 =?utf-8?B?b1A0dVVBTS9TSXRDMFJsdVpzWHh4ZFE3TGpLQS80TS94UCtwbEZSQS80dDRS?=
 =?utf-8?B?SHFIVmZnYUtSRTRZQmVMckFRY0FOemVTNlFJalZETWYzNTd5K0FsWW1JVktD?=
 =?utf-8?B?VlhJTFNNbHNrajBCRXhqdWtwWkFueXQxWk9WMHNOdGs4cmR3MmNHWDdCejlN?=
 =?utf-8?Q?jrmS4uYVQRopwfQo42ozGGYd4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ac5173-822d-483b-f9bc-08dbc458e8ea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:37:14.8154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpWacMwnAY6gEXCNqkKANYBJ0h1X2CmsLMU1inR9V6Uj6CgdzXK4ZWLWT4NOh0fvHxDL77T0QNnMAuSbl9SCaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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


On 2023-10-03 16:50, Philip Yang wrote:
> If there is no VRAM domain, bo_node is NULL and this causes crash.
> Refactor the change, and use the module parameter as higher privilege.
>
> Need another patch to support override PTE flag on APU.
>
> Fixes: 55d7e2001c7e ("drm/amdgpu: Add EXT_COHERENT memory allocation flags")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 0d88698ae33f..305b2c54edfa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1248,26 +1248,22 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   		break;
>   	case IP_VERSION(9, 4, 3):
>   		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
> -			     (amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
> +			      (amdgpu_mtype_local == 2 || ext_coherent ?
> +					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);

We had some offline discussion where I thought that MTYPE_NC should 
become MTYPE_UC when ext_coherent is enabled to get the desired memory 
semantics. With that idea in mind, this would become a bit more messy, 
but here it goes, as clean as I can make it:

-		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
-			     (amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
+		mtype_local = amdgpu_mtype_local == 1 && !ext_coherent ? AMDGPU_VM_MTYPE_NC :
+			     (amdgpu_mtype_local == 1 &&  ext_coherent ? AMDGPU_VM_MTYPE_UC :
+			     (amdgpu_mtype_local == 2 ||  ext_coherent ? AMDGPU_VM_MTYPE_CC :
+									 AMDGPU_VM_MTYPE_RW));

But maybe that could be fixed up in a follow up patch. Either way, for 
the purpose of fixing the crash, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   		snoop = true;
>   		if (uncached) {
>   			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> -		} else if (ext_coherent) {
> -			/* local HBM region close to partition */
> -			if (bo_node->adev == node->adev &&
> -			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
> -				mapping_flags |= AMDGPU_VM_MTYPE_CC;
> -			else
> -				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>   		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			/* local HBM region close to partition */
>   			if (bo_node->adev == node->adev &&
>   			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
>   				mapping_flags |= mtype_local;
> -			/* local HBM region far from partition or remote XGMI GPU */
> -			else if (svm_nodes_in_same_hive(bo_node, node))
> +			/* local HBM region far from partition or remote XGMI GPU
> +			 * with regular system scope coherence
> +			 */
> +			else if (svm_nodes_in_same_hive(bo_node, node) && !ext_coherent)
>   				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> -			/* PCIe P2P */
> +			/* PCIe P2P or extended system scope coherence */
>   			else
>   				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>   		/* system memory accessed by the APU */
