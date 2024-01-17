Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AAEC47077
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 01:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8957E10E0BB;
	Wed, 17 Jan 2024 01:16:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B7510E0BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 01:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgIf+irMbXF/wRpnlINXN9It+rkUq4NqBich9HlskQx0jZshEe8JfBuZ9ArqfRodi5U18RPXxoCuXpBgRWdphmBbui6IfCknsP7TqtUdzy6KNlWmQbVwhbXcbseB+vvjHaJe2n64bBeaPetfp+MQKIQ5JuSsX9NPus/LQ/Z11aFrkKHmszk8gH+0yns+o3JBHg8tcl94zabbzqi4ZgH/kM4QlKrZH2bCWZSwmo+glp3LWHpIuV+aqsn4pAeuhxQoDhMcIsE3N+SOZVH7HAcRLY4yo901qFuz2LjaJ6zSNNBMSSQrIHuYfVbDv63y4H+C8SHo1IsTB+bo2OZB04hRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s/0hrtqMqlc8Kb+iGKkDBuZXBCyKF7mKLDbCMhqIdk=;
 b=nNhwU9xnP90k2P09WF+nho4F6wR/c7khVXRGFaOiuTZJJWqDAtjtXt2odQj9TNO5zvzVNN7wKsa+jrldytWdTY3BvpfaDbqawynnyOKMQFIG/Snpx3VsUdkrpJVcc1kczgeCO/hgDvZnRDelfMYap2WoqcZa02fWPnVwjdOgyP+sSsIpper5cRB4F3Y1C555amcd205WrariWEQ+hYIMZmijcR6y5jWUC339NuBIxXvmldO9Hejleyfwe9J4pLh+blMu8oiKKwCgW+PdamOnT+mkBnCJiHI8haiy/Lnr3ZJbsfZrV77lIJsSC8VK2Dp26GTyo4lg9y41hLbVYaQYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s/0hrtqMqlc8Kb+iGKkDBuZXBCyKF7mKLDbCMhqIdk=;
 b=poGKEM4RzPsXAEeLv2UM6phsQ3l9wdsGK6tGbT/8TIaJYUSJF+EhiMD30hwUjJmKU+cHuzk5NwQo3BIoPjaXzoLnjdve4Q9eF0odnVPNhfY9W2EER0O69IJH/7/NfrXvJFb41Zghfx8wHvmLbjLoa6Ibb0uVSaVY/wmZm3tpYBM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 01:16:06 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 01:16:06 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix UBSAN array-index-out-of-bounds for
 ras_block_string[]
Thread-Topic: [PATCH] drm/amdgpu: fix UBSAN array-index-out-of-bounds for
 ras_block_string[]
Thread-Index: AQHaSGuAdMK0gY3fzUicRyI7qWmdrrDcScwAgADqBeA=
Date: Wed, 17 Jan 2024 01:16:06 +0000
Message-ID: <PH7PR12MB5997E30047B9A1EBEDA5D5F382722@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240116110204.1352227-1-kevinyang.wang@amd.com>
 <8da7b544-f868-4eb3-a28c-cd032fe79e22@amd.com>
In-Reply-To: <8da7b544-f868-4eb3-a28c-cd032fe79e22@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA0PR12MB4430:EE_
x-ms-office365-filtering-correlation-id: f996c1a6-22e5-4664-147c-08dc16f9e159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XOgy1Lb/tCbzPHU4lWsXUaDTRi0WsvC7Zg1aAsxU+ur8oEtIeUGWYSN3p6r6+6phm7jZKQQkVedIvfURt+5ITmGONMizIoWWywrejKN2/fXzRIQL3UG77C+9vwud6nLgLNk/6btx/X4/pQAuCvCXUb429Atqh/L6rUGYJNcbiiBtuqSxepX6v2L8za0vzUQj14Sg4Il5vES1hKaZczk0BNOgOOvlXqkiqVrrw9IKxYOlVXFcLHR4PQ3QUO4G3OHQSD5L/Pw+e45+kRZCGpzKHwEiaeGVTszLGhLGFzIXbykMBbLN9VIERObQrE6RpbQ+TC9yRVda1bjYFUQ8yNCdNPVJahEjiWhZbDylq7iNIdynt+o4b/BHbiN9aubk3i00EgBE4CeZW0u2ESc6jZ4VqiCP/e5vmZsD7uXwJqpdhpyRMvKsh0bzGrGo8TPuxZnQq7w8OBXEPLGXTL8Lwj8BLBhWXBlzVy/xX0pVBNU93B7V+hz++rT/lEzs605qY5CG0vwWolUuQ5odk91Yzjwp5PC26CTtAVJqHH5/XuQ1nUzEGVJcdCbLcWzjrRX5U9n+hb2elIu2HTWeWilEDosdJxyTwif0pL+3sj8WoUlGWfmVZzwvnhshNBeNSql3tlM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(122000001)(5660300002)(2906002)(41300700001)(38100700002)(86362001)(33656002)(64756008)(66446008)(66946007)(76116006)(110136005)(66476007)(316002)(478600001)(53546011)(6506007)(7696005)(9686003)(66556008)(83380400001)(52536014)(4326008)(8676002)(8936002)(26005)(71200400001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1daZWZsNy9XK3BFT2JEa0UrM2ZTZ2F3ZVFOVlVpVHhNUUNBOVQyMFNJMUo3?=
 =?utf-8?B?MGlHQW9lbnV2bHcyNHhILzZSdW1wM2pWaTRVcDFlK1BSOGEzQkVEOHVyTTB5?=
 =?utf-8?B?ZnlvMERuY0x0ekJ1Z2NQS2F1UmdPQzBCMDFBREtJWm1tVjhPTGZ0QmNoZCtC?=
 =?utf-8?B?NnJ6OGp5U3NrQzF2VzY4VlAxWlJHbmFPaEFybHp0Y3NzNTZpaG1Nb2Fpb2dx?=
 =?utf-8?B?MVVoMzFXV3dkQ0ZoSjJuZEY4cEU5VHFlaWFIZGR4cWYzWGF5d0tJWVJiYTh6?=
 =?utf-8?B?bTUwZG52bmlxMHZZVGZEYURqR0ZrUWp6K2dxQjlhOVZDbmk1STR1cm9CbWdl?=
 =?utf-8?B?QlBKZjZoWWNSdmk0eXp1NEwwZzZLMkFxYzBVdHI3Nm9rcmw4L1pwZGp1UURI?=
 =?utf-8?B?TVBnWnl2bTFNK2pJU0QwMzFaZ2VOQVJoQnIxSU16MUlKajhVNmxLc0VaNyt2?=
 =?utf-8?B?NU1uU0FITEdyUnJFWXZXUFJ0ZVJOTzNrbjdPY1crTGVmRGhwZkloT1dabzNC?=
 =?utf-8?B?TGxTbGtMNjZMMHlHQ0JwaVZ0cHZoUFBDaTRRb0xneFRBNk50OUE1ckJTSHNZ?=
 =?utf-8?B?LzdtVkVxQ0VQQXVRNDFSQ3hFM3ZCVDd0c0VDdWVTRTVrVzcwTmd1L0s4NjNF?=
 =?utf-8?B?TnkwS3h0VEdMVkRHMEhkUXF0MjhWQ3dvM3pPM29PNWh1V0grdHhMMU5RRCtl?=
 =?utf-8?B?L1QwMkZuREZjU0lIUWJmMHRFQTgzZkViZWc2LzhnS1NZbE9xaUR5L2ltemNU?=
 =?utf-8?B?SGFVWWN6dFpzVkZLQnp0L0l0QWoyRml2K0dmTlBKMnFldTJub2FHY0VMRkx6?=
 =?utf-8?B?RWQ3bjV6WGpPZ283endST0Y1ekJoVm1MRFZ0bjF0NXZPaUhreGwzYmQ4Q2po?=
 =?utf-8?B?emY2RmFlYzYyWkdOQXhzZjdyZWdSdDJrdk9jRnF5ZGRscG01a0I3ODZYMHFn?=
 =?utf-8?B?ZVF6SzVZcUpBMVdtN1BQRGdEWlNtS0JydjhrbDlzYytmd2dYZ2dvQ0xTWFJt?=
 =?utf-8?B?S2dXWlljd3gyRkFkL3FMUDZVS2M0RWVHZm4xdkRnY29zRDJPMDA1Nmh5emlj?=
 =?utf-8?B?b1pXa2FmbUpqczRCWlYwdzN1eFZMRWgraWdsY3FCRHJzbUo4bkJBWndOSTQ3?=
 =?utf-8?B?RkdOT3VybW8zRFlvNU5ReE9WMlh1VTBIT2sxb1BYTWg1OG45d0RMSDUrZjdW?=
 =?utf-8?B?cVF4VFJWYWZtdlFVVmVWZE9vQjFLWFlkM2FkVENVcU9DcjVobnkybUpLc0Na?=
 =?utf-8?B?NWU1dTRRS21RS0FyTUVHTDJzNWdzam5IcjdDTHNTM0VSdThoNFJoR0V1Qlcx?=
 =?utf-8?B?dVo1YjNINHZxcjZYZ1ZHWnc3a1NDNzVKWWRCb1p5Vm0wM1UxYnRWbERLcXdp?=
 =?utf-8?B?WW5BSnJ6ZTczOERTMHhjWDI3aTRwUW5LQkhYak1HZmlQM3Fad1ZJbE0xZWg3?=
 =?utf-8?B?cTQzNGlTa2xQeWZmUnZIcExXNjg5SDhVeFROTUR4K3JFM3p1UVJLdWVDZ0JI?=
 =?utf-8?B?NjJTem9MQ0p0UXRTdG81VFR4bkk0d21ZUWZYUEs4TDZyb3g1SURIUzFOK2gv?=
 =?utf-8?B?VDNLZ0Yrb2dpRVpmcytiR0pndXZibW91eDUxOWJvMDd3RHdsK1NGSmkzZE5F?=
 =?utf-8?B?dXpSbllxTkhUWmIwdm1kRkR6N2hhTjI3dU1PNkFWN3lFbDkwRGV2RXB3amRn?=
 =?utf-8?B?YXpLSzN5YVN0L1ZiOURxbnNpTHVaVXByTFhpaVZzQ2lCSHUvUm9meHdNRVJp?=
 =?utf-8?B?QVBDbTQ4Z3RJaDNwVm54Q1R0eDlJclcyb1FvTDFIM09CTDJzZVFRUWtTNHVt?=
 =?utf-8?B?Ly9vaVdSazQzNnZJMTdza3NrVmt2dTJvcTY0UUdteTVpVDNnREpXUlczVnE0?=
 =?utf-8?B?MkpYZGVZK1FZelVZNDBtMnJNSzdyTXZyMGdGMXZBZ1k2aitSRVZyZGlxWUd6?=
 =?utf-8?B?T3ZxYmh2N2Ewek9VZGo3ZTlQRFRzY0VZQ0JmdjFJcFR6S2RJc01pZ3Z2aElw?=
 =?utf-8?B?VHZBUk9INnRvQnZiR3ZJNXhGbHZSK2ZYck9iaFZDeG5IUEgzVmxOTWxTeVBC?=
 =?utf-8?B?aCtqSnZJREhpNk5aSU92NzRkeHh4SW9LMmVUQnpoNEZmbHFXNnBaOFlNM1Jz?=
 =?utf-8?Q?8o9Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f996c1a6-22e5-4664-147c-08dc16f9e159
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 01:16:06.2560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6oO/2cGc1eEJFkLf6KEhqPe7bFk0pjdF+G6zcuPZyjjNQsVuAHRXjDv1h/oPiZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5M
YXphckBhbWQuY29tPiANClNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTYsIDIwMjQgNzoxNiBQTQ0K
VG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0Bh
bWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IFVCU0FOIGFycmF5
LWluZGV4LW91dC1vZi1ib3VuZHMgZm9yIHJhc19ibG9ja19zdHJpbmdbXQ0KDQpPbiAxLzE2LzIw
MjQgNDozMiBQTSwgWWFuZyBXYW5nIHdyb3RlOg0KPiBmaXggYXJyYXkgaW5kZXggb3V0IG9mIGJv
dW5kcyBpc3N1ZSBmb3IgcmFzX2Jsb2NrX3N0cmluZ1tdIGFycmF5Lg0KPiANCj4gRml4ZXM6IDJl
MzY3NWZlNGUzZWUgKCJkcm0vYW1kZ3B1OiBBbGlnbiByYXMgYmxvY2sgZW51bSB3aXRoIA0KPiBm
aXJtd2FyZSIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFdhbmcgPGtldmlueWFuZy53YW5n
QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYyB8IDUgKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
Yw0KPiBpbmRleCBmZjZmODQ3MTRmNjguLjgwMDQ4NjM3MTlkMCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBAQCAtNzQsNiArNzQsOCBAQCBjb25zdCBj
aGFyICpyYXNfYmxvY2tfc3RyaW5nW10gPSB7DQo+ICAgCSJtY2EiLA0KPiAgIAkidmNuIiwNCj4g
ICAJImpwZWciLA0KPiArCSJpaCIsDQo+ICsJIm1waW8iLA0KPiAgIH07DQo+ICAgDQo+ICAgY29u
c3QgY2hhciAqcmFzX21jYV9ibG9ja19zdHJpbmdbXSA9IHsgQEAgLTk1LDcgKzk3LDggQEAgY29u
c3QgY2hhciANCj4gKmdldF9yYXNfYmxvY2tfc3RyKHN0cnVjdCByYXNfY29tbW9uX2lmICpyYXNf
YmxvY2spDQo+ICAgCWlmICghcmFzX2Jsb2NrKQ0KPiAgIAkJcmV0dXJuICJOVUxMIjsNCj4gICAN
Cj4gLQlpZiAocmFzX2Jsb2NrLT5ibG9jayA+PSBBTURHUFVfUkFTX0JMT0NLX0NPVU5UKQ0KPiAr
CWlmIChyYXNfYmxvY2stPmJsb2NrID49IEFNREdQVV9SQVNfQkxPQ0tfQ09VTlQgfHwNCj4gKwkg
ICAgcmFzX2Jsb2NrLT5ibG9jayA+PSBBUlJBWV9TSVpFKHJhc19ibG9ja19zdHJpbmcpKQ0KDQpC
ZXR0ZXIgdG8ga2VlcCBhbm90aGVyIGNvbmRpdGlvbiBmb3IgdGhpcyBjaGVjayBhbmQgcmV0dXJu
IGEgZHluYW1pYyBzdHJpbmcgbGlrZSAiPGJsb2NrPl91bm5hbWVkIiBvciAiPGJsb2NrPl9ub2Rl
c2MiDQoNClRoYW5rcywNCkxpam8NCg0KDQpba2V2aW5dOg0KDQpUaGUgZnVuY3Rpb24gaXMgbm90
IGFsbG93ZWQgdG8gcmV0dXJuIGEgZHluYW1pYyBzdHJpbmcsIGFuZCBtYW55IGNvZGVzIHJlbHkg
b24gdGhpcyBjb25zdGFudCBzdHJpbmcuDQpCdXQgeW91ciBzdWdnZXN0aW9uIGlzIGdvb2QsIGJ1
dCB0aGUgcHVycG9zZSBvZiB0aGlzIHBhdGNoIGlzIG9ubHkgdG8gYnVnIGZpeC4NCg0KQmVzdCBS
ZWdhcmRzLA0KS2V2aW4NCj4gICAJCXJldHVybiAiT1VUIE9GIFJBTkdFIjsNCj4gICANCj4gICAJ
aWYgKHJhc19ibG9jay0+YmxvY2sgPT0gQU1ER1BVX1JBU19CTE9DS19fTUNBKQ0KDQo=
