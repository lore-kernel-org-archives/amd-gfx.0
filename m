Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76464C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 02:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AAB10E236;
	Mon, 22 May 2023 02:02:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8D710E236
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 02:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNykpIY1w/tKC2gQYY4R+SiLYuPmnpVbyAoj4dvZM+CuBb7ZLxjRmGOt9K/qL0rPm0YzNuZ5+5wBjzcZeLOpXfDoQ4Zdbn/fP1fqtyTy4QE+nroiQ9rJdzf07vIdNnkuWNUF4lp7RbLhQONf+vivCsRWETLwGqOIexSiyeO49H8hUuDEx2dzd/oFgSdM77dj/S19ac2YBF0EsiUpMJFAPyJdeeFo5G9qrstnlOmNnWLKHHz+Objh0FUP2MXS0G4G7EgK6wUYOLPY28fym96HXNxSrde3vALccc7FYZhSRQD7fkXnXG6vndjqu7Vr5+J1JM2T560EEs7JRwZLO6q/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPIaIN+NpeS4fOH7lPyBBM2zw2aiR1/MlAvF9Nmw+pY=;
 b=FUINxKX5d4tPJBRz2SXEB93fVcBxZJqYGa63jRtxLWs4zeWkE9nkXSbf3MQP3IdHKlRdLluSv5DRncvUAfIJC668UEqQxdsG3BQhR7OBHntpBTURS+ORwaiY6YJfhvaSmVqcPQXkZK9ksH+bMGCEcoxMwJ0ZxPH2rxzAMJfni4IOZPL3vRGkUH44i09dyx4LHC5k50as+X2Ym81ikJUvQuSwiTmYutGhajKJRw6lXHN2dQBBqZvbSKWsxVCEIRjby/cN1bbXDeTJ+3E3yv1kWWn02I8vxI6IhtkLn6XRS9gJUDkFU/EWBo6OGgU1wCPQZcElIUTlzKWnp6VV57No7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPIaIN+NpeS4fOH7lPyBBM2zw2aiR1/MlAvF9Nmw+pY=;
 b=5ui2ySWCe5tkQXVjHrDQrmeoBjh0Q/qIyK7uxABTcgUoePLOgetfnxqODXi8ZSfQTFZNfaos8pbfNQhUso8rBY/yvjy0tVq2UHaZGXzdjCjx6r3HhRT2dfOf/HkOa837lPLr7WeuBY0er7unm4fXu3gsaLLposbgmBeIh1tueLo=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM8PR12MB5432.namprd12.prod.outlook.com (2603:10b6:8:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 02:02:47 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::6242:5c8c:11fe:d7e9]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::6242:5c8c:11fe:d7e9%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:02:47 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix vga_set_state NULL pointer issue
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix vga_set_state NULL pointer issue
Thread-Index: AQHZikLKBKanJK5R0EK+NtYY0dKpgK9hcfrQgAQccwA=
Date: Mon, 22 May 2023 02:02:46 +0000
Message-ID: <CH2PR12MB41521F7700CEED906207562BFE439@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230519111158.1354372-1-likun.gao@amd.com>
 <DM4PR12MB5181BF00A429D4C4CB115D30EF7C9@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5181BF00A429D4C4CB115D30EF7C9@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fb67d2c1-42ca-4866-8dd3-1d6203923721;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Privileged;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T11:15:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DM8PR12MB5432:EE_
x-ms-office365-filtering-correlation-id: 2bb2d751-b7d7-4829-333b-08db5a68a39b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vRCoQK1BKLPNct0Bl+piaY0VkLnuUF3Kvkk+Pn4WTYfT9j8+pkD/D7ipP5DjC23mnaFSZ/ZYFaVEQC45Gl6US5ZHEk8e8IxDK5FoNB5jSUqNFx2Hc++aWRAPSXrXcwrHDQmfM6f5OpoZJeAj6cBTS6Vxp6EP4nZOIu9IsbOhqxpG0jYMhaSOY6dRxBUg5mPul4StjfiDan4F9n4k5++Hhk8vXu1tMLSaF/nDIxoH+LY2tNtr9pGHD71k2IacjKLvgJbZy+eCgmBsGZ4iOKh+j8Y1CyIq6/8SA2YasZpPH1FhVacAX27QxHde9WHz74p7Blu6xx7xe7Cv/RLq5q7PTEwtitodeYV9ONZzq0IoE5TR9ZisydspvFOYB4OqthTsuO3pL+R2nS4PaFp+2FKZKUoAtKEKRvbCrQBWqrmDelDHoesvw4BMQvHNzRRqVl5vdA/djjEe+ImU9Bvhe03R0aDtkxvb5twrbepumeAzSzRy/KvzpoT/SmM85KzIFbz/2Xp2O7Bt4FGOwoDFpJBmDrUe5O3jKkqmECdZ8XXNtLzaJLViJxuONZo3plCKzdhk93U4lw534IVOwF3SRPcWurvnE1+QDhOTTqt5wbxe+U8cGWwZKwemv86zxOYYC4W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(52536014)(83380400001)(186003)(26005)(53546011)(9686003)(6506007)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(7696005)(33656002)(71200400001)(55016003)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(316002)(4326008)(478600001)(110136005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C7i3TiEozE3FEYK0fMBKDcUUuB+b+Cu08bbM7lDQ+Npavt8/V+oYAnWkfWum?=
 =?us-ascii?Q?4tEe5tSLOmnwYu2EFS4UsH939mM+wdbjZw/Wb9Cm65asm6LcRvmYsq6L9D2L?=
 =?us-ascii?Q?PU2+zoV0I9dcz9ZhI53WFQpcyfkR0NhwPOaRnUk7uNeH3bL01nZaomZ8Ekc/?=
 =?us-ascii?Q?EHkRzVL39GpmV9Bi0wl7qD7ptoxbYMom748EZYRR9ebuc6OMXJjvxTrNCYC/?=
 =?us-ascii?Q?/49qdJVfVVglk1zf4WEj5r3iYSEWl7NDNGfiCeFIDwyw2Tr878r7scU1w8ef?=
 =?us-ascii?Q?qd18LTKkn/5u4AyZGKyJkyX06HMFQOk7MPn7Q+shWvLg24HnGXhPyab978qO?=
 =?us-ascii?Q?HWbACK7kMqp14vjXYk5pDkqExlfdF8cPvLNOSRDAn7WIlFo8ADkSv8LWX4de?=
 =?us-ascii?Q?/nOmYFAFumopF9TVWaNyaCR3wC2aow2NtsIdpEYwDH/BS9AtKTe3faddxYGQ?=
 =?us-ascii?Q?A1EF00QL+MrnpqxaCmM7gWvbvbaV2bjVAZrUtAcg0IFLifhcgTuZNZM3e1gs?=
 =?us-ascii?Q?m1MbB4YjTICjrxm2SHNoKtOPRlTrNIvGXREIVDpKDhmtaKDbt0Znct2c/jmo?=
 =?us-ascii?Q?h3g5O0Jlf/emPwe7y9hmRmO2Fu8CZ50MsPtE+GDRggrwUpGCYOHnLUuDU9wb?=
 =?us-ascii?Q?igvYVoKzZBApGTm0yUudz7QmPDNlPjPuFAltaEGUcJulY2s8TWiEBJHLvEm4?=
 =?us-ascii?Q?obWFTzf2+rtw7hb7MsNlTh3zCJyzyILMSI/YzahMGirsHP4IyjhOehJRGDsW?=
 =?us-ascii?Q?XGHVhB1J+xdV6xt0MFmGqPgrJoEWux8Yt+U18fDke9fjUugkwldEILtLOs22?=
 =?us-ascii?Q?1z9P8drsW18bfT4VCRSqZGAAqjcOekEBtHaQTbXIMJ5rlhiMYjkr8gk/yqIf?=
 =?us-ascii?Q?4Isi9XE+cXdXg5LgnjQndP8auwM5Mv3qJFx8ZRd+4My5u2/kPw5joPISpAOh?=
 =?us-ascii?Q?WW7wUo8xh3fptLqd4/UAjUomOvE2Wmk2X5LAwjD9dngeR0RYZd7l/z9bKcVS?=
 =?us-ascii?Q?uk8s+0/sGYqiFHQVDte4ViNKO3M7taHtjIArkL79cpnbOpt23BE/pbnsn4oz?=
 =?us-ascii?Q?8YSFVqC4WeOd9dKsb3K/y9D4vopHZusooBtcrvPVjMxBHQvtDY9GFJ7dkpNc?=
 =?us-ascii?Q?qDSQN7bmV/iapzBBgwqUj2OHgwrMdRQkF31kJK4tWOhOR8BRcOJqFRikOCFF?=
 =?us-ascii?Q?Xn2cbW3VbxZEZFR+TZyAUxwWigzJ4lF2vNJGhVaYXJOykIvwDMB3MXvIxRjs?=
 =?us-ascii?Q?KnUKrDdxmxeTyN4mybSFni77J8YWVLh4oCdekR7vdQ7c6QqM1OY5ha/kDvF9?=
 =?us-ascii?Q?IEObABleMvDu/SiBwpv+og+/BSQkS77qC1+tyv29BCgIyuDSzRwR5H266yee?=
 =?us-ascii?Q?NXNDqV3hrLf1bgrjD4hLgFVBfODjZvikn+M7qk1tvgTvrRBENNHmnpOOOpDk?=
 =?us-ascii?Q?zIGyX4dtMIoxpqJQsC75Qrnphf9iCi2pz+ExJ5bIdDkduLT4Qg1eUhz5VMCc?=
 =?us-ascii?Q?d0qIzSgNUYFK39ogOhm67yiM2wAh3gogPiBlDNOgRtMpfWPITmk+IzPaOK30?=
 =?us-ascii?Q?QMPRM3F9sJDZnuXP2A8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb2d751-b7d7-4829-333b-08db5a68a39b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 02:02:47.0490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nejntCZiGWv4eS6rzWFVNzDbVJJJ55piYy9ou2IxIWDHWj32tzKb5ghr5MSU2ULU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5432
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gao, Lik=
un
Sent: Friday, May 19, 2023 7:17 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: FW: [PATCH 1/2] drm/amdgpu: fix vga_set_state NULL pointer issue

[AMD Official Use Only - General]

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

Fix NULL pointer issue for vga_set_state function as not all the ASIC need =
this operation.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index ce196badf42d..5af954abd5ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1260,7 +1260,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 /*
  * ASICs macro.
  */
-#define amdgpu_asic_set_vga_state(adev, state) (adev)->asic_funcs->set_vga=
_state((adev), (state))
+#define amdgpu_asic_set_vga_state(adev, state) \
+    ((adev)->asic_funcs->set_vga_state ?
+(adev)->asic_funcs->set_vga_state((adev), (state)) : 0)
 #define amdgpu_asic_reset(adev) (adev)->asic_funcs->reset((adev))  #define=
 amdgpu_asic_reset_method(adev) (adev)->asic_funcs->reset_method((adev))
 #define amdgpu_asic_get_xclk(adev) (adev)->asic_funcs->get_xclk((adev))
--
2.34.1

