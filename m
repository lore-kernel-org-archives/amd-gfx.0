Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E050C44500
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 17:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D4A10E64D;
	Fri,  3 Jul 2026 17:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSz/gG+u";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE85010E64F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 17:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKRvp2H5Efxauckxcfkp5TtA4RbOM6MMYvbJkA4rYwaTI8yFwoRFyANQ9DNvKL+hmpRm997gmViu8170baaG4wNbXOr0FA5oJeLO6xiSxatU+n1/R6v76biahIGkmkunvyjTRtyCjz9BAtD3pqQ1eSyASTeW1CuP+384pvdI6UQaKY3Cx5Hwb8v5D6GnPFIJdETSzGTbJ8eB+GxsKEgRayxPV++UXnuFFPXoQUAXZXg2SnYBVSTQkyWVl+I2fqxPpEL5cgc28bgp3aR9obTcfJq5IT/0etCDrvL79RQmPhLG+xsNTSCvYST/MIUaYvOMK2lu3yQt1V6pkgS3hjai+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd0CL7BvKPUjf5Gir37DVpvF7EJOe8Hi6vtSyA1V5uc=;
 b=lCONt2vvqt3+ebmx3CI/CHLSJUJtUia5bE4YBDp0HEyJZK3p+TLU45tBJ0GOnOTdzyqiqFVWeh6mKSzTDfOqlW5mlK5HqMSjVpJ+rAcZ8qzxcNrJHLwdtWSBLOQ4BGo9Aus+cnyO50xRf2rlQUyW1tuGS3eNM8PpUtNDpM+dQyci10qel95XpON2E6cCN+XDpepJvMxdgUgCu/bp8UdyoL53UtkMr9lR3qZhxXGCCBKuYKgxF0oBu3SN/j0+eZlyQifX41OdZsXtznExImb6imsRreRVYSQEoDGeAw0/yJ6PTet0zDi44+9uI4BGayHyjA/JzrCEOW9xHaqU+2Jb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd0CL7BvKPUjf5Gir37DVpvF7EJOe8Hi6vtSyA1V5uc=;
 b=LSz/gG+uRoHn+onDztXDG0ocC6uXtiVqXsKrDPY7DVwOQFAe134Pw9vBUmf6C2RKbeuBlvzrSImXM4GyrGH5t+LyMqfbORsIbSZQfFGcjhq72vVz4SgBIKEIIjUi7+PSpEK9jfa0H6YQKnrK4AmQweCZMbDspgFOrNxwIryTixA=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 17:46:03 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 17:46:03 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Natalie Vock <natalie.vock@gmx.de>, "Shetaia,
 Amir" <Amir.Shetaia@amd.com>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "He, Siwei" <Siwei.He@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Thread-Topic: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Thread-Index: AQHdCXUtrYxinPp64U66GHiN0PlGWLZcCLKw
Date: Fri, 3 Jul 2026 17:46:03 +0000
Message-ID: <BL3PR12MB6425244AF10CABCDF2A131D3EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-12-timur.kristof@gmail.com>
In-Reply-To: <20260701161721.85681-12-timur.kristof@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-03T17:03:01.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ0PR12MB6710:EE_
x-ms-office365-filtering-correlation-id: 1f4f59c4-1bb2-4965-6a8b-08ded92af3df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|921020|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: xdg1yqfSqPOXckvTQapcTpsU+exjZM9hFELP9Nqurr3Gx3zNS+oBKffwnWr/W6Xhs4fGddRbK3hs0tE3ZqAX9WbibxOAVTtN5bIjmrZGmJvE0wysi17wlmH5rpLpO75FLt4BjBpKq/le3jFhqS9xvjB5bW+KEdxIVekXZuiQNF5RqRXe6goDqw+gDTu6NAGlBix2eYebE5uFJ3647toGq906QGsxQLrXNxyUVu3BDDU5yTJZRUdPnRGoXvIcBzm0raNKwG5zWz5w/n1c49g4sD4sDow3eWiZrY0ZVKaVw29HHhjOQ8q74PwK9m8/hKsUnIuHQE/kgTfesQsBXSkydCFKFs3+h16jxm6kQKkkVobVKufchYPlLJkYE4ZUl105UgTaHxpMXlLBbPOh15n6f/Gsru35/7wm1yRzY67+y43NZTKZTDNIN6TR015gJT7kw2bPJdNuBcxf66RQKHQQlvVxZZU8l4KeNI+udzKjpbOpjRZPac56hhEJnxBmL4C3xkBv6ePGFH8T20AUEfO3yZOovqGsk0wp9Ia55Una5BzcqiXBjmzj8cXBSnvRZjdlGDXv05LyyVGjLR1NnTa13rt8P1i6g7RmX5sBQ3m8pJoBHlCZiVJXLD/0a+pASuXti/uB5iv2fYZ0AJ7OaXSFy+O7m9usnPWrq0DEhPJUHfxOyGp2ePW/oK7OYvS3bcgm3qKJmSz42Y0gIEM3+tT14eim4DVCufUrMUn/GLAouy/YLkm2izzGgTQM+/GwPTcL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm1MR3J5dlJoV3lYbEo5cHpON2lGT2gvZTFwd2tCZ3hVOVBBQVphM0pXWHRs?=
 =?utf-8?B?Z3M1MFpTVEVLNm14UjlTOEowL3RUYjcwcEp6OXNkeWRoSXhpNTRFWlpZVnF4?=
 =?utf-8?B?dXQxL2RiWHRrc1dFY0VjZTh5YTcxQWdWbzJ1aDQ2QlJCY2FHZWt0NWJEQ1ZU?=
 =?utf-8?B?YW03UmZYUTgweWRaZDZKdDZ4NjhlOFRiaVpzRlNQN1hraE5OcWQrQ3liWk1L?=
 =?utf-8?B?VVp6TndlZUxPVk16V0V4bXRvcDdtM1p1MjNwbjJPbzRBZG5UNGdVb2x0VHdG?=
 =?utf-8?B?UHJrT3N1VmxzS1F0YXVYdlpvdmpUWkpDc3NqdnorQ0lDS2l1dDByc3d2eWhz?=
 =?utf-8?B?Q3VLcTgwUDd0a0IwS2NsZ1hCZ0ZuS1lNQ3Y1VHQ5T2FXdzdJT1BSUzduMC9y?=
 =?utf-8?B?OWJiY2dMVkUyTStaTjZETFhJbE91Vkg5cGlHcDkzNjlkN1p1UFByc2xqaHJj?=
 =?utf-8?B?WG9HMDZGRHgwQk43SmxkcG82Yk9EY0Q1STl5eXh3Z3R4OXlYV3VyQjVSSjlK?=
 =?utf-8?B?SVNvUnZKUjZhM3dnc3IvcUg4NmpZazlFRmszNml4RDVFdEFtSCtHL0w4clhK?=
 =?utf-8?B?QVBKTzJtc0lFcDY3K05QbmIxa2JPMElNbFNVTTNrMFJteE12K0RiWGgyeHI2?=
 =?utf-8?B?STFzK2VFL3dPUFNOa2FDUnFnMU5ndEdiZVcyOVIwdFhSWnFqSkE4Q2UvVjEw?=
 =?utf-8?B?Q3p1dXkrNEVCQmJaTGlHQ1NGcWZlelhKY3NnMk1yOStyWXp4WHRCYlJBZDI5?=
 =?utf-8?B?ZjhWd2pzamhDWVdHU283SDNIWkNzWGVRTmgxcmRIUXF6cFQ5TW9XV2dzRG54?=
 =?utf-8?B?VTZmSUl4NUVROEduV2p1Z3hnd2diWEFZejh6aTJrcnFqUWpzR05JZDBXMnNo?=
 =?utf-8?B?RW5aVHVwUThnemZqSDI3eitrQ01HRDR3MGpRRGNxN00xazBIR3hmcVNmMTBl?=
 =?utf-8?B?empuWitDa1FiV05za2VIQXpyN3JHcGUxcWI4bitneTNTY0lkTFZhaUNTRjhh?=
 =?utf-8?B?dkhGMCt0MTEwSFIzU01RMU03ZElVNHB4enZ2aHVEeDkxMDl1TEFlU0xvblpZ?=
 =?utf-8?B?cU5kYklHMDdPNm5hWEV5NThoT0JlV24zOUxENjF3bTNwdk5BcEt4OExmN3J0?=
 =?utf-8?B?c1dldmRPbmp6M1dyRUFTckRBdlJqeXYxNGJPZ2hpSUJ1YVhRdUpUclRlOWdJ?=
 =?utf-8?B?M29Gc1BKL1VaWDJyNjhjSjBmMk1vOW00YmhTbnRFTUd0VUFpNTVSeFNneDVa?=
 =?utf-8?B?d0IvSHVoaUNOV1NXYnEzTm9FeTIveUZLVFZsMytpUElGencyUzBPOHBiaWtn?=
 =?utf-8?B?SnBBZEt2dkwwSVNYdEVEc3ZvRTlJTnRGWm84RmU1RHJYL2lIK2tIVVVZbmFQ?=
 =?utf-8?B?YWRUbk9RaUJ0STJlUWZCK0hHKzh6UEI2U0xFblBlb2h6RmRBaU9wdFIzSHYz?=
 =?utf-8?B?LzdycHAwVFNwd0ZpOGJWcWZNKzdJeDJjNnlVYmI3eWxFS2tSZ1BxR3NoanFB?=
 =?utf-8?B?c2RVWFpDYjZpeDdmM3FoMGxMTUZmcDhBS2d0Vys5WXVGVUdTZnJUUk9jYlNK?=
 =?utf-8?B?ZGhwRWRKSWZwcWdZRWc5bFJteGozQ2dZcldxazB3UUkwZGlreG9Zay9sbzJp?=
 =?utf-8?B?bHFEUUwwSWhQdXcxcE5YaDkzcitYODlrYXhJR0ZnRnl3SU5Qa2NsZHhhT3lm?=
 =?utf-8?B?ZUNUMmF0YjZ1NjdpSGVKRDJWYVlOUmZDZThZMGJIRTJtV2VneHBOQlJOZ0hz?=
 =?utf-8?B?OHY1VUhTbUt6cCtvcktZTTg2WFFlQTI2YUJwSjhHaTBETXhWQU1WcHVPQnNz?=
 =?utf-8?B?QWlac2wvYlVMUGJsQnczaUx4amUyelpySms5MVBNbjlrQ3hPcm0wZ0w4VEJZ?=
 =?utf-8?B?UTVXZFRWTkU3UTU5ZGVwV1lHSWI1T09qMTJpNU5vRnNWLzQzZG5aVG1nc3lU?=
 =?utf-8?B?UCt0OEthTitqNkg5SzhQUWhIOTBDZjFwNVh1MEIrS1MveW9Nc1dmbVJiMC9I?=
 =?utf-8?B?UCt0dEl0ZWZxbVo4RWxvTzRZZlA1M0dqWnRiaDNTVHMwU1hJcDNIenVZeVBa?=
 =?utf-8?B?VkI0SjdRa3ZVTU5VWC8ySFVXaDRhQXJKbGhTV2xqTnl6UVNEMEJHUmx4NlVY?=
 =?utf-8?B?ek9kVWUxMHo0MXlIQnBQbFAzTkdpU3pPNmwxcHlXS010QjkzVUtSYm5aNk5y?=
 =?utf-8?B?TDJqZHk5T045d1JBTEovRUMwRUxhaUtuajY2MFR6c21qNHJxcmNYMy82MnpL?=
 =?utf-8?B?N3EyZVRUWTk2a1BkbUhtM2EzQ2RSUU8zT2RtM05NN2V2TkpTWVFROW94bVpI?=
 =?utf-8?Q?dIXFKfuaw/7raTWX1d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4f59c4-1bb2-4965-6a8b-08ded92af3df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 17:46:03.6341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmxJdpsMFQFaO7B3LlitJQrw//9Hxqp9/qoof9rOSZYVvSfhuKzhHPmUTeVEx9DNOb7CvhsTENJKsnemqS79hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW11
ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
SnVseSAxLCAyMDI2IDEyOjE3IFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IE5hdGFsaWUgVm9j
ayA8bmF0YWxpZS52b2NrQGdteC5kZT47IFNoZXRhaWEsDQo+IEFtaXIgPEFtaXIuU2hldGFpYUBh
bWQuY29tPjsgTWFyZWsgT2zFocOhayA8bWFyYWVvQGdtYWlsLmNvbT47DQo+IExpbW9uY2llbGxv
LCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IFR2cnRrbyBVcnN1bGluDQo+IDx0
dXJzdWxpbkB1cnN1bGluLm5ldD47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT47IExhemFyLCBMaWpvDQo+IDxMaWpvLkxhemFyQGFtZC5jb20+OyBIZSwgU2l3ZWkgPFNp
d2VpLkhlQGFtZC5jb20+OyBZYW5nLCBQaGlsaXANCj4gPFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBK
b3NoaSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+IENjOiBUaW11ciBLcmlzdMOzZiA8
dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxMS8xNF0gZHJtL2Ft
ZGdwdS9paDYuMDogVXNlIE1NSU8gQUNLIGZvciByZXRyeSBDQU0gb24gSUgNCj4gNi4wDQo+DQo+
IFRoZSBkb29yYmVsbCBpcyBub3Qgd29ya2luZyBvbiBOYXZpIDMxLg0KPiBVc2UgdGhlIElIX1JF
VFJZX0NBTV9BQ0sgcmVnaXN0ZXIuDQoNCkkgdGhpbmsgdGhlIGRvb3JiZWxsIHBhdGggaXMgbm90
IGVuYWJsZWQgZm9yIElIIENBTSBzbyB0aGF04oCZcyBwcm9iYWJseSB0aGUgcmVhc29uIGl0cyBu
b3Qgd29ya2luZy4NCkkgdGhpbmsgd2UgbmVlZCBhbiB1cGRhdGUgdG8gdGhlIE5CSU8gaWhfZG9v
cmJlbGxfcmFuZ2UoKSBmdW5jdGlvbiB0byBlbmFibGUgdGhlIGRvb3JiZWxsIHBhdGguDQoNCkhh
dmluZyBzYWlkIHRoYXQsIHdlIGludGVuZCB0byB1c2UgZG9vcmJlbGxzIG9uIGFsbCBBU0lDcyB0
byBhY2sgSUggQ0FNcyB0aGF0IHN1cHBvcnQgcmV0cnkgZmF1bHRzLg0KDQpSZWdhcmRzLA0KTXVr
dWwNCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaW11ciBLcmlzdMOzZiA8dGltdXIua3Jpc3RvZkBn
bWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjZfMC5j
IHwgOCArKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhf
djZfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWhfdjZfMC5jDQo+IGluZGV4
IDY1ZTVkMjE3NTNmOS4uYTk3Yzg1YjBjYjk5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9paF92Nl8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvaWhfdjZfMC5jDQo+IEBAIC0zMDcsNiArMzA3LDExIEBAIHN0YXRpYyBpbnQgaWhfdjZfMF9l
bmFibGVfcmluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gICAgICAgcmV0dXJu
IDA7DQo+ICB9DQo+DQo+ICtzdGF0aWMgdm9pZCBpaF92Nl8wX3JldHJ5X2NhbV9hY2soc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMg0KPiArY2FtX2luZGV4KSB7DQo+ICsgICAgIFdSRUcz
Ml9TT0MxNShPU1NTWVMsIDAsIHJlZ0lIX1JFVFJZX0NBTV9BQ0ssIGNhbV9pbmRleCk7IH0NCj4g
Kw0KPiAgLyoqDQo+ICAgKiBpaF92Nl8wX2lycV9pbml0IC0gaW5pdCBhbmQgZW5hYmxlIHRoZSBp
bnRlcnJ1cHQgcmluZw0KPiAgICoNCj4gQEAgLTgwNyw3ICs4MTIsOCBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGFtZGdwdV9paF9mdW5jcyBpaF92Nl8wX2Z1bmNzID0gew0KPiAgICAgICAuZ2V0X3dw
dHIgPSBpaF92Nl8wX2dldF93cHRyLA0KPiAgICAgICAuZGVjb2RlX2l2ID0gYW1kZ3B1X2loX2Rl
Y29kZV9pdl9oZWxwZXIsDQo+ICAgICAgIC5kZWNvZGVfaXZfdHMgPSBhbWRncHVfaWhfZGVjb2Rl
X2l2X3RzX2hlbHBlciwNCj4gLSAgICAgLnNldF9ycHRyID0gaWhfdjZfMF9zZXRfcnB0cg0KPiAr
ICAgICAuc2V0X3JwdHIgPSBpaF92Nl8wX3NldF9ycHRyLA0KPiArICAgICAucmV0cnlfY2FtX2Fj
ayA9IGloX3Y2XzBfcmV0cnlfY2FtX2FjaywNCj4gIH07DQo+DQo+ICBzdGF0aWMgdm9pZCBpaF92
Nl8wX3NldF9pbnRlcnJ1cHRfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+IC0t
DQo+IDIuNTQuMA0KDQo=
