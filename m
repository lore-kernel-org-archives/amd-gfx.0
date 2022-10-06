Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4371FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 18:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7293E10E660;
	Thu,  6 Oct 2022 18:11:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608F310E660
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 18:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW1uZ/udqIhyn6KJqtAXkPzOk5pBocGYrt0W93OeKZzZ+MVQycpkJ7j6//hVisT8djFKTydnYbfCCCLZhihyGD3hZffrI32gU0BrIv7hyF9+blApwgatiL36dGQf4PCX46PhmvQR53V67DXy9YgQv2tTLZ9yV/98jcsSKiefexdN1X1aiOb/RTA5uYrDzE6j34lDP1wse1eD3jpey6WyUGvwfxYEfAYIbHDIthVUmOupcWpBYRElF4mMDOt/6kqxjvAGSnr7xlCN4cYRi+uzGLvnyoOS26Dsd14b0YpC9vfW6m9liYXzhRZKpMoUyliJ9V5X9r9IAM2B1n9+n7WhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiAj8wAt3jhxsIWZVOjLyuKuHbEp4dXVlUCb/SNNAx4=;
 b=eeewXwUj2xg5iM8fnFuq+IGv49pgpaaP7ZWkiq9DTPWc0QFByPGT+i39+N1sJ2tZZCOXqE0X4Bhq6hXuGV/3BBth7BX1auQqsM+uP//886VbDZu8TjfQvS5Ajq81PEGbvcDEsBeHQgOTn2gz9mIObADuOVlXRDEAuxhkm0iQkyjOO4kiEGnrzLmvQ4cLCgfWvkJvnS1gVPgeitACNYoqV1gnL3Sgr/y80uRdwBqTCGV1QdmIsOcJQpyRpBs8bgMrFpkf+S0oWwKK1tBcvb4TpH/0zTF3ZvA4C/CeWPJktMaDSaXjSt4krQt319msHMeKsC9dFY+yNyEUg7eEHJNsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiAj8wAt3jhxsIWZVOjLyuKuHbEp4dXVlUCb/SNNAx4=;
 b=zRJVlCD6QOaTplK+488A4U2bkpJHE+WrE7a4Uv7FGfxHZ1jN7NXTMsA9XVYvk2/gD/t/naMOWrTi11Uv/elKk50BYsznhvySqAMZOz43u9314SorQVlvszq24Mq/e68SmNLuWqJPmxio23wGl/TIcTQ6jUpvUcSIql4uRX6U9D0=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 18:11:28 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::228b:1a06:f715:e460]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::228b:1a06:f715:e460%2]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 18:11:28 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix SDMA engine resume issue under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Fix SDMA engine resume issue under SRIOV
Thread-Index: AQHY2a6uQhYbBBF2wkSY+KsfG9dMZ64BqlbA
Date: Thu, 6 Oct 2022 18:11:28 +0000
Message-ID: <MN2PR12MB2957F0AE3227749B07AAB7A4F45C9@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20221006180838.5132-1-Bokun.Zhang@amd.com>
In-Reply-To: <20221006180838.5132-1-Bokun.Zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-06T18:11:26Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=91adb879-e1cd-4af9-9c05-0dd7f9f29a47;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-06T18:11:26Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: db9fe773-f758-4c43-b25e-b38a739c35a4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB2957:EE_|CY8PR12MB7244:EE_
x-ms-office365-filtering-correlation-id: 9d70ebaf-a5ba-4187-c2c5-08daa7c6304a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyaro7VpEY/PMAgBhxR+cexEctjd8YdF0pljHVMHdoH5o19KT9an8yjRvFhuHQdyu1vCAgxoBzIYiwrsk4jlBkkVu3GKPdwx2giPPdf8loWjRZsLLQqzq3HuUnbAluQ4I87BiF/GkVjlu5u+Gie90S8nzSMENNaMKIhaFa65vL8mqS5YYzHUtq6Jkmw1/wqFtJq7q4D6lU1zL1p6s8Lq+J2f01OabsT5BNfyNFdDYdsiheO+212+aZQ2o2runMymhHLz1ICQnWR5rJrulsVz1MWFXAqOt0uLwv+nXipLknPfcmAXISfQGMk6U3apTS5eAosZw0QT4NpQboqEkdES0WBniPkPVmpZCUx/VD4/u8j7+shTjpU0ezT6sSjUh/hgcBFu0ge7C8qDL6v8BHB2pr70BL5tveqpV4OKvUECsxeOmlb/a9jiv0IL4LgHdA9QjfowoOtq2gwsJg1rPxYqurwvMHm+KuvLR6eWE8EnEMge+xEqu9UR+ne8qX7Y2FtH0Lnw6MeK7kuUnBAactMEx6dewhRVBHsUawiGvTI2hi1+b59/kcEtmLxdsr6KlR3wt7IhVuUQLt7qUsWMc8XkaLrUPsfFA3of9y/t/20TxUZi03TFdZqQsNzrBVcwDK3OwOHwqOSjt+2N1llOmbHfPV2nDMervbqX/MptL9oanC0/+Y/jeHFRQ0C+cWY5g9VirqWMswOwMEOFiNGGZ9x1NTh9XKlJc9AwR7kFNxMFp6Zx4vB9PxoEkR0PO4qhV0cVlbYMLhJk7FcvSeBlX40wrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(38100700002)(122000001)(5660300002)(71200400001)(2906002)(64756008)(66446008)(38070700005)(66476007)(86362001)(66556008)(478600001)(66946007)(83380400001)(33656002)(41300700001)(7696005)(4326008)(110136005)(6636002)(26005)(55016003)(9686003)(316002)(8676002)(52536014)(53546011)(76116006)(8936002)(186003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8KhULZYu3O153iWsYMd9VIMEYmTH4v8zM27BkDrmUt7j1z2T7HHyDf6hLu9j?=
 =?us-ascii?Q?xeJZVt8DPX290ExcdnEqOKMDD2YuxV5XycdKbDgafWN1lAFzcgZMDLB77WTM?=
 =?us-ascii?Q?UQT89XuXmARGFHkt9yhTG8PRBDk+YrE36Q8caqT9Fepf1VTvu2o0itEGPzCo?=
 =?us-ascii?Q?rUyt5mL56K8Ilx8cOMmpNGetU9OlI2aY9ZomhA9ti6OLRAtLd/rETp4JdxWn?=
 =?us-ascii?Q?NPxKglNaKKV873m8Ien4fHzqBY8b+l6ZBLgiX/5UHo1Iqf8h6F1CadIMsYqJ?=
 =?us-ascii?Q?MVukkVoBAELGegEyihTvjV87TMi4qRGUne+nUE6AEQDNjzg5+1JC7TNbXeDd?=
 =?us-ascii?Q?8kJHPY27EKwtyQglWkI4Gbh0Uff7jOiW1+Rev7x1tF2kafOOrgZA+e6IGYrV?=
 =?us-ascii?Q?8JgxfUcD4DfSxyLkccnlSiTpivp6wpFOTmGI8Lg2sf85D6dH5PQDDzQdxYag?=
 =?us-ascii?Q?+pNQb5uvfhNjv8KawJG3QZ16sFdAaDyh2HlYw/zY3Ec9/8CGMS6FgS3fI3WB?=
 =?us-ascii?Q?gK+S9NHfRtIzD0yExORBn7sZ+mUk3RkAWLscuNxX8gt3x111DFC/IMe3EsnA?=
 =?us-ascii?Q?kZCtbfpUByFQkGC1aa0J/g3zZhXqdpvlVq9irUHgnkX31z+M6DgLogShcB56?=
 =?us-ascii?Q?A5VuUD5bgmQ1UFW1obpMLFgXdQPtKCUir4XEj5c5jvzQLght9FumZL19gdfs?=
 =?us-ascii?Q?wl37fgJxQAhU8v8mxnKFOBoAncymktqqjuZ6OM210vVMFTxUCX2QribqITZX?=
 =?us-ascii?Q?mOXuKuBcl0hOpAvyV4UmBB/1JX+0Em4WOsriIuowzcWtYZ/qrYoVLRH04gBu?=
 =?us-ascii?Q?ADzp8Om0gu6LGmtserRk5bKZ53gavOtnFUI5mBp71AarS3oiq/50p1X2N9lt?=
 =?us-ascii?Q?cAAe7oaePfM1Iv9klX0dOWl+B1cIUZ675ljG3V7vGyplhG/n/IZVbYYfzrmv?=
 =?us-ascii?Q?p8CBTugtPjOtZwS+VtZDJFG4lY0J4pmRLnoVCn4+aonwDiIkYPIq8yrPTGes?=
 =?us-ascii?Q?MAKgXeubbMMPoaOsHr59xVwmjq5QNaQEvduW4tfcVrrg/3OLqiTR/JA5uU+C?=
 =?us-ascii?Q?spxVNZuD14IFJ1t5QdAP7IKspQbEiC7RhPqVY6MH0qB4PWTdLfAAwHHdTXr7?=
 =?us-ascii?Q?SAKvMTGiUonMFfWX1sKLAiLP5emGrmj5iIynE8xKSqshUSRTc/EPTS+cshqn?=
 =?us-ascii?Q?V76DaHxuC2thWp3HRyt+eRdbG3M7ppZMt4lHnDstPaYtB1etU2fxEQUgmGB1?=
 =?us-ascii?Q?fqc4r0Z1Und1xY56fzI5rh27ZmMmRCNSZz2IctX17p2uKewrieVNiAARV5sJ?=
 =?us-ascii?Q?kg+ySeIzbn7AucGVCQv/+drdQJOvoK8+sfk8Gt/S0DKYuLy+SfdvhM1zDW7L?=
 =?us-ascii?Q?aRRRwaT4E8DVtJPikuWlWbzYnTs7ObS3nQwL6Jq9u3CeQfAN9BWX6r3eQjMV?=
 =?us-ascii?Q?KWmT6Bm9Sm8YxbYAkyaqxMJS9+pcMFRPCK8Hjlncr8STcFMzTKcGw99w5tf4?=
 =?us-ascii?Q?CjdLwgljnXvYdWWS3wA3xGiIuiS9mcS02TGiZNILJD1SQHBWaacO8vmcICV1?=
 =?us-ascii?Q?eLYC56uKU/A5QUjXvyI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d70ebaf-a5ba-4187-c2c5-08daa7c6304a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 18:11:28.1290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kN59T+6wRutTfkBOfHFTP/5E7HpK/cX5lVfFqGsNwMVmY1fwyEGTRs7TH2jzd1Tg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hey guys,
    Please help review this patch for the suspend and resume issue.
    I have tested it with multi-VF environment, I think it is ok.

Thanks!

-----Original Message-----
From: Bokun Zhang <Bokun.Zhang@amd.com>=20
Sent: Thursday, October 6, 2022 2:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix SDMA engine resume issue under SRIOV

- Under SRIOV, SDMA engine is shared between VFs. Therefore,
  we will not stop SDMA during hw_fini. This is not an issue
  with normal dirver loading and unloading.

- However, when we put the SDMA engine to suspend state and resume
  it, the issue starts to show up. Something could attempt to use
  that SDMA engine to clear or move memory before the engine is
  initialized since the DRM entity is still there.

- Therefore, we will call sdma_v5_2_enable(false) during hw_fini,
  and if we are under SRIOV, we will call sdma_v5_2_enable(true)
  afterwards to allow other VFs to use SDMA. This way, the DRM
  entity of SDMA engine is emptied and it will follow the flow
  of resume code path.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index f136fec7b4f4..3eaf1a573e73 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1357,12 +1357,19 @@ static int sdma_v5_2_hw_fini(void *handle)  {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
=20
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
+	/*
+	 * Under SRIOV, the VF cannot single-mindedly stop SDMA engine
+	 * However, we still need to clean up the DRM entity
+	 * Therefore, we will re-enable SDMA afterwards.
+	 */
 	sdma_v5_2_ctx_switch_enable(adev, false);
 	sdma_v5_2_enable(adev, false);
=20
+	if (amdgpu_sriov_vf(adev)) {
+		sdma_v5_2_enable(adev, true);
+		sdma_v5_2_ctx_switch_enable(adev, true);
+	}
+
 	return 0;
 }
=20
--
2.34.1
