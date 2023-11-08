Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282EDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 13:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53E910E0A8;
	Wed,  8 Nov 2023 13:47:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990FC10E0A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 13:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol4FsIYiMIHuGo8xWLnznlK9MY7vafGzyQJNeMS+L9tYN1Jv9c0kirzejpFJsx7mKA63CIwQENz0tgZ8rR85/NJJQ6rjVQcX1qSC7IU5hvlx0i9uYnu/lHszg1Pbxztkd538sD7embZsWdxDqZ+czeE/xRudp+xbro5W9nxFtDLdt1+TbpsFk5zVKiYvsdI3KXsBYTmL6nVUrH7nmp6MR7RkdGKhIXD2QRajI7k5+3NYxmiVuuaEshyxm1o/fdaBY1Mia0QGWIzSnkHij+awFtUr+/B7j6RjFfp6/AiprYUVMidgfJdYjXU6MoZ/Nyq6xLdjN3Ir2PLuUzUhxPVrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWwi+0H/vB5pdvyAKpJK/Q925Bx0icyFwqxsUzvGBZ8=;
 b=Khy61newxmBejFst/ezuyIFFy24dubbntYwQEsiHX+UClQCE7VI8oQv84WqKUCjL6Y6wFKZrHjHH4Alr7BiS5CBGlPmjCKeK2Sj+rxGnOVhdp3scrc2Z1DhC0eUJP/9ZLto8ka+0RG1j3rTjhzzxGL3oPg9wTiE1atqqY/gTeLydsbbplZvIEDhpZiKKUzZXyv9F/UxReh8KXT6kiiv9lpqvLooPXnrb7uCIwjY7HmAdvY1A8WWeYGEQGOy/s7NotSXSiICfSLq3qEhBlcmfc3MKWaxd1xF8xlkQgzkIrhxht2Giiyf2hTcSEVSSj8UON0h0B3eC1wyji1l6+eV6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWwi+0H/vB5pdvyAKpJK/Q925Bx0icyFwqxsUzvGBZ8=;
 b=vK3T0Z7kcFE/ECdDqZiiUqVO/FsHHaO1w2cxsjVfWvk1ondrE+StyX6fY8PXR9pLymG7P36cObkXPvXSvRBPYrCxL1Z0Jp/q7zm8ed99wAQpABnX68TjaY5XdZojpc0vxg5pfiP7z7WZ0356BwAzrNwN4GArjYtkFKFoD47L+YA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 13:47:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 13:47:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: correct mca debugfs dump reg list
Thread-Topic: [PATCH 7/7] drm/amdgpu: correct mca debugfs dump reg list
Thread-Index: AQHaEkM+M09i+a42ek2VKaiQ1zKoLrBwb4xQ
Date: Wed, 8 Nov 2023 13:47:30 +0000
Message-ID: <BN9PR12MB5257AEE9E4BB0B87275E7FABFCA8A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
 <20231108125735.2497856-7-kevinyang.wang@amd.com>
In-Reply-To: <20231108125735.2497856-7-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=24306ea5-6283-4f1d-b268-fe167050dd2c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-08T13:46:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4419:EE_
x-ms-office365-filtering-correlation-id: 61dc370b-59f8-4769-b10b-08dbe06140ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HM0zQctw7Zv2alJXXCY9A1FaidAR1zKYZX90f+hx30BR6UtE1doGGIMefCt+b5ux8qmMn4v8k0P+qoBWpuHOayOwdM/VF05HtzG7ml1bjBp91ix5dOas9tPMNOeHWPngu7XSqkw+8GO+n8ZFS4KvcIw+mD8oLHQnNsyx7UPMEMURAErbTwesJ73eO/18iZhR1dKYtu4HTRrx/mgw1S277TI5ZGC0E57rBb1Uez0K8rJzPJgSyXqWJ7NqdnxeeSJKl9BTyYlzJ0t8/3nm79mVyw9gq2Ngyfi48uZfcmfHRukA6gXqQKN4IO2KZxC4jwIoW3dBSvMxBaZBZK1jst3mjGkwYZjskypSxjoTMnskG/NYUN0VAV5rqQXBsC5kN9g74HvxM4vNgV1buJQr94oAIoxTKecs50AtqgRoltb1oVIlVCXVCYRuUgQy8+khIieAL9gJqFm6uCwGVZswP8Lyhn+rTVamc6920zCoNPHsRvsI/DmVNuXd4nwbS1HF+oXU+uZX12lmtqE+vdoGVdYdp396nhibENBrOF++1LKhjXGCuNVI0s7qYaJXgDPWMGiRr4ACLdjndS6vMN76awMgiop0HT0ua4WEc4LniNcOYe10DlgwegVD0PPx89+J2gJ+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(38100700002)(7696005)(6506007)(122000001)(9686003)(53546011)(478600001)(71200400001)(86362001)(55016003)(41300700001)(26005)(66446008)(33656002)(110136005)(64756008)(5660300002)(76116006)(66946007)(316002)(66556008)(66476007)(8676002)(83380400001)(8936002)(38070700009)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fj2WmLLy8o2v6b3Fj2ZCIdeRwHlNdhT2NvFJwlkOfhwpPnxxA+qe9qILWfzh?=
 =?us-ascii?Q?TAIk15XpmyY7mvTWOHHKMw9bAhdnKaLE3T2zwI2XfiAkCefX3/xd4SYWAGIQ?=
 =?us-ascii?Q?F1Fq08ksv4HUBHF4twMrdn1EWJnrCXz/WseQroYhqgeO3c1TBE0x3kXqGMlt?=
 =?us-ascii?Q?RY7LpZeODQBSNoUMbQQ1FCRtrbJTEg+lO29YzmX36p4UKPsJDHUQ4crfviG5?=
 =?us-ascii?Q?uaDivBc+IJXFOeiC8sso4en3wSBHpZX8sEA5Kaky8srLN6SEdH6Uf5NQftGw?=
 =?us-ascii?Q?Zt8iJ5gj3XzmhNg0q0U6u709D74O610oF+RprSZUkXvDwMnJSKKuTp8uLoNU?=
 =?us-ascii?Q?viKkExzeAlltcMma7jdvI5RsEEleeVWwOEQtx2KdpiD4eFoY7bN3M5T2R5IM?=
 =?us-ascii?Q?9+JA2gS+VwPTSTWm0tkaCKSio84QmslZN7es2pnd2D8hkuZr+/vqa5+DNJL6?=
 =?us-ascii?Q?U1u4YUiWt7BH/3q4+sktl05mKhaZ0eIr6mbn+bEq4pFJS88IW3NtbH7cFZj2?=
 =?us-ascii?Q?UQteiROd2cZY6U1+Z6BtyyKv13HvwPBfK3Pt79+iSFrsn/oE9NQB10D30mDB?=
 =?us-ascii?Q?tjvIHJ44tnpmYSNrw/jSsk0rlCvCCECdQ9Xjt+2YldrJmTo4EPx+xPXaPvCU?=
 =?us-ascii?Q?lpXyRh+B4BweUcB4OajMw46mh71wUYhnIK8t8vxncJRvTsJFQ5tO2DKma7fH?=
 =?us-ascii?Q?FB41vH9AixikEsOCSUNtaDNTVxI9Zy3KEuG2yf9LJmF2DEatlwOcPuovDZ4w?=
 =?us-ascii?Q?WGRKtksjUdKuPJmwfXwc9WnQRKnCzTC2JqABvYD0jOh+/ZzuNWBK7PiYcZlt?=
 =?us-ascii?Q?GuwG47R2NiTCPX9bLg6X1H9Xk7kW47B7kUoxPa22zzbwW4P9HbSqzyOv9cqB?=
 =?us-ascii?Q?eYtHzLvH0GtrfTPcN/FjgsY2Nli4oOtg67n0+opKgqZz3X/8H1N+E/mnI5CC?=
 =?us-ascii?Q?POsHfb5Rqy+BkYWu8G2LMk7YxBijd0Uuhi5qis9k8K1aMT1mIF62zN8WLaC+?=
 =?us-ascii?Q?k61clYM6yMAm71CWVpsUSo3YtqcStHh/Bqfkcg6GRtI29GhNAnUsnO+v5/B7?=
 =?us-ascii?Q?w9dDMdpCWubFlPuIOPRBeTpEtD03QIQ4/REr45OCVtXtapOLdszCkY550/D3?=
 =?us-ascii?Q?Bgi78kHzbjj30kL7t+RZPUMHp/XZ7ya7hFukuGQzhs5To8PmeAsQtm7HxMtZ?=
 =?us-ascii?Q?PUONeNHOvrKBeaJvp4/xIsN7k7l+KRQvGjpKceqwfFMSC2wp2PGPw7HOF/WF?=
 =?us-ascii?Q?QU4AyNmhAZfEAhcm0DRi6yyo/118LrR43EXKluugzFHOF9+B1jjI3SlScvnb?=
 =?us-ascii?Q?7k9XH0sKZ4x//Sa+XjbauGkRiN3ZGw+XBdmhLIe9M3NQIJh/XcbrkzNwjEvB?=
 =?us-ascii?Q?3OT+bNfWHNps/F1qnSvdpVOJRkNV0UjB5xcRLEkftpxEFb7E3Mop6SN9n921?=
 =?us-ascii?Q?dlTCww2Lc1uIoMXe7pKUCddgjbRiVGCRUFMicZbLhx/SDHNI/upjLkoOtOmw?=
 =?us-ascii?Q?+D1ASMkIcxB1FA44i7kx4r9aOMau38nF/fR7FVkivJx2G3+AQ1+gi8TO6XkU?=
 =?us-ascii?Q?k1cMtH3LHfFJuxmPPaucU3X05Pxx/tZA3OB2gXgm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dc370b-59f8-4769-b10b-08dbe06140ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 13:47:30.4067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iuv0U1NCJLB/xUGWynq+Dn65G52viANRHZMPXtxqfM2HOWJdgIC7GDlTyDgLNzuiqT09a82Fipo8Kz3wOoMUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, November 8, 2023 20:58
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: correct mca debugfs dump reg list

avoid driver to touch invalid mca reg.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 65926f3c708a..cf33eb219e25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -389,14 +389,21 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, =
u64 val)  static void mca_dump_entry(struct seq_file *m, struct mca_bank_en=
try *entry)  {
        int i, idx =3D entry->idx;
+       int reg_idx_array[] =3D {
+               MCA_REG_IDX_STATUS,
+               MCA_REG_IDX_ADDR,
+               MCA_REG_IDX_MISC0,
+               MCA_REG_IDX_IPID,
+               MCA_REG_IDX_SYND,
+       };

        seq_printf(m, "mca entry[%d].type: %s\n", idx, entry->type =3D=3D A=
MDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE");
        seq_printf(m, "mca entry[%d].ip: %d\n", idx, entry->ip);
        seq_printf(m, "mca entry[%d].info: socketid:%d aid:%d hwid:0x%03x m=
catype:0x%04x\n",
                   idx, entry->info.socket_id, entry->info.aid, entry->info=
.hwid, entry->info.mcatype);

-       for (i =3D 0; i < ARRAY_SIZE(entry->regs); i++)
-               seq_printf(m, "mca entry[%d].regs[%d]: 0x%016llx\n", idx, i=
, entry->regs[i]);
+       for (i =3D 0; i < ARRAY_SIZE(reg_idx_array); i++)
+               seq_printf(m, "mca entry[%d].regs[%d]: 0x%016llx\n", idx,
+reg_idx_array[i], entry->regs[reg_idx_array[i]]);
 }

 static int mca_dump_show(struct seq_file *m, enum amdgpu_mca_error_type ty=
pe)
--
2.34.1

