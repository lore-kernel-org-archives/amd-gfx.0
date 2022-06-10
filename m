Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FC9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 04:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1929112CA2;
	Fri, 10 Jun 2022 04:17:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7068112F37
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 04:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFd4zvdtRlTuYy1+yOB3RovdkM8JUZR0Sqi2UaseCmmGCnRSBgwWFptGeMrIPi1cxfkUlyM29jnm9qwkEoIog4vfbZ6272VsLuusUzEdxePeIc5gwYFRyhzrmvz9Gq22P/E/Rn5yuaw/Co2eH+lSa6oIOogvFaFCzYrh8Gz6ov53V8FGsUv1OkI4dm1kFBs129yynVs4LJTnswWed7i+w43OaiVg++NJ5ZBOjd4iZw2IvjpAtOQ4iAVB9hzAv82Obg2MGUNUvpSpLrUleM+xVN3WC6khbYiRkkvVbNFdJo8UqozuNuNzP8m6Xo6GeHAq4GqNvykvYScKhSQ/nP34SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9yzVbj+l12yKZXVavpUvG8VwXwVGrlZ/TCoyG261Rs=;
 b=BWXym5+DsKO0bchTHotWDISmf+cE3AXlyfN1PDPZC511wRq+eNxa6LzbnR+Ok9xX3HOkQ4FsA1tZzHSAz+JMgEdBInl8c3NCVBZ2zM6GFizBznyNah75hjOMPLaKZnmdFJmQq0/WCbterYOY0/DT0zdwjVhX5MlfyW6pmQLsGIHX79rIKCA5T1KtVnHiLcs9YIRAzmsdvwrDMkad7/KUoNpRYC8O9wrBFd1vgekvQ7KbBelMh1bkBIX6edaU6qQiRiLPrNfvQ0hAydszGWC7H9BBZvN95oWzZJ7n27Y0Rr8Jm7tuzAL4GWlsW+YVTDgpcz0ldOP/ENdgdoaTcGF9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9yzVbj+l12yKZXVavpUvG8VwXwVGrlZ/TCoyG261Rs=;
 b=FN3pNqnE7HyXl6KLc3h3PNkPIto45NpiU43kHQ1iuKbvNWoAfp9BrpBJtfF950bqNmVuFsbEgnyIpomfCP36WJcaxLzHQbyS0Z1Jg2ejeBDPcRWi48+4O5HxIO4/00KaV4AkK1f+NFAwLpcuYKQaierLGbb9XAeYgBu96gGlHps=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (13.101.60.9) by
 MW3PR12MB4539.namprd12.prod.outlook.com (20.181.54.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Fri, 10 Jun 2022 04:17:02 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::7516:71e8:f04d:83c7]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::7516:71e8:f04d:83c7%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 04:17:02 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vYW1kL3BtOiBza2lwIHRvIHNldCBtcDEgdW5s?=
 =?gb2312?Q?oad_state_in_special_case?=
Thread-Topic: [PATCH] drm/amd/pm: skip to set mp1 unload state in special case
Thread-Index: AQHYfH2Fki9RPbBsC0iDbNrNYTSdra1ICNxF
Date: Fri, 10 Jun 2022 04:17:02 +0000
Message-ID: <DM4PR12MB5165D29462CD6F3006B6B3E38EA69@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220610035212.3514499-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220610035212.3514499-1-KevinYang.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-10T04:16:55.9439495Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24358ef8-f13f-4c3b-76dd-08da4a981240
x-ms-traffictypediagnostic: MW3PR12MB4539:EE_
x-microsoft-antispam-prvs: <MW3PR12MB45397F622A414F1CBF75ED778EA69@MW3PR12MB4539.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXpOWZKnXjlqTAS+DOW162WmU4wWFgC4uq+CvUKhSbe9iPulieHljTxXUfF6r1Vb/pocnMaNPbnH+w9C75DYDuyht2xD8Ki5ngScmhI/EEk4CbEbpPT2VqEu+KBhUC5ts/apeF/81ZolEtrXusaahJiIb8zAa1LhwrDGpyKKwAfhL+jWoNa2m6da+RXloQcnDhy5D7KBWpynPDQ/EQIvjCvxCgAxrWwnJnW6a6KNq7cUlPh9omi1BsUhjX6bCrGHW6g1fjPWOP2WMkPc95svkoR1S5F41ohXa+Qjl+jzCIYEU3YEhLrtWjVcCyiBJExwhLw5+ioPVMed7xE/8FCBv9qQI0b1H9ydZlmkSmp/EiOXN2SJ82Tw49oXYPFtPj03iWfhuvvqxNmP6N67RxfCq1ZX0hi3h6urvCA55PVfw1Pu5Zk8XsKp20bLNlsJQEXloLLLqQ7XLTnElxIyijQllrD/6rvHbcGyfhxzst6pDLq5SH2tU4+3TmGc6PXh+Zp89C7mxOzZ0CX9JnviySd7hLynO9bKrAV56u/0VojLZjXgsUnb9keplN6AeE6cQqglF5F1SWinZ7uSibbu1kz3Ev5oJKaD3DvGHoB7SyjlsSeWiKNFlpyGCv7MgmgeKvOyn7jzicXpPlhqf8JJ450v1I7/t8jdtXd5xp8BcdwJwwWNXNw03lgLrKa06P6kqhyEh4YxlPQmx8wMojOzVWFVpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(122000001)(83380400001)(186003)(38100700002)(7696005)(38070700005)(6506007)(508600001)(110136005)(71200400001)(26005)(86362001)(316002)(91956017)(9686003)(2906002)(52536014)(66476007)(66446008)(66946007)(66556008)(64756008)(76116006)(5660300002)(4326008)(8936002)(224303003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OHcrY3hvbzREa2ZyS3grb1VrYW05VG9OVW90ZTJVcWtVY3Nha1JFRE9OdkJ1?=
 =?gb2312?B?Q3QwL05OaFdrMVBkcGJEbTFYL0N1T3B3UzJLRkcwb3p0djIzN3VZUllqWkVt?=
 =?gb2312?B?SmZKd0ptV2w4ekVYZTFHOWpkbjl6d3NlQWF6NHVmOTM0a1gzeHk5TmhZMW91?=
 =?gb2312?B?cHRjdUxBazlCc2NHc2ZDeDA2K0pKMEhMUUtDUTVYeHlVK0o0OFIyS2tXN0du?=
 =?gb2312?B?bjlQN3Z6NktxNEI3SWJyZldzZEJzYTlEV1kyQ01BaDVTU3FhdXp4S2F4T25M?=
 =?gb2312?B?bjgzUlJ6QjBTbnpBSTRvOWV5d0hqQnVFM2hWZmNxcS8wdE1FaVA0T0w1OVE4?=
 =?gb2312?B?Mnd0M2dLVVIySnNUUEgrTktWdndkVGlLOGp1ejQ4MUJFRUxOdUdtWnVHdExz?=
 =?gb2312?B?b1VIb1AwdnFqOWx6bHdEUithK2NoQk1zQXU2RDErN1Q2YU04VU1tSmRYZEJ5?=
 =?gb2312?B?ZThzN3AvZlp3UGViekw3MlFpTlEzQWdqdTVmVmdkaGRTMTdaSER4NUlLeVJP?=
 =?gb2312?B?SVpqVnJCMitJUTFrS1k1Y3pMNlNvR1BEOHpsbzE5RHhoWkJNbFZiNmlrNjAr?=
 =?gb2312?B?VDZpN2ZGc3B0OUU0eDg1RVdjSVhWM05lajBZZTVnNnJMSk1lUGVnSU5kajVn?=
 =?gb2312?B?cFhObGgyS09FT3NFalY4UjJ0TFlsQ3dpanhuUFE5czhrZng2Wjk3SkhjRXVw?=
 =?gb2312?B?a08yeGx1aEt5RW1SQ3JkYi9WRTJyVW1BcEtRckJ4T25aNmtZRys2NktUV1Iw?=
 =?gb2312?B?YUUrQzM3RmRCZTNCTThSRVFTSVQxWWJEMi80Yk00T1M2VVVjYlQ0YnhnTmZm?=
 =?gb2312?B?NU4xbkl4dVZ6Nk1QaG9jZWVFamhscTJiWG9LS3cxaWVUUkRtY1M3bW94aFJD?=
 =?gb2312?B?YlpRNnlVTGZZcDRaOHE2N2JwYThBalQrYnFqSGQvUU1hSlQ1c2Npem5Edklq?=
 =?gb2312?B?dUJNSE5JUitqeVlJUHJ2OWt2NkpKaW90bDU0WkNueVRHV1p6ZVpDSXN0VDRq?=
 =?gb2312?B?bUpmbWdUMWgwWEdkMjBxTG5FSklyNHpxZzl5UnN4Rzg4NWdrYVQrMm5EZ1pE?=
 =?gb2312?B?TUN3Z1F5NW9WL28zdG53NzlZbWRWVDZQTVp6UnhlYno0SXNiQ2ZmckRXT3Iv?=
 =?gb2312?B?Rk1VeENoQjlnMFZxbDJtejZiNFIyMlFEaUdaRFcyRkhPclVpZ1FvN0RiNy82?=
 =?gb2312?B?NTAzV01zdm5GY2srbjJCd1o5RitBYURVNVR4VDhSVnB4dldsRkxjWnZvV0FE?=
 =?gb2312?B?dXl2My9CSEZkT1cwR1lMdStGSm5jOUkxaVZZS05uZWdqNyt4S09BNGNpVU0x?=
 =?gb2312?B?cUZOYjUwUjFkUWlEVDFxYXpPbmQ5L1Nqdmo1TXkvakZaV2hHWi83R2ppTGJm?=
 =?gb2312?B?T3NNemNKd2FJV3A3TC9zdUxkaTlZVXh6bTB6REVSS0VVOEczOFhCLzYxd242?=
 =?gb2312?B?NFhuS3dRbWthWG4wU0dBM0tpSU1sMWNZQk5Da3dSeW9RQml3U1pjSU1ZblpL?=
 =?gb2312?B?T0VwdFpZbjVFRkxkZWxpeVFWZ0l6L3RsTGxNZ0poZ1ZNdWV1L3V5amtUZzZC?=
 =?gb2312?B?Vy9YVWYrUlpBZGFzWUx5bVBPM1dQVm9mc1E2bWk3VjQ1bHRNRzMxVEJxdjBS?=
 =?gb2312?B?V1ZpK2EyYVA0dGxobHJhR1dJYTh4akFZb2NVNGtOZGFPVjN6RnAwZm5pUXZL?=
 =?gb2312?B?K1FjTUdJc1l5czBTc0dENFY3cHU4ejR1UWV3UURQY0VYdXE2ZGUxV0pPWkUz?=
 =?gb2312?B?b0xocW1JTklERTAxUUhhazZLRUE5VCs1QVJwWkFNTGhGaC9aSmszYzNIRmMr?=
 =?gb2312?B?dEwrZUc5MWI0K2FvaGNLWFVpa2g4TXlEMkhJRTNZMTZ2c1pDRFRYcktmd0xu?=
 =?gb2312?B?UDk2N2RnUm8zaDVhVVJac29CSVN6SytxMDMwTWZhTGVCdDNKMlY1WFFLRmN1?=
 =?gb2312?B?N245SVBTN2E5bU10ZXZxREsrelY4S3I4eHN4SDJiNHpObHNpc1ZWV0djdXVC?=
 =?gb2312?B?UTBHME1kdUxCQUg5TDNObUlHUnhUUEZ3dGczbHc5SEJzcGNkMjk2ZHBwbG9Y?=
 =?gb2312?B?MmhTUWd5c1c2Y0YySUlIR3RMVFk2cWJrOE4zQ2dFZzdpQUsvTDF4UmI0ZmRZ?=
 =?gb2312?B?SzlFQWVpM3U5TlRzT05XQTBCU1ZNS3JnZXNMeTZZUXk0WXpzQUp2SjJtNzlw?=
 =?gb2312?B?R3dpZVR1VitCYTMyZWVpQzBwZjhYZHpDRjVpYkJlbC9pNW9lNXhDWDZNeG9Q?=
 =?gb2312?B?dHErbEVOcEZ2N2VFZUJQbFhiT1Iza0szNlRDY3ZpdFYzeVpLcHFXNFYvSWdM?=
 =?gb2312?B?VzFDajVDUUJJRU01d2dvU0NnUFVaY0RlYXAxRmo4aW9uSWYxbjFWdz09?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5165D29462CD6F3006B6B3E38EA69DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24358ef8-f13f-4c3b-76dd-08da4a981240
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 04:17:02.7577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /O3MotSFwKOOn3MzWDtsFgKDgNe7o/bLf0K50NWBwIO1H39qMK5Cu9NvRW5+yaMc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5165D29462CD6F3006B6B3E38EA69DM4PR12MB5165namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEdlbmVyYWxdDQpSZXZpZXdlZC1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdA
YW1kLmNvbTxtYWlsdG86a2VubmV0aC5mZW5nQGFtZC5jb20+Pg0KDQoNCkJlc3Qgd2lzaGVzDQpL
ZW5uZXRoIEZlbmcNCg0KDQq3orz+yMs6IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmc+ILT6se0gWWFuZyBXYW5nIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0K
yNXG2jog0MfG2s7lLCAyMDIyxOo21MIxMMjVIDExOjUyDQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCrOty806IEZl
bmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPiwgV2FuZywgWWFuZyhLZXZpbikgPEtl
dmluWWFuZy5XYW5nQGFtZC5jb20+DQrW98ziOiBbUEFUQ0hdIGRybS9hbWQvcG06IHNraXAgdG8g
c2V0IG1wMSB1bmxvYWQgc3RhdGUgaW4gc3BlY2lhbCBjYXNlDQpbQ0FVVElPTjogRXh0ZXJuYWwg
RW1haWxdDQoNCnNldCBtcDEgdW5sb2FkIHN0YXRlIHdpbGwgY2F1c2UgdGhlIFNNQyBGVyBjYW4n
dCBhY2NlcHQgYW55IFNNVSBtZXNzYWdlLA0Kc2tpcCB0byBzZXQgbXAxIHVubG9hZCBzdGF0ZSB0
byBhdm9pZCBmb2xsb3dpbmcgY2FzZSBmYWlsOg0KLSBydW50aW1lIHBtIGNhc2UuDQotIGdwdSBy
ZXNldCBjYXNlLg0KDQpGaXhlczogODI2MTI2ZDhmODA1ICgiZHJtL2FtZC9wbTogZml4IGRyaXZl
ciByZWxvYWQgU01DIGZpcm13YXJlIGZhaWwgaXNzdWUgZm9yIHNtdTEzIikNCg0KU2lnbmVkLW9m
Zi1ieTogWWFuZyBXYW5nIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgfCAxMSArKysrKystLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQppbmRleCAzZDI2OWQxYzI3NDkuLmZkNzli
MjEzZmFiNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1
X3NtdS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0K
QEAgLTE0MTUsMTIgKzE0MTUsMTMgQEAgc3RhdGljIGludCBzbXVfZGlzYWJsZV9kcG1zKHN0cnVj
dCBzbXVfY29udGV4dCAqc211KQ0KICAgICAgICBzd2l0Y2ggKGFkZXYtPmlwX3ZlcnNpb25zW01Q
MV9IV0lQXVswXSkgew0KICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDApOg0KICAgICAg
ICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDcpOg0KLSAgICAgICAgICAgICAgIHJldCA9IHNtdV9z
ZXRfbXAxX3N0YXRlKHNtdSwgUFBfTVAxX1NUQVRFX1VOTE9BRCk7DQotICAgICAgICAgICAgICAg
aWYgKHJldCkgew0KLSAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJG
YWlsIHNldCBtcDEgc3RhdGUgdG8gVU5MT0FEIVxuIik7DQotICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KKyAgICAgICAgICAgICAgIGlmICghKGFkZXYtPmluX3J1bnBtIHx8IGFt
ZGdwdV9pbl9yZXNldChhZGV2KSkpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHNt
dV9zZXRfbXAxX3N0YXRlKHNtdSwgUFBfTVAxX1NUQVRFX1VOTE9BRCk7DQorICAgICAgICAgICAg
ICAgICAgICAgICBpZiAocmV0KSB7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRl
dl9lcnIoYWRldi0+ZGV2LCAiRmFpbCBzZXQgbXAxIHN0YXRlIHRvIFVOTE9BRCFcbiIpOw0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KKyAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIH0NCi0NCiAgICAgICAgICAgICAgICByZXR1cm4g
MDsNCiAgICAgICAgZGVmYXVsdDoNCiAgICAgICAgICAgICAgICBicmVhazsNCi0tDQoyLjI1LjEN
Cg==

--_000_DM4PR12MB5165D29462CD6F3006B6B3E38EA69DM4PR12MB5165namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
span.searchhighlight
	{mso-style-name:searchhighlight;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;" a=
lign=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span class=3D"searchhighlight"><span lang=3D"EN-US"=
 style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;co=
lor:#070706;background:#FFEE94">Reviewed-by</span></span><span lang=3D"EN-U=
S" style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;=
color:black">:
 Kenneth Feng &lt;</span><span lang=3D"EN-US" style=3D"color:black"><a href=
=3D"mailto:kenneth.feng@amd.com" title=3D"mailto:kenneth.feng@amd.com"><spa=
n style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;c=
olor:#0078D4">kenneth.feng@amd.com</span></a></span><span lang=3D"EN-US" st=
yle=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;color=
:black">&gt;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best wishes<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kenneth Feng&nbsp;<o:p></o:p></=
span></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> amd-gfx
 &lt;amd-gfx-bounces@lists.freedesktop.org&gt; </span><span style=3D"color:=
black">=B4=FA=B1=ED</span><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black"> Yang Wang &lt;KevinYang.Wang@amd.com&=
gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=CE=E5</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">6</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">10</span><span style=3D"color=
:black">=C8=D5</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;color:black">
 11:52<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
</span><b><span style=3D"color:black">=B3=AD=CB=CD</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;, Wang, =
Yang(Kevin)
 &lt;KevinYang.Wang@amd.com&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> [PATCH] drm/amd/pm: skip to set mp1 unload state
 in special case<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">[CAUTION: External Email]<br>
<br>
set mp1 unload state will cause the SMC FW can't accept any SMU message,<br=
>
skip to set mp1 unload state to avoid following case fail:<br>
- runtime pm case.<br>
- gpu reset case.<br>
<br>
Fixes: 826126d8f805 (&quot;drm/amd/pm: fix driver reload SMC firmware fail =
issue for smu13&quot;)<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 ++++++-----<br>
&nbsp;1 file changed, 6 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 3d269d1c2749..fd79b213fab4 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1415,12 +1415,13 @@ static int smu_disable_dpms(struct smu_context *smu=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1=
_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 7):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Fail set mp1 state to UNLOAD!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(adev-&gt;in_runpm || amdgpu_in_reset(adev))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_=
mp1_state(smu, PP_MP1_STATE_UNLOAD);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Fail set mp1 st=
ate to UNLOAD!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
--<br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5165D29462CD6F3006B6B3E38EA69DM4PR12MB5165namp_--
