Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7AFC7EE2E
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jun 2023 11:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747F810E186;
	Sat, 10 Jun 2023 11:45:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B4210E188
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jun 2023 11:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmlwFHo6fAVmgboxisgp1LuKK69RqsMXweWG+klB7qFq67RLGYw6EU0Wt49VQd6gD3BZb34PTbEZZMK4VuCpSh7khgHYUObDfh9r67brH4k4WJKzGWXBv3pnF9Y9zGy1q/D6q2JKyjMFjnFIdyqXpsg6ccY5VBt3qYpIKu7LvEeVl5NjgLH4TC+yUwI+u+5fKNsnPX385g5ZD4PIbIkrlvxoH/zp+AS57cY0UQPOEIhCeGcottWviKOTTdq4AU3QmKV+X1ptQ01r/s41mhCSfHfRTGQRcT4O1NVlcaCdawyAMoNCK0ILYm89TlPjujyQrHJ0RHN/JsKQYSoiqH+0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgocW89+a0l6Q0UtpQkoflJ0BFHThdKKJibDtBLya+0=;
 b=QhKQz7X/9V/QT4FfDS+v+VqEibKfrTis8Hdv+mpT0vAS3mChh3DRRO3u3cehh7vITjhMp8VrAYMEp41SYw5kq9nH72CHCh4hIPL0pj6RnsUQzdQRANGTOZPyH5KqOYx5y2IFy0gGEJ+nVoKswAjHWuLO/rwZHRTvwW1E0h8ku8VFa6mPL2M7svyS9vkMiV43N9jV6ED8AP4iuIyF941LyaC7NaS+48+ddkbXctN0EOTb0jOh3Ojc8T0P5FWGsdN418w6LdDHQ2WNf8V0dZKCeDd1Xk4jYehhEqqRj0av6h0vQx+2IYfh7EtDixekWDpBhJA83P1Ri4GDhsiBhWSFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgocW89+a0l6Q0UtpQkoflJ0BFHThdKKJibDtBLya+0=;
 b=hkZl/eFdpUNM1t6IhX6UijlpP6jb7avYCq/Q/UAVlt+dzFmKzf1ivqKoO1ymBiEwU3GEB2c3Gnn5cp0e6JWyiNtRUw29oCqFSVvrP14KS/Ks6ZtNv9DXr8A7NvAWGEAAHO57hvKt5yzsFYxwjzRgmXmJjkt/fUHzulhbp9JYVdQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sat, 10 Jun
 2023 11:45:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%4]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 11:45:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, AMD Graphics
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix usage of UMC fill record in RAS
Thread-Topic: [PATCH] drm/amdgpu: Fix usage of UMC fill record in RAS
Thread-Index: AQHZm4+8WFy/KE4d2UOiw++TYQ5Siq+D6uOw
Date: Sat, 10 Jun 2023 11:45:33 +0000
Message-ID: <BN9PR12MB52572484E8F1768FDF19A1C0FC56A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230610113536.10621-1-luben.tuikov@amd.com>
In-Reply-To: <20230610113536.10621-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=619a3acc-1a9e-4bbf-9cb4-45724b4433e1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-10T11:45:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8547:EE_
x-ms-office365-filtering-correlation-id: 1b116426-bccf-4886-ff5c-08db69a832e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDC6XavPo5gB8/eah1INnHWZ1eTIBkPhe12yoh6+nDsjkX6e5atD0emdpS46k4s3+hiZHIPo5bsSk1HjSuJL3tnMEkh5dro0JpJZSz5Z09GWMXuk9SykA8KigTQtw0RrvNSk1zo4VC2mAOLNrMT60nzl00n8a38Mn59aKGhSyL00WfKUgL8ecf3BsRAvqP5bdWlecfbN7TgmZSGb1WqJPkF4dD/jz25FzqlO8VvQyRBSLoE0VdR2BPLoda3rYpr9gFD3D4BNVwu6Pwv04Dbx8EqjbQs2WIfVXkCF1I8lRLAzavAbsOLLP0ITuzhKvrJWt8At3pkxOs/XMMgwYQLXr7+8X1DaeCOk6gi4VPoQp+EMrN3LiBH0CrlWBrC0QgF9W4YriVOVGWYotTVyloGN4NHtbK6XM7cZa4ZPcDOMRwdC2UG8MDL2iXkaYVgGTjOMtDy1ns9K/egcekc2Lmv0JJISvz1iMBnhi8HMb5mHteEr98WK9WnG3xfKCK0H4YY4M4QiehBw40af/wTqQX5Kdub9Nlc2vz5rB+vuYJWe7wwRu/Gxgs2Ll7CW5i0xj+/QYILuJ7J2GKXFe2GifZJ/6uZbs5TWAm20b8BHTDQflF3F8sotxL7TC92fIeCfMOP8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(9686003)(53546011)(6506007)(38100700002)(41300700001)(7696005)(83380400001)(186003)(71200400001)(478600001)(54906003)(110136005)(122000001)(64756008)(66446008)(4326008)(316002)(55016003)(66946007)(76116006)(8676002)(66556008)(66476007)(52536014)(8936002)(5660300002)(2906002)(38070700005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zw+vqk3TKm8Gky2RldPhqq6YWtLx90fx25nGKJoU/ClN+Ps/Snm2AnUav9hP?=
 =?us-ascii?Q?5Q/gY/cCqCe3Pcz1FnFQ67BS5Ynf5IFAeM43R0HuMVI4ruYlNW4i6i4o/+Nf?=
 =?us-ascii?Q?oQRhKD7wZ3Smf71oZqbvmklgHS5nUU6MLREr8ethHJpT6BQP+1wq5QO2RVF7?=
 =?us-ascii?Q?lihpKPjFYkoPbFcxd9Bp3kHWJWNt4sgqujvT2mvI7SqsFf1yV57F48+dM+xB?=
 =?us-ascii?Q?8vQ4mifC1aXQvZ5k8RvnNBr3hHlbioNdshWs05SnN5au4Gme0QA+ZgF9VbZa?=
 =?us-ascii?Q?sluHOx1vKzglNILCwRXrHEdCojwySk84H4iuEkCjD6I0ATlhlyM2zIE7E6Up?=
 =?us-ascii?Q?JCjfFA2gKyL3yUjYAMFgrtbvbivavjiI6EaA8VN6UlPaWLJaPsAL7AhjknQU?=
 =?us-ascii?Q?1ySc084B/17W3vtB+gxniC542HQrKTCNvYPov9nGQC8ZFeoFidbreOGP7sHW?=
 =?us-ascii?Q?aYk1MnVZx0Dd8qcVXeKwpfaCheakGH0auoPMy43hXXWGKesq0EbFqvO+Z/fl?=
 =?us-ascii?Q?Yarobu+S2/n4rvevFy7ghXnHloG6kksx2daHj4IeL5T0AR1jVzOK9xkEAmBO?=
 =?us-ascii?Q?Fk/Gux9LlPREHLJkZ0FaB4LEE2VixWKzHVEdneyk6xheLU3Vrs+HqVDbydOZ?=
 =?us-ascii?Q?dvNgzE1LL7R4I/fiFUNA4u1HVHAC48K2wATa/RaLMZAnJBOTdnrI6I2irc+J?=
 =?us-ascii?Q?G91qpa2pAbUv6b9ZhIVLWdf9c3+SC3hJZoMZEiqLlzr071lvMl+LgCeh0usz?=
 =?us-ascii?Q?/6zZu8LqWcM3xVbWoq4wpfBmA1biwzL2jy72/+cpbOT15eT8dzyFlXOhhtkZ?=
 =?us-ascii?Q?N+f8QIxc8nzVu2/us2sLYICGPlXwZY6R6kYyz/T/EwLQAApzjlWGSh4yIebx?=
 =?us-ascii?Q?duBLiv9p4OtiK5XKK7fQbyWYSQG8fr/PgBCuLg9ytUGDbMY0g1vhdemvmotI?=
 =?us-ascii?Q?m70l+mR0NK/vnFR6r4ZRDLqsx2pBEa1nritgVG3lSJvmACpZkPQU3eKwCTLD?=
 =?us-ascii?Q?vLZjm/7WmOe30ZfJkiO/wOVixI4Y6ylnurnIdN6ovJvKNjcQMLguEZDQXkRO?=
 =?us-ascii?Q?gpL8Ygo2nUnTxxYO7pOQHVfyGLgHqZKc41yPvCNTfJqEcsavYglHJE008ZBh?=
 =?us-ascii?Q?qP6Jue3d0vkGCGql9vpzkJia3w8mJ8B5Aa0PVdXGzpjYQEzMiC3vLOJuc4+x?=
 =?us-ascii?Q?fX0joTF9lzrofkfn8IHkVjxIlrqhWzrKEuKODBJMxIICTPuVW/KtYSv/DGMs?=
 =?us-ascii?Q?Z8nVzVeXaD3YccL0656LrpAXa2GGAT1iJi/CKh8Oi5TEyuWNFp3zR5vcAxRr?=
 =?us-ascii?Q?7ZSfDPw/yWBe98hEndoq3oLSpgh5c/MrXxPMG2cXHQomsYsJF7DJOas7JW9i?=
 =?us-ascii?Q?u8MpNBQIITSi56Wh4wp0uKbiK54eblWMF5iIDxF8DOuf+XscD9kXLT7eBsjT?=
 =?us-ascii?Q?Rwhi7pmAourUe3wGUgb8vCgIZABEATK8OebaUyJNKSy9fHLCc3RG40eyCvAd?=
 =?us-ascii?Q?ljyPsfvWpZi842+M7+yDbqvjpoJBqXKG6qwLCsblw+OLfWuwweK2BKNeWQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b116426-bccf-4886-ff5c-08db69a832e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2023 11:45:33.1723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuvwF8BngqYX+6GTOA6o1ZNl1ZaxWLxWqvDIcbtNQwnPH6YqHiEfTqGnQg2a+JVD64JyNn+MS8HEUbFnSZqihA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Saturday, June 10, 2023 19:36
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deuche=
r@amd.com>
Subject: [PATCH] drm/amdgpu: Fix usage of UMC fill record in RAS

The fixed commit listed in the Fixes tag below, introduced a bug in amdgpu_=
ras.c::amdgpu_reserve_page_direct(), in that when introducing the new
amdgpu_umc_fill_error_record() and internally in that new function the phys=
ical address (argument "uint64_t retired_page"--wrong name) is right-shifte=
d by AMDGPU_GPU_PAGE_SHIFT. Thus, in amdgpu_reserve_page_direct() when we p=
ass "address" to that new function, we should NOT right-shift it, since thi=
s results, erroneously, in the page address to be 0 for first
2^(2*AMDGPU_GPU_PAGE_SHIFT) memory addresses.

This commit fixes this bug.

Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 400013b268cb66 ("drm/amdgpu: add umc_fill_error_record to make code =
more simple")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 27a32933cbee3b..700eb180ea60fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -171,8 +171,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_dev=
ice *adev, uint64_t addre

        memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
        err_data.err_addr =3D &err_rec;
-       amdgpu_umc_fill_error_record(&err_data, address,
-                       (address >> AMDGPU_GPU_PAGE_SHIFT), 0, 0);
+       amdgpu_umc_fill_error_record(&err_data, address, address, 0, 0);

        if (amdgpu_bad_page_threshold !=3D 0) {
                amdgpu_ras_add_bad_pages(adev, err_data.err_addr,

base-commit: 7eda4451177abbc8d2fab24f816a3243dd1808d8
prerequisite-patch-id: f2a3eadc5d7074225109701f1bb43b38bd6024fd
--
2.41.0

