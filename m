Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F42C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 06:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE4E60E08
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 06:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AE4E60E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777E76ED09;
	Thu, 23 Sep 2021 06:47:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8219B6ECEB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 06:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4oSDbS2wsmaXP7D6d23/4lixTHStzzSWAxxwVcUzDhxIDQtwaBsMA4aJxk5HGw87VZyQ7cG1ENA6+OSweUI4eoVv3PslPG1eLn/lKQtRC/uQiLz7kDSpKNyVQj/Uo4aBmwzllFpbbpPnOUk9sy3t1ibMog+V7EPLDB/JCoTT/GXoTwH+WaFZw+3h2EDYBAVu4f8nMOfckpGg36Ja/H6Zaz3eqhhsWOW5deyjPjSuhqaLX5CxHsmiLbRO7jbGDn0+4pY+pAcUPLVaPIjUuE+FyzYPqcpqyhVqDCyz2aXDsj8jPcvwfmwxPvIeFCnlFt38GjivLTI00TWRfSPM2YNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ytS0BZFyVvIGu+GDwKHzT0n685gTBKLM7IJtlOEHbBs=;
 b=XbGINrt7d3N1ICyEXLexOUVrT7whzjiEGsrU0ZCTFUIco5vFfYbuJyPtM4Tf7lLto6ERc3cS0CW8tzanVtTqv8HdohfA8Hdv1YQZjBj05AN2I5bu1hI81hvaXkn7igc6tZMeXpj3dJWTr+sh03Xq+dMd34eHX30brBqRSPvYUPtGZfPL3uV20q5sNuNe9tf3Ke2JpEnidLHiXh3gzJAjgmsVCIpP7l+ATZMhuIsGWggbSwDqCT45OSwfAfSoNNi95Gp1hdBJooiKlww0G1g09wvj1H2UbFhm/EGArjQ8I5OonH2Hkvtl5RX4Iy9eMM/djVFdcM+DRNij+80+UsBRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytS0BZFyVvIGu+GDwKHzT0n685gTBKLM7IJtlOEHbBs=;
 b=aXiUhqI5rV+54EwVV95uLzx7h79VVTfH67JG92ASvx07fY0s/2wxpd2kQUnrUMTCtMKsWdaITyqGKSpbGPD7cyqWkF/3exr9YxwqKqL0wekAIqnid0fc5v6BzA1cShCnDKjXoX6Verd7RJRbbY40decrhywC1HZ8iV1G43hu3OI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 06:47:51 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 06:47:51 +0000
Subject: Re: [PATCH 60/66] drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type
 by default
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-61-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <2bec6445-429a-c12e-f807-6105d99051a3@amd.com>
Date: Thu, 23 Sep 2021 12:17:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-61-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:98::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 06:47:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32cd36c4-3b1a-4a47-c56a-08d97e5e0ff7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11470B4B3DEBEECBC74244E597A39@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duNGhL5OyHPnBM9Q4rBqQdtpobpqxPUuonaF6F2t0wpMKvmend+0asGSe4oJ2eySQdMph5rCzIkdrtqlCDROfAsL0N4L/wcoX56XLq/0ggDMsw+eHzcvP/7TG9dJLTCir6Ud4vQf6nkyLgFHmVY0G2h0c0rMMYMamP5dyfgTwvldAuQhYEvYOC2Ma+DEW7o3Je9TuUZ1nVOMrOPvkEMcyQ2qNv4UrVGyejjTwTS/zS9nDbJTlBYM3U37+oTM4se8RsKVSi3eGne8CDfjwQoptF07CdBID/i4tzc0FvR5L6sS/HcQkRgySGWh0ltPGRqGJB8JBQaGhnnZeMF+kLqxFfFX6oa1sZiUtKJWSVPw0Ga+NjpiKuqVwI1aUBdcK16XwBvutvTNV1LOhQWasB7Axim6hUJWeSbG2mDUn5uFLLi3p8T1P53K6c1oA6T4uXUkJlsBep2ux7CouApuTsLvU/c7tXjcnyQB7+MFd+iWPRUfv9DbNTB1csGCj/SjOk+owXFgTOCB1tRBGH+3ogSM5SiV0h2meVl2ktwoQ4ST5bXmU8CbhonA0srZgAhweiu+gzRkpN6Ej2SYpCHfeGqMqWh87K78JEdjnWfIm1Y41aygW+jtIiW825U8tg83i1ZFOmPNX57U3NcljwSD8NLQ7AJ4zMUnrZMwUHNN0ZTwfk9AxeSkZGHrUpjsyMvcH0l6rg9IA3wZ/r/ZrvNzMvWwVsmXg/8Fk2vlwj+6PpWlo2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(83380400001)(186003)(2906002)(66476007)(508600001)(38100700002)(956004)(53546011)(26005)(2616005)(31696002)(36756003)(66556008)(86362001)(66946007)(6666004)(31686004)(6486002)(5660300002)(316002)(16576012)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXRtSUM0VkdtcE00NjNDaDFvVEJ2VFhhb3B6enBWakp2c2RTSUhYNDRWTG5E?=
 =?utf-8?B?TDlhdVY5WGxBa2xwYW1zcjMzNzBwMUFQTFY5RTB4a0pBVE9oTDBBU3JzVzN4?=
 =?utf-8?B?UmpsQVFDa2pVck96TkRHMXNHV0tpeXQzWlhUWFJzZktzeXBReE8xbkZTMndS?=
 =?utf-8?B?U3d6bzNZM1JySHdiVUtjWUJYM0NiWlpPai9CODVRU1R6SmpsYnVTcUw3L0M0?=
 =?utf-8?B?bUhRNUxhdC9Eb0JJVkR1OHZ5dHdnZDJWVXRVQTMrSkJDbmErb2Z3OWNzV1p2?=
 =?utf-8?B?Q24vQUx5QStPb3YzeThlZHdZYVA4d1M2aXB3S0JxTlpaOTd5c2VTQzdSdnkw?=
 =?utf-8?B?akdJOTJvekF1U2xZUVBBZEtGWWFpQmdUVEZ3TGJSYWtFWW5JZEpaZWd5am1P?=
 =?utf-8?B?RTNCNytEYTU3VUtUbzZoUHQ4Y2ZjUXJoNW9ndnp4K0RBRUVaSXVYYitWWXlq?=
 =?utf-8?B?N2szc1BFWFJITlJzOEhMaURnTVhnbGd4S1lQUFNhK3FPVEFCRWxyakVaNXFq?=
 =?utf-8?B?Q000TFRveUdhRzdkYkErTU9zajlCbUQvWmIxOHc0NGVPNGg1dFhpVWlYVUZt?=
 =?utf-8?B?TkVrZFhiRnl3M1Jtc2lGN3JVSXlNcVFuRndPL1N1OVhZYUNGaVFCQlJ3MElk?=
 =?utf-8?B?Y3BIaUIrM3ppaU1sUjBDVmxVTmpPQzJoMmlyd0d4MXFFbDgvTEhEYXFtTTE4?=
 =?utf-8?B?aHpwTUZyaEJPWTBaUVFmV1pZMG5EVWJEL01La1Z6dGR2c3l1SVRzbEtkQjg0?=
 =?utf-8?B?UXdnemxwNnBLMmgrdmpka24rbkZuc24vb0gwNUhZeFBVUXNrM0dJcVZFYXBp?=
 =?utf-8?B?SGpvQ0lBZlZUZjFBdnpwTWpoMW5LU2tlL3k3Z29oYitDN3VNREJDK3Q4Rk1L?=
 =?utf-8?B?dnVMRjlxeE50czFxM0FIOHVZcVZwME05WmV1OWUxTnlUUWQ5SG1mMG5PWVA1?=
 =?utf-8?B?OWNhRDRXdS9ZdHdaK1h1R3ZXMzYzUDBYOUtUdjZDbjdIcG1VSjFrNkRtZ3c4?=
 =?utf-8?B?OElweUwvdVhxaWxRd1E0OHF1VFEyczV0ZGV2aldhaFRPWDdyYVVMcE01eGpw?=
 =?utf-8?B?QzRwWWtVSVd6Rit5S2cxSzg3dlJoV3YvL0lyd3NTVnRmTjFJUGtuV2Y2cUhQ?=
 =?utf-8?B?ZGhDMFh4V3FDMEVKS3JjQWttU3JTa2VVSW9OeTFPbmlJWXpQNFVudFJVc0xZ?=
 =?utf-8?B?Zm9Jd2kwL2RtYkIwYzhUcy81N2ZlL1g2d0hKNmE3MERIVzUzbWtNS0dhWXVH?=
 =?utf-8?B?aU11UVV4ZWJTK1cwbEFCb08xOU1xdjlLTmgwMlVUQnJRaHlvQXdTWkQycUZ3?=
 =?utf-8?B?UXJFMzRWU0F3YWFNTDV6SEtKQUVMMXZnS3BjU0x0bVdXZVU3cWg2TTlUUGF0?=
 =?utf-8?B?V2h4cnZON0NsaG9uYkpzaTJLUzV0Y2RlODRxV3h2WkhuMmRmeEdJN0JzdG1v?=
 =?utf-8?B?S3djbVkrTkllWFRsVFpZajlsbCt4eDZ6bWVLaFFTQVN6NHJRS2FXdHNKcCtU?=
 =?utf-8?B?d0lScmJCV0pxQzlSbEtxV09mMy9EN2FmV2ZqZmZ2RUt4cFhkQWpIZndERTB3?=
 =?utf-8?B?YkdSNE41SEV3OUZoN3N3em5IYTlHektXTDhKZEM5RUpERVJFWWNIczB3MEY4?=
 =?utf-8?B?cXhibTE4emJ2ZEpBMlVlYVdTZzhUandqcDcwZml5bjN3WGFkYjhoMkxTVDho?=
 =?utf-8?B?V2pzSml4U3pyWXZ3RFpZM29FS0JMcjF3My9ScEIwY2dmTUNKNW81dEZoSEFa?=
 =?utf-8?Q?g2dDiOGb4RrZ30AGKdsfBtlczb6BmtZ7PWbF8ZE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cd36c4-3b1a-4a47-c56a-08d97e5e0ff7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 06:47:51.1386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz8RmSc08Q9mLo6wTtjcJ61fAIKL4Z1rb9s3YXss+uFY5Fxztlt6JrIXA+MKQNrS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
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



On 9/21/2021 11:37 PM, Alex Deucher wrote:
> For new chips with no explicit entry in the PCI ID list.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index c21eac6216a8..c7da1f7cc880 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1796,12 +1796,12 @@ static const struct pci_device_id pciidlist[] = {
>   	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
>   	  .class = PCI_CLASS_DISPLAY_VGA << 8,
>   	  .class_mask = 0xffffff,
> -	  .driver_data = 0 },
> +	  .driver_data = CHIP_IP_DISCOVERY },
>   
>   	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
>   	  .class = PCI_CLASS_DISPLAY_OTHER << 8,
>   	  .class_mask = 0xffffff,
> -	  .driver_data = 0 },
> +	  .driver_data = CHIP_IP_DISCOVERY },
>

While listing the devices one by one, some of the below flags are also 
used to indicate the device type/support. Since the patch is replacing 
this method, I guess the series needs to address this one also 
(especially AMD_IS_APU, it is used extensively).

enum amd_chip_flags {
         AMD_ASIC_MASK = 0x0000ffffUL,
         AMD_FLAGS_MASK  = 0xffff0000UL,
         AMD_IS_MOBILITY = 0x00010000UL,
         AMD_IS_APU      = 0x00020000UL,
         AMD_IS_PX       = 0x00040000UL,
         AMD_EXP_HW_SUPPORT = 0x00080000UL,
};

Thanks,
Lijo


>   	{0, 0, 0}
>   };
> 
