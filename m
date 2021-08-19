Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B6FC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 04:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60C3610F7
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 04:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B60C3610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB676E49F;
	Thu, 19 Aug 2021 04:30:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27436E858
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 04:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edpnQ5I3+5/sXguFW2d73eBJqt+i+lSzr00X2sWaQedaY+kpPFIgHNSw9OvQV49/bRSPf2yBoIBGJfZslhTFN2G3ZpZFA/EYavmPccNjx4CYB4K9PZa8QyHGjUusspmU51TFcrSZ3SD3ehf944nrb/m/NW6w7oT1QwssrtCSqoY3mVlyUYTB0NAwcJtBnzUchzR7Nmq9H8fqH8h4zre+BU1H7o3hRjGvkrjAqa7oiWeyZXFCPP40ir/AgD0t2DCQpAYPQtUMVtllVrMIIvKBfNel5XBHtoUQVKUk5C+O04kqzCUkJwBPqLVNkjLMaflwrduDnKElMUXxOpRMbq8gUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpUp8KM2X3sFk96NEq8auwZ5NVpds3/BNUmlCrKmw4c=;
 b=fmNvO9uk6gpk5Np6DudABteGnK7Kdlxjs5rBuhb5SeqriYrZbrR82JX0arUzENaT+wHIC2TPuCK+HfZ5874a86NmmAFcNZVnPwwdLimsitRDXmzEvvwM0SG0QOeNfsge5sU21Pvm7S83tG5dHjcV5upO5Rk0YJwFcHthFaW6ivMaYwVSYfmN0jIBlqEHcTMKdQ50DQCHTIrrM8tUUy+cDa1gTnVYXWkUWp45+rIlrwUCIgPIQGqqGJGo/a8z5ev3K0R8G+U362DvEV4TbExT4lGonXvJAkH1y42YxlfJ4wbNMGNhBVS1mc3eMFOVwA0cfhELP04PyjoBRhQTAXCdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpUp8KM2X3sFk96NEq8auwZ5NVpds3/BNUmlCrKmw4c=;
 b=HOn7vois4bsZ7nugylCN3BPmmx3ZNt6XEpWURZPsFMGe1GwN/cX8sRf9fieSR2WdP4pEUe5InPd+0b+nndVak5gAMLMab81r5uJTn/WN/JwvZDqdnp8oa3NSUMq43/+KItFrNwjvHxwFyFyUj4qVjfzvbn0m9Bo74aHyQUIR83U=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Thu, 19 Aug 2021 04:30:47 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 04:30:47 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Leo" <Leo.Liu@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
Thread-Topic: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE
 on suspend
Thread-Index: AQHXlKeZ2NazE6nFqUasUKFQlWs/Aat6PE3g
Date: Thu, 19 Aug 2021 04:30:47 +0000
Message-ID: <DM5PR12MB24692A47A8CA42E49531D632F1C09@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210819030859.1470753-1-evan.quan@amd.com>
In-Reply-To: <20210819030859.1470753-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-19T04:30:45Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3b6e0b3f-0c63-4886-8d54-ae648cdafe20;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a43fe0a-7916-4114-57b2-08d962ca1e25
x-ms-traffictypediagnostic: DM6PR12MB4124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4124C5CA716D974D401AAEDFF1C09@DM6PR12MB4124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/fTn7T8Kgbjdt83BRyZcXEJoNRLXZ2S//iqaYZa9a+Mj7UP3x/FUpn2bVjTgYQ4mr1unMNAOcLXbQf/8GEymztRCbRkRfrRCfZJ/xaQQamIPpbKHOJQivQaUglcxSJiEHMCnwDwToGGoQSWa6m6lAkO4sg/ZavjO0hOcUSVNXFzgv+PZQ+AIbmqtQU2fkQMnNcPrO4ThIQWtD6m6Zj+G2e0oFZ0U2UXpAT91cwG8EBOoCYdwlv1snNI/9C98uYtP2VnA2L1F7Af6D38FlQB7UkI6/kg07RGJipfEhp3lpRQmwqvODV2phNZk6JemybyVrb1+afhVkmvQ5i5VXzQXNKGgyg1FinGaWOX+jLxGIAVISGMxVTP3jmZkkQvRzzDcpnQJ0sFTmtRk9/OeEIO5J95gv80xylZqm+VzQSQV7e5eNmwWB4qM7BoUqEc5VRUnIqdW40XwjybHbtqqYpiUD+cYzzjeR+utLMh8++8N0FzwgwwMSu7TxDx/t4t6bhZ0ohC/HEjX1pgEM6PUpG6P7E0aWzTcST0OJ2so0pvh35GAp+xMysinxXTcp1dmk8sp8aZcInROLJLyt0Ib9zEz1bOv/DliammxXP3rFnKrGN/tjFGFEX+5Unrb2nPx2T7t18LtKzlTHOmccBevZJn/uASZACUydWx3DSs2KTWy2apfYfGQns5DnqSdH4ZPKoDlQuAWnv9IWtL29hPJ2i/mQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(8676002)(186003)(9686003)(316002)(38100700002)(122000001)(38070700005)(55016002)(4326008)(71200400001)(6636002)(2906002)(110136005)(83380400001)(54906003)(66476007)(66446008)(76116006)(66556008)(53546011)(52536014)(64756008)(8936002)(7696005)(6506007)(26005)(478600001)(66946007)(15650500001)(86362001)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UpGQ1CzcCzJBRHyVobol8RgvZ21S34UlfMwDTFGQ3h179oLPqpB/LM+yTfdg?=
 =?us-ascii?Q?VeqH2pRfrTlfG/EwwCnUAGsMtTHACVJtUCOHFbT3NcIBNMX+luUaRGlcH50j?=
 =?us-ascii?Q?glGfjvZEtkCwbHf2rSOR/wnHYv4tbbC5Q+94aTskKZp3MT/i9ps9liyq7Tdy?=
 =?us-ascii?Q?ipucQb65dBURCOmfoW4KqpHFoqgwQJM/+eaThd3GqbGbD1too6TefwpuV1Xt?=
 =?us-ascii?Q?3fVJEnxhvI/g8uJDhHNwdBcozBZ+52UcNA2avgX8INtxYSdk0CT1yxnMlZG+?=
 =?us-ascii?Q?KIROvwqRKAnWuYqBSblVZd8766uaLxga0EwS/O8hMwy2f7lJbim2Dj1IK9oP?=
 =?us-ascii?Q?fBWZr7Q1HgdulfkJp3NBxnr8DD1PVr1IZ+ooTZRVhG2g1y/8qcoYMhbPA0Qv?=
 =?us-ascii?Q?7roBOTH729ZICESOnlU28A4f5teQEpxLmFQX0eSTYbnPYjtubTW87L9S5eqH?=
 =?us-ascii?Q?c2/1UwYBe+6HKAjG2gfTLtGlaGrGeXQbX2xDdVML+eozHvrDiZIqAdatXZNf?=
 =?us-ascii?Q?ZOLActyj/CM3eE0GdAQ8RYRbbZSafOyssR6pgS9mQYoFKzuIgAKYXj0OtaOP?=
 =?us-ascii?Q?JhKyOaUu5HNknbJk33o+hYHQKQjc1z2Q1QUcydpHVrkmqysK2vTWXqGpo5dU?=
 =?us-ascii?Q?aD5oQjbEij3BIIRY9IU1/jsvq17hXfM4A8tkADKVFGczKE2dez/oD2vPi6u3?=
 =?us-ascii?Q?xANPdg1JDX9WAXz81LAQuNBU9YzZ5FWNt9ShvXMEA2lzg7q51rz5O6do693t?=
 =?us-ascii?Q?9jcbUaUA7NnfD6vos2jIVasJIElLSCfn4IV+3zC+jkxcvXsbBG2409HzAuia?=
 =?us-ascii?Q?DLFHv4rPj5LULn2+PX0mKFdWWDyXseQHUH9VJoFIPiLkuAc5YPwegS3kFsTd?=
 =?us-ascii?Q?VQHantCDrIF83TAfmeHtiCvnmJz+/bQ/49CdvzM0ooOHkgCWgp7A+fvzqxlt?=
 =?us-ascii?Q?+1Ki4pXcxKn4vVEDe038sxHGIfTBOjndKK6bVbtWnPcIiOsFLuhA1mkdijYv?=
 =?us-ascii?Q?l+11jHkT+fOlc+gG/BCuZK3KkzaVGPTERla/IJjY6Nb9k6+kGeLeDEUZejLW?=
 =?us-ascii?Q?zBfT7z+xFdYELK4Pn8M8GEoP1+PUkLiZeg8a8MZTqmpwNTEndBKmk2weUvqJ?=
 =?us-ascii?Q?Av3QAoG9gRwarzZODUl8Do8Kdxxhfv/IgOWff4lzGAXElKlbADP4aLIZwWQm?=
 =?us-ascii?Q?bp0JgTt5AZNlZ454+pUGj4hozHwtSWF467Id3hEimHFg4SDO7McDXl3FyhtA?=
 =?us-ascii?Q?FQxvZXH6KMg9fmsqP4bAn9rvigUInoXMjCU+kyW+5RdNtLBo92M1Nq6G2MT1?=
 =?us-ascii?Q?cDpCK6rzglrALvZ3J7WEcFQR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a43fe0a-7916-4114-57b2-08d962ca1e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 04:30:47.6296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nm7LHZ0tA1WyH2xwkwBDd4/nY1uy2C5756bR0LUKmQSmDUZws6f9xszDVlzYzL9r8qIXm8Cazv1dqylbnA/z8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

[Public]

+Leo and James to review as well.

This patch is:
Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Thursday, August 19, 2021 11:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.co=
m>; Pan, Xinhui <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on =
suspend

Perform proper cleanups on UVD/VCE suspend: powergate enablement, clockgati=
ng enablement and dpm disablement. This can fix some hangs observed on susp=
ending when UVD/VCE still using(e.g. issue "pm-suspend" when video is still=
 playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++  drive=
rs/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c
index 4eebf973a065..d0fc6ec18c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
 	int r;
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
=20
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+	}
+
 	r =3D uvd_v6_0_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 6d9108fa22e0..a594ade5d30a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
 	int r;
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
=20
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+	}
+
 	r =3D vce_v3_0_hw_fini(adev);
 	if (r)
 		return r;
--
2.29.0
