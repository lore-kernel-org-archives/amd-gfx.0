Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAE606A33F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s7sK5c+/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD2F10E8D0;
	Tue, 17 Nov 2026 13:39:21 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17BF10E477
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 13:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHX5T9SzxDlPfN2Jwxhb7De8HM8ynK9N07arw4Z+oHM0Dx3PBtIysuFdgwSWooPeJYx+nMZxOCbW011yPW+3qp+wrSSyYTzGfgE4Nte28hMn5C6wJp6cKDgpj2oZGhEuTiJKzty+GP3mhhqkgZmv8g6qVT/ljiQHluoKLLAFeluXJhFdD0BQxjKz4lKA1CAFDRIEpnaDJrfxYlNcH6koPuj7OrH9fXzoi1nv3U6mG73qvqOEP+H7Jfm3jpPjYBTAecRKSb6/gEXyEuzI0SkBe94O2nryAzl8uh9W4rPPoyj9uTeCSkHLGUU/r38oUQ2HrbBVtWnkFPHeGyBcQEPu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxHfbjK4wGmrNadHgDKoauGE0VfHH+veYBD9iaeRYkw=;
 b=prpFXMdzDyVPlSehk0dgxmo0K6lzRLEYK3CwGbHurTqas9uTkZ3hxh2bFYX8LXK86j5tgZzwGbQ9lLI5MpCv+ZK8GjwBqSTEfqCyzI/GhLf4TtbTQgKnw/Y/yjBg04sG3GO2z1LEyn4VwqooUxl4Nzpc4S9C/f9Z85t76AEClnpE6oRCHrFQi4GWNFcz1CCfl9q0xR/MYIPCswXpLVg60R7EWcfpEnCUXGjvJtlXweoeIqnIcx87FWKW1uLdfeIQzdzPru8BobB/t317+wjICG1mXlzaeRKCi9WrXFa85V4W1Mp7WGXJ3x0Abhi2tjBdFzsUWn/qOguq3PoTcn97oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxHfbjK4wGmrNadHgDKoauGE0VfHH+veYBD9iaeRYkw=;
 b=s7sK5c+/N2YWhINCwIgpzD000Pqtsdu8LCYfuKovVkVAr5iK9N4tjU3GRdb7PMtej+3ACndx9n5GO9VEOhd7XnHm6HxPSzedUkAXNU/93pkoJWdyjj+T1y2sXz++lpGXs6Z9idz0PFBEv6GdFRdJz43XYFNk4iAh/jYj2b8Gcv8=
Received: from SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13)
 by LV0PR12MB338367.namprd12.prod.outlook.com (2603:10b6:408:3ed::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:39:11 +0000
Received: from SA1PR12MB7152.namprd12.prod.outlook.com
 ([fe80::38d1:d01a:aed2:5052]) by SA1PR12MB7152.namprd12.prod.outlook.com
 ([fe80::38d1:d01a:aed2:5052%6]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 13:39:11 +0000
From: "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
Thread-Topic: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
Thread-Index: AQHddgq8k6edsc6iMkiIJuA4Q754FLcyAlSAgABCLcA=
Date: Tue, 17 Nov 2026 13:39:10 +0000
Message-ID: <SA1PR12MB715234880D4B3AEDAA1AFF72F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
 <5e22b2e1-2379-4583-968f-78217ce5525f@amd.com>
In-Reply-To: <5e22b2e1-2379-4583-968f-78217ce5525f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-17T13:33:56.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7152:EE_|LV0PR12MB338367:EE_
x-ms-office365-filtering-correlation-id: b76e9076-7952-4a01-5b8a-08df44b02970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|261009223027099003|18002099003|22082099003|261026140227099003|261026121527099003|261022075727099003|261021121427099003|261102123227099003|261028144727099003|261022105027099003|56012099006|4143699003|10067099003|5023799004|11063799006|38070700021;
x-microsoft-antispam-message-info: E3GkiHNOUks6J+7mhntWOcmRiJsQLW3mgjktqgshRi6bpDkdOqhtozlr06Qq+WmiLpaXeMO8PY1uLg0N9RpPTmWgzBtpEIfuzuPYJWDnnXsUfTqp32PPyYWXsoktu4GMdbpDigUAXjcSxDJwyPDzvarlvDHCxl+i44u/ZLzQSj7MpINGNM6kc2Gv+3yQdpq2w2+cFGNPoYhfLfCWYtni8mmwQExsIlOjVkpRL2qYfZWDQ42PK/nV5mTFdL3gOtUtcsLsBQoA1gjBTQy31sKu3e+QkvEBFeoYtq9n6lBhMjCTdfEPH0bB1WBN/muytEfaGbTfOZLMZlm2O9ILpXTN8Na1SD+wH/tr+Tqq9qW3oOTUGemVDntgYqGWMSeHsXFZEgfjScFFve9ZE+CMfDvAdq/071PeNajL6LySWlCQTEYeSeLpCLIOs4NM2x5LsjPtpw7qJKwbrt3EVe5N/ZSwCd6XiJrYFhuDfpVeAXvrNGs0T38gY3C6rnPRg7WmRzxKqygFzRz7YVTg8PheBueIn8xls1lTsL9caXaaLfNpq3mhnFb2L1thLkoVojIYVvGZlKRulITLC4WUOpIZvKIo5qxByM2pMddQ3UICaTDGojRHXqOB4gckBQHvO+Gvs1HR/AI4LeAaS5ECKKk2JvYqU6qcgvgmG9wseZ1AHPIY5LM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(56012099006)(4143699003)(10067099003)(5023799004)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ly9hQ2pJbW9hU3NLK0pZa1VITGdqZXlWTjkvS1FBTmllZVlWM1pDdFlFSVVC?=
 =?utf-8?B?TUpzeXpoRHZPbFBrRnkxaWtCaHhFQkdSbW9GSm1rczBVQi9JOGc3Wjlpd05a?=
 =?utf-8?B?N2FzYjhESm1mVXhTbTFUMWVPSkF2WHQ0VVp1Zk5kVmx0RnpENUc1SjVTU1Zy?=
 =?utf-8?B?bjFORnFwZmNyMmViMTFvV1k0S0xTRFJNMTVaM0pNTUwwZkJHbU1heU1DaGFa?=
 =?utf-8?B?ckNmVjRuSWk0Z1E4Q0FtV01xNDRLTU1rWGswaXlSY1YzS3U5T2NrSEpYOU1p?=
 =?utf-8?B?WUFJNE9wOVM5S3hWTy9DZ3R1aVpWbWlOZzh6dlJKdFpSKzdnN2NrVUdKUm9G?=
 =?utf-8?B?SjhNVVVUOWpPcUZnZFB6OHJsRThhVkNncUNybzFXZmg2cEtuMThqUVhIWjBv?=
 =?utf-8?B?ODhYUnU5TVNlS2RVam8yOFdQUlRQd1p1MVVoOExtdE9DbHZtejVKRDlDc0oy?=
 =?utf-8?B?MVpMeEFwN2JuQ3graHM3OVJWLzA4N0J5UTJFaEJ0YlZhNUNhMkVydFFmNUsr?=
 =?utf-8?B?WGV6ZmZTbm5DR042K3BuZ3YrUDl3Qi8wZG5XdFRKdHl5K0RkNC83OHZmVlNk?=
 =?utf-8?B?QkxjNDVxd0lqaFFhZnh0SzRIRWRvNVNLR0E0VXhVWnJ1WTlxNVJaUFVra21P?=
 =?utf-8?B?NVlHamx6S3Q1UGdDR3drbThkTmxqazJFWWhEc0lhVmg0Vnh0UkdUSXlXQ0JU?=
 =?utf-8?B?ZGZCQS82SFI5blptOVI1RGtlVkZzbkQvNFB0UGRtbHE2NWZwUGtBT3VmRXFO?=
 =?utf-8?B?VkZyL0tCWWR4YjR6Y1ltWHIybWkxUmNob0ZoWUU4aU1VbEJTczF0aUhYYTlO?=
 =?utf-8?B?NzhYWGNtaVpESFkwNytGY3BDOFlTOEZhTjVaZWx3dWJtZVl2SmI1eDZFUUNm?=
 =?utf-8?B?dG5jTEhiMGg3QUpndjZpQk1EZnVSV0xBR2ZLTW5QY2laZ080K3BTcS8wdlZI?=
 =?utf-8?B?T1dlN2pSS0EzTmFFcHRzVHAwL2E5ZStzemNyK2w5elRSNGRkK3ZQaFc1OVJ5?=
 =?utf-8?B?T1ZoSmFPa25VcTJGVVNpRlJDcW15Tmc3cTFaNEw2TlRJTG5GZFlQeWZ6M05s?=
 =?utf-8?B?dlh2aWwvVjR4QVRmcFVleDN0SVZ6cGZtRlpvS3ZJSk1NTW02MG5mK3p2VHd3?=
 =?utf-8?B?UDRuM0tyZ2lIRWpUWUZ4azhmSlVlUmRPcDBCekF2Vmh4STZWVFR0UWdtZUVl?=
 =?utf-8?B?QUZhUHl5b1A3Z1VGZ2grTVZkRGpibWNLYmxIRk9iaXh2czlOcUF3djB1aTJw?=
 =?utf-8?B?M2FZWEE2dWlWTHBRYzRodjBkQTk3SGtZZnpaV0JoVVVvcWdnRmgxbTN3YU4z?=
 =?utf-8?B?YXBZalVPUHZGNjBNNGd2cEloaFo5Tkp3ZE1ORzFzQ2pDQ1BiT2hKb0xnRXpv?=
 =?utf-8?B?SHFxbFRxKzlXNnBGTmRZTk9WaWFwUkg1d2k2dG9rcUs5M0hqUy9iSm84UW9Y?=
 =?utf-8?B?T0NiVHJaNDg5TlJaMWtyUEJWZ0h3MjIzSzlHSGRDZFM0WFkrUkRDOVB4L2Jm?=
 =?utf-8?B?Q1dkeHRDbUU0ZXFndUREMlc3Rm5rdEVJYXQ0cnE0cktyWGpSNXJBL05QM3h6?=
 =?utf-8?B?V2VGN09NOHdZNTU0UXQ0ZVh5QjM2dWhxY1BYNTZ0V3VyMml1K1JjRzVkVENa?=
 =?utf-8?B?V0RQK2pmck1QTm1aWkxzV3hkTHZtbnMyaGo5SVBScU0rakN0NDZyTlVHMVBZ?=
 =?utf-8?B?aVFrcE1xNkZoMmRIVmRGZmZrREF0NmRGcDZXRVV4NFdQeTM0QmU1ZkdwQjJr?=
 =?utf-8?B?KytjR2dXKzd2amlqaWF2Y04raDZub1JVbnJYSmZGekxNRjJPV0l3VVVhZlJs?=
 =?utf-8?B?ZmZqTDd3WE9mQXJHMSs1VVpQeTQ3VDAvK014QnZZM09kVmdjU01NWEQ4b1U0?=
 =?utf-8?B?MnJMUDkzaExUb1hHTzM1dVhtQTlpZS9MTWM1a2kyMG1RekNVcTUyOUpZTGVR?=
 =?utf-8?B?RmN3UkZaeWUvbkdWU1FkQ1psZGRVSjZyWkVSdEsrTmhreGc4Y3VuS2I5SEF5?=
 =?utf-8?B?OGR2WDh6cS9GZ3lSdThoQnNvKzBRdUF1RDgwY0JvL05SYmxYVnpVMHJ3Z3ZM?=
 =?utf-8?B?cDZibkNxK2dScCtrL1FhNmVWajF1VElqV1pic01TYWVjTU05bkF4d0VsNUQ3?=
 =?utf-8?B?OVdNMzRsc2JoeTU3ZERNRnhkM1c1SXdCdCs5YVh4NDVkUWllN3pLT0VqbGJE?=
 =?utf-8?B?OU5hdStmMVVZTjBXcXNBWmNxVTl6cDJ4eXhINk1JbDFsempiaUoybHkxaU51?=
 =?utf-8?B?c2JjbEVucXVmTTROZmYrYUUxeWprbk1FYnArWlVDdld2QW1HR0QwcWRzMkFz?=
 =?utf-8?Q?HlY+DKCc2YAfUxKKPw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76e9076-7952-4a01-5b8a-08df44b02970
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 13:39:10.9512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hm7z0A9sWIqDPQve+VC+1Se8Ye3o3PSsnVBN30zb6fbMa7E2VWNgElaR0JmG8VGiQge6PjmtJ0Y066puXmAouQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB338367
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KSGkgQ2hpc3RpYW4sDQoNCkkgbG9va2VkIGEgdGhlIGFtZGdwdV92bV93
YWl0X2lkbGUoKSBmdW5jdGlvbiBhbmQgbm90aWNlZCB0aGF0IHN0YXJ0aW5nIGNvbW1pdCAxZjAy
ZjIwIChodHRwczovL2dpdGh1Yi5jb20vZXNlaWtlci9rZXJuZWwtYXNhaGkvY29tbWl0LzFmMDJm
MjA0NGJkYTFkYjFmZDk5NWJjMzU5NjFhYjA3NWZhN2I1YTIpICB0aGUgd2FpdCBvbiB0aGUgVk0n
cyByb290IHBhZ2UgdGFibGUgZmVuY2UgbGlzdCBpcyByZW1vdmVkLiBTbyBjb3JyZWN0IG1lIGlm
IEkgYW0gd3JvbmcsIHRoaXMgYWxvbmUgd29uJ3Qgd2FpdCBvbiB0aGUgZ2Z4IGpvYnMgcmlnaHQ/
DQoNClNvIHNob3VsZCBJIGFkZCB0aGlzIGJlZm9yZSB0aGUgaWRsZSBjYWxsPw0KDQpkbWFfcmVz
dl93YWl0X3RpbWVvdXQodm0tPnJvb3QuYm8tPnRiby5iYXNlLnJlc3YsIERNQV9SRVNWX1VTQUdF
X1JFQUQsIGZhbHNlLE1BWF9TQ0hFRFVMRV9USU1FT1VUKTsNCg0KDQpUaGFua3MsDQpUaGFyc2hh
bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE3LCAy
MDI2IDQ6MzcgQU0NClRvOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFt
ZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFRob3RoaXJhbGluZ2Ft
LCBMb2dhdGhhcnNoYW4gPExvZ2F0aGFyc2hhbi5UaG90aGlyYWxpbmdhbUBhbWQuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZHJhaW4gcXVldWVkIHNjaGVkdWxlciBqb2Jz
IGJlZm9yZSBzdXNwZW5kDQoNCk9uIDExLzE2LzI2IDIxOjQwLCBNYXJpbyBMaW1vbmNpZWxsbyB3
cm90ZToNCj4gQXQgc3VzcGVuZCwgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9od19maW5pKCkgb25seSB3
YWl0cyBmb3IgdGhlIGxhc3QNCj4gZmVuY2UgZW1pdHRlZCB0byBlYWNoIHJpbmcuIEpvYnMgc3Rp
bGwgcXVldWVkIGluIGEgc2NoZWR1bGVyIGVudGl0eQ0KPiBoYXZlIG5vdCByZWFjaGVkIHJ1bl9q
b2IoKSB5ZXQgYW5kIHNvIGhhdmUgbm8gaGFyZHdhcmUgZmVuY2UuDQo+IFVzZXJzcGFjZSBpcyBm
cm96ZW4gYXQgdGhpcyBwb2ludCwgYnV0IHN1Y2ggam9icyBjYW4gYmVjb21lIHJ1bm5hYmxlDQo+
IGxhdGVyLCBmb3IgZXhhbXBsZSBvbmNlIGEgZGVwZW5kZW5jeSBzaWduYWxzLCBhbmQgdGhlIHNj
aGVkdWxlciB0aGVuDQo+IHB1c2hlcyB0aGVtIGludG8gdGhlIHJpbmcgYWZ0ZXIgdGhlIGhhcmR3
YXJlIHdhaXQgaGFzIGZpbmlzaGVkIGFuZA0KPiBiZWZvcmUgdGhlIElQIGJsb2NrcyBhcmUgdG9y
biBkb3duLiBPbiByZXN1bWUgdGhlIHJpbmcgd3JpdGUgcG9pbnRlcg0KPiBpcyByZXNldCwgdGhv
c2Ugam9icyBuZXZlciBzaWduYWwgYW5kIHRoZSBHRlggcmluZyB0aW1lcyBvdXQgYW5kIGhhbmdz
Lg0KPg0KPiBUaGlzIHdhcyBvYnNlcnZlZCBhcyBhIHJhcmUgKGFib3V0IDIgaW4gNDAwIGN5Y2xl
cykgR0ZYIGhhbmcgb24gUzMNCj4gcmVzdW1lIG9uIFBpY2Fzc28uDQo+DQo+IEZsdXNoIHRoZSBj
b250ZXh0IGFuZCBWTSBzY2hlZHVsZXIgZW50aXRpZXMgb2YgZXZlcnkgb3BlbiBmaWxlIGJlZm9y
ZQ0KPiBldmljdGluZyByZXNvdXJjZXMsIG1pcnJvcmluZyB3aGF0IGFtZGdwdV9mbHVzaCgpIGRv
ZXMgb24gZmlsZSBjbG9zZS4NCj4gTGlrZSBmb3IgYW55IG90aGVyIGRtYV9mZW5jZSB0aGVyZSBp
cyBubyB0aW1lb3V0LCB0aGUgd2FpdCBpcyBub3QNCj4gYm91bmRlZC4NCj4NCj4gUmVwb3J0ZWQt
Ynk6IExvZ2F0aGFyc2hhbiBUaG90aGlyYWxpbmdhbQ0KPiA8TG9nYXRoYXJzaGFuLlRob3RoaXJh
bGluZ2FtQGFtZC5jb20+DQo+IENsb3NlczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYW1k
LWdmeC9TQTFTUFJNQjAwNzMyOTJDMTEzQzZCOThEOTI4MjA5MkY4N0YyQA0KPiBTQTFTUFJNQjAw
NzMubmFtcHJkMTIucHJvZC5vdXRsb29rLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGlt
b25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMjYNCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gaW5kZXggMTlh
NTY2MTg3ZGZiNS4uZDE4MzQ4MTE2ZDNmMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtNDUzOCw2ICs0NTM4LDMwIEBAIHZvaWQgYW1k
Z3B1X2RldmljZV9jb21wbGV0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQ0KPiAgICAgICB9DQo+
ICB9DQo+DQo+ICsvKioNCj4gKyAqIGFtZGdwdV9kZXZpY2VfZmx1c2hfZmlsZV9lbnRpdGllcyAt
IGRyYWluIHNjaGVkdWxlciBlbnRpdGllcyBvZg0KPiArb3BlbiBmaWxlcw0KPiArICogQGFkZXY6
IGFtZGdwdSBkZXZpY2Ugb2JqZWN0DQo+ICsgKg0KPiArICogV2FpdCBmb3IgdGhlIHNjaGVkdWxl
ciBlbnRpdGllcyBvd25lZCBieSBhbGwgb3BlbiBmaWxlcyAodGhlDQo+ICtjb250ZXh0DQo+ICsg
KiBlbnRpdGllcyB1c2VkIGZvciBjb21tYW5kIHN1Ym1pc3Npb24gYW5kIHRoZSBWTSBlbnRpdGll
cyB1c2VkIGZvcg0KPiArcGFnZQ0KPiArICogdGFibGUgdXBkYXRlcykgdG8gcnVuIG91dCBvZiBx
dWV1ZWQgam9icywgc28gdGhhdCBub3RoaW5nIGNhbiBzbGlwDQo+ICtpbnRvDQo+ICsgKiB0aGUg
cmluZ3MgYWZ0ZXIgdGhlIGhhcmR3YXJlIGZlbmNlcyB3ZXJlIHdhaXRlZCBvbiBhdCBzdXNwZW5k
IHRpbWUuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfZmx1c2hfZmlsZV9l
bnRpdGllcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiArKmFkZXYpIHsNCj4gKyAgICAgc3RydWN0
IGRybV9kZXZpY2UgKmRkZXYgPSBhZGV2X3RvX2RybShhZGV2KTsNCj4gKyAgICAgc3RydWN0IGRy
bV9maWxlICpmaWxlOw0KPiArDQo+ICsgICAgIGd1YXJkKG11dGV4KSgmZGRldi0+ZmlsZWxpc3Rf
bXV0ZXgpOw0KPiArICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGZpbGUsICZkZGV2LT5maWxlbGlz
dCwgbGhlYWQpIHsNCj4gKyAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Zwcml2ICpmcHJpdiA9
IGZpbGUtPmRyaXZlcl9wcml2Ow0KPiArDQo+ICsgICAgICAgICAgICAgYW1kZ3B1X2N0eF9tZ3Jf
ZW50aXR5X2ZsdXNoKCZmcHJpdi0+Y3R4X21nciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTUFYX1NDSEVEVUxFX1RJTUVPVVQpOw0KDQpUaGF0IGlzIGFjdHVh
bGx5IHN1cGVyZmx1b3VzIGFuZCBldmVuIGEgbGl0dGxlIGJpdCBkYW5nZXJvdXMuDQoNCmFtZGdw
dV9jdHhfbWdyX2VudGl0eV9mbHVzaCgpIGlzIG9ubHkgc3VwcG9zZWQgdG8gYmUgY2FsbGVkIGZy
b20gdGhlIHByb2Nlc3Mgd2hpY2ggaGFzIHRoZSBmaWxlIGRlc2NyaXB0b3Igb3BlbiBhbmQgaXMg
Y2xvc2luZyBpdC4NCg0KV2UgdXNlIHRoYXQgdG8gZGV0ZWN0IGlmIHRoYXQgcHJvY2VzcyB1c2lu
ZyB0aGUgZmlsZSBkZXNjcmlwdG9yIHdhcyBraWxsZWQgYW5kIHdlIHNob3VsZCBkaXNjYXJkIHF1
ZXVlZCB1cCB3b3JrIGluc3RlYWQgb2Ygd2FpdGluZyBmb3IgaXQgdG8gZmluaXNoIGV4ZWN1dGlu
Zy4NCg0KPiArICAgICAgICAgICAgIGFtZGdwdV92bV93YWl0X2lkbGUoJmZwcml2LT52bSwgTUFY
X1NDSEVEVUxFX1RJTUVPVVQpOw0KDQpUaGF0IGhlcmUgc2hvdWxkIGJlIGVub3VnaCB0byB3YWl0
IGZvciBhbGwgd29yayB0byBjb21wbGV0ZS4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPiAr
ICAgICB9DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogYW1kZ3B1X2RldmljZV9zdXNwZW5kIC0g
aW5pdGlhdGUgZGV2aWNlIHN1c3BlbmQNCj4gICAqDQo+IEBAIC00NTg3LDYgKzQ2MTEsOCBAQCBp
bnQgYW1kZ3B1X2RldmljZV9zdXNwZW5kKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGJvb2wgbm90
aWZ5X2NsaWVudHMpDQo+ICAgICAgIGlmIChyKQ0KPiAgICAgICAgICAgICAgIGdvdG8gdW53aW5k
X2lwX3BoYXNlMTsNCj4NCj4gKyAgICAgYW1kZ3B1X2RldmljZV9mbHVzaF9maWxlX2VudGl0aWVz
KGFkZXYpOw0KPiArDQo+ICAgICAgIHIgPSBhbWRncHVfZGV2aWNlX2V2aWN0X3Jlc291cmNlcyhh
ZGV2KTsNCj4gICAgICAgaWYgKHIpDQo+ICAgICAgICAgICAgICAgZ290byB1bndpbmRfdXNlcnE7
DQo+DQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNzQ3NWVhOGI1ODYxNmIzM2MwNGFmYjk3NmNmMGZi
YWFkOWRkNjNmYg0KPiBjaGFuZ2UtaWQ6IDIwMjYxMTE2LXN1cGVybTEtZHJhaW4tc3VibWlzc2lv
bnMtMTdkNDQxNGFiM2I5DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gTWFyaW8gTGltb25j
aWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+DQoNCg==
