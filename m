Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456AEC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 12:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC0E10E241;
	Mon, 15 Jan 2024 12:18:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E8F10E241
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 12:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZZ+gtnoflImI3GAH1lBE7X+3B2nWwl9gPuL6n4h5atQhvWUiSA683sk2EHUCHoUDuIAjTjfOvzdOSbDdFmYQDTan3TtxIrLlFfvyW3MTixHFiJVodF3MMloyItgUBC1H1LEHscOLnJ3M06cl2LSGpLx3ZdtbqfErTv9NyNLnaaYzn/eHXas1u72spPCO6LweGMVsOTRIDtLUhM+Ts2ZyoZMDk8fxcsDZdbXwFIxsLgZNYdgJgmVCG84xwhuGx856UNWCGUb4CzOazqcN4sXr2Px4l/RgreIv4/YL20w1F/s16/yGQ6I/U0V6LWmZjCZ/Bdv/cQQL0gNHaU1NyykgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dghFg5MXlTg2uvLSOpha297p0AmHlQ65tQZzcbqEx0Y=;
 b=fXPTS2uZUFi/HrQjWxzGwBdYqJ2DoDH4GPubT+UImmVSJHBBtY4fn2Qy1toUNz9WVjd22tKUsxlS6snxhsvXgK5MajplMVMH7Xe9SVDVxkK9GNvFVsf/BYYFO19kuUW7MJ8uBwTQUV8S6jkvMTs9yKiMldUAjvMMALa2uZWNDvxWRoDubmr+NIunOukvzLGpqR2MTu6bHEMcA/AHrdRw3Nk34apEy3Au1qAgNhlVp1CwKoQ9b8EBFun3RxYqrFAS7YY8dzM3wH8JKKHyASWQoh0KPg6nwPZypgRFqGp/S0oV4rAOD/4JA50MryyLg62JYqoLDpCCk7brlos02SlYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dghFg5MXlTg2uvLSOpha297p0AmHlQ65tQZzcbqEx0Y=;
 b=Ok3vaGwqiWz/NHjRmlvsSHXEt16kBb/qFOQfH14Le1enwx3K9hEpjzIq4b+ET/TQTwsyqf6ulnmgfMSUBCx7ojzCvvxQwILX8xN+mCDxXBoCbcyEfc0RfUrhZXbJElhB0oIoLISrfKwyToQmexH2J7AB2keEZveN0Pss2W0lLlk=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Mon, 15 Jan 2024 12:18:04 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::1766:791f:b4a0:5edc]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::1766:791f:b4a0:5edc%4]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 12:18:04 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix sdma ecc irq unbalanced issue
Thread-Topic: [PATCH] drm/amdgpu: fix sdma ecc irq unbalanced issue
Thread-Index: AQHaR6r5c/7AnD8hE0K4ym0ujQFtDLDayh7A
Date: Mon, 15 Jan 2024 12:18:04 +0000
Message-ID: <DS7PR12MB607127A5D05E2BF37874E8FF8E6C2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240115120318.936129-1-kevinyang.wang@amd.com>
In-Reply-To: <20240115120318.936129-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f5784806-4000-4300-ad3e-e53ed6bf178d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-15T12:16:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SJ0PR12MB6903:EE_
x-ms-office365-filtering-correlation-id: 72110a6e-9ecb-4933-2393-08dc15c4065b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2AIKBa5R5hY4P01iIST8sDrBTnKPXnrYmSsgu0utXqZwezyxkM09bYsoox1kIChKtxg8ulSERbZAdyWEhORMGTBZxsGuJ08HBTE7072quOCGLcrcZXEvnKP6GzJRvEr4/DCscZC0S7yPGoyjokWLhaor2HWUUR9r3dTX4Ie41TVheK2NroA3nRo43YL1bbqQ0gVxgdo8jLSWlsIFfXIaiSxFKvDy2JRNPVIdGu8wbwzEG5M8dtJ/6Iga1fKytAixO8bc0YnjSSY/GRB0dgWq/obqpiEhkb3Jr3fnDcQUXQN2XVBqJkpOugD1YStudzNopISSFH5nvwqd+RfWm3ZENk1e7pzUaUxOAs6cow663Ri4a5vbitYo/Wakyu2wIJ/5ySN8Xn/eYBzoK6K7zhbj3DmnNI/Z2lXA03FWk6CXw6K7WZb7vLskb1WJYDupWwTb5DGxRbGu3hHshkIT55aoNS6PXgnDJlLRgTyhgQvmQlQcK/lrFo1n4/AuvYD2HOh3oJYrOZUPh2d6mRMp9ekWt7Vcl3PkkfGcFAWprIgJKPxbtS0NvG+D6enA0VZad9mAvy8oLe9pQn7Pqmtu9TWntcy150FQElMuIFv+hoVTaZE86gPiT5bAdDNeigDXnEBf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(110136005)(38070700009)(33656002)(86362001)(83380400001)(71200400001)(2906002)(4326008)(64756008)(53546011)(66476007)(26005)(122000001)(9686003)(5660300002)(66946007)(6506007)(54906003)(478600001)(66446008)(76116006)(66556008)(8676002)(316002)(8936002)(7696005)(52536014)(38100700002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xHtGazE0zPAssM9GH90MW2vc+Bh30YfFWA3E6xs1AKdFyefzjiltwPOz6kI1?=
 =?us-ascii?Q?Cdm4g9PT5Ld75aNPywA2laxvym7ZfeJXM5XPDQAgAKw3TnVzZi1r8pIwFSZE?=
 =?us-ascii?Q?Q7UXMLI0ODGjTB//a0VirW/KMPXyVIb1RFFQx4RkL73hM6hhbzaHx0Z0Ft2P?=
 =?us-ascii?Q?5P+WHvLWvFGgfdng9Zn2km55B+VBs+1whxegOpjkfyvuLkB75mynRB/t9hll?=
 =?us-ascii?Q?tOoUcwAtN2PYlIMzBfAteKGNhnO9D3KqIZ3o3OC0K6pHFTWsyK57xS8fWprA?=
 =?us-ascii?Q?an/+wstiaCB1PgrQA6W1jyF/6mWLRLG314++I29jZvO5m5ySptE+Yi4OllyK?=
 =?us-ascii?Q?dz5JjoBEol/nWBGlHyQlPB807sKjuxOMR4NXBa944+anm47NG0LqdIdGHcpn?=
 =?us-ascii?Q?vGOGid8CUaek42nAn9JLuT8NW9F7oaqIxM1d12nMZ8++60oJC+z5kLkm/CE9?=
 =?us-ascii?Q?zM0By9GnNkJNpUQlGFG1LTTWmDYeXpjWP8K1PCr1aiPR0Ps1w9yqQWV2szxM?=
 =?us-ascii?Q?dj3Tr/B4Zplehq8TiZVRkEVLR82nPDv1l1Zxu3K9a0/bfAmCL4NRCW/5YzM+?=
 =?us-ascii?Q?2Ypg7Pdd3/bNPTAHuPD+oHT7VEeoCJK1FUx9rZnClSzpj6YLce7PtS3Sg6kE?=
 =?us-ascii?Q?Hn2VlZDFAJyF5iq8a46fgtJBKoTsOmifdarFvTRMdsA4lGkzLE2NXbtqdJKw?=
 =?us-ascii?Q?gy+uE/JLUcRgL5gw4bIUAO3E/ygd7PBqeAKtXbudWvBdpOVXNm20RaFNwxMs?=
 =?us-ascii?Q?EHbyMVZxQNl0N8802Ik7+FD3Sg3LikawzQALY7jPvfPs+8ztDBj9ROfu3S7+?=
 =?us-ascii?Q?LBAWApo6CFpFX4j55fM3tO2iP9/jYxlfo4Dq8cYIEpygysLV//5Foad58n5g?=
 =?us-ascii?Q?kY+dhrninxnzLaRls4CJcjhhN4UlSfzJp+3EPtBOfrP1bq3ovU3lehIw+V42?=
 =?us-ascii?Q?JvTCeY+tX8zMinGkN9YZ1lAij6x7DJngsVsryXmSsvVSfucobkWyEPjEAaaB?=
 =?us-ascii?Q?CYETHBXx/45R8vtGPWpF2QA+vtuyM6t0Y60N3dbiuGjv5uVXnIG1LO47hy98?=
 =?us-ascii?Q?FNj1cUsh4/vf28cImXkgdTofBC6fdO8OMjn6utuIKHq5zny5aqNh8aqOPNsQ?=
 =?us-ascii?Q?MjJyy8OlCDcpvdIsMqqcZNg859hZ7vC1u19Pt6XHthuG6vWmigI0w/sMdXt+?=
 =?us-ascii?Q?s1udUm0XmelAo319gwbilAxVorPlhU5HNtyCxOcyC6r3qcy2GgoxtdcLRQqH?=
 =?us-ascii?Q?UtvYUnu1Ysg6et5bKtu9w+3LgkriloeJh76FoKoOIQvZofXSva19eX7KgYpa?=
 =?us-ascii?Q?aaLwhlfZPHr4b5f4E7wQN2ChKIlXFxo3OwRxZfrX2yK+3qWWKzaJ9RDabmdn?=
 =?us-ascii?Q?TPF9QInV3I0AAhC9feNtGacyG/Eq2HujkJ7HcdkEs0nVv+KwWrU+z8lXZPZX?=
 =?us-ascii?Q?aI7YYc++7CErLx8zjlNOuoU2F1k9oB/+zsbchbO/HvR6ROsDWyrMiGebQQw7?=
 =?us-ascii?Q?cE9n10GnqzSZq/vyO7XqN28ybpVOsFoefFT0PVRKR9lQ4k/BBz9KNYdLM33z?=
 =?us-ascii?Q?1hIYZpm+BtsfseI7uKo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72110a6e-9ecb-4933-2393-08dc15c4065b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 12:18:04.3889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B00o3WdHnDsTsvKBuzeFz0znyyY2G5u7+BUYDRbZeybcLZOnbKRU19pJcVhNyK4a1JtVJPoFUnstrFlQJt7jKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Monday, January 15, 2024 5:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhang, Hawking <Hawking.Zha=
ng@amd.com>
Subject: [PATCH] drm/amdgpu: fix sdma ecc irq unbalanced issue

fix sdma ecc irq unblanced issue when do mode2 reset.

Fixes: 90b87f67124a ("drm/amdgpu: add sdma v4.4.2 ACA support")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 4bb055eacad5..fec5a3d1c4bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2267,21 +2267,12 @@ static int sdma_v4_4_2_ras_late_init(struct amdgpu_=
device *adev, struct ras_comm  {
        int r;

-       r =3D amdgpu_ras_block_late_init(adev, ras_block);
+       r =3D amdgpu_sdma_ras_late_init(adev, ras_block);
        if (r)
                return r;

-       r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
-                               &sdma_v4_4_2_aca_info, NULL);
-       if (r)
-               goto late_fini;
-
-       return 0;
-
-late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
-
-       return r;
+       return amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
+                                  &sdma_v4_4_2_aca_info, NULL);
 }

 static struct amdgpu_sdma_ras sdma_v4_4_2_ras =3D {
--
2.34.1

