Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6139C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DC010E4E7;
	Mon, 19 Sep 2022 02:31:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6178410E4E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1YYo3U8q9c+o/COBxQf4+++3ewVfgGHIK0tMOYLyqhw70NmyDVmMR0ZSIL3ugWscyA2ntWkbjdFazCjG34YI3s8fthpiQJLF8dz8LoM5F2Qh0q+75xYSKjfflpxY8f7JojPNFhRyNOGG2kh1fGyqCppTaR0C2HKqZ1UyMgHb6NaY/OVG9998AGSRbde76lPWnuUzmUYZ1qDSBlIpl2v85S3KRWqvfLG87Y7ovIBTDWQnA9FwApV5amHZMR9qKzKp/EJGmpSKKGeKKo4lbfAuCdwDV6zWJoG/KMPU9/9GptXQB5dRsz7DGHqogFImmlZixIl4Il8PDHcq9prdp4GSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xQgDY5jwGghRdVmEhrHxgoCvtiYCXpc4T0NqYbZYS0=;
 b=KWtGtub+LJ/gjkyDy9+ZDZi1IGqoWi9I5MwHeCEnYQL5MYqCOAXk9AbSX01frouL5Ka34nFxR8SJ2OLD4w/kOpXtBN3JWf6l1KYOukqVsho9eDamrl0uMcg+xjM2dVISQELurL/7i4udPWDTXpWcoYsjfZmC1s7WFyHIx9IYft10gl0ZM0Ne4YrB2a19k33KqNLujaZLawzKTQlt3kBqElNSIF9VkFeE563aWYZ5if6NIs/hJ5fj+1PEVxle4hZZfJW+YJyuiU8NnwBjgLfkQw7gZbZ96adscjpFIsPvtDGSCPYRLJd6tRqWFEhJFmWSOCXG2xFnERacyT3/GCB1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xQgDY5jwGghRdVmEhrHxgoCvtiYCXpc4T0NqYbZYS0=;
 b=4v6Xf0FCClMu/b7trNTtTS3+JlZjYkz6p9xRvuDcly/+GNV87oPzsOQla4p7TBodAcy+qVyv1PQQBZMBC6X7QJGJSuGM+FRrc3kVbHM0cz7Ahw+OxueFXOL0MNYQHVnfzGsUVsqLTsZNDmGMWJSfH6NB6Y864Fkqlo5PSTUOszk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 02:31:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 02:31:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header v2_2
Thread-Topic: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header
 v2_2
Thread-Index: AQHYySTgGH0Dj4JL5k6ZiLrV+WyI4a3lcjaAgACbKYg=
Date: Mon, 19 Sep 2022 02:31:44 +0000
Message-ID: <BN9PR12MB525727347B70EE24DAD3EC51FC4D9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-4-Hawking.Zhang@amd.com>
 <PH7PR12MB59973981CF9C648188B60578824A9@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59973981CF9C648188B60578824A9@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-18T17:13:31.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7357:EE_
x-ms-office365-filtering-correlation-id: 74c07e6d-4d65-4591-55f2-08da99e71837
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OIZJ44hAJ2Y1aq5g9kpxkdWwzGSDWhEZxxRJSXruMv+g94eq6K1Msnc3Lz97b6UIRGQjV1QtUESWb7U0pqSQ60ZVxGhMPDmPE2xJ8GliyC9NUBb0YYCZkEltU3Kzw2zne4qFs0W2nxhyj4NDvL1Td1L/MxC+FXbSLmCI2ECOizofSNZ6AS1XY4ECOfhc0yw4OfHPPJcfwtJ5xLELKPJEt2zzw4kbXcg5pOjza7RYzrg70bE06SnY1MpKSgVoahjPYkJ9u5LP3SzU7KrC4XGMWnWLyU/gZ7eU75rkCM76NoCQQRinEcY4iloS3XfAq2iXBdRG+qLX0fiTPUobWj0aq/tkoiuTqPHsRNKlIwJznYp8VWmWj1BZ5UB0emci8P6Gv0eOKmyJ3P/nv69YHDQyCPQZNnrmACbC3d2TDrx6UzWuQ/a8NJn+3Ha8PJvRlHRg3mxHb4d1nwgIrYDJseaq1Cwc/pZU6RSwC+5yU8Hp+TpXnrANskBksm4tbgKxPcx5ln1aG+Jb1OmILGPH8gd8PMBeIyIIyQa4QWCVFgqgOfvHLGLxlVHUvPxYl3Iom98KsOx63CmB3QWGEzgAWmav7Kchbn3WN2xz2HMdOdxEZSDfO4Mo7Js64Mz+6P7QXPL1dkdr9erqktACDqvex5M//dYhnvbuL/gINi1LmHLFcJldb2r3N04hd5Nsxuzc4RouNMaoxrdX9+XgwLcoyPdIbiIJ93/k7UX1Io3G2g6VBwehMwSRoY/Xt4rcvXSZZIXMTUTSpc0BDJX89HN5Zx5J+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(38100700002)(122000001)(38070700005)(33656002)(86362001)(186003)(5660300002)(8936002)(2906002)(26005)(9686003)(53546011)(7696005)(83380400001)(6506007)(64756008)(66476007)(66446008)(8676002)(41300700001)(76116006)(66946007)(71200400001)(52536014)(91956017)(55016003)(66556008)(478600001)(6636002)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FzIT93vSF50572ExWhUMR20tar5Cyobclq0/DGvQOtQ5PmGbkTAK/jyahERm?=
 =?us-ascii?Q?gduDN7Jzdd08IiqZQih2e7kFF71Gbhf5mCdaI6jl632vboC7R/cQYBqadykZ?=
 =?us-ascii?Q?s4gLdGjhB/rHJCm/MaIydk7VVhICZQWqvdQB7Bjadt9vKZkt0SFfqOgoxoor?=
 =?us-ascii?Q?2pkO+B9qgvIawAdCLIBfc4h7H58t7ukLu4afoH0GLMTCam3VK43pBFjkm829?=
 =?us-ascii?Q?pizPPVBxlaARLDOV0oV4diuy1fD5tyrS1rtzGMA32wvKzl/cba6YiJ8QEM1i?=
 =?us-ascii?Q?1bTr3cCQbCPeC0oIKgOU0W8jn25R/NPyoXDj+6gZK925OLfDSdWA8HYSS6cF?=
 =?us-ascii?Q?lFDqm6Uj4T42EqJ2XO7E1iyuo0JdU6J05Ww2vSF0PYbvvDDgUBeW2WPODpNa?=
 =?us-ascii?Q?j3LQO3Amub4J/sXlz4si0yLUBKLOxuBsEKiILtXWIsxljpx9n5aGAEA83TDw?=
 =?us-ascii?Q?/ZNhCG5JL5gQ9NXMwMtfa3XPg0DMjlq9io9eOb77pRX5TtE5gL/cw2ImnQl1?=
 =?us-ascii?Q?5iLr9Ao6MD9jYjgik0lFHQDKf/HMH4Y3iCdwd1X4E/2wERiivAhRRr1QiHnZ?=
 =?us-ascii?Q?W7HGqVhmmIfvPhTwyjxom410H4STCxkCJtme2fApSR0KukxCAbPC9z2QFtU+?=
 =?us-ascii?Q?R1Lfq69x01xt40ZCtqwjzdQEsrP761KICJmVoFm199kOHrgWuQRJyL0pNQYH?=
 =?us-ascii?Q?WpNlgCUtl8hixTZYR09l5xaSg9aHiuRS/VSf8VcmfJEF+dZQ6aiT3yralmMb?=
 =?us-ascii?Q?BGEr7O52agZ2iE0YTzT+Q8O0Izj5vnDGXgRSYw2Zs1lyZjr0TYByGKpOONz0?=
 =?us-ascii?Q?kTttUf029McyCZWGfTCSa4VV6UafiM9dvjlH0r44ZKoyy6TrAHos3Fim7VxB?=
 =?us-ascii?Q?uMJpv0+QnB+FeqTj16jFQhjHxeONcpkRsgjHdjU8QKWxpl+LSvWiLHx9W309?=
 =?us-ascii?Q?UlP8cNl4qjoZFDFdsrXe9NRl2ayjmd3uXyUME2EpcMdUdg1A28zEDHxeZkgj?=
 =?us-ascii?Q?y7ylcCGohCaWslQ/Y6FpyjbgUCJt9qkkmT9HSMgUWMGMCu2qLJD2TA5PcJX2?=
 =?us-ascii?Q?SZ0ZtlHXueXiHKnH/sPuTgX0/+7o59edrBJ95AddrhZbUcWix6f9cLT4WKYK?=
 =?us-ascii?Q?/TWkKp1x0z9rpX3iYEKlr0G0ZCN123pEE3pD6NVyjRBuX8Yu+6REZ6WCNj68?=
 =?us-ascii?Q?byzVjuEgiD2/Pxud6ixXlQ9E8YcraLqpsqQCsIaoPp20xxUyo/AY7Hk4VYFy?=
 =?us-ascii?Q?vagjl5x659ftiQCzAuZSUqhqvoFadPAxXrVTrUhyE76racyy3RnxgiPZEXch?=
 =?us-ascii?Q?Ag+MRTV8n0HiV/Abg4wFOmNIwR9DwYlU72gHMSAmiiPiXKiO2CYylR0O9K39?=
 =?us-ascii?Q?XVnqr3dquEfNpXjbOMZmc/N8DDg9g6fo7vwl+iRovKD4W6kpG6SxqGposK8d?=
 =?us-ascii?Q?GuwV7Q/oiXv6wPJU2PHJym9iI+BKPOv9jSj968ncdT+tIP9u19fPLDtsCp5Z?=
 =?us-ascii?Q?f/WfhoBKJeLcy+MVYi+PIT+93bx/BBvJ6yT5k4D9nhyXH3FbY6ys+sBGwtJv?=
 =?us-ascii?Q?YBCDBj5sWIrxK9TFYhb36vDSu5vdKhqnjmYaqYrrfFGcvTe3EzG7sZs5HxCa?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525727347B70EE24DAD3EC51FC4D9BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c07e6d-4d65-4591-55f2-08da99e71837
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 02:31:44.8965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwqJ/kXE1fkk2jVeLo7eFw042Gagjzo/MOGN9YuPq6AZkswSxxLIMp8IwC8PcJxB0eBvQjush38IdWiwGbd5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

--_000_BN9PR12MB525727347B70EE24DAD3EC51FC4D9BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

[Kevin]:
according to code logic in above, the following code is not needed to conve=
rt again.
ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_dram_ucode_size_bytes), PAGE_SIZE);

Good catch. will make the change when push the code.

Regards,
Hawking

From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Date: Monday, September 19, 2022 at 01:15
To: Zhang, Hawking <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>, Gao, Likun <Likun.Gao@amd.com>, Deucher, Al=
exander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header =
v2_2
[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Friday, September 16, 2022 1:01 AM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header v2_2

To initialize rlc firmware in header v2_2

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.c
index 04bdb885918d..a055818d87f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -376,3 +376,33 @@ static void amdgpu_gfx_rlc_init_microcode_v2_1(struct =
amdgpu_device *adev)
                }
        }
 }
+
+static void amdgpu_gfx_rlc_init_microcode_v2_2(struct amdgpu_device
+*adev) {
+       const struct rlc_firmware_header_v2_2 *rlc_hdr;
+       struct amdgpu_firmware_info *info;
+
+       rlc_hdr =3D (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_=
fw->data;
+       adev->gfx.rlc.rlc_iram_ucode_size_bytes =3D le32_to_cpu(rlc_hdr->rl=
c_iram_ucode_size_bytes);
+       adev->gfx.rlc.rlc_iram_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hd=
r->rlc_iram_ucode_offset_bytes);
+       adev->gfx.rlc.rlc_dram_ucode_size_bytes =3D le32_to_cpu(rlc_hdr->rl=
c_dram_ucode_size_bytes);
+       adev->gfx.rlc.rlc_dram_ucode =3D (u8 *)rlc_hdr +
+le32_to_cpu(rlc_hdr->rlc_dram_ucode_offset_bytes);
+
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               if (adev->gfx.rlc.rlc_iram_ucode_size_bytes) {
+                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
IRAM];
+                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_IRAM;
+                       info->fw =3D adev->gfx.rlc_fw;
+                       adev->firmware.fw_size +=3D
+                               ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_iram_uc=
ode_size_bytes), PAGE_SIZE);
+               }
+
+               if (adev->gfx.rlc.rlc_dram_ucode_size_bytes) {
+                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
DRAM];
+                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_DRAM;
+                       info->fw =3D adev->gfx.rlc_fw;
+                       adev->firmware.fw_size +=3D
+                               ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_dram_uc=
ode_size_bytes), PAGE_SIZE);
+               }
+       }

[Kevin]:
according to code logic in above, the following code is not needed to conve=
rt again.
ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_dram_ucode_size_bytes), PAGE_SIZE);

Best Regards,
Kevin
+}
--
2.17.1

--_000_BN9PR12MB525727347B70EE24DAD3EC51FC4D9BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ti=
mes New Roman&quot;,serif">[Kevin]:<br>
according to code logic in above, the following code is not needed to conve=
rt again.<br>
ALIGN(le32_to_cpu(adev-&gt;gfx.rlc.rlc_dram_ucode_size_bytes), PAGE_SIZE);<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ti=
mes New Roman&quot;,serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Good catch. will ma=
ke the change when push the code.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking</span><span style=3D"font-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Wang, Yang(Kevin) &=
lt;KevinYang.Wang@amd.com&gt;<br>
<b>Date: </b>Monday, September 19, 2022 at 01:15<br>
<b>To: </b>Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;, Gao, Likun &lt;Likun.Gao=
@amd.com&gt;, Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc: </b>Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in =
header v2_2<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">[AMD Official Use Only - General]<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ha=
wking Zhang<br>
Sent: Friday, September 16, 2022 1:01 AM<br>
To: amd-gfx@lists.freedesktop.org; Gao, Likun &lt;Likun.Gao@amd.com&gt;; De=
ucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
Subject: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header v2_2=
<br>
<br>
To initialize rlc firmware in header v2_2<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 30 ++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 30 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.c<br>
index 04bdb885918d..a055818d87f7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c<br>
@@ -376,3 +376,33 @@ static void amdgpu_gfx_rlc_init_microcode_v2_1(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
+<br>
+static void amdgpu_gfx_rlc_init_microcode_v2_2(struct amdgpu_device<br>
+*adev) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_v2_2=
 *rlc_hdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_info *info;<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmwar=
e_header_v2_2 *)adev-&gt;gfx.rlc_fw-&gt;data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_iram_ucode_size_=
bytes =3D le32_to_cpu(rlc_hdr-&gt;rlc_iram_ucode_size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_iram_ucode =3D (=
u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;rlc_iram_ucode_offset_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_dram_ucode_size_=
bytes =3D le32_to_cpu(rlc_hdr-&gt;rlc_dram_ucode_size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_dram_ucode =3D (=
u8 *)rlc_hdr +<br>
+le32_to_cpu(rlc_hdr-&gt;rlc_dram_ucode_offset_bytes);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=
=3D AMDGPU_FW_LOAD_PSP) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.rlc_iram_ucode_size_bytes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_IRAM];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_RLC_IRAM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(adev-&gt;gfx.rlc.rlc_iram=
_ucode_size_bytes), PAGE_SIZE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.rlc_dram_ucode_size_bytes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_DRAM];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_RLC_DRAM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(adev-&gt;gfx.rlc.rlc_dram=
_ucode_size_bytes), PAGE_SIZE);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
[Kevin]:<br>
according to code logic in above, the following code is not needed to conve=
rt again.<br>
ALIGN(le32_to_cpu(adev-&gt;gfx.rlc.rlc_dram_ucode_size_bytes), PAGE_SIZE);<=
br>
<br>
Best Regards,<br>
Kevin<br>
+}<br>
--<br>
2.17.1</span><span style=3D"font-size:12.0pt;font-family:&quot;Times New Ro=
man&quot;,serif"><o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB525727347B70EE24DAD3EC51FC4D9BN9PR12MB5257namp_--
