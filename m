Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC4C12002
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 09:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C816108B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 09:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C816108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D916E0D1;
	Mon, 19 Jul 2021 09:40:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D106E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 09:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TocYrw+G49KdVJ872GvkDbuJfTDZs5bod1IXZGtYILCsgLyAnI4peyHoa/ssn53CUFDuMXwWKVgzZltv9F0wGeQUDgKIAqbQDjPRQcxIX8u0vqRdefMEOcOBMPlTbpNPbolKjYSZkFO7+Wz+Fw8tlmK268WM0+EpqkVAi9BJMaVCR5bt0jfQFqIt8qw09pH3ckUG27Qzedh7FqWoEOMVVslDrEPNYJl0RYKNQpS9Wn9iojDDHfqs76TakCoDm+G506hpmbouUPffmfafnf59q+A7QMgoxjJ/I76oS0+5ApCqk+NNx6/VD9JOzxPN3oLa4/3f+vewfj69S23ZRmPT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI3ckeqP/9lAcU0lIPKf8ixhfRBsUOXrTMpM65tUXWo=;
 b=LyXStwyA90CUQCcv8IQja/AxqCGfO6/Rwv+YkfH4lL6OqJhe0pgP8OMHRQQX62K1NTSaqDB8+f5IahVVQ3zxkGq1/sm7Ua5O4vlYhi/5L+8EkUpoUwj0hj71PdacIrBULjV1QaH8QuG1Bl5oMj77CJqjCoOQip+J0DN9hYUO5aluqgrxbin+h+UFw06J2Lii5TnYH1gAd2cV54mTVUE0lKkzdBzKTsRgheLDe0YFqGcqVF5G+lWyjvQz3o693mOq6+S/R9F/6FUT2+MKlO/O4DR8DTSv/ikWH1DQmUjZs9dQjyWQv4QmTaUEc+CKb5aHHiqNeoRMfRKaJyNeRZqd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI3ckeqP/9lAcU0lIPKf8ixhfRBsUOXrTMpM65tUXWo=;
 b=FsNHzZ9VzJ392UDVLeXy/jH5pb236YEoLOedormTck5MJr1SL8cVUOAOuQIssQ/4blJf4vWQOfldJ9PVPmF40wpMklerUmUPM0FYBcp50kFXnVVAZCn0/lbKWF+Nz4J5leyVFGov9AqNYk3gT9GLMmWRwYG7dxSziYQMnGIPiVM=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Mon, 19 Jul
 2021 09:40:02 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 09:40:02 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Thread-Topic: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Thread-Index: AQHXfGMXqyKk82oQU0e799K+59gf9KtJ9lKAgAASVkA=
Date: Mon, 19 Jul 2021 09:40:02 +0000
Message-ID: <BL1PR12MB5269EC6B2D9822EAAC4A292A84E19@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210719055754.244832-1-Jingwen.Chen2@amd.com>
 <a56009a5-4793-7301-2a80-b4b051db6c0c@gmail.com>
In-Reply-To: <a56009a5-4793-7301-2a80-b4b051db6c0c@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-19T09:40:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=876cadf2-8664-4bc0-baa6-2bd453e1fa6b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c777dad-3d57-44c4-10c0-08d94a992ecc
x-ms-traffictypediagnostic: BL1PR12MB5078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB50785B5A8249C2157930332E84E19@BL1PR12MB5078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XBNp2aIOIC4cKGNhzLDV98/SS1VvneeBWLTjb+Y9WLBAwYUTrCzQIJXrBXZSwVFP00vEvTWpSrsBYBcKfTWUKxrBea8fL5Lv8OfSybYQPIRTa1/4LeBKQhgOXpHhPIo6LRlAYc09CEomIdhyPpuDR5yuoUWopFNfdL9UzChpPzT+jF8IPteeXXv6vOY32hT03w6+NrvGyB7uvAcSkPjQsh8X9upImhLsOdLYRWwrGBuEjl5aONVFnC9J9RlgUtoHkDdtc7n/LR9iWVVgpC/tjgfj+s13t4cy3RMKhamRrlEUytDdkxNnW+rBJLbfKG0h7IlEHF0kNCFGPX9MSAlkzWRC9twOlF+fq3MiRVw40DUDPrSgMYXNj0GLImKordJmvlcDIPn0J6GQCaXsE411sOVv42cwp7HHSlfKT6noLJv/Zu+Cqz8FpzCJaHRCjG4krw2TvVsyoll0K4DrFwpPS5ZMJ55yAK1IuRn6VUyXxFDJKwG2SSd0CRtx2jv3V/0ZiKAOa00Ao//GrsdrZo2VMI54HcyjTuKuWxl0rNQ7Tv3VYg3hN6ZFFSoHZGlsVhy/PAo6H3j2Iuht05+k1SPiHUFQa/5JDP/rti5uyvohoN+10jpuJQ0dD+e+cwbCfHrHUyw4P8+MidyH9HKTbJTmILaIiwu28pfVAie1ZjNNCggFJu5+fxtmVkhEi8qLzHIesjslztZwHS0VHCjmE9JyvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(64756008)(2906002)(66446008)(52536014)(5660300002)(110136005)(33656002)(316002)(9686003)(186003)(55016002)(26005)(66476007)(66556008)(38100700002)(6506007)(53546011)(7696005)(71200400001)(8936002)(76116006)(86362001)(8676002)(83380400001)(66946007)(478600001)(4326008)(122000001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckxTbzI3Z0JlbDVMTHUzSXJRSzRWUllHNGhrRDM5QUMycExxNCsvR2FNcTZq?=
 =?utf-8?B?R3NBZjJHclgzZ29KYXlDVWdUaU5iWVorODZTNGlrbkwvUElZUVhtUDQzU21U?=
 =?utf-8?B?ZThhd2VnNzhMRlVGdExvb3QrUE9MRkk5VUpGbC9IR2w3aVdsQXpWRE1hUnRL?=
 =?utf-8?B?K3dhVkdKWU10Zno0MVRweWM3UkxoalcvdFczQVQxNktHRUdvVHVETk84ckNB?=
 =?utf-8?B?S0g5SlZVSFA2N0JoYzZ3RURrMnR2bDBRUWFjMWpDRmY0QTFFRlBmZXUra0Nq?=
 =?utf-8?B?UVNOSDNrY3RwcDNyTTVPemZvS2s4VWxYWUlPS1FoTThSSnBhWHFQOVp4NDdM?=
 =?utf-8?B?V3FhOFo0VkZuYUNjU0JlVUxPRVlpTVJicGgrWmdVNWFqbVE4cVF2Si93NVM4?=
 =?utf-8?B?T3RPTXdHN0t0OEs5b1BwSzQ4RXMvaEdrZzI3U3FDV3BGS3dVTDZJT0Z5UzF3?=
 =?utf-8?B?dkdwa205dGxacXRMUjhJa2M2VThxZW1HSnZzUUcyam55VDM0R0E1RDg0Nmwz?=
 =?utf-8?B?NENMVXFPdWdiQjl5Mnk2OWFnSUg4OTkzRmRSenhid0tueDVjNC9xeTZmMXM5?=
 =?utf-8?B?bHM5VjlmNzZwZ3paT1JSb253UjUzVmxzcVZsY3d3NXFBVC9TZ21WdWcrcHhT?=
 =?utf-8?B?Y3U4OXc4QXpkYVVwVmtxU2YyRUVxbnBNYUVVTnRWaGZLc1VkVCtMc0FiYWpX?=
 =?utf-8?B?QzczUks3eEo2NnBDenN6aHlEMXBDY1Z2RWt2VTRRTTFzYkpHSmp4SVVkeVNZ?=
 =?utf-8?B?ak5vVFV2OVlRL2hTRFNFQ1pWamlhNnhBT1I2WnhRODZocVAwaC9CNUJvVmNk?=
 =?utf-8?B?YXNrZW81NUxFWkZTNXlJQm5EUndqUDZBb2ZXc3pobGpoSzdTTmw0VnJ2bXhM?=
 =?utf-8?B?Q0wzRjV0MVdSeWtFWkNQRDJ5ZHBRVVc2aGtORWNWWFNLWm9pNWx2REZzRndo?=
 =?utf-8?B?VnpvMVdmUDFCaWw4alpUVVZUY3JuK2cvWnU4RjJuODJTcmpoMlRUZXFvTTNk?=
 =?utf-8?B?NHZneUdsSnkvRnh4NWJzVzEzMi9sMFo1bG1wNDQ0QUxMSzF6b2Rxd0xCaWUx?=
 =?utf-8?B?d0F0UjMybThvNlFLS2IzbHZQbmprNWQrYVdvenRUWmJiNUs5UmdtK2wvMzlz?=
 =?utf-8?B?V052OHZKMVNkVnpabktIY1RoV05neGhNWWxDVTZTeGlDRDBuSklLUGFrZ2Q5?=
 =?utf-8?B?ajVHRHVZTVZXcGM3UEtrVWhETWl6WmlDYytxT0JpR1BpNUNFMUUxRkR2bVB1?=
 =?utf-8?B?NHJHZTZYL0xLWDdaVzlIbXJCOUJJR0ZjKy9GOWFNNlIwblZ2OE40SkczZm1O?=
 =?utf-8?B?cXZkV0pnMktwUStTRm4zOG5reGUzZytOMWlLQndob09YUFBUeDFmeXRYZG95?=
 =?utf-8?B?L1Q3Q09abC90dG5CQnRNTkFzQkhTRmZyREN6U0FiWCt0K0lBMmxMUnNvNnFR?=
 =?utf-8?B?a1BQb1ZvVXJKT3ZFdU81QUI4TTFoK0RSSmgxZWxtZ0VzNUJkVWh6NTlCNjZC?=
 =?utf-8?B?dFEyU1dIcWtqWjM3T2dhT0w0d2dIUWkyM0gxbnZ4THdBQXhqSXBtWHN3Vzcw?=
 =?utf-8?B?WWJCVkxrU3ZyNS9ONzJHWG80cTNDeUxGTHBpNlovalloQ1Z4dVY1TDRkR2Jj?=
 =?utf-8?B?ZENGOFhjamJhVGtOQUF1N0lWdHNaTVM4RUdDSXYzbDd1a2J3QVZSTGwyUW5z?=
 =?utf-8?B?TDltYWFRYW9SYmc5cm13UU1qaVh0VElrRzluaU84TlVuTGZlQm9OTFdLeVFt?=
 =?utf-8?Q?bkceRfFJf0l5nrhSKyCnpMnCm8lUl4iOoL+S/+P?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c777dad-3d57-44c4-10c0-08d94a992ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 09:40:02.3371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YfG609zkSD07nYfM+pcNAUqNLVKo2oA1OAV0fC7STmJbsMPirOfJy6O0fuDdyHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSWYgdGhlcmUgaXMgbW92ZSBqb2JzIGNsYXNoaW5n
IHRoZXJlIHdlIHByb2JhYmx5IG5lZWQgdG8gZml4IHRoZSBidWdzIG9mIHRob3NlIG1vdmUgam9i
cw0KDQpQcmV2aW91c2x5IEkgYmVsaWV2ZSB5b3UgYWxzbyByZW1lbWJlciB0aGF0IHdlIGFncmVl
ZCB0byBhbHdheXMgdHJ1c3Qga2VybmVsIGpvYnMgZXNwZWNpYWxseSBwYWdpbmcgam9icywNCg0K
V2l0aG91dCBzZXQgcGFnaW5nIGpvYnMnIHByaW9yaXR5IHRvIEtFUk5FTCBsZXZlbCBob3cgY2Fu
IHdlIGtlZXAgdGhhdCBwcm90b2NvbCA/IGRvIHlvdSBoYXZlIGEgYmV0dGVyIGlkZWE/DQoNClRo
YW5rcyANCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpNb25r
IExpdSB8IENsb3VkLUdQVSBDb3JlIHRlYW0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IA0KU2VudDogTW9u
ZGF5LCBKdWx5IDE5LCAyMDIxIDQ6MjUgUE0NClRvOiBDaGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNo
ZW4yQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IENoZW4sIEhv
cmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiB2bSBlbnRpdGllcyBzaG91bGQg
aGF2ZSBrZXJuZWwgcHJpb3JpdHkNCg0KQW0gMTkuMDcuMjEgdW0gMDc6NTcgc2NocmllYiBKaW5n
d2VuIENoZW46DQo+IFtXaHldDQo+IEN1cnJlbnQgdm1fcHRlIGVudGl0aWVzIGhhdmUgTk9STUFM
IHByaW9yaXR5LCBpbiBTUklPViBtdWx0aS12ZiB1c2UgDQo+IGNhc2UsIHRoZSB2ZiBmbHIgaGFw
cGVucyBmaXJzdCBhbmQgdGhlbiBqb2IgdGltZSBvdXQgaXMgZm91bmQuDQo+IFRoZXJlIGNhbiBi
ZSBzZXZlcmFsIGpvYnMgdGltZW91dCBkdXJpbmcgYSB2ZXJ5IHNtYWxsIHRpbWUgc2xpY2UuDQo+
IEFuZCBpZiB0aGUgaW5ub2NlbnQgc2RtYSBqb2IgdGltZSBvdXQgaXMgZm91bmQgYmVmb3JlIHRo
ZSByZWFsIGJhZCANCj4gam9iLCB0aGVuIHRoZSBpbm5vY2VudCBzZG1hIGpvYiB3aWxsIGJlIHNl
dCB0byBndWlsdHkgYXMgaXQgb25seSBoYXMgDQo+IE5PUk1BTCBwcmlvcml0eS4gVGhpcyB3aWxs
IGxlYWQgdG8gYSBwYWdlIGZhdWx0IGFmdGVyIHJlc3VibWl0dGluZyANCj4gam9iLg0KPg0KPiBb
SG93XQ0KPiBzZG1hIHNob3VsZCBhbHdheXMgaGF2ZSBLRVJORUwgcHJpb3JpdHkuIFRoZSBrZXJu
ZWwgam9iIHdpbGwgYWx3YXlzIGJlIA0KPiByZXN1Ym1pdHRlZC4NCg0KSSdtIG5vdCBzdXJlIGlm
IHRoYXQgaXMgYSBnb29kIGlkZWEuIFdlIGludGVudGlvbmFsbHkgZGlkbid0IGdhdmUgdGhlIHBh
Z2UgdGFibGUgdXBkYXRlcyBrZXJuZWwgcHJpb3JpdHkgdG8gYXZvaWQgY2xhc2hpbmcgd2l0aCB0
aGUgbW92ZSBqb2JzLg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogSmluZ3dl
biBDaGVuIDxKaW5nd2VuLkNoZW4yQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jDQo+IGluZGV4IDM1ODMxNmQ2YTM4Yy4uZjc1MjZiNjdjYzVkIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBAQCAtMjkyMywx
MyArMjkyMywxMyBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQ0KPiAgIAlJTklUX0xJU1RfSEVBRCgmdm0tPmRvbmUp
Ow0KPiAgIA0KPiAgIAkvKiBjcmVhdGUgc2NoZWR1bGVyIGVudGl0aWVzIGZvciBwYWdlIHRhYmxl
IHVwZGF0ZXMgKi8NCj4gLQlyID0gZHJtX3NjaGVkX2VudGl0eV9pbml0KCZ2bS0+aW1tZWRpYXRl
LCBEUk1fU0NIRURfUFJJT1JJVFlfTk9STUFMLA0KPiArCXIgPSBkcm1fc2NoZWRfZW50aXR5X2lu
aXQoJnZtLT5pbW1lZGlhdGUsIERSTV9TQ0hFRF9QUklPUklUWV9LRVJORUwsDQo+ICAgCQkJCSAg
YWRldi0+dm1fbWFuYWdlci52bV9wdGVfc2NoZWRzLA0KPiAgIAkJCQkgIGFkZXYtPnZtX21hbmFn
ZXIudm1fcHRlX251bV9zY2hlZHMsIE5VTEwpOw0KPiAgIAlpZiAocikNCj4gICAJCXJldHVybiBy
Ow0KPiAgIA0KPiAtCXIgPSBkcm1fc2NoZWRfZW50aXR5X2luaXQoJnZtLT5kZWxheWVkLCBEUk1f
U0NIRURfUFJJT1JJVFlfTk9STUFMLA0KPiArCXIgPSBkcm1fc2NoZWRfZW50aXR5X2luaXQoJnZt
LT5kZWxheWVkLCBEUk1fU0NIRURfUFJJT1JJVFlfS0VSTkVMLA0KPiAgIAkJCQkgIGFkZXYtPnZt
X21hbmFnZXIudm1fcHRlX3NjaGVkcywNCj4gICAJCQkJICBhZGV2LT52bV9tYW5hZ2VyLnZtX3B0
ZV9udW1fc2NoZWRzLCBOVUxMKTsNCj4gICAJaWYgKHIpDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
