Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB35C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 01:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AA910E869;
	Fri, 19 Jan 2024 01:04:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C46310E869
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 01:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWBiN1Rbc1cim+uTg9/VVH9cLurPFKZFoD0neypM7/r9O9ShH2KALJRJviYVSgXWe1zjr0ATiYnTHokjxgYzA3Y+ULODBiUAWMpCAIOy0RXcHKdNVDybz0lLgtxmvIMO36l8edP3k6/kyJ2oBakHS3FcU3tNbygd0Y0QbyBviVp7MUzg+7VRGt1vR0cdClEKBy9cyePRXFMNRtmYf82QJqDWHtvo2XYBsjlGpAfw+K5O0OFdGl7otUJg2DuvbV+oZrsWHKW/j76fRK9ztoz1VNxMxNfsycfAVpEVPQuo+cgnTwLmP4Mf/39Zkyck0HXbQopzJJ1pV8BI7E6V5bW+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nky+isf2foiNZlSgUXkFcOD1hVy1ZeYdD+wmRIQnVes=;
 b=fT3gK7wgLkFKHcCi+o2Z9l4O8/8Dq7bKJIOp9w53T9HwMiL0Jwc0j354Giyc5YlbYpRZSQh5c8XdZSjMJ3LJOwqyVawzsLWvNM5J1x/3GOVahasjjpRuK80nS7TLGk8YuX1JACE9g9JruAOek14B8a4jYYL3XpvnF6W3akQt1Mb65TcdzeOQ7v/hGi04+aBFui1AdG0LAkxLQKtgn5IGlneBtlKE47gucRDmarhKN+qctZHwE6YvfMcFr5j2dKpcqSeWDjlRExET1YcoIWqEQ1hwrc3fiVdpWR3isxMXINcyjBHYHROFmZ2viKuWGMTsRpe8SSYq8/lQWtadrENdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nky+isf2foiNZlSgUXkFcOD1hVy1ZeYdD+wmRIQnVes=;
 b=tRQNbtCzkSZAvhcybz1XyNctxhHvgQJ6jxGUR5aLizyFwNIGrr9l5SQibah6jcaw4onVQmrPogeIQO1FhH9kCCrpOM+quPce5wjVL20nUolvZazjRGlnnpQ82wwylhyKsTCKXc4T86mnDHWrUgYlQQNermTo0d+U08nw75zrXik=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 01:04:38 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 01:04:38 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Topic: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Index: AQHaSdmrt2k/LEXugESPpnLHLFLenrDfjQEAgADGJlA=
Date: Fri, 19 Jan 2024 01:04:38 +0000
Message-ID: <CH2PR12MB42151192D9A6BEE73591BF54FC702@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
 <PH7PR12MB5997A1FFBF28D64279710E1582712@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997A1FFBF28D64279710E1582712@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T13:12:31.1432102Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH2PR12MB4134:EE_
x-ms-office365-filtering-correlation-id: ba622b1c-b005-40e4-e38a-08dc188a9c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEu662ik+6OcNATCxxDJqPgXPd8buIAeLs+/fU/fMy+w/RQcqFEDWgApEOhQy5oiEJX6gGFsY5e3aGQmzLtJU7xii7ZBFDQgEsb15KwZ86EyFi3vcBWWrQNK6ZNUrrAMoy3LJxkkuTFybx19mU6Sur98EQt0mDrOht/8Ic3BeegZYM04sdO3vJnN4BW7DINK2uRFIANTulwIFWEH0iWR2z755MN+/N1NNdZ84qSR0ywStfcy6PLnLOZNLRmkgzl3mcZhacMimgOVwOY8K+sZeFuCCRlweab5OJXqfeOIepcDPVTC75V7tZiO0fGKlIZOgrO1QVkPfmzENkPXQiPe3jkRdokKWwxU9+q7gVtpIgdBbWauUbtfZikEKHktLT8OryL0mFW9HgWy0y1DG9eyOHshH3onVqdRHqUFxf8qsilpbE8Gie75b0PFIXQHx4UC7JHhRxowkkkHawGMskkp7hlb3aU8/W4dE8hnIAxRr+LV/iL8WzxxF0W3teOJbO2e55gXAJroQUxsBJO0jlWUmzPb3InQW8c0tHh1TuMxUjtS1TWyUL1JVGB9fntYjLN+XW+abLrvFHc9JDYCB2NWdPHou35+4DRmRdzj0n4IwYMiW8cY6ni+SAPzPxWRohuS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(38100700002)(122000001)(33656002)(41300700001)(86362001)(66476007)(66446008)(66556008)(71200400001)(316002)(64756008)(54906003)(6506007)(66946007)(76116006)(478600001)(53546011)(110136005)(9686003)(7696005)(8936002)(5660300002)(83380400001)(4326008)(8676002)(26005)(52536014)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PtdThd0A4Gpx7XwlxqwNBBRgr3DS4/cpUYMnFMlJ0f9dGaWsOXDL+sK3CzoB?=
 =?us-ascii?Q?o61Bh+b7R/viXmwcoIvdMZpONoRhrgy6GVpcUGqo9NHtZbfMuM1r27LWJLVA?=
 =?us-ascii?Q?8g78qhFcDn0qoWnig256dIH9I/2S/BGgIE2yaNXBkMr92Gnq+QpsmcMK5KW5?=
 =?us-ascii?Q?n7Q9NpVEOyuHMioO5je1CTk4Ywf7zS5zAPoEUvrJyoBNI65vyycqgtU3TJRY?=
 =?us-ascii?Q?/eIf8du1F6WGK2nDGyo2jvO5whZ2fI53dVAa8AlhaD/ghd8pBufvgZxbJczK?=
 =?us-ascii?Q?4CSQcV/8TXXRdiVFQSjH9Kbj4zgECaU2WeHTavdVrGu+VIlIDEU0L/YQilSr?=
 =?us-ascii?Q?RdzvKwcEl9S2hktnl/WtNuXzmo+4PNw9iMxpRDGtj9a07ym9rKqaY2U2lMYL?=
 =?us-ascii?Q?j1IEk0MMRtQLOYXvT+0E1SuhqdAVCQ/ltK4lNx3SJi69hrcU8gOkx2RewyvV?=
 =?us-ascii?Q?+/cS9omhWrmJo6Q2p+kCMlIUjE2+goOaOkom8CX1RyU5Fh+ODQi4q1VcqBWm?=
 =?us-ascii?Q?ZqZFcAvUTtghrj9yBe6rEjcyK4puAuhHhjevIHvRiUkkXVrKH6C6K4WBiDam?=
 =?us-ascii?Q?jghXu9PguHOhmIbNUIlXl7VfrjSiyGAioPF+bU0UR/+g6dvhFgwCyg/7gHRA?=
 =?us-ascii?Q?364l/nOi0mibNOxiS7F42XftQ1h7GOrtAzjmoU4CnwN6pXqt/l0vUPH3r3c3?=
 =?us-ascii?Q?zrkBL7nzbs6b9Lf+5WSE84LjyW86KxpMXj8vIaHpLTA2vCSTKbn6AOjRKzMj?=
 =?us-ascii?Q?HUQAkHbw6SX831/HPfHfbORGGpwokVjUdGBsA0YbecB/wTv+IC6xgE3fK3w4?=
 =?us-ascii?Q?fNMMZsBm32COmgbW4xFr+brxtO8nOzQotJ5ghfk2JNC4GPYqjaBENE3fPIQ3?=
 =?us-ascii?Q?ZRgJ27pQC8///odrXiMpMb015SvVz0zcyzbzHSgOVyCK7/rsgC4ZRss6Ahlk?=
 =?us-ascii?Q?fJJY5cNQjaLlhePaQhYVCNUsm1cA6kiM4OarwU1jauXRx0zrJRFSCGmM+D4+?=
 =?us-ascii?Q?q9HaG9aoMqMtXI0vcbqLJrh6+KAJKHuDxcBmC4YgXIS7+4aZXvh6OfBJ0eII?=
 =?us-ascii?Q?LJot5bDFFyz1DCD9PRymBAbtql1VfCQ/4BRQIJluk+CBgMM4ky4t2CBuBP7F?=
 =?us-ascii?Q?sIusysZ+pn46pSh95g91RZyKVvIpSHQ/pAoHKaKi58j+QwrhrsaIFz0YaisD?=
 =?us-ascii?Q?7+935S3TnNlRJb5O+FZD8KZmdAIiGdrw0hXn3SP1+8uNwJZ7/7DebT1gBVUa?=
 =?us-ascii?Q?Sc3vcAwvV7FiwCIZmgOdD3aq29MG+ct4F1vTPN6CDsEihXSZeg75o7qm8mPA?=
 =?us-ascii?Q?nNDpPQcSb1dx93hUg+IAB80TI2Owoako34KNs+TQquplI/5uHp1SZM+F2x0O?=
 =?us-ascii?Q?OHTzwBllTPetAhR//JcjItYCnnDqd5DJ5Puh6RONi6osYPIQduMphd+qr+aQ?=
 =?us-ascii?Q?o522wJOGfNPmIwNW76J79lraw6B/gLnAKlGWda26Pe2EZxj6VV3uVzGibgX0?=
 =?us-ascii?Q?8lAJS2wzBrqApw65ks7H0ds7Ay9P5pZgp9nP1Bx2uWCZIagYN8tOFdfVfRL+?=
 =?us-ascii?Q?GmV2WrO61iTGgbA6Q7I=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR12MB42151192D9A6BEE73591BF54FC702CH2PR12MB4215namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba622b1c-b005-40e4-e38a-08dc188a9c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 01:04:38.3679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZIY7v0DIbxva0HSwpuD3WzjowtfNh9wzTbbxukjWpUyh/hSLm7dz7G+Xy+bbDx5RswkC0A1qb5Sq/LDaWy9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH2PR12MB42151192D9A6BEE73591BF54FC702CH2PR12MB4215namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

OK, I will remove it.


-----------------
Best Regards,
Thomas

From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, January 18, 2024 9:15 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>
Subject: Re: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_=
v13_0_6


[AMD Official Use Only - General]

The title and description don't seem right.

Remove smu?

Best Regards,
Kevin
________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Sent: Thursday, January 18, 2024 14:43
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Zhang, =
Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Li, Candice <Candice.Li@amd.c=
om<mailto:Candice.Li@amd.com>>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com<m=
ailto:KevinYang.Wang@amd.com>>; Yang, Stanley <Stanley.Yang@amd.com<mailto:=
Stanley.Yang@amd.com>>; Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Cha=
i@amd.com>>
Subject: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_=
0_6

Add log info for umc_v12_0 and smu_v13_0_6.

v2:
 Delete redundant logs.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c |  6 +++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)

 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status)
 {
+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, V=
al),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
oison),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, D=
eferred),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
CC),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC)
+       );
+
         return (amdgpu_ras_is_poison_mode_supported(adev) &&
                 (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0,=
 Val) =3D=3D 1) &&
                 (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0,=
 Deferred) =3D=3D 1));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)
         uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
         int user_gpu_id;

-       if (!p)
+       if (!p) {
+               dev_warn(dev->adev->dev, "Not find process with pasid:%d\n"=
, pasid);
                 return; /* Presumably process exited. */
+       }

         user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id);
         if (unlikely(user_gpu_id =3D=3D -EINVAL)) {
@@ -1334,6 +1336,8 @@ void kfd_signal_poison_consumed_event(struct kfd_node=
 *dev, u32 pasid)
                 }
         }

+       dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+               p->lead_thread->comm, pasid);
         rcu_read_unlock();

         /* user application will handle SIGBUS signal */
--
2.34.1

--_000_CH2PR12MB42151192D9A6BEE73591BF54FC702CH2PR12MB4215namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">OK, I will remove it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-----------------<o:p></o:p></p>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Thomas<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@am=
d.com&gt; <br>
<b>Sent:</b> Thursday, January 18, 2024 9:15 PM<br>
<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhang, Hawking &lt;Haw=
king.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Li, Candice &=
lt;Candice.Li@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 a=
nd smu_v13_0_6<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<div>
<p class=3D"MsoNormal">The title and description don't seem right.<o:p></o:=
p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Remove smu?<o:p></o:p></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal">Kevin<o:p></o:p></p>
</div>
<div id=3D"mail-editor-reference-message-container">
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b>From:</b> Chai, Thomas &lt;<a href=3D"mailto:YiPe=
ng.Chai@amd.com">YiPeng.Chai@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, January 18, 2024 14:43<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.C=
hai@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd=
.com">Hawking.Zhang@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Z=
hou1@amd.com">Tao.Zhou1@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:=
Candice.Li@amd.com">Candice.Li@amd.com</a>&gt;;
 Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.=
Wang@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@amd.=
com">Stanley.Yang@amd.com</a>&gt;; Chai, Thomas &lt;<a href=3D"mailto:YiPen=
g.Chai@amd.com">YiPeng.Chai@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH V2 1/5] drm/amdgpu: Add log info for umc_v12_0 and s=
mu_v13_0_6
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Add log info for umc_=
v12_0 and smu_v13_0_6.<br>
<br>
v2:<br>
&nbsp;Delete redundant logs.<br>
<br>
Signed-off-by: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPen=
g.Chai@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v12_0.c&nbsp; | 11 +++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_events.c |&nbsp; 6 +++++-<br>
&nbsp;2 files changed, 16 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c<br>
index 6423dca5b777..fa2168f1d3bf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)<br>
&nbsp;<br>
&nbsp;bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t=
 mc_umc_status)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mc_umc_status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val),<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Poison=
),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferr=
ed),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC),<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC),<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; );<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (amdgpu_ras_is_pois=
on_mode_supported(adev) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STAT=
UST0, Val) =3D=3D 1) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STAT=
UST0, Deferred) =3D=3D 1));<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c<br>
index 11923964ce9a..51bb98db5d7a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t id =3D KFD_FIRST_=
NONSIGNAL_EVENT_ID;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int user_gpu_id;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev, &quot;Not find process with pasid=
:%d\n&quot;, pasid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return; /* Presumably process exited. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_gpu_id =3D kfd_proces=
s_get_user_gpu_id(p, dev-&gt;id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(user_gpu_id =
=3D=3D -EINVAL)) {<br>
@@ -1334,6 +1336,8 @@ void kfd_signal_poison_consumed_event(struct kfd_node=
 *dev, u32 pasid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(dev-&gt;adev-&gt;dev, &quot;=
Send SIGBUS to process %s(pasid:%d)\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; p-&gt;lead_thread-&gt;comm, pasid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rcu_read_unlock();<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* user application will h=
andle SIGBUS signal */<br>
-- <br>
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB42151192D9A6BEE73591BF54FC702CH2PR12MB4215namp_--
