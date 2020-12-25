Return-Path: <SRS0=eRNB=F5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7CFC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 07:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36232230FF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 07:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36232230FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2A689B3C;
	Fri, 25 Dec 2020 07:11:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0156889B3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Dec 2020 07:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDP5oKRHsg24jQdIUaxQbWOvzOoM9YDEJefQSLY1h43JePxuqNiSCf8C54P9nlJY1Rwascl/E93ONnhubYHqzIP3hciiC7Rmz3g0oC7GrhnwqLQbEDiY1AucY92Jk98GD1Dhn/flFxrFQELg34ENPDTfmYhbyvrtyPyMZbANBSHH3jGVQyXtTqDFqK6dkMCWdCS2PYzJ/SzKKvjcWoongxoSWhqUcQ/fi6XKavQnlbegz17nDkU6xzEFkoGVFsu4fbUbFw3jH504agRvfjwiIADvStjNGLesDlMvHFPtvGWDRYqwnn6opphcmWpfk9qzGg0g9lPIKX8pP+zzYiAVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkHbpemDgnMI9LfDgulTKOVg31g0nGSGpYmjkKAqsc0=;
 b=FZZUPS8xuwV9AkMrlOv9qL8394zf4XqnwUo7L/4QTdmo7/PDl3e1nIT5O35dBGhmrHEe85NCBJv88WqwdsvskO+p3TSTli3HF91Jz1dZcDFh9Je5spVi62svQBPHfgspv0YmTeqf2R32UTe/DCn+BkQVWiTpdYUfq+bJ3RVMz3PRVkMLq3el7Ta1Xq9Q9YmgqKSVn1OXRALkGQHOpTHxY6vrR3YGmJ+q4WUBWNSsuu6Gx9o27HWOb29q+Fjqujx0mTc0WArhUvc9tJEV+otkq9Co08syCkhIJvW2g1URuNVp32cBWv7OT/TgMFZzki8hvwB9othfmOTrNEddOoSpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkHbpemDgnMI9LfDgulTKOVg31g0nGSGpYmjkKAqsc0=;
 b=cfhyX9j5eFs3eREhfbUCNTDqkIJgk0THRh4Oxbt9bJhTsqY89QGeQ+ffvApmsX+ieMyLrSx4Qp7NmRGLoJjdP4fKl83VexMaNAjpOaNRSPJjlfAmXeCswr+fvlb2IJHf1u8vbgMgLU97ewpCJI8t2gvhNae/bSDK4Bk4sw6giKQ=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Fri, 25 Dec
 2020 07:11:36 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%6]) with mapi id 15.20.3700.029; Fri, 25 Dec 2020
 07:11:36 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: do optimization for psp command submit
Thread-Topic: [PATCH] drm/amdgpu: do optimization for psp command submit
Thread-Index: AQHW2ovj8Rn1I9RR3kWHv8mItfHQf6oHZSlg
Date: Fri, 25 Dec 2020 07:11:36 +0000
Message-ID: <BY5PR12MB4115414805F40D8B773DDAFE8FDC0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20201225070158.13066-1-PengJu.Zhou@amd.com>
In-Reply-To: <20201225070158.13066-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e35669d0-34ae-40ec-9990-0d71a0bdaa64;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-25T07:11:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b6ee2cf-bc96-4eca-d7fe-08d8a8a4514c
x-ms-traffictypediagnostic: BY5PR12MB4968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49684974C89E72439921C6CC8FDC0@BY5PR12MB4968.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKMkpw74D8Cbx5c4EV/X+dnGXIruCrYgTXq7uS61r0tzHTDhv2/3/ucVjhbIf7FvKi4/cMtjZX+uOCy9xWtga4/O8nZe1DOfcbhNjuOsvhwuXncAOmBL32apRyOU6jwDfuJv+F03C1gMMxpSDsS72DKQ8644xd6Kz9ybWELIeU0knJQAneLaIx+0svLH6WX7nIbhJWtoOZBGb/+YdBvEnlAVAWs6rw+ERYTVe546g/m4Qhh/Ht+yLuaMlmbbJ6y19u7gW17TeIjigq7bhYZ1SOn1BMuGX6tSWQBSXa2jg+jT5+92Fl8qghVyVxK0T+lOA9ghkI6/rYMb+YiAHHwzoK/StS3qiTt1jf+fEfYG5neQo3CRg5kqDR4VVBwK0mxl2JVcGmUP0takVd7DHZY1xOBQgI8O2PNKabzr7BNLTtxsHDDQ5q2F/xwXSQ8GieHoU46HYqhTzWueZR42UPuo9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(71200400001)(83380400001)(8936002)(86362001)(9686003)(316002)(33656002)(110136005)(7696005)(66556008)(64756008)(2906002)(52536014)(55016002)(66946007)(8676002)(26005)(66446008)(66476007)(186003)(478600001)(6506007)(45080400002)(5660300002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sH/EylKEndZGxnbHHMzdLSGGRxIpIIKCVZspX5om2vVq1o6fw2KlkUPZpAtU?=
 =?us-ascii?Q?bdv/qUwYDv1vJx6VvyV7BKF98i+DX1uPjpTyYVWhFY1G/Aa+EtALl29178JH?=
 =?us-ascii?Q?d7tvcaRI+0nlBrDfCM0goi8vD/yenW2Qsanyc9g0nEprm+5VF1t3aT7ZMwF1?=
 =?us-ascii?Q?dTO5yj0yhrOsjmQbh4EVMuOiHm+0DN4APFXcTN0+iXSk+1Z3tsLYT41bVojX?=
 =?us-ascii?Q?UVD89i5GKKZpkB9J4EbzyU/4Yj/AYAnVqYdBlvcL3ZQOxlLEI1/DybQF3WEr?=
 =?us-ascii?Q?u4O1vexyQvzjUCXsJXBE2/p2TVjlgseABHtAVpOQJaR4NeEsCH81DNg+PrCG?=
 =?us-ascii?Q?x+oz9s7uCm8kO9fhC0n5/9mj5bd7jbuSt3XYSaMds2026a+MYHNx+N38ivQJ?=
 =?us-ascii?Q?gl9iqUjOoGATzxFtqs4y10MKnvGvaTvDFVGThrIEgYO+8hQ8BqG7LcbiqCtx?=
 =?us-ascii?Q?hFsbFTOT5Ih+oEARzgdVxQcKOnbdgdQdFi2rzBRLTMzghriAlea5/jBZfSME?=
 =?us-ascii?Q?yEMkmKoQae3uKQQnUYCd47ydt7Dp2bjYFB3M7z0mkdBMnvkdwRoGyPdDWARP?=
 =?us-ascii?Q?lsMgsNiLND8enZffb3FdCpKSNIg32KmgmzYKZB2NgK494XO4RS8d//V6euNh?=
 =?us-ascii?Q?R8WLzhGqC730J01M8fbdUlotHmWrBXkpQfanYqkrixM3HLXq45XpQoY7teWk?=
 =?us-ascii?Q?3oSKWveuTnG/mz6kXF+6vcye4lrT6GZRwDADj3WQ71nTOuX4j5Zq0JjTxWVY?=
 =?us-ascii?Q?6Q1RrhcJRR1f27afW4Wzb3/NlaQbOoZrK6WLrY+2eRRMilbcGB5lNkf3IqNY?=
 =?us-ascii?Q?q3HRbsYI2uFlTB8dqcWtVs/rBFyknKHVItm+ez3hW7EvRBbRlKTyBpRhTCjt?=
 =?us-ascii?Q?vQb4st8+TtG4vWVxjhAiSP8yUyHxdBYjERiTpt3wJTK6QCRmDqd4uhap0j3O?=
 =?us-ascii?Q?9a8iG8sv7PUfmwOTGXt1RfkmVqi0+ct0lEivoXk/BKA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6ee2cf-bc96-4eca-d7fe-08d8a8a4514c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 07:11:36.4510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rPT3kXqqRKpufbhHyP1tctV4dQw6Ls91Oh5I7LBS9Fgtlof3wtxd5IMiZAzcCvC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Peng
>Ju Zhou
>Sent: Friday, December 25, 2020 3:02 PM
>To: amd-gfx@lists.freedesktop.org
>Subject: [PATCH] drm/amdgpu: do optimization for psp command submit
>
>From: pengzhou <PengJu.Zhou@amd.com>
>
>In the psp command submit logic,
>the function msleep(1) delayed too long, Changing it to usleep_range(10, 100)
>to have a better performance.
>
>Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index 523d22db094b..8d11b34fe40e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -249,7 +249,7 @@ psp_cmd_submit_buf(struct psp_context *psp,  {
> int ret;
> int index;
>-int timeout = 2000;
>+int timeout = 20000;
> bool ras_intr = false;
> bool skip_unsupport = false;
>
>@@ -282,7 +282,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
> ras_intr = amdgpu_ras_intr_triggered();
> if (ras_intr)
> break;
>-msleep(1);
>+usleep_range(10, 100);
> amdgpu_asic_invalidate_hdp(psp->adev, NULL);
> }
>
>--
>2.17.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C57638b8bb2ed443
>d966d08d8a8a30448%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
>7C637444765410848027%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;s
>data=Ypcwgp0epONjbZGria4RwVRRnrIQs%2F36%2FnzWNXUDPRU%3D&amp;
>reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
