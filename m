Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2355C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 08:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351D210E1C4;
	Thu, 13 Mar 2025 08:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MCQ/e1/V";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD7E10E1C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 08:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkTtiOi1hkXtqxpv6k3q9U1wXhe42ghBGcNmhkZQMSAI8gKIzTSXQK6Q1j4g9hX+HQ7y6REr8PbvX9Pi4nYNySS6Yc/jBKzZea36AVNHk3SUZEJHpmrhPAhXd+mJCVQzour/Ta3dwwdc3Qwjm5IjZJc8EY9QB6AqKGUTyVQQx+ZXd1ZxYpCx0m3Vo011ELXH8PgcBsSYl9gR+1sNr4qn32a0Dkf+F0wrjTZLYzWZXD0SR+Tl5Hat3H7dFXqrgMF6dnvaFhwRvywxiMIAFi+cmzAhAvGXUK8cy6iQP+6SQ5QdiMHrPIvNL/L0T6ZpPcg3bMHy1B+ZrpWL6j+Vu3fbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTVlZQ/o5g2ppmsf5wYvpC70MvRmw96DICe/EGhou+U=;
 b=VUmTbVDb8UTp7i+u0QJ22l/Hkeo0otZwBvue+oa9lA86TbPAPhwkj0FpLdnnAQbtUl+jpKZaoDIrkJF827i7Y1k+apw/Eb0O2GveOrerhQlbSz/pYyUXkNUn0ZhOb07BfRKQ/KghLWiuwKZShh3gmgQUzPXnCXM+Z1EnlTHHf9mJdgGfeTAC13DuXrxlBnc0bAESe4+k/5Kq6TdqJJrYRfph31Fu954W4mxNo9dZCspXg7Yw61nvyg95CbMfieAAs5Q9VRYbsBe6C92qVlQQGj0TIrvEQDofDO/eVb6HZtiUsrDQSlu//6MFsvvppt+GI/pzcz9wM2nGsrt/pdIIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTVlZQ/o5g2ppmsf5wYvpC70MvRmw96DICe/EGhou+U=;
 b=MCQ/e1/VSyLLDqQhTHMLG2Acn2yLp+7y/j+7ZyX3PSVNIC/6Pe8+F8kX34bFNAt7qaK0BVFDzFtYT/LgjrnF6moAWhGHBxEcx159KWKaUl5H/KIvRi9SdNIUuWY2x/XzhpQCpvscPyYkwLJ1UMatQzq7dp+QI7+h7JzXMBba7GA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 08:08:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:08:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable ACA by default for psp v13_0_6/v13_0_14
Thread-Topic: [PATCH] drm/amdgpu: Enable ACA by default for psp
 v13_0_6/v13_0_14
Thread-Index: AQHbk+fxD0e+zaeoiEi4EMs//gSfHLNwtlUQ
Date: Thu, 13 Mar 2025 08:08:35 +0000
Message-ID: <BN9PR12MB52578F156A3C88BFB798D986FCD32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250313071652.466718-1-xiang.liu@amd.com>
In-Reply-To: <20250313071652.466718-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=79999a23-94dc-4b99-8db6-f4518177dbef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T08:08:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6772:EE_
x-ms-office365-filtering-correlation-id: 3d612100-b4ea-48d8-f1f2-08dd620640d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kh+u7RIu1yZVGrLXpRnIScyBYJqJq0odqOWrVqjPjm/NloBAWYPs7GXx1H53?=
 =?us-ascii?Q?ba+Nk2miiaBn7czgeh0gz3UUJ8jSR2imto5JeSqgcQxTfQ4+ro86vPiNU7kS?=
 =?us-ascii?Q?KG7mz7+ss7DzsYjCFF2AHkhpBT96JTavj2/9SAt2FRi5uwlZCHmMKAnrAJbV?=
 =?us-ascii?Q?0ulEUCR486sdy0JF/fB9YxdM7dGyN8hDNvF9Ke2x4QRMpkcbiGkBzEYf97xI?=
 =?us-ascii?Q?1oiZgjXiN5SbGsfI+NDBaeYIUtJX85JCAicy5i/UOdiow533XKXZiZjZWkvS?=
 =?us-ascii?Q?kO+WVFM1sYCYayJOXgd5rWE5F/jlvrdiK+dYyS7Ym9J095UrgF6tmWmQTj/t?=
 =?us-ascii?Q?c4lEgpp15FmqWDqQUSPmUjNgtevDYWC5yDCf3r/Upds4Ir81D3zVxzpl66nh?=
 =?us-ascii?Q?3HX++rC4p3DxKQruQVUTz1W9orZ4EuUKTYQcvSRqUccEE6MJT2M1po+P+bk9?=
 =?us-ascii?Q?Nt+0rGu/tnZCU5HgdSNvRZuOyL0nfG3XzM7cFUwgg/1TUR+1TqQ7TBWRW5os?=
 =?us-ascii?Q?YePLrJxDJk/tnNe/M/EP4DJkujcBupcnBvBAoxciGI+a652r6b6AAZ4roaSf?=
 =?us-ascii?Q?jBqWFP53b2vCiJbB3NXjg5rDzLECA6MXnblODMVVeGhqw5izPHhRj8H8kRWX?=
 =?us-ascii?Q?/b/f8k4ufwrhxJz3dxWyfUnFgxzbhHJ/o+Oa1cNPE5oj2GgGEednao+0tSrA?=
 =?us-ascii?Q?mEM3e7LdnWwL0oGTUzU2Es6YuWgyaO0sNQHFOybCHzlOBu/EVomHKitcCXtJ?=
 =?us-ascii?Q?IwaB7ZNDHEcP8o2BBWQzfrj4VTkgBGoOJNOQ02ODeVO3bfoxnPfFMPjt/nLa?=
 =?us-ascii?Q?6h1H3dSE5Pj9lsmzpUf2F7ZQPTXJ/dtbI1gulWudyfflTpkH7vP59SltOYhW?=
 =?us-ascii?Q?Hdgeu3QtwxiKbxiNsA7aFNdvb4bNqcEZXSR5y5+JZ4PWBvvPux7aUEsskzoT?=
 =?us-ascii?Q?uUVjLqlNG3aocQGFPJnOZvnDC2oUsnzLgNFIDuzq6qNt/+vo43u4esRQn+wE?=
 =?us-ascii?Q?+RdA+jwmsBMWba8ELWo/yhg2fApXT8KkVh1AW1f+aFpaLZvFAnUSFyotuGao?=
 =?us-ascii?Q?JVzpr4JV3wffCMNFaMPvCGzPM5cY6XMszjIumfPEJolQnuziA3pWMUM49RGA?=
 =?us-ascii?Q?XY315mz/1xe/mY79lyvnLzq6mCDxh07WWGC+/d5By7H8KF/0UTZTqM3TfE/3?=
 =?us-ascii?Q?xKQ92JUcfOvvAGSSo96Inf+z6KkZGhdLHfWTS/gLkKvDBEiqRpm95sxTmyX0?=
 =?us-ascii?Q?aDHI9g/zHyXNxiVAftDkcPX5oVStJSnAuaAcz0KQABvXMJMtRXwxWPXAWyAu?=
 =?us-ascii?Q?O0gbjxAoss2FONst8RbfG/wDNIIEnbzFTekYl7bMY+Q8/4O8MBMq/Hwql1kK?=
 =?us-ascii?Q?f2AygOGmJa9P3XWhZxAIn+tsG+xU8fg8E66x571poLTdPqOAJA6bEnbpeNJo?=
 =?us-ascii?Q?4/4hPiqkfoP/aSB8Ux+g/No+x3iYMIk4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CIVChU7422fr2gDCbI+NeBvvBGPiT2U6hkzsHu4381sfq6lEDqfZrbVKecdw?=
 =?us-ascii?Q?JpnMjZVsK3hGlMfaUmpocIZaiVnq2LKUs40QPDD9hReyoSR8pCldg0+qFfmA?=
 =?us-ascii?Q?7+Nu3qfTR4MiQcfSv84jWDezqOslO5mGcGk45uPS7c/txBAuv3D6yq90Ki6a?=
 =?us-ascii?Q?Iyz8uE85AHnxGV0AlOA6Dnh5EQ/aHDwHYQlZYbpyXwGkFnujn2/FIftFRCyr?=
 =?us-ascii?Q?wNffqWSjUQQ3EBPpQFYrHTZLD3dA28xfy+UM1c/OFV6oIzF4sf1GBI5Qow3a?=
 =?us-ascii?Q?cJP6dYD47yFr8XOMtpIrW1n6YNQG6SsZXcjJ4dfKmSk6FVF9323Wpeb4nHlW?=
 =?us-ascii?Q?PUbH2FH3EK8Tbs3q+qDKT2lCrn+MxmTzi3sKgACqi3wvYcSIS/REqRmP5y7d?=
 =?us-ascii?Q?++kk6epoy4Z2C+ANu0VrLIuznlvVTeZkxTIVyRwzqg+eX3RpADR76NTtt3zd?=
 =?us-ascii?Q?mipPpGblXLw9DwwmqR3AntUfiXHetJp5/74wgMNPsS5R8V2lIbkc2wXPiDTd?=
 =?us-ascii?Q?Wgmy7rDra3oi42YaIml7J1S8nkeIf7ODwV5zBwqgNOUmYwlQG9JEM30VlM1m?=
 =?us-ascii?Q?xZtWRDf6X+FJn/zA8PEv6m0haSEVLTK/HAvi+IjlPOsKSftskN1oxwNOw5vE?=
 =?us-ascii?Q?U7IejDE1Q9KydT/OycpdTMhqm86AZ+JXTk1cXrxQEgwrL4oZHAY8n0gXHDJ5?=
 =?us-ascii?Q?zCZMP4lZ8q1Hl3gow/GuruA5LQym0rdQpXQSxISCZiaGeNgA+aJxhaN4Xj0Y?=
 =?us-ascii?Q?VzlQLDRmf0FCSLsUcO0FVg0ouEBYyww7eY3wQdrT0zVy48X3PL8BMYawGkoj?=
 =?us-ascii?Q?4Ps7rp5j60DkKpWBJ0Ru0/ywMwQ6NZ/ZAdbSyrXWIpAtj6wGMRqw2+tz/QgR?=
 =?us-ascii?Q?F8SdHV36y2pz35QvtwbM10ljnS5DyeeLZ+/gNN+mTs6TykE5HFMBHSGY95wK?=
 =?us-ascii?Q?lpRO9LvkSiu4Ei/XVGEg+Ww+GkeDhTM4r14gvL6uFSkelWgRkliU+nIh41cx?=
 =?us-ascii?Q?1NrGI+JxfTOw5sF1JiMA7votZ65/El4t+lJkDtJ5v+JVBNsk04N/WM7SwWeJ?=
 =?us-ascii?Q?AnfVBg8vXyY5dhnOo/Yl+S4hgxKgfpLYsbNh8Fyo1THV8ic9Pw95tl/A7rsd?=
 =?us-ascii?Q?bNhvFf/+y/frAILzephyvVBxwtnZ2xei2SSOEmnAl7UyDqKsaq9r24aGZctP?=
 =?us-ascii?Q?O88lv/Ffdz0LxLqXDbaaQv1WbR0JFtD4ihXhrHiF9hjXKvfCJvMXA11fVCh9?=
 =?us-ascii?Q?OemddwYo+vPBQDp+uPeDzddhx48LK/sqfQTX1/NTtUKc0ljrpWdrEskPDZIo?=
 =?us-ascii?Q?0Aqs/dKoed5FJTPRqv00+wXE3HasLg9gVv9asaW26ZHd8XNZZ0N15DUPhDaT?=
 =?us-ascii?Q?N6YxI17p4NLUKXwjjbBQX+895gV0+AP8BHSZTr+9vxDJ5u0JUaVvzmdbWXzf?=
 =?us-ascii?Q?1GtI6nxubGV0XwQpEPgTlA13DVsQLfkpZU1UpOmJA/aWE84xnkH6QkdiGArM?=
 =?us-ascii?Q?BXZ6KT6j7Wj3l7WAdDWopiuKVaznlwjFMN4G8D9e/s45TDtekBUfxbj0dhCz?=
 =?us-ascii?Q?XR/LBmsMQgG/LXwMBu50RDOEIGgnHQQUwehPg3yU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d612100-b4ea-48d8-f1f2-08dd620640d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 08:08:35.2951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4FDO8UmEPl9dQsR3EM3/rD+fc69cTIKJLIy92WhZ2uPSOiZ5QefDfRykeUT+YtrcrzQy3vYe+HmRr4lA8qY6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Thursday, March 13, 2025 15:17
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Enable ACA by default for psp v13_0_6/v13_0_14

Enable ACA by default for psp v13_0_6/v13_0_14.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 7cf8a3036828..cfec29835634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3785,9 +3785,11 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
        adev->ras_enabled =3D amdgpu_ras_enable =3D=3D 0 ? 0 :
                adev->ras_hw_enabled & amdgpu_ras_mask;

-       /* aca is disabled by default except for psp v13_0_12 */
+       /* aca is disabled by default except for psp v13_0_6/v13_0_12/v13_0=
_14 */
        adev->aca.is_enabled =3D
-               (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12));
+               (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 6) ||
+                amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) ||
+                amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 14));

        /* bad page feature is not applicable to specific app platform */
        if (adev->gmc.is_app_apu &&
--
2.34.1

