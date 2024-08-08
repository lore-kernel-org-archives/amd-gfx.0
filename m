Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9C2C52D7B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 14:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2814510E74D;
	Thu,  8 Aug 2024 14:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bqarq2iC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFC610E74D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 14:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2kO28DcvbRWAx7iSPMWiGXcbokFxuWsLmIaLWZqu/bpKJC+2rjlEKJw1G4byeyo0E0uvmArF/lAp3Fbdy/fxsJbZ8RnWpZy/Ayqntwy7v9cq/KAO5ihEfJMLupEhXKFWYLpk+xUtWAcTRW94K7lh/FHwVipTj/nTL3ZFsRsO5ZPPo19YJBbqJujzZZKTY461QDmFUqlymJi3Rn7jcTGj3im7XyEDVQuTCTX6h6EaoYWNnSyQ4qS0VgbUHAIAZ65p76hEjWwa5wvRsTgdv39wekju9IhWoj1W0uYOvPWlNWIO9i/qF+7SzMMLre1kiB06Vi2r2+XjDD7q/A8utWaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9KnpWIQOVPFe8ITdfnw0dkXucVpN/JoG4qyJ0enUjE=;
 b=wgOd37gdnLfva1Z/iWZ3XOP4gxPzlu5p6Goy0dICXjJeeXGSSucxU5fQ+z6Od0PmISS55+ACUpH4mxdVdkjNyiPw2FPiNkSc0R0SuoVpRfDo9uZktgFYpktSW7O3nK5DZQazG06iGVDLrEWL/daAuoQyL7jo4XscdHzBUfHfl5dFUmIUpVV81Ep+aCIdUcftZJ7MguIz+xvFbpsFOkhS16KNPNgdN5qGs2xcgvcuGQTcW+ugAcSOk39TuK4Mwoe+yHtfvvsaBlJddZNaJstFHygcnQO/Z8sKx4l0QSbT67Z8XOk1/0KmlR+JooYVPjFkjj8bhKWz0i/h5eOlvUmhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9KnpWIQOVPFe8ITdfnw0dkXucVpN/JoG4qyJ0enUjE=;
 b=Bqarq2iCeTJUJj1ZKRxZxlrG+JXKWBMP/M63JvTnBbFI6A5+Tx73yIsG+Q972LkKDevmO6E+XC5FWC5WH321kuSBaNwj2oPk5RRCYLIOpampuPZM5pLXLzxkJ8zN/cBfkqm8oMnPgfc9IQKoOjaJMbab7X6HAY35bPFvYIqYVPc=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 14:58:36 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%3]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 14:58:36 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH v2 1/2] Revert "drm/amdgpu: Extend KIQ reg polling wait
 for VF"
Thread-Topic: [PATCH v2 1/2] Revert "drm/amdgpu: Extend KIQ reg polling wait
 for VF"
Thread-Index: AQHa5/3v9ai/PZ2ez0y3+FvlM08SALIddsGA
Date: Thu, 8 Aug 2024 14:58:36 +0000
Message-ID: <BL1PR12MB5317BEC8D55BA4C36D627F2AF1B92@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <CADnq5_OdCBnP=E7oe0cOh3=HGJwXYavRGCH958=S8Px8smH99g@mail.gmail.com>
 <20240806124043.443643-1-victor.skvortsov@amd.com>
In-Reply-To: <20240806124043.443643-1-victor.skvortsov@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8619e4c9-cba7-4009-a491-56e0cf301129;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T14:58:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|SA1PR12MB8699:EE_
x-ms-office365-filtering-correlation-id: b573b8bd-5129-425e-ec30-08dcb7ba94bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qIVbmDzZNr10MUylqE7HcLfvbQHPGUSusJrQUQ9k+KGGeJ3EI/oBCSWKIU9h?=
 =?us-ascii?Q?rTasRanClnkzrbT9VLHm9pr4CGalJY3+SpBqROvX4/iDr9XL3Ub+GTUVfcHh?=
 =?us-ascii?Q?6tNL10QwSqTpx+Euj22KgCpeY+2KdfVFtcopfxjIMWaQ7E1e1P8WV3YsUzlI?=
 =?us-ascii?Q?F7VosGr8e5CXrd6vke2AYpejPdoDtJXO77Vj4WJz05dvLw3mKJUX07shs4Hx?=
 =?us-ascii?Q?iq9dyEMtVr9W7kbtGcBdQLaPXfVXnM7l+pPep88ijLDszEZnTBPRB9nEToSc?=
 =?us-ascii?Q?1s4+sBwK975dpKRNrX5UTAemQVascIDYgh5aGtWNYSfFkcyqiTZpa45ScUJW?=
 =?us-ascii?Q?gA/N9mDS5Qg0pgMX6RcDjPh+vRdCsHk9vI8Brp+BDiALtqD20L1LkqHKgNN/?=
 =?us-ascii?Q?WtczJlDCI9r9ns1NytyZinA8L0EYaxtiLy46JPyapH5HhkUeeHAprWWytMxw?=
 =?us-ascii?Q?tQamIqDSA8afQh6rbT4TrxiYxKFmERVD+/QHYHqsXcPe/qWCEtY9MK+elu4f?=
 =?us-ascii?Q?LhGZP/A5j4ArpwW8b15o2V/W5OZAPc+pjyRaX6IlwSwWgddNTSuuBaiXYGYu?=
 =?us-ascii?Q?TbXRpJQt65oPbQpOxOmmmb2WiXZJqoNbmupOOCxgaXaF6bDTJc0jHk/Swmg9?=
 =?us-ascii?Q?baqU3ZT0/q8a2A82XuwGAjxfGokk5z8dsg3Ygn1ra5fmk1LImBovYaMhypXv?=
 =?us-ascii?Q?jUXEBq76j/oLLnAxNJbaZSSvr4E3Z6EIp6mbQfPcHEMSg5hHCaBsvQjr9nLg?=
 =?us-ascii?Q?JJT9QCuAPR5tlXM5J4tZp2rB88w0AJDVAS8BCkQOWoCrO/waGfiwfEEJdg0L?=
 =?us-ascii?Q?qJkarR0TzZ+ZekUIVtNAsrOjAZTaAZ6jWtRKdIeL3oBcumQwYTXHEHOl3Uo2?=
 =?us-ascii?Q?RdnhShICWNzuyMxUDZESqo8hnscQw7gieZapKcHRYePwXwAvNvIG9oJDou5W?=
 =?us-ascii?Q?08sJNY+r+jNYnYAT7nKXPYRx0RkHkJpR7ij0N0+Pk4AThu/A4kILZZxOEuXl?=
 =?us-ascii?Q?GkDOkdiKm7h0mQW5iDNPt1zGcUqiM3k6KRwwUPHalT4ZFMz8bMSYFiJVHYGh?=
 =?us-ascii?Q?cAscKlTPeANSpwIrt5vBjPmZjTGbe7KaDgUKqEQk2iB5/4CmSO+tbMHwnEBu?=
 =?us-ascii?Q?pEKYnm5u/v8vI5HQ1rozXzxFAouyyGG+uf/iI71M1C18ZrxyrQ6OaZi7JpoW?=
 =?us-ascii?Q?E/0xEmeo5b+uU6paX4PQrAbLI02bCriVjQvZ06hCawqxR+4Kg/j2a493GysP?=
 =?us-ascii?Q?N6X5rbaZgthbuQFHEuyBxWMFIYAY5/Wt4+ixA+aMx0NopRXalrTtdfLLUYrs?=
 =?us-ascii?Q?R5hOwstMpSCLFa1GKhwtr9TlnTGCe3g7K09WUSN/ZKUXkorYx+6M5M8MDyk+?=
 =?us-ascii?Q?hWDOIZjn4KAytVS4i7OLMFLh2b0AXPi1dsB8f45M7bOpoaD1xA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+PHEn6/ALKvmoa9PUmIbdQsuZiQFbbVXwKfVttmX6WiW2/3Ogi9xc+09jiy0?=
 =?us-ascii?Q?Yx+/CyP6zCV+FL/+rhbTp0HQ81dGeSa845L7QjuQLqUtdyR57TkWEuTHf8VN?=
 =?us-ascii?Q?zONRiRCT/rkNs0nkzzeADoWtZhHoBj/8/vwC6iGD4QgMOrio/ILbdMXOxpgG?=
 =?us-ascii?Q?4nch4QYGfIjXv8YzEwWjWspRu2l/YuKF1T9LaF9g3UrH++F1BSwFJdhAhuoa?=
 =?us-ascii?Q?er8/S7EPhNzu3WE80TOWkdihJ+0LrB7PcPFvS0yiOahAmGnUKdes5j6LDBEb?=
 =?us-ascii?Q?qi8mjJw3lBo+TCG5wZFoC5WzHsjA2TnnQDBNgvdr+8+rVsZit7SpohZPeGKT?=
 =?us-ascii?Q?2JN1zkKvOxKenlAHorngEkcR3KFMSjYI6bwiL0RBfOuoJl2bCemmtvPXwQ16?=
 =?us-ascii?Q?vvoQiJDVX7dC5n2e3KPdJ8aO8Q3QPNjUuK2NYfI0sNuKiMAltgVD/yeDhnfy?=
 =?us-ascii?Q?hbyyEtlr0SWg5UAPYPwTHYKoeO8UW4CgJHkrd3PzTmMR1MFy05MK4YNgMsim?=
 =?us-ascii?Q?eVIBmw24xLrNylya5/nqfs9/+Q8xzyXf0kjKIMb9790WEM0xjTrifI4ixigE?=
 =?us-ascii?Q?q9NUSB1rwot8eTeh5a48xXVhMjZhUqwVlvGpeEtxt0FtIUtCOpdxDvfVpnJN?=
 =?us-ascii?Q?33PnwvrTZpHJsbsSYxWq2gkzIMDN2pLYDwxXpeE2otSq9DwpT4EZ9QoXgNkt?=
 =?us-ascii?Q?P1hI52wBsBkT2Xv4tzpvzqDSy0LamfNYlSBaJG7xPD/AfZK1fXI0MXRnrx90?=
 =?us-ascii?Q?mJZdLiDMw9/a38zAyYabfF4WEuayVCRjNya5EgOoF+ZwwTitPPPDDvi3/qiS?=
 =?us-ascii?Q?WDmsXTIzgC7ZEcfk0E3w7n82uBpywBCMxB6HAX8W8KPC2+ODO0zv5FCTuHQc?=
 =?us-ascii?Q?Ohg43A8s/pD73PDJzPVUis8TVmxT8laQgTW2jJVKpnbUF9z1k5AU57SVXDOI?=
 =?us-ascii?Q?VzEVCaEO2RoITDzGZ0Raty9ZPKCQlBtLVdJeXpTzxMqSdrSr9yLQFo6FXHoI?=
 =?us-ascii?Q?N5nYbTvXf45uxcW/dH4FO3n0siBHodfmeZCf7DJra5CEs3YdDRTpJh6emKhF?=
 =?us-ascii?Q?gKbA5YdYWZO3nqGB0/OPlm8WZu8JF4NQpd39ifU6Q6/zB0nlvTcRFeNa93D3?=
 =?us-ascii?Q?VjcdkDzHhWfoqKvJUET/fr8fl/cPeSXFGvq96rHj0D7BERRF7zi9Y6w5b5oo?=
 =?us-ascii?Q?iAvtQGV0PH1RmjTW0wqJQNpN/kUo8sGfyzbJ5dKKvJ6G5YlGVURQDFvggMeA?=
 =?us-ascii?Q?ioo0ZhxF7PGD7MUylYFcMJwO29H147SHw6Nu2fILONzvBklbhAGFLaN9aYRP?=
 =?us-ascii?Q?6ywrYaI/aKICIohm0UnuInT2wU2FFIOcFFx3AR2vDRphu43OtuEEZJuJCjza?=
 =?us-ascii?Q?LmGIq7vsnmZEWsVyh5V5TFgcaUEHJ84UXtk+PGvdyl9T+xwaP4c8KgVfQetV?=
 =?us-ascii?Q?keojUi/5+dM2CD1xYOGhx4rhE3ImSE3/lbNUjuJfYKwiKhE46k/pyar1nOV8?=
 =?us-ascii?Q?Cy5FwRjj5JvM4clJ8oUzCnblMHno7eGOHwwGeIGUtQodALh5CypoTLD5SaR0?=
 =?us-ascii?Q?dxzFotY/JPm9+M1QApM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b573b8bd-5129-425e-ec30-08dcb7ba94bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 14:58:36.6773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VxA8LYRs8xxVElsE9gscTq2uRj328oGqWgmt24UAsUslcVAXmhikMbVPxvi7W2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Tuesday, August 6, 2024 8:41 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v2 1/2] Revert "drm/amdgpu: Extend KIQ reg polling wait for=
 VF"

KIQ timeouts no longer seen.

This reverts commit b4d12cc00ad69e8a0dea2ece7202bacfd8b894fb.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 137a88b8de45..206360503136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -347,9 +347,9 @@ enum amdgpu_kiq_irq {
        AMDGPU_CP_KIQ_IRQ_DRIVER0 =3D 0,
        AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT 1200000 /* wait 12 * 100ms for SRIOV */ -#defin=
e MAX_KIQ_REG_WAIT (amdgpu_sriov_vf(adev) ? 50000 : 5000) /* in usecs, exte=
nd for VF */ -#define MAX_KIQ_REG_BAILOUT_INTERVAL 5 /* in msecs, 5ms */
+#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
+#define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
+#define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000

 int amdgpu_device_ip_set_clockgating_state(void *dev,
--
2.34.1

