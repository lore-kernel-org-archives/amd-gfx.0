Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D80C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 05:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FEDA10E32E;
	Fri, 15 Dec 2023 05:04:31 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744DB10E9D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 05:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPv+j/+BaXrQYoFMoFk8vmAh7A6ahCURKaYXMVbXzTauu7+kDTHfl6sg2l8QwVlvNVIhfzTMnX+3N41hb2LwjviFVTW3djlz6Ny+S5UjG80n7AyW5GSoTIDJu/kBN/AwR4vYwDTZIG395LNyq1TH95kjmUUo044m6MZHWDrnTg86Zldg5uwvZjFlMwXvlJH40S5TI1zeaRctOO0xrQYyOuSzg3ol55oJNLQvrQYknklDG4n6a4CkzAjQjHnAQb+YF0V4tRXPtFINeyss/Y8ybL1P2Mvu+Yy+zk1YfreoHbO7xNTUGDohWSRvlhbc32hwfMOnaLQw6eaWdYh9HDDBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhabjLGCR/Zs5zghrRSfsRRzQ5F0YMeSaO9SLd/ZySg=;
 b=AWT27UQNCpIkyZUCCmJzOvdo+EdRPHyoHWcd6/Fpk+7dpCtVLyEAfzIy/on6I4fZbDby7cmPx7pXRD8tB9UeOOad4WvQ9E+6IEObGyeG367iXTPaIiJc+zu1JG+9bW1O1RX7r47rSaSMMjsNXJBDwF97dH0QH76NRKn/lh1WVMi8FNdleBqXSlbsCzqYLH1aOyA8qIRawg8RML9sXwCK7DrOgnSj1HUvqZNznscsYLaV1TeEQST8Bm+/o1t/0Zg+nSsIxZUJri6dL3I89gqGB0uzS9ke4LVVebcNe3SGzydnx/bXb66q+JTeJmJO9EbJciGDKzSVHGhPkSfWvY0FDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhabjLGCR/Zs5zghrRSfsRRzQ5F0YMeSaO9SLd/ZySg=;
 b=MK6RYbfEjHe65/BJsUspQhWSORFN6eZ/8ygT+kFM0TDw5HL2yZ3HVMMmPI4K5cCLWydq7yYb8ICSNjHuXND+czRhFxMyedlCBfKqybqgSG+0DDR8VRafvKqrptm5vaFN7ThPDxgyOyJ1FbSTNkmuD4iUdJyiNjWADwKTCMztYGQ=
Received: from IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 05:04:25 +0000
Received: from IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::79cf:ba33:6895:33fa]) by IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::79cf:ba33:6895:33fa%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 05:04:24 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/swsmu: remove duplicate definition of smu
 v14_0_0 driver if version
Thread-Topic: [PATCH v2] drm/amd/swsmu: remove duplicate definition of smu
 v14_0_0 driver if version
Thread-Index: AQHaLwj9bAZzqsdFnECVjKhmMUvQS7Cpyf4g
Date: Fri, 15 Dec 2023 05:04:24 +0000
Message-ID: <IA1PR12MB6356A6885ACEC8D61110189FC193A@IA1PR12MB6356.namprd12.prod.outlook.com>
References: <20231215034408.2217732-1-li.ma@amd.com>
In-Reply-To: <20231215034408.2217732-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cc8023be-5c2e-45e0-8503-7a6f25cfe268;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-15T05:03:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6356:EE_|CY8PR12MB7217:EE_
x-ms-office365-filtering-correlation-id: 64794cc5-34b7-4dd5-b2e8-08dbfd2b4e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QX4cOb6s8W6FyR4/KTN9VZzUAPz+bNdtHy6jF91jjkb/xLpFU+JiF8tMsM5H6e62T2wVA42SX2qL4KZoRUIvNu30y570MM8q0K6fvB2KQ4gJsw1clothjVT24FrJKZTBoHvGKqW71T807XQz4tc0h4EyOncc0g90H0o7DT3QOTAMpKIjXA22UawDJFP75UX7Xp59AM2PkmrXQ8xe+w+37T1FgzLVjcafX20F8rLRm1ms8FRskO2H5saUnO8eAhEbxEuj8GE8r7XHhUtGxU3MVcoH/bbO7qINLQ92vi9R2kRH5ZuRa3QbSR05kAfCOJVrQKraCiuqHQewUopcFLXrrCwlCkBZzAPA6RFTJaTj5XH2wln2i2cw5SQySkFguLEU06BUWVZTTgH7GVYwVDAMwjYfdmyCeGvjaIStKuApkD7zedV7NC8Ppt8sVd97FKS+d4KMJZF1nBudfNj2PirmMhecknd42atXg2AttOMMafHyFsVwxgVgQGtXKRd+G0Y8SGYilzOBrP4XtPbJihup6+ZiSqKAseo8KAf88gzueVxB9vRjrZ2V6CydOm4i5PX5VvfyCeURFq7oQlXHqQCgXDs7m05cvwLRNLQp0AOxvqdP7g7GndAzE7vsRonNNE3B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(33656002)(86362001)(8936002)(8676002)(4326008)(52536014)(316002)(5660300002)(38070700009)(41300700001)(478600001)(9686003)(26005)(71200400001)(55016003)(83380400001)(7696005)(53546011)(6506007)(110136005)(38100700002)(122000001)(66476007)(54906003)(64756008)(66446008)(66556008)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vJXkji+PlcuibWwri11B+HU1KgnrBzLrWOymPFa70uCMUx/tI9G7zPJ+puwt?=
 =?us-ascii?Q?Jnw+upnqdgpNDTtOJBOv+At6BWYKeUOAwpyYFRi5TLbVghaoZ2UZ3xTtj704?=
 =?us-ascii?Q?ePP3lry+3B7DTeN1cYTEcGJ5/kI5RGMWu2W2SzUK2ot9wXgw+LVHsCtZMl5B?=
 =?us-ascii?Q?k83zIjmu6NUVOKsLOjCFZB/Vba7dTvOZ/pwVfc+N1vJ67j4znQTLeFmLPvmf?=
 =?us-ascii?Q?XywKV0cLN6pYqAOSVwG7aGM+upYqG6guyi1BqTAHlqaImF1tvivV7T+VZnEe?=
 =?us-ascii?Q?0EBLFel+FhtZoyS/oe4NWCrYu+lOaDr+WPUJ9cnc5x2pnj9XGA8MYscuKMEm?=
 =?us-ascii?Q?tp/ajxY1RN2q/l4OzDXgKrwh8i5IOQq4rpiNWH0FQ60ihOgE5sL8s6U5Av0b?=
 =?us-ascii?Q?SgoGCyAVlO91DfHyvy3awy0Bqpu45uLiz2n7sKKrIa5S+v/e4r1HbJYlj2XV?=
 =?us-ascii?Q?9ssmNw6bevoUQshM8n+IRUykHnv7t1DHUqErvwXaOGHNZ3iGMa3DVswQUIaO?=
 =?us-ascii?Q?ZkWZlBzuC7P9rczB3pGXzfap9b9QxtzICItpjSC3z5KlGodm2+qJ3W39cTx+?=
 =?us-ascii?Q?qwYk6XPxGhBfsz552PyhowDtO7QW4KUEMXu23G2wiKtiTkmi31t3RKkp9IWA?=
 =?us-ascii?Q?LDYOBrIc35GpdkKmYefrHTofspvduwpfw+oqGYF//opVs8CHNofQdEC7d79R?=
 =?us-ascii?Q?f2Tk04DGPGAehKleFUf8g7JCm3WdIqGXHYyEsD+yfhrbUC3mPHESa8Xd8r49?=
 =?us-ascii?Q?QDSqxo+E0x74lRt+hwzNDrVZtqMPxW61QLz1tdIZx6UIFtoyINMEyszd7ibU?=
 =?us-ascii?Q?HApPDMyrKgq5tAI6N87iu9h17Giok0K10TdUEuUmLxsFir9KzJm0F88eOjLj?=
 =?us-ascii?Q?D3uNJRf1p3RYJvMzIEniUF5QF4WMmyxr9uuFeXqSbZoHj9lGsb0fP1QXe/YM?=
 =?us-ascii?Q?GsQFSkjb3pkYAlnPzdoOhpjUx98rUC/EFHPWLh6asJvNNQedS6v8OdOlGV67?=
 =?us-ascii?Q?3unaDwiit5JPuSBE0wie7gPHrZET64snM1WkHfsiFxPA6FjNtzzk3Ba32D9u?=
 =?us-ascii?Q?iUbmdBLw/3xIDTPu0G1JCxNiCTgv/nx9PRYvq23/T0Pf1dbGtkX+le0Z9m8n?=
 =?us-ascii?Q?Zo/BEYshNSG/4qp1HqwOBnv5vkmHfWKHadg+UQw8i6ixB05XNAXEwDPdys/S?=
 =?us-ascii?Q?EDCs4YFq+MotENjPpGl7WyKYfONOY8LLMkzG6yaED/hzE9R73o6MY1pE4K+z?=
 =?us-ascii?Q?DAiCZcadYhFe5FeyxBe8vLaF1PnOb7c6VvdhgzT4ufsQROMQhNLZl26Tis/0?=
 =?us-ascii?Q?g77oER+lKOk07NpXXBsy74hLbSqNvLn14tCBINbJGt5HKaF32GeiA2PKM4/t?=
 =?us-ascii?Q?Djv5iIN4IvT50SPnWjnvm+1IKozXzCBtSIal5BeDSNw4WhsQfNQ8PfnlBXYr?=
 =?us-ascii?Q?WxnP2RrYYTNVqhVa3UM0Em+gT2MsFda7MjoChyHkcNyeSIakRtZMQmz9+2ww?=
 =?us-ascii?Q?x95mNbqm0IBj6wWrFJpTGxfaCmiTu8yOR0AC2DShEgpUSwC7i8rSaSBn0FGb?=
 =?us-ascii?Q?gTr8z7f13NDemdtmLlc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64794cc5-34b7-4dd5-b2e8-08dbfd2b4e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 05:04:24.5946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zb9JteXBxtGi2HSlO0uNBAsb1f2fjCWZiE5yr8YtX4Xu/qRiPO5+9/JO0V5AI2ls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu,
 Lang" <Lang.Yu@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

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

