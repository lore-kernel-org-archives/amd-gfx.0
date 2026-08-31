Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1C1C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 12:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6AE10E7FF;
	Mon, 31 Aug 2026 12:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="31dENhgF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FED210E7FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 12:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndMjsynOAvNecOWCSum0kbzz3r1N2T8h/XyGW6T7vrixiJO7uqNbv4LX2lW1LjPuo0qSrxxxWPnPpZuEs2JCOtwIwGye8c4XAOGG9qyCPuBJjA7UXDEyWE6iMiFQaaMs1nQQiqRxLClKc1XJGc6sd3eWNugKXoEtt2P/MN2D97ikGL8A9o8aX3yEx+FehostWNhaGy1igbbdAvmakhfRxeuMEo5JN2x2ek9zXK0RnxNQX5YcDQzFVjtGJhRs2rFC7jsivlde8vC7hfAMlNhfsvjPSdkQqxmAAStthTiLfI2dVNTt5bF0sYDfQLbChLDtANRkRYxMCpOEq4liv35bYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8r8qtJh7YTQ25TaSEMJ62UOHulLdhVc0mr7jbbJh5Y=;
 b=QUvEsOuT9qS4lw8bhRaVf/vbHCWxzM4yTyQSokuD4fBm0/cJay5qlLEkiyIjdrjTNyMfo3drWbR6IB3gSV209JGnA1NMUAZfHm9j+YcYpfNeAWxcc19gUWREc5EkBp9NQAPrxUOsieNCng4PR84+BLOyh8z+psiSSKaiHf91szzqdvzUJ+hSocgbj6FtlPL5v8d8PeeW+dB/7uU27xQjK+24tpjydGY9eZm5y2H1zf3fQlGMKgMVDr5wZ7X+8LvuASTRVLqyUKdPx7iX6zqKTB1SMaQB6sEEbW3KIk1OeMKy/U6eEjHtr3JVdkrU+agXsNvkzi5Qu6yY42llJtjckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8r8qtJh7YTQ25TaSEMJ62UOHulLdhVc0mr7jbbJh5Y=;
 b=31dENhgFpPKg4xIk51eKsFoheP9qNtA2pbFeYdSVgbxUc90EdII9SHhYv647EGN2qCgL3DVQjcn1pfWF5jI+RlescXgnUfR/WuypiAorgLmDlVKloLXY16DojBRreb0jlyRgUzugc+o+mZNF1QSTqLDjISLQYimg9kWOiBlyfQw=
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 12:03:48 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%3]) with mapi id 15.21.0360.006; Mon, 31 Aug 2026
 12:03:48 +0000
From: "Zhang, Horatio" <Hongkun.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Morris" <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip IMU microcode request for GC 12.1
Thread-Topic: [PATCH] drm/amdgpu: skip IMU microcode request for GC 12.1
Thread-Index: AQHdOShlNIZL1gLJJUWbKdBH7rnyvba4DpuAgAAAPsA=
Date: Mon, 31 Aug 2026 12:03:48 +0000
Message-ID: <MN0PR12MB5761A5143C36A07F33B3D204F7A92@MN0PR12MB5761.namprd12.prod.outlook.com>
References: <20260831090909.30544-1-hongkun.zhang@amd.com>
 <BN7PPFFF39339DD4F2C037469B49218FD43FCA92@BN7PPFFF39339DD.namprd12.prod.outlook.com>
In-Reply-To: <BN7PPFFF39339DD4F2C037469B49218FD43FCA92@BN7PPFFF39339DD.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T11:58:33.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5761:EE_|SN7PR12MB7883:EE_
x-ms-office365-filtering-correlation-id: a80d5710-5d70-46ea-d26b-08df0757ea1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: pUOIt+6p7mo/liUO5Uk1igdLOQkqH1aP+ro6DztgyAPK0jzDMVMqhZ0wN2SI0AzkBjd0K9jQEH/nUBwJPXWLY9tI9SGhxlRo35J40PCMUS5bQGfQ/L5kQ3lMctyBbHJuynQotyJ7a1fmjgIG+00XdNpEmNmA8Ikoh7MIPxXaSpVg1/gIafZxro6PbXcCRw+m7FpqhwqvzmEb//B3LxyVa/8Lx+JkuPzVJ4wzMS9ARZFwbWoQnF0LqFMCMAyppf+kkeT7UmraneOl0VZayYZAH6v/bOOdMuofEWfjFpP7i1kk28Oqjqcq7bP9wo+bDR+8xzVxLsRn8oGKj0BdP+beRjwGlpuHUInx6Zyjl86vGqzqf3/8j3lGRAuBq3DdHKpMYFAU/dWalyS9Elws1YhbaUm27i4rgnJDxypStPX0utidD6Hgyh36elzGm6/iUDayxpNDjRhCGjZLVpYN4omxsrzmAoByc1+iFCasOEpwRo9N+WngYoUvm8tbJt5sLhvJpC5r2XMT3OvC2omKHI9b1fsDjKUW5kBK9xFMhHTZovBcG0CbguRZLUL1XBLeK7WDKm/SvYrD9o6/tayS3Huz/851gvRdTQG5rgvVeLGzpz353RwH+KmqskT0MBlUxzXjyK8bHUbzzIWO5XAzuOf/zVrjclWnbVvTVpFhGRrFxAJaFadXnC4DPEvHVxJCfswGPqMwLUPzcJb/WSmFtMKMqg+xAh08tzN5Y6DdmCVCJDU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7FUq2yGw1/n/MFRKAH7QHoKnBw9VGWMgHQV9crwsL4PRjGHdI+XPesRM0c1j?=
 =?us-ascii?Q?fAAGzqthYiF3Ft1vFlY1LyUJDWBs7x0hUbo4Tyhbomu+pqMffHvs2zqTAhrP?=
 =?us-ascii?Q?mA0ke0x9xVAoJO/iJVXlhkdSJxn7kDdyHn6bi2uj7EbAxOZNNrFZH1534p3I?=
 =?us-ascii?Q?6KPCRly29EB14GgKp9T8asFwO0Ew0hspTfwRMz18+VFQpgEb3ZHLdNXtXuaU?=
 =?us-ascii?Q?FG/9JoH7h/z3V/44+/krT2hXpVpC0WsGa84iaURYLJ1J9bPLgu3YaqG7zZtA?=
 =?us-ascii?Q?cI82K5PTFITRJ384rMrHS8aZqN9iIAHsGwZ1Dzo5dQ2+CYHC6qcBndl/337Z?=
 =?us-ascii?Q?uedEtTdk91OhFN2XaFsv/orvY6DT2HgQmcK6xD4Ao1kPoeEEt9c0hwamf+iN?=
 =?us-ascii?Q?AhzRkJtFHSyoE0vD6I4LuKmA1cl6ms+kToq/bP8owjFKiLeEv7iJ/PDBUNhw?=
 =?us-ascii?Q?epzdQKZkywFZI3SynYyI6oFRiORJYE7usTJ3liCerI5zZMyxeDKZm8qqv4fZ?=
 =?us-ascii?Q?cRDeZZPaq1aV1qAVHojdkXmw9vUU2gfXnG5H8sHuG9n2qQdc3HHafwsDwhJe?=
 =?us-ascii?Q?CNVU7jAnayHn//tkOR3zDEC6XQSAq2QBor8cKK/FG1mqtsmEm5IdHesZ2spF?=
 =?us-ascii?Q?jUcTep///FHqeY/CuM2UwJ++S8EjVd5qa+HelC+VDfU/7vEytDHFFdUW0DY6?=
 =?us-ascii?Q?jccdaEzI3MgcdpMISXe9qGXn7L3z+O/WnO5bXd/chbG3GgP8otFfj/g+Aq3P?=
 =?us-ascii?Q?LXQ00SiqKkATtNrzb2v61aoVlbIURpKCrJPcS2iI6bb5BWDYdwm93Vq6ntt3?=
 =?us-ascii?Q?B54rhyNkkHeJbCTd93AvB1ra6Mf2x3fADZqKekzoL8bBP1OUgRcZpSE5qfTV?=
 =?us-ascii?Q?HwC3XmirDXN5VL5FhTQXSFhzgzbsxwHW6BWG6NlQoUdm2kugbWKul1YJWo7A?=
 =?us-ascii?Q?wygQdLQuSbtqFapIAt+9DsAKxL3oMWu5QMh5IGoo4fGJAA9UDNt/IxPtCHR4?=
 =?us-ascii?Q?juo/6PEbjnEZH765y5fhPny9n567RJUv0GyRGbG1yZ7AsCFDG1E+H4ByJQjf?=
 =?us-ascii?Q?E0zeVC+S2sSkJOG6tnBELuL42KV2fdFriNhjoK7PF2KZ8Yh5S73AukoR9TBg?=
 =?us-ascii?Q?dULd+bSfEnVQH5vU80B+PRn/aGlCBoexV4efJlaVKtnUPkbOy1JSE3sLF07s?=
 =?us-ascii?Q?3PWYbJoII+/LzcTlEg1o6hgM3S2OAaibi5N3GZiQ6g+xkGWlrMMVpA+MoJpA?=
 =?us-ascii?Q?yRMBVAhVkCM0PxX5x8m5xYfSm3w5luOIglv+GE+aQKsmL2TCj1tBKIenRVO/?=
 =?us-ascii?Q?c4FY3jITB0bBGdt5fdD23hyDSNQdgFaJ85XEpTRF99FiZyYuza17Z8gyy2XY?=
 =?us-ascii?Q?WtS0zCOtJ62DZeK7NUzdL31WaQaFpE6b2Y8H5w3rTON0ci2WOBmHOhAIXUCu?=
 =?us-ascii?Q?VxK60coA3kNZB2Co1KtSNgDZsVAQxbdeo9U9yQDf3JQzzMuQjDD54YwJyl/X?=
 =?us-ascii?Q?OYxtO98z4ca3Iinw4V5eUi4gVYyXlsH0S3DDFFbl59b3cO4wLLFNJy/kZtxi?=
 =?us-ascii?Q?9gUn6qR+GpCnfucGRv/KJGKjicw9404lpW3CS5ZeyA1l2L+UBGv/jTw7mZCT?=
 =?us-ascii?Q?s6gyDmfMVq2J2QOAjkUVG82tapIpPBl8Zalc4G7gLY+kCLYCNu+l/mx0Y8zy?=
 =?us-ascii?Q?zUycbiYCc1SBR1Ft7vHVhYwIB7+1TeNKPIqUgkeOCjwCNkgM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80d5710-5d70-46ea-d26b-08df0757ea1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 12:03:48.0654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mVe2SEn7Y7zaYc30P6paoeLyw1S8oQZ3+xovPjIFB/KC9AvGKblaZ3nWjQjtfWPzlmEGPl5wwzphq/I94DL+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
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

Okay, will do, thanks.

Best regards,
Horatio

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, August 31, 2026 8:02 PM
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Morris <Shiwu.Zhang@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.=
com>
Subject: RE: [PATCH] drm/amdgpu: skip IMU microcode request for GC 12.1

AMD General

Feel free to remove MODULE_FIRMWARE("amdgpu/gc_12_1_0_imu.bin");

With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Horatio Zhang <hongkun.zhang@amd.com>
Sent: Monday, August 31, 2026 5:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.=
com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: skip IMU microcode request for GC 12.1

vBIOS has the support of IMU firmware. Requesting it now fails and aborts G=
PU init:

  amdgpu 0001:01:00.0: early_init of IP block <gfx_v12_1> failed -19
  amdgpu 0001:01:00.0: Fatal error during GPU init

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index 82ac39239d78..db06360873eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -581,7 +581,8 @@ static int gfx_v12_1_init_microcode(struct amdgpu_devic=
e *adev)
        adev->gfx.mec2_fw =3D NULL;

        if (adev->gfx.imu.funcs) {
-               if (adev->gfx.imu.funcs->init_microcode) {
+               if (adev->gfx.imu.funcs->init_microcode &&
+                   adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
                        err =3D adev->gfx.imu.funcs->init_microcode(adev);
                        if (err)
                                dev_err(adev->dev, "Failed to load imu firm=
ware!\n");
--
2.43.0


