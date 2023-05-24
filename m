Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84780C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 09:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2329C10E5C3;
	Wed, 24 May 2023 09:20:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C4F910E5C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 09:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbHwuKIBnI99RKO4Vna0AIS7M6CstEbzO6MG/0nk1AsATThDTGZN9Br713PnEUhBO7isePpBf4aGInvrwuvDztOyZx6lsjCku+I5eatKJOzqVFhyQ53IDXfdVI5xFhQ89aRy9zw0y0TT3nM6//Iozm82biQy2FnqmjRFngpp4SN5IHxAmEJtr9zfl8pzGejcrm/emcqY0BPTYjWr4+TrCQMEvUpkglmzFbJTfCjMR8rUOinLzBBzmy6QDz/JNQk3uW2AJa1YWoddlVu+480Dn7mGuNjsR5Ey2nLg9KCP9vGtRxQUCDSKMOBO12bzIZNvCbOGrawbq4JjYOjNLyo1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1nCpAssMStxRWpS+D/plE18iU6jUTvA9j4kK4zcxUY=;
 b=hKfFxMAv6XUcYH+z69r3nIgNa8w2NQmzreryKexsRVDJCVRpruwrqsa9BnOSXRD4MJVREdXxYq6G9gJHmKs3IA2KglzdQmz6UbUvwrfE6I48tc9Dx/h1Sd1FeUmTDSQ4UPffeZIznwrg2kJ61tNmI8fFdXLYd2K/58isH+8UMKu7TFwmjlIABvM8UagiVqYMF/49N8niLDu3hIhHDpIAxmn+lyIA/Rqhx/XJofe4RGfCFHd+yFQ62wmn81ZgIyXSVkLLmqqjp8NH8PMB06dmLhSsrrVAIbXSeNnJ1ji1j0plTUQYg3bNTfYXN/4cU8oQGRxYMXS7kTO7WpKPnfFSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1nCpAssMStxRWpS+D/plE18iU6jUTvA9j4kK4zcxUY=;
 b=tp5LQ7Z4C4wc6FPMslkxwTHqDf764N5kIb6lzqAT1XhnJl8OX+nSPfSLeTllBCL9b5UzBUWhkuudL0F3sFsK15KAcaTMWeoVX+dcp9KnLizrs3O6ocmBLcIQkJhxVmVGic1+25Bp97ISswUfrgZIT7lVXcPqRw6egl+nKjeImII=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 09:20:00 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 09:20:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Remove unused static functions
 si_set_temperature_range.
Thread-Topic: [PATCH] drm/amd/pm: Remove unused static functions
 si_set_temperature_range.
Thread-Index: AQHZjh5drX0jGNXiYU2lWMH/dYpTbq9pJVCg
Date: Wed, 24 May 2023 09:20:00 +0000
Message-ID: <DM5PR12MB2469203CDD63BEB97560B200F1419@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230524090125.3098744-1-yifan1.zhang@amd.com>
In-Reply-To: <20230524090125.3098744-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8aba21bf-69d8-4f52-8b39-cb427208c323;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-24T09:19:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|BN9PR12MB5179:EE_
x-ms-office365-filtering-correlation-id: ba00032b-6239-47eb-ec07-08db5c380cb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AV4Lv8EosJOkU1CoSJR3FMWqpu3uSbkP4JWuTM5qMeJ2dvmIiowXJSyBTUXU7W5UpdQlCc8nhueReld4rBW+61xRj7UMYAYemAkqFCf8oYA2jGB3brzwZctZRBNotW5kO8c+zffZJ8imY2ybKCLDvH3eO/EUiFd3bbybKxfFehtp5/zOTVQbJ1MNZzfT9aCxRruZBBftrybMc+yjL99jXG1CXiAUhVajBOyyORRyOaJMfMmjXtbW/TaD75EvwPzvDuO6sLMyP7AWLt/UN8SzP16W27iPO+I03SYIIm8vKturPib9XI5aUYQxRnCNysfnXBKMhGMzSfaOaALdNsmAjO3/8ELDwyHy69LSKNv+uxbmvXPuWpR5zLff6pBZ3Omh2zZIHem5EMdDMr1KcQ9UCg5Icnsy7pPkkvYP72SmUfn1e/07QgpM1IGziaBQecjnmoUE93/iKNSA0XJwefunyzr1r1XXn1gqWZl8u86MtCqXmbDEbXi1vdUlLfjJfZTxg+s+wd43sVb8vHa8uuCSE+GyYbWrrteWmAAF7hi8c3XibXrwF5PySMRiWqMOXGWOnRj8hUIBE/jR9fYBSC/ERaRMQTHdyif4D4Y79EimYcleyEXvUttnHDnpxOyuABaN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(186003)(122000001)(33656002)(9686003)(26005)(6506007)(38100700002)(55016003)(83380400001)(53546011)(2906002)(76116006)(54906003)(7696005)(71200400001)(316002)(41300700001)(66446008)(110136005)(478600001)(86362001)(4326008)(66476007)(64756008)(66946007)(66556008)(38070700005)(8676002)(8936002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzZ2dlBpNTlxVmh1WTVzNUlObCtDckVGVG5PTkVlOXNvSCtRTTVPZHdybkJz?=
 =?utf-8?B?Z2U1S3hHVytIQmFiSDYwUjd1b0hmVklYanJsUFE4WjFJcWVNVlZyQkYrdjFa?=
 =?utf-8?B?dStWcEVVSzJJdHJxZm5SVFM0ZG1WRmJhNGJ3K0hpWXFOSDh3ZHExMndIUkxH?=
 =?utf-8?B?T2RnelhIQkU3RlpRRzJFZ0h1dExneWhJY2dHQ2lCNldNQktwWjkwMHBjMysw?=
 =?utf-8?B?UjQ3NGVkMFc3ZElLc0pDd1hscDZzbUFHNEJqeWxURHBtSXhYM09QYkJHTXVm?=
 =?utf-8?B?TUVuaWR2akx6aXVHZC9MdTdaSFp1bXpjRUdjSEdrUllobVBUS0VmT1dTMUY0?=
 =?utf-8?B?UFhFd0xhWXl0K1VxQVlVUmd6SExxWjBuOUNYYjZwZFBNRWQ0WnNNd3dOeVBO?=
 =?utf-8?B?MG1oeDNiYVcxUzRORmNEa2xrQXNxMTRBK1VNYUljbFNlSnZNY2ZiSy9SaW53?=
 =?utf-8?B?SVNzZnF2Q1JVQ3A0V0l6SmUrdnNwY2dYbG1yTndGZnB0S3pDUkRRbHBleHZ5?=
 =?utf-8?B?RGloU1VzT0RYN3RWY3ZkQUN0NVRyWnIwc1F0WmJwd1pXUys1bnRrTnBDS1pn?=
 =?utf-8?B?OHVUbnVibnhwOWpNd08ySWpUMWxWRlphUnVqc28wSkwxWCtSY0JpVG9wdnd3?=
 =?utf-8?B?WmxaM3lGOGNzTVBwT2c1QU4wK0lObEoxSWFzWUZvQklLSzc4WThyMTlNclhh?=
 =?utf-8?B?YUpHblE3Qng2bjArSGV2RzNOZ1BJY3JPYklkWXorSjRuVmIzYVRJN0JoazVw?=
 =?utf-8?B?MWtGNWlkcEE2UGwzUDFXMTEyNExmU0lwVWRnQitXRW9WWUhQWi8wejlJZWlE?=
 =?utf-8?B?eVZHZFJuZ0R6TTAzTUg3amQ1ZDFkZ0V0TGFzdmk2YmFzVVdEb2F0WGYrTUJt?=
 =?utf-8?B?bTlyUVd3eDl6ak1TU0lRNzBHTDZQVTZEUzUzVzVHMUNDUm42VXlSVDBGcVcr?=
 =?utf-8?B?SDBLMjdUaDk4NzJtRVpBRHFHZVo5SGprSi95eXZNR2hFUWFSR0tqY2dVQ0Ix?=
 =?utf-8?B?WUZPUGRnZlB1eVhBcHVTZEFZNGVLTnZRckdzcHJZZ0FIbFA5N20wajB5azRp?=
 =?utf-8?B?RXZkM2dya3hEQ1RRNkdCd1VsTlI2QXFpeTVTd0kybXRQVVZjTk1QY0g0eFY2?=
 =?utf-8?B?ZG1EOUY2KzF6RFJTa29CY3RWNkFXaXpiUm1qM2pCVGNraHFweVBxUlVOWkpk?=
 =?utf-8?B?cjVpQ0IwMWJWQnA0am9FS1J2VVFYa2NtRklSclhNNTgzZnhBWTBNeFg1OXRO?=
 =?utf-8?B?QUtLK2h3a3o5cVpCaFBVRi9tNlVoZTZCZTEzRzNsSVd6YTE2UGd0TTYvdEY0?=
 =?utf-8?B?b1NrZFBqOXNzUWh3bnQ5RTZKeDdKQ1huRm1MdDZIQ3h6TDRoTVlwYzFTeG9U?=
 =?utf-8?B?Nk1GK2pJREh1NlhMSVp3S3ltWkdPVW1MUHEvQzUrRWp2OE1ya25IK1h5cGlp?=
 =?utf-8?B?MmpKNWJ4QXlTVG8ySWpaeHQwOVQxcEM1KzMzd0taMFRNL2FRd2N3V2EyeXpl?=
 =?utf-8?B?QU8zelRZNW1VUjY1aVQrTC95TmZiV0xSYnJjcXpCVVZ3YmljOWU5aTdLTHEv?=
 =?utf-8?B?MVFsbmtDRkZwaU9LOG9wT2x2N0VTRlhjM0I2SlVLTjMyVm91OFI5dGxFdDdJ?=
 =?utf-8?B?QVA3c0JiY20yR0w2WGk1SVp4T3JsMXM4RGdZTjlsYnhwdW5OREZ2b0hPNGFs?=
 =?utf-8?B?NkZHdVdiaDlZSGY1ZHBZS0xvaUQxV2twSm9hMU9JSEc3eDRqek1EU1htV2dK?=
 =?utf-8?B?OGdZbnpOQnBlcWVkMGt4WURucmc2T09yZGxENWVTMS9FMVRhTERRa2ZsZmt2?=
 =?utf-8?B?R3d3QjlKd0Z6MUJ5WTRNRjdFM2pTZnBkSTd1NDNVZi9GcmllSGpTUkxCdW1D?=
 =?utf-8?B?dzFyMnJqYVI2Nm5hT0cxRkRzbTEzYkFqSksrNWErZDFGTytSK0tZOStCdnhF?=
 =?utf-8?B?SU11VS94UncxMjZlYVN0eGQwckZHQS9ubzYyaUFrdnRFRWtTMFA2UTNXMUxh?=
 =?utf-8?B?MGZEdWtaTlphNHRyRmN3OWxBZElrZzVnS2J3UmYrdzhHTnFVdmVWT01ZdElj?=
 =?utf-8?B?YUVtbVFHSE5laXBBcFZXVnRqeTkxaUNBUTRjV1pBWWprMUVmNUU4V1IzU3Z1?=
 =?utf-8?Q?hqpM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba00032b-6239-47eb-ec07-08db5c380cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 09:20:00.3892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5BdjgQXmV7L2Nwl8Dxlxgvotg6mVimjzsGRDl/YPlQ6F1TlZzN+eDF3VdapYpqb2dn97qW+nARg7tpB6Ly3RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "lizhenneng@kylinos.cn" <lizhenneng@kylinos.cn>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KVGhhbmtzIGZvciB5b3VyIHByb21wdCBwYXRjaCBmb3IgdGhpcy4NCg0KUmV2
aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpSZWdhcmRzLA0K
R3VjaHVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmcsIFlp
ZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjQsIDIw
MjMgNTowMSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENoZW4sIEd1Y2h1
bg0KPiA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IGxpemhlbm5lbmdAa3lsaW5vcy5jbjsgWmhhbmcs
IFlpZmFuDQo+IDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0v
YW1kL3BtOiBSZW1vdmUgdW51c2VkIHN0YXRpYyBmdW5jdGlvbnMNCj4gc2lfc2V0X3RlbXBlcmF0
dXJlX3JhbmdlLg0KPg0KPiBGaXggY29tcGlsaW5nIHdhcm5pbmdzOg0KPiAgIENDIFtNXQ0KPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291
cmNlLm8NCj4gICBDQyBbTV0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9kY24yMC9kY24yMF9od3NlcS5vDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L3BtL2xlZ2FjeS1kcG0vc2lfZHBtLmM6NjkyODoxMjoNCj4gd2FybmluZzog4oCYc2lfc2V0X3Rl
bXBlcmF0dXJlX3Jhbmdl4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC0NCj4gZnVu
Y3Rpb25dDQo+ICA2OTI4IHwgc3RhdGljIGludCBzaV9zZXRfdGVtcGVyYXR1cmVfcmFuZ2Uoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4gICBDQyBbTV0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9kY24zMC9kY24zMF9od3NlcS5vDQo+ICAgQ0MgW01dDQo+IGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5j
ZXINCj4gLm8NCj4gICBDQyBbTV0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3Aubw0KPg0KPiBGaXhlczogZGE0NDlmM2ZlZjNiICgi
ZHJtL2FtZC9wbTogcmVzb2x2ZSByZWJvb3QgZXhjZXB0aW9uIGZvciBzaSBvbGFuZCIpDQo+IFNp
Z25lZC1vZmYtYnk6IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2xlZ2FjeS1kcG0vc2lfZHBtLmMgfCAxNyAtLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5jDQo+IGluZGV4IGNhOWJj
ZTg5NWRiZS4uMDJlNjljY2ZmM2JhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL2xlZ2FjeS1kcG0vc2lfZHBtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9s
ZWdhY3ktZHBtL3NpX2RwbS5jDQo+IEBAIC02OTI1LDIzICs2OTI1LDYgQEAgc3RhdGljIGludCBz
aV9kcG1fZW5hYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2KQ0KPiAgICAgICByZXR1
cm4gMDsNCj4gIH0NCj4NCj4gLXN0YXRpYyBpbnQgc2lfc2V0X3RlbXBlcmF0dXJlX3JhbmdlKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAtew0KPiAtICAgICBpbnQgcmV0Ow0KPiAtDQo+IC0g
ICAgIHJldCA9IHNpX3RoZXJtYWxfZW5hYmxlX2FsZXJ0KGFkZXYsIGZhbHNlKTsNCj4gLSAgICAg
aWYgKHJldCkNCj4gLSAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAtICAgICByZXQgPSBzaV90
aGVybWFsX3NldF90ZW1wZXJhdHVyZV9yYW5nZShhZGV2LA0KPiBSNjAwX1RFTVBfUkFOR0VfTUlO
LCBSNjAwX1RFTVBfUkFOR0VfTUFYKTsNCj4gLSAgICAgaWYgKHJldCkNCj4gLSAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiAtICAgICByZXQgPSBzaV90aGVybWFsX2VuYWJsZV9hbGVydChhZGV2
LCB0cnVlKTsNCj4gLSAgICAgaWYgKHJldCkNCj4gLSAgICAgICAgICAgICByZXR1cm4gcmV0Ow0K
PiAtDQo+IC0gICAgIHJldHVybiByZXQ7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyB2b2lkIHNpX2Rw
bV9kaXNhYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KPiAgICAgICBzdHJ1Y3Qg
cnY3eHhfcG93ZXJfaW5mbyAqcGkgPSBydjc3MF9nZXRfcGkoYWRldik7DQo+IC0tDQo+IDIuMzcu
Mw0KDQo=
