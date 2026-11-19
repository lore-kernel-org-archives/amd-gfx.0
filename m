Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEAD606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3aRiXnwu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA7C1121B6;
	Thu, 19 Nov 2026 08:53:00 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 034951121B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 08:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riGeeBVzu2NHUP2gCWnFyY2sZ55FvQGvJzdN5GX/Glt6raCpkHaAwDQoGYQv57jSHqawqBtM4fkZo11N1jlO7Jglkv2l3tOn6vBdWvhSzB7vOjF89qLjGGCua698+1GM19Y8cRQng9gN7E40xozPAxH17aMiC4w4qMaOJYlGYxWcSVufH0nOD7BhmZZuhyLlE1jwsZMmtgrnKVmPDGCfYRaZbb5atZokAiwOKt/tt3twDgu36pzgdiOJS5hi8LOADAtr1fwa4Ra9SdJktY5DaIkQwVGt91zSndzuTbxAVA4aUWxGj8BT8PWKx+rDk+0zEJtx8woAWOJfysSk/pXNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9B9+vsBTOAWbS60nubRP6FEUq+v2zYYohHijdKR1b0=;
 b=A5Xj/5+3002ogexIzXxsw22mZXV5xfGsbrekWvx1EnnyONCciB3/dZsoWaM9ix8nghmpcsu1l/2s6mcC/wr9XCnV5Xj5rnr9+5NdIIwHK8AUZNm1tk2+gkabX3y9TXkBPZ7WTLAWguU55MKvdElH+YWWPCO1lqWvAxTj0zvrJuEdPyo3coPhCTv9JUfpRnmcQ9j97fpB1VEYdMXyaskXizLuf/2iYRtBOHxm9TUGbGOld+oQASqQdLAokIC41UTRxzBGUrLcvsXnmvFM5DqDxWy1MT1jjbo1zUckke6s9uaMMreaewqZKVkM2Kt0vhauR6ibrFmtMhQvNFi4WK8QDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9B9+vsBTOAWbS60nubRP6FEUq+v2zYYohHijdKR1b0=;
 b=3aRiXnwuLroBYl34Zhu56wZdeWY6+pZUvuY4Bu/Br+LQgXlCjs6DlDPhOWHGm1s4NaGkrJk1mJOC+J5Fte+QJMlZi2ja+mPw7dHKZ2ucSdlTuapOxB3xd0MmZ5bHBBklwVTUv3Colx8pybwPJfTG85040Z4p0aY8emucrcUiECw=
Received: from MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 08:52:50 +0000
Received: from MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc]) by MW3PR12MB4572.namprd12.prod.outlook.com
 ([fe80::79cb:c567:1825:51fc%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 08:52:49 +0000
From: "Mu, Zihao" <Zihao.Mu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Thadeu Lima de Souza
 Cascardo <cascardo@igalia.com>
Subject: Re: [RFC PATCH v3 2/5] drm/amdgpu: track internal completion of SDMA
 VM updates
Thread-Topic: [RFC PATCH v3 2/5] drm/amdgpu: track internal completion of SDMA
 VM updates
Thread-Index: AQHddohcMOlM7iTS3EWImvhWZvcxNbczfrKAgAGa8CA=
Date: Thu, 19 Nov 2026 08:52:49 +0000
Message-ID: <MW3PR12MB4572F3508BC654BCCA1408299E792@MW3PR12MB4572.namprd12.prod.outlook.com>
References: <3a727e33-4bd7-4116-bcc6-c7d4067286f4@amd.com>
In-Reply-To: <3a727e33-4bd7-4116-bcc6-c7d4067286f4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4572:EE_|MN0PR12MB6079:EE_
x-ms-office365-filtering-correlation-id: 45079d8e-a447-407f-f79c-08df461a7d3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261102123227099003|38070700021|56012099006|11063799006|261026140227099003|10067099003|261022105027099003|261021121427099003|261022075727099003|261028144727099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: UDZRysWDPHmN1/vXBNhcK0Itj1GubHTCf9OhX0yvLAqFkJw81Rv7FhEsliUyStQY0HHjOjafs6q277oc9diA0d7WJoCFx1ZOlibp+SMLrZBjZOmI2mDPCDZ7NdPdzXEdwhmukMVpA7Y+YGVvSKqKg9Y47WEPAf/lATe3q9K2Duq/2jrKmmP5XZlsH7vg3fw30ikxUeQkaa8cXxKsEHJVGD5xeJOlDWA9r17/fiBywElESrpXJzMA1l4IlGYCdGJflyj53O2nwSVi1+697vAp7Kz/2Vk+KMHuakTtoMEXNVtiMBiqRhvYcbaVYW31nAQ96qI4YKOe843t2q5o5FVJYz4bV0q/1xHtQE7O7r64GThStAUEzJKeCtsDReUroDymBhk3CTvkK/LClb3RPmHvr9uY196PPy4N+nHb61oo+x7K5KpadhZ5lw3FkFDQwWUlgiAe2o3nCi2FHMYLmOZnKhTpuHqUVYVMdw6sShMnPb1Di58LHyhIkOcZJgi7CTTGoQJTka47EEXGxrP2eQKjn3SV9KHEvxdPr7SKT6w4uZDZ7kv4Ymtyat7vFycigSE363r4KMoX41eVfoMxwcaV7Y5wXfCDJiUKi1VDxcdQOGyiI6NZ0GdTuy95VjXEMSdLCEHSrKcOXHyW799kpQRL22BhP72DlEM0RZ0NxWU5hfaomeaT1Umk61xdgVK+mj1ZYmOD9VA2ZtN2nUXCqvbeY/oC2UNlGE43f4WAOOLHNpQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4572.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261102123227099003)(38070700021)(56012099006)(11063799006)(261026140227099003)(10067099003)(261022105027099003)(261021121427099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sjtc8Aw5Ml8SVNBMPJx0zWmzjK9Zs2Gd5v0AjlwblalRqI0iQW6FuW2XNtCK?=
 =?us-ascii?Q?ME252DwpCpByCbyZiiqxEeoJXWslX+EbHq9OIlrxsihUZpLCHDJIizxWmMz7?=
 =?us-ascii?Q?pYndZlCRlYE6Q1IgRKbdfnXnKwfVG4DrOYvW6//Kg1Ksato4C+1E7V5Sp8us?=
 =?us-ascii?Q?pM+VbzTBZ4WJJjapEz07huQPpmtKivh8ORs0bnpjUcgAwHj2k1YVHWBGkEZi?=
 =?us-ascii?Q?1g0bCLPuXIEjLEkxkswkglrfmnI+xt5tXqjkOWmrQAMhYwfvyqyoZhmLsvbd?=
 =?us-ascii?Q?aFaZOa2Rgm5taRj6RTUoM+5cXS2eAW1moGT+biqg3fkUhvofVlZ6L6DvxTjb?=
 =?us-ascii?Q?J6P3C0EYG+AAp5h53nmjaZyx7R97fUXzXR8siIHwb9VCu/9Jr09FYRgjq5BE?=
 =?us-ascii?Q?4zG3y8idImL07f32slbVlLQwysQY/YhUEGaKUergcxhn9Qw1EFytAr7eU4tl?=
 =?us-ascii?Q?BWZmWE4RtdSZEqHLdO6kOSd4oEq0gA1ppnGpMFJ/IYDbCG2nqo8RdbT9UAZ0?=
 =?us-ascii?Q?PDExOlmseKqSeuwixeCeeMH2wGthLWEJiKva3POitTHp1xRoEwIcFRP6A/vL?=
 =?us-ascii?Q?C5uZZzrVF+P09VtfxWyTMXXRq7O1kscz7QRSMX771gr+eEFF4JRoBy4C9z+U?=
 =?us-ascii?Q?bvRb13QqhC0BmkRHy+FzK2RBEsGcbOcjF/1IHsji23oAfRZ+ZdewAl3/JqNP?=
 =?us-ascii?Q?no38UQppYQa2UyrGalHpNkNIASi8yG4S+cYSeHYlEznwdpy/wt9qOPhYWbAa?=
 =?us-ascii?Q?PGyZp+xADG67kIhNoHbSqdIpuytWKIRLQwBR+nnPWNuTxZ/goBWKWmSk9wXA?=
 =?us-ascii?Q?GCtVJVtmgG2e53JZXRQpOzjK9Wk4BioWMcrJF46UG3WQOg8/zYBXO8m8waDh?=
 =?us-ascii?Q?GfoHZBk5T5he05E+nv7bIGkdMkXJJaUq7+l5Xhu9VzBdmM9PivAb7ErNHk+2?=
 =?us-ascii?Q?4yjqd1SS/fJwlyykqNi6oOgP9gDrF0E9Q15k9itre/aznExS38+UtWyD4ONZ?=
 =?us-ascii?Q?lXhho4H9u7LLj/sPm+tXiAPNwhN6L5I3uJrAbr/JSn3vRQflFabuPq3u52cT?=
 =?us-ascii?Q?r6SCkGdWvwrWVM5Bg/nxXzxYk34ojiQf6q5jwX+Uhgn+W0NIYxDoWjrA+7Q8?=
 =?us-ascii?Q?rdBiUL9ehMbbHcLBNDpXvKul/PaG+6flxwfcTzyhdQKX0k5zEpUxgdswiSIz?=
 =?us-ascii?Q?vTSp6WLR2G0vWkNf6xP6aSCJg1xbVDBO/c8qSKjWgrGH5xWDhUWGeLPwT5TJ?=
 =?us-ascii?Q?2pEmds6gyxb+1VL5k+pS1qPM+viyLHWySoT9CmY9pGazEhoDbqew2fWU+WZN?=
 =?us-ascii?Q?R3BxJZlHujCHultJB16ZJP+uRDoQWTrbuzcTWWutYwkaalAByGGA4cqKlut+?=
 =?us-ascii?Q?qNL+aChpf8iKj668GfUypqz4AgQRQ8dCC3jGhauiaWKo1pblZTdjQwUc5mRI?=
 =?us-ascii?Q?KXq8343FAj+rnHSm2BkcgVvmWc/dHsFji57+SQjMlx166aJ3pRV98+N6aU0r?=
 =?us-ascii?Q?fYZMrRx/h5AacxXIwi8v9kUTIDMBOWl5r7HlGLKrrfpceE9/zYbjlmr9V6A3?=
 =?us-ascii?Q?UtgAjomhVyu0Fk4w1Jk73sDfe91jY70gR2TLxEN9dtLob+fXgKSoK0BiQlyR?=
 =?us-ascii?Q?VR0VZNUufjkp8RPy2E+9+THykeWRfvKtstLicNyWSvWraTD74ufdDldNvquL?=
 =?us-ascii?Q?5DpfpkCODsfc4hb/nMycCkBPgiR5oIu2cSSBJRjTtU7rdlqR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45079d8e-a447-407f-f79c-08df461a7d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 08:52:49.4161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsjVDkbGEzKAjQb1Qt0DxLwgNtmQNNomJJijYYBsw/7aK+PBa7KVDFG2AlV9QIGr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

> I'm about to remove immediate updates from amdgpu_vm_pt_clear()
> and only give the parameters to that function as well.

Could you point me to the patch series, branch or commit for this
refactor? If it is not available yet, which base would you prefer
for the next revision?

I have dropped v3 3/5 and removed the commit callback's output-fence
argument in my local draft. I would like to align v4 with your
clear/context changes and avoid duplicating them.

Thanks,
Zihao
