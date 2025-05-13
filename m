Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5204BC3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 18:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E8E10E5D4;
	Tue, 13 May 2025 18:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dUJff4oe";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32EC210E5D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 18:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlQh49xwohsbfxm2v/LTOdhRl3vFsfnyYMB1G1qMYBZ8T7DHQncDVP4NgH6jiDFaEBSnfFDqX9W6bsJ9gTezAz0uMKH5dztIKMCc532O6wwat8qGgeZj1K9ShyiT4zjO5i6qxUnpretALP/NJ4xkqeFuN5j3oUOm2mROJLrul7tDscZgaEjR06sJ0XSyZXazliSB9VKN6oikbAC5b7rfALUjAYhfuHZXtQ1kxVWRmCilZGubvdNvzVxKVbKgrhfLSDj6kCYNWD64+RDAigjVGMMAs9d/TjApJFLQ0tuZJn2+JZkqE7m9M6l5oHRGbkaIVpoxTsNo4TY2kcbGzPrUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFoeWTDMz8LvzkH/V0MYzGLaBQd4dlEyWKJfJ+2kc9U=;
 b=TxqHVLGI9L82YuG4nRKkzuf/sjtYosgCPKQt+hY6PbDbQSGk6Mp0Rd5dsVpw1Nfva6pEgxy00uVD9wA69/Q5c0IkYrLHWuitdDMAU6eVfhxTArd/Xp/YoIBhmgxilnpLXrZRRi4EjKvqDXfcTQtn+kxk9r+ny+PJSoBkeWkSUPvoqcNdg9avuNom3nJ1oAnT+vWInD2Fe6OxhIG18GKyjoNL/1w3P3w3by8LOFt2OJKsdE1FORIOaFuJQhimdHoMlOPUtmw/otpXkY+XmLYtX4hUXsQN839gg3u9jifGBDuonnssSDNgzEwFs1Hoqwy+LRfqqLTC9A1HtcRnt6cMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFoeWTDMz8LvzkH/V0MYzGLaBQd4dlEyWKJfJ+2kc9U=;
 b=dUJff4oeT8OUAomCoJIXMFwtDP5E0l556a/B83QE0czd95Rx6QsY2f5IPmr7LuFxpGbki0gvQv0b5c/jwUA9yFKKMBZqc0tAcob6gMPiM/R9Pf5+Z7KGUtdfnRTnykKp4VL+GftciYLkKMhHCtaFtky2Q1p8NFvdziaV4kBHkBE=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 18:37:52 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:37:52 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [PATCH V2 2/2] drm/amdgpu: read back register after written for
 VCN v4.0.0 and v5.0.0
Thread-Topic: [PATCH V2 2/2] drm/amdgpu: read back register after written for
 VCN v4.0.0 and v5.0.0
Thread-Index: AQHbxDQd3k0plVnFO02+njMM81Y8RbPQ4z2Q
Date: Tue, 13 May 2025 18:37:52 +0000
Message-ID: <SJ1PR12MB6194D08428DAD47A53BFFF439596A@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250513182307.642953-1-David.Wu3@amd.com>
 <20250513182307.642953-2-David.Wu3@amd.com>
In-Reply-To: <20250513182307.642953-2-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7d4e0c15-cfbd-4fa6-b72a-9ca74212f025;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-13T18:35:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|MW6PR12MB8757:EE_
x-ms-office365-filtering-correlation-id: 8990c24c-07cc-4bd5-06a6-08dd924d44cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Tp1TyfGBvi3Z3wCafNM4G9iFPV2/k1QUB3arB7hlw1p1AAo2tNYpAy/gjLWm?=
 =?us-ascii?Q?zhcxTXOcwB4E+OZWkJCEToJ6vfkJSLDXTMj0DA6iTeUKtm+tMHn0dQB/rFjz?=
 =?us-ascii?Q?ru85LVigxinQi/hyhBJndVZ2sAPaGPMPUp7zI7XvNV9tN25Hn0XAJHctReY+?=
 =?us-ascii?Q?5ufkZe/7NnU/WtpvHuxRbo5OKAAu2Z+P3pVNPuV1D2160AnoS/b9Z94gQEsN?=
 =?us-ascii?Q?MDMBZ1nD1tgEc+FXBv5KTMn/TIQDBeStnbO90woR5sdUaHaVWieRJMWc/Gf9?=
 =?us-ascii?Q?GPMABoel8mp7gFF+t08+1LKPWd2Jl7SdTiHfaHSArIjKvmNoIg40CH+ePkPl?=
 =?us-ascii?Q?cPW9XAYVSeZBfWUC8A5clWs3iCVI7XRlZcj7z0H5IgvXYYDbDMlhgx/rLmDg?=
 =?us-ascii?Q?RtoXxQdI6V9kKWyHymZlZfly5doMxhjNwHV51Qm/szCUAruPpoLoCAoinrXN?=
 =?us-ascii?Q?ySwQVVxsg3bsOIIBd6Kvj7itARxDeLFIsjRnfqdwjvKB/6SdD1O/iDGhMR1D?=
 =?us-ascii?Q?myE38SqVS1nK/cIrO0+fUnVKZQ+N+6ePwbjaNjAGynVL4jwDD1U68ob9Zge1?=
 =?us-ascii?Q?NUKnhg3XBcq3iuMjNw5apJOYBSVEbOz35mmIOKDiSOCgIc0tTrFfO8f+gcb/?=
 =?us-ascii?Q?6vQ4iJ2A6fIzJKgdM9+/U8cxMs1nk4EWKWMS7wCx0geJFQKSNu4pWsIIoWZ+?=
 =?us-ascii?Q?Y9xLUx9nIMQLWODVqtox25TzHBZ8JGd08NjmFG0h5TdB8IwQsCY0gUbleZhO?=
 =?us-ascii?Q?mFsaYhmwKfp5GkqbMMBsPizu3Zp4C2/7BGTggq4qi8CUV+vYT4VLhmARcvrD?=
 =?us-ascii?Q?72fm2FysJY2R2ydhUATy0CNkqxIPJJrlKXzGiRmlfOQ/9zpECjurUg25Q3e7?=
 =?us-ascii?Q?ef08aA+UNYnnWd/gS0MK8i6Tv62xZJV5/qqjL8uWnZmVMKScf/Zoc9TDeG9B?=
 =?us-ascii?Q?qg+VbwkhLZ1M69huXgMmbF5xRWaSu666bJz2HHHKdwC3xRn3+euL/OCcpx0U?=
 =?us-ascii?Q?gJLDO0dI5ELEb4uC5xQm9O79GhQmyMtcoGKD85K4hx4GlR/mpQZxQryKPxbX?=
 =?us-ascii?Q?5n3YJykFEc0hmh+/TqWhnVYx3fTPO0jn7qCW1tWMheNHQDkRRyDAidsxggj1?=
 =?us-ascii?Q?+ut5UrbC88xCKJlkXKCJL6zmU4Zk18SxnhhCAWSL8zcfJGN8Tacvm0o81fh9?=
 =?us-ascii?Q?xAwt/osOucNYCwPsdSdOD38enOZ5H65DprIXFRxnIUHJwwYfd2Ftjd1NFAYS?=
 =?us-ascii?Q?Rsy6B4gNEY6012d9SPj0Y96fArA0VY+zu1LhdxHqlesZ1q5KBcgLW2tnFY1E?=
 =?us-ascii?Q?4e/Rqu2QtmC79FJDMe4rYyemD+i8wFLAtHFsdpfau6ZMmrOglFo1qpa65+UI?=
 =?us-ascii?Q?X78b7nhc9i9lWXjyT688rFBnN7mInzmCyIg6Zm7X0bj+9XmDiqoFr7/Bmw3i?=
 =?us-ascii?Q?Pnmrx2lWeuViIoJrReYntHyGon/zLazNlQOcdRumIpUKl+OeLWTyoyReX9Oi?=
 =?us-ascii?Q?Vwe23MIIXbETwy8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4lXOvz1cARxpWZpX9wnJy/4HByX9duqRS/G9co4kcHcJ0YXh5NQsLtrfVr0J?=
 =?us-ascii?Q?N5+AGzTO8P3GIuL8aYAPE94+gHZm5pXbtltt3f2L/fKsUhXChYJl50ANSNeT?=
 =?us-ascii?Q?1fMHXpKLu5iU7T3akz/J15+tNtMNXL6rC4fIpxjrxP1XaH0Jq2RBJb8dk6gm?=
 =?us-ascii?Q?8yXSIPaMvD/CxHs21ZAfoEBowAfn66bNsAZkszQj98MtKGUtITyCJy6ZouaU?=
 =?us-ascii?Q?a5y9b0gMFPNtGpZMYrn6m4uCS5jRkcdF+frpH196LmO8EpjC9yw5Ke6N74OI?=
 =?us-ascii?Q?JKLRHIlf9Mw4SPI05sLxw2gBEAl9+ZgpzciPE7PUdN4jQcLvXrYC+y8B5i8f?=
 =?us-ascii?Q?5J1YPkQdlQQ2m0kbx+57O/sDPxrWvX6JHQ1lFNWv1iL8Oz+vRorMVGy36vVz?=
 =?us-ascii?Q?lP1vsjRONYbwO6PCwxFEX8g3ilctVqUbpgBwnJhfhjQbAjv1apEyxhNeqtdt?=
 =?us-ascii?Q?VgJqdl8ZkOQFF4pOgHhW2puhRbR4L4O6NwRnbckL9BDAST7R3yvLmZVAZysF?=
 =?us-ascii?Q?L25YDrcf7x3S/FFkryu1z2z8V76znDuRap6oOV9fqgGA8V1cwZXyRB46nntn?=
 =?us-ascii?Q?UbF3MgE2eLwdNbunneVmmkpkUnIh2KgkkGAbpr4Qp9IiWVw49MMR6S39saxX?=
 =?us-ascii?Q?oAh0fPF9VNB4oX4E6OrlTTC1Q3gMu5B4xC8hEdo3aNIiDxRNs4bqs3zDYdUI?=
 =?us-ascii?Q?oGvLiwSbEucKrL3kSyCgNQpoWHlcVrd8B1op1BUEH7TGmMEzu7kbzN0Rvrzi?=
 =?us-ascii?Q?SACMQsAn46L8tS0xg/tFbo68av9VKxPrwZDDOmSsND7Od+NRouTyMFiBzgaZ?=
 =?us-ascii?Q?Cp9I+c25A4JP3Ra4MdruGbMb3eDN53FIYzn4KiG/Lm9oNVSFOeX4s7Tsm4AX?=
 =?us-ascii?Q?fLip2IIfW79pR2uOrvzIxXb4poApPGSt3UjmnZvYdl1HqvKDU1xtYed/pB/S?=
 =?us-ascii?Q?wYriXncqPr0Sgo7+edvTSGgjAkRld7IBUToPF0tqzXM1yd/vsN88nP9LEwAs?=
 =?us-ascii?Q?4N41Si29Inn19hEpIvPcAiWReT3OrgIVIM8YWFyVNHguDFcZU6RpIZbzCb1o?=
 =?us-ascii?Q?/9tVjrpXKp1YvZm/ybzq8G2tQKMgpz+PQS6T8f+jA+oHvLaVst9HSMHQ9Gjz?=
 =?us-ascii?Q?kxCzAuyu/4Ab09UN85ThNGu7xFVeXniyUGuPvtTNuqgd8umuy6m/zfn13Sk9?=
 =?us-ascii?Q?PNf8hUrLvdJN33Ted1QnqDg3cJpgum7pC0HlvC9HjMGwILsnHQgT57Td45oI?=
 =?us-ascii?Q?ANudzQumSxIwKOsblEruXNgjtknbEIJGqZgaN2s/O9xA9psSkevgFuYXgILC?=
 =?us-ascii?Q?B498IOyhgbjcY6fT50FiHXk688DdeR0VGHhKEOC/DzIFHUmy957PBD9TE7Av?=
 =?us-ascii?Q?7plb3PiV0SWAQYjcQfHHUySfnurksZrwfLtG88ssT2w1I5BwRG1zMs059Mmm?=
 =?us-ascii?Q?Du7F7VYPuswPexDvEVjk8yoEI1Hpqdjmw6U9C+xl/hc2J6XOf8cxWaMp2mRv?=
 =?us-ascii?Q?6XJ0TuRjgSyHyXAfBoBiNBRuP6umwgDjAiPmJQyeCRMvAlqwRsuqHYkF8BUI?=
 =?us-ascii?Q?CWbqhVyFRXzMvWSJQCI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8990c24c-07cc-4bd5-06a6-08dd924d44cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 18:37:52.0518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+INP7wMQkL+GNkCs+UM4+icjpjHGrVkP/hqbJhhZCWmMLPn/ZNlOWedd83osRS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

Hi David,

The last register operation in vcn_v4_0_start and vcn_v5_0_0_start is write=
, I guess we can extend this little more to do a dummy read as the last reg=
ister operation.

Thanks,
Ruijing

-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Tuesday, May 13, 2025 2:23 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.c=
om>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.co=
m>; Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu: read back register after written for VC=
N v4.0.0 and v5.0.0

V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start as
    there are read-back calls already. New comments for better understandin=
g.

Similar to the previous changes made for VCN v4.0.5, the addition of regist=
er read-back support in VCN v4.0.0 and v5.0.0 is intended to prevent potent=
ial race conditions, even though such issues have not been observed yet. Th=
is change ensures consistency across different VCN variants and helps avoid=
 similar issues on newer or closely related GPUs. The overhead introduced b=
y this read-back is negligible.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 8fff470bce873..070a2a8cdf6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn=
_inst *vinst, bool indirect)
                        ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SH=
IFT |
                        VCN_RB1_DB_CTRL__EN_MASK);

+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions */
+       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_0.c
index 27dcc6f37a730..77c27a317e4c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn=
_inst *vinst,
                ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
                VCN_RB1_DB_CTRL__EN_MASK);

+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions */
+       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
        return 0;
 }

--
2.34.1

