Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F92C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 06:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49ED10E6A7;
	Wed,  5 Jun 2024 06:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+W7Ttze";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A6010E6A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 06:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTUM1QY2fhzQUFAMYWar0EeM8u8BC8+Yo01zAT50OPgU4PCjS+0uiCel/0qtwvEdhaaT9X4unR8mLlq3Jw1pdydQZ0PcP02ngpCYsVhAB3WwLWVbKHV3Ugj9MkQsO0ySJ0p7wOATK1K/dDqel9MaotaerWObQmyTsRs8zIdG7ngDz9kvHWXh1zG9W9v5HunNXGbvoZ4yzbkrvWtFLtp+muOyVbLXaDULEmYcaDCwhegL4ibyUHBmV7WZhBt4xHcfcT0Eltdqmc8v/jqZ52Cre55wGYcMJwUEm0/+DgWctDNVn5GtC9/zz1DCYrs4okrtV4Wj/Ctm/MDpzOlYuMP3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avlmWhKIezDcCWwCcmqWQNYS8JoOGhRfh4OVU897Ghs=;
 b=NU4vncZg+70+c2JES/oPjgXXjPyoNPv5t+WN5t2YNJoqOr0ShdltrDqUJNP8QTYwHr2VRH5Ty4nlVWY/Cv1q6wOQB43oFV4GauyhGPsPg7+LZhTNJZMwM7mnJNNjr9RAnTXgysGcbxZRCHqT1JMeIZacKo3JX9LaP1ptKTc1PAt6BBrO9k/FFLY0TKN/5kVx7lcJfFufZgC7Tdyv5Min3SSBjOq+J8GFi+L8NTDv/l+z17It7z+9FU5P3pnWIXBcZG0CmBC5WoECe0ZGHi3M5fkJtZKAFHp2Z5nJ8/GFnywdjfdOKbVTeC8itu1KGOdOVW2Ft4a5fs8lZgCCFrCbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avlmWhKIezDcCWwCcmqWQNYS8JoOGhRfh4OVU897Ghs=;
 b=i+W7Ttze6wKMvBq+1U4NJ/Sx2KsOup/7Zxy8Ei4UPKwDgL3CqojLJ2zyJolTF5f20g2T8uLxR88LMGSL2fUzKwPN95hBtsVTIanp/tGhe++CW//ZFTATH9zkx+sQ2is6PaVE8tYPCufKpXq20VOA2uEb62lGiOFlkz8lAdC9p5k=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 06:51:42 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 06:51:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 4/5] drma/amdgpu: set fatal flag for RAS recovery
Thread-Topic: [PATCH 4/5] drma/amdgpu: set fatal flag for RAS recovery
Thread-Index: AQHas0hDs34BAX2EDUKpvYysDBfVf7G4wuRA
Date: Wed, 5 Jun 2024 06:51:42 +0000
Message-ID: <BN9PR12MB525779CC69209B300F05B914FCF92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
 <20240531104911.14748-4-tao.zhou1@amd.com>
In-Reply-To: <20240531104911.14748-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=caa05664-9801-4e86-bbab-620a227f5626;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T06:51:01Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7265:EE_
x-ms-office365-filtering-correlation-id: 9143ffb1-9b2f-4c4b-2566-08dc852bf52f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?jDZWEO4nJ2hPO5fIkAGqSoIyf6AY4FEvimx08j4kwDFSlnJQMK+6QuUQpnAk?=
 =?us-ascii?Q?XSjVU/ebnlE5lNx/4AKrKlg1EP+6D+mPcU6qmjDvNKit6tnG+bJKQEawMm7J?=
 =?us-ascii?Q?9+ihb5i3EVUhGg85Uf0TgHyJLXF+8liK0e1wop68G96vs89pewTndEVWWZ3g?=
 =?us-ascii?Q?h39iZHrIXKHfg4usHOYLQMZdFRfFlgnpT7s/SdEQsoHOMnEmZwv//kPI+vW5?=
 =?us-ascii?Q?v3m3+X1cKFL07E3jPt95GrRuqKeyaLSdEQmlH+UzU/QwvEx+IgpL8YWKtPU3?=
 =?us-ascii?Q?od8p9wq+SZeYVrhLoY5CQ5Y6O4HFrM4NgUkt4LCIbARTalp98ug2Dr+PUj6y?=
 =?us-ascii?Q?0uNjY8REkCjWNU1E6ozQTEe3lKoffkAMDQsj22bp1ekyCwR6IamQfu0oCbtm?=
 =?us-ascii?Q?YTYawh425JNNNV+5TagER/6nhh/WOGRhPwLsgGeukR2CxbiMOwA7sAn29O+z?=
 =?us-ascii?Q?R/Tz9EXJeTp3s0qJ6DervPViaSn7yqAGsJhyz4trac6e507IrMqdYGDzbLuG?=
 =?us-ascii?Q?EyITzLavO5pEJbVUGY0XdYBwK0sIyOKdHVMp7hlg4wKbps17C/tKunfUPMHq?=
 =?us-ascii?Q?NIOpxP/Y14wwlrgXw6PoBFrRboVBn24dXvIWR7hpphXwThoAh3n3hhMBzNJo?=
 =?us-ascii?Q?Vsav958BPra1icXWpnIVr3Ltp0KiTtFDUcKQzsyHlnYS5eKUGXpO+hJ5Kmqp?=
 =?us-ascii?Q?q5lVYSXemSjxrkTN7zMlcs1Yk6Z3JABQnss5X/bEiY4Bp7vu+geyuqeICtEL?=
 =?us-ascii?Q?7adYND/+SSdz3wf4gYJAoh7HDViww3TGXp0FDXwxTW+hrWcOsvwY+YZcUr5o?=
 =?us-ascii?Q?GIPnYP5ypnm2QugtvX3x4BIpAGqi9YOnZ08fvNgcVCR1ypBC5Sp03f4+rXZH?=
 =?us-ascii?Q?C4r3RCZfqw68ZLYf1MoBG2ZV/GzHT1aqdVCeP1aBWKDBH3Tq4GvXQdVxh2XO?=
 =?us-ascii?Q?y1tULWhf5TytzctLz51VFakaqGB8BTiAPob6StrRt3yP5l1tnXCXrpmUJ7X8?=
 =?us-ascii?Q?JNV19oj/GwKoYfCbGZ0Ti/Rnj0ZMFTPETYxzG/sV09dqTybOMJ2MsM1TfnPz?=
 =?us-ascii?Q?At2pdWRe3kiPFJw5CXhpO8KRJEMw6eASfGKXcuHkRJ51cefaF993PHx7W7o8?=
 =?us-ascii?Q?tqxsRCNANXus79XWkxcAvE1fwvypHH0OXjiW2d5xbokuvn4W85szcq7FExsK?=
 =?us-ascii?Q?3peJRPa8kPq7bjM9Eu9t30SfD+0+h2ojxweSf74iJBSWMNSEoRFioHNS8zxA?=
 =?us-ascii?Q?lTIaBmQWt3n29cav/uvv1hGLpk/2rjZPPZAqB6GHsjlRnAiFcfsNo66HcvAg?=
 =?us-ascii?Q?uJ7q18xW/MGFk0xbnMVEIO3EaW/IPnuKq0U7tLXS00aQSgS4dnN+8v5ACKZz?=
 =?us-ascii?Q?Xi2wcDs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vdRdI9edX5P4/5tkBeVUMAdd/G2/7ixh0NA9Sq8jYYV3lO42YUFhuai6cuUZ?=
 =?us-ascii?Q?hzkcejnzoEhFyO0EPe8BbnfApt+GbQK5Z6ch805+QDjAW7paCkfi8Nx4mHgX?=
 =?us-ascii?Q?Nb2imC0PgGJJNSjsCjEVTZlpjhJja4BKRSOlrbiBVEYnKxCJ7I+RolYSZxde?=
 =?us-ascii?Q?f/usd6Ia4lI9FXL/5kTiaOnoZ5OAlzTbCrQ/R7yKzQ1kjHbbGDbymcbgp5Wq?=
 =?us-ascii?Q?fwu7esilP8bh6e7Uk+mf9OUjBeof4iY/4sdd03RLBFT+rDK2irSEiXCHNclR?=
 =?us-ascii?Q?Hv1FwtK2YE/SCTpek6Ugb/QPuoM1FbztutIZ8mfJaPAZYBVyvRWGPRaMZKd2?=
 =?us-ascii?Q?Tb3sHI9721+yGQs4FIJLDZJaw0rNxlnIQ8drxIUdmXn1ULRj4GeXGSEoBqo7?=
 =?us-ascii?Q?2wYpee70xruPholKUeB2JJVLhwvE8DoUykfWJ4F2qp5qwBV+tAoI4J3aUmPZ?=
 =?us-ascii?Q?R5wmViFtw+o+acL0TS0zauVsk5HAHfrIAoI2znzGeK/NJ7b/Ffsx/RIbAJaD?=
 =?us-ascii?Q?PMJAeij4H5tmzKmd5038USfaV3ITB+bamIfhZmzPBHIVwGLXWPjKzRpEPbc/?=
 =?us-ascii?Q?c7U5Sf02/AntcTbASF4RM8HtH3wX19LgMCcUcZ7/sqyvSaqGV7UUpUnTN7P9?=
 =?us-ascii?Q?CNTfMj8TMK3L231yqGQPN/THA1gIvc3K6nBGcxsBAbRinnWrzie6PiGoyP5Y?=
 =?us-ascii?Q?WHByY2Nw0uh3q57wrHaeGqwxJ2AJ+deBDSgt1A65r1JwwMATyV2WoO6I5DuH?=
 =?us-ascii?Q?jIlD51fKM3MSXubKoEd6u0HYAnqnc0QiYW8QyBTYqgQfbrb+oJBgf1bfCiN3?=
 =?us-ascii?Q?lQ4Ps0bxbTotxXhHK/QxsXHmTWW2YDyPXtCzzdtS4Fa6TykQrqYnvDPQKFXa?=
 =?us-ascii?Q?w/a+bDqUzjDlUhFaaXa0hVjZE46aOkACUKQ3bqbVykq9pX/8hn87nVjmTHer?=
 =?us-ascii?Q?43dJIbfagyM7QdQO6ApPnYJnJtnE1TYdAfBDaejEsWp4KLaSegyEN5IiZfnK?=
 =?us-ascii?Q?7jMhWssofB1+ewZI/NoaEGPqshIlHAEZxXW9wYTHFIEpEPG+YlC0Gwe+oceJ?=
 =?us-ascii?Q?7Oo/VHgWOXH9rLt6+yHYxZMP94uRuGLcoaIyNUFAaXWhAoESm/zeLY9yvCfp?=
 =?us-ascii?Q?1VCHp/C63lqidIgDWpNJ18tYvaI7DzXUmJevMOClzAMxkEF39XLFebhNu2Ge?=
 =?us-ascii?Q?onsjbd3lEyGDm/HmkUe1oL4EyyVSE84QKtSFao+QatOS1KwY++BuJVTxopa+?=
 =?us-ascii?Q?M/MM4tU6+4HLeC3WbUzROyKJQSvzvrgwVreBiYICX1aQ5n8iIseQH/nz3gap?=
 =?us-ascii?Q?wM062I7QzmGFcb3di3lNJu3V1i0JTqjQQsZ6KDkCw1Q+aLuNZMqat8d0YKbM?=
 =?us-ascii?Q?LBb+nJmyHhKcUuSKoc57K1VTHmX7coUTg44KTdk6FeP5jdc4Un9CPP76p5YB?=
 =?us-ascii?Q?h9g/TxLMDYbjne5nD7REek4qPsbBvueIZd6kRDiS2p5tYCsk+NLQmpHUAoe4?=
 =?us-ascii?Q?sa4SJr4KjiYfuqSzLtp9+6ZarRrWXTpyV2Hn9UpoIpKiBUXb2j1CpuKR54IA?=
 =?us-ascii?Q?iLjTVBptrL7oXaDLzG2g8gX2rtcGwqhGzzPOxIhl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9143ffb1-9b2f-4c4b-2566-08dc852bf52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 06:51:42.2964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKPQj8YOub1AmWntbJPKESHztkouJpSHYDCzM/BCryPyhEf/ONMqUiqwcFvNZMyX6KGrcg/H1djO4UWxlfCY3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265
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

Please correct the commit subject before pushing the change

drma->drm

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, May 31, 2024 18:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/5] drma/amdgpu: set fatal flag for RAS recovery

PMFW needs the flag to know the reason of mode1.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  2 +-  drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c  | 10 +++++-----  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  =
|  2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  2 +-  drivers/gpu/drm/=
amd/amdgpu/amdgpu_umc.c  |  6 +++---  drivers/gpu/drm/amd/amdgpu/gfx_v11_0_=
3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index fb5fc1fe6ad0..f55bff59052f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -940,7 +940,7 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device=
 *adev,
                if (adev->gfx.ras && adev->gfx.ras->ras_block.hw_ops &&
                    adev->gfx.ras->ras_block.hw_ops->query_ras_error_count)
                        adev->gfx.ras->ras_block.hw_ops->query_ras_error_co=
unt(adev, err_data);
-               amdgpu_ras_reset_gpu(adev);
+               amdgpu_ras_reset_gpu(adev, true);
        }
        return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ff2d34dc9718..2071e30d7e56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2070,7 +2070,7 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *
        if (poison_stat && !con->is_rma) {
                dev_info(adev->dev, "GPU reset for %s RAS poison consumptio=
n is issued!\n",
                                block_obj->ras_comm.name);
-               amdgpu_ras_reset_gpu(adev);
+               amdgpu_ras_reset_gpu(adev, false);
        }

        if (!poison_stat)
@@ -2825,7 +2825,7 @@ static void amdgpu_ras_do_page_retirement(struct work=
_struct *work)
        amdgpu_ras_error_data_fini(&err_data);

        if (err_cnt && con->is_rma)
-               amdgpu_ras_reset_gpu(adev);
+               amdgpu_ras_reset_gpu(adev, false);

        mutex_lock(&con->umc_ecc_log.lock);
        if (radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
@@ -2888,7 +2888,7 @@ static int amdgpu_ras_poison_consumption_handler(stru=
ct amdgpu_device *adev,
                flush_delayed_work(&con->page_retirement_dwork);

                con->gpu_reset_flags |=3D reset;
-               amdgpu_ras_reset_gpu(adev);
+               amdgpu_ras_reset_gpu(adev, false);
        }

        return 0;
@@ -3815,7 +3815,7 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *=
adev)

                amdgpu_ras_set_fed(adev, true);
                ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-               amdgpu_ras_reset_gpu(adev);
+               amdgpu_ras_reset_gpu(adev, true);
        }
 }

@@ -3996,7 +3996,7 @@ int amdgpu_ras_is_supported(struct amdgpu_device *ade=
v,
        return ret;
 }

-int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev, bool fatal)
 {
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 37e1c93c243d..ed5793458a70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -878,7 +878,7 @@ bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_=
device *adev);

 int amdgpu_ras_is_supported(struct amdgpu_device *adev, unsigned int block=
);

-int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev, bool fatal);

 struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 151f83ea803b..f976b6deb42d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -129,7 +129,7 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_devic=
e *adev,
        if (amdgpu_sriov_vf(adev))
                return AMDGPU_RAS_SUCCESS;

-       amdgpu_ras_reset_gpu(adev);
+       amdgpu_ras_reset_gpu(adev, true);

        return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 4a72ff8d8d80..2596a1c2a64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -198,7 +198,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,
        if ((err_data->ue_count || err_data->de_count) &&
            (reset || (con && con->is_rma))) {
                con->gpu_reset_flags |=3D reset;
-               amdgpu_ras_reset_gpu(adev);
+               amdgpu_ras_reset_gpu(adev, false);
        }

        return AMDGPU_RAS_SUCCESS;
@@ -247,7 +247,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_d=
evice *adev,

        if (reset || (err_data.err_addr_cnt && con && con->is_rma)) {
                con->gpu_reset_flags |=3D reset;
-               amdgpu_ras_reset_gpu(adev);
+               amdgpu_ras_reset_gpu(adev, false);
        }

        return 0;
@@ -266,7 +266,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_devic=
e *adev,
                         * let MCA notifier do page retirement.
                         */
                        kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-                       amdgpu_ras_reset_gpu(adev);
+                       amdgpu_ras_reset_gpu(adev, false);
                }
                return ret;
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0_3.c
index 9cd221ed240c..07c24704c4b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -98,7 +98,7 @@ static int gfx_v11_0_3_poison_consumption_handler(struct =
amdgpu_device *adev,
                }

                if (con && !con->is_rma)
-                       amdgpu_ras_reset_gpu(adev);
+                       amdgpu_ras_reset_gpu(adev, false);
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index b8fc9e126e0d..0935ed57a906 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -414,7 +414,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bif=
ring(struct amdgpu_device
                /* ras_controller_int is dedicated for nbif ras error,
                 * not the global interrupt for sync flood
                 */
-               amdgpu_ras_reset_gpu(adev);
+               amdgpu_ras_reset_gpu(adev, true);
        }

        amdgpu_ras_error_data_fini(&err_data);
--
2.34.1

