Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0025C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 17:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6092075B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 17:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TPQk3xwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6092075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD8B6E096;
	Mon, 13 Jan 2020 17:12:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEE76E096
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 17:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY00iFp+Ue1b3pj9NKpPPu/XkFyBmzNjus/yIlxWAWq2YTByUL6TKdXvH/EpW0Nr15vIRr7FNMrOUq6Eq+CfO760CZ0ZKWBwkCaYNUDTflB4p25S7Z3lrUAyooy6Ur5ZaRn9A3OXMSQXb25BVLgOLfJ+nJ9xl67gr90csp/IMHaavwlf6u5yKw+32I6SLqlS/LnYq2ORir1gD5EFqx7wCqF4nqlm3k1Qvw0MdZ40+qzrKaP2Pa4h9kqY/lh1T+78RmtmqHjkUSe5ln3u6xKJYYAoCYTZOJmTplnR2CWKSHgTHXbr3tYjVqHzK8qggD1z2yCj6Cmrk0n1en80v8ih8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KLiDzgV+gicXQGIm1S8AI9jxcgdW2KhPMdsW4P/T2Y=;
 b=IgZ5q6pVO/hIP4TsfjSrhWp5iwATVB1Ixz63gJ8o4h/HlRw6AeD5dIjRlZ2Vyag2Arqb64inE8svQMorFpF9qhpp5dIrUB1lUYCsy4wg4NlTMSmzyHdzrBex7ekjtQiBLRblGidcO1a7q8R1V6s42HDFnm1SMoE5AdZun3duyUMHpoJvESHpyMojoCFlE+MaFPfn/xKgkosysBYycZs+2Kyd5cAUdzc6JqtjLZIisTeTgrbKCXbofXF97ngZlIOMfFNvJTkVhFBNJZbPpzLCIphZEA+VFr0jk8wY+2LKocKi+hi5Hv+fq3f3WnrM3doa5G++Huogbyehl16dXRCy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KLiDzgV+gicXQGIm1S8AI9jxcgdW2KhPMdsW4P/T2Y=;
 b=TPQk3xwdJCAc7OW+SiNz9zbeNtr1HFIVZdlzSxob9eyjKuC0oX0ucVh0vuZozbcvhX4r4eFPGyifiWhO/+JnPF+vuereixURTjc70hspNy0deoMtwqMBq6R9NMQHZsxML3y65TM9nJ7VRJEgcsyR5LQyiBwUIUoMAgAhGHUDSFE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2443.namprd12.prod.outlook.com (52.132.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Mon, 13 Jan 2020 17:12:37 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 17:12:36 +0000
Date: Mon, 13 Jan 2020 12:12:31 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: christian.koenig@amd.com
Subject: Re: [PATCH 39/43] drm/amd/display: Use udelay to avoid context switch
Message-ID: <20200113171231.4y3fjz4lfzxwsswx@outlook.office365.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
 <20200110144655.55845-40-Rodrigo.Siqueira@amd.com>
 <e5846131-ed59-2790-30c1-c44b19ad8914@gmail.com>
 <DM5PR1201MB25546012AE5DE4AB84B38BAD9E380@DM5PR1201MB2554.namprd12.prod.outlook.com>
 <3b143333-21a8-6075-ae85-026180eae286@amd.com>
 <ea175487-1c3c-c7f9-e3be-267e6d2c6566@amd.com>
 <f7783fc7-aeaa-f582-2a8b-b6c497d4f512@gmail.com>
In-Reply-To: <f7783fc7-aeaa-f582-2a8b-b6c497d4f512@gmail.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from outlook.office365.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 17:12:35 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84248785-77e2-4eca-b88c-08d7984bc936
X-MS-TrafficTypeDiagnostic: MW2PR12MB2443:|MW2PR12MB2443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2443A128DA271238C0D3136E98350@MW2PR12MB2443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(2906002)(66476007)(34206002)(956004)(21480400003)(6506007)(86362001)(4326008)(81166006)(8676002)(81156014)(478600001)(53546011)(66946007)(6666004)(66556008)(45080400002)(54906003)(55016002)(9686003)(5660300002)(26005)(6636002)(52116002)(7696005)(44144004)(66574012)(1076003)(16526019)(966005)(186003)(316002)(8936002)(2700100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2443;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGXbNgExdiQwSMlqddxjsQnzwInQbc9k8JqblSvFXKD8YLGL8qy8h3d4qfWWR2bd5KmcZ3J8drJJjUvN6aqlrKhWqP12L+laLmOEJ/oaNON26TBIup0xLVBt/By1Zad7GbRAo5W1zBuxIN72QtTA0tLooLup4E4x/j5ZwsITjvI7WAAPfvnBhn27j9uv8YXqA98stYbI4pEnu+ohAtTHQ76n+tmmJDAp5Y6jIxbg/saJ6VLMlavtRlWnUACbUytldUz9aguqzZK1XWm4QVeo9VQ6HfUJDYHmHQU4KjIM1zw8CK+3L7yFcv1vBM72PvPTfiQAlB6G1SE5pkJFAa/GQCOgCZyrokVEWBQAKqtIZ5oEjCtbjEERT1qodLD19xehy+yDpOmODa46M9dpLdFWNISYFn9mfYNtVYT82Ar42/xoGtilHVGBeKTL49Hq76HLywXEiib3g5mvCF8SJlD6qfn3BWqxo2K6aNztFejggFrgYkWX4/k7EtM0fXQLosoEMxnB7ChtMqpK4GgHqbbuHlZ0rxTFCLFpQSB/q5UwbOPaNXfdurdSV8+zVmzfwJchKqn96smhpgEeY3RmPTSZ+uZjNpySEvp0EiOlcRPC7hw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84248785-77e2-4eca-b88c-08d7984bc936
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 17:12:36.8526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHMwBFDJ3dAjr9QarD3CduxIidbLWeHtz4VOEHRMfU2nytpG4d7UO2M8KO0sUFh8jC0+c97+aHIkgnLle7nT1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2443
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
Cc: "Tsai, Martin" <Martin.Tsai@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cheng,
 Tony" <Tony.Cheng@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 Harry Wentland <hwentlan@amd.com>
Content-Type: multipart/mixed; boundary="===============0014427598=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0014427598==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sq5675hwmtvvu6pj"
Content-Disposition: inline

--sq5675hwmtvvu6pj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/11, Christian K=F6nig wrote:
> Am 10.01.20 um 22:30 schrieb Harry Wentland:
> > On 2020-01-10 4:16 p.m., Harry Wentland wrote:
> > > On 2020-01-10 1:47 p.m., Liu, Zhan wrote:
> > > >=20
> > > > > -----Original Message-----
> > > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > > Christian K=F6nig
> > > > > Sent: 2020/January/10, Friday 10:02 AM
> > > > > To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; amd-
> > > > > gfx@lists.freedesktop.org
> > > > > Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Cheng, Tony
> > > > > <Tony.Cheng@amd.com>; Tsai, Martin <Martin.Tsai@amd.com>; Lakha,
> > > > > Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Wentland, Harry
> > > > > <Harry.Wentland@amd.com>
> > > > > Subject: Re: [PATCH 39/43] drm/amd/display: Use udelay to avoid c=
ontext
> > > > > switch
> > > > >=20
> > > > > Am 10.01.20 um 15:46 schrieb Rodrigo Siqueira:
> > > > > > From: Martin Tsai <martin.tsai@amd.com>
> > > > > >=20
> > > > > > [why]
> > > > > > The rapid msleep operation causes the white line garbage when D=
AL
> > > > > > check flip pending status in SetVidPnSourceVisibility.
> > > > > > To execute this msleep will induce context switch, and longer d=
elay
> > > > > > could cause worse garbage situation.
> > > > > >=20
> > > > > > [how]
> > > > > > To replace msleep with udelay.
> > > > > >=20
> > > > > > Signed-off-by: Martin Tsai <martin.tsai@amd.com>
> > > > > > Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
> > > > > > Acked-by: Harry Wentland <harry.wentland@amd.com>
> > > > > > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > > > > ---
> > > > > >    drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++--
> > > > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > > > > > b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > > > > > index 89920924a154..0dc652e76848 100644
> > > > > > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > > > > > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > > > > > @@ -1642,9 +1642,9 @@ void dcn20_program_front_end_for_ctx(
> > > > > >    			struct hubp *hubp =3D pipe->plane_res.hubp;
> > > > > >    			int j =3D 0;
> > > > > >=20
> > > > > > -			for (j =3D 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS
> > > > > > +			for (j =3D 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS*1000
> > > > > >    					&& hubp->funcs-
> > > > > > hubp_is_flip_pending(hubp); j++)
> > > > > > -				msleep(1);
> > > > > > +				udelay(1);
> > > > > Why not using mdelay() here?
> > > > As far as I know, mdelay() is only defined on Linux side.
> > > >=20
> > > > This piece of code is shared by both Linux and Windows, so we have =
to use a function that's available on both platforms.
> > > >=20
> > > It was used here before so we definitely have it defined for Windows =
as
> > > well.
> > >=20
> > Whoops, I misread that.
> >=20
> > mdelay is indeed not defined on our other platforms but we could go
> > ahead and define it if needed.
>=20
> Yes, indeed. And to repeat other platforms are irrelevant for up streamin=
g.
>=20
> When changing the code in a certain way for Linux makes sense then we have
> do to this and need to adjust other platforms accordingly or maintain the
> delta somehow.

Hi,

I already made a patch to define mdelay on other OS platforms. For this
patch, I just replace udelay by mdelay.

Best Regards
=20
> Christian.
>=20
> >=20
> > Harry
> >=20
> > >  From the commit description it sounds like msleep wasn't tight enough
> > > and longer delays lead to issues here, at least on Windows.
> > >=20
> > > Martin, Tony, do you have more details about this?
> > >=20
> > > Thanks,
> > > Harry
> > >=20
> > > > Zhan
> > > >=20
> > > > > Christian.
> > > > >=20
> > > > > >    		}
> > > > > >    	}
> > > > > >=20
> > > > > _______________________________________________
> > > > > amd-gfx mailing list
> > > > > amd-gfx@lists.freedesktop.org
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cc13de5453b1b45fe04a108d796b41f24%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637143572686205847&amp;sdata=3DVgCSlghDomSX5T6v=
2JtujBb%2F0qwYUNvX0UCDUU0ehB0%3D&amp;reserved=3D0
>=20

--=20
Rodrigo Siqueira
Software Engineer, Advanced Micro Devices (AMD)
https://siqueira.tech

--sq5675hwmtvvu6pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl4cpPoACgkQWJzP/com
vP/ttRAAgTFqVYY6MF0uzTMDH3TdMGyzbr3xoBiJ1bkapD6PqqP2+qI8RCTmUyby
klGs8CAdnrol31g3gRVGKiDPB6LmCN5Uqg10zDxQDBvrxH9ffNqXB5c5Pub2ZOKU
4rF0uAD1uNQOH043/rUfztashuoToYThpckkDZ8cuBsTL5uJdRnFT4fDIVqOs5LR
DRaD/y78icEACGU7TgWIKt1tPgJRinTcmR51rNEr+iGrONsTlLuFWx2pdhWoTxmx
HF57vn4X/rphHMNz0w15lkwbB+0eBH3gdWV9GD5ni4vytJHoP2/VC2B1ryWxCh8s
2j5du8rKTJqMXlysvey+rsqCbLfz2yW5KyRUodv+EezOmVFhq5TjeIQhKviq32en
ZIy1XYzmGHKo2NCOyxzuXxSNTX26nvl2TuSuoeagYZEQ2QPhTAmOLMcBgKazeFDs
p+6E1y5LywhXasFN/Og+/LRhj6FfK1qhalwg63FkSjz/1EpFeV6uK5TmC91UfraF
uY/t3HdfJnSXfNyqKoesep/zoV+XFX2/9YLUMy41kYzJtKDHXE9r4GrncPBmUUgq
pt/sPaVXit9QbcXhrHSLcVPMzKA1YgEWJfCGxhF+DQsr3OOawPp/OnZCd+3WvRoX
flp9+Se80vbv0g9az6vPHgrARgoEIppg6LzgibPmCCY8Uufdwz8=
=hVnl
-----END PGP SIGNATURE-----

--sq5675hwmtvvu6pj--

--===============0014427598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0014427598==--
