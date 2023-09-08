Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2373FEE7FF2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 13:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E8E10E8A7;
	Fri,  8 Sep 2023 13:21:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDCDD10E8A7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 13:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4UekI5s4oTU9GPsmU5/UOl8rVNqq+WBkbRRXjngqLx3sNxwPs4AE/11FQsZOgfKPVKmh7uFPvTC9dKZBGmqHPMMwvuwzaRUodeeTZ8pi2DBY7rr+r1K0oHh2HD1BG6Gu/aMLR4UWZzq+NliVwqz1rVQaldZHIw/yso2/7t+UBY0pdLMbhjAKCB/L/uzF/9Y30YIBb01kTtflz8traCPZOYQuyKI7jPKB9/saCQNr5/5/VJ4+nrM1kRBn52SPDpoNOyrIu7BudznjD9Lb5Wcv60JcQPG07iXUVrFQ9h4RHYZ6LhyL+19pgHROesyPQFkR2pcI1+x1uoOvjzQt2PC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBzxlAJsjRT3Jj1NiT41HYgXyJuF03nTY1HXoTjGZhA=;
 b=GM/v81dVauoz2KckCZcid6y4GKOFTHxcsdw7JvVUSG5CtbnE7NZZ83wykppwHdPJmhNenO7tF8g5Z4nMekzmAeOcf+Z9LmkjStL5ie1gXixLYLW33fctmPy/mzHuMolJHPPg7nQPB7OV+xoj3cUp8Z2Y+N6CU1sObTVcqo2L8ti8pRiabM15KfrmpEjummaJbdiWLzOIyoHqjMttXAXCHCEo9aLr+W6Zori7kY392aGBDNzkqq0fEAaleil4Ng1z+0EHZz2wUH8zSCfB40v9Vo2CABhERnwiupoyTZ3/HglOoD6Rl2maQyIbIyy2tOBBhVCZadO1i1cSpHbKsXq4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBzxlAJsjRT3Jj1NiT41HYgXyJuF03nTY1HXoTjGZhA=;
 b=Nv6OlxclJiujQwH0pyksLoeKNe3sbsjv5BZojLid85VhWPOEC5UrX1MZJvcWaiGR6UiRfxqU4jHqkvHoOZ9vU7+zsDcyhCGU9ZSnvwVr2QEaTs/2S5hqWhwSy2SxV3oAHjOJQsVdt9Ss26fZHwuaBcttevcmhGZKbKZD5+5EF2I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 13:21:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20%6]) with mapi id 15.20.6745.030; Fri, 8 Sep 2023
 13:21:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fallback to old RAS error message for
 aqua_vanjaram
Thread-Topic: [PATCH] drm/amdgpu: fallback to old RAS error message for
 aqua_vanjaram
Thread-Index: AQHZ4lbejdaJOd96R068BTUfV5ZJ3LAQ6cqg
Date: Fri, 8 Sep 2023 13:21:02 +0000
Message-ID: <BN9PR12MB52576BD1FF773BAB2FAC1939FCEDA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230908131728.9401-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230908131728.9401-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9f870d2d-a55f-475e-9b56-cba2748ac2f6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-08T13:20:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5375:EE_
x-ms-office365-filtering-correlation-id: 3d522905-816f-457c-587a-08dbb06e72c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7pW3CV3hgHnoKZRWLQtuOW+smyk6Myay4dug++eXL9gVqKK5jt0EbMTuQQrb/0z1sdU6nYPvmCdoPOSDWqOXIvFNyQvecDxZ/3VnPhoBfm3DwYGvaJJ/64hrYm8Hs2xqXBRQdwWrSWjom+p2K1m844Hk4HwnfQYD9/hGWny6KjdHCbpDKGRpbVUjHNNN6VbXlXIvsWcdOTwbk0LEIic520zBqAuJgimpg9b+yhVTxV3JMe8AtjvZsgqmsJsght3Ox4wpgeFM2ImXdprWvp+SYcQrX1Tj8QQ6KGWYxehheDzyJolhCY4CPRR8BE/K8z7B5tjJcPocJqoTQrk1oUr6Hop0Siu1ookbrNuKrFHjbdKDKlHg+AtBJVTSPYfQKd36pndONLU2CDN0f49j6DPswwTXcin2q8DmeYQLxQV4cQwZdm3DeElZLA/25yloiI9mQIjtVQ87APtYyek7X4bzBVr/PVrES6BglW62/SriwgB07Tj+IRQpevjDt3oNRlRnmupemh7kJJ8U6UTFcl5R9euE1PX+pV3MB26M+CVLTcfxjiXGZuQRb1BexCcD3XUtpft2fwglRYeo27sPaAcp41Hr+YGIqDSw2vEYd+A6UQweejT4XSCFzLxgt51WHNJh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(8676002)(8936002)(26005)(55016003)(15650500001)(52536014)(5660300002)(83380400001)(9686003)(53546011)(41300700001)(6506007)(7696005)(110136005)(66476007)(66556008)(66946007)(66446008)(38070700005)(64756008)(76116006)(38100700002)(6636002)(71200400001)(316002)(33656002)(478600001)(86362001)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XJz8jZgYHmTeXwYjA1oJUDVY/USqrSvYZ12tqvvI3ewuU6uYpEQxbqvd4eiE?=
 =?us-ascii?Q?fFURG5d1RK15KUrr81xDrfU/Y8422WqIkZ4nXDn1SNJ7f0ZljE9DtfvdlLn+?=
 =?us-ascii?Q?hUMLQ+ZxX20XwlwGoq7n4+46Yczn2whSqw7JlOPzygr/W4Lh/z9FMpmDLfgS?=
 =?us-ascii?Q?sR33QS9Mmvsin70zCdJ37CuegLIXs34OCZ/g/zwlUMh2ast/8Ceqen92qNmf?=
 =?us-ascii?Q?/L3ZerVjQY7bckAydrncN7Y5xHVXajG5Qa2cYkVPF4sHZa1W8gb3CqkWEuqj?=
 =?us-ascii?Q?89pqbxIFtYLJzdpht9mUeYAcmp/Nbp4tfno5f733B6fWBAe/xPT3kzA8NP2O?=
 =?us-ascii?Q?7TRfhQzM2q+cTLOCPMBsXZqbTyqvpx2fuvqj6P+OWxg5kQC4EZNOxl9/cbXg?=
 =?us-ascii?Q?pafuDPrmR3Uw3QXItZc29z1JGEF0ZSXZ6xeyD4SkPkuSyGuFarRIYogPXoOr?=
 =?us-ascii?Q?lJcqJXQzW60LnYqCcch4mZTXJFDBi8G+aAFmDucvF78lY8wrdouSP/+iQKhq?=
 =?us-ascii?Q?7d691vuB0GqZuI4wW5vLu4dSJtNVDn2eZ35+lvRrGIKb4L6B7Etip640isju?=
 =?us-ascii?Q?GuZSHqS40BlA5DaeNklqSlHXI2DaY8x8nR2IOBaOqWO3ZSs1Qfn2VWGbZU6r?=
 =?us-ascii?Q?xkSdEefHiNUQtT5HodGj3iwTEJnO8M2khtKar0ZmX5Lt4Ue/Lv3WX69Z9zmS?=
 =?us-ascii?Q?NeulRh/ndm0tf5eMGrqGXN62ROezY/fZLsWvG9c3Mis8ZIkfghMxC2sJYE1D?=
 =?us-ascii?Q?dMAhCi/4lJOZr+AGkzyENvGEOOzOkkZKePk6DOEBCmNyuTBzRhhsAOdxX5ej?=
 =?us-ascii?Q?mbtTlY8YnNVgEF/RcQZ0yV+zk7577eXmawXhFKopz80hTebM9wPeD6P+rkMa?=
 =?us-ascii?Q?aDEt3B+BwJfLsV28/9jnt81bSP3/88+g/DsqHfw69NFsfipkcGqDH93z7F0a?=
 =?us-ascii?Q?4Bb5akK4FzXp3y8DLn7Y1iKhEsyNUbr8oj2D+uTovn5QVsT2+wOHqOcMhYr4?=
 =?us-ascii?Q?dFOqRaIkBJqCT53RvGICScHS5f5EQasNKtHCiP6M9njwCbK/mjVeEMSYlF6R?=
 =?us-ascii?Q?+Svs2Zvl1Lmlv05mIjT+ZkTJG9DmV63T76Dud8ZJV4BeC96GPREO9YCvmCmr?=
 =?us-ascii?Q?vHTSPjk0mVZUFxJYlEeIkdlRztctGfB5oF+TbTHZi7U4xSGce5tnpJww4ve/?=
 =?us-ascii?Q?BZ+iIvMlJ/G2ZhQDjdDiBzk62LhpaFBVh0ZDnlQqMlCStXIBksOsfC8/eRrR?=
 =?us-ascii?Q?F/LekHhVJVeHtfk9hCPz5pA97/LQQB3b0lgvc2DNreXvqquMg/bcdpoZocUw?=
 =?us-ascii?Q?8VC9h1Q/7c4UjCQrdWfw2uP6Q6nYibKPfOacwTR/kWap+2ujLMR4rL/cy24X?=
 =?us-ascii?Q?SBe1nHvViHmlQrW7Q558z4jpAWPqUzApW+edlhhRfHu0fHHG1q8yasFiVQ1g?=
 =?us-ascii?Q?BvG0jUpH059o9EWtpYOeM6j0zHRYKpLRRn6d6Ize3dshsbRTaiLjeZuIeJh3?=
 =?us-ascii?Q?tbt7T53HiJlXAxomfHY68vjjJrSSHMHCoW8aejmhYV6KGfyN2FDZuxRvRX8H?=
 =?us-ascii?Q?Z12QOaq6hkJQhf9BLJc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d522905-816f-457c-587a-08dbb06e72c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 13:21:02.0603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0LDIfMtsuwHzRQvzxAgheLQ9c9YFGJAx2sTA0JQP+8FuPjRx0yQHrdgn9xAkxVMyw/FNgW0DGHG2dLkri++OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375
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

Will send out a new version soon. Ignore this one.

Regards,
Hawking

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Friday, September 8, 2023 21:17
To: amd-gfx@lists.freedesktop.org; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fallback to old RAS error message for aqua_van=
jaram

So driver doesn't generate incorrect message until the new format is settle=
d down for aqua_vanjaram

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 8eb6f6943778..dee7b5b705e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1053,7 +1053,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_devic=
e *adev,
        info->ce_count =3D obj->err_data.ce_count;

        if (err_data.ce_count) {
-               if (adev->smuio.funcs &&
+               if (!adev->aid_mask &&
+                   adev->smuio.funcs &&
                    adev->smuio.funcs->get_socket_id &&
                    adev->smuio.funcs->get_die_id) {
                        dev_info(adev->dev, "socket: %d, die: %d "
--
2.17.1

