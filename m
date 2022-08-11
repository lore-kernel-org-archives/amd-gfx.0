Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2AFC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 11:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEEBABCA6;
	Thu, 11 Aug 2022 11:29:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6263BA9937
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 11:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb/XbMBx6TH2oqlrSo3OWXxu9A8JFvkXoJHOBEbOyVuprPJd8luPAtpGXVGSRSdCRQTdb8VE1NBjZF8LIAL1TRes+MFr6HmKB7/w+qJ+W4Z+bb/P7d16ohQmS8AfnLTyWWaRlDiEg173iaTrsoIzjHkw6PMTobtDk5uUleUK3IRxpLc5oUKb3xsGVKB88eAdsCNxqlDGleLmo+ywmxbg4/vF+mNHrk96jQLOl6ljPCXxNAmAfqRJ5iQBUL9DCuGxNPNiWUI+DaQlgKWFl7IZBbhKeQ5wgEEj9X9pR11wMpSjQ9I7cQMDn1mxtcqjCzRLq0JDSKjkjgQKKl0km3fgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrgMCnVjN4A26zldN7/i89OK87iNaKewOC+ZUpG3hbI=;
 b=UVjD7zhyo9UumKnelBocYd52ZdZ0mrifWE8Tn6KDTz7dfwDBIReiMixrSBIXMunBvNZPQIi6eQuIuSgjHF3/15xaYx0DvVaa9OLyUXND+472U0otVSQFOpxIROeHMufpyXnWcCAwYmq8UQum+GkO08nCpR/Tvgr2LSloiXyc/lxxrBT+tyiO4loOReMWYVmApVeA1kWGzELJw//97gLaN89Ow0qHrEKyVwcDGFZwQFjyFknfw3X2/ImHLHFvuyfstjWoy6Dyt138wZDlqO8RgoeMH679rLb9naY11U3lverVe9PCiZZi//yRz0H+2yAiKr+nNJm3mPVPctSGYedVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrgMCnVjN4A26zldN7/i89OK87iNaKewOC+ZUpG3hbI=;
 b=hyssm4ywbVr9qouJJBTGtCIo0Fxotb03Y768gNfjRhkdA4wLrH2tv9Lxa0jTb5WgOjkUSSOVR6+cOdj+xlSJsvXedECC6rMY0CEGoJnRJLXv7a4gimmcxdYrB6PqT41cJZ3sP2kb9IMI4XRv14/kn95rPWR0tWar43VgpLmDT24=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BN8PR12MB2866.namprd12.prod.outlook.com (2603:10b6:408:68::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 11:29:06 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::f435:36cf:b1f6:fdf8]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::f435:36cf:b1f6:fdf8%9]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 11:29:06 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add mode1 support on smu_v13_0_7
Thread-Topic: [PATCH] drm/amd/pm: add mode1 support on smu_v13_0_7
Thread-Index: AQHYrV4WG3E08qbuLEKXy9JbRAXBGa2pj9ag
Date: Thu, 11 Aug 2022 11:29:06 +0000
Message-ID: <PH7PR12MB5997F6057E3CACFD664BF52082649@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20220811084029.1924377-1-kenneth.feng@amd.com>
In-Reply-To: <20220811084029.1924377-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2547c94d-965b-4053-b706-a37f114263e2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-11T11:27:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45afa6ee-f85c-4fdf-1fba-08da7b8cb3b9
x-ms-traffictypediagnostic: BN8PR12MB2866:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgJv9v1vDfofXedirwCIqhegX1YfovZyvgT+zJE/qizVasr4zPNY3BARowOtSYF0lvJXeMXh7g+EXERigAL458t79UZDh9x7INaoi4UGT75uRxoS0PCQrTj9LmvNcku0l1/RqR+ytnyFRmJzvHBWyPU/TFRvvMUM663vIE6/qgUUQsXGGai264/92FnU8jdFIXnoabCSr1bE6ZxiSSPIkx+7UXNC50B4lzApVuxMiitFN51BYYxrtQAuOlMMuA0VPGTubgWtxD7NnD9OZ/wieQ4ssEP9v8fxLhX2DGyXMptylgws565fTZyVuOjI5G3af4SOcEjBoZrZn1op66oiGw3LFHgLOKmmo1PQANBCaFYIDc0W64uDW1uoe9v9pCTLd8kziquO4YK9TmuXe2LSMGPU6g7vb4J3IFImHdF2vVRQDEmvpbvM3UThNHhyPrjt4nwl4p5kgbPjgTn4dCJcBERWXoK+HY9Q6TOmc73IiaOlmwyJq+yBeZkzVHiC4IQN03x7/mNfvmoYkjgLvUy5QTfwvoxIIQzu2QBw9yItOvgqGuFDYPu+Z1KsN6UaCJXDZMjfqJ7n/Cyjs6w716MPOrngWtaSbjQypuUI2dPa4gYXIMN/bZ2bGUJZTnV8CF5MyNuQWgweM2tiphpn+vw+7E72eHQX/0hHduOLS+aBz2vGen80TGdX2gd+3fX2OoMnQHP13M7qAFfLnb/AAMvC8eA7N/2V/umnbHismXHYFxleyT5zaZ/4GtjzvVaRJeyUUIZq+uOUp8aaHJObclkwdur7fZE0wL8Tuo7SlN4olK+p1Ip3WsXZQoE0re/NjB/R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(186003)(38070700005)(122000001)(38100700002)(83380400001)(8936002)(5660300002)(52536014)(8676002)(4326008)(66446008)(66946007)(66556008)(66476007)(76116006)(55016003)(2906002)(41300700001)(478600001)(9686003)(26005)(7696005)(6506007)(53546011)(110136005)(316002)(71200400001)(86362001)(64756008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F88csSEiJDfrhBbe2Up+7SonJRj8+uCmZCVsowCjKQF475gDs+J9wr3Z9tZS?=
 =?us-ascii?Q?TYfIMme//TO0lEVfE8NMJsWkj+3aQjdl4SR11yHYIvE57AxX3UWtH4Ks8IBI?=
 =?us-ascii?Q?OCSw/E1tj5XYrFRjkyXpjXhLb8PQiTgr2sm2Qg2cEO4uzbGgAHXwim907Rd5?=
 =?us-ascii?Q?SS5pTkVMcUU7J9/gKhVe5S/mrJvy72vzrTAzZB4/LbZREK149qQPt/4ugnAF?=
 =?us-ascii?Q?pwzFGAmrX5WSxS1vDpnBy5x56KUmMT5elAPxRGFn22Bo+fPzrnurthTiNvrH?=
 =?us-ascii?Q?xM8YiIxpf/yliEGuIVR7gffAKHytRgzN3GAAE7M4PR6Yf5iZ0zT146OqPWdQ?=
 =?us-ascii?Q?hZPMksJGEDsnvvA/rFyfpX3TMoSd2RxKjDaDHggEr6i1/fSpq1Hp4cc9rOIM?=
 =?us-ascii?Q?xCKz4Y4q/E7PnfFCtc09dMZHLj0anwDrWb/XwerQTbLsO59g0iYpiMebsj6b?=
 =?us-ascii?Q?WIGYVFodxpxSpV7vNdNXPgUXw6OTrge3HmNqPE++riLWuP34Iu9dNevnPndW?=
 =?us-ascii?Q?EoUASRsyJKm6ccX15bak2ZB1rsUbsEtd9BKx+wepLHp0p8wHFOot5gupGgf0?=
 =?us-ascii?Q?1ygF4lrC6WU7LBRVIt952A/UaWmZ5BzUjLdbG4Dhey4dZ9HeX1SYUZ9HEh8u?=
 =?us-ascii?Q?3DyFjzEkpA48nKoD88KclqOVksqQbSITO11c3H9Nllfq7G3yuxXu7QqWnQOb?=
 =?us-ascii?Q?xpAjJOCGiFO0xYZLC3bTdDT0ENMbYw23e6xZ3z4BzygVyCk5nODEb9jGfzKk?=
 =?us-ascii?Q?TISuxtaOaz21KNMjwAStKNZFucH5bQ+jm0ePYM1rKJ5GknYJ0ERXloOL5nP/?=
 =?us-ascii?Q?V/K968Lj3I5rIVXWpuQUmom6+fvlOmtqFwWKclgwJ9tmsnwNIjg1SIzqRpbd?=
 =?us-ascii?Q?6xCYEkNyTOzezuVzzhU/4LJZk9Ea5CD0jlkL8T3xlhEiM8yfL68qd5Ln+Jqr?=
 =?us-ascii?Q?0hGb8Ok/nnZ3NPXAwGBhgBiAdWp3untKqbSXkphn17pcDwO8vHOGaqzfZpTK?=
 =?us-ascii?Q?ejziopwDW+Ag1XuwuCZbqehEiDyeZ/zwFm9oYW647gzD0P/VUe2VnNHWfqgn?=
 =?us-ascii?Q?B8+aeCCETFLxIW7oh7PQtnxpUTnnALQ98uU0FN+1t6rbCk+7hpwAxyhRNI9m?=
 =?us-ascii?Q?bQ+UktpNaPrBCfaTHYDtrrwQqmsciRWusnLvVdwYymrYQ0EQgTeCqT2LYTSR?=
 =?us-ascii?Q?1mKYIdw9eGH8IpCWlFQ2JSO+T8GGJ4DPS9xKKZIVQkeT1Tf3kN4gHVtZhtdg?=
 =?us-ascii?Q?nrLpWnONkL6S5hfPuvFnFxqQh53RW+e00Nqd/OCyxeJC54+1hilOiSEJ/Gpp?=
 =?us-ascii?Q?+1RM8WpKRnXQuCJYWQuctO0M8mh3I+3OcHdgTw+Qe1q/LECHBs8XjCoQBYaK?=
 =?us-ascii?Q?j2KJp+3FbWQgUhpvhu5DqjIEpXg0zrm/7CS0P59gSUfqUal+YH+enxTCMkIE?=
 =?us-ascii?Q?8zoxIF/D/aAWRb8vhZ2QNOQx4taCdvi45uBep7yMVQcMOrQ5cXtuxahGqsAJ?=
 =?us-ascii?Q?TWbZQQfUBdLMCEy6vWDed5zsbJy0JOhfBX+ofq/FDKf/R7Kb2Stwyfng7Aa0?=
 =?us-ascii?Q?kl5WXvHst0pHz6ep3sg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45afa6ee-f85c-4fdf-1fba-08da7b8cb3b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 11:29:06.6769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: janfQgPxLiddTd/aF+ISTBABJHo29pYJDx8aZWtuFkk7mY6hEg4QY169YiG+f9vo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2866
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Thursday, August 11, 2022 4:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: add mode1 support on smu_v13_0_7

add mode1 support since it's missing on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d78375d9a141..1016d1c216d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1567,6 +1567,16 @@ static int smu_v13_0_7_set_mp1_state(struct smu_cont=
ext *smu,
        return ret;
 }

+static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context
+*smu) {
Is coding style issue here? Anyway, the patch is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
+       struct amdgpu_device *adev =3D smu->adev;
+
+       /* SRIOV does not support SMU mode1 reset */
+       if (amdgpu_sriov_vf(adev))
+               return false;
+
+       return true;
+}
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs =3D {
        .get_allowed_feature_mask =3D smu_v13_0_7_get_allowed_feature_mask,
        .set_default_dpm_table =3D smu_v13_0_7_set_default_dpm_table,
@@ -1626,6 +1636,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
        .baco_set_state =3D smu_v13_0_baco_set_state,
        .baco_enter =3D smu_v13_0_baco_enter,
        .baco_exit =3D smu_v13_0_baco_exit,
+       .mode1_reset_is_support =3D smu_v13_0_7_is_mode1_reset_supported,
+       .mode1_reset =3D smu_v13_0_mode1_reset,
        .set_mp1_state =3D smu_v13_0_7_set_mp1_state,  };

--
2.25.1

