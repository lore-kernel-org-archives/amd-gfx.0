Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203DDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 02:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E4E310E02A;
	Mon, 28 Mar 2022 02:17:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9F210E02A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 02:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLOiFStzajQw7gjWTjdV6Pi8bWEsyNWvWziIk1NUACwn9ILYNyJprW3DYMcd6E5kC5TFHirC1uvE7j8cAWYP/aFFFNkU8DUj64/cBas+MWdGaYUu92akBJcoUkMhhzNJXPq6TpXPrM6ZccoqEzf4P2QD8+hVaHAGWr/sXkMgH8cuuNV5spaxHNqlbEy5IN1wA7L6v5qi1on6waiIG3qxYngI2CMBCjeic09Xe7NGDVV9979pK5qzSA8WNFZCRLCmyVasvxOO4aCWqz69VebPnEsCYWIR/ZcOIf1hrS7EjUe2TrgDQgEhMF6ZL1SiZ5FcEkmohce4THMqrrXn7PtZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShXJ+r0YuzJf2TzU8/T2vgDZaA5xBLPmAvthbu1nNKA=;
 b=DEYq+dVgxX3br5Tz1u3U0ignE4Lrsk57wS4PTydgh1gV9OY4bqrPag/t6g6LG7T1eDgPXvBAxQW8eGjz7c9gYmK+k8A82ZhjnB/REqdfXk/K3Mw86CMCkXw2pOYyvcMEtxB4tPt/YB/mrcRqQXWA9r6JBYvjj0pgjhNbFVEYNusT2FWWuE04Gl/KXuqA8xIY1Ge1L0Qw4T1oq3ovkmpw9mZa9X+D9ivHX4uYcJ53zjPCivRZR8dyZSNrWISEPFBpDDTLnEA8475arkFy61SG5E3G9DF6rw9lztjYqktQnSFsUO6EW5uPkCKwvlwZSkI12KzkDJfCk4wt/KgjHz6RoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShXJ+r0YuzJf2TzU8/T2vgDZaA5xBLPmAvthbu1nNKA=;
 b=LKtTx1NoZQfSVTA2wNkCj1ob5o+el6HzcY/u5fYx4xoTHAoK8xYyFYBIn4+KJKPVeE26r+LMdUQcMyfsTHkLsJf/qVwbW02oPQW5Zjj/BUtRTZdohTwN3Ckh2l1RUvzYvKaSFwA/fvHPv+I9LnoAu1tyC6zyxR2gS1pFum9mZMs=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 02:17:29 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd89:5054:25de:2942]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd89:5054:25de:2942%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 02:17:29 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Yin, Tianci (Rico)"
 <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Topic: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Index: AQHYQcx5XDW17ZrXr0mvlVZY1KuRWqzUAdiAgAAOGWA=
Date: Mon, 28 Mar 2022 02:17:29 +0000
Message-ID: <DM5PR12MB2469B027D59B5151A41075EDF11D9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220327111857.1372675-1-tianci.yin@amd.com>
 <DM5PR12MB2469F8E803B628080BD1A247F11D9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469F8E803B628080BD1A247F11D9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3213d836-bb7e-4714-86b3-08da10611c2d
x-ms-traffictypediagnostic: SJ0PR12MB5501:EE_
x-microsoft-antispam-prvs: <SJ0PR12MB550117A68AF3049F3A8A20A4F11D9@SJ0PR12MB5501.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzZucYZ6YregSBNK4O5zFAzDbYiKQ2X3w3orC7R47S4jppFbrj+wxPvoub3G/PFoUJ5OdJbFdMqFO7wGUFXdPhxcXW5KuSiVxQYbSu0lsF7g7yEYp/ZTptr74ixmA0ccMMZAEqLoVg97jdLgsLiZQoN316NXL2TFPE9mUfwqnOu4YvOGXTO5t3fx2Vy2sjTOgRk34DUBIvRDCNiwJF+PNeKeV8jwkfif9smUu5r/jtISJFZjbD/EDlXWIrS/Vb9qQp1W0a8rz26wvLC+/Wo72KPuWFjLx5ZqrFofMVoNRzjVYQSRKPrMRy3z3Ry5CPjdS4Oy0DFrtwZMOFre/sXpJGAHVOHzOpbkkMkWfuWdX12vUgYfqoBLFmB1NjF6VXb0YjqLOMrrYo6wEqbZj7FIq9gxzoP7OgYeq3LXqXis8F/0MUeESQYgp0fD3UUecRJbXXwHD12yH1JerBxsa+29A/VpXaFzqa9Rl1zqx2XKvYyc4/O1rTGx8y0UW6nvlXFKksHvB3ATLFCwzIdH8I2IAkEmL/btATu1u/BGuWAYLGtAULh22Q4vA5akk1fOjiLbLxUzOGPU4Ysp/fNsFv3PJ8qhHNFvoXrcPDCmBYmXk+EwkkrFnO2uJ+dl+DwoOOrTLVtNpZII306sn2cSSPL5a6DdxPF18wZ/Ryr1g6q0AcI8YxDkXPFzlS6FlcFkGv4JVyo69zKxD6HBLLx4vGxq2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(9686003)(5660300002)(38070700005)(4326008)(2906002)(33656002)(83380400001)(38100700002)(2940100002)(52536014)(53546011)(6506007)(55016003)(7696005)(54906003)(110136005)(8936002)(122000001)(26005)(508600001)(186003)(86362001)(316002)(76116006)(66476007)(66946007)(8676002)(66556008)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MHwyRN6bo4Yxt7u2JnUHWCmF6N9QKVfHYiclOrR4/K6Ty9im8LJrWatLR93g?=
 =?us-ascii?Q?D6qMabxeKtjmiM9lxsNeFCYyT9rZ47oqQXEBZ9Q1P7/QnSf42nhHIfq8Js+v?=
 =?us-ascii?Q?3A6LkITn/ncB/7TYMhpgdLG58EMGPlEkVHBYYVQ0t7GRfWN6sdkY8Jeb72j/?=
 =?us-ascii?Q?5FMQiLLcQfwIJ2EhTIigREaZVyW+qsF+/twhOsyiJvUwb8JMolL7BAZQpBN9?=
 =?us-ascii?Q?cx25GSIGZtHngYXI1R+nZkaraDQMmmPpXIXKKAURb+8SOiV1EeqfDA8B4CL5?=
 =?us-ascii?Q?1N58evCu7aV87WnQIIXqszVZza6xec+dt/kF1IY9zQhQe95RU27g0utlYOkV?=
 =?us-ascii?Q?nfbpxdMdChY3nzsftcCHlh8ZoO2PupWgfMtc22IY+pLhx6AvqyF4si4EEivZ?=
 =?us-ascii?Q?V3tkEzXbFIj6Eb/O2Hl/B8MwhkBU4j7RJe2lE6CkR+qe7bU+PsMMwzw2fS1E?=
 =?us-ascii?Q?cDQ+ehEjpYHkD3d70kxz6gM7AVhjIqEkntNixTRElYbgkIJ3qiCoun7Q1yHX?=
 =?us-ascii?Q?RVEqg9+yG8T7xJCc1/hwQrZCWMQal5B01AeeooQ0MffOMywyKXy1R+twSFLl?=
 =?us-ascii?Q?OdzKLfBQKTPeyunK8aIommySKgJp06jPiHkw8nkXsz3Eupsd0nI9+R2ptMMt?=
 =?us-ascii?Q?VykqKDH5BPwP1w1TQKVwrtU5nbMk2k3XC4jZj54aDOmMwp3qNpKsBEd6VWJu?=
 =?us-ascii?Q?qPyZMTaR+gihF1Mv9CXR3Npyhc6XZsGzPnuI/6zDliuYi/hSeJ6Thd/szlLG?=
 =?us-ascii?Q?p5mDTuRZQYVfbg910TLjwrAgX2XWQ2JTCANWW/w4XfRQPT/HPyHziDrS+RRM?=
 =?us-ascii?Q?nUutCBoKOWqQ1PS0qYtAvYFUswLcZ61ac0MCStxyPI4FMnAIkl+GTWXtn7CP?=
 =?us-ascii?Q?HfYh1aBJ+fmoQ1hFdLCC5K50Yft5JTKH+gWCskkgA0GQfLrQ1LiThQ6KGiyC?=
 =?us-ascii?Q?mPGL6dCZ1DfQ2BnVNBxNqKJEnfPuO3cXMSgt4rUVjdYLin/MuzVw6Xk7tDum?=
 =?us-ascii?Q?a2oybYbo548eoJh41IIKSkNBkXnqDA7L3jRVMjjj5m2o8vA4DAmYcl/o2NIu?=
 =?us-ascii?Q?6XNNlLkFGqAkwv0YiAVoLtug54dXeWP4kjRAf3GaotZ9Hhsqv6b+DhtnO6oP?=
 =?us-ascii?Q?nNAMF2CKT9DhWJ2dxPVfhErCVoHtzXCE3pixWJZT2PHRiLqQqojUSwuzedRM?=
 =?us-ascii?Q?Qf8yUlJR43VWFpMwvNsyTD/jcsSBjM7SR0hnPlrBKm60IkPh/4nJg+bo3kHb?=
 =?us-ascii?Q?HF5Mz1rvloRgtWM+HmSQAw0QsFP4bQGB1n9Dyq2sgXVbLXCZCwvDBRLuUXdB?=
 =?us-ascii?Q?p4Ff7/M7e0gTYBZzfUD+P+b7X5ayeXiVXzqquxvwquemRJtcC+3S7y1SixXj?=
 =?us-ascii?Q?yFv39MGq+4zU8AtWDl1EYovr3nmTicle5wlGM2V9J+PfsdrGcdOXr1jR6ifU?=
 =?us-ascii?Q?7HbbkyOP2haOUhV6RsMeo6xoJmWGgnixA/3l5Dpy1xX7/oaQfjeeg5QUhGQ1?=
 =?us-ascii?Q?2ozHWbSUOXoqNMWecK0OuDL+PRdTL8560HeJoXk6CQhF+PwkKMq7rTAM+X7b?=
 =?us-ascii?Q?TPhn9u9SPtK/USio0x2q1VR0UKd6q4cWwXPi5W08TpGZzdD0PqQWOoCt3L1Q?=
 =?us-ascii?Q?dIURvohkDDUsgVafelqPcETsvZz+f/jgFNZ1HNvrO2tjO26TTabsnicKbNAh?=
 =?us-ascii?Q?u3lEQ4iRsjvgUyJNAMsNHKkUZa2rf8jAmI0Kg2r/D+5/mUR2fLkbYbD684Go?=
 =?us-ascii?Q?97nAar5+jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3213d836-bb7e-4714-86b3-08da10611c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 02:17:29.3527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkKcsAU9gTHQ09oNJy31n5zY7psaE29tjUD3ng47hPBn+4YULKTXwbYciuF6UYqzFaVdmAN3CPqw0wD6O46l6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Tianci,

I think we shall improve the subject a bit like "drm/amdgpu: fix incorrect =
instance id passing when stopping dpg mode". How do you think?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Gu=
chun
Sent: Monday, March 28, 2022 9:26 AM
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wang, Yu (Charlie) <Yu.Wang4@amd.com>; Zhu, James <James.Zhu@amd.com>; =
Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: RE: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com>=20
Sent: Sunday, March 27, 2022 7:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhu, James <James.Zhu@amd.com>; Wan=
g, Yu (Charlie) <Yu.Wang4@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0

From: tiancyin <tianci.yin@amd.com>

Some video card has more than one vcn instance, passing 0 to vcn_v3_0_pause=
_dpg_mode is incorrect.

Error msg:
Register(1) [mmUVD_POWER_STATUS] failed to reach value
0x00000001 !=3D 0x00000002

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index e1cca0a10653..cb5f0a12333f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_devic=
e *adev, int inst_idx)
 	struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
=20
-	vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+	vcn_v3_0_pause_dpg_mode(adev, inst_idx, &state);
=20
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
--
2.25.1

