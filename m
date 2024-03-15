Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D107AC54E69
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 09:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313B510F5AA;
	Fri, 15 Mar 2024 09:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PPX94vlX";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80BE112073
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 09:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj/pe49yg3+5M930J8HnIy2KOJURcZ1TVaWwwy2A1xflfXPHjMa93WEWepqrh1WPzdsMutpcgSxjfz8m64qTBSyZFoy6jZkALiKJ9M+QnZau2WI61gGnnA0HSpA2nGULxWmqeHsg1TLE9dNut9Hee7MIgdi58ftMdB1Qqmdr6Eur+peF8FBCUgkINbHNHekGtYXSqs+kIqc762DzM2zVRzqOzSqvmyCdz5xbZaeVHpdsBpiCBpL+AVzWtewqFdqJHIjDFwDTdACOCcHRFuqzqMIoX3ERtqYHnfzqaRxu5NBeAIf/UQJfPXW7S6t+bjM0W/QiqvjrrIPeuAFt9ulv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCVSoyYTHwaW6388C0duOpz3Yina7/DeUnIFHpBf2Fg=;
 b=JhgoABKTrTQN9BHujeJ6gGqgNM7O1tlO/Y3Z+IETXVTj/eCPmBliINKEw+iz61pNH8GbpgsVXgttQmaL5h6UWfOp13PTxdRefRZqez4nSar3nykJpAQTtzFuWwMJ0lZLH+g1ySc/nO+vdAaGbdaYRQVZxMpgavkNajyCpAA1b29a4xm25x6YjP+9I7TnJVe5M0aaNf3irF+lkva5t506YtyaAyDHytdhA+lqMtYBTgneE/LNvU2Z5XFSrGQf2vLCqXPmFF7vNxg0by0wKy2tT81bznZ5vgK+O1PUEQ0zwjnRhMCBGqyih35Rstr9fBrO3UjG0ROKGGzxVre/6BRVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCVSoyYTHwaW6388C0duOpz3Yina7/DeUnIFHpBf2Fg=;
 b=PPX94vlXJabgMEC1OGvOO0iG8+Amfxjl5oYMohA9yKx3IQvCimfaVuH4oRaqMoJmSi/mS/vBO45kDzTpJp7BoriD/Og7BBuI7I+tzsDLzQpjw8ImPQsINzbtsRowPr+G5T6TWk8aoKjJQhmSDFYJV2BgEWhyzezR8E8jUbbDubA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 09:22:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 09:22:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Song, Asher" <Asher.Song@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/1] drm/amdgpu: drop setting buffer funcs in sdma442
Thread-Topic: [PATCH 1/1] drm/amdgpu: drop setting buffer funcs in sdma442
Thread-Index: AQHadrl1+DTXfLUgp0CvLgujzMtrtbE4hpGw
Date: Fri, 15 Mar 2024 09:22:22 +0000
Message-ID: <BN9PR12MB52579198CC6FCCB13209BD10FC282@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240315091607.1070927-1-le.ma@amd.com>
In-Reply-To: <20240315091607.1070927-1-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2bb5276b-4a9c-457d-9f1d-d9ce77624ebd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-15T09:20:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7841:EE_
x-ms-office365-filtering-correlation-id: b74b1fd2-14a6-42d9-464f-08dc44d16bbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /J/hrOhDSZ2E1zseVQkIbnrlAAl9p2oyheS9xHt8SnotvDQsYiLqt9k9DlLGKZzAbdis+/f4gn0BiGdOQXvjmf9klrzfhcqQJfV3BZ4ifsxp0YhrFzQ8lnDO653WqUQiql9fcKXvK0yYJoKIRPkNgYpp7SEbDisc6+PFXtrZ1wnPRD98O4QPGM0TGfw7X8gRucK74cYLqmYJfaNj1/ArWZgMbcPEoKTbsCI68zfhrcBN1XYIa7/1Uhwoq/OuR7CA72XPCID31cZiusN5coVMFjOxjXIgg0MgKKB9omApDjn5HepAdYLcws+KI8O4PXT89Nr3iw6+fjwuuZsqZR+8f0tfwJxpjapalL+CQhgkcD1xtxZC5WUxYpLI7tYOXEBdZwAaR+ExU2tg2xqf1DtjAW0czwMhQEK+SMBt4R3KdnfybCGBrpf+2t7zc1LuB+GmzM5Zv2i6Exm6jEm5FZMy27yqO9uuCcrWGzVitFU2PNIjvO9qHOY0D9/xBzVesEmW7cen1xrhf907ZSWPX85sWAeo0SN2R2xQ0cPuwG1r0IKosgG6R8hBzb7Xb1YZtxEyb0plYODSb2Hs5ZYU9RcPRf74hYsw9xeEu94YS/80ExrM/sKoV+SWMfV6+oTFsWtZZkhlx9KMXmt6q4O1Vc8yc54b3zCFs2Q3NcKX5WUr7xFpeUFKfxe6PuFIXZpTYzINLFfSBMC7pvE9+fVG9jdbcQLWdfrqBBt3B99mVT7hWwE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?crctGlyW6K52gYjoz2wM6cpHLl8c7KWLwfvPETcP4h2lUkLuECND3iLubRcw?=
 =?us-ascii?Q?GwjI0aflea3xrECZstU2xZkf6DP7fOxdx4ha4F4z0JrD9yY32o9gJ9Fbve9r?=
 =?us-ascii?Q?f6Rl0YhT5dkkFos7M9koXbQyQqYpPduez+Qyr8nFm9l6RDT5dF6CskIsnpC+?=
 =?us-ascii?Q?bwpAQo4usaCV+rAhE8svqyN+LdbT6EMBZa5D2hgeSCSTaEiHxH/b6bmPSySh?=
 =?us-ascii?Q?g/YUw+BzATrNBM55zpbh0BANYK9HB8VyMjtAyOluYY2KCw9z6VsN2QzWtnuA?=
 =?us-ascii?Q?TLDY4E8Wv3E3gRFvaNQDH9lHZtcqPn2pDeDUpaqPjBEhEVM6uQ98tHneclAr?=
 =?us-ascii?Q?KpetwQsbexlFANKKUOCmYLZas+857+T1JVL+n9yLEJzdsDDtAL7U+GTRmy3r?=
 =?us-ascii?Q?1/CfIh1l5kUkF7fRUKbPGSM+kKG5WBHFLOnlxpISS4evS+V9rIcWLo2kYSdx?=
 =?us-ascii?Q?4APfSsVoZYNFQoVbSf/goT74yGJ3sNL20W6xL0dw6EwZKXlN+mKYUP+y/Lr1?=
 =?us-ascii?Q?rYS07TBTNVsbtOgKld/S4IyaB1NhUenDWaTuqHNFUgR+vUEnfSSnwZz5WjNf?=
 =?us-ascii?Q?SsRTFnIfYjXscq7f4PCNgMf23G0wI9cso9hlZLn1RR4wr6ohfyNqJPL3s4t8?=
 =?us-ascii?Q?Gfpjg9067bEMLiGyIWaAnF+aFiXjgDwcs482R4MMXpO+NhJMp6Mti223yq52?=
 =?us-ascii?Q?9fVcTtiib8qiFJjTV6MnpYDSBOS5xdSO9/5RPqjDBds0SfFJfm/U5mtQ8Rh4?=
 =?us-ascii?Q?ZZNLWV1aXPqk5EpP6j6pmE38Jqs93f1xJKwbqsYR7XjzToh5Iaayd6cNJnWZ?=
 =?us-ascii?Q?ltIKPLcjTIW7JB0fx/eK3miCziSPTMMf6OSOeMBz9/HT71EL7t0ftjPQLzcK?=
 =?us-ascii?Q?U97Xz/DZGDy02sC+y13gOVRPj/wQaZBrXAllTn7kc5EEl8p+ATvtbDmqNJOZ?=
 =?us-ascii?Q?gTCz07xN4IlYtLYbbjq6vtu7gu8y8kv/gVKXUTUnirscXzoWceL5Pq349tVS?=
 =?us-ascii?Q?vkia//4uzjKi4O5ox7WSYcQMeZ220BbbOGGRBT9gshAgrw63wFjxE3L1xe/2?=
 =?us-ascii?Q?1y4FkINM9+h7fFhV77sHsdSDHtVR4JTKs27oP0TRAFgpg4KM5hibd0mmgxHe?=
 =?us-ascii?Q?CgIX0HMS+wRDtd8bBI01xHXPv8aF6u5tx1H4m/lPm/IWLgV/T1eJAKzDG6eW?=
 =?us-ascii?Q?Rjdp2F4CZit2PvgzpR2lLIKkNLuOrkgaxPs66C7r4qk/O6OGBHm9WJKJL0U6?=
 =?us-ascii?Q?J6TgJ6aXw3cTSJ3P5in7wuaQvfmsgXVUWxZoNVBSKqNF3OIgtUMG4voL8rKn?=
 =?us-ascii?Q?SMHz4jdTSag6b78pSUthtPdrkc1hRw8tD7EKqsLY7821Xzo6ptRkrawdJw1Z?=
 =?us-ascii?Q?9bEjZw3XCbH905w80Az+AS48ctBNbMzirsaLiwyRmuhkTx1rvaFFjJIHcVz4?=
 =?us-ascii?Q?ce+BWvRhbuEFamZ7gHGJYKt8X/eQsDpvgqvNgt5injDUXBxl0scWAm6Ibn5J?=
 =?us-ascii?Q?R/1TSHgvNmz4qm/nKqaCeIRR0qdFoWl7nWjuFSD753fJPk6RlDt58L5FmKZ+?=
 =?us-ascii?Q?MzkSboOlDlzc9somKkjwvUO0lJ2ASs4qfZj/VNzV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74b1fd2-14a6-42d9-464f-08dc44d16bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 09:22:22.5689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J15MMMxOkGagYW8igERqH9vU8MZoIKQvCdwTvXWmk2udeGFNk/0eNq1T9mEtJ9ExyLF1GKFP00tF7ACmqqWoMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Ma, Le <Le.Ma@amd.com>
Sent: Friday, March 15, 2024 17:16
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Song, Asher <Asher.Song@amd.com=
>; Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: drop setting buffer funcs in sdma442

To fix the entity rq NULL issue. This setting has been moved to upper level=
.

Fixes b70438004a14 ("drm/amdgpu: move buffer funcs setting up a level")

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index eaa4f5f49949..589a734982a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -431,16 +431,11 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_d=
evice *adev,
        struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
        u32 doorbell_offset, doorbell;
        u32 rb_cntl, ib_cntl;
-       int i, unset =3D 0;
+       int i;

        for_each_inst(i, inst_mask) {
                sdma[i] =3D &adev->sdma.instance[i].ring;

-               if ((adev->mman.buffer_funcs_ring =3D=3D sdma[i]) && unset =
!=3D 1) {
-                       amdgpu_ttm_set_buffer_funcs_status(adev, false);
-                       unset =3D 1;
-               }
-
                rb_cntl =3D RREG32_SDMA(i, regSDMA_GFX_RB_CNTL);
                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA_GFX_RB_CNTL, RB_ENA=
BLE, 0);
                WREG32_SDMA(i, regSDMA_GFX_RB_CNTL, rb_cntl); @@ -490,17 +4=
85,10 @@ static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
        struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
        u32 rb_cntl, ib_cntl;
        int i;
-       bool unset =3D false;

        for_each_inst(i, inst_mask) {
                sdma[i] =3D &adev->sdma.instance[i].page;

-               if ((adev->mman.buffer_funcs_ring =3D=3D sdma[i]) &&
-                       (!unset)) {
-                       amdgpu_ttm_set_buffer_funcs_status(adev, false);
-                       unset =3D true;
-               }
-
                rb_cntl =3D RREG32_SDMA(i, regSDMA_PAGE_RB_CNTL);
                rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA_PAGE_RB_CNTL,
                                        RB_ENABLE, 0);
@@ -950,13 +938,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device=
 *adev,
                        r =3D amdgpu_ring_test_helper(page);
                        if (r)
                                return r;
-
-                       if (adev->mman.buffer_funcs_ring =3D=3D page)
-                               amdgpu_ttm_set_buffer_funcs_status(adev, tr=
ue);
                }
-
-               if (adev->mman.buffer_funcs_ring =3D=3D ring)
-                       amdgpu_ttm_set_buffer_funcs_status(adev, true);
        }

        return r;
--
2.43.2

