Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462D9C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 10:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84D310E571;
	Fri,  5 Jan 2024 10:46:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC16A10E571
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 10:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH9wRaSm3UXa68J84nxau6ZWt6JNF6ZJXUg++Z58wNtHj5VtAJ8Nxk9JpOie4hdsWCLcBbiVj3MxEDTXmKD0NDiodz9iD7HAlPXaHz1Sb9tLeVE1jTFYzrRvmvqJVuPWE8uwY1eAVnNgRXPy2r0gQ6RRhSfxvlYrBm/zZ/bm07Ve2v9Hq9/rTAIFVdvlBTLjNBv8+LPgfoLzxXZLVpWzVQG9Jn4llYD44eRAJhK6pZT38cE56QGluCvbfdnWcFeDLQkhdVVjUfUKXCjpj3eF9m4Ktudj+ZHamI1O8AuC+7btHSiJcw/DAq4PS8WZvNSPThNQAmKcwiBvqGD2yfs4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv2b/lA01iloqh3hBGv5vqLvB2jzrHgdrVNvholOH00=;
 b=YvgUE/7SnMgqDtJkMD0h6yH6Hf4N50qpSy+LUmDisZYOhHIOYV6rc8ET9IkUUkZOVGCOlMup6jCNkPK8x9m4xQN5ttK0S6N8n1uXA3aHoJ3UPvZFqksXk5kYxTyeI73Ow4s3s8F5UhRzxZVIgn4LBRfWtjcy0Kfu6t39Pf7gcr7/2CRW2WEXIBz+VQIYNtmS0k/zubTq8yng6RVM7Ov7HCmbTXF4eugprB1peUOUnpEJZ7slJNBqBBPuVJ4Q0y9QBeZVBik6PCwxIXMsnYu4syobjTtBpGLFFuoCoEb7KIqFuAdvEmWLSSAZYdDnP7jbe+F6vq2jH1osMXlbFPvz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv2b/lA01iloqh3hBGv5vqLvB2jzrHgdrVNvholOH00=;
 b=qYo1Y9tRjotTOJcXnZZNUPE2xnYraropgfjKWO37x0pJNyTw14WCESixASlMusr0PttKnxgz4vD//uEmwvJHsSZHU7362EdCWduK9uzI3sXuqVzvQAuY+MNGEEJVufz7IBhi5N+jnkq0nhRmTcSDWJdPvhm0LEOunU3pvlDfaRY=
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 10:46:21 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 10:46:21 +0000
From: "Lee, Peyton" <Peyton.Lee@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCB1bnNpZ25lZCBjb21w?=
 =?utf-8?B?YXJpc29uIHdpdGggbGVzcyB0aGFuIHplcm8gaW4gdnBlX3UxXzhfZnJvbV9m?=
 =?utf-8?Q?raction()?=
Thread-Topic: [PATCH] drm/amdgpu: Fix unsigned comparison with less than zero
 in vpe_u1_8_from_fraction()
Thread-Index: AQHaP8PJPl9VB9bFCEmHdCEeqJqY2LDLCI7Q
Date: Fri, 5 Jan 2024 10:46:21 +0000
Message-ID: <MN2PR12MB4373CE2EE2D4F2F2C07EF90386662@MN2PR12MB4373.namprd12.prod.outlook.com>
References: <20240105104126.2773281-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240105104126.2773281-1-srinivasan.shanmugam@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=756db0d9-6c44-4e3f-a054-6cacb6199c82;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-05T10:43:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|PH8PR12MB7350:EE_
x-ms-office365-filtering-correlation-id: 0b7ef4f6-1c96-4736-2c6d-08dc0ddb8e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgoOB29/UZvHArV7MCx97F81NluB5b36eKniyHiT6TwjNCpjoha1USdY9X3e6MIpvM38/rVX3mDsXpnuZxW4ssUZ787EY8t+/CJSkVy64mI70M67OpYHoc/bL+42T7bi3UHEZB1tnyVTcNF7NSxm3Qz81DG5vqP6H4QSglrE9sSoK1J2WTAyTyX//vZBPec88SH0IVwFw2GeJWYfARBn8uUykpbwsIjcohi2AJfAIbyKCBkhVJv7K4UDIzHouFwr8lm3qsUWF+wbNlKuUMCgz/Pc+Ci2mrCs6MFu3g3nqCCrp2SpyaHZbljAxnceUidSvy5xW1ZRTVW16uehfNoJ3W3Klr41JOK45UGrIQ9usN+MTg3Qqc1evx7dfCekOTHjYqD1I4b7Zvnj15bf1Uzpt+ryiNkTpRiB03fK6+6aHIIfKokZReAVBISOf44NhSqKPPbjFyrIKLay+0SZlqgeIE8LsRcNtzr0rWwkiiYvCJqLd47UfMxJifjVQQZ2GQAQK8Hm8Z98ie1xoYgQuH6eaYzFVYniDs4IVuZWpgkfE8yK9HWdkSuKN+0v7uULAckRqpQCiPgRDS0IRiABdqlKZb9vZY+rrPDwMobuzehCh8NI61PNolSj5onrnO2e57dF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4373.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66946007)(64756008)(66446008)(66556008)(8936002)(6636002)(66476007)(76116006)(316002)(110136005)(54906003)(5660300002)(33656002)(86362001)(2906002)(224303003)(41300700001)(38070700009)(4326008)(52536014)(6506007)(7696005)(55016003)(83380400001)(71200400001)(9686003)(26005)(122000001)(38100700002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUlDTmhucGJmY2NSSzVHdWE4VUlLZVA2OEZ5d04zdmkwVjlMZG9GTExkc0Zs?=
 =?utf-8?B?ajZ1cm0xSWNtYy9KRm9pNFFhR3AxUTYxbElKanlFWTZqd0JyL0Rhem9URlRt?=
 =?utf-8?B?VzZuN3IvUE55MUltUnFrOXd4WlpSWmNBdUdzTzNJckZqN0xsWDRNS3F2ZTJ6?=
 =?utf-8?B?bjdWbFkyeFhvbFVpYmNjVWJxajJVZlVqRE1POVczS0lZdkRPUVYzN3JsTkhT?=
 =?utf-8?B?U0JyVGJacDc0WTNOSGpSdC9FeVB5OWd3R2RWa21QbXM5RHR2bjcwQmVOc0Y0?=
 =?utf-8?B?TUk1WWJzRWtNaFhnQmdiNWV5NEhGbE80QkhWYW5Ud3RIRkVBdmlTUXptZEx1?=
 =?utf-8?B?Sy90bWZMc1RKazFwSUJobWJXSnQ1K2hQeHNTdDZLM09wYklmRUR3MlV5cW1C?=
 =?utf-8?B?TE9qbUxwWnVHc3pmT2lINUZ5cFhGaThCMUp6NjVHVmRvTDZ0ZHNvSXZndW15?=
 =?utf-8?B?YU5MbEh1V3NZRDh3Zjkwb3FFYnRZK0RVQWNkZThydWcwTmY3dFlVTUF1WFJD?=
 =?utf-8?B?UHlsSHNFMnlIUXBYdGxDSHZCUEZsWGwwT2drTmhScUZyRWduQTFDR05HbExr?=
 =?utf-8?B?WEt0STVKSnB4d2FLNzhtNlVvZ3VEWFhOOFAwQzJWMnRvalB6RHV3aGprN1ZL?=
 =?utf-8?B?a2lxNS9kVSt4cUNjNmZHajJjZ05YcXRlanlLZFlMTk15UGNZSE1HbmxETEtR?=
 =?utf-8?B?Q0hqc1JNYkljbWE0U25ZcWlFUWZzTjNTUWdFUVFmZjMySHhEY3N2T1BCUlN0?=
 =?utf-8?B?a3BDdC9SZHo3K1dMNE1XWTVtaUVMQVpwRVpURnJIdGRjMXh6OXVWSHpXZU5h?=
 =?utf-8?B?Wm0wNGM3WWNqS0tTS1FtR3QxV2pKQjlFU21ZVm9mQ1F2emlVU1FRdjVabGU4?=
 =?utf-8?B?SkkyUlI4Q0hFS3prTzh2VG9xQ3ptWklxdUxQRGpHenlHR1k2UEdwY2Y2VnhL?=
 =?utf-8?B?S1F5cEppaFlHK3l3Qk1JWndYdWFFVzQ3NXNPV0szdTlINVhzMVBWaGtlUnN2?=
 =?utf-8?B?aE03NURrZEdQcnJ2cVhnZmpjMjVZVy8rMjB6d243dzU0RkJZc0w0VnZ2MEt1?=
 =?utf-8?B?N0JJaVEzMzF3dlNKMElkQWMzaEFjaGNMTjhMS3pCWStBdXA2RHo1QUY0OWd6?=
 =?utf-8?B?b3M4RkgyMjBzWVpHSVpPblh0Zy9qd1RZaE5EVUVWK1VhS0JhanFYU2JJV3A0?=
 =?utf-8?B?K2FXKzRoQVo5cVdYNmlZVmZmSHJ5Y1dKa1Nud3h1RFQzTEJpWmlweWtFN1NS?=
 =?utf-8?B?ajFBVEozMS9GM1JMYys5ZVAvZ1U0aE5Na1dUOUsxSTVxR1loaTdTdlRndUxz?=
 =?utf-8?B?Mm8ySmFTL0lhWFU2bWxCeG9IbVFzU2xrSzduSXhBSENPWFJzdisxdFJSWDN5?=
 =?utf-8?B?UnBJTHVTZHpSdlFqWXFQZmV1OVF5ZW1QOHhWcmFHbWdXSnlUSEN6dnR5cHM0?=
 =?utf-8?B?WHJObTVEVjZuOEdFenE1ejd0MjFHTmFhMWJXc2x3NEgrdEFaUjJFdkU3bVE3?=
 =?utf-8?B?cEwreDd6dG9ncnBocnZtZzlZbjFvUTkyU2QvWVorcGJBL3ZaUDVuVkZIK1FL?=
 =?utf-8?B?SCt5YmUySXd5b1pMZ0gxb1ZGUWhzT2VOY1JaaDR4YzV2enYya08zUjdnamxn?=
 =?utf-8?B?cS90elJGSDlaWDR3NUZ4Qkp6MlA0dC9kbCtndHZMQytVSlR4OGY4RmdWdGVM?=
 =?utf-8?B?ODFibzhoMmxaRVlXQnZ6Vm5WVnQyMVJJTkRFRVFSU2lBZFVLTWVBOTJERlFW?=
 =?utf-8?B?M21IZFJjaTEzdk5kdTI2OW91eEFla2tQTjN0dXk5ZnRGNzhhTlBvcUxIQnJF?=
 =?utf-8?B?K1p4NmczZzJjUm43bUh4bU1CK3pkT1BUcHRnWDVoVGkwaXNnVjFyTFVtcXBj?=
 =?utf-8?B?MUxldHJNcXRMTVJCbE8rTTVrb0o5MG1MVzFtWnVpSXlWM2MzcDdWS3F2WkE2?=
 =?utf-8?B?ejZqZzl3UHJNVTV1ZSs1d0l6NHlpWlI5QjBGUHR1MjB2blFxdjRmdS9rR1ZM?=
 =?utf-8?B?YXZnR2F4dUdrVTZHTFVFLzFZT01KR2pZd1lRWTd4UDRwd2Y3dnZ0UjRQT1Bm?=
 =?utf-8?B?SWd5M1lva3VxSWk0NXMxNlVFNGVyenpwRTIyd3JkUzlPTDJKbmIvZzdMMGN2?=
 =?utf-8?Q?dObY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7ef4f6-1c96-4736-2c6d-08dc0ddb8e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 10:46:21.4132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiL2Xs81AKDccj3dnvxEoVrIHGuat/zB1IpzhI1YyeTJCAi06PYKm5F0iELwEpCysR6M8IfGH+m/7GYAkyFj6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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
Cc: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBQZXl0b24g
TGVlIDxwZXl0b24ubGVlQGFtZC5jb20+DQoNCi0tLS0t5Y6f5aeL6YO15Lu2LS0tLS0NCuWvhOS7
tuiAhTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
Pg0K5a+E5Lu25pel5pyfOiBGcmlkYXksIEphbnVhcnkgNSwgMjAyNCA2OjQxIFBNDQrmlLbku7bo
gIU6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5p
ZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQrlia/mnKw6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4u
U0hBTk1VR0FNQGFtZC5jb20+OyBMZWUsIFBleXRvbiA8UGV5dG9uLkxlZUBhbWQuY29tPjsgWXUs
IExhbmcgPExhbmcuWXVAYW1kLmNvbT4NCuS4u+aXqDogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXgg
dW5zaWduZWQgY29tcGFyaXNvbiB3aXRoIGxlc3MgdGhhbiB6ZXJvIGluIHZwZV91MV84X2Zyb21f
ZnJhY3Rpb24oKQ0KDQpUaGUgdmFyaWFibGVzICdudW1lcmF0b3InIGFuZCAnZGVub21pbmF0b3In
LCBhcmUgdW5zaWduZWQgMTYtYml0IGludGVnZXIgdHlwZXMsIHRoYXQgY2FuIG5ldmVyIGJlIGxl
c3MgdGhhbiAwLg0KDQpUaHVzIGZpeGluZyB0aGUgYmVsb3c6DQpkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdnBlLmM6NjIgdnBlX3UxXzhfZnJvbV9mcmFjdGlvbigpIHdhcm46IHVu
c2lnbmVkICdudW1lcmF0b3InIGlzIG5ldmVyIGxlc3MgdGhhbiB6ZXJvLg0KZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jOjYzIHZwZV91MV84X2Zyb21fZnJhY3Rpb24oKSB3
YXJuOiB1bnNpZ25lZCAnZGVub21pbmF0b3InIGlzIG5ldmVyIGxlc3MgdGhhbiB6ZXJvLg0KDQpD
YzogUGV5dG9uIExlZSA8cGV5dG9sZWVAYW1kLmNvbT4NCkNjOiBMYW5nIFl1IDxsYW5nLnl1QGFt
ZC5jb20+DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0K
Q2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0K
LS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZwZS5jIHwgMTAgKystLS0t
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnBlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnBlLmMNCmluZGV4IDZmMTQ5YjU0ZDRk
My4uYjlhMTVkNTFlYjVjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZwZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnBl
LmMNCkBAIC01OSwxMSArNTksOCBAQCBzdGF0aWMgaW5saW5lIHVpbnQxNl90IGNvbXBsZXRlX2lu
dGVnZXJfZGl2aXNpb25fdTE2KA0KDQogc3RhdGljIHVpbnQxNl90IHZwZV91MV84X2Zyb21fZnJh
Y3Rpb24odWludDE2X3QgbnVtZXJhdG9yLCB1aW50MTZfdCBkZW5vbWluYXRvcikgIHsNCi0gICAg
ICAgYm9vbCBhcmcxX25lZ2F0aXZlID0gbnVtZXJhdG9yIDwgMDsNCi0gICAgICAgYm9vbCBhcmcy
X25lZ2F0aXZlID0gZGVub21pbmF0b3IgPCAwOw0KLQ0KLSAgICAgICB1aW50MTZfdCBhcmcxX3Zh
bHVlID0gKHVpbnQxNl90KShhcmcxX25lZ2F0aXZlID8gLW51bWVyYXRvciA6IG51bWVyYXRvcik7
DQotICAgICAgIHVpbnQxNl90IGFyZzJfdmFsdWUgPSAodWludDE2X3QpKGFyZzJfbmVnYXRpdmUg
PyAtZGVub21pbmF0b3IgOiBkZW5vbWluYXRvcik7DQorICAgICAgIHUxNiBhcmcxX3ZhbHVlID0g
bnVtZXJhdG9yOw0KKyAgICAgICB1MTYgYXJnMl92YWx1ZSA9IGRlbm9taW5hdG9yOw0KDQogICAg
ICAgIHVpbnQxNl90IHJlbWFpbmRlcjsNCg0KQEAgLTEwMCw5ICs5Nyw2IEBAIHN0YXRpYyB1aW50
MTZfdCB2cGVfdTFfOF9mcm9tX2ZyYWN0aW9uKHVpbnQxNl90IG51bWVyYXRvciwgdWludDE2X3Qg
ZGVub21pbmF0b3IpDQogICAgICAgICAgICAgICAgcmVzX3ZhbHVlICs9IHN1bW1hbmQ7DQogICAg
ICAgIH0NCg0KLSAgICAgICBpZiAoYXJnMV9uZWdhdGl2ZSBeIGFyZzJfbmVnYXRpdmUpDQotICAg
ICAgICAgICAgICAgcmVzX3ZhbHVlID0gLXJlc192YWx1ZTsNCi0NCiAgICAgICAgcmV0dXJuIHJl
c192YWx1ZTsNCiB9DQoNCi0tDQoyLjM0LjENCg0K
