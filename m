Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD9AC6FD1C
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 02:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5AE010E457;
	Mon, 13 Mar 2023 02:04:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9292810E457
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 02:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjz1fiXybk/hQaHHZ0jcFDkhtmHMnXpH/nXIUXZML9aZpuDeJyOncpkQDIdTzRS5ZvAIppz4CXSlYMuUnYmVWk/zXMhe/WZgZgiDJSf9yF+c1+cj8BfuND+Wdy6fna+EwqJNk3/HO21WwoHVqJgaQUkpDW8/OLBA+QVfWkwuRUDY9LjWlN7itLjVzLAHBkLAkJQiZG3iV+OHu/m8o2DhypxScMqTMeiLCwRHZIB9oS6RXzWMyAZauQUKgu8yLZtwFW0JUUlh6mr0LtU8ZCB7MSTwOGuoXKz2vVjf9pcUfE2nkRDPwNHjua5y02sB8NLhrXx2Mi2TTtyfRUzvfWJXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMiaxT/3OoMrBNyIGBxYaJ4JqWyYasCqSNww+K9QPjQ=;
 b=XOZTOV21FBL027DNjr9glpJG+8GKucqzEcKEkTT0zA4BI5NL/FKJD1qudDB4o0ldh2fOmpAEKDcHgY8/6RJLPrxK6qDrFdMt8LZmcAFM5Ob4vOWIvMaBGcsNUFx9tW8dyIh2BKkA/MWrjvyKVNJmMmzv8MvhmnQgXXv88wmQWO8XN7HiIfWK1ZqfDHtPtiWYgiM9KxPehojbw2CyR98dINQ9VfK3nz43XxY6Az6a6/oBAzJO8RbQiW4bMD8Zx/hTcoP3pxmQnSZb8irnsAC9CiSdDmOU0LJJbY3NqF9ngtRQSmduIU2FOC+xVWyw6gToy5N3VP79iX8QVQm9X5Ny9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMiaxT/3OoMrBNyIGBxYaJ4JqWyYasCqSNww+K9QPjQ=;
 b=3hwY7W7SgNxxN/2Mij3NphMToGlViWbJXFOd8Z6ZYGz6ubM59RB+ioNhLx4vJ75FuaSFfdk7FrE96JiautK3xQiIKNLCfYSgAvemRqItEn0mrY59xi9rlIpky9d+7VuYLtqCp2MyWgN1Lc4YpdR4Lx8gSAkky6ScA+I0nA/Ddyg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Mon, 13 Mar 2023 02:04:26 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 02:04:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: =?utf-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resove reboot exception for si oland
Thread-Topic: [PATCH] drm/amdgpu: resove reboot exception for si oland
Thread-Index: AQHZUyayYDVcB0qNSkOAgOVEzBYkza7zqzhggAQ+IwCAAAc/cA==
Date: Mon, 13 Mar 2023 02:04:25 +0000
Message-ID: <DM5PR12MB246978C0E16C0AC0F626F965F1B99@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230310074000.2078124-1-lizhenneng@kylinos.cn>
 <DM5PR12MB2469FEB1E81CA99C51E7DAF0F1BA9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <ff8eb2c4-c567-2765-effb-d26d55b32af7@kylinos.cn>
In-Reply-To: <ff8eb2c4-c567-2765-effb-d26d55b32af7@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4155:EE_
x-ms-office365-filtering-correlation-id: 8ba76dc6-1867-4c4b-4c54-08db2367457e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: etZQ4tlEAQTdrg+xEMKrEIemUzHlsAGT3sXDcai0b3d4sv7nqSrus4OT8lcrTNE22xBdfMdd1GYRmo8cL//+VR4HbK71xAL04UAzRJRpGgPXDY8ZglJOU5tAzd0QkRHFSw+tvCWdcmWTum8JvWKJ1IC/LbwdsyeQxEqT4TTPvApZ8DeVARuwxUfAi1CCNrTIJ2Q0RcG4dlRkOFDuBAQLliPg7lsXyXFFo4n70sDSMyLJMo0e40DFcX1wRYWalyQCG8nEDQ9QBwBqtnOHtBWj8seSwIjbUpaHbgjhftjVvZ9To6spBBeso/hilEbi16yXwDujaGua2uyrTBY1HQ8SUsqGqqanSF9Ow2pCQ1Pcw9hfcMFD0gSWqdE8qI4JLXXlGZ9rhvXyIEy/w2f21OQWp+PVRqd1v6Zfim3bd8xWEszhB2jOwJj7qjZIJcV1M5qdWXdUPi33Czdmh/RozFGpL9LgdxCfmhuE4n3ve8CJkj8Up0g2cyc+WRhRwSXg9Yy7snEQy1GdmUtnVfE+C0F+t6IL+YqNcc5z3B9nfvdf9smSKX3EabYaZzqvdiUXBx9URZaXlrYZsp4rlTlT39BGp67t+hB+e1w9FZU9jIO9DhfW3kMRgqhYjaiG+hyGB+1nyvWDki3dM0zfAANSNotn8rfjaNUVsOBXdsC3/bS8fGQUt4CDRMiVv1E/EtfBsdsn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199018)(966005)(2906002)(83380400001)(7696005)(26005)(6506007)(9686003)(5660300002)(53546011)(55016003)(33656002)(52536014)(8936002)(186003)(71200400001)(8676002)(86362001)(41300700001)(38070700005)(4326008)(66446008)(66556008)(76116006)(64756008)(66946007)(66476007)(478600001)(122000001)(110136005)(38100700002)(316002)(6636002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDc1SWI3a1A1UG1WbzBFUG5VcHl2MGdzMkxPQWtEaElXdTFrRnc5Y21pZ09B?=
 =?utf-8?B?Z2l2Qng0VzU4MVpVZWdXLzJIMkYxZ2JTbnVzazVpRmQrdWk1eDg3ZGFrWTlS?=
 =?utf-8?B?UnJ3YVBPTW9WbCtFa3cwU2s1Vm42YUNWeVlkSDJVYnA0Wjd3Q1NzS2NIajBw?=
 =?utf-8?B?U1VQRC9IbnNaaVd6dnVLMUNKTitBSDFCZ2FRellaMjJsTmd0bFpLOFhSMDhs?=
 =?utf-8?B?RGh3ZkFXS0tuY0x6VFRmV3d2elk0WUJ2dUpKL0FJYndnUlU3MDJhSHd6OENo?=
 =?utf-8?B?Vit1SS9EZC9zWkVsamUwVjg2UE90MGhUc1ZCb3U1Q3ZFQW5xWk5Ja0ZURGV2?=
 =?utf-8?B?SEsrS015UGlpL1dsOVpqNzlkR05NT1Nqdk40bjV5eFAxaUFnb3I0WkpHcytV?=
 =?utf-8?B?dHVnOW5NT0pUZUVNZ01QYWJuRDVzQjhmWkNsZktPQXVDN0FmVUFIZThKSUI1?=
 =?utf-8?B?UTRFVmJwQ01uOGhkK0NPK2dNdDRNaWJKR01qakQ0N2dBd1IxUGNQc1FWNnB0?=
 =?utf-8?B?Qm5KeUNUaVlaSE5oSTN5YlF0U3hyemphZnVmMzBvQjFmM2MzUDBiUkNjcFZ5?=
 =?utf-8?B?MVdBK1ZxSnNyS2tvSXkwK0JObFFBRCt3Y1NUelArUjdieWFGbFBUb0lpclFX?=
 =?utf-8?B?NzVLYlJkQnQvSzNSWVdRUVlyUEpGcCtxVW5VNGxHOXNzekduS2poZWcrNXpu?=
 =?utf-8?B?WnNqZU1BT1dGNWpRV0FlejRDdzJvUG4rL1BsbFE5N3hPK201aFhnS2dCQVIy?=
 =?utf-8?B?R0J2NlVBby81eEwxOEwwY3dqTVJYTU8wZDBVdlRMNlFPYVN4cEx5MUZjdzVz?=
 =?utf-8?B?TVd1cFVKMmxlbDFYYlRGa0V6WWU2L3NYd2Z6dWRKS2cwWFhydEswMG1WTXNT?=
 =?utf-8?B?ZVRlMjdhLy9TTm1JeCtxTm92MXZxOThXNHo2N2hRbWpLZ2Ztb3g1eWExcUI2?=
 =?utf-8?B?WGxKOFJiUFlheXI1SUsyYzRBczNpVEFqUTIzVk03cmJwZGQxZCtFdFFJVGdt?=
 =?utf-8?B?OG8wV1AzKzNFUUZSWGlkaTl1OGFjTTZycXVDRDBwS0x2dkJ5SzBWWEFabDJM?=
 =?utf-8?B?cGlFb0d1dGtNK2V6eTlpUWZ4L1hjMVpOSGNDdjFESTY3UHFmelV1NGNDck5z?=
 =?utf-8?B?VVlKNHJacUVuOXhSKzRVVEpxeENHY0o4NlZKMTJ5RWxTQ1VBaWpueVFUZ1pv?=
 =?utf-8?B?bXdtZGtkbkVrbFE4Ri9SaVVrc1hybjAwcHhwUXRoZ0VXNTFvMlJkRjR2blVl?=
 =?utf-8?B?UlRlZTlBZndwWkFCckhTa0xDYi9ZTzB6cFgrdkpQZHBGcnBzaUNJZUZDSysz?=
 =?utf-8?B?aTdvM3BPRGdveUNvbmNwU3pTZU5Sd2d3WFRiZzRwdm8zNUNlNk1lSjNFYngv?=
 =?utf-8?B?a0t6dVdGZTZ6QmlYWit4NEp1a1l4dmZmM3o0S29IKzJvNFpwbkF1Q1dLTXJN?=
 =?utf-8?B?dWZMQlhvY3NEK2NRMXVINmduUUtpWmFCU1VFQ29DZTBqUnQ4SEZxTFVCSUhu?=
 =?utf-8?B?bFhVV1ppQlFJa3J5WTNwbWp2dmgxcHI0VEtTZVF6SFdlQnRwL05ZTEEvNzcz?=
 =?utf-8?B?TEVxK3A2bkNLZEhCZ0tKNzNUc2h6MkFoekI1NlhIdUdEWUhNY1hkdklmWDJo?=
 =?utf-8?B?dW9ZYmpBVy9meWhCcmxFRE83QnU3ZURqdU9ubHZzbHZSVHNNSHRUWFRJT0Qy?=
 =?utf-8?B?TGczTkJiSHFOMTFiMmRMYUI2eDl2Nk1WZXlRaTIyMFRhTFVRbEpoNkhVRWJw?=
 =?utf-8?B?SEI5QU40T1VVdUsvVGI5Qjk4VlhKbUhPb084aElOWXM3Z2l4bHY5RVZCRUhF?=
 =?utf-8?B?S1U0Z28xM0laYlh2cEp0bm9LNWVsZUV0VXpETjNTR1FyOTFRUDErRWpBOWxE?=
 =?utf-8?B?dFBnZllIY1JkQWlKNHYxYThhdElscVZYU2xmWFpwRUJpaGxZdkdTdzJMdFdt?=
 =?utf-8?B?azNMUzk3bEkvODlFTFFVcFVxWjFKY0l2aVlpRlpRb2V1NEhBK2IwU1VXVlds?=
 =?utf-8?B?MWNQZlRLeHBOOVRLSHo0dWQwcGNxcGJLTVpWa0QyU3poZ2hsYnBOYjRNZUt6?=
 =?utf-8?B?bmpwdE0xWXRoTnh2d2tmN2EyMjh2RXpmeXZVS0VaVHc5N0R3S2s4aWlUaTR5?=
 =?utf-8?Q?l6b3nycvVsNmYT+mnsroOw2Zb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba76dc6-1867-4c4b-4c54-08db2367457e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 02:04:25.7409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVqfXnmlPZcuIxSunSn9ZYeMKqMX9fbxU4CBC7Dv8+NDoGRNs0fRAzhFq1f9nBTX9LElYOvlQKx2PFr0KaFnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIGZvciBzaGFyaW5nIHByZXZpb3VzIGNvbnRleHQgb24gdGhpcy4gDQoNCkJ5IGEgZnVy
dGhlciBjb2RlIGNoZWNrLCBJIGZvdW5kIHNvbWV0aGluZyBpbnRlcmVzdGluZyBpbiBzaV9kcG1f
bGF0ZV9pbml0IHRoYXQgd2h5IHRoZXJlIGlzIGFuIGVhcmx5IHJldHVybiB3aGVuIGRwbV9lbmFi
bGVkIGhhcyBiZWVuIHRydWUuDQpUaGUgc2VxdWVuY2UgdG8gZW5hYmxlIHRlbXBlcmF0dXJlIHJh
bmdlIGluIGJvb3QgaXM6DQoxLiBJbiBJUCBod19pbml0KHNpX2RwbV9od19pbml0KSBhaGVhZCBv
ZiBsYXRlX2luaXQsIHNldCB0ZW1wZXJhdHVyZSByYW5nZSBhcyBwYXJ0IG9mIHNpX3RoZXJtYWxf
c3RhcnRfdGhlcm1hbF9jb250cm9sbGVyDQoyLiBzZXQgYWRldi0+cG0uZHBtX2VuYWJsZWQgdG8g
dHJ1ZSB1bmNvbmRpdGlvbmFsbHkgaW4gc2lfZHBtX2h3X2luaXQNCjMuIEluIHNpX2RwbV9sYXRl
X2luaXQsIHRlbXBlcmF0ZSByYW5nZSBzZXR0aW5nIGlzIHN0aWxsIGV4ZWN1dGVkIGFzIHdlIHB1
dCBhIGNoZWNrICJpZiAoIWFkZXYtPnBtLmRwbV9lbmFibGVkKSByZXR1cm4gMCIuIExvb2tzIHdl
IHNob3VsZCBza2lwIGl0IHdoZW4gZHBtIGluY2x1ZGluZyB0ZW1wZXJhdHVyZSByYW5nZSBoYXMg
YmVlbiBzZXQgYWxyZWFkeS4NCg0KU28gSSBndWVzcyB0aGUgcmFuZG9tIGZhaWx1cmUgaW4gZW5h
YmxpbmcvZGlzYWJsaW5nIHRoZXJtYWwgYWxlcnQgaXMgcG9zc2libHkgYnkgYW1kZ3B1IGRyaXZl
ciBkb2VzIG5vdCBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIHdoZW4gc2V0dGluZyB0ZW1wZXJhdHVy
ZSBpbiBod19pbml0IHBoYXNlLCBGVyByYW5kb21seSBoYXMgbm90IGZpbmlzaGVkIHRoZSBwcm9j
ZXNzIHlldCwgd2hpbGUgaW1tZWRpYXRlbHksIGRyaXZlciBpc3N1ZXMgYW5vdGhlciBzYW1lIHNl
dHRpbmcgY3ljbGUgdG8gRlcsIGFuZCBGVyBjb21wbGFpbnMvcmV0dXJucyBhbiBlcnJvciBjb2Rl
IHRvIGRyaXZlci4gVGhpcyBtYXkgZXhwbGFpbiB3aHkgYSBkZWxheSBjYW4gd29yayBpbiBzdWNo
IGNhc2UuIE9yIEkgYW0gdW5kZXJzdGFuZGluZyB0aGlzIHdyb25nbHkgZHVlIHRvIG15IGxpbWl0
YXRpb24/DQoNCkhpIFpoZW5uZW5nLA0KDQpBZGRpdGlvbmFsbHksIGNhbiB5b3UgcGxlYXNlIHRy
eSB0byBtb2RpZnkgdGhlIGNoZWNrIHRvIHJldHVybiBlYXJseSBpbiBzaV9kcG1fbGF0ZV9pbml0
IHdoZW4gYWRldi0+cG0uZHBtX2VuYWJsZWQgaXMgdHJ1ZT8NCg0KW0Fsc28gSSBkcm9wcGVkIHNv
bWUgcHVibGljIG1haWwgbGlzdHMgYXMgbG9va3Mgc3VjaCBpc3N1ZSBpcyBhbWRncHUgZHJpdmVy
IHNwZWNpZmljXTopDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog5p2O
55yf6IO9IDxsaXpoZW5uZW5nQGt5bGlub3MuY24+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTMs
IDIwMjMgOTowNSBBTQ0KPiBUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsg
RGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzog
RGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5A
YW1kLmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTog
cmVzb3ZlIHJlYm9vdCBleGNlcHRpb24gZm9yIHNpIG9sYW5kDQo+IA0KPiBUaGlzIGJ1ZyBpcyBm
aXJzdCByZXBvcnRlZCBoZXJlOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8x
YTYyMGU3Yy01YjcxLTNkMTYtMDAxYS0NCj4gMGQ3OWIyOTJhY2E3QGFtZC5jb20vDQo+IA0KPiBJ
IG1vZGlmeSB0aGUgcGF0Y2ggYWNjcm9kaW5nIG1haWwgbGlzdCdzIGRpc2N1c3N0aW9uLMKgwqAg
YW5kIEkgZG8gcmVib290IHRlc3QgZm9yDQo+IHRlbnMgb2YgdGhvdXNhbmRzIG9mIHRpbWVzIGFi
b3V0IDEwIG1hY2hpbmVzIG9uIGFybTY0LMKgIHRoZXJlJ3Mgbm8gYnVnDQo+IHJlcG9ydGVkLg0K
PiANCj4g5ZyoIDIwMjMvMy8xMCAxNjoxOCwgQ2hlbiwgR3VjaHVuIOWGmemBkzoNCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+ID4+IFpoZW5uZW5nIExp
DQo+ID4+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTAsIDIwMjMgMzo0MCBQTQ0KPiA+PiBUbzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiA+PiBDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPjsgUGFuLCBYaW5odWkNCj4gPj4gPFhpbmh1aS5Q
YW5AYW1kLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoZW5uZW5nIExpIDxsaXpoZW5uZW5nQGt5bGlub3Mu
Y24+Ow0KPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPjsNCj4gPj4gS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXNvdmUgcmVi
b290IGV4Y2VwdGlvbiBmb3Igc2kgb2xhbmQNCj4gPj4NCj4gPj4gRHVyaW5nIHJlYm9vdCB0ZXN0
IG9uIGFybTY0IHBsYXRmb3JtLCBpdCBtYXkgZmFpbHVyZSBvbiBib290Lg0KPiA+Pg0KPiA+PiBU
aGUgZXJyb3IgbWVzc2FnZSBhcmUgYXMgZm9sbG93czoNCj4gPj4gWyAgICA2Ljk5NjM5NV1bIDdd
IFsgIFQyOTVdIFtkcm06YW1kZ3B1X2RldmljZV9pcF9sYXRlX2luaXQgW2FtZGdwdV1dDQo+ID4+
ICpFUlJPUioNCj4gPj4gCQkJICAgIGxhdGVfaW5pdCBvZiBJUCBibG9jayA8c2lfZHBtPiBmYWls
ZWQgLTIyDQo+ID4+IFsgICAgNy4wMDY5MTldWyA3XSBbICBUMjk1XSBhbWRncHUgMDAwMDowNDow
MC4wOg0KPiBhbWRncHVfZGV2aWNlX2lwX2xhdGVfaW5pdA0KPiA+PiBmYWlsZWQNCj4gPj4gWyAg
ICA3LjAxNDIyNF1bIDddIFsgIFQyOTVdIGFtZGdwdSAwMDAwOjA0OjAwLjA6IEZhdGFsIGVycm9y
IGR1cmluZyBHUFUgaW5pdA0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L2xlZ2FjeS1kcG0vc2lfZHBtLmMgfCAzIC0tLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGRl
bGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9sZWdhY3ktZHBtL3NpX2RwbS5jDQo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdh
Y3ktZHBtL3NpX2RwbS5jDQo+ID4+IGluZGV4IGQ2ZDllM2IxYjJjMC4uZGVlNTFjNzU3YWMwIDEw
MDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2xlZ2FjeS1kcG0vc2lfZHBt
LmMNCj4gPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5j
DQo+ID4+IEBAIC03NjMyLDkgKzc2MzIsNiBAQCBzdGF0aWMgaW50IHNpX2RwbV9sYXRlX2luaXQo
dm9pZCAqaGFuZGxlKQ0KPiA+PiAgIAlpZiAoIWFkZXYtPnBtLmRwbV9lbmFibGVkKQ0KPiA+PiAg
IAkJcmV0dXJuIDA7DQo+ID4+DQo+ID4+IC0JcmV0ID0gc2lfc2V0X3RlbXBlcmF0dXJlX3Jhbmdl
KGFkZXYpOw0KPiA+PiAtCWlmIChyZXQpDQo+ID4+IC0JCXJldHVybiByZXQ7DQo+ID4gc2lfc2V0
X3RlbXBlcmF0dXJlX3JhbmdlIHNob3VsZCBiZSBwbGF0Zm9ybSBhZ25vc3RpYy4gQ2FuIHlvdSBw
bGVhc2UNCj4gZWxhYm9yYXRlIG1vcmU/DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IEd1Y2h1bg0K
PiA+DQo+ID4+ICAgI2lmIDAgLy9UT0RPID8NCj4gPj4gICAJc2lfZHBtX3Bvd2VyZ2F0ZV91dmQo
YWRldiwgdHJ1ZSk7DQo+ID4+ICAgI2VuZGlmDQo+ID4+IC0tDQo+ID4+IDIuMjUuMQ0K
