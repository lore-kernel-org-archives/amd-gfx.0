Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5A3C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD058619C8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD058619C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51ED26E910;
	Tue, 30 Mar 2021 15:04:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360CC6E910
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 15:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoTvHnnPVWT2lPrQB/lEBxEIi4UY/D08TY20IbcwFUcqGlFDk/59/zOijR9XXCmzG6w7qGN1aQY+n0Sbdnzrgqzr2x/ffXoY+/wk2Wf+c6sB1BlThA5+3vyPfckmXsGlugChoa3zxDEozU9G0KLPdLIOng1hZUE5CxkuBAAYn9n1VnhH/VlcZXBpZRtqaa+qd53YvGY/tVi1fd8feJ2eep3cWs1jUDFDEGRZ2CrzSKmxfPITmSB2OnmkKfHw2RWqL4X9FcXyOM3hKUz1m0NB3bYJM03TwbdCWatT82w/voGgafHg0CzvNd3JYFzqh8kyNyn7hRG2xbsONO30NWIINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCiE1nB1tTtN4DGI97oBVE/f6QyYOVhiq4BuDAeUXR4=;
 b=A8cY06WnIvdEbQ4j+BZNscFnjscs+fswL8f++CCPeIKOsbdoortB1+1/Z2YCJNSQVBulIlMUH2Q7xV9luMPQ8ViMgAOJ0J618froVd15C6uaZ16EdXpaTozBNkEJjr5UPgVf5rimPtjmobZSPA3ezGKuI+UiJw2B4rgsO3WZIQcpTC/mfTa9l7IGDDV4N+w1cOEwmKxhhRXEHc1ONuplgFNitf3YjB8Z0IRlyPtNFxu3zphq10q6B7+G+7CVFEbY+rqRarcKaOYMhwVlJxzZmS+raYGlUufz6pn2A/+1+ji4h9DNBcomHEzIvPBPtruIJH3VHif90ylSXFq4sKkGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCiE1nB1tTtN4DGI97oBVE/f6QyYOVhiq4BuDAeUXR4=;
 b=EciB2a4IRDYIVKXSZi/UQs7nGJ5Anf6paAnkkRqR922sXyXxO95zBBlkjVLM4Oij5WF8NRWpJcaJTCIFNEYlLz88ctXbOj5GywlPKa0zB058erfGfQLXu7HyQABx0VRVpESRDHTxSoIMYOHL98PAYnkycPNPh5k1UenMq/WeANM=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM5PR12MB1467.namprd12.prod.outlook.com (2603:10b6:4:c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Tue, 30 Mar 2021 15:04:47 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 15:04:47 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: Macros for vram physical addr calculation
Thread-Topic: [PATCH 1/4] drm/amdgpu: Macros for vram physical addr calculation
Thread-Index: AQHXIZVSXY1VFJiBGkmDuPugf4JtSKqcZdGA
Date: Tue, 30 Mar 2021 15:04:47 +0000
Message-ID: <A3D5D927-4E86-463E-BEC8-D6FFD746FA20@amd.com>
References: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fb0acd0e-1857-4add-a1a8-66672f673202;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T15:03:46Z; 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c090d57-d41d-41fc-ffca-08d8f38d28c0
x-ms-traffictypediagnostic: DM5PR12MB1467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB14672C14D8EB9DDB56532F11807D9@DM5PR12MB1467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnREw1lrDhRj+OibF1wayVe7EfMKYXND0lcmS0LDzsIE3CbbtOKudCdXPNAw/qOOqi/yzg4+E0b8tBbyXmG3h5S5LInFnKjn2wU2iqfA5DNeUAIN6vk6kC39snK77xe7+4dVxFp54U4dXNCwMzdgORN792Qg4A8GhnkiMtUPsplQAxUottbOJeuWdh4A0/TXZ4H3DVy9eXVeCgN3rPirQkopiG8UGrnM/ZBeiASJ4lwgaOMYZFNKUN5JPzfWBgTMIEoBq6ynIkzm9KuTciHj2via9TQIH0hNgjoueescfi8vAxTIzfPx/U38aVp6sx7+MsRLwP2vg/9RURGu3W9gU0JFuqYhhs53rAQNdZ75e0cvZyr20ILPoKvhIZqTgFhkiphdJtl2f1gWt0QFUcHI3P3xhfdp9nGZS8Y2yhAK824ITcnxehK2ck2VpK5NY4RkI+5SgNBvUVZDSmPVN7GbA15hVlNpKsc3Zd+wrrSj4Yu5Fl8N/szkPtR4tqsVci2zm0676NvYfEAhGdBJ07B+0JOHQL3xAHHxap3Al/T5m8tInpR/0Ged2bTsb/XFF2gTF+o2kWOePgg9SVyTJSTLk81k+FQhPrRZkG6C+b7WiLRROMF62M9KeE2uoVcEh9BxL5oXRTMsGkqcAxUKhR5OYP0gf0HLhY/gPVOCX+MvFLd/ExkMaWEDwIZGGgsxKMW7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(2616005)(6512007)(36756003)(6506007)(26005)(66946007)(5660300002)(316002)(64756008)(186003)(478600001)(66476007)(4326008)(71200400001)(54906003)(6486002)(8936002)(8676002)(76116006)(33656002)(91956017)(2906002)(38100700001)(86362001)(66446008)(6916009)(66556008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?T0VoYWVoK1JUaDRtTHh4dWdpQitnN2pua2NPbkxKK3NucVM5Nk0vdXpPaU5O?=
 =?utf-8?B?bnBscnJ6UzlLWW0wYjg2L0owSFR5YXFkMkdScEVhSElvb0xmNzhEdURGUlJS?=
 =?utf-8?B?bS9pTTR3WXdCK2NFUVpSNnViMW13a0xPMkR2ZU9FS1Q2UlJFdTNsczFVTTVK?=
 =?utf-8?B?M0xOeVM2eHZ6ZjIrMTRZSUZ6eUtFTlRYYzEva21QUmxCN1oyYkxFaWUwelc4?=
 =?utf-8?B?TVdDVkFsTlBDR3FCWjJlWm5IeExJUWdOc2Z5aVFwUm9HeXBtZzc5TWFvd1Ji?=
 =?utf-8?B?UEsvaHBnNzhkVUlUQ08vaDUyNW56Ujl2UzhZSEMyWUtINXZCU1pVNDNkTHB3?=
 =?utf-8?B?T2RpQUt4MkpQWnFzeC90NTY5akhkUFlzWStUd21LNW0vV2VWYnFleUx1Y0hO?=
 =?utf-8?B?NE9aQTFGMHZzRTdaNGdGN3ZqeWpWOGdBbG5IdVR6dmNHNmZjbXJjZ0tEdGZn?=
 =?utf-8?B?aWFnNVExUHdqa1k3dHJ6WFBtOVFyRHZNb1M4NGRSWUdpOVkvUkNqZ2k1aGpS?=
 =?utf-8?B?L2tod2lqZDd6SVRXS3JRR2hyQmkraHEwdWkwZDZPVm5JakxGN0QxdW5IS3Q5?=
 =?utf-8?B?VWxNaUlpS3VTS2ZBNkVsVCtmU3hiaG43NjBKNllFRm96cm96azllK2w1eUlm?=
 =?utf-8?B?RVdvR2tSWmxDTlVDRC9GbSszemJDWndJMXVVaXRXT3lrU0hJZ2NpZUpkNmNr?=
 =?utf-8?B?Q1p6SStaQWc2OWJORXdodTVLbDY2MnhoS2ZoSVdzTytDeXJSREtGVTI0aEVC?=
 =?utf-8?B?aHdHSGluYmpPc1Y1NXRmRk1VdlVRRWhoK3l3WUFlQnZCTk95OWZmVFpDZHFV?=
 =?utf-8?B?cXZrQkxEMmkyVU10enRrRHFCR2hhWmdFcTlwY1h2cWlkVDN0ZTNhdTdWSlhm?=
 =?utf-8?B?NzE3eExaczB5VmFiaFBXUVRiTHVRdmdjbGd0RUc2cnkrV3NzSGpWeW8yRlBs?=
 =?utf-8?B?ZDVHalJKV1FGbnRmbGdiM1JwVkp6MGNkKy8vcFVoQUJIdFVsbWJZcjlUaTA0?=
 =?utf-8?B?cmplRzlzZDlnNEJIaTYydEo2M1VONmZpU3lyS0UwcEZMaHRSWTFub3lWQUZI?=
 =?utf-8?B?bUQyVjZGMnBUaDFRd09tMUEwN281RWhKcldXOE9vcEdpbmV0cWIyTHZYZEd3?=
 =?utf-8?B?bXo3L3FwdHoxeEtPWnBiNEpiekZ3d3Z2a05wMkNDQkhXMFl6a1dPT0I0dXdS?=
 =?utf-8?B?aUtJbm5obDdTN3JHeFh6S1MyOUNaVG1FVEFNZWZTV2dRc2tPdHU0RTZHR2Vp?=
 =?utf-8?B?bkhRWko5TVQ0YVZJQzZHdkdZRkQxWUI1eERTd29NMkRURG9OR25XaFYxOFpR?=
 =?utf-8?B?b2tEdUhqRGFWYWhuS0N4ZEpWM3o3eFJuclYzV2xDS3M2by9PYXJ3ZFIrdEFG?=
 =?utf-8?B?Tm5tUW5hUTZ3Y3huaUJrSFY3TWRGUVE1cWEzZzRhbmhEaDRIZGlrK1pLNGRo?=
 =?utf-8?B?VHd0SXpGcDcwT0U5Y05LVVlHTXQ3UW53QUovNUtqaUl5cTZQd2VoRUcxVXRw?=
 =?utf-8?B?Z0duYXNBalZyZjBaYXNvKzl0ZXlDWWlRbXcyemx3S0cxTVJMbitRMXJMV1VD?=
 =?utf-8?B?UU5yV3QraThuaWV2ZzEzaHNpSUx1aEx1czA3RWVDRFZ1UkpIUUNyWUFSNlpM?=
 =?utf-8?B?c004R1o5bnc3RlNHb2RQVjBrbXlmbC81Y2tmajNrczFQQ0JSTmIrKzBIT3px?=
 =?utf-8?B?ajFOUnIxWStFSHpwdk1yRHI5RUR1cnV1Nm82Qyt1SGxJUEJ6Ukh2SXZrK1Fj?=
 =?utf-8?B?S1I1NUh2TXVKSkRBM0d1MWJGQ08vMDlvMVVRUkFqQTc2OWIwbFF0QlRReVRC?=
 =?utf-8?B?Uk8xY0Zpb2M4NllBdnZYQT09?=
Content-ID: <41E6E184C2F15C4F9227EF1AA4763137@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c090d57-d41d-41fc-ffca-08d8f38d28c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 15:04:47.0351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okS3CB4i2Iju6leio/Cf5UJcp3Q3ZmzQ9iPnPj4lRhpvVcoB1MqOj9na6mds7/2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1467
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpQ
aW5nLCBjYW4gc29tZW9uZSBoZWxwIHJldmlldyB0aGlzIHNlcmllcz8NCg0KUmVnYXJkcywNCk9h
aw0KDQoNCg0K77u/T24gMjAyMS0wMy0yNSwgMTI6MzggUE0sICJaZW5nLCBPYWsiIDxPYWsuWmVu
Z0BhbWQuY29tPiB3cm90ZToNCg0KICAgIEFkZCBvbmUgbWFjcm8gdG8gY2FsY3VsYXRlIEJPJ3Mg
R1BVIHBoeXNpY2FsIGFkZHJlc3MuDQogICAgQW5kIGFub3RoZXIgb25lIHRvIGNhbGN1bGF0ZSBC
TydzIENQVSBwaHlzaWNhbCBhZGRyZXNzLg0KDQogICAgU2lnbmVkLW9mZi1ieTogT2FrIFplbmcg
PE9hay5aZW5nQGFtZC5jb20+DQogICAgU3VnZ2VzdGVkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxh
emFyQGFtZC5jb20+DQogICAgLS0tDQogICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuaCB8IDMgKysrDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykN
Cg0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21j
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgNCiAgICBpbmRleCAy
ZWU4ZDFiLi43Y2Q5ZDM0IDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuaA0KICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuaA0KICAgIEBAIC0yODMsNiArMjgzLDkgQEAgc3RydWN0IGFtZGdwdV9nbWMgew0K
ICAgICAjZGVmaW5lIGFtZGdwdV9nbWNfZ2V0X3ZtX3BkZShhZGV2LCBsZXZlbCwgZHN0LCBmbGFn
cykgKGFkZXYpLT5nbWMuZ21jX2Z1bmNzLT5nZXRfdm1fcGRlKChhZGV2KSwgKGxldmVsKSwgKGRz
dCksIChmbGFncykpDQogICAgICNkZWZpbmUgYW1kZ3B1X2dtY19nZXRfdm1fcHRlKGFkZXYsIG1h
cHBpbmcsIGZsYWdzKSAoYWRldiktPmdtYy5nbWNfZnVuY3MtPmdldF92bV9wdGUoKGFkZXYpLCAo
bWFwcGluZyksIChmbGFncykpDQogICAgICNkZWZpbmUgYW1kZ3B1X2dtY19nZXRfdmJpb3NfZmJf
c2l6ZShhZGV2KSAoYWRldiktPmdtYy5nbWNfZnVuY3MtPmdldF92Ymlvc19mYl9zaXplKChhZGV2
KSkNCiAgICArI2RlZmluZSBhbWRncHVfZ21jX2dwdV92YTJwYShhZGV2LCB2YSkgKHZhIC0gKGFk
ZXYpLT5nbWMudnJhbV9zdGFydCArIChhZGV2KS0+dm1fbWFuYWdlci52cmFtX2Jhc2Vfb2Zmc2V0
KQ0KICAgICsjZGVmaW5lIGFtZGdwdV9nbWNfZ3B1X3BhKGFkZXYsIGJvKSBhbWRncHVfZ21jX2dw
dV92YTJwYShhZGV2LCBhbWRncHVfYm9fZ3B1X29mZnNldChibykpDQogICAgKyNkZWZpbmUgYW1k
Z3B1X2dtY19jcHVfcGEoYWRldiwgYm8pIChhbWRncHVfYm9fZ3B1X29mZnNldChibykgLSAoYWRl
diktPmdtYy52cmFtX3N0YXJ0ICsgKGFkZXYpLT5nbWMuYXBlcl9iYXNlKQ0KDQogICAgIC8qKg0K
ICAgICAgKiBhbWRncHVfZ21jX3ZyYW1fZnVsbF92aXNpYmxlIC0gQ2hlY2sgaWYgZnVsbCBWUkFN
IGlzIHZpc2libGUgdGhyb3VnaCB0aGUgQkFSDQogICAgLS0NCiAgICAyLjcuNA0KDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
