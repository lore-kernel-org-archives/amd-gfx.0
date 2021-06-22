Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EDAC2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8016102A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8016102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3EE6E500;
	Tue, 22 Jun 2021 13:25:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 781D36E500
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 13:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3Q91QIjk+fQdfuQSXYkqfn9B1BHsJFYWdzHrrl85CRwiqdLJXhj+4RuP5GwWPZcAcIHx3FSCdZ9Vht8U9S9H3ky/odjM2h8XrrN0lAgB0BU9ANnjHKOp8BoJBu+6/PELsZYnkuq75Av12MgibEfwSl5WbA38/fPkdx+gkbreIzD7HJPUdXT9e9UpAq+vw63cw+BVZr+D7G2R6tCQCciBobmQpRZtiPK/tSLgdhoBwA/PvjLe65mEtdALIPMbc58LnRoQy6Tk+GkWALOcmEeba1smnz4GhQO0WRHR9OeDngtM/6TRwK7OeH6lrPMEeweFDObmur1BdnThakSrFY3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC8XuxTp2R9ob+IblhaI8QmPsKe7ZIUB4v2eHeZgQ6U=;
 b=S763TSp/EROcAuN/FNQE+Z45Wj4nzmCvGj15Q2DG+z6kmjVur1xzSej077sqy05oCEil6ra7iR32/842gVQEem90p3A4cAr0jTgI99J06lGh5brEoHpYnVtOF7ErTK/goJD1LlZPby1RVQUKynu2KQahRjm2cycthW2bweSH/sxrxigJ3r/D1acg71dl6aRKy9r8eCC0lCZXAx9LynKnMzIL9S2FX6s9DWT7/cQN3EBO74HTn4lr5sTVZ9OodLxKcOEy6ZqiywjJA8sdk5FvLuHdF9ycM/mDL5CvZBOomDmRGhkD/iJDD8/xM+TeXpO96wtd1J9wew9vXQpRYI2Vkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC8XuxTp2R9ob+IblhaI8QmPsKe7ZIUB4v2eHeZgQ6U=;
 b=r8DHizQFkrhdV3LH8S0a8V5qhh6wp2fc6HNKp2hMRH2bXQKaEE6HcVoQDRYv7WfaTQpWoVffpxum5T1FL1lV+POAR2mRbwGd6wBruFU5HRFMRJQzJeCqGEeJRRw220FXXDH3rVVLgVWZaL+j0lpHGLHF2FcKHL6M9EV0IklkDZk=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 13:25:37 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::5d51:1728:8288:432]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::5d51:1728:8288:432%3]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 13:25:37 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 umr 3/3] Enhance printing of page tables in AI+
Thread-Topic: [PATCH v2 umr 3/3] Enhance printing of page tables in AI+
Thread-Index: AQHXZru2mF5Ixuf/YUuPnZqQWnzsHasgBoZ6
Date: Tue, 22 Jun 2021 13:25:37 +0000
Message-ID: <DM6PR12MB35472AD577F49583858405B2F7099@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20210617192540.4272-3-Joseph.Greathouse@amd.com>,
 <20210621163712.17852-1-Joseph.Greathouse@amd.com>
In-Reply-To: <20210621163712.17852-1-Joseph.Greathouse@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-22T13:25:36.986Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:f2c0:e4c0:b2:d3fb:b908:583b:772c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c652c004-b8a5-4d8f-ac8e-08d935813916
x-ms-traffictypediagnostic: DM6PR12MB4895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB489567ADFBC5A03066498AE2F7099@DM6PR12MB4895.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCFCF65OvdmIh5HaQ6Lb0TD7l79xYNrevOoOyYaBM7lhxGQHULA7cJvCVstKCQdin0ub56OrEhuQ7weW46VhQv/rsZak0qsVzaKUKLbXNLn/1k3KMM9g08UOB6MYLcaxxRekgTO0+OiUKLhlVbprjO+xE3EGtHSUAkFKmFUKJ+hl4y4zrBHeJpF47MehraEvHmeFIPK606d8WGr9wug5OmPYbfdqaBfk5NYSHQj7SIbDfvnumdtr79Vmzcmtm0Gs6f/lrcKMTQ8Hwk9L9pYiAMHl4q2TCi/kbKjK83sNWOjas7AMs6Ul4KC1nyhxSfxTjev4fXayaSQ79Wgn9FljH+OUU8HCgRlVtZQddXXCqIoiYSuEpbG16BsuifaJcrQ0FRN8/onrHrkKuk79JOEFnLebems5zw6RY3aO+rbTRjJuoEBTnAqaPovKrMICZFBg9v3d7rUygVevGqUKJwnc87u+jUYS8Vj7SN2NIMWj+d7P1c3oEeQNgli1d5GHQtU72nh37GkqSKQ8HIpBtZ/eHQGBt6tiZAujiQz8m6ZLvIKbxHBP0glvpBefb74WeAK91GFR8muTSk/eXT2jUpQVXdioxQJplPx+KlS28JlqxiU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(5660300002)(2906002)(86362001)(9686003)(83380400001)(33656002)(53546011)(186003)(52536014)(6506007)(7696005)(122000001)(76116006)(110136005)(38100700002)(478600001)(8676002)(316002)(71200400001)(91956017)(66476007)(8936002)(55016002)(66446008)(64756008)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h/0E4tuuLOmNTZdicGPNWPTIKztYbTuGs6igSsQ2MffEZjowsLCuqVqfdm?=
 =?iso-8859-1?Q?FAdrDJeFwhOIJIuJ6cF6pMn1LLp9mNka8gYEDzBZNzwtrinujRuQ7k+t7k?=
 =?iso-8859-1?Q?ajxUYoCLdSDisgy40blcbq5MlEIlwnlYHxDJWpRL5RjNsdJOWknPoFZiY/?=
 =?iso-8859-1?Q?g+aqSS/C2tbFGO1PBhclRiPlKRPcwYmW1rnZKnIA7ybH1B4jVy422Q38CG?=
 =?iso-8859-1?Q?Pmo3BvdRHhNgphJBHaJ2FewPXIxOQ7J4mUAEFkGWV2MeBMchQiLE0Dv28M?=
 =?iso-8859-1?Q?t90R6NeHFzeMZBDQ5MS9bhTwFNGUfJHj+QhTuNdpMyMlnMIwhapMvbBDO5?=
 =?iso-8859-1?Q?xZ+gmUIScxqYGDyrj7E5clmHTVL3L7hO9LXhLaeYi2nU1HnfjDerlrGtaH?=
 =?iso-8859-1?Q?azp+F/Lt0zEjYtDoN8QzflgKi2bQeFMK5TRf89q/c7GynUkPLcRjtlnrnY?=
 =?iso-8859-1?Q?9QnB7vQ3L04b9EKT9vzxaNFSgGA8tiSCgc0BYfGWVX8I3pBp4OmxJKxQcT?=
 =?iso-8859-1?Q?lGl0epcUFL5P7fyXUFIfUAHs3J740qG8y1S/MG4ErHlIjbrfX/snxHGSgg?=
 =?iso-8859-1?Q?wbhqoPNP7bVDWg3RK/wajNcNV1a7rRMQGd+iKHDbEoYAIwjX0s2PXYNaEC?=
 =?iso-8859-1?Q?pP59zzgjq8cBgC3rKZotftwBrpmwqB88n22NVyXo/oX/2dlx+mj4r2ELuC?=
 =?iso-8859-1?Q?0CyVE7XvkJOcUHaaFHJlN7ORhmO41jvYy7FEtLtXV+AvVA+LlSwqAN5WM2?=
 =?iso-8859-1?Q?R//XKsPgY6/YHNDygBXS0l/N94rjT5tWP4Y0tOplLOcWwubBO9DBcVLBSA?=
 =?iso-8859-1?Q?ZEzXv0SxQWZJbymC0mfE6GdUtP1Brd8XeVs76w2H9BCj32Jn7g9Kupvp7h?=
 =?iso-8859-1?Q?BAxlEeatwNFGhl2xTtL/jeZpnrdnZVjVvcY1SKfIf3//eGBFcXDU9+YNUd?=
 =?iso-8859-1?Q?/oyrNP2uoS0Fdh8w/7AVP21pFQiOSx+Mir4Cm8W2jAIkPWq80AuxdcgxDl?=
 =?iso-8859-1?Q?gq4a+bST4D11cTen3pOUg68YOJhhJw80Qlsuqe9Wwxl/+fjZiaJZ5+/5c+?=
 =?iso-8859-1?Q?MxlDHu3AdrDhceUjCd1K2wIxPJy0wSGpbw71plIs3/wZVzAW59MXKdUk3X?=
 =?iso-8859-1?Q?FoBocslHAqUk0vyklUlq5pu/WKHPcd/+0hpLXh/Sdsdl8Lk9F2tOZ3yDaM?=
 =?iso-8859-1?Q?BiziB/pRLdSETQDl10ZNfvGj/T4HqFf5risksPzvx6AVfBh9qJ7LpEjX6R?=
 =?iso-8859-1?Q?jI+YuhsJdth65cuLzXaSQw6WFIkp/Sln2wo0WJYiWsOF7QUxKIxtlCIMy7?=
 =?iso-8859-1?Q?Z8RvPoHhx3t6ntbEDpQeq0mu5xMvAUajprLaok0OnsVgHaIeaurSNkUmaE?=
 =?iso-8859-1?Q?62uQHQStUV2Qi0XlwFHw2QJN24vACoVK2z+04Ou4F3OPhsVeKXXdk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c652c004-b8a5-4d8f-ac8e-08d935813916
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 13:25:37.3447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dZ+FNB/wQ3GDnppdTo36gINXTt5vJfCrJFvHgheNB7oYWpnGVkqdpfeC0obg+VyR6We4F3lSBC7HXmkLKuMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
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

Hi,

Just a quick update.  Your first vector passes with your v2 patch in place.  I'll add the other 3 and then start reviewing the code.

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
