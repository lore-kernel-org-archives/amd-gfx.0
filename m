Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AE5D1BDCC
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 18:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087CA10E823;
	Wed,  3 Dec 2025 18:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iW999v2R";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9146710E81D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 18:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdVABZyV8wpNUPi+Q3tb17j0o1HkD/93z5GwI4Q+a2QPkN/rBTCs0yFxSeaF7O4dhmKCSFBV93RCkKXXgUpETZRgCF02aBncmXoHXg4sGCA7uUeNS47OPsUcbfdJf0nQJTaTB2iMQ0LGrOzsm4iFejGTjwshbOzZW1ZMO0DWn+hj3q5GeTWhKFTm4Ix3RTL62RS/95wAkvBxTjovwjcPDyfczsuhd2yk00BkHVOoW4bM3XYUQPCF6E1/fU+7CC3G2IYfWPFoHC06c1zLta8CnFmuLoUw8pvZ42420SirDJU1pIRw+QvOEXGCVjZSuUzlyORfEpHWmqcVcWiXktFepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggd4dXEH6vjN6c0OZc+kh4tTi89qMZ/Td8YMCCMCsTM=;
 b=lD8Tax+xvtDn52b5rR9z56UBB03/1Po7pXchxDmJaLOiVeZ4fcjCkZJmZnhHIC8PkLAgbtdjHihRp3L+42v2/d4XrJv78eSCfc+J2LKDgR+YxmDj6m9vhHX1KgVOlf1k+SDyvvQqf7FABRAO4nc30zV9DGyKn9NOjYd7SeF+ExmYBV800qWAkRwCnyyTkgjt8fVU8A2He0JtykqwBS7fSRq0RxuCJ+vrbxdl1r1UDG3RZYjFp7LYqmmQbNdPUwrmJbZlCDAJ3gl5mLvq/Zp3Kb4VZanCHVlpAM/NyHmeIEYB14+65Wer/MCzNX2qKqTdVg8G0fwVc8Xa/EJFk/hYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggd4dXEH6vjN6c0OZc+kh4tTi89qMZ/Td8YMCCMCsTM=;
 b=iW999v2RtE+g8ynagA2A+LztEMb62Oj0SgEjgwqt7cjZGQAUguUoGq2emwDu4en3dAxCp0DLrZiQjzS4n8jhgumHdyMxHetF4FrY4GsOPiYjRjrn9k6pxjogc0sHvZiSeXXxFOVvDUfQR3a4Xboi56bUv/BfiPKj3cFGI8Y8k2I=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 18:39:24 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 18:39:24 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amdgpu: Ignored various return code
Thread-Topic: [PATCH v5] drm/amdgpu: Ignored various return code
Thread-Index: AQHcZGNrUcyx9QvoZUmBQMM9YyyStbUQLTcwgAAKxYCAAAc5gA==
Date: Wed, 3 Dec 2025 18:39:24 +0000
Message-ID: <BL1PR12MB5898F53319E1BD6E12C2127A85D9A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20251203144435.62300-1-andrew.martin@amd.com>
 <BL1PR12MB589874A177F717DC7956CAF285D9A@BL1PR12MB5898.namprd12.prod.outlook.com>
 <SJ0PR12MB81380A3BC561CE1EBC297AD1F5D9A@SJ0PR12MB8138.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB81380A3BC561CE1EBC297AD1F5D9A@SJ0PR12MB8138.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-03T17:34:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH7PR12MB7282:EE_
x-ms-office365-filtering-correlation-id: 1dc0754e-cc81-4824-5f13-08de329b47eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1nRIb71WFrhVNcWzs1IuTHA85oMug7jpKoCOOFdkhtskV0k24/hemedLZtGH?=
 =?us-ascii?Q?jXtOJiQgbESW6T4ctENYmZlSg7jnkv1wplEuFMgfjmH8c6Y+kjkOf10mXqgk?=
 =?us-ascii?Q?lYHluafF+zeESEZp5U2a0zVpya5eyb9rerOF+z+1dVAH7DP2dwfxr1ICZaFH?=
 =?us-ascii?Q?cic2XzmGtQwkyf5iRZm+EZ02J4MSHv4+ri6HCLlwpFvw2dpHjhxlSUQvGaNK?=
 =?us-ascii?Q?G/BEebV3mE5a8maYw4ARFXniPPiPLY+oPcOuHfiujrZVoHrGWblQkUwNqZpc?=
 =?us-ascii?Q?ADwjQlhFTmz8MtXvJ15RZu4ZajEO1ANhdw57O+TisW/0ez+afrbBLFyPiXB7?=
 =?us-ascii?Q?j+vlJCcBzE74N7sNPJo7uvWD20RUPb6XHTHgI4kM/fQzl1NfpKlQZiUQ9YaZ?=
 =?us-ascii?Q?CSoYFkkP9DPzW7BD4G2hd88DISWzGuQAhvNKRZnRz84JRa7oZkcomildMRPf?=
 =?us-ascii?Q?4XiVdhSkHZMA2I65mKOXgY+VpP1Ad6TdDcs2j61JpZvROW9c7GKdcz3y0Kd2?=
 =?us-ascii?Q?eUAMd182SxJs+y0VvXZxjrrmFAPO6HONrjNZch1jW6sH9GWFSgAkyUOIjmrq?=
 =?us-ascii?Q?OKf7YWeBf2s5UGYcUle0pKf0FGICzpmCxi/hqZZYdZfK/xo1NFNTS89Y7rCo?=
 =?us-ascii?Q?HQEsOCTcef7h4eDtd/5qWeECwm0LNnYYtcpmH2UZNfkwqBiymkXNsd9/bDG6?=
 =?us-ascii?Q?GNFskHVnFkIyZhYWaOPlJBFRZbRDUAyhovqb217gG9SdHup05V2V88Nw+6Fp?=
 =?us-ascii?Q?oGvwAsr7xMFkx7t/PARzz8ECR7Ti3/FapyaNXVRXTqiFATgfphPWzwXfPQvq?=
 =?us-ascii?Q?mxVFnTfY5/6ZxqxQUYPvWDTlWNTIojgASUnFCvvoH0QQfAHU0rY3PQERUAFH?=
 =?us-ascii?Q?uj0Mrt0JeJ01kfwuzXC7+qEV2dN3vXnnKfDqF1s8gNwnRH0vQlKYo9KALimO?=
 =?us-ascii?Q?SnmMgQaB2W7GBXQX+5gUHajgVVAXdZYBpzJBRWHvbkiSHnG+FT3HdhiKa+qV?=
 =?us-ascii?Q?fasTJpz9rSEboKrzgvP7mnbc8bzuJ8G6MhcHCde5Zohr/+SA8e/bG9JWK989?=
 =?us-ascii?Q?2tChw6XwOmlU0sAjTZeRZ7MrS22xJx50OIEcxjPPUNeTD806TDk928bcVH/h?=
 =?us-ascii?Q?lFmbHF3wDif1HJsOOeDR03lbYT9s+ZnU0fqkDKLr42y/oRg+bOxlqcH06kED?=
 =?us-ascii?Q?h1YOt7qk/I+IYkAwt1VGj5a9EK1HdH9bicP/Zo1bov9Vee78IT8xwyqVQbNI?=
 =?us-ascii?Q?ZFB33qWXRcoUOMdPgn8wbfYd/PCb/5q5ycK0hj6fh+CJqU8lqzmzD7niIgl/?=
 =?us-ascii?Q?wFiWZhFHbWtdNEWNA8qmsEsp4CMsYHjXZmpY/ElIdHheUkaapXE3+7NJy5Ts?=
 =?us-ascii?Q?4Af/7Ss5AAyVpcOkkU9u5meSjZ8D+WL649Lizqj+Ncrr2RcLGEVpvqBRbxmT?=
 =?us-ascii?Q?NpYJOwbzrlU+cAr481eS/GvlC5dmmTq7jNyDag144S65ww2vfozzMHUM0bcE?=
 =?us-ascii?Q?750tXLXqaYvDaykOPEV795V8+z128SG9L8yO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x0Kvs3RzRs2YbhEmBIX/DVnap1MtgFrJ0uYeU9tJjNuoY3zV25+6yzdmxB6N?=
 =?us-ascii?Q?QDb8B6b2CWfgZYQey91ewNVpVc2roP5xN5BNmhqcAyGxDHPmA17efd8ToEc5?=
 =?us-ascii?Q?sBNZOb7E6ZU7JB1BNiRGJ1QTf7TxG88cgoYfcq2tJEhcrwTNH3ueFvkqeJc/?=
 =?us-ascii?Q?fWfjybAvvXuef06/jjt7jgeQTtkp9C2/gVKCyL0L52r8iL1xDxRdfizMlhdA?=
 =?us-ascii?Q?oA4+0u2+Kf1Cljuha3kehaMvyvONDRgIF3J2xlNhVdYBeaxBtm8+5aDJTGYW?=
 =?us-ascii?Q?zJUc4p9IIA+tn8JwfMx0GfjtgUFAv33HUhUoA0q48PvDPAiLNoAJfDAPaH/C?=
 =?us-ascii?Q?KLNFTm/kgDXKTI7InT0TITrAQP7TcDMg2neTncKuakC/2UFDfmfNEp81NAF6?=
 =?us-ascii?Q?xIKEP1s9xjDmlEymGq5vczM+l18f0EBfGRXDLhtklNZa/Jf2DFHFn2kHFdk5?=
 =?us-ascii?Q?NkV12HiheXhyUq5JfXHKsnkjzcuFyqA4BbbiWF00SgL4i7cfZTkN5xtGPG8i?=
 =?us-ascii?Q?1UAhaGBv/XOSZHrRcLW/DkxOmg4zUSdOQwqwCjAEvfzAuVyrRJ+GS1vYttFk?=
 =?us-ascii?Q?BIsxoY8sG0+1HrQpuaxk3gk0IAkfm/am8C/XOKRhC5xAkUwuBwa7CWci9oy8?=
 =?us-ascii?Q?jbfYlJ0sXn2Ujk32jmdAqEvuT+DduYOR7rQpRpWPwLSWMxS9Xco+yTSAx+kM?=
 =?us-ascii?Q?mulAxa7S0KsxeKg5yG+CKT1V4ujUkmqBHXBa43ki7hYV96u1EufKRVxGrGF8?=
 =?us-ascii?Q?cuCifr+RafB9FVoHAHR/b5xXiN9Sl7N79zaoKVZClqHSawVL1Hi8N0J8+Jaw?=
 =?us-ascii?Q?rc+IB6vDumyT3/1EU1ilQiwWdOhew8AUSSjRlD/seGP6byUqFMK9b5ruUn7d?=
 =?us-ascii?Q?sW+nzS2OfHMLIQgXPK+JXnWlyROY9XOaTU6E079hwie5K9q/kNcJXoy233WZ?=
 =?us-ascii?Q?plkwy9xNR0NFjalBMWw/ocfe02OqGIIzbeK2DbGqGygNGQSKSqOy/8y4an7B?=
 =?us-ascii?Q?trJJWV2HNSU0FgXK9RgsilhBDxgCYiwct2qs3aSb3brW0rPkkjwEG5hquL6S?=
 =?us-ascii?Q?g1+2qSLhwZLxcaYYEfwsN1X0s5fEtrme6rypuUHCO8KyqDCYty3aZFlgVtQm?=
 =?us-ascii?Q?unOsSCsD8leqGpu/KQDWXi1SMSLB0O90g1srvvXBponL797nPLLMgrzQZ7Al?=
 =?us-ascii?Q?12bxZNuEX0JIOJd7LGif+wbVkb9gRrnUC6EB5Ur3XcSbsggpbu1JaNS4Iv5d?=
 =?us-ascii?Q?k7L1+ByXaCaGzl8IKw3dfwWWaa1X3AodViAgbSEWlxj4iP8VdCDsI5BkN2Av?=
 =?us-ascii?Q?JfK933SD5ngFLblUCwQK2hEkXH4nadLKho+bxGfid1tk403QQWjy8s0XIeBG?=
 =?us-ascii?Q?Oonbfcyo5DCzlFOjcDDzoMljeJunTbDjtxOwrTUOnLCcAU/BgTdwlP0JreXO?=
 =?us-ascii?Q?L6wrRTMTsUKz0ItDoITzxLIgmO7K9biAI8YIptO8evEcR2GMTrnTZIO3d+hC?=
 =?us-ascii?Q?agRbCXKzwZP2Uf2reIwcM9Bpb03qbvkC3/4NVUx9V5q2oEf+Se+EfICQAtPW?=
 =?us-ascii?Q?jJJH5SDodjsNAS0oIO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc0754e-cc81-4824-5f13-08de329b47eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 18:39:24.0756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yk050OzQk3HF0JiU+3L2k2lAkLz19zdipLLOME0wQbLjfoXciOWDfnIZKo1yfbI0Q5/v0xX6nIniQXZ7Zdy3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

Fair enough, I saw the 2-lines-down-to-1 and immediately thought about leng=
th. Unless anyone really complains then we can use use 100chars, per checkp=
atch. Thanks for clarifying

 Kent

> -----Original Message-----
> From: Martin, Andrew <Andrew.Martin@amd.com>
> Sent: Wednesday, December 3, 2025 1:12 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH v5] drm/amdgpu: Ignored various return code
>
> [Public]
>
> Greetings Kent
>
> > Can we try to keep it to <80 characters?
> >
> >  Kent
>
> Yes I do try but, sometimes this collide with concept of keeping to the e=
xiting code
> style (though not in this case).  Besides the *checkpatch.pl* has extende=
d the
> *max_line_length* to 100.  And indeed running it: * ./scripts/checkpatch.=
pl -g HEAD*
> did not warn or erred.
>

