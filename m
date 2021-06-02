Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A1C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427B761C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427B761C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1E66ED8F;
	Wed,  2 Jun 2021 16:50:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F8C6ED9F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aecZAdnE896QwrU+Js1k4W2H0K2E2KbhrKVenzuysLxz+95sJrGM1PAdCXdGwd9hEHAeQdOfQAB5hO27vl7ow49+gWz2OARCc00qmCknZk+qcGPoMXqOuRmbHUyCq75CdFgYdN3BS98nW1NzIlz1N/T/kmmFX/2JfcwwmxTXDGM19349L9ua5DkhLLy72CeNXpXO1YUsk2IJ/QnJFQQzXZxejpTijkXo1SPsP+GTHt8Q+5t14ig9yuRjTx5kSF+J+2T1DwyiMQwkOsOReJeHKtZ5GuG2EJcKLZVGugmi1+ZL/DM8ZJD9Z4n+yn3W64sqUpZgrVG/24Xgpsu87jAELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lBxJvn2+boONDkiUO5Q450G19yIcGWpgTyhZ5WqAbE=;
 b=FyRuE3S1WpyP82Kh99bKKCH1Y1yYYSNlLAwe4QnVVxsnWx/Cj8QHYqWPl4eWQiZpcXl72f/MA761/g2ZExWd71j5MaiWTUlif5mIGWoAc/znLwQMRhl+3dirDAicxFqXUphUcEz5K/zOM6nKD/f2suYC7f0tbQCGWnOPKytHXLO0I7zGK1kwyv/4muFSHH7Porf7itNaThXVeXAg1web0C8fL/KqIeA3a5fL6o6yclapowGXIopcIkOblhDQLqkwxwCSYXuseUXVBXo+mUg8+DjpumRvaMCX388ca9kbe2aLt0EkJ5wdxfI4UDFIXZlSiXhH0nSBBhg5OvrrFXtMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lBxJvn2+boONDkiUO5Q450G19yIcGWpgTyhZ5WqAbE=;
 b=AiP7kbGDwC82s2FsztTfOmZcPnail1RK/3ZwXdpxvk7liaefDW22EZXqeHjTeBnWqLw/2GAoN/sHrdoYeeM9OsF45bjDxmcD0nJav2GZm44xV5jzVcXZBPjVazCpkicLUOZgxovJTu+n0crCt7Yg5OjwhEUzUcS0Lo3gqeBFEkE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/89] drm/amdgpu: add SDMA Clock Gating support for yellow
 carp
Date: Wed,  2 Jun 2021 12:48:15 -0400
Message-Id: <20210602164908.2848791-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b99a1dc-1090-45b1-4d6d-08d925e6721b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46755A3544CF94E0204DE96DF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfmVg02WDbjZTqqoT12BoSy6gEwuYdS4kXj2XZnTKaLbmyR7y9qC7b1If078gnmtI/toWVsj2DcrWXj2z6qdIJvtiPkWXGhlVWIwbWNO0gLFGx4wbFKbgjBJocRVgyAC28s93LPJ+KTsZSil0EINEz1z0EEpKss7COe9RNbMs9r3+JBBWFAxMn+drcB8XHpmfePP+NGpqqsd54jHr1ZBNIEC1NZAYLGDQOrJaSJiDMJ0XOSA3+Y0iVt35yKVjhPay3lIFP3Z8RKhOC463GQqYWmG/X9HqCHKeIsaaciUNF2iEElgCh/Bh4OpmHq6iJwHpFOn3lWSOdQjyhtxzGVitXGYEYdirJrqt1stvSkbWzmx4pbv8ZCUfsbPC4V4GZf0wv2J9YCsJ2ytFAFHCUssz2iugGipdRGaVo2HC48AWy89+f0IApDJ43aMbmbD2IvWiJzaY8ravSvYsaQEDpV1CZ3b3z3xy9BkQ6og1nZO5Qz28o29vMyFH+9W8i+D6Fjt8z2MlwV9QfetbzyOU7uKpzlkYKnggPd4zgudjeQ/tS100hPPW2NGUe8wxnPn7VPuhDJXFdHXA4KomAJtBzJ8tMdGO+cyRoKMxbTRytAwGYikiZl9xDHG8S3jalQ3v+JKpfTTvw0xN5OuxyiqIvduQJOFbr12wIrJJeApsYCE6F0iyUmUkGIUVZwN4z2U1efT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(4744005)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zas7j2mNe0Nh1sok8Rcj6SSzgpcP4dpr8KtcawEjvr+f9CTdjj/3Uu7Y2fag?=
 =?us-ascii?Q?Xdk4x0K85MYNFZVyt8TELctXN2JE6fE/8phdcaRBELQuFlKFXde06e8CH6xk?=
 =?us-ascii?Q?NSIuv264qcWJ+KZR8mUxjqisL3AgADu9Yx4STSCHUAsH2amI/FvLkmfWdg4T?=
 =?us-ascii?Q?SmXr2s8VLXLl1LFDKDJ49qJNA/D060bcoYe9P7hyefh4nOAGQgHRmSZ6DwkK?=
 =?us-ascii?Q?w4Y20gSDbrQLoc8+NsSg0L0M6HWR+r6IU3ElCQ78DQbeb1wNmrrn+ZHjSC0J?=
 =?us-ascii?Q?mLx9gPq44YOJPajeufZqTFHK4bRhi8bxtd2yY0WDIHUmKHkEaXwWHhk3PaDW?=
 =?us-ascii?Q?5KbilBBR4lhTMx6xUeBzUQpdr/QtnwbeMPz1oc/osLS0hlF0kUQoHkR9cz1U?=
 =?us-ascii?Q?umJOWHNXeNV1xEd+mBAaSoS9r0rh15BNeAJ9xwMEZN8v4rik72dWzlb/w7sP?=
 =?us-ascii?Q?Ah0tqI5yRPLMgIzSnj3snDs0DRu4KPhoi/QfmQWpJJiNx0Bqaz6UZMWNf71a?=
 =?us-ascii?Q?G07qAvOlGMHNMU9fH4GnNeZ/iKhRCgyAV/fsq63+CwPf8jObLGsnGG+TEcMB?=
 =?us-ascii?Q?jXSMEYK06ZSHN17C/hLQmN+deIGxc+fjCL3oqmES0mNWbdMeNX0zUwndMJQ3?=
 =?us-ascii?Q?i8c91655a6APOqHrtRlXx1j/enlKFiB8KmBtE/PaUcDKWPW7oXBa+uDjJzdJ?=
 =?us-ascii?Q?g80ztzXTHHUcRUlp8SQKMd6mhepncYOXPDJaYZ4Qt5GlMP+tsmSWWz43xNde?=
 =?us-ascii?Q?xqIJ1zOdMKRpWquJLsLsNiXAz5GKSmF2cqw+y1WyXmzLBsvPGH04KQmIDAp0?=
 =?us-ascii?Q?f+Hw7x+/DUNxT/lMNvMp3LtBsvdtebmI9tewo2t3zVyJUHieEMBpMH443+EE?=
 =?us-ascii?Q?5YPI4SbuC1YXqJ2INIA+4GwsijrEh5dI2rGTLV+VX+oZOLxHT0aSNCupZbMK?=
 =?us-ascii?Q?1CxqwcUqcwR/EpqIR7wkI6wVwQtLKaYfl5qiq11GZ3ZQYHN+OVd3tOefHyFv?=
 =?us-ascii?Q?SzZgxGmDrYKUEZJKwdHEK/pv7dzwcqQBvtkGoCwnwhbUSYBRAn5HggJ+JCZI?=
 =?us-ascii?Q?KIw+iB7vdvOUleVhJWJmG29Xg4tNn7qSa/4UUeXfgkdfzf+zpenIVFoPH1B/?=
 =?us-ascii?Q?NKmAQ10X/BpHE3MznIQ9Ebb7H2I5M8QqxLg3Kpyyd9HJEsE636dQ6pGPVNk9?=
 =?us-ascii?Q?rsbFilagyKIONwgTwlI8Ccf2Yk63IqK2+W91vJ6/j1d+lsazE7/24lOpEyAz?=
 =?us-ascii?Q?dfMKLxGunxcMsQLrRJKgQ161zWjlmfN4a6W38/MWHLQrDi7XW4BruvEqRpBY?=
 =?us-ascii?Q?iD82lu+/MmYhDE9leIKQV8m/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b99a1dc-1090-45b1-4d6d-08d925e6721b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:53.8625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6XzjGb3LHoOgmNZaFJu2rgFNtevZ5rk/0YpFKHby7C4ewfJFo5uNn6c5FoJlIWVpDuvM2jWXyaz+Mf2ZB6CKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Add AMD_CG_SUPPORT_SDMA_LS support.
SDMA MGCG programming is migrated to RLC.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 3ffb8095fbb3..3e20c40766b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1335,7 +1335,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CP_LS |
 			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS;
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_SDMA_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
