Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC05C27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 10:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DAD10E2BC;
	Fri, 31 May 2024 10:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="apSlFf++";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D365C10E2BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 10:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDGJAsLytoe3Cz901EYWgBHx18ryFGmZJ+xfmCka9T26uT9WOWmILC2EVkzkqlHXBrIhpWphurpkveyOk8poKEedGzJWfr2u+Osd6TmLhip3qS9esMHGKffMzAJo73dSBmbao/RjJSHnF2/lkw6vZmROu2vXENE0jn2pjy7gJmSHpU5VfhyAVYD/81Dai6Ex2k7sP7GcWBaUv+cs4T1xz1MC0eR3K0CYMIM5yPlJB/LBGz7MvZU/SthKbGl3zpes8g/hdGhHpUQRVbnM4Bdof27j76crw0Tdi5NmiWxl48MmUkH1J8z+ut+A9iDCW4ld5svTOS4FrC4b3XB2I1nG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGpbrw8pDZyk4sMtM/MGJQm8PbGAZP31YTaPxhBAkbc=;
 b=UvGNowuETBK3+O7/O/RJnB0GvqDWwKDBg/fzPr9z5CLXe09gftj7b4w8QaUCkkBf3sx7T9S1BzNxQDY3q4F2RWg0d6oAikffMq+4pducSxr5m5KHUZ5pauXKzIQb8VCM8yfoIk+IrEZJbf1Sau4keqEYps8KmFVz3L8cKMqMTZaIJYtQQ45uVmwjwEdUvbeR5B2UHTkC/InA66wNrcs2J7du6v4ygKqqvQ2u/Dj3ajZ8b48Mg69V/Lr8Y2QRzuRkcmQjVc3JjOVSkK1Yp91W/RbIHJxLCHGMdkrc+9L628gf01GEV1GX6VbFi4raTkxk+e5dJp1++RdQClAtrBnt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGpbrw8pDZyk4sMtM/MGJQm8PbGAZP31YTaPxhBAkbc=;
 b=apSlFf++R8CCG8hiXMJa0zMKMSWSg4yunawRxGskiTsarZiF1Vm1j3+yHCrVLTDg4wlkR/928YWlcKqKm5rTAQ6WO/e+RxevWmnD7bJ5kkIpt7/w0iOZSA6iF0nUqOxWCsqlE1eOnQTJu481VvLVNLHUIjYY9JupoOgiozGzLx4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 10:17:18 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7611.031; Fri, 31 May 2024
 10:17:18 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: add missing error handling in function
 smu_v13_0_6_allocate_dpm_context
Thread-Topic: [PATCH v2] drm/amd/pm: add missing error handling in function
 smu_v13_0_6_allocate_dpm_context
Thread-Index: AQHaszOWNSgy7BOV60qE1m1g0+JhQbGxIOJg
Date: Fri, 31 May 2024 10:17:17 +0000
Message-ID: <PH7PR12MB5997B7739A5ED69C9060716582FC2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240531082145.24027-1-bob.zhou@amd.com>
In-Reply-To: <20240531082145.24027-1-bob.zhou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=57b86b84-31be-4828-b52c-8b6b10cdeb6a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T10:16:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW3PR12MB4459:EE_
x-ms-office365-filtering-correlation-id: cd48f2f0-a771-40c1-7775-08dc815ad9b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hOwRk6yoq0ZFvnjufTlNE6v034wCtCUyxo1SkarXEy1MLzOgpYqh30+p+LZk?=
 =?us-ascii?Q?9ZqLih9AhwuYMXZqUFhI0G30fh/OzrtANsZyq7Is2iPo8zymXeifqesn+SRG?=
 =?us-ascii?Q?If+PknpJ+SRwWTZcPkubGmX6JzegncQD13SPrfKWZDheZt63SVDA+xTUGzK6?=
 =?us-ascii?Q?BbcRB+867Mv3Sp6hLP3RXVKEgyeKVu5Z80noALAk6Hm4B29QREIm+La0wNGw?=
 =?us-ascii?Q?FkGKALQQnjuCu8N+o1skZUxekoSYwQwGiS2FTwjO/WSTtCk4pkFBuntX+SOS?=
 =?us-ascii?Q?zG5vRZXfYOpVmgTpwALKSmv+oxqmXWxNHasHxW6T/nRcz5DhnSplc3YEbB98?=
 =?us-ascii?Q?iMmf48Y7K7uq/Ni8UVBpsIrHKlXf5J+gaMWcZz3mnuxhJ5mxsfq2HAnLXFPa?=
 =?us-ascii?Q?Ea3VglKS/6PGJwTO8ibMycuQtZ8R3lmlNU66qhOJCXxsB+4O9rcwTJ6ytDRl?=
 =?us-ascii?Q?SzfpKtZCNcGcjrzBD/Jlam1tx4UaoydKo5HJsbj7FEeeCWqBBuWh+rVLNLLW?=
 =?us-ascii?Q?GvMalgp91uhynH1nGgm6xynTemWNzT7+nJENAG+8i96C2zdecr19QrTEX3eM?=
 =?us-ascii?Q?33FnPL7M3p1m6yQRU6k0gULWWtINirTLFstL1mMhdoRGEc2dYZXZ2ZmCCr/p?=
 =?us-ascii?Q?MG8w3XRKTUmN43tMMLQPFToPcsYPCm2WRN//FsMpRjqXxxKz9d5vcnqDeIe2?=
 =?us-ascii?Q?Xpop35l7wXD7pv+rlGrPuxHA1RZd1Tb5WU6MK9BSRUieGddApajywE7SBz4D?=
 =?us-ascii?Q?xlt7BdJQX2ui+RwLAXkkH8KBXNGi994vI3ZqL+eAuWP78RbQxF/iEebkgHZb?=
 =?us-ascii?Q?22YC/fNOUaGRRsRAH7GUKCt295ODyXt7/LtXLu+gCUUDAaNSAuCk9zFm1hiz?=
 =?us-ascii?Q?UtdWptcGQwaZtJhZqAaJgdgOs3T+h3DZvlMplDK/i5oVLfZ+7MH8Ufya7aEV?=
 =?us-ascii?Q?25y2Mvslfuh3K8+VgArUkiEHi1YZ5xeXy3xcIdss3dzuqA2YuMVbzKlxRtYA?=
 =?us-ascii?Q?E9nLuMOJbHX0SQlQvVoqmTfV2DlwLPCE7T48e91WJlmFYwrhO6foPJt67BEr?=
 =?us-ascii?Q?rdlZgw8PHJufEkw9BCiatjnU285oIBlPwlptpLJ2nH1etwVg1Dt6IMGGIKuG?=
 =?us-ascii?Q?hwFH1dCGHBnuYEeW3Qq1AMJd3+VdeAvrTpQWknLxfTouYetHLth7TUSi3GeI?=
 =?us-ascii?Q?F+9Bh5rkTfmyyLZ5oFYnEBRwmAgt3wyqaFu89MndRhdl1rdMv5AxPp/Odlqm?=
 =?us-ascii?Q?doxQ4kj+w5cyArKYgAvjHvNFBsfHPPA21lfw77SsZ+iOtkfUZfDkgrf/6+hg?=
 =?us-ascii?Q?V5jyOve3tmnFav6XGofOux3c+ry4WPsQf2VwcEyu03+jPw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XEbrTvGamaJPLMqDZsHUyLtBY06FeycbrH7Iov8hbFj8FzV3r09rewS2AnL1?=
 =?us-ascii?Q?iKdl9E8MjUe4AknXQmYRbi7SH3f5ECrKDAynb1MMCu+buHeUzOc7z5M7IWOX?=
 =?us-ascii?Q?Rv88kLmCLEShPIGVKdVrBh+/I5w4pihnGQ3dOZqxZe8oYUlpkwzGOAzT4nxD?=
 =?us-ascii?Q?vzL2H7idwOR5bDo7pfjq4zraBQHxdNA1YPbCaVFggB+yuK9lr3oibPN7hI5D?=
 =?us-ascii?Q?aqM9UbrmAGHmdszoVRBduFZxHox0pzHH4UJMMURADQCsUznKameFfUXvOnJP?=
 =?us-ascii?Q?a0EIAClMGJ8cvs32vl490wcC61Hx6iunu3az1S+EgCDU0MQBWM2izzl6z73+?=
 =?us-ascii?Q?OzISUFe8eL+HWIJlzVSpXvrJBBVhrmyiMnp4QNTj7AgP2NBPBA15T0l1lTRJ?=
 =?us-ascii?Q?9hxAq+529RoJLNfSgz3y65YeyVfaWsGwdDzXnCf0FGEjRIU9yrRRDpPTQSjf?=
 =?us-ascii?Q?L4VA7dpc5ENQRIIUlklKu4zTZDDuu811wwfZhccTgtQK98guScSBpuWPSwB0?=
 =?us-ascii?Q?b3bBa8KgZnkHYZz0GtLttD04mDP4RsUaR4LtSkkcwietM8bZv6gm1BZo1/8T?=
 =?us-ascii?Q?XnCZyMDzAP2n0KsqciGjUXutrtjJM48jPVoAl9yVEIFyC8+43VwDOxJZE8sw?=
 =?us-ascii?Q?6s2f5VbEbwrYyurWcpPz7LfM0SJsvpSOzHohAR6kYbPkNzg5p5yBxzNB57ck?=
 =?us-ascii?Q?IIkDa9TTfluXNICQ1WURptk5SKRTWfJmTMjZ8uojvrF9NIP1w++3bhgIjf45?=
 =?us-ascii?Q?g27XtC/6ATLHbaDDy91HJCtlLTjacF6bnCrhPh7c2v0avvLqJ+UKtxbyMuCP?=
 =?us-ascii?Q?DOJQ4trqV0SmN34CAyK/6fbQShgWAwQL33VrjgQ1HQGV54n09pyqd0zaFPwi?=
 =?us-ascii?Q?1OZKrMK5l+5lTWVJHXMGu6O7eBndQ6m/WaRdrFug/mjrH1WsrR2rD5HM1SHx?=
 =?us-ascii?Q?qJavocM0/pXeF6Bq2d+Llscgf5XR3leZroUlLtex5oyXwsPTpH7RXqdkvetH?=
 =?us-ascii?Q?uY0FmLLa4Z3BZbycDEnyjhiXRzeKBdkqEKXPFiYj5fJHAvMDGoed6V4+1Ekj?=
 =?us-ascii?Q?rHv7XTGFbdAfFjI8mj2fcILzL9CewLUt4st7jfsksAqx1UsQQmJy7x5U0dkD?=
 =?us-ascii?Q?acrRJbvHdPRbwt42FwuSN2Y/YDXZ3tygJC1QXQMUumq7b8y8fQA1QWYiDBoD?=
 =?us-ascii?Q?0gtRHcPsoPEmLyAV/U0dGT3gh/3cGiWfxju3cLojRgw92cUjDE9DU3UYpA8l?=
 =?us-ascii?Q?s7uhp+gDbxYTFvAAJVtyIkWUVYn4rC6vnaOOMBWmgox9VZQcQZHZFxuVjUqw?=
 =?us-ascii?Q?H1yc0c4XLysLMEAPZ9SVMgwECUmkH1S1Ywgzq9EzEJVJzDzkV3NWKPo6PmlK?=
 =?us-ascii?Q?V5+yJYtzllNW7zEfIPsncxSKDa1lNoiTEv9qVb/jN+NEEC0qtoxtM8TWWhhJ?=
 =?us-ascii?Q?xLiRLRZ19mWNgt26wYOLiTL1Qi/rg5wizSqJdAOro2vhsDR2Qf+WUTKQeXH4?=
 =?us-ascii?Q?WXgTVXBllI4A/rYfppPzTAFLmRi0pT7R9NofqQnfqNITLZCW2PTVCHUnXIaS?=
 =?us-ascii?Q?a8G8gVOEXwxVKrrM1Dk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd48f2f0-a771-40c1-7775-08dc815ad9b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 10:17:17.9542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RP0kICbKyueyZZ5KcdAQfOOfjC1ezboJBhOXAinCfLdqzz1si5HIbh0YDR3eVLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Bob Zhou <bob.zhou@amd.com>
Sent: Friday, May 31, 2024 4:22 PM
To: amd-gfx@lists.freedesktop.org; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
Subject: [PATCH v2] drm/amd/pm: add missing error handling in function smu_=
v13_0_6_allocate_dpm_context

Check return value to avoid null pointer dereference.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 15c0aa0ad443..6b8decaf6427 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -451,6 +451,11 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu=
_context *smu)

        smu_dpm->dpm_policies =3D
                kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+       if (!smu_dpm->dpm_policies) {
+               kfree(smu_dpm->dpm_context);
+               return -ENOMEM;
+       }
+
        if (!(smu->adev->flags & AMD_IS_APU)) {
                policy =3D &(smu_dpm->dpm_policies->policies[0]);

--
2.34.1

