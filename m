Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE7FC46CD2
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 03:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F8C10E049;
	Fri, 22 Dec 2023 03:04:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B621310E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 03:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ6tVvaG6vdmqJTTrFycj4DUrtz8MqUs3cuTjR68Zc/wiMlJY9BP7TRDbFocUfG0tnAsUsQRR/bov1CMNJvxlA5QJCcDhJ7WU5xL82C0UqIOmbiuJAqMkXFvCKNLW8Sblyq5pviNFHvMp0wxwG2lx4Li2DIY0qKfYsstkP/pMBUTQF8j1ijEfcqe6nCxn8RqYyNagkNFmuifJOkst+6jT684CLM1CkiQ9POh/rqYWURE7ftu7ECqKpz2D0PUEvfIywYvK3qH930uk0ggVl6hTvGxFx3pRjUmOnpOW9pn4xYX4Z3f3oTxgX5NnxKuDOvQy0ye2sMdAsoXv3I4dzIUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUTc/RE+fvLACv2PHj0Qs21709CXtQ1Tk0FcQQTddxQ=;
 b=ngX+9Qk9WCmho8xtmTRPM9llsxXPmJIiuRQf5MTJX8eUdzXCjZR1KE6vo1ac+qGk7Wfh/dKQQvNVk5gFKO8Ef80cJwvva3BdTUZDirjAQOd7iyIaWUFIBDZHp6vcBb3/jrNmSvXYdyhQguoR8qcX6OCTykGgHOyPd7Ik7/Mbl5tg1Fnrh9ZNjqFdpUSzYm8av0pkrPP3GtzThSQFd60NdZ3UfMmN4GrfxqT1J/chwkZeCn1S3r7leTKQR6gfEQhBMMobaajHwN+6ovSkmBnRiLu8llO70JjCryyWcJczOhv+JkOmD8DuEaOi2QcZqTAH5g767d/aNAHrxaHwyBWOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUTc/RE+fvLACv2PHj0Qs21709CXtQ1Tk0FcQQTddxQ=;
 b=DcsGF/Bd9Cp+gLaXakWqSL3/82oj+oVXM1s5x5nifOOiKuyyUqUe3BOEepwALZN7295x5niO8+879KyqYc27+C679FL6x2ox7NRtmZqgknBjww9G9T3rzpflE18GYjqWHMbf/iP1mAJIXd0wc2WrR/pogzqPdtZ2PwI00Sz5JM8=
Received: from PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 03:04:08 +0000
Received: from PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::eab3:f11d:3aa0:7d04]) by PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::eab3:f11d:3aa0:7d04%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 03:04:06 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
Thread-Topic: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
Thread-Index: AQHaMl0d8cB9ZHuZR0Gsr1tkGLie0LCw1hMAgAEQ3XCAAE/CgIACZy0g
Date: Fri, 22 Dec 2023 03:04:05 +0000
Message-ID: <PH8PR12MB68416BFC24B4947D7FC2096DEF94A@PH8PR12MB6841.namprd12.prod.outlook.com>
References: <20231219092340.1601929-1-Jack.Xiao@amd.com>
 <CADnq5_NAzBZj+SXc7iY5ZWUgxGCmt3A+PsVRRx59YWx4=toXYg@mail.gmail.com>
 <PH8PR12MB68417ECCDF64B44C09248DF3EF96A@PH8PR12MB6841.namprd12.prod.outlook.com>
 <46bf9893-f31e-47cb-84a3-c609d13e3a65@gmail.com>
In-Reply-To: <46bf9893-f31e-47cb-84a3-c609d13e3a65@gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7aa36bfb-9c6a-47c7-95c0-89dba0021a7a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-22T02:48:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6841:EE_|SN7PR12MB8818:EE_
x-ms-office365-filtering-correlation-id: 97553eb3-68a3-4eea-659e-08dc029aa851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtFcdSPRTyqiHfpc3wRqpCIxPKnKBOxbkd3wTdLZyC3hG+VM+RTIAU4r52HjhKrGGoOp6Sc3lJjEXfrkLVG2SdGjIb/adoR1ufHyk5Q0tz3WzdyyckaAXC4zHfN5htPhT24eU69yP0PnabDsbho0Ynm23jFNIrHXVuHtRYC84wPemlCb48JHH/ncKThbZkPMJimeik0WY8YRB6ERZAPh2UCHAJpmJ95hQZajSNiVYIB+yYBsAH+1WVZfQsxKrhE96V3XIscYAsQ9t7LG/aSpMOvN9AFHQ+xGAZICxvvBXVb6jdalAWiadZj4a4ZtekdzGuKBbKLtIsBdeQ5UbskOCTLlzmnUihnJSp4BTJl7vPY3aFfXcbc/87aqdCo7wO3Y5WZTM9TpXrZydUzcFC7Xo8thu2d0lkpVvmsmAzHoYilOjrfkV8OF+Vvy87Zejbqzv8UPPMIvFKnHsYsmxKnMQ12h1kQBiqKa8ynm96KU4fdhhpPp4xtRSbBNQF6nemlUu0wHWW6G2BVL+x7cHVd1tbDLNdaXXctUpqCSz6LBwcknbAQftEDdXG6brRFP6I8D7yUO0tZ0l7CxcEYYpgW1EGXqFmyaDwAvrzcwAMCmotI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66446008)(4326008)(52536014)(122000001)(8676002)(8936002)(66946007)(76116006)(66556008)(66476007)(64756008)(316002)(110136005)(54906003)(33656002)(2906002)(41300700001)(86362001)(38070700009)(38100700002)(5660300002)(26005)(83380400001)(55016003)(478600001)(9686003)(6506007)(53546011)(71200400001)(7696005)(66574015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkFUN25RQlkvMGRlNS9qZTNEZnRDbklBd3ZZNUlEQWlLamg1dDlIOXhoVkVk?=
 =?utf-8?B?Ukh1VW1CS0RmU0czcDV4alRyZThCSDRyWTlJVFM5em9LSFJ1cFBlVnZzamdx?=
 =?utf-8?B?UmM4Z0w3MWU0TmxaYUNXS1BvdWswdFJObzZrTWY1SE1lakduM0tCRWZEUEVh?=
 =?utf-8?B?RVpFUDFqVFFEeFBqR3A3ek5jV0VXRlJiVi9uV2Zkd096bTA5RXBsZ3BqUTc5?=
 =?utf-8?B?YURwOEY5Uk1aWFBmdG5mTzhTQmw0MkY4aEFtN3pqMEFIckNXczBQVFB5dTRt?=
 =?utf-8?B?ejNtTUtGQStnenZEMmFVa2dNVmNZOGZFZWRHeEV3aDVNRXlPZzlPN3BYTStR?=
 =?utf-8?B?TjdaRHc0K3Bna1gwYkVaOENERFVVMzNpdDcwR0ZxVDRCb3RmSjR5OXZva0xJ?=
 =?utf-8?B?NmhzakhzZVpGS1o2blFXM0lrZUxEU1gxdjJGZ3llalpiK09PZitXdmh2b1Ur?=
 =?utf-8?B?VWxEWlJMcVl6TXJnSnNHRm56T2tvK3ZTUzlHaVVIcjNFbFlJeG1mWGlJVmoz?=
 =?utf-8?B?TGJvSVF1eW1vU0ZJbzZETFA0c1haaFF6ME5EVURTbVNnMzBkYWVtd3BkTkFs?=
 =?utf-8?B?TE1pMjU4RkdnRGVPQ1ppUWZMQ3JoQ2pTZjVTY3lSeEM1QnZxQ2JBNDRIM0VB?=
 =?utf-8?B?cHBmYUJhWldnbXJ6Nk1ISFlQditxcjRKK2lhNU1Xb052aE5ieExuSmtFSkRx?=
 =?utf-8?B?UnliOUxCcENEL2FidjhBMWxPWTNrQVBNVTY3U2J1TkthaVJOK01ITmRlcHVr?=
 =?utf-8?B?R3FPTE5iaWs0K3lzbVpETzJoKzA0QVU0Ni9qZW0xUGd6aTBSdlFmT2VtWVJ0?=
 =?utf-8?B?eHJEZ29BQjRocmo2QmFQZkp1Yml5TG50cEM4NDIrd2toam94dHZ6Q2sxNDJE?=
 =?utf-8?B?MzRMY2NMVEV6ditJeDhOdVU4Z2s1VDkxYUVqV29NZjljcHZla0EzNU11MGht?=
 =?utf-8?B?RGRjakRpNnJhNTNsZjhoUWVWZzMzS1JjcXFBUzRFcmxCQWJILzdIdTlCQlBQ?=
 =?utf-8?B?VmJJOU9OWnVLOUNQT0phWm9Ram5YdVFQNmRoWFI2YkdObCtWRUJWR2NVN3RM?=
 =?utf-8?B?b3V5L0RKd09UWVg3cVE3M29zVWY5YnVsN0luYWxYaHN3c05kN2pnQThTTm9M?=
 =?utf-8?B?bU1LQ3ZIZDlyTGkwUFpjdHBiOVRhaDJnUXBVYTFuY205dkVadWFIUmpDek9I?=
 =?utf-8?B?N3FtZ29YVnNnNC9KMzNtbzNWZ1hURTJpWDZvcDZJWW5rMzg1NEp2SG85ODNH?=
 =?utf-8?B?TXRkcEZDYStVdmp4ZjNSZDhrQTR0WHFTREJ4L2hSekR2YlVvbDY4ZXBaWDVY?=
 =?utf-8?B?eUpWV0dPZ0h3MXJYcFUwa21Fb09ucitMVncyQ1Z4L09BMEQyN1c5aDlkL2NI?=
 =?utf-8?B?RWVoZEpYYjc1KzRPZ29JT0gzYVZmYmI5M0t0cWpxQVJtVkFRQlUwd0VMMGs1?=
 =?utf-8?B?VUZIMTBSekpnalVDbDYzYjVuR1pVRnJvdEdXazZ3cm1ndkpuYllVRVk2Zk1P?=
 =?utf-8?B?ZXNRVGk0dHlibklKaXo1c3o3V1h3UWFqUDBCSVZQSnBINm1hUzhkNnFaeUE4?=
 =?utf-8?B?NjFTQjhPVU9TaHFaVG0vSkRhemJPa2ZWSjMzOWRucDRnZVhqYXpkVXlhR3l3?=
 =?utf-8?B?MnFqUWdFTjJGSTdNNjFUdUJvNURNTS9VeDFVUFhPdE1aS0pURUNGcVRHdUZm?=
 =?utf-8?B?ZTZnMWs2T3VZVVZBVjFmOTZoNDUwM05ETU42VFdUT2hxSGswMVFxY1VqdXZu?=
 =?utf-8?B?Zlo5RmRTOGdtZmhOYXl6U1ZNcVI2R29sQjJnMW9LSkoyVFR3aFpINWg3czU2?=
 =?utf-8?B?LzY5ZGFvQ0VRbXZtZEFkUGRiSnRCdEtzaXJ1MThKak5WVmFkRUVNWHY4NUg1?=
 =?utf-8?B?bFZ6UCtET3I4VG04Z2ZyMFVUV0FrQUxPWDB3YWJvNFhvVWNONkprb2xCbnV0?=
 =?utf-8?B?V3pKTVZDZkRHbjQ3TldoVWs1RWVZMTNIMExXMUNTZ0xSZXo5eThabmFaUm5Q?=
 =?utf-8?B?czlxbWJhTGViQXE2bk1LTSs0cWdtVE1uSG43ME9qblQvQnl1d3RIamlOb05Y?=
 =?utf-8?B?aGt5UVV2SEVMV3dSVDdhRzkxR3dCb1VzM3lPRVEvbi9LVTZ3YXU2QjFhN29s?=
 =?utf-8?Q?/qec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97553eb3-68a3-4eea-659e-08dc029aa851
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 03:04:05.1272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MR7sEfuimmuiLdSXnUrhx+ohRjjEitQsNqN7mkIQNelPuLZmSNxDxQCL/N1YjsUu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkkgY2FuIHNlZSB0aGUgc29mdCBy
ZXNldCBjYW4gYmUgY2FsbGVkIGZyb20gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlciBhbmQgcGNp
IGVycm9yIGhhbmRsZXIsIHRoZXkgaGF2ZSBjYWxsZWQgYW1kZ3B1X2RldmljZV9sb2NrX3Jlc2V0
X2RvbWFpbiB0byBhY3F1aXJlIGEgcmVzZXQgbG9jayBiZWZvcmUgc29mdCByZXNldC4NCg0KUmVn
YXJkcywNCkphY2sNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlh
biBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KU2VudDogV2VkbmVz
ZGF5LCBEZWNlbWJlciAyMCwgMjAyMyAxMDowNiBQTQ0KVG86IFhpYW8sIEphY2sgPEphY2suWGlh
b0BhbWQuY29tPjsgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L2dmeDExOiBuZWVkIGFjcXVpcmUgbXV0
ZXggYmVmb3JlIGFjY2VzcyBDUF9WTUlEX1JFU0VUDQoNCldlbGwgbm90IHRoZSByZXNldCBsb2Nr
LCBidXQgdGhlcmUgc2hvdWxkIG9ubHkgYmUgYSBzaW5nbGUgcmVzZXQgcXVldWUgd2hpY2ggdGhp
cyBydW5zIG9uLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQpBbSAyMC4xMi4yMyB1bSAxMDo0
OSBzY2hyaWViIFhpYW8sIEphY2s6DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFs
XQ0KPg0KPiBJdCdzIGFscmVhZHkgcHJvdGVjdGVkIGJ5IHRoZSByZXNldCBsb2NrLiBJbiBteSB1
bmRlcnN0YW5kaW5nLCBzb2Z0IHJlc2V0IHNob3VsZCBub3QgcnVuIGluIHBhcmFsbGVsLg0KPg0K
PiBSZWdhcmRzLA0KPiBKYWNrDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIERlY2VtYmVyIDIwLCAyMDIzIDE6MDQgQU0NCj4gVG86IFhpYW8sIEphY2sgPEphY2suWGlh
b0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIs
IEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHUvZ2Z4MTE6IG5lZWQgYWNxdWlyZSBtdXRleCBiZWZvcmUNCj4gYWNjZXNzIENQX1ZNSURfUkVT
RVQNCj4NCj4gT24gVHVlLCBEZWMgMTksIDIwMjMgYXQgNDozMOKAr0FNIEphY2sgWGlhbyA8SmFj
ay5YaWFvQGFtZC5jb20+IHdyb3RlOg0KPj4gSXQncyByZXF1aXJlZCB0byB0YWtlIHRoZSBnZngg
bXV0ZXggYmVmb3JlIGFjY2VzcyB0byBDUF9WTUlEX1JFU0VULA0KPj4gZm9yIHRoZXJlIGlzIGEg
cmFjZSBjb25kaXRpb24gd2l0aCBDUCBmaXJtd2FyZSB0byB3cml0ZSB0aGUgcmVnaXN0ZXIuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1kLmNvbT4NCj4+IC0t
LQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyB8IDIwICsrKysr
KysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5j
DQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+PiBpbmRleCBi
ZGNmOTZkZjY5ZTYuLmFlMzM3MGQzNGQxMSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjExXzAuYw0KPj4gQEAgLTQ1MTgsNiArNDUxOCwyMiBAQCBzdGF0aWMgaW50IGdm
eF92MTFfMF9zb2Z0X3Jlc2V0KHZvaWQgKmhhbmRsZSkNCj4+ICAgICAgICAgICAgICAgICAgfQ0K
Pj4gICAgICAgICAgfQ0KPj4NCj4gV2UgcHJvYmFibHkgd2FudCBhIENQVSBtdXRleCBvciBzcGlu
bG9jayB0byBwcm90ZWN0IHRoaXMgYXMgd2VsbCB1bmxlc3MgdGhpcyBpcyBhbHJlYWR5IHByb3Rl
Y3RlZCBieSB0aGUgcmVzZXQgbG9jay4NCj4NCj4gQWxleA0KPg0KPj4gKyAgICAgICAvKiBUcnkg
dG8gcmVxdWlyZSB0aGUgZ2Z4IG11dGV4IGJlZm9yZSBhY2Nlc3MgdG8gQ1BfVk1JRF9SRVNFVCAq
Lw0KPj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsN
Cj4+ICsgICAgICAgICAgICAgICAvKiBSZXF1ZXN0IHdpdGggTWVJZD0yLCBQaXBlSWQ9MCAqLw0K
Pj4gKyAgICAgICAgICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQoMCwgQ1BfR0ZYX0lOREVYX01V
VEVYLCBSRVFVRVNULCAxKTsNCj4+ICsgICAgICAgICAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxE
KHRtcCwgQ1BfR0ZYX0lOREVYX01VVEVYLCBDTElFTlRJRCwgNCk7DQo+PiArICAgICAgICAgICAg
ICAgV1JFRzMyX1NPQzE1KEdDLCAwLCByZWdDUF9HRlhfSU5ERVhfTVVURVgsIHRtcCk7DQo+PiAr
ICAgICAgICAgICAgICAgaWYgKFJSRUczMl9TT0MxNShHQywgMCwgcmVnQ1BfR0ZYX0lOREVYX01V
VEVYKSA9PSB0bXApDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAg
ICAgICAgICAgICB1ZGVsYXkoMSk7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgaWYg
KGkgPj0gYWRldi0+dXNlY190aW1lb3V0KSB7DQo+PiArICAgICAgICAgICAgICAgcHJpbnRrKCJG
YWlsZWQgdG8gcmVxdWlyZSB0aGUgZ2Z4IG11dGV4IGR1cmluZyBzb2Z0IHJlc2V0XG4iKTsNCj4+
ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4g
ICAgICAgICAgV1JFRzMyX1NPQzE1KEdDLCAwLCByZWdDUF9WTUlEX1JFU0VULCAweGZmZmZmZmZl
KTsNCj4+DQo+PiAgICAgICAgICAvLyBSZWFkIENQX1ZNSURfUkVTRVQgcmVnaXN0ZXIgdGhyZWUg
dGltZXMuDQo+PiBAQCAtNDUyNiw2ICs0NTQyLDEwIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMV8wX3Nv
ZnRfcmVzZXQodm9pZCAqaGFuZGxlKQ0KPj4gICAgICAgICAgUlJFRzMyX1NPQzE1KEdDLCAwLCBy
ZWdDUF9WTUlEX1JFU0VUKTsNCj4+ICAgICAgICAgIFJSRUczMl9TT0MxNShHQywgMCwgcmVnQ1Bf
Vk1JRF9SRVNFVCk7DQo+Pg0KPj4gKyAgICAgICAvKiByZWxlYXNlIHRoZSBnZnggbXV0ZXggKi8N
Cj4+ICsgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0dGWF9JTkRFWF9NVVRFWCwg
UkVRVUVTVCwgMCk7DQo+PiArICAgICAgIFdSRUczMl9TT0MxNShHQywgMCwgcmVnQ1BfR0ZYX0lO
REVYX01VVEVYLCB0bXApOw0KPj4gKw0KPj4gICAgICAgICAgZm9yIChpID0gMDsgaSA8IGFkZXYt
PnVzZWNfdGltZW91dDsgaSsrKSB7DQo+PiAgICAgICAgICAgICAgICAgIGlmICghUlJFRzMyX1NP
QzE1KEdDLCAwLCByZWdDUF9IUURfQUNUSVZFKSAmJg0KPj4gICAgICAgICAgICAgICAgICAgICAg
IVJSRUczMl9TT0MxNShHQywgMCwgcmVnQ1BfR0ZYX0hRRF9BQ1RJVkUpKQ0KPj4gLS0NCj4+IDIu
NDEuMA0KPj4NCg0K
