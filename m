Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65455CA9EC7
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Oct 2026 15:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF48F10E1DF;
	Sun, 11 Oct 2026 15:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CMCYwSgH";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010069.outbound.protection.outlook.com
 [52.101.193.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3A310E1DF
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Oct 2026 15:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7mOkU8zgK9EfgbI8ZebUx//OK0B+MAVnU4cZpc9wNYRYrfANuYNCeOBkIcyFCBOHEq0alFSwwYOe6zolaSeI106URopYOV1e1umGWkFk0XE21XgIomMIJ/CIDg+Kq7MSQBexoqvj5xZAKwdDga2qbWeiGFoCHuuC+POTgxp7Y+EFDnyGh0iI46EfSHiMbcjyBtErF9UzO2KCX6ZBc7zphVoYbSqBfqzVSnLbXCW6+z7uMIJZS6sCejvJXm5LoR+ob0gLwDSAxDZ04XLpHHgqgynWC1Si918hF+9Xj6tKRPngeR/GmN3KiU4CNCeQaShrINUHNOWEujLSO58MqJQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAjVZFFU+QV93/EN4qDPYtJBY1otTkFihyi7qd3PYGY=;
 b=qGjmnFFuetwFr6SsTS1SqjOM1NkamAjE/BEET5ktmd4AEpeI49i514xhy1PEieN1otbqsK6QpCNKTiDRloZPIMwY43X/kwg9p72QMYBCNqLwpINxLRTDp0fnaycM4z9CYHd4uoYvP92L3g1CYyVoYwE1HNebcWIelz+MW2jaxPHXlBBp34cYqQQ+/EcOs49pP/VN1BF+sBvANqH65We88vKmeo+b48exStOX5IAyD7n/N2dOsQ0JKLoWsUO/QGljcf+sU4H5ueFpM+HLteRJDKW6WlOHdEJfCTV3C7A70CpxzBROIapJnAhQ5nPCQfL8PYxoaxngFOG7U1tezllqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAjVZFFU+QV93/EN4qDPYtJBY1otTkFihyi7qd3PYGY=;
 b=CMCYwSgH45C2iFlz1ANsi7JdpfJfmsZWJQYQ6cMfez6+3Cp5pDJpTHmAgOGir0D/h5d49D/bGdAeVwW5ujVWCS5UFz95ZIPLiaI0Eiz9b68IGGDLdazQawlfX9mrx9dj5cg1GgExgKKAxFdq9yaVPXLgvlYTNNQIfjlwx0fq9bs=
Received: from BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Sun, 11 Oct
 2026 15:32:12 +0000
Received: from BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::3420:a950:a599:eeab]) by BN9PR12MB5258.namprd12.prod.outlook.com
 ([fe80::3420:a950:a599:eeab%6]) with mapi id 15.21.0451.022; Sun, 11 Oct 2026
 15:32:11 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: Re: [PATCH v2 1/2] drm/amd/ras: Use MP1 feature status to select
 fw-managed EEPROM
Thread-Topic: [PATCH v2 1/2] drm/amd/ras: Use MP1 feature status to select
 fw-managed EEPROM
Thread-Index: AQHdWStKQJiekg4pPEK2RxSt2FDqU7b4b2cAgAAIhTo=
Date: Sun, 11 Oct 2026 15:32:11 +0000
Message-ID: <BN9PR12MB525889B93F3220DC22B665BD9D902@BN9PR12MB5258.namprd12.prod.outlook.com>
References: <cover.1791686882.git.cesun102@amd.com>
 <1fbc1515d6cd8f36bb3f60b498b3fbdf6e7b4760.1791686882.git.cesun102@amd.com>
 <BN7PPFFF39339DD20B115CB61A2962AFAA0FC902@BN7PPFFF39339DD.namprd12.prod.outlook.com>
In-Reply-To: <BN7PPFFF39339DD20B115CB61A2962AFAA0FC902@BN7PPFFF39339DD.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-11T14:50:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5258:EE_|SN7PR12MB6715:EE_
x-ms-office365-filtering-correlation-id: 9fe10613-c33b-40ac-1a7f-08df27acd187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|18002099003|8096899003|10067099003|11063799006|4143699003|22082099003|56012099006|38070700021|261009223027099003;
x-microsoft-antispam-message-info: Rxlu6AU4ZvUommE4yE9CoOVt56YEoBEfvb3++EplaSUvl+9IZoA1JPzDZFNjY0lg03Lre5N5DYC3LOpNU78EYcfF5wDlV3gAwsGNsTMIpnbr1lBZlFmHI06bObZ74LRqkb/dTz+gChgX3CPSFFD9kEDpQPJCF19b3WXB7gqKe4OwkeKRRm8kiSX13VTgRAofpSfQwIucWsLLmETygYnXzED5lNchtdr5zeiO+HOpYIeQQG5yJDrd97Vkz/gxbcjP6XKf3bd29DDaqIIj+95QmYDuvV0phKjycS8t+fCi5nW/8jU0ChbkcMTM1AglPEykBrh5vKs7gd9Xt+bpSgKMtcbU4w8UJusbigI2gRrXkLwkotUK35c+QQTklOKKjztExbVN6OtftIlXW0a9FdvePkZgX4fY+MKxockInwo8FRz297BfOewBX8q3RaM/znAvYG/D2/cXHlEyTPdnxRSUa+5LvEtzpOu/iIl+mV0tMIVeKHUVitBk9DmNQ2ANh3Rk3Hr8iS0N/C2g3SYcDAIB1TCluqqHlDK+nzZHipWVlfnf6A8+xiJb4Pc4CeX9VRN7NpQI5uXB53Dd0nGTIofOBCHgOhEoAvy03fxfk6uXzWOeE+2T/htZQasT8H4PIYjNP3vUcOqbHiFJBIDuI2tRY9UhjovxIwQAKaHkEjN5dHZaWwj2FTwqN+YeXTTt5jd2yKfYgM2G3gYgGvwwzvQTgh84CXsk7UweohYZ5YHTDy8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:BN9PR12MB5258.namprd12.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(18002099003)(8096899003)(10067099003)(11063799006)(4143699003)(22082099003)(56012099006)(38070700021)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WlFkTm50L2pwdjRYQkFQaXhuNUZoY3JnVHRWWnJRNnUwSkNVUGh3U1JFelVS?=
 =?gb2312?B?aDZGcUZRZHN2ejVOZ212WUlwREh3aFREazR5cmt2STVrOVlxcUc1ZW42TU5C?=
 =?gb2312?B?dXZ2aks1TkZvbmswbHVsSTM3d3dyaG11RTYzQno4ZlRhOGJPM3pUQ1lCdzJ2?=
 =?gb2312?B?OHcyVGVOVnhhanl1MEtvaEd6SW9xNmtsS3BUaWs5WHNmSCtITkI0UVVkVGM0?=
 =?gb2312?B?RTczT0JSWDdHQURhUW5aL2JvK1lBTnp4eUNhK05DUkUzNEIzdkUvNndZRlRh?=
 =?gb2312?B?ckJQUG9oL2FoYlRjTEhyV1Z6SHpOemJ0R2QwdTdrVmlocnE2SnBSQ2dHTVdI?=
 =?gb2312?B?N2VwcnlUQUNWenByaUpQQkdqbEJ3MWdMQk1XOHF0Z1ZQWDdsOXdmc01iTW8v?=
 =?gb2312?B?ek9nZERvUllyQjk5SExrVlpYRlVzL1pJWmY0Y1NpeXNXNVo0ZTE3dlRwaUxt?=
 =?gb2312?B?Tnh3Q3RKdlFJdHpFNDZXcHBxTFBtbDhhdE15aU85cC84REdaYmFZL1N3V04y?=
 =?gb2312?B?akZ4ZHdCdlBaVmwweEhMV3htUHpPQmhiUitkOEJiREJyTW5OdzdOaUlzQkFH?=
 =?gb2312?B?aTg4QU5PQTJ2WFA0ZHR0YzFwK0crby9tMlB5NzhtVWlPS1RpNURUTm9YWk0v?=
 =?gb2312?B?b1JwSG04V3ZSRmJ1MlpEWGZtOXJ4TzN1d205TVRQMTNoWjJLL3ZyVFJtVG1a?=
 =?gb2312?B?TjdZcWR6WE9uZ21pNWpHSHh3bmUydFJKT1NJck1ObHhBVU12cis4eXA3R045?=
 =?gb2312?B?d010RU1LZ3R2ejdRTnFQdjNSVFliYThWTzRjNE40Y3pPODVrR1ZuQkN0R3lW?=
 =?gb2312?B?R0tjM2xNWSsxajliNkVwNU40RVNyWGFnOVkydDZSaU5JV013T3JTV2paVnRQ?=
 =?gb2312?B?QWtRNzZYLzFFRmplcHltQ3RDbzlNbWsyYnhkMXpFTUxiWFRHSkllMCtEZUV4?=
 =?gb2312?B?dWd5UkovejFhV09kcWs2NkRiTWlZLzhJa3NGUmJYajlET09nRXlaQ1FxeXB6?=
 =?gb2312?B?MlVwNG9GTFhOaExTUW9BOXJHaFoxNnluY3lPeWtnVEROSnFIRWlTeUlLdURj?=
 =?gb2312?B?RVQvaG8xNmlGMHNiSHlLcGo4MC9WWGdvd0s4akNWQk02cXpaU0ZjbjBGRUJu?=
 =?gb2312?B?dGI1ZVhxSzFiU0NqSHBvaHl1RUtnNnlkMEJxVFZQRFZqSE5vZUVIYXU2RDUw?=
 =?gb2312?B?Y0RuNzJ2VTBaOEE3TEN4ZTV1ejU4ajIzOUZMSWlOS3VkZDR4TFR4bDNNTVlN?=
 =?gb2312?B?My9yanp4MWViY0k2eDdpNm05TDFoRWQ5UnBEd3J6UDg4WW5RZDVSdXNCa0g3?=
 =?gb2312?B?bHc3TVpEbGtmamdNZVAySnZMMy90WDZUbFJZU2FZQ2VKKys3TkJTWHE3aXZo?=
 =?gb2312?B?MnVweGUrVjZxVTA5RDhQNmptbVJCakdrWmxJbk5MbDNxem9iaUFQWkltdlJh?=
 =?gb2312?B?MExWUGtRZ252YzBuOE5PVWx0ZzNVQWROU2JKczdqeHBhVE53RFdLYmx0SCs3?=
 =?gb2312?B?Vm0xU3BmZFVWY0ZEWWZzMkZoamdHUU16T2Nha3dsL0NhVVhCME1HVXFjakJG?=
 =?gb2312?B?QnJCY3JhODRjU2VRbDdsL2tjaHlVK2xrVUFmampNdDkyY3d3NDFOcWt4SmdI?=
 =?gb2312?B?aWhINDM2Y2NSQWZTUm9zVkJLSEt2aURWSHhCcWJ0bTNJd3laQS9ZY0xlSXhs?=
 =?gb2312?B?TEMxdUxBa0xZT0c5eDlXcUhvenV0eXVKZkpDT01KWmlJR2lEdEd2RitYN1po?=
 =?gb2312?B?dTFSTE03Zy8wc3N5eWJTM1IrVUwvSFZGd1ZvV25yVVJTeVQvS1RZTytSbkFL?=
 =?gb2312?B?VVNhbU9lN0hOcWI3OVBqNVVJWjV0K0p3VjhTcjBGSXVwTVFic0ZjRC9uelJU?=
 =?gb2312?B?MmtVWDJCcmFPelJQVzkreWhrdXhQS3VsbVhuK1oybjJvT1lNL053YVJ4Q0pD?=
 =?gb2312?B?ZTkzWkR0c1JXZ2wwQnV5TUJVQ2dSSndHeXU1OXJ6b01OZjl0OTlKRHVzdDcv?=
 =?gb2312?B?WWQrazJtL2c1RkRINGc0bmM4aWYvOEcwODZzMm9RckpsTmd4cU1lRmtZVHp2?=
 =?gb2312?B?c2d2SXc1NnhxekF5RTJEM1JrbjVyNWNXcG8vdjlwc1hPYkgySEVnSGIxWUl6?=
 =?gb2312?B?MWJuVFBMRW93OFFoQjBKTDI4SlRxNFI5QTk1ampTQ1k2MWpyYzhRY3gxVTd4?=
 =?gb2312?B?TkxYK0F2bUlJWWtmZ2t4SHNxRUh0a1RwVFlXRzhUR0JSRHVEdDRtWjlJcnND?=
 =?gb2312?B?blE3UHY5U2NkWGU4SXp4eUJZRlY2aFZmeHBLZWYvR3g0eWRwejhlR0x5S2xh?=
 =?gb2312?B?L2NGVVpReWR3YjhMMGVwWkRtTVpITUk4OEErQzlNRHhWRjMwY0VSQnNNTjli?=
 =?gb2312?Q?G85nOqDOB6FfqFcueiXBUfZ2tXy2tadcPAjW/FYh5x4T7?=
x-ms-exchange-antispam-messagedata-1: c1U5UOzKTaXzrw==
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525889B93F3220DC22B665BD9D902BN9PR12MB5258namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe10613-c33b-40ac-1a7f-08df27acd187
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 15:32:11.3032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xg6kgDHpUsbf0Q4V5riL8gdyQskTdxiBRaRZBbjac/TGSqQVwkm0jdkKLNmqD0nFRBvexDBcoNXiN7aPyzKJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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

--_000_BN9PR12MB525889B93F3220DC22B665BD9D902BN9PR12MB5258namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

QU1EIEdlbmVyYWwNCg0KSGkgSGF3a2luZywNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpUaGUg
cmVhc29uIGlzIHRoYXQgZm9yIE1JMzUwUCwgaXRzIE1QMSBpcyB2MTNfMF8xMiAoMHhkMDAwYzAw
ID0gSVBfVkVSU0lPTigxMywgMCwgMTIpKSwgd2hpbGUgb25seSBNUDAgaXMgdjEzXzBfMTUuIFNp
bmNlIHRoaXMgY29kZSBwYXRoIHRhcmdldHMgTVAxLCB0aGUgb2xkIGltcGxlbWVudGF0aW9uIHdh
cyBpbmNvcnJlY3QgYW5kIHdlIGZpeGVkIGl0IGluIHRoaXMgcGF0Y2guDQoNClRoYW5rcywNCkNl
IFN1bg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogWmhhbmcsIEhh
d2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCreiy83KsbzkOiBTdW5kYXksIDExIE9jdG9i
ZXIgMjAyNiAyMjo1Nzo0NA0KytW8/sjLOiBTdW4sIENlKE92ZXJsb3JkKSA8Q2UuU3VuQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+DQqzrcvNOiBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+OyBaaG91
MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0Bh
bWQuY29tPjsgU3VuLCBDZShPdmVybG9yZCkgPENlLlN1bkBhbWQuY29tPg0K1vfM4jogUkU6IFtQ
QVRDSCB2MiAxLzJdIGRybS9hbWQvcmFzOiBVc2UgTVAxIGZlYXR1cmUgc3RhdHVzIHRvIHNlbGVj
dCBmdy1tYW5hZ2VkIEVFUFJPTQ0KDQpBTUQgR2VuZXJhbA0KDQotICAgICAgIGNhc2UgSVBfVkVS
U0lPTigxMywgMCwgMTQpOg0KICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDEyKToNCi0g
ICAgICAgY2FzZSBJUF9WRVJTSU9OKDEzLCAwLCAxNSk6DQorICAgICAgIGNhc2UgSVBfVkVSU0lP
TigxMywgMCwgMTQpOg0KDQpCb3RoIHYxM18wXzEyIGFuZCB2MTNfMF8xNSBjYW4gcmVseSBvbiB0
aGUgUE1GVyBmZWF0dXJlIGJpdHMgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgdGhlIGZlYXR1cmUgaXMg
c3VwcG9ydGVkLCBjb3JyZWN0PyBJZiBzbywgd2h5IGlzIG9ubHkgdjEzXzBfMTUgcmVtb3ZlZD8N
Cg0KQWRkaXRpb25hbGx5LCBzaW5jZSB2MTNfMF8xNSBoYXMgYmVlbiByZW1vdmVkIGZyb20gdGhl
IHN3aXRjaCBzdGF0ZW1lbnQsIGNvdWxkIHRoaXMgY2F1c2UgYSBOVUxMIHBvaW50ZXIgdG8gYmUg
cmV0dXJuZWQgYmVmb3JlIHRoZSBmZWF0dXJlIHN0YXR1cyByZXBvcnRlZCBieSBQTUZXIGlzIGNo
ZWNrZWQ/DQoNClJlZ2FyZHMsDQpIYXdraW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgQ2UgU3VuDQpTZW50OiBTdW5kYXksIE9jdG9iZXIgMTEsIDIwMjYgMTA6NTAg
QU0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5j
b20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkgPFN0YW5s
ZXkuWWFuZ0BhbWQuY29tPjsgU3VuLCBDZShPdmVybG9yZCkgPENlLlN1bkBhbWQuY29tPg0KU3Vi
amVjdDogW1BBVENIIHYyIDEvMl0gZHJtL2FtZC9yYXM6IFVzZSBNUDEgZmVhdHVyZSBzdGF0dXMg
dG8gc2VsZWN0IGZ3LW1hbmFnZWQgRUVQUk9NDQoNClJlYWQgdGhlIGZlYXR1cmUgc3RhdHVzIG9m
IFJBU19DT1JFX0ZXX0ZFQVRVUkVfQklUX1JBU19FRVBST00NCnRvIGRldGVybWluZSB3aGV0aGVy
IHRvIHVzZSBmaXJtd2FyZS1tYW5hZ2VkIEVFUFJPTS4NCg0KU2lnbmVkLW9mZi1ieTogQ2UgU3Vu
IDxjZXN1bjEwMkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvY29yZS9y
YXMuaCAgICAgICAgICAgIHwgIDIgKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9jb3JlL3Jh
c19lZXByb21fbWdyLmMgfCAyNCArKysrKysrKysrKysrLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2Vk
LCAxOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9yYXMvY29yZS9yYXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL2Nv
cmUvcmFzLmgNCmluZGV4IDczZTM5NjBjN2M4ZS4uMWI3MjRhYTIzNTk0IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvY29yZS9yYXMuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9yYXMvY29yZS9yYXMuaA0KQEAgLTYwLDcgKzYwLDcgQEAgZW51bSByYXNfZ3B1X2hlYWx0
aF9zdGF0dXMgeyAgfTsNCg0KIGVudW0gcmFzX2NvcmVfZndfZmVhdHVyZV9mbGFncyB7DQotICAg
ICAgIFJBU19DT1JFX0ZXX0ZFQVRVUkVfQklUX19SQVNfRUVQUk9NID0gQklUX1VMTCgwKSwNCisg
ICAgICAgUkFTX0NPUkVfRldfRkVBVFVSRV9CSVRfX1JBU19FRVBST00gPSAwLA0KIH07DQoNCiBl
bnVtIHJhc19ibG9ja19pZCB7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMv
Y29yZS9yYXNfZWVwcm9tX21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvY29yZS9yYXNf
ZWVwcm9tX21nci5jDQppbmRleCBmZTBlMzUzNTdhZjEuLmM2ODY5YjRlZjU5OCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL2NvcmUvcmFzX2VlcHJvbV9tZ3IuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvY29yZS9yYXNfZWVwcm9tX21nci5jDQpAQCAtMjYsNiAr
MjYsNyBAQA0KICNpbmNsdWRlICJyYXMuaCINCiAjaW5jbHVkZSAiZWVwcm9tLmgiDQogI2luY2x1
ZGUgImVlcHJvbV9mdy5oIg0KKyNpbmNsdWRlICJyYXNfbXAxLmgiDQoNCiBzdGF0aWMgYm9vbCBf
X3Jhc19lZXByb21fZGlzYWJsZWQoc3RydWN0IHJhc19jb3JlX2NvbnRleHQgKnJhc19jb3JlKSAg
eyBAQCAtMzYsMjUgKzM3LDM0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmFzX2VlcHJvbV9vcHMg
KnJhc19lZXByb21fbWdyX2dldF9pcF9mdW5jKA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUsIHVpbnQzMl90IGlwX3ZlcnNp
b24pICB7DQogICAgICAgIHN0cnVjdCByYXNfZWVwcm9tX21nciAqbWdyID0gJnJhc19jb3JlLT5l
ZXByb21fbWdyOw0KKyAgICAgICBpbnQgcmV0ID0gMDsNCisgICAgICAgdTMyIHN0YXR1cyA9IDA7
DQorDQorICAgICAgIHJldCA9IHJhc19tcDFfY2hlY2tfZmVhdHVyZV9zdGF0dXMocmFzX2NvcmUs
IFJBU19DT1JFX0ZXX0ZFQVRVUkVfQklUX19SQVNfRUVQUk9NLCAmc3RhdHVzKTsNCisgICAgICAg
aWYgKHJldCkNCisgICAgICAgICAgICAgICBSQVNfREVWX0VSUihyYXNfY29yZS0+ZGV2LCAiQ2hl
Y2sgUkFTIEVFUFJPTSBmZWF0dXJlIGZhaWxlZCwgcmV0PSVkIiwNCityZXQpOw0KDQogICAgICAg
IHN3aXRjaCAoaXBfdmVyc2lvbikgew0KICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDYp
Og0KLSAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDE0KToNCiAgICAgICAgY2FzZSBJUF9W
RVJTSU9OKDEzLCAwLCAxMik6DQotICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMywgMCwgMTUpOg0K
KyAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDE0KToNCiAgICAgICAgICAgICAgICBtZ3It
PmVlcHJvbV9lYXJseV9pbml0X3NlcnZpY2Vfc3VwcG9ydGVkID0gZmFsc2U7DQotICAgICAgICAg
ICAgICAgcmV0dXJuICZyYXNfZHJ2X2VlcHJvbV9vcHM7DQorICAgICAgICAgICAgICAgYnJlYWs7
DQogICAgICAgIGNhc2UgSVBfVkVSU0lPTigxNSwgMCwgOCk6DQogICAgICAgICAgICAgICAgbWdy
LT5lZXByb21fZWFybHlfaW5pdF9zZXJ2aWNlX3N1cHBvcnRlZCA9IHRydWU7DQotICAgICAgICAg
ICAgICAgbWdyLT5md19yZWNvcmRfZW5hYmxlZCA9IHRydWU7DQotICAgICAgICAgICAgICAgcmV0
dXJuICZyYXNfZndfZWVwcm9tX29wczsNCisgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAg
ZGVmYXVsdDoNCiAgICAgICAgICAgICAgICBSQVNfREVWX0VSUihyYXNfY29yZS0+ZGV2LA0KICAg
ICAgICAgICAgICAgICAgICAgICAgIkVFUFJPTShNUDEpIGlwIHZlcnNpb24oMHgleCkgaXMgbm90
IHN1cHBvcnRlZCFcbiIsIGlwX3ZlcnNpb24pOw0KLSAgICAgICAgICAgICAgIGJyZWFrOw0KKyAg
ICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KICAgICAgICB9DQoNCi0gICAgICAgcmV0dXJuIE5V
TEw7DQorICAgICAgIGlmIChzdGF0dXMpIHsNCisgICAgICAgICAgICAgICBtZ3ItPmZ3X3JlY29y
ZF9lbmFibGVkID0gdHJ1ZTsNCisgICAgICAgICAgICAgICByZXR1cm4gJnJhc19md19lZXByb21f
b3BzOw0KKyAgICAgICB9IGVsc2Ugew0KKyAgICAgICAgICAgICAgIHJldHVybiAmcmFzX2Rydl9l
ZXByb21fb3BzOw0KKyAgICAgICB9DQogfQ0KDQogaW50IHJhc19lZXByb21fbWdyX3N3X2luaXQo
c3RydWN0IHJhc19jb3JlX2NvbnRleHQgKnJhc19jb3JlKQ0KLS0NCjIuMzQuMQ0KDQo=

--_000_BN9PR12MB525889B93F3220DC22B665BD9D902BN9PR12MB5258namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<span style=3D"color: rgb(0, 0, 0);">Hi Hawking,&nbsp;</span></div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<span style=3D"color: rgb(0, 0, 0);">Thanks for your review.<br>
The reason is that for MI350P, its MP1 is v13_0_12 (0xd000c00 =3D IP_VERSIO=
N(13, 0, 12)), while only MP0 is v13_0_15. Since this code path targets MP1=
, the old implementation was incorrect&nbsp;and we fixed it in this patch.<=
/span></div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, =
-apple-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" id=
=3D"ms-outlook-mobile-signature" dir=3D"auto">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Th=
anks,<br>
Ce Sun</span><span style=3D"font-family: Aptos, Aptos_MSFontService, -apple=
-system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(=
33, 33, 33);"><br>
</span></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Zhang, =
Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Sunday, 11 October 2026 22:57:44<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gf=
x@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhou1, Tao &=
lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Sun, =
Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> RE: [PATCH v2 1/2] drm/amd/ras: Use MP1 feature status=
 to select fw-managed EEPROM</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">AMD General<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 14):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 12):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 15):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 14):<br>
<br>
Both v13_0_12 and v13_0_15 can rely on the PMFW feature bits to determine w=
hether the feature is supported, correct? If so, why is only v13_0_15 remov=
ed?<br>
<br>
Additionally, since v13_0_15 has been removed from the switch statement, co=
uld this cause a NULL pointer to be returned before the feature status repo=
rted by PMFW is checked?<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ce=
 Sun<br>
Sent: Sunday, October 11, 2026 10:50 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.C=
hai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;St=
anley.Yang@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
Subject: [PATCH v2 1/2] drm/amd/ras: Use MP1 feature status to select fw-ma=
naged EEPROM<br>
<br>
Read the feature status of RAS_CORE_FW_FEATURE_BIT_RAS_EEPROM<br>
to determine whether to use firmware-managed EEPROM.<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/ras/core/ras.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 24 +++++++++++++-----=
-<br>
&nbsp;2 files changed, 18 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/c=
ore/ras.h<br>
index 73e3960c7c8e..1b724aa23594 100644<br>
--- a/drivers/gpu/drm/amd/ras/core/ras.h<br>
+++ b/drivers/gpu/drm/amd/ras/core/ras.h<br>
@@ -60,7 +60,7 @@ enum ras_gpu_health_status {&nbsp; };<br>
<br>
&nbsp;enum ras_core_fw_feature_flags {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =
=3D BIT_ULL(0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =
=3D 0,<br>
&nbsp;};<br>
<br>
&nbsp;enum ras_block_id {<br>
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/dr=
m/amd/ras/core/ras_eeprom_mgr.c<br>
index fe0e35357af1..c6869b4ef598 100644<br>
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c<br>
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c<br>
@@ -26,6 +26,7 @@<br>
&nbsp;#include &quot;ras.h&quot;<br>
&nbsp;#include &quot;eeprom.h&quot;<br>
&nbsp;#include &quot;eeprom_fw.h&quot;<br>
+#include &quot;ras_mp1.h&quot;<br>
<br>
&nbsp;static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)&=
nbsp; { @@ -36,25 +37,34 @@ static const struct ras_eeprom_ops *ras_eeprom_=
mgr_get_ip_func(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_core_context *ras_core, uin=
t32_t ip_version)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_eeprom_mgr *mgr =3D &=
amp;ras_core-&gt;eeprom_mgr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 status =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D ras_mp1_check_feature_status(=
ras_core, RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM, &amp;status);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RAS_DEV_ERR(ras_core-&gt;dev, &quot;Check RAS EEPROM feature fai=
led, ret=3D%d&quot;,<br>
+ret);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ip_version) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 14):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 12):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 15):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 14):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mgr-&gt;eeprom_early_init_service_supported =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return &amp;ras_drv_eeprom_ops;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(15, 0, 8):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mgr-&gt;eeprom_early_init_service_supported =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mgr-&gt;fw_record_enabled =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return &amp;ras_fw_eeprom_ops;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; RAS_DEV_ERR(ras_core-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;EEPRO=
M(MP1) ip version(0x%x) is not supported!\n&quot;, ip_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mgr-&gt;fw_record_enabled =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return &amp;ras_fw_eeprom_ops;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return &amp;ras_drv_eeprom_ops;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
<br>
&nbsp;int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB525889B93F3220DC22B665BD9D902BN9PR12MB5258namp_--
