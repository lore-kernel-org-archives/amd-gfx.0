Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A30BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 06:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0AB472C14;
	Tue,  7 Dec 2021 06:41:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C84172C14
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 06:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD2mcxf5KRTMF3adFtsk2a098bXv4XRZWtmJe8/z0/GP67h0TQDcHg1cVsBr4Orgx3/MHv2m++nBHmVjaaSku7RqSwAn5UM1qa3xYamnkgcXqH6+QUbv4bDvmV3fmq0kKEW9O5me6cEhwOp4V2Qu6NRFA6Gx8XVJTeL06AoHGQ7di78huIaxsd+ogmXc0ANsBpe5Kw+uyvorQ3bGxh2IsPqW+Bngsf5P2bICwl2bcyD13unKZtBpMmVaqQkk3m3svgXbwHGaDtpFFG7qqgJi5ZWBUS8ePNUklT5mSN2OgJOBF1oTiYaAvuyBBbHh4MjmhKvqRHqHSvhxR4kwCN4hMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnGz0oRCvqyurBJ/veMl5MufPdRlOc2QvRzR3WUm2rg=;
 b=TrPtrnNAEdx6ZQ9VcNPTv1K6iqeALrnPyuKW01wXCUHmpyJvGkc6JZl2EaMgriUzNx65R0dnAznui2ebzJB4GIdY/m2gZDRnmFBvc+E+2qXZTxf0uDb2yEK/JkiNrMUya+XEg5xldkmjPyC00E5cl11voxYHz6lQBJHVtirTvcR9+spMejO8iWGm1qP6FQXjM9Paq3t+O75JwMiUZoX3cfC4L7hgq61x2TyCUMtWieUG3plbadUTdQlxqPgHrJ34/PpkYTow2Vjnzu+ZTsZ+ivEUJIyyVWQx//QRfpN8/Seg+Z5RLG2UqwMqOn2yxAQy1WF2az9p02fyU0AhSbTbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnGz0oRCvqyurBJ/veMl5MufPdRlOc2QvRzR3WUm2rg=;
 b=NsuL+t2tE+bJRJbGDRYHjzgOmGlSXG9FkbAfjzcbn9QjgH+z9iQ54YZpn8d1bZ34TXdAsYHvVgxZ9h+4mKeNO0VVcLKI2eKx8rbfeN4uTMY2/upl8eqIiN11oF6o53DZESfyjJvpO0Q01UDMmuq+tvy4qbXFdADIxPPoDQyEbek=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 06:41:17 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.032; Tue, 7 Dec 2021
 06:41:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: skip umc ras error count harvest
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: skip umc ras error count harvest
Thread-Index: AQHX6zVLh24bp4YIJ06qTr4YtCuzjKwmlEKw
Date: Tue, 7 Dec 2021 06:41:17 +0000
Message-ID: <BN9PR12MB5257AA3E97C7305C70D7CA4CFC6E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211207064005.14026-1-Stanley.Yang@amd.com>
In-Reply-To: <20211207064005.14026-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-07T06:41:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=01fe798b-0362-4b3f-aad5-d2eaad3747f8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8de2a20a-22ca-45e2-3e12-08d9b94c923f
x-ms-traffictypediagnostic: BN9PR12MB5242:EE_
x-microsoft-antispam-prvs: <BN9PR12MB52422A40490B044D11177737FC6E9@BN9PR12MB5242.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5UXppY/+ufhwW91YbqlNfjHWy7yNv72OWHiOxbqpW1oTWLO0pjCPwwTVaC+LwSj/zpCsk3+psmTGW2tRAyywkvxEKzfypRlTghG5J97izP5qrfA3Y3VzZ047bKnFl10OufjKQ/GhoFkatU0Tk0HNO9mN6mq7JiPzoK+g/wufZUhJVlEei1ixV++msJBCVVPCmat0mZa7KW18zP3fWaShUtZMYjARL/gh6IxKlUKR+PffB+CyTjaX9BxXxq3f8yzhwIunKvrxb1xEqxs0SDdu+epc+iVJpBcHzRb/DjhSznpaoP44cPtDEcNT0Tm0N4exMzUQW2a4Eu/zP/Prtmj/4YmiThtPrwas1Jl0i9tVLe5YdVNN0U0LtPiCZmXT2jQzmloeSBYu364+D/95r4ArekSI1ALcd+rAjOUTMb7AvLEri1NXTXISb/YBpY8TWxV4AR5ll2gQyGQksgLlYTQHLopiZUHPqZKyoe9GQGpu5ZUNM3RUkp/GTlH5zQdJE2pOxSW2ReDAyl9YUkymN+uVsMSSSYWj7N+glvbWaq92W3X/GK6zmjv6zeEXiQq4zhD0PJyQtsJoNEDp0GAY+FQFtyoF17XhPRL7F27lvmnLKxisuVNfeWfd93wofWzqp3EqA+Fjs/9TV++98F+z7V00JNjqKdzec/BeRqmjy5hd3iGO8Xx9yId+cJ02fGVSnsh38nOEVxPkt1nNi1qncOB/7HXPX5O8denHdZUTjv9Aho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(8676002)(8936002)(71200400001)(64756008)(33656002)(316002)(52536014)(66556008)(38070700005)(6636002)(9686003)(508600001)(66446008)(26005)(5660300002)(38100700002)(921005)(110136005)(122000001)(2906002)(53546011)(4326008)(76116006)(66476007)(7696005)(66946007)(86362001)(6506007)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DRlGY7+4STDna/pC0wVM76hUI9twq1/cI4dOYx3G90TO3Ryaly4sifYnuqmk?=
 =?us-ascii?Q?Y3ayBt6zM/NBU9qiMTDUAEswe5a0PjiZtoVcE0gFkI1Ft5s12opD/eEhx79+?=
 =?us-ascii?Q?6J+j0PtiVBcX/OAVudG/Mvcm6fK1YpauvqTSuo895OZru5Dcn+SUi1yVNrzv?=
 =?us-ascii?Q?iKz1IAwQ/eVQeOOup5DxdSwTkya5m7bZurELjuD8ds/pO4A6R6Tkf0FdH69O?=
 =?us-ascii?Q?GdOfzHeLhOONnnoyZeo3CkM15XVWKoSZfTYjBKlBCAzWqQ+eyu6AU2Nw4tUJ?=
 =?us-ascii?Q?pdjXEHJbfcnxTmba3EtUkYFEsr6DJSqZ8BSuKAAEG9+icjmp8jPbM5AvgLrA?=
 =?us-ascii?Q?49/C11MfqiEGrJNwb3Mw9SO7SsACSehzaSHIyauMfypkam67R79+JOfNyLUa?=
 =?us-ascii?Q?gRMFw6qQpwvPc0q1gUwkuNQT8MYavjjKTaMwEBdDplT9biQzNv3sXUARh9LK?=
 =?us-ascii?Q?u4Zz0gd9+DsPxsSZDgde+N7UUqQaeDlVoFyBX+mLc3b1sZhHowQC6o16wDnY?=
 =?us-ascii?Q?IRhHDLaxEjmK4ezs0fVK72hknixQ3H3FRBMg1d3pcJOvpdn2hwC8YqY3DtdJ?=
 =?us-ascii?Q?P6ct9L9SVbM8M1c3CtVgfnkvv/FkswfOJJt4O3++llouJanENyi5WEaCXEUM?=
 =?us-ascii?Q?orQN7WYbwro/rE96iw77uqlETKTTo2Y6VBBkQ47AG8EVOiQ+a7UKVfI/QyPG?=
 =?us-ascii?Q?+NFizcoeWI/qeQ2bKVVMlQ4yUev6+FDpt9T2lsrGW8UqaayS7mfq+oaUpuEi?=
 =?us-ascii?Q?H1q2JMzGAYEj0K1jqTvw8ZQ1RgIeKvxM3gaKUg9lljQ9KP6hFGJ8ThVoqkfq?=
 =?us-ascii?Q?jqg2NstjiW2yHCJSG2trwl61lsSAMnYUJIqKp84ujbxzMefEJ2Hx7pfhHFnz?=
 =?us-ascii?Q?f1//zvnN5tLP6xdBu5McH4ZO8rQudnUWy2OVlEEJ3wCJy2FBvmtJU99qbaCs?=
 =?us-ascii?Q?8RpA3Gao+ocaY7uHnGLruHIm+t6IYi+pP9b8OFyoiae6HoZBLuwxA6hQw+Vw?=
 =?us-ascii?Q?bDpYrt0TjCHlKaEvYb18etkzyw91zqPnTlCzOmN5xgXOT0sSWFXnOHdUFA5Q?=
 =?us-ascii?Q?lKsPA5QWUcVAtJCnLWaWtFq4cvX4ZSQh4c1CbMiuJU6ZQ9oSoipbZNRw0frb?=
 =?us-ascii?Q?zxytJbFtlkQTDgcCwgrrTThNjwHV9EnC9wDb2V9pg1SOwSNY3NdqbiYwiLBe?=
 =?us-ascii?Q?DX6zifDAJ/a77ZorC5+9QuhlR2IGbJmi1ms7AjyVzRQorAHHFo02KHZQgxsf?=
 =?us-ascii?Q?2mQWfHr9Y8Kh+jn1QNVZRNV+a2gh8dRlJrsPzX/uOqeId9WL02vJpH6zjUx1?=
 =?us-ascii?Q?xPO48R/EpKN41kW+a+IvdMx2mGRvsE2OFRgCivpNP4I4UHU2F007Mp0/Siut?=
 =?us-ascii?Q?0oaZKIxFAXW8K8038JJSUhcCzbAIw/tTL9UwKVdwm6tfdsB005Mdzag4d/Fp?=
 =?us-ascii?Q?VPue8hU4kMDLpzzOtk9ZMkQwXmW/cfv6UsNprRDT7voEvYyBsGiNGOiiLbDQ?=
 =?us-ascii?Q?4aoOIwJ4F3sEOCwfvT5FUuiS/klWRjIyih01xoOq9g0Fc996jedVy5gK2xCp?=
 =?us-ascii?Q?7DogBl1SvF3xpFeFhWJ3szUp9CwpKXyy9TglVQvUNpXOUsrJXUIqSGT1DKUJ?=
 =?us-ascii?Q?mOq29rJykswuF4OfkFNTdaA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de2a20a-22ca-45e2-3e12-08d9b94c923f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 06:41:17.0314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpxAKje6mISDbF2gGddhKQH6q4vJ1PNFlgvaEZVWW3N6esX9pfz83f33QGG5h3k61/2xN4qXwfc06fezunLRfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>=20
Sent: Tuesday, December 7, 2021 14:40
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,=
 Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: skip umc ras error count harvest

remove in recovery stat check, skip umc ras err cnt harvest in amdgpu_ras_l=
og_on_err_counter

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 1043d41b6807..a95d200adff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -897,11 +897,6 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_devi=
ce *adev, struct ras_err_d
 	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
 	int ret =3D 0;
=20
-	/* skip get ecc info during gpu recovery */
-	if (atomic_read(&ras->in_recovery) =3D=3D 1 &&
-		adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2))
-		return;
-
 	/*
 	 * choosing right query method according to
 	 * whether smu support query error information @@ -1752,6 +1747,16 @@ sta=
tic void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 		if (info.head.block =3D=3D AMDGPU_RAS_BLOCK__PCIE_BIF)
 			continue;
=20
+		/*
+		 * this is a workaround for aldebaran, skip send msg to
+		 * smu to get ecc_info table due to smu handle get ecc
+		 * info table failed temporarily.
+		 * should be removed until smu fix handle ecc_info table.
+		 */
+		if ((info.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) &&
+			(adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2)))
+			continue;
+
 		amdgpu_ras_query_error_status(adev, &info);
 	}
 }
--
2.17.1
