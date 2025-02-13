Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2EBC021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 12:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3060110E102;
	Thu, 13 Feb 2025 12:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1e8HIMJf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E914D10E102
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 12:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePnk/aizC91tYhDA3p42TLVa43iI4jHrYnSgsjGpvAstS5Na3Scd6Z2uiOSb8zpXDVblytOw4XlX7Q/mU+Tgak/+jVcY3pS1zHz563XHhUWt1vaQmVapjGoC2WLwsIXbtqodWJT1YankUtxjTsmyD1CTLcFF91EboXMWPrsXfnqBUOYmq8jpQ+/jsz0p7eVmefu7gmzaytO6VFwGGSH2zKZ7lnLEEs60HvhU6LXVHv7p7x9A0wpLznpAuLsDYI+BD/wWFRK/Q0pLrAH0hFTRXHVgGsx0l4tbQURymEKQjrqlXbuAF4CyhID+ZgLLEnFiMQhe38AYkN/TdCLxmXiy3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELE3DWNtw8Ebk1vT7U76MjhLYO/7jJXOH9MSImLgwW4=;
 b=hxI/VRbcnpdsIxJyv22KS89IY0neDySBSnd7VQdehGTA7BfrnLddY4tecGtqse7A6xJb+PN65h7crwv/e0cqfO57DPB6eogPKPf8t7M0b9SRtscdn53sl3bAI8I6ZM1hW11Q/D3ijDi8hIX8iaj4UW31VtmVshVZLDXlXkH2C/CMaHJ1SYSxSIoFkpSOs3NLxyaJpRnxTYzXknwWcwqaGU+q2Qz/EJnowYksgme+gRQzf/sHDYNnnix3s7QimXbF6n3XOf8RHsIDbUfUm0SBlsBf/nQ3PvfhkxRYYbT+JhMMU0fGzushyTECmgu/fzNASVmcHdJfD9F+kjkCfX8flw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELE3DWNtw8Ebk1vT7U76MjhLYO/7jJXOH9MSImLgwW4=;
 b=1e8HIMJfEWelHyRtaru7/AGDbde7duHOAEl+lrHlz2nF245q41981tDQpO8+pkzOhb6R/wJ5GAhRpts1gLQT/7nkWug7XOCbFq+EO8q21PiaxEOVnuMmrmT41OdcbR/eVnwzjKQFp4N7WuC2Q8xluLTUJ38NX84vXNGicwa2sKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 12:59:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 12:59:23 +0000
Message-ID: <62453f38-c3c0-4288-80f4-8eb3256b0424@amd.com>
Date: Thu, 13 Feb 2025 18:29:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove extra checks for CPX
To: Amber Lin <Amber.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250212194003.3774783-1-Amber.Lin@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250212194003.3774783-1-Amber.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7baf8d-7fc5-4d5a-be45-08dd4c2e3ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2ZLRVpkNUVTclpPTjdtdWhvNkQ1OXBVSko2bHZobHBIOWlpdVNjVDhtZk1K?=
 =?utf-8?B?TDdGWHJ6NUxtalpDSTBFbUhDVWRGTmg4NVBpclRYTFFyMFZSVVgwWVkvVWho?=
 =?utf-8?B?UEtteitxOGd5SzlLYjRmMmtGMldFeExBZjFEdUFIQ0F3Tnp4c0laaXB5TFBj?=
 =?utf-8?B?S3NGVE1PRWVyYVR4MjREVW9LTFFlY050cE1NZ2hhOVZ6b0NYM3VQZnZXUUVZ?=
 =?utf-8?B?cDdzK0VlOVRhSTJIWlR0TW9GZnh5MVpOWU9rSVlTZHNsdjdMUmFUcE85WUN1?=
 =?utf-8?B?aEdKNDFuVWxhZG16U2c2MUxtS04vM2U3aHBmOTFWNG1zeDV1dTJkSXVHNEg4?=
 =?utf-8?B?elNKcko5cWE4aEFyK0RmY21YNTdrWjYwUzdEYXdMNlAxOFNFT0pzN05IK2Vs?=
 =?utf-8?B?Zll1R1pncHcxOE1YUzZyVTZkRldqMXI0UGxVdDRUUFFmcG1rbjBNMnk0b0U5?=
 =?utf-8?B?eWc1M085WlFKMjFXMDRxREVoSzhicWpKYlF5R1VUdW9PblM2NlJGT3FaaDF5?=
 =?utf-8?B?ZG11RGdyQlJOam1wU3JFOS9UMkQxMjhQcXdXb2p5V2FtNUVUbGxWM0JESWZI?=
 =?utf-8?B?OEZ6bWVqRDZoL3pQWXZKQkprZmQ0ekxpNVNLZmZwNGg4TmZVZ2djcmo4d1BZ?=
 =?utf-8?B?UE9GMUZsVE1QU3k0QXdxOE51VUN1SCtpS20vNWg3dzd3cmkvY1BoZ3NxN3U2?=
 =?utf-8?B?bk1FYStYUWdpMUl2QmRzT2pYbjBGU0puVEN3ZWtFYW93azlPQmlrUEhDRUxp?=
 =?utf-8?B?S1VPb01mUjR1OHUraWhrcFBGdk1zd3pZWVQxRFMycFByNU50M0xOSUNiMHRy?=
 =?utf-8?B?eklIVDlGWE5jZWpKYkhQRHpaSzRlWjFlcUNWaEhhYlEvOVUwbU9Xa3pGRTh4?=
 =?utf-8?B?cTExUUNjMkVNaFRsQlRJK2FVVUhIWlB3Ry9hYm9oandNVjlNWU94RmdBeXdr?=
 =?utf-8?B?Z2srVlh4TlVtZHJUZjRaRkM0b1dTMjdWT0luVzQxQ29aOFJzTkdXRGRodFdn?=
 =?utf-8?B?WEtuQ2F2RFZidndJanh1V1FGZWVtamQzS3YvS0tIM2kxNllNSFh0YThIRkVG?=
 =?utf-8?B?aVVkRHJpaVAzQlJuK04vT0hSZEtOdlB2bDhvd1VyUmtiUWRvMnlwTW5TQXhV?=
 =?utf-8?B?bzBVSGV1NXJXVGJrVFR1S3FLdXQrVzBRbXBjWEtsS1pneWRZcDBsUFBScERh?=
 =?utf-8?B?eTJOMXB0ODBqRCtzMjJydW1WWXYwd3Bka1JsWko5SE9qUmdkSjFZYzd4NzVh?=
 =?utf-8?B?bVdYeWhxYWI3NnNXZ1lGSndNd2poWVVuVGhqbU9jeEFsUjNrOW90NzlhdjZy?=
 =?utf-8?B?Z3lzRWpjN0J3UjRpeU9sNi9uZlc1aVFCVytyNTBWLzJyeGlJUDBuQVBBVWpE?=
 =?utf-8?B?Q0ZqZkZ1cDY0dWd5WmlzWmtma05nR2wyMlczVUlPK25LRE1rYUpOK2RvdG5y?=
 =?utf-8?B?R0RWSTF6enBRL1VSOERJaU95WXBwRHN3SHJYRnZmQnZVSExDRGg5NHplZFlk?=
 =?utf-8?B?dU5iVDZQejRUckQ5NjZGUHFER1dLMVZMTHhSR1k1VTRDQlFzRUx5ZUdseWpP?=
 =?utf-8?B?U1pHMkxGeTN4bnVQbkFSOWJXN2hiSDFyTHAwQmdDd3hKZDNCbEw5QTB4aGx0?=
 =?utf-8?B?blR0RUFKTFVZM3Q5SmZtR3dXTTN1ajFvMVd1QytaUFJZVFJ5aVk4RldzZGdX?=
 =?utf-8?B?SGZ2ZnR2VGhJNWxSMEdMaUlrVVlSdUN6UGEybE1ZRyswOUtWYi9vUEM0cml0?=
 =?utf-8?B?US9FZWFRYXJpWFpVMjNRK0w2N2tDNjBvSG8yS09XZDVPSGZzMFEyS09IZUpa?=
 =?utf-8?B?Njk4eE5yM3pKc1R0NmkvbzhRZGJRVDJ5NXZaNlROaXpTa085c0JsSU9jZ0Fa?=
 =?utf-8?Q?Jke+/IU/+Equh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmswcnJpV0hjMnNSZ2MyaWZkS0xKRU43K1EyTzhWTlphM3gyejd6VXliQU9N?=
 =?utf-8?B?R2xNaHFMR0taTk5mbkV6YUsvYWdxNS9kSTZNWFJiQWJ6M2NsT0tyTE9keUtT?=
 =?utf-8?B?TkhBL3VGM2l5YTVtWFdTTnJDT1A4OFhrSGcwSFlGRzZUUVJ6QzNSbENPMGVj?=
 =?utf-8?B?NjQwKzdPUTVabWw0VTBOZ3gwK0dJTGlXaDZOblRnR2xYVG80Zmw0Si9KejFn?=
 =?utf-8?B?NUtOSkFBcW5NNCtoSnpoUmJ2NXJ5MjJoTnNWdGJOMG01RkQ5QVdNSDlIRlll?=
 =?utf-8?B?Sm1uOHhpWDU1aEFzN09aKzVpUmFwbVBOK0Z0ZG1iSE5GNHBsaEh2WnNsUHgv?=
 =?utf-8?B?a05lcUU2OUY3ZW9UQ0w0cTVyN0RFOWFsdi9aMUg5K0x0ZWg0ek9zcHZCZjI5?=
 =?utf-8?B?dWlRWExrLzVFY1k5elQ5cDhzR0lUN0J1RWttemZ2ellISEhtL0ErUzgyL1Z1?=
 =?utf-8?B?ZHZrMFkvSzJINFhqQkNIUHVkYTJ1bzRWdi9QQ3MzTUltc3FZSVFGNGRQaDBt?=
 =?utf-8?B?SGRTcUY3Z2FyZDRKNjdMdnJYQTR3YVl1dTZsa29OdlI0MVFkUUZIaEo0Vk0r?=
 =?utf-8?B?WmRWM2Z5bjNreWlJUlU4ZGJNS1ZEa1dVaEJwSjdKVldtY2kzYWRrNE9ZT0xy?=
 =?utf-8?B?UUFFbGhSRDJpd2plMGExL1VIa1dJa0VLajhsbDZ6SlZUMWRtblNYOWNpaXJs?=
 =?utf-8?B?N0JqUXFyRXBqTTU0S09GMkZpVXc1dk53SnF6ZXNaVTZ5QWE2Y0FzWXBjZU00?=
 =?utf-8?B?SW5WMnkyUnIwNnNoLzJvQXpLSHR4SlVXbzdlb2trSmUxNjBIeU4zbi80NlJR?=
 =?utf-8?B?QVJ2VzM5aVZQeGZLbG5CSjlRa3VEbVQ4bk00N2x6OUxpS3J3QjVWZ0tXZFRu?=
 =?utf-8?B?Yjl0NkdQM0xkNThBb3I1OXdpeGZtVTJEd2M3SWd4MmdoR2FPQUloZloxQ3hT?=
 =?utf-8?B?dno4NmREcjNuNUducDUzNlowY3c5MzFabFZLcHdRLytEUnkwM0tqSWJKNFo3?=
 =?utf-8?B?dmVvdW9aT3dzNG1GQW1SZU1GY2hGMEFVdlUvVUFZT0tDUkg2c0tVMFNra1BC?=
 =?utf-8?B?ZnZoc24rWlhMN1ZrRG0xaUYybDdGekgrelp3NVNsOEdIdkRPVzdhNklhNTdw?=
 =?utf-8?B?ZFZZUGFESDVvT2lYYmI3UmUzd3h0d29GRDZ1OXJSeENvdGk2MjdnbHJZZ21G?=
 =?utf-8?B?WnNTa0NxWmdIQzVnZ0R2YWVNSDNCOGRjMzF1Q2ZrQTYyZ21CRmF1M0ovbmZY?=
 =?utf-8?B?aTY4VDJZajQ1ZTFkSVNldTBHMjNDZitodHgyaFpxeW0vdEVGaFFjQklFZklo?=
 =?utf-8?B?OHZoR0tCN2haSFAvRys4cGo5VU5MbjdKVjg1bHRnSmdQMEwvUU1tMVNsYkVq?=
 =?utf-8?B?Q2p5dmc2YVZMeHNBMjd4aTlXcjBZUzIvMC9aWVdYZTVnWTR4b2hUS0dETUpk?=
 =?utf-8?B?Ry9QUzBrUnNua3VmbG5HNFRPQVZwamRQMk9UZFF3Nm5ycDZRRnNmOEJPWG9D?=
 =?utf-8?B?TXNQMlRpeXZHb1ZrV2Z4UnVxTGpmVEJXUkcxTE9KMlVPdCtaRjl2UzZENXZu?=
 =?utf-8?B?djJ6MTFvaUIyTWdqNHBOQzNsZ0tjMjRWNGtNOEhrM3VwNkdxcUhLelVZd3ov?=
 =?utf-8?B?d1ZZcm1UbGY1T0VraE9GclZCaTFvQTBFSHZYVVVDOTFybmJ1ZDBqb1FhdVRR?=
 =?utf-8?B?STlJd05iZU41VGxHb3BMSkVoVFIvNXFuWmhBRFFqS3U4aFRibldRbjd0VjZR?=
 =?utf-8?B?WFRidWxOdmU2WlZGODUyWFljWEs5ejZjMFBIYVBJOERYTVdiM3c0eXh6aW4y?=
 =?utf-8?B?UmZSbC9zRnNwVGxYYkdqd2tPTmVET1laTEFDSm9aZFpYQS9OZlorUnJNdEI3?=
 =?utf-8?B?VDFwYm5VazBWWU5UMi9UdHVpZ2RYYWpIdjh6YVEyemRPc3lpUlVSbkxiS1lk?=
 =?utf-8?B?ZDJxRVBUTmQxSGpvVWVGWUVYNHRoeW5jdkM1QUE0dmZidnlrYSs1dDJNbmgv?=
 =?utf-8?B?VnhjUFlNc28xYjBORDl4UjNPVGZGbHFrUk5BdUE4YUNiTnZPUVpCVTVMbFJL?=
 =?utf-8?B?c2Q1TEN3VlBaVGFRR0JQZDg5dXFYeG9ibkZPQ0hTQ3MyTS9mU04zVXRrdjI0?=
 =?utf-8?Q?0OfEcJP+Ul5GsW52zEBwywPBu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7baf8d-7fc5-4d5a-be45-08dd4c2e3ce2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:59:23.4365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxcHWdQYEd/dwsgWMUbLy1h333l5n2qTW6fQH35KpIPXciWdmRt4a8ukuMjd0Nb0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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



On 2/13/2025 1:10 AM, Amber Lin wrote:
> As far as the number of XCCs, the number of compute partitions, and the
> number of memory partitions qualify, CPX is valid.
> 
> Change-Id: I65696f25e2afd75f2f4a177dabc0991b15293d9a
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index e157d6d857b6..2753f282e42d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -559,8 +559,11 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>  			adev->gmc.num_mem_partitions == 4) &&
>  		       (num_xccs_per_xcp >= 2);
>  	case AMDGPU_CPX_PARTITION_MODE:
> +		/* (num_xcc > 1) because 1 XCC is considered SPX, not CPX.
> +		 * (num_xcc % adev->gmc.num_mem_partitions) == 0 because
> +		 * num_compute_partitions can't be less than num_mem_partitions
> +		 */
>  		return ((num_xcc > 1) &&
> -		       (adev->gmc.num_mem_partitions == 1 || adev->gmc.num_mem_partitions == 4) &&
>  		       (num_xcc % adev->gmc.num_mem_partitions) == 0);
>  	default:
>  		return false;

