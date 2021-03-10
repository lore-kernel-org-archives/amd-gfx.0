Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1C9C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 20:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F205564FC4
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 20:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F205564FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF746E372;
	Wed, 10 Mar 2021 20:59:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB516E372
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 20:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGhPEQ0AI5mfvoNNaUfYhd/n493j+7+316Ipbknik5cCgQ6GZm31N6LuWJFZz1derI1KXLjlvtSmNJk8VOdsYh+4ZXPvBbGWW+I2PBTjUv0jC6Jy5SEj2y0kJlZ4Lk0I7qpzFyeCXYuhu2ZzXDJCoU/m+94hgbGoFGvQ2pURt/7FOgqGLq1FSz8j/HF8N6NA86U1KVp1qNr8Drqq5IwSi8HvDpAUqtwR8W6fR3v9cP1cwbWscpUA1XC3IkiMgYMEIffcdXhKUYchGYNM4PYLgtYlci+BNhijRy8yeI3/A116qA9/cOUs9l582y/K56L+eMVliRmPB4NSZIklPZw10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcSHEaQa2XLmXQMqSkGLBrt80cpZ43cDh8BHtJNMMsI=;
 b=FP4Nnv7xZ9LGAg1L1HckUmu+fvSXz2v1eTFNSS8MMFAVcOacAm1CpZI1CgaWa0YfK31lz8rIrl3rmXq4ccc3aW2sCJvlVMdAhNASqhFyVK9wzzFSgTRkIpn00pDBadzFxwkO+7Tf61VHtrr0KIko40VP2PlaWgeYSPYhlgm1nOzBzu3NKtzDor/uH5Qe8mXHrmZRAvofC/F3mzJ/j6ID3WLMNgJNdOOhttSo6Ckf/Qd42nZpJtP6bwI38RLfTOoknPB6cM3tqFUV2uc3DdITpIrnO+nRylRSaJlJzS1Bz5RSbJi4Uc+ZmmH4/WU13bQJ/3toGHAzBIdmrkjyBN+dzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcSHEaQa2XLmXQMqSkGLBrt80cpZ43cDh8BHtJNMMsI=;
 b=AIek6h8XW8BVTaOtC0sXSguC/YsgCCT40QWI4c8IDWIN2qWSrT/XfnpHrBSXI7DyVfGQu/SfuCnva0HVgaIl1jlazAsqemTRasBeZA7yfLjj7Lc8SxYqUA+v9RS0n7F9O8pHf4hY9k+A18mRu/poGpqSinwsjX3nrZbTjuGY120=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Wed, 10 Mar 2021 20:59:01 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.041; Wed, 10 Mar 2021
 20:59:01 +0000
Date: Wed, 10 Mar 2021 15:58:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused defines
Message-ID: <20210310205857.vuxi7m3kiv4rdjua@outlook.office365.com>
References: <20210310205134.22538-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210310205134.22538-1-qingqing.zhuo@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:4b3e:4896:933b:6060]
X-ClientProxiedBy: BN6PR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:404:8e::26) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:4b3e:4896:933b:6060)
 by BN6PR21CA0016.namprd21.prod.outlook.com (2603:10b6:404:8e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.3 via Frontend
 Transport; Wed, 10 Mar 2021 20:59:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa2dbe17-1ce9-4319-f984-08d8e40754dc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3931:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3931D0A3EE3180937C7EF7EB98919@DM6PR12MB3931.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyPysCHBlermrhyxTPCkweq9ZYifsI1yy0PYDrpm81BDiVovvxZ3fPwsidOuG1oxByiSfXmagwZRnzbX1nkpH1qNUhiYIb2gRsCMawtRf1EAToFYkyCwsfmus+WNcW1ITmvhXXpZJR1RoAZA+skYOTQRIrj0XHoyVKFAlWDmov8S/b7/nEuJOiTv46FVXMcdlSzYRvxfs6MgT+SMaiVDA8DLxFzwAn46F6GISwKt6aXETJHEhtVJ05Gb4AFWSYz6OR9dYLYx17csoaQIGMAnn5sFHAw/8M90MOShDeAwOeKeAWkLpP29Fcdxl+Fkqpqs23VPkpGYniKou2QNLl44UhC48kHHyMJZNylbqAJqnabuTqSoAn6x8QJ829w9nsiUL/QeZNN5QnPjV8P5EwN2sSxwgtnpNzSX0S3dH8ueZ2gSY9oClGSe+AjFkWa0Z7f+lb8HypbmNyG7l90I6/NWOg3bCzFucue6JYO5VcEnFNQlHJgZNSlctJggQL45CHpwb3zG43y+LJVCmpuX18D/w0m3BBUKHMSyzaLAvNI2G9JOKpNLGIsPnzTGs+r+pOHFN9wUlgY1PQsuCbds6rY1Illj5sHoq//w8+k0w44kkFM4d1VvfhTxLROezQL0R0X/WlhiihhUWmCWL6S0QKYdrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(6636002)(6862004)(1076003)(4326008)(21480400003)(6506007)(8676002)(66556008)(66476007)(6666004)(55016002)(7696005)(2906002)(52116002)(44144004)(186003)(16526019)(9686003)(66946007)(316002)(8936002)(478600001)(966005)(5660300002)(83380400001)(86362001)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6W6EhKIMgqHvnZDFfS8mbZfAF1eQC50BpVHh5ljs+5Knj2M5GqeQ/3XCF43s?=
 =?us-ascii?Q?pm3py6TZp/zsXni3Pwk1IQYDa/ZdzTmJnpD03WDWWhHz3OFOKLnDFNAsGfeR?=
 =?us-ascii?Q?ospz8nQdspzDGm/u6n100swf7cFA0LpXb7EZh1zNF8qjydTi3yGfyrTF/S7y?=
 =?us-ascii?Q?R0xyqB4kMpu1jfoB4fNCyHRJkaOUp0snND6HnEIoOMsFiPPXtHPbnNCsXiDO?=
 =?us-ascii?Q?r1+/VBPT1fyghaOn+iJRPV4rC+F0CTOYQMiLnQ3ADUfFq1z16nycYLJ5lFa/?=
 =?us-ascii?Q?tdJHtMOfwnWIgCp3MhqHiygS3GRtQPw4wiWf5RHWCJ5bw8aIms44phkmwWrO?=
 =?us-ascii?Q?OSm7EuN751WNOwHlz1KbaYSb2yZAiauTAHFeiU0D7rw4JcvU6B7L+T9Tt1XY?=
 =?us-ascii?Q?hVmgv8GMA/wv/a07HerNjnthFi13tFnZE8fwaEGLGKONROtdLvKofse9sXhR?=
 =?us-ascii?Q?UUyH3n3SD02t7dwf4Yzm3dTJ2kIkYhfHpJQHGknfjFo+oLSnn9teb33uwF8h?=
 =?us-ascii?Q?4MMCc57/jLf797p3x0xKoE9Gg2ok07k9nSeZe/t7JcMMFyNDcyPwntqW1Cc9?=
 =?us-ascii?Q?f5RmbjehtQagIyJKuH+nLeap8JXr68wBJjq37TKbs2Rd7xDXT4VZ/W8OVnN+?=
 =?us-ascii?Q?lJ5dbkT8g0li/edwUR/o2wtZex3zpZckvgSgMW+1OdPPSw4bkpQ4i/aVlO22?=
 =?us-ascii?Q?3Tg+bXbEle+cBO3O98Tv4sjmIcik286xhRnxr0T0cFCweXGqW0i5QkJbIl/Q?=
 =?us-ascii?Q?Q5fbb3accqpNOEMSPAyIR8co3VB/k5MSjsL98EoaRrF2DrrOgWiTnk7EFHAr?=
 =?us-ascii?Q?rEAVZ+N3eiC3xSTL3lhpZv1ero+aVe5qvak21lFQPudIrJNlQYQITx2ZTEn7?=
 =?us-ascii?Q?HvG/BXcY1Sh5fXGHc8ARAPTSdaFn8B2vPhvCVV98Oy5m+m/vWt6LWb4xQJCZ?=
 =?us-ascii?Q?Y6cnOIZCTBW+DajePUs+jCLP7zekyrr8wzYLNokSw4dKG9oaU4vptduxeJlT?=
 =?us-ascii?Q?lIwi255md6ZlHE7bFQteKYt1LCnFOZjNieKSQmAT0kr6RzwzjogA7PO7WRKS?=
 =?us-ascii?Q?/rTXIH5xPp9qFbv1LWRfs9Vil/hCBvawZxfXkaJeSfFaDNqYRGbR8cWVKTaE?=
 =?us-ascii?Q?RwAOcRuon0C6qpV7cz57VEO3xC86PS8uThd5pmBvPbS4TabqWTEnhqdwmq8q?=
 =?us-ascii?Q?G9svMj7qDSJ9RoivYiYR1U01YCX/nO2EjeIV4gzEhNX5lfCD9npGvtBF//0w?=
 =?us-ascii?Q?zvd3YEUwsoVTg6Z1OLmzQdVeDT8jC68QUJry/JkC2/90cwueIS6stRVaZqcO?=
 =?us-ascii?Q?ufWkpWiGScgy7JXknLm1wQVcV8ZlnIbHx2wnvxaDwcaVt9ZfAldCoHEQeLn1?=
 =?us-ascii?Q?Acx5fVX8K73e0MzVH+9Z457PRull?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2dbe17-1ce9-4319-f984-08d8e40754dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 20:59:01.4795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5ewL691tIB91o24V8snwUBedb5opXNdYuFsX6FU5e4pCgT9BWQZFw3+8iu4d8MQzZUqO3jc9k9dMPOJUys/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3931
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: multipart/mixed; boundary="===============0175091243=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0175091243==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lwcuj3zaxhxtk7nz"
Content-Disposition: inline

--lwcuj3zaxhxtk7nz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 03/10, Qingqing Zhuo wrote:
> [Why]
> CONFIG_DRM_AMD_DC_DCN3_0 has been folded into
> CONFIG_DRM_AMD_DC_DCN and is not needed.
>=20
> [How]
> Drop CONFIG_DRM_AMD_DC_DCN3_0.
>=20
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2506e85a19b6..7aab4a6a69c5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -976,12 +976,10 @@ static void event_mall_stutter(struct work_struct *=
work)
>  	else
>  		dm->active_vblank_irq_count--;
> =20
> -#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>  	dc_allow_idle_optimizations(
>  		dm->dc, dm->active_vblank_irq_count =3D=3D 0);
> =20
>  	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vb=
lank_irq_count =3D=3D 0);
> -#endif
> =20
> =20
>  	mutex_unlock(&dm->dc_lock);
> --=20
> 2.17.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--lwcuj3zaxhxtk7nz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmBJMwwACgkQWJzP/com
vP9l3A//XtH7mq4M99h4NWMmx6C03PGIg9a8V+peDjupTRJxwEwWCJrWR9NEC3Rf
86hi054oCnVkcQDzeMOIuIkRN6HOTg/jn0hd3+CGzQ+KxVsZRunvz1Fq8yRgAXfv
xC3/+CcuYGXCpEG8Ct3UcEz2yKh/3FRZx/gVxG+oLq9e+1QxO6K0Xs3GSLdGRlgE
cYDW6fHux+RPrnpq1t2HVP8/gPT6yy3F6Bbo2prw7xWtNf5XbVdY9FmOogIMkpUW
CWPQ0pQGdUNegjnKfBiGKi4AnHQIZM5qW4KsgP/7rY1GB6COLpOL7IHy3ZD6WSkU
bYOfRGDpkkVTc4GdUdpzo3lWYC41sWjT7Srzm83EoF2HHUUZbsEUWFb294U5DSRq
gCB2HABdyHQXHOPVrccme+lkL7AcmzUskBtccLj+HnUfmOShXVBsZCLAzzMRxQqe
0fv67nERJ/4FSs6QtKAX5ZSvFUnc4gw55aw6XjOb6El6yc9LTKrdF9WUl9NSc9wJ
W0BSRkg+Bvn65LxgBqvV94Wgb66nDb6cF9g05CWnMFvJhA9Z4kFgW54yh6UtRruL
huuw/Jq/KQo8ytXf+0yr4nq4QkEatqEbGAJTserY5ugfNowVVeDDpqVhhCocCiiH
5AaSSY0ViYQiiDQjIcZsXQ+5BGSK1htBA/AfrnS5kGodgh6vArA=
=6hgb
-----END PGP SIGNATURE-----

--lwcuj3zaxhxtk7nz--

--===============0175091243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0175091243==--
