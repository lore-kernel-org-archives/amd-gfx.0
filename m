Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40EBC3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FBD10E0DB;
	Wed, 14 May 2025 17:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0jDqexRC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4108510E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlB41d34IX6c6xN96BxlisRABLVDMGqXCq4jqEJV5JrVQc5DqMhblcf9JwEznpv1Sfc8EIy+nkx6Plv4sGRUqqEWf4d3cYXzSeIjGb/Zis14p+jyf54RXg6rLbZGTd84ilDDxe7cdH1wgc4qHW1X0YnRo/Gnm2eiCR1C0JS/K74bJfzJ9JUaDx/WMSWmxF8DsApa3ffJaLmLwJL+eM5xtgU2/7AVXw7KdXQAGkiCRWke7/8fFns4ZtvlQoD2hxx1RhnrTvc8PUFjbIyDPMC4eLjxVJKe1mryuammBau5koi/glJJh/PpObTeyf5cOnuJHTGZJKYkzeK1guxeHyYPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLyn71+2x2Fgg0dUhAuKWlYBYBSfcFrYk8K5R7XPVUs=;
 b=bI8Vs8IV7qfptSgVbfjCg8EsHM3FC8p6L40CE1sRBH+9p91CR+zIq0qkIss9kJS8S4kCw4/K25op0Dn2YHuOsILK9+FbM7UZqfjCFuBeMribMmt1fB5VMgZRBsO8yd24WUbQ4NSAX5eorrCgblZJ9kIYH41t/a6rZqhhib/anOQsi+F5hG5emf05jSaDYa1Q2Q9BhO/c79BlHKG3JFp8nJ1Jl7Jm+gsiXYIOerxUd4+I50ucxeRJ7K8E4nwFW+WWKzbRjI+Oc1S6Q+t9SbNo4c74C+5Lqqd5bJsLsvrFzPQyqTnEzOnfGE3JZaGZUVkQC0Kib4Le0B/wVlRs/6oJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLyn71+2x2Fgg0dUhAuKWlYBYBSfcFrYk8K5R7XPVUs=;
 b=0jDqexRCQir9TB3xIh0mLtLRD03HbZA9azeWAIMfaa6bfd8Ifx4KB/N2dhsOm0Zg6ZTpbOLiH3Kf33nkvDgLFluea/oEXHjrtrZVbROM1s4/OD6srJ0tFMmFKDkG6mgiCdgN+8X973Ve6PL7flrgm75d27JQS6XdP/K42HxWd/8=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 17:33:11 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 17:33:11 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH v1 1/8] drm/amdgpu: read back register after written
Thread-Topic: [PATCH v1 1/8] drm/amdgpu: read back register after written
Thread-Index: AQHbxPTcQkYKULUqdEeIcyqAdEzSbrPSYkQA
Date: Wed, 14 May 2025 17:33:11 +0000
Message-ID: <SJ1PR12MB61949015407F2749BDD2A8499591A@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
 <20250514172251.726484-2-David.Wu3@amd.com>
In-Reply-To: <20250514172251.726484-2-David.Wu3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9b79b090-1813-4d7a-a328-ec8fb5947321;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-14T17:31:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|PH7PR12MB5878:EE_
x-ms-office365-filtering-correlation-id: 4dfac676-f8d8-4ed2-8e95-08dd930d663b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zCj2cQ2Is4+gdyvt+ajAcN5R4H3T8DJCv8vKBymz2VPwR0sV+XW14i+jdJXw?=
 =?us-ascii?Q?C5Bk6golCqFEC/SDnDOz4Oap+CC5FQLQQtCRxwsughIsWJvi8wyCxaU8ng8L?=
 =?us-ascii?Q?ZbqaUuvdCv5Q62Cr/YUhAUTOH1ekpNJsxyY2FshEzwVfeS5s2NgvvdZmN42b?=
 =?us-ascii?Q?t5vrOZ9Oplo0ziaN/VxOD+E2gxVENrJyv5bdCwDKgO1nEQRVIqq2zsvqnqcr?=
 =?us-ascii?Q?Yi6He4Euk1aTxY4EkV2VZcrZVJ978PVhWcZjOD3qqeGVrqle8uVuyrGCr0LY?=
 =?us-ascii?Q?WvtK2YAo7arNjMfS9FnX01lGmlisJAo0Vy4pVLM3ErblSHaqteKcEGwzhSPk?=
 =?us-ascii?Q?uCYtxPL/sNDmX7pBjcTqon+SZRJ89KUUIwOwvxemTib83qHkT5KUa/KAQQUO?=
 =?us-ascii?Q?0hkwzYDcgPXVZyBtV4qayF76X/m267LxkOycVfcj1jS2ydI9FlusYWNi8+I5?=
 =?us-ascii?Q?36KrR6ex8/IOQrQVav+d9MKqw+WB4Y0GqQhJKZxok9ANN5+wJjaGylUrr1kD?=
 =?us-ascii?Q?8CjJX/OCeXdQSkaur485tl/K9SNe8PQKGBGetRVYOd+59RzjI04jBQpxsQz0?=
 =?us-ascii?Q?W5JpmLZuQal1rPATxAFkqQ+x0Vjk4vuWmi0mL0OuaYNHjc3W3Vxl7Q5DkGcL?=
 =?us-ascii?Q?MmWRR3j7O4P+fSAkTAKAEKmh1tZFUOFNFYL1+zN6mip29azMaHP3GSO3c1X5?=
 =?us-ascii?Q?KVFmKdcFOTXcIyVWnMS48EXPfwu76EJYC2E4AZVqZ9r5cQRfitX8uNQ43vf5?=
 =?us-ascii?Q?+9po4TbALjSmYAxr8cLmbmwh1dabCnEcI+Fh2nLI3wNKgV2A2QUjlhnfcQUD?=
 =?us-ascii?Q?/rqPJiV8Yfs6KOv9IKKQxQvMxiLhWJq3AZ5My4oJIk+bHr9kMIErQ+SdfDYh?=
 =?us-ascii?Q?gFzuhTw8AoRBPMyqjF8Y8IMUqDxl1dj3sUsXD7OCPrVOg5BBT6tCwRxDoW2G?=
 =?us-ascii?Q?bGAPDSTWFZ89G0nE1gQm4sVnrCTMmcPEZi7F3qu5BwUJdLthDEtQoPtpav/5?=
 =?us-ascii?Q?MhX/TvUBNOItGBnkM7qzHm0Le7kFlgOub+Dz1+7PfjLeDuVsSwWDkxiYA277?=
 =?us-ascii?Q?w54otbWqsu6iT7UkrDeTp2ztx3J9dVH/zul+UnUj0VIHqyoW8O1Ol9D9c7hz?=
 =?us-ascii?Q?36Wk7P/6RX1SjbccICPUBE2LDURYZdL/D/qYO7knB0vvBUGiSzoOTMCdXOQr?=
 =?us-ascii?Q?dAMDThHgnD0RY1UqPWv/6TN2tPOFKT8KmZRX3lC7WZVwItEHcawilEjKBqxS?=
 =?us-ascii?Q?ISBwcdb5hIZg/gnLr1pYzpdDXTGJEKo+nTr+ODVBd7mPnht0aaRs0eIkLJoQ?=
 =?us-ascii?Q?dwiEZ2+YastgxodgW0K87oP7xJSuyfeEBdrvaYkyZsqpe0+/Hoa9w2Fu1pGq?=
 =?us-ascii?Q?3ekIy2OkaqC11MNpdiwottUvYl7DBxkef+1Tnq2BV8L1Y1XTm16IcwPk7u0/?=
 =?us-ascii?Q?m+gjmbDAOhb4Rf+jUWvbkN8JqWn30hjDVL2Tz14aUX9w+OApxQPYbw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C4/6mrQTcvgcwhy0UDvFrDZwifAd0ZpFOcgw0KwveH2JpSmaTqxEtP8EZit1?=
 =?us-ascii?Q?1gkWJHpDqesb6ulgWfvEtF+a6qebuKTEwfvGt8muz9oGt71ltMgP2IW0n8ay?=
 =?us-ascii?Q?o4641Uv3ZyF/7l4IRlZNDdnnlizxKSJgg3rh5TOs/pf53xNX8kyU07fbymBM?=
 =?us-ascii?Q?Pei6XhvydBP246duUxuZ3lpftEZfud7EQvKSIcoiyh71No+LmTAIRibxsLE6?=
 =?us-ascii?Q?L4z8Ip8EEpzKKGyjDvRc0wKBFVa63UwJmasEUI2Ukp3ah/dqr8llTETT6Mud?=
 =?us-ascii?Q?9IKHiKyBnoXHX/vpaNupC1PlhUFtnDJ1kao5v1Vpsd1c9S+z09c0Rp65lUpf?=
 =?us-ascii?Q?gMAn1m75Jd+XfTqHAl9NbsIrjzAo0H2fUHXRQGNwwZyI7F8htuHFvRftOFBt?=
 =?us-ascii?Q?1Y9ikybuUje4TU1hukAJ9Mee9iZ2d5VE4w45/WB4y8K8OiF8Ji3o0HQz84Ha?=
 =?us-ascii?Q?xz/K6A4e1rIZk1hFUmHhQlL8hQoKJC4RWz7xka7qNLn4Z2O41Barj9I7y71i?=
 =?us-ascii?Q?9EejE6FFkJDH4GEofL9H7ynkZCVccSAqbfXxRpeapdLQKEbKmH6Wc0TXm1K6?=
 =?us-ascii?Q?c4M83AS4b8aZMyRXfHZ1XfFudeNMGQC1vgl7NFBVq/xEkec6SoAfY+j4Eyv2?=
 =?us-ascii?Q?zaaDCB10lvUoiT3sg+aL+jz6v+usB1vyMMHtU1bLM6z9tx9fSgT/4EBd4Cwv?=
 =?us-ascii?Q?F5L1M0VikxQDjARnIlHaM9of0AI2HOPT4oX5u50zVKEmLfPsiAZM2lLylI/7?=
 =?us-ascii?Q?Itjcf4/rVoianFml2Z0Y+23b+Tk3EkNzAeHh610kfG7aCk9AT6aiMgP5Pdtf?=
 =?us-ascii?Q?bH7DCirPylty9wnKSm8NR6XBSkISxMiJB2TyKi1s+EpSh88lKzuWVWvBPm63?=
 =?us-ascii?Q?gLh9oXBJ8Jzp8jLIl0I5TFz+fMb/Gi3OnfLDraIg6+CSjgRbG0zkGWuccMm/?=
 =?us-ascii?Q?2dRNZMEz0tI7U/4+XCosZ0ktBCKSlqS4D0/A6MEGXEEGSAXUZMmbd77PqObr?=
 =?us-ascii?Q?vbsVQ9vJ1pYZwNnOipAx9poeRpc9b9JxM4zQn+kmJPeRwGKJmPaCspo003T3?=
 =?us-ascii?Q?J5HNbRxcPDC/sNQPQqE606T9LoanGkMMxtYHPQYXNGaWpT6ej60YJY4yxRon?=
 =?us-ascii?Q?uDA9FhcJKpcyi/xIMmHMOohENTOo7N+TIqOIIt0M56MaahF/6D+OWeu4bz9i?=
 =?us-ascii?Q?13dcdIMkRhAPA28s4LDyvlfTWxpRWzmrkewOYi86yFgOHvKlsoS2MOWz9jM5?=
 =?us-ascii?Q?Zjql3V5y5J7Cwex82cGyEGVlYoXYnWQcCXt8DiL/SoB2bQBDdVpMcW6wUpfP?=
 =?us-ascii?Q?nXVELDQ98hSUznDqItvQWBNP1kAK5nHzmU6VCWTplMnEpTzP1cz7CIdGGoSL?=
 =?us-ascii?Q?wsSMt/hsy0FmkuyWG+bWvYtdsFTuTxW9lZcZ8lwvY6rq0GYgfWEe+HbpzsqD?=
 =?us-ascii?Q?mcQAqpnUI7a4FFukwNKnWX/mXiIAKuEkeTerDk/RaZmkBpKPc3OSKvmH58v7?=
 =?us-ascii?Q?K4mSqwzE8AwUBWYg+RwxXrFc76DQaQpSFXdntUVcW5w8zgcHPaG1gFjn2HlY?=
 =?us-ascii?Q?3RaCMy6YhePFnzV6UPc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfac676-f8d8-4ed2-8e95-08dd930d663b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 17:33:11.5062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/G0OIEMMZbKsvhhItC3kXmgOYSPcazEi34dYbyK+KRq1tetSPU2+VkdwYqeUmkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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

This patch is not needed as it has the read-back in jpeg_v1_0_start();

Thanks,
Ruijing

-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Wednesday, May 14, 2025 1:23 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com=
>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>
Subject: [PATCH v1 1/8] drm/amdgpu: read back register after written

The addition of register read-back in VCN v1.0 is intended to prevent poten=
tial race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c
index 21b57c29bf7d..f56b623713c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1009,6 +1009,11 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn=
_inst *vinst)

        jpeg_v1_0_start(adev, 0);

+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions
+        */
+       RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
        return 0;
 }

@@ -1154,6 +1159,11 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn=
_inst *vinst)

        jpeg_v1_0_start(adev, 1);

+       /* Keeping one read-back to ensure all register writes are done, ot=
herwise
+        * it may introduce race conditions
+        */
+       RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
        return 0;
 }

--
2.49.0

