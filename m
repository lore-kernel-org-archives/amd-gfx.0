Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95911C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 14:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402EC23330
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 14:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mRvqyLAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402EC23330
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02ADA6E7E5;
	Wed,  5 Aug 2020 14:54:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5C46E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 14:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsCgavVchn4jUkTYs3S2N3TAQzJLb7KKqcEKsoqfBsilv7n4NDLLc9gVU1eshev+vyNGllH8ngG6FVUmZe0/vr36XTk2zmz1IDSF8MOzTltGOJ2fvLFtkuJPwO6rjFslUqzU7SBKi3wTZ8CHHqJXKwFABWSuN3x7SCd1ljOQ3n6c83RFzpe9icC86glN+roAzuFlXBcoPHdeUoaoje4UXH8N3VdnaZ00igugYQX6Cy2ieniTURR1vGE8ykfjigSA7kkDTXl1xjeTIH+iwBeWy+bQEaBHFm+AeD7Xulb+NByodSqsFy4F56grkIWDxPauWy5BF1L7kDdOWGuZF2avNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipkNUroOIGa3cJDkJHIL8iuNQKAv80BVPX3t3jADzsY=;
 b=ldmxRg8Nuvnb7Yp5mAF0jhFXuL5jetl3G/3xS3vUEWyNxaT3uq9dH5AZr9mMMzfWKtp/rDFE4LtVVBEiDOG6J0oOmanshdPrFr1dK8h2nADO5WgSGtOMzZ8EyCCT1Vt0fdyEU6nody2FSMY966T6MbEZM8T3lAfjUICQUB5QPCV8kDje8ifoJ0FFBzvjtwsBbHLVfFZXG3H85lzec8RkU7dcTP7n2D3VC8NIOsfH5tIkP/mP/rpyC65s2u7p3zf4bbf8vVkYqM7gHaegoNm1rAK6t6ptE7GfKb9ORSBySHB0UVM6X60iazwrCjrg3q+QoZfa0sjnryZVrqeWANduxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipkNUroOIGa3cJDkJHIL8iuNQKAv80BVPX3t3jADzsY=;
 b=mRvqyLAskkSW4doLqdp57xUQ7K8u2/vkNwy2Xjqv1+FcjwvtrE/SA6tgeSDqQuCZqyqdWN77wAqNHDUqueLiBkc12Yfy7zm3hUcmUvXJ7HjYuajL7cy8xfsOTCvjEzk6bGvTK5oLJQY9sPyV/0iTc8eylg7nCDprrJnRgSs3Q7o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 14:54:53 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 14:54:53 +0000
Date: Wed, 5 Aug 2020 10:54:50 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Wayne Lin <Wayne.Lin@amd.com>
Subject: Re: [PATCH] drm/amd/mst: clean DP main link status only when unplug
 mst 1st link
Message-ID: <20200805145450.ouxbrqlhd6xnrwu7@outlook.office365.com>
References: <20200804032927.32274-1-Wayne.Lin@amd.com>
In-Reply-To: <20200804032927.32274-1-Wayne.Lin@amd.com>
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::80d1) by
 YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Wed, 5 Aug 2020 14:54:52 +0000
X-Originating-IP: [2607:fea8:56e0:6d60::80d1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 740795af-70ef-4ebf-54cd-08d8394f82bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB451664AD20790D4EC9C29D29984B0@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rVUKdZOUo8GW0KNP1XEdCCkYfuMRue72bMzoq6r+yNuqL9ZbTV7krc7CTN2ywPQwwylOWdzQpias7+mFuRZCPJJ45KPlqP0QvmpEhFWJ7rqKKqXBTuJ2kOzYIo48wxstCdC1q5p1HEgIaigLUcSey03dxyjsqVCB6n22gd4BOFkVD9aUBgotZOMS3BmVPbfvEvb9iYfRmiK0D48LBF/BJkPU0rv3epc/t6IHFqZALYSnUjqVy6rBqJFAR+zlfHsnyRvk/N1X14VGDBOutnhnADYa2lbIUGn7cV6l4kj5mT3KcAiE3iiwKX4oI6MrdZFap86q2Q4Dhp7RnzfLLwdw5oqKYJniTeOgHFHIfJ0/KRl4yU2vM5BfRohJy4E71SHc+1+DaSj2uU/PX1hxYHI6k+rr2zijlVEhekM3hq2jISchNiKXB5gptcMJXjEsKwYDK/vfyolIvorA8BdZgPA/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(966005)(8936002)(2906002)(316002)(6862004)(66476007)(186003)(16526019)(66556008)(52116002)(66946007)(44144004)(6506007)(8676002)(7696005)(478600001)(86362001)(4326008)(21480400003)(55016002)(9686003)(83380400001)(1076003)(6636002)(5660300002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sc9tXqZbL8hdw1Gt4GETEfKEQn7f8cO8CPLiQ+4sQTdAQCZh1Yf/xbR7pENz2hpsb/vI1f5Ziuh8qlgON5KXFjWgNXItIud1HU2i5xDJCfGC0Uf0+0v18mwOFqgXu4/HoBWP7ZVDPFXVeU+r6Z1lUFwLwxJgAqOdO9edQKJueAfihviPW1Wja0FNFPoy86IjIwANZam0P117grhGGtjypvdvsqGIdtmdvxBQCh71wYMpSfh3bIt3Xdqr3L+zmyyir5upJ+JRAsUwizSQATGjGekYfEaKSmaXUIrwF5Fqc40uloaiNu56A6Wh0YCYVSPimLp6OoX5Y/ku1XuxnJFHq9hu5nJtPqgNa1+RhF2xbiO3eetPcKX27KZ53tH+7es3KfeEdKv8GmC6X4PgwnNFo1iifCEK3AYMWKBV/U5eHwyvmM0wkQnHqilMYx8/SYyahKKbcdezpD/y4chSs75N5qY+bHJrIDzJ4FtWDhT80DXcWfX0XEb0QoyCWZLUInK//aMSrPU1tT+MtyzWxRESNZaIHTzljXB04u4Pu1x6Zb9QfGuBQstoGStt/gyop9B7wEIYYgLgSzoXFuHrB7NlWOoFoQSl7ietN7VVZjJ94IxblnEvdlu1S5rhsvN1WFwsBAMcV7UYZkElGpWsczjRamEcJ2h0PHt0ptAeo1ccD9gl8F4KLnQu132eynFHelZr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740795af-70ef-4ebf-54cd-08d8394f82bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 14:54:53.3048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ge+DgRUlcF6CxLV9NyAIF8uM/XDOYUI90xNi8eTREq9s7ajj6mjzUgbcnyI5BycocuB7o5wkHDxcNEvh+7Vs0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Cc: hersenxs.wu@amd.com, jerry.zuo@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas.Kazlauskas@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0020991427=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0020991427==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iiqs3bpzyaxelk3y"
Content-Disposition: inline

--iiqs3bpzyaxelk3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/04, Wayne Lin wrote:
> [Why]
> Under DP daisy chain scenario as below:
>=20
> 	Src - Monitor_1 - Monitor_2
>=20
> If unplug 2nd Monitor_2 and plug in again, observe that Monitor_1
> doesn't light up.
>=20
> When unplug 2nd monitor, we clear the
> dc_link->cur_link_settings.lane_count in dm_dp_destroy_mst_connector().
> However this link status is a shared data structure by all connected mst
> monitors. Although the 2nd monitor is gone, this link status should
> still be retained for other connected mst monitors. Otherwise, when we
> plug the 2nd monitor in again, we find out that main link is not trained
> and do link training again. Payload ID Table for Monitor_1 is ruined and
> we don't reallocate it.
>=20
> [How]
> In dm_dp_destroy_mst_connector(), only clean the cur_link_settings when
> we no longer do mst mode.
>=20
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 2c10352fa514..526f29598403 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -415,7 +415,10 @@ static void dm_dp_destroy_mst_connector(struct drm_d=
p_mst_topology_mgr *mgr,
>  					   aconnector->dc_sink);
>  		dc_sink_release(aconnector->dc_sink);
>  		aconnector->dc_sink =3D NULL;
> -		aconnector->dc_link->cur_link_settings.lane_count =3D 0;
> +		mutex_lock(&mgr->lock);
> +		if (!mgr->mst_state)
> +			aconnector->dc_link->cur_link_settings.lane_count =3D 0;
> +		mutex_unlock(&mgr->lock);
Hi Wayne,

The change looks good to me.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Just for curiosity, do you know why we use a mutex instead of
spin_lock_irq for this case? FWIU, the spin_lock_irq behavior looks
better for this sort of manipulation.

Thanks

>  	}
> =20
>  	drm_connector_unregister(connector);
> --=20
> 2.17.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--iiqs3bpzyaxelk3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl8qyDUACgkQWJzP/com
vP/EpRAAwnWme11WWBh//vumz49BPQrGXuFUqDs5U3Q8lB2ndOyh/ssaTw8AyYQP
hitu5/3rZd/H+c7lwvst1VDn1QAW2Kaladv7huPNVTGCYx5wJjNaSb4hcoZvKOOF
jwgdI+Wal4CKp9K8LtBG0Vymn6bxhhItrUZqlnhirS+jMgu6IXl3gZv8Anw9uvjZ
9/4nH0VFY/CpOPhalADHtUY6uMQOAJvYNFy/mj3mnBqAIfXbZFWTWpz1zs7KKd2N
LyVyYtorHHjmpNgKd2wLTqvPDbNoRGTnxwMhz3GYbgaaLTv/0CZ/jC4ktCNG/U8o
zhghTVG3b/q4Ld7cGgy49rEY6/qAxrLM8NejGqTrngyg0r0TTMdZv/NXETEXgAd2
x4VaVoezXlPqW/xr/AhY4g6ArBBprEcWZDzrdAko0M30JkPK6I5FfFDDllVdTPQE
WTyBnoXwyQyMtfMnQKgR+0onwbQsUPE31OMOLfQnK6eGYdS4YXA04sFJflhcHCp5
btxZ+E5p0/4lsQ/INRJhbdV3w0pSN0GiIgOH8BTWyWtoCf9ERpCOq+2gKYT2YBiQ
FiV/cxowrTlbNXskFdUSzBEzLFKw9nxG/N+9fqLxTM65mejLEjsS3roHxBDgVxgl
NDER4ma6NTSvrdOX0GL8Q1z0VjP5xPEX9T1ybc7EHGf+92vGkXY=
=yExV
-----END PGP SIGNATURE-----

--iiqs3bpzyaxelk3y--

--===============0020991427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0020991427==--
