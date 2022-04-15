Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F98C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 05:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B477310E2AD;
	Fri, 15 Apr 2022 05:24:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A16A10E32A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 05:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCAVC285TEu0E8OaGeHnzzNpdnE+Pc9AgfxO+vvVze5u/KJ6vvjlG2WL7v1+9fqWuk856OfOQe+1RnEYypdPrimT5hwk6pxqAkMwo87y7ByIew4n7xGl0dzd3vABedN90SnWoRAwoq3PIX1qvF3b5uUkiNQJdIrYO7fQEaZTpxkdD/WUo6Wc3v4Godh4NB+hRLQlEscK31ZBucteOT2LO+I7zTV2lkwoEl9qhEoWltR5QqP2BbHV9eb0v1epl8o+xm9mgE9we0OWlCafTmJbOvuid6xHTh0moxtwohh0uk6V3wQBAySyXQf8dUOikDOIJd0MS7oBJXG3/NomUoFSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdMeKaGojVfaiaqhoP2ITVGC8GAG4NGJQ6HGaX6JDHY=;
 b=mntJsdAwlhnwjIhEFiEI+fGeRH+ChsiGUNxE3+dvX9wiHNNkLcECEuxoETconIrlBgGwuU/67xtAMlKjNF9P5DSI7m2HxJPOxyhPhLb6seTxcroaKxF9Ccn94j74HTr0chz39LBo07nW7l2xHtnb4q9nm+JuFPGArKg4oiEK8zh2PUQyWdVw/RFYVSXjWcGbYs/sSynt0LEMYIiNHVHix117qkkDrT5ZBmHc/1OfnSonLwj47cZ0lx6sZRrv0+B4ATIk97EwO07r7hr1byKoMKfUDZfgcl8bIYNmZkeNoePueFqJJlG9+0eiOI4IRvasUrUfhjTwUYKjGE7gCT+tcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdMeKaGojVfaiaqhoP2ITVGC8GAG4NGJQ6HGaX6JDHY=;
 b=MWxACrgHOgs9rcor4AluShauCfxKKIzn1h34pe9lDgyx/HOi7Hc4Wl/VTkktSFOTpn974Pg2rcgPSw5CR9cT/Oc71xSSI6RuBIbb2e+5YFvdE6PAfnfAvD0kgys3mXaSKtKCsnqfqQtEBWZMB0ktrYfu4LHSdJMaAUfa8W3ExA4=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:24:21 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::78b5:e553:f4cc:4251]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::78b5:e553:f4cc:4251%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 05:24:21 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: fix the null pointer while the smu is
 disabled
Thread-Topic: [PATCH] drm/amdgpu/pm: fix the null pointer while the smu is
 disabled
Thread-Index: AQHYUH849FnAUZQe70etFyalcxTkUqzwcNuA
Date: Fri, 15 Apr 2022 05:24:21 +0000
Message-ID: <BL1PR12MB523780193D231468BA4EA12AF0EE9@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220415041325.3345497-1-ray.huang@amd.com>
In-Reply-To: <20220415041325.3345497-1-ray.huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-15T05:24:18Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=750395de-4441-484e-8a22-c36bf390f695;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-15T05:24:18Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7fb591db-fdee-47f1-8f95-8906bf32e6df
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8220126-4b5e-47b8-639a-08da1ea0326c
x-ms-traffictypediagnostic: BYAPR12MB3238:EE_
x-microsoft-antispam-prvs: <BYAPR12MB32385F01DD468377E761F19BF0EE9@BYAPR12MB3238.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqf+S2mVvfa7VkQC50TkQ8YbCm+tmK81lnjgdQVzJbQYCXeBip1JvCP2fZjj7SIWgTBNKxtBY/A2MgxrY3oExavHX+xwvx3CCyu09lqnGgZP0bJNIBBL+SaZlMZEMGogXSbtwlCYlLYehPnkQPCXJEkHcfPzLu4mz9q4kbVOJlfmZrCqXD4Nl9ND4eVFn/BV59xZclr7JcQc1U8jq5tWpCPorQPbdDMdDK2VTAbkCd19RNqhTlma+aCFyydDUj5t9PgI8Q0myL4Xrl2xljjDrQphl8FxAmgCo6Md5NncQYkEA/yL3dnwe9IYZtcpzZ89QZOWJBGWy2vZAiQqe9EseOPSFemMRl8tuxRE2ZngefjODX9jNbK0ITEicM8x+LxzwWtyduiGA40/d9iCZAi6gEGmXWP+NWsf59TFTlnA/TcztqBCyoMQV6l4vUb2dd2MdArxxk0ZuSnTKcSfl9ek3+DoT+NkLnm1qxCZLOkgsS889AkiONG67qQZMka0RFUgdFAbpR17gEdNFUWwKlKsQrXDQ7r/SY9sEtEBMxWBYl0zX4kMDIbFtJvzOFIURkl1PjUXz4q0RJ/YNX7jjoASlvB/ISphT46Pja06yL73KG4vXLf/9GAGKPZwY47Xx/wjE9c4rcOrmJhWnAlOybJKC6p9h5vS8m/een9Q0z/MrC5qLbODEPGVN9UfVFEr24S9l+zLwmVJFH0PdwSEjExkTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(53546011)(52536014)(316002)(66446008)(110136005)(66556008)(54906003)(66476007)(8676002)(83380400001)(8936002)(71200400001)(55016003)(2906002)(66946007)(76116006)(38100700002)(122000001)(64756008)(9686003)(38070700005)(4326008)(86362001)(33656002)(6506007)(7696005)(26005)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xma8SbLcxuPTSl8UlRyr8EEhp+ObFP6/MZcp8mrPwfnTDSkxKOPAkKWC69eZ?=
 =?us-ascii?Q?3HXu5e6DbxMgffvpTSmBc+MQWdOZNfDje+qUh2+7b6sI+W6OlrjX6ybNVizE?=
 =?us-ascii?Q?OtqaHKDvok435PhX+vG+XE+d0s0xUs75VceSamMgT+Vrh5COVQmDcSv0a6Ym?=
 =?us-ascii?Q?xbeS8f29qBLsRdf6pMPK1M6g/D+0QjLvutXfsAL+Seaf7UydjOlNAgFcz5s4?=
 =?us-ascii?Q?S5bxj1pSRR5Y2OTqkI2uj3RKyCBJzT1H3KE6grXf6aXnfJmkB8z6twavQLvM?=
 =?us-ascii?Q?Y3164lYtlpBrKUOGqEK77Uxiu12WkCBPqd80BM1vcURUvbZw04TOQ6iVUDeB?=
 =?us-ascii?Q?Ai+P8eNXyBt1o5nm+r/tGp1jmHpP2jK7BC2jH7TH9A2MMlC+Ytze1nod1Zg6?=
 =?us-ascii?Q?2UgBwQAgQPu/BeQwOrvXuGH1oLsQh9T7WnO5JeAuGgure7fB3jk+3SLqMn4g?=
 =?us-ascii?Q?kUnly5ilv8VfTECk8K7skNQNjWM5Nij/3q17Q3bCJSZVpCJCzTLq5qD+sGqQ?=
 =?us-ascii?Q?ckhNshCsaoP6ZU2PTj1lihQ+YC2//RxYp8zHmFxaQOgX/eDqAo5CydQ7X0b5?=
 =?us-ascii?Q?NUo2/O41pJX/WCcRcNCwBFoT/LvYoGYDKTUgSyS4yOdyHEEUgW0Q6Q2SpZ5b?=
 =?us-ascii?Q?yz/jKFJFKwRM1TazNnWUk/Z3y/Q4ak7QK2JlShZS3D42b7FV1LEYopmbgjDY?=
 =?us-ascii?Q?G1AhfOcirxvl6kSZL0DuzioDfFI9c15RLi4Ekpj2TjLikixCJKIMddwbSv0s?=
 =?us-ascii?Q?uKjvzAX2rH3OxSEZsXV6Tu6Un6zBUSYlMMKlCemAl3y/6o9xtKuD+IZMQ/f/?=
 =?us-ascii?Q?nZLyXSJb6B20WEvc2B2dZpkuGkQkv/AhPszPMdtlbMbUVZhF1SmMHa2rD7o9?=
 =?us-ascii?Q?HUm5caj+7TKRtyZtAV2OEEsL2lqolcoFJ0aEfPBlsxcDcXFdhafwi9b/akbj?=
 =?us-ascii?Q?d/pJHlCnmsQOJnY/Yw+EOIKEj9cT3im4thIvML5ZzD7rNVxloESOazrQmhQ9?=
 =?us-ascii?Q?ZlCX9pfHOH5x3C3CkGfYTgMoqzdi+6Qw+eJnUwwNCprrX5qgtBI10IkkkH1B?=
 =?us-ascii?Q?J3Rv0aLl+DHBulv850qopzBT7S+oqS7z2AuFCJZK4jDr5bSUy4LBMJ+QC0GS?=
 =?us-ascii?Q?ROqxTZ8l87+xdFiAdRILQBjX+4OwBXMyHc48UA9WriENkJGspCtU0gWcF2d0?=
 =?us-ascii?Q?c4HjBLyX2DqcosgcdPqG400mv8S++AmvK80tqS+y32xEhR4cg4d+gtHNr9Zb?=
 =?us-ascii?Q?4+CJfbjcm4aGViUt1l09n8bYZ19aAxJkIDKUCdEh6wF58IZ8AxLB3TUvnJMo?=
 =?us-ascii?Q?IvK+nFHE83Bu0gVMT60eLVEc4m5Uz6jlvbvqVG5CtYiDgw1+kI4mOARJu3Et?=
 =?us-ascii?Q?4hXGfd7oG3VK/meQcosZ3dhEnlqqmHIwi2h0sQJ9tf0fcmLXMEAS7Tu9vvfI?=
 =?us-ascii?Q?JGsRSYmUyRdp2QeBGPj3j8g7COfLBzoomXESGiazVp7meAVNY+smX1IAAWFq?=
 =?us-ascii?Q?loKHANiJ9BaBIe8/fY/el22ON41W2AY9dplgFgqxYllDzlbMghDAAU1YYTnN?=
 =?us-ascii?Q?0Y7T1subUD0poOmwfnsqUgwA0bKBfrqz4OoF18v2VQd7+SmgDwjE3LwuuVyn?=
 =?us-ascii?Q?1nsYIfDHWFQy+zDEw5tBk9W/oBMKE1WmqbVrD4AWlgmmlOeEBb52B+dUwUkm?=
 =?us-ascii?Q?LN577iWus8cS0vVzdwaLi4KUUmlL0fQSOezqfAZmo3OnUWfw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8220126-4b5e-47b8-639a-08da1ea0326c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:24:21.3255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIMYxkHf7XYvzSUo2bqmeDmjyxJr6Pgtomz2q5prMaUwpRbWbU6RvVELHt9lHSjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3238
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Huang Rui
> Sent: Friday, April 15, 2022 12:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
> Subject: [PATCH] drm/amdgpu/pm: fix the null pointer while the smu is
> disabled
>=20
> It needs to check if the pp_funcs is initialized while release the contex=
t,
> otherwise it will trigger null pointer panic while the software smu is no=
t
> enabled.
>=20
> [ 1109.404555] BUG: kernel NULL pointer dereference, address:
> 0000000000000078 [ 1109.404609] #PF: supervisor read access in kernel mod=
e
> [ 1109.404638] #PF: error_code(0x0000) - not-present page [ 1109.404657]
> PGD 0 P4D 0 [ 1109.404672] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ 1109.404701] CPU: 7 PID: 9150 Comm: amdgpu_test Tainted: G           OE=
L
> 5.16.0-custom #1
> [ 1109.404732] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006 [ 1109.404765] RIP:
> 0010:amdgpu_dpm_force_performance_level+0x1d/0x170 [amdgpu]
> [ 1109.405109] Code: 5d c3 44 8b a3 f0 80 00 00 eb e5 66 90 0f 1f 44 00 0=
0 55 48
> 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 08 4c 8b b7 f0 7d 00 00 <49> 83=
 7e 78
> 00 0f 84 f2 00 00 00 80 bf 87 80 00 00 00 48 89 fb 0f [ 1109.405176] RSP:
> 0018:ffffaf3083ad7c20 EFLAGS: 00010282 [ 1109.405203] RAX:
> 0000000000000000 RBX: ffff9796b1c14600 RCX: 0000000002862007
> [ 1109.405229] RDX: ffff97968591c8c0 RSI: 0000000000000001 RDI:
> ffff9796a3700000 [ 1109.405260] RBP: ffffaf3083ad7c50 R08: ffffffff9897de=
00
> R09: ffff979688d9db60 [ 1109.405286] R10: 0000000000000000 R11:
> ffff979688d9db90 R12: 0000000000000001 [ 1109.405316] R13:
> ffff9796a3700000 R14: 0000000000000000 R15: ffff9796a3708fc0 [ 1109.40534=
5]
> FS:  00007ff055cff180(0000) GS:ffff9796bfdc0000(0000)
> knlGS:0000000000000000 [ 1109.405378] CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033 [ 1109.405400] CR2: 0000000000000078 CR3:
> 000000000a394000 CR4: 00000000000506e0 [ 1109.405434] Call Trace:
> [ 1109.405445]  <TASK>
> [ 1109.405456]  ? delete_object_full+0x1d/0x20 [ 1109.405480]
> amdgpu_ctx_set_stable_pstate+0x7c/0xa0 [amdgpu] [ 1109.405698]
> amdgpu_ctx_fini.part.0+0xcb/0x100 [amdgpu] [ 1109.405911]
> amdgpu_ctx_do_release+0x71/0x80 [amdgpu] [ 1109.406121]
> amdgpu_ctx_ioctl+0x52d/0x550 [amdgpu] [ 1109.406327]  ?
> _raw_spin_unlock+0x1a/0x30 [ 1109.406354]  ?
> drm_gem_handle_delete+0x81/0xb0 [drm] [ 1109.406400]  ?
> amdgpu_ctx_get_entity+0x2c0/0x2c0 [amdgpu] [ 1109.406609]
> drm_ioctl_kernel+0xb6/0x140 [drm]
>=20
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 1d63f1e8884c..428623e64e8f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -717,7 +717,7 @@ int amdgpu_dpm_force_performance_level(struct
> amdgpu_device *adev,
>=20
> 	AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
>=20
> 	AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>=20
> -	if (!pp_funcs->force_performance_level)
> +	if (!pp_funcs || !pp_funcs->force_performance_level)
>  		return 0;
>=20
>  	if (adev->pm.dpm.thermal_active)
> --
> 2.25.1
