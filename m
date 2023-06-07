Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCDDC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 16:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C0810E053;
	Wed,  7 Jun 2023 16:25:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7871410E053
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 16:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3XzmPzKCawF/Zyaw4on5K8SA5nUEy1ypoYOpsD3IFFTPIuIoccZrI6cbTlpNyVa67ZXq8IqqLfXrYbdZdn1M6LBQDkDnem8GhGYsQBFkzsdTSCvtH5M+Z0nM0II2x9y+ks5DJbCsQiKzIxWyw99c2BGWHPCJtm61/HnKkb+Mz6b6QubSgctSbhlH0BTANZ1zboS0t9PoHomIN1CDlPqWGJxLfVAHezGpfqoQQdv+Vpwh6885YC0pCdHVdFCKqcQtUL5Bc4xLXKhZC3kD88R03GYPVPX/D5fahuUGrU6w0Q+ab+tDlI5T3FCB2qUEjgMR49oxp4MDlUV/1D1mhnIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NNL0DgOoHtCrauAkR3OHoShuxmPSabz2P6sWhEKaFE=;
 b=VzfkvgfeqyRsXE40lkF7++qUZp3Hsq0sk+MT1+7tIspMnBGouET25X3TsNyH7U1ltmYGi3+an26IvRwXa3Dgmt6AWpFEjC8FAI8RjEdANckudS6CFJEjUPzN7xxQeENGTlLOsy7cNkuS5y+yCvi6otT7MAqwowC+2Nd876F5Op6WBZcLIR3XfByOYHhoTXqQuTMPuVNBzOGTAI6U4lLPFZetcFlW31UcDYHS0aov5YHG3x8xIb8qnD0qx4zG9Z+dEP9QZWMu8+e28Letaq9B19DN7Umd/BOPZHQYXgQ2XIMdxZ5hqd9ilqDBucY+0wG3wHprKobbRJcBtBGREsppUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NNL0DgOoHtCrauAkR3OHoShuxmPSabz2P6sWhEKaFE=;
 b=z5TfEdS1rPm7XfxopSF/ffONUF2ILrfGOlSypVAbHzPH0OhTXd1agHimDuts2gYZhg78R/GKcmSi4hBelzXt459bFfMgpxH6EzkShhBZHPkHyAqXy2gjkJf0nzaIXGV6dwg4bp1B206A7UXfJi8ImKjqqIMg66HPvNcqb0Id1N4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:25:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:25:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init
 header
Thread-Topic: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init
 header
Thread-Index: AQHZmEOPyLD2zVS4Q064sP0GaEvrrK9+iuwAgAD9yHg=
Date: Wed, 7 Jun 2023 16:25:19 +0000
Message-ID: <BL1PR12MB5144397E8A846D8DF833C5C4F753A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230606065210.3103195-1-Emily.Deng@amd.com>
 <PH0PR12MB54179D8AE876C2278669678B8F53A@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54179D8AE876C2278669678B8F53A@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-07T16:25:18.590Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: 5077df5a-66bc-40a3-0194-08db6773c929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHBAJAF0Q7XPVS1LD5IpDbJmMdgsmQQyos1ykdimwij6kgQBiJ2Y/dyrqrAPYx3N6Ev8JZF8u1WzIaqtIDuEsfYzt71dyi33II99WxHTTYCkc5HofwKUrn3tu/K4Lf13Rcdlxks5BzWKixJu66TFqf1gh0vzrlsfYXZWGbOldik0Wq7QGUUzqL5MbXS0hUheuWfHsSen8xfF3gZWPJLb9Rn2a4utL5vQfY6CHD3X++JkM3ui7abuMxy9YMBnpP7ea04pyn9Q0Bk75bpUsaTyrpUVFeDgMbtenwRhAr+/IoqB8nhIWf+bnET6MQry03Q9BSr4kDdpsDsFNwD1PbraX4q6kuhm2fvzfnXAiXsjaih0KIqo7qHxeOVhDd2xZ/qxn74nwT3R8UQeiITqFHMDWPOd7T4LgHZoYwKryvjWJQ7q8BpaMAYlQsmRWQ6PjKeWeni5KrzG9/li0cAurqQxLDEDPvdCjSk9nEuXTWN4XcAervH+HFRBjDeyiyvrW/4Rj2Ut3wyeBiKxhYjG9uaWTiHcrGnBHWp7grLjWslIIWZzTaqrozCVhAixOqXQWNsWQelWuuFienM0Dvb5Cw8HjEq3AdYEsopVoOcT+2BQ3VVrG1RE9P8LMsh3PVvtJHbw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(478600001)(86362001)(38070700005)(5660300002)(33656002)(83380400001)(8676002)(8936002)(110136005)(38100700002)(122000001)(52536014)(55016003)(26005)(316002)(186003)(64756008)(66476007)(66556008)(76116006)(66946007)(53546011)(6506007)(9686003)(66446008)(71200400001)(7696005)(2906002)(41300700001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?855PP7KfaEshF88iUbIbjlu+idjRGzZfuXzJD6O3c1ck94KdBdA4SecRes8Y?=
 =?us-ascii?Q?0oEQLOrPoecObnplrjJO2RYHluLKiND8VMm67nXOaVXUvye6AD+qNJSQP/eT?=
 =?us-ascii?Q?1r+mawBlRUT6HEL/KXSMxR85wKA09SYxQKW6xogU+hZLtOqN+ajL8fZ+B6fP?=
 =?us-ascii?Q?mBd3F2Onz5Hk8zte7R0cKoONHWX6s0jG5QhhHK5prWsEk8KI5xvzuHk5rn2t?=
 =?us-ascii?Q?sYj3/o5mmprhA1NJ46lSu4627PikVcYYjyy9yvSBBwri4tJ4/KNpKVZNlb05?=
 =?us-ascii?Q?ZuoKlvGsxPx005IAf9k2tykorDS1pMBOXypmLPVppUyQoXeDQCTQ0vZDPzQg?=
 =?us-ascii?Q?n2oLeMYWIbaWoVWLLEvbAzTrZyIVpgjwKrvY65ie0L+E+omHxE+DJfxdrTKz?=
 =?us-ascii?Q?EF6KKOkFAFoU4ZllY9K9kbh72Ex5I8GABmCskDmmFSgJ+P1QytEpoIGZZ83m?=
 =?us-ascii?Q?Yle62pQ/IHxHu/L4cTGluSB34355HdnH94WNHmb4YipYFWDmcMFybBE6/eAz?=
 =?us-ascii?Q?KmYesHpXEEY2fKxhcsimogiwBPGuQJ53O+CtXqxQLWyK/tcgsnz8tqlFlaML?=
 =?us-ascii?Q?XtqQlqBc5sWOFr0BPnjNHFTKz6ArPUekEglCnS6d2MSuaCuZ1SY/dKZa3cmS?=
 =?us-ascii?Q?Ss+IKPDj9ek5XWtMhUVBfEHNPCBrrxh8jYzX7Sj5Hw7yKfxgPYZUZmm4hIT1?=
 =?us-ascii?Q?lI7FSlAmeq5vo1aKdKVzy/QacVzyEMJdJVsUY7rll0aZpHV7S2qerpdZaSM8?=
 =?us-ascii?Q?rOUKQsY/hSrsBeAGmsvrUkjTDQHGI0h5Q4rccUk03gXSsXkhhwgks9AMIUPf?=
 =?us-ascii?Q?C/7bo7Kt6GUozsz4zJbzVGRydXFHF9+igeKM2Mq5HsuqMpmtxZJilbnudK6x?=
 =?us-ascii?Q?92r6O+zhxQVu81Uf6kYzwscYdPLMwERFIPUz5vTxwZjYT50q2MvIP2SY297x?=
 =?us-ascii?Q?8uNTwim2KGCzbMDJAOgM6E87gzZVipXkgLCunFxQFQc0qaIQYuRULo96WXJl?=
 =?us-ascii?Q?Ppljq6BrhpNl5eJFxZwa5N9ZHnEU+D2YeWAUrwXvsu85J7ruU9tBzZEVb0hu?=
 =?us-ascii?Q?TmtHmuHhiXQRW0ihjCoEw1ECgA5c1QTQkt/0LaVQzLXZWmYAys1hx8QghHM8?=
 =?us-ascii?Q?USL17+9WWTDH1NywdWWdwjby8PFUBJeW4ahHzC7I8qWLEROyZHdp4zZ+kjCg?=
 =?us-ascii?Q?heZQ2/T68SZtQWoTliWa7QMn6kPhhRXrXf9C6wxFmO0KawtXJi/mZLlKLAhR?=
 =?us-ascii?Q?LQiNzavL6Yzk1Zowws+zi3F6HHtiF0AObJFVT2QmADDncl1qazBoh6L+hAab?=
 =?us-ascii?Q?OfYxMsiv+CDmiKLC9zDJyD4DaWWCjGlc3m1VGRc3UwUA9PPjsLKsIDp9YrAQ?=
 =?us-ascii?Q?6lyg/4/ir2n6RpSx79oZ02IIYfCUN4Ps/Qq1HOpvjLuljaqFq0rVK80s5rva?=
 =?us-ascii?Q?LI8Lqd9AtGu4B1WTQVIaFWNBMIsHl4uG/fyp4Zmik8M3kgbh8YsPveVRg2N5?=
 =?us-ascii?Q?D6vetQMYJQyIq2P2OqPzSBblvAXAApwX4sUuRtnZAe2UdDNqTkOPXaAqKgQT?=
 =?us-ascii?Q?z39g9R5PUiRef5QSJbA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144397E8A846D8DF833C5C4F753ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5077df5a-66bc-40a3-0194-08db6773c929
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 16:25:19.6273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih7BewoRkZ84n4o5wANwt6imOpzXCewuBdKoMtu046S/WplPh52JO5o2luqKfix7gy+bFf67p8y/jWoHZB17LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
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

--_000_BL1PR12MB5144397E8A846D8DF833C5C4F753ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Deng, Em=
ily <Emily.Deng@amd.com>
Sent: Tuesday, June 6, 2023 9:16 PM
To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch ini=
t header

[AMD Official Use Only - General]

[AMD Official Use Only - General]

Ping......

Best wishes
Emily Deng



>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, June 6, 2023 2:52 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init
>header
>
>For the header, it is version related, shouldn't use MAX_VCN_INSTANCES.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h | 4 +++-
>drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h | 4 +++-
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
> 4 files changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
>b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
>index 3e4e858a6965..a773ef61b78c 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
>+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
>@@ -30,6 +30,8 @@
> #define MMSCH_VERSION_MINOR   0
> #define MMSCH_VERSION (MMSCH_VERSION_MAJOR << 16 |
>MMSCH_VERSION_MINOR)
>
>+#define MMSCH_V3_0_VCN_INSTANCES 0x2
>+
> enum mmsch_v3_0_command_type {
>       MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
>       MMSCH_COMMAND__DIRECT_REG_POLLING =3D 2, @@ -47,7 +49,7
>@@ struct mmsch_v3_0_table_info {  struct mmsch_v3_0_init_header {
>       uint32_t version;
>       uint32_t total_size;
>-      struct mmsch_v3_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
>+      struct mmsch_v3_0_table_info inst[MMSCH_V3_0_VCN_INSTANCES];
> };
>
> struct mmsch_v3_0_cmd_direct_reg_header { diff --git
>a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
>b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
>index 83653a50a1a2..796d4f8791e5 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
>+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
>@@ -43,6 +43,8 @@
> #define MMSCH_VF_MAILBOX_RESP__OK 0x1
> #define MMSCH_VF_MAILBOX_RESP__INCOMPLETE 0x2
>
>+#define MMSCH_V4_0_VCN_INSTANCES 0x2
>+
> enum mmsch_v4_0_command_type {
>       MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
>       MMSCH_COMMAND__DIRECT_REG_POLLING =3D 2, @@ -60,7 +62,7
>@@ struct mmsch_v4_0_table_info {  struct mmsch_v4_0_init_header {
>       uint32_t version;
>       uint32_t total_size;
>-      struct mmsch_v4_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
>+      struct mmsch_v4_0_table_info inst[MMSCH_V4_0_VCN_INSTANCES];
>       struct mmsch_v4_0_table_info jpegdec;
> };
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>index 70fefbf26c48..c8f63b3c6f69 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>@@ -1313,7 +1313,7 @@ static int vcn_v3_0_start_sriov(struct
>amdgpu_device *adev)
>
>       header.version =3D MMSCH_VERSION;
>       header.total_size =3D sizeof(struct mmsch_v3_0_init_header) >> 2;
>-      for (i =3D 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
>+      for (i =3D 0; i < MMSCH_V3_0_VCN_INSTANCES; i++) {
>               header.inst[i].init_status =3D 0;
>               header.inst[i].table_offset =3D 0;
>               header.inst[i].table_size =3D 0;
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>index 60c3fd20e8ce..8d371faaa2b3 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>@@ -1239,7 +1239,7 @@ static int vcn_v4_0_start_sriov(struct
>amdgpu_device *adev)
>
>       header.version =3D MMSCH_VERSION;
>       header.total_size =3D sizeof(struct mmsch_v4_0_init_header) >> 2;
>-      for (i =3D 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
>+      for (i =3D 0; i < MMSCH_V4_0_VCN_INSTANCES; i++) {
>               header.inst[i].init_status =3D 0;
>               header.inst[i].table_offset =3D 0;
>               header.inst[i].table_size =3D 0;
>--
>2.36.1


--_000_BL1PR12MB5144397E8A846D8DF833C5C4F753ABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Deng, Emily &lt;Emily.Deng@am=
d.com&gt;<br>
<b>Sent:</b> Tuesday, June 6, 2023 9:16 PM<br>
<b>To:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/mmsch: Correct the definition for mm=
sch init header</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - General]<br>
<br>
[AMD Official Use Only - General]<br>
<br>
Ping......<br>
<br>
Best wishes<br>
Emily Deng<br>
<br>
<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
&gt;Sent: Tuesday, June 6, 2023 2:52 PM<br>
&gt;To: amd-gfx@lists.freedesktop.org<br>
&gt;Cc: Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
&gt;Subject: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch ini=
t<br>
&gt;header<br>
&gt;<br>
&gt;For the header, it is version related, shouldn't use MAX_VCN_INSTANCES.=
<br>
&gt;<br>
&gt;Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
&gt;---<br>
&gt; drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h | 4 +++-<br>
&gt;drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h | 4 +++-<br>
&gt; drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c&nbsp;&nbsp; | 2 +-<br>
&gt; drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c&nbsp;&nbsp; | 2 +-<br>
&gt; 4 files changed, 8 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt;diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h<br>
&gt;b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h<br>
&gt;index 3e4e858a6965..a773ef61b78c 100644<br>
&gt;--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h<br>
&gt;+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h<br>
&gt;@@ -30,6 +30,8 @@<br>
&gt; #define MMSCH_VERSION_MINOR&nbsp;&nbsp; 0<br>
&gt; #define MMSCH_VERSION (MMSCH_VERSION_MAJOR &lt;&lt; 16 |<br>
&gt;MMSCH_VERSION_MINOR)<br>
&gt;<br>
&gt;+#define MMSCH_V3_0_VCN_INSTANCES 0x2<br>
&gt;+<br>
&gt; enum mmsch_v3_0_command_type {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMSCH_COMMAND__DIRECT_REG_WRITE =
=3D 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMSCH_COMMAND__DIRECT_REG_POLLING =
=3D 2, @@ -47,7 +49,7<br>
&gt;@@ struct mmsch_v3_0_table_info {&nbsp; struct mmsch_v3_0_init_header {=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t version;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t total_size;<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmsch_v3_0_table_info inst[AMDGP=
U_MAX_VCN_INSTANCES];<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmsch_v3_0_table_info inst[MMSCH=
_V3_0_VCN_INSTANCES];<br>
&gt; };<br>
&gt;<br>
&gt; struct mmsch_v3_0_cmd_direct_reg_header { diff --git<br>
&gt;a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h<br>
&gt;b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h<br>
&gt;index 83653a50a1a2..796d4f8791e5 100644<br>
&gt;--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h<br>
&gt;+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h<br>
&gt;@@ -43,6 +43,8 @@<br>
&gt; #define MMSCH_VF_MAILBOX_RESP__OK 0x1<br>
&gt; #define MMSCH_VF_MAILBOX_RESP__INCOMPLETE 0x2<br>
&gt;<br>
&gt;+#define MMSCH_V4_0_VCN_INSTANCES 0x2<br>
&gt;+<br>
&gt; enum mmsch_v4_0_command_type {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMSCH_COMMAND__DIRECT_REG_WRITE =
=3D 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMSCH_COMMAND__DIRECT_REG_POLLING =
=3D 2, @@ -60,7 +62,7<br>
&gt;@@ struct mmsch_v4_0_table_info {&nbsp; struct mmsch_v4_0_init_header {=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t version;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t total_size;<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmsch_v4_0_table_info inst[AMDGP=
U_MAX_VCN_INSTANCES];<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmsch_v4_0_table_info inst[MMSCH=
_V4_0_VCN_INSTANCES];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmsch_v4_0_table_info jpegd=
ec;<br>
&gt; };<br>
&gt;<br>
&gt;diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt;b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt;index 70fefbf26c48..c8f63b3c6f69 100644<br>
&gt;--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt;+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt;@@ -1313,7 +1313,7 @@ static int vcn_v3_0_start_sriov(struct<br>
&gt;amdgpu_device *adev)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header.version =3D MMSCH_VERSION;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header.total_size =3D sizeof(struc=
t mmsch_v3_0_init_header) &gt;&gt; 2;<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_VCN_INS=
TANCES; i++) {<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MMSCH_V3_0_VCN_INS=
TANCES; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; header.inst[i].init_status =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; header.inst[i].table_offset =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; header.inst[i].table_size =3D 0;<br>
&gt;diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
&gt;b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
&gt;index 60c3fd20e8ce..8d371faaa2b3 100644<br>
&gt;--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
&gt;+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
&gt;@@ -1239,7 +1239,7 @@ static int vcn_v4_0_start_sriov(struct<br>
&gt;amdgpu_device *adev)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header.version =3D MMSCH_VERSION;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header.total_size =3D sizeof(struc=
t mmsch_v4_0_init_header) &gt;&gt; 2;<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_VCN_INS=
TANCES; i++) {<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MMSCH_V4_0_VCN_INS=
TANCES; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; header.inst[i].init_status =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; header.inst[i].table_offset =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; header.inst[i].table_size =3D 0;<br>
&gt;--<br>
&gt;2.36.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144397E8A846D8DF833C5C4F753ABL1PR12MB5144namp_--
