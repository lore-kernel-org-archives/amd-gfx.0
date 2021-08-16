Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1696C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 14:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7563F60C3F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7563F60C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8971D89F73;
	Mon, 16 Aug 2021 14:58:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C0489FD1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 14:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8YHDdKQtZ2IU/bDKCXus0kBVQHXuRj8VHKmq0ZKr4Nog2gVkmqSP35i68cW3LavwBXv5zNi9XvU9iEewOqPdShI0dA6yMowGq0HBWwhgcx+JMPhqIqUhmBP7JjedBML9E5tILUdvZnW4CtoKhcseZfvueJgGYrphfhdop/6QKWBwnyP0R/0FDinT6XmnAdeUPNu4yeB2x7mOpIYeshrmAp4/WfqTWudgJAJjNjHwmvbIO1Ce3CE6TYutg50vsW7dfNAWYuhP+X9Ze5lmo3djsJsD48VeelsskBKMp4D1nYy6KVRJSXWSQRBsT6frKYew64hFvHzuLOoztNfyJwVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5lRKDscdLKPU65ofKXo7LO4JPyV4DPmzA6CMKj8XnI=;
 b=Br5c0setinNaWM23+aDzEAZmrbef8oUjm+QsB7l3G6ql/ngm/muYpvGgj5s4AS6vMbtiNsxRwzQRpzXSZbMWWBPCnYFldnBaprTWRUihhdXEcy+kjOOWIhV6wdAocHY4YOf2DnHq/TbJEJrFxF5OVwCxsFlLkgCLrjPShEcZQWdtXuuFf8TDdNM1kqFdGUwopKFf4q017gp8vpN5IauHxSoQki085H/F3nBhVJLbIG4Bn2wOWfnkddgHazJzQIVW4G2QlM1lvFr3htNtrp9DA7xA2hqeqSb05G55FcSe+FERx1TY2RI8dfK0TA150KFvnV8qWj3q2uNokHMeh6i+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5lRKDscdLKPU65ofKXo7LO4JPyV4DPmzA6CMKj8XnI=;
 b=Rf/QhqWXgiiygih4ek+uF1JeyG2bJiz9J0Viy1G7NhAWJXtRiSqVvlddfv9S7fxFE8WT9OgSb3LGZSCs9lcWi8x0q0fidC8Nha9WXw6IBEOovVdAIaPFh0h/e6L779HFbWwDYYhoO4URxl1Vx03fqx2oqZwTK6YJd6m/KVuKv6k=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Mon, 16 Aug
 2021 14:58:36 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::c411:c7cf:2d9:a2c0]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::c411:c7cf:2d9:a2c0%8]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 14:58:36 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct MMSCH version
Thread-Topic: [PATCH] drm/amdgpu: correct MMSCH version
Thread-Index: AQHXj4vQu/W77n2vr02KxLHDJ62/iat2PLWAgAAAv6A=
Date: Mon, 16 Aug 2021 14:58:36 +0000
Message-ID: <BL1PR12MB5317CC1E3F22C3BC045EC56DF1FD9@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20210812150718.8827-1-zhigang.luo@amd.com>
 <DM6PR12MB55344C769CBA7414D8637777F4FD9@DM6PR12MB5534.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB55344C769CBA7414D8637777F4FD9@DM6PR12MB5534.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-16T14:58:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8531ada9-b1bb-46fd-b72c-42cadeeb6e4f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73690962-5f3a-4318-971e-08d960c65326
x-ms-traffictypediagnostic: BL1PR12MB5286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB528686AF661D8C5FA8C1D46DF1FD9@BL1PR12MB5286.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Za+vaStgdDF6IutHW8Q/hziIqPnEBlbFPSJIdA6MH3c7D1m0vbQS5S2t8gy8/nD/dM5Dhmzq8QoMR3jfjqCefYGHWQEUgDMhThYl//83b2IpUfOhqbsSawxdJ5coJGcAtEmLgsZNqPdqUPUQKwDcbMP04vF0v+yLxNlz8O6+G6wCjmYc8oRw0pTWOvEKzhSwOCEJHYjE5ljiFLRt4UvcbsDrKRfXEePoNsuq4MRdttmhV+Y+pVnp7ILCJRU2iF28HbFyC0YgBMjZu8LeqS3eGDVHwj6WcngYNe54fX7h8Uoo+1jk4Uu12BIrEubM7sSPNjYCJRRkBRSccPv0lILFA04drW3E9lKp5hGiYwb8CvLfnAqIFtdRXvc8NWupshgJupcykzEszyUTMoNZc0rwi+QZa8lb4lPw49Uub95qGQPOiIEt/Spn+YblsYFgR5is3Tz6Xu0bZaSCwdPl60k5UkLjsbVwZ7Uq8GhGe1WvYU/rdVw/O702dDZtc7Bgd8ikALdoK5kp0djId8l1wWNiIcagEGHgUWSXmwD56fD+60ku4q/dvndcmNdRCyFEw5bDOXQijRiINVN/CavAH2DhWGLlDFd050YUDxNIQMIq822+436dI5HTUHkw2WmofV1z/1rWYMGel2WDslvR6NCXIJQFOHz3VWjFpVYaPotSYTpDQOhg+z6crsQpOch2+KmG1Je+CBq72IBCbZ3bswi63g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(186003)(71200400001)(38070700005)(26005)(2906002)(5660300002)(83380400001)(316002)(66946007)(38100700002)(8676002)(122000001)(9686003)(52536014)(64756008)(66556008)(66476007)(7696005)(53546011)(66446008)(8936002)(6506007)(33656002)(76116006)(86362001)(110136005)(55016002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?52MoYjfIP8UTwGZaypr5Q3Rl6MwVIW8jo9G4GqmzQd0rUPSCexCxVVxqr6Oe?=
 =?us-ascii?Q?gSAbB0LK6yKXkZXMH+77koPd5eJc24PAsgK8VLd1eJ3cflTrhYhChBNASZoa?=
 =?us-ascii?Q?iBsPfX3t0q1Lt2v+nXJaXom7wgKECnPk9Fc3uI1R4nDS2fkcb/Fn9Nu+A/p8?=
 =?us-ascii?Q?/4f59im67+ook7knWlY4jyWfiAst7tGy7fVcgEc4Xoc3W5fv7d40SUvMX+7y?=
 =?us-ascii?Q?HQn0UiHqw3sav9ecCJohuIUJnPA7/zPXFHmEsc5C8/8Jerxm2IKZPQmxDrhG?=
 =?us-ascii?Q?TL8qLWVZImJt5Cz17RfDy+d1UFafY4z4dTYM8IWsf93V3N8sGmLeiuWBaHZO?=
 =?us-ascii?Q?r7LjIo7VCv04UAUGoMLG9i5msu6ryfM6mSsy95F/NjA4yepYJOmn81rX3nYw?=
 =?us-ascii?Q?dHd9jdxFHnVIWqfHWE/riPEILyn+UoJAIQG3TJxjb0zx9G7bcq7VD4en3I55?=
 =?us-ascii?Q?rUxSN1ROsCUmWfWsuBtBD0QT8+lrv5g1SQC5O34FOkfGY3HW9+5vFvhxIC/u?=
 =?us-ascii?Q?9cWjBnQzU86iaVl91Z9HTRxPQJxaDD6rZXeZwlHD0JgSyCWkAteXXnWd6cgk?=
 =?us-ascii?Q?/3jr2hbUbaj+Udi4UVkju9Jf5+VRKWmpqWnMJcHrjBO3IAOqmo55CtBVyjuK?=
 =?us-ascii?Q?ib2r0MlrtNP6Q8DWIZGTU+lXwRg+oAiZl55fjqJFV0/6bFBugkaBFAM5M3eO?=
 =?us-ascii?Q?jmFApIIppVGHxPWGqY8PhiyRop7MV2xCo4bxw0C9GDvwbPW5p+0b1NV8N0XE?=
 =?us-ascii?Q?BMmyZHlwgWi0nraIxZEn4ReQkvS9czgIYH3JhCCmz3ztJ5AZ7up30hDfzeME?=
 =?us-ascii?Q?AJyWbpUvKxmG1NoZ4m9yL0V0hORCi68CfrTL7EL8ZR8N6q4IEdP9fzZ7Rl8f?=
 =?us-ascii?Q?wNYWYMWuZl9OdWLxKLd++aKHUQUVM9bqyFaWlxCru24335ARVkxr/YukDjLU?=
 =?us-ascii?Q?Qp5OIfLPTun9aZntE4yHYvdBZRpXzdcOouYkTkhGMD/5cFjRi+4q0nmUGX9p?=
 =?us-ascii?Q?SGZqgOTRjjI0BAA4zYCDhLBlkmCO35L4hhI+oHMLzZT0ggIJug0wcwmnLnyM?=
 =?us-ascii?Q?oLmrMn8EHoKu4Ou+6O11niVol4KYLC05Ph5zvDvu7Zcj/awpc8SPOIyg7oPD?=
 =?us-ascii?Q?AoliDwOEioQvSt3Nfapo2R0yFPGpZ95i++6wfTS4lTi6zOJ4ib38zvSXWAk6?=
 =?us-ascii?Q?sib2x2v3mPvN2f70JnUOI1bQSK4kTIGTSwM/zczmXAf+PScbfusWs8Uey0sx?=
 =?us-ascii?Q?CIBTLd4QkFiAbZ700MXMU6zAqLlm8d8bsvqYzHkBA6WGU4hCKsT1efkNnVVd?=
 =?us-ascii?Q?HaOTKPNh4U8ZAZXa1iaHPOtM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73690962-5f3a-4318-971e-08d960c65326
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 14:58:36.3220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3kMOU2+3Jr9HVqEeDMfWAM1GtJ3vrB9bZ5/Zlv5gtGf/oWEGsK0SZuIM414M4V7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
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

Yes, the information is from MMSCH firmware team.
They are saying the version info is not used in the old MMSCH firmware, so =
it won't break the ASICs using old MMSCH firmware.
Ok, I will change the commit message to specify mmsch 1.0.

Thanks,
Zhigang

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>=20
Sent: August 16, 2021 10:49 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: correct MMSCH version

[AMD Official Use Only]

Is that information from MM team ?=20
Please make sure it won't break the ASICs that use the same  code path. Als=
o If this is true for all mmsch_v1.0 , you need to specify this is mmSCH v1=
.0 , since other MMSCH version will still use this major and  minor.=20

Shaoyun.liu


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang =
Luo
Sent: Thursday, August 12, 2021 11:07 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: correct MMSCH version

MMSCH doesn't have major/minor version, only verison.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h b/drivers/gpu/drm/amd/=
amdgpu/mmsch_v1_0.h
index 20958639b601..2cdab8062c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
@@ -24,9 +24,7 @@
 #ifndef __MMSCH_V1_0_H__
 #define __MMSCH_V1_0_H__
=20
-#define MMSCH_VERSION_MAJOR	1
-#define MMSCH_VERSION_MINOR	0
-#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+#define MMSCH_VERSION	0x1
=20
 enum mmsch_v1_0_command_type {
 	MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
--=20
2.17.1
