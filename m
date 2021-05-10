Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BD1C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 07:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB963600CD
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 07:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB963600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C6886E252;
	Mon, 10 May 2021 07:13:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457476E252
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 07:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPAyr3qyKdfS9OA1kXjbALz9QIm4qR4qThRP7CNm7SZC231uZWj89YkRurmPWBzFX+8q5ihckYfWwvDlGvM4G4fJCVXYao2ABnI6mDJGl0YCfMjspkIb2zlvMRm73STWW1e6ONNesM4vNTrMGkH4CMtb+I5N46NkNudWlmlVJwZGXZw6CjmE2ekQ9/G+Y8CWrHKAGdr7sh4R6p3hgmKxiDs9tsuqtvtOYlPqIyYrEe+BF+aTQD1AEL2RyoWFMLnhGipIXDM/LJj577poVCt35xB4ZdoidMt8b+wEZSzYz9WkpxT9kwTIGjsjJn2Ct9YLLAEeZjur2Y4VfgQTcQAyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zgv67LD7GxZMmvB4VFMF9Iim2pjiE67KY9B1Faf2N8=;
 b=GZeblzX2n3/Jl7PcqAXeU8fNsJPeArEr0emWXXNfak0CrIq1+eNnahHxvJZZHOBXcaAC7d7vVi8Og8jv3B3InqxFuwupbyYcb8zF9znffInuHESsn76aFxz/vyll1SiBCLjVhag3FdReCaxCwKB+r8QFADyveXFqDoTvYsZLlY+XkO45+mmkEFqi0rYuq6g/J6XXxsZCxQv1W6a36g3TuvYOa5fXocI0KuiTX7f5XEdmfeAuZNASDCB5bzVcfHV7SlEIthrHyT47oL3UgWG1myzBmM6JqUr53j/xyrX56kZK6efSCzvkebQRBo1+s5rM9LqhVlAzRWZVfcD2tqu+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zgv67LD7GxZMmvB4VFMF9Iim2pjiE67KY9B1Faf2N8=;
 b=FwOWqLdk+j/lKroj4yXlndYtHgv3DckfuwTsZ6z1GuKQoviQYVMYHIKpRCiH/r/mwBqxAA1aerXSkNdBrWCui/UWg8v8ud3CkHsd7ia/tlfszM4xNuC73EVUnbOFqSixeh04ud0bYB6zH4L7P4CcZosqfw8Z+WdascVgjYCLdKo=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 07:13:08 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 07:13:07 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Nieto, David M" <David.Nieto@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Index: AQHXQ9Yf8LVbEME0wESo6KxpkiJJJqrbUMIAgADxAdCAAAjk7YAAA0ig
Date: Mon, 10 May 2021 07:13:07 +0000
Message-ID: <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>,
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
In-Reply-To: <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-10T07:13:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c5deeebf-432e-4e23-ab9a-cf0ae8d162e1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60a90d2b-18a3-4edd-dc8f-08d913831003
x-ms-traffictypediagnostic: CH0PR12MB5316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5316308853A448BCBC074F16F8549@CH0PR12MB5316.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnigKGykQjpvbVq62dHjmcJ8YbjglOiNmLAdGWT+FGHHFAAr49IAr+A5LB4aeXfTWdNWCi0vpyJ53UypfgKWdwkD/WuFYkyWXfiOQg5i1sg4MnLv/zXranpA3EKsmvWSWoXY/EusJybaWXZ2IjZhts+Kvdk5+5ZuKeOlygZGorrrOMDSEXEhVqugL7lMTv6DnIi9aj//a8dS6HaMSXyGNS3zsiRsZAGsuwdjJTpC/cF/E9AQIvvFVK4G+naFilnMrzwviRMDTHNhi9G8g0mqdE8+2efVDmUEKI8ZPtkwlXU6xVAUtX65LAMXAlKq3o7vXdUc0cesV95VbOG1vTkDPm+YT3BPgM4wW0ciRU/ESOtJstG9N7+E2BBYq0qCxrcXpgqGlOPLDe1qqVsnIR/+U/YCcCUud4KMaN54tE+uiGIUBkQ/V7lf0CW2pCB+khzRcM5L8ntcLrDDc8fJ3AC39sjNi1ba5TJKpr3SMkvWA2VTVabwP7hrMyxSDhgka1kQhRcqCHa5YUAmSf6l7m51E1OgGZeRc1lKOkYeHFAYTFCIZnrNa+yKIWsIKUGlF6v6N2oLMravdOeVqkrMlCE0GEFdtiRF5nEEcNeqpQNj4Ip2E124KC4fu4SSezj06lb1632ibkXwhp0H9pfSKJXGbJpSXAhJzc40L6mbwaWVeadqEtkWVpp03VWAjixm3Nuv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(53546011)(6506007)(6862004)(66556008)(478600001)(66476007)(4326008)(316002)(66946007)(7696005)(76116006)(122000001)(64756008)(66446008)(9686003)(6636002)(55016002)(52536014)(45080400002)(5660300002)(86362001)(38100700002)(71200400001)(26005)(8676002)(8936002)(2906002)(54906003)(186003)(33656002)(83380400001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?eTEwWGtlOGRUS3pRZkw3TGNreVlXOUxWTEg2S2liWTM4Vy90dlJGcVpNSmVS?=
 =?utf-8?B?MCt1Z3hXU0ZwbGoydCs3ZWYwWjM4NEt0Y0o2OVE0anJ4b01FQmJ5UlpTbWJK?=
 =?utf-8?B?S0hRQjRGT3pKT3FZamQ1Si9PdEtPQUhuQ0FVOTAxTkZaQVBVUU93OG80cGlL?=
 =?utf-8?B?Y1hWOEJZUEpHamJnei9sdnZ6WU9KZDNNVnBtVjd4b0dCMS9VZ2lWU0duSkYv?=
 =?utf-8?B?Ly9ieWpYTEEvUHlLZXhzL2ZWbC9QWGlSZVFhL1praVpxOEdrNzdyNXpUM0Nr?=
 =?utf-8?B?cThmVWorYUdldmlrNk5rWGRteEgzdkdjMlpiZHIyMGEzRDN2WUhWcmJlTW14?=
 =?utf-8?B?dTkycXpGMXhGSC9HRlRjWFNxelZzNGIyTndscTdCNElTZHA0a0p0ZytZYklQ?=
 =?utf-8?B?WElzVXdvdDNZSmQ3UUhrajhqeUNkRVQyUWZNVGtHeXZrdDJCa3Bvblcyb0JG?=
 =?utf-8?B?MmlTelZ0Y0lZRUdIVHUxaHgvR1ZQd1JEUjRlaEt3dWNMamxYS0g3ZFVWTFFN?=
 =?utf-8?B?aTdjRCtUN25sc1FiUGwxaVpXS1lGRVFvYUxEbEZ3d3pNOFJCSWdHbkxiYWQv?=
 =?utf-8?B?NkpSZUVBalF1YkxVMTBkYkRTUWR5YVhqWHV0SGFuVmVWUzM1OU96N1ExVnYw?=
 =?utf-8?B?RHQrRXUyRmVBR21oVGZHUWpxY05HNEJvVmgrUHJTUHhpRnM0c3BIR1hDdFc2?=
 =?utf-8?B?SWsvcTZtcjRPYU1ZYkQ1cmV1Y3Fpb1ZFNk9GdG80Z3ZnWm1wNTd5Sml0L3hL?=
 =?utf-8?B?NjA1ZWZBNEMyNzU0M2E3TXhydko3MXY0TVIyRjhNeGMwTW1wbEFWV3dnbnBW?=
 =?utf-8?B?ZmtWa2lpZks0Ri84Q2w5dmZWUzVaRTJoRVBuTmdBZkNOd00vQmN1SGdrYnAx?=
 =?utf-8?B?YzQwTTErOHo4TXVEWjhpWXI2WjVuWlhvcTZXMkxQNk9NSDhqQXVZVXFFQlBv?=
 =?utf-8?B?V2tCMmgvQi9yS3QrVTcva1BGSnlLRWRJcmFTYWNKUUltLzNaVEsyZTFBYWtS?=
 =?utf-8?B?QUtUcDY5WVlrWjlGeUh6L1o5RWxPT0hBTUJ2R2VIZWhNemFHdWMrUHB2RmVk?=
 =?utf-8?B?dkhmQUpTSmc1NjVQTDNxcjhEN3dRSmNYT3NLSzdUL0lFZVZkRTllb2JBa05h?=
 =?utf-8?B?b0kvRUxPcXpZczg0YlZzNnFqTTFFMDN4OEg0ajVIZGFOb2RpaFoveXJRblBN?=
 =?utf-8?B?ZEg2T2RsSDJqQkJheUJPMGlFUm8vbHI1TmpyVGNjNGhGTURIcTA2VDIzK2kr?=
 =?utf-8?B?dzZ3cy85WFduWkZ3T1A0ZEZPVjdCMkFxcUNWUUFQS2thdnc0SGl3alF2UUM4?=
 =?utf-8?B?dERmVER0VmxxLzBLRkhITmpldklXREFZUXREZkdzZFN2VHVqeGplWFVDREtQ?=
 =?utf-8?B?WkVjN0hpd2dldURNblJldkVMZERJTm5iK1ppcHR4M09qcENTdDBiN3ZnOVJm?=
 =?utf-8?B?ME1FdlNBdXVuanlFdnhJOXlVSGxpdThrb0NnaWRONW5nWHQ3NHNuaWg5bEhv?=
 =?utf-8?B?R1p5Q0VYeU1jUmlLQlh5UmJqUHBiZjBzM01vUmorbXNEZEdyWFZEbHJBRDBP?=
 =?utf-8?B?a29YOHEySkgwLzh5V1FzTXFlaDkyRXBhcjVCQVpSa0pxNUp5Q2pJZG5wNG5D?=
 =?utf-8?B?bjlEUnczaFpNUDRXZnorQU5IWStleTFLbVQ4MVg0ZmpBODFrZDUxckN5SEMw?=
 =?utf-8?B?T0xhaU9qTCtyQVRwSy9UR1JqT3d2T2p0bVEvUzJYdUVkbEtaN1pkZFRMREFo?=
 =?utf-8?Q?7HtCwFBnphJgAqqOmfSwPe9UF7JeTwsChHhbgaB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a90d2b-18a3-4edd-dc8f-08d913831003
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 07:13:07.8315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4nu4IBfsr0+fKZ0oiIpiUXCHyp96ShYGYOP7+tCEJEAmWwMRRnbGlinKAF3ee2SCL1uefgJtRsBRVlsQMBdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, Kees Cook <keescook@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBEYXZpZCwNCg0KV2hhdCBJIG1lYW50IGlzIHRvIE9OTFkgZGVsZXRlIHRoZSBzZXJpYWxbMTZd
IGZyb20gZHJtX2FtZGdwdV9pbmZvX3ZiaW9zLCBub3QgdGhlIHdob2xlIHN0cnVjdC4NCg0Kc3Ry
dWN0IGRybV9hbWRncHVfaW5mb192YmlvcyB7DQoJX191OCBuYW1lWzY0XTsNCglfX3UzMiBkYmRm
Ow0KCV9fdTggdmJpb3NfcG5bNjRdOw0KCV9fdTMyIHZlcnNpb247DQoJX191OCBkYXRlWzMyXTsN
CglfX3U4IHNlcmlhbFsxNl07IC8vIGppYXdlaTogc2hhbGwgd2UgZGVsZXRlIHRoaXMNCglfX3Uz
MiBkZXZfaWQ7DQoJX191MzIgcmV2X2lkOw0KCV9fdTMyIHN1Yl9kZXZfaWQ7DQoJX191MzIgc3Vi
X3ZlZF9pZDsNCn07DQoNCnNlcmlhbFsxNl0gaW4gZHJtX2FtZGdwdV9pbmZvX3ZiaW9zICBjb3Bp
ZWQgZnJvbSBhZGV2LT5zZXJpYWwsIGJ1dCB0aGVyZSdzIGFscmVhZHkgYSBzeXNmcyBuYW1lZCBz
ZXJpYWxfbnVtYmVyLCB3aGljaCBleHBvc2VzIGl0IGFscmVhZHkuDQoNCnN0YXRpYyBzc2l6ZV90
IGFtZGdwdV9kZXZpY2VfZ2V0X3NlcmlhbF9udW1iZXIoc3RydWN0IGRldmljZSAqZGV2LA0KCQlz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQ0Kew0KCXN0cnVjdCBkcm1f
ZGV2aWNlICpkZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQoJc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSBkZGV2LT5kZXZfcHJpdmF0ZTsNCg0KCXJldHVybiBzbnByaW50ZihidWYsIFBB
R0VfU0laRSwgIiVzXG4iLCBhZGV2LT5zZXJpYWwpOw0KfQ0KDQpUaGFua3MsDQpKaWF3ZWkNCg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmlldG8sIERhdmlkIE0gPERhdmlk
Lk5pZXRvQGFtZC5jb20+IA0KU2VudDogTW9uZGF5LCBNYXkgMTAsIDIwMjEgMjo1MyBQTQ0KVG86
IEd1LCBKaWFXZWkgKFdpbGwpIDxKaWFXZWkuR3VAYW1kLmNvbT4NCkNjOiBBbGV4IERldWNoZXIg
PGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+OyBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz47IERlbmcsIEVt
aWx5IDxFbWlseS5EZW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBBbGlnbiBzZXJpYWwgc2l6ZSBpbiBkcm1fYW1kZ3B1X2luZm9fdmJpb3MNCg0KTm8sIHRoaXMg
c3RydWN0dXJlIGNvbnRhaW5zIGFsbCB0aGUgZGV0YWlscyBvZiB0aGUgdmJpb3M6IGRhdGUsIHNl
cmlhbCBudW1iZXIsIG5hbWUsIGV0Yy4NCg0KVGhlIHN5c2ZzIG5vZGUgb25seSBjb250YWlucyB0
aGUgdmJpb3MgbmFtZSBzdHJpbmcNCg0KPiBPbiBNYXkgOSwgMjAyMSwgYXQgMjM6MzMsIEd1LCBK
aWFXZWkgKFdpbGwpIDxKaWFXZWkuR3VAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79bQU1EIE9m
ZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+IA0KPiBXaXRo
IGEgc2Vjb25kIHRob3VnaHQsDQo+IF9fdTggc2VyaWFsWzE2XSBpbiBkcm1fYW1kZ3B1X2luZm9f
dmJpb3MgaXMgYSBiaXQgcmVkdW5kYW50LCBzeXNmcyBzZXJpYWxfbnVtYmVyIGFscmVhZHkgZXhw
b3NlcyBpdC4NCj4gDQo+IElzIGl0IGZpbmUgdG8gYWJhbmRvbiBpdCBmcm9tIGRybV9hbWRncHVf
aW5mb192YmlvcyBzdHJ1Y3Q/IEBBbGV4IA0KPiBEZXVjaGVyIEBOaWV0bywgRGF2aWQgTQ0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBKaWF3ZWkNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiBTZW50
OiBTdW5kYXksIE1heSA5LCAyMDIxIDExOjU5IFBNDQo+IFRvOiBHdSwgSmlhV2VpIChXaWxsKSA8
SmlhV2VpLkd1QGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPjsgS2VlcyBDb29rIA0KPiA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBBbGlnbiBzZXJpYWwgc2l6ZSBpbiANCj4g
ZHJtX2FtZGdwdV9pbmZvX3ZiaW9zDQo+IA0KPj4gT24gU2F0LCBNYXkgOCwgMjAyMSBhdCAyOjQ4
IEFNIEppYXdlaSBHdSA8Smlhd2VpLkd1QGFtZC5jb20+IHdyb3RlOg0KPj4gDQo+PiAyMCBzaG91
bGQgYmUgc2VyaWFsIGNoYXIgc2l6ZSBub3cgaW5zdGVhZCBvZiAxNi4NCj4+IA0KPj4gU2lnbmVk
LW9mZi1ieTogSmlhd2VpIEd1IDxKaWF3ZWkuR3VAYW1kLmNvbT4NCj4gDQo+IFBsZWFzZSBtYWtl
IHN1cmUgdGhpcyBrZWVwcyBwcm9wZXIgNjQgYml0IGFsaWdubWVudCBpbiB0aGUgc3RydWN0dXJl
Lg0KPiANCj4gQWxleA0KPiANCj4gDQo+PiAtLS0NCj4+IGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1
X2RybS5oIHwgMiArLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0u
aCANCj4+IGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggaW5kZXggMmI0ODdhOGQyNzI3
Li4xYzIwNzIxZjkwZGENCj4+IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRn
cHVfZHJtLmgNCj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+PiBAQCAt
OTU3LDcgKzk1Nyw3IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2luZm9fdmJpb3Mgew0KPj4gICAgICAg
IF9fdTggdmJpb3NfcG5bNjRdOw0KPj4gICAgICAgIF9fdTMyIHZlcnNpb247DQo+PiAgICAgICAg
X191OCBkYXRlWzMyXTsNCj4+IC0gICAgICAgX191OCBzZXJpYWxbMTZdOw0KPj4gKyAgICAgICBf
X3U4IHNlcmlhbFsyMF07DQo+PiAgICAgICAgX191MzIgZGV2X2lkOw0KPj4gICAgICAgIF9fdTMy
IHJldl9pZDsNCj4+ICAgICAgICBfX3UzMiBzdWJfZGV2X2lkOw0KPj4gLS0NCj4+IDIuMTcuMQ0K
Pj4gDQo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsaXMNCj4+IHQgDQo+PiBzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q0oNCj4+IGkNCj4+IGF3ZWku
R3UlNDBhbWQuY29tJTdDY2VhMzE4MzMxODRjNDFlODU3NDUwOGQ5MTMwMzYwY2MlN0MzZGQ4OTYx
ZmU0ODg0ZQ0KPj4gNiANCj4+IDA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1NjE3Mjc1
MjM4ODAzNTYlN0NVbmtub3duJTdDVFdGcGJHWnNiMw0KPj4gZCANCj4+IDhleUpXSWpvaU1DNHdM
akF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlNw0K
Pj4gQyANCj4+IDEwMDAmYW1wO3NkYXRhPWtBSmlDNldvSlVUZUV4d2s2ZnRyTGZNb1kyT1RBd2c5
WDdtR2dKVDNrTGslM0QmYW1wO3Jlcw0KPj4gZQ0KPj4gcnZlZD0wDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
