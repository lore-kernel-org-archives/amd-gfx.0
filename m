Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A42BC5479D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 13:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D9D10E740;
	Wed, 11 Jan 2023 13:23:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6574310E740
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 13:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbqOpzzUDwJi5qY0vmY+Q7JOzJEXTYfxS68DlUF/s42006JU80lSwHXGcQFJc/FY5Ess3wnxRo9RfcMfUmZbGYOSgrEK0L4AlXFNU9CSWWr+QtbIBScYOlm35M4CkEz7zYQZKKAOJFJ5UqLpUztl9QqOYMyyvsqzP8y+Jnu1ioJih3rbfnpyVNlOIjZnehRPmEVOMcV6z+0PxLXmYTHJ8rwaMD65feDSGKM7cpg+raaRqOdNo+rU16irafwROyup5U0eStb8gO7Ry6/WW8qXUrjYDHj3bSJB1G76mDXG2lWNlkEHWBgomkQmWu/kUeqUMgJGrdoEq2U0zNtcV7Wa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ2zMQcnMK3PAmqaMqsHcS+qnMj5kKaUMlhNIdu2XIY=;
 b=V1f4hDZRlXZilfFU7EK2GPKxHmZIskjNnoZsppGCDCskhjEH0PkjgGYJh+Rpw944O8JteSDiIM4XIfNEYV75bNmmTyUUDE7A5TQ1+zbexusGZjq/Z2ZV81Atv7NFGXSYbaZgwtItZ57m/RxBySGjli89dFcmtqdd9Wd9v8d5llM0YYtFkALwYqukYjn5rwc8ejRgcHPeh0Lg4b0shGkAkhc7Q2sWy+bMG42BuqWJBKlan41EXi/jeJQ6xnhC9k44hwKVClnvdr6x3SLfHx9+xVHm4y8YqYIuTvGZIt5byNcQVQYAqnx9LdcUNzx32+33/YX4wjx7NvgfnEoxxnaRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ2zMQcnMK3PAmqaMqsHcS+qnMj5kKaUMlhNIdu2XIY=;
 b=tHKPlCw9CTDPCvThsuFzIPczWm1X4Vv1wstOQUkZAnQ1JVkSwy4iG175YSzYZh/SK+VCijWqq+GMFZ4uh+p+hCsTSr2Ptc+RkdWV0qny0J1Dyz+1734tZj/CbXi3/alez3gdSDtvsMn9Xdg/RWF5jTXgRAUYcnb6ItL+tOkqdpY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 13:23:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db%5]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 13:23:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.7
Thread-Topic: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.7
Thread-Index: AQHZILUVoTOA57zzmEKoUzm3sYBq1a6XPS7ggAB4SACAAYJ6sA==
Date: Wed, 11 Jan 2023 13:23:19 +0000
Message-ID: <DM6PR12MB26194938F0D4873D5DB83A1DE4FC9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-8-evan.quan@amd.com>
 <DM6PR12MB26191B413EDC7BD52A9D0532E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bc81b6b8-4bf8-4565-80f4-cb46539318ff@gmail.com>
In-Reply-To: <bc81b6b8-4bf8-4565-80f4-cb46539318ff@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-11T13:22:26Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=997f961b-461c-40ff-88e4-04994582ded6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: 711606b5-3ce6-4f52-ae6e-08daf3d7017f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FROCeff2WVdBCrr04jEnjznJRz5H4jXAkOURnvBtc53DMJop3TRIxPjYwBw1yGXDQgT+arNWl+qKDEynaUSrBW1/s+r23W1aV5oSMh0MJSpRHQy8ZJxs9le4/Y+6lm+qPQCYrjs9b8/7WxjgvZKuudoIlJZb6CqdACNPNVFxZ6Sj0WJgHE6nyysT/pizZNa4RR0OOo0yuRIsoDllizfe4I05TmbUy5OfOREQtQEu8jS3L+yesrtTS1vxKh7jBTM0xZ+zvi028eQ+sVFpjhGJSEoGn8+0uZPQxHpOE9bZsSsmguvYHjMLM7CSyFRz8fxIx5Ii/h2Sq2l+RnhcVjOulPUJNiCG9Ue+LErmQUxZqxoPfz7OMy/GjoirsvNZTVudornNIpdiV8a9rt117VB5LIoI4snzFBvZXQT6Dt+rwpnYe5StSF6EyA4PiFRge6JlKx3VMxeuxGmpQz6cXJnsC+ccijlztQ0I7EUbc5mTgevYzD43oqunIyaU4vr9iDv8MzPwrzYIeiOTQ8/0+4HLVnf3j048EEjYh6M7aYOBXHxtudb5x9fdUh3mb1Ofbc9FSKnJP0Uj15NVyo3gUIxFPmLkJT8Q5eBFwBWrz6R/ruvA4rfPxviw2JWN6zQK9OatIaXmCfebSBnrjTV6FUsETwvssiITbKr6MU3lNwVodCgnymY7SG/HzRbucgFwjTEs1RHDbBMMBjbk6Sl3PNW0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(6506007)(38100700002)(122000001)(53546011)(2906002)(478600001)(71200400001)(186003)(33656002)(26005)(7696005)(9686003)(316002)(5660300002)(83380400001)(52536014)(8936002)(55016003)(86362001)(110136005)(38070700005)(66476007)(4326008)(8676002)(41300700001)(76116006)(66556008)(66446008)(64756008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGhlTVZzM0NyUkJJQjg2dWVXeVZUNWRYdHlrRXVydmF2TUFYdVJFQU9JbjJN?=
 =?utf-8?B?MjRab0pPY25vQzhSeFRWTHkxNE1KVVpWSjhHV3BsMUdSZGhJa05mUVNNZ1VN?=
 =?utf-8?B?SVBVREFrdlVJVzg2QWFsZE1Xb3JXc1NqTk4rZWIvdmdGNG9PZGk0WUtCSVND?=
 =?utf-8?B?RVE4VlpyYngxclE2U0Q5OS95ZllUeGQ3NE9PUlMxRDdqU1Vpd2tnVFVjdjF0?=
 =?utf-8?B?SlNIaVF6WTlQM3g5OUliRFozeTlNV3FkY1RVWlduRmVvbnY0ZU4wTjVpQ1Zm?=
 =?utf-8?B?eXVPcUd0cjN4QjNXM01HMVRmekRPcVdtdGl0c0ViSnppQzhFVmxTK0RuWjBL?=
 =?utf-8?B?b0Y2Y3NWYzhWNzNWNmpQNVZyeFp2QmJ2Z3laZEE0MVZsRStTRlFMY2FibDBQ?=
 =?utf-8?B?QjdqeUNMemRnaEUzT1d5bVN4bDRTUFpIS2Y2dWhvREo2MmRuNjBLNFZFb0Ny?=
 =?utf-8?B?WHFpcmIvS3dUQ2tKM3NpeVZKdGJIZUZUSTkyc2R2dEIzTGg5dXltYnE2TGhM?=
 =?utf-8?B?WkV5T2dtWW1PZDJCSk8reWRWcVdjR2N6c3g2THVWeC9ab2VodzVyY1dwcmJv?=
 =?utf-8?B?M3JCTnNFbmxRYnlvTXN4bkJqT1hsUWpneVZ6emF6NncrY2prVFgyOUlDSk1s?=
 =?utf-8?B?eUpiZXNYRXNNUmsxenJyNWhSUzEwcEwyalZmaUdNeDlYUFJMUEo3dUN5M0p5?=
 =?utf-8?B?MzhxejR6OEF2akgyTUFMMVJmdytENmN0RHZZQ3FCRU9mUFBXZHFLcmVVLytP?=
 =?utf-8?B?b3dyUkNCanhqbFh2U2RyVm5lZmpnQm10aUdxdFVaVXF6OFpYTTJyQ3p6MUdi?=
 =?utf-8?B?VXhocUkvVmE1R2lSSGFRRm5idkNiMU5rd0p1bm1uOFZzVDFKS0FOR3BBM1Mr?=
 =?utf-8?B?VFkxaUdSQ1NJOVVZOFZnU3d3Nmk3NW1hc25GV1JyVFVaSFhiOTViT2NzWUFS?=
 =?utf-8?B?aWExUFZYQWE4UGg0eXdycW9COFBtTDd1c25SS080MU1ydzN3cVdTUm90OGdw?=
 =?utf-8?B?a3ZZVlRKQWluYndBb25HWnBwMUt5TWczbUUrU3pwMHlzUHhlSzBseEhSRUxH?=
 =?utf-8?B?WUV1djZLUytub21hVCtvMVpHYUE0aFU1cnAzcTFSU0xVeWoySlRTZkRVb2JZ?=
 =?utf-8?B?ZzQvR0h3TnZGaTFDMmdXbkpGSDFEMzYraThsZEFrZFMxbW9zWFQ2SjJCN3Ax?=
 =?utf-8?B?YWNDZ1hQdnd2NFlCaEUzREpvSGt3d0hrSmFXRjVzbG9uakNmT3N5MS9nSGxa?=
 =?utf-8?B?WGFKcFN5a0tyeU5ibS9KcWhjWm5kaTRTaUorRjJyaERiMHpyV3pHSjc0TEpD?=
 =?utf-8?B?NFZ2V0xySXltbkVZVG5tMU16RklUdi84Z0lBNHZtenA2VERSN1Nib01xZXE4?=
 =?utf-8?B?VHlqQ1ZNc3M5emgzWU1yaTR3bnNxNEJrdkZIOGFUVVV4a3FtQ29TWGN0YnJ1?=
 =?utf-8?B?Tk02M1kxVHpPOFlHUXNXSURoZ2xNNnB0NEJ4ejdHWHhlU1JJRTM1WDFYcjla?=
 =?utf-8?B?NkhyeWhraEt2M1FlbGcwaTk0L2lJa1ZJeno2VUk4RkZUSklpTjdYWXlzcTUy?=
 =?utf-8?B?RUFnNXFKZEs5YWdRRVY4Y0pUNXhhanIzTHBJUFFqTXcyTUxVbSt6WUh2elB0?=
 =?utf-8?B?M05yNGJwWGpWcTZMNWs1UFlrdDZlbElYdXpndGFLTjFJaE14bEd0OEl6eWFL?=
 =?utf-8?B?amYwNEZlMzZscjYxdnVkM2VRVHNyU3pBeTVXZFFkK20xRTdtYSthWDQ4ZzNW?=
 =?utf-8?B?cGI5dFBLbnBQWVJMSmZsNWk0SlpRczF1MHNFMkV1NlV1di82SnVkOWs3WHRT?=
 =?utf-8?B?aGpGVzFrNTJBUU1QbWkrL3dxUVJSRi9tRENZRUtadnJxK1hTTzdVWitEY0li?=
 =?utf-8?B?UUhJSmpFUVRSa1UrZmFMckl4WUxEKy92c2JsaWVxVE5WUE9pT1NYY0dSNENL?=
 =?utf-8?B?MkdtNlMzdkhYOER2aVY3QXJtcm82a3EydmNHV0N0M3pFbkFTcE9yaVFFbjhk?=
 =?utf-8?B?QWZZRGthbW9jajRzMkJJbWVkR0xVTDM5amg4bm1nNTgvMU9KL2s5WUQ1VWhQ?=
 =?utf-8?B?YTBJb1dhZE5nTDFuMGFpRDRqc1BBR0YwdWRKSTBEMWh4blBHZWc0VFEwNUhL?=
 =?utf-8?Q?Cyk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711606b5-3ce6-4f52-ae6e-08daf3d7017f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 13:23:19.4853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kk1P4l2xM0Yv5KsCPiZ64nf+mbqRkFmnJTWdVTHnMUcS7dNMuBkIKCoWUYh0pAE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hdHQsDQoNClRoZSBwcm9i
bGVtIHdpdGggdGhlIGFwcHJvYWNoKHJlbW92YWwgb2YgaW50ZXJmYWNlIGZ1bmN0aW9ucyBmcm9t
IHRoZSBwcHRfZnVuY3MpIGlzOg0KMS4gSWYgdG8gZHJvcCBzdXBwb3J0IGZvciBzb21lIHN5c2Zz
IGludGVyZmFjZSwgeW91IG5lZWQgdG8ga25vdyB0aGUgaW50ZXJuYWwgaW1wbGVtZW50YXRpb24g
ZGV0YWlscyB0byBtYXNrIG91dCB0aGUgY29ycmVzcG9uZGluZyBmdW5jdGlvbi4NCiAgICBUaGF0
J3Mgbm90IHN0cmFpZ2h0Zm9yd2FyZCBhbmQgbWlnaHQgYmUgbm90IGFuIGVhc3kgam9iIGZvciBu
ZXcgY29tZXIuDQoyLiBTb21ldGltZXMgdGhlIG1pc3Npbmcgb2Ygc29tZSBpbnRlcmZhY2VzIGlz
IHVuaW50ZW50aW9uYWwuIEl0IG5lZWRzIHRvIGJlIGFkZGVkIGluc3RlYWQgb2YgYmVpbmcgdHJl
YXRlZCBhcyB1bnN1cHBvcnRlZC4NCjMuIFRoZSByZW1vdmFsIG9mIHRoZSBpbnRlcmZhY2UgY2Fu
bm90IHVwZGF0ZSB0aGUgc3lzZnMgZmlsZSBwZXJtaXNzaW9uIHRvZ2V0aGVyLiBUaGF0IG1lYW5z
IHRoZSBzeXNmcyBmaWxlIG1pZ2h0IGJlIHN0aWxsIHNob3duIGFzIHdyaXRhYmxlIHdoaWxlDQog
ICAgYWN0dWFsbHkgdGhlIHNldHRpbmcgaXMgbm90IHN1cHBvcnRlZCBhdCBhbGwuDQpUaGUgcGF0
Y2ggc2VyaWVzIHRyeSB0byBhZGRyZXNzIHRoZXNlIGluIGEgc2ltcGxlIGFuZCBzdHJhaWdodGZv
cndhcmQgd2F5Lg0KDQpSZWdhcmRpbmcgdGhlIG1hbnVhbCBmYW4gc3BlZWQgc2V0dGluZyBpc3N1
ZSB0YXJnZXRlZCBieSB0aGlzIHBhdGNoLCB0aGUgU0NQTSBmZWF0dXJlIG9mIHRoZSBuZXcgU01V
MTMgYXNpY3MgcHJldmVudHMgdXMgZnJvbSB0b2dnbGluZyB0aGUgZmFuIGNvbnRyb2wgZmVhdHVy
ZSBmcm9tIGF1dG8gdG8gbWFudWFsLg0KV2l0aG91dCB0aGF0LCB0aGUgbWFudWFsIGZhbiBzcGVl
ZCBzZXR0aW5nIHRvIHNvbWUgc3BlY2lmaWMgUlBNL1BXTSBpcyBub3QgcG9zc2libGUuDQpBYm91
dCB0aGUgY2FwYWJpbGl0eSBpbiB0aGUgT0QgdGFibGUgeW91IG1lbnRpb25lZCwgaXQgbWlnaHQg
YmUgYSBkaWZmZXJlbnQgaXNzdWUuDQpTaW5jZSBhcyBJIGtub3csIHRoZSBjYXBhYmlsaXR5IHRo
ZSBPRCB0YWJsZSBwcm92aWRlZCBpcyB0byBjaGFuZ2UgdGhlIG1pbmltdW0vbWF4aW11bSBmYW4g
c3BlZWQgbGltaXQuDQpUaGF0IHNob3VsZCBiZSBub3QgYWZmZWN0ZWQgYnkgdGhlIFNDUE0gYW5k
IHJlbGV2YW50Lg0KDQpCUg0KRXZhbg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBNYXR0IENvZmZpbiA8bWNvZmZpbjEzQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
SmFudWFyeSAxMCwgMjAyMyA5OjU3IFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBMYXphciwgTGlqbyA8
TGlqby5MYXphckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDgvOF0gZHJtL2FtZC9w
bTogZHJvcCB0aGUgc3VwcG9ydCBmb3IgbWFudWFsIGZhbg0KPiBzcGVlZCBzZXR0aW5nIG9uIFNN
VTEzLjAuNw0KPiANCj4gT24gMS85LzIzIDIzOjQ4LCBRdWFuLCBFdmFuIHdyb3RlOg0KPiA+IFtB
TUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KPiA+DQo+ID4gV2UgbmVlZCB0aGVzZSB0
byBhZGRyZXNzIHRoZSBmYW4gc3BlZWQgc2V0dGluZyBmYWlsdXJlIHJlcG9ydGVkIGZvciB0aGUN
Cj4gbmV3IFNNVTEzIGFzaWNzLg0KPiBNeSBvcGluaW9uIHNob3VsZG4ndCBtYXR0ZXIgbXVjaCBn
aXZlbiBzcGFyc2VuZXNzIG9mIGFjdGl2aXR5LCBidXQsIGRlc3BpdGUNCj4gaGlzLi4uIHNob3J0
IHRvbmFsaXR5LCBJIGFncmVlIHdpdGggTGlqbydzIGFzc2Vzc21lbnQgdGhlcmUuDQo+IA0KPiBB
cyBzb21lb25lIGxlc3MgZmFtaWxpYXIgd2l0aCB0aGUgY29kZSBiYXNlLCB0aGUgdXNlIG9mICJt
dWx0aXBsZSBzb3VyY2VzIG9mDQo+IHRydXRoIiBjb250cmlidXRlcyB0byBtYWtpbmcgaXQgaGFy
ZGVyIHRvIHVuZGVyc3RhbmQgYW5kIHJhbXAgdXAgd2l0aC4NCj4gDQo+IEFzIGZvciB0aGUgc3lz
ZnMgZmFuIGNvbnRyb2wgaXNzdWUgaXRzZWxmLCB0aGlzIHdvbid0IHJlYWxseSAiZml4IiB0aGUg
aXNzdWUsIGJ1dA0KPiByYXRoZXIganVzdCByZW1vdmUgd3JpdGUgcGVybWlzc2lvbnMgZnJvbSB0
aGUgaHdtb24gZmlsZXMgKGlmIG15DQo+IHRlc3RpbmcrdW5kZXJzdGFuZGluZyBpcyByaWdodCks
IHNvIGl0IHdvdWxkbid0IHNlZW0gdG8gYmUgYSBoeXBlci1jcml0aWNhbA0KPiBkZWxpdmVyYWJs
ZSB0byBtZSBhcyBhIHJhbmRvbSBvdXRzaWRlciBsb29raW5nIGluIChkZXNwaXRlIGJlaW5nIGVm
ZmVjdGVkIGJ5DQo+IHRoZSBpc3N1ZSBwZXJzb25hbGx5KS4gRXZlbiB3aXRoIHRoYXQgaW50ZXJm
YWNlIHJlbW92ZWQsIHRoZXJlIGlzbid0IGFub3RoZXINCj4gd2F5IHRvIGNvbnRyb2wgdGhlICJh
dXRvIiBmYW5zLCBhcyB0aGUgRlcgcmVwb3J0cyBpdCBkb2Vzbid0IHN1cHBvcnQgdGhhdA0KPiBj
YXBhYmlsaXR5IGluIHRoZSBPRCB0YWJsZSwgYW5kIGlnbm9yZXMgYW55dGhpbmcgc2V0IHRoZXJl
aW4gZm9yIHRoYXQgcHVycG9zZS4NCj4gSG9wZWZ1bGx5IHRoYXQncyB0ZW1wb3JhcnkgdW50aWwg
RlcgZ2V0cyBmaXhlZD8NCj4gDQo+IEkgYWxzbyB0aGluayB0aGUgYmVoYXZpb3Igb2YgdGhlIG90
aGVyIHByb3Bvc2VkIHNvbHV0aW9uIChyZW1vdmFsIG9mIGludGVyZmFjZQ0KPiBmdW5jdGlvbnMg
ZnJvbSB0aGUgcHB0X2Z1bmNzKSwgaXMgb2JqZWN0aXZlbHkgYSBiZXR0ZXIgZXhwZXJpZW5jZSB3
L3IvdA0KPiBvdXRjb21lLiBJZiB0aGUgZnVuY3Rpb25zIGFyZSBOVUxMLCB0aGVuIHRoZSBod21v
biBkZXZpY2UgZmlsZXMgZ28gYXdheQ0KPiAqY29tcGxldGVseSosIGluc3RlYWQgb2YganVzdCBi
ZWluZyBtYXNrZWQgZnJvbSB3cml0ZSBwZXJtaXNzaW9uLCB3aGljaA0KPiB3b3VsZCBtYWtlIHRo
ZSBtZXNzYWdlIGNsZWFyZXIgdG8gdGhlIGVuZCB1c2VyIHRoYXQgaXQncyBub3QgYW4gZXJyb3Is
IGJ1dCBhbg0KPiBhY3R1YWwgbGFjayBvZiBmdW5jdGlvbmFsaXR5Lg0KPiANCj4gQ2hlZXJzLCBz
b3JyeSBJIGNvdWxkbid0IGhlbHAsIGJ1dCB3YW50ZWQgdG8gYXQgbGVhc3QgaGF2ZSBzb21ldGhp
bmcgY29tZSBvZg0KPiB0aGUgbGFzdCBmZXcgZGF5cyBJIHNwZW50IGltcGxtZW50aW5nIE9EIG9u
IFNNVTEzIGZvciBub3RoaW5nIQ0KPiANCj4gfk1hdHQNCg==
