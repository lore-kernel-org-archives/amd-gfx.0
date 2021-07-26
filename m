Return-Path: <SRS0=1/L1=MS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B106BC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 14:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0CB60F37
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 14:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D0CB60F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF136EB84;
	Mon, 26 Jul 2021 14:28:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9642C6EB84
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 14:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI/668kGFQ5FLdM0vqtTMlErx4yXdKeYdX4eTaJWL2PgGtPcaeqo6oQSRk4A17NaxzkFxp/trcVdmU6K5kPVcxJNOiU7sJQKG+wRdzYgpHk0/o5bd+WU/KkRTn11lnOp9b+f6dTI/mNqXWF6yKeARQw6pe6JxGtvWnt9tO9ly3jSbCpDBQ/5l2c610eXv8cjvjH0v3vyqM4iuL6bNveUQYWLAoDGb3xS7cIqBHgrug0+VkOhhGHRTRh4ta5mL5jwu+CyUxG2zlLrqFRz1Z2m5B3cyve9YkgQP0ZcY2Kga6SaZnsNxzss/cFIMncqvSi9ovkkV9X7VEye5wPqyka7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJXAK1e7sEltAjeGtKJX2pAbVHPOi7i425Hk0zbx3UI=;
 b=Wzw2JgdiwKCy4h3GdGR7LjYAEQJ9w1Vt/yLnOLw3L1q05ToqQJxHZ3t/95QtQvn/tDR6CHmp1kGvbDo9od0Wa/BpwaAuQXif8fRGvOoJfNH6uy5IEFmJpnmxviJqNmFIQaLcCHnGrTwKg3Ep4t8Vc+CEfUk2BluLG39Mo4pwoD+8cpRBEfygWoFpYsXW05NyrGDHwBiLqFLcFz5gYExL01fg+hUCOsmLRuzQrer4kmd8frNH7MnrcLowPqgUCiQKUBMcb5zz+jaRATVKTSweDzFsHl11ifuBTmOnSCzKj2dtHNKTgztc9LkiKtVLAW6jPiSgmfGaJ8bKLUNIPVBMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJXAK1e7sEltAjeGtKJX2pAbVHPOi7i425Hk0zbx3UI=;
 b=OlaJuuLPM1jraXuTFicSSr1gkcIqLtt+1p1GbpjuCMflguDY5RDQaPW8N2/1dx6fmSWowQku7CWph45+ziEryg2fw5Ejnokm5OvOs3/Pzf0c5ZtY6YsLeIJZk8wCuCQhYqTcwiPjLPo5I9CnzuDiOV/ccwig6w8XeyXFU0tatj4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Mon, 26 Jul
 2021 14:28:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 14:28:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Rename amdgpu_acpi_is_s0ix_supported
Thread-Topic: [PATCH] drm/amdgpu: Rename amdgpu_acpi_is_s0ix_supported
Thread-Index: AQHXghpxNE9Ho4EMi0ib7w3sH+NqCatVUKXz
Date: Mon, 26 Jul 2021 14:28:20 +0000
Message-ID: <BL1PR12MB514496E8592D50CF4B2DF600F7E89@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210726123313.3722569-1-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20210726123313.3722569-1-Pratik.Vishwakarma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-26T14:28:20.321Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5d6cc1f-7baa-410c-e836-08d950419e5c
x-ms-traffictypediagnostic: BL0PR12MB5521:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB552106C64E83A834B86A17EDF7E89@BL0PR12MB5521.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwZv+CQUwSFuoqdrrGbF0kjSRQ27+wAKUitLYvQSw1lH1ZyDOTIKvenlcKYB8nBlE/oklfvH94vkI6X6vXrENOKKFA1ciMd2ljLQM16LCyRwDG6dctSsezqERFFPuyPmDzvbZuv2b6ZxRTg25hdFGI/o6ESm7okNzSTW2SgbNCmqjAqSASmEj8KGzl+VDags+QYiGXNJfE7KtWB9M/+leDGgHDgR5vVf1jzgMQGZdZBLakYU0V6obtxL7VxRsrOq8K2ykHt29VEByRUG8Kmk2bS/ZeJQxlpJfl0psNgtnsgnvzetMhmtNE8TwYPg49KYbIhrJlnsgMxfqNKYcQ0xoksjAcbuuUnb1Cu+QXzyS8KaReFd6C41gFKVUK68GsR2IV+v+huJ2thY5OcAGgLXtpu6Fim0HvPjhB2o8ATy0alied647UJeaKHFHhlbzgxa1tp63R5pTDRibJhL1crNnmkz4+TUOAZO/HaOLKvxA7SA6v4fYI9cRsMDjWBDV22V94js5XyGR6szwiwRMajfiQKyLTh6qfYqD0gYkApGBur/Z9cS2YUCGcDfXbf1KKYMrWySvbkHza6aw3LRn71nq9gmggCsNzLqIwT7Wq6BIsCyR4TuLyDyISjHhRbmCiEP8GX9FpuI9N1sE4+xpzGdG6zyULhEXak0LIgMlxekn2pMLZuQNGRcZQyed+UHxYBcV2TvrKxFl0Bo0rTmKyHmJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(478600001)(7696005)(6506007)(53546011)(66946007)(122000001)(38100700002)(186003)(8676002)(9686003)(8936002)(2906002)(110136005)(26005)(19627405001)(86362001)(71200400001)(55016002)(76116006)(64756008)(66556008)(66446008)(66476007)(33656002)(316002)(52536014)(5660300002)(83380400001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9yoIhV5Jv3WqJM0vJ2SSJ6LEXB6b5s/9RYl7niaHAVJwAvIm7kcD3U/Yjjkf?=
 =?us-ascii?Q?tf0EC2fej45bPab1OITGswDHG4UsAaOvKMR6WV4M5zR7yLSnON7LMT0qp/nw?=
 =?us-ascii?Q?hW4Hp3aFtRKidYqzF0/036Dc4UQGp8GIgacNAaK7Im1jR05tQepvUOJdaQ3d?=
 =?us-ascii?Q?KwcfXaNrUYzE5dRsfS1fF1O5jYqmPVL7uCVwL1QZTkZjPjfjpjHR4wCy2ePC?=
 =?us-ascii?Q?IqLaketrfrLGMLmFJ+DT+ZAyauS115X0I95PmGdemJS+KXoDE7s8KmlBWXFY?=
 =?us-ascii?Q?1TaraWlZ10MVNY5md0oJTpyuvwXooqdWDLAtZFydmHx1y4bq+iQ8eJrfOlco?=
 =?us-ascii?Q?Dte2EUrAXuhXSHH8DVLqUI1F0w6HftqIuWx9dfEBOKkNjdrgXcVeTlg6LLM9?=
 =?us-ascii?Q?+kCSi30/gwIUJt5T1IdHAqJm/JJwrHJTB2veCDxj1kvXPljdMF78amasQ1s9?=
 =?us-ascii?Q?mDAQVkeQOz7DZKZYr91oqpyxzU/YV6vDgnuwDSyGG/mBmXa0yLDqOvUzZ64P?=
 =?us-ascii?Q?OPVMY0qFUoELle2CpOtxpjhH2O7Z20L9QT/pii2a9msIUKz0fN0vWI4b/99G?=
 =?us-ascii?Q?WB29vVc3J2bGgkW8Bs3aZvzSGLbgjW2czamYnFoP7FoMPJhePpo+PqqbVuAx?=
 =?us-ascii?Q?8AMVKb6RjZ28UJA6Hv3QFrjWJGmBp66/ERgqNSSZ32ZMQHp0WfSY7RMC5uAG?=
 =?us-ascii?Q?6TE3BrChZFDIqBYjI0PvVFz06l1gis+Ku3Rm7DB+Uw5uETQ2Ul5tJ4jlx2/Q?=
 =?us-ascii?Q?5U1sBJcsFEd+ndFZeEdQ0OnH4yFX+RAIOIU9T5sWd+VAYizCxrMC8TWmANqZ?=
 =?us-ascii?Q?NyH6Tg1rYiaYwMdiNF+FAnpGayfheDdx+iJPLEd2Y+0Wd5ch4c76whGcVAFW?=
 =?us-ascii?Q?1pTQ5mG3UicAOVZJdh2qPJyq3QwuBY7LcSzctEfJPtPz9N7F3BEk4LFG8+x1?=
 =?us-ascii?Q?OJ51AR2rbm7yeKBFL0ApxX37+8oksyjDRBzsgSweIeS7kRtTq6wXUDHvFb3W?=
 =?us-ascii?Q?SI34uT4JIbVM3uiBurJlef9KjMpMiCIzUub0q139J/8BKVznh/r2sx6n3EPI?=
 =?us-ascii?Q?rKtiYPdCrRmB0hPghr9zdzzvzEVorw5BylQaeB2Lh7UxDO4oGcPUggX0LY7a?=
 =?us-ascii?Q?W+7UwQMLgddgVjJK0Fu8nT7Ow5mVluI6J2joembPxlG6JMp0QIY0R3ySpkjh?=
 =?us-ascii?Q?wN0Q9fQEkBk+2vdPg9LQXJu+pIolVn3Xs7CTf5WgD4X/lkqKS1jwQsBI5apx?=
 =?us-ascii?Q?Y5JsNqN4Nfs9CCsZkq2nugBfR+ay6nb+F6yipUkj+lUIEjQUxkaqnPy+VT/E?=
 =?us-ascii?Q?2wj97TeOL08uWH8rrpong5Zz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d6cc1f-7baa-410c-e836-08d950419e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 14:28:20.8874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33Ktux6yydI5nWjdCAoKzbIkeOwDdVLegwKd5xuGqMr+Sv9EMAaKN6MtLn54j6cQf4ArSxOSlaVQ9u4EhA+avg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
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
Content-Type: multipart/mixed; boundary="===============0270579602=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0270579602==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB514496E8592D50CF4B2DF600F7E89BL1PR12MB5144namp_"

--_000_BL1PR12MB514496E8592D50CF4B2DF600F7E89BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Sent: Monday, July 26, 2021 8:33 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Subject: [PATCH] drm/amdgpu: Rename amdgpu_acpi_is_s0ix_supported

Rename amdgpu_acpi_is_s0ix_supported to better explain
functionality by renaming to amdgpu_acpi_is_s0ix_active

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index dbaa79ddd468..d10baa3338bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1390,12 +1390,12 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);

 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)=
;
-bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);
+bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0;=
 }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
-static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *ade=
v) { return false; }
+static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) =
{ return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { re=
turn false; }
 static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *ad=
ev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index bf59bb263816..0c281c7f5cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1031,13 +1031,13 @@ void amdgpu_acpi_detect(void)
 }

 /**
- * amdgpu_acpi_is_s0ix_supported
+ * amdgpu_acpi_is_s0ix_active
  *
  * @adev: amdgpu_device_pointer
  *
  * returns true if supported, false if not.
  */
-bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
+bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
         if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index af1710971ff3..bbc6bfadafd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1468,7 +1468,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
         int r;

-       if (amdgpu_acpi_is_s0ix_supported(adev))
+       if (amdgpu_acpi_is_s0ix_active(adev))
                 adev->in_s0ix =3D true;
         adev->in_s3 =3D true;
         r =3D amdgpu_device_suspend(drm_dev, true);
@@ -1484,7 +1484,7 @@ static int amdgpu_pmops_resume(struct device *dev)
         int r;

         r =3D amdgpu_device_resume(drm_dev, true);
-       if (amdgpu_acpi_is_s0ix_supported(adev))
+       if (amdgpu_acpi_is_s0ix_active(adev))
                 adev->in_s0ix =3D false;
         return r;
 }
--
2.25.1


--_000_BL1PR12MB514496E8592D50CF4B2DF600F7E89BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vishwakarma, Pratik &=
lt;Pratik.Vishwakarma@amd.com&gt;<br>
<b>Sent:</b> Monday, July 26, 2021 8:33 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Rename amdgpu_acpi_is_s0ix_supported</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Rename amdgpu_acpi_is_s0ix_supported to better exp=
lain<br>
functionality by renaming to amdgpu_acpi_is_s0ix_active<br>
<br>
Signed-off-by: Pratik Vishwakarma &lt;Pratik.Vishwakarma@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4=
 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp; | 4 ++--<br>
&nbsp;3 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index dbaa79ddd468..d10baa3338bc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1390,12 +1390,12 @@ int amdgpu_acpi_smart_shift_update(struct drm_devic=
e *dev, enum amdgpu_ss ss_sta<br>
&nbsp;int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);=
<br>
&nbsp;<br>
&nbsp;void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *=
caps);<br>
-bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);<br>
+bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_acpi_detect(void);<br>
&nbsp;#else<br>
&nbsp;static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { retu=
rn 0; }<br>
&nbsp;static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }<b=
r>
-static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *ade=
v) { return false; }<br>
+static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) =
{ return false; }<br>
&nbsp;static inline void amdgpu_acpi_detect(void) { }<br>
&nbsp;static inline bool amdgpu_acpi_is_power_shift_control_supported(void)=
 { return false; }<br>
&nbsp;static inline int amdgpu_acpi_power_shift_control(struct amdgpu_devic=
e *adev,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index bf59bb263816..0c281c7f5cea 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -1031,13 +1031,13 @@ void amdgpu_acpi_detect(void)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_acpi_is_s0ix_supported<br>
+ * amdgpu_acpi_is_s0ix_active<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device_pointer<br>
&nbsp; *<br>
&nbsp; * returns true if supported, false if not.<br>
&nbsp; */<br>
-bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)<br>
+bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;#if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acpi_gbl_FADT.flags &a=
mp; ACPI_FADT_LOW_POWER_S0) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index af1710971ff3..bbc6bfadafd6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1468,7 +1468,7 @@ static int amdgpu_pmops_suspend(struct device *dev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(drm_dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_supported(ade=
v))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_active(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s0ix =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s3 =3D true;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_suspen=
d(drm_dev, true);<br>
@@ -1484,7 +1484,7 @@ static int amdgpu_pmops_resume(struct device *dev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_resume=
(drm_dev, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_supported(ade=
v))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_active(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s0ix =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514496E8592D50CF4B2DF600F7E89BL1PR12MB5144namp_--

--===============0270579602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0270579602==--
