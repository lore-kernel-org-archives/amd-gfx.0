Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544EAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 01:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA43510E05A;
	Thu,  2 Nov 2023 01:03:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC1F10E05A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 01:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1owdf1O7A+SE5Cei2RVfOoUEsB6LeQODRqZ8M0TmrxTgTtC96hOH0iQhznXUvMSPHtJaTJ5I/gh6UzMXCd2a7lfQyM3krmUrTQI8VptSLVbrYNBq8xovmi7aZQUW0zjRv05CvNOdhhTcsezxp/19TgPen79EqCfMH851vVFNbQ47uTrMLuMWl58kPtcpUfvMCxWNokuUosKKFrEO7bmF5eOfTjZWGxAzEAQn++wP8+G6Nc4Dhwrb7u+fx4wdpdHkDrMvTqMHc/IEZEgEt96CFqjxr5ZRUN4KRdMncKsOK63w9c8+l4Pt0zp1ylJyHGJRHu94RHfrzIavpVzrKMIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R9FHQj+1fuWPjJ4Wovt5uB3C0xHudJD0i+eujJUgVQ=;
 b=XJ2mgRnaWoU1IerCoBwlXzE4Ugpz3HvL26Yv3KIf1D/YYWOQMZvNd8s+bWobcHFuaUrYOjhm8cjeTH8ycED44qT2pcxzn1h0DoG4J5aVAajEwbEQh3MXwmxrSmjqS2AKXvlglE3hgl0IARkxe3WTwsEU7VCxb27yfDKPBnbw+YhAMt5rtPPtp3Kctmz511qbIZGLG+y4n5xERna49uC+ylp6gQXYcW6iIHfyxrwVbhp0j2Y3DMvaGlTuxXWNZqvWD/USU0MhpdM8Hov7OsFfOQ9fGXGilwoAY4b4fylxEinQnD4p9OUDIv8LSVwhBJ8+bHdNBeB5lXuBsmUkgDCzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R9FHQj+1fuWPjJ4Wovt5uB3C0xHudJD0i+eujJUgVQ=;
 b=LziBUW26u2ADAEQXAguVFzQLi/MtOa+9bBd7xkTy5PQCLwOTntkMn2TN18u3yi+p+KnAJEXbrlHAQwP4gOX1GI9FiaGebPC23MW9nAIh9s1oF+n30fIGrjI3lBLyV2k4WYlnYlcUtNojUxIA625Wccasqw2hiC/6Wl9lupakhRY=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Thu, 2 Nov 2023 01:03:53 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b%7]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 01:03:53 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdgpu: Optimize the asic type fix code
Thread-Topic: [PATCH v2 1/2] drm/amdgpu: Optimize the asic type fix code
Thread-Index: AQHaDHAzAOkgp4UmEk+F6RI9PYe+KLBmNnwAgAAA4DA=
Date: Thu, 2 Nov 2023 01:03:52 +0000
Message-ID: <DM4PR12MB51651B8CB9DCB495035602838EA6A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231101030442.1988771-1-Jun.Ma2@amd.com>
 <b499c258-9b13-4612-810c-979ee847059e@amd.com>
In-Reply-To: <b499c258-9b13-4612-810c-979ee847059e@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=84213b71-bd6d-440d-b2be-9ba189d31967;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-02T01:01:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CH0PR12MB8531:EE_
x-ms-office365-filtering-correlation-id: 76c3f3a9-0838-4dfb-079f-08dbdb3f94e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gbdv31OAugqmYeKKuxM6S73rymznEuEh3GBDeiS35ANMTyIPENwQS1XHLgrzYlVTWX46lxKSxgY0u5eNcjZYKJif3YpH7lQs/AEBfFI/sLcvDjS+0R3VUtFmOHhTf7fsTh7zXf5F1tC8lQtd81bjHQLik7Hrl7s5V87E7mspEpNQW8XodxT35W8WBSwzd+3JeQNmMVu+fYndQNlYzhHDBu6ffu3gztZ60oYvWnxuv99Cy0DfjNOhQSkCMARqCfVlJVKLnUX/JlV90yCIH+WYd7VrfxoDXDs/ev3ccY4W+DcHWWhTdWkjyRv5INwCRCUoWJ2OZoIqTHk8uEtxRhJ8sVy50WIrscjrJvxSHxB4mE6Y2lQPgWAUmcJozNZfqi+2V0DhzYY45DJf1ktGQa6XManaRpSXzwqlcA/mv0HJVBHtoMDy3N1/gnSUR0C19OyNUuzmvmMEXI2SbV9z/Xx5+ZQWoymrF34WXeU3mKv5bB2gFDPOvnDTmiCk0mWnwI+xOij6PWrWpnqR5VvlSADahOADzGd/a749ux5i3MaNbp5AFMzn31PGw3VMrywBpSfPYNZDVPZS5cF20Eb4izOFLGbNfjaFFkfwkgtMwpKaHU16hR2KC3PMkG7MpNogohDw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(33656002)(122000001)(86362001)(38070700009)(71200400001)(5660300002)(478600001)(26005)(6506007)(41300700001)(2906002)(83380400001)(8936002)(8676002)(38100700002)(52536014)(66446008)(6636002)(110136005)(316002)(64756008)(66476007)(66946007)(9686003)(53546011)(7696005)(66556008)(55016003)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUthWVd0cU9WelZ6eHNGRVQwbWhSL2tZMWRMZlRMVzFLTkVKVlhhWU9lTkJO?=
 =?utf-8?B?OVJiZTBnMll0WStZMHZ1am04MlV4alUwZkNqNWc4MXN1bnpvMnZzSEFENng0?=
 =?utf-8?B?TTdoOHUwWVowVldNbWtMMkdJM1gwczdsKzRvQlVRMDY0ZFg3WThRcUdoWnUx?=
 =?utf-8?B?QU9FNTlRV2dlTmZCZU4raHdoY2R0RDhtNWJlZWc5MVdzN1pLV0xRaGpEWC9C?=
 =?utf-8?B?alRmWm5HeFl0QklxYlJCVDlSUG0xUnpaVDlYL0JXTkxhcnJRL1NjdFpubjR1?=
 =?utf-8?B?dFZabjVMRkJvN1hoemRldFNjdEh6d2cyaTBoZjJPVldKTXNkd2xrUk1aRWRj?=
 =?utf-8?B?N3BCZ21lc0kwMitKVG55VkQxa2t0ZDVzcVpyMWFZbDZDSGUyUzVEQlJmRTNl?=
 =?utf-8?B?QW0zREppOXFDT2xSTzQzWVMrdXdzVi9QUy9STTZsTWdOcFljVUZZclMwWU81?=
 =?utf-8?B?Q1UrUmFwRWpsMldHa0p0cDlGM1YvYzNyZDBkaWNCQ0w0U3g5bU5kV2NQeHVo?=
 =?utf-8?B?SzhqdzVJNVdoNU9FMmN5MFZob1loRnpRT2ZsRXRFRksvMmxpWXh0VTJaT2Jo?=
 =?utf-8?B?K1dLK2lDYkMwcEJZL1Vod1VwQ0FsMVl1MlEwRldXZHVsdFdtOXBMYy91VENq?=
 =?utf-8?B?SjRZYXVOcUtZZzR5R1loTVdQMlZ4dGcraFhVYUVSQVNMOURQNmhhNlI0a0hm?=
 =?utf-8?B?bnRUTFNDL1pnMnF2MXl0NU1wSzVSU1lmUGNPOFpGOXl1aVE3WHZieEpVQ0w5?=
 =?utf-8?B?SFZVcGMzUGJEc1F3Sm5ENm5sZWE3WHAxMGZYYjNqcTBvaFdDaHFTQ1pMSFIv?=
 =?utf-8?B?c3QxNlBTeE11cVF1M09vU1V6YzAzNW9XaTBOZkR5ZWZKbnhTSVpiRy9SYUZ3?=
 =?utf-8?B?elVFZGZER0VrVm1yS1VRVVV0MmwwM2YrNzhCZjgyc0lUZHFQWS84SEFaSlJG?=
 =?utf-8?B?cFFtb3lBbXZSa0ZOSTVZYzVPL2UrQmpaNlBSY090anl4OHdXZ3E2MFV2MmV0?=
 =?utf-8?B?RkRCa3NCNzVoWEQ4V2k3dHNhaGxVa1pFZkVlT0liWFJZV2Y3dFlPN0Z5K2dG?=
 =?utf-8?B?aktlTDJvM3A3RDZXdkhnKzluZzZ5b2lIVkxKVlVuZUF0QksrQUxOK2xpZXFI?=
 =?utf-8?B?ZzVCKy96ZG84OFc1TXZaRGtSa3VwbThaT3A2aGFZRlQwNmZzalUydXljbGFN?=
 =?utf-8?B?RWFoWnRrS2VTK2dXbjVmQSs5UUtBODllK3o3RHRtbjJEWnBHYmhSMG1MODR5?=
 =?utf-8?B?OWd5dDVwdmJpN1VWZjE0dmUwNStjczZDTUlRb2FWZ3ZqeG9lK0ZSOG92VVds?=
 =?utf-8?B?bWFvYmt5SXhUVFI5S2dPalpGWStzL0VTZW5kbTVWT1ppNHNmUkxKQVFMMWRh?=
 =?utf-8?B?Q0ZSUDV2THAzZXY3N3YyTmU3UFpGdVFCSm9IK3FRYm11dVhZem5SK2tkSkE3?=
 =?utf-8?B?SVhCcE1VQ3ZuRDFtbW4rdVFEQ3lEMzZDb09HY1hVQXRjRHdxSGFFSzI3NFg5?=
 =?utf-8?B?YmU0bnlMTEx2WDI5QnpZZXo2ZTlSYmg0N3JxQ2RQV3hpWnJiVis4c0ZmaXpM?=
 =?utf-8?B?MXRObUtGNGxTZmdXRXBPeG52QUxmMnFWWEJCbDN6WTk3WlRZRStIS0RHVXBW?=
 =?utf-8?B?eG9EZ01jWGxsNVVCSUQ4MXJ2WEpSQ3RhNjF1eWJROVlsMzFHdS9nVHBIeENX?=
 =?utf-8?B?V0JQT0lhalZaT3IxOHJsaVQvUEZ6SzMvVVpmRXhueUpOV2NwdGdxaEd1ZWlG?=
 =?utf-8?B?Zm0rbnY1d01IdXdNMnhkVmFWYlA4Wk1zNWhSeDBTZklpemFFcDNJV0REdHFU?=
 =?utf-8?B?amV6T2JaZi9sUDdMV0EwbE9aRlFPR3JITmlYRnJmRm1henRKVWZGTU9zRTBi?=
 =?utf-8?B?SUptczJIeFVnU2JqY21weUw2MkVBUkEwb2NUcEYybXBIc3ZzWUlVNGlJRUo5?=
 =?utf-8?B?eTlDQWxSTCszeUdRRy9lRTJGR01HaTU1Ti9heFRyQUZuSU5xWU5GZDFyMWVC?=
 =?utf-8?B?VWx0WG1DYzk5MXRoandFWUw2M1pCemhNVWpuM0xFbDhabmt2QVhZaDZOTlhu?=
 =?utf-8?B?bHErb2RYQlc4RSsrb3JrTURaZmxLaHBJMkdQY1J3N1dHQnpIYjNMS2llR0I3?=
 =?utf-8?Q?EIfA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c3f3a9-0838-4dfb-079f-08dbdb3f94e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 01:03:52.9644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFDgH2GQSK/xXH2R8ft5QMly6HtjdT2AydovBAivcDYxQ/QT+HVUis7LLpPua2e8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBLZW5uZXRo
IEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBNYSwgSnVuIDxKdW4uTWEyQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgTm92
ZW1iZXIgMiwgMjAyMyA4OjU4IEFNDQpUbzogTWEsIEp1biA8SnVuLk1hMkBhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0Bh
bWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0K
Q2M6IE1hLCBKdW4gPEp1bi5NYTJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8y
XSBkcm0vYW1kZ3B1OiBPcHRpbWl6ZSB0aGUgYXNpYyB0eXBlIGZpeCBjb2RlDQoNCnBpbmcuLi4N
Cg0KUmVnYXJkcywNCk1hIEp1bg0KDQpPbiAxMS8xLzIwMjMgMTE6MDQgQU0sIE1hIEp1biB3cm90
ZToNCj4gVXNlIGEgbmV3IHN0cnVjdCBhcnJheSB0byBkZWZpbmUgdGhlIGFzaWMgaW5mb3JtYXRp
b24gd2hpY2ggYXNpYyB0eXBlDQo+IG5lZWRzIHRvIGJlIGZpeGVkLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBNYSBKdW4gPEp1bi5NYTJAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAzNSArKysrKysrKysrKysrKysrKystLS0tLS0tDQo+
ICBpbmNsdWRlL2RybS9hbWRfYXNpY190eXBlLmggICAgICAgICAgICAgfCAgNSArKysrDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gaW5kZXggODQ3MDNlMGE3
M2JkLi43NTZjZjQ5NTU3YTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMNCj4gQEAgLTIwNjcsNiArMjA2NywxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBj
aV9kZXZpY2VfaWQgcGNpaWRsaXN0W10gPQ0KPiB7DQo+DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxF
KHBjaSwgcGNpaWRsaXN0KTsNCj4NCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2FzaWNf
dHlwZV9xdWlyayBhc2ljX3R5cGVfcXVpcmtzW10gPSB7DQo+ICsgICAgIC8qIGRpZmZlcmVudGlh
dGUgYmV0d2VlbiBQMTAgYW5kIFAxMSBhc2ljcyB3aXRoIHRoZSBzYW1lIERJRCAqLw0KPiArICAg
ICB7MHg2N0ZGLCAweEUzLCBDSElQX1BPTEFSSVMxMH0sDQo+ICsgICAgIHsweDY3RkYsIDB4RTcs
IENISVBfUE9MQVJJUzEwfSwNCj4gKyAgICAgezB4NjdGRiwgMHhGMywgQ0hJUF9QT0xBUklTMTB9
LA0KPiArICAgICB7MHg2N0ZGLCAweEY3LCBDSElQX1BPTEFSSVMxMH0sDQo+ICt9Ow0KPiArDQo+
ICBzdGF0aWMgc3RydWN0IGRybV9kcml2ZXIgYW1kZ3B1X2ttc19kcml2ZXI7DQo+DQo+ICBzdGF0
aWMgdm9pZCBhbWRncHVfZ2V0X3NlY29uZGFyeV9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikgQEANCj4gLTIxMDksNiArMjExNywyMiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfaW5pdF9k
ZWJ1Z19vcHRpb25zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICB9DQo+ICB9
DQo+DQo+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBhbWRncHVfZml4X2FzaWNfdHlwZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwNCj4gK3Vuc2lnbmVkIGxvbmcgZmxhZ3MpIHsNCj4gKyAgICAgaW50IGk7
DQo+ICsNCj4gKyAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoYXNpY190eXBlX3F1aXJr
cyk7IGkrKykgew0KPiArICAgICAgICAgICAgIGlmIChwZGV2LT5kZXZpY2UgPT0gYXNpY190eXBl
X3F1aXJrc1tpXS5kZXZpY2UgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAgIHBkZXYtPnJldmlz
aW9uID09IGFzaWNfdHlwZV9xdWlya3NbaV0ucmV2aXNpb24pIHsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZmxhZ3MgJj0gfkFNRF9BU0lDX01BU0s7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGZsYWdzIHw9IGFzaWNfdHlwZV9xdWlya3NbaV0udHlwZTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICB9DQo+ICsgICAgIH0NCj4gKw0KPiArICAgICByZXR1cm4gZmxhZ3M7DQo+ICt9DQo+ICsNCj4g
IHN0YXRpYyBpbnQgYW1kZ3B1X3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KSAg
eyBAQCAtMjEzOCwxNSArMjE2Miw4IEBADQo+IHN0YXRpYyBpbnQgYW1kZ3B1X3BjaV9wcm9iZShz
dHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAiU2VlIG1vZHBh
cmFtIGV4cF9od19zdXBwb3J0XG4iKTsNCj4gICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsN
Cj4gICAgICAgfQ0KPiAtICAgICAvKiBkaWZmZXJlbnRpYXRlIGJldHdlZW4gUDEwIGFuZCBQMTEg
YXNpY3Mgd2l0aCB0aGUgc2FtZSBESUQgKi8NCj4gLSAgICAgaWYgKHBkZXYtPmRldmljZSA9PSAw
eDY3RkYgJiYNCj4gLSAgICAgICAgIChwZGV2LT5yZXZpc2lvbiA9PSAweEUzIHx8DQo+IC0gICAg
ICAgICAgcGRldi0+cmV2aXNpb24gPT0gMHhFNyB8fA0KPiAtICAgICAgICAgIHBkZXYtPnJldmlz
aW9uID09IDB4RjMgfHwNCj4gLSAgICAgICAgICBwZGV2LT5yZXZpc2lvbiA9PSAweEY3KSkgew0K
PiAtICAgICAgICAgICAgIGZsYWdzICY9IH5BTURfQVNJQ19NQVNLOw0KPiAtICAgICAgICAgICAg
IGZsYWdzIHw9IENISVBfUE9MQVJJUzEwOw0KPiAtICAgICB9DQo+ICsNCj4gKyAgICAgZmxhZ3Mg
PSBhbWRncHVfZml4X2FzaWNfdHlwZShwZGV2LCBmbGFncyk7DQo+DQo+ICAgICAgIC8qIER1ZSB0
byBoYXJkd2FyZSBidWdzLCBTL0cgRGlzcGxheSBvbiByYXZlbiByZXF1aXJlcyBhIDE6MSBJT01N
VSBtYXBwaW5nLA0KPiAgICAgICAgKiBob3dldmVyLCBTTUUgcmVxdWlyZXMgYW4gaW5kaXJlY3Qg
SU9NTVUgbWFwcGluZyBiZWNhdXNlIHRoZQ0KPiBlbmNyeXB0aW9uIGRpZmYgLS1naXQgYS9pbmNs
dWRlL2RybS9hbWRfYXNpY190eXBlLmgNCj4gYi9pbmNsdWRlL2RybS9hbWRfYXNpY190eXBlLmgg
aW5kZXggOTBiNjkyNzBmMmZhLi43MjRjNDVlM2U5YTcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
ZHJtL2FtZF9hc2ljX3R5cGUuaA0KPiArKysgYi9pbmNsdWRlL2RybS9hbWRfYXNpY190eXBlLmgN
Cj4gQEAgLTY4LDQgKzY4LDkgQEAgZW51bSBhbWRfYXNpY190eXBlIHsNCj4NCj4gIGV4dGVybiBj
b25zdCBjaGFyICphbWRncHVfYXNpY19uYW1lW107DQo+DQo+ICtzdHJ1Y3QgYW1kZ3B1X2FzaWNf
dHlwZV9xdWlyayB7DQo+ICsgICAgIHVuc2lnbmVkIHNob3J0IGRldmljZTsgIC8qIFBDSSBkZXZp
Y2UgSUQgKi8NCj4gKyAgICAgdTggcmV2aXNpb247ICAgIC8qIHJldmlzaW9uIElEICovDQo+ICsg
ICAgIHVuc2lnbmVkIHNob3J0IHR5cGU7ICAgIC8qIHJlYWwgQVNJQyB0eXBlICovDQo+ICt9Ow0K
PiAgI2VuZGlmIC8qX19BTURfQVNJQ19UWVBFX0hfXyAqLw0K
