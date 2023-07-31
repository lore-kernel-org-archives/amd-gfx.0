Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72FC001DE
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 10:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF2310E258;
	Mon, 31 Jul 2023 10:06:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8127010E24A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 10:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nsbgh5SmO3524OULtXVbMy/TiHBrfXsPhiBmSOTLjBaYVY2C12v6/h0p8dfvca0xI8IVDss71VgJtiX3EtXzG9KxRPcVvN18CAysSRAv/3UvNBwVxDjtVoeeqkA6F2xi/RoEHH0tIvJrBrE+MFdbZhgIvelS6CGhAvVkRJO2yEMjedx6Yh+OEYro5bxOWMWYODmTTgOPBFUKkoyHLcJKUjCPIdlEUisZaar/bcFyQf0H0UaH1i1Jkg5dpBZZMw9+QMkxBjs9yfBO4BzyJLvEF2pUXhgFojTUMvHfv7BRgA3+T3x0IgDVnqiNOKW/+DPkhyJTDnUtdnRiJmPACXt+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAHNv7Kf6fU08wnC9QcVOoIjrsrIVTWTOKkMxGPrvFE=;
 b=R9lQaPzB5lRdArL70hr4zdOhY+SuBTnMiA1k+wqjkmIOCTQaXChUOELmyAyaue1YbiG49X1oujUOfFzX7SRrHRi2CWigUOXt/OrcvyrH1XUyK07bZTUu9a20JyK3P2EAn69KyISArqe670ffDCK1kCmLMIrUH5GRzxsn+WQ/Ji0vwwKjskz2iQwQLKcgKuKKHhwxAyIC2ZrBnFgYbnZX2r589X+BscqBXl96senKRgoqKtt8329B4iCEW8cLPkHyAxA2e7FKu3RMTqSy5a97pvVnurSNKrD/56kL8hg0kocNn8K0Psj/jM/RSOGCqvwCTGqvQEQrmYOSmxRmz+mIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAHNv7Kf6fU08wnC9QcVOoIjrsrIVTWTOKkMxGPrvFE=;
 b=L7L9hFGHEDHF9Jk+8+U6beNRqbX+rGV+escEEB5gFz7+GACjomcD639rbcZizqd4MqaLz04cLuWHHmFLXQgEc9Dfws1sABVDBXRu+l9BTYftIRANrPL7BzjnRRhTJhP6QavsmMaYzseL8wHvW+IHsdZ6MOIRYlSKmKlAFu2mZd0=
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 10:06:44 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::c959:7faa:f37:2f9e]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::c959:7faa:f37:2f9e%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 10:06:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: GC_9.4.3 requires at least 280MB TMR
Thread-Topic: [PATCH] drm/amdgpu: GC_9.4.3 requires at least 280MB TMR
Thread-Index: AQHZw1+7PhJKhwHDqEKznQIArILxLq/Tpcog
Date: Mon, 31 Jul 2023 10:06:43 +0000
Message-ID: <SN6PR12MB462127C6F9137BB7C38ECFA69705A@SN6PR12MB4621.namprd12.prod.outlook.com>
References: <20230731033213.3128180-1-Amber.Lin@amd.com>
In-Reply-To: <20230731033213.3128180-1-Amber.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=75589e9f-2cf0-4ad8-9b9d-49f62a29a0c4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-31T10:03:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB4621:EE_|LV2PR12MB5896:EE_
x-ms-office365-filtering-correlation-id: c5b236f4-c985-4b3e-af12-08db91add7c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tEBcJEzuXTyC8oltLQz95zVQ42Ru/8LNHB+drk67U4JVh/j8w/19GQvEWpvheb6s5+9uRN5WSJ2bRzQVHg3dCPJ6hh63N6RKx36A3jOIUFsBKNPrcoHOz+7YjZ6uDepFBZz6lk5TH1rfiG+78ESWnwUNbo8Z3QDygI/173aqgsdJCaQ0x3uazZymMCrHvOjIrQXCEd5ge10t9WhdMM/AZxxgSCLRg3/WR1EpjTyIFfPTtQZ6ZDlVlhIxDxOk3Eurhr7EjZ/p053WwYCiDT8tE4pFJElp/ZkRYbTPDQWdTAU1BXYsZYA0iNaXP3qr4ge3iEQOsWvLjbNHOyBZcEF+afISyjjKp84a+T7grtB1QPJYHaX/xaO/g2V6ZP3C/acsfrbC/nJPa5CPQH/pbB89znNpkCafc+fwp04YKQZvOljID+0ShwqcI2Tgx+2uUzkrFpgn92ALv+84o6Rhhjxh3fW3+1RKmGLUllJ2lBBHFs0Jsr8ErZDFl2EndLGNiUfx05ZU7KmtmDNaveMKocB60SmH9CjInaelrVDPZVVq9Q46U8vBJCWpbItYP8rLt7oytyEravY/bnf89Y0vawqGB4d8ED1ZiMWSIQq4K22M1q1EFna/J+Zc87ky/v+G8ygd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(9686003)(7696005)(55016003)(53546011)(6506007)(83380400001)(186003)(33656002)(76116006)(66946007)(66556008)(52536014)(38070700005)(122000001)(110136005)(86362001)(66476007)(316002)(4326008)(64756008)(66446008)(5660300002)(8676002)(8936002)(41300700001)(38100700002)(2906002)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i3qDvgehOx4lkF7uahoxvMd/CDHCR5P++hf6lzpiu4pMUW4NB4yrI/S/TmnD?=
 =?us-ascii?Q?PTLEnyLE8lwHwSO14BVZsEIP4lbJKz39X/kAP08H9FVGK3fxpQ90knnWOS0A?=
 =?us-ascii?Q?WfRD0M4gcaHewQLYzZa2XEVZMzWJMX4Yi2tXCDrV7lZhNx1ygx/KPJCkygYx?=
 =?us-ascii?Q?tbXUb9VxXpwvzSWYK4MmBaonb8rUJLajGLKlsABkpGm4AHRcLU5xDKWkXmzh?=
 =?us-ascii?Q?AxH0o3f+iJrBP9zggQlQFNSqlTuLXJQMC5Z6lQ8RyeNKqAiUwacl3kn40Tb7?=
 =?us-ascii?Q?3ltKDx46yuWgkz5wOEpZ3GrnFFTI8SRxpEILJpVxe+pYol449kFYxOw7U8sq?=
 =?us-ascii?Q?IsFTenqXln5DCCKVUU0+svNECepVhEl7ktRBHsp5HKkY+yyEYHE8sGfJns4F?=
 =?us-ascii?Q?JuxRyedlnMAA8vvU2Q17a1pnz7l5yD3ibseUEtKl2BEyKzPTvJBXeeCUQdCR?=
 =?us-ascii?Q?HXMvmtsB4BUt9cNUaPGDHps9XdjmZKGqfoxbD3kVi5pPTF9zACOTiujAJdA0?=
 =?us-ascii?Q?vgRU4n4VD8Rfcv2RJZVTaHhyfJp4CSh5IdECbkCcXujEgsiuHnCZNp1b1j4A?=
 =?us-ascii?Q?BG4a/MMnUgRUDMwSGS1wdTQtrVfmJsj97Quy8ZpZgmC0iqLeVtyhZSv6kJMc?=
 =?us-ascii?Q?NSZ/Bzuvc6j5Hxo4beUnchOlmy+HvoLwcomxhd2bUuDgqD54A0vXkKeajaDX?=
 =?us-ascii?Q?6z2VpSb1dC/WVf3r8625tG+3aTF4VwsYCQs7tYvxHNNCWBHNihpD2TXVdyQU?=
 =?us-ascii?Q?D0ZGgKtw/un5m+V1xl+J5Nx5Z7GIao6ufk0EOTULPPbmNoJgzr9z7W1dJ/ES?=
 =?us-ascii?Q?nlmjtSPGheZJwqlSP9hpvtCT/Xyda6vZL0WhC97TePEiBoerMMxTE2AdzpkH?=
 =?us-ascii?Q?mkJLdpLO6m+anVDuAtCfGXE86cjdRIbjeebCnIevaiSCMHjHsbP0WnfaP3+l?=
 =?us-ascii?Q?Qb/C0SIviOhFjC3XyPnNZ6GqsFZF7B2YBjVQV6U2lKP+F908bxDKZcndO7YF?=
 =?us-ascii?Q?Viegxkj15JapNVq4ArtAeLIK1z562QaH8arIjgBY29pSE63bKmpf82uhEjBn?=
 =?us-ascii?Q?Hy0lSxpsAGqTo9jC1V+1HZK+zbJP6FPqiR/DK/ytyhEPQTRveMJdHZiHwcxr?=
 =?us-ascii?Q?YlDNal16q8UiBysT+i9/dhb6dzc84Rsj0cUhKOnRB43CMTBkm3CShv1AEMXU?=
 =?us-ascii?Q?tnI2wiHFT+oKDRpDokjcYRyS50y+WIBqBchSGIrOf9pHk+XpV5cN332adMRD?=
 =?us-ascii?Q?ivL3oIzlbnkX+Y4RzcQ8cRGkmqHAfTVULB+OWScr1hNOyH2oqJnHE4l2sJ46?=
 =?us-ascii?Q?8ZrLL6Qkb+vvLZcj1crGxwmx7RkuzjgcekzI+yzUnI/vokf97POIE4BjkBL/?=
 =?us-ascii?Q?EUdkqebXamsN2cjFdREzsBVagXUEqqfA8gtugQApgO+JvYAClhvpktvJFDFL?=
 =?us-ascii?Q?ixIWPysPCHXa7Yxu/CShubGdSGDCDG2TvtYecRbW1DvR/iWM9n/ryomcxZVq?=
 =?us-ascii?Q?Jn98qwNeCdPpIdVJGS9ZX5O3XrdbAvjL/gCPYgD1H3mMFEUYIlQvCquxXQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b236f4-c985-4b3e-af12-08db91add7c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 10:06:43.8373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6w582ds7Bw798tJyCrI5774C9ANdNw1bbvvF9tAU4rHOabqMpT/DZuqifZq7HKG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

If BIOS is present, it's supposed to fetch a non-zero reserve size and it s=
houldn't fall into if (!reserve_size) path.

        if (adev->bios)
                reserve_size =3D
                        amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);

 If the reserve size is zero, then is a BIOS bug. The check should remain.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Amber Li=
n
Sent: Monday, July 31, 2023 9:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lin, Amber <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: GC_9.4.3 requires at least 280MB TMR

On GC_9.4.3, if atombios reports TMR size less than 280MB, firmware area wi=
ll be overwritten by driver or user application use. Remove !adev->bios con=
dition since reserve_size is initialized as 0, it'll fail into else if (!re=
serve_size) condition.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 7c6dd3de1867..fa5721b3139c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1718,7 +1718,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_devic=
e *adev)
                reserve_size =3D
                        amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);

-       if (!adev->bios && adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(=
9, 4, 3))
+       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))
                reserve_size =3D max(reserve_size, (uint32_t)280 << 20);
        else if (!reserve_size)
                reserve_size =3D DISCOVERY_TMR_OFFSET;
--
2.25.1

