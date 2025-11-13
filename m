Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C8BCD5BBF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 10:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2BF10E350;
	Thu, 13 Nov 2025 10:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kx5ivc6E";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D0510E350
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 10:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQP5+yF31UZ4KXFeHAp7kc3Syf+26pwjrmzjIZDWaUIzV0xDVhPV1laFH7rlOo2iiwFtcghZZtWna8SqSjpIVsW45SNedrmHbbU6DqY8HPAD3+/qWY415Ut0cQgduuIcAEXcoZQM3h7Fa1tTnwjwCcv3XcusKops62oRc459ai5TTNYuRa0eXqbp0/xytPg1Y3Gt5vTORWTdYGvAZdEqx7j14yR1jn8UjGWQ4Mw8j+5z+GLy4lqZZLZQbNVDtc8yAvuPZYkZFVu4TgZOwiMjumR9fw6FkQkrjfOyD5j2M1RrtNyvY7Kz6rfbHxuIxiMJdjp1sjqeEHZ+hCyJX+U7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV0XwwkwSEZ0uHnxheWW9E4Bs4U00e8WURDNaiU+Y8g=;
 b=IEripLos0tFrkD/udPiGJkpI1clamDrqAQBRP+HgmuZFLIO+VR3DBKcEKyO7D/Ynl/8Jh7PzU7AhS1gBC7DDV7QZYEqnF7l1YOIZZAaZIDkOCe4rs5CRW1n5tGfCIWDmMOFSskSDYH06kpsB+WIeinx51+xsxVJdj4Axy85S/TwJs59KW4F1+wogSwyWyjZ+Pm193z8p30C0IKESnDfnHT+mj/3fmpLLtFH8tXAxpcZqDB8Bv9L9AyuQm0j7aNTnQgtZezfXTMCEKFd1jnWnHNsyqnAvq5/dGqHnxqi+82r7IY6eyLJfQ9ApP6APh3gKeUBhKRWfY5CRumjOGJZkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV0XwwkwSEZ0uHnxheWW9E4Bs4U00e8WURDNaiU+Y8g=;
 b=Kx5ivc6ECLF385+yaophlUYti4mgUKJS6k99p68KYdfK9DBSwVkKGlMuKG2YgwSSoIhLCoRivzj6f/wRqOvUSQgwhiFzV+HziIlCmr52sKAUVHHtCNw1W2PeO1oADswPpZlji6qKh+7mOaV8+gNgH2tCIoibpQaQG4vU5J4mcyY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:35:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:35:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Fix the issue of missing ras message on
 sriov host
Thread-Topic: [PATCH 3/3] drm/amdgpu: Fix the issue of missing ras message on
 sriov host
Thread-Index: AQHcVHmDqwJ8QPLIDkWudD2JZFeRabTwaYXw
Date: Thu, 13 Nov 2025 10:35:51 +0000
Message-ID: <BN9PR12MB5257D7E837759A7FCC8FBAA9FCCDA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251113084154.115932-1-YiPeng.Chai@amd.com>
 <20251113084154.115932-3-YiPeng.Chai@amd.com>
In-Reply-To: <20251113084154.115932-3-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-13T10:35:31.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6181:EE_
x-ms-office365-filtering-correlation-id: e5fd20b9-a573-4aa0-7891-08de22a06ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?huMgzQ2NchzRslicXgIZ0hy0aB0Lm7HniZ8y5UC4iVEdl0mSi3cTPRGLvyh8?=
 =?us-ascii?Q?X5P+fr9oLCcsNLRsKEUApHe9/KVplrELb3z2WIofc+g5Z7O+Y9zYSAJDgmC2?=
 =?us-ascii?Q?wMLNYzXJwCAHPvAoL/YpPEnEIjQnWpjtVWWOXBjasW/H1BrIuvN1cFYDmPrv?=
 =?us-ascii?Q?8kr1chytkf3ZacAWbINaKfbbY8QqWtA63wN7tlgD8r5V+BHrGjpRrVKvZIMb?=
 =?us-ascii?Q?fnZ/KkzXVWhHYXo9TC8YD7WvmCIiX7FrzIVsIBRqiQVS3POZiqJkjqDMWFdg?=
 =?us-ascii?Q?AMcy+2zt/Tc8lAttyZyZfDuL0GCyjJ6N79vVWkM7FJxb1hlIdOzUyoIdv/Ca?=
 =?us-ascii?Q?yjYGRWkvdwEcgGym1Cizb6Ku4yTT7/j8l0Qked/9zjCFLnRvUFWLbGzLiz8m?=
 =?us-ascii?Q?s4dQJx/U/eCGsDM5CC1WpNBiRoEp1rxr0BpZB7SVDfRVvXoXKToMKI0i9i/b?=
 =?us-ascii?Q?0a1nzvsdgidh2eshjifY6IE0hDRui9lWH0MOhOw68OmWQaRtXHn1oD9r7x1M?=
 =?us-ascii?Q?CALn220br0wV7+TcyN61uHgLH22T0/nmsHjRNPrdUh5B03lJ1OgYdtQxDLf2?=
 =?us-ascii?Q?inSzK+ma+1wkUtBW9ikO/AygLYUyyWVXNsym+r/vMUThZbaoRY8gMkz9elcf?=
 =?us-ascii?Q?fzgj6NUZP0i1Lew+ujBxZDraC5sQFfK/mVD+92S3BhzmMlp4i5xuqBv471dd?=
 =?us-ascii?Q?Cw569wgC8WBv3rGhGqaAH7CjAecf4tHrX/1rFmLGJztONSOOm+YK3NoLZn6Y?=
 =?us-ascii?Q?y5DpJA66zv2RPn4MuEcFQX0QejP9wU/0bdFtaf4CzGdpA8NxvISYvqW84/O0?=
 =?us-ascii?Q?Nhg9v7E54u1+F5VZqSxlP8niPLH3vXAdXJovNSZ1VOxGY4beJ0TTKF4F0U+o?=
 =?us-ascii?Q?ikmmM/r27GOSFIJBz4sob4A+YZgw7dTraGMwObxfp2rsKfFtxA/qkcqZV+d+?=
 =?us-ascii?Q?GSCoDOjxbTo9oDLy3ALUjf6oX6JM6aNRXQJLFlqz9g0eXa3BVk+BhhlfVBpx?=
 =?us-ascii?Q?ayGv2Cbd42+AHeGAYwtP1CbxlA5pEfaJiWDg9fgpX2kJMWXcPiDbtGFQCPFF?=
 =?us-ascii?Q?b/PoEcqb091YCOfczuAlQMCkiBdH1eQUBGx7ewgzgKJNJJmZ848k+pWS3LPz?=
 =?us-ascii?Q?JVbD2/WOOXjEYiTyuQ+tZ02f46fC10H5kB+n+EW3WZuCWKE7/CxRUBAJ+hLU?=
 =?us-ascii?Q?U2KOTumJ92sGasAxF8dmBhYzjzYdxE3UkfRPthf3a+WD1866uaMqmqGOCyER?=
 =?us-ascii?Q?VKy+uGIXDJLekgzbI6bxUqyp5zFsi24FBfBzcgi5dL/wHn2gn9+CQSIcIfIJ?=
 =?us-ascii?Q?zuMNQmSZkkRND8SGLJP1NUGGuulnZXFvl5CcYzsRa5b/05On7Aoy95oDwKvv?=
 =?us-ascii?Q?kho4uGU2z1KxjVcuH1ww73+i1ym7XDl+MCx8tQqEJR4rewV0wwDP7yQLnCef?=
 =?us-ascii?Q?k0/6tGtZBXOe2YSsoCsoZnUvyGxSfWEIoNch7o7GL0UM8cJKtlzRQGi9C2mK?=
 =?us-ascii?Q?juiy6VAg9q6if6r/7dHJqD6k7MbIp4XK8GmG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WZgqeKL9J1rhN9FKJar97A4EZZRQb9sBKM3ptULULlwGB81XoXMn6QLcgy6D?=
 =?us-ascii?Q?oW8ANQD+9hpfZ6t7DNcxL+yLZ/K4/HPpkG3Kjf2JFJhGXJ8/QTTWOnAS7hw0?=
 =?us-ascii?Q?GbmXn+rAhikbmmoeAnggKxnPFmXT/3DxNljlOU2n4b9IuuAgGj3r4dP+eX0H?=
 =?us-ascii?Q?JItDlcbMHjiJt2mM31GWN+PGcmcGTeju0hxfjEqwLOPA4ySXUOCZBXg6HBtg?=
 =?us-ascii?Q?Q1+532yKQn/WYh7zptlvWe7c0fmj2QXwCQJSFp86az2xaWvvaIvFv6Pc2gu+?=
 =?us-ascii?Q?d9u3b5373OncljVxX6e3GMmlNQPOysLvWNelIgviH2ibeF0kt/fPoqFP4ZAE?=
 =?us-ascii?Q?mng53sX1XarvpJK9HivjWWDogrjj6Z9t+EtqfomY4Chh35tCX7XZH3R6Gkh5?=
 =?us-ascii?Q?ttJnK9Ch27UTx7EwrMuMb3MThCePf3dKmVv+CZFYNNWALxmEH3zeEygtQuQQ?=
 =?us-ascii?Q?MOcEXXoO8Emxjgi1zx1xINr9AEGdcXYP+RJCxZAm/1snRg+TAfmJ23ZrPFvg?=
 =?us-ascii?Q?Q4pL4D+pRNcObgisW6raPc0EH2akOexl0FoG05DRWcu/3F1bTY89DVpG3r6y?=
 =?us-ascii?Q?b8qgjxYCHTQWDic88okiQ4diy5wrdJm3yUf3tR0ndral3rH+hMN822YVCnuZ?=
 =?us-ascii?Q?1sKqcRiZcQevKNmHYYH0CLV9k21sgKjYmKxOJiYSZq5ybbZ6Mlqt2il82HeY?=
 =?us-ascii?Q?ag55psSf5jhW2FIMt7xU7PF658BLguiHr0Uz9M1GYo62R9JZhOVk7a2BDMEy?=
 =?us-ascii?Q?4dznSqjQFKqbaccqmAiDpVABicy80d0NKCun0U2uBYndRBeJbi2kCy8kguZ7?=
 =?us-ascii?Q?0SgI/QtbfTInqeRijbrtlmsf9YLEPTMknMAn9PGj2GxvG5toHgP0X17UyP3d?=
 =?us-ascii?Q?x552bebG5znNeOADNxMkAbH+Y/pi7VplhVae98OwPDIiWkwKpC+0Fa/eNL/p?=
 =?us-ascii?Q?bUXfPfUprhED1oxQKeiXuzsp8gQHSIOuJLOzmYGKULurSH7O3oMKzMeHAITG?=
 =?us-ascii?Q?8JGkH+hH0eYuc98PZvsHTP2MIZ/LJiXIB/7COj7bb+HHG4BP+F9OXFO0xGDE?=
 =?us-ascii?Q?+lunbbfVfTr0X1p01ARGncUvDKare9y1YILT87w7qOh910bLgdCtsuU+woBo?=
 =?us-ascii?Q?juyE7UnGRd1KEVF4omY/DCuTETNwYqdgAULopD6nZ1JqIVxPbIQL1B/01Gt8?=
 =?us-ascii?Q?VL+vEt0S3dA4GyYpog+DAYw/9H9wsyo3n29QzqWyJ4c1wPkqt78iHTckqEaX?=
 =?us-ascii?Q?iNjeIjaJHHL0MPjlXO/OAXfXPl5s6ru8Rwh2Qrrx1/ZbqKmVtXyCfAtkR/Oc?=
 =?us-ascii?Q?gd77pn4X9NTxY0DbeJ41KXTgDM97vdY91EdXNaobIkoyCXKcQVNp0P0DZDLL?=
 =?us-ascii?Q?Otn68J9f8EMiX95D8jUWmScFUEmv0AtKTw+LMPrjjT83KCGvZBARTe2Otwr0?=
 =?us-ascii?Q?fUpPl7c/uJ0fAOceQqQlif0rA3P0Jto7kTzfvHHN4WNwUKihLPCNAqZJb+yh?=
 =?us-ascii?Q?uRIoIQe6fM+d5RwIiwq4fs6lOVdv5m9NMpNpx0BNNu29+A89zYi6bjzF8SA+?=
 =?us-ascii?Q?MTtWLN30WA4Jvg+4cIo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fd20b9-a573-4aa0-7891-08de22a06ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 10:35:51.3615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVsz8XAG+lwK9JLFTHnwgkZF/UAiRZLSIsU/6jix0KCy3kuU4rtU9t1FTU0OaiOTjE54uqV6M7OM5xivnYqfpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, November 13, 2025 16:42
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Su=
, Joe <Jinzhou.Su@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix the issue of missing ras message on sr=
iov host

This code only applies to amdgpu processing poison consumption after uniras=
 is enabled, but not to sriov.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    | 10 ++++++++++
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 39d712e3e692..70f5334775a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -36,7 +36,6 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
 #include "amdgpu_reset.h"
-#include "amdgpu_ras_mgr.h"

 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables @@ -757=
,20 +756,6 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struc=
t amdgpu_device *ad
                                enum amdgpu_ras_block block, uint16_t pasid=
,
                                pasid_notify pasid_fn, void *data, uint32_t=
 reset)  {
-
-       if (amdgpu_uniras_enabled(adev)) {
-               struct ras_ih_info ih_info;
-
-               memset(&ih_info, 0, sizeof(ih_info));
-               ih_info.block =3D block;
-               ih_info.pasid =3D pasid;
-               ih_info.reset =3D reset;
-               ih_info.pasid_fn =3D pasid_fn;
-               ih_info.data =3D data;
-               amdgpu_ras_mgr_handle_consumer_interrupt(adev, &ih_info);
-               return;
-       }
-
        amdgpu_umc_pasid_poison_handler(adev, block, pasid, pasid_fn, data,=
 reset);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index f540ee37a4ac..a662758b4f75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -24,6 +24,7 @@
 #include <linux/sort.h>
 #include "amdgpu.h"
 #include "umc_v6_7.h"
+#include "amdgpu_ras_mgr.h"
 #define MAX_UMC_POISON_POLLING_TIME_SYNC   20  //ms

 #define MAX_UMC_HASH_STRING_SIZE  256
@@ -273,6 +274,15 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_devi=
ce *adev,
                        }

                        amdgpu_ras_error_data_fini(&err_data);
+               } else if (amdgpu_uniras_enabled(adev)) {
+                       struct ras_ih_info ih_info =3D {0};
+
+                       ih_info.block =3D block;
+                       ih_info.pasid =3D pasid;
+                       ih_info.reset =3D reset;
+                       ih_info.pasid_fn =3D pasid_fn;
+                       ih_info.data =3D data;
+                       amdgpu_ras_mgr_handle_consumer_interrupt(adev, &ih_=
info);
                } else {
                        struct amdgpu_ras *con =3D amdgpu_ras_get_context(a=
dev);
                        int ret;
--
2.34.1

