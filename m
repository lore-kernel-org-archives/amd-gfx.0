Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DEBC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Feb 2022 01:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E59810E128;
	Sun, 13 Feb 2022 01:48:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F3210E128
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Feb 2022 01:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOwnt0yqi7lHRxk33nINRL11OWFGRK3iaG717RIB0QnmI8AHvEwmyUIXXgAFIBgMFlHr+ejHQWL1kBCexXTU8IJJvUZ7mm8/R00pRGkOKst8Bua9zOvCO9MMsr92l/KRehw39WJZNa1foYnU2BPTd2PBKarAyGaLn2Ed6xCtSFPyYWNM6ww6N4DXXjJWZwD/Z0Lv7rcHRTSxkUKlUZfSAxV4j8OOdsbsnFacXAld2z6KfnqV/eyGxiyKv8sIaRl9ilBpUi4mIk/u1uiNhAEhRHdpKBuiWe6+hCds3rrwCTHSY/eX/CLNj8dbxF40Zvqe4JyQ6oEjpiaVlvFKfPc/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQF9oER7qESvTW2p3tHiFy/+ETAajbMOYe03KW1Je08=;
 b=JJ3ka04QbELGHndPHwTSXUaFg1r8glCl/OFiB9nf3l5D04eI/yruGvjMhpHfbC0m02HtsnS1/gby9iU5OC6xRTm1KaOHUgFRy/60s3Io11ajFK2f/2z+TnUYqacsCPG0lHMPDsTzaMBchvdET7X00oip9czqL/liU0Ngyi6TVn3CCUuH/qPzIpH01s53gv4KONh/4hSI8Y4Q1VqywOFiAt/4vRHGGMDk9IB4u5Lzd3ysbpLoaN7C6cg9shAOU48JU7ClN5Y5xQleeId8ULlpdZ/cwmmvdaizommpnsbG1XuzONrDxfIzhC0xalqG9zxvh9aZ4OoSxzrtlfwYhMx5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQF9oER7qESvTW2p3tHiFy/+ETAajbMOYe03KW1Je08=;
 b=m1KQTy+zW+A7HRchW5151lmvXa/YapLwSauh2iP817oITM6tJrAYI5RF84GwMnn2ugcOXnbHa1xvS3kWaihFmZWPTAiLtQSEOsV/Iu/62sDnOPCkXNxEK4BeRdloWsEGVjbVQRUZWhqt1Jd9up4RYe9e0kO+e3l3mRY2MYIuWZc=
Received: from CY4PR12MB1797.namprd12.prod.outlook.com (2603:10b6:903:124::8)
 by BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 13 Feb
 2022 01:48:01 +0000
Received: from CY4PR12MB1797.namprd12.prod.outlook.com
 ([fe80::15e7:a19c:8a0d:8ec1]) by CY4PR12MB1797.namprd12.prod.outlook.com
 ([fe80::15e7:a19c:8a0d:8ec1%11]) with mapi id 15.20.4951.019; Sun, 13 Feb
 2022 01:48:01 +0000
From: "Xue, Ken" <Ken.Xue@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove ctx->lock
Thread-Topic: [PATCH] drm/amdgpu: remove ctx->lock
Thread-Index: AQHYHyDLXnqeAmnI6ESalPSQbkZHpKyOp84AgAIQsBA=
Date: Sun, 13 Feb 2022 01:48:00 +0000
Message-ID: <CY4PR12MB17971300CC1EBD3DF418BEBAFB329@CY4PR12MB1797.namprd12.prod.outlook.com>
References: <20220211082410.31186-1-Ken.Xue@amd.com>
 <11104985-f99c-0c7e-490f-c489704d3f3d@amd.com>
In-Reply-To: <11104985-f99c-0c7e-490f-c489704d3f3d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-13T01:47:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=32c58858-d30f-4e25-9983-14791bd87f0a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-13T01:47:57Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: af4ccca8-b1d6-4f59-b9d0-9cc54b08d3f7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df163402-1e48-489d-7a3a-08d9ee92de36
x-ms-traffictypediagnostic: BN6PR12MB1124:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1124BF1DB96D49722FDEC384FB329@BN6PR12MB1124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73PtdRRoscZS8alcnfptxDlEqifkpf9yZv2Dxxri8OY9ykZ6se6evSwhi08MHM5OfppHuicwzh1ND/I3VRE/2nN+s0wAntS2+JFBIQVfxO/Mfm4kKm0JPzYOOnbhJsdiDSxw1Rf9M7GPtHIQwYXJJtTBpJtXsWOsPXsL6YDCppVeeKJ3wUofx3CjD/PwA0nNHQ91xSduw/aRJNJgOuzgKd8kQno3zFd9TafdVqm3O/dJhaftN4/Ec8ZPLEooLd7V05xuUv/9EsQ95qaVEIZu0DDFQR1cMwhvLtVoFCKbSKhSsmWV1VA6jcbFdXHGkiPKdi3zXg44TDxnqOyMwsphCElaMWHDCDpp41NaTjBke8apkUMpTRA7gwW0sClVBjO6q3qXjv5RE3XhJMj/yGi46Vu0qSknPVJks7qYMq8loJ+boZOfdL7TftxLrWzjrBY/GozAu7pcOXIKPb1s6Mg/i8p9VihPiwm8mZT8qHJUWPV71OxSSq3cnXvi8lu4EHum6BZ/etwYa13kvqbFYRUFRtLI7yZiGAvt7ugcvZaOkVFCWGB7gQWTZIKQNzH7OAgBwYWMLhINtyi/oqOm/MX+tKWTog2n7VALdDJGmJ4r9pmMTi7UFh9c0T2O/D9D8ubkV/2szy1PqjmkYY63KGE8mmASKFrWn6qccx5+fsy1S4NsFgNAM6EmVx15Vj9q4nNNTc7cZV3JJMSu3jk+KLQKkI01tUurSCPIl8OFSqj6HvjFsXHd7dz20O2r0Tdx03p5pmJsoNwIeY0y2MbBq/3sFpjSkD2OCWfPKalC5dnobXg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1797.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(186003)(6506007)(7696005)(33656002)(55016003)(8676002)(122000001)(5660300002)(9686003)(52536014)(86362001)(2906002)(966005)(71200400001)(66446008)(6636002)(26005)(38070700005)(76116006)(38100700002)(110136005)(66946007)(316002)(64756008)(8936002)(66556008)(66476007)(4744005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVBNmdlamUyNmlkQ2Y0bGYxVGFobE4zYlpac0hjRGh3bGxvVU5yVFJKZDBz?=
 =?utf-8?B?WEJZeWlmV1Z5MFdFSnJtd1dzOHBOS3k0TWlzTjNFbkFHRk5wcTNLeFNxYjVv?=
 =?utf-8?B?TWx4Qk9xSllqVENWZ3NoenpMbzRTZkVhZFVnNEZHd1hsVytDeUFMSVNjV2tC?=
 =?utf-8?B?NVpZVmRhL09kNlhjb3NBdncrVk9SUXgzb3dOTWNGNVRlZkdNLzhkeTFOWS96?=
 =?utf-8?B?VGVkMStBN05vajBaRHRGL0dhYlVEa1RnS3FmNytEQXRoOFAzUFQwb2NUUzhh?=
 =?utf-8?B?cWVIOHpyRE4vTS9jMktXU0Z3aFNkRFJVb3VIVEhRS2VDWElVQTBHd3U3WGRa?=
 =?utf-8?B?Q3AwekRNVExWWGtaT3c5RzRoSVBWQnNGYW9hZ2ZuaThUU1Q1ai9sRGhrRGhP?=
 =?utf-8?B?MS9FdHJVNXRidUJVZXFxbDRXRzVGb1crRzl1Q2xXV0Y2Q1hLTEtDZEJVYnhI?=
 =?utf-8?B?VFpQY0lyM3dkdmxKYkphMElFOVRTRERCNjY5SFJpV1E4ZnhsYUo4T2RwZ3Uy?=
 =?utf-8?B?WjRyM1VCOWEyVmdFR1dHSDMveXFwREkvcTYxNnRTaGZ1U2RQM2YrNXlLMU14?=
 =?utf-8?B?bjlKd3ZuMlBheHVqQkMrWk1VNXY2ZExGbERNTWJmeTJGY1dKNlRHclFMNk8v?=
 =?utf-8?B?UWdaTVdXbTFQdm5hMzMvck9pV3o0Q0lpS1E2TlR1RzZwaDd6RFZLODhBNlp0?=
 =?utf-8?B?MkU2dHIyRGhma3MxdFo2UnprYyt3OG1iM1YyM1pGSlo5dkhUOCsrUHBIb3NG?=
 =?utf-8?B?eGVJN2I3ZWhERTA2S29hbUdpRjFubjZPZ0ZBTGtDNC9rdVZwWStlL3lmZzlJ?=
 =?utf-8?B?a3l5a2lGTGMxQ3dEOUN4SGFpZm5HWGhHM3NRYkczVEhOblRPMzFueXF4Vy9r?=
 =?utf-8?B?OXVYZDdkYUMwQ2VhR2lRMUFzTmhLUWFwWFpkTDdQS3MveUNZb2VLUTZUSG1P?=
 =?utf-8?B?bXVZZGp6MmVkQ0lUL0VuNDRYM1dwRHpUeTVRRXZjUWpWakNtMHhHMndHREs4?=
 =?utf-8?B?Mm9qMmVJMzJ1bDFiT1NXVXJ4SmFHSUxWK1FyMUoyL25ZaXlyUUhhN3RnYk9h?=
 =?utf-8?B?L05iWDk5OS90YzdzbXBiSFVPN3RPOTFwZU5na2YxbXNVdkRHNmN4VEhRYjhw?=
 =?utf-8?B?M2I2ZSs2cTNpd1RKYU5FemM0d2NPd3REUEFtd01LQldvNlp2bGJxMU4zcHlo?=
 =?utf-8?B?Z0M2M3lEYWN5Tk40Wi9jTVl4ZDdYQ3ZkemhiUjNLekp5aG9HMjNhNnJyYWlQ?=
 =?utf-8?B?MUtCZjVBNXhpR3BiVFRKWjlsWlJDdytXTkFBeE9vbksxVlJqSzhrWHkzR0xH?=
 =?utf-8?B?eldLUXpRZFhYeE1uSHRCdG5VcmxnR2tSbkRIL2tUanBVelJNUkxWQ1AwODZs?=
 =?utf-8?B?eDlvcUV3QVlNZmZRNGtiajJNalBpU3RhTHowR29wYjZQdkFmV05LRkRTMXoy?=
 =?utf-8?B?Z3ppbU1pNGM3QUpVL0dndWNjTHY4aHNTSlRIL2VoajhUTDJqUFhwdXd1akhp?=
 =?utf-8?B?UHJMTzd2dHgrZE5WV0VSMVo5WWJqRTVnOWtPR1dJMm1Mb0pzRGtrd3JHTi9U?=
 =?utf-8?B?anZGM21JVFZsZGJST0FIVzFuM3JibTNpa2p5SVZuU1Irc2p5d0l5Nm4xUTY5?=
 =?utf-8?B?enVwNS9INjJHWDNCSC83QlQ2YndqeUd1a1pHeVVhLzdScjhlS21Fem5VUG42?=
 =?utf-8?B?c2Z1MXVUR0FveXN5WmU0STQ3S0hRWmQrTXBUSTI2NUFhalV1b0UwU3VyeVRP?=
 =?utf-8?B?bEZSTEZLVXN3dVAxcWhVWElTWXk3dnBLMkpncFFDdE4veHYvTFlVRFdJcmp5?=
 =?utf-8?B?RkU3aUdHcDNFeUtDcHZwQXdkRFMwZ0NmN0dyN3lCd3lDdmZvQ3dkMGl4TkdV?=
 =?utf-8?B?WFVESVVpRGwzYTBXalBqTGx2ZHAvc2xVRENKZ1Y5TENzRndlRlZoVVplN2Y0?=
 =?utf-8?B?blR4WkJ3YVJ5NVl2S21JTFQ1V0tuUkVkdTBqMmlzWVVYTWdEUFZ4bW96SEp2?=
 =?utf-8?B?WWkybGJIdm8zZ3ZjWGRJaC8zS3dwU3lpZmVFMU94VTZGSm1BdWZBTXdVSWR1?=
 =?utf-8?B?OGtSOEEzbVA4OHRJT2YzOGdTOVJHSm9FNllGciszQTlaYzNESTllalp6bzQ1?=
 =?utf-8?Q?SChI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1797.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df163402-1e48-489d-7a3a-08d9ee92de36
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2022 01:48:00.8196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEDaZzBcwtGuDjVfQQIFB5Iqvh6fyXUR46YwIt8ZJUTMRaiBzhcYggfyPzZ9dMRV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1124
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiA+IEtNRCByZXBvcnRzIGEgd2FybmluZyBvbiBo
b2xkaW5nIGEgbG9jayBmcm9tIGRybV9zeW5jb2JqX2ZpbmRfZmVuY2UsDQo+ID4gd2hlbiBydW5u
aW5nIGFtZGdwdV90ZXN0IGNhc2Ug4oCcc3luY29iaiB0aW1lbGluZSB0ZXN04oCdLg0KPiA+DQo+
ID4gY3R4LT5sb2NrIHdhcyBkZXNpZ25lZCB0byBwcmV2ZW50IGNvbmN1cnJlbnQNCj4gImFtZGdw
dV9jdHhfd2FpdF9wcmV2X2ZlbmNlIg0KPiA+IGNhbGxzIGFuZCBhdm9pZCBkZWFkIHJlc2VydmF0
aW9uIGxvY2sgZnJvbSBHUFUgcmVzZXQuDQo+IA0KPiBKdXN0IHRvIGhlbHAgbWUgdW5kZXJzdGFu
ZCAtIHdoYXQgZG8geW91IG1lYW4gYnkgdGhlIGRlYWQgcmVzZXJ2YXRpb24gbG9jaw0KPiBhYm92
ZSA/IENhbiB5b3UgcG9pbnQgbWUgdG8gZWFybGllciBjb2RlIHZlcnNpb24gd2hlcmUgdGhpcyBk
aWQgdGFrZSBwbGFjZSA/DQo+IA0KPiBzaW5jZSBubyByZXNlcnZhdGlvbg0KPiA+IGxvY2sgaXMg
aGVsZCBpbiBsYXRlcyBHUFUgcmVzZXQgYW55IG1vcmUsDQo+IA0KPiBTYW1lIGhlcmUgLSBjYW4g
eW91IHBvaW50IG1lIHdoZW4gd2FzIGl0IHdhcyBoZWxkIGJlZm9yZSBhbmQgbm90IGJlaW5nDQo+
IGhlbGQgbm93ID8NCj4gDQo+IEFuZHJleQ0KDQpbS2VuXSBJIHRoaW5rIGl0IHNob3VsZCBiZSBs
b25nIHRpbWUgYWdvLiBJIGp1c3QgZ290IHRob3NlIGluZm9ybWF0aW9uIGZyb20gaHR0cHM6Ly95
aGJ0Lm5ldC9sb3JlL2FsbC83MTU4MTBhZC0yNmNjLTUwNmQtNjI0ZC04ZTUwMjQ5NjhlYTBAZ21h
aWwuY29tL1QvI3QuDQpMZXQgbWUga25vdyBpZiB0aGVyZSBpcyBhbnkgbWlzdW5kZXJzdGFuZGlu
Zy4NCg==
