Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEA7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 19:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DE010F842;
	Wed, 15 Dec 2021 19:09:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614C910F561
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 19:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQssS+UFvf0drEkO74ojO5M9W2qljCWv0rVcILxQZm6aN9fUtvFhhwlaHC7iWtbQDTnDhJgNOVEyXKGFN2PbZ6PnllWXDR72cEM7fRYWTyzgFW7nQV3AqeiK5uVm6v0rw2/oZkKBL5PdjD0Wwu9w2ca2+j4nt0NyV2EionxjHjkiVRXBWzHDJjSZh/huspFirFS2yyuGvAMk/48OT2Llx1WTdbB9LNwvME1h4fA/wJqZUrHHKiqpD5Lhp4A1f/KvctEV4W2nS7jmcoEGAacU8g0j0G3vcWTeCEkJNBmVpM8c9ZGX3hgj4ZFsJ5nip364ez8J5IvfL/yyE5PbSjxdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWEGlRh/I0l8oSRnI8e8JgyJuCm8LhJZxrQGSAfWsYM=;
 b=H8J9dn2FgI147OmeDdo+CxrAwDE7vdFJ3HkbGAEiA5VbXO9RmQ/edOIOtTYpuRpd1YL+I4KbjWy8TiRom1BUmuM8dGWzAnMlzHL22Mj+dUfcMFi6+kiJA0IpimZMCqW+Fba67AzXmPk48PAowAaY98Vc5Zad8Ro3BoXzPWtgvsYI5gp4Mn2myO6roL1BUNmyBBPhRiwjjobJwMwfMPZ4Ky+XRAEzs74oa1a4EbLwSnr7+ojUzr5tL0JmZA5MEfeO3qGjDvJJZWFE3+eXTvKGY9D+1psOLXHN41wlubvJsMH9xrZkM2TY0aiA+TgbTjfmC4UUgrgsS4LkpbGJo31Dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWEGlRh/I0l8oSRnI8e8JgyJuCm8LhJZxrQGSAfWsYM=;
 b=BmNwuXEA2GeyVQSqOMTeH+jRaxYwfLGsBuV472ctKFOoPZkW3gKKLqPriVS7OMhji8c3+1IhkJ41BD1ht9asi6OKgtAYpfpOD8jTyDeY3VLlq/HG+MS/m3SxfK9cDQJKxU2MQkl6y1YDGdlLlI13lSRXvPzroYmD+/lLyqbY6zY=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3605.namprd12.prod.outlook.com (2603:10b6:a03:ae::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 19:09:35 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::5425:7b82:3787:d5fa%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 19:09:35 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers
Thread-Topic: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function
 pointers
Thread-Index: AQHX8eVYWjzUjtJE00Wf/3svlKFDOawz6jQp
Date: Wed, 15 Dec 2021 19:09:35 +0000
Message-ID: <BYAPR12MB2840F88BACC359D89B1CC67EF4769@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-5-victor.skvortsov@amd.com>
In-Reply-To: <20211215185510.15134-5-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-15T19:09:34.961Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 85e8c1f4-2d8d-44da-84a0-c45337ffe770
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16fbbb01-4dda-46a0-0e34-08d9bffe6f2d
x-ms-traffictypediagnostic: BYAPR12MB3605:EE_
x-microsoft-antispam-prvs: <BYAPR12MB36053BA7CE141271797409A3F4769@BYAPR12MB3605.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUsxVRyfE2mneS6SwEu7q4bjmW/Xh45m+NYB4QJH8qWnRgVVccSPcIXXjJOPOVjyRxq4kFjQG+OBPOB0/lqvE/dLfcSUrTj4eEpf1kZ92TqQh9Dsy4gpqMSOr9e+l5RpnVZ5zTPwBVADzubpe3LXU5ObijAXav8nMEREAVjAF1wKuneEMuJIooP70+CGQT5M1oZLeA4bK7TFQx19oGhmIWcZB0/dCGENP0U88SCZNxUC4swXvXwEi8rmoLhUK/iHCifKv70b9tz4LBp8v1zK+RuWTHTznyv75Z3KL94+0CRmnWQo8uw4s3WcPFORZ47CJREszg8BYHP4asIrh4HiqVhi1HzupQJjDNL5nk8yM4jadEU5WymMXf59FR5BOEirw2bKsTL9JTM8q+CqZZFC8e7t50knITd79TIQyc2VkyHAcHJQdlENDQZAH+M65SAbFCtbYPWnFxMI5MaZn8GpUMn4VRpCYvy9b/RxEpYRqhYUmSjYRPeJcUE4vwH3MlE6cS2yMOzLy3WScVFhbV5/Tps1u2dnoub3s44MgKvyrqyaBeL88hO6QWVVZb+OoEHgzcHqK3+BY4zaKOTEiOhV1nHlI/LuKk46sOJRdSvuhRa/rk4skI9cqY9tRPX3DtL1YUo59A9zwXjvLTkoUyZXmF/+afKaTPI6dnyGcPbtBTXOgE+tphGlWi9UO01ag89CAlWpjiC1XXwUbBwidi8GMV7xxkuceOjBjyKCYVwkjm4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(921005)(7696005)(6636002)(110136005)(53546011)(8676002)(8936002)(6506007)(76116006)(86362001)(186003)(66946007)(64756008)(66446008)(83380400001)(66556008)(66476007)(2906002)(508600001)(9686003)(38100700002)(19627405001)(55016003)(38070700005)(5660300002)(71200400001)(122000001)(316002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g3JKsPZK2fXT8KyDARN8HGj124ExVicixe0abV4o12tmhyXJH8V2f3+2kKTl?=
 =?us-ascii?Q?FNDgW9FyDTw57yZc1e9DBA8zZUBMDpwjhneYP2iP7xVqdj1BVwafsgexTJwH?=
 =?us-ascii?Q?Tve0qNRRc++v1k+zRW/lOa+T5bPY1Dcy+iIr3Q0Ce7FJKgmS1t35LcgyzONc?=
 =?us-ascii?Q?WAaz+HkpxOQ2eRJPQp11tzI63dkGijpuE7zsP1jVpgq/qZ4fvT/ic+mAUhLw?=
 =?us-ascii?Q?xS+xMncZW5DlWVGZhhdGuJYyirQGN7wPmjsRQ/m/m0MxfbByHmRpm0XQNY4f?=
 =?us-ascii?Q?ioANCj2WJ2NZpgFu++gwRmx8UoaZPDPpi/H9DQfemDfmh5ce0ZQWu1TeApSb?=
 =?us-ascii?Q?/4xc8MEkSCE3Uzt8s7mFOHiv2LPsy5Eu//A6ALoTUs2rzvOgZpuVxwPwlLI2?=
 =?us-ascii?Q?zZVrXXmIWaa5AXpwcrx9syu8hIAYnBNX34wRGB/LvNrHeWIRneF3LFx1/sWL?=
 =?us-ascii?Q?1r8kegyHq47/aR252mSgbYbXWV1tL8+Hb0XrwSWNBRfD5GxHMa3j5qsODfyj?=
 =?us-ascii?Q?laTzWXZecbqE+6eoWUeDHH4Cw9toh7MvHTTMh5++yFER+t6fIeGfFV56MFkb?=
 =?us-ascii?Q?4eSKwaW674uK4ecXZ9FUYDdLjUnud0KjnP/XygKIhO9VJqdP1Bzq2BChdFnf?=
 =?us-ascii?Q?51RFtvct8Q0KWzA1HlAISdfX+/yXktUZWe3PSDAdsOzv7+pscl9PmjRyExcF?=
 =?us-ascii?Q?Dhsq1d7G6HRCwBFFMfBhuVbZpeZRByTIDRVAMOzuH/6zznGjxVQL7d7aken/?=
 =?us-ascii?Q?pQn7WpSVpvlvhqLWCva3Yxv9f0c32e7TYna4ULDahY+VlM2HvXk6f0W5sNz1?=
 =?us-ascii?Q?WBcZoVGliHaHAqmjydfEClMI3W70KU0vTgMCd3KijmuPzNC6FHDPEuJhyUuC?=
 =?us-ascii?Q?AM33hS8CovtbQzVtalOHJi3LpCsOd2olxgnpwActnJeXcGSufpRcM3zzGQ0b?=
 =?us-ascii?Q?tJQoZc052GJarjUHt/xbpPDMTsYCPt2O3nfjjaGYPYbce84Zui9TTTwzJe7o?=
 =?us-ascii?Q?eHqjxMiFEZ7FVLzmtiHE2W/rbUH5mvDmyqQrEnA38ex1M0mk+QKZbitW75A9?=
 =?us-ascii?Q?IZEnxbPptCi0a6DEczj/9sjvARCHjywu5vMghwU6AyO6+ESKzCh5+V5loUtQ?=
 =?us-ascii?Q?+qLCxJY0POvT1I9OUMqKtYhrIen+89l7Cb3b+UZtmO8LgIdrbykqgd8YYAk1?=
 =?us-ascii?Q?reLVd51/jliT/ccsYpnbPh5YhtTk3H0ObjtvE4xwUMWmjctMTVxxsTIGrsZV?=
 =?us-ascii?Q?Ar5cBqOdsWom786lQ5V+tC+tAfaStIgVnTDxpIcfDsfpIsemcKI4Gl5s+/SY?=
 =?us-ascii?Q?RyMkA1mOyDl+CJRvZnszbUABSoOZSh1+tLHma/r3U/bSS5N15T8E9hGp+j7J?=
 =?us-ascii?Q?rzVAwkjak0wPPPv7MwwcMQz5SrZPJChmVfemHp+ThDBX/gJ9IqMuG2SpMOOE?=
 =?us-ascii?Q?e291yfc6+wieGNQbD+EggPA8FfL91d36MusPiYIzT0ReVpdExMiQE/blnXRX?=
 =?us-ascii?Q?j+T1JIVQXw12zCV3cGuhH0AYPtWvxnLM2Sj78Xwyn6dFvSlWIrEEw8T63FDq?=
 =?us-ascii?Q?vW47ODkd9sYd0SQWqJJKBt33uQ1PpTMqr+tbd4Yw?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB2840F88BACC359D89B1CC67EF4769BYAPR12MB2840namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fbbb01-4dda-46a0-0e34-08d9bffe6f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 19:09:35.6248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbQjssbpGBmad1oqjTvaUgUzmSGxprKDTdskMUW94/2Eu0AWN3yALwCCaBwQcTpY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3605
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

--_000_BYAPR12MB2840F88BACC359D89B1CC67EF4769BYAPR12MB2840namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

         case IP_VERSION(9, 4, 1):
         case IP_VERSION(9, 4, 2):
                 amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
+               if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 2))
+                       gfx_v9_0_set_rlc_funcs(adev);
                 break;
         case IP_VERSION(10, 1, 10):

I think for the above, it would be more clear just to separate them:

case IP_VERSION(9, 4, 1):
    amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
    break;
case IP_VERSION(9, 4, 2):
   amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
   if (amdgpu_sriov_vf(adev))
       gfx_v9_0_set_rlc_funcs(adev);
   break;
________________________________
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Wednesday, December 15, 2021 10:55 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deng, Em=
ily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.=
Ming@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zh=
ou@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Ch=
en@amd.com>; Nieto, David M <David.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers

In SRIOV, RLC function pointers must be initialized early as
we rely on the RLCG interface for all GC register access.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 65e1f6cc59dd..1bc92a38d124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -844,6 +844,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amd=
gpu_device *adev)
         case IP_VERSION(9, 4, 1):
         case IP_VERSION(9, 4, 2):
                 amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
+               if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 2))
+                       gfx_v9_0_set_rlc_funcs(adev);
                 break;
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index edb3e3b08eed..d252b06efa43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -816,7 +816,6 @@ static void gfx_v9_0_sriov_wreg(struct amdgpu_device *a=
dev, u32 offset,
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
-static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
                                 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)=
;
@@ -7066,7 +7065,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_devi=
ce *adev)
         adev->gfx.cp_ecc_error_irq.funcs =3D &gfx_v9_0_cp_ecc_error_irq_fu=
ncs;
 }

-static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
+void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
 {
         switch (adev->ip_versions[GC_HWIP][0]) {
         case IP_VERSION(9, 0, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.h
index dfe8d4841f58..1817e252354f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -29,4 +29,6 @@ extern const struct amdgpu_ip_block_version gfx_v9_0_ip_b=
lock;
 void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_=
num,
                            u32 instance);

+void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
+
 #endif
--
2.25.1


--_000_BYAPR12MB2840F88BACC359D89B1CC67EF4769BYAPR12MB2840namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 case IP_VERSION(9, 4, 1):</span><br>
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 case IP_VERSION(9, 4, 2):</span><br style=3D"color: rgb(0, 0, 0); font-fam=
ily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;=
Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &quot;Helveti=
ca Neue&quot;, sans-serif; font-size: 14.6667px; background-color: rgb(255,=
 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 amdgpu_device_ip_block_add(adev, &amp;gfx_v9_0_ip_block);</span><br style=
=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI =
Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, &quot;syste=
m-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6=
667px; background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
 if (amdgpu_sriov_vf(adev) &amp;&amp; adev-&gt;ip_versions[GC_HWIP][0] =3D=
=3D IP_VERSION(9, 4, 2))</span><br style=3D"color: rgb(0, 0, 0); font-famil=
y: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Se=
goe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif; font-size: 14.6667px; background-color: rgb(255, 2=
55, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 gfx_v9_0_set_rlc_funcs(adev);</span><br style=3D"color: rgb(0, 0, 0); font=
-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &q=
uot;Segoe UI&quot;, -apple-system, &quot;system-ui&quot;, Roboto, &quot;Hel=
vetica Neue&quot;, sans-serif; font-size: 14.6667px; background-color: rgb(=
255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 break;</span><br style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI=
&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -ap=
ple-system, &quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans=
-serif; font-size: 14.6667px; background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 case IP_VERSION(10, 1, 10):</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">I
 think for the above, it would be more clear just to separate them:</span><=
/div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">case
 IP_VERSION(9, 4, 1):</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;"><span style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 25=
5, 255); display: inline !important;">&nbsp;
 &nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v9_0_ip_block);</span><br=
>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;"><span style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 25=
5, 255); display: inline !important;">&nbsp;
 &nbsp; break;</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;"><span style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 25=
5, 255); display: inline !important;"><span style=3D"margin: 0px; color: rg=
b(0, 0, 0); background-color: rgb(255, 255, 255); display: inline !importan=
t;">case
 IP_VERSION(9, 4, 2):</span><br>
<span style=3D"margin: 0px; color: rgb(0, 0, 0); background-color: rgb(255,=
 255, 255); display: inline !important;">&nbsp; &nbsp;amdgpu_device_ip_bloc=
k_add(adev, &amp;gfx_v9_0_ip_block);</span><br style=3D"color: rgb(0, 0, 0)=
; background-color: rgb(255, 255, 255);">
<span style=3D"margin: 0px; color: rgb(0, 0, 0); background-color: rgb(255,=
 255, 255); display: inline !important;">&nbsp; &nbsp;if (amdgpu_sriov_vf(a=
dev))</span><br style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 25=
5, 255);">
<span style=3D"margin: 0px; color: rgb(0, 0, 0); background-color: rgb(255,=
 255, 255); display: inline !important;">&nbsp; &nbsp; &nbsp; &nbsp;gfx_v9_=
0_set_rlc_funcs(adev);</span><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
&quot;system-ui&quot;, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant;">&nbsp;
 &nbsp;break;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Skvortsov, Victor &lt=
;Victor.Skvortsov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 15, 2021 10:55 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com=
&gt;; Ming, Davis &lt;Davis.Ming@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@=
amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;; Chen, JingWen
 &lt;JingWen.Chen2@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; N=
ieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Cc:</b> Skvortsov, Victor &lt;Victor.Skvortsov@amd.com&gt;<br>
<b>Subject:</b> [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function p=
ointers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In SRIOV, RLC function pointers must be initialize=
d early as<br>
we rely on the RLCG interface for all GC register access.<br>
<br>
Signed-off-by: Victor Skvortsov &lt;victor.skvortsov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 3 +--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 2 ++<br>
&nbsp;3 files changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 65e1f6cc59dd..1bc92a38d124 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -844,6 +844,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v9_0_ip_blo=
ck);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; adev-&gt;ip_versions[GC_HWI=
P][0] =3D=3D IP_VERSION(9, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_set_rlc=
_funcs(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index edb3e3b08eed..d252b06efa43 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -816,7 +816,6 @@ static void gfx_v9_0_sriov_wreg(struct amdgpu_device *a=
dev, u32 offset,<br>
&nbsp;static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);<br>
&nbsp;static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);<br>
&nbsp;static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);<br>
-static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);<br>
&nbsp;static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_cu_info *cu_info);=
<br>
&nbsp;static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *=
adev);<br>
@@ -7066,7 +7065,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.cp_ecc_error_=
irq.funcs =3D &amp;gfx_v9_0_cp_ecc_error_irq_funcs;<br>
&nbsp;}<br>
&nbsp;<br>
-static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)<br>
+void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[GC_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.h<br>
index dfe8d4841f58..1817e252354f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h<br>
@@ -29,4 +29,6 @@ extern const struct amdgpu_ip_block_version gfx_v9_0_ip_b=
lock;<br>
&nbsp;void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u3=
2 sh_num,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; u32 instance);<br>
&nbsp;<br>
+void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);<br>
+<br>
&nbsp;#endif<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2840F88BACC359D89B1CC67EF4769BYAPR12MB2840namp_--
