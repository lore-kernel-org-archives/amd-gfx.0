Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5837CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 13:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9EB10E8E9;
	Mon, 28 Sep 2026 13:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CAa4U0Lv";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F11C10E8E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 13:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufVEk6/hpreBIe4jjkjT+3w62dN1ZmlJpi8DtdsXw9ypesKjqmbSJJD02PoH7dbMWeMca41FZe5DezReOB5vn2zo6+A1LZ3qZxLJwmD7KNcoX92V9Fz82GSWOcyQHkUdy3STK9VIk0RRjNGA8so+lZweyeOSgrRtrcD1NMNxb7jlYeP+SW7LYSrd9HWklr0hOVqOPr66AMMyWBuV7YNc1LCy4PkhdeTeQ0BHHRMaBdR6MRpZoVvC926LF34wscF7v41gEDC8WzVs0Up77jW+CRteBL0diPSq7R7og79nBm2V6R+8Vs1WjVbDnyhnUvnvXnUh6zVExT3DK3pCBPvmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8bew1JYr7E2KGWoJL+sgitupldIlBY4k8hGJuCqUeY=;
 b=VqhgXPWBwC5ccyH1TgtqVmg2sLQbUbtfarfu3JSxkzVzpimyueGTYJmASIAD5fg+wK7czQkZkUU8AW0FZfeAsn6fVIXm1a7dZz/KBkhcBsMaUX8W80qwcGYd0yOkJ6ogXyANh4ZgYJtK8qI+/nc0KJhmJh9j0OFA5dNJCeo6EtOm9aPbCoWcSntaciHBUNOST1cpnbdqNwFuncczfdcXMFz/+qx36mI0p+RlbQixN5UpZIVYi2jMoPOnLtBVd3H1HAV7rY3irNZ+vtWCL8LGH7QHiezhMtOf4jzSSzdS2ZqLNGTSr4uDRTF1Qc0kQHAE2qCs9SOLc8tCx/P4MwB8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8bew1JYr7E2KGWoJL+sgitupldIlBY4k8hGJuCqUeY=;
 b=CAa4U0LvhnLv35fxDthD/HVaoEzzQS3WAW/QRYzHe0UX2pJJg+llRU4MY/zuYuSU5QxIU9mptFOwPqz7mOKwOeylnHHxjy6spVzNHoeoKxCodnOEpcI0ASxN1GvEdVAqDMBzCXrPS8zZmyvciNr907hQzuS7jA/jjPl3kXxgFJA=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 CH9PR12MB167381.namprd12.prod.outlook.com (2603:10b6:610:314::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 13:18:28 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 13:18:27 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add package type mapping for EAM
Thread-Topic: [PATCH] drm/amdgpu: Add package type mapping for EAM
Thread-Index: AQHdT0XuisAoJtUBOEO2EnPMhZbeDbbj+R9w
Date: Mon, 28 Sep 2026 13:18:27 +0000
Message-ID: <DM4PR12MB57486012AC21EF42E1622B608E8D2@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260928123532.2885747-1-lijo.lazar@amd.com>
In-Reply-To: <20260928123532.2885747-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-28T13:18:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|CH9PR12MB167381:EE_
x-ms-office365-filtering-correlation-id: 8ece3168-84f1-4e95-abe2-08df1d62fbd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|260925021311599003|260925021911599003|260925022911599003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: mb6Cb1oQOcVUQZinhoJ+lwe4moMdW6ARTw19sR+ZoN+mN30LFw0eAjx0H0q/ek6L7PnflNTLL/5QXGHb+J2VNJA5AIhbSrSI7Fv0g//DRTJdav6NpqLHPGoY5joEiZrioJVcxfkO0Ps95no74yzkE54Pax87RZ6JXp2tgtY8//Xq+93RwaITtn/7rXktELx60AMQFoiXWd4gAtQ7yFND/kGtLtGQwRt1xX1QIrDDrlP0uomZUZshr3qS4wuOIGYYn5MGjCP9xWHVzhUJ0OSld/j2VgtEsVljxGsvciYROmc0W38e5/h9qwj6WfIc1VWwmELwp7TA5JPVCnRfLlE6fPSG1bInTKuDSHVNu7gE3xRIG3G7WqW/rppTBy16pTX4Kg4e89Q5dRdAbkB99e5aKjkJMKqIGMlMfxyogUSiGxsj1WclocUQWIyRGKvadE7TwtVaE+ghl6p8cH200CyvIpBIY582oE/BdTT+HOKeE516GTAS/mDTmu+qg8+3BP9e8lwPNnmlEZxOvro/z8QM2RpNF9QXFq1FQR36PZGk345UkxLuvgD2XaqCJLRfcM5zGtzlCr4PnzcQ/sqUSKeEzwt2lfSgaegK2QzZ7hkE9GW2BZpub8mNbbCBS/h5Sl7xNDls0y3SKz5oH36Ti+thJz7g1llMZONuByng7/cMQb2WGZetMF3xT2QwXYx56fdAatsf1potGQ+Fe6UmDcLmypPVIIb1Px7WbyHsoFctURw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8levOE2jmX9Oeqhol6subfKhwVxjTSwwh8Gt8ciHDUDlZFnzT1QqLCMkK+53?=
 =?us-ascii?Q?hbYBdc+Refbyn9KiZa1W+WdTQp3Dp9etALmIOYHLRxiIpEGiUi1EvK66e/P8?=
 =?us-ascii?Q?C1zLMwgkPzxWRFz6MUgsp80gL1yrhiuh47/yc2dUiUacDYNUcfnueweQzMVC?=
 =?us-ascii?Q?ChnL0dKQalbB/y0QAumXrvZYI04byhmbUpejE9B6JEmHJ0PFxcewZCzD4JFm?=
 =?us-ascii?Q?PmV0xUuDXCEzYh57RMdkjGqERQvBMSfSnYikJLFVAv7uyn3cw+v6YQfQZ+dQ?=
 =?us-ascii?Q?j8GOsxD4DIpcJCuFZSYwikS+4lkYpJDcpwgJ0rwWzHY7tdWP0o2LJS8UtPx0?=
 =?us-ascii?Q?qkjipdU6npBRY6xwsuRUNlYeluUVLSPjigH16aamaQ9JG2RoWLaQ2qsDtDt+?=
 =?us-ascii?Q?+uhc0lW89rSJhPXUDsbfSaV6fcmqZ4lvoEYTgecY8+wxHp+F545vv2HEJzXq?=
 =?us-ascii?Q?1uM86PaJ0QslG9PEASHAZ7iMST0m+NezyTiUPJ1mWM1+zhCcongYHEu8RRD8?=
 =?us-ascii?Q?/LOnCv939e24foKkdD37XvrzwcFC/Wdl8MCND6RxCc6DFfGimbnEHtZenYZf?=
 =?us-ascii?Q?YB9I3DZbXtP8XlJ4MEN5honPZ5FbPOL2LEPFIbhBdDYk05K3e5qeFAVIUnix?=
 =?us-ascii?Q?SsGRgi7qgweTKtmunmvKTUQcw8KdnlEdCcye7xP1VD8Co5i/Ng1KVQs8q+Pn?=
 =?us-ascii?Q?zdXfudJhXY5Gvobiajb6J04tkrri8cKH0UPff/8KoKaXS2cgLGz4uR50LZXw?=
 =?us-ascii?Q?v/kwfLE6Nwt1i5z1lO3wz3e97l72T/ims5KtqkVBq9xfWJCcr3qrjh/AidiC?=
 =?us-ascii?Q?9PW7UuKgD/GxS/YeTFeYLvNUYFYf5K3LM9y0ko7q4nJWWFkU0D3EU/APiGDJ?=
 =?us-ascii?Q?t9cZo7tvUR498NWZKek2X7ugGvVFT1+AnsDxDhN53YPqux4418EaIZypxagd?=
 =?us-ascii?Q?nT8Y7lyRiIEJ9CxoXq75wfA7sb4Hgh4UJbP8wySWa2q+kHFr5XoVgHwbD9JU?=
 =?us-ascii?Q?/R4Y2TFYeN4jq23ZNj3VY1C1e+5fOD4626vkry19MZiUTt5Wl0sfE4NCnAo5?=
 =?us-ascii?Q?ek/f0SdwM9PEdKe2a6BPbwT2aVOApr7IKjtmVP4kGN/UzsgPeT2NSuG2RG36?=
 =?us-ascii?Q?eUPiZLE6AvWGFbLDTPFw+kXtWPsDEnyQHaczRt66z7DZxS0rHAif1j3yr21E?=
 =?us-ascii?Q?LHPXp5ZkQG6pDfHCG9ZtUP8N8elh334kvJAZrXLMLqWGkYd+Qa3AfSvwsc/V?=
 =?us-ascii?Q?+jZN9dValba+4erZd2TFDWpR1wJVorBLntUsNtRR5A3e3TZVpLqF1DIeXr4w?=
 =?us-ascii?Q?ApRfjJfr6Ajl6BTxtxCmnRB3cVXPijrbzkWohN2NlOwoNwmKAFZIcxfmAbC6?=
 =?us-ascii?Q?kvEyckWncblFBuFE9vSYQbK41Y7fsGLf+zkr1j3mItdzZnZDVkNHakYktyIo?=
 =?us-ascii?Q?v/rtBAww01TD5FaKGzfdgOecQg6yZqXQYtwXYQVZNEe0LVxVHMnXuax5WnOl?=
 =?us-ascii?Q?02xB+V7LsCg4tk943TRfgUrOWRNMt3RS+ONMLoYttODyb+/JBw3XerdCX1zF?=
 =?us-ascii?Q?lFpMKQXG/aYMEtdQx5hsQoCGAQUsLDjBM9N1O2J0SCUxR4dOtTAH11eYnJn0?=
 =?us-ascii?Q?jhJ6gJexDo6LwQvq6phRYk11DDFXpbsFyatrWvGdpUoDZjetkKb+QVUmblgq?=
 =?us-ascii?Q?PzdoYSZkl8GhbfvzahaOJFL0D3jvHWuZDb7RI2XA60snOYs1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ece3168-84f1-4e95-abe2-08df1d62fbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 13:18:27.2681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8OOXHS2JKKgiJEAGKr/4VzLv2pGvUyR/oDpxq1KeC90CHyY890w1wFVOOX7QBqPse0xf2xmdXgdEazpKSFxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB167381
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, September 28, 2026 6:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add package type mapping for EAM

Package Type BB uses EAM design.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 4762944969b0..87829747d7a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -334,6 +334,7 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *=
adev)
  *
  * - "cem"             - PCIE CEM card
  * - "oam"             - Open Compute Accelerator Module
+ * - "eam"             - Enhanced Accelerator Module
  * - "unknown" - Not known
  *
  */
@@ -357,6 +358,9 @@ static ssize_t amdgpu_device_get_board_info(struct devi=
ce *dev,
        case AMDGPU_PKG_TYPE_OAM:
                pkg =3D "oam";
                break;
+       case AMDGPU_PKG_TYPE_BB:
+               pkg =3D "eam";
+               break;
        default:
                pkg =3D "unknown";
                break;
--
2.49.0

