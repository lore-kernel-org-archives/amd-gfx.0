Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D590FC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 13:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA5B10FF08;
	Sat, 29 Jan 2022 13:54:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1BF10FE86
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 13:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIYBiT2dhgbBQQMMGKlpjYIB6yz/iZsNnCkCQQpMZwO2PEs668fo38QzhH4tFivq/nhb+6ZmA1eiBsg1PtHl4DOuTki3Hj1QykrCuxqOmW1RWa4XCfOGI08wV5MOXT+Q+H7tmgWscR+M4x36vysQp99VuLw4Mm/R3/pfRTM2fWk57Fu71mTP/bTbE2uu2COerekFQIv2GS6PzJglhKm8cgN/kpGY9dDPcMt4ykC/yyFU1vlH0f/18wA7IQj68lfNbrFNf6GAt47wU65eTg5XyhDbwA6gHaYWpVQP0JXARPaqvgxKcnvplS/kz+JtD5WvkxnCGtTWu6Lhe1LrC5/i8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q/RL/+JwWXAABNz/fDlSVqTA1Yum0Lo3Fzlsx0lcOg=;
 b=XaSvuA+wy10Jsgnt0Sps+t2Sbh+mNQJGH7unrs0/S4CKa9iTADjHcgWOxLIpOYH/IvWwI/OBSNjcWDYb2HhiXxrP0V7r7OepGDFMuFrOR6WeR6UW8ZhfZMpcAV8MFIUte0kfHY5RwBb8x7tNCLMz9lgyTytGm+UmXjUxw0RFmwcRR8HwoiD4Dbzipt6FXHJq9uNyANVlDJpdnAQG9VBQC6v5f/LvS5slhmnXl4IIzXkRfSpaOy+YUiY+vQ1txi7xcYDG4NxWMzW257MxJ4KOs1Ve5uOrx0qIaVkpXZRukWzweRL8hApmew/rHsHJ+Rieuh2xmu5umGOydNfOxhRxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q/RL/+JwWXAABNz/fDlSVqTA1Yum0Lo3Fzlsx0lcOg=;
 b=B67xddxtspZuKdr7MOKHFzpDrdQGzpV3mfNDjqvTuoM5O1BS0MgbW8JTzgifsOX5wSdGNtAw2vinIUEzqnqJCaUOcnn3jTQlEjJoM8Wc9B8RpWwmRS/OR42dYwmXzyrW78K6I9ZHw5D/dq3/isime2EGm0OLQR+064ToDuyge6Q=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Sat, 29 Jan
 2022 13:54:40 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4930.019; Sat, 29 Jan 2022
 13:54:40 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix uninitialized variable use warning
Thread-Topic: [PATCH] drm/amdgpu: Fix uninitialized variable use warning
Thread-Index: AQHYFBH8znevdJ+XiEOYkM3QFlKcAKx6BveQ
Date: Sat, 29 Jan 2022 13:54:40 +0000
Message-ID: <DM5PR12MB24696B7A2FF047BE8452C42DF1239@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220128064019.2469388-1-lijo.lazar@amd.com>
In-Reply-To: <20220128064019.2469388-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: lijo.lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-29T13:53:15Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8584dbf9-c6a0-44eb-b973-5e356a2ff8c0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-29T13:54:37Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f6623c48-4771-4a5b-bac4-3fc504179c8d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8578d0a3-1a9c-4b54-ca58-08d9e32ee57f
x-ms-traffictypediagnostic: MN2PR12MB4047:EE_
x-microsoft-antispam-prvs: <MN2PR12MB40470DF7EAAE749F5F0AFB4EF1239@MN2PR12MB4047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcNTliAUbA530eEZCiJb26LN1axn3N76mIQi5ViIhnqmGIKPc4BhKXNbgEKI2bHf9zE8i1H4Epwx+VYEcUjZQbw/0SKNF9zJpuO83DVqeBsC7pXps9D2e1ctj8NeCr3DS41AWTrO07DaEx+kIHFNnkvgoQK/+FX9XY71NoBXBagooV8diGG9xus6ocT6Wt2hSQOd0/s1VGWqEtcxXSI9JInlbx3i54+cmJ9c4vncgLSQAmekedvAG4VXK3A16DlBYlkyZ+ERDDj1BPD+a5QDRQZWrLqqjB+cc4CN3UfI/LRldy2i0NDBxWWwQnZoHisgYhoUOjbVYOTGjLs/MSV9PJo4Umju7C/TrEt4+RSbn5CXy0MvltvCzT1bcb0ntXEqQptGs8e/3uBp+HFv7doNoxh0zZorPrt1QzI/KXMvlsPlc7N/+65hvvqsftX34jw6Vpa7lxdV8lAiZYIP7HabcphCLpkfgyAa194AMUoBJNEWTa411rIi67hUvPav0zE9GH2Bhc5+Y6EcKJrAeZeXFS7wisDOzVC6y9rWyJaZ4poGMsmVMO0iTOTTr0Th73a3eRD7jbNtIkMkmPbYLEPWSzkmphx65IwgvysDHxVmzPEREZREFnhWGfGtRN39rrid08sIcJ8jnqdg6+9bVSKHO6wHv6DqYPKnx9ZWHgOZVMS9AO8oK25CdeCd5oAuAXFJH6Sh7QlGrOfiNFyFv/Qb1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(53546011)(6506007)(55016003)(71200400001)(9686003)(38070700005)(508600001)(122000001)(33656002)(38100700002)(83380400001)(86362001)(52536014)(54906003)(110136005)(316002)(186003)(5660300002)(4326008)(8936002)(66946007)(66446008)(66476007)(66556008)(64756008)(8676002)(76116006)(2906002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Shof4xTaG6vFImsSIzhS1yE9v6Juzh8FrYqVgPI2l+PqueLwXwXpIHJEDo+P?=
 =?us-ascii?Q?vJxuuTqjkqEgPGFSGd7G5SfowOM5nbAYsw++m9cEatDV9UHf3Em0nnBTlpLi?=
 =?us-ascii?Q?mI6rUjwHFVf5fk3d+QoC8ea146nemKrCnkDooNmhK0s+ywIYrNU+II+sWCdS?=
 =?us-ascii?Q?BXb906jXbe1GhaKK+lCLJ0LSSPjvlMPPnqLUswC9GyP1diRP2ARBXKRMt/XU?=
 =?us-ascii?Q?mETg4uGqcC2JMAdDuVOzFU8XYAH/t5wzmHayHHm0Zmc1SxzSzemBcH0jpNMx?=
 =?us-ascii?Q?miJ8hc0sAHsUfYIOITuG0cXekLgzyWQbxMUKpkP05cGAHD8dnaqnQz20XjHK?=
 =?us-ascii?Q?SDgl82JqdCnKm/CLEXg2GgKT84zQDVCdLs7pOAYG6hEjE1sLVvnUtbC4Mu9H?=
 =?us-ascii?Q?OIwJp4qz+n9Y1SBuNkl27dSJzwhu82CH9fBcb8sJxPP2Id5j9h1PPu6/7EQf?=
 =?us-ascii?Q?CAbWI0v1j8cHA+FcHduUUq/lI2y4MCBVHEy2iWKwjrVveKgNDoxn6ZtPt81v?=
 =?us-ascii?Q?FCn9LkDWbE9gF7/0s6RO71moQt3sAMcK42KwpAw3c1reeIJtdwvohNh8T0+4?=
 =?us-ascii?Q?WkkeK/GhdHToGfZgJA1xe31RLkeTp/Nf7tJ6YiDSg6k77EZR6gLC1N/TINtf?=
 =?us-ascii?Q?Mtgq5l6fjhR3p8uNYgRwSfQSsDrcHg0DB6Ygu/3AkmQUUAkRKGIaPyQekgmm?=
 =?us-ascii?Q?P0PX1pqLQ/6xEsbr1nMSeV5Px4eE8cRofPmA6d6H7ePT0RNF68dFcE+GKIKG?=
 =?us-ascii?Q?g8Qqw01ILlwyj1htN1WonWVgnmAj/So/2j1j91ost7VxZNZ982mrlkEHRjve?=
 =?us-ascii?Q?8qJH85S8QPmPQUpS9vdd8DJw5uoX4n7E8+aFLalKQusPRmGt8UgErmMqcUB7?=
 =?us-ascii?Q?y4k9p6FXq4XkY44L00j4HbARrngXyoSybaUfHV4fn+RP7fsPOmcL9xkJYk4q?=
 =?us-ascii?Q?IEKkUoQr8TPoDMU8MA+1iDurkPXw3nt4qtNo0ZhA/I4A6nEWG3/tZYoMr8Wr?=
 =?us-ascii?Q?7p9GaPTyJTSQsqoJUito1xMOR0fUAPtGqmtElr54STB2b/8/nbWMQvNwnT+K?=
 =?us-ascii?Q?BgNWJz3jBpwjDzuCvn+5cKtP+N0LQxDoPKL7osYBhq2EGaWKCGIhM9pOT+Id?=
 =?us-ascii?Q?tdfwIXFcDqKzZuelbMhSx/E88uPvPq5lZxqNebQBEM/+dDNMaJg6kJ0N3i7Z?=
 =?us-ascii?Q?kuA9YRJDXBXMb4hXoSdWquF+yApOn0u96P4PU6CKUBOp1yesE6/3194D/rTH?=
 =?us-ascii?Q?ajFe038gnV452zY8uZNjLvUOFxjTzoSu66Nd9A1H84/l3GfqD2ODx8PZf63g?=
 =?us-ascii?Q?V3X6NJlbHraxSSS0zP/VnBAvGB8Qz0W9gB9PCVffRBDf1iEZ1VS5TO1B8ENU?=
 =?us-ascii?Q?OwjZ71xTiZUfmJzMZAYhx+gWRgm7N8Og/jgeceiMVBwQTJ90EGimJjkXqcyA?=
 =?us-ascii?Q?KKFmoBsBDbpgGfTLSZnorsnsXWcuAD6y8kpcqWbe/aEHQcBdindwNl8n2Pgh?=
 =?us-ascii?Q?j4xS0a9GnXWFV+yiohmlUhDie6hG4v3aFFtVvw1X8g12Mzb3E2/Xh2jfkOy4?=
 =?us-ascii?Q?IGORq74f9FUxKogBZ3MRzGuiMvibnQDp/NfXXLDalkeH8Al9TBcCYNuXdxzS?=
 =?us-ascii?Q?XtR2ato5Q8E6Nmhd6DcWiWYhC/6AAP5IDjt1Z6SoWFTSDZjymNsYDQ1rrB9M?=
 =?us-ascii?Q?wKv0E24g408eSRpUr3lxMEKJJTM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8578d0a3-1a9c-4b54-ca58-08d9e32ee57f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 13:54:40.7525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq7Wz2WYGN7nRn2mnM+gExb3k82nYQ4ddFxh0t3Kwc7UXPXfZ2idhae6pTYMTNV3qDhPzF1V+DoHrgqV+UZiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <yujie.liu@intel.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Hi @Lijo Lazar,

Can you pls submit your patch to drm-next soon? This indeed fixs the regess=
ion by rlc indiect reg access related patches.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, January 28, 2022 2:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <yuji=
e.liu@intel.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix uninitialized variable use warning

Fix uninitialized variable use
warning: variable 'reg_access_ctrl' is uninitialized when used here [-Wunin=
itialized]
     scratch_reg0 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->sc=
ratch_reg0;

Fixes: 51263163eb3f("drm/amdgpu: add helper for rlcg indirect reg
access")

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 80c25176c993..c13765218919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -875,6 +875,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device=
 *adev, u32 offset, u32 v
 		return 0;
 	}
=20
+	reg_access_ctrl =3D &adev->gfx.rlc.reg_access_ctrl;
 	scratch_reg0 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scrat=
ch_reg0;
 	scratch_reg1 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scrat=
ch_reg1;
 	scratch_reg2 =3D (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scrat=
ch_reg2;
--=20
2.25.1
