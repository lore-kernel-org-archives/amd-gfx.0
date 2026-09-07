Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D89EC79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 10:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CECD710E1FF;
	Mon,  7 Sep 2026 10:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SvMYF9up";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5A310E1FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 10:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCABdKGMqabAiV3CMUcvmdmiCOR/q91ZitN2/kJtX9bAQJl9xf/xvnhXBaj9lVIyFTgyTxA7s7muGOr/8gRbjNi8tXQI7ByYP4kBpKQSXlb/Yx5+iqBkzsFSoyk/Jb7Q1nXs1ZLbEpFhOiiLt9+yiK+NfM6AUPBmIT0LapXkxr9CZFc9Ysf7+whVhskP59lg60OCbTowwzwyzuxioMgMyMCiZlJhp3N0rgehyFyBxTbnX5KJzhpjT+R3HxzUOnmXk7PE6SzpqOn1iBr2ymenyRJ14IC09czJvpGQWHqVelBuKN3ga/DMYSrjPp12osvGTbqHHl7qffDf438c1qtfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dVwBc7a6CTtn2pX8fT46PIr5oG61drArGLbIy7IcsI=;
 b=MieTrS5EShTtx2nGHPRhNeMXD57kHsTFcsbKc7OO3RQYrTMjpyTqS5E9CTL98gRCJo11cAGs90vHY3tSHcjBhsWQYhyK1NCSq3nS0xTBxIqbiJUb7N5i7kPmIMA3r7riOYLcXtFVXbpHlwTWU1EKkhP2ZDH+P31BcFJttobdQKFa/nVqJAeRI02ziF/8LHapip+hgIBfvn+segDFnFv1PUgpFK5cpHcCWZip1wcmO/tNmUn43kBtSOU0IklL6Viji1iSgfWR1+A91sSEy6MqGmJp7tHekUap+YVanVUTRV7Zrm+XiB51zpEO7UwbJydqpsefs1w6lqHz8nyeGQIOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dVwBc7a6CTtn2pX8fT46PIr5oG61drArGLbIy7IcsI=;
 b=SvMYF9upKsAZdhN5ZNouqpIO/psf6L2wCMsHl1P0UWitSUlJ4Q5pIhXhrO+qhDGLhGswCWnF5zqtprJsFFe2La/8JJ8SYbxBubVY03tJFibQDlkz3tRk5ZMIVzm1F4hPHo83uY8PnoF1Qa5i40Wt45BZKBwoc5X5qVv8EjsPOpk=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by MW5PR12MB5598.namprd12.prod.outlook.com
 (2603:10b6:303:193::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:14:56 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 10:14:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang, Horatio" <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: allow 255 queues per process on GFX 12.1.0
Thread-Topic: [PATCH] drm/amdkfd: allow 255 queues per process on GFX 12.1.0
Thread-Index: AQHdPq5SF+9Qtq5wZkmXuOsKbECx/bbC5UWw
Date: Mon, 7 Sep 2026 10:14:55 +0000
Message-ID: <BN7PPFFF39339DD9531E34D2C9F0CE54BD0FCB22@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20260907095011.1223820-1-hongkun.zhang@amd.com>
In-Reply-To: <20260907095011.1223820-1-hongkun.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-07T10:11:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|MW5PR12MB5598:EE_
x-ms-office365-filtering-correlation-id: 0c181943-af61-40d6-8620-08df0cc8dd80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: s3F1wsygNoPsoCT49B7Sh0EDAHZL3b5H25u1JXKXNocRrO1+gWtJqkuiWUXsQ+Mt9W0gb/Zkl43CKSq6ObfnrjykUMe77Jq45a+bhmF1ia2Jo7VprkplV00cMr+E1iG7YnA1g0H7wiyX2ofk6uE4uqpGNpv5ikB58OoTHQMtVZ4LYSsA1pgaf8duRJpRpMA3EI1uj/IccjNR14Qn3inSdnbYqNAvuXJ7+KhmK49gkxN/OiuxUKtpstyboKeDErbMReYUrtBHtVm76j2u9zdUpNaXkKJQYbW3YOm9PcuvXVGeQ0Mk3VUxSYcyjtQRUYJWmD0WZFb8ysp6CwIA+CpQWa+VzDDvQxKEuJW3BxlXvFbagHrBZdC/2wMnWm3Svc/3SOfidnXD/1jFQ1XCX6sj2KCQK5lQoGpQzaJY7Y9hcf9ViV80znfL4xbivJNU1DZ1GZa4C3nJ+ZCnRhYBBp0fSrZzTiY4LpWBsM3i0MrRDdHldyhhXrEm3ovUtorVJNvEA75bIptclAwg/VYPI8EeAAjtjxJBaaOL5bG5mynMU5Yze96zxArOhtXhy+995/s4rdNc/RHDjMaD4YW7WIogi3Et2EikA84Mt6AmbnA6+xzOT28h5ql3c8LuaaovwEBCtAsniHoBVOgS1Q6B9xcjwIdMPx91mC22hhj6QAvMOyo7JdJ9iig0O1xhPS01mib3B4WFF4e4S75aQBag6sKzNK/lWoRj/1eQAUBtwhIfkp8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1GqqknaKiOOLome2mKB6j8F5q4GAVFT8km/EOwl/upyM4D4rndw3ChxrXeLb?=
 =?us-ascii?Q?8HygBx774qa/I9dkzLpo03/UjRg40Wbm4CRS2Ql2KGQK+RXpzNwGrD++o2t4?=
 =?us-ascii?Q?11npEHWuvAU704iectHK07JwpITNbayKx5PdvQW9SO53IxH0GFesaKwgf0uX?=
 =?us-ascii?Q?hfX6zBSACtYT6NNha5dFqJCzh6gTFaAdZrk4pSxqKIoj2DFo9zi194NDUYyi?=
 =?us-ascii?Q?uNtBKv2kacC8VmoNA641K04phE1vitDl5td3kVnQNneLqnnTkoPKOTjoKAEW?=
 =?us-ascii?Q?5QrzMhUqS3hggTEg3JKGN6itH4Oten0x3rsx3yBd8eTfjpq1H8vbapfjsJaL?=
 =?us-ascii?Q?XvVbakU8AtwuiMwUx+LOmARirtDDs+BtuDedOmCUYmP/9Nx9CDoNM6CLY3Sm?=
 =?us-ascii?Q?NWN8cKjqgqzEGgGugTyfltYWb2gZ2YrDAUBRVlNVS7V8YYZHDFPhVpxInxrk?=
 =?us-ascii?Q?vwoyS7kFRtxMdXETMmxDReN00NuhKY+tHiQWVEMfmj5m6K0uDMKDh+3hbL45?=
 =?us-ascii?Q?BvXMdYyJKRhd35BZSJfPBftZ//ZhQXJZc7/dMSXB4nDcA3tPQNKmNVOxCoIU?=
 =?us-ascii?Q?ng8kp2pnHjbmz0wnPQ3/OFRI8TXx6LcoT6GStj/uXHoS2GWwZOdZKbkUWfSO?=
 =?us-ascii?Q?aDuPdBv+UhIA7T9oviEPLT6OfHGL+edJYsSzMRmVYYVw0C3+51mXEpkrbUjw?=
 =?us-ascii?Q?2IgA1wqb3Kba4JUM4bTqEZJ9I341xoS8xRo5Zix3z25xy1J8Z69vL+aibQde?=
 =?us-ascii?Q?mowCCxEhvmi6xWKRRjYUojTcyM2M8a9MvDzDeka9U1ESCqpR8tAWvLySVP6q?=
 =?us-ascii?Q?bVGtDp1kCv+LnaUP14cVm/5L7YUV/EtFo4uy/bRe5OdvEGp2X799ikYhJzRw?=
 =?us-ascii?Q?LJDAIOD4b+citOfOJS1xCowOld+MpSxuudTzd4uUG8nK/BZJWGzO8WP0nOjs?=
 =?us-ascii?Q?Q9vwoQ+MMNy3elRLT712eBZu3tru6tE4xQb4xeCVdV4/vPNyHzS5eRFeMzqQ?=
 =?us-ascii?Q?CGsh9gDNbkEySb3BExDgCYfcV0xyh3YapvkjrHoFAbfLaPO0LDo9RgBCDIWU?=
 =?us-ascii?Q?HwWqXwDeN8pYyRYJC5hn1s0ct2a0+yhR1aXI7G/+4Iwf0BoOp07oO2f01xFH?=
 =?us-ascii?Q?rstHEMdgLhZnIFU/EM9g6p5+mtxWs/XLprYNqNfFivKhK0hYLyH9V8Ttva//?=
 =?us-ascii?Q?9VS+8/scECvbnFV63VHQMgkrt5wHGtELB+OnsQ5tyjyVw+OWR8jcoGH3xc+B?=
 =?us-ascii?Q?UrdjOUj0UzWoxNqLZqmy8uzq4sNazTMfRe8wFRa3uh4MY3+No9P8pmDf8UmS?=
 =?us-ascii?Q?YCF/oA1hRqnW8D3JgGplZUORoNcMqkPpTQTUcg/cwbzCRH7ncUZWjqB2wOJ9?=
 =?us-ascii?Q?FgyZ4NxmkcSSp6prp912hKIkghsnngxVbDkI7scuR8GQKb0wvAFSQAJy7ypV?=
 =?us-ascii?Q?C1fvR27zov/VcYs19ECYNnY2eLoLXvhjlIHFBA7boPKdH28t6QS4l/VuQ4z3?=
 =?us-ascii?Q?JDkTQxlKoZeapzGXPrcmW7mdQvhqHLxbiu4Ux4c8h2oJ5neS+W9rNFbrscFo?=
 =?us-ascii?Q?tdtMtzp21iCzDwcspKzMOCDgZHOsBpkGo2qOagx59DXwisLH3T3/UY2fBcs/?=
 =?us-ascii?Q?BD/SnYowO+Jdne8q4XmMMcNcs9TX5j0PUVDtA592LMGlP5W/sUXSzVCeNEje?=
 =?us-ascii?Q?fRIHZ344VSYEiZnZwCBWD9ien2IE3P/jvsKxGo90lO3bp80Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c181943-af61-40d6-8620-08df0cc8dd80
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 10:14:55.8947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ucYWCHiDkriLL3Sq/ZFYopQGWAoS5S2KwvphAO/OYqq5Ty/aGl5aSrEoTwFn24gLWRTG0zdEcL4hfkdCSuSOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Horatio Zhang <hongkun.zhang@amd.com>
Sent: Monday, September 7, 2026 5:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>;=
 Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: allow 255 queues per process on GFX 12.1.0

GFX 12.1.0 queues are managed by MES, not by the HWS runlist, so the
127 queue limit does not apply.

The topology advertises 32 CP queues plus 16 SDMA engines with 6 queues eac=
h, so creating every queue needs 128 and the last one fails with
-ENOSPC:

  [ RUN      ] KFDQMTest.AllQueues
  KFDQMTest.cpp:365: Failure
  Value of: (sdmaQueues[j].Create(gpuNode))
    Actual: 1
  Expected: HSAKMT_STATUS_SUCCESS
  [  FAILED  ] KFDQMTest.AllQueues

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index fb2d8ad9c2c5..a15a826519ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -339,12 +339,13 @@ int pqm_create_queue(struct process_queue_manager *pq=
m,
        unsigned int max_queues =3D 127; /* HWS limit */

        /*
-        * On GFX 9.4.3/9.5.0, increase the number of queues that
-        * can be created to 255. No HWS limit on GFX 9.4.3/9.5.0.
+        * On GFX 9.4.3/9.5.0/12.1.0, increase the number of queues that
+        * can be created to 255. No HWS limit on GFX 9.4.3/9.5.0/12.1.0.
         */
        if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
            KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 4) ||
-           KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 5, 0))
+           KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 5, 0) ||
+           KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0))
                max_queues =3D 255;

        q =3D NULL;
--
2.43.0

