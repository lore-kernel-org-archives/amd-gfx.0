Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE65C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 15:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B03410E140;
	Wed, 26 Jan 2022 15:06:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D441F10E140
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 15:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb9NqpiJhv5jwXxROF/PfAlJ3R8KgFa8U2ld7DMYYv3EnManlXFk/gQIMveVy8+bQy/kWyTJXhjLrxy96SMgdLSP8g0jkJGTfP+USUOz4O+1AIyNVuh8sXobCI9YVavEurxXkB+PAxEuKD1jT2eqpH+esl54wugISYmoWdKs8aflcaKJnw9kypfJCi294z81zU+V+4tiibgW4NCPo1eqcj3MgyJoumnzPYdc8uZajxYpRv4XnxXcyB8s9SgQHJ8XKmHh4ZWzU8OvLLCiuB+WPNquZD7F3qlxYd8eyqvECFHQnbbJyORyZolwJkvK53zMSghF+miua/MsF8lC2BK1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2XobhutUnwqxvvPyfu7YYdmSklwW6MnF0rKITfWhsU=;
 b=hjWkK/ZKFrWvz5YQS4+P0/soyuyUGah+E3+NklIo9tuo892qPpb4HaB69oqYz/QbiNzP6jbBKHHQY/yZ95x2wgHc7izds9dyQaoG+XAMS+GnBfOK6Vb4zXSgHhswA6GhzgxT+CSGcRScLYbq3M6VYJd04ZA0OaSav7O1kbnNTdJ99m4a1V8Te8ZijeLPkwCWsvrELkjr/eTFjmi88TfFj+jHhwhQXRafJYcBONOUuEByeqXmC4EBRwAsVLCxT7/2VWuc0jeT0jzhqWcKSv0PdKsFtNsO7Zw5UnTK4R/TTyWotHI4xZ/i4p58YnvJUjq6d8FwXNv7i30dCWwqKLEW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2XobhutUnwqxvvPyfu7YYdmSklwW6MnF0rKITfWhsU=;
 b=PJ0MSNOx3viYeGNDTFPYaVUnOeWD4goJUs0w5qeEBKa27TMronSxLprY+S6vyGYEU7ss7lSVK0JJ/pOJQVg+0Q6YeUpSeZBOCLRlx0AI7yefkDMzz8wRCUU5UOQesxAYNuY1GinOs8FXIIckkH73+fCfUvwawqzGxvCMDpb40hs=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Wed, 26 Jan
 2022 15:06:19 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 15:06:19 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Topic: [PATCH v5 2/4] drm/amd: add support to check whether the system
 is set to s3
Thread-Index: AQHYEmqSHwh5iWHEIUyIlQG0NjKWVqx1Z7LA
Date: Wed, 26 Jan 2022 15:06:19 +0000
Message-ID: <BYAPR12MB46142C4338D620EE1F7977FB97209@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
 <20220126040944.4324-2-mario.limonciello@amd.com>
In-Reply-To: <20220126040944.4324-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T15:06:16.4994730Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d5a1003-2c3f-4ed7-4ea8-08d9e0dd6896
x-ms-traffictypediagnostic: DM6PR12MB3932:EE_
x-microsoft-antispam-prvs: <DM6PR12MB393280927907388BA1FF8FC597209@DM6PR12MB3932.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qUVoE9RCj4L6KfOUzbW2H7IR1XZETuDWDy8650nQFX/nhvRX7RgQ36guVNjmUu0ZsHPe97olsWu/XfA14xLdfLitvEF+PwmFOc2j2yHqr/j1PTTWfVWdH6fUKLNrvnlqMfoV2qcVYc9titXyua6iufdEpnH8kIQn3c7f3yp7c6NzWkKpuvmRORNlZjgAdgTc9PACluaHgJdXK12HETGyGxvjZ95coC0NXFIFHXuPoSkEya5lKPgTddn4qGwINrxRddlEfzzagjRMKF5j/GNLrTM1/PgoiYsS/iY6WnNK7l/a/CNazGs5vvo0aT9AAHMJMv2nE9sLhv2fsKhJDqCim6gd/+y5GBH5f2BHc5r/NmLq2hHxyas7PWA9yiN1g3fJdLP61eL0YLVetlwFRRo89xOI1wBS4WGMatlCuPwPcFsD0vgz+2JSCoV3wVJ5i9aILkmfBPlAg1ei/Y5nL+Qmdvg3OrYsqp+u+vJgeD628AbFkssna7rXUk7Z0wDbPDjwPQvuDvIgZxZy+bxCBiTtD9Hr7657jHh8qnMYAAVGxeHVp9Oyz7SfVJHA+vNgBCr6wxU+EQW1Zh25rCrW+t4hCQ57gy5V7ipR6nGIw2OFP/i0l9UFWr73zXtZ3r09k+FLhLDL8MdReucsw6qsMfOAFyNQ0fBBS59xGf5B+uPWIW5Xvhv+O+A8awzSKv1hzTJtjWKnXm+E8DByai4uk0DjmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(55016003)(83380400001)(71200400001)(8676002)(9686003)(186003)(33656002)(86362001)(38100700002)(66446008)(316002)(54906003)(38070700005)(6506007)(91956017)(7696005)(66476007)(508600001)(66556008)(122000001)(26005)(53546011)(5660300002)(4326008)(52536014)(2906002)(76116006)(66946007)(8936002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tfbP8lwj1IwxHLQcSqF4ugbusns6LKBpVZFg2EfInwtka2DW+wgLL0YUfaK5?=
 =?us-ascii?Q?TnKnWow80hzFJS/MkxZXfKxCch2wUgwQWizzZq9WOFSP5DRD0+dTv3fVEpL4?=
 =?us-ascii?Q?NLDGIJ6SedoXROMG8vGTMn8UhxUGDImBgPdk6a4Xz0YKEh4FEwcBBW+a1ZzA?=
 =?us-ascii?Q?AXZeJfpfZDemXs44bWHMaapurNfFy0pDfx5hiE76vZ71hTYGpZiK47Kn/V25?=
 =?us-ascii?Q?PrOPle+EHu3XOWmCVVygnUFp3mdB4vfqJqzhZQo0RatA/ScFPwcvt8qjUtO2?=
 =?us-ascii?Q?HHwrR06FSYdrggVYBjByb7ysgSXkfSgAdgPRZMq5tI58q8xlO7StK/I92WdP?=
 =?us-ascii?Q?OSUKoy6h5Mobh/oVLlXPPtaMW/6e65s47kQsMQiO/5CKntTSynJqVfmg4Meh?=
 =?us-ascii?Q?58CWpVcAfAZw02VfAwgnSohH2yrBUUM7QNRb/61YwPpV4Cjkp68TziPF9Ro1?=
 =?us-ascii?Q?fa1cdIkKxnSPJ17x19vF1H5Y5zikM6CMOLIjGWG4/NEFRMvGh1/EHhoOfwC0?=
 =?us-ascii?Q?n+pfF7jI+j2RTNn6sm+OAm2l+uQUlabwYeaR73/wDiUvhgqaHx9hIbHM7S/i?=
 =?us-ascii?Q?xXS1WR8YQf+zUoWHZ+NLpZKhWNw7saX2IeyRHBrzyWFe05mvvzI8K/bUHsBI?=
 =?us-ascii?Q?4eCYlXIzAOzvmJ65BQTGmYCRnm7UW+OP9HQYNbOqwDfx4GUmJCfVWZn43lmI?=
 =?us-ascii?Q?jm7aZD+PBq4P4SK56H3sBYbKHHzEMHmXxXZLacBZGfYZzA4eps0+jFO0V1s+?=
 =?us-ascii?Q?qhqE49PkUSfAYIJIA3RgR5ChLygHb0APVNWoRkK3VlqT85V4RB0eoVZxL+Lu?=
 =?us-ascii?Q?1+jaIYRWKCeg1FWfTLXgweuqNcnv/LROZIMkGOMk5L3OZ1blWfkSAXdKK00H?=
 =?us-ascii?Q?63EQIZP/ilvg8piZD9CUKQunpGH3vf2HyN+rAeGyESUo1TKeHnYE2g2DTr68?=
 =?us-ascii?Q?Phff+V3SWancwgqx1djRKvc2VPz15cmYvMJN1IemPQRtuIYUY5cdPxhOriXz?=
 =?us-ascii?Q?Ac9azRAoG1watnuvhi0XG5/eHWRgNlYZ4tpkWbEH5vu5uPxteBz5J6jwIenY?=
 =?us-ascii?Q?JdRvqPkAuPCwflmontG96X9nJ1jm2ypyxXrV50VeaWDJ/r9ITHquzOds2x/G?=
 =?us-ascii?Q?mXMNBbFjMAvmyJE/gy8CMkW3zR5wgR4mRYCXg0DUmhL4yCx3e1pusWVg6Hyv?=
 =?us-ascii?Q?uk7ge/STWVFU6V/ebKtE01+/M5aU/Tt9TkKbmsArU0hwVTnCCSN+ih79Lwwo?=
 =?us-ascii?Q?7RjE8Z437JqjD0a/0vlP9ukeSNVhAHyeWurlAPOhsNv1JSAWM4G0Q1BSPJGD?=
 =?us-ascii?Q?vD9b9Wu3cgzTdUWo6fGJLkcotxw9cjdUHS/r682ZhLEo40WpP1moF8MQAGTc?=
 =?us-ascii?Q?6Pc/nKMQfswMQyHThdgKK87lDcB3AKwutsulSFlXfOGilKkVDeAkeLDT9bLG?=
 =?us-ascii?Q?pyFdfZYEqeLF8X5hmBfvY2un01AcIYCZv03+Uw5wp2Y/4oER22AoU+peNNJW?=
 =?us-ascii?Q?KmfZ5lDgEN/COlzVNUKCjm9GtvRk+S2yBnlEfuSs7dVHzw2faWxX0gPKjUI/?=
 =?us-ascii?Q?gL7MbzDaGPA6mPbsKZlWhdmNVL5vPTryJTqj4OR1?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB46142C4338D620EE1F7977FB97209BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5a1003-2c3f-4ed7-4ea8-08d9e0dd6896
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 15:06:19.5773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0m4TiYR7R4EsYY4YqvpWutqJfWI52FtB3+BauqiUQ+tvxQmJUthS7uQEVnrCWwck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3932
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB46142C4338D620EE1F7977FB97209BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Returns true for dGPU always. Better to keep the whole check under somethin=
g like this.

if (pm_suspend_target_state !=3D PM_SUSPEND_ON)

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Wednesday, January 26, 2022 9:39:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>
Subject: [PATCH v5 2/4] drm/amd: add support to check whether the system is=
 set to s3

This will be used to help make decisions on what to do in
misconfigured systems.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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


--_000_BYAPR12MB46142C4338D620EE1F7977FB97209BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Returns true for dGPU always. Better to keep the whole check under somethin=
g like this.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
if (pm_suspend_target_state !=3D PM_SUSPEND_ON)</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto"><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 9:39:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; Limonciello, Mario &lt=
;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH v5 2/4] drm/amd: add support to check whether the sy=
stem is set to s3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This will be used to help make decisions on what t=
o do in<br>
misconfigured systems.<br>
<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
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
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB46142C4338D620EE1F7977FB97209BYAPR12MB4614namp_--
