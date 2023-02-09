Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C4FC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 07:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2B010E91A;
	Thu,  9 Feb 2023 07:12:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8473110E91A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 07:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhYAnMby6ghAY3Q3JCc5qlgqbuoHQs24FFryLvgRILcupClmottvUSx5UQmc0YqP4tkh/YF2kGAb/YqcK2t1H6nlWpXH1q/CLFkMMZT+e5VG3Kgdqi2C/91oDYBncleRgOqAIECLc/O3Is9tLbEPRaVWJ0Snvt5STqdBiaqm3OaPzHjo9LT5zakNXP/KQgCEtINckkj3GVrq0L+hDLuLBeiiBvptbVPGzzfpJ95HrtD88inGz/I4UfG+mNldjWc3yQTapciTSpL3fcA8gyIjZvyH2UIerQDp1W29/FD9+eKPRp8Cma5TAmeXeNB78dcaXiyjFAJ6FMjCxJn3jwxiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N+iKkMsMpu1SEmIGDtwgNXK2nKGYFSvsX1qKs1KYek=;
 b=DJLyINrVdcpdlzz02w8cjVYSBVJE44Y3eVcd+cYjq9kKIDqLcXW0HWxlKnH6rW+pyd9FFduceOmORlleSUhYA7CCQ8kbkKY/ES33TpxAxWYu8gVIpNpLWA1D8Ggead+3Po91HEiCtc0s1M1p+2QrB5zJ2o9OQ9BnLwews3o3TeMHsUGx86X9AQP7rHGSopwnPqTaqqmazLQ4hwi2tlNyLMSe0CRmNZZ9vOypk5QPLRVS+EF7Gd4PaOxcGMYrUdt5V0kEioOk+nRb+HNicML/07R0Q0pIErJPMc75lEvmAsDVaLN+7Pg86CL4Y0mvrkJQ0TlofASg7ULIyPH9py6wpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N+iKkMsMpu1SEmIGDtwgNXK2nKGYFSvsX1qKs1KYek=;
 b=rBC4TeDdc6bDRX8LyUxiz2f2952hUNG4x5z6UaD9P7SZYs8tQV7HbUez60jYFop00RYutgO9uxJlMUOM9Y2gjnYX03kXVkv6GF9EtS8z3KWfJ/QTsvxFCXrjcgl3d0zaNtZbl98A71SkUOgCsm55k2xAEGOQ/xebjNrssoEqR48=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 07:12:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 07:12:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Thread-Topic: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Thread-Index: AQHZPEGDYOeRDQ6vM023lPktTuRCpK7GMsjA
Date: Thu, 9 Feb 2023 07:12:34 +0000
Message-ID: <BN9PR12MB52578D18FB80BD45372C85CDFCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230209044616.560657-1-alexander.deucher@amd.com>
 <20230209044616.560657-2-alexander.deucher@amd.com>
In-Reply-To: <20230209044616.560657-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cdd5f4d3-6137-43e8-bff8-11efe56428a7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-09T07:10:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB6391:EE_
x-ms-office365-filtering-correlation-id: 4f094489-ee41-4ad7-df97-08db0a6d0445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wynpro7GW6rTreOvh5ltTip0oSSfGF1AGWejMjcUgD2VcL5Xb7pns+RLnTdfj+IXFd2Di//U9oPT3ZBwBtWPOb34azAdUxRseFqr54M8alO4ngXpQMDypY51glYgMoZKoeUqJNn/fDaToSWxHGenNvR/MFsslATTkt3Nye+MVHq3hY5090srnAcqTVu5Gp3JwlnBjreJ+wZ2Mea2J8C4fRPCl/Y/dAPUTlneXIAQQEwzYEtJgMIFWrLakA0S7lz5apKTDRFqFV+rOXKaDB+RSBoT/RW7axRrQQC0bJhQRjIkE7PpqOfIYGVgDw2zVwWhd0J6bGbq5GZsTBy29tJ73fDvsC4vwoSDwZhscw+DQFyIdEgpOY/LHGpxGBZ04mm/Ibm+R8E6XlL6jTlL77wIl9KdzggrEVmFhs7lYNQkYgNZmzLUWVt5VsSsUVTkdf2Zjvs7EFZ4V7dzFova8Voc0gNeC1O1a+7Ms4ZxrGPGUx6UR+/2M2ANl0nwtfCa0663ZEfVu7+VewBMrcgIQH9La1QYIZejcqwPvezKjHgdrLzVJB4bl/W/g2eBiHtD2ddc5UiCxB63lshb1oUbCWBEKuNf4AUG9eJJ9jOMCj9u3Vtb2ihvrgaF2jHaGa6JNLV1feHoEX9IwRLTJuWkRXB+d59YVb1RbkwcgfSHNmYVgB9Qsil2fFKtCx+nKWti3fNqn7b4F/pm9VHj1qqVkRQdQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(2906002)(5660300002)(53546011)(9686003)(122000001)(38070700005)(55016003)(86362001)(8936002)(7696005)(478600001)(6506007)(41300700001)(4326008)(71200400001)(33656002)(83380400001)(26005)(186003)(38100700002)(110136005)(8676002)(52536014)(316002)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CTmjCjo9iuC0rnn0huCuB5N5V7Rwncn9o+ZmOmURZ2XuJMQC7N7wqg7Shhj2?=
 =?us-ascii?Q?vB/lOsmb6Ky2Q6albUjgsBXQXf/2MOI5dYhsyMGTwZ8aZskvNq1SrysZytlb?=
 =?us-ascii?Q?1UPrSnrW8wEREg/psCm32oVzcbh3UZbgqA7eAuqlFVupovHZin9857fgiDjq?=
 =?us-ascii?Q?9lwjPg6F2sgCz1fSfrhgnnwD4T2SJi9vMWqBWu9EgvQa0gAO696IQP7T5VNA?=
 =?us-ascii?Q?jPa7/PmvKI9GkWxGvmq9y9b+diB4FoofdqoAy9Gbk3OsYSfm0tP7YJhso/qI?=
 =?us-ascii?Q?FFwtRFGYv6yCnzpPYN4CdoGzfqmOAcVSOgPwb+Obb0WiTeYTJ344JX1P5pTN?=
 =?us-ascii?Q?awBKDQGvJA0ZXbtOukar0Ga2RCICuWOPYsHqS0f7MyntBlAGCDkxzGkoGM29?=
 =?us-ascii?Q?VYwRFAonjb2Nin8lgCzcxSjg8kdbww4s8EphNZ/O7xADZ6HJ7Q8ivklMbtk0?=
 =?us-ascii?Q?HcKUlBcqXNaPDGYu4vlhW7CdW8dDRa6KHd/qjcZI59nlMWQ53wbcQYsR3szi?=
 =?us-ascii?Q?cbcUeztuQ8bxekTBiOhDumTI7av05ayNwMFq5z3Wk7jMCerXO2pZChNOUmMB?=
 =?us-ascii?Q?PhITN0JC/8VtG1Za9byuhrc+8gA1JonfXYS5VifvMGLj5eLi3U+WL8R9dpxj?=
 =?us-ascii?Q?xYVRj5nM1hjPzuxWPgeM8m6GwErAco96T+GtG7/vJJ+pkigCmb5Alio1/v9e?=
 =?us-ascii?Q?rf93I3Ts3P6am1mzLGPcdfbEC+bctyvwol+q8biAcQxUgwCrYsWznXU7X2FX?=
 =?us-ascii?Q?kCGQSzRNZcJD0KQPlLB6153lytQz6fB3KllXiSAXnLkRylGIP1H573tjIcCR?=
 =?us-ascii?Q?q1JHUkKPoDk/hkbotAIcP+2gzUz8vAFsIVHKtpNZRCmZWapUNypOx/WCmq09?=
 =?us-ascii?Q?iWxupzpBhebU8dDXrUHD4kdd+fOhcOXDgfRv4qmlSwI0508W0DWrcP+NatLA?=
 =?us-ascii?Q?qAWNtFATDauLKPoLhwn6kFr+TynnJd7W4YYSHRtqVPdP8kJycwPvnqAjHk8B?=
 =?us-ascii?Q?fSxKUjic+NRpe/t1eNpZmXghywqEcalbLWKNgfPFVvV9DsvyHD6ZZtHKtPRv?=
 =?us-ascii?Q?3FadlWMnIQcW7HrBwRhahiHYLKLwZukVrXKV6RVbcePl9DhXsZWYOAYC/DtT?=
 =?us-ascii?Q?cbQpG4WTIW2l5Z4jQoBcX+eW9D+mrJsaB+hvsPkKc4kUgJyTgUv6dV15ExeF?=
 =?us-ascii?Q?ZWhVaH94kXjnMtKWKugHAVbVe8VPXZn6PzF6s0gmg3Zwyf6dCJtQUCWziHhM?=
 =?us-ascii?Q?CC0fpfuWXBAUduWp7dnvDfhwUw6k/maM56gXaB09w5eBxEo7BM9mUFIN0Pj9?=
 =?us-ascii?Q?wtNyuEirCItLY9UDQ/Wl95HVXalSTexOPj1LkY1C3Bu3w0o9COvv1QWxg3k1?=
 =?us-ascii?Q?xo7wS4xsOpVwjyyCNzY7t4/VADkUg/Gqoatnx0TtqLBY2btbfe8fZSo1zRa6?=
 =?us-ascii?Q?4JDGp32/wak9iGQny2bKzD7FX243Z0hhy9htSWxVqdhaEnhJfsJNZnhLjgtv?=
 =?us-ascii?Q?puPXLKZt4iEm2vdc2h7VyQfwGNxHgFfwjMwnr6lTbir4ulQDTuYJigaKDkO9?=
 =?us-ascii?Q?1oxUSakg6XCFpTeAvzEPjHDznQKFr25oIFn2EJx8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f094489-ee41-4ad7-df97-08db0a6d0445
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 07:12:34.2301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HtkgZ+SjXCSjYfga41JWkZnUtoSBUA7BbByuC0xxMPfszaAEACHaSe2jbwKZle3/tPbUbDaLFthlt75fqSYKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, February 9, 2023 12:46
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup

Use fb_start/end for consistency with gmc code for non- XGMI systems, they =
are equivalent to vram_start/end.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8ba4a57d8e6f..bf06875e6a01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1191,7 +1191,7 @@ static void mmhub_read_system_context(struct amdgpu_d=
evice *adev, struct dc_phy_

        /* AGP aperture is disabled */
        if (agp_bot =3D=3D agp_top) {
-               logical_addr_low  =3D adev->gmc.vram_start >> 18;
+               logical_addr_low =3D adev->gmc.fb_start >> 18;
                if (adev->apu_flags & AMD_APU_IS_RAVEN2)
                        /*
                         * Raven2 has a HW issue that it is unable to use t=
he vram which @@ -1201,9 +1201,9 @@ static void mmhub_read_system_context(s=
truct amdgpu_device *adev, struct dc_phy_
                         */
                        logical_addr_high =3D (adev->gmc.fb_end >> 18) + 0x=
1;
                else
-                       logical_addr_high =3D adev->gmc.vram_end >> 18;
+                       logical_addr_high =3D adev->gmc.fb_end >> 18;
        } else {
-               logical_addr_low  =3D min(adev->gmc.fb_start, adev->gmc.agp=
_start) >> 18;
+               logical_addr_low =3D min(adev->gmc.fb_start, adev->gmc.agp_=
start) >>
+18;
                if (adev->apu_flags & AMD_APU_IS_RAVEN2)
                        /*
                         * Raven2 has a HW issue that it is unable to use t=
he vram which
--
2.39.1

