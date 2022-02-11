Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4319AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 14:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B692E10EA75;
	Fri, 11 Feb 2022 14:30:49 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD2210EA75
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 14:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbmNUqRXApxvhslUy+M8w+HQNwDw9TE9nbQlei0s4QadrLnU6Kts15hpCLca2+2auWkflacLLzwifP5ia+scwWf9dAK+IyX1IYRyvon6PBQ+Loxl0J5MXpA7lJc8Z7sTH6/jpEVkUR7ooaf1DiDQFD7KEAif4cAgOJW8J0qpOeJ47M6zFHYTVVQsiOrQQaDXB6o92VVpUm7e3xwWaVRwNl7FcwFnRQzoWmXVNyQB8EHnZoHjS33/nbWlkyQ9VlJvCbYATQu4uPoa81WYAJN4T7hC+oAw/x9Y/+PDwV9P+CChOgLaNCSh7PJEuxUTySovGAQ6c5nyPCb/duVWChr7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PthzMase1vDzWknarUPuWz4M4goUVQzU7Iq1x3xp/34=;
 b=XjZYeIoYpXk/cZcWe3Niw6a7ZYksjz+tCa8OpWw+FGP3K/lILAq9B+hjYwdpfxQpSwB9YKJMOXbNC7hjL2BqU+gSOU1MDU0h6odJ1w7tC/onGoFYhizDv3oeYJsqRexI3ttuqD5D45EoZ8PIQ6dm5TI60+QKfApJzhbvk/9vyNhSFXkD6EBQUhePKTNHESgjt3DyDpqTAiYgr+UbnRqizS5C5jHW24VXmDY2Uk1IAJMomBszbY11jrieEivULWODmYAf0sjc0OOZ6bnbTG5bKsGxuKW7MVlJXgaNG+BmSPggqVSD9xFqZsBfDznpsSfawGXjT+JGztb8Jp3bihWcEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PthzMase1vDzWknarUPuWz4M4goUVQzU7Iq1x3xp/34=;
 b=28R/V7T5zmiSWq2Hw1y0KnW17ZEIEHG0hY005o3OfFERdrzBaKRN/suaeWiIk/ne1U5P26kVVHoqfy0Hn0YkpovPNtYOuJfUGHNcGVOfjTROZNtBx0qaOFOZTA7dPF35LIA+En3KVILDPy9gXci4zVI/5CxFQM8xwuPT3u2zuFI=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by BYAPR12MB2997.namprd12.prod.outlook.com (2603:10b6:a03:db::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 14:30:45 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::d145:f774:db68:558]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::d145:f774:db68:558%7]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 14:30:45 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case
Thread-Topic: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case
Thread-Index: AQHYHwnCycb9kLSAJ0KITnrGuOXs4qyN5voAgACCsJA=
Date: Fri, 11 Feb 2022 14:30:45 +0000
Message-ID: <BN9PR12MB5324BAB3362036CD55A181BB8B309@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20220211053856.31729-1-guchun.chen@amd.com>
 <BN9PR12MB5257E276C9E2512B17CAEDFFFC309@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257E276C9E2512B17CAEDFFFC309@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-11T06:42:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b8579452-f857-4972-878a-f17ef8f6b46f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-11T14:30:43Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b81e5f6c-b60d-4cf3-a0bd-d90e697e955b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dcc4797-5995-4c6d-4660-08d9ed6b1731
x-ms-traffictypediagnostic: BYAPR12MB2997:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2997CFB53C30D090E43550A58B309@BYAPR12MB2997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uF5sX7Jy/qlG+qSJAENqMchB+X1gqjtw71ta0kJuXQJSZz8nP6WKLw871NpcHYMLqWdXkgXnbV6tyqF6mcqI6zvpRai/K9ZgwAAjVs3TBPMMDye7SMarkbGxclA7kL+fBT2ZtQnIIHGGCscMQFz62OjxSRiHhetjPUjV0uU3S7eScfvY+UPgzgnEBpgMz1nucsZReiu3IWK7BN6NV4FfLNLwY8WcBmXfsWZFAG4NkCkD/kaPVV4yyVlLM5aQyIjTrVgKvbIKCkxXOejYcYK/tgEkO4ECuHyf0+Sao4hzr3/AT0pX5JJSIHkFSxEaFXaDrWjDmbqvdMEv/sRGIUfS6rjra6jiha02VtaVnA7tbin9fQWnAGBO1tS79vsSav4eqSmsfqX2s0pduerZLxiQ74t41taNMDZAkMaYNvnJMto7ZdfIe8zrRs82zZxXyitOC9IgZWgeMJs1WPBqjRS8hG98fbxCqpl9rorUD0Aqoq1NE/HQeRoX61BzCgvZ016Ti6MgChqVkTlHb8SxSphC3fFWinRXmfHz5LJeZqpk1JVmwF7+A0REeKYR8Kt5MKfYOWMBVQXS6Hb5uLp81HcJxU3ykUWBGfEZw5LF1q6N94B5JafwuB1XXdRqK8+fxGwD4BDnlYZ1r7VJe9M7bXiUodUr0DX0dOT5oqzJjCliVNLve3lwJMwzWoKvNndXeZTXavoQAIFhLKtTkiP/ZmXHInXvw7Fxg+TkT9ZI4wQefbo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(38070700005)(2906002)(55016003)(921005)(83380400001)(122000001)(33656002)(71200400001)(38100700002)(8676002)(66476007)(76116006)(64756008)(66446008)(508600001)(66946007)(52536014)(316002)(6636002)(110136005)(86362001)(8936002)(6506007)(7696005)(66556008)(9686003)(5660300002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j2W9BEBY4K2hVEvGgx60lByQxk7D2IsXmrrH9rMVUBMLD2wPZ2sNlAf5ep5U?=
 =?us-ascii?Q?RVpe/tNwro9TpBa1grdgk7VET+QRWh32y+9sbpnyQotayRxu9CUX/rx26jwH?=
 =?us-ascii?Q?Tblpb1GZCQpFfNHBKmDZmHF6HotjRCO+ab3xz80GmDkc3vethlrTFTSd5jBR?=
 =?us-ascii?Q?0/NAc7hx1jAMobupAXuZiShA6wdlcNn6M90I9jjKNQuPwoSc+b2vPlLa0A+4?=
 =?us-ascii?Q?BdUTfk8CNofABYX9tKwLgyHWXcSQfu/eHIFYTQIUOPvEw0YLs/zpkt39onZo?=
 =?us-ascii?Q?r5B3rizC6KLuCbLaB+mY0viXYNG2TX/rSnCphcNfG0g29Fk7LEYDPVUkTrGB?=
 =?us-ascii?Q?HbyuvUm+1BVISgXF11U50lX+EC5ROtxsXTQLCIYauaOfmVhEx/oCWhgNvo5C?=
 =?us-ascii?Q?yIF403zvPPfYYiq65TMFPHVIex7Q4ThzWrqVflaFu6RxoxapU8Z/WJ833dTw?=
 =?us-ascii?Q?0gPJzjbmS6/g8kq2E18pL4sCSWX26jjcSINZ9+jcqVI08D5lVDl31ExO6she?=
 =?us-ascii?Q?7EQcLaVlzJ4vZKA68KBgPUOnZFe18BEXKXxYOIVM0Z/gyl1nfgqBzcXI7Wa6?=
 =?us-ascii?Q?S6yGcg+IQZYoUI2z2LQybjkKWwX3h79zXCF9zj820bhImgDWCAa1kIMqa3eH?=
 =?us-ascii?Q?XLIDCToecnPszlPKFdJAS2p4Kcj1Jjz0149Hx9Z/NLgww7f557kwjbeldsCx?=
 =?us-ascii?Q?Hgv/KuPzjshe2TeBfmMjP6u4hSZGOhnzVZmKaFJjAY6CMFi0rFIK3ZGGFpFQ?=
 =?us-ascii?Q?UX4Bibv6QPIBf8bmmgoMVEXPSYBZYH+rovcgckzStqnPo89UlQj5DbXv/ckr?=
 =?us-ascii?Q?WPHt6MWcMHSKqaXakTAuOwHdRThQIaSGvDUVtXAihwpvoWAnDuQiYpMi/k7M?=
 =?us-ascii?Q?Ap0o9PWLHjvB2pNg54SptnQvpd00tz+CbpnzmaR8ZRXmhmbUyy+32k6GCfeU?=
 =?us-ascii?Q?WiOi2ty9WYOdTWA8S/OC//lHIsLeE8zzwSKUSqWE1dLd+wgvbPKotIwES675?=
 =?us-ascii?Q?EPQ4+bDDHFvBkXQ1Jj/8LprnUE0LzSFvXxWalXclU+b5imCwfDInIIdolRtL?=
 =?us-ascii?Q?41lo9rJmw3wdmaFWcapwQt1jeckob4mKlfxmnFpW4rJO+R5ShRaUze40aqbm?=
 =?us-ascii?Q?hIzQ0im/5N9VexLBmYiYpVcNDOmepd1cRsYqorLRdV+EG/RsasMALkioYKG9?=
 =?us-ascii?Q?z5oHBjbzuT6/V6qNzM7YO6BiG3m5Efp+z6N337AuiprcTX/QA9vijad30+v7?=
 =?us-ascii?Q?ahFtNoNlejFnhp0msoN91ZTxmnfUHJJ7LYXyWBHxP/DIt243cHDlVi8P0G1i?=
 =?us-ascii?Q?Yofo1+ztrPKQrgVMEWatzBkp4j94FlJmcKIRqQZ76k9Y2AgKGHBmBTRvhwuq?=
 =?us-ascii?Q?vcsCSu7QjEcxN5On/b+GWcYlcx9NWClgH3AqBkMZZ8iA+a9IR07ORQ7eCPi+?=
 =?us-ascii?Q?EAKugC37btwpXcbyu980pz7QjTsh1XwXmSPupvk2QArQvXcvlyd41VU2VQNV?=
 =?us-ascii?Q?0xmKg/qv1K0JVCRGVwz8mRzfI8GeeU+f2rlclGM/7qlbzgPf3dUdfTJXUabA?=
 =?us-ascii?Q?OtRE2PwSy+aIAPRVkC0I2KWpO5SnpEpAQTbt8mnNGP/qrnFdflRAqhMQ1pP9?=
 =?us-ascii?Q?+TcdC+iAeuzqtqVbdHtZdQ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcc4797-5995-4c6d-4660-08d9ed6b1731
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 14:30:45.4150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9EYm3vTCO5ziGI7jGIcO3yXI0sGK0rAxep7lcx+9nqmC1Zz21AgN7lzQ2Q1b6OWm1sJ/FWHbwqdH+kY0g+GPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2997
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

[AMD Official Use Only]

Reviewed-by: Victor Skvortsov <Victor.Skvortsov@amd.com>

Thanks,
Victor

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Friday, February 11, 2022 1:42 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhou=
, Peng Ju <PengJu.Zhou@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>; Deucher, Alexander <Alexander.Deucher@amd.com>; Skvortsov, Victor <Vict=
or.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Friday, February 11, 2022 13:39
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou, Peng Ju <PengJu.Zhou@amd.com>; Koenig, Christian <Christian.Koenig@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Skvortsov, Victor <=
Victor.Skvortsov@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case

rlcg legacy read is not available in SRIOV configration.
Otherwise, gmc_v9_0_flush_gpu_tlb will always complain timeout and finally =
breaks driver load.

v2: bypass read in amdgpu_virt_get_rlcg_reg_access_flag (from Victor)

Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx=
9")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..6668d7fa89e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -836,7 +836,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct=
 amdgpu_device *adev,
 		/* only in new version, AMDGPU_REGS_NO_KIQ and
 		 * AMDGPU_REGS_RLC are enabled simultaneously */
 		} else if ((acc_flags & AMDGPU_REGS_RLC) &&
-			   !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
+				!(acc_flags & AMDGPU_REGS_NO_KIQ) && write) {
 			*rlcg_flag =3D AMDGPU_RLCG_GC_WRITE_LEGACY;
 			ret =3D true;
 		}
@@ -940,7 +940,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	u32 rlcg_flag;
=20
 	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rl=
cg_flag)) {
+		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true,=20
+&rlcg_flag)) {
 		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag);
 		return;
 	}
@@ -957,7 +957,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	u32 rlcg_flag;
=20
 	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &r=
lcg_flag))
+		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false,=20
+&rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
=20
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
--
2.17.1
