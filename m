Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D132CC433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  1 May 2022 02:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575F210E511;
	Sun,  1 May 2022 02:12:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBF610E3DC
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 May 2022 02:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d16z/+txckJ04AsK5gaO+nsPa7AOmzPl4n3lgfk2cVzUcCwuo1Gw+/26TkVBiONY/kYRCKjojbxFG5ZszLml8FjFFPeta+lnQprZgFS3qywj0LKrUpYKw2FYyB8+dtkimoWsp6Emh32tL+jeWC+yjudhUsg5aq75lK7YrAKCnu/Z2vQiWKqKamRiCym1cOKCS5oyFLQfgNqSoq3GCMr4ivN4ekzK66JncTrA6iiRQ3IRWKUJCuf4R11J74Ki/o84V5/CaQ/nJiwBXQU7d99yBlghYZdvY4ghasCaREAkId92zPf18H+d62iJjqVB73fP4E+rZco8lz4JaYr2JsNoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs4EHsKPO41jUZdpIAUFaHlmYfmeksRPmKz3IXyMJTQ=;
 b=HrRhBVg6aRnP2bZEDj7c8xhLfDKukZrFvJ/KdXjPXflp0nIzQMJy2vDAA4aLQkjL0ZKEXbof2kweYkBsofoLVazN79M8yb64lGiBHurBN0S/UeECng3c3OiGSOa2yyPi2kDXxcBZhguul8SogyR84oP7kFXjBuc8ky4k37Lcd6oBKHd3I2R+gKSBr2GJldAjBvCSnqYaB24ClIXjpAO2aJYPdgaT1YECxwRKQNk4dZ1WigFGNyi9gYflqnwuvBtBSaSCS1WxCXZG4hb6qH33H9jO7DzDSeRnC2Lkg0nV1++IU0y9Li4fQI6n+VVRGyRi88rVWP5XGNXhqajsb/e3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs4EHsKPO41jUZdpIAUFaHlmYfmeksRPmKz3IXyMJTQ=;
 b=i6EHUqXrpRzMSZbzOTujlXAWE3JJVaNg7OI78MlUKdCnuEXxT3keSyUQisDNGbjrRHCZHi1C1ghLZvGleXKPCsVjVELtENmPtalE0M/SIaAAT+wntlQKivqtHmhiGz9/hW+ex9ndKmcgpFjZjROBLaAV2DLuT/D4qHbYWKBkzGU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY4PR12MB1607.namprd12.prod.outlook.com (2603:10b6:910:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sun, 1 May
 2022 02:12:46 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5206.013; Sun, 1 May 2022
 02:12:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/discovery: Set GC family for GC 11.0 IP
Thread-Topic: [PATCH 2/2] drm/amdgpu/discovery: Set GC family for GC 11.0 IP
Thread-Index: AQHYW+8i4LRLH+J05kWSgpWtSubMAq0JSfDQ
Date: Sun, 1 May 2022 02:12:46 +0000
Message-ID: <BN9PR12MB52573AA9CC5956279C411215FCFE9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220429173218.433113-1-alexander.deucher@amd.com>
 <20220429173218.433113-2-alexander.deucher@amd.com>
In-Reply-To: <20220429173218.433113-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1d61a28a-8214-4c72-8375-5d38d7f022e5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-01T02:12:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b78ba4d-d884-40fe-2617-08da2b181574
x-ms-traffictypediagnostic: CY4PR12MB1607:EE_
x-microsoft-antispam-prvs: <CY4PR12MB16079944421270CB984EC7D0FCFE9@CY4PR12MB1607.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VmL0XcSy708zI/SstUkt5FmdpWqRNRcTYDUOqtx4S4gD8xepGVWZgYk8c0T9Ybml2B85by6re1WcBVr7aooiXE8fOcY6pWiP1UjA6utfntdwQnOkUFYTL3MPmlFi3hiIT/K18YCtTlRsMGCn5IU0IX+3K62ARF+Ie71dUDLm7PbWx+ODI5qA7e5IjWFHwpcSIUJ+TEvJeJn4GzKaexsATZpuPsxSy9uzN9gPxdgnjKaPcECaweekl2fgOHKQ4fuldX3aUiXFUJ/3fXTfAZbHEzjcEBV02Wft7rp13rRSU52RCt5Dzkk2VySVR1m4A88fVQ8X1l8Gs/pFydMcoXuyBdQ1+m/0lij98yfK7F+OkcYwAU0ZH8D4aQy1ooriuMQ0EgY+2aGYytLGzKhObT+2xo6E7bVXxYleFY40JVO72Sd3UjtbnOF8X6Lg2EOFc+hZGXMiI+2vNGA64WvhvA/t4USKblo49AYAn/bZn5YOh1FRGC6oW8fo1ICpUotdLSwd/Q+Y2qkyP69d0b3sqtW14P6bkJ6DHzDGEyzNPpCZo8RQZPnYn7TDVtpMEkEe95024agtg2eo+YiJpgpcuT2Aco1l0RZymu/7zN64GdHNRpywJ0O/PGAyqAbFIjovKBwpc+G1xk2/DU0b63ZobMeTv/ItpimjUr/fT9NKzT+KL+TW/fLexicxQs5roTQgE14OkdUUq3eCioDI/60u+Xks9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(66476007)(64756008)(316002)(66556008)(66446008)(76116006)(66946007)(8676002)(4326008)(53546011)(508600001)(26005)(38100700002)(71200400001)(6506007)(38070700005)(186003)(9686003)(7696005)(122000001)(54906003)(110136005)(33656002)(83380400001)(8936002)(5660300002)(52536014)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OeZ0fyqt9OTDaYL2OwPA9iPh+uEqOLFqJjBbl6YDz3W+1qOrNJV+vx0H/Ogp?=
 =?us-ascii?Q?J14m91BKvzPs9B3NpT2mp6Hcn7tuNCX69o4RKTOXrqAsolQrZx56JZvWQHsJ?=
 =?us-ascii?Q?mTtaC9BGj1O5c6fMyEHMgjLCLtXSUPCqHU6cTY7+Lhwk5h681bVnYiJE75Mn?=
 =?us-ascii?Q?a5m+bGIoXZlghS3xBWegd3+bC/8w9XK6vE4HQfhLKz/mRe8q2EHl74ZsFY6o?=
 =?us-ascii?Q?c5PzDKAQq3Vum57drjxReS9WgMm8G5OpHWiJAp13HvIr9zZOtrcV7GEp5fFH?=
 =?us-ascii?Q?UCoNI50t1jbg5wdTwUQNGjgAuBuR31wxvNbS52xchoB2eRxwI6TSV/1rT+KF?=
 =?us-ascii?Q?AvbOYjCymyk16wVWey3UZFNEQtJ6n9sFh+CuWgAD+LfwZbDpm1Xi/hd9/rBn?=
 =?us-ascii?Q?z5+AX2IpEHZ0BsNU+AH6GmBdeTnGr64kgd3y58GvohpyLjX8euFF+Vyhtq+o?=
 =?us-ascii?Q?YHIh+fqRMThhJjbezggyMdwFGiXbKN6bDU0ehFB5pf3LBoqj7tK1jsvYY2Ps?=
 =?us-ascii?Q?RYz6c6cSTGumYKOpYa7Hn2a/If9yAnNkhdy7vOxXxaGFhcoeWZyhvp5sOHEE?=
 =?us-ascii?Q?WS4Lq6RrSaIeV85ePwuIXPiWcXLMi+y9DIx3h/VS3Gu0vWgL7pIUhY3Vn0BJ?=
 =?us-ascii?Q?Ez59DwmYtCCGIIVpjyRcBJyzBCKr6RPRB6tnEbdb1NUSfdOtD8rgfO+GO3f+?=
 =?us-ascii?Q?uwmylfiiRtAEZk8ZNaNYPGFuggF0SaGUnhG2kncDOeZ9kEfkSrqgN0poLcLp?=
 =?us-ascii?Q?hVKCC51kaz9kJtmwrtH5WIkrfOsB5489TCczWzqVO1ejVCb9qN2l7ntrg4eX?=
 =?us-ascii?Q?Eqe5dZp0hx0DlqoVgX9e/PSj9KssWbX3dvxuixMlmsZYmc8CF3m2frSd8+hp?=
 =?us-ascii?Q?XPBQor25+t0kcm/w2Pu2QE6NN2ofvnFh2EjwjE+Ht0hwrGC3qIjTIs1Xx6E+?=
 =?us-ascii?Q?gSiUABgkPQN2dJzVif9Vd+TI5J03xuV+fO/DbUeEMBDFGKDOSrf85NPsd2G2?=
 =?us-ascii?Q?fL7E7qEYsc7EB9bSWJkL9SaiJot8YhRsLV6XF1t63dzVxmKhEQZfnBMDve5V?=
 =?us-ascii?Q?stKh/yO4XQJT+kD6ah+k4Xbcn0bOsFJq8uGzzcOIjyVzCnN7CvHbIqN1Q9yC?=
 =?us-ascii?Q?ENSRkbZHtDr0JKny5WRATLWrpaOnfv7LYaC6SDgyGxbZm28SPusH66OOdpJC?=
 =?us-ascii?Q?c7lHMKfPEjAs6ysy2wj0X7RWvO/4R6Z8U1FRdVubNK/mDmxCiPDgfZvBQBCZ?=
 =?us-ascii?Q?ZWuHN91FKMS98PwrQEmIe0G2Ca+5whnybwZucmnlC+tQk/htVFzr7V2f5xmv?=
 =?us-ascii?Q?305W/xDJIzghEH0t33V5DjXa/5nhOFTBopPQ0IROp9aIVud3QM3fFHOaN/uX?=
 =?us-ascii?Q?BdJeeH37AAcgSFpY7CELtpkv8dF4XDtSgu+PQcLhbeQwAACuFfpCaRLrsABk?=
 =?us-ascii?Q?PTGZp6A2wU0zoNXaZ8YqsdOpJZfTtwGcs07bEQLsTLG4j/R/TaGbyp6GpPS4?=
 =?us-ascii?Q?38K1T7iPYo9yid93JhGmp811o+6fRmM2L24/Bn+68/FvJRNv/Uuj00WSUM3y?=
 =?us-ascii?Q?/nH2evwYkQU1Bmpg1NX15uRrb4fKJaEWuW3LhgFg6gZ7BBbAQiAK8MEaYi9/?=
 =?us-ascii?Q?R3NjJzI+94XHCgh7IxyX0XIz9x+hXng4XikVxBPm4V700DsR1sOkA9jpTiWW?=
 =?us-ascii?Q?WFpElnTIpnJx5bNjAWOqHGGNt5c4M27W+GTD51uHjeGy43372PKX6fK8+s27?=
 =?us-ascii?Q?JBIoZyj1sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b78ba4d-d884-40fe-2617-08da2b181574
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 02:12:46.5020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkEkO2LUGp+8I5+3bMFEgAGaBcWgN4Bfk98JjibRo9QE13qG98HzCQkqMbhlM41hl0x62EspzZPYyYCXALp23g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, April 30, 2022 01:32
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gao, Likun <Likun.Gao@a=
md.com>
Subject: [PATCH 2/2] drm/amdgpu/discovery: Set GC family for GC 11.0 IP

From: Likun Gao <Likun.Gao@amd.com>

Set GC family for GC 11.0 IPs.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 2349617efeee..9c177ccc7ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2090,6 +2090,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
        case IP_VERSION(10, 3, 7):
                adev->family =3D AMDGPU_FAMILY_GC_10_3_7;
                break;
+       case IP_VERSION(11, 0, 0):
+               adev->family =3D AMDGPU_FAMILY_GC_11_0_0;
+               break;
        default:
                return -EINVAL;
        }
--
2.35.1

