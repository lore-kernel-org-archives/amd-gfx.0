Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4403AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 14:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F59210FD15;
	Thu, 16 Dec 2021 14:27:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDFF10FD12
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 14:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnPQEUZ5+OpLIm57MzmAgTr80beOM+DHbW8WuQkQIBNig2zw0MIPNsR0Wtw5iwxFPqxUzUprSVqCMpf22LauzLp2BKzi1r0N08KqD5kN5m6+VpRD3QlmDfq2PIbwyRiMym1nPWHOM8F0EQF9iS2b+8g7SwVxAo2Ru2QNRMI/yvw4j5YmOw91yN76pZlyKOgXoC2BeXxAVZeM06SkE0Ee/ssvHvUCZhKQitaBeeSImKHKsgxZf4CzhuAaXNKvQWI6Zn4BjuUd6F35K1nN3UdUv6qI4N7qo44+4mDTWLwZqdRZogGB2ZszHxnVj5FIxFNbFnxiJAt/bkHz3qwpZGCAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N259ASBgvsczOaY6T1tlJlESSjFkTlh7e5lUJCw08vQ=;
 b=Q1LGvgFchWHNB49JE97fbySxBYV6UvjW+6Swq8tBvT2iECqoNhmcT03L6o8xSeGbydUrpRDkN3v+Z3KU6Eb+zoegK7sONugpExSKeTxiiME9cAhl0f+rPJLnKKRXikGhFheIWPZNAejF7CFd/Te0Gt0CPDoPtaQyPR4N50Jy1Yjl8pjjMxPm0Hswxs2lnge3B9LegbdoqI0OFs65K/c7JJFdlAljYHG/1p8LRevWdUhLpm+CQaJ+nG22AfdW5+O7kqXq/4oI+Eqf22nN7VVxMekoy7YH7TodITJsmAqybxS9/Qj64U5AA3nKQIYXVJwiSr5m088YnvvSIBYPXrKuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N259ASBgvsczOaY6T1tlJlESSjFkTlh7e5lUJCw08vQ=;
 b=0BJ1RkEkQbboE6fxlHaoHZ0SUPff1SdrS3JihuUiOIu0KJh/JalVx6NSvJemt6ejrtHUXF5IsinAuXa/1BkXFoxsEyzzMn6ahmIa0bHJ499EDYPUjhq5a5Mi6TuJHfkEuVR+U340gcfQukxIn7AJ3C4wD98r+Vg6weQNPTQEiGs=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 14:27:33 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::a10e:e3e6:7760:fd5a]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::a10e:e3e6:7760:fd5a%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 14:27:33 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers
Thread-Topic: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function
 pointers
Thread-Index: AQHX8eVYbZ3Q68gxa0q6k5L3Aqw5iaw0FEcAgAAnJBCAAOlUAIAACYPw
Date: Thu, 16 Dec 2021 14:27:33 +0000
Message-ID: <BN9PR12MB53244796AC2C7BEA2199D3C88B779@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-5-victor.skvortsov@amd.com>
 <CADnq5_OP0=TCPcMprrqFo4HxkXWsZamXkLHa25ZWPEMezM1c_Q@mail.gmail.com>
 <BN9PR12MB5324A5B0B87F3E80B2BCA2728B769@BN9PR12MB5324.namprd12.prod.outlook.com>
 <CADnq5_NHvR5p-7X8VRQKqT_fmpUQeEyVEQLw25a39S0k3b1oCw@mail.gmail.com>
In-Reply-To: <CADnq5_NHvR5p-7X8VRQKqT_fmpUQeEyVEQLw25a39S0k3b1oCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T14:27:37Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3e316eca-e019-4379-ae4a-37428c81228c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-16T14:27:37Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7ae1074e-b022-4134-a970-dbde57b86ce2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 777aaedb-7b2b-48c7-8f58-08d9c0a03343
x-ms-traffictypediagnostic: BN9PR12MB5130:EE_
x-microsoft-antispam-prvs: <BN9PR12MB51307C9BD0109776AA9A8B8B8B779@BN9PR12MB5130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWyd8IJ4x0QSwWrd6+yPwPUXMxr4ZsuU/HHhKH94Pf2X2P0NSkH4Lq2vWWp+rgUToME4HqzueBKg19Ol+UwNK1SaimzgbQZp70mvhrcsXzL7IfrU6LEtwwp/IyUWz0iZ9SNPDWvTkCmVk0LLlgWgggP48cWAQWLkVp28IH0DbvzXr48i6ZGGMKG1/86vaYC1zHk/eMFvaOnGx0eMFDAdSOZ9/A6WYIuejilGOuSv4h5h0WiJzTQq0MSzoW+29LdzAWHxDj3YEZwAFauKtkmiURMYqLw/ZyQUgrSGsxpQTTDxykZQu3q5fBOAZhwMlf7SkvmuYmXlNI/W7KsHMVOsXhEnWKzaz+MaGuHmP9eIU9RbhRR1vbz1MuJeiB+NT4bU4b75gCuPL9jcQBDCazvp2V7hUqlI/79dqfIhwW5LxxoAHv7XBqgKu8GMmxgwXDedL/Bw5vKfyM06IJtZluT8T8oahD+WXcU1+svzGBu+W00QycPTfkpSvMigSBu/aa2FeMR0vUbrAcnfrLi3TK9SrzBm/fjdqGfJdJreA6DQ5Esz2fN3vVsQprUvCRmTKoKEhxy84luy7paO554cNuf78ue1eWzLJwlS8XhTI/3yGnPxiaZGfE4Su0iOy/9cbmSv7nQFwBS3G/fJxdkDFXKQZ70/xRIMHVt/RDyz8w5U6jG1OCXKOsolOEW5PktWSM52G3IMSTh+Y7HdESg79xoPAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(66446008)(4326008)(55016003)(8936002)(508600001)(6916009)(2906002)(38100700002)(26005)(38070700005)(66556008)(66476007)(76116006)(64756008)(66946007)(71200400001)(54906003)(9686003)(52536014)(83380400001)(7696005)(53546011)(33656002)(316002)(122000001)(86362001)(8676002)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2gyTFYvOTJaQko5M0F4ZDVaWlpJUy9WNndqV3VGb0tPWUZzcERPTzcvMzBL?=
 =?utf-8?B?R3ZUU1VxQ2ptQURHamtubXkzb25NNGgxbWFvV21USjFid3crMUxoL1JVdlI3?=
 =?utf-8?B?UmV2c3dMTlhicTR1UzFRajZMbUsxSzBiY09UaENlbGdHV0VjU1pkUE1yejV2?=
 =?utf-8?B?T2s1NlpvUkZRWnYxaWd0M0xDckVnYUFtZExKZmVHT3c2UmpVbmhoSGNKWith?=
 =?utf-8?B?akprVXgzdFNlM3JmTkQwcTBlOVFvR1orTHY3RDNZVmE1MDZHQUxOR3prTTVt?=
 =?utf-8?B?QUxXbFNCRW8rdnNqOHpXVE5EamFjd1VHMFcwNTMxalpUN0JoU3hSLzZFb1Jh?=
 =?utf-8?B?eUNFZHVkZ2JKQkh2YTdMc0ZuLy91bGQ1NjZNdXdYakJPVm53bUpsN29yd0h1?=
 =?utf-8?B?cmh3WHlYMU5oYVRncmhDSzFaYkJYYzF5RlRrYVBEeFBKdVJtV1RiUlUzMTU4?=
 =?utf-8?B?eDJTYW5UY1AvZGU0a1B4bUdiMEpONkZDSVlYZ1VwMUdCYzhhT05neU5sWHMw?=
 =?utf-8?B?SzJlKysxdXNnd1NNa1JDZko2WnVNUk1oeVhjWGtpMmszeWU5aFlpTFdib2ti?=
 =?utf-8?B?SmxNZVoxYnJOdytDQ2hDR1ZNUU9YTDBLM1pKSktMUzV5NjlxTWUzaXNnRmNH?=
 =?utf-8?B?UTI4WjFUQjh0dG5vSTVBTGZCeG1IcFRHQjhZM3d0UllpMVZYQmdlbTVkMDN2?=
 =?utf-8?B?TmYwc2ttSVVUd3NxMStCN1NaeXNtYitFQk1FRUFtZzRsUHdodUJPck9rN094?=
 =?utf-8?B?TnhsdXZzaUVOaURrMkFscHd3UGw1L1NVREFxcGRHeHBuTE8zbG51c2lYbEVk?=
 =?utf-8?B?Vi8xOE1XNGMvQW9sZG9ENFNNOHBXUFF2N2xPVEx0RmF4Mi9JZ3ZSc1FKc3kz?=
 =?utf-8?B?b0RvTVpHVFprL2QvaEIraHBENEFDYktEandBbnQwcXlWOEpYeFQ3UjNhTUFW?=
 =?utf-8?B?UXZURzFoRkl3cnc0ZHpZdmdMNERwc1VNZ3hvS0RRYXU3eUZUdSsxRDB2eVlt?=
 =?utf-8?B?NW1wNUZ1MnZtT0ZJS3NQNjE2T0pFWWY0bUZjL28wM2F3SnB6NDZvV0JuVXg2?=
 =?utf-8?B?UWhpWWkxVFpqeW1zOEd4THRIeUprZHFtWjRlTG9Yemdwcm9NR29CQUUzbXk4?=
 =?utf-8?B?bW1sK2lOaE9qd1drSlFKdHVERVNTQzkxR3JiV0hLMHZjMEI2dGFxM0dHQUhD?=
 =?utf-8?B?UjBKQ2hJUTVPV1h1bnFGa09WeTh4ZEtQWUpvK2FnYlgwSzBRa3FVVmJ5SVdU?=
 =?utf-8?B?VWpLRHhJTWMzZ3U2djhzTmFVM2dRajJLWmdDN2x0bENoZHlMSnVCbUJiZUY2?=
 =?utf-8?B?TzY2bTVTZ29kNFRnQjNqTjgrWnNDQ1Z3T1hWY3c1Q25UNE5xbmFoVzEvdlls?=
 =?utf-8?B?eHg5L1JzSnRIbzlVbWpXSjI0V21US25CSDVLK012UHdyKzJjMDFlbG51d2dk?=
 =?utf-8?B?bUhHZ2lGMDNJaUlyTzJHejlrdUpMelJOTHJqaldRSlZtb2VTMGkyMmw0TEJ2?=
 =?utf-8?B?MGdXVUhobzdlc3FGYmtxZlpzVGtkNFBBSys3RHdDczFHak8wcTNDMC83Smli?=
 =?utf-8?B?NFlaazdJNWZvUHZiZUhNZ2lUcS9GSjdGbndmSnhsUEhIM1U2VHdYcUo2Wm1y?=
 =?utf-8?B?cG9yUjkzYzlGT2orZmoyVitDaVd1RFYzSzMvcDFhdjR0Z3lveUJRVjVyWmFX?=
 =?utf-8?B?QUdHd3dhb3hsU2hIMDZHcmVoRnBXaHUwTEZEMzFZSmNaQjlac2dxR2NnOVJW?=
 =?utf-8?B?K3ZzQkRvZWxDSnJYUndmTjVFMytWRE1FdzdjQWE0dDBlRjV4S2ZnSHBubitX?=
 =?utf-8?B?eTNHSE5zdHlmcnAyQkd5M2duZjdjUE5xbXdmUFR2VGxlNld6V3pEeFRIVEtr?=
 =?utf-8?B?VVFUN3RLcE8rSnY5ZndsMGV1SnNPVnkzSjNrMTFSNHVadlg0K0FrYUEvZWFm?=
 =?utf-8?B?cXVqU0cvZHFXUjQ0SjdabWtSdlZaeG5BYUJMbUNNS1QyTkQzQm9hNGN2QVZU?=
 =?utf-8?B?U0dNTENiT0QwWWNvd05WMmlkZGRmcDVnbVp4TDY4NHkxYkNPMUZQSU1KQmxz?=
 =?utf-8?B?REoyNEtHeWlYRHBRVTQ0ZFQ5UlJVWnlEL09naHNBSHpzTUNtOGFRSVlweWVB?=
 =?utf-8?B?S2ZVRGRvcjRha1UxOFVmd2hlM1NMUTlWaURYcStZMGNnQUp5WE5sNkd0S2Z5?=
 =?utf-8?Q?HcfCvgKCv6Or/o4hzI2aiEs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777aaedb-7b2b-48c7-8f58-08d9c0a03343
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 14:27:33.6220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRAUK6WqPsQgdd0LiZNu+lNsoOX5LNpdDp1sCpjwy5cGUTu1VbqKzCmkvL7XL/oA42FfeGeSSNmlPxgVKyFYVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Nieto, David M" <David.Nieto@amd.com>, "Chen, 
 Horace" <Horace.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KR290Y2hhLCBJIHdpbGwgc2tpcCB0aGlzIHBhdGNo
IGZvciBkcm0tbmV4dA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBE
ZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IA0KU2VudDogVGh1cnNkYXksIERlY2VtYmVy
IDE2LCAyMDIxIDg6NTMgQU0NClRvOiBTa3ZvcnRzb3YsIFZpY3RvciA8VmljdG9yLlNrdm9ydHNv
dkBhbWQuY29tPg0KQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc+OyBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxp
dUBhbWQuY29tPjsgTWluZywgRGF2aXMgPERhdmlzLk1pbmdAYW1kLmNvbT47IExpdSwgU2hhb3l1
biA8U2hhb3l1bi5MaXVAYW1kLmNvbT47IFpob3UsIFBlbmcgSnUgPFBlbmdKdS5aaG91QGFtZC5j
b20+OyBDaGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBDaGVuLCBIb3JhY2Ug
PEhvcmFjZS5DaGVuQGFtZC5jb20+OyBOaWV0bywgRGF2aWQgTSA8RGF2aWQuTmlldG9AYW1kLmNv
bT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81XSBkcm0vYW1kZ3B1OiBJbml0aWFsaXplIEFsZGVi
YXJhbiBSTEMgZnVuY3Rpb24gcG9pbnRlcnMNCg0KW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0K
DQpPbiBXZWQsIERlYyAxNSwgMjAyMSBhdCA2OjU4IFBNIFNrdm9ydHNvdiwgVmljdG9yIDxWaWN0
b3IuU2t2b3J0c292QGFtZC5jb20+IHdyb3RlOg0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5
XQ0KPg0KPiBIZXkgQWxleCwNCj4NCj4gVGhpcyBjaGFuZ2Ugd2FzIGJhc2VkIG9uIHRoZSBmYWN0
IHRoYXQgYW1kLW1haW5saW5lLWRrbXMtNS4xMyBjYWxscyBnZXRfeGdtaV9pbmZvKCkgaW4gZ21j
X3Y5XzBfZWFybHlfaW5pdCgpLiBCdXQgSSBjYW4gc2VlIHRoYXQgZHJtLW5leHQgaXQncyBpbnN0
ZWFkIGNhbGxlZCBpbiBnbWNfdjlfMF9zd19pbml0KCkuIFNvLCBJJ20gbm90IHN1cmUgd2hhdHMg
dGhlIGNvcnJlY3QgYmVoYXZpb3IuIEJ1dCBJIGRvIGFncmVlIHRoYXQgdGhlIGNoYW5nZSBpcyBr
aW5kIG9mIHVnbHkuIEkgZG9uJ3Qga25vdyB3aGVyZSBlbHNlIHRvIHB1dCBpdCBpZiB3ZSBkbyBu
ZWVkIHRvIGNhbGwgZ2V0X3hnbWlfaW5mbygpIGluIGVhcmx5X2luaXQuDQo+DQoNCldlIGNvdWxk
IHNraXAgdGhpcyBwYXRjaCBmb3IgZHJtLW5leHQgYW5kIGp1c3QgYXBwbHkgaXQgdG8gdGhlIGRr
bXMgYnJhbmNoLiAgVGhlcmUncyBhbHJlYWR5IGEgbG90IG9mIHVnbHkgc3R1ZmYgaW4gdGhlcmUg
dG8gZGVhbCB3aXRoIG11bHRpcGxlIGtlcm5lbCB2ZXJzaW9ucy4NCg0KQWxleA0KDQoNCj4gVGhh
bmtzLA0KPiBWaWN0b3INCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
QWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
RGVjZW1iZXIgMTUsIDIwMjEgNDozOCBQTQ0KPiBUbzogU2t2b3J0c292LCBWaWN0b3IgPFZpY3Rv
ci5Ta3ZvcnRzb3ZAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc+OyBEZW5nLCBFbWlseSANCj4gPEVtaWx5LkRlbmdAYW1kLmNvbT47IExp
dSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IE1pbmcsIERhdmlzIA0KPiA8RGF2aXMuTWluZ0Bh
bWQuY29tPjsgTGl1LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPjsgWmhvdSwgUGVuZyAN
Cj4gSnUgPFBlbmdKdS5aaG91QGFtZC5jb20+OyBDaGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4y
QGFtZC5jb20+OyBDaGVuLCANCj4gSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPjsgTmlldG8s
IERhdmlkIE0gPERhdmlkLk5pZXRvQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81
XSBkcm0vYW1kZ3B1OiBJbml0aWFsaXplIEFsZGViYXJhbiBSTEMgZnVuY3Rpb24gDQo+IHBvaW50
ZXJzDQo+DQo+IFtDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCj4NCj4gT24gV2VkLCBEZWMgMTUs
IDIwMjEgYXQgMTo1NiBQTSBWaWN0b3IgU2t2b3J0c292IDx2aWN0b3Iuc2t2b3J0c292QGFtZC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gSW4gU1JJT1YsIFJMQyBmdW5jdGlvbiBwb2ludGVycyBtdXN0
IGJlIGluaXRpYWxpemVkIGVhcmx5IGFzIHdlIHJlbHkgDQo+ID4gb24gdGhlIFJMQ0cgaW50ZXJm
YWNlIGZvciBhbGwgR0MgcmVnaXN0ZXIgYWNjZXNzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
VmljdG9yIFNrdm9ydHNvdiA8dmljdG9yLnNrdm9ydHNvdkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgfCAyICsrDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICAgICAgICB8IDMgKy0t
DQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmggICAgICAgICB8IDIg
KysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rpc2NvdmVyeS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlz
Y292ZXJ5LmMNCj4gPiBpbmRleCA2NWUxZjZjYzU5ZGQuLjFiYzkyYTM4ZDEyNCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4g
PiBAQCAtODQ0LDYgKzg0NCw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9zZXRfZ2Nf
aXBfYmxvY2tzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICAgICAgY2FzZSBJ
UF9WRVJTSU9OKDksIDQsIDEpOg0KPiA+ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDksIDQsIDIp
Og0KPiA+ICAgICAgICAgICAgICAgICBhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAN
Cj4gPiAmZ2Z4X3Y5XzBfaXBfYmxvY2spOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoYW1kZ3B1
X3NyaW92X3ZmKGFkZXYpICYmIGFkZXYtPmlwX3ZlcnNpb25zW0dDX0hXSVBdWzBdID09IElQX1ZF
UlNJT04oOSwgNCwgMikpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ2Z4X3Y5XzBfc2V0
X3JsY19mdW5jcyhhZGV2KTsNCj4NCj4gYW1kZ3B1X2Rpc2NvdmVyeS5jIGlzIElQIGluZGVwZW5k
ZW50LiAgSSdkIHJhdGhlciBub3QgYWRkIHJhbmRvbSBJUCBzcGVjaWZpYyBmdW5jdGlvbiBjYWxs
cy4gIGdmeF92OV8wX3NldF9ybGNfZnVuY3MoKSBhbHJlYWR5IGdldHMgY2FsbGVkIGluIGdmeF92
OV8wX2Vhcmx5X2luaXQoKS4gIElzIHRoYXQgbm90IGVhcmx5IGVub3VnaD8gIEluIGdlbmVyYWwg
d2Ugc2hvdWxkbid0IGJlIHRvdWNoaW5nIHRoZSBoYXJkd2FyZSBtdWNoIGlmIGF0IGFsbCBpbiBl
YXJseV9pbml0Lg0KPg0KPiBBbGV4DQo+DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+
ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDEwLCAxLCAxMCk6DQo+ID4gICAgICAgICBjYXNlIElQ
X1ZFUlNJT04oMTAsIDEsIDIpOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jDQo+ID4gaW5kZXggZWRiM2UzYjA4ZWVkLi5kMjUyYjA2ZWZhNDMgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gPiBAQCAtODE2LDcgKzgxNiw2
IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX3NyaW92X3dyZWcoc3RydWN0IA0KPiA+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHUzMiBvZmZzZXQsICBzdGF0aWMgdm9pZCANCj4gPiBnZnhfdjlfMF9zZXRf
cmluZ19mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7ICBzdGF0aWMgdm9pZCANCj4g
PiBnZnhfdjlfMF9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsgIHN0
YXRpYyB2b2lkIA0KPiA+IGdmeF92OV8wX3NldF9nZHNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldik7IC1zdGF0aWMgdm9pZCANCj4gPiBnZnhfdjlfMF9zZXRfcmxjX2Z1bmNzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsgIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfZ2V0X2N1X2luZm8o
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2N1X2luZm8gKmN1X2luZm8pOyANCj4gPiBzdGF0aWMgdWlu
dDY0X3QgZ2Z4X3Y5XzBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVfZGV2aWNl
IA0KPiA+ICphZGV2KTsgQEAgLTcwNjYsNyArNzA2NSw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8w
X3NldF9pcnFfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAgICAgICBh
ZGV2LT5nZnguY3BfZWNjX2Vycm9yX2lycS5mdW5jcyA9IA0KPiA+ICZnZnhfdjlfMF9jcF9lY2Nf
ZXJyb3JfaXJxX2Z1bmNzOyAgfQ0KPiA+DQo+ID4gLXN0YXRpYyB2b2lkIGdmeF92OV8wX3NldF9y
bGNfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gK3ZvaWQgZ2Z4X3Y5XzBf
c2V0X3JsY19mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgew0KPiA+ICAg
ICAgICAgc3dpdGNoIChhZGV2LT5pcF92ZXJzaW9uc1tHQ19IV0lQXVswXSkgew0KPiA+ICAgICAg
ICAgY2FzZSBJUF9WRVJTSU9OKDksIDAsIDEpOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5oDQo+ID4gaW5kZXggZGZlOGQ0ODQxZjU4Li4xODE3ZTI1MjM1NGYgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuaA0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmgNCj4gPiBAQCAtMjks
NCArMjksNiBAQCBleHRlcm4gY29uc3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIA0K
PiA+IGdmeF92OV8wX2lwX2Jsb2NrOyAgdm9pZCBnZnhfdjlfMF9zZWxlY3Rfc2Vfc2goc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiBzZV9udW0sIHUzMiBzaF9udW0sDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdTMyIGluc3RhbmNlKTsNCj4gPg0KPiA+ICt2b2lkIGdmeF92
OV8wX3NldF9ybGNfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiA+ICsNCj4g
PiAgI2VuZGlmDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
