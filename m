Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A6FC47DDB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 12:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93BD10E7C7;
	Tue, 23 Jan 2024 12:09:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C505F10E7C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 12:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbriSr0D3HA6YO0zzGJyVoFNsINhhEhM86u6KoRfvMHJEIkbUo+YmJPsTVdPr2vCLSOM0pXD3wnci6CJIjmbiuyjEhhw7UAL2UZQHJnjsTWRqXcY0zXef1oQd8RLB0D+qLLybwVyYZpbE2rdy311r2dPBhhWD84Qt2JDOWAQMYtiUB4wSqeqRkKNiK39nbBsZdhRn7y3Tyzj01JrDqLOXrYAh7agMSd7lbnr+aDR1kuo947AgWyQaKh3+bBOcl1imfLw49MgJDbkh4OhQYsZlJYpqGW0o85yLD5LH7pB5nsvBZMvf5KjAAgTguEk+uaR2TaBmxRjS8T3qXZ4WjRkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06O04eh+3yExK2QMz2hcoFzWz2GJ/LAY29uz0xrCSlo=;
 b=atAoNQPhwReHsBUVoM5DCZUicqW/Utw/oXGxHoy3LoT/OW/2FIGSE+Z+pdMI8XG1CcW0ccK1s4+VaekYGuENlkdW7cYsimvoHsOooYzBmgNtiLIM9vMv311FC6UogHLhDuI2kKZb97nWSe03T6jgDw+NOdJzXlpJf5PAaHFjRfPaGeAWqqMz0IuKWqUtL/130Ckt1wqDw2nhzajpr4DgM8bryOIYbDu/kb53HIr27ead8ixrl0+5FyJ8IgPH+VHcT2gLFoWHErSpJOB5pjRmhnPMRS981N6tmcfzgZ6jfLHR3qOViYiwnBmssdf75toz72SajkhVWs9NE4QGMhlSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06O04eh+3yExK2QMz2hcoFzWz2GJ/LAY29uz0xrCSlo=;
 b=5XKaPXFhZt9vwWIxRiB3W1yFaFTNjgF1SqqwvAT7ScIW+iK3TFM4sgAR3Qv/P/+xEJQM5grOZPdRp/8eMJK2Vo354KLnDBY859LrtWMIvs7GuY4cyrks0M/B890FNVmXt+BAfwVsJR/7Xw7xuACOSWwz8PYKd22KAeukNMgG82I=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 12:08:55 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 12:08:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Thread-Topic: [PATCH v2 2/2] drm/amdgpu/pm: Use macro definitions in the smu
 IH process function
Thread-Index: AQHaTdSS1DWgIoW8PU+yEP8WcoZphLDnTDag
Date: Tue, 23 Jan 2024 12:08:55 +0000
Message-ID: <PH7PR12MB5997873C916E57FB0D72CFE282742@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240123081326.1066121-1-Jun.Ma2@amd.com>
 <20240123081326.1066121-2-Jun.Ma2@amd.com>
In-Reply-To: <20240123081326.1066121-2-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bc4d75cd-45a2-4abf-a335-a9859a66fe83;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-23T12:01:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL1PR12MB5176:EE_
x-ms-office365-filtering-correlation-id: ff54affc-c1fb-43fa-0f4c-08dc1c0c1279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTBbm9lfO+gJl9sXEMDDTDwXQ4AkLfxIGBB8SJ7X/zixBZvzgQ0dxlHaCjJ1E+7zsxiTVkLEKe6WpAI9zfPf9/qubY9oTwr7icHssJ9h9eLxGhjBgY/Av95pjA7Q1/5Cj8Gmh36Sufx29UgzjGiy1mnNkvDcfE5XF4f3lo0rIcN1/v2AOFxUiwEQ7JRF+O1W00XBA2O9YwFKEB+OnwyIbhrYHfL6mcoudQGnA/3sLVJi9Yer7CW1lA3fTzQSfh102AZEQNLqA9HpGyktZasXmgaBpJ1JQCBEHAIHahivV3OwbrfofgjPPlAVkhZbG/QZzfcgjbh1K9q+sRbh1gEsVjsvChhBC2FrmByjToxe7TZoYF5z/sQQvNgDmMEiiBKYZYlVaIgTP7kHUz/VVY50lnqMTkFdYA8XWLWC2JEJEAwIpHji3Smdk2zSB0j8vqYamP1nTmoEmqNYQP5Xih2j7OF3lnaFIqAmhfQTvguG3ER+W1YRwdOA+99iVbwMAsLpdtVmC1kxjkxWH+UWPXJyEt7ARLMpQY0Y4orr7n3gngg1j06RALd/KtNpj9TcxCgHxiStusJWqeaFjqdgleeAJh5luys69l2ZDBqpl1i+CiKkfwQg+hLa1kV4nmPV+czP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(5660300002)(86362001)(478600001)(33656002)(38100700002)(38070700009)(53546011)(83380400001)(6506007)(7696005)(41300700001)(9686003)(26005)(122000001)(71200400001)(316002)(64756008)(54906003)(66476007)(52536014)(66446008)(4326008)(8676002)(8936002)(66556008)(66946007)(76116006)(110136005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jnDoM3r3RNGs3lJ3iNLWexQnd0wB4sHNrEjxCXV1ErV2zn5zduDBmvLPli2F?=
 =?us-ascii?Q?3jp5was9lEjLf7H9xX6YaWBHKsE9OWVuQf2MHuhU7qpkQrFdX9YFntoI13SS?=
 =?us-ascii?Q?31fCy2B/LQJ69I/xdHYnFDzP/cIuKHV15CnEbu1UZMbNr2QhDTl5GJVYp/oI?=
 =?us-ascii?Q?TBctd2ewO1J6INgF0lhtVqGeB7GzGGmxlUqCgclpwpleqf53RrtKmiK/3WIB?=
 =?us-ascii?Q?EnkhFjO38u+aixqrNYHZR61P9MVn3B98PvrvBNSPjzBjA54Afrk/uPkUq0z4?=
 =?us-ascii?Q?+eAGnwVtnh7MLTvKNs+5pnKDvzvDpkZLQtzhEpvxve4WJtRdQKa03wTP8Flb?=
 =?us-ascii?Q?D3czQDQHpOuPxWQxPcM5vymKL5cINDYOKFd7B8h6FWWhQ++QzOmRtQubimPk?=
 =?us-ascii?Q?DeO0IRGyngYjrD9Z7NETkoo3O5ZemlyNCn4D8JFD+8/r4/e9u9rgEL2BZR7Q?=
 =?us-ascii?Q?af5F5CWPVc/LVALGUr2TvKkIKDqVo6yliS/88BHIP7N+ab/NvuKMKuazjoaY?=
 =?us-ascii?Q?mr9bS9aXnAt7gHg0z5duGLbxDupfkflifiZMYsepRxPIFkDwiGBnEKOW9xDz?=
 =?us-ascii?Q?AxpJpGy/BN0/sbsZmVi1sat6a3Q+GFg+gNSVZ/d+JOQZNISF20lhfdZneyGj?=
 =?us-ascii?Q?hpYBXrGJYIdOo2Gz1i+YkJzBFJDB9bleFnG3t500MGSr1tx84WFAwU4CwA0p?=
 =?us-ascii?Q?Z6p42otHpRBTAD5b1jbUqgFyLm2EuJgMTzfFveVDxVUuNUKuasapJI0Yxoac?=
 =?us-ascii?Q?o9MwFoepBlGbqHZ9bgeblaZioRzhqIGmGxa71qj/jcA8vb0gY2A333zdAJ9A?=
 =?us-ascii?Q?nxNu9RalO1uCFqxHB6gtfQAedqbX8GBKVJwqh2WnZKnNfW4ivVqZmmckPewl?=
 =?us-ascii?Q?vTVZy/Itc7iDQjlkXuiq47fQ35yqu95ZyUH51+50lOvoK5/UT1SMjWRVyrng?=
 =?us-ascii?Q?/T/UW+4D+wcQ7a3GUXg6HByP4nSoCSklD0qWW/WoLTUuhBYvdEZHVPUUFva5?=
 =?us-ascii?Q?c2yugGf1Kro6xXi9+MBdmwvg6WdyY+2KraoSpTnZGBB/2F3HLosfvCMjVJgH?=
 =?us-ascii?Q?syQCr1UU6F/sCHlXjUvmdl6cidf74k4cVhY43zqWyEDDnhZ39t7lwj4fHEj0?=
 =?us-ascii?Q?4oHE7yOrpG1Mrk/MizTi/sI8s7vVxgSz4EqqHke2Kjq8ZR3qVzuKPsMqUtvO?=
 =?us-ascii?Q?CwDZx5oMfFeXns00eJrSsUAWa5Q5rJwE6NxhZUvRkCC+UEVCTT7vzcA52uuV?=
 =?us-ascii?Q?5ilqjHBu/Y8bL5efFzxbQCJWEx892mBnSXg9/XTH8RgxYNu/OiO+n+XlvvNR?=
 =?us-ascii?Q?AnfyEFK6Xkb0kPlH4LIkhO/vBDumh9iQ+dfIt8IzxQ4ADdW9vaM9t/Trx+Hf?=
 =?us-ascii?Q?uz5OnL5Uz0GA3YRy8r+gJxXbS3OjoIej7Mf0ucaiDMi1yvQL/AKTi6JIsedJ?=
 =?us-ascii?Q?fjYgxYXCXzwD0DSP5lTB27cyFdtVcbQ/ZuJDFwmpLoQTbeNcRNCx9KcNueDY?=
 =?us-ascii?Q?ZZXDGimWf5/NlqwdYXh7xfTVPGbN/kmRwTyYFahx7DE94U4vNtoogpAfi3w4?=
 =?us-ascii?Q?t4xU8nXXNC/AnRiy1ms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff54affc-c1fb-43fa-0f4c-08dc1c0c1279
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 12:08:55.4369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1L+QbdCpAMgGew1VlVXUOnKQbe46qrVQXTLaXMFCPRP3YK3eTuIkbf0syjFzUfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

HI Jun,

I don't think it's necessary to delete these definitions in smu driver_if.h=
.
Adding a prefix can be used to distinguish definitions in the driver and ca=
n also make it easier for us to track problems. E.g: SMU_IH_INTERRUPT_ID_TO=
_DRIVER
And definitions in the smu_cmn.h file will cause definition conflicts in al=
l subsequent driver if files, we try to avoid modifying the driver_if file =
and have kept synchronization with pmfw.

Best Regards,
Kevin

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Tuesday, January 23, 2024 4:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYa=
ng.Wang@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH =
process function

Replace the hard-coded numbers with macro definition

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 11 -----------  .../p=
m/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h |  4 ----  .../pm/swsmu/inc/p=
mfw_if/smu13_driver_if_v13_0_7.h | 11 -----------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 14 +++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             | 10 ++++++++++
 7 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index b114d14fc053..91229b2dadb5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -1618,15 +1618,4 @@ typedef struct {
 #define TABLE_WIFIBAND                12
 #define TABLE_COUNT                   13

-//IH Interupt ID
-#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
-#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
-#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
-#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
-#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
-#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
-#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
-
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
index ced348d2e8bb..957b177414a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -209,10 +209,6 @@ typedef struct {
   float    minPsmVoltage[30];
 } AvfsDebugTableXcd_t;

-// Defines used for IH-based thermal interrupts to GFX driver - A/X only
-#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
-#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
-
 //thermal over-temp mask defines for IH interrupt to host
 #define THROTTLER_PROCHOT_BIT           0
 #define THROTTLER_PPT_BIT               1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0=
_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 8b1496f8ce58..33937c1d984f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -1608,15 +1608,4 @@ typedef struct {
 #define TABLE_WIFIBAND                12
 #define TABLE_COUNT                   13

-//IH Interupt ID
-#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
-#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
-#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
-#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
-#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
-#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
-#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
-
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index fbeb31bf9e48..ddf435cdddfa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_devi=
ce *adev,
                dev_emerg(adev->dev, "ERROR: System is going to shutdown du=
e to GPU HW CTF!\n");
                orderly_poweroff(true);
        } else if (client_id =3D=3D SOC15_IH_CLIENTID_MP1) {
-               if (src_id =3D=3D 0xfe) {
+               if (src_id =3D=3D IH_INTERRUPT_ID_TO_DRIVER) {
                        /* ACK SMUToHost interrupt */
                        data =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_C=
TRL);
                        data =3D REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL=
, INT_ACK, 1);
                        WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data=
);

                        switch (ctxid) {
-                       case 0x3:
+                       case IH_INTERRUPT_CONTEXT_ID_AC:
                                dev_dbg(adev->dev, "Switched to AC mode!\n"=
);
                                schedule_work(&smu->interrupt_work);
                                adev->pm.ac_power =3D true;
                                break;
-                       case 0x4:
+                       case IH_INTERRUPT_CONTEXT_ID_DC:
                                dev_dbg(adev->dev, "Switched to DC mode!\n"=
);
                                schedule_work(&smu->interrupt_work);
                                adev->pm.ac_power =3D false;
                                break;
-                       case 0x7:
+                       case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
                                /*
                                 * Increment the throttle interrupt counter
                                 */
@@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context=
 *smu)
                return ret;

        ret =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-                               0xfe,
+                               IH_INTERRUPT_ID_TO_DRIVER,
                                irq_src);
        if (ret)
                return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1db74c0b5257..9277c5dff5e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_devi=
ce *adev,
                dev_emerg(adev->dev, "ERROR: System is going to shutdown du=
e to GPU HW CTF!\n");
                orderly_poweroff(true);
        } else if (client_id =3D=3D SOC15_IH_CLIENTID_MP1) {
-               if (src_id =3D=3D 0xfe) {
+               if (src_id =3D=3D IH_INTERRUPT_ID_TO_DRIVER) {
                        /* ACK SMUToHost interrupt */
                        data =3D RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_=
CTRL);
                        data =3D REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL=
, INT_ACK, 1);
                        WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, dat=
a);

                        switch (ctxid) {
-                       case 0x3:
+                       case IH_INTERRUPT_CONTEXT_ID_AC:
                                dev_dbg(adev->dev, "Switched to AC mode!\n"=
);
                                smu_v13_0_ack_ac_dc_interrupt(smu);
                                adev->pm.ac_power =3D true;
                                break;
-                       case 0x4:
+                       case IH_INTERRUPT_CONTEXT_ID_DC:
                                dev_dbg(adev->dev, "Switched to DC mode!\n"=
);
                                smu_v13_0_ack_ac_dc_interrupt(smu);
                                adev->pm.ac_power =3D false;
                                break;
-                       case 0x7:
+                       case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
                                /*
                                 * Increment the throttle interrupt counter
                                 */
@@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device=
 *adev,
                                        schedule_work(&smu->throttling_logg=
ing_work);

                                break;
-                       case 0x8:
+                       case IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
                                high =3D smu->thermal_range.software_shutdo=
wn_temp +
                                        smu->thermal_range.software_shutdow=
n_temp_offset;
                                high =3D min_t(typeof(high),
@@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device=
 *adev,
                                data =3D data & (~THM_THERMAL_INT_CTRL__THE=
RM_TRIGGER_MASK_MASK);
                                WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTR=
L, data);
                                break;
-                       case 0x9:
+                       case IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
                                high =3D min_t(typeof(high),
                                             SMU_THERMAL_MAXIMUM_ALERT_TEMP=
,
                                             smu->thermal_range.software_sh=
utdown_temp);
@@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context=
 *smu)
                return ret;

        ret =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-                               0xfe,
+                               IH_INTERRUPT_ID_TO_DRIVER,
                                irq_src);
        if (ret)
                return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 4894f7ee737b..9a8b7fd6995d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *=
smu)
        // TODO: THM related

        ret =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-                               0xfe,
+                               IH_INTERRUPT_ID_TO_DRIVER,
                                irq_src);
        if (ret)
                return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index cc590e27d88a..9d5d1afe4137 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -30,6 +30,16 @@
 #define FDO_PWM_MODE_STATIC  1
 #define FDO_PWM_MODE_STATIC_RPM 5

+#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
+#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
+#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
+#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
+#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
+#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
+#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
+
 extern const int link_speed[];

 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
--
2.34.1

