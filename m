Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0774FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818D310E676;
	Wed, 19 Jan 2022 22:23:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA16D10EEFD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEiG3/dqbnizQwrQkcePV+2Vki2/2AAjxxrbupDPfZnWMCjmSCTsc+66N3neZKGDMpy0EEXhOfoPTaep28Ql1GyxjY0H8svzEx/VgaLbwnVDxUnADxY1KG4yUG7+mpkqSSfKqzIh7gP9H1pZqFrfeV3Yk9OHnyXZ6kxsJDU65IIDiHqTbCgZmbhSAJavN7X3V1E7ttOsR/2ao/3ej9k6ednFlHlNjdsKkWtG3IgkeCYuGChCjKfi/ktiRvxc3h+zxfCqT0C1MpmeAGSE1o0tNw2gfFi31AjNfU+MhO5wvZJoUmre4Bn0ZkSX8DViCRSSuvdLpAlqjdlTVscJGm65Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDzoJBwbeRsApxrNNhcekCZ7TAP3AdRVfD/1584UGgU=;
 b=jUEhhYL1lB4wR25BdlTVJL7rAMubYqH3id77mMwTk7+G7857m4xfz+ecR9QYS2dfh/GqeKTtIM+XWF/bRS2fTtL2kwejoT37eDODAFZDVG6bf0yejtj6CkWqAFQIvnNrDxph7SjP7fPr5qK/7eirgrxp8KNYL+FSyuNJ/J9VBjqCW+WRiIHEBvpqZ0QxWPEIdthJAOuqOHaKTS5pisEsjZNUrQ2/hCGskzwykPb2lHNK+Ll8t3rV/fPEZkRZywpEhuGo3dNG2MbwHmEX4hCHD26s4JSVFd+0zoEyC7U7ENKVkHpQ66U33fu8vxVq0kQ/Yr76cfH0LiaVXQI3D0Pmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDzoJBwbeRsApxrNNhcekCZ7TAP3AdRVfD/1584UGgU=;
 b=O3Ue1aCf1VgcBjhKRMLm6ICwoqWj5k15NYPMZ4X21JeHADuGp+zobcm2wEWLuZbVwzkfnxKuTz+5cS/TDfPWQp5v2DDIt0mBOnUCw7tJvRQgAehhafGAtIQGh2EMbYf6ht/VkFVKUX3BrR5FslJPzAXCLq8ccKFe0AeCWzFPXvk=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by CY4PR12MB1448.namprd12.prod.outlook.com (2603:10b6:910:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 22:23:49 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 22:23:49 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Shorten delay time to 1us while
 resetting FIFO
Thread-Topic: [PATCH] drm/amd/display: Shorten delay time to 1us while
 resetting FIFO
Thread-Index: AdgNgnXaHjkBOvHIRT23qnPD9UzUcQAALKxg
Date: Wed, 19 Jan 2022 22:23:48 +0000
Message-ID: <DM4PR12MB5214DD41D3E2E2271F732CBF9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
References: <DM4PR12MB521400998515602D0F8AA6EA9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB521400998515602D0F8AA6EA9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5d442e48-a6bb-4d26-b007-f22afc8456bb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-19T22:23:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7199bc0d-3903-4e42-7d02-08d9db9a5d86
x-ms-traffictypediagnostic: CY4PR12MB1448:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1448F4071C17C1083EA3045E9E599@CY4PR12MB1448.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8O2LWtFLXI+1yAKQB4DsukjaisvDdJB1rIEfNws7K8wjYeEdEqQXX2HIDhagQ+bQyhASEuXXb1scaWgaNlJ8DqUN/Qsa52yB1IpEmuB3z97TAuv71MGQozc3nw+1hcgHcq7zbAXmYkugvRUwiRMxu3CDxApyRMMdYFo3gw4HQK0TanDUHt7zVGoLijbgvBi/UAzQwb9zMAO9aJ9RZJnT+wdxKIEoNhFOH+5URIygEqd0W3zgA2pTLmwsFOofzCc4qQXU9/lmUH5Xcn2rhctN5AWPEnT7fsVs1FIpr61xXcnB4yy2qmQVFIuxR8lGOMkqcU14rueIq5FNrdpazc/fjV/wPM3yDBGohIIWMHvg26Z8DaXrxGqrfMjZIk9oKn0OLYss/LHQ5PPQomRbvOkTTdQyBuVy6yEhaTOzBBMBBxD+Qf7Ja0GboYPW6cxQLAnx6xQiJc29853HYKOMfm8UKtFRWqJqoNCZ1iqRhzfKqRIzu8c5jjozUcheu8ABIbMl/GZxEAjKTp6silusY0U5mJ5JVtCmZbu5CTsfjZFc0lMDrDcIMgYFoZE19FwtpZ8lsxW69YYDlWsz7EmRZ2wIrtJC+27P42QeIzDDaAFIn9lwhca9Sw5IhJvxofmSPCPBH/ybw5GusfMTSuSZeJueUgAGJz90oUbLAGZdaP3q+ag/GRq/JtmFDiDx0LBuBq3WihwXWFasP8ma7DN3nuK7Sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(316002)(38070700005)(8676002)(110136005)(54906003)(66556008)(52536014)(76116006)(66446008)(4326008)(64756008)(66946007)(2906002)(33656002)(53546011)(8936002)(6506007)(186003)(9686003)(5660300002)(71200400001)(86362001)(38100700002)(7696005)(55016003)(2940100002)(83380400001)(122000001)(508600001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6uLXEaqR3g0WADIzOhMH6oC5TYT4v/zfDJoYZKi41dMk65d6PFE0pkKuVjzx?=
 =?us-ascii?Q?yV1OCWOifLE+4TPGt03h0po9y9wcGQ58bC++nBojcE0cG1n0DlnD8ZycTfq3?=
 =?us-ascii?Q?+QD1hv5k1auDYYfgCsfO4HqyaBIdatKwrWk33jleb5GpRz+wz+joYKG1rHZQ?=
 =?us-ascii?Q?lAtZL/m6UAv6C7J0q7xWBTDwjoul7tVozU4rND908+/q/4q1srJN2TiseKb9?=
 =?us-ascii?Q?ObzKSPvE4dZhnyYUC4SIevC4fWA2UBwzdwqEDoIxkI/8Jq9wGlIQlyoHyaQT?=
 =?us-ascii?Q?gEyAzyLrmkU9yp8LlESt/FsQEE2xARKihPxJDGVQ5STWVBYRYPurTRaHsTFa?=
 =?us-ascii?Q?WHLPATz10Q1RyupnbvI5svZdcw238AQzx3/9pBP8gYruNHlg8wm0Rieyo8lN?=
 =?us-ascii?Q?W1MOBj7riO5H7qZt6ioGEP2LxxloUKoGlJDiXc0KrVXork/lBfzFgUELH6PN?=
 =?us-ascii?Q?O1UmZbtT8OYA7D+1Vsw7/NB+Uhl9OTKVg9/DvuoerMKnPpZ3atMQ7jP02lw2?=
 =?us-ascii?Q?bXFhdR/8Sv20JD3XfircALaPaHlM/EGIdT3NT27UOB8S+VahPICla59OT/Su?=
 =?us-ascii?Q?VV+Syx18PA56OWwPk8c6SRqFBw7rnr1cDgRNLC0jamBdcB2fCqDuooXQaTWb?=
 =?us-ascii?Q?8gCKbE/IlHq1iRp6zjqqGSYeBtUbp59l124wghlqjaY9EncyUqEYmi+/lEOI?=
 =?us-ascii?Q?g3r8yhVRq2r4IRR2CGjLVJKNOqdnYptQicydROLEEQ9gLPgs3y39BWrNbA63?=
 =?us-ascii?Q?p+DtQ/dSVgwK45PxnAoW6FHYU3O7wHMK4Ic+0RJ6iNMxpChUHUVb67XnB9BF?=
 =?us-ascii?Q?wwAGWEo96sU+YL9kfs02ExWJEccgSX8ptxhNLuRBEBOkShqJa0py3k7pWH7L?=
 =?us-ascii?Q?WrKhYVF478tvrJ1pdw5PzMP4B/pH1cPImH/P9tRNc0aLebIPRoLOVNrLf+Dd?=
 =?us-ascii?Q?Jh9/vcdci28VXiXKETBdKYGDe2mOQC5mFszkaEYrX8E916omVutIijAZHEiz?=
 =?us-ascii?Q?qDKgqGVbgLRcaxadVhrCe29KIWJrFmBj5mookz7N6LCJoX2pg2GLQTIKItI3?=
 =?us-ascii?Q?6folS8t782XyetyQ62FM/RSLD1FlaRm/cLCForr+cmZb5mJb5fEU5kIGY/Hv?=
 =?us-ascii?Q?ZD4tkc7o6wDkaGbpc+MmcmxBww6e2+jumXp3LYk/+445mlAYnFqj+nfHD8cF?=
 =?us-ascii?Q?hNHYtLIC9sdCTH7DKarNQU9+K1CEjNa7tp8mk1jPJuM3Dugs9MGPf2hOJyau?=
 =?us-ascii?Q?BAVEkDcSu5ZgCd5MnFkyNJNVCtGOkLnV9wORsVf+xw4+KoeDszJz33BVmjHc?=
 =?us-ascii?Q?Dgq+5lcv3mYO1qcxiZXurPh6+uoeUl9T/gpfGKliKtpSqQmcNCtJ+oUC5Cu1?=
 =?us-ascii?Q?abWYK0IisahpNBGUXpOGnVaxot5pJZfDtdiUfy7VXOIqB4VURPDtn9MT/s8c?=
 =?us-ascii?Q?F8pA0x0blHAKGa175I+M53IbGeTUEQsrUdlYcWfr0S+qHVnXOu7BvNFzxcdN?=
 =?us-ascii?Q?Kc2uiJFExsL4K8PRgQUncisAQqb99H4VE5kQ3HFyS8fqBrW4gsYcIciQkkVF?=
 =?us-ascii?Q?wcmZnMroE+hXzAvulaY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7199bc0d-3903-4e42-7d02-08d9db9a5d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 22:23:48.8302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRGoRaDgzbR4Qujan2IVQ0tEXaFM5L35delYICdxEYDzaq+sxD54kr3Tr2J3u5zZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1448
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Apologize for sending out the patch with the wrong sensitivity a few second=
s ago. I've updated sensitivity policy to "Public" here.

Thanks,
Zhan

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Z=
han
> Sent: 2022/January/19, Wednesday 5:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Charlene <Charlene.Liu@amd.com>; Kotarac, Pavle
> <Pavle.Kotarac@amd.com>; Pierre-Loup Griffais <pgriffais@valvesoftware.co=
m>;
> Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Cornij, Nikola
> <Nikola.Cornij@amd.com>
> Subject: [PATCH] drm/amd/display: Shorten delay time to 1us while resetti=
ng FIFO
>
> [Why]
> Current FIFO reset delay for dcn10 is 100us, which is too long and will f=
ail atomic
> flip. As a result, there will be no display on boot.
>
> [How]
> Shorten delay time to 1us. This also aligns with FIFO reset delay on othe=
r ASICs.
>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> index bf4436d7aaab..2077c22befa5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> @@ -909,7 +909,7 @@ void enc1_stream_encoder_reset_fifo(
>
>         /* set DIG_START to 0x1 to reset FIFO */
>         REG_UPDATE(DIG_FE_CNTL, DIG_START, 1);
> -       udelay(100);
> +       udelay(1);
>
>         /* write 0 to take the FIFO out of reset */
>         REG_UPDATE(DIG_FE_CNTL, DIG_START, 0);
> --
> 2.25.1
