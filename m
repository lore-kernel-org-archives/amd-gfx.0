Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A2CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 09:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3184710E60B;
	Mon, 28 Mar 2022 09:49:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B068B10E605
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 09:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyeMcjTdhqpoBSLwweUfK/F+PpBA17cPqaemCktZhQNwpLIT9EA/LBrdYxMRK6iCprn4fIR9NT+VdC9Bp4U23UOmpSESixeYKMsqkxebsSqZGCqvOvWV+13q7OVo1GO0msbLZRugDYk7RcX/ZMwEP3s+bF/E/M3U5J5ANNTG9B/aV0h8SfcqtEFce/cIolxZ/zq2BcjXxRfKOV1n0TRX/Uu2Yv8Kr9Y153gbZvdJp+7alEZ9UgpcdDZvaGUknzLQa68ckLNY8jbzPBs5w1zNoca+37S6RzXQYZ+rMxxkZ+t4J+sUIbOYmwk4r7vQhoa/Gcuf9hkiCZFOGeqvD3gWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/5IYh6COgyVy/zm9VjQ0M7t41K919GQ/mbJ0r/VxuQ=;
 b=bhtf656ZL37UMEXFu9oJ16ZwkBkSXbOFIycd1lrbJ5H/patdbFc7os0CS52Y13Oow8bDhRsAJ/LX8uHOJRDZDpYuPhTThTxju2n87FLoQ0QCdLR6KJDI5jdLys0tLPpaIK9j9Ghu5lN91Gs7/ManwsYtYyRBWFwK3A7iFqeoXe+H3kfRjthEVQD2xrua3cnIcJ/ES49UDqAj1Pa5ekKTP2r4n9YvtpjhTn5rouPYBhaE1C2MIlE11QOki2kB2EdD3D249aemMD91Xky4C9nK/TWZS8324y8qclyJnS/QZDnlphzQ5Bgf1dZCz/GmTXkRvbKFEy8tyQWYJPwo4eEKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/5IYh6COgyVy/zm9VjQ0M7t41K919GQ/mbJ0r/VxuQ=;
 b=rLKeTE9P8WRLXogjw/Mnozk4GJIS2Ck0oTpOOiZ7E0hQ8gzIA/PjbtH3oOARBAbxLWFwElYG3qd94NvdZG9zQ2E7LekqIpRJntpdMlGy6HDecPGS6ny2mD36/+p9ex11MMoBavv2rZnIpwkizjWZ+8D6YZFINCr8jUiSwGB8fAk=
Received: from PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 by CY4PR12MB1160.namprd12.prod.outlook.com (2603:10b6:903:38::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 09:49:49 +0000
Received: from PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::9cf6:6683:b92b:ae42]) by PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::9cf6:6683:b92b:ae42%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:49:49 +0000
From: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Thread-Topic: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Thread-Index: AQHYQmyab1uU8owgCUWioXdX2ewBnKzUaiWAgAACcgCAAACmUIAABACAgAAJzqCAAA8KAIAAAlwQ
Date: Mon, 28 Mar 2022 09:49:48 +0000
Message-ID: <PH0PR12MB54514F94A327C6A5E12BEE67981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
 <DM5PR12MB17706851354758760795883DB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
 <3c80e4e5-97fc-9222-d9a3-f676125b0f5c@molgen.mpg.de>
 <PH0PR12MB545100117A4F02A2C98BCE0E981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <92b220d2-1d1b-c673-f9f9-3636dc1ba804@molgen.mpg.de>
 <PH0PR12MB54519484FA4DFFBF63B0AE3C981D9@PH0PR12MB5451.namprd12.prod.outlook.com>
 <0fe2edfd-b9ba-fa08-17fb-ebbf678b1b51@molgen.mpg.de>
In-Reply-To: <0fe2edfd-b9ba-fa08-17fb-ebbf678b1b51@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T09:49:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6137b354-ba19-4a1c-91bb-c253f24ad36d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-28T09:49:45Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: bec6f1ca-685d-4306-9fdb-a48442c91dd3
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f344941-9a2b-499f-2910-08da10a04c84
x-ms-traffictypediagnostic: CY4PR12MB1160:EE_
x-microsoft-antispam-prvs: <CY4PR12MB116060A7917C098F12BD3BD9981D9@CY4PR12MB1160.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmsdQpDwRugbntdWye7vEqvCgXx2Bhv28Qc5f383BS5kX3crbvguDq535Y4STbqI/xZhQUu7O1Dag90ZjeLavLuL/we1Sxh8VwtjkdLK5ppu8gf8VOpoGMY85aYxSZDK5vuaTIMABQfKOKvTc3e6vAizjK5yQIdxMNzgIWarGlFuY3Pxn275F4Wf+vUVfxTZfD0+iR1Lw3N2QlrOxyI6a8U9KDWYhpUlGDh6VXWY45G5HI6NobW47RuAwZJNoRE4ySb5KiliuKAIOAPpDfwJ0r4cl4MWONrkFO1J6GP9xV08jfYKH6DojYMb3+QApENpVQII/LkLPmQ+8Zavbdkc8LanGXPyObi6gL9eA23hOqtFgekq/CAaxBJSfI4CYfAuiO7dQY7yebHwhLhfRqiaersAQnQ1XGGxN8tURImkYmriuuxILiZtJiIgyWTD+PMCmPlr3iTUD5iDA/AJCBsMXauOWnsqKrf2gZH67kLbVQra4dcjxT+0mEuHqxJDo9YASa/mvXAq+RajUFrmM6G+GqDvmDi4KjSbiNsYilUk1aXrjp3n92tn5NYFyjjXpXlne9TsrHbUJ47xGWE56YlaWWQCHYm8GFHs/oPiyrpwBD5pS8h+k0W0uqCm2kTfsNIOj1l0iilAxO4+UWVF0gn7YY4tjm07WlSAEXlGU2grhagdnkyeOxbY79d8IKtlop8mT7sHDNw7wYXymFaulWDdwg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5451.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(8936002)(2906002)(26005)(55016003)(186003)(52536014)(6506007)(7696005)(55236004)(9686003)(83380400001)(33656002)(86362001)(66476007)(66946007)(122000001)(5660300002)(4326008)(54906003)(66556008)(76116006)(110136005)(6636002)(38070700005)(38100700002)(316002)(8676002)(71200400001)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cldGdVNHb2JWanFBVHp3RWMvZTN3Q3FLd3dvMVVQN3RsQjRMcno2SEdnRnhJ?=
 =?utf-8?B?cUJEYTREWGhIUXdaeUhmd0FWTzIyQzN3YXBCSVZQeEQwZ2pJamhLUVgwVmVI?=
 =?utf-8?B?THBXdjEvQllFK2ZmZS9UZGE3WmtkODdpdUR3TmJIS3R0UjBxWEJpUmszc1RC?=
 =?utf-8?B?MDhzcEhkZXdpMU5xN2FuRURlV04xREhWam5UOGhyai9RTnFneUpKaExlaWZT?=
 =?utf-8?B?cGowb3ZEN2VuRERLVlFMWGN0SngzS2pTd1diNCtkRTE3dXEwNDhSWUFXNW5X?=
 =?utf-8?B?aDR1aFI5ZWF4eHNGNkc5TlY2L2VpZWRmOTdTRVpqSXB3UGp6cUdhNmx6R2th?=
 =?utf-8?B?VUdlRkdxRUM4dFpjU2NIOEhSMDlhTmptWjhyNkVWanU4aXArTHJKbCtZcW9p?=
 =?utf-8?B?dVVIRlRDSXo4NFQvMVFxaDBOM0c0d2hJOXB5eVVSZFF2WE9zRjdoS0s3MHVQ?=
 =?utf-8?B?MzVPd1JZV0FBdUgvcy9sMWg3T2I2eXRXRE5aQTVVQ1pCVVorUW0rS0tFY0Vk?=
 =?utf-8?B?YnFLaGFBdmJ0YXlUUWlUVmpaaVdaTjBlR2tjS2VjZ3VKTDQ0V2ZvL0VzOFk0?=
 =?utf-8?B?OG1nQ3FQYzR2YVVMSWY1UGV0M3VidjgwOFEwaWtzN0dFYmJHT2NZWmtMaVNN?=
 =?utf-8?B?SVNyUnZGTXYxWEt2ZHhyc3V3U1BBMTZFK0NGQmNnaDNxSGVQYkFwVEtzRmdK?=
 =?utf-8?B?cU5DTnN4dmFyMlVYTlBUUDA4ZnUyVWsrLzYxNW1HZGZlS1p6K2lscEVidm1p?=
 =?utf-8?B?cFhZS2J4MFh1WDR0dXRhSWhVN3dzTkFOQ0pHQkRVQ1VuMTlqd0tXcUYwYWZQ?=
 =?utf-8?B?RWM5ZWFTcnFHMUp6dmptcGxLRy9ydWhMTXAyaXl1SnNBdEllaXZJcy8xZFM0?=
 =?utf-8?B?QkZQN01FaGdmSnVuaGkyK0QrS2lCems4bFFLeFZ6SXhCcVN1VXA3NHZ3ZTZJ?=
 =?utf-8?B?S3FQRy9GNkErRVNCUExyd0U4Y01adXdmT3F6by9tSEZyTHZSWkc5MEdzRTVl?=
 =?utf-8?B?aDl1K0N3aVNmMm9CME5McWcwZ3hNdEJCamhwS0k3RDNiVnBPMGQwdDl0NFhv?=
 =?utf-8?B?emNtUDR2T1ZQWnRvRGpZdDI2QlBXRGxpMkVpSHdFV3U0dmIvQkJlRWJ3Nk05?=
 =?utf-8?B?MkJMRk9vNEFwSStmdmRxM1BsWHU0OVR1ODNPK2NqY1B0T3lORlpLOW4wbHlF?=
 =?utf-8?B?RFh0TE1DRjUzak9aakp0QlB0ZHRDOFh6VnlkYmVnSTRlb3JZMU1oMmpldjk3?=
 =?utf-8?B?QU5OS3lDRkFndGJoWVpSRkNqVTVoc3ZVT00zNVQweU1aUDdDQWFtYU0zdGpo?=
 =?utf-8?B?ajVQdjd3NUx0M3hhUUJEQVUvK3YyclBsUjVHeXkrMEZ0R2lCZHFkV3daZ1BL?=
 =?utf-8?B?S1Bxdzcwak5XRHpBbFV3TCtvczJOQy9tOWsxNExvcVlpdnprQWNoVnNlampk?=
 =?utf-8?B?ZDJqUkxsV0JNSEV6bjRQMXB1WEY2L090dnhrNUVNN2NSWE1nYXpmM25Ldllo?=
 =?utf-8?B?QU1rVkEyMWJJYnVBcWV4ZXFIOWd6Y2JuWk9OTFowR2dZc1cwYWJCRVlMTitC?=
 =?utf-8?B?d2xsckM0QktKMkc3K0RWYjd1TGJocWRwcDFIZWduM05FNTJTaFpiaGhGYnNt?=
 =?utf-8?B?RmYvUDVtQ2Z2bEZHMEhJanZyTCs1ZnpLMWNkdnQrUkZPbWIzZDRBZlhSd2VO?=
 =?utf-8?B?VDUxSGp0RUNiTU40TGkxQlNEVEw5eDdLU3l6Mkt2VGYrTlNvYXRLY2xJS2hJ?=
 =?utf-8?B?VkNvY0RIb0cyd1JTWURjaDAxR1ZISVhhR0s0ZUJEMlEwYmdrdWhYYlNlN2pZ?=
 =?utf-8?B?YnlPc1VxSUI4eEZVRDZCL0c3OHRCdmxFMjh5V2RDZkw5Tk03MDhSZlJRTjk1?=
 =?utf-8?B?dmZLN1dRVDFpQjNReFNIUlNXODcrdFV5SG9sYy9STHk1YzdyUjFYSEJ3Wk1a?=
 =?utf-8?B?UEtzMlpLRERGbGhTbFN5VjRGYWtFUDZFZkhBWUJhUmk3Z2tBYlhqdFd1S3ps?=
 =?utf-8?B?UWRjaUN6aFJUL2dWdE9ZZXNPR1ZuTVZYTnNQYnE5Tloxd01OUHBBejgydkJO?=
 =?utf-8?B?N3BmNFVsWWZjVGtOckFXeTRRWUtIRE1xeFIxSlVoUHlxZEtOZ1dJY2tKMTE5?=
 =?utf-8?B?a1k2eHM3Y2lta2NsUEZ2VCt4NG5Gd2ZrRkRiTDk4SFlvdExVKytUODAxRkhU?=
 =?utf-8?B?T1BoWnpUUzRhQzVFVUlxTmJmQlhlQ2RoeWhTV1VlL0ZpK0p1R3E3b1BGZHZI?=
 =?utf-8?B?dmI4SDJXdnJNaWtoUGU4bEZSRzNPdWs4NmcyQ0cvazZZUmcvMlRwaHNRWlpj?=
 =?utf-8?Q?coz0leGCJqg2BNjXjV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5451.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f344941-9a2b-499f-2910-08da10a04c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 09:49:48.9950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tensB02LP7nQKE1dKQtvv0C74IUMf9oGq6tNvrSYEYAbK5pagGqDrUf5gWtAUY0+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1160
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KRGVhciBQYXVsLA0KDQpDb21tZW50IGlubGluZS4N
Cg0KUmVnYXJkcywNClphZmFyDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206
IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+U2VudDogTW9uZGF5LCBNYXJj
aCAyOCwgMjAyMiAzOjA4IFBNDQo+VG86IFppeWEsIE1vaGFtbWFkIHphZmFyIDxNb2hhbW1hZHph
ZmFyLlppeWFAYW1kLmNvbT47IFpob3UxLCBUYW8NCj48VGFvLlpob3UxQGFtZC5jb20+DQo+Q2M6
IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgWmhhbmcsDQo+SGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjQgNS82XSBkcm0vYW1kZ3B1L3ZjbjogVkNOIHJhcyBlcnJvciBxdWVy
eSBzdXBwb3J0DQo+DQo+DQo+RGVhciBNb2hhbW1hZCwNCj4NCj4NCj5BbSAyOC4wMy4yMiB1bSAx
MDo0NyBzY2hyaWViIFppeWEsIE1vaGFtbWFkIHphZmFyOg0KPg0KPlvigKZdDQo+DQo+Pj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBt
b2xnZW4ubXBnLmRlPg0KPj4+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjgsIDIwMjIgMTozOSBQTQ0K
Pg0KPj4+IEFtIDI4LjAzLjIyIHVtIDEwOjAwIHNjaHJpZWIgWml5YSwgTW9oYW1tYWQgemFmYXI6
DQo+Pj4NCj4+PiBb4oCmXQ0KPj4+DQo+Pj4+PiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBt
b2xnZW4ubXBnLmRlPg0KPj4+Pj4gU2VudDogTW9uZGF5LCBNYXJjaCAyOCwgMjAyMiAxOjIyIFBN
DQo+DQo+Pj4+PiBBbSAyOC4wMy4yMiB1bSAwOTo0MyBzY2hyaWViIFpob3UxLCBUYW86DQo+Pj4+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+PiBGcm9tOiBaaXlhLCBNb2hhbW1h
ZCB6YWZhciA8TW9oYW1tYWR6YWZhci5aaXlhQGFtZC5jb20+DQo+Pj4+Pj4gU2VudDogTW9uZGF5
LCBNYXJjaCAyOCwgMjAyMiAyOjI1IFBNDQo+Pj4NCj4+PiBb4oCmXQ0KPj4+DQo+Pj4+Pj4gK3N0
YXRpYyB1aW50MzJfdCB2Y25fdjJfNl9xdWVyeV9wb2lzb25fYnlfaW5zdGFuY2Uoc3RydWN0DQo+
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4+Pj4+PiArCQkJdWludDMyX3QgaW5zdGFuY2UsIHVpbnQz
Ml90IHN1Yl9ibG9jaykgew0KPj4+Pj4+ICsJdWludDMyX3QgcG9pc29uX3N0YXQgPSAwLCByZWdf
dmFsdWUgPSAwOw0KPj4+Pj4+ICsNCj4+Pj4+PiArCXN3aXRjaCAoc3ViX2Jsb2NrKSB7DQo+Pj4+
Pj4gKwljYXNlIEFNREdQVV9WQ05fVjJfNl9WQ1BVX1ZDT0RFQzoNCj4+Pj4+PiArCQlyZWdfdmFs
dWUgPSBSUkVHMzJfU09DMTUoVkNOLCBpbnN0YW5jZSwNCj5tbVVWRF9SQVNfVkNQVV9WQ09ERUNf
U1RBVFVTKTsNCj4+Pj4+PiArCQlwb2lzb25fc3RhdCA9IFJFR19HRVRfRklFTEQocmVnX3ZhbHVl
LA0KPlVWRF9SQVNfVkNQVV9WQ09ERUNfU1RBVFVTLCBQT0lTT05FRF9QRik7DQo+Pj4+Pj4gKwkJ
YnJlYWs7DQo+Pj4+Pj4gKwlkZWZhdWx0Og0KPj4+Pj4+ICsJCWJyZWFrOw0KPj4+Pj4+ICsJfTsN
Cj4+Pj4+PiArDQo+Pj4+Pj4gKwlpZiAocG9pc29uX3N0YXQpDQo+Pj4+Pj4gKwkJZGV2X2luZm8o
YWRldi0+ZGV2LCAiUG9pc29uIGRldGVjdGVkIGluIFZDTiVkLA0KPnN1Yl9ibG9jayVkXG4iLA0K
Pj4+Pj4+ICsJCQlpbnN0YW5jZSwgc3ViX2Jsb2NrKTsNCj4+Pj4+DQo+Pj4+PiBXaGF0IHNob3Vs
ZCBhIHVzZXIgZG8gd2l0aCB0aGF0IGluZm9ybWF0aW9uPyBGYXVsdHkgaGFyZHdhcmUsIOKApj8N
Cj4+Pj4NCj4+Pj4gW01vaGFtbWFkXTogVGhpcyBtZXNzYWdlIHdpbGwgaGVscCB0byBpZGVudGlm
eSB0aGUgZmF1bHR5IGhhcmR3YXJlLA0KPj4+PiB0aGUgaGFyZHdhcmUgSUQgd2lsbCBhbHNvIGxv
ZyBhbG9uZyB3aXRoIHBvaXNvbiwgaGVscCB0byBpZGVudGlmeQ0KPj4+PiBhbW9uZyBtdWx0aXBs
ZSBoYXJkd2FyZSBpbnN0YWxsZWQgb24gdGhlIHN5c3RlbS4NCj4+Pg0KPj4+IFRoYW5rIHlvdSBm
b3IgY2xhcmlmeWluZy4gSWYgaXTigJlzIGluZGVlZCBmYXVsdHkgaGFyZHdhcmUsIHNob3VsZCB0
aGUNCj4+PiBsb2cgbGV2ZWwgYmUgaW5jcmVhc2VkIHRvIGJlIGFuIGVycm9yPyBLZWVwIGluIG1p
bmQsIHRoYXQgbm9ybWFsDQo+Pj4gaWdub3JhbnQgdXNlcnMgKGxpa2UgbWUpIGFyZSByZWFkaW5n
IHRoZSBtZXNzYWdlLCBhbmQgaXTigJlkIGJlIGdyZWF0DQo+Pj4gdG8gZ3VpZGUgdGhlbSBhIGxp
dHRsZS4gVGhleSBkbyBub3Qga25vdyB3aGF0IOKAnFBvaXNvbuKAnCBtZWFucyBJIGd1ZXNzLg0K
Pk1heWJlOg0KPj4+DQo+Pj4gQSBoYXJkd2FyZSBjb3JydXB0aW9uIHdhcyBmb3VuZCBpbmRpY2F0
aW5nIHRoZSBkZXZpY2UgbWlnaHQgYmUgZmF1bHR5Lg0KPj4+IChQb2lzb24gZGV0ZWN0ZWQgaW4g
VkNOJWQsIHN1Yl9ibG9jayVkKVxuDQo+Pj4NCj4+PiAoS2VlcCBpbiBtaW5kLCBJIGRvIG5vdCBr
bm93IGFueXRoaW5nIGFib3V0IFJBUy4pDQo+Pg0KPj4gW01vaGFtbWFkXTogSXQgaXMgYW4gZXJy
b3IgY29uZGl0aW9uLCBidXQgdGhpcyBpcyBqdXN0IGFuIGluZm9ybWF0aW9uDQo+PiBtZXNzYWdl
IHdoaWNoIGNvdWxkIGhhdmUgYmVlbiBpZ25vcmVkIGFzIHdlbGwgYmVjYXVzZSBWQ04ganVzdA0K
Pj4gY29uc3VtZWQgdGhlIHBvaXNvbiwgbm90IGNyZWF0ZWQuDQo+DQo+U29ycnksIEkgaGF2ZSBu
ZXZlciBzZWVuIHRoZXNlIG1lc3NhZ2UgaW4gYGRtZXNnYCwgc28gY291bGQgeW91IGdpdmUgYW4N
Cj5leGFtcGxlIGxvZyBwbGVhc2UsIHdoYXQgdGhlIHVzZXIgd291bGQgc2VlPw0KPg0KDQpbTW9o
YW1tYWRdOiBbICAyMzEuMTgxMzE2XSBhbWRncHUgMDAwMDo4YTowMC4wOiBhbWRncHU6IFBvaXNv
biBkZXRlY3RlZCBpbiBWQ04wLCBzdWJfYmxvY2swDQoNClNhbXBsZSBtZXNzYWdlIGZyb20gYW1k
Z3B1ICIgWyAgMjM3LjAxMzAyOV0gYW1kZ3B1IDAwMDA6OGE6MDAuMDogYW1kZ3B1OiBIRENQOiBv
cHRpb25hbCBoZGNwIHRhIHVjb2RlIGlzIG5vdCBhdmFpbGFibGUgIg0KPg0KPktpbmQgcmVnYXJk
cywNCj4NCj5QYXVsDQo=
