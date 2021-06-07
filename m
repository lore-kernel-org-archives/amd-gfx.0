Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E60C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715A16054E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715A16054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250106E4C1;
	Mon,  7 Jun 2021 16:42:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F8D26E4C1
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKx+Gi4mCct0fzNBjUuVr35CMazMvzgdOiSffIzDcFXr+RDdrYhfzwJu+SLg/IIhztzNs1DZmLdgvUxjKBA4gZwO9EDP+XrUeNT4Zr8byNP/LWDGYLcMgxTbE+OuE05YJv6ORE+jwI5W/YrMaRZ+4DkNCffl3N7rhvrH7vAluVsq7AzlM+c17NiO2s0jLTivyXGBUghpJKFDH1aiFcB9EqqtwERF/sdUonrI0mHhV9zapTLdCrm2EtHBYZD/Lev2wxfWbjYnE9csHMnAraJfgaS9e0KidOS4A0Sb5uuvHiO3jxttG9y3rc6NFJD3j4thJzYNgFx0fO945inf+F1hEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DQSt0yQGzPvt3vY4rtfn1lVgN7nFUY1bMaHEWYlFSs=;
 b=Hnqb7eAawXlDC0mfaTe9kyKRJ8vUwL4CsB7WKHtxuzdcskLGI1bMfp5Gz0L7XvWWFV6TRRBKjuQk7+E9mKfglOcSI0BUDPw5ZHS10EGOgZdncB/FErD6vlxGxTkLiSTpc0KemYsIJ7AtRzBxxbdtoS+HXlJKc8Ng26phKINmcL9664OG0J51Y6cixrhp7lOAsKlqZA8MEIJ3TlWB8AbXHvZahVPjWq64V7YrcYxdTOnoxAUETfDlapBpqR41mWd3cXycuwBmpdqz7vOjf4lCkLZ81QwrKAaTpzdn+bDhbpfo+y270NxvsCEPbk5WUrg3f22iwr+UM/5bPLniVqdIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DQSt0yQGzPvt3vY4rtfn1lVgN7nFUY1bMaHEWYlFSs=;
 b=n0soF+HmKXCrvV4u6U1urvdPWBr9jB7OAJLyG1nMiL1CLQCKdZURboZayewxiQalG0AlztgJQGo7E3j6H4lg8R8i4L+GJvtLkSMzXTjrX+gIDf+teNyHV/GUKqjI7sEatuyDRkT900L+P3OuSgV2kLxGJzGdS2u0UfMOQygLeW8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2482.namprd12.prod.outlook.com (2603:10b6:207:4a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:42:34 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 16:42:34 +0000
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Khaire, Rohit" <Rohit.Khaire@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
 <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
 <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <da0025b0-308f-6f2f-e4d8-b5a68117828c@amd.com>
 <BL0PR12MB47552C90D8667E1107279AD487389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <bf87ed0d-d32d-5701-f9bf-c71f6a6b23b6@amd.com>
 <fddc3188-55b9-55e4-485c-4568a621c466@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4d486c0b-8bd1-71aa-fdb4-3413e27beeb0@amd.com>
Date: Mon, 7 Jun 2021 18:42:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <fddc3188-55b9-55e4-485c-4568a621c466@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ce67:4e4d:875d:ffeb]
X-ClientProxiedBy: AM8P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ce67:4e4d:875d:ffeb]
 (2a02:908:1252:fb60:ce67:4e4d:875d:ffeb) by
 AM8P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:42:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b844d7b-52c7-4c4b-a9b3-08d929d3403d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2482ACB75BA71B772CBF320283389@BL0PR12MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfYlWJEBhYIBEyfowHuJJEAddS3eI/p8bqsJhgTQLgnssPNvsrgsilBgPed7ZwT6PjCLAV/zurY9b547ttxEOPUogIEqTfRGIcDXvZU3EZAkiH/YBzner5l1AE5Ou56nSaIscvlmdDurnfSsfuJ7qwDdVoHa5lri3N6B18M7M54jZ4ckq8aEVsytzKG6bNmwovR8IepYgzSyhop4lcvZzZM1aX8dFM724cV2BCzLuouS5QqpVbU+bRNqVsfM9Xzw1yhvqpZ/4A086wKC7ymNjC5qD9E+z2R06oYoo8N+HPLWH6n3OcX9UG0KIGPF4OQMeuVgw2xA+ro05OOM9ewLRP9vAw4Qujz6knstW81w/rep2KccygiAfnqyfAVzI5Yo7fgYsPBFgKdralGT2zUPsaMaumwkPgyJbD405F376Y8xo3jDZoZOkXy141AhBsruwaSAYCTTiBaSln4UCzeNxMMKHAgetAR3o/AOHfGJFOk0ovC6Lzfo7CFHDkKqhB499xSl3VPyXOslwN9oPVIc1v0xlHuOUd2JVlDWJu+WJPTaYl3XOujV4lA4UiWJTJvpBFumy67Em8y1Mwt58TFl7DvduxY4k65xI+Mxy9EKZg0SmOHKP4Mv9GA0sBySArvmFycViVGNnywPk3uTTPkGXgFJxpQ9H2BwKH5jnszC82MKAzvztbSKpvb56Xv2iFxO+6rHuGZvWF5Fy9uvcYJWwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(186003)(16526019)(316002)(4326008)(31686004)(110136005)(6666004)(8936002)(8676002)(66574015)(6486002)(83380400001)(86362001)(36756003)(66476007)(66556008)(66946007)(5660300002)(2906002)(478600001)(921005)(38100700002)(6636002)(31696002)(53546011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RmFPaXB4UGZzdlo3S2VGU1lnTm40ZkhMNmppdk9nYlUxSDBTTkVKNm9hNldw?=
 =?utf-8?B?LzRaM1dZSzBUUitmZllucit0QUZNMlpPMEhvam44VVJicUZkVVRNeXlkdXdO?=
 =?utf-8?B?dk0rOXdkaUpJcG9YUUE5SE1QSXpSSm54Z0d5TzlubTRtSG41UEJRbGhlMXNV?=
 =?utf-8?B?M1gzNUhyUlgwWmpMRUhRMGFJLzdpcGw5eHNoRTNpY2VMTzJSZlZrclN1S2lB?=
 =?utf-8?B?VHlBbi9RRVFkUGl6b0dJb2VzeGppZUw1U0Y1dHloVjRjSS9XYUl1RkIyd0ZV?=
 =?utf-8?B?SjJLYytSUFc5b3JtMUVYc0R0aGdSTlNaMGxXTjh4Z29rK25KTXg0R3c4dXJo?=
 =?utf-8?B?dERPVDMvRXFhTkdFdUJLSVE5ckFETU1JaFg2ZUVpZUdEVXJORCtWL0dheTBo?=
 =?utf-8?B?czM2QlRtM3BxK25MU1dOczNEQzBVRVNQNVlkUEhhRmlLRzA0K3EyVTVWSFdZ?=
 =?utf-8?B?WCtQa0Z5bFFUSTNTcnVMcnhFS2xadjRyMkZpVjl0VGZwR1dEOGk4OFN5bWdI?=
 =?utf-8?B?Z09ya2RuOUVVSjM3M0krZGU0NWlNUFRwWnVkM3FmdzFMQXpBWENPVEt4SnBm?=
 =?utf-8?B?cXF0ZUEvdzROVjNPaTBoS0hpcnozU0R6WTU5b3pVVlRZSGRFOGw0Zyt2V0ta?=
 =?utf-8?B?WE90SnkwQzBQSGRuLytsYUJCWUVBaWhKbGZxSFY4cEdTeVc3d2Z5S1dXT01n?=
 =?utf-8?B?V3Y4Sk8zRjJMdWZ1Y0Jqb0l4em5VVitDQlVDRzVRODZJOXMwaHcvd0FURWlT?=
 =?utf-8?B?d0tmR2xRVGpmOGZMam54TTRXNEs0SnE2elVvb1J5TUh4cmxEZkppVlJwcy9r?=
 =?utf-8?B?UmFiU2xLT1dvSHpqM2hVL2hUZXhwQ1h1Tkh0aHBhSnlGa0dydDZOMm5XTU13?=
 =?utf-8?B?RG1CNW8xeEUwT1VZN2E1amFIMzBLTk1ST2FDeHFvRkVhdWdYZmx3UUFMNUVJ?=
 =?utf-8?B?dnlIaldCdng3L2ZrN2NmU3VOYXkvQnhIUGRDYStPMHNSQXR3TjFoM1YvbXZr?=
 =?utf-8?B?cDM4Zzd2SXZjejJMaW5pVUtVT3ZESVlnM0t1QXlXbVBQcWxpQ1kzY2VRQlg4?=
 =?utf-8?B?eWNOejBqelpYOFo5ZFEyQWN2L2NQcHY3K1dMR1NLNVh3SGppWjgwbWFxazNk?=
 =?utf-8?B?dVdwdjZxRCtKMVNsVmRRa3RmY0Rkb0ZhZys4dFcwZ2pjNHd4dFVua016UW1R?=
 =?utf-8?B?aGZSdXRkRVVGVEZQcGJtMC9pTk1ZWVpUZ0VpenFQd3VXdit0SnBLS0x2ZHBm?=
 =?utf-8?B?clJJZmJCSlBtclg1Y0JCdC9EWmNIRHg1YnRpdlF3THhaOUp4NElmbS8zSGtj?=
 =?utf-8?B?cEhZUllCNmRkQWdUb2t2bEU5b2dMT0tsNEUxWWtRblFyWFozeU5jYUVvU0w5?=
 =?utf-8?B?TGpaS3JOWlUwNE8yUnFXRUVNRy9zeUowVVFaWTIvTFdDNjl5QXcyQ2IxNmov?=
 =?utf-8?B?bmhIdnpOakRyNVErUmNqNDFpRml0V1NLQnN1QWhsRW9TZk5wVU1IQklucGlU?=
 =?utf-8?B?em40dW9SdkdDaFEvNVIwbEhOMXRyZ2NQNEw1ZG5uWWw3dTBSbXBhZTFxckpi?=
 =?utf-8?B?M3AxcmVMTks2T2JHWXVuTU1IKzMvOGlqYkxWTkFITGZZRUhHdzJ2aXhjcHJX?=
 =?utf-8?B?b3MzQkZCajdONVhpOG8xanR4dXdjOGhEUmp0RkVhYUIrTnJRMndYZ3pXRUJC?=
 =?utf-8?B?R0hUTythT1FBS3krUUMzZzF1eGdHYlJKU0Y1RmFqY2F4TmdsdGFKbUhmMlg4?=
 =?utf-8?B?SkdSeVZ4Z2d6RHgwZGxLS05CY1B2QXByZXJDVmh0aHl1NjQ5NFNpUmxpcEFh?=
 =?utf-8?B?TGN1Q2xFbnk5NkJmK1VxZzFNWnNXRld4TjY4VXFEUE1hWTBDdTFRTnFDTWZr?=
 =?utf-8?Q?mp9dS6f5/e/z/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b844d7b-52c7-4c4b-a9b3-08d929d3403d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:42:34.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkTBdgMKytFJcs/8sU2XuBP1uWBsi/fDun9JpOBLx3D9sScfde2isSK1SJrDOjO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2482
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWgsIGdvb2QgcG9pbnQuIEluIHRoaXMgY2FzZSB3ZSBzaG91bGQgcHJvYmFibHkgcmF0aGVyIHNh
dmUgdGhhbiBzb3JyeS4KClRoZW4gSSBzdWdnZXN0IHRvIGNsZWFuIHVwIHRoaXMgcGF0Y2gsIHJl
cGVhdGluZyB0aGUgcHNwX3JlZ19wcm9ncmFtKCkgCmFuZCBlcnJvciBtZXNzYWdlIGlzIHByZXR0
eSBob3JyaWJsZSBjb2Rpbmcgc3R5bGUuCgpDaHJpc3RpYW4uCgpBbSAwNy4wNi4yMSB1bSAxODoz
NiBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IFdpdGggU1JJT1YsIHRoZSBpbnRlcnJ1cHQgcm91
dGluZyBpcyBzZXR1cCBieSB0aGUgaHlwZXJ2aXNvciBkcml2ZXIuIFdlCj4gbmVlZCB0aGUgc2Vj
b25kYXJ5IElIIHJpbmdzIGluIGNhc2UgdGhlIGh5cGVydmlzb3IgZW5hYmxlZCByZXJvdXRpbmcg
b2YKPiBwYWdlIGZhdWx0IGludGVycnVwdHMuIEknbSBub3Qgc3VyZSB3aGF0IHRoZSBoeXBlcnZp
c29yIGRyaXZlciBkb2VzIHRvZGF5Lgo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+Cj4gQW0g
MjAyMS0wNi0wNyB1bSAxMjoyOSBwLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4gVGhh
dCdzIGEgd29ya2Fyb3VuZCBmb3IgYmFyZSBtZXRhbCBhbmQgYXMgZmFyIGFzIEkga25vdyBkb2Vz
bid0IGFwcGx5Cj4+IHRvIFNSSU9WLgo+Pgo+PiBXZSBvbmx5IG5lZWQgdGhlIGFkZGl0aW9uYWwg
SUggcmluZ3MgZm9yIHBhZ2UgZmF1bHQgaGFuZGxpbmcgb3IgbG9nCj4+IGhhbmRsaW5nIGFuZCBh
cyBmYXIgYXMgSSBrbm93IHRoYXQgaXMgaW5jb21wYXRpYmxlIHdpdGggU1JJT1YgZm9yIHRoZQo+
PiBtb21lbnQuIEJ1dCBGZWxpeCBtaWdodCBoYXZlIHNvbWUgbW9yZSB1cGRhdGVzIG9uIHRoaXMu
Cj4+Cj4+IFNvIGFzIGxvbmcgYXMgd2UgZG9uJ3Qgc3VwcG9ydCB0aGF0IHVuZGVyIFNSSU9WIHdl
IGRvbid0IG5lZWQgdGhpcwo+PiBwYXRjaCBlaXRoZXIuCj4+Cj4+IENocmlzdGlhbi4KPj4KPj4g
QW0gMDcuMDYuMjEgdW0gMTc6NTkgc2NocmllYiBLaGFpcmUsIFJvaGl0Ogo+Pj4gW0FNRCBQdWJs
aWMgVXNlXQo+Pj4KPj4+IFRoZSBoYXNoIGlzIDVlYTZmOWMKPj4+Cj4+PiBSb2hpdAo+Pj4KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+Pj4gU2VudDogSnVuZSA3LCAyMDIxIDExOjU4IEFN
Cj4+PiBUbzogS2hhaXJlLCBSb2hpdCA8Um9oaXQuS2hhaXJlQGFtZC5jb20+Owo+Pj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcgo+Pj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PjsKPj4+IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsu
TGl1QGFtZC5jb20+OyBaaG91LAo+Pj4gUGVuZyBKdSA8UGVuZ0p1Llpob3VAYW1kLmNvbT47IENo
ZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT4KPj4+IENjOiBNaW5nLCBEYXZpcyA8RGF2
aXMuTWluZ0BhbWQuY29tPgo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogVXNl
IFBTUCB0byBwcm9ncmFtCj4+PiBJSF9SQl9DTlRMX1JJTkcxLzIgb24gU1JJT1YKPj4+Cj4+PiBE
byB5b3UgaGF2ZSB0aGUgaGFzaCBmb3IgdGhpcyBjb21taXQ/Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4g
Q2hyaXN0aWFuLgo+Pj4KPj4+IEFtIDA3LjA2LjIxIHVtIDE3OjMwIHNjaHJpZWIgS2hhaXJlLCBS
b2hpdDoKPj4+PiBbQU1EIFB1YmxpYyBVc2VdCj4+Pj4KPj4+PiBXZSBkb24ndCBuZWVkIFJJTkcx
IGFuZCBSSU5HMiBmdW5jdGlvbmFsaXR5IGZvciBTUklPViBhZmFpay4KPj4+Pgo+Pj4+IEJ1dCBs
b29raW5nIGF0IHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgb3JpZ2luYWwgY29tbWl0IG1lc3NhZ2Ug
aXQKPj4+PiBhZmZlY3RzIFJJTkcwIHRvbz8KPj4+Pgo+Pj4+ICIgZHJtL2FtZGdwdTogYWRkIHRp
bWVvdXQgZmx1c2ggbWVjaGFuaXNtIHRvIHVwZGF0ZSB3cHRyIGZvciBzZWxmCj4+Pj4gaW50ZXJy
dXB0ICh2MikKPj4+Pgo+Pj4+IG91dHN0YW5kaW5nIGxvZyByZWFjaGVzIHRocmVzaG9sZCB3aWxs
IHRyaWdnZXIgSUggcmluZzEvMidzIHdwdHIKPj4+PiByZXBvcnRlZCwgdGhhdCB3aWxsIGF2b2lk
IGdlbmVyYXRpbmcgaW50ZXJydXB0cyB0byByaW5nMCB0b28gZnJlcXVlbnQuCj4+Pj4gQnV0IGlm
IHJpbmcxLzIncyB3cHRyIGhhc24ndCBiZWVuIGluY3JlYXNlZCBmb3IgYSBsb25nIHRpbWUsIHRo
ZQo+Pj4+IG91dHN0YW5kaW5nIGxvZyBjYW4ndCByZWFjaCB0aHJlc2hvbGQgc28gdGhhdCBkcml2
ZXIgY2FuJ3QgZ2V0IGxhdGVzdAo+Pj4+IHdwdHIgaW5mbyBhbmQgbWlzcyBzb21lIGludGVycnVw
dHMuIgo+Pj4+Cj4+Pj4gUm9oaXQKPj4+Pgo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
Cj4+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4K
Pj4+PiBTZW50OiBKdW5lIDcsIDIwMjEgMTA6MzEgQU0KPj4+PiBUbzogS2hhaXJlLCBSb2hpdCA8
Um9oaXQuS2hhaXJlQGFtZC5jb20+Owo+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBEZXVjaGVyLCBBbGV4YW5kZXIKPj4+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpo
YW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Owo+Pj4+IERlbmcsIEVtaWx5IDxF
bWlseS5EZW5nQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBaaG91LAo+
Pj4+IFBlbmcgSnUgPFBlbmdKdS5aaG91QGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgPEhvcmFjZS5D
aGVuQGFtZC5jb20+Cj4+Pj4gQ2M6IE1pbmcsIERhdmlzIDxEYXZpcy5NaW5nQGFtZC5jb20+Cj4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogVXNlIFBTUCB0byBwcm9ncmFtIElI
X1JCX0NOVExfUklORzEvMgo+Pj4+IG9uIFNSSU9WCj4+Pj4KPj4+PiBXaHkgYXJlIHRoZSByaW5n
IDEmMiBlbmFibGVkIG9uIFNSSU9WIGluIHRoZSBmaXJzdCBwbGFjZT8KPj4+Pgo+Pj4+IENocmlz
dGlhbi4KPj4+Pgo+Pj4+IEFtIDA3LjA2LjIxIHVtIDE2OjIzIHNjaHJpZWIgUm9oaXQgS2hhaXJl
Ogo+Pj4+PiBUaGlzIGlzIHNpbWlsYXIgdG8gSUhfUkJfQ05UTCBwcm9ncmFtbWluZyBpbgo+Pj4+
PiBuYXZpMTBfaWhfdG9nZ2xlX3JpbmdfaW50ZXJydXB0cwo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBSb2hpdCBLaGFpcmUgPHJvaGl0LmtoYWlyZUBhbWQuY29tPgo+Pj4+PiAtLS0KPj4+Pj4g
IMKgwqDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyB8IDIwICsrKysr
KysrKysrKysrKysrKy0tCj4+Pj4+ICDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L25hdmkxMF9paC5jCj4+Pj4+IGluZGV4IGVhYzU2NGU4ZGQ1Mi4uZTQxMTg4YzA0ODQ2
IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWgu
Ywo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwo+Pj4+
PiBAQCAtMTIwLDExICsxMjAsMjcgQEAgZm9yY2VfdXBkYXRlX3dwdHJfZm9yX3NlbGZfaW50KHN0
cnVjdAo+Pj4+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgaWhf
cmJfY250bCA9IFJFR19TRVRfRklFTEQoaWhfcmJfY250bCwgSUhfUkJfQ05UTF9SSU5HMSwKPj4+
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJCX1VTRURf
SU5UX1RIUkVTSE9MRCwgdGhyZXNob2xkKTsKPj4+Pj4gIMKgwqDCoCAtwqDCoMKgIFdSRUczMl9T
T0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMSwgaWhfcmJfY250bCk7Cj4+Pj4+ICvC
oMKgwqAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJgo+Pj4+PiBhbWRncHVfc3Jpb3ZfcmVn
X2luZGlyZWN0X2loKGFkZXYpKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocHNwX3JlZ19w
cm9ncmFtKCZhZGV2LT5wc3AsIFBTUF9SRUdfSUhfUkJfQ05UTF9SSU5HMSwKPj4+Pj4gaWhfcmJf
Y250bCkpIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFJNX0VSUk9SKCJQU1AgcHJv
Z3JhbSBJSF9SQl9DTlRMX1JJTkcxIGZhaWxlZCFcbiIpOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm47Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4+ICvCoMKgwqAgfSBl
bHNlIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhf
UkJfQ05UTF9SSU5HMSwgaWhfcmJfY250bCk7Cj4+Pj4+ICvCoMKgwqAgfQo+Pj4+PiArCj4+Pj4+
ICDCoMKgwqDCoMKgwqDCoCBpaF9yYl9jbnRsID0gUlJFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1J
SF9SQl9DTlRMX1JJTkcyKTsKPj4+Pj4gIMKgwqDCoMKgwqDCoMKgIGloX3JiX2NudGwgPSBSRUdf
U0VUX0ZJRUxEKGloX3JiX2NudGwsIElIX1JCX0NOVExfUklORzIsCj4+Pj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSQl9VU0VEX0lOVF9USFJFU0hPTEQs
IHRocmVzaG9sZCk7Cj4+Pj4+IC3CoMKgwqAgV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9S
Ql9DTlRMX1JJTkcyLCBpaF9yYl9jbnRsKTsKPj4+Pj4gK8KgwqDCoCBpZiAoYW1kZ3B1X3NyaW92
X3ZmKGFkZXYpICYmCj4+Pj4+IGFtZGdwdV9zcmlvdl9yZWdfaW5kaXJlY3RfaWgoYWRldikpIHsK
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChwc3BfcmVnX3Byb2dyYW0oJmFkZXYtPnBzcCwgUFNQ
X1JFR19JSF9SQl9DTlRMX1JJTkcyLAo+Pj4+PiBpaF9yYl9jbnRsKSkgewo+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBEUk1fRVJST1IoIlBTUCBwcm9ncmFtIElIX1JCX0NOVExfUklORzIg
ZmFpbGVkIVxuIik7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0KPj4+Pj4gK8KgwqDCoCB9IGVsc2Ugewo+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyLCBpaF9yYl9j
bnRsKTsKPj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+ICsKPj4+Pj4gIMKgwqDCoMKgwqDCoMKgIFdSRUcz
Ml9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ05UTDIsIGloX2NudGwpOwo+Pj4+PiAgwqDCoMKgIH0K
Pj4+Pj4gICAgICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
