Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F48AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 17:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D224510E2F6;
	Fri, 17 Dec 2021 17:06:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0D210E29A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 17:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7SzjGqRoRTHVWrHYUdWKOkDQq7kR9VLzgiDpixU5wOjfzCu4J+znxOH56iiFRbWlJgoTkO3jOOgVDTma0kDJLxwMAPLADhgpfxA54uwtMB2mwdtv8yFpunBfJCP3B7Cy+nm5ZlWGkrzw7KP4mZhXCPdJTzIiVu4SkT8+H8DsOhJUN84WCX6H61SwA5wyLuePkumJqozzpfzQ1MocMC/hI+W6wwoLtsYaLHPuMlQT3BZkzCjQL6l6o/RkbT18r4qmYtWYg0e1oNJRNnl3z60H2miCvmkzLXAOL6oRTHSvLrsUsFDKDAdA7K04N9VrdLHvl4EzeW2MVqPNHQx8qDhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAPIdNYvTTgS3vCKbhME07KcR+rOAFJEErNbHDyfkO4=;
 b=i7+28Sou2MFwUApHjpIzxKvIXMoCwPk/xaW4t/wWmmW11Cq6GUOPOMNBmmus8OruXIZD0FFdhmBwdG3ijERzAjRAsr1h+G+n4qaqCGZr9JmniE+PzTk415ZkNprJCv6fUeTeuor8FdsVaPktzzGdSbdBnHfWlh9n143MYF9rao4BI79vQblnR6cU29GGYG6ZNvbwauhDrid+Vwbn0/SH+eTFUT0dDSwFTQxwEvN836Y4gEyvQlEThS4UOQ2Bw4pXLo+scxnzr2H5XkHw9bbtWOaG5je5z+6hojfiuEehaNRttB7Nhg9bJjV5nd/Q+XKNKsYilCOOEWTrAguQ4RpoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAPIdNYvTTgS3vCKbhME07KcR+rOAFJEErNbHDyfkO4=;
 b=R8nKZDS12tAwgWm3nWyV70QmSnY1roLP0J/SKBdenODdDq/4doFsvEcN4iJIxftvyrjT5HGNbFSIKjjArkFtqBWep300K3v7QNhrj1SLAfsXKWcH2nRduWpN81CwVTZSoNAkBK6WTpuk7u6hXNy7+wr6YqNr9+9K7ItbrXVMslo=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Fri, 17 Dec
 2021 17:06:40 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Fri, 17 Dec 2021
 17:06:40 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Saye, Sashank" <Sashank.Saye@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Topic: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Index: AQHX81uBknBplA2VSkGfNdOPR8f4G6w23geggAAIaQCAAADBIA==
Date: Fri, 17 Dec 2021 17:06:40 +0000
Message-ID: <CH0PR12MB5372126F79E6ECC03CD0801FF4789@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211217153324.181888-1-sashank.saye@amd.com>
 <CH0PR12MB5372EAFB8ECE025BA088D829F4789@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL0PR12MB2433BF358DCC96638855549390789@BL0PR12MB2433.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2433BF358DCC96638855549390789@BL0PR12MB2433.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
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
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T17:06:37Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: cfb1981c-76c2-4859-ada4-6b150309140d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e821b177-a9a6-4014-2711-08d9c17f9806
x-ms-traffictypediagnostic: CH0PR12MB5089:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5089E6C51AE8193D3FBAE1BDF4789@CH0PR12MB5089.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1R/RX+73oEtBgeiRLm1KG5ewoVPp92Nln/VmRaIj8aZLXiB6PU+zlOyh/kqwU4FuuV7YCE4GG4ntO4InLTp3W2B/xB9LaX9lmJJSi4eL2oA/Qsahg8ZgyeuWgqLNw/uf1WoQmI2kg8AD+yvXB6SNlG5TF/qPpYypVLA6UIOFAmjhJu9Zou5ZgbzLN412j5hwJwy6jsJ57CDDJjIsuEkXkJKaRNFVFaajci81lefJ1GxEYR4xmQ+1lBG4a1L19oYd1M9csdennLTeYNuf3r18io+PIUG2Ly/2tQ+3sjT5Dhjyy5E/fvQONuU6A55pEKs3r3b1mP8fpz6HpKJ2+RstHqug/uG+aGjj5nrXNlpBGnFBq8doitvUXPLm0NaSj0RFm0bXyZyZxOEAYiSIXvgRWcovM7Mr9osqSAEdA7NprvCAN1FtigwO5vsznsu80LXiVddOYhu7ieOc7GERxf2U+UjTzgjrKbcvKxGAkv09rxPuyFMc8FvfYL+nbxwaKHTJscuYy+K6x/oDKIsBP7GLJYTKEBUXDq3hdlqCSwpUpxfq0R4GG9Oft5jDecPJp20P8y44Zp7x28FU42qA98V2gZLAwKiC5SMkszvBMBOlyUWGj5X/40vMvkrAefl+vl7PKapQZefuDv3/0oxxJ+5MmQJLWW8xS7OeUzWjAGHziJ6zqUNbcWLWXjSnhaSBoNNcvSMOGyFAT3uxIbtAMZJTJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(7696005)(53546011)(52536014)(86362001)(83380400001)(186003)(26005)(38100700002)(76116006)(508600001)(64756008)(2906002)(66476007)(66556008)(66446008)(66946007)(316002)(6506007)(122000001)(8676002)(110136005)(15650500001)(8936002)(33656002)(38070700005)(9686003)(5660300002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2f16khSbnhTt50Ntdd23hpXyuR3if7hYu2vcQhY9NrNO1VC6XqsbrHvWe6MC?=
 =?us-ascii?Q?qbtVRlCqm52fsce9fkVGuzMxHxtUHmhOlNxz/Aa3XNIP3kGYR87mHkt4aBKf?=
 =?us-ascii?Q?I3/ZsWsZL4XMldK6sMNsFTuJT6jNcofDs1/faVwK4IyCD7T/qd08FsAuEzcT?=
 =?us-ascii?Q?rmJeuU1pQID1HA2BpRIoZBu13dIlgbP8ZPyISQjB8JSPVd5pDyjLVp8rIk4B?=
 =?us-ascii?Q?ANjmqtXIz0HEv798lp5qxkbp2++FHraPMGTi31bpJFiDZDxM95lGv5BXHWbn?=
 =?us-ascii?Q?tsNweweXiipjflvF+b55rcxGowUZ3a36DEIPoe94Ds+37T6JPm02Qo7VTU1O?=
 =?us-ascii?Q?7XcEPcUX6CMJln0+ug3kdkxIwlLaXAs9E6J+q5zXXOlEHmFsWDsIN28O40J6?=
 =?us-ascii?Q?Ndwbfpmxou/62KBYKQt6VIAvn5EPecZUZcgmprKn62IzDe6wRIqueV23YIc1?=
 =?us-ascii?Q?aoDR0JqN7Jgax1NgFMEYziZBsdlTU8dqttQ1KvDB9GrEEemqk/EGa4zt3ko0?=
 =?us-ascii?Q?8w+yUycYV35nuGZKJIwvOmNziGZ8fV5ytMaXd4bKZ5vqWver03EJz4ViX/P6?=
 =?us-ascii?Q?yZR2FUseekx9ik2DxP0WeiS4j6nz6+RUKeUynAPfKt5bzreQ25qmykZ0jPDv?=
 =?us-ascii?Q?aeo5hNzx2OGW0F/rqYAibECFCDvqyutIROzjlhm5FxGPPfKDb/aemEMb06Xv?=
 =?us-ascii?Q?/GkToo8pJt26IAI42XjuI+TgWIQoGjbSYXEpIoWLWfS5h1J3/LuCKL7TRH0D?=
 =?us-ascii?Q?iH/hj1nPKdswrqddm3cQdaQI4ZV/uSXoGiN7ZNp8aAgeM0hHBzj69dJFMaUa?=
 =?us-ascii?Q?KgVPXaODA+9ueresDV0q5KsNTsQ04N8IGT5gfxzeT/i6k7cFD+OaY9ipeZbP?=
 =?us-ascii?Q?TpYa1j9iDGjTWr0Wj0zyX6lPgX+JQve7TGxLXuDOPY2v/uScYrvkfdSdj0tf?=
 =?us-ascii?Q?e5P0+Tsn1Ah/xm3DCI2tpjuyWSVFHLzEKX5p8qIUr7GJkjPA6EJRK3ZJTrO6?=
 =?us-ascii?Q?CrkZwEjlNSA9bYSXsApuSPUPEdrtM0wTGzOS6SYOiY2AonFTpaXcvChLwOpS?=
 =?us-ascii?Q?xiMA8zsheEdUamrNKhwbbaKFdIUU2iMmQT2RX7i6poRNUpkWcZV158yKfwQD?=
 =?us-ascii?Q?mqevk6iWfLwsWIy5JbKGoNDfUQ06An8ydVkFON4qfgngjV2ElH8TQBVftocJ?=
 =?us-ascii?Q?pL80zs+CC7twZeq6tGiuefwFYMMiC5VdO7PwfmkA4jahMADY3JhQqnAByMFe?=
 =?us-ascii?Q?ENBOJHji0aywyyRhguhYaocAPtzulFFLRDMogJqnqIkchhNewm1GQBCGajmF?=
 =?us-ascii?Q?p15QosoH921gkHSc2uShblTQAhXtSj7Vjd9Nnc71CvgQnCyVgN/tOUa6i8dn?=
 =?us-ascii?Q?ep81SXgPyTcDQrPxH7nUKW06PT8Je3kcpQWhh9X8qdfdqhL4a0R9XWDBkzfv?=
 =?us-ascii?Q?wegv8Afhoxc1Ad/OyoEyzcwx+tG2NYxFLh/I5DHA8RfRGNjqq8c/BHE6SMMK?=
 =?us-ascii?Q?gTIgfKU6rxDkSbIPHLYiUsQG2rFVIetOe5Jc4f6uVp8QTCJnKxd0Rayd6ZSk?=
 =?us-ascii?Q?L7IKPFJxbyEkwA7IGG6eibaIew0DCc0fZPhrliF9tgtMjdA6b82BtcsnBspB?=
 =?us-ascii?Q?4l9f65nT+nBBoV/WWYVRtPQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e821b177-a9a6-4014-2711-08d9c17f9806
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 17:06:40.3590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qfCebbgvnByVvMjO0frcDh/pdELn0lCYucgnCe4dOcODSCi5AkGYBqx/8fWBgoz+XzCPUk6Q9FAzImIvMxoSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5089
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

Ok, sounds reasonable . I'm ok for the function name change . =20
Another concern , from driver side , before it start the  ip init ,  it wil=
l check the SMU clock to determine whether the  asic need a reset from driv=
er side . For your case , the hypervisor will trigger the SBR on  VM on/off=
 and SMU will handle the reset.  Can  you check after this  reset , will SM=
U still alive ? If it's alive , the driver will trigger the reset again .=20

Regards
Shaoyun.liu

-----Original Message-----
From: Saye, Sashank <Sashank.Saye@amd.com>=20
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
