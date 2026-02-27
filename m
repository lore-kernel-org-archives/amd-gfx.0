Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53299FD5323
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D886D10EADB;
	Fri, 27 Feb 2026 09:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQggbTtI";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3AE10EAD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 09:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1CotTDKkre/cb4lzCsAPDBd4l+veUm9BywCvKUZP3PyHcuFfzFtSwIxeSlDOyeNwtX5aTPnng7AC78Se3BZjjTnbPukTKN3b7xgIFomhCwthHFIpZjCsq+UZ0M8WjKPtWrz0GLWeS5TCZMY3APIx0VWiWJ0Xp5OHqDbWOyJ0EGaz6RTZISJcIQbmeHMRVg/61EZbXexlHEJAbDz8FV76GKE3X9Pp4gb66NBUQ0/uJSJ2JkGNi7QYgfbs+3aqidY1+5yaGVhNaJeaRo5zfhkPQl8xPi0T0VbiLNmnzTdJD009vVKez/YvQjOE18EP6gM6eb+1um6pHkMqVG/hGtKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfF6dBWTPsU05h3HjRuDYNqNA3xRS7qV+jnH/YK/9PI=;
 b=TQiBydBvCbAL0yXFXU4ZxXogPC4ejMYphatDhfVdC9t+lBJ+Ocx5GJ7u8bwFQBQXgd6AaABSgmpyov/wJi1XlHHK3MWPOdqZWXHBp297HHJnj7WdphRzE7Xa0JZwYq+TBGvyN5vLIeculP0mfa4H0+AcdRqA9Tr2kAyP/1DZQ49iCnhxbjt1uoHU3pOP8gBov0Qf9Cf+edR1ky/jK+TdUvbO1F3RMqhIYNRjLz2dMpVdIws2RZpUTrP9D+Ll+7wTQJYOeXIG5xU3DSxbQe29AK4iyHd3kRbpZ0qwnsM0XqS+KNhHOSUtTtfxj/YCes/7xzwOUgjUbaiJEf2prOl7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfF6dBWTPsU05h3HjRuDYNqNA3xRS7qV+jnH/YK/9PI=;
 b=mQggbTtIqC5NvUSLduZvVZ0RGeJeTfyBEwP4YnkW0jItK0JNf40i40SptiMS/j34ruO4iFvLE2mN9V0OwezCCAoRTF1A99a/c5IxNU7+q+GauePKevsHghvb+pxMSpxGfHBD40kfL7PFz8EGRlgL+bZz8fJMkGJjDm0lNzR2beo=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 09:43:09 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 09:43:09 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
Thread-Topic: [PATCH v2] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
Thread-Index: AQHcp8ZDHnNBBJG3DEO7/TCQwaogerWWQMSAgAAIUdA=
Date: Fri, 27 Feb 2026 09:43:08 +0000
Message-ID: <DM4PR12MB51522BF9B5A7FD1AAE95F423E373A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260227085110.2865415-1-Jesse.Zhang@amd.com>
 <711f9a67-0323-47c5-a59a-81705af16d9e@ursulin.net>
In-Reply-To: <711f9a67-0323-47c5-a59a-81705af16d9e@ursulin.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-27T09:34:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV8PR12MB9713:EE_
x-ms-office365-filtering-correlation-id: f1730091-b213-43f7-d35f-08de75e49d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 1MZ6KD9YOtsCFZtiKmtoLczUP6VAh2VZ6+Ov2N+9ijqp/IeYKrybLEjdyI8evDiwpqaDw96MhjmKU0/Us/wVcOeTT+PA1q6DqW1H1uQ4jtxgatXa4CiVlDJcDgLWRX0I6HLBo/XUZOzNCb+leejAdLg+sjyFg3Gfps2t/f48s2IBWwhh5tVJwLwk55OWeps0QEjlr676DjIji0GNygGmTqH9O23ovjPK304wgXp8nvioiIKrqlCxrwkJihvVweyYUHPv6p2RwcdkNZ6YlnR3RY4/KIZJSr/iEPKX7ulL9UC4zCF/AHQBnz6l3sK/7VHb6IgtjNLxNyW66y0GaoVKSL3bGDTC5jYSeQtp5FOKGs59j0js+/ZKKe1QvinW0bGJO4njw20k4/7fKZNQJEvHBG67u+DOfwlPpYrrvOC7+Z/tDjpsBlfFlR6RPJq9LNapfv9joovLUI5eYGPROZmQA83Bd+YjjorhTG8Seb0+sYUPOExU+I9quCnYP4ALfyiuls69a+3DlmWY2Nwd8l/tsry/ga9FvwsgfGUG6hehF77KbPCmvongCaDL4W/Q1u+z1VXksjOWQtgSH4Oe5M2xGyRtxYNNBWJWiklNEkZhNz/QsE7IAR7gCIU/0vskVAQ3F9P2cqN7/txX/dXCQMEGULUacImnnGfioHoup66Kz1DcpKwfx5ojZwPQU/KzBTO5fGKCqqyobVxa8tYEJ2dDETygTrhFyscytqC7/eIXHliY0mah0ay+7Muxlppbd6PoPRLwPvnrdJR5snMZpYMeLUa46tTuVbENa8VvitqP8sg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJ5M1ZUT1QxNUJVVHRkSFlCeXhPZ1F5VnF4MWc4bzVUTFdZN0xETUg1M2RJ?=
 =?utf-8?B?ZG9mVjlWaUJiT0orOUpFb0VJbGVTUU5oTjRwREhMWnhROGs1UldzZnhRT1Nm?=
 =?utf-8?B?ZE8vUkp4ZklpUHRYQUFLNUlsVTJXeVhvVS8xYXVQSlVzQnVLWkM2NGgxcnRW?=
 =?utf-8?B?Qk9SS3gwN002TzJHVjhFcU53clp4cDhLNytYMkp3V1V5K2N4SDVhUWhuMTVv?=
 =?utf-8?B?c3JzRGJYWEMzQWtHcDNDZENkOHdVcWR4RmM2UFpYLzFybEw2RFVZdy9meGoy?=
 =?utf-8?B?NlZaWVU0cjN0eC9OS1ZoUll2akNlelZsc2phZXY5M1pTbzR0ZEI3NDhua2gx?=
 =?utf-8?B?L0FNLzlwTkpwaE12NThscXRvYzhHMkRFQlRKT0lvZy93alB3Zis3MmxKTmtU?=
 =?utf-8?B?UlJ5bERlbW9IaWlEWVZKYUIwbEhuSmFFZW51YTlBT2FudWRQaThKTFhvVlNJ?=
 =?utf-8?B?SWN0Z3IwSTE3MWd5dDc0c2ltWVZZZ01yTWJ5Z0MvT1VFNnZWTk9jRTRmTnNi?=
 =?utf-8?B?MmxJZ28wUy9UaThEWWo1bUkrekRpZ1VJdVJQaHU3M2hZZVpwc0VBNzZORkpo?=
 =?utf-8?B?dmZOb3c5SElRajE3d2ZpN202Ylc5bTJIWHZuVGxZdXVKNGdWMHJjSnVzZG9p?=
 =?utf-8?B?Wk5UbjFCTXJXeWk3anpyV29SLy9HVHJPRk9HbUVLM01IS3NzUUlXN0VESVAy?=
 =?utf-8?B?ZC9tZmdWbWxwTWpablJ2MzRUNy8xWnVVak9JdjdLWmFkZFpNbU8vNWRtd3lI?=
 =?utf-8?B?MVZEK1NEWUErSHpsbzh3Mzk2Y2dNYkRsWTh6WS9WQ2luc1RLelRRZ0VNZ2lW?=
 =?utf-8?B?UmVScHZsUGNYaGY0eTRVMEpMK2ErU2FLU01YditWMGk0Q3RsT1VzL01ZQW1Y?=
 =?utf-8?B?Vk5sZ25EZW5hL2dGMEF0azhsYmI0ZEdnU2UwMHZZaktLYVl5ZXNtdzkrQ2JQ?=
 =?utf-8?B?bXAyOUpnMUE5UnJCcTJac1A3akxoK2p6b2V5WU42SFJ0MitPVnhzWXVJZlg4?=
 =?utf-8?B?MmY5ODd5bkpmeEpvWDc2Wmk3eUVscE9sQ2V0MzRROW9KWE11ZG1NZXJweGR6?=
 =?utf-8?B?akhtTlAwSFdid0FWbWxuMmpvNjYwcTQ1NVo3UmZ3SWZ1TzN4c1VHWVlkNnc2?=
 =?utf-8?B?Z1FBbnBlMkhaaUtUZTZaYVFYUmRUbnNBQmtuYXZaaW1OWW1KNXFFdG9xUytj?=
 =?utf-8?B?Z3dyZmwybE14QncwMEY0ZThLY0RKNTFzYkUzanFCL0Y1eUV1dFVVbkw1bHkx?=
 =?utf-8?B?MU44Q25jSmNRS2NneHpXbE9lK3JoYkFHK0JIRGZONUsrWGFqN2FxNXArVjB6?=
 =?utf-8?B?OVcwRjc0MHNjZjZObjhmQm92VXhzckVveVpiajBHWWpsWE5LWjFDbHNyaU9H?=
 =?utf-8?B?SjF6MzBVNXFvZWNLN0d1UDl1L3hCaG1FTWw0bXBLckhWeUtrRjZzeGhQbVFP?=
 =?utf-8?B?NkN2V2Z1cEFtOFExUmRrODJQZGVnRFhLR29rU3ZHUmFiT24zZjBwRDd6cVBm?=
 =?utf-8?B?YzJLSnA3c0pCUXpDMitraTBnZlBnWnJBV0hkZGJ3bGhIVk9qRW45Q011akVO?=
 =?utf-8?B?dWh4VGNEajlvSkF1aXEyQmU5ZXduVFVLOHpHR0xIVFJGLy9Ib2xKeThWV1Fp?=
 =?utf-8?B?aTRGS2JlTkJUK08zNXhqaUFLSTlreDF0a1E4bWErdFkvL3BNZEZ1T3lSVktC?=
 =?utf-8?B?Zjd3NERvaDh2c2JRTTNRMWR5dlpreTMrNWtqblBFZnZKK284bGlnZTNPQUN5?=
 =?utf-8?B?eWwxNGFCd3B0QUFoa1NpQUJZS1BPTEZDYjlQbGpkUm9abXFnNW00Ri9wd28y?=
 =?utf-8?B?WFViQnRnelNmYlNFeDRBc2N3T1ZEVElxY2treW1XaHdhODRXK0RoK0VFNHNC?=
 =?utf-8?B?NE1zZXp3ZW9TK2FnNDM5Y1hvcyt0cmJGQk9OK21wV3p0emRJSEhFMng5TkxT?=
 =?utf-8?B?blRFbjVSZ3pUa0RmR3RYcmw3ZmpUK2pRR2NTckdmbW9tSU5SaUpDcnFVL0JS?=
 =?utf-8?B?Q2JhTk8xQmxjTEdPZHlWU1RIWWhrYkFENXRyMVI5UjMwdXNHdENDdTE3akhJ?=
 =?utf-8?B?WkUxeUNtVGROVlpvTXNOTUpiRUI2c3ZhaUZOWGthb05HcUdyYjgzam5oU3dY?=
 =?utf-8?B?NmhsbGV3bk0vb1hibGdqVmUvaUNvU2c3bVYrQkZraUhwYnd3TlBQNUdrTkxG?=
 =?utf-8?B?dnBUWFNpem91Zm9tZ3ppS0hWQkdCdGJ4dTZJQmRQSjBlZG5HdFdrZ2NDbTdm?=
 =?utf-8?B?Smx6QVIrTGZrNUIzeVNlbHNmZzZMS1RmdER4bHdFUEpwZ1FObktHQ09sa0FT?=
 =?utf-8?Q?KjktY+30LvO5gs7gKV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1730091-b213-43f7-d35f-08de75e49d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:43:08.8479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+iANswd8ZNUrWA1OJCxH7jpcuqlUknW0BAkza1gEBG9AO6awp2Q6KYaovtUBh+SSW5s/fywkFcJdnk92sWQZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUdnJ0a28gVXJzdWxpbiA8
dHVyc3VsaW5AdXJzdWxpbi5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjcsIDIwMjYg
NTowNSBQTQ0KPiBUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdTog
Rml4IG51bGwgcG9pbnRlciBhY2Nlc3MgaW4NCj4gYW1kZ3B1X3VzZXJxX3NpZ25hbF9pb2N0bA0K
Pg0KPg0KPiBPbiAyNy8wMi8yMDI2IDA4OjUwLCBKZXNzZS5aaGFuZyB3cm90ZToNCj4gPiBUaGUg
YW1kZ3B1X3VzZXJxX3NpZ25hbF9pb2N0bCBmdW5jdGlvbiB3YXMgdHJpZ2dlcmluZyBrZXJuZWwg
cGFnZQ0KPiA+IGZhdWx0cyBkdWUgdG8gbWlzc2luZyBudWxsIHBvaW50ZXIgY2hlY2tzIHdoZW4g
YWNjZXNzaW5nDQo+ID4gZ29ial9yZWFkL2dvYmpfd3JpdGUgYXJyYXlzLCBhbmQgaW1wcm9wZXIg
aGFuZGxpbmcgb2YgbWVtb3J5IGFsbG9jYXRpb24gZm9yIHRoZXNlDQo+IGFycmF5cy4NCj4gPg0K
PiA+IFRoZSBjcmFzaCBzdGFjayBzaG93ZWQgdGhlIGZhaWx1cmUgb3JpZ2luYXRlZCBmcm9tIHRo
ZSBpb2N0bCBwYXRoOg0KPiA+IFsgICA2NC45Nzc2OTVdIENhbGwgVHJhY2U6DQo+ID4gWyAgIDY0
Ljk3NzY5Nl0gIDxUQVNLPg0KPiA+IFsgICA2NC45Nzc3MDBdICBhbWRncHVfdXNlcnFfc2lnbmFs
X2lvY3RsKzB4OGU0LzB4ZGEwIFthbWRncHVdDQo+ID4gWyAgIDY0Ljk3NzgzMF0gID8gdHR5X2xk
aXNjX2RlcmVmKzB4MWEvMHgyMA0KPiA+IFsgICA2NC45Nzc4MzRdICA/IF9fcGZ4X2FtZGdwdV91
c2VycV9zaWduYWxfaW9jdGwrMHgxMC8weDEwIFthbWRncHVdDQo+ID4gWyAgIDY0Ljk3NzkzNF0g
IGRybV9pb2N0bF9rZXJuZWwrMHhhYi8weDExMCBbZHJtXQ0KPiA+IFsgICA2NC45Nzc5NTVdICA/
IF9fcGZ4X2FtZGdwdV91c2VycV9zaWduYWxfaW9jdGwrMHgxMC8weDEwIFthbWRncHVdDQo+ID4g
WyAgIDY0Ljk3ODA3MV0gIGRybV9pb2N0bCsweDJjYi8weDVhMCBbZHJtXQ0KPiA+IFsgICA2NC45
NzgwODhdICA/IHR0bV9ib192bV9mYXVsdF9yZXNlcnZlZCsweDFlZi8weDQxMCBbdHRtXQ0KPiA+
IFsgICA2NC45NzgwOTNdICBhbWRncHVfZHJtX2lvY3RsKzB4NGYvMHg5MCBbYW1kZ3B1XQ0KPiA+
IFsgICA2NC45NzgxNzldICBfX3g2NF9zeXNfaW9jdGwrMHg5ZS8weGYwDQo+ID4gWyAgIDY0Ljk3
ODE4Ml0gIHg2NF9zeXNfY2FsbCsweDEyNzQvMHgyMTkwDQo+ID4gWyAgIDY0Ljk3ODE4NV0gIGRv
X3N5c2NhbGxfNjQrMHg3NC8weDk1MA0KPiA+IFsgICA2NC45NzgxODldICA/IF9fX3B0ZV9vZmZz
ZXRfbWFwKzB4MjAvMHgxNzANCj4gPiBbICAgNjQuOTc4MTkxXSAgPyBfX2hhbmRsZV9tbV9mYXVs
dCsweDk4Ni8weGZiMA0KPiA+IFsgICA2NC45NzgxOTRdICA/IGNvdW50X21lbWNnX2V2ZW50cysw
eGU3LzB4MWUwDQo+ID4gWyAgIDY0Ljk3ODE5N10gID8gaGFuZGxlX21tX2ZhdWx0KzB4MWNjLzB4
MmIwDQo+ID4gWyAgIDY0Ljk3ODE5OV0gID8gZG9fdXNlcl9hZGRyX2ZhdWx0KzB4Mzk0LzB4OGEw
DQo+ID4gWyAgIDY0Ljk3ODIwMl0gID8gaXJxZW50cnlfZXhpdF90b191c2VyX21vZGUrMHgyYS8w
eDFlMA0KPiA+IFsgICA2NC45NzgyMDVdICA/IGlycWVudHJ5X2V4aXQrMHgzZi8weDUwDQo+ID4g
WyAgIDY0Ljk3ODIwNl0gID8gZXhjX3BhZ2VfZmF1bHQrMHg5Ny8weDE5MA0KPiA+IFsgICA2NC45
NzgyMDhdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQo+ID4gWyAg
IDY0Ljk3ODIxMF0gUklQOiAwMDMzOjB4N2YzYzA4YjI0ZGVkDQo+ID4NCj4gPiBGaXhlczogZmQ0
ZmRlMWRmMThiICgiZHJtL2FtZGdwdS91c2VycTogVXNlIGRybV9nZW1fb2JqZWN0c19sb29rdXAg
aW4NCj4gPiBhbWRncHVfdXNlcnFfc2lnbmFsX2lvY3RsIikNCj4NCj4gSXQgaXMgYmVzdCBwcmFj
dGljZSB0byBDYyB0aGUgdGFyZ2V0IGNvbW1pdCBhdXRob3IuIDspDQo+DQo+ID4NCj4gPiBWMjog
aW5pdGlhbGl6ZSBnb2JqX3dyaXRlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFu
ZyA8amVzc2UuemhhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMgICB8IDIyICsrKysrKysrKysrKystLS0tLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2Vy
cV9mZW5jZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFf
ZmVuY2UuYw0KPiA+IGluZGV4IDNjMzA1MTJhNjI2Ni4uYWY5MzQzNzRkZjk0IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMN
Cj4gPiBAQCAtNDY3LDcgKzQ2Nyw3IEBAIGludCBhbWRncHVfdXNlcnFfc2lnbmFsX2lvY3RsKHN0
cnVjdCBkcm1fZGV2aWNlICpkZXYsDQo+IHZvaWQgKmRhdGEsDQo+ID4gICAgIGNvbnN0IHVuc2ln
bmVkIGludCBudW1fcmVhZF9ib19oYW5kbGVzID0gYXJncy0+bnVtX2JvX3JlYWRfaGFuZGxlczsN
Cj4gPiAgICAgc3RydWN0IGFtZGdwdV9mcHJpdiAqZnByaXYgPSBmaWxwLT5kcml2ZXJfcHJpdjsN
Cj4gPiAgICAgc3RydWN0IGFtZGdwdV91c2VycV9tZ3IgKnVzZXJxX21nciA9ICZmcHJpdi0+dXNl
cnFfbWdyOw0KPiA+IC0gICBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKipnb2JqX3dyaXRlLCAqKmdv
YmpfcmVhZDsNCj4gPiArICAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICoqZ29ial93cml0ZSA9IE5V
TEwsICoqZ29ial9yZWFkID0gTlVMTDsNCj4gPiAgICAgdTMyICpzeW5jb2JqX2hhbmRsZXMsIG51
bV9zeW5jb2JqX2hhbmRsZXM7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfdXNlcnFfZmVuY2UgKnVz
ZXJxX2ZlbmNlOw0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZTsg
QEAgLTU5NywxMyArNTk3LDIxIEBAIGludA0KPiA+IGFtZGdwdV91c2VycV9zaWduYWxfaW9jdGwo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwNCj4gPiAgIGV4ZWNfZmluaToNCj4g
PiAgICAgZHJtX2V4ZWNfZmluaSgmZXhlYyk7DQo+ID4gICBwdXRfZ29ial93cml0ZToNCj4gPiAt
ICAgZm9yIChpID0gMDsgaSA8IG51bV93cml0ZV9ib19oYW5kbGVzOyBpKyspDQo+ID4gLSAgICAg
ICAgICAgZHJtX2dlbV9vYmplY3RfcHV0KGdvYmpfd3JpdGVbaV0pOw0KPiA+IC0gICBrZnJlZShn
b2JqX3dyaXRlKTsNCj4gPiArICAgZm9yIChpID0gMDsgaSA8IG51bV93cml0ZV9ib19oYW5kbGVz
OyBpKyspIHsNCj4gPiArICAgICAgICAgICBpZiAoZ29ial93cml0ZSkNCj4NCj4gSSBkb24ndCBz
ZWUgYSBwYXRoIGdvIGdldCBoZXJlIHdpdGggZ29ial93cml0ZSAob3IgZ29ial9yZWFkKSBOVUxM
LiBJZiBudW1iZXIgb2YNCj4gaGFuZGxlcyBpcyBncmVhdGVyIHRoYW4gemVybyBkcm1fZ2VtX29i
amVjdHNfbG9va3VwKCkgZWl0aGVyIGZhaWxzIG9yIHJldHVybnMgYQ0KPiB2YWxpZCBwb2ludGVy
LiBXaGF0IGFtIEkgbWlzc2luZz8gV2hhdCBicmFuY2ggaGl0IHRoaXM/IEJlZm9yZSBmaXhlZA0K
PiBkcm1fZ2VtX29iamVjdHNfbG9va3VwKCkgd2FzIGNoZXJyeSBwaWNrZWQgdG8gYW1kLXN0YWdp
bmctZHJtLW5leHQ/DQpbWmhhbmcsIEplc3NlKEppZSldDQoNCg0KVGhlIGlzc3VlIGNhbiBiZSBy
ZXByb2R1Y2VkIHdpdGggdGhlIGRybS1uZXh0IGJyYW5jaCwgYW5kIHRoZSBoZWFkZXIgY29tbWl0
Og0KY29tbWl0IDBjNGM4NzE1NjE4YjIxYTg2YmYyMzgxNTZkZWZhYTg1ZWY5NGI1ZGEgKGdlcnJp
dGdpdC9hbWQtc3RhZ2luZy1kcm0tbmV4dCkNCkF1dGhvcjogWXVqaWUgTGl1IDx5dWppZS5saXVA
aW50ZWwuY29tPg0KRGF0ZTogICBUaHUgRmViIDI2IDExOjAwOjM3IDIwMjYgKzA4MDANCg0KV2Ug
c2hvdWxkIGluaXRpYWxpemUgZ29ial93cml0ZSBhbmQgc2V0IGdvYmpfcmVhZCB0byBOVUxMOw0K
b3RoZXJ3aXNlLCAgdGhlIHBvaW50ZXIgd2lsbCBwb2ludCB0byBhIGRhbmdsaW5nIHBvaW50ZXIu
DQoNCldoaWNoIGZpeGVzIGRvIHlvdSBtZWFuIGFib3V0IGRybV9nZW1fb2JqZWN0c19sb29rdXAN
Cg0KVGhhbmtzDQpKZXNzZQ0KPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgZHJtX2dlbV9vYmpl
Y3RfcHV0KGdvYmpfd3JpdGVbaV0pOw0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICsgICBpZiAoZ29i
al93cml0ZSkNCj4gPiArICAgICAgICAgICBrZnJlZShnb2JqX3dyaXRlKTsNCj4NCj4ga2ZyZWUo
KSBkZWZpbml0ZWx5IGhhbmRsZXMgTlVMTCBqdXN0IGZpbmUuDQo+DQo+IFJlZ2FyZHMsDQo+DQo+
IFR2cnRrbw0KPg0KPiA+ICAgcHV0X2dvYmpfcmVhZDoNCj4gPiAtICAgZm9yIChpID0gMDsgaSA8
IG51bV9yZWFkX2JvX2hhbmRsZXM7IGkrKykNCj4gPiAtICAgICAgICAgICBkcm1fZ2VtX29iamVj
dF9wdXQoZ29ial9yZWFkW2ldKTsNCj4gPiAtICAga2ZyZWUoZ29ial9yZWFkKTsNCj4gPiArICAg
Zm9yIChpID0gMDsgaSA8IG51bV9yZWFkX2JvX2hhbmRsZXM7IGkrKykgew0KPiA+ICsgICAgICAg
ICAgIGlmIChnb2JqX3JlYWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICBkcm1fZ2VtX29iamVj
dF9wdXQoZ29ial9yZWFkW2ldKTsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiArICAgaWYgKGdvYmpf
cmVhZCkNCj4gPiArICAgICAgICAgICBrZnJlZShnb2JqX3JlYWQpOw0KPiA+ICAgZnJlZV9zeW5j
b2JqOg0KPiA+ICAgICB3aGlsZSAoZW50cnktLSA+IDApDQo+ID4gICAgICAgICAgICAgaWYgKHN5
bmNvYmpbZW50cnldKQ0KDQo=
