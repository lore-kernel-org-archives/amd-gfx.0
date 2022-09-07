Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED94BC38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 03:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BDAE10E0B4;
	Wed,  7 Sep 2022 03:29:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C6E10E0B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 03:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3yjqzAl24/gFwWZpFJIzll5iYMmaHXqr6NPdqtq/DDY9CeORlIYoaGh9dN3eREouiOtl7R9IjWpo2f7Pd7QfyHYnpldd52S2XbswQEKZ26H5/53nZNMKkyr0Ofu/S0h02TNE+NcjibLoWljc3TBv0yVsYJORjrgz80eP8h/vjkzOPVcPHgx4LUAdHqs4ivUafF4tzWddrnOKb6rfMy6k1YzjsthVeKShDXVSwFlChXxDODkDZtF+It8hlhgz8nB6tQJ+U5hvLuupqqGYA5VIrRgSKBOkMupDk+JSeXMXCX65n2YxEEvApYkUzBmmOd0UNiak6xPjibhOobuural4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4xMaavsUdgjjW7VcMSYZ1aNIXPZfJYWESqHjUNJ0FM=;
 b=FO09w9NRTd2WbWmHOU74p4Vxwryj68Y6eiHHj3gTr0DS+KZT08hacAcQNV1J/wMERYB3Pha3jrAKefPu/kyIX/C+/IC6tLK7+2NCyci+n3OphhjssJxYxZ0YWAEAQov1ALxvTpHzTv/iMnfmpnytuYTafxJuDLf1BWkS6oZ+fw3kVyRRVtKUSUSw/YU/O72Iwl88LwAdpavvi2iLB2sBCuJMlpW4+lnwi7ZhTbXxl+oyt+IzYZxOGOFagZiVRjFGrcfCAJ2JRNwuNgjdux1D20d6v0A3SFiuFQx2FycRnvHqGgPwK1tEpTG/XfQ/mITk8itnB4sej3tA1EpAvjQa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4xMaavsUdgjjW7VcMSYZ1aNIXPZfJYWESqHjUNJ0FM=;
 b=A+3Chko8Y7phTkIFxVEEb+6PpsKULg313CVFGUXYeZCvXV1Xhp9/EV7C5IAUPkbhtUq/qPFvSY0BJcXXrQpkr1H3sWnE6W8lf1m6tyBin5Nk3NdKu4iVDg3qzb4TMktO8+UtEU5Sp4XxyDscSJoBmbaSdULKd26PrDabnDbcr8g=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 03:29:35 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b554:96ce:4449:5e98]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b554:96ce:4449:5e98%5]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 03:29:35 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: Adjust removal control flow for smu v13_0_2
Thread-Topic: [PATCH V2] drm/amdgpu: Adjust removal control flow for smu
 v13_0_2
Thread-Index: AQHYwcUXXCDZYelE7UWkXHkAOUzNjq3TQqOAgAANyfA=
Date: Wed, 7 Sep 2022 03:29:35 +0000
Message-ID: <CH2PR12MB42157A5295994AACB0D17166FC419@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220906074822.3885626-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257F5FC5531B2426C073CDEFC419@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257F5FC5531B2426C073CDEFC419@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-07T03:29:30Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-07T03:29:30Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f5de10d8-1021-453b-ba2f-62362a59296b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b03064-cb83-4be2-0c05-08da90812fc6
x-ms-traffictypediagnostic: DM6PR12MB4156:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bwreetIEJC7L4Ew8P6fZxRw97MksQmauhndiYxC4SjTEtYxkgpogojwjnVj2wAcevUfCuycSe9SMRvdFUPlBRivHV5N2ZndKyQ/o4bfkjJGhiCgPWsEQqGmF/X9grQTnfskiVbwHOK6L8Y0Otua94J1SPyOEdz50IDo3htjg88Cme1QvfHTYVLuGPyH4sFzS9y0MUfXmz5+i1w3mxapVMIQ37IoxqqB3bmue5l1xeGoPd+XqfOTkPgj2uk0M2VXQ5/Q5Al0f5OuTpc90SpNsVKcImR3O6KWwoDT2dmlkMlUe0H3MRDXftrRkisoJ4kzjm0PMmgq8BYoMsjtM+vPSqvR9JYPZuQAX4PYiljKJ3mveOgUsr7jHcs1uLHm28UnqqgH9m4QDR9kX6+AS62KO0hSJ2Mqg4YPwleL0qbUOV8ER3yqDF19gS7DuQt2FU2h42CAvxzZHjM/s5DP3AmE7xwtkBkFng/+SZEKyQ2RL20IExh2TbMg8B6aO3/J/qyJnLZKR5sNL+Tdi4Ai1RfeH2NJCUlLJWai/1aM157qqEVCCm9QoSIXVDu2chAD1dD60fGNw7CHeYVwR95z6ENv5vQCN46xI/Qf9v7S6u+Ym8YY4TAW1pGpDSiHicnKzN6DMHnlJzM83tIJhK29gIvB4RtjxI6PSEYtPXEjzKhmMpg4oDXKCWxOIb5YV2A0p4eagBZlcQ7wW01aD9cEZA40x3y+3/gDJar6GpdMMHnL7VY5PBLHKZNEB5yxg7aaYokpgOnxjocOLpAqRaqk425n8TRA9Lamu+iQnbtDBevxojOQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(52536014)(54906003)(110136005)(38070700005)(55016003)(83380400001)(316002)(71200400001)(186003)(26005)(122000001)(41300700001)(8936002)(33656002)(478600001)(9686003)(5660300002)(2906002)(53546011)(6506007)(4326008)(7696005)(8676002)(38100700002)(66946007)(76116006)(86362001)(66476007)(64756008)(30864003)(66446008)(66556008)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Kzzg/zyL0467ZBH4BM1U8mf2wkjfMLHZ+FT0Wb+sr8wzZmqH12yyhf/oVp1?=
 =?us-ascii?Q?z/jjq2XKX1WJ5RoAGcj9ntNvy5+pmgjD0gkpAEI/AKCzb3daro45kyQs6r9a?=
 =?us-ascii?Q?M5olVXpuwUVmthJcD46PA8qlxVMUt1YpeDCArXJy0No32/flWMd3emwGxIH9?=
 =?us-ascii?Q?51wbntcSYInty1eZZiSZJc9/OOqXU0qT+bGuUOfnY7knWYqkcqn5otPW4Mnx?=
 =?us-ascii?Q?QzlMhJnJ9uoCqb/zPZ75IRWaYvplTaJWsNq9GvAUEb0alOR5MqJ1CVaA6kof?=
 =?us-ascii?Q?Vwr9K/ZfyN0+8cpvIJDcerYmZoEcWa68LjewAvFJqbnU41c5TccWC7zg+KbN?=
 =?us-ascii?Q?cZlWyhNWsa4q3VogoKpH3SpGGfj08EIU+ju9w7Q5Gsi1YS4mSeiCkOVUkeV+?=
 =?us-ascii?Q?VyqB+hBPkztxogcI/L7wBwjyyu2NxijG3uFul+FM7WDA6eU5iL1lHRTear6C?=
 =?us-ascii?Q?MmLxYY7Xu4M2LdAs8Y/bd35DyuQGTxthZ+6Xy1G1BspQsqJIi0cV0/3YfB84?=
 =?us-ascii?Q?GO09Amj+jTK1agWwHLCx2nJLkyF9uJq2IXhGqjEK4GiHOTNA12p0DYYCHEf5?=
 =?us-ascii?Q?a0+riyRiurcQYJ3EmKBUDwGz0ulRpLkzQqbwkxjKKMuf0/vAWUKpbNs76dka?=
 =?us-ascii?Q?/7f5QuNVv/VuQTUt859PjJwGSy/QYfrIk4UunRrN3B5LPCbkSIAimT3COlpz?=
 =?us-ascii?Q?rD1tDCyDtWdPurKXd81/Ne63BwLgW2BjbviRJ2ah2IVfjQbSz2f9F94CX8AR?=
 =?us-ascii?Q?dnzN3F9U4OygYlPLyKjJ8Sa2t7QIux2kp9O+UZQk8Hsn6CzjXIOq8SsriMAT?=
 =?us-ascii?Q?gn61CzSzD3tU70Z80Js9FcDgKTVImhZG6SKPkwuxRocBFBpsrIT4h4gfbD9m?=
 =?us-ascii?Q?qsWHPe5E4qLSZ71Kc4GeLBzNMaYeWVLFJJSmvDUagsqbyRTPvnbJTT4pElYQ?=
 =?us-ascii?Q?TyINzDAbi3/keo8trA0qj/AOfAKkkMsc0Lcm6b8Qqm0fgakLcngW0ChqNoQA?=
 =?us-ascii?Q?J23h/4c5C8GsAFcTRbECTjbaS6D4h8aiHj+wXn41aTtYf/iIHgTEqwZktFHf?=
 =?us-ascii?Q?gbX+haox8zQ1K4b2LHp9ERaWZQgJWeydB4NoYroO+c7SGRTXNftnvbOmyFJN?=
 =?us-ascii?Q?QxRprPcap6O09mq5xib6GafCGjmyPbB0r6Xb5PtuA8T6CC4dNEZaKuV2VGCP?=
 =?us-ascii?Q?ZC51GoERb6RgRc27kM5CG0XXLJ558IqBciIFQfuXmR8wMTblpDGA6oVbNytc?=
 =?us-ascii?Q?SGbrvrTmNwfqmeH8lqdWnQj8yrqWMLSZTwmdx1lvB376c/nSbT4piyqDV6sl?=
 =?us-ascii?Q?FwaAai5qnJWaPcQoufL8efAkzmgb50RKlNOLMp0ON6IYS8K/51onHlrIwgn3?=
 =?us-ascii?Q?2iuKJg5tV16EqH2B8kK5R8ia4OwpddVKPh2bsjdoceezskymQKQxL0uNVDTN?=
 =?us-ascii?Q?MWifHcP6GET0QiHPoTI0UMuN75LZ9JimWNJSf0DZ0a/LpiVO76BZXCs7lA8X?=
 =?us-ascii?Q?Ow++xAC0CcLo/E+pivrVXeigWt1A2juwY/1VDkJV0BE+d4xirHBMFrT07FNw?=
 =?us-ascii?Q?Zh39psF1S1SKuEXEgCJIKUWZbpQ9czEw2JlHtlg3?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR12MB42157A5295994AACB0D17166FC419CH2PR12MB4215namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b03064-cb83-4be2-0c05-08da90812fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 03:29:35.2410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYqPtrcJeQmjuRlwPDESRO0ucGimN1ieVHqfLFWKNfQaOaZSl9MkEZ5wWg7f7CSdHNo8ezfDfYHDfaZ/mftaIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH2PR12MB42157A5295994AACB0D17166FC419CH2PR12MB4215namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

OK, I will update patch.


-----------------
Best Regards,
Thomas

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, September 7, 2022 10:40 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Wan=
g, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: Re: [PATCH V2] drm/amdgpu: Adjust removal control flow for smu v13=
_0_2


[AMD Official Use Only - General]

+static void amdgpu_device_gpu_reset(struct amdgpu_device *adev)
+{
+       struct amdgpu_reset_context reset_context;
+
+       memset(&reset_context, 0, sizeof(reset_context));
+       reset_context.method =3D AMD_RESET_METHOD_NONE;
+       reset_context.reset_req_dev =3D adev;
+       set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+       set_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context.flags);
+
+       amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+}

This wrapper is kind of confusing. Let's keep amdgpu_device_gpu_recover as =
the only entry point for recovery handling. If possible, please drop this w=
rapper,  initialize reset_context and call amdgpu_device_gpu_recover direct=
ly


+               /* If in_remove is true, psp_hw_fini should be executed aft=
er
+                *  psp_suspend to free psp shared buffers.
+                */
+               if (adev->in_remove && (adev->ip_blocks[i].version->type =
=3D=3D AMD_IP_BLOCK_TYPE_PSP))
+                       continue;
Can you please share more details to help me understand the sequence adjust=
ment here?

Regards,
Hawking

From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Date: Tuesday, September 6, 2022 at 15:48
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>, Zhang, =
Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>, Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>, Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com<mailto:KevinYang.Wang@amd.com>>, Chai, Thomas <YiPeng.Chai@amd=
.com<mailto:YiPeng.Chai@amd.com>>
Subject: [PATCH V2] drm/amdgpu: Adjust removal control flow for smu v13_0_2
Adjust removal control flow for smu v13_0_2:
   During amdgpu uninstallation, when removing the first
device, the kernel needs to first send a mode1reset message
to all gpu devices. Otherwise, smu initialization will fail
the next time amdgpu is installed.

V2:
1. Update commit comments.
2. Remove the global variable amdgpu_device_remove_cnt
   and add a variable to the structure amdgpu_hive_info.
3. Use hive to detect the first removed device instead of
   a global variable.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 35 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 16 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c         |  6 +++-
 7 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 79bb6fd83094..465295318830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -997,6 +997,9 @@ struct amdgpu_device {
         bool                            in_s4;
         bool                            in_s0ix;

+       /* uninstall */
+       bool                            in_remove;
+
         enum pp_mp1_state               mp1_state;
         struct amdgpu_doorbell_index doorbell_index;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 62b26f0e37b0..1402717673f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2999,6 +2999,13 @@ static int amdgpu_device_ip_suspend_phase2(struct am=
dgpu_device *adev)
                         DRM_ERROR("suspend of IP block <%s> failed %d\n",
                                   adev->ip_blocks[i].version->funcs->name,=
 r);
                 }
+
+               /* If in_remove is true, psp_hw_fini should be executed aft=
er
+                *  psp_suspend to free psp shared buffers.
+                */
+               if (adev->in_remove && (adev->ip_blocks[i].version->type =
=3D=3D AMD_IP_BLOCK_TYPE_PSP))
+                       continue;
+
                 adev->ip_blocks[i].status.hw =3D false;
                 /* handle putting the SMC in the appropriate state */
                 if(!amdgpu_sriov_vf(adev)){
@@ -4739,6 +4746,7 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,
         struct amdgpu_device *tmp_adev =3D NULL;
         bool need_full_reset, skip_hw_reset, vram_lost =3D false;
         int r =3D 0;
+       bool gpu_reset_for_dev_remove =3D 0;

         /* Try reset handler method first */
         tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_de=
vice,
@@ -4758,6 +4766,10 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,
                 test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
         skip_hw_reset =3D test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->f=
lags);

+       gpu_reset_for_dev_remove =3D
+               test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->fl=
ags) &&
+                       test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->fl=
ags);
+
         /*
          * ASIC reset has to be done on all XGMI hive nodes ASAP
          * to allow proper links negotiation in FW (within 1 sec)
@@ -4802,6 +4814,16 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,
                 amdgpu_ras_intr_cleared();
         }

+       /* Fixed the problem that BIOS signature errors and psp bootloader
+        * failure to load kdb on next amdgpu install.
+        */
+       if (gpu_reset_for_dev_remove) {
+               list_for_each_entry(tmp_adev, device_list_handle, reset_lis=
t)
+                       amdgpu_device_ip_resume_phase1(tmp_adev);
+
+               goto end;
+       }
+
         list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
                 if (need_full_reset) {
                         /* post card */
@@ -5124,6 +5146,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
         bool need_emergency_restart =3D false;
         bool audio_suspended =3D false;
         int tmp_vram_lost_counter;
+       bool gpu_reset_for_dev_remove =3D false;
+
+       gpu_reset_for_dev_remove =3D
+                       test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_con=
text->flags) &&
+                               test_bit(AMDGPU_NEED_FULL_RESET, &reset_con=
text->flags);

         /*
          * Special case: RAS triggered and full reset isn't supported
@@ -5159,8 +5186,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
          */
         INIT_LIST_HEAD(&device_list);
         if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes >=
 1)) {
-               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head)
+               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head) {
                         list_add_tail(&tmp_adev->reset_list, &device_list)=
;
+                       if (adev->in_remove)
+                               tmp_adev->in_remove =3D true;
+               }
                 if (!list_is_first(&adev->reset_list, &device_list))
                         list_rotate_to_front(&adev->reset_list, &device_li=
st);
                 device_list_handle =3D &device_list;
@@ -5243,6 +5273,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,

 retry:  /* Rest of adevs pre asic reset from XGMI hive. */
         list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+               if (gpu_reset_for_dev_remove) {
+                       /* Workaroud for ASICs need to disable SMC first */
+                       amdgpu_device_smu_fini_early(tmp_adev);
+               }
                 r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_context=
);
                 /*TODO Should we stop ?*/
                 if (r) {
@@ -5276,6 +5310,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                         adev->asic_reset_res =3D 0;
                         goto retry;
                 }
+
+               if (!r && gpu_reset_for_dev_remove)
+                       goto recover_end;
         }

 skip_hw_reset:
@@ -5349,6 +5386,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                 amdgpu_device_unset_mp1_state(tmp_adev);
         }

+recover_end:
         tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_de=
vice,
                                             reset_list);
         amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 728a0933ea6f..9271f219d8fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2175,6 +2175,19 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
         return ret;
 }

+static void amdgpu_device_gpu_reset(struct amdgpu_device *adev)
+{
+       struct amdgpu_reset_context reset_context;
+
+       memset(&reset_context, 0, sizeof(reset_context));
+       reset_context.method =3D AMD_RESET_METHOD_NONE;
+       reset_context.reset_req_dev =3D adev;
+       set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+       set_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context.flags);
+
+       amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+}
+
 static void
 amdgpu_pci_remove(struct pci_dev *pdev)
 {
@@ -2186,6 +2199,28 @@ amdgpu_pci_remove(struct pci_dev *pdev)
                 pm_runtime_forbid(dev->dev);
         }

+       if (adev->asic_type =3D=3D CHIP_ALDEBARAN) {
+               bool need_to_reset_gpu =3D false;
+
+               adev->in_remove =3D true;
+               if (adev->gmc.xgmi.num_physical_nodes > 1) {
+                       struct amdgpu_hive_info *hive;
+
+                       hive =3D amdgpu_get_xgmi_hive(adev);
+                       if (hive->device_remove_count =3D=3D 0)
+                               need_to_reset_gpu =3D true;
+                       hive->device_remove_count++;
+                       amdgpu_put_xgmi_hive(hive);
+               } else
+                       need_to_reset_gpu =3D true;
+
+               /* Workaround for ASICs need to reset SMU.
+                * Called only when the first device is removed.
+                */
+               if (need_to_reset_gpu)
+                       amdgpu_device_gpu_reset(adev);
+       }
+
         amdgpu_driver_unload_kms(dev);

         drm_dev_unplug(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 28ca0a94b8a5..1f19f9fa4396 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2647,7 +2647,15 @@ static int psp_hw_fini(void *handle)
         psp_asd_terminate(psp);
         psp_tmr_terminate(psp);

-       psp_ring_destroy(psp, PSP_RING_TYPE__KM);
+       /* If in_remove is true, psp_suspend is called before
+        *  psp_hw_fini. psp ring has been stopped in psp_suspend.
+        */
+       if (adev->in_remove && psp->km_ring.ring_mem)
+               amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+                               &psp->km_ring.ring_mem_mc_addr,
+                               (void **)&psp->km_ring.ring_mem);
+       else
+               psp_ring_destroy(psp, PSP_RING_TYPE__KM);

         psp_free_shared_bufs(psp);

@@ -2715,6 +2723,12 @@ static int psp_suspend(void *handle)
         }

 out:
+       /* If in_remove is true, psp_hw_fini will be called after
+        * psp_suspend. Psp shared buffer will be freed in psp_hw_fini.
+        */
+       if (adev->in_remove)
+               return ret;
+
         psp_free_shared_bufs(psp);

         return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index f71b83c42590..dc43fcb93eac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -31,6 +31,7 @@ enum AMDGPU_RESET_FLAGS {
         AMDGPU_NEED_FULL_RESET =3D 0,
         AMDGPU_SKIP_HW_RESET =3D 1,
         AMDGPU_SKIP_MODE2_RESET =3D 2,
+       AMDGPU_RESET_FOR_DEVICE_REMOVE =3D 3,
 };

 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index 552e6fb55aa8..30dcc1681b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -43,6 +43,7 @@ struct amdgpu_hive_info {
         } pstate;

         struct amdgpu_reset_domain *reset_domain;
+       uint32_t device_remove_count;
 };

 struct amdgpu_pcs_ras_field {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 5e318b3f6c0f..6be90076c9f3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3405,7 +3405,11 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)

 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 {
-       if (adev->pm.dpm_enabled =3D=3D 0)
+       /* If in_remove is true, the check for pm.dpm_enabled
+        * needs to be skipped, since smu_suspend is called before
+        * amdgpu_pm_sysfs_fini in the device removal path.
+        */
+       if ((adev->pm.dpm_enabled =3D=3D 0) && !adev->in_remove)
                 return;

         if (adev->pm.int_hwmon_dev)
--
2.25.1

--_000_CH2PR12MB42157A5295994AACB0D17166FC419CH2PR12MB4215namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">OK, I will update p=
atch.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">-----------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best Regards,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thomas<o:p></o:p></=
span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt">From:</span></b>=
<span style=3D"font-size:11.0pt"> Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;
<br>
<b>Sent:</b> Wednesday, September 7, 2022 10:40 AM<br>
<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH V2] drm/amdgpu: Adjust removal control flow for =
smu v13_0_2<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+static void amdgpu=
_device_gpu_reset(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context reset_con=
text;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;reset_context, 0, sizeof(=
reset_context));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context.method =3D AMD_RESET_ME=
THOD_NONE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context.reset_req_dev =3D adev;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_NEED_FULL_RESET, &amp;=
reset_context.flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_RESET_FOR_DEVICE_REMOV=
E, &amp;reset_context.flags);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_recover(adev, NULL,=
 &amp;reset_context);<br>
+}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">This wrapper is kin=
d of confusing. Let&#8217;s keep amdgpu_device_gpu_recover as the only entr=
y point for recovery handling. If possible, please drop this wrapper, &nbsp=
;initialize reset_context and call amdgpu_device_gpu_recover
 directly<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /* If in_remove is true, psp_hw_fini should be execu=
ted after<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; *&nbsp; psp_suspend to free psp shared buffers.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;in_remove &amp;&amp; (adev-&gt;ip_blocks[i].version=
-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_PSP))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;</span>=
<span style=3D"font-size:11.0pt;font-family:SimSun"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Can you please shar=
e more details to help me understand the sequence adjustment here?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Chai, Thomas &lt;<a=
 href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.com</a>&gt;<br>
<b>Date: </b>Tuesday, September 6, 2022 at 15:48<br>
<b>To: </b><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc: </b>Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.C=
hai@amd.com</a>&gt;, Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd=
.com">Hawking.Zhang@amd.com</a>&gt;, Zhou1, Tao &lt;<a href=3D"mailto:Tao.Z=
hou1@amd.com">Tao.Zhou1@amd.com</a>&gt;, Wang, Yang(Kevin)
 &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.Wang@amd.com</a>&g=
t;, Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd=
.com</a>&gt;<br>
<b>Subject: </b>[PATCH V2] drm/amdgpu: Adjust removal control flow for smu =
v13_0_2<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Adjust removal control flow for smu v13_0_2:<br>
&nbsp;&nbsp; During amdgpu uninstallation, when removing the first<br>
device, the kernel needs to first send a mode1reset message<br>
to all gpu devices. Otherwise, smu initialization will fail<br>
the next time amdgpu is installed.<br>
<br>
V2:<br>
1. Update commit comments.<br>
2. Remove the global variable amdgpu_device_remove_cnt<br>
&nbsp;&nbsp; and add a variable to the structure amdgpu_hive_info.<br>
3. Use hive to detect the first removed device instead of<br>
&nbsp;&nbsp; a global variable.<br>
<br>
Signed-off-by: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPen=
g.Chai@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 +++++++++++++++++++++=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; | 35 ++++++=
+++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; | 16 ++++++=
++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp; |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 6 +++-<br>
&nbsp;7 files changed, 99 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 79bb6fd83094..465295318830 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -997,6 +997,9 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_s4;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_s0ix;<=
br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* uninstall */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_remove;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_mp1_state&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 mp1_state;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_doorbell_ind=
ex doorbell_index;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 62b26f0e37b0..1402717673f7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2999,6 +2999,13 @@ static int amdgpu_device_ip_suspend_phase2(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;suspend of IP block &lt;%s&gt; failed %d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i=
].version-&gt;funcs-&gt;name, r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* If in_remove is true, psp_hw_fini should be executed after<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; *&nbsp; psp_suspend to free psp shared buffers.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;in_remove &amp;&amp; (adev-&gt;ip_blocks[i].version=
-&gt;type =3D=3D AMD_IP_BLOCK_TYPE_PSP))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.hw =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* handle putting the SMC in the appropriate state */=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if(!amdgpu_sriov_vf(adev)){<br>
@@ -4739,6 +4746,7 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_=
adev =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset, skip=
_hw_reset, vram_lost =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gpu_reset_for_dev_remove =3D 0;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Try reset handler metho=
d first */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_en=
try(device_list_handle, struct amdgpu_device,<br>
@@ -4758,6 +4766,10 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context-&=
gt;flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; skip_hw_reset =3D test_bit=
(AMDGPU_SKIP_HW_RESET, &amp;reset_context-&gt;flags);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_reset_for_dev_remove =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &amp;reset_context-&gt;=
flags) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_=
NEED_FULL_RESET, &amp;reset_context-&gt;flags);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ASIC reset has to =
be done on all XGMI hive nodes ASAP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to allow proper li=
nks negotiation in FW (within 1 sec)<br>
@@ -4802,6 +4814,16 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_intr_cleared();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fixed the problem that BIOS signat=
ure errors and psp bootloader<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * failure to load kdb on next a=
mdgpu install.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_reset_for_dev_remove) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, device_list_handle, reset_list)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_resume_phase1(tmp_adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, device_list_handle, reset_list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (need_full_reset) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* po=
st card */<br>
@@ -5124,6 +5146,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restar=
t =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended =3D f=
alse;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tmp_vram_lost_counter;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gpu_reset_for_dev_remove =3D fal=
se;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_reset_for_dev_remove =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_=
RESET_FOR_DEVICE_REMOVE, &amp;reset_context-&gt;flags) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_NEED_FULL_RESET, &amp;reset=
_context-&gt;flags);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS =
triggered and full reset isn't supported<br>
@@ -5159,8 +5186,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device=
_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
 &amp;&amp; (adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgm=
i.head)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgm=
i.head) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
add_tail(&amp;tmp_adev-&gt;reset_list, &amp;device_list);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_=
remove)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;in_remove =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!list_is_first(&amp;adev-&gt;reset_list, &amp;dev=
ice_list))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
rotate_to_front(&amp;adev-&gt;reset_list, &amp;device_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; device_list_handle =3D &amp;device_list;<br>
@@ -5243,6 +5273,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,<br>
&nbsp;<br>
&nbsp;retry:&nbsp; /* Rest of adevs pre asic reset from XGMI hive. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, device_list_handle, reset_list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gpu_reset_for_dev_remove) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for=
 ASICs need to disable SMC first */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_sm=
u_fini_early(tmp_adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_co=
ntext);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*TODO Should we stop ?*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
@@ -5276,6 +5310,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;asic_reset_res =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
retry;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!r &amp;&amp; gpu_reset_for_dev_remove)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto recover_end=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;skip_hw_reset:<br>
@@ -5349,6 +5386,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_unset_mp1_state(tmp_adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+recover_end:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_en=
try(device_list_handle, struct amdgpu_device,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unlock_reset=
_domain(tmp_adev-&gt;reset_domain);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 728a0933ea6f..9271f219d8fa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2175,6 +2175,19 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static void amdgpu_device_gpu_reset(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context reset_con=
text;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;reset_context, 0, sizeof(=
reset_context));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context.method =3D AMD_RESET_ME=
THOD_NONE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context.reset_req_dev =3D adev;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_NEED_FULL_RESET, &amp;=
reset_context.flags);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_RESET_FOR_DEVICE_REMOV=
E, &amp;reset_context.flags);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_recover(adev, NULL,=
 &amp;reset_context);<br>
+}<br>
+<br>
&nbsp;static void<br>
&nbsp;amdgpu_pci_remove(struct pci_dev *pdev)<br>
&nbsp;{<br>
@@ -2186,6 +2199,28 @@ amdgpu_pci_remove(struct pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_forbid(dev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_AL=
DEBARAN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool need_to_reset_gpu =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;in_remove =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hi=
ve_info *hive;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D amdgpu_=
get_xgmi_hive(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive-&gt;dev=
ice_remove_count =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_to_reset_gpu =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive-&gt;device_=
remove_count++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_put_xgmi_=
hive(hive);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_to_reset_gp=
u =3D true;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Workaround for ASICs need to reset SMU.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * Called only when the first device is removed.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (need_to_reset_gpu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gp=
u_reset(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_driver_unload_kms(d=
ev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 28ca0a94b8a5..1f19f9fa4396 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -2647,7 +2647,15 @@ static int psp_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_asd_terminate(psp);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_tmr_terminate(psp);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ring_destroy(psp, PSP_RING_TYPE__=
KM);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If in_remove is true, psp_suspend =
is called before<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; psp_hw_fini. psp ring h=
as been stopped in psp_suspend.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_remove &amp;&amp; psp=
-&gt;km_ring.ring_mem)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;firmware.rbuf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;km_ring.ring_mem_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void **)&amp;psp-&gt;km_ring.ring_mem);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp_ring_destroy(psp, PSP_RING_TYPE__KM);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_free_shared_bufs(psp);=
<br>
&nbsp;<br>
@@ -2715,6 +2723,12 @@ static int psp_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If in_remove is true, psp_hw_fini =
will be called after<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * psp_suspend. Psp shared buffe=
r will be freed in psp_hw_fini.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_remove)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_free_shared_bufs(psp);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h<br>
index f71b83c42590..dc43fcb93eac 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
@@ -31,6 +31,7 @@ enum AMDGPU_RESET_FLAGS {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_NEED_FULL_RESET =3D=
 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SKIP_HW_RESET =3D 1=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SKIP_MODE2_RESET =
=3D 2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_RESET_FOR_DEVICE_REMOVE =3D 3,=
<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amdgpu_reset_context {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h<br>
index 552e6fb55aa8..30dcc1681b4e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
@@ -43,6 +43,7 @@ struct amdgpu_hive_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } pstate;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_domain=
 *reset_domain;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t device_remove_count;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amdgpu_pcs_ras_field {<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 5e318b3f6c0f..6be90076c9f3 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -3405,7 +3405,11 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)=
<br>
&nbsp;<br>
&nbsp;void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enabled =3D=3D 0)=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If in_remove is true, the check fo=
r pm.dpm_enabled<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * needs to be skipped, since sm=
u_suspend is called before<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_pm_sysfs_fini in the d=
evice removal path.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pm.dpm_enabled =3D=3D 0=
) &amp;&amp; !adev-&gt;in_remove)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.int_hwmon_=
dev)<br>
-- <br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB42157A5295994AACB0D17166FC419CH2PR12MB4215namp_--
