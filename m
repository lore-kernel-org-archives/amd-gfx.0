Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9747C19F32
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 01:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B430B10E16E;
	Mon,  3 Mar 2025 01:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c5dR1Ge6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA8010E16E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 01:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giCKaCO8hiOtkSz9A6MF/jJpV5omoQLnzpyByu02MJ/VUKrXu/3FacKujblQF5Ms4OdnBSF/CfNmOnP2E2IUmzxTPwFW/qt7s4EH+5YimkxyvJMGSh6SNvbG72mzTdKnuiO/4riSJPfaevR7O4J+W9CXv/tx7fgNePM1Wy+jcRfbrkDcoCZDahx1lfeuFVJn+zNUX/b42rJ7uRj/7gaX7ijT+zkRZ6AifoIYQxCAh/z+GapRvPDi1v0obVfYmy7gU6Urx06G0CeWU6mCj7nxmrEqwkV6X4cmfXpekCf0eLU4vxD8TFqYW6br0hOB4swkHD5FMGqoRAFQv5ew3FPM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4meulKaZqmJRuYEHGSkUOAUAxl8D7+mk6HCe944616U=;
 b=UETpYyOsIcb+/ZJfRcsqWCfnIMbFyH28tydQuDSH3grzOXKTNcxWG0q56Q4z3Q0J8AgJk/5o9vXXK98QnsKAKwg9xeSyYgdDVIbB6o+EwsVe0mxmwklGKujegQWXIqqkAi9aTT34ie1TSPL4fBbs2acKRVJM/nqelsOIafBb8MfC621p+UAjdDFT+G9YXEkJm5lecTHdgD60ty2k2rOXfIjB9Fs5s5aKLUFnnzKlJGsbggyNQcZYKkKTl9jH+YIpsyUHaJZih2xSXHcVQmNu2jVot3Eu51mGaAmObg6Kn6rSoZb7zSCK+BxdBi+nFyNKX6vRqLFF3ta5FxcezuPTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4meulKaZqmJRuYEHGSkUOAUAxl8D7+mk6HCe944616U=;
 b=c5dR1Ge6lEinkmI0Gdg0U1s6PRbtE45rFAqT42ZO+nNwzKjG3KmDBYZEXOPicdzaQys7iy17Sa2PPcoyWYdNNiJ5gEdlQfZg38s4vIcvt09MoRktrkyc/V8L87KdMLvyj9plQ9mU8QG6XwHVYeccE8vmQ+MHUD7Fno8JsGw69Yk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 01:20:09 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8489.021; Mon, 3 Mar 2025
 01:20:09 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: always allow ih interrupt from fw
Thread-Topic: [PATCH] drm/amd/pm: always allow ih interrupt from fw
Thread-Index: AQHbicAoQ3mfLo5zh0uf5Jg2AyjuCLNgoTJw
Date: Mon, 3 Mar 2025 01:20:09 +0000
Message-ID: <PH7PR12MB59972886E3CD32C64BB23C7582C92@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250228090519.528255-1-kenneth.feng@amd.com>
In-Reply-To: <20250228090519.528255-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=306c721b-b386-4644-9aab-47922a1941c9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T01:19:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CYXPR12MB9441:EE_
x-ms-office365-filtering-correlation-id: acef8c90-2914-4985-e6ea-08dd59f18a07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cWqEcBWT5zrBftmikhjy0eh04hg4txJP6PWE80MgXCwk/XT4oFxSg4kjWT7x?=
 =?us-ascii?Q?riR5cv7NPVenDGmwaNH+nY13nVkZQeGWxNGjd7s8/KUJP3NX8RPkF5UrMZZr?=
 =?us-ascii?Q?lxU01kfUGjmGZ/rdxSYC3ZceH6FRnrbG+6KvH9NNmYp9VIRxSi/qiXQKJ2Gn?=
 =?us-ascii?Q?crmO3yiFblF3I9mWhx52FIK4lNpuJXkQc79fOLix+BgGHJtYXC2s81oGzhwh?=
 =?us-ascii?Q?Tq/sLG2ohmzf2P2/s2cv+GWAiR5fHm1LWDYHGhsASQW+upKp1/EVrfloEYIm?=
 =?us-ascii?Q?F96LBlT9Pi4Mb0p086frPmNpEE8Ll8EZNKIvD+OANr8CCl6Oi7ErBHJkW+AL?=
 =?us-ascii?Q?eR+jZ1DJ7oCmrwL6r64+p/PKYlz0c+rHAwaJ7UYxFFadK1GGsKrm7w2PypS1?=
 =?us-ascii?Q?BakOUJK/1dmoX7OOqpYlmoGGiC+t5Gd3vIy6hgef5Zm2UcMmhNhOtVrqwsLk?=
 =?us-ascii?Q?3X6aV9e+BfxcWeQ98ahnJdhcjT2Rd2YCguxDEp+dL+Paar8VhQzCX6FPniCx?=
 =?us-ascii?Q?HXwyJ1SDbllSfL1jDPyZsZuomzmKY0lmN46JYXThoMCA0FUu/ZOVzho/RDoi?=
 =?us-ascii?Q?hig2ZFYkgsGAaVXOdi5t76uCHSXz+R8/5Iy7Nj6bLp2wxbIpze7WRmZMTRlx?=
 =?us-ascii?Q?0XUvSmsQzsbQGVS9xb6wzYRso0USOWYWJ0fnzXPZDsDWSwq0ISp8WfUGBO7/?=
 =?us-ascii?Q?3RfbLH/L4Z8rgGRLfP8R1eSKndEUp5xyAMd0yrdo+hi7wjntKXDorxGKaIMj?=
 =?us-ascii?Q?dMnMFDmDMHsHL0DeYePFxSe+matMSAhb951NwkqRWduZ8dHc8F5gbZ2yAoK4?=
 =?us-ascii?Q?oglGVxcZUV53YoDyKl45RKqlnlYSK86h59dSiJa5u4kBMksUyjixIBobd759?=
 =?us-ascii?Q?XuIHrQs00CN5/mR01mmwjQya+mTOBOu+rdXc3mzzJgMRwVLpd1/MTFR81p3L?=
 =?us-ascii?Q?rzatkFmVLIaMYw870K/g/gXj0t5dPuwTZL8aoynF95UuK+uMYqTOb+yMlQcc?=
 =?us-ascii?Q?kmb/WB0XKv9BYb3YA2Vjw0pAa03hxG6Crw2IUv642zgZw6IDpC1eUgi0d+YT?=
 =?us-ascii?Q?f2Q9KbJNwuQWdu9OGXyfXmka6Jw/m5TXh6RM158rlIwesDpAGcvgcxT/avtt?=
 =?us-ascii?Q?8xj518idFM4IfQRFtWtjsZfhO02j9tFYNV6RddFe5Q5M4neqboS5Y1Zso9zi?=
 =?us-ascii?Q?5UtyF1wvsu7QQfY0RD1K1bWcURnriFP0QUiB9TdLPUxdbxtTM94CN8RQShti?=
 =?us-ascii?Q?tLraZJptAiwUnsLs9pLegHYzw8kuyYNFDbV8hkxH+8nSVNzI1tbsJRF2OgPb?=
 =?us-ascii?Q?/wI59p+LxFJOJoGzD1rsepC041dnUZ9sYDzKVTL4cSnQS8ONT2uUaMvFK5ui?=
 =?us-ascii?Q?WhJEgiZS+5PYTVFfmnwepQc0U6EPkgdl5skjc0G/xKQgr25SFb+kavo30NBH?=
 =?us-ascii?Q?WA630rnr5gEw+VE5ohDzubIIiRH4phe0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hrMekbkqDwv1pIgWOxzacJbzKc1H+xPsk53JBwrIP6NuKLYX+xc7uMuiXG5O?=
 =?us-ascii?Q?RIrCGZ9Z+vYEJNSHBeIphJrzizUZwdvPQx6PtinLfHj/CkerQCBIo6zu73uO?=
 =?us-ascii?Q?yTHhUdsPJAgFZpQ6xxzvdA3d1y634CGes8atq1/tqP/2Dr7wrYVmiF7iEDV0?=
 =?us-ascii?Q?jrVv9Ca7LGMHsXD3HI4yjnLT8feYAGjhtgKYGq0+0i4XWE9MTgmpow3D0KRV?=
 =?us-ascii?Q?tqkv76a7GrFl2f8h95o+JYC5/sjGbbQzJSibGtmRpLquuu/K5k7uUEJ+FfS+?=
 =?us-ascii?Q?OOU2eNa5Bq53FyOyNp6MgQEuwZRP/ueoCQdQEww1UEtkEPPakwe+e1ZSCIn7?=
 =?us-ascii?Q?ppnI/L7j2g7WJ9CUagLONVDXkMCmHL4jwcAWGJ9LNENH4dN3ZIGumvJtAImf?=
 =?us-ascii?Q?BheIdDbNA56p9TVpkk1F0nmTYKfNxs8cWrH9j3f8DCA9KS/CINpT0Pi20Cg+?=
 =?us-ascii?Q?pwwHB5KduHDOQe1xKbIojLQ1j3aI433s9UZ+luzR216kSygIXuS3/ovbU2mq?=
 =?us-ascii?Q?HdPzx+usN3VRmZQ7By6yZlWHIsiCdfjWbGwrLv+p9RmiLI5qbth1Ry4mMovk?=
 =?us-ascii?Q?xdiYlskvneiAbSRucWxL7LoyPXHnGfqrUup0BZbgjN7dtjAGr0ZW1F3FhrN+?=
 =?us-ascii?Q?9ZdVVTnM8R9PMTveB5PelGZrvLjVa2Fq6IpnEB4wBvhZYPjGYofFOthsFSRA?=
 =?us-ascii?Q?cjGbyVu8BM098v/oHV52DQr92mAFQy53ZiqBf85sECef04yo+opaX29JFZ00?=
 =?us-ascii?Q?3bty0k8lQ3p2leBZks1l0ZnK75wjD7w4h/b8arWW5bgWoit45KSYRqeE0c5G?=
 =?us-ascii?Q?bngXMbup7+92Mv23s1neE1bMTwAHYJPEsPxK88OIk3c5uxcW7G5GWgqnWgfs?=
 =?us-ascii?Q?qV9MZxF7aLs7cn1QJxQH/Q60i/Pxjkk83piImZPFwoRjDNtc9ZYzoPWLhYMM?=
 =?us-ascii?Q?A1RJ7jdQVN7nnkQFFvXt4HnVfoJH6PfJzCNpEhMMSgn109PVeAm190eobB+G?=
 =?us-ascii?Q?ra8r6oY1uJcdd72i35pcabvwe0coxCXNl6NZoOTyJ4OfBeYVdaMISHP6cSl5?=
 =?us-ascii?Q?VtW3un9ymKER5P0RiZytzxYIIRBB4bhJZ5YMq7fOIdlqbhQ7NwCWEOKxU/do?=
 =?us-ascii?Q?HR1mR/4RAAovb4iTtjsqPJ5SiQ+R31LBxMaMWvE5LiJCTjLK0jtlEcM/Gi3B?=
 =?us-ascii?Q?L4OmXT/gLz7VoY+e/CGCdMNmgB3jex7JWcu5Lx4L2x6Bi7a8f+8dCzoSn+vG?=
 =?us-ascii?Q?55YvglHpJ1qH4OXUNipuKM/41Q3ynP7KsB8Pptpu+oSMOhJnKNU3tz3UwA+D?=
 =?us-ascii?Q?/W68AzzL0uSWwzGYHACIHZAAClDGHVnoif5Z4jXhFLBYXLXLQLPItko4TTsn?=
 =?us-ascii?Q?lbUXugYg0GvoKdw3IXUjw/MbGTz2c42dCRnog93Rg0ozYDwVeh5PxuOo3yZs?=
 =?us-ascii?Q?UC21opsOQRQestUXDwVGgDKNp5Levx8WsfEBO1ZrTa7ITsvFC+PAHkNPskZl?=
 =?us-ascii?Q?cS87Caj8kFkJSmZf3deeR3YeLNtwpnqfhQ63H5N/UaLvNEZjSS2HhMgPo51H?=
 =?us-ascii?Q?tfsWAd0IbO+ngYtoiqI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acef8c90-2914-4985-e6ea-08dd59f18a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 01:20:09.3864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bM/UXIVIMQjgCUFAgWf89I+lgP4mUVj6XMaVQ4/f+uAZgOY5YukQNIDiXbHX8/w/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Friday, February 28, 2025 17:05
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: always allow ih interrupt from fw

always allow ih interrupt from fw on smu v14 based on the interface require=
ment

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 14a5760082b8..76c1adda83db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1949,16 +1949,6 @@ static int smu_v14_0_allow_ih_interrupt(struct smu_c=
ontext *smu)
                                    NULL);
 }

-static int smu_v14_0_process_pending_interrupt(struct smu_context *smu) -{
-       int ret =3D 0;
-
-       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
-               ret =3D smu_v14_0_allow_ih_interrupt(smu);
-
-       return ret;
-}
-
 int smu_v14_0_enable_thermal_alert(struct smu_context *smu)  {
        int ret =3D 0;
@@ -1970,7 +1960,7 @@ int smu_v14_0_enable_thermal_alert(struct smu_context=
 *smu)
        if (ret)
                return ret;

-       return smu_v14_0_process_pending_interrupt(smu);
+       return smu_v14_0_allow_ih_interrupt(smu);
 }

 int smu_v14_0_disable_thermal_alert(struct smu_context *smu)
--
2.34.1

