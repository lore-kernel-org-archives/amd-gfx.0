Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590FAEB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 03:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAF210E60E;
	Fri, 21 Jul 2023 03:24:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A071810E60E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 03:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNLqYyH1Ycb8592JrSBDyD5pKjflaiqDtMoCtZLjvmdv0g314NfyxVr0flncaUWhq7Fxa/zH/YGJ8Y5jhi+CXLAkBATQ7wqdzn7vDnbYpeBpFtJTtb2lyFJXDTiqONjKvVAVBdq+yeMZi7YzxfK8V57iFcqkcYN8z8g+dOLpVg2liYcgx624mvlVguXN2p9mbF7JSXOzMn8OXW6LPVqYT8L/FUcA3T2VmthGxyVLVzJNQYqEZQhgefJif4O8w02A7nW+QXnC8IwvH/MvIHmnJ/j2g/7WuU8pnl6OzsDNAlwu64cqvAeoCTpZBglqhKXsiZi864F5vkYNxZrnznfO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/8pEQrh3EUpLxSjX4y+C/J350MGPL4p0EsOzyInCDE=;
 b=CuW/PACtU2/H4u6Ul/UWV39IG69sF5Yv2JHw75MjjyzO1Kcp8Ht6lSawgqfLwHDoMSzBr/E3VPTa57w/580yC8p2ir5GaILpusopfT1ZWbiMT1pZsm3ZNoiH9zVHF57lhlc2+qk+Ur8U93iskSIcyHjB9oh2311piDTdn45ee6Gms7F0oeAxrurfF/jp4P3nOe1Embd0vvDLeIDgqN+017oLPUx3euZaO9P7HH0Mphfkxk9sZZ68BYkzFoMXTz20b6rI6eWMzJeY30nc03Ergt8sP/lggDDHvboWYE7mm3N4f4SjLwwcR07REhu0zoknFFCbQV/EcnrJuod3kSUMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/8pEQrh3EUpLxSjX4y+C/J350MGPL4p0EsOzyInCDE=;
 b=oMjf8mQBfS7JCi2t9ND3sz97lePTyDISRDqHQQQ5W2QXynA7pP305W4GrC/EcASdtr/t5UuPFxUXd1OXiso53cXUU4bxCXA2wEUoMmunJhKTvw8GW8BYG66HCSXAD9kwkI57PDr78o8uc3/MdF49Tis1fqefX/tUyP2zONcUYz0=
Received: from DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) by
 CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.25; Fri, 21 Jul 2023 03:24:12 +0000
Received: from DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::4aca:b561:652f:cfac]) by DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::4aca:b561:652f:cfac%2]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 03:24:12 +0000
From: "Chang, HaiJun" <HaiJun.Chang@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: set sw state to gfxoff after SR-IOV reset
Thread-Topic: [PATCH] drm/amdgpu: set sw state to gfxoff after SR-IOV reset
Thread-Index: AQHZuiB06zvdYz0PEEyIKGd1lZylzK/DkBOw
Date: Fri, 21 Jul 2023 03:24:11 +0000
Message-ID: <DM6PR12MB49581CEB1718D9E71A9015E2813FA@DM6PR12MB4958.namprd12.prod.outlook.com>
References: <20230719090705.3263-1-horace.chen@amd.com>
In-Reply-To: <20230719090705.3263-1-horace.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4e19f3ee-4d44-4e53-bbda-a39b09ee5767;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-21T03:19:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4958:EE_|CH3PR12MB9145:EE_
x-ms-office365-filtering-correlation-id: 0f511551-28fd-45f9-744b-08db8999f40b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5yx8GLIg5ZCI/Z6CMlAlCjgEvkkezBeA+P3qwJ+XjUpO5CfjppVGThn3+3I6c+OPnVgwZTLLUqhJNuvYYC/cXpCcsP40lHGgCvsdsW9jM//I2Hf75WsQ+7wxS7t2sko/AYpEKcAKLu0rAx+x9aEeMip/41m5/c/B/o5IMd6VD6qL9C3LZrt7A4J1CcWTHQ1wRMVteAHVdscDN4xcVw4VeiD2Pz7HXBG0E6j5oY8iKrsmm1tC5caYbcN5JCySu+cWZDaM5ariclKVX2rP7IKMpOoTTUgzKeKIt/oKM+Y+kGB9JImvFwDc1nMdsrOJHAE+Yki/djKOdfGnZNEqVdmOq8LubwUeWQ4KlyCpOSTX7ZJJEH8EuG9bK4/rWmZXFAoiRJIDwlmbOk8IKp4SFtEXxevyeTjfsJclLG0vN+sRaRUtC50CufDivx7ZM4TpY9IgbEC0PZh0eQoLnTSibAeKj8l298qzkjmd92hNgd/m3ki7bSw7S0lY75PZseOxm43/+KVIe132s7gdfVDtifnKQ7Eaxt8/f4J896K+YhI6oELwBKVPNsxl3eDlzfMOJ0b6Ca30pQen2nV6IlKxBDGiHq8SL8aAb9Dil+0XHCa1eL4sSkEcaTiCA0EXAMlCeAMS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4958.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(122000001)(38100700002)(55016003)(41300700001)(6506007)(53546011)(9686003)(66446008)(66476007)(76116006)(66556008)(66946007)(316002)(71200400001)(4326008)(64756008)(7696005)(186003)(8936002)(8676002)(478600001)(54906003)(5660300002)(52536014)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FojXM6ykeYZEvv4MgM5/JOOCEXV8jUYHLzvR6fFJ8dOZmS7IhZDTfbh/vlFC?=
 =?us-ascii?Q?DFD+xwjib+EIUmvXNXizLcx2Xrmv6puxSUJ9iP6qWqfPQnNKJ4+S0TdcgRNP?=
 =?us-ascii?Q?e5jUscG4y44m6XSWyNgylZWWhA4h0jwrgQ2FrM+AIJX8qyGfnbVzkipbuhsT?=
 =?us-ascii?Q?bBPQLDJAclCAZFp9vn0ZCf2Q50fDQHyvxMu1BpqExPRYySkFxdMBgh+pVZil?=
 =?us-ascii?Q?vuWSH8WKOFSgDeSA/rTjEfF5Y6pMJbWNkM3x2zZSaKgPcp99GpMzYPOgFCKP?=
 =?us-ascii?Q?YmUpCtf4sqmlHJvkc5hWxu4Gt2kkm9v9yJkFlRefnbIqEDKyoibkubJyyk7A?=
 =?us-ascii?Q?xfkL5xBECFWV8+EAcBjUp/b7Z+s0eOOsUDpevrRlkZqsO7ctocoFhfHe3CPQ?=
 =?us-ascii?Q?2oty/1TVPK6mJxwTvjFZaEfaw5EDDJBENxNhOcRPJSbkxkHBKAQ4FujSDu3K?=
 =?us-ascii?Q?yAewEDYdPGZIlYyjS9duaEJLxqomsM12t9krY6K0Qu2D3hj1Iiu4RVFhhglS?=
 =?us-ascii?Q?AHiuqDwKTX9NynM4fbo0yLBDF7MR/+yIaRFS9T4jtLtrmB9rKauufSftgDQd?=
 =?us-ascii?Q?YlNr/XNOS9XkYdgKuX7IibQRGbKWybZhxeZY+DhzJLqQ+3UEuTJHSN3bswW7?=
 =?us-ascii?Q?MeW47sDxYCmgQQa3vy+PtwmJ9Rfz3zNhorJ60n7zDPcROgR4AVn0KAWRXdV2?=
 =?us-ascii?Q?S2ktwjzH3hLlTvJpuq8t7OppMBJpGld3FFWRdCZPT28O+kUaJNIAA0rGA+7g?=
 =?us-ascii?Q?dvoy/ZCb5BDrq0UO047uTiUEVP/H2w3Go1uEdKyriFcrErkD1FrFQ643P3j1?=
 =?us-ascii?Q?TilqMZUogQMLFp/BUAsLljBq4CwnActtHAJrnSCX4P54/fDqOqS5gxbnFT2B?=
 =?us-ascii?Q?YBFlXY/dx4hRSzrVlrczM3zWZSQ52DzBZQ+fkKbDWPKKVu/7WQNVpFUO6Wtt?=
 =?us-ascii?Q?0qBi5UsBA9pDhYu7/4Hl88tj2AFARsu4gqb85VULa+u2EbMH+YR6C3CdK20/?=
 =?us-ascii?Q?sxOJoZkldlI3MCU143+r+qUx6abQphPfQkP5OpZGducm9tO8a7XiZQpE5o/3?=
 =?us-ascii?Q?puBPpFxSMvAxNX9GMRUPIR6aQGj6L4UH9sy21AkPiFW+h2iJgNK1pClI70gb?=
 =?us-ascii?Q?akG6svC1n+7Vb9s73yn7yUrbrMXhLCuADejNykp0JwLKLtU0tjmadAYE3Qin?=
 =?us-ascii?Q?nRWqInudrB4vARIlGYbbrZuPOjl9cZtwmGr34ZVllwwoLUiWwphJaL4Mcczn?=
 =?us-ascii?Q?ZCheajHwMM2MuK57cz8IgwRz7oFg4IObmk7zvd1qSPbQGywnLJUgDqOcb1TR?=
 =?us-ascii?Q?jCh7V517ut0KTwiluiMZz0vuAEuDSMXi7UekcTraX+m+QuOqfOA5czqBm3Ok?=
 =?us-ascii?Q?pwE9cxI/ykYiaDMrCHWzLRCt4OwauU4RBtQ0Bv/DL+UsmDDi5YTKwR6ESnq8?=
 =?us-ascii?Q?UbzCZEFhm8cYgkyWY9yxwmW28K2fe4sHj/kxVWfdpePIuaY0gEx8X+79kHjR?=
 =?us-ascii?Q?NbMvv0i8LqAUeu92ZRX1rG+Y+YzWgUeKNYVEjOqfulvG+8afzvS+Fr/tcg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f511551-28fd-45f9-744b-08db8999f40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 03:24:12.0105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1PFq/VH/Z1OpBPJptYTdjvK4n5e11unbuzu5Vv1EgLWKtThYBEy9xsrOU5Q7GA9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, 
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 Leo Liu <leo.liiu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: HaiJun Chang <HaiJun.Chang@amd.com>

-----Original Message-----
From: Horace Chen <horace.chen@amd.com>
Sent: Wednesday, July 19, 2023 5:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@am=
d.com>; Chen, Horace <Horace.Chen@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <=
Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk=
.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chang, HaiJun <HaiJun.Chang@=
amd.com>; Leo Liu <leo.liiu@amd.com>
Subject: [PATCH] drm/amdgpu: set sw state to gfxoff after SR-IOV reset

[Why]
Current SR-IOV will not set GC to off state, while it is a real GC hard res=
et. Whthout GFX off flag, driver may do gfxhub invalidation before firmware=
 load and gfxhub gart enable. This operation may cause CP to become busy be=
cause GC is not in the right state for invalidation.

[How]
Add a function for SR-IOV to clean up some sw state before recover. Set
adev->gfx.is_poweron to false to prevent gfxhub invalidation before gfx
firmware autoload complete.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 28e6419023b7..1c786190a84e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4575,6 +4575,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
        if (r)
                return r;

+       /* some sw clean up VF needs to do before recover */
+       amdgpu_virt_post_reset(adev);
+
        /* Resume IP prior to SMC */
        r =3D amdgpu_device_ip_reinit_early_sriov(adev);
        if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 770eb9725ec1..c712d027d62d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -835,6 +835,16 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mod=
e(struct amdgpu_device *ad
        return mode;
 }

+void amdgpu_virt_post_reset(struct amdgpu_device *adev) {
+       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3)) {
+               /* force set to GFXOFF state after reset,
+                * to avoid some invalid operation before GC enable
+                */
+               adev->gfx.is_poweron =3D false;
+       }
+}
+
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t u=
code_id)  {
        switch (adev->ip_versions[MP0_HWIP][0]) { diff --git a/drivers/gpu/=
drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d1f7509a44cb..fabb83e9d9ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -360,4 +360,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
                      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);  bo=
ol amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
                        uint32_t ucode_id);
+void amdgpu_virt_post_reset(struct amdgpu_device *adev);
 #endif
--
2.34.1

