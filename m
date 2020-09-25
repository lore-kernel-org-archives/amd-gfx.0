Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB9AC4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481F1208A9
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qfyDIs+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481F1208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58286ECEA;
	Fri, 25 Sep 2020 14:27:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085C66ECEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgFDbFOhxXjGZYPb/1PPZWR5yXjte/V3WolLhm4pJ+Fv2P/1nwqreZ0WPeL7qyLJ9MDM3X1XAND6je/pAYX7BkkqRz/Jkru31pQ1eLF8HKgcKtMp68yr+dqvI4mcvlJJ6z5F6h5+ll/kH8sqWje1/padUywVY2NWmAlYXZ0mlzwPPdP9b/yDaW0xqkBMGyGjwUzbmlutNMcjYqtPQ+sat17irUP4pA8s/sbD0kLOAPImDx1TGq9daMrC1x+FqH2Hq50gGnGzO43RJqdlSQx7rWt3ETd5aGncpHXtNTMGGd89l4cLQe0c5XUgRLXMuButfjFBM5Qdd6sXvi+Vx+QDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9jQpzoez5TG1qaPCeAySCD2QTsbZvKK9uqpUGPWEpg=;
 b=RyPT0QTHIFzmq/Hx1kgKLIGmPTD35CRlxP7murCwzxh/jVoDldwkiDYQMZx/nNH9PbXnFWqqorXInz7oMROOFPQ/CJF5KEE5REI0q4faGuzf50KDZ5tDnNpNAh9J2qmNoROnY2ns/Uf3PCUA8cEs8auzf2bgsgEcenwNBJ1nQ8GBubS17eC9gPM/0D3RkBe7VfXANjUfNvL7Eej66I5z16Z8zORDr8Wyup6SjmN2VND6y+W/ro22sIjxhfklxGt3Es9d90UjMQiJZXtdLH/TMH9i8IuFwwfF67LNHod91Ai8QsPjjjJ+K1FRSV00CuMmQvkHxHnyfwK4/tFm7oNmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9jQpzoez5TG1qaPCeAySCD2QTsbZvKK9uqpUGPWEpg=;
 b=qfyDIs+Qe34hz/GtAChdEHc47+br4SAOzRrdp6PRJxIlo8X+zAmqBElMg8gykwVGJ/Oq22PBxkvrEvyYTxLA+xe8s0j0wfDtwBYHL+lsCppEf9CRpAM+HrKcD37xO9CHv7ieJEr8K5dHeN7OI2h8F4AqGNOJhI9lLZFL/syD/Kc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 14:27:47 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:27:47 +0000
Date: Fri, 25 Sep 2020 10:27:43 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: amd-staging-drm-next has a compilation issue
Message-ID: <20200925142743.4lsihvvdopzpclmi@outlook.office365.com>
References: <20200925135456.sudcskvjvfqsfnc4@outlook.office365.com>
 <CADnq5_P6s1abDn2un1dbxcBR_3xcAZeT9GdEfrDS0gjtoHNR3g@mail.gmail.com>
In-Reply-To: <CADnq5_P6s1abDn2un1dbxcBR_3xcAZeT9GdEfrDS0gjtoHNR3g@mail.gmail.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::980e) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:27:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb421b07-0dcc-4da9-2743-08d8615f2caf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435591BEDF0CB2F5BAE9AF8C98360@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xG8thxe6GyIEMu35qNWozAoxRzlJ4HSznqXLitLlneTKlc7rR8FcoOJXcv+Cos4cSIFy8zbfkekgL6A1tmSb8N0w4+xDKtpVQ6X/Ad8mUR5OWde6chEmWPI0inUFbma9HW7eAARqPstS5G0WVW8xVxfXqKVTo6m0pHyoWe/rJWOYrNq+AVGMXVd+AqMgsG0DCW8qVCLFu9zCE1ICQCWOCSvDj33jLcplbuhQWl49IUR7UY1D63NbTEK+Vfe1vVORCSIq0oVPTHcUmPGsfJSnpv5XNcSaeLTmvzyNc8Hby2gfy2QPq7Bdgu3SGS92IrFtz1tykMS4WdgJh8R/t1HowgkirZQ+LsPDFe8lnDZXkRbu8JxOxiDsHRQhGbIu+atXLot+TkmAlQGlFKEBThcxfNq3soE1ykJBMFiKIi/N/yHSJzB/dwgUiq1wbPTFE0NkXYXisYvYzajCrn2N5BSmeNGz8Jnlu+joWGpps4Ze8synX5c0XWr0RYHtLtEO0qxS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(16526019)(8676002)(8936002)(45080400002)(66476007)(966005)(478600001)(66556008)(186003)(6666004)(44144004)(55016002)(2906002)(6916009)(66946007)(4326008)(86362001)(21480400003)(52116002)(9686003)(6506007)(54906003)(53546011)(5660300002)(7696005)(33964004)(1076003)(83380400001)(316002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GlRzj+uuELdB9xlhd/rl5PFTAcVWkdOHXG/VHbTfzmikYnc2AGlgtNYPMrrrPzpN5U9wlA7PmGlQkbSxT4GwvYmEXufhvuCRw1ed8XanKQ0CUb3U60HwZNlEGERCweWdLddOOxvGPWZkoa4L4kIZph4+incFWoNr61zSNZOyCfhW9s5JUVARzuYaqJVO0wW9z+uJ31/kx5v+L7AKqimWVncs3Am6ot1+l/Okm2zD7m20MXg1QYfDj7/nDleQtPERPY3C1e3VDQnX/t3XiWAt6mQ1eNzk8RFZu5vtA+MczWvtRYkxyc24tl7FH69krqRR2CEt1i4HedPCN5CZWxjPzO1GBHiXrgmEcf82NDpK4FudszrCZaBvMzc3MIBffLsPUVMSL7vN1yS4SUITN+PZAFv20aLa4MYCdY1typ5US88i0CphhSUH+FX66sr8nWCMpyAEA9eNResN9b29L2MAwuhCdeOa8pNJpL1yEB06YihAwwP0oT8Rgo9UQygYUOZxeqBI1J0ak7lBb6EsI6usFCDr2AEJgznrJKOlg3y8GehBCMBGGl9vm1gVpIe8LbUPoMjEofEiNA+Urgy4Hb4xfzSdab1dtZ89KRAWKhinY25Sg2iK66LaFMooi3dMJoD3YnaAd/zcTsoHYNebCf0WyacKtgcIGWDSyxzqUtHyyAwmnhnZwf9oJFnLJrae4jfv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb421b07-0dcc-4da9-2743-08d8615f2caf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:27:47.3942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6/A1N5wRXQ9Eh6ajlhyL/mMW7xtUmTCCOW/reZmnEwYm81KN8yzfK3wkiZv0uY7Q28VXqTHqB8GJk1xPJiotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1363881813=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1363881813==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eyhxeyfvmxfvvuou"
Content-Disposition: inline

--eyhxeyfvmxfvvuou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Alex,

I already tested the patch and everything looks fine from the
compilation perspective.

Best Regards

On 09/25, Alex Deucher wrote:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.freedesktop.org%2Fpatch%2F392192%2F&amp;data=3D02%7C01%7CRodrigo.Sique=
ira%40amd.com%7Cb72ce334a3484dddab6c08d8615e65d2%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637366405348981954&amp;sdata=3D7kPoyo6sCqlkXBTJLbppjedOg=
cQnRT8ZmJICCCEXCM4%3D&amp;reserved=3D0
>=20
> Alex
>=20
> On Fri, Sep 25, 2020 at 9:55 AM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
> >
> > Hi,
> >
> > When I tried to build the latest code from amd-staging-drm-next, I got
> > the following build failure:
> >
> > drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c: In function =E2=80=98amdgpu_v=
irt_init_data_exchange=E2=80=99:
> > drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:586:10: error: =E2=80=98struct=
 amdgpu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
> >   586 |  if (adev->fw_vram_usage.va !=3D NULL) {
> >       |          ^~
> > drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:591:9: error: =E2=80=98struct =
amdgpu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
> >   591 |    (adev->fw_vram_usage.va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << =
10));
> >       |         ^~
> > drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:594:9: error: =E2=80=98struct =
amdgpu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
> >   594 |    (adev->fw_vram_usage.va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << =
10));
> >       |         ^~
> > make[4]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/am=
dgpu_virt.o] Error 1
> >
> > The latest commit that I tried:
> >
> > drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K monitors
> >
> > Does anyone has seen this issue?
> >
> > Best Regards
> >
> > --
> > Rodrigo Siqueira
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsiq=
ueira.tech%2F&amp;data=3D02%7C01%7CRodrigo.Siqueira%40amd.com%7Cb72ce334a34=
84dddab6c08d8615e65d2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63736640=
5348981954&amp;sdata=3Dw83BWszpGXMuId7GZJ3ecnJ8PCBOhpqDpTtKKSo4K0g%3D&amp;r=
eserved=3D0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cb72ce334a3484dddab6c08d8615e65d2%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637366405348981954&amp;sdata=3DS8kmcb7g4bTnhbaD=
RLdQ%2B%2BCqVL7%2FhSugc9BHyIGaDW4%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--eyhxeyfvmxfvvuou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9t/l4ACgkQWJzP/com
vP9OzBAAi3nTRHI682ZUA5wcP9tsUQm/GYENP410wTbvIYZ2t3cS7HlVZ7grgWgr
sgLHmsi+qTy63CP67jbWxbpvKfWql81HLByYwZvC6u2J0iDbIkrpi0siux17f8K4
hkDYg0b0YFCU6EzaeNTcldvM+oMl44puIEBZUyr/ddxTyqCXoaTVUc8JZn+XPCTG
v27NDZl7w0W+2BV28vqGhVJ0u3chxlzPRRTP20lvX4DOa3IVumUj/yALDnjIEaCJ
I+a0R8G+yp+1k+r0JliHcVZobf9tRXHSLBYckgAYTzkPAZD40EG1bFvogxXjgMSE
lBU6iEVbTlmm8Ocy5xfN73XR3xZF0pkSgacQdIe00wa/aM8eXJ9UvTX8Ch90rxmH
589iZRHqbMakWChG3OcRgNuZQ4YGvWE+LyNyXFOnknRNwFUVplb5knv+ERFJz63Q
2/pPpUrKJKjsTHtOLZ6igXeXTERFC5oDahJtHNNAclGOrmXxrIs6RTKxPWb4nnaj
3YaCOPvsqW6Z3xow9emfuub+S/Uj4qhdV55RLKFLxMNaGel5oJNpo4WL47+1EA4N
ZkrirY3bK6m+/xXt70jw276NWu6AeweWkKLCZyifoz27Tyfu5Kwz5WjwQhrIZpPG
L05OoL1+nYmbrKnSIRk5sSH5XE19xGUfTk478OGVW0hi0/qsgNk=
=Ow6o
-----END PGP SIGNATURE-----

--eyhxeyfvmxfvvuou--

--===============1363881813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1363881813==--
