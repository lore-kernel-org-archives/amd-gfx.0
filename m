Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA59BCA5FA5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 02:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0769410F153;
	Wed, 30 Sep 2026 02:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XVV3PfUR";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B18710F153
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 02:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSm9yonksXlA0oAaeTrTOZZgf+cnMbrewLJTe78wsjI/1V5ZZxEeT9wDF19RT6TgK+G2fQG4ldaJugQyGIJ0dDx8VvNCRLgSbjqkvfSMjQoaXMAvGmHoy37h65cWaLdxHj8jCr45dFNlpIgRicagHXGrZ4DP4WQAnYHscvIzdCWQEgwGS/ueb5LbqvSqw2sjDu9Fvoma0z96Lht5Z9Kbn8beSUHpraJiNFOO/H+nqRHrpUTxJWmRFF5/wMXXho6a2ZoXz0oqv2dRjpCNwTsY0+u7iuSdcJBwfptywtLTnsnSqNhpqXL9XkfwU+baM0oENp8joaaNSrrfGzlzVl9KEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQgtpBafDl6V6ZDXZXpm3LGu5AK87UT8tgOk3Ru5fcs=;
 b=OZs8NXuodtyHgKdVKzMuT+K7+FuGuoxWgPYSmoEGojL7I42LEmoRJAOaUdJhwrPqczBkmEdYxki2gAjYhuaxOM2rLxOFj2FdfK+2vJljvABEjWDzidcOZfKoCXmCh03KsALEh4wBGaAS5dlFWMgYYGARuhyW4SLb7edMEFqHLK5BShlLnn6aXLMqS+jsCwVzmR4dXlOBqBwaDhyB5HrCi1BTnStTXnChYvD1EaLygX63fGktZ5ArGJPbewkM/J/Nm0qkTDWFmp8psTEeeDc+JSgEN3VPYi2eMVuN+Xj5k4npclQp4W0YKZXkKhd3SMsZq4ye1SRnvQrhLpezi3eZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQgtpBafDl6V6ZDXZXpm3LGu5AK87UT8tgOk3Ru5fcs=;
 b=XVV3PfURMvGAfs+3WMJhnnmCJrXM4beMd8HQHzNZ8Y2Mx8k7E8DJSSuNi1ZQuQ/Yg2W76nJ0iprY5ObZl1Nkyfo0vX9Dog4g/yWNZtDHROCbUDdI07DL8dWtGVrEbvhOURHUxfMUeJYU+OrYamnV7L+N6RdyPNPKOETpBzJVLxc=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 02:55:12 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 02:55:12 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
Thread-Topic: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset
 on gfx12
Thread-Index: AQHdT7nmMq5HTaPVj0+C645FmSOmiLblQ/QAgAACu2CAAKMngIAAfzww
Date: Wed, 30 Sep 2026 02:55:12 +0000
Message-ID: <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
 <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-29T18:59:25.3240000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DS7PR12MB5789:EE_
x-ms-office365-filtering-correlation-id: 8871bb8d-aa9b-49d0-7ce0-08df1e9e3f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|4143699003|8096899003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Dxkv0GrMD775+9YdTYyYIZYFAugNedOYmhsYi8qzKqN9o82kotTvRsi5egrgEvxkVZ+QGzAn0BzqLgCnyjSJiyw2BdY7eyFM345Sz21JFB2Qm9E6o2cnyZZCejiGwNagEgMn/UuTWMPuFkMKQWslttpdh8WZYkZbcPj0atUNXzKA3/esoCDaarSyOB0Uitzx+V9fwo/4cnzJJHak77QzcurCa6jh8M91ZQBmwYF829qKGGvg/MVo9zH3HfZPFIhVrPawQSHUw3eb8ntf+1RnBv+DngUmr0UZaHmmXi9n8FI4eShe0nVxcxvxg0VqY7waJQpQTxov+xCgbWrlhONasaUeiTeaZJeG8uFJSJfkGu7/7e6MkyGKYE+WChA6FreIh+7ITjJutZTBMn0jP0bRzZzoX9I5fZaJZmtRLi0OEos8vtxlv0FK1Z4HxH6AlFUMpzWzxx1JWFtugGlwoiZ1W4b1nfRbNM9esA7XTB8D/XsFyu1ddY0h3sI2f0PdyHExrClsMP8phfRXW4Hxs8x1lkfYOfCOb63qpc4LOkbaKxWfxzoANR1bsoFjGiA/oMFF5nv8FStxpV47iS0HFIQH2PqNgzrJbb6dFic7p9Ta4HKLmIX4NU7rKHryRvisnHRN3Jcvn67VObSkMeCXJKDnWnJ/Ou45LKV7f+D9pdvgRcHOiKaDO0dZD6mJss5Kq1el1AJgE21RwJiNyl5shC3/KUXCJi/P1AZ/2hhlh8KxcAo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(8096899003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6BLOz97we+y+2eMSNOu00URQKeSKB4FvzrN7UrKAPgw9k1JMhDbi2R+zq1kH?=
 =?us-ascii?Q?wiHi788D97nE5BHmdPyHjq+kazWG7h65KhK1jD/VtyxlUpFgY2WfgwuKJh9v?=
 =?us-ascii?Q?fLBsiQhLP9heRnQCs++Wvoi/xNV3uDq6hniCTHnWj7eGhaBZ52ps6a42ai7M?=
 =?us-ascii?Q?8n6LyUlZMd6w4+BMNIIutBoWxoRat8qbYxheblrjw+WjyHUh6uUoOSGHK0qf?=
 =?us-ascii?Q?GVRRz+tFmBBaRoFPvdNoQppg6a1yskArsypV31uAzFlmIR9IlyYLtRG6G6W9?=
 =?us-ascii?Q?TGX9/4U3gtKdkHRMtaIEa1nZ9qFRlcyCp4elbkYetojxc2k1unOK55B7Qwl9?=
 =?us-ascii?Q?h8vaY2sm/rv4nv80934y56kPjxNhx0lrU8T9Hpu+ueFuj2EALTaDRPhdyBtC?=
 =?us-ascii?Q?t6xEzWL1Z+o4T51PhFo+QJ+bHLN2yWY4gB0cZggplkc+8hcHwJynnzHCb0e5?=
 =?us-ascii?Q?SnbweDDBcEnfWZeasrxbuHc3Ucf+w6oZUkIVdh2SIP4AjvJKDRjyq1g5Lr3G?=
 =?us-ascii?Q?JDYowvIey0MMrBs/g8Rf1d/suczDCYe1Yqi9cH+erqVYK3xXpAFzZmtSKTI4?=
 =?us-ascii?Q?YOh72cPQA76M04sLz0V/Q8tgaEX9iGywmlUwxtgWWLnzTQgE5DV/oTwWWCnl?=
 =?us-ascii?Q?jLvNcym7uu+yu4iHbaW+sUTKcTWEsQZEScbUdGTfnY6HxF0hIVWRa1ksGQKV?=
 =?us-ascii?Q?NI24okCCO1pCbSdVKtFmfOrnApqSsqqGKlNPgj+5mI4UcgnL99s9uiQoR2lS?=
 =?us-ascii?Q?jGBxjDwCeIvoBJHZiF460SFyjtOARiazZXt7o16o9k7ZhuBT72qlqJFd90bQ?=
 =?us-ascii?Q?M/VNqeo7V1aYHNmrBwXKb1Xax3D+dh3clJiKh+zOH2t/QjvdSmojVKZROdBN?=
 =?us-ascii?Q?KpbdAoxSy/lJFGZhCGMglsCifyTUMKVYVraQkDq0bV4xdAVLIOpFYZrjSc7M?=
 =?us-ascii?Q?genyLgVz7M84CRWRvV3olyq/HeJpRuU8BpRoF85b6ItEOo7fy9lDSsZ8qYiH?=
 =?us-ascii?Q?VRh4DO+QL/RuKAYzx/M4h27o5Bt1jo88yESVbHwTJiLdaPVupxi4DkmHXIZI?=
 =?us-ascii?Q?AYwEH0OEClcvysK91XatyXKIOAwYBDVtTLRU5S0io8yr0OKQcEKfZk/67VCA?=
 =?us-ascii?Q?gSB1KYkzwmU7L+PW97o7/ZQ2MSZGsS4cjmhVSOE1JeHhMuaLqRHaY+e5BgaN?=
 =?us-ascii?Q?lVtVJf1+PB53htgpbvq8lQlRGz11QmbdoZJha8QDed6MFkCsgHJFocb1lSzV?=
 =?us-ascii?Q?Q9Z+uDQkz1HjmPD8ZsxOpboQyB6/lB04bwUvczJqARGKv9XaIMRpn3UWMjeG?=
 =?us-ascii?Q?1znsTPAQqaztYh5boWSMm5zbQIMJpjK6niBwAUMSH3djc5F4BC9D1WDkrTTE?=
 =?us-ascii?Q?KLV7gyluLK72dIVfGRKJuRJ3xYoPn9HtfzFtoR7K/bahIWEiXwBeLvWXvpNH?=
 =?us-ascii?Q?wLRkE/RLZna64x0mQ4vu/GzkBMw0RXrOxko2dbaudwQmF9VhqbBTvcHGQ1Ee?=
 =?us-ascii?Q?lS+BJjU8v1u9wR4VhZWLI1NyqO8/41ttsRp4MUOMKtdb1FVAkERMmmjCWHf4?=
 =?us-ascii?Q?RVhKNaSEGfdQuChzTPDnKvHPnEYRciLo/9/OqZE5lD+WqyLPlju7xnf7bFnu?=
 =?us-ascii?Q?vtJG8sCpq8OBwvzQGMbGpXWB5ukvcjXZcSbAr2JQYBzV+oxeRBYGnftgu3Nu?=
 =?us-ascii?Q?BCKA1eaYyOqPoz7ET8eEPa+XabYsdaH0qmEoIhthbQT8iktS?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63694BE5CF3FB172F837CCBFC18B2CY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8871bb8d-aa9b-49d0-7ce0-08df1e9e3f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 02:55:12.4284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+9g/Cr80H7PxuM/AwpNbT6hWc1vrcNEJAySayDZeYeFZnBlja1fJOcIl1LvDARK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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

--_000_CY5PR12MB63694BE5CF3FB172F837CCBFC18B2CY5PR12MB6369namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Public

Hi Alex,

I think it is reasonable to apply the patch to all ASICs. I will sync with =
the hardware team about this change; so far we have only tested it on Navi3=
1.

How about adding a common helper and calling it from ASIC-specific code, st=
arting with Navi31? For example:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b690a07e31ab..075de681ab86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4931,6 +4931,28 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_=
device *adev)
                return false;
}

+void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
+                                   unsigned int delay_ms)
+{
+       u16 saved_cmd, cmd;
+
+       pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
+       cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
+       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
+
+       msleep(delay_ms);
+
+       pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
+}
+
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index b250c5e41e45..356e09b7eef9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)

        ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
        if (!ret)
-               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+               amdgpu_device_mode1_reset_wait(smu->adev,
+                                              SMU13_MODE1_RESET_WAIT_TIME_=
IN_MS);

        return ret;
}

Best Regards,
Yifan

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, September 30, 2026 2:59 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Koenig, Christian <Christian.Koeni=
g@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Yuan, Perry <Perry.Yuan@amd.com>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

Public

I think this should be asic agnostic.  Any asic doing mode1 reset should do=
 this?

Alex

________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>
Sent: Tuesday, September 29, 2026 5:36 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Yuan, Perry <Perry.Yuan@amd.com<mailto:Perry.Yuan@amd.com>>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

Public

Hi Christian,

The no_hw_access flag was first set in commit 0de604d0357d0d22cbf03af1077d1=
74b641707b6. This was intended to fix the Mode 1 reset hang, but it proved =
insufficient.
I think the flag was set in the SMU code so that it would apply only to SMU=
13/14 ASICs, without affecting the Mode 1 reset process on other ASICs.
I'm not sure whether we can drop the no_hw_access flag after disabling PCI_=
COMMAND_MEMORY. The PCI hang occurs intermittently, so we may need another =
round of stress testing to confirm that the flag is no longer needed. Shoul=
d we remove no_hw_access in a separate patch?

Best Regards,
Yifan

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@a=
md.com>>
Sent: Tuesday, September 29, 2026 5:06 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com<mailto:Yifan1.Zhang@amd.com>>; amd-g=
fx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Yuan, Perry <Perry.Yuan@amd.com<mailto:Perry.Yuan@amd.com>>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

On 9/29/26 04:25, Yifan Zhang wrote:
> block GPU PCI bar access during mode1 reset on gfx12, to resolve the
> random mode1 reset hang issue.

Interesting idea, that is much simpler than trying to mess with CPU page ta=
bles in the GPU reset path.

The only downside I can see is that we now drop VRAM and doorbell writes, b=
ut I think that won't matter since VRAM is lost by a mode1 reset anyway.

MMIO writes are dropped as well which means that we can also drop the no_hw=
_access flag.

And BTW the SMU code should absolutely *NOT* touch that no_hw_access flag i=
n any way. Who added that there?

Regards,
Christian.

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com<mailto:yifan1.zhang@amd.=
com>>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
> ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 072d9c4e202d..25b9085ead71 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct
> smu_context *smu,
>
>  static int smu_v14_0_2_mode1_reset(struct smu_context *smu)  {
> +     struct amdgpu_device *adev =3D smu->adev;
> +     u16 saved_cmd, cmd;
>       int ret =3D 0;
>
>       ret =3D smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
> -     if (!ret) {
> -             if (amdgpu_emu_mode =3D=3D 1) {
> -                     msleep(50000);
> -             } else {
> -                     /* disable mmio access while doing mode 1 reset*/
> -                     smu->adev->no_hw_access =3D true;
> -                     /* ensure no_hw_access is globally visible before a=
ny MMIO */
> -                     smp_mb();
> -                     msleep(1000);
> -             }
> +     if (ret)
> +             return ret;
> +
> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
> +     cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> +
> +     if (amdgpu_emu_mode =3D=3D 1) {
> +             msleep(50000);
> +     } else {
> +             /* disable mmio access while doing mode 1 reset*/
> +             smu->adev->no_hw_access =3D true;
> +             /* ensure no_hw_access is globally visible before any MMIO =
*/
> +             smp_mb();
> +             msleep(1000);
>       }
>
> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
> +
>       return ret;
>  }
>

--_000_CY5PR12MB63694BE5CF3FB172F837CCBFC18B2CY5PR12MB6369namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
Public<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think it is reasonable to apply the patch to all A=
SICs. I will sync with the hardware team about this change; so far we have =
only tested it on Navi31.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">How about adding a common helper and calling it from=
 ASIC-specific code, starting with Navi31? For example:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devic=
e.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoNormal">index b690a07e31ab..075de681ab86 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -4931,6 +4931,28 @@ bool amdgpu_device_should_rec=
over_gpu(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+void amdgpu_device_mode1_reset_wait(struct amdgpu_d=
evice *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; unsigned int delay_ms)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 saved_cmd,=
 cmd;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_read_confi=
g_word(adev-&gt;pdev, PCI_COMMAND, &amp;saved_cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D saved_=
cmd &amp; ~PCI_COMMAND_MEMORY;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_conf=
ig_word(adev-&gt;pdev, PCI_COMMAND, cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(delay_m=
s);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_write_conf=
ig_word(adev-&gt;pdev, PCI_COMMAND, saved_cmd);<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_=
v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index b250c5e41e45..356e09b7eef9 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(stru=
ct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D s=
mu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)=
<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_mode1_reset_wait(smu-&gt;ad=
ev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU13=
_MODE1_RESET_WAIT_TIME_IN_MS);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best Regards,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Yifan<o:p></o:p></s=
pan></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Wednesday, September 30, 2026 2:59 AM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Yuan, Perry &lt;Perry.Yuan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode=
1 reset on gfx12<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">Public<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:black">I think this should be a=
sic agnostic.&nbsp; Any asic doing mode1 reset should do this?<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">Alex<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Zhang,=
 Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifan1.Zhang@amd.com</a>=
&gt;<br>
<b>Sent:</b> Tuesday, September 29, 2026 5:36 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Yuan, Perry &lt;<a href=3D"mailto:Pe=
rry.Yuan@amd.com">Perry.Yuan@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode=
1 reset on gfx12</span>
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">Public<br>
<br>
Hi Christian,<br>
<br>
The no_hw_access flag was first set in commit 0de604d0357d0d22cbf03af1077d1=
74b641707b6. This was intended to fix the Mode 1 reset hang, but it proved =
insufficient.<br>
I think the flag was set in the SMU code so that it would apply only to SMU=
13/14 ASICs, without affecting the Mode 1 reset process on other ASICs.<br>
I&#8217;m not sure whether we can drop the no_hw_access flag after disablin=
g PCI_COMMAND_MEMORY. The PCI hang occurs intermittently, so we may need an=
other round of stress testing to confirm that the flag is no longer needed.=
 Should we remove no_hw_access in a separate
 patch?<br>
<br>
Best Regards,<br>
Yifan<br>
<br>
-----Original Message-----<br>
From: Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">Chr=
istian.Koenig@amd.com</a>&gt;<br>
Sent: Tuesday, September 29, 2026 5:06 PM<br>
To: Zhang, Yifan &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">Yifan1.Zhang@a=
md.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;; Yuan, Perry &lt;<a href=3D"mailto:Perry.Yua=
n@amd.com">Perry.Yuan@amd.com</a>&gt;<br>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12<br>
<br>
On 9/29/26 04:25, Yifan Zhang wrote:<br>
&gt; block GPU PCI bar access during mode1 reset on gfx12, to resolve the<b=
r>
&gt; random mode1 reset hang issue.<br>
<br>
Interesting idea, that is much simpler than trying to mess with CPU page ta=
bles in the GPU reset path.<br>
<br>
The only downside I can see is that we now drop VRAM and doorbell writes, b=
ut I think that won't matter since VRAM is lost by a mode1 reset anyway.<br=
>
<br>
MMIO writes are dropped as well which means that we can also drop the no_hw=
_access flag.<br>
<br>
And BTW the SMU code should absolutely *NOT* touch that no_hw_access flag i=
n any way. Who added that there?<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Yifan Zhang &lt;<a href=3D"mailto:yifan1.zhang@amd.com"=
>yifan1.zhang@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c&nbsp; | 29<br>
&gt; ++++++++++++-------<br>
&gt;&nbsp; 1 file changed, 19 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; index 072d9c4e202d..25b9085ead71 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; @@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct<br=
>
&gt; smu_context *smu,<br>
&gt;<br>
&gt;&nbsp; static int smu_v14_0_2_mode1_reset(struct smu_context *smu)&nbsp=
; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u16 saved_cmd, cmd;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_debug_smc_msg=
(smu, DEBUGSMC_MSG_Mode1Reset);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_emu_mode =3D=3D 1) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(50000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable mmio access =
while doing mode 1 reset*/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;adev-&gt;no_hw_=
access =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ensure no_hw_access =
is globally visible before any MMIO */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smp_mb();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_read_config_word(adev-&gt;pdev, PCI_COMM=
AND, &amp;saved_cmd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D saved_cmd &amp; ~PCI_COMMAND_MEMORY;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-&gt;pdev, PCI_COM=
MAND, cmd);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D 1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; msleep(50000);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* disable mmio access while doing mode 1 reset*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu-&gt;adev-&gt;no_hw_access =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* ensure no_hw_access is globally visible before any MMIO */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smp_mb();<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; msleep(1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-&gt;pdev, PCI_COM=
MAND, saved_cmd);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif"><o=
:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_CY5PR12MB63694BE5CF3FB172F837CCBFC18B2CY5PR12MB6369namp_--
