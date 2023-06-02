Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92098C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 16:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D780210E5C8;
	Fri,  2 Jun 2023 16:38:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753FB10E209
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 16:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqP+px2AXGw8qQd24YxQdPz7TTFzLqjDaZ+/bFEKYJPWoys66FYn04QsshS4/JQh7BeKcla77C/RjkVbBpcW7qKd2pgpbdKGMJhfxvS/86S0x8i/Vy4MntikPpaY1X+0XmftQI6kVfHtgtEnB5HKOWmjaZkWXmPM0s2uCs2NbWg5VasJy9qec5JrxGubwjbPO3aKcqRY311fZbqDSJod9U6OV2WTj0zKhKd3WlvyIh46Z7mlUVkyt341knLdD/OTcB6wkcjwXTBYnBwnfSxFaI+25TafpnTrKUEBuWAgWk33wRI43EeuEWG4PTbysKw19Yun/QNizVE9/RS6ZOBCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk6p4QOb2UaA8mIcGIPaxCu+BMWaVgZ8JZH2Wo4Mj3A=;
 b=kAOadwzlPosO4JVPyIwa/QAp+o/JZJnRCOPdX/tL1KkRkMBhF1f5C87itQVsgV6XOjffjN3qIYneN+CUBBLmFIvb5FxRNiWM3UqbfWYrz+xxLVp0QyLiYJcZ7G4StQQjKlIZDevcM7oJvmQATrXTOahwqphEjNH2yV2MF8pgVc+YtMD9eEK+PIOwNxh1nMFbHPscrmattjaODwZPF/fgp7Cln31bAcQ3nkWfPuJ5kPeQf1WI7jAXV8tAYcb+emGXQOar9E2lIwXxUIip+dMcOCJzaf8E4A6603hj+AubXuFmqVLVfktz6Hc/Z8YEGnA9Myt7nY88jzVb5vUsYgrglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk6p4QOb2UaA8mIcGIPaxCu+BMWaVgZ8JZH2Wo4Mj3A=;
 b=HdxLfBMEYmaWUCNKlbHtHlgCDNtYFkO4beVf8xYySowKGJeeluVNsfOMnK0Q05Jdh7TsaFNMFrm0QCvmqSC8WVMWCeb39Qo/PWvKvU5AbwqZhQ2DyOUSL1t0V/GxoiL44G2MPWu5AvwWnjGORH0CKbwASQDglMs8DvfrIJ3bwvs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 16:38:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 16:38:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Mark 'kgd_gfx_aldebaran_clear_address_watch'
 & 'kgd_gfx_v11_clear_address_watch' functions as static
Thread-Topic: [PATCH] drm/amdgpu: Mark 'kgd_gfx_aldebaran_clear_address_watch'
 & 'kgd_gfx_v11_clear_address_watch' functions as static
Thread-Index: AQHZlWpXQY8PnpW5R0CzpTXfpMz4ua93tj8h
Date: Fri, 2 Jun 2023 16:38:00 +0000
Message-ID: <BL1PR12MB5144E1DFE0B37F5EF11C913CF74EA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230602155251.1729429-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230602155251.1729429-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-02T16:37:59.625Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB5860:EE_
x-ms-office365-filtering-correlation-id: 6ee7bebf-ecf8-47b8-9527-08db6387ba9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/P2X977dalQTiGvnKIhGtuDfA3dzDPkYnnw0UoZFp3WxBQBC8x0rM7dtwSK53+kYJ1L5le9OQ6NxH3C+A8TjH/pKsf/wHg4IB/q9Gip2Jl8F/K78B4so6ef5NuIohSMJlI3pfdzwsE8XBazdFOpmDjnqhl9yJiPeWqmWgEtbmKvtRerMlrEFC/KIatFqn5P4ThiiyTplhe8sIUoK8QhphcNF/qmFWLLfgXkhU3K3GjLe8Pj9/xQvvC52iHL3o1XRe1JHj69bAlyIbTPRspepaBO2WrK79imxD6mNOCsWEuvuPlD7bnRJTHJfmTdY8ctlr68HEwgy2V7z0llNKeBJ70f/J75vcvyZNyup6nPgkcZqLTfoLGXC3536PE/6ZZM5iMo06lplyrd56eHKD1D2PQG6KlUI7f0mO80fdYwaPyRtmJJEBfQi+rGrQuNc9GcrsXwGt8n6rX5Ojhuo/n8qZ6CWnJ4Rs846A5LrEi89fiAGuBB0Q7Sle4sDKBrfrxUmczcNsYiaEqiGV27JCRmgABSYk4/bL03aPVw2/7j7/AE8vXwGWxNhsJbOkNK0u5K1ZI/hqdqGy2YGHrNpn1Kj2z5xbvlqyF0+PhAAiLXc8/YUmNHJLRjmKX2Az2y8yXX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(41300700001)(316002)(110136005)(2906002)(5660300002)(52536014)(478600001)(8676002)(76116006)(66946007)(19627405001)(66446008)(66476007)(66556008)(8936002)(4326008)(6636002)(64756008)(71200400001)(7696005)(122000001)(33656002)(53546011)(9686003)(186003)(55016003)(6506007)(26005)(66574015)(83380400001)(86362001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?yf6OuiWw0dR0ADWbQLKztcvb8c+bpFeAAJlEiarlf8M7aFQ4OoGV+XPC?=
 =?Windows-1252?Q?cVWRcUGNNQp+ZblGP20CV1BiHzobANMGDIQxV+fl4l6b0VC/oEmb2r/n?=
 =?Windows-1252?Q?F9uQM3rzEMBaqmd7g+DevvRncB1FUzYKyiGFd9TDOlqZIuBCshe/4Fn2?=
 =?Windows-1252?Q?BH907f/XwRchfLWuRZGR9rPBAfkNz14H5hCGclIsiqXWOgX453Z2n6Pr?=
 =?Windows-1252?Q?S0+lNQNDjt7FtW/ejYoS+7NVixOxj7k7EeO/OJF0eZ8dGDmlZKSCIHBT?=
 =?Windows-1252?Q?ROuPbxU2aRkuni014ZWkPBQf6LZFM3SYO+G9TQPDh3QsHxloP68ZMiIY?=
 =?Windows-1252?Q?bhZ6Q5d3tpudMOrDslK5jPVIzk8qU2hAdxwZOXHH9l6hz6LBdwt31UjS?=
 =?Windows-1252?Q?UzQs12354mLG7gHtZndAS8ZXkLkGMe0mfaMK08uyIcALFK2LyebJSiQK?=
 =?Windows-1252?Q?FJldTvA5mNkZDof7YoBUz3GoyyKAGrrI9KR0l/cfC3E8nYDqBgCs5+64?=
 =?Windows-1252?Q?cew7iKenCh3S7d14rVNKX1S008l0R8qMCjunKgbFVORxA6/TGvh8hsyk?=
 =?Windows-1252?Q?fqbTgNtePahyyqf9wrx/dN4aplM6tGSMT67bQS8oFGKnhD4zQxWxtkvm?=
 =?Windows-1252?Q?IvPIVVc6pnbel8hyZRm/ebNpGINFTI1NLiK0/Ork/h2atDtBTxH0xq8d?=
 =?Windows-1252?Q?5ATJgYe19saqW8mEWgnPP/K3NJZYtg5afY4Nyh/v6CDsq8rxl4dyVihQ?=
 =?Windows-1252?Q?xb6RX6MQG8QkvjunQ12jrKTJCV5YOnJae6WTwX98XAqyHYr8G9sPcDs/?=
 =?Windows-1252?Q?w50ts+MqKfpvKgeoVTYzb6jwanYRMN/w4Q+Y9bCRqej+NWKbby1dUOK6?=
 =?Windows-1252?Q?BWg5HwjJqHrolxS5L9eQUYJnd+XQTdAdVIldvuscA8SYPjrJ4FCnQ9qB?=
 =?Windows-1252?Q?jg2+Yg2CiSqG0PD81un8nl7X/mWg319SROAZKOiVOadRalNJbVrENWCn?=
 =?Windows-1252?Q?T25FBY5l9YfH5Y0Q53oshe6GH9rB66APb/sjIoQZhmjMdkp5KoSvvkWr?=
 =?Windows-1252?Q?tQq/7/4oBvBomkOJrU2SiEetyRa8Z4VTx1Ky76wBx/m8yfJYhW8o0xOz?=
 =?Windows-1252?Q?ilolRpSyQ89bYV4s2GWir6pwxPjZlrvgR8UXGZ/lfZDmpw462hZpkRPm?=
 =?Windows-1252?Q?mur9aCE/eTyJHuHZmjp8IvyvejBWpYGb6gXV/+ChcR9J5xipozeFlwAT?=
 =?Windows-1252?Q?+C9usWfm8WsLhMFNemg68q0HKcJuRTd67bTpckEL3FKXzZrQDbgSM4M7?=
 =?Windows-1252?Q?dajz2tG6GLcUD7FRhhr1kQGnd738w+36Vj2Ttxb5l1NgyqJbtiytnKtx?=
 =?Windows-1252?Q?qZlp+hRqC+40Nl/x7vG7MjV2qz7noqz6XHvx9Q+4JK0ws2e0scGQxMQM?=
 =?Windows-1252?Q?vqJEL8n5m4LaD0IlkcsKVbzCvzpjAKkhXH+ABCFTghK7MbUByYbPoh3O?=
 =?Windows-1252?Q?9Hd5SXinmVkvXlUU5tAZdoTpJQraUYgVTw10vYb7I5/m9zjeB/Yj9SbP?=
 =?Windows-1252?Q?/UvtRHAsZoDp6qPnRaC0g4jUTqTxmbdSHgO3eLiC32yxubxMZNmfsPvO?=
 =?Windows-1252?Q?63mqNh4itOKXHNuCBrnEJYvYGVJ1K3z4gsYeb6kqAilXi+hZ2n3fZ8Gs?=
 =?Windows-1252?Q?FLIfo+FuJVg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E1DFE0B37F5EF11C913CF74EABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee7bebf-ecf8-47b8-9527-08db6387ba9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 16:38:00.5262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5V69tCsnFi86zTjoApqNxvgukZzaM/VJshsbUghA3NtQOh5RW5QQ6O14Nxs+P8JBZy9lQRqlnzmu52nBh/VRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144E1DFE0B37F5EF11C913CF74EABL1PR12MB5144namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Friday, June 2, 2023 11:52 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [PATCH] drm/amdgpu: Mark 'kgd_gfx_aldebaran_clear_address_watch' &=
 'kgd_gfx_v11_clear_address_watch' functions as static

Below two functions cause a warning because they lack a prototype:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c:164:10: warning: no pr=
evious prototype for =91kgd_gfx_aldebaran_clear_address_watch=92 [-Wmissing=
-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c:782:10: warning: no prev=
ious prototype for =91kgd_gfx_v11_clear_address_watch=92 [-Wmissing-prototy=
pes]

There are no callers from other files, so just mark them as 'static'.

Also fixes the following checks:

CHECK: Alignment should match open parenthesis +static uint32_t
kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
uint32_t watch_id)

CHECK: Alignment should match open parenthesis +static uint32_t
kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev, uint32_t
watch_id)

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index efd6a72aab4e..60f9e027fb66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -161,8 +161,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
         return watch_address_cntl;
 }

-uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
-                                       uint32_t watch_id)
+static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device=
 *adev,
+                                                     uint32_t watch_id)
 {
         return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 52efa690a3c2..91c3574ebed3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -779,8 +779,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct am=
dgpu_device *adev,
         return watch_address_cntl;
 }

-uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
-                                       uint32_t watch_id)
+static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev=
,
+                                               uint32_t watch_id)
 {
         return 0;
 }
--
2.25.1


--_000_BL1PR12MB5144E1DFE0B37F5EF11C913CF74EABL1PR12MB5144namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Friday, June 2, 2023 11:52 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehlin=
g@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Mark 'kgd_gfx_aldebaran_clear_address_w=
atch' &amp; 'kgd_gfx_v11_clear_address_watch' functions as static</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Below two functions cause a warning because they l=
ack a prototype:<br>
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c:164:10: warning: no pr=
evious prototype for =91kgd_gfx_aldebaran_clear_address_watch=92 [-Wmissing=
-prototypes]<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c:782:10: warning: no prev=
ious prototype for =91kgd_gfx_v11_clear_address_watch=92 [-Wmissing-prototy=
pes]<br>
<br>
There are no callers from other files, so just mark them as 'static'.<br>
<br>
Also fixes the following checks:<br>
<br>
CHECK: Alignment should match open parenthesis +static uint32_t<br>
kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,<br>
uint32_t watch_id)<br>
<br>
CHECK: Alignment should match open parenthesis +static uint32_t<br>
kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev, uint32_t<br>
watch_id)<br>
<br>
Cc: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c&nbsp;&nbsp; | 4 ++=
--<br>
&nbsp;2 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
index efd6a72aab4e..60f9e027fb66 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c<br>
@@ -161,8 +161,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return watch_address_cntl;=
<br>
&nbsp;}<br>
&nbsp;<br>
-uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t watch_id)<br>
+static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device=
 *adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; uint32_t watch_id)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
index 52efa690a3c2..91c3574ebed3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
@@ -779,8 +779,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return watch_address_cntl;=
<br>
&nbsp;}<br>
&nbsp;<br>
-uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t watch_id)<br>
+static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t watch_id)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E1DFE0B37F5EF11C913CF74EABL1PR12MB5144namp_--
