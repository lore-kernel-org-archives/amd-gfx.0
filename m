Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5DDC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67C510EA7C;
	Fri, 14 Oct 2022 06:08:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE9710EA79
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2u1zie/FBI0wbkN1DYDDc82TiPJZcx/ALxSCav+WBnzbMCOsEU0+RTVvRa6aNVK8BXCuV8mgCiYg9773w2S1iEF6o5OIksTHOtcb2O5tbyW1TqqBmGFrwzkD4ZhtF08J1VxHdCzX/zT5+zBT5b6z2Z3OdmInoIBZbPb+qmHHNuMTxpfb8YcbiGQcdZHlJ8w8dlSmpFPU+98eIrsfXUMoMO0AY2i1lJHRUY3lvBkW593LA49Vx0ekH8++MG1Lpw4apv9WNW1yMXf1cx5eCBmQeMpE8FX2TE4oldMFgY4xF6/3MTlQEu+NOW50N1nEKUitZ4SUBUqtpQ4TCUNIRmY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzQ8gD5wGGuNwVJ7hPFYsGhn8Z6B34W69n+Vc1B1tNQ=;
 b=IhSdtZXc7SGGb+8SMcFZ0wrJL9dAifNDGzNOMh+mEx4hvHEZhmje+MgUJvMev7z2N0t4fXttNip/fehs4iYp61FSWKOiaDon3LrS+QDRe5o8X3ZsrVs1z5p6anFxVtIQHzk4VQrONa0UYCj+Y8KJrVC/7mOEnhKTksQAmH5hnmu+Xmc06oTM/aQ2zVIz66s6SbzG8SozUnzTvBh1shSQLcN4wrCzkQn2Fl5gZyVaws2bzho7yGDxLmOv62LRy/LSirIgX7h/FiFne2U5qfKZCoxnZg1+G0iBxwUBBfVOtwIQX5Vf2g80GEICbKhl9+5UzN+Mxro7yFSMxBxY0yIPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzQ8gD5wGGuNwVJ7hPFYsGhn8Z6B34W69n+Vc1B1tNQ=;
 b=XOcRJ3i42Q9b/CtVFmjwIubnltoUaRsMAAuHDI26f8YDeveA5x/XHU9Ra4T2lRq5d8J1Ki5oX+BpTZYI+nhIJZdlQq8d3xKBnKrFWMMdkP/RCGh/2m0Elk/DMLUvrP3eDOiwstAgDDoEe3fiydxSMi6Q6S5Y6iA0l7TSvqChLrc=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 06:08:11 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:08:11 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: skip mes self test for gc 11.0.3
Thread-Topic: [PATCH 5/8] drm/amdgpu: skip mes self test for gc 11.0.3
Thread-Index: AQHY35HaTuGWnFzL0kK8za5MzkuOw64NZjNw
Date: Fri, 14 Oct 2022 06:08:10 +0000
Message-ID: <DM4PR12MB518133965199FDA5EE1C9D7BEF249@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221014055711.921716-1-Likun.Gao@amd.com>
In-Reply-To: <20221014055711.921716-1-Likun.Gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:08:09Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=19756c5c-56fe-4a96-b5e5-dd1843b8820f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:08:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5a90251a-ade1-4b44-982d-086bf7432a2b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: 91b8dd0b-c68a-4165-250e-08daadaa78db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYzlzyI0vNxEdfb8SRQuCaLKU9cbiKxnByJphQD2DgyOxHsdjqgziEG+rf/gdxqGIAWdJaZTIf4/gz+DuY2ZkbwtX7EfmLiDXVUhEVr+dwx66q1ru8CLYP7tm2DrfHWGZpwCXunOm3yPIqjDOBHuQzWrUkDdfB/U7Xeg0PZcK2dLjMWVgZfZ96OqHSzxI7UemSemeCMJww/yUMNG+dNC9qlxQwa7MBR1RORRHnXN10egVhvp2rAgSdkboAmNcpJb+R8plAxd+9c9x2ZzcZPin7P/EepzrUxUyWsgUYVcb8aLAwI5nJDthS5JZOGblQzDaym+atiDcuZwheCEwvXTbqG34/UN82IkI/UCJXnXiQINqT0AlAo0vUnHITK3WFxr5YsoHb/zEviHrJkv7b9myqxyean1RPOLn+Q8+3q7rVutbebYpcOtiDRQv6yvcDB1xiJl7uhRXR7f6tJ1I3AZ2O4bhhKNoioenshNwInZfkutEV9RtCpNQSJ4TbKRo8TtxZnByVCSq3a0R+TDOksFV/gj9vGmVuok6BLrgId7HCDZPnzUqByBG8/uLNNvgc/NEwlEoeGJPMssxIkvEbIW2sNNxn/u5w23cr+SOhr8K+6U9OFIESTDMs/4E+ITFm8JfvQFaZI8LmW1G8bHapOibzbkSX2VQQ1WmdzdTkb97rmhaRdzuGzZw7srdf5vsAiI4ZgGiytAKc7FrREOiOB8dLb+fYQ/i9hWBYrFOigwofPQvMbLW0PBbKMuaQlykKn+ZXEI7VuKDFEBOdGEsH/d2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(186003)(66476007)(9686003)(83380400001)(38100700002)(122000001)(8676002)(4744005)(38070700005)(64756008)(2906002)(8936002)(55016003)(76116006)(316002)(52536014)(478600001)(66446008)(6506007)(41300700001)(26005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(6916009)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sYmI5FZC5+4EScZSleyfJF9065tCbArqFSrCx/N9172ya5JXlU6cJV1cGZB5?=
 =?us-ascii?Q?UkmmiqNbpVLCtCeUWyj8ZJfAkAz+Kt/r4eD5b+ziIuSuLZJXcElydVYK8PBf?=
 =?us-ascii?Q?AE5CYR8AFx8EiBBRULvXUrks05Saql9eR9cmxqsWkmSUSbfDzhxwa7uPHjNf?=
 =?us-ascii?Q?HHywZOpP/cLXilUfx0/gg4Aeu/Wg3kMb/FCFEVyZ6kXTRSvwRPmbFcJcX0kg?=
 =?us-ascii?Q?RtLKJtDuYQgFUiVQwbJLy4qahEVkuWQQNw7y6KVWr54sQHN56BzgUBR2qB3e?=
 =?us-ascii?Q?pQSF5t6FVhivODxEV1K7IHwntAntRDMOAXAiN1iogsoz4Ou2F/WopTOK3Ge5?=
 =?us-ascii?Q?TK4LekLCnsLHUxfR6sxusY+ageaqQah3ohUbiHyDFP0LvtcytRW1OdPBu7A9?=
 =?us-ascii?Q?5WZZdAQiB90kq1oPKEKXHOpDhQOe2ER72qxxOQeDErxUIGZ641eC2i3MTt7n?=
 =?us-ascii?Q?MaZcr3fd98RXDwfyA6VPVQrMiZqFxquFYzyXJPCV1iZWYbOpzy4t30sCTasi?=
 =?us-ascii?Q?lBzPmlEbSf4as+C0FWZC1mEUSdl5UVrWc0X1AvYwk2nzK1KSefe1ZgCt/cpE?=
 =?us-ascii?Q?QYEwOCump6P2wn+/iT/qbIG5DD81DkPyFhvTgcj6/YCBWNa2aJR1aFasVRH/?=
 =?us-ascii?Q?3eyTNHSa3lmm5TPTN1oPFjLYToY/zhb1Jcqe6OUF4BYc6XqHvwienRO5aqFk?=
 =?us-ascii?Q?OpPoqT9MBZBSc9Y/NmTca7COmjhFLH3skctRaCz5AYMgYCcdlFBkoS7dK8PU?=
 =?us-ascii?Q?u6R0Jt/sScII/XCQhdnebHCPqk+KP01Zs8EMPQzaoBQpdBRgaQRKPgSTzGVt?=
 =?us-ascii?Q?2qR3si6wuDKUkCuGaCYEL2SqY5zeQj7XkGAKgKoSdcCMUKzxCc0C4QwHWlLn?=
 =?us-ascii?Q?4uZOjlyzhlLFnh9KUo/qt3NmRCo3gqcxwm+EcxgoYdake9Mz1t1vxdeD5yqW?=
 =?us-ascii?Q?HWyHOTqdUdLKRhijPUYXI6DdfbZW00b4zVYelNC8yrHtD2G3S/v/gkdV8kYy?=
 =?us-ascii?Q?Wa3OlwwAWl3D0DqgBE3J70rJJ9xGfVbrSJtJl8ZcjxZKk5DkwVGB/QFEeFBt?=
 =?us-ascii?Q?RZM/3t6HtxheOVZ/dokXj3t6fWZF0Pc69tRsy2KYJyTyr4hFKmPuLXP6q7jg?=
 =?us-ascii?Q?ikmM1P8qNmvM6hC6aEHxFxxFVTDKWXM99iMLgpkIjwkbD0atsEmbHgWeqrxg?=
 =?us-ascii?Q?mPG8xVSa8VX0DXhW1qVQtbCSvqvbr24yRLyFqW17Yn7xXQtyzCSoRd8005qU?=
 =?us-ascii?Q?KPphELZJlFqQgQEREk3E84+IzNGiJBQBB5V/FVVi15IhUb9irFroF5Ms+5Jw?=
 =?us-ascii?Q?6Nn8LVv99mJL3UADxLu+PU2WXKejXly3NFFjUsnKK6Nv6FnsQi1X7gT5PXor?=
 =?us-ascii?Q?kK1nrjyw3LlE4/bee9AjSZBljGjfCRtLycfuqxtIWpz4pttO3N5CYMwILJa9?=
 =?us-ascii?Q?rBuVWvSw4tzcsMmqjAfc6RaQX1kIpfYGYqDxkho6wVhIt8+QAxdn/XPJfktn?=
 =?us-ascii?Q?agF/MVNiSD4I1uHKE2VibnrCXbtR33sspl6pm99G2Ys+5a0rIEpSGY3q/9Yg?=
 =?us-ascii?Q?Rns6Nx0t/6OyFivzJcA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b8dd0b-c68a-4165-250e-08daadaa78db
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:08:10.9395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srrEa8drgwud/5WQQM8zHoiGWFtCDSLTNY3dlcPB1CwkDnpWULzrdN5qUPk8T+Jx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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

Temporary disable mes self teset for gc 11.0.3.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index b48684db2832..1174dcc88db5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1291,7 +1291,8 @@ static int mes_v11_0_late_init(void *handle)  {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
=20
-	if (!amdgpu_in_reset(adev))
+	if (!amdgpu_in_reset(adev) &&
+	    (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(11, 0, 3)))
 		amdgpu_mes_self_test(adev);
=20
 	return 0;
--
2.25.1
