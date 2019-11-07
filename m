Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4BFC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 21:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049D22084C
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 21:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049D22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD41E6F7D8;
	Thu,  7 Nov 2019 21:49:03 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820052.outbound.protection.outlook.com [40.107.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD81F6F7D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 21:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwxT6rzTR/7cnSZEviLcA/siaA2Y33epIiAik3ZckiR0zsQ5P46D/r0woteNFxCm9iauQElK3UAoXBYBq5zpZZkPmjrttlcMAQQDrjX5dgcr9xIQWovd8dlGbS13W1bnZ//GC2SJNVWyK6fmqvZEfSjtXscCMYwKqVkaPDHAOpoyFvHUXhKIqIe1jtL5DzrKJ+b4xw8W0+qh3ylWmQIpWPXHlXJDHd28CrngLLGUTXIKSQ8lq5IwxNvvDfrmIMgmrTV2NPbo8xLZDf5hQWdcsL6kv3St8BbmQtQpHYuIigKo8yzaruJXQBersDZbrm6Xys7FLH5dBhXiWB8JL9KytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPS2I8GHmsffdnFtuw9ePUjMcA3gyNPJ7r672T2Y/AM=;
 b=fJS5DxNtto8tKzsO3359errAPsFLahAKsYPjKevSztcoc+NS8z0LULREM2wFacLntOJzAJhQBrCcjKp+Sydh0foPQpUiF7Jq18aUuGxYAtt5iWBtluuTm2eKmrbFlZsFA+dBTr9RmT+nXtlvj7eNev+4uMVNz+yPHwOKC8y16EUx41mgWvR6DFqgWDbuvm3DBBITMTfmddEFvMUUK4ZyR2toxfIZz4M1ES0CWj0H8D6hWxNQTBNcd5MYG8HO9lVHvsia+XFCvBbQAIrgT+UMcV17ACXWUeTEOZ9gR0RfQ63DPeDiC2y73dujCI4hewHGGOedg/9D/PNBy6XUfYRlBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2668.namprd12.prod.outlook.com (20.176.116.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 21:49:00 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 21:49:00 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Use kernel queue v9 functions for v10 (ver2)
Thread-Topic: [PATCH] drm/amdkfd: Use kernel queue v9 functions for v10 (ver2)
Thread-Index: AQHVlaqwPhTObydgU0i3ODr2JUPiVKeAM0sAgAALM2M=
Date: Thu, 7 Nov 2019 21:49:00 +0000
Message-ID:
 <DM6PR12MB2778273C513A51D90A0109CCF0780@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191107203349.31805-1-Yong.Zhao@amd.com>,
 <f27d6f58-bb85-4431-7fbc-be7c9a6b7dbd@amd.com>
In-Reply-To: <f27d6f58-bb85-4431-7fbc-be7c9a6b7dbd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfec905a-9cd6-4edf-35e4-08d763cc4c62
x-ms-traffictypediagnostic: DM6PR12MB2668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB26688A2082B434047D7A6578F0780@DM6PR12MB2668.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(189003)(199004)(51234002)(7736002)(6436002)(14454004)(54896002)(55016002)(14444005)(74316002)(6246003)(76116006)(25786009)(52536014)(66066001)(8676002)(33656002)(186003)(7696005)(81156014)(3846002)(6506007)(9686003)(76176011)(316002)(53546011)(81166006)(8936002)(229853002)(26005)(446003)(11346002)(6116002)(486006)(256004)(2906002)(476003)(102836004)(110136005)(64756008)(30864003)(66556008)(71190400001)(5660300002)(478600001)(19627405001)(66946007)(86362001)(71200400001)(66446008)(91956017)(99286004)(2501003)(105004)(66476007)(579004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2668;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4vZa3RVb8fqbNyaTPtyj1bAGowwVj57QCfhHSHStyTVwVXyAiZcYL4iuPIk8gK0qOr5h6NlYeRZXi4PWi4fvrAMXCx9rjhz6aqBpcy8sHvJEG2OM6LuDV3SVVmoPJlo7j0x/qeZJgp4E/WNl59Vj1I27Ln/nHWnuJaqoLMu8GP4K7GPRSWP7AoYQvmvFSY4ywWsqzntTGAVCKPv7Hbp49wZI8Qzn+pR9FgPdESWkJCHzwCfk0X2audPTRApxi1BRBSFFAoB1zhYNH6NajvCTLdTnFiYSuGX0vn4PAiJldNO6hR2EFSl94c+p/Nr1sirwLGDFj3Fr1xKq7lBmvCTlSpsJaTqH6v3nQhtLPlm9d77YYCPFxrjekirnG/PypU1H4zr8ER9dBYR4WDiXMQjSex9sNOESmb4D9i1TqN6txBASpaOx0hDdcW0SPFu20Aq3xNf7h2peQ6fV3F7DXTXMww==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfec905a-9cd6-4edf-35e4-08d763cc4c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 21:49:00.1138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDz0V5Pc1lsTS3bFqGajWGcAErhFQ2NhMmdJ4aUbnlQhHy21D/ZHDDppIqmWNHPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPS2I8GHmsffdnFtuw9ePUjMcA3gyNPJ7r672T2Y/AM=;
 b=eX7buU3L8VZMOaK7ymFZeQvJsdIJA5G9y6zuayQm+mKBy7zWsf+957cxsRwm9y1TzBPdHP6+mmEFY5lnN/PajPG2YW0yMg9h+SoSnj+xQkrzipZ/pAbm3+dkUUuxk12dd2IvGwBZgLEk1SNZBq7ssa9gIS2A7uQ696hPjy2PCJ8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0828746311=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107214900.O7I7ygflMEW6v0gm3yachuRYgKiq-exIAKD0ipWoDkc@z>

--===============0828746311==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778273C513A51D90A0109CCF0780DM6PR12MB2778namp_"

--_000_DM6PR12MB2778273C513A51D90A0109CCF0780DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Okay. I submitted a PSDB. Meanwhile, I got the answer from FW and SQ HW con=
tact that nothing bad will happen on GFX9 by writing 1 to TRAP_EN.

Regards,
Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Thursday, November 7, 2019 4:07 PM
To: Zhao, Yong <Yong.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Use kernel queue v9 functions for v10 (ver=
2)

Are you sure that setting the SQ_SHADER_TBA_HI__TRAP_EN bit on GFXv9 is
completely harmless? If the field is not defined, maybe setting the bit
makes the address invalid. It's probably worth running that through a
PSDB, which would cover Vega10, Vega20 and Arcturus.

If it actually works, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
   Felix

On 2019-11-07 15:34, Zhao, Yong wrote:
> The kernel queue functions for v9 and v10 are the same except
> pm_map_process_v* which have small difference, so they should be reused.
> This eliminates the need of reapplying several patches which were
> applied on v9 but not on v10, such as bigger GWS and more than 2
> SDMA engine support which were introduced on Arcturus.
>
> Change-Id: I2d385961e3c884db14e30b5afc98d0d9e4cb1802
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/Makefile           |   1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |   4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h |   1 -
>   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 317 ------------------
>   .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c  |  16 +-
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |   4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   4 -
>   7 files changed, 14 insertions(+), 333 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/am=
dkfd/Makefile
> index 48155060a57c..017a8b7156da 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Makefile
> +++ b/drivers/gpu/drm/amd/amdkfd/Makefile
> @@ -41,7 +41,6 @@ AMDKFD_FILES        :=3D $(AMDKFD_PATH)/kfd_module.o \
>                $(AMDKFD_PATH)/kfd_kernel_queue_cik.o \
>                $(AMDKFD_PATH)/kfd_kernel_queue_vi.o \
>                $(AMDKFD_PATH)/kfd_kernel_queue_v9.o \
> -             $(AMDKFD_PATH)/kfd_kernel_queue_v10.o \
>                $(AMDKFD_PATH)/kfd_packet_manager.o \
>                $(AMDKFD_PATH)/kfd_process_queue_manager.o \
>                $(AMDKFD_PATH)/kfd_device_queue_manager.o \
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_kernel_queue.c
> index 11d244891393..0d966408ea87 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -332,12 +332,10 @@ struct kernel_queue *kernel_queue_init(struct kfd_d=
ev *dev,
>        case CHIP_RAVEN:
>        case CHIP_RENOIR:
>        case CHIP_ARCTURUS:
> -             kernel_queue_init_v9(&kq->ops_asic_specific);
> -             break;
>        case CHIP_NAVI10:
>        case CHIP_NAVI12:
>        case CHIP_NAVI14:
> -             kernel_queue_init_v10(&kq->ops_asic_specific);
> +             kernel_queue_init_v9(&kq->ops_asic_specific);
>                break;
>        default:
>                WARN(1, "Unexpected ASIC family %u",
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h b/drivers/gpu/=
drm/amd/amdkfd/kfd_kernel_queue.h
> index 365fc674fea4..a7116a939029 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
> @@ -102,6 +102,5 @@ struct kernel_queue {
>   void kernel_queue_init_cik(struct kernel_queue_ops *ops);
>   void kernel_queue_init_vi(struct kernel_queue_ops *ops);
>   void kernel_queue_init_v9(struct kernel_queue_ops *ops);
> -void kernel_queue_init_v10(struct kernel_queue_ops *ops);
>
>   #endif /* KFD_KERNEL_QUEUE_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> deleted file mode 100644
> index bfd6221acae9..000000000000
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> +++ /dev/null
> @@ -1,317 +0,0 @@
> -/*
> - * Copyright 2018 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include "kfd_kernel_queue.h"
> -#include "kfd_device_queue_manager.h"
> -#include "kfd_pm4_headers_ai.h"
> -#include "kfd_pm4_opcodes.h"
> -#include "gc/gc_10_1_0_sh_mask.h"
> -
> -static bool initialize_v10(struct kernel_queue *kq, struct kfd_dev *dev,
> -                     enum kfd_queue_type type, unsigned int queue_size);
> -static void uninitialize_v10(struct kernel_queue *kq);
> -static void submit_packet_v10(struct kernel_queue *kq);
> -
> -void kernel_queue_init_v10(struct kernel_queue_ops *ops)
> -{
> -     ops->initialize =3D initialize_v10;
> -     ops->uninitialize =3D uninitialize_v10;
> -     ops->submit_packet =3D submit_packet_v10;
> -}
> -
> -static bool initialize_v10(struct kernel_queue *kq, struct kfd_dev *dev,
> -                     enum kfd_queue_type type, unsigned int queue_size)
> -{
> -     int retval;
> -
> -     retval =3D kfd_gtt_sa_allocate(dev, PAGE_SIZE, &kq->eop_mem);
> -     if (retval !=3D 0)
> -             return false;
> -
> -     kq->eop_gpu_addr =3D kq->eop_mem->gpu_addr;
> -     kq->eop_kernel_addr =3D kq->eop_mem->cpu_ptr;
> -
> -     memset(kq->eop_kernel_addr, 0, PAGE_SIZE);
> -
> -     return true;
> -}
> -
> -static void uninitialize_v10(struct kernel_queue *kq)
> -{
> -     kfd_gtt_sa_free(kq->dev, kq->eop_mem);
> -}
> -
> -static void submit_packet_v10(struct kernel_queue *kq)
> -{
> -     *kq->wptr64_kernel =3D kq->pending_wptr64;
> -     write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
> -                             kq->pending_wptr64);
> -}
> -
> -static int pm_map_process_v10(struct packet_manager *pm,
> -             uint32_t *buffer, struct qcm_process_device *qpd)
> -{
> -     struct pm4_mes_map_process *packet;
> -     uint64_t vm_page_table_base_addr =3D qpd->page_table_base;
> -
> -     packet =3D (struct pm4_mes_map_process *)buffer;
> -     memset(buffer, 0, sizeof(struct pm4_mes_map_process));
> -
> -     packet->header.u32All =3D pm_build_pm4_header(IT_MAP_PROCESS,
> -                                     sizeof(struct pm4_mes_map_process))=
;
> -     packet->bitfields2.diq_enable =3D (qpd->is_debug) ? 1 : 0;
> -     packet->bitfields2.process_quantum =3D 1;
> -     packet->bitfields2.pasid =3D qpd->pqm->process->pasid;
> -     packet->bitfields14.gds_size =3D qpd->gds_size;
> -     packet->bitfields14.num_gws =3D qpd->num_gws;
> -     packet->bitfields14.num_oac =3D qpd->num_oac;
> -     packet->bitfields14.sdma_enable =3D 1;
> -
> -     packet->bitfields14.num_queues =3D (qpd->is_debug) ? 0 : qpd->queue=
_count;
> -
> -     packet->sh_mem_config =3D qpd->sh_mem_config;
> -     packet->sh_mem_bases =3D qpd->sh_mem_bases;
> -     if (qpd->tba_addr) {
> -             packet->sq_shader_tba_lo =3D lower_32_bits(qpd->tba_addr >>=
 8);
> -             packet->sq_shader_tba_hi =3D (1 << SQ_SHADER_TBA_HI__TRAP_E=
N__SHIFT) |
> -                     upper_32_bits(qpd->tba_addr >> 8);
> -             packet->sq_shader_tma_lo =3D lower_32_bits(qpd->tma_addr >>=
 8);
> -             packet->sq_shader_tma_hi =3D upper_32_bits(qpd->tma_addr >>=
 8);
> -     }
> -
> -     packet->gds_addr_lo =3D lower_32_bits(qpd->gds_context_area);
> -     packet->gds_addr_hi =3D upper_32_bits(qpd->gds_context_area);
> -
> -     packet->vm_context_page_table_base_addr_lo32 =3D
> -                     lower_32_bits(vm_page_table_base_addr);
> -     packet->vm_context_page_table_base_addr_hi32 =3D
> -                     upper_32_bits(vm_page_table_base_addr);
> -
> -     return 0;
> -}
> -
> -static int pm_runlist_v10(struct packet_manager *pm, uint32_t *buffer,
> -                     uint64_t ib, size_t ib_size_in_dwords, bool chain)
> -{
> -     struct pm4_mes_runlist *packet;
> -
> -     int concurrent_proc_cnt =3D 0;
> -     struct kfd_dev *kfd =3D pm->dqm->dev;
> -
> -     /* Determine the number of processes to map together to HW:
> -      * it can not exceed the number of VMIDs available to the
> -      * scheduler, and it is determined by the smaller of the number
> -      * of processes in the runlist and kfd module parameter
> -      * hws_max_conc_proc.
> -      * Note: the arbitration between the number of VMIDs and
> -      * hws_max_conc_proc has been done in
> -      * kgd2kfd_device_init().
> -      */
> -     concurrent_proc_cnt =3D min(pm->dqm->processes_count,
> -                     kfd->max_proc_per_quantum);
> -
> -
> -     packet =3D (struct pm4_mes_runlist *)buffer;
> -
> -     memset(buffer, 0, sizeof(struct pm4_mes_runlist));
> -     packet->header.u32All =3D pm_build_pm4_header(IT_RUN_LIST,
> -                                             sizeof(struct pm4_mes_runli=
st));
> -
> -     packet->bitfields4.ib_size =3D ib_size_in_dwords;
> -     packet->bitfields4.chain =3D chain ? 1 : 0;
> -     packet->bitfields4.offload_polling =3D 0;
> -     packet->bitfields4.valid =3D 1;
> -     packet->bitfields4.process_cnt =3D concurrent_proc_cnt;
> -     packet->ordinal2 =3D lower_32_bits(ib);
> -     packet->ib_base_hi =3D upper_32_bits(ib);
> -
> -     return 0;
> -}
> -
> -static int pm_map_queues_v10(struct packet_manager *pm, uint32_t *buffer=
,
> -             struct queue *q, bool is_static)
> -{
> -     struct pm4_mes_map_queues *packet;
> -     bool use_static =3D is_static;
> -
> -     packet =3D (struct pm4_mes_map_queues *)buffer;
> -     memset(buffer, 0, sizeof(struct pm4_mes_map_queues));
> -
> -     packet->header.u32All =3D pm_build_pm4_header(IT_MAP_QUEUES,
> -                                     sizeof(struct pm4_mes_map_queues));
> -     packet->bitfields2.num_queues =3D 1;
> -     packet->bitfields2.queue_sel =3D
> -             queue_sel__mes_map_queues__map_to_hws_determined_queue_slot=
s_vi;
> -
> -     packet->bitfields2.engine_sel =3D
> -             engine_sel__mes_map_queues__compute_vi;
> -     packet->bitfields2.queue_type =3D
> -             queue_type__mes_map_queues__normal_compute_vi;
> -
> -     switch (q->properties.type) {
> -     case KFD_QUEUE_TYPE_COMPUTE:
> -             if (use_static)
> -                     packet->bitfields2.queue_type =3D
> -             queue_type__mes_map_queues__normal_latency_static_queue_vi;
> -             break;
> -     case KFD_QUEUE_TYPE_DIQ:
> -             packet->bitfields2.queue_type =3D
> -                     queue_type__mes_map_queues__debug_interface_queue_v=
i;
> -             break;
> -     case KFD_QUEUE_TYPE_SDMA:
> -     case KFD_QUEUE_TYPE_SDMA_XGMI:
> -             packet->bitfields2.engine_sel =3D q->properties.sdma_engine=
_id +
> -                             engine_sel__mes_map_queues__sdma0_vi;
> -             use_static =3D false; /* no static queues under SDMA */
> -             break;
> -     default:
> -             WARN(1, "queue type %d\n", q->properties.type);
> -             return -EINVAL;
> -     }
> -     packet->bitfields3.doorbell_offset =3D
> -                     q->properties.doorbell_off;
> -
> -     packet->mqd_addr_lo =3D
> -                     lower_32_bits(q->gart_mqd_addr);
> -
> -     packet->mqd_addr_hi =3D
> -                     upper_32_bits(q->gart_mqd_addr);
> -
> -     packet->wptr_addr_lo =3D
> -                     lower_32_bits((uint64_t)q->properties.write_ptr);
> -
> -     packet->wptr_addr_hi =3D
> -                     upper_32_bits((uint64_t)q->properties.write_ptr);
> -
> -     return 0;
> -}
> -
> -static int pm_unmap_queues_v10(struct packet_manager *pm, uint32_t *buff=
er,
> -                     enum kfd_queue_type type,
> -                     enum kfd_unmap_queues_filter filter,
> -                     uint32_t filter_param, bool reset,
> -                     unsigned int sdma_engine)
> -{
> -     struct pm4_mes_unmap_queues *packet;
> -
> -     packet =3D (struct pm4_mes_unmap_queues *)buffer;
> -     memset(buffer, 0, sizeof(struct pm4_mes_unmap_queues));
> -
> -     packet->header.u32All =3D pm_build_pm4_header(IT_UNMAP_QUEUES,
> -                                     sizeof(struct pm4_mes_unmap_queues)=
);
> -     switch (type) {
> -     case KFD_QUEUE_TYPE_COMPUTE:
> -     case KFD_QUEUE_TYPE_DIQ:
> -             packet->bitfields2.engine_sel =3D
> -                     engine_sel__mes_unmap_queues__compute;
> -             break;
> -     case KFD_QUEUE_TYPE_SDMA:
> -     case KFD_QUEUE_TYPE_SDMA_XGMI:
> -             packet->bitfields2.engine_sel =3D
> -                     engine_sel__mes_unmap_queues__sdma0 + sdma_engine;
> -             break;
> -     default:
> -             WARN(1, "queue type %d\n", type);
> -             break;
> -     }
> -
> -     if (reset)
> -             packet->bitfields2.action =3D
> -                     action__mes_unmap_queues__reset_queues;
> -     else
> -             packet->bitfields2.action =3D
> -                     action__mes_unmap_queues__preempt_queues;
> -
> -     switch (filter) {
> -     case KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE:
> -             packet->bitfields2.queue_sel =3D
> -                     queue_sel__mes_unmap_queues__perform_request_on_spe=
cified_queues;
> -             packet->bitfields2.num_queues =3D 1;
> -             packet->bitfields3b.doorbell_offset0 =3D filter_param;
> -             break;
> -     case KFD_UNMAP_QUEUES_FILTER_BY_PASID:
> -             packet->bitfields2.queue_sel =3D
> -                     queue_sel__mes_unmap_queues__perform_request_on_pas=
id_queues;
> -             packet->bitfields3a.pasid =3D filter_param;
> -             break;
> -     case KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES:
> -             packet->bitfields2.queue_sel =3D
> -                     queue_sel__mes_unmap_queues__unmap_all_queues;
> -             break;
> -     case KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES:
> -             /* in this case, we do not preempt static queues */
> -             packet->bitfields2.queue_sel =3D
> -                     queue_sel__mes_unmap_queues__unmap_all_non_static_q=
ueues;
> -             break;
> -     default:
> -             WARN(1, "filter %d\n", filter);
> -             break;
> -     }
> -
> -     return 0;
> -
> -}
> -
> -static int pm_query_status_v10(struct packet_manager *pm, uint32_t *buff=
er,
> -                     uint64_t fence_address, uint32_t fence_value)
> -{
> -     struct pm4_mes_query_status *packet;
> -
> -     packet =3D (struct pm4_mes_query_status *)buffer;
> -     memset(buffer, 0, sizeof(struct pm4_mes_query_status));
> -
> -
> -     packet->header.u32All =3D pm_build_pm4_header(IT_QUERY_STATUS,
> -                                     sizeof(struct pm4_mes_query_status)=
);
> -
> -     packet->bitfields2.context_id =3D 0;
> -     packet->bitfields2.interrupt_sel =3D
> -                     interrupt_sel__mes_query_status__completion_status;
> -     packet->bitfields2.command =3D
> -                     command__mes_query_status__fence_only_after_write_a=
ck;
> -
> -     packet->addr_hi =3D upper_32_bits((uint64_t)fence_address);
> -     packet->addr_lo =3D lower_32_bits((uint64_t)fence_address);
> -     packet->data_hi =3D upper_32_bits((uint64_t)fence_value);
> -     packet->data_lo =3D lower_32_bits((uint64_t)fence_value);
> -
> -     return 0;
> -}
> -
> -const struct packet_manager_funcs kfd_v10_pm_funcs =3D {
> -     .map_process                    =3D pm_map_process_v10,
> -     .runlist                        =3D pm_runlist_v10,
> -     .set_resources                  =3D pm_set_resources_vi,
> -     .map_queues                     =3D pm_map_queues_v10,
> -     .unmap_queues                   =3D pm_unmap_queues_v10,
> -     .query_status                   =3D pm_query_status_v10,
> -     .release_mem                    =3D NULL,
> -     .map_process_size               =3D sizeof(struct pm4_mes_map_proce=
ss),
> -     .runlist_size                   =3D sizeof(struct pm4_mes_runlist),
> -     .set_resources_size             =3D sizeof(struct pm4_mes_set_resou=
rces),
> -     .map_queues_size                =3D sizeof(struct pm4_mes_map_queue=
s),
> -     .unmap_queues_size              =3D sizeof(struct pm4_mes_unmap_que=
ues),
> -     .query_status_size              =3D sizeof(struct pm4_mes_query_sta=
tus),
> -     .release_mem_size               =3D 0,
> -};
> -
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> index f0e4910a8865..9e0eaf446bab 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c
> @@ -25,6 +25,7 @@
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_pm4_headers_ai.h"
>   #include "kfd_pm4_opcodes.h"
> +#include "gc/gc_10_1_0_sh_mask.h"
>
>   static bool initialize_v9(struct kernel_queue *kq, struct kfd_dev *dev,
>                        enum kfd_queue_type type, unsigned int queue_size)
> @@ -85,10 +86,17 @@ static int pm_map_process_v9(struct packet_manager *p=
m,
>
>        packet->sh_mem_config =3D qpd->sh_mem_config;
>        packet->sh_mem_bases =3D qpd->sh_mem_bases;
> -     packet->sq_shader_tba_lo =3D lower_32_bits(qpd->tba_addr >> 8);
> -     packet->sq_shader_tba_hi =3D upper_32_bits(qpd->tba_addr >> 8);
> -     packet->sq_shader_tma_lo =3D lower_32_bits(qpd->tma_addr >> 8);
> -     packet->sq_shader_tma_hi =3D upper_32_bits(qpd->tma_addr >> 8);
> +     if (qpd->tba_addr) {
> +             packet->sq_shader_tba_lo =3D lower_32_bits(qpd->tba_addr >>=
 8);
> +             /* On GFX9, unlike GFX10, bit TRAP_EN of SQ_SHADER_TBA_HI i=
s
> +              * not defined, so setting it won't do any harm.
> +              */
> +             packet->sq_shader_tba_hi =3D upper_32_bits(qpd->tba_addr >>=
 8)
> +                             | 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
> +
> +             packet->sq_shader_tma_lo =3D lower_32_bits(qpd->tma_addr >>=
 8);
> +             packet->sq_shader_tma_hi =3D upper_32_bits(qpd->tma_addr >>=
 8);
> +     }
>
>        packet->gds_addr_lo =3D lower_32_bits(qpd->gds_context_area);
>        packet->gds_addr_hi =3D upper_32_bits(qpd->gds_context_area);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_packet_manager.c
> index 83ef4b3dd2fb..700be4f80867 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -241,12 +241,10 @@ int pm_init(struct packet_manager *pm, struct devic=
e_queue_manager *dqm)
>        case CHIP_RAVEN:
>        case CHIP_RENOIR:
>        case CHIP_ARCTURUS:
> -             pm->pmf =3D &kfd_v9_pm_funcs;
> -             break;
>        case CHIP_NAVI10:
>        case CHIP_NAVI12:
>        case CHIP_NAVI14:
> -             pm->pmf =3D &kfd_v10_pm_funcs;
> +             pm->pmf =3D &kfd_v9_pm_funcs;
>                break;
>        default:
>                WARN(1, "Unexpected ASIC family %u",
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 62db4d20ed32..f2078bfb8ae1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -977,7 +977,6 @@ struct packet_manager_funcs {
>
>   extern const struct packet_manager_funcs kfd_vi_pm_funcs;
>   extern const struct packet_manager_funcs kfd_v9_pm_funcs;
> -extern const struct packet_manager_funcs kfd_v10_pm_funcs;
>
>   int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm=
);
>   void pm_uninit(struct packet_manager *pm);
> @@ -996,9 +995,6 @@ void pm_release_ib(struct packet_manager *pm);
>
>   /* Following PM funcs can be shared among VI and AI */
>   unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_siz=
e);
> -int pm_set_resources_vi(struct packet_manager *pm, uint32_t *buffer,
> -                     struct scheduling_resources *res);
> -
>
>   uint64_t kfd_get_number_elems(struct kfd_dev *kfd);
>

--_000_DM6PR12MB2778273C513A51D90A0109CCF0780DM6PR12MB2778namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Okay. I submitted a PSDB. Meanwhile, I got the answer from FW and SQ HW con=
tact that nothing bad will happen on GFX9 by writing 1 to&nbsp;<span style=
=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &quot;Segoe =
UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMac=
SystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6=
667px; background-color: rgb(255, 255, 255); display: inline !important">TR=
AP_EN.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Regards,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Yong</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 7, 2019 4:07 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Use kernel queue v9 functions for v=
10 (ver2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Are you sure that setting the SQ_SHADER_TBA_HI__TR=
AP_EN bit on GFXv9 is
<br>
completely harmless? If the field is not defined, maybe setting the bit <br=
>
makes the address invalid. It's probably worth running that through a <br>
PSDB, which would cover Vega10, Vega20 and Arcturus.<br>
<br>
If it actually works, the patch is<br>
<br>
Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2019-11-07 15:34, Zhao, Yong wrote:<br>
&gt; The kernel queue functions for v9 and v10 are the same except<br>
&gt; pm_map_process_v* which have small difference, so they should be reuse=
d.<br>
&gt; This eliminates the need of reapplying several patches which were<br>
&gt; applied on v9 but not on v10, such as bigger GWS and more than 2<br>
&gt; SDMA engine support which were introduced on Arcturus.<br>
&gt;<br>
&gt; Change-Id: I2d385961e3c884db14e30b5afc98d0d9e4cb1802<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/Makefile&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 -<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |&nbsp;&nbsp=
; 4 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h |&nbsp;&nbsp=
; 1 -<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c | 317 ------=
------------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c&nbsp; |&nbsp;=
 16 &#43;-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_packet_manager.c&nbsp;&nbsp; |&=
nbsp;&nbsp; 4 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 -<br>
&gt;&nbsp;&nbsp; 7 files changed, 14 insertions(&#43;), 333 deletions(-)<br=
>
&gt;&nbsp;&nbsp; delete mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_kernel_q=
ueue_v10.c<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd=
/amdkfd/Makefile<br>
&gt; index 48155060a57c..017a8b7156da 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/Makefile<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/Makefile<br>
&gt; @@ -41,7 &#43;41,6 @@ AMDKFD_FILES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; :=3D $(AMDKFD_PATH)/kfd_module.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_kernel_queue_cik.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_kernel_queue_vi.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_kernel_queue_v9.o \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; $(AMDKFD_PATH)/kfd_kernel_queue_v10.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_packet_manager.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_process_queue_manager.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_device_queue_manager.o \<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
&gt; index 11d244891393..0d966408ea87 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c<br>
&gt; @@ -332,12 &#43;332,10 @@ struct kernel_queue *kernel_queue_init(struc=
t kfd_dev *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kernel_queue_init_v9(&amp;kq-&gt;ops_asic_specific);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kernel_queue_init_v10(&amp;kq-&gt;ops_asic_specific);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; kernel_queue_init_v9(&amp;kq-&gt;ops_asic_specific);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WARN(1, &quot;Unexpected ASIC family %u&quot;,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h b/drivers/g=
pu/drm/amd/amdkfd/kfd_kernel_queue.h<br>
&gt; index 365fc674fea4..a7116a939029 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h<br>
&gt; @@ -102,6 &#43;102,5 @@ struct kernel_queue {<br>
&gt;&nbsp;&nbsp; void kernel_queue_init_cik(struct kernel_queue_ops *ops);<=
br>
&gt;&nbsp;&nbsp; void kernel_queue_init_vi(struct kernel_queue_ops *ops);<b=
r>
&gt;&nbsp;&nbsp; void kernel_queue_init_v9(struct kernel_queue_ops *ops);<b=
r>
&gt; -void kernel_queue_init_v10(struct kernel_queue_ops *ops);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #endif /* KFD_KERNEL_QUEUE_H_ */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; deleted file mode 100644<br>
&gt; index bfd6221acae9..000000000000<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c<br>
&gt; &#43;&#43;&#43; /dev/null<br>
&gt; @@ -1,317 &#43;0,0 @@<br>
&gt; -/*<br>
&gt; - * Copyright 2018 Advanced Micro Devices, Inc.<br>
&gt; - *<br>
&gt; - * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; - * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; - * to deal in the Software without restriction, including without lim=
itation<br>
&gt; - * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; - * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; - * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; - *<br>
&gt; - * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; - * all copies or substantial portions of the Software.<br>
&gt; - *<br>
&gt; - * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; - * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; - *<br>
&gt; - */<br>
&gt; -<br>
&gt; -#include &quot;kfd_kernel_queue.h&quot;<br>
&gt; -#include &quot;kfd_device_queue_manager.h&quot;<br>
&gt; -#include &quot;kfd_pm4_headers_ai.h&quot;<br>
&gt; -#include &quot;kfd_pm4_opcodes.h&quot;<br>
&gt; -#include &quot;gc/gc_10_1_0_sh_mask.h&quot;<br>
&gt; -<br>
&gt; -static bool initialize_v10(struct kernel_queue *kq, struct kfd_dev *d=
ev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_queue_type typ=
e, unsigned int queue_size);<br>
&gt; -static void uninitialize_v10(struct kernel_queue *kq);<br>
&gt; -static void submit_packet_v10(struct kernel_queue *kq);<br>
&gt; -<br>
&gt; -void kernel_queue_init_v10(struct kernel_queue_ops *ops)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;initialize =3D initialize_v10;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;uninitialize =3D uninitialize_v10;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;submit_packet =3D submit_packet_v10;=
<br>
&gt; -}<br>
&gt; -<br>
&gt; -static bool initialize_v10(struct kernel_queue *kq, struct kfd_dev *d=
ev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_queue_type typ=
e, unsigned int queue_size)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; retval =3D kfd_gtt_sa_allocate(dev, PAGE_SIZ=
E, &amp;kq-&gt;eop_mem);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (retval !=3D 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;eop_gpu_addr =3D kq-&gt;eop_mem-&gt;g=
pu_addr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;eop_kernel_addr =3D kq-&gt;eop_mem-&g=
t;cpu_ptr;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(kq-&gt;eop_kernel_addr, 0, PAGE_SIZE)=
;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void uninitialize_v10(struct kernel_queue *kq)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(kq-&gt;dev, kq-&gt;eop_mem);=
<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void submit_packet_v10(struct kernel_queue *kq)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; *kq-&gt;wptr64_kernel =3D kq-&gt;pending_wpt=
r64;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; write_kernel_doorbell64(kq-&gt;queue-&gt;pro=
perties.doorbell_ptr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; kq-&gt;pending_wptr64);<br>
&gt; -}<br>
&gt; -<br>
&gt; -static int pm_map_process_v10(struct packet_manager *pm,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t *buffer, struct qcm_process_device *qpd)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mes_map_process *packet;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vm_page_table_base_addr =3D qpd-&gt=
;page_table_base;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mes_map_process *)buf=
fer;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mes_map_=
process));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_MAP_PROCESS,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct pm4_mes_map_process));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.diq_enable =3D (qpd-&g=
t;is_debug) ? 1 : 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.process_quantum =3D 1;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.pasid =3D qpd-&gt;pqm-=
&gt;process-&gt;pasid;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields14.gds_size =3D qpd-&gt;=
gds_size;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields14.num_gws =3D qpd-&gt;n=
um_gws;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields14.num_oac =3D qpd-&gt;n=
um_oac;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields14.sdma_enable =3D 1;<br=
>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields14.num_queues =3D (qpd-&=
gt;is_debug) ? 0 : qpd-&gt;queue_count;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sh_mem_config =3D qpd-&gt;sh_mem_=
config;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sh_mem_bases =3D qpd-&gt;sh_mem_b=
ases;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;tba_addr) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;sq_shader_tba_lo =3D lower_32_bits(qpd-&gt;tba_addr &gt;&gt;=
 8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;sq_shader_tba_hi =3D (1 &lt;&lt; SQ_SHADER_TBA_HI__TRAP_EN__=
SHIFT) |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(qpd-&gt;t=
ba_addr &gt;&gt; 8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;sq_shader_tma_lo =3D lower_32_bits(qpd-&gt;tma_addr &gt;&gt;=
 8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;sq_shader_tma_hi =3D upper_32_bits(qpd-&gt;tma_addr &gt;&gt;=
 8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;gds_addr_lo =3D lower_32_bits(qpd=
-&gt;gds_context_area);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;gds_addr_hi =3D upper_32_bits(qpd=
-&gt;gds_context_area);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;vm_context_page_table_base_addr_l=
o32 =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(vm_page_t=
able_base_addr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;vm_context_page_table_base_addr_h=
i32 =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(vm_page_t=
able_base_addr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static int pm_runlist_v10(struct packet_manager *pm, uint32_t *buffer=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t ib, size_t ib_=
size_in_dwords, bool chain)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mes_runlist *packet;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int concurrent_proc_cnt =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd =3D pm-&gt;dqm-&gt;dev;<=
br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Determine the number of processes to map =
together to HW:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * it can not exceed the number of VMID=
s available to the<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * scheduler, and it is determined by t=
he smaller of the number<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of processes in the runlist and kfd =
module parameter<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * hws_max_conc_proc.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Note: the arbitration between the nu=
mber of VMIDs and<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * hws_max_conc_proc has been done in<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * kgd2kfd_device_init().<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; concurrent_proc_cnt =3D min(pm-&gt;dqm-&gt;p=
rocesses_count,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;max_proc_per_qu=
antum);<br>
&gt; -<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mes_runlist *)buffer;=
<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mes_runl=
ist));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_RUN_LIST,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct pm4_mes_runlist=
));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.ib_size =3D ib_size_in=
_dwords;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.chain =3D chain ? 1 : =
0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.offload_polling =3D 0;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.valid =3D 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields4.process_cnt =3D concur=
rent_proc_cnt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;ordinal2 =3D lower_32_bits(ib);<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;ib_base_hi =3D upper_32_bits(ib);=
<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static int pm_map_queues_v10(struct packet_manager *pm, uint32_t *buf=
fer,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct queue *q, bool is_static)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mes_map_queues *packet;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bool use_static =3D is_static;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mes_map_queues *)buff=
er;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mes_map_=
queues));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_MAP_QUEUES,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct pm4_mes_map_queues));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.num_queues =3D 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.queue_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; queue_sel__mes_map_queues__map_to_hws_determined_queue_slots_vi;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.engine_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; engine_sel__mes_map_queues__compute_vi;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.queue_type =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; queue_type__mes_map_queues__normal_compute_vi;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (q-&gt;properties.type) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_COMPUTE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (use_static)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.q=
ueue_type =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; queue_type__mes_map_queues__normal_latency_static_queue_vi;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_DIQ:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.queue_type =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_type__mes_map_que=
ues__debug_interface_queue_vi;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_SDMA:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_SDMA_XGMI:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.engine_sel =3D q-&gt;properties.sdma_engine_id &#=
43;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; engine_sel__mes_map_queues__sdma0_vi;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; use_static =3D false; /* no static queues under SDMA */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WARN(1, &quot;queue type %d\n&quot;, q-&gt;properties.type);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields3.doorbell_offset =3D<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.doorbe=
ll_off;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;mqd_addr_lo =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(q-&gt;gar=
t_mqd_addr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;mqd_addr_hi =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(q-&gt;gar=
t_mqd_addr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;wptr_addr_lo =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits((uint64_t=
)q-&gt;properties.write_ptr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;wptr_addr_hi =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits((uint64_t=
)q-&gt;properties.write_ptr);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static int pm_unmap_queues_v10(struct packet_manager *pm, uint32_t *b=
uffer,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_queue_type typ=
e,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_unmap_queues_f=
ilter filter,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t filter_param, =
bool reset,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int sdma_engin=
e)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mes_unmap_queues *packet;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mes_unmap_queues *)bu=
ffer;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mes_unma=
p_queues));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_UNMAP_QUEUES,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct pm4_mes_unmap_queues));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_COMPUTE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_DIQ:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.engine_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine_sel__mes_unmap_q=
ueues__compute;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_SDMA:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_QUEUE_TYPE_SDMA_XGMI:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.engine_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine_sel__mes_unmap_q=
ueues__sdma0 &#43; sdma_engine;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WARN(1, &quot;queue type %d\n&quot;, type);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (reset)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.action =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; action__mes_unmap_queue=
s__reset_queues;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.action =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; action__mes_unmap_queue=
s__preempt_queues;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (filter) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE:<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.queue_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_sel__mes_unmap_qu=
eues__perform_request_on_specified_queues;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.num_queues =3D 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields3b.doorbell_offset0 =3D filter_param;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_UNMAP_QUEUES_FILTER_BY_PASID:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.queue_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_sel__mes_unmap_qu=
eues__perform_request_on_pasid_queues;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields3a.pasid =3D filter_param;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.queue_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_sel__mes_unmap_qu=
eues__unmap_all_queues;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES:=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* in this case, we do not preempt static queues */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; packet-&gt;bitfields2.queue_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_sel__mes_unmap_qu=
eues__unmap_all_non_static_queues;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WARN(1, &quot;filter %d\n&quot;, filter);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -<br>
&gt; -}<br>
&gt; -<br>
&gt; -static int pm_query_status_v10(struct packet_manager *pm, uint32_t *b=
uffer,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t fence_address,=
 uint32_t fence_value)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pm4_mes_query_status *packet;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet =3D (struct pm4_mes_query_status *)bu=
ffer;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memset(buffer, 0, sizeof(struct pm4_mes_quer=
y_status));<br>
&gt; -<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;header.u32All =3D pm_build_pm4_he=
ader(IT_QUERY_STATUS,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(struct pm4_mes_query_status));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.context_id =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.interrupt_sel =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt_sel__mes_quer=
y_status__completion_status;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;bitfields2.command =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; command__mes_query_stat=
us__fence_only_after_write_ack;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;addr_hi =3D upper_32_bits((uint64=
_t)fence_address);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;addr_lo =3D lower_32_bits((uint64=
_t)fence_address);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_hi =3D upper_32_bits((uint64=
_t)fence_value);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;data_lo =3D lower_32_bits((uint64=
_t)fence_value);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -const struct packet_manager_funcs kfd_v10_pm_funcs =3D {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .map_process&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D pm_map_process_v10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .runlist&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =3D pm_runlist_v10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .set_resources&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D pm_set_resources_vi,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .map_queues&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =3D pm_map_queues_v10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D pm_unmap_queues_v10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .query_status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D pm_query_status_v10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D NULL,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .map_process_size&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct=
 pm4_mes_map_process),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .runlist_size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =3D sizeof(struct pm4_mes_runlist),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .set_resources_size&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_mes_s=
et_resources),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .map_queues_size&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(s=
truct pm4_mes_map_queues),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .unmap_queues_size&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_=
mes_unmap_queues),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .query_status_size&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D sizeof(struct pm4_=
mes_query_status),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .release_mem_size&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0,<br>
&gt; -};<br>
&gt; -<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; index f0e4910a8865..9e0eaf446bab 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c<br>
&gt; @@ -25,6 &#43;25,7 @@<br>
&gt;&nbsp;&nbsp; #include &quot;kfd_device_queue_manager.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;kfd_pm4_headers_ai.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;kfd_pm4_opcodes.h&quot;<br>
&gt; &#43;#include &quot;gc/gc_10_1_0_sh_mask.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static bool initialize_v9(struct kernel_queue *kq, struct =
kfd_dev *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kf=
d_queue_type type, unsigned int queue_size)<br>
&gt; @@ -85,10 &#43;86,17 @@ static int pm_map_process_v9(struct packet_man=
ager *pm,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sh_mem_config =3D=
 qpd-&gt;sh_mem_config;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sh_mem_bases =3D =
qpd-&gt;sh_mem_bases;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sq_shader_tba_lo =3D lower_32_bit=
s(qpd-&gt;tba_addr &gt;&gt; 8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sq_shader_tba_hi =3D upper_32_bit=
s(qpd-&gt;tba_addr &gt;&gt; 8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sq_shader_tma_lo =3D lower_32_bit=
s(qpd-&gt;tma_addr &gt;&gt; 8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sq_shader_tma_hi =3D upper_32_bit=
s(qpd-&gt;tma_addr &gt;&gt; 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;tba_addr) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; packet-&gt;sq_shader_tba_lo =3D lower_32_bits(qpd-&gt;tba_addr &gt;=
&gt; 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* On GFX9, unlike GFX10, bit TRAP_EN of SQ_SHADER_TBA_HI is<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * not defined, so setting it won't do any harm.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; packet-&gt;sq_shader_tba_hi =3D upper_32_bits(qpd-&gt;tba_addr &gt;=
&gt; 8)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 &lt;&lt; SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;=
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; packet-&gt;sq_shader_tma_lo =3D lower_32_bits(qpd-&gt;tma_addr &gt;=
&gt; 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; packet-&gt;sq_shader_tma_hi =3D upper_32_bits(qpd-&gt;tma_addr &gt;=
&gt; 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;gds_addr_lo =3D l=
ower_32_bits(qpd-&gt;gds_context_area);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;gds_addr_hi =3D u=
pper_32_bits(qpd-&gt;gds_context_area);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
&gt; index 83ef4b3dd2fb..700be4f80867 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c<br>
&gt; @@ -241,12 &#43;241,10 @@ int pm_init(struct packet_manager *pm, struc=
t device_queue_manager *dqm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pm-&gt;pmf =3D &amp;kfd_v9_pm_funcs;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pm-&gt;pmf =3D &amp;kfd_v10_pm_funcs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pm-&gt;pmf =3D &amp;kfd_v9_pm_funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WARN(1, &quot;Unexpected ASIC family %u&quot;,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index 62db4d20ed32..f2078bfb8ae1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -977,7 &#43;977,6 @@ struct packet_manager_funcs {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; extern const struct packet_manager_funcs kfd_vi_pm_funcs;<=
br>
&gt;&nbsp;&nbsp; extern const struct packet_manager_funcs kfd_v9_pm_funcs;<=
br>
&gt; -extern const struct packet_manager_funcs kfd_v10_pm_funcs;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int pm_init(struct packet_manager *pm, struct device_queue=
_manager *dqm);<br>
&gt;&nbsp;&nbsp; void pm_uninit(struct packet_manager *pm);<br>
&gt; @@ -996,9 &#43;995,6 @@ void pm_release_ib(struct packet_manager *pm);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /* Following PM funcs can be shared among VI and AI */<br>
&gt;&nbsp;&nbsp; unsigned int pm_build_pm4_header(unsigned int opcode, size=
_t packet_size);<br>
&gt; -int pm_set_resources_vi(struct packet_manager *pm, uint32_t *buffer,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct scheduling_resou=
rces *res);<br>
&gt; -<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; uint64_t kfd_get_number_elems(struct kfd_dev *kfd);<br>
&gt;&nbsp;&nbsp; <br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778273C513A51D90A0109CCF0780DM6PR12MB2778namp_--

--===============0828746311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0828746311==--
