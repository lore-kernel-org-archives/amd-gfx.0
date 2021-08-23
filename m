Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE93C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E124960F11
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E124960F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688C589BA1;
	Mon, 23 Aug 2021 08:44:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BA789BA1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 08:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXgPJo2Tug1pOVOyti3r96EtK/aY8Iy/KcNH2sXktPijszPgg0rjyFD4sLKDB0j8lfzHrrneCw7eCC7sGmOHN1E2cdfDx0TCs/pU9W6Ml28mjINLcgJ772ZuoNxZ9y9oum7SXvQya+azWpLOS/7QkYlubuc9FPW3dn9Fx05VsZR4Lf7Q+/7Gn6NYpjzcbfDq97JREx3vR0uI0gm0sElLC+KNYlwKtNbfE+egWjRQ5nhLC0pF271o3G0j+9X5K3MzFW9yeak8hmpTHka8nXLfUIoslelmrgP/a587K8/5lyOACKdr1j2/fJOQZOcXRRD9KgRjQKprSErwDAIRSntExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMRlJAh+Dtu6gz3zKrDLqaSUYhN3f2uTqc4z58UFJ/w=;
 b=lL8wbCBOCc2isPNQzFGUyNY7j9w9ex1WPeQq2PvS/SK6OhalfuBNqFluOonfge7R40Hcz7f1+ZEjXeQEduUqRDTqcgaw7gWEoEZDljixRYHWM4kjp6KKGVGmCDfdmaZMaT/rrmydXnH9w0R0/zuUF1fI6SUirQw8RuoJXtQyQgOcaLi0yJ1dQwDoxSR7uksxp3rMZpsOQ14e4iJFQ7iYFfq/hwanH8FxDRawiZ6x+h6UR+WZS9ncyTCOlNHU00N5Phgh5XkJlpzpFTsbMeLAVb+YToq4XNtR8V8tkjmxRzAfcsPOVxzCIzCb+dDezzuT8Al9cIAT4xCX9Stfjnegnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMRlJAh+Dtu6gz3zKrDLqaSUYhN3f2uTqc4z58UFJ/w=;
 b=OrQs2zBSRSQnHIFEUTgyh2lza9aexKd7wuPMuy5GkAzguW7jRgBsqCyw/CA4HJjdYFiUxNog7WprHsjT02Cb1T/2eXYHF8AgxIyYNgKCfETrS4/Ujb8YrXDVW9BfY+9uKNUVm0dme+OMEP8k2Prpp2HeLhDt3tiQqJKUisR5ctg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Mon, 23 Aug 2021 08:44:08 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 08:44:08 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH V2 1/3] drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend
Thread-Topic: [PATCH V2 1/3] drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend
Thread-Index: AQHXl/nTZiEacz5NJU+qJ8GIyPy4y6uAxTCQ
Date: Mon, 23 Aug 2021 08:44:07 +0000
Message-ID: <DM5PR12MB2469DB6BAEB76ACFBE93EB91F1C49@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210823083505.53711-1-evan.quan@amd.com>
In-Reply-To: <20210823083505.53711-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-23T08:44:04Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=82ef90e7-b8c6-440f-92a5-45fe5a54629d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fb461e6-edb3-472d-997e-08d966122bed
x-ms-traffictypediagnostic: DM6PR12MB4124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4124795A35A0B96C2D1F75D0F1C49@DM6PR12MB4124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZZVhMr9crz7fPFXbuEd9G1khqNCi5pN9C1qu+JoSn7oMT1kQDaazVKtyGtaoGgZWtTsb9IUn6M0kdj3oCbbL4Sm86158k4y7DkTCuwRhGHUuFh5u6uCbYbC+7eFqhX2Sz4wTK4D/Nx8vC7WPP19oZySX0+v5TsVaYz7jNf8eQa3nPiNhpHRHSxtTLn5ytWyp751+SkELc3ulXSqtHIBng0zuKZmKgdb+H0IUndYrMRr3ycNg6ffvKIo6ekNVBp7n9DUHbUXH4nxFkRhW//tAmf8DfzdMtqjIo7V6Cb+SM8BJt5mKUG7YLNXdcI5yfCnkp/zZ/t8d8NWfOuEi/JqgVRuxWIcVwpiYgt15eaD1LhCK23AVbitPzDfMHgIaITrDNkmYCUT+UbrOyrf7xfAG3W+y9czdTOs9ezcy2aZyBSnjivPJleZUwdC+mPqJ66ZPFq4+dCQwHCT+/SPgwwmoxrVEGiisVnibbuc1QyT+9oYNlUfMqibqG8WbJGPHRi5d7MZdwizwT8b3BC2A678BtXOFtBXQuIa6KTHRdnJpxz4W2R0+LSxo73bXE6+2k4+nC81mInOLakd7/sE+NL5qJ1xlMbo+lMrtTdmC/SqaD3Bos55uLlXkORzVJBph58ae6+DmULmdXwE8wdGNIagtmFuhW3Q9fhMBLi58V1SNMk8e8vpD5Nidgob/3Gehvcnog6/QczHDdF+yohLJQo7Iw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(4326008)(7696005)(76116006)(55016002)(9686003)(2906002)(66556008)(6506007)(66446008)(71200400001)(8936002)(110136005)(5660300002)(54906003)(64756008)(66476007)(478600001)(15650500001)(66946007)(53546011)(52536014)(316002)(38100700002)(33656002)(122000001)(86362001)(38070700005)(186003)(83380400001)(26005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0gT6SOhLVIOwWc9qFI9dAWL6Vq9KXTqKiLvlRg75cUUG2+C7AlLXHsninGFw?=
 =?us-ascii?Q?ot9l0PSESeOHV2mBoPu5W8MMiRH6DvzdVihH+f+ze7G+VT6J1a608ybZiHX5?=
 =?us-ascii?Q?ArYKo0TRq8TGFralUB5k1h/1NLxlFNDdme6ybwpO9Tzoi9hEDMD9Ii7K1cQx?=
 =?us-ascii?Q?fZZ9+dT9JX0Ui0tJ7DQIarPRHyr/8rPpMPPluagkmdJDW83u2lVN7IZXO18Y?=
 =?us-ascii?Q?fWLkjjSn3lDahlGe0dBLEN8sRrM7qfktEkcrPYL5WxIU63P2jDsd7lNtqCGQ?=
 =?us-ascii?Q?jglwiUpVyduYnMHtC/9W3qmW3tOAZ+jafRL1DMJtpMjar/hRROGJvUULJ17Y?=
 =?us-ascii?Q?Kb4UA9Y9TKP5DeyXD3wVTyP8HtZdn8mk5KlbSZDev0co2AsawoE7XqmgvW5j?=
 =?us-ascii?Q?s+w5yCclboZyzKycdwxzye+3OqB4a+yPBfteMGm5qCoI9nUbqEk2k55ng9k1?=
 =?us-ascii?Q?XD/BVU1OyBd0f7ShT1r3Wz7Lf4QZekBy/sECxxi4et0570YsSkR4RrlGhG6Y?=
 =?us-ascii?Q?PaNNFQ+cxeEnsqMwX05J3sO7UD228u5ZS9E2xlD32CAS+qWc4mr2DtMzFZeY?=
 =?us-ascii?Q?AkwWwb96Qv0mDYx74d7jCUvzEiVGKn/7adweXfQWfhhkQ14nna0V9HRjesU7?=
 =?us-ascii?Q?Z9MUyxbxbilDN1zrrdYZWHXGUV3D92AxVQc2EC3XQr7eep9u6hLKcWqOkaP9?=
 =?us-ascii?Q?Tv6vc04e/uyHDaGj/MNHM5hvf0L1ZgPfDV7aU1wcAQulzbrHqusFRL93FoBm?=
 =?us-ascii?Q?mJT3Zzm9u28iBADEKidxskfrVhj9TRf7bLag4dXm/6raFaK3ViKpMTOvXiNG?=
 =?us-ascii?Q?OK/Stxo6Q0iNPeFCxuVjw58MKxB9979TUrIXPDTDa3+iXM75t2Ps6kWFifZr?=
 =?us-ascii?Q?o0GXJTKMKGwRE9lavFR4nLNlhviMoz6vnBSONqfxPxxrhqyScc4y6P5+SlyY?=
 =?us-ascii?Q?eY3cWt0onNlvXkYhJ7rXdLcgw+7GurtiV6z5HO1i45FMgv5meGdMc80pjpRa?=
 =?us-ascii?Q?rCEUiXT/osGCpdhE16J9J2rgAr4jXYM5V0Krxlt+651Oak1ISmu8Af/hectx?=
 =?us-ascii?Q?riM/+5J3DSdNj2zjg9Qqmf39A5KXA28vAymSqyPFEes3CLZTjPeYONYyuGS0?=
 =?us-ascii?Q?/MQ4pkxm9ne4k9cyY+UISxcYHXZi/SEt7tvnt0bgtc1Q2FQrZ6UPPIkTgOIU?=
 =?us-ascii?Q?84Bgha5vOQdMujnPWdeJW9xFXwvJ99ELDve28UmmkdOI4xS13vEmi0n8NaAx?=
 =?us-ascii?Q?PlgOXjvp25STSIZlrV9fY5MO9oSz5+QbWgoPF7NDoMriFDjxIwaMtEYQa2Js?=
 =?us-ascii?Q?XvnOQpJUtA0ej72282wJBPvF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb461e6-edb3-472d-997e-08d966122bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 08:44:07.9923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4ZkAWq8rGRxFYoCQmvLAnBe3RFds7YCqDnpz7UArFr9iWcBU4o7o58vmsLVtwrmNsXpIKt2OWl/Z9rnWk6IYA==
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

Series is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

As we have rooted cause this issue, shall we revert former patch "drm/amdgp=
u: disable BACO support for 699F:C7 polaris12 SKU temporarily"?

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Monday, August 23, 2021 4:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhu, James <James.Zhu@amd.co=
m>; Liu, Leo <Leo.Liu@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Pan, Xinhui=
 <Xinhui.Pan@amd.com>
Subject: [PATCH V2 1/3] drm/amdgpu: add missing cleanups for Polaris12 UVD/=
VCE on suspend

Perform proper cleanups on UVD/VCE suspend: powergate enablement, clockgati=
ng enablement and dpm disablement. This can fix some hangs observed on susp=
ending when UVD/VCE still using(e.g. issue "pm-suspend" when video is still=
 playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
--
v1->v2:
  - move the changes to ->hw_fini() (James Zhu)
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++  drive=
rs/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c
index 4eebf973a065..c238aa2014fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -543,6 +543,30 @@ static int uvd_v6_0_hw_fini(void *handle)  {
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
 	if (RREG32(mmUVD_STATUS) !=3D 0)
 		uvd_v6_0_stop(adev);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 6d9108fa22e0..e99877c13d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -490,6 +490,29 @@ static int vce_v3_0_hw_fini(void *handle)
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
 	r =3D vce_v3_0_wait_for_idle(handle);
 	if (r)
 		return r;
--
2.29.0
