Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E1AC48BC2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 14:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9946023E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 14:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9946023E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DECC16E901;
	Wed, 23 Jun 2021 14:14:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0936E901
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 14:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HilMLZLWLAPcLrcHS2A619BiP16Gyzunq+mhqaRs2X5X/xBYG3FUI65i27uoVLLS5ldm5Xs7JoERjrAMtz/Rk8IxOXEcIHa4J+z794b3oZhcSHXdsGJKoyielHfgYS/3sytCscBb+kKXVbD+NMgJbdJ4xKQtARv+rVWhA3v4QZgTVvXedpoGzmS9XxRa4YekVQlamaOw70DFbdQslrtxlkcOSnbAyqlPvnLGY7khLZVpxWdbqmLXpZSi1msmnjB9Pp1MT7MqQsb0Sfn5MkhS2tGdHZanUq5R0QyY5bjYeLF9aBWj2hlfNa6gAEyTG+tIHomErJKkxE0aW2SrXIeniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMDmqwwM2gI9NoZpK8lsqF8OW87dD4JPDkCbuQ/Gd/w=;
 b=CjI5kMSiIhvgPvE8w9xr6hQ1QrWA79C/nd3nMVXiW5egZSoyaF6UHPjkUK0bjIFC3RtdSB+5m8sARqncY+YI4kUN152yC164D/LHJxS2d/Vb5JUcWYIZFit860dqAr1/po/J3rB74MX5vCsKB2NDa4dsi8hhMaHDAUdhTLAvtX6pOZkDvE5+q/M0ifYLgsjZuoIZgeNr5+aGWN1oW7mZoE4VVevs0ZGxIfDH3gyO+zqXXVtuI2ZJ5cWhB+n2R8MqW853RsHjM2H9+zlZ2ovOO6sin4mUSqjdUO3CjkUXHER1p0HyXFA1HNTdN3EgAt0tqrsiRWa2zBinp1nPDCANAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMDmqwwM2gI9NoZpK8lsqF8OW87dD4JPDkCbuQ/Gd/w=;
 b=o8JUtJRXgixguaBmJ7odSYDKifH5trI4ZqEcDR98LSV+lOzXxIw7y0r9uUqZ2hcCGy8uMpSHc9y0DGb9M3L9bnCcT1S9AJtnwsIP4jTjwnr3WqLJoE2JxYGkcoXe3RnIos6WOAgvtK5Au1OlugwoW6W4nvGXnsv84LB8YZJ0mwQ=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 14:13:57 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::5d51:1728:8288:432]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::5d51:1728:8288:432%3]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 14:13:56 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 umr 3/3] Enhance printing of page tables in AI+
Thread-Topic: [PATCH v2 umr 3/3] Enhance printing of page tables in AI+
Thread-Index: AQHXZru2mF5Ixuf/YUuPnZqQWnzsHashpmyt
Date: Wed, 23 Jun 2021 14:13:56 +0000
Message-ID: <DM6PR12MB35470D89C130CFC81AE34F23F7089@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210617192540.4272-3-Joseph.Greathouse@amd.com>,
 <20210621163712.17852-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20210621163712.17852-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-23T14:13:56.284Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:f2c0:e4c0:b2:d3fb:b908:583b:772c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcd84f12-dd15-46ba-0493-08d9365123c2
x-ms-traffictypediagnostic: DM6PR12MB3817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3817A608CAD71676B767E954F7089@DM6PR12MB3817.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eY+WAWWeqrfH87GTNiXIojoTsE9+9a3Gkbi9yZwZLHx2V268jNovuiVHUtlWui9kSW0EZnOtEsU5O4pFE+QgWBu7M2PXPZU+trmifvN3V0CY9fIKyWG/eQiaqISx1q3ketr5vLVrzL4TMeAgAW8sz7GD0h1kjWq83wugi9kpimT16CJMKQ+0DA3+ED5F0ox3BhD6Pj+3s9tShmr9tgdswkggqaUgefs170Ny4SKZviL3eulm0fKaleIzrimW/OKYiiOQVxmcYYBpuzwweABx1DdJISEvvj/uaoHOq/NIAE1tP6mEZTB7qivphGq3hKZVcCp2HVTIkoYtCqpCgMclBgJ2Vm4Gt8T8RqmCzmoIKQn07FPXBioPKhKOwG45E35o0Rd/A9Nnr664i4fVnFXT1qM4epejAIQLjm9n5f9IPU223IhptuneP56i7FVGCy1q2AeALiaNZ26temP02pPpuzJLZ0ihA0h9ADs3c4SjM8CbkkVnnFCuoqF4hJg0U7/hIMYQgozTLI/UsHQtqWlCvuywI2BgE/fqEjKZASIcjiy14rBXfEUlDzwjJIl8i8Z3l+X3Efrjw1wr30t241pImmcMp5emJwVt3VRE6URurk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(86362001)(66446008)(66946007)(66556008)(66476007)(91956017)(33656002)(122000001)(76116006)(38100700002)(64756008)(71200400001)(55016002)(110136005)(53546011)(7696005)(52536014)(8936002)(83380400001)(6506007)(8676002)(316002)(186003)(5660300002)(2906002)(478600001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qFrGYSnMaSEnSn6FgdRhgnEr2ySt3BJG6bz7EkDeNt8T70v1OBi/mBOVnI?=
 =?iso-8859-1?Q?3LSeYPE9FjkdReKQf4NVf6mQNFWXIXAcyxAOPvmfg2qThHHMGS+GvY2K08?=
 =?iso-8859-1?Q?rvwqa8BPqHKUFgURzfKXG2jl9w98OJehvY9V5nReedsQ1KQoV/cdL1oF8X?=
 =?iso-8859-1?Q?JLaPDmKk4XE/RQ5S1hyq6i0SyAxXUXDfRR5xu7d2z2fa734Et0m/LJgDTz?=
 =?iso-8859-1?Q?JlzASd7zzPh+jEa2/kygQCF3WvcPTewquDn921UM7/6Z/UozT8sQWiALeJ?=
 =?iso-8859-1?Q?DfwaI+gz56bIlUDWM1LiVQDFQNyeA7uYCyDQuBjj4M6ZrOs9lrhjjhxw0i?=
 =?iso-8859-1?Q?0BW4aSpHU2iUI6gV3z77H3rS7nY7DSOPgL14Q4iicjWhzluf98WclFhgZb?=
 =?iso-8859-1?Q?ATt/GVBGlZqJD6CB/yyy0cooveH799Ln+LALaMNRu0QPyrw7bz3N3YQQqR?=
 =?iso-8859-1?Q?YUua6QWCSvsQZZTgc721xhLXad3XluDcUbX4YihIp6rZjJl6jkZe2EoThR?=
 =?iso-8859-1?Q?mm8RgU5eLIHLTe+jtutC65k/i5JxabufWy1NEeEEN08qfHs0qJHP3gFr2V?=
 =?iso-8859-1?Q?CLiFfsrAi53gLJkE9I8ADfBDc9EonCm8i/BYeUMU82/0fAtbb3OwGZUWbF?=
 =?iso-8859-1?Q?waLtLR1MK4wd8/Pe/uhsgxxCQ0yGGbY7yoB03LGkDv5DugZEYkGJUtUa3Y?=
 =?iso-8859-1?Q?mfI0o3oqsT/lgeNBpQOPzJnfChfRHnoUow+E6TrSzLPDIDvJNvm+Djfjk7?=
 =?iso-8859-1?Q?Rsvq2hV9kG5ZLbqSXCrGrxNYT7Q3E6TblLwzCh+vL8wt+np+IF3ce706Fr?=
 =?iso-8859-1?Q?66m60RwkKrr7KqGJkx3e87rt8HQOE03k8Wi+9pRkfEixFrhBEm6UkuKTkQ?=
 =?iso-8859-1?Q?JVPmac/0yM4RktJ3fXBNNbq9hpMclQffIxuCGlz+ye0lVm/MM+pJ0JqIN0?=
 =?iso-8859-1?Q?IZwVEgz46L2dfxQzq9pKlR7e8WRQyYO2Q8DxGydqnch35uLT/ajWyiVu4Z?=
 =?iso-8859-1?Q?eLyjCz4VwUUU8oGcFqiG79oO5etvas4cqlPyBIMv5K+Fo/hUD52suzZjVn?=
 =?iso-8859-1?Q?+0/IugNv783e7w6ZDmcwYAFB32n28n/g67qO+6NOQa8yw+UNZZDLYrtsBU?=
 =?iso-8859-1?Q?ALxXMq8//llWntG9T8H+MGwxIY0+Sz94mhjpQX2yRzd5DEgEZJStsgmdVw?=
 =?iso-8859-1?Q?2joY6SxZdMyOSORtJKA4YcueE/1sgo6RDG54D4S3BCqdFzO3RlGuf9pnWn?=
 =?iso-8859-1?Q?hg7I+iks9QQBBR5ZeJF9L+USgcuiEkHJnFqHxivGM5p78SnRo0bOKOIuVM?=
 =?iso-8859-1?Q?GQoEj49dkdT6nxBgE1LdPY3FmC1dqiSU6e6SdOP5Na6mQwEtV25SwC74Mw?=
 =?iso-8859-1?Q?xvgjDzn2q+uyWuAof4qge2UNdN9HA7Eq3pgBPP+skaNYlNx1n0MWU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd84f12-dd15-46ba-0493-08d9365123c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 14:13:56.9094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jxb+m9101XyoeudlfVFcFEdMdWhyfc0/Ea9IBdrAs60uC/TwqKaj4Yor9gNuKYZQCKxQT4tXOMhNIbWGmgLqzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Tested and pushed out to main.

Thanks,
Tom

________________________________________
From: Greathouse, Joseph <Joseph.Greathouse@amd.com>
Sent: Monday, June 21, 2021 12:37
To: amd-gfx@lists.freedesktop.org
Cc: StDenis, Tom; Greathouse, Joseph
Subject: [PATCH v2 umr 3/3] Enhance printing of page tables in AI+

Pulls print functions for GPUVM page tables on AI+ chips into their
own set of generalized functions, so that we don't have subtly
different printouts for different layers.

Explicitly prints PDEs with P bit (which makes it a PTE) and makes
the PTE with F bit set (further, which makes it a PDE) properly
indent the next layer of the print.

Prints remaining fields from the PTE and PDE printouts, such as
read/write/execute bits and MTYPE from PTE.

v2: Correctly handle printing translate-further PTEs

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 src/lib/read_vram.c | 184 ++++++++++++++++++++++++++++++--------------
 1 file changed, 127 insertions(+), 57 deletions(-)

diff --git a/src/lib/read_vram.c b/src/lib/read_vram.c
index 2998873..bea1232 100644
--- a/src/lib/read_vram.c
+++ b/src/lib/read_vram.c
@@ -415,6 +415,112 @@ static pte_fields_ai_t decode_pte_entry_ai(uint64_t pte_entry)
        return pte_fields;
 }

+static void print_pde_fields_ai(struct umr_asic *asic,
+                               pde_fields_ai_t pde_fields)
+{
+       asic->mem_funcs.vm_message(
+                       ", PBA==0x%012" PRIx64 ", V=%" PRIu64
+                       ", S=%" PRIu64 ", C=%" PRIu64
+                       ", P=%" PRIu64 ", FS=%" PRIu64 "\n",
+                       pde_fields.pte_base_addr,
+                       pde_fields.valid,
+                       pde_fields.system,
+                       pde_fields.coherent,
+                       pde_fields.pte,
+                       pde_fields.frag_size);
+}
+static void print_base_ai(struct umr_asic *asic,
+                         uint64_t pde_entry, uint64_t address,
+                         uint64_t va_mask, pde_fields_ai_t pde_fields,
+                         int is_base_not_pde)
+{
+       if (is_base_not_pde)
+               asic->mem_funcs.vm_message("BASE");
+       else
+               asic->mem_funcs.vm_message("PDE");
+       asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64,
+                       pde_entry,
+                       address & va_mask);
+       print_pde_fields_ai(asic, pde_fields);
+}
+
+static void print_pde_ai(struct umr_asic *asic,
+               const char * indentation, int pde_cnt,
+               int page_table_depth, uint64_t prev_addr,
+               uint64_t pde_idx, uint64_t pde_entry, uint64_t address,
+               uint64_t va_mask, pde_fields_ai_t pde_fields)
+{
+       asic->mem_funcs.vm_message("%s ", &indentation[18-pde_cnt*3]);
+       if (pde_fields.further)
+               asic->mem_funcs.vm_message("PTE-FURTHER");
+       else
+               asic->mem_funcs.vm_message("PDE%d", page_table_depth - pde_cnt);
+
+       asic->mem_funcs.vm_message("@{0x%" PRIx64 "/%" PRIx64
+                       "}=0x%016" PRIx64 ", VA=0x%012" PRIx64,
+                       prev_addr,
+                       pde_idx,
+                       pde_entry,
+                       address & va_mask);
+       print_pde_fields_ai(asic, pde_fields);
+}
+
+static void print_pte_ai(struct umr_asic *asic,
+               const char * indentation, int pde_cnt, uint64_t prev_addr,
+               uint64_t pte_idx, uint64_t pte_entry, uint64_t address,
+               uint64_t va_mask, pte_fields_ai_t pte_fields)
+{
+       if (asic == NULL) {
+               asic->mem_funcs.vm_message("\\-> PTE");
+       } else {
+               asic->mem_funcs.vm_message("%s ",
+                               &indentation[18-pde_cnt*3]);
+               if (pte_fields.pde)
+                       asic->mem_funcs.vm_message("PDE0-as-PTE");
+               else
+                       asic->mem_funcs.vm_message("PTE");
+               asic->mem_funcs.vm_message("@{0x%" PRIx64 "/%" PRIx64"}",
+                               prev_addr,
+                               pte_idx);
+       }
+       asic->mem_funcs.vm_message("=0x%016" PRIx64 ", VA=0x%012" PRIx64
+                       ", PBA==0x%012" PRIx64 ", V=%" PRIu64
+                       ", S=%" PRIu64 ", C=%" PRIu64 ", Z=%" PRIu64
+                       ", X=%" PRIu64 ", R=%" PRIu64 ", W=%" PRIu64
+                       ", FS=%" PRIu64 ", T=%" PRIu64 ", MTYPE=",
+                       pte_entry,
+                       address & va_mask,
+                       pte_fields.page_base_addr,
+                       pte_fields.valid,
+                       pte_fields.system,
+                       pte_fields.coherent,
+                       pte_fields.tmz,
+                       pte_fields.execute,
+                       pte_fields.read,
+                       pte_fields.write,
+                       pte_fields.fragment,
+                       pte_fields.prt,
+                       pte_fields.mtype);
+       switch (pte_fields.mtype) {
+               case 0:
+                       asic->mem_funcs.vm_message("NC\n");
+                       break;
+               case 1:
+                       asic->mem_funcs.vm_message("RW\n");
+                       break;
+               case 2:
+                       asic->mem_funcs.vm_message("CC\n");
+                       break;
+               case 3:
+                       asic->mem_funcs.vm_message("UC\n");
+                       break;
+               default:
+                       asic->mem_funcs.vm_message("Unknown (%" PRIu64")\n",
+                                       pte_fields.mtype);
+                       break;
+       }
+}
+
 /**
  * umr_access_vram_ai - Access GPU mapped memory for GFX9+ platforms
  */
@@ -457,7 +563,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
        unsigned char *pdst = dst;
        char *hub, *vm0prefix, *regprefix;
        unsigned hubid;
-       static const char *indentation = "               \\->";
+       static const char *indentation = "                  \\->";

        memset(&registers, 0, sizeof registers);
        memset(&pde_array, 0xff, sizeof pde_array);
@@ -713,14 +819,7 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
                        va_mask <<= (total_vm_bits - top_pdb_bits);

                        if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose)
-                               asic->mem_funcs.vm_message("BASE=0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", C=%" PRIu64 ", P=%" PRIu64 "\n",
-                                               pde_entry,
-                                               address & va_mask,
-                                               pde_fields.pte_base_addr,
-                                               pde_fields.valid,
-                                               pde_fields.system,
-                                               pde_fields.coherent,
-                                               pde_fields.pte);
+                               print_base_ai(asic, pde_entry, address, va_mask, pde_fields, 1);
                        memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);

                        current_depth = page_table_depth;
@@ -783,27 +882,11 @@ static int umr_access_vram_ai(struct umr_asic *asic, uint32_t vmid,
                                        log2_ptb_entries = (9 + (page_table_block_size - pde0_block_fragment_size));
                                        ptb_mask = (1ULL << log2_ptb_entries) - 1;
                                        pte_page_mask = (1ULL << (pde0_block_fragment_size + 12)) - 1;
-                                       if (asic->options.verbose)
-                                               asic->mem_funcs.vm_message("pde0.pte = %u\npde0.block_fragment_size = %u\npage_table_block_size = %u\n",
-                                                       (unsigned)pde_fields.pte,
-                                                       (unsigned)pde0_block_fragment_size,
-                                                       (unsigned)page_table_block_size);
                                }
                                if (!pde_fields.pte) {
                                        if ((asic->options.no_fold_vm_decode || memcmp(&pde_fields, &pde_array[pde_cnt], sizeof pde_fields)) && asic->options.verbose) {
-                                               asic->mem_funcs.vm_message("%s PDE%d@{0x%" PRIx64 "/%" PRIx64 "}=0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", C=%" PRIu64 ", P=%" PRIu64 ", FS=%" PRIu64 "\n",
-                                                               &indentation[15-pde_cnt*3],
-                                                               page_table_depth - pde_cnt,
-                                                               prev_addr,
-                                                               pde_idx,
-                                                               pde_entry,
-                                                               address & va_mask,
-                                                               pde_fields.pte_base_addr,
-                                                               pde_fields.valid,
-                                                               pde_fields.system,
-                                                               pde_fields.coherent,
-                                                               pde_fields.pte,
-                                                               pde_fields.frag_size);
+                                               print_pde_ai(asic, indentation, pde_cnt, page_table_depth, prev_addr,
+                                                               pde_idx, pde_entry, address, va_mask, pde_fields);
                                                memcpy(&pde_array[pde_cnt++], &pde_fields, sizeof pde_fields);
                                        }
                                } else {
@@ -870,21 +953,6 @@ pte_further:
 pde_is_pte:
                        pte_fields = decode_pte_entry_ai(pte_entry);

-                       if (asic->options.verbose)
-                               asic->mem_funcs.vm_message("%s %s@{0x%" PRIx64 "/%" PRIx64"}==0x%016" PRIx64 ", VA=0x%012" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", P=%" PRIu64 ", FS=%" PRIu64 ", F=%" PRIu64 "\n",
-                                       &indentation[15-pde_cnt*3],
-                                       (pte_fields.further) ? "PTE-FURTHER" : "PTE",
-                                       prev_addr,
-                                       pte_idx,
-                                       pte_entry,
-                                       address & (((1ULL << page_table_block_size) - 1) << (12 + pde0_block_fragment_size)),
-                                       pte_fields.page_base_addr,
-                                       pte_fields.valid,
-                                       pte_fields.system,
-                                       pte_fields.prt,
-                                       pte_fields.fragment,
-                                       pte_fields.further);
-
                        // How many bits in the address are used to index into the PTB?
                        // If further is set, that means we jumped back to pde_is_pte,
                        // and the va_mask was properly set down there.
@@ -920,6 +988,17 @@ pde_is_pte:
                                va_mask = va_mask & ~mask_to_ignore;
                        }

+                       if (asic->options.verbose) {
+                               if (pte_fields.further) {
+                                       pde_fields = decode_pde_entry_ai(pte_entry);
+                                       print_pde_ai(asic, indentation, pde_cnt, page_table_depth, prev_addr,
+                                                       pte_idx, pte_entry, address, va_mask, pde_fields);
+                               } else {
+                                       print_pte_ai(asic, indentation, pde_cnt, prev_addr, pte_idx,
+                                                       pte_entry, address, va_mask, pte_fields);
+                               }
+                       }
+
                        uint32_t pte_block_fragment_size = 0;
                        if (pte_fields.further) {
                                // Going to go one more layer deep, so now we need the Further-PTE's
@@ -946,6 +1025,7 @@ pde_is_pte:

                                // grab PTE base address and other data from the PTE that has the F bit set.
                                pde_fields = decode_pde_entry_ai(pte_entry);
+                               pde_cnt++;
                                further = 1;
                                goto pte_further;
                        }
@@ -972,12 +1052,7 @@ pde_is_pte:
                        pte_page_mask = (1ULL << (12 + pde0_block_fragment_size)) - 1;

                        if ((asic->options.no_fold_vm_decode || memcmp(&pde_array[0], &pde_fields, sizeof pde_fields)) && asic->options.verbose)
-                               asic->mem_funcs.vm_message("PDE=0x%016" PRIx64 ", PBA==0x%012" PRIx64 ", V=%" PRIu64 ", S=%" PRIu64 ", FS=%" PRIu64 "\n",
-                                               page_table_base_addr,
-                                               pde_fields.pte_base_addr,
-                                               pde_fields.valid,
-                                               pde_fields.system,
-                                               pde_fields.frag_size);
+                               print_base_ai(asic, page_table_base_addr, address, -1, pde_fields, 0);
                        memcpy(&pde_array[0], &pde_fields, sizeof pde_fields);

                        if (!pde_fields.valid)
@@ -992,13 +1067,8 @@ pde_is_pte:
                        pte_fields = decode_pte_entry_ai(pte_entry);

                        if (asic->options.verbose)
-                               asic->mem_funcs.vm_message("\\-> PTE=0x%016" PRIx64 ", VA=0x%016" PRIx64 ", PBA==0x%012" PRIx64 ", F=%" PRIu64 ", V=%" PRIu64 ", S=%" PRIu64 "\n",
-                                       pte_entry,
-                                       address & ~((uint64_t)0xFFF),
-                                       pte_fields.page_base_addr,
-                                       pte_fields.fragment,
-                                       pte_fields.valid,
-                                       pte_fields.system);
+                               print_pte_ai(asic, NULL, 0, 0, 0, pte_entry, address,
+                                               ~((uint64_t)0xFFF), pte_fields);

                        if (pdst && !pte_fields.valid)
                                goto invalid_page;
@@ -1018,13 +1088,13 @@ next_page:
                if (asic->options.verbose) {
                        if (pte_fields.system == 1) {
                                asic->mem_funcs.vm_message("%s Computed address we will read from: %s:%" PRIx64 ", (reading: %" PRIu32 " bytes)\n",
-                                                                                       &indentation[15-pde_cnt*3-3],
+                                                                                       &indentation[18-pde_cnt*3-3],
                                                                                        "sys",
                                                                                        start_addr,
                                                                                        chunk_size);
                        } else {
                                asic->mem_funcs.vm_message("%s Computed address we will read from: %s:%" PRIx64 " (MCA:%" PRIx64"), (reading: %" PRIu32 " bytes)\n",
-                                                                                       &indentation[15-pde_cnt*3-3],
+                                                                                       &indentation[18-pde_cnt*3-3],
                                                                                        "vram",
                                                                                        start_addr,
                                                                                        start_addr + vm_fb_offset,
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
