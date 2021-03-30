Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA0C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E6C61969
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E6C61969
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6477D6E8E1;
	Tue, 30 Mar 2021 13:16:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EA06E8E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 13:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIKs1y8iV+Jath/aw+/KB/NaA3h19VA+GyaSU/b1C7A32olWJvQU4morCMCGw8Tiy04p8PJlXb1gXbL+dMy+iOM5nBCm9o4qy508/HsTtic2kLwy0u1w35j5UiqaZtX/j8bQFZQyHGLw6PmMKZRnfXt9/n/gAJfeWauoinoPXfy4ZvSy2m50Hc6PjM+rQS1PiL0RD25Y/PaXNgSz+bKDMxuQEcu+mLmoHVbXi0upIPPk7VV0VLDf3dPebrHGTj+j/1SfmfrlZEhj1bvvLFbizRlsMqHfkU6rl8W/G+OYZa/uPNhZAplp5zsQKhr4D1jxYB3uxjwniQNgYKvVsMm1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaPTzTTbriZZOYBlYGZc3J/TEkK4bP/JmGMDYzKrOyA=;
 b=jkR+pbQVmEkiXO9VFvMbjcGzfEjCmhMGioCgrsQrMixnFVFuimIXH6j3tlsDOTImP7sD0F5KEqcvORhjZdG4/a7uKuh+p0VvZn0SryjKo3CQU+Fq6hJ1yQ4pgl0aMeIVDFqDJxiSF6Nv6q39QnO4YIjJ1jIBEXUKDil7useoVRhPy/Scrcfl3bNOijvc5xrzjGThhAX0BoIk4ytEmeLM9eUg74V3T9MGdoRvSLLYGt6UDd8MlU55pl1ZV8nCP5fmG4a0rQ+XeZo8UR4owgbPC/QHcPc4gztEj2XY/rlf6+YwiZ0PuyQHAwJLpfx+UpvC6sQj2SVTNclIi41vm7GTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaPTzTTbriZZOYBlYGZc3J/TEkK4bP/JmGMDYzKrOyA=;
 b=grnZw0dq7nxn7fGZrf4d8+jauGNXmKB+yWwpoCU/UkUUy3urKnB4gcJMvCbBu8NzEwDI9q0Ch0ypvhpjpKPRdcIIJWT1BwjzA/2NG/WdPLbACymxoi+JtTqyLPuFw2JAVo5xITMP4WsRcjJQL2gxjQXeUHRCyVXx0dC77r/zsjs=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0183.namprd12.prod.outlook.com (2603:10b6:910:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Tue, 30 Mar
 2021 13:15:57 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Tue, 30 Mar 2021
 13:15:57 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix NULL pointer dereference
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix NULL pointer dereference
Thread-Index: AQHXJUvbWMm8FLDF102ax0yPp7vp0KqcVyKAgAAqX6A=
Date: Tue, 30 Mar 2021 13:15:57 +0000
Message-ID: <CY4PR12MB1287EC30BEEFE6724D395C98F17D9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210330100229.26435-1-guchun.chen@amd.com>
 <34904a56-726c-fb28-fd21-a3425f51d72b@gmail.com>
In-Reply-To: <34904a56-726c-fb28-fd21-a3425f51d72b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-30T13:15:52Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b09e55ba-a6fc-462c-9d3d-edf7b4680d00;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.93.253.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 309d9941-ca88-4d7a-be78-08d8f37df4a6
x-ms-traffictypediagnostic: CY4PR1201MB0183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01836409CE1D40B099D8CB22F17D9@CY4PR1201MB0183.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1C2YXklOwnEDwfc7uK0Jk6+2wcU4tbxr41CSay6m1fmxd67axj/zEocJBd9kB3yEsdEWhYwOJEWXSc/xnasyKIXvJ40m8q00/Hfy0erEb8RFqk8VeIKb7GOqUMi+4GbuNsBnaYr7weoMtoIRL7QW3ekwS/U+p2IVNfAOdNGXx6fh053QxJzMPfOmYhGeciQFRSYkL1KdP+0+nfUM8g51Fi+IodeZpOsbWUtBuWKvXn9+tqNHb82okmbj2CUs9YwO9SdvD73M8XbtnoSg8KRnRhXHQqAWRtKI5OPjYa9qKI6gArQGwK1/Ah5SEfT2CtjubRZ5zneb3HKe5v46mWAwfdcwY8gA7iUFUZbGS0+zgCF9r+RfK2xehgNCNTIvVSL8CSkhkmEYB1GPDl4BEZP0ieI9OqKAfbzHTHWu/lee1rP8A5Qn9TAHmrEi3JLek4zPmRN1/YdmCThWYwZo15O3/q8j1LxzCf6lN8r7F2pXvii2dNMuTOnUGHXdzFkb0+tZPE3OAwumx2LyHzLdEvQY8vC6MQBAD4yAS+hav9GL+KBRSvkRMhOVludfyAgwva/7XVoJBpa2trVHShymeEjY5G+eddMxGYmYmoQpfum/0TqGeNJvVsUCtdy3flmJpt60U0VZ61Mtco/nyiTdH1OhH2pGNIEVFbfYLtpQ7Z3Ijtg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(366004)(52536014)(76116006)(9686003)(64756008)(5660300002)(110136005)(55016002)(26005)(7696005)(86362001)(83380400001)(2906002)(8676002)(66574015)(71200400001)(6636002)(38100700001)(66446008)(66556008)(66476007)(66946007)(8936002)(53546011)(6506007)(478600001)(316002)(33656002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aXlicHVScExZenVpOHk5VE52a1JJSWtYdVp5TWdWVU9XL09GRHMyUjZYa2Zx?=
 =?utf-8?B?RWg0OTYvOE1Xc1FibldWS2cxKzVMenBGRnZocjdMekF1VUpjUTZYTzNPc00v?=
 =?utf-8?B?S1Y4c1Y2RWQrZVo0NVB4QlczU1FlZGFJUy9LV3B5N2ZsNEdLZ2htWTJQN0I4?=
 =?utf-8?B?b0RON0hrY3k3ZXRSRzhCZmdPSFFKSm5IQkZ6cUU4TU04L1BMTzRsVGZVNjdT?=
 =?utf-8?B?Rm80VVFETFlFOGozSjJEcklZOWNjbmJOWlFTUDRLcE02U1ZUcklyUTBOYnVF?=
 =?utf-8?B?aWdRNFVYY016cjY0aUlxd0VEUzNDdWwzQUtpZC9XZ2xIVVZIVDQxWUZJRjEx?=
 =?utf-8?B?VHJIU1dwTUtmbUJlZldNaUlSRXBQOFJLaFRqZXZ4a0RzM2JQazNjNFhoSGhR?=
 =?utf-8?B?alYxVjF5TUpHYzAwWk9TaEhyZ2VyYkF6bnZoR25vdEpVK09KU0ZmZnZ5TGtX?=
 =?utf-8?B?NWVsSzhLZ0FWZi9zazBsYWt6QnpNYmdlNHlwa2kxdHo3UHJkZ2x6NWZ2YWdV?=
 =?utf-8?B?a2tHbHR1ZWZLS1BuREthVnU1ZDI3Y1VpUXFzcjl6SHJXZnNaT3c2aWcxRmcw?=
 =?utf-8?B?WkZTSThaaGpJSnR4eDRhcVpBVDdLdWVWRG1qSVNYSXYrcWlwNllEME4rQXl3?=
 =?utf-8?B?TC8yZmNnYUltdGpscmo3WTFzc3BrZ25ONS8vc1kzTUhTUXl1eENRVVA5MFY4?=
 =?utf-8?B?WkNtTnZ4WjBuM25Gb3dJSXYyR1A5eWF1MGhJOFdJNGM3QWZtdHlYMmRHTi9O?=
 =?utf-8?B?OFNYdHlmV2toYm1neUxkcVFSTlRpb2M3UGw5d1BNNy9aNmlEb1ZjS0hQNmFF?=
 =?utf-8?B?ZEpJTUJ2WDlFbVVaVUtZQVU0Q1lVMTZuNHFYeVNJeUpFeW44bjR6SklrT2tw?=
 =?utf-8?B?UjdaQldWNWhZczI0dmJudVlZRys5NGYzRGNTNUxOdXo1RjhNaGRjaktXUHJE?=
 =?utf-8?B?VTF6dlRId2dYWVJraHR0bjl2NmN0UlE4S05SWEh6NnFSbTdlK1VBY3hQb1By?=
 =?utf-8?B?dUd4Z0phcXFMZlpSQ3Mvczd5ZFF0cGx4a2xZVHV0T0J5OFFsbE40bUlhQWVv?=
 =?utf-8?B?dFgweDd5Z1FZQjFPMDdVdzBhYmFsWDJEUEliR1lFdXlMZSs2Qm5GQWlKQVh0?=
 =?utf-8?B?QUF3dWlCV014L1hrampoazVFOUtUeExmTS9UL3hXaEU0b2RjcGZTT2dzaUZY?=
 =?utf-8?B?MDFkZys1UUFWS21iNVpmZURrVWpXR2NTcVZlSnRrYWtib01OSjEvWmxNR1dY?=
 =?utf-8?B?cmdVWThaL0hoSlFyeVNEMHBpcWNHMGNOT1M3dThVV0l3WVEyOWNwMy9NM2t3?=
 =?utf-8?B?bW92S0d1UVpBUjQ3dGU5SzNNRFRoZVVkOWRRSkJPaENJY1pmdXJBeFNYZitw?=
 =?utf-8?B?aVBwWTd4UExRNVdGYzZLUWhnbjhnT29HbHl2MGtHWkJOa1JWUDBVQmFRbUdo?=
 =?utf-8?B?dWhkL2NVdU16NjNLdnBFRVNvTitUUEROVUlaaW9Zeit3NDNJbjJsdEFZQ25C?=
 =?utf-8?B?UjRhb2MySkI0azBFUGRobGJDdXRrTGlmOVp4elhkUWpnWmFGbHR6TDR3amtP?=
 =?utf-8?B?RXFzMlZaNktpd0F5dUhsd0NwcllEOXFYR2dHcm9VYWw5ZVp4ZktReEMrWUpI?=
 =?utf-8?B?QXZuTGhGVzNXMG9iTjBZMGUwWTRDTkIrK2dlMWFmS1Btc2FLZTZ6YnJ0OUY3?=
 =?utf-8?B?SWZBY2lVYmdNaGJTZHMyOE4rQ2k2Ym5QQTZqaFdZMTVYYXp3dGVySTc2K0h1?=
 =?utf-8?Q?zNTjA4AUamNZWVbkUDASTZrYAJZckUZI4+1+LTk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309d9941-ca88-4d7a-be78-08d8f37df4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 13:15:57.3045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hinj+pl6U0MbU3lvjI3HGn4r0eNILY/oTghl0u8VoSlt+gVas+cA6QNlHL1BxSagkFwq+XSU8A5DqzBZ8ejfdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpUaGFua3MgQ2hyaXN0aWFuLCBJIHdpbGwgcHV0IGxhc2VyIGZv
Y3VzIG9uIHRoaXMgcGF0Y2ggYWZ0ZXIgbWVyZ2luZyBpdC4NCg0KSSBub3RpY2UgdGhlIHNhbWUg
bG9naWMgaW4gcmFkZW9uIGNvZGUgcmFkZW9uX3R0bV90dF91bnBpbl91c2VycHRyLiBTaGFsbCBJ
IGNyZWF0ZSBhbm90aGVyIHBhdGNoIHRvIGZpeCBpdCBhcyB3ZWxsPw0KDQpSZWdhcmRzLA0KR3Vj
aHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmln
IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBNYXJj
aCAzMCwgMjAyMSA2OjM5IFBNDQpUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UNCg0KQW0gMzAuMDMuMjEgdW0gMTI6MDIgc2NocmllYiBHdWNodW4gQ2hl
bjoNCj4gdHRtLT5zZyBuZWVkcyB0byBiZSBjaGVja2VkIGJlZm9yZSBhY2Nlc3NpbmcgaXRzIGNo
aWxkIG1lbWJlci4NCj4NCj4gQ2FsbCBUcmFjZToNCj4gICBhbWRncHVfdHRtX2JhY2tlbmRfZGVz
dHJveSsweDEyLzB4NzAgW2FtZGdwdV0NCj4gICB0dG1fYm9fY2xlYW51cF9tZW10eXBlX3VzZSsw
eDNhLzB4NjAgW3R0bV0NCj4gICB0dG1fYm9fcmVsZWFzZSsweDE3ZC8weDMwMCBbdHRtXQ0KPiAg
IGFtZGdwdV9ib191bnJlZisweDFhLzB4MzAgW2FtZGdwdV0NCj4gICBhbWRncHVfYW1ka2ZkX2dw
dXZtX2FsbG9jX21lbW9yeV9vZl9ncHUrMHg3OGIvMHg4YjAgW2FtZGdwdV0NCj4gICBrZmRfaW9j
dGxfYWxsb2NfbWVtb3J5X29mX2dwdSsweDExOC8weDIyMCBbYW1kZ3B1XQ0KPiAgIGtmZF9pb2N0
bCsweDIyMi8weDQwMCBbYW1kZ3B1XQ0KPiAgID8ga2ZkX2Rldl9pc19sYXJnZV9iYXIrMHg5MC8w
eDkwIFthbWRncHVdDQo+ICAgX194NjRfc3lzX2lvY3RsKzB4OGUvMHhkMA0KPiAgID8gX19jb250
ZXh0X3RyYWNraW5nX2V4aXQrMHg1Mi8weDkwDQo+ICAgZG9fc3lzY2FsbF82NCsweDMzLzB4ODAN
Cj4gICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5DQo+IFJJUDogMDAz
MzoweDdmOTdmMjY0ZDMxNw0KPiBDb2RlOiBiMyA2NiA5MCA0OCA4YiAwNSA3MSA0YiAyZCAwMCA2
NCBjNyAwMCAyNiAwMCAwMCAwMCA0OCBjNyBjMCBmZiANCj4gZmYgZmYgZmYgYzMgNjYgMmUgMGYg
MWYgODQgMDAgMDAgMDAgMDAgMDAgYjggMTAgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCANCj4gMDEg
ZjAgZmYgZmYgNzMgMDEgYzMgNDggOGIgMGQgNDEgNGIgMmQgMDAgZjcgZDggNjQgODkgMDEgNDgN
Cj4gUlNQOiAwMDJiOjAwMDA3ZmZkYjQwMmMzMzggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDog
MDAwMDAwMDAwMDAwMDAxMA0KPiBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwN2Y5N2Yz
Y2M2M2EwIFJDWDogMDAwMDdmOTdmMjY0ZDMxNw0KPiBSRFg6IDAwMDA3ZmZkYjQwMmMzODAgUlNJ
OiAwMDAwMDAwMGMwMjg0YjE2IFJESTogMDAwMDAwMDAwMDAwMDAwMw0KPiBSQlA6IDAwMDA3ZmZk
YjQwMmMzODAgUjA4OiAwMDAwN2ZmZGI0MDJjNDI4IFIwOTogMDAwMDAwMDBjNDAwMDAwNA0KPiBS
MTA6IDAwMDAwMDAwYzQwMDAwMDQgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDBj
MDI4NGIxNg0KPiBSMTM6IDAwMDAwMDAwMDAwMDAwMDMgUjE0OiAwMDAwN2Y5N2YzY2M2M2EwIFIx
NTogMDAwMDdmODgzNjIwMDAwMA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3Vj
aHVuLmNoZW5AYW1kLmNvbT4NCg0KWWVhaCBJIGhhZCB0aGlzIG9uZSBvbiBteSBUT0RPIGxpc3Qg
YXMgd2VsbC4NCg0KRm9yIG5vdyB0aGUgcGF0Y2ggaXMgQWNrZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4sIGJ1dCBJJ20gbm90IDEwMCUgc3VyZSBpZiB0
aGlzIGlzIHRoZSByaWdodCBmaXguDQoNClBsZWFzZSBrZWVwIGFuIGV5ZSBvcGVuIGlmIGFueWJv
ZHkgY29tcGxhaW5zIGFib3V0IGlzc3VlcyB3aXRoIHRoaXMgcGF0Y2gsIGlmIHllcyB3ZSBuZWVk
IHRvIGdldCBiYWNrIHRvIHRoZSBkcmF3aW5nIGJvYXJkLg0KDQpDaHJpc3RpYW4uDQoNCj4gLS0t
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMiArLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIA0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KPiBpbmRleCBlMDAyNjNiY2M4
OGIuLjcyMmVmZDg2NzE4ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYw0KPiBAQCAtODY3LDcgKzg2Nyw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV90dG1fdHRf
dW5waW5fdXNlcnB0cihzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwNCj4gICAJCURNQV9CSURJUkVD
VElPTkFMIDogRE1BX1RPX0RFVklDRTsNCj4gICANCj4gICAJLyogZG91YmxlIGNoZWNrIHRoYXQg
d2UgZG9uJ3QgZnJlZSB0aGUgdGFibGUgdHdpY2UgKi8NCj4gLQlpZiAoIXR0bS0+c2ctPnNnbCkN
Cj4gKwlpZiAoIXR0bS0+c2cgfHwgIXR0bS0+c2ctPnNnbCkNCj4gICAJCXJldHVybjsNCj4gICAN
Cj4gICAJLyogdW5tYXAgdGhlIHBhZ2VzIG1hcHBlZCB0byB0aGUgZGV2aWNlICovDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
