Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82CBC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 08:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B73E10E724;
	Thu, 27 Jan 2022 08:11:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71ABA10E724
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 08:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI2qnDvT6V3jsnHHDTwRKz63WVKhCCKK/JqSXZFFhOQ8PuoCHofyOYusro9Zhn7SiuGQXNHGg5dWsIuV0aw0R5Y6f245btp1P4yGXe8rvSIO9eLiCSFF2HSWXELVDFgCHfewLrfA5lz9WrNrJ1K06h3r4X1UThv3yRshyE2rhpqnvfYC16KOnXQGUL2W4+deGzHdZ400VFtbDwJ7KHEmdyHy12xqBeDnp2UZTW8Wttccxre9qCsxaVAzYxn/vayCa/K1XAQ2PStSh5nIa01D4brx+gIcnUKPctPwht3nHKEP0Rwyj4UBPk+IiQj+vReQKZGSQLXHYgakoXw70uHAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/HDNECAWKjG0Sv99/JQXNSI1unGYQ9QQ2Tk9eJqMmg=;
 b=nsz15r4o7GN7Fl8iDeTEVJBEw/kSm72W91rWTt3FTjgaL1LSJrIoTotSm38SL4yWPJ0M+V2r6xbe7ZEa/+Dp9oEEwWNpl5gLB8WrOYQ4I4ooekuxKQJu6jZitYtMoYNcSmTdbR0C7BjtmzorIdjKtN+zAwwyRVYI1Acd55tvj+KEK9lbbJfAtGU0mhT6n+CzmM3tEH+65omt0/zEyyhAuBgesQy7VAjRUARYiEoU6yts43kYLEkHLtX7auOWPvZeSFoqVDUo36YFkYuoJOIJhz0QXqwg7GUf3BXHdbOrdmnnOjVLUDzvYDClZ82eI8kZwSC2x13sf/aK/XCSw8RBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/HDNECAWKjG0Sv99/JQXNSI1unGYQ9QQ2Tk9eJqMmg=;
 b=XmxeqQ7Ag/lzuX0GVuqOYjt4YWKQeddRI+id+xGQm9JXIgerW45DuDgdoUUIotRWBiGtdmjj/1wau8TG5UbdW+bPkESXzuwuP6Z/yBSdSohsaW9nLaJEI+hhrGmX/w10bkw0yXlZHgdLC1HAK2EHOezWEWR+jAJAfa4ZaLeWDWY=
Received: from MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 08:11:54 +0000
Received: from MN2PR12MB4256.namprd12.prod.outlook.com
 ([fe80::9094:b5e3:249d:7ebc]) by MN2PR12MB4256.namprd12.prod.outlook.com
 ([fe80::9094:b5e3:249d:7ebc%8]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 08:11:53 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Thread-Topic: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Thread-Index: AQHYEoneecc7xFzME02I6HZtGOhQT6x1wSKAgADCJXA=
Date: Thu, 27 Jan 2022 08:11:53 +0000
Message-ID: <MN2PR12MB42565B33E018A907863A20CFFB219@MN2PR12MB4256.namprd12.prod.outlook.com>
References: <20220126075326.1134770-1-Lang.Yu@amd.com>
 <BL1PR12MB5144A8EF8920246EDCE4B865F7209@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144A8EF8920246EDCE4B865F7209@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-27T08:11:50Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-27T08:11:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2d938388-4a23-4e14-9e71-175e368c2e40
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b61ef95-9435-4a82-ee22-08d9e16cadc8
x-ms-traffictypediagnostic: CO6PR12MB5475:EE_
x-microsoft-antispam-prvs: <CO6PR12MB54750A2FEDE27053B45248BCFB219@CO6PR12MB5475.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9TWcxxs1aSEP9//0FDnxHohvxqkg9XCZ78WDyJv8AE8e+ceW1+SvR+BK1w+DHjUgqTZ+csceLVE5lKLih3EKnDoNr7VESBGYj0gbxvYRlaMLZyeInZkTiQBCMrMuE9rCOe/moy8nFKnLv85GY5pNMqIhj7YmAr+hx/BBGZYPMyc2KngK1LFOi8ud9LtkTPBr6a+JDGcylqN19nqU3M9tMiBlWm2NAmocBM5q7Ni1FALW34/UEtuQzmLVmdpghQ6yTz7Wx74kSp1AtaYVRXa4YeuZ6Xm2FJJeBgsqy72Q+8SJAq90Ef0LUJAg27IO/uUduMdzZZpE/taSuM7SQvKqwS9TA24bL8lNRL1d9gVhdbKARk1jjSYa9MI+Hnlz7KHuqAF/IrwrgBqHX5eFvVjvIi7aXnsDdhu5hf3y3rl3Yhx8xNbAYsrIroN/byHHmeLyuLqL/R3qvwZoHF0Rapz5ddG4usdFvyL3pxh45XLbka5Eo2UBnoTseHBVH+bn1f7yaH4XwNiAwhdBIVKyVqusd4nxJ5qRfiWlEDEcX2QrzJepVslCjluRTJa7W49vcQCbTmJc3C812sJZbVs1Ql01OJTE0Er+MHJky+/q+QPO+y8X6HzDZdemO1tKGYTb6UWpWMRtQlrmKp5khZGxEpKA9lJLcMiOmcTZMgFWA+oJfz4iIuxlJCwpK0SQnwRhmYF+Y1UPzIkwgXOdyMvhPzEH2/nNcM3ColmtMhKvihM1zk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(54906003)(38100700002)(66556008)(2906002)(5660300002)(55016003)(8676002)(66946007)(52536014)(66476007)(38070700005)(66446008)(76116006)(64756008)(8936002)(316002)(4326008)(71200400001)(9686003)(508600001)(83380400001)(53546011)(86362001)(26005)(33656002)(6506007)(7696005)(186003)(122000001)(21314003)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PfoIiLtWnM3zcUxlXUoRIcp1lzpKVTSIXhGJ5YyQ/udmt1rB2zsiU8lXSgKg?=
 =?us-ascii?Q?y3KZpc79P96AQPuWv4zPjen2zJIcmXFVa+pQ5rdMAoBS/z6HLthDA+h2qWSI?=
 =?us-ascii?Q?/ge/ZsDtDRxNV6qqq6YJ0qIEFzGv9dkH/Dknv2pSE5g6zBDhKC79GvQl8Utx?=
 =?us-ascii?Q?ewJuU08W5AeRTVSFI5ddzmoZYLUA3jIWzV3hSdYoXzPqHiluBTMqCADsfnFW?=
 =?us-ascii?Q?Gh+jj1EpqDcKIAAA9bqirJ+c5WiHKs2yiJntkuZhGI2PoPLvaMPZxpI9MUg4?=
 =?us-ascii?Q?eMCcrHVlvlJZwhkJ80f89pZpqXUt+B3A6rxjYXDf/IB0LkVJ8l39/ao62z1z?=
 =?us-ascii?Q?zfMERyUN84XY5cPNrVSGAGwQ6Bk0L0jK6b+SoqEjQ0y1JG5MJtmCVqQdj8b1?=
 =?us-ascii?Q?63yNWSbSZEQtECu4aodOTlGcsHZOiL+fHssaKSS8941rw7IKbRcnqo32hGl7?=
 =?us-ascii?Q?bT2Q17dQtMtLv4TkNUtYqjxjdQSRd0J9nSPmS9vCl6Ig0PQIMcOiS+tWpfCy?=
 =?us-ascii?Q?FHDgQ0XrbpSFZ9e0/+f5K/fQcAIhO/ko+P1OCGSgrwVoN/2TMkp0R0psG5fZ?=
 =?us-ascii?Q?/IT1+3moeneyZlKQbEBZel2VUpJFZj2AllakUvEapdz1r8e727LXbl2fW6fd?=
 =?us-ascii?Q?hoLR2YSlTaR/R8/5cswYUN0ZoRCE6mV7iRZdNJK6UwgoGKoTHpxQnQzneb9w?=
 =?us-ascii?Q?AzcWVwUL8IXoKPYkIauNmjxmlRPJTxub5r1PQus0Dc5jV9BG1GN5NrW1Npng?=
 =?us-ascii?Q?XAo4eYPZJujxy8rAUxGukbaSZH5ABsSkxJgW1QsN5HzRx2eRmsIDc05+NJ/P?=
 =?us-ascii?Q?ZWW1SD9ROFdBCYWWS0Dg0o/roFiefc1ysH0EogXxVEm5L29KoELhTnPO3zDH?=
 =?us-ascii?Q?ShV3oJA0IStA4WZ9VWTme4Fk0sIa8pTr+be+TVuHSYpgy9m7kOi4og+RGho7?=
 =?us-ascii?Q?7QnGO6GAicuWEEFs6r42WgxY90KHogPW014iru8hkQr++llP1zmiotYMHOAS?=
 =?us-ascii?Q?MEeh8cHegRGsKwZ2UmbDyCkuWZ9F/M++lqV2bBMK5roL7v8r2GJVM4em6v6c?=
 =?us-ascii?Q?wlw/TTRmAwLt6zzv3wXn8hq5a/ojWVM8sAJHtAnaTuFdu/kpvx6ttVOCjNoh?=
 =?us-ascii?Q?TX+BQ0bmzHpPWeR9CMsSx5alXVbf6xO8oC4MDM1DL6kn1AIqx8vZcFMfE0QQ?=
 =?us-ascii?Q?6VATL3nAjk5t0l/yy+FtAzwa2rsXdEpa9TLS8/YO8s2nUnBUT7+0REjUMOUi?=
 =?us-ascii?Q?hrkuNjyoGAO/eubzO+3aFEHpCfmvFrz8AQY8+XKLi4Rti2doE8dQCAZ80HsM?=
 =?us-ascii?Q?uhMm6vEWVn6xr8VShmYuVwpEJ7XogCRJ18nStXviq6h0qVcyOqdySVdmsNvs?=
 =?us-ascii?Q?gEjrkh7RsOjD/Ze3k+qsds3j+u3YL59H30pF8IaDR7o3I28fYN/DR+f8KgWR?=
 =?us-ascii?Q?NY0NcuyYazNe2oxAf3Kb46bDnkq3alHjr+NDArrgx73rfYMkAdfSq5+/9vlA?=
 =?us-ascii?Q?IBqphWEV7ERl6XNt10MI6q8rUeaT4KeAVsvF/Ankav+WV71m4ARxKjw85Flm?=
 =?us-ascii?Q?H8m2YPqJ1D1PWrn+v7LYf9hr4y/MjeBO4zlzPab2oWNDobqfWQEO65rHHloL?=
 =?us-ascii?Q?iKpAnmDy5W5F06Fq5zlRd2Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB42565B33E018A907863A20CFFB219MN2PR12MB4256namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b61ef95-9435-4a82-ee22-08d9e16cadc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 08:11:53.6730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSqgUKcqEXfX+MtuF3FLPVCwY4c0drvX0FDfUCTveZH6YDvA3NXEwS8yDGfSPf9jIIZJO1/8+9wToT9TkiQXAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MN2PR12MB42565B33E018A907863A20CFFB219MN2PR12MB4256namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

>  Should we set *flags =3D 0 before we return?

That will clear other bit masks. Actually, the caller initialize flags to 0=
, we can just return.
Or  just *flags &=3D ~( AMD_CG_SUPPORT_XXX) before we return.

Regards,
Lang

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, January 27, 2022 4:27 AM
To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG regi=
sters


[Public]

Should we set *flags =3D 0 before we return?

Alex

________________________________
From: Yu, Lang <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>
Sent: Wednesday, January 26, 2022 2:53 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Hua=
ng, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Yu, Lang <Lang.Yu@am=
d.com<mailto:Lang.Yu@amd.com>>
Subject: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG register=
s

We observed a gpu hang when querying mmhub CG status(i.e.,
cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
skillfish doesn't support any CG features.

Only allow asics which support CG features accessing related
registers. Will add similar safeguards for other IPs in the
furture.

Signed-off-by: Lang Yu <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c
index 4c9f0c0f3116..1869e2019461 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -550,6 +550,9 @@ static void mmhub_v1_0_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_7.c
index 3b901f941627..f7b9843b36e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -546,6 +546,9 @@ static void mmhub_v1_7_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c
index 3718ff610ab2..3f5f326379b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -686,6 +686,9 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_3.c
index 9e16da28505a..b23dd9ddfb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -580,6 +580,9 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1, data2, data3;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.c
index 619106f7d23d..a2d5c8424e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -651,6 +651,9 @@ static void mmhub_v9_4_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

--
2.25.1

--_000_MN2PR12MB42565B33E018A907863A20CFFB219MN2PR12MB4256namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
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
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&gt;&nb=
sp; Should we set *flags =3D 0 before we return?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">That wi=
ll clear other bit masks. Actually, the caller initialize flags to 0, we ca=
n just return.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Or &nbs=
p;just *flags &amp;=3D ~(</span>
<span style=3D"font-size:12.0pt;color:black">AMD_CG_SUPPORT_XXX) before we =
return.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Regards=
,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Lang<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, January 27, 2022 4:27 AM<br>
<b>To:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;; amd-gfx@lists.freedesktop.org<=
br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Huang, Ray &lt;Ray.Huang=
@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub =
CG registers<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Should =
we set *flags =3D 0 before we return?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lan=
g.Yu@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 2:53 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Li=
jo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;; Huang, Ray &lt;<a href=3D"mai=
lto:Ray.Huang@amd.com">Ray.Huang@amd.com</a>&gt;; Yu, Lang
 &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG r=
egisters</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">We observed a gpu han=
g when querying mmhub CG status(i.e.,<br>
cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan<br>
skillfish doesn't support any CG features.<br>
<br>
Only allow asics which support CG features accessing related<br>
registers. Will add similar safeguards for other IPs in the<br>
furture.<br>
<br>
Signed-off-by: Lang Yu &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.c=
om</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 3 +++<br>
&nbsp;5 files changed, 15 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c<br>
index 4c9f0c0f3116..1869e2019461 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
@@ -550,6 +550,9 @@ static void mmhub_v1_0_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_7.c<br>
index 3b901f941627..f7b9843b36e6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c<br>
@@ -546,6 +546,9 @@ static void mmhub_v1_7_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c<br>
index 3718ff610ab2..3f5f326379b7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
@@ -686,6 +686,9 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_3.c<br>
index 9e16da28505a..b23dd9ddfb5c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c<br>
@@ -580,6 +580,9 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1, data2, da=
ta3;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.c<br>
index 619106f7d23d..a2d5c8424e2b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
@@ -651,6 +651,9 @@ static void mmhub_v9_4_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB42565B33E018A907863A20CFFB219MN2PR12MB4256namp_--
