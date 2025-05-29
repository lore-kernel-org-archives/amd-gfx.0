Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E67C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 12:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6955610E077;
	Thu, 29 May 2025 12:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wExcmzsz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7BB10E077
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 12:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTdCThGVr4pwQ9che293lsYMvnjEyWZ5suxJZKSuGqr2EitugB8K4prPgr6+1hx+LCvHsxJMU52mHcW4+8ReFsF8UlKJ40xJE79MpNbwGM14cNVcAaaoj9FQdLboP+tQF4JXpGZZd30vF+wCxLTJ3QF/dZbvZkIzt+97yuQiG0cARqKYMYchVIyoKsY49ndDRkI+WfN7w69z8NaT7IjIjySqDQZq2x6iubxBpAfjsfotWh2IjnxoboxGHqsF4ZgNwo3ca6lBQGOHuyjgW8fTRAtbGn5p3glQbKdxEWwVZ9Y4jbxY0T1F9dUerXfGq9rfKWtElAtD5aosQJma18bNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQlOEKIVRiH40lmzUSG4JTey8eYXOFhJlsLJbLaqKlM=;
 b=Mis/0NMpuG6tWAm4t811w8mAVfZQMXQMrm3os1mLRPTbGw3ZeVBxQNUwFrl99az3A6n9fB6Vegkjvp4XjdmgWc3vD0u9RhAvPwL/iAGH97M3VAV8HO3YvbObkJg9dGsj2IfIIICw9Zm0PsHfKJe7m07q8EUbWq8/FUJuQrtiQGlMIm6D7wzTHV3GC/qy/wHuQexHLyFtEZuoz4jqepR6lRiMoPNshHigCIATxb0TtqerP9H+43aGaqFsvlyb3QmZfS7yMqwXnjVQCmMIlxZ1SPN1XK2P3+iAriPG8xl8VhHknyXB6F/+LRSUXxv2qz9liGYaP6MXcPwap9NrRI8vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQlOEKIVRiH40lmzUSG4JTey8eYXOFhJlsLJbLaqKlM=;
 b=wExcmzszW6Mx65fygMGDkhkG5kr4701vNeXdiu1x6XAXkDoTXu3NU33/Y4brHcQMO6+sfK5i+QfcV+DN/5PLSzq72CPhxEdbajQuiMkU8Y4INLVv4+DWMg0cO2NnrudHB4ZtsCqZ9vJThOeroIcUszqtS4Ek6f4+FcSuCGEt2d0=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 29 May
 2025 12:11:26 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 12:11:25 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Check pcie replays reporting support
Thread-Topic: [PATCH 1/2] drm/amdgpu: Check pcie replays reporting support
Thread-Index: AQHb0HPyOMjpvDEIOEqXhOgNAsG217PphKCA
Date: Thu, 29 May 2025 12:11:25 +0000
Message-ID: <DS7PR12MB607166CCE5064CAA4ABA40268E66A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250529083015.589652-1-lijo.lazar@amd.com>
In-Reply-To: <20250529083015.589652-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=30ee8d6c-7955-4d76-90a9-4c5332f67f6d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-29T12:11:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SA1PR12MB6776:EE_
x-ms-office365-filtering-correlation-id: abf61b6a-c981-414c-d3c5-08dd9ea9ef49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?t66I9Y1nA8YpqUQPdjhkS3izQc/ulVR8yX1BNPJgqDROkc7SaY1l2VcnIJcd?=
 =?us-ascii?Q?ZGQX94yyaAYKd78AByz19sGvtvbO7kHLcuX3fQXHYDSzRP4dqH50+rx99xxh?=
 =?us-ascii?Q?lr9ohp+KuaHup+7jqvyQibPWkfqZiZ9fKFi3SzvUDuC9XPsq6LkHrlMigjPA?=
 =?us-ascii?Q?4XMycrtNDtt8UDbK7vcuplBzapFWAuLaKvFxaGWoTvkbkIz82gZsmjFvLQLX?=
 =?us-ascii?Q?kCX/jP56gmE0YysQt7wMHPpRg7Z06z/muI6cZ9xfDu4sDNpjtJ+U2i90Qamh?=
 =?us-ascii?Q?USxtt0Ow4ZxcPGpeKhCcc6ot065SzWvz8fWu4Le6vH+Jl/R/rra/5FF5GqjI?=
 =?us-ascii?Q?H6Y9zEi4uELYHeO33H0ygjORdEoW/lM2ryVtChiOwgKBG0wd8c1dIXq6c3wL?=
 =?us-ascii?Q?Bg0DPWAE8v/FB3EaABZ8MzYA1mFNQ+zEMjrazWH6ruFLE7HOqkZiUjOgzRWB?=
 =?us-ascii?Q?3pcTO2shwfU89xMmV5JTp3fnUWQAklIbw2reSlOYkS8Ppx3n3X5PosNssfLu?=
 =?us-ascii?Q?UKmpws+olEOVGDFFc9rdx/Cw4O9ouyrgJG0xg+XPcGLT2S/HBh7h74nswh7j?=
 =?us-ascii?Q?rMxafQDYZ/aUFuqbRhXHUTTJ6IvStL7wSHHegVnO69CVOCZoJKI3Ig57bDaB?=
 =?us-ascii?Q?RP2gd4DLs5xPG5004ewlzHdlzLEROSjpmXSeKAUyuuPUTlB9WOX7ji53iBj1?=
 =?us-ascii?Q?UFqIQF+X8GM5eQqGRoULC2Wq8hECAU4QcilBmc3/R9PP/2IjaWWAOXZ1WXs7?=
 =?us-ascii?Q?lMBD77ebQwsK5+7MBjDzJkhDWIW+6U6EUzO101iQhowCwqTRfZpRcyBw+lEs?=
 =?us-ascii?Q?7SG/Ud1IqgfgebdGpa6/1xta8pkIczoFhPk+ryJ65B77IWV5j6/IqMfrHm+z?=
 =?us-ascii?Q?NsiX9+ubDZHqfLo5YdC35s8pimSEXcYhHYOukaykP/HZs42S6JKP6rL15J1s?=
 =?us-ascii?Q?jq/uSSH57bJC0Cmq0Fibl9NMH9bOBE9Ng3PYw4kIrPQQMYQPph+SM2Is7ZQD?=
 =?us-ascii?Q?+CcnO0JZ8IapwZ5zvtKpOaRvrmsicIPw7oTNxgurcdYdSNQ1yUtkc0frTmXQ?=
 =?us-ascii?Q?gD9yg7wMJtujsNLV84cTlJKH01w/QCGZuv7Ctb3PwL8e8KxoycvsICkmIKhQ?=
 =?us-ascii?Q?0njA/O7cfjA5hYkgaGwCBSZYAII5mQ8UtQhXnwFHgAMC4u48fq7TaUZIu5o1?=
 =?us-ascii?Q?SBUFGFmogMy95rCzkIuQVe+OsbwXPmdqJnY+dBLe7JTrMMTmcSjHURcakNZY?=
 =?us-ascii?Q?kYthl+EAwTUnQQ9L6O6O9j9qZ9Y7/W6e63QXTIxwniDYvxueODhSSL/vebI9?=
 =?us-ascii?Q?W16r8fuRLZ7fyKHCM4YFvXk79L1YDNNNI24JKEGiupQxGkmIo48tb2uAveEj?=
 =?us-ascii?Q?moXecxOVUP++VfJUzkhur8sL2v6M7sRqubJae+p8VqCAwWw3yzspIIUealmk?=
 =?us-ascii?Q?SKJiSQyOw6TrxIXGoZ/Qy/qi/Jr6qFX2bLF0C6JzSt7omLE/AUTj0++B1Lhk?=
 =?us-ascii?Q?RcBsVKbPwBfK8z0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TsKPQYw+J/eL51Uaoy0rpRusG+ahEaOZZKrWiBRhDm6PlQxbvj0kpqr5vDWf?=
 =?us-ascii?Q?iiEqHfKt2hTtWnHNB5TUdG5fOaXaFeqFrNYD2hAesNqLt/21pvaLAM75EWK8?=
 =?us-ascii?Q?lWRKugZkNhMnuPG+tSHE/Tme42euWcY/IYDc2CcLxUCRTfwHkULaiAp0wizV?=
 =?us-ascii?Q?CmQBM1w5g63u50/f1j2fKMZfLaSrhNoApi+ioOmTyd+mys6fcN4aH22ACYwK?=
 =?us-ascii?Q?0euIy8V/vqOMB2F9untr1WnCKhyjCklrzuL8qlPW2plz9W8GPRPESQxahvKb?=
 =?us-ascii?Q?iiQXXmArVgOh+dJ6+6IFcEL14eaLEVEcKbiSquFYosj/F/QUu6GRLilHy6Ec?=
 =?us-ascii?Q?Wxv45qE+Tu4U5dxHP+A+jn5nLENUTKI9+zc6+ZP53+RYUXcT73Y+j+VGBPjN?=
 =?us-ascii?Q?hYP08EwnltcddBm6PE6u1/RNb+sPG6ufcQDxHy93Kq5vCIo0lypJmGr3dHS2?=
 =?us-ascii?Q?b8I3uvUFlXjk42GRRxrRqyoloQKMSScB9JNr1hxGxCeDgDZ52EU4IbfjnN4e?=
 =?us-ascii?Q?Ktj7XWPJOU9WtZsWnHDVTIEQmdSiYEff3uiaUeQ1CE7CYaGXDXBGxvMfqn3k?=
 =?us-ascii?Q?VhEkSRxlVT+qFHbqQ/nHxY5oq+Kd8MOUeSDY2aaGKMPkLaydaZ/A6eWyw2ZT?=
 =?us-ascii?Q?4Qh+hgIfFfjFqvpTGaLyILvSxekxmV4OEaMjPfhhzdPoWev3VnQQvMCl5Pjy?=
 =?us-ascii?Q?E/EcOdhd7dqM0SYfjw9jj0AfwxFEeHzsCzK8KYuEaQ/KPe46XEzdwgBMxRHU?=
 =?us-ascii?Q?UKNQEuhsJLTorebSj8cPVsg387M1zCorVWf1K0V3mv1d2Nr/r5rCoquR7WYX?=
 =?us-ascii?Q?f3uG8U6pi9Q/r9Ie0TlnRZhfBYR29zmgZya53dAy3B1VIGFviW/QCYFE7jDW?=
 =?us-ascii?Q?noTTddU5xFP++pqdQ8p7NuuVqcXZyI1We+yCamTZkXtEVaBOupZM23UyaqVR?=
 =?us-ascii?Q?xKpjY8/ryCv0PHckcIluif8mfGUpPnRRUi7nZYD8P9B9zNQWjzpjUoguGeTx?=
 =?us-ascii?Q?UKkqlXbfeGxK6aCjgypplU5DzaTXeBgSQcsADmfiymwcrSi4RAmM2wrkDlNo?=
 =?us-ascii?Q?agP1I6msEuplOg1QcxFRLkCk/gMDDWRBEpvup5F5l/EUelG2ERPlKaoNtzNS?=
 =?us-ascii?Q?O44+0ByzbcvfxnvbMLx0j9N8pPSCgsm0QCekGshOJjrwTeEwTh7nUjfqjhAw?=
 =?us-ascii?Q?WS5+jLADJVlxNOpsBiS4MOxpbwjf6e4/LNdCq2vtz169kIoLHQXXCvESwQD1?=
 =?us-ascii?Q?ryRuqKdPzumGSWfCjwEkNIWHsuZWqHilp1JnsvXaWIGXcjorswJd3OApQvq9?=
 =?us-ascii?Q?oipMrVOtGEZh4MuhsXG0I8WjtxipfdGWW4oq1HQJptRWHmM/ByA2x5xKInRa?=
 =?us-ascii?Q?RFjmAAUw7nKyfvFi+q/228YiCPPz7TksJnLxD+XUeF4QaHsGGtNS6NHqZ2EF?=
 =?us-ascii?Q?UbZsMO+KC3tBJ9phTxBlV5EIBuiQdE+EuPNSVm18F32HRhNyyUVFBQ92IEcn?=
 =?us-ascii?Q?naVDa+NQeAnoDH8tnH+BLEmBiRj22jSQrSKfgQswTEwpReJl/TFBDiwl/x9z?=
 =?us-ascii?Q?0uotaTu5nOi8Y9zQxVM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf61b6a-c981-414c-d3c5-08dd9ea9ef49
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 12:11:25.6916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q17vya0XUuU8B0TPFdSBucxQSQoEvvHkkaYk+fPa3lICD0aqmQnc9RsoO1EckxY3w6/DiA8fTrwn7dpdgS3gRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
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

Series is Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad


-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, May 29, 2025 2:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Gadre, Mangesh <Mangesh.=
Gadre@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Check pcie replays reporting support

Check if pcie replay count reporting is supported before creating sysfs att=
ribute.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c   | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   | 2 ++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 72e41781afb0..9eaee8dacea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -232,7 +232,7 @@ static int amdgpu_device_attr_sysfs_init(struct amdgpu_=
device *adev)  {
        int ret =3D 0;

-       if (!amdgpu_sriov_vf(adev))
+       if (amdgpu_nbio_is_replay_cnt_supported(adev))
                ret =3D sysfs_create_file(&adev->dev->kobj,
                                        &dev_attr_pcie_replay_count.attr);

@@ -241,7 +241,7 @@ static int amdgpu_device_attr_sysfs_init(struct amdgpu_=
device *adev)

 static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)  {
-       if (!amdgpu_sriov_vf(adev))
+       if (amdgpu_nbio_is_replay_cnt_supported(adev))
                sysfs_remove_file(&adev->dev->kobj,
                                  &dev_attr_pcie_replay_count.attr);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.c
index d085687a47ea..e56ba93a8df6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -53,6 +53,15 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_devi=
ce *adev)
        return 0;
 }

+bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev) {
+       if (amdgpu_sriov_vf(adev) || !adev->asic_funcs->get_pcie_replay_cou=
nt ||
+           (!adev->nbio.funcs || !adev->nbio.funcs->get_pcie_replay_count)=
)
+               return false;
+
+       return true;
+}
+
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_commo=
n_if *ras_block)  {
        int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.h
index 79c2f807b9fe..b528de6a01f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -119,4 +119,6 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)=
;  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_com=
mon_if *ras_block);
 u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev);

+bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev);
+
 #endif
--
2.25.1

