Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05894C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 17:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0507E10E5B7;
	Wed, 10 Aug 2022 17:39:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E47314ABF1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgK2uuszZpmAzlq8PyX4HrtVUG7+RMioCOvJqdwhNPqH3cvVuPuh1EwvyhCoa2TuZ728iYf54w1TxXKXmslKLSkEf3kFsMuVzdfj7LzQBETj5hnk1yVkJLATkLWylTU6lh2bUld8N0/6wn6URf16I7BZ4gi84o6GiFz3WsPoD7ylnyjLU9to+Q/gMKcPjKsXFyQGuTJ7h07ZPCSZJcEmGI+30PZtzunYmbV2RXQneHiYHgcxQdNpEsITYNNWklo7yMqBI17wHJUvx2US5NJqrgT0zIdVFU4hbwR4Z8DqPrpJs5/+OG+BzGMINUbbQmods1XkuEcdwAhYPFcf4XKKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAncNhjcvvgdPajll+fuMIolyAUHB2oNVb68V6fawU0=;
 b=n106yqMr9ML+RUZiOxJoz76Gxkp4BdoQHyM3Qwy0M+AlCBIJQse1S69FbLf4LaKNJjBBr6IXNiSt+iX5lU2h52VklWA55u9+cA+mpOa1Y/+jQpo40Mzpz+54kP5NxPZhippu/DhvgEzPs36lebSMwKfcnd/G2iTGiyUXWrSqTySoF4ciic4KJqiMYC605gR2BhTA2i/5zQxsB3kGU2Pd8fZi8a5Q1EKVrz25cRfcJpiaCs/1D25rQHDzTVJKgzrc7PJsUqyoLzQSotQLm1q0La/sL9GY3+rproWl+WIKiTs9wN6XqWDqP8NdDi/rEi9V3U5Mg8/bxKam5NxGtEZ27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAncNhjcvvgdPajll+fuMIolyAUHB2oNVb68V6fawU0=;
 b=3jdqsYeSqhZ2+CwBLeiLYURbHohkQTtske9fAeIVz+GNs5VPTV/WozSXwzWho3AMIAHparko7xFADifPMVXmHIKo4QUYTViq/cFUdX1I3Mu3lqUytiRKjpqlgOpZLzn98yWYcI77VyRf0hSNTJOlKWHyqhCmEnr+w6DDei97mBA=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BN6PR12MB1380.namprd12.prod.outlook.com (2603:10b6:404:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 17:39:03 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::10b1:8de5:fbb:2899]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::10b1:8de5:fbb:2899%6]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 17:39:03 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: use sjt mec fw on aldebaran for sriov
Thread-Topic: [PATCH] drm/amdgpu: use sjt mec fw on aldebaran for sriov
Thread-Index: AQHYqOXJut5BtQXw4U66V3cXGIS+fK2oXHgAgAAQGrA=
Date: Wed, 10 Aug 2022 17:39:03 +0000
Message-ID: <CH0PR12MB53729298AF8D9115C43D8BD3F4659@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220805160930.13664-1-shaoyun.liu@amd.com>
 <CADnq5_N18cwfpxO-U7yhp2snY170_Y07f2xddCzdf4pjn-hwaQ@mail.gmail.com>
In-Reply-To: <CADnq5_N18cwfpxO-U7yhp2snY170_Y07f2xddCzdf4pjn-hwaQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bddc28aa-a3b3-43b2-803b-159d3734e64f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-10T17:32:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2efbcb45-8efd-4e38-9909-08da7af737c3
x-ms-traffictypediagnostic: BN6PR12MB1380:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mi0JhO5lkMcX7+rXdSMOYzPsXGb9hcDKpuB2iBY7r+xjeqU0Ux2a3fhRnsIgoiAaSCkJmAhdbFmG1K4+IUStdZRrAfOadK2o1bNtclDE6xTVMRrPj7NoaQHuhgBknp4H/OLq5j71kMTU+3I9n5xsaE0Erj804IBdp5d5tuel5zZpIaY3SwL7Bu7myOa/JQxRawojRHGiC4GPDqwMTADIDfBkqEE2AAQb+xM4WszrTUtIKVojmNl2rW00gtpze1JmTyb1vk/a1pQBwOQvviinmoyu+C9P3pYbUwjp+vDPVSBxCad6DXT+XYOytoptuFRTxapp6lzXlTaukCOrMnNmriidDpDz/RnbTh4D0XDaC/DxdPPJviFIUGM7qUT0f2/NZcb4fjTwitoPP7jLK6F3fBbC8s1QPQIJRPf35eKkHAA9z22kzxaFwo7iN8PRORmqlvts+rnnPMLZ6tNiNjMJWE9UNp13J5oWeUaq4nbMSxFgOSPomTqcptEL26ROAlQhyQ38qdMRz8Gp+AMe2jj3wwoN2WtCrc6l1+0xtqrhEsUhVMMflrDwntXmnApuFmHrSiMVyQ5PFM10A5GHLImyrHIKGZD/yPaSMzYxC7uZw/nRyp89TgNuAhWij8Rx6ebPVzUVSE1ackDFUKnEMGgjGpvwOwiqCaoyL4WaoWs715VookTDDTGYltLkizZnOboUNHbEuCSJp7N3VMo5irM3ROf5QvqvUktIyaQZS82cypuTLqohjyd1K//CK8RZjIzCrXbg7afGB6rFUp8LdLOcg/aOX1Z/oM2H4fNzAWeTf+7hP4U4Srw1wPbxf7V0shBA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(38070700005)(6506007)(53546011)(9686003)(26005)(55016003)(316002)(7696005)(8676002)(41300700001)(4326008)(2906002)(86362001)(66556008)(66946007)(64756008)(38100700002)(76116006)(122000001)(66446008)(66476007)(71200400001)(478600001)(33656002)(186003)(6916009)(5660300002)(8936002)(52536014)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW4xTk1TWmRHSzgyUEdGYkJTSlVJckhCNW1YMzF1N3NvUnc4bmNGSVp4U0Mz?=
 =?utf-8?B?MDZYeXI1ZElzeHU5TGhEcklzT1FmTnZSbTlEZGJTOWkxZE5aYlN6dVdKYWxQ?=
 =?utf-8?B?VVgxbkxYQ0txdWxmRktETThmYzcyTFF3bTdLQWdFMmVoeWNhdnJXMmRPNnNR?=
 =?utf-8?B?ZTZ3c3l0MVN0NmxVSVJtbi9tcjBQSG80RXhlcjF3SXNueldmRitRZDhCbVVi?=
 =?utf-8?B?M1grdEFnNzdhZ1huZXZ2VkJoUGw4VmN3bGVaaHh5MGlJc01CTSsrRUlBM0ZE?=
 =?utf-8?B?M0w0dzg4MHVrZ0VVU0xXbmdHRGdtbVVKUUZQRXRIVjZ4NjdwaVQvanRvVEox?=
 =?utf-8?B?M1d1cEZsdDNiSkZ4NnVoSHRKZ0FRL1MvMjdvVjZ4UmtESmUyczdHaWp3bmFj?=
 =?utf-8?B?b1VGb2Q0d2tFeFl3Z2dOV2pPbDVkVXVSa2N6blFRMVAyZ0s5NDZyL05WdDBo?=
 =?utf-8?B?RzJ4YS91Y2oydWd4V09nZkZZeDBTeit6Q0l4eWJnT2VaNlp4Z0twL3VjSlQ4?=
 =?utf-8?B?ZEx4RlBEWStrOVZxQnJrWHZYMFdFeXNjN2pRdTF6Lzc1V3RmcVBicTRERGpC?=
 =?utf-8?B?Ym13dGpSVWRQL1hUNDdFVktiNTNPcFBENmsyeEdrMFZUMDhKZjMyaGdMYllt?=
 =?utf-8?B?eUh3MmorSFBTa0xwcGkwemk2dWNNQ2liZ282TmdwWTRNMGFFME1rNHpwcFNo?=
 =?utf-8?B?TDVjSnVCZGNraGI4dHlJNUdncXFqb25Lblg4QXdWZmQxTlYwbEZpQmZLYml2?=
 =?utf-8?B?bnBaazN0bGpta3JCUkVWQm5jOU0rQmgwekdrWitXK25FWlRnVlBPTEY1WVVw?=
 =?utf-8?B?REJwcC84MEZWSGNxdUdkRUprK0UwYTlUaTBxSU9iemlTYk1EWERjYkZpWVg3?=
 =?utf-8?B?bXQ4WXhCenRidXF5WWpCRHJvUXdmQ2NsbUVQTTVGbWd4dyt2QmRlU3B6amFP?=
 =?utf-8?B?clcrUHFSbEU4L09saTlQcWwwSk5EdFJkRW1TTHJDelJ4Y2ZjN0M3ZnJtSXFC?=
 =?utf-8?B?djVxWVhmQnNqam0xMXBMbEVVSElRM2ljUWxoTDI0dVVLSkNKNkc4eCtBVTdB?=
 =?utf-8?B?cHQxRmZ5S3hxbEY5Tmp5anc3YS8yeUorUXFleE5DaHpWVGNkclJnU1dpNlYy?=
 =?utf-8?B?dWM5QjNyQWZna2tKRkp6OXZjSTQyLzllVFlUNTF4U1F1ZG04N095bHNGR2VB?=
 =?utf-8?B?ODJrT0dLOTd0WVR4T2hsQnllQ0hDTG0rclBQY3RYdCtpd0tsb254aENuM1Bv?=
 =?utf-8?B?ZktGUXhveTB6aFdodk5IaTdJZTRiMlVZeS9WZFhJd1NTNmk1YkMrbVpDZjhQ?=
 =?utf-8?B?cXVJaDFJM2JWVU1jSjZoVUJnbzRwN2twU0pkUDUvZ0RnVDRaWVcxNmcxWmQ0?=
 =?utf-8?B?RmVQTU9ncDJQL3pMaVd5WVZIdkJoVWt6WEpTTUVwTlIwZldJSGdRUW5wUlky?=
 =?utf-8?B?QlZLR0trSlJMZW53ejkzRjlsSGNBS3lBMXdiRk9LWHZ1bFhTRGtwYTdXeHFa?=
 =?utf-8?B?NU9TVnI5M2s0WDJOczNLY01ZeDBmSkw3algyd2ZhVXZVcnhyWTNVcXNYNUx5?=
 =?utf-8?B?ODV0TGpmaFdoTWdTZU5nL2xaeXgrTDd1NGExNDhPRWZMT051cEgyNjFGK0dH?=
 =?utf-8?B?bi9xRlQrK3B0M21LUzdOT0N6a2E1MVY5SGZCdUtsTDhhYm5Db1dKY3dIM1ZU?=
 =?utf-8?B?a1B6ek1QTmM2a1JxQVNDNGdnS1prbDlrNW52cnNITVE4TFpGa1U1ZmJMamFC?=
 =?utf-8?B?YzBET0FOcXcrMjB3NlhudWl2RFFvRFFKTXBPNmhNTmdDN3NwdXVTMml0REti?=
 =?utf-8?B?MDEvTUJaZjVOeDlOUGoxTGFSVjR4OHU0K2lKdHhDN2l5NVNBODBVeUpsS05G?=
 =?utf-8?B?cmZTSmU0Q1pxUEF2eWNKMW42QnNXSTB6TzI0azB3bUszUHlramQvU0RzcG5i?=
 =?utf-8?B?NXRmSWpQYlVOaG0wdjhJL0FYOTNkWWZlUWRnVEtCS25oWTUyNDA5Skd6UVJG?=
 =?utf-8?B?b3BHWVl2aGtpMnVaK0ZseHNRU29JWHJkV1BwZDJ0VjdPbHJTeEVCcUN2cjdh?=
 =?utf-8?B?VDEzNy9ncnRDUVF4UWNseXduNGNSQXcvbkVmRXBXM1BuU0dWZjl4akJSbjZM?=
 =?utf-8?Q?HMcs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efbcb45-8efd-4e38-9909-08da7af737c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 17:39:03.7266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJOJO7ZRzaT8cXyrvuEOHbhJdxMsnbD0lreZu6yhcGKeUCclqba2ZSepFmPfnprycelNqoGoEQFPm0ObMSgRSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1380
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBmb3IgdGhlIHJldmll
dyBhbmQgeWVzIGluIHRoZSAgaG9zdCBkcml2ZXIgc2lkZSAsIHRoZSAgUEYgYWxyZWFkeSBsb2Fk
IHRoZSBzanQgTUVDIGZ3ICwgIHRoZSAgcHNwIHBvbGljeSByZXF1aXJlcyB0aGUgIE1FQyB2ZXJz
aW9uIGxvYWRlZCBpbiBndWVzdCBzaWRlIHNob3VsZCBub3QgYmUgbG93ZXIgIHRoYW4gdGhlIHZl
cnNpb24gIGFscmVhZHkgIGxvYWRlZCBpbiBob3N0IHNpZGUgLiBTbyB0aGlzIHdpbGwgZ3VhcmFu
dGVlIG9ubHkgIHRoZSBWRiB3aXRoIHNqdCB2ZXJzaW9uIGNhbiBiZSBpbml0aWFsaXplZCBhbmQg
ZW5hYmxlZCAuDQoNClJlZ2FyZHMNClNoYW95dW4ubGl1DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6
IFdlZG5lc2RheSwgQXVndXN0IDEwLCAyMDIyIDEyOjM1IFBNDQpUbzogTGl1LCBTaGFveXVuIDxT
aGFveXVuLkxpdUBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiB1c2Ugc2p0IG1lYyBmdyBvbiBhbGRlYmFy
YW4gZm9yIHNyaW92DQoNCk9uIEZyaSwgQXVnIDUsIDIwMjIgYXQgMTI6MTEgUE0gc2hhb3l1bmwg
PHNoYW95dW4ubGl1QGFtZC5jb20+IHdyb3RlOg0KPg0KPiBUaGUgc2Vjb25kIGp1bXAgdGFibGUg
aXMgcmVxdWlyZWQgb24gbGl2ZSBtaWdyYXRpb24gb3IgbXVsaXRwbGUgVkYNCj4gY29uZmlndXJh
dGlvbiBvbiBBbGRlYmFyYW4uIFdpdGggdGhpcyBpbXBsZW1lbnRlZCwgdGhlIGZpcnN0IGxldmVs
DQo+IGp1bXAgdGFibGUoaHcgdXNlZCkgd2lsbCBiZSBzYW1lLCBtZWMgZncgaW50ZXJuYWwgd2ls
bCB1c2UgdGhlIHNlY29uZA0KPiBsZXZlbCBqdW1wIHRhYmxlIGp1bXAgdG8gdGhlIHJlYWwgZnVu
Y3Rpb25hbGl0eSBpbXBsZW1lbnRhdGlvbi4NCj4gc28gdGhlIGRpZmZlcmVudCBWRiBjYW4gbG9h
ZCBkaWZmZXJlbnQgdmVyc2lvbiBvZiBNRUMgYXMgbG9uZyBhcyB0aGV5DQo+IHN1cHBvcnQgc2p0
DQoNCllvdSBtaWdodCB3YW50IHNvbWUgc29ydCBvZiBtZWNoYW5pc20gdG8gZGV0ZXJtaW5lIGlm
IHRoZSBzanQgZmlybXdhcmUgd2FzIGxvYWRlZCBzbyB5b3Uga25vdyB3aGV0aGVyIGxpdmUgbWln
cmF0aW9uIGlzIHBvc3NpYmxlLCBhbHRob3VnaCBJIGd1ZXNzIGl0J3MgcHJvYmFibHkgb25seSB1
c2VkIGluIGNvbnRyb2xsZWQgZW52aXJvbm1lbnRzIHNvIGl0IHdvdWxkIGJlIGEga25vd24gcHJl
cmVxdWlzaXRlLg0KDQpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPg0KDQpBbGV4DQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogc2hhb3l1bmwgPHNoYW95dW4u
bGl1QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYyB8IDE0ICsrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jDQo+IGluZGV4IGM2ZTBmOTMxM2E3Zi4uN2YxODc1NTgyMjBlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gQEAgLTEyNiw2ICsxMjYsOCBAQCBNT0RV
TEVfRklSTVdBUkUoImFtZGdwdS9ncmVlbl9zYXJkaW5lX3JsYy5iaW4iKTsNCj4gIE1PRFVMRV9G
SVJNV0FSRSgiYW1kZ3B1L2FsZGViYXJhbl9tZWMuYmluIik7DQo+ICBNT0RVTEVfRklSTVdBUkUo
ImFtZGdwdS9hbGRlYmFyYW5fbWVjMi5iaW4iKTsNCj4gIE1PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1
L2FsZGViYXJhbl9ybGMuYmluIik7DQo+ICtNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9hbGRlYmFy
YW5fc2p0X21lYy5iaW4iKTsNCj4gK01PRFVMRV9GSVJNV0FSRSgiYW1kZ3B1L2FsZGViYXJhbl9z
anRfbWVjMi5iaW4iKTsNCj4NCj4gICNkZWZpbmUgbW1UQ1BfQ0hBTl9TVEVFUl8wX0FSQ1QgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMHgwYjAzDQo+ICAjZGVmaW5lIG1tVENQX0NIQU5fU1RFRVJfMF9BUkNUX0JBU0VfSURYICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDANCj4g
QEAgLTE0OTYsNyArMTQ5OCwxMSBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2luaXRfY3BfY29tcHV0
ZV9taWNyb2NvZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgY29uc3Qg
c3RydWN0IGNvbW1vbl9maXJtd2FyZV9oZWFkZXIgKmhlYWRlciA9IE5VTEw7DQo+ICAgICAgICAg
Y29uc3Qgc3RydWN0IGdmeF9maXJtd2FyZV9oZWFkZXJfdjFfMCAqY3BfaGRyOw0KPg0KPiAtICAg
ICAgIHNucHJpbnRmKGZ3X25hbWUsIHNpemVvZihmd19uYW1lKSwgImFtZGdwdS8lc19tZWMuYmlu
IiwgY2hpcF9uYW1lKTsNCj4gKyAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmIChh
ZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BTERFQkFSQU4pKQ0KPiArICAgICAgICAgICAgICAgc25w
cmludGYoZndfbmFtZSwgc2l6ZW9mKGZ3X25hbWUpLCAiYW1kZ3B1LyVzX3NqdF9tZWMuYmluIiwg
Y2hpcF9uYW1lKTsNCj4gKyAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICBzbnByaW50Zihm
d19uYW1lLCBzaXplb2YoZndfbmFtZSksDQo+ICsgImFtZGdwdS8lc19tZWMuYmluIiwgY2hpcF9u
YW1lKTsNCj4gKw0KPiAgICAgICAgIGVyciA9IHJlcXVlc3RfZmlybXdhcmUoJmFkZXYtPmdmeC5t
ZWNfZncsIGZ3X25hbWUsIGFkZXYtPmRldik7DQo+ICAgICAgICAgaWYgKGVycikNCj4gICAgICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiBAQCAtMTUwOSw3ICsxNTE1LDExIEBAIHN0YXRpYyBpbnQN
Cj4gZ2Z4X3Y5XzBfaW5pdF9jcF9jb21wdXRlX21pY3JvY29kZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCj4NCj4NCj4gICAgICAgICBpZiAoZ2Z4X3Y5XzBfbG9hZF9tZWMyX2Z3X2Jpbl9z
dXBwb3J0KGFkZXYpKSB7DQo+IC0gICAgICAgICAgICAgICBzbnByaW50Zihmd19uYW1lLCBzaXpl
b2YoZndfbmFtZSksICJhbWRncHUvJXNfbWVjMi5iaW4iLCBjaGlwX25hbWUpOw0KPiArICAgICAg
ICAgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAoYWRldi0+YXNpY190eXBlID09
IENISVBfQUxERUJBUkFOKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc25wcmludGYoZndf
bmFtZSwgc2l6ZW9mKGZ3X25hbWUpLCAiYW1kZ3B1LyVzX3NqdF9tZWMyLmJpbiIsIGNoaXBfbmFt
ZSk7DQo+ICsgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNu
cHJpbnRmKGZ3X25hbWUsIHNpemVvZihmd19uYW1lKSwNCj4gKyAiYW1kZ3B1LyVzX21lYzIuYmlu
IiwgY2hpcF9uYW1lKTsNCj4gKw0KPiAgICAgICAgICAgICAgICAgZXJyID0gcmVxdWVzdF9maXJt
d2FyZSgmYWRldi0+Z2Z4Lm1lYzJfZncsIGZ3X25hbWUsIGFkZXYtPmRldik7DQo+ICAgICAgICAg
ICAgICAgICBpZiAoIWVycikgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBlcnIgPQ0KPiBh
bWRncHVfdWNvZGVfdmFsaWRhdGUoYWRldi0+Z2Z4Lm1lYzJfZncpOw0KPiAtLQ0KPiAyLjE3LjEN
Cj4NCg==
