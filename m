Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8D3FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 19:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7793A10E2D0;
	Mon, 27 Apr 2026 19:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2EBRLG2i";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B5A10E2D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 19:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR1eS0nqu1OWAzcIi2wvagUILDycvkWV5D0TdMoRznmLuhP9P+IDVxChifEqP8rHOU3q9A6temqMhjYRfxvD0OC6TH/VqQ1Mizj45n5ABNIOxxVC8Zjbs5cL91Np7REPI+7m6QQe443o7RO5ZguYqJ3m4wkeNr7MOQI9/ovPhLk4YrUp++CI+7tzwRh42neNv4xFt6IxrS9fyxq97eNPh14s3SwgECO6hVQtLfoQ3ZVRIx9bai3MFaPydA5fUioAAefFqKmZfA8O+GHI5Elp8lzgIL91EOUKr7FO75fe7eQDxG3J1Y5RZskqDCWUU4NOJiEWfi2Ymx4oEAx+Ex+FdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeKLIVg88NbE1oomkhN4TVVk4xZ+pZ73nkKuTMlgLBA=;
 b=epf02/sJs/E8VibH9qGk4gSxmMwzM1vMDNVsTIFTxpZ5UJTMQNJKk2QPKXpuLmu8JaKGWyl92SgU8mVpZV2ByksYcnowOvW4GNLQJXS1IE6BUf+reRBeTsDXvjGZWdMkhwLrhRKiD/pAgmIh6Byi5RhUmoo6L5gLhufogW3FbvM6mTfR8ZFgYr9GM9JMfHEoynxyrfPL+E2Nm7/XI+SAKcgZWWkhY78BtsMRFLENnGC6xrAhSotiybwdSFf/MoU+XlqeVMPkOv0FKF5f6HodXq3cMAX2j0jBZ+KabCb/oiREZTdPCH7bhylHL0iogIDLzJDTCre/V35cM+D/v95LBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeKLIVg88NbE1oomkhN4TVVk4xZ+pZ73nkKuTMlgLBA=;
 b=2EBRLG2ilgl7F95x577B1cwJzIOz0/GEt16W9HcG7/I+mOStgkqbA5kkgld0JmAxIMOqGwExHLuLNVSPBmqW6aguykWq+NN7bgrV+qO7wjKm9zU6N3DiN6vOcYDh5Q/2fldN9fkHB1cqy3UR7nCTrGWgZMIbScK1IFwkwqmRPn8=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 19:22:04 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 19:22:04 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Cheng, Benjamin" <Benjamin.Cheng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wu, David" <David.Wu3@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Cheng,
 Benjamin" <Benjamin.Cheng@amd.com>, SDL <sdl@nppct.ru>
Subject: RE: [PATCH 2/2] drm/amdgpu/vcn4: Avoid overflow on msg bound check
Thread-Topic: [PATCH 2/2] drm/amdgpu/vcn4: Avoid overflow on msg bound check
Thread-Index: AQHcy1DGWxtY65Myn06z+2+jdKDBs7XzX2jA
Date: Mon, 27 Apr 2026 19:22:03 +0000
Message-ID: <SJ1PR12MB6194B03932069B255E8F451B95362@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20260413142037.1039073-1-benjamin.cheng@amd.com>
 <20260413142037.1039073-2-benjamin.cheng@amd.com>
In-Reply-To: <20260413142037.1039073-2-benjamin.cheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T19:21:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|LV9PR12MB9805:EE_
x-ms-office365-filtering-correlation-id: 93a88ad5-6df7-451b-d770-08dea49243ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: JlLLGvQhk95L+5tGs3yMe6XGgzxFTpZ6KjJfZtn6VUa/aVrlIlHB8s14kl0GDAPiXPaLI7RTTlGdg2cjrWW0VJu8/Q1KzNf9rNbW9S5MYWrRMZdLuebk10ckAyshAygg5B1wvE7FQp5n33Vtvr8YU7OnQYlxarGKy5g28XpgAfcS1uPVwmc8ytrCuVIbiWiX8PWGWYRAbQiwEJewYYXH/yJMUK77IUqHDRDMM0uC8xhq+5KzElk5M8kVB/zpzRCRnmBskaO6FdftnZbCDhnV7m3X1qGp9GT/srgLRSw0duzGHYn/RWtC64tkiawc9WH2wd2hHs6A0OVTwECw2npBh7HkSwyqDTac84zhYNXSI01ZCucUG9kVVoy6+aYnmuHS8fxBIzVgQ22ILHadse5GMHbmZGFNe/SYNBJPsLbSICOUO3ZjwmC6GSxvkG8lUjmw6rx4stRObD5kUVunsbBS4Zkv8H1PCH5aot6LRqJr7bMNjdbvU6KYVTmJvgbAw3Kv3M6K3TFE/cqhiKWvweLA3ZDN+m5tcyBv9joY0yHV1LKpDeSnCSV3LoxnEFoxfgwuTGnAeqmt3bHJ5JAnZxU31U3oV5RRQ+ssdG9R0WLvMHAePu0gRJfoMDx43QPt1KMT7zh7xGXLJRQUcUY5T3zSkEZz4qauOc9WPzQFuYscqs4tw7Jsre5nXceKpGCWsEs4VXR456kL6OqMGA/3Jr58YXWDQIjNCDssonV0tOwnL2N2cZlcDy0Khy/QHuQysQ4Xl6NncnnLx7p5DwQWGlIukHwtU8hfelOa7ogRhqfHYzc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Bhw9Frv8Ndjm4DxYVgXdrPPeS06AlJrYXnIA0dp5emVW0Kj3TjmMhyiw6VN?=
 =?us-ascii?Q?4dMieZYZq1p0Gwgp/Pao0SFkHOjo6zKDWt2atpwTDgfjmBAjd7k7Pin/Q121?=
 =?us-ascii?Q?jp837S/hhsteGwJ/h8BH1CP/m6DZ6aWZDrMMR2ruxzjMs8pIL2vSyN3CmiTG?=
 =?us-ascii?Q?BcvxjH2px8IOHWFPFwtLkx/Uwi4d4inqoBL31C8GL9UnHtIlSZQaWGhuxbAy?=
 =?us-ascii?Q?L6dtPH/5BmWJGa2q+u8nN69DiQjczSnPUp+ew8QDvthKyDkhLpAz4LfKRI9h?=
 =?us-ascii?Q?eHr5GMEn5flWeYN/aJ3pnNyE5xMMYFo+3I8cdbB8lKmlxuYda3fK2r5sqfsZ?=
 =?us-ascii?Q?hgFgHRGW2L5Q1PJLxStN/YN8ubiMk8zQAmrPUjXAnDIRoKnFuP5An7FKB/n7?=
 =?us-ascii?Q?QvMOc6Qhoa2OgwIrB6GLzU7MMu69hMcqukP2B21htnw8YZ4sfOSzINBK+I4X?=
 =?us-ascii?Q?LUrgi+vVZu85dpSoSTuVrbvc/AgCgmoCZ5gqKbRrbeeTXXsFAVZUTBSmvrfn?=
 =?us-ascii?Q?uBqVwJ5EJIYRTVS380zfRBwqo9UtKSIR3IgAvM21oYwBQudakiR6mUrOM/wB?=
 =?us-ascii?Q?IJsE+Ju4M9esK068HBrvN7lFY9LRIemowo8yE4Dal5n6Ps0xr4lulBfVpLTO?=
 =?us-ascii?Q?fVhAi/EWs86m5I/NW+oksmsM+PbsGFgV25IuUlEkyR0ywOiCbniWmyD7uSWT?=
 =?us-ascii?Q?IhMLtOtoEGJNqnmzg1IMQJokHBF6ynhthso3jne+2E2UBmgs2q4QeKk24r76?=
 =?us-ascii?Q?nr+ONv72qvVfVnVeefYoCH3UR6HA9rn71Mar86lcdvBI5PXRAHgbsiQ9UDDF?=
 =?us-ascii?Q?Do66rXfK8cvU3aKgOUz5Q5IwSIUQOeBY/cEeqf4hJbYEPvPLHmUCEgsri8Iu?=
 =?us-ascii?Q?lvYFLgZ3xOgv6VmzhXM+PD6VgOpho8oSbAMeEbjCDjZHb2xUvFbUgpBkH6BD?=
 =?us-ascii?Q?/owO4MTgPaeVjGE4H1Wk/HYNEb6RBRY0uYbN2PUVVY6LNmVn9DV0NEEYgrJI?=
 =?us-ascii?Q?C9hxdyhNiv8n4BkAexFZQPWbysDvootlZI86Dv8JxXTYoxbUJcGHbeNgXjQk?=
 =?us-ascii?Q?5UAQJNmzNVTX4zDoG0WW6MafW10IxAqE5C+Maoth8/3FLUM7Wbn0oiUCcHqu?=
 =?us-ascii?Q?jT15CemUsayRYR/tMLUJfpRJXYR2RHVIocuTB/M8D+hdQPQiWeMOfe7XAR3T?=
 =?us-ascii?Q?qFnricxXUJT6Y/2yUCuHmYoofUe/2NbR1yoHux9auLaIrwbFI8TvDZgkaehM?=
 =?us-ascii?Q?I38QDawOUl8BK4H8HwSclekRnVB5fnTr5mPDSr32eZtQjfkRsLFahapOYNzt?=
 =?us-ascii?Q?wQvWIjkxXUQsDiwsrbzd7E2ekMkEoJGqej+ZEVV7JDII5+jTktXu/D5l5bdD?=
 =?us-ascii?Q?wFjo5h4XFfRiEkTGYV7i1TP9BGnbm7vYw5n07T0Z2NfXcS8wBqzc9AQyHkHR?=
 =?us-ascii?Q?6r6ZDUgZA2WUX+Vn0H+TxA+72qrSmCHaZjWPEdTULgaokZXkjC7e8u3etpHw?=
 =?us-ascii?Q?rF8hQDCh5GP1aX0iv/0ti2uGjNMOBMbtGy8wLb+1xeGo0GmzpDncpnTkxdVj?=
 =?us-ascii?Q?a0jfizuqU33QXIp9q4QCudo9D5+JcXOuawK8MnzApwAHnGxOuyk8vTDeLJuV?=
 =?us-ascii?Q?ZKGHFJoVz4mYqon5K7R2YYkASuaiKoRQrBNrm6gTmPrM4Uz+GyM7xDxGRuW0?=
 =?us-ascii?Q?EO184P8Fb3tw/+lJ7BXIJRKiZVdeMSpC7OelKSWYsEfbh2QQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a88ad5-6df7-451b-d770-08dea49243ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 19:22:04.0211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lazG1c8hxWwJnpJcKB2QozDP78mOg9uTxsAgl0KwCV3cOrPplbR7HEoqfjmWlYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

The series is
`Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>`

Thanks,
Ruijing

-----Original Message-----
From: Benjamin Cheng <benjamin.cheng@amd.com>
Sent: Monday, April 13, 2026 10:21 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wu, David <David.Wu3@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; Li=
u, Leo <Leo.Liu@amd.com>; Cheng, Benjamin <Benjamin.Cheng@amd.com>; SDL <sd=
l@nppct.ru>
Subject: [PATCH 2/2] drm/amdgpu/vcn4: Avoid overflow on msg bound check

As pointed out by SDL, the previous condition may be vulnerable to overflow=
.

Fixes: f405753b0751 ("drm/amdgpu/vcn4: Prevent OOB reads when parsing dec m=
sg")
Cc: SDL <sdl@nppct.ru>
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 5dec92691f73..63d37b475c2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1889,6 +1889,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *=
p, struct amdgpu_job *job,

        for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
                uint32_t offset, size, *create;
+               uint64_t buf_end;

                if (msg[0] !=3D RDECODE_MESSAGE_CREATE)
                        continue;
@@ -1896,7 +1897,8 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *=
p, struct amdgpu_job *job,
                offset =3D msg[1];
                size =3D msg[2];

-               if (size < 4 || offset + size > end - addr) {
+               if (size < 4 || check_add_overflow(offset, size, &buf_end) =
||
+                   buf_end > end - addr) {
                        DRM_ERROR("VCN message buffer exceeds BO bounds!\n"=
);
                        r =3D -EINVAL;
                        goto out;
--
2.53.0

