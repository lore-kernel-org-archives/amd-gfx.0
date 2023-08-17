Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F25EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 08:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4815A10E1CA;
	Thu, 17 Aug 2023 08:57:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FA110E1CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 08:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd79UzSrTTjHDQWLrnnIxibFXc4DjII/zLu0wgTcLnTYcBHE0jIdc5apKTvdJoQN/4CIHNzNe7+DTh587ptRmztAgZmAQV/SSfCPC2hdo+d5EvJAJGcVg9+Fhr+6rjosJ9inP9kVRw6YeC+fYHxIAfKoWQN8pv9ZUBO612yaSYj69Mnll42ljhOhoaU7n80PZ4NeCwKreDnZn+/GTGqKckZ+bbVoHBQvFdRBvwbMIsAyjXXJDQ323nvMDhfusi0PuE5qYtjmr5u/bPUc8mVWqnv0cNVPEFXf+Hb1kasjsIIeaVhcUuaDiCOoWettnhsv0xELRbMqlzORBvTypdzsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C7kAmuJGr8M/tlt0skxzl7XmNcP8Zv9TJLSF45wZA4=;
 b=lOzNRFRwxYeK3B9GJk6AikO6qkUBa0I/Sb+lIso+68W3XRzxTL90N7c5O8aIGH/5e04IHGFzS4IKmajcyzLJovl5JjmB/aOGiAAgVtOJXTzpRlgYXg0RUVXkm2KWvQv0UduSyUuGJghm7w+TfG583pgYUVdPVy4By7MfD3UrlSwJDf5K3mNYfL1YLwA2bNE0g358sb7nbCwbSuNJoaB5xaR9uJ8RZg1T96+Op6zCQBtpx/talHYk827vvvnDE0wJ1ZanvZYA5spmAuL8Nr6C1A4ofaeIH+h86Cw3XfesfS+FzA/5ci7ZW1yRc2YbARxyARyx116O1LWtL0dvkPi9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C7kAmuJGr8M/tlt0skxzl7XmNcP8Zv9TJLSF45wZA4=;
 b=WzR9zl2S/GEwb8PiU/h+fJnpZUfbnXZZCv4lSyX0s5oNeIuAfCqOwOe7KrlRfVHfhMuwBpPyGx3kawquiqfojiqYnXlOcTmUMEex4j4RQBgtFMp4uWKwNfPAVL4ZDrZUX5Jp3A/Q+mYONagRavZKN4KoQcAlNzgFWq643ORJvoE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 08:56:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 08:56:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amd/pm: Add critical temp for GC v9.4.3
Thread-Topic: [PATCH v2 2/2] drm/amd/pm: Add critical temp for GC v9.4.3
Thread-Index: AQHZ0D23vhYhFaOJfEaJYIHvQr1u+a/uMPng
Date: Thu, 17 Aug 2023 08:56:56 +0000
Message-ID: <BN9PR12MB5257CC1CA7256A9F7A9FA363FC1AA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230816123201.1195066-1-asad.kamal@amd.com>
 <20230816123201.1195066-2-asad.kamal@amd.com>
In-Reply-To: <20230816123201.1195066-2-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a1b1589a-0888-4753-a565-a3fb7e38c474;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-17T08:56:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH0PR12MB8506:EE_
x-ms-office365-filtering-correlation-id: 750cad35-b889-4c19-e7d0-08db9effe927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4KTmbVNOTG42XaOc3tbBARfzfXGYNRDTKK/o/oORexgoofnqCqvC5ZOh+WS6Io5VRM9D1TlKzF96xcBEIUHFWNKdL6phYBsXntr9vb4Cax5xy16OitSGWGEbLm7qGk2nB/yjR8GwcxQ51D7SDHg/sKqDA+QfVkEnYLGUuV9y2pMdjUxnd3YM397eTzF9fVdDbbe++T91EF1PeJkkqAGf79EreyA/1BsXZrh96GQ271bCBM984dZfxX11W4amuMPIXzKCZT1gFfIK4AhPaufiVWuIoGkLGLDclww1c2bT1OhJ3tLkS5LQl94APNbeF9o0ncO+2GUjdHRy7uUQK3zv6tokqYXK5gdI8EDXpjFxsjOmQZSlw2OqGrm1BZUi1xvsCLz79wJoo8f8R1No12GdHVu76wIAENwib5gKtkL59cTz3j69xpObY8QVKasKEHCoa46xzZIdDAXkzYr3bfecGAVJ5iakCdgcUUrsN5y3nMfe1h0Zap7XzzI5sZKIP1U+iiWelWLLyAIzm92TRAYVehf0xkF/6lUsmGJzZu+GEtKorUlzrhPga+AlMVlwAVXvoovWJCFXDhwgIXscJvQ2ZoW6ULpWKOgJQyRmCZNI2JscKhPjs22RdxgQmbgUIgAW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(7696005)(71200400001)(33656002)(9686003)(53546011)(55016003)(5660300002)(52536014)(41300700001)(66446008)(122000001)(54906003)(316002)(66476007)(66946007)(66556008)(76116006)(64756008)(110136005)(4326008)(8676002)(8936002)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jQA9GRjiCgVv7hYPg2/KZvN1sEd2USR7T8myvgZ4E7qWi9m110MrJsz7FMHr?=
 =?us-ascii?Q?kSpRN7r3DTXdTX7/nlQzOb+k5bwvtlxWmKMAQn3WfX1H79jJVOnHBQYHXAwW?=
 =?us-ascii?Q?6b8T4fydTwkRqNUq4WNtoLFzx+5OFcaLAnfL7Q29rW1/1pH+lIYnvTQhQjDr?=
 =?us-ascii?Q?1axFXJwVPsayYzSeHLq/32vtqmGmhhg8vgXglyBtFXu9tsqF8koAKO8YHRFi?=
 =?us-ascii?Q?y9MxC3MbI0+421cr84EPlht7XZ1uWHxRdjwurJasac69Ee9JO7wDvwqCVyL/?=
 =?us-ascii?Q?+4wQbps5F1Y0viusSt8Cghw3t4JwbYiLMPQkWFkyGipGEd+m5sj5wbxPd2gw?=
 =?us-ascii?Q?ndTSBlyT9Qf7j7Hlnlc8sip6/EXyChdCnua+k6++OewYRt+idzGNgVTHUZoF?=
 =?us-ascii?Q?/bpeL6zu/llrfGuDcKc8AQGdH9pIHBtumPNTeG/0f2Bhz+3ZQOTWJ8QxxQt6?=
 =?us-ascii?Q?JOlx4jC49ou6Gcke0U3AZcFHAccqTSVTpaT6MM80TYxCduJUWMh00pZowsQ8?=
 =?us-ascii?Q?5QzFu4JigN60f1wM+4QatB9L0O48suuiPobEveGznd6upfhHC9XF6q+5whkC?=
 =?us-ascii?Q?j4Vo85nyXW0QIyfh11TvNGDKp/k1+aa/95YljeNxwLi9rmcPyr97L6SneoQB?=
 =?us-ascii?Q?BSl6Jz6ES+N/7j0mZaN8k8OmZnfznZqZpD0xWZOewLNzw5AnYHltMNFx/YzI?=
 =?us-ascii?Q?a6sIvyL86bapXs7BCa5nG3paojHufTuH4l5oUtM/PsiajqcFpPTysUTD4xlJ?=
 =?us-ascii?Q?ZL7qOr+2rV3Gs97QzMYEZl0NnxNNfx4s04GgqUlpcXID1vGScOVxmtHKF56W?=
 =?us-ascii?Q?xbD+MtpP4MZW9J+p4Y/ZiK09Brp3+p//C9Dqf3FhLDejF/fBhNx4o1JU+/Gu?=
 =?us-ascii?Q?0EtX8EBvIfkvw1Osljld2ycVpAChXRM5xlKJ6Vl6v3z42L+Aq7SVwajCX0ll?=
 =?us-ascii?Q?UTRdw93USFY9AZcBpIvczXd16Ad5U9Hed+LWCkWagcnrR8rcvv3xoOTE8kqj?=
 =?us-ascii?Q?hE/c4EmBEJm6I87/KHyRFvmWj3QLiJ2ipR4FeiVkn6n0E3n/NonzYrQDzWcB?=
 =?us-ascii?Q?JUSDEnjGuYgrKBb3QeE6aDlX3volMoXqdSG1oIKly1rN9CSiqr2McdoU5VZ8?=
 =?us-ascii?Q?N022LbktGRm9+5dlFRQCRYRRGiGDDaRyyKVNOEuFg1NOy/jdxWcsNTsf3ef4?=
 =?us-ascii?Q?guQGD46vMzuGVWWWZ7J7+RhzbVMLnJjJQIqWt2RovtYYGjMlM9eg86LZez+2?=
 =?us-ascii?Q?fJ6OJDk2fnvPWLhBR6aEkHJGesn+uiFLu/9XNgm4QjnVuEZFfc3W1dY64aOM?=
 =?us-ascii?Q?VFCZuCP//bQtBOnVqp7zLiB8FRCzM0bbFea25JZgPTnocVhsgsJD3QTtVbrj?=
 =?us-ascii?Q?pKkK8qiCkM0B7cF1AVbz7BuY132B+YN1a+Z3gFbbRX1OMCqqa5C4uInp8gAy?=
 =?us-ascii?Q?ZhPD5lO8+oD8l8C1+Tilqt3ghf4ejHYmUtBTweHwXT1JfP4T+3/ZLP793MoQ?=
 =?us-ascii?Q?sU4D8rkVmSwbZxdtmM8s/xk+DrYah5+LdaYcHYmT7NPvzWqsZC/TAlvgyEFO?=
 =?us-ascii?Q?VbfaiwSB/rmcmibrQYp5OaIK8dFZs0OEJw71uI64?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750cad35-b889-4c19-e7d0-08db9effe927
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 08:56:56.8031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gYbrcg7V0gab34s8miQiBFofV60V7JNyceDDRLeLsT4rm01W439nxqR4/JyTZb6SzhkV10Y1hZhBIQsB0nuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Morris" <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Wednesday, August 16, 2023 20:32
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; =
Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Hawking <H=
awking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: Add critical temp for GC v9.4.3

Add critical temperature message support func for smu v13.0.6 and expose cr=
itical temperature as part of hw mon attributes for GC v9.4.3

v2:
Added comment for pmfw version requirement & move the check to get_thermal_=
temperature_range function

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  8 +--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +  .../drm/amd/pm/swsmu=
/smu13/smu_v13_0_6_ppt.c  | 50 +++++++++++++++++++
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5b1d73b00ef7..f03647fa3df6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3311,8 +3311,10 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,
            (gc_ver !=3D IP_VERSION(9, 4, 3)) &&
            (attr =3D=3D &sensor_dev_attr_temp2_input.dev_attr.attr ||
             attr =3D=3D &sensor_dev_attr_temp2_label.dev_attr.attr ||
+            attr =3D=3D &sensor_dev_attr_temp2_crit.dev_attr.attr ||
             attr =3D=3D &sensor_dev_attr_temp3_input.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_temp3_label.dev_attr.attr))
+            attr =3D=3D &sensor_dev_attr_temp3_label.dev_attr.attr ||
+            attr =3D=3D &sensor_dev_attr_temp3_crit.dev_attr.attr))
                return 0;

        /* hotspot temperature for gc 9,4,3*/
@@ -3324,9 +3326,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
        /* only SOC15 dGPUs support hotspot and mem temperatures */
        if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0) ||
            (gc_ver =3D=3D IP_VERSION(9, 4, 3))) &&
-           (attr =3D=3D &sensor_dev_attr_temp2_crit.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_temp3_crit.dev_attr.attr ||
+            (attr =3D=3D &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
             attr =3D=3D &sensor_dev_attr_temp3_crit_hyst.dev_attr.attr ||
             attr =3D=3D &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
             attr =3D=3D &sensor_dev_attr_temp2_emergency.dev_attr.attr || =
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..c2904791fc6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -84,6 +84,7 @@
        __SMU_DUMMY_MAP(SetTjMax),                     \
        __SMU_DUMMY_MAP(SetFanTemperatureTarget),      \
        __SMU_DUMMY_MAP(PrepareMp1ForUnload),          \
+       __SMU_DUMMY_MAP(GetCTFLimit),                  \
        __SMU_DUMMY_MAP(DramLogSetDramAddrHigh),       \
        __SMU_DUMMY_MAP(DramLogSetDramAddrLow),        \
        __SMU_DUMMY_MAP(DramLogSetDramSize),           \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6ed9cd0a1e4e..7d8af9b309b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -132,6 +132,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGf=
xClk,                0),
        MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGf=
xClk,                0),
        MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDr=
iverUnload,          0),
+       MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,=
                     0),
 };

 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] =
=3D { @@ -2081,6 +2082,54 @@ static int smu_v13_0_6_mode2_reset(struct smu_=
context *smu)
        return ret;
 }

+static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *s=
mu,
+                                                    struct smu_temperature=
_range *range) {
+       struct amdgpu_device *adev =3D smu->adev;
+       u32 aid_temp, xcd_temp;
+       uint32_t smu_version;
+       u32 ccd_temp =3D 0;
+       int ret;
+
+       if (amdgpu_sriov_vf(smu->adev))
+               return 0;
+
+       if (!range)
+               return -EINVAL;
+
+       /*Check smu version, GetCtfLimit message only supported for smu ver=
sion 85.69 or higher */
+       smu_cmn_get_smc_version(smu, NULL, &smu_version);
+       if (smu_version < 0x554500)
+               return 0;
+
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
+                                             PPSMC_AID_THM_TYPE, &aid_temp=
);
+       if (ret)
+               goto failed;
+
+       if (adev->flags & AMD_IS_APU) {
+               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTF=
Limit,
+                                                     PPSMC_CCD_THM_TYPE, &=
ccd_temp);
+               if (ret)
+                       goto failed;
+       }
+
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
+                                             PPSMC_XCD_THM_TYPE, &xcd_temp=
);
+       if (ret)
+               goto failed;
+
+       range->hotspot_crit_max =3D max3(aid_temp, xcd_temp, ccd_temp);
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
+                                             PPSMC_HBM_THM_TYPE, &range->m=
em_crit_max);
+       if (ret)
+               goto failed;
+
+       return 0;
+failed:
+       return ret;
+}
+
 static int smu_v13_0_6_mode1_reset(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev; @@ -2177,6 +2226,7 @@ sta=
tic const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
        .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
        .set_pp_feature_mask =3D smu_cmn_set_pp_feature_mask,
        .get_gpu_metrics =3D smu_v13_0_6_get_gpu_metrics,
+       .get_thermal_temperature_range =3D
+smu_v13_0_6_get_thermal_temperature_range,
        .mode1_reset_is_support =3D smu_v13_0_6_is_mode1_reset_supported,
        .mode2_reset_is_support =3D smu_v13_0_6_is_mode2_reset_supported,
        .mode1_reset =3D smu_v13_0_6_mode1_reset,
--
2.34.1

