Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533BECDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 02:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FF610E07F;
	Thu, 19 Oct 2023 02:37:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF6210E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 02:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brq4BrG4g+VpYViVak1HDEm6FpRQeBgIXqyxkyqWRXzJxvFrh8NBn1gspiQcME/5K3Up0Ti7oN9KmyDZjrxzkG6QM7UmkmCe8Of4vPTkMoVYUyi1sln4UaF08fsi8SmnRhtJxR/wpWngLQusvDwG60CeZ/dWJcpIUZ7WWp39rRm+EU7jtkXcUGdiQCjvypumuI5JoJwyOQ1SUCCQAzcRcDvx3UqQnRamFlowbHu7yHx04E3d22aq+ILeZ9g05/xfGUMjtlfAqC6NqwMgKb16JmjC4dtw9UTVGY+06k5LbIgqHgeDPE/QEtr6pxF+bRBJioUQaHqeMN8ULzHEkAHSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+3hQKhSNqeY+qE7Q6eTWOTJekEQgS96I48/Ky+H4Q8=;
 b=UYe5jPJhdod/+XYBrCphsjbe/PvzBg4+2m5N321QH+Luqp6gvXccLnhFCMMx0BzMOnc4Uf1XhLVfOlOymTKETS1jr75i5UV4KXd8hkxuidHPScuua3y8A+ZvykzJjzjA95IE2Ajjj5yCZY8a7dTqpD3RfCT9/ecg7INo3qz6ulkYF/x8oQw+ygLhxBHQnaCQQhFHbPY1n6exW6cLyK/mx5WJEdlNufDSUAnQKeCeIdWAYsAt9byYdoo1msTOnoR6xhyhJ+S+Lcr46YRiajXg+J+GJg1ThgXNho82LWkjeP7ZfNXjOv6Sb2ys1uS2KXyxGDKo5eIsLappj0ToyWpH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+3hQKhSNqeY+qE7Q6eTWOTJekEQgS96I48/Ky+H4Q8=;
 b=JvJotx6U2Ry2/ko7BaPXw8Uvv8gPTP6fdqjY+iuGLX2K8TTYGeJWVA7uxQmtKssjUX6r9m7iZ4M+p58F4tNO9LFSFHBLSBKE0kDlLDQZWhROnG6a/+ynlF3p9zctAY45VgUISnYyzcCz/bWTNagGrE7P+h7yeN/H1K+fKfKXTEs=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Thu, 19 Oct 2023 02:37:23 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::ab3f:4dad:c638:6b53]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::ab3f:4dad:c638:6b53%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 02:37:23 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix the return value in default case
Thread-Topic: [PATCH] drm/amd/pm: Fix the return value in default case
Thread-Index: AQHaAjQlKSzqYVZWZUiSM3PEPgTN3rBQZcXg
Date: Thu, 19 Oct 2023 02:37:22 +0000
Message-ID: <DM4PR12MB5165A99D912D73A9156BA82F8ED4A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231019022925.212867-1-Jun.Ma2@amd.com>
In-Reply-To: <20231019022925.212867-1-Jun.Ma2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a71e3043-b2d9-4c03-beb4-b6864af3b61e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T02:36:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CY8PR12MB8215:EE_
x-ms-office365-filtering-correlation-id: c068b9a7-4473-4142-b41e-08dbd04c52d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYNrclw31GHiYFzshzS5cw68P0mLtIfJ1sB7t7zrBjCLbt474l+lv5ODGyaNknYWbYbe7xblLiqwvbfJMUw+68Us9c9nXnuJf9rAgaJ32Lkq6s1DUUst39kTV9xLY9DYJqED7PelDRBv+i23s4GzM6D45t7GLp6lzMDU2qSJCHDgC/LFoFn7QzJ/hjmGsZsFtPlcHTd3by2i0/cPgFpBQJ2yWcF9/38CZyrihndYB3YkGtfj+umNCTBWQCWHGYHwEDzi2LjcSGtV7ZxTJAKQGLRelkvj+IRvsm/mHnJcsA3Z+Xl3e+wudSDc4tXm59bdsQCJg89v2fhqA//MHhaIMHPmHSedaPcke5VwR6fptjT2zfFZxbnImxgeJdOJmUReJmzRM1Wf9Qmm/9t39m5/5XhAjc40mIKwQyl6/PEIJ6v7qEjYGA/RRz/fdfKcoUfU8t14XC/ujWeEQcujbvsyfS1qrQD0+ZPQfjgJkBJzxRYuw7px0FHEQ4OLm6JXHRZafIuHqJr43M/sWpPcnnrxEnG5NFfBrK8a5RQTeMZEQ8I89K6Ocz95hraDeZEHOfn7eTlo+anAFxdbLVC3PtwAJcXP9vS3hDS3hR1kaMoSSq/wINYJEblXP9ZhNsVUvQg/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33656002)(55016003)(110136005)(66446008)(316002)(66946007)(6636002)(64756008)(76116006)(66476007)(66556008)(86362001)(38100700002)(38070700005)(122000001)(53546011)(83380400001)(26005)(9686003)(71200400001)(6506007)(7696005)(8936002)(2906002)(478600001)(41300700001)(5660300002)(8676002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fSKzBH+C3oyTpkOrLBCL+1oAruygPRBbrGgdtqDb81/ur5kC1BUJoyrfv+dy?=
 =?us-ascii?Q?ofyJlLTgQ8gvbwZTTGrMZTiafX7nri8TyDe6qobGwDrLdiGtoik39B3J56NP?=
 =?us-ascii?Q?SlTAGJf09QyznUe1pcV5vjNEaJLTjPOUMxcZ40JL6z3cIKhVnpjUfxGu/QlG?=
 =?us-ascii?Q?mgEfRJhBDqSzJY3U7N/qq9Bu8qwtuarZ13LjvWqjTbskTPh/m3LlBM0LRjVo?=
 =?us-ascii?Q?rzecTxzboHsKjvwqiDKxH0SQNCHa5pEATJ6bbxQjxBRKKvqWKwxB+X6L64x/?=
 =?us-ascii?Q?9y/BS7WYB8Tv6xr8aZ2Hy/mNdAYWaCcRi1DP5hfQUDh0FQQ+Mj7RAdFQspDp?=
 =?us-ascii?Q?PIkSjbSbFPd5d7DIMKT4Uv4+sbEaAjpKHB44YQVxkOGP0MyZMzQ/2VuFiy51?=
 =?us-ascii?Q?uw7i+3LBZa0UaCH6uF+f0lMveEy3I3A+pb+fUAmcfoDhHLXNipfGDpPdebls?=
 =?us-ascii?Q?x9i5/sLcARursILNOX4vQR3qBTg3RQ1+2cxfc7jK+JSGTVGFr/Yl0IaYD+vl?=
 =?us-ascii?Q?IVZCHq6eR8rMVun+HkyRRN0Znggr0ZhgyAfqAdvE9Sx9IgbED2DHA1ccudVt?=
 =?us-ascii?Q?Rw74vIC/RD/89OCc3QRQk4TC7TxBhT9JU8+rdoZ0TpAXcw8zYa/TvvoUoE7c?=
 =?us-ascii?Q?LyAbejo8lrIP9jgr8APkJsuhjNm1CmfavauDR47eNpQo3Nfj2y6pttV7NHlj?=
 =?us-ascii?Q?dhTpfqVb2isTcHuPxIPJs4dfNN69v/GdBrYWC0WgOO1sxxL1WK58HzOhIwqE?=
 =?us-ascii?Q?Aj1p61OXZJo+58ztfxgIA6z/L8guotdxtaKU6LfuWR7D9aHJE6U9Q5dazRuA?=
 =?us-ascii?Q?7YvGSbHr8D/Prf7wxYZnUtD6yCaxpagpL7DYRN6b/sSY0/ZgXa+usgSSITTq?=
 =?us-ascii?Q?DzSC5v4HZn8EAnrhLIOsxjE0NyicUTDrdU3GebAV964mUzrmBc3htqkDPGlL?=
 =?us-ascii?Q?r6l/L50vV4dpBBMPet20ZdPMED3Vv2u1srszYG/MIT0942c8MEa/4pTvbDG7?=
 =?us-ascii?Q?aSb4XedDCPdVAcTC3AAE+WAS9UnZyK87D4TpoWg8y2NtALY2s2GL8/01HuPK?=
 =?us-ascii?Q?xU7mZORlsV11XNHH5DqgtxDc/XmFuvFPtoaKEnDKfzfF3flmtiZKE+69eFjp?=
 =?us-ascii?Q?Yia/t5rDqieBCZ/3lqJ+MOBRFWhkoARLO+5wXVxMmZmiJSXtkMQe8QW2U51P?=
 =?us-ascii?Q?GPINOoqPFcBiL2ti0XtNwFDusVZzvy8omdACScaldQHA2uBnlHp6gHDbRNh7?=
 =?us-ascii?Q?nl2DUwkJNXQOEMyCg6ptWbhVToj8Xry0DzgTPdsyplsbTFgmusEkpT4/d/uz?=
 =?us-ascii?Q?/fgTiltBwTEbbcmFrY7H1XyStpOEh+moPTme1UK3LS7iPcvn0gccICDB3uxy?=
 =?us-ascii?Q?KWlSM7fN0uby/QHyVdn6fyiwz93DonVe/60i2ax+lYXln5AAykBt4xR6X/j3?=
 =?us-ascii?Q?MggDnNZQ+to4HUhG847RwTY+i8h29tOycJvAh13sd7kIr6nAhd4wO88NLLMV?=
 =?us-ascii?Q?AytQ1ONs++wmvFY5uPGo6n1loag1b3aXc50LvEnQ9DKedtOdWEEyI7pafeQV?=
 =?us-ascii?Q?De82oW188Donpfyo6Rs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c068b9a7-4473-4142-b41e-08dbd04c52d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 02:37:22.8594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nmu+MvLblNzPsvLMQ9WjvvO+Jncj1OY1KQukeK+pU55L/X39Te5kVbLXYC8u+cPT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Thursday, October 19, 2023 10:29 AM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm: Fix the return value in default case

Fix the return value in default case and drop redundant 'break'.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 7087f9840ab7..3b4053e2607b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2434,7 +2434,6 @@ int smu_get_power_limit(void *handle,
                break;
        default:
                return -EOPNOTSUPP;
-               break;
        }

        switch (pp_limit_level) {
@@ -2452,7 +2451,6 @@ int smu_get_power_limit(void *handle,
                break;
        default:
                return -EOPNOTSUPP;
-               break;
        }

        if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT) { @@ -2486,7 +2484,7 @@ =
int smu_get_power_limit(void *handle,
                        *limit =3D smu->min_power_limit;
                        break;
                default:
-                       break;
+                       return -EINVAL;
                }
        }

--
2.34.1

