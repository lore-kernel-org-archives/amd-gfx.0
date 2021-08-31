Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A286EC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 05:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6173D60200
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 05:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6173D60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFDC89B05;
	Tue, 31 Aug 2021 05:38:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D483189AFF
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 05:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avGin7mVH5+Jnwx4G2EhS/fN2sOmUj7npgXi8aNLqaru0nO88EADS22t2dLwin0cvJWS4SKptdUgSigdONU9RkmCXzhZzX1CP4hmO4FKdcmnOHwdGnZ9r1kkZl3dE7Sjge0XQ/lxrMY93mQIm7A865kprpwFXimbW/LqIzmCrkFzSmJHXfx36f6SQlZYC1JJuK7auJKSn/isu5N8r06i9+Ns0iqJADJ2bbhlWlk2u7kkKVfuycV+nXMs+gQ/b7Afjpjy9gzlvPfEuN6olS6CB1tTMmJkZYgL/uPD/XpDZ1Z3UuqzOdXKTm8mBdprDIXUrXtsan2wMaEJ8FRc3j3xwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoHTpdEsO0OiC2Iq6KuYIqJvY41efHB0Rf7K2n+jKeI=;
 b=etMadkxDsWC3JBfTucby+qHfiiKgXnBN5qHOTBHpQR9yNiYYgvAr+3BeCZhCqS0RWVCcPwmUHLHlXwqOsFF1qLyovEKMu7/f0zp3Bz9EoRjkWiqetJWsYV+Yb2x5GplUwlNkWf1FfyYcfhinv3ufDa7OT/t7gonraRmk8xrz07S5gsTqsrAoJAXXJZwaKWl2Kx+MYEGAqTtl2RkPAeLFSzaxI8eSfT778wvlFdQpsHCBQxAH4Ef/oSiwoZJ9n9NX253/qQ6vtDxOpoYywjgUTRHd96yZ5G/0BxY7gpXnElTGAokgq4whpQtj7i7lJwyXgxlnqy5Nz51Tm7o6+b9ZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoHTpdEsO0OiC2Iq6KuYIqJvY41efHB0Rf7K2n+jKeI=;
 b=G9Sx2vaxb7XqDxt5JvZ3b9Z8Yd5iTGQobs01jdxfzuv+T7hYeRzS3MS8ipIChsZlzTsFOUY5apwRc+4+BcnOmMr3lhKu4H7e3QTsX2UdxC+yWlZFTuUT6lwi4qkTdIlbU5rEyXFo6wLq4mD02eC+v1JxfKj7DMLdZjX1A5x+aUY=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20; Tue, 31 Aug 2021 05:38:42 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 05:38:42 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails
Thread-Topic: [PATCH] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails
Thread-Index: AQHXnh05XbwK6k67P0+s+nQi5Faq9auNnsiA
Date: Tue, 31 Aug 2021 05:38:42 +0000
Message-ID: <C4E7B450-18FA-4DA3-9AED-FCA03A24B279@amd.com>
References: <DM4PR12MB5165AFECE854E6A4E82A05DF87CC9@DM4PR12MB5165.namprd12.prod.outlook.com>
 <0a52e64c-c5c7-ab65-4370-94374e2d0458@amd.com>
In-Reply-To: <0a52e64c-c5c7-ab65-4370-94374e2d0458@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bee2693d-1cf7-4f8c-9004-08d96c419806
x-ms-traffictypediagnostic: DM4PR12MB5247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB52471AB6946B6B0BC81F46F787CC9@DM4PR12MB5247.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emhHpRikbkuSkg5FmChceijcq/h7fH/W00BfrHpPikilQD5BfJP/nXNmGkBH6+L6gQexuR/PakaS/vAs4EPYLicSXVypSFIb+byYPwYJ/F9ILjuUiqjnA92yWgQBfkCu5LXmMH8ye+6IR14fYjy/ctip1BpTpQPVH8FhGbCERzwsM9ubpKLPjHX+g3zR/JBl8l67QT9lyB8BKI/Q8oV6C7VrzG2Avhwb1DFUvoLaRqtRDv+OZrSHxD2i+9cCDKDgA7BiaZ8Y7SDfXYdb/ajyY9DiXYnLvgCPa8nH0VAoqCK/0TwCjMT9j0XIZc5PI2xiqjS+SlRO4FF2TEb6gY2+OihIDkjDE7pSj0h85uE+DVniA+Le+A1QFi+OJMqxg/MDqII7Zl0FACrfzZ1IecKmExP5ED6gHeOHyRuRGL3tm8L7HR05Sk8jRg7pt1nPf3AkOkUiMQnzIVeM5KwVxxDm/5wKlnYxU+B20vj7+YiSSc94YGOz0xiyecnYY7UPaLkeHnWAOLmhFD8++gZhuwLy/AR7jNk3rAjErMtRKHgjc/Sa7oOwLDfx56PxhvvV9G/Zh5MDQGH/3j1ZSNFH5xOGuBfbPCUSBvlLdGMVdZevd6+A7nvrwz2XgE+yFK34XVyiPTFee9lKIstDiu09l7ErFr2cyJXeIpor2YudexSYxQCTKPFrmsGCrS5oM9/XnLPAr5Xt8xhbVU0O+T4Y7H7pLTvi2ZcWy810sy4+JpankzE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(8936002)(53546011)(316002)(2616005)(6486002)(6512007)(33656002)(5660300002)(86362001)(64756008)(83380400001)(91956017)(71200400001)(8676002)(66476007)(66556008)(66946007)(26005)(6506007)(76116006)(66446008)(4326008)(478600001)(110136005)(38070700005)(36756003)(122000001)(38100700002)(54906003)(2906002)(186003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVJhQlFlcGZJZkVqUWlEcmtwcVVmeVBWaW9YTVRxSEJRZ3VEUFFxKytlOXVO?=
 =?utf-8?B?OEhmandwaEJLWVZUMWUyaGkwM1FmQ0VUWUJmeGlYVlNRNVREei9ES1FGQy9u?=
 =?utf-8?B?SE5yeUZDOWlsZ242dXBSSmZOTmZCNC9jSDlsT1JZTTU5MlNIeCtBZEJ4TFpk?=
 =?utf-8?B?QVV2K1puSTg2TGN1bmRhQmRjaVIvV1AvS1pUaE5jbmN3bW1JaklwZTJFdi95?=
 =?utf-8?B?YjZ0QmdENkNxRElvcDRTSGw5dmYyWDArMU10VHVDeWVLT05weEFNSFVHWG80?=
 =?utf-8?B?ZXBlbFVPbTRsaFRLNVI2Uk1uelEzSWI5c21ZdU56eVpMd2U3WThEVFR2ZUc2?=
 =?utf-8?B?NUQwVjAvc2NOMytwbU5LZ2lGVkVKSXFIckh3ek02VTkzOTR4d3dlVTA1VjM0?=
 =?utf-8?B?aExudGRoZXFyNmwwZVRwaDN5NHZ2OTRxc0JKbjFMdkd6cThuQytpMmdKd003?=
 =?utf-8?B?TS9jWTJOVVFSK2IvcnpFMjd1T1dQWURFMVo3MlFoTEphWnFrQ0xQdDlRdmlt?=
 =?utf-8?B?bGRSaFVoWGsxNUNIUFdTRkZmQ2tHdFFDdHErNzV1WHhGbWQ0WUxXNnFQYXFr?=
 =?utf-8?B?bTRFeTl2UzhXSm81c2R6OGFvM3JhUHFGUmpKSFpsc0lXVjF2eTNNUVhkOHdo?=
 =?utf-8?B?aUwrWFVOTnpNa3FpaFd5SDA3ckhYVkgrTzFGdmpyZXoyY1Voa1hLQkRLLzFj?=
 =?utf-8?B?Q3hXWmUxMWZyYmNYLzJyMFJaYVBsbk9lQ2dneGRZQy9BdDR1eG1oL1pUYmxP?=
 =?utf-8?B?ODdpSHE5OXlmdlU5NVJVT2p4aGpNcDZ5cHluTzY4VjZSU2wzWmE2NE9WemVi?=
 =?utf-8?B?aThwV2NHYmljSHVVZ0FOUE03U05aZysyZTI5ajB0N0JrTmM1bTlCWkQ2ZlJZ?=
 =?utf-8?B?L1ZxSFY1VzE3Z0oySXVORi9VV1Boalp2UjVmaWV3V2drb0FuNGVUR0Y3elBQ?=
 =?utf-8?B?VlBiZTd6c2ZsS0hQVUxFbEJzNHNQOERqZnpaWm9hTDhKaVVDY09WOUFKZGJ1?=
 =?utf-8?B?bDhvaE0rVkVKRjBpQVZUdDFaRk1lSzFBdVBMck9PSjhWYUpnL2VSMGkxdDhn?=
 =?utf-8?B?N3R5Z0Y1TVI1RDlpK1ZjYjlpU0xMbEo0WXI4SWN0TElTb3RmTFdqMms4eWV2?=
 =?utf-8?B?RlRJT0F2RlZ4cDdadGFMU2pIRGdvdWhidGNTeFh6Z25ycktsL0dQWjU0K0w3?=
 =?utf-8?B?YWdMWEtOQVRDa1ZUSXRwWGM3QTQzZkJRNkdGVUp2SExQbFpTdEVTeWJxckdR?=
 =?utf-8?B?N1hQY3pwWjZDZ0NqUTFDL2hZdDNEQkxxVkRJWGdhaGcrSUh2WGZka0oxL05t?=
 =?utf-8?B?TlpDc0xvOWxHc1hWSWhvZFBtNWY1M3MxaFA2MGI2anN3UXh5bXdHUFJOVEdj?=
 =?utf-8?B?Yk5ud25rZnVERytHSjYwNzkrdUc0eFFoMkJURnRMSGRXTmlPVXlnMmd6NlVH?=
 =?utf-8?B?N0JqWGVOcHYyZ3AxZ0V2eUZnTjYvQy90QnQ0ckxtaXAraG5YV2Z0UGZCWUdh?=
 =?utf-8?B?K0V1a3RULzhMdEZ3WGZZekFWMmtweVptK1FjR1FIUjN5UlBlMTJldS9ZcUpY?=
 =?utf-8?B?b3dnbEpYNHhHTHRML05ldUg3TFZJb0VxdDBWU3ZRYWgxSEIvU29ZVWxnak5S?=
 =?utf-8?B?RlcxblIxL2V2SG0ybFNYQWpuYnV4TUJMb0w4WEw0Y2dtMGVWNWdXQXFvKzZl?=
 =?utf-8?B?Wk5Zb3g3VFhLK29scjlNblp6aUZ2cnZVWXIyWTA5WXBjOGVVT3h3bFJwVnBP?=
 =?utf-8?Q?XzSQo4h60mLx2pMy2lXD8n7m75Md1+kQTtVYSzt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <045CE3F739F8AF49A4F8D2712CE13B4A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee2693d-1cf7-4f8c-9004-08d96c419806
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 05:38:42.7871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvCfmdfyzX3KFyZuE7q3q214B8dRQzfIfc/CWzeFlJiI4VpsZstypOlh8CND8Cci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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

DQoNCu+7v+WcqCAyMDIxLzgvMzEgMTI6MDPvvIzigJxHcm9kem92c2t5LCBBbmRyZXnigJ08QW5k
cmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4g5YaZ5YWlOg0KDQogICAgDQogICAgT24gMjAyMS0wOC0z
MCAxMToyNCBwLm0uLCBQYW4sIFhpbmh1aSB3cm90ZToNCiAgICA+IFtBTUQgT2ZmaWNpYWwgVXNl
IE9ubHldDQogICAgPg0KICAgID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCiAgICA+DQogICAg
PiBVbnJlc2VydmUgcm9vdCBCTyBiZWZvcmUgcmV0dXJuIG90aGVyd2lzZSBuZXh0IGFsbG9jYXRp
b24gZ290IGRlYWRsb2NrLg0KICAgID4NCiAgICA+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4g
PHhpbmh1aS5wYW5AYW1kLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCAxMSArKysrKy0tLS0tLQ0KICAgID4gICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KICAgID4NCiAgICA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCiAgICA+IGluZGV4IDg1YjI5MmVk
NWM0My4uYzlkYjdkMmM1ODE2IDEwMDY0NA0KICAgID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQogICAgPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ2VtLmMNCiAgICA+IEBAIC0zNTUsMTkgKzM1NSwxOCBAQCBpbnQgYW1kZ3B1
X2dlbV9jcmVhdGVfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwNCiAg
ICA+ICAgICAgICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUcoIkZhaWxlZCB0byBhbGxvY2F0
ZSBHRU0gb2JqZWN0ICglbGx1LCAlZCwgJWxsdSwgJWQpXG4iLA0KICAgID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzaXplLCBpbml0aWFsX2RvbWFpbiwgYXJncy0+aW4uYWxp
Z25tZW50LCByKTsNCiAgICA+ICAgICAgICAgICAgICAgICAgfQ0KICAgID4gKw0KICAgID4gKyAg
ICAgICAgICAgICAgIGlmIChmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX1ZNX0FMV0FZU19WQUxJ
RCkNCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9ib191bnJlc2VydmUodm0t
PnJvb3QuYm8pOw0KICAgID4gICAgICAgICAgICAgICAgICByZXR1cm4gcjsNCiAgICA+ICAgICAg
ICAgIH0NCiAgICA+DQogICAgPiAgICAgICAgICBpZiAoZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFU
RV9WTV9BTFdBWVNfVkFMSUQpIHsNCiAgICA+IC0gICAgICAgICAgICAgICBpZiAoIXIpIHsNCiAg
ICA+IC0gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfYm8gKmFibyA9IGdlbV90
b19hbWRncHVfYm8oZ29iaik7DQogICAgPiArICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9i
byAqYWJvID0gZ2VtX3RvX2FtZGdwdV9ibyhnb2JqKTsNCiAgICA+DQogICAgPiAtICAgICAgICAg
ICAgICAgICAgICAgICBhYm8tPnBhcmVudCA9IGFtZGdwdV9ib19yZWYodm0tPnJvb3QuYm8pOw0K
ICAgID4gLSAgICAgICAgICAgICAgIH0NCiAgICA+ICsgICAgICAgICAgICAgICBhYm8tPnBhcmVu
dCA9IGFtZGdwdV9ib19yZWYodm0tPnJvb3QuYm8pOw0KICAgID4gICAgICAgICAgICAgICAgICBh
bWRncHVfYm9fdW5yZXNlcnZlKHZtLT5yb290LmJvKTsNCiAgICA+ICAgICAgICAgIH0NCiAgICA+
IC0gICAgICAgaWYgKHIpDQogICAgPiAtICAgICAgICAgICAgICAgcmV0dXJuIHI7DQogICAgDQog
ICAgDQogICAgVGhlIGFib3ZlIGVhcmx5IHJldHVybiBzZWVtcyB0byBiZSBuZWVkZWQgZm9yIC1F
UkVTVEFSVFNZUyBjYXNlLg0KICAgIA0KICAgIEFuZHJleQ0KDQpUaGVyZSBhcmUgdHdvIHJldHVy
bnMuIEVSRVNUQVJUU1lTIGFuZCBvdGhlciBlcnJvciBhZnRlciByZXRyeSBhcmUgYWxyZWFkeSBo
YW5kbGVkIGJ5IHRoZSBmaXJzdCByZXR1cm4gaW4gaWYge30uIFNvIHRoZSBzZWNvbmQgcmV0dXJu
IGlzIG5vdCBuZWVkZWQuDQoNClRoYW5rcw0KeGluaHVpDQogICAgDQogICAgDQogICAgPg0KICAg
ID4gICAgICAgICAgciA9IGRybV9nZW1faGFuZGxlX2NyZWF0ZShmaWxwLCBnb2JqLCAmaGFuZGxl
KTsNCiAgICA+ICAgICAgICAgIC8qIGRyb3AgcmVmZXJlbmNlIGZyb20gYWxsb2NhdGUgLSBoYW5k
bGUgaG9sZHMgaXQgbm93ICovDQogICAgPiAtLQ0KICAgID4gMi4yNS4xDQogICAgDQoNCg==
