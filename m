Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA67CC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 04:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F078606A5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 04:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F078606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAED89296;
	Mon, 16 Aug 2021 04:26:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F9C89296
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 04:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah9woKkppqC02sdCj1ZQb7jRTSwI8KKqlpguGqjHYWZFxAfNjSa+6FJdyM1ACb+0lQIaMgXX3WAMNbVNVXQ7GPFSNvU6Rq/BlETjgubzG13QHoJg88ZqJJeWtNVx7EJBkwsc0v4gDlNYj4t6v7rfwMHgs9GsFn50C69HwW/SRIbjzHqhanQ11AcyVPDvS3OavvJK3Cjbl/enzoMYkYPJUaabdQ1T9Cf4Q4xRVVzqDS5zVtvjb4M2RWTj1MGCLor0/ai0x5AlWWvyuZXjv3lYRaeJjJy6d0pZrcpNjJz0y7PPhwk/6uvrYmOonuV9fk8ZaXK7jO8T+nWiKqvLYHx7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmNpMvDQGMdjjHr2UuGpnV+g7JH02UMWb0dWt0YnNhs=;
 b=TxkP9oS/aRyiRDyFCZHlqZ3VnXz6H8NjCZ1L/fRc4p4roRbEi5/lt0E9K7rIjxjWidrnN/lxDL6hV5x7fcZAIuKNOG8owp7eyBOXKo0WzZjCxtf9LrtGbFEDESc7E+nIMXSrF3iWdxoZOaAC3zKe22XUC9+jEDC3AsfQ7iQTq+wkFfyycM4X/2QTTUeZYJCh5PsKX5qy7czLL+Av2R091S/BPKTLCJwhcVb0f9+PhajGUCXGhkxyyhR4w7j3Pf4RYldNCyhK7GKSSaEoSmYpFogt0vUVFHsyYG61yROZwp+9IBZnGlh+ojZQC+eJsTZLYnF2oLXxjAtOgVmVOtippg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmNpMvDQGMdjjHr2UuGpnV+g7JH02UMWb0dWt0YnNhs=;
 b=A3Iz5pE9khmNWCJqzeFQSW5amRlXhNw27ID05eT0iAQqrloLzEMIXdaqcEoiy55RIRZDjoCr7tCcUQ3mPQNRnywbcH+8alcOLaJhx09FofeoyOS50F7HwbhTxURFpRZw32brjzBq+SuTy1SaesmJ1agY7HTPpaNcy17+TYacGmw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1834.namprd12.prod.outlook.com (2603:10b6:3:10a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Mon, 16 Aug 2021 04:26:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 04:26:11 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable BACO support for 699F:C7 polaris12
 SKU temporarily
Thread-Topic: [PATCH] drm/amdgpu: disable BACO support for 699F:C7 polaris12
 SKU temporarily
Thread-Index: AQHXkBqXgi4kbOFI8Ue9SHYaagB1TqtxdUsAgAAARoCABBeF8A==
Date: Mon, 16 Aug 2021 04:26:11 +0000
Message-ID: <DM6PR12MB2619C9CB7FE628794D8EC49DE4FD9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210813080933.1348241-1-evan.quan@amd.com>
 <CADnq5_MFk50m_PCys-pkHxbeSfW90rjxCpmhwNe1jEyouB+KRQ@mail.gmail.com>
 <CADnq5_NF-RFPBNqBd_GU0R-XjQzw9_9unYNwnjd6ujNQoD0aPw@mail.gmail.com>
In-Reply-To: <CADnq5_NF-RFPBNqBd_GU0R-XjQzw9_9unYNwnjd6ujNQoD0aPw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-16T04:26:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7e08cd45-1d6a-48d6-82a7-525b06055fc0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 995f47da-4768-4cd2-3b82-08d9606dfa34
x-ms-traffictypediagnostic: DM5PR12MB1834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18347820FFDD9C292B743588E4FD9@DM5PR12MB1834.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jbqQxj+HA2GSxaytxvz1u6KBsTpepS1nMCCgIQGaFgE9Fv1ySBxXyLJ3DAIpOPiE4sypvIszFtBy3Z+HwAhSuI2XWasx0JuZRPyaSNRK885jdY4Pv7ep2gEBEao9kuJdlDAomTKQQuLHndDBt7FCJ6GRDRrcdscEwejTA0ojj97QkStdsesdvtSK0kL5VvOy4FGSFP2LZWeQRBheOuXCCkyFL3VOSQglCoH+oNdCY0GG7M+q5fIzs5UgTqlsiHkz340XdjWyLZyVcQoFljySwzT14RrqIXiLUxje7lGF7MebCI5KRQPasKMeOYuFvmA3TkzX/f6sYMDu5lEM49xe7b9QqFKp4tGiwWqX00RVmlK4nB5qIVZ5xhyG1xfpAdlJMdKPJ5JD23cnsDXkF0JAEa9iTtsaPM80/q2TYd9g8RH97qvZopXRSaB7YGyycMEu7wCLzbn1IrjdtDenS2sFOelXgXnFQGEwVxtEFJLX9E0mu/FATvTCsftFZlBwDdad9uxpf22bJqaVFI/2ehB6RjYfgKeVreaLRhouB5hhDQ5ZQOSYj6C2e9y+jNQf8xiPZVfIckNcsZEJtqIxHqpAuA2M6Tpctm/lNNLfilxN4ax49yHqn8NC1J8GJQjJIMuyxbAt4Y+nz/yMa201WV8nY8II4oEvroC5A1p/S/j9jIkHcRAz0k700OGc1kFa5zuLPyI4YcH/bX+RL/7Jjj3nVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(6506007)(7696005)(9686003)(86362001)(53546011)(55016002)(54906003)(2906002)(508600001)(26005)(6916009)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(186003)(8936002)(38100700002)(4326008)(76116006)(122000001)(71200400001)(33656002)(83380400001)(38070700005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWRscXYxZXpBVk1EM1A2Tk54QkNjSHJMS1F3d3VCRXZpeUsxQTduVlZZcFo3?=
 =?utf-8?B?eFdoS0JyS0N4OS83UXM5QjNYb1BiZ0t0anArcnpiVU9qb3lFbWZpS3JXY1FM?=
 =?utf-8?B?LzczRkZsd2Y0L21VRnBDN1IwSnkwK1U0R0NTbHFGa2ZsMjh6R2JxWStWV0Nv?=
 =?utf-8?B?ci9XYUlPT1c3WW9XSWlRT2lmTFJEQzRWLy9nWU1KSENaaDR5YVR0c0ZibUFn?=
 =?utf-8?B?K2V2VFRrNCtEdzRRK0VJbU04eGdWR2hjVkVvRktYdWVCM0pQNzdoVWxJRnVt?=
 =?utf-8?B?V3dycDh4SlBYZHVMUFFNWWpvTzlrbm5rbG1kamdTcERWQytqVXQxanlCMi9X?=
 =?utf-8?B?WXhlR1RFVllaNFduZnVGRWdJL0pwUzdCcC83TVQveEJwZ2phVEorckFvNmZR?=
 =?utf-8?B?UnN5dC9SNEl5V1hKZ1NlRnZxaGdPejR4L253cy8rNlIxemxrZG1LK0pwR0hH?=
 =?utf-8?B?N240c3ZxNXBTLzRMTzhhbCtoYlpEdUd2ZmsrT2tpUmRRZCtKN0I0emJpeHRI?=
 =?utf-8?B?REI1WEFJT1V6S1pFQ0kzWkdVN1hLTGR3R0Fsby9KUnB2cno3NHF0eDVYSHBF?=
 =?utf-8?B?SlFzUHFkVlFQWi9nVEpxTDZkV2pZUFNNVW5FcmhHS3N3L1FmRmJOelV2dmo4?=
 =?utf-8?B?eVdNd2Jwd1dpQUp1L2VKajNjK0xoTnJGYnQydUR1UmYxWjdrK3Y4RXpLeDc0?=
 =?utf-8?B?NGpJUTNjR1QwNGZvNmU5RzZSRkxCdEE1QVJwVlMwemk5R3FXUTVORkdrYzhX?=
 =?utf-8?B?ZUpxeVdGVFVndVE2d0RmYlVIRDE3UzQ2MVRmVlBpN05WaUdXNzl1MkxjQTVl?=
 =?utf-8?B?cUl1K2xqazhWMlU2VndmNDhXOG53d2tOOENRU0Zta3Q1YWJuaDhzL0VzRWt4?=
 =?utf-8?B?QTh3VWNKazRJSEw2U3h2bmlFcGVvVTdnWG1OdkZaRXNkcmY4OTRLMXhRa1VK?=
 =?utf-8?B?UzdraldJNVlXUWR0amtEck9TUWVuSlFLcXY2M1hwZFBSQ3JSQlpNd2F0NDdS?=
 =?utf-8?B?UGpPcndoemhRR3hPTTk3U2Z5d0RDSTRPbFZKNStVRm5kUllhTlZQZVp6Qm5B?=
 =?utf-8?B?Y3lrOWlNZEF1eHNWdDhOdldTM1l6NHNrL3VLZzlkemVLOUVXYXcrVVZ2TkFp?=
 =?utf-8?B?N2ZnUklIRHBUekIzSWRiVVkzYWxOMDIwWlgxVzd6M0psN21OL1kzR1lBU0FH?=
 =?utf-8?B?YnhGOEk2WW5YS2FlRThFakVOUDVvTjlQVkpXUmJrME1KQndReW9pNWJweFEx?=
 =?utf-8?B?dGgrZFpSOGFUWUw2b1pGSDRnTGdjTVZwOG5yTitKQnFRTUNqa2xjVFFOVUl4?=
 =?utf-8?B?bnE0aDBvZERZbnJwQW5vL3VnQmF4enY0WTJCQlNMUzNYU0ZKSmZ4Si9yNE00?=
 =?utf-8?B?UFZWNmZoQ1JDWFFRRVBSaWZlYVVueHhKNHpPUFJFakVaMHh6MnMyQTExMzl6?=
 =?utf-8?B?SXpYcXpZU1VhQ2hiWDhXbDJ4VEtXWHV3aDhBOWx5RG5NWWVqNmtzR0pRVlBZ?=
 =?utf-8?B?NlIyMjUwS1hKMVhzeEZsN1YvZW95bERkdVhvYXgrZ1BlUE9PYUdsemF1NlRD?=
 =?utf-8?B?ME5KaGZ3Rk84bUhaemdSM0JhZm1yRGVSdklXSW9vZFE2T3RDQytzQVhQUjFs?=
 =?utf-8?B?aXMrYWdvTUZwZlpIZGxWN1RWbFM5VmFZNXhiT0d0N3dGUTA3dnh1V01vSDlG?=
 =?utf-8?B?ZDdEaFhWUjdZVmxGZ1l1aUJlRjFuaUcwVDc5M2FTclRmTGFudXB3UElWcUpH?=
 =?utf-8?Q?ga4KzVOJ8calCRynUB0lH23d6OvwvUn31mE3UJl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995f47da-4768-4cd2-3b82-08d9606dfa34
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 04:26:11.3775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZklcYYz+nCy8DQZbvxVlcCeS0LxRNxhod0TuNCFMB0nuSG7gUycwR2CBxZ7gOEEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1834
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6
IEZyaWRheSwgQXVndXN0IDEzLCAyMDIxIDk6NTYgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4u
UXVhbkBhbWQuY29tPg0KPiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogZGlzYWJsZSBCQUNPIHN1cHBvcnQgZm9yIDY5OUY6QzcNCj4gcG9s
YXJpczEyIFNLVSB0ZW1wb3JhcmlseQ0KPiANCj4gT24gRnJpLCBBdWcgMTMsIDIwMjEgYXQgOTo1
NCBBTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4N
Cj4gPiBBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiA+DQo+ID4gT24gRnJpLCBBdWcgMTMsIDIwMjEgYXQgNDowOSBBTSBFdmFuIFF1YW4gPGV2YW4u
cXVhbkBhbWQuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBXZSBoYXZlIGEgUzMgaXNzdWUgb24g
dGhhdCBTS1Ugd2l0aCBCQUNPIGVuYWJsZWQuIFdpbGwgYnJpbmcgYmFjaw0KPiA+ID4gdGhpcyB3
aGVuIHRoYXQgcm9vdCBjYXVzZWQuDQo+ID4gPg0KPiANCj4gQWN0dWFsbHkgaXQgbWlnaHQgYmUg
d29ydGggY2hlY2tpbmcgdGhlIFNTSURzIGFzIHdlbGwgYXNzdW1pbmcgdGhpcyBpcyBwbGF0Zm9y
bQ0KPiBzcGVjaWZpYy4NCltRdWFuLCBFdmFuXSBDYW4geW91IHNoYXJlIG1vcmUgaG93IHRvIHBl
cmZvcm0gdGhhdCBjaGVjaz8gV2hlcmUgdG8gZ2V0IHRoZSBTU0lEPw0KDQpCUg0KRXZhbg0KPiAN
Cj4gQWxleA0KPiANCj4gPiA+IENoYW5nZS1JZDogSTU2ZDQ4MzBlNjI3NWUyMGE0MTU4MDg4OTZl
ZWNiYWRmZTk0NDA3MGINCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFu
QGFtZC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
aS5jIHwgNyArKysrKystDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92aS5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMg
aW5kZXggZmU5YTdjYzhkOWViLi43MjEwZjgwODE1YjgNCj4gPiA+IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmkuYw0KPiA+ID4gQEAgLTkwNCw3ICs5MDQsMTIgQEAgc3RhdGlj
IGJvb2wgdmlfYXNpY19zdXBwb3J0c19iYWNvKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2
KQ0KPiA+ID4gICAgICAgICBjYXNlIENISVBfUE9MQVJJUzExOg0KPiA+ID4gICAgICAgICBjYXNl
IENISVBfUE9MQVJJUzEyOg0KPiA+ID4gICAgICAgICBjYXNlIENISVBfVE9QQVo6DQo+ID4gPiAt
ICAgICAgICAgICAgICAgcmV0dXJuIGFtZGdwdV9kcG1faXNfYmFjb19zdXBwb3J0ZWQoYWRldik7
DQo+ID4gPiArICAgICAgICAgICAgICAgLyogRGlzYWJsZSBCQUNPIHN1cHBvcnQgZm9yIHRoZSBz
cGVjaWZpYyBwb2xhcmlzMTIgU0tVDQo+IHRlbXBvcmFyaWx5ICovDQo+ID4gPiArICAgICAgICAg
ICAgICAgaWYgKChhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg2OTlGKSAmJg0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAoYWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHhDNykpDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiArICAgICAgICAgICAgICAg
ZWxzZQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGFtZGdwdV9kcG1faXNf
YmFjb19zdXBwb3J0ZWQoYWRldik7DQo+ID4gPiAgICAgICAgIGRlZmF1bHQ6DQo+ID4gPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gICAgICAgICB9DQo+ID4gPiAtLQ0KPiA+
ID4gMi4yOS4wDQo+ID4gPg0K
