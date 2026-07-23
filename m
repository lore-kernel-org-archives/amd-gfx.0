Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBFCC531C7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 06:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0171D10EF9C;
	Thu, 23 Jul 2026 06:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IhO7F0TY";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C244110EF9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 06:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmNtJXKbjPXWIGHLj1aZKZMnCuHk+f/xI+uHnSyhtoiukKfbVqi9+tF3yVP4jNvKxBM9rZE9PB+f/+rIi7MTIOiFh+0tojc9uQUzbTIVFDo/cHAvSDsr4TsR4GhB5Fjd0rKUEcI3AL5D9rq+F595YZFgZjpSqmxbdlDw2V0yM6dv/cHyeTqPX5gt1EvcPENM5qqKRodLpV5WOtP98J3JTyXUxCl7KHl8CDNnetYu/sX4k4koyTpvEtTsLaVifnLWIWfkz2YlbSXcjB0Nqg5SlB0jJ7QB2ognFF7idpPWHhanjg8SGAelOAMPLe2EOMiBJyJbqFSrGItGkitVgco8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdUkOPI1CIwTvWIhVUz7NFAAHkXUBDCydcpqGpuLuls=;
 b=lITTGyNW3ONHWqM5Fpfz4LiF6w4Vsf6QEHZ/FM3RbGtTjwE+fkNoUq62+hcMUcQj9n0wvajnCQ6L/vfJUgXbQDlTYLSc0DtkMEkKBOONDEkIuRSCSEXOUIosmf5b/RdBRVmhkqxSxm05BzErClrfbW+5qSE5uDQGMmBI06UOQZYgl58lLxyrBswJ6UG3hdtNU6R7mE+pMG5TC98qs0/vd9eMf191lS9Cb2GUzS3tCUg5ttsVae5tb5ZPdFMaxbxrNAjgVLMOgGHFFK+optBhKvopTia/44GMsaCvZZWBM0TCiQ8DVxnbY1SB3vwEESaZi7SNkaq3wTxi8XnSauGjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdUkOPI1CIwTvWIhVUz7NFAAHkXUBDCydcpqGpuLuls=;
 b=IhO7F0TYH+TDQTcIrA6yUBRjY/kgUNQ2tPFo/S+Q0qNHedlpdfIjVj707QZDj9cL3j6BF4MQ68ORlsSFdUSpDeQuu+uOG1+9oXoQKupi7+gRPli/nt1vtCDfJ9VHqCtqzHU0oGqEK19qLuQpDb/S+knbsMZFffQlK2Q1oCxLjd4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 06:38:07 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:38:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq reset
Thread-Topic: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq
 reset
Thread-Index: AQHdFCOgnbCr85VDm0SiIcpJNE08b7Z6sLog
Date: Thu, 23 Jul 2026 06:38:07 +0000
Message-ID: <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260715063128.581232-1-Prike.Liang@amd.com>
In-Reply-To: <20260715063128.581232-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Jesse.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-23T06:28:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4106:EE_
x-ms-office365-filtering-correlation-id: bfa3c3dd-b02e-4626-36a5-08dee884f4a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 9vmsRyq0ErMcnljB17/zKxQ6iKLRu1LOWPa0RbElV3YYD7FIxCZd3hzC6PFBXWUlOUrGOKOQr8UPnZ9FmhN6P2anesGEz/hXLithkwiz3K/cFeh8Z1znCSYIbu3QlQOSw5vbJgyAbIRZQRqRL8oSrR9RU5rByRuj83sVonDSdEFLX4reg2rMdMbr4vRJE71++aBE2paRphhwwAz6dDvdy+fWkyRZJyEn3SYYgJNGN/GR/NmsR2rSXnDNnv5OpL7SNnOd23zsfYrWqNrLV3uUyHgcuJdWViR+rjMAXW/ssJyAGXSxyizs6hDQpSRaKtyDQdfMWwsHCpqtpcgUVfNtaUSCncjVsp3mZHcDZqRKkIGvk9krpml8vNKMuyLLwdMVD/ZrQldzNoC3gFol3BLODHpD1zL+FhAFZSl2RJvwLwE7tH8sTT8sdfIQgAfhZ/fk6VPgba0M7FfzdbNFtn3VWuFyTMGLQ81rfNkJ7Gm+oQZ2f0Ldp2mRfRpB1Dd0sETmJcPHAG/pmH7rGQH2r9QoQSpb6Jkrws5Sm36UP4XTxdwyayIiZQp9kRm1x5DbKmYseHka0JvM6AbqnX0w/HZSBeGf9wmUqbzZ9uXjf03T664Y98eqb7YKNM/C2odWFlSD1llfkZV06946L5J0JpAaPdzqPQpWWy5Ciq9b4yVcod/XBhIqThJSDfraPgqWx73tGlXU90Wa+UcNInoWaN2AH8oaHI93PbfHqUVIXKoafds=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZzRg4CV7htCxEV/uVg4AIQMF7rsagNc5CUoqF72xiBqodTt9w2/5cRHkuFUL?=
 =?us-ascii?Q?4wVu0XFOdpl4rBhs5Aha3fbgc1FzSbAm/SkJ/v7x4cMbBtdaLkm7C+Rnob2j?=
 =?us-ascii?Q?oSaWvnb9IBEi93gDz2epqG2XMNdySt3e4HpoMLfPsZpoO9jHXKVSMkfuBbxe?=
 =?us-ascii?Q?xLyi6vbSjUAWrUFxiilklZJ8WeRlpHj1aoCgTO6zCVfmwxi9cdpLvgqDJ4jS?=
 =?us-ascii?Q?1+XXN98CSwi4rtyu21DfIwcuty8YTXGIm6Zb8jnJFw4WblC9TiIJXlqsF32P?=
 =?us-ascii?Q?CXSMtct7G1HNCMP0j+v8sYY0uefY49YFOB4UjdNVQXAzyXgUwK3s9tZTdUxF?=
 =?us-ascii?Q?eu6uDw8hh77tp+HWfqFm1oklTyahQOYOg3Xt2jBE5wBq78srs6G0k2EZ5Ig6?=
 =?us-ascii?Q?0/JflRzRzWnZaugRiGDcuVY0SoV2OQwW8kgnA6Kddaacqy6dHQNjpvdJ5PlX?=
 =?us-ascii?Q?Arx7OiIuAyjcHUOdxSfNdv97F5kBzbz2pJ3vdA5iNm9XobxjVjWjVpOKb8CA?=
 =?us-ascii?Q?VhfLpoxUjMmNt32O1Zt2GxU7vz+HdpiZU6/ZCzfhtLPJ91jG+NF7dvtzIc+/?=
 =?us-ascii?Q?hdzbTJEBag8h2K7x7nb5wtjCs+Og3hF23tlly8GTU29yqNEYjD8Dg1l6pj0M?=
 =?us-ascii?Q?klbvNrL9DEcu411jAWimDcHoaHJHLyHqgrd+D9wXeaqLKj+Uwpiv2+q6/ST1?=
 =?us-ascii?Q?7CfCgBOf4l00QMHJ72OjDMIIJBIucHzWv20y3MG1D1TVPTkQmayIo5IfbT4W?=
 =?us-ascii?Q?Wx5m7JtOSmFL12WmAvAmNrNKfdSDaI3WSaHppzbtLcpecWdu5cfoUGhTFyPq?=
 =?us-ascii?Q?/Ne84IHi4DOjGVqegD4GeEV3rM1QIATP/noPMwQnY0CZxAc7Hn8Pjo3MjuJH?=
 =?us-ascii?Q?n8Av2HZFeK6BQ9v8TJO7VOaXQv8o2MtSWCu9LeknnyJNfjx/du60tvUqQNW1?=
 =?us-ascii?Q?eRrcjviASgdYBMcR68SKhZ0x1L55XZV7qNwCOa03zzKYw2CooXwr0kG3UPXV?=
 =?us-ascii?Q?CXqURGE4AYLz8cJwUjjXxq7Z1FY3zm3NrfNULw+om2gUKI2fX69DiAO4Z5i1?=
 =?us-ascii?Q?BlxYRLAfgh0Dce/wvoXYb4vnM+0WQBCxZH9mArlNpREvZH6joqSvtCqk82So?=
 =?us-ascii?Q?XPHRa24WZHgi3QxKb+bifK0aEHVnQJMQfTEB6tlndzTmSiPE5f9iXt5XhboC?=
 =?us-ascii?Q?S61mWvKwEi9S/hmXU8Lkq4FiaUQWCpoAl49BlA3NklksHX1rgncl6h8aKkGE?=
 =?us-ascii?Q?lbLbARhH2/zPgtW2RRsBTrD+VMQOMibZU7r3dYvPd/Kb7oWz62xrTwVrdGsE?=
 =?us-ascii?Q?III0r5pQ9tSAlqSoSZkgpHzlNIPNNt96+P5+p9O5W1WxFLgRLWB6WwvaAtS4?=
 =?us-ascii?Q?m9z7v0XdMIDzZXMXwNM5o8sLbIpWlFRFTIDKD1Xq0y4/rD8YuXiyabnOMMf1?=
 =?us-ascii?Q?gAKWsEZGyHZ3EIiTdx9671/0NJYusT1hrth6Aas4Up97a2B1QQp5BcXf0cgs?=
 =?us-ascii?Q?8UA175Llj64pkwQOFCnzB9JPp5LyHemPaLeSW24cIwviHMI7NliFdLrqJpNg?=
 =?us-ascii?Q?/wvXdr8RWXQANgX0SeZBWPDOCjiJKBCuw2pfwLAGKiL4xheOS3K0gYsImBPq?=
 =?us-ascii?Q?YTrotbn8hfexEvWPdY1F5cWaIh1BGCfgDKa92VfFDlZswYncb4jBYHtJb54M?=
 =?us-ascii?Q?4aHw5607Bo0+lkZALSFUiIujwnK/bvkPVvHBco2dEW4iLV06?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa3c3dd-b02e-4626-36a5-08dee884f4a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 06:38:07.1109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmjVcq+c+xo40iZ5TjsbV/qvl6NteK7LJ6FaHU7bZcCyRd4na2HHM8L3zWji3I3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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

AMD General

I checked each different userq hang cases, and the guilty userq can be iden=
tified by the MES firmware and report correctly.  @Zhang, Jesse(Jie) could =
you further check as well at you side?

If there're some hang queues miss identified by MES firmware, then the corr=
ect thing is to further debug from MES firmware side rather than have such =
strange reset sequence and this reset workaround should be cleaned sooner o=
r later.


Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, July 15, 2026 2:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq res=
et
>
> amdgpu_mes_detect_and_reset_hung_queues() already detects the guilty comp=
ute
> user queue and resets it through mes_userq_reset_queue(). The additional =
reset via
> mes_userq_reset() is unnecessary, so remove it to unify the compute userq=
 reset.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
>  2 files changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1e275c2e7dd3..4f2d5ff2f7be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2315,11 +2315,6 @@ int amdgpu_gfx_reset_mes_compute(struct
> amdgpu_device *adev,
>               deferred_end[n_deferred].fence =3D guilty_fence;
>               n_deferred++;
>       }
> -     if (uq) {
> -             r =3D mes_userq_reset(uq);
> -             if (r)
> -                     goto out;
> -     }
>       for (i =3D 0; i < num_hung; i++) {
>               struct amdgpu_ring *hr =3D NULL;
>               struct amdgpu_fence *hf =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index b6bfa3974839..fab21d4275f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -226,8 +226,6 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
>
>       xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
>               if (uq->queue_type =3D=3D queue_type) {
> -                     if (uq =3D=3D guilty_uq)
> -                             continue;
>                       if (uq->doorbell_index =3D=3D db) {
>                               uq->state =3D AMDGPU_USERQ_STATE_HUNG;
>                               if (use_mmio)
> --
> 2.34.1

