Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FA6C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 06:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EF310E6B8;
	Thu, 17 Jul 2025 06:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UNqhDAjx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8757910E6B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 06:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjHJ+fSx0fIxuOsWhetZMPo1pNM14y3bJNkrBTp26RwnXFYQ1xqmyM7aanji3IoD+ZTvLONnX4PU2ykIj6z54FjNO7eiIyQF43LausRtBCvfop/Vwf6+r8Z3t0DiQIL92sSDMOiSTBBrrassthJWwRKz06Ur2XPqBntYd4WLKMGcU8fqZCxtrgv6ixm7RyiAkqO3WAt1+SXb+3S2h+3CfBjfem/Bb2MMvhx8xGCpdSsRq2f1aiuRY82SRwPaEdCiokIokb7QAiNI2iv3ukinuXB4UwVNijYf+2jtt12zvErSBOXTClDL16fLwP9vI0C3tUu1SWEx2q6qqtRlBtavhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh3sKdq3r+r/I6faH7N5V0wquJwy2hDytFLMMeKS6M0=;
 b=iVP/pWU1x0ZBywwpb6JP9Z8bHlVBKEA9yXjGBi/ha+4h1x4zlQ8fULlH//h8E2sxPDHwHlklwwnZ9LFSHk4gOTXApRnlUVYkAIOQYrzWi5mUceS10Wd5xFc/ePoIH8q1eSGwzTGJ96vW+zTZbRX6b78CUfvHMs9YENKyD+jd6Ed17PvD0CtxJ6z2s7QcXlTKarh786qNjmUtX6qVh8X5tt1ImxtmEx0huJG4sRrLTJn1LpXHuF5oBIUxqutJIgC/5C5dcRDoMbSHPIQi5MkpDE0dcD7/CW7qgKvI6PuN/ouajj0eMNT9iVSzsTZNP2TXjl0qUzdm57/ILdM14LhPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh3sKdq3r+r/I6faH7N5V0wquJwy2hDytFLMMeKS6M0=;
 b=UNqhDAjxpd+SsTmxGDpwUopy0c+cS/dwBMa0QSI0bir51sbMJR6fjnJcuVhLX+GPXRIWpVskiiRZ4yhL0Y0fDcqZKkzKK4sTVp5K1aZe13Kzh/hIOtudY+ZLIp+z3fGzQFULg8/Qmam/jf+87AxraC2zBZQARYWl/RJLfkAXe5Q=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 06:40:10 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 06:40:09 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add command to check address validity
Thread-Topic: [PATCH] drm/amdgpu: add command to check address validity
Thread-Index: AQHb9h25htMIeLc170Suq+hiksd0k7Q13rrA
Date: Thu, 17 Jul 2025 06:40:09 +0000
Message-ID: <PH7PR12MB8796D356664839C1D5445032B051A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250716064823.1272183-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250716064823.1272183-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-17T06:39:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB6667:EE_
x-ms-office365-filtering-correlation-id: 4fb936ec-a5dc-413b-aabb-08ddc4fcc672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JjGTabmwCRTGux79RMVsqgYqkcPLCG0wrnfjefcmKEyaD7b5tNAebMgnJeb+?=
 =?us-ascii?Q?1hTIWMe8GgFJxQGrJQy5DK29RWDlUkawWEXg64LI6WcLwMVY7Dq9DniUkKBa?=
 =?us-ascii?Q?SgmlNBA7OKiRrSBeQqDezsNnsXJNusSd61WuMNomokTIkr75EzncQj6ZTou1?=
 =?us-ascii?Q?vq1MEqnhlCYlkEwzmokYFWh7MFDxEhe9aO5LslGMyhMlHdUSM39Cy79QjwYC?=
 =?us-ascii?Q?ATtP92H57pZhE2pR5re2CCJnFzVrbHdtyG+6NNVRVkm/MbLz2C71xbKEzWRS?=
 =?us-ascii?Q?FsWeDqwCJoj5tHda4i1uMuds5yhNbTQEAVn0xrv2L7Ft4xFl6HOafgAjxWZw?=
 =?us-ascii?Q?A77XGdgGwx2jy5HQeBQY3K5laasLd5efB0N8KIm4MjzarFEGqIimSBg8DfGb?=
 =?us-ascii?Q?0P8z7b0SbRJuMvVNMqW4vDL6kQeEeKstXJ/oPTtZnq4WI1lPBYaUCD03ba/u?=
 =?us-ascii?Q?IyagVc7Kj5Dk7fxfp6KcqOClQkHvHhdQZy1fNhoXBdlbu8rFBsPQhjshkRYN?=
 =?us-ascii?Q?Zw5qSuUbmf2VFE0rHe65Oykqf+8FFOnjg7jIgKpEq2j2aPp7n8fD4Jh9V9jE?=
 =?us-ascii?Q?uImbU5/D8ep8E3g4guwelAwJGQ9lLic6HAk7vQTYCXHwqdPHuD9SrKqmRyY/?=
 =?us-ascii?Q?ZMMnJAnhZMK2jwUKhWxPwqdQNDIs7W1Q492rSDe47mrSOw2KnwtziZzo0O+o?=
 =?us-ascii?Q?aDEQoNuMcSl0/YyBMGmJ3ZoyFNcYt7cWkOIj9v4bnKR9y5Zbh6KBlo6wH4xK?=
 =?us-ascii?Q?fHxCNYekww85j354ZZ+snKtJ8Kq/FxBulD6haGQkhr0g6giIk2vNPddLQIAz?=
 =?us-ascii?Q?3hqDkQU5bS2/esW3n6I3dRbRiTWbPFCy/uXq3vcc2Vkb1oH461uOBKI2VC2C?=
 =?us-ascii?Q?QNeFMZh7lKIJ/wnDnsPkqHmsMcns6AzIcjTpek8uE0pDJG8TIGymRhTgcAh4?=
 =?us-ascii?Q?qc0N6dzS5Sfh1jv9lFFCUcZpm9kRNY26QOmNG6a/PnkaeE7/uN/BRYiV/GTJ?=
 =?us-ascii?Q?RYqLTYUcxA2mf1oBxhZqKNjzPyl+oegijelg8hm2fYNUMTQ+qrCstx+0s0Kx?=
 =?us-ascii?Q?H2vRsbyJoMYK4qRo5tWbI42GL71KJGD1Lkeua5L8N84nK0MD5T6sCv4BYhcg?=
 =?us-ascii?Q?++RKCzngwIJuBYpYW3YYyXbyK+qHZq3EBySnXfChMaQ6xydsZ1g3aIcv41WQ?=
 =?us-ascii?Q?W0jJNUhkudgK2jbeQp+x4vqHtWOWg2MqW5FUw1vLDsQGheknl2WLdyCaIBVn?=
 =?us-ascii?Q?2iLggY8kPAc+CDUzIraCABd2UR8cHB0tAs9INrh/Fale/sON8MEr9Z4ibSKb?=
 =?us-ascii?Q?oO95mY0ZDHAx/+UTdZcLMOiwjeLxGxEsD3VCxX0Rs5JZ9185bcJ5MfcInOBk?=
 =?us-ascii?Q?ElFV7WQy4o3Rt7dMaFSmx6rp2E4DmfpUGSGyg13b6UXSD4co76L8DR6q3Tnr?=
 =?us-ascii?Q?lxibnk7W2uLNNPd3EJu1ui+sOqauXyJo4GlKDuXfx4IcoDXm5cdtzQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IEehNjOKjkY8Xu4xEItiLWh3jxlDDFVAeAYct8vi6KpBIvRrHuraOiAZd0BP?=
 =?us-ascii?Q?QOfHfstTljQpyHCElWsaC3KjJmltAEdEJO+WXSYaRZBISBTarJiGYmVMVHf8?=
 =?us-ascii?Q?Jqvqb4lZ+UnMMQln4WQOT2QQNHYiyS+QnaCbKJPd7J2fpFQDs63kybjU5s/0?=
 =?us-ascii?Q?RVpMSlJy0lJZp0dfznV3WGW37zYVfmT4iQk8kh0DoHxTTSDi9E8M1mvzy0OZ?=
 =?us-ascii?Q?wa+n/DzCOWloccL/FgVEuj6pugINsfHx4bp7GuJgS7NIjyIQOZCSxjRCpNNQ?=
 =?us-ascii?Q?FIYY9UIsbZinMBYXEe1TDatZe1w3DYCAGQav1YdIxpqYJDdjqIxnurw0uxua?=
 =?us-ascii?Q?cI4AtxCyc3voQXkfoLayjuYp/la1JtXV8sQXDthiS8Rp2gsfktCeA1jJigib?=
 =?us-ascii?Q?dwIQuDjPH9glw0qsv/fKYJa/JWPweZWpRb/dxV9gir7hB9OJEH4V8MvmoU4U?=
 =?us-ascii?Q?d21vL2O7CXcIlv1T3MyRHcm4AD0vrd+70IFm3cMcsGL850dlgwrTOPQvvLQR?=
 =?us-ascii?Q?YNrrCFcngToUIVCe5QYYDmnBX4J+DFMh0Js7PpZpFyr66yAOYLZA93I3bOEB?=
 =?us-ascii?Q?Qu/NYaJRUg9FuZAqLK5ma3FdpJYE6/rajCXfBD/oJDwcbcB1CjwriyN6X+m0?=
 =?us-ascii?Q?zISPpo34TEgGKJBdx2AIFPaOtaxScuAqS9Wak9gMFvlpiqRmjGNCEL8UFBYe?=
 =?us-ascii?Q?xk9G6tDzdme9090uOrbruoXClESnBxD2q5I799jv+60B7kWQVMZzIiMCDCmr?=
 =?us-ascii?Q?mIu9p7x8msYS0PPPrCRL8/W59JSjJagfq6bnFKPL8RYLT8YuWQ/GTxmB1c5f?=
 =?us-ascii?Q?x30ijY8D7yXpcVbMqNCIdXWbuzwh0j10pg1azbO87qwzUomq8TqW9hNN8oGs?=
 =?us-ascii?Q?sfw5cV7TRG/2EpfNWixRGas4fKm/N2XlWNmJPkcfGnQLsSwT078vRjAnQHCG?=
 =?us-ascii?Q?HNJiW4rjHwpM4HxL2tW+8oYO1QO4n+xUsChmfx3ThA9hUGPOSJt/mXx88Ujz?=
 =?us-ascii?Q?vEItTCQl5wuTDEPgaparXQ0o4cPVY+T0NRrdBeV+ka88jOc4b7gmkHx08b29?=
 =?us-ascii?Q?tkGsCANY/aJlnDWyICEx/QT5KnzRDJxUZxAl2BEq6AwNzXN+WTvR0+aYtjOM?=
 =?us-ascii?Q?RL/ffT8ytDxRNeroU7uK36dbesensnBBSpskD32+CFaVatnL/UxaN2jxwx69?=
 =?us-ascii?Q?us588+Qejj4txRHXY4OVWABcx/EPqyPAKsf90v+N1miX6IthX+d8ejMSeMnm?=
 =?us-ascii?Q?X3BsuLBJtCv/u7ub8o1CJjS19nmSMNtPjlQBZCaSC1LGtA7Qc/bZDIOdHtTK?=
 =?us-ascii?Q?+7BS/XqGtwgH09s9xlV3N0yihfhvmu497hXqnmTJnGlsHzQ9ztSC0GZKGZBu?=
 =?us-ascii?Q?z0dEbHN/dEIG2ZfEBS0lKig/MINdEEnfdRRD6/AxMcwelLURLhmCJ0MhEf3E?=
 =?us-ascii?Q?glL0nI9I++3bLVi9d4uGztusvNhbR1LIpOu7ZvqzGE2Fl+DPwSCO3iyL4q/D?=
 =?us-ascii?Q?WBcIX3pb7BSUluGi3M7aXBmMBqeFpQrvd76InOgVaUmydBOiDkDABAs7dDGc?=
 =?us-ascii?Q?1NiLJ2fnaSREZ023rxo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb936ec-a5dc-413b-aabb-08ddc4fcc672
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 06:40:09.6440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKCxaioAZ71hELQPl/xfnUYczdTLESrxipfdYlDXXCtWbj3zPyVKE9nc6KFwmeOO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
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

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, July 16, 2025 2:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: add command to check address validity
>
> Add command to check address validity and remove unused command codes.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58 +++++++++++--------------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++
>  2 files changed, 29 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 15bde4904996..68feec0956f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -163,47 +163,38 @@ static bool amdgpu_ras_get_error_query_ready(struct
> amdgpu_device *adev)
>       return false;
>  }
>
> -static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64=
_t
> address)
> +static int amdgpu_check_address_validity(struct amdgpu_device *adev,
> +uint64_t address)
>  {
> -     struct ras_err_data err_data;
> -     struct eeprom_table_record err_rec;
> -     int ret;
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     struct amdgpu_vram_block_info blk_info;
> +     uint64_t page_pfns[32] =3D {0};
> +     int i, ret, count;
> +
> +     if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
> +             return 0;
>
>       if ((address >=3D adev->gmc.mc_vram_size) ||
>           (address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
>               dev_warn(adev->dev,
> -                      "RAS WARN: input address 0x%llx is invalid.\n",
> -                      address);
> +                 "RAS WARN: input address 0x%llx is invalid.\n",
> +                 address);
>               return -EINVAL;
>       }
>
> -     if (amdgpu_ras_check_bad_page(adev, address)) {
> -             dev_warn(adev->dev,
> -                      "RAS WARN: 0x%llx has already been marked as bad
> page!\n",
> -                      address);
> -             return 0;
> -     }
> -
> -     ret =3D amdgpu_ras_error_data_init(&err_data);
> -     if (ret)
> -             return ret;
> +     count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
> +                             address, page_pfns, ARRAY_SIZE(page_pfns));
> +     if (count <=3D 0)
> +             return -EPERM;
>
> -     memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
> -     err_data.err_addr =3D &err_rec;
> -     amdgpu_umc_fill_error_record(&err_data, address, address, 0, 0);
> -
> -     if (amdgpu_bad_page_threshold !=3D 0) {
> -             amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> -                                      err_data.err_addr_cnt, false);
> -             amdgpu_ras_save_bad_pages(adev, NULL);
> +     for (i =3D 0; i < count; i++) {
> +             memset(&blk_info, 0, sizeof(blk_info));
> +             ret =3D amdgpu_vram_mgr_query_address_block_info(&adev-
> >mman.vram_mgr,
> +                                     page_pfns[i] <<
> AMDGPU_GPU_PAGE_SHIFT, &blk_info);
> +             if (!ret && (blk_info.task.pid =3D=3D con->init_task_pid) &=
&
> +                     !strncmp(blk_info.task.comm, con->init_task_comm,
> TASK_COMM_LEN))
> +                     return -EACCES;
>       }
>
> -     amdgpu_ras_error_data_fini(&err_data);
> -
> -     dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES
> AND WILL CORRUPT RAS EEPROM\n");
> -     dev_warn(adev->dev, "Clear EEPROM:\n");
> -     dev_warn(adev->dev, "    echo 1 >
> /sys/kernel/debug/dri/0/ras/ras_eeprom_reset\n");
> -
>       return 0;
>  }
>
> @@ -295,7 +286,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct =
file *f,
>               op =3D 1;
>       else if (sscanf(str, "inject %32s %8s", block_name, err) =3D=3D 2)
>               op =3D 2;
> -     else if (strstr(str, "retire_page") !=3D NULL)
> +     else if (strstr(str, "check_address") !=3D NULL)

[Tao] the added check is fine for me, but I prefer to reserve retire_page c=
ommand, we can set check_address to op 4.

>               op =3D 3;
>       else if (str[0] && str[1] && str[2] && str[3])
>               /* ascii string, but commands are not matched. */ @@ -495,7=
 +486,7
> @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
>               return ret;
>
>       if (data.op =3D=3D 3) {
> -             ret =3D amdgpu_reserve_page_direct(adev, data.inject.addres=
s);
> +             ret =3D amdgpu_check_address_validity(adev, data.inject.add=
ress);
>               if (!ret)
>                       return size;
>               else
> @@ -4103,6 +4094,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>                       goto release_con;
>       }
>
> +     con->init_task_pid =3D task_pid_nr(current);
> +     get_task_comm(con->init_task_comm, current);
> +
>       dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
>                "hardware ability[%x] ras_mask[%x]\n",
>                adev->ras_hw_enabled, adev->ras_enabled); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 927d6bff734a..7f10a7402160 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -570,6 +570,9 @@ struct amdgpu_ras {
>       struct ras_event_manager *event_mgr;
>
>       uint64_t reserved_pages_in_bytes;
> +
> +     pid_t init_task_pid;
> +     char init_task_comm[TASK_COMM_LEN];
>  };
>
>  struct ras_fs_data {
> --
> 2.34.1

