Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55E606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h8L3z00Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEED210FC82;
	Wed, 11 Nov 2026 16:25:22 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E9510FC82
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcBCGsMfozHhHaDWj52PtNK/wVPH3uL930RRMEpGVuzyFSaXD5VS7piDtarblDlZcbH/IVmiWO623Qz54aTicpfzqGhYjNsOCkGbybQQf3cET47U0DR2PJpTr0SrqlD4/roxo0aXzAouvmSNJ3yIF3Q7BM442pQehU8tL53UO4dQDl795QknYZN2qjgBs9dAxya9FQJ6panar9LvOcboud2UZaHOuM7kW9QxPXp3TyywxP3rOruxtMkni7ck9fkUzi5gTdnFl8b4ESHvtTwNa4fMAvHQfWZu7bdBDq1+wyQx+dpINh3IvPE0WN6CNwQ+rIxZe7azarn3loBA0ofgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+z4nd9qQ0iMp7JKMqS4X3TtPZm1M+rNEyVbQO7QWLs=;
 b=MtMrh3nxoBKeh7oiigCiHzMGk1fkUHOJb8sExrR5UuxUcaQL6ADa4zPuCf4DWnzsYO99sTqQ6NhYN/d4R4AuYiSjXkATDlP3YBEgwqp8YNRh9ii1iKibtmRR1ZI7qkMQa1s3csxhmEEILRwb00WMc8pgpWENE91XP5bc39KHGYbEDDnLydZOknM9Bnxnw3dpJz9InVC+w+6sgG0TaF9xNsGXM/zAGLkEHzCMERTIMqJ5pqsSvPU4MOGdVTwp8JGdIvKoQZrodg0jloPM6AynaQxK7MzidcwqQwve0+2bezTovWkNfnK5yjfQt7pdwKrmlvZPppXfak9sFMKSmNx+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+z4nd9qQ0iMp7JKMqS4X3TtPZm1M+rNEyVbQO7QWLs=;
 b=h8L3z00ZTSD8OvA+MWfLpQpBIeym0NLYCDDGLGU0lEwBWq3H+CqgxulyHG+VZltCdp3WtkzrBUqEHAhANDOH5AvXeKmrPkqMqoZgrSG1VZmJ7KzipOqZkXnGTn7BOSHCimX+8MiemyUOF//eRiZujUe02AwTOyBIGNEdXK3UGGQ=
Received: from PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:25:11 +0000
Received: from PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069]) by PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069%4]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 16:25:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kazlauskas, 
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Rodrigo.Siqueira@amd.com"
 <Rodrigo.Siqueira@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, Wang
 Jiang <jiangwang@kylinos.cn>
Subject: RE: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on DCE
Thread-Topic: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on DCE
Thread-Index: AQHdbQToOOTaBc4iQUe5amwWOc+oOrcfz96AgAlIOXA=
Date: Wed, 11 Nov 2026 16:25:10 +0000
Message-ID: <PH7PR12MB68126E767A5D04C4948DA93BF7712@PH7PR12MB6812.namprd12.prod.outlook.com>
References: None<20261105090543.930342-1-jiangwang@kylinos.cn>
 <2026-11-05-1-daily-reply-0008-dce-post-update@kernel.org>
In-Reply-To: <2026-11-05-1-daily-reply-0008-dce-post-update@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-11T16:24:10.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6812:EE_|LV2PR12MB5824:EE_
x-ms-office365-filtering-correlation-id: 8d4992e7-a071-4bcc-aa14-08df40105b92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|38070700021|56012099006|4143699003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261102123227099003|261021121427099003|261021135927099003|11063799006|10067099003;
x-microsoft-antispam-message-info: COp6BI4zGQaOId/IKG4KZZGHaTamhUXteIdEi6PUduLFzfOTINZhue/pXi30DYxfq0ysyLBLLh0f7ebkaZ6kgXFA5GGmomVbjCwgKCKH5Cp0vXu7WrH8nr23gwt7mUKpWjEaqH/lX390Q1KXtwhLks0jNv7bBVI7MdSa0cHP/2S9M/LTJ+UyQNkhlttBBkN/cA6p00A5eHa+y/SSnFjJUfPiF1w0N7TUocM/zb2dXUjQ1j2O+R3Ve0fSOu+oBwZKCOcObZKbgaAZh0BrA4Zoh8g+puNqdJRAh+b9jkmHUVPmE+HXZt1m2d9hJUugAtWyChKknpakqod45R/94oJHOrJ3HXJd00Qv36+ypRR4yfy5BAz6GV8hNnGLAeAb1uTSMGMtMtB4Bq8pQ2UhHa1NOakOtRQLTqgp69GK15Qvg8Ni4T/TLPBTfN81tPgsnL0ArMglyO8G0nZBcg37c7jdycPsTUlftxlbEHLmoX59sO8CAgQVYBT7troTOkJRsFIMlnKckts0dJJK52AixUJE+yqtY5LJueyi/1TK+znJN8RfD9+5F/Sm4wYBd4zR8qxA8GsWKQ4fBuGW9GDPbUfYr5W9s68pbr2JCjhHgwWFl2wCAEv6fH2BOLJtlRvqjhNPum+kUe5LS8Wtdy7wK62RQUQ3acHHLWAuIMhhP0BFFZaQ1BtYO9sUPG39tLawUg9EvLUVLCVHEVxgeq1hzu7r1nqABrNeKvlSdXm/YN+G5IM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021135927099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+wGaqXHdKw9My57HXFXyAb+OBbaoHs7TIsoxE45XIfsErCir1fzCHYjsBCDv?=
 =?us-ascii?Q?+dmFmZ6mAL3wBeO7v9XbgncgJizGHBcUFxoGU+GYRNgb7ABzWCgBsg3c6UDU?=
 =?us-ascii?Q?lzPblUO/Y5KxNL21aWI9dB2QRVli21eg62c94gPI0jjQJj4B6H8cKJnLKXwG?=
 =?us-ascii?Q?C16Sf9SaSOHAUizN/y31Ml1DbkWLf24XvKlw3brFuVu0MAjDGn0VHwjqch5e?=
 =?us-ascii?Q?mG7zze7v1+5kSTTTGPf9JDRvTlN9EFFHrsTTDQyxwShVtUIsoBd5OWa39E2u?=
 =?us-ascii?Q?jbsNNPKoau7/X7QC5ip5LPUItlqhV5sSOxjOOto4bCcfFYnuhjmscOEAARPt?=
 =?us-ascii?Q?OQTaUNtBe7PJpU0m/nIqkDgnZXIAqfDBQtWqkQ0KH25P2YBIw+213kEg6scR?=
 =?us-ascii?Q?7FSbZg9QIuQMthgIYshjGwUWtfigJI7bp6v+Eo7rfxdISwbQVDNaD2of/CHP?=
 =?us-ascii?Q?+G3tmXHnVIsrUTvZCkg3StSC67V+/kf5KUvoFSzoWo7Ufh/EDYVNfNkTyNT9?=
 =?us-ascii?Q?YdnN9drv4VVKnKKs6J9UT4zRjKF3y7VT1yXroOMq7tymzD0TslkdYcp1gJYB?=
 =?us-ascii?Q?/4E59CvjidgVBPkmPG6lioQnYjYKxa6aEE9EwwhhYrcFXEE5yfAUTpD5EPm/?=
 =?us-ascii?Q?gQK1VwJ0F90k1s93lCKeSgsIVu0i4pcdPlknB7M4SBQVLbJGmMNeb1gwoyR2?=
 =?us-ascii?Q?a4phkS15HoYfRNaQUIc1CPDXJDr/10xAg7QPmXtr1rrIr+OSq3dGmOnwHiFI?=
 =?us-ascii?Q?Wq7/8728HxeJ3/XCmfx9MzmEHR+K2XuCDUmlNFpZmduCCHDo5/9mAuMfTSS4?=
 =?us-ascii?Q?GqyAkbkftmiEz3UxQzECg12EHo1Nw3EfLDhbTsWaZY6/2qTb29B0FMsy6ZGS?=
 =?us-ascii?Q?G8+aQ1dGDQTiDveTsdgcQuL/fMuPyuNvdFA9NPIneyK45/cyMWZ2oG6xANxm?=
 =?us-ascii?Q?tSkaXOE9jHZuNSwMjuNwk32+OF7HWkOjFnaeG0LH+Nw8d92mvlHfWjWKmmNB?=
 =?us-ascii?Q?SjCQ7JcQxl6xV7mt5HeFIbe3bP2lcLxY3SMBWd8WxLUFPMeEcZb7gFFzST04?=
 =?us-ascii?Q?iGUxqsWfG4DURgRUSLxn7h/8V2Q984nDLaDQSGKvkegMEZxPTA4KQlqOo4th?=
 =?us-ascii?Q?0CrqJF65hDui1m0KTe6zMTN6QBVo5oaV5jd79VIAfJFBgtYcP7YBNEQ6Faxz?=
 =?us-ascii?Q?C90AMU9/UAnfcDqgEF5N+DtuHSpk36WA1OjTQTjOAbnZ72NOeSASSUTHsZiy?=
 =?us-ascii?Q?9tHLASp5trdPqBxoxwpMtDB0O9nek8n+ysNrqgsLjZCUPd+nQ9t7ByaAtjU8?=
 =?us-ascii?Q?1Umu+eKc3WlGaWTkAwuFp1wq6sBCNz5ki7NLF27YcLEkTRmEhkzGPx0ex9av?=
 =?us-ascii?Q?Y0pRBOWZ6RtHQnMNSFMcAs8Qxuz+EGv0u9QQkI9d7noYc02PDLnx67A5DQ4+?=
 =?us-ascii?Q?lFYGqt8PMByT/Hpq4cYHUrNNJ35eH/35GVyF3MM5PrvDl6cvGNGsou/F+PlG?=
 =?us-ascii?Q?HJa1OUmR9GukkzAEW4Zt3AxAVqCoF6S3zURYsdO+b+8jMUMbAqYs5r18j5VT?=
 =?us-ascii?Q?vtt1otM3p/ZbkNDMKg/PP1TjDu0SCm7bc/IpDnYvrHVeNrPeOfWDrU7MGiPw?=
 =?us-ascii?Q?mpq1ISJDTY1CbabFcAPUcRRI8z16zOVYvaOadjQGnaxIU25kdZ6e2AM66agm?=
 =?us-ascii?Q?WVDr80HnMNMvAh6s8bM/iEEXMbe/NxaD8XW9j0yXqzEV05v9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4992e7-a071-4bcc-aa14-08df40105b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 16:25:10.9509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwnUabdMz4w/EntqFdXWgW6fs4plJzTAk/jBoBc+D+XgGtZa5nqmp8Nz7cK1ro5CPVBg8d6BWCqgE05KouHeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Thursday, November 5, 2026 1:39 PM
> To: stable@vger.kernel.org
> Cc: Sasha Levin <sashal@kernel.org>; gregkh@linuxfoundation.org; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kazlauskas, Nicholas
> <Nicholas.Kazlauskas@amd.com>; Rodrigo.Siqueira@amd.com; Wentland,
> Harry <Harry.Wentland@amd.com>; Wang Jiang <jiangwang@kylinos.cn>
> Subject: Re: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on D=
CE
>
> > Restrict the pre-update call to DCN, matching mainline behaviour.  The
> > full mainline rework does not backport cleanly; this is the minimal
> > equivalent for 5.15.y.
>
> This is a stable-only fix with no mainline equivalent, so I need an ack f=
rom the
> AMD display maintainers before I can queue it for 5.15.
>
> Alex, Nicholas, could you take a look?

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> --
> Thanks,
> Sasha
