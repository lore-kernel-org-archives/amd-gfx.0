Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C90AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 17:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B60410E79A;
	Thu,  8 Aug 2024 17:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XInonv+o";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8085110E79B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 17:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwWT0k/alB7R42c78tt0HEOYU1mvbtQxIwaz7HY0DuJpzRMVSjHyhSSYla209jcYaHvPx4mstW8p+wCz8Lnp3gAEq3H0zp3CHqmzkriYHqjfCHd9NeszlHNnnhNhATa4j6YnBYt1qsrGDt/jTVNr/TfWw2/ughOSaZzJjN/38+6kU1wjoXfTknp24/NYOo8OhAnVYvpyoYZggAfNlVS6xw8ALIF9d3rf0FgAmn8U4CWPYTrIoeZPWE58fzMuNJVANVWIzWhrNBKBMg0BMbs7LwZk+vZFfMJ5bUMPW46xCB6jtOflweUOs/u5JcWloJWLCRjrvYkJXyLZfD9JtzpuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKLY9wxIzSKwmOE9K9Ei/Ba7OdwWqbwU+er2/RYf8Lg=;
 b=wx7NT9CAaRzVQe5P+5/BjG+7GyRFIm6jGJ5LOx1Sknjy2Wscqy0UBsBuN9XSElvibxs6e+mYD3sQ92vof5BhU30ZDAy1Y2i8VAfL8NwgLsreA+UOqgCnfVYlYSUMDPF5h31gqTdwuhHKL1urTAjMVPBFyUz45mV48V4bdKt9ORPS1J+svKYwoyZfLHvJC5XZ32e7pAZz0y6SOXjI/40F2D+zPJYSm+SalmMwlyGtRRhsQLLmOZYZmvfdzSQxMVst0PUHaWy6ZD+eIlPrvkeS7VGd9xjeE8Sxn7F8MRjD/bKlxl23NUAgUT9jxe8Vdh2UItlakm6ZzF2pQQTxwen+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKLY9wxIzSKwmOE9K9Ei/Ba7OdwWqbwU+er2/RYf8Lg=;
 b=XInonv+orpWuMJLCtU51Bez4pRexhxyNHw/gQsCMSQz9/DvK2W1mTQBvP+YBjxlc2mfwDB+r9/KlzqXMUjKFyBVZcWRsmuk8Z+fR9hetsr9lde6c0RW9LEa2wbwXIjlPwf0qrC3uie7GHXnvDCdD5LmzmG6ziKqmt9ciyBrI+cs=
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 17:00:00 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 17:00:00 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 98, Issue 214
Thread-Topic: amd-gfx Digest, Vol 98, Issue 214
Thread-Index: AQHa2IlC5btgl9qVnkuTCh4ivxdh8LIdt4Ug
Date: Thu, 8 Aug 2024 17:00:00 +0000
Message-ID: <PH7PR12MB6420B63DDB46A7FB5EC1284E81B92@PH7PR12MB6420.namprd12.prod.outlook.com>
References: <mailman.771.1721248687.1134.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.771.1721248687.1134.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T17:00:00.256Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6420:EE_|PH7PR12MB6810:EE_
x-ms-office365-filtering-correlation-id: 00610be5-fb55-4b96-8610-08dcb7cb8a59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|4022899009|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VPNOLBVtumSD2Xhk/3MaBpKs1NZCfh+Op33McRjjS+QMVc+w2qME8JvxPCjD?=
 =?us-ascii?Q?ETp4SPBf+K9xe5TpCAm5vEWjn9GppIMUsf5qUVIJqT2xIvQgsMvTKM5fFXy1?=
 =?us-ascii?Q?mhaBCKNVtPMnq1H75rDfROCKXaiFVUCDwxdGlsFM49bAHKn7GxPiKLN7m3Nj?=
 =?us-ascii?Q?u3YQrBGGExOtQZ0X8BReS+qs489cR+Q+5LoUvfPbl0y3FZAy/l4ugxV0l8NQ?=
 =?us-ascii?Q?8Xt25MYgEknuErEZ3mwKo+umVm77KvwQETppGJp7EFyLb6sCJBMnpLZyAVDZ?=
 =?us-ascii?Q?nOfxlZN6AlS9yIP3Gbao69CxuF4OeeeXweXkalXgV+n7GTZU3ko5TTyasXRz?=
 =?us-ascii?Q?at2rrYMQnQxls80sRRoIo9cBJmcxwdC3p/EMs2CQiD2IYcrxEVsPbDCv+Dzt?=
 =?us-ascii?Q?E0pew7zHeUZJNYmybEOThj+ecqbzCVO0J97lVIFx2uIusv91m5Nvi713l0fT?=
 =?us-ascii?Q?SU08avRztR3KQqXVPaB6zztK1kHdtWfnuJO3mBhdKYz87NoZIZ2xZwqwdzKL?=
 =?us-ascii?Q?ZGPvccZwOz4tNsXFNOPDB3Veauxf5JtbA7HCuPCdl/JkxD2kDqAzw5j7/7FU?=
 =?us-ascii?Q?J7viM4VeulKCNhZgAInWhnfAr0TPNSRGoEJIWgWKh6RkGo9FyBkEfywqEvJ1?=
 =?us-ascii?Q?p5ce/XdmHfDC8XUSrc6FlvXxMmK43ng45sGTem3c52Mq8xcRR1P1WjEgiyRh?=
 =?us-ascii?Q?O1wegi4ZnAuPROjtb5f0bzjDzpcpwa/oiwq236TW0hkT2zPt2NcjCd+5qGyG?=
 =?us-ascii?Q?AfybTb8wMOnP1kPGs5tXmHyBQqbO5K3pPOErbaqMCKUFRu7DcjI3jOM+V9Nt?=
 =?us-ascii?Q?WP9wqzUa3Em+ZVWtHvpJKLYl/vygQzfAfDnsNPgePXCcMrunfS3sy/0kBvni?=
 =?us-ascii?Q?87zJWr6OfqHGbNwosEsjGAO+OCIHdTr7SAfCiKs5ZVl4F3RQW82YYhzeewRp?=
 =?us-ascii?Q?it3f/opR6tq6xiHrFM06UEQtBB0xhnHnewki1Iu63she7ZuxYZHzJOtYAhMV?=
 =?us-ascii?Q?9ynxDVsS2X83lheivBKCed9BH2p41U52y6PsQIcNEL+jwTkwoL5nTN8iw/SI?=
 =?us-ascii?Q?dWwl/JCq3/N2zIMUtXZxH13leiVkiYkxiMI8wKtx7GAnuVOrQfTdbNhEwAZ8?=
 =?us-ascii?Q?cHFKNhi4NlMugUx6aKc843wDtWbvdotuGvV2zyKvmwsIWh+S93fLWMuI3LlP?=
 =?us-ascii?Q?ynj/OIKeo+0hF4N9CYmLiwcGRWUTJScB///3bHi3kOWERUkV3HeP9WWkN6J2?=
 =?us-ascii?Q?//DPrbu5nJRuOeoazba8XnHvW5cTJc8EUy2cMBofZp/Ci7p3sWjg1nY7wFcz?=
 =?us-ascii?Q?ra1NLPRknRubyQv1DCoujKhzdsWNtke90m4pvdKjj0FQzv68ycyYpFbH0xpo?=
 =?us-ascii?Q?pl1jiF4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GiFUGKMbHUsv8HK3ZsR4Ans74Ar8lPjsb0eVECf7ftiQ3OFLg1YR/b3lTFVR?=
 =?us-ascii?Q?LhzQlGiSieLuriJa5pPYPF113xwPIWpnCrCRLXJ1nlrh4h3E94hqcz4DwjbG?=
 =?us-ascii?Q?jllggXzcpupBT1wxpO6zsKnEKREdwtDaTAycetCznMGuTq16pPM402XCytv6?=
 =?us-ascii?Q?6WLl/aTWdcGPlLPoucc80JPtQj//YkoMtg8sVssbnwl0wQJkQlJK5vQxXYyJ?=
 =?us-ascii?Q?DmfKO3C9oMLb19fMaPlTXkeR40EgUP7oqq9xq+4jQCf/Cd3BxO23PoGbzHJM?=
 =?us-ascii?Q?RJc8mdBlW7QlunWjEayWtNKmov8QLkI6DF+gPAU/Hz9hPqEBhjIxANFgYBj3?=
 =?us-ascii?Q?d4Hp42EITA5qAhLQxidwWii5n/KNPHMsXYFKv8i++MoI51lB+myycwGckLEu?=
 =?us-ascii?Q?mcsy6b5CqVIIQsKFOkujKWNfK8QIKNEBy5EzZx4AYKEHBi2Py5IqNVv+RPGh?=
 =?us-ascii?Q?SI8lAKzvQA1D16wrUzvu8siiIAEE4m9TbT20Kpdwple/iDF+/+X6fxE1H1Yz?=
 =?us-ascii?Q?Dw/5dW5lvGDEaMBBNioLbCeMke5arfhdSnmv4k3qK9VAwADdsPNNCcp1Z0M/?=
 =?us-ascii?Q?fRwmMoE3KstpoVdrk7GdOFK5z6oLhe8Bu8hBH9ktPV1jQb3ttVpSCxGPPgvA?=
 =?us-ascii?Q?/PhHj9aRZ0gWFHM6D4Gs6WFu/Zvzd77O7Q12sSdKBMTjSJmOiTCv5CBRDEic?=
 =?us-ascii?Q?EXdPv3vrUwnlOgnShxRfD+zoiu4epwz+cH7p+iJCYMbmI7krlBjQCyj7cMp/?=
 =?us-ascii?Q?L9obqdP5/UYJq4glR11Qmora6/F5sPjvzUIHsvUDvtWO+mRvVubCNMOwvmHg?=
 =?us-ascii?Q?rMdilF4GQsTbZQplMdx5EEsyaU/NzhgeLId4uL4anQ4D3KOlFJw1d77EWM5q?=
 =?us-ascii?Q?9IdBhz61y6WK4AAGJnvsunWf03MhpUE7TIyhOxALXaM6bLdjbdKgZgoj6uro?=
 =?us-ascii?Q?2BVfnjDgirnkoVBzTkqsRggoGk9vhiN6heDclgF+LRUVx7urTKlpWp1/Sh6l?=
 =?us-ascii?Q?UFVBOafqU9OdOjxH6hjJo8KG4wExZCkXANzU1OOgjzZN6oISo1V9BXJUTTTJ?=
 =?us-ascii?Q?FQ2BH+W0ohQlqzrKTO24pN80NrYj5K3vZbBEVld03S7D1ZhSGay3ZErlefYd?=
 =?us-ascii?Q?zAoBpIGE9Wp+ZFi4UulDKdT/Yewk5cKfArliZ6j1xfnyJzfF9oumeBR1hX79?=
 =?us-ascii?Q?iNRXdLXVct3vqKu3Xcx+IhI58ugGVYpStiH256XXEmrZVP3Y3OGXhvmTx6aS?=
 =?us-ascii?Q?zvhHvQUpFDMPQjb3icOBNNuzTBc/FW9Jyw1W+cfJlmP28Sxb1mHcsDGqvcqN?=
 =?us-ascii?Q?Y9vMMmZHP5HoMmhwYIz/jpvegKG2yeJsNUlN+nmAnelqm3AVsScQVBFBDv9O?=
 =?us-ascii?Q?eph9zCWyQI8HAf7cJsKoAa9zzWMd10oQi/Lrc40+uobKvnCfGWhkddDvOhAa?=
 =?us-ascii?Q?dguqeHid4fQSs8W3rdbaO2Pf2lLsHKiZVM4px+sKkED9QkOGrrwUmn2Dva2K?=
 =?us-ascii?Q?nOc57iCPzWYN1WeW6Gnhz3EbvMSEss4bKlMtCW9VqOr8Yf9m3yE8LA2AbamR?=
 =?us-ascii?Q?3iU4xg8ekxuNy49u/ZM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB6420B63DDB46A7FB5EC1284E81B92PH7PR12MB6420namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00610be5-fb55-4b96-8610-08dcb7cb8a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 17:00:00.6805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bthb2PyguN45g4odqWJLm/EYZXgIZlXdj+8HqXMi8InEIHkzmzud9vzhoN4ml/RiOvYDtQKGiWulPVlVzPJW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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

--_000_PH7PR12MB6420B63DDB46A7FB5EC1284E81B92PH7PR12MB6420namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Wednesday, July 17, 2024 4:38 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 98, Issue 214

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. [PATCH 2/7] drm/amdgpu/gfx8: enable wave kill for compute
      queues (Alex Deucher)
   2. [PATCH 3/7] drm/amdgpu/gfx9: enable wave kill for compute
      queues (Alex Deucher)
   3. [PATCH 1/7] drm/amdgpu/gfx7: enable wave kill for compute
      queues (Alex Deucher)
   4. [PATCH 6/7] drm/amdgpu/gfx11: enable wave kill for compute
      queues (Alex Deucher)


----------------------------------------------------------------------

Message: 1
Date: Wed, 17 Jul 2024 16:37:35 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/gfx8: enable wave kill for compute
        queues
Message-ID: <20240717203740.14059-2-alexander.deucher@amd.com>
Content-Type: text/plain

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index b4658c7db0e1..a1963e6c5cab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6955,6 +6955,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_f=
uncs_compute =3D {
         .insert_nop =3D amdgpu_ring_insert_nop,
         .pad_ib =3D amdgpu_ring_generic_pad_ib,
         .emit_wreg =3D gfx_v8_0_ring_emit_wreg,
+       .soft_recovery =3D gfx_v8_0_ring_soft_recovery,
         .emit_mem_sync =3D gfx_v8_0_emit_mem_sync_compute,
         .emit_wave_limit =3D gfx_v8_0_emit_wave_limit,
 };
--
2.45.2



------------------------------

Message: 2
Date: Wed, 17 Jul 2024 16:37:36 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu/gfx9: enable wave kill for compute
        queues
Message-ID: <20240717203740.14059-3-alexander.deucher@amd.com>
Content-Type: text/plain

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 2929c8972ea7..d4e38edc9353 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7244,6 +7244,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_f=
uncs_compute =3D {
         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wait=
,
+       .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
         .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
         .emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
 };
--
2.45.2



------------------------------

Message: 3
Date: Wed, 17 Jul 2024 16:37:34 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu/gfx7: enable wave kill for compute
        queues
Message-ID: <20240717203740.14059-1-alexander.deucher@amd.com>
Content-Type: text/plain

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c
index d84589137df9..5fbdef04c9aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5002,6 +5002,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_f=
uncs_compute =3D {
         .insert_nop =3D amdgpu_ring_insert_nop,
         .pad_ib =3D amdgpu_ring_generic_pad_ib,
         .emit_wreg =3D gfx_v7_0_ring_emit_wreg,
+       .soft_recovery =3D gfx_v7_0_ring_soft_recovery,
         .emit_mem_sync =3D gfx_v7_0_emit_mem_sync_compute,
 };

--
2.45.2



------------------------------

Message: 4
Date: Wed, 17 Jul 2024 16:37:39 -0400
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu/gfx11: enable wave kill for compute
        queues
Message-ID: <20240717203740.14059-6-alexander.deucher@amd.com>
Content-Type: text/plain

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index dcef39907449..554aae995f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6603,6 +6603,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_=
funcs_compute =3D {
         .emit_wreg =3D gfx_v11_0_ring_emit_wreg,
         .emit_reg_wait =3D gfx_v11_0_ring_emit_reg_wait,
         .emit_reg_write_reg_wait =3D gfx_v11_0_ring_emit_reg_write_reg_wai=
t,
+       .soft_recovery =3D gfx_v11_0_ring_soft_recovery,
         .emit_mem_sync =3D gfx_v11_0_emit_mem_sync,
 };

--
2.45.2



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 98, Issue 214
****************************************

--_000_PH7PR12MB6420B63DDB46A7FB5EC1284E81B92PH7PR12MB6420namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of amd-gfx-request@lists.freedes=
ktop.org &lt;amd-gfx-request@lists.freedesktop.org&gt;<br>
<b>Sent:</b> Wednesday, July 17, 2024 4:38 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 98, Issue 214</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Send amd-gfx mailing list submissions to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request@lists.freedeskto=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner@lists.freedesktop.=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. [PATCH 2/7] drm/amdgpu/gfx8: enable wave kill for compute<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queues (Alex Deucher)<br>
&nbsp;&nbsp; 2. [PATCH 3/7] drm/amdgpu/gfx9: enable wave kill for compute<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queues (Alex Deucher)<br>
&nbsp;&nbsp; 3. [PATCH 1/7] drm/amdgpu/gfx7: enable wave kill for compute<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queues (Alex Deucher)<br>
&nbsp;&nbsp; 4. [PATCH 6/7] drm/amdgpu/gfx11: enable wave kill for compute<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queues (Alex Deucher)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Wed, 17 Jul 2024 16:37:35 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 2/7] drm/amdgpu/gfx8: enable wave kill for compute<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queues<br>
Message-ID: &lt;20240717203740.14059-2-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
It should work the same for compute as well as gfx.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index b4658c7db0e1..a1963e6c5cab 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -6955,6 +6955,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_f=
uncs_compute =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D amdgpu_rin=
g_insert_nop,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D amdgpu_ring_ge=
neric_pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D gfx_v8_0_ri=
ng_emit_wreg,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_recovery =3D gfx_v8_0_ring_soft=
_recovery,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_mem_sync =3D gfx_v8_=
0_emit_mem_sync_compute,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wave_limit =3D gfx_v=
8_0_emit_wave_limit,<br>
&nbsp;};<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Wed, 17 Jul 2024 16:37:36 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 3/7] drm/amdgpu/gfx9: enable wave kill for compute<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queues<br>
Message-ID: &lt;20240717203740.14059-3-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
It should work the same for compute as well as gfx.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 2929c8972ea7..d4e38edc9353 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -7244,6 +7244,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_f=
uncs_compute =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D gfx_v9_0_ri=
ng_emit_wreg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_wait =3D gfx_v9_=
0_ring_emit_reg_wait,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait =
=3D gfx_v9_0_ring_emit_reg_write_reg_wait,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_recovery =3D gfx_v9_0_ring_soft=
_recovery,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_mem_sync =3D gfx_v9_=
0_emit_mem_sync,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wave_limit =3D gfx_v=
9_0_emit_wave_limit,<br>
&nbsp;};<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Wed, 17 Jul 2024 16:37:34 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 1/7] drm/amdgpu/gfx7: enable wave kill for compute<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queues<br>
Message-ID: &lt;20240717203740.14059-1-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
It should work the same for compute as well as gfx.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c<br>
index d84589137df9..5fbdef04c9aa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
@@ -5002,6 +5002,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_f=
uncs_compute =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .insert_nop =3D amdgpu_rin=
g_insert_nop,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D amdgpu_ring_ge=
neric_pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D gfx_v7_0_ri=
ng_emit_wreg,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_recovery =3D gfx_v7_0_ring_soft=
_recovery,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_mem_sync =3D gfx_v7_=
0_emit_mem_sync_compute,<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Wed, 17 Jul 2024 16:37:39 -0400<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 6/7] drm/amdgpu/gfx11: enable wave kill for compute<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queues<br>
Message-ID: &lt;20240717203740.14059-6-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
It should work the same for compute as well as gfx.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index dcef39907449..554aae995f41 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -6603,6 +6603,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_=
funcs_compute =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D gfx_v11_0_r=
ing_emit_wreg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_wait =3D gfx_v11=
_0_ring_emit_reg_wait,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait =
=3D gfx_v11_0_ring_emit_reg_write_reg_wait,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_recovery =3D gfx_v11_0_ring_sof=
t_recovery,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_mem_sync =3D gfx_v11=
_0_emit_mem_sync,<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.45.2<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 98, Issue 214<br>
****************************************<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB6420B63DDB46A7FB5EC1284E81B92PH7PR12MB6420namp_--
