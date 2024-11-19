Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FE0D4920E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 05:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F89110E16D;
	Tue, 19 Nov 2024 05:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iJno7ACN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D0A10E16D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 05:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URaAgIOzAjdm0rEne8nBMyrMTwyT9c9CU0KuIRHu1MXNlFMfkGHld3iNHZckEGMGwh3eDfNmUD8FNiqZEotk0IgAcMYuxgaE1dMvw5E1X0JsuK/CvpaDl75X5QgtY747jMxOMKiTE8B9OjaPbD7cLMuEJyRa8a5nSBzcXlOs7pAbgNRVroAwoIGv8FlQ2uX7cjyhPb6UBQsjg3uEQe2h6T3/WT11DpolhdfMvHXRIIQUs/4q+Gi+rsKWmJfay9vQXgX++7MM/iGTdGxwt2D6UGsvZX5qFaO+uo4gi2cdotyytwoB8tvIvLXbnXrf9dByhLvr6zvEbqvDE9kWdSXc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gB0mZfO78vj/EZzO992VMnyWq6nMJVSLPjrPeDZtGE=;
 b=iXErSP3gkvjXarOcMHCc2WbnzAMy01u9z2NQY/++NZpan4Kk6KHz1ULDsvGw03HfrrM7/iI4XEdq0rxbaZZ5t0cItqVhAz3vrViHmWy1UYWb/CH/rFE6Mjs9T+UaDnrD/r1xXrLVa6UZ08JCV0ddKukwIqDeU8m65SUsZtBrE6I+IUFiYVqA0JD9BUgDHzuhhRiwNaWeHRmPktySjF7T/Vbaq28xNWnQ3x8p491MigqGzJXbt5q8OYsQSYiymHef1ZxmqmbHehVhTcO+SRupIDszBHIMXrIqq8y7IdRwALHIyREoa2McdSMs4TkJpKNVAcAmSpoWNykg+9q2vw39pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gB0mZfO78vj/EZzO992VMnyWq6nMJVSLPjrPeDZtGE=;
 b=iJno7ACNS9FVc1jTafu/b0KDS3aKxJeKC/CZNIB6SJKn7BNRTppklKH74S1LKaJbk0D1TRteFgD3jaLEXj54jkMEHw8O/PsXr6xCThTDh8wCBs1O/9qv+tX+diXos2HR2RQFSA1/LNsKvxFVtpoz+sJdqiCPk8tsI0OlKeahgT8=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 05:58:35 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 05:58:35 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: skip the power source check on smu
 v14.0.2/3
Thread-Topic: [PATCH] drm/amdgpu/pm: skip the power source check on smu
 v14.0.2/3
Thread-Index: AQHbOkapTsIHUMLkMUyDSU7ZBWm3N7K+GzqQ
Date: Tue, 19 Nov 2024 05:58:35 +0000
Message-ID: <DM4PR12MB60129B59C6A082D226F2BE8B82202@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20241119054823.436238-1-kenneth.feng@amd.com>
In-Reply-To: <20241119054823.436238-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=705a5541-1f8e-4a2d-b443-182e871a3849;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-19T05:57:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|DS0PR12MB8247:EE_
x-ms-office365-filtering-correlation-id: c5a32291-e769-401a-3bb7-08dd085f34ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zGk8z0fBhWGIwjwExNPpGqpE8IzZrwuLMaw6gDxr9d1lsgioCL1kUScqVB4J?=
 =?us-ascii?Q?aTotMtB+GPPoen7qeSZ4DByGMLSMhVbQGdpX0TYUEtIOJEQXCy7o7krRLXBg?=
 =?us-ascii?Q?Wc4veKsOKWlShCwScdSZExviKuGbmhaxBlP91UFBsfBho3gMvEqMdzUrbf+p?=
 =?us-ascii?Q?7R5iyaU0MA9ZnBmxPGqK1OXG5IEfqrTaT0cuPIb3uJGcRYVtlYmK+3bpqlZM?=
 =?us-ascii?Q?hjM+IJoqbpKLe17/d6/To4u5UdccSLKgAJdpqdG2bU4ssbBrFtt4d5nB1IXH?=
 =?us-ascii?Q?TzSwfbKAbbBvdye0VRBiFyne3Px1gNqhehz5QSVI5u9zb6C+B5RPDQnhycfo?=
 =?us-ascii?Q?WgOIiVDxQ7Pmj0s17WRpBRelwfM/5fbyiSwsBGsiKbF7bgY0XNG2qhU6N9Qw?=
 =?us-ascii?Q?Nu7/vXaQytmGA9SD0fcQtAAFNvvgPlB14wIEn93qCagiD6Q4Cgp3XxklLkMy?=
 =?us-ascii?Q?pYQAL1iWyoVo2GeWLwSfAGwHiqTf4IbI/emiZlJ/7U4lbpNGhWBa1eVwe5uk?=
 =?us-ascii?Q?Lvq30tgVKeMoRMulPl/bVF9mU7BnsPPwjbps1NpMfE2PIMw1FH+Xj+T5+cOG?=
 =?us-ascii?Q?otuKv67bHeSKTtpc8pwKmGJTTL8oTxpiF3sjU/tr+903NPR0crXldTydb+Qj?=
 =?us-ascii?Q?gM/vjex838GLzObK95qO9itQYzlICpCQP7pdPSAIBnZl8Sx+b91VfjNeXBCG?=
 =?us-ascii?Q?w1YnSKey71pfTpGZ09HtYgTEkNBSwx3uzSb8YRceatwIrRV5XUJslHZ3Z67k?=
 =?us-ascii?Q?Rv3C4butHbK3T095wwgqWKNS9fhQDuW4ohVNkIPtS8fO+XXJIT4/HlqhEjJM?=
 =?us-ascii?Q?SsywyBaNDouV5VtjVT8X1coBuy0FJzLgrNRpGvo8/VQIJVw0o5srgG4SpNH4?=
 =?us-ascii?Q?87yA7ewReieNdlXZcwIjrfZVIXjgacxdBMnREe7sHax2jwfq8bKNxSBs9v+P?=
 =?us-ascii?Q?m43ut3N/JJFGzOz9Gy2wPu2dTphg/ev8rhwQMufwgz7Gtdj5LgeBr+NR1Fod?=
 =?us-ascii?Q?v11tfJ79g1tElbzOIhkg+HqgN9KcwyPPPH6mthk2MY5eS7oH3RNh/m2IUvvD?=
 =?us-ascii?Q?6pT2M+nE24NFFRj4GeLbA0jHdfelpOR/2b0YX4vYkrpbMolrNUuctIM5mrAn?=
 =?us-ascii?Q?Ylzlsslen9XVJWz2J6JVjcvrzp5V/V4yCjEQY0jWVNTdg5aJqbeYG6J2QhDV?=
 =?us-ascii?Q?hKCQvFAE39YcOoBy7ID1zJweLZZJAKBH5dXHqJSU5V0x26pKGQq9sSusQn2m?=
 =?us-ascii?Q?oanLD00UFkmwwvMIAXIJB0G2egvtVSIAQVZs3vgqmEBCF7ftkvwGJZ4+lVxn?=
 =?us-ascii?Q?7amgexhF+5792P42oR7X2sOhJHYL8g6S6xMiNSKQtdEpygoDJfzUG0I8lCIQ?=
 =?us-ascii?Q?EqKjzAk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yxnq2ZEzGKbd+zQpnv8Xdd+MumTZ6Zw+qbspnyrOhJ9q+mDHjjEvNGx7dTqu?=
 =?us-ascii?Q?B+Wa63Uax4hgfP2YqB7dm+aeNJXAyAV5divEPkZ8dxSpKRQ+UOl38+fIaV/R?=
 =?us-ascii?Q?T58v+eVPNgD+3HBSFtgCUkjKxhNm86MZPHwD+DOrKCKjO+1oKyRfevpFzBNs?=
 =?us-ascii?Q?kgeeg1egxpi59JQFGQZSRJO9/xWxi2tBhI+WkOGbcWvK+sNn24pFMXUmKBO6?=
 =?us-ascii?Q?yvuUDEPUjNmvsgtj/uSt4vp5aS7QUIFyn+2SHXVlwyj7EkAVX659EAPplS9L?=
 =?us-ascii?Q?b33aAblaXsTMN9VATqwGexTdp5U1NsPFIk9iHqruvniF6rdNQFjHve8W2vfc?=
 =?us-ascii?Q?wKcL4k4nSM4uyrvRKdYWRYovmMtzWe3qxnUENtaXDLgYIVYTeB3uq2q1wqsx?=
 =?us-ascii?Q?wGhED8h7sdbaezDUopAFRjntOiL7lUFKOT+dQ0tVKJeJwpND7VL1CtpUCtYo?=
 =?us-ascii?Q?4wKCrzSkQyji4YkaO1+9nOshak5lAi5FMV7oeq/n5OZzTmak/5NBqHacRxgg?=
 =?us-ascii?Q?2FZ94hh71KqFqZoxiiFw22idO3YUkOdxg+4dHnC40zNQ4dfv7+2UD3P38mkF?=
 =?us-ascii?Q?TEbWckis3pREvCENz7ObH3KSXZz9QbWzxcM1f6ngGsiBP1mm6NJhm+dgEwdV?=
 =?us-ascii?Q?Wml56HlthkUyCz9LU8VnMQxsrAZIHVKwcwUdmqPdR+UwoYh59V/bLdyn2F+m?=
 =?us-ascii?Q?tP8f/qmQdL9D6/3zNbQs8JlYdE2u1RU/QsH7z0+Ln4WzrYs4+OirGjLg0qjE?=
 =?us-ascii?Q?rxHX8lgxJj61HP1Bm/YHKpA9nFME3Q1/ZGHOi7X946u1BK3HZqq6ja/47kuL?=
 =?us-ascii?Q?eYEQ8ekCo+J3mKFVEHcQtPttgZDSYcfctCm0TUF8SKZAYemgUsRfJKwIG3iU?=
 =?us-ascii?Q?lhmMQJTtxIfl9FxVF8TL4B/n+vdnXJ8JbKf7rpyHIIW4wRbQDcQwjdcjw55P?=
 =?us-ascii?Q?CTmGkGX4hAqFSZUXiWmaGce/7qEcRfsBxdYgSFTeSNPMIOYpBTOHzL41XsjE?=
 =?us-ascii?Q?vXgrloBtsSQvEScRQ2EUG2MFfxT8d3zu+FuRbIh9QySIduipaTGx6vaIzMzL?=
 =?us-ascii?Q?AG/tVuHHW9YeRqmFVRmlejXIufa5JhOMJ5wlP5CA5bvGMBHYfagZMUA8Q+Fs?=
 =?us-ascii?Q?bMqOh24ZREeL/46TjbJGbzCX7NuOYQNKYRgG8J94EXGEU16nuWtjljwKDIm9?=
 =?us-ascii?Q?AoMvckWYuuXkSSk0nEXf1Y9LGknwhRtk/c+ad3vXGA2jTQCNRrybSYYe85kn?=
 =?us-ascii?Q?UV6lAsXSgUUUXZPt+AoD138433eb7ttOVbT4+pfTwUs5Rwg3jgns+DOIFQfZ?=
 =?us-ascii?Q?h95wIRWMKBfJisXoSKrihW585mhGDQNws5K8sUxaqMNJ/AeAJFWC+hOtZsDu?=
 =?us-ascii?Q?FBCEwXu+ebVXZEQsvujQ/g/qjXSpdNzGvO3vjw9W7Q/45WU26seOcJhYKM6D?=
 =?us-ascii?Q?+fpEcB7AXEIIY0PWdltCF8E8ZrfoA62vT7KE+Mi2WDWUM3ZQJXD+W4CkW8f8?=
 =?us-ascii?Q?MYmRhYQRCNZSdZRiyHSnJPvxl3YSma2IuA+POIWxPxbNb79r9TG0yl/EFPd0?=
 =?us-ascii?Q?7UBSC3eilCSidwKMDOo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a32291-e769-401a-3bb7-08dd085f34ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 05:58:35.4824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MsnvtOjIxeqQf+Rtzb5OCiju4n4eDsX9BC8bp/aiej5b77fZ21KqxWlIhvsmnjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Tuesday, November 19, 2024 13:48
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amdgpu/pm: skip the power source check on smu v14.0.2/=
3

skip the power source check on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 5460f8e62264..b60837bd259f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1365,6 +1365,10 @@ int smu_v14_0_set_power_source(struct smu_context *s=
mu,  {
        int pwr_source;

+       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14=
, 0, 2)) ||
+           (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14=
, 0, 3)))
+               return 0;
+
[kevin]:

I prefer to implement a new callback function in smu_v14_0_2_ppt.c source f=
ile, to avoid add version check in IP level source code.

Best Regards,
Kevin

        pwr_source =3D smu_cmn_to_asic_specific_index(smu,
                                                    CMN2ASIC_MAPPING_PWR,
                                                    (uint32_t)power_src);
--
2.34.1

