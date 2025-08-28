Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50AACA0EFF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 01:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF1210E069;
	Thu, 28 Aug 2025 01:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2mFf6ZuK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE9710E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 01:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF9A8Fbz2P8ZFT1fVM1RD35sELrS8H87+32Ugpqo5lAvuQGMiofgBQG6zBhrjY8Mpi7lOdHEW2GPtj1EQeHkBhGFpEoQF+gr2tkmOP0bdlmpfvNSr3s+atBclK60LF2b04bKel8el2+VA7FKpIphBdg4ZbtpCtDLQpo6c3yURAE4kWWlU0sgbT20LatfYZGscqaKxJkEz5aJPRVVfaorwijWfVSCZZxUctL1VzQbL5Lg4VJ+eAm8PBXqyN6jhAaOLtu2Esecq4E+M5sES/rngkkb5t9A26ZwQIgM06mwKeNAPfqvi9dgwemJHzZLntfd08h32yJqYIShOPfGfFSLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT/F8R24xXkzm1g7CVKTg2SErZU7xx92SNeUN/oYhek=;
 b=uky4bZmkR3Zg+C9VyLnQMOl5ogKebJzuCyPkPZXW1gE3aZ1OvJEQ3NLTrBPztOmUSXbbKIiGutZZc1dbLRQjhhHOgBclkqLmhDm5CesoSW2Cd8FGy7g8mas/0X8ii367B+nuhvyBxpp8C+1arp/9lewbUJx/wyQ98n5eWi49pcBFi556klblLOYbS4SlAPoGaKtSgUnqoY4rJvSem28mDdzTFrTVYY6d40a0q9sfer6ZXJ5CCX9BqwsJWfCkYJQOfGU/WWfqXkej9TjDYu/jWEycgTk7C8MtG09kPkw2Kevc57+SacDf/ckUFnlVPimi+BsOyjUXgmQoLshTriIYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT/F8R24xXkzm1g7CVKTg2SErZU7xx92SNeUN/oYhek=;
 b=2mFf6ZuKC0dBSZ936vs7nZs8ETYoTW801wI6+YLVeYTtOUAYV0b4hEqw+iohr7+A0OolszMX/SRjAr+oF2Kd6pYVOnfc43KG3eeIXp7ttInkgw/Bdl45r3l/SqTJopYq28uOflyRV2EUe4Pv6Zsfkk1z4epp80b1ItHFHfReIVk=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 01:44:54 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%2]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 01:44:53 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mes11: make MES_MISC_OP_CHANGE_CONFIG failure
 non-fatal
Thread-Topic: [PATCH] drm/amdgpu/mes11: make MES_MISC_OP_CHANGE_CONFIG failure
 non-fatal
Thread-Index: AQHcF4Uw+D1ba8y3V0yL7Asx50jTIrR3S2Ug
Date: Thu, 28 Aug 2025 01:44:53 +0000
Message-ID: <CH0PR12MB5372D8C026E37801B2C39A96F43BA@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250827190235.1784506-1-alexander.deucher@amd.com>
In-Reply-To: <20250827190235.1784506-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-28T01:43:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SA0PR12MB7463:EE_
x-ms-office365-filtering-correlation-id: fc28c4f9-0b35-4e7e-0911-08dde5d47c52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Rer/J6Od8cIdfO0qZUGJoPSOn67Kcko+jY7OChutaY2tbadRm2/6xBfJNJoj?=
 =?us-ascii?Q?30PKG6dAIoOrHbmlgLsbIi6q9fTWGnN/BrMNhVFQ+QmgbSnLwBjxd9W5fGFd?=
 =?us-ascii?Q?xNLeKW6TpTe4654A2t9fL08fFXuTQ5LZQRMYiCASFULXzT5pcerXLswcd3mJ?=
 =?us-ascii?Q?5/et2UHQCrYpCRh0GjD1YXDqsjUm6bfKcr8eIoPF9cNffPkmAQAQjFXYpF7Y?=
 =?us-ascii?Q?C/V9YvYQODaV3guX3Z3e/nk/E0CEaP/w6DVCJ3Gj8IttECsFWlTesZ9+nMqh?=
 =?us-ascii?Q?8GTWzctRkDl7vsUTqq4Aosj4CISXvd9uPgKvJnimTdc2/qOXPq3xrgXymGgA?=
 =?us-ascii?Q?bIfjb1xpxltQg5dwANwiI1igLULEWvnJqrW1XVR0ZYnZIVADdP8pEdgJ6oR9?=
 =?us-ascii?Q?M7FkJhybTf3QUJeGe8HotyHmDSFE02CTjnsbvxglLF/qQCZTC9nV0pjkLNCc?=
 =?us-ascii?Q?kIwHSCc1U6cwo7puaG5AJV+o5aZ5bJt+cU/ExTIwwKARLUhk9jEanpexX5kP?=
 =?us-ascii?Q?vp2wbaoKAEd2qUdZteKhm7gC8C0D86a9LIcOTYVcERQ4wus7gyTac6B/IjWQ?=
 =?us-ascii?Q?Im5HODbeK96fI+roCwa3CKCSsi7zjvRzPzi5AxZ5aoExkWKwHBrtPiAA8z1V?=
 =?us-ascii?Q?jTnVtxuOtCnVf+Ii4qr4PtK/8kHvGp4CkinSHBl/3WuBzIJEvAMOTwScZZ7K?=
 =?us-ascii?Q?8bFUB0bljrdEP8wUVIPvIOMD4x0jw0H0TsFLYkuCrDn5BdVKei8E5AIe2FwK?=
 =?us-ascii?Q?nNwI9k2yiEC/s2k33CHP3ZICVrDfUIWqsO5aLTuPreYuQhuf0vk3Qrr6b2Se?=
 =?us-ascii?Q?jjVomFAV+la7ry5/fx85yFk6J38jVA28Y9mCD8Yp0M6PjKBnNNnKt/ah3lW5?=
 =?us-ascii?Q?dTYrU5W1lhX+eE7h5TBUj6kdrNn22IR5t++wflsBm3X2YjSJRUUSifkxA7ku?=
 =?us-ascii?Q?z2rM8l2WtWpv/nbxZbDC5460jsI3v4zrVu0ZRdOFEy0jgNJawiIp3oY7eW/r?=
 =?us-ascii?Q?XUzxb4D9HePgRz/010+g+FcKnMexOXi130OvMqxaLnPiMIyIFY+K9pTEUFlI?=
 =?us-ascii?Q?bBbGyF2AL3EjnphytBQRUS5EWqBwM5AQACJN1FmldcYLZbXEqXVLgNt/d3eg?=
 =?us-ascii?Q?iMQXO8vab40CmeaVH8bVi/eHQdCOLoLfDnu9IZkeLx53OU24o7BElR5quaau?=
 =?us-ascii?Q?SXUDdrigoieHnj4n/sNR3vFW6SoHCryugMYmAwnrIUE+PRif/dVLHFsn6kSg?=
 =?us-ascii?Q?VDvKaV4tIU/TwmXNwArgHNIzB/z68MGIv6mpzLd0lQFSIJT7HcFXPYrE2FWC?=
 =?us-ascii?Q?OLMztzp9M8TjVOvv3MwoxsCMv95pFjRVbHgGjwd8En0gBKLP9puyW0352Buk?=
 =?us-ascii?Q?ZmVPln58m3oNJrgo1qd7kRVGkYZ+70ruXMMiHewt3NLL7yEir/fes0k7klao?=
 =?us-ascii?Q?XKtTGKqYPuk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k7ra/jHbRMJqeMhLNRiQnvpkatjZRhzBXV5QCw6AhqV+AGQnEvMTzqgImwR5?=
 =?us-ascii?Q?yJYMoah9PbbFdzkjjOOgMRsfxPt1tyJeImnYLfIj6RUqnPLEhcHsxccnNKip?=
 =?us-ascii?Q?KH4zrbzeD73F02ubthc9bab+mAHxJ7IFFSwNHdpxhTAWRvViuSKZ+QR62Jr8?=
 =?us-ascii?Q?mPuZn3s5ZJIgzo2x9nXGUcptXCFzrF680Dp23FcEEbcXzm04WiHJ0XoNJQRD?=
 =?us-ascii?Q?cJNLIyHQmUqlj8A3oIz0k3lOUqcXqanDbCLTIhO0rDkuOkD/hjThgYhrmIeW?=
 =?us-ascii?Q?z+bH+XfUqg4+hYEw3z+OMSwpHlu3tV2lG8N43OOmbZrkpxlOUKJkX6mH3EiS?=
 =?us-ascii?Q?f9c133Wx2MqRaSAqOdlOKbP3LZ05v7aMvdj43rYEWyES/lrcz2Eb2cZ02VXu?=
 =?us-ascii?Q?e/TUrHxbq8sMRWl0dqL7suBCB5PanbXYM6GMYyLgF9ZFKCtMK33NaGzJMZCu?=
 =?us-ascii?Q?ugmL43cg1krGpuJnu0B8QL1Mn/QZ5knocjK9E1S2+3cH+ZJfVi/F0Bi/eFoH?=
 =?us-ascii?Q?50kWz5vxbIDPzZnAD3aRwydFPfTxbyrxtv9zd46fZNxu/kdoIt77HP9yeTd5?=
 =?us-ascii?Q?3lQasd621nPeqYvYi08+o0vSRGjq7ueX0Xla+Q1ikLHFiIdu/WUlCIwCZKSI?=
 =?us-ascii?Q?s8BuhuXvFb18SyzY+XjKZIr9BF3/eqbSl7+g57oYG/3coV3Iqp5RILv1KFqq?=
 =?us-ascii?Q?ihdOhdoBAsWlosQ/QAe85RCG5FV782cmhiNHWnSOCSvLiM7lg867UBRu0Y0F?=
 =?us-ascii?Q?ANfN54IqL79VE7U721ZrT+2qBoEX+hmVibe05dWmTwDdSQWqJ4HAchjSp/JI?=
 =?us-ascii?Q?d1GF6bCyAT2NJvZx/RC/MCSWALHJW5dhlrRcl9Wz8sMZbRbPL0pS8sfVax0i?=
 =?us-ascii?Q?/ognqPJqYpB1tNtiV12hNKSh70+ZLVxdonYmRlPRapHjom4ffsMgZC96YZan?=
 =?us-ascii?Q?aE/YkdGd172Cxzyc9sfNCDLCLRPfLAyKcAI3rrAhncv3Z1I0EuiXV0rLbFo4?=
 =?us-ascii?Q?XE2HMJk8vJcEYjItyig2PqcluhZ3EnGzOVa04jTUPhr7bi/+JuVh+7fxMQVT?=
 =?us-ascii?Q?OhbSJ8GmMTO6Xrkt/78nAB3abrv1f5FVo4d2s+BRj14IdzqEgLFHZEq6Ziwz?=
 =?us-ascii?Q?wyVWybdQgkBhrS3iv24cNb68xhyUxbV4VAJ51BurjaKU6giexMvAHe5m4eeM?=
 =?us-ascii?Q?83YCK6ptl2ecEvfqyRJ1QQL/N4ymST5qicPJ3r4okc/D3OfLnCu3iuY7tF7t?=
 =?us-ascii?Q?sVSQwp0NPXp6Cg1Rq1gzwgR96H5CacRcBNYgOmslwo9Q16j+vQXGcBldW/Og?=
 =?us-ascii?Q?yZ/NkiYR7I07JzogLvgDowE4w7DG+zE7eftijXWbEwgtWMGxoGdYR9YWTEP2?=
 =?us-ascii?Q?nMPYNwozyEZVbSTOgS4/hGAr1S6S9oRlmtdQRnB/rqmgvb6IVtPnN5mHypfN?=
 =?us-ascii?Q?Lsfk3NigZX2AY2DtZZKbJ3E73p4qOnEj9veolhwksskbzBc91Gy9E1AjY9oq?=
 =?us-ascii?Q?JzHDKVPxhN4zpaNXTdrc7uT+nEwM1eDg3b+fv+7dAxopqwrTFElDniSB7Uno?=
 =?us-ascii?Q?Wz355cZ/kTNXQGcIFGQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28c4f9-0b35-4e7e-0911-08dde5d47c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 01:44:53.7559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgFi+La5cpUvrD4HA6VzFuNHPEr76wH5UtVhFLlhF3zqk8hp/ooTNeAZ96Sy75sRvdSPwBRxA/a/GReVenBCcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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

Looks good to me.

 Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, August 27, 2025 3:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Shaoyun <Shaoyun.L=
iu@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: make MES_MISC_OP_CHANGE_CONFIG failure n=
on-fatal

If the firmware is too old, just warn and return success.

Fixes: 27b791514789 ("drm/amdgpu/mes: keep enforce isolation up to date")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4414
Cc: shaoyun.Liu@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 28eb846280dd4..3f6a828cad8ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -641,8 +641,9 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
                break;
        case MES_MISC_OP_CHANGE_CONFIG:
                if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK=
) < 0x63) {
-                       dev_err(mes->adev->dev, "MES FW version must be lar=
ger than 0x63 to support limit single process feature.\n");
-                       return -EINVAL;
+                       dev_warn_once(mes->adev->dev,
+                                     "MES FW version must be larger than 0=
x63 to support limit single process feature.\n");
+                       return 0;
                }
                misc_pkt.opcode =3D MESAPI_MISC__CHANGE_CONFIG;
                misc_pkt.change_config.opcode =3D
--
2.51.0

