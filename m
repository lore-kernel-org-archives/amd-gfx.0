Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42820C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 03:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C165D10E30E;
	Fri, 15 Dec 2023 03:46:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A00210E30E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 03:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghjSMhMxVE4ipcR7SkzmeQbs2uurXkaoXwphqJnnqfmtrihCvS5gQWS6RvMg5PB+sRSqd6+29//q9jtaNe0ED0Gdra+i3cHfajm/5KGlVxBy0AOX/B9+IflS7JQUjFQ4/fvKdLdJC/nWLtKgrUmWekQ3/UPtoa7z6luZjKMxlJjgt02VibaaxgFedrOdh91U10tIsAnlyj7CUUsAMVTg8K2Slho+Ru15+RgAuHmfamN6nGIvYTCU7zDus7bYJgoR9S9Y7LKst5oGgo5eEtpPTE/XbQifybzXzC8oocSoRR9p+2fabdJ+jUHHNXU6oHDfywI7CsPDwCMEs7bv+7GEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzIlF3q/dgCwl2Rr7R/Ph+UhpgWXh5gYg2NaU9UdxSc=;
 b=Pw/Yd25olGf6SV1ZLcaEh/w1Szh+nDi45H+e8giFt/VFE4c9C82rWAfRoeJugcMWlL7Onre1rSRKxKFAEAp1fB0mEKynwghx3mfyAYnSrGjHH2YBddNpNIz/DEQhPv9UXSX2I33Glxx1i7/IGG4qCUJrc7PKmPS7bwhVvXLN1g2hWHbzMjksE89mhmbgBDIZqqBU3HIRXswHWXSIq+5ptS2cUyNG8TcQWhY784/zUPgPjf5d7W3M1F6qhLcDONgqCKe3aXD3YPop5pdiTAwsCTgl7UNp3kE3ilVTQyYqSD2jIC2n07qItrUMUIgZ/hA+sy4HWRKk8iHAvg1gEKv4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzIlF3q/dgCwl2Rr7R/Ph+UhpgWXh5gYg2NaU9UdxSc=;
 b=py61t8XX0aNEfNulk9f1osSs1uViE0aoh3BEP3y1tw6SIgyTiocoaQKqq/VKlZ6d++l/in6730euxDRx/FpdRtIBAmxGxvMDp/oat+mtmXExLjFKqzJaktmVr5GuuKYwlWTIsRTPETJz04sjVmkOvTwcntMoAZr0k4Y56f0eRro=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.31; Fri, 15 Dec 2023 03:45:39 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::eaa4:8228:28ce:22a]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::eaa4:8228:28ce:22a%7]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 03:45:38 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/swsmu: remove duplicate definition of smu
 v14_0_0 driver if version
Thread-Topic: [PATCH v2] drm/amd/swsmu: remove duplicate definition of smu
 v14_0_0 driver if version
Thread-Index: AQHaLwj9Zxd5ezAaH0a4b4/50VEuXrCptCDg
Date: Fri, 15 Dec 2023 03:45:38 +0000
Message-ID: <DM4PR12MB516506E2B6FB2254B1968CF28E93A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231215034408.2217732-1-li.ma@amd.com>
In-Reply-To: <20231215034408.2217732-1-li.ma@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9f0bfe00-4e57-4033-8556-98a1bbbc4b88;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-15T03:45:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM3PR12MB9433:EE_
x-ms-office365-filtering-correlation-id: 13982d17-bbe8-4d86-3e5b-08dbfd204dcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mh0HC5Dia51d5E63WkLUFLqD6VPDZYhHT/GiRkVlc5LXImuMSHoNq2tL2MyZYcCeuvLnRok+WIcoLsbcKkZnx6yNv31FJx0dkRUY/4NjP+R5LX6Gsb3l0phZfn+/n+E9SiY/+MACHwgYEDAOT0BV+UQmDXtETiFh/VN1eaJXiJo72Ma/uA308iyxMYLC03IcGuERUxquopWn+PhCA09MHLRwARGayTV2llL8utYkn9sgEC5j8VansJEs3Iq+6z2EmFnaTKM3BPunjLcmyz/7//dWWMCXpjX26+8JhZmogF6R9nj9/+pSqgUZ1/exYQOrJvrDKVu4GZI9GkNZxRrN8liDGh18oQ/o5P4zY6eo6tmToVLpmR4cufIkrioOZjfHzsHJ+KAGBuZ3dW4RZJy1wTqOuAJYh/HhddNWMUhJPCyYtXoCHYPLbIEXKl/uyuNh30OVkK6wXaKiOVRoy0h0TxS70Uy9dk2Aj1RSnFl9X3QgJIWeE824O/AhdBka3227uJxwNgUXSR7Y1PP1UcurvFoYttnFaRTWUtQxu1Wcl37H24or9cWKqq+jmWA4jTabcvwHX0VLu9YlMLhG3sVNHmuvCY8Z+T9DUOC2/rOtME0Mueul5rRawsH2PTX0YfB0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(53546011)(9686003)(6506007)(7696005)(71200400001)(83380400001)(55016003)(26005)(478600001)(41300700001)(64756008)(66556008)(66946007)(76116006)(66446008)(66476007)(110136005)(8676002)(8936002)(54906003)(316002)(4326008)(38070700009)(86362001)(52536014)(2906002)(122000001)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?citBu+0oT3smmAMs6ph2mGmPhALP8L33GNdd3dYekCvNIESgPrwJRwhvx15X?=
 =?us-ascii?Q?5hGOTiiHVNAEtPXvkhPNSp6k/Nu6vdpeQO6H4C7sib/dDX+Tm2nDRDC7KB/t?=
 =?us-ascii?Q?GD0P4mf5zTCXFKfXgQ/ZwbPsVL0nPb26XHL1++JCew3k29e46VVkibrb448t?=
 =?us-ascii?Q?0yyanHCplXnV4zxggXaBbgLpcIztyYdXykRbj96iGTKLUIVCucEiYePrPJM5?=
 =?us-ascii?Q?7+lEkEc+8h7perR/rphDVGvv+gk+CDCWitRw/648FrT7ID3tuPCV2hPcmnTh?=
 =?us-ascii?Q?HrY8rDB1S8VI518lZa3YnY2MGOSzzv6ICmb7UHrX3rKTG0rObXuCcLZ0H8lq?=
 =?us-ascii?Q?jtZ52z9Xni8GprXok0gxSQLHlaqE1h1kfiQbSRFkzUQbr1DRRW3UKtiFAkwQ?=
 =?us-ascii?Q?GZKtCaxu+MV9WY/37wV7HK1aeFgFOTih9S67PDrsqCNB2oKUk7/Ssb2I9ob3?=
 =?us-ascii?Q?exI7vnwPJVI2CjZobYCezPhUxdDnLKYdUJdBFlSESU4JNDoPG2dy/XXYREry?=
 =?us-ascii?Q?aCHizmNgAEMCsvG7Syoj2Zem+Gv1h9hfyWlqb29DoFmhU1z607myYZJ8kbVN?=
 =?us-ascii?Q?bddz83eX7t8x3nJAMBnCRcM8/kRguUrTmQvzBLrky3q90OX8y6dnbsc0Un2K?=
 =?us-ascii?Q?f5lApxbmvL8LV7UczBT2VZEOyLk9ihtVJ+6+DTHObi0tQ6lLiyaAxtBSo4vy?=
 =?us-ascii?Q?sYvY8E23friBi88gljU4GsTb3Hzx5/bVCbGSw8TEaXUDW4hf78t1nOJuZMmz?=
 =?us-ascii?Q?BQzp8UETpIlo4PkKxU4PRBdb2SMXwV3mNahI+GHbWMDMFF0uCg2y20CyCThy?=
 =?us-ascii?Q?rNnyMFPDA0URSRI05w5IkoP05cAoYjpgrp3AaGI+kMjKPXv5PT7qyClzVwqC?=
 =?us-ascii?Q?TSZDHmThFr96SKh4dlALP/4QOD9PROw48Ccj0BUKIWzU3lCpbmEZJNdV7Ycr?=
 =?us-ascii?Q?QrW0qbZtCYt8dW+Fc22nBBmjtYL5BsNBjPVxdYlJAFyY5NtCqSaPpG3xl8TV?=
 =?us-ascii?Q?/706NGtGi/ZGJZT7KADTri7iZhOImclLdlcC2R9Hloy0o5oNW7R+7VBl4ixb?=
 =?us-ascii?Q?4EhfHlA5byjlBjaMjFLZQ3xk/9ZscJge7dk84I4da/AlV8E0OpvgN3Uhi0rc?=
 =?us-ascii?Q?Hutri4wqOjR2u0rhEZRWJVDkTzEyA4kWQ97puDC5SekDI4Z66MVkdg/oTb/1?=
 =?us-ascii?Q?Hg16EVvv347Lq0yxXDbAela+QVnIqPj4xhB8OE05vMAkO2796yNNTHrHzeJQ?=
 =?us-ascii?Q?nH+HFDabPfzhFFGtCpp6yakEM8Se75k5SRmTkbtvZm/xW2yUlelLvYC2HA5M?=
 =?us-ascii?Q?PRrCbTn8aL+kIgEUniPTMe1xb/o+mVQosbksAVWt18xWFaTIjaom1lIXonVI?=
 =?us-ascii?Q?m7JtP0114jaP33JKpV9QXtu53p/B5nN89UJ7PxWTO6Kqo1H546SpFVwg8275?=
 =?us-ascii?Q?jp0EWjFvQSYkeUOmgC3xOaSehLfu2RXRB6I+Y9h+fn1HJ4ycmmtubP9DJcC8?=
 =?us-ascii?Q?dQjhYPtYvULMq5IwomTJt/a3GNFZxqtqXurDY7TkKtXwP1547mPX8f9L1lQp?=
 =?us-ascii?Q?QlzCZqsh0Hu6jEWYUB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13982d17-bbe8-4d86-3e5b-08dbfd204dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 03:45:38.8433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hazx+YgRP7FkSE7AHnorK2hufUAOP6+cVULYoIbEn78Npsxn61aGodtZjZUVsc/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Friday, December 15, 2023 11:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.c=
om>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH v2] drm/amd/swsmu: remove duplicate definition of smu v14_0=
_0 driver if version

There is a repeated define of smu v14_0_0 driver if version, so delete one =
in driver if header.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h   | 5 -----
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h                 | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 8f42771e1f0a..5bb7a63c0602 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -24,11 +24,6 @@
 #ifndef SMU14_DRIVER_IF_V14_0_0_H
 #define SMU14_DRIVER_IF_V14_0_0_H

-// *** IMPORTANT ***
-// SMU TEAM: Always increment the interface version if -// any structure i=
s changed in this file -#define PMFW_DRIVER_IF_VERSION 7
-
 typedef struct {
   int32_t value;
   uint32_t numFractionalBits;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v14_0.h
index a5b569976f19..3f7463c1c1a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -26,8 +26,8 @@
 #include "amdgpu_smu.h"

 #define SMU14_DRIVER_IF_VERSION_INV 0xFFFFFFFF
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x7
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x1 -#define SMU14_DRIVER_IF_V=
ERSION_SMU_V14_0_0 0x6

 #define FEATURE_MASK(feature) (1ULL << feature)

--
2.25.1

