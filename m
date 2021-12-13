Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303C4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 05:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEB810EB3E;
	Mon, 13 Dec 2021 05:15:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D7F10EB3E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 05:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmAMiSSa0zjuhhvuCQybzWcSWOkIXajqSAaw9MRZz+wdAGIoz1U4EsirqkgaQxSX7AICrzkzAeukhvHYc0Y+XwCjFFKi72kiNsj3BDuoGzmTaQUeQkXI/s6qQxcB58iseIH/0uZT7F6xTxqpaUPRwjWlXr6SiMcETIApjcx3TRg+sa1NJqD8DePUS4v0Ol3dTqPINR4nlqCZb5Sqyg4JPICn3U2HjaKL0rT8PtTXay17BMMvoyRQ2FP/7ITW9xFQZS5rpem9j28IvubPe5G8H31qG1ZCB7dG3xN+QVKWYYO+Q8l6oVvo3typi1LIhOttWuivADmktX5QZiIZmX0ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBwnZ+eVmJhbgyNea9tjcpd7zWB+ZVFN0oEp1czwsE8=;
 b=CiJFzVj8Qa5UlSP4YpIrTqgqqNqOnm1ubP3X8xGSZ4kvkZQeJxTotd5lziF75sHyQ8dvrdvlPdX8OKVN2goduASQZsR4BZ8kxN1aqMQHkMg2JFow26mRlY4npEiDTNQx2JR1liqOfLHsGM/Rp0XXueGTfpu+jqEmPae6wIySJ/Tno6CywnnCLBxG3nRVxge97YGOJ2NU+XRXbRv6bJMeDjFD1mE266a/NJtKy7owDHJOMSYQ+h1ql/bAbotT9hbN2e5GNfZq6NmmaCQCNDWNSKsbVjnBR6ILyDoPwyZl56SOs99d+Wc8Vtz5e44k2vFgzxWT+AyaiRGWBqYunU+Ksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBwnZ+eVmJhbgyNea9tjcpd7zWB+ZVFN0oEp1czwsE8=;
 b=SaszNLuq3MxAEiV59ewnr3rOSciFFfZFtaNiERBKyTpehJiLymMnynFx5AqfX9l+/Y2zP/b/xp7ZySefd7gB9Qa/946Xehm8lhbS0mra+cCWQ/MrupzSg+JB5xt3LJELMX2Q4bTNXwgoXo2F+7eQR2lvB6HjdKn9qInlOiKjUcA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.11; Mon, 13 Dec 2021 05:14:59 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 05:14:58 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V5 15/16] drm/amd/pm: revise the performance level setting
 APIs
Thread-Topic: [PATCH V5 15/16] drm/amd/pm: revise the performance level
 setting APIs
Thread-Index: AQHX79T1ELVTM37yYkSfAEUuqz3t7awv4J3g
Date: Mon, 13 Dec 2021 05:14:58 +0000
Message-ID: <DM5PR12MB2469965CA3B320B4D9716905F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
 <20211213035223.772700-16-evan.quan@amd.com>
In-Reply-To: <20211213035223.772700-16-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T05:13:23Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a3892cb1-c6db-42bd-a27d-8419e4b97d9d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-13T05:14:55Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d0581c9a-2332-4518-95d2-8f469e9e42c1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91548c74-b291-4a62-ce82-08d9bdf7823e
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_
x-microsoft-antispam-prvs: <DM6PR12MB45169F8AC862E8C627615A92F1749@DM6PR12MB4516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: heRO6RtzXJgCN/PmdRIxnq9Ax+mcDOQaaJLcLfIwuwgvEEIzT9d5YoSEUmexlQ5AdxXqENiPLIZF+LnxV8CjuWsIFj8lySTAG3Mf0/P5H1DP1nBow32nDiZ74oVyUGJsAIXN04pZgUh4gcfiF+UQPu2B9sCuBbgPiWW1lv27AHVG+pr4ovHg4n5B8/WxLCYDe5or65W1wdkMJQzPNhtskPLpVt6QOwR3KCE7RiPUTr58qnYIPwM54WgDA0AUH1fmX01Ra6APmUNuKDF4XjMTwol82C0LphxObyLWdhEo0i+rBnYmYeLL/NwVEki885nxewXO56Fr9fzVAsvWmbBue0mUbXcYViD2muAKqCM4mnew9RyvVxwaBn3SLufFgTqMsRgPn8g/lGQRSyGmfJBDxc8j+xnU5geaakhzPGJtyZYOfKlH4ZLjD37r4fHlloOz1RFeOBIg5SwpK1AdQDrPGm7Nrf//PbkP3z2RNF6RIsHR7sp8LqBfAphNqcYz/hu0qwTDh50gALxK1cHypXRtrtdzuFtA8O+H4avVBsZ8dY9AZw/XZOBfKg8c+/6OXv3K/a7k6D2aW21PjW0F7exdwhoQv5X6HdZNGnO2LOTeDPu0wP4ILw86pSiDqN1Lki3tFYPNM6rpNL85Pm8JogWVcbVIChu9XE+qw+DhL/m8CzS7P3/uYr3iw9UgfuPQW7K38KrBPKCiZXxJ9nfBV+Z1wg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66946007)(9686003)(4326008)(71200400001)(66446008)(38070700005)(66476007)(7696005)(64756008)(186003)(54906003)(26005)(5660300002)(110136005)(316002)(76116006)(508600001)(33656002)(30864003)(2906002)(8936002)(52536014)(53546011)(8676002)(6506007)(122000001)(83380400001)(38100700002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gzkRRPnYrQR1x5+7jnpK35mHXtSNBncBW6dP6x8nD90L44Dv27lO9W+cl45l?=
 =?us-ascii?Q?qRV1I54SjaSD322TzyvicGPDLIPBQObxwV3exrYbUBWGt2dKPruWiQTJOzIQ?=
 =?us-ascii?Q?o+hXsmTJOhUpxWQC/6YBsY1IuujdeIZXqifyNJ8TY5CyR5gLA20dGYIeOQYC?=
 =?us-ascii?Q?Zo6/QZTUfTw6/WiuHJB+4EHmDmbQIi2gjYBEYtXCExmQ6QEdzxAiS7GWotkF?=
 =?us-ascii?Q?mm2egHC1xDsY0PrpK6Q+j+ZVrOgTPXOzToDzNpVVXo4a+i9aWIv9bfIbj/qU?=
 =?us-ascii?Q?ehM2/csTVa7Ix1qXxsdtZt5cLILv0urO8vg/UPbArjmhFr5E4XDFyHMZ9y1Q?=
 =?us-ascii?Q?xLp/WpPSTfq/PH8ngh5f8TzTwrDzeJoqjwgZFitvWp6NGsAa+oOCxcNHe5Q4?=
 =?us-ascii?Q?Oudf2AGzN7aTfomOXPb53mpH7mfjMbNigFDfCWAgsXdHeXgmIqeSwWPjr2pQ?=
 =?us-ascii?Q?Py3GZyYIO/qVq+derw03e2o9OA8kasKJxz8BG/h/2TTaNirayVW2KcCyJIF6?=
 =?us-ascii?Q?qoSNTpnTuGrDfoqQqYLBuLcSGm1Ei78MeSiQbLUohdrdo0kVgnueMVckv14c?=
 =?us-ascii?Q?bwR8oJgXwFo3ga3L7rmih7gpwfffdPpKC7Ly7LvrYv+Qa11G9k1mqzzU3x95?=
 =?us-ascii?Q?P1TqNVsHOqkCpYEALX//F22D3z/tbk/mXtgg8kFn2+9jfx3w1oIwSqyn/BhW?=
 =?us-ascii?Q?BHDTPL7/zcwt8NRhhuLv4aCWwZGKSMeSurSm0O//dsxpFRDKWztCaHuTXlXN?=
 =?us-ascii?Q?zxcs0a+9iAERMMZAZpvwUTJeJ1xVXsk4/frGMt2sLavSebj6r+CmIFzaKgxg?=
 =?us-ascii?Q?Ysv9OoEfW8NGSgR4GWAxZsSWKWU0aYTXgGHgAKZu1MFtnR1k33lw+A/2j451?=
 =?us-ascii?Q?czk/yL66y0DXGkbH/dnlbRe0L5RHoV0vSnBgUQElwUM+0KcYKEFqnvCzv4zE?=
 =?us-ascii?Q?C7WaUSYRMusrz7GED7pB/ewcO+Kj80QFBH52PYI1jGSMUhWxcBFDS66yy25f?=
 =?us-ascii?Q?gnJaUJi3VzcAJaZRiOA89RYn/tBZCv5QBX/Xz0GhKb1EY6HpQfFb3vAAk+1S?=
 =?us-ascii?Q?zr1D8uqDehYVLc1XY0Rhy9K0WsfmW6nvUbymGURkaImyS5gCSS00FUcI63S4?=
 =?us-ascii?Q?4pEa6iRPko82/KUMAgwPmk1Cfv42AD6NDZug+D02B4rUmn+eX8QxRukXdjg6?=
 =?us-ascii?Q?/dHeFz3n6PJuYNk2iuWqJdox6KmSN4e/UEAGxrunS60+2DbodbKZ3jVSUhFc?=
 =?us-ascii?Q?HJuJ5ZSqZjHi3lLBPk8SeakvphUlHPGgB96h7HjbufHq7fBGf2OZzf25RNCT?=
 =?us-ascii?Q?gH2lOIk8NAgK8yVfmP1xoby/Mn/OmmYm1CMACsnPc+zneDKt+La6HqDc3sr9?=
 =?us-ascii?Q?/wVUa/xHk/gSNP6h7pIeLW+QZk/A0X4spTFZT5iicFGeXBYu7nGlD2GJC9SR?=
 =?us-ascii?Q?Bic/rmlHEf6n1F6mi7XLUk3Habp0ux9C9j0D0eSyS9EWa0EJAnSjhOskkAiJ?=
 =?us-ascii?Q?YqcOh18HVLqfGZH+Xpirx++KwDiYIp9pVneh1h4LNjk6Z1XX59AbMM+VLQGr?=
 =?us-ascii?Q?5Gmgla6fKg16TZj6u0uM5jEeMDRNr+n2tJjfhBO5XhvaTOJJfVnbSibU4TMx?=
 =?us-ascii?Q?4nuOAE7KTxUl5bI1uDUImQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91548c74-b291-4a62-ce82-08d9bdf7823e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 05:14:58.8268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQhzGgj8TuIqVA6OY3tavd5mmnHf3guBDDgs8lxqPqAwGb4hi3CXKi5wGSoyp6NeX5phhWQF/JgKlZKs+SyYEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

A coding style nitpick.

	int ret =3D 0;
+	uint32_t profile_mode_mask =3D AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;

It's better to declare short variable at the end. So pls move "int ret =3D =
0;" after profile_mode_mask.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Monday, December 13, 2021 11:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH V5 15/16] drm/amd/pm: revise the performance level setting =
APIs

Avoid cross callings which make lock protection enforcement on amdgpu_dpm_f=
orce_performance_level() impossible.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ie658140f40ab906ce2ec47576a086062b61076a6
--
v1->v2:
  - drop unused enable_umd_pstate callback(Lijo)
---
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 29 ++++++++++++++++---
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 17 ++++++-----
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 --------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 15 ----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 6 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index f57a1478f0fe..fb6ad56ad6f1 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -268,7 +268,6 @@ enum amd_dpm_forced_level;
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
- * @enable_umd_pstate: enable UMD powerstate
  *
  * These hooks provide an interface for controlling the operational state
  * of IP blocks. After acquiring a list of IP blocks for the GPU in use, @=
@ -299,7 +298,6 @@ struct amd_ip_funcs {
 	int (*set_powergating_state)(void *handle,
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u32 *flags);
-	int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
 };
=20
=20
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index ce80430c0eb6..106f6ee955f4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -301,6 +301,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_=
level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	enum amd_dpm_forced_level current_level;
 	int ret =3D 0;
+	uint32_t profile_mode_mask =3D AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
=20
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -354,10 +358,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_=
level(struct device *dev,
 	}
=20
 	/* profile_exit setting is valid only when current mode is in profile mod=
e */
-	if (!(current_level & (AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)) &&
+	if (!(current_level & profile_mode_mask) &&
 	    (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
 		pr_err("Currently not in any profile mode!\n");
 		pm_runtime_mark_last_busy(ddev->dev);
@@ -365,6 +366,26 @@ static ssize_t amdgpu_set_power_dpm_force_performance_=
level(struct device *dev,
 		return -EINVAL;
 	}
=20
+	if (!(current_level & profile_mode_mask) &&
+	      (level & profile_mode_mask)) {
+		/* enter UMD Pstate */
+		amdgpu_device_ip_set_powergating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_clockgating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_CG_STATE_UNGATE);
+	} else if ((current_level & profile_mode_mask) &&
+		    !(level & profile_mode_mask)) {
+		/* exit UMD Pstate */
+		amdgpu_device_ip_set_clockgating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (amdgpu_dpm_force_performance_level(adev, level)) {
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/d=
rm/amd/pm/legacy-dpm/legacy_dpm.c
index 3c6ee493e410..9613c6181c17 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -953,6 +953,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(st=
ruct amdgpu_device *adev,
=20
 static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev=
)  {
+	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
 	struct amdgpu_ps *ps;
 	enum amd_pm_state_type dpm_state;
 	int ret;
@@ -976,7 +977,7 @@ static int amdgpu_dpm_change_power_state_locked(struct =
amdgpu_device *adev)
 	else
 		return -EINVAL;
=20
-	if (amdgpu_dpm =3D=3D 1 && adev->powerplay.pp_funcs->print_power_state) {
+	if (amdgpu_dpm =3D=3D 1 && pp_funcs->print_power_state) {
 		printk("switching from power state:\n");
 		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
 		printk("switching to power state:\n"); @@ -985,14 +986,14 @@ static int =
amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
=20
 	/* update whether vce is active */
 	ps->vce_active =3D adev->pm.dpm.vce_active;
-	if (adev->powerplay.pp_funcs->display_configuration_changed)
+	if (pp_funcs->display_configuration_changed)
 		amdgpu_dpm_display_configuration_changed(adev);
=20
 	ret =3D amdgpu_dpm_pre_set_power_state(adev);
 	if (ret)
 		return ret;
=20
-	if (adev->powerplay.pp_funcs->check_state_equal) {
+	if (pp_funcs->check_state_equal) {
 		if (0 !=3D amdgpu_dpm_check_state_equal(adev, adev->pm.dpm.current_ps, a=
dev->pm.dpm.requested_ps, &equal))
 			equal =3D false;
 	}
@@ -1000,24 +1001,24 @@ static int amdgpu_dpm_change_power_state_locked(str=
uct amdgpu_device *adev)
 	if (equal)
 		return 0;
=20
-	if (adev->powerplay.pp_funcs->set_power_state)
-		adev->powerplay.pp_funcs->set_power_state(adev->powerplay.pp_handle);
+	if (pp_funcs->set_power_state)
+		pp_funcs->set_power_state(adev->powerplay.pp_handle);
=20
 	amdgpu_dpm_post_set_power_state(adev);
=20
 	adev->pm.dpm.current_active_crtcs =3D adev->pm.dpm.new_active_crtcs;
 	adev->pm.dpm.current_active_crtc_count =3D adev->pm.dpm.new_active_crtc_c=
ount;
=20
-	if (adev->powerplay.pp_funcs->force_performance_level) {
+	if (pp_funcs->force_performance_level) {
 		if (adev->pm.dpm.thermal_active) {
 			enum amd_dpm_forced_level level =3D adev->pm.dpm.forced_level;
 			/* force low perf level for thermal */
-			amdgpu_dpm_force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
+			pp_funcs->force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
 			/* save the user's level */
 			adev->pm.dpm.forced_level =3D level;
 		} else {
 			/* otherwise, user selected level */
-			amdgpu_dpm_force_performance_level(adev, adev->pm.dpm.forced_level);
+			pp_funcs->force_performance_level(adev, adev->pm.dpm.forced_level);
 		}
 	}
=20
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c
index d57d5c28c013..5a14ddd3ef05 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -323,12 +323,6 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwm=
gr,
 		if (*level & profile_mode_mask) {
 			hwmgr->saved_dpm_level =3D hwmgr->dpm_level;
 			hwmgr->en_umd_pstate =3D true;
-			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_PG_STATE_UNGATE);
-			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-						AMD_IP_BLOCK_TYPE_GFX,
-						AMD_CG_STATE_UNGATE);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/ @@ -336,12 +330,6 @@ =
static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
 			if (*level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level =3D hwmgr->saved_dpm_level;
 			hwmgr->en_umd_pstate =3D false;
-			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_CG_STATE_GATE);
-			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_PG_STATE_GATE);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index b5fbad92738b..29f521854796 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1674,14 +1674,7 @@ static int smu_enable_umd_pstate(void *handle,
 		/* enter umd pstate, save current level, disable gfx cg*/
 		if (*level & profile_mode_mask) {
 			smu_dpm_ctx->saved_dpm_level =3D smu_dpm_ctx->dpm_level;
-			smu_dpm_ctx->enable_umd_pstate =3D true;
 			smu_gpo_control(smu, false);
-			amdgpu_device_ip_set_powergating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_PG_STATE_UNGATE);
-			amdgpu_device_ip_set_clockgating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_CG_STATE_UNGATE);
 			smu_gfx_ulv_control(smu, false);
 			smu_deep_sleep_control(smu, false);
 			amdgpu_asic_update_umd_stable_pstate(smu->adev, true); @@ -1691,16 +168=
4,9 @@ static int smu_enable_umd_pstate(void *handle,
 		if (!(*level & profile_mode_mask)) {
 			if (*level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level =3D smu_dpm_ctx->saved_dpm_level;
-			smu_dpm_ctx->enable_umd_pstate =3D false;
 			amdgpu_asic_update_umd_stable_pstate(smu->adev, false);
 			smu_deep_sleep_control(smu, true);
 			smu_gfx_ulv_control(smu, true);
-			amdgpu_device_ip_set_clockgating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_CG_STATE_GATE);
-			amdgpu_device_ip_set_powergating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_PG_STATE_GATE);
 			smu_gpo_control(smu, true);
 		}
 	}
@@ -2146,7 +2132,6 @@ const struct amd_ip_funcs smu_ip_funcs =3D {
 	.soft_reset =3D NULL,
 	.set_clockgating_state =3D smu_set_clockgating_state,
 	.set_powergating_state =3D smu_set_powergating_state,
-	.enable_umd_pstate =3D smu_enable_umd_pstate,
 };
=20
 const struct amdgpu_ip_block_version smu_v11_0_ip_block =3D diff --git a/d=
rivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu=
/inc/amdgpu_smu.h
index 9d4a85c39ad2..778196167de2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -363,7 +363,6 @@ struct smu_dpm_context {
 	uint32_t dpm_context_size;
 	void *dpm_context;
 	void *golden_dpm_context;
-	bool enable_umd_pstate;
 	enum amd_dpm_forced_level dpm_level;
 	enum amd_dpm_forced_level saved_dpm_level;
 	enum amd_dpm_forced_level requested_dpm_level;
--
2.29.0
