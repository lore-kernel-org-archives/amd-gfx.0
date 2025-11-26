Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C693D10372
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 02:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A2110E4F2;
	Wed, 26 Nov 2025 02:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g+9LFmrF";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1094910E4F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 02:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpeVBAzoh3epEz0XErzr0tOkWQCTvcFWeuA0WT6OH0wT0qS2tdNUbCjH6jaNePbGgcsBcEo5Z6hwA7l7GA5PVoW8hfphtH2Pl6/T3RyHiZJQwDIUV0wj1TZMVj8YiohpOjQjj/fnE6Ic72cKliKmYk1j0i4lqog79/7EblcQKz6D8VaeMIRkOyr0xGHBbTVGIgjnKMN+NE1GIbO5bvwS8eKrG9rxL5bSOY3IQIn2R3aNr57YhH/Mr6JEiEL4CbBaiGfseCQXDkC6NkXuzBs3O1DPF6to2IIKOm0wGGoEpk6r+nX5cwHzPvea6zUbc8EC2kxrs0Nfot9zzKXyWX2clQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRe3ZMW3kGcou7mVuw7Cb7RhKuQQKpNwY8ol+up0Xf8=;
 b=ENgcVLHagdTNNSiN2n2zKn+WxmVuURTzdwurTwUnOK1q4TFxAQwHUeF29nkeLMOOBWynAYB0kjr/ikE+hLbHsqZ1BQRTzPhPX/4kx5vIlklf925dOp1TRAUFClaMajpPWiZ/r7B0leVFKaOdw4LNzNGD2zFrDx3qTg1YEp4g5Nq7sWIiERljt95agHkTEtWY/FqdMk0ghbLBUEMIQgCXvR1KBY1nzTGX3sXTzNeg3snjuQj6e/c/TDQwWi8dFlWoAV3Z0T/eRJSRxucOvkNvbkQsiBkoBkXqTRiagvigShxv8m9Kj7lWFRPGQzxKVPE5KBBYFO6kdA2XHrLCFQOZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRe3ZMW3kGcou7mVuw7Cb7RhKuQQKpNwY8ol+up0Xf8=;
 b=g+9LFmrFB7VFgitaQNN0I6UkCNXUQoCorSxx0w6T7VFDfzcwCeigPhRnr7qRYiCcpRkYEiN4ioHLD13kAIv1ldRXjxouNrfHuN7MQDJOtybBvDJygilnyN5vSgUd0vKH0W8m7CBShN2Cw844NkSEkLhgBWVq9o5i95k+kGwFSPc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 02:18:38 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 02:18:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu/sdma6: Update gfx11.0.3 SDMA FW version to
 include UMQ protected-fence fix
Thread-Topic: [PATCH v2] drm/amdgpu/sdma6: Update gfx11.0.3 SDMA FW version to
 include UMQ protected-fence fix
Thread-Index: AQHcXiQrps8nlUEjJkCQN+KVSnvDz7UDngyAgACaxvA=
Date: Wed, 26 Nov 2025 02:18:38 +0000
Message-ID: <DS7PR12MB60058FBBBB7F27C8DCACDF55FBDEA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251125155331.222776-1-srinivasan.shanmugam@amd.com>
 <20251125155648.223100-1-srinivasan.shanmugam@amd.com>
 <CADnq5_OP9m0jc026bm3qtOzAwtZPaaVgE_p2tfvK6bBnzho76Q@mail.gmail.com>
In-Reply-To: <CADnq5_OP9m0jc026bm3qtOzAwtZPaaVgE_p2tfvK6bBnzho76Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-26T02:15:46.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB9101:EE_
x-ms-office365-filtering-correlation-id: a6ef3f8d-9827-4126-5533-08de2c921c5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YVNEVHYrVVJaTm9rZjFjZWE2bTZLMXdQQ2NZcGxGeUZyNzc1aThRRGI0aEho?=
 =?utf-8?B?VmZJU0g5TEt4eVA2cmNqRDJhTnNsUWJTaVVOTGowRlFUeTJOTzdnZm44R3pI?=
 =?utf-8?B?MTZ6OTQ0Mk42eFpIcE9DaGowMnUxSEowaisrQzlneUwyaTVzeS9yT1pzd1NB?=
 =?utf-8?B?bWsvU3hGKzdlaWk4RjJwL3gxZDd6dStRMHA2WXRzWHVJM0NDWE9HUVYrUHpk?=
 =?utf-8?B?Y0twSjBoY1NyOHNMdVN5ZVJieFlTUVBZeXNwUkRRVTI2SzZsMmJxNGhXWUly?=
 =?utf-8?B?cnk0T3ZoVllIbTFlbnplUEt4RHNGdjJJME1nUXdvRDlHL3VrRjFLT3BRbU91?=
 =?utf-8?B?Q1dsSkhDOGt5NUJuN3dLbmRJWGpJTCtBMm5hQnh6MzIzQVRtelJudU9zSVFP?=
 =?utf-8?B?bXdPN096blZjMjR2aTVFVU13aTRyVXJMYUVINlFlZFhJSExXbkNVOFc2cUlO?=
 =?utf-8?B?OExVSy95dHZKc0xKWllKSzdOaER4b3lPQ2RUR0xoZTZpeUFQclVVN3BoSlFv?=
 =?utf-8?B?dHV4ajQyOWtqRW5ob2dFNGZTY3Z3UEVIWFk1dUtJRFRHa2tiR0xYOVhPOUhw?=
 =?utf-8?B?Rm9MTC9Dcm11N3VSY0VKUmNnd1hoeDM0TytxWGoyUkFrRXdrblVnMnBZT0xF?=
 =?utf-8?B?cndhU0hNcVU2Tkwvdzl4Q0w1aVo0NEhaVGRPMk9uMkl0MnJPY2wxNEUrV1pZ?=
 =?utf-8?B?M0ZHdWlyb2NmcjFYOFpIL0R5aCtId1AxQVFUbUwwNld1OXFyL1FxRnZxaUlU?=
 =?utf-8?B?WGlQVUtXTGw0a1NkT0NQcGxDNVI1ZnMvWUFCd2JjeldxbGgzM200VWNoVHcz?=
 =?utf-8?B?a1k5VHpKZHF4b0ZudXlNTzZMMmthcGVJTmZVanBrQnNXVzFBKzhJZHVneDMx?=
 =?utf-8?B?endsTjJZQjFyanVOZlo1VHQwb3Rnc3ZUSkdDUEpuTmF0czNXaXEwTTlaamth?=
 =?utf-8?B?bitadDdHV0FZL2Qyck1VREM0N0todmJBVGlBd3VCU0pTQ1lxbi91QTZkTTBu?=
 =?utf-8?B?MDZ3YmJwTUZJNStWRWRxVHdyQVFRSzYzcXBqa0FMS0YzR3VDbzl1VlFEaUMv?=
 =?utf-8?B?NURMTEtIVVowZFVYWUxFVDZrb2JaTitBRmwydHBEcGZuNHB2N28wSWRnOFFz?=
 =?utf-8?B?a1RZSHkvb0puK2owZEczQUI1cXAzdGNqVGlYWktsTFRJNVFyWVZLaGkwRlFS?=
 =?utf-8?B?OFUwR3lqQnlrczRidkNjclJ1VS9LalNDS3ZmV0dDeVFLMEUxTlZWVkRIK241?=
 =?utf-8?B?N01JOGlJSzl0VmkzY1FYSXlkelFMakZ4M3RSdXpsbjRDQUVmNzE3cVdOR3lU?=
 =?utf-8?B?YUZDTUZkQ3RjR3krSEYxNzBpQzF4VWVTSjZ1RXY4ZnJ0YlJMUng4ZnBSb0Jj?=
 =?utf-8?B?ZXd5YWhLMG9LTVd4ZzQ1SjhiVzN4eGx2Y1FzQ0U3TlBaSXVIZHJjV3RVNTk2?=
 =?utf-8?B?b3FtVVNIUW1zREJGM0YwR1J4VXFZYUppcmpXc0ZXNDBzNjZrWEx2OUQ0VWhS?=
 =?utf-8?B?d2o1L0tLc2Y3ZDNxY3RpbDVjN0tLbnFDSjgwRkN5bFhYQTBtZHgweXdMSkZw?=
 =?utf-8?B?T3Z3Z05CVTdNeUNhUWtoY1NRQmxLbDlza2twN2xWYTJxQnZSQVpacjJhanda?=
 =?utf-8?B?MVNrTmtybkhGa0FDS1JOam5ZaVBHOGtEWUF3YjJ6SVRFZHl6c2tUcHRla2dt?=
 =?utf-8?B?Mk8yWnBYem9jWnpnS3VPdUFEWmZKaTMyZDdhd2g3dzNZUzUydTNsQmZ4dTFQ?=
 =?utf-8?B?R0hnbXo5SFM0NGpMa3lJMmhtL3JGbU5jeWtjV2NuRWpwcWRIVEVlQ1NrWDgx?=
 =?utf-8?B?SXpQck5nNEd3cStWTUIxSk9ZRk9oRkVTaXMyNmJZNTlIRkltNnBnQ2JhQkNI?=
 =?utf-8?B?ZXNYQ3JLSU93aW9LTVVNaDM0YVhURmZwcjhRb2RXODdvbjQxSFl4UVhuVkU0?=
 =?utf-8?B?dnpadDZlYnJtWUJqWmM4K00rdTBnYVNxQWZZeFBBTlMrRzgxR0dNc3VaQ1Jw?=
 =?utf-8?B?NnRla3pxQitFaVRlbjlzT09NRGY0SDJza3dZbnN3Q1FEb2RpUFNoeUZoSisz?=
 =?utf-8?Q?/kVI7l?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1YzSUxFdjZ6WE9DMlFKaHhJNHRXSjVudFJEci9ldEluNGlmYk9WRlZENHhW?=
 =?utf-8?B?RDh3MHRtd2s1Z2REbVZFQ3FHVjdaZEp1MzhIVzN5QVF0YXdhWjVkWEZ6V0cr?=
 =?utf-8?B?clBqWmxvdkpYcUxYaHVWWkJmRzZodHJHSCtWMEs4aEZyRTZud0J2dUZJYVVr?=
 =?utf-8?B?SmhOc1ZraDFyMU5TamNvb0tFOHkxNFRkdUtXTWNWK2hkVW80NHdabksxVkV1?=
 =?utf-8?B?ck8vV2JCYzYzZ216WHJyang1aGpEaHhGUjRUd0dhZWNWVFRhakhrSnFmUUFR?=
 =?utf-8?B?OUd3MGRnd1BBMGV4WDNCbnAzREV2T3hocDREL0xHNWo0WkFFZWdwM3d5M1hQ?=
 =?utf-8?B?ZEljakZoOVdJTHNjUnBDWXNTRWVsanZLQllNUndkUHY0Q2FRQTNqcXpRa09F?=
 =?utf-8?B?TVZ6SjFxTGN1bUlabFBwMmZrR1hGZWgwYzVxN01aVVlBMUE2blRSTzRyczVZ?=
 =?utf-8?B?dDlWOXdGcFBkNU1iV0lYcy9RVThvV0dHYmZuTFRhOXIyTkNRSTAwOEt1ZFZH?=
 =?utf-8?B?NStseHRWNjVzZlppNjhvSCtwZXZZMWJQUDFJdVBUOVhVbGJzSW9kK3NsWi9H?=
 =?utf-8?B?QUx0L2p0eUFVeFNrSGI0UHROSjhvMTlqUW9nc0JHaFFSMGxPL0NIclYvZDlm?=
 =?utf-8?B?a25kcmlOTlhnd2xjWEZZcWY1ajNrbkxzZEFTdUJkdFhxTWxmWUE5R0pjbkIx?=
 =?utf-8?B?c1RyVkZLc1FlNklnbkh1Z3JMN3RoTU9ZMnFYdGVKTjYxRGsyNVdiSTFzUE5E?=
 =?utf-8?B?Qld4K0ZvcTM1di9uM2hkVlo0YTE5OWczTEg1d2ZCZ1krN09JUFFBRm8xaWZN?=
 =?utf-8?B?Y1ZhZDNpTVpycGxmWEwzMzRDb2lVQmJWRVNoaU9PcVg2bFlDNnNna0xVZmVR?=
 =?utf-8?B?OHF6LzdJTzV6bzVJdThLM1NIUUVLNTNUWXgvWkZzbnVCRWdJY1ZyaXVWbWlq?=
 =?utf-8?B?eXlWYnhiV3R6b1RLdGlQZm11SEFnTEpDK01YZ3VuYmFNci9tNUxXSjhKVE5X?=
 =?utf-8?B?Nzh3U3hwdlFpelBIMkpia3diNzIraVhxczhJeXpNaVJOR0dzeE05Z3g0MG1x?=
 =?utf-8?B?NkQxb3NKZHFkbkg3SmU0NjZqODg3MFdCZ1VWelRkdTBOOERLRXlNMlVmTVV5?=
 =?utf-8?B?U0JTN1FKZ1FsVFpBQXRwcGlXTXBYTFlYM0JyaDBxL3lqWkdYak1RUGxTZ0dF?=
 =?utf-8?B?YWxkTXpyUXEreVF2dUh1RmkvVG9CbDN3aWNjM2pQYVg0MHJmdWFKR094WElK?=
 =?utf-8?B?WjBSWjZJNkNsTHFhRFFhb1M2R3JpZ1dEcit4djlDVnVxendrY1pJbWZhdXM2?=
 =?utf-8?B?MHpjcGF0Uk5nVlVoYXRUYnBQdXYxNWVuVVBGLzg2ZFhEWXBjMzlXWlFOOHF3?=
 =?utf-8?B?QmlJV3YvRHY4VVhsL3FRZ0ZkWXk1Q2dBaWVlWEFKa0xNVVhqbWNGUmlkU2E3?=
 =?utf-8?B?V0hpYnE4WkV6RlNkRGw1L1ozYmtCWGtxOVNxaDZCNjIvVDZsLzdBQkVoWGgx?=
 =?utf-8?B?NHVzNFk3V2hxZ29IeWtjdVJNSzl3blJXckZjaDVYSEU3TmNrR3ZrbkgxaGNL?=
 =?utf-8?B?c0RtUCtReHg1bzk5d09LcEE4Uis5bWJjRmRSQmI2VnRqNXQ0b3NLd2owTURU?=
 =?utf-8?B?L3lidDZoREZncXE4YUk3YzhHQ1ljK0dZYU0rT0hrUTlVd1NOSGw5RWIzOCtG?=
 =?utf-8?B?ZW1jQ0dOT2ZTOEc0RnYvNDJxN1Y1WlcyN3YvTjhoZ1NveWlkcGJ3MlJRUWNp?=
 =?utf-8?B?SkEvY1k4MXN0WWVuV0E5emltOG1NRzBuQjdaSWxmMHAzcXZ1R0NVUDQyU3hs?=
 =?utf-8?B?ZVNWNlhuKzdsY0FoL1JCenhudTUzcjRVRGVma0wvUkRqRzNHZUlqZVJwUFdY?=
 =?utf-8?B?S1VpeGtmUTJSVDlRY1NvODdhQ0pMWmdHZjNDcVhOYThpdnlLUUFGd1BpeWhR?=
 =?utf-8?B?S1A1WDVERFk1aklOVUY4eHh0MXBiSURrUW9zWS9yQnRORnJVTGs2UVc2WHRO?=
 =?utf-8?B?MzArbWdUWkwveXJseWpmZzdIa0NrK2RnNERocWFONWd4dWpDYmNqOEZOUW9S?=
 =?utf-8?B?cFlGNU14bnNMZW5BVCtNUlBxVVBCeDEzbFNFQWhsZTJ2cEh1OUp5ZUp0WG9C?=
 =?utf-8?Q?BeSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ef3f8d-9827-4126-5533-08de2c921c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 02:18:38.5819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPw6bBQrs3vXUxEgQLYFO/ed0gcvXobL4t3VNZivdnDnnQZPbl5B32oR1FH/wPFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101
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

W1B1YmxpY10NCg0KV2UgbWF5IGhvbGQgdGhlIHBhdGNoIHVudGlsIHRoZSByZWxldmFudCBmaXJt
d2FyZSByZWxlYXNlZC4NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDI2LCAyMDI1IDE6MDIgQU0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklW
QVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gQ2M6IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1L3NkbWE2OiBVcGRhdGUgZ2Z4MTEu
MC4zIFNETUEgRlcgdmVyc2lvbg0KPiB0byBpbmNsdWRlIFVNUSBwcm90ZWN0ZWQtZmVuY2UgZml4
DQo+DQo+IE9uIFR1ZSwgTm92IDI1LCAyMDI1IGF0IDExOjE04oCvQU0gU3Jpbml2YXNhbiBTaGFu
bXVnYW0NCj4gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
T24gR0ZYMTEuMC4zLCBlYXJsaWVyIFNETUEgZmlybXdhcmUgdmVyc2lvbnMgaXNzdWUgdGhlIFBS
T1RFQ1RFRF9GRU5DRQ0KPiA+IHdyaXRlIGZyb20gdGhlIHVzZXIgVk1JRCAoZS5nLiBWTUlEIDgp
IGluc3RlYWQgb2YgVk1JRCAwLiBUaGlzIGNhdXNlcw0KPiA+IGEgR1BVIFZNIHByb3RlY3Rpb24g
ZmF1bHQgd2hlbiBTRE1BIHRyaWVzIHRvIHdyaXRlIHRoZSBzZWN1cmUgZmVuY2UNCj4gPiBsb2Nh
dGlvbiwgYXMgc2VlbiBpbiB0aGUgVU1RIFNETUEgdGVzdA0KPiA+IChjcy1zZG1hLXdpdGgtSVAt
RE1BLVVNUSkNCj4gPg0KPiA+IEZpeGVzIHRoZSBiZWxvdyBHUFUgcGFnZSBmYXVsdDoNCj4gPiBb
ICA1MTQuMDM3MTg5XSBhbWRncHUgMDAwMDowYjowMC4wOiBhbWRncHU6IFtnZnhodWJdIHBhZ2Ug
ZmF1bHQNCj4gPiAoc3JjX2lkOjAgcmluZzo0MCB2bWlkOjggcGFzaWQ6MzI3NzApIFsgIDUxNC4w
MzcxOTldIGFtZGdwdSAwMDAwOjBiOjAwLjA6DQo+IGFtZGdwdTogIFByb2Nlc3MgIHBpZCAwIHRo
cmVhZCAgcGlkIDANCj4gPiBbICA1MTQuMDM3MjA1XSBhbWRncHUgMDAwMDowYjowMC4wOiBhbWRn
cHU6ICAgaW4gcGFnZSBzdGFydGluZyBhdCBhZGRyZXNzDQo+IDB4MDAwMDdmZmYwMDQwOTAwMCBm
cm9tIGNsaWVudCAxMA0KPiA+IFsgIDUxNC4wMzcyMTJdIGFtZGdwdSAwMDAwOjBiOjAwLjA6IGFt
ZGdwdToNCj4gR0NWTV9MMl9QUk9URUNUSU9OX0ZBVUxUX1NUQVRVUzoweDAwODQxQTUxDQo+ID4g
WyAgNTE0LjAzNzIxN10gYW1kZ3B1IDAwMDA6MGI6MDAuMDogYW1kZ3B1OiAgICAgIEZhdWx0eSBV
VENMMiBjbGllbnQgSUQ6IFNETUEwDQo+ICgweGQpDQo+ID4gWyAgNTE0LjAzNzIyM10gYW1kZ3B1
IDAwMDA6MGI6MDAuMDogYW1kZ3B1OiAgICAgIE1PUkVfRkFVTFRTOiAweDENCj4gPiBbICA1MTQu
MDM3MjI3XSBhbWRncHUgMDAwMDowYjowMC4wOiBhbWRncHU6ICAgICAgV0FMS0VSX0VSUk9SOiAw
eDANCj4gPiBbICA1MTQuMDM3MjMyXSBhbWRncHUgMDAwMDowYjowMC4wOiBhbWRncHU6ICAgICAg
UEVSTUlTU0lPTl9GQVVMVFM6IDB4NQ0KPiA+IFsgIDUxNC4wMzcyMzZdIGFtZGdwdSAwMDAwOjBi
OjAwLjA6IGFtZGdwdTogICAgICBNQVBQSU5HX0VSUk9SOiAweDANCj4gPiBbICA1MTQuMDM3MjQx
XSBhbWRncHUgMDAwMDowYjowMC4wOiBhbWRncHU6ICAgICAgUlc6IDB4MQ0KPiA+DQo+ID4gdjI6
IFVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UNCj4gPg0KPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdh
bSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Nl8wLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjZfMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3Y2XzAuYw0KPiA+IGluZGV4IGUzZjcyNWJjMmYyOS4uNDk5NmQ2
MDc1MWVmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFf
djZfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92Nl8wLmMN
Cj4gPiBAQCAtMTM5MCw3ICsxMzkwLDcgQEAgc3RhdGljIGludCBzZG1hX3Y2XzBfc3dfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrDQo+ICppcF9ibG9jaykNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBhZGV2LT51c2VycV9mdW5jc1tBTURHUFVfSFdfSVBfRE1BXSA9DQo+ICZ1c2VycV9t
ZXNfZnVuY3M7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgY2FzZSBJ
UF9WRVJTSU9OKDYsIDAsIDMpOg0KPg0KPiBDYW4geW91IGNoZWNrIGlmIG90aGVyIElQIHZlcnNp
b25zIG5lZWQgc2ltaWxhciB1cGRhdGVzPw0KPg0KPiBBbGV4DQo+DQo+ID4gLSAgICAgICAgICAg
ICAgIGlmICgoYWRldi0+c2RtYS5pbnN0YW5jZVswXS5md192ZXJzaW9uID49IDI3KSAmJiAhYWRl
di0NCj4gPnNkbWEuZGlzYWJsZV91cSkNCj4gPiArICAgICAgICAgICAgICAgaWYgKGFkZXYtPnNk
bWEuaW5zdGFuY2VbMF0uZndfdmVyc2lvbiA+PSAyOSAmJg0KPiA+ICsgIWFkZXYtPnNkbWEuZGlz
YWJsZV91cSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT51c2VycV9mdW5jc1tB
TURHUFVfSFdfSVBfRE1BXSA9DQo+ICZ1c2VycV9tZXNfZnVuY3M7DQo+ID4gICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiA+ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDYsIDEsIDApOg0KPiA+IC0t
DQo+ID4gMi4zNC4xDQo+ID4NCg==
