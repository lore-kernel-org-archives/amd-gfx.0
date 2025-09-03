Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C11CA1010
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 21:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513EB10E938;
	Wed,  3 Sep 2025 21:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eh7f6QD3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7BB10E938
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 21:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buRx+E4S9qzrSjxAxnoWJsVQjUs2JkkFSQCHbkRzrHKYfz37HEAEUu+VuOB9JwIgdSq/DGVYhLfp4Vu2VV2LKsHGqj+dyDe+2HZXtiMHBOeW6zjpGQH7AugyW7pMuC39bvz+EdwMCjPIw54uIJUox5cCfzXcElc7Jf1YPrmxbWkLoK8cQ6siD6K0ZNnbVpaHxoaJiG7ip0Ed+DH8g+qO36WEnYU+iaJdEYl3e891WNpY/nwNc9qp/lYD3xGCMjZSoG9MC+SduISIs2sejXpS/ZM6pbKvOCogmyXVXXR3JSkF9cK/d9k0kfjbUL8Thhx9W2CznqTMB5kDGDxJHPqVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgdmPXuop2OxWYgcaqSv2OimJoHtx7OtYYQQTy1rMD0=;
 b=VEo5s2KuAWNzPdIZqQfHLQtBQEwCbYtRcEYiHIyWzjI2LGQH3Deu6cbFt4XClVtJRHdQbbrqvAYYKFCBiWw7T79MJixVSDO7fgr+8FSVwvE/fFdRWwq2QaZhSZRVX9YkQ9yyuLG/PBwWXO1uf3C6J65QFuxaL7qA0I5Ui9ZsxHOE2O7O1zjqCmTs7IUexmE/D4UFPZAEE/zivoSCZPcZn9nBlSij7XEa5Fhu4Al4l/TWxt1cNcbo1ueNGrDNavX0twQB+43q2SxeN3ZnquduYABdjE0bg++jAlazoQXHz9OJQIvlCQEOQXpSqCADEtWmUB/yOUIzYckF/0dwN9QfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgdmPXuop2OxWYgcaqSv2OimJoHtx7OtYYQQTy1rMD0=;
 b=eh7f6QD3VtnTZO7BsVhcslX1pkUgT62QYxNDEukzFaFEx2HMQFXA5QOaYKGyce2sdS+2N3mf0XV0FiY4+EfcfcbRLGFQYht7eLOkpIbuf43HI/d7G+b5yCiapDNxxl6Ix8B+IQnNhSHWJhFLS0FQ7Sb8/z9PyTX0Ury13Yp6HHQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 21:04:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 21:04:42 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>, "Du, Bin"
 <Bin.Du@amd.com>, "Rosikopulos, Gjorgji" <Gjorgji.Rosikopulos@amd.com>, "Li,
 King" <King.Li@amd.com>, "Antony, Dominic" <Dominic.Antony@amd.com>, "Jawich, 
 Phil" <Phil.Jawich@amd.com>, "xglooom@gmail.com" <xglooom@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into
 isp_v4_1_x modules
Thread-Topic: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into
 isp_v4_1_x modules
Thread-Index: AQHcHRJzTlmUBeP7vUSRYTpLa4KRfLSB65gAgAAGAgCAAAD8gA==
Date: Wed, 3 Sep 2025 21:04:41 +0000
Message-ID: <003cf58a-3b4a-4b7b-b320-22b7df9343cc@amd.com>
References: <20250903203601.839525-1-pratap.nirujogi@amd.com>
 <20250903203601.839525-2-pratap.nirujogi@amd.com>
 <2a0c1e16-8594-439f-95a2-763ca5e92ac4@amd.com>
 <CY5PR12MB6429886911C284A3F4777BBAFE01A@CY5PR12MB6429.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6429886911C284A3F4777BBAFE01A@CY5PR12MB6429.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN6PR12MB8489:EE_
x-ms-office365-filtering-correlation-id: 76152b7c-3a4d-4bba-0d8e-08ddeb2d8094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RlhNMXFJamNaNE00NjB3dm5ZNk9MTHpSUkFxZHNYUGFPK08zUkZXbkQ2N2N0?=
 =?utf-8?B?ZVJOdXhZWlU2WkVtcXpUVXhtK2pLZWhBYkpjamxDa29JZHNzRVkrbFB5YU9W?=
 =?utf-8?B?ZElhVSthdlVqZGd1Wk1IdDlIRTZGWExLNjFyTnhIUXpXdXpNTHlsSEhTcGdv?=
 =?utf-8?B?cVVCQXR3TkphMk9UQmxvcmRhRUJIdG1aeXluRTNKL2xxMitkSEVVM2M3bTlR?=
 =?utf-8?B?djNiOTczbG9QZEozbnAvVDVBeUJsOUs2TUhVcDVETTRxdVBxSjNGeXhKd3dw?=
 =?utf-8?B?aWxzWnRPc2c5TGt2N3Z5RTRjUlNlQzcvYnhZN3pMWUJSRVdiSjgxcVFPN3pL?=
 =?utf-8?B?Ylh5QTRwM0RmQlptMW4wR1AwYTZIL254WFFJMU9uR2hza1J4RXViZ0x5b3pY?=
 =?utf-8?B?NFE0aEpLd2ZKWGFiblBZa20xVUxZbmNYcG5Gb3laaTBiVlUraE9UUjdtNTdw?=
 =?utf-8?B?L3FQVjIzTWNEWktRL1NLc2hmWVBEVU5FY1VSVWlpbHEwOHorb2UzNlhjKzFN?=
 =?utf-8?B?L3o2Uk9odmwzM2J1TDliTWVyU3kwZDJ2RHdSYzdPK3h6V2tyRklMbnRFMDJT?=
 =?utf-8?B?VnJYSzZ4N0dqNkU0UG5zTHdFQTAvd1lIOXlOaVpyUW9uSmhnbUJ0Rjd6NTNB?=
 =?utf-8?B?SG5NT1k0cnBDZVRVdkM5RWd4UzBBTjVNWE9FM0I3bDhORFJRUjN1MUswSVo1?=
 =?utf-8?B?Zld4ck9pWWJpOWo5V05iL000M0k2R2JGOEZWYTJzV3ErVEcxWUNQSFRRREQy?=
 =?utf-8?B?Q2NtbXBJazVXcy9weVJsRjl4ODRMUU1SYmkrUTJHSW1iVU9TWFo2d0Z6c3JO?=
 =?utf-8?B?Q252SXkvRW92czdrVk4rM2xrQmJNMTlhakpxS3Z2Vnh5YlpyY3IwV0VNc2pq?=
 =?utf-8?B?dERwRUZKbkRIcjh0R0t1dGdDMDhaK3psVlpsRThRUUR2aHRvOG9ERUtHeW8x?=
 =?utf-8?B?eHE3UGxOYzBobkVRQzVTRDRDRGFUU3lYMkRPR05SL25LMGkzL0JjUGljV2Jx?=
 =?utf-8?B?QmdKSk9pakp1S3NvS2wydytKMXN3d2NuWURGNGE1amttRGd4cUNxV05JZDB4?=
 =?utf-8?B?SnE0N0p6ODBQUHlnQ2c3TlUrZitldVhmNEdhakVTWFBBUTkvNys3QjNUZEFG?=
 =?utf-8?B?OXl6RUFoTGI3ZmtrMWhxN21Sb3hVLytvazREQ3JueFBPeVlWTTZNeE01Kzgz?=
 =?utf-8?B?YXRtczJJWFg3Q1ZXV1R3ZXNVbDJ3V0FjeG1Ed2tpSG1IRUMycWV1eitUV2Ny?=
 =?utf-8?B?TDViSU44a0pSTml5YlhNK3liRmsyaU5WZkc3NDZIV24yNUpmbnMrczBOWFBL?=
 =?utf-8?B?Zk5QcDRHVmROUnlhUnJnekh0dUZuYUpOS0pKK0xwTENQc1IrcXZtbDkzMy85?=
 =?utf-8?B?VTdsbXBsU1o4MUhWSWFnc3lLcGtlcStqWlZBaTBTcTVwbk9xbElWY1N2bnVS?=
 =?utf-8?B?V1VaNTBDdDg5L0pkbmREdW5VWXBKbW9lTTZ1NFNaTGhrVU9Za2U1eE14RFlj?=
 =?utf-8?B?eFBKUXBaVUhOcmU0dkdYajgyeExFZHZkV2Y2REpaeFIrTlFSUGw1NEdUTDh2?=
 =?utf-8?B?U3pnQ1NDd3dTS2ZxQ3JtR0JQWWd6YVlLVGMvUlRGM0FsSlJtcTdFN1JsdCtS?=
 =?utf-8?B?bUxBS0IrTmxqOER3VlA2dGIrOVpBSFEvRE5HUUhJL3RTZ2VnRjhabkZlbDBZ?=
 =?utf-8?B?eDA0dy9QcjlHdkg1alRsV2pTTWkzM2o0MEdmYVM5eGIyb1RvQ201eFAyOWhH?=
 =?utf-8?B?OTRhMk10VklyUU05WGlkbUE0dlJwelg5bU4xaUc3KzFQejRpNzYyQytnczNN?=
 =?utf-8?B?ZnpwNElzTHRkZkM3Ymd0K295eFgxUkpkeVNqZXBFQ2tOUmNWSk1NU0QxK3di?=
 =?utf-8?B?RUJ4M09YUWRta0xjQWtNNmpFbFVWSWI3d3lQOURRUnlqQy9PczRUUnc5L2FZ?=
 =?utf-8?B?MzF4NnVia0hSbHhXenl1VVptRlpjOWVqWHhGU1pMRy9JMUpaMTBzWm45Y2Qw?=
 =?utf-8?Q?5+eN9QJppOger8e5iXRHd0V3kzOlnY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVU5NTcyT0QzRHdtcitQbGowNHdMVVlOVEpzRk1JYTdXbUkvVll2SnlzbnFu?=
 =?utf-8?B?OGM0cXYwd2Z2a21MM1BNb3g3QmVwUjlwT1lsalB6S2JXdEVkMTNBY1E3UUhX?=
 =?utf-8?B?UkQvUXlORjdaTFE1cTRuSXhFMU9FWUhIRG91cklBYUVodGRTNklGMzNCRVFO?=
 =?utf-8?B?MmxnMXY4VlVyUEEybTRBTE5ud1ZqY1hwaHgwR2Vmd2ZzYjlDanNNZzlndEhn?=
 =?utf-8?B?UVF1bUtlTm1zbU8vWEpsUFdpaVV6K0NkaDhwL0l5cGU2ZzlIbE9ZRFhuYUhY?=
 =?utf-8?B?eXVJb1RFeHdlSGNaK2w5eXNzYlRmYXlGaGRxNUdZLyt0YkUrcnJkaWFDcS8x?=
 =?utf-8?B?dlFzVUpJUS9ZcE5CNTdtQ3RONmZqSzh0LzdjSzh2a2FIZmdLL1JlRWdGYzF4?=
 =?utf-8?B?eGNxV1RKcHA0dFQ4OG1kODV3UG5wMHg4aE1FcVAvQjI5SndwR2VoYUI3R0pF?=
 =?utf-8?B?MmNEWWRYb0V0UzBzczFNbXZuSnI4bjVCRTlsKy9sNlJINUwxNmk4ekxBd25s?=
 =?utf-8?B?RzRkVzFHTFFtYTRTS3M0dHFVem1OWG8wdEUzUHU4U09HV2lOYzM5UTN4Q2R2?=
 =?utf-8?B?SFEvcW11cDY5bWhOR3hwc0crU3NuZjZXbnpKOHZlK1NSdFBtdXZyZUN6SmJu?=
 =?utf-8?B?YzFvbzZ4cW1yRXNpOVZ0aGpFMDIybVZBRzRRT1EvcUJEUCtYUmlrQktVTkNE?=
 =?utf-8?B?RmY5L2JldXA2ZzN5OHBvVXRFSzFUQ01hNThoS2s1KzU2OUdtSFQrYXhZUHN4?=
 =?utf-8?B?dzVKN2VyRjM0MW0rTll4a3VlWnBSS1RvTnpseGwxbkpZK1FzV0VJWFRrd0Ew?=
 =?utf-8?B?RHBzZUpVVktJL3JaclhibkFVS1B4TlMvK3F5T0VnMXZNTFJBSmp3N1AwY25x?=
 =?utf-8?B?ZDRXaG1iTGVFdmhNbTVockd4aWxRa216MEk0b1c2TDN0emN0SkR2NTBPTklT?=
 =?utf-8?B?SEhXYTYybm9VVWhOZ3BKSWdPUXBxbERqc1BKeVNOZU4vK1lIYngwZzZSWjdZ?=
 =?utf-8?B?aklnaHdyUnpQVmtHT2JmZXV4VGVPS3NPMTEzdjVvS3FGd1o1TXF1NGFPZUZD?=
 =?utf-8?B?RWk2b3h5dTFSajdCSER1TzdLQ2dOcmtCajB2T0pCaE9nditFRW5XRUNnZUR2?=
 =?utf-8?B?NHJGTWJEWjBHb2gvaTVLWEFSdTNHMm1Yc0dWVFRtbkc5WjJMTk1xckg2RU1S?=
 =?utf-8?B?aXZ2bituKzFUMjd5QUpuUHJyL1ZteHQ0eTloditBRW1JYWl4Zi9vckRjamVu?=
 =?utf-8?B?MGQ2UE1qV2JtcXpkajdzdU43UFFxNTI2eG1Hc3ZaRUd2SjJhV0lVeE1sWlF1?=
 =?utf-8?B?Ti8xeTIraHdVOUYwVWpGKy9JMEtFRW0yTjZtTmtjUXRxKzdxNHJpSW96MSts?=
 =?utf-8?B?NXhJWk9yK1dWekQwMGUyWnVKbC85MjF6TElxZi84NHRuTEpmNW0zanJFSnRD?=
 =?utf-8?B?bnFzWG9iZFVKNFFDZklwSkFON2xlS3VpZUNNcTViWk1VRE1hQlg3Z3B3d2xm?=
 =?utf-8?B?cXYzV3l2Rmkva3V1TE9sdnRRVWpYWVFzOXR3M0krUTgycndJUDFiU3hxTmVM?=
 =?utf-8?B?ajFkMDlueng1N3hzWVVJZFpZY0xHL1Q0SDFzME1vWkdOL1BBRjhPNFE2WUIz?=
 =?utf-8?B?YW1kczBOeDU0QzB1aTZxdnFjTzNEMUVPcXVCRzFOamRDcE93K0w1a0U3dWVh?=
 =?utf-8?B?VVJSMHlvbnlLMWNLc3pxYWliREhya2Q4TTIwSXJCK2tZT09jVStOK2ZkVHh2?=
 =?utf-8?B?SlJxREtXRUQxMmdkcEljbksyU0x5KzVSWWg1RkJiRzBwT1dWcmVRMnc1T3lZ?=
 =?utf-8?B?ZkJkTDErTTZ0eStTdHByZWdQdXVaMWxUUi8wVGZ6S3FnZDVpS3ROcmIrRndp?=
 =?utf-8?B?ZlNOdXZWZ01HdzdtNGpuajNaM3E4ZHVRYVV5NHFPdUJ6TlpmNjRYMk1ONUw2?=
 =?utf-8?B?RnZWaTh5WEFjMjZJUC8zRW9zOTBDR0pTNGIra2tsVEJkUURiQ05yNjVpenMw?=
 =?utf-8?B?djVzN0toYTh0bkZ6TmREOVhUU0hyZWdlMUY5ekd3M1llMk56N0VPYVA2aEpF?=
 =?utf-8?B?Sy83VUEzUmdNRDRHSXl6ejBXQlFjSzFadmZrK3JTbjMrTnBzZmVzMW5zYmJN?=
 =?utf-8?Q?SZbQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <014F96A58295274083A174083AC50720@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76152b7c-3a4d-4bba-0d8e-08ddeb2d8094
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 21:04:41.9105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VTANF3uvXrkItF13ecJ/vxJl4Dql8/1cu550nYDx/deo0uzRvpys6HvoXW7wM8j3S6Erw7LZa3SximeOJKdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
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

T24gOS8zLzI1IDQ6MDEgUE0sIE5pcnVqb2dpLCBQcmF0YXAgd3JvdGU6DQo+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+IA0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDMsIDIw
MjUgNDo0MCBQTQ0KPiBUbzogTmlydWpvZ2ksIFByYXRhcCA8UHJhdGFwLk5pcnVqb2dpQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1k
LmNvbT4NCj4gQ2M6IENoYW4sIEJlbmphbWluIChLb29uIFBhbikgPEJlbmphbWluLkNoYW5AYW1k
LmNvbT47IER1LCBCaW4gPEJpbi5EdUBhbWQuY29tPjsgUm9zaWtvcHVsb3MsIEdqb3JnamkgPEdq
b3JnamkuUm9zaWtvcHVsb3NAYW1kLmNvbT47IExpLCBLaW5nIDxLaW5nLkxpQGFtZC5jb20+OyBB
bnRvbnksIERvbWluaWMgPERvbWluaWMuQW50b255QGFtZC5jb20+OyBKYXdpY2gsIFBoaWwgPFBo
aWwuSmF3aWNoQGFtZC5jb20+OyB4Z2xvb29tQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDEvMl0gZHJtL2FtZC9hbWRncHU6IE1vdmUgaXNwIGZpcm13YXJlIGxvYWQgaW50byBp
c3BfdjRfMV94IG1vZHVsZXMNCj4gDQo+IE9uIDkvMy8yNSAzOjM1IFBNLCBOaXJ1am9naSwgUHJh
dGFwIHdyb3RlOg0KPj4gTW92ZSBpc3AgZmlybXdhcmUgbG9hZCBmcm9tIGdlbmVyaWMgYW1kZ3B1
X2lzcCBkcml2ZXIgdG8gaXNwIHZlcnNpb24NCj4+IHNwZWNpZmljIGRyaXZlciBtb2R1bGVzIGlz
cF92NF8xXzAgYW5kIGlzcF92NF8xXzEuDQo+IA0KPiBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5k
IHdoeSB0byBkbyB0aGlzIGNoYW5nZS4gIElzbid0IGl0IGp1c3QgbW9yZSBjb2RlIGR1cGxpY2F0
aW9uIHdpdGggdGhpcyBwYXRjaD8NCj4gDQo+IEhpIE1hcmlvLCBJIGhhdmUgYWRkZWQgdGhpcyB0
byBzaG93IHRoZSByZWZlcmVuY2Ugb2YgY2FsbGluZyB0aGUgZncgbG9hZCBpbiB0aGUgc2FtZSBm
aWxlIHdoZXJlIE1PRFVMRV9GSVJNV0FSRSBpcyBhZGRlZC4gVGhpcyBhbGlnbnMgd2l0aCB0aGUg
YXBwcm9hY2ggZm9sbG93ZWQgaW4gb3RoZXIgZHJpdmVycyAoYW1kZ3B1X3ZjbiwgZ2Z4X3YxMV8w
IGV0Yy4pLg0KPiANCg0KSSBndWVzcyBJIGRvbid0IHNlZSBhIHN0cm9uZyBhcmd1bWVudCBmb3Ig
ZG9pbmcgaXQsIGJ1dCBsZXQncyBzZWUgd2hhdCANCm90aGVycyB0aGluay4NCg0KPiBUaGFua3Ms
DQo+IFByYXRhcA0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQcmF0YXAgTmlydWpvZ2kgPHBy
YXRhcC5uaXJ1am9naUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfaXNwLmMgfCAyMiArKysrKysrKystLS0tLS0tLS0tLS0tDQo+PiAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmggfCAgMiArKw0KPj4gICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5jIHwgMTIgKysrKysrKysrKystDQo+
PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8wLmggfCAgMiArLQ0KPj4g
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMS5jIHwgMTIgKysrKysrKysr
KystDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmggfCAgMiAr
LQ0KPj4gICAgNiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lzcC5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuYw0KPj4g
aW5kZXggOWNkZGJmNTA0NDJhLi45MGFmMzVlZThmNmUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuYw0KPj4gQEAgLTY4LDcgKzY4LDcgQEAgc3RhdGljIGlu
dCBpc3BfaHdfZmluaShzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4+ICAgICAg
ICByZXR1cm4gLUVOT0RFVjsNCj4+ICAgIH0NCj4+DQo+PiAtc3RhdGljIGludCBpc3BfbG9hZF9m
d19ieV9wc3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAraW50IGlzcF9sb2FkX2Z3
X2J5X3BzcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgIHsNCj4+ICAgICAgICBj
b25zdCBzdHJ1Y3QgY29tbW9uX2Zpcm13YXJlX2hlYWRlciAqaGRyOw0KPj4gICAgICAgIGNoYXIg
dWNvZGVfcHJlZml4WzEwXTsNCj4+IEBAIC04MCw3ICs4MCw3IEBAIHN0YXRpYyBpbnQgaXNwX2xv
YWRfZndfYnlfcHNwKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+PiAqYWRldikNCj4+DQo+PiAgICAg
ICAgLyogcmVhZCBpc3AgZncgKi8NCj4+ICAgICAgICByID0gYW1kZ3B1X3Vjb2RlX3JlcXVlc3Qo
YWRldiwgJmFkZXYtPmlzcC5mdywgQU1ER1BVX1VDT0RFX09QVElPTkFMLA0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImFtZGdwdS8lcy5iaW4iLCB1Y29kZV9wcmVmaXgpOw0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhbWRncHUvJXMuYmluIiwgdWNvZGVfcHJl
Zml4KTsNCj4+ICAgICAgICBpZiAocikgew0KPj4gICAgICAgICAgICAgICAgYW1kZ3B1X3Vjb2Rl
X3JlbGVhc2UoJmFkZXYtPmlzcC5mdyk7DQo+PiAgICAgICAgICAgICAgICByZXR1cm4gcjsNCj4+
IEBAIC0xMDMsMjcgKzEwMywyMyBAQCBzdGF0aWMgaW50IGlzcF9lYXJseV9pbml0KHN0cnVjdCBh
bWRncHVfaXBfYmxvY2sNCj4+ICppcF9ibG9jaykNCj4+DQo+PiAgICAgICAgc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSBpcF9ibG9jay0+YWRldjsNCj4+ICAgICAgICBzdHJ1Y3QgYW1kZ3B1
X2lzcCAqaXNwID0gJmFkZXYtPmlzcDsNCj4+ICsgICAgIGludCByOw0KPj4gKw0KPj4gKyAgICAg
aXNwLT5hZGV2ID0gYWRldjsNCj4+ICsgICAgIGlzcC0+cGFyZW50ID0gYWRldi0+ZGV2Ow0KPj4N
Cj4+ICAgICAgICBzd2l0Y2ggKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIElTUF9IV0lQLCAwKSkg
ew0KPj4gICAgICAgIGNhc2UgSVBfVkVSU0lPTig0LCAxLCAwKToNCj4+IC0gICAgICAgICAgICAg
aXNwX3Y0XzFfMF9zZXRfaXNwX2Z1bmNzKGlzcCk7DQo+PiArICAgICAgICAgICAgIHIgPSBpc3Bf
djRfMV8wX3NldF9pc3BfZnVuY3MoaXNwKTsNCj4+ICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4g
ICAgICAgIGNhc2UgSVBfVkVSU0lPTig0LCAxLCAxKToNCj4+IC0gICAgICAgICAgICAgaXNwX3Y0
XzFfMV9zZXRfaXNwX2Z1bmNzKGlzcCk7DQo+PiArICAgICAgICAgICAgIHIgPSBpc3BfdjRfMV8x
X3NldF9pc3BfZnVuY3MoaXNwKTsNCj4+ICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gICAgICAg
IGRlZmF1bHQ6DQo+PiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICAgICAgICB9
DQo+Pg0KPj4gLSAgICAgaXNwLT5hZGV2ID0gYWRldjsNCj4+IC0gICAgIGlzcC0+cGFyZW50ID0g
YWRldi0+ZGV2Ow0KPj4gLQ0KPj4gLSAgICAgaWYgKGlzcF9sb2FkX2Z3X2J5X3BzcChhZGV2KSkg
ew0KPj4gLSAgICAgICAgICAgICBEUk1fREVCVUdfRFJJVkVSKCIlczogaXNwIGZ3IGxvYWQgZmFp
bGVkXG4iLCBfX2Z1bmNfXyk7DQo+PiAtICAgICAgICAgICAgIHJldHVybiAtRU5PRU5UOw0KPj4g
LSAgICAgfQ0KPj4gLQ0KPj4gLSAgICAgcmV0dXJuIDA7DQo+PiArICAgICByZXR1cm4gcjsNCj4+
ICAgIH0NCj4+DQo+PiAgICBzdGF0aWMgYm9vbCBpc3BfaXNfaWRsZShzdHJ1Y3QgYW1kZ3B1X2lw
X2Jsb2NrICppcF9ibG9jaykgZGlmZiAtLWdpdA0KPj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaXNwLmgNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lzcC5oDQo+PiBpbmRleCBkNmY0ZmZhNGM5N2MuLjM2NzUwMTIzZWQ0NiAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuaA0KPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lzcC5oDQo+PiBAQCAtNTcsNCArNTcsNiBA
QCBzdHJ1Y3QgYW1kZ3B1X2lzcCB7DQo+PiAgICBleHRlcm4gY29uc3Qgc3RydWN0IGFtZGdwdV9p
cF9ibG9ja192ZXJzaW9uIGlzcF92NF8xXzBfaXBfYmxvY2s7DQo+PiAgICBleHRlcm4gY29uc3Qg
c3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIGlzcF92NF8xXzFfaXBfYmxvY2s7DQo+Pg0K
Pj4gK2ludCBpc3BfbG9hZF9md19ieV9wc3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0K
Pj4gKw0KPj4gICAgI2VuZGlmIC8qIF9fQU1ER1BVX0lTUF9IX18gKi8NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8wLmMNCj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5jDQo+PiBpbmRleCAwMDI3YTYzOWM3ZTYuLjky
Njk0N2E2MTJhNCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lz
cF92NF8xXzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFf
MC5jDQo+PiBAQCAtMTg1LDcgKzE4NSwxNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlzcF9mdW5j
cyBpc3BfdjRfMV8wX2Z1bmNzID0gew0KPj4gICAgICAgIC5od19maW5pID0gaXNwX3Y0XzFfMF9o
d19maW5pLA0KPj4gICAgfTsNCj4+DQo+PiAtdm9pZCBpc3BfdjRfMV8wX3NldF9pc3BfZnVuY3Mo
c3RydWN0IGFtZGdwdV9pc3AgKmlzcCkNCj4+ICtpbnQgaXNwX3Y0XzFfMF9zZXRfaXNwX2Z1bmNz
KHN0cnVjdCBhbWRncHVfaXNwICppc3ApDQo+PiAgICB7DQo+PiArICAgICBzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGlzcC0+YWRldjsNCj4+ICsNCj4+ICAgICAgICBpc3AtPmZ1bmNzID0g
JmlzcF92NF8xXzBfZnVuY3M7DQo+PiArDQo+PiArICAgICAvKiBsb2FkIGlzcCBmaXJtd2FyZSAq
Lw0KPj4gKyAgICAgaWYgKGlzcF9sb2FkX2Z3X2J5X3BzcChhZGV2KSkgew0KPj4gKyAgICAgICAg
ICAgICBkcm1fZXJyKCZhZGV2LT5kZGV2LCAiaXNwIGZ3IGxvYWQgZmFpbGVkXG4iKTsNCj4+ICsg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9FTlQ7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICBy
ZXR1cm4gMDsNCj4+ICAgIH0NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9pc3BfdjRfMV8wLmgNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0
XzFfMC5oDQo+PiBpbmRleCA0ZDIzOTE5OGVkZDAuLjVlNDNiYTA2NDcwOCAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzAuaA0KPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5oDQo+PiBAQCAtNDUsNiArNDUsNiBA
QA0KPj4gICAgI2RlZmluZSBJU1A0MTBfR1BJT19TRU5TT1JfT0ZGU0VUIDB4NjYxM0MNCj4+ICAg
ICNkZWZpbmUgSVNQNDEwX0dQSU9fU0VOU09SX1NJWkUgMHg1NA0KPj4NCj4+IC12b2lkIGlzcF92
NF8xXzBfc2V0X2lzcF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwKTsNCj4+ICtpbnQgaXNw
X3Y0XzFfMF9zZXRfaXNwX2Z1bmNzKHN0cnVjdCBhbWRncHVfaXNwICppc3ApOw0KPj4NCj4+ICAg
ICNlbmRpZg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92
NF8xXzEuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmMNCj4+
IGluZGV4IGE4ODdkZjUyMDQxNC4uOTc2NmM2MDU2ZGM0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmMNCj4+IEBAIC0zNjksNyArMzY5LDE3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgaXNwX2Z1bmNzIGlzcF92NF8xXzFfZnVuY3MgPSB7DQo+PiAgICAgICAg
Lmh3X2ZpbmkgPSBpc3BfdjRfMV8xX2h3X2ZpbmksDQo+PiAgICB9Ow0KPj4NCj4+IC12b2lkIGlz
cF92NF8xXzFfc2V0X2lzcF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwKQ0KPj4gK2ludCBp
c3BfdjRfMV8xX3NldF9pc3BfZnVuY3Moc3RydWN0IGFtZGdwdV9pc3AgKmlzcCkNCj4+ICAgIHsN
Cj4+ICsgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gaXNwLT5hZGV2Ow0KPj4gKw0K
Pj4gICAgICAgIGlzcC0+ZnVuY3MgPSAmaXNwX3Y0XzFfMV9mdW5jczsNCj4+ICsNCj4+ICsgICAg
IC8qIGxvYWQgaXNwIGZpcm13YXJlICovDQo+PiArICAgICBpZiAoaXNwX2xvYWRfZndfYnlfcHNw
KGFkZXYpKSB7DQo+PiArICAgICAgICAgICAgIGRybV9lcnIoJmFkZXYtPmRkZXYsICJpc3AgZncg
bG9hZCBmYWlsZWRcbiIpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsNCj4+ICsg
ICAgIH0NCj4+ICsNCj4+ICsgICAgIHJldHVybiAwOw0KPj4gICAgfQ0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzEuaA0KPj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmgNCj4+IGluZGV4IGZlNDVkNzBkODdmMS4uYjIy
MWQ4YjgxOTgzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNw
X3Y0XzFfMS5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8x
LmgNCj4+IEBAIC00NCw2ICs0NCw2IEBADQo+PiAgICAjZGVmaW5lIElTUDQxMV9HUElPX1NFTlNP
Ul9PRkZTRVQgMHg2NjEzQw0KPj4gICAgI2RlZmluZSBJU1A0MTFfR1BJT19TRU5TT1JfU0laRSAw
eDU0DQo+Pg0KPj4gLXZvaWQgaXNwX3Y0XzFfMV9zZXRfaXNwX2Z1bmNzKHN0cnVjdCBhbWRncHVf
aXNwICppc3ApOw0KPj4gK2ludCBpc3BfdjRfMV8xX3NldF9pc3BfZnVuY3Moc3RydWN0IGFtZGdw
dV9pc3AgKmlzcCk7DQo+Pg0KPj4gICAgI2VuZGlmDQo+IA0KDQo=
