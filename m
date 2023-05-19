Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388A3C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 06:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BA210E5CF;
	Fri, 19 May 2023 06:46:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743FE10E5CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 06:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScHYaQOsItKY6pP80xNWA/mgPnvlYS22jzY/vATtjefduldwFdsqNT1vYr8Y/RSzMd4GtOHhXcreSu48v2ixZWIoqBRB0EjPwkq6VTi9BoNgwPsjBZ/1oi1syleHhzHWARQOtTBRA6R2zzccMPC6CITobgmEPCPDhSaEnFbACAz1yRP865b/1mbCSl5XW5CkUYLRZ52fUB2aZCwEdvuaabtFd7gOeIY/u95Jirc6Tf+6iXxzL/myMGef+G2cwtcH21UHkrC0CRIm/aUFvxdF5CGZsnL8Qlhl4kcWDJdgwUwFTJuhRgJctGO9x4/qUjTM77i41HTFovsITmIl5i3tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N+t8txmr1X/+m8psRFqO4nf12WVlq6Ret6RZU4TjsM=;
 b=CbDb2OMKhwxnMQRSJsvEWtirk1GKCOQrStu2EwNTmvaDXagQIkVmD+seWsAX4rU2tbnxZp/LiB1VMTPBh/DltjPfLHR8Ds7BVDKQMatZ3rl9kmjZNaf9NdF7hndkyxXzr6Q26fdv4vh3RXfM84arqp7pad3oLJFUR9qCzEDnW2WT5ExMHRfILt4umymHQcu914d3htl4xjC58nRdF89h1XWetrKPCJfzT7GGLldXF3IJbUifWqijJk+TawEHKl1/zo2yFhrcUqB3f756wbdZoPVoN8jKrEsfbGyJ5+RVUWFckXam7BN6+UDp2ic2ebKb1tUpXOgJ0y0WWeDOq7/8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N+t8txmr1X/+m8psRFqO4nf12WVlq6Ret6RZU4TjsM=;
 b=4bQk4J1WUSTrlF/170hLuiPp3d6woblKhy91zD1ss4EUuKI/fSGyQtzyEMWWcev7NwoEr+1QUwoHuPDRTHWvQ65HdSwJpAHKnzGYnX30zDFo3IzEySl852HelFhXEjjgQZeNZVG5F2KO74Zcpx0bcj8STUFMCay4MrmvHDBrFtk=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 06:46:40 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 06:46:39 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix uninitialized variable in
 gfx_v9_4_3_cp_resume
Thread-Topic: [PATCH v2] drm/amdgpu: Fix uninitialized variable in
 gfx_v9_4_3_cp_resume
Thread-Index: AQHZihnrAhGQ3sblIkmprhQuQQxxJK9hJwdQ
Date: Fri, 19 May 2023 06:46:39 +0000
Message-ID: <BYAPR12MB4614062AB5A349E0C17C2917977C9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230519061931.162582-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230519061931.162582-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T06:46:36Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7a40d9b6-5cfa-475e-b33e-3b322972058a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-19T06:46:36Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 04164c9f-508b-44a0-8290-840951411818
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|DM4PR12MB6303:EE_
x-ms-office365-filtering-correlation-id: 3e6cda2b-21d8-43fb-bc81-08db5834cc3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQ8nSVSYjfeV7CE7ojCwQjDfMmf91kjxByEfttijUEA2VPY3RYx3iCdj3D0J4QgfOcgDcio1cWVJ1nrsYCuY5D8+3PQ2cQBbpfUBD5po+qws+O5nDHlHwSmNoZAVuiDS2L5ch7+i4R5HH/8uYejhS81qc0w5Gd46xWYNIU+pXz4d56iR0Y/TAu/WkdN7ASFPl5zwidviygJbOqxMquf6liVRl2tYBH17xjqrqEWuerJIE0u37mlGDoM7QU6U1AE2pVBvKzu5MYDLG3qQjm2h/0gI5clmqJd1dvkTWo5G7C4Wtizi1WOr9cPo/ZROZ/cqmfnKE/qN5w8pMtFIDAnAEzPYkXO/wol3dq30+cE1YiZ+JEhKO8dn0rcO0TnwYDXsEHDSEqna0UU82lRAKeW1imI7X+LDk+aEfJQNGeAjK3PzbtYAWJ3qXEmOEhH1zoc2cJLRmG9EdOjuXZjXWGPF17X+H5V+Yo8PRMyHnzQrI3VK/sgLcBwG3Kcz4IYNyFFxBf8mlPvBqWnDL+9Rw2FWViqD+FA79h+T1vVZjQwQyEfVu1v17OWDKoEslZeWzNX3CkjgS7O/TR02gdUMiY6xg2CDJKOf2X7OApJ+6kpxdocSpKA/EOfhBbyrQ7y0+JoU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(26005)(55236004)(9686003)(53546011)(186003)(2906002)(6506007)(86362001)(38070700005)(33656002)(122000001)(38100700002)(66574015)(83380400001)(55016003)(110136005)(41300700001)(7696005)(8936002)(8676002)(478600001)(71200400001)(316002)(6636002)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnpxeE0zNks1VTJCVU0zdUQvaU5VTHNwUE10QmZRdmxyOFZOOXVFb0ZoWVNU?=
 =?utf-8?B?ajNhWDNMNXk0Wk5GUExZMEVqOHFDTnhTVWFRbFJENlQwM0p2aWN4WjBhMkRa?=
 =?utf-8?B?TW1MVlFEVzVFK2pzZVIrMmxrMzd0TUY4U1NYYVdEazROaHQraXZodEVMaDll?=
 =?utf-8?B?b2toWEJ6c1FwV0puSU50TVBxM3hvcDdkUkI3NTBhQ21RaEpBbnZuNjdzRElB?=
 =?utf-8?B?ak42cXcycFBobDBMQkZCWElzQzdUOGZ3OUlIcmlmT0hHY2ZtbFNFLzhFWkdS?=
 =?utf-8?B?MG5tVnNZZGlOaCtLME5LKytTdWw3SXhJbUtqTlN2b1JTZUN6VytXREtiMGhm?=
 =?utf-8?B?Y096UWxReDJPcEZFT1V4Tjh5eFZXZjVPK1AxdEZQM2M4OE9JcTFBbS9CK2J0?=
 =?utf-8?B?a0hpbldLNm1xRG9YVWZab2NBVW50MVNuWGRTV2Y5WnJPVDJGU3FaT1NTVWhv?=
 =?utf-8?B?aDJjdURrQVFoY0o4cGVSSjVDVlRTa1cwYS9BTXBBYmZ3UUtDaWpaQVBGSkZX?=
 =?utf-8?B?eE9jOEdCazZoUmRxWU9aZHhtQUJweUVPZVBMQnlJT1o3UFFDbktPeGdWTDNJ?=
 =?utf-8?B?eWljZ2NCYkgwYW5PZDBUa2oxN1ZuQXlMTkg2ODRwZmVZYndhamxPOE10aG9S?=
 =?utf-8?B?T1ZPV2tzWGI0dUhWL24xa1F5ZzVnZ1ZKUUtrdjRGZkJ4WU5KU2s3b3lXeVk3?=
 =?utf-8?B?VE0zS3h6UzV1TlhIc0tVY3VvNWNneUxYM0lQdGtOWUViN3gyNG5iVDJ3VTR1?=
 =?utf-8?B?TkowMnpKODB4K0s3YmpCMG5MaU5GYXhwZWlQbzQ2RkQwMTZsZlgrQmRkWTJi?=
 =?utf-8?B?bW1VUEk5UXluL0dXdTlVMlpSQXU2N3VnWnMwbGtUUllLOTBtMTRrWXl2ZGla?=
 =?utf-8?B?V2twWVdPMkpCRnNvTXdJdTg4YnVkVGZBQXkzcUE1cDN1MnNXOHdBQWVBZ2Fx?=
 =?utf-8?B?UXBieW9vZGJ5R2c2R3hSWU4zaFoxQStsYktXVXYrT2dOZnpDWVVPdXIvem9i?=
 =?utf-8?B?NFRGdDVwSjVNZWgwajZkZzZjUmxJeGU5TVNXczVPWWtOVDIwNmVmckF1bm9G?=
 =?utf-8?B?NmNOYzhhYkdCS3g5VmJNLzRXVzBjcnZLUGlaSnJmTUZSaEJMY296SjFkb3V0?=
 =?utf-8?B?UWd2YnNIYVdvdUJoRDhtd2d5M3VvK0ZNemJWa1lSMGRWKzVkU0s5MGlNdFlz?=
 =?utf-8?B?aUp0RDNZN1VGRXdSNnJSNjV6citvQzY4a0JCNGI5eXBJZnNKZURzd0VLS0tx?=
 =?utf-8?B?Vm8rWDUycVU3VFpKMzdySUpoUElNMzZLV1JjTTRuZitTUWdYQTNUV3p4Nm1p?=
 =?utf-8?B?eVE3NXIxa1F5MUNDbmhLY3NMSGVZNytHd1NDZE82d2EyWUZ5VWVZWDVnVzBU?=
 =?utf-8?B?dURBOFY4d0YvSkFkTDUxcmh3V3dMd2hDNE4wRmg4S0phYllyN3JXTUdRNGNj?=
 =?utf-8?B?OVNRZjh6aGdHeE1UVVVSWm1EN0ZSbXFNdUhlV2VsRUhVZkVmQVNEbGVYcmN6?=
 =?utf-8?B?UGp3VlN0K1Y1MjMyeks1UWliaEdkOTVJZ1ArYXBCaWtyRml2QjRHK0JMeVV0?=
 =?utf-8?B?YUlidTBkdkUrUTFqVnR0QlY4SHZYVzBTNmtWN0F6dlhTSDJmUXpRZm9TcVY5?=
 =?utf-8?B?WnRLWG1IQjk5dEZwMjBUZ1ZmeWVNSmdFQUJRZWwyazJDRlJWWms5QWE5MmR6?=
 =?utf-8?B?UWxXQisrd2ZPb3puQzlkYnpIWVY3VTlHN2NqUUUxTFhZa0JOQk5IaHNjSlUz?=
 =?utf-8?B?MG51WFcyUGM0K2V6QklNYXZWVWxlbjlIeEZUM04zRHhSQ1hPNVV6ZlRkTE1R?=
 =?utf-8?B?YlBLVytBZ2VSWnJSOHRxNDIydHY2M2dPaTJDbUxldnV0eW93aUNzZlhHcWF4?=
 =?utf-8?B?Zm9DYlZ2TjV4OXRtNEF0bDd6Zjl5TTF2bURvWVpndWk4ZXMzNjB1MkdmblRS?=
 =?utf-8?B?S1FkajJqQXErVEJrd3I3Y2hJNlpqUU80WlR2VVkwdGZsQk5mRmFYalRMZ01k?=
 =?utf-8?B?ZERRclo0ZzRvR2NIb1kzWUpuYmdQclB0ZFg4dFdFNEo2RCs4bmtCa25hZkpQ?=
 =?utf-8?B?WVJmamI0SVJhSkVxbDV3Q0pXNlBwMDgxVXN1MGk5QnJvNFlKR1plaCtFSSt2?=
 =?utf-8?Q?oeW8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6cda2b-21d8-43fb-bc81-08db5834cc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:46:39.0775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyXcXjIcYD3N6OrhyuW74yMW/2AGWwmWsDplpb13t5/0glD7vueD8rFxb5U6yLLU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBMaWpvIExh
emFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQoNClRoYW5rcywNCkxpam8NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5T
SEFOTVVHQU1AYW1kLmNvbT4gDQpTZW50OiBGcmlkYXksIE1heSAxOSwgMjAyMyAxMTo1MCBBTQ0K
VG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxM
dWJlbi5UdWlrb3ZAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8
U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2Ft
ZGdwdTogRml4IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUgaW4gZ2Z4X3Y5XzRfM19jcF9yZXN1bWUN
Cg0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMy5jOjE5MjU6NjogZXJyb3I6
IHZhcmlhYmxlICdyJyBpcyB1c2VkIHVuaW5pdGlhbGl6ZWQgd2hlbmV2ZXIgJ2lmJyBjb25kaXRp
b24gaXMgZmFsc2UgWy1XZXJyb3IsLVdzb21ldGltZXMtdW5pbml0aWFsaXplZF0NCiAgICAgICAg
aWYgKGFtZGdwdV94Y3BfcXVlcnlfcGFydGl0aW9uX21vZGUoYWRldi0+eGNwX21nciwNCiAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCmRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYzoxOTMxOjY6IG5vdGU6IHVuaW5p
dGlhbGl6ZWQgdXNlIG9jY3VycyBoZXJlDQogICAgICAgIGlmIChyKQ0KICAgICAgICAgICAgXg0K
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzRfMy5jOjE5MjU6Mjogbm90ZTogcmVt
b3ZlIHRoZSAnaWYnIGlmIGl0cyBjb25kaXRpb24gaXMgYWx3YXlzIHRydWUNCiAgICAgICAgaWYg
KGFtZGdwdV94Y3BfcXVlcnlfcGFydGl0aW9uX21vZGUoYWRldi0+eGNwX21nciwNCiAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCmRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYzoxOTIzOjc6IG5vdGU6IGluaXRpYWxp
emUgdGhlIHZhcmlhYmxlICdyJyB0byBzaWxlbmNlIHRoaXMgd2FybmluZw0KICAgICAgICBpbnQg
ciwgaSwgbnVtX3hjYzsNCiAgICAgICAgICAgICBeDQogICAgICAgICAgICAgID0gMA0KMSBlcnJv
ciBnZW5lcmF0ZWQuDQoNClN1Z2dlc3RlZC1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQu
Y29tPg0KQ2M6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+DQpDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hh
bm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0tDQoNCnYyOg0KICAtIGlu
aXQgciA9IDAgKExpam8pDQoNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8z
LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMNCmluZGV4IGU1Y2ZiM2Fk
YjNiMy4uNmExYTI4ZGY2MDZjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzRfMy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
NF8zLmMNCkBAIC0xOTIwLDcgKzE5MjAsNyBAQCBzdGF0aWMgaW50IGdmeF92OV80XzNfeGNjX2Nw
X3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IHhjY19pZCkNCiANCiBzdGF0
aWMgaW50IGdmeF92OV80XzNfY3BfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAg
ew0KLQlpbnQgciwgaSwgbnVtX3hjYzsNCisJaW50IHIgPSAwLCBpLCBudW1feGNjOw0KIA0KIAlp
ZiAoYW1kZ3B1X3hjcF9xdWVyeV9wYXJ0aXRpb25fbW9kZShhZGV2LT54Y3BfbWdyLA0KIAkJCQkJ
ICAgIEFNREdQVV9YQ1BfRkxfTk9ORSkgPT0NCi0tDQoyLjI1LjENCg==
