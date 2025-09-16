Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE57CAC598
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C031010E070;
	Tue, 16 Sep 2025 09:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQek7W21";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A536710E070
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWVmNSnZXVPc2/2YYXfbMFbdsvHh1/pBVSecy2/N1wRhQaIW8AcD0q9yGnqRamYFFLA2YzzM2UK9GxFeuvHPrRYu+fPzHjwjpPkmrAqmzr7q/bpVulJxBcTjuwb4gLO5dW4shZOY1ueEfJ318Nbq4gulqzKLAGP2GsYbzNIORikw0oL45lSp9KOk9u1J8tP+xoPPrDOK9K1mRr3ubwJ70NxYPBRTgLzMLZt8hTHZjVTk7hsBdjc5W77lZQeDhIkWYY6OmWv3RDqDhuhBQ3cBjepuRReb9rOyAE6tjYTLBLqy0wMkGvf7uqF7dxLH/60aM/BLg7XqasN+icdF3GigJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYqqze5RhXPTtrYGFdoMGFykbggqy/jXBDwt/Eo4ju4=;
 b=WZHibkQjWaZZMJLjbKF/f0UJG7jryI1l4LHMrH+0o5vxyW6raOqQnJaDTm/riF+9/UROxO7xkZeyPG4Z/hdCD+wQ/MG+wqje3DDhwE/Cn+DLcDfFu92ym07h/7PkZDHV/kDbgA6t2mgyGmdWuaTtlN4aXq53m96R8AE1fdi4IFHNt9BSTZeg3ao8RaEzc4Fn8kGwWyLJ8jsxmslHJzwQLzl+1knttJCslz9EJw3U7fEdPwL4timi3oIoTiU2VsCElO3s/PixEHT3WiT4NXeGAi8GBLGvrqSU64EQ2P1kkW+AGgMD3IhH1VUG1ufuufxSFhak+48qqcbd6s3goN1Lcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYqqze5RhXPTtrYGFdoMGFykbggqy/jXBDwt/Eo4ju4=;
 b=MQek7W21rRsBbrY0UB39RF5OHeAyzz6qdOILkdyfTAPz4buNBNAOF4yuha7IK4Q999Vk1U48s/YBWADpVLoH6BV+JNPKef/k4wHp6Jj4rxjgbDzP7zZvCzzKH+9K2PcASNw39bwcGohMmv0qG1GhacRefzsQ6VLH89Or+DYK3VE=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Tue, 16 Sep 2025 09:41:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 09:41:33 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v3 6/6] drm/amd/pm: Enable npm metrics data
Thread-Topic: [PATCH v3 6/6] drm/amd/pm: Enable npm metrics data
Thread-Index: AQHcJukeyOHvfrf5qkmJ43Xb2K96PbSVjTcQ
Date: Tue, 16 Sep 2025 09:41:33 +0000
Message-ID: <DS0PR12MB78043E1F11CD3A864509DA9F9714A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250916090527.2727930-1-asad.kamal@amd.com>
 <20250916090527.2727930-6-asad.kamal@amd.com>
In-Reply-To: <20250916090527.2727930-6-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-16T09:37:29.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DM6PR12MB4073:EE_
x-ms-office365-filtering-correlation-id: 0ebd5887-fdb5-4609-05ce-08ddf50538fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?37tDqZZgULAXSTecGK3BhjGKhM0M9ff7Rpq6Hpdym2MZlxfJ1GlloVxHARdM?=
 =?us-ascii?Q?CYqRIXB+a9HcOnqQ5Y+K0OMxKGdqBUhh1VbrqsOg1GMbhbLS2cq4VpEgTDiR?=
 =?us-ascii?Q?V2Ylj1WCUoG/0Us48gxbuRLeRt187ZULo1kbtEczvABAc+kyhf/Cs2f+VsY/?=
 =?us-ascii?Q?OqAcf0W2kR+NapbO4Ifu/V9Nxup3l9Lah7v9hyZlY4xSQjIn9NEDHcFVitPL?=
 =?us-ascii?Q?LSNY/LQ7P/57U8X88q2fhXfb0RrTSRTAHJTHt/h8tXB8Qu0iXGNkJceaqtzK?=
 =?us-ascii?Q?DzC93ToPuTkf42VQML7pjtvu1q8NyFwx6WKQfVMr2tQjvTOqsRKaYMVG0mGj?=
 =?us-ascii?Q?Yufrwd9/lITBtftX9m2SYOrLI3vi4JXF1MVneFmZc4ccU4XoMzKWVwkRRiN4?=
 =?us-ascii?Q?/EmFVZ4zLkzpq2IF2Q5/RbRfMgkjDG3AvKxbQbiLOmpdNaoYX5PPa0cHMlH5?=
 =?us-ascii?Q?4aDL5U8ttBy1kcgFxA7LztFDSUWIQe3WkFpRJtNcPNbcEJPZgl4x8XQzk4bH?=
 =?us-ascii?Q?cVTB+wR2pIsSZ2DbIwTgH3HzCJ3VCYIInXjCZrj884BM30t+ldPLo1Djm4Rd?=
 =?us-ascii?Q?fQaxp1lKG+S/7Gn7aTAPPUhdD3vX7A3HTLh954z7PHm7nH9lTExch4rEvDC2?=
 =?us-ascii?Q?u+XjholoWoam6wiGT8p6yZQzcZmDmf+KuueipqDlCf5Mrzfp9RNj/B+Mq8N0?=
 =?us-ascii?Q?6Vg1yczM6ajvm5C43E/8E1zGp5LB60/6Ay998QZbxh4z26ppXkvBEPtqPcLK?=
 =?us-ascii?Q?10nUU/XHI+GW9Xa3l6096v4Mh87owOPWRG+amELjunzH14aObynUT1uwwPCF?=
 =?us-ascii?Q?RevrUUEQfLvRx0TF7u++8gy5GcC7QYBIa1q4POKM5Ar73nogTDmMbjecyNrO?=
 =?us-ascii?Q?N8NWpgKMnnZ0TFIc+zDk202rsPThV9kKCGO3tQ8n8i4WijwJUdw7eogIoFu8?=
 =?us-ascii?Q?Op6DCUmkD7v8UJ0oejF9Slnz9sUZljbc1Bqk2TnB6jvmHIllVng1iNDP/2dE?=
 =?us-ascii?Q?BchSueeTEnIVDmqxk9PaJsaQ4NFoHEktifu4mPPhzVQU4HHb02Yfzg0RuYYB?=
 =?us-ascii?Q?i1URT2upvfWLn7FLGEG//DtnIfJ5YVaB5iCW+hDp2aGb06ya80WbJqy6hfzH?=
 =?us-ascii?Q?Blgzn46or2kGiVJGoEEG4SgduOPbb3sj+6kYxvnMvohBbXTFTAv45K7VhdsZ?=
 =?us-ascii?Q?sCiZ7/S6KtTfvPAe0SrXZE0Yh/jwtdotTDkb8tRV1UpPpewohutc2hCH5YvQ?=
 =?us-ascii?Q?BhDJey8335jdYUXyeIRLq63eEB+hDV5eOFFevA5xAWo5yGlU1JZphOHxXJe1?=
 =?us-ascii?Q?HdsCRpg/6fsPMjoxVvFI+Z+XDwTijjP3IWA1yY/XttSSx4XgyPTBap6+AtmU?=
 =?us-ascii?Q?JDONdamP5hbL0rtl5fKT9vvxBV4O8dYltjWn3aasazUnuYByXrYYB83VtGCg?=
 =?us-ascii?Q?n+1JvNBS7vvXHiH5PGa7+aj+wz0CcxLek/2Rnfndl6Onjchkvqm51w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lASaWL8GKPXsRulLpMtVpn8Q3ta7+zla4Sdtiu7AnqPF3DRThknVgXUYTTtn?=
 =?us-ascii?Q?Zwsdc/9ZfD+BqROt4L58K1+CGkjM5hy9S14GCzhj22R1+vaHC866eFM0+Dd+?=
 =?us-ascii?Q?YRYO/5HBDpUGApJ3C0bBuJmSpiOzHDP9jjGZWkMOaLyxEY0fvgvoAdzAnsHR?=
 =?us-ascii?Q?4DBwQ+0U294jI25EJFmqMLcf9H3YrKPCwLropfH7OfX5QpoWwBpplLhLJNUp?=
 =?us-ascii?Q?2ErxPirQI9Htrkuc3tDxeF44K/gK28PSu+9YaOkItMXKQ6CAoF3oCev2RcrH?=
 =?us-ascii?Q?eouQZMVwBZIz8wqdRf7yyixnX6i+tqUyFUhLELVy5YxcPfB+MBag37zB72iU?=
 =?us-ascii?Q?OmhHFa4fhFOcoU1KH+IwJkaYeuVXpOiX20z3IuWJtC3B4bydB486/wm3p0Av?=
 =?us-ascii?Q?pQQdCJ8s4eLPVOpfYX396tpeS0JFE9p/I4pbB6RZU2H9zZIKuKr5mtYpk+mz?=
 =?us-ascii?Q?o9oIO+qc6cfmFFG112M8bHrwVJxyFx2FW/ngRPP6u9tgLjLwQEgal+l35Pyj?=
 =?us-ascii?Q?vyPlW9Ob73PYffh1zeXnLrrTvD0uLylDz/zWJIyVUIjHDUiHpfVJgk6hwzUZ?=
 =?us-ascii?Q?OHXtIRlgQjIHOGI9mV6Redovdh09sYJKfNW98SUV8R4+oIjIKHYZ/v+j+Jgd?=
 =?us-ascii?Q?l20Ahql1dXncKlJ6skBElnSA5UEVHhfw0j/LOENdP/vOaZcc6A5slbcHfNLK?=
 =?us-ascii?Q?OCdnDZzhsM+bSSDLkJMPRGZicFAzj/ja1vRWDddlQqQ1Nk1HdLMoZmQwYNU0?=
 =?us-ascii?Q?0iUEQyjRYjp7Tt9pPBzxRZboFovsGgVQf3bjcjdo/WAqguWtKkA4bRM5NPwC?=
 =?us-ascii?Q?KPeX9bnaaXhDHCTZXN/1LK3cUPdPWLJ7MCNGIixjiuW6yloRIgF/U8OvZzml?=
 =?us-ascii?Q?cQ5kVTP59W6xYaqfjhOdOtD8ptdtbnx3zi0alui6ZNQXin83322UgJKw0Z9C?=
 =?us-ascii?Q?h5nOBAdPOcfQQmbxcyz9tl1lCGD6qZVALbxQBKmK9qY5va9yBXnqLTSZi2LZ?=
 =?us-ascii?Q?SnlD2oaIjquP3D5a7HRqxJZMAeWid3YDrkPfrSi1WWS4EiwPWNd7leAkJBw9?=
 =?us-ascii?Q?uOOdG782v2sP6FJTZayEAtAR+QzvT1apmQPZjDVzvFs17ZBntjejYWhRI7Va?=
 =?us-ascii?Q?Md2DnBPS4O9zuomYmnViFRbw64cvcWo/5/+Bob4RkSsdIkDRNaA/zE8G/bAv?=
 =?us-ascii?Q?Hp+HJcwuC7L/6rDYkkq0HmF255he1WvAPvHoXOBT2MxcNkqydJU9lCR5CjH0?=
 =?us-ascii?Q?8B45NuJuLd4KQ5aV7g+muv90Fou0LYiS5sAA/brjgt8SIgx3r6sEpbGNDRne?=
 =?us-ascii?Q?B7xVufvfPK0EtTPNlFZ6Ac1ScqMzloTqKJz/qCJ39VAOT65/FOQQ9jZCLMMV?=
 =?us-ascii?Q?ToPZE5U6Sjeisl4gynJkM8jHuYoTYpUJadgC36BWQwnweRbsoY7PjRPIa3mj?=
 =?us-ascii?Q?g1mufvcXlHzZHphPp+CcFvNB+dHbXIuXhb42En6X9pwFxDroKqUBW9qvGIQ7?=
 =?us-ascii?Q?OFNy8bW6bZwRhTtEOhyngzpH0T4XsyxovdhsKppLVAoLlTtUX7jrI8UBXHBL?=
 =?us-ascii?Q?MNBav2geJs2IkcTsedc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebd5887-fdb5-4609-05ce-08ddf50538fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 09:41:33.6235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lUJ0s5OJZxbxqKHM59NYGRLqOwJKdEI8D5HVbwEJ4sZOcO/+PteH4RT8hVjxYG3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, September 16, 2025 2:35 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH v3 6/6] drm/amd/pm: Enable npm metrics data

Enable npm metrics data for smu_v13_0_12

v3: Add node id check for setting NPM_CAPS (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f749acc7d48e..03b6a9969174 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -356,8 +356,11 @@ static void smu_v13_0_12_init_caps(struct smu_context =
*smu)
        if (fw_ver >=3D 0x04560700) {
                if (!amdgpu_sriov_vf(smu->adev))
                        smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
-               else if (fw_ver >=3D 0x04560900)
+               if (fw_ver >=3D 0x04560900) {
                        smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
+                       if (smu->adev->gmc.xgmi.physical_node_id =3D=3D 0)
+                               smu_v13_0_6_cap_set(smu, SMU_CAP(NPM_METRIC=
S));
+               }
[lijo]
        Keeping 'else if (!amdgpu_sriov_vf(smu->adev))' here may be nicer t=
o avoid multiple cap_set().

Apart from the change mentioned in patch 5, series is -
        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
        } else {
                smu_v13_0_12_tables_fini(smu);
        }
--
2.46.0

