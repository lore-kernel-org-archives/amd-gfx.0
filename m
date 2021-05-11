Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F9CC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 00:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EBC615FF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 00:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EBC615FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CB26E97F;
	Tue, 11 May 2021 00:37:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F206E97F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 00:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFBBTIJVh2md9VgjqF7WOHUI1E0Xo5BzCGGCITlV6Ax9q2ElUpMCdAe5SAVQ+5wU7pAoUgvq57BzzFW6HpOnoTwY6RXFC8YcBnzRWs/RSzauPc6em15bmlHyuHHlZ6sWL9BgA31C5jzbXi+eeoR0U7eovUfbQLLzmslZ6+wjPxzYCPoXpdmC7Lm+OFDIrVO/AFp7vgUQK3kSmjy4YyOiQQHXg3OtoWud5kVWLd33Sp6cB1+wY0dWrvQL0kVzyHPBoEhu4m21ZapljKitDinJQHMpIKM6ZCgnIsUISvKa1U9HEkDaJljCSyenpyoRCilbFwGQConI+U3Ra5ESZCzVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8YhO2vwlN7yu+eZa6Mr9q40GQBgYwCm0TRahGv7si4=;
 b=XvV1T5iuwFruPGxvCHV17/RiuEjqTGn67Qvqi9uR4g+9+Jk617bXNWOSgy2kK5NgJ4wHtYpK9ohHfZzs72v15kRbrZoQ0ns6FvoikPkDZwYBziyd2g4FFeB4O4ZMh+5G8ZuaLUeUPETRUU4EcATHbUt3jvQJ/YgvhvRxs1b7WhfVS7Y7D9nFQPmHnCTrw/19Jk+qCjCSypHpnojIlhHnAD+NudGavtFETBQWLHZGuDz0ep1im+/14JY25s8hEU8s0knEnCf5aXpz7FasZAGeE8PdzfYzGRWXTV0FFYaSM3ks+S5SBfOZExXmSc60ShEdSRZ0YNsDp/e04ReIQO+G6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8YhO2vwlN7yu+eZa6Mr9q40GQBgYwCm0TRahGv7si4=;
 b=nbKO+GNh278UcqLlkofs2PgKjkl9TZLr/LwPp7NgIFstj/XCZHexroyj8KuNbHC0LAP1FZBFC+HeWIDGBL79ZlWrb9UUSJj+lln8RN3QkxYNz0KUbqkVYWUnCWBwCJ9y9QR3QA7Azt+nfN3ecozjoB42fVoRr18/d2NyjHFdbQ0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Tue, 11 May 2021 00:37:04 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 00:37:04 +0000
Date: Mon, 10 May 2021 20:37:01 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: youling257 <youling257@gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when
 using overlay
Message-ID: <20210511003701.eik36vjufjbfegcl@outlook.office365.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <20210510022047.9323-1-youling257@gmail.com>
In-Reply-To: <20210510022047.9323-1-youling257@gmail.com>
X-Originating-IP: [2607:fea8:56e0:6d60:f4a9:20d4:302a:1728]
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:f4a9:20d4:302a:1728)
 by YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Tue, 11 May 2021 00:37:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca36dd9-0cba-4308-d4a0-08d91414e5ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4402C6005CB4661345BF06A098539@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdF1dHJ0pSV/4wDfhiy6i8pNPopgnMrLSQoplkqH7JeufYgeFMQ1fvpVZpQBKolqb7r1QOXxifpIEoJK+W/PjVvBjt30SDhgrld9UX9/5+xRm24KIfLEvE7enJoWrrKYTwFRcYcSD5K2SM/VSTnuc80gXvdPPout4nPRfBcMxLzkrNsJsgwJxMCHoxWwLBIgaqSV+VQ0lgAfUz7s/bdLtWA0w33IU2F2fH/6IqzrIBS22HaigogAaQHhCyosGjHAMH7DzCDip6kuLu+tTTEIOrmzPlPXDLl/a7gsGpKpAcZJTKROKU5PakYl1LXCTQDkpRfikOwvBza1ggWITVVkzfescez+v+26RalDL0WA3oeneewINkNkxKZhYwDPvIVty2qzUpAbqloLTgM8X4sgjw32Tk6rg9nxL+31tv/xQ4bwkQA+IE4ZfkR3uVJRW0tAyjWvEgQHmo/5c1jMl0NvCq4zvRqlTvgzFfrHCXD8Ypp3a9sigw/Hb6EFvHi/OLvbc/zQX/UTsSLVGGEwglMCsAtPqYEyLvU70xbzWPklgUW6hK1D3AspBNmU3FLUQ3YrAXSdcfydS5xg3OrfysUKJ8cY7uF4ONgMkTrFqkq2X5xfxHGT4qkvATCGBVg4AaC7MSKymAGNIOobVblPAf/y9TPhlErjHRp0ZWi2U8r44npn/DuGRUMPAbubjPKJl3+Fm4aJuJSpRfq0yR1qvzFBf21xw7g3oHICG1fxRxy8/5JoPUHp4tBBFfZRhUxZL5pTomjk+iG3Y6++7flxbbnF6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(1076003)(186003)(16526019)(4326008)(21480400003)(316002)(8936002)(38100700002)(9686003)(8676002)(55016002)(66946007)(66476007)(966005)(66556008)(86362001)(2906002)(83380400001)(478600001)(6506007)(52116002)(7696005)(44144004)(6916009)(5660300002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jYhimJi3U8+BJ8ixZwVmiZvcirapiMi44oVWrcD6/+evpUGJFiQNVIBduiKs?=
 =?us-ascii?Q?fDJkM4YwSOzu0YPyhDl+J/5VFcaC/uZtlyxCOWZCkD1zAw7wUG2Db0yuMny+?=
 =?us-ascii?Q?KYDvk1wN6O5e/g34ZBvsatxkQ2AqhxklQAgcmOAVZVevy4UcGAqM91Bes6c5?=
 =?us-ascii?Q?kydGcJr9CR0GE4vuQa5fGDdk0jYrERa6LkYzoLynykP40qR2ETkMpBu/jY2x?=
 =?us-ascii?Q?CVIE/S7of4LZJpG7IfBSmW+rhqft6DMxU3w55gByupRSKCfnCO04QDYfk6zK?=
 =?us-ascii?Q?zqEeG1iSy/eoz4UIxYlRZvT3bKa+8UEUecXkYP13Jyq1Td2/1I1IQ7I0CucR?=
 =?us-ascii?Q?S5kQJJdiQzP5mhOHCnaOuzQ+9Zlp5nwdgEyUz1F/N4q0fN22MDW86uCNm7WH?=
 =?us-ascii?Q?m6tdlXNCb/gFaexCwwFdLWWaBLXJYe2fbJBw3L90K0MFrI1LTbHHEc3KNlMk?=
 =?us-ascii?Q?ZTEq/gj8wlYGi4aSDk7bBZ2/GiejkCczzr87SOcwej93l7UNyCj6UeFahdCj?=
 =?us-ascii?Q?eKxf00htNPBznF2ijEOjxWxnuT3ubyANnh3wYJ6XkIaDKMTjvKWrRHeXbStS?=
 =?us-ascii?Q?1oRdZ15yf1J/kTyYiF7vYt84U9fw3RUtarw74tQraOm04OZEWPy8lwfPnt2a?=
 =?us-ascii?Q?9ShZ8lULhuzl3VhJ3pDBuBNYu+0dAISalVv7U8PptLgmiwDEjx4UH8ptuSKx?=
 =?us-ascii?Q?B93MGwrTuz8YI5xpj1wx0FQBaAmHRwq6fSqW5zvqEsIGfEndypjwbTvs5t7A?=
 =?us-ascii?Q?GC9umIyZhy0xRs9EtkIrecFqe6WXfwWfJIH+5uVRzXFrAl/4MdbQxJnanaKH?=
 =?us-ascii?Q?rFaEICG2NbGfJ52JLJKGynifCdDselBF5MVosbOkH8gI/ZCngwsZq2xo9bGD?=
 =?us-ascii?Q?GGqCP8e/0+BCnLqBjyZ/BhORERh2pl9VuQcHz2/5jeGy7LP2Mw9EJ7riz9Zc?=
 =?us-ascii?Q?VjdH2QbPj1xW4kB6F3kQulrqcdQQ7/TNXhDRIEf+/PWnmTfAS75hmpIOkSUz?=
 =?us-ascii?Q?lXvdjo1LLYEx/cll0krWm7oPdYBWJMRp4vM7URkUqHrgeYnNqfT1H5fh0jJj?=
 =?us-ascii?Q?c5RyNuLLQOqwCNR1dkJDmVmCuBtPuO8CnLWoyacmuGK80Fj5R09jEOtgoK1V?=
 =?us-ascii?Q?NsTBe+9vyfj8R2259ybhjrImm5usiJlUqkq1nYgXIkjwHUFV3Z5n5hNd6VLD?=
 =?us-ascii?Q?TUItEHqkYrmGm0bSm3yLdn3K4hz/dDU/p7pb7cltcKQtFbuDF7BgA9od9pUo?=
 =?us-ascii?Q?fdzy+egPMAUMtuxpxG/K1jKC//Uyts9KhURsB7QyHmGNWMJfBjDXluDpM+pj?=
 =?us-ascii?Q?mtfdLBeaPf7ZnhwAdnaZieRjv0wOO0qxxHl9AzaG/4FQfrqh/Fq9JXxDbIHs?=
 =?us-ascii?Q?BA9DEGAEsi5G2g/h5fGm8aZyIstF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca36dd9-0cba-4308-d4a0-08d91414e5ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 00:37:04.1266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBQK16UJSK9IwEHth5niAXdNBST8r+foAvkvr24aChI5KU95zuhZ1Cra3Zmsj7KOinFRPYifxupIkMEehysATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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
Cc: amd-gfx@lists.freedesktop.org, seanpaul@chromium.org, hersenxs.wu@amd.com,
 Harry.Wentland@amd.com, Nicholas.Kazlauskas@amd.com, Ching-shih.Li@amd.com
Content-Type: multipart/mixed; boundary="===============1373991011=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1373991011==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="traxc5k535w5ch5n"
Content-Disposition: inline

--traxc5k535w5ch5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/10, youling257 wrote:
> I using amd 3400g running with android-x86, this patch is a bad commit wh=
en i use android-x86 on amdgpu.
>=20
> Revert "Revert "drm/amdgpu: Ensure that the modifier requested is support=
ed by plane."" is the first bad commit, cause a androidx86 run on amdgpu pr=
oblem, look the video, https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl=
6_3rtZ7IqbjR_/view?usp=3Dsharing
>=20
> "drm/amd/display: Fix two cursor duplication when using overlay" is the s=
econd bad commit, also cause this problem, https://drive.google.com/file/d/=
1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=3Dsharing

Hmmm... I don't think that the two cursor patch would cause that
flickering. Are you using the latest amd-staging-drm-next? Do you have
this patch in your local branch:

 drm/amd/display: Reject non-zero src_y and src_x for video planes

Thanks

--=20
Rodrigo Siqueira
https://siqueira.tech

--traxc5k535w5ch5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmCZ0acACgkQWJzP/com
vP+MtBAAihHsY6M3k9QW2A/Wk7em7OqhJh3jFO+ApekpERqVPth4B4EejJUvbOZI
p4mokzoMJ2hg+mcEqLoVWs3GIb3Dh3yER+XutQ5yI+iq8bEpqChlRFbHCuVkWehb
RucI2fAxMf0N2TeQYvG3tL72mAWrQfulnd9V9WHmrTnq3dJySJlOWnocZQc6kDeV
0MYHOS0rPX2XcJ6MAubfs6OFFsLqeSUFvHZTTP6f3YW/wPXkEIOdfXzbtnuq3HlV
m43Plvp6AM2qSBh2vS1DiQ+1z58U3R8ApicIC3ydvI/ofgcwxqlRx6pcEQyyGVtp
XuwdyC/qLzaKhOhxIo6oLCnyHDJV3rHXnz/K7KG24T9Cc2PlZPdzhdndxBOtbmV0
LWFAy9s2ohTky5fxy17YA9iUywiPnkZ/Gwe6O8/at6/xFtwA9+K7Gf+QTG7byK2Z
bsBjvNSecTYhQg/7pL4Tg3nVWkwxiPjmY6XFfjlgjEqevVWX23LbseZDzBZ4yrIy
7Hev+FVgVlLDAGRF1M2b8ctdOZircQ+VPWVlmQ5J83e39RZUQ/8BmLPlrfwBSLqa
CD/3gqpmqZKbv8zh3zOa7UIvNKy/aeChXOdvGigq9sI5ydBTWCZ/qc4Fp/d/Umk5
+oaMrC6KfqmwNIiL7vCobVUCTenlYWykVA+WgYZNiVSuoLpS2RM=
=D1Cq
-----END PGP SIGNATURE-----

--traxc5k535w5ch5n--

--===============1373991011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1373991011==--
