Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA62BC3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 05:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0D710E048;
	Mon,  8 Jan 2024 05:53:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096F010E048
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 05:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIidKPH4iNh5kjN4KP339vKbUxoOscXWUEjc7fbAviwpXdI/P8Zyi8XyUQr2NoK+cpFTbt9Jg63s1tIjpLw2G/qxUrw+vsrhMouIj9PrsA7BkZpLvMuHQhffSr3N674S/TjGyTLCAXe7HKnyQGW4ekL4EuiSMbJx0LzTU3aIJ5cVS4oW1+TWdVVxiR/9P2RAr19PI30qRaiMGVduFXv6o/cMHfbwi8VapUPiK+q2FGRGml8B7FSqUFkoR3ikv2H4r/YQpBRa5GVjdnSXBTcgaHsv0fVoEPaCrBPJO1CxEVHX4wr+WLVxbt6ROfTr5lUWF3TShaSb4IMedV9INjKzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQVTt6LcipybHwdk0a7ZyNm2Cn6Cf2NfZbjM+OzHae8=;
 b=eELEDF9NA2Dd9t3a/gaC5XHiD7njx8dH0CEkOE6O2YfomN+EGBHyVPtell9fJV7skmBI86+D+6tdUL0cbyEPZzrEhLlZDVjdjchOGiGkbjzQOT8Puk/y3IttsmucHaOdQVTe+Bydg38oK5j8GN2vLNRWHZWLr1Zv0sDt8qNQC4avLemX3p5Zm0sX34CBxXzV4p9P6QzhGbW16PMen/8YRpLw9k33MQuqmzhRvqxH4hdqHcKwKeuMYRGYCLxJk8F9AHs80IwGB0bWuXdSC3d56PdDjGgffmiqpzlZU1AE7/pEsSpV4FgEM1H/uMzfbnLeomJeDM7ynqOLhfpBe9y8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQVTt6LcipybHwdk0a7ZyNm2Cn6Cf2NfZbjM+OzHae8=;
 b=odixol1j0ll/GSMScUV1u7CorCgqNMEvaEuajsCDpEc7z106UpE9K5BNtaeqOObmd7eIYGhZC4ocYvzpi/P/YPFba/6fDShvD3LmZCEVqfChfcZYiwKojlFaba31TQVGSiAwbU1BJslX2hlOojzKMG8KJpJQIqYgKlGrMHif/Bg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 05:53:28 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7159.018; Mon, 8 Jan 2024
 05:53:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH v2 v2 2/5] drm/amdgpu: Init pcie_index/data address as
 fallback (v2)
Thread-Topic: [PATCH v2 v2 2/5] drm/amdgpu: Init pcie_index/data address as
 fallback (v2)
Thread-Index: AQHaQX/s57ngr7VlU0Sq8/Yp3rpMarDPaTHA
Date: Mon, 8 Jan 2024 05:53:28 +0000
Message-ID: <PH7PR12MB5997B577C2A840B34DF13071826B2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240107154011.12927-1-Hawking.Zhang@amd.com>
 <20240107154011.12927-7-Hawking.Zhang@amd.com>
In-Reply-To: <20240107154011.12927-7-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=04162585-2831-414c-9027-d7bf485a9434;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-08T05:46:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB7337:EE_
x-ms-office365-filtering-correlation-id: 5598608f-e002-4dd9-1e74-08dc100e231e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WmGE8XERgcaGbOe0qfMgEl1VFDagXn3M1KqGeTEWmrzAEY3BkEAEwTrmXXfhxXuthR45RCfAJt5yKb3UTbf1MZrT7VjnY/NUuEjdAdfYd+ct5dAn3wqGCdrkk//K+FW+5yo0JZCnZeLbV747YoZOnxtKNeBwXvyZ8yN1FyUrgi7dqbm4ICGrnHifTj/dgbXEnsJ9+q/aVxekkw19xKQt0aZzNGDQqayIf6NlpkdUM0J8wvst4cTXI4Tyd6SxwPsEEyEvjTZB1w/VWiz2WGUKWmJdRFMKOm2TWcKQHaSPTyFbIlsRE9q9rfBEYdiZaoM5XE6mi/8wRuotGQvf8niKdPyBfUbhCFPVkUrydB56GEHzzUe4jjVoWO8lZfcuXDjtkGOX4AGiWuWCWD0P2mjOuxUuMC3yhADmZaDL3tkSMIvs8f+s8XlSzmabrPJa7Xu59pKXgOPBU/x05aNIMstbA4Xv4L0ARTJuvi3KSRx+yPTgP1ntt79kR0PLDYk85G6nM7o8FIjmzPuPXrYB39+GEAap/zw0cwXtUZ4cpQm3SimxUi3T1NvVxooh3Ch7kVxsNAj3ouIHmr9hnjuurPS2y/mS/vrS/tDrsJaQShLx1YK76pXnS7eRf9PZK8TAzlGj9HZugAxEWp/pchnJg4zFyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66476007)(66556008)(76116006)(316002)(52536014)(8936002)(8676002)(26005)(478600001)(83380400001)(64756008)(66446008)(71200400001)(6636002)(4326008)(55016003)(2906002)(5660300002)(38070700009)(41300700001)(38100700002)(122000001)(7696005)(86362001)(6506007)(9686003)(921011)(110136005)(54906003)(53546011)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?emlsN9HsDHakmxjY8eWyZvT08Ej8ZaHQcZVKoDR5lRMGWbDAmckxv89SRsWd?=
 =?us-ascii?Q?5HG4R+zRGAg7BGATtGZOHKWhN3N+aInfNN6r2j6TZUAwa6sIDa4/3FDzDQNL?=
 =?us-ascii?Q?LTjJiAOpIhTxFYmDn6E4az2CuUYgkSz4hwV2RD/43d6w9eJwFXoyFUwa1bIo?=
 =?us-ascii?Q?ODGt/mP4DC3luIGzJqwHnQ1XIDxoeaB/GE2qbqPe9WEOMtjb+LkOHC0bJp2B?=
 =?us-ascii?Q?vBunB59ZnVQRCoq0O3TX1fbjN+9KI/mA5VipjADH/KIyF9nNTGm4zuLVnYHn?=
 =?us-ascii?Q?Vm15vXLWexssTpQwzKZq1Sxl8eCIlqNrMiyMblWATgEJignCaFpqQLMQL4Bv?=
 =?us-ascii?Q?8GC790nwoQzduOWnLOVo/DZh3nfoTuVIQaYCEaGLxEi4y7iYnqzJZbm2qqo1?=
 =?us-ascii?Q?ngTNIPao5krX136L7E6sreFBloM+741mqXpDtBj3n0W8aROk5vSlcdJrBIWa?=
 =?us-ascii?Q?o+P05DQG6whYPtERgBami30aw8MVNGuDkagILAxCOfhMfyhAZ5zlvPK7scc3?=
 =?us-ascii?Q?XOoB7At24w6iOr9SGItZLmDZKp02ZPkgA+1BPOHqGvSIS89xEn5e79QV7qEr?=
 =?us-ascii?Q?Ig9nzjXLHSgauOuUGBCneKFHYvAU6wL0Bi+G5YVFT7nc4qKGQeqvxXJRo2FQ?=
 =?us-ascii?Q?UEj40HE2HaNWLyDHRXKxvvuw+oA6SxFSvu2gqwvunDhIqqtZM+e8k04W5ADW?=
 =?us-ascii?Q?bYneh3Pcd9exQ6k6YBL9J7vbVE5+Rdrnz1be9hxenMhyDAQYZHS31lY58LW0?=
 =?us-ascii?Q?P/OgHax4h2y7ynds+SWVXwI46EZLNAcaRoDcz3pa1C49Cder3IX3n07GKIUm?=
 =?us-ascii?Q?eFgnowKO3CRTaj+fW7QI8tfru7lcWtwYOUOhl81mn6d6JEeGF8EWz9HZx707?=
 =?us-ascii?Q?3QpeweRlF+zZTiB+G2fWAhAySXklDXEtZhapEPDShasNKS2lAZDLa4LrDbj9?=
 =?us-ascii?Q?gixKJWiWSoR3EhySP0dkZEySqBWSvX2IM2zRHythO9EqXm+S3gCDsw+/ic/c?=
 =?us-ascii?Q?LAQcwlPRvTy+ymCOpHtidMuTe+pXIYptoawlccsMmZnCMcYFTISBuU4UK4wE?=
 =?us-ascii?Q?ioAidZohZzzexVqkakZL7ktPBgqs37bkBwEsnVqQAg286OhRFwG4UkvKg9fe?=
 =?us-ascii?Q?u/Rf+I/OsxaWjW7caN2UFaBtFwepYBnDBhJvQRPMcfcuyc0iKS1TAN7gA0js?=
 =?us-ascii?Q?LETnCuLVCzqzjgUOC/Wi0ck7UXY079JWNJom7AY7tVJML+mdhOO0yLKX16Ku?=
 =?us-ascii?Q?5SG2TU5Ikeauab5Gak7tP2tmWOxMSuXO6OrMS4pCPVhNPMXc4uMO2qqYrBbh?=
 =?us-ascii?Q?QAYBoJA+P90jg7OfHNhhK5UN6fWN/T6Jn4GIB5RBZxwUlL3fhcrCY6Jr25Vx?=
 =?us-ascii?Q?+PAt6F80zKlWaz3Saz4tHHwV8MyRiOrviFQwHh7uOBj9r3XSACjCko/oU/SN?=
 =?us-ascii?Q?74r2DhvGyREFaD1uOksJZDyQcBD3qp0sCj7UzE+E8Frgywl3F9CMidn9FO3i?=
 =?us-ascii?Q?SZmjgz7vQzoYFtmIsxmps6t7bqgWtGUqM2v81i75Uv08WHRHAXwI8le5Tlgn?=
 =?us-ascii?Q?qipltzoeTUpAMn4S2zo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5598608f-e002-4dd9-1e74-08dc100e231e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 05:53:28.4036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8j9+4nQqKBGZ/bEExvZKC8q9zBSi8FG8tOueDS+RAL73O3bhkC3BrX8UDMslH0EN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Sunday, January 7, 2024 11:40 PM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, St=
anley <Stanley.Yang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; C=
hai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH v2 v2 2/5] drm/amdgpu: Init pcie_index/data address as fall=
back (v2)

To allow using this helper for indirect access when nbio funcs is not avail=
able. For instance, in ip discovery phase.

v2: define macro for pcie_index/data/index_hi fallback.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index abad5773714c..05d7cdcf28b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -96,6 +96,9 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_RESUME_MS               2000
 #define AMDGPU_MAX_RETRY_LIMIT         2
 #define AMDGPU_RETRY_SRIOV_RESET(r) ((r) =3D=3D -EBUSY || (r) =3D=3D -ETIM=
EDOUT || (r) =3D=3D -EINVAL)
+#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2) #define
+AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2) #define
+AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)

 static const struct drm_driver amdgpu_kms_driver;

@@ -781,12 +784,22 @@ u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_dev=
ice *adev,
        void __iomem *pcie_index_hi_offset;
        void __iomem *pcie_data_offset;

-       pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
-       pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
-       if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset=
))
-               pcie_index_hi =3D adev->nbio.funcs->get_pcie_index_hi_offse=
t(adev);
-       else
+       if (unlikely(!adev->nbio.funcs)) {
+               pcie_index =3D AMDGPU_PCIE_INDEX_FALLBACK;
+               pcie_data =3D AMDGPU_PCIE_DATA_FALLBACK;
+       } else {
+               pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev=
);
+               pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
+       }
+
+       if (reg_addr >> 32) {
[kevin]:
Gentle reminder that the macro 'upper_32_bits()' can help on it .

Series is.
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
+               if (unlikely(!adev->nbio.funcs))
+                       pcie_index_hi =3D AMDGPU_PCIE_INDEX_HI_FALLBACK;
+               else
+                       pcie_index_hi =3D adev->nbio.funcs->get_pcie_index_=
hi_offset(adev);
+       } else {
                pcie_index_hi =3D 0;
+       }

        spin_lock_irqsave(&adev->pcie_idx_lock, flags);
        pcie_index_offset =3D (void __iomem *)adev->rmmio + pcie_index * 4;
--
2.17.1

