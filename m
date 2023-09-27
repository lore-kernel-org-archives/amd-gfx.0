Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C86DE80AAE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 14:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A895B10E537;
	Wed, 27 Sep 2023 14:11:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6C110E537
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 14:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWPs5ROmDcmknDIbYehmrFHKkVZerHkUe/yIcOurdyMKJGU/LFwK2aGdoYLys+I5tsMrIJ0AzNsrtwQ1Br9U6bXtiMqt/g3jxVDBxzOVxu4FTAc4loV09T7OmtuV1DKnc5kupCmjlPg+oY3e8jSxdBVDtlsFE6Eb8YM9nNWP8WzlfelDGQxsp7xk8uJPw7QYiKJ/YsSXlh4WW0WdlwhDMTYVisGKBW0DZh7CbP3ICWOkvSfrtm/71goH7+RNuSnU9blZK+dL//pnco5ylEVNSPeJGydOVUK3/NlNlBUbwc63kcGhoWxOCKakb8fQF9ZigkRYcQJrN2Dw+NON1Um73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b00RJBYhHPPr3kzTetuBL+2Eyu6OKEml5VNLDDrE0eY=;
 b=eNWHZgH6Bva3qdG5917RLa557E2Sg1+66hzuDd43/9Mw/j3fgJp/pAvmLMOc48ukXtLYgXrsXqYLbAYVlTWN+xtbuzceMc2aYs6AnzGuWKF0IX+aTPyWXTFtUFM+KqC2rrXRXrJhLG19SIYqN/yxyYW68KPs7iV4REh55xFVTdjN1yNVWeIuotGViwDbOpfL7y/BOjjjyqkfi1Er0wj4meveIbFMl+fmaBvfqQauzMb2jarNmPFAflv6Y9k/HCxn9sLns1RDFnEkH/CzNR0WBa5dENF0o46tkqBnYCBIcf0N8m1N0UiTLdVyGmR5r6cgOjIREddJQrfsTyHhB2zQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b00RJBYhHPPr3kzTetuBL+2Eyu6OKEml5VNLDDrE0eY=;
 b=QS0oqZXOvrdCk9v31g+4pJD7AdKWcRmiCUcy+LSqBNoVGzqg6LNHkRDrvz+zJMCThmifZE5R4lu0IptNRLcNRMhw1TJssTPmu9JrUrhmUe52OIvNkIUFhFdQ7Z6YTXpf3I7t1aZratq49n1HPI38vaFoqP29qi5xHN40I4WgBHo=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 14:10:56 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 14:10:56 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Evan Quan <evan.quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: delete dead code
Thread-Topic: [PATCH] drm/amd/pm: delete dead code
Thread-Index: AQHZ8T9xPqYxa4eMGkGMedZ84KvFI7Auti7Q
Date: Wed, 27 Sep 2023 14:10:56 +0000
Message-ID: <PH7PR12MB5997674A218864F1B9C6B16882C2A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <b238c665-91d6-4afe-83a8-da2f2d59a75b@moroto.mountain>
In-Reply-To: <b238c665-91d6-4afe-83a8-da2f2d59a75b@moroto.mountain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d0cc97d2-ceb2-4373-a73c-891ddf5ce2c7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-27T14:10:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7323:EE_
x-ms-office365-filtering-correlation-id: 04814aec-c932-4bfc-fca3-08dbbf63915c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGdQJDklafIcXtBZmPA0U0AQRsVn0XV1jneth7wBmfjUx15xpuTmwxc/V+TSIuaw+FQBWQGDLgHvH+hmoAjwnE3ZDhUgZjaFzRONKuejK5YE72BoJzJ9BYGcR+bjdlS+GqGqAUrBg48DR0nSx3QO7iZtaoZ0b2w3iT2wXesLUT3NWIZntkB9q4kgEHVt6z30c691ZRGIzpcN088t8Evl5rKMuYBeKwMEzUDVdIXtf/AOUBiUetqiDrZnCOyEJeUDaWN5tnYfz9hqx944aPEJ1jIRhQOK9dqLW81qi2GklEqIr2QlR67HhQOkw0hxbSP23z7TTeML7wbo1FNKEzNriiMLKLu9QjLApN31C/0Bdtw49IteIKt6nrrp5rs2J7zbDj297d6Mw+7vbt/gbzrjMwDj1hZWnCicVhaj3Z/Wvvdi3T046Q4K4uHQSqI8wpMEZQq+lxF06UyzVNhG+pVFfdSfAFGQtVjiB5Jt/xcS0MdX7/sy5gYVJHHnXmRUg7grcQWuKTL37L6E7u42eIfmWlOhyDvTWoh1oNbuu86SDUkiTM9VbnBDhT8Ohardducrlf2C8U0OvB6zY+R7MjAoiCeI5fJkImU1sIVNh0Kw5eQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(2906002)(110136005)(66556008)(66446008)(66476007)(54906003)(5660300002)(76116006)(52536014)(478600001)(64756008)(71200400001)(53546011)(9686003)(66946007)(7696005)(6506007)(26005)(8936002)(6636002)(316002)(8676002)(4326008)(41300700001)(83380400001)(38100700002)(38070700005)(86362001)(122000001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p8en02p56MO3crleo3+OIZtn2yCBJ/CCbel+mnpNch/Av4uDEnomELVQgzWm?=
 =?us-ascii?Q?abqNI3kT5CQoABxF6UNdVAlepSTbwnn4XAqWrfpLv4YtLfGIJ5bY3PoUHrWN?=
 =?us-ascii?Q?OuylthqqyYrHdri+Yw6mbA4tvI4KUY4Ne1uIYL7/7BDSZQpL3CAmSTX5a3sL?=
 =?us-ascii?Q?/gTQMf9T0YZlOygwSazpxwTn79sP2U+5NHT4rfK0uYeazbXcTDL9ERGPpmh/?=
 =?us-ascii?Q?CKqh6txVBpuPIsEaqp7GeGG3ZqEa08MFjuCwLDEoQKwNPFJ/pfKDRfVu2s6N?=
 =?us-ascii?Q?ym+cl+IYdAf9g2JUAhf84VngoJafu8RvAsoBBRfvIfScI3yqSx8ALc3UGDok?=
 =?us-ascii?Q?8x/f9jumYseqm9hvTRRSpU0rwCUQnP9X1Asi9yx0iVHv3vnJnXCf5WnOeh3W?=
 =?us-ascii?Q?aSokNCsMKGp4s2RpnkPhv69kYIjfhM7YeQ/S+nCH8wmaUFbXWCTzfyIt3BL/?=
 =?us-ascii?Q?vlUmtzt1VTgUz6bW7tlqAIF3jerGub4aBW87DWhfcDdmZMAIPmo7/RDk+HvG?=
 =?us-ascii?Q?SsxqxKWLNc86RRBhri1QAn9XXFDcneJ3oyK9CWg6oVIQhdhWMxiZ+NnFNAMc?=
 =?us-ascii?Q?BnemFsUCEHRTDhHlGfA5Fkr3ItI4+RFaNn1wdumISRLniq1wW10AkjL+V4Iz?=
 =?us-ascii?Q?BN2d7ZSp/P29hIhAxyKqi7hdxQDw9Bq9jDfRGcc/dztH9sGNZoXnxOKjAH2X?=
 =?us-ascii?Q?oeigEEQKWq44Xk5xkqBQJNDw7ooch+8Pkb+Vq+98uvCxYQIbjmf381Tw7Xzw?=
 =?us-ascii?Q?ycj4SFxM2ULtbCv5NDJYB8KgGIHodm3dMlZWr/gOBnGgphkUo47M1V7vSqDf?=
 =?us-ascii?Q?Smw2PQ8UXYDrWKz3fx0DT9BCyf+sWwXtVMF5iBymd4Z//2bhODjEIAS+lhGt?=
 =?us-ascii?Q?67tI9Dqn9awRIHxO/ikmk/IyqiKP2T2NXqV73LNZDW8wTN23XASnBSC7boUE?=
 =?us-ascii?Q?va2YXFNhKmEAyVbfz3tfwkifIy9EPr0pCS9qvWo6pUIKzkZ6sSy6EdQSabWh?=
 =?us-ascii?Q?sVYjMcXb/gC49ToESmxeQIHt9prNV+twWTDXVECwuUfXOLCQhhcW89cWlfTQ?=
 =?us-ascii?Q?mM4lYpxGJPI9HgUZHCNgnxIMhuR2kzz3YgqCXEzcGf6O5AhU3jkY/cWFIrPK?=
 =?us-ascii?Q?uM0KzlcQkMtuL9IKiyA7Vqx3jVYKW2dDszEvQ0ljVheyMin1KAAc3AgjWjgB?=
 =?us-ascii?Q?HTZuvCQl2Du3ZHK/STL2v4/Qkqd0IW3eMM7HUKUp+u3i2FrCb7DniX7TtUfJ?=
 =?us-ascii?Q?Bboag5LpeogpCVdAXQ7DyXSl7PgBQ0fiKPAH6j8mi7NhM6CizSp5tgDK/RwR?=
 =?us-ascii?Q?JMdan6l/jLkkfawxxi0QEA3+1lIe9hWB+ry4z+O+0BgU1TYhbk5BSdh+xSfE?=
 =?us-ascii?Q?G8yQXI7lZpGvOTRhcr1YBVAWoiuZKCWwy2QFrbfYjlwAPjJHXMNa/Y8MAppA?=
 =?us-ascii?Q?sUhA7zYE7Yt8yFAUnHnfxgvzO5jDUC46evk8N5T/DXmcw4TN0u/ZdIZiLNM4?=
 =?us-ascii?Q?7M34RyRdu2TiofjkATuOMmotKrZ5jPyDDhsQVm/mw5MPGwClWo5z0/hxuKw/?=
 =?us-ascii?Q?Uvg2BpEBtjRtluX+bAk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04814aec-c932-4bfc-fca3-08dbbf63915c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 14:10:56.4483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IURahKORebUsNwICgy6VGv4mtNF6avvE5nbZ0bqWDrtLFCLFgjZZGw2COkUlk2xJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "Kamal,
 Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, David Airlie <airlied@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Dan Carpenter <dan.carpenter@linaro.org>
Sent: Wednesday, September 27, 2023 8:38 PM
To: Evan Quan <evan.quan@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <airl=
ied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Lazar, Lijo <Lijo.Lazar@am=
d.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd=
.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedeskto=
p.org; kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/pm: delete dead code

"ret" was checked earlier inside the loop, so we know it is zero here.
No need to check a second time.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 11a6cd96c601..0ffe55e713f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2346,9 +2346,6 @@ static int mca_get_mca_entry(struct amdgpu_device *ad=
ev, enum amdgpu_mca_error_t
                        return ret;
        }

-       if (ret)
-               return ret;
-
        entry->idx =3D idx;
        entry->type =3D type;

--
2.39.2

