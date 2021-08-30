Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F97BC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 03:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3573860F3A
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 03:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3573860F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C2389C97;
	Mon, 30 Aug 2021 03:08:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2196A89C97
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 03:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzB1++smxiGc3bu04ULQSK3NCWgdblZR3/lASYKyBBigmoajObl2TvnMaxm/0POx1HpokGBdGx1NX9hUQDYh6oTORrbtriCT5c10xYTUdGUHRPi+JB//6zpuVKaBDHIo8PKVSKg3tzAJL7K0b+NVIpezY30YkI7JQ1fcU8V+V/lcX4p2f+aAmTyboOt3hqVdRNalAGtgCE8YQ9otBVF+6TpMR6CvqwHSgEYMinRHe3NnIYmlzFlAYyPfXIQRZgZ4rsWH4+PR+pd3Bk8yb6kUqqYXCajBbmAyzsf5qR+wPOA2yJpnPNDnVijrdQSiPx2uCL94QHwhsrmidRliL5Blng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mjutnXlBX3KbPHhQyffKf7HYJlUXBJfezAkWGVcmYc=;
 b=ac5TcV4U7izPPAPbsoQKC6mm5gOa/TPf4nLdPsX1itqROZVy8xRtUoleyBCjzEW4scpqTOn8Ks5jVncMBrSZMCryVA1RaVfBkue9lX8PG9iFDkQjA1tSIj6fRZjaspTg4TR+EwnxvLhwGcKyVajLs9x3GWLxXWDVShdcIaiUSOX/3A27POetXkn8UPqCjo8lkDj7zKAccKMn68vTOML4wLdD5aZGOeoqkOYvV0nRe2VVYe35A0PInsWpb6WhAtY6HUQSE8z4yg0T85reBc456dUl3CE6FPp0nHgJgaUgp8IG8heRGZR6nmRC8GS0PJF0eeZb4cm6XY3rvCcauTJ5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mjutnXlBX3KbPHhQyffKf7HYJlUXBJfezAkWGVcmYc=;
 b=J4a4bP3JplFmXTsXwlNU4fD78+SWAoH1zp0V5T59dArkIktB5qSpmbd5rQ+0D6jJ97aCwenWpX+mKDVyvk76OmscTNGM8kbE/io0OmrQTIOXKMMHOt6+2EHHsGS5360C3IMQVCpkm7uFaIwuH5c68q+AhHRmpxWHxAbMYuG6Jcw=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Mon, 30 Aug
 2021 02:53:44 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 02:53:44 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: add mpio to ras block
Thread-Topic: [PATCH] drm/amd/amdgpu: add mpio to ras block
Thread-Index: AQHXnUhLoS0SrZWh/kGXKehQA7dcP6uLWeew
Date: Mon, 30 Aug 2021 02:53:44 +0000
Message-ID: <BN9PR12MB5226A97E0793016EE03DBF02FBCB9@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210830023914.13670-1-candice.li@amd.com>
In-Reply-To: <20210830023914.13670-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-30T02:53:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=36848324-a0d7-4270-a79f-dee504a6c098;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7f03254-bd82-4ebe-a5d9-08d96b6161aa
x-ms-traffictypediagnostic: BN9PR12MB5161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51618F4D0403C7B991279ABCFBCB9@BN9PR12MB5161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sp5ldHrTHKT/zBYPnVvc7KIl/3tBNWayvvORa0wXO2EZppLK8JceKW5531XrL6sxKnbF0/hwcoykizvhg+YX+/Z2NnkV7DyxOQCK3FC/Fsl6/6BsA6mnDK1W/ClRcqs+nbegJV7lRNcAtbHPi9y5fdiFyF/0O17eUwp1OBilU8V8HdLx5Cd2aZhVhd+NQSNWrLm+wCYDMfBZDjHNzoB3EgrRNS8vBvy1V2yw4cZOYzwlk7ojt6BJHiBZlOSGxIQJSsDFazq+kb41MoJ6VrzytJG4NFtv7iP0BKUOWXFgkuV4Shviy9ecX6vcl7Uw6lNDANVdevtRbnA/wgDxRchRTRst75kWlKJWELzB5fTcVQFAt271S/NUAbCWgsQbpsCw4zlQ1/ynz/Xf1JoHT2qD8Oz7K82E0eocG7So/b3Ty5eAzSgBTqkmn0p1F73lyb2DZuMAWHG651yhqpwJ0urqVw+CrgBvXDhwrFUMOw+eO8a4IZ8M0bjRKhz7KchKMI3+ZjHXXknzqywW41T2Tu5JnQ5BBzB4YJeK+esAwumnyoyV/KnkUcWBXi+/AiAMVfkwHAYx+uWQh0BQH4p1ieZfVZWOe6Q/UWAD5SflTabXVlY8yQfauyGCWz7AB9mLosx5zC0JpeMfueTfL3AkINJrYTIpRFtDdoBFruZN7LHwJOYxOKpKym9vjUHaNYTqZL3TdF4lxXNRzOT1mRFvEZNVVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(186003)(76116006)(8936002)(9686003)(2906002)(64756008)(66946007)(66556008)(66476007)(66446008)(26005)(55016002)(8676002)(71200400001)(33656002)(83380400001)(52536014)(86362001)(478600001)(38100700002)(38070700005)(6506007)(122000001)(316002)(53546011)(110136005)(5660300002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BsDiMRFDQomSJ3V8O2YsIrOCxnBovLTiKpo6Lfi1FoeHIFPztaBRX9sMbO72?=
 =?us-ascii?Q?3NlILAjykMqq2k6wQpFgA4QUXBRmP2wX36p2u4Hp68ZDCvdQiVjMleweasN6?=
 =?us-ascii?Q?kELS+DgTpjWEuHLnbXbMfqSbUCioozqPNiEkk604EuR1Cey70vKNpbzd0t9l?=
 =?us-ascii?Q?T9RJv+dQ3+kSypcpiNM6El1BUTqpIHDEwqPhU1V3OKkCQQe5xyDqbfKVWQs+?=
 =?us-ascii?Q?1MPNb9WSpkDOCIXVLRu+gO72JFB3BMoKT/QTCNKPUb+X121g3Wk48DX0ZndZ?=
 =?us-ascii?Q?BjqbU3wVF5mnWe5n6vkhZTv3NWXa64D38XSsuxRuBXYm5jCZAViqvkNAUeh0?=
 =?us-ascii?Q?82NbEh8OkkAzWHa93jszqcDFCm5wM8BQYoqpl6simcK1o/vDxmY0mrm/Yt3r?=
 =?us-ascii?Q?tDtoIlaxZpM9kj/FOWOr0Gs8WyGyT2vPxb9OkkxxWvH9SuBM2yjhIFSKlSX/?=
 =?us-ascii?Q?+P48L6Dphwt0wjRmJchdPI8YpE00vvyAl5Ukm22NwaepIIiX5RqwFy+4LZQx?=
 =?us-ascii?Q?RfrOKk0CSJ//lJBALfYTVx+K8TYvWq5tRT5Gd/53V7wOT+bqnz8Gh6IBn6je?=
 =?us-ascii?Q?565MU8XQg9wLp3a0V9vgw3H+hIma5I65SCWAdo9qtQXPHy0ApkXmL3HEDCQS?=
 =?us-ascii?Q?fiB3x802LN2uhcw+Q8ba657JgGsNfPoZCoJty8+6aHoxyKUtxttNwllcjrRg?=
 =?us-ascii?Q?jBAq0UUKED5edixDgpvC3ul3VD88vqHXDq7/3a0HwhVyo/7/hRfFs8+ChlVq?=
 =?us-ascii?Q?zIc4lhSK969d+lz3oVyKSKPUASTP+b3ch1VAAXqBOewshK9sUaGBNMwPAlxJ?=
 =?us-ascii?Q?KG+DSos6KNy7apd5QpR/hKNlNYRtHRzV6+8BrFIKH7lWEmC066rPxyQDqiaD?=
 =?us-ascii?Q?Zes/AmRD8haO7HfQ9cknm4O7Bc3YwdWx6976ZWRwZnlEH/n4RHT0Vui3kq0Q?=
 =?us-ascii?Q?v5Fpwq+K33y2f2BuuON55vG0SR4yZ7Xgi7UEbZ45Stwub1Io3yyNPXxG5INO?=
 =?us-ascii?Q?WqZhR3Q/MKX3QS70qYGRWzRCui71/O4RDxxkm5UTMGbQ+wpauOskQ0cvtV3J?=
 =?us-ascii?Q?/V6KfmUBWbF55/HAnlUNwUSV4WTL82k1Ksi+Yu5Jj3t2w775/V7karTakncN?=
 =?us-ascii?Q?X1k/f0+UrwlRh7vJ0aT+m0gA9CAVPrHu02oW6ztVEtLX8auqcMno1u+Dt8OT?=
 =?us-ascii?Q?gZNTWbzzAANIXljxggDwYwVfpHkTu5GoObDfWoJwj+PhX+yWIlgI81rq02Ad?=
 =?us-ascii?Q?juRt3+nisyfLUdSzmTmKX1sByRcozj4/2JLuAhYKpMN9wWGsMUhTaL1ZFRMu?=
 =?us-ascii?Q?lGrw2o2lQK4ekUyK1wBFPBwC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f03254-bd82-4ebe-a5d9-08d96b6161aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 02:53:44.2566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lt3ZvsyZzwW6t152DFCLqlD1rS26Qf2rwxMI1w/tBAFxlN+Cl6G3AJ6H4rksRWQbBQuuC0ON4I64KjSy11Zsyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>=20
Sent: Monday, August 30, 2021 10:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amd/amdgpu: add mpio to ras block

Add MPIO to RAS block

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +  drivers/gpu/drm/amd/amdgpu/=
amdgpu_ras.h | 2 ++  drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 96a8fd0ca1df31..77140821dc1126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -61,6 +61,7 @@ const char *ras_block_string[] =3D {
 	"mp0",
 	"mp1",
 	"fuse",
+	"mpio",
 };
=20
 #define ras_err_str(i) (ras_error_string[ffs(i)]) diff --git a/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index eae604fd90b81a..1670467c205463 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -544,6 +544,8 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 		return TA_RAS_BLOCK__MP1;
 	case AMDGPU_RAS_BLOCK__FUSE:
 		return TA_RAS_BLOCK__FUSE;
+	case AMDGPU_RAS_BLOCK__MPIO:
+		return TA_RAS_BLOCK__MPIO;
 	default:
 		WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n", block);
 		return TA_RAS_BLOCK__UMC;
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/a=
mdgpu/ta_ras_if.h
index 0f214a398dd8fd..532260fd64db14 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -73,6 +73,7 @@ enum ta_ras_block {
 	TA_RAS_BLOCK__MP0,
 	TA_RAS_BLOCK__MP1,
 	TA_RAS_BLOCK__FUSE,
+	TA_RAS_BLOCK__MPIO,
 	TA_NUM_BLOCK_MAX
 };
=20
--
2.17.1
