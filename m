Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BD9C4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 08:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027BC10E310;
	Thu, 16 Jul 2026 08:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TSOLNhc3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F08710E310
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 08:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwBs31nUuJ0N+7HdkcqYCvXbPM+hTeZ7cmFSZNq8lgzG6NwxRO4yjxc4O5BSn1NQGnqWAVbBb/N4P6RBzJ2GdAS3LaNq6cMYPcKS+rJdbBRRf6w0uxSBIBNnc4NzxwdFo948gYcvWSZ5M+C2jys9FDMwzxHtOzi/Sf3d7a0BhbIkW4jIGEsiiq/a8xwQR3u9jdpmiPDnzyjS7b4vbz06FNOSLq1T3sFfK1p5HgfLsBiwArKMRkQXnnw3UQTOQsK0oS3Y6XPOnHzxXqSiRxcxzKkJDfqM2gEuRW2pXpUts4RB3R19XBBZZfojqHHY2SmySXVurKr1JXXZee57S1nyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uITQezKRv7LiOU0RoomCWyiXo657yHVb/dCkAVt2RR4=;
 b=rVWLLRVvDKqVEkJQtP4E+v0ZaCwGVYRKxe4N1ByBymxxIz80Dnr2i+iAz4MbiWXGAncRdkB79asYUs3pXIPxkXPO1oOkzWc+DxQWb7POvE0gX0JHM6QeyiXafCYbIBp1Hn9fuUd3tr6yyo7YFDphd9E1Ccki7G5nHet09empv0VUAJwG26jPdfD0SeLlWYjZa+1ZpFDD4Ezs8IWreLzWBAjszttnrJjbOrv/Vuw6QSdce97aq+LRb8B5PBasgQb+8eyrLi8yo8+Nz65Ad7o87Kvl9mnrurlq5iHt6v6SYygazSsy4bE63EL9A9O6HmCh4lZ9yqX66TI3l4eT8eAmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uITQezKRv7LiOU0RoomCWyiXo657yHVb/dCkAVt2RR4=;
 b=TSOLNhc3BK6LOsKT8zm1WKBdtk715D+4naNave7jTMTh5P33oMT4XJKlaMGWkIlz55lAHwjAC4qOMppjUXBLHh1fwTF5OEK6qCbSLY9A6ThLtRPEqAmdME6UfNm4RUKmpT5kcux/dACPfd4jcN3gEnGnI/AXaHhemQaFzTsW6IA=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Thu, 16 Jul
 2026 08:55:03 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 08:55:02 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V3] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Topic: [PATCH V3] drm/amdgpu/ras: Add debug mask to disable CE logs for
 uniras
Thread-Index: AQHdFPxJO6PzCJMHcESKTCIyugib3LZv1Onw
Date: Thu, 16 Jul 2026 08:55:02 +0000
Message-ID: <BN9PR12MB5306701641CB956E4A02A6D5FCC72@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260716082233.1056365-1-cesun102@amd.com>
In-Reply-To: <20260716082233.1056365-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-16T08:45:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|CH2PR12MB4055:EE_
x-ms-office365-filtering-correlation-id: c3049380-086d-4aab-fbe8-08dee317ec91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|22082099003|18002099003|38070700021|10067099003;
x-microsoft-antispam-message-info: S59+4HMwLlhcDKTJgYjBr8H6VF0JNIzZYsSVuJ/hQ6gDbIWwmNtjmXuFR2SYe6TVhm1pvsRYZ3rxbLpNWhIse0G7XJKV+k35sfAXzcC2mbKasrZFJq6BHtFf/nIDNwUvSaoiP5oQzKX24gsfuPf/ksNzfbVKpT92z5/BaALiLkC+MFt5Z/biSmcr/kqx5JYO3CnyXi1pgOX/eYJOBA4qC2jlUFPWFYv03Tlbv9mg0dkTH0uZo1Sa9eHgTMbjlXl+tC89BZ86/u6mx/lyXeO3SD/lvGUHyR2TpAlgQfUVOpkYcrSkYrTL2FXLUHXs6+E3QaJ/od0YMjLMsc4Z9dtGCmlVWI1TLL4zLJ+AaCvBYsjKApRQM5jdaRdyw1d/6ean8BjTY5RrEj5v3+JablNdgIw1+uKOF6BGDMINUrDK/6onE3+g9f+c+2P79ud3Ln3Tnh1zvJWG5insGlUfJc+YhQ4iopQW2AH1tEMMplvFycQieIWMuhb8ZKxZMTUruyldMBslvkooOuPxCFzgJXj+ztn9rNgAdktnTdhfiW7JRE2JxScZeHcMjsx2LxnEj9aLLR2dUHNzpTFsistaPndL2Dd7xjXvpsZOMhkSeXAfFU0XrGF4hnFO8W5n+//tRxaXLnPm59zThH/NwqmH1X+iAAVfkPbS2SOcEclbjxf5o+8hvcCVuzgYHPN4EdadW5Sruq1t56eKwxDlQmXZ4MTeAvoXdla+t4vAU92oRfLj64o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Y005d1JBSThYZEZJMzZGZUswb2p0bDE4MWFETG9zUU5sY3l2YkhnTnFJ?=
 =?iso-2022-jp?B?czA0OTh5eXQxN1J3cE5mM3VZVTJ1YkI5R3lHMEtJV1g1ZU9kSmpUVkIz?=
 =?iso-2022-jp?B?Y1FqaVhQUUtBUm9NZzVYd1J1RHJZTm1jT0FHbzJjRWN1ck9hL1ppbFk4?=
 =?iso-2022-jp?B?ZXF5WEJ2ZGcwdkJBWXhiWmVnQ2lHaWF4ME45Y09Cc1pZVzNTc2hrM0M0?=
 =?iso-2022-jp?B?R2pGL0Uwd1Q0enNLeVpKZTZacFY4Wm51b290T2doc2d5KzczWHl2bHhU?=
 =?iso-2022-jp?B?ZUl6S1JkK2dPakp0dG1sM3JMYm82bG1TT2ozOSt6VWFYcnoxb0lIeDYw?=
 =?iso-2022-jp?B?L2FqMEVubWpBV2xjaHJPM1JzTVFzUzd2cXNRbWFHcGgvZ3BUSjZYVVN4?=
 =?iso-2022-jp?B?NEpBcDY5WDkxVUxmaWlpOW5kbnFLQVRyN1pCUWZBYlhGL3dUL2duaUQz?=
 =?iso-2022-jp?B?MFhjNCtVSE1GZXVaeW5hMmtNN016ell1V1luSmdYWHFGKzdhMDdET1Bj?=
 =?iso-2022-jp?B?VXhObFBLR2lmbVJDdTNiUEY4QU4zZHRqZzdwUThGVEJjT1NhL1hpR2RB?=
 =?iso-2022-jp?B?RzlnTG9hZ2xuVGFWTEl4K3lsSi9UUkk1NzJvVlB3TEhVcnR0bFVuOXlp?=
 =?iso-2022-jp?B?R01UQWJTVzNNVVk4ZDBWdDFPS2k0SjNYek00elJsallHNHo2SGFIVFJN?=
 =?iso-2022-jp?B?YTRMYmkwNWpXemZJUlVjOXByWlpxRDVFbkRreldNeVVHUW9VYmx2QVpX?=
 =?iso-2022-jp?B?ZHp3bE1WbVdCYkhIZVMzL3k3SEhYNm1FRU9CM2JmZjhXRE1XMTF1aE5U?=
 =?iso-2022-jp?B?MUFjazFRN0txN2hTVkFIVVlxOFhwcmFZVWtNRDNldjh3TEFhNDdlWlA5?=
 =?iso-2022-jp?B?cGszZW5ZVUFCQzl4aXlHY1VaeXMzTWN5Y1FkcnV4U1VTWVVWcjhhQWhM?=
 =?iso-2022-jp?B?amJ2cmpIK0p1dmdlWHZubkIrVUJhMVFWUVRYTUZmNkpWUHNtNlNyM0xz?=
 =?iso-2022-jp?B?bTB4bVpBd2FPNG94U2trbUJhZUJRL0NGTTJ4R0tUb0F6ZkxZbWdLWEc4?=
 =?iso-2022-jp?B?RHNyMFk0WjVxUnJ2MXI1SU02ZDRCK01xZ1p0NnFoMmRWS3d1bC9pRzhG?=
 =?iso-2022-jp?B?Z0hKR05mMkxIMkFCR1h0OEk5a2w3YXd6TW43RXlQQ1lnMzNtZVN2U2FT?=
 =?iso-2022-jp?B?cWJZSmNYUlhIZEFZdXA1RXJLQ2pxTFd2UWt0WFg1ZVljNVF6NDhWWFdR?=
 =?iso-2022-jp?B?NG5xWGV5RG9hR3U2SUt0VGtwWk9hRFhxcVBhR2VjYitkNzd0Tkd4ZmJC?=
 =?iso-2022-jp?B?TlNXb3NmSXhMTmdzUG9mcXIvV2JEbk1pWlBqTHZaSCsxK1pRNmphQkJB?=
 =?iso-2022-jp?B?ZzlzYUo1OGsvQWp2cmMzWVBUbjJQNVBjUU5md2l4SjFDaXh3S0M3bk1o?=
 =?iso-2022-jp?B?aU1sbUxINyswYlNVYnIxTG5rU3VOY0FYejlDT1hrVmJlWXpleHBoZXh2?=
 =?iso-2022-jp?B?eEU4UXk1S1c0T0JQUklyWUFjV2hWK0tRb2trd29TWU50Wi9UajlYMElD?=
 =?iso-2022-jp?B?cjJkSk9zS2ErcUJ2cG5lR05xV215YUw0cnkrNVBCNVozdkdtenpLa1VX?=
 =?iso-2022-jp?B?WjBSL3RraldEZ3RhbnNva0ZnYlhkL3IxdmZFcTRVeXQrZFh3VnhpZytV?=
 =?iso-2022-jp?B?QlRaOUdzMnY2VERxQWRTZVZJQ2pyRU5JZy9aNDRYTlZvVWFVVjZXbm1t?=
 =?iso-2022-jp?B?MG5xNUJ4MVVUbllaMzM1T05UQllNalFxdW56aHl1eHduL1p4d2l3bnRl?=
 =?iso-2022-jp?B?eTlldzczSVIrSnVlZFdGRStaMjJUQWx6RTJUWE1oUk5POS9GTTRqWTJD?=
 =?iso-2022-jp?B?dW8vUW9xbVppdzhWeUhDYWhKTHMyYlJCWXBvczlUN2p4Z1VCZDYzUXhr?=
 =?iso-2022-jp?B?QnpSSVVjZGZDWlhzWmxCTnZxeENmakg5anVxczUwbHlqYmFyTFo4WStQ?=
 =?iso-2022-jp?B?TmpCK1hDODFqc2RiamFwRmU1K2w2TkJteHcyNTBUQjErUHd5NWNVay82?=
 =?iso-2022-jp?B?dTA4VlEzUlpvN3RJRDVhWmJrL0RrVGg2cWE5bE91U0syRHBBUXVEdXMy?=
 =?iso-2022-jp?B?ZTdIa2I5LzREQ1RBK1FsY3ZnTnhEZU0vdU9sL2pNcXp5bW9PRDIvbUt4?=
 =?iso-2022-jp?B?TGw1RWIyNWFXSFovOSsxN3BaVmlmNURLWUF3bDU1L1pxSzZlZ0hwMFVO?=
 =?iso-2022-jp?B?Z3RCeHc0RFhENlRzcHdCeTR4bHUwbEJkZDZRYThLYlc1S2I5aUJ4NnhY?=
 =?iso-2022-jp?B?NGRUeVV3WHF2VmRuREw3eUNNYmdjN3IvQmp6WEg0TjF0Ni9XYS9KUDRx?=
 =?iso-2022-jp?B?K1NSdWx6TVhEcGpGNVNsSm1CVVd5WUpKd2JhR2drMjJ3NjVxejY4WkpT?=
 =?iso-2022-jp?B?OEFUOGlrRWhlY2tjVlpaWFdCaGFoTk1HMmJvL1QrS2FHUHBzd1FRMHQx?=
 =?iso-2022-jp?B?czVJQTFM?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3049380-086d-4aab-fbe8-08dee317ec91
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 08:55:02.3598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urq6EV19Qzzt3KDlwnXP0fFACkvXkJKsUK7d1+hCPrrcxSpSDRqoyqQojgcSolwkC8dbHFza52aed1CFzTuqsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

Best Regards,
Thomas
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Thursday, July 16, 2026 4:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH V3] drm/amdgpu/ras: Add debug mask to disable CE logs for u=
niras

Add debug mask to disable kernel logs of RAS correctable errors

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  1 +
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  4 ++++
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c     | 17 +++++++++-------
 .../gpu/drm/amd/ras/rascore/ras_aca_v1_0.c    |  2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 20 +++++++++++++++++++
 6 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index a3dafdca7eb3..bc6b7da3914f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -226,6 +226,7 @@ extern int amdgpu_use_xgmi_p2p;  extern bool pcie_p2p; =
 extern int amdgpu_mtype_local;  extern int amdgpu_enforce_isolation;
+extern uint amdgpu_debug_mask;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ea95e0f93d1c..0db755ba7037 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -309,6 +309,7 @@ static struct ras_core_context *amdgpu_ras_mgr_create_r=
as_core(struct amdgpu_dev
                amdgpu_ras_mgr_eeprom_is_supported(adev);
        init_config.poison_supported =3D
                amdgpu_ras_is_poison_mode_supported(adev);
+       init_config.ras_debug_mask =3D amdgpu_debug_mask;

        amdgpu_ras_mgr_init_aca_config(adev, &init_config);
        amdgpu_ras_mgr_init_eeprom_config(adev, &init_config); diff --git a=
/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ra=
s.h
index 878dfdfcb18a..53abf1a8600b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -301,6 +301,7 @@ struct ras_core_config {

        bool poison_supported;
        bool ras_eeprom_supported;
+       uint ras_debug_mask;
        const struct ras_sys_func *sys_fn;

        struct ras_aca_config aca_cfg;
@@ -346,6 +347,8 @@ struct ras_core_context {
        spinlock_t seqno_lock;

        bool ras_core_enabled;
+       bool ras_ce_log_disabled;
+       uint ras_debug_mask;

        u64 ras_fw_features;
 };
@@ -403,4 +406,5 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras=
_core_context *ras_core,  int ras_core_check_address_sanity(struct ras_core=
_context *ras_core, uint64_t addr);

 int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable=
);
+bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_aca.c
index 67a35409ff0e..a1fb9a5f72cf 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -83,22 +83,20 @@ static void aca_report_ecc_info(struct ras_core_context=
 *ras_core,
                        seq_no, skt, aid, ecc_count.total_ue_count, blk_nam=
e(blk));
        }

-       if (ecc_count.new_de_count) {
+       if (ecc_count.new_de_count && blk =3D=3D RAS_BLOCK_ID__UMC) {
                RAS_DEV_INFO(ras_core->dev,
-               "{%llu} socket: %d, die: %d, %u new %s detected in %s block=
\n",
+               "{%llu} socket: %d, die: %d, %u new deferred hardware error=
s detected
+in %s block\n",
                        seq_no, skt, aid, ecc_count.new_de_count,
-                       (blk =3D=3D RAS_BLOCK_ID__UMC) ?
-                               "deferred hardware errors" : "poison consum=
ption",
                        blk_name(blk));
                RAS_DEV_INFO(ras_core->dev,
-               "{%llu} socket: %d, die: %d, %u %s detected in total in %s =
block\n",
+               "{%llu} socket: %d, die: %d, %u deferred hardware errors de=
tected in
+total in %s block\n",
                        seq_no, skt, aid, ecc_count.total_de_count,
-                       (blk =3D=3D RAS_BLOCK_ID__UMC) ?
-                               "deferred hardware errors" : "poison consum=
ption",
                        blk_name(blk));
        }

        if (ecc_count.new_ce_count) {
+               if (ras_core_is_ce_log_disabled(ras_core))
+                       return;
                RAS_DEV_INFO(ras_core->dev,
                "{%llu} socket: %d, die: %d, %u new correctable hardware er=
rors detected in %s block\n",
                        seq_no, skt, aid, ecc_count.new_ce_count, blk_name(=
blk)); @@ -114,6 +112,11 @@ static void aca_bank_log(struct ras_core_contex=
t *ras_core,  {
        int i;

+       if(ras_core_is_ce_log_disabled(ras_core) &&
+          bank->ecc_type =3D=3D RAS_ERR_TYPE__CE &&
+          !bank_ecc->de_count)
+               return;
+
        RAS_DEV_INFO(ras_core->dev,
                "{%llu}" RAS_HW_ERR "Accelerator Check Architecture events =
logged\n",
                bank->seq_no);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c b/drivers/gpu/d=
rm/amd/ras/rascore/ras_aca_v1_0.c
index 840610538c1f..288fad0862a2 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c
@@ -265,7 +265,7 @@ static int aca_parse_bank_default(struct ras_core_conte=
xt *ras_core,
        ecc->bank_info.addr =3D bank->regs[ACA_REG_IDX__ADDR];

        if (aca_check_bank_is_de(ras_core, status)) {
-               ecc->de_count =3D 0;
+               ecc->de_count =3D 1;
        } else {
                if (bank->ecc_type =3D=3D RAS_ERR_TYPE__UE)
                        ecc->ue_count =3D 1;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/a=
md/ras/rascore/ras_core.c
index 08e17a83ad5b..f3c6cbc7e05f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -28,6 +28,10 @@

 #define IS_LEAP_YEAR(x) ((x % 4 =3D=3D 0 && x % 100 !=3D 0) || x % 400 =3D=
=3D 0)

+enum RAS_DEBUG_MASK {
+       RAS_DEBUG_DISABLE_RAS_CE_LOG =3D BIT(9), };
+
 static const char * const ras_block_name[] =3D {
        "umc",
        "sdma",
@@ -374,6 +378,14 @@ int ras_core_sw_fini(struct ras_core_context *ras_core=
)
        return 0;
 }

+static void ras_init_debug_options(struct ras_core_context *ras_core) {
+       if (ras_core->ras_debug_mask & RAS_DEBUG_DISABLE_RAS_CE_LOG) {
+               RAS_DEV_INFO(ras_core->dev, "debug: disable kernel logs of =
correctable errors\n");
+               ras_core->ras_ce_log_disabled =3D true;
+       }
+}
+
 int ras_core_hw_init(struct ras_core_context *ras_core)  {
        int ret;
@@ -382,6 +394,7 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
                        ras_core->config->ras_eeprom_supported;

        ras_core->poison_supported =3D ras_core->config->poison_supported;
+       ras_core->ras_debug_mask =3D ras_core->config->ras_debug_mask;

        ret =3D ras_psp_hw_init(ras_core);
        if (ret)
@@ -434,6 +447,8 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
        if (ret)
                goto init_err7;

+       ras_init_debug_options(ras_core);
+
        ras_core->is_initialized =3D true;

        return 0;
@@ -545,6 +560,11 @@ bool ras_core_is_enabled(struct ras_core_context *ras_=
core)
        return ras_core->ras_core_enabled;
 }

+bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core) {
+       return ras_core->ras_ce_log_disabled;
+}
+

[Thomas]  Since `ras_debug_mask` is a read-only parameter, set `RAS_DEBUG_D=
ISABLE_RAS_CE_LOG =3D 9` and directly return  ras_core->config->ras_debug_m=
ask & BIT(RAS_DEBUG_DISABLE_RAS_CE_LOG)=1B$B!$=1B(BThis way, perhaps there =
is no need to introduce the additional `ras_core->ras_ce_log_disabled` and =
`ras_core->ras_debug_mask` fields?

 uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_co=
re)  {
        if (!ras_core)
--
2.34.1

