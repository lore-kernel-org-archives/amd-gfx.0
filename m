Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2FCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 13:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12C710E5D4;
	Wed, 16 Mar 2022 13:55:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB66F10E5D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 13:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZhDqzVYqWwiXViei/4Tplo4BgqoHke43iZEz/D39EWGdqSh9PzaHC/98TocaK7i0gqdOY3rgl6XufpPCuREJBL2FWP2oOg7nuRdacl8SHY3fFy5qgL68QLnZdYrysSe0yUFe4YdKrf0q9h8AjBal3MwPXdywelZHRi/RKY79IjoGZKGZFw4o/bG8Wt78OllRkZNMDmnz9b4Vw5cemeSgKIat0lycZbZwKV1UHHrEpKsUtfomEq7Sy/XkQBxp9zIQwB9AJPZ7dRElu2JDtHsVDPORb50GE4bpfNAgwlwOtZ6qvzsol4+5AQsRb9HG9iAlj3dppHAeb/D3DoocvyNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfYbXsrT8qGmirc7zXukAAWLkCZByETe0X9SU/WzO7k=;
 b=Pqr3cst8WkDHOsrHO2If0bsGiVRx3xoF9BH7HR2Terb/izIfA0fmLPEsWb5DmHphwQLO/Ha2/7fxiskVkGFN/QDWwXVxHfOR4LCHcVgKIZamHqKoRhjFrAvo3VyK1MgAPMPmXS68N5Hp7ok/8K7RQCIdXvo7Ns0hOJJ0E2LAUTI3Ky/a2DCIw5bPTrzI/djXxjTn6ami0TGz1RDnKIBmTWNQkcCSVo0Up1lbUqaCgNfqFxWwyLPvxDPW+dw3B1sAJcNTIWaPodiWj5nXz0qz6JtrHnuBskZ6n2oTc+TUAMXMCFngZB6hv6fmK/U+FX8AJop3v1sOXam2fCQspVl+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfYbXsrT8qGmirc7zXukAAWLkCZByETe0X9SU/WzO7k=;
 b=i4YLsssUSIsPhCn0Zm3sDcLfTfu7RRpv3iqrzus7Bgmq4OKM8yFz0YPmZO5c4ahLe/AyT6PJsYGL81p7BI5l3EAw4U4YtuYzx92jQ4l2A+6fMTQHVdfERVfo5A/xlfB6/MH5tbd6RzqtiXt/5qrZPkzQlnPSCVoUb5MyI31dDXA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 13:55:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 13:55:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption
Thread-Topic: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption
Thread-Index: AQHYORfxgvEzL4NrJEKMra7bojheAKzCBmDAgAACOPA=
Date: Wed, 16 Mar 2022 13:55:17 +0000
Message-ID: <BN9PR12MB5257321E3DE83511EE0E513BFC119@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
 <BN9PR12MB52570BD45B672A97C2AD6B3EFC119@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52570BD45B672A97C2AD6B3EFC119@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bb9d2b11-f295-4724-b35e-d9f89e75a8cf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-16T13:46:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 176c6257-fd07-45c5-d96f-08da07549a7a
x-ms-traffictypediagnostic: MN2PR12MB4094:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4094A9F1FB7071C6DE7C36A4FC119@MN2PR12MB4094.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymQpkcwl2InapYaxEvbJ+XQI7huHgCoMRzFiehu1Q0W/xVT2DliF/WSFvaIiYbrkaiUaliy8Xz4euTXF51uVs+P4jGNjQp7yZyTaBW/rUQsrzJXbTnkI8Bfbftsz45XPUkL2+rxKgVo1AreqmzFYZx1hnDynQ8W6Hnz8ZUNlTGC0yMX2tg5JzEpODFQHkbirVLyz/pgV0qE7fpja3INLFzXAlTw5vVvIIggGXpS7SY9HX0SYEpAKHLw2jpJnsV3g0DYj1P7zccxo8wVzZf7YNfGm27YI7530wW0ZY/PYshmAXPB2SeBCNuAF3ti6d7uCBiey6fMAxLJrduWtz1emk/U14/wmYcO2kbW7nS8LtSSnNCd/kj2AeSGbN12nK0MemqkQX1nJPINnTWN22K/k5GUuKQxwRKqQ3N6XGkliLTqR1HqA4au5UMspmps7Nvr26DBOAqy28Ay1yppn+6omyKxRbeSAfTNB84HUUSrOguHrJuW4TsEN4573QqMOyB64ByVdmI9VgSTP5g2LOvNBnwbqZBryUrN9XHJL76Ywd590E0ZD+htCZCYnQz9XqsGjFunDF2lzG28z3NQUxi8PDACYni0BtVesqJF5uQYARxmabF5GRjr6F2SOVec6y0+OCoE5ORxQwif8bSORJ9BWsY81/rv8Ky6BHRywgclaOQq+ECOyQ+NC3RRsqFRgrosDjX4YgYcEHgAC/XwbpqfjTYmwwQBPH0STvTVawEpcIJU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(55016003)(86362001)(921005)(122000001)(508600001)(71200400001)(38070700005)(110136005)(316002)(6636002)(7696005)(6506007)(26005)(53546011)(9686003)(83380400001)(2940100002)(8936002)(5660300002)(186003)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(8676002)(52536014)(76116006)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6YSdPMrtIQdWhP38YUdAMXPgvEaJpkQxZQqEKxOohQvaqVWeU06y+XMIyU/F?=
 =?us-ascii?Q?OwENzUnr+h4ihNxTV1wEc+qzgJ7fHf/06ozDzhIs2ZLFa6WFazBqebn98hfq?=
 =?us-ascii?Q?fnDIMfwjdsfEvD9zyvyYQNY2bisFPm+Vc4tuyJoz1xIYeeeNJqxEe2r7i7xr?=
 =?us-ascii?Q?zn6JysIkdv65GoCihtdxxJVFO+7E3aufI9FhUCApfSmHUEH+7sVxM0UrzVHl?=
 =?us-ascii?Q?YJr1FqTz9EnWyV3tw8P3V4UkhOUuSBIlqRlBD8GXMJef/oPT9EXjCyinm4El?=
 =?us-ascii?Q?0HWHFzD1fePRA4e7dWHJUgLIJkSqkaz4CJV0NB9EngLOFLgLYMG1SxZHFiCo?=
 =?us-ascii?Q?LypBrXlYUusl+INEZCENMpyyvpZDkDHcqsaZzoeJGijclpxsKTGS+vEIZOYu?=
 =?us-ascii?Q?FLtinBTLWKFBjvZZpqIxO9TZSw7ONns+7vyhiG2zfmM1GEk5/xZNRNjQV1eq?=
 =?us-ascii?Q?pUiPlfSwNm/qlA3xSoZHWogGGx0x7qYvyQRrHGy7qDhzUkTiRIoJNTmlReUJ?=
 =?us-ascii?Q?JnaxmCrCpzsYO0MUlcMiHdyK/KYsAPHtBSia0wNtLRLzMnbznjAaQGbhba/m?=
 =?us-ascii?Q?aHBbfvxikIUtXp+nqpjH3kOhfTKKjgyQlq3LxM8YrW2bOGQsE3aYm9YPfoFC?=
 =?us-ascii?Q?Q6kYEBIN8ccafkEUN30e+JdiR8aQH7x7ys25Rc5Qgw0EdnqaQ59kj1/xEQZk?=
 =?us-ascii?Q?QbwWD6Ntl1k86kcsjWnImT785x0QGjqCJu5NHWkUt2SIqgI710QN8eSOfCii?=
 =?us-ascii?Q?oa30ErsDrkIJClYMdKnf8zPkqq5UH60+BrA34SoPRHF4ZcIyI9GhyyYAJLD7?=
 =?us-ascii?Q?z/yk1q6igKy2t3oFBn6Y1rC4UBI4YSLfIR4M04CIgvwHH+snrs3vfBOhUhw1?=
 =?us-ascii?Q?vJ0WIIo2jCkUMps7az0aNC8RffpFEflhDpwHcZCoRmoHHIwGl8czh34d823W?=
 =?us-ascii?Q?5zy0DiF/9I1GLqKprJsHc3n/5SYpze2guJeVFEfDHyIEhC/Y0GC8eMmhKVUo?=
 =?us-ascii?Q?SA+KQzd3Z3D9pEaoDsDXPLJWC5tvyNgt30lIuxHKcJKxrOB/OL8mFDMRC05T?=
 =?us-ascii?Q?MWsCQFANCBe6Yxy/8JcpNJx1hVPpeVES0thSI7XyPMFLAusG5jzD/AXEz9h1?=
 =?us-ascii?Q?TeXpuyZBkFyBaXze7lAhfloXvFjhn+cpk+MA0junvu6Nl8icPQh44VMJg9IX?=
 =?us-ascii?Q?AqeS8ETpg/HV5jg1H+rkEx2BNqvq3+7U3hl8G7TorC9IKDW4bdGbKT346ZlP?=
 =?us-ascii?Q?5qrLnu1yXBaGqu4azZp5ftrjtlcOm0uG45UAQBZz0pH2HRF7aFJ023eVr6vo?=
 =?us-ascii?Q?So0I/PiNw4R8HvEf0+XYttl6Vqhj9VYm5M+c1/Q5UZnxue41O2HVg9AEMRMf?=
 =?us-ascii?Q?/3wPPrWJfc5+6YRgGLiVn/vpxLzSKk3vUDNkIFYjoFM8FrF9OulpX6g2wE9f?=
 =?us-ascii?Q?EBoSsT0Fa3ZxC48WlYFJMBw3v7Tv1iaE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176c6257-fd07-45c5-d96f-08da07549a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:55:17.4392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9C+xvp/XG4ebycpwbQWLzsLk0xqbcdIRrQZzZzXB1dw3iWvAmTFLXUgFJalpA9Q+VAgsBVBdN7rK75Y2cq+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

[AMD Official Use Only]

Hit send too quickly. With below addressed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Wednesday, March 16, 2022 21:49
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Kuehling=
, Felix <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumpt=
ion

[AMD Official Use Only]

[AMD Official Use Only]

+       pr_warn("RAS poison consumption handling\n");

Given you already print out this, might be better add some more information=
 to help identify which blocks issued this poison consumption interrupt. e.=
g. add client_id or source_id

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, March 16, 2022 17:26
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption

Combine reading and setting poison flag as one atomic operation and add pri=
nt message for the function.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 7eedbcd14828..a992798ff8b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -93,20 +93,19 @@ enum SQ_INTERRUPT_ERROR_TYPE {  static void event_inter=
rupt_poison_consumption(struct kfd_dev *dev,
                                uint16_t pasid, uint16_t source_id)  {
-       int ret =3D -EINVAL;
+       int old_poison, ret =3D -EINVAL;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

        if (!p)
                return;

        /* all queues of a process will be unmapped in one time */
-       if (atomic_read(&p->poison)) {
-               kfd_unref_process(p);
+       old_poison =3D atomic_cmpxchg(&p->poison, 0, 1);
+       kfd_unref_process(p);
+       if (old_poison)
                return;
-       }

-       atomic_set(&p->poison, 1);
-       kfd_unref_process(p);
+       pr_warn("RAS poison consumption handling\n");

        switch (source_id) {
        case SOC15_INTSRC_SQ_INTERRUPT_MSG:
--
2.35.1

