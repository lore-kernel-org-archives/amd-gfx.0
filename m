Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F06CC2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 08:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A7461184
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 08:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A7461184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41F26EC46;
	Wed, 26 May 2021 08:48:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B756EC3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V77ZFj0gzcCugrswGONUOHrMjSCWGbv7TJa/UB+HV7HH4nWvTnQ4Gjg1LRDZDLGXRuaawzRgnsdaaATSLKn6PfWIH4ZfGuuQtITQ0AAkHV1C02Q70xHgO5yN37DgL5crQ85g19C2RiiGPWuYkqn9i3lH2Trl5NLkGf+E3pgEb3ptPyn6NPzjttkONK6y7wMcmEsojpFtlp/gVndoj9RezPoPcsKLuLcHfJV08OOBLS742mGx9bx/E2pUUbwDkZBGG/Zce2A4Uhy0kEbw79sqzhQroCBZ676Cr0H629KjoKamUdJrNJAXxkt2rMpoIeasQI9qUvf+MN3nzyOzshPikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F1XLBsv/78lhwh1p0hxunAlJNx2zYakB2Ey/e+I9eQ=;
 b=WdsqJkjHm1EdP+Ab3ufKO5buQ5C9AyaQoW9ICgQy9iMB4wFoS27h1GfTnb7bQ4UMgCIwLIZviaUJJlgkuVhVgffJidT4kdmEIip2rJdg7bkr6t+D7GavAuDNFLfyCZ8sPcdAUj03WFDC7kBkMZ1ZLU+7e4hYPMA21oF7ngkkei7Emgd9MBWqR8B9AavZYenpm0nLXNfn8Zq42sSmYXWUWNBkEt+F4z77k8szDabxflICJVnqazZxl9E7vDkU7Ov0sOYv65FmZLwZDz2AmcbS/3UKi23TEbeWjis+KcQh9xLcl7HJ6xsSH/0Rxut+7OwYGLAU5dwHFJv+cKPzeCRYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F1XLBsv/78lhwh1p0hxunAlJNx2zYakB2Ey/e+I9eQ=;
 b=OUpTJTpFPOpuR5OQ430msACm3+Y5DRtIsHQGYaTBacxsisLfdqipBAn4WOvwjwE2RiRJRRUFjj7gYT2aV2ZGV1UT1edztSCXWj/XemWprJ34FaJoEZ94jBxdbab9ZfnE+E80dEEOmMPt53lEJte8g6hZHRjdO+k2ahe+u462I3I=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 08:48:03 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 08:48:03 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: fix metadata_size for ubo ioctl queries
Thread-Topic: [PATCH v2] drm/amdgpu: fix metadata_size for ubo ioctl queries
Thread-Index: AQHXUdzHPw60lU3buEWuuRBv+0/Doar1c8fQ
Date: Wed, 26 May 2021 08:48:03 +0000
Message-ID: <DM4PR12MB513675AC97734E16B6D88DAD8B249@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20210526031054.1122-1-shiwu.zhang@amd.com>
In-Reply-To: <20210526031054.1122-1-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T08:48:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fbba394b-4e0a-4d18-bc90-2ae5141d8c1a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2003:c5:8f26:4300:d522:207b:ae82:4dad]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4031f3bf-c67c-44af-70fa-08d92022f990
x-ms-traffictypediagnostic: DM4PR12MB5232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB523247879561BF0EFC89EB618B249@DM4PR12MB5232.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDu19ATza03HhkPOaGI83hVmEsDkxfa/ytIaWq9sBjLqEMyPBAlVBJKR/BcBYI9Oht1ZWayvVD/MwLcSkLWoeWDFP2A4dKbDgaz6VTkpa17mZN6Mrd9K606i7EqbEZiNAix+ZLOtg4rzYF2I8DlYWhIbGDpsEfxwoyhlEQC0XggwE7v1iSN9/c4h3ofpOI9iM+k2aGIBcw5pJdGwueVKaU56M8khFdmGGqd70Y03x96JhaMDutZ1R0i7bnhld8O13GczzBT+DBGKiba27Euv/OPlpJsLYFl2O2qDsptwppdw4RYHKBCkT90QqP6NXBHCTpe51lCB12ScsTuuZajw3tK/QbpC38Q5ziejXeb8lGq25gb5IHzRSUY2p7xpWsWuA8gYDgMQq+IzQhZIngGQJywNZzv/2sghoccz/5+jbUG1LTx6VrT5kKVJik4rdpFi5jV3U8mIcY4G01S2s6ezvcfG5MxvnoV5pvnIl/tjrJ+Wr7tuUP6ZF8rmcMsZn/skRd5jUg7KBg6M5AdCNP85xCUBEefucaixYcxWgupsLKT0oX/7bgxxajfEuq4kEhH4LJAu0EjXbQXxLu9cX5paARFksWUioqfC2aejrJ0t1wA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(52536014)(5660300002)(66476007)(66946007)(66556008)(64756008)(76116006)(33656002)(66446008)(9686003)(71200400001)(86362001)(2906002)(83380400001)(186003)(478600001)(53546011)(6506007)(8936002)(110136005)(316002)(122000001)(38100700002)(7696005)(8676002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Jh4vdXtrvyLy020Rv7RiSYskBBmBoN7rp9k0HkvnehuXPRKFDZwAKUy91fud?=
 =?us-ascii?Q?LpMW8dPXepdsY7AXI5MPmLTorXDnO4TU/c+QRWl7gGnqrSvY/nIwLA1ebNGL?=
 =?us-ascii?Q?1O1yn2xRWdLyJDu8ooB/P95NQmSntnpnZjbRPMkOhQDAN+zxAowudCCHNlL0?=
 =?us-ascii?Q?BgQTo4M5gToxsRAZVRhRFtFS9eBmcvr1CdIW7PUp+ATTtKzCzkBXlPXcUYhF?=
 =?us-ascii?Q?MveH459OrrSKkjHeWsu/tDpBx2woDSZxMFGtRpk2hYyPD+G6OR+CqfqNDfiJ?=
 =?us-ascii?Q?utdWPWx1ktnmIhtHvq79mXYFkfP4HL6XQYsP2KR1AlGrFhCGPPziC4jaEFR4?=
 =?us-ascii?Q?X2zsPSCAO5kWtKKi0va/l4kSJAnCufJlF7Di6bXiFwj/uhxEmdBOtDQuCUvL?=
 =?us-ascii?Q?q1O1UORTZO35SecBqZmOI4qevOL6YMiw1kKtaT6euRdu/0lVzgcaW2ULK8L4?=
 =?us-ascii?Q?A7A5utS8EwrgNTmNXWu/t2PVrKN5zqBrZgI0Qb+v5m+VElI/3i0s4vznwvDg?=
 =?us-ascii?Q?gmgffC2Hmx41k+JXbdtqBRQn89P3TutqqVcjSNypWu2VWMq0n4V6/vTrPau9?=
 =?us-ascii?Q?Rdh7h1FawW7b5BouaEv9zWunMahWLYmJmp9U4oqVcBHOU5ke+XwhKIuZi3vl?=
 =?us-ascii?Q?oMGg81Crhx//2COtLapb7ooEESdGoQq8QPtfF+nx0VrPeaYRQUxQ8ZkvRtVB?=
 =?us-ascii?Q?roN08RMHmI9cbUlLMsgau4rznp/5xW36ENH4Wn0vqKRjK8OMNNHEZtwNqRBs?=
 =?us-ascii?Q?2gywJePpJmJBXKeypEBsW22uAVwkhEB01umoPUF4+uRTmMbXNLDLUWCYs2ZT?=
 =?us-ascii?Q?4wmhYJuuHWHdGbK57xGYe0jw4b1ywPo1J/DNhaIeRCjlIbTRtXoTdNPWvv+k?=
 =?us-ascii?Q?UwSs5IepEl/EhChtsYI9fT9qzxxQe+JOrGJ2cuwZ8ptMEj9IfQcOOIVqTUCP?=
 =?us-ascii?Q?kozYXsrf8XTwWQrDsk9yqlrl9JTMnDcDnfxJapVXmUeeJXENblJ1MRz7eD7a?=
 =?us-ascii?Q?T5YFx0VMS8/sG/KWsLy/hX05avL2SXIwd+H1QqdQzTIYxS9bKFzDWKlAI8ss?=
 =?us-ascii?Q?e5EuCAxvgrLe/hZJMI4d5WXnT9OZ2b4owhwuyDPxaHvH+SGv+ZZF5fnV5035?=
 =?us-ascii?Q?ZKVi/m20BGdFhVK47VyCXO+6GTNOKSP5APm/Aec1TQbSS6S4AC9EHJkbV7aE?=
 =?us-ascii?Q?aT2FVbDY0xLRskFYKyL3LUPMqGE/cDlKQhIvc09mp9SD+LtxxRGXD8fCl5me?=
 =?us-ascii?Q?C2WUhe2jBmGCWqPslrPGtNGwSz62CjvqRCWGk7y7jjo6munO2k8dM+USKbng?=
 =?us-ascii?Q?sxcSA1ppc4Mx5YTZYKPw5k5sisa+sSrVh3OHiHGqfzA4O51Y4j1HP7sm2RjL?=
 =?us-ascii?Q?sHsNYNA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4031f3bf-c67c-44af-70fa-08d92022f990
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 08:48:03.6092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctOB1VVN5auVporcSsNZWYcWMq3XKMdOvg7rl8OZPU6EzHkvjgCEJ8T7aJh+gt3HBoZNF9ZrgEbRSXUj3sXy2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

-----Original Message-----
From: Zhang, Morris <Shiwu.Zhang@amd.com> 
Sent: Wednesday, May 26, 2021 5:11 AM
To: amd-gfx@lists.freedesktop.org; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix metadata_size for ubo ioctl queries

Although the kfd_ioctl_get_dmabuf_info() still fail it will indicate the caller right metadat_size useful for the same kfd ioctl next time.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3f85ba8222ef..2d876e1eaa7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1213,6 +1213,9 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 
 	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	ubo = to_amdgpu_bo_user(bo);
+	if (metadata_size)
+		*metadata_size = ubo->metadata_size;
+
 	if (buffer) {
 		if (buffer_size < ubo->metadata_size)
 			return -EINVAL;
@@ -1221,8 +1224,6 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			memcpy(buffer, ubo->metadata, ubo->metadata_size);
 	}
 
-	if (metadata_size)
-		*metadata_size = ubo->metadata_size;
 	if (flags)
 		*flags = ubo->metadata_flags;
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
