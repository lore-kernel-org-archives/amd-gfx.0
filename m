Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E9C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 22:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370FE61059
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 22:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370FE61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3476E843;
	Wed, 16 Jun 2021 22:30:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D213A6E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 22:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACu7vFCpKkzaQIV+w3TOvo+IqkYoXHR7uOm0ifiPaAcann8yjbKhjApMkonEgn6HtQFe4LrscjZrGmOzFNGWbjCLRFt2FHinWxjRKVlU2+DmI07gSKrZ66OhnFZCMecT345IS+HtlOLT5uJe6P2t2FSaxcDZZk7oXKvQdasT7B8BhyOJBRymXLUbRXKlBIWzOodicNYGtztFN9rHiirVJsdqR7P0o03lL8+cbEP0gFtqxrouzieYZNQKYBMs35qTLMaiN56lvbyMxoIntUpDSNiZaAIHobyfYNq8A5fqrTe9eZMeNpxQMmIE5lThFRHXTXDHyuVdqi06dsR73E77GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Fmit2wS84S2iEHwThRLNLNaee2Ae99GYuHGTvKypQ=;
 b=jbgVDeB0Wb0tI7/2x4fJGMPx/wN3dx134Mbh8FMAE/Tt4xOF+9ipcwj/AwuU1rmCoCY+sqUqPKPVQMO5lwBE2gxTM+JseQbdsKKVT+zT8bLeHf5OpCjWX7ThUYBxVfie5hGNUNW8KWy3fl9NF6DFE2bi5XEsysRppSgCjAFpVSf+hkdmLusznvRiMEC5tO0faAmfqNbrpzv1J5bMy2xY6XB+OmZ1MXrXU306Wx3dnySRwMsS7MNQsTdwi70TI1DDmim0mKNKzwOZTY4CCpox3MZjFsnJllMxh0blKyAqXvEmVaJzI3hg6aCubC1vYYDVzqiAAxVhYRC9MvX0wy1hdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Fmit2wS84S2iEHwThRLNLNaee2Ae99GYuHGTvKypQ=;
 b=RSk/uT74uB5XNRmTkgM8628J04IaEGlsC2lmUs6ndFwuMiP/L2kopZUQrztwuu0VlPLDVRFHogC3euE87lIzJCJxcCf/EAgb/rHd96YR23l6b+GjgLoZka7mkyGv+S8tfsU/1YJxsN0gYfsZ1KPvR+xSryTBBxmPvzba76psR7Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 16 Jun
 2021 22:30:33 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 22:30:33 +0000
Subject: Re: [PATCH] drm/amdkfd: Set iolink non-coherent in topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210616181215.376756-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <eb50c4a8-b8a5-fb0e-e89d-1cc72a3fe8ee@amd.com>
Date: Wed, 16 Jun 2021 18:30:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210616181215.376756-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 22:30:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 367358b8-10d7-4b66-6516-08d931165a8f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5228:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5228F260CA4C132450B00719920F9@BN9PR12MB5228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKqI6Z4Xpd3cY3eWy3BYWor8gxgZDVDcsUb0Y/BGTbyhJ7IwhTbClB7I6ehOhozPMcFGCmSb6BWG5xr3DyIWdNQNhJbGfTE0RhRh5ODiWdV7sUPHgFs/GlCYgoDmQAf6y4TTdWawGV+HwG7vQpADin3eIzdGlvZ+FVu5A64/rxgT7c1bu6PhbDCgqYMHghJfYU5mYFgPwPBXjrTua2EOJ+HYJSVPV9ULzvifE8CTAlGHSYezT/X0lqUHzMhp5AEL22hHDfBp1co3g+iW9cfm9KcjGr2X4YvayQ2LCHJaxYlzgI3cQoCEpt3IKFCrBbMsADAZmyabAy83AW75f9R5WNUy2GUnGAxxXziBev5pYqviKDjby06/ILE/1nlj08J22VBhXIV3vGDwrKGxKpfDtIv6LNJV7UxvKlpPbSDJTVNEXqefJW/XnBTqvfpp20nJuoVblfSi9J5NZJ5CfCud28MnjYxREPQdmimfxkqM8qaromVh7wGcKGYzK/Ho+nwdOG2JtUlyTho8U3q+pwa0NL3YkJ6iNtgoEw01hYO/eaqGiztxbHp7C3LtSbFH/7fglASNNT+MupWJG0WaIXnrVBLsB4bGXQg36y1X31jkfMbrkUokOT8N0n2E8Q+neU/Sh4kzX+FkmojJ1R22Nmwd/T1jx3oqvKzeCBpAu04mz34xYjH/fuq5hDNKy6r8yLD0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(36916002)(186003)(16526019)(6486002)(44832011)(26005)(5660300002)(66476007)(66946007)(66556008)(31686004)(86362001)(2616005)(956004)(2906002)(53546011)(16576012)(316002)(38100700002)(478600001)(8676002)(8936002)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRBanVpY1NPU1poblBNL3RHeDdYNUs3VzBpYk9xYTZlOGMvdE8yRXFsUWhk?=
 =?utf-8?B?MjgwdE0xWXdhTDJ0MDZqbkpVdjlQZENaQWlZNVdsZUVHSURVSDQ1VGVFTDU0?=
 =?utf-8?B?M1dzcG9YbWllN3ZGMEREN2pFVERkWnEydUxyaklsRFAzanFwOUF5SjNXSktJ?=
 =?utf-8?B?MklLVjZUcjdZMk5XdVVXME4wN0lUNXVsMmljOSsyTURaWC9tejNJcmpkVEoz?=
 =?utf-8?B?WjFRRzhMQjhLMzIwTFd6RUR1WmdIaEV6RFR2MVVBWkNQUk1JQmlRN1VwS1BI?=
 =?utf-8?B?UWtCcnUyY0c0YmdiSHFESnJiY0lTWUJ6dkRJT2ZYeUd4K3NGNFhCQWZmUjhG?=
 =?utf-8?B?eU90M0NocU1NcDVZY0E0NWpydEpab1pnTGhMeGJIcUU1Q2puZDlwMWFlTUxh?=
 =?utf-8?B?ei8yZzdFNzVveFV2bCt6MHJ2N2xpTE9VY0ZwQkY3VGN6U0pKamZNN25kemNx?=
 =?utf-8?B?cVlSeTN3bFpqemJaS3ZBVUdKajJTM1FuLzVWaXZXa3VDTHpUNkhQd3pXS2tP?=
 =?utf-8?B?VERhYk9hWkJyL0tQUURFZmhtcU55ZXBTNUFoVExCY00ycDVBemNheUJycVMr?=
 =?utf-8?B?TFZIZmxreFRlbmJrbitPSUNsZDZWc1JodU5uSzkxQS93ZE1lRlFjMUE4U1NV?=
 =?utf-8?B?NFBRK05aSDRQc0ZxVXNCWlMvamxPbjJHNm5oWlRzbzVUclpudk1sT1RvU3Zr?=
 =?utf-8?B?Vkg0dmdOWStVZ3p5VytQOGdaM084QWc1Vjc4V0txYXJpZEpYVzl3M1pnRUNC?=
 =?utf-8?B?c0pzV1hONk5lSVdreVN3azhPcFpFKyt2OWdVcWYzS3FDM0V2b2xNZzVtUE4z?=
 =?utf-8?B?b3pxd25zTHg5Rit2V2ZpWkROenlBZVI4NFoyOWdSdmtZMkY5VHRXeU9ZeHN4?=
 =?utf-8?B?WkNTWG1lSnpzaUlRNlJ1dHRVY0VLM3BqMFhUcWREM3lUNzZCWlNWOGtHSDRu?=
 =?utf-8?B?OHFYUkNZckxiMXBsbHYzRlI2ZFJuekhaR0pZZG1DdFRLY0xaT1grSzhlU2RK?=
 =?utf-8?B?eXNHN2ttVkJWV0FkWG5YblpGTzhKZlNqZTNrMklhRVNaN2IyaVJqQUNKVS9E?=
 =?utf-8?B?Mnp0Nmgyd0dwSUNoNVQ0RmgzN2w2TDRST05xcFVpRFFmUVM2YzRHMUZFQUx6?=
 =?utf-8?B?RlowMmg3eXRuUVdpY250Y3VaRXp2d1ludU54SEVSSk40MGVpc01Lc1BPeGY5?=
 =?utf-8?B?QWZyR25WbVlTRmF0TEdWR3BJdURWVXp5RGg2NG94VFFHNTdyZXZyOU1LU2Vr?=
 =?utf-8?B?SFVVaGlzZGd2WHcwVXBZc21uNDhrcmhaU0RkenBWVWdMaUxObmJ2Ym1LUEg1?=
 =?utf-8?B?eHZhRzN1RnhxRzlFbXExNjBoYU8vaCswUXNJQkNjb3lqVmk4RG9uUmN5a2Rm?=
 =?utf-8?B?ZWZydlRTc1FoQlFON2pWTnc0REN6ZnozRmY2WVk2bDNwOVpMRDRTSEVJbWZ4?=
 =?utf-8?B?S0cvUCtkeGh3ODB1Z2lMaHlRdkh5SUtmUEZMY3d5VTJBOThOcnhtUGN5aTRT?=
 =?utf-8?B?VkR2TkY2aU9lcVVQRG1SeHFFald6c09aMnB2bFVKYVVoamJiemNNRUpyMzhX?=
 =?utf-8?B?ZThxWU5QeVRTTGtCdlZmcFVUMForUWpKR3BKQVJ6SFA4TEcyRlk3eEIvb2xH?=
 =?utf-8?B?allrOVRIdTlmMnRveS9wWEZMWlN0Sy9CcWdDZFJ6OWprQ1hPMFRvWnNXSjZP?=
 =?utf-8?B?aGE0bFJoakV5dmVJemdhdE8xaGErb1Q4T0dnQ1NrRVJmaHJTQjBkTlVsVFdt?=
 =?utf-8?Q?VcsrXc3sasCycXDGrpyEZ7+Fqdb+MyhzIOYBxAK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367358b8-10d7-4b66-6516-08d931165a8f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 22:30:32.9199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlidKZm1IV+xvzWDfe956ovg8lnvsfJFzSTvpY4oFnDyZK8HaK3tzCItOZJaKGJGOmsoa833I2UTSu3XSCYrHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-16 2:12 p.m., Eric Huang wrote:
> Fix non-coherent bit of iolink properties flag
> which always is 0.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 6075cbfde59f..8ef3add769d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1336,6 +1336,28 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
>   	}
>   }
>   
> +static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
> +		struct kfd_iolink_properties *from_link,
> +		struct kfd_iolink_properties *to_link)

The parameter names here are really misleading. "from" and "to" are 
relative to a device that's not even in the parameter list of this 
function. from_link is the link to to_dev. Please rename these from_link 
-> outbound_link, to_link -> inbound_link.


> +{
> +	/* CPU -> GPU with PCIe */
> +	if (!to_dev->gpu &&
> +			to_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS)

The indentation is a bit off here. For readability I prefer indenting 
this to line up with the open ( in the line above (1 TAB + 4 spaces in 
this case).


> +		to_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
> +
> +	if (to_dev->gpu) {
> +		/* GPU <-> GPU with PCIe and
> +		 * Vega20 with XGMI
> +		 */
> +		if (to_link->iolink_type == CRAT_IOLINK_TYPE_PCIEXPRESS ||
> +				(to_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
> +				to_dev->gpu->device_info->asic_family == CHIP_VEGA20)) {

Same comment as above. Also indent the last row one more space to line 
up with the second open (.


> +			from_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
> +			to_link->flags |= CRAT_IOLINK_FLAGS_NON_COHERENT;
> +		}
> +	}
> +}
> +
>   static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   {
>   	struct kfd_iolink_properties *link, *inbound_link;
> @@ -1361,6 +1383,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
>   
>   			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
>   			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
> +			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
>   		}
The DKMS branch has a second loop here for PCIe P2P links. Please 
prepare a patch for the DKMS branch as well so we don't forget to handle 
this.

With the above nit-picks fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
