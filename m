Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092F2C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 17:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5F710EA2B;
	Fri,  4 Feb 2022 17:02:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01BC010EA2B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 17:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0PeY14QoR//Lk4f7CinMZC8/KCB0JY15pg2JTcAkVeAPu2vPGCiXcZ8DTD9hnOUhLG0DqUc8pzz2jaqqJnjIgOtwtEocMQwVhqu0hsTSWeVdQbgTaNzBWYixhfkS3RWsaX/sshVY8CjYBzOoymEOlLBjrwLvc4LL5IWWYzCMrdB5Gou0yylG2oOVrwlIQDAseyi9MC+kiDDmApjEkK/Jv74yXZRhmLhZLNnGGu123IW8lcOVJDzg7pPkmxuOzyVn15QAdXe5qtqnfXdsTxkbJzYhCvkUvHh5/RzwKSiktI6kJijd5aqzCcSHkQihWoDXNIXt+23l3GzMHdeIzqLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXXf8JCuvaksORkNzYFRUhm0+1bXxjIu24UzE4JqHnQ=;
 b=JjIQGFBOCNvfUulaVODwnom/5yj7re9e22Iml01Ni2/oi5UV77JF//HfMAVBlMPP2Tn19aNii7HznqRH9qVMiu2wtHcMaQVUdCdy4hAYX35V8bODCzZ/294RSxcwKZlaeeJvoKZYYUJO2Xod90h/wW7ByRRjOaCvTrd9TmYrUA4shOjKDMTEXWqdNsiCji/oBiIxsm8XAh6hCNoNRIx3UkxVrL8+3hI7HpZuMZ6hmdIgi64O0eWSDPPwU8IC09OdqHkHGoddOaMime3UjD7z2nxkzM7lg4fZOeOVEZZjLMc+FDasIWAi8pa21yNy9CmqH36Kn1W6pCZ0Bgokdg/Xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXXf8JCuvaksORkNzYFRUhm0+1bXxjIu24UzE4JqHnQ=;
 b=x/dG/82grSuKfeIAFnwtF7WWldRUhVnetBeF4bjLW9HbIh7c+m14CMgnaHGITfVcmsuEbc0DHD+9mBo6S8B7ckEStZFQzxcP+M0uVoWM/0vtduR2Vz37HQ8mZNUSGiW07CWmkIrKulnFfNBdwxxio5ZWKpSNyBa9XfLjf/M1lRk=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.21; Fri, 4 Feb 2022 17:02:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d0d1:eba5:5729:c636%4]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 17:02:05 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Topic: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Index: AQHYDwZjidvy0bXGukSiArQ04UD9j6xumGUAgBUU44CAAAJvEIAAAz4AgAAAfDA=
Date: Fri, 4 Feb 2022 17:02:04 +0000
Message-ID: <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
In-Reply-To: <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-04T17:00:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0d6a4bfb-1c27-47c1-932e-04dcc46a39f3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-04T17:02:01Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4eb28218-bc60-48a9-874c-50d5ba31599b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e0ec886-e3cb-46da-dbe2-08d9e8001214
x-ms-traffictypediagnostic: DM5PR12MB1594:EE_
x-microsoft-antispam-prvs: <DM5PR12MB15942C56BA91DC6D74651AD897299@DM5PR12MB1594.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oh4O59m4MMlD+/hV7XOA05De/SjKS3OAPOiAWkvbFm4u1crWJ5qxRt4rObNETWZYn3rVqGDK2XJ3auZR4gSe5ffR8h59kB7v7/yuUCohAcvQCKQNFyvtA0JRh/ikB3uh/aBU5coU+4wnb3oRYW9JqiazgHGDXZcLmVYt3Nkfvu/a/RgNNb00r3lsM7LRJPPwQwQtoQmDWU+XpQ6C8Tpz0q6Pctj0w5bPlRdbNInav8P8701s5tqOI6J+EcOI3WdKhhFU3YCs+R/1dKswvNgCf7MwChEzas9bhLJdioor0NG16B7dil3EJX37IX3GEhxnT/O4arf/c6JQqi+XSmlQ+XjmsuRITAs9bky2S0b3isboLrsu72YMKa0Xm2QFTJYNwXDtLF3WOC/bVE2GFd/R1PKn/79LBXl7MVvauWLkS7AKXZqxKWDuEFjzd/VMZBX0HWOGXLa7AIuzpJ4jST1JdGWCstf2Nvoip+JPbKCaETYyrUAxM2rEAVIb1KxIoS1SbSNafxFxA/Z3dzLIPJW0T4wW2aWsHEDsl4lKrxfV4Lduk2rEUBA9d99Zi/MmVg20WglOnlLYSrZAHe6mMyeXyxWaSGpRGmJzhr0PzaenwHX/lXeNxTfeHWN9xi1rdXFoT8/3pM9XEPtVGlCMcrbjY9Dyzr4LtFmnIH09oUHWc1r2d9MVH4ZBiyOSfXIKqyfrn62VhvtYe9KW1RtmE0BL68c8daMsQSVaED0mZ0bbawaPQwwInuwqEgz2H+R6yTEkqu0QkbllJp3UcZrlyuHrR8WMf96WPiddnOiVy6dMOSg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(6506007)(66476007)(2906002)(4326008)(5660300002)(66446008)(9686003)(52536014)(53546011)(83380400001)(71200400001)(7696005)(64756008)(66946007)(76116006)(38070700005)(508600001)(110136005)(186003)(122000001)(54906003)(26005)(86362001)(8676002)(8936002)(38100700002)(55016003)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3RadUVBeHZlcjA5T1l5cndwUzU2Y1RMbU1HQWNkNGlvVDdibzJtcUd2Zzcx?=
 =?utf-8?B?ZkpnZkhERitVRUlnTDdBdUNhWGRDOGhqTWRsOTJyaDRUUG8rY3h5WTJVMmlp?=
 =?utf-8?B?TkVpZkhHM25FM25LWCtua2xLMkMxbE9IYVh5UGVkdDFpYTAvNzU3TEJWcHda?=
 =?utf-8?B?YVZEc1o4b1pBdG5qeVludEdXMzZmOHJuNTJjRVd6cUkxUTVIb2E3dWtrcjJy?=
 =?utf-8?B?bkRjOUk1OVgvL3Yxa3F3RVlES3N5Q2l6SVYwY3FxdzBtUnJYZnJLd1JnckdM?=
 =?utf-8?B?UlpwalJrMXZOSDN6dHQvSWkyc1doYm1sMnpQeDl2RHFpaUZCU0ovbkpIOUc1?=
 =?utf-8?B?YlNqWnhIUlJRa2FvK3Nnc1BPQ0JoZTU2QTRPZlJKZUs4dER4VlAyNDdaMC9P?=
 =?utf-8?B?N2I2VW9QVExUanNzSXhqT3E5LzBnRVN0YzRWMmNqaHFhR054dEVWWTdRYkFL?=
 =?utf-8?B?U0NsbFlSVHVyd3BuZW5aVWV2R3NraEYzakwra2dsNVZzWFBHK0c5S09jNHRy?=
 =?utf-8?B?TXRwY25tUnJKNFRBdWFCZUwvd1dLYW4yVTR0K2RhTFFlbFMzUjE2WGF3NU9F?=
 =?utf-8?B?RDdaak1kRFpJQS9hc3VVQzhqSDV5alBRYncyWWtqYkxpM2wyNUpUdFM3T2Rw?=
 =?utf-8?B?YWpvY2x6L1R6MnF3QnZDVjVwOHFMVHN5d0EwdlU3VFYyNmROOWpCUWovbWJT?=
 =?utf-8?B?RWZnaEpIK0ROVVY5Zkp2VEFmMzgyQkV3MTR2L2dieE4vTTZBV2JFOEdLeERC?=
 =?utf-8?B?SjBLNFZvWHhYQzVCd1lQUnVJU0w1UUpvNDNtTXpzdmpqK1FkMHRSMUNqWlha?=
 =?utf-8?B?Nm1CZnd6S1NPcnU2YnNqdFBTbTF3VE84VTNIZm0rM0pucXFtd2lmdi95L2U5?=
 =?utf-8?B?UzZFQnh5elZHWnkwTUZBNnYrVEFuV1JBMWxoUVZhM3V2aG1DS2U2eXRodjJw?=
 =?utf-8?B?UTB6ZDloQml1UUgweGpmMUlqamhibGk2UmEwM3JycXhoc3QzdGRNK0RETUVE?=
 =?utf-8?B?U3U3aUtjYWZ6VnVaWXIrSW83alRmT1NwSUpmUlZzOEpzRTQ2OFRNMExQcTdJ?=
 =?utf-8?B?ZEg3Z1h5UWNRK21pN1E3bkM1bUdsQjN0UUpGOWVWK0oyaUk0ZHc3UDRiTU9m?=
 =?utf-8?B?b0FrZlkxSjFBVHY3emhpOTJpNno3R1J5c0pEbGp4Y0V1alBiMk53RGlzVEk1?=
 =?utf-8?B?YnFvVnNVeTZmZVJScjc5U2FDckxYQ05idXg0aEZHMEYyd1NXcVdFeWVmR1k4?=
 =?utf-8?B?VnN3MkI0Nm5JV1c4MU44SkhyTXFjM0xtSFdpUHkva0RTZDMrMFV1NENmeWVE?=
 =?utf-8?B?R212amprSmFxUDA3NVF6b0I3ZUJhUHk0alhyTnZDV2ZTaW5jTzJDMkNCZVNj?=
 =?utf-8?B?aHZrRHpuNTNPdXROSW5KZG13MXlWS05UR2lxNXNRWnRhbCtuUVJKU3RxVFVy?=
 =?utf-8?B?RGlmTHVjOUowV3pXTElnOGxHR0VBVnFSbWczaEhZMWF6NGlHRHBzS05Ndm43?=
 =?utf-8?B?U3Fva2trYzE2WlFuQWZ2MldJbGh4Wk1lbUdtZGs2TWg4WUMxOHMvVGlrQlhl?=
 =?utf-8?B?OENCL2Y1OVF1MTRCMnM3cHZOODNKOW9uMzNYSGxDSWlvdDd5MGhNbmlObVkv?=
 =?utf-8?B?cWNPSnZzVmJueG1kVWdkdTUrQ3R2UVM2WHh0dWpvd0VKeTQwVWRaT3NUNFBh?=
 =?utf-8?B?Zys3Vm1nOWhuSGp6bmFWWlBlOThvd2luTk5kaVhoN3N5MU9JMTNrSWJZNWJS?=
 =?utf-8?B?Ykw5LzgzNDFicDZ4SzZkOWNaeXlxVDVRQzNDQWNNWTRJcm1PQVZOZVZsLy9y?=
 =?utf-8?B?WEtLNjJqSFB3Z05wUEo1bmg2b003WUpubThQWlJ4UVNXeXQyYjAzdENsbGhM?=
 =?utf-8?B?eHdvSWJUQjZ3a1d1NnEwR3ArRFJjQlF0WXpocVlVZnB5N0hQakxHSnB5NkMx?=
 =?utf-8?B?ZERROHJCdFMrZ09Gd2lZRWRFYUkrQWE3TWl2elpmK3FZaEN2aTM0SDg1dG9L?=
 =?utf-8?B?L2w4VkdNMkMwU0lKVnBSeE9GS3hSUWhCT0ZLdy93RlNLUjN5c1RFcWczWVE4?=
 =?utf-8?B?MlJ3YmJKWUdjRXNWbnBSZnlUbHNXM1l5RGtKM3Zkcmtsa09Dd0pwZDJmRlJT?=
 =?utf-8?Q?alJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0ec886-e3cb-46da-dbe2-08d9e8001214
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 17:02:04.9855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NH9uVPBiSm/qrVcjfs0nU5uZmrDzxpXbSnBZq+7Lc/R6yXjKtSlqrjJDE/r8Z1i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KVGhlIHByb2JsZW0gaXMgYXBwIGRvZXNuJ3Qga25vdyB3aHkgdGhlIHJlc2V0
IGhhcHBlbmVkLiBJdCBqdXN0IHJlY2VpdmVzIGEgYnVuY2ggb2YgcmVnaXN0ZXJzIHRvIGJlIHJl
YWQuIE9uIHdoYXQgYmFzaXMgYW4gYXBwIGNhbiBmaWx0ZXIgdGhpcyBvdXQ/DQoNClRoYW5rcywN
Ckxpam8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNoYXJtYSwgU2hhc2hh
bmsgPFNoYXNoYW5rLlNoYXJtYUBhbWQuY29tPiANClNlbnQ6IEZyaWRheSwgRmVicnVhcnkgNCwg
MjAyMiAxMDoyOSBQTQ0KVG86IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IFNvbWFsYXB1cmFtLCBBbWFyYW5hdGggPEFtYXJhbmF0aC5T
b21hbGFwdXJhbUBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNC80XSBkcm0vYW1kZ3B1L252OiBhZGQgbmF2
aSBHUFUgcmVzZXQgaGFuZGxlcg0KDQoNCg0KT24gMi80LzIwMjIgNTo1MCBQTSwgTGF6YXIsIExp
am8gd3JvdGU6DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+IA0KPiBUbyBleHBsYWluIG1v
cmUgLQ0KPiAJSXQncyBhbiB1bmNvbmRpdGlvbmFsIHJlc2V0IGRvbmUgYnkgdGhlIGtlcm5lbCBv
biBldmVyeSBzdXNwZW5kIChTMy9TNCkuIEluIHN1Y2ggYSBjYXNlIHdoaWNoIHByb2Nlc3MgaXMg
Z29pbmcgdG8gcmVjZWl2ZSB0aGUgdHJhY2UgZXZlbnRzPw0KPiANCj4gTW9zdCBsaWtlbHkgdXNl
IGNhc2Ugd291bGQgYmUgcmVsYXRlZCB0byBncHUgcmVjb3ZlcnkuIFRyaWdnZXJpbmcgYSB0cmFj
ZSBvbiBldmVyeSByZXNldCBkb2Vzbid0IGxvb2sgbGlrZSBhIGdvb2QgaWRlYS4NCj4NCg0KSWYg
eW91IG9ic2VydmVyIGNhcmVmdWxseSwgd2UgYXJlIGp1c3QgcHJvdmlkaW5nIGFuIGluZnJhc3Ry
dWN0dXJlLCB0aGUgYXBwbGljYXRpb24ncyBpbnRlbnRpb24gaXMgdW5rbm93biB0byB1cy4gSW4g
bXkgb3BpbmlvbiBpdCdzIHJhdGhlciBub3QgYSBnb29kIGlkZWEgdG8gYXBwbHkgYSBmaWx0ZXIg
aW4ga2VybmVsLCB3aXRoIG91ciBpbnRlcnByZXRhdGlvbiBvZiBpbnRlbnRpb24uDQoNCkZvciBl
eGFtcGxlIGlmIGFuIGFwcCBqdXN0IHdhbnRzIHRvIGNvdW50IGhvdyBtYW55IHJlc2V0cyBhcmUg
aGFwcGVuaW5nIGR1ZSB0byBTMy9TNCB0cmFuc2l0aW9uLCB0aGlzIGluZnJhIG1pZ2h0IGJlY29t
ZSB1c2VsZXNzLiBJdCB3b3VsZCByYXRoZXIgYmUgYSBiZXR0ZXIgaWRlYSBmb3IgdGhlIGFwcCB0
byBsZWFybiBhbmQgaWdub3JlIHRoZXNlIHNjZW5hcmlvcyB3aGljaCBpdCBpcyBub3QgaW50ZXJl
c3RlZCBpbi4NCg0KVGhpcyBjb3VsZCBldmVudHVhbGx5IGJlIGp1c3QgZGlmZmVyZW5jZSBpbiBk
ZXNpZ24gcGhpbG9zb3BoeSBtYXliZSA6KQ0KDQotIFNoYXNoYW5rDQoNCj4gVGhhbmtzLA0KPiBM
aWpvDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGFybWEsIFNo
YXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFy
eSA0LCAyMDIyIDEwOjA5IFBNDQo+IFRvOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFNvbWFsYXB1cmFtLCANCj4gQW1hcmFuYXRo
IDxBbWFyYW5hdGguU29tYWxhcHVyYW1AYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIA0KPiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gZHJt
L2FtZGdwdS9udjogYWRkIG5hdmkgR1BVIHJlc2V0IGhhbmRsZXINCj4gDQo+IEhleSBMaWpvLA0K
PiBJIHNvbWVob3cgbWlzc2VkIHRvIHJlc3BvbmQgb24gdGhpcyBjb21tZW50LCBwbHMgZmluZCBp
bmxpbmU6DQo+IA0KPiBSZWdhcmRzDQo+IFNoYXNoYW5rDQo+IA0KPiBPbiAxLzIyLzIwMjIgNzo0
MiBBTSwgTGF6YXIsIExpam8gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDEvMjIvMjAyMiAyOjA0IEFN
LCBTaGFybWEsIFNoYXNoYW5rIHdyb3RlOg0KPj4+ICDCoEZyb20gODk5ZWM2MDYwZWI3ZDhhM2Q0
ZDU2YWI0MzllNGU2Y2RkNzQxOTBhNCBNb24gU2VwIDE3IDAwOjAwOjAwDQo+Pj4gMjAwMQ0KPj4+
IEZyb206IFNvbWFsYXB1cmFtIEFtYXJhbmF0aCA8QW1hcmFuYXRoLlNvbWFsYXB1cmFtQGFtZC5j
b20+DQo+Pj4gRGF0ZTogRnJpLCAyMSBKYW4gMjAyMiAxNDoxOTo0MiArMDUzMA0KPj4+IFN1Ympl
Y3Q6IFtQQVRDSCA0LzRdIGRybS9hbWRncHUvbnY6IGFkZCBuYXZpIEdQVSByZXNldCBoYW5kbGVy
DQo+Pj4NCj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBHUFUgcmVzZXQgaGFuZGxlciBmb3IgTmF2aSBB
U0lDIGZhbWlseSwgd2hpY2ggDQo+Pj4gdHlwaWNhbGx5IGR1bXBzIHNvbWUgb2YgdGhlIHJlZ2lz
dGVyc2FuZCBzZW5kcyBhIHRyYWNlIGV2ZW50Lg0KPj4+DQo+Pj4gVjI6IEFjY29tb2RhdGVkIGNh
bGwgdG8gd29yayBmdW5jdGlvbiB0byBzZW5kIHVldmVudA0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogU29tYWxhcHVyYW0gQW1hcmFuYXRoIDxBbWFyYW5hdGguU29tYWxhcHVyYW1AYW1kLmNvbT4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQu
Y29tPg0KPj4+IC0tLQ0KPj4+ICDCoMKgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8
IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgwqDCoDEgZmlsZSBjaGFuZ2Vk
LCAyOCBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbnYuYyANCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMg
aW5kZXggMDFlZmRhNDM5OGU1Li5hZGEzNWQ0YzUyNDUNCj4+PiAxMDA2NDQNCj4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbnYuYw0KPj4+IEBAIC01MjgsMTAgKzUyOCwzOCBAQCBudl9hc2ljX3Jlc2V0
X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPj4+ICphZGV2KQ0KPj4+ICDCoMKgwqDCoMKg
IH0NCj4+PiAgwqDCoH0NCj4+Pg0KPj4+ICtzdGF0aWMgdm9pZCBhbWRncHVfcmVzZXRfZHVtcHMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsNCj4+PiArwqDCoMKgIGludCByID0gMCwgaTsN
Cj4+PiArDQo+Pj4gK8KgwqDCoCAvKiBvcmlnaW5hbCByYXZlbiBkb2Vzbid0IGhhdmUgZnVsbCBh
c2ljIHJlc2V0ICovDQo+Pj4gK8KgwqDCoCBpZiAoKGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVf
SVNfUkFWRU4pICYmDQo+Pj4gK8KgwqDCoMKgwqDCoMKgICEoYWRldi0+YXB1X2ZsYWdzICYgQU1E
X0FQVV9JU19SQVZFTjIpKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4gK8KgwqDC
oCBmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX2lwX2Jsb2NrczsgaSsrKSB7DQo+Pj4gK8KgwqDC
oMKgwqDCoMKgIGlmICghYWRldi0+aXBfYmxvY2tzW2ldLnN0YXR1cy52YWxpZCkNCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFh
ZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MtPnJlc2V0X3JlZ19kdW1wcykNCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgciA9
DQo+Pj4gK2FkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5jcy0+cmVzZXRfcmVnX2R1bXBz
KGFkZXYpOw0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHIpDQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgRFJNX0VSUk9SKCJyZXNldF9yZWdfZHVtcHMgb2YgSVAgYmxvY2sgPCVz
PiBmYWlsZWQgDQo+Pj4gKyVkXG4iLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MtPm5hbWUsIHIpOw0K
Pj4+ICvCoMKgwqAgfQ0KPj4+ICsNCj4+PiArwqDCoMKgIC8qIFNjaGVkdWxlIHdvcmsgdG8gc2Vu
ZCB1ZXZlbnQgKi8NCj4+PiArwqDCoMKgIGlmICghcXVldWVfd29yayhzeXN0ZW1fdW5ib3VuZF93
cSwgJmFkZXYtPmdwdV9yZXNldF93b3JrKSkNCj4+PiArwqDCoMKgwqDCoMKgwqAgRFJNX0VSUk9S
KCJmYWlsZWQgdG8gYWRkIEdQVSByZXNldCB3b3JrXG4iKTsNCj4+PiArDQo+Pj4gK8KgwqDCoCBk
dW1wX3N0YWNrKCk7DQo+Pj4gK30NCj4+PiArDQo+Pj4gIMKgwqBzdGF0aWMgaW50IG52X2FzaWNf
cmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pj4gIMKgwqB7DQo+Pj4gIMKgwqDC
oMKgwqAgaW50IHJldCA9IDA7DQo+Pj4NCj4+PiArwqDCoMKgIGFtZGdwdV9yZXNldF9kdW1wcyhh
ZGV2KTsNCj4+DQo+PiBIYWQgYSBjb21tZW50IG9uIHRoaXMgYmVmb3JlLiBOb3cgdGhlcmUgYXJl
IGRpZmZlcmVudCByZWFzb25zIChvciANCj4+IGV2ZW4gbm8gcmVhc29uIGxpa2UgYSBwcmVjYXV0
aW9uYXJ5IHJlc2V0KSB0byBwZXJmb3JtIHJlc2V0LiBBIHVzZXIgDQo+PiB3b3VsZCBiZSBpbnRl
cmVzdGVkIGluIGEgdHJhY2Ugb25seSBpZiB0aGUgcmVhc29uIGlzIHZhbGlkLg0KPj4NCj4+IFRv
IGNsYXJpZnkgb24gd2h5IGEgd29yayBzaG91bGRuJ3QgYmUgc2NoZWR1bGVkIG9uIGV2ZXJ5IHJl
c2V0LCBjaGVjayANCj4+IGhlcmUgLQ0KPj4NCj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2FtZC9hbQ0KPj4gZA0KPj4gZ3B1
L2FtZGdwdV9kcnYuYyNMMjE4OA0KPiBJbiB0aGUgZXhhbXBsZSB5b3UgcG9pbnRlZCB0bywgdGhl
eSBoYXZlIGEgY3JpdGVyaWEgdG8gZGVjaWRlIHdoYXQgaXMgYSB2YWxpZCByZXNldCBpbiB0aGVp
ciBjb250ZXh0LCBpbiB0aGUga2VybmVsIHNpZGUgaXRzZWxmLiBTbyB0aGV5IGNhbiB0YWtlIGEg
Y2FsbCBpZiB0aGV5IHdhbnQgdG8gZG8gc29tZXRoaW5nIGFib3V0IGl0IG9yIG5vdC4NCj4gDQo+
IEJ1dCwgaW4gb3VyIGNhc2UsIHdlIHdhbnQgdG8gc2VuZCB0aGUgdHJhY2VfZXZlbnQgdG8gdXNl
ciB3aXRoIHNvbWUgcmVnaXN0ZXIgdmFsdWVzIG9uIGV2ZXJ5IHJlc2V0LCBhbmQgaXQgaXMgYWN0
dWFsbHkgdXAgdG8gdGhlIHByb2ZpbGluZyBhcHAgdG8gaW50ZXJwcmV0IChhbG9uZyB3aXRoIHdo
YXQgaXQgd2FudHMgdG8gY2FsbCBhIEdQVSByZXNldCkuIFNvIEkgZG9uJ3QgdGhpbmsgdGhpcyBp
cyBjYXVzaW5nIGEgY29uc2lkZXJhYmxlIG92ZXJoZWFkLg0KPiANCj4gLSBTaGFzaGFuaw0KPj4N
Cj4+DQo+Pg0KPj4gVGhhbmtzLA0KPj4gTGlqbw0KPj4NCj4+PiAgwqDCoMKgwqDCoCBzd2l0Y2gg
KG52X2FzaWNfcmVzZXRfbWV0aG9kKGFkZXYpKSB7DQo+Pj4gIMKgwqDCoMKgwqAgY2FzZSBBTURf
UkVTRVRfTUVUSE9EX1BDSToNCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9pbmZvKGFkZXYt
PmRldiwgIlBDSSByZXNldFxuIik7DQo=
