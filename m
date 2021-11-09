Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD55C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 08:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23228611AD
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 08:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23228611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3FF6E8B0;
	Tue,  9 Nov 2021 08:52:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B157A6E8B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 08:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwW+2Rr3go1oCSWXfa+I8ZnZgtIcamJU0njpOPbfuD2RxOncizrq6Dtr6jaPMvqxHD27IcUa2jAyTTQCDKNJe/aZuyt06rY2R9EgnFjujx8A+rtfHX2/1EhDy0kUmJ7D3UlaCy2RFknqF797/Im0/w1Cuz23ZPmV9/1rtKfopjSTwiAjvCIoTyeenQyDmwrtgCQY2bCfxvylVDkd3cwwb8fREaSn7wPX+Li6MIr/CgajVuOiZCFIStIKNmTgLRnpROCKzQY1MP3UNxz0EIOPJbKLp5W+2bwduMEcPKFdgSR7C4YxevqJfPutb7U/9CcVVocUw8olrveFBc5/wR7b0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXe5YEF6v6gppMyiq1/gE73813CLbEUJE1atDrN6qds=;
 b=SN2QBNLHrqvJEsR9EBBzi/emAp5DSykakj/YNAoF4w24Ccuw5wDrVvuZXnj163ULswsQbbesaV2iFkHY5HOtzqDDxJ1b3+L7pDgYwjOhkuh2Jjyfs2roKcumaxStBU5JAIWGfU4VI/z5DI9Uems9HJGAQ5KvMfZFjb4HWKZYrty0oYJ0MT+zDv5C3thKrog3iiWKyJGUN+SYw1/k1BRsMYJCPEodETO2Xg4O8UqV8MADqT+FK+XZWumkLh2A/nQDJyorwStoEcGn2Bp+Mif6HncXYUzdAcpVSyMMwwMXkDs6CjFyE4gTY8U2tFyyw4v108SsSWLz3Ca/b8kZ6bxBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXe5YEF6v6gppMyiq1/gE73813CLbEUJE1atDrN6qds=;
 b=UBN8/3L3fAufJqiXPNNvAYgycsUdylez5OTbbs7ivkpR3T38iHwZ62vdKORbT6luBHja0Kwl8M94ehIBnqCL1PtPTKxbo2sTpcyS43WCcXjHNewPiT4YqZ69eJCUpkvbzLTr2x8eUdwKsufgPNWWZf0eMxh0ksjqbmE1enkDlts=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2827.namprd12.prod.outlook.com (2603:10b6:5:7f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Tue, 9 Nov 2021 08:51:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 08:51:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Borislav Petkov <bp@suse.de>, Paul Menzel
 <pmenzel@molgen.mpg.de>, "Liu, Leo" <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Topic: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Thread-Index: AQHX1FvEu+OweiWVMEOG0w2/0y3AtKv5Us2AgAAoOYCAADIkAIAAB3mAgAEWLgCAAANYAIAAFa1w
Date: Tue, 9 Nov 2021 08:51:57 +0000
Message-ID: <DM6PR12MB26199372E655E754DBCBEC83E4929@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
 <YYkGteomN5Cbh1+C@zn.tnic> <3800b659-f0cb-2565-c525-91b5b34d1a30@amd.com>
 <d35eca15-df36-5885-ca31-a1bd50f09fdf@amd.com>
 <a1bfc35c-c987-38b4-e7b7-16c9b9295635@amd.com>
 <00fc5d97-5228-1935-a544-91f2a9b1b803@amd.com>
In-Reply-To: <00fc5d97-5228-1935-a544-91f2a9b1b803@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-09T08:51:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f714ebad-56c5-443a-9e81-15310895c64d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8671f10c-a267-4d70-107f-08d9a35e2fe4
x-ms-traffictypediagnostic: DM6PR12MB2827:
x-microsoft-antispam-prvs: <DM6PR12MB28275EB208948F9640EAFD09E4929@DM6PR12MB2827.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+xIb3ZYi14o8pdQzwYDCSOSxXKbF9ZVXVkJ9oz5IEMqaJVt9d7Qhr1wp8JENkyuBd1x7hAunI0jzIYDdK78bxkM3xxauq0NMhg+OcKKKTtKqxX2hiD0ZZly3ImLcPW2A8KgBYnY5nQ+ZESzsTHuK7xNGUp/m7IBpFDK4C4VTp8jLek4AOCnKY5n5DKzMgH+ps23r/hnDET4N11iy6zF9PI8X7U5HVJQCbYN9sCXYDeT0HMaG7iPhRIuYqeSKKFXe+cLWH7mnR07vae0rRMwfMR6msKbyG0YonCgv2x5heGfkTYzi5NH7zBtxoWgin4nj6RPnZtoQiTF8GvXpnLjsxGJ/ySJdARqY1Gqy1oz4uO2P0H4fkV3paiy1t2Qn4DFdiBIC7tHIOYik8LcWwgvsTUi4hVBXFCZZtADSZ+yXWhbNTJXsJlwLfYYEUokiVS3spvawcsrirRaBJmSe4P3UUjevPJdfhxEMADB5PYjPXOf+bOZMxVfud2HRiluF2nhLXt+YZletOpeS22X8chIBi5zgEoESRLmqiMICdxQKyImBJW/Cs6nGU1fh12yePq2x2aRAoewaMDqRShvraFLGuqeOdTGKn278IKbOZMjyZzz0o+vLKWGIZMRQjNNQpUFLhyq9S9qo3Coxe2JDx78Xfa9hE5JofTDSNgg4JPqZaDf+VWT9/WjKJZsfge0+m0tnt1bRmHpJKyjF8280xW6R6d0UP18t6V+N8jps508I3P3/1Dx4RgEa17/zwdwFRaSGdHDR7ZqhSUXBcRbbWxeH9oR5njh0MOoQulj9qE6m1E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(316002)(66476007)(66556008)(64756008)(86362001)(52536014)(54906003)(8676002)(2906002)(7696005)(66446008)(76116006)(110136005)(38100700002)(38070700005)(4326008)(66946007)(966005)(9686003)(71200400001)(26005)(55016002)(122000001)(6636002)(66574015)(83380400001)(508600001)(6506007)(53546011)(33656002)(8936002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejloYTBlTVI4U3JrQWlqaUFwOG5RMEM5UmxEUjk3emp2WnZESDRyT05Lc2hs?=
 =?utf-8?B?WHF5ZHV1ajlBTVdGamVIbU5aVVk3NGh2bXR2N2RleGFoQmxLVndQSWgxNVA5?=
 =?utf-8?B?N1ZhSWFYR2xVRm83N0tTN2JGZndkRUVXZTV3d0ZpNnR3a1JXSEVxTWFwMmF1?=
 =?utf-8?B?OFU0RkRObUQwTklTOHh2M2lkRzdTSzRVYnFOSUhjNGg3dkZXTDh5YXpSYmFI?=
 =?utf-8?B?MzFqbC85NWFpcnBQVnViTFM0MXgxSlF5SHdrK3g4Tk1ZOWJRQ05LZU8yTnAr?=
 =?utf-8?B?RUhLUFRLanhFcVJ0WUVoNEN0KzVzT08vUzhvVjN5MHZGbGRJQ1A2YkRoVGtW?=
 =?utf-8?B?UDhPQVlBdUpIbXd6VDRjRU5kaVNSdTBDNW9qa21IMDhqMFdqQ1pkR2Y3azBQ?=
 =?utf-8?B?eTVWYitpc2RxcVBnSWdQR2tNRyt6UERLUTdOdXpuR3pxWC9rQWFUenZGeUhS?=
 =?utf-8?B?VktnTFNvZjh5UGwwdGNnVUpZRXZ2dHpTOWhadUkyanRGTWN2aFdQZDNqSEhU?=
 =?utf-8?B?OXZXZ0twVkhMdWdBVElDQ1A2Q2lkdENSdGRkVEI3c0dEYkpFbTA2dHdwRlVu?=
 =?utf-8?B?TWpjUFJZU3JZMGxGRFRFdkpqZXZqMUlvR0F4MjY3bUVnODd1TUZhZDNOaU9k?=
 =?utf-8?B?UTBtTTFWbHdhbi9kQURjM3ZQWk9McUJuU3RqdmdxS2c2NGRFeVpuajJ6dmNv?=
 =?utf-8?B?ZEZsVVpBdk5LRUhqa203eTQyS1VCR1FiYkU4c2pGTGFDZjRCWjRhRjF5VS95?=
 =?utf-8?B?TjlRblErYjVnQnNHaXJoY2R1RGZycjNTSXZETVorRDBZU2tXSmZQSW5Zd2hI?=
 =?utf-8?B?alJVK0dycFVBSHlyKy80bTdZeWNHM0RSeHhTUmorQkN2ekVsSVhwd01LZWdm?=
 =?utf-8?B?TDg0SjNwcTh6SS84d1BpMEpHUlZ0Zk1ZY2VmL1RPZlJoRGhFUHQyOGxHZVNX?=
 =?utf-8?B?OWlxZEFVL2NuOE4xYmJWVTlhZUo2MUNPOUllSk1OMklWSTNXdHlvK3FaUCsr?=
 =?utf-8?B?NVAzbUt4YVpEVTZRRVo4OHRQV1NNL0xJVUxNN3hzK1VpbUJCdGJtY3JTVFBh?=
 =?utf-8?B?ekJocFZZT0R1YUM5Z0l6eDRDOU54ZE1zRHY1NEdOTDdqQzZGWDNvK1hWQkc3?=
 =?utf-8?B?b1Rub20wWUF5dFVJRUplMFRGTXFTUkxBazdNNHdCUC9kWHdtTUppcXdVbWlj?=
 =?utf-8?B?U25reDNCOEtmWVpONVhBNHdQZ2hsZGFnY1pwTXlaTzY1Wm0yM0JuRUpJcU81?=
 =?utf-8?B?M0YrK2ljdloyTDF2NEpjSmdhd1hpbS9JVVBIS3hTT2RiQ3pXR29RL3dVRnNp?=
 =?utf-8?B?YWFieWphOFc1dDkzTGRtVmo4bUdLdG1SbUtkSjVuTmlvYzk4b3V6eG1lSjh6?=
 =?utf-8?B?cFY1N0UxN1gzSnoyTFZLU01GdnNyenMrUmxZdTQ0MTBoR3lzTGxDb0QyaFJH?=
 =?utf-8?B?ck5LNVJEMjh3dG95MkVESzRiOE9QUWs0WnhZU1hUS3dKbzhxMGtTcCs2Yk5L?=
 =?utf-8?B?MUZ5YU9scXV3VWQwQlBwMDNIbG5VM2J0bzlxbytUUis0cDI2bm9QS0dSZGJ3?=
 =?utf-8?B?aFNDQmlJWjVNV1VWdUlvWGpFWURIbnltTXlLcUdEekF1MXV6aTRxQ0dnY1F3?=
 =?utf-8?B?RkFPU0M2RjViR09EMndwNi9LdWtZQ0FNYnhPOVdqN0lPaWFRTDYzSGczNW1m?=
 =?utf-8?B?SDRrSFVDbEY3eVB5ZTdpWXl1QUJjRzEwN0pQYlMvSU1LaExicVA5ZmRDZC9l?=
 =?utf-8?B?V29vU0VneGVxTWRkcGpoMmlqT0pKYkNaT2R5R0RNdXFnczU5V0xxVnBxOXlU?=
 =?utf-8?B?NUNnbkNJUjN0QlRFZ0UzMTY2VGJxTFdZaXZ3N2hScWowWDVaOWVHaUZlNHdk?=
 =?utf-8?B?cVdhdWJVWHRtdEVzZW1jU0JvUHZsZXdaNHc1VlN3UitYbDhJM0syRlFWV0VE?=
 =?utf-8?B?d2k0Y0VOc1RtVVIwUEduanJuVlJaa3RhSk1nenRUamlvRDhwZTg2TWV5cnZ2?=
 =?utf-8?B?dUpGbDRFNVBxOWZ2UkN2bVBDVlpWRHU1clUrYmVCQXc0bGJ3eHRIUFdLZWZD?=
 =?utf-8?B?OFFMU3dyeW5Yc3lUK2dSSEJOSitCcGpNMFdNdnBrSXdrTVUrSlltZGFPNTNS?=
 =?utf-8?Q?hdDk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8671f10c-a267-4d70-107f-08d9a35e2fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 08:51:57.4855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhlBdEmOXmHcqtXpxQHz4KP15EEK7z0f1Zl6SIR3oGZJKNgIcW6be0jIxSNnVHYB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2827
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgTm92ZW1iZXIgOSwgMjAyMSAzOjI5IFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgQm9yaXNsYXYgUGV0a292DQo+IDxicEBzdXNlLmRl
PjsgUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT47IExpdSwgTGVvDQo+IDxMZW8u
TGl1QGFtZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBRdWFuLCBFdmFuDQo+IDxFdmFuLlF1YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IGF2
b2lkIGR1cGxpY2F0ZSBwb3dlcmdhdGUvdW5nYXRlDQo+IHNldHRpbmcNCj4gDQo+IA0KPiANCj4g
T24gMTEvOS8yMDIxIDEyOjQ2IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiA+IEFtIDA4
LjExLjIxIHVtIDE1OjQxIHNjaHJpZWIgTGF6YXIsIExpam86DQo+ID4+DQo+ID4+DQo+ID4+IE9u
IDExLzgvMjAyMSA3OjQ0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiA+Pj4gQW0gMDgu
MTEuMjEgdW0gMTI6MTUgc2NocmllYiBCb3Jpc2xhdiBQZXRrb3Y6DQo+ID4+Pj4gT24gTW9uLCBO
b3YgMDgsIDIwMjEgYXQgMDk6NTE6MDNBTSArMDEwMCwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+ID4+
Pj4+IFBsZWFzZSBlbGFib3JhdGUgdGhlIGtpbmQgb2YgaXNzdWVzLg0KPiA+Pj4+IEl0IGZhaWxz
IHRvIHJlYm9vdCBvbiBDYXJyaXpvLWJhc2VkIGxhcHRvcHMuDQo+ID4+Pg0KPiA+Pj4gVGhhdCBk
b2Vzbid0IG5lY2Vzc2FyeSBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYSB0byBtZSB0aGVuLg0KPiA+
Pj4NCj4gPj4+IFdoYXQgZXhhY3RseSBpcyBnb2luZyB3cm9uZyBoZXJlPyBBbmQgd2hhdCBpcyB0
aGUgcmF0aW9uYWwgdGhhdCB3ZQ0KPiA+Pj4gbXVzdCBmaXggdGhpcyBieSBhdm9pZGluZyB1cGRh
dGluZyB0aGUgY3VycmVudCBzdGF0ZT8NCj4gPj4+DQo+ID4+DQo+ID4+IFJlYm9vdCB3aWxsIHRy
aWdnZXIgYSBzdXNwZW5kIG9mIElQcy4gQXMgcGFydCBvZiBVVkQvVkNFIHN1c3BlbmQsIG5vdw0K
PiA+PiB0aGVyZSBpcyBhbiBhZGRlZCBsb2dpYyB0byBwb3dlciBnYXRlIHRoZSBJUCBhcyBwYXJ0
IG9mIHN1c3BlbmQNCj4gPj4gc2VxdWVuY2UuIEluIGNhc2Ugb2YgVVZEL1ZDRSwgcG93ZXIgZ2F0
aW5nIHdvdWxkIGhhdmUgYWxyZWFkeQ0KPiA+PiBoYXBwZW5lZCBhcyBwYXJ0IG9mIGlkbGUgd29y
ayBleGVjdXRpb24uDQo+ID4+DQo+ID4+IEluIGFueSBjYXNlLCBwb3dlciBnYXRpbmcgaXMgZG9u
ZSBieSBTTVUgRlcuIFRoZSBhc3N1bXB0aW9uIGhlcmUgaXMgLQ0KPiA+PiB0aGUgbG9naWMgdG8g
cG93ZXIgZ2F0ZSBJUCBjb3VsZCBpbnZvbHZlIHJlZ2lzdGVyIHByb2dyYW1taW5nLiBBRkFJSywN
Cj4gPj4gYWNjZXNzaW5nIHNvbWUgVVZEL1ZDRSByZWdzIGR1cmluZyBwb3dlcmdhdGUgc3RhdGUg
Y291bGQgY2F1c2UgYSBoYW5nDQo+ID4+IHVubGVzcyB0aGUgYW50aS1oYW5nIG1lY2hhbmlzbSBp
cyBub3QgcHJvZ3JhbW1lZC4gVGhhdCBtZWFucyBlaXRoZXINCj4gPj4gRlcgb3IgZHJpdmVyIG5l
ZWRzIHRvIHRyYWNrIHRoZSBzdGF0ZSBvZiBJUCBiZWZvcmUgYWNjZXNzaW5nIHRob3NlDQo+ID4+
IHJlZ3MgYW5kIGluIHRoaXMgY2FzZSBwcm9iYWJseSBGVyBpcyBhc3N1bWluZyBkcml2ZXIgdG8g
YmUgcmVzcG9uc2libGUuDQo+ID4+IGkuZS4sIG5vdCB0byBjYWxsIHBvd2VyIG9mZiBhZ2FpbiBp
ZiBpdCdzIGFscmVhZHkgcG93ZXJlZCBkb3duLg0KPiA+Pg0KPiA+PiBUaG91Z2ggdGhhdCBzZWVt
cyB0byBiZSBhIGJhZCBhc3N1bXB0aW9uIG9uIHBhcnQgb2YgRlcsIGl0IGlzIHN0aWxsIGENCj4g
Pj4gcG9zc2liaWxpdHkuIEhhdmVuJ3Qgc2VlbiB0aGUgYWN0dWFsIEZXIGNvZGUsIGl0J3MgYSB2
ZXJ5IG9sZCBwcm9ncmFtLg0KPiA+DQo+ID4NCj4gPiBPayBndXlzIEkndmUgZG91YmxlIGNoZWNr
ZWQgdGhlIGdpdCBoaXN0b3J5IGFuZCBmb3VuZCB0aGF0IHRoaXMgaGVyZQ0KPiA+IGlzIG5vdCBh
cyBpdCBpcyBpbnRlbmRlZCB0byBiZS4NCj4gPg0KPiA+IFNlZSB0aGUgY29kZSBpbiBxdWVzdGlv
biB3YXMganVzdCBhZGRlZCBpbiBBdWd1c3QgYnkgdGhlIGZvbGxvd2luZyBjb21taXQ6DQo+ID4N
Cj4gPiBjb21taXQgODU5ZTQ2NTkyNzNmMWRmM2EyM2UzOTkwODI2YmNiNDFlODVmNjhhNQ0KPiA+
IEF1dGhvcjogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCj4gPiBEYXRlOsKgwqAgVGh1
IEF1ZyAxOSAxMjowNzo1OSAyMDIxICswODAwDQo+ID4NCj4gPiAgwqDCoMKgIGRybS9hbWRncHU6
IGFkZCBtaXNzaW5nIGNsZWFudXBzIGZvciBtb3JlIEFTSUNzIG9uIFVWRC9WQ0UNCj4gPiBzdXNw
ZW5kDQo+ID4NCj4gPiAgwqDCoMKgIFRoaXMgaXMgYSBzdXBwbGVtZW50IGZvciBjb21taXQgYmVs
b3c6DQo+ID4gIMKgwqDCoCAiZHJtL2FtZGdwdTogYWRkIG1pc3NpbmcgY2xlYW51cHMgZm9yIFBv
bGFyaXMxMiBVVkQvVkNFIG9uIHN1c3BlbmQiLg0KPiA+DQo+ID4gIMKgwqDCoCBTaWduZWQtb2Zm
LWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+ICDCoMKgwqAgUmV2aWV3ZWQt
Ynk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiA+ICDCoMKgwqAgU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+DQo+
ID4gQmVmb3JlIHRoYXQgd2Ugd2hlcmUganVzdCBub3QgdG91Y2hpbmcgdGhlIFVWRCBwb3dlciBz
dGF0ZSBhdCBhbGwNCj4gPiBkdXJpbmcgc3VzcGVuZCBhbmQgc28gd2Ugd29uJ3QgaGFkIGEgcHJv
YmxlbSBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+ID4NCj4gPiBTbyB3aGF0IHdlIHNob3VsZCBkbyBp
bnN0ZWFkIGlzIHRvIGp1c3QgcmV2ZXJ0IGNvbW1pdA0KPiA+IDg1OWU0NjU5MjczZjFkZjNhMjNl
Mzk5MDgyNmJjYjQxZTg1ZjY4YTUgd2l0aCBhIHByb3BlciBmaXhlcyBUYWcgYW5kDQo+ID4gZXhw
bGFuYXRpb24gd2h5IHRoYXQgaXMgYSBiYWQgaWRlYS4NCj4gPg0KPiANCj4gWWVhaCwgcmlnaHQu
IElmIEkgcmVtZW1iZXIgY29ycmVjdGx5LCB0aGlzIGNvbW1pdCB3YXMgb3JpZ2luYWxseSBhZGRl
ZA0KPiB0byBmaXggaGFuZ3Mgd2l0aCBTMyBzdXNwZW5kL3Jlc3VtZSBjeWNsZXMgdHJpZ2dlcmVk
IGR1cmluZyB2aWRlbw0KPiBwbGF5YmFjay4gUmV2ZXJ0aW5nIGNvdWxkIGJyaW5nIGJhY2sgdGhh
dCBvbmUuIEV2YW4gd2lsbCBrbm93IG1vcmUNCj4gYmFja2dyb3VuZCBkZXRhaWxzLg0KW1F1YW4s
IEV2YW5dIFllcywgODU5ZTQ2NTkyNzNmMWRmM2EyM2UzOTkwODI2YmNiNDFlODVmNjhhNSBhaW1l
ZCB0aGUgaXNzdWUgYmVsb3cuIEl0IGNhbm5vdCBiZSByZXZlcnRlZC4NCiJJZiB0aGUgVVZEL1ZD
RSBpcyBzdGlsbCB1c2luZyBvbiByZWJvb3Qvc3VzcGVuZCB0cmlnZ2VyZWQsIGlkbGUgd29yayB3
aWxsIGJlIG5vdCB0cmlnZ2VyZWQgYW5kIHRoZSBhZGQtb24gcG93ZXIgZ2F0ZSBsb2dpYyBjYW4g
aGVscCB0byBwdXQgdGhlIElwcyBpbnRvIGNvcnJlY3QgZ2F0ZSBzdGF0ZS4iDQoNCkJSDQpFdmFu
DQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4gDQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4u
DQo+ID4NCj4gPg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IExpam8NCj4gPj4NCj4gPj4+IFNl
ZSB3ZSB1c3VhbGx5IGFzc3VtZSB0aGF0IHVwZGF0aW5nIHRvIHRoZSBhbHJlYWR5IHNldCBzdGF0
ZSBpcw0KPiA+Pj4gdW5wcm9ibGVtYXRpYyBhbmQgdGhhdCBoZXJlIHNvdW5kcyBsaWtlIGp1c3Qg
dHJ5aW5nIHRvIG1pdGlnYXRlZCBzb21lDQo+ID4+PiBpc3N1ZXMgaW5zdGVhZCBvZiBmaXhpbmcg
dGhlIHJvb3QgY2F1c2UuDQo+ID4+Pg0KPiA+Pj4gUmVnYXJkcywNCj4gPj4+IENocmlzdGlhbi4N
Cj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBXaG9ldmVyIGNvbW1pdHMgdGhpcywgcGxzIGFkZA0KPiA+
Pj4+DQo+ID4+Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9ZVjgxdmlkV1FMV3ZB
VE1NQHpuLnRuaWMNCj4gPj4+Pg0KPiA+Pj4+IHNvIHRoYXQgaXQgaXMgY2xlYXIgd2hhdCB0aGUg
d2hvbGUgc3Rvcnkgd2F5Lg0KPiA+Pj4+DQo+ID4+Pj4gVGh4Lg0KPiA+Pj4+DQo+ID4+Pg0KPiA+
DQo=
