Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49274C61DB2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 03:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59C110E186;
	Fri, 13 Jun 2025 03:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFPYEOy3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521BE10E186
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 03:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5ku2Q31aqtx/iqT/XfzwK46sR88L2KfdaTMee574sYajd8Ja/+STBB/Z61pGGoOHFBqG9+JaMGNWCay/s6T5aesf5RDiyYQKbzz7idVDw8y2lwNZR074+N6WXEqJUDqX+iW+0ZdJ5Q7KUtz26GSbRUbfRUfILxzFgptRFdBiGjlS1pe9/aq/mAHcogxhhHifOH0S7qL9B+orzfgCJlmt9HX0EqPIbRBR5XXBJsTN+0+DcKUaHfgDYAg2jI7c8I7Mhdtc8RbCMQ8LWIEmoHRNC4nbdll5/HvPPFUYBKIzvYFRe9hEAJZH2JK4dMO8+sKqOiVU9f9/QIKEWK9q0PSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQfBfGKA+vZ3hzXE3B9L/xwR62qdTuAekOuBFq2cDys=;
 b=uj4XU1JoiZcrQS/BO47JFwUfB8mu9drVZTZnt7CMtxv/6aSbGJ6Pd5kN40hdXMq2N5y5v1m9LOeYG0SoJ/EN2m5O5JBkUlLwAufN0HCn8xqNjgLQjefMRJtyidD84fddVPArFl5l5QNh1NZa2rhdH8+SLDyopGxZZSZ1nJCq/T/TxwEv0yAmxCgBKfg18HkmVLbnSfuIRyojmVjyPAnVW5xNWvIgqs8WrFHcbwaCMyG6REXNrErCCITra33gX3swx0sCfW44xgETP1i3IMfbV2RGWJzUp33GNLUGxZrK4XobntS1jw/+UuzzP06pK0x1cI+lg75mnce0RvUCWlTNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQfBfGKA+vZ3hzXE3B9L/xwR62qdTuAekOuBFq2cDys=;
 b=YFPYEOy3kKvXZj7WJ0+0rtNx7jvtDLDGh2rdr1mSU5a6WQW8wXk7mJaXvK//Gokyy5yQ2XubmkTop6T7Ikw6Zk6wdWL2f2Wnj/FfhTCHOwOgfXtGKCpJwHn/GR8WiUf/lkRrpjxRr9QFNduw8JCnxffnXYCCAIkolyEaZlJXjlM=
Received: from SJ0SPRMB0087.namprd12.prod.outlook.com (2603:10b6:a03:4ee::15)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Fri, 13 Jun
 2025 03:59:48 +0000
Received: from SJ0SPRMB0087.namprd12.prod.outlook.com
 ([fe80::50a1:7ed5:ae4b:550f]) by SJ0SPRMB0087.namprd12.prod.outlook.com
 ([fe80::50a1:7ed5:ae4b:550f%5]) with mapi id 15.20.8792.040; Fri, 13 Jun 2025
 03:59:48 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Thread-Topic: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Thread-Index: AQHb3BBE0mHNjxthI0anCGsQ6Zd8UbQAdNOAgAABpsA=
Date: Fri, 13 Jun 2025 03:59:48 +0000
Message-ID: <SJ0SPRMB0087A2BFCB7BED96C79DAE48E577A@SJ0SPRMB0087.namprd12.prod.outlook.com>
References: <20250613030636.188030-1-ganglxie@amd.com>
 <BN9PR12MB52575B4796D7E46E3DA1B5F3FC77A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52575B4796D7E46E3DA1B5F3FC77A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-13T03:48:05.9514735Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0087:EE_|PH7PR12MB5596:EE_
x-ms-office365-filtering-correlation-id: ec615509-9553-4147-7a31-08ddaa2ebdb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Itq5cdN9ivejZt4bJfLCbXDAFearspvsrwOkdgnDFbdJ3Nc+c9R/eLTwr8Gq?=
 =?us-ascii?Q?9NAKlvN0mtqCs462TLIv5Aj3A2xrcNFzNJ2xK4BjrWSFaXzTOqTyuj5rTs7t?=
 =?us-ascii?Q?YNQXN45nMndcZQHxDUORfSqL7LrkYGm7zKdQl4R1CQ74sq59feZKBnvBy2Sb?=
 =?us-ascii?Q?RhX6GlmIBQomc3mF1+ViLsS404Hil514fmz4Y7sCmCszYDwlTppDc5ZdL+FM?=
 =?us-ascii?Q?OoOE0RF9zqJZxS8E71SDRPFDXfCVMPq32/v8yVJ6ZwlprJf+rRCF2hCs7Ykd?=
 =?us-ascii?Q?KBNNRSb4Jf8uSqPiL38JHwqtR4qke7VL/UAzqUFMOfSWh1cVDAKZHCFghxQN?=
 =?us-ascii?Q?SyK+uxH3mRpw4h5bWTiJU55F7W7Roj0yZFahAwOUGKgd/F410aVLiFCOXO57?=
 =?us-ascii?Q?IN+4JWdMxBTWbr+3S3JpEmek5iVTYGi8bwBfQTaUoOQyoI9GEvitPig7mPLA?=
 =?us-ascii?Q?/U4xouvfG0Vps0eOgt1Fbc4asO0owHUs/oHbpk6McielEnXcB078N7QmJWL0?=
 =?us-ascii?Q?bs2N66WSNp1/R+jaErRH5y2O8ZjJWChUkYC8vkxOo/QDhGiERU43F6pc9xVh?=
 =?us-ascii?Q?EHc9sGZIF4pc4woT/v7vUdNmSrNAtvH0YQ5btHfMPy5pqbkGrcYpXn3JCThb?=
 =?us-ascii?Q?WyYQTALxpGOjr23MqVwvMg/qDhG83XxlMfjja/w/nUhOD4MgB2q5GjsboXNQ?=
 =?us-ascii?Q?YWoRaHXjg9kewxjOKVi4x1I9DD/3nJZNRBhfZAnSyF7/7zbjnJR6TkSjYZ8m?=
 =?us-ascii?Q?oy5GvfX22H+iIiarRHhzq88qb33bzuZxIIyOXsB/l77W/F0ZxSDlYjwsngK6?=
 =?us-ascii?Q?Kj+qfxfKDaR2zHxcrfJy66N+dqy0PrP6e1FFmakzA5JssTWvkMkjHEv/zb8W?=
 =?us-ascii?Q?kpLKTKIkECavT26dbnvJzc01hpyhUTwKTmFO9odsQ+Ij3cP4j3J7JQiS+b+V?=
 =?us-ascii?Q?/AUsd30R36lCWweEuAYdUT0ZRHGpmp1X/VUUCfbZyfsHjPZkvdeJ6jdcSX35?=
 =?us-ascii?Q?hJV9g5pCnlZGOp20pwoDBDSY2BYoVCITWye9K2zpr2/C49Vmjux13c1Siw+g?=
 =?us-ascii?Q?KGFdWVTmGZxQkfqN2XDjUgkua210EQ232HZSyNtqcuM7f+KGOY6u09AxZvM2?=
 =?us-ascii?Q?8BdV1P70ZSejJcZUypj36BYMjAv9V9YZpZhx1GoyoLGVz4r+tjuhFW/o2g3O?=
 =?us-ascii?Q?omO8X6qyIc1WK4taKWEXi+HYv3E9LM0GFiG765ntPcGCnzpuBTe2zMsBi+dD?=
 =?us-ascii?Q?KPjeSNxfe4E8rNU02vtVwPQxyPToVCytDXq3bJuBMKMqLWN3qUDzaNHYAkKP?=
 =?us-ascii?Q?8dApJO5ExcmEWSz9BDfrb8O9LX7E2OcP4g7z4+ONRpErDw0WXKHEJz99tcxj?=
 =?us-ascii?Q?4XLvLqN9qY8zewzW6C6T5WsGFei+mhvfgObsIcWaNSlvEJgXhVC/vVMJ9/Ad?=
 =?us-ascii?Q?eQRcTKgxRaI5+cT0TBChIpXPlOnBKDaPYa5iYgwktrP7LAdWkr4alTClG4V8?=
 =?us-ascii?Q?bTYdY6XMKiXMq2E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0SPRMB0087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tSjbW0bXODdsgrZPed/PQ3yZQkCE0Ft4lPF/JHmgKjVbIb9jCmgzBRVVkM5x?=
 =?us-ascii?Q?lOqOit/bt/ztiWSq/2gAB7WNVc4aVWq1nqKHqMnBGoSXjbwUR+kd7y4NhLqF?=
 =?us-ascii?Q?RSNHi+NtbBkeNoAC15WEZU+wW5G9MDfPMH2BwYN0Z5YVTO0JLlMhuq67Z7Ii?=
 =?us-ascii?Q?FY/Kj6VLAJohjqLDuJ8qch7/S33ZWiuVe4TUvZ9wrGp9ERoDiEbel/epl9ls?=
 =?us-ascii?Q?dK9U8afChI270DvlZ0luf3IYeW8n2NZj7hQjvomcu8aDGwnQSgbMVjHocu1g?=
 =?us-ascii?Q?sUbMVufPDTdlqbweux52oViX4YjGMMwANOsNLyo2fVbSLq832hLsC7JIgLHr?=
 =?us-ascii?Q?lvJiE7saQ9R68bKm+xVhH9/YMXZU9a2GRUFpxYRGXiD4PRIXBkwaRaBBOzIJ?=
 =?us-ascii?Q?qvgOLQMzlDhZnSDbhpXUrOwUufmBVy95f7y5qgbTpopMLccDYExVfnuol3ro?=
 =?us-ascii?Q?jBEzYMFCjpBkTw3IqybcvR6LBRQ0AJ09pHFg3B+0X5+u5OCeG54obpcAAHU/?=
 =?us-ascii?Q?hLK73OnPrCbGm6RRcYRfbotMdkzSPWp7McW2IIytqUvrZ7xFGVGplMEAqVE1?=
 =?us-ascii?Q?nS/WWZcQFHfgstofSsadq42B6O3VIjND2J8N+8BaI7SPD2REc8jMyEn4xaKb?=
 =?us-ascii?Q?X4j6yyTXxdHChwz3iNeDTTc4kWNME3VFPe6bT1ML82boRBbMZiHvwsfb/iYf?=
 =?us-ascii?Q?dgI3xejFhRo5/9eNmOSFy913fT4u1aoYUSBpWX8zuPFeIdhwxIkw564kDr5K?=
 =?us-ascii?Q?UVpUZD5cHsX0E+vWoVQN+qXEyUvbaclOgwBasMS0vlS0qHTdOiAh5pmkKeXL?=
 =?us-ascii?Q?JQDJP8MzPh7Nxi4Eo9oKBEKCniT3ilK9FhQiQjlOMI0K0Z8Rz7I4sYDJqX6H?=
 =?us-ascii?Q?FJbTPtcXUV98c+QP96qqL3x/MW106Xj7X6ZJer22KEW7go+wDktxYsf0yQtu?=
 =?us-ascii?Q?W889ZTUbf1u3cZs/wmOLaReBGHf2x50eqL4KCQAICyGL0vcVh5MKApkCkJh+?=
 =?us-ascii?Q?6nZZOP1jxAcrwJkGy2url1wSQ765phx2z6BgyX/ttr/OIp8W1hK9zvmbPfGA?=
 =?us-ascii?Q?CjsjdmQu4wFJCArn11UicF+ei/NZ3QywhKBeKNsjYubrUqqNUPi9rjdXqgGG?=
 =?us-ascii?Q?ebVB9nkyP9TxwDmBVUckzQCv8XLOQaDH66p51iWguAy1I8hhXiY0AzPbuy03?=
 =?us-ascii?Q?p5273Fdp97bohne3injcxAwzGt2lwjN5FLaXqfPVtTZU3W/jvrVOrzdyYS0F?=
 =?us-ascii?Q?6PLG/87C//ZIZrgESfTS/5DPPUPyaOhY2AVucsjSZOQghog4l29q96r8l7dB?=
 =?us-ascii?Q?gZMbuqzeoUrWsuawOlkX7wW5gL6q9c01dvaHRtujH92CfBkFDYjL07B1GAVG?=
 =?us-ascii?Q?vc1u6Rx4ASMigAXoWEc40c8ijA5RRI4E4fvZ1+IfzDQ/TCgJcUWMk8pNSEca?=
 =?us-ascii?Q?ziLe4hVu/Ap84+6XSTOB8d8zpu2FoFRyveaDJA6AgESVABHfXjVPzXnohJsC?=
 =?us-ascii?Q?BqFAv+/Fq1ZMyr5dcstwQHYugA1sqo6t0DOSkYDbYMxpOkU8rfxxnomDiN4W?=
 =?us-ascii?Q?rxw2hfXmKDIzEn8n+0A=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0SPRMB0087A2BFCB7BED96C79DAE48E577ASJ0SPRMB0087namprd_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec615509-9553-4147-7a31-08ddaa2ebdb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 03:59:48.4480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va/ADTS4QwS9Cmtlx/55ry9jFhAURWmz4+Bs0l+W3+KXEG1J/PmJoQNEjS8j8m/3aiNnLSBLsjPUwMp7t/7xcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

--_000_SJ0SPRMB0087A2BFCB7BED96C79DAE48E577ASJ0SPRMB0087namprd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Sorry, it is a mistake, I will get rid of it.

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, June 13, 2025 11:52 AM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
Subject: Re: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold


[AMD Official Use Only - AMD Internal Distribution Only]

                         if ((amdgpu_bad_page_threshold =3D=3D -1) ||
-                           (amdgpu_bad_page_threshold =3D=3D -2)) {
+                               (amdgpu_bad_page_threshold =3D=3D -2)) {
hmm.... Is it fixing code alignment?

Regards,
Hawking
From: Xie, Patrick <Gangliang.Xie@amd.com<mailto:Gangliang.Xie@amd.com>>
Date: Friday, June 13, 2025 at 11:07
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>, Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>, Xie, Patrick <Gang=
liang.Xie@amd.com<mailto:Gangliang.Xie@amd.com>>
Subject: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
when amdgpu_bad_page_threshold =3D=3D -1 or -2, driver will issue a warning
message when threshold is reached and continue runtime services.

Signed-off-by: ganglxie <ganglxie@amd.com<mailto:ganglxie@amd.com>>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2ddedf476542..a9246c53bde9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -763,18 +763,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eep=
rom_control *control)
                 dev_warn(adev->dev,
                         "Saved bad pages %d reaches threshold value %d\n",
                         control->ras_num_bad_pages, ras->bad_page_cnt_thre=
shold);
-               control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
-               if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
-                       control->tbl_rai.rma_status =3D GPU_RETIRED__ECC_RE=
ACH_THRESHOLD;
-                       control->tbl_rai.health_percent =3D 0;
-               }
-
                 if ((amdgpu_bad_page_threshold !=3D -1) &&
-                   (amdgpu_bad_page_threshold !=3D -2))
+                   (amdgpu_bad_page_threshold !=3D -2)) {
+                       control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
+                       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_=
1) {
+                               control->tbl_rai.rma_status =3D GPU_RETIRED=
__ECC_REACH_THRESHOLD;
+                               control->tbl_rai.health_percent =3D 0;
+                       }
                         ras->is_rma =3D true;
-
-               /* ignore the -ENOTSUPP return value */
-               amdgpu_dpm_send_rma_reason(adev);
+                       /* ignore the -ENOTSUPP return value */
+                       amdgpu_dpm_send_rma_reason(adev);
+               }
         }

         if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
@@ -1509,7 +1508,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)
                                 "RAS records:%d exceed threshold:%d\n",
                                 control->ras_num_bad_pages, ras->bad_page_=
cnt_threshold);
                         if ((amdgpu_bad_page_threshold =3D=3D -1) ||
-                           (amdgpu_bad_page_threshold =3D=3D -2)) {
+                               (amdgpu_bad_page_threshold =3D=3D -2)) {
                                 res =3D 0;
                                 dev_warn(adev->dev,
                                          "Please consult AMD Service Actio=
n Guide (SAG) for appropriate service procedures\n");
--
2.34.1

--_000_SJ0SPRMB0087A2BFCB7BED96C79DAE48E577ASJ0SPRMB0087namprd_
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
<style><!--
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
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle21
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
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Sorry, it is a mist=
ake, I will get rid of it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Zhang, Hawking &lt;Hawking.Zha=
ng@amd.com&gt;
<br>
<b>Sent:</b> Friday, June 13, 2025 11:52 AM<br>
<b>To:</b> Xie, Patrick &lt;Gangliang.Xie@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Xie, Patrick &lt;Gangliang=
.Xie@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_thr=
eshold<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if ((amdgpu_bad_page_threshold =3D=3D -1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (amdgpu_bad_page_threshold =3D=3D -2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold =3D=3D -2)) {</s=
pan><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-se=
rif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">hmm&#8230;. Is it fixing code alignment?<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Regards,<br>
Hawking<o:p></o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Xie, Patrick &lt;<a=
 href=3D"mailto:Gangliang.Xie@amd.com">Gangliang.Xie@amd.com</a>&gt;<br>
<b>Date: </b>Friday, June 13, 2025 at 11:07<br>
<b>To: </b><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc: </b>Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;, Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.c=
om">Tao.Zhou1@amd.com</a>&gt;, Xie, Patrick &lt;<a href=3D"mailto:Gangliang=
.Xie@amd.com">Gangliang.Xie@amd.com</a>&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_thresho=
ld<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">when amdgpu_bad_page_threshold =3D=3D -1 or -2, driver will iss=
ue a warning<br>
message when threshold is reached and continue runtime services.<br>
<br>
Signed-off-by: ganglxie &lt;<a href=3D"mailto:ganglxie@amd.com">ganglxie@am=
d.com</a>&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp; | 21 +++=
++++++----------<br>
&nbsp;1 file changed, 10 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index 2ddedf476542..a9246c53bde9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -763,18 +763,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eep=
rom_control *control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Saved bad pages %d reaches threshold value %d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; contr=
ol-&gt;ras_num_bad_pages, ras-&gt;bad_page_cnt_threshold);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; control-&gt;tbl_hdr.header =3D RAS_TABLE_HDR_BAD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (control-&gt;tbl_hdr.version &gt;=3D RAS_TABLE_VER_V2_1) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
rai.rma_status =3D GPU_RETIRED__ECC_REACH_THRESHOLD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
rai.health_percent =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((amdgpu_bad_page_threshold !=3D -1) &amp;&amp;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold !=3D -2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold !=3D -2)) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
hdr.header =3D RAS_TABLE_HDR_BAD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (control-&gt;=
tbl_hdr.version &gt;=3D RAS_TABLE_VER_V2_1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_rai.rma_status =3D GPU_RETI=
RED__ECC_REACH_THRESHOLD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_rai.health_percent =3D 0;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras-&=
gt;is_rma =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* ignore the -ENOTSUPP return value */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_send_rma_reason(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ignore the -E=
NOTSUPP return value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_send_=
rma_reason(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (control-&gt;tbl_hdr.ve=
rsion &gt;=3D RAS_TABLE_VER_V2_1)<br>
@@ -1509,7 +1508,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAS records:%d exceed thre=
shold:%d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;ras_num_bad_pages, r=
as-&gt;bad_page_cnt_threshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((=
amdgpu_bad_page_threshold =3D=3D -1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (amdgpu_bad_page_threshold =3D=3D -2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold =3D=3D -2)) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;Please consult AMD Service Action Guide (SAG) f=
or appropriate service procedures\n&quot;);<br>
-- <br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SJ0SPRMB0087A2BFCB7BED96C79DAE48E577ASJ0SPRMB0087namprd_--
