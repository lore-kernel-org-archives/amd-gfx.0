Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DC7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 08:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD8C10E118;
	Fri, 24 Dec 2021 08:19:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC8A10E118
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 08:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8QP4qZ+f95O+xn+hhSlfzsbxQOlO3uTLffiC/5LRDdzQAIvnUETNlcqZfIqyO+eDxvktiwvVT+/n+lTq9xMFbL/6VcuD82Cgp2fR8/M+mEOnZsoBieNQAz7e2eig4bzfcqHrsKodyvwl1bi6oLIXgBkI0knu6uylvXq01T/GQ1guaLI1E2RoiU51uEJF9bdGx6wjvg1EdgQ3anVB+KRiRsAXqoTNaTXVwEbS7diAvvDBGzELms+BVkvFthp5zUuGJFbX9tkbUoe+8VZxYhuu2azBZZDmpAKdMdtbs9rJpx19Fe3UoVhXkRmASGHdYcHftWKoGvsphhYcg/oqMfsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rofXFUUxjGDkQ64W9z6raKW7vcJo7chWYIET8JOyNk4=;
 b=ZcmE3Ly0JzgtootcJSxg7Mah35Z5F8XswM4O5/mObfQ9yM78iIJEPwWleQMRIM1m7rtGAyuKHnBrzq5cY5cOeN8g/3sQlSpJ/fNObe9oVneJA/M8VhZxKUVa5SsDC9eRHJfWWtQDVj9LXJoIb4YD8WrZVtfH3VejmtaWJyHA6pwmzDyNfzvaRR72cE8zaulSNl5ml/hTPD8puaI4ekdhwlPbgFBI4Hd9/j9y0r9NqeXViTJPirT4fEePJyf+/I57dFAD8oIk9y9LLG32bETXToM94CcZl+LAWlQpmdtNJFyhNz1t+12siIfc6VZFgAhAwtigEwmrUeZAYcYP6X5+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rofXFUUxjGDkQ64W9z6raKW7vcJo7chWYIET8JOyNk4=;
 b=TTZu4g6Dqw+eAnNjToYGl2UoWs1IdEqdpOrzcGO2uzf1odxmf1JFVN7w4jTEjjgTMxjA59/fQRER3OETo1IQL/wyOi+rM2G+mHiWgVCPZjUpXtLddLqheh7V9/7ebvrXjMsE3mbuKXihZGD1JI7432HThcRdE2XaNTiOgI1MFkE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.16; Fri, 24 Dec 2021 08:19:04 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 08:19:04 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: no DC support for headless chips
Thread-Topic: [PATCH] drm/amdgpu: no DC support for headless chips
Thread-Index: AQHX+DIXUSMt6ytPmki1kpsriwd81qxA8RLAgAA594CAACAigA==
Date: Fri, 24 Dec 2021 08:19:04 +0000
Message-ID: <DM5PR12MB2469B10EBEC2E753887089D0F17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211223191934.1269698-1-alexander.deucher@amd.com>
 <DM5PR12MB2469BFC66394EFEA7625B131F17F9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CADnq5_M1uVqbdJyRyW0zZzKy3rF8FmRQseggr2g3arREKQQk2Q@mail.gmail.com>
In-Reply-To: <CADnq5_M1uVqbdJyRyW0zZzKy3rF8FmRQseggr2g3arREKQQk2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-24T08:11:02Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=679bed30-5de3-4e5d-8e04-728703eab7af;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-24T08:19:01Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 85748320-a9d2-4113-8cdc-40d821120562
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78275d08-0385-4df7-2c45-08d9c6b60c86
x-ms-traffictypediagnostic: DM6PR12MB4387:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4387FC653B2DA3B1EB83AE25F17F9@DM6PR12MB4387.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUGIMHeUR61dfnqAV+NJHZRIqhPerkhli3tg1iw/xCw7opHi9a4i5by1S/6XdOaTVG+7MKrVs7Wtb/aZYL0zJhS8aFjxAuFyUpR/SHdNBZ5BLcws6ZLUV83jpPwqfpiHC6ZW9KZyUMr1Bzm4YSvCx+72VQlVolRA4eVIMubQM928aJJzTjbZcMACr3kAe4AqQP+2yBeAG+pSIZPQumm04BKez7kg6HzhRPZ3yFl2FItW0SviBW5pmQkR0d94iIwrXgQcpJLZubxzlaI/C0hePuACxL/33b32gkfxkzhDUSd+dqrzCZnBmO1kdqZox2y4ltcnKtsTVThDA49doHMARfE03a0L8MBwfXr3BzUMOXBrwXMcR4EhCtyQCk8wVYVOdEryVxXpLTUMicIcVKbrKQvTKo1x+Us2eGDNjLIwntEOqO9eKseP0Q39HTs2TWVzhcsBH0d+xDatt+tbf9mYKntbt4HbmMtulhsMXZzhjBsHLFFiuEbEU3zlFwxJlEfcFMhzxH6f/ZmIkvSjtnwkIByOR3ltC8cpmjoAzM/pTrTREWW46w/PcWE7MCA5bhHFs8N0TzSJsj3AWK0ul2GbyYdJOtMNirS+hZPUNZb8i0Uy231Vn6WB9kCbttxq1q8OM3yd3CJFpc+lKUaiej7Y+1Ve/kczwswXAdaxg5bychtGZ4fRkpXrKE/XXXxxSgls4afQLAKhD/piMyvAYsBq0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66556008)(33656002)(64756008)(66476007)(66446008)(6916009)(2906002)(9686003)(8676002)(38100700002)(54906003)(122000001)(52536014)(316002)(7696005)(71200400001)(86362001)(53546011)(8936002)(38070700005)(508600001)(4326008)(83380400001)(55016003)(186003)(6506007)(26005)(5660300002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0RtNk5iZnBMQm4vaG9hT2Z0d3JPNWsrdVNCNVVFcWJYalNvQmFsT3plVm5h?=
 =?utf-8?B?VEduc2hwTVdRekFWYUQvUEg1bHZyQ0paenBxR0lreSsxRER5cFgxczduelNy?=
 =?utf-8?B?dlJLTTBNVG5hcjl3eHpZNTQzbnZjMFY2WmdLNHRMSTB2RmR2QnFTWlNUeG5H?=
 =?utf-8?B?eXdud1ZMeWVxKzNRbFNhdkxMeFFOWE91N1V4WldzMFZONkpCSTEyWU1LK0pp?=
 =?utf-8?B?ckc1MzRlbnlVbG52b3hCLysxQTNTa25zajZ2TFlXZ3d6Qng0V2RiS0xGWG5F?=
 =?utf-8?B?WExGZDg0cFdqdkYwNk9mTmRUVzRpTC8wYjN4QkZsWmQ2Rjg0aUpBV3BwYklS?=
 =?utf-8?B?eW8xak4veEtKMXJHRk5WSW13YkwxSjFpVkpCSDUvWG16SFk4YVZrbWdEcDlN?=
 =?utf-8?B?K0Z0UFdCcGw1QWtnQTBjNUNyZUtYWWdjcWNSb2ZrdkFtcWFRTXhTV2lVRVZx?=
 =?utf-8?B?VFhGRHNnZTBLc3NsWnYvUjRvTFNCNkFtMUROQmF5WWVDc0dhTmd0MWQwVkRN?=
 =?utf-8?B?R0xwMzUrU3ZEMGhVZkxYa056clZTdGpBWW4yZ0hZbjNDdG9FNHhXNzRmWDIz?=
 =?utf-8?B?eUhtOWpBV3V6YzVDRW5WNlhtQWhrSlo1RSt1K3RkQ1N0ZWtMQS91TVJQSzlq?=
 =?utf-8?B?N1N5MThMMFJCdXdmc1R6Z2VlUGZ3OFpQeGxNWXkzc2hFZEtzcGRLcUgzcHc4?=
 =?utf-8?B?c2UvcnA3OCthTTRYQTNVa3ZxcW93bzMvZ2RnaVN1bG5YMmNXbUZIMTg3dnZW?=
 =?utf-8?B?WGNsUkthUk8xUC9NM1A5M0hFVm1KY3loWE9BWnVLSXBSR2diT1FlRDZnOE9E?=
 =?utf-8?B?UFVMUS9LMld6VmhGUmdXU2x3ZFFEUjJoY3dsQkRlb2lDK0hKbEE1WU5RU3lk?=
 =?utf-8?B?UE1maytZWXJkUlE5SkZrSlkvK1VRRzBja1lXMFk4VWJ6L1FlaHI5NEVUcTdD?=
 =?utf-8?B?ZXdtajVjRkJjaE5FVVVyVDRkVEtWSjNzNzhXcTI2aUJiM2U2WnBFZDBKS1ha?=
 =?utf-8?B?akpRMFhJS0RrRHo0YjhJSFV5em1BWHJGUnFFYjZndFJrTElFU1hJeERYdDYx?=
 =?utf-8?B?a3E3QnpkbFhhaDI1Q2Z3SUZ1Mk1ZdFdmd2xrcjkwcmdpcE13aXVBMnZkSStJ?=
 =?utf-8?B?YjZTZmZhWURvTkcrc2dBUXQrZ2E0WDJUR0tHN2R0YlEvamptT2l1ZHdMV0lC?=
 =?utf-8?B?MjRqVXd6N0VhZXBESUl1dFYzMlpuRnhmekV3S25wR0RoeUh1MENNK1FaWHZp?=
 =?utf-8?B?cmhVdTBYK2cxTFUwb1JpSnM3NC93Tk12SWU5MCtPQy96VTlpRWlRdUdQVUVU?=
 =?utf-8?B?YkNyZmpic3VCMmpHZVNCV2hTSStJZEFrQWxIUnIyZWFXMThXVlp5UVM1Ylhp?=
 =?utf-8?B?dmRYTUIvWkI5ZldaVEM3ZkVLRGZkYXRzNDdCVjJLOGJPMWVBT2R1LzNhUW5D?=
 =?utf-8?B?T3dmZ0F5bEFMdmdwN1RRaDBUTWxvMXZWTVBTUWI3eVBhcHNkL2VmQU4vT1hP?=
 =?utf-8?B?TldYM250ejVJNTVwYnI2bjhyZU02N2svQ1NTeC9vZjN3eUNnUm9FeFV2STNL?=
 =?utf-8?B?a2VPalV1SGs4U2I2VU4vaCtSU05GNDhDQUVpMGpnYkdMaXh4eVFsalpvVVVR?=
 =?utf-8?B?aTJKajdPWE1xZktIREZaK0dKb1hZS2N3WUxhMFI1NXpxNnRQamhacHYvQjVN?=
 =?utf-8?B?cW5NYlhpZFhrb2g3TENFNEhCZ0Y5WHA5RWMxNmx1bWYydHFzODJHcWtUTHcy?=
 =?utf-8?B?aGVmTzRGNGJSZUFIWkEzY0NYMjljMW9jWDF0QWptTXZLQW5YcVhQQ1JnWGlv?=
 =?utf-8?B?Ly9yMCtlWmVwVzVuSUxhb01JdnFRY1RMQmNXcW9GL3llQUxLSVpGcVdUZHFx?=
 =?utf-8?B?clVZbDhKZkpaczlRcTdPNDdJOUtDOE5TSzdKTDhHNHpYSXM1NU5sMTdUbVJX?=
 =?utf-8?B?aU9Vb2kxazRZOWxJNkxQZXFZNUVkazNHVmMvWDA4SnM0MnF5cGtvU0M0QjQ0?=
 =?utf-8?B?NHlhVUYrL2VCK2pLdk1lR1Q5TUJpNjFkYXFNUUlXOUpRckJ1Ti9aSENwbW1I?=
 =?utf-8?B?MlprOEZLdml5ZXg1ajBVMFBWcHhPdEcyQXMxQlNEY2tWWkJWNVRPd1pBeGp6?=
 =?utf-8?B?eklnV3YyNTNia0I0eWxHTDdJQ2hGdXByejFUcHRQci91M3NjV1Y1MEZvZ3Rh?=
 =?utf-8?Q?iBicZSXxUVG6uWanbBD8sxU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78275d08-0385-4df7-2c45-08d9c6b60c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 08:19:04.5478 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09YmQeEc1cybKAqa8hYm9g18/vDdLu1v5c50dh0w+uZUfg5Sk25MS5wJ4SA7vevcaW0tjE+N6d/qTyrI3jOvSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
 "tarequemd.hanif@yahoo.com" <tarequemd.hanif@yahoo.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KSGkgQWxleCwNCg0KVGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uLiBUaGUgcGF0
Y2ggaXM6IFJldmlld2VkLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4gLg0K
DQpNeSBjb25jZXJuIGlzIHRoYXQgYW1kZ3B1X2RldmljZV9oYXNfZGNfc3VwcG9ydCBpcyBjYWxs
ZWQgYXQgbXVsdGlwbGUgcGxhY2VzLiBCZWZvcmUgdGhpcyBwYXRjaCwgZm9yIEFSQ1RVUlVTIGFu
ZCBBTERFQkFSQU4sIGl0IGdvZXMgdG8gZGVmYXVsdCBjYXNlLCBhbmQgcmV0dXJucyB0cnVlIGJ5
IGRlZmF1bHQsIGJ1dCBoYXJkY29kZWQgSVAgZGlzY292ZXJ5IHNldHRpbmcgZ3VhcmFudGVlcyBu
byBEQyBpcyBpbml0aWFsaXplZCBvbiB0aG9zZSB0d28sIHNvIGZhciwgaXQncyBmaW5lLiBIb3dl
dmVyLCBhZnRlciB0aGlzIHBhdGNoLCBhbWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0IHdpbGwg
ZXhwbGljaXRseSByZXR1cm4gZmFsc2UsIGFuZCBhY2NvcmRpbmdseSBpdCBjaGFuZ2VkIHNvbWUg
c2V0dGluZy9leGVjdXRpb24gbGlrZSBkcml2ZXJfZmVhdHVyZSBvciBpbiBzdXNwZW5kL3Jlc3Vt
ZS4gSSBhbSBub3QgcHJldHR5IHN1cmUgYWJvdXQgdGhlIGltcGFjdC4gQW55d2F5LCB3ZSBjYW4g
cmUtdmlzaXQgaXQgaWYgdGhlcmUgaXMgcmVncmVzc2lvbi4NCg0KUmVnYXJkcywNCkd1Y2h1bg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+IA0KU2VudDogRnJpZGF5LCBEZWNlbWJlciAyNCwgMjAyMSAyOjE2IFBN
DQpUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KQ2M6IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyB0YXJlcXVlbWQuaGFuaWZAeWFob28uY29tDQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBubyBEQyBzdXBwb3J0IGZvciBoZWFkbGVzcyBjaGlwcw0KDQpPbiBUaHUs
IERlYyAyMywgMjAyMSBhdCA5OjU0IFBNIENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNv
bT4gd3JvdGU6DQo+DQo+IFtQdWJsaWNdDQo+DQo+IEZvciB0aGUgZmlyc3QgdHdvIENISVBfSEFJ
TkFOIGFuZCBDSElQX1RPUEFaLCB1c2luZyBhc2ljX3R5cGUgaXMgZmluZS4gQnV0IGZvciBDSElQ
X0FSQ1RVUlVTIGFuZCBDSElQX0FMREVCQVJBTiwgSSB3b25kZXIgaWYgdGhlcmUgaXMgYW55IGRj
IGhhcmR3YXJlIGhhcnZlc3RpbmcgaW5mbyBjYXJyaWVkIGJ5IGhhcnZlc3QgdGFibGUgaW4gVkJJ
T1MuIElmIHRoYXQncyB0aGUgY2FzZSwgSSB0aGluayB3ZSBjYW4gZHJvcCB0aGVzZSB0d28sIGFz
IHdlIGNhbiBwcm9taXNlIGl0IGJ5IGNoZWNraW5nIEFNRF9IQVJWRVNUX0lQX0RNVV9NQVNLIGlu
IGFtZGdwdV9kZXZpY2VfaGFzX2RjX3N1cHBvcnQuDQoNClRoZXJlIGlzIG5vIElQIGRpc2NvdmVy
eSB0YWJsZSBmb3IgdGhlc2UgY2hpcHMsIGJ1dCB0aGV5IGRvbid0IGhhdmUgYW55IGRpc3BsYXkg
SVBzIGluIHRoZSBoYXJkY29kZWQgSVAgZGlzY292ZXJ5IGluZm8gaW4gdGhlIGRyaXZlci4gIEkg
ZG9uJ3QgdGhpbmsgdGhpcyBzaG91bGQgYWZmZWN0IHRoZW0sIGJ1dCBJIHdhc24ndCBzdXJlLi4N
Cg0KQWxleA0KDQoNCj4NCj4gUmVnYXJkcywNCj4gR3VjaHVuDQo+DQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiANCj4gQWxleCBEZXVjaGVyDQo+IFNlbnQ6IEZyaWRh
eSwgRGVjZW1iZXIgMjQsIDIwMjEgMzoyMCBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IA0KPiB0YXJlcXVlbWQuaGFuaWZAeWFob28uY29tDQo+IFN1YmplY3Q6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogbm8gREMgc3VwcG9ydCBmb3IgaGVhZGxlc3MgY2hpcHMNCj4NCj4gQ2hpcHMg
d2l0aCBubyBkaXNwbGF5IGhhcmR3YXJlIHNob3VsZCByZXR1cm4gZmFsc2UgZm9yIERDIHN1cHBv
cnQuDQo+DQo+IEZpeGVzOiBmN2YxMmIyNTgyM2MwZCAoImRybS9hbWRncHU6IGRlZmF1bHQgdG8g
dHJ1ZSBpbiANCj4gYW1kZ3B1X2RldmljZV9hc2ljX2hhc19kY19zdXBwb3J0IikNCj4gU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDggKysrKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyANCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gaW5kZXggOWRjODZjNWExY2Fk
Li41OGUyMDM0OTg0ZGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4gQEAgLTMxNjYsNiArMzE2NiwxNCBAQCBzdGF0aWMgdm9pZCBhbWRncHVf
ZGV2aWNlX2RldGVjdF9zcmlvdl9iaW9zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgYm9v
bCBhbWRncHVfZGV2aWNlX2FzaWNfaGFzX2RjX3N1cHBvcnQoZW51bSBhbWRfYXNpY190eXBlIGFz
aWNfdHlwZSkgIHsNCj4gICAgICAgICBzd2l0Y2ggKGFzaWNfdHlwZSkgew0KPiArI2lmZGVmIENP
TkZJR19EUk1fQU1ER1BVX1NJDQo+ICsgICAgICAgY2FzZSBDSElQX0hBSU5BTjoNCj4gKyNlbmRp
Zg0KPiArICAgICAgIGNhc2UgQ0hJUF9UT1BBWjoNCj4gKyAgICAgICBjYXNlIENISVBfQVJDVFVS
VVM6DQo+ICsgICAgICAgY2FzZSBDSElQX0FMREVCQVJBTjoNCj4gKyAgICAgICAgICAgICAgIC8q
IGNoaXBzIHdpdGggbm8gZGlzcGxheSBoYXJkd2FyZSAqLw0KPiArICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiAgI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURfREMpDQo+ICAgICAgICAg
Y2FzZSBDSElQX1RBSElUSToNCj4gICAgICAgICBjYXNlIENISVBfUElUQ0FJUk46DQo+IC0tDQo+
IDIuMzMuMQ0K
