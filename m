Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89003C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 15:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539EE10F260;
	Wed, 19 Oct 2022 15:14:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A003010F261
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 15:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1tIxRI23qroGBTlywf3042/YZTXsNZNqqDDJfKXxVhNEWUXhgb8hVe68Gdjwwi+Q/S9DpkhlaJI4IdnK/mjkJK0UDQ8WQT6PuhjM3/xr2W3ofoW8r+S7D9d3kTUUbuX4094qNOlHs/2vwcg7mGyePLhm1eDhzGxCxkwE5grgtPYZJetE46DzXcnfmgypn2kiBx7JM91+gvJTDA+tt419RFwzB0OzWY1J1Gj1dtjVLcDJlQpqFeWlRvssLQeE7CzFSejJK1BKOMlQKgz1mjesEZbeZKD5z/VZmjpHFl2Ef1ENoADr1ujPelGESXOPrjd63XHi2/U72y/D1xpg+S1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9hC9aIif2uXP0Q1UQIyUSJbmuJig9nmAKDKG4hx1gc=;
 b=hkwGP7yjlmM+bc+wwrXTj/sgn1G2HOCQ9NIg+ezIhrWttk9B+LCOMrNyGMPto5wUylOE+gng2gRybHScg0UkFxqI0gkSiKNpTXkHAF7x/rhOqrHKEJV13Fk5+hMGe7jfdmZSa1XMoIGS+IpUvXKxrE07a7TMfRFBNY2vOoNhOHKIoNiHxZy7P82OkXClUQe1ccBnkMZ8tKRWO3IAdoI9Nr6zh95SyUtB9q9DHfFxINu25SzzsPN8eSOHyuOR1/TYliAyAOwMe6go+IyCWwO0HucOHaht3MdESZBwxA6biSs1wGdXakC02XyEFkQDaBmH3GlfLZuddrmEuDNAz6Lsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9hC9aIif2uXP0Q1UQIyUSJbmuJig9nmAKDKG4hx1gc=;
 b=hp8P1d1AoaPTXZ9XJCuXonNwWSDSIYflX8mTfTWD06gzRIUb2ldv0xRjcQxezYG/FyrCoiypW1BoaIIyWExqjXSF3sUZajYZ9zteKqWpG46VpvtpGbM9FE3lquXYW1NfX4eMo7WD88bpfpzSFv3QJ1k6pvZqoX9oihcQ3nF4E10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.31; Wed, 19 Oct 2022 15:14:34 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 15:14:34 +0000
Message-ID: <ee217b86-81ac-b5c2-a50b-e6f8c3f31079@amd.com>
Date: Wed, 19 Oct 2022 11:14:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/5] drm/amdgpu: Introduce gfx software ring (v8)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221018090815.2662321-1-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221018090815.2662321-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::13) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a489fc0-8c07-4124-9c03-08dab1e4a133
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bw94HgIZ3nLKWhPmGoPv23vjnpQ3SH0+OmEN263lBTS5e/yrY1/xxHhC73PVo3Ct3vaa3U1FY3ow5P98mvBqBo9cfoP97w9aryWMwSe7X4SDyQGCKYSDnj09V9WGutoO5zgp3ht0Uuo5dvExY1TqBcmixqrCRgTeuDq0EU6UccY5iJBDWkDbAqhgi8fqVhajxXOUoJa75AfA7IvdEQZWBcs9XLdJm53K6k1XTzfTa/KjZSNZiAeQtnUl0Hx1OkUYZMymILPCO44J4HlJSrt0AFCKJrnqnHOJQL7x9vGVeLBBMapjnxwkZgk44/xT1EBURBEgNdbWnMXvRoUwPLBTWT+O8PVowtnlB2c0XT7uKAep7NJEbHro7PT3gMeyB35TpvSKVqvi9wkik5nfeHwtdIHphdhyKUDB9E686yNV8q18JpIdANygQwtbdkQd2GJPvtbX53G0HNrX6FuJcZYMJBjQl9wzyx0oWNG8V+yeZeKbyN5mqSWc+eFalPA3XMCbdIPVgoawYBHCuY//QWwzA43gAtCTzojs7l0KxiAQSRdpGslxQ44nGTSXWZ4/hb4DBH2/ku0N460uH7IwNlp8S42jrqw6Ql5n1WQXFvrUXpoggvA/RQcZJzdhCuWO5Pm1Hw1wnqFhFbg2SNK7vOiuwyp3LlcVm9B6xZHZmjRebypZJG5Moc72DumzGAoKxYzfOk0VRIZFbCM2otRUtZqxq+60XsduWheA49fKy8g70i0r7c7S0BPlw4vsOLLQ+XFNkApEcQho33r9+j5VrB7VqE13DSiuudXrzAc2pCi7jvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(66899015)(6486002)(316002)(54906003)(478600001)(6666004)(66556008)(186003)(2906002)(4001150100001)(4326008)(66946007)(66476007)(8676002)(6512007)(6506007)(8936002)(53546011)(41300700001)(26005)(44832011)(30864003)(5660300002)(2616005)(36756003)(66574015)(86362001)(31696002)(83380400001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hXZllleGtERGJCSEI3d3AwTkdPd3lmSWVXRlBDQURHT0dPRW9RWVRYTUl1?=
 =?utf-8?B?Q09JRUNkNzBFRUUzUmRVWFdYcXNJRU5XNnUyV2RTVnRCTWJjNjNKYWppT2Iv?=
 =?utf-8?B?S2lQeVBTU0orNURoT1REYzZSbjdmVFozUmsyRG9zUmhFb3N5dS9wcVhzL1di?=
 =?utf-8?B?aENSVjF2ZlZoNFpyN3JEa3lFWllVQVMrT1NkSitELzdBeDJVakJSUkIxRm5j?=
 =?utf-8?B?SUhnajBRaFRpZ2ZOSWpLb3RRTmNtajY0bFNrRm1Wak5PTDBBc0hqbkY4NVZY?=
 =?utf-8?B?djhuU01EVHFhNVByNkhSQkZrY2l6NVBoOTFrSnZvUjBFM2E0VkVhek1zNmgv?=
 =?utf-8?B?RTk5UXlRN2J5WmVGTEdUQWZXTW5ZbkdPLzhTWFY0S05YODh4ckpSeC9RYkxm?=
 =?utf-8?B?ZWc3TnhwT3lwK0x6UlZXWmhEVGVLZlg2cXZmTXcwS2ZLbUREVEJHTkxqTHNy?=
 =?utf-8?B?cHhyVC9aQmZ6cVBJVnVWQXJySWE2WHNvTVp2OUVUek9wYjQzZmwzY3dmM20z?=
 =?utf-8?B?enY3MWhJUUZ6S293UUh1SmZOc0tySXYrSy9qZlMxTlVNNzZ5S3pzMDVaVXBr?=
 =?utf-8?B?T0lUQm1qdEZpU1hhQWZmOUg0L2hNeUN2K3NqQjlpQll3MFVNRGcxVzRRTW1n?=
 =?utf-8?B?VHBiQ0NFVG1SckFVMTd1bnFmZjQvZE5YZmJJQUkySE5JMUtLOWFEWGtHTFh4?=
 =?utf-8?B?cWl5SEJvc3VxbjBlTmIxS09nWFdOOHBUMnFEemlwVzg5RUVscHRCZGoxN0t1?=
 =?utf-8?B?QUxzV0FkZHpKTlN6a2xxMFJ1L0Y5WmhOcHpSQzUvZ0dVVjJvbG9rbG9vejJK?=
 =?utf-8?B?OC9TS3JSNHJjOHZzemF6clJSY20zYjNTeU5hWEZPNDAvbXN6RVlteUh5ZkFz?=
 =?utf-8?B?cENOQ2xMbnU2d0hOSXI4WFR4bFhCalNOaHpVdEJPSkZ5Qk9mRTlLdWYvakVJ?=
 =?utf-8?B?R2VpZDhmZjZuSS8zY1NMTjUrVS9jUmo2cFVDc0lrdmlxWjRDa2Q4UW9WekEz?=
 =?utf-8?B?ejJWaHlrbzZmODEreEY2SFN3N0tCbzcxTnhneUIzbDJpQndBalRRUEx3ZU1t?=
 =?utf-8?B?aFdSWW1NZGEva3RkN1BzU2o0dFVuOFVsT1BRdmlmUUpYVVA1QW8vY1crc2cr?=
 =?utf-8?B?YnBTUTJkNVIzVmdHU2pjbEF0TC9aMno4d1ZzK3l4VmhVb1AycTd2TzdIV3ZB?=
 =?utf-8?B?K1YwR2FzSlBGRnR3emtCOHZycEtHSXd6cEthQ0xyc3c4cTNmaTRFeEJkTk0v?=
 =?utf-8?B?aWZMS1JKQ1hJQmc4WFlNRDFQRHRndnpIbnZkeS9TMmN1enBkRTVLMXFSR1du?=
 =?utf-8?B?ei9vWkFoTWk2cFlTS2tnK3BBNzNycFN2NUFVWHFGRFJEU2JoOE1KSXFXNExp?=
 =?utf-8?B?aTZJUXNLNmZ2dGV6cXZOZ1dGWHdGWkMzR3g4QW5kMFhqTFYycU9rMUVDVHQ0?=
 =?utf-8?B?UU9BQmY4TXA3OUdmZEovdkJkV2FMOElnamF1cHl6UFJhczEybTQvWHdOcE4v?=
 =?utf-8?B?dC9wWVVYbEdpVEo1K01ST3JSR005bldreU1zRDIrY2lqS0hVWlFXcXJNeFlT?=
 =?utf-8?B?K3NyWU92V05XTDd4NGxMeHNUTnNqbFhyM1Y0YjlUK2xjd2dpUmNIcHRHVTdr?=
 =?utf-8?B?YktVVUU1a3RFbmg0WFBCK3ZQK0NKVFFjNDBpdlc5RFh1eStGRk5YdGNJQVVt?=
 =?utf-8?B?UkY4eUpWeFUxMWhDWkNlQjdiU20xNkRxeThlQ0xObFA3cm5rVTVhUkttSkF0?=
 =?utf-8?B?elh4RnF3MThKV0dCZFJLU1ZqUFk4T0YvM291akt5eTFvWE1YUjVBSnd0ekdY?=
 =?utf-8?B?OHdQZnY1Q3ZLS0dsTVV3dDV0MXFDeU9TbmgyZVU1Q21sWkJFbW8vWDd6bkFK?=
 =?utf-8?B?cURUNE5SM05QZlJOeDMxUitlb0pnWDU5bDRoaWVDQktIMjFsSXM5bml5ek5E?=
 =?utf-8?B?eFdnZEwxVkx2emhnK0l6cFl3NU1NQmxyR1FwVHFpYk43VlBERUxLdHYzNVFs?=
 =?utf-8?B?eWFrUWd2SlpOb3ZCeU1NN1hza3djSnIzdUdtbDZDR0o4V2o2MGVqS1B5U2VP?=
 =?utf-8?B?OEhBdlgxbDZOQTZPZE9DNEtuYTlhNVcwMmp4cGkxcWw1SDN5WG55bU9GQitr?=
 =?utf-8?Q?uXpzKene7Gc4zkbVUJ7rWfxvB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a489fc0-8c07-4124-9c03-08dab1e4a133
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 15:14:34.4645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0opdailJj7w6d3vWVmWSaVQo7sv7ew6so5USr7oxcgZi/9U4feNRSA7A9PZ/SJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Huang Rui <ray.huang@amd.com>, Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inlined:

On 2022-10-18 05:08, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> The software ring is created to support priority context while there is only
> one hardware queue for gfx.
> 
> Every software ring has its fence driver and could be used as an ordinary ring
> for the GPU scheduler.
> Multiple software rings are bound to a real ring with the ring muxer. The
> packages committed on the software ring are copied to the real ring.
> 
> v2: Use array to store software ring entry.
> v3: Remove unnecessary prints.
> v4: Remove amdgpu_ring_sw_init/fini functions,
> using gtt for sw ring buffer for later dma copy
> optimization.
> v5: Allocate ring entry dynamically in the muxer.
> v6: Update comments for the ring muxer.
> v7: Modify for function naming.
> v8: Combine software ring functions into amdgpu_ring_mux.c
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky  <Andrey.Grodzovsky@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 217 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  76 +++++++
>  5 files changed, 302 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3e0e2eb7e235..add7da53950c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_ring_mux.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 53526ffb2ce1..9996dadb39f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -33,6 +33,7 @@
>  #include "amdgpu_imu.h"
>  #include "soc15.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_ring_mux.h"
>  
>  /* GFX current status */
>  #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>  	struct amdgpu_gfx_ras		*ras;
>  
>  	bool				is_poweron;
> +
> +	struct amdgpu_ring_mux          muxer;
>  };
>  
>  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..40b1277b4f0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -278,6 +278,10 @@ struct amdgpu_ring {
>  	bool			is_mes_queue;
>  	uint32_t		hw_queue_id;
>  	struct amdgpu_mes_ctx_data *mes_ctx;
> +
> +	bool            is_sw_ring;
> +	unsigned int    entry_index;
> +
>  };
>  
>  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> new file mode 100644
> index 000000000000..43cab8a37754
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,217 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <linux/slab.h>
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_ring_mux.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu.h"
> +
> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +			 unsigned int entry_size)
> +{
> +	mux->real_ring = ring;
> +	mux->num_ring_entries = 0;
> +	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
> +	if (!mux->ring_entry)
> +		return -ENOMEM;
> +
> +	mux->ring_entry_size = entry_size;
> +	spin_lock_init(&mux->lock);
> +
> +	return 0;
> +}
> +
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
> +{
> +	kfree(mux->ring_entry);
> +	mux->ring_entry = NULL;
> +	mux->num_ring_entries = 0;
> +	mux->ring_entry_size = 0;
> +}
> +
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	if (mux->num_ring_entries >= mux->ring_entry_size) {
> +		DRM_ERROR("add sw ring exceeding max entry size\n");
> +		return -ENOENT;
> +	}
> +
> +	e = &mux->ring_entry[mux->num_ring_entries];
> +	ring->entry_index = mux->num_ring_entries;
> +	e->ring = ring;
> +
> +	mux->num_ring_entries += 1;

Why is this all the way down here right next to the "return 0;"?
Move it up, so that it is clearly visible and in context,
right after "ring->entry_index = mux->num_ring_entries;".

IOW, the "adding" of an entry should be clearly visible and in context.

So it should look something like this:
	...
	e = &mux->ring_entry[mux->num_ring_entries];
	ring->entry_index = mux->num_ring_entries;
	mux->num_ring_entries += 1;
	e->ring = ring;

	return 0;
}

With that changed, this patch is Acked-by: Luben Tuikov <luben.tuikov@amd.com>.

Regards.
Luben

> +	return 0;
> +}
> +
> +static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
> +								struct amdgpu_ring *ring)
> +{
> +	return ring->entry_index < mux->ring_entry_size ?
> +			&mux->ring_entry[ring->entry_index] : NULL;
> +}
> +
> +/* copy packages on sw ring range[begin, end) */
> +static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
> +						  struct amdgpu_ring *ring,
> +						  u64 s_start, u64 s_end)
> +{
> +	u64 start, end;
> +	struct amdgpu_ring *real_ring = mux->real_ring;
> +
> +	start = s_start & ring->buf_mask;
> +	end = s_end & ring->buf_mask;
> +
> +	if (start == end) {
> +		DRM_ERROR("no more data copied from sw ring\n");
> +		return;
> +	}
> +	if (start > end) {
> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
> +					   (ring->ring_size >> 2) - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> +	} else {
> +		amdgpu_ring_alloc(real_ring, end - start);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
> +	}
> +}
> +
> +void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return;
> +	}
> +
> +	spin_lock(&mux->lock);
> +	e->sw_cptr = e->sw_wptr;
> +	e->sw_wptr = wptr;
> +	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
> +
> +	amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
> +	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +	amdgpu_ring_commit(mux->real_ring);
> +
> +	spin_unlock(&mux->lock);
> +}
> +
> +u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return 0;
> +	}
> +
> +	return e->sw_wptr;
> +}
> +
> +/*
> + * The return value of the readptr is not precise while the other rings could
> + * write data onto the real ring buffer.After overwriting on the real ring, we
> + * can not decide if our packages have been excuted or not read yet. However,
> + * this function is only called by the tools such as umr to collect the latest
> + * packages for the hang analysis. We assume the hang happens near our latest
> + * submit. Thus we could use the following logic to give the clue:
> + * If the readptr is between start and end, then we return the copy pointer
> + * plus the distance from start to readptr. If the readptr is before start, we
> + * return the copy pointer. Lastly, if the readptr is past end, we return the
> + * write pointer.
> + */
> +u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	u64 readp, offset, start, end;
> +
> +	e = amdgpu_ring_mux_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("no sw entry found!\n");
> +		return 0;
> +	}
> +
> +	readp = amdgpu_ring_get_rptr(mux->real_ring);
> +
> +	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	if (start > end) {
> +		if (readp <= end)
> +			readp += mux->real_ring->ring_size >> 2;
> +		end += mux->real_ring->ring_size >> 2;
> +	}
> +
> +	if (start <= readp && readp <= end) {
> +		offset = readp - start;
> +		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
> +	} else if (readp < start) {
> +		e->sw_rptr = e->sw_cptr;
> +	} else {
> +		/* end < readptr */
> +		e->sw_rptr = e->sw_wptr;
> +	}
> +
> +	return e->sw_rptr;
> +}
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_mux_get_rptr(mux, ring);
> +}
> +
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_mux_get_wptr(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	WARN_ON(!ring->is_sw_ring);
> +	amdgpu_ring_mux_set_wptr(mux, ring, ring->wptr);
> +}
> +
> +/* Override insert_nop to prevent emitting nops to the software rings */
> +void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
> +{
> +	WARN_ON(!ring->is_sw_ring);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> new file mode 100644
> index 000000000000..d91629589577
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -0,0 +1,76 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_RING_MUX__
> +#define __AMDGPU_RING_MUX__
> +
> +#include <linux/timer.h>
> +#include <linux/spinlock.h>
> +#include "amdgpu_ring.h"
> +
> +struct amdgpu_ring;
> +/**
> + * struct amdgpu_mux_entry - the entry recording software rings copying information.
> + * @ring: the pointer to the software ring.
> + * @start_ptr_in_hw_ring: last start location copied to in the hardware ring.
> + * @end_ptr_in_hw_ring: last end location copied to in the hardware ring.
> + * @sw_cptr: the position of the copy pointer in the sw ring.
> + * @sw_rptr: the read pointer in software ring.
> + * @sw_wptr: the write pointer in software ring.
> + */
> +struct amdgpu_mux_entry {
> +	struct                  amdgpu_ring *ring;
> +	u64                     start_ptr_in_hw_ring;
> +	u64                     end_ptr_in_hw_ring;
> +	u64                     sw_cptr;
> +	u64                     sw_rptr;
> +	u64                     sw_wptr;
> +};
> +
> +struct amdgpu_ring_mux {
> +	struct amdgpu_ring      *real_ring;
> +
> +	struct amdgpu_mux_entry *ring_entry;
> +	unsigned int            num_ring_entries;
> +	unsigned int            ring_entry_size;
> +	/*the lock for copy data from different software rings*/
> +	spinlock_t              lock;
> +};
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +			 unsigned int entry_size);
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
> +u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
> +
> +void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
> +
> +#endif
