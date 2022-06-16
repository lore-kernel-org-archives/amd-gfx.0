Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326A7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 16:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4575511A4EF;
	Thu, 16 Jun 2022 16:26:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5767111A4EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 16:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxX+zDfP0sWpM0ANBzKg+fNC8tjsOnzAMRiTGUOu9vItOt+Jdo8OoiDqhPSm4QWE540aBfdyR94jUvonyLfMXQYCW5I423LRQtReeUm1eqMO4Z5EBDFqaTn1xxLFfIbm38fMVeQTz1RaDXgGS4rtFrqv+xxwQ4NRqpty2JAcAT6qyL9IYgyN09HbYuKtt8vPt/myr5vlG0AKU9dsZcssSXZ4EqJ36Ib7YV0D6fhdw9RmNbqcVUsOXVvm+IUo35rxYMM8n3fOXAD/tMqIvSbT5i/seBCSt9ZUMWyxn5tZ/47jR5OwBKgVvKEKRLnOvY+9+zm75rChbBW3VdugCk2low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxwiC/NGIegsANscq2EUcm2jMl/HhBGU4ihoSWytXyI=;
 b=OMfCH8vjmL/nj/GLSeTbaY95W5Z+1fnTqh/Yop75ABxmgyxI26OXQphESg/ZzUphVX9sG985Xa/vF5V3LmTC7OCXsfaDqKJavzcpe52QG3qPnh+WuhXSQJamsAIOY1z4zIg0XBcrWDY+lvEut1TXjrk96DnHz4SmpfnzSnNMW9KH6V0Wg17p2p6GrxdABCgfuqiKqF9XTGRUSsViSBhgX0gxflF3wYaIbfmRvTM/AS0ruJRJJ++dHMvm0dVAYM98B/ZmiQ+lhq3RBBOvfT53ZR3e+FmQpk+0GfPHZ9IQfCPZ9a+JF6lz+hM7LxzeIQEJ3fwaIyPBYDv+g1irzoPXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxwiC/NGIegsANscq2EUcm2jMl/HhBGU4ihoSWytXyI=;
 b=fCQ4/Coc5lb7GG2ZEkxoexnkO0MLFtrSmLFubWloaZr2ZtU1Ns87a04Pp3F/Rqh6ulPZxZeQnHCOMPWG+/ZXznnxJRdF0BShtBSDFo4dqmyJcJbMcsGCvb6UScVitDLUzdT4cCynHhafUDdzikhyBjrQch956Nj22O1uzyAkKdI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 16:26:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1%6]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 16:26:34 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd: Don't show warning on reading vbios values for
 SMU13 3.1
Thread-Topic: [PATCH] drm/amd: Don't show warning on reading vbios values for
 SMU13 3.1
Thread-Index: AQHYf/osYBxhhI8gJEq/amIfOpVbOq1RXdgAgAAG1YCAANbBMA==
Date: Thu, 16 Jun 2022 16:26:34 +0000
Message-ID: <MN0PR12MB6101CC58F25CA53B6177CF0DE2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220614142220.19188-1-mario.limonciello@amd.com>
 <CADnq5_PrgkeJvrGoYPNCEe3J1gYFB5G94W-j1yaCRViKGm9Stg@mail.gmail.com>
 <DM6PR12MB2619BCDB033015C60FC6953BE4AC9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619BCDB033015C60FC6953BE4AC9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-16T03:36:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=28d5e772-52c0-4605-83d2-0ecec245d606;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-16T16:26:32Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e4d80e39-bdfd-4553-b1b5-1423b70c084d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddd6ca32-9c52-457b-bc19-08da4fb4fa75
x-ms-traffictypediagnostic: DM8PR12MB5416:EE_
x-microsoft-antispam-prvs: <DM8PR12MB54161752428EC380FFC3EA6CE2AC9@DM8PR12MB5416.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kE/VbfBI8yjArRmBjYQ30aYQaxPGuHzwGmEOTCSiIbRp2lcxN69miLHQ4Feg3kGi2nEeKhPb5pjP0JYQPOe1SYwKL5Shu1yKKuoThwP8GV0WyAQLO4Ht/S9XLDJet12UmkKbj32WiQxNHkAbns7TsnsoS1sAuI5XcIebmR52nHDe9y9JY2+9u5LVoadu1LSZL6GytBChVDlmMxZ4SQpA4x/zFrW6kNNlzS3kDEWY/xxk5a9h7cDPFYADMdIOpRFXelFbIbByeaPkk49ZZ/jkbB3rhI1dUYyvSaauDgDqtzct3uFOEA3ssuAu0oqhkPfPU7PWN0ChndG6D7aj9FH+FI6Jgu3R1DlzTzxcRS3LLQTP0eSMRpW8x+Yk5TpQ3yQMD0z3fXcf2eRWczgXQ0QL/PpK3xq+n5i8np366BlVgdR4WhW9oVgZxuHvIbBJGkeG9dCRaNCL5aQKhQxuiQCP/8QikcMTw82q06ZMgjXtHDAdpcP62OX2mvITBcBKjBK5Jf+HYQ3k24qZ6KJ93sT4mlDuMx7fCp4hMX/Uqa07LrJtA0wGIQUtVD1r/OjmWvLi8SbxnUTZ5JvC1lY7SxbpuRISc5Kl06Y+YwDj3DZjPhhibUZetTqPdeoCUDr5GJOpIwZI4Y8yITw6NuXHwEZsxfvhmKoHk74RJ9uYiDZ9PtpdruhwXwHLxxUFDOvFOIYat1UICAPUUEUndtzjulMl4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(55016003)(6506007)(7696005)(71200400001)(498600001)(38100700002)(316002)(186003)(6636002)(110136005)(33656002)(2906002)(66556008)(8676002)(76116006)(122000001)(4326008)(52536014)(66446008)(53546011)(9686003)(38070700005)(66476007)(66946007)(86362001)(64756008)(5660300002)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXRob2VBNDU4MlBKQkwzWGdDQ0poTjJqNkJ4dDJIZDBpbDFEUVJRSEN1cko1?=
 =?utf-8?B?T3ZxeDdCODF4OE9YeGk4andXNmhJUmFWaXJUM3E5Qnc2WU9oU2prT0JVeVpW?=
 =?utf-8?B?b2RvdkUzNDllMUxZTTY5NUhuVnViR2JVVzlpMmpwTXR0VGFycCtsNWlXNEYx?=
 =?utf-8?B?OTBaRUZZSTJETWpPcnNZTGp5NVJRazFqc2VDUmxKNnFEQW9aanZFRTNJUHp2?=
 =?utf-8?B?Q0tDSVpRRVF1TUdVZ215VXdiV2k3N1BBcUh0dEFtL3pMK0xZSDExSUN5WS9n?=
 =?utf-8?B?V0Y3aitEOWJtbkYvd0I3RW1pUDRsVXRkQUZjTkZYMWJkbWtROWtuSmFJNktL?=
 =?utf-8?B?dkFITWZnQm84Q3FTT1FEbWIxbFdsS0lqRjEvOUp1ZWplRGlhQWsyTUJlR2Nm?=
 =?utf-8?B?dmVaZThLY3UyUnVJdisxL0FtbmhPb21aZThCMjZpT1hsZ29uelBnRVB5SDBF?=
 =?utf-8?B?bXY3c1BZcURwOE1wVk9YdVJiOUdtd3lPanEyczBWMWFSUEhZVUhScGJtbStx?=
 =?utf-8?B?MklmcjluRUNWbC9HZ3NWS1RGQzNlTWZIcjRjS3NwUS8rZ2xUczlpcFYxSEpS?=
 =?utf-8?B?bWlFcGhQVVVydWh4RkZGeUJJeVRBWlorTm1Xa2N1ZVJGbjBGVDFRVHg5ZTVx?=
 =?utf-8?B?Z1NFaUtvRUU4VmNsdjl1d0lNTC80aDNsalE2dEc4Q2R6VVdaazUxNFNSQi9o?=
 =?utf-8?B?ZzJwRmtvRHIreHhuNGxxUWFZNURDNlNkckhXMGoyS3BTdEJ5Znd2YjRJSXZY?=
 =?utf-8?B?Rm9kM1lTbVBhNGN4RSt3QWdSd2MramVwamdrTXpSdGhsVVhScFhTTkZpU2dj?=
 =?utf-8?B?dG5WdmN6YWp4bW8yRlQ5enhOYUE4RVNQSndrSDdFQkJBajMrRUNPTFZNejha?=
 =?utf-8?B?WVF6SXlCS012Wk1YL1pHUnpMS1hWVExuKzc0c1NuNVFmOFFTMkdDZEIrVVlS?=
 =?utf-8?B?VWFXemJxTWltN2lUS2F5K2RiMXlPNDMwV0NRbWErbHArc0plTVVyTTZ5bDUy?=
 =?utf-8?B?RkpJWTJJdTJGVklhaHVXMlNXVWFPZTBFREZNV0NneEd2RGd2WWtKdEFEVXJz?=
 =?utf-8?B?VFIwUkM4dzBlRStWSFRMY2ZKa0dLaU81TWVoZm9kNW9tMVdDUCtYUUlXeVZL?=
 =?utf-8?B?OGhCTzM2bWY2cVNnc3MxOWlkRFN2U2RwamxHZnE0b0ZGL3VudU1aUXd6RlNo?=
 =?utf-8?B?a0FKWlZ3b1lpVUNkQ2JIaC9YeGM4ZlJwK0VmWU1kckFUZE9YNWtKZHl1KzhO?=
 =?utf-8?B?TkdOWUZEaGNHcjJUYzh2TXJta2UwVmdaelpkRER6bjNMbk1PWGxPSjJmTGx3?=
 =?utf-8?B?Sk9tUitKYlh1MGk3ZUloN29zQy90T3JhUDNMZnh4ZkdYdjJyVTU1WVZoNDdm?=
 =?utf-8?B?OWRUTTA3dXFzNWMzdjNjOGhPcVVnQkhtekdOK2Y0ZlpQMlN4UC9iSWEycndm?=
 =?utf-8?B?RkVFQnJZNmN5Qm5vbHE4RWNFVzhmQlQ1S2g4MktLS2ZkOTIwc0FvY21IRTdU?=
 =?utf-8?B?OThoZkZZZFdGcUJPbWlpU3M5K01OOHcwbzJZTHhFaVdBSmdKOExsWDhKTGQy?=
 =?utf-8?B?a1E3QWozKzJTeHRFMXpoSS82WUdDTnFoSEZPcTFIVXpyd2l3T0dqV1NmZlVu?=
 =?utf-8?B?UURVWWNPVjE5dEwyMi9UeVRZSkFhdENUTHJyWkE4VkZaczNUQXZjbERhNTRM?=
 =?utf-8?B?UFhQd004TXV5dCtNVU5jUUxlMzlXQTQxdmdTbnBXUVZQYTBGNDZaWVllb2I5?=
 =?utf-8?B?cklkazJ6RElSU3hRMXZuMElkWWx4YjBicS8vYm9vMUdjRVozTnU5dlMwRGxJ?=
 =?utf-8?B?Z1Z1cFRtcTlGcWk3MjNKMkttSk1td3VaM0pXalNnN01JcFQwc3ZKUXVKR2Nt?=
 =?utf-8?B?YVUvdHlocVlIRldHeXB1UGV4VlFBTWRGTHNwakE3TVJqVTdCSE5BWjVua0xH?=
 =?utf-8?B?WEYxOTRaVDlrVGhUVDRZU2lSUEdENTcyZkxtR3prTmliOHNzY2JZaGN5dTFj?=
 =?utf-8?B?ZTROUnoxajJlWHJaOWZqUTVRbC9jMXpLY0R1am1iaktRZk5kd2Zwa3d3Tkxv?=
 =?utf-8?B?UGVTZnQxaVVIWGNhT3FVM1E2aUltME11SWtnRWQwSm51SEdZWE4rYVZhdEJo?=
 =?utf-8?B?NjVRSm52aUJlSUtWTHIvZUpiNjJGVjdlOU82Y2pKVTRaN2ZhZUVTVzN0UnZH?=
 =?utf-8?B?ZjJGZmx0cnpGNzJFVHVzUEJLTENPUUlNaEh1aHdiM3ZjTnEvdmRRQmFnYllt?=
 =?utf-8?B?N1JaRW9rY2o0VDdZUXFnT20xUlVWM3h1d0hydkQxSm5pc043NVI3WEFGN3lN?=
 =?utf-8?B?SGtlejEwN01FbTZnanhCWG1tUEZCbFZiRUUxeWtKclo2QUxucGVMWVVQeUc3?=
 =?utf-8?Q?hJEdSKJxGGRC5cJI1D8glVJ82ckff5mYiLJ7jrrhP5mP/?=
x-ms-exchange-antispam-messagedata-1: l0+iOq4NgZUT/A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd6ca32-9c52-457b-bc19-08da4fb4fa75
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 16:26:34.0435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAr2WPAwKCoTSxbdbk8pyoKoZcOqYZhhmLg35jFdYHreSpgI9rRomvVxbaqUbhTWofbDizVyyPTEl0OFxOBSDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIEp1bmUgMTUsIDIwMjIgMjI6MzcNCj4gVG86IEFsZXggRGV1Y2hlciA8
YWxleGRldWNoZXJAZ21haWwuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1v
bmNpZWxsb0BhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQo+
IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kOiBEb24ndCBzaG93IHdhcm5pbmcgb24gcmVhZGluZyB2
YmlvcyB2YWx1ZXMNCj4gZm9yIFNNVTEzIDMuMQ0KPiANCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25s
eSAtIEdlbmVyYWxdDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBmaXguIFllcywgdGhlIHN1cHBvcnQg
Zm9yIEFQVXMgd2FzIG1pc3NpbmcgZnJvbSB0aGUgcmVsZXZhbnQNCj4gY29kZS4NCj4gSSB0aGlu
ayB5b3UgY2FuIGp1c3QgZHJvcCB0aGUgcGllY2Ugb2YgY29kZSBiZWxvdy4NCj4gLy8vLy8vLy8v
Ly8vLw0KPiBlbHNlIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2X3dhcm4oc211LT5h
ZGV2LT5kZXYsICJVbmV4cGVjdGVkIGFuZCB1bmhhbmRsZWQNCj4gdmVyc2lvbjogJWQuJWRcbiIs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1aW50
MzJfdClmcmV2LCAodWludDMyX3QpY3Jldik7DQo+ICAgICAgICAgICAgICAgICB9DQo+IC8vLy8v
Ly8vLy8vLy8NCj4gRWl0aGVyLXdheSB0aGUgcGF0Y2ggaXMgcmV2aWV3ZWQtYnk6IEV2YW4gUXVh
biA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+IA0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGlzLiAg
SSBsZWFuIG9uIGxlYXZpbmcgdGhlIHdhcm5pbmcgaW4gcGxhY2UgYW5kIGp1c3QgY2F0Y2hpbmcN
CnRoZSBBUFUgY2FzZS4gIFRoYXQgd2F5IGlmIGEgbmV3IHRhYmxlIGlzIGludHJvZHVjZWQgaXQg
aGVscHMgdG8gbWFrZSBzdXJlIHRoYXQgaXQNCnJlYWxseSB3YXMgdXBkYXRlZCBoZXJlLg0KDQo+
IEJSDQo+IEV2YW4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEFs
ZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBK
dW5lIDE2LCAyMDIyIDExOjEyIEFNDQo+ID4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT47IFF1YW4sIEV2YW4NCj4gPiA8RXZhbi5RdWFuQGFtZC5jb20+
OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCj4gPiBDYzogYW1kLWdmeCBs
aXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj4gPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1kOiBEb24ndCBzaG93IHdhcm5pbmcgb24gcmVhZGluZyB2Ymlvcw0KPiB2YWx1
ZXMNCj4gPiBmb3IgU01VMTMgMy4xDQo+ID4NCj4gPiBPbiBUdWUsIEp1biAxNCwgMjAyMiBhdCAx
MDoyMiBBTSBNYXJpbyBMaW1vbmNpZWxsbw0KPiA+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29t
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiBTb21lIEFQVXMgd2l0aCBTTVUxMyBhcmUgc2hvd2luZyB0
aGUgZm9sbG93aW5nIG1lc3NhZ2U6DQo+ID4gPiBgYW1kZ3B1IDAwMDA6NjM6MDAuMDogYW1kZ3B1
OiBVbmV4cGVjdGVkIGFuZCB1bmhhbmRsZWQgdmVyc2lvbjogMy4xYA0KPiA+ID4NCj4gPiA+IFRo
aXMgd2FybmluZyBpc24ndCByZWxldmFudCBmb3Igc211IGluZm8gMy4xLCBhcyBubyBib290dXAg
aW5mb3JtYXRpb24NCj4gPiA+IGlzIHByZXNlbnQgaW4gdGhlIHRhYmxlLg0KPiA+ID4NCj4gPiA+
IEZpeGVzOiA2YTczNDU0MzUwYzAgKCJkcm0vYW1kL3BtOiBjb3JyZWN0IHRoZSB3YXkgZm9yIHJl
dHJpZXZpbmcNCj4gPiA+IGJvb3R1cCBjbG9ja3MiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFy
aW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jIHwgMiAr
Kw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAu
Yw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5j
DQo+ID4gPiBpbmRleCBmMThmOTYwNWU1ODYuLjBlNTlhYjIxOTJiZiAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4g
PiA+IEBAIC03MzEsNiArNzMxLDggQEAgaW50IHNtdV92MTNfMF9nZXRfdmJpb3NfYm9vdHVwX3Zh
bHVlcyhzdHJ1Y3QNCj4gPiBzbXVfY29udGV4dCAqc211KQ0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgc211LT5zbXVfdGFibGUuYm9vdF92YWx1ZXMudmNsayA9IHNtdV9pbmZvX3YzXzYt
DQo+ID4gPmJvb3R1cF92Y2xrXzEwa2h6Ow0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
c211LT5zbXVfdGFibGUuYm9vdF92YWx1ZXMuZGNsayA9IHNtdV9pbmZvX3YzXzYtDQo+ID4gPmJv
b3R1cF9kY2xrXzEwa2h6Ow0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc211LT5zbXVf
dGFibGUuYm9vdF92YWx1ZXMuZmNsayA9DQo+ID4gPiBzbXVfaW5mb192M182LT5ib290dXBfZmNs
a18xMGtoejsNCj4gPiA+ICsgICAgICAgICAgICAgICB9IGVsc2UgaWYgKChmcmV2ID09IDMpICYm
IChjcmV2ID09IDEpKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsN
Cj4gPg0KPiA+IEkgZG9uJ3Qga25vdyBpZiBFdmFuIGhhcyBhbnkgY29tbWVudHMsIGJ1dCBpdCBt
aWdodCBiZSBiZXR0ZXIgdG8ganVzdCByZXR1cm4NCj4gaWYNCj4gPiAoKGZyZXYgPT0gMykgJiYg
KGNyZXYgPCAyKSkuICBJJ20gbm90IHN1cmUgb2ZmIGhhbmQgd2hpY2ggc211X2luZm8gdGFibGUN
Cj4gPiB2ZXJzaW9ucyB3ZSBtaWdodCBydW4gaW50by4gIEV2YW4gb3IgS2VubmV0aCB3b3VsZCBr
bm93IHdoaWNoIHNtdV9pbmZvDQo+ID4gdGFibGUgdmVyc2lvbnMgYXJlIHZhbGlkIG9uIHdoaWNo
IFNNVSAxMy54ICBhc2ljcy4NCj4gPg0KPiA+IEE7ZXgNCj4gPg0KPiA+DQo+ID4gPiAgICAgICAg
ICAgICAgICAgfSBlbHNlIGlmICgoZnJldiA9PSA0KSAmJiAoY3JldiA9PSAwKSkgew0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgc211X2luZm9fdjRfMCA9IChzdHJ1Y3QgYXRvbV9zbXVf
aW5mb192NF8wDQo+ID4gPiAqKWhlYWRlcjsNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4x
DQo+ID4gPg0K
