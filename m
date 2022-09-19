Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C680ECAAD8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 03:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E64510E517;
	Mon, 19 Sep 2022 03:17:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375A710E517
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 03:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq9VVpGA1eGR+8ls229lNiS2ol2R7pYXYeUt5ZPgNV6BNeCiYP0O4g++QJG582gGvb9O2yqyjdqsCvbs2PNa+lF3B/Torcqt2YbpIJ9LofLSn6mPPgxRazsfQqMUHzbHfbHwyIjPfwIOIlJJwzVhyyGZqW42gPLA0sQj1FKEZmzDJRe8F4SFQAHLCXYrKpHFajyfipREJaBQkD4zB9VjAH1lsKL3HeTvnaU+UJvvL6lpfsgXS5XXWguJVB75NNY0z2tp22XQFnoZlonjI5PsmHVntFMSB4TdPFImqExFuaJJOI6lUowgg+yXAxTtllh+9PUtoR3FPcfvX9GHbXmkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oYv7Vis/atABh1quTAHdbCRBq9Ewvx7SBLQTOi4zU8=;
 b=HTvLJaMBGOHxgFX7zFNf5PjlJFGSIxkjde1b3veCqqtSZKgzGcjGhrhnN7KKSfWCbyHlDQD/iwfWyRWcU5R4eYWPtfmPLLmt3U+IL1fQSh2v4pFECTJCAXBGke5nouKumzNMYKHoZsxqfRdH1FMFYixEaWpMyeNrErNlPFxZT/TmvoS0ictUVyx/1u1q2IdPMoc6ptbuePNPb6vSeCuXFeu17qEMa7HKU+Fj97MBOO7WolayiyRM99Jo1xDFZ8HqeFMu17TV0/BNrm3TovcqzBhaHdb4KtAV17KB0MaPRl3rWdRq4ITrK7OAI5+V9LCJ+ZrLuhlFwtdrt6P/kh42Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oYv7Vis/atABh1quTAHdbCRBq9Ewvx7SBLQTOi4zU8=;
 b=qdPq7Xi3rh6YbkXnMU1tYISluS0wRpMMlfB57tNui/Anu+0iVLSY1H26UIa3Ca5ECCkpzEwS1+/yU82q6gEJz5BpwIo3T+8R5Q+YRq7lbq+XDq3vzPS/Be9LKoCzSRQVx4q0Ulic0OLk84L40EVIgOhxZtnvxxyftgAYXnMnsiw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 03:17:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0%7]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 03:17:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/7] drm/amd/pm: add support for 3794 pptable for
 SMU13.0.0
Thread-Topic: [PATCH V2 1/7] drm/amd/pm: add support for 3794 pptable for
 SMU13.0.0
Thread-Index: AQHYy8wIj0P/mlFEfEeOVPyfBwStaK3mFP8A
Date: Mon, 19 Sep 2022 03:17:54 +0000
Message-ID: <DM5PR12MB2469F5B6814E82410443B9E2F14D9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220919020251.7048-1-evan.quan@amd.com>
In-Reply-To: <20220919020251.7048-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|BL1PR12MB5350:EE_
x-ms-office365-filtering-correlation-id: 871323e7-c91c-452e-2113-08da99ed8acc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cO6xvB4frSSjqmcHJULw0ABVfHGYtsxU89qEOUdcXIiGI2SnCrpAqMakbO+WaqGSgcFiGfM5Xg16pnm6bXFOsLThjhNpYIIOSnqDJg1TfV9Hb1Y78DxNpYQY3HxL1GzDGafwg8GczeadzbAoq5k5QQCt/1loHMU4BsvC3EaUUY8qY/TNKzcb8Pg45D+C2ffMFW9I/6JdDOilv6UV0uKCamXKJRhNAYWVX9wgJr+Ozt91ntpFK1nLpFwshIYcD3NWwjKbx5Mv0Yg9/575jdqdteMZUE50itG1xjH0d3SQxhI9H3x6kkgzABWhfiwbM7LEqLbsUQimGhWHztb+Ff9mAiy4Xo8bH4FEWjaEkdfHp+JnLkyDpAJ0Dpo0vYPS1Vtvo4y5DhGhm21OfY6c2ZnKWan6dvtSatUrw7cKt4SMtQEmciUZ1SU0GVWb64Uc8HLzE4TJ1Vlh/fZcbkGZziShvqkhghG+AomLFkJkSs+ZtXXwIFnt2/imwAAF2u8Ls9NeLGFyNCM+CW3bgixRUjmH0Dndq3d6rgguCYQDw6m88no77z66UM96jQMDy6ZLcdvWSkA4gwxW8WBzNQCwg2dIrz3PUgM+RDflskZxbQhqlJL1VKbRCmwu4DAl7/4reXbEdONDvC3ORnzaGshz3A6KmEzQWU+vyYMvUg9I8XxyWRaA3K0gbJSLNpjZkyvJuDubwDBDHBcbFwBA2sr/11e4SVzvyaxrPWyuY/ZIO9/sjqjT82eqNzV3Uz7AK9nnfF5nnghDcZWkX0mVyqL31FDbfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(38070700005)(6506007)(4326008)(7696005)(2906002)(71200400001)(86362001)(55016003)(53546011)(8936002)(9686003)(26005)(76116006)(38100700002)(33656002)(66476007)(66556008)(64756008)(66446008)(8676002)(122000001)(66946007)(41300700001)(478600001)(110136005)(83380400001)(186003)(5660300002)(52536014)(316002)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IBRm8ZfoyfqLzfi41vXAPkCXA6rW8Ay+mQfYOZPBzSOukmD/uWrMlHyiNOM/?=
 =?us-ascii?Q?o5kKVRdGP9ZJeWiE1hk5QZyo+mTDSUkoKNR1zgXFzGqgTu335BctQnTOOlWp?=
 =?us-ascii?Q?+MXWZi3a6Hwhc4ygXT4PIZ5qQwqz1zNJtSO/GjYMGso9OZ+ZjbF+NfQH+uLD?=
 =?us-ascii?Q?Vu/ZjkguETQNLp/ACZdOXYE7kvChrMzk52b5yTKcIU3XfZ6aeYViSAKuIKkZ?=
 =?us-ascii?Q?CMyhOAuSh71hLTxj8RIBYR7Zri7Calshoxw6wVYrt9ln8HUsG3fiO/1Bpl4J?=
 =?us-ascii?Q?FwNW+77c8eUNAK0ceCNb4IFMvmtgJ9BL0+9etCL97m5rwRLtg65JbvJkOXg6?=
 =?us-ascii?Q?NInMWTQOw/+zoR2wG8fHO7ayL6MIrl48mUHeYcACZCAoucLIE3SulmyyG5xx?=
 =?us-ascii?Q?DWvz+Lo2Y412GuIi3+q2r2Gthw2iXs61bSD4Tx6XLwtTfbnfFt9d+vMt3duJ?=
 =?us-ascii?Q?v72cUbqOek83vXYyzfkwGUdcwRSFtbQzehk7rL28iYi7mpBD56Rr/oNpePfC?=
 =?us-ascii?Q?VHsLwR8WkMMHAa4Jq8cGEg4m/+romFpqlrkHBjr1yEPPCD17siv7RBLo/YCJ?=
 =?us-ascii?Q?Zcnx2pex9G9TQPNISSAe6NiZ8bljBZsDsy/BjFbD3D5YrN7GbLHxJfRdfv6o?=
 =?us-ascii?Q?mhZacUWdg4+DALLe2GyzbB1CudU+1mMa/um91kQwbNNx7cFWKWC/7Un62ZAS?=
 =?us-ascii?Q?eTyag7IRnKKiXjKXQCovI4x5GKt6IbIuvicbTeh0Fxt/aTGQ+clXt8b3fkGw?=
 =?us-ascii?Q?ErGuPbvLe7Mmd7exUI/HQaMxuspN82eqceWjg9L9s4pQikWhN4+CAxpr4/JC?=
 =?us-ascii?Q?De1VCkJPxGjMt3JWVWAMMx6XhUTwvu9u53i4RCa2b+ZlUI/v7zOtJf+f9G5j?=
 =?us-ascii?Q?hk3TT8AQhZePdIVu1G7oD7rpZ9nv5akYyIHHsZ8EwoxNxB7VzGH0WdFVASLh?=
 =?us-ascii?Q?IceqYq8mymxuJsmHMtfEgQ37/ZpKo2f03wMJ248wdgImxTDM3befY64egnrd?=
 =?us-ascii?Q?4kpH0zNDJ5nL7UEKOyzi9ZfL2kRMbMIMNK8K6s++1DFgO3F7ShtbZJvfKHtC?=
 =?us-ascii?Q?K0rCHzoQw6Q5PgGHWYp8vMdDoiXPbxEQOxzF+kCT5C0UVoD0DlVJGP2xQ8Db?=
 =?us-ascii?Q?glnn2LQk1SN1K3/SP3o5F7B6z+DHb1Zfrr6CD+VFDjp96kQyeARqX7M4nICT?=
 =?us-ascii?Q?HNks95nR+MHOjsKVpjZLjgyE55M5HPwlPgBP74BPTlANnlnphKtYEwAL+l9j?=
 =?us-ascii?Q?Sj/bQiiy6tC76D+6VZ41Qnq6w5a+lUsTD3QP6aMgoPAzlg+DA8eQvpZ++hE8?=
 =?us-ascii?Q?Wstm7hkYZSuIAxioFBqhm0juuE2J3u8XRRFRbmOwE3wnrAsirBlWYI7nHTNn?=
 =?us-ascii?Q?zMMymNi9YjRhyDUYWYMu0Li15KOmmrdUzIGIu3TWQuAy98iAtcyobdlg3W6z?=
 =?us-ascii?Q?Fmlm5Qroijqb9+h96mjzCspgKf8FwpHCYpAaGJvmAHV3XzW+nMPIWDkUEVmS?=
 =?us-ascii?Q?7sxd4MvJrMawKoTXszV2tqSFZixkAkFDn2W78o2XYvJcMNY43oRBvfwd+x1h?=
 =?us-ascii?Q?bUPQwv0mjc9Q2yuyVXc9Gwwc7jhRp9TEZVcdv3EW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871323e7-c91c-452e-2113-08da99ed8acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 03:17:54.0810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUKKiTCQYwM2Ah1FJdEqER+6yG1PknhYIxqzCWgr41I2TWUcTMHs/Z2u2N+PHalOXZqZkZPVuY7f3HSiDjdiHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Guchun Chen <guchun.chen@amd.com> for this series.

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Monday, September 19, 2022 10:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V2 1/7] drm/amd/pm: add support for 3794 pptable for SMU13.=
0.0

Enable 3794 pptable support for SMU13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia208531c9eb96611b6136975bcbd8d27007b9e14
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index de779f8089d3..a6b7319fbfe6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -406,6 +406,7 @@ static int smu_v13_0_0_setup_pptable(struct smu_context=
 *smu)
 			case 3664:
 			case 3715:
 			case 3795:
+			case 3794:
 				pptable_id =3D 0;
 				break;
 			case 3683:
--=20
2.34.1

