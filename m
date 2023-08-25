Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A806C3DA66
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 03:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAA210E5F5;
	Fri, 25 Aug 2023 03:21:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E0D10E5F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 03:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Woga0jthddscGy38FTZavyHceKuncN0hZ+0sK+uj67itVtyTB1CAR2wAuV17wvqSS1ezF77F78dZ0iGdMaAoEn1xKJ+YpeRKkBV6eXWQWPz6QHpLqoakAKMCDPKdntkPYKCe0EAzgHSJKZVoprbQT9LNvfQGX1f5H0dsxYohkCCvOJH2oFdMyzv/MWgpj3d6h+HEn2TtNuggZvuUN94q6jM0QNLoLgT60QDjpbVo0cK7wtR6ujUrnzHnSGtLVFwqtNrcES1L/hdGMfXyqL/B64xqSsVTkuXiAGZTkQ/ajssn7B+KlUoh8NmpoPM4xsLJs4mbsqusFHxFHw0QF09LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf3LzUQYP59uPNSLnNom7LwAQ0bwQWx41j4hx/Fhjz0=;
 b=dYtXBX8phKRK1NcfLpnY8TdoKqoX3pJZwsnaKHcIylT3j+J8Cg0YOrwvgceMzpLyJjKh8pXrkAnmjeTazC9A8k6+ACwAfmFrnAiOV16/IzSUb/JB8fSjFb7NxWTjfN3sTX7mp0QzZrwtfu3ilipBZous3tJWQHoTmTeqOyMw8j9pPIGuN1qd+fiS1b1xbMVp7CE8aEsWh2ncFBuOZYR+0HPxzsUHbAENHl2DM4vY6m8vrx/2QAtqgUHyaln8BVOcsn9BJF19/dMos4kIqRies0z8RGreGvTYCJICu8qSrZhKZ3irlXjKWHsKT1DPO7Z6X4pfeqDq8eV3EPvB9k09Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf3LzUQYP59uPNSLnNom7LwAQ0bwQWx41j4hx/Fhjz0=;
 b=I/t8Z2xu7UFDbGHpzQZ3oEjD0d3dSo2LM/GTt9r/mUE2iTrM/8WzMfYqpio+U0jTwzz89qCvuRmPbscO/RkhXChVJZK0mfkVj+etAe2A8umlSV8OoN+jvcYHXcpyg89m6ins/na6iHVSHZTbZgraahb6a4JHhj25JWLOiiUeTGw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:20:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:20:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: workaround for the wrong ac power detection
 on smu 13.0.0
Thread-Topic: [PATCH] drm/amd/pm: workaround for the wrong ac power detection
 on smu 13.0.0
Thread-Index: AQHZ1wL805mVt6H9xEibksvxE+yMW6/6WCXg
Date: Fri, 25 Aug 2023 03:20:56 +0000
Message-ID: <BN9PR12MB525733FE26982B22FCD1A7D3FCE3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230825031926.1932471-1-kenneth.feng@amd.com>
In-Reply-To: <20230825031926.1932471-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=20f85140-615a-4ef4-bcc6-96e38f7b2581;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-25T03:20:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB7780:EE_
x-ms-office365-filtering-correlation-id: 93143538-265e-4f4a-4b5b-08dba51a4c28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqxox8BOxdYcetR6O9ZjRrMWJG07o3+C0A8P3DNr8C8468otK668KHA8eqSmoH8O7eWhZ3HrnKwa8YHK32pk0vVaSB5SgccI7tlB+PMFZxcUxQfyf8zzNbPUdUsbR2Fq6j1fLFj2CjEKBEJv7/rX7rgnSDvOGcKsX92fJyaPxLx5igqIcfV3Ml5mGOaigkbuhcZNSPSOQ55BbBXYaabEAn2CLMue/fktukjo38FXahiw+TmjeVv7yB4QNSaD4btqAqVhqWWWhv0cQsdkl1iETFWTzOQhPZLlFjFnTYVdf8l1u0EoPyCVq//O3TonOwSENSZ9Agtjq2frAud1rrbmmx/AwqwlAXDr8uYwF/rzGIqPN+ija1AECk3ABQaKp/t73xVnwdO61v+vRSoAmgr+t2t6cdv1WeJ4I+ZcdIZ89yLSibDHzEgJFU78vKLilbVUgNSRlfzZjs2EmTkAHJqURg33GiMkAFOOwkBXlo5FDEK9AKg8xMtlR36hgcpIi0MdYhZbZrQVe1mMqvbBiCO180toJTNkTumFweNohhAvTDX4MUvNBeSRzCub+DuYuBUnPQHxVbQIgBuSMcn3omvNpvZdFpCEkLZhgCFFzmH6WsF1cIiE6bpoTlerT5bXZgSc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(122000001)(38070700005)(38100700002)(4326008)(8676002)(8936002)(41300700001)(53546011)(6506007)(7696005)(316002)(33656002)(66446008)(64756008)(54906003)(71200400001)(66476007)(66556008)(110136005)(76116006)(66946007)(86362001)(9686003)(55016003)(26005)(66574015)(478600001)(83380400001)(2906002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jpN+CvXIS4Mb4BwmRHGSOhV8SA/yfhcKzzoCq2XaecaPeSeLFDZmuZLi9cjp?=
 =?us-ascii?Q?+cpJhr5hTy+bzKfVw7oWSEJwRDQmtTwNKGt05RC9USahaN5vAR6emfszz2Ro?=
 =?us-ascii?Q?7K/iTkgjcYpaeLFg0+Q1d5sWmG34kGIbT40HKEHj2ROXRn7qNASHpe9sgyZL?=
 =?us-ascii?Q?q99vB34QIH5h2JtEICUqKVf0um8995G8KsrwArRqqlccneE8zaTkaUGdOLGZ?=
 =?us-ascii?Q?CD0IFqTtC9xBuh+cVbMRS1kS0y2PB4psVn5TQtlpSD8VVM6LgmmsddvLSSe1?=
 =?us-ascii?Q?iMC07a/nwwJdVf+XKpkRK0AEnlNtIVYBv7CXHtI0Od2pR/tlwKmVxppbnb/j?=
 =?us-ascii?Q?KLkXBs9RzcpmyKw/oUly56mvlgp4MMIpRwHQgXiJFfPa8HnboNboGUpfnzyu?=
 =?us-ascii?Q?t5YehkzmMQjO6Of5Xw3Kbq0acd7vYGLieDwlUt69uevVw0ZK1faJyvpKiBTT?=
 =?us-ascii?Q?+hmVcdrmgkkDzRGDPHx/+eUOhH8aC3BvhSb2ya3LjfBKr/EY34my1FiIkpFB?=
 =?us-ascii?Q?QGYite+RNdjSt8Db0OAn8CE7jwmLs66Rp/10TbPWmUbCHGcBbxdv0ayoE3Bo?=
 =?us-ascii?Q?iKpzCs4pdHvuMC/sjPr6Px+yA8OtuNoE9lf31qi7JuTdcoqJszfE+UWMrS0g?=
 =?us-ascii?Q?cSfJTw5vt0bBRsgXUdo04Hd4PVE6fV7agc9AkbEG4wLyQGg9WvvzZskf9wt2?=
 =?us-ascii?Q?69adQapFm5Plo/iiWF14II0YC69XN56y9FBG/qx0QDDtEVwoAeJmxMO6dBlj?=
 =?us-ascii?Q?HNhIvKIhRyllGsaf4aZxSNZmFvIoROMiboW9DQ2rjQ1qu86TlQCVN7AclqWf?=
 =?us-ascii?Q?ALvUKx9m6DLEiemyqoSIhV1Jk00zj+fudxCDukHqU/5g9L++vSXd3LzAIXDl?=
 =?us-ascii?Q?xhZZrV7g59ycCkc/6tdtOVKKyouDqXAxKMA/0OxLBc9p1JsEIFFKyZ00m6zK?=
 =?us-ascii?Q?Ui5SnV1Clh95n6lv6BxiY8Ffr/RPLN2S+sYK3yxfqH9aB7AbJnxDLRdSwlpC?=
 =?us-ascii?Q?hv6Gq2jxDSgakKRlVgCQPo+LmPvgPtuHMkzEmzk++FC1XjPfR3BR6CepvMZm?=
 =?us-ascii?Q?KYAGEePzFpdB0EBzeisLsB8oGxw3csKHZWvRZQwOGdMw8yh9ADO6z2kju2Ov?=
 =?us-ascii?Q?NMtMuXS/grCm1sJNI698LY7LPbv8+NAB3m+y+Il4Xbnr55Mv3rZZyoqsb87I?=
 =?us-ascii?Q?CSe9AsdTUDYjB+/g2wK2xNZ28mDVx+K1oFzuD0mxVWbmynvOWiRlnIWmb1tY?=
 =?us-ascii?Q?s2pCqGduXMvgGcF/Avl9EPiDmSsmblQrZWF+6Da2IzR4QgJwM4IECC578NGG?=
 =?us-ascii?Q?SvMkuPUklja8Ba4dnDrqB0oDlHFaRnhI2TUVRs6OzmHdKmJSNW0ja9ZDLFTA?=
 =?us-ascii?Q?wnvTjaxedcu1kYRyWjB/X2tVQo+RxuhnqGoMbz61oagG1Bd0s2e3MYqHbqGd?=
 =?us-ascii?Q?LTfiD89LMq6hZtV/9TbQiMhCRqd9+qGXWjpSOIjfJQRpZZMl0nes+Uc/BZqi?=
 =?us-ascii?Q?dggSRFHmE+OFwSJ/3N/jUxaujtKRuDH2pQWpCzovgS1psFYnmv4ofiLKe3fp?=
 =?us-ascii?Q?pHS7ZAncs8mxX5lICMO0VvDIsToq2lgin+LYLoH1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93143538-265e-4f4a-4b5b-08dba51a4c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 03:20:56.8130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxXvuoIjGeYjvW2GrozlAaMLLtQs/YNLTCK7bIvprTphCbEyB0B1b24+qw1TPU8jLZH/jvdEJXE5TJvD8DWwIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Friday, August 25, 2023 11:19
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: workaround for the wrong ac power detection on=
 smu 13.0.0

workaround for the wrong ac power detection on smu 13.0.0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 +--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0232adb95df3..fd1798fd716e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1021,8 +1021,7 @@ static int smu_v13_0_process_pending_interrupt(struct=
 smu_context *smu)  {
        int ret =3D 0;

-       if (smu->dc_controlled_by_gpio &&
-           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
+       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
                ret =3D smu_v13_0_allow_ih_interrupt(smu);

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3903a47669e4..128468355375 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2664,7 +2664,6 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {
        .enable_mgpu_fan_boost =3D smu_v13_0_0_enable_mgpu_fan_boost,
        .get_power_limit =3D smu_v13_0_0_get_power_limit,
        .set_power_limit =3D smu_v13_0_set_power_limit,
-       .set_power_source =3D smu_v13_0_set_power_source,
        .get_power_profile_mode =3D smu_v13_0_0_get_power_profile_mode,
        .set_power_profile_mode =3D smu_v13_0_0_set_power_profile_mode,
        .run_btc =3D smu_v13_0_run_btc,
--
2.34.1

