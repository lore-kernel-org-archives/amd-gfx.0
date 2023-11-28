Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044DDC4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 02:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D092810E415;
	Tue, 28 Nov 2023 02:55:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D50410E415
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 02:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKo4Z3t1fdE1Bx5KLbf22uUtoRumppLMUQyAMTLUaHtVzmLNglF5Xfsq513YQe4GeMhrRq/BAUPAGsLlxEkPSkES7IKGIDMJ7abTkbsQ1eg1uI+vyh/W+yYsr+BbSTi/QhilhJsg6huPtHj3WDphfZfNuZVTxad5wAIwT8+vQyyT9MICcfz7Arl+jU69Qp2nMYTnekfjffaiuAVUtGde6ADXgkbIOHdTfIq9c1uyqjT5rLB44y8iUO+suwu/PY1epZR54tHeczKz51kAL754EICR5PU0AKf2aW6U7m+R9AO1sNcYTDA+Dpf81P7op0c8+ShGvPzWxBmWVChyoG7SOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx3oeyGnR1WuYOA44dXDk6bfxBlbBKNSnkPNNp6/KBY=;
 b=VvNSWvRVUoWltvjYML2hIMI8+ho9F1asd+w4RFi9/9zWq4ENrSu1V3L9WGvNPbywu3whmX7VPaDC4tFguxry53LrGcIW6Qomj+O1MoDUD28irFxl/OXkzXsuXRp6Awl0FCjWtPbQvbUaTuJr/2KUpL2B5oXZRJrYCFE7pOHymv6svjp3ssaQacu6oUj5i9/ZmtbBqX0jCw27Af7st6MXhqrtcjtD/yj8Yp7yevtqc2wT/nguWrKzoB+qysI8VgR6QeZQwnTZDzN0keit9j4OtuTo2Kcq/+PVcyGmKQZvGAbEMu0LL4LGzSMaE79e9jPCQiSKmP2FBJX+FwMlapwMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx3oeyGnR1WuYOA44dXDk6bfxBlbBKNSnkPNNp6/KBY=;
 b=hbthO0Dp/WGcz3roqwXMM2pdObR24paBrxV9WvkTWX6CBxb9iN2cKYccMj5jLfaR1VbMvCAVoCkmO6G4Erp8e+dLSUjovZj4tzUEVByTsCv3RWwoLaa3jn0SlluxOLb2iGf0unNsp5XGvzCQgvEW+eIHQWc02XEX21Ukk0VtZ+g=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 02:55:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 02:55:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Fix uninitialized return value
Thread-Topic: [PATCH v2] drm/amdgpu: Fix uninitialized return value
Thread-Index: AQHaIWOcrjRKAKQ3Bkul5hl+1xbBrrCPCcYA
Date: Tue, 28 Nov 2023 02:55:19 +0000
Message-ID: <BN9PR12MB525747DE1132159C70C528FDFCBCA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231127185615.1110293-1-lijo.lazar@amd.com>
In-Reply-To: <20231127185615.1110293-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e55e91ff-4516-4e02-b5dd-10bf4a75cba7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-28T02:55:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6038:EE_
x-ms-office365-filtering-correlation-id: ad2ef04c-2840-47f9-fe1a-08dbefbd754e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSDnPX2Ysg+4TmHe4fIokSQio42tBeFhi8F4Fm7XQ5SCX/06vZORCScCMitGJTItML3vn4yeoJW4CmNNRYEGOoylInKb9860z3+9ngMLYEEOa4y9iRXcGuHXpdUtQSP+2021AVXxEXdtuJYbTSKP7H30FszVVTJeGsuabjtwwfmSIDPeQNHfmUABNbxVFyYajcXZbCoOamjUwI5B6YbDpgx9HY0MlxtZwvvO1P49eSvRPGFTbHKp7sIOpoVFyGTRSSoufvyxiOfGiP0YD+NBQRBI07KT/bZq9mZFYrDt5AsX6iRFddk/R9giib0Tycdc90bKjW4ceBOOINuIFcAqDKBj/RzwsOGLZzVkvDtzASLY97b09zIyKj3PTTFI3JfnWfA77fLa4R++ZxPHHnA4BYmHOCvWZGSBA01+wFN4K3i6AXh1UfKID1kqvab4nAUKlhiiqGLIozuQmbH0StE+gD5u5lVm2etvb1/z8qAZC3hp/XyQb8mtF14ACOteeuwxaCSH0w9liLdQRylhOYuORM4vCxJGOaCgrBdQ7y6Odiq++BetLyhAHWTbWupzNLK6fGhUB32wScweJ1uidVl6GqK72EgvQRq7Xg5jHldh3LE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(53546011)(7696005)(478600001)(9686003)(6506007)(71200400001)(38100700002)(86362001)(38070700009)(33656002)(122000001)(41300700001)(2906002)(5660300002)(76116006)(66946007)(83380400001)(64756008)(4326008)(316002)(110136005)(66476007)(66556008)(8936002)(8676002)(52536014)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4tZ2fODOADn04TvgvwpXN8UJX6CKiFyx4buKdzvEDkdzDS6zn5QwmVN4a8iE?=
 =?us-ascii?Q?X6cpCpiP+V71J2LaRd7TAHtKBfCTlQF2Ww6mtT9QmHVu/IaNSU24rKTsa0E9?=
 =?us-ascii?Q?hZfqb5G24zCUV7gIAmw99/VDt64y/Ucg6IzM5PxQWARUEZs/vJb5x3LAr3yA?=
 =?us-ascii?Q?E3P/4KH4cr/BnFk+5Cqr1/2E1hl4sEwU5iHloq6fUhsGZMeaL2bM0uuk4WT+?=
 =?us-ascii?Q?DIq1TCJJcT1oyRNkIZxlEA/aBLnj+Ttzju2qUZlXEkz/1/fL1XLmbv3NI76y?=
 =?us-ascii?Q?S2nkJBukGxxENH0bG5apQm6PCi0bw+15n400Nt1EnS5xEsattAFpPwU4KhDm?=
 =?us-ascii?Q?SWydd3sC7g81bfWVq6VjtMVBhGpV5n8g/076iuJVz4F1jynvEHSXNbf8WAOB?=
 =?us-ascii?Q?4LEdCzF6EiPB2Rekd6mKSahU2LDOEFOEKrGl2SlmbP4cGhiKpVVm9zx++JuG?=
 =?us-ascii?Q?Zreg5sF6vZ0NBrtBeMJuVLspude7r3rpwjPr+TQqKDcxwoUIVggF4SyigNzM?=
 =?us-ascii?Q?DzUH7f0bjfZRDRouIgiEM55p83ehrhk5v+64dZgTEfRdLZGHKZePpvgpBERq?=
 =?us-ascii?Q?hQA+l8QIKYn+sY3HFGyh0vDG/GRnv+PpSoLrn4eCYue5F4dX8SpxIXmBG4fG?=
 =?us-ascii?Q?EA44MaCUR9JGcsMSgXr2WtmyG0rFdsUJ4pfNZrOmdFOEDui5Z9nepN4D2CK2?=
 =?us-ascii?Q?yb1CXL1Bg3kNF/UtHrak2NojxchTAYsoIJRsDLBBOyDFwmx1TNJ4Dh7C+ogg?=
 =?us-ascii?Q?KXC6I/iV9otlcspxZzKL6MVD3euJXGv+0TqHaJ/rMxBOa6fZpVYPwhK2nYK2?=
 =?us-ascii?Q?RxWf6gcXIKSCkHrfO/Nnr1+8+bbk+P5D9YJdeMWQ5mS8aTOZXV+nT/nyc9iN?=
 =?us-ascii?Q?CqkNgMehIkG9nbesoNIsjiqMoqhMOspLtYU4OFZlASO1GLqWRgxU3h43lvBW?=
 =?us-ascii?Q?RofQKW2oWBlahmKGIOvOHBRd9aJswX6xCgAtD5zBGViXRKlk0Dl1005kdCr6?=
 =?us-ascii?Q?6zJkOe4YYBa9VJ9NSWR6vrOINb5oTsQH83nbheqOVU4fMS8rwpcZqD+Io2K0?=
 =?us-ascii?Q?HX94CLZYZURtWXrUdAVlWGoFKJtWwtBDUoLQJBUVU5uwSf6bhN9Br9w5cOWJ?=
 =?us-ascii?Q?j47UjerfEr5C86/yHhHHZF6oklYPLr7eeFliffVWOJlojYL6x8Pj7wcPNwK2?=
 =?us-ascii?Q?7NWI1HUeDrMYb6JGqhp6JUrihkaE/ImgteqJQS5YglKrJy1LTBYmXxm8taZI?=
 =?us-ascii?Q?iTOkSWGsZJIbPbVQEqRrQA3H76qW4FRWGpWXLxP6YpOn3eCDJ6r8EGetQWk0?=
 =?us-ascii?Q?59BpGInXM9MzznDtV2EuJ3tayNJV2iutrp9Lc+KlEoWuOIbxj8BOUQa5YyDK?=
 =?us-ascii?Q?foh9elLu+UG3GlbX9AxQ4qZOHldsz8DT47LqGxMS+evdVgjUfLn7BalXSMQA?=
 =?us-ascii?Q?S6C3pMT/42CB/I70JI6AXVmrB+9Bwu9msGz59yU4pvTaNtosd4XT4dtKziB5?=
 =?us-ascii?Q?1TqX5CInd/uXzuE9UCfLOYwLnlOoyKtjPq30zjIkGCg/hl1aOgLBtHNfJQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2ef04c-2840-47f9-fe1a-08dbefbd754e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 02:55:19.8961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkeESH5q4bJpuCmWxUZYwzHYHPAtKTJHIjXcZG1Z/Zvb/g+GkFWHIRkqtq/OJoRU7z8fpRQote2Oc+KmyjV2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, November 28, 2023 02:56
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix uninitialized return value

The return value is uniinitialized if ras context is NULL.

Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to ras)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Avoid variable initialization (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 1a8668a63e67..79fae180639a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3416,6 +3416,8 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_devic=
e *adev, bool enable)
                ret =3D amdgpu_mca_smu_set_debug_mode(adev, enable);
                if (!ret)
                        con->is_mca_debug_mode =3D enable;
+       } else {
+               ret =3D 0;
        }

        return ret;
--
2.25.1

