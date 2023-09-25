Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D385CE7A94
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 13:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECFC10E180;
	Mon, 25 Sep 2023 13:59:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAA810E180
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 13:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9dHmT4VdjmnZ+NBoMPVOhpavImAVSEEnGwnTjfOThcqTWO5SWXlLuTERV9+MAvPehhDw2WPM2xUCxb2X/ng4cOmc3i3XBasOMlUnD8hds2uxOSW0gxPnRHgssSg7dWLr7OxvtrpAPf1MT7gVsZ53ZO5N9WxkGTTp5ZTqvl5ofYfbQ69u6eIZeOM2GNozNsUBbZ1tnDOBqSUUNEjaSTq7bKGYKLJvzmjf7IEmdFJJkE7EmBmCZS8Xdyv+TqAeEWMI78sxKBsWcIy2OwcWGZMxaJjLT0qor3wR7yzIV216i/OUkC9MCNMDp7velVPgpZ2UBcAFoJKnPMajtXVoE06Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyL5zn0771FGpzv3tDTN9AOIazCbiRO2FXhbooeQCMo=;
 b=HmiJnrTuHXwjJ/hpaFnHr6+xkmn8GQ+JArWgm3+iMjJ4SL069HAZcHB/6AH6MiOb8VNl+TYQTXhFBjV/LXK4kC5R8qKTDpxvHg01KZlYHtxAGxfZMcC4NnxAZb+mgX4ztFkD1GSQ25uYpeB5VumBBy2HO2FcIp4pjWSmby/N+Xk7bl2GJA1+lexj7qi0AIFhl1A29gX8MDOhOWLgm08kVRw/lukkncITukwHD4IYfQfcsZMMSSATXCDyhCxzp/uNOsMXqOZbJ0EJ75Doqv5VLzfriwptG7moJD1ImJvackFZlwbShrwWP23dJK0XYNeIZyMfkoIxyYI5bEaOeE34rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyL5zn0771FGpzv3tDTN9AOIazCbiRO2FXhbooeQCMo=;
 b=O/LwzTwd7i/sA03/hZ6vC18dnpPVWtaQMySUEAr7ZMB8I0ov4U8IawRjn2a/irtcxQoPNiJM8bUNpDytFetjtiGfjFuYuUf8SDjdcARxWKmWW679E7vHaPnFQ77MJH6424Rh2rPqFDbVjxtg79gaTHNS66F4kDmGq1iDbMnRvTk=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 13:59:35 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 13:59:35 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
Thread-Topic: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
Thread-Index: AQHZ7g9+4qALCrH7qkKht3YO6NhAmrArax0AgAAAu4CAAB/mwA==
Date: Mon, 25 Sep 2023 13:59:34 +0000
Message-ID: <CY5PR12MB63697922C3AC69AD31C7F8B3C1FCA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230923111651.719593-1-yifan1.zhang@amd.com>
 <BN9PR12MB52577619DDE258CA1F89A5E4FCFCA@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB5257AE0760BA4835714303A8FCFCA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257AE0760BA4835714303A8FCFCA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fcacfb65-9d07-41a5-aa85-42239f0fa70c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-25T11:26:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SN7PR12MB6714:EE_
x-ms-office365-filtering-correlation-id: e2e2a76f-3c0c-496f-1530-08dbbdcfa657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BCa9ykx/GuP9IN03VXfMUcda1aTTFuQ46+RWxO8JFYBlYWFq+CzPlsjNFu67qu3V1iKQHMAoEN6VqlM428QoMUd5T3tuEvcYqaAzgtIPsRjYFY1Mj0AwtZq8/V759P0djn0HtY4F+Uq8Xt2HdhXcUTVprMBgmf/7BmkVaH8lSWuPzh4A+3siKbQuT83UaItetf6aiC2tpz5WDxBonVPBLhJNHusSHlSZci668vKWFpMgweoOr8mXsItUh/BUqowLD8JjixVVjUXNsneSJhw8Q3H2WrHZVQCKBPu4rCIzNcZN4K8LgH7C1B/0wxHlYpRQ7vhPm+JK6dTKuX/6KuT6gN7JDJKkxlFAH3h0UGa4jHmBxMVo6iNrsEhSH/4hvVizBNY+6CrqIWKXzt8rlwhChAPTBFJrSO/OBLj+fO4WUh87Kge+Mb95O9Hv6xtba6UIL7rx/sDVPNg1OhAriQV9nWKKj7H/rfBRhBIKjVjHfsvA2VZ24jPpAfVk/eYTW5vcrpm0s/wNkLODjX3yi3l6OxNZ7/LW9Jz/ZGVDcbhxLzDJm0Fks8XNOL/GAHZh0sm3vGRvCZgpTdprng468a2nJT6zfDrPZdfJCXr3CITh6R/EchM4ilp032/bR516OWh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(2906002)(54906003)(110136005)(66946007)(66476007)(66446008)(64756008)(5660300002)(66556008)(76116006)(52536014)(478600001)(71200400001)(53546011)(9686003)(7696005)(6506007)(26005)(8676002)(8936002)(316002)(4326008)(41300700001)(83380400001)(122000001)(38100700002)(86362001)(38070700005)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aON9H5uRX8Ruf+/yamwWOdpYy6WEGDygII1HhpvXmA+9S2U6gy0+t0Uc9xU/?=
 =?us-ascii?Q?Sic0RTCyM9NpkE6pbUKbdVGIms3cZaOpPw6ZIB+UV+m8jyARR7V7CnNsq+Vs?=
 =?us-ascii?Q?E1m7WFNlUA4XkvA5bNzRv6wHaASfkhYig4L7e6qDO2xJcuRtu/Jv+nsR72wn?=
 =?us-ascii?Q?tjoU8MtCxuHwwRxqG5QBFq5AwEUaHeLr/AgIWTloffz11/UuVZbSsFvx/NcK?=
 =?us-ascii?Q?D0Lm7/dI04OsidDAUg7N/DHMFQL1FKim7HAVKF2k9xZs6Jtjjnx7BHXpLKKE?=
 =?us-ascii?Q?RRbbj+5gqLvV0KRBBIPdy6aByQFAW75RdIHkoGuchDO3YhoXHwLAe901dps2?=
 =?us-ascii?Q?R4ARjKHHjzfmi/Cgqkk1VnICgseduyd+8zwb9DXWBnljftGcjTBlZc13Oszf?=
 =?us-ascii?Q?BUBPWVOC+bIbRaof61M/EokNfUgkSRrGoL8Q7kQufizkGRDG8EmeJMVwytbO?=
 =?us-ascii?Q?WUfyQDCRoPGhhco1GPOxWC2dGDzpg40A3kff9IFAmVa48B5WKECGn2nnwep2?=
 =?us-ascii?Q?VXwGqbnvmRal7MiXYMpdNP6occEY27KadAhvsDcaimo6iCM7LmsIvmJiQynF?=
 =?us-ascii?Q?GRdnvm9IY/+EcsX6gb08XuQuq8B3xZNKCQYlGNhjS5PjHnP5t0aTe/idrZT4?=
 =?us-ascii?Q?Srdrm9NiNmOCDTnm+jIxV2H94ymiIalP8Qxjggiu8abZAb42kNbb9UX18s4r?=
 =?us-ascii?Q?VZX6HfRjBHP6FMJ2JXPuYb5WYqj/eJ/leynM2hBLC/IB2H2Xoapd2D0/Tpci?=
 =?us-ascii?Q?RFGC+slsWl3c04YXNyrGkPaxRhgSDWIlf9idH+5AB/mHyTftscT56Mf3NMVh?=
 =?us-ascii?Q?D60YeCSZ2mga6P8489Ko18VuGwbPVwYFjmKpf06z9lesldmmI8fwYJshjtLZ?=
 =?us-ascii?Q?7Yt6LdXwX7PBC2+G4IEQti7F4AclNqztJf/WHJEUmNGNriBZkbbewIbuvwNX?=
 =?us-ascii?Q?986xxk0mjU4rNqUCTVawERI0bldhfkyd+oJ054vMGslRisKGrQwUgAU+f3Ke?=
 =?us-ascii?Q?oPKsu4TZRlNbL2IIL2tD3IGtwz6rdrPlQHRZqC0R0H6LakRR2to8lNthzocR?=
 =?us-ascii?Q?nde564Wj7mck8mhKK82S/u4JuyJsnAtEdwUyJqWjPO52/mPH1MjLwrN8muYZ?=
 =?us-ascii?Q?J8nhxuLJRojCZuwz0BoGUFvd1/6esi2I8PHjpR7AjfgSH8rPCvt9ACh+/WRD?=
 =?us-ascii?Q?QhgZLRzyKoOTXKDLzq2HUIecdt8U/AeI8OpSwMVrQAn1WlBvbGShtxKb+mLH?=
 =?us-ascii?Q?RfxnIMQFjrmHXnV3GuSS9rNRvIHLRswTzon/pnFg3Gkvwe/DBQbufS/3+AWL?=
 =?us-ascii?Q?0ST+dcO0Aohk+Zm73sG2HANtiwoFSBAz9NlxE5pm4/KbyeRZx7RrVhuL/Lzt?=
 =?us-ascii?Q?nGInYzlItkRYfziKDC9tfLeGC8n6ClX3WkTwp8nESI6s82V5BxOZ+AQ7o47D?=
 =?us-ascii?Q?P2eLabOZJVhJX2kWofj9AX1V/CC7KXG1PbLcepuS4ukuhwVo5ZRXAGaql5B2?=
 =?us-ascii?Q?EcpnIRwfcRjgOlBfGN9O13xutrgbilyztkndmVQgGNbGY26X4L9+PflYJQMP?=
 =?us-ascii?Q?Ck0SY2+19JDjDokcuB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e2a76f-3c0c-496f-1530-08dbbdcfa657
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 13:59:34.9338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBwv8t9hFS6O/K8LwVDW9LUYrseMQ/MNDsc7VNL7O82EDfR51hb0DiIaQdl2xfRV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Hawking,

No, no gfx HW programming before gfx power on, gmc_v11_0_flush_gpu_tlb retu=
rns before real tbl flush happens.  The dependence is a pure SW one as belo=
w:

static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vm=
id,
                     uint32_t vmhub, uint32_t flush_type)
 {
     bool use_semaphore =3D gmc_v11_0_use_invalidate_semaphore(adev, vmhub)=
;
     struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
     u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid, flush_type)=
;  ---> get_invalidate_req  is NULL if gfxhub.funcs->init not called.
......
     if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
         return;
}

We can either move vmhub =3D=3D AMDGPU_GFXHUB(0) before get_invalidate_req =
or move gfxhub.funcs->init to gmc sw_init as the patch does.  To align w/ o=
ther generations, I choose the later approach.
Driver loading failure was observed on GC 11.0.4, but it should be universa=
l to all gfx11 ASICs.

BRs,
Yifan.



-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, September 25, 2023 7:33 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.=
com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init

[AMD Official Use Only - General]

For sw_init, it's fine to move to gmc sw_init phase, but any hardware progr=
amming should be done after smu hw_init.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Monday, September 25, 2023 19:30
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init

[AMD Official Use Only - General]

[AMD Official Use Only - General]

RE - gmc11 hw_init depends on adev->gfxhub.funcs->init now, move it to gmc1=
1 sw_init

isn't any driver loading failure observed? Since from gfx11, GFX won't be p=
owered on until smu hw_init phase. Any programming that touch gfx core is i=
nvalid before it is powered on.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Saturday, September 23, 2023 19:17
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init

gmc11 hw_init depends on adev->gfxhub.funcs->init now, move it to gmc11 sw_=
init. This patch fixes below driver load error on GC 11.0.4:

[   43.928149] [drm] amdgpu: 512M of VRAM memory ready
[   43.928151] [drm] amdgpu: 7641M of GTT memory ready.
[   43.928168] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   43.928182] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[   43.928185] #PF: supervisor read access in kernel mode
[   43.928187] #PF: error_code(0x0000) - not-present page
[   43.928188] PGD 0 P4D 0
[   43.928191] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   43.928193] CPU: 7 PID: 1278 Comm: modprobe Tainted: G           OE     =
 6.3.7+ #73
[   43.928198] RIP: 0010:gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
[   43.928406] Code: 8b 4d d4 48 89 4d c8 83 f9 0d 0f 87 7c 04 00 00 48 8b =
45 c8 44 89 ee 44 89 e7 48 8d 04 80 48 c1 e0 04 49 8b 84 07 90 eb 00 00 <48=
> 8b 40 08 ff d0 0f 1f 00 44 8b 45 d4 41 89 c5 45 85 c0 0f 85 c0
[   43.928409] RSP: 0018:ffffae24c28277f0 EFLAGS: 00010256
[   43.928411] RAX: 0000000000000000 RBX: ffff95bf0ed80000 RCX: 00000000000=
00000
[   43.928413] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[   43.928414] RBP: ffffae24c2827848 R08: 0003000000000077 R09: 00000000000=
00401
[   43.928416] R10: 0000000000001000 R11: 0000000000001000 R12: 00000000000=
00000
[   43.928417] R13: 0000000000000000 R14: 0000000000000000 R15: ffff95bf0ed=
80000
[   43.928418] FS:  00007f2703c83000(0000) GS:ffff95c26e7c0000(0000) knlGS:=
0000000000000000
[   43.928421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.928422] CR2: 0000000000000008 CR3: 000000012c300000 CR4: 00000000007=
50ee0
[   43.928424] PKRU: 55555554
[   43.928425] Call Trace:
[   43.928426]  <TASK>
[   43.928428]  ? show_regs+0x6e/0x80
[   43.928434]  ? __die+0x29/0x70
[   43.928436]  ? page_fault_oops+0x154/0x4a0
[   43.928440]  ? amdgpu_bo_move+0x25b/0x790 [amdgpu]
[   43.928612]  ? do_user_addr_fault+0x325/0x710
[   43.928615]  ? exc_page_fault+0x7a/0x180
[   43.928619]  ? asm_exc_page_fault+0x2b/0x30
[   43.928623]  ? gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
[   43.928797]  ? amdgpu_gart_bind+0x64/0xc0 [amdgpu]
[   43.928974]  amdgpu_gmc_flush_gpu_tlb+0x258/0x2e0 [amdgpu]
[   43.929159]  amdgpu_gart_invalidate_tlb+0x66/0xa0 [amdgpu]
[   43.929332]  amdgpu_gtt_mgr_recover+0x67/0x80 [amdgpu]
[   43.929504]  gmc_v11_0_hw_init+0x4c/0x130 [amdgpu]
[   43.929690]  amdgpu_device_init+0x1766/0x2d60 [amdgpu]
[   43.929858]  ? pci_bus_read_config_word+0x4b/0x80
[   43.929862]  ? do_pci_enable_device+0xdb/0x110
[   43.929866]  amdgpu_driver_load_kms+0x1e/0x1a0 [amdgpu]
[   43.930032]  amdgpu_pci_probe+0x16b/0x4e0 [amdgpu]
[   43.930201]  local_pci_probe+0x4c/0xb0
[   43.930204]  pci_device_probe+0xcc/0x280
[   43.930207]  really_probe+0x1c4/0x430
[   43.930210]  __driver_probe_device+0x8a/0x180
[   43.930212]  driver_probe_device+0x23/0xc0
[   43.930214]  __driver_attach+0xfb/0x200
[   43.930215]  ? __pfx___driver_attach+0x10/0x10
[   43.930217]  bus_for_each_dev+0x7e/0xd0
[   43.930221]  driver_attach+0x22/0x30
[   43.930222]  bus_add_driver+0x120/0x230
[   43.930224]  driver_register+0x68/0x130
[   43.930226]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   43.930394]  __pci_register_driver+0x6c/0x80
[   43.930396]  amdgpu_init+0x67/0xff0 [amdgpu]
[   43.930549]  do_one_initcall+0x4a/0x240
[   43.930554]  ? kmalloc_trace+0x2e/0xa0
[   43.930559]  do_init_module+0x52/0x230
[   43.930563]  load_module+0x2386/0x2880
[   43.930566]  ? security_kernel_post_read_file+0x60/0x70
[   43.930571]  __do_sys_finit_module+0xc8/0x140
[   43.930573]  ? __do_sys_finit_module+0xc8/0x140
[   43.930576]  __x64_sys_finit_module+0x1c/0x30
[   43.930578]  do_syscall_64+0x5d/0x90
[   43.930581]  ? syscall_exit_to_user_mode+0x2a/0x50
[   43.930583]  ? __x64_sys_mmap+0x37/0x50
[   43.930586]  ? do_syscall_64+0x6d/0x90
[   43.930588]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Fixes: c6f52f1ffd91 (drm/amdgpu: cleanup gmc_v11_0_flush_gpu_tlb)
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --  drivers/gpu/drm/amd/amdgpu/=
gmc_v11_0.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 42fc0cc13fdd..9c4562bda8cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1329,8 +1329,6 @@ static int gfx_v11_0_sw_init(void *handle)
        struct amdgpu_kiq *kiq;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       adev->gfxhub.funcs->init(adev);
-
        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(11, 0, 0):
        case IP_VERSION(11, 0, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 7d61f66625fa..d0e3583a3cac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -720,6 +720,8 @@ static int gmc_v11_0_sw_init(void *handle)

        adev->mmhub.funcs->init(adev);

+       adev->gfxhub.funcs->init(adev);
+
        spin_lock_init(&adev->gmc.invalidate_lock);

        r =3D amdgpu_atomfirmware_get_vram_info(adev,
--
2.37.3


