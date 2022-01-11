Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9205C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 04:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73280113918;
	Tue, 11 Jan 2022 04:15:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572D911390D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 04:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2lTUxYiUDrJGuMNs1FzhT6qejEd4DTksmREFiLz1Pxu2876pQhOT9y8t0nm5CJKHoIdib4jGdUWpWm63QBjjsCpElOsiZpCmomhSjk/MgRBnAK2+mS3EmCfduynMa8KQAemFpMYVcv4NGf6rbppdKxFgPPXhbCDe2rTM/25P4sXJLIMAN8DD8jXwPSc1YPxh+rZ4SAaiQqyJptfe3PGc9F5uqonwLU1bkQBys0EHKCcth5qleMpxWtIDAwDAZiKoeDQhPpShVi606+jN1ucAYHygvTBnQjjJVI/wSw0fll+dJYWhrW1PPaPsihOMse4ChJZV6JygIDBsCJeexW4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHSLIIrMkcPIeZCvYb7Z/JPs/RW9hJY2hRda+x01gF8=;
 b=OVkqg/wUIwS/NOYJAt1BTmiNFQKp69Ma1IL8HUKgA3+MrrXULx1dkM8SH1oN9rbKfTNcVH/z4hCGXwSZOaAQcfbNyaMyv9DCet4Adbf9tehce13ptTLk/X0+U0cvP6FlFXhV9BxS0IV6I86sJGuNrrwjyThsgxMZwWQ65553GVZerjaDRk9QUCmeA351CSQeOxxdOh9vVZnByG9PvMpIl0p2xxQRXdxPOHFvme60Mkk57csIPuZGM3xUaW3GSZeMAHL50MBFXzrNFkq+xbzuV8kiG1c1jzLDXSJHxOecWw8bM5Hu/dbLcbxoljrZlm8pddY2TSPmOA5GWSstAsuHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHSLIIrMkcPIeZCvYb7Z/JPs/RW9hJY2hRda+x01gF8=;
 b=5GERweQlkS5NU0Rye8jsiFcVhtzuBUuuPITbn7ES9cmhVMFr3m0pgJ2uTgIG7L+kdemiVS1UzvSUai+TnKAjIDWGHBhz4aNWthE1qNvaQ+bGNH6psmAC2LuhajGyEV8TiWs8wBIJY3vfQy8u2rrbP+7N8pjvzPUpzetOM+M2Cmc=
Received: from BN6PR12MB1171.namprd12.prod.outlook.com (2603:10b6:404:1b::21)
 by BN7PR12MB2641.namprd12.prod.outlook.com (2603:10b6:408:30::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 04:14:59 +0000
Received: from BN6PR12MB1171.namprd12.prod.outlook.com
 ([fe80::9a4:2eaa:6ef:c35c]) by BN6PR12MB1171.namprd12.prod.outlook.com
 ([fe80::9a4:2eaa:6ef:c35c%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:14:58 +0000
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Huang, Qiliang (Warden)"
 <Qiliang.Huang@amd.com>, "Zhang, Bokun" <Bokun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
Thread-Topic: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
Thread-Index: AQHYBeDhd4c0iNDegEuh1qV6ayG/NaxcZP3QgAC+HwCAABRqMA==
Date: Tue, 11 Jan 2022 04:14:58 +0000
Message-ID: <BN6PR12MB117150C4256F9AEB126ACC83FE519@BN6PR12MB1171.namprd12.prod.outlook.com>
References: <20220110051344.29134-1-guchun.chen@amd.com>
 <BN6PR12MB117124D8D3DAE8FA8B75464BFE509@BN6PR12MB1171.namprd12.prod.outlook.com>
 <BL0PR12MB2465BDB9A4785355D6B2738EF1519@BL0PR12MB2465.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2465BDB9A4785355D6B2738EF1519@BL0PR12MB2465.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-11T02:57:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=53ba233b-17aa-49b2-a55d-f85bf1e2f310;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83ec73cf-b2a9-44c3-741c-08d9d4b8ee61
x-ms-traffictypediagnostic: BN7PR12MB2641:EE_
x-microsoft-antispam-prvs: <BN7PR12MB26410BACE7E5698B60C0A8AFFE519@BN7PR12MB2641.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YalsIy+sCLU94gwpG1HwUU2QLJ0pFOheTSdbNmQs968p2UummlFyHY6s7B3X9f8Oqd9FSfh+tjw1MrIBF7TlA5Fi6IGncNWU9bxobVeJcaAgayekNFkAyV1N8k725Yd+D7tfVNQwPaDonGBJAIObKan8AYb8daHykCBg+e4S6Nx+E+oDQG2j5B2fLTwk5+adXMHT0gaw9XgCdrbMxjdWkxhCk/5b8aDW5NdcbJ1WvzGbwvxnjgOMSqm/YbSIwAvCtp+AZJ0OVVSR799q0WR2TNpYfP5s8LNHaCsav389IygdgYp6idssA82BC3kocTWPHa1kODhX3dy7MtqrAbUZ/CQLLDrk+l702irqplqsQR1lAeZcZnndJVmXWquDq8unC/H2o8+k8i1bfnp03jtTVfQcuGxpfhkO66v5q9Jn4657sj2D+xLOvbzvtPk168j2sLJyxaY0LLfsjfZ8mKk8P+DcUcLbShUt8sQU2lk69fD4QITyWf5sO3nTNxYR/zc93boldAC+6za48hREZFIAyZEeExT/w0fKF5rSl8wedmb9cjr9zsGPhd2Y3iSOKn6rtblcJqs0MNb9kqEarugaGOYRpme/acYRKRjS26jtlsD2WTNJqTYq+9h67x9YZ/WnM+XPn5EbiClHhxDNadOkRDPiXKHMcYZJlQglsYsAobSP+cNWADLi4MSMdfMS7LjWVG1dSb6L1LvQsCATnon+nEELkWEBYC+fwCi6Z/IHtY8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1171.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(52536014)(26005)(66946007)(921005)(8676002)(186003)(55016003)(6636002)(316002)(122000001)(38100700002)(86362001)(9686003)(7696005)(110136005)(53546011)(508600001)(6506007)(71200400001)(66446008)(76116006)(66476007)(8936002)(66556008)(64756008)(2906002)(38070700005)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dJ/2uvP0RIXP1lfeuEyZm2Dru/laJzzhKFhmcu8M+bCWCV+kO+TXgoeNXCSB?=
 =?us-ascii?Q?o5K3xclrN/likKU4OaUrHUDouvOKuuoIe2hpj8Dhbx8OT001wdUzAZbYBzZs?=
 =?us-ascii?Q?6rCtrQ8EeFJmTmrRmWZZz9rpy6HlgVVjrqaLLkA7AbtQyZ8si+sstNh2VCxh?=
 =?us-ascii?Q?vf0d3PtqRl30mm1MRX01DZyXPKWOhFNW6xXA8MOpnPXD9dUuEdXvjZoDC+eE?=
 =?us-ascii?Q?Fry+s1N7AECVi+1moRPsOE5wCz426U6ObhRg/uNyam5UKtK0NkYKnL4hggFA?=
 =?us-ascii?Q?akzJUZzkI9OqM09kG2Ohv0tYO91VyCTnDOnJlzvlaJJpdUWFafv/VAI8p5/e?=
 =?us-ascii?Q?WJ6x7pUuKmGIVmLarMSszVmJ2duvo/3AbWnBLMoL6xJGbePeLbCZ9qS6wjYv?=
 =?us-ascii?Q?wfCh5tcqIQChbajrRjR0J4zdG4/WiIJsLurBtBsLzu5xC+/gHmxabtlXXQK9?=
 =?us-ascii?Q?FLk9VXf8fUpeEh7nNeoyAvor3l4LkOesebbRL9b+5aq3tdVyR+k7QE/ocM45?=
 =?us-ascii?Q?dMIRGPKcvQtnKGiKZy/9lW4QZppn4LGztsfQQPDhTF42A/pifbmz9iICWrC7?=
 =?us-ascii?Q?BmWu5OK2tXmTPsuefiGUbzqzewAogQXbsaTgT/RxDID9P+xfh7ZBZUbSGjDu?=
 =?us-ascii?Q?xVqv4IhqEZRxxu6WOFzNSb0RyP383YuZZ5f1C+1nyV8u8NB8JVcAooiz0+qK?=
 =?us-ascii?Q?kXhYImd1X32/B5ICadTGcH0Hx25x990tq8WzkgnP0RXNsJFsTpEjeP17ASYc?=
 =?us-ascii?Q?b0rr7uNn/bLI0/dGenqhuHuO+jnrQPxb7WfJL3nm3v8E+gptDKwX37GU8lDO?=
 =?us-ascii?Q?REe79vgC3+vIOpaTG9ZGvZbAz2ibHKSk76N4ekOAR1VkKcT+kGWuyqEGI/xV?=
 =?us-ascii?Q?MmgyY0uuT02ML8j9Opb41HUmW0HvQWC8NkiGruvPY9Ok9oRDFFdRN+n0DfOV?=
 =?us-ascii?Q?uJuMbJ4cF7Ww2x7ZDDM0wnqK6racX7D/DqxpwsIWy3YCYkzEoNxu7WTSdpFq?=
 =?us-ascii?Q?X+U91zKG3C42w0/HmgSD6nwee+FCcH+xmnRs2qoxEAmGUYi5a89pHiTX1UIh?=
 =?us-ascii?Q?Isq51HK2B+5IFunt892BOi7FJbyEQVa3pj1vGLux+W3jlfFSKAu4yyoBfGy9?=
 =?us-ascii?Q?DeFTRolpFstxo1nNlzQXtgYfNCLiwW4zAgABQUA2Jx2zuiCAEJo/PPKoIeSN?=
 =?us-ascii?Q?boly+PzwcpMfPjqAeAnVLlmz4GMIfyHN5GFvFvcKQ/wK2DY5skI8ryU53i4D?=
 =?us-ascii?Q?6qw4zZZa+tOF0ZjrNIgUpgnJmvUvuhpOusnnXdNgwF05iQOXedRTaQllxwx1?=
 =?us-ascii?Q?AdJW+OaR5h1dHjw2W0F0R57WlIQ08Sv0PeCenY1xnWQyhV5MyVPgQU5fAvIe?=
 =?us-ascii?Q?LhxADl57Bmp4KZ3i0uTvqefXyz1jG2yLUB2McxDnOvzH8nN3m7oF0F2lVpDt?=
 =?us-ascii?Q?u2AcxNU/nt6zGY5hbCoMEERGADrdaRyZMPU0o5mAVjOnhkcORaSe8NL5Upn8?=
 =?us-ascii?Q?RLs50BgJWlznPseLmzySbwVMjOvcoGeIwZszAEOPyrQ1ChoE42savP+PnJhz?=
 =?us-ascii?Q?X0YWQYG8nWYRPHdp/rqW+j+M+7lpvacDzbsoDlKn78WYepdT98YwXnwak4S+?=
 =?us-ascii?Q?cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ec73cf-b2a9-44c3-741c-08d9d4b8ee61
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 04:14:58.4790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjubVdy+kHOnJojdseOXjXeamQncSi7RP3hrjFD404LRe5oU7nQZ6vQap1qUiU0suL2JNTyNL8FLklh09fPEcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2641
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

Thanks Guchun.

Tag is okay.

Kelly

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: January 10, 2022 10:01 PM
To: Zytaruk, Kelly <Kelly.Zytaruk@amd.com>; amd-gfx@lists.freedesktop.org; =
Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Huang, Qiliang (Warden=
) <Qiliang.Huang@amd.com>; Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by=
 local interrupt

[Public]

Thanks Kelly. I will push this patch with a tag like "Tested-by: Zytaruk, K=
elly <kelly.zytaruk@amd.com>". Pls let me know if you have any concern.

Regards,
Guchun

-----Original Message-----
From: Zytaruk, Kelly <Kelly.Zytaruk@amd.com>=20
Sent: Monday, January 10, 2022 11:42 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Huang, Qiliang (Warden) <Q=
iliang.Huang@amd.com>; Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by=
 local interrupt

I can confirm that the fault no longer occurs when the patch is implemented=
.

Thanks,
Kelly

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: January 10, 2022 12:14 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.P=
an@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>; Huang, Qiliang (Warden=
) <Qiliang.Huang@amd.com>; Zhang, Bokun <Bokun.Zhang@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by loc=
al interrupt

This is observed in SRIOV case with virtual KMS as display.

_raw_spin_lock_irqsave+0x37/0x40
drm_handle_vblank+0x69/0x350 [drm]
? try_to_wake_up+0x432/0x5c0
? amdgpu_vkms_prepare_fb+0x1c0/0x1c0 [amdgpu]
drm_crtc_handle_vblank+0x17/0x20 [drm]
amdgpu_vkms_vblank_simulate+0x4d/0x80 [amdgpu]
__hrtimer_run_queues+0xfb/0x230
hrtimer_interrupt+0x109/0x220
__sysvec_apic_timer_interrupt+0x64/0xe0
asm_call_irq_on_stack+0x12/0x20

Fixes: ba5317109d0c("drm/amdgpu: create amdgpu_vkms (v4)")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 2dcc68e04e84..d99c8779b51e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -144,15 +144,16 @@ static void amdgpu_vkms_crtc_atomic_disable(struct dr=
m_crtc *crtc,  static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *c=
rtc,
 					  struct drm_atomic_state *state)
 {
+	unsigned long flags;
 	if (crtc->state->event) {
-		spin_lock(&crtc->dev->event_lock);
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
=20
 		if (drm_crtc_vblank_get(crtc) !=3D 0)
 			drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		else
 			drm_crtc_arm_vblank_event(crtc, crtc->state->event);
=20
-		spin_unlock(&crtc->dev->event_lock);
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
=20
 		crtc->state->event =3D NULL;
 	}
--
2.17.1
