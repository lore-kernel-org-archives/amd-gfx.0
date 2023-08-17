Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB61CC5320E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 19:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1E210E02C;
	Thu, 17 Aug 2023 19:51:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04olkn2040.outbound.protection.outlook.com [40.92.47.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382CB10E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 19:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjjix/9wyuPxFtJTwJ6ogKufIN8Szb1JNo7qhnkqGGXAh2+zuiSSVUPnxwvL+yzt+ySjfDc9ReN7WvYei467Enipk8CpIhOGRULmcLlBa/WSSmcPh5ZSXNuFDIhzIjXaiDFzodSG9vf3xQHAcDWF1rLO5wqqP+ISGQs1y2bEViL4y4Op51GzDkcAf7HCansE2b8kpDdOZAzr9bkJBM4BFowN3yi7QzRCfoTp8nXqsXRPWDvN82yCnUTCDAL7obFWjD1kYVwzPUIwn3RUnYHsLYXBWkK5ragU9Ql6TUen7H4ze+gzEUZomQhGxL90PZrX0dW6fmeirN2e03NtV39S1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDYKRyqQeIcVakf5JbeBMfG39i9HpgL5ZrvkunO5PBk=;
 b=M41izN5xt46U9aMQDILKNeVzcJid+6qxeAeGKI1F1Antbe2c2R7ma69DFch55DSXnxyYjW3acW19EG6fni425P4h7Po8uoX2mdyfBeX4mtDvGakGlelD5WqIZfGjaQrNS6/U5TI9BQu27xERlnHJMinTZxaegG9dMhT6ANUp5pXi3fVMotBkFrSshaQ342AF/vCgSbdt5c3Nhagyzcj8mZWoTr/9h7wXEHvYbgpmwWR7Y5IXr3SxrDxJY27tWnRxr6vDFeS2JXQLz+un7bYksQRK9cc/QnryQThiqsTUomcXvx6GXQjrk/uTE8q8w3Lftk0DRNudrUXsZxmf0HwbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDYKRyqQeIcVakf5JbeBMfG39i9HpgL5ZrvkunO5PBk=;
 b=mufpnU/IIZ8TGabEhEoOYxJrtb/LFBJCJM4OX6tha7JVCbtlVX6etmmiOlNO1GEkJnsQsXJ+Cw8gbWkmtcsNnNHnPCgbBnQBC8uHQlFnVt++YydQxMYbjsTg9+6AsQ3AO7Z171+jLtf3MI82t+XnrKtfKGrhrNeBUAYJL+HJf7EthZaP/Ta9pwzQlC7M9BMi6qq1luNlIWkmi7r2Ov8brwN+JHcLGX51iRej9EjXZN2krD5z8hbutYTIRxbZ6amIanHRQKdXguhul5wTDD/nlqS0Qs7SwhchxAtR0WPnntP3yHI+P/zzM8cgEx8rDm5hcCMlyHPdBWExuBSavVSHEw==
Received: from MN2PR14MB3328.namprd14.prod.outlook.com (2603:10b6:208:1a8::13)
 by PH0PR14MB6614.namprd14.prod.outlook.com (2603:10b6:510:29a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 19:42:12 +0000
Received: from MN2PR14MB3328.namprd14.prod.outlook.com
 ([fe80::124b:ba37:a62e:3af8]) by MN2PR14MB3328.namprd14.prod.outlook.com
 ([fe80::124b:ba37:a62e:3af8%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:42:12 +0000
From: Joshua Peisach <itzswirlz2020@outlook.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu/amdgpu_ring: match type used for loop counting
Thread-Topic: [PATCH] drm/amd/amdgpu/amdgpu_ring: match type used for loop
 counting
Thread-Index: AQHZ0ULhIl9lKIVZCk2BhG9aPqu8cw==
Date: Thu, 17 Aug 2023 19:42:12 +0000
Message-ID: <MN2PR14MB332833921E3C32103154BB23B21AA@MN2PR14MB3328.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [WSzYt4qg2rNI6TL/k4O61QTMfW0gKxAb]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR14MB3328:EE_|PH0PR14MB6614:EE_
x-ms-office365-filtering-correlation-id: 24e537bd-8ce8-422d-8a52-08db9f5a0d71
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vmIFq49QbTycUzymDmMcvWmcwpFU9Z+v8Vgmdc/fpuit/lq7pl1mZ3iJCRPw/82aF3fWlipHvCl1HfVUmPTZMsZzGyc1Y/Fpm25ynwiBs/VbxWEhNTrTKB5i61aOpuA3mH7iMECL6fKpdrEJ30xszTG3M8r4GxcCRtHd71+R3iD1GPAh/uZBDn+KnIE+/ji5rczMSqVfhTk9sj6K2BrwU5EvqlMcEobChlqoS+HNyRPFT2YvnnYH2Qr990R+irN7/JLismPRe3J6X6XIaq8gFhDdU8bGIE3T5mVRV7j6+Oy2l7TetNtudQVzycdzkv1PHTS2X/f82c3gKfhTnhhh+/wXPWwCU7H7fbgeq1sLvned6MsVSTdu7zJH0nGZ3vHcjiE2cwQrn9E8h+ulYZ8QJ3hM6eAbPUC17T61WUfY36rmV4rq8wS8B6NYGWNCvzRyAnBucvwxNp67ORj2Q6DGInp4b92s3388IluS9Vy0pPAcegcXUoZ+ot3NO/eC9plSYsEhqMSTIU2JzpzJHTyp8x1Wqj7ie2rSWnRyVtO90RryGhPRLl3Z7aCsq6wQVW/Z
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jThWKrekqTpnJ2i2XN+Sg2CK1dIw0frPYx2qc3jiQTk442p8I9vGIEJebB?=
 =?iso-8859-1?Q?yFVaq0saO0FVsIXBW0qe81b970hGJC8AIFMETLS2F0UMJaaoF8DBE87Fuj?=
 =?iso-8859-1?Q?ce1Jn9drMkucBIIEYn1AL7qvyQJ0uAoAKfUjpxVC4McEsn2r6WudayfQ1Z?=
 =?iso-8859-1?Q?5nqYcAJtbHnsxjThDuyBd8VL1pOlXprjlLgj2IeAjWCYvCLZXq2aGFuJhG?=
 =?iso-8859-1?Q?XkU//1qdhXalfFCyI21Fwmz14Bej4RjMps/J0WSnhpMiS3ApdCKUoYpU52?=
 =?iso-8859-1?Q?0GaVmGtSetpeMAe4NuEpata2dzN1wvifpfgfg1wmgDUj78tZLAf5V8GmOp?=
 =?iso-8859-1?Q?IDrNXm9exlUqrAqksah2k3LoV+G47+34z293AwMR+pSbkuveHB4Le+44P9?=
 =?iso-8859-1?Q?fQ29NzzooNHUTc9f1N19lvF4kr+fri98GvBo9IfeGRDIwTAiObL1uJCHAP?=
 =?iso-8859-1?Q?CzdV0vZFnhKByvqI8FRqyfgtCjUDx1ujR7iA66+vRUxair5swIsHU+LbEs?=
 =?iso-8859-1?Q?VsnabrtEUvPEzdoqNTxIBeOaFQZH6de00MxeyTEIELYtgzDuP1b1iVu7mJ?=
 =?iso-8859-1?Q?mqoE68Ye92s1iZmSyf6F+GTdydEs0P0Y3onaIbGFY5hX7bbjV7kQdqKlxh?=
 =?iso-8859-1?Q?0UO5wim34wyWRA82Sao+c64vB/uiTigGCNsuiXJuMtGVNljW5GpezfRip7?=
 =?iso-8859-1?Q?02Rl2/QFB4uoCSNNYTChvfP54P2yUDUbiIwjUhTg7w9t3qGsokcFjE+DNO?=
 =?iso-8859-1?Q?0hAoc0qjP8RxEOQDxDyiC+SjIrH/LM8TU0BcIiS+x6QNttMdQlMnwanGHD?=
 =?iso-8859-1?Q?IIJF8TaQxYfXUv/FsD4YwkcYcyXOboKNxZbGQAvh+MWiC4V+QPOz/3f6Ym?=
 =?iso-8859-1?Q?4soAkbqsTeGo4P9As3x+TMF3U3MjekVTnZUQWZxGMlo6BJn+ItL9nubvuL?=
 =?iso-8859-1?Q?TUb33CGyLZ+bmNnTZ/JatMaBFN0cXvMtYhi6AKZh57JR/y9U3bRr0tLIMx?=
 =?iso-8859-1?Q?HMSXpe7Kci1J4LBJR3yMcaMYo04/d3SK7p/WSb53jg/5vgd+EV1X0hCDx+?=
 =?iso-8859-1?Q?yuHQNb9WV2FSoV9VEv9PGz+DxdpcRIPmdOUtAJ2CR4maoFNatez7m5m/5G?=
 =?iso-8859-1?Q?HtP+DE8yaoDh4XfR0S/1So8sn6xfy+l9BkNf24HJ69RblV2fy3vZKrXDcf?=
 =?iso-8859-1?Q?u5GpUvl99nrldYKq1hYdHOpg/DAhlQrSVBr7QOBYimhfoUPR6nC2QPtOwV?=
 =?iso-8859-1?Q?P0skV8KHjbYdB0LSVDTQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR14MB3328.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e537bd-8ce8-422d-8a52-08db9f5a0d71
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 19:42:12.3952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR14MB6614
X-Mailman-Approved-At: Thu, 17 Aug 2023 19:51:01 +0000
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

The argument passed to _insert_nop is a uint32_t, and the loop=0A=
counts to a regular integer. In the event of the argument being=0A=
larger than the maximum integer size, the regular integer would=0A=
become negative, and never reach the count number.=0A=
=0A=
So, match the type to prevent an infinite loop.=0A=
=0A=
Signed-off-by: Joshua Peisach <itzswirlz2020@outlook.com>=0A=
---=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c=0A=
index 80d6e132e..273894441 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c=0A=
@@ -108,7 +108,7 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigne=
d int ndw)=0A=
  */=0A=
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)=0A=
 {=0A=
-       int i;=0A=
+       u32 i;=0A=
 =0A=
        for (i =3D 0; i < count; i++)=0A=
                amdgpu_ring_write(ring, ring->funcs->nop);=0A=
-- =0A=
2.41.0=0A=
