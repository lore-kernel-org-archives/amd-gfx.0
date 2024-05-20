Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CA1C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 03:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4341A10E06A;
	Mon, 20 May 2024 03:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lzhlXyOW";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105F810E06A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 03:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzOCSbzGOQHwbXSXN0VXZzwKDWUmV6rgIOk04Uxx6wDmQCoQ1h4xdem6Ciby4g44B/ohBSbg61eO6SJ4p0Vor0UYk7LcZ76AexdSmRy7Me4W+Wczg0jtUyNMegmhl1Qw/I1avtWXaQ/16VgVNTGH+g60Uf9YFc8DcpxcQBombWfVSmCMuyi2glRGVS/yGgGYO/4Y3Lt4oNx6gqEDm5RO4hsTiP3aary+rxuKkANfqulYi3Db1CTVXvtv7dKXXinTAGM7jfi8TQHsel5WkG7DYa/+ma3VNtzRqXQXSkzrvefCTzHA3Bk83MLNBatd3R2TWo6PPrHzNPe/xBFr7ExO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euK8LZPLIGSYlHS/TQFXIKnUQ5N8c2ij6BYYpHwLJog=;
 b=HcQsp66cO8EbGj26ccW4BhsjiHDqXstCYtQvTf8QjY+gL8SIuW4RWTeRuBErkr2VVVGNxkAxHTmpxyRQ/wgP5+DZB0Y7G/KclTKVRY572fdNhabIPwTudgyEGw4oJpMSo29mPGUPWPu2cD5/zaGC9l5yCOhRttHUjV0CutiAL4KuTTixnIixuAQeHSIlZV28wHgmf53OvEy4IdGM2z96Qxj8EO0L/gFwvWo352/PuQkzsuXqLDb0e6rL++iDSswcb9v0JGeT24dKDYVlzKGNSkqAqm5287IWvw5tgQCJ7E4Y96TCX1u4BtfYPdOH2Emu4LogP/ndN1ppOwAE3kxP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euK8LZPLIGSYlHS/TQFXIKnUQ5N8c2ij6BYYpHwLJog=;
 b=lzhlXyOWUPxOebeQ4hmzn66067z3ChgcHcQ1JTrjpK0xz4R1NlLgv2PrjOxd0fEi1JKbV4hwbpNh14teZBrSa4AQ0ijvtN9jpgm31JRdZz+m6/ocEA6tyoN0qabfee9btjIljHAQJgAy83op5vxlq1PBqquydu8+clWXOFI6bDY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:23:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:23:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom
 functions
Thread-Topic: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom
 functions
Thread-Index: AQHaql/k18He/d08u02Gll0lrb5/FLGfc3WA
Date: Mon, 20 May 2024 03:23:08 +0000
Message-ID: <BN9PR12MB5257F610E24EF0C1E055E5E2FCE92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240520024546.23403-1-tao.zhou1@amd.com>
In-Reply-To: <20240520024546.23403-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=394acabc-8271-48a2-86d2-5da837e1c2b1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-20T03:16:28Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB7517:EE_
x-ms-office365-filtering-correlation-id: e3f3cc9f-c1ae-4299-447a-08dc787c2bfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?8g46O01w8ky1rTePYb4Ir3DMArrxlRiuFlLWAhl3YbVzToi4eOCkn51b7gqV?=
 =?us-ascii?Q?opkvspJj3CTvnM/KGvtTv4J8V3GIcQrF6XSojV+i9Bn4XpQl3/4CIYyFkKxT?=
 =?us-ascii?Q?qqxeecmFsHglW2j4Asj+LkyAB2+58cVancptOy/cS8+WkQKcikXIn4sN98r+?=
 =?us-ascii?Q?NSYFa9oPi5JzERob5U6+SSCWm+eZd+2n9lppF00VCr4hEPUwOROSaqJSvYl/?=
 =?us-ascii?Q?eUplXDgUINLK885OinAUo92tkH65C1yvSMPS7psxFHre5LaOoOS97spN6ijA?=
 =?us-ascii?Q?AhuPNoRLnDCLLtzGpH0KLUADVYxrupKn9KmKCoZmH1Yy75+Zk7mmk0Ws0E3C?=
 =?us-ascii?Q?E4BYwKneZtS8lD2rfJEXDE//hCkYFRiQB93vbWukM9J+QxFBxVF0sftdYLO8?=
 =?us-ascii?Q?p1gb9qpgwogICS37z6FSoKsKcv7Ff2YeFC3OrzRkSFSz9blwdEStyWOvkCcF?=
 =?us-ascii?Q?Nf9s78Ul4Ju6gBRdzv4oB/t61D/q2Oi1m2p/qBl88y54Kkq+Z01lg/npgho1?=
 =?us-ascii?Q?B7YqvC2ILENX8LUJMvPukgUvB5Qrdo1pws5PHwI9VSDH+nk15O6HZF24rLX7?=
 =?us-ascii?Q?bGUdabMraMIxRGr+U0fMNANmRxLSVQhjLOpBbnub66dR9RWLJgF58eYQpjWl?=
 =?us-ascii?Q?At3fIwmXok50iBY13ANAzpfIQprtiGqmmeCB9UhoGxTDz/KY3nzZoaeGgW7Y?=
 =?us-ascii?Q?wVtZAoAUT+NB5yc4UXzqKfVlk5fTkNaBkjlIPKaRUr8VRworSlpgnrgjiCq2?=
 =?us-ascii?Q?Y81KglnB7O4WgvabfqEyAnLHejwIy1SxKm0YM+opoDxnqodn0xSfLGwpfGQt?=
 =?us-ascii?Q?sQy4uV/oLs+2P3glArREbtON2kyaLsCVVfEW/pWytGPbr/KAg0G4USs9gxP7?=
 =?us-ascii?Q?ZBs/6ourgGtyw+5AbVhi8YjnwyD6KQEzp1aF1YFmXHJzF3+ZclbqjDYY2SHj?=
 =?us-ascii?Q?O100a7Qt2bCIWiergeRkYSL0YCl5pLvY3yKmwDK4rDq2WoGQZ2u+tgb6d0Jg?=
 =?us-ascii?Q?XepCQOp0ck04yJ/sXxkvdDDQFzm3qOPsJhN+bl2cF9bf6u/8QEXzCNICC/gS?=
 =?us-ascii?Q?H/YqPTANKKmnN+oQb+tLncE346IUBfqHLOCBWjT73knYRXuPv77YZJAdUwR5?=
 =?us-ascii?Q?31xqWea42Pk31ymMXuyI7hXdfwmSpE+TAl6ISQsL6M3BdWvD18/NEjfSFRbE?=
 =?us-ascii?Q?J8bjumsBNZGRymKGT/ZXr1/48MqZ2JCw83vtmJF6DYwwz5D/5zRbo/+vytjg?=
 =?us-ascii?Q?5ZicL3Gx80GQ112zPfaNCNnU/a8flVl0bU8QZZP60HMrYddvZwXmnYozU5EU?=
 =?us-ascii?Q?uq1u91KVj4gVwSMOfk7SnS8PFDvGSsPe39TsSVemK2aixw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jEgJ8V6Bb21Q0FsTXkS0dH4Xk5D9/6mGxiloKKwZBaBFW/++Gx5MSOU0Vdgc?=
 =?us-ascii?Q?5D6cYpt/BhLuiQ5QAkLwpPfXml79U0YP4ONFQ18tKWEGs9/xAuIpenVYHGRz?=
 =?us-ascii?Q?HjE0oHcA3bskPh3WWbDuShc8p7s3n333JbDY0MQDJDBFbn4/kQVQ2HgCEEgi?=
 =?us-ascii?Q?qFMO1a2XynuLhNf9dpx1LXB1QPsyAztcghcX4KEy9B6cbfvDKQWFjNCwHE65?=
 =?us-ascii?Q?f2D8wFqXz2/GUPLfxEMNO7l4/iRRzknlK7K8IwrcdneigNBRYPfMmieksiyW?=
 =?us-ascii?Q?/2iFjhzSLPbGwe7GWyLDYEqpMWJg7sKoTN8nlj5lMbIKaqdCNkpBxDUazsyN?=
 =?us-ascii?Q?Gj37TP/7eEBK/pzoaAgWRhe9+ajgChrLLgQXXZzoLWM4hnWqwalmByie645G?=
 =?us-ascii?Q?Ts/ytji9G81jO8y0EAbn4HceRZp+YIuuTvyt1jJXUZVVw5Vlf+y2tNGu+0Vv?=
 =?us-ascii?Q?2EMIxkTk/Ri/MwfbERMvwtgOTp/7GQD5LySgIN0PiVhCCC5vlhyvqVgB1uCd?=
 =?us-ascii?Q?oSrpuX27u8MIbns5ZEf1UJECNFB6N4cWh+B+u/wDWo83co9/S8PcpTtPwnrI?=
 =?us-ascii?Q?YrgEnT2tToMeHS3Cklqn2M9YQoRJcluIkgNTZiDlaBSwbS6ryY1qMfSpacVs?=
 =?us-ascii?Q?zGo6gZgsEkEnIvNmgwlRsEPEzIAjUAxmI3IMRggNkqaBTY3gXpwNWpV9JgIW?=
 =?us-ascii?Q?jp/hbi0h+SPCLW+FVub9djAlvaW8bWN3Y7AG384A1KnJjakHl8PIsKeMbVpH?=
 =?us-ascii?Q?H1gmQ4Q5J4eNbam7qSazzDGPbSkhuPsANb+CbOGR9nNP5Bi1vJMivvRFejt5?=
 =?us-ascii?Q?jkJvw3Zxoz49g7UoM5SOAs41djpNMfnT5XJ9gYLhX16UjUtppPYdwLS5+MQZ?=
 =?us-ascii?Q?voSukdRSa0amp8z7DmQLIxLgIwXSD+jvbuQYD3Q6Nd36bdmC5DmKyYSLQl6v?=
 =?us-ascii?Q?J9nxwojQ9y8/lZNh2fa4UHHoUxhtSix2pfeli1UWf6uA6w1nyhChJhM8uNGd?=
 =?us-ascii?Q?qW64hd8oXIFGgaj3GyVxeJVbBN9Spja4lBntv+P9pICpT9u8rejGXYRDaHax?=
 =?us-ascii?Q?n0vn08L67vA6saHIDr5iO+sNwwJoTyYSHEa3WM3eqFMs9QeQ6CiwegPisvRQ?=
 =?us-ascii?Q?KecceKlUsh0cXCjhLd1rghFF/fUA/Mvy8SE9GcOoeHelbkxfQ3OUeXRacd2x?=
 =?us-ascii?Q?Mh8/qDNS4hwZ0Fx0/1JUbSMt4Yc8vsbKMe38CgR0qzYGtR96H+YvwrqoY9ba?=
 =?us-ascii?Q?6hDx9du439RlfNSjGaEcF/evyS7C6TOqnlx3YoBkiUn3huYp7UKcYapvTKfH?=
 =?us-ascii?Q?yvF+oO0zUQaWUbyXYTXzvf2QDSRPr1b3RrSCaR9L3JBQTH0t45ILN5ind8Mz?=
 =?us-ascii?Q?2xH0DkCvBSHv9uLUJfQCLjr6CEBA8e6XYAmdYQXVQq8k+WufU28PidzRZOxd?=
 =?us-ascii?Q?x2q0HjOUjSfAcmC5YJAYKjDxYv1p1DznMRka9GcurRGA3JtE31wggD8wlkkl?=
 =?us-ascii?Q?sOR1D0W13+ZAJEmfnURKETkiT+r7b9D/BepTa3zU8A5wmZcIiyZYNLRMUbFO?=
 =?us-ascii?Q?KONlWrNh4FPssHXtP20=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257F610E24EF0C1E055E5E2FCE92BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f3cc9f-c1ae-4299-447a-08dc787c2bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:23:08.8732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeUOSVXNRWnydmu6uadAIBEQGSTY75GF4qPRanJHhrm49huLLlYkiwkhO5IfKJYjH48Kb1oQ5EvSKMJwCYNTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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

--_000_BN9PR12MB5257F610E24EF0C1E055E5E2FCE92BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Hmm... but in __amdgpu_eeprom_xfer, the u32 will still be cut to u16.
__amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr, u8 *eep=
rom_buf, u16 buf_size, bool read)

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, May 20, 2024 10:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom func=
tions

Avoid overflow issue.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 6 +++---  drivers/gpu/drm/amd=
/amdgpu/amdgpu_eeprom.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_eeprom.c
index e71768661ca8..09a34c7258e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -179,7 +179,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c=
_adap, u32 eeprom_addr,
  * Returns the number of bytes read/written; -errno on error.
  */
 static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_add=
r,
-                             u8 *eeprom_buf, u16 buf_size, bool read)
+                             u8 *eeprom_buf, u32 buf_size, bool read)
 {
        const struct i2c_adapter_quirks *quirks =3D i2c_adap->quirks;
        u16 limit;
@@ -225,7 +225,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_a=
dap, u32 eeprom_addr,

 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
                       u32 eeprom_addr, u8 *eeprom_buf,
-                      u16 bytes)
+                      u32 bytes)
 {
        return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
                                  true);
@@ -233,7 +233,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,

 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
                        u32 eeprom_addr, u8 *eeprom_buf,
-                       u16 bytes)
+                       u32 bytes)
 {
        return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
                                  false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_eeprom.h
index 6935adb2be1f..8083b8253ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -28,10 +28,10 @@

 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
                       u32 eeprom_addr, u8 *eeprom_buf,
-                      u16 bytes);
+                      u32 bytes);

 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
                        u32 eeprom_addr, u8 *eeprom_buf,
-                       u16 bytes);
+                       u32 bytes);

 #endif
--
2.34.1


--_000_BN9PR12MB5257F610E24EF0C1E055E5E2FCE92BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hmm&=
#8230; but in __amdgpu_eeprom_xfer, the u32 will still be cut to u16.</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">__am=
dgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr, u8 *eeprom_=
buf, <b>u16 buf_size</b>, bool read)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ta=
o Zhou<br>

Sent: Monday, May 20, 2024 10:46<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom func=
tions</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Avoi=
d overflow issue.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Tao Zhou &lt;<a href=3D"mailto:tao.zhou1@amd.com">tao.zhou1@amd.=
com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 6 +++---&nbsp; drivers/gpu/drm/am=
d/amdgpu/amdgpu_eeprom.h | 4 ++--</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 2 f=
iles changed, 5 insertions(+), 5 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_eeprom.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x e71768661ca8..09a34c7258e2 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
179,7 +179,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_ada=
p, u32 eeprom_addr,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p; * Returns the number of bytes read/written; -errno on error.</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u8 *eeprom_buf, u16 buf_size, bool read)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; u8 *eeprom_buf, u32 buf_size, bool read)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_adapter_quirk=
s *quirks =3D i2c_adap-&gt;quirks;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 limit;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
225,7 +225,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,=
 u32 eeprom_addr,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 eeprom_addr=
, u8 *eeprom_buf,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bytes)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bytes)</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_eeprom_xfer(i2c_=
adap, eeprom_addr, eeprom_buf, bytes,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
233,7 +233,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 eepro=
m_addr, u8 *eeprom_buf,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bytes)</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bytes)</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_eeprom_xfer(i2c_=
adap, eeprom_addr, eeprom_buf, bytes,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false);</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_eeprom.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6935adb2be1f..8083b8253ef4 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
28,10 +28,10 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 eeprom_addr=
, u8 *eeprom_buf,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bytes);</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bytes);</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 eepro=
m_addr, u8 *eeprom_buf,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bytes);</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bytes);</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #en=
dif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB5257F610E24EF0C1E055E5E2FCE92BN9PR12MB5257namp_--
