Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76033606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=huNzSMuI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC8E10E4C6;
	Thu, 22 Oct 2026 21:33:02 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A1910E4C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 21:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wf7rUqXRye9nS8M8u9aQEWbN3HYkjSaJQK92QZzV1hHKve11Ut3VsDSPzITf9y5rlimfH4tCPT8qDjUBEsGu0lEXEWjQGhQpFdLKLyvnlF28rK7UNn2WE5RnIA7xQ1XSLnm8ZigZD7Of4mACPqTulWKt/22iMHxZcMp61q42gekSE7bhM0VpecupLYxWMu1Ha3iyEdrKQiMumNeveoywXokDOeu8NA3FE95oi6PiXVTd+6wiJC9SMpcmhCJlARp0EfY3KX64bXSk6MTEQK6A0swvsXSMl2veOLiXqEd5ilUr/5YdeCVsXMh24ZLosXcEHifK622Zibh+HKSOI44fgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjJp9rxldYjLcIUobCwtmuWIRfFMQH5cszsq3Fe0LwU=;
 b=q0/ddlexKvgiZkzZF9TMXFCeH5QX6kbJWDySW+CN/5lncuFWH3pqwRCMfVg8A5JSqRV8y++XJWjg2ii5dlUrPK56YpSMzlHk1It+WzSzP2TcB3ARfRLiXUicyj03GsD2lvbgjmxvvweUtzAC45yJp/1AQdSU+rwfbjSS8CPSnwE9hR0CQvs+Q0BZ+C6pFPVe+MQy1j+DWm26c9iUfVcERCAL24f6d/9UyPLo1ZMeTOOdP6PGIXVZ46HQ2pqu+N+IwqqMyv/fhh88e932S55bw4wr5E5PCCdCuqtNKousixecQZBv7XUjKB3ORky7hLGQp8k+AIjeEdTdCRkeER/uTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjJp9rxldYjLcIUobCwtmuWIRfFMQH5cszsq3Fe0LwU=;
 b=huNzSMuINYIyw57d4wRSvb+ebC4WpVj4mwPSzEgboTt34/fKkXx3s/DcFvx0t9s8+WwuN/hoHtJPhbImVqHHEq5fxvoMhEJzUfY6WNkb5RhOfYGvx4pkyCfzO5OqI7VbG7jLmbDGPPZIksnFiUlzx3WsIMzkzdGnSWaJFzzTc/o=
Received: from CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5)
 by LY0PR12MB331121.namprd12.prod.outlook.com (2603:10b6:404:226::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 21:32:52 +0000
Received: from CH3PR12MB8075.namprd12.prod.outlook.com
 ([fe80::83e8:3151:eef1:9e40]) by CH3PR12MB8075.namprd12.prod.outlook.com
 ([fe80::83e8:3151:eef1:9e40%5]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 21:32:52 +0000
From: "Patel, Maharshii" <Maharshii.Patel@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across
 s2idle
Thread-Topic: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across
 s2idle
Thread-Index: AQHdTGSke7N6kQgkRUyQxWaWiLyv4rcKQPD3
Date: Thu, 22 Oct 2026 21:32:52 +0000
Message-ID: <CH3PR12MB8075FADB8E90CD10DBF9BFC6F3652@CH3PR12MB8075.namprd12.prod.outlook.com>
References: <20260924203756.2771789-1-Maharshii.Patel@amd.com>
In-Reply-To: <20260924203756.2771789-1-Maharshii.Patel@amd.com>
Accept-Language: en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-22T21:32:39.2039598Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8075:EE_|LY0PR12MB331121:EE_
x-ms-office365-filtering-correlation-id: b2519d23-913f-424a-e32b-08df3084074f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|23010399003|10067099003|18002099003|22082099003|8096899003|261021121427099003|13003099007|11063799006|261009223027099003|261022105027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: epWzUrvCKUoVlLE8P3nAMLjZRWiWdJAjkK2TgoI8DRiwmIo053UEBmxmMC2gcKaMw1Tmu+/sKlsHNGDIvdZsQz/tZqvDq+k5e5FLhFN5Svo8ID9QXcn2I/0JugGjsBqhVckIl/hAYY2vfGwORfMK+3hjd4RoTx8RqV4fcP0OSz4kq42tgFlaW7gucdYaP0g+fZxOySjjSqNSy9X8LHpsePCFl7DaEBF56pdE6wqQyse+IJpYe7bdsRg/9hRuyzzam+1b1sBoM5YwnqXo1sVnkmrsJpcVuL1iSnVQaZ9rNLLn3TM5hm6scHasaBV2WtKU7V1vc4h9Ccrr5pIR4c9VXtS57HKP+JZv2ciz/vqGK4JP2KE6NyQDOHKLqXYEMsKjYEXBhxHXFOI/yjzFDMIKV1DSYgkxnjnD4pgVyLNToC3YD73KHJDmx8DKxcazCTM2XbYxKc3Djjcm9dxEgNVwOeiHeabkukGsGtLcaEQc/R49WQrIHtdjAnxurlm+fEFwTzthGISNaQdWJ0W4axMX1dxWNVGqi6CWLW1NbD9HcEG/t13C52tNi6Ypnug6hRXtf7OQdut4Evp57Fr5zu/mhtZsVQg96K1w/5bROCxnqzUSM8fQsrNl48SzVjV8GMfbBX3/w2c7sDZvDlwyMHG7T+a10CJ5WSq+uZrBfRYXRh3THvWiHAPh2APryWFylG1ArVo4peFSpAjeMDOfmM4hZ1GuNa/0jzMUu7y0XV6qEGA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(8096899003)(261021121427099003)(13003099007)(11063799006)(261009223027099003)(261022105027099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5KUMNSRu1h20PeOpECZYgmP+vjEUvWhfRVoC2Wtu24zjZNBxw3vjQXsCd7pg?=
 =?us-ascii?Q?VDDxYB8liZDHkwG8/crd4whXYsdx1p8R9nTmp5CWwHcUSdjdQSZeYf10pobZ?=
 =?us-ascii?Q?Z2DDxLfUyaPEW+tLtHfY+HIsMGkQus43FnEGH++/5gyUcePB6+ldZE/V2fNG?=
 =?us-ascii?Q?hGxMKfmWGy7Wgsjs+++qmo+1Y/CJwBvhFjnIwDqHyUgpB8MQGVCpPZ2dWfLY?=
 =?us-ascii?Q?UMjTRpGfWvijfcOr2/2y28xZ9tIIF0YihVaC/Nj4mRH/xZ21NgfTCSjVm4Ov?=
 =?us-ascii?Q?3RkBYK2yJE3nCFHbvpWLHV6COOASmDZmCgvpBAkFFXHMqphrtXGBXm+mvia/?=
 =?us-ascii?Q?hXELvP9+nt4CbspexpBaTIvxFMeEmNAZ3vgyYZsEbgpFs6DDx3uI31HbhOUB?=
 =?us-ascii?Q?lmSbr9h1Ek3VxjZ5OBfXWAq1TBq0f26XSj2w9nAokOzL/eizIkYp2ANxGfkr?=
 =?us-ascii?Q?82zgS3NHcMIZV6AVLkrkRqAMznBxgzGceJyteeaAO0yOInld2XQm5vWPCCjG?=
 =?us-ascii?Q?4YBg3AFZo5N3R9pMZuDUzCOkN6kbtCk8tmfh+YeQ891L9ZPlORfKOihQhLAF?=
 =?us-ascii?Q?f/Z4AgsYC75BaKTTw5HtvlakZXm2WS9Bk6C1BmzNEPnL00TLsKXUhBLNAQTA?=
 =?us-ascii?Q?dSKOH+Ll/+47zgzEsaWERztQMs9/UwUmGexbHOO7rN6dA2Cmq4mA9q05D/pL?=
 =?us-ascii?Q?wFnGpe3OpdzUT0ik5S8uH+ujL8k41MdWUP21oLBaBy7NdksI+jDU/25a37Ro?=
 =?us-ascii?Q?EkFViyZrg7Z93hkHvJ1ZBMX0DZJJ7p8Ywb4ccWcqpwPf3Rr66XV+2HVE79tj?=
 =?us-ascii?Q?WXx9QLNVPsstw4o4XON9/SJFwP4keB7KAD9KwLu77lPX+QZortKjBsQjoa5C?=
 =?us-ascii?Q?BZtvelaMGud80x6D1rtZdDtpPihnKLbChqQD+UCQOEicXlKkxz0Elz8c45Nd?=
 =?us-ascii?Q?dakxJPhLIisxVZjWojhJ5RSCIjIJdp8xJ2YwfAL6JF5xpzh+ZFcPmzZrQPHp?=
 =?us-ascii?Q?H5LDOMgUBG4Y3Dso0/vFelevgX3YjQqafxtomEPogNpz4vkSfzGdBvR47YQy?=
 =?us-ascii?Q?lylNUqwa1mA5T0OSpJquLg232l3qkE08BQjDpZ2Jj56raKcxsigUSdoeC21F?=
 =?us-ascii?Q?uVMwpVF9rhB5c/QzyoyUMXHfX6Dq4VjtAAuVrcuwirSlTjAd7ALjCG4RkXJ4?=
 =?us-ascii?Q?yM8VM01ohMdM0ANHShU1mztwZuCWXRN8S9CIWi5Tenxynpc8ZvbB8mKq2yi9?=
 =?us-ascii?Q?MwR3lCE89eq7wpTfl9L27Cl3Bh8u9ahMKkatgduVjV8XlRz6073fg2YLixMj?=
 =?us-ascii?Q?RcoN/mO+xAv9pz6Cs+rMAUSxKbZZ6eBhhGUjdorGRYeWw6fSKB1Zk5HUiaTw?=
 =?us-ascii?Q?v4+olNwc4V2zF+2PrmZv7aBIWCC9JVAPoBWZP1c/m6XScUi5MOLeFMR9w1Cg?=
 =?us-ascii?Q?NdURYe9RrFxw6Tvnv3XY0bBARW5bkEG1MoJYZr9mU1/hCdPSm3pZ/uf8jeoK?=
 =?us-ascii?Q?M4ykfxvrO6IdhvMOmwzNeWvAhr5hI9imgutoVWZ2b242ndmRwl9fFw6lXmOs?=
 =?us-ascii?Q?QYJHtaEdBj8ZQuOo4L7VLREPwz5HYKa42VUHlYbZb98ytHLhwXNuWfGWyx0e?=
 =?us-ascii?Q?eXARMAc96ljrfBlTRgstNqIlcqrpmSw48seu3B65bJuLh7FQOUf859n4RVfi?=
 =?us-ascii?Q?wTFton3q/jcdpGXveMMN8IxL1gSmbhyW/EuCQEDDJfuwQ0vFWvLt0NTi62JX?=
 =?us-ascii?Q?ULRmLupTIRnyNqNvz+8ybBKCb3gbcI4LKr6oVtiVYfrVuKyI5g0I95qh23FT?=
x-ms-exchange-antispam-messagedata-1: x5YWtmjvNgYqTw==
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8075FADB8E90CD10DBF9BFC6F3652CH3PR12MB8075namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2519d23-913f-424a-e32b-08df3084074f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 21:32:52.5538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehNC8KfuD78gL1w7Mkl84O7nzCkL2X4PrYDiB+6Qt3sDiCW7V2tafR22BETYxFfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB331121
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_CH3PR12MB8075FADB8E90CD10DBF9BFC6F3652CH3PR12MB8075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hey folks, any update on this?

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Patel, Maharshii <Maharshii.Patel@amd.com>
Sent: Thursday, 24 September 2026 16:37:56
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Patel, Maharsh=
ii <Maharshii.Patel@amd.com>
Subject: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across s=
2idle

dGPUs take the S3 suspend path even when the platform suspends to idle,
but amdgpu_pmops_suspend_noirq() skips the ASIC reset for s2idle. On
desktops the GPU also keeps power in s2idle, so it resumes without
having been reset or powered off.

SMU 13.0.0/7/10 and 14.0.2/3 skip smu_disable_dpms() on suspend and rely
on the PMFW to clean up on reset or power loss. With neither, the PMFW
still holds its pre-suspend DPM state and stops responding when resume
sends EnableAllSmuFeatures:

  amdgpu 0000:03:00.0: SMU: No response msg_reg: 6 resp_reg: 0
  amdgpu 0000:03:00.0: resume of IP block <smu> failed -62

SDMA ring resets and mode1 recovery then fail as well, leaving the GPU
unusable until a power cycle. soc24_need_reset_on_resume() does not
catch this, as it only detects aborted suspends.

Do the skipped reset in amdgpu_pmops_resume() when the VBIOS init state
survived suspend, i.e. the GPU kept power. S3, and s2idle platforms that
cut power to the GPU, are unaffected.

Tested with this change applied to the amdgpu 6.19.4 DKMS driver on two
Radeon AI PRO R9700 (gfx1201) on an Intel Z390 system: s2idle failed on
the first cycle without it and passed 16/16 with it; S3 passed 10/10
with no extra reset.

Closes: https://github.com/ROCm/legacy-rocm-build/issues/6684
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maharshii Patel <Maharshii.Patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 9c5e93c..b9be88e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2703,6 +2703,24 @@ static int amdgpu_pmops_resume(struct device *dev)
         if (!pci_device_is_present(adev->pdev))
                 adev->no_hw_access =3D true;

+       /*
+        * A dGPU takes the S3 path even for s2idle, but suspend_noirq skip=
s
+        * the reset there. If the platform also kept the GPU powered (VBIO=
S
+        * init state survived), the PMFW still holds its pre-suspend DPM
+        * state and times out when resume re-enables features. Do the
+        * skipped reset now; resume will POST the card afterwards if neede=
d.
+        */
+       if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev) &&
+           !adev->no_hw_access && !amdgpu_acpi_should_gpu_reset(adev) &&
+           !amdgpu_device_need_post(adev)) {
+               dev_info(adev->dev, "GPU kept power across suspend, resetti=
ng\n");
+               amdgpu_device_lock_reset_domain(adev->reset_domain);
+               r =3D amdgpu_asic_reset(adev);
+               amdgpu_device_unlock_reset_domain(adev->reset_domain);
+               if (r)
+                       dev_err(adev->dev, "reset on resume failed (%d)\n",=
 r);
+       }
+
         r =3D amdgpu_device_resume(drm_dev, true);
         if (amdgpu_acpi_is_s0ix_active(adev))
                 adev->in_s0ix =3D false;
--
2.43.0


--_000_CH3PR12MB8075FADB8E90CD10DBF9BFC6F3652CH3PR12MB8075namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Hey folks, any update on this?</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"ltr">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" id=
=3D"ms-outlook-mobile-signature">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Ge=
t
</span><span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-syste=
m, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;"><a href=3D"https=
://aka.ms/o0ukef">Outlook for iOS</a></span></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Patel, Maharshii &lt;=
Maharshii.Patel@amd.com&gt;<br>
<b>Sent:</b> Thursday, 24 September 2026 16:37:56<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@am=
d.com&gt;; Patel, Maharshii &lt;Maharshii.Patel@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reset dGPU on resume if it kept power a=
cross s2idle</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">dGPUs take the S3 suspend path even when the platf=
orm suspends to idle,<br>
but amdgpu_pmops_suspend_noirq() skips the ASIC reset for s2idle. On<br>
desktops the GPU also keeps power in s2idle, so it resumes without<br>
having been reset or powered off.<br>
<br>
SMU 13.0.0/7/10 and 14.0.2/3 skip smu_disable_dpms() on suspend and rely<br=
>
on the PMFW to clean up on reset or power loss. With neither, the PMFW<br>
still holds its pre-suspend DPM state and stops responding when resume<br>
sends EnableAllSmuFeatures:<br>
<br>
&nbsp; amdgpu 0000:03:00.0: SMU: No response msg_reg: 6 resp_reg: 0<br>
&nbsp; amdgpu 0000:03:00.0: resume of IP block &lt;smu&gt; failed -62<br>
<br>
SDMA ring resets and mode1 recovery then fail as well, leaving the GPU<br>
unusable until a power cycle. soc24_need_reset_on_resume() does not<br>
catch this, as it only detects aborted suspends.<br>
<br>
Do the skipped reset in amdgpu_pmops_resume() when the VBIOS init state<br>
survived suspend, i.e. the GPU kept power. S3, and s2idle platforms that<br=
>
cut power to the GPU, are unaffected.<br>
<br>
Tested with this change applied to the amdgpu 6.19.4 DKMS driver on two<br>
Radeon AI PRO R9700 (gfx1201) on an Intel Z390 system: s2idle failed on<br>
the first cycle without it and passed 16/16 with it; S3 passed 10/10<br>
with no extra reset.<br>
<br>
Closes: <a href=3D"https://github.com/ROCm/legacy-rocm-build/issues/6684">h=
ttps://github.com/ROCm/legacy-rocm-build/issues/6684</a><br>
Assisted-by: Claude:claude-opus-5-5<br>
Signed-off-by: Maharshii Patel &lt;Maharshii.Patel@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 ++++++++++++++++++<br>
&nbsp;1 file changed, 18 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 9c5e93c..b9be88e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2703,6 +2703,24 @@ static int amdgpu_pmops_resume(struct device *dev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pci_device_is_present=
(adev-&gt;pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;no_hw_access =3D true;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * A dGPU takes the S3 path even=
 for s2idle, but suspend_noirq skips<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the reset there. If the platf=
orm also kept the GPU powered (VBIOS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * init state survived), the PMF=
W still holds its pre-suspend DPM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * state and times out when resu=
me re-enables features. Do the<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skipped reset now; resume wil=
l POST the card afterwards if needed.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU=
) &amp;&amp; !amdgpu_sriov_vf(adev) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;no_=
hw_access &amp;&amp; !amdgpu_acpi_should_gpu_reset(adev) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_devic=
e_need_post(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;GPU kept power across suspend, rese=
tting\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_lock_reset_domain(adev-&gt;reset_domain);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_asic_reset(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_unlock_reset_domain(adev-&gt;reset_domain);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;reset on resume failed (%d)\n&quot;, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_resume=
(drm_dev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_ac=
tive(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s0ix =3D false;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH3PR12MB8075FADB8E90CD10DBF9BFC6F3652CH3PR12MB8075namp_--
