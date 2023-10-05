Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA15E936ED
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 03:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C134110E1AD;
	Thu,  5 Oct 2023 03:40:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F44B10E1AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 03:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHm0H2YyhLJAArSielJLbCnGLoBDrOjmhgLb0rVVrN7nphTQQjS7ZxKqiUdmKp1QqJUsha6tWX5uHUy2gOlnpLyNlijVgFtBZ2NULalfVlNNPNRDVguddICDjXixWW0CQ+MNv8abzdP16TahDGzaZ3zN72zZqlKYZAT47FK9auzmbDVzBUs5f9dDA4TY0FeAQ/ifq65zduue6TG577OOBfwKyGKq0++pjfyaHcYZ8fQ6Twyq/oUHhXB2zoVka1wtyrYHtMmtZZU3cXyyU7xCH0o7BCEHcusi602FSx0osfnLXaZbemjv18Vh3xcmbfZNw9Y5JSxjXbUXB39Bf5fMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j3LtaMhoilU/oXhq75/9i9qm+ODUph2ggksqjvb1fk=;
 b=L/ZxmCgcbHPSd4e2un+an1mZcxNrPU438p00kOyfl1Ayyb1xDMFxIkt5DYCAvDxdN1aGyTE7DqQPLJA413k+lgaykMx0+r+YqVsfhwh42h3KIYFKPc+x89ZUCqoAaFjGqkUrEZRbd367t4s+nCev4rd1E6majqZTKGJyPwDKAL3oLqvRg0cDKH+SmkEcv/J/6HRfOd7M21P1uqSA89VSZ0HvjFZa+LirVyFB1ZxNk6E/5d+01dIx65PxbpkseZthCsoyV3KASvVRstM9rTf9h6HzCADq0dW388TPeR7IZuv1gxS0it9YXZ5geDRpuusyBX3YzOcCGx/p1LzJ6AgdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j3LtaMhoilU/oXhq75/9i9qm+ODUph2ggksqjvb1fk=;
 b=Z/ufJ8dqQP2GCpbqJHIyPJjdLPeRmyzPupzKwudsa9grKyHldKJ+lNbvADWIwlMmS6gUxPvlD9gjmnuTPDw2iI91PocJdQr1wTBKC6GvrCiMPkydV70Z7jBw8H8UxQ6PyoJNFEqxO8V0g3Btg5RKUcvxzoP0dbXAKgvWWW/LPr0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 03:40:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 03:40:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active (v2)
Thread-Topic: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active (v2)
Thread-Index: AQHZ9thIe/Qxdiefxk++tj5fDsmIMLA6iz6wgAAArRA=
Date: Thu, 5 Oct 2023 03:40:08 +0000
Message-ID: <BN9PR12MB52576BB64B4AB77BBA32D6A5FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231004153410.895387-1-alexander.deucher@amd.com>
 <BN9PR12MB52571DA4201DF6772AE601C8FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52571DA4201DF6772AE601C8FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1d64daec-81a2-4339-85a5-b618c7713874;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-05T03:31:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7228:EE_
x-ms-office365-filtering-correlation-id: 68f06d3f-59ea-4fc4-c1af-08dbc554c5d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z6I6XutuL8F8yDKSahVHgZKNjtPcvj4hRvyppNWQIlHXgZDtKacrtsAc+O38kpDQj4Sc/H4GF1BYmA1/4f6P/k19uh3WB9Q8jJ6NXHgFw0ZpjgXsCjl0uUUOi3zmBmRhwkxg7dVldpRalzacP6bRuN7PCFlIPiEhDbp2B8rAmBEDRFkftgwxhhKG8S/KmeIXnhwrKDd0x7LIA1LVAOKliVJAYpQG/yNgL3N1Dmw22CgBFQz6WEXHaviQPO5GTq3DPHYq/Lp4EWQod2fgd5vhshv8U0FvccZeeY8VUjJOTl3zF1vvFb1qbjEYQAHMu1+pMl7+1LRRH/SOYlqrmElMwJFmmRA2qa2T19V0q626kqunB6l45wzSokKGaES7fkHUO2tkH8IAxKagoc4nbWiVS9ONMMsAyusrpCsXCIh/+8QliAWa7yR2cAe0Fav8jXjxc9jgOwxO0Cu2NIazQ/jpDxLrQmArx+AL4G5n612hqZ3qbxZABF4z8KDB3UutMa1USNwh7qjzm+ew4npZbexNJ/GyBr6uFBXtD4n4He18/eIGXVL06NbXCdI7S0j2O7FV+3Ch09b7ViK7iuHpo8SFWKnKM9Gqc1j3h3dXK2bgranNJiIgF6aINtBERcWUxoNk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(110136005)(76116006)(2906002)(4326008)(66946007)(8676002)(5660300002)(54906003)(64756008)(41300700001)(66476007)(66446008)(66556008)(8936002)(52536014)(9686003)(478600001)(6506007)(7696005)(2940100002)(71200400001)(53546011)(316002)(83380400001)(122000001)(38100700002)(38070700005)(55016003)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ju7Rv5pANAFmWNiz6NGc+g9GINLBYhSGJ82+xADsfnvi6PVJ1JKcqU+Lt6SM?=
 =?us-ascii?Q?Lx8a7h6itiHxqRjo+Xhj+PF4Ogz2zgIezVk/LAZvNTl0bohTeQk5/42QsuqE?=
 =?us-ascii?Q?VIrvIleWZ+7/qMEr0I1FyxReH7EOWqs1fjasOu/aha/pov+649NvMqDmX8Xg?=
 =?us-ascii?Q?hNLeAibHU9zKwwXKmtayY8PJeEYSMUXsj3LwVR9rRRME+krru4nhwCNCjZri?=
 =?us-ascii?Q?vpcKbxqx9XFotW/bvyIvQ9zRjzUEMmS6VxvQ/qIHoc2Z1nPAHKgsoMcz7lVy?=
 =?us-ascii?Q?2sFf/kB6FAGWSTbr5g5KH9tFm9t5Fn/bxo5/7b0LzuWfCJDJVUqkgg/PwqFf?=
 =?us-ascii?Q?CXf7YE84kooRQ1/zTm667skf1aCu8zoiHlcUhFsqU7PmoLOK94PjiHQbf8Fq?=
 =?us-ascii?Q?POX6F+n0czzvKd0L0aatjELZCms+Z1jSgxb1fKVZk6f5GG4MDzQySd+CczNv?=
 =?us-ascii?Q?XzxpxFyqoIFEaFEQ9u9UvgxYjKzURedsxgTlq9JRfIcMGZqHJWyrK+Co7rOU?=
 =?us-ascii?Q?+ztWV5LDePHftC5fR8Bd0O/6avvHSe/QHqTUlen6uTKgjAPhstVVT3nMiJ/t?=
 =?us-ascii?Q?w2I2iYNuEeOu9T2/I+vqOksqYWWFLVp5I4extUqG8JFLYzVNkRJy2Dsq7208?=
 =?us-ascii?Q?YecpP8sAseNT9WXe5wCwDZ+HL8VlGQmezGpQngw9WZMOGEk9mC9vYWrrzfUn?=
 =?us-ascii?Q?ZPMgUcQqJjMGRWwfXKWI41Lp5KLJnqF3LJGLCgRu1/70dgCFFXth4mSANWQb?=
 =?us-ascii?Q?UbtFhevGGXiqt/KIA+QfCwPl/USWKJc49eIU/erhMI1tEcXd4lHu6+Cv/TnZ?=
 =?us-ascii?Q?uKCbbatx1ZMlF4AYFI2ilS8kqM4puQUda2xfMGm/tmjqIlypv6pFWZ2dl4Z/?=
 =?us-ascii?Q?mNDugYbEndv4Iy3FXXRKJWq9/8apz1SI0HRC9uhaseHvqdICNUBb/R/zUoFF?=
 =?us-ascii?Q?zvtQY3VGFW0ZXHHp2dX+0MvK+PZmi3RMFWXKFFoeVn7czDOJFYZizS1bXdmA?=
 =?us-ascii?Q?5FAX6lNs7TihDnspzh7NWPIod+1P+MWy6uPQZFtREn/1AyXCEK9o+vos2S51?=
 =?us-ascii?Q?6M3VCLIT8t8eWpCMmy4iN5jHjmodvLctLxZ1oCkl6oRd4Pe/EFabG8+3tK3F?=
 =?us-ascii?Q?szEYc9dNmeufFX0jBkTPi0mvwDUcsuu6nGqfCVirWTo+Y4BalqoDlMpXxMTl?=
 =?us-ascii?Q?H3RxHXO97dnlOmoOEPiYI4UZPO0tiZe/PJy0bvhvMXg3DVleSt4k8zkfaGFV?=
 =?us-ascii?Q?LXO4XvWhIB5Tiq+cai+MXZRmO10ym9tEmYyQ1JQezAOB9RtNqIg54dheFCGW?=
 =?us-ascii?Q?faDwrDKDVoP7avkSFkxHc+e2s6xX7vdMdLMkbnVcJOjRtafERp+6uTHN62gg?=
 =?us-ascii?Q?y1D8eM8v8aB00dVyqASZDNyqqTgmt24XiPw/SrFL/Se/VVJVjV4N6qCYyld+?=
 =?us-ascii?Q?5iFwQmsEuJslTVSr8gXqAsjww1D7ig/5YBjARv3upircsudU5usLxYjVGGPg?=
 =?us-ascii?Q?NyYYkBTCAUxf8v+Sk/qo9lhVQdLMdxiu+qnI1dqQEmKyRJhtxgOZaIIvwxvZ?=
 =?us-ascii?Q?LrW16KuAwKsV6oickp0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f06d3f-59ea-4fc4-c1af-08dbc554c5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 03:40:09.0099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YR38RtH2XdovrVRHuYj5Mj3Ca3aVHLmFEtwEnGOvY4u+YBYE5DsIzSlXrwZhvbprjDJY8WCNzsaUzZmVXUwk+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hmm... thinking about it more, will it override the profile mode/workload f=
or 0xC8 or 0xCC SKU as well. In another words, does it mean the pmfw fix is=
 general to all the 13_0_0 SKUs.

Other than that, the patch looks good to me.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Thursday, October 5, 2023 11:32
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Kun <Kun.Liu2@amd.=
com>
Subject: RE: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm =
is active (v2)

[AMD Official Use Only - General]

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, October 4, 2023 23:34
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Kun <Kun.Liu2@amd.=
com>
Subject: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is a=
ctive (v2)

From: Kun Liu <Kun.Liu2@amd.com>

When ROCm is active enable additional SMU 13.0.0 optimizations.
This reuses the unused powersave profile on PMFW.

v2: move to the swsmu code since we need both bits active in
    the workload mask.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 684b4e01fac2..83035fb1839a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2447,6 +2447,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct =
smu_context *smu,
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
        int workload_type, ret =3D 0;
+       u32 workload_mask;

        smu->power_profile_mode =3D input[size];

@@ -2536,9 +2537,23 @@ static int smu_v13_0_0_set_power_profile_mode(struct=
 smu_context *smu,
        if (workload_type < 0)
                return -EINVAL;

+       workload_mask =3D 1 << workload_type;
+
+       /* Add optimizations for SMU13.0.0.  Reuse the power saving profile=
 */
+       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
+           (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 0)) &&
+           ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
+            (smu->adev->pm.fw_version >=3D 0x004e7300))) {
+               workload_type =3D smu_cmn_to_asic_specific_index(smu,
+                                                              CMN2ASIC_MAP=
PING_WORKLOAD,
+                                                              PP_SMC_POWER=
_PROFILE_POWERSAVING);
+               if (workload_type >=3D 0)
+                       workload_mask |=3D 1 << workload_type;
+       }
+
        return smu_cmn_send_smc_msg_with_param(smu,
                                               SMU_MSG_SetWorkloadMask,
-                                              1 << workload_type,
+                                              workload_mask,
                                               NULL);  }

--
2.41.0

