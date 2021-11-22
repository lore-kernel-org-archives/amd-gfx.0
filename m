Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0B1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 14:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFF4899BC;
	Mon, 22 Nov 2021 14:23:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C6B899BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 14:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhXaFx2tnZNzcDst1nElY6KIR3ab+fx/744DYVRHh/N3S3uFqiQfLknMrRWM8sXusJLm8GDTsxjzCcRmwP499qNgXr3BkPsXsYo9MvTMvEwaTwACR3mu8YrAnvyJ/8rjmTfLgDlCHP6V49Dy9HBNLCwZiRtspPeEvFPAHu+aibadukmb2Usx8XMVlm6Vxpk29uNCpptMYQP2Si2ec2zcYg28RiyjnAwV6pT3ldKIBIzo56ZR2WYBvNQP1apMsHQDvymLhuaSBL7saHqdeUgu+b8UqTGci5puGMfMOCsB/3CizEKTi2sulhhpWjMaZ8OSfHoSzIK0hBeuVjmWu12Ekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0B3uGIOnJNnBaiGmxBRXy4xwQmmuRkJ9iqY3NGVsCk=;
 b=RIh1HR7zVG781X/VOPcKrrMi/j/Zbo5acwqMofRpaPsOfu3KbEbDzmLpOnG0HWLVbWz7VrZ0YNGdOz0Qyes4nASfTxDmO2rYncIUkIW54hjAoUTf1xoGwiCO0JfKpQuEkN2gayYnDg2Ttp2EgN1zWQtAuBpyKjs8YED8/S7VdK0IooN8PWh6mx/2awf5OVHo6XLgP8t+UnVHoGo/yR8mhJr8ZC4JNXiR4Mo0091vsURLcwtFlgVLAN5fpnTXW0REP01YmYKNHvqsPAG5gLrwrQ0M0T0YDZsYL/ek2LPUg3IZMbxqf2Vjl+Gu61mSEwfdO9uBorMqnieFbSZrAmNJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0B3uGIOnJNnBaiGmxBRXy4xwQmmuRkJ9iqY3NGVsCk=;
 b=iA/OyNMuok53ujh4K0uDBIpi9XY39knIayqm1mlGC2SI2a/I06JTyUfAjUrpnaNce/3tQnrkI7XYp8/XbxpqmDWK695nDnLceZ/PkGT55ZL2axa6O1mIUcFNv58N2wYjA1CCk5jB3JzGzN1cp657Kmh7pwJVWJ5qTgacLw5LJXg=
Received: from MN2PR12MB3246.namprd12.prod.outlook.com (2603:10b6:208:af::21)
 by MN2PR12MB2958.namprd12.prod.outlook.com (2603:10b6:208:aa::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 14:23:32 +0000
Received: from MN2PR12MB3246.namprd12.prod.outlook.com
 ([fe80::70b6:8476:4368:fd71]) by MN2PR12MB3246.namprd12.prod.outlook.com
 ([fe80::70b6:8476:4368:fd71%5]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 14:23:32 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Thread-Topic: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Thread-Index: AQHX3Ep0OrbJL2yYpUqCXznVALiInqwI7ECAgAA3wuCAAC5hAIAAAPMAgAAAjwCAAADIAIAAAvYAgAAA3ACAAAksAIAAFYQAgAYlvHA=
Date: Mon, 22 Nov 2021 14:23:31 +0000
Message-ID: <MN2PR12MB3246251ECB6905B242B29379FB9F9@MN2PR12MB3246.namprd12.prod.outlook.com>
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
 <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
 <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
 <CADnq5_MGQ802Z-gdgfQXK_Eo2RXeE0qZ7AQUQLusez4Y3ysT5w@mail.gmail.com>
 <14cd6274-c967-ba7d-71d7-ccf332c30494@amd.com>
 <DM6PR12MB3930D33025C01706AE0F258F979B9@DM6PR12MB3930.namprd12.prod.outlook.com>
 <CADnq5_MbghaKafhQ0cQZPoL4FNHap=53kCDGP4X99rxe7Du-eg@mail.gmail.com>
In-Reply-To: <CADnq5_MbghaKafhQ0cQZPoL4FNHap=53kCDGP4X99rxe7Du-eg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3a41f247-a684-470c-b6a2-7220411fe769;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-22T14:10:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 958bda1c-3049-4176-9150-08d9adc3a951
x-ms-traffictypediagnostic: MN2PR12MB2958:
x-microsoft-antispam-prvs: <MN2PR12MB2958B5DB2146705A95F94ADCFB9F9@MN2PR12MB2958.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUm6Ao9t44Kls+MAuS/0ADhXqMsxEQKc8msgpmSxUW7cQVxdmz2yYdVJDpvuGCNtX9HOy2A1YNfSGoygvjYofmVnp5eE0jbdnkCIjpJuG0CQ5lWMyRGJ/VSsMyQJhTWgbA5OaIX3n3Dl/LTze02Sjw/Smw1f3ZUeCVtPq2/7iP7hOuntUCVodmbd0Ae9zYd/+zyLVYAGuzqlia+Vewm01P7OXvj4OBItIMWMk309NcIcRDU7tkqnJeFCma9I3QQbKP+AilICct11VghwKega0L2Iizm+MDnZtjpbEXoQxErcdhRxni9cmZOVeSRaoXYYV5Or7qB99bAbrhvJMA5PJ5y07/iGaPQ39TNQ7eodV+tn/KgFGDoV3ca3TGWxUyOorThrfe6bLc44+WVPpcCUTELp2JbkIfoyeDSfcVOFKSN/anrVmFoceFAPtL5FFIXjnfKJy4tVIQ2SS8fEPadoJ6KACvHBJByZeb2OCX+bAqYhSMEvnTKzjreRBb4ZSJrqvxNeeGEmLDVG5wOv7OUYYt84VjelhSOL5JEP+d9rrHqiT27nfwZcYkrKk+QIhfMC840m80BKdROWrQc0OBrLCPehP3my3ybM9dtyFIZ8qvThXlZoD8DO8BQpNFCAANZGP4qIradYndE3keOQaZQ3oIXoMVhc49hFI/VtoXZ9DmdwYptp0IGoeUJjgT2sJIrduoA4cUV8CPI1JMd11ijnXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66574015)(33656002)(4326008)(8676002)(52536014)(8936002)(53546011)(186003)(26005)(2906002)(86362001)(15650500001)(54906003)(316002)(110136005)(9686003)(55016002)(7696005)(76116006)(508600001)(66946007)(6636002)(71200400001)(66446008)(64756008)(66556008)(66476007)(122000001)(38100700002)(6506007)(83380400001)(38070700005)(4744005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU1qeklPY1pRdnNzcjZoSGhFUmszQm95ZDUrd3o0WFFKb2xydkE2cnAxdjlz?=
 =?utf-8?B?MldpSkF5eWh4RVpMcm0zc0hLK1Bxa1BRZlRTWWlKRFloVHluMUJLZVRaUTMz?=
 =?utf-8?B?MTRhNUtpK2VOTUFCMWVsRFpQd2xhcWJlcWM5bmk0dXQzUUZ1TjhHZXpXY2ph?=
 =?utf-8?B?UGdUQTJ0MEF5cm5HT0ZQNSt1amUveE9XSHZwR09sNmJvQ2VlNEJVTmxZNFJq?=
 =?utf-8?B?WmJjSWtDSVNvYWRycS91cUpDcGZpWlpMdEI0S3gvTGJ2cGVSN0VIK3JOK0cr?=
 =?utf-8?B?YU5sZTltbGdEdFRFNnpXMDNZQmh6Yml4Qm43UUN2RXlNRW1LZEQrdDBhQ1cw?=
 =?utf-8?B?U0s0SENCRnA1NHJmV3hhd1kxa0lFTmMwYk9VQUdZL05HN2lTZ0lBU3RIUGZn?=
 =?utf-8?B?K1VxYWh3QWtnQXFvYmpJZVV3MHBjVVRCa3lIMXl4d082QnNLUGsxVUVMRWU5?=
 =?utf-8?B?K3NFckZmejJqQjdkVU1Vd3hhTmdLSkFhMFdtVVVBOWtvb0tDN2ZWS29wY2FT?=
 =?utf-8?B?bDdIbGZKU2FuUk9NaFgvQ08yNUJmQmlydzk3TUtVcWVCQjNjNTFkN3lvZDJD?=
 =?utf-8?B?ZFhuRVVybGZmQWRwQmxURnFvdXBJMnprRUtFeVVRMkFYOVdsTnFwbzBjSC9Q?=
 =?utf-8?B?MWx6WEFWcHNwYTJGM2RuNlBQRGVOSHJpWEw0alVVYkFyTWRORmxkNlFkeUJ2?=
 =?utf-8?B?dkpCZFB3YXVLVVJxaUw4ZW5BSFRCYWJ3S3JISU9zUFlCR1pRVnVrU3NtSjh0?=
 =?utf-8?B?ckhNdUxQaUhoYUZFOHA5NkRFV09zUHRWZzRzVkZRbEVyOVZEZU1hazcycXkw?=
 =?utf-8?B?UnVXTjhiM0docStLYWV6MFhpMXpYQ2g3bTMwWTVrZWczQUQ2bGRiT1R1M0M5?=
 =?utf-8?B?bHZ0ZWhLeTJWemJ1b2Uya0Vsc2dzUFd6NUxxSXgrdWw0dHpzdkdZME1uMzhv?=
 =?utf-8?B?UWlHdmZYb2VDcmo0UWxHRnNxZWN4c09JMkxNTGN5NkE2UkU2aEl2cjRBeVNY?=
 =?utf-8?B?cGlYNHk5MGw0RlNNM3JsbHd5ZmFVWG1TdFVjRUJaM1ptU054YXhQRHJSRVFM?=
 =?utf-8?B?NW9wUUYrZnc5b1ExQkk4NmVsMXFCSmNFZlVMU1FWMk1qY3QwOFpzLzdiQVdM?=
 =?utf-8?B?bkVmRkFnRkpva2l6U1NwN0pNQ3d0UCtLQWdnK3VQWlVKTnpvSGVDZnRQUEJI?=
 =?utf-8?B?OXpCK3FuWUVxakJpeWtvSlhDazZYS1ErL0N0YzJPdlkvQloraUhFZzhqbWJs?=
 =?utf-8?B?YWp2d0pLL1R5bWxOQWZnc0kzOVlFQUdFTVlhUzVzc0lwc0RIK2pJNzZvaGZB?=
 =?utf-8?B?UFYxM2JwV1JIS01XZE9XVUhTaG1mTkROWXlnMlpHdGdoQ1hmOWd3aGlXa2o3?=
 =?utf-8?B?NXNxSElQczVSaVloaEdLZUhOWmVURTJvSGpITElndmtkMldXeUVmdFN1Z3NF?=
 =?utf-8?B?dklNcmRCYkFDRC81TFB5dUI2ZUJLalh1QzNXUTJDL0tlUysyWDFneW5aR1dP?=
 =?utf-8?B?WjBZeDhzSWJjQWdvSWNLdjdCU2dDUDV6MU84emdTUk1xRW1SdU1EVTRpZGpC?=
 =?utf-8?B?SHdhVnFjQStnRjF3SUJHYkc3UG1KVEs5bllVdWVFNWV6cXdZV1lPRllkaDdn?=
 =?utf-8?B?OTFYUUxHbjlVUVYwb285Q3VTSVVZR2hxZUZFMi85TEtCU2dVSnp1V251ZWJp?=
 =?utf-8?B?QWFxVXVCZGpUdm5aSHdFaVFGd1dXL0o1aW1RQUN4SlJDSHUvQ0Uza1R5STI0?=
 =?utf-8?B?a3Uwd1VvUXIyeVZmMTd6RlBJOVVoNXA4RXpNeUV3NFNYY1JHOVRmMStxVlRE?=
 =?utf-8?B?SEdxU3pzSFY4M3BVM2EyTll5Zmc2cGJCSkJ4V3g1aGZNUEsvU3owWjJZdUdO?=
 =?utf-8?B?YWdsamtQL1ZJa3JQbUZrLy9wd2pzYkRLRUdyMXVySlJzU0xoTTIvcDZOMURK?=
 =?utf-8?B?ajcxNnpoUmJLODkyMGkyakxFQlJ1TTU1SkZZSHZLZjQ0ZmdoempHdlpyRlJK?=
 =?utf-8?B?eXhzWkhUa2lRZGpKVWZ6ZEdJa0pjcGVuYW00eXF6SXM4K1FtV1BLSFQ1YXha?=
 =?utf-8?B?WGEwT1hsTFArVitXUExKL3ZGK3lzV2Fna1RaQ1J6T0FkZFVFV2UwNG1TdEF0?=
 =?utf-8?Q?BrXA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958bda1c-3049-4176-9150-08d9adc3a951
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 14:23:31.8080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SH+B5WIe13xuI1imKKsdZ0hmXC+RWoJUwZhLMM/Q4wCR5McgOptV+5f+RVT1hqJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2958
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
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAx
OSwgMjAyMSAxMjoxOCBBTQ0KPiBUbzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4N
Cj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENo
cmlzdGlhbiBLw7ZuaWcNCj4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPjsgTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsNCj4gSHVhbmcsIFJheSA8UmF5Lkh1YW5n
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiByZXNldCBhc2ljIGFmdGVyIHN5c3RlbS13aWRlIHN1c3BlbmQN
Cj4gYWJvcnRlZA0KPg0KPiBPbiBUaHUsIE5vdiAxOCwgMjAyMSBhdCAxMDowMSBBTSBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFtQdWJsaWNdDQo+ID4N
Cj4gPg0KPiA+IEJUVywgSSdtIG5vdCBzdXJlIGlmICdyZXNldCBhbHdheXMnIG9uIHJlc3VtZSBp
cyBhIGdvb2QgaWRlYSAgZm9yIEdQVXMgaW4gYQ0KPiBoaXZlIChhc3N1bWluZyB0aG9zZSBzeXN0
ZW1zIGFsc28gZ2V0IHN1c3BlbmRlZCBhbmQgZ2V0IGhpY2N1cHMpLiBBdCB0aGlzDQo+IHBvaW50
IHRoZSBoaXZlIGlzbid0IHJlaW5pdGlhbGl6ZWQuDQo+DQo+IFllYWgsIHdlIHNob3VsZCBwcm9i
YWJseSBub3QgcmVzZXQgaWYgd2UgYXJlIHBhcnQgb2YgYSBoaXZlLg0KPg0KPiBBbGV4DQo+DQpG
b3IgdGhlIEdQVSBoaXZlIHJlc2V0IGluIHRoaXMgc3VzcGVuZCBhYm9ydCBjYXNlIG5lZWQgdHJl
YXQgc3BlY2lhbGx5LCBkb2VzIHRoYXQgYmVjYXVzZSBvZiBHUFUgaGl2ZSBuZWVkIHRha2UgY2Fy
ZSBlYWNoIG5vZGUgcmVzZXQgZGVwZW5kZW5jZSBhbmQgc3luY2hyb25vdXMgcmVzZXQ/IEZvciB0
aGlzIHB1cnBvc2UsIGNhbiB3ZSBza2lwIHRoZSBoaXZlIHJlc2V0IGNhc2UgYW5kIG9ubHkgZG8g
R1BVIHJlc2V0IHVuZGVyIGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA9PSAwID8N
Cg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IExpam8NCg==
