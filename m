Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8D9CA5500
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 07:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1A510E0E3;
	Wed, 13 Sep 2023 07:07:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA5410E0E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 07:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT17LGdaiWkJQjtCcfEK304A5bMhkXHSIS5wHddL4trqf7iykWe3ErXi8ye+5mfBd16n2RNVW5Ra3jyaCpR17pbEBAxy2Y7cULnqwx/rK1Q1Q4C5J/FG6wCXKOism0xr3B046eHmmGj0NVgYys9HXjfV5ijY0yt2TU9wgLI9ee8ZehudDjQ9VdYDpr7NZhHlV/eVC2Xnbx/M3VqOqAuMdS4mvDph/TYq62vT67l8Gt75j+XGfVeZwU2/QMV+Rkp5pvdy3sXfxygTKc6c/HRLAtqskDhmVGXs8QfatsVO109HWtaRkHbtK7vahJ46UotKBEmJ+vcfsnM8v+foDTV1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TBOg4xd4j9yG2tDZRjZSVw9daWHjHmGsygkkWvbHHA=;
 b=WQBHrp8h1Rc7CJRuVb7aDAMEHJS4jkXbZVBZbWLk54Pn3P9e7I8Ef2g27FHUdiKLVXfObREn717qhg8aPfqEqBFJuhFEiyXxESdCZ680vEx9/FRNRM8vbhgklCY/DnTaid1Ql7LmVvSptOHH3D5jBjGA6gzEayYMp2B4/rVvh8fjw17VVqsp0F6YULsK/XKIU6IweQHUk/YMgWR8Ti2CxxyG/ji652wyuce4002u0kFuqBdBkOm4hzZwfRP+Jr/cL+UEHR2veVQVhR78h2XFy3vn2BbtfGdJ9z8oXygfQDAISXPdU0LMZMx3QEhgqdbIKQXKUNXAscdHtrXVa2WXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TBOg4xd4j9yG2tDZRjZSVw9daWHjHmGsygkkWvbHHA=;
 b=JezTil6MZaW1mbAoHaj5UTOmy/xO3L1bo5KfV+dcgsjSSFVUSbkOgMyRRBFmq1z/0NXbLVQ+R0X+bWjHCejP+D04yOR5HaAL9N0IVph3VOGAdKRB/lJcQIG014NDqNQ+k25mrU3FARMLL8FNGUWHQPDkqY4rgBfM75qruLuPUpI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 07:07:13 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::186c:dd6c:34f0:5632]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::186c:dd6c:34f0:5632%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 07:07:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Add more fields to IP version
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Add more fields to IP version
Thread-Index: AQHZ5gdNtvCCcdSv3EKmpJJFsE9OorAYVaeQ
Date: Wed, 13 Sep 2023 07:07:12 +0000
Message-ID: <BN9PR12MB52576A87C96AAC49CE9A7A78FCF0A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230913055744.1162406-1-lijo.lazar@amd.com>
 <20230913055744.1162406-2-lijo.lazar@amd.com>
In-Reply-To: <20230913055744.1162406-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90d4ac5e-08d9-4d05-b702-f5b774453993;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-13T07:06:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB8101:EE_
x-ms-office365-filtering-correlation-id: f3a4ee2e-bd8f-4afc-1213-08dbb4280e02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKPr4ImIbWLoUfhMrUe8P6sJkEBN3MnvRfcyruTICVpNOCRb89/8YCQVEa8axhMuwM9R+SIpx2DT87ZcKO+CbVCXBMJHbPul5VfitMKTnEsioIyrS77ZgXz9FQARwAd+Vv0QQD5JsZt/z4QFJmsaCsErKG0m0qN1uzDSmKKI75gzFj8sDofrL9Ge129qa1x4i7HAS/yKkn52oqNeojPeiquS15LIYyH9KtW9Dzjz2vdvjHDJOLqrM/uQqP0l4nGl4j+W365haWTS+MqlnBAqmPxOzEOCaMoNC490tXjA+X5GcbXNJ+KBUdBGbRD1/VMCRfia5UVCWqQ8X7s+4WZ2+Wdk6KZewHwaYKlKDJ3aUdEpv0RLkIcOcMmTgY9ZgeUO1UxfLxdsSKQkiNX9PuNGIPCJnQgtHoWn178zpdEMcJTQ949gUf3knQc40Y153fMf+tztt1p0cqvLaHWqDRrIpRBlhNfmWTDmUZHCsFs7+6nq9/n/RT2I5iqBKVr1ZISWNVI1kdkmUK3zSOSa7LgNlkR092KXwbQaTKUz7CGRHlpvElnaaw9+3jUu3G5Uw0lxt5/nEWoF1xECdItL61ZoUB6TsDMNwqyH7s2iKw7CQsKMr55CnRsTSol1MzrA3oD4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(186009)(451199024)(1800799009)(41300700001)(316002)(26005)(55016003)(8936002)(66556008)(110136005)(2906002)(76116006)(8676002)(66446008)(4326008)(54906003)(64756008)(66476007)(66946007)(478600001)(5660300002)(53546011)(52536014)(6506007)(7696005)(9686003)(86362001)(71200400001)(38100700002)(83380400001)(33656002)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWA9wtXVbDsbX81UOzS9trjqyjdK4lvO2IcfzuRbjuj8DnInMMn5NlbqDT4Y?=
 =?us-ascii?Q?+Knk2sQmvxPjs1mUNsnNJVYD7ul8o9ExeNR6LWOvVTEGDVJFAjYCnK0m2jUu?=
 =?us-ascii?Q?MfUS+nJhQ5Q0wSOGNb9VUna7z7P9iWVbyjz53XUc/L8abMPA2jUTXL7lSqAf?=
 =?us-ascii?Q?u7fumfIxeNnLK0DtDLNyg+pr7m2kjH2YqXxUZvPZUYpvyNUf/bioDQhm0L43?=
 =?us-ascii?Q?SLej8Wi21X9k4Nw6gSnQ2oLvODI4uQHH2wFTJbYB4zaCfS8NQOJ5U9wXlhwZ?=
 =?us-ascii?Q?VoSm5E6uWGQ4hGGMjAyhMXAEe3Ymyy2/njQg1IhdNFRfatCL+xDh3W6fYOi1?=
 =?us-ascii?Q?RVJYXX+ZBFElhGiJglWWz1gMbdXpm9R5NPRtP4EBYw+3ft7Dpk5uBVNZkcof?=
 =?us-ascii?Q?980JY6CQxz/ISlaJbpA/qSiM7qLEbJ70UW3tRcklaO1IPnUu+Htn4f3Z0r9i?=
 =?us-ascii?Q?clNir8iTv13lz4UkecKd2CcfFCwDE1kaBwIxP5cl1gFlkzXIQhYVvzxm8UlG?=
 =?us-ascii?Q?LFc/NIQkNS6QIVu+QbQIN5xcUiTGUXL0WMtSk2ufaH2nVKdAZUHr0+TA5/Xo?=
 =?us-ascii?Q?ACslXNeW3OeO8lCvVNSxSRHtotzi3cjUFvrv3YpM0cYopFrxpb2GWT9pBkV1?=
 =?us-ascii?Q?36bh3p+EMOHmYtzOnKwJL5D1Pt1nLdLwyYDzaUIRrAu2//Gxk9/ILflhY/Hy?=
 =?us-ascii?Q?SqhsGwfjjp14orvDWLfI+XFX/FEvOTl6mndvE6RSUHr8Rj40Ick6/mac5EYG?=
 =?us-ascii?Q?tQyeIb0nZfsJdktA1oKRV5PAAUYzIvMkcBD7/PtIUEZTDbEtDdC81w1tOdOo?=
 =?us-ascii?Q?fgvnD29XwQTPTeXerhEpTOv5asVx5pL6oL+bQvxfsscniqO2jZkYoaBWGHIx?=
 =?us-ascii?Q?XVV1qQDkljH224jboM9q2xKvIdA3iWWIonaWbwx1M9p/5XsXEcrCv47QpUll?=
 =?us-ascii?Q?KXouVxTIFMdgOMP3SqpYXcQENdAPIMiSgm1oO5udl56ikS1FV7/FLm81ekqz?=
 =?us-ascii?Q?XCompV6V+fhM46JGWNFW5D2ttO3VBiuI5Gk/dPfrTbnRnKsVoPac+99NBuA4?=
 =?us-ascii?Q?KR9FLFbbR5OZFlkCTiPjVm9Mlk/rjX3pffdHV2riOwwv2rKnoEpjgvcLF4o5?=
 =?us-ascii?Q?h1utvoxx3WqjYL9xIvoy6cuVyMlSFX9IeKXGh/vWfeuuL8qPCtxbcsrc7DU9?=
 =?us-ascii?Q?EXhh8K1iIShOp82MVujUC5BipC+49Z3+aeSeN1h+WmhnLcNmleJubcNiu61N?=
 =?us-ascii?Q?UBpbYS3Mr164GG3oLWmPIJJbf0Ju8mqSCNjkcFwqq0L/vtoE9JD4ng9faDgY?=
 =?us-ascii?Q?Qv+MZz1Cpt32HvF4NOmvXJT5FpFAW0qOLT42btL7vKWlloGDCdneknBsoSeh?=
 =?us-ascii?Q?iohDy3XiAZKsIGZ3yNz0yzHDTYZ3vygNALnCTe5noEgJ9bkNDXqfpoZncYGt?=
 =?us-ascii?Q?PDQpeCFKp5Ze6X56aN5j1P8op8MJB/J9+RwFTtjEgSkUoSmXMowXdPI9BPfE?=
 =?us-ascii?Q?WBLfh57CiNP2RSDbbePtPWU8E24ZMniH1wqmm9bq1mB6iJqHOf1WyhwlR97Z?=
 =?us-ascii?Q?dLcEfm6bk4DOcaJuEUjU/Px9JciZk9aDKIy/nJvq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a4ee2e-bd8f-4afc-1213-08dbb4280e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 07:07:12.9640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hg5mS79SzQtnK2lmnPGIYKeGYniWz2WFUdQQhlH3LrLPurZzQ5fp0Dnx3uoLnjqjem40Uh6CxjbFc4Co3fwxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 13, 2023 13:58
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>; Deucher, Alexander <Al=
exander.Deucher@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Add more fields to IP version

Include subrevision and variant fileds also to IP version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
        Use major/min/rev format in drm_amdgpu_info_hw_ip discovery version

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 18 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  8 ++++----
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 30f44db6c9c5..d62c245d8ad7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -681,10 +681,15 @@ enum amd_hw_ip_block_type {
 #define HWIP_MAX_INSTANCE      44

 #define HW_ID_MAX              300
-#define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv)) -#defin=
e IP_VERSION_MAJ(ver) ((ver) >> 16) -#define IP_VERSION_MIN(ver) (((ver) >>=
 8) & 0xFF) -#define IP_VERSION_REV(ver) ((ver) & 0xFF)
+#define IP_VERSION_FULL(mj, mn, rv, var, srev) \
+       (((mj) << 24) | ((mn) << 16) | ((rv) << 8) | ((var) << 4) | (srev))
+#define IP_VERSION(mj, mn, rv)         IP_VERSION_FULL(mj, mn, rv, 0, 0)
+#define IP_VERSION_MAJ(ver)            ((ver) >> 24)
+#define IP_VERSION_MIN(ver)            (((ver) >> 16) & 0xFF)
+#define IP_VERSION_REV(ver)            (((ver) >> 8) & 0xFF)
+#define IP_VERSION_VARIANT(ver)                (((ver) >> 4) & 0xF)
+#define IP_VERSION_SUBREV(ver)         ((ver) & 0xF)
+#define IP_VERSION_MAJ_MIN_REV(ver)    ((ver) >> 8)

 struct amdgpu_ip_map_info {
        /* Map of logical to actual dev instances/mask */ @@ -1109,7 +1114,=
10 @@ struct amdgpu_device {  static inline uint32_t amdgpu_ip_version(cons=
t struct amdgpu_device *adev,
                                         uint8_t ip, uint8_t inst)
 {
-       return adev->ip_versions[ip][inst];
+       /* This considers only major/minor/rev and ignores
+        * subrevision/variant fields.
+        */
+       return adev->ip_versions[ip][inst] & ~0xFFU;
 }

 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev) d=
iff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_discovery.c
index 430ee7f64a97..42d379956ef3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1191,6 +1191,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu=
_device *adev)

 static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)  {
+       uint8_t num_base_address, subrev, variant;
        struct binary_header *bhdr;
        struct ip_discovery_header *ihdr;
        struct die_header *dhdr;
@@ -1199,7 +1200,6 @@ static int amdgpu_discovery_reg_base_init(struct amdg=
pu_device *adev)
        uint16_t ip_offset;
        uint16_t num_dies;
        uint16_t num_ips;
-       uint8_t num_base_address;
        int hw_ip;
        int i, j, k;
        int r;
@@ -1337,8 +1337,22 @@ static int amdgpu_discovery_reg_base_init(struct amd=
gpu_device *adev)
                                         * example.  On most chips there ar=
e multiple instances
                                         * with the same HWID.
                                         */
-                                       adev->ip_versions[hw_ip][ip->instan=
ce_number] =3D
-                                               IP_VERSION(ip->major, ip->m=
inor, ip->revision);
+
+                                       if (ihdr->version < 3) {
+                                               subrev =3D 0;
+                                               variant =3D 0;
+                                       } else {
+                                               subrev =3D ip->sub_revision=
;
+                                               variant =3D ip->variant;
+                                       }
+
+                                       adev->ip_versions[hw_ip]
+                                                        [ip->instance_numb=
er] =3D
+                                               IP_VERSION_FULL(ip->major,
+                                                               ip->minor,
+                                                               ip->revisio=
n,
+                                                               variant,
+                                                               subrev);
                                }
                        }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index dfd24a582391..1bf545154e8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -502,21 +502,21 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
                switch (type) {
                case AMD_IP_BLOCK_TYPE_GFX:
                        result->ip_discovery_version =3D
-                               amdgpu_ip_version(adev, GC_HWIP, 0);
+                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(ad=
ev, GC_HWIP, 0));
                        break;
                case AMD_IP_BLOCK_TYPE_SDMA:
                        result->ip_discovery_version =3D
-                               amdgpu_ip_version(adev, SDMA0_HWIP, 0);
+                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(ad=
ev, SDMA0_HWIP, 0));
                        break;
                case AMD_IP_BLOCK_TYPE_UVD:
                case AMD_IP_BLOCK_TYPE_VCN:
                case AMD_IP_BLOCK_TYPE_JPEG:
                        result->ip_discovery_version =3D
-                               amdgpu_ip_version(adev, UVD_HWIP, 0);
+                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(ad=
ev, UVD_HWIP, 0));
                        break;
                case AMD_IP_BLOCK_TYPE_VCE:
                        result->ip_discovery_version =3D
-                               amdgpu_ip_version(adev, VCE_HWIP, 0);
+                               IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(ad=
ev, VCE_HWIP, 0));
                        break;
                default:
                        result->ip_discovery_version =3D 0;
--
2.25.1

