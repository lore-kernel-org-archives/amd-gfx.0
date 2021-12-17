Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB188C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 17:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BF610E670;
	Fri, 17 Dec 2021 17:11:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542E510E667
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 17:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuvtDHTB/NnN5qawPZ6IG7m9LRqCEZpsLTk2nXCXuoqs9R62vhY9PLFf3RIiPIVZ/MENtKydGita6Juo5/nksLLr6n8bk8vZHFsxYtY8Ft03iMQeYb6nyLUWH17hMo9O4YQ9NAtRT3jqw5tPWUePqDzprfTf9ldjlZSIPxOtIqscAuexzwFINUY2yCmBIC8mSHfLTW4pVAzaAuNFJJ48oUPQMk7vj44KdZUGgV5k6G9EkUh24a9r+CF1iIAUQH36u4qmpdDYleeaURUdJ40rOkFX3PO+d9GMNBPP5badS1ADvjzLxA+PJ5vErnMRZFTEdbU1VxKEagrdvEqXIRq82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMR7LgDGiydVMjzwUfL6UT3UBc/HSiag1mrXxRLDNZ0=;
 b=PN+yvbmt7P5ZDA5t+nGSrAPdvteihsDe1QxTF3zgvhp5F9LAmikTT8hIFVYv+7t7dXts+/p3cINe0j1wqocZAX3zkxv8cClRFOd34hSqIQ5b3ZbfyOhE+a+I83JkjNaLEgDohtzX3aTUMuK7MnSNaTf8vz+wzmtIYmTE6qLH/NdZw4zrIkvCljrTqWPjNg+JPOI2lD1GbXG5ko+949UwPv8gacUzH38lZ6HiZyIrpE4W6pK7ioeET3h0+USYXmC4zSYgAPtVkUQM2VL/lCeXYeJtJI0CSVCgKnJF917tuSM3sZcpLPz+dxV4nCgjw5pR8+xhR5x3tEMzs1/4Grv7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMR7LgDGiydVMjzwUfL6UT3UBc/HSiag1mrXxRLDNZ0=;
 b=hEhsTbKqv8PwfK1lvO6tiEAN+K11jWZQNI1WlZ4RYxghlokD4pxxxz14ElpaJMZUz/xO1bZIBPzIpPf08ok0fUGjWcg11ZRsvxjONyLOlDRV0CvgrflCGTQRaxBrKaRFk7chQ3hkUNN8LRH0SlFUCSn4vzIOBE7kq5dGwLp77YY=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 17:11:23 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::950:57c2:75bf:aefa]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::950:57c2:75bf:aefa%7]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 17:11:23 +0000
From: "Saye, Sashank" <Sashank.Saye@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Topic: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Index: AQHX81t7hy2jKHuu/UiEWJtjhi9W/qw25CSAgAAASmCAAAXFAIAAAPWg
Date: Fri, 17 Dec 2021 17:11:23 +0000
Message-ID: <BL0PR12MB2433C87A670C49F021812CC090789@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20211217153324.181888-1-sashank.saye@amd.com>
 <CH0PR12MB5372EAFB8ECE025BA088D829F4789@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL0PR12MB2433BF358DCC96638855549390789@BL0PR12MB2433.namprd12.prod.outlook.com>
 <CH0PR12MB5372126F79E6ECC03CD0801FF4789@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372126F79E6ECC03CD0801FF4789@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T16:23:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=122135e3-fada-41e2-a729-6a70502decbc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T17:11:22Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 1005bc1f-c325-4f35-bb12-5dcf17913928
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1daaa772-5918-4de8-9957-08d9c1804087
x-ms-traffictypediagnostic: MN2PR12MB4190:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4190917D7C8BD7DD64ED20B590789@MN2PR12MB4190.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 592JBQHJihEc5MPVanQpu9QX4K7fTjj+4AQRVrZ4/oPZ+jlnMcEJGSG3HlzwpkzzV7MhuXTXrjGrcyh6MsJMHuggLlhqXM5W4toINTUQkmqJ+vjoxOnbh9iuf4jkzP6u8uve/hfDoW/DRwdJki9gHvmVDGQJ25jM+PbiLpbsv+ihvQdELr4t65HsSEi8n8d1q0mztGY5qeskdJwURPZgsTe4B8PHyqkCwKAevIA33W8GReaHWRIDoQ7Xt3hOxipLJG86UKXFv/XmiwMA69uneLFAaDODxuR9ika8O32GIqkpZatqZki4MymTBWeRGi4XPm/NC7MHm8y3rwXY/H1Z7ixfvg33Xx+481B4CU5Ek+LpvPb9qi7WytuxbgoUYWrGbM8qS6xDP7C9AZ+OmVm6/vaCPhiDIMfG6wlHhProqmZgDbcY3At7SrlEL9VzLsov8AOUxHsnOEh2LLlvjceLi51RsgAOgj7ULn0n8O/tasfy02D+9d5gbNC6Z0f2qySgcrEXnn3u48dazbvY3uH2HyV8Gbzd9OwlFCvMd0Z0lNQH+3PEhvhP1Jtm//7jm1TdhYkrhepOaXnPjBBSPvcxFdTkZxUdQ+Xw0ilCNje6uoSja12dYjE4RrKNu2hZZW4Pe5xVWIuTfRoIPCy04lND+N/L8yZUZ0M1YggZZaf2W4JjlKp2P3T7fQAvXoe6Vo/qlH6jVvXba/an+jNZJ1gtEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(38100700002)(9686003)(7696005)(26005)(66446008)(83380400001)(66556008)(64756008)(8676002)(66476007)(66946007)(55016003)(2906002)(110136005)(76116006)(52536014)(6506007)(316002)(38070700005)(71200400001)(186003)(86362001)(5660300002)(33656002)(508600001)(15650500001)(8936002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mo0PmB7XxUbfigIjHQLTJibDK66rLf0HLS5+ElfDAkmk9eHX1j6juWPdZ6GX?=
 =?us-ascii?Q?XKIoLD8zmd9TW3g5IfzNB5IytOvix0Bpxm5i7xOggpg1y3WG+/qCe/4Nj6TT?=
 =?us-ascii?Q?fT/MlV7n9p6ksRCHBvZ1//jy7mdjvnotLChOSsUt+Coksg108U6MP+Mu4fvT?=
 =?us-ascii?Q?E2lGxRMYdewyF9MAz7ZZddv1P7HT8O/DmZna7dUhYSbCdFUG1xL1rbp6p1oK?=
 =?us-ascii?Q?heaahSEmY4i02Hda+mclDo3XNPqLwfB7Agd6xmZLcUmMzdWkVXWWIuQ6TmRQ?=
 =?us-ascii?Q?JWGdIL2FhfmPSNMwmS47Ua2d1m5tf5/YdoF8iM0ysddFXjzcE1opVDyMJViQ?=
 =?us-ascii?Q?KKjJFqqGI+MOZ6uClfKpziJlwjvtf57Oi7Znt8BO/lWzkikQgVgsK+xer/WJ?=
 =?us-ascii?Q?6anFWOfpvLi/RRumFYZKs+i6hoxaWmn23arV8HluhMy6lLWfb9n8ae+0xT8x?=
 =?us-ascii?Q?aWARuV5K+PbiYnWKw8Q6QPIv0mvJJCEoH/SM12diipa4IEKXhpseYZVTmxrs?=
 =?us-ascii?Q?bXuezr/j5l7w8/UV+EMDpWTwAurCfhjgKnYCxih4gGzzhFrr/g2g+GQYL0M6?=
 =?us-ascii?Q?Mma+G6iiamp5WSUCtXIe0DpZ+fZPi7FP1W8to44GbgxSl7BCwOgNAaEUMXIY?=
 =?us-ascii?Q?k3owhTuIKE2bdp0SYadP0xMzHSDJgN5kSl6FRfFxrl9MXGFiTi3YP0qSfuuZ?=
 =?us-ascii?Q?Dg38nkEd5CFTwTdcKc+7Mjg6tnovt3mvgJjGTPqsNQElIpHNI3t0Z5Jd3yeS?=
 =?us-ascii?Q?8ombkOUJqA1Y2ZRnVZmMfQuTJLEcOCQ31un8oBVci2wOG5og1lnaeNDJYmuc?=
 =?us-ascii?Q?YYotQwrukXd0Vg9PqoMvx29v7vX43FWa3UTwLyM7QuD8WZkJOSLnkNctSQIC?=
 =?us-ascii?Q?taeB4FlimiEeLqhup8m3EB64ddAeVsnwQeRcaKSFnhMWXIPz88hB1F+k9mc1?=
 =?us-ascii?Q?llg9momLWKHsylg9w2CB5hUOGyu1VlnvhJvTlCon/Dn5AL4dHZi1sxYoFjlL?=
 =?us-ascii?Q?PLet6waSYrku4KaN0G+VatKUqC9N7x5Z8Ot5lj8QyFrpw9+Kj169Ri/51kTZ?=
 =?us-ascii?Q?Si0dncK9ZD/azyQi9949X5z6133Y7X7oUAJrNMaVu8ugexlNcUMn5LmmQqz0?=
 =?us-ascii?Q?xbGgq4ZICbVPlYk+e60+Q5il7m96vGslWABZEv0aG0ADoCnOS36I4ZvMpX+8?=
 =?us-ascii?Q?roQRjdtVc+rk1PPQqMjcTgSpg7PQm44wcl+G5Aqb+JGZ440wvyn9B51/1cvj?=
 =?us-ascii?Q?D0b3x0fgj21IyGNRtXcmuR9sS072OUc1S1XTNE7mGEWiBbiUoKjfL2TFEatn?=
 =?us-ascii?Q?99ykWAYOsfpAMT2bokDvPC7UcxEoX7G0IJsSdapg8E32rpCorNhHQIBHtLCL?=
 =?us-ascii?Q?XaxqRj1IyiH/sfHAvCrlbDd6Ydbql4Zegv8CKmGmmCrzZKHtkwNALiHUNHsR?=
 =?us-ascii?Q?yjarlFKKnTQc0wMqJu2I8oDFtkVsiAewKdJHUkEf9caII8d2xquwiZujZh0j?=
 =?us-ascii?Q?uiLSSwFAqw8A6C6mQ8ndE3Fakq6w4RJPE1n/aFE4zAKT1hwQpplBXQ3hyBo9?=
 =?us-ascii?Q?nTmk+Mh+5/1Nj9xFNGE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daaa772-5918-4de8-9957-08d9c1804087
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 17:11:23.1269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaHhdAMLLrGCoREC6a/tAK1EjPy/xOeKc/ByHaBi4H7NxtdGwz7PPHXnr5dt/VYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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

Yeah after smu does the mode 1 reset, the clock is cleared, hence when the =
driver boots after that, it will look like a regular cold boot.=20

Regards
Sashank

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>=20
Sent: Friday, December 17, 2021 12:07 PM
To: Saye, Sashank <Sashank.Saye@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrou=
gh for sbr handling

[AMD Official Use Only]

Ok, sounds reasonable . I'm ok for the function name change . =20
Another concern , from driver side , before it start the  ip init ,  it wil=
l check the SMU clock to determine whether the  asic need a reset from driv=
er side . For your case , the hypervisor will trigger the SBR on  VM on/off=
 and SMU will handle the reset.  Can  you check after this  reset , will SM=
U still alive ? If it's alive , the driver will trigger the reset again .=20

Regards
Shaoyun.liu

-----Original Message-----
From: Saye, Sashank <Sashank.Saye@amd.com>
Sent: Friday, December 17, 2021 11:53 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrou=
gh for sbr handling

[AMD Official Use Only]

Hi Shaoyun,
Yes, From SMU FW point of view they do see a difference between Bare metal =
and passthrough case for SBR. For baremetal they get it as a PCI reset wher=
eas passthrough case they get it as a BIF reset. Now within BIF reset they =
would need to differentiate between older asic( where we do BACO) and newer=
 ones where we do mode 1 reset. Hence in-order for SMU to differentiate the=
se scenarios we are adding a new message.=20

I think I will rename the function to smu_handle_passthrough_sbr from the c=
urrent smu_set_light_sbr function name.

Regards
Sashank

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Friday, December 17, 2021 11:45 AM
To: Saye, Sashank <Sashank.Saye@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Saye, Sashank <Sashank.Saye@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrou=
gh for sbr handling

[AMD Official Use Only]

First , the name of heavy SBR  is confusing when you need to go through  li=
ght SBR code path.=20
Secondary,  originally we introduce the light SBR is because on older asic,=
   FW can not synchronize the reset on the devices within the hive, so it d=
epends on driver to sync the reset.  From what I have heard , for chip aruc=
tus , the FW actually can sync the reset itself.  I don't see a necessary t=
o  introduce the heavy SBR message, it seems SMU will do a full reset  when=
 it get SBR  request.  IS there  a different code path  for SMU to handle t=
he reset  for XGMI in passthrough mode ? =20

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of sashank =
saye
Sent: Friday, December 17, 2021 10:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Saye, Sashank <Sashank.Saye@amd.com>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough f=
or sbr handling

For Aldebaran chip passthrough case we need to intimate SMU about special h=
andling for SBR.On older chips we send LightSBR to SMU, enabling the same f=
or Aldebaran. Slight difference, compared to previous chips, is on Aldebara=
n, SMU would do a heavy reset on SBR. Hence, the word Heavy instead of Ligh=
t SBR is used for SMU to differentiate.

Signed-off-by: sashank saye <sashank.saye@amd.com>
Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 ++--
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 +++++++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f31caec669e7..06aee23505b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,8 +2618,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
=20
-	/* For XGMI + passthrough configuration on arcturus, enable light SBR */
-	if (adev->asic_type =3D=3D CHIP_ARCTURUS &&
+	/* For XGMI + passthrough configuration on arcturus and aldebaran, enable=
 light SBR */
+	if ((adev->asic_type =3D=3D CHIP_ARCTURUS || adev->asic_type =3D=3D=20
+CHIP_ALDEBARAN ) &&
 	    amdgpu_passthrough(adev) &&
 	    adev->gmc.xgmi.num_physical_nodes > 1)
 		smu_set_light_sbr(&adev->smu, true);
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/aldebaran_ppsmc.h
index 35fa0d8e92dd..ab66a4b9e438 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -102,7 +102,9 @@
=20
 #define PPSMC_MSG_GfxDriverResetRecovery	0x42
 #define PPSMC_MSG_BoardPowerCalibration 	0x43
-#define PPSMC_Message_Count			0x44
+#define PPSMC_MSG_HeavySBR                      0x45
+#define PPSMC_Message_Count			0x46
+
=20
 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/p=
m/inc/smu_types.h
index 18b862a90fbe..ff8a0bcbd290 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -229,7 +229,8 @@
 	__SMU_DUMMY_MAP(BoardPowerCalibration),   \
 	__SMU_DUMMY_MAP(RequestGfxclk),           \
 	__SMU_DUMMY_MAP(ForceGfxVid),             \
-	__SMU_DUMMY_MAP(UnforceGfxVid),
+	__SMU_DUMMY_MAP(UnforceGfxVid),           \
+	__SMU_DUMMY_MAP(HeavySBR),
=20
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..f442950e9676 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_mess=
age_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(SetUclkDpmMode,			     PPSMC_MSG_SetUclkDpmMode,			0),
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		=
0),
 	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0)=
,
+	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,         =
               0),
 };
=20
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D =
{ @@ -1912,6 +1913,15 @@ static int aldebaran_mode2_reset(struct smu_contex=
t *smu)
 	return ret;
 }
=20
+static int aldebaran_set_light_sbr(struct smu_context *smu, bool
+enable) {
+	int ret =3D 0;
+	//For alderbarn chip, SMU would do a mode 1 reset as part of SBR hence we=
 call it HeavySBR instead of light
+	ret =3D  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, enable ?=
=20
+1 : 0, NULL);
+
+	return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)  {=
  #if 0 @@ -2021,6 +2031,7 @@ static const struct pptable_funcs aldebaran_p=
pt_funcs =3D {
 	.get_gpu_metrics =3D aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
 	.mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
+	.set_light_sbr =3D aldebaran_set_light_sbr,
 	.mode1_reset =3D aldebaran_mode1_reset,
 	.set_mp1_state =3D aldebaran_set_mp1_state,
 	.mode2_reset =3D aldebaran_mode2_reset,
--
2.25.1
