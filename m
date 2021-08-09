Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E22C43214
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 09:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3516101D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 09:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D3516101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F059898A7;
	Mon,  9 Aug 2021 09:49:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9016896ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 09:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmsg5zj7c/IoD5oMPKkvwdO6kjWW6iRmPjFWuRU4J6zFUHli/YbsZhoNQvzgGAdsTFtrj5SOXj6gVMAUH5zxyKuUAk+PpwoGKk/vruADS4KHtZD1t5JfIiAboau1hT4m62YlejeJLm71n8lM5SkjyA6flN5omFFaQ/tBg20dolsb6pecEaEgpQqT+ek9nN/P6Vuoh506X0/6Vj/HiR2WAHl2io400Px9d2nn/Df84MN/gadePtp7FACcrSAl4KusE4Ek3tzzWo1sY3Uv/3V5Tvs3MhrWtNECbt6xhjxcei//4vQCtzS90oRUWkKuZQCUJCl8GOdXDdMCyQ9r6z/+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQiDI4o3cSebXynWdJWxmfxrYZ/pg+76wLUyZam9ab0=;
 b=nMO5ISuj3YoOIBXPwkEWXigq1YzYh/jwyEKApvEpDjMr/e2TOdFh3sp+MsEOtl4lpnpy+ROxUkubZTwqEXzO6TGmwcPPLQQk7TT1w9hPTh7G9rPxWodre9H8wa0ZgTQrmHKGtqSrdhUccKPLFuJ0jYTZhBpwTmv/dCXQERw9a1T4xpEuI3xUdBrMdILhQQrJpXjhcYa6RoZVF9XnapyCjs0Y4XlGLT+QboNIhzj5D+Jhaj9TVKPPWATOk1eRTJItDd5WSmC6wAu+rwrm4uZFWrn3MQsqz4y+RxJ7m7nYOICRWUVePED0KexRI104+7h2r4MnJzolJp3jdYJMfjrhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQiDI4o3cSebXynWdJWxmfxrYZ/pg+76wLUyZam9ab0=;
 b=PJNUaOEEUVJ7NHKGx3u1E6t2jFPh740XZ+YyBhGhVGmwRVgxvsvzfsuu6SYJMFoSezwFBFUd5e9BoYxtnTbMeyN2Wde7IGrSB84Xi6QybpcNqmUZ5kYZijI2ukVNSRC1SIfUIllE+71P3Wq+CgXgQPNc1poXJ5q5/ZC6LYgcnIg=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 09:49:07 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::59af:41e:7d7a:6337]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::59af:41e:7d7a:6337%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 09:49:07 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xiao, Jack"
 <Jack.Xiao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, Kevin(Yang)"
 <Kevin1.Wang@amd.com>, "Wang, YuBiao" <YuBiao.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: skip locking delayed work if not
 initialized.
Thread-Topic: [PATCH] drm/amd/amdgpu: skip locking delayed work if not
 initialized.
Thread-Index: AQHXiaLkw9BdYfnCIkmsh22hZa8ovKtq9C3g
Date: Mon, 9 Aug 2021 09:49:07 +0000
Message-ID: <PH0PR12MB5417A6F7156C08AFBD4415B28FF69@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210805023736.699291-1-YuBiao.Wang@amd.com>
In-Reply-To: <20210805023736.699291-1-YuBiao.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d88b1835-4a59-41aa-9574-3163eb23a7fd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-09T09:48:36Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ac004cd-2a37-434d-7ed4-08d95b1aee34
x-ms-traffictypediagnostic: PH0PR12MB5482:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB548268B965800A39E3D63C0C8FF69@PH0PR12MB5482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0RLz4KT3QHS4dAL6B5NgBg2rBim7IzkR7lRJ82hC7USI3FhavArDULDQEp6dVx0kHiPPEA9tQvOGd/r1X3q8EO3ppRPQF6hxZNHPiZrzJ7nJdt7Z4eqWqufA2EfXiw/OFXCqKsSCQO4nb6Wk7v9VXA8zcviEQ5WZKYldN+Un6k7rZLzqtS7MG2UCCZQ/ozTc0OddgpJO5OpPFWUY9PNRDXc8CuSyOVwjdOXJosey+kp+y21lUM7tJsiEob2wKb8UVGdwaInScXGCWwk5J3YID7Y6JEZLSzefeARpnBmS0zImLq9lQlTLU7Hl0/3hjIOLPc6m/+bVPtFpgP5kBedOQN9zNFc6Hs64Nr+V0gqLyDRgGl7yODHoN5bwJ0wLXACBTYVzqCLVKvkK4679Om/ndEpUqk3AIPp+L28uyU7UhzyknejX/MbM9HL+P+KBjngf5KxVrBHAYQ1+VZKbxBeoovaeI1Dhhs+No2D30R73hiv9EuRva9LoxE0DG8u+uAzzf1dGW7As2lnD2gp4SbsRzizqjkrEfA/aSDQnI/5M4xeOdtB2ErBbYoy8Emi18RW/LkpMH97oigzQfNBXjOZ8BH98nsmX7OZKCKLw71ir1tV40uMcuO0OWYCiOLst8aa3Y7pyXdMY5MqCgnb+6y58ARL4ANjMXTfID9x97PhOvEwegM22g1CZPoNbooBsQ7XFmwwLY6k/3yzTCBCin3v9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(110136005)(66476007)(54906003)(83380400001)(71200400001)(4326008)(66556008)(66446008)(64756008)(76116006)(66946007)(186003)(86362001)(55016002)(8676002)(38100700002)(33656002)(52536014)(8936002)(6506007)(2906002)(9686003)(478600001)(26005)(38070700005)(5660300002)(122000001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2+bZ7Z9MB8TdUEE2UoVGNygq39991N1LjdJVz9F7QuBS/13sf2gKhIjCdRZv?=
 =?us-ascii?Q?lnRCh2g4wPRNaLYnEpqTJfXq0vodPh9+xvvU1Cs/lmHQs36ajLYOD6BrIsiw?=
 =?us-ascii?Q?oXhQvF4v+8COeWNrH85BQPMLVPVySTYS8A4mOKMu194x22XdZkSNwlvdyhfP?=
 =?us-ascii?Q?OYBCkih1DpjmlqVyW1Lg9pTxc7K/uhqYSeVOqP4KI6Lvm1B/2qNl+ClGtBOP?=
 =?us-ascii?Q?32AZ19d3zIJijaHFHX7mGFk8nUGdXFKZufmb5dc8nhlkZKLpKHrQ2XZFJUSx?=
 =?us-ascii?Q?XabNpAKBmEpX9skL5k86REOCmEE3Eug2+QuinKqUmQSV6qJl5y0zRRBugUi/?=
 =?us-ascii?Q?HNJYRf6AMOJMRyGVgkeXqL61etIl3iQDLrw24NPXL/+QXps69TdtfMqrwiTk?=
 =?us-ascii?Q?8kkxJ8N5EViF7rm1WFuRlYpH5vo5mtZPPx79roLVmPxGqFXEf7y/mWABKuRT?=
 =?us-ascii?Q?c82MCWXW1l4QRctn32mIdQdLP8QRTb/MjLO/l2d1tDzjHG5DMQZW6Xzx9GtD?=
 =?us-ascii?Q?rKnKphByu5XlJ+Cy0v0XdSJ3t7izbRt9gfY8eD6GSt1H2s+d6RHoKg8pBz3U?=
 =?us-ascii?Q?oIJ3DT5+3tBaukmLaDUgCFElpn0Kd6y+OseDb8vezosFXJCxPmRZvG4EMGeu?=
 =?us-ascii?Q?nRIg1l0KbtPO7AFO6iQvc+0Ebg4iS841O7Hu/iKuZntlHUFVVMIljvqMJrMy?=
 =?us-ascii?Q?I/eUm8eecArm/G7jWxMui2+BoZoarL+f95Vg1/rNzOm5eTFElTxU68jFTSV/?=
 =?us-ascii?Q?KMifWPDFz8+DGlIMePQ/T7H8hIo+Ea/IzLnhibTJs6xIWvvjchq75iFRUg1n?=
 =?us-ascii?Q?tij/Q7zBjSpHMxXmp1MXGlteh7N8jNAtKjWDv4GnWQtiuUu/7p6lYrTXhAYQ?=
 =?us-ascii?Q?TPM48lqqwBkPIwuv+8E1SYaY1bpxdei8I8V33+O11SdA0pcFhPEYQToFMf1x?=
 =?us-ascii?Q?MAxg7dpYp/2OP6PZCC4JKVCein+kvPQlyLjtLS/U740lZFdj5XKmU8R+xRgj?=
 =?us-ascii?Q?szVb1c+LXf2siFGg0EF77ddbM9qJOhWpRU+Ja6OugbFCAulPQTCw8TPNGduZ?=
 =?us-ascii?Q?IqLAjTO0gnfJh2z2PoNVV4O1fSF6MSjhhXwtnmVUovyKd2prZc73Yv7MebLR?=
 =?us-ascii?Q?djMdqzMni4uMQ2g4vfJVUjxteaF9QXgSZlW0yoKMKNfYnbcgyTRXm9J+elZS?=
 =?us-ascii?Q?nMw3qqFnynmAsf8DKbyclvzEfYvR3MOvsXUdrfxBi/g1mABxksyhlnAS5+gU?=
 =?us-ascii?Q?HPAtUW1kY4EYb4PQnhRkiZ5A9i0LuW+/m6JpKYZWercwvVoJjFjAvo87Z02B?=
 =?us-ascii?Q?eL4i/6jr3lfwhjO8muuuFdea?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac004cd-2a37-434d-7ed4-08d95b1aee34
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 09:49:07.0801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9WP5sCGe4TVhLpbBkxxcb301bl79CzPkyMzXagSfhsLuOdgjtvEnETzUsMFCCDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
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

Reviewed-by: Emily.Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>YuBiao Wang
>Sent: Thursday, August 5, 2021 10:38 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan
><Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov,
>Luben <Luben.Tuikov@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
>Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
>Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>;
>Wang, YuBiao <YuBiao.Wang@amd.com>
>Subject: [PATCH] drm/amd/amdgpu: skip locking delayed work if not
>initialized.
>
>When init failed in early init stage, amdgpu_object has not been initializ=
ed,
>so hasn't the ttm delayed queue functions.
>
>Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 9e53ff851496..4c33985542ed 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -3825,7 +3825,8 @@ void amdgpu_device_fini_hw(struct
>amdgpu_device *adev)  {
>       dev_info(adev->dev, "amdgpu: finishing device.\n");
>       flush_delayed_work(&adev->delayed_init_work);
>-      ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
>+      if (adev->mman.initialized)
>+              ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
>       adev->shutdown =3D true;
>
>       /* make sure IB test finished before entering exclusive mode
>--
>2.25.1

