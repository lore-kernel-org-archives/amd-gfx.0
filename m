Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8D8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 06:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE1710E160;
	Fri, 14 Jan 2022 06:12:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF7610E160
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 06:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AROJVHATLuyqHpsTd2ytiRTaBv3LoJRxmAoWZ3ELBnWYXgeBGlfqZi7IXtnRt/l+GCsB6yik5NwDRQXNVCEvBX8rRIScP5jd4L309UIMRKTO7n8wolkCnMGp1KUJ0o9qkSd8zMcHCQDbYURemwear2YGkswY5qe1683Vmj9WHpjpuVnXgglRUXPgNsf33VVmzeZaVaQfCrxw6SFKvrXwHlcz+bWIAGA+FzjYQMEF1Hl1NQXoK3KBFf+EQFG2rGRWEmolMpw6oSqGaidzsxnJwaMOxBaUG1mJ1wIxDYCCryNeOGxYbU+6qDNo6CCsBA1TmOa+miZtsKwN+FgV4u2I/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3fvztzvGMrsbDkRj3hcAclDhqVjYyZntUWvq8m/39M=;
 b=gfyiMkTkh15/92vTU6KwjLGYFq59JIJGI2W+PtPsLmjamyae7Hy4kmEYeFeKnMUzqRkJApqj3rDfj5M7DJoZUmR3dE29glBSGIxyMcF0K6n/9VNs6hi4Q16nZccNwsiZa5khaPufsE8fa0fLf+uiqJXcSOMQzLmK7wozIL+wd1298mNY56/82nSM1txSHa14BsuWv/a+/M6qUfTFadu9riHKU4mWfz0M9nnr1B8C1Kf3pvsaiBmU7MoiPBr1E56fPmq4FHlIOsqULYLZYTQTbpbEesGwh4aQ9Wy7FtiWeN5RUjP7We5Xw2KhuaClzjw730qtmOlVqe/VPZ2f6pb9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3fvztzvGMrsbDkRj3hcAclDhqVjYyZntUWvq8m/39M=;
 b=PBRZfleKySFmOwMNVtEhOSivqjjYaO6xIB5e3nr9+ynD23aZ7lUIESSPRISo2AZnmJY2ugWIXnnthdUoDGF1q0KdVMyCUGW+h7yWE87SKDs/Btt3OY8dlSrW0Wu/V8YapXT6NhYjUY4cu4EHdpem3N9rDnrzwMMBRqzIA7skWQA=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 06:12:01 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::d145:f774:db68:558]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::d145:f774:db68:558%8]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 06:12:01 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH v3] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV
Thread-Topic: [PATCH v3] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV
Thread-Index: AQHYCPyGtwbvGHXWzUu/cVQzks/FJ6xiB+wg
Date: Fri, 14 Jan 2022 06:12:00 +0000
Message-ID: <BN9PR12MB5324F5AC52321455FFE030248B549@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20220114040850.113575-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20220114040850.113575-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-14T06:11:59Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bb086abd-732f-4df8-9919-21b4fb68d24d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-14T06:11:59Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 09550187-eea8-40d2-a029-f33ce826345d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34220abb-842d-4eba-1fda-08d9d724c72e
x-ms-traffictypediagnostic: DM6PR12MB4282:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4282648809C55BF33B721D788B549@DM6PR12MB4282.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lesO1jFXvYIobwcFp4xj/b9W4qeaxmS4aGD4zlCQa/bkthVa1qZfIhSMpoTDjIWwsszbEwYIZrCO+qDny29iDsxQE5KLWPF6OacqkZU9kRSM5IjedhTvoCl6Q1XRPy/I/CzRLWNkJkmH/1ifU4NkDn3+md+d3Qrk1HyMnQkQfXZm9RPLT6H9yhqOrb87LRb8FHD2R66Wl53DtatukTk6waeGiOmXGMExkNv7JtOuu95cfEdMS4M1IC4fcLtCSPUA035pRqr5xAlQfEUFlSHT9+aCo9vs35xGBTFLbm/tzxfNM4ZbW6RjTii/z4EEgKumi/TKSJUZ/CsuY6p8KPtS/zhqYz0diPMItHFbYDERObHbnxOuox7zoLDecPIZA7P0b1G1vLDOt4fXvFEcWyi9YcpWhcumyogxyhfmltW5UVns0Pm8ajnd+qmdqge1C2rhwQwkoTXnrkdtwJIrE0wc7WOjU7OvpIC2TCPygZCueahc8rhn3DlzLiI3YI1klI7dilD9rs1kmB2iS3WHb7Ug2+IjIEe8aah5Tygk2drVukoEiLyzmdOf6jU3eoi469/9zzICEqEIN2kTfsySNqz2sDStCuF/wj1/8pLtt5UfsLI6GO6qHFCGflkEYrx3MsIcqKN7uW+qHqkZZsDLoil2VTYRFWdbrzjjPeR1fp5EsmzKERfkndeq8YPf7CqOMmymd2smSysrin7zBND1+aD8DA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(71200400001)(38070700005)(83380400001)(26005)(508600001)(9686003)(2906002)(53546011)(76116006)(6506007)(7696005)(66946007)(38100700002)(186003)(66446008)(86362001)(52536014)(66476007)(8936002)(8676002)(316002)(122000001)(66556008)(6636002)(33656002)(4326008)(54906003)(110136005)(55016003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tpTwVRnDDiE61hL44NngX7i3z9u+npSCwmZh+2yKdnghqXG5i6rLx2Sr9wR7?=
 =?us-ascii?Q?O5A1V8pcSerPCU+NIvyOcYzM4z3pu44pQZAmQ/4EJy2+uQHv5qhshumjRrtQ?=
 =?us-ascii?Q?/4Xez+G1lNOIRmd+LaKaDHVVjY53up5aQa9zxOnQSxkfuUcqWCEaDOuAQXbE?=
 =?us-ascii?Q?l4OW+BWmdXeAMZGB+WCMjnso9dItf3m30MKmj+cp6nm6jCJlQIB3TJRvXGky?=
 =?us-ascii?Q?4S+EPLADnCrFFH4AUNqqKcim64yvHssiKIzbw3fA8BJPyB7Z62kj1o67ZLmW?=
 =?us-ascii?Q?nZ4Gj3m29W2L92dJ4xJ14QgEAZ6wiG3CvpC/T40QjnJnOMpX21dr9LlxKOOY?=
 =?us-ascii?Q?11T45e/jEzcKTWDC1NETM+lGElQ+G17yXkcGqtlcpWFy6KhBbQBEPLKL5GD+?=
 =?us-ascii?Q?lAoItdEXz3sDPndaJZeQFT8QzSNHxvMJHUvgc0OZxSmWbIkSICKr8weynIWt?=
 =?us-ascii?Q?6nnezRfDFQUvW24ZSA9SXdYFkehd7JkKS0vP2ty0yavDTKRWVwEQoIaod/0r?=
 =?us-ascii?Q?skFz+IRMXFZX8iq/T1FcEdqXLEz1G7h/cQJmB5jQb+XPmXEmy12oYKbsXyf4?=
 =?us-ascii?Q?6xdu2h7DLbh2dKSHNMfkkDXmrtaK1LPvZM8vzcTzsmY7x3vJV2Jf9QWEqrWq?=
 =?us-ascii?Q?TLmUqeY/bTTbRdfooP+UTxW8cR8Ej6E4gwdWN51zFX/iaA5vxapFOUHGXYo5?=
 =?us-ascii?Q?QX3Gxx+2WnLzWkj7Ra29zEd3K7xG4eYTJqbqgM1qyrjF0+8JswBSsIvlgPFT?=
 =?us-ascii?Q?bfLhM+OE8Yupnhd9n6l2CT0PqPKfNzaEDFaamQXxGvRrkxxK/hwOxEKPihn1?=
 =?us-ascii?Q?uy8dMaHE1OI1c3rJtt9OV8fslUeYDd5eJnIIzMPO1589lgLrUYDvYpTCNHG2?=
 =?us-ascii?Q?5n7BGNC6lSNY1QBS7Yh+VSHvHlAkXQ6RrNbTCtdfDCvfICnIdbXpGJm67hzj?=
 =?us-ascii?Q?XMUnMRz+vwBhBbLW7Sb+sDa2tv7eYccZi1zqI+jCisPI952wbzZgWPQfFi7N?=
 =?us-ascii?Q?WXKZOKIStWCRJwzPRXwIWxcF/N4K9fkI+2CWPunVfSm2dUm+ZRd3fWdNTn8+?=
 =?us-ascii?Q?kDqcCixrzsaQdu8MoAgoJtTXI59o9ug/4AaAAXPmhrg6jZXlb8bFOtG8wltL?=
 =?us-ascii?Q?FDV/0m3HW3QQ+y4QHn7V/HWSsi1ufrzC9wN6GHFIISXWMRGg5c/AQuVkos9U?=
 =?us-ascii?Q?BIR22yt/dP5RLrV8jRvSHwek9pqTkGO1q0oi4IszpwdAvrRfzSj74AQufcWE?=
 =?us-ascii?Q?YLtO+7qbgo66EUn/dilBk3lo4aV1il0NXNsfg4+Tk3SmB6/yymdRZe7NF1cr?=
 =?us-ascii?Q?+zBjOIgRs01vxdr1EGtiCVZxUybwjy9NanZZU7KCEsF3uPjaAs5Ldtn8M6Vh?=
 =?us-ascii?Q?qBjXpgnNDrcqE5frf4WOGpaXwu9t3sAwhJyUrA2XbB/1f1aExZqlino8vqmn?=
 =?us-ascii?Q?KXTFguK1qBT12DVeXuxEymE0VKlK3tSaW+1A6/kTswdeUAFf1LRDjhDUn9z1?=
 =?us-ascii?Q?H4BJ+ocRbFfSNrUe/azb6sRiDYBz8CCXx+R5+tzEMM33rSbZVvqJ5cEIA88m?=
 =?us-ascii?Q?zyqzqSBHElNh1fpaIWX+Xr7AyePH7d+4ueNZVM/9OfWcwB5we67s0Senk4xC?=
 =?us-ascii?Q?JaGZ9bECn7INwvmYZUt5fBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34220abb-842d-4eba-1fda-08d9d724c72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 06:12:00.8713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HwSdDkqAWFk7V12GIJDtYNkTOjULSMTRfXfoXoRusHnOId55zF/WCE8u+4ov9Ma0QPZaroLTDlMb2gmfWHbWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

+Shaoyun

-----Original Message-----
From: Chen, JingWen <JingWen.Chen2@amd.com>=20
Sent: Thursday, January 13, 2022 11:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Skvor=
tsov, Victor <Victor.Skvortsov@amd.com>; Chen, JingWen <JingWen.Chen2@amd.c=
om>
Subject: [PATCH v3] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV

[Why]
This fixes 35709bd76d229a51b0c571a768b741650ec47828.
we should read pf2vf data based at mman.fw_vram_usage_va after gmc sw_init.=
 patch 35709bd76 breaks this logic.

[How]
calling amdgpu_virt_exchange_data in amdgpu_virt_init_data_exchange to set =
the right base in the right sequence.

v2:
call amdgpu_virt_init_data_exchange after gmc sw_init to make data exchange=
 workqueue run

v3:
clean up the code logic

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index da3348fa7b0e..5610eae8ef0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2353,7 +2353,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device=
 *adev)
 	}
=20
 	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_exchange_data(adev);
+		amdgpu_virt_init_data_exchange(adev);
=20
 	r =3D amdgpu_ib_pool_init(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 894444ab0032..d83dfdc64d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -625,14 +625,16 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_dev=
ice *adev)
 	adev->virt.fw_reserve.p_vf2pf =3D NULL;
 	adev->virt.vf2pf_update_interval_ms =3D 0;
=20
-	if (adev->bios !=3D NULL) {
+	if (adev->mman.fw_vram_usage_va !=3D NULL) {
 		adev->virt.vf2pf_update_interval_ms =3D 2000;
-
+		amdgpu_virt_exchange_data(adev);
+	} else if (adev->bios !=3D NULL) {
 		adev->virt.fw_reserve.p_pf2vf =3D
 			(struct amd_sriov_msg_pf2vf_info_header *)
 			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
=20
 		amdgpu_virt_read_pf2vf_data(adev);
+		return;
 	}
=20
 	if (adev->virt.vf2pf_update_interval_ms !=3D 0) { @@ -674,12 +676,6 @@ vo=
id amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 				if (adev->virt.ras_init_done)
 					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
 			}
-	} else if (adev->bios !=3D NULL) {
-		adev->virt.fw_reserve.p_pf2vf =3D
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-
-		amdgpu_virt_read_pf2vf_data(adev);
 	}
 }
=20
--
2.30.2
