Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3E5C04A95
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 08:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEF710E3D2;
	Thu, 29 Sep 2022 08:47:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA46810E3D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 08:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1cWwB6AzBQjeXQStae/v6Zf+wyDfFIQlGoEi48vQSzpiUWDz3g3PYT4jc+0Blm8sT67wejfhaDqKDy/8/x3+U9wJrAZeiOhoIEz6McQEJGMUZC03dytQaOCR7FyPPsPv5pBWr7dxBkdzwEuF+JeL58SKJxqbXDO2IW6zX5NSh2Cu9TBWJZZ0uwiibj9KhdaAAiY5AMLA5vxFGWp2R/kafnq+VJ9roYboOBbpDc+F+VMV1kyoSSsDu905LHIw35OzBZocpuJ0fBA+RvYWsldF7Sd6MTw+l0f+eVpvdFP/3EBw9iSXcYMmSmK7oml/ZTZIT2LUAn5mIT49l4uj2Snbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1w+/RNQVMuEVk9iz1cvYTXH6zRKfi5MpT535saQdIg=;
 b=JY/13YEDVLe0Rqb6xHJfY++DzUhAJlZyt4+j+NWMQwjRKxQqYtTgfN45RcNsItQafh4EZ9ni12JldpnmYu2tb/OKi3tZgti8ahpoppD19PxmVszxspEQhwza6ybSMgaAluS1cdvYasND0MoN7y1RczWbDrktauFKH1ckbGKsymlWGBBTagUjt3TTRaYnIwfUxie9DXayBIx4xIuvxY8N4sZNtmk0HkXXizD+arpsndmBbR6ZdL7UEtwH/4v/jPvEaBZnZD/YxN6V14O8PUyFcrfG68JkJ6PjfVCBX7bt+S7MG+OetamS5noVtGbXU7bnfDu7LI2mbBqfEsyzOqOvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1w+/RNQVMuEVk9iz1cvYTXH6zRKfi5MpT535saQdIg=;
 b=j28TKa6VmJZMVZhfu3Mx7dAcUPOgbti1MtHaEU2JazAyUjUP+j+jNYu6H3rohb6fN/9i7LB/TlL+aRDMNxwryf/yIY0ZBXVxskYRksNVKsmzmpldcpvKiyasSeU4iCnz5mhqin1uRuStFrsYjWS5TS4n9qhSJOWfagV20gG3dO4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 08:47:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%6]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 08:47:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the memcpy size for ip discovery
 firmware
Thread-Topic: [PATCH] drm/amdgpu: correct the memcpy size for ip discovery
 firmware
Thread-Index: AQHY09grzSRx6YsFU0GJcF9y3XGYvK32GIzA
Date: Thu, 29 Sep 2022 08:47:51 +0000
Message-ID: <BN9PR12MB525721587DBE6ADB93D9838BFC579@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220929074932.10114-1-le.ma@amd.com>
In-Reply-To: <20220929074932.10114-1-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-29T08:47:49Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bbd1093f-f71a-4fe5-a0cc-7586294f6a93;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7682:EE_
x-ms-office365-filtering-correlation-id: 0a234ecf-2c26-4796-e066-08daa1f74b6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ee+Tv62uAXFCLMRHf9EeRq8wf3e8/K0jrsfl3o9xD6iuFNFdQiZkNI4ROpgKf9h50+xdqyhah5YSFv3wxawDz0FMJvd6QHpaNOf5hdcZyWLxNc1eKMHoh6McsTRLCn8wvu3Vk+hfJ2TJcg29Jel+B321Hy4+0yuyusoGKu5Lq4aN5I53r7azBeMm+DGTIM1rzwMlvzHw5m7bHiVtQoY0fSP4UgOCtf1M9+WqlYGbC5u+kq8FBFgeC86317txrAq3G2f19e+Nc7d8iA9sl5LXIRejEbRmNy0qbBab7uNaAxWbftdSTn8p4tVa0/69XeEAPmFHo3MmXW8pACeEI1gKeV8Wio3Gc6JJDe+cf0Xi9q1tZSlDSanrCCbgWpqydZ6XEeKAMS50HrFnybFyQp1YGwE1VpFsntKoa684uflVciA8BuuPJ66/qw2b/rlaGAPkFjCloNZ5AXIkZ+saocGkglbEEa2siY3ZqmK3DOCI3fkgl0tZ3/K5OqIAvRTzi8qx3/GkJflGCsDetgpqBmXTFE0m2ul8qarAJ1MOOdiy16k3z8i8nEyiIkURm3ED2G2lkjSRbMwwuDYwRxkTzFSLBxRq/QFYuBGLq34MSxNAWaD/varGfEIBx4z61Te9+cpCd1nHqEgMGwYbfAD/ilx3CP+lgujo3jO2uBkjZy5SO8BREKj7ynImpzNjoBE5haiUDVXNeY9dZCBMh5lqgfDcwa/dSGKlM3Uzgcar3OHvgbmwlM57ThCkGmGggOgC4+lA62zDPgy/kRzSBQRKVrTLWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(66476007)(26005)(9686003)(66574015)(186003)(38100700002)(478600001)(6506007)(7696005)(316002)(38070700005)(71200400001)(53546011)(83380400001)(66446008)(33656002)(2906002)(110136005)(8936002)(52536014)(122000001)(5660300002)(41300700001)(76116006)(66946007)(4326008)(8676002)(66556008)(64756008)(55016003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejZEdXRxbGp1ZFEvelI0MVBRYnh5NmxNNFlQbmp5ZldST0ljN1QrdXJmY2pG?=
 =?utf-8?B?VUlHWXV3bFFRRWM2MVIrZlhIb08vOGxzd0hjV2dKR2xKVjBmTkRpenBJbS9u?=
 =?utf-8?B?QlZ1THJmOHczL2pIKzNmUlRLV0Rld1NxSnNDNnlQTVliQ1R5QVpvS1FjcjI4?=
 =?utf-8?B?T0tDYm1WVjl0d2Q1NTZoYm0wam9PaWZtbU9ISGdqSXRuWnpNUk1ITEJyK3k2?=
 =?utf-8?B?ZTFsN2RJYTJ0TVVscGxUUEZ2K2g0VkxJcExzend6cXcrQ2h6K1Y0Tk5BZGRC?=
 =?utf-8?B?dXpsNFB4eTRGQ24vL3o5aGUvc2cwakwzTk1nV01nTWFlUUswME9tZ0JYQVo4?=
 =?utf-8?B?SUgwYnJjei9JY3BvMjI1UE9zWkE2NkdaZWcxUUxNTW1iTDE3ZUJ5eWlQc3p5?=
 =?utf-8?B?U1VIVDRoWkZhaGNuTXM4aW1VMTJ3NWZycWJ5YVhYODVwamZoditkdHI1ZG0v?=
 =?utf-8?B?Mmxya0R3Q21KV0JaSVdsTkYwVHJrVWI4eWJUUk0vS2E2TkRaSTdraG9pUFZn?=
 =?utf-8?B?Vmk1dUhURmxCaFpqSnRXY3BhWVRoRUl1aFZwWWhSWlMyQjIrOTJwR2RMODhw?=
 =?utf-8?B?U3JJS1NmVWw3aVFFdjZIZTNIWDNsU01TQnJpamJ0WWwwU04wTWJWbU93UElY?=
 =?utf-8?B?L045SGRBOTdvLzhHS0hUSW5FN1JjMnV5Vnhha1EyMVVMRHcyb1JQZUpjUWxv?=
 =?utf-8?B?NTV6UUs2YS9LUzhjMU0yenJTUG9ZVFNGSGRYZFJEZFlqbEpwbUE4TnBqVDR1?=
 =?utf-8?B?K2JjVGJtMGYyNVpjRHFhVTRKS01OVjErbXNUYkNGSVR6aGVibnlmbmVoNm11?=
 =?utf-8?B?M2lBQmJ1NVJEQVJGS0tBTTBkUkRzTjBZdlcwcEJQLzYzV1RGakRsaHY0S3c3?=
 =?utf-8?B?QVoxelRJT0M5TTNyWEZ1QnB2TmRYSlc4L0ZSdC8xTUpxa0k0OGp3aDZueEJW?=
 =?utf-8?B?dGIwQVQzL3ZTd3daNDRteGtVOHVRellnVE1udVRjMUNFSHY2QjlzTEJaNjBV?=
 =?utf-8?B?N3hhNTA1Q2M2ZW1zYnVCMkVtTDh5Zi83UzduaEF5L3g4MDh3QmRRcVFtOXVP?=
 =?utf-8?B?RVhiQlZha0gwK21YODNOVS9YMGR5aFJJaUlybEFWSHpLQi9UTk84dWF2Y3ZV?=
 =?utf-8?B?d294L2ZOa3lWV1ZkWlUxcU1nVnQ2TTFYYUtrb0tUNktvMDIrRUlQMnA0ZnFl?=
 =?utf-8?B?TGZ4d1dCYzE3KzRrbHljdVpjK2pvT1RLcDhMQTlJRTRhVENzeGwwZlVKcThy?=
 =?utf-8?B?Tkhja0ZPRG54YmNuR1ZGa3FJcnh4eFRoTTZyWFVYa2JpaGhpd2dCbGxSM1Zs?=
 =?utf-8?B?QVFrK1FzS1lYOTc4cVNFMWcrNTRnS0FvMDRERXpSU2xHaVI4bk45SlpTWVgz?=
 =?utf-8?B?dll0ek1Fb0t0UDhCSjlEcGw4bWRZNC93TXR4c01BY1lwNVRzc081WDV4alpB?=
 =?utf-8?B?VXltN09hTDhST0RlYU9qMTh0LzBWZ3pzd0ZubUNWR1kweUNGS0hyL0d0Y21t?=
 =?utf-8?B?TlNuOW9EMExxOGl2RDhEM09Udm84enUzc24xNGFtSVZKaHcxVWEyMGJBT3gr?=
 =?utf-8?B?VWxXMllRMXkraTVvUnZoaFhFeUQ2WnBMbWdiR1BXaVpKemx6djNmWXYxQkJX?=
 =?utf-8?B?dis3bDlldVhxTzFhWVZTbFFHUE9MZmJwcEhkNmlmOGRuS0xJaEZJWGF3V2Zo?=
 =?utf-8?B?N04vTjlRNjllVHEyMXJyY0sxWWh0QjNyVDJRT0pVeVRXaVlMY3NkdW1GUE1Q?=
 =?utf-8?B?bmRzcFZTVDg0UDlnVDM5Yk5tTS9DTWxneVhUOTdob05rUFlrWEZ3U2l3Tk1y?=
 =?utf-8?B?OTVRaXRhcDJBSHdvSnovTVNwRkZESXZQdGZ4TFdEYURMTTMxZVpZYXRSUVFp?=
 =?utf-8?B?a3g3Q3k4MHlKaGxncll0V0JFUlNjYWdyb2duY1JFUlpZQW9TK3R3a1ZxOGha?=
 =?utf-8?B?S2liZGxVV2VOaU5iQ1Nxd2M2dms0Q0wzR3pZSWhrNGFsaTd0N2NSb2lJR1Yv?=
 =?utf-8?B?eGp3bTdDeTFlbUlxVUdNc0ducDgyN0J1Y1pmcGlHYjJsQTVyNE1ydEdhdHhs?=
 =?utf-8?B?aWs4NTBrSCtsY2FJY245NU5XZ3dYUWZtMHMycFc2QTFlcEppNWFadTcvRnNP?=
 =?utf-8?Q?VMKlELzbjYTXEflzDXid2jT7p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a234ecf-2c26-4796-e066-08daa1f74b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 08:47:52.0076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 822cE+Hox4LcFsJo33IXIX/pMHApt3xR49tbLKof3Lj+ulN6B+0PiSNoug8GcPtqPbxg80DJXNiBo/ekRWPvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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
Cc: "Ma, Le" <Le.Ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBIYXdraW5n
IFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIExlIE1hDQpTZW50OiBUaHVyc2RheSwg
U2VwdGVtYmVyIDI5LCAyMDIyIDE1OjUwDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCkNjOiBNYSwgTGUgPExlLk1hQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRn
cHU6IGNvcnJlY3QgdGhlIG1lbWNweSBzaXplIGZvciBpcCBkaXNjb3ZlcnkgZmlybXdhcmUNCg0K
VXNlIGZ3LT5zaXplIGluc3RlYWQgb2YgZGlzY292ZXJ5X3Rtcl9zaXplIGZvciBmYWxsYmFjayBw
YXRoLg0KDQpDaGFuZ2UtSWQ6IEk2MWYxZWM1NTMxNGVhNTk0OGVkM2VmODIxYmVjZmRkNjNkODc2
MjcyDQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4NCkFja2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgfCAyICstDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCmluZGV4IDMwOWQzNTAyNjIyMi4uMGI0ZjRk
MmY4ZDMyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c2NvdmVyeS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292
ZXJ5LmMNCkBAIC0yMzQsNyArMjM0LDcgQEAgc3RhdGljIGludCBhbWRncHVfZGlzY292ZXJ5X3Jl
YWRfYmluYXJ5X2Zyb21fZmlsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWkNCiAJCXJl
dHVybiByOw0KIAl9DQogDQotCW1lbWNweSgodTggKiliaW5hcnksICh1OCAqKWZ3LT5kYXRhLCBh
ZGV2LT5tbWFuLmRpc2NvdmVyeV90bXJfc2l6ZSk7DQorCW1lbWNweSgodTggKiliaW5hcnksICh1
OCAqKWZ3LT5kYXRhLCBmdy0+c2l6ZSk7DQogCXJlbGVhc2VfZmlybXdhcmUoZncpOw0KIA0KIAly
ZXR1cm4gMDsNCi0tIA0KMi4xNy4xDQo=
