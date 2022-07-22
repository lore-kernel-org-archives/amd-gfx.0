Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AA7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 03:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9E711B9FD;
	Fri, 22 Jul 2022 03:32:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E27011B9FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 03:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEbfcxePQL7LXKYcoJGc3zfLalFuj0el9MJRISNLJ/breeekk0StQOsfS38xuSH7nkix9w/352Ij9rZAlZRnUQOI0Cv+5N7d5JxeMv5vMJUOezNz4s0uAeBLvIp/SPHXG8/17YQzaHTFZXoKlbpwoIgofisQQ+4GXQ8409AFFQdp9vUeCQ4qnbRWJCqiAgxZ4vCdZaSdCjF71VJJazPtEwEUlHRKM21M7r0Wy1js8lqFu3WIsjXz5eNYa44aChPAa4BVBS+59WspS/z0zea32bCIxls+6A2WCof0OxP+lTLaWpBfEBEKUAVbiUik2mpJIS9cNi3co9SfpN0LHYK+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtR98XW5nqryFKR/pZB56Kmd+q6qa3BPEjBcf1HI1KI=;
 b=W9OC3C3B5jG6Z/1GfVJ2SNAw9cMy8LtobXNMnuIvQNTMsPwrPHnqDzWJbnA/dtWoneDbuRStcRC12Rz2EUGM8Hb+7geHP/dfiXSgOcicu7Gdb+A3otADmpoxaABsAdRPWCxqNJD/JL8rEJsTvYz11Lhh53IyXejPIzFJSWL5jkOU9Y8QZf3zbXNmhixFs37oDYXIlBCyfV7/Q8gQi40tZ0vO1ZjweiZvDzx0O4M5cA2wtjt7zEvP1mL+kdNNwUOuT7vicgtu2dWtzE+6YIFs8upI5n8cssGSi84WVrRjx1T4EZmwZOiDlGwOrFWyCTFZkdVNkiwJpwWPALJTNumu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtR98XW5nqryFKR/pZB56Kmd+q6qa3BPEjBcf1HI1KI=;
 b=SLmmp8HfRHiyHvU4bDQO6XoycbwUCxpaLWH6MBECnm3JtC87JVT4AY7Hdk5dSKpjvS8wXO/xmy9/rIwap/Hbu4h6Wi6bsAOyLw/XIhcpkRuTI21WSAgjlGLRShhiryW0nd9c3S2CZ8/cOsr+Xx88DJF3f6oAu5HsTHK0sjFRNHA=
Received: from BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 03:32:08 +0000
Received: from BL1PR12MB5061.namprd12.prod.outlook.com
 ([fe80::55a7:9de1:5fb2:d8d9]) by BL1PR12MB5061.namprd12.prod.outlook.com
 ([fe80::55a7:9de1:5fb2:d8d9%7]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 03:32:08 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/6] drm/amdgpu: add CHIP_IP_DISCOVERY support for
 virtualization
Thread-Topic: [PATCH 1/6] drm/amdgpu: add CHIP_IP_DISCOVERY support for
 virtualization
Thread-Index: AQHYnOeRrqFhN7NUsEaA2OwQhA6nEq2I5OEAgADUp5A=
Date: Fri, 22 Jul 2022 03:32:07 +0000
Message-ID: <BL1PR12MB5061D3195F5AF7BCBF12DA7BE1909@BL1PR12MB5061.namprd12.prod.outlook.com>
References: <20220721095210.37519-1-horace.chen@amd.com>
 <CADnq5_PoE3m2qic2tqRn8pwgXBFS24u=5gRPpg90qHocqbietQ@mail.gmail.com>
In-Reply-To: <CADnq5_PoE3m2qic2tqRn8pwgXBFS24u=5gRPpg90qHocqbietQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e8ed5a4b-b10b-4f84-b7ce-54b33e33c463;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-22T03:18:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa76eca0-2212-4361-d853-08da6b92c14e
x-ms-traffictypediagnostic: MN0PR12MB5881:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LbOGV743czT02/8HRJzTlSXGTpUc+O7a3nG4TdfdUpKKu/ap5kh6DEWmh5AQhTg+G2uZ4NiCGBsFMWehbb/h/VgW423jCGu5TToYW3BtE7oN3GkpHqtwRyvUPbWkS6ZwD0oi516GQikjuG3JrtsS9oG3TkAwSgWN7pYh3E81n9+QECMOH8wrtSSdE5OjQjnyWprF+nydd8IEQ5Rtt0zImVlISQS/BqXJ0NXBC2/cgmLXGONjLYOLwavA68T2zz70oFOkD5k5DG5Y75Kz4ovtJv4UnEgfBhtpFDMn+NpTM2QoeA1dREr66CAWRcFoMZu1964HR5/SyfWHWrtclJysA0EB+QYTXjlAEdI21jERPZN90Atn+ZTJ+x/+nY7jMuawfvQUsHbinMTn6h5yllqVe+aDJGbPLRVxelz3D5nbJ2VvO+zkWW8nxL2yHlKmmKgfDkYR3NzIskAZoX//tnpjkPthT8C7418+Vs4x5kLaTx3M698J6G8Ta2QfoNpDl1Dl+yeCOzYGHywYoF03AGS+zrm8NmwvX/X/NNR/XBfmcme881Ipc9gx3REaLJSrdCYdnb6lr8ajx+5fWsoICNALtMjXYndKIdFSUEhSYNDAHDoqLZTCHm/kAMHu9xN1x90D9sU3zZNiXD9STyfdTRSCVnRSW5WZCjvewMN8h5dTwmtWEJsSBPpKr2q5LkPyf3/oyqLuMN+yi9Kv/iIZzBeojLKzRR+9dW8UpGbEiJSAdnQYktKsQNzlf25fDFMH871NmDfsp+9l/QPaU9V17RPwjiT43axwI/QxoJuuHEpdZK9sYU/Dk6LDl1uuz9kljTPe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5061.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(41300700001)(316002)(71200400001)(55016003)(6916009)(54906003)(64756008)(478600001)(76116006)(2906002)(66556008)(66446008)(66476007)(66946007)(8676002)(4326008)(52536014)(122000001)(7696005)(5660300002)(53546011)(38070700005)(8936002)(33656002)(86362001)(38100700002)(6506007)(186003)(9686003)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzdPMHFpaU0yN3F1QjU0OGhZb053U0RxcTZyZk54a1JKdHcxYndHWS9NTi95?=
 =?utf-8?B?UWhUWWFzdkNlR2JONWtLTWx4UkZZSUtBcVppQzlpNTVCbFZwOVg1aC8yc1E1?=
 =?utf-8?B?Z2hzMFNkMWVqVmlBbzhQMmtDamovQ3pGa0NMZmtGTmdSTy9EVW14VWZtYURa?=
 =?utf-8?B?Tk9kQ1I5MzhjVzAyV3BLL0FTR0p1TWZMM0lHN2pRMWdtLzZxSHhFQ29Xc0Nw?=
 =?utf-8?B?eFkvQ0dVVlhqamE0MTZhOHZYMU01dzEySGVUdnRTakZhZFQ2NlQ1T2wyK0Zy?=
 =?utf-8?B?Ti82NFgwM1ZOVDlrNlBSLzQwWjdkU2tUWTgwR3hMZDJHc1NQV3k3NFNjMjN1?=
 =?utf-8?B?VWdoay9JOUhrZm5rNG41UkZDa1VoMGppRVNwZ3dvTURBd0VDOHc5ZTNaUTdJ?=
 =?utf-8?B?MGNXL2ZvelgwK0NhdzlVTmRtT3UvcVlzUlhPdm04Y1dDeDBWd21vMW1sbVh1?=
 =?utf-8?B?elRYdnVmYWM3cURKMENtbGI4UHhWdU1SV0tIcnFuelVaTjZza2pRWVJSMklh?=
 =?utf-8?B?QkFpVklGWDV3R1BzKzVUNWNmdUljc3BjUmpFVXNDL3V1TzNCZDZybGxQVDE5?=
 =?utf-8?B?cktiV3R0R21lSGk3SWpqVit1V1E0NjMrWnlrdnlKZllLVzBWYkdOY2RDMG8v?=
 =?utf-8?B?NTYxWU1ad3o0ZVhsajBockVJQ1hXdEE0Y0FhNTBTZHQ5VVpNeTNSaHc2S0Q0?=
 =?utf-8?B?cG5DN2F3SEI0b1ozd1BIMlFHVWNpWkJCTWRxVVFPcEhCVVRScUpvdC9EYXlN?=
 =?utf-8?B?WEVrUWpqVUdMTmtSeXpWajdTUEpqekJwMVNFWG1pejBpNmxpOHhxaERZcWJj?=
 =?utf-8?B?ZG8rdC9KaUZoV2pFdCtrcXd5eHErUmxiNi9UeGFLTVZVM0dFZTAzanB0OVhn?=
 =?utf-8?B?UWRpZTM2VzZZUmlHMGZLM3BpdmF1ZlBkOFZ0RGhiZ202L2ZsYkxkQTlsRkdk?=
 =?utf-8?B?RFUzcHRjMkdQYmJ1SndkNlZRaHdFMGZGTXcvdVREZTcwZm5lREpjVmc0aFpG?=
 =?utf-8?B?akhBTTl3TG8wL0VlQ1NjeERNRitOTVptak9JWWtZRDZiNGZ2aURSdnkwblBm?=
 =?utf-8?B?WDdqS3RNWk16MG43OWxzTTkvNWR2UkM3OGdLVHRrVWVTVFZhbm9oZUlHUXFk?=
 =?utf-8?B?bk1RWklDZ3JLMFExSDcyMFNXdGYvbHplM1d5VlEzVTVtQnI0U2kwYUdaVkhn?=
 =?utf-8?B?N3NkUW1veVNTN1JvcGJiMjFUcHk2VTNWRi9FUHNzS3ZvbDdkdXFGTitKTTZL?=
 =?utf-8?B?WUlFczdGdnNsNEh0SFZVdXdEY2tsQmRiZFFpVWo0cXp4UCt0WktlalBMckF6?=
 =?utf-8?B?eWJ3OEZsRWpRV0xnNEpHSjgybHQ1RDI4dWt2emlyb2Z2UlV6Q0NGQmhFQzIy?=
 =?utf-8?B?OTJiL3h6Qm0xR2JSN2ViYXU0a3pyWmV4RXdTMGJsUkJVTDR3MElZNUZ4Uk9j?=
 =?utf-8?B?eEZjQWRpVzMxS2w5eTRVMG16OEdVb3U3N3ZOc3VJd3BVWXVLY2l0V0k0YXZj?=
 =?utf-8?B?SVNuYkQwSEVVR2lPRytUVDBFY3h2dEc3VzRBa24zNmVlLzVJMGRRRlZvSEll?=
 =?utf-8?B?Z3p4dStoaXV3VHM2QmV6NmtjRW1qSGJhelVVWDdlODlvTnZkQlZNWlIvZVpm?=
 =?utf-8?B?SHBCZ2xDRGpNYmovRUI0cGJ5T2NmNm41NWlJYmdxMmh6WnBLZUNLWmJ3alMr?=
 =?utf-8?B?aHlhZTdkczBtS1hBaytMQmZuOHFldWN4K2g4a2xiSDZYcVVHb0RXVHRDRGdn?=
 =?utf-8?B?YzJZMGR3K2IwMlZzYjJTQUs4NTlGMGRocXYxTDM1Rmp1LzhDVWZaamZNemVr?=
 =?utf-8?B?Q0tkRHA2UlgzMkVmUFMxeTBnbWxUV3RHOHk1KzRGeHM1QU9YemRKSm1nZ3U5?=
 =?utf-8?B?V1czMVZDamtDUmI2ZGxVamFTenlzWEFOWXhSM3ozcjNyZUdKL2ZsOVdYTWxI?=
 =?utf-8?B?UUk3SGtsVUtsSGFENGRWdTlvTWd2ejJ4UUc1aFB6VXZ1dStPMkpWTkNKWXo1?=
 =?utf-8?B?NzV0ZDZQckVIaGo2VkxCVVdIMHJlcFZUQ0VTYTdEV0dmUTM3VmU0YlZMekpY?=
 =?utf-8?B?WFN1ZTZhaFRoMFRuNmRwN1orc3d1UUZtUitxRDdtRVN5a2ZhVU9jSXJRNVlS?=
 =?utf-8?Q?usQw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5061.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa76eca0-2212-4361-d853-08da6b92c14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 03:32:07.8444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1hufl1cDWKaQQhVbd6XrcQ/1uz8FiaXG6U0BQA/YvOqEAoXGVFDufmYYKnfxwJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Tuikov, 
 Luben" <Luben.Tuikov@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgsDQoNCkJ5IGN1cnJl
bnQgZGVzaWduLCB3ZSB3aWxsIGtlZXAgdGhpcyByZWdpc3RlciBzYW1lIGZvciBhbGwgbmV3IGFz
aWNzLg0KQWxzbywgdGhlIGFtZGdwdV9kZXRlY3RfdmlydHVhbGl6YXRpb24gd2lsbCBiZSBjYWxs
ZWQgYmVmb3JlIHdlIHJlYWQgdGhlIElQIGRpc2NvdmVyeSB0YWJsZSAodmlydHVhbGl6YXRpb24g
bmVlZHMgdG8gc2VuZCBhIG1lc3NhZ2UgdG8gaG9zdCBtYWNoaW5lIHRvIHJlcXVlc3QgZm9yIHRo
ZSBJUCBkaXNjb3ZlcnkgdGFibGUgcHJlcGFyYXRpb24pLiBTbyB3ZSBjYW4ndCB1c2UgYW55IElQ
IHZlcnNpb24gdG8gZGVjaWRlIHRoZSByZWdpc3Rlci4NCg0KUmVnYXJkcywNCkhvcmFjZS4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNo
ZXJAZ21haWwuY29tPg0KU2VudDogVGh1cnNkYXksIEp1bHkgMjEsIDIwMjIgMTA6MzcgUE0NClRv
OiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1k
LmNvbT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgWHUsIEZlaWZlaSA8RmVpZmVp
Llh1QGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47
IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJl
bi5UdWlrb3ZAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNv
bT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIIDEvNl0gZHJtL2FtZGdwdTogYWRkIENISVBfSVBfRElTQ09WRVJZIHN1cHBvcnQgZm9y
IHZpcnR1YWxpemF0aW9uDQoNCk9uIFRodSwgSnVsIDIxLCAyMDIyIGF0IDU6NTIgQU0gSG9yYWNl
IENoZW4gPGhvcmFjZS5jaGVuQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBGb3IgZnVydGhlciBjaGlw
cyB3ZSB3aWxsIHVzZSBDSElQX0lQX0RJU0NPVkVSWSwgc28gYWRkIHRoaXMgc3VwcG9ydA0KPiBm
b3IgdmlydHVhbGl6YXRpb24NCg0KQWxsIGN1cnJlbnQgYW5kIGZ1dHVyZSBjaGlwcyB3aWxsIHVz
ZSBDSElQX0lQX0RJU0NPVkVSWS4gIElmIHdlIHBsYW4gdG8ga2VlcCB0aGUgcmVnaXN0ZXIgdGhl
IHNhbWUgZm9yIGFsbCBuZXcgYWljcywgdGhpcyBzaG91bGQgYmUgZmluZS4NCklmIHdlIG1pZ2h0
IG5lZWQgdG8gaGF2ZSBpdCBwZXIgYXNpYyBJIHRoaW5rIHlvdSBtaWdodCB3YW50IHNvbWV0aGlu
ZyBtb3JlIGxpa2UgdGhpczoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92aXJ0LmMNCmIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zp
cnQuYw0KaW5kZXggOWJlNTczODkzMDFiLi4wYmRkNzFmOWE4ZmIgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQpAQCAtNzA5LDYgKzcwOSwxNiBAQCB2b2lkIGFt
ZGdwdV9kZXRlY3RfdmlydHVhbGl6YXRpb24oc3RydWN0DQphbWRncHVfZGV2aWNlICphZGV2KQ0K
ICAgICAgICBjYXNlIENISVBfQUxERUJBUkFOOg0KICAgICAgICAgICAgICAgIHJlZyA9IFJSRUcz
MihtbVJDQ19JT1ZfRlVOQ19JREVOVElGSUVSKTsNCiAgICAgICAgICAgICAgICBicmVhazsNCisg
ICAgICAgY2FzZSBDSElQX0lQX0RJU0NPVkVSWToNCisgICAgICAgICAgICAgICBzd2l0Y2ggKGFk
ZXYtPmlwX3ZlcnNpb25zW0dDX0hXSVBdWzBdKSB7DQorICAgICAgICAgICAgICAgY2FzZSBJUF9W
RVJTSU9OKDExLCAwLCAwKToNCisgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IFJSRUczMiht
bVJDQ19JT1ZfRlVOQ19JREVOVElGSUVSKTsNCisgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KKyAgICAgICAgICAgICAgIGRlZmF1bHQ6DQorICAgICAgICAgICAgICAgICAgICAgICByZWcg
PSAwOw0KKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQorICAgICAgICAgICAgICAgfQ0K
KyAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICBkZWZhdWx0OiAvKiBvdGhlciBjaGlwIGRv
ZXNuJ3Qgc3VwcG9ydCBTUklPViAqLw0KICAgICAgICAgICAgICAgIHJlZyA9IDA7DQogICAgICAg
ICAgICAgICAgYnJlYWs7DQoNCkFsZXgNCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JhY2UgQ2hl
biA8aG9yYWNlLmNoZW5AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmlydC5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZpcnQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMNCj4g
aW5kZXggN2Q3MDQ0ZTlkZTJmLi5hYjU1NjAyZmY1MzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYw0KPiBAQCAtNzA1LDYgKzcwNSw3IEBAIHZvaWQgYW1k
Z3B1X2RldGVjdF92aXJ0dWFsaXphdGlvbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4g
ICAgICAgICBjYXNlIENISVBfU0lFTk5BX0NJQ0hMSUQ6DQo+ICAgICAgICAgY2FzZSBDSElQX0FS
Q1RVUlVTOg0KPiAgICAgICAgIGNhc2UgQ0hJUF9BTERFQkFSQU46DQo+ICsgICAgICAgY2FzZSBD
SElQX0lQX0RJU0NPVkVSWToNCj4gICAgICAgICAgICAgICAgIHJlZyA9IFJSRUczMihtbVJDQ19J
T1ZfRlVOQ19JREVOVElGSUVSKTsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAg
IGRlZmF1bHQ6IC8qIG90aGVyIGNoaXAgZG9lc24ndCBzdXBwb3J0IFNSSU9WICovIEBAIC03NDgs
Ng0KPiArNzQ5LDcgQEAgdm9pZCBhbWRncHVfZGV0ZWN0X3ZpcnR1YWxpemF0aW9uKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICAgICAgICAgICAgY2FzZSBDSElQX05BVkkxMDoN
Cj4gICAgICAgICAgICAgICAgIGNhc2UgQ0hJUF9OQVZJMTI6DQo+ICAgICAgICAgICAgICAgICBj
YXNlIENISVBfU0lFTk5BX0NJQ0hMSUQ6DQo+ICsgICAgICAgICAgICAgICBjYXNlIENISVBfSVBf
RElTQ09WRVJZOg0KPiAgICAgICAgICAgICAgICAgICAgICAgICBudl9zZXRfdmlydF9vcHMoYWRl
dik7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIHRyeSBzZW5kIEdQVV9JTklUX0RBVEEg
cmVxdWVzdCB0byBob3N0ICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV92aXJ0
X3JlcXVlc3RfaW5pdF9kYXRhKGFkZXYpOw0KPiAtLQ0KPiAyLjI1LjENCj4NCg==
