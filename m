Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67AAC636D7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Feb 2023 07:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D41110E49B;
	Thu, 23 Feb 2023 07:16:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5DD10E49B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Feb 2023 07:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THkPvMVp7lfCoYcP4O8K6Y9E6/5uxdD+WIqgsSQ4xVRb3p8NWBueFRl/l0AMLYvFSBbG0zybU8VBQhbxrWTOJ/OaOIR+IPW77xJWY1IGvwxOFejMcErG8eP3gI5C950uEcEjFm8i8Cmj0VPm1YWDhOC9fKons1aJ++wbz6xmwLPjo67OvoEGvAvcg9R0SY3DuZhW8/5p/OuHkuT4miP++4nZyjIU2PQ1fDEMplOoEFg9f9ElQLU5eCEr/jibJ3CUZ9HfimISQKiyeflDfnwe/n2F8vSyz5NgKdK3oLW+UO6ow63A93zUHjqIJfxPb2hG7QJ0opWWJjX32XaE96bwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMcNpmU0GoraX+3x8V4gHqx+IPc9oEVrqZmeg2WTNww=;
 b=gx+dwRvbeTDgjHvf58XiTAWn4zC2f41Sxmg8hki787gmI5JGTnqG3WCZwLug/LU4OuQ6Y9943+ygtscJ6m2TjVTLNCr9HR7Zlw29sWpfWk4TAMrOSbncRR6HvmDoXUncMC14RtdXf+aHvZI8AAAohjuIY1SujCJtcMVBxxE99ougRE+oGusTPbt7EovWGfALbZrbRiZz+bN3XfJ/0VQ2DiCXASqwKzcoQY7vBmifw+ZT09/p301pBwGiTm9qbmYgAVOzAysaftORc8txIRC2RKPlSHZ2bb4b8pSMuJA2st5nUEgUvMSsupEoXNljiJHR0NjBBIzQoNZUYBdPraiFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMcNpmU0GoraX+3x8V4gHqx+IPc9oEVrqZmeg2WTNww=;
 b=MyPyScyJRJIeS4BqmURvwKYJo6DBcXFL20t9PqGnDoRa1Wa1IYBDgsV71SZhEc979Fg7u3ejG4Eer0eGvq3DGN1qZmxJm8/Tk5l9wwnO/kjR4/FViGc75kXysfFFU5ChhjOqboMrnFUXTOzO74KNa3COZHHqdRW9eO4IBYendA8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Thu, 23 Feb 2023 07:15:57 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6111.019; Thu, 23 Feb 2023
 07:15:57 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Cui, Flora" <Flora.Cui@amd.com>, "Shi,
 Leslie" <Yuliang.Shi@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix compilation issue with legacy gcc
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix compilation issue with legacy gcc
Thread-Index: AQHZR1Y94zDrzFAIh0q26zAzzaEv3q7cHokg
Date: Thu, 23 Feb 2023 07:15:56 +0000
Message-ID: <DM5PR12MB2469638D66B420C520890CE9F1AB9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230223071244.5025-1-bob.zhou@amd.com>
In-Reply-To: <20230223071244.5025-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CY8PR12MB7586:EE_
x-ms-office365-filtering-correlation-id: 438b25ac-ce1d-4cf8-221d-08db156dceb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohHjNitotSo6I8i5LIAvoZTPb0pxTKeMTBTEigDE4Rtkw6B/1V5a8nUTCMJOS5ykoFXg4XHRG2/XSY+cbqxWJKBlq+IfSL5nkoaSmY9sYzM1+eQfq/FBMLK0laWJXjwba4mXLsx0lZs+znBnxz2gHqQyjRDx0WfD5Zf0ve9jZZJ5mkFrq+Vg8PdQ5n3uca+AXyliv29yXCraid2+9UW41EkR67IDlVGddRHPgRpO8ibKXBCjOrqIQaS/V2md5Ec7NZsjCDZdX3MAmQjE6Q0COjkTlwBAzvPcceO5MUTt8E7/ib1hz1t//AkMbEEWwcIwxAYeUCItS03MeJvHf2R4FQyWvIEzVcbaDzJ/UAvmlEKRjUuenxdxvsI2HLHt2t5Pxr37+Mk0csuqVlFabQ/UJ/7s2hLO6Vyd4I3fl/riB33oyK/peHfuoosOKWcFcz3TPOAAvJ1YHXuEvEOmLSo5c2e9oUI+kGNbpypzNC7iH9DdJQa0+X8gHrXMMh1zSl7HtPwL6CbtW7Lut1VJglQdXNV+8PUBNUGcemAO7HGrvkxRAZTYTe/T8aQZSM4m9cBMvuQdG+s9zufHX6Cso+AI6p/5RfMUlcazH3RRQtfy3u9RWZvIDzLFr+3ZXkR/jzCHUuGBuiXLwkq+diHV5Lnon2W6gQFaNJqoES2K0gNlX5jKvt47BXjeyQcC9Zi0mU0D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(33656002)(122000001)(86362001)(71200400001)(110136005)(6636002)(478600001)(2906002)(83380400001)(66446008)(64756008)(5660300002)(38100700002)(4326008)(66476007)(76116006)(41300700001)(8676002)(66946007)(66556008)(8936002)(52536014)(38070700005)(26005)(53546011)(55016003)(186003)(9686003)(6506007)(7696005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFAwaEYrZERTeERORjNKKzI1aFB3TEMzREFnVGpFMFRkeFZKSlRFYUlaOE94?=
 =?utf-8?B?RGN0djBrYlVlWEtkMDJDcWJjaFZGbnVrcE4vNDZ4eHNoV01oeEs0WVNnNG5K?=
 =?utf-8?B?UDlDSXh3Uyt5aFY5bHJoaU1NaWNpLzV6bmJ3eWYzTzJkZFRQR3hqTGcvelJa?=
 =?utf-8?B?NkloU01GSWxWSTRlaXlKVFZnZWoxREQ5R1RLL0ROM0xGd3VhRmg5Mktwdk1J?=
 =?utf-8?B?NnFOajJBbENOUVp0b2hXa1RCODFBNUMzc0M2Q284TjFvK1ZEWnJDWWdBVXJx?=
 =?utf-8?B?ekQ5dkNIRVg5Q3FRQnc0cHo1UVNnVmJmZlF5RytCYmFWWGxTNFN3ZE12RnJ6?=
 =?utf-8?B?cTdLK2tTeDRQTnhnbmZLZno0ekU1YlM4Y09JNUJJQ1RWaGtDWlhxVjVUOGNI?=
 =?utf-8?B?RmhWQUtKRXI0dm5ERXFXUlR1ZllYM1BNZHQzdHB0MnRnT3gwb1hDK1BvNTZM?=
 =?utf-8?B?Y0NxT20wODFKeHlDaHBSNGdiQmE4UEdGbE1ZWlltNE1OVytub0NxNXZhbDdo?=
 =?utf-8?B?My9ZYm5XNVc3Q0tvV1J6NU95WXdDU010VEptZ0xRTzUwazNxWCtERjVTNjZo?=
 =?utf-8?B?bXNLaDRzU0p4SzR3ZW1pNmJTamdsVzlxYnA5NmV3eGRqU2E4TFhMb3BSRW91?=
 =?utf-8?B?RXUvOVRDeTZ0Z2o1U2xzNWUwdGR0WEI3OHVydi9HNXljMU41enZCbXM2QlZx?=
 =?utf-8?B?NXZtV2tPaWdtbVh2VmQ4Q0hZbzZObFAxR2dQRDYrajY2R1B6Z1Y3dDIzdHFo?=
 =?utf-8?B?VVdIbWMwS1U2WXRnMDMva3VOY1NMa2dncEZwalYrdWRYc1AwM2ErTVZNdkF5?=
 =?utf-8?B?MGo2WmE4eHo3ZmxaK2MrZ0lNQ2hENFM3MjlSaXkrUThkU251UWFqUnE0S1FR?=
 =?utf-8?B?UHBGelZMR29JZWx2cjl6YjJtUWxCR3ZTODltZ1N3Tm1INkRLNFhKaVdmcXFR?=
 =?utf-8?B?ZjR1UHk4TTBmRTBZZ09BRXVpLysrZlRPQ2U2Y3pCVjlvOUhwMEJxdkh4WE5Z?=
 =?utf-8?B?RDFJakFQV1RCOEl5b0JVM0Q4OEJQaFJINXNXdy9mN2g5OXlkU2NkY3dYVWhN?=
 =?utf-8?B?VGVqT29DamRURWR6ZDg0MXdJSTFQU2lNYThGSnc5RFZZZWZxMEYxdkJvVU9E?=
 =?utf-8?B?dUNlZ0h3L3Q4ellCRHZma1NLWDREOUdYem9meGlhSHBYaXpabUtVNzRXZGtP?=
 =?utf-8?B?ZHJNMnpvTkFLMnZhMVhXNVhHditYbmIvWktRcDFaNGVQdFYyd2dhQ2pibzNE?=
 =?utf-8?B?TDVBeTljSGxKR2JOZXV1VWZTZ1ZrbXovWlB0cDFPSkVZelBxZlVIV0JxWUZ1?=
 =?utf-8?B?bHNrYmNCQzhreWlHVWxHcCtyYkV6Z3NURjRaVWNHZFRNSWY2bmQyR0FBcUhT?=
 =?utf-8?B?TVkvemhaOG1VWFpTVUFITkhBeDhMVnhsVUt6bWNzSXkrNnJ0V3RJMDZxMnlm?=
 =?utf-8?B?VVM5MGhKa0w5Q0dsclNsSVNNSHVjZWZ5MUZDcFB0WS9DM2JTOEhXdEFVNThh?=
 =?utf-8?B?U2o5TklpOEttdXpzYzdLZFhBRC9JRGcwM0cweWV0cEc2MWdGZkdpZWhjbExy?=
 =?utf-8?B?aGUxK3JVaFlIeFV3NCs1cTg3VktOUUcvUnNSbE5kb1lTb1E3Rmg5OXNEVnBu?=
 =?utf-8?B?ajc5Y1ovZjJLd0NndmJFdEJIRHNrQlk1MUxJUjE1NmVBNVpDVmx5Q3hhZUZ5?=
 =?utf-8?B?VXRtQ3JXUGRBVzZUSHdsMDErc3NNTmNDM1VoS3hNeGRpNzlweWZoVjhpMERY?=
 =?utf-8?B?aFg3SVk2cWUvaHIycGlYaHdCU2k1OWhqSGpCeFZjSm1UdmU2ckZtZ3I2YTRo?=
 =?utf-8?B?ZGt5RS9aRnJoYVJmZXZpbzJvMW50VjhEbmorWTVjaWlmMk9rNld0SnZ5YVE4?=
 =?utf-8?B?RUhsMktGaW9nY0sxeGs1RnJXSkFIU1c5alRVOFBqRGRXQXRIOUNCN0wrL2cz?=
 =?utf-8?B?bWt2NUU2TWZFa3pqbGNYZTNmK29YamRoMlBNbXVyejVmU3JRVFdEL3U2OXdC?=
 =?utf-8?B?eURpd0JtaVFaTTVVMkswOFBjSmcxbXNPNnE3YXdxbWZLOS9NcndsNlQzbldv?=
 =?utf-8?B?SUR3Y0JsQnVtRVo0V1diUnVrMkRUdkVMREExT0szRldQVGJ3OUdaWHZuRE56?=
 =?utf-8?Q?Zo18rEPwRXI6gXtJZxvFUxrX1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438b25ac-ce1d-4cf8-221d-08db156dceb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 07:15:56.6290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilm52NnsZdLlFtW/6akzVh7dNxILj5xWoUnP1jvTiBHfZh7R8mQEUbB7+vctwNgmv0UecxyepmuPH+5yX5vO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBib2J6aG91IDxi
b2IuemhvdUBhbWQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMywgMjAyMyAzOjEz
IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IENoZW4sIEd1Y2h1biA8R3Vj
aHVuLkNoZW5AYW1kLmNvbT47IEN1aSwgRmxvcmEgPEZsb3JhLkN1aUBhbWQuY29tPjsgU2hpLCBM
ZXNsaWUgPFl1bGlhbmcuU2hpQGFtZC5jb20+OyBNYSwgSnVuIDxKdW4uTWEyQGFtZC5jb20+DQpD
YzogWmhvdSwgQm9iIDxCb2IuWmhvdUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1k
Z3B1L3ZjbjogZml4IGNvbXBpbGF0aW9uIGlzc3VlIHdpdGggbGVnYWN5IGdjYw0KDQpUaGlzIHBh
dGNoIGlzIHVzZWQgdG8gZml4IGZvbGxvd2luZyBjb21waWxhdGlvbiBpc3N1ZSB3aXRoIGxlZ2Fj
eSBnY2MNCmVycm9yOiDigJhmb3LigJkgbG9vcCBpbml0aWFsIGRlY2xhcmF0aW9ucyBhcmUgb25s
eSBhbGxvd2VkIGluIEM5OSBtb2RlDQoJZm9yIChpbnQgaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVt
X3Zjbl9pbnN0OyArK2kpIHsNCg0KU2lnbmVkLW9mZi1ieTogYm9iemhvdSA8Ym9iLnpob3VAYW1k
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMgfCAzICsr
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMC5jDQppbmRleCAyMTNiNDM2NzBmMjMuLjIzMzEz
ODM0OTBmZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8w
LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMNCkBAIC03OSwx
MCArNzksMTEgQEAgc3RhdGljIGludCB2Y25fdjRfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkg
IHsNCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KiloYW5kbGU7DQogCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZzsNCisJaW50IGk7DQogDQogCWlm
IChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCiAJCWFkZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyA9
IFZDTl9IQVJWRVNUX01NU0NIOw0KLQkJZm9yIChpbnQgaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVt
X3Zjbl9pbnN0OyArK2kpIHsNCisJCWZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9p
bnN0OyArK2kpIHsNCiAJCQlyaW5nID0gJmFkZXYtPnZjbi5pbnN0W2ldLnJpbmdfZW5jWzBdOw0K
IAkJCWlmIChhbWRncHVfdmNuX2lzX2Rpc2FibGVkX3ZjbihhZGV2LCBWQ05fRU5DT0RFX1JJTkcs
IGkpKSB7DQogCQkJCWFkZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyB8PSAxIDw8IGk7DQotLQ0KMi4z
NC4xDQoNCg==
