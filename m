Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76DDC4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 08:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB99711246B;
	Wed,  7 Feb 2024 08:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="sshyzYkk";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn19011002.outbound.protection.outlook.com [52.103.66.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696CF10EA6F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 10:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPyvZmol8Xjn/ZW9mYNWBebDtX0Pi83MWppIDGuP4urV+YToZ5TEFDoGiUdjvMfE5RoEnZ3Old1gkZhvUY1UrBbFCeaPi+484oyBGT+5YIuo1i3AL0W0k51LCgWl2ciXmn9X8S3jWVXUjnu5s3S51z11631f8B28Az5qKKyO4ZjfIXJqHQ497l79qlIZLNkwjYgljuR+p8yNrcZwTYuNqu7M0GhNib6uhrpoRys69m5UYzBSZV7uLceF2y3ZF8mfWgC1dPTLxKJXJ/SuJc0EnujQYmzRbhwTY/DQkk+gBy5ocFrQqlYjkKYzvpOYbQHHUjcFwwJcRPvA7Vnj8Nh/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqJwZC6pavYj/yNTjN3wC4wrN6IMIg0gVzkL6hMoxPA=;
 b=QRb08KOs0dMYZej68blu3ckh61gpp+ahu9QzGug3DqW+W3GEe070UqmSn0zI50GZZ1RF73ELuh3VCX4Q49k3dJWM/dZPEENE2+EC3qnaGaJUcHGvE1APvxzc5KoLsYwPJb8K25S2TZmGxXErxXKGYN5cVhF166iPT8ph3456ugbD9W3+ZknlIVQobKTHNZko0ZOtB+Ts7ZzgkY/A2TgRCES+FZTYkAKCbyos76SBk38SOQnQ3e6sgqKjE4HsRKnXlz5ats2zE5miaHebcjloYj5iIoTRzgviZw8b94B7xRNia/4WXRDkjpMUxRqs/ohKF8lAm2XeKusUCA46aVIE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqJwZC6pavYj/yNTjN3wC4wrN6IMIg0gVzkL6hMoxPA=;
 b=sshyzYkk3GWNDrYedxEYOQTW16bM4CCyYxd+XgGnE+3sZGiiYqTdSVuH39IW90iarPb56xtPdM4UF8mYcBLgLb2ugijK2n3qRl6spDKCwGwNfeCm62s4ZSTyK8ilGAL3Hv+3A0mHsO71WXV9sdBvMliEAgdpzz9NuP2xxwtMIGdxiXMfnhqzEyKW+EtSfvI6MJZu/ijr/1ijoDvLQxxjutYvBqWTKuvelkZ+vv1bxjVY4S4LXEIbMawo/BOuna1PNGOekuKEDuU0dFPzAFNj9NjCN0LFoCCtqC0FQwm379yT8styt81JJpMg2gtXB53d+5uxEdeHO+bulrEy+kqItg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB2698.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 10:08:33 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::574a:19b5:4c79:4092]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::574a:19b5:4c79:4092%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 10:08:32 +0000
Message-ID: <TY3P286MB2611E2E82EC6DB77F1AF58EF98462@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Tue, 6 Feb 2024 18:08:08 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, "Cornwall, Jay" <Jay.Cornwall@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Subject: Re: drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <5b23b3ef-2ccf-430e-bc0b-b4868358ad8f@outlook.com>
 <TY3P286MB2611C443C88FFC125AE79DA2987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <8b8d9a37-111e-4c92-886d-f29da2abb527@amd.com>
 <TY3P286MB2611E17DA5FCC50F6FEC83BB987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <d180e65f-7b3e-4413-baad-e40c3bb63fce@amd.com>
 <TY3P286MB2611781B20F3953AAD2FC38E98412@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <BL1PR12MB51447B5CC481DFBA3F197126F7472@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <BL1PR12MB51447B5CC481DFBA3F197126F7472@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fV3sq0CLdV3Yz03YOo8gHPXX"
X-TMN: [BxGUQaFMyM1FllsE7KHdSkoHz4KyYxw9BlImxqXB4NTP+ttql2tkCOPVx1IE9ZBa]
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <ea1d355b-3788-4648-a00c-f8eedcb9caa9@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2698:EE_
X-MS-Office365-Filtering-Correlation-Id: af1d8663-1301-49ae-37fb-08dc26fb931e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4MsRSbsa2qHCQdxpP/BlZMARq0dJBVu6lBQC7nQkkW69eK+GXyrChsTtnBU1alTdYPB5WtVIOr4X2VuP8FpL4FJC55eUo2GGUHfcEX1Enfz7txebkWfJDpHwAXYL9qEcfuQ6hjU06O/Rn83hkxA5yDtHXHwjVPPhe0vPtYa7LrG6fDJW6qiS9Pxgd/os4U/5YBv9JKfVmg1BdOGoDTcLYPbgBURwbfQ4mtZyY1mvq+X3M8ITECzKoQ5PqQVyxEdctgQ59H+3cDDvkLmdfROBIbirI+6iYzQ2OgzYIVrSZCNy1ha/K4PZhIPCsH08+vZUs7OT8zcMh7jbk5/k9wbzfqLltB97Tovak711/9viEhjVG25k4mXw4wy35Q3xkF0FTfQ3OiOP9paurSLwbPkbZcl2DUUYdJTouvMUjmnQKc9+evl2fKVMGGXV1wA42AN4n86hjADihULY2RWm5Dhnnmh0OiDTnwITLHp96Xua+nK/MiU8Fv30kjOxaCKSDa8+g56UjHiLSuz4z4emXeNp3buGLxo9zhESFQq/WxgN9FBXhl5FISypQFAnNppMyj6vmaQ38WD/OauIlSJLmJe0nf+o9ctyg3IhzbUvWzk4s98xhnHMUD+l+uC9wqay3HYs4bttEjxAgjYb0nV3RbIrunFtaLSzgtKEG2oVg3mHuw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjM5cU9wYURTTTFDd0RmdVFwQVdvZWFXZFd1Y3V3M2NuTHVKN3IrNmI4SS92?=
 =?utf-8?B?SXNUSE15eEUvRWRBd1ZOUXBsN3dFQUo1TS9pMm9LS2x6Y0xTempwUDJWMkJ2?=
 =?utf-8?B?RmFLb0tlR0krUUlxUnR0ZFI4TkUrbTEwSytzSDVYeXMyci8zQUU2UHVnbGRi?=
 =?utf-8?B?eWVjUGhxRUxRM21NWEQ4cHdNalZwQVM1UzlaaHVxRmlmWVlSOFNXMm5Fcmpz?=
 =?utf-8?B?ME5wS3FmaFgwc0l6NHhDQ0crcW1TejQ2dFZnaEc0T3dGZzZ4QWVTekxpN3oy?=
 =?utf-8?B?QWEyRS96eXY1aGJkTmVzMEZJeERXVVQwdUV5YkZoTEpYQWlOU0F2NzlHVjEx?=
 =?utf-8?B?cTZaMHFRK2VMQ1M4MjNoVzZXbzgvNGxyMlk1UkFFV3BqQXV3V3JOaUhOVDVr?=
 =?utf-8?B?RGpyZU1hckMvWWlpVUJmb1g5UnoyVXhtVnJmMUJJRitIMjZkTmJjZndwSmRX?=
 =?utf-8?B?bGFqNUxLQTJrZitqSWI4TzJtcmJzNlBJZC9NaU9YQm15QTA1clR0QmlPTXht?=
 =?utf-8?B?em5ReHlMRHJ5OVBnUG5YWFN5QWxpcGpDY1Y0aWJVY3I3eGZSdGVRdEZjcWxZ?=
 =?utf-8?B?ZHIrdW8rMjJPYUhTRkRYNnhvOC9OTERRUFJ3TExBbU1YT1FQMEZUdUdydmpl?=
 =?utf-8?B?cXVESGFZeVV0S3ZBemlaRHlDUjg0aVZ2K2pFbkJWK2ZPczBUdDN3U2s0ZVlC?=
 =?utf-8?B?SDBSUlEyTWtCQnZsd3U2MHFBRHIxSUNGNm4wdlYwSWViTm9MYm5RV2Z1a0xw?=
 =?utf-8?B?NzZXYmJNaHZqb0hKZ0sxNUwvM3BTYmlrbmFCM2NRTXkwYkFsU1ZPcDZFcVRU?=
 =?utf-8?B?RFcvWll5ME41NXN3dThHd2Nwc1lMSXB0TVZCcXltTit5SEFMMlRjOC95djhh?=
 =?utf-8?B?aEtUUmlRQ3hreUFaWm9JakJ4SW44ZkRuMERETm5FRlpUK0drL1NxN2dXVHRT?=
 =?utf-8?B?MDNwVEZCVEZkcFZBSnBtVlVRQ1dzbWRDdmNtR3JRbHc5cGVoY2ttZXdkS0VH?=
 =?utf-8?B?cldtNk5GclJiTFhGcWo3QktKb1BiVkVDTDhGa2dEUFlHaW5zbUNieW5EL2ZN?=
 =?utf-8?B?UHkrU29xVm9SUmM3YjRZU2hoQmNhVUtQQVBOa0dDbnFYcjllaUtEVjhTblJY?=
 =?utf-8?B?QlNabVBVTmVqSWlPRFFCQ1hNTmxLdi9RWnJIYlNOVmNYRkV5Um5xc1YycmRJ?=
 =?utf-8?B?cTM0MkE3OHoyanZvK0swMzZnRVpnMnVESUdlejBtNHQ3MDZFbWNYa2RsMU9D?=
 =?utf-8?B?YU50VVVUNjRyUDB5RUlsd0pzVW1jQjkveUVWVVp0T1oyTWZmYkRBYytrc2V3?=
 =?utf-8?B?eHVjSS9Md0VRdXhvT0tJQ2prRmFMS3dmVkg2ckc5dTVoRzJIVndlcElISEpw?=
 =?utf-8?B?UW94N3Ryb1pSc2ZBSkZodlFTK0o2WGJaTjQ3ZWZzcUFqNzVLbDhWWkg1NnVF?=
 =?utf-8?B?U05ybDNqcnN4c0FOK1pCNjdFSVBwcUFLSzdBWFpDN1BxT1UzWjYwbGJGTlhk?=
 =?utf-8?B?aFVVRW9ZcE9mUExxU2c5SUxiK2JRNXlSNjFORG0yYjhtM2puTWxpTU16eGtJ?=
 =?utf-8?B?ZDVsaTNXb1VkK1dkN0NVRUZFTDNVTUpXOVpZZ1JYb0YzV2d6QnpwQUwrZUN0?=
 =?utf-8?B?MTdFamNULzlOWURGQUZsVkcvMDRaNlc2ajhOd1ROVTNod29JRlNscW9qLzdx?=
 =?utf-8?B?WmExYWFub0pvOHJzS2Q4R0dxYWVES1k5VUxvQ0puaFAyd2hncU1wclgvUnJC?=
 =?utf-8?Q?kUjjkMJUnbu2nZGTsk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1d8663-1301-49ae-37fb-08dc26fb931e
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 10:08:32.9319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2698
X-Mailman-Approved-At: Wed, 07 Feb 2024 08:06:42 +0000
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

--------------fV3sq0CLdV3Yz03YOo8gHPXX
Content-Type: multipart/mixed; boundary="------------LmuAPJSJCHsWxMB10sJbuUod";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: wiagn233@outlook.com, "Cornwall, Jay" <Jay.Cornwall@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Message-ID: <ea1d355b-3788-4648-a00c-f8eedcb9caa9@outlook.com>
Subject: Re: drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <5b23b3ef-2ccf-430e-bc0b-b4868358ad8f@outlook.com>
 <TY3P286MB2611C443C88FFC125AE79DA2987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <8b8d9a37-111e-4c92-886d-f29da2abb527@amd.com>
 <TY3P286MB2611E17DA5FCC50F6FEC83BB987E2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <d180e65f-7b3e-4413-baad-e40c3bb63fce@amd.com>
 <TY3P286MB2611781B20F3953AAD2FC38E98412@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <BL1PR12MB51447B5CC481DFBA3F197126F7472@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51447B5CC481DFBA3F197126F7472@BL1PR12MB5144.namprd12.prod.outlook.com>

--------------LmuAPJSJCHsWxMB10sJbuUod
Content-Type: multipart/mixed; boundary="------------iIwR5gveU88MitCnPgD2jzDP"

--------------iIwR5gveU88MitCnPgD2jzDP
Content-Type: multipart/alternative;
 boundary="------------HKK6HiwT0450DUeELVSwCwGg"

--------------HKK6HiwT0450DUeELVSwCwGg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQWxleGFuZGVyLA0KDQrlnKggMjAyNC8yLzYgMToxMiwgRGV1Y2hlciwgQWxleGFuZGVy
IOWGmemBkzoNCj4gQXJlIHlvdSBvbmx5IHNlZWluZyB0aGUgcHJvYmxlbSB3aXRoIHRoaXMg
cGF0Y2ggYXBwbGllZCBvciBpbiBnZW5lcmFsPyAgSWYgeW91IGFyZSBzZWVpbmcgaXQgaW4g
Z2VuZXJhbCwgaXQgbGlrZWx5IHJlbGF0ZWQgdG8gYSBmaXJtd2FyZSBpc3N1ZSB0aGF0IHdh
cyByZWNlbnRseSBmaXhlZCB0aGF0IHdpbGwgYmUgcmVzb2x2ZWQgd2l0aCBhbiB1cGRhdGUg
Q1AgZmlybXdhcmUgaW1hZ2UuDQo+IERyaXZlciBzaWRlIGNoYW5nZXM6DQo+IGh0dHBzOi8v
Z2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9hZ2Q1Zi9saW51eC8tL2NvbW1pdC8wZWI2YzY2NGI3
ODBkZDFiNDA4MGUwNDdhZDUxYjEwMGNkNzg0MGEzDQo+IGh0dHBzOi8vZ2l0bGFiLmZyZWVk
ZXNrdG9wLm9yZy9hZ2Q1Zi9saW51eC8tL2NvbW1pdC80MDk3MGU2MDA3MGVkM2QxMzkwZWM2
NWUzOGU4MTlmNmQ4MWI4ZjBjDQo+DQo+IEFsZXgNClRoaXMgcHJvYmxlbSBpcyBub3QgYWZm
ZWN0ZWQgYnkgdGhpcyBwYXRjaCwgc28gcG9zc2libGUgdGhlIGZpcm13YXJlIA0KaXNzdWUu
IFdoZXJlIGNhbiBJIGdldCB0aGUgbmV3ZXN0IGZpcm13YXJlIGltYWdlPyBPciBpcyBpdCBh
bHJlYWR5IA0KcHVzaGVkIHRvIGxpbnV4LWZpcm13YXJlIHJlcG8/DQoNCkJlc3QgcmVnYXJk
cywNClNoZW5neXUNCg0K
--------------HKK6HiwT0450DUeELVSwCwGg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    Hi Alexander,<br>
    <br>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2024/2/6 1:12, Deucher, Alex=
ander =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:BL1PR12MB51447B5CC481DFBA3F197126F7472@BL1PR12MB5144.namprd12=
=2Eprod.outlook.com"><span
      style=3D"white-space: pre-wrap">
</span>
      <pre class=3D"moz-quote-pre" wrap=3D"">Are you only seeing the prob=
lem with this patch applied or in general?  If you are seeing it in gener=
al, it likely related to a firmware issue that was recently fixed that wi=
ll be resolved with an update CP firmware image.
Driver side changes:
<a class=3D"moz-txt-link-freetext" href=3D"https://gitlab.freedesktop.org=
/agd5f/linux/-/commit/0eb6c664b780dd1b4080e047ad51b100cd7840a3">https://g=
itlab.freedesktop.org/agd5f/linux/-/commit/0eb6c664b780dd1b4080e047ad51b1=
00cd7840a3</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://gitlab.freedesktop.org=
/agd5f/linux/-/commit/40970e60070ed3d1390ec65e38e819f6d81b8f0c">https://g=
itlab.freedesktop.org/agd5f/linux/-/commit/40970e60070ed3d1390ec65e38e819=
f6d81b8f0c</a>

Alex
</pre>
    </blockquote>
    This problem is not affected by this patch, so possible the firmware
    issue. Where can I get the newest firmware image? Or is it already
    pushed to linux-firmware repo?<br>
    <br>
    Best regards,<br>
    Shengyu<br>
    <br>
  </body>
</html>

--------------HKK6HiwT0450DUeELVSwCwGg--

--------------iIwR5gveU88MitCnPgD2jzDP
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------iIwR5gveU88MitCnPgD2jzDP--

--------------LmuAPJSJCHsWxMB10sJbuUod--

--------------fV3sq0CLdV3Yz03YOo8gHPXX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmXCBRIACgkQX75KBAfJ
sRk/Uw/9Hwk/zkMynBPpThyUa3hahxVtd3S34zYLkoLUPa9eG/HyLwjtCUNBR8l+
6gle67LxhcCl2aKj4BZ37ZVzy2tcpN0iSlwRjmslipj39FCd72HI7uAfN2bhQbEL
lMovXjDxkGJsVQe7V30wtvoIQ7FmVXuHwrp0iDVkbkHT8LfuiJR/dniiTaq7BHJH
rpKoZQUGlp0pBxz5irbwnm7eVWIffDTXLb6V1y9KKwW8E3SpokywG15QETE16VPw
HoUZet7hJxyHnkkWulBsWTd4vrz2DuMX0F5x/XrkBbww27fqZXwBOlrN5UbAT72a
KjK9mGEiDkfG57sG52I6L+33ivD26lE4mPFoW9SIlZG6k84LIjHdHl3seCE+g+tL
fJLstx9mkl9LNhiqmAMA8duOzgSMrEgJYkSbrIHvsTLBu3rlYT6glb5xpZoncDix
ZguaXuxBllFzLCi3lburLWmlTaCrAKoRuaorLA4o42irxhfCZcRLgHM7lWmJ2JyD
PAeu1WT3qj/Q1qsLTNmdQyU+3bkClJWAaeINmzPwO9go5OK2kJfxTF5hTaHha0bI
0mZhTUPEVrYES8/QxnzV2mfRlj/ZJZaiue3O2jJ7x9hz/xrhWDcvTiF01ch6Z7e2
VYb9OdVC4SytaiyebgSg9MXjS8xmQgZeT0RyQanTAo22RYNTFLQ=
=glPG
-----END PGP SIGNATURE-----

--------------fV3sq0CLdV3Yz03YOo8gHPXX--
