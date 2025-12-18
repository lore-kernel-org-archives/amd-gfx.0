Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352B7D68BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 02:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2FB810E1E6;
	Thu, 18 Dec 2025 02:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sNMb9jOn";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A349F10E1E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 02:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pbgh2W/SdeH5l5ck/asikC2qNneXcZYPgD3rZIFdLDvXbVu3xWHX92XNIHDUifGarhj2blFouCE8oOF+NrXims4dcdp64VDU4HPfVOsWjoPjD/qRwInj+PP0oZ4KzM3tMhlXykb4XlXA4CTceL4h3zWrF4/8P9p0StAZyhCiqyo0NVOw/S7kYGMIwkobAuLJzzmK0Ky/AXE+vjoRQoFHRlI8An78a7QKjIYnbKYOjIQht9oQJQ3JT32EcXRoYPTcdiTJ5HXb68VaPIxt4y+0Yo3gNTuHdSL+xo3g7D4zsHtR1o6fNGQKOMgOHx7BC8W+gNQ7ScErLi9mTlFREjCrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E26fZK21/84vEXI6gdX+z8l9l9IWBiKerdKObb0gEOo=;
 b=kGuitmKeLBTEpkiE7pBiPZcOMZYCMXO0eh7fe+0UM1/+XK5Brf5OUNReKfSlWi3EUuIIyj3nXlZJUFIZ0/6nq+6zk9AEgfQtsWpz/SSd2Zqc5alS2OHKFeiWY4hv1ZgR0LzcCjouDdoF8BDpnIfxfoxcmt2ywDTSjQ1gvoMWCY2bh/tWzavGCLmN7FqnyaV0EuicrDr/S3N+E+vrubXOmOS4/IxTq9yZ6Rfxk9dUkCuMwGHDugifOixo/57o7Xm6hii5zrKqnViEIz44VnJDqwN+UgNj59u8smKiQE3pn39GZgemGlVv8jU5O8Ds4YnLWxqP0u1w9AOI5Ucv7kOqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E26fZK21/84vEXI6gdX+z8l9l9IWBiKerdKObb0gEOo=;
 b=sNMb9jOnX95AXI9ndkcSZ4P1VYgT8UTGMLfscBN7F4opzjrjqyxJYhZeClJLUNfmLe0WLIDK9uFOYkPrMpdW/75c6jSWFGhwx26QWx2b/6wGnBJGTOCydLFvPwo8FEBg3s8g6PMWUY48+HxJB5L25POR2RngA4C+4VIAeuYGB/A=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 02:56:14 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::53da:e77e:261e:5a29%6]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 02:56:14 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 6/6] drm/amdgpu/gfx9: Implement KGQ ring reset
Thread-Topic: [PATCH 6/6] drm/amdgpu/gfx9: Implement KGQ ring reset
Thread-Index: AdxvyNCJ9zgSlzcXQWOSpkvrw91y9AAQ3v8A
Date: Thu, 18 Dec 2025 02:56:13 +0000
Message-ID: <BL1PR12MB5849126D365B461FD5B85E2BE7A8A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <BL1PR12MB5849EF718ACDD3FB753F8D1BE7A8A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849EF718ACDD3FB753F8D1BE7A8A@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.9434.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|IA0PR12MB9048:EE_
x-ms-office365-filtering-correlation-id: 2b7add2c-28d6-4f49-65eb-08de3de101d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZVRTSUNCdkVnSHgzODg2VmRiVVp0anVsdHpLSUFPcWZFTFB5YkRVU3VvOTVi?=
 =?utf-8?B?MUNzSjMraTd4SkhOMlRwQkxmWVpxcXdBSk5OaVdQL2k2QmZ3UGZzWmJTQ3BP?=
 =?utf-8?B?TkhVa2JJTFI5WjRiZGRld2k0NmVvMmhHV2w3RDR3M0JiamlnbmVjaFQxVVov?=
 =?utf-8?B?eXlJR0NZbklaWkZCeVVZV2lvaUpKMmxwNWtNdy9xTXZNajZ0M21HdEVrMEtw?=
 =?utf-8?B?WXBnR2NkNTB2dFp3NnpyWU94RE9OdlpMSHh1MFZxRGt6U3pMOSs5REJGSmox?=
 =?utf-8?B?SGl1UzNUWGVRYndOWTJTV0htR3Y1aVdVc2Yxcjlrc3pJZGtMWFpZOFljSXdn?=
 =?utf-8?B?Nm9tbVBRTWs3TTlWTWUrTWYzTmYrczQvcDh4cHg1ZnA4NmNNNERrQWNnK1V4?=
 =?utf-8?B?SEk4Sjgxa3VlRnpOQkxpb09yWDFIMGswTFc1djU1bDVJdnFvOUhjYVJSWFMz?=
 =?utf-8?B?a0xob2dXUCtXYzJWaldldnd4UFQvY3YweWxEaklnQnQ5bWc0b3NEK291VVhN?=
 =?utf-8?B?RjV4RHhtYUFrRjZxS2NjeHN1QTh5SjNmUXdSWGJtRTRnUnJqblduemlJeXRH?=
 =?utf-8?B?TzVSTzR1Q01BV0FzamxQZndadHFjQTlDaFNWekZTSUdLY3R2TTVka3FNdFJ1?=
 =?utf-8?B?S2xpU1dzMTZHK2dtT3duZTZmTkNyZDRsbklaVitudzJwZmxLUEsrY2JZYjhC?=
 =?utf-8?B?ZmpiUjRqR1ZEUGpOSi9LcFRVTXNmci82eHR5N1laZEpYMlI0ZmpwdDhKNFBh?=
 =?utf-8?B?QXN3RUVlV2FLdmpzRTBpRitiNi85aUtIZktEM2YwdXpGM1pnM0hGRlczeFlC?=
 =?utf-8?B?eTR3K2pnQlhiYzc3Z2FwaDQ4elIvck5DUlBJZjAvNTQ5Z3ltRTkyMG8wbks1?=
 =?utf-8?B?WFlDRDU0WG0yaFQ0NTU0enJMWWNQd216TEd0dU1xeEtvVnFCQ0d2VkxQY1VO?=
 =?utf-8?B?Zml4cThpMU1nakU1SVVCOUMvZ09jYUY5UHJQMHRaZHhqRlpGVXZHWHFhb2k5?=
 =?utf-8?B?bDBlS0gvMmg4bXlmU2w2N1FNQjBOZ00xUUJvb2xHT25URzJ1L1haZS83VW1u?=
 =?utf-8?B?UFBXMFZZZXNxOFZ1dEszN21wdHUxQUhZZzZOVWhpdElwSTlka1J5bE13WklX?=
 =?utf-8?B?eGgvY2VHZmd0WW96TkdZTk9sbmVRUTBNNWJLMXIveUw4Sm54R3RoVFMxcmFw?=
 =?utf-8?B?Z3lEeXVCTzlIQWRtLzFPbEJlYnBMeXdLMTEzdTZXNFdqb0J0bHZWUUNSdUx2?=
 =?utf-8?B?UE5FYmJLQjRXVFBObW9tVk0vcWZDRUV6aCtONWVLYkxhSWY4a1lKaDVDTUMx?=
 =?utf-8?B?ZUR4U09mSjlJSm9Uc2ZVU2ZyRHdzZytpMHFmalYvSmlCUkNJZGdiRjZEZTZ4?=
 =?utf-8?B?VW9YWkRCM3ZwUXhjN0c2SlpNMlBvUDBlUkx2Y3loQXBhdklTSW5CK2dpdTVh?=
 =?utf-8?B?SHRtNkJMY3ViZ2t6Y0VXUXVVcloveno0cDB3SW5KU0c1UE1kbnBPTVFUR3Ba?=
 =?utf-8?B?Y2dnMnRDL3BUVVV4cXhkbmxkMzBERUM4WldmOWE0Vy9hcFZxc0g3R1ZSYUVE?=
 =?utf-8?B?QjVFdTNYNlllazZCempEMUtvSHBnY1NOTVNPWDF6SkYxN0ttOWZ0Q2dERGRB?=
 =?utf-8?B?OUpyQnlRZkZwSStKcVdzVVRYR2c1eE5JMFhIYmJ6a1RaT0drbWhMRHNvcE9J?=
 =?utf-8?B?eGJVZk1JQS9vR3BYanFNYkZYb3U2SlhYRnZVT3VkaFQ5cnpYaXZ2Vk1FVVA1?=
 =?utf-8?B?SzEvV1V5U3RSMHoyNno0TnFhLzllTWY4Y2FYVm85bEEzU0dFS1ZQRHNNRmlV?=
 =?utf-8?B?emZYdzVHanpLZEo1TXFhUzRuV1ZSWE9oOXMrOTBsaVJLNityU1VsMC9LcWFP?=
 =?utf-8?B?QWF0S3g1NXVTdnFRa2diTVc0Uzl4ZDhmNGttcXJiQnRFaTliRHhKTnRkaUNY?=
 =?utf-8?B?NTI4aTJMZmRUL1I0N2xlTHBJQ2dpcHJySXZlQ0F3VHV2cWxXUlJ4bUNHZnNs?=
 =?utf-8?B?aFkydkRmR2hWUzA4ZHBQdlhPTkNxTnF5SE40OW43aW1rM3ZsdlNDWWNKL3Fo?=
 =?utf-8?Q?BXOZ+n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y05QRHkyajg4MGZrczJyRmZsQXJWZG9TemRBSnpDZllZN3o5aDFWQmExQU51?=
 =?utf-8?B?ZFBUY2JnUGpoWkdrYmUwdVpBK2d1SVZ5YTJPS2VVbWR0NjJ1cU5xaWNPQ3g4?=
 =?utf-8?B?Qk93c3JJNUFOTFMxWW16TXNiNlFNUW4wZHRicW9jUDN0STE1L3pmQWNmOXI5?=
 =?utf-8?B?YjdkRGlPdEFuS2c0YlUvVFI5RlhlUlNRVW1HTGNURVVoeElnaG1scHZuUmhJ?=
 =?utf-8?B?S2ZTbWhHK25rY2Z5UWRWT2xpZERWbTNvYWFCMTh0bGt6Y0xhbTU2a0RaMWx6?=
 =?utf-8?B?MVZMMy80cC80WGpsbTN1TkhSVWl0MExTNjcyY1VZbW9Kc1BDUG5ONEhPenpD?=
 =?utf-8?B?dytXaGxSWk4rdjV1ZytyenVFVDNaRTdJRnhrYm9qNnBFMk42VHdQZVhmOU5l?=
 =?utf-8?B?SmlCWUcxY3lPM0xJUFdyYS9IcU9pMU91MVlSQUNDRVhYNWNkOWk1UmhVNGxF?=
 =?utf-8?B?ajRIa1Z3QWQ2WlZxY1hHeUhRbCtoRTJQa3JoRlo0bzIrSTVkbUYxU2NLUkpZ?=
 =?utf-8?B?Ti8za05aWXVBcWJqK3dZcllqaVB5WkFsWkdkdGRIT0RlSVRzdFZvTnJtV2l1?=
 =?utf-8?B?ejVSSTVndVBMaTVOTkpxUU9wdzhrV3N6WjUrUzZqK01heXlOWEwwZ21sZWpY?=
 =?utf-8?B?UUVGaG1vTXFnZW1XOG9SeTJueUZRcmZwSUt2MWxDcUs5R1VSTTFObGFiZVFo?=
 =?utf-8?B?amRCbTdkUk8yN0xMNjFQbkpsZXBLWTFlY1FvOTZ6Z0NtWU9YbXFoY0VXdEw4?=
 =?utf-8?B?ak5wb2dBUTNsRDZKUkNRZS84TjFUait6ekx4L0hZam5xQTlwKzZzZWxHdWl1?=
 =?utf-8?B?VHVTVXZNalBBMEllT1JZTXVPZzFIR0pIbHI2anBoaHJBdHEvVlhpR2dZRDhv?=
 =?utf-8?B?K1hFY3ZIREE5cjFxeUsxaXN4T29tc3liSDBiWndmOEczL0dmN2FtMUFRMjN3?=
 =?utf-8?B?SnN5OFNocnVQL3dmckNyUUk0VjdNS2pFNmhuRGFrbW5XQVJ0emxnNmxCa2NY?=
 =?utf-8?B?SFlBUitKaElEUGxKSEY1M3hqU2tVUmt1M3l3Y29Hd1h4U1JHSGozT0t2UmVI?=
 =?utf-8?B?RWtUa0l3SGZUd3ZTMFNtNjBwdTQyYlAvdW9IYnA4RWxJMU1qd1VoRnU2UzBr?=
 =?utf-8?B?Qm5oTHNDbmNEQlRRL3h0ZVlmUXpGMk1OTVpqQ1JWMVF5Q1RBRlpWUUY1VDF2?=
 =?utf-8?B?cjBna0YvUFdaWTkxZ3luczlFOURwN243N2V4clplVFFUVXRhTGpMWmxmMWNZ?=
 =?utf-8?B?OHlreE1JQjVwSVhoaGNuTU5FNDg5WndiZkdXcGgySmhQSElwc1dKMUVWRFVG?=
 =?utf-8?B?YUYvQjAvQXBwZnVBSzZVY3VoSjN4eUZtc1JrQUtzRjlBSHQzQVlXWGdkSCt5?=
 =?utf-8?B?OVdERThWYk5IZSt5TnJZRzg1OXFyNHY5V0tuSzk0YXp5K0l0YnN6MXhzbWxx?=
 =?utf-8?B?NjloMXNkUlA3ZDRGaDMvbjI4QWVKckhIbWlUbFlVUGlFYmtMQTU0VkFWTEZV?=
 =?utf-8?B?OTRLd3VYRjRTaHd2Y3dLakJjQTYwWUo4eVMreXg1ZENBbzF4cWhOLzhOc1VN?=
 =?utf-8?B?eVVxcEprYVBIUUVuaHpvVzVQTXVoMCtGM0xXd1pLR2UzbjdiSloyWVpqNmZW?=
 =?utf-8?B?NHB0M3RLaXpZMVBxUE5kQ1BBL2d4M2NpRi8zWWp0cFpTYk4rWTVXLzQ5cHZV?=
 =?utf-8?B?TGJIMkxNL3VRazlDcHVFOWl0cUhSdW5xWXZ3a1NCNXJGTHcxZGQ3V3BwRWx1?=
 =?utf-8?B?bURwWFUrQmdpSHJkNmthVEUzZGdhOVRnNThyeHhBWUtSR3VOaHpXTmQ5K2pE?=
 =?utf-8?B?bE1NaGtTclJWeW9oZVh6N1gwQ0M4YUliUnowN2xzc25UdlZvNm55RG9NeWxP?=
 =?utf-8?B?WjV5OFp6Tk9DVjlMMVZxWi9EQ0EvbVBQVU5xeFp6K3FLR3VSUW1YVnFNYjE4?=
 =?utf-8?B?ajg4bXQvRXhFQVp5cFVTUlF0QWlvY3lYMktSSTh0cWtacFVtWG1xT2tBNXN3?=
 =?utf-8?B?K3l3dURhVmRvU3Z1aDdnN1NzbVowdmEzVkpkNHVieEtHTDZpa2JJL1pQWm9B?=
 =?utf-8?B?ZHFpa3B5eGdTUENkT2M5VFQ4VXJYQ0YyUU9UeXIzbHZDM09UWkw5SnEvaWs1?=
 =?utf-8?Q?WVZ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA066E01360F214B91FA816B3E009B98@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7add2c-28d6-4f49-65eb-08de3de101d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 02:56:14.0233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/94kQZCwNZ56ADFmnRykmkd6uCh19ar2L369D4dkAAF84xMDenMCa8DxQqAcKmYHnW1nz+m+kbaDamZNYRE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
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

PiBHRlggcmluZyByZXNldHMgd29yayBkaWZmZXJlbnRseSBvbiBwcmUtR0ZYMTAgaGFyZHdhcmUg
c2luY2UNCj4gDQo+IHRoZXJlIGlzIG5vIE1RRCBtYW5hZ2VkIGJ5IHRoZSBzY2hlZHVsZXIuDQo+
IA0KPiBGb3IgcmluZyByZXNldCwgeW91IG5lZWQgaXNzdWUgdGhlIHJlc2V0IHZpYSBDUF9WTUlE
X1JFU0VUDQo+IA0KPiB2aWEgS0lRIG9yIE1NSU8gYW5kIHN1Ym1pdCB0aGUgZm9sbG93aW5nIHRv
IHRoZSBnZnggcmluZyB0bw0KPiANCj4gY29tcGxldGUgdGhlIHJlc2V0Og0KPiANCj4gMS4gRU9Q
IHBhY2tldCB3aXRoIEVYRUMgYml0IHNldA0KPiANCj4gMi4gV0FJVF9SRUdfTUVNIHRvIHdhaXQg
Zm9yIHRoZSBmZW5jZQ0KPiANCj4gMy4gQ2xlYXIgQ1BfVk1JRF9SRVNFVCB0byAwDQo+IA0KPiA0
LiBFVkVOVF9XUklURSBFTkFCTEVfTEVHQUNZX1BJUEVMSU5FDQo+IA0KPiA1LiBFT1AgcGFja2V0
IHdpdGggRVhFQyBiaXQgc2V0DQo+IA0KPiA2LiBXQUlUX1JFR19NRU0gdG8gd2FpdCBmb3IgdGhl
IGZlbmNlDQo+IA0KPiBPbmNlIHRob3NlIGNvbW1hbmRzIGhhdmUgY29tcGxldGVkIHRoZSByZXNl
dCBzaG91bGQNCj4gDQo+IGJlIGNvbXBsZXRlIGFuZCB0aGUgcmluZyBjYW4gYWNjZXB0IG5ldyBw
YWNrZXRzLg0KPiANCj4gwqANCj4gDQo+IEhvd2V2ZXIsIGJlY2F1c2Ugd2UgaGF2ZSBhIHBpcGVs
aW5lIHN5bmMgYmV0d2VlbiBqb2JzLA0KPiANCj4gdGhlIFBGUCBpcyB3YWl0aW5nIG9uIHRoZSBm
ZW5jZSBmcm9tIHRoZSBiYWQgam9iIHRvIHNpZ25hbCBzbw0KPiANCj4gaXQgY2FuJ3QgcHJvY2Vz
cyBhbnkgb2YgdGhlIHBhY2tldHMgaW4gdGhlIHJlc2V0IHNlcXVlbmNlDQo+IA0KPiB1bnRpbCB0
aGF0IHBpcGVsaW5lIHN5bmMgY2xlYXJzLsKgIFRvIHVuYmxvY2sgdGhlIFBGUCwgd2UNCj4gDQo+
IHVzZSB0aGUgS0lRIHRvIHNpZ25hbCB0aGUgZmVuY2UgYWZ0ZXIgd2UgcmVzZXQgdGhlIHF1ZXVl
Lg0KPiANCj4gwqANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4gDQo+IC0tLQ0KPiANCj4gDQpUZXN0ZWQtYnk6IEppcWlhbiBD
aGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KDQo+IMKgDQo+IA0KDQotLSANCkJlc3QgcmVnYXJk
cywNCkppcWlhbiBDaGVuLg0KDQo=
