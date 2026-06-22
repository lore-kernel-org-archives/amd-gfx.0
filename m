Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1844CCD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 18:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A963010E7DB;
	Mon, 22 Jun 2026 18:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5eBYRZzC";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4EC10E7DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 18:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tvd+/GAjvp+3so7FZ2VTk1W/p6pWdZ0gMjVuQcwEM+DUqA/ze1BC2BUMRrj2UzrqkrTz6dkcw27TWq+TjCRHUcakjXCDadLQYd9rTX7Z97zV7Cv/8JqqtiHhwRvRzsmUCisue6FGJwSQP8/OZpIUuLpEB5fUc+unLYYkIUo1bjLl4BYFiO36aRF3dM6nE+LeVmEZlWNjwXLBPl8Nm0QX9hITU2DjiTajQhcFNp3081JCRQ1JsVGs1c6+8dLQzPPPUvun2jbvcGpxJjznqHWiY9VGr3hTLAm2blOansSsbgysZ7lYvXyonAoL2CvjA8OKI23PLJ3dmXbXCvpBph6xKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp5BLtfTTdX6VVeMVzRXXLhORMaXVGnhlAyqPSXTh9s=;
 b=BydsjIogPWXK95F/OBHAqCuh6vlFu3qRjjx+0uxJ+RGjYYD0AO0KceOtL3LDEH+qwGnJhmlmZTajzbYBVkIKqNf85kKpz14ycQlFQ+8LumfcpY/PoMmjKAVIQflEO5wPdYV/WUbVmFPdn7Vu21ZIY7JoVTRY4ZfKsxRs5ObVpsC6CvgP6Zhi70oX9TY52ckN9l0bss+d5VHBNbbb5XdctHOZnfp1TlJun4eNf6kciwSevmR/ajA8qcBgc4sL/VWup1nBZd18xVDMwjq/8d19pz+viSEW53IuyBra0fIEIRXLCR1m4aF5dAiAN+ohJUQTPBIsNbaTXIG3j8rp7TGNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp5BLtfTTdX6VVeMVzRXXLhORMaXVGnhlAyqPSXTh9s=;
 b=5eBYRZzCAaKamxcrPeuTZwD6GTpX3pxJC5PzVnQLjEHAeeBpkE7XQRPeV75V4Liyne+PPJOuA5wbqSiBtFnvymk/RYdIIFk/hVScuJyTb/hjNbKKm9CWJObkxB4z5QJ5+Ff2d1qvhCpaqYm85gAfSO4K5yn8iKtIylJDpYDwKpQ=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 18:47:48 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%7]) with mapi id 15.21.0139.011; Mon, 22 Jun 2026
 18:47:48 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: avoid race condition of mqd when reading sdma
 counter
Thread-Topic: [PATCH] drm/amdkfd: avoid race condition of mqd when reading
 sdma counter
Thread-Index: AQHc+dIvaRYGUpl1FUq89jITlDw4eLZK+3uX
Date: Mon, 22 Jun 2026 18:47:48 +0000
Message-ID: <SJ2PR12MB86508C02519C5843127EAA3A8CEF2@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260611184303.141724-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260611184303.141724-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-22T18:47:48.678Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=1;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|SJ0PR12MB8168:EE_
x-ms-office365-filtering-correlation-id: f1321f74-4d12-42cc-db4b-08ded08ec1a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|18002099003|22082099003|56012099006|8096899003|11063799006;
x-microsoft-antispam-message-info: eTRifp+po0yCBnVFzo4arYM5/XkmPM8TIHpAUyztDRYK+Yl7HEK3Kl3W9l/mCX/T6I+CMJunKwpNR9b8D23gKYg8PCRrkN6d1sU2av3cUjzBn11M/vhIHHYcFD3lmllqeoa1J3VOQbCcxfMG80ecg4pETFTUo53a9ECl7VnxcO6w1i6fg6QMy1HLdJwpk8JcCKLVbJiymEZ3cx3i+vn7Tak1XszO+t4kIlRljf3zBXU17BXExeNPFwY8/cPdY3gyDmgjAMz7yOepGTj1/L5rf0d83Znr55GyCIMW4eOdSzoYV7oenNwvGZZ7Nvauat9+dW6LVI6axoxFf/ZmqdZV3pIUCFsUirM+rIjfqfCWr1qwZqm6XsZeo+AnW5Q41Y9b7zigaUy1pCvkvh8gzVMFKArdVW78rqVPNPJ1OpuIWmRobIusjfYw4S6aH61gYEsM1OnG22WiK1e5cRW5WvGcBxmjEK1Uq+Zdk+ujps/JIjeqTf0U4MhDOKpUuTPBZGVJDe+vhtijUAd4vvL6TLByo7OpSyh2ABptD7sMVfliougkLfjE/oKCStoRRX3JRVORDl8J+4nOOEiGO9vANbLdDxsi1khsH8TgsA9YWjLgkGfKQb6NoDnGwMa1CiyKVbR+IDXm2Bac4E0shmIdUBygdI5WOosGLa0hPFnxnMqWNwNF7RPw/VrpEbZHyfULNTouYyvtft6U6MKWDRGh+ufz7+bg0+3ul+IEwoqV3cquK44=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(8096899003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nohQeCKV6p44tNx63jonZ/uDcef2OY1t5SxvnFWhAxJsVScKvFHDeZgTOfWQ?=
 =?us-ascii?Q?a9HhokGMJTlLg9+dffliRqayyRdhFm6Scgl9kMYQgntzlpXhExyT22HB/g9M?=
 =?us-ascii?Q?NNeVaUpVTj8f1HNDX1ObkAiWBYdszqwfVqG+wbtlGt5pPsesBLS4u6ORGBEL?=
 =?us-ascii?Q?C4Wcc+M+2FYSKqkALDGGCwe1WYdLjv8gETk6WqE4j09Kuc9fe34boE4B3Smf?=
 =?us-ascii?Q?I6MXiu4km7N+8UQD9si1JCSGTA9LVj1w6bkx0uaoehcF10KMp4NGJfPfNLrO?=
 =?us-ascii?Q?0f+uk0CdwmvK9eL9Q82Yai/1F1K8J+IEPWOu3XSNp5hDF6t77/O8whFSpCFz?=
 =?us-ascii?Q?OHhxbgf3AZ0s59CqRZrLq92IXaVR9FvUMwX3azWvLw4ttmgF86ezOrVjWga7?=
 =?us-ascii?Q?IWrBqLKVOXNEQA0pzX6By4j36TLR2iYhC2f2q57CJ5PZ5CdbE17Rr7WX+FVc?=
 =?us-ascii?Q?SK5fIZmak3kVUe6/rNkinB0hWXiDDivlm4+d9r4FpfkSw1E0XEH/YyHmhJmP?=
 =?us-ascii?Q?yp1xipzXhNMmUJeeZB4EPZZagVJjYX/b9BkjhoarFHvtwRH9XLdiRkd5aN8y?=
 =?us-ascii?Q?ny+F6RCanMb+mn4T6m/IgsHrcOcvpNsmcFwD8xUpINWDC4aELq/gZK5otLBt?=
 =?us-ascii?Q?0nFU6FzuR1vgi3gijHHdcvT2512JjsZhBXyAf/u7dgim4liDRCwbgefg+aBQ?=
 =?us-ascii?Q?chkMJL129Ld/BoT3w2wxAFBScvcp+xZDJCxiaTW7G5dNFLtzDDnxEB7qv6RV?=
 =?us-ascii?Q?g5uXt//rMA7zS1P72R9xhX1GG9dA0P5mDVkaw7IznCjIiFecGw7LnxpADzWu?=
 =?us-ascii?Q?RiE5OWwOZQjYF8zNaWF6Bd2n17yVQ4kHTljv+MIYK1vwNrM7sBWVR4WT6WoT?=
 =?us-ascii?Q?G7aOtvgK37PsqVfDdFihgMQUvzv71KdyLqESdCZiZcaNbgT6d14KCwvPNSHD?=
 =?us-ascii?Q?7MtHsVWTWGYa/GfRKdVVAWJPnPB1rcaMXTWUNcNPWiXXdGKXXi9YM6QkaqAz?=
 =?us-ascii?Q?BL0RE4x7JC7591MCm5kcILOizosSab6lZzHaj+qTWwJJuo0CSJn6mdo83xwf?=
 =?us-ascii?Q?ittOMNAObw6cRFTNGbV0fMRfUFVHmabsuLpwjHn4XkdYH8KNOxIMCAazmw3T?=
 =?us-ascii?Q?xNe7F+7CvRnDmmmPsl0oaUvvOvu1lVyHSpDrgSB4QLsE+tmHVbUn01RDXASI?=
 =?us-ascii?Q?2ySd3FaRiezGIoRiQjoHkB2/Jq9nVRyHd8IwnNHI8ytZUx7f37D6D9OfEl70?=
 =?us-ascii?Q?E0EHay1cSJoWmQaDHAslKZBQMB5meg0lHLBW14SxNKHSigeVcjnGBuwhq9Gt?=
 =?us-ascii?Q?y5Sa9CUEWUAdg9dIRPjF0015PnsfNxLJzm3xkKVYgabQ29zYIqRGdvyyNBZE?=
 =?us-ascii?Q?QquucjL+2fEeeP8upN58P5EGlkFM3fSIqKj6WRgdERVuCpoQnRrda5IFpJev?=
 =?us-ascii?Q?DLCJJ6nH/Utd5UPqnM2jPSTvPBP9EbZ1v6MuH37Aa6fcc7Jr6OhiqyZV8Kn0?=
 =?us-ascii?Q?O+WPGpgna+5A7X9+7M4IDJKXWEHhkkrDtNBeSWHhHWA9TMf/eqg//0WJDOZC?=
 =?us-ascii?Q?ew1dXbRRl1At9jMWBgH/oYIg57qBssm7i2iZSzpPRcGPmLEI3VqL5mEEbn7B?=
 =?us-ascii?Q?UGFyy/sl/eE9SBWuK8cL3IqbE/fbZEvGOAsyXRY7LandPfAF6Q60lZEX26bP?=
 =?us-ascii?Q?F2qoiHoGOzxOFdCs7MZ/tjPW4vJKAYmwp9fxIEfdAsC48kC+?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB86508C02519C5843127EAA3A8CEF2SJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1321f74-4d12-42cc-db4b-08ded08ec1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 18:47:48.5473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XuYWt1rsEsbOAZAsYtC4SH+OSbN1WJTJALoGXqjQ7eE5rkj1vvn0rjxHxf/O+diw5WILKGOgYIdqvokLFMQQNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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

--_000_SJ2PR12MB86508C02519C5843127EAA3A8CEF2SJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Public

Reviewed-by: Harish Kasiviswanathan@amd.com
________________________________
From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Sent: Thursday, June 11, 2026 2:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Huang, JinHui=
Eric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: avoid race condition of mqd when reading sdma =
counter

MQD used outside of dpm_lock is unsafe because of the queue
could be destroyed during the window of dqm_unlock, moving into
dqm_lock range is the best practice.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 32 +++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index e0b885b2395a..1cf689cb5e2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -91,7 +91,6 @@ struct kfd_sdma_activity_handler_workarea {

 struct temp_sdma_queue_list {
         uint64_t __user *rptr;
-       void *mqd;
         uint64_t sdma_val;
         unsigned int queue_id;
         struct list_head list;
@@ -154,6 +153,22 @@ static void kfd_sdma_activity_worker(struct work_struc=
t *work)
                     (q->properties.type !=3D KFD_QUEUE_TYPE_SDMA_XGMI))
                         continue;

+               if (KFD_GC_VERSION(dqm->dev) > IP_VERSION(9, 4, 2)) {
+                       ret =3D dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
+                             dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+                                       dqm->dev->adev, q->mqd,
+                                       dqm->dev->kfd->device_info.num_sdma=
_queues_per_engine,
+                                       &val) :
+                             -EOPNOTSUPP;
+
+                       if (ret)
+                               pr_debug("Failed to read SDMA queue active =
counter %i\n", ret);
+                       else
+                               workarea->sdma_activity_counter +=3D val;
+
+                       continue;
+               }
+
                 sdma_q =3D kzalloc(sizeof(struct temp_sdma_queue_list), GF=
P_KERNEL);
                 if (!sdma_q) {
                         dqm_unlock(dqm);
@@ -162,7 +177,6 @@ static void kfd_sdma_activity_worker(struct work_struct=
 *work)

                 INIT_LIST_HEAD(&sdma_q->list);
                 sdma_q->rptr =3D (uint64_t __user *)q->properties.read_ptr=
;
-               sdma_q->mqd =3D q->mqd;
                 sdma_q->queue_id =3D q->properties.queue_id;
                 list_add_tail(&sdma_q->list, &sdma_q_list.list);
         }
@@ -173,7 +187,7 @@ static void kfd_sdma_activity_worker(struct work_struct=
 *work)
          * count
          */
         if (list_empty(&sdma_q_list.list)) {
-               workarea->sdma_activity_counter =3D pdd->sdma_past_activity=
_counter;
+               workarea->sdma_activity_counter +=3D pdd->sdma_past_activit=
y_counter;
                 dqm_unlock(dqm);
                 return;
         }
@@ -191,17 +205,7 @@ static void kfd_sdma_activity_worker(struct work_struc=
t *work)

         list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
                 val =3D 0;
-
-               if (KFD_GC_VERSION(dqm->dev) <=3D IP_VERSION(9, 4, 2))
-                       ret =3D read_sdma_queue_counter(sdma_q->rptr, &val)=
;
-               else
-                       ret =3D dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
-                             dqm->dev->kfd2kgd->hqd_sdma_get_counter(
-                                       dqm->dev->adev, sdma_q->mqd,
-                                       dqm->dev->kfd->device_info.num_sdma=
_queues_per_engine,
-                                       &val) :
-                             -EOPNOTSUPP;
-
+               ret =3D read_sdma_queue_counter(sdma_q->rptr, &val);
                 if (ret) {
                         pr_debug("Failed to read SDMA queue active counter=
 for queue id: %d",
                                  sdma_q->queue_id);
--
2.34.1


--_000_SJ2PR12MB86508C02519C5843127EAA3A8CEF2SJ2PR12MB8650namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
Public</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Harish Kasiviswanathan@amd.com</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, JinHuiEric &lt=
;JinHuiEric.Huang@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 11, 2026 2:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; =
Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: avoid race condition of mqd when readin=
g sdma counter</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">MQD used outside of dpm_lock is unsafe because of =
the queue<br>
could be destroyed during the window of dqm_unlock, moving into<br>
dqm_lock range is the best practice.<br>
<br>
Signed-off-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c | 32 +++++++++++++----------=
-<br>
&nbsp;1 file changed, 18 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index e0b885b2395a..1cf689cb5e2c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -91,7 +91,6 @@ struct kfd_sdma_activity_handler_workarea {<br>
&nbsp;<br>
&nbsp;struct temp_sdma_queue_list {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *rptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mqd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t sdma_val;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;<br>
@@ -154,6 +153,22 @@ static void kfd_sdma_activity_worker(struct work_struc=
t *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (q-&gt;properties.type !=3D K=
FD_QUEUE_TYPE_SDMA_XGMI))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(dqm-&gt;dev) &gt; IP_VERSION(9, 4, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dqm-&gt;=
dev-&gt;kfd2kgd-&gt;hqd_sdma_get_counter ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dqm-&gt;dev-&gt;kfd2kgd-&gt;hqd_sdma_get_counter(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;adev, q-&gt;mqd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;kfd-&gt;device_info.num_sdma_queues_per_engine,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;val) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; -EOPNOTSUPP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Failed to read SDMA queue ac=
tive counter %i\n&quot;, ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workarea-&gt;sdma_activity_counter +=3D val=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_q =3D kzalloc(sizeof(struct temp_sdma_queue_list=
), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!sdma_q) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_u=
nlock(dqm);<br>
@@ -162,7 +177,6 @@ static void kfd_sdma_activity_worker(struct work_struct=
 *work)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;sdma_q-&gt;list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_q-&gt;rptr =3D (uint64_t __user *)q-&gt;properti=
es.read_ptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_q-&gt;mqd =3D q-&gt;mqd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_q-&gt;queue_id =3D q-&gt;properties.queue_id;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;sdma_q-&gt;list, &amp;sdma_q_list.=
list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -173,7 +187,7 @@ static void kfd_sdma_activity_worker(struct work_struct=
 *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * count<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;sdma_q=
_list.list)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; workarea-&gt;sdma_activity_counter =3D pdd-&gt;sdma_past_activit=
y_counter;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; workarea-&gt;sdma_activity_counter +=3D pdd-&gt;sdma_past_activi=
ty_counter;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -191,17 +205,7 @@ static void kfd_sdma_activity_worker(struct work_struc=
t *work)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(sdma_q=
, &amp;sdma_q_list.list, list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; val =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(dqm-&gt;dev) &lt;=3D IP_VERSION(9, 4, 2))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D read_sdm=
a_queue_counter(sdma_q-&gt;rptr, &amp;val);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D dqm-&gt;=
dev-&gt;kfd2kgd-&gt;hqd_sdma_get_counter ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dqm-&gt;dev-&gt;kfd2kgd-&gt;hqd_sdma_get_counter(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;adev, sdma_q-&gt;mqd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dqm-&gt;dev-&gt;kfd-&gt;device_info.num_sdma_queues_per_engine,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;val) :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; -EOPNOTSUPP;<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D read_sdma_queue_counter(sdma_q-&gt;rptr, &amp;val);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_de=
bug(&quot;Failed to read SDMA queue active counter for queue id: %d&quot;,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_q-&gt;queue_id);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR12MB86508C02519C5843127EAA3A8CEF2SJ2PR12MB8650namp_--
