Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9FECED628
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 08:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1967410E67A;
	Wed,  9 Oct 2024 08:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hpTYUx/8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF5510E68E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 08:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/E8MRosODJiv4RtbqtIKi7lPOvkVFUIurTsMjTzSQwls0eqyZiNblPmCkTz3WoSEqy6aNZY1vSNMhPPraj9tXqc6Ww50QLt+u9115oBuGEvFr+Lv8FQi5caMvet9dHwUDe6h4SOC66kVm6g3/y7n6IO9MDc/i24EFHw91s4APr2oBi70cYKJzyD6WcXm3AXL1WhofA3jcf2YUYo1iL/CAkZfFr6TcPYMklEYNvUVOdiCn6wEitR6Ka+2YlOStC4ZhcmUNDKD8cXfGb8ODG/cAQhbi9Oq0NkX9Y8uqnZr/SV3/En80MT8N4SpBC7FSrnnQ09Z2q7x4ci9Yj88mtNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CRpjfj4UwAsGDhyO/DMzLCIwoFoowdMlDTX7yLpcHA=;
 b=R1nXwyrOh8Z2CUSbMkR0bTZ2Ijmg6bYGTLLbYyTuRP/w9fNTVhgcWHxU2eRlSxCzRQs/KbpEd+mLBBk9JeHYw1YwDjLcBKX6fn2QSD9yhWoUibPJjKBVE0mogFJpehPuW4g9/Fc8yr25WFX0tKk61e/QOwK32ar+mZeUjbmd0nkWFCDHZgWBFmF+WEYzTnv+SP4VyTa1DMAnnQnfchl8E3stLactDJqM12a46is4nMTptX0vhJJpcAtx+1TEVJQvgnjm09SxFMYh+qhrbOfu0tcaI1Q0CH+xddn2ulINRCYoZQPSFDqMTZBeDBbyjQR8Ynved7Y1KiDJ5Qw5RmoKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CRpjfj4UwAsGDhyO/DMzLCIwoFoowdMlDTX7yLpcHA=;
 b=hpTYUx/8RLkBvGeC33miJbt6SCbY96P7eoEG1KeLRI2uyf1pEV7ui/N8qv0StVW81IQPi/gMoH8fvxAXp97PvG1Mu7tQHYshjUxsU/lCfS3FhOk8NWUepqHBvf0PiFyjzk2NqraVxgreW04tP2eiqMmoyDS0dCH9GFHI4OLoYLI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 08:08:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 08:08:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Bhardwaj, Rajneesh"
 <Rajneesh.Bhardwaj@amd.com>, "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "Xu, Feifei" <Feifei.Xu@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Add NPS switch support for GC 9.4.3
Thread-Topic: [PATCH v2] drm/amdgpu: Add NPS switch support for GC 9.4.3
Thread-Index: AQHbGYqLC8CRXfYIEE+wLs2XUnBu07J+EYuA
Date: Wed, 9 Oct 2024 08:08:03 +0000
Message-ID: <BN9PR12MB525725A9CA863BEC58DF6BA5FC7F2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241008140051.2998777-1-lijo.lazar@amd.com>
In-Reply-To: <20241008140051.2998777-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f8a00009-0536-4a64-968a-36e7ecfed29e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-09T08:07:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4321:EE_
x-ms-office365-filtering-correlation-id: 78ede02d-9bf6-4d78-f3ba-08dce8398031
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bEXd3NdCMJ5rOEOatxfIQBSyqpminQ4Dyjh+Pre36CNPQmCxfFNLRyUD8Ykg?=
 =?us-ascii?Q?sotPUKENUmqzPp9phdRKTM9yL3DHsCj38PiQXqEMKtSzl7s341SPsT9uYUsX?=
 =?us-ascii?Q?8a+cmRH5KDf3WSVC+aDFKJEPdRD7seLO5iQSlBzmUNcCFcHr1v3av4GV1cfu?=
 =?us-ascii?Q?VvI+m53o6+U7EvWOsvsoUZID+ITGLtYcSNbUsJAtObXy90DMpPgMTMC/Bh7i?=
 =?us-ascii?Q?aYSItGU8LHP1M0/tVD2PZrA4cbjdRlL6fh80XMyVkyKXxBky/k2SdXo7H4wq?=
 =?us-ascii?Q?fKTMoZ5tYHlv+gynkPM0uHaAvdK2fXMiD9DRJdL9gby6sPRZx6x/aTG0NHzg?=
 =?us-ascii?Q?QXXUAfZrYf1x9tuJt5JpfoG35CZ3VrJI79xodmVFSan7OiqfbS1Gj7iDc07I?=
 =?us-ascii?Q?Q3Y1Z4ErqCRSKTsfDsVf/UAry1QQsi2DLhr1mKu2jtp49+oxdbbMuplcjW+L?=
 =?us-ascii?Q?LCMS+68p20WeZTn7M5F9OMfcZad6sjVGM5QhKnauD0OoF3vBe9JHg1lSqHPO?=
 =?us-ascii?Q?gGBaozN+DMKfP99yBMkogihFlZtCw/v5xAQcKu3TwI0ZBfUwhHvnFrXPmCxt?=
 =?us-ascii?Q?YFWw/5vTldy1V01v0CcWQsddTDw3xJJu09898M4r+UVveE5ZFMPaPpjcy9wU?=
 =?us-ascii?Q?r0s7RLwn7W/HftPLsryGgxfUuQLmFk7JLDQxR4Ekyi40mWHjLoX5+IXPb6kQ?=
 =?us-ascii?Q?Jm8nJEdt+22u3Gu10hloKKuP2QsDI/KNDQ3ZZyMfdD4wS2fJ5TtOV6ub0AjD?=
 =?us-ascii?Q?jKClps4Q0tDRjGj6FLIEd0pldAofDwSKwsmIVHI1GnUgX8iFOSsh2latd6x/?=
 =?us-ascii?Q?BiivmCjedrgWbG5fHGhVH3cMBR7/Dij4Tj/jUyYOO8N8UVK5lZ8lIjnVswzH?=
 =?us-ascii?Q?LjlNm38YK6YU/qJ5fd/cojuXfYmAP4fXv63M5SJ2tJb39b74dYPTqLZEMP9B?=
 =?us-ascii?Q?JUAmlAcR1h1n9SbIDYo0dv7VrVj5L6kliYV9nR/aM4uep/bxInl8I0otx2A6?=
 =?us-ascii?Q?mofDMdQwN/3h54ms/ipsmrpOJ4RuXUhtzFj2qTY3SIW0E1HoG3uXg4db2Cx5?=
 =?us-ascii?Q?3jbtd6Pv+TCiRwESECWCbSnsMYpJ5Q22D45boaE83vd0t7u95G0CMnjkWYGA?=
 =?us-ascii?Q?+6Wq+h7NvoRILD4izd1f0AWYbjz6GOxzT5lFgWye86olL6tYi+RZBGDUnS+N?=
 =?us-ascii?Q?TC5v0Y1wruurAxGZfvVunuSeU0pcst7/QGvL8DSrXx5E99p7KSyq+23Wb965?=
 =?us-ascii?Q?8qh5mZs+EmOZ1IxiJ7U6bOTEJThcHCauE1Liq7COAdITWE9Z8reorCiOOLiX?=
 =?us-ascii?Q?kHlYUjXseF9QZKCdXcbkuNjaqa91t7sYWGalC7D43ahZxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HYC6fJI/tknVz+XNYiPSrDQdqX2tiYUtucbKAGL1l/+HowBr9KxkQPHbXXCz?=
 =?us-ascii?Q?x/f+/psF7uaTngsLPLp2WE5a0q9I1kWIqrGQOBKyd5cGxnHUKuwA+agFhcp1?=
 =?us-ascii?Q?9I11Eq+tcZ3NlcV/689mg/CAiTdtJFBa54EhRohsaOs2zz//8kNa3a12n9OU?=
 =?us-ascii?Q?hzbGVACExUtkEIbCKnkAEAOzf8RwWzRFyfaCEojRe6d/kzEUFLTw6GYQjLip?=
 =?us-ascii?Q?oW9l6RRMWrUtXz3PYuNoOz+ij8Bs/epiw3M3+nyduBtC/VGkBkjs1yviJ6Cu?=
 =?us-ascii?Q?Ld1JSptTSFkFQ9c8XDLhYDEe+1hzNYGMJu/lDv9ceJEENKOW+PwBhdB+GJ3O?=
 =?us-ascii?Q?us4UO9GMK9AGkWXVukPvtbuTfaATk1zzexcK1fFSMWYH0/3TykZaEvWsOEV5?=
 =?us-ascii?Q?YHL3cTtVlcP6vJ45GeNmLZBmB9Bj5noqfGXxhDUMVFxvurEPB2Bc0M0ob/C8?=
 =?us-ascii?Q?+zSE9vsLvxPyBv8RmsUDgIiCo7QyJrAQjwrfMmqsCevm+wJHm7JB80VXQLhb?=
 =?us-ascii?Q?3wSXVPYZfAzpxreh5RBQQ9kD8xzJM8RLnOGwoapY62bZxKn+P1xUz3uvJZ+S?=
 =?us-ascii?Q?i/dk7oM2yCbQ/0rXhUjjtH2Q1WZUxMmWiOrhiJfVyMXr2T6JhhPJwBRMxVCw?=
 =?us-ascii?Q?eP4FeU0HQBSTb8Km6Dj6nWmVkWCYlrVML1b9qcKRBFW3WOtJm47uu7FaPwzD?=
 =?us-ascii?Q?LcWwsQh/1ZptQqxLbmWUIVk2yDtR0M38CAMQka/TEaJgVfc5vaRiY9C0UINr?=
 =?us-ascii?Q?Kmw6GH9UyakRuMfd+J1emZJVDwy7Kyhe2zwsifK3xcmTQm7p11EHV1OMntOZ?=
 =?us-ascii?Q?plWNciDLY5LxH8IAtCm25kmSP+U0zv3VxEWyOsevdBn0CqQDzpk3DXEB3Iz2?=
 =?us-ascii?Q?R2/diTqeycQ4gNUleId4/MMJ40aIAHFpvdtozC4bc1x7u3OBs5DMFFOSJr5d?=
 =?us-ascii?Q?U5YERt051xRx7JkQmfYIKomw37CyEIvdPwyElQk2x8YnIifLxfypJg7bpkN6?=
 =?us-ascii?Q?4cZfTTXImGYB2GYIktpJAPJdcbIunapxZDMJQBlKcOJElNCM5E1lq3WBVo+c?=
 =?us-ascii?Q?jfOPUp3xETKiOGwtZBFWX2sbnJr5OzXAVppGZjmcNNIl4cz1nBLv+Jv6XETm?=
 =?us-ascii?Q?sYIh2YOYQ6aysKAh674GbRSXvslxRuz9KTCQ4vBW7yPyzLvJUeJBzq1V3az7?=
 =?us-ascii?Q?Ut86QL0qmphBmCYRIP/ODhs3XfQ8IhLc0KvrC1yj/KbxEQf+7GaIO7+opyON?=
 =?us-ascii?Q?I/ZQ6zE5uH2/3PvRkzjsOgh/cxRfwxbU2+rtJAu5bZm6QLEAt6wiUicT+QBB?=
 =?us-ascii?Q?LdDQFPpLJe1e61krrKki3MbKHp+Pw0Bo5eJbYniiCY2QZm3FBfRVjB9sH3UP?=
 =?us-ascii?Q?Dt7RfY++fttdYNOMef+fkWwE7ykSVn3iNLTIeaWv5Lj78EdRpCtGGvR9rQhA?=
 =?us-ascii?Q?DvCfqYehLCRvVzryaWtRfcaJaDSsA8tPqEHlgBb/ZIaL3vgC4p1/j2KYh5U+?=
 =?us-ascii?Q?pIrLspkNHY/qaUY2PGiY89pny38N+v2NXUUhvHH/VWUdCL17axKliIEGX36V?=
 =?us-ascii?Q?lYHHrL59TeHC2hFgFY0g+ykQcd3hemlsbQz1i4wR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ede02d-9bf6-4d78-f3ba-08dce8398031
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 08:08:04.0835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3fWx5KJoS5SKNxGii9K98GFop0l9zz5fZE4zfwXsRcpTgpWwmybPIbfEV8uuj8YqGOPA/0n12coM8Cvm924Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, October 8, 2024 22:01
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, =
Ramesh <Ramesh.Errabolu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add NPS switch support for GC 9.4.3

Add dynamic NPS switch support for GC 9.4.3 variants. Only GC v9.4.3 and GC=
 v9.4.4 currently support this. NPS switch is only supported if an SOC supp=
orts multiple NPS modes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
v2: Add NULL check for is_nps_switch_supported callback implementation

 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 45 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 12 +++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.h
index f61d117b0caf..79c2f807b9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -101,6 +101,7 @@ struct amdgpu_nbio_funcs {
        int (*get_compute_partition_mode)(struct amdgpu_device *adev);
        u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
                                         u32 *supp_modes);
+       bool (*is_nps_switch_requested)(struct amdgpu_device *adev);
        u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
        void (*set_reg_remap)(struct amdgpu_device *adev);  }; diff --git a=
/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_=
0.c
index 94600e5c8ea3..bfbfbcc9b89b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1395,6 +1395,17 @@ gmc_v9_0_query_memory_partition(struct amdgpu_device=
 *adev)
        return gmc_v9_0_get_memory_partition(adev, NULL);  }

+static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev) {
+       if (adev->nbio.funcs && adev->nbio.funcs->is_nps_switch_requested &=
&
+           adev->nbio.funcs->is_nps_switch_requested(adev)) {
+               adev->gmc.reset_flags |=3D AMDGPU_GMC_INIT_RESET_NPS;
+               return true;
+       }
+
+       return false;
+}
+
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs =3D {
        .flush_gpu_tlb =3D gmc_v9_0_flush_gpu_tlb,
        .flush_gpu_tlb_pasid =3D gmc_v9_0_flush_gpu_tlb_pasid, @@ -1406,6 +=
1417,8 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs =3D {
        .override_vm_pte_flags =3D gmc_v9_0_override_vm_pte_flags,
        .get_vbios_fb_size =3D gmc_v9_0_get_vbios_fb_size,
        .query_mem_partition_mode =3D &gmc_v9_0_query_memory_partition,
+       .request_mem_partition_mode =3D &amdgpu_gmc_request_memory_partitio=
n,
+       .need_reset_on_init =3D &gmc_v9_0_need_reset_on_init,
 };

 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev) @@ -1545,6 =
+1558,28 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *a=
dev)
                adev->gmc.xgmi.ras =3D &xgmi_ras;
 }

+static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev) {
+       adev->gmc.supported_nps_modes =3D 0;
+
+       if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+               return;
+
+       /*TODO: Check PSP version also which supports NPS switch. Otherwise=
 keep
+        * supported modes as 0.
+        */
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+       case IP_VERSION(9, 4, 3):
+       case IP_VERSION(9, 4, 4):
+               adev->gmc.supported_nps_modes =3D
+                       BIT(AMDGPU_NPS1_PARTITION_MODE) |
+                       BIT(AMDGPU_NPS4_PARTITION_MODE);
+               break;
+       default:
+               break;
+       }
+}
+
 static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)  {
        struct amdgpu_device *adev =3D ip_block->adev; @@ -2165,6 +2200,7 @=
@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
        if (r)
                return r;

+       gmc_v9_0_init_nps_details(adev);
        /*
         * number of VMs
         * VMID 0 is reserved for System
@@ -2435,8 +2471,17 @@ static int gmc_v9_0_suspend(struct amdgpu_ip_block *=
ip_block)

 static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)  {
+       struct amdgpu_device *adev =3D ip_block->adev;
        int r;

+       /* If a reset is done for NPS mode switch, read the memory range
+        * information again.
+        */
+       if (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS) {
+               gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions)=
;
+               adev->gmc.reset_flags &=3D ~AMDGPU_GMC_INIT_RESET_NPS;
+       }
+
        r =3D gmc_v9_0_hw_init(ip_block);
        if (r)
                return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index d1bd79bbae53..8a0a63ac88d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -401,6 +401,17 @@ static int nbio_v7_9_get_compute_partition_mode(struct=
 amdgpu_device *adev)
        return px;
 }

+static bool nbio_v7_9_is_nps_switch_requested(struct amdgpu_device
+*adev) {
+       u32 tmp;
+
+       tmp =3D RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+       tmp =3D REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS,
+                           CHANGE_STATUE);
+
+       /* 0x8 - NPS switch requested */
+       return (tmp =3D=3D 0x8);
+}
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
                                               u32 *supp_modes)
 {
@@ -508,6 +519,7 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
        .remap_hdp_registers =3D nbio_v7_9_remap_hdp_registers,
        .get_compute_partition_mode =3D nbio_v7_9_get_compute_partition_mod=
e,
        .get_memory_partition_mode =3D nbio_v7_9_get_memory_partition_mode,
+       .is_nps_switch_requested =3D nbio_v7_9_is_nps_switch_requested,
        .init_registers =3D nbio_v7_9_init_registers,
        .get_pcie_replay_count =3D nbio_v7_9_get_pcie_replay_count,
        .set_reg_remap =3D nbio_v7_9_set_reg_remap,
--
2.25.1

