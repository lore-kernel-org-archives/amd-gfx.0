Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5820C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862D6610E9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862D6610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A27E89FC0;
	Tue, 18 May 2021 18:58:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE9A89FC0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 18:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaYu/r1gKV43plWxliG/nv6UIgyUfT54+NJRHFl5zT5mbwdmR34Z9nUSup5VdcqNDhVlGYMv12ObGxsjrmH5i8jNiyWOPNWxLd2Sn1hgVH+vMpI4IZgx858bonOKFr0MDir5yhGn54HX8H8anG5UtHVN2+ZCSIbVd1kEkngejURpGfsuw8o+IXSx3SI2xaEuudhHI6hpzhP1qHDvrf24ryO2Sipeg9/I4qpLrNWbKbEB2FAfCFUsvpvL/n2mi/rzrMUx2J+UxOhcXwXMFnRAyZ27j7ZzDODJkvQQ+fecMOh4F+ci83upSfZztC4/8qKqKVAfZijmPjHtoujTaUlrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr5Fvd0/hX+Z8rKBL2giB8i5LksBJyygAxugAjJD8do=;
 b=JCQznnLsDQWUyvTCNTGWJG7h2BOJ3/vFkEP5m6jsozewpLoH5wRzvE+rzb0GK2iTfy/NK2CF+hIslbSo6SnLPgSTgfKlnCmxZWam4jZX4cmWnNwKasyNf1R3NN2cW9C85PtaPSUMWzi9SfJbXhyTIPsg5vRbA0QRpz/81bjMquSJY3P0O7xcpDeg+YFvP3vh4JsMiT0aIyvTNI2OTby4e9qO5A2aORRWQMQJ3qXgOzsTRs+lgkoS0Cx04nv12aSsxgzd2acclWGc7A4onEaqoBiF7wx70PHnH6/6nioUmMHCM6PcZqnPjn6NkLzRThEGtRsKglHdckGXmuiLxX9b/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr5Fvd0/hX+Z8rKBL2giB8i5LksBJyygAxugAjJD8do=;
 b=Iw5c8PjqtQ7HK6SmgTlvaX4ITN3FkxYqB2yDkEc/GmwQbwSOdzH6Bn2qmxxY/OHBhaDcGy5O0h/a5wEB77a0tbR6lmu4gLeCeePePQxg96VLxpksB1Aq3j7fhzOJA7psoyfm6hMZw0E5MKsbXCqSJwkMyEB7MP8VRm54nfXDZtI=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Tue, 18 May 2021 18:58:10 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 18:58:10 +0000
Date: Tue, 18 May 2021 14:58:06 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Mark Yacoub <markyacoub@chromium.org>, seanpaul@google.com
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
Message-ID: <20210518185806.gsrzfcxcwo6o47kc@outlook.office365.com>
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
 <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
 <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
 <CAJUqKUrM6jrUrZkcfF=R7vNeoj4KvwymwM4tMVy09ndsPci-9Q@mail.gmail.com>
In-Reply-To: <CAJUqKUrM6jrUrZkcfF=R7vNeoj4KvwymwM4tMVy09ndsPci-9Q@mail.gmail.com>
X-Originating-IP: [2607:fea8:56e0:6d60:6b1a:1957:ce44:99d7]
X-ClientProxiedBy: YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::45) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:6b1a:1957:ce44:99d7)
 by YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Tue, 18 May 2021 18:58:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b59c6af7-204c-4c6c-9d75-08d91a2ee186
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4057B3B15DE9EFD74C0DD3D0982C9@DM6PR12MB4057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqQnTNVvCzQUiNTDbIDyZ13SGdLcuJhmIOZbbC9ge1IH2xfY7o+YffzmrcIHgLD+7YH+CK50/1/DP0Q1i4FzjXQM4k69K9M7TuzgDRcv+OClq1SBlzkOBkj5NoqAdmhYuQd5X8YRnnUm8KyZ/dH8eopE3lt/kUzeMZeNxyNIN922PfHjy8qEsrhBuJCrtXbiut5Z2P1BOpcoiU4+DZfv5VgQvCqGkr29cqzMmGT3SgS/NQCnhM/iwac6rCybJSGIuX3Y5PDC7aTDiCbNaFOdLjaO842Dw5fvFOEbZIYI//ArZjUdwsZ5EJ805gWNhaYXW0vnmuMlHHs6XV42sC7/1LR+aJItIftDkbaD/6kvM1FJkFMPQosxE3zG74LJbke5eGATQtbbKXNdh6EZn4VDMjr3f/06EUryUkAmhbdMITBo7c0UUd5/Jd1aCAejHkix3Y1iAF+8zzZcu2Q5lpqAr4ZYwG3npv3j84hNPP1Kfo29mDZoevFMns1CIGgD4ezrxDU4BmPVIPsXHiKoh7FCdEM+XPesYbkIG/pg6ckq6RLl+rOQ1xy8mI4A8/U3S6agbzv9C7chCUTP00CPl9vPEcMmA57wjkc1jszokkH5c2gCaKSH2lN4sdP68u0sEDWW5qMQKDTbbcU+/ROVmOMBdKAXOKPZpLGxXmxTmD/UL1ueabsnJbEpheioSV7KZdn/dt/C8FuxoN54Nm2sEkPA9DjQ09gG8nIkhTxNNweL0Fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(7696005)(44144004)(478600001)(52116002)(9686003)(4326008)(55016002)(38100700002)(186003)(316002)(16526019)(1076003)(54906003)(2906002)(6666004)(8936002)(21480400003)(966005)(53546011)(6506007)(83380400001)(86362001)(66476007)(5660300002)(66556008)(8676002)(66946007)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ARy/jk0IakzFi1aKX+q3Hsjq373Fh1JBJWZeDmw7KyTgtGUI3a+eUNih7wB3?=
 =?us-ascii?Q?X0JThDnnwPhGXOUhuWkbzZtVADNNgqdz40cmoWcHn3XdufNx3xT5lT0LlDsZ?=
 =?us-ascii?Q?NMd0o/5i+zkPkV9e6g6vKoxgBq2ANz6vzbZmunEXwVv3rVojLNqQ8mdl7YNG?=
 =?us-ascii?Q?SNnTbWAWSIcCeF0tgnzRJnitrKU65QioCMPu08Q/qSUade9iqVGRJwdIBVSP?=
 =?us-ascii?Q?oL8AvX0VfTLsoIQCHmqn1JPFe33gwNsP0XSHb6XxZbuDvzEdyGJtRvV3k7Mc?=
 =?us-ascii?Q?9ukbi2Phr3gTf2Ta6yCWq/cbnO6ZxHaZ6VVse0YFI3wStwIzR1hWStAJtI+A?=
 =?us-ascii?Q?83MU40VIeuX32wnX94OaqZHqinFtLG5gjsRGCAfX0XZ4NtCAIgz3+/5yBI66?=
 =?us-ascii?Q?DzU1NUDoM43stcIKq6htW03BGcCgnJwiiUrPuKFIG5awWK6UTLKl/N6lLOA6?=
 =?us-ascii?Q?Q1NHlRTDuYSH/J5TcdsHymJZdfeXuhj7lTbwHZVN8NBIir9b+Jrb1oH/8o83?=
 =?us-ascii?Q?YFQNlAhYhbs0Niya6JxgAebEiqvqg7umV1Wt8JoNF3Gdxt5KldjEyMB2sYgp?=
 =?us-ascii?Q?xbEXRqR23ADd0hHtMGY1zSOIBm/L66d+0UjSBKkdjT1wihQh0B7ypYBtsjFf?=
 =?us-ascii?Q?/mHTzG/gAHFiK5fwNuk9ijG0pOV8UnJXZo4mElwMik4KpRgaqPXNFrfzd6MX?=
 =?us-ascii?Q?jFPwm07slaDixaFUIe/UvCoNgiPYFeU7PqKzz3QvbXBOvckqkuMWDmlAg3Mm?=
 =?us-ascii?Q?n++/5HBceBTbD6v/2lFhYnLaWq0EwkWW2XNI6Uk19XFYqSBBhudmUio+j7CA?=
 =?us-ascii?Q?k1EY3xZqR076jaIOBtFPB2Y8aMq09huqVwWguwFZvenxve17avMEi5lBvCpl?=
 =?us-ascii?Q?iyvuLwnfqEolkTvRXz7D05Zg4lG6c9RvLLQiLRrUwqOWc2puwVxtb4G5Iciq?=
 =?us-ascii?Q?fmX6BjTmb4zOYHV4q4OAyu0b5NNZkb7Vun18iJkfIzHQ8WUHr/nFXxyEgU4j?=
 =?us-ascii?Q?AIbH490pl0/2cUejjneRq7ADpGyxPd+vqREmXbptDNoL9O9Ktb26JhnUwLbA?=
 =?us-ascii?Q?tUXY3RarMv49ylhjISfj0SX9JMxxaPJeNnNoi8akDhyqbnHXQeii927nRYkN?=
 =?us-ascii?Q?BNAkVczXlULertapZq0KJed/JwRvZXcx6adc9gnCx7DKf44ZIKmRBBa/XXJl?=
 =?us-ascii?Q?l5WeB3BkLMVGMDxNc3TIJxpGmughMk1BtV60OuX3ZTMjcWYaF2l/tmEihG0J?=
 =?us-ascii?Q?t9tMKgNcjMucPRqBuw6EC70niMTwZHv3kuhNvKDGZufoju1G5GdJ//zk52fv?=
 =?us-ascii?Q?M+sS2Vs5hS9b7cEG2rapsgzl66HfCg6x0c8a0o2I64+VUyXIoaVL06smOiHw?=
 =?us-ascii?Q?T3BckXcqll9Xr+Lu2Fh2G1Ld/Tij?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59c6af7-204c-4c6c-9d75-08d91a2ee186
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 18:58:10.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shEsyKlfeXGK40Sd6BsL3v/RIgRYsxsnrI3ANYSjQ/UgDYvlxJ7PZDqqCjZoFCperH+zGPpK0r8ngqLfENqAcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 "Tianci . Yin" <tianci.yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: multipart/mixed; boundary="===============1710677926=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1710677926==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtvryjscdlrkwegi"
Content-Disposition: inline

--qtvryjscdlrkwegi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/14, Mark Yacoub wrote:
> On Fri, May 14, 2021 at 12:31 PM Mark Yacoub <markyacoub@google.com> wrot=
e:
> >
> > On Fri, May 14, 2021 at 11:28 AM Harry Wentland <harry.wentland@amd.com=
> wrote:
> > >
> > > On 2021-05-14 7:47 a.m., Rodrigo Siqueira wrote:
> > > > A few weeks ago, we saw a two cursor issue in a ChromeOS system. We
> > > > fixed it in the commit:
> > > >
> > > >  drm/amd/display: Fix two cursor duplication when using overlay
> > > >  (read the commit message for more details)
> > > >
> > > > After this change, we noticed that some IGT subtests related to
> > > > kms_plane and kms_plane_scaling started to fail. After investigating
> > > > this issue, we noticed that all subtests that fail have a primary p=
lane
> > > > covering the overlay plane, which is currently rejected by amdgpu d=
m.
> > > > Fail those IGT tests highlight that our verification was too broad =
and
> > > > compromises the overlay usage in our drive. This patch fixes this i=
ssue
> nit: s/drive/driver?
> > > > by ensuring that we only reject commits where the primary plane is =
not
> > > > fully covered by the overlay when the cursor hardware is enabled. W=
ith
> > > > this fix, all IGT tests start to pass again, which means our overlay
> > > > support works as expected.
> > > >
> > > > Cc: Tianci.Yin <tianci.yin@amd.com>
> > > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > > Cc: Nicholas Choi <nicholas.choi@amd.com>
> > > > Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> > > > Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> > > > Cc: Mark Yacoub <markyacoub@google.com>
> > > > Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> > > >
> > > > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > index ccd67003b120..9c2537a17a7b 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > @@ -10067,7 +10067,7 @@ static int validate_overlay(struct drm_atom=
ic_state *state)
> > > >       int i;
> > > >       struct drm_plane *plane;
> > > >       struct drm_plane_state *old_plane_state, *new_plane_state;
> > > > -     struct drm_plane_state *primary_state, *overlay_state =3D NUL=
L;
> > > > +     struct drm_plane_state *primary_state, *cursor_state, *overla=
y_state =3D NULL;
> > > >
> > > >       /* Check if primary plane is contained inside overlay */
> > > >       for_each_oldnew_plane_in_state_reverse(state, plane, old_plan=
e_state, new_plane_state, i) {
> > > > @@ -10097,6 +10097,14 @@ static int validate_overlay(struct drm_ato=
mic_state *state)
> > > >       if (!primary_state->crtc)
> > > >               return 0;
> > > >
> > > > +     /* check if cursor plane is enabled */
> > > > +     cursor_state =3D drm_atomic_get_plane_state(state, overlay_st=
ate->crtc->cursor);
> > > > +     if (IS_ERR(cursor_state))
> > > > +             return PTR_ERR(cursor_state);
> > > > +
> > > > +     if (drm_atomic_plane_disabling(plane->state, cursor_state))
> > > > +             return 0;
> > > > +
> > >
> > > I thought this breaks Chrome's compositor since it can't handle an at=
omic commit rejection
> > > based solely on whether a cursor is enabled or not.
> For context: To use overlays (the old/current async way), Chrome tests
> if an overlay strategy will work by doing an atomic commit with a TEST
> flag to check if the combination would work. If it works, it flags
> this planes configuration as valid. As it's valid, it performs an
> atomic page flip (which could also include the cursor).
> So to Harry's point, you would pass an atomic test but fail on an
> atomic page flip with the exact same configuration that's been flagged
> as valid. Failing a pageflip causes Chrome to crash (Reset the GPU
> process cause something went horribly wrong when it shouldn't).

Hi Mark and Sean,

I don't know if I fully comprehended the scenario which in my patch
might cause a ChromeOS crash, but this is what I understood:

There is a chance that we pass the atomic check
(DRM_MODE_ATOMIC_TEST_ONLY - TEST) but fails in the atomic page flip
because, after use TEST, the compositor might slightly change the commit
config by adding the cursor. The reason behind that came from the
assumption that adds the cursor in the atomic commit config after the
test is harmless. Is my understand correct? Please, correct me if I'm
wrong.

If the above reasoning is correct, I think the compositor should not
assume anything extra from what it got from the atomic check.

Best Regards,
Siqueira

> > >
> > > Harry
> > >
> > > >       /* Perform the bounds check to ensure the overlay plane cover=
s the primary */
> > > >       if (primary_state->crtc_x < overlay_state->crtc_x ||
> > > >           primary_state->crtc_y < overlay_state->crtc_y ||
> > > >
> > >

--=20
Rodrigo Siqueira
https://siqueira.tech

--qtvryjscdlrkwegi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmCkDjkACgkQWJzP/com
vP9FCRAAl/u/Qfj5ktA+LUbAt+VM6Bd5ncHbIRbRRzj7Mr1SBHVUsrVyx3Yy0XRA
SN8cen2ktCeecN5FcrTNsreIFNhZBNquIPan/RB2d/AZUmRITOpoBBIuQhRTQIZI
F3I2PskWqRd1AH+wRRuMIODB1QMmN/v29vhzP7decA8bW3BlrAH1xQc6PFKBAVK/
Aegh/Mmf9DvzqFtTNDlMz5Tu3dGb70Hqe6IaCwj1UugC3KZwFCsWVYgwaV0344nG
LEk3+O2/hB5V9gFugEkRll0O0GJn0jiS5OagMZMzGBRH6fdy3aeAnxTkRmk8ww0a
oR8VGKmPMO75SrTcvlw6v0PZpVi/Z8qnK3TcCtgQ1jvpxlpTZT2FyjKEzveiS3Az
RjTpeDc1cvUm4ssF+3qYUT6fFoL6dasAE6C2QJ88vKtgOwV96LaumID6NdXpa5vD
7averWFfCrStoYZ036gZl84orgd8f9CVFnd7Hz9FX1pQS6zlTmltXOHEtKZyGo4k
xlVH49gZ1wkG7lEUgJu9bXPIJUIouqthjJ1FYqomMrzCegTABnr80ylFQjxCx594
GsbA4ZQLEmfppa7KhPCoQPJcP7mZ2mx2FQguzya80o8yIUdMVWK09WL0PpQuRG3C
SFlJW3ZNuW1HGcr+ATecL6KrMe/HKX+ZzgMagi/HlsqkyzwYSyo=
=vUwR
-----END PGP SIGNATURE-----

--qtvryjscdlrkwegi--

--===============1710677926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1710677926==--
