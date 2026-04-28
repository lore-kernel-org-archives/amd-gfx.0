Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10C0FF8864
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639FC10EA0E;
	Tue, 28 Apr 2026 03:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UA+E8jGp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D5110EA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo8xDXb+lRRzcKUPewNicAjelhciMtcq6G2CH9Xwyj2uFejZPpRFPByFuFdxZ9YV/fJOhbulCMq1ztW3gQ14X+xsRUhHbWSbKFjGDHTZtxMpF11FfLJ/2SDBktLGFXtM1iy5ZIZylj6uRFYTiuTqcGQM4dFqe1Pjk8RgFysvtEY16rlZ6PaCjyyfm1j81q1/auqfpCwltTXqw4/lEmheogpS+gWaBlXG72US3pGue8sbvOdos1+G0toC/yOsZGZVK4Qgb2P4f/5eFbzdxja+ua1zKMvNazuC18YgZQiIgvpFZg6MSsv7TPLUBHh5vQ921GIb0+R4Kc33r/WUHgUN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf9RwN6SfrGZroEo1gC2P15GqbD2LZfA3KhidPFAjKc=;
 b=W7bqqH/psqndKkfevxKa8kTBi0pVWWirXv/PJ8T8ffz1DWgjmvnoRt5cVta/4YC0YAz/EubJp3DB8Kw5B/NJQDgdNAcmi03VW7gg354h4kRbwzhtCXX9ATyV0jas7g+o/VDapswJ6EMx1Rg5e7sL0ZoT3gX43pn/gHR0q8EqCedOossaiNlo8sNO5XUCv1AkV/hNP0vwmlfIIdmfwOJnqedJt3IprCmrj6j2acEkdzSQ/bz5ijEoU5fZzPjKIYdAMq2XwjKwUlmDgi0HLGjWNhBjYjlknuX27VvdJvnp4LlNey3RfS4fHaAQGHB3yU6lvHmQSs7ybMTTOYZOZD7JLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf9RwN6SfrGZroEo1gC2P15GqbD2LZfA3KhidPFAjKc=;
 b=UA+E8jGpC9fLItNVt5L9lKrFtLgE9LK/sas+5NdmeBYm7mxV6mG0mEPeO1mp/SLIF0NuOkmFT3LYiEP0wAwOYTjZybS361I60/1PC8VygA7CdT3yk7hquTm73bTYTsgy+iTFZ0idu9dzcCzf6K7lwG8TeDPeRQu5O9RO/wMdWBM=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:16:22 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:16:22 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 08/17] drm/amdgpu: add profiler/spm interrupt handler
Thread-Topic: [PATCH v2 08/17] drm/amdgpu: add profiler/spm interrupt handler
Thread-Index: AQHcu9QY5sOcNsBoYEmvAi9uQBp8QbX0AxAA
Date: Tue, 28 Apr 2026 03:16:22 +0000
Message-ID: <BY5PR12MB4179E048164E443B31F33831FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-9-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-9-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:16:10.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: 5397717d-f4b2-4513-13f0-08dea4d4866a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: SAtqkr1RiabTiZ/yj42JGLymu4JTK2P3Q/eimo3crPxrXUQHCfNvzLnGg0VaMTtvzhU3bhiJQacbrNmoiFLmLWYaZW8dR307XnH9exPPjG4LwJkZCm1ocQq9xblzyK5+g6kJlv8qZ810cDCeWJjCfugJOLtDkMFu3vKuXuFxjsVVmXZerqpHJlp5iAHLh11avgADHhpLpvAPk5vYFnwHrbe58b2chxf3sjiEN38xcOlaJ/XzNW6uuPReiNV5JxcTWIG4ILpwgYtX9be+qwaL+SbW86QsxRwTiTNOj0LMsxXbJZ4FJaIz+rsFMBcnNsWw6ltdkjWugaOOF7RkwZpAJ3b1Pn34taOCjNHG/gZhWem34Fvr6JaQDp9GkA71EPD1y2QHNK3zvlTaI7fBO1TC9lm3uAVF9N7WKMF1sJqnkTxNIMfSMLWGJXztRld8mKt3sQPyT+9srzfsSRPHPBlf+YuNnH3zi8S360u9EyHqa9ish8VgVH+zHjUTOlSwUakwJzq7HKIW8UH+XBsLa0hq8WFgW0V6CH3aADAz99JJPesDtPm0MYRI8C/hW5JB7QpAqpXO832W+P5fG6AsZ3L2zPQi9+CzYyaOV4OeQ/xpSYfw8YZ15HNhChkrF8o9d71guK/X+usTfAgMcZ0FzdALS7ZYj3+VQ3QH6i1ebU6PPKZh5qu/pSGNyqOaPv4z4Rh1BQGmLSCcx7iiIU4UFdF8dKRJf+DWfthahkQ1zSn/LmSvwtvq513eT6RsTIZMepA+begyUrGaGUWULEVLRi8e8RTkg2QbcFEscjgn2sVRF3Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4NVpLAE0upDT3V1g8FYVQtOTjJxrm5K7mRShcbEG+9kkHCvv/Mo9KTmvC26x?=
 =?us-ascii?Q?cGHYZBb2mobOfpEY5syAL6iZcWmo5HwTEvhGskGLt69kZWSvgpulx99v9yrY?=
 =?us-ascii?Q?u3A815nrswUIVU/ETZhUCdeNk+cj034nX7oRriF1xjdzzKVavSQYYaMJeUil?=
 =?us-ascii?Q?iMKGO0EmOnI6X2CFeP4WPZJG60vFjuXgYvkbjWeP3Bt3YEhlbFiBspywNYNh?=
 =?us-ascii?Q?b4C4CnuUtnR/ODqLfYnF8+lFgrNFe0QGndyBF+AK9+7oRp1u6azPFCY/74Xo?=
 =?us-ascii?Q?9ggGhuXGiWGeioiMj/QIuRjbEpj3xQl0aJCkNWbZWBUbNlU+P5MoZJgvoZW+?=
 =?us-ascii?Q?mbW/LZ6yKd3NK6BSLnO7DsNbSNc9oWEZhJtHL2o21JuZK6v4iTIQtOKim5Zz?=
 =?us-ascii?Q?yomNU6+VJIUQPoqiQqwWITAugGgPZpErU3Zvv/kVY6z8IklNP/53g7LnrUGA?=
 =?us-ascii?Q?DWHtyKkPInJcn3kmZ/B1n6Ym/xhu7k/rK8lZTETIILhT6HMCNfuduKJU79wv?=
 =?us-ascii?Q?ICI2iFmnsv0Onl5nItA05y/BfBRXOpxNlkBuzK7/5fhcDS0fVnqAh5iUG/Sa?=
 =?us-ascii?Q?2nYB7L3I1lXTQv7hgQkh4smMABVtphzbITkfHiTKJYAVqJxdvOsEUDo3SWlp?=
 =?us-ascii?Q?n4WQ7fF6zTxvtN/LVCxg+/SLJRlZWM5fkyoLhaGdvu1P2/xLt2uMEcmHP8sA?=
 =?us-ascii?Q?VLnU4MUsf1WEi5/0APDD6mP8TksUxRMha6jPGLT+IsIrB/2y5lC5RId/TSI2?=
 =?us-ascii?Q?EFBrIaQoAcuxLNSebniuCA9fMKjhIeTXYUHXBBOwzrHegAOJZARoT7pZAD8L?=
 =?us-ascii?Q?7W5wIr3TAuLFjIQtmuEuP8ISRvvzvBdCo2boR/MvfFnL0POxhWdSN/Na2akw?=
 =?us-ascii?Q?LzIU+xNg2B8eDa2Uhhi+nqXS9LXjkVgYl5s9nPd3QihXZ+sGM0ipmapEbcNh?=
 =?us-ascii?Q?YTyu2rN4VPQQ1ya2EVZphloL42cdnTgUA847QlWO7hMSchNiQ1HdtWp4azCc?=
 =?us-ascii?Q?hLIT+Cwkgo2VQX9stWybHXaPFGe1Ft9KfqsIosS6cg2Y5NqWaXIi4OGKbRV5?=
 =?us-ascii?Q?gvFBkp2Fylk4ADBB4THJrPYPaZq3Zu2kA2Xq/XrYbtwh5KEN9JuZi85CojZl?=
 =?us-ascii?Q?B1asTtZwzzCD9sQrQaJSo8dN2RiL7O0XFLK70K8kXCXrXJcAjb2E5PEwdKXH?=
 =?us-ascii?Q?CKVa1TXZYIBhQKBna3tpXkHPsW/Wpf22EWVKqpvD4GEFXdSQr/v2UTX5nXaB?=
 =?us-ascii?Q?ZgsPpdeiHvlrQvN5k3vqx/AXKgOgOEncCpgorCY91Smf7WGkYYdscBxi3eec?=
 =?us-ascii?Q?g+ylQckC9odOJbiJEqpJ+8WcZFYy0PFwO4aVZzP2NyoIwzlASie8kmNXeazY?=
 =?us-ascii?Q?OCuqmixmTlpkrWINTT27qZC/rGuswUkI7PK8ob0dWGe+3DqFF0BQBacm6kk0?=
 =?us-ascii?Q?TORkpSG7z3L9owl+eACHyA3+dI5iwTnvr2TtqhPiYCP8N2e3A6otJmxL25AC?=
 =?us-ascii?Q?8plvGt6eZ4yZkRwGLibg0o2o1ItItjIpOERcyeVKRLJg9deIor5ydUhkaV7L?=
 =?us-ascii?Q?XclMlnlC+8AfOJc4iq+WFoeBhpIYoWpT44Ot/TU44G1xdfXuN4/qcL3CVDqB?=
 =?us-ascii?Q?9mZrhIiUaREgBvNtu2DRwmZnH/tDRIKvsKgSaaKFbo5XehWQh/B1qiUbUT+W?=
 =?us-ascii?Q?Y8vQXvTqyHIt+zkBQt72S/pFludbuLodKHms9IDnnCL24xrq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5397717d-f4b2-4513-13f0-08dea4d4866a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:16:22.8289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fl9guaBKQD1lsGI2i6udGKbikR4bkz/UEeBoFUPRlw7lDBOHEqVBUlIaTmNU96+2JybHl8ZFuri3af0/UMSHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

AMD General

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 08/17] drm/amdgpu: add profiler/spm interrupt handler

to complete the amdgpu_rlc_spm_interrupt() stub by wiring it to the new SPM=
-layer interrupt handler amdgpu_spm_interrupt().

amdgpu_rlc_spm_interrupt(adev, xcc_id) is the entry point called by IP-spec=
ific IRQ process callbacks (e.g. gfx_v9_0_spm_irq,
gfx_v9_4_3_spm_irq) when the RLC fires a Stream Performance Monitor interru=
pt. It guards against unconfigured hardware by returning early if adev->gfx=
.spmfuncs is NULL, then delegates to amdgpu_spm_interrupt().

amdgpu_spm_interrupt(adev, xcc_id) is added to amdgpu_spm.c as the SPM-mana=
ger-level interrupt handler. The implementation is currently a stub (TODO) =
and will be completed in a later patch to schedule the SPM work queue for d=
raining the ring buffer when the hardware signals that data is available or=
 the ring is near full.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 5 ++++-  drivers/gpu/drm/amd/amd=
gpu/amdgpu_spm.c | 5 +++++  drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.c
index faf2a34df42f..fa89dc04d072 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -671,5 +671,8 @@ void amdgpu_rlc_spm_release(struct amdgpu_device *adev,=
 int xcc_id, struct amdgp

 void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id)  {
-       /* TODO: */
+       if (!adev->gfx.spmfuncs)
+               return;
+
+       amdgpu_spm_interrupt(adev, xcc_id);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.c
index 27f4ed1aa1e0..af7ee74aaa35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -60,3 +60,8 @@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
                spm_mgr->file =3D NULL;
        }
 }
+
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id) {
+       /* TODO */
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.h
index 06b4f6dba41b..ade50abfa590 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -30,5 +30,6 @@ struct amdgpu_spm_mgr {

 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);  void amdgpu_spm_=
mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id);

 #endif
--
2.34.1

