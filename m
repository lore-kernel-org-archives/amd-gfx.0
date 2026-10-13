Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB24CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 22:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5C810FA1E;
	Tue, 13 Oct 2026 22:53:44 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E05010FA1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 22:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL3KD2oP40yYe1tW34nWYSVxJGVPC/cOF7zKCNlJblu7zWdCojNLz6t4vj2+I4h6ZNOaBLb7SYnhiqJMAEnI+nD58WO6wMPnxD0XrFZSDtpqCJ8qcjswJm6H5kfTkUwJ/HN5khFURUNgcuWAzpn47RSkw7+gg4JndPqbaI5gPK9he2R2nFoxUw/CwR6WIjIZS3n8pYM47qL4j2NeNtvrX0kP0vLDsKMjSQAc0O74skqyRV0x23RnZ7aHML4DxtRoO98/mJW577fsitf6/aIim5VRRPWFUMjIDV9wvXp2VJVbuL9hXxnGrV1Hu2soW8OT1yN45g5MwZlRifZIG9XCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MfMXfjI3m1nGFhD9CyB26nIObidmqltQBJx4bWMHCA=;
 b=AWRuwsY48vNGdt1LOZ6uFIvLg4ynKpajL74P1uyXM/AHzc32dL5Jo8+kuMCbGw1hKfSnixN0hkAQENadH7N+JZdVYiYJK7U/Ng139dxfEZrz8rrjc3NdKh0e1+EfPCFez2DH3Dpq779/eKJSjPzsKDlwT4cp9kK1B8oUumT9IoxOFW7yBpxzPNHA7tSqaoaMEUCYdHFNlyEpQaZU6p3vBaC18JR7O1wdGhV+RKQluSbWrethYKM3WiGbP0bZebX2ln+lJDl1Rlwsp/+cJSkQErgNeDWIbqWj1wj5mhVKK4t/SCkWktQdBoyLzSAL5Lr7mOIg+dYVV+mSPk9ksiJs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MfMXfjI3m1nGFhD9CyB26nIObidmqltQBJx4bWMHCA=;
 b=JkyffbPuiGXrnIkkW+x6AIKqmTaUzj0QjcoyqgdKrDfi3NmnMGmG8qgdNHEeO0IVj/yQJ7TMXrUtTU6k34Epsx2ckKDtvdfYl32liZ/i3n9Uc1GZmx5yU6l+ZjKxPw8XZFPFhmonLDGk0MJUlrORzEbtqnPOUudAjk1cjEtnI9E=
Received: from CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:53:34 +0000
Received: from CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1]) by CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:53:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Wan,
 Gavin" <Gavin.Wan@amd.com>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable queue reset for sdma 7.1 VFs
Thread-Topic: [PATCH] drm/amdgpu: Enable queue reset for sdma 7.1 VFs
Thread-Index: AQHdW2KXVUe0g0FmFUyq9VpVJec4irb8E8tg
Date: Tue, 13 Oct 2026 22:53:34 +0000
Message-ID: <CH0PR12MB51394DEA473C03FEE97A6359F79E2@CH0PR12MB5139.namprd12.prod.outlook.com>
References: <20261013222951.763992-1-victor.skvortsov@amd.com>
In-Reply-To: <20261013222951.763992-1-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-13T22:50:50.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5139:EE_|MN0PR12MB6342:EE_
x-ms-office365-filtering-correlation-id: efe8b49d-8323-4210-d45c-08df297ccfa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|38070700021|56012099006|18002099003|22082099003|6133799003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: 9J/tUh83mfz8+WWqsLAc27bry4Cf+g44/xjtXBIVSiQp49NRxKXjBCBZ6HH8giIKdkNRzIVxNO8aOeZV/8Di/bsS4y/2InGmius8jRdhpyV5l8Up907RSIVaoxNdhY1eFQWl5CaoXex6+9dDyvYL+6yBKLMC95077wnYdcg/Bg4y/r6KEHd1zFqM3sIGhvFeCJfFBiTVjL7lv9uRuzJEfGiuTrxd+oWFHHdJ8TXSILCra1ZqFxJVc6FOjxvEe4+1S+pP7dhgXYI8LHcySorI7mF7/C+3TwOy45lUqgyDq8W+3ZDjBrL6cDB3Vzyp+wzN6Oxs/4SPi7Ssnd2bP85t9sRj8DsZMUVINzyExihGav5FLoG60ogUF7rzA0IVTxNMHQrHYeEeWe2CDctdt1R6AU+tMcUpLblkM4qA/hmfNdlK3EweEvBuvXI8qQYEJBhfGKHkvhEW01b2KzO/F+HoIHPo6xZcjsv91dkRbhKunUpNdq1yrYylgm9jLQHFfXQQUAVpUHxIeWP1atOLBr4UA6axg0JYrOFLpiPb58x3KC3ovsJ9qUPb5RBMDi/RJyJ5v/r/VH44oRV4g3oYaAkc1YygjqvFAizqSy+hEN6ZgMeQ86MMTDh2C3S5cxqYK1h6sv2BeQuzE7xDaXx9QYwxaQxiICCJv7jaMZLKxuLYQ4ff+huf3jeNT5+E5v+HllszWBTtjpDkbdVgh3OG/wj33i0/iVq8wFbsRMx7dAmBJR4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LQ9drseIBCkmcAhLRMQVLXZNpTcwbt0FrO+y24kBPOmeHPFE0QgIoRkTZDaN?=
 =?us-ascii?Q?kr76kRUIp1FwHKERvzU26WFVksAxrgxHSNc+vDQ4rJAYE4URX3S6NTGa1/99?=
 =?us-ascii?Q?vb9S4mVwtOl9VSSkkWokSCWhYPWCpic/hIib0ZFQ+SWpUwpbNxFvvPHdNybn?=
 =?us-ascii?Q?kbn2UfR62Ce8jnYXfcXNorD7ltoElJ7XpgaB9T1ZD006U962FTcC8+u/XVOr?=
 =?us-ascii?Q?WQypa/AsTBNB0Uxya/omoW/cuC1pFsbJXokGN7sui0lWLIPjk3cGK0cgzlUO?=
 =?us-ascii?Q?2EUmdrzctKJbAIcT+3BtN8qW7SbsxX28Hzy3iXcQPV3rDKLPGANTg1mYF7ln?=
 =?us-ascii?Q?Ox0N9cbZIIqG6nPC2UUGLZu9oPRdbVBuuQnguKwHCeQa10Wem9qnyUPcpY5b?=
 =?us-ascii?Q?6NRAHeeqftEcWWNnpT9nqi31FC/RgtWJUHHOnkZ5qlIKi5GH1GLrFCpKDg5x?=
 =?us-ascii?Q?4ZFAvKjj8NZrlSnJn9Vc/iySjnvwj6hAH+V7rLIxNJVHOgtU282rpMx+jN/d?=
 =?us-ascii?Q?Y4AQ6JVNOi1sPt018+Zf3b8e304oAQMptwZSo59cqtkvhf1ftZG5J5wcpauz?=
 =?us-ascii?Q?0MUJswQNXS6kx6rd10Qpsx36zceapFbfMoeQ/W4JkHbUPoKoEFEOWMBSqsH7?=
 =?us-ascii?Q?uNqBnkc+BPSivusiOrrMXAsLRrGgg/QCLjqNvaSZOs156+5Bb74EfPXAtoki?=
 =?us-ascii?Q?OK6bvRzCzmhY9bzK7spxYwvOru02K7QNSyj3hzI9YCjUNZS6p2hrmB+DFrA9?=
 =?us-ascii?Q?BsI6GFhpyICHNhhlFmNG1oQUr2niXLfLtXEQbqw9YvJfavCH5ewaesN6wCr5?=
 =?us-ascii?Q?bwCk8fpy3Iv6cZjpMjganDMt9yMhMhuVqKLXh4O4a7VfPZjGkDEfQl2fzlOf?=
 =?us-ascii?Q?EapYiaXcayLCsBlsrfE/k1Vm/7JEVuSE0F1qF+yOpjNwI0qxcHlPvwIyX7AL?=
 =?us-ascii?Q?JUjZPVEIGfOw8bgTPiIX51FS1mvAJBM6vJrgjKTzsyQ1lpAQHgVoQ6FaGuOR?=
 =?us-ascii?Q?0ZrPzs7zDPm2S+Q/JuzrwQL9Ii9lXpXzXRMchn3sv1rvyXTSU8qQ3eiC7n84?=
 =?us-ascii?Q?GJP4GFyqN1ci1LJKAGXoMeowBKWXZY/TJNcOkmq5emNfQKxm7xVwfnWJKkH4?=
 =?us-ascii?Q?TTCiWUAbgOfBxkiZnu2aTwt3YpYboHv256S/qJrt3oVek6aKzRezFslObv7g?=
 =?us-ascii?Q?Nn0Pk1u97ZXqVRvLGrH4rrC3ngp/tkISxNGCqsroGaekwuPgScq9gd6yiWpX?=
 =?us-ascii?Q?G36iS5A7V7me3MUKQux9gqvvDONQUrju0DxpD8jlszPXhVl5T8ksRdgfuiMM?=
 =?us-ascii?Q?m3hu0MVPGGbcGPBFuXMCJlSVt8Ox2lX6+4k3bMHFByktN+oNbeh/uOx8P7SV?=
 =?us-ascii?Q?JSCXMEJemyXd9jEZ2wL8bjt+YVZcDWlJVRGt9FNGFTtDfqwCXlPu/UH0mLs1?=
 =?us-ascii?Q?sWlgM/+FmQOv7FYUXk4iQVaY94htIvqbem9SHFtJwC68yVopKKjym426wU1P?=
 =?us-ascii?Q?5SYWIAARRLhjoKSv2gy1+HY+qVjKovL2bku6cKIue5Nddk65Zz/XYWeQrYJn?=
 =?us-ascii?Q?ASFetkKnf5w/t3WmSxK806wJIzgpN4d4+6Vr3BLawICXsX6rzWFv1ZtjF7IJ?=
 =?us-ascii?Q?cYi7/bo9sKBxnkYavalliIYxUyn91GMDOIIH4VZAdF17Qk2y/e7MLG7uPEBF?=
 =?us-ascii?Q?fJVRL2M7sLdce55jh71me1igV6PBVSCbJPFNd+Doq09WeSgp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe8b49d-8323-4210-d45c-08df297ccfa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:53:34.6047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mym1njR3Odqhax6/APFE+1G6X3M3XMWqpoIeD6R0ZNT+ugGJ4zgAEkV6QpswudOhBsoeWgtIg3krmAR6Zcib0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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

Public

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor
> Skvortsov
> Sent: Tuesday, October 13, 2026 6:30 PM
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Luo,
> Zhigang <Zhigang.Luo@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>
> Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> Subject: [PATCH] drm/amdgpu: Enable queue reset for sdma 7.1 VFs
>
> VFs support same SDMA 7.1 queue reset capabilities as baremetal.
>

This goes through the MMIO path for kernel SDMA queues.  Assuming that is o=
k for VFs,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> index 21882f2cd2ae..6bea65622086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1333,8 +1333,7 @@ static int sdma_v7_1_sw_init(struct
> amdgpu_ip_block *ip_block)
>
>       adev->sdma.supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev-
> >sdma.instance[0].ring);
> -     if (!amdgpu_sriov_vf(adev) &&
> -         !adev->debug_disable_gpu_ring_reset)
> +     if (!adev->debug_disable_gpu_ring_reset)
>               adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>
>       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> --
> 2.34.1

