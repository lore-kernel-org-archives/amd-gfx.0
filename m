Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529A5C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 06:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF9E10E21F;
	Thu, 30 Nov 2023 06:22:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB9410E21F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 06:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baC+VG6VJvaLVoGQDxrS6oS5CORrfsV8ho3r1Kxz7L+YCUcd9xDrc/+lxC2EWiHzPFi/TDFSxgcwZ9ZBY9wDqaaxWsgw3bXnlFwfH42KMXozg4eLf0lPyff7NhRYe/PyYI28vWXoxYgALGKzUQUJCvura7PZnD84GNDEe7SeF/pBuFEw8k8mROduPAj/ChgvYCTtuG/ckMUxGoQJyDXrdQMko5QvUplNfXuHowh0UkbbGCAIpmEQE1CIwLB85DwUAvvGSINLTmDaNHkw8qtHwY13yajSGmN+1+nP5binmhB29Wm+wzYNYN++NCXWwZ6fxp/TjrJTt0HPTTmkULLeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2dAsdJafr8GKEkB+V2Oe2GNEXbcYOKS/LmGj58jG2Q=;
 b=Om42r8E3Kt756ZFlwyBzXE8mARtE137GLBJ4uxwwaleHY5hFEHSgNhlUBDaxPs9nGV7/gL2ZX9CmBhuJfPqTJCqCMrsUgSeb0+wzvZ2BYPUeLh5axvLmXb7DcwGdYnw04/qAhM/gBMBDD0gu/Ga7YO7F36cr4d9md2CTlWuHK9EMg5jaMy2ZrW8cMaNvSjwy09uZvl/Ju5ri/en+/RWWsfqyqZxaozs4lT2Qbda7OOpB/55v0EZSKI322XD0dtean3c9EUk3LflXt8P6ptSudEG2Hno/bthM8DT51G199R6jc71RJA6wMGFVVnVBDix6XIanEb86d2aaytHMlB1gaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2dAsdJafr8GKEkB+V2Oe2GNEXbcYOKS/LmGj58jG2Q=;
 b=4CmNzAr1GlTw9qD1oeqGRkz87ZAy/Oo2tlYf4WSr1p6vuabq7f70KQjkaXutgDr76YjWevnopxA4TBkGN4kn8Ubc/LHohvfZJAsrKaNgYtfzgUcrUDUtOgCx97wVaMqGdB11GPgFKEhgmpTagIQQ73TtPoHLY542QV9kn1tDnco=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 06:22:05 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::3764:1fb6:a384:2284]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::3764:1fb6:a384:2284%4]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 06:22:04 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix miss to create mca debugfs node issue
Thread-Topic: [PATCH] drm/amdgpu: fix miss to create mca debugfs node issue
Thread-Index: AQHaI0tvLLOIMwDrMEqMkiRZ6a6YS7CSY54g
Date: Thu, 30 Nov 2023 06:22:04 +0000
Message-ID: <CO6PR12MB5394851D3AAEAD7001253B179482A@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20231130050919.1283614-1-kevinyang.wang@amd.com>
In-Reply-To: <20231130050919.1283614-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ed89bdb4-4c64-4f03-ab76-090a71888eb8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T06:18:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|MN2PR12MB4303:EE_
x-ms-office365-filtering-correlation-id: d079d44f-a4bc-4f2c-c94b-08dbf16cac1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0JBdbVEq+ntJYxdYV3YAZNyNUsMVmWAj3X7QsLRl12VLm4wyrg1TwQj2OFMoGF1JcO7XlJ/NyQcKIinkyve3B+OBfNwxXRGvFJDuOhcJrbTo2q5Q3L1DNZtozFhXf7GoO0WNK9omP46ToqwGVBw7YvimbaxxW4O2+9/jey+5d/uMFNgzyCvgBKurBcdMe1tvUl9riGyGC+/P+QpZERwbLapEKZynUr3Nn7sJ3U3KGTJR3OciNDXKtV3w7qTqH9SLdiykXQuJ9LajORKZ8JZKlkNKEVAsmBYss3FHw/HuJyoro1KMNx0XmGOxOkPp5kGgEznapxDFnTFmcw9I7jRmZRawk1aI8NEYZIfAk0rY/juSkj6vEiUszHZFQzOpgaXJyBc5N219LzvgENRwd/XIT7qxsMLdY5YEjUY9HgkatSoYlGsYZbJLXS131pj/hoti0NiOW3cAC9qb+3M9i8SxpL48a3Ih6pL8xeud5+xRRfGCKyUFOVakp2ikerWJ9qGgu9hEx5LGl+WhAI1qQ26H8ViaKeQXWxyUXkEr8T9Ncn+IH5QBeQdSv/6oNkw0R8sSh+UrfR6R8/O/BjDjXdoZZwKqLuugtdDksf9oafzagUabWd59PuMi1OQJK8T5C2yQfgmgQNY/BgXnGe+Ut0B8sVP0csdP/rTcq0eUI1c5Q6Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(38070700009)(202311291699003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(71200400001)(38100700002)(33656002)(86362001)(122000001)(83380400001)(26005)(6506007)(9686003)(53546011)(7696005)(2906002)(110136005)(316002)(478600001)(5660300002)(8676002)(4326008)(41300700001)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pWubs5/XUQMh1s+DxU/E3vxB8G6yo5Bc0zBcqKcJS2x5tEq0KbAe0pGwszZj?=
 =?us-ascii?Q?aDWQuZEWUCW9tYQpJcM/j4R58OfdJwDdgDoYq6xAQMbBiR6G3rfp0ZMVhOuW?=
 =?us-ascii?Q?zmQyT4Pb1C+hSkOWgCR7hrPYd9b9mimfIxQfDTK3x+7wNF40ZNDxzORUp5+q?=
 =?us-ascii?Q?aVFGoN8euKIBfZw8SFj8gjHHqMep/lRTc692gXQkyhYIQhnnOsckuwGzjJkf?=
 =?us-ascii?Q?H5k4w3yCjamAsoiQH6g+PEgBv4Q4aIWwwmlvnlhX7aculo2Wd0wZP9IzaMRS?=
 =?us-ascii?Q?4TTIv54TmoAZD5UDjQzHQekvkexhNR5BXuC7BRV47DT0VfZ+Yms2Ul25MDX6?=
 =?us-ascii?Q?L3DhU0UXjEkrq09Ph5AJgZAka5EMLvVJsf2ij5Nobg6nis9BOf+p5XkQhiUm?=
 =?us-ascii?Q?UZZVH+SW/H8Kxwze0wz1Zqgm6OHm5sIw+ahJuMQg1SJPivGr0UIObwnc8bSD?=
 =?us-ascii?Q?z0ouicrfCmAtEbC3t1zjmaUDlNgtYff7kFyHhvcbmR3uGjnweM6NCMCfnUBI?=
 =?us-ascii?Q?68iNx8DLV6HHbQEByBWDsEliZ1Jcaer6xnWe3f1aCEqp1pSwvWVqAQDEhK22?=
 =?us-ascii?Q?TLp1W6rGiyosCvcSS2WE4uWeKOAN+y3hM4i4WpoB/c4brlvwlIhPy5ynBv7J?=
 =?us-ascii?Q?w2k/BhF4CFSp/IJtmDZQxkjKEzLvoSewo3BjCadqHK2m1iewE1ILX9OOQVB6?=
 =?us-ascii?Q?gZCxOfqiCO3kC9BtwswHh7nv7hrygQmXAhbUXFQ5FwBTOjnd1pRCzm4iMFWG?=
 =?us-ascii?Q?0ksABnzfJO7rgICZufLhZvkE6o8cxzECWSPfL4lTEnliBVBZ7Ck78PejXfFK?=
 =?us-ascii?Q?/vhLI0OTlsxEKZ9pCbdS3sYepPFlemhlXJJbvEz0NtZsZGny1uA+YgcjPKae?=
 =?us-ascii?Q?FiVZ9gHLSamlJFoZ2hs3GqsgSbicl9DtsGvn5l9lcedZE9Ahj8JSE6+dyHcg?=
 =?us-ascii?Q?1lAOmJIKFZN9lQB0+J2QKzAMjBmuw7C8x4aOUL5LGztknLRj+xD2AuY5XtXI?=
 =?us-ascii?Q?nuI6icpXcwvGdj3P1c2+Bvq5SeXTTT8IFnDPYr97ErDH3FkS7VQspIIH2ZHj?=
 =?us-ascii?Q?ZjmR/sptbuiE7OdSrAvy5CAnDHyHDk9oOosYJwRnnCxiHKDzduecsFlQt1yN?=
 =?us-ascii?Q?a/80ZW/om9vqV5T8qoqRQYmCN1OtASpLg8NzaS52jj3yZatvH0xba93JOBrw?=
 =?us-ascii?Q?J3cYL9n8vSrh4vK2PgrSSutmn0pP97cAJyMTPRf+EtDPIBdkNUgoxG1k9NF4?=
 =?us-ascii?Q?LDS18ocdtz0TQLuwDQMzvWmAjUToORZeOo1hkJe55Li3Uoaq8PSb+wmAmLxW?=
 =?us-ascii?Q?M8FrXsDHeMEw0H9NIrpgkuV5Scw+VlszZDkxFJf3Mqi+Kg0lh/pi859rnaSa?=
 =?us-ascii?Q?EXybmU+zmzW+gavI12/qyLHGv85x62W2TvoAyuXrUSV7uAmVh/CbfHxTE3Un?=
 =?us-ascii?Q?esydAC9RV3ICl9nm78Fgaxx31z3XTiFTWU/Vg3XiyFuuUom4/CULT0GD/H7l?=
 =?us-ascii?Q?D+uhPW0R/u0Gm9YiYjKdWoCSJNAAkdYpLiK4LGGAqebzqhjDq6CfKNmO+rUn?=
 =?us-ascii?Q?R+RwDBuqq/eP2z9BGss=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d079d44f-a4bc-4f2c-c94b-08dbf16cac1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 06:22:04.9113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2sRa0bIhLd4hAWyAnwnMI9Mb9d+vzmw+3D6ZV4OhHVM6IkRfChw519RV/aqJcD45c9b/OefiQO2GBkZJYw1PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Bob Zhou <bob.zhou@amd.com>

Regards,
Bob

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, November 30, 2023 1:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix miss to create mca debugfs node issue

Use amdgpu_ip_version() helper function to check ip version.

The ip verison contains other information, use the helper function to avoid=
 reading wrong value.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 54f2f346579e..210aea590a52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -485,7 +485,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(mca_debug_mode_fops, NULL, amd=
gpu_mca_smu_debug_mode_se  void amdgpu_mca_smu_debugfs_init(struct amdgpu_d=
evice *adev, struct dentry *root)  {  #if defined(CONFIG_DEBUG_FS)
-       if (!root || adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(13, 0, =
6))
+       if (!root || amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(1=
3, 0,
+6))
                return;

        debugfs_create_file("mca_debug_mode", 0200, root, adev, &mca_debug_=
mode_fops);
--
2.34.1

