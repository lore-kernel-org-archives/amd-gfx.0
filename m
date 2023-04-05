Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD605C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 21:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17AAB10E132;
	Wed,  5 Apr 2023 21:30:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BAF10E132
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 21:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obTuEtKV0nVWj2B+jB/zhSy3vR4zp3/VuWQYZZ/UA3TGoWT/Ml67BQehekjHcaXXEu4adeTD6Yb1/rirbft57chFmgG1mwiGU1/TzOeI8LDokZ0HZMwsCF4nBhPzChM0BrKHYvi9yHSHRmC961dvFwZc1OChRrVKso+7/nRYF6LbPmwefc4+DYpuf69z1wf0WxBEk9AGSdRJvPwZ5bl3qv4wym7qfhm2ZWCukJiQPU2q6J2KSBTQ9NUKH1JYE8PwPBcoUzJ/keBdMOcW/4/Py1Jt8ns+X3xZ0O1wP8Ba91Q/eqI3YYKo/RjOpR/CvMLiwQcjdrk9n5K96hNn2LvumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfBPVsYpgb/O3e/culrlVbhtvZiPHXo+M3S7mTG/rnQ=;
 b=GJmgBDKkOcq7xw+kTho1NYIiZkysqxS/HlrL+omj4O+G+r/CdpFa+fvu3PE+nq0yrptCD5KGjTI6vB0/CrWEihnV7uRkYsMw3S16frdXbzUjLTB5Egi0USBufb8L40lXl9OBVi1fTRZSB3bpiLk8mtTJ6fBjeFnTvn2CU1wHnDKii09MlYFDgoxVCcwQFMwy3mNVJbeBo6FAT6t17QarUlZwN2IVj69U3rTjIZaQXgshbXrWTQSC6JFkOjHqAHvL67tbBhL4EwviOHqhnLx0XYgxteUOYMTP9+DQ8bCXroBj6bmZonmgyyD35N0yLDR0GKNgSZ/4w4SvUjMu0KizHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfBPVsYpgb/O3e/culrlVbhtvZiPHXo+M3S7mTG/rnQ=;
 b=eP40/HJ6/x0ByRonYV4/SyT6dlIwmmjfXSRDrhnAybr5AWp3tmhDlzeYQCaKfY9LqvCb95Nt2D+yN74qn0/kgsrImSO7AJZ0F0NOiyu7XBqSKDau8aeoAjFrmZgKChSgArDHWWM9W0DQl+ao0zjDjWxuXT5G9INPpnkxxWiZ0Gs=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Wed, 5 Apr
 2023 21:29:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Wed, 5 Apr 2023
 21:29:55 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>
Subject: RE: [PATCH v3] drm/amd/amdgpu: Drop the hang limit parameter
Thread-Topic: [PATCH v3] drm/amd/amdgpu: Drop the hang limit parameter
Thread-Index: AQHZZ9LEejHuCJ2ceUWXsrH1wthdMa8dO8gw
Date: Wed, 5 Apr 2023 21:29:54 +0000
Message-ID: <MN0PR12MB6101116F64BF9FFD41490215E2909@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230405152352.457978-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230405152352.457978-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-05T21:29:53Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=88a86ca1-0db6-4b2b-9dba-56df5131326a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-05T21:29:53Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 56baa334-457a-4b92-922f-e51b3a21c102
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8650:EE_
x-ms-office365-filtering-correlation-id: 927a38f7-588e-409a-bbf5-08db361ce603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hq9v8Pz0RByIbJBJSGAZidF/Mx78C49u+Nx4DBpDEqd0vk8s3InclbMxoTfzFbSnaNk/vgY74Z6/P0YlVCEpJicZHFF4sSk9+ueIKtfLR17xdp4r7EgGUJP7SvHZ/RFwEm/mMFYbli0uRKj69zhTR08CMihsX9ml6WAltKz2gPnxx02ray82tMfblXtedFIEfL99u0yFeS9FhASVi5Dt9fb/WBmjjEmu87WR/vICC+fUB85DD78aY0aUIdTcuG9rs0DPott2mY4qVQ3J3Fjm2e1p6du4YJuteeTM++77i+mcclQ/2990qB3sQR2M9A2UcAYRr3CeY0FRLCQyMbeOsZ7c2G2AK74ukrxuOw65U0cpoqqD+vRXnpZZMxnkyZCswy6pDc9AOFXAnQmCBmb9Q4UAn79SKXNAcrw1PUwbml+z/LNyMtXdUwry0Ilyp83oY/aqt8aC32w4OGceUY1hmSpbz5ezsf3ywLQk/ckTCxGPHEjXoD0nwC1nlDhursumXdice98uU5tgSkJWt8WaAIClbs+XEQ7cuTWjAxIYx3U33PLy49d49Ksfa3kRLdk5BmHruM2g0lj7L8EIemW+Zwyvla3ZZ6fG6VP07FBWSiy8BjUbDI+nygX211SkYIlg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(5660300002)(86362001)(83380400001)(66574015)(9686003)(53546011)(122000001)(6506007)(186003)(26005)(38070700005)(38100700002)(66556008)(55016003)(8676002)(6636002)(478600001)(52536014)(71200400001)(66476007)(66446008)(8936002)(64756008)(7696005)(66946007)(33656002)(4326008)(76116006)(110136005)(316002)(41300700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFFMc2d4RmZFS0t2Wjd6bGNtUXBVc0pJUmh5TjZKM0hqZENuQlMyZlk5SG5N?=
 =?utf-8?B?dDhOYlkyRE9EY3FJN2c3YlYvUFNRWEN5eWhHNllEbmlYR2J0N0lXbmlOdE5s?=
 =?utf-8?B?U2pQbGJXakdSVnVqS3NwclVzSDFudkhiRTVFUXVvOGJSV2tjZ2FoeHBoak1i?=
 =?utf-8?B?VjRLaEJuK3h2T3c1dTBaTnNybUZYWkdEK3NnNlV3TEQrRldhbjlZbVBhM2VM?=
 =?utf-8?B?OFNDOFl0azhBNEl1YXZ0VTgxbFFJUndSdlB6WXhJVUtrS3F5TTZZNGYyWnFG?=
 =?utf-8?B?L3NYUE1JUmNiMzQ1dXNzOTFaNTEvcGdOU1NxbFJvZkQ2UXM4bC9yWmxJMkVo?=
 =?utf-8?B?N2x4UjI4STB1V2R6dW80eXliR21KUkRYU0ZDdFFaNTNURUlRU05RZXcySDYr?=
 =?utf-8?B?V0VBZStjTGFTdjBkWVR4OHNGUGY5UE5oenhyaHJkeUxUQmxGbWl6TGJzM0dH?=
 =?utf-8?B?WXl2Ukt5SGljSmR4bnNIR0JLa0RaY2FpN1JEZ1ErdnFqQyszSG43YlBQUFR2?=
 =?utf-8?B?S3dSY3lxalB6eElUTGhRVWxuRzRPVUJocjJnbEE1SjJpTnEyZ1VQK0VVZ2di?=
 =?utf-8?B?c0JUNklTdGlXNkUwenY2NjBuc0FjazJGZ095VnMxa29CNDdEVkFIcU1HRkpH?=
 =?utf-8?B?RVBxcWQ1YlBTVHpIRzFBS3VPVkxPckxoZTZqdStkU2RlTHozSzlzaGN0RHV6?=
 =?utf-8?B?L3BwTUROKzNHbEJxaStVdllqS0pZSkdDR2xWcy9YYmVrRWRZdk1uU01PM1E4?=
 =?utf-8?B?YVVhYkU4UFFjcU9yUGV0U1Nxam0zd0UyZk41N2xaTDBmY0QrQThjQlJyMUpT?=
 =?utf-8?B?K09DNTh2MlJIWkljZ0RvdEpnNEh2MGhkTkRoWGt4U3hSOUtYMjdZOHIzNlJ6?=
 =?utf-8?B?SVdPcGdHVUhSclJ3NFlNR0RUdlBJaktYRDBUdktHZzFtSTI2bGFYVlBXR3RO?=
 =?utf-8?B?eWZ0MUZPc20vcVBGc2ttOG5MZ1pHdjlEK0hoRWhxR0x2TFVBUktGU0hCT01W?=
 =?utf-8?B?LzRTcS95cHdySk9Pd05YdEpDUmY3RUl2b3lKYWRxSDhYNXN0R1NRRi9hZzBu?=
 =?utf-8?B?TmxWWXc4UnltdFZLVFV0aWQyRDArcEhObFNwQjFhZk11VEJFUXpqMGpFM3pT?=
 =?utf-8?B?Tk9ucHZPNmlmNml1Y0dCRjBXbm9HUHBhL2w0V0hzb1VuWWIzWmJtcEZSMjRv?=
 =?utf-8?B?K1VPMG9ZZHZWc0x5QmRycDdEOGZPZDBVZlZtWWgwamE4aVV2eUxlMDZVNUVN?=
 =?utf-8?B?cSs0MEFoOGtvS3REQWYvUFBjempxMHVvTVVpK09Sazh1bTVCNGRoM292STJp?=
 =?utf-8?B?YWRpMkxqR0Y5ZWVhczFUaGcxWUdBeHhFbExETVVBODhVYUV5MzBUaFBHZU5D?=
 =?utf-8?B?QytFNFJMYW83bERsbTRkOUVaYlBva3VMZ3hvbmdGZXFOdG9xeTdlVERqSWZx?=
 =?utf-8?B?V01EV2ZMck5xUm9VT3hNWXRTK2hHQjhEWTBkTm1KZm1Qd2U0WUpXMlQ5OTBu?=
 =?utf-8?B?THIvYTgrbDNjZzhQTVZwR0lYbGVmSUc0YmhhZ3l4SzdiSlQ1Z09RQkxmZ0VF?=
 =?utf-8?B?MUEydzdQelZYR2pnN3lzb2gyRHZXNW5ZdmFkWjBGUDl5bmJrbzFmc3QxOVdB?=
 =?utf-8?B?Z2VGNVRKU0FPWkR4ekRFankzUHRiT2ZSdE1XSmxNTDltU2FJNHl1Q2d0K2ZJ?=
 =?utf-8?B?bUc2TGtIcVJ6RXF4MSt4ZUhDSUdOc1dEcXhRdXVIZXREaW1Uc2ExZno4a1ht?=
 =?utf-8?B?L04wR1pIbHQ4eEtkR3lOY0tWYnptZXZvaUhxN0F1M2FjOThQOU9Nc1RJekh4?=
 =?utf-8?B?a1BuQWo5QzF4WWtSQmtSMFJUYnRjQ3pCUWxqSXRkU1FHOHFTeDhtNStkczIv?=
 =?utf-8?B?QytzYW92VmVWekFBUWQvdjhpTzFaSDNDZm53ZWhNWDR4L3NJNjI5UmZEUG5x?=
 =?utf-8?B?d1U0dmU3VzNtNXZRcjhHcVJnbCtvTU1jVWNjaHh0V241QnlDUFNHeUQ2V3ZQ?=
 =?utf-8?B?RW1TRTRYa09PVkdPYlBtV0tpLzJOZXE1Q2V5NDdwbjN3Uk8zREc1RTUxTjg0?=
 =?utf-8?B?cVVJbXA2ek9JaVVQYU1oSGJPUlJqTUZvZThzQnlMTWkrL2hzTkNsUTVSd1dE?=
 =?utf-8?Q?0itk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927a38f7-588e-409a-bbf5-08db361ce603
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 21:29:54.8714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9B/oXd5GmwYIOM5wdkSO+MjKTapSF9XsgT2tZ/zBP4O+cF4LllJ2HMWSYhZzQrBvnb2jJJ7OBV8VR9eBhq5yNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU0hB
Tk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIEFwcmlsIDUsIDIwMjMgMTA6MjQNCj4gVG86IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxp
bW9uY2llbGxvQGFtZC5jb20+OyBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT4N
Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFT
QU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2
M10gZHJtL2FtZC9hbWRncHU6IERyb3AgdGhlIGhhbmcgbGltaXQgcGFyYW1ldGVyDQo+IA0KPiBU
aGUgZHJpdmVyIGRvZXNuJ3QgcmVzdWJtaXQgam9icyBvbiBoYW5ncyBhbnkgbW9yZSwgaGVuY2Ug
ZHJvcA0KPiB0aGUgaGFuZyBsaW1pdCBwYXJhbWV0ZXIgLSBhbWRncHVfam9iX2hhbmdfbGltaXQs
IHdoZXJldmVyIGl0IGlzIHVzZWQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1v
bmNpZWxsb0BhbWQuY29tPg0KPiBDYzogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hh
bm11Z2FtQGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8u
bGltb25jaWVsbG9AYW1kLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oICAgICAgICB8IDEgLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jICAgIHwgOCAtLS0tLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaA0KPiBpbmRleCBiYmFjNDIzOWNlYjMuLjM1YTA0NzRjY2RiMCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gQEAgLTE4Niw3ICsxODYsNiBAQCBleHRlcm4gY2hh
ciAqYW1kZ3B1X2Rpc2FibGVfY3U7DQo+ICBleHRlcm4gY2hhciAqYW1kZ3B1X3ZpcnR1YWxfZGlz
cGxheTsNCj4gIGV4dGVybiB1aW50IGFtZGdwdV9wcF9mZWF0dXJlX21hc2s7DQo+ICBleHRlcm4g
dWludCBhbWRncHVfZm9yY2VfbG9uZ190cmFpbmluZzsNCj4gLWV4dGVybiBpbnQgYW1kZ3B1X2pv
Yl9oYW5nX2xpbWl0Ow0KPiAgZXh0ZXJuIGludCBhbWRncHVfbGJwdzsNCj4gIGV4dGVybiBpbnQg
YW1kZ3B1X2NvbXB1dGVfbXVsdGlwaXBlOw0KPiAgZXh0ZXJuIGludCBhbWRncHVfZ3B1X3JlY292
ZXJ5Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+
IGluZGV4IDNiNmI4NWQ5ZTBiZS4uMDUxYjllMjMxY2Y0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC0yMzY0LDcgKzIzNjQsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaW5pdF9zY2hlZHVsZXJzKHN0cnVjdA0KPiBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KPiAgCQl9DQo+IA0KPiAgCQlyID0gZHJtX3NjaGVkX2luaXQoJnJpbmct
PnNjaGVkLCAmYW1kZ3B1X3NjaGVkX29wcywNCj4gLQkJCQkgICByaW5nLT5udW1faHdfc3VibWlz
c2lvbiwNCj4gYW1kZ3B1X2pvYl9oYW5nX2xpbWl0LA0KPiArCQkJCSAgIHJpbmctPm51bV9od19z
dWJtaXNzaW9uLCAwLA0KPiAgCQkJCSAgIHRpbWVvdXQsIGFkZXYtPnJlc2V0X2RvbWFpbi0+d3Es
DQo+ICAJCQkJICAgcmluZy0+c2NoZWRfc2NvcmUsIHJpbmctPm5hbWUsDQo+ICAJCQkJICAgYWRl
di0+ZGV2KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBp
bmRleCBlNjUyZmZiMmM2OGUuLjAzZTkyODEyM2Q3MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBAQCAtMTU4LDcgKzE1OCw2IEBAIGNoYXIgKmFtZGdw
dV92aXJ0dWFsX2Rpc3BsYXk7DQo+ICAgKi8NCj4gIHVpbnQgYW1kZ3B1X3BwX2ZlYXR1cmVfbWFz
ayA9IDB4ZmZmN2JmZmY7DQo+ICB1aW50IGFtZGdwdV9mb3JjZV9sb25nX3RyYWluaW5nOw0KPiAt
aW50IGFtZGdwdV9qb2JfaGFuZ19saW1pdDsNCj4gIGludCBhbWRncHVfbGJwdyA9IC0xOw0KPiAg
aW50IGFtZGdwdV9jb21wdXRlX211bHRpcGlwZSA9IC0xOw0KPiAgaW50IGFtZGdwdV9ncHVfcmVj
b3ZlcnkgPSAtMTsgLyogYXV0byAqLw0KPiBAQCAtNTIxLDEzICs1MjAsNiBAQCBNT0RVTEVfUEFS
TV9ERVNDKHZpcnR1YWxfZGlzcGxheSwNCj4gIAkJICJFbmFibGUgdmlydHVhbCBkaXNwbGF5IGZl
YXR1cmUgKHRoZSB2aXJ0dWFsX2Rpc3BsYXkgd2lsbCBiZSBzZXQNCj4gbGlrZSB4eHh4Onh4Onh4
LngseDt4eHh4Onh4Onh4LngseCkiKTsNCj4gIG1vZHVsZV9wYXJhbV9uYW1lZCh2aXJ0dWFsX2Rp
c3BsYXksIGFtZGdwdV92aXJ0dWFsX2Rpc3BsYXksIGNoYXJwLA0KPiAwNDQ0KTsNCj4gDQo+IC0v
KioNCj4gLSAqIERPQzogam9iX2hhbmdfbGltaXQgKGludCkNCj4gLSAqIFNldCBob3cgbXVjaCB0
aW1lIGFsbG93IGEgam9iIGhhbmcgYW5kIG5vdCBkcm9wIGl0LiBUaGUgZGVmYXVsdCBpcyAwLg0K
PiAtICovDQo+IC1NT0RVTEVfUEFSTV9ERVNDKGpvYl9oYW5nX2xpbWl0LCAiaG93IG11Y2ggdGlt
ZSBhbGxvdyBhIGpvYiBoYW5nDQo+IGFuZCBub3QgZHJvcCBpdCAoZGVmYXVsdCAwKSIpOw0KPiAt
bW9kdWxlX3BhcmFtX25hbWVkKGpvYl9oYW5nX2xpbWl0LCBhbWRncHVfam9iX2hhbmdfbGltaXQs
IGludA0KPiAsMDQ0NCk7DQo+IC0NCj4gIC8qKg0KPiAgICogRE9DOiBsYnB3IChpbnQpDQo+ICAg
KiBPdmVycmlkZSBMb2FkIEJhbGFuY2luZyBQZXIgV2F0dCAoTEJQVykgc3VwcG9ydCAoMSA9IGVu
YWJsZSwgMCA9IGRpc2FibGUpLg0KPiBUaGUgZGVmYXVsdCBpcyAtMSAoYXV0bywgZW5hYmxlZCku
DQo+IC0tDQo+IDIuMjUuMQ0K
