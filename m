Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3EBC00140
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 08:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F4BC1592;
	Thu, 18 Aug 2022 08:06:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9953EB6983
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 08:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl+WQlOYxtdRk2uuSfYQeKr4XA6PL2wYzdpXG+E/WDmm9l0WB9qUg6fUMv8zV9E08WHUz2jyqi13kVfEB3SG3OpYckR6vM7NcmqNGB7ITTz0QCWPSObc/N2c9XfuxTwpJDf9zkDI/ln2+36Rshulw/c3PcveaQDNJ05LF/vs1lMVvspNZLXVXDbKgIphb6sjLaTLwojNafURoDlJXGaNXbTZWwkWdFhuloTp2PTNrFzD89r5tbUSoFdTTXiguiPkvyzWbQtTBW4Cg7+W0V4XVzbwAujhpaLjvu70uo8tQ3yp09o/mR+g2dXJK325469PAKUTrp0jQNmomuqPfo/9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzuauV3WEne/UafMcGQDSjKCUbXtynJvir5Rvpprsug=;
 b=O1aLE2I/6xqmEPvRAuhtcRNLvUsH0+SIsWtZ3pZPx6epIWPlbPb68r957SMX5eABMzEs+YGtEX2IkRoajmwf+4x/wjcT6EjspZghJ3LXwc6sQV6fHuRU/8mik6ElZtxQy9jSiIlqUThRKyNmVmA2pYblLn8Efj2j0vSkEh7n/2hwjLgAO2WacW5j12BV9hqsYkbPyUO5cMzn+BpeV5aMY2z+49GPGjDLm0mZ7i9iREYdpQplq1pEmZ9alNduymSDIx6q3rPHPR+7tsGy+lqlSsU0j0oYGwhENTuehmuL2yWE7XfnZ5uH8ZaObjAnpMUI76yafIkve9vP/X3MCNb3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzuauV3WEne/UafMcGQDSjKCUbXtynJvir5Rvpprsug=;
 b=kG2Ik+S2ajrqI2szhqiTINyACRYGis04X6p1tnqALs0Wj5sKWd2zCOLl6moGwydwPK6i9XR8JUKAnHbxsb70kik8de1V4/iw0oYhw15dTN9FLCYH/uh/S+SOaVuXWAgejC/2fQHMQDWdNNjxzTutIIyY5uV457xPhElGXLYHGvo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4582.namprd12.prod.outlook.com (2603:10b6:208:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 08:05:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::b938:8710:3028:4e99]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::b938:8710:3028:4e99%4]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 08:05:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Check num_gfx_rings for gfx v9_0 rb setup.
Thread-Topic: [PATCH] drm/amdgpu: Check num_gfx_rings for gfx v9_0 rb setup.
Thread-Index: AQHYsrJmRSkNFwvqa0+ZZ49mQcGlta20TQLA
Date: Thu, 18 Aug 2022 08:05:54 +0000
Message-ID: <BN9PR12MB5257FADBD747368B1A3480B7FC6D9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220818032557.30044-1-candice.li@amd.com>
In-Reply-To: <20220818032557.30044-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb2ca282-c0d0-4b87-7e5f-08da80f07960
x-ms-traffictypediagnostic: MN2PR12MB4582:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GMKaFU1zbTcOQIyLc/WHOepNcoYBZMy9rS6h6zQzUvHFYhHJ0rFdAlDVnPVpGkodpaGDOKwXTOS8ncgsX4wNCr5z1K7m922WO/V4cZ7Y19e0WhANOiUAEjyNIoH14/5UVb8exQcGtVQx2GF1QvlI74oOCwQWf+Y703y10vTpInD49RCqNFPd+070Q3paOb4Ya1LNj/jM5gkOyuTDT7Mh6pbymJgXoH2sj6YcJees4qKJL4vWabIP9eTa/e5BxpMhuCO4Y0YqXC1eyR7gIq3h8W9HEW+L1GM5P3x0f4hDOYJ8G4GVgxeVRytyNOxfa7e2oNsbrhZA3mQjUyPffpaB3tT35hE7dUPfmdTe6ffBBJToKQ1cEcDBe7WXn9RIN3dGxIwR+O5G/xdIz/Vk6dDrCq1Elp4hubxo2a3tqyXkrFrqA6y8yaXSzOH7ci9alvm2fHyz/+bbNvt2CYigrV9HY4BviL/gGNpjalk22ar+6MKyTFMSVK3LKQtn8MDK4/28Go5sYNbBfc3NRt27pAR2q6YIxkgCzGCaHh9Wj72w9PXf6AjOxnxiQBMLQYLzG+VqldEwq6FkpFO98CXPuBva0A53RY/JEyyg0VNn/4Xh3a2fMAwo2lmRiJq9vZ83sD+ut8FXKRPshBexpY9a2jtUEH4PX8xo3dkI0m1LdBxx6yLpOFN5e0+gDelksME6KjBuTFUDz+1fisiEIEELjXyF+0jm/4gIXWfzyOWrOltNWE9hSKz0kDchIkntu1OFwdVX/V9nJlRsE4QXYLuKopu+oQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(4326008)(2906002)(508600001)(26005)(9686003)(86362001)(52536014)(7696005)(71200400001)(55016003)(6506007)(53546011)(110136005)(38070700005)(83380400001)(8936002)(76116006)(186003)(66556008)(66946007)(66476007)(8676002)(4744005)(64756008)(5660300002)(38100700002)(66446008)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mpfLUvVZaLwpoB20ucQVSl19iundpHoy6jdkWhXnfr/G8WkeY2ev/WH0kom9?=
 =?us-ascii?Q?bzxJ565rM+BkAZXbDE0eAKhm3rso4spQQmaO+BIr3Ls/xbJsy05VyPbH6yKK?=
 =?us-ascii?Q?HAUPGMme0cRIh6DjYb+TWXEYU63n4UYv0FeaqSCtCOUwwkOK/pIomy9bfDqs?=
 =?us-ascii?Q?OSdABflKG2dkiL1Wzrqk1HbcYyklXOf0MNYg1KT55qgoHFtrUXM/HJjzo/lx?=
 =?us-ascii?Q?Iuds6FGU9hlQg4WeAuu5PNtO6WWyBQrrR+LvM7GcZDHjut2oWlEAHRH+eiQT?=
 =?us-ascii?Q?Kox1kerExLHeNX/6GN63CuXj0CDs7d4Nh0xJHPF2n9Ejc/YdWlAJLN5Sag5x?=
 =?us-ascii?Q?gSN7hVYvgtpggc5eXfHOs7rymgtj/MptVLbnMRbKQkiapXoJASwbcNMVvp/U?=
 =?us-ascii?Q?cXA4g9HBe+vcqVhjkRqqTXWcJo2tpy6RjWk5faaW7/X9r8QaDPyDe/aECJSU?=
 =?us-ascii?Q?ecYmROU88bq8iAO2gs/k0TqZ7JRZmJLA2sN/jKu9tnuVx+VcAdkXUul5qhqA?=
 =?us-ascii?Q?NSDcecyOicxjOZmzFwdsmKLbRsQHtNe7pEXHnzldVQP8wvo5ywJnhtxZN3gY?=
 =?us-ascii?Q?/c4RRZRv3If4XihoaI1RbdPXQpT02+dow57QNyYpYy1TGBOesO8xqWQJMmTt?=
 =?us-ascii?Q?X3Ch/5JhxUiBH2GyFtw39kjZfrURyDguebHBpCEPnUhpA4kXXIVc+ebjhNqL?=
 =?us-ascii?Q?6w/bTn4fyRevewdMUL+R5xV0h1sw9wOgsSuz+lY9bQQn19iqWcDrPot2W/7V?=
 =?us-ascii?Q?WDteJto6kdgykC/izAvq1npTwM5Lh4wEpbOfzMqe3c4eqR1eBeFWKv3Eoe1W?=
 =?us-ascii?Q?rSAVigWZi4wC66jPqggFkW6KvaVO2wgt9DsoJgjdv0Zjj0DbcuAPY39jDMCe?=
 =?us-ascii?Q?TsKEP4UejrJs5RXpo0r9HVBMqUR3aEpmRlwK9lpdpWCrtVbE8sZjD+RWqloZ?=
 =?us-ascii?Q?d5VzmHkw0ovoikgjWBgekDV7JUP7W/6wwIOxWebLZ1ZxniMPjqWlIG9h3Jik?=
 =?us-ascii?Q?qu7mgoxycpsM9TCSlpkC3+fgB6Nq0SaDCpu0jpIDUG4bIVlqtZ3FDdDwqZY9?=
 =?us-ascii?Q?X6pG2hKuFGUTk6Ayp74BYrzVeeCJyM0U80BdWwQ8UyMyYIlWqDs0fflnS79R?=
 =?us-ascii?Q?HiPjwNMG7H7kvWDugiNllyj5pkEizBqOzobpsQeDkQNkMvcNoJtcnUK29tP1?=
 =?us-ascii?Q?ENG5I2eHKAaaZPej74VNRqYf1JOQD2a5Y/6zVB1M6vpKZkp5YqzTT2NuWcZi?=
 =?us-ascii?Q?DB4XLiplLKPjVzlrQfifA9QcioEKi0CX71W5yl8Sop1vkDhNyNLc1+YNBeMm?=
 =?us-ascii?Q?JYw8mjadA4LPVwR0OVzguUoMG6TbN7PqILS+Emlq1v5nrftE9pXCERwx1JgT?=
 =?us-ascii?Q?8EyJ4febCNhaQGufGHeKG+n84BtHpTZjJXPet4d6fupdD1XBk/72JNwVgQ9h?=
 =?us-ascii?Q?87gTFlmALI9l3qv4dFnGm63TQCs/+G9/j7ABRJr8M9D6NcI8SYgpkinhKuao?=
 =?us-ascii?Q?X/DcnTH72WHhAZp8tvUWPvcewRyPj1t5eMG+I+EaqcbX2gz/ce2hThQnFsSX?=
 =?us-ascii?Q?fMsUzCoFqHDAd3v1MeNymVNjKiziLId4kdWxjXm7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2ca282-c0d0-4b87-7e5f-08da80f07960
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 08:05:54.2750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fU46IqqilTJfJwmbyfYCABhqtjwYVw9LzieWB6ZYJ4GFkQFpC18FQA0dG+NrupVDUDXWR3ly2Uol1RPY/HAK3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4582
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Thursday, August 18, 2022 11:26
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Check num_gfx_rings for gfx v9_0 rb setup.

No need to set up rb when no gfx rings.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 7f187558220e9a..1d6d3a852a0b3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2597,7 +2597,8 @@ static void gfx_v9_0_constants_init(struct amdgpu_dev=
ice *adev)
=20
 	gfx_v9_0_tiling_mode_table_init(adev);
=20
-	gfx_v9_0_setup_rb(adev);
+	if (adev->gfx.num_gfx_rings)
+		gfx_v9_0_setup_rb(adev);
 	gfx_v9_0_get_cu_info(adev, &adev->gfx.cu_info);
 	adev->gfx.config.db_debug2 =3D RREG32_SOC15(GC, 0, mmDB_DEBUG2);
=20
--=20
2.17.1

