Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293BAC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 12:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78E060F46
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 12:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B78E060F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4302F6E3DF;
	Fri, 13 Aug 2021 12:58:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AEB6E3DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 12:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxD52PkokORS7OvzPBEf+Mm7k9akLhbjkFlfPv8rag/vfqa6gwSTAMw0QDhw0j8CaurzoAEHn1XOQo4ZIsiBjUDqazH+hd9dUcvJkiK7bQmf3I60tke/54KsL5HkXEfNk/Xokq3pDEG01AwuCDTyFVwA15JTZRcQSYibaCxRR30gA4z/wpuL0/nUaeF/8CwIHFQrS4yt0FGcaC4GSy6bcBNBsc13t99naaN6PbZuYmkg2AdqLyGnIeFKdpmI7EwVi6T1AwBqMT2S6YEBYqjXuVSS0P5HiJ/DhdbgGKYSufo3iWce4d5l6Q869Nv/bYaSCfAHSCPOo8JgrSM5rXdowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMmo4T9YktbNN+Xa3Wj2J0ktspChd0ytGksMM4IU2AI=;
 b=lYMkQ85vWptUFS2wOIQFBU9lXwd69O3vmi0lxc0Lx4wyrwemky5zNEcnSP3nNjuaqIdKAlvYgWIfrARbSOV2ruVTa8AZdCJGrPCoCylviINLgOgo7b1w+37F0OTBYzLHi89JnPEf/EiGnVYz8ho1pR9u+f5N912Hka4nIbgDX2Sskxg+w4YOjozvwo9Q3ln64JbEGXXRcI02ilrgxRnieIPlX4Lr89PzlclVwvsP1cdLYuQdLVWKA+TMoVABaoTW2TDIcW/el4nJVWaDSmau+gC6ZPRtmrv9eMeQ5tGs+maWVXpY4zfJPu1QhtzvgYZdaPs1CABwcNTo9R0vf0NdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMmo4T9YktbNN+Xa3Wj2J0ktspChd0ytGksMM4IU2AI=;
 b=X7wcXPja53XkiCInNUcwrPryRH35niS3QNiv2Yc/aL6BTTEA1mmxB7SLD4+aG+66eoGs+4xPQKzmjbe1m3H1kHCfdVu+usWHu72ZYJnXszVMuYgKyJQmEYThb8nfbHb+jWoRGYQ9+EliVG8ex0x279dSqWklJVVBpT9XwGAJFx0=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 12:57:59 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4415.020; Fri, 13 Aug 2021
 12:57:59 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: remove unnecessary RAS context field
Thread-Topic: [PATCH] drm/amd/amdgpu: remove unnecessary RAS context field
Thread-Index: AdeQNskhKJjxWjtYR+6ZkMW2ppJQJwADAG2w
Date: Fri, 13 Aug 2021 12:57:58 +0000
Message-ID: <BN9PR12MB5226B1116ED425808F5AF312FBFA9@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <DM6PR12MB4649355F3251E0EA3FE7743091FA9@DM6PR12MB4649.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4649355F3251E0EA3FE7743091FA9@DM6PR12MB4649.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-13T12:57:55Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=45831505-1f6c-4427-a379-c45988518013;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 792e6926-ee48-42be-c823-08d95e59fa15
x-ms-traffictypediagnostic: BN9PR12MB5084:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5084CF37B672DD3E1D62D7ECFBFA9@BN9PR12MB5084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:34;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dL26l2+GtmeFMXJPfRN4i/68l0cOApIIVVYS64IOlMdbjGZ4woyDqDGBaQSZd9gRfOk34IpvCDq7Q4vI7scCPfH+5LyKWhScttU/bJ3pxWmNNtZs0xlWHjGmVfvl0GFRJ+6LNueD0POXoMNbdYvzLjlLD44dfDgaMvyVTiEfulXWtcRUZBW8XwL6FA4bJ8lU2nW+23baRYmJHrgt7ET9zqX0/CklsdJD5XzR1T3mK35UT4ewyrfsNwBzPMVVyKYwjSzwV02fH2WGYfs9OzIfqH74h/SeCP5VQ48FBsjp1B9rL4a1qqV/UlUeO6OQpBcBsqlEpRUmTrjTM0Bu4UyM9CZKzSFRU0HLyIdcJwLf1sNI9w7kaZ2MI9IBqNsIzYz1/+mXpUny5ZB4bxPuDNYbVcKKGy8b3AzLMWSxN/WGMJT2tRfCu3yAd1xARvYFlf0qu4UCunUAS6YNSl5dwCkcBP6OGsW3k4c66Mtb66kMv5J/7s/O4tlilGQPGYgejzJkhdMNmLhO01gSrmgOsp8dEdAXJVMwu3aUM6KSie8RaVe+qaZrlJk6C4Iw67nFzZDUc8IqTh9mM8pId1IjmIL8LXPfgxuShr818RPXBFncDoeGBCpHmllCYGux11PmkQE6Mhq8TNcXlVwe3d7vfTGYVxHag94yVQF/Z00FVviPY1xD+pHygmW2nQxUEIyrmz6rs32c3jxnwdW02f0XXmELwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(76116006)(66946007)(64756008)(66446008)(33656002)(186003)(26005)(66476007)(86362001)(52536014)(2906002)(66556008)(8676002)(8936002)(5660300002)(9686003)(71200400001)(478600001)(55016002)(83380400001)(38100700002)(53546011)(6506007)(316002)(38070700005)(122000001)(110136005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pC6n9gfS8BZ9N1HMZ4ae5Z8dpTeZOyitvMYWPrlg3QnqXCkxllXaIBUHyhGs?=
 =?us-ascii?Q?CqdiWDDptIagecQDrGeCsKfP6PeKB2teDjBDzrIomHwQ5hG1YZxdePTBTvnk?=
 =?us-ascii?Q?SERianUAQdvVtXApF3p/Op3U934OX03GWjahtQdgHZjUcLn8EifKhciL9W31?=
 =?us-ascii?Q?8boutvfPHgdPWWTZC45mRDjHsjjolMeo00N95ytEo1drbtFXaGkuSP04ZP6C?=
 =?us-ascii?Q?YaOLsYPn4WxUlFyQNB/HE/On3VyogXDcAPM4poeZVthYhrXVswtYxvEiCIY9?=
 =?us-ascii?Q?IvudbeWVbznTqe7MMx1MDKRnPxGYw5Q3pb6ug8+QC0+p9Jo9NpfHBV+RY5Qk?=
 =?us-ascii?Q?/Q+JmYs3UiiLQYWvBzXGH8tSwxlsF4p0B7DZnfpSmvcAGTPHN3dt5H+pi4Ne?=
 =?us-ascii?Q?7th4HUMzjH1qJRSZMM/UfXk/2edA9sxp0WWuqjm/W/FdUYmDn++iiin6Ln5K?=
 =?us-ascii?Q?9wj1F/9/e2ZdOaSx9JbBsvPpspqNf8VAL20OATfvZMvgIuvK8EICV8i/tUBZ?=
 =?us-ascii?Q?bUh9EEfob5nc00yJfB7Dyx5oDSFQHQUHoA6GCYoyCuDAAtm5r3myJVI97ZIM?=
 =?us-ascii?Q?ij3Q72KdV26cHVZ+aiHgx0FgEHrIPbGC5zKCdtvr2LPoOhSdIri0U7LN/ElI?=
 =?us-ascii?Q?rwbmzP8z7eixDf6pWPP8C/+/r5dHrOfUIuPyaRlhw1EawEw/Kc81EVr5y1I5?=
 =?us-ascii?Q?t5bz/tTvk1lvql7qmyHForVbCHOJNDr+pBDfqfpvuHX+1/FF9VrECS3RdiNb?=
 =?us-ascii?Q?IZA4k7HHzsFkUU6DAdVfbYwP96IVDTafWAkVG/k5j45vcTc4dur4akzgO/QE?=
 =?us-ascii?Q?dc3It2kaa9jikEKSr1M4Q3TNpp2/5T6WLOd3tXhLi95J/86GiQjft7OvBxxq?=
 =?us-ascii?Q?PsDUAOBfIGz6WKWvuL2TZATsuwRBKRb9LrmOCvxm1+Oc9aKecia7eX+SYX6t?=
 =?us-ascii?Q?FmUwoZfos0zEG4mJFfp7pEFGKxgyNOAmQKJPBO8GV2hmM/5K0tYZgIMrV7og?=
 =?us-ascii?Q?uadNi32tlUszqgPpfTN312RXYQ7HHP0I2VHciMisjoSekERBHMfiCKfrdfA4?=
 =?us-ascii?Q?477QUNqkKboCAWuZJPEq9bvkVYqzd0yzY3gi+r6o8GVEglve32iSTx5fTJX/?=
 =?us-ascii?Q?soKbR3AyES2NgMl6yNbeI+IALT8Vex9keOsZDJNMCNpv29qJOyd85HIwjbUQ?=
 =?us-ascii?Q?auv0pUVwlJPcuOXXArN21KVR+tug2ymmbtpX6xJsEFU67JrbVcuiejtuejav?=
 =?us-ascii?Q?pwBM8++K6CRxFyyF+NBm6nELSBMb8sE3TvVj6e7kjE+neDWMDrE+HNCXjq45?=
 =?us-ascii?Q?tRlriMY6uHa/qSYFZcmSDOTT?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5226B1116ED425808F5AF312FBFA9BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792e6926-ee48-42be-c823-08d95e59fa15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 12:57:58.8048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkiKB4vwebGtSuAgy2R1IKqCGe8hlQ1lCbBdgBF84Ya8mOn4tvXGXIpHUiI+IrMr1IclqlzTvqy6XRcegJ45uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
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

--_000_BN9PR12MB5226B1116ED425808F5AF312FBFA9BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: John Clements <john.clements@amd.com>

From: Li, Candice <Candice.Li@amd.com>
Sent: Friday, August 13, 2021 7:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amd/amdgpu: remove unnecessary RAS context field


[Public]

Delete ras_if->name in the RAS ctx structure and remove related lines.

Signed-off-by: Candice Li candice.li@amd.com<mailto:candice.li@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 4 +---
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h   | 5 +++--
drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 1 -
drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c    | 4 ++--
10 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 9cfef56b2aee..5beaa7c1bd11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -615,7 +615,6 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev=
)
                            adev->gfx.ras_if->block =3D AMDGPU_RAS_BLOCK__G=
FX;
                            adev->gfx.ras_if->type =3D AMDGPU_RAS_ERROR__MU=
LTI_UNCORRECTABLE;
                            adev->gfx.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->gfx.ras_if->name, "gfx");
             }
             fs_info.head =3D ih_info.head =3D *adev->gfx.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->gfx.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_hdp.c
index 1d50d534d77c..a766e1aad2b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -41,7 +41,6 @@ int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev)
                            adev->hdp.ras_if->block =3D AMDGPU_RAS_BLOCK__H=
DP;
                            adev->hdp.ras_if->type =3D AMDGPU_RAS_ERROR__MU=
LTI_UNCORRECTABLE;
                            adev->hdp.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->hdp.ras_if->name, "hdp");
             }
             ih_info.head =3D fs_info.head =3D *adev->hdp.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->hdp.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mmhub.c
index ead3dc572ec5..24297dc51434 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -41,7 +41,6 @@ int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev=
)
                            adev->mmhub.ras_if->block =3D AMDGPU_RAS_BLOCK_=
_MMHUB;
                            adev->mmhub.ras_if->type =3D AMDGPU_RAS_ERROR__=
MULTI_UNCORRECTABLE;
                            adev->mmhub.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->mmhub.ras_if->name, "mmhub");
             }
             ih_info.head =3D fs_info.head =3D *adev->mmhub.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->mmhub.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.c
index 6201a5f4b4fa..6afb02fef8cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -39,7 +39,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev)
                            adev->nbio.ras_if->block =3D AMDGPU_RAS_BLOCK__=
PCIE_BIF;
                            adev->nbio.ras_if->type =3D AMDGPU_RAS_ERROR__M=
ULTI_UNCORRECTABLE;
                            adev->nbio.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->nbio.ras_if->name, "pcie_bif");
             }
             ih_info.head =3D fs_info.head =3D *adev->nbio.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->nbio.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 3811b6b6a192..96a8fd0ca1df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -64,7 +64,6 @@ const char *ras_block_string[] =3D {
};

 #define ras_err_str(i) (ras_error_string[ffs(i)])
-#define ras_block_str(i) (ras_block_string[i])

 #define RAS_DEFAULT_FLAGS (AMDGPU_RAS_FLAG_INIT_BY_VBIOS)

@@ -530,7 +529,7 @@ static inline void put_obj(struct ras_manager *obj)
             if (obj && (--obj->use =3D=3D 0))
                            list_del(&obj->node);
             if (obj && (obj->use < 0))
-                           DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n",=
 obj->head.name);
+                           DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n",=
 ras_block_str(obj->head.block));
}

 /* make one obj and return it. */
@@ -793,7 +792,6 @@ static int amdgpu_ras_enable_all_features(struct amdgpu=
_device *adev,
                                          .type =3D default_ras_type,
                                          .sub_block_index =3D 0,
                            };
-                           strcpy(head.name, ras_block_str(i));
                            if (bypass) {
                                          /*
                                           * bypass psp. vbios enable ras f=
or us.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 471ffe885fdf..abc5710898e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -53,6 +53,9 @@ enum amdgpu_ras_block {
             AMDGPU_RAS_BLOCK__LAST
};

+extern const char *ras_block_string[];
+
+#define ras_block_str(i) (ras_block_string[i])
#define AMDGPU_RAS_BLOCK_COUNT AMDGPU_RAS_BLOCK__LAST
#define AMDGPU_RAS_BLOCK_MASK   ((1ULL << AMDGPU_RAS_BLOCK_COUNT) - 1)

@@ -306,8 +309,6 @@ struct ras_common_if {
             enum amdgpu_ras_block block;
             enum amdgpu_ras_error_type type;
             uint32_t sub_block_index;
-             /* block name */
-             char name[32];
};

 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index de91d29c9d96..65debb65a5df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -105,7 +105,6 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *ade=
v,
                            adev->sdma.ras_if->block =3D AMDGPU_RAS_BLOCK__=
SDMA;
                            adev->sdma.ras_if->type =3D AMDGPU_RAS_ERROR__M=
ULTI_UNCORRECTABLE;
                            adev->sdma.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->sdma.ras_if->name, "sdma");
             }
             fs_info.head =3D ih_info->head =3D *adev->sdma.ras_if;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 0c7c56a91b25..a90029ee9733 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -41,7 +41,6 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
                            adev->umc.ras_if->block =3D AMDGPU_RAS_BLOCK__U=
MC;
                            adev->umc.ras_if->type =3D AMDGPU_RAS_ERROR__MU=
LTI_UNCORRECTABLE;
                            adev->umc.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->umc.ras_if->name, "umc");
             }
             ih_info.head =3D fs_info.head =3D *adev->umc.ras_if;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 258cf86b32f6..2e47bc446700 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -663,7 +663,6 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_devi=
ce *adev)
                            adev->gmc.xgmi.ras_if->block =3D AMDGPU_RAS_BLO=
CK__XGMI_WAFL;
                            adev->gmc.xgmi.ras_if->type =3D AMDGPU_RAS_ERRO=
R__MULTI_UNCORRECTABLE;
                            adev->gmc.xgmi.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->gmc.xgmi.ras_if->name, "xgmi_wafl"=
);
             }
             ih_info.head =3D fs_info.head =3D *adev->gmc.xgmi.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->gmc.xgmi.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index cef929746739..1c94a14fc18d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -372,13 +372,13 @@ static void nbio_v7_4_handle_ras_controller_intr_no_b=
ifring(struct amdgpu_device
                                                                           =
          "errors detected in %s block, "
                                                                           =
          "no user action is needed.\n",
                                                                           =
          obj->err_data.ce_count,
-                                                                          =
           adev->nbio.ras_if->name);
+                                                                          =
          ras_block_str(adev->nbio.ras_if->block));

                                           if (err_data.ue_count)
                                                         dev_info(adev->dev=
, "%ld uncorrectable hardware "
                                                                           =
          "errors detected in %s block\n",
                                                                           =
          obj->err_data.ue_count,
-                                                                          =
           adev->nbio.ras_if->name);
+                                                                          =
          ras_block_str(adev->nbio.ras_if->block));
                            }

                             dev_info(adev->dev, "RAS controller interrupt =
triggered "
--
2.17.1




Thanks,
Candice


--_000_BN9PR12MB5226B1116ED425808F5AF312FBFA9BN9PR12MB5226namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
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
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: John Clements &lt;john.clements@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Li, Candice &lt;Candice.Li@amd.com&gt; =
<br>
<b>Sent:</b> Friday, August 13, 2021 7:46 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Clements, John &lt;John.Clements@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: remove unnecessary RAS context fiel=
d<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Delete ras_if-&gt;name in the RAS ctx structure and =
remove related lines.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Candice Li <a href=3D"mailto:candice.=
li@amd.com">
candice.li@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp; =
| 1 -<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c&nbsp;&nbsp; =
| 1 -<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 1 -<o:p>=
</o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c&nbsp; | 1 -=
<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp; =
| 4 +---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp; =
| 5 +++--<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c&nbsp; | 1 -=
<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c &nbsp;&nbsp;=
| 1 -<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp; | 1 -=
<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c&nbsp;&nbsp;&n=
bsp; | 4 ++--<o:p></o:p></p>
<p class=3D"MsoNormal">10 files changed, 6 insertions(+), 14 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 9cfef56b2aee..5beaa7c1bd11 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -615,7 +615,6 @@ int amdgpu_gfx_ras_late_init(str=
uct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras_if-&gt;block =3D AMDGP=
U_RAS_BLOCK__GFX;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras_if-&gt;type =3D AMDGPU=
_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras_if-&gt;sub_block_index=
 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;gfx.ras_if-&gt;name, &quot;g=
fx&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; fs_info.head =3D ih_info.head =3D *adev-&gt;gfx.ras_if=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;gfx.ras_if,<=
o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 1d50d534d77c..a766e1aad2b9 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -41,7 +41,6 @@ int amdgpu_hdp_ras_late_init(struc=
t amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.ras_if-&gt;block =3D AMDGP=
U_RAS_BLOCK__HDP;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.ras_if-&gt;type =3D AMDGPU=
_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.ras_if-&gt;sub_block_index=
 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;hdp.ras_if-&gt;name, &quot;h=
dp&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;hdp.ras_if=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;hdp.ras_if,<=
o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub=
.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c<o:p></o:p></p>
<p class=3D"MsoNormal">index ead3dc572ec5..24297dc51434 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -41,7 +41,6 @@ int amdgpu_mmhub_ras_late_init(str=
uct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.ras_if-&gt;block =3D AMD=
GPU_RAS_BLOCK__MMHUB;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.ras_if-&gt;type =3D AMDG=
PU_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.ras_if-&gt;sub_block_ind=
ex =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;mmhub.ras_if-&gt;name, &quot=
;mmhub&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;mmhub.ras_=
if;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;mmhub.ras_if=
,<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 6201a5f4b4fa..6afb02fef8cf 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -39,7 +39,6 @@ int amdgpu_nbio_ras_late_init(stru=
ct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras_if-&gt;block =3D AMDG=
PU_RAS_BLOCK__PCIE_BIF;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras_if-&gt;type =3D AMDGP=
U_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras_if-&gt;sub_block_inde=
x =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;nbio.ras_if-&gt;name, &quot;=
pcie_bif&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;nbio.ras_i=
f;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;nbio.ras_if,=
<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 3811b6b6a192..96a8fd0ca1df 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -64,7 +64,6 @@ const char *ras_block_string[] =3D=
 {<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;#define ras_err_str(i) (ras_error_string[ffs(i=
)])<o:p></o:p></p>
<p class=3D"MsoNormal">-#define ras_block_str(i) (ras_block_string[i])<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;#define RAS_DEFAULT_FLAGS (AMDGPU_RAS_FLAG_INI=
T_BY_VBIOS)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -530,7 +529,7 @@ static inline void put_obj(struc=
t ras_manager *obj)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (obj &amp;&amp; (--obj-&gt;use =3D=3D 0))<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;obj-&gt;node);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (obj &amp;&amp; (obj-&gt;use &lt; 0))<o:p></o:p></p=
>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;RAS ERROR: Unbalance obj(%s)=
 use\n&quot;, obj-&gt;head.name);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;RAS ERROR: Unbalance obj(%s)=
 use\n&quot;, ras_block_str(obj-&gt;head.block));<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;/* make one obj and return it. */<o:p></o:p></=
p>
<p class=3D"MsoNormal">@@ -793,7 +792,6 @@ static int amdgpu_ras_enable_all=
_features(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D default_ras_type,<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sub_block_index =3D 0,<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(head.name, ras_block_str(i));<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bypass) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* bypass psp. vbios enab=
le ras for us.<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 471ffe885fdf..abc5710898e8 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -53,6 +53,9 @@ enum amdgpu_ras_block {<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; AMDGPU_RAS_BLOCK__LAST<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+extern const char *ras_block_string[];<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#define ras_block_str(i) (ras_block_string[i])<o:p>=
</o:p></p>
<p class=3D"MsoNormal">#define AMDGPU_RAS_BLOCK_COUNT AMDGPU_RAS_BLOCK__LAS=
T<o:p></o:p></p>
<p class=3D"MsoNormal">#define AMDGPU_RAS_BLOCK_MASK&nbsp;&nbsp; ((1ULL &lt=
;&lt; AMDGPU_RAS_BLOCK_COUNT) - 1)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -306,8 +309,6 @@ struct ras_common_if {<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block block;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_error_type type;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint32_t sub_block_index;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* block name */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char name[32];<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;struct amdgpu_ras {<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<o:p></o:p></p>
<p class=3D"MsoNormal">index de91d29c9d96..65debb65a5df 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -105,7 +105,6 @@ int amdgpu_sdma_ras_late_init(st=
ruct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ras_if-&gt;block =3D AMDG=
PU_RAS_BLOCK__SDMA;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ras_if-&gt;type =3D AMDGP=
U_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ras_if-&gt;sub_block_inde=
x =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;sdma.ras_if-&gt;name, &quot;=
sdma&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; fs_info.head =3D ih_info-&gt;head =3D *adev-&gt;sdma.r=
as_if;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 0c7c56a91b25..a90029ee9733 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -41,7 +41,6 @@ int amdgpu_umc_ras_late_init(struc=
t amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras_if-&gt;block =3D AMDGP=
U_RAS_BLOCK__UMC;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras_if-&gt;type =3D AMDGPU=
_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras_if-&gt;sub_block_index=
 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;umc.ras_if-&gt;name, &quot;u=
mc&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;umc.ras_if=
;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 258cf86b32f6..2e47bc446700 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -663,7 +663,6 @@ static int amdgpu_xgmi_ras_late_=
init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.ras_if-&gt;block =3D =
AMDGPU_RAS_BLOCK__XGMI_WAFL;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.ras_if-&gt;type =3D A=
MDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.ras_if-&gt;sub_block_=
index =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;gmc.xgmi.ras_if-&gt;name, &q=
uot;xgmi_wafl&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;gmc.xgmi.r=
as_if;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;gmc.xgmi.ras=
_if,<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c =
b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<o:p></o:p></p>
<p class=3D"MsoNormal">index cef929746739..1c94a14fc18d 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -372,13 +372,13 @@ static void nbio_v7_4_handle_r=
as_controller_intr_no_bifring(struct amdgpu_device<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &quot;errors detected in %s block, &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &quot;no user action is needed.\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; obj-&gt;err_data.ce_count,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;nbio.ras_if-&gt;name);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_blo=
ck_str(adev-&gt;nbio.ras_if-&gt;block));<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err_data.ue_count)<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&=
gt;dev, &quot;%ld uncorrectable hardware &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &quot;errors detected in %s block\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; obj-&gt;err_data.ue_count,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;nbio.ras_if-&gt;name);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_blo=
ck_str(adev-&gt;nbio.ras_if-&gt;block));<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;RAS =
controller interrupt triggered &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Candice<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB5226B1116ED425808F5AF312FBFA9BN9PR12MB5226namp_--
