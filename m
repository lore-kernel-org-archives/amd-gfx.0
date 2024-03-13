Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76CCC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 09:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF01310F718;
	Wed, 13 Mar 2024 09:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0yIcH2MU";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C06C10F604
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 09:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDGE8vXv3rFzkC7+TuIkub9yaRKzi8Tg2rGv5V8G9DINSe9HsGYkyXHSjTE8EzcFpo+tl2j80qtUtvQENP0iD8n1ont348zLGljFetMWbAU6hF6zrMWC1HJNBc5tWI7lwIRkhZpbya77tS2jfDPpCxerugvcJi1hc4kbLYBEnUWviuPuuNm5lTcN2UjjSHarcK1aptISzdhztFWcuiX/1gSI16BuJKs8T11RvIPxsyxn6vQiwJAgUXcj2M/BrIrRDiPs8KfcG0C27+oQOOa9Cnc+D2YVpw4s5CEJxvf2bs9fMN6EZIPhX/yKgreBzVE13v28u0O30yAAFhW2WgMZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBiJU57TzOyT1Q4G3xiyrTZSRXNNRi9DmdcEJbe3Phk=;
 b=c97jjNF3LdEDQq7Q+m3bFpD1dVCI47JAUAckhv+D8F5DrVI8DiLYCLEuaxWc7BUbAlNNFHG5Wm/nRpCvl/t3tOpdFpCzrYerbrRIMmY9NdnoTGs9Yxsys+xaCa7Voe0E0tub1lr8kE8b6UN7HT5xUYcv6x+tagW3mxrnezz/4vHX6AX1oAEEWCLIsd/1H2xgx6gOLduhDT9Vc9F08VG1x++b/a3ZvXu/tpW9zWq0SX+w1vOMTrHVyJKgKOj37w/wgUGw0Dwo39IsQyjTA8Mf/u7E0rW7B7XhRye3smr4MsqBtMy1f1dRfsvmoJ9Y9yhowsWSKpADfoeOnc11B/l4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBiJU57TzOyT1Q4G3xiyrTZSRXNNRi9DmdcEJbe3Phk=;
 b=0yIcH2MUhZTwgDlX9Agc5+Lr0RMmSpjK7KrKcUO8CGFZEH0sEkkgjFUcYbW4jscNhifB0PM5GmBQpgwabxWqnnfUqP5fcXvK0Rvhk7S+bTPwsdvM5C07X3hfqCvZZXFOTQmybomCVojTNKX+jGAh+9VUj7k2mc12/hw7DxBMGfk=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 09:48:29 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::4730:f7bb:1576:31c5]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::4730:f7bb:1576:31c5%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 09:48:29 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Do a basic health check before reset
Thread-Topic: [PATCH] drm/amdgpu: Do a basic health check before reset
Thread-Index: AQHadSqtlbfWv+8uY0S4AtEyjyAtorE1bM5Q
Date: Wed, 13 Mar 2024 09:48:29 +0000
Message-ID: <DS7PR12MB607185D142662D7F46C992C38E2A2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240313094132.668370-1-lijo.lazar@amd.com>
In-Reply-To: <20240313094132.668370-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1fffeb72-a132-45a9-890e-59d734f0bce4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-13T09:48:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SJ0PR12MB7065:EE_
x-ms-office365-filtering-correlation-id: 90738243-be8f-407e-2de3-08dc4342bcea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0583kSa23dgnTDW/6M4mgx51OKd529UBb32QcRiFCt550ccaRKMy44xMtOoHSO1KgahZio9UPjBUPim06pXBBSPhG+PXIKAKw05RYdOygTpxeScoyhGssANSEf7JmHjCDaC8XSyOGzpIsfHQ5NTGjatWQex+lIOHDM3AdgFNQDakFnDX37o3lfDBvIixX1cvP8OxsUePsVP8HX98L8OeJk3+XrwhZXe381F876+K+jcSpGvMyUhsGS+5xi+ICl0gkINpdG86WdqYM4WUMsEZsg95bv5NDsQSiQQePeQi85cie5XOIg5Fn2B/BTcmHOHQz9diOB5+jJWlj2CR0aI7qUyydtipgqkWRVzJxqGFaMStteP4i+6tHSpAWeMg0KlMv7ARiQgajL0PbDaEG2h23yKSSJZlHaTbyRbCN1R2aUGJ1iNvam5cZBOdTqTfw6hmFGhPq6ttARieIKhRV9FutSY3QstFlQOMaq/YILQtBpqwmzVqaVfDYoZVkK4xC1XTcAaE25BOcZ6A0em19BsUopYsXvFxfAUMhCjpROLUxAGv+glTun7kCPYl28Ra6Uiak6EpvEzV6r8fOj85v1JQU98n19vzce5TTKQJJDWeeoAT7kyySo1U8G9Yzr2TErKmmulVO2ozUbvd2Zku52cKdTHFjq+4HdsEqAUqYnYLO5LeNn1RbhmzKZ7K2XrYESBRW5lh9GSQD9nL+3JppwrKHZ3japJIDNHKm4OFwgfwYtM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZYDiYBETSJuzXSCCOwybFCD796cOaI9uanQRRe0nh6Vs1SEXAvUbKcJZUmxN?=
 =?us-ascii?Q?ZBqTQEGT1/9WXwz0JNLZBhpwchHPdfZwGewOqpGmYxWt9ba+lORcxa7haKcZ?=
 =?us-ascii?Q?mJU0KoS4PMSN3Uz2SgEzFTIHx2R2UyCU8LBmh0YtFNmK+jOZ3d+/Cj85HTMU?=
 =?us-ascii?Q?41J/i8K0a7uONk0zQ+cLC56ggDfnon22kphGTCi+g/q4qxs+ZDVC7CD4SRZd?=
 =?us-ascii?Q?0k0So+2ur594OBjzBITBPtghva84M9pEY4r/C3qA3AMFov+0QfsqsIx84gax?=
 =?us-ascii?Q?ggc3FvN2C17H+OzqiBINK4f1jwsk3mNDBeARH+KfNxCogNbllPH6ExxAaqjY?=
 =?us-ascii?Q?9zp7S0VxLjzMLyts7H6K08EWM/PgcsoeyUUVBhqgTdl4p7yhbK7uasGpVT0o?=
 =?us-ascii?Q?HlmyRFPC+gPhIPVtp5xNhuXC+dNm0fqQYDbK94hMwAw6Q4Gs8g01OXPnEz8r?=
 =?us-ascii?Q?K1ZtiZHV72H6jQZWB4GgxFEgqvohwCPGVotaN2fr4jvTDiwmk46wITyRHXWY?=
 =?us-ascii?Q?llE8gUaUY+whuR+zumORBHXz/Zkhe7euD5MtzbZDgq6pN/8hX9bozO4R5ZC/?=
 =?us-ascii?Q?kNV+I24EwO/XLd0Lwv8mufUQx3RTKTJRTpj+J1hZgrw5pzCJQ4jLjZT3w5Sl?=
 =?us-ascii?Q?+NV5S6/OXxX0p9FZfRGoeNv6bit/RcSd5aVXc5U1dtLP0LV3q170MuTZOlX0?=
 =?us-ascii?Q?Tl0KMNnZCdmaUfWD7l6egPxolCD7UlVIZ6o93SV1bydtBRsI8MUWN4VaADk+?=
 =?us-ascii?Q?aK1Qi12sREarDxi+d/1D4lLMIlGp5WbpptnmKQg+Szjze7xouER/kiHdy7BP?=
 =?us-ascii?Q?wuWIZzcIWB5i3l59/B2jWeHSeNOd9XqN2XHaW5PpPk4KYG3w4aUqQN9Xxvz7?=
 =?us-ascii?Q?6z3FXCXEIIDQQ6BDFDclfEudYA0bL8nOORXnVRVNYi04HKrF0xt+ZS/CrvE8?=
 =?us-ascii?Q?no2V8bZlfQwVGDXEaBy0+PBKXs+/tcbrC1YXDvp4je0JokUFRG2KseKvWJ/6?=
 =?us-ascii?Q?CEiJlhSJt3fh6O+8HFgE5hkzvqgg2I3U8ZIQJGY9WpaOHTWWANRNPie08HrR?=
 =?us-ascii?Q?KDPvnL3hAW6k4pkedqJvkL4MJB8rvhnp9fnsqCFc4+hLyGqNqi2Sazhotrjj?=
 =?us-ascii?Q?LNmPtkvJKrgWyxATUbZbw/F9jnsaf6KMtaAyLtopVm7nNv+vkeONj1Gr5GYb?=
 =?us-ascii?Q?X10ZwpkRuPGbBZ+D892gK3Ex8prq3Ld8oPRJ2O626BxDjFvrRIeap8xLLLH1?=
 =?us-ascii?Q?5a0JmeB7l3DZ53nNLOO/DSz+ViWfQJqu6BUZap0b1krKvxyDO2drsRuk+3bS?=
 =?us-ascii?Q?TIDtElEo2QqYKp0mbxBVMTmb4OUs7SCA/sCikMEM1aMApPZmEqkR2nHqEnlL?=
 =?us-ascii?Q?B8+YjrOjMU9n2LpcU+pddgyhygfIOohTzNiFq0s4Ag7ivzPHc+NsWCmkDjp0?=
 =?us-ascii?Q?t9xDQvZnhSsPXZlTRTzhfY2n/zXigZugQhASTpJn4jg7rSkjgHzjdzK5eKgL?=
 =?us-ascii?Q?GtwnVV8ekFPXt1kiJ5l2Jh5XhJN6cMjcS6A3e4c5Qhw97f9nS2o2CWHJnVUk?=
 =?us-ascii?Q?9jnQuZch75cWBV+Dpyg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90738243-be8f-407e-2de3-08dc4342bcea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 09:48:29.5983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bcWsZiVyiTALQvTNE+FiN0ZFnfXgEpoeiwJS4EnSY42BpqyDxgRj4XeDkCJfn8biR5miWi/Nj0ZaUCsWWUuyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
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

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, March 13, 2024 3:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Do a basic health check before reset

Check if the device is present in the bus before trying to recover. It coul=
d be that device itself is lost from the bus in some hang situations.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 1e9454e6e4cb..b37113b79483 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5536,6 +5536,23 @@ static inline void amdgpu_device_stop_pending_resets=
(struct amdgpu_device *adev)

 }

+static int amdgpu_device_health_check(struct list_head
+*device_list_handle) {
+       struct amdgpu_device *tmp_adev;
+       int ret =3D 0;
+       u32 status;
+
+       list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+               pci_read_config_dword(tmp_adev->pdev, PCI_COMMAND, &status)=
;
+               if (PCI_POSSIBLE_ERROR(status)) {
+                       dev_err(tmp_adev->dev, "device lost from bus!");
+                       ret =3D -ENODEV;
+               }
+       }
+
+       return ret;
+}
+
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
@@ -5607,6 +5624,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
                device_list_handle =3D &device_list;
        }

+       if (!amdgpu_sriov_vf(adev)) {
+               r =3D amdgpu_device_health_check(device_list_handle);
+               if (r)
+                       goto end_reset;
+       }
+
        /* We need to lock reset domain only once both for XGMI and single =
device */
        tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_dev=
ice,
                                    reset_list);
@@ -5772,6 +5795,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                                            reset_list);
        amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);

+end_reset:
        if (hive) {
                mutex_unlock(&hive->hive_lock);
                amdgpu_put_xgmi_hive(hive);
--
2.25.1

