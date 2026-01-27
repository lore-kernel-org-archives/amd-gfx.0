Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE58D25920
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 02:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C8E10E13D;
	Tue, 27 Jan 2026 02:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m/qL/t0m";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60B410E0B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 02:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guHqC5AjTaDyr9+EMd9L1etewbnfJDDpBCjbvjq9iZO3XuhzuouvHpsIi+Ukp7yKK+EzEiGdqjGZ2gziOdRevLEpY/lrBntE1TdyvHst+F90D3M11nkkAhjAyJ0PyeC9qjsOKbCwn2Qzy8O6OJJOl7ojPdJ5H2IGexwh5/kvbpDOsOcb+7l+c2rN3AXbdncr6L5poDpjjQfD0/AWK0ZObL1NUi4devQaZ93l2gmJAbYwegrUExfijDPhDjs7/Bb9UrPoJYp7wFvXJBRyweK5NyWGQisvl1hOLa03HeQrkd/ID3L+7R19A5F7lcoXJY0AVZg5EP1Czm8sqQoYaVVQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jUnJnxTS5sluSu6m6nPfIf9umIfaW9WphIbaKIXFIc=;
 b=ki39vW9HWLnNJ/xnvhyyTwrNNAxTrGnKUPrXjT6mIoXAH/gV0tAOLAuZW54V8BfJhs5E/jML+EjMgmCNXjfC6YxcpuqDShadZFNsXGuTF8NLyMoMo6cD/zXFPaYEfwvj2v8+xftlKNdqrLCsq4ZtBskNTypqhxAZqPYVVpce8SvyYy8vWZw4lptJjZF43ebc8jxtVPXNjirLhjIfcfYAImd1KK3ZOzKWNSvmFSmybddjPdzf4T6s0a4S77Nwye075Tr0kTbYO3rAV1eEy/juhSDvsYxSvbLrZqeMGEnSPTxMH/mDVrAT5v05jXRZAg9k2FREn+VbIHMx8GhwwG16mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jUnJnxTS5sluSu6m6nPfIf9umIfaW9WphIbaKIXFIc=;
 b=m/qL/t0mCvr9Xb68Ibdg/MgqHGQ5T9gP7U0Gi3EUGNhWtOWT/9SBSxflvsZsJJrUKptdFARjMi1zjmsGrMtQGT7lDDr53AqQcziFTxX8vdUi1TZIP7ws8vHtG3VL28ihvkMcq3lNC3Rxl476oR78tnbyGmLCysTIDdl+DOLbJvw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 02:44:34 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 02:44:34 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Topic: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Index: AQHci7NcWqicV1uOgU2xzIOvuGM2iLVfRk2wgAC2JICAA8S+YIAAzIiAgADDR1A=
Date: Tue, 27 Jan 2026 02:44:34 +0000
Message-ID: <PH7PR12MB8796E280CE14214C3EB8BEACB090A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260122152501.351937-1-kent.russell@amd.com>
 <PH7PR12MB87965382F541A9E18CB67EF9B094A@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BL1PR12MB589834F3ACE3526E2AA118F28594A@BL1PR12MB5898.namprd12.prod.outlook.com>
 <PH7PR12MB87960E8669B7A76762E9C920B093A@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BL1PR12MB589811A52B70DDDC7A9EBDA18593A@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB589811A52B70DDDC7A9EBDA18593A@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-23T16:58:23.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW3PR12MB4345:EE_
x-ms-office365-filtering-correlation-id: 8cc18094-3ab1-43f2-8a2d-08de5d4e016c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lPGd85AtpQ11mVzwu9/x28jC42yqa9Fl5MxcRUCzkiU3A6Xhg0O9g8Lfed2j?=
 =?us-ascii?Q?5qB+jhfQia3Zx0DnDap2xyAVcKpiKJoHbry89Ha8E4jKNbJURjSPLj9M99GK?=
 =?us-ascii?Q?XhPxbtt+wp+rg5Ju4Hr3OnWyqOIFmoqZBhlVmbjEIpXEkh5epndunYvvNG3C?=
 =?us-ascii?Q?i1lbiZY2TBYUnECDAfjKPll3LMRm5MsNrZrA6k/PpyZaismsFhDSZ1Ah9ePP?=
 =?us-ascii?Q?w/kkzttRBy5rU82LQo5E2TMv2Vs8H2tJFDRojmdhCA+seylV2O76mH46a+rb?=
 =?us-ascii?Q?PY+/k2atgNZN1yMG3FWSG+JZYEQqsylSgZqLlG2Gkt3pgRGFJycTtPTClF7u?=
 =?us-ascii?Q?afN501euoPvyYf3rwh995wc3/CUFPM1bi271dKv4shl9nolCmW2+y/4JmBgq?=
 =?us-ascii?Q?sRCl5jMuSQOWkQZBn4PGwarmp4CiZlO5Vu0mTw3HDiI+JBXFfnVQtTqEo2vE?=
 =?us-ascii?Q?rsxWgMGyMVTBNuAggJR4oniBVUn/KJdMukHTZRk1ho3WAgdsrkCgP39GhwW6?=
 =?us-ascii?Q?HC6EPOcAGnVs6a7L3H/jMwfrfnjU8hBiyPT4pvplSWWxQSvHHrcMSQ8YWcHK?=
 =?us-ascii?Q?delpT8VgNxSKZejkuPCq15SWCgMPk1JyG4jTti6nFIBtU//C0yUMC+qgMr4W?=
 =?us-ascii?Q?8a4Ixq2lFozLb6kTzySfSkMC74pF3eQhUtZ77ADymfFiPn/KpN1IWMD/wgk+?=
 =?us-ascii?Q?AX9KT6P6vME+J9n/ePlBgGJEpu/OhNwn7PuKaCssNWVqL3huT0Dl7M33t+V1?=
 =?us-ascii?Q?m8Uud3dlQWoslvuwfIicieTFbVfJpfR0l74Ahr1ChFK8EpM+ZYK3UKOab8jO?=
 =?us-ascii?Q?SENLTCkol1hYHN5M4RTCxmqxjTLD5GQzsrKPaNHbfTaQTTTh3+AZX9j4QGco?=
 =?us-ascii?Q?Y9YLqYAxPDVUUTB3yio8yafABLCioqLQ9GsBJLNyGXoHWVC2KhhKcmfSytVX?=
 =?us-ascii?Q?Nwd6ZYEN03TtHqEC8/kCTq0d7vyzOrk7eCsarK2fu2iR4qzPUCmpwvatS2K0?=
 =?us-ascii?Q?almKk0OpfoJdX6+dfH3QeKV5ntPNRyzGH+V2BERaWqgm8KsCOSNEyabSITaa?=
 =?us-ascii?Q?MZuvN8Kn4fz/4JplNBr83EZSwABOhi5ShLLShPGSr5TNwXXwqdLV/FggsPOY?=
 =?us-ascii?Q?5QFIUPh22pJx7UgW2lOBuPIncr557miBqHYtfLHyaRC57DwniX8gfuAF4WCO?=
 =?us-ascii?Q?ADCiDQx9kaVPbS0Oh4Sm6vXbb4FpkfVpiekTc/m8j6xDekR4PQJyWlirGGya?=
 =?us-ascii?Q?pguyx4hiilLVYCB0DssvtWVJuJm6XPHOqnrYTpsOXhl/KKlF66OIe7iU5T3s?=
 =?us-ascii?Q?0Edi2RMTc2LWrzZkBqQRmVyYT/ihwaJOSLi25SdM0uqVIa/DE9NtNxDdcmmA?=
 =?us-ascii?Q?wFXx02zLJKxSv/BnVmg43iT/LmjvYcASYyVMOOkZyeA3mltKtcWWp2RIsbAP?=
 =?us-ascii?Q?cJMYdrqNp7lQDsct82VIqBPnJOlOb0riD57EqYAE96ZRh2sPxKrj9tJAc7iK?=
 =?us-ascii?Q?87X+zgjtg5X5SSELyoh3nic3fW8PxG/TtGi9AXxUf9hwmFg4QsoJnIG82+Uf?=
 =?us-ascii?Q?lISZCx3/spqFy+lwStQqPCVbqat7cbgi4CEbSzFRr2GtnawtN8I8TGPCPeve?=
 =?us-ascii?Q?FVGgdDsLiS9WLxm7F30RTuI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fz3herauD3iOjvgVDv0E4v+ehZO27YrJ0JaQkUXn3u0qGzwE9NgEeRb9thq+?=
 =?us-ascii?Q?b6gl3CB2SmlhbdJkWOEVDCNGHitlXS6LnJ6kVdTxP2vcKMMEa9oYJ91URcy2?=
 =?us-ascii?Q?bEJ9Ku2+U7yUCOoGko4Rp5lqkf+jtzzzJ4mbn1Z/1EvjH5MTVxajpr5CcZ96?=
 =?us-ascii?Q?3dfS1ZoQtWcHwhR2qlACs9bL0tsu/Bo3e33Sj7VBslRcxmMO0/S+vlgJJ5ol?=
 =?us-ascii?Q?OuVDLgTnjavcXPMQcEHMA+abCJ8xoBfwaRho66vAOeLOcwbyG9yrMqFkkJaZ?=
 =?us-ascii?Q?vBhntwhMMWxHAc8PKF0o1J+5ysO8dPLwXWOSzV0tdo9d/MEcCUwCt5IYKgCk?=
 =?us-ascii?Q?QOgxsoN8dBiek1PL6b5F3GH+xevLOMxiCGEt7XlYoFNc3m7wcDUbDgCvFBIB?=
 =?us-ascii?Q?EJACWG1I8NTzU/3bnBjQmbBoIdul53QGaDahS5A5cLxf0K6m3EViMCYmpMrz?=
 =?us-ascii?Q?UJOVx+l2c+TyWIKvV5Jne2/WFtM4hFfXX1TEdyKC4KMCfQEbcVJMBlqPub1c?=
 =?us-ascii?Q?fPir6XFXfT0TwocgLNyE8MCGMQr+Dc0T8C4BZsnd+rNvXrohtcZZB07g8ZtJ?=
 =?us-ascii?Q?ouZNGJhZ1qyLeBfS2uGxNn814XjayKCTREPWKAv2eG+y645Ntkd2qp34RfkO?=
 =?us-ascii?Q?6PXbQbGqZ4zQ++Au1lheP8/GStBNI8e0IFuqvAkXDYjUgheggawyeGERK208?=
 =?us-ascii?Q?d+lmdKIe399CSK3s68uKDDDhyEu8yUP0++f6yEN4/wDvbiAHSfr0bHjuVbAQ?=
 =?us-ascii?Q?BbRpiwt5ggECOBY2zgKAe+3qnpjqzssHZaQg46a+gKG21Ii9RthCVhI34vQT?=
 =?us-ascii?Q?HmWDiXKTRgEllPgMEgAe9aKfJA2S/OygLnof8Y+3z2wI4KYaCvZ+Ltya6YTZ?=
 =?us-ascii?Q?m4jMv5o1BXvS/2VNGtiF5ArahWXWQOr/L5Z7nkhFcQi2cPerQ/N3OxCi6GIG?=
 =?us-ascii?Q?vlOmxe+j6gugg4TwhehAVxeBwvELErqD+XY9xj/yr2FgZ+PgRWX53uT4GPar?=
 =?us-ascii?Q?qDFtYVU6RUHak4WkZUUDmaM+X6696xyoojjuWG4D7kYCV/90DvIuurgNq0kL?=
 =?us-ascii?Q?GkO4z7q+Aa1jHNAOgI6eqiSOWtUos8Xc4rDzupzJ034JcMLVf8Zvxm/ReTAf?=
 =?us-ascii?Q?Bit2nthta6UHZ3wSu5yO2+A0VbcTBE/Fy4o7E/OxXUwxJ0YroBQZvab7mE/r?=
 =?us-ascii?Q?SX2g3Ctgt+HSqTSHS5U9crClpt8K1I+8Ybhsk9xQm6yff7NFg8oZfv5GaRkj?=
 =?us-ascii?Q?etlK5hZoIGz5vKK1lUguxBxog72CZZzB/IemkokNgzUQOygL0h/1z0PDzkmZ?=
 =?us-ascii?Q?HKNxSYBrI1sA4Fczxu6NEoWoEidUgII/tsxL/fBv402Zt1BsOOhyiTk/jsQv?=
 =?us-ascii?Q?WB1ljZhlrewciI0AkkzA2Ew4xNjlc5R+Y9HfnlcUFipDB2xme4yzpKw97v34?=
 =?us-ascii?Q?U96180MsHffc8q51KdwCD/RDlfd1y19JGNyeOZko4JO9tTJhu6KfvwTcYPy9?=
 =?us-ascii?Q?wgqD5eEIk1idaqg7rsZFcSEXHwSvbWX0A+qX0wT+vJHcyjezVHeoDXspTMOq?=
 =?us-ascii?Q?lN4ZBZ5vwEU7HXqDIGNJKzzQ1vQVzQyWOi4pKtxDqr3mfUF3TJv7RnJMEOCe?=
 =?us-ascii?Q?ETAVCzs/sjpn+6G7B5HgYZ03qadkK0duMHsycgVotnQy8QZE9P8P5ocpq7x/?=
 =?us-ascii?Q?j829iq8YaEwPEV9XeTA3oaEtRoUBHdoMT8WhNi5Pir7EaTyX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc18094-3ab1-43f2-8a2d-08de5d4e016c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 02:44:34.5318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /y2gZ8jn1Urha9ez1e/agDb2J9rvjqaan0E/MJa3I505XNiqrD/B5TF2JuY8soZ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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

[Public]

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Monday, January 26, 2026 10:47 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
>
> [Public]
>
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Sunday, January 25, 2026 9:40 PM
> > To: Russell, Kent <Kent.Russell@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Russell, Kent <Kent.Russell@amd.com>
> > > Sent: Saturday, January 24, 2026 1:02 AM
> > > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> > > Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> > >
> > > [Public]
> > >
> > > Thanks Tao. This was really just to get some feedback on how to do
> > > this. And if
> > there
> > > were any dependencies. Ideally we want to send out a CPER for the
> > > situation in
> > the
> > > commit message. I can definitely add that as a comment.
> > >
> > > For the 2nd part, I am not sure. The big issue is that systems that
> > > rely on CPERs to know when a GPU is bad will not have a CPER for
> > > this type of situation until they take a new UE. So we want to alert
> > > them every time we load more than the threshold. Would in-band also
> > > benefit from that? Is there a drawback to having
> > both?
> > > I figure more alerts is always better when it comes to unhealthy HW.
> > >
> > >  Kent
> > >
> >
> > [Tao] Hi Kent, can system bootup successfully in this case? If the
> > answer is no, I think in-band CPER is unnecessary, otherwise user may
> > be confused about the inconsistence of in-band and out-of-band cper.
>
> What we were seeing was that after the patches from you and Gangliang, th=
e system
> could initialize amdgpu with a massive number of retirements (previously =
it couldn't
> even init). But it took roughly 10 minutes from modprobe to completion on=
 the node I
> was testing on. For health checks, a 10min init would get the node flagge=
d for
> service, then it would need to be triaged by the service team to figure o=
ut why it took
> so long. The CPER would help here since that way the node would immediate=
ly be
> flagged as RMA, instead of needing to be triaged as to the reason for the=
 slow init.
>
> Again, I am not a CPER/RAS expert. The hope here is that we can just sign=
al to
> OOB that we need to RMA the node, instead of waiting for the next UE to t=
rigger that.
> If in-band would benefit from that too, then great. Because right now, al=
l we see is a
> slow initialization and then we need to dig into dmesg to figure out why.
>
> Hopefully that helps explain the unique situation a bit more clearly.
>
>  Kent

[Tao] Hi Kent, thanks for your explanation, I'm fine with or without inband=
 cper. After comment added, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>
> >
> > > > -----Original Message-----
> > > > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > > > Sent: Friday, January 23, 2026 1:14 AM
> > > > To: Russell, Kent <Kent.Russell@amd.com>;
> > > > amd-gfx@lists.freedesktop.org
> > > > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> > > > <Kent.Russell@amd.com>
> > > > Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> > > >
> > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > >
> > > > > -----Original Message-----
> > > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf
> > > > > Of Kent
> > > > Russell
> > > > > Sent: Thursday, January 22, 2026 11:25 PM
> > > > > To: amd-gfx@lists.freedesktop.org
> > > > > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> > > > > <Kent.Russell@amd.com>
> > > > > Subject: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> > > > >
> > > > > Some older builds weren't sending RMA CPERs when the bad page
> > > > > threshold was exceeded. Newer builds have resolved this, but
> > > > > there could be systems out there with bad page numbers higher
> > > > > than the threshold, that haven't sent out an RMA CPER. To be
> > > > > thorough and safe, send an RMA CPER when we load the table, if
> > > > the
> > > > > threshold is met or exceeded, instead of waiting for the next UE
> > > > > to trigger the
> > > > CPER.
> > > > >
> > > > > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > > > index 64dd7a81bff5..469d04a39d7d 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > > > > @@ -1712,6 +1712,10 @@ int amdgpu_ras_eeprom_check(struct
> > > > > amdgpu_ras_eeprom_control *control)
> > > > >                       dev_warn(adev->dev, "RAS records:%u
> > > > > exceeds 90%% of threshold:%d",
> > > > >                                       control->ras_num_bad_pages,
> > > > >
> > > > > ras->bad_page_cnt_threshold);
> > > > > +             if (amdgpu_bad_page_threshold !=3D 0 &&
> > > > > +                     control->ras_num_bad_pages >=3D ras-
> > > > > >bad_page_cnt_threshold)
> > > > > +                     amdgpu_dpm_send_rma_reason(adev);
> > > > > +
> > > >
> > > > [Tao]: 1. Better to add comment to describe this special case;
> > > >
> > > > 2. Do we need to trigger in-band cper as well? Like:
> > > >
> > > > if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
> > > >     amdgpu_cper_generate_bp_threshold_record(adev))
> > > >         dev_warn(adev->dev, "fail to generate bad page threshold
> > > > cper records\n");
> > > >
> > > > >       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
> > > > >                  amdgpu_bad_page_threshold !=3D 0) {
> > > > >               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> > > > > --
> > > > > 2.43.0
> > > >
> > >
> >
>

