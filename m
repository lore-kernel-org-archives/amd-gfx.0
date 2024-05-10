Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E06C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 18:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D0F10EF39;
	Fri, 10 May 2024 18:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b2q7nNgV";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBDF10EF39
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 18:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DezwTwpFr/r8LDya25mYiaSRdDU7aK2AsITPrR92vY4iq7fiYHL3s1E8+O2x+9OJCWXrY22XSOUJ0o40NRTE0eR9TKjvi63LcmMer1V0Y4y8egBfwHmrQqVcTNtAX1rVEuRgXh3bJYWte+1TnnTsFbmDaoprhdscV+2iJ2XxMPiVQ4flG+5lYK+Q283nKjtypy036kR5kQEamHXZGAUjoa7AGkKrwWjSqZK4GJof6yqtTdvchlrP3tF8ovr1gUuyrTNzRRwZEINMK24OmrifqzUVX6yH+k3Aj+IbFcCBfV3anXbTYLnMioe0hftxNyDGsMQg/mV8EejgAV+jO636Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGIS4vQOr5ByoPuuUbjcE1AO7Djz0oGSsUtkzqlbyWw=;
 b=GgknFmOmJDZUfHQy0v+75g/NqAXO3zdeRnlwASM+LGUHlp7loVR0MLo6vILf5OXNN6wwAsm7PmUdHhWK3cVk/tIoP+lU6Ifc6EqpXJeJas3qzGPAaUpm2AeRE0iHpZ92h5vb1ithwwkioBNPrRvdal6905Qz8v/1lBYsGwg7NvKygc4K8O8ppO8JcEViHZiIC8zhRyxpg91PiGqldtiHIJJ57h0mqiNmzi6ruU+lvmDDf+KKhdY6p+em/dfPyzvDTESmJI1N/wnD79ML98jcqK79FvrrdB2mb4WPPtskEs7UziDKZWc0DmfRb/mBuIrEw6tpu17pyo03bj2s5uInlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGIS4vQOr5ByoPuuUbjcE1AO7Djz0oGSsUtkzqlbyWw=;
 b=b2q7nNgVUc9cQjjgoIODWHyuEOUTkKO+/JBNBmxV4dnKjuUKp5xR+3YwM5XW68faD0I2Ou5YqFyzTGF0Pg5KZBWLNz5MZzrZoRd5hiJptPThueHoMPvvVbV+s9uvX7jk3WA6yFBp0snCNZaLB3bS85dx4I3OT9D8PCKfC3GsCDk=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 18:12:50 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60%3]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 18:12:50 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix CU Masking for GFX 9.4.3
Thread-Topic: [PATCH] drm/amdkfd: Fix CU Masking for GFX 9.4.3
Thread-Index: AQHaol0Gfkk3CoheJky/BUaAsUOBp7GQxnuw
Date: Fri, 10 May 2024 18:12:49 +0000
Message-ID: <CY8PR12MB7099310987F5BFF5B9DA45598CE72@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240509220503.2297691-1-mukul.joshi@amd.com>
In-Reply-To: <20240509220503.2297691-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=93c91358-e3f4-401c-9eef-5d6be1f5aa8d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T18:12:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SA1PR12MB8843:EE_
x-ms-office365-filtering-correlation-id: 7b9eb3df-2ce5-468a-113d-08dc711ccd70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+9qCdxl0yLVIQXXp/qwbtG2fNqSK7ZRKakXkRmj37PdXk+HRJaWmsKrbbb8s?=
 =?us-ascii?Q?g1R6ER5f8Mqx5/JeBUFxaREqEQ005FypQw5vwClsfLJ2PmQsWx9CWWXlqUAN?=
 =?us-ascii?Q?aPSHNs2JzcSVK4k3bg/TWXbquILLokOpN5tf7ylTmNsUUZzM7oCQB+zkba27?=
 =?us-ascii?Q?Sx6+caHSYTo6iuVJgvzMQkvkAhbydY8YMU3ujHYYXIuTzdSh5ytqFXYGXyeK?=
 =?us-ascii?Q?E1B6DXY17ZM4Jk+UcXbXscMTB8Mv6F4hwObtlpyB4qKImTi5wi5wLCVngOQm?=
 =?us-ascii?Q?GCHdlii0RNysQ//dD6ULMZpzLGKGNRDcdtDVmlousP3oxWdoNCYNRVsOdi3k?=
 =?us-ascii?Q?OucY9n4EdGgJ5NZ1Rd7uQ7lGoyBQtvx/0yy2QzmOly4W2+77gNAm8p+1jca/?=
 =?us-ascii?Q?gPcBPVF29A4waRyPt228uoJCC/3p9QjZVINPDdmpx7p1cNQzphfom6xs6ANj?=
 =?us-ascii?Q?BSfIoatGvNKKf1C0yKkS0+HlRE8LxQ1uETjMs0g4qqI2anxgon7orI+3SJxI?=
 =?us-ascii?Q?CawdJeih8IahaKn4qKjwezsf7GvVhHd3kSGVWODOnwYCHCBi4B5G4X/ZgAac?=
 =?us-ascii?Q?346Znnb1LIcbR2BkYii6dFdc4e1nJFOjQE/b28G/m86jhONI7+YxY+y/GZa+?=
 =?us-ascii?Q?/ZgKp0XLghg9+hCyDgCbnbVPWNar+UamW2uQoc/YbBxkgBlsESdZY7uPxsP8?=
 =?us-ascii?Q?B5sMAZp861Cdfv7GqZYZOi3GBlUNn8oNJO0uDhN6isLYVhS6xyKM6Sil+c/u?=
 =?us-ascii?Q?V3ujShhtBITnvmGqs9URPNOOBu6eL5RWqXS6tITm5uCi0QO7SeWNqKZSI2or?=
 =?us-ascii?Q?qYZBiAjENZBis1Dgnz/m1dhYasMStnxWmZVQbL+U7zCUdyzYEv80gNb8nIjr?=
 =?us-ascii?Q?loNLoAo7Sy0HkNzyUBh8+kTfWWhsRADKrbXfjFuI4h4APEfEZluM05kA1wQS?=
 =?us-ascii?Q?ptfi4TGIJ+FzqYrDigeaa0ROFi/b8tD2HV99b2sQ+CkY1pA/Q4qPSH3+jWZb?=
 =?us-ascii?Q?3aDqKJIMtBOjANr2FNXxjDpfnH9p8hvsPv+U6KVtQFtuU0tO8YXzOufq5x9W?=
 =?us-ascii?Q?KmXPhT6h1gCQZxBOuKfiv+pSFfCgPVxEHr8WmDWJLGR+EednWQu1z5wncYKA?=
 =?us-ascii?Q?q7p4cAnH+hz60cdbda3prqh3WWlfT48fdgIBIfJnapeie+lJCkTfrx/qX/cv?=
 =?us-ascii?Q?4mPCrE3sSUosa/yrNih8S2pjP9gLdUS7SNBuS2IdyjYy4AFrarxhy1wM4tk/?=
 =?us-ascii?Q?El5h93CdXH3jC8fZU+8cUxWNcS8xHCM53K9JoKFDRI7phXi09cpqiLon6ntJ?=
 =?us-ascii?Q?9dzbasZ+mHTGyeEGRqAbuv/nkzmOPyM2sm2e6UF3I94v0w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JICE+V4ESUYKfbsHz7b7c6viQJlHvE/Au5eKEuzllnxzGMCuedDHRwI4BAwd?=
 =?us-ascii?Q?NgRDIP0knFWF5mQzg/MHF9fRtwc4UdAS/GgkiVyFuU0YpnCh5pLD8bK8f9uJ?=
 =?us-ascii?Q?oMvv2unbKmQPkzYVSeemrI6br46wI9D6ACsIsYvq6pf2ooerhUeiq4Zx1Zc3?=
 =?us-ascii?Q?D2hDIKl/ubl1G6nOHA/MBcKg94ciVOMYBD+YyIqKXr5bbR3UatL99Pg499i+?=
 =?us-ascii?Q?qlHU/qvwudZYcv+q/d579A6E9hVzFWC66gkH9G5M9TMrkdv6Z8nNdQ6ERSwC?=
 =?us-ascii?Q?U4ZaF1Q7V8QjPaoTWPjlCUg2J4pQawTX9RUIQE7aUkkBSJoX0Q9yhiZ3CnEO?=
 =?us-ascii?Q?d++/QYdOvOgT353EokG5cqKdO1GFrESQ51WF8E9EGgX/dTI7WhafqepaLCnF?=
 =?us-ascii?Q?sm9AcmPnC7EaAA2pHulcgo4KFhXCxgKiH12Hi8V8WEF/IcbeugAFuP2JV6HR?=
 =?us-ascii?Q?G/w7s4wNVOEUAKG9vIGNuiquZ1fkETqpmH3GsuKF4YxRQdBlvCjwgh3wOfIQ?=
 =?us-ascii?Q?yuwSbcuhsS8Hfz7pqSOWbJCIweNFMmXW44fMOZEQWZBQehGFyWqiN8AGp3Dw?=
 =?us-ascii?Q?icyV2l0u513FFyQpY21wacPivi8J+cer3Rh/hexyUkDAV8MXQHpoYPnLRQ3w?=
 =?us-ascii?Q?ucU/YVk9QWcmRRo8yBL65kSL0JodRCU6H4qrJ0ntuJSN6NqBqkNJB+ykknLq?=
 =?us-ascii?Q?5wk61HRPbry23bQge0dmzbZ/fdhawKm4D4IQ3R0S1I8c346UjbNg4zsp5+2+?=
 =?us-ascii?Q?SPTCoU3i8DyKWOxvZrms1JNGgUgnXTh2N3gYUUheQBUL1gK33lfPsbS6mcZ/?=
 =?us-ascii?Q?CvDc7caEvSl5i3d4vF92bb3WJnkSGD+Cb5cDgj7BFbt0j7LCErO+ZHVh6Xew?=
 =?us-ascii?Q?KrcLk0+hu7ffjVe+DzxGqb45gNZrft/aVvs0BqZ+a2vHvUDkGFc2EMFWnlI3?=
 =?us-ascii?Q?plaoaq46CgAAr6XemKiWwbnvTjN6HvLaLfCXlLsViQqtITkeSPTJylmbpCgd?=
 =?us-ascii?Q?0Y98r41b2iPJAgrOgXaoEwuTYbUH0DLheeHtvz2lr6djCUHSJff4C+HLjF+h?=
 =?us-ascii?Q?SdnJqBkPtFVsKv466mQ367Qiec04lBnmCzWtIcp7jeIsG5aNPybxqrku0qR+?=
 =?us-ascii?Q?31zgXZZA79wt1glG8RQ1Kq2Os4/kzcWWe17f+OgXD7SJ7z2OdHbL95ps+8U0?=
 =?us-ascii?Q?ULixpo1LjTxKVYKVUi+wbu96fKBaM0QmKzFBrb6C8H9IjgvV5wB7nuPkV06+?=
 =?us-ascii?Q?wHYPxdGuhhfo/4IVavR+TdWkj0qn7Eyu0D7+W4g+Vg7QvsOLg26IwuwaYzQx?=
 =?us-ascii?Q?EeE1BC+rqsrcA1+U4j4yHff1xXUQmrNJJIyZxc9mO881ds9VJLTvZGcyUvx0?=
 =?us-ascii?Q?UGf/j/5wdXkb1x5lfGEpe15oMhLDARB3y4LvMwwlaK2ZlrW4/BRZ7Ji1rsyx?=
 =?us-ascii?Q?fyZKkN88M9MZKZjJIn0GYh2T212kXKVwPyecfuyU1geeuCUjhsXRJccAG5eX?=
 =?us-ascii?Q?hjpGZzT9yDpazVuQVsdMqBs/fyjPL+6qU0HUFbPdIuKQg6mN0Q6f6nxvZWI8?=
 =?us-ascii?Q?Ux255L0Vow0lS8HsOuY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9eb3df-2ce5-468a-113d-08dc711ccd70
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 18:12:49.9329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjlEYWaG6WrmdT0XdVTV9GpvYlluN9indpaEhA++1O5kJzxuuBsGEKKkpDIRKtN2tIWHdgE7KL568bb6ZIfBAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843
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

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Thursday, May 9, 2024 6:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul <Mukul.Joshi@amd=
.com>
Subject: [PATCH] drm/amdkfd: Fix CU Masking for GFX 9.4.3

We are incorrectly passing the first XCC's MQD when
updating CU masks for other XCCs in the partition. Fix
this by passing the MQD for the XCC currently being
updated with CU mask to update_cu_mask function.

Fixes: fc6efed2c728 ("drm/amdkfd: Update CU masking for GFX 9.4.3")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 542191656aeb..399fa2106631 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -715,7 +715,7 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, v=
oid *mqd,
                m =3D get_mqd(mqd + size * xcc);
                update_mqd(mm, m, q, minfo);

-               update_cu_mask(mm, mqd, minfo, xcc);
+               update_cu_mask(mm, m, minfo, xcc);

                if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
                        switch (xcc) {
--
2.35.1

