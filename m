Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0A5ECAAD1
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 02:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024F210E029;
	Thu,  1 Sep 2022 01:59:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC43010E029
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 01:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp84CCrPWtoHtzaBEl4yuJurEf5DmAkz+ACouriAcarF2Zb5pZMnHGiJ6uo7bgSLQey+DcgBhNKmkm6EgafkS8/M8yqf8qE34aavArRXvUHp7yi8yDtAVcKGPA7+qhzuiikUn/QGf3M7NJ8Xei/xLBQY5+2pvLKqRQcLF1ylXyfrr6F4qrzWjmwJWVHJOmTMCmoT+Y/LdRXYwShvk2OmreiO4FMxARbiTYmAXmtmYyQWZGweqPUqq3gAAGdr/zVHRfFad05K5kPu+Rx3a8WvT1RrLhVRItqTnDOYvBLMqaFQfnD/XFkAVJKNa40lb0jbBFPjqQBWxS3nuClnXXC5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDwOrNyWhwCWXmHJFHoSTaWtgDzwoDtWXxeMNWlHFjQ=;
 b=V2fI5v8bITdWOGneOrqzMca4QhDCSPJeUFjiP3YaRM6AIsDBzIoKHpCCqZLm2E8UyLaBGhzYGMn33KSLdczs/X4iLWUd3ZyZrFX8vyL/IzK4oBKzRu+vzmwwsXxzbNo6BT9TgY4/u2noE+InOnhAgUrQ0ePEvw90vy6mF6gKHrIAueEnDhUfoh578Tpb6falyQg30+DvL+vQAssVAvI0bXGJjoxVut72j6AGLcINZjQAl2G4XDV59swygTENh82qs70+y/h1CbmLcdfsNbFFkXNFSys0cBeQPHL26RWIJBpJOIq7nwnCTsSD5gfJ6cRrF9yU1kzhrDazyc4Sc3J+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDwOrNyWhwCWXmHJFHoSTaWtgDzwoDtWXxeMNWlHFjQ=;
 b=D3f/AMVfL+X3lT9AAAeRaaNEq0DwWiXLUl/SxQx9fljJNadPXa2m+vtwmmES7WvtITdmPlvtgzCnig5jUWRYTDBMZoNfRnG/6z6RDcF2em5BqCUXX4su754R1G/qMF5WTnIhE9NhDhu2HXis7+3uFPtxopS2XixAA4pviUjLBO8=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 01:59:51 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6047:4ead:7690:57e6]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::6047:4ead:7690:57e6%2]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 01:59:51 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:  disable the debugger on gfx1036
Thread-Topic: [PATCH] drm/amdgpu:  disable the debugger on gfx1036
Thread-Index: Adi9n5u4QBhFsURoQ4+Un9d1uHtasAABsU4Q
Date: Thu, 1 Sep 2022 01:59:51 +0000
Message-ID: <DM4PR12MB51524BD0879832D1C9BB34FCE37B9@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <DM4PR12MB51525C1D8C1E070C54C78301E37B9@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51525C1D8C1E070C54C78301E37B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-31T00:50:18Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=338a98a8-b401-4727-910d-a6d4f3e7b2d3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-01T01:59:48Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 613d8c9b-4fed-4201-a074-248d25ed167b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82164c78-508d-432f-0262-08da8bbda83a
x-ms-traffictypediagnostic: DS7PR12MB6264:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4hqJCwcK0tZMNAZ8622iFQphxWC9y5TU9Ok5nXLW/I5pXhLRje39581aiKbt96d41zV+iuHkuWPUoG05tx+oph6AshL5/nn/hVppoiqZgGNmhK/44BmhG+ZYWyImKtgcnDKuRBSvc9lArotiWg9xPOT8WheUvqwED+wOXZojV8jzUhYB2fcKyJx1G5EiuDzXHnvbygZdAjvZkpixUinApgzDvHUkd7GmDEGhdQp6vEywlT4lxq8KZTdPdlhnFpzAokA0S2MqmVFDQ0RF0cK4o1wIvK4MjSzN+vNJZTxttUgOeo0MJn49rBirukFJn5T9bpj9aHCjibtv1jIHfnwzHVsI5qIl+lyxoLdeHO1F5aDliAmSee2rrhPUrUach0isNUTKqXdfMbtV6QK0n41jzPpQGE5Nh5LjPfcyjl0zwDIdffo8aPM6YBXG0hxkY81f/dBIWRfb49rloD+7cNwWnhemZ9ysGVtCreHUzMUfByPyJMcGVz7T+LJ9A/5gXYdUFm+Kw5CJWMexZx6kq3GtQqmfwyZqphLkr58zVOJgOfVnwmERQyWpyqVsi7EplDLBk/zoemf1GcVmzwkrW5h74FVTPl4DDQx9dx7mq9MNFkYFYua2ZRd5KM5nMrNCbVN+srKjBkJj9bF35nGh2nrfVIAUMjZEIhHScFY4X7MuI/Q/6E7LNZCGS13GgwseLWYeUnFsrzY4Ifuo3F283JtWRvl47Fv7M445G6D4VTrqG4JuP1brsFdSsRVvBzvrZr4BkwBiGdylzhxpKZbN+lDdlaD7yAUBv1PpwMeEOhgCir8Ww6QbHx8bkipblHQBw1C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(4326008)(316002)(5660300002)(2906002)(66446008)(66946007)(66556008)(64756008)(66476007)(8676002)(4744005)(54906003)(110136005)(33656002)(52536014)(8936002)(76116006)(38070700005)(38100700002)(478600001)(41300700001)(55016003)(71200400001)(122000001)(2940100002)(9686003)(7696005)(86362001)(6506007)(26005)(186003)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TThFL0Y0Y2VZdEttb0ZURWNkZlZkaEs0dm9reCtyZms3OGdQOUo5KzNyaGtR?=
 =?utf-8?B?UDRrdElvc3V4dEw4QWxqRmpwM0szelZZR0dBaWNubUlTTVh4emtPVndyNHJI?=
 =?utf-8?B?UWx1bzZib3BhZ0I1L09GQlNUVGQvd0R3VG5LelExdXM4T0U1NE9aMEY0WnVv?=
 =?utf-8?B?bFVacTFveHowcFJpQmVLdTdjVlRGek9KR1c4QzRWOVdmYjZFN29QWGdlYkU1?=
 =?utf-8?B?K2RRRDd1ZllPUFQ2L0syZGhnczE0MWhqcnJSQ1hoSEtOYkptTlNQMGFRbDlO?=
 =?utf-8?B?RFlWc1NsTCtkMFN3ZVpTQUQvcWEzMllsNkFFRURyd3IrcHp0VklFSno1eUta?=
 =?utf-8?B?UU9UOEhHOFlFMC9admVxY2kyRkx5dU1udnRpLzcvck9adHZ4bURrVHVSY3JK?=
 =?utf-8?B?VVFJWGE5MGl2Tk1yTHFWUGhxZ0JaeGs0endIMi93WFVMRndDMEZXSmxNYkJk?=
 =?utf-8?B?cmlMRDR5LytCd1AxeG5wTndTRTlvblBYWkJTOURwVUNFVHI3ZTdJbkJFS2pP?=
 =?utf-8?B?TXVSTkRYVURmZDJHK0NxOHZTTEtIOVlGMjdGTzY4MHhxc2cycWZZakovVXAy?=
 =?utf-8?B?RXByT09pOVVGd3pnN3VMNy80RlluK3pkN2pPNlVlWTB5eTF4ZmdKMi9WUlow?=
 =?utf-8?B?VVU5WnBWQTV0MXg3VlNSK2dPdWlydldYdXRJZ1dYNlJiUzQvbjZxaCtjRm1F?=
 =?utf-8?B?MVhmcE5yRFN0c0xVWURMTy92dWVZaG5YUEVad3RTT1BJMXVCRnloV00yM3lH?=
 =?utf-8?B?azVkcnE5RE0wQWZBODM5blI1YklGZy9oYnpxQTM2MnQ3dEt1SnNrbk9KWDBr?=
 =?utf-8?B?dzdzODd6QmpBYzhJQkdMQWlGcnIrMWhNMVJFQVYvSzVXT0lvTW95clFRN1Fa?=
 =?utf-8?B?ZTRoUmdLMWxKOTVzeURTRWlqZkFxNDNCMkI4UnovYkt3TkpWRlZFcERINDVN?=
 =?utf-8?B?YTJ3bWNPdnJteGtXd1V6bzFtalplLzRRd3dUTVNLZks1YmYrVDYwaFVLYUkx?=
 =?utf-8?B?eEwvMWcrOUpQSXU1KzlzV1pEMlpNemJqOGRMNlJqK0JQeE43dmcvT3VBL2tC?=
 =?utf-8?B?YURNeWVxMFliWlVNRHRMVlorU2kxbXpnVVowWG1scmt2U1BEdWtLUmdHWkhj?=
 =?utf-8?B?Rzg0S1Vjd0tud0c1VHhNQmREUGM4b09FQ0FKdGZNTjFESmFDV1BWeElUZkp2?=
 =?utf-8?B?Q1pkNWh1ejVpcnZGekNPNC8zb01KZVRzZjhrWGFtK3lLeVdNZXQyamVxYlVM?=
 =?utf-8?B?VXBCaFNOUDBia3RQRjBjeXU3ZUplbE1taTlaNysrbm9UcVZ2d0xKMWtUdGRq?=
 =?utf-8?B?OTBCRXREQUtSMWp6OTAwU3FBd3VSalhZVktSaG9iemZGSDJ3NHk4eFkxUmxF?=
 =?utf-8?B?Sm5SQkxjUTU2cjVMbEZBQklBbXd5Q0ZROTBFenRHMEpIdjBlblZQUUdtOHQx?=
 =?utf-8?B?c2IxcnFPcURwOFJEVTdJTkJEU3R4UHZ2blB5OVRnYVV6SWg2VU9qQUJlbW9F?=
 =?utf-8?B?ZVJ4dXpma0dYWjJWaGVkbE5kQWllTFByYldxRXFibG5QUEwyYlc1QXlsTGUz?=
 =?utf-8?B?NW5sczNwdzNmbzAvVFFmKytvTzFKTFRZNGExR2s3eTBhOFdLczJWcE1hRDFa?=
 =?utf-8?B?NGhJSjkxTHh4clo3Z0lveTZWMnh3OXBOYVN4MEttYXc0OERWRGQxeHRCYzha?=
 =?utf-8?B?L2ZQWW9Cb0dzbzlkeVhCY1E1bC95czFhYkV6QmNMejZ0S0pDbm5pSEY5VHk5?=
 =?utf-8?B?cmltQlVDaUN1L2NaZkhlL2FaL0VvcVVMMWl6Yi8vcXlFSytQUDVzWkx0L3Zj?=
 =?utf-8?B?M0hQUXVja1ZWMjlWb3FWaVRwMGtXa2NhUW5vU1pmQVo1K05QWWx1V3VHcGpU?=
 =?utf-8?B?ZW9RUHM0WVU1NGVpeGFRUjljWDRQZEdzTVRLZko5S1I3NUk4SDAwZEpET3FR?=
 =?utf-8?B?V2xqbVpVWGppdFBBeUVCK3JzMmlSQWlyejh2cEhYNTBJeXJGVlZBdWRrUzVJ?=
 =?utf-8?B?Q052cmpQcEpEVlNJRno1WERKL1VlMnVvOUNnc1ljOVQ1WGpkOWJHR3d2bG1v?=
 =?utf-8?B?NHFMMlE0NThQYUlYMncvcTd5QWw2ZHZwV1JBMzBITWZLSnlTbTBjWTk1VWJZ?=
 =?utf-8?Q?qOofJBo5CFEsX8YZbM5/pv9sd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82164c78-508d-432f-0262-08da8bbda83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 01:59:51.3175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2e0XxwJg5YoxLiWmOMtVvPUg7yJIcAXaGwGpMyuHXU/I40M2o2BYui0nw/YdoA1Lo033dGZbLj6uEA8Rarhh6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KRGlzYWJsZSB0aGUgZGVidWdnZXIgb24gZ2Z4MTAzNi4NCiANClNpZ25lZC1v
ZmYtYnk6IGppZTF6aGFuIGplc3NlLnpoYW5nQGFtZC5jb20NClJldmlld2VkLWJ5OiBKb25hdGhh
biBLaW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZWJ1Zy5jDQppbmRleCA1YWIyMGY2ZGMyOTEuLjg5ZWJiM2VlOWNjYyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZWJ1Zy5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYw0KQEAgLTEwOTcsNiArMTA5Nyw3IEBAIGJvb2wg
a2ZkX2RiZ19oYXNfc3VwcG9ydGVkX2Zpcm13YXJlKHN0cnVjdCBrZmRfZGV2ICpkZXYpDQogICAg
ICAgICAgICAgICAgYnJlYWs7DQogICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMSwgMyk6IC8q
IEN5YW4gU2tpbGxmaXNoICovDQogICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMywgMyk6IC8q
IFllbGxvdyBDYXJwKi8NCisgICAgICBjYXNlIElQX1ZFUlNJT04oMTAsIDMsIDYpOiAvKiBnZngx
MDM2Ki8NCiAgICAgICAgICAgICAgICBmaXJtd2FyZV9zdXBwb3J0ZWQgPSBmYWxzZTsNCiAgICAg
ICAgICAgICAgICBicmVhazsNCiAgICAgICAgZGVmYXVsdDoNCg==
