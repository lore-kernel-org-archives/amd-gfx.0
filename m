Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB609C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 15:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2502910E234;
	Tue, 15 Feb 2022 15:54:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3426210E234
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 15:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIYtkChcNwXdiRP6RKhgThrHAMG71X9tY7UHBJO6BU+PNr0TOHyF+tstfzCAOdL3KyQ+tWC7cSmS3DURPUWNwslBtcWbJl6JrHuRcbJNs7vbPLc+kye1Q2g7luO+v/nj+9DVo5Hx981u1wRfC/KlHHp+h41UuMpk2RogE7cyto1MkK9sY+PuCJCMn+vRLG8Vmo4xxY4p4bKWyxcwTAHEmlJSro3TgHpZYS03xaRkxiPORCDJrITY5+W9fENsiX6rhCGunqNiioM8ttceIQlnY7F3WVUxqvL6sT0cerb9EG7Oj4O6hYVLlWUSeSKmE4uiAURk+Q6OtHip1AwHPXEA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Av90+boHlsJHi9qWA9HVI6WjuH0fKqHjr6RRNnqMA6A=;
 b=BtoLrJN0TzpTidwRivz3NrZFKw3xXvKEZX9y7Ea9IeVW8tDWT2NLPabOhxlF28G7HYeQeXLChhDyVs9h95mEZl0eYlZqLrULf8CjtVx1L56HuSWjDy5i7tqdtDUvHFzD+5V6h8p+xVNLi7+SnP7KvfFWECMNF4EqtJYZKbIcKH/FRHjNQMg498dGJv0udhxZVgBt5wV51I/VyVNKtMumkFxW8cy1R4mHeFCZE9e99zj4ZoXRrVdbOAaqmsRrCqBaYJvP8tSqORgoi1nuVfxk63Ld3RoVeknEb2MSs3f2Wb4Lg2HhAicbMwRPIMcQtZSWG6/lNVfgKVUHwVfbcNpFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Av90+boHlsJHi9qWA9HVI6WjuH0fKqHjr6RRNnqMA6A=;
 b=OUp9l5cvnqLjEbS6BP9nu1l1xVsnvvEc4BYVIFaOCNJR9l+tnNPn2Iw4UJwnfzh5MHX50MMbQrQKOsMINGFY9Q0cMqeFG7/vxMZcsyxx7Li8J2uTaoRtNNbViYodzXZzKEFEuDp4iozWgoT1TbJT3eRtVSOIKIuEZar1sfkIWvU=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 15:54:02 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::b0f4:49d3:af0a:4ebd]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::b0f4:49d3:af0a:4ebd%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 15:54:02 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix wait for RLCG command completion
Thread-Topic: [PATCH] drm/amdgpu: Fix wait for RLCG command completion
Thread-Index: AQHYGUSqsBP5WgyYTkSEju6NEcn/E6yTm54AgAE6NVA=
Date: Tue, 15 Feb 2022 15:54:02 +0000
Message-ID: <BN9PR12MB5324CD23FDB86F765A3DE12E8B349@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20220203212525.12738-1-victor.skvortsov@amd.com>
 <MN2PR12MB29570E798C089D8BCDBEF3ADF4339@MN2PR12MB2957.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB29570E798C089D8BCDBEF3ADF4339@MN2PR12MB2957.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-14T21:08:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7f65bd2e-5151-4039-8183-af86cb5a44ab;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-15T15:53:58Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9bb87676-6f97-4693-a5de-78a72e76d35d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf0b89f8-94eb-4d05-67e5-08d9f09b6331
x-ms-traffictypediagnostic: DM6PR12MB4386:EE_
x-microsoft-antispam-prvs: <DM6PR12MB438654A8055643751A59B15E8B349@DM6PR12MB4386.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kQ0ywX1PbCdSzOJp13JcqdjQgYQk7QZX1Etvb0S/W2Bf8e5UTEXKsKeJiT/QmNVdrLq7tWwA3ecXQN12ipWHdMvG7juGKbu6X8HPIA98ANAxFUKqwTVNvxMBPcJ477ueSjhBqXWXE7JvwQbgnhsU5FnjLZ771yPTjCc9Ckxrmhp2kqFwe95ONQKEvs/GF/NmiT/1NsK7nT9ERgsKHyp1FSCTAgEUQ1uGghZUH7kh9JVBIT8O0+zlRdcJKo8qjmPm2U30iVVlUQ7Cvyg9xFx0hnzEB54NBm2gwqcpojZf15G/ETqyMmZuZVUaC8Cbcb6HL6NOUoTsutinSy0xh/FbmeDQI2jXqd4bqREg9JZup/xA4u70G8464uDomr+fTfQ4ewFP1rXedZuv+7kedkuHTljxBZDHQ1qpCU8jpWxQuJKW6ka4dD3T6yTOYVIMHeB35qVYHdCQu/wpj4GZr9CrM+UZvc7n2fNd93Sa63qMyY28qHeNCaZo4oTZgRCCM/qbd6dd+HHzOouqgCVDAI0DRSuvEWh2R466RW+8M+eb0ZIb4t0RzH78eub9Nx/DzzpCouapRF+r0tzFLt/Vqwmz+oPGp4AX/J5I33RU59+nSrn7E2r4dDXZ1uIJQrG7jU8ZVB6rkEtQX5MIv1lv1quqJgadazvf9C3MyV3lOpz6xNNn55ZouB+mip4f3wzYJNRY6UMcG/ksr7bq5us0yXFQog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(33656002)(8676002)(26005)(6636002)(316002)(508600001)(66556008)(76116006)(66476007)(66446008)(64756008)(186003)(71200400001)(5660300002)(66946007)(83380400001)(2906002)(7696005)(38070700005)(86362001)(52536014)(53546011)(55016003)(9686003)(6506007)(38100700002)(122000001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zFLi/jhxldVyYhAwUzRvX2YqTYW1TeYk61s+UlLc3XV8QCOoKog7AeoKYbA4?=
 =?us-ascii?Q?QMoVlyGXRhH8oEY72wzOV2Lo7O5D0XCKKLmw/yXWU1f0fduMb67GGeCDNuSA?=
 =?us-ascii?Q?PtmvQ7K3EOQcD8MegFs5sa8Qg6UyLfkZbNi+dAlLSF/ZuigAVaFqHSPrEU6n?=
 =?us-ascii?Q?3uQok4cGNCKhPl4YrKONtrn312d75klJaxh6dqBGKN+y7D6aE7h6nCB1g/0R?=
 =?us-ascii?Q?oAU4qSaZWVRYnJ42WwkIvjmqeUe4x6wr360vywI0eUFRbwoVJV5M41dR5JoT?=
 =?us-ascii?Q?+ODMCmW1aOE0dz45/vAckdyx7Vl2CT4tCq0+6LAGvvNfBlAW3V2mYvkIxOMS?=
 =?us-ascii?Q?3driIuDR6PU7wQhMTXKxqNrFheDujE8PW7ddKzP5mFad9i/KeCSKvLEfNkfl?=
 =?us-ascii?Q?wUqLCn/7hOUtw60SR7EiUD00vFNhUxyh6bN6ZWdFUqHPyLR6teMaxJwQnoDq?=
 =?us-ascii?Q?QVxahZpU/k9FkdPXRoVyX0Y4md5DVd5e/avLsaqjcM5j1qHWORUtTlFwm6ml?=
 =?us-ascii?Q?ulnGQA+5awPiIIqQqF1LpquUFDx+0zdIaTc043eNIl/vTNCr/rPQEG0+6QIm?=
 =?us-ascii?Q?YBeGbBnLU9CUPfbFhB2OflST89Cdjd+cSRFq0AwAxw38SYkG0Km/JcsC8bL8?=
 =?us-ascii?Q?8yDRNpW9ErV+9mTiL7jKkGGRpD1W1gjNUffjHOgiAfv/sBdwShb4uXv6+42F?=
 =?us-ascii?Q?miIuZwxxQoL3LcO+TWGXcUWDPheENIXAx+VuFUX8l+v9vxDj8fcWKf22UpRg?=
 =?us-ascii?Q?O7H1jXeKzdaGh1XaCj7eXJxCI4UhoonYBvOL/EnAXluoCkIioeIh5sGTkpYJ?=
 =?us-ascii?Q?R4zMAe8yqsx4NpODJ7OUhju5PgxO7OaTQsVnQFyHNdK9HQFJLuOv4Ap7FSOa?=
 =?us-ascii?Q?uz5yRvudWWaof3C69PS6LIKUNJz6D+FDuw8nqlIbAcC9YL3Mon/3INo6xgNb?=
 =?us-ascii?Q?9r99qyvwCj7JNEGU5qQaJDYuaOuwtv1k0UcCK9/BftAfBkVb1gSHip+3S7WM?=
 =?us-ascii?Q?RLUJHtcPxt3JPHvyhLOm0PD3/49/ghL9nFJcgWZn2FthCx3zc1Fd+bjY25Ob?=
 =?us-ascii?Q?p3AdocFr+CE8+hh4CHbdKQNgTFjXzH0YIuXvlbkRXXTsyKrIoYiriPBg+/fE?=
 =?us-ascii?Q?dSv8cOwh6T/wSS83gCZZS5bhqrTu4qib5HLBkDvOoI7KjhBVt+n/VMwFIv2q?=
 =?us-ascii?Q?n7iDW2hfgapI7vwmdfmzHRrC909aazK8eEWQzupGJ+6p2M1kBpLj2wF6Hzg/?=
 =?us-ascii?Q?c9V+gF5JFyEXW57i/g8JP0Y2ZtFWb8lUPZ3qRxtCMx+4jsmSHD5aRJlgSsWp?=
 =?us-ascii?Q?OGnTMGtCa+lUJeUKQuMJxHtEEkdDuaF70ea3VBa/bg521jpCuVEtBPDXzRAa?=
 =?us-ascii?Q?z/nGOihVifDU42uV37Yf2MDNCK6Gd7YEW46IKan2T/icbpTF23DcR5v7jFfp?=
 =?us-ascii?Q?vsIoR9HTvh+HNoMGpfcxZL78JpKdNi3WHSD3tQwxRqfytvwNEzSvdtLtjwmn?=
 =?us-ascii?Q?1IHnxsQPZ2mPygDsWSMl5kmDiWVwJN7EyZW1G8p6A7FkFyYCnv+v2T536eBN?=
 =?us-ascii?Q?WIsyP+fttiJNop8j7gg+q5LrKGFatmQOZK2o7HVxjo/8nu8hYjxVmlR/hR65?=
 =?us-ascii?Q?mYPk2Z253vlKAbazfSKJBjo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0b89f8-94eb-4d05-67e5-08d9f09b6331
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 15:54:02.3477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixq0XtLk3I1GozYiH9gKFVY0iTW4Bg/gyyETbR6DW4Sy8EpB6IaMiQ9UAo0ffcOxyfXsQlL0No0wVhLZvJU2aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
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

+Shaoyun

-----Original Message-----
From: Zhang, Bokun <Bokun.Zhang@amd.com>=20
Sent: Monday, February 14, 2022 4:09 PM
To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; amd-gfx@lists.freedesktop=
.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix wait for RLCG command completion

[AMD Official Use Only]

Tested-by: Bokun Zhang <bokun.zhang@amd.com>

The test configuration is 8VF with 100 loops of VM reboot.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Thursday, February 3, 2022 4:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Fix wait for RLCG command completion

if (!(tmp & flag)) condition will always evaluate to true when the flag is =
0x0 (AMDGPU_RLCG_GC_WRITE). Instead check that address bits are cleared to =
determine whether the command is complete.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_virt.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..a8babe3bccb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -902,7 +902,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device=
 *adev, u32 offset, u32 v
=20
 		for (i =3D 0; i < timeout; i++) {
 			tmp =3D readl(scratch_reg1);
-			if (!(tmp & flag))
+			if (!(tmp & AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK))
 				break;
 			udelay(10);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 40803aab136f..68f592f0e992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -43,6 +43,8 @@
 #define AMDGPU_RLCG_WRONG_OPERATION_TYPE	0x2000000
 #define AMDGPU_RLCG_REG_NOT_IN_RANGE		0x1000000
=20
+#define AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK	0xFFFFF
+
 /* all asic after AI use this offset */  #define mmRCC_IOV_FUNC_IDENTIFIER=
 0xDE5
 /* tonga/fiji use this offset */
--
2.25.1
