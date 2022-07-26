Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8D7C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 09:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A197D11A282;
	Tue, 26 Jul 2022 09:41:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAB311A96D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 09:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGd4U9BlJKyX/WgsN8kIuxP1p1mflXY+WVxC8a4iUGNyzH5QBV45q+0AdlmvxDN9QIp5e3/dgnvXP5MR+LEWvBzDMSLYjXKiUgDxiMOwTqnyhSTaUHtK4WUWkOsjx2+ZyDF8uCezGzUwfH5v7ZcV7eLIVQPtz5X8ASvOy2bs3sPMdl7suQfYoJ9cn9GZwfW16kOKChVKdEDO/A2QAjpbKVnWSYQL60KteZUcCxj7LEO7lJwrXajE88SI0Sf5dK3SdGlTct4mvSSSYDgHAfNL/t+rNzehXPwb/31OjAWQXJC8B9rc05HhRVsBhK+58cn8/fdli2Yy+V2bD8RMqaLBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9mqnJUBrB1xbnyS0nst2tF+GiZzI9jz5Kz4wq96NXY=;
 b=haUQFGP7pjiF/FHrQbgEwQiyCAelMT7ooUTPP4MOTJK2eyGe4n30nVVijRSC6SRKOxDgt85va0dhF5MRaBOmVA1cPOoxGbITbcX0JNVTxo1hgoZalJddk9nqpx9NNRJg7shr6qYmVgtB7YgskWkXlcALRgFa93mu1PMQ9crOygpKZpAtwMEVCvUyyscC36L3cgLX6WiF4lNQjmrYb3hJLtjzui+x+/m3eXvH+I16adjWXN7uYe8bn0Vpx/PNfPTBGUJvHrVde9c4Kqj7vMvtgqUljsa09fhxqlIepYuCA8ohmsIcrFDlOEs0A1Q+XgIn8MpvVIzgfgj2NCqF4fa1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9mqnJUBrB1xbnyS0nst2tF+GiZzI9jz5Kz4wq96NXY=;
 b=xFcBDiIg3BD7ElQpqgsm5Rln/Rbu394MFnfJOxOfK8DUK5S3+M2gKSYvuwshcN3va9WDnWhSHaivQbA2nxpUM9Kci+SaqE+Jfv1ebHJgkj16DAzPpGC8zC6AzLjXr3Don88zFTIut8HMzGsSiAZ5ZtTEuF0Qy2dW3z0QzaqXQJI=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.24; Tue, 26 Jul 2022 09:40:57 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::e4db:dd4e:4fe1:d32c]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::e4db:dd4e:4fe1:d32c%9]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 09:40:57 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: reduce reset time
Thread-Topic: [PATCH 5/5] drm/amdgpu: reduce reset time
Thread-Index: AQHYnZ2WdyUDm2zW20eX9wk5d+2HWK2PnLmAgADJkWA=
Date: Tue, 26 Jul 2022 09:40:57 +0000
Message-ID: <DM6PR12MB4340889B38A77BBCC4E0486CFA949@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-5-Victor.Zhao@amd.com>
 <85e76646-4b14-2d33-8143-0fe0095afa25@amd.com>
In-Reply-To: <85e76646-4b14-2d33-8143-0fe0095afa25@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-26T09:19:09Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b4d143a2-5114-44c3-833c-69d709d282bf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-26T09:40:55Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9f22b3b8-6736-490b-953a-745e92386132
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8994b82b-57cf-46f4-f263-08da6eeaf14e
x-ms-traffictypediagnostic: DM4PR12MB6349:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/VheCCqZPbk8prUAw+sVEleYoyZ/7BRjH1BYI3gxA4Rq3aDnB4HXfNvt3UyHBUUQMJakJ+Vtkj+kFCoS1QDSiU/DkePKfMR4wlsBae8MwMQcTwcbK2p3Tm5GEFOqI8ZqJ6iQSTOEp44M5LAnos8AZwKAxroAfhBeB254JCstxlWN/nZxlvInRL8I0HRtx54KGUc/n6dC9mMOX1OeLCWpPDvGJLrx//8i3o3NjT/yKYcY/f9KItmkLSIcE64tpiLmjDt+ZtPsi4Si6vxKGnXQj7Cdk5tE4XR5k2GsmRh9IDIecFyb865nGngNX5HSIXTN4YDbVa+d9ovc/uJzfmXaIsZAjVBsCv300qQzAU1eB1qNV1DdurmTI9/PHItVKac1Cyt1ejfQlFGa1A6C9tuOxTTfcu815pB5IgI+4+VrCNZnCHGIbvP0xix6OsBVhJoG3VdfdneNurGFCAyg2JRC08EuivSpkLp0DAlez8Q6GSNzAP8Y1+RCvwkOYD8mi0gOPbZpqhNsz+yhDHlP/8VnLEHS6hxjKJKerxg4YY4yinrdzTFREDD17BNZHrUhTxdDC6HbDzR3uDEK257sQpoJ6FhFHCJKfWEkrlh7BNs8/EurVxMPa3iEglhncmivbJ3aUpKAzlZ/APnEHmA06efURwTwUqc8kYT6ISuakC/jff+QgGSqkqd9SXm7DzF/C+J6SgyM0vAYahbi2n0fKfogd/M7en/9s76ESXZRdX3lTfIcPiGZc1KAZeif3HAjFN/F4p8EcI6Z6UWnbIqgQ1bacu2OA9YcWjvkeyUYOfLM/2ONWdZH9nd+wE8FEoNFL6a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(33656002)(26005)(71200400001)(52536014)(86362001)(186003)(38070700005)(83380400001)(122000001)(2906002)(38100700002)(9686003)(53546011)(478600001)(6506007)(110136005)(54906003)(41300700001)(5660300002)(8936002)(76116006)(8676002)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(4326008)(7696005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0xpcVJUUFlsZ2FVam1TU3VhajVTbTFGOWVMVjFKVWNTa0kvTkNVckpoQ0FT?=
 =?utf-8?B?eGFVK1Fub0VRdTYrQ2xRUXJmMXZZd2xnRERwWEtQOVR4TUhLM1ppMVBhenNV?=
 =?utf-8?B?cWZQeE83ak53bVRIc3pWUFJJS1RKV2NFTTFHZVoxV0gxaVRaL1pjWjlEYmJM?=
 =?utf-8?B?VWdrQlU2aVlJVG14UFhscXVtblEzNGs1NXZzVUJ4SFR4Y1JTVFp4SGRIK05s?=
 =?utf-8?B?UXFiQUx0U1N4Si81RWNNTk1NQk9HTVc1VTMzaC9TNE9IRWIwVWNzU0pOUTQ2?=
 =?utf-8?B?aHpKZFJhYjNhTmpoUXdGeDRzNXc5RDhKcVZsQnJIeWhhU0JENmF4aWRIcXJO?=
 =?utf-8?B?MkNBYjZYSmYxTXdwb0laSmx2RUhha2V1cGRZRXdFWWdEYWZuRGRRZ1p6NVVT?=
 =?utf-8?B?ZUI2WkFEU0hlQldUWVhveTdGaHFrZFVtdER6ZjNSV1JtVUdxNEFNSW9tRTRn?=
 =?utf-8?B?cHFwNDczaWUzTDdJKzNkaWpMczh3U2d2aG5pbStnbm9SVlBDdU1IKzJ6UkFS?=
 =?utf-8?B?dUk5N3U3dzFrdVBGQ2dHL2dUSVpramowYU9aYndya0R1VHBUbU52ckFMUjZ6?=
 =?utf-8?B?VUFZYkJUb3NoT3JCdER5S1ZGUkVkWGVOVHdkeUV4dHU5SDUwcXJUVmlrbWNW?=
 =?utf-8?B?azhZMlphSVd6bTlicndiQk44TWNzNFV4K2d2RUJ3R0lYeHJaS0xXd1hYUmNt?=
 =?utf-8?B?K1dlcWwrNUhtM1BxVDk1R0Z4bkhUa1RTanpLRVRqR202dTUwWm1MTzJMNEZo?=
 =?utf-8?B?Q1BsSDNjVVN6a251MWJGWmpDLzlyZnY1TVM0Z3dwSzlQM0JJQVJCdnpKRlJz?=
 =?utf-8?B?OGduRWNiUlJseDNtRFVEbGs2L3VVMFlXOGFGcm1hOTlmdHFGQzBrR2NmeVNF?=
 =?utf-8?B?WkZZenhpQzlGZmsyRGNpY3p5RHNZYURReVVKdGZvQmdyREZycS9RazQwakJn?=
 =?utf-8?B?MmNSRnY3VjFPOVptOEcyYXFqQ2x1NE1oMEhsbTk2c3N2elEraEF3dWRzb0pk?=
 =?utf-8?B?cTRQNmlDUXZNajhScEZoV2c5N25vcmduS1dHbUs4UVI0UGNkL0F0S2YyR3ZL?=
 =?utf-8?B?eW1yZS9YZWRCMkJiaEpGYzlQQ1RsQ3QyU0ZiTDlQb3lFL0lkR25oaFg2OTRH?=
 =?utf-8?B?eGk5T2dPZ25PVUo4Z3lzZE1SN2F1ejdmeDJSVjN1VWtGdFF2SHZyUDUrQkZY?=
 =?utf-8?B?TThuVzduSVM4TWZHMGJCLzVaRlNJeFg5dU1zZVJoUjlvVk10ek9EbEFuOFd4?=
 =?utf-8?B?cklBU0FsWnEybjZ1aTFNbnBUWDlYSGNTc005SkRzSlZ5ODQyTXdIQWZidFRW?=
 =?utf-8?B?Q2tkTUpNOUdUMy9WUmk1TW5MNkJnalFOcU83akRtNGdaVWJ2TnhidS9EWmtN?=
 =?utf-8?B?ZG1YYjZLSnNPazFFbE0vck1oS1FBRGVwczVVRytpeVEwZk8yU1VoL2tRNVpB?=
 =?utf-8?B?UlkzY3E4SU9PcUEwc2sxZC94cW9TTm8zYS9WdzQ5S0o3OFo5dVNRRVB6Nk10?=
 =?utf-8?B?b2tHVitWSVNBUEhIZWRaQ2FQV09rWE03L0xtMXUrYlJZb2RVRmw1NTNmWVpT?=
 =?utf-8?B?N2U5NEFXU2Vub3Zxbk5JWFBTQ29uUmF0cTRWSi9mMUpkMDhoVGlkeGdWQzZm?=
 =?utf-8?B?b0syYUsvdm5KSEJ3dWppRERxR0VxclFzak8zTjZ2Ukd0ZEhGQ3plOVh1bVp1?=
 =?utf-8?B?cy9lc05HbDRja1dCdlZOcmRwWHVHWkZQMzVjWFRkRytyWUk4SnNVMU9XTHNo?=
 =?utf-8?B?aHVNdkNHRzJXdFBvZFBXbTFkR2QxYzMyOTNuSUNzL2tKNHUvRHNGWEpmMkdQ?=
 =?utf-8?B?R1BjdjVhVHZDVFI5YnQzdnhnU1l6YXl6Y1dnbG5IVDZJK01XRERWZzM4Mndt?=
 =?utf-8?B?cnlLY2t2RTVIb0x4N21qbGNpTDNLaFNKTyt5SVpCR3VEMlRESlhqczdLb3Z2?=
 =?utf-8?B?TGg3RTFVYnQ4Nlo1eHBsVXkrTkZITHArdDFxbWVWMFFVbW0wSmdMbG9ndUh5?=
 =?utf-8?B?TjF5MDdGTngwOUxkTnErUUVpQjZXL0VGV2VBb29JZVRlN1pnbmdpR1VOaHRq?=
 =?utf-8?B?WWZjTVpqeUhQdWNKQU9lb1I5UzhNNEdJU1NXUGZTdFlVaE1kYmVLSTQxRnNI?=
 =?utf-8?Q?X2QA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8994b82b-57cf-46f4-f263-08da6eeaf14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 09:40:57.5607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iHIjJJkNpvr2xF8dJU2iqthveGnamvqo4eHL7+d/ySUarRekqasSe0xiqnt6eaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFuZHJleSwNCg0KUmVwbHkg
aW5saW5lLg0KDQoNClRoYW5rcywNClZpY3Rvcg0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNv
bT4gDQpTZW50OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIyIDU6MTggQU0NClRvOiBaaGFvLCBWaWN0
b3IgPFZpY3Rvci5aaGFvQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IERlbmcs
IEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCA1LzVdIGRybS9hbWRncHU6IHJl
ZHVjZSByZXNldCB0aW1lDQoNCg0KT24gMjAyMi0wNy0yMiAwMzozNCwgVmljdG9yIFpoYW8gd3Jv
dGU6DQo+IEluIG11bHRpIGNvbnRhaW5lciB1c2UgY2FzZSwgcmVzZXQgdGltZSBpcyBpbXBvcnRh
bnQsIHNvIHNraXAgcmluZyANCj4gdGVzdHMgYW5kIGNwIGhhbHQgd2FpdCBkdXJpbmcgaXAgc3Vz
cGVuZGluZyBmb3IgcmVzZXQgYXMgdGhleSBhcmUgDQo+IGdvaW5nIHRvIGZhaWwgYW5kIGNvc3Qg
bW9yZSB0aW1lIG9uIHJlc2V0DQoNCg0KV2h5IGFyZSB0aGV5IGZhaWxpbmcgaW4gdGhpcyBjYXNl
ID8gU2tpcHBpbmcgcmluZyB0ZXN0cyBpcyBub3QgdGhlIGJlc3QgaWRlYSBhcyB5b3UgbG9vc2Ug
aW1wb3J0YW50IGluZGljYXRvciBvZiBzeXN0ZW0ncyBzYW5pdHkuIElzIHRoZXJlIGFueSB3YXkg
dG8gbWFrZSB0aGVtIHdvcmsgPw0KDQpbVmljdG9yXTogSSd2ZSBzZWVuIGdmeCByaW5nIHRlc3Qg
ZmFpbCBldmVyeSB0aW1lIGFmdGVyIGEgZ2Z4IGVuZ2luZSBoYW5nLiBJIHRob3VnaHQgaXQgc2hv
dWxkIGJlIGV4cGVjdGVkIGFzIGdmeCBpcyBpbiBhIGJhZCBzdGF0ZS4gRG8geW91IGtub3cgdGhl
IHJlYXNvbiB3ZSBoYXZlIHJpbmcgdGVzdHMgYmVmb3JlIHJlc2V0PyBBcyB3ZSBhcmUgZ29pbmcg
dG8gcmVzZXQgdGhlIGFzaWMgYW55d2F5Lg0KQW5vdGhlciBhcHByb2FjaCBjb3VsZCBiZSB0byBt
YWtlIHRoZSBza2lwIG1vZGUyIG9ubHkgb3IgcmVkdWNlIHRoZSB3YWl0IHRpbWUgaGVyZS4NCg0K
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFZpY3RvciBaaGFvIDxWaWN0b3IuWmhhb0BhbWQuY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgfCAgMiAr
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jICB8IDI2ICsrKysr
KysrKysrKysrKy0tLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dmeC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZnguYw0KPiBpbmRleCAyMjJkM2Q3ZWEwNzYuLmY4NzI0OTVjY2MzYSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiBAQCAtNDc3LDcgKzQ3Nyw3
IEBAIGludCBhbWRncHVfZ2Z4X2Rpc2FibGVfa2NxKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQ0KPiAgIAkJa2lxLT5wbWYtPmtpcV91bm1hcF9xdWV1ZXMoa2lxX3JpbmcsICZhZGV2LT5nZngu
Y29tcHV0ZV9yaW5nW2ldLA0KPiAgIAkJCQkJICAgUkVTRVRfUVVFVUVTLCAwLCAwKTsNCj4gICAN
Cj4gLQlpZiAoYWRldi0+Z2Z4LmtpcS5yaW5nLnNjaGVkLnJlYWR5KQ0KPiArCWlmIChhZGV2LT5n
Zngua2lxLnJpbmcuc2NoZWQucmVhZHkgJiYgIWFtZGdwdV9pbl9yZXNldChhZGV2KSkNCj4gICAJ
CXIgPSBhbWRncHVfcmluZ190ZXN0X2hlbHBlcihraXFfcmluZyk7DQo+ICAgCXNwaW5fdW5sb2Nr
KCZhZGV2LT5nZngua2lxLnJpbmdfbG9jayk7DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjEwXzAuYw0KPiBpbmRleCBmYWZiYWQzY2YwOGQuLjlhZTI5MDIzZTM4ZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gQEAgLTU5NzEs
MTYgKzU5NzEsMTkgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfY3BfZ2Z4X2VuYWJsZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpDQo+ICAgCQlXUkVHMzJfU09DMTUoR0Ms
IDAsIG1tQ1BfTUVfQ05UTCwgdG1wKTsNCj4gICAJfQ0KPiAgIA0KPiAtCWZvciAoaSA9IDA7IGkg
PCBhZGV2LT51c2VjX3RpbWVvdXQ7IGkrKykgew0KPiAtCQlpZiAoUlJFRzMyX1NPQzE1KEdDLCAw
LCBtbUNQX1NUQVQpID09IDApDQo+IC0JCQlicmVhazsNCj4gLQkJdWRlbGF5KDEpOw0KPiAtCX0N
Cj4gLQ0KPiAtCWlmIChpID49IGFkZXYtPnVzZWNfdGltZW91dCkNCj4gLQkJRFJNX0VSUk9SKCJm
YWlsZWQgdG8gJXMgY3AgZ2Z4XG4iLCBlbmFibGUgPyAidW5oYWx0IiA6ICJoYWx0Iik7DQo+ICsJ
aWYgKCFhbWRncHVfaW5fcmVzZXQoYWRldikpIHsNCj4gKwkJZm9yIChpID0gMDsgaSA8IGFkZXYt
PnVzZWNfdGltZW91dDsgaSsrKSB7DQo+ICsJCQlpZiAoUlJFRzMyX1NPQzE1KEdDLCAwLCBtbUNQ
X1NUQVQpID09IDApDQo+ICsJCQkJYnJlYWs7DQo+ICsJCQl1ZGVsYXkoMSk7DQo+ICsJCX0NCj4g
ICANCj4gKwkJaWYgKGkgPj0gYWRldi0+dXNlY190aW1lb3V0KQ0KPiArCQkJRFJNX0VSUk9SKCJm
YWlsZWQgdG8gJXMgY3AgZ2Z4XG4iLA0KPiArCQkJCSAgZW5hYmxlID8gInVuaGFsdCIgOiAiaGFs
dCIpOw0KPiArCX0NCj4gICAJcmV0dXJuIDA7DQo+ICsNCj4gICB9DQoNCg0KVGhpcyBjaGFuZ2Ug
aGFzIGltcGFjdCBiZXlvbmQgY29udGFpbmVyIGNhc2Ugbm8gPyBXZSBoYWQgbm8gaXNzdWUgd2l0
aCB0aGlzIGNvZGUgZHVyaW5nIHJlZ3VsYXIgcmVzZXQgY2FzZXMgc28gd2h5IHdlIHdvdWxkIGdp
dmUgdXAgb24gdGhpcyBjb2RlIHdoaWNoIGNvbmZpcm1zIENQIGlzIGlkbGUgPyBXaGF0IGlzIHRo
ZSBzaWRlIGVmZmVjdCBvZiBza2lwcGluZyB0aGlzIGR1cmluZyBhbGwgR1BVIHJlc2V0cyA/DQoN
CkFuZHJleQ0KDQpbVmljdG9yXTogSSBzZWUgImZhaWxlZCB0byBoYWx0IGNwIGdmeCIgd2l0aCBy
ZWd1bGFyIHJlc2V0IGNhc2VzIGFzIHdlbGwgd2hlbiBkb2luZyBhIGdmeCBoYW5nIHRlc3QgdXNp
bmcgcXVhcmsuIEkgaGF2ZW4ndCBzZWVuIGEgc2lkZSBlZmZlY3Qgd2l0aCBNb2RlMSByZXNldCB5
ZXQgYnV0IG1heWJlIHNob3J0ZW4gdGhlIHdhaXQgdGltZSBjb3VsZCBiZSBiZXR0ZXI/DQoNCj4g
ICANCj4gICBzdGF0aWMgaW50IGdmeF92MTBfMF9jcF9nZnhfbG9hZF9wZnBfbWljcm9jb2RlKHN0
cnVjdCBhbWRncHVfZGV2aWNlIA0KPiAqYWRldikgQEAgLTc1NjksOCArNzU3MiwxMCBAQCBzdGF0
aWMgaW50IGdmeF92MTBfMF9raXFfZGlzYWJsZV9rZ3Eoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQo+ICAgCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2dmeF9yaW5nczsgaSsrKQ0K
PiAgIAkJa2lxLT5wbWYtPmtpcV91bm1hcF9xdWV1ZXMoa2lxX3JpbmcsICZhZGV2LT5nZnguZ2Z4
X3JpbmdbaV0sDQo+ICAgCQkJCQkgICBQUkVFTVBUX1FVRVVFUywgMCwgMCk7DQo+IC0NCj4gLQly
ZXR1cm4gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIoa2lxX3JpbmcpOw0KPiArCWlmICghYW1kZ3B1
X2luX3Jlc2V0KGFkZXYpKQ0KPiArCQlyZXR1cm4gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIoa2lx
X3JpbmcpOw0KPiArCWVsc2UNCj4gKwkJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgICNlbmRpZg0KPiAg
IA0KPiBAQCAtNzYxMCw2ICs3NjE1LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfaHdfZmluaSh2
b2lkICpoYW5kbGUpDQo+ICAgDQo+ICAgCQlyZXR1cm4gMDsNCj4gICAJfQ0KPiArDQo+ICAgCWdm
eF92MTBfMF9jcF9lbmFibGUoYWRldiwgZmFsc2UpOw0KPiAgIAlnZnhfdjEwXzBfZW5hYmxlX2d1
aV9pZGxlX2ludGVycnVwdChhZGV2LCBmYWxzZSk7DQo+ICAgDQo=
