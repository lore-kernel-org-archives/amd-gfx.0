Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24981E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 15:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6EBF10F129;
	Fri,  6 Dec 2024 15:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYfPeeX3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3BE10F129
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 15:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRD6JUxSZLL9cdLBXn4cBbQMdHx4Ho7q51Y4PCPzGRJyE58HI97ZksdcgK0ZHW6s2OKgIINqgnVCrtqe9aklQDUDEs6jGG2RjJr2We3Z74z3ZyKyy3ONaZ3rp4oVlY7ejARP+M1mVDlFvnh2EwEN1jvLMeXBM9JyXNrgeUYONdW5vIdloX7Rvi/p13r+FCuM0zw1Biv4D62mMZo8D6eNN/VTsPhqb2BDCbIrSkXxzbqsrUHe/NpE9g7EkgRbvR94zrKgV/11EQYKbyBX/m6u8pX/WPbCpnZ+GQp7E3GwQKGuH7r1F1DT5J643BAyFZ8ZBSgbyD3F3XX+a991uhNZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzfT7Uc+wcP6Hj+8mpbhM0Rbd098pSEBwNiYPqw/nCQ=;
 b=xi3HZayEQZGoBkPCCmZ+pKbB8mFzGIVLvgj+Os5tUDg7Pi4UcOd5A5v2dW9Yfsm1DaYGb13ewqNkhsbQQ/vgClVmCK7aRoe0aex/bRSphFO00xUmHNJVJrLawNY3bq8A30E9xq5OjA19UrpkUxULGGAu4PY2Iu0vGFVJWvzAT8ipYKzvxengbDoSLAVSoCPEh5i5N0kGO8SZSicjqg5ZgtBXy51HJK0h6MykMJ9UzR2SijycAjXhxJQ9rZyGWexReVTVb2Ypfl2TyF4fJPBJI2Z7kv2MY//fGZagysQwA8SRCJsfgzj7+bS+2ZdcrAHhm3cIcA+5fSW1wIajLoEmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzfT7Uc+wcP6Hj+8mpbhM0Rbd098pSEBwNiYPqw/nCQ=;
 b=aYfPeeX3aw8ZFnUEW1Ppupd+xuItF2xW/7+jwxJainSz7Xl2qsi9W1cJM2LkKJT3p+Y/o21OHdXoe75dWbaCXrQ2zjXbdxuWIlJl/XVRBwqyF0hWRnUQrD2W7C9uwZ5GQW0grwDswmcQ6DI0zmG4RHUIxCogxAybk0xAhjDlEsA=
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Fri, 6 Dec 2024 15:44:49 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0%7]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 15:44:49 +0000
From: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, 
 "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>, "Li, King"
 <King.Li@amd.com>, "Du, Bin" <Bin.Du@amd.com>
Subject: RE: [PATCH 1/1] drm/amdgpu: Fix ISP HW init issue
Thread-Topic: [PATCH 1/1] drm/amdgpu: Fix ISP HW init issue
Thread-Index: AQHbR1KyizZCnP56YUiOeZtHtDYzurLYq9wAgACxASA=
Date: Fri, 6 Dec 2024 15:44:49 +0000
Message-ID: <CY5PR12MB6429F760B397FF849A9BF0E3FE312@CY5PR12MB6429.namprd12.prod.outlook.com>
References: <20241205201705.578136-1-pratap.nirujogi@amd.com>
 <20241205201705.578136-2-pratap.nirujogi@amd.com>
 <d13e29a4-96bf-4bc8-a898-06eea1b87c78@amd.com>
In-Reply-To: <d13e29a4-96bf-4bc8-a898-06eea1b87c78@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d7d2047f-ff2a-43a3-a88e-15e37cea13d0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-06T15:44:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6429:EE_|DS7PR12MB8204:EE_
x-ms-office365-filtering-correlation-id: 7ac7e94a-583b-49f1-d990-08dd160ceb30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WFFqM3UyeGJuQlUremJDbGJlUzBpVHh0RDhCdFB4RFdkMzlIREF3Nk9ERTlU?=
 =?utf-8?B?bnVYY2xNcDZtbHo4b0pjMCtacjdPbC9ZZEpwSGt1Q3ZJbmZHTU45dExvR0RF?=
 =?utf-8?B?bmx2OXd2Vkh5Vml4Z0E0b2MxVWZDdzRLZEpWdTJFMU9GVGZ4cFRQTFJFTk1n?=
 =?utf-8?B?SmFmSzUyNXNsK2Mxek9lT3g4WXA2UmR0cy85RXVvUUxGeXJJbkFVMGdSZTl6?=
 =?utf-8?B?UWxPQmtUaXNaSFJRVHhEMWNybk9vM0dPY1dhbjlZSFhKMEZSK0huOUkvTitx?=
 =?utf-8?B?c05nUU1JMERGMzVyUnFjVGFRdGh2TGYrZlVqcWlKUjZobW5Pdnd1Zks1d2U1?=
 =?utf-8?B?ZlZFc2ExTG1DdFcrZGNoMDllL2FTVnI1ZDVBaVhOcHZpNXoxWVdqcU5vcXhT?=
 =?utf-8?B?L1FoYlQvZ2NRMzhtaXdYY1NTemtWeFhTSnFhZHd6azIxQjhqUXh5QkJwa3Nk?=
 =?utf-8?B?c2JBeVF2b0V2K1lNNVA4M1pYTUtGbmdwN3lWbUg5aHNxYlhVOTV2cTYyeHY4?=
 =?utf-8?B?S3R6TGRKUGFNRk83OUd5QjU1UjNMb2F2TktWZlZ1ZXYwcVRDcHNpb1JhaTNM?=
 =?utf-8?B?RlIvc2Q0dit2d1BnSVFWSkNndnhWVUQ3RDBGMlRtTklFUGZvRTRpcGhOM29B?=
 =?utf-8?B?aUdFM1dqcncrK2FyYTNKRUpjem9uQjcyTnNVWm1nVHRuc0JROHFremFPRXpE?=
 =?utf-8?B?Zm41cDdPZHV6Q09ubUlGbDJPTkVOOVRlSGlzNUZsL0JqLzBVV3QvNGsxTUlN?=
 =?utf-8?B?dmp0Vko1NHRIVVh0bUQ4YkxwdFVaVEk1dS9pNTlIdnhldldKUGJZVkwwS3lR?=
 =?utf-8?B?WXFMK1FUak9kR3J1K0ZDd2thSTh2SThUTk1iblBlYTNCZUlZYkduOXF5NmlC?=
 =?utf-8?B?bFlsb1drYzNONzU0UU44eFdtejhPeXN4Z1d4b2FWdDViN0gxQnVVSHlLR1hF?=
 =?utf-8?B?WUd0MzYvTTJNaFNsc2x4ci9xTjBDWTAvOGg2OGhNeEhJMVpOUzliSUN3cmhB?=
 =?utf-8?B?S2duaTU2RHQ4bm9oV0lpTW5jUk5MOEZzUGl5RVBYRitLd3A4RGMxdUdUUEFq?=
 =?utf-8?B?azhobHU2ejVvRzdiYjZyVTF0Vnd5THN2eHR6ZDFnTFNxMEhzVkdvbVQ5S1M1?=
 =?utf-8?B?eHlpSVQ1OVplWWc1S0YxRkpuQmh4RzRBdnlQaFJVVDJUc3A3bjdtUnVDaEVt?=
 =?utf-8?B?YTB6L1lwRjFVLzRtSVN2bGk3NnY1VXVYaFJPNmhKYlo2bGcyTHdnU2JkcUN1?=
 =?utf-8?B?MWpsblJTREs3QzJqVCtRbi9yYS9jUUtyNnJtdUpVMmM4T2s1SUM1eHRnTlFz?=
 =?utf-8?B?cXlPdms4a0JNRDRydHZpOERJUmlJbVA4QUh4TS9sMkNUekhNWFBZQllQQ0ZU?=
 =?utf-8?B?OGNJSzZ0NDZsblpjdUpRaytQSkhqcVRqUkNEK3RoNmpoOVhRMDlvQkcwN3hq?=
 =?utf-8?B?OUlWOUhzM09DZkJYZVAyWnF3bENWMFBMRmphVlA0d2pPd1M2ajNYbTFxL3Y3?=
 =?utf-8?B?RnpLNUROM3pleFpoY3N1QXhqNnRMTnI0dmY4TURqMG05b0Qwd1VybDluL0pQ?=
 =?utf-8?B?RDlobFVPYnBaaGNuZ3ZiVkNjVnN6c2hnSENwbEM5cWhtSFdwWmlkSnVZSXls?=
 =?utf-8?B?Q3pzYUdlVXp3bEc4L2lRNi95anBDYVdFYlVSeEJQamlFVzYvcTBsQlRFbmNL?=
 =?utf-8?B?KzIwZTdVU21sUnZ3UUdSN3ZqOW12dDl3dzYrV2JmNUFBMHdicjNZMXhyck9L?=
 =?utf-8?B?U1FYd1hmVjBFbkhGZ25Yd3h5MElCL0tqY0FmNS9JRGV6WHhmY3REVGxYblpm?=
 =?utf-8?B?SkFqRk4yZmRDMlVadlpQMzRzR093bURPMFZQcFNjeEJCd1RFWnZGNGYvQVh0?=
 =?utf-8?B?N0txQ3c4N2hTMmFaVDRMYkFmQnlBQjRJZ2tyb3ZRc21nQ3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djZWMHFTcVE5cy9KWWFGTjErWkNRaFNQa1l2dnM4WHA5WnpZTkJaUDAzYk5N?=
 =?utf-8?B?OWN0NWlnajk3anFGNnpXZi81Q2tlSHRaaG1IR3RWQVJKT3N5SUhTS1ZQM295?=
 =?utf-8?B?UjBTSmJOMDVmYkYvR3Y3elNJMjJOSUhzUnVib1BzK2NJSnBvcDVqWHdDSW04?=
 =?utf-8?B?RU8yZ3QxL2dIWVduaUZIeEJtZFNRQ21NOUlZamYzdjZsZjlndXN0OWZTcnp2?=
 =?utf-8?B?aWhENXpaRjFHaFpUd29QZlR0WnFrWmRyVWQvZW9GbzBHNWIxTHRJd3lmeXR5?=
 =?utf-8?B?VkZ4VEowaFJWN3RTMSt1M29wWjdvSGpMLzl5aUJHTGwxaXlFT09QRml2SnZM?=
 =?utf-8?B?SlV5cFk2dklHdWpjenJ3bHAvc0I3WEtHTzlpVjZvT0wxdTZwL1YvRURqNzF0?=
 =?utf-8?B?MVY4S0FubU05YUZHMkI2QXBtTU9hakZJenlvQzFuS2RCWlhDMERLNUl2MTEv?=
 =?utf-8?B?ZEFxa3Q3QlVKYkxHeU80NGgzdnJ3ajQ0WDNqRUlrTHFGSW5OcExrbTdzNlda?=
 =?utf-8?B?NUtzK1FsaFZPdWlBZnB6QWNtdVBLYzJSYStrd0xMUTkyQ3hjczlnMW5kOXIy?=
 =?utf-8?B?aVVYbERGNnhkcmhOVk84ZE9saVlFMURLeUFlQ3hTSHlOTkxKZkxXSkNMRzho?=
 =?utf-8?B?WlZGT0RXL0VHY3FVZGtORis3WXhmSnhKWS9XMS9VT1lWdDhMWlVQMHNBTm9M?=
 =?utf-8?B?b0N5OVY3VVJCUVE2d3M5a0taT0xhck1heGlPVE5VTnFtRFdxOWRheDZQeldz?=
 =?utf-8?B?Z3FsdlFjNFVmOTdqbTlSd29zYkd3cXpIUFpnTzdPRVIwYkxRNmlnMUZNZU9s?=
 =?utf-8?B?YUZlMXR6NXJwV2cyclZ2bk1NaXZQK1hCeEw3MHhTdnFCc3ZDVituY3hYdlJX?=
 =?utf-8?B?cHZmK3ljQ0lTYkcxbndzZWJsblRwYWVpbnRJK01lWnRGcVFaR2dDSjJnQ3Bn?=
 =?utf-8?B?b3NMR1g2Z0t3a2RheTU5QUFXK0h4TUN5anVDZC8rWGdhM0N5c1N5UExjMnFZ?=
 =?utf-8?B?elI1NWowSzRBWGgzVFVhSERURHdCV3BLbi9ORmVQeitPeXIvRjBLclhVSXQr?=
 =?utf-8?B?UFFRL1NvOHk2blBPajM0cjV4RUJDNzkzRTUvSWVlR1Mxc05HRnpNK1owQlRP?=
 =?utf-8?B?NkJReEcvcHRHcm5nMVd6L1cvL3lrdWJyQVpmVEhRS25HZGVwbWlRRkhmS1py?=
 =?utf-8?B?eXo1em9OSU5Ja25mc1hOYkRQbnQvNDE1U0M4bUZyb3Vkbk5ndUpqd0p1MjV2?=
 =?utf-8?B?SVI3QVJsazRDVk13RW1tMjFFdndFY1JycGI4eVFtYlhMM1doSDlTTVpDUEMy?=
 =?utf-8?B?b2xMQldwTmREbG5tQTBvTGdYNzllUHBpaEVwMmV4Z1k5WkwvMWhuZjJIRzF5?=
 =?utf-8?B?UitLUUVsNlEya0lYS2V5RWt5aCtpZm5kTjhQVVNlLzcrWS9VbFpGaUNNbUNR?=
 =?utf-8?B?VnNEYXE0ajgzZEtYYXREcWZScm13UWZVMFV4bzhiTmc0VHFyc1Vva1Q0UnJP?=
 =?utf-8?B?clNXWTlrU1l3MXpjNmwrMm5PZmxFcDQ4MklDQmtOVG8yMTMvT2U0UlRqUlVq?=
 =?utf-8?B?QytCTVMxQjV6cGxYNUpuNGdMMHZMeEErcUQ4bnUwNWpCYmZxY3pVSTFiclkz?=
 =?utf-8?B?TUUxaG40QWZmR1pLSEQvWG1WU3NOWmhSVmNFbG9zaDZZWlR1ZDI3ZmlBYnNP?=
 =?utf-8?B?NUZwVkc5YW5yUnJNemV0Q0NPNldCeEVqYW1tcUdBTW1HWjdLTVFnZjgvS3FK?=
 =?utf-8?B?MzJLWTdROHNKNE5ZSVpnbXpBcGNVTWFDb0h1YVpaYnY1Vzl3d0RidmQrQXR4?=
 =?utf-8?B?eWdNZFo2T1QzZlEzV09rN1kyWGQxNEp6Q1pVY1dma2tPRFZYenl1NENDQW5M?=
 =?utf-8?B?OVFjVVJGdDBHcFJML21RNHJxVjIrcGxjejBDZXRrTHJIUzNBZnJmMFZTaWhO?=
 =?utf-8?B?TGZ5bEI2ejM4aGlDTFpFUnZQaXNBTEE3OXFDV3NLS0xFNkdwUTd6ZS9ibjN5?=
 =?utf-8?B?MGt5THZxWVg5VzJLQThKVm1DcE5nbVJwM0JiWE5FMmVoNFJ6dTk5dm16enJI?=
 =?utf-8?B?Qjd4UjZIRFhCOUZ0eGZibmFpMlp0Q1FrWE5aTk05RTVyM3ZWeU5jL1A0eU9H?=
 =?utf-8?Q?KkpY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac7e94a-583b-49f1-d990-08dd160ceb30
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 15:44:49.7313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVsYRhXegOzq6U+YiF+GCpQXRYITxkERmqVXBxvZ6Iun3etyijJrdWte7rWV49LK/8RXKkD9jPfyxqZq5v24kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhhbmtzIExpam8uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBEZWNlbWJlciA2LCAy
MDI0IDEyOjExIEFNDQpUbzogTmlydWpvZ2ksIFByYXRhcCA8UHJhdGFwLk5pcnVqb2dpQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+OyBDaGFuLCBCZW5qYW1pbiAoS29vbiBQYW4pIDxCZW5qYW1pbi5DaGFuQGFtZC5j
b20+OyBMaSwgS2luZyA8S2luZy5MaUBhbWQuY29tPjsgRHUsIEJpbiA8QmluLkR1QGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gZHJtL2FtZGdwdTogRml4IElTUCBIVyBpbml0IGlz
c3VlDQoNCg0KDQpPbiAxMi82LzIwMjQgMTo0NiBBTSwgUHJhdGFwIE5pcnVqb2dpIHdyb3RlOg0K
PiBJU1AgaHdfaW5pdCBpcyBub3QgY2FsbGVkIHdpdGggdGhlIHJlY2VudCBjaGFuZ2VzIHJlbGVh
dGVkIHRvIGh3IGluaXQNCj4gbGV2ZWxzLiBBTURHUFVfSU5JVF9MRVZFTF9ERUZBVUxUIGlzIGln
bm9yaW5nIHRoZSBJU1AgSVAgYmxvY2sgYXMNCj4gQU1ER1BVX0lQX0JMS19NQVNLX0FMTCBpcyBk
ZXJpdmVkIHVzaW5nIGluY29ycmVjdCBtYXggbnVtYmVyIG9mIElQDQo+IGJsb2Nrcy4NCj4NCj4g
VXBkYXRlIEFNREdQVV9JUF9CTEtfTUFTS19BTEwgdG8gdXNlIEFNRF9JUF9CTE9DS19UWVBFX05V
TSBpbnN0ZWFkIG9mDQo+IEFNREdQVV9NQVhfSVBfTlVNIHRvIGZpeCB0aGUgaXNzdWUuDQo+DQo+
IEZpeGVzOiAxNGMxMWI3MTk4NWMgKCJkcm0vYW1kZ3B1OiBBZGQgaW5pdCBsZXZlbHMiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBQcmF0YXAgTmlydWpvZ2kgPHByYXRhcC5uaXJ1am9naUBhbWQuY29tPg0K
DQpSZXZpZXdlZC1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KDQpUaGFua3Ms
DQpMaWpvDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Yw0KPiBpbmRleCA3MzVhMDFjNThjZDcuLmI1MjA4YTE2ZDdkNCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtMTQ0LDcgKzE0NCw3IEBA
IGNvbnN0IGNoYXIgKmFtZGdwdV9hc2ljX25hbWVbXSA9IHsNCj4gICAgICAgIkxBU1QiLA0KPiAg
fTsNCj4NCj4gLSNkZWZpbmUgQU1ER1BVX0lQX0JMS19NQVNLX0FMTCBHRU5NQVNLKEFNREdQVV9N
QVhfSVBfTlVNIC0gMSwgMCkNCj4gKyNkZWZpbmUgQU1ER1BVX0lQX0JMS19NQVNLX0FMTCBHRU5N
QVNLKEFNRF9JUF9CTE9DS19UWVBFX05VTSAgLSAxLCAwKQ0KPiAgLyoNCj4gICAqIERlZmF1bHQg
aW5pdCBsZXZlbCB3aGVyZSBhbGwgYmxvY2tzIGFyZSBleHBlY3RlZCB0byBiZSBpbml0aWFsaXpl
ZC4gVGhpcyBpcw0KPiAgICogdGhlIGxldmVsIG9mIGluaXRpYWxpemF0aW9uIGV4cGVjdGVkIGJ5
IGRlZmF1bHQgYW5kIGFsc28gYWZ0ZXIgYQ0KPiBmdWxsIHJlc2V0DQoNCg==
