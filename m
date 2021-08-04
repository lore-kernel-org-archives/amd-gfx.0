Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5A5C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 06:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF7960F25
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 06:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FF7960F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2629089C93;
	Wed,  4 Aug 2021 06:16:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D084889C93
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 06:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J74nfSQlN/mx6mL8/dxagmzBGXBspy6H6U8OPOMgQ1/3CFaw9URWLfo0Wm7eoX/PyWZuQBu/JdEps9MrvNfR4AgmxwgBnmXsPkWOwEFFKtIE/0WcTZn0HwCWC3y4HMAbviRLsKP35vT4QzgU4XGxdUhLKGnP9Ord+kg9DK28giE23lSWQ8+HJQS7sdmkSdd7s/MEcoTe89AcN7KmQzrcUqfn+2MU6oOxXEDf70C1hstxMn4TsTd/Zg3hlost16TOjV99A6u2l3Oz5Fr6PZRt+6dbZ99oYRb2qvTiAGxHXfNCw+Ty08X8dgZpDk7OTg93SU9y06cg02khvj4fd/Sb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwu1gEG9km6B64ESHRc43ST3ScZBJWBPVHonWgFPxlg=;
 b=IPLFdKecD1xMFo9Ozf2jo+lZv1dZted9S59xryOM2nhvblnKr+g560tHkoilu+mIxWunICV63DqlmYzH2QB+T7a+0k6Gt1S8Vzw5tlpZgkEagAm3rU9xzjFAFTQdTtsydLkeLONIalHGbxaSD53QOjpQgMCFIp/xeFoDC7JK3gJ+l7eBMZJxqLeFG79I4nczvx9aGLryeloXgBUOET5dL//4MoLI8K8T+GBDdX7CC2fbOz+TGtydmM5PLst8nVPEPbT6bDeDxORp5mjbFmM/qH1P6uYI4U1OHgAovj/WAOv65UWOMxqbkfchMY1V72ukAGotwuYFd/2wxNYq86hCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwu1gEG9km6B64ESHRc43ST3ScZBJWBPVHonWgFPxlg=;
 b=hzPvAIQevquH0BFWZ84uSqtFRRjAox5Mu+IOxsmR+fj16OfIooQVBfnvYLekzfp9Fp1jRXk8DENYJWyyPnmKnIewcBoNY+HGVWTYWhjzbXFSNQ9fMsWuMgBUKDtC+11wnBWpXqjnXmNG80sKj5iCTNBuKiBi2Gl4PieNFB/WvSA=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Wed, 4 Aug 2021 06:16:35 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 06:16:35 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Topic: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access
Thread-Index: AdeITLg7attLKh5xSlmEVfidPAvHswAIhHnwAABMeRIAHFsMcAAAM8HAAAVo/6A=
Date: Wed, 4 Aug 2021 06:16:35 +0000
Message-ID: <DM5PR12MB2469E0C8DA284DDA0E1D07C4F1F19@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <BN9PR12MB52265FFACD0557EC17C4FAE6FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>,
 <DM5PR12MB24697166AD67A6E7A60718AAF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
 <BN9PR12MB522659C72ED024CE62496CFDFBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
 <BN9PR12MB52268D6CCE55D9EF41DF7ABDFBF19@BN9PR12MB5226.namprd12.prod.outlook.com>
 <DM5PR12MB24692417404B35DAE5A72A12F1F19@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24692417404B35DAE5A72A12F1F19@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-04T06:16:30Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e70ae0c-155e-4dd8-4445-08d9570f6952
x-ms-traffictypediagnostic: DM5PR1201MB0028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0028CEB4E72E98E8D63087F3F1F19@DM5PR1201MB0028.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LGv986FyYrnusq8/nLhd3kWE6lDAPWxq/gqZYq59CkuUtB1NgX0jwnR17ReBoUNYfADQKPBRJNZyz6tmQi9dKjaygY21b4pzxZLLMfeU6TStIIlpBbDmmUITlJ0TMJnSSVbBrCpfTSsJdtpX2l+GBVL5T6pTm6iO1oqkMnt7tBQFT+9TbWIuo3QcZlxW2TOoxXggC46dEKHBkTuX2kXsc5hp4saTJ/ym5IYYdbgZnG/p1Xb4tLwypFSyf1iDMnp31ZCH5h3qXqLecBpMNSolE3SwAO2COQSs6ZkBreTN1aA4QS2NkNCV9jNuGBAaIRXDcEv+5mOHbNFvRwzAWyXuZUodnY0ibWFQgFmuzxhCc8U7qZDTHfme/nL0vqqQYkTgLIsA6e2rNtnGK4iHqYpmVNRks5spkeVE591V3Nx3zeQLvS6D5DGWrOgGKR1wS1poEDsiBbDa3QDN2o87lse94Sn22iW+HOqI/3ZrYKkJDsTtDoDCoSNZLTQp8FLF9fwXeJjbt2TPOv3WUTVKawEj6CkCrF4PRDv9GTNJsSsyRP8UAetWV+WdKKOzX4YIReH+DaiRMXQArvKHzHyqlnloi/ou01oyP8HoavCb2tpmfNHxb9q+zfr/ps3cd9q59YBWGv3rSk29MsJw7b1U0vwH/UotuJUMdQd6gr9RJtDuMPf2HSZMoY9orXpJxgUqZjU03sgGMxE6MBPea6h3mqTX0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(26005)(478600001)(186003)(122000001)(7696005)(38100700002)(53546011)(6506007)(71200400001)(52536014)(9686003)(8936002)(8676002)(5660300002)(38070700005)(55016002)(54906003)(2906002)(316002)(110136005)(4326008)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(33656002)(2940100002)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mvRWqwJGqqTLAMkMNfDm6HeWl0QZtQLXMwfqYZ90YvaoRWVEUVj/wnRHtiqH?=
 =?us-ascii?Q?d/2nj6PmfBAyajs22i/ydUJGVHnPOoUQ8A0tw3zraxuyG4tKXnTQPRgh64a/?=
 =?us-ascii?Q?G1rwlP/yXCWHy0f9V5wBmIhgU9MJJe3C+RjQArs0qlEa7aENuvChCU8aUZe8?=
 =?us-ascii?Q?rBPMvNWXa0gcxXEPI2wJx4mP1cYd5XgZsmZbipd2SIprzn9jnghu8t7RVypH?=
 =?us-ascii?Q?XHycQYBP/oFbudcOljcuKTHk+CCPMTfEtYVXXZ2Q0HvEckoM5P157hluIzQu?=
 =?us-ascii?Q?phXyM2rygGQ/z2pstS56Mh083lfkzPjtc5dDNsl+RdbE/A/CC5yvF+4VbNWe?=
 =?us-ascii?Q?8zDaCrS2YW/OKulzHEtJnUVILqLHgKPcXo7Syc/7+JcVvGnUbM7zI3I+Toeb?=
 =?us-ascii?Q?c1oVWbM5UMkZnoYKd2m8dw3WOCdWrnOEgTyLaULpgxf7PM99Z0yLrUbDHLvM?=
 =?us-ascii?Q?UStEiz2HleMCrJjGSFFt3cRsrgQWgyxPx6lNmx558wYRJe9E+8j7LHg+5EjR?=
 =?us-ascii?Q?yEuyn0gr/tPFp9nGQaXb6Qc4v4n+Y5UibHl/mGdW/Iw5y9ijNE7COkfj3xnT?=
 =?us-ascii?Q?dqG/8SzBJtUfm8po1YWWNiNklS6GACmwyG0AlFwNu3cpWoYuCjzQqQuNOH2v?=
 =?us-ascii?Q?xn3q+oOZMjMB5a5fS80IV4AooTKqHsXoksODxUWdAVeamskIlcL+cbXxQe0t?=
 =?us-ascii?Q?knaIpjpUUoNtNPSCMjFzxRrrwrLEAHadRiWVSXFqOCznB/s6lLE27aH8Ozy5?=
 =?us-ascii?Q?thEiYlVI6O8HurG8sTM4ZWEzxfPNwxHiA51IzHVzaPbUSKNrDQr7zw5mvWJz?=
 =?us-ascii?Q?8J06zHxrTRVFHPLZe9o16nKYNWbvZRHjlFOsTIQv56tCxzQWmi4x8zyLl4Nt?=
 =?us-ascii?Q?eCpal7IZL7FapXz/vSgyS68YO8Peh8T+Tm7/izbtKFerYMSBFEjseTfBG2u7?=
 =?us-ascii?Q?xBHHreG3FqmI4Vuxcq9rjQybY2wNOiQ0eKHXeOPj1jVqTT0GoTncVZixTUJr?=
 =?us-ascii?Q?Pa6i7osEOo97tL+gRN3un17vrPZvSpp/zQICSG87h6SS5xDk5eg6yaNZUcJ9?=
 =?us-ascii?Q?PzN0M+zFx59fC8dXjqH+JwNbhNkWILz6AIjG+IKyoGiavU7Ga0dKCPf1gvXC?=
 =?us-ascii?Q?z1aiYpDwXn4VUytfukZOqbP41pypCnWEhWxaCE9pO74OJBCK3dfOBll2UL4W?=
 =?us-ascii?Q?VibC9dJZeVVNB0A37wQiDV7WK9c06ZSZWf5Cv1vi7/GiFxDld2BnjMJzftF2?=
 =?us-ascii?Q?PGWlxUMtHMzhp2BNwaFsYMd5xLVdN37ekpaer40EMTe8tdry1SBeKCRwHcI6?=
 =?us-ascii?Q?xPGgWI3QH1pE8wvAwikxmZjm?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB2469E0C8DA284DDA0E1D07C4F1F19DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e70ae0c-155e-4dd8-4445-08d9570f6952
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 06:16:35.1221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idZjrLPuMzC5h7c9Xg5DqdrR0yQPy1j3L850gyRjq8yXND7x4NJwVB7oltPPaeX9g+9MaJtog57yFjRFNl7k2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
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

--_000_DM5PR12MB2469E0C8DA284DDA0E1D07C4F1F19DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Sorry for missing RB.

This patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Gu=
chun
Sent: Wednesday, August 4, 2021 11:40 AM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss


[Public]

Thanks John. As in the same context, it's meaningless that two mutex target=
 almost the same thing.

Regards,
Guchun

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Wednesday, August 4, 2021 11:34 AM
To: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss


[Public]

@Chen, Guchun<mailto:Guchun.Chen@amd.com>,
Based off your feedback I double checked the code, and I changed my opinion=
 about it, I think it's better just to reuse the original mutex for now. I'=
ve submitted an updated patch for review

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, August 3, 2021 10:07 PM
To: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss

Hello Guchun,

In most of those cases you are right it is redundant, the reason i kept the=
m separate for now is to resolve this bug while also keeping those interfac=
es modular, and not affecting the psp submit sequence yet. We are planning =
a bigger change to that source to remove alot of the duplicate code regardi=
ng the cmd buffer prepare/submit flow and will probably go back down to one=
 mutex there.

Thank you,
John Clements

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Tuesday, August 3, 2021 9:58 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: added synchronization for psp cmd buf acce=
ss


[Public]



Before calling into psp_cmd_submit_buf, a mutex psp->cmd_buf_mutex is there=
, and after entering psp_cmd_submit_buf, there is another mutex psp->mutex,=
 is it a bit redundant?



Regards,

Guchun



From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, August 3, 2021 5:50 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; L=
i, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Lazar, Lijo <Li=
jo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Chen, Guchun <Guchun.Chen@amd=
.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH] drm/amdgpu: added synchronization for psp cmd buf access



[AMD Official Use Only]



Submitting patch to synchronize access to psp cmd submission memory to reso=
lve potential race conditions.

--_000_DM5PR12MB2469E0C8DA284DDA0E1D07C4F1F19DM5PR12MB2469namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsipheader23c54b6f, li.xmsipheader23c54b6f, div.xmsipheader23c54b6f
	{mso-style-name:x_msipheader23c54b6f;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheadera4477989, li.xmsipheadera4477989, div.xmsipheadera4477989
	{mso-style-name:x_msipheadera4477989;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sorry for missing RB.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This patch is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;=
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Chen, Guchun<br>
<b>Sent:</b> Wednesday, August 4, 2021 11:40 AM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks John. As in the same context, it&#8217;s mean=
ingless that two mutex target almost the same thing.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, August 4, 2021 11:34 AM<br>
<b>To:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><a id=3D"OWAAM657D9489ADBF421697FD567A7A47E1AE" href=
=3D"mailto:Guchun.Chen@amd.com"><span style=3D"font-family:&quot;Calibri&qu=
ot;,sans-serif;text-decoration:none">@Chen, Guchun</span></a>,<o:p></o:p></=
p>
<p class=3D"MsoNormal">Based off your feedback I double checked the code, a=
nd I changed my opinion about it, I think it&#8217;s better just to reuse t=
he original mutex for now. I&#8217;ve submitted an updated patch for review=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, August 3, 2021 10:07 PM<br>
<b>To:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">Hello Guchun,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">In most of those cases you are right it is redundant, t=
he reason i kept them separate for now is to resolve this bug while also ke=
eping those interfaces modular, and not
 affecting the psp submit sequence yet. We are planning a bigger change to =
that source to remove alot of the duplicate code regarding the cmd buffer p=
repare/submit flow and will probably go back down to one mutex there.<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">Thank you,
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">John Clements<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.=
com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, August 3, 2021 9:58 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added synchronization for psp cmd b=
uf access</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsipheader23c54b6f"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Before calling into psp_cmd_submit_buf, a mutex psp=
-&gt;cmd_buf_mutex is there, and after entering psp_cmd_submit_buf, there i=
s another mutex psp-&gt;mutex, is it a bit redundant?<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Regards,<o:p></o:p></p>
<p class=3D"xmsonormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:J=
ohn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, August 3, 2021 5:50 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd=
.com">Candice.Li@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.La=
zar@amd.com">Lijo.Lazar@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto=
:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: added synchronization for psp cmd buf a=
ccess<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsipheadera4477989"><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]</span><o=
:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Submitting patch to synchronize access to psp cmd s=
ubmission memory to resolve potential race conditions.<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB2469E0C8DA284DDA0E1D07C4F1F19DM5PR12MB2469namp_--
