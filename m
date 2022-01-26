Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5278C28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 15:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF7610E6E5;
	Wed, 26 Jan 2022 15:11:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B2210E6E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 15:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB3FugkyS262EBR9bprYj4AucWX6FUVbFz5FDv0FBk6TFwqMyJz3L0gHPXfckFYFDLcCKHPJ+6CRqvpehFuRrWJVuO8zerVlH5KhsB2GIqsOrgLHyrS3Ewn8Wmm2Fxe2QajGXC9RSwOdc5t1es4zXpKY2/cHEY05seWm/gOhxm05ciIam95lamlfDJjrpQ2Qth+WdNM94ViYvqrKeZ2AJdDLgzRmb0ZjvHvvAWid/40hNOVGDY8+wG39vSxydfWVUXZ8c834LQU/qUctP0E7IMnC5SfJ0Y/xkwPxOegUVdorqJqomJ7ekffMlwFwZ7bgw6PAUnrw6NLpJZZnYZkMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byowMGmfQmp1wA98IucgPdhekooEckfW8EfNUIe6znE=;
 b=NPVbU/xc0gFCKM8sKOSzxR6raRzSATIjMNDdGwDlf6vai495F/MK1c/EgRFhTaPvjgb74UEb9wXRDGqN9nmitcm/Cm9iHmj35n9IzUl6TTaL7W29DQ0wHolmWExss5qyOnzMfPm9ziZLWIYWePEw2D6ptDT8B/ic6i8GPRjHEh35ZLCuH/7rnxVpZ7nSFHF9zqVqMg86LyPC8SJiY4+iCYdgWIHotszYdPLcEy4pPgduwFj8CjkUc9Y38yYtsVMMRE3D32SEEOYCDGTpNwEsRa0bR17B5KxaN7wFC9ihKoYlgGIPxapLKt28nJUWvvIrRyuDvsLScWHmoRE9AhbMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byowMGmfQmp1wA98IucgPdhekooEckfW8EfNUIe6znE=;
 b=dsUlRI9zqhmhXyPvOa8F7Yuu/cmgdTovvIKLCwKVmkdWAzyg/ETaVzekNNcKK/ce8YKLQ1toe8ErXsLIhODw2Comi5zUvb2pMgFR+JwPmKYNMtdGrWfwqyNiH8RF/ntkLjcw/07HY/ndibucSKcXY7EZx4Kb+Nwgwz+KG+wAOBg=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR12MB1223.namprd12.prod.outlook.com (2603:10b6:903:38::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Wed, 26 Jan
 2022 15:11:19 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 15:11:19 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Topic: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Index: AQHYEmqSHwh5iWHEIUyIlQG0NjKWVqx1Z7LAgAAAVgCAAABYUA==
Date: Wed, 26 Jan 2022 15:11:18 +0000
Message-ID: <BYAPR12MB46143045A2226B863E1CCB2997209@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
 <20220126040944.4324-2-mario.limonciello@amd.com>
 <BYAPR12MB46142C4338D620EE1F7977FB97209@BYAPR12MB4614.namprd12.prod.outlook.com>
 <BL1PR12MB5157001FFC7CC78C6AA12DF4E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157001FFC7CC78C6AA12DF4E2209@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T15:07:26.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f579a53-f751-4eba-9901-08d9e0de1b08
x-ms-traffictypediagnostic: CY4PR12MB1223:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1223AF438844FB1521F584A397209@CY4PR12MB1223.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTZ4+umQFAeqpl2CIzMXvYOOj3EmqajM3LzY4jH89VGpHXj0z+iGxDQqs77M44ecoe2Do0JVVbGaeg3Guw73a3pkVovVVmAU8FYaCgnXx/NIbGhs6CFB/sX6mG98wilmJaTyKsZJGyJ1yZrxA+Tewzg3j+4geGFiju7/+X9ADHE9Oy4HBmDRI99l1DJmVLn7lXfIvxj4iBSs8FQOMXxgl9hGA8T05CIYcXK8MzeXMfYgGE6qereJ7nSGBOOVbjYVvqmKxOnt5lFGiy3x2fuRm7j8o/t6kkrcNMzGof7aeoYvjogr37VhplnVax6X/L6ZFL+8qAyImAkUHF61azLvEpRm+ftoYDDNH/j8D7/jjOj8wxBdEH8svSClDlCHMATzRP84uhV1k/ZBW9CiZPhrusdQKNrSoJU5xHDtBi++3kbYFSGUF/GqDgla9KJDHeVeBHQmnQcus2fhDLRFxugqLcPjjFvmIAfXAIby6krcsh6czrn64XZThjAqH6f4vz2Fklm1S+8MAkH/9lPqpzfcoGS2DNgSTPyuaaPKLS7xeM+B3JVzIzOK/fF3ZfrVVG2a4XjCUf3bue7SbkkEbDvJ44DPSjIX8AJIlH9IA8hC4KL/yCBzoYEqB12fcyveKbegyZQqyJBMFXFPpgoNTQ+ucxYDgSwv6SXdwd2mZwcTb1BIh3lxrbKJ6OA4ForSYRqXqvdgDQv5Hwz2L9rz/sfVyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(9686003)(91956017)(38100700002)(38070700005)(26005)(186003)(7696005)(53546011)(110136005)(33656002)(8936002)(2906002)(71200400001)(76116006)(83380400001)(5660300002)(66556008)(86362001)(66446008)(66946007)(64756008)(66476007)(122000001)(508600001)(52536014)(6506007)(4326008)(55016003)(8676002)(19627235002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?XC73Sm+92F4SSmkqdnHQWq8kURl7lbMPpa24XUxddl/FnuwkUzmOvw8F?=
 =?Windows-1252?Q?/ecHujRp3s5HWXBz82PwFQCy1FQ0sc6HDPSmB7yxiufM/7UPGfd93n3X?=
 =?Windows-1252?Q?Rz53jiDOnLgORUX3HCWGJ1THEOxEZyX/05e54YG3allOjI74mAp65fI6?=
 =?Windows-1252?Q?vOK1eS7CRyidVf4kLHKX0ENy7m0AwwchSYEeLASQjZrF9hHYPL+PQvH1?=
 =?Windows-1252?Q?PNgtSxmpRkPZ2ZuFVLppy/X/R1IgMOT6BrnmN/fB+8N97Fu/1MbWi6xJ?=
 =?Windows-1252?Q?vL1jlE5AlAoLmL+7jUdcWjIV0G00z7vcbHZiCqmwS7rs0JqvcagmyWzF?=
 =?Windows-1252?Q?zuLvM2c4zduaUbnj2ohOLWSDKY6PNZlj+PK970FoqeuSGF6wNnw0xWU5?=
 =?Windows-1252?Q?FFmRUat87Bpd9xqi1pzm71/slnrKy8+2p8QLNQUFDqAok7V5dgmdfN3c?=
 =?Windows-1252?Q?GD/1lwdWbjPgfMM6c5ZEhkoF4FYkRPin4xtL7NOpBSQ34yFA0cAl+DI7?=
 =?Windows-1252?Q?GIa1hMn5jkDxGNxC38Q5vdIOB+ThFCVVd6zeqAEuwu5QNO6f3xVREppG?=
 =?Windows-1252?Q?AOiqZL6BgkomQyP4eABhKaIeqQDh3JCKTqOxpXvg7J5cCUSWmYVCZ/op?=
 =?Windows-1252?Q?aFl/mVvYxS+smw1JomeUfv1YoysSl5S4kkDo91cdQzn/0DCbAGX1J/K8?=
 =?Windows-1252?Q?UBc7VRw5gM0QWg9qzMs4Ca5vk6iASA71vZ4dzLw+ZeCLAh9BSjhW98ED?=
 =?Windows-1252?Q?h1gYzsbpWPpHYTXhIkdvjhkrticB5lElKhGB04aUKWB1LF9Keu8BN2+y?=
 =?Windows-1252?Q?A4aCzD28B8+yNLUnLf4co/gkzlFRxajhApDOQWebS7KFMFK0lkuuWThh?=
 =?Windows-1252?Q?OqKXuf9NF23BJXtfepQk1YZIYTD3y8D4dnTE8TLcSavXPsh47q2dw0vY?=
 =?Windows-1252?Q?JhiU8uToa4MCpC34vOzwOU/fa9Kaw3MaGqAQrQ96MXF3t4eUr8BjQAOY?=
 =?Windows-1252?Q?9RsP8e6gVxUOfHPOnAMT7PNFS+ZNSxgooJClSWQw/pKM4sntm3H6OXRA?=
 =?Windows-1252?Q?akcNNGvGmgAfmKSzIfDu8pfvUmn8IuFGLGKGbuwstbF0QMjTPjk8GWbS?=
 =?Windows-1252?Q?d0Un+PakF9ECTZt49rxxjzyKtHTQJ5vBszocOGbHGrYmb/IUnBLUFkhN?=
 =?Windows-1252?Q?pieAPZ5exUI1tuw7IGn/dI0/qk7E45LphbZOryg7peOVPnLP4Cpt6Ybo?=
 =?Windows-1252?Q?uGz69KavE7ovWy/7CgeSYdrRj63uo55gCsuM/tutu/HeYgYU5T31h0D5?=
 =?Windows-1252?Q?2iUt6yo5zvdTkdm9N2nfWzEuwt+5C3+lcOUfE++V9GRG1oe2HL0ARTvT?=
 =?Windows-1252?Q?YQF9vs8g1YgDecJs3aIZ/QxFjxEtD9eKFBmgAsH30Jm0lbkWibDYg54U?=
 =?Windows-1252?Q?3P92hWEY2jIPfOG4bVQauQMhHOAgLVEH9vFIGzltKzAQejUaGosI61bb?=
 =?Windows-1252?Q?L4nWDa9gbg8a8DXk+tvArHYMMofqWEPDiQb3qAYLGjnBLDgp1zGSTuyd?=
 =?Windows-1252?Q?P3EDs2bBccI0LWeJxKiDPw+itpkAJXjP24nJyIwEOCSWbI3qWUinlDLu?=
 =?Windows-1252?Q?Da3e0SlnbAA3k0UDMpBbsMykCD6mbk5ekto2u+4FhB66HvwrDnmVyj9h?=
 =?Windows-1252?Q?KidR151tuO50cO0NaPea7c6vnxSw7TqS?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB46143045A2226B863E1CCB2997209BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f579a53-f751-4eba-9901-08d9e0de1b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 15:11:18.9920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zru/72pyR80BxSQio2yLz1tvg3Y4+8Nxs/YmM+BLUVoUGmnyEKAUSjZMlVelieVi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1223
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB46143045A2226B863E1CCB2997209BYAPR12MB4614namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Talking from generic API perspective - S3 is considered active for dGPU onl=
y if it's going to non-S0 state. If called from anywhere else than suspend =
op, this should return false.

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Wednesday, January 26, 2022 8:37:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Liang, Prike <Prike.Liang@amd.com>
Subject: RE: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3


[Public]



That was intentional =96 shouldn=92t dGPU always be going through S3 path c=
urrently?



From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, January 26, 2022 09:06
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the syste=
m is set to s3



[Public]



Returns true for dGPU always. Better to keep the whole check under somethin=
g like this.



if (pm_suspend_target_state !=3D PM_SUSPEND_ON)



Thanks,
Lijo

________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Mario Limonciello <mario.limonciello@=
amd.com<mailto:mario.limonciello@amd.com>>
Sent: Wednesday, January 26, 2022 9:39:42 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>; Limonci=
ello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@amd.com>>
Subject: [PATCH v5 2/4] drm/amd: add support to check whether the system is=
 set to s3



This will be used to help make decisions on what to do in
misconfigured systems.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.li=
monciello@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 3bc76759c143..f184c88d3d4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);

 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)=
;
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0;=
 }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) =
{ return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { re=
turn false; }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index 2531da6cbec3..df673062bc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)
         }
 }

+/**
+ * amdgpu_acpi_is_s3_active
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if supported, false if not.
+ */
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_SUSPEND)
+       return !(adev->flags & AMD_IS_APU) ||
+               pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;
+#else
+       return false;
+#endif
+}
+
 /**
  * amdgpu_acpi_is_s0ix_active
  *
--
2.25.1

--_000_BYAPR12MB46143045A2226B863E1CCB2997209BYAPR12MB4614namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Talking from generic API perspective - S3 is considered active for dGPU onl=
y if it's going to non-S0 state. If called from anywhere else than suspend =
op, this should return false.<span></span></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Limonciello, Mario &l=
t;Mario.Limonciello@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 8:37:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheaderc10f11a2, li.x_msipheaderc10f11a2, div.x_msipheaderc10f11a2
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:green">[Public=
]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">That was intentional =96 shouldn=92t dGPU always b=
e going through S3 path currently?</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt=
; <br>
<b>Sent:</b> Wednesday, January 26, 2022 09:06<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; Limonciello, Mario &lt=
;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v5 2/4] drm/amd: add support to check whether th=
e system is set to s3</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:green">[Public]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">Returns true for dGPU always. Better to keep the whole check under s=
omething like this.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">if (pm_suspend_target_state !=3D PM_SUSPEND_ON)</span></p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<p class=3D"x_MsoNormal">Thanks,<br>
Lijo</p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lis=
ts.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf=
 of Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com">mari=
o.limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 9:39:42 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;; Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonci=
ello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v5 2/4] drm/amd: add support to check whether the sy=
stem is set to s3</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">This will be used t=
o help make decisions on what to do in<br>
misconfigured systems.<br>
<br>
Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@am=
d.com">mario.limonciello@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 17 +++++++++++++++++<br>
&nbsp;2 files changed, 19 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 3bc76759c143..f184c88d3d4f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1409,11 +1409,13 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta<br>
&nbsp;int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);=
<br>
&nbsp;<br>
&nbsp;void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *=
caps);<br>
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);<br>
&nbsp;bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_acpi_detect(void);<br>
&nbsp;#else<br>
&nbsp;static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { retu=
rn 0; }<br>
&nbsp;static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }<b=
r>
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { =
return false };<br>
&nbsp;static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *a=
dev) { return false; }<br>
&nbsp;static inline void amdgpu_acpi_detect(void) { }<br>
&nbsp;static inline bool amdgpu_acpi_is_power_shift_control_supported(void)=
 { return false; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index 2531da6cbec3..df673062bc03 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -1031,6 +1031,23 @@ void amdgpu_acpi_detect(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+/**<br>
+ * amdgpu_acpi_is_s3_active<br>
+ *<br>
+ * @adev: amdgpu_device_pointer<br>
+ *<br>
+ * returns true if supported, false if not.<br>
+ */<br>
+bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)<br>
+{<br>
+#if IS_ENABLED(CONFIG_SUSPEND)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !(adev-&gt;flags &amp; AMD_IS_=
APU) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_suspend_target_state =3D=3D PM_SUSPEND_MEM;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+#endif<br>
+}<br>
+<br>
&nbsp;/**<br>
&nbsp; * amdgpu_acpi_is_s0ix_active<br>
&nbsp; *<br>
-- <br>
2.25.1</p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB46143045A2226B863E1CCB2997209BYAPR12MB4614namp_--
