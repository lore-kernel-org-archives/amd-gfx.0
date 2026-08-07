Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4C9C5AC7A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 08:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB61E890BE;
	Fri,  7 Aug 2026 08:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qmQF9Pwq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD93890BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 08:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbpvSulGpUcaFLk7tR++rXGSz5/jWyGTBU/dNCyrp8kWlhHrYIM1CPOGwDzhwfX3YiVM0gNNDoIOnGEtOe9q4vXPKtGZN0aScX7Rhn62NGssbw/rPUErHg+u3nBzoY7y0tfJzCQ4VqQpI9Sg03sc05Y6iEGhPuJPNsaSItU8UVSTaSSD7MyNOuIQWSPglJRLTV9IfN2XFJ7C3Z5rYrxbfWq4bXiWPUSPU7U4COVBRZYtdugSWRxwfXfBVqp+FzbPTMMgwVip7DM7YjX86mGbkgLOkXzzQYM6vY2uIjUKAd8UUGkPFWyk9T5ZSdmuz9TeSqqE3MMEm/T+pViEzK6QaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTAbss6Dt5QXeebYVvvEQyj+0TZ4TZbHEDShc+xafHw=;
 b=EM9a5kxPbHxIZ5Npvc3v5vj9XOynx60bABWVjQg6oF/YAZnHqXsEOnFNDH9v/BHmNcSqkTVSVWu/nnr1hY0LJ7jKvmwzPfbUOcnrXei++SNefTNdhdMc6N1ZxRVWjDzHcBQs2reZyqbzgGlMEwbtnZ0e4IAx4dL7tLhfGtPMvOGgx6KV0qr28sYqWNMfGaFo2nSnRA+MMrYDwyyNuAdFG3+Ug3lkY+OezSEqXEyk1BeC1O8hjShWja3U+c5SSu64vkmtBlAJj7ds/ChN9gpUt/5U9JKy0bQ28JKUqfneOxCjsozjC0rtIzg0MT5fw65Hy0u73NCg3tkiKMCxLS/dAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTAbss6Dt5QXeebYVvvEQyj+0TZ4TZbHEDShc+xafHw=;
 b=qmQF9Pwq2uJ1JZKIDpe6bBcoUJRGV1wItdx8Xla8m93RuCaKdNu7mRaifblAtbT6KrHcyahmZ4cLlmTG6mBzs/Part+IdsYhyoW2/te0c6Cv0sRWRo7/xLmx+htfOQTby6xmbGOSwUCsPB0P37RLBAuy5N1ptDA09AKtPeOuFBM=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by SA1PR12MB7341.namprd12.prod.outlook.com
 (2603:10b6:806:2ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 08:20:24 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 08:20:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused by
 DPC
Thread-Topic: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused
 by DPC
Thread-Index: AQHdJjrG/mJWnOfHy0yA6IsMqWQtzLaSPd/A
Date: Fri, 7 Aug 2026 08:20:23 +0000
Message-ID: <EAYPR12MB999158FE6597CE2D6AA590FEEFFCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260807070237.1169684-1-cesun102@amd.com>
In-Reply-To: <20260807070237.1169684-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T08:17:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|SA1PR12MB7341:EE_
x-ms-office365-filtering-correlation-id: ab398331-7d64-4b74-78f3-08def45cbab4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info: vu6axB23xIj4hjK7ipuvvw4+syqTgkBT/6R2Lbgy9RpOqj2ivVK0PAbrC95BMOCZXR66SH6Yf1I5Tpb5pL7VTVXyLIIbVDOtgHdQTDJ+HoVuLiqHWwbCtciZAtarJC6qqdq3eEbRecOUFKvRSRTQcJmF8m7SIalVwyoEbgMaZq+9qaMoVlGvRAo8yQs/Fyut9X1+vhCkTz73L63GRo7L3j2eei9izPY3saM+RRW2kqlRaXrnclPRRPL3OAu01I04XteyIwYY1FKmTw9ToGytT8wVIk2Z/wP5vwUV/LUHmuYr9i637Ji315P4lnZANdapxLTgfq++ZgQ/WvPd+uSX7qYmq6NY+9Ux0JArYQDGwQS7jY8jac7TqIygUueX6xSihKeBv3IQxwyqjLY8QnGmYMYlL3duNLO94zEZrGHpQy0rgYC914UfIJN8mLj8w/PEhLJ60H4lFKmsgYztDSERJ3BnLsLK25InBgg0JbabAXNcf3jNafZd93eUooohRpc95YK4zhlwVwN8cIoxgfhVxmATXIc3nvxV90ZsJRWtcUigiUIe6PPCsFQOVUbqnrEWRszqEnYSiLVKd1fD3u6H8w8Td+25B9Y2Jlx2X/gFx3Bfg29yqcz3N49gEswiLJ5hDLu5/drsqgBZ3PTopnlsjv59kVTmdjIdtRH5p0qXjnB95bnmZl89VFXIKys3pyc/r/FLZa6q+mJ9/HV795X3iKx0FRR0brmm02XMEPa8T6A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a3WE+y7gF9fat6bo22s+ZAvv9th5eTUKwUP7hj6Sg1bnNHuamBUWkg62jQ6/?=
 =?us-ascii?Q?Lz6TsYjcQbwH2wiUVlmCXRxP/oc5cu49p1pW071cBdyfnPejsGlWHkjA4t3E?=
 =?us-ascii?Q?AyP0PPEqhnIgaJ6zvYDibMlQSWAEoKdwaOUdqrAFz10ZE6iMBj9uFzbOo1Mb?=
 =?us-ascii?Q?ktkLPYi+7fSBoAX9H/AJQIBDwzsM/n7RljPgG1+nFdF5VQn8uGPNv3OwEj2k?=
 =?us-ascii?Q?yWLaK3yFSwgYwY4yrqRLKvoqhBQex3SC/CAWflAXHzFItTUXwL/ADv0k1jmB?=
 =?us-ascii?Q?uGXE1HmTmTPxliFRgSGj4ZmI6S7rjFxdeybjyLVZs+KTPr5GmVBqUVFT1CBj?=
 =?us-ascii?Q?18aiAxd9XSVXPp5rujchmYCCjenWxM1lrESi/8x9ZDhPWMjZNfnPV0YhqDTT?=
 =?us-ascii?Q?lOgld4lRJHYp5psZfXg/bNGNmBvScPdTpTotlnPTTwKWUVG315GsifaqgxPJ?=
 =?us-ascii?Q?6sRgFGQtlFwAAsCvm+VqAisCrCLjOWJVHORcslZwQIeooO2EqIzFxwXba6eL?=
 =?us-ascii?Q?ZJMIUM06mfJ+sIVtilkWS0WGeabxnru1siIF+S7J5Sl00TGuQNfDcNJ5RpNm?=
 =?us-ascii?Q?jZQHHO4YPK56OmMUBdk+Dvg2Et/+xZaHeqp7Nmfcn0DGqyoCFY/DI96wx/nR?=
 =?us-ascii?Q?PT681h/VieOB3aQDi2Zdwfahw9EYEHoqS5YtgGFM9nkOQibSR5wlc+7yaO7e?=
 =?us-ascii?Q?0hzI9qiZ5khruE7jUJ+iTcKaQHJ1a7MMd4CZqu4+c988RAT11Avzi/tJFpfy?=
 =?us-ascii?Q?3aDznmzLPPDY6rE/w4gqhJ4JmQJ2yWnWzLYLa5qwTwhGeNB5NtJqopT3ZPcN?=
 =?us-ascii?Q?22uvodcogw6ayU6UNmQgzc4yPvRzdofMJxG31LQH4mAVLtV2y0knKHuSM7kD?=
 =?us-ascii?Q?0VPE3cwqYhpjZ9E9M2l2o/412VR+iKrFWQznwU9c/DlcR7BZLl4Mx6q7pUJH?=
 =?us-ascii?Q?CDcEbmJL1O8ch/0KWLCb3Rcdhl/i1htCYd/pdLoRLIOm+AWlf8dCZQBRJgNH?=
 =?us-ascii?Q?WIXBA0FTz+gvYG1h0jjQIsIezidnp00MeaKqSgE0n61WUsRfFtPuSLySGq+3?=
 =?us-ascii?Q?rhBZftjezT9I6YRyaQuxH5WTIlcKxhZI0Bk53MGmbviKC/jB9wCLCCClUi/s?=
 =?us-ascii?Q?8O1Iul69mTTRL+rt6ao0SoMZcq05ZrEBvS/QfOYCfi4/mB9YhaCnbKLpC2BF?=
 =?us-ascii?Q?i8bMAF7P9cblaAkNOZvugsH91KRl+T7y3udaPXfOKNq1fhiDzPHlsakuZvxY?=
 =?us-ascii?Q?C1vdgUyPh+CnyYzv0CIywdharSfqAhFhqALUqelkBB3eNVKA5OoMKJ8/STit?=
 =?us-ascii?Q?aycGWLWQe0FKjDi4HKYXEmvCYb6gg2vA7TmnW4pQM0dQCndIhqq73u08oKmx?=
 =?us-ascii?Q?WpMc+FeweCiuRo5Lzo4rLBMfDsik8aQrF3XSUPVCwIAIZkF6RwDLi6mj54aR?=
 =?us-ascii?Q?8tsNHlJ3Tx7Ne3+4eP9sKnW+yZQQxEsi4slqTREieMRazQo5thA+JPLJtH5m?=
 =?us-ascii?Q?Ba4hLPE/dPOKuYxKNMhcULyuV6DeUM9sRdJePjG3/PzioVfrwf4Kq0CUfZw4?=
 =?us-ascii?Q?uFM5Hju7R0SuZfFzliZlg5rdSbMRIFyfeSMd4W9BZEV4PqWiRC7WUvu1YWfz?=
 =?us-ascii?Q?I+uU6kIBzpsAa6OS5WmAxPqKRj/tL094u6Rrl63hJkJQK5i5kRHpnD8u4PJe?=
 =?us-ascii?Q?UQdMOC4t3C0esymEQTg2P2XX6oXCi5B/OtUJh7B9o2AkmNZM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab398331-7d64-4b74-78f3-08def45cbab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:20:23.9377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x96WXlwIE7Kt2m8NX3OY4n5nWwjG2MLVbwjOwHy5RFHo/G4fsMxvjEVI4u2dp0PzRPaDEYprRSTQlOWNjUVHFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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

Would it make more sense to set the RAS query ready flag for the DPC event =
as well?

We should keep ras_query_ready as the single flag for all RAS sysfs and deb=
ugfs nodes. This would help simplify the implementation in the RAS block. I=
f the device is not available, then ras_query_ready should be set to false.

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Friday, August 7, 2026 3:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused by =
DPC

When DPC events occur, the GPU bus becomes unavailable and all user-space o=
perations should be blocked. There is a timing race where rastool may still=
 send RAS error injection commands to the driver after bus loss, which lead=
s unexpected failures.

Extend the readiness check in ras debugfs write handler by adding
amdgpu_device_bus_status_check() to detect bus lost state. Print warning an=
d reject injection requests to notify user-space the function is inaccessib=
le.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 35eb87591740..4943be034c80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -564,7 +564,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fil=
e *f,
        struct ras_debug_if data;
        int ret =3D 0;

-       if (!amdgpu_ras_get_error_query_ready(adev)) {
+       if (!amdgpu_ras_get_error_query_ready(adev) ||
+amdgpu_device_bus_status_check(adev)) {
                dev_warn(adev->dev, "RAS WARN: error injection "
                                "currently inaccessible\n");
                return size;
--
2.34.1

