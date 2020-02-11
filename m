Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDCC35242
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 23:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2057D206D6
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 23:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Syuy3y8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2057D206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F8B6EDF6;
	Tue, 11 Feb 2020 23:28:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA886E43B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 23:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+h4aI4I7NV94zxBTiFUO/RPfRhBP/WAu69sI1Up16i7eGB7GRpNwZ49WEAnepOVDIFsUl5XQXOHZvpKlxo0xEB+C5DW5xGuPGlhRwchFd70eP8AVG0y8pWV4YEIUpMtw7DY9MYQ1WxyRtTeFvSnCz0PrxDFjCZOx6m7AMA8QzPFHKx76CU+78xn1aWJsHnOWm30mkA2TcA1OGNkohSiSGQ6ttOB8hctpI1+n9US7eEACFOTbA8SsN74pvYdSJgHJXca5IMS8ohnxYhhc2yOgwlSDNQyotNR7uYWpdeRY+HrMVVIc3C6bC3vk6M4qsKPIyCsK0ovwPbhoD1EDea2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMwNy+HzEVTYiJ1Xv+XNW1D2893lar0g8CU7rLpWpi4=;
 b=OhHRMpj4zualZ9nHRMbrGAUBEL2lB71MRunRYkI3y9pkV9lUtzqgF0BptANxekoPMod+RdyYMju2eBnn0fh3mNSv8WjyG5iAS8M3bAB+lP3crFVJmV/8YdZjICJxJZs4+ZzDDbGZ1GxG117TV2ijgAgL9qPZHS3Mx2/BlB8GdxaSCG7UN3wl1QgNCxinmAGi200YMBM9zvTNhLoZfKX51OasB/AHDd/SrQoP8vXauLW9lGi87Pw6aE7CEMiBSvUqAGgsKVjRyv/wNo20/8qSnMeqmd1qtu/LUX3TQ/3YiseMa9P0/63GKpZx76WfTf7k5M4rK0ckUnDYX5DplrZPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMwNy+HzEVTYiJ1Xv+XNW1D2893lar0g8CU7rLpWpi4=;
 b=Syuy3y8J4/FlGadbvHzbVuLnd1OPYMLOamwcBpMiVTwXFvMN9lJAeiaCNLlXPSXWInj9vpITMKEOLpzeFUNommHw9dnJaTyBqInxyNwmOyt4JFIOiBuLUa6Fh3QaxZ/QqTBfzcg+52UZGhb3FqQCSXCGxZb4kaFpBEN2AGGo9JQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB4201.namprd12.prod.outlook.com (10.141.185.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 23:28:39 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 23:28:38 +0000
Subject: Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu
 tests
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1581420183-14223-1-git-send-email-ray.huang@amd.com>
 <a54f6008-918a-dbf6-0000-f2f048cdaaff@gmail.com>
 <CH2PR12MB39128F0E67FFB7E60C16B1ADF7180@CH2PR12MB3912.namprd12.prod.outlook.com>
 <MN2PR12MB330985788CF1A81319DF67C3EC180@MN2PR12MB3309.namprd12.prod.outlook.com>
 <CH2PR12MB3912CCDC4F15E6B7B1E92543F7180@CH2PR12MB3912.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <759679d7-6e14-84a9-8334-7a591b35a92c@amd.com>
Date: Tue, 11 Feb 2020 18:28:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <CH2PR12MB3912CCDC4F15E6B7B1E92543F7180@CH2PR12MB3912.namprd12.prod.outlook.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::27)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 23:28:38 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18623447-8d58-4c06-5a76-08d7af4a1f3a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4201:|DM6PR12MB4201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42012C68EE23390B3A9765BB99180@DM6PR12MB4201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(26005)(6486002)(44832011)(2616005)(6512007)(2906002)(956004)(36756003)(66574012)(6506007)(53546011)(31686004)(66476007)(66556008)(478600001)(54906003)(66946007)(316002)(8936002)(110136005)(186003)(31696002)(4326008)(8676002)(16526019)(52116002)(81166006)(5660300002)(81156014)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4201;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dabDhStXwdvcD9kG2093HQVuYHP5Yp2RTxTXvtU1UHwiQKy5ZhiRFdGOtwk5oX2RBXIZy0MgTE3UET52JrMrGXhMNPvF7lcZ2eMPDdcCViEPooGa3Vj77Qf7oN6iunshdnxImJdDhpGbyw5KOCvqjQ2c7KxSccUov6Z6uMp4SuEix8B5hmDIf8f5TcRb/317oKxDMgkFdy9aTjG6zc2u8reqTRSaUuZzBPL9IuVqTwPbbWr/uyda4fFlGFN96YM7817MgvTemzOHLcdtZ1/71q29sBW3ly7LbF7yGmroWsW2CmUJkE+aghMIqAuVZjdVB04/jmJUmYfncCovtgwosIJeUTaeXldB9fssB5J7ZNbExWUhZygkVm1CLjlpTNYM5/Zy4UA1C+Nph+hLwffaT9a0aSL+5D6r08F+06pizh/X+fbYnMNHcrA3eu9FANY
X-MS-Exchange-AntiSpam-MessageData: 66rYwZ9Q78EglMwx+HJxCZ0NvNxeo2LMim2GFIOvgwjoP1CFr06cr713yFmEKx3Tq6mYgWQd3LYoNgphQzgbtDrED4urDPmlOc69lYLx2OhJ4oVZ+uJs5GvPt2FvAI6+EPYWu0FBJgAIqsf0tIqHzQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18623447-8d58-4c06-5a76-08d7af4a1f3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 23:28:38.5161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSE0P8Y82Y3B6/CgfxRdJBesdaHIvtLe/BlHpezGRDVrrSLrKps/M86TI8gHiZjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TG9va3MgZmluZSB0byBtZSBhcyB3ZWxsLiBKdXN0IGFzIENocmlzdGlhbiBzYWlkLCB3b3VsZCBo
YXZlIHRvIGJlIGFwcHJvdmVkIGJ5DQpNYXJlay4NCg0KUmVnYXJkcywNCkx1YmVuDQoNCk9uIDIw
MjAtMDItMTEgOTo1NyBhLm0uLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3JvdGU6DQo+IFllcywgY29y
cmVjdC4NCj4gDQo+IEFsZXgNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICpGcm9tOiogSHVh
bmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+ICpTZW50OiogVHVlc2RheSwgRmVicnVhcnkg
MTEsIDIwMjAgOTozNSBBTQ0KPiAqVG86KiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4NCj4gKkNjOiogUGVsbG91eC1wcmF5ZXIsIFBpZXJyZS1lcmljIDxQ
aWVycmUtZXJpYy5QZWxsb3V4LXByYXllckBhbWQuY29tPjsgT2xzYWssIE1hcmVrIDxNYXJlay5P
bHNha0BhbWQuY29tPjsgTGl1LCBBYXJvbiA8QWFyb24uTGl1QGFtZC5jb20+OyBUdWlrb3YsIEx1
YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+DQo+ICpTdWJqZWN0OiogUkU6IFtQQVRDSCBsaWJkcm0gMC80XSBhbWRn
cHU6IHVzZSBhbWRncHVfY3Nfc3VibWl0X3JhdzIgZm9yIGFtZGdwdSB0ZXN0cw0KPiDCoA0KPiAN
Cj4gW0FNRCBQdWJsaWMgVXNlXQ0KPiANCj4gwqANCj4gDQo+IEhpIEFsZXgsDQo+IA0KPiDCoA0K
PiANCj4gTVIgPSBtZXJnZSByZXF1ZXN0P8KgIFNob3VsZCBJIGNyZWF0ZSBhY2NvdW50IHRvIHNl
bmQgbWVyZ2UgcmVxdWVzdCBpbiB0aGUgZnJlZWRlc2t0b3AgZ2l0bGFiPw0KPiANCj4gwqANCj4g
DQo+IFRoYW5rcywNCj4gDQo+IFJheQ0KPiANCj4gwqANCj4gDQo+ICpGcm9tOiogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiAqU2VudDoqIFR1ZXNkYXks
IEZlYnJ1YXJ5IDExLCAyMDIwIDEwOjMwIFBNDQo+ICpUbzoqIENocmlzdGlhbiBLw7ZuaWcgPGNr
b2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiAqQ2M6KiBQZWxsb3V4LXBy
YXllciwgUGllcnJlLWVyaWMgPFBpZXJyZS1lcmljLlBlbGxvdXgtcHJheWVyQGFtZC5jb20+OyBP
bHNhaywgTWFyZWsgPE1hcmVrLk9sc2FrQGFtZC5jb20+OyBMaXUsIEFhcm9uIDxBYXJvbi5MaXVA
YW1kLmNvbT47IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPjsgS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gKlN1YmplY3Q6KiBSZTogW1BB
VENIIGxpYmRybSAwLzRdIGFtZGdwdTogdXNlIGFtZGdwdV9jc19zdWJtaXRfcmF3MiBmb3IgYW1k
Z3B1IHRlc3RzDQo+IA0KPiDCoA0KPiANCj4gW0FNRCBQdWJsaWMgVXNlXQ0KPiANCj4gwqANCj4g
DQo+IEFsc28sIGxpYmRybSBjaGFuZ2VzIHNob3VsZCBnbyB0aHJvdWdoIGEgZ2l0bGFiIE1SIG5v
dy4NCj4gDQo+IMKgDQo+IA0KPiBBbGV4DQo+IA0KPiDCoA0KPiANCj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IA0KPiAqRnJvbToqQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1l
cmtlbkBnbWFpbC5jb20gPG1haWx0bzpja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4+
DQo+ICpTZW50OiogVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMjAgNjozOSBBTQ0KPiAqVG86KiBI
dWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbSA8bWFpbHRvOlJheS5IdWFuZ0BhbWQuY29tPj47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxtYWlsdG86YW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+Pg0KPiAqQ2M6KiBQZWxsb3V4LXByYXllciwgUGllcnJl
LWVyaWMgPFBpZXJyZS1lcmljLlBlbGxvdXgtcHJheWVyQGFtZC5jb20gPG1haWx0bzpQaWVycmUt
ZXJpYy5QZWxsb3V4LXByYXllckBhbWQuY29tPj47IE9sc2FrLCBNYXJlayA8TWFyZWsuT2xzYWtA
YW1kLmNvbSA8bWFpbHRvOk1hcmVrLk9sc2FrQGFtZC5jb20+PjsgTGl1LCBBYXJvbiA8QWFyb24u
TGl1QGFtZC5jb20gPG1haWx0bzpBYXJvbi5MaXVAYW1kLmNvbT4+OyBUdWlrb3YsIEx1YmVuIDxM
dWJlbi5UdWlrb3ZAYW1kLmNvbSA8bWFpbHRvOkx1YmVuLlR1aWtvdkBhbWQuY29tPj47IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbSA8bWFpbHRvOkFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+PjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbSA8bWFpbHRvOkNocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4+DQo+ICpTdWJqZWN0Oiog
UmU6IFtQQVRDSCBsaWJkcm0gMC80XSBhbWRncHU6IHVzZSBhbWRncHVfY3Nfc3VibWl0X3JhdzIg
Zm9yIGFtZGdwdSB0ZXN0cw0KPiANCj4gwqANCj4gDQo+IExvb2tzIGdvb2Qgb24gZmlyc3QgZ2xh
bmNlLCBidXQgTWFyZWsgYW5kL29yIFBpZXJyZSBjYW4gcHJvYmFibHkgYmV0dGVyDQo+IGp1ZGdl
IHRoYW4gbWUuDQo+IA0KPiBDaHJpc3RpYW4uDQo+IA0KPiBBbSAxMS4wMi4yMCB1bSAxMjoyMiBz
Y2hyaWViIEh1YW5nIFJ1aToNCj4+IFNvIGZhciwgdGhlIGFtZGdwdV9jc19zdWJtaXRfcmF3MiBp
cyB1c2VkIGZvciBNZXNhR0wsIGhvd2V2ZXIgdGhlIGFtZGdwdSB0ZXN0cw0KPj4gc3RpbGwgdXNl
IHRoZSBsZWdhY3kgaW50ZXJmYWNlLiBTbyB3ZSB3b3VsZCBsaWtlIHRvIG1ha2UgYW1kZ3B1IHRl
c3RzIHZlcmlmeSB0aGUNCj4+IGFtZGdwdV9jc19zdWJtaXRfcmF3MiBBUEkuDQo+Pg0KPj4gVGhh
bmtzLA0KPj4gUmF5DQo+Pg0KPj4gSHVhbmcgUnVpICg0KToNCj4+wqDCoMKgIGFtZGdwdTogdXNl
IGFsbG9jYSBmb3IgZGVwZW5kZW5jaWVzIGFuZCBzZW1fZGVwZW5kZW5jaWVzDQo+PsKgwqDCoCBh
bWRncHU6IHVzZSBhbWRncHVfY3Nfc3VibWl0X3JhdzIgaW4gYW1kZ3B1X2NzX3N1Ym1pdA0KPj7C
oMKgwqAgYW1kZ3B1OiByZW1vdmUgdGhlIHVuLXVzZWQgY2h1bmtfYXJyYXkNCj4+wqDCoMKgIGFt
ZGdwdTogY2xlYW4gdXAgdGhlIGNzIHN0cnVjdHVyZSB2YXJpYWJsZQ0KPj4NCj4+wqDCoCBhbWRn
cHUvYW1kZ3B1X2NzLmMgfCAzNiArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+wqDCoCAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0p
DQo+Pg0KPiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
