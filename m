Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C94C00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 09:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D46810E0E8;
	Fri, 29 Jul 2022 09:27:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6FA510E0E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 09:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU4Rc9r/EkisguubE7RBa7s5vrs3m7Yod9AlfMyrmwIC+Z/klU+yy58bm0HMke/HfwVNlo+ePNk/2KluFDQ/U0i3OwfIFk0RU3odXTmjTAEAnK/2+hhyRw5XE+QYA8AA+j7TBAjYzbIPsXhfUtZLBSOM7h3+1Z853gBI+2YMQDQqQ2/TCHcP/EmnWMtOdDSwuqF5p61kAFxxv7QwLBVeEjZIW6/jqF0M1JdCM/OcPeaCWPgEPIBQ+BQJsGyTImDzmVHGaYNy86ocaQQrZjv4JAuH+JfI2dpJisERIvH9aaZ6buBOh4NoV86SHMYfyzVbrYMq20ZmBtpwQRbNVe4DVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7d08BXZoU3rTmAVmJtqK5RPux4i6iVLYNhV8eiEbA+o=;
 b=P/JL3wNEUx5D6zzoNEleY03weF6flHQ/VZTBdpKSlA+W7QcccANqz1oC2+1z9yqOnBeJv8+XMwYVShOmda9pOFsUreikIvT98rIpX8Q3yRZJ5JZ32RK5x8GgtuoaAia4jILm4LRawH8Qf79exa6JXGQ2Nn/I3wb2NKdOz8w/Yw2bP41vQ7yXSrQH/+Hag80Lya9m667xyFFFMWRBZMvahxl1Axl8sAsWraDzbikmxfIx5SiCnRTcp8RqFgquLyizPLY62V8MV0Kcmp9s5ELsPZhVgxE3kW58git9TgbHYneIwkTYo+RJE+KLnwXo70shlaIxbBRDlTl63fFoprMMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d08BXZoU3rTmAVmJtqK5RPux4i6iVLYNhV8eiEbA+o=;
 b=iG9Ru2wswTMCKOx3QdS92N7d7xTjVbnsnvynrdt8PByazNbjD+TBUYrgoI0gcqw0vZGX7XY4jiwb/MLALVmq4GWOPMwKmBQmz8nM8Tux5JV3HkTHg4qjqSDCgh0mUt78ozdiz8CrBiPIyaQQcWZWLzWfHIzk9xIJ06gRSAABEOA=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB3292.namprd12.prod.outlook.com (2603:10b6:5:18c::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Fri, 29 Jul 2022 09:27:53 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f028:1155:8518:3fee]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f028:1155:8518:3fee%4]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 09:27:52 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 6/6] drm/amdgpu: reduce reset time
Thread-Topic: [PATCH v2 6/6] drm/amdgpu: reduce reset time
Thread-Index: AQHYom0be2dQsrCAL06hdfBMK+4uVq2U3yQAgAAw9pA=
Date: Fri, 29 Jul 2022 09:27:52 +0000
Message-ID: <DM6PR12MB43407E1407CEFA32AF3ED7D9FA999@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
 <20220728103027.27255-6-Victor.Zhao@amd.com>
 <8dd25904-dca5-a9c4-9c8a-567b3d8db7e2@amd.com>
In-Reply-To: <8dd25904-dca5-a9c4-9c8a-567b3d8db7e2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-29T09:18:41Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8fe29eb4-6f0e-478e-bc2e-2158d2368ed2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-29T09:27:50Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7fa55efc-8e16-40a8-b531-3fab77e5a031
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c8fe407-2303-44a0-731f-08da71449cd3
x-ms-traffictypediagnostic: DM6PR12MB3292:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cqJyC5aLLu5hlCO7tZv5A6yqaYoCHngiiyCklB+xZx8/Y7blRHqGT3K5ViLTkr5TeGgYl2Pg1tdtbPOP1HCbGrDKM2aI6vUfcfo7ApIRmVgS6yo8zM1gYXyvVys7neGmtKY0UDpfegXa0JemGym1DkdyW7Fj5h9RIblSa3AH9SiYHWpHk2qO2zsjXyHWEZXunhhrsAMIclva/RQvIQzeQYlZMl0uXFJhuzPPl1bHYXyADA1Cy5LpklxyDF+y7vlZcCqt2ao3/RvSMG5C2B3BQePQDTo4S+fS4SaDbZ0oMmHLgps/JqM53mkxDbMTQ8yt8x8Vf/gIajVt7sasknZOY/mnfUvzwe+0yKMnwTlCy50lgrpfPRorgYWj/v04NfxUhaSk0ezWdeUk7iD50XTFGLGfA3CieM8kWDcT9FojP+XfVkWSYBOB6T9qvmRxlVVIoT0xPsYe1En2IUZdWdn/Maf2klxETScqyF67YIiIrPM3E4/GREA1EKKpk0VATt0BLcNhASqgoTLgdrHh8K/12GDwn/w/vf3BAlFAl4r8l6RqGfOG4RsZvzsV1gMAUl00Tq4pWHsGCNWUBq+S97v8wrh80Msg5FuCVMeaP6bpwHpWhLnqVXC587B/EmYwbzWegAvT+8HBB0ai2jkBX/aEw+NY7v3NebB3SFMsmd+HfiW7iROSyCKN7URu3e1HuCrs22ICJSXpHl/a+e6OTSqKf4Manxkq7xjpkIdXS4IW5Wwpix1iLGIJ24+P3TpUycu9Ln9HjQUR2HPOT1yG4EQ5DIH6qva7Q8x03jLlS0xmbTTqE/KduZDp34XcZyl8eEya
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(86362001)(83380400001)(38100700002)(38070700005)(66556008)(66946007)(76116006)(66446008)(64756008)(8676002)(55016003)(110136005)(316002)(122000001)(4326008)(54906003)(66476007)(2906002)(6506007)(52536014)(26005)(8936002)(9686003)(7696005)(53546011)(5660300002)(33656002)(186003)(478600001)(71200400001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFdtamFUUXJGVmozSjJQcXlvWjF2Q2pVckJSVHU2SWU2YVk2WWVHYWNTOE5H?=
 =?utf-8?B?RkpiZWhnbml4YVRINzRPY1k2eitFNHdWMktiRW1TNTA1dURFbVpxM3NpYlV2?=
 =?utf-8?B?SVJXdVZ5MlBzemhQSjJzTmNFSnBScWlBZ1UvdGlGTVMwRDJYNXdSRjF2UVF0?=
 =?utf-8?B?ZENzUGN0OGlEcVlqcktGVDdjVThzckYrejZXUWdNRHllSlZHMURZdC9rYVJj?=
 =?utf-8?B?ZFBGMVJLTHNiRDFUL3Y3OXhaMmpZekd0ZEZsSThwMTNNSE1QUU1xcFUzTTUz?=
 =?utf-8?B?dHdXdmsvbUVOQmFvWlRKbmlzWlowUDdPajJ2QnJzTmRoRk80SmtDUmRyWmVL?=
 =?utf-8?B?SG9oZnhya2YwZ21pSk5IVklLNWhDWTJyWkUxWHBpbWlZU0E2YU5rRUtIZ3Zq?=
 =?utf-8?B?RUkwcWh0WHZwdG1ZRSsxazRNekNWQ1dLN091NzZOenRSSzV5eGcxOEY2eG52?=
 =?utf-8?B?UlNLQ3JZMm1ienRFYmlRZGdpT21HbTNrSGcyN2ErMTByTTVmR1MzS3BtNzQ3?=
 =?utf-8?B?QUNxOTBheDFkbW1NaW1PUTEvUUdBWFpUdlplelRILzYrZHpFSjVXS052b3Mv?=
 =?utf-8?B?bHBhRXg3WFd0WEJoRDk1YU5nNjdPT2VEN09nNGR3UVZEZURxWUU2K21SN2U3?=
 =?utf-8?B?bzlHam02NkR1VXZIclBBUzZleURqR2pHRS9vYnZ0c0dEYVJSQjdZUGRGM1dE?=
 =?utf-8?B?akV5bDlHZnVjdE5uTERaeXNrYkNGUU1US1NMZzNLR2pOVGFETFZ2aStrcVpU?=
 =?utf-8?B?NHUvTGlseG9qRlhhNGtHS01OUU9USGtQN0E1cFU5eWJLOTZLMmcva0pFckpC?=
 =?utf-8?B?NlpETHdRa3ZJK2hkSWN5YVlGRHh3QzVyTFc2TXZUdVRlTE1xRmFKVjMzcWdm?=
 =?utf-8?B?Z3pFSmU1ZWdEclk0SE5lMjFNbUdRYVVCS0VQN1d5TWR4YWVaMG8vdHFVSDdI?=
 =?utf-8?B?YU1FYTRQQ0NOeVh1dDdXL0JKdkl5Rm9PWFN3Z2pTakM4TnRwVHppdC9zWTNa?=
 =?utf-8?B?blY4UUk3eHlQNm5zejdrd2dlYmpsSzAvay9xOFhkVDhJSjI5a045UTk1cEVY?=
 =?utf-8?B?TXk1djFCdHNZanYxcDdrNXJPK3B0YnpnZzdGWTZ2TFdaeTQyc3JPbFo1NVR6?=
 =?utf-8?B?dnpuL1h1NGdJeGZDNnB3TXlBemUxMGdmZk5MeFVTd0JZYVhWVzJoTG8xaith?=
 =?utf-8?B?ZmQ5TUhmakorc2F4eHlUVHQwZjl5QXhlb1JMTXlWOTVaMyttR2psQ2RyYUNZ?=
 =?utf-8?B?ek1pdU1XUHdMY3JvNzhaU25yRnZMOE9VZkwreVlRZUJIN2JrL0ZGRFM4d3Iv?=
 =?utf-8?B?RC9nOFJ0Tmd6bmNoV2FYUzJ2QmVIT05Nc0ZEdXhDZTBWS2cvY1pvSXZISVZp?=
 =?utf-8?B?UmErL1pnOG5meGI5MjI1ZFY5bjhSM2Q5WVdTNVVlNUJmV2JEd0hGVkswenRM?=
 =?utf-8?B?S0tjQkVCN205dkY2ckFucHJWcHNLdDcyMlM5VmxwZzVxcHpuQmx6RGNsdnhF?=
 =?utf-8?B?d05uUStYb1Jpd1lMS200N1liUjFMUjM0VlRNTFpBY2JFcGVqWmxIOFNTeHh6?=
 =?utf-8?B?VEw1a1FycStPY3hsVzRqM3F5VUUzaTZGQkJxM1JoU0FuZmVuRW5iNDkxUU9X?=
 =?utf-8?B?WVJSYVlLcmFEV0F3clpEbFQrelpJdDc2YXJGZzA0VzY5VjEwMjdNeUhiQkVY?=
 =?utf-8?B?TWI0d2F2SUJhWGFjeldocnJzc3BQb28yd2lDSUs5bFIxWlNzZ2t4c3QxVW85?=
 =?utf-8?B?OEtITnhvKzhCZ2kwTDR2ZUJvYmpVSEpOYkhiKytwNzFObEF0OGdXUDJPaEl1?=
 =?utf-8?B?STJoZXF0OVpCa0xqVCtYdi9pTzA2MlArWm45SEgva3BiRDRkT1RVRGZEQU5J?=
 =?utf-8?B?dDVzU1o4aHRoSjVkdHNIRUI1eGY1TG9vR00yU1JWR2J2VUhYVWs2a2UrTkYv?=
 =?utf-8?B?UDMwTTk2MXQ2eUVxa0dvMDBVeXh2WUdkYWJaaVZ1RWN0NUs1THlmZXlaNzRT?=
 =?utf-8?B?ZHRvekw4ZVczd3U1Q0dwUDJ3RzRqQy9pR1RaMVQ5bnp3cktWZUlHaUxFUk8r?=
 =?utf-8?B?eFNwbWtWcDVOWFlGY3Fud0VPbGtZOWdYdXhVaVM2T2NTQWtQTVI5RlcrUVVX?=
 =?utf-8?Q?JFOI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8fe407-2303-44a0-731f-08da71449cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 09:27:52.8539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06uoX6s52ln01d3oy4RWxRzq6gLVFJC/0ABqPHocinUWve6r2fOgiUJAHUwdWwUr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3292
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIExpam8sDQoNCkNhbiB5b3Ug
YmUgbW9yZSBzcGVjaWZpYyB3aHkgb3RoZXIgZ3B1cyBjYW4gYmUgYWZmZWN0ZWQ/IEkgZG9u4oCZ
dCBoYXZlIGEgeGdtaSBzeXN0ZW0gb24gbXkgc2lkZS4gSSB0aG91Z2h0IHJlc2V0X2RvbWFpbiBp
cyBwZXIgZGV2aWNlLg0KDQoNClRoYW5rcywNClZpY3Rvcg0KDQoNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+IA0KU2Vu
dDogRnJpZGF5LCBKdWx5IDI5LCAyMDIyIDI6MTEgUE0NClRvOiBaaGFvLCBWaWN0b3IgPFZpY3Rv
ci5aaGFvQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERlbmcs
IEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBHcm9kem92c2t5LCBBbmRyZXkgPEFuZHJleS5H
cm9kem92c2t5QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDYvNl0gZHJtL2FtZGdw
dTogcmVkdWNlIHJlc2V0IHRpbWUNCg0KDQoNCk9uIDcvMjgvMjAyMiA0OjAwIFBNLCBWaWN0b3Ig
WmhhbyB3cm90ZToNCj4gSW4gbXVsdGkgY29udGFpbmVyIHVzZSBjYXNlLCByZXNldCB0aW1lIGlz
IGltcG9ydGFudCwgc28gc2tpcCByaW5nIA0KPiB0ZXN0cyBhbmQgY3AgaGFsdCB3YWl0IGR1cmlu
ZyBpcCBzdXNwZW5kaW5nIGZvciByZXNldCBhcyB0aGV5IGFyZSANCj4gZ29pbmcgdG8gZmFpbCBh
bmQgY29zdCBtb3JlIHRpbWUgb24gcmVzZXQNCj4gDQo+IHYyOiBhZGQgYSBoYW5nIGZsYWcgdG8g
aW5kaWNhdGUgdGhlIHJlc2V0IGNvbWVzIGZyb20gYSBqb2IgdGltZW91dCwgDQo+IHNraXAgcmlu
ZyB0ZXN0IGFuZCBjcCBoYWx0IHdhaXQgaW4gdGhpcyBjYXNlDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBWaWN0b3IgWmhhbyA8VmljdG9yLlpoYW9AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jICAgfCAgMyArKy0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgICB8ICAyICsrDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmMgfCAgMSArDQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmggfCAgMSArDQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMgICAgfCAxMSArKysrKysrKystLQ0KPiAgIDUgZmlsZXMgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+IGluZGV4IDIyMmQzZDdlYTA3Ni4uYzcz
NWExN2M2YWZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2Z4LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5j
DQo+IEBAIC0yNyw2ICsyNyw3IEBADQo+ICAgI2luY2x1ZGUgImFtZGdwdV9nZnguaCINCj4gICAj
aW5jbHVkZSAiYW1kZ3B1X3JsYy5oIg0KPiAgICNpbmNsdWRlICJhbWRncHVfcmFzLmgiDQo+ICsj
aW5jbHVkZSAiYW1kZ3B1X3Jlc2V0LmgiDQo+ICAgDQo+ICAgLyogZGVsYXkgMC4xIHNlY29uZCB0
byBlbmFibGUgZ2Z4IG9mZiBmZWF0dXJlICovDQo+ICAgI2RlZmluZSBHRlhfT0ZGX0RFTEFZX0VO
QUJMRSAgICAgICAgIG1zZWNzX3RvX2ppZmZpZXMoMTAwKQ0KPiBAQCAtNDc3LDcgKzQ3OCw3IEBA
IGludCBhbWRncHVfZ2Z4X2Rpc2FibGVfa2NxKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
PiAgIAkJa2lxLT5wbWYtPmtpcV91bm1hcF9xdWV1ZXMoa2lxX3JpbmcsICZhZGV2LT5nZnguY29t
cHV0ZV9yaW5nW2ldLA0KPiAgIAkJCQkJICAgUkVTRVRfUVVFVUVTLCAwLCAwKTsNCj4gICANCj4g
LQlpZiAoYWRldi0+Z2Z4LmtpcS5yaW5nLnNjaGVkLnJlYWR5KQ0KPiArCWlmIChhZGV2LT5nZngu
a2lxLnJpbmcuc2NoZWQucmVhZHkgJiYgIShhbWRncHVfaW5fcmVzZXQoYWRldikgJiYgDQo+ICth
ZGV2LT5yZXNldF9kb21haW4tPmhhbmcpKQ0KPiAgIAkJciA9IGFtZGdwdV9yaW5nX3Rlc3RfaGVs
cGVyKGtpcV9yaW5nKTsNCg0KT24gYSBzeXN0ZW0gd2l0aCBtdWx0aXBsZSBHUFVzIGludGVyY29u
bmVjdGVkLCB0aGlzIHdpbGwgYWZmZWN0IG90aGVyIEdQVXMgYXMgd2VsbCBvbiB3aGljaCBqb2Ig
d2FzIG5vdCByZWFsbHkgcnVubmluZy4gSSBndWVzcyB5b3VyIHVzZWNhc2UgaGVyZSBpcyBkZXZp
Y2Ugc3BlY2lmaWMuDQoNClRoYW5rcywNCkxpam8NCg0KPiAgIAlzcGluX3VubG9jaygmYWRldi0+
Z2Z4LmtpcS5yaW5nX2xvY2spOw0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9qb2IuYw0KPiBpbmRleCA2YzNlNzI5MDE1M2YuLmJiNDA4ODBhNTU3ZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYw0KPiBAQCAtNDksNiArNDks
NyBAQCBzdGF0aWMgZW51bSBkcm1fZ3B1X3NjaGVkX3N0YXQgYW1kZ3B1X2pvYl90aW1lZG91dChz
dHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc19qb2IpDQo+ICAgCX0NCj4gICANCj4gICAJbWVtc2V0KCZ0
aSwgMCwgc2l6ZW9mKHN0cnVjdCBhbWRncHVfdGFza19pbmZvKSk7DQo+ICsJYWRldi0+cmVzZXRf
ZG9tYWluLT5oYW5nID0gdHJ1ZTsNCj4gICANCj4gICAJaWYgKGFtZGdwdV9ncHVfcmVjb3Zlcnkg
JiYNCj4gICAJICAgIGFtZGdwdV9yaW5nX3NvZnRfcmVjb3ZlcnkocmluZywgam9iLT52bWlkLCAN
Cj4gc19qb2ItPnNfZmVuY2UtPnBhcmVudCkpIHsgQEAgLTgzLDYgKzg0LDcgQEAgc3RhdGljIGVu
dW0gZHJtX2dwdV9zY2hlZF9zdGF0IGFtZGdwdV9qb2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hl
ZF9qb2IgKnNfam9iKQ0KPiAgIAl9DQo+ICAgDQo+ICAgZXhpdDoNCj4gKwlhZGV2LT5yZXNldF9k
b21haW4tPmhhbmcgPSBmYWxzZTsNCj4gICAJZHJtX2Rldl9leGl0KGlkeCk7DQo+ICAgCXJldHVy
biBEUk1fR1BVX1NDSEVEX1NUQVRfTk9NSU5BTDsNCj4gICB9DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuYyANCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuYw0KPiBpbmRleCA5ZGE1ZWFkNTBjOTAuLmI4Mjhm
ZTc3M2Y1MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jlc2V0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0
LmMNCj4gQEAgLTE1NSw2ICsxNTUsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiAqYW1k
Z3B1X3Jlc2V0X2NyZWF0ZV9yZXNldF9kb21haW4oZW51bSBhbWRncHVfcmVzZXRfZA0KPiAgIAlh
dG9taWNfc2V0KCZyZXNldF9kb21haW4tPmluX2dwdV9yZXNldCwgMCk7DQo+ICAgCWF0b21pY19z
ZXQoJnJlc2V0X2RvbWFpbi0+cmVzZXRfcmVzLCAwKTsNCj4gICAJaW5pdF9yd3NlbSgmcmVzZXRf
ZG9tYWluLT5zZW0pOw0KPiArCXJlc2V0X2RvbWFpbi0+aGFuZyA9IGZhbHNlOw0KPiAgIA0KPiAg
IAlyZXR1cm4gcmVzZXRfZG9tYWluOw0KPiAgIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yZXNldC5oDQo+IGluZGV4IGNjNGIyZWViMjRjZi4uMjllMzI0YWRkNTUy
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQu
aA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuaA0KPiBA
QCAtODQsNiArODQsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiB7DQo+ICAgCXN0cnVj
dCByd19zZW1hcGhvcmUgc2VtOw0KPiAgIAlhdG9taWNfdCBpbl9ncHVfcmVzZXQ7DQo+ICAgCWF0
b21pY190IHJlc2V0X3JlczsNCj4gKwlib29sIGhhbmc7DQo+ICAgfTsNCj4gICANCj4gICANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+IGluZGV4IGZhZmJhZDNj
ZjA4ZC4uYTM4NGUwNGQ5MTZjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYw0KPiBAQCAtMjksNiArMjksNyBAQA0KPiAgICNpbmNsdWRlICJhbWRncHUuaCINCj4g
ICAjaW5jbHVkZSAiYW1kZ3B1X2dmeC5oIg0KPiAgICNpbmNsdWRlICJhbWRncHVfcHNwLmgiDQo+
ICsjaW5jbHVkZSAiYW1kZ3B1X3Jlc2V0LmgiDQo+ICAgI2luY2x1ZGUgIm52LmgiDQo+ICAgI2lu
Y2x1ZGUgIm52ZC5oIg0KPiAgIA0KPiBAQCAtNTk3MSw2ICs1OTcyLDkgQEAgc3RhdGljIGludCBn
ZnhfdjEwXzBfY3BfZ2Z4X2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBl
bmFibGUpDQo+ICAgCQlXUkVHMzJfU09DMTUoR0MsIDAsIG1tQ1BfTUVfQ05UTCwgdG1wKTsNCj4g
ICAJfQ0KPiAgIA0KPiArCWlmICgoYW1kZ3B1X2luX3Jlc2V0KGFkZXYpICYmIGFkZXYtPnJlc2V0
X2RvbWFpbi0+aGFuZykgJiYgIWVuYWJsZSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gICAJZm9y
IChpID0gMDsgaSA8IGFkZXYtPnVzZWNfdGltZW91dDsgaSsrKSB7DQo+ICAgCQlpZiAoUlJFRzMy
X1NPQzE1KEdDLCAwLCBtbUNQX1NUQVQpID09IDApDQo+ICAgCQkJYnJlYWs7DQo+IEBAIC03NTY5
LDggKzc1NzMsMTAgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfa2lxX2Rpc2FibGVfa2dxKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+Z2Z4Lm51
bV9nZnhfcmluZ3M7IGkrKykNCj4gICAJCWtpcS0+cG1mLT5raXFfdW5tYXBfcXVldWVzKGtpcV9y
aW5nLCAmYWRldi0+Z2Z4LmdmeF9yaW5nW2ldLA0KPiAgIAkJCQkJICAgUFJFRU1QVF9RVUVVRVMs
IDAsIDApOw0KPiAtDQo+IC0JcmV0dXJuIGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyKGtpcV9yaW5n
KTsNCj4gKwlpZiAoIShhbWRncHVfaW5fcmVzZXQoYWRldikgJiYgYWRldi0+cmVzZXRfZG9tYWlu
LT5oYW5nKSkNCj4gKwkJcmV0dXJuIGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVyKGtpcV9yaW5nKTsN
Cj4gKwllbHNlDQo+ICsJCXJldHVybiAwOw0KPiAgIH0NCj4gICAjZW5kaWYNCj4gICANCj4gQEAg
LTc2MTAsNiArNzYxNiw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2h3X2Zpbmkodm9pZCAqaGFu
ZGxlKQ0KPiAgIA0KPiAgIAkJcmV0dXJuIDA7DQo+ICAgCX0NCj4gKw0KPiAgIAlnZnhfdjEwXzBf
Y3BfZW5hYmxlKGFkZXYsIGZhbHNlKTsNCj4gICAJZ2Z4X3YxMF8wX2VuYWJsZV9ndWlfaWRsZV9p
bnRlcnJ1cHQoYWRldiwgZmFsc2UpOw0KPiAgIA0KPiANCg==
