Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D50C46467
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 14:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F7810E154;
	Mon, 16 Jan 2023 14:06:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4888D10E44D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 14:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPB5+IXyKrJIhPsw/GEGdY+MflfqQzhGLf5uw0lM4w+Iqp+ag4JJMush5QyUNkeZMR48pdgcLjhDWRl0q8J/E2cT9dFISYfiBVch+TAxMx/1LX0ORNPG43csBISTKtjaWyydd19jXa6KYbzr6n/4KhRUs/wRE1w0QhshqT7wo0y858r6tlkSKJL0V7r6tQaLQXu2oxKn9gxZe8wpAmj8xNBfdlDpUu6Putlr7VZu9YDUv8qeCJ/suCnvtZNkCnxATudMPdRlDq5pPM5YnmiEuFzpq+Qg1wGLzOWvouRN9DXP689A2ooc8ReTM7ESt6h3RXy/G3THg71jy3RZmu5NYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2K8BrSaJ/33FkVwUObJ/JrXhCNyxNY4lX3UoLobhP8=;
 b=XorSIvdhMYU+DlspmPpJPnC678EbTZ6xJzF0Ri+tmeDXKfE9U30/HGUqI4/3q8CqszA7qJB1WwxjXUh1QZk6PiEE7/pkUi++zfPlZOgnx/8ybOuS0rA77mNPWV4HaO+b6iACVyRkqGQExPOoeLqXvdk2z5/gkZmjPqqd0Llw3X57MWbbwR590DTe/HXRYjK7FW3KtzIyHVskphGXC4dds2AmJ6JERXzd0sqIShFedRxZnh761EH+/u58K+OiTZlPhf+vl57zSVimqk//5irGvJ33/4uY9yPf8GuTUk8oi07HtzS8BYJW/KURlY7wVC9B85nuMkcvIDTKrtSjn9c6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2K8BrSaJ/33FkVwUObJ/JrXhCNyxNY4lX3UoLobhP8=;
 b=MZVsJ8JHTvRUW3RMFhP0noGf/gK3z/qRBw9tgZxecYwsfYF16jBmmfk8I0E1uHaCZuiS5Nun6YgL9VpgGq8YuS0i7z9NEBc1K+stGNGucSqOs9XefP7uGJlsVjRkDJAWzpFBQ1l8wApedEroZj56rVmNk0AMiefG9UNVdQDLa+s=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 14:05:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%8]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 14:05:50 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/3] drm/amd: Adjust legacy IP discovery for
 Picasso/Raven/Raven2
Thread-Topic: [PATCH 1/3] drm/amd: Adjust legacy IP discovery for
 Picasso/Raven/Raven2
Thread-Index: AQHZKRaoq4ZJ76hzrk+GB+TWssDZFa6hEQiAgAAD98A=
Date: Mon, 16 Jan 2023 14:05:50 +0000
Message-ID: <MN0PR12MB6101A52E211A727F7D841F20E2C19@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230115192144.4566-1-mario.limonciello@amd.com>
 <CADnq5_OW7rmBqGbW=X+LHGkhW6Dr5tC628JPboAg7cP+uHct1Q@mail.gmail.com>
In-Reply-To: <CADnq5_OW7rmBqGbW=X+LHGkhW6Dr5tC628JPboAg7cP+uHct1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-16T14:05:50Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b82da81a-3c41-4d5d-9888-e17682205b73;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-16T14:05:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: cecfa25b-986b-4125-b801-e6ba015a729b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH2PR12MB4213:EE_
x-ms-office365-filtering-correlation-id: fcc8a04c-4bb5-4b68-2a15-08daf7cac62e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWc0COuCdiuETzMObX7NmG91i2PR/fyaTWA6hk2ouc0DaxYK935kaF3lVcmZ+aUDZj7J5dvS+zu9QdLBNzMy64zXTG7yNSB6/N/nuqAuDcg+xQqgQqCMx2eUHImivMwly3gHPl//Vgu6jKbdCGsyRaWqETPFkJvN+kV2aURMOm1S/qJ4Q052mJzbLlU9MKQdRxazZsGHPT3xTpsCRcER7VbtTDH5SJh9O3RlaerWUU6ugRo3Pf+ycXn+Dn/1xhs9SGG9d4Mx0Ce7f51d5DXqvOYjVRCmxMTkR0F3dH7uQL69ov3aQHm/vzo81/CUdX3QwyC4nOobRS6qrV5RbdbMZMOeWrhvrwkYtvPb205t6MP84zBP1vEm7ssROBxdaxog5mHmmkiYqKn1g8OyJ7xLenPgunjN3TzIZHy6TK2ZK6Gq4UIj2AAruriCI6lmJXezjzjDeNEwZ5FK4UFqoDjY7I1McOO9FAOZj/bqGkydVoyQP/Gdc9qa8XXCiwq67ygUWHd5XARU0/GBOcsmolmtGBWmwvwH+de1iyftpMBIsDlVanxkmlGW4muOIeAO+xs3Nu5D/cBwooUGoxgKQscMQG3QebtwC3WPM3yfZuXLYiZsE/Ybo0j40GRC7LzyNfYgUe6+4iKQaKcSSjoyGGn4xjpJSO8XgFJkb4dqweLO1s/XbUQk6WaZYa1w+MbDzr1Gg8N/WJhw0Gw0cOOiihZuDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(33656002)(316002)(38070700005)(122000001)(38100700002)(52536014)(86362001)(41300700001)(5660300002)(66556008)(19627235002)(66446008)(66476007)(76116006)(66946007)(4326008)(8676002)(64756008)(6916009)(2906002)(55016003)(83380400001)(71200400001)(7696005)(53546011)(26005)(478600001)(9686003)(6506007)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cms4RDVDaUFiVXlLSFhCUHlyeW9UbkZtaHVUOElNRjl2aXdGcUF1ZzZuWVJJ?=
 =?utf-8?B?SDY1Nk9XL25FK2VVUnlSUFFMUm1mampMMWVKQXdsNTN2MW9IOFVTV0xmZDNs?=
 =?utf-8?B?LzRMVi8xR0hDSSsyK0cwSTBXQ052VDgvdjMyRlVoZTVlUThBdTlYQWRhOGZH?=
 =?utf-8?B?d21LdGJ3SVNOK05xdmw0TU1DbnNRWlN1amFEbFZRaFpHTWk3aGQ5MzJ1Mzdu?=
 =?utf-8?B?T1FGc3k1djRwYjdUdXNwVFR3ZDRvK3lqdW80N0N1TzdhendVTTZNcjArcGVn?=
 =?utf-8?B?TnJjRi9lNDE5WGNxeWpMaFBYMWNuaHRNTktQVXA5RWI5UHljUkZrUFM0TmdW?=
 =?utf-8?B?UzNPSHNYK2RQSWQyOWwxVVdubEI5WWRYWUEzYVk4T1BBK0ZwMWx0enpnTmVK?=
 =?utf-8?B?T0RHUGwyWjNodEQ4YkR4TFpGK3FOcDNScGM0ZVQvbmpqR2djUEJNL2RUNkZk?=
 =?utf-8?B?aUV3dE9ncnNQVW5Lc0pLcEFTTHNHT0VxWVRhMTR1TGVpL0NLeThtRGFoL0Rl?=
 =?utf-8?B?NDdqNFpwMXlQLyszdVdFdWdDMVFBVVd1OHk0RXJDSEJqOGFVcXU4eUQ5Z3Y3?=
 =?utf-8?B?Szgzc2RXV3dUb2NPb0pPUSs4TDFJeUVpOSsvcERadk5iOHVodHU1OGVQamZO?=
 =?utf-8?B?TDhLV3g0dWlVa2UvMzdoT3ZQSUVlN1JoMUhOUnVFRStuM2Z2VGVpQTMzbHVz?=
 =?utf-8?B?eU5UR0FuQWZrcGpneitoRS9uY2x6SCtHUXRYM0lLN2w4OWNieXdVYVNuYXJO?=
 =?utf-8?B?Q0RSWUF2OTVidTBTTjcrdk5vY0dIVUZxMUltekZvbGUrTWRldU1wdWdXVHF1?=
 =?utf-8?B?djBKbXcyZ3Z5NlZrUHF1bncvK1pEZ3Vvb09aNTVOUDZOcEI2OGVXZ05Uazdr?=
 =?utf-8?B?dnRQTzhYUjZJd0tRTWZkY1d0ZFllN3JlNlZVa0tzeFBoYnAvcjJwQXhBc3BF?=
 =?utf-8?B?S1lybXZZYkFsWVp4ZjBuclI4dXdqQzBDTEpwZEJTZm1jdzV5TWVhTXZRZXVQ?=
 =?utf-8?B?aFNEM01iVjlkdmVCOU40cUVqdDJFYU9Ib2FVMWFGSjFFdnlUeXhtcm43SEc1?=
 =?utf-8?B?ZnAyeXBIT0FWQlpud2dHdVk2Ry9vaFRHL2dxdlZ1Y3FRYTBaSUREcEcvMmhW?=
 =?utf-8?B?YW1pSjdmZ1I0WUxGRWV3NWtNbW5zQmoxdGlNVkpsSjdMS3UzNnc5UXFCTng5?=
 =?utf-8?B?TG5KclEwYlAwS1MwckFlbnd3V2M3M0ZWdUlVUzA0dkdBclFTcHhQKzJXUEFU?=
 =?utf-8?B?b0NMOHQrb095RnNRR1gzUmFTRVNUZkc2NFp3cjI0c1MvbzU4WVRPODVSWjRY?=
 =?utf-8?B?ZjhxRXdMdjB3Nzk4SkZ5WGZlWVNlNGs2d1E3RWMyNHQwNlRpYzhEM1Fha2t2?=
 =?utf-8?B?WjRhRm5qZEc1VWEzVTRhbVQ4Y1BTSXYwcFZnZlBVelgrZFlYcWR4V1JmUzRQ?=
 =?utf-8?B?UTBZWlJWczgxdWNobHJOeFVaVVZUVjB3UGg4bk8yaVFnTWRuSnBMelN1a1ht?=
 =?utf-8?B?QnhGQ0dTcmRta3J2OXNwbnVhTFIzNUVISUZQMTZ0UUlaTlZSQlQ0cU5Jakhj?=
 =?utf-8?B?QzJaUHllU3hvdU5FbmlNZnlON2xnOVBWZklhazczNVQ2NVVWdHhIdlVYNWwr?=
 =?utf-8?B?NUl5RkwwNXZtTlA1bUxacDYzSHUyZ1l2WWpRaHlKdFZ0VnNLdmVYeFNQOW1y?=
 =?utf-8?B?WERveVd5WHVkeTVySms3ZlUrSlBNSU5xY0Z5aUpFSm8vNUcxLzdSZFNNU2o2?=
 =?utf-8?B?OVVJT0xVT0NtSjdndkVpU1F2Q04wRW5TOWNzbEVVdG5wcGV5OTRFWnRtOE5s?=
 =?utf-8?B?cmhDRGRUWDc1UzFKaldkdkVLNzBQS2FickN4Wk9EUnpoZTFNMmd3RU1UcFBo?=
 =?utf-8?B?YVpIZlN5cUgvYTQ1ZjJjVDYzblJvWHh1Q2xmME0zYmZKU3AzaDRDMU0zL1Bj?=
 =?utf-8?B?M1hlOFhPck5SQWlDV0F4STQwblZmNElHTnlIZUU0RW4yanlHaEVEc0tPeUtu?=
 =?utf-8?B?eHp5cUZtQVVTcDNhTGtmdWhRMDBPWUptRllieGtIOU1KZkRqditiTUJ2VWhr?=
 =?utf-8?B?VjgxcVRGYlI0d3hXY0YwcWYra1ZmZ1BiKzM4MTVYL29kV2kxMGNneUpPQ1Bm?=
 =?utf-8?Q?VhnA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc8a04c-4bb5-4b68-2a15-08daf7cac62e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 14:05:50.6246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ej4coC2Kj8U/0y2jcZX0QLxCdzMVZnrhFQeBeB0nSp4h7HuzKBF9oEDhGtGeQM+VUtnIZ9ffleBxhh67tb6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFy
eSAxNiwgMjAyMyAwNzo1MQ0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNp
ZWxsb0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWQ6IEFkanVzdCBsZWdhY3kgSVAgZGlzY292ZXJ5
IGZvcg0KPiBQaWNhc3NvL1JhdmVuL1JhdmVuMg0KPiANCj4gT24gU3VuLCBKYW4gMTUsIDIwMjMg
YXQgMjoyMiBQTSBNYXJpbyBMaW1vbmNpZWxsbw0KPiA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgc3dpdGNoL2Nhc2Ugc3RhdGVtZW50IGN1cnJlbnRseSBj
b21iaW5lcyAxMC4wLjAgYW5kIDEwLjAuMSwgYnV0DQo+ID4gMTAuMC4xIGlzIG9ubHkgdXNlZCBm
b3IgUmF2ZW4gMi4gIFNvIHNwbGl0IHRoZSB0d28gY2FzZXMgdXAgdG8NCj4gPiBtYWtlIHRoaXMg
Y2xlYXJlci4NCj4gDQo+IEtlZXAgdGhlIGxvZ2ljIGFzIGlzLiAgV2UgZG9uJ3Qga25vdyB0aGUg
cmV2aXNpb24gaWQgd2hpY2ggaXMgdXNlZCB0bw0KPiBkaWZmZXJlbnRpYXRlIHRoZSByYXZlbiB2
YXJpYW50cyB1bnRpbCBhZnRlciBJUCBkaXNjb3Zlcnkgc28gd2UgY2FuJ3QNCj4gYXNzaWduIHRo
ZSBwcm9wZXIgSVAgdmVyc2lvbnMgZm9yIGVhY2ggcmF2ZW4gdmFyaWFudCBhbmQgcmF2ZW4gYXNp
Y3MNCj4gZG9uJ3QgaGF2ZSBhbiBJUCBkaXNjb3ZlcnkgdGFibGUgKGl0J3MgaGFyZGNvZGVkIGlu
DQo+IGFtZGdwdV9kaXNjb3ZlcnkuYykuDQo+IA0KDQpHb3QgaXQgdGhhbmtzLCB3aWxsIGRyb3Ag
dGhpcyBwYXRjaC4NCg0KPiBBbGV4DQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8g
TGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jIHwgMTIgKysrKy0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vj
b2RlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYw0KPiA+
IGluZGV4IGMwMzgyNGQwMzExYmQuLjBkOTUwYWUxNGIyN2MgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYw0KPiA+IEBAIC0xMDc0LDE1ICsxMDc0
LDExIEBAIHN0YXRpYyBjb25zdCBjaGFyDQo+ICphbWRncHVfdWNvZGVfbGVnYWN5X25hbWluZyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IGJsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAg
ICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTAsIDAsIDApOg0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChhZGV2LT5hcHVfZmxhZ3MgJiBBTURfQVBVX0lTX1BJQ0FTU08pDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gInBpY2Fzc28iOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAicmF2ZW4iOw0KPiA+ICAgICAgICAgICAgICAgICBj
YXNlIElQX1ZFUlNJT04oMTAsIDAsIDEpOg0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlm
IChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SQVZFTikgew0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVfSVNfUkFWRU4yKQ0K
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gInJhdmVu
MiI7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIGlmIChhZGV2LT5h
cHVfZmxhZ3MgJiBBTURfQVBVX0lTX1BJQ0FTU08pDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAicGljYXNzbyI7DQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gInJhdmVuIjsNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICB9DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuICJyYXZlbjIiOw0KPiA+ICAgICAgICAgICAgICAgICBjYXNl
IElQX1ZFUlNJT04oMTEsIDAsIDApOg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAibmF2aTEwIjsNCj4gPiAgICAgICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAy
KToNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
