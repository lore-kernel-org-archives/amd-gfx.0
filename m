Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0A6CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 13:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BEA10E062;
	Thu, 12 Oct 2023 13:14:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AB710E062
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 13:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMLE08TkLoqQcbmfWs5pOdFGJZhzh301fIY11YJ8Blt6VPQnsbNSOlFzyW3dGAVMIe5O6Jj4rlgD9TYsKE0cBBRSOcbygfcm6NzrIiU8AX/2Y27w7dFemelO8tZDIH1RutXP5TuscdEE1oNQ1zDvlbIO1TEJc6WW/OE89UyXn0ErLwLF5Hjn8/CuHd8rsS5s98etAokmpUr34oovgu2kM4yGkFboawWCsO4AMI1eMkNDxYLaZC7o/6bg6ssWnVVnjj9x7HWGA6aZ2+4sZAXQedg7TtqGEfwAiopimiR9WD2FY5WZK5gldjopN+oR+27lE8bKzBibVHjq4lcnh4xS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1jbktpZ1y4eO3p4K98dD4suzp8Dsgg6qXG/5mgm9OE=;
 b=gfjjrP4Cf5i1Db9eN5gPBpDibV7Yhyd0XQpiMV2+2MGRsR1iY06gRHT41WxjUwB0wqkQBcRTPaAaT8euLnV23vU9gXAWiWuKzdI8AtZ0/9vXwc3JriZ17CjFrOz2BUfX18SVsSXwwFXKngDCrYa//3GW7sqrjLFiiI2UOeWIHgDQXtx/7Xfxh4x2qm4l/eprUqhi9ASsmKMHxD0ixEJLIbYikem6OhCenPHzdjedNB0reDrkIb6Mtz24Why0yXp5K/imb3FRvsVMohsfB8QZjuZ2VBaf6qcSiu1PvWRT0eIQzjW+naL4QTH5TPn0/EyJrem4wD0DJu7UuzLOTUC5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1jbktpZ1y4eO3p4K98dD4suzp8Dsgg6qXG/5mgm9OE=;
 b=VZMvcOL2J4a+1f77Uk98jH5xvtEq4pXcesc92K9AChrZIlKlBHeORAUlG2LYnv8XzdPPLVr9t/Y9moRJ+e07ckIWvrGOD/is+uMLXOaS2qab2riZCZkVaiOCa4+CycPNN0X08BMhIC1YEO+Cm5K6rBltgAG+jGR9bSIQX7++tV4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:14:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 13:14:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, 
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions
Thread-Topic: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions
Thread-Index: AQHZ/OqnOCmdl7Zc00m5TFME+tEBI7BGIYQQ
Date: Thu, 12 Oct 2023 13:14:07 +0000
Message-ID: <BN9PR12MB525713DC934E04C624AF57BEFCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231012090034.31055-1-tao.zhou1@amd.com>
 <20231012090034.31055-4-tao.zhou1@amd.com>
In-Reply-To: <20231012090034.31055-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6d7afcc8-e2b4-4fce-9b7c-8fc882d5c31f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T13:11:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW6PR12MB9020:EE_
x-ms-office365-filtering-correlation-id: 39f49a34-10a0-45ed-2a12-08dbcb251dca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Voz4ffsZEUh0L8rG7NUlRMCCD8YO/U1g5Vgg2XaOIuDMHNlys0G9xBqwAKGQNySAqBtBrCfc2qq6X9oGDkujvNSL2DHYuKqkRDE7DMpM4xTJMUS4Kzxy3+Uipe55Ee7CRcDYIOIL0vveDDlZTbHtzyngRrOLozH1MhdiLBuqFPfRxNx13r+O1hpN7LcFay6ToeusBQwCMEYzX3QFXs6ikb9FOu+YRGaZaEIJeiPgvrQriKwnzuGHF6Qrvm9+KIz2zAgDHi53GYGW1cJxFJR9tpanX63YC9aFOXsp06ZE27HtJgozHcVRC/+U0oOREJ+v1cvhLuu0i68jUX1wPujepqcJdIuFfQGyFljvGsKGYRaj7C0+A6tugA0rtd/CSTzsXx7sArUbNFniZT82UJbcLDz1FMQJQVjVhisMxk3W4vPw4Kf69KDnHJ/4zfVds99Z00W76W5948PgpEFB9gjZEzvu+gS0oaYoJJG5OcrgGoKcPMRNd0HgpyZ1LNdeZuub5853Zl+inAu8Nf0cGJzzbizlX7jw8V7CoLns6i9m+Pfh661VhE1fetmRiHIKxIDi597jzft74ag+LGEJzIIVu3L8Wp85To1JuhrmpdZ/G2ANgXgp/JWPPAaZEWDsv+Y67sUgcGuA6+9tZjk4SdpFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(6506007)(7696005)(71200400001)(41300700001)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(478600001)(5660300002)(9686003)(83380400001)(52536014)(316002)(6636002)(38100700002)(8676002)(110136005)(55016003)(8936002)(122000001)(921005)(86362001)(33656002)(76116006)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N9xNgffckw9pNktA24s9qgpihB3S5t9Nx5qpATHtsP9mllLLN3FwNVT0yGbh?=
 =?us-ascii?Q?Gt+b1kFex4WGsfNeJqFbT62J6CkSQh/N+UkDwMuIADFeUvonm66px8C5IYTT?=
 =?us-ascii?Q?0tN/POAriz6hDKJ4lhWP40vl9bJYU+/dxj4CnYyB8nkIyPRJq4mimVQxqsvy?=
 =?us-ascii?Q?dlHzzDfNrgnMx6yF3We3in/XD+z2qFJy/qfiiSG2jbjZ7h2ifgXoAjOjoUQ8?=
 =?us-ascii?Q?3DCIq9UULx9Kxe5bnC4OFFoGExM6ChR+hzuENZglBjI5ne8X09S7f3IhLLRz?=
 =?us-ascii?Q?J9HYpOcFoFEJk8JCkoNhFVxnCgL88Yppz6wNZEsGBIsJzoLc6v1KniZue6Fh?=
 =?us-ascii?Q?WgoGoxRP19IzqYPNtIOhnFCI777sopu5qhF1fqGV6Lv9/Pc8AUuVaQT+hp1f?=
 =?us-ascii?Q?UQ/jDxm7l/tMH5ec7pZMMsr3h71dqrN9hIaQG5KsiUJC/Ev6MgnDHXR+qNma?=
 =?us-ascii?Q?4t1Fos+WoVJdcBYyRK6am96r7wWezfBDytFXZT6rXT5nEF17HDAtxgcY/5q2?=
 =?us-ascii?Q?s4K3swXziq6L3T5DuLfwhdsbPf3SScxrbDalxc652r2x3tHq95XMwqWggAqV?=
 =?us-ascii?Q?n05gFsXev4wevT8/R4PL9v/8z+o0aWWdSlY8eTqh8iYXcplmd5LCuP/HsQS2?=
 =?us-ascii?Q?4s8jGD1ZcGYShBzr9iRTkF0jaRqHeIV4tHXxIjyDNB8zm7pPoRB9wphGaPWM?=
 =?us-ascii?Q?c7iXv/7kK2fF9v7veftbdVy5j3/RY0dccTtafpRN8pb7H7x3+RxlIYiBUkrI?=
 =?us-ascii?Q?FSGT421scFQkwCtyvCMt7tkAfMPEDmESttn2Fnsb98/BkVHLb6U1vKoJHdMi?=
 =?us-ascii?Q?q+Hr2XDx+CMOmnuoq5pn917FSZtHDpNK4EwklMQ4nLFPEYmG8hfwSYp9CgKK?=
 =?us-ascii?Q?mJOyUkm2nXjyip6sBZ28Y2AnKj8gDJGUv6A5bfcUCofPdlv/3eWRBXoj4et3?=
 =?us-ascii?Q?5g6lr1rbAyJbwIVJonhiUg9Vb9WwpzX3UtGO7MXRxD7rJgeBsC5pQABpe5o3?=
 =?us-ascii?Q?qcLfSu4ByokXpETAO+N/IGe6L6lVVsum6QxIgpnv8HC/iTWr5OqEw3aqgkAn?=
 =?us-ascii?Q?Hy3dySEXYNLbJlst85bda8nJsgSLFjeOOmqvoEL+o/7H5w3re+d4DnC/zDC/?=
 =?us-ascii?Q?RgfFrI6DLgkoYz3m1TTZF3PGjCE5YrLmiFbidgSrrnpCixwZIJkt8om4jx2a?=
 =?us-ascii?Q?5cfXvsfrtb0jho5nILpNSmyg9nMkykP3Z/rdkYEgKLNvBWTNgt8jiMxtVPeY?=
 =?us-ascii?Q?A+i4ZQmNQVpAzs0h1T7W3QYq6Gnd+TRNsUcW/84+mJRyF6ibS9hGqiaEzNWL?=
 =?us-ascii?Q?wc7QScviLOHrcOE2hy3lcAEX5iBohK9TJdEX+5Pp8EBFFYwjwtYWetoXszqe?=
 =?us-ascii?Q?VzEM34eCBmK9pqK+joJO1Fb2f5HAPa+V1SVcB/HFHmUhxRz17Z1bA+Ix2aYL?=
 =?us-ascii?Q?pdhmfLYl/m8qCKncyM2Y4mMKqDopxA6Wv7Z9CKoYaez84X+a7yYEnKbCvyD1?=
 =?us-ascii?Q?Giw4PMUepl2rqotjHj/MGw8IxGxOKBGsNQnyRWS2QeU3m2+8xs+GHV822w?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f49a34-10a0-45ed-2a12-08dbcb251dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 13:14:07.6822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6YkTXMKMRdbarxzn3cdPXDz1Bgo0pgcqF0ZeaQspf+cNuWcrrhR5UYqIokgrwBI0tyAT7nNRgBskzmifCgvFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
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

[AMD Official Use Only - General]

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;

We should check RAS in_recovery flag in such case. Reset domain is locked i=
n relative late phase, at least *after* error counter harvest. Please doubl=
e check.

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, October 12, 2023 17:01
To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Zh=
ang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions

PMFW is responsible for RAS error reset in some conditions, driver can skip=
 the operation.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 91ed4fd96ee1..6dddb0423411 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1105,11 +1105,18 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devi=
ce *adev,
                enum amdgpu_ras_block block)
 {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
+       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;

        if (!block_obj || !block_obj->hw_ops)
                return 0;

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;
+
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_get_mca_debug_mode(adev))
                return 0;

        if (block_obj->hw_ops->reset_ras_error_count)
@@ -1122,6 +1129,7 @@ int amdgpu_ras_reset_error_status(struct amdgpu_devic=
e *adev,
                enum amdgpu_ras_block block)
 {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
+       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;

        if (!block_obj || !block_obj->hw_ops) {
                dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",=
 @@ -1129,7 +1137,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_dev=
ice *adev,
                return 0;
        }

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;
+
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_get_mca_debug_mode(adev))
                return 0;

        if (block_obj->hw_ops->reset_ras_error_count)
--
2.35.1

