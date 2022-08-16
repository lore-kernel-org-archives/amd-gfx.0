Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA190C19F2C
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 05:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1786DCA51;
	Tue, 16 Aug 2022 05:24:26 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAA7DCA26
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 05:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjoDGQ0SbJk/Qp9cEGeO1wdi0GtlZms6WlQADag/186DRXxxlVcFf+gl4qbf8SGnwBR3FFA9eWCWfeiJi9D6c/rV/Jl8gByIvNFtpP+EBqX0+qiuSZLFRBTJq9LLmaiZ1HFaDPtxUImRv6Y62uv0euZ4tkpoQd0/c/4pnuzB7L52k0GdY5hA0LXaRstHOp+WwKB2TtoThJvdbTWdydd6IoTO1lnD7DjLPPePlE5yAzwtXzuQmx6wqm1bfzM+wsaxRk52MQuFidavF33hWa3+SB3ekE+1MMKM2M/2BQ6wzcezJtrSQ41Jk38u7GJSuHxY4SkJgOJzihqbyKmeGgouBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLsXw68SEA4XV7eOKHwZyXYfHfAw7wxJkeSlIcipXNw=;
 b=KD75RLJp1RRBJloNraM6HPa98UYQGGY9b3IiaCuShQWZiraRpuLrKxKzr7T9IIWCK8GxJcASbuTgHNuuhI2QFJY9OfSKtqrw/8F2IYDCaW5LNNvG0D3sZcRmJ2jD07QZYPCAlw7hs52UKv+5GHFJ473L9TxpNz8qGOyOcfV+qI+yQXk2AlySNDTrrllg4y+++HAcnhDy4PL53ox2cGxfnvfW4WX9tOtbUveBLMcPdmXBMsVmsIicVppW6VKDB4H5oVSS8Nzil84qhWSdaCIo+1rOTKS+ZlBGHNg/2QQkWWZHBd43AJqYtd4N5+pO3lGdstIRuKtepRTS0f324j0LRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLsXw68SEA4XV7eOKHwZyXYfHfAw7wxJkeSlIcipXNw=;
 b=eS4QchZYn34wqvoMKNZ4eOzyoPbpDoYdPZatsu9uZ+cxBpRTg7O4zmr3C++x4T4YmxyB3y2REPANtxo/2QSEXUxl0K+B8xIkyYIPWo2fwsSHr2WpdNKP4Oc2HyZRw6dT9HR8cDurY9JKov8HD0L3GnCpLeMK/C5wJBPfr0tL8jI=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 05:24:13 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::c85:7688:fe17:4256]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::c85:7688:fe17:4256%5]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 05:24:13 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device
 needs to be earlier than psp_hw_fini
Thread-Index: AQHYrivbAEp6fGMUDUKntPt1ke2PV62vjaFggAFcgICAAAA2AIAAGbog
Date: Tue, 16 Aug 2022 05:24:13 +0000
Message-ID: <CH2PR12MB4215BE03F203F34238A96301FC6B9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220812091317.338637-1-YiPeng.Chai@amd.com>
 <CH2PR12MB4215CBF380BB28417AB5C82AFC689@CH2PR12MB4215.namprd12.prod.outlook.com>
 <BN9PR12MB52573C7C4242760F14E0AC2DFC6B9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB52578F51FC2A5E2915A6BA56FC6B9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52578F51FC2A5E2915A6BA56FC6B9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-16T03:49:47.0000000Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-16T05:24:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e26a8290-e2fa-42ba-b4f7-314da37115ef
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de27f7cb-815e-44a1-020e-08da7f478e2f
x-ms-traffictypediagnostic: CY5PR12MB6203:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6RTt3esVfke0Td6kaMDZO5bGOrxVQG7vQGRZdGbVvevEsz7ZVFDVRSq4/pcuqTP46Wf53RVoBzUBp0vxXsiugWCWXTcRY+zBCch+hk+w99eTo/+Mx00WfbRLdwRvHFDeBlguKoSprViDEAfxjUJhNxz/ILjqi+l8SOMTx4YW7hffQKwQXdl5IwxUJMyvA3/4Vafe6BRm3xboIsaOYgHfJRrjSuOT53FxTiJwzETrbaPQpAu+L8IpDbEHbsJkHY83KmSqvRKh1gVYkHn133JPPlKlLj13BMyI+Mz4XA3sWh0VUwKRmc41tiTj1dknKyqL/+kDfJiIyyH6FWN95a6nrSMAmR7qOB79AZW7RLtV6n5XK2FnLQ6lvna7fjLgWyHJyx05Ww2o7NBJG+oWF6NwkW6gLvhgEnHD2fZb3mfSEcJsKhzZJty6FfbZQd3B86BsDGTMN+ldapbIi20Gs9EqiEUrkIDEC72aPpDbOT57SQhtHfHsecnXSu2U8Xa2EFGbTsGUnbKQk1ZVZ+/ndL1nNMtGur47IdfuPoS2WLFNEPp3utuQEymwoBawhlF4hsr5OQRSnsLITbFoEpF0NGY2t8oe6WOrkd4F1tb9Neuq1JNBsN8wxjD0dw1NKBZcWXcpPt5mboIiatO/K1kp0EjekqTmzT/Ia6+fdTB5666gbRy9eZPZ5JTIQuYubkat0VJzkVwZ+jmnv+d/jPtAIm9yx5KbQrqHaP9rWp+Cp2osMTzQpDJR+85GBtGTXjIkR5bcMdAO2DwFs+QPGSzr/GcOyjZS48RvcU4HZF9OnOTvzrBL7YlZTjn/cnGI1TB7uWu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(2906002)(52536014)(5660300002)(478600001)(66476007)(66946007)(66556008)(66446008)(33656002)(64756008)(8936002)(122000001)(38100700002)(38070700005)(8676002)(41300700001)(6506007)(86362001)(7696005)(9686003)(26005)(186003)(55016003)(53546011)(71200400001)(76116006)(4326008)(83380400001)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nRCu+oAoNmS0zarupYwO54IZLwPVeDi6WuKsn8Qw766gSZ3ITGzEBfXfH//5?=
 =?us-ascii?Q?M+Wlg8WVAbvaIbxjhVrsmUjCHYfn072Lo5l1ua2mar59JQhDi8m6A4aOljXp?=
 =?us-ascii?Q?3qxFmvCEEiDm9FhlUeXnQ+r3qC+1w4/TBqsTZGhJ2sR7olJ/uQrbMdQe/BKA?=
 =?us-ascii?Q?b3KG5UJVabCxBKbPMC2rYtaCHOtr/6CboqpqfY4cCskFx7WJ1ZFw/iDKe+EA?=
 =?us-ascii?Q?wlhc7hayoZjRUwm8m4MdMVPnHnwoGEYUO6SOsiCO8sqElybsNQgBdMoIB8C+?=
 =?us-ascii?Q?7MLZWRzZMMO095dk/IUAj6dwqGtzzGqc2S44J6dK1z0QllEl/NSVQ0ldBdYR?=
 =?us-ascii?Q?CfpXF4b6pbaFTpekzYkAtNSQg74CDPqCZK3yxcW0BdfFciwJSLRqs/AprG8X?=
 =?us-ascii?Q?SD4ikQ7N2bM0rLOEZ0Kfj+9Xk4J6pkaxC63B4lq9yiLB0BvbFGeYmZVki7A6?=
 =?us-ascii?Q?SEz1DANDPY9ZmYc6WFAvYwIqXFpSTIrFT5MOTW1zGrPcYCyWBMNwfaTaZypf?=
 =?us-ascii?Q?JEmjWidqRqFcPvbgcnF5v63mXZ8xeyjb7MFPihOQg9s1p3VZWt7VRcOg/RZz?=
 =?us-ascii?Q?X9lXajQx9KGLGwyy73mvHdHmeM0NAG1FBPl2ApQdEa4iU+aoeJERCOHReMss?=
 =?us-ascii?Q?GQJcTNy+CdSiz+HNL7K56Yy+DUP/5acuHkndVXdHoDJaqsC9zBFtmGTDp8PA?=
 =?us-ascii?Q?z8J8lp95tCs+g2+RoTc03MlQ6poyccZsOP8EyOeeGLqmR/5oYwpvWU19k8bc?=
 =?us-ascii?Q?20t/Ricj86cBzoE7vFj9IHPCKp3bQAmSaAJ3iTeE1KBxPKxK9mF6hVrv0TU9?=
 =?us-ascii?Q?q9XJdPQHKgIldBo3jJS0UoOIndF9W5dwSxlCnylLKswpm0J4UK/2iTRi2vML?=
 =?us-ascii?Q?kCVWnAhAfJIqUVpnncXLqJJlNtcrrEoXs5GfLUmz13w0A1Yplzrup24bltgu?=
 =?us-ascii?Q?5csTQnXKudoSK7QwGkVFk3b4BKd4akOTh488FNpNrqc5BRizf/XhXH/hy8TI?=
 =?us-ascii?Q?wKTEQGkXqe1TGe2Ss+Qm9QHsLHs+UUS+FtGFg4+wzXquRteyfdTFR/mtLRer?=
 =?us-ascii?Q?kis75a+A+dU7gDOj7d8ODJOr5Yy7AZanBHODOgsRci6sKYxqob7RUWsa13uP?=
 =?us-ascii?Q?vik0Paba9D86pXkiBoKPGzQ6gv7pNdjrW6ZgsqkWnPnOY5RQdJTdlNkQVis6?=
 =?us-ascii?Q?Vd4fV2xwUFaOvqDo0U3flD9Gjz2Z2F8Ko+UjvEdwys82qPMX/KRi3CfppEtu?=
 =?us-ascii?Q?JuLOJiIo/JrA0XWfO3GhDK0UCqFv1KSnlpG1xsH1zn2qY4IGHAfJKGoECh33?=
 =?us-ascii?Q?wEjwbjvP3M3cWkd3ydFYYLuXydc54amS/1+XBZC2bLqkDmmn1tOXGUSKtnGt?=
 =?us-ascii?Q?I9mRG7oq3DwfMzcq5etSyoZY/IrEHidyDwVbH/gvXzsg9tzKwnEgkDhWB+bj?=
 =?us-ascii?Q?0oecm9Zj1Hp8C8kqcGOeboiu8Rj13XZUY7OJ3FeHt7J1vNr10ezkPYYvqgBz?=
 =?us-ascii?Q?9Cf6ggnJsL4LpHJSDtIkFncxaT4reIRTcH1GoGhv+6H6diaAm1iM9ptvdj6G?=
 =?us-ascii?Q?wAJ3IJvDLtTfmtltHT95eyDN3dkTBU9MHJxc7ez2?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR12MB4215BE03F203F34238A96301FC6B9CH2PR12MB4215namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de27f7cb-815e-44a1-020e-08da7f478e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 05:24:13.1041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMIMbloTG775Yoc0SWdFtLFkLkMtRA4DigUoaNaoDaMP2fZ0Kvzh1IUnabMbtn37Q8WjGB1lDPo8KA3JC9UHTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH2PR12MB4215BE03F203F34238A96301FC6B9CH2PR12MB4215namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

OK, I will update the patch.

From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, August 16, 2022 11:51 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini

Fixed typo

Regards,
Hawking

From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Date: Tuesday, August 16, 2022 at 11:49
To: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>, amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com=
>>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini
[AMD Official Use Only - General]

Alternatively, it might be better split xgmi ta terminate from xgmi_remove_=
device. In psp_hw_fini, check ta->fw and num_of_physical_mode to terminate =
xgmi ta. and make amdgpu_xgmi_remove_device only deal with software fini, l=
ike add_device.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Sent: Monday, August 15, 2022 15:03
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; W=
ang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com>>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini

[AMD Official Use Only - General]

Ping on this series.

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Sent: Friday, August 12, 2022 5:13 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Zhang, =
Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Wang, Yang(K=
evin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com>>; Chai, Thomas=
 <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Subject: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device need=
s to be earlier than psp_hw_fini

The amdgpu_xgmi_remove_device function will send unload command to psp thro=
ugh psp ring to terminate xgmi, but psp ring has been destroyed in psp_hw_f=
ini.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c84fdef0ac45..2445255bbf01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2787,6 +2787,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)

         amdgpu_amdkfd_suspend(adev, false);

+       if (adev->gmc.xgmi.num_physical_nodes > 1)
+               amdgpu_xgmi_remove_device(adev);
+
         /* Workaroud for ASICs need to disable SMC first */
         amdgpu_device_smu_fini_early(adev);

@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
         if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
                 amdgpu_virt_release_ras_err_handler_data(adev);

-       if (adev->gmc.xgmi.num_physical_nodes > 1)
-               amdgpu_xgmi_remove_device(adev);
-
         amdgpu_amdkfd_device_fini_sw(adev);

         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
--
2.25.1

--_000_CH2PR12MB4215BE03F203F34238A96301FC6B9CH2PR12MB4215namp_
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">OK, I will update t=
he patch.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt">From:</span></b>=
<span style=3D"font-size:11.0pt"> Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;
<br>
<b>Sent:</b> Tuesday, August 16, 2022 11:51 AM<br>
<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_=
device needs to be earlier than psp_hw_fini<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Fixed typo<o:p></o:=
p></span></p>
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
</span></b><span style=3D"font-size:12.0pt;color:black">Zhang, Hawking &lt;=
<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Date: </b>Tuesday, August 16, 2022 at 11:49<br>
<b>To: </b>Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.C=
hai@amd.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">=
KevinYang.Wang@amd.com</a>&gt;<br>
<b>Subject: </b>RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_=
device needs to be earlier than psp_hw_fini<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[AMD Official Use O=
nly - General]<br>
<br>
Alternatively, it might be better split xgmi ta terminate from xgmi_remove_=
device. In psp_hw_fini, check ta-&gt;fw and num_of_physical_mode to termina=
te xgmi ta. and make amdgpu_xgmi_remove_device only deal with software fini=
, like add_device.<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@a=
md.com</a>&gt;
<br>
Sent: Monday, August 15, 2022 15:03<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@=
amd.com">KevinYang.Wang@amd.com</a>&gt;<br>
Subject: RE: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device =
needs to be earlier than psp_hw_fini<br>
<br>
[AMD Official Use Only - General]<br>
<br>
Ping on this series.<br>
<br>
-----Original Message-----<br>
From: Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@a=
md.com</a>&gt;
<br>
Sent: Friday, August 12, 2022 5:13 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd=
.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">H=
awking.Zhang@amd.com</a>&gt;; Wang, Yang(Kevin) &lt;<a href=3D"mailto:Kevin=
Yang.Wang@amd.com">KevinYang.Wang@amd.com</a>&gt;; Chai,
 Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.com</a>&=
gt;<br>
Subject: [PATCH 1/2] drm/amdgpu: The call to amdgpu_xgmi_remove_device need=
s to be earlier than psp_hw_fini<br>
<br>
The amdgpu_xgmi_remove_device function will send unload command to psp thro=
ugh psp ring to terminate xgmi, but psp ring has been destroyed in psp_hw_f=
ini.<br>
<br>
Signed-off-by: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPen=
g.Chai@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---<br>
&nbsp;1 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index c84fdef0ac45..2445255bbf01 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2787,6 +2787,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_=
device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev=
, false);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_no=
des &gt; 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_xgmi_remove_device(adev);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for ASICs nee=
d to disable SMC first */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_smu_fini_ear=
ly(adev);<br>
&nbsp;<br>
@@ -2830,9 +2833,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp; adev-&gt;virt.ras_init_done)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_virt_release_ras_err_handler_data(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_no=
des &gt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_xgmi_remove_device(adev);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_fini_=
sw(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip=
_blocks - 1; i &gt;=3D 0; i--) {<br>
--<br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB4215BE03F203F34238A96301FC6B9CH2PR12MB4215namp_--
