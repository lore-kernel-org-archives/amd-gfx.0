Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802B3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 14:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF6710E2F4;
	Mon, 11 Apr 2022 14:12:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F82310E2F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 14:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5toIqNuQWL3YNtwtGVEFNT3RDk+dVz3LNga7IrU6yXsnvyTtLtQGxmS4juixuPn+1bXyc1nwOEGhmnmRI3+Uv4oBUQ2+lTttwVu9XFD54XFk54R8MeIoOUE9ceYxd09lzUt7+RCnerYjv9ZYocUb1u7pJgFzzFW4DMm6QcPiqrQqLSPiukNDzpI603XQSz+WHJmsYG0dIAFKG1/b2iCp+9KUG03a6vQVLmnjsAaz/m6WFZONEMN1l+gGF8zTEc8MoePXj6geds+xGi57sAfKGB9TIt62yB24KYaFpWj28R5DLIeei6BChTl45cWu9EMJ2aTSsg1Yqge/tDknYNFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU1lqbBNUq5lV29JCav9F2uYTL1fWlP4UT4B3AEx8VQ=;
 b=GVoU7Y3ePXDtx3dqwS1JhJN76XKArusHuwK0IMm/UuV0U2b4NdrIxF3a38Lp0ciYLxkzvpFVEL9uKHXSHL2YLWlqhtGCCTSepTsilTSv9vDIWoHt9UglIDp4Nc5Zfw5XFDTcyjQE9alWJoh6p2clKz7xM/OluwTE5AJjWyCXCCc4yStmXmIZBzLuzQWnjaCsWD+7tKXQkA+r2OrgIok7LseY+Ait+kWEEU+TRXX/ZcNuieQW1OTQVStXpFWNXpjjQtCbybJ6avbs+d7QOPJ6OEPl4iRZoFfrd5nyxC7AKVK6XQD2wbGe1oxWCiiLaA0JFUmdkeApk3CqKc85Fzb/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU1lqbBNUq5lV29JCav9F2uYTL1fWlP4UT4B3AEx8VQ=;
 b=iDjNuhN7/g5f+1TPEhonEsz2y8w0JEkKnKWNkK0QU5tBjBC77uA6Bhrs4Aqw0i/O2/568jnI8v2J1Ec883gAnCuHaul6ElTOGrH+QsYzPRkAbDTgGl8VXYHIg+C5prQELvA559KalVMNqHuIv8tBkfvi6fNOE8AW0GzZNREC/8k=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by CY4PR12MB1895.namprd12.prod.outlook.com (2603:10b6:903:11c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 14:12:08 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::89e5:94d7:69f4:603c]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::89e5:94d7:69f4:603c%8]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 14:12:08 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ziya,
 Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBhZGQgcG9pc29uIGNv?=
 =?utf-8?Q?nsumption_flag_for_RAS_IH?=
Thread-Topic: [PATCH 1/3] drm/amdgpu: add poison consumption flag for RAS IH
Thread-Index: AQHYTZSHO6LZJId0zEGItrUkSYoTFazqs1hg
Date: Mon, 11 Apr 2022 14:12:08 +0000
Message-ID: <BL1PR12MB5334047390308672B445C7559AEA9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220411110825.18808-1-tao.zhou1@amd.com>
In-Reply-To: <20220411110825.18808-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=08114bf4-abc2-4172-b902-c897ce91c910;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-11T13:22:54Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca764f12-584a-4417-acf1-08da1bc5437d
x-ms-traffictypediagnostic: CY4PR12MB1895:EE_
x-microsoft-antispam-prvs: <CY4PR12MB18954C0151D1628EB58A98319AEA9@CY4PR12MB1895.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PpGajLe+HRVjv9kxqzBENHAeLgKOVaJp1Hs8d0+Tkf7QbDzq5l5XWuRaw58b8mwJzNNgHD9QRdbBGSGdjmTkiE2kEhjWEkEJqvfUIdel9A914n9zgGW4i9R3GOx6UvhqnOHyn/pXKpXvbde5RlVaOatLVvXiIj6pn3na1SOPUxFnHA+KugNzbp+djftaumVI8I4awSBfs9SkaSnMCiS+sXpVvRAKh12bAaK5yg790WYL0a9FJkl1sHIrbXEPFhlz3SM1IFuGvgYpHdMvaZMO3u98b+lxdMPnX4ZAh98uDTTim0IZmZGgkbGm7HDg4FiDvK4/k49xy29P/nD+acQ2aqbQrrn1F6du+IoJOUfJFKlDGdkb9C0W+16AkSdnjgCYx7TS/M3oHZVDL65oPq6xIoswCJxn+7ugY+iD3U3UJ9h6d57QQPSr9YA41uB3B6HncSW1ZZ1NEIdp7gARMO/OVsf4mYbROgWP290veaBytUa+VASylwXjQ1vKyuikYItEj+lXqBT/wp8HXKD2LumSstkxOptbPT3wDuWgDNQ5xQBksaqbAdASDTsAjyuxnDe1sinW7NRUn3V7+mXWjlXvZD+uSDeUy+sgdgs7hIg8xcDCEYNeeghRqIzW9bbwEiHZwDfXR0Z1bFiuqfe74gBcSoXIm1vuD6ffDPGEpwZcyYKavgXIMZKnCGY1wryuKH888y/+QkziJ6NlDvcIcyNRurOC/60K9BRNRnSqCdi77pI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(64756008)(66946007)(66446008)(110136005)(52536014)(66476007)(66556008)(76116006)(316002)(508600001)(921005)(122000001)(38100700002)(6506007)(7696005)(9686003)(71200400001)(6636002)(83380400001)(38070700005)(33656002)(8936002)(2906002)(224303003)(55016003)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHVHUVpHbEZXbjdJRDRwOUd0TFdXRWVuOW95enEvbXJhbE5kcFZqRStKS0F5?=
 =?utf-8?B?cWttQ2NMZmh1SkJhTVZXMGJ1a3VseklpOVN3b1FZTmNjN1JMU1VaRFBqMnUr?=
 =?utf-8?B?TEtaSVNZTDRjS3NmRk5kUXBxM0RidnpkU3dSSlJlUE0vN29qTzRtQWo2a2l6?=
 =?utf-8?B?K3hpQVQ5VmlWSHNLcnBKOVg0RE1jWW5FeU1VWVFkZHlHT0VqSk0yeUZwam5p?=
 =?utf-8?B?ZEgxWnlZQ3IycDEveEtpbWZub1U1OFlYYXdPQ2ZzeXZ4QTFXbVoyVnlPNy82?=
 =?utf-8?B?YzZ2L3R6SzV2cVk0UFZOTjFTM1grNExVb25VemlvM1JwamFvYWdlUU5KeGNW?=
 =?utf-8?B?MFpOMk0vcjljUVFvMWNJU0x6ZGlOUTFEaW05ejZlRzdYTHpRb0xUMDJnOVJi?=
 =?utf-8?B?enphUlRsdVNvVyszZXg2a3BIN1prRFNpNDBjV3AxZmpaMTBGWUd3NnpINDlr?=
 =?utf-8?B?TklNODUrY09YZGo1akcxOXcxTGZ4Rjg3MGlJTWRLdWNsOTQyekV2S3p1WmNt?=
 =?utf-8?B?YmRmWDEzTHdKekxleGRBdSs1aGFVdWZWanJyZXJ0MDJ4S3dBS2Vkc2duZGY1?=
 =?utf-8?B?c0pOenRSc0xCMTFtWkxUUDNxRm43ZnE2UWdtUWxsaGtxN1g0U1hSUitYUGxN?=
 =?utf-8?B?S3IzR2xBUGlTV3BxOEcvS2lRUHlzUkNYWm4yREUybHlKYzhNSTMrejd4c3Vq?=
 =?utf-8?B?em5rYWh3RGVWMVBwc0dpQjloRitPTXk4MVM1MVBudWtodDFid01vZFpEbS9m?=
 =?utf-8?B?SWN6NHZPWEtQRThDd1ZSb3ZjNG9IeVJKUEFNK2JrT3B1OE9HYkxJQzF3MlpV?=
 =?utf-8?B?WWtucHZFMVVnc0RlZzl3U2hUdnlCaFUvNmdsN1J5Mm1hL3dCMnExWElzYWIz?=
 =?utf-8?B?MElFNlBzMXljeG1hUERhMi93TVNOdTB2WVBvWDBXeXVRc1FEek9vWlpMWjlG?=
 =?utf-8?B?YXdsMGgweUpNZTJvTWNhRlRwckJtSHVqUFhNNWFTZVpNbGZJQnJBaU42RVBw?=
 =?utf-8?B?Zk9VcWtEQkt6RjhMb3Z0dDhVTTRvNktLcnJNY3VQUDVxZmlTWnhwbW5MNDNJ?=
 =?utf-8?B?N3dSd0ZLVU4zVE8wYU5BUXlVZUZydUYzTlkxSGxaOWxQcFNNSjB1ZnVkZnZh?=
 =?utf-8?B?MllvUFJoVkJUMm1YTmxpYlpnQnlpdDlhVXhkSnBiME1aaVlZNjJ0UXkweS9N?=
 =?utf-8?B?alNtUVRWVDNzbWJTdzhybW9PNFVEU2xXNC84aG5mWStvM1FJR0g1VzNiL0Fv?=
 =?utf-8?B?KzZzRlVVektYMTlNa2RvRXZCTU0wQy9VQjEwWFJCZEZxVzZtRmFSRklhb09x?=
 =?utf-8?B?dWFTM2prdHNMdTZXOUlON21TZHdwdUFEQWc2QXVTbG1hdWNaRlR3cW1CNkh6?=
 =?utf-8?B?U1oxZGNKcWpuUGZFdmJCTTQ4ZEI0Ti9xRnB0MUdNV29yUGRuZE4yVlpaS2ln?=
 =?utf-8?B?RGJ2RWpKWmNkeUJBVTJMZ201M0Y2VjNHMkdjbTRSQitiVGtMQ1JNS1NwbjNv?=
 =?utf-8?B?eVVSaHV1RFk2UlF0cDdYSE5VbkJZVWFzNFlIMVYrY1MwbE5wVFFEcjc0WllF?=
 =?utf-8?B?eW9mRTNHL0JjaVBQRE1zbUZtbkFySy9IWmpGQWJzdWUvQ2I5eEJ2emRVSXNU?=
 =?utf-8?B?UmkyWjN5anl6ZjdtVzE2TklGRmN2T1B6Njc0SWtDT0UvYkFKbjRDN3FHSWMw?=
 =?utf-8?B?eTY1T2tBKzRvT0lGUkhkMjBDc1Zhc0hmT0lkK1lVQ2VubnJYb21PUDVjNGs4?=
 =?utf-8?B?Sko2cHBNQ2dYSlVYYTdNenBhUmZtaHlyZWRNQkFYSlE0R0VVbG5XdHVQWHcr?=
 =?utf-8?B?S1p2L0I5dWZBbS9hZWVKeDFFMmVWNzMvellNM2lCR2plRGdaSHVmaEM1N2o2?=
 =?utf-8?B?UGh1bnZVS2RFTEdNcWdpejlCc1g2YVoxdlh4WWllSVdEdGgxZlB2RmFWSDh2?=
 =?utf-8?B?M2ZPY2VUNHVNUEJOODk3WEc3b0loekZuOFJrSHBWeitGR01kL0R4R1hhd3lB?=
 =?utf-8?B?LzcwcXhhdzhzUmhneUlZMmQweTZtbzZ0Q1J3NXdTZzdTaHB6cUprVU0vRXRw?=
 =?utf-8?B?anY5aWgwem9DcFdxRTFHU2RpK2NEU1JMemFUOXFnMXo3WjhOOXdZUkt4dkRR?=
 =?utf-8?B?TXJuaGF2VmF0dkJlL0xJbExHSnZmTWJ4MldlOEpGcTVBckF0UXkrT05aQ3BV?=
 =?utf-8?B?dGd0SzhmK1FnSjhxYzZsOEhVYXBFNEJlMHAya08wOXI1cGpBcFNuOVNpL0RR?=
 =?utf-8?B?bmJGelpFMUhYdVdsbW0rd25GQlNSYk14eXllUmlsU1VHblBMZHV0UFNPZFZ6?=
 =?utf-8?B?bFNCL3hIbUZiSU1yNWFxbFlaQWpvWm9pOStqQWlmMlB5aWtPR1JxelVmY0pD?=
 =?utf-8?Q?V6LMkUlgCCemmGgSpOQofrr/Yzyk/i+AKTjqV0fO0BJbN?=
x-ms-exchange-antispam-messagedata-1: cXP1UUdVk20bYA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca764f12-584a-4417-acf1-08da1bc5437d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 14:12:08.0539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8W6injvxUhMwbq0VKe8yr5+nfCGJ/uQ1peRltvh7ovnlsBoe8aKfoUOliQ90fb03bSAxOJ9qeV4lNSTI4x4fqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1895
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgVGFvLA0KDQpBY2NvcmRpbmcgdG8gdGhlIHNl
cmllcyBwYXRjaGVzLCBJIGhhdmUgb25lIHF1ZXN0aW9uLCBpcyB0aGUgcmFzX2loX2ZsYWcgc2V0
IGFjY29yZGluZyB0byBwb2lzb24gbW9kZSBjb25maWd1cmF0aW9uLCBpZiB5ZXMsIGRyaXZlciB3
aWxsIGhhbmRsZSBwb2lzb24gb25jZSBnZXQgZWNjX2lycSBpbnRlcnJ1cHQsIGJ1dCBhdCB0aGlz
IG1vbWVudCB0aGVyZSBtYXkgbm8gYXBwIHRvIGNvbnN1bWVzIGl0LCB0aGlzIHNlZW1zIGNvbmZs
aWN0IHRoZSBwb2lzb24gY29uc3VtcHRpb24gZGVmaW5pdGlvbi4NCg0KUmVnYXJkcywNClN0YW5s
ZXkNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFpob3UxLCBUYW8gPFRh
by5aaG91MUBhbWQuY29tPg0KPiDlj5HpgIHml7bpl7Q6IE1vbmRheSwgQXByaWwgMTEsIDIwMjIg
NzowOCBQTQ0KPiDmlLbku7bkuro6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsNCj4gWml5YSwgTW9oYW1tYWQgemFmYXIgPE1v
aGFtbWFkemFmYXIuWml5YUBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPjsgQ2hhaSwN
Cj4gVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KPiDmioTpgIE6IFpob3UxLCBUYW8gPFRh
by5aaG91MUBhbWQuY29tPg0KPiDkuLvpopg6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IGFkZCBw
b2lzb24gY29uc3VtcHRpb24gZmxhZyBmb3IgUkFTIElIDQo+DQo+IFNvIHdlIGNhbiBkaXN0aW5n
dWlzaCBSQVMgcG9pc29uIGNvbnN1bXB0aW9uIGludGVycnVwdCBmcm9tIFVFIGludGVycnVwdC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaCB8IDcgKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+IGluZGV4IDYwNmRmODg2OWI4OS4uMzgwZjRjMzAy
MGM3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+IEBA
IC0zMTQsNiArMzE0LDExIEBAIGVudW0gYW1kZ3B1X3Jhc19yZXQgew0KPiAgICAgICBBTURHUFVf
UkFTX1BULA0KPiAgfTsNCj4NCj4gK2VudW0gYW1kZ3B1X3Jhc19paF9mbGFnIHsNCj4gKyAgICAg
QU1ER1BVX1JBU19JSF9QT0lTT05fQ09OU1VNUFRJT04gPSAwLA0KPiArICAgICBBTURHUFVfUkFT
X0lIX0xBU1QsDQo+ICt9Ow0KPiArDQo+ICBzdHJ1Y3QgcmFzX2NvbW1vbl9pZiB7DQo+ICAgICAg
IGVudW0gYW1kZ3B1X3Jhc19ibG9jayBibG9jazsNCj4gICAgICAgZW51bSBhbWRncHVfcmFzX2Vy
cm9yX3R5cGUgdHlwZTsNCj4gQEAgLTQxOSw2ICs0MjQsOCBAQCBzdHJ1Y3QgcmFzX2loX2RhdGEg
ew0KPiAgICAgICB1bnNpZ25lZCBpbnQgYWxpZ25lZF9lbGVtZW50X3NpemU7DQo+ICAgICAgIHVu
c2lnbmVkIGludCBycHRyOw0KPiAgICAgICB1bnNpZ25lZCBpbnQgd3B0cjsNCj4gKyAgICAgLyog
aW50ZXJydXB0IHR5cGUgZmxhZyAqLw0KPiArICAgICB1bnNpZ25lZCBpbnQgZmxhZzsNCj4gIH07
DQo+DQo+ICBzdHJ1Y3QgcmFzX21hbmFnZXIgew0KPiAtLQ0KPiAyLjM1LjENCg0K
