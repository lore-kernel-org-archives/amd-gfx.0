Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F745D12D5D
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 00:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8ED710E3EE;
	Mon, 11 Nov 2024 00:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HBLBe+8X";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9939110E3EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 00:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PI+Zk3/vj0uy2zz7ZUSUfqtuas48OA6GOMbGWOzu7VFrBzrw0phuRdpjkJ8rslz+1gI3O0wQogL5H9vU7u3zUtBAtzxVJGvUclnw1DDSk1DPS6OSUxwHuQTdmaoABjF+Yu0YMqLbZu1T0QlFqV58uHYbVflqEE89Od9GlrCU1ABxLUtF3pyWplmFECRNaB9S7cavg5+eQXzKdGBvkmbsHhtgPhVKCNmlayo8EGHdE7MZsbbX+TSXxTd/lfooJ7wpC613CWspv7HmqoJhNC/0vPb3ppStI/PcZNC1vQYAOgdvyBIceimwGrnlL5zdOTYYOASLT505/W+Lnw5cgcR8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAeZTmM9KvkCRZ7JAtsbx1ahQ6cgJovtVePkIRIqkgo=;
 b=GIIFD4vu98+lQzh6aZMQv/XNah3K5GySvAvHKdyBdLhGbmxf9IdJg6VGr9bIwdzcxf4MVAKVvPLS+aazSOUjrOcsJ/c3ry+f+LdxzF9igvlNGX1t4rvaL22VljzY0KJR5YunPQEDqO4UTx5eMtzNyyhOnCM4sRUf6wHlXi0PAgFF4fW4Z7yoYmm7vvGOeAJqazSqhpPiPIGQVwVWMKzITclTYn6S4gPy5itEpjX1SAm3Qx7EP+5Tlx/1zKik9O6m0Nv61sZDGpxjdaoSLJ9lWgzUNrYErBMl7Mc++O93sRJT22HnZ/l6rnFN6hHdzrI6QVJ65MZM7PJ29XbeSuuDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAeZTmM9KvkCRZ7JAtsbx1ahQ6cgJovtVePkIRIqkgo=;
 b=HBLBe+8X6GJjjZ8p8v8qdXWdXmvIf+uXQdGVMw4884KwgEkssjRh+zXIHieqnmYuB2PcRv+/8QipEevRCFkcpNMW2Hx0PcX0w996Swn6SwyhKZXNEkmt/WfhQIZLJl53wAlNZlAomlfCQoeA+h+G39z6bpPkDcKC67URcpwJwz8=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 00:47:37 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 00:47:37 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Recall: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb
 pool
Thread-Topic: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Thread-Index: AQHbM9NNAjWsU2+dwEe6qG9NEj+WCQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 11 Nov 2024 00:47:37 +0000
Message-ID: <BL1PR12MB5269025E3D377B38AC2D954184582@BL1PR12MB5269.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|PH7PR12MB7454:EE_
x-ms-office365-filtering-correlation-id: b16b23b5-c533-471f-d05a-08dd01ea701b
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dFWHedHa18ZEhXi4Ht1Q48ncGX3kO9amaKwJuPi4MvFSvu7W4GZUEh3y2H?=
 =?iso-8859-1?Q?lyoDii6yctMsfZckT8kAij6FDTHPoEuYBHSgC540jKQzu6p3H+Xd2N/GuX?=
 =?iso-8859-1?Q?cXep59oozIKZp55gyS2yLibZbRUUgcw4rHODP5vi1MJDeMenaDPArGHAf5?=
 =?iso-8859-1?Q?lCKAC1AGvvk8IUfVW+FRVUMhOxP6s6JrtKAmhn7h3WXEo9YdSegt9496DJ?=
 =?iso-8859-1?Q?jtjlMNhnPc0wc2Ra0GUybkJFjSzIEELEZfiv6235KENoMmZkisqEvnn3DY?=
 =?iso-8859-1?Q?MlW2VMkNLSe4tTRs+/UPE63SANHyAMcsaMIP8mUfos74o8IMmXN0ARXZFD?=
 =?iso-8859-1?Q?G9DqxpNJMS7npsPpguq9VJuJ9s8Q5DoUWdn0ZXyGpuKeINf5sLhAeyic0/?=
 =?iso-8859-1?Q?6Fo/uz1wu1Yxlw4kXsNwPBvqg1ZjS9hxlawQ7QjxL8Lo0hVkBxyCpq5hTC?=
 =?iso-8859-1?Q?wZNeEroXinTtimyxz8aNWjnmQYtvdIm6l+Bsl456X4Gb3fyckaQ+gChDrH?=
 =?iso-8859-1?Q?tGuT8KEYxZdfSbZsylb5w2drgH/0AYTniaa8eQXRKPonszZ3TWmeHCTkzR?=
 =?iso-8859-1?Q?6EgzH/o4oRnyaaQyutNnhp+HSW6syXvAZCg0C0EkYFZox8zjw2Yn1wsYII?=
 =?iso-8859-1?Q?hdZ7EOwZVWdvLF9axgJ4cY9Bh9cCpRrBShAOe87E0cjI7fkW/M/TV4JZPJ?=
 =?iso-8859-1?Q?cjkdGogtzs1uw3jbPcFR5/FY7Rrr0U4rPk9XT3BlcT649h2ZByYPwqmZnM?=
 =?iso-8859-1?Q?W4yx8sVt2/LVWq2dXryTNcn9AQ51YkUefsEuJLM7FVfsXJnq6xa+Ycgb03?=
 =?iso-8859-1?Q?YwKseGg4lB7ensw84AZ4rS+maVwfy25AvpRUgM/QhY3gXTWGTO18sKjYLW?=
 =?iso-8859-1?Q?ix7lN8c2S/W1aFk6QS4mH087fdnlT6TtbEbakIzNrNnX5/RJ+LbgGChlE1?=
 =?iso-8859-1?Q?mp2pktTSPfpt8l6UJNOCEfGxqgUvf/ZziOO++dLf1O+jTdCa5U9ywdC1vB?=
 =?iso-8859-1?Q?OOOwrCuG2dIouRjQ8lSXOLJ88P8kAA1LIllplUcnAgcblS8R63h8nLtm+X?=
 =?iso-8859-1?Q?KWDouwVPzxi5y1KNdGlsyTOVadjgL69QRp3YT9/r0AWSrBsb28ZLE43F1q?=
 =?iso-8859-1?Q?71jpmJz+hdMhetFjXHnyoEEDGMyUeOsafY2xbiXrgIVYcVebUu7gi8RPFb?=
 =?iso-8859-1?Q?AcYzYgJ/gopqPStNxaxMhnvRCn7X4tStKk9JyJb6/nsoQr+LlF3SbJg1kU?=
 =?iso-8859-1?Q?Jz03JSV5Kmf0Ss0mZN17bXrls57xOKclc2XWFr6HszPho2tmm6kxuE+bFG?=
 =?iso-8859-1?Q?kGHxnyyggTl67IFUy92UA00pCZpMLwP5nmic2HMhMrG5bHP9mXhQWEmm0v?=
 =?iso-8859-1?Q?W4NeqvzLafbZ7cc2xvRf1EqfNUWk6DJZehGAYfiIbESFm9ASLRaKg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dJFDO/AMxK5j+7k043uEA9S0EGK72ClfVL1f+11PYsPXENAXCXH4pE/BpN?=
 =?iso-8859-1?Q?mTSgEkga+Tb3+/HsS1W52/nqrvGdAMxJXm4BnVRO3WdWoitpa8v8mwj28r?=
 =?iso-8859-1?Q?PnvhcB+ZUBj/vkrjhgrqRJQ2xu5m84947deu55oeFanEwj1+cDovOwAYPU?=
 =?iso-8859-1?Q?bqYTJ4H6si7n+Ex/rqgw1ZkBRM6tin+iY4m52XE/jCT7yYRQ0KZ8Zi8pN3?=
 =?iso-8859-1?Q?3msyEdiRhxbXqIsdWw99EQipUVMQV7wFn0UPSyQuG93BSa3SKn6mp99FzS?=
 =?iso-8859-1?Q?Unyt1dOM7QNIYteocksDROjw5pnJYa2hJwQInrUF5tFlAx/GiTd7YCiIDp?=
 =?iso-8859-1?Q?ZxDG/R/nTgqPti+WnaiE/D2NDrmO07nFYUBoPo1YWlM4acga6GMxxDspF7?=
 =?iso-8859-1?Q?wybexygdbe6xjbHK5mkXq50Gmzi9npaRc6Zh/zPGoBl/U/8jzaSotpMXFA?=
 =?iso-8859-1?Q?EaDa1M4TT7Dj3eDGq66ZM5jc06HAohw8EGxiN+0Uk9eAX5QC9I72jFsrWG?=
 =?iso-8859-1?Q?xNugxZBEiingD4O8UpLh4VA4Bx8f0TYae0BUKvCtCrUMgT0FaVrZ4srbas?=
 =?iso-8859-1?Q?UiVhElROhHoXTz5fIZRu3zM6igStCQyA5yDcEmQC5mR+it97I1O1ybFOPY?=
 =?iso-8859-1?Q?/qwpEORtkv/2RTzjrAYpxIhtntjZqoPeD1Jb6zY2PgmGG+Uyrwcym19NPY?=
 =?iso-8859-1?Q?C10jMfJ1jByVAF4Hhg9Rm5bR8+REVor2sYlqXQ/0QXGW4lRNd+R2fZtUNZ?=
 =?iso-8859-1?Q?b8dzA/LtsYq8ess+HL1g4jbool5SV/cIGkJjWno30OHyVhIws/V9r4kfYX?=
 =?iso-8859-1?Q?HJazDocM+HFx42OUflA+YX5LMfgLjQ6VCyv3LbVqWH9LnUXc/tlT0fI3Gy?=
 =?iso-8859-1?Q?leOWrdmL9CWq9iTSpxpljYjyPKnw52HWol78rTo6RVynh5efJpf86x5gQV?=
 =?iso-8859-1?Q?XT/FkWiPsd4Mxtt8sWBq+Heu0SKHJYbD5MVKWIH2KX0XcCMf88Y++XJaDw?=
 =?iso-8859-1?Q?Tc7gQ4ZBRIPDyq5y+XV1UcBSOrhNFDr2hObjnTcAiblqcGs5L89Bgh4hXA?=
 =?iso-8859-1?Q?GOBy/ha0f2VQkz6Bi/W0QfdMa4jZEzvcRqICaariXstN4PQcEsJLtKbFSj?=
 =?iso-8859-1?Q?Pjy+FbN7+ZMcIyR8HG5E/j+4UEp25dtp/M2+PZZxOk4lSaA/EMAhhPsGKq?=
 =?iso-8859-1?Q?7aO20yRJEoBhvZSOonAe/pWEt4HlNxrBrjWFJTn4c3d8hY0i42nNmCcKi7?=
 =?iso-8859-1?Q?5vxzy/GSKC6oZU0sqeNMdHkEbzjVayA9Iq+NDV40jILsNqfZSJZXJFrlvU?=
 =?iso-8859-1?Q?/w819llLPZGMgHTFq2Q+0i1b4hi4Sm+qEWMUZQ8qGZNCYgVv8a4YemqfG7?=
 =?iso-8859-1?Q?J8PJ1Mt675a7vNusQ9/yTfPGpKPGMLltOYRcIiMpm0RVV7eq6uAXu+JwPv?=
 =?iso-8859-1?Q?2tUc1LGMHfYZs1WwUV3Et1vJJHCjXPX17sSsI6SD4TTXPKto6FA/WqRJEx?=
 =?iso-8859-1?Q?MEXBVd2CpPWZs+v3GRRhBh9r8GRly4uJRa2oAIsIYO+flnjH19X8+IuMF1?=
 =?iso-8859-1?Q?mqGSM7YIo4xHA0ud4acnXl9UUA6p3yuqVVaFBBviqukX1N9lszqxkXorPL?=
 =?iso-8859-1?Q?vFqKRClimlp0Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16b23b5-c533-471f-d05a-08dd01ea701b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 00:47:37.0980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8kb2LbAbfveDxVJUUnb3+LkKl+eEtbXtZB0j50JBZFLL8ya7xud0+5UYrwM73zR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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

Liu, Monk would like to recall the message, "[PATCH 2/2] drm/amdkfd: use ca=
che GTT buffer for PQ and wb pool".=
